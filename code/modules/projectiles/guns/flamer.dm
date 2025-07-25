#define FLAMER_WATER 200

/obj/item/weapon/gun/flamer
	name = "flamer"
	desc = "flame go froosh"
	icon = 'icons/obj/items/gun/special.dmi'
	worn_icon_list = list(
		slot_l_hand_str = 'icons/mob/inhands/gun/special_lefthand_1.dmi',
		slot_r_hand_str = 'icons/mob/inhands/gun/special_righthand_1.dmi',
	)
	equip_slot_flags = ITEM_SLOT_BACK
	w_class = WEIGHT_CLASS_BULKY
	force = 15
	fire_sound = SFX_GUN_FLAMETHROWER
	dry_fire_sound = 'sound/weapons/guns/fire/flamethrower_empty.ogg'
	unload_sound = 'sound/weapons/guns/interact/flamethrower_unload.ogg'
	reload_sound = 'sound/weapons/guns/interact/flamethrower_reload.ogg'
	muzzle_flash = null
	aim_slowdown = 1.75
	wield_delay = 0.4 SECONDS
	general_codex_key = "flame weapons"
	attachable_allowed = list( //give it some flexibility.
		/obj/item/attachable/flashlight,
		/obj/item/attachable/magnetic_harness,
		/obj/item/attachable/motiondetector,
		/obj/item/attachable/buildasentry,
		/obj/item/attachable/flamer_nozzle,
		/obj/item/attachable/flamer_nozzle/wide,
		/obj/item/attachable/flamer_nozzle/wide/red,
		/obj/item/attachable/shoulder_mount,
		)
	attachments_by_slot = list(
		ATTACHMENT_SLOT_MUZZLE,
		ATTACHMENT_SLOT_RAIL,
		ATTACHMENT_SLOT_STOCK,
		ATTACHMENT_SLOT_UNDER,
		ATTACHMENT_SLOT_MAGAZINE,
		ATTACHMENT_SLOT_FLAMER_NOZZLE,
	)
	starting_attachment_types = list(/obj/item/attachable/flamer_nozzle)
	gun_features_flags = GUN_AMMO_COUNTER|GUN_WIELDED_FIRING_ONLY|GUN_WIELDED_STABLE_FIRING_ONLY
	gun_skill_category = SKILL_HEAVY_WEAPONS
	reciever_flags = AMMO_RECIEVER_MAGAZINES|AMMO_RECIEVER_DO_NOT_EJECT_HANDFULS|AMMO_RECIEVER_DO_NOT_EMPTY_ROUNDS_AFTER_FIRE
	attachable_offset = list("rail_x" = 12, "rail_y" = 23, "flamer_nozzle_x" = 33, "flamer_nozzle_y" = 20)
	fire_delay = 2 SECONDS

	placed_overlay_iconstate = "flamer"

	ammo_datum_type = /datum/ammo/flamethrower
	default_ammo_type = /obj/item/ammo_magazine/flamer_tank/large
	allowed_ammo_types = list(
		/obj/item/ammo_magazine/flamer_tank,
		/obj/item/ammo_magazine/flamer_tank/large,
		/obj/item/ammo_magazine/flamer_tank/large/X,
		/obj/item/ammo_magazine/flamer_tank/large/G,
		/obj/item/ammo_magazine/flamer_tank/backtank,
		/obj/item/ammo_magazine/flamer_tank/backtank/X,
		/obj/item/ammo_magazine/flamer_tank/backtank/G,
	)
	light_range = 0.1
	light_power = 0.1
	light_color = LIGHT_COLOR_ORANGE
	///Max range of the flamer in tiles.
	var/flame_max_range = 6
	///Max resin wall penetration in tiles.
	var/flame_max_wall_pen = 3
	///After how many total resin walls the flame wont proceed further
	var/flame_max_wall_pen_wide = 7
	///Travel speed of the flames in seconds.
	var/flame_spread_time = 0.1 SECONDS
	///Gun based modifier for burn level. Percentage based.
	var/burn_level_mod = 1
	///Gun based modifier for burn time. Percentage based.
	var/burn_time_mod = 1
	///Bitfield flags for flamer specific traits.
	var/flamer_features_flags = NONE
	///Overlay icon state of the pilot light.
	var/lit_overlay_icon_state = "+lit"
	///Pixel offset on the X axis for the pilot light overlay.
	var/lit_overlay_offset_x = 6
	///Pixel offset on the Y axis for the pilot light overlay.
	var/lit_overlay_offset_y = 0
	///Damage multiplier for mobs caught in the initial stream of fire.
	var/mob_flame_damage_mod = 2
	///how wide of a cone the flamethrower produces on wide mode.
	var/cone_angle = 55

/obj/item/weapon/gun/flamer/Initialize(mapload)
	. = ..()
	if(!rounds)
		return
	light_pilot(TRUE)

/obj/item/weapon/gun/flamer/on_attachment_attach(obj/item/attaching_here, mob/attacher)
	. = ..()
	if(!istype(attaching_here, /obj/item/attachable/flamer_nozzle) || !rounds)
		return
	light_pilot(TRUE)

/obj/item/weapon/gun/flamer/on_attachment_detach(obj/item/detaching_here, mob/attacher)
	. = ..()
	if(!istype(detaching_here, /obj/item/attachable/flamer_nozzle))
		return
	light_pilot(FALSE)

/obj/item/weapon/gun/flamer/reload(obj/item/new_mag, mob/living/user)
	. = ..()
	if(!.)
		return
	if(attachments_by_slot[ATTACHMENT_SLOT_FLAMER_NOZZLE])
		light_pilot(TRUE)
	gun_user?.hud_used.update_ammo_hud(src, get_ammo_list(), get_display_ammo_count())

/obj/item/weapon/gun/flamer/unload(mob/living/user, drop = TRUE, after_fire = FALSE)
	. = ..()
	if(!.)
		return
	light_pilot(FALSE)
	gun_user?.hud_used.update_ammo_hud(src, get_ammo_list(), get_display_ammo_count())

///Makes the sound of the flamer being lit, and applies the overlay.
/obj/item/weapon/gun/flamer/proc/light_pilot(light)
	if(!CHECK_BITFIELD(flamer_features_flags, FLAMER_IS_LIT) == !light) //!s so we can check equivalence on truthy, rather than true, values
		return
	if(light)
		ENABLE_BITFIELD(flamer_features_flags, FLAMER_IS_LIT)
		turn_light(null, TRUE)
	else
		DISABLE_BITFIELD(flamer_features_flags, FLAMER_IS_LIT)
		turn_light(null, FALSE)
	playsound(src, CHECK_BITFIELD(flamer_features_flags, FLAMER_IS_LIT) ? 'sound/weapons/guns/interact/flamethrower_on.ogg' : 'sound/weapons/guns/interact/flamethrower_off.ogg', 25, 1)

	if(CHECK_BITFIELD(flamer_features_flags, FLAMER_NO_LIT_OVERLAY))
		return

	update_icon()

/obj/item/weapon/gun/flamer/update_overlays()
	. = ..()
	if(!CHECK_BITFIELD(flamer_features_flags, FLAMER_IS_LIT)|| CHECK_BITFIELD(flamer_features_flags, FLAMER_NO_LIT_OVERLAY))
		return

	var/image/lit_overlay = image(icon, src, lit_overlay_icon_state)
	lit_overlay.pixel_x += lit_overlay_offset_x
	lit_overlay.pixel_y += lit_overlay_offset_y
	. += lit_overlay

/obj/item/weapon/gun/flamer/turn_light(mob/user, toggle_on)
	. = ..()
	if(. != CHECKS_PASSED)
		return
	set_light_on(toggle_on)

/obj/item/weapon/gun/flamer/able_to_fire(mob/user)
	. = ..()
	if(!.)
		return
	if(!istype(attachments_by_slot[ATTACHMENT_SLOT_FLAMER_NOZZLE], /obj/item/attachable/flamer_nozzle))
		to_chat(user, span_warning("[src] does not have a nozzle installed!"))
		return FALSE
	return TRUE

/obj/item/weapon/gun/flamer/do_fire(obj/projectile/projectile_to_fire)
	playsound(loc, fire_sound, GUN_FIRE_SOUND_VOLUME, 1)
	var/obj/item/attachable/flamer_nozzle/nozzle = attachments_by_slot[ATTACHMENT_SLOT_FLAMER_NOZZLE]
	var/burn_type = nozzle.stream_type
	var/old_turfs = list(get_turf(src))
	var/range = flame_max_range
	var/start_location = get_turf(src)
	var/current_target = get_turf(target)
	switch(burn_type)
		if(FLAMER_STREAM_STRAIGHT)
			var/path_to_target = get_traversal_line(start_location, current_target) //todo: use get_traversal_line and change recursive_flame_straight to use get_dist_euclidean for range
			path_to_target -= start_location
			recursive_flame_straight(1, old_turfs, path_to_target, range, current_target, flame_max_wall_pen)
		if(FLAMER_STREAM_CONE)
			//direction in degrees
			var/dir_to_target = Get_Angle(src, target)
			var/list/turf/turfs_to_ignite = generate_cone(get_turf(src), range, 1, cone_angle, dir_to_target, pass_flags_checked = PASS_AIR|PASS_XENO)
			recursive_flame_cone(1, turfs_to_ignite, dir_to_target, range, current_target, get_turf(src), flame_max_wall_pen_wide)
		if(FLAMER_STREAM_RANGED)
			return ..()
	return TRUE

///Flames recursively a straight path.
/obj/item/weapon/gun/flamer/proc/recursive_flame_straight(iteration, list/turf/old_turfs, list/turf/path_to_target, range, current_target, walls_penetrated)
	if(!rounds)
		light_pilot(FALSE)
		return
	//recursive checks
	if(!length(old_turfs) || iteration > range || !current_target || (current_target in old_turfs))
		return

	var/list/turf/turfs_to_ignite = list()
	if(iteration > length(path_to_target))
		return
	var/turf/turf_to_check = get_turf(src)
	if(iteration > 1)
		turf_to_check = path_to_target[iteration - 1]
	if(LinkBlocked(turf_to_check, path_to_target[iteration], PASS_AIR|PASS_XENO)) //checks if it's actually possible to get to the next tile in the line
		return
	if(istype(turf_to_check, /turf/closed/wall/resin/regenerating/fireproof))
		return
	if(turf_to_check.density && istype(turf_to_check, /turf/closed/wall/resin))
		walls_penetrated -= 1
	//how many resin walls we've penetrated check
	if(walls_penetrated <= 0)
		return
	turfs_to_ignite[path_to_target[iteration]] = get_dir(turf_to_check, path_to_target[iteration])
	if(!burn_list(turfs_to_ignite))
		return
	iteration++
	addtimer(CALLBACK(src, PROC_REF(recursive_flame_straight), iteration, turfs_to_ignite, path_to_target, range, current_target, walls_penetrated), flame_spread_time)

///Flames recursively a cone.
/obj/item/weapon/gun/flamer/proc/recursive_flame_cone(iteration, list/turf/turfs_to_ignite, dir_to_target, range, current_target, turf/flame_source, walls_penetrated_wide)
	if(!rounds)
		light_pilot(FALSE)
		return
	//recursive checks
	if(iteration > range || !current_target)
		return

	var/list/turf/turfs_by_iteration = list()
	for(var/turf/turf AS in turfs_to_ignite)
		if(get_dist(turf, flame_source) == iteration)
			//Checks if turf is resin wall
			if(turf.density && istype(turf, /turf/closed/wall/resin))
				walls_penetrated_wide -= 1
			//Checks if there is a resin door on the turf
			var/obj/structure/mineral_door/resin/door_to_check = locate() in turf
			if(!isnull(door_to_check))
				walls_penetrated_wide -= 1
			//Check to ensure that we dont burn more walls than specified
			if(walls_penetrated_wide <= 0)
				break
			turfs_by_iteration[turf] = get_dir(src, turf)

	burn_list(turfs_by_iteration)
	iteration++
	addtimer(CALLBACK(src, PROC_REF(recursive_flame_cone), iteration, turfs_to_ignite, dir_to_target, range, current_target, flame_source, walls_penetrated_wide), flame_spread_time)

///Checks and lights the turfs in turfs_to_burn
/obj/item/weapon/gun/flamer/proc/burn_list(list/turf/turfs_to_burn)
	if(!length(turfs_to_burn) || !length(chamber_items))
		return FALSE

	var/datum/ammo/flamethrower/loaded_ammo = CHECK_BITFIELD(flamer_features_flags, FLAMER_USES_GUN_FLAMES) ? ammo_datum_type : get_magazine_default_ammo(chamber_items[current_chamber_position])
	var/burn_level = initial(loaded_ammo.burn_level) * burn_level_mod
	var/burn_time = initial(loaded_ammo.burn_time) * burn_time_mod
	var/fire_color = initial(loaded_ammo.fire_color)

	for(var/turf/turf_to_ignite AS in turfs_to_burn)
		if(!rounds)
			light_pilot(FALSE)
			return FALSE
		flame_turf(turf_to_ignite, gun_user, burn_time, burn_level, fire_color, turfs_to_burn[turf_to_ignite])
		adjust_current_rounds(chamber_items[current_chamber_position], -1)
		rounds--
	gun_user?.hud_used.update_ammo_hud(src, get_ammo_list(), get_display_ammo_count())
	return TRUE

///Lights the specific turf on fire and processes melting snow or vines and the like.
/obj/item/weapon/gun/flamer/proc/flame_turf(turf/turf_to_ignite, mob/living/user, burn_time, burn_level, fire_color = "red", direction = NORTH)
	turf_to_ignite.ignite(burn_time, burn_level, fire_color)

	for(var/mob/living/mob_caught in turf_to_ignite) //Deal bonus damage if someone's caught directly in initial stream
		if(mob_caught.stat == DEAD)
			continue

		if(isxeno(mob_caught))
			var/mob/living/carbon/xenomorph/xeno_caught = mob_caught
			if(CHECK_BITFIELD(xeno_caught.xeno_caste.caste_flags, CASTE_FIRE_IMMUNE))
				continue

		else if(ishuman(mob_caught))
			var/mob/living/carbon/human/human_caught = mob_caught
			if(user)
				if(!user.mind?.bypass_ff && !human_caught.mind?.bypass_ff && user.faction == human_caught.faction)
					log_combat(user, human_caught, "flamed", src)
					user.ff_check(30, human_caught) // avg between 20/40 dmg
					log_ffattack("[key_name(user)] flamed [key_name(human_caught)] with \a [name] in [AREACOORD(turf_to_ignite)].")
					msg_admin_ff("[ADMIN_TPMONTY(user)] flamed [ADMIN_TPMONTY(human_caught)] with \a [name] in [ADMIN_VERBOSEJMP(turf_to_ignite)].")
				else
					log_combat(user, human_caught, "flamed", src)

		mob_caught.take_overall_damage(rand(burn_level, (burn_level * mob_flame_damage_mod)), BURN, FIRE, updating_health = TRUE, max_limbs = 4) // Make it so its the amount of heat or twice it for the initial blast.
		mob_caught.adjust_fire_stacks(rand(5, (burn_level * mob_flame_damage_mod)))
		mob_caught.IgniteMob()

		var/burn_message = "Augh! You are roasted by the flames!"
		to_chat(mob_caught, isxeno(mob_caught) ? span_xenodanger(burn_message) : span_userdanger(burn_message))

/obj/item/weapon/gun/flamer/big_flamer
	name = "\improper FL-240 incinerator unit"
	desc = "The FL-240 has proven to be one of the most effective weapons at clearing out soft-targets. This is a weapon to be feared and respected as it is quite deadly."
	icon_state = "m240"
	worn_icon_state = "m240"

/obj/item/weapon/gun/flamer/big_flamer/vsd
	starting_attachment_types = list(/obj/item/attachable/motiondetector, /obj/item/attachable/flamer_nozzle/wide,)

/obj/item/weapon/gun/flamer/som
	name = "\improper V-62 incinerator"
	desc = "The V-62 is a deadly weapon employed in close quarter combat, favoured as much for the terror it inspires as the actual damage it inflicts. It has good range for a flamer, but lacks the integrated extinguisher of its TGMC equivalent."
	icon = 'icons/obj/items/gun/special64.dmi'
	icon_state = "v62"
	worn_icon_state = "v62"
	gun_features_flags = GUN_AMMO_COUNTER|GUN_WIELDED_FIRING_ONLY|GUN_WIELDED_STABLE_FIRING_ONLY|GUN_SHOWS_LOADED
	inhand_x_dimension = 64
	inhand_y_dimension = 32
	worn_icon_list = list(
		slot_l_hand_str = 'icons/mob/inhands/gun/special_lefthand_64.dmi',
		slot_r_hand_str = 'icons/mob/inhands/gun/special_righthand_64.dmi',
	)
	lit_overlay_icon_state = "v62_lit"
	lit_overlay_offset_x = 0
	flame_max_range = 8
	cone_angle = 40
	starting_attachment_types = list(/obj/item/attachable/flamer_nozzle/wide)
	default_ammo_type = /obj/item/ammo_magazine/flamer_tank/large/som
	allowed_ammo_types = list(
		/obj/item/ammo_magazine/flamer_tank/large/som,
		/obj/item/ammo_magazine/flamer_tank/backtank,
		/obj/item/ammo_magazine/flamer_tank/backtank/X,
		/obj/item/ammo_magazine/flamer_tank/backtank/G,
	)

/obj/item/weapon/gun/flamer/som/apply_custom(mutable_appearance/standing, inhands, icon_used, state_used)
	. = ..()
	var/mutable_appearance/emissive_overlay = emissive_appearance(icon_used, "[state_used]_emissive")
	standing.overlays.Add(emissive_overlay)

/obj/item/weapon/gun/flamer/som/mag_harness
	starting_attachment_types = list(/obj/item/attachable/flamer_nozzle/wide, /obj/item/attachable/magnetic_harness)

//dedicated engineer pyro kit flamer
/obj/item/weapon/gun/flamer/big_flamer/marinestandard/engineer
	name = "\improper FL-86 incinerator unit"
	desc = "The FL-86 is a more light weight incinerator unit designed specifically to fit into its accompanying engineers bag. Can only be used with magazine fuel tanks however."
	default_ammo_type = /obj/item/ammo_magazine/flamer_tank/large
	allowed_ammo_types = list(
		/obj/item/ammo_magazine/flamer_tank,
		/obj/item/ammo_magazine/flamer_tank/large,
		/obj/item/ammo_magazine/flamer_tank/large/X,
	)
	attachable_allowed = list(
		/obj/item/attachable/flashlight,
		/obj/item/attachable/magnetic_harness,
		/obj/item/attachable/motiondetector,
		/obj/item/attachable/buildasentry,
		/obj/item/attachable/stock/t84stock,
		/obj/item/attachable/flamer_nozzle,
		/obj/item/attachable/flamer_nozzle/wide,
		/obj/item/attachable/flamer_nozzle/long,
	)
	starting_attachment_types = list(/obj/item/attachable/flamer_nozzle, /obj/item/attachable/stock/t84stock)

/obj/item/weapon/gun/flamer/big_flamer/marinestandard/engineer/beginner
	starting_attachment_types = list(
		/obj/item/attachable/motiondetector,
		/obj/item/attachable/flamer_nozzle,
		/obj/item/attachable/stock/t84stock,
	)

/obj/item/weapon/gun/flamer/mini_flamer
	name = "mini flamethrower"
	desc = "A weapon-mounted refillable flamethrower attachment.\nIt is designed for short bursts."
	icon = 'icons/obj/items/attachments/attachments.dmi'
	icon_state = "flamethrower"

	worn_icon_list = list( // for whatever fucking reason we can't set it null
		slot_l_hand_str = 'icons/mob/inhands/items_lefthand_1.dmi',
		slot_r_hand_str = 'icons/mob/inhands/items_righthand_1.dmi',
	)

	gun_features_flags = GUN_AMMO_COUNTER|GUN_WIELDED_FIRING_ONLY|GUN_WIELDED_STABLE_FIRING_ONLY|GUN_IS_ATTACHMENT|GUN_ATTACHMENT_FIRE_ONLY
	flamer_features_flags = FLAMER_NO_LIT_OVERLAY
	w_class = WEIGHT_CLASS_BULKY
	fire_delay = 2.5 SECONDS
	fire_sound = 'sound/weapons/guns/fire/flamethrower3.ogg'

	default_ammo_type = /obj/item/ammo_magazine/flamer_tank/mini
	allowed_ammo_types = list(
		/obj/item/ammo_magazine/flamer_tank/mini,
		/obj/item/ammo_magazine/flamer_tank/backtank,
		/obj/item/ammo_magazine/flamer_tank/mini/X,
		/obj/item/ammo_magazine/flamer_tank/backtank/X,
		/obj/item/ammo_magazine/flamer_tank/mini/G,
		/obj/item/ammo_magazine/flamer_tank/backtank/G,
	)
	starting_attachment_types = list(/obj/item/attachable/flamer_nozzle/unremovable/invisible)
	attachable_allowed = list(
		/obj/item/attachable/flamer_nozzle/unremovable/invisible,
	)
	slot = ATTACHMENT_SLOT_UNDER
	attach_delay = 3 SECONDS
	detach_delay = 3 SECONDS
	pixel_shift_x = 15
	pixel_shift_y = 18

	mob_flame_damage_mod = 1
	burn_level_mod = 0.6
	flame_max_range = 4

	wield_delay_mod = 0.2 SECONDS

/obj/item/weapon/gun/flamer/mini_flamer/unremovable
	attach_features_flags = NONE


/obj/item/weapon/gun/flamer/big_flamer/marinestandard
	name = "\improper FL-84 flamethrower"
	desc = "The FL-84 flamethrower is the current standard issue flamethrower of the TGMC, and is used for area control and urban combat. Use unique action to use hydro cannon"
	default_ammo_type = /obj/item/ammo_magazine/flamer_tank/large
	icon_state = "tl84"
	worn_icon_state = "tl84"
	gun_features_flags = GUN_WIELDED_FIRING_ONLY|GUN_AMMO_COUNTER|GUN_WIELDED_STABLE_FIRING_ONLY
	attachable_offset = list("rail_x" = 10, "rail_y" = 23, "stock_x" = 16, "stock_y" = 13, "flamer_nozzle_x" = 33, "flamer_nozzle_y" = 20, "under_x" = 24, "under_y" = 15)
	attachable_allowed = list(
		/obj/item/attachable/flashlight,
		/obj/item/attachable/magnetic_harness,
		/obj/item/attachable/motiondetector,
		/obj/item/attachable/buildasentry,
		/obj/item/attachable/stock/t84stock,
		/obj/item/attachable/flamer_nozzle,
		/obj/item/attachable/flamer_nozzle/wide,
		/obj/item/attachable/flamer_nozzle/wide/red,
		/obj/item/attachable/flamer_nozzle/long,
		/obj/item/weapon/gun/flamer/hydro_cannon,
	)
	starting_attachment_types = list(/obj/item/attachable/flamer_nozzle, /obj/item/attachable/stock/t84stock, /obj/item/weapon/gun/flamer/hydro_cannon)

/obj/item/weapon/gun/flamer/big_flamer/marinestandard/do_fire(obj/projectile/projectile_to_fire)
	if(!target)
		return
	if(gun_user?.skills.getRating(SKILL_FIREARMS) < 0)
		switch(windup_checked)
			if(WEAPON_WINDUP_NOT_CHECKED)
				INVOKE_ASYNC(src, PROC_REF(do_windup))
				return
			if(WEAPON_WINDUP_CHECKING)
				return
	return ..()

///Flamer windup called before firing
/obj/item/weapon/gun/flamer/big_flamer/marinestandard/proc/do_windup()
	windup_checked = WEAPON_WINDUP_CHECKING
	if(!do_after(gun_user, 1 SECONDS, IGNORE_USER_LOC_CHANGE, src))
		windup_checked = WEAPON_WINDUP_NOT_CHECKED
		return
	windup_checked = WEAPON_WINDUP_CHECKED
	Fire()

/obj/item/weapon/gun/flamer/big_flamer/marinestandard/wide
	starting_attachment_types = list(
		/obj/item/attachable/flamer_nozzle/wide,
		/obj/item/attachable/stock/t84stock,
		/obj/item/weapon/gun/flamer/hydro_cannon,
		/obj/item/attachable/magnetic_harness,
	)

/obj/item/weapon/gun/flamer/big_flamer/marinestandard/deathsquad
	allowed_ammo_types = list(/obj/item/ammo_magazine/flamer_tank/large/X/deathsquad)
	default_ammo_type = /obj/item/ammo_magazine/flamer_tank/large/X/deathsquad
	starting_attachment_types = list(
		/obj/item/attachable/flamer_nozzle/wide/red,
		/obj/item/attachable/stock/t84stock,
		/obj/item/weapon/gun/flamer/hydro_cannon,
		/obj/item/attachable/magnetic_harness,
	)

/turf/proc/ignite(fire_lvl, burn_lvl, f_color, fire_stacks = 0, fire_damage = 0)
	//extinguish any flame present
	var/obj/fire/flamer/old_fire = locate(/obj/fire/flamer) in src
	if(old_fire)
		var/new_burn_ticks = min(fire_lvl + old_fire.burn_ticks, fire_lvl * 2)
		var/new_burn_level = min(burn_lvl + old_fire.burn_level, burn_lvl * 1.5)
		old_fire.set_fire(new_burn_ticks, new_burn_level, f_color, fire_stacks, fire_damage)
		return

	new /obj/fire/flamer(src, fire_lvl, burn_lvl, f_color, fire_stacks, fire_damage)
	for(var/obj/structure/flora/jungle/vines/vines in src)
		QDEL_NULL(vines)

/turf/open/floor/plating/ground/snow/ignite(fire_lvl, burn_lvl, f_color, fire_stacks = 0, fire_damage = 0)
	if(slayer > 0)
		slayer -= 1
		update_appearance()
		update_sides()
	return ..()

GLOBAL_LIST_EMPTY(flamer_particles)
/particles/flamer_fire
	icon = 'icons/effects/particles/fire.dmi'
	icon_state = "bonfire"
	width = 100
	height = 100
	count = 1000
	spawning = 8
	lifespan = 0.7 SECONDS
	fade = 1 SECONDS
	grow = -0.01
	velocity = list(0, 0)
	position = generator(GEN_BOX, list(-16, -16), list(16, 16), NORMAL_RAND)
	drift = generator(GEN_VECTOR, list(0, -0.2), list(0, 0.2))
	gravity = list(0, 0.95)
	scale = generator(GEN_VECTOR, list(0.3, 0.3), list(1,1), NORMAL_RAND)
	rotation = 30
	spin = generator(GEN_NUM, -20, 20)

/particles/flamer_fire/New(set_color)
	..()
	if(set_color != "red") // we're already red colored by default
		color = set_color

/obj/item/weapon/gun/flamer/hydro_cannon
	name = "underslung hydrocannon"
	desc = "For the quenching of unfortunate mistakes."
	icon = 'icons/obj/items/attachments/attachments.dmi'
	icon_state = "hydrocannon"

	worn_icon_list = list( // for whatever fucking reason we can't set it null
		slot_l_hand_str = 'icons/mob/inhands/items_lefthand_1.dmi',
		slot_r_hand_str = 'icons/mob/inhands/items_righthand_1.dmi',
	)

	fire_delay = 1.2 SECONDS
	fire_sound = 'sound/effects/extinguish.ogg'
	attachable_offset = list("flamer_nozzle_x" = 20, "flamer_nozzle_y" = 27)
	attachable_allowed = list(
		/obj/item/attachable/flamer_nozzle,
		/obj/item/attachable/flamer_nozzle/wide,
		/obj/item/attachable/flamer_nozzle/long,
	)
	flame_max_range = 7

	ammo_datum_type = /datum/ammo/water
	default_ammo_type = /obj/item/ammo_magazine/flamer_tank/water
	allowed_ammo_types = list( /obj/item/ammo_magazine/flamer_tank/water)

	slot = ATTACHMENT_SLOT_UNDER
	attach_delay = 3 SECONDS
	detach_delay = 3 SECONDS
	gun_features_flags = GUN_AMMO_COUNTER|GUN_IS_ATTACHMENT|GUN_ATTACHMENT_FIRE_ONLY|GUN_WIELDED_STABLE_FIRING_ONLY|GUN_WIELDED_FIRING_ONLY
	flamer_features_flags = FLAMER_NO_LIT_OVERLAY

	flame_max_wall_pen = 1 //Actually means we'll hit one wall and then stop
	flame_max_wall_pen_wide = 1

/obj/item/weapon/gun/flamer/hydro_cannon/flame_turf(turf/turf_to_ignite, mob/living/user, burn_time, burn_level, fire_color = "red", direction = NORTH)
	for(var/atom/movable/relevant_atom AS in turf_to_ignite)
		if(isfire(relevant_atom))
			qdel(relevant_atom)
			continue
		if(isliving(relevant_atom))
			var/mob/living/mob_caught = relevant_atom
			mob_caught.ExtinguishMob()
	new /obj/effect/temp_visual/dir_setting/water_splash(turf_to_ignite, dir)

/obj/item/weapon/gun/flamer/hydro_cannon/light_pilot(light)
	return

#undef FLAMER_WATER
