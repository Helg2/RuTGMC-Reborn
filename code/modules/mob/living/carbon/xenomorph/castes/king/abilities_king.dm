// ***************************************
// *********** Nightfall
// ***************************************

/datum/action/ability/activable/xeno/nightfall
	name = "Nightfall"
	desc = "Shut down electrical lights for 10 seconds and extinguish flares in nearby range."
	action_icon_state = "nightfall"
	action_icon = 'icons/Xeno/actions/king.dmi'
	cooldown_duration = 45 SECONDS
	ability_cost = 150
	keybinding_signals = list(
		KEYBINDING_NORMAL = COMSIG_XENOABILITY_NIGHTFALL,
	)
	/// How far nightfall will have an effect
	var/range = 12
	/// How long till the lights go on again
	var/duration = 10 SECONDS

/datum/action/ability/activable/xeno/nightfall/on_cooldown_finish()
	to_chat(owner, span_notice("We gather enough mental strength to shut down lights again."))
	return ..()

/datum/action/ability/activable/xeno/nightfall/use_ability()
	playsound(owner, 'sound/magic/nightfall.ogg', 50, 1)
	succeed_activate()
	add_cooldown()
	for(var/atom/light AS in GLOB.nightfall_toggleable_lights)
		if(isnull(light.loc) || (owner.loc.z != light.loc.z) || (get_dist(owner, light) >= range))
			continue
		light.turn_light(null, FALSE, duration, TRUE, TRUE, TRUE)
	for(var/obj/item/explosive/grenade/flare/flare in range(range, owner))
		if(!flare.active)
			continue
		flare.turn_off()

// ***************************************
// *********** Petrify
// ***************************************
#define PETRIFY_RANGE 7
#define PETRIFY_DURATION 6 SECONDS
#define PETRIFY_WINDUP_TIME 2 SECONDS
/datum/action/ability/xeno_action/petrify
	name = "Petrify"
	desc = "After a windup, petrifies all humans looking at you. While petrified humans are immune to damage, but also can't attack."
	action_icon_state = "petrify"
	action_icon = 'icons/Xeno/actions/king.dmi'
	ability_cost = 100
	cooldown_duration = 30 SECONDS
	keybind_flags = ABILITY_KEYBIND_USE_ABILITY
	keybinding_signals = list(
		KEYBINDING_NORMAL = COMSIG_XENOABILITY_PETRIFY,
	)
	///List of mobs currently petrified
	var/list/mob/living/carbon/human/petrified_humans = list()

/datum/action/ability/xeno_action/petrify/clean_action()
	end_effects()
	return ..()

/datum/action/ability/xeno_action/petrify/action_activate()
	var/obj/effect/overlay/eye/eye = new
	owner.vis_contents += eye
	flick("eye_opening", eye)
	playsound(owner, 'sound/effects/petrify_charge.ogg', 50)
	REMOVE_TRAIT(owner, TRAIT_STAGGER_RESISTANT, XENO_TRAIT)
	ADD_TRAIT(owner, TRAIT_IMMOBILE, PETRIFY_ABILITY_TRAIT)

	if(!do_after(owner, PETRIFY_WINDUP_TIME, IGNORE_HELD_ITEM, owner, BUSY_ICON_DANGER, extra_checks = CALLBACK(src, PROC_REF(can_use_action), FALSE, ABILITY_USE_BUSY)))
		flick("eye_closing", eye)
		addtimer(CALLBACK(src, PROC_REF(remove_eye), eye), 7, TIMER_CLIENT_TIME)
		finish_charging()
		add_cooldown(10 SECONDS)
		return fail_activate()

	finish_charging()
	playsound(owner, 'sound/effects/petrify_activate.ogg', 50)
	for(var/mob/living/carbon/human/human in view(PETRIFY_RANGE, owner.loc))
		if(is_blind(human))
			continue

		human.notransform = TRUE
		human.status_flags |= GODMODE
		ADD_TRAIT(human, TRAIT_HANDS_BLOCKED, REF(src))
		human.move_resist = MOVE_FORCE_OVERPOWERING
		human.unset_interaction()
		human.add_atom_colour(COLOR_GRAY, TEMPORARY_COLOR_PRIORITY)
		human.log_message("has been petrified by [owner] for [PETRIFY_DURATION] ticks", LOG_ATTACK, color="pink")

		var/image/stone_overlay = image('icons/effects/effects.dmi', null, "petrified_overlay")
		stone_overlay.filters += filter(arglist(alpha_mask_filter(render_source="*[REF(human)]",flags=MASK_INVERSE)))

		var/mutable_appearance/mask = mutable_appearance()
		mask.appearance = human.appearance
		mask.render_target = "*[REF(human)]"
		mask.alpha = 125
		stone_overlay.overlays += mask

		human.overlays += stone_overlay
		petrified_humans[human] = stone_overlay

	if(!length(petrified_humans))
		flick("eye_closing", eye)
		addtimer(CALLBACK(src, PROC_REF(remove_eye), eye), 7, TIMER_CLIENT_TIME)
		return

	addtimer(CALLBACK(src, PROC_REF(remove_eye), eye), 10, TIMER_CLIENT_TIME)
	flick("eye_explode", eye)
	addtimer(CALLBACK(src, PROC_REF(end_effects)), PETRIFY_DURATION)
	add_cooldown()
	succeed_activate()

///cleans up when the charge up is finished or interrupted
/datum/action/ability/xeno_action/petrify/proc/finish_charging()
	REMOVE_TRAIT(owner, TRAIT_IMMOBILE, PETRIFY_ABILITY_TRAIT)
	if(!isxeno(owner))
		return
	if(xeno_owner.xeno_caste.caste_flags & CASTE_STAGGER_RESISTANT)
		ADD_TRAIT(owner, TRAIT_STAGGER_RESISTANT, XENO_TRAIT)

///ends all combat-relazted effects
/datum/action/ability/xeno_action/petrify/proc/end_effects()
	for(var/mob/living/carbon/human/human AS in petrified_humans)
		human.notransform = FALSE
		human.status_flags &= ~GODMODE
		REMOVE_TRAIT(human, TRAIT_HANDS_BLOCKED, REF(src))
		human.move_resist = initial(human.move_resist)
		human.remove_atom_colour(TEMPORARY_COLOR_PRIORITY, COLOR_GRAY)
		human.overlays -= petrified_humans[human]
	petrified_humans.Cut()

///callback for removing the eye from viscontents
/datum/action/ability/xeno_action/petrify/proc/remove_eye(obj/effect/eye)
	owner.vis_contents -= eye

// ***************************************
// *********** Off-Guard
// ***************************************
#define OFF_GUARD_RANGE 8
/datum/action/ability/activable/xeno/off_guard
	name = "Off-guard"
	desc = "Muddles the mind of an enemy, making it harder for them to focus their aim for a while."
	action_icon_state = "off_guard"
	action_icon = 'icons/Xeno/actions/king.dmi'
	ability_cost = 100
	cooldown_duration = 20 SECONDS
	target_flags = ABILITY_MOB_TARGET
	keybinding_signals = list(
		KEYBINDING_NORMAL = COMSIG_XENOABILITY_OFFGUARD,
	)

/datum/action/ability/activable/xeno/off_guard/can_use_ability(atom/A, silent = FALSE, override_flags)
	. = ..()
	if(!.)
		return
	if(!ishuman(A))
		if(!silent)
			A.balloon_alert(owner, "not human")
		return FALSE
	if(!line_of_sight(owner, A, 9))
		if(!silent)
			owner.balloon_alert(owner, "Out of sight!")
		return FALSE
	if((A.z != owner.z) || get_dist(owner, A) > OFF_GUARD_RANGE)
		if(!silent)
			A.balloon_alert(owner, "too far")
		return FALSE
	var/mob/living/carbon/human/target = A
	if(target.stat == DEAD)
		if(!silent)
			target.balloon_alert(owner, "already dead")
		return FALSE

/datum/action/ability/activable/xeno/off_guard/use_ability(atom/target)
	var/mob/living/carbon/human/human_target = target
	human_target.apply_status_effect(STATUS_EFFECT_GUN_SKILL_ACCURACY_DEBUFF, 8 SECONDS)
	human_target.apply_status_effect(STATUS_EFFECT_GUN_SKILL_SCATTER_DEBUFF, 8 SECONDS)
	human_target.apply_status_effect(/datum/status_effect/incapacitating/offguard_slowdown, 8 SECONDS)
	human_target.log_message("has been off-guarded by [owner]", LOG_ATTACK, color="pink")
	human_target.balloon_alert_to_viewers("confused")
	playsound(human_target, 'sound/effects/off_guard_ability.ogg', 50)

	add_cooldown()
	succeed_activate()

// ***************************************
// *********** Psychic roar
// ***************************************

#define SHATTERING_ROAR_RANGE 10
#define SHATTERING_ROAR_ANGLE 60
#define SHATTERING_ROAR_SPEED 2
#define SHATTERING_ROAR_DAMAGE 40
#define SHATTERING_ROAR_CHARGE_TIME 1.2 SECONDS

/datum/action/ability/activable/xeno/shattering_roar
	name = "Shattering roar"
	desc = "Unleash a mighty psychic roar, knocking down any foes in your path and weakening them."
	action_icon_state = "shattering_roar"
	action_icon = 'icons/Xeno/actions/king.dmi'
	ability_cost = 225
	cooldown_duration = 45 SECONDS
	target_flags = ABILITY_TURF_TARGET
	keybinding_signals = list(
		KEYBINDING_NORMAL = COMSIG_XENOABILITY_SHATTERING_ROAR,
	)
	/// Tracks victims to make sure we only hit them once
	var/list/victims_hit = list()

/datum/action/ability/activable/xeno/shattering_roar/use_ability(atom/target)
	if(!target)
		return
	owner.dir = get_cardinal_dir(owner, target)

	playsound(owner, 'sound/voice/alien/king_roar.ogg', 70, sound_range = 20)
	if(istype(xeno_owner))
		xeno_owner.icon_state = "King Screeching"
	REMOVE_TRAIT(owner, TRAIT_STAGGER_RESISTANT, XENO_TRAIT) //Vulnerable while charging up
	ADD_TRAIT(owner, TRAIT_IMMOBILE, SHATTERING_ROAR_ABILITY_TRAIT)

	if(!do_after(owner, SHATTERING_ROAR_CHARGE_TIME, NONE, owner, BUSY_ICON_DANGER, extra_checks = CALLBACK(src, PROC_REF(can_use_action), FALSE, ABILITY_USE_BUSY)))
		owner.balloon_alert(owner, "interrupted!")
		finish_charging()
		add_cooldown(10 SECONDS)
		return fail_activate()

	finish_charging()
	playsound(owner, 'sound/voice/alien/xenos_roaring.ogg', 90, sound_range = 30)
	for(var/mob/living/carbon/human/human_victim AS in GLOB.humans_by_zlevel["[owner.z]"])
		if(get_dist(human_victim, owner) > 9)
			continue
		shake_camera(human_victim, 2 SECONDS, 1)

	var/source = get_turf(owner)
	var/dir_to_target = Get_Angle(source, target)
	var/list/turf/turfs_to_attack = generate_cone(source, SHATTERING_ROAR_RANGE, 1, SHATTERING_ROAR_ANGLE, dir_to_target, pass_flags_checked = PASS_AIR|PASS_GLASS)
	execute_attack(1, turfs_to_attack, SHATTERING_ROAR_RANGE, target, source)

	add_cooldown()
	succeed_activate()

///Carries out the attack iteratively based on distance from source
/datum/action/ability/activable/xeno/shattering_roar/proc/execute_attack(iteration, list/turf/turfs_to_attack, range, target, turf/source)
	if(iteration > range)
		victims_hit.Cut()
		return

	for(var/turf/turf AS in turfs_to_attack)
		if(get_dist(turf, source) == iteration || get_dist(turf, source) == iteration - 1)
			attack_turf(turf, LERP(1, 0.3, iteration / SHATTERING_ROAR_RANGE))

	iteration++
	addtimer(CALLBACK(src, PROC_REF(execute_attack), iteration, turfs_to_attack, range, target, source), SHATTERING_ROAR_SPEED)

///Applies attack effects to everything relevant on a given turf
/datum/action/ability/activable/xeno/shattering_roar/proc/attack_turf(turf/turf_victim, severity)
	new /obj/effect/temp_visual/shattering_roar(turf_victim)
	for(var/victim in turf_victim)
		if(victim in victims_hit)
			continue
		victims_hit += victim
		if(iscarbon(victim))
			var/mob/living/carbon/carbon_victim = victim
			if(carbon_victim.stat == DEAD || isxeno(carbon_victim))
				continue
			carbon_victim.apply_damage(SHATTERING_ROAR_DAMAGE * severity, BRUTE, blocked = MELEE)
			carbon_victim.apply_damage(SHATTERING_ROAR_DAMAGE * severity, STAMINA)
			carbon_victim.adjust_stagger(6 SECONDS * severity)
			carbon_victim.add_slowdown(6 * severity)
			shake_camera(carbon_victim, 3 * severity, 3 * severity)
			carbon_victim.apply_effect(1 SECONDS, EFFECT_PARALYZE)
			to_chat(carbon_victim, "You are smashed to the ground!")
		else if(isvehicle(victim) || ishitbox(victim))
			var/obj/obj_victim = victim
			var/hitbox_penalty = 0
			if(ishitbox(victim))
				hitbox_penalty = 20
			obj_victim.take_damage((SHATTERING_ROAR_DAMAGE - hitbox_penalty) * 5 * severity, BRUTE, MELEE)
		else if(istype(victim, /obj/structure/window))
			var/obj/structure/window/window_victim = victim
			if(window_victim.damageable)
				window_victim.ex_act(EXPLODE_DEVASTATE)

///cleans up when the charge up is finished or interrupted
/datum/action/ability/activable/xeno/shattering_roar/proc/finish_charging()
	owner.update_icons()
	REMOVE_TRAIT(owner, TRAIT_IMMOBILE, SHATTERING_ROAR_ABILITY_TRAIT)
	if(!isxeno(owner))
		return
	if(xeno_owner.xeno_caste.caste_flags & CASTE_STAGGER_RESISTANT)
		ADD_TRAIT(owner, TRAIT_STAGGER_RESISTANT, XENO_TRAIT)

/obj/effect/temp_visual/shattering_roar
	name = "shattering_roar"
	icon = 'icons/effects/effects.dmi'
	duration = 4

/obj/effect/temp_visual/shattering_roar/Initialize(mapload)
	. = ..()
	flick("smash", src)

// ***************************************
// *********** Zero form energy beam
// ***************************************
#define ZEROFORM_BEAM_RANGE 10
#define ZEROFORM_CHARGE_TIME 2 SECONDS
#define ZEROFORM_TICK_RATE 0.3 SECONDS
/datum/action/ability/xeno_action/zero_form_beam
	name = "Zero-Form Energy Beam"
	desc = "After a windup, concentrates the hives energy into a forward-facing beam that pierces everything, hurting living beings and vehicles."
	action_icon_state = "zero_form_beam"
	action_icon = 'icons/Xeno/actions/king.dmi'
	ability_cost = 25
	cooldown_duration = 10 SECONDS
	keybind_flags = ABILITY_KEYBIND_USE_ABILITY
	keybinding_signals = list(
		KEYBINDING_NORMAL = COMSIG_XENOABILITY_ZEROFORMBEAM,
	)
	///list of turfs we are hitting while shooting our beam
	var/list/turf/targets
	///ref to beam that is currently active
	var/datum/beam/beam
	///particle holder for the particle visual effects
	var/obj/effect/abstract/particle_holder/particles
	// sound loop for the looping sound lazor beam
	var/datum/looping_sound/zero_form_beam/sound_loop
	///ref to looping timer for the fire loop
	var/timer_ref

/datum/action/ability/xeno_action/zero_form_beam/Destroy()
	QDEL_NULL(sound_loop)
	return ..()

/datum/action/ability/xeno_action/zero_form_beam/New(Target)
	. = ..()
	sound_loop = new

/obj/effect/ebeam/zeroform/Initialize(mapload)
	. = ..()
	alpha = 0
	animate(src, alpha = 255, time = ZEROFORM_CHARGE_TIME)

/datum/action/ability/xeno_action/zero_form_beam/can_use_action(silent, override_flags)
	. = ..()
	if(!.)
		return
	if(is_ground_level(owner.z) && CHECK_BITFIELD(SSticker.mode?.round_type_flags, MODE_ALLOW_XENO_QUICKBUILD) && SSresinshaping.active) // RUTGMC EDIT, tad lasering
		if(!silent)
			owner.balloon_alert(owner, "too early")
		return FALSE

/datum/action/ability/xeno_action/zero_form_beam/action_activate()
	if(timer_ref)
		stop_beaming()
		return

	var/turf/check_turf = get_step(owner, owner.dir)
	LAZYINITLIST(targets)
	while(check_turf && length(targets) < ZEROFORM_BEAM_RANGE)
		targets += check_turf
		check_turf = get_step(check_turf, owner.dir)
	if(!LAZYLEN(targets))
		return

	var/particles_type
	switch(owner.dir)
		if(WEST)
			particles_type = /particles/zero_form/west
		if(EAST)
			particles_type = /particles/zero_form/east
		if(NORTH)
			particles_type = /particles/zero_form/north
		if(SOUTH)
			particles_type = /particles/zero_form/south
		else
			particles_type = /particles/zero_form
	particles = new(owner, particles_type)
	beam = owner.loc.beam(targets[length(targets)], "plasmabeam", beam_type = /obj/effect/ebeam/zeroform)
	playsound(owner, 'sound/effects/alien/king_beam_charge.ogg', 80)
	REMOVE_TRAIT(owner, TRAIT_STAGGER_RESISTANT, XENO_TRAIT)
	ADD_TRAIT(owner, TRAIT_IMMOBILE, ZERO_FORM_BEAM_ABILITY_TRAIT)

	if(!do_after(owner, ZEROFORM_CHARGE_TIME, IGNORE_HELD_ITEM, owner, BUSY_ICON_DANGER, extra_checks = CALLBACK(src, PROC_REF(can_use_action), FALSE, ABILITY_USE_BUSY)))
		QDEL_NULL(beam)
		QDEL_NULL(particles)
		targets = null
		REMOVE_TRAIT(owner, TRAIT_IMMOBILE, ZERO_FORM_BEAM_ABILITY_TRAIT)
		add_cooldown(10 SECONDS)
		return fail_activate()

	REMOVE_TRAIT(owner, TRAIT_IMMOBILE, ZERO_FORM_BEAM_ABILITY_TRAIT)
	sound_loop.start(owner)
	RegisterSignals(owner, list(COMSIG_MOVABLE_MOVED, COMSIG_ATOM_DIR_CHANGE), PROC_REF(stop_beaming))
	if(istype(xeno_owner))
		xeno_owner.icon_state = "King Screeching"
	execute_attack()

/// recursive proc for firing the actual beam
/datum/action/ability/xeno_action/zero_form_beam/proc/execute_attack()
	if(!can_use_action(TRUE))
		stop_beaming()
		return
	succeed_activate()
	for(var/turf/target AS in targets)
		for(var/victim in target)
			if(ishuman(victim))
				var/mob/living/carbon/human/human_victim = victim
				if(human_victim.stat == DEAD)
					continue
				human_victim.take_overall_damage(15, BURN, updating_health = TRUE)
				human_victim.flash_weak_pain()
				animation_flash_color(human_victim)
			else if(isvehicle(victim) || ishitbox(victim))
				var/obj/obj_victim = victim
				var/damage_mult = 1
				if(ismecha(obj_victim))
					damage_mult = 5
				obj_victim.take_damage(15 * damage_mult, BURN, ENERGY, armour_penetration = 60)
	timer_ref = addtimer(CALLBACK(src, PROC_REF(execute_attack)), ZEROFORM_TICK_RATE, TIMER_STOPPABLE)

///ends and cleans up beam
/datum/action/ability/xeno_action/zero_form_beam/proc/stop_beaming()
	SIGNAL_HANDLER
	UnregisterSignal(owner, list(COMSIG_MOVABLE_MOVED, COMSIG_ATOM_DIR_CHANGE))
	sound_loop.stop(owner)
	QDEL_NULL(beam)
	particles.particles.spawning = 0
	QDEL_NULL_IN(src, particles, 40)
	deltimer(timer_ref)
	timer_ref = null
	targets = null

	owner.update_icons()
	add_cooldown()

	if(!isxeno(owner))
		return
	if(xeno_owner.xeno_caste.caste_flags & CASTE_STAGGER_RESISTANT)
		ADD_TRAIT(owner, TRAIT_STAGGER_RESISTANT, XENO_TRAIT)

/particles/zero_form
	width = 400
	height = 400
	spawning = 5

	fadein = generator(GEN_NUM, 5, 10, NORMAL_RAND)
	lifespan = generator(GEN_NUM, 10, 20, NORMAL_RAND)
	fade = generator(GEN_NUM, 5, 10, NORMAL_RAND)

	gradient = list(1, "#C3B1E1", 2, "#800080", "loop")
	color = 0.3

/particles/zero_form/west
	gravity = list(-1, 0)
	position = generator(GEN_VECTOR, list(16, 18), list(16, -18), SQUARE_RAND)

/particles/zero_form/east
	gravity = list(1, 0)
	position = generator(GEN_VECTOR, list(16, 18), list(16, -18), SQUARE_RAND)

/particles/zero_form/north
	gravity = list(0, 1)
	position = generator(GEN_VECTOR, list(-2, 16), list(34, 16), SQUARE_RAND)

/particles/zero_form/south
	gravity = list(0, -1)
	position = generator(GEN_VECTOR, list(-2, 16), list(34, 16), SQUARE_RAND)

// ***************************************
// *********** Psychic Summon
// ***************************************
/datum/action/ability/xeno_action/psychic_summon
	name = "Psychic Summon"
	desc = "Summons all xenos in a hive to the caller's location, uses all plasma to activate."
	action_icon_state = "stomp"
	action_icon = 'icons/Xeno/actions/crusher.dmi'
	ability_cost = 900
	cooldown_duration = 10 MINUTES
	keybind_flags = ABILITY_KEYBIND_USE_ABILITY
	keybinding_signals = list(
		KEYBINDING_NORMAL = COMSIG_XENOABILITY_HIVE_SUMMON,
	)

/datum/action/ability/activable/xeno/psychic_summon/on_cooldown_finish()
	to_chat(owner, span_warning("The hives power swells. We may summon our sisters again."))
	return ..()

/datum/action/ability/xeno_action/psychic_summon/can_use_action(silent, override_flags)
	. = ..()
	if(!.)
		return
	if(length(xeno_owner.hive.get_all_xenos()) <= 1)
		if(!silent)
			owner.balloon_alert(owner, "noone to call")
		return FALSE

GLOBAL_LIST_EMPTY(active_summons)

/datum/action/ability/xeno_action/psychic_summon/action_activate()

	log_game("[key_name(owner)] has begun summoning hive in [AREACOORD(owner)]")
	xeno_message("King: \The [owner] has begun a psychic summon in <b>[get_area(owner)]</b>!", hivenumber = xeno_owner.hivenumber)
	var/list/allxenos = xeno_owner.hive.get_all_xenos()
	for(var/mob/living/carbon/xenomorph/sister AS in allxenos)
		if(sister.z != owner.z)
			continue
		sister.add_filter("summonoutline", 2, outline_filter(1, COLOR_VIOLET))

	GLOB.active_summons += xeno_owner
	request_admins()
	if(!do_after(xeno_owner, 10 SECONDS, IGNORE_HELD_ITEM, xeno_owner, BUSY_ICON_HOSTILE, extra_checks = CALLBACK(src, PROC_REF(is_active_summon))))
		add_cooldown(5 SECONDS)
		for(var/mob/living/carbon/xenomorph/sister AS in allxenos)
			sister.remove_filter("summonoutline")
		return fail_activate()

	allxenos = xeno_owner.hive.get_all_xenos() //refresh the list to account for any changes during the channel
	var/sisters_teleported = 0
	for(var/mob/living/carbon/xenomorph/sister AS in allxenos)
		sister.remove_filter("summonoutline")
		if(HAS_TRAIT(sister, TRAIT_LEASHED))
			continue
		if(sister.z == owner.z)
			sister.forceMove(get_turf(xeno_owner))
			sisters_teleported ++

	log_game("[key_name(owner)] has summoned hive ([sisters_teleported] Xenos) in [AREACOORD(owner)]")
	xeno_owner.emote("roar")

	add_cooldown()
	succeed_activate()

///Sends a message to admins, prompting them if they want to cancel a psychic summon
/datum/action/ability/xeno_action/psychic_summon/proc/request_admins()
	var/canceltext = "[xeno_owner] is using [name] at [AREACOORD(xeno_owner)] [ADMIN_TPMONTY(xeno_owner)] <a href='byond://?_src_=holder;[HrefToken(TRUE)];cancelsummon=[10 SECONDS]'>\[CANCEL SUMMON\]</a>"
	message_admins("[span_prefix("PSYCHIC SUMMON:")] <span class='message linkify'> [canceltext]</span>")
	log_game("psychic summon started by [xeno_owner] at [AREACOORD(xeno_owner)], timerid to cancel: [10 SECONDS]")
	notify_ghosts("<b>[xeno_owner]</b> has begun to summon at [AREACOORD(xeno_owner)]!", action = NOTIFY_JUMP)

///Checks if our summon was cancelled
/datum/action/ability/xeno_action/psychic_summon/proc/is_active_summon()
	if(!(xeno_owner in GLOB.active_summons))
		return FALSE
	return TRUE

/datum/action/ability/xeno_action/psychic_summon/succeed_activate()
	. = ..()
	GLOB.active_summons -= xeno_owner //Remove ourselves from the list once we have completed our summon
