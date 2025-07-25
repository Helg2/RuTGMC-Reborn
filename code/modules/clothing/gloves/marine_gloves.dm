/obj/item/clothing/gloves/marine
	name = "marine combat gloves"
	desc = "Standard issue marine tactical gloves. It reads: 'knit by Marine Widows Association'."
	icon_state = "gloves_marine"
	siemens_coefficient = 0.6
	permeability_coefficient = 0.05
	cold_protection_flags = HANDS
	heat_protection_flags = HANDS
	min_cold_protection_temperature = GLOVES_MIN_COLD_PROTECTION_TEMPERATURE
	max_heat_protection_temperature = GLOVES_MAX_HEAT_PROTECTION_TEMPERATURE
	armor_protection_flags = HANDS
	soft_armor = list(MELEE = 25, BULLET = 15, LASER = 10, ENERGY = 15, BOMB = 15, BIO = 5, FIRE = 15, ACID = 15)

/obj/item/clothing/gloves/marine/fingerless
	name = "fingerless marine combat gloves"
	desc = "Standard issue marine tactical gloves but fingerless! It reads: 'knit by Marine Widows Association'."
	icon_state = "gloves_marine_fingerless"
	worn_icon_state = "fingerless"

/obj/item/clothing/gloves/marine/insulated
	name = "insulated marine combat gloves"
	desc = "Insulated marine tactical gloves that protect against electrical shocks."
	icon_state = "gloves_marine_insulated"
	siemens_coefficient = 0

/obj/item/clothing/gloves/marine/officer
	name = "officer gloves"
	desc = "Shiny and impressive. They look expensive."
	icon_state = "black"

/obj/item/clothing/gloves/marine/officer/chief
	name = "chief officer gloves"
	desc = "Blood crusts are attached to its metal studs, which are slightly dented."

/obj/item/clothing/gloves/marine/officer/chief/sa
	name = "spatial agent's gloves"
	desc = "Gloves worn by a Spatial Agent."
	siemens_coefficient = 0
	permeability_coefficient = 0
	item_flags = DELONDROP

/obj/item/clothing/gloves/marine/techofficer
	name = "tech officer gloves"
	desc = "Sterile AND insulated! Why is not everyone issued with these?"
	icon_state = "yellow"
	siemens_coefficient = 0
	permeability_coefficient = 0.01

/obj/item/clothing/gloves/marine/techofficer/captain
	name = "captain's gloves"
	desc = "You may like these gloves, but THEY think you are unworthy of them."
	icon_state = "captain"

/obj/item/clothing/gloves/marine/specialist
	name = "\improper B18 defensive gauntlets"
	desc = "A pair of heavily armored gloves."
	icon_state = "armored"
	item_flags = SYNTH_RESTRICTED
	soft_armor = list(MELEE = 35, BULLET = 15, LASER = 15, ENERGY = 15, BOMB = 25, BIO = 15, FIRE = 15, ACID = 20)
	resistance_flags = UNACIDABLE

/obj/item/clothing/gloves/marine/veteran/pmc
	name = "armored gloves"
	desc = "Armored gloves used in special operations. They are also insulated against electrical shock."
	icon_state = "black"
	siemens_coefficient = 0
	item_flags = SYNTH_RESTRICTED
	soft_armor = list(MELEE = 30, BULLET = 20, LASER = 20, ENERGY = 20, BOMB = 30, BIO = 20, FIRE = 20, ACID = 15)

/obj/item/clothing/gloves/marine/veteran/pmc/commando
	name = "\improper PMC commando gloves"
	desc = "A pair of heavily armored, insulated, acid-resistant gloves."
	icon_state = "death_squad"
	soft_armor = list(MELEE = 40, BULLET = 20, LASER = 20, ENERGY = 20, BOMB = 30, BIO = 20, FIRE = 20, ACID = 25)
	resistance_flags = UNACIDABLE

/obj/item/clothing/gloves/marine/som
	name = "\improper SOM gloves"
	desc = "Gloves with origins dating back to the old mining colonies, they look pretty tough."
	icon_state = "som"

/obj/item/clothing/gloves/marine/som/insulated
	name = "\improper Insulated SOM gloves"
	desc = "Gloves with origins dating back to the old mining colonies. These ones appear to have an electrically insulating layer built into them."
	siemens_coefficient = 0

/obj/item/clothing/gloves/marine/som/veteran
	name = "\improper SOM veteran gloves"
	desc = "Gloves with origins dating back to the old mining colonies. These ones seem tougher than normal."
	icon_state = "som_veteran"
	soft_armor = list(MELEE = 30, BULLET = 20, LASER = 15, ENERGY = 20, BOMB = 15, BIO = 5, FIRE = 15, ACID = 15)

/obj/item/clothing/gloves/marine/som/officer
	name = "\improper SOM gloves"
	desc = "Black gloves commonly worn by SOM officers."
	icon_state = "som_officer_gloves"

/obj/item/clothing/gloves/marine/icc
	name = "\improper ICC gloves"
	desc = "Tough looking working gloves."
	icon_state = "icc"

/obj/item/clothing/gloves/marine/icc/insulated
	name = "\improper ICC insulated gloves"
	desc = "Tough looking working gloves. These ones appear to have insulation to protect from electric shock."
	siemens_coefficient = 0

/obj/item/clothing/gloves/marine/icc/guard
	name = "\improper ICCGF gloves"
	desc = "Tough looking tactical gloves."
	icon_state = "icc_guard"
	soft_armor = list(MELEE = 30, BULLET = 20, LASER = 15, ENERGY = 20, BOMB = 15, BIO = 5, FIRE = 15, ACID = 15)

/obj/item/clothing/gloves/marine/commissar
	name = "\improper commissar gloves"
	desc = "Gloves worn by commissars of the Imperial Army so that they do not soil their hands with the blood of their men."
	icon_state = "red"
	soft_armor = list(MELEE = 35, BULLET = 30, LASER = 30, ENERGY = 30, BOMB = 15, BIO = 10, FIRE = 20, ACID = 20)

/obj/item/clothing/gloves/marine/separatist
	name = "kevlar gloves TG-94"
	desc = "Once before, the original of these gloves had protected the hands of the civilian militia of the colony of Terra during the heroic liberation of their territories from the hands of the enemy. 'Wear it with honor,' reads the inscription at the bottom"
	icon_state = "separatist"
	worn_icon_state = "separatist"

/obj/item/clothing/gloves/marine/veteran/marine
	name = "veteran gloves"
	desc = "Ordinary Marine gloves, artfully reinforced for personal gain. An extra steel plate and a pair of cool white laces will definitely make this item look better. You're sure. The Marine Widows Association is outraged."
	icon_state = "veteran_1"
	worn_icon_state = "veteran"
	var/gloves_inside_out = FALSE

/obj/item/clothing/gloves/marine/veteran/marine/examine(mob/user)
	. = ..()
	. += span_info("You could <b>use it in-hand</b> to turn it inside out and change it's appearance.")

/obj/item/clothing/gloves/marine/veteran/marine/attack_self(mob/user)
	. = ..()
	if(!gloves_inside_out)
		to_chat(user, span_notice("You turn the gloves inside out and change their appearance."))
		gloves_inside_out = TRUE
	else
		to_chat(user, span_notice("You roll the gloves back inside and they look just right."))
		gloves_inside_out = initial(gloves_inside_out)
	update_icon_state()

/obj/item/clothing/gloves/marine/veteran/marine/update_icon_state()
	if(gloves_inside_out)
		icon_state = "veteran_2"
	else
		icon_state = "veteran_1"

/obj/item/clothing/gloves/marine/mp
	name = "security combat gloves"
	desc = "Standard issue military police tactical gloves. It reads: 'knit by Marine Widows Association'."
	soft_armor = list(MELEE = 15, BULLET = 80, LASER = 80, ENERGY = 0, BOMB = 0, BIO = 90, FIRE = 0, ACID = 0)
