/obj/item/clothing/head/hardhat
	name = "hard hat"
	desc = "A piece of headgear used in dangerous working conditions to protect the head. Comes with a built-in flashlight."
	icon_state = "hardhat0_yellow"
	worn_icon_state = "hardhat0_yellow"
	soft_armor = list(MELEE = 30, BULLET = 5, LASER = 20, ENERGY = 10, BOMB = 20, BIO = 10, FIRE = 10, ACID = 10)
	actions_types = list(/datum/action/item_action/toggle)
	siemens_coefficient = 0.9
	inventory_flags = BLOCKSHARPOBJ
	light_range = 4
	light_power = 2
	var/hardhat_color = "yellow" //Determines used sprites: hardhat[on]_[hardhat_color]

/obj/item/clothing/head/hardhat/Initialize(mapload)
	. = ..()
	GLOB.nightfall_toggleable_lights += src

/obj/item/clothing/head/hardhat/Destroy()
	GLOB.nightfall_toggleable_lights -= src
	return ..()

/obj/item/clothing/head/hardhat/attack_self(mob/user)
	if(!isturf(user.loc))
		to_chat(user, "You cannot turn the light on while in [user.loc]")
		return
	turn_light(user, !light_on)

/obj/item/clothing/head/hardhat/turn_light(mob/user, toggle_on)
	. = ..()
	if(. != CHECKS_PASSED)
		return
	set_light_on(toggle_on)
	if(user == loc)
		var/mob/M = loc
		M.update_inv_head()

	update_action_button_icons()
	update_icon()

/obj/item/clothing/head/hardhat/attack_alien(mob/living/carbon/xenomorph/xeno_attacker, isrightclick = FALSE)
	if(turn_light(xeno_attacker, FALSE) != CHECKS_PASSED)
		return
	playsound(loc, SFX_ALIEN_CLAW_METAL, 25, 1)
	xeno_attacker.do_attack_animation(src, ATTACK_EFFECT_CLAW)
	to_chat(xeno_attacker, span_warning("We disable the metal thing's lights.") )

/obj/item/clothing/head/hardhat/update_icon_state()
	. = ..()
	icon_state = "hardhat[light_on]_[hardhat_color]"
	worn_icon_state = "hardhat[light_on]_[hardhat_color]"

/obj/item/clothing/head/hardhat/orange
	icon_state = "hardhat0_orange"
	hardhat_color = "orange"

/obj/item/clothing/head/hardhat/red
	icon_state = "hardhat0_red"
	hardhat_color = "red"
	name = "firefighter helmet"
	inventory_flags = BLOCKSHARPOBJ
	heat_protection_flags = HEAD
	max_heat_protection_temperature = FIRE_HELMET_MAX_HEAT_PROTECTION_TEMPERATURE

/obj/item/clothing/head/hardhat/white
	icon_state = "hardhat0_white"
	hardhat_color = "white"
	inventory_flags = BLOCKSHARPOBJ
	heat_protection_flags = HEAD
	max_heat_protection_temperature = FIRE_HELMET_MAX_HEAT_PROTECTION_TEMPERATURE

/obj/item/clothing/head/hardhat/dblue
	icon_state = "hardhat0_dblue"
	hardhat_color = "dblue"

/obj/item/clothing/head/hardhat/rugged
	name = "rugged hard hat"
	desc = "A piece of headgear used in dangerous working conditions to protect the head. Comes with a built-in flashlight. Looks rather robust."
	soft_armor = list(MELEE = 50, BULLET = 40, LASER = 40, ENERGY = 40, BOMB = 50, BIO = 40, FIRE = 50, ACID = 50)
