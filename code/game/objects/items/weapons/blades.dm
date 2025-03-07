/* Weapons
* Contains:
*		Claymore
*		mercsword
*		Energy Shield
*		Energy Shield
*		Energy Shield
*		Ceremonial Sword
*		M2132 machete
*		Officers sword
*		Commissars sword
*		Katana
*		M5 survival knife
*		Upp Type 30 survival knife
*		M11 throwing knife
*		Chainsword
*/


/obj/item/weapon/claymore
	name = "claymore"
	desc = "What are you standing around staring at this for? Get to killing!"
	icon_state = "claymore"
	item_state = "claymore"
	atom_flags = CONDUCT
	equip_slot_flags = ITEM_SLOT_BELT
	force = 40
	throwforce = 10
	sharp = IS_SHARP_ITEM_BIG
	edge = 1
	w_class = WEIGHT_CLASS_NORMAL
	attack_verb = list("attacked", "slashed", "stabbed", "sliced", "torn", "ripped", "diced", "cut")
	hitsound = 'sound/weapons/bladeslice.ogg'
	///Special attack action granted to users with the right trait
	var/datum/action/ability/activable/weapon_skill/sword_lunge/special_attack

/obj/item/weapon/claymore/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/scalping)
	special_attack = new(src, force, penetration)

/obj/item/weapon/claymore/Destroy()
	QDEL_NULL(special_attack)
	return ..()

/obj/item/weapon/claymore/equipped(mob/user, slot)
	. = ..()
	if(user.skills.getRating(SKILL_MELEE_WEAPONS) > SKILL_MELEE_DEFAULT)
		special_attack.give_action(user)

/obj/item/weapon/claymore/dropped(mob/user)
	. = ..()
	special_attack?.remove_action(user)

//Special attack
/datum/action/ability/activable/weapon_skill/sword_lunge
	name = "Lunging strike"
	action_icon_state = "sword_lunge"
	desc = "A powerful leaping strike. Cannot stun."
	ability_cost = 8
	cooldown_duration = 6 SECONDS
	keybinding_signals = list(
		KEYBINDING_NORMAL = COMSIG_WEAPONABILITY_SWORDLUNGE,
	)

/datum/action/ability/activable/weapon_skill/sword_lunge/use_ability(atom/A)
	var/mob/living/carbon/carbon_owner = owner

	RegisterSignal(carbon_owner, COMSIG_MOVABLE_MOVED, PROC_REF(movement_fx))
	RegisterSignals(carbon_owner, list(COMSIG_MOVABLE_IMPACT, COMSIG_MOVABLE_BUMP), PROC_REF(lunge_impact))
	RegisterSignal(carbon_owner, COMSIG_MOVABLE_POST_THROW, PROC_REF(charge_complete))

	carbon_owner.visible_message(span_danger("[carbon_owner] charges towards \the [A]!"))
	playsound(owner, "sound/effects/alien_tail_swipe2.ogg", 50, 0, 4)
	carbon_owner.throw_at(A, 2, 1, carbon_owner)
	succeed_activate()
	add_cooldown()

///Create an after image
/datum/action/ability/activable/weapon_skill/sword_lunge/proc/movement_fx()
	SIGNAL_HANDLER
	new /obj/effect/temp_visual/after_image(get_turf(owner), owner)

///Unregisters signals after lunge complete
/datum/action/ability/activable/weapon_skill/sword_lunge/proc/charge_complete()
	SIGNAL_HANDLER
	UnregisterSignal(owner, list(COMSIG_MOVABLE_IMPACT, COMSIG_MOVABLE_BUMP, COMSIG_MOVABLE_POST_THROW, COMSIG_MOVABLE_MOVED))

///Sig handler for atom impacts during lunge
/datum/action/ability/activable/weapon_skill/sword_lunge/proc/lunge_impact(datum/source, obj/target, speed)
	SIGNAL_HANDLER
	INVOKE_ASYNC(src, PROC_REF(do_lunge_impact), source, target)
	charge_complete()

///Actual effects of lunge impact
/datum/action/ability/activable/weapon_skill/sword_lunge/proc/do_lunge_impact(datum/source, obj/target)
	var/mob/living/carbon/carbon_owner = source
	if(isobj(target))
		var/obj/obj_victim = target
		obj_victim.take_damage(damage, BRUTE, MELEE, TRUE, TRUE, get_dir(obj_victim, carbon_owner), penetration, carbon_owner)
		if(!obj_victim.anchored && obj_victim.move_resist < MOVE_FORCE_VERY_STRONG)
			obj_victim.knockback(carbon_owner, 1, 2)
	else if(ishuman(target))
		var/mob/living/carbon/human/human_victim = target
		human_victim.apply_damage(damage, BRUTE, BODY_ZONE_CHEST, MELEE, TRUE, TRUE, TRUE, penetration)
		human_victim.adjust_stagger(1 SECONDS)
		playsound(human_victim, "sound/weapons/wristblades_hit.ogg", 25, 0, 5)
		shake_camera(human_victim, 2, 1)

/obj/item/weapon/claymore/mercsword
	name = "combat sword"
	desc = "A dusty sword commonly seen in historical museums. Where you got this is a mystery, for sure. Only a mercenary would be nuts enough to carry one of these. Sharpened to deal massive damage."
	icon_state = "mercsword"
	item_state = "machete"
	force = 39

/obj/item/weapon/claymore/mercsword/captain
	name = "Ceremonial Sword"
	desc = "A fancy ceremonial sword passed down from generation to generation. Despite this, it has been very well cared for, and is in top condition."
	icon_state = "mercsword"
	item_state = "machete"
	force = 55

/obj/item/weapon/claymore/mercsword/officersword
	icon_state = "officer_sword"
	item_state = "officer_sword"
	force = 80
	attack_speed = 5
	sharp = IS_SHARP_ITEM_ACCURATE
	hitsound = 'sound/weapons/rapierhit.ogg'
	attack_verb = list("slash", "cut")
	w_class = WEIGHT_CLASS_BULKY

/obj/item/weapon/claymore/mercsword/officersword/equipped(mob/user, slot)
	. = ..()
	toggle_item_bump_attack(user, TRUE)

/obj/item/weapon/claymore/mercsword/officersword/dropped(mob/user)
	. = ..()
	toggle_item_bump_attack(user, FALSE)

/obj/item/weapon/claymore/mercsword/officersword/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/strappable)

/obj/item/weapon/claymore/mercsword/officersword/sabre
	name = "\improper ceremonial officer sabre"
	desc = "Gold plated, smoked dark wood handle, your name on it, what else do you need?"
	icon = 'icons/obj/items/weapons.dmi'
	item_icons = list(
		slot_l_hand_str = 'icons/mob/inhands/weapons/melee_left.dmi',
		slot_r_hand_str = 'icons/mob/inhands/weapons/melee_right.dmi',
	)
	icon_state = "saber"
	item_state = "saber"

/obj/item/weapon/claymore/mercsword/machete
	name = "\improper M2132 machete"
	desc = "Latest issue of the TGMC Machete. Great for clearing out jungle or brush on outlying colonies. Found commonly in the hands of scouts and trackers, but difficult to carry with the usual kit."
	icon_state = "machete"
	attack_speed = 12
	w_class = WEIGHT_CLASS_BULKY
	force = 90
	penetration = 15
	icon = 'icons/obj/items/weapons.dmi'
	item_icons = list(
		slot_back_str = 'icons/mob/clothing/back.dmi',
		slot_l_hand_str = 'icons/mob/inhands/weapons/melee_left.dmi',
		slot_r_hand_str = 'icons/mob/inhands/weapons/melee_right.dmi',
		slot_belt_str = 'icons/mob/suit_slot.dmi'
	)
	equip_slot_flags = ITEM_SLOT_BELT|ITEM_SLOT_BACK

/obj/item/weapon/claymore/mercsword/machete/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/strappable)

/obj/item/weapon/claymore/mercsword/machete/equipped(mob/user, slot)
	. = ..()
	toggle_item_bump_attack(user, TRUE)

/obj/item/weapon/claymore/mercsword/machete/dropped(mob/user)
	. = ..()
	toggle_item_bump_attack(user, FALSE)

/obj/item/weapon/claymore/mercsword/machete/alt
	name = "machete"
	desc = "A nice looking machete. Great for clearing out jungle or brush on outlying colonies. Found commonly in the hands of scouts and trackers, but difficult to carry with the usual kit."
	icon_state = "machete_alt"

/obj/item/weapon/claymore/tomahawk
	name = "Tomahawk H23"
	desc = "A specialist tactical weapon, ancient and beloved by many. Issued to TGMC by CAU."
	icon = 'icons/obj/items/weapons.dmi'
	icon_state = "tomahawk_tactic"
	item_state = "tomahawk_tactic"
	item_icons = list(
		slot_back_str = 'icons/mob/clothing/back.dmi',
		slot_l_hand_str = 'icons/mob/items_lefthand_64.dmi',
		slot_r_hand_str = 'icons/mob/items_righthand_64.dmi',
	)
	inhand_x_dimension = 64
	inhand_y_dimension = 32
	atom_flags = CONDUCT
	equip_slot_flags = ITEM_SLOT_BELT|ITEM_SLOT_BACK
	force = 70
	attack_speed = 8
	throwforce = 130 //throw_dmg = throwforce * (throw_speed * 0.2)
	throw_range = 9
	throw_speed = 5
	sharp = IS_SHARP_ITEM_BIG
	edge = 1
	w_class = WEIGHT_CLASS_BULKY

	///The person throwing tomahawk
	var/mob/living/living_user

/obj/item/weapon/claymore/tomahawk/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/strappable)

/obj/item/weapon/claymore/tomahawk/equipped(mob/user, slot)
	. = ..()
	toggle_item_bump_attack(user, TRUE)
	if(!living_user)
		living_user = user
		RegisterSignal(user, COMSIG_MOB_MOUSEDOWN, PROC_REF(try_throw))

/obj/item/weapon/claymore/tomahawk/dropped(mob/user)
	. = ..()
	toggle_item_bump_attack(user, FALSE)
	if(living_user)
		living_user = null
		UnregisterSignal(user, COMSIG_MOB_MOUSEDOWN)

/obj/item/weapon/claymore/tomahawk/proc/try_throw(datum/source, atom/object, turf/location, control, params, bypass_checks = FALSE)
	SIGNAL_HANDLER

	var/list/modifiers = params2list(params)
	if(modifiers["shift"])
		return

	if(modifiers["middle"])
		return

	if(living_user.get_active_held_item() != src) // If the object in our active hand is not atomahawk, abort
		return

	if(modifiers["right"])
		//handle strapping
		if(HAS_TRAIT_FROM(src, TRAIT_NODROP, STRAPPABLE_ITEM_TRAIT))
			REMOVE_TRAIT(src, TRAIT_NODROP, STRAPPABLE_ITEM_TRAIT)
		living_user.throw_item(get_turf_on_clickcatcher(object, living_user, params))
		return

/obj/item/weapon/claymore/tomahawk/classic
	name = "Tomahawk H17"
	desc = "A specialist tactical weapon, very ancient and beloved by many. Issued to Delta by CAU."
	icon_state = "tomahawk_classic"
	item_state = "tomahawk_classic"

//FC's sword.

/obj/item/weapon/claymore/mercsword/machete/officersword
	name = "\improper Officers sword"
	desc = "This appears to be a rather old blade that has been well taken care of, it is probably a family heirloom. Oddly despite its probable non-combat purpose it is sharpened and not blunt."
	icon_state = "officer_sword"
	item_state = "officer_sword"
	attack_speed = 11
	penetration = 15

/obj/item/weapon/claymore/mercsword/commissar_sword
	name = "\improper commissars sword"
	desc = "The pride of an imperial commissar, held high as they charge into battle."
	icon_state = "comsword"
	item_state = "comsword"
	force = 80
	attack_speed = 10
	w_class = WEIGHT_CLASS_BULKY

/obj/item/weapon/claymore/attack(mob/living/carbon/M as mob, mob/living/carbon/user as mob)
	playsound(loc, 'sound/weapons/bladeslice.ogg', 25, 1)
	return ..()

/obj/item/weapon/katana
	name = "katana"
	desc = "A finely made Japanese sword, with a well sharpened blade. The blade has been filed to a molecular edge, and is extremely deadly. Commonly found in the hands of mercenaries and yakuza."
	icon_state = "katana"
	atom_flags = CONDUCT
	force = 50
	throwforce = 10
	sharp = IS_SHARP_ITEM_BIG
	edge = 1
	w_class = WEIGHT_CLASS_NORMAL
	attack_verb = list("attacked", "slashed", "stabbed", "sliced", "torn", "ripped", "diced", "cut")

//To do: replace the toys.
/obj/item/weapon/katana/replica
	name = "replica katana"
	desc = "A cheap knock-off commonly found in regular knife stores. Can still do some damage."
	force = 27
	throwforce = 7

/obj/item/weapon/katana/samurai
	name = "\improper tachi"
	desc = "A genuine replica of an ancient blade. This one is in remarkably good condition. It could do some damage to everyone, including yourself."
	icon_state = "samurai_open"
	force = 60
	attack_speed = 12
	w_class = WEIGHT_CLASS_BULKY


/obj/item/weapon/katana/attack(mob/living/carbon/M as mob, mob/living/carbon/user as mob)
	playsound(loc, 'sound/weapons/bladeslice.ogg', 25, 1)
	return ..()


/obj/item/tool/kitchen/knife/shiv
	name = "glass shiv"
	icon = 'icons/obj/items/weapons.dmi'
	icon_state = "shiv"
	desc = "A makeshift glass shiv."
	attack_verb = list("shanked", "shived")
	hitsound = 'sound/weapons/slash.ogg'

/obj/item/tool/kitchen/knife/shiv/plasma
	icon_state = "plasmashiv"
	desc = "A makeshift plasma glass shiv."

/obj/item/tool/kitchen/knife/shiv/titanium
	icon_state = "titaniumshiv"
	desc = "A makeshift titanium shiv."

/obj/item/tool/kitchen/knife/shiv/plastitanium
	icon_state = "plastitaniumshiv"
	desc = "A makeshift plastitanium glass shiv."

/obj/item/weapon/combat_knife
	name = "\improper M5 survival knife"
	icon = 'icons/obj/items/weapons.dmi'
	item_icons = list(
		slot_l_hand_str = 'icons/mob/inhands/weapons/melee_left.dmi',
		slot_r_hand_str = 'icons/mob/inhands/weapons/melee_right.dmi',
	)
	icon_state = "combat_knife"
	item_state = "combat_knife"
	desc = "A standard survival knife of high quality. You can slide this knife into your boots, and can be field-modified to attach to the end of a rifle with cable coil."
	atom_flags = CONDUCT
	sharp = IS_SHARP_ITEM_ACCURATE
	force = 30
	w_class = WEIGHT_CLASS_SMALL
	throwforce = 20
	throw_speed = 3
	throw_range = 6
	attack_speed = 8
	hitsound = 'sound/weapons/slash.ogg'
	attack_verb = list("slashed", "stabbed", "sliced", "torn", "ripped", "diced", "cut")

/obj/item/weapon/combat_knife/attackby(obj/item/I, mob/user)
	if(!istype(I,/obj/item/stack/cable_coil))
		return ..()
	var/obj/item/stack/cable_coil/CC = I
	if(!CC.use(5))
		to_chat(user, span_notice("You don't have enough cable for that."))
		return
	to_chat(user, "You wrap some cable around the bayonet. It can now be attached to a gun.")
	if(loc == user)
		user.temporarilyRemoveItemFromInventory(src)
	var/obj/item/attachable/bayonet/F = new(src.loc)
	user.put_in_hands(F) //This proc tries right, left, then drops it all-in-one.
	if(F.loc != user) //It ended up on the floor, put it whereever the old flashlight is.
		F.loc = get_turf(src)
	qdel(src) //Delete da old knife

/obj/item/weapon/combat_knife/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/scalping)
	AddElement(/datum/element/shrapnel_removal, 12 SECONDS, 12 SECONDS, 10)

/obj/item/weapon/combat_knife/upp
	name = "\improper Type 30 survival knife"
	icon_state = "upp_knife"
	item_state = "knife"
	desc = "The standard issue survival knife of the UPP forces, the Type 30 is effective, but humble. It is small enough to be non-cumbersome, but lethal none-the-less."
	force = 20
	throwforce = 10
	throw_speed = 2
	throw_range = 8

/obj/item/weapon/combat_knife/nkvd
	name = "\improper Finka NKVD"
	icon_state = "upp_knife"
	item_state = "combat_knife"
	desc = "Legendary Finka NKVD model 1934 with a 10-year warranty and delivery within 2 days."
	force = 40
	throwforce = 50
	throw_speed = 2
	throw_range = 8

/obj/item/weapon/karambit
	name = "karambit"
	icon = 'icons/obj/items/weapons.dmi'
	icon_state = "karambit"
	item_state = "karambit"
	desc = "A small high quality knife with a curved blade, good for slashing and hooking. This one has a mottled red finish."
	atom_flags = CONDUCT
	sharp = IS_SHARP_ITEM_ACCURATE
	force = 30
	w_class = WEIGHT_CLASS_SMALL
	throwforce = 20
	throw_speed = 3
	throw_range = 6
	attack_speed = 8
	hitsound = 'sound/weapons/slash.ogg'
	attack_verb = list("slashed", "stabbed", "sliced", "torn", "ripped", "diced", "cut", "hooked")

//Try to do a fancy trick with your cool knife
/obj/item/weapon/karambit/attack_self(mob/user)
	. = ..()
	if(!user.dextrous)
		to_chat(user, span_warning("You don't have the dexterity to do this."))
		return
	if(user.incapacitated() || !isturf(user.loc))
		to_chat(user, span_warning("You can't do this right now."))
		return
	if(user.do_actions)
		return
	do_trick(user)

/obj/item/weapon/karambit/fade
	icon = 'icons/obj/items/weapons.dmi'
	icon_state = "karambit_fade"
	item_state = "karambit_fade"
	desc = "A small high quality knife with a curved blade, good for slashing and hooking. This one has been painted by airbrushing transparent paints that fade together over a chrome base coat."

/obj/item/weapon/karambit/case_hardened
	icon = 'icons/obj/items/weapons.dmi'
	icon_state = "karambit_case_hardened"
	item_state = "karambit_case_hardened"
	desc = "A small high quality knife with a curved blade, good for slashing and hooking. This one has been color case-hardened through the application of wood charcoal at high temperatures."

/obj/item/stack/throwing_knife
	name ="\improper M11 throwing knife"
	icon='icons/obj/items/weapons.dmi'
	icon_state = "throwing_knife"
	desc="A military knife designed to be thrown at the enemy. Much quieter than a firearm, but requires a steady hand to be used effectively."
	stack_name = "pile"
	singular_name = "knife"
	atom_flags = CONDUCT|DIRLOCK
	sharp = IS_SHARP_ITEM_ACCURATE
	force = 20
	w_class = WEIGHT_CLASS_TINY
	throwforce = 25
	throw_speed = 5
	throw_range = 7
	hitsound = 'sound/weapons/slash.ogg'
	attack_verb = list("slashed", "stabbed", "sliced", "torn", "ripped", "diced", "cut")
	equip_slot_flags = ITEM_SLOT_POCKET

	max_amount = 5
	amount = 5
	///Delay between throwing.
	var/throw_delay = 0.2 SECONDS
	///Current Target that knives are being thrown at. This is for aiming
	var/current_target
	///The person throwing knives
	var/mob/living/living_user

/obj/item/stack/throwing_knife/Initialize(mapload, new_amount)
	. = ..()
	RegisterSignal(src, COMSIG_MOVABLE_POST_THROW, PROC_REF(post_throw))
	AddComponent(/datum/component/automatedfire/autofire, throw_delay, _fire_mode = GUN_FIREMODE_AUTOMATIC, _callback_reset_fire = CALLBACK(src, PROC_REF(stop_fire)), _callback_fire = CALLBACK(src, PROC_REF(throw_knife)))

/obj/item/stack/throwing_knife/update_icon_state()
	. = ..()
	icon_state = "throwing_knife_[amount]"

/obj/item/stack/throwing_knife/equipped(mob/user, slot)
	. = ..()
	if(user.get_active_held_item() != src && user.get_inactive_held_item() != src)
		return
	living_user = user
	RegisterSignal(user, COMSIG_MOB_MOUSEDRAG, PROC_REF(change_target))
	RegisterSignal(user, COMSIG_MOB_MOUSEUP, PROC_REF(stop_fire))
	RegisterSignal(user, COMSIG_MOB_MOUSEDOWN, PROC_REF(start_fire))

/obj/item/stack/throwing_knife/unequipped(mob/unequipper, slot)
	. = ..()
	living_user?.client?.mouse_pointer_icon = initial(living_user.client.mouse_pointer_icon) // Force resets the mouse pointer to default so it defaults when the last knife is thrown
	UnregisterSignal(unequipper, COMSIG_MOB_ITEM_AFTERATTACK)
	UnregisterSignal(unequipper, list(COMSIG_MOB_MOUSEUP, COMSIG_MOB_MOUSEDRAG, COMSIG_MOB_MOUSEDOWN))
	living_user = null

///Changes the current target.
/obj/item/stack/throwing_knife/proc/change_target(datum/source, atom/src_object, atom/over_object, turf/src_location, turf/over_location, src_control, over_control, params)
	SIGNAL_HANDLER
	set_target(get_turf_on_clickcatcher(over_object, source, params))
	living_user.face_atom(current_target)

///Stops the Autofire component and resets the current cursor.
/obj/item/stack/throwing_knife/proc/stop_fire()
	SIGNAL_HANDLER
	living_user?.client?.mouse_pointer_icon = initial(living_user.client.mouse_pointer_icon)
	set_target(null)
	SEND_SIGNAL(src, COMSIG_GUN_STOP_FIRE)

///Starts the user firing.
/obj/item/stack/throwing_knife/proc/start_fire(datum/source, atom/object, turf/location, control, params)
	SIGNAL_HANDLER
	if(living_user.get_active_held_item() != src) // If the object in our active hand is not a throwing knife, abort
		return
	var/list/modifiers = params2list(params)
	if(modifiers["shift"] || modifiers["ctrl"])
		return
	if(QDELETED(object))
		return
	set_target(get_turf_on_clickcatcher(object, living_user, params))
	if(!current_target)
		return
	SEND_SIGNAL(src, COMSIG_GUN_FIRE)
	living_user?.client?.mouse_pointer_icon = 'icons/effects/supplypod_target.dmi'

///Throws a knife from the stack, or, if the stack is one, throws the stack.
/obj/item/stack/throwing_knife/proc/throw_knife()
	SIGNAL_HANDLER
	if(living_user?.get_active_held_item() != src)
		return
	if(living_user?.Adjacent(current_target))
		return AUTOFIRE_CONTINUE
	var/thrown_thing = src
	if(amount == 1)
		living_user.temporarilyRemoveItemFromInventory(src)
		forceMove(get_turf(src))
		throw_at(current_target, throw_range, throw_speed, living_user, TRUE)
		current_target = null
	else
		var/obj/item/stack/throwing_knife/knife_to_throw = new type(get_turf(src))
		knife_to_throw.amount = 1
		knife_to_throw.update_icon()
		knife_to_throw.throw_at(current_target, throw_range, throw_speed, living_user, TRUE)
		amount--
		thrown_thing = knife_to_throw
	playsound(src, 'sound/effects/throw.ogg', 30, 1)
	visible_message(span_warning("[living_user] expertly throws [thrown_thing]."), null, null, 5)
	update_icon()
	return AUTOFIRE_CONTINUE

///Fills any stacks currently in the tile that this object is thrown to.
/obj/item/stack/throwing_knife/proc/post_throw()
	SIGNAL_HANDLER
	if(amount >= max_amount)
		return
	for(var/item_in_loc in loc.contents)
		if(!istype(item_in_loc, /obj/item/stack/throwing_knife) || item_in_loc == src)
			continue
		var/obj/item/stack/throwing_knife/knife = item_in_loc
		if(!merge(knife))
			continue
		break

///Sets the current target and registers for qdel to prevent hardels
/obj/item/stack/throwing_knife/proc/set_target(atom/object)
	if(object == current_target || object == living_user)
		return
	if(current_target)
		UnregisterSignal(current_target, COMSIG_QDELETING)
	current_target = object

/obj/item/stack/throwing_knife/melee_attack_chain(mob/user, atom/target, params, rightclick)
	if(target == user && !user.do_self_harm)
		return
	return ..()

/obj/item/weapon/chainsword
	name = "chainsword"
	desc = "chainsword thing"
	icon = 'icons/obj/items/weapons.dmi'
	icon_state = "chainsword"
	attack_verb = list("gored", "slashed", "cut")
	force = 10
	throwforce = 5
	var/on = FALSE

/obj/item/weapon/chainsword/attack_self(mob/user)
	. = ..()
	if(!on)
		on = !on
		icon_state = "[initial(icon_state)]_on"
		force = 80
		throwforce = 30
	else
		on = !on
		icon_state = initial(icon_state)
		force = initial(force)
		throwforce = initial(icon_state)

/obj/item/weapon/chainsword/attack(mob/living/carbon/M as mob, mob/living/carbon/user as mob)
	playsound(loc, 'sound/weapons/chainsawhit.ogg', 100, 1)
	return ..()

/obj/item/weapon/chainsword/civilian
	name = "chainsaw"
	desc = "A chainsaw. Good for turning big things into little things."
	icon_state = "chainsaw"
