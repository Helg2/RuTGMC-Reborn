/obj/structure
	icon = 'icons/obj/structures/structures.dmi'
	obj_flags = CAN_BE_HIT
	anchored = TRUE
	allow_pass_flags = PASSABLE
	destroy_sound = 'sound/effects/meteorimpact.ogg'
	var/climbable = FALSE
	var/climb_delay = 50
	var/barrier_flags = NONE
	/// Similar to machinery's stat BROKEN
	var/broken = FALSE

/obj/structure/proc/handle_barrier_chance(mob/living/M)
	return FALSE

/obj/structure/ex_act(severity, direction)
	if(CHECK_BITFIELD(resistance_flags, INDESTRUCTIBLE))
		return
	take_damage(severity, BRUTE, BOMB, attack_dir = direction)

/obj/structure/Initialize(mapload)
	. = ..()
	if(climbable)
		verbs += /obj/structure/proc/climb_on
	if(smoothing_flags & (SMOOTH_CORNERS|SMOOTH_BITMASK))
		QUEUE_SMOOTH(src)
		QUEUE_SMOOTH_NEIGHBORS(src)
		icon_state = ""
		if(smoothing_flags & SMOOTH_CORNERS)
			icon_state = ""

/obj/structure/proc/climb_on()
	set name = "Climb structure"
	set desc = "Climbs onto a structure."
	set category = "IC.Mob"
	set src in oview(1)

	do_climb(usr)

/obj/structure/CtrlClick(mob/living/carbon/user)
	. = ..()
	INVOKE_ASYNC(src, PROC_REF(do_climb), user)

/obj/structure/MouseDrop_T(mob/target, mob/user)
	. = ..()
	var/mob/living/H = user
	if(!istype(H) || target != user) //No making other people climb onto tables.
		return

	do_climb(target)

///Checks to see if a mob can climb onto, or over this object
/obj/structure/proc/can_climb(mob/living/user)
	if(!climbable || !can_interact(user))
		return

	var/turf/destination_turf = loc
	var/turf/user_turf = get_turf(user)
	if(!istype(destination_turf) || !istype(user_turf))
		return
	if(!user.Adjacent(src))
		return

	if((atom_flags & ON_BORDER))
		if(user_turf != destination_turf && user_turf != get_step(destination_turf, dir))
			to_chat(user, span_warning("You need to be up against [src] to leap over."))
			return
		if(user_turf == destination_turf)
			destination_turf = get_step(destination_turf, dir) //we're moving from the objects turf to the one its facing

	if(destination_turf.density)
		return

	for(var/obj/object in destination_turf.contents)
		if(isstructure(object))
			var/obj/structure/structure = object
			if(structure.allow_pass_flags & PASS_WALKOVER)
				continue
		if(object.density && (!(object.atom_flags & ON_BORDER) || object.dir & get_dir(src,user)))
			to_chat(user, span_warning("There's \a [object.name] in the way."))
			return

	for(var/obj/object in user_turf.contents)
		if(isstructure(object))
			var/obj/structure/structure = object
			if(structure.allow_pass_flags & PASS_WALKOVER)
				continue
		if(object.density && (object.atom_flags & ON_BORDER) && object.dir & get_dir(user, src))
			to_chat(user, span_warning("There's \a [object.name] in the way."))
			return

	return destination_turf

///Attempts to climb onto, or past an object
/obj/structure/proc/do_climb(mob/living/user)
	if(user.do_actions || !can_climb(user))
		return

	user.visible_message(span_warning("[user] starts [atom_flags & ON_BORDER ? "leaping over" : "climbing onto"] \the [src]!"))

	if(!do_after(user, climb_delay, IGNORE_HELD_ITEM, src, BUSY_ICON_GENERIC))
		return

	var/turf/destination_turf = can_climb(user)
	if(!istype(destination_turf))
		return

	for(var/m in user.buckled_mobs)
		user.unbuckle_mob(m)

	user.forceMove(destination_turf)
	user.visible_message(span_warning("[user] [atom_flags & ON_BORDER ? "leaps over" : "climbs onto"] \the [src]!"))

/obj/structure/proc/structure_shaken()
	for(var/mob/living/M in get_turf(src))
		if(M.lying_angle)
			return //No spamming this on people.
		M.Paralyze(2 SECONDS)
		to_chat(M, span_warning("You topple as \the [src] moves under you!"))

		if(prob(25))

			var/damage = rand(15,30)
			if(!ishuman(M))
				to_chat(M, span_danger("You land heavily!"))
				M.apply_damage(damage, BRUTE)
				UPDATEHEALTH(M)
				return

			var/mob/living/carbon/human/H = M
			var/datum/limb/affecting

			switch(pick(list("ankle","wrist","head","knee","elbow")))
				if("ankle")
					affecting = H.get_limb(pick("l_foot", "r_foot"))
				if("knee")
					affecting = H.get_limb(pick("l_leg", "r_leg"))
				if("wrist")
					affecting = H.get_limb(pick("l_hand", "r_hand"))
				if("elbow")
					affecting = H.get_limb(pick("l_arm", "r_arm"))
				if("head")
					affecting = H.get_limb("head")

			if(affecting)
				to_chat(M, span_danger("You land heavily on your [affecting.display_name]!"))
				affecting.take_damage_limb(damage)
			else
				to_chat(H, span_danger("You land heavily!"))
				H.apply_damage(damage, BRUTE)

			UPDATEHEALTH(H)
			H.UpdateDamageIcon()

/obj/structure/can_interact(mob/user)
	. = ..()
	if(!.)
		return FALSE

	if(!user.CanReach(src))
		return FALSE

	return TRUE

/obj/structure/attack_hand(mob/living/user)
	. = ..()
	if(.)
		return

	if(!can_interact(user))
		return

	return interact(user)

/obj/structure/get_acid_delay()
	return 4 SECONDS

/obj/structure/effect_smoke(obj/effect/particle_effect/smoke/S)
	. = ..()
	if(CHECK_BITFIELD(S.smoke_traits, SMOKE_XENO_ACID))
		take_damage(10 * S.strength, BURN, ACID)

/obj/structure/punch_act(mob/living/carbon/xenomorph/xeno, punch_damage, ...)
	. = ..()
	xeno.do_attack_animation(src, ATTACK_EFFECT_YELLOWPUNCH)
	xeno.do_attack_animation(src, ATTACK_EFFECT_DISARM2)
	attack_alien(xeno, punch_damage * 4, BRUTE, effects = FALSE)
	playsound(src, pick('sound/effects/bang.ogg','sound/effects/metal_crash.ogg','sound/effects/meteorimpact.ogg'), 50, 1)
	Shake(duration = 0.5 SECONDS)
