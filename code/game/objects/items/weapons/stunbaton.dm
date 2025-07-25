/obj/item/weapon/baton
	name = "stunbaton"
	desc = "A stun baton for incapacitating people with."
	icon_state = "stunbaton"
	worn_icon_state = "baton"
	equip_slot_flags = ITEM_SLOT_BELT
	force = 15
	sharp = 0
	edge = 0
	throwforce = 7
	w_class = WEIGHT_CLASS_NORMAL
	attack_verb = list("beats")
	req_one_access = list(ACCESS_MARINE_BRIG, ACCESS_MARINE_ARMORY, ACCESS_MARINE_CAPTAIN, ACCESS_NT_CORPORATE, ACCESS_NT_PMC_GREEN)
	var/stunforce = 10
	var/agonyforce = 80
	///whether the thing is on or not
	var/status = 0
	var/obj/item/cell/bcell = null
	///oh god why do power cells carry so much charge? We probably need to make a distinction between "industrial" sized power cells for APCs and power cells for everything else.
	var/hitcost = 1000
	///whether the baton prevents people without correct access from using it.
	var/has_user_lock = TRUE

/obj/item/weapon/baton/Initialize(mapload)
	. = ..()
	bcell = new/obj/item/cell/high(src)
	update_icon()

/obj/item/weapon/baton/proc/deductcharge(chrgdeductamt)
	if(!bcell)
		return
	if(bcell.use(chrgdeductamt))
		return TRUE
	status = 0
	update_icon()
	return FALSE

/obj/item/weapon/baton/update_icon_state()
	. = ..()
	if(status)
		icon_state = "[initial(name)]_active"
	else if(!bcell)
		icon_state = "[initial(name)]_nocell"
	else
		icon_state = "[initial(name)]"

/obj/item/weapon/baton/examine(mob/user)
	. = ..()
	if(bcell)
		. += span_notice("The baton is [round(bcell.percent())]% charged.")
	else
		. += span_warning("The baton does not have a power source installed.")

/obj/item/weapon/baton/attack_hand(mob/living/user)
	. = ..()
	if(.)
		return
	check_user_auth(user)

/obj/item/weapon/baton/equipped(mob/user, slot)
	. = ..()
	check_user_auth(user)

//checks if the mob touching the baton has proper access
/obj/item/weapon/baton/proc/check_user_auth(mob/user)
	if(!has_user_lock)
		return TRUE
	var/mob/living/carbon/human/H = user
	if(istype(H))
		var/obj/item/card/id/I = H.wear_id
		if(!istype(I) || !check_access(I))
			H.visible_message(span_notice(" [src] beeeps as [H] picks it up"), span_danger("WARNING: Unauthorized user detected. Denying access..."))
			H.Paralyze(40 SECONDS)
			H.visible_message(span_warning("[src] beeps and sends a shock through [H]'s body!"))
			deductcharge(hitcost)
			return FALSE
	return TRUE

/obj/item/weapon/baton/pull_response(mob/puller)
	return check_user_auth(puller)

/obj/item/weapon/baton/attackby(obj/item/I, mob/user, params)
	. = ..()
	if(.)
		return

	if(istype(I, /obj/item/cell))
		if(bcell)
			to_chat(user, span_notice("[src] already has a cell."))
			return

		if(!user.drop_held_item())
			return

		I.forceMove(src)
		bcell = I
		to_chat(user, span_notice("You install a cell in [src]."))

	else if(isscrewdriver(I))
		if(!bcell)
			return

		bcell.forceMove(get_turf(src))
		bcell.update_icon()
		bcell = null
		to_chat(user, span_notice("You remove the cell from the [src]."))
		status = 0

	update_icon()

/obj/item/weapon/baton/attack_self(mob/user)
	if(has_user_lock && user.skills.getRating(SKILL_POLICE) < SKILL_POLICE_MP)
		to_chat(user, span_warning("You don't seem to know how to use [src]..."))
		return
	if(bcell?.charge > hitcost)
		status = !status
		to_chat(user, span_notice("[src] is now [status ? "on" : "off"]."))
		playsound(loc, SFX_SPARKS, 25, 1, 6)
		update_icon()
	else
		status = 0
		if(!bcell)
			to_chat(user, span_warning("[src] does not have a power source!"))
		else
			to_chat(user, span_warning("[src] is out of charge."))

/obj/item/weapon/baton/attack(mob/M, mob/user)
	if(M.status_flags & INCORPOREAL || user.status_flags & INCORPOREAL) //Incorporeal beings cannot attack or be attacked
		return

	if(has_user_lock && user.skills.getRating(SKILL_POLICE) < SKILL_POLICE_MP)
		to_chat(user, span_warning("You don't seem to know how to use [src]..."))
		return

	var/stamloss_applied = agonyforce
	var/stun_applied = stunforce
	var/mob/living/L = M

	var/target_zone = check_zone(user.zone_selected)
	if(user.a_intent == INTENT_HARM)
		if (!..())	//item/attack() does it's own messaging and logs
			return 0	// item/attack() will return 1 if they hit, 0 if they missed.
		stamloss_applied *= 0.5	//whacking someone causes a much poorer contact than prodding them.
		stun_applied *= 0.5
		//we can't really extract the actual hit zone from ..(), unfortunately. Just act like they attacked the area they intended to.
	else
		//copied from human_defense.dm - human defence code should really be refactored some time.
		if (ishuman(L))

			if (user != L) // Attacking yourself can't miss
				target_zone = get_zone_with_miss_chance(user.zone_selected, L)

			if(!target_zone)
				L.visible_message(span_danger("[user] misses [L] with \the [src]!"))
				return 0

			var/mob/living/carbon/human/H = L
			var/datum/limb/affecting = H.get_limb(target_zone)
			if (affecting)
				if(!status)
					L.visible_message(span_warning("[L] has been prodded in the [affecting.display_name] with [src] by [user]. Luckily it was off."))
					return 1
				else
					H.visible_message(span_danger("[L] has been prodded in the [affecting.display_name] with [src] by [user]!"))
		else
			if(!status)
				L.visible_message(span_warning("[L] has been prodded with [src] by [user]. Luckily it was off."))
				return 1
			else
				L.visible_message(span_danger("[L] has been prodded with [src] by [user]!"))

	//stun effects
	if(!HAS_TRAIT(L, TRAIT_BATONIMMUNE))
		L.apply_effects(stun = stun_applied, stutter = stamloss_applied * 0.1, eye_blur = stamloss_applied * 0.1, stamloss = stamloss_applied)
		L.ParalyzeNoChain(8 SECONDS)

	playsound(loc, 'sound/weapons/egloves.ogg', 25, 1, 6)
	log_combat(user, L, "stunned", src)

	deductcharge(hitcost)

	return TRUE

/obj/item/weapon/baton/emp_act(severity)
	. = ..()
	if(bcell)
		bcell.emp_act(severity)	//let's not duplicate code everywhere if we don't have to please.

//Makeshift stun baton. Replacement for stun gloves.
/obj/item/weapon/baton/cattleprod
	name = "stunprod"
	desc = "An improvised stun baton."
	icon_state = "stunprod_nocell"
	worn_icon_state = "prod"
	force = 3
	throwforce = 5
	stunforce = 0
	agonyforce = 60	//same force as a stunbaton, but uses way more charge.
	hitcost = 2500
	attack_verb = list("pokes")
	equip_slot_flags = NONE
	has_user_lock = FALSE

/obj/item/weapon/stunprod
	name = "electrified prodder"
	desc = "A specialised prod designed for incapacitating xenomorphic lifeforms with."
	icon_state = "stunbaton"
	worn_icon_state = "baton"
	equip_slot_flags = ITEM_SLOT_BELT
	force = 12
	throwforce = 7
	w_class = WEIGHT_CLASS_NORMAL
	var/charges = 12
	var/status = 0

/obj/item/weapon/stunprod/update_icon_state()
	. = ..()
	if(status)
		icon_state = "stunbaton_active"
	else
		icon_state = "stunbaton"

/obj/item/weapon/stunprod/attack_self(mob/user)
	if(charges > 0)
		status = !status
		to_chat(user, span_notice("\The [src] is now [status ? "on" : "off"]."))
		playsound(loc, SFX_SPARKS, 15, 1)
		update_icon()
	else
		status = 0
		to_chat(user, span_warning("\The [src] is out of charge."))

/obj/item/weapon/stunprod/attack(mob/M, mob/user)
	if(user.a_intent == INTENT_HARM)
		return

	else if(!status)
		M.visible_message(span_warning("[M] has been poked with [src] whilst it's turned off by [user]."))
		return

	if(status && isliving(M))
		var/mob/living/L = M
		L.Paralyze(12 SECONDS)
		charges -= 2
		L.visible_message(span_danger("[L] has been prodded with the [src] by [user]!"))

		log_combat(user, L, "stunned", src)

		playsound(loc, 'sound/weapons/egloves.ogg', 25, 1)
		if(charges < 1)
			status = 0
			update_icon()

/obj/item/weapon/stunprod/emp_act(severity)
	. = ..()
	if(severity == EMP_DEVASTATE)
		charges = 0
	else
		charges = max(0, charges - (6 - severity))
	if(charges < 1)
		status = 0
		update_icon()

/obj/item/weapon/stunprod/improved
	charges = 30
	name = "improved electrified prodder"
	desc = "A specialised prod designed for incapacitating xenomorphic lifeforms with. This one seems to be much more effective than its predecessor."
	color = "#FF6666"

/obj/item/weapon/stunprod/improved/attack(mob/M, mob/user)
	. = ..()
	if(!isliving(M))
		return
	var/mob/living/L = M
	L.Paralyze(28 SECONDS)

/obj/item/weapon/stunprod/improved/examine(mob/user)
	. = ..()
	. += span_notice("It has [charges] charges left.")
