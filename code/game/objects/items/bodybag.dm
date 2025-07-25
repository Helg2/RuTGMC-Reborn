/obj/item/bodybag
	name = "body bag"
	desc = "A folded bag designed for the storage and transportation of cadavers."
	icon = 'icons/obj/bodybag.dmi'
	icon_state = "bodybag_folded"
	w_class = WEIGHT_CLASS_SMALL
	var/unfoldedbag_path = /obj/structure/closet/bodybag
	var/obj/structure/closet/bodybag/unfoldedbag_instance = null

/obj/item/bodybag/Initialize(mapload, unfoldedbag)
	. = ..()
	unfoldedbag_instance = unfoldedbag

/obj/item/bodybag/Destroy()
	if(QDELETED(unfoldedbag_instance))
		unfoldedbag_instance = null
	else
		if(!isnull(unfoldedbag_instance.loc))
			stack_trace("[src] destroyed while the [unfoldedbag_instance] unfoldedbag_instance was neither destroyed nor in nullspace. This shouldn't happen.")
		QDEL_NULL(unfoldedbag_instance)
	return ..()

/obj/item/bodybag/attack_self(mob/user)
	deploy_bodybag(user, user.loc)

/obj/item/bodybag/afterattack(atom/target, mob/user, proximity)
	if(!proximity || !isturf(target) || target.density)
		return
	var/turf/target_turf = target
	for(var/atom/atom_to_check AS in target_turf)
		if(atom_to_check.density)
			return
	deploy_bodybag(user, target)

/obj/item/bodybag/proc/deploy_bodybag(mob/user, atom/location)
	if(QDELETED(unfoldedbag_instance))
		unfoldedbag_instance = new unfoldedbag_path(location, src)
	else
		unfoldedbag_instance.forceMove(location)
	unfoldedbag_instance.open(user)
	user.temporarilyRemoveItemFromInventory(src)
	moveToNullspace()

/obj/structure/closet/bodybag
	name = "body bag"
	var/bag_name = "body bag"
	desc = "A plastic bag designed for the storage and transportation of cadavers."
	icon = 'icons/obj/bodybag.dmi'
	icon_state = "bodybag_closed"
	icon_closed = "bodybag_closed"
	icon_opened = "bodybag_open"
	open_sound = 'sound/items/zip.ogg'
	close_sound = 'sound/items/zip.ogg'
	density = FALSE
	mob_storage_capacity = 1
	storage_capacity = 3 //Just room enough for that stripped armor, gun and whatnot.
	anchored = FALSE
	drag_delay = 2 //slightly easier than to drag the body directly.
	obj_flags = CAN_BE_HIT | PROJ_IGNORE_DENSITY
	can_be_welded = FALSE
	var/foldedbag_path = /obj/item/bodybag
	var/obj/item/bodybag/foldedbag_instance = null
	var/obj/structure/bed/roller/roller_buckled //the roller bed this bodybag is attached to.
	var/mob/living/bodybag_occupant
	///Should the name of the person inside be displayed?
	var/display_name = TRUE

/obj/structure/closet/bodybag/Initialize(mapload, foldedbag)
	. = ..()
	foldedbag_instance = foldedbag
	RegisterSignal(src, COMSIG_ATOM_ACIDSPRAY_ACT, PROC_REF(acidspray_act))

/obj/structure/closet/bodybag/Destroy()
	open()
	if(QDELETED(foldedbag_instance))
		foldedbag_instance = null
	else
		if(!isnull(foldedbag_instance.loc))
			stack_trace("[src] destroyed while the [foldedbag_instance] foldedbag_instance was neither destroyed nor in nullspace. This shouldn't happen.")
		QDEL_NULL(foldedbag_instance)

	UnregisterSignal(src, COMSIG_ATOM_ACIDSPRAY_ACT, PROC_REF(acidspray_act))
	return ..()

/obj/structure/closet/bodybag/is_buckled()
	if(roller_buckled)
		return roller_buckled
	return ..()


/obj/structure/closet/bodybag/update_name(updates)
	. = ..()
	if(!display_name)
		return
	if(opened)
		name = bag_name
	else
		if(bodybag_occupant)
			name = "[bag_name] ([bodybag_occupant.get_visible_name()])"
		else
			name = "[bag_name] (empty)"

/obj/structure/closet/bodybag/attackby(obj/item/I, mob/user, params)
	. = ..()
	if(.)
		return

	if(istype(I, /obj/item/tool/pen))
		var/t = stripped_input(user, "What would you like the label to be?", name, null, MAX_MESSAGE_LEN)
		if(user.get_active_held_item() != I)
			return

		if(!in_range(src, user) && loc != user)
			return

		if(t)
			name = "body bag - "
			name += t
			overlays += image(icon, "bodybag_label")
		else
			name = "body bag"

	else if(iswirecutter(I))
		balloon_alert(user, "cuts the tag off")
		name = "body bag"
		overlays.Cut()

/obj/structure/closet/bodybag/closet_special_handling(mob/living/mob_to_stuff) // overriding this
	if(!ishuman(mob_to_stuff))
		return FALSE //Only humans.
	if(mob_to_stuff.stat != DEAD) //Only the dead for bodybags.
		return FALSE
	if(!HAS_TRAIT(mob_to_stuff, TRAIT_UNDEFIBBABLE) || issynth(mob_to_stuff))
		return FALSE //We don't want to store those that can be revived.
	return TRUE

/obj/structure/closet/bodybag/close()
	. = ..()
	if(.)
		density = FALSE //A bit dumb, but closets become dense when closed, and this is a closet.
		var/mob/living/carbon/human/new_guest = locate() in contents
		if(new_guest)
			bodybag_occupant = new_guest
		update_appearance()
		return TRUE
	return FALSE

/obj/structure/closet/bodybag/open()
	. = ..()
	if(bodybag_occupant)
		bodybag_occupant = null
	update_appearance()

/obj/structure/closet/bodybag/MouseDrop(over_object, src_location, over_location)
	. = ..()
	if(over_object != usr || !Adjacent(usr) || roller_buckled)
		return
	if(!ishuman(usr))
		return
	if(length(contents))
		return FALSE
	visible_message(span_notice("[usr] folds up [name]."))
	if(QDELETED(foldedbag_instance))
		foldedbag_instance = new foldedbag_path(loc, src)
	usr.put_in_hands(foldedbag_instance)
	moveToNullspace()


/obj/structure/closet/bodybag/Move(atom/newloc, direction, glide_size_override)
	if (roller_buckled && roller_buckled.loc != newloc) //not updating position
		if (!roller_buckled.anchored)
			return roller_buckled.Move(newloc, direction, glide_size)
		else
			return FALSE
	else
		return ..()

/obj/structure/closet/bodybag/forceMove(atom/destination)
	if(roller_buckled)
		roller_buckled.unbuckle_bodybag()
	return ..()

/obj/structure/closet/bodybag/update_icon_state()
	. = ..()
	if(!opened)
		icon_state = icon_closed
		for(var/mob/living/L in contents)
			icon_state += "1"
			break
	else
		icon_state = icon_opened

/obj/structure/closet/bodybag/attack_alien(mob/living/carbon/xenomorph/xeno_attacker, damage_amount = xeno_attacker.xeno_caste.melee_damage, damage_type = BRUTE, damage_flag = MELEE, effects = TRUE, armor_penetration = 0, isrightclick = FALSE)
	if(xeno_attacker.status_flags & INCORPOREAL)
		return FALSE
	if(opened)
		return FALSE // stop xeno closing things
	xeno_attacker.do_attack_animation(src, ATTACK_EFFECT_CLAW)
	bodybag_occupant?.attack_alien(xeno_attacker)
	open()
	xeno_attacker.visible_message(span_danger("\The [xeno_attacker] slashes \the [src] open!"), \
		span_danger("We slash \the [src] open!"), null, 5)
	return TRUE

/obj/structure/closet/bodybag/projectile_hit(obj/projectile/proj, cardinal_move, uncrossing)
	. = ..()
	if(src != proj.original_target) //You miss unless you click directly on the bodybag
		return FALSE

	if(!opened && bodybag_occupant)
		bodybag_occupant.bullet_act(proj) //tarp isn't bullet proof; concealment, not cover; pass it on to the occupant.
		balloon_alert(bodybag_occupant, "[proj] jolts you out of the bag")
		open()

/obj/structure/closet/bodybag/fire_act(burn_level, flame_color)
	if(!opened && bodybag_occupant)
		balloon_alert(bodybag_occupant, "The fire forces you out")
		bodybag_occupant.fire_act(burn_level, flame_color)
		open()

/obj/structure/closet/bodybag/ex_act(severity)
	if(!opened && bodybag_occupant)
		balloon_alert(bodybag_occupant, "The explosion blows you out")
		bodybag_occupant.ex_act(severity)
		open()
	if(severity <= EXPLODE_HEAVY)
		visible_message(span_danger("The shockwave blows [src] apart!"))
		qdel(src) //blown apart

/obj/structure/closet/bodybag/proc/acidspray_act(datum/source, obj/effect/xenomorph/spray/acid_puddle)
	if(!opened && bodybag_occupant)

		if(ishuman(bodybag_occupant))
			var/mob/living/carbon/human/H = bodybag_occupant
			SEND_SIGNAL(H, COMSIG_ATOM_ACIDSPRAY_ACT, src, acid_puddle.acid_damage, acid_puddle.slow_amt) //tarp isn't acid proof; pass it on to the occupant

		balloon_alert(bodybag_occupant, "acid forces you out")
		open() //Get out

/obj/structure/closet/bodybag/effect_smoke(obj/effect/particle_effect/smoke/S)
	. = ..()
	if(!.)
		return

	if((CHECK_BITFIELD(S.smoke_traits, SMOKE_BLISTERING) || CHECK_BITFIELD(S.smoke_traits, SMOKE_XENO_ACID)) && !opened && bodybag_occupant)
		bodybag_occupant.effect_smoke(S) //tarp *definitely* isn't acid/phosphorous smoke proof, lol.
		balloon_alert(bodybag_occupant, "smoke forces you out")
		open() //Get out

/obj/item/storage/box/bodybags
	name = "body bags"
	desc = "This box contains body bags."
	icon_state = "bodybags"
	w_class = WEIGHT_CLASS_NORMAL
	spawn_type = /obj/item/bodybag
	spawn_number = 7

/obj/item/bodybag/cryobag
	name = "stasis bag"
	desc = "A folded, reusable bag designed to prevent additional damage to an occupant."
	icon = 'icons/obj/cryobag.dmi'
	icon_state = "bodybag_folded"
	unfoldedbag_path = /obj/structure/closet/bodybag/cryobag
	var/used = FALSE

/obj/structure/closet/bodybag/cryobag
	name = "stasis bag"
	bag_name = "stasis bag"
	desc = "A reusable plastic bag designed to prevent additional damage to an occupant."
	icon = 'icons/obj/cryobag.dmi'
	foldedbag_path = /obj/item/bodybag/cryobag

/obj/structure/closet/bodybag/cryobag/attackby(obj/item/I, mob/user, params)
	if(!istype(I, /obj/item/healthanalyzer))
		return ..()

	if(!bodybag_occupant)
		balloon_alert(user, "empty")
		return TRUE

	var/obj/item/healthanalyzer/J = I
	J.attack(bodybag_occupant, user) // yes this is awful -spookydonut // TODO
	return TRUE

/obj/structure/closet/bodybag/cryobag/open()
	if(bodybag_occupant)
		REMOVE_TRAIT(bodybag_occupant, TRAIT_STASIS, STASIS_BAG_TRAIT)
		UnregisterSignal(bodybag_occupant, list(COMSIG_MOB_DEATH, COMSIG_PREQDELETED))
		bodybag_occupant.record_time_in_stasis()
	return ..()

/obj/structure/closet/bodybag/cryobag/closet_special_handling(mob/living/mob_to_stuff) // overriding this
	if(!ishuman(mob_to_stuff))
		return FALSE //Humans only.
	return TRUE

/obj/structure/closet/bodybag/cryobag/close()
	. = ..()
	if(bodybag_occupant)
		ADD_TRAIT(bodybag_occupant, TRAIT_STASIS, STASIS_BAG_TRAIT)
		RegisterSignals(bodybag_occupant, list(COMSIG_MOB_DEATH, COMSIG_PREQDELETED), PROC_REF(on_bodybag_occupant_death))
		bodybag_occupant.time_entered_stasis = world.time

/obj/structure/closet/bodybag/cryobag/proc/on_bodybag_occupant_death(mob/source, gibbing)
	SIGNAL_HANDLER
	if(!QDELETED(bodybag_occupant))
		visible_message(span_notice("\The [src] rejects the corpse."))
	open()

/obj/structure/closet/bodybag/cryobag/examine(mob/living/user)
	. = ..()
	var/mob/living/carbon/human/occupant = bodybag_occupant
	if(!ishuman(occupant))
		return
	if(!hasHUD(user,"medical"))
		return
	for(var/datum/data/record/medical_record AS in GLOB.datacore.medical)
		if(medical_record.fields["name"] != occupant.real_name)
			continue
		if(!(medical_record.fields["last_scan_time"]))
			. += span_deptradio("No scan report on record")
		else
			. += span_deptradio("<a href='byond://?src=[text_ref(src)];scanreport=1'>Scan from [medical_record.fields["last_scan_time"]]</a>")
		break
	if(occupant.stat != DEAD)
		return
	var/timer = 0 // variable for DNR timer check
	timer = (TIME_BEFORE_DNR-(occupant.dead_ticks))*2 //Time to DNR left in seconds
	if(!occupant.mind && !occupant.get_ghost(TRUE) || occupant.dead_ticks > TIME_BEFORE_DNR)//We couldn't find a suitable ghost or patient has passed their DNR timer or suicided, this means the person is not returning
		. += span_scanner("Patient is DNR")
	else if(!occupant.mind && occupant.get_ghost(TRUE)) // Ghost is available but outside of the body
		. += span_scanner("Defib patient to check departed status")
		. += span_scanner("Patient have [timer] seconds left before DNR")
	else if(!occupant.client) //Mind is in the body but no client, most likely currently disconnected.
		. += span_scanner("Patient is almost departed")
		. += span_scanner("Patient have [timer] seconds left before DNR")
	else
		. += span_scanner("Patient have [timer] seconds left before DNR")

/obj/structure/closet/bodybag/cryobag/Topic(href, href_list)
	. = ..()
	if(.)
		return
	if(href_list["scanreport"])
		if(!hasHUD(usr,"medical"))
			return
		if(get_dist(usr, src) > WORLD_VIEW_NUM)
			to_chat(usr, span_warning("[src] is too far away."))
			return
		for(var/datum/data/record/R in GLOB.datacore.medical)
			if(R.fields["name"] != bodybag_occupant.real_name)
				continue
			if(R.fields["last_scan_time"] && R.fields["last_scan_result"])
				var/datum/browser/popup = new(usr, "scanresults", "<div align='center'>Last Scan Result</div>", 430, 600)
				popup.set_content(R.fields["last_scan_result"])
				popup.open(FALSE)
			break

/obj/item/trash/used_stasis_bag
	name = "used stasis bag"
	icon = 'icons/obj/cryobag.dmi'
	icon_state = "bodybag_used"
	desc = "It's been ripped open. You will need to find a machine capable of recycling it."

//MARINE SNIPER TARPS

/obj/item/bodybag/tarp
	name = "\improper V1 thermal-dampening tarp (folded)"
	desc = "A tarp carried by TGMC Snipers. When laying underneath the tarp, the sniper is almost indistinguishable from the landscape if utilized correctly. The tarp contains a thermal-dampening weave to hide the wearer's heat signatures, optical camoflauge, and smell dampening."
	icon = 'icons/obj/bodybag.dmi'
	icon_state = "jungletarp_folded"
	w_class = WEIGHT_CLASS_SMALL
	unfoldedbag_path = /obj/structure/closet/bodybag/tarp
	var/serial_number //Randomized serial number used to stop point macros and such.

/obj/item/bodybag/tarp/Initialize(mapload, unfoldedbag)
	. = ..()
	if(!serial_number) //Give a random serial number in order to ward off auto-point macros
		serial_number = "[uppertext(pick(GLOB.alphabet))][rand(1000,100000)]-SN"
		name = "\improper [serial_number] [initial(name)]"

/obj/item/bodybag/tarp/deploy_bodybag(mob/user, atom/location)
	. = ..()
	var/obj/structure/closet/bodybag/tarp/unfolded_tarp = unfoldedbag_instance
	if(!unfolded_tarp.serial_number)
		unfolded_tarp.serial_number = serial_number //Set the serial number
		unfolded_tarp.name = "\improper [serial_number] [unfolded_tarp.name]" //Set the name with the serial number

/obj/item/bodybag/tarp/unique_action(mob/user)
	. = ..()
	deploy_bodybag(user, get_turf(user))
	unfoldedbag_instance.close()
	return TRUE

/obj/item/bodybag/tarp/snow
	icon = 'icons/obj/bodybag.dmi'
	icon_state = "snowtarp_folded"
	unfoldedbag_path = /obj/structure/closet/bodybag/tarp/snow

/obj/structure/closet/bodybag/tarp
	name = "\improper V1 thermal-dampening tarp"
	bag_name = "V1 thermal-dampening tarp"
	desc = "An active camo tarp carried by TGMC Snipers. When laying underneath the tarp, the sniper is almost indistinguishable from the landscape if utilized correctly. The tarp contains a thermal-dampening weave to hide the wearer's heat signatures, optical camouflage, and smell dampening."
	icon = 'icons/obj/bodybag.dmi'
	icon_state = "jungletarp_closed"
	icon_closed = "jungletarp_closed"
	icon_opened = "jungletarp_open"
	open_sound = 'sound/effects/vegetation_walk_1.ogg'
	close_sound = 'sound/effects/vegetation_walk_2.ogg'
	foldedbag_path = /obj/item/bodybag/tarp
	closet_stun_delay = 0.5 SECONDS //Short delay to prevent ambushes from being too degenerate.
	display_name = FALSE
	var/serial_number //Randomized serial number used to stop point macros and such.

/obj/structure/closet/bodybag/tarp/close()
	. = ..()
	if(!opened && bodybag_occupant)
		anchored = TRUE
		playsound(loc,'sound/effects/cloak_scout_on.ogg', 15, 1) //stealth mode engaged!
		animate(src, alpha = 13, time = 3 SECONDS) //Fade out gradually.
		bodybag_occupant.alpha = 0
		RegisterSignals(bodybag_occupant, list(COMSIG_MOB_DEATH, COMSIG_PREQDELETED), PROC_REF(on_bodybag_occupant_death))

/obj/structure/closet/bodybag/tarp/open()
	anchored = FALSE
	if(alpha != initial(alpha))
		playsound(loc,'sound/effects/cloak_scout_off.ogg', 15, 1)
		alpha = initial(alpha) //stealth mode disengaged
		animate(src) //Cancel the fade out if still ongoing.
	if(bodybag_occupant)
		UnregisterSignal(bodybag_occupant, list(COMSIG_MOB_DEATH, COMSIG_PREQDELETED))
		bodybag_occupant.alpha = initial(bodybag_occupant.alpha)
	return ..()

/obj/structure/closet/bodybag/tarp/closet_special_handling(mob/living/mob_to_stuff) // overriding this
	if(!ishuman(mob_to_stuff))
		return FALSE //Humans only.
	if(mob_to_stuff.stat == DEAD) //Only the dead for bodybags.
		return FALSE
	return TRUE

/obj/structure/closet/bodybag/tarp/proc/on_bodybag_occupant_death(mob/source, gibbing)
	SIGNAL_HANDLER
	open()

/obj/structure/closet/bodybag/tarp/MouseDrop(over_object, src_location, over_location)
	. = ..()
	var/obj/item/bodybag/tarp/folded_tarp = foldedbag_instance
	if(!folded_tarp.serial_number)
		folded_tarp.serial_number = serial_number //Set the serial number
		folded_tarp.name = "\improper [serial_number] [initial(folded_tarp.name)]" //Set the name with the serial number

/obj/structure/closet/bodybag/tarp/snow
	icon_state = "snowtarp_closed"
	icon_closed = "snowtarp_closed"
	icon_opened = "snowtarp_open"
	foldedbag_path = /obj/item/bodybag/tarp/snow
