/obj/proc/take_damage(damage_amount, damage_type = BRUTE, damage_flag = null, effects = TRUE, attack_dir, armour_penetration = 0, mob/living/blame_mob)
	if(QDELETED(src))
		CRASH("[src] taking damage after deletion")
	if(!damage_amount)
		return
	if(effects)
		play_attack_sound(damage_amount, damage_type, damage_flag)
	if((resistance_flags & INDESTRUCTIBLE) || obj_integrity <= 0)
		return

	if(damage_flag)
		damage_amount = round(modify_by_armor(damage_amount, damage_flag, armour_penetration), DAMAGE_PRECISION)
	if(damage_amount < DAMAGE_PRECISION)
		return
	. = damage_amount
	obj_integrity = max(obj_integrity - damage_amount, 0)
	update_icon()

	//BREAKING FIRST
	if(integrity_failure && obj_integrity <= integrity_failure)
		obj_break(damage_flag)

	//DESTROYING SECOND
	if(obj_integrity <= 0)
		if(damage_flag == BOMB)
			on_explosion_destruction(damage_amount, attack_dir)
		obj_destruction(damage_amount, damage_type, damage_flag, blame_mob)

/obj/proc/on_explosion_destruction(severity, direction)
	return

///Increase obj_integrity and record it to the repairer's stats
/obj/proc/repair_damage(repair_amount, mob/user)
	repair_amount = min(repair_amount, max_integrity - obj_integrity)
	if(user?.client)
		var/datum/personal_statistics/personal_statistics = GLOB.personal_statistics_list[user.ckey]
		personal_statistics.integrity_repaired += repair_amount
		personal_statistics.times_repaired++
	obj_integrity += repair_amount

///the sound played when the obj is damaged.
/obj/proc/play_attack_sound(damage_amount, damage_type = BRUTE, damage_flag = 0)
	if(hit_sound)
		playsound(loc, hit_sound, 40, 1)
		return

	switch(damage_type)
		if(BRUTE)
			if(damage_amount)
				playsound(loc, 'sound/weapons/smash.ogg', 25, 1)
			else
				playsound(loc, 'sound/weapons/tap.ogg', 25, 1)
		if(BURN)
			playsound(loc, 'sound/items/welder.ogg', 25, 1)

/obj/ex_act(severity, direction)
	if(CHECK_BITFIELD(resistance_flags, INDESTRUCTIBLE))
		return
	. = ..() //contents explosion
	if(QDELETED(src))
		return
	take_damage(severity, BRUTE, BOMB, FALSE, direction)

/obj/lava_act()
	if(resistance_flags & INDESTRUCTIBLE)
		return FALSE
	if(!take_damage(50, BURN, FIRE))
		return FALSE
	if(QDELETED(src))
		return FALSE
	fire_act(LAVA_BURN_LEVEL, FLAME_COLOR_RED)
	return TRUE

/obj/hitby(atom/movable/AM, speed = 5)
	. = ..()
	if(!.)
		return
	if(!anchored && (move_resist < MOVE_FORCE_STRONG))
		step(src, AM.dir)
	visible_message(span_warning("[src] was hit by [AM]."), visible_message_flags = COMBAT_MESSAGE)
	var/tforce = 0
	if(ismob(AM))
		tforce = 40
	else if(isobj(AM))
		var/obj/item/I = AM
		tforce = I.throwforce
	take_damage(tforce, BRUTE, MELEE, 1, get_dir(src, AM))


/obj/bullet_act(obj/projectile/proj)
	if(istype(proj.ammo, /datum/ammo/xeno) && !(resistance_flags & XENO_DAMAGEABLE))
		return
	. = ..()
	if(proj.damage < 1)
		return
	if(proj.damage > 30)
		visible_message(span_warning("\the [src] is damaged by \the [proj]!"), visible_message_flags = COMBAT_MESSAGE)
	take_damage(proj.damage, proj.ammo.damage_type, proj.ammo.armor_type, 0, REVERSE_DIR(proj.dir), proj.ammo.penetration, isliving(proj.firer) ? proj.firer : null)

/obj/proc/attack_generic(mob/user, damage_amount = 0, damage_type = BRUTE, damage_flag = MELEE, effects = TRUE, armor_penetration = 0) //used by attack_alien, attack_animal, and attack_slime
	user.do_attack_animation(src, ATTACK_EFFECT_SMASH)
	user.changeNext_move(CLICK_CD_MELEE)
	return take_damage(damage_amount, damage_type, damage_flag, effects, get_dir(src, user), armor_penetration)

/obj/attack_animal(mob/living/simple_animal/M)
	if(!M.melee_damage && !M.obj_damage)
		M.emote("custom", message = "[M.friendly] [src].")
		return 0
	else
		var/play_soundeffect = 1
		if(M.obj_damage)
			. = attack_generic(M, M.obj_damage, M.melee_damage_type, MELEE, play_soundeffect, M.armour_penetration)
		else
			. = attack_generic(M, M.melee_damage, M.melee_damage_type, MELEE, play_soundeffect, M.armour_penetration)
		if(. && !play_soundeffect)
			playsound(loc, 'sound/effects/meteorimpact.ogg', 100, 1)

/obj/attack_alien(mob/living/carbon/xenomorph/xeno_attacker, damage_amount = xeno_attacker.xeno_caste.melee_damage, damage_type = BRUTE, damage_flag = MELEE, effects = TRUE, armor_penetration = 0, isrightclick = FALSE)
	// SHOULD_CALL_PARENT(TRUE) // TODO: fix this
	if(xeno_attacker.status_flags & INCORPOREAL) //Ghosts can't attack machines
		return FALSE
	SEND_SIGNAL(xeno_attacker, COMSIG_XENOMORPH_ATTACK_OBJ, src)
	if(SEND_SIGNAL(src, COMSIG_OBJ_ATTACK_ALIEN, xeno_attacker) & COMPONENT_NO_ATTACK_ALIEN)
		return FALSE
	if(!(resistance_flags & XENO_DAMAGEABLE))
		to_chat(xeno_attacker, span_warning("We stare at \the [src] cluelessly."))
		return FALSE
	if(effects)
		xeno_attacker.visible_message(span_danger("[xeno_attacker] has slashed [src]!"),
		span_danger("We slash [src]!"))
		xeno_attacker.do_attack_animation(src, ATTACK_EFFECT_CLAW)
		playsound(loc, SFX_ALIEN_CLAW_METAL, 25)
	attack_generic(xeno_attacker, damage_amount, damage_type, damage_flag, effects, armor_penetration)
	return TRUE

/obj/attack_larva(mob/living/carbon/xenomorph/larva/larva_attacker)
	larva_attacker.visible_message(span_danger("[larva_attacker] nudges its head against [src]."), \
	span_danger("You nudge your head against [src]."))

///the obj is deconstructed into pieces, whether through careful disassembly or when destroyed.
/obj/proc/deconstruct(disassembled = TRUE, mob/living/blame_mob)
	SHOULD_CALL_PARENT(TRUE)
	SEND_SIGNAL(src, COMSIG_OBJ_DECONSTRUCT, disassembled)
	qdel(src)

///called after the obj takes damage and integrity is below integrity_failure level
/obj/proc/obj_break(damage_flag)
	return

///what happens when the obj's integrity reaches zero.
/obj/proc/obj_destruction(damage_amount, damage_type, damage_flag, mob/living/blame_mob)
	SHOULD_CALL_PARENT(TRUE)
	if(destroy_sound)
		playsound(loc, destroy_sound, 35, 1)
	deconstruct(FALSE, blame_mob)

///changes max_integrity while retaining current health percentage, returns TRUE if the obj got broken.
/obj/proc/modify_max_integrity(new_max, can_break = TRUE, damage_type = BRUTE, new_failure_integrity = null)
	var/current_integrity = obj_integrity
	var/current_max = max_integrity

	if(current_integrity != 0 && current_max != 0)
		var/percentage = current_integrity / current_max
		current_integrity = max(1, percentage * new_max)	//don't destroy it as a result
		obj_integrity = current_integrity

	max_integrity = new_max

	if(new_failure_integrity != null)
		integrity_failure = new_failure_integrity

	if(can_break && integrity_failure && current_integrity <= integrity_failure)
		obj_break(damage_type)
		return TRUE
	return FALSE

///returns how much the object blocks an explosion. Used by subtypes.
/obj/proc/GetExplosionBlock(explosion_dir)
	CRASH("Unimplemented GetExplosionBlock()")

/obj/pre_crush_act(mob/living/carbon/xenomorph/charger, datum/action/ability/xeno_action/ready_charge/charge_datum)
	if((resistance_flags & (INDESTRUCTIBLE|CRUSHER_IMMUNE)) || charger.is_charging < CHARGE_ON)
		charge_datum.do_stop_momentum()
		return PRECRUSH_STOPPED
	if(anchored)
		if(atom_flags & ON_BORDER)
			if(dir == REVERSE_DIR(charger.dir))
				. = (CHARGE_SPEED(charge_datum) * 120) //Damage to inflict.
				charge_datum.speed_down(3)
				return
			else
				. = (CHARGE_SPEED(charge_datum) * 240)
				charge_datum.speed_down(1)
				return
		else
			. = (CHARGE_SPEED(charge_datum) * 320)
			charge_datum.speed_down(2)
			return

	for(var/m in buckled_mobs)
		unbuckle_mob(m)
	return (CHARGE_SPEED(charge_datum) * 50) //Damage to inflict.

/obj/post_crush_act(mob/living/carbon/xenomorph/charger, datum/action/ability/xeno_action/ready_charge/charge_datum)
	if(anchored) //Did it manage to stop it?
		charger.visible_message(span_danger("[charger] rams into [src] and skids to a halt!"),
		span_xenowarning("We ram into [src] and skid to a halt!"))
		if(charger.is_charging > CHARGE_OFF)
			charge_datum.do_stop_momentum(FALSE)
		return PRECRUSH_STOPPED
	var/fling_dir = pick(GLOB.cardinals - ((charger.dir & (NORTH|SOUTH)) ? list(NORTH, SOUTH) : list(EAST, WEST))) //Fling them somewhere not behind nor ahead of the charger.
	var/fling_dist = min(round(CHARGE_SPEED(charge_datum)) + 1, 3)
	if(!step(src, fling_dir) && density)
		charge_datum.do_stop_momentum(FALSE) //Failed to be tossed away and returned, more powerful than ever, to block the charger's path.
		charger.visible_message(span_danger("[charger] rams into [src] and skids to a halt!"),
			span_xenowarning("We ram into [src] and skid to a halt!"))
		return PRECRUSH_STOPPED
	if(--fling_dist)
		for(var/i in 1 to fling_dist)
			if(!step(src, fling_dir))
				break
	charger.visible_message("[span_warning("[charger] knocks [src] aside.")]!",
	span_xenowarning("We knock [src] aside.")) //Canisters, crates etc. go flying.
	charge_datum.speed_down(2) //Lose two turfs worth of speed.
	return PRECRUSH_PLOWED

/obj/proc/crushed_special_behavior()
	return NONE
