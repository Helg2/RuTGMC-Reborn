/turf/open/floor/plating/ground/snow
	name = "snow layer"
	icon = 'icons/turf/snow2.dmi'
	icon_state = "snow_0_1"
	hull_floor = TRUE
	shoefootstep = FOOTSTEP_SNOW
	barefootstep = FOOTSTEP_SNOW
	mediumxenofootstep = FOOTSTEP_SNOW
	minimap_color = MINIMAP_SNOW

/turf/open/floor/plating/ground/snow/Initialize(mapload)
	. = ..()
	RegisterSignal(src, COMSIG_ATOM_ACIDSPRAY_ACT, PROC_REF(acidspray_act))
	update_appearance()
	update_sides()

/turf/open/floor/plating/ground/snow/fire_act(burn_level, flame_color)
	if(!slayer || !burn_level)
		return

	switch(burn_level)
		if(1 to 10)
			slayer = max(0, slayer - 1)
		if(11 to 24)
			slayer = max(0, slayer - 2)
		if(25 to INFINITY)
			slayer = 0

	update_appearance()
	update_sides()

//Xenos digging up snow
/turf/open/floor/plating/ground/snow/attack_alien(mob/living/carbon/xenomorph/M, damage_amount = M.xeno_caste.melee_damage, damage_type = BRUTE, damage_flag = MELEE, effects = TRUE, armor_penetration = 0, isrightclick = FALSE)
	if(M.status_flags & INCORPOREAL)
		return

	if(M.a_intent == INTENT_GRAB)
		if(!slayer)
			to_chat(M, span_warning("There is nothing to clear out!"))
			return FALSE

		M.visible_message(span_notice("\The [M] starts clearing out \the [src]."), \
		span_notice("We start clearing out \the [src]."), null, 5)
		playsound(M.loc, 'sound/weapons/alien_claw_swipe.ogg', 25, 1)
		if(!do_after(M, 0.5 SECONDS, IGNORE_HELD_ITEM, src, BUSY_ICON_BUILD))
			return FALSE

		if(!slayer)
			to_chat(M, span_warning("There is nothing to clear out!"))
			return

		M.visible_message(span_notice("\The [M] clears out \the [src]."), \
		span_notice("We clear out \the [src]."), null, 5)
		slayer = 0
		update_appearance()
		update_sides()

//PLACING/REMOVING/BUILDING
/turf/open/floor/plating/ground/snow/attackby(obj/item/I, mob/user, params)
	. = ..()
	if(.)
		return
	//Light Stick
	if(istype(I, /obj/item/lightstick))
		var/obj/item/lightstick/L = I
		if(locate(/obj/item/lightstick) in get_turf(src))
			to_chat(user, "There's already a [L.name] at this position!")
			return

		to_chat(user, "Now planting \the [L].")
		if(!do_after(user, 2 SECONDS, NONE, src, BUSY_ICON_BUILD))
			return

		user.visible_message(span_notice("[user.name] planted \the [L] into [src]."))
		L.anchored = TRUE
		L.icon_state = "lightstick_[L.s_color][L.anchored]"
		user.drop_held_item()
		L.x = x
		L.y = y
		L.pixel_x += rand(-5,5)
		L.pixel_y += rand(-5,5)
		L.set_light(2,1)
		playsound(user, 'sound/weapons/genhit.ogg', 25, 1)

/turf/open/floor/plating/ground/snow/Entered(atom/movable/arrived, atom/old_loc, list/atom/old_locs)
	if(slayer > 0 && isxeno(arrived))
		var/mob/living/carbon/xenomorph/xeno = arrived
		if(xeno.is_charging >= CHARGE_ON) // chargers = snow plows
			slayer = 0
			update_appearance()
			update_sides()
	return ..()

/turf/open/floor/plating/ground/snow/update_name(updates)
	. = ..()
	switch(slayer)
		if(0)
			name = "dirt floor"
		if(1)
			name = "shallow [initial(name)]"
		if(2)
			name = "deep [initial(name)]"
		if(3)
			name = "very deep [initial(name)]"

/turf/open/floor/plating/ground/snow/update_overlays()
	. = ..()
	for(var/dirn in GLOB.alldirs)
		var/turf/open/T = get_step(src, dirn)
		if(!isopenturf(T))
			continue
		if(slayer > T.slayer && T.slayer < 1)
			var/image/I = new('icons/turf/snow2.dmi', "snow_[(dirn & (dirn-1)) ? "outercorner" : pick("innercorner", "outercorner")]", dir = dirn)
			switch(dirn)
				if(NORTH)
					I.pixel_y = 32
				if(SOUTH)
					I.pixel_y = -32
				if(EAST)
					I.pixel_x = 32
				if(WEST)
					I.pixel_x = -32
				if(NORTHEAST)
					I.pixel_x = 32
					I.pixel_y = 32
				if(SOUTHEAST)
					I.pixel_x = 32
					I.pixel_y = -32
				if(NORTHWEST)
					I.pixel_x = -32
					I.pixel_y = 32
				if(SOUTHWEST)
					I.pixel_x = -32
					I.pixel_y = -32

			I.layer = layer + 0.001 + slayer * 0.0001
			. += I

/turf/open/floor/plating/ground/snow/update_icon_state()
	. = ..()
	icon_state = "snow_[slayer]_[rand(1,8)]"

///Fully update all the turfs around us
/turf/open/floor/plating/ground/snow/proc/update_sides()
	for(var/dirn in GLOB.alldirs)
		var/turf/open/floor/plating/ground/snow/D = get_step(src,dirn)
		if(istype(D))
			//Update turfs that are near us, but only once
			D.update_appearance(ALL)

/turf/open/floor/plating/ground/snow/ex_act(severity)
	if(slayer && prob(severity * 0.2))
		slayer = rand(0, 3)
	update_appearance()
	update_sides()
	return ..()

/turf/open/floor/plating/ground/snow/proc/acidspray_act()
	SIGNAL_HANDLER

	if(!slayer) //Don't bother if there's no snow to melt or if there's no burn stacks
		return

	slayer = max(0, slayer - 1) //Melt a layer
	update_icon(TRUE, FALSE)

/turf/open/floor/plating/ground/snow/attack_hand(mob/living/carbon/human/user)
	. = ..()
	if(!istype(user)) //Nonhumans don't have the balls to fight in the snow
		return
	if(src.slayer == 0)
		return
	user.changeNext_move(CLICK_CD_MELEE)
	var/obj/item/snowball/SB = new(get_turf(user))
	user.put_in_hands(SB)
	if(src.slayer > 0)
		if(prob(50))
			src.slayer -= 1
			update_icon(TRUE, FALSE)
	user.balloon_alert(user, "You scoop up some snow and make a snowball!")

//SNOW BALL
/obj/item/snowball
	name = "snowball"
	desc = "Get ready for a snowball fight!"
	icon = 'icons/obj/items/toy.dmi'
	icon_state = "snowball"

/obj/item/snowball/throw_impact(atom/target, speed = 1)
	new /obj/item/stack/snow(loc, 1)
	playsound(target, 'sound/weapons/tap.ogg', 20, TRUE)
	qdel(src)

//SNOW LAYERS-----------------------------------//
/turf/open/floor/plating/ground/snow/layer0
	icon_state = "snow_0_1"
	slayer = 0
	minimap_color = MINIMAP_DIRT

/turf/open/floor/plating/ground/snow/layer1
	icon_state = "snow_1_1"
	slayer = 1

/turf/open/floor/plating/ground/snow/layer2
	icon_state = "snow_2_1"
	slayer = 2

/turf/open/floor/plating/ground/snow/layer3
	icon_state = "snow_3_1"
	slayer = 3
