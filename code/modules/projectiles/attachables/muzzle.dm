/obj/item/attachable/suppressor
	name = "suppressor"
	desc = "A small tube with exhaust ports to expel noise and gas.\nDoes not completely silence a weapon, but does make it much quieter and a little more accurate and stable."
	icon_state = "suppressor"
	slot = ATTACHMENT_SLOT_MUZZLE
	silence_mod = TRUE
	pixel_shift_y = 16
	attach_shell_speed_mod = -0.5
	accuracy_mod = 0.1
	recoil_mod = -2
	scatter_mod = -2
	recoil_unwielded_mod = -3
	scatter_unwielded_mod = -2
	damage_falloff_mod = 0

/obj/item/attachable/suppressor/unremovable
	attach_features_flags = NONE

/obj/item/attachable/suppressor/unremovable/invisible
	icon_state = ""

/obj/item/attachable/suppressor/unremovable/invisible/Initialize(mapload, ...)
	. = ..()

/obj/item/attachable/bayonet
	name = "bayonet"
	desc = "A sharp blade for mounting on a weapon. It can be used to stab manually on anything but harm intent. Slightly reduces the accuracy of the gun when mounted."
	icon_state = "bayonet"
	worn_icon_list = list(
		slot_l_hand_str = 'icons/mob/inhands/weapons/melee_left.dmi',
		slot_r_hand_str = 'icons/mob/inhands/weapons/melee_right.dmi',
	)
	force = 20
	throwforce = 10
	attach_delay = 10 //Bayonets attach/detach quickly.
	detach_delay = 10
	attack_verb = list("slashes", "stabs", "slices", "tears", "rips", "dices", "cuts")
	melee_mod = 25
	slot = ATTACHMENT_SLOT_MUZZLE
	pixel_shift_x = 14 //Below the muzzle.
	pixel_shift_y = 18
	accuracy_mod = -0.05
	accuracy_unwielded_mod = -0.1
	size_mod = 1
	sharp = IS_SHARP_ITEM_ACCURATE
	variants_by_parent_type = list(/obj/item/weapon/gun/shotgun/pump/t35 = "bayonet_t35")

/obj/item/attachable/bayonet/screwdriver_act(mob/living/user, obj/item/I)
	to_chat(user, span_notice("You modify the bayonet back into a combat knife."))
	if(loc == user)
		user.dropItemToGround(src)
	var/obj/item/weapon/combat_knife/knife = new(loc)
	user.put_in_hands(knife) //This proc tries right, left, then drops it all-in-one.
	if(knife.loc != user) //It ended up on the floor, put it whereever the old flashlight is.
		knife.forceMove(loc)
	qdel(src) //Delete da old bayonet

/obj/item/attachable/bayonetknife
	name = "M-22 bayonet"
	desc = "A sharp knife that is the standard issue combat knife of the TerraGov Marine Corps can be attached to a variety of weapons at will or used as a standard knife."
	icon = 'icons/obj/items/weapons.dmi'
	icon_state = "bayonetknife"
	worn_icon_list = list(
		slot_l_hand_str = 'icons/mob/inhands/weapons/melee_left.dmi',
		slot_r_hand_str = 'icons/mob/inhands/weapons/melee_right.dmi',
	)
	force = 25
	throwforce = 20
	throw_speed = 3
	throw_range = 6
	attack_speed = 8
	attach_delay = 10 //Bayonets attach/detach quickly.
	detach_delay = 10
	attack_verb = list("slashes", "stabs", "slices", "tears", "rips", "dices", "cuts")
	melee_mod = 25
	slot = ATTACHMENT_SLOT_MUZZLE
	pixel_shift_x = 14 //Below the muzzle.
	pixel_shift_y = 18
	accuracy_mod = -0.05
	accuracy_unwielded_mod = -0.1
	size_mod = 1
	sharp = IS_SHARP_ITEM_ACCURATE
	variants_by_parent_type = list(/obj/item/weapon/gun/shotgun/pump/t35 = "bayonetknife_t35")

/obj/item/attachable/bayonetknife/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/scalping)
	AddElement(/datum/element/shrapnel_removal, 12 SECONDS, 12 SECONDS, 10)

/obj/item/attachable/melee_attack_chain(mob/user, atom/target, params, rightclick)
	if(target == user && !user.do_self_harm)
		return
	return ..()

/obj/item/attachable/bayonetknife/som
	name = "\improper S20 SOM bayonet"
	desc = "A large knife that is the standard issue combat knife of the SOM. Can be attached to a variety of weapons at will or used as a standard knife."
	icon_state = "bayonetknife_som"
	worn_icon_state = "bayonetknife"
	force = 30

/obj/item/attachable/extended_barrel
	name = "extended barrel"
	desc = "A lengthened barrel allows for lessened scatter, greater accuracy and muzzle velocity due to increased stabilization and shockwave exposure."
	slot = ATTACHMENT_SLOT_MUZZLE
	icon_state = "ebarrel"
	attach_shell_speed_mod = 1
	accuracy_mod = 0.15
	accuracy_unwielded_mod = 0.1
	scatter_mod = -1
	size_mod = 1
	variants_by_parent_type = list(
		/obj/item/weapon/gun/rifle/som = "ebarrel_big",
		/obj/item/weapon/gun/rifle/som_big = "ebarrel_big",
		/obj/item/weapon/gun/smg/som = "ebarrel_big",
		/obj/item/weapon/gun/shotgun/pump/t35 = "ebarrel_big",
	)

/obj/item/attachable/heavy_barrel
	name = "barrel charger"
	desc = "A fitted barrel extender that goes on the muzzle, with a small shaped charge that propels a bullet much faster.\nGreatly increases projectile speed and reduces damage falloff."
	slot = ATTACHMENT_SLOT_MUZZLE
	icon_state = "hbarrel"
	attach_shell_speed_mod = 2
	accuracy_mod = -0.05
	damage_falloff_mod = -0.2

/obj/item/attachable/compensator
	name = "recoil compensator"
	desc = "A muzzle attachment that reduces recoil and scatter by diverting expelled gasses upwards. \nSignificantly reduces recoil and scatter, regardless of if the weapon is wielded."
	slot = ATTACHMENT_SLOT_MUZZLE
	icon_state = "comp"
	pixel_shift_x = 17
	scatter_mod = -3
	recoil_mod = -2
	scatter_unwielded_mod = -3
	recoil_unwielded_mod = -2
	variants_by_parent_type = list(
		/obj/item/weapon/gun/rifle/som = "comp_big",
		/obj/item/weapon/gun/rifle/som_big = "comp_big",
		/obj/item/weapon/gun/smg/som = "comp_big",
		/obj/item/weapon/gun/shotgun/som = "comp_big",
		/obj/item/weapon/gun/shotgun/pump/t35 = "comp_big",
		/obj/item/weapon/gun/revolver/standard_magnum = "t76comp"
	)

/obj/item/attachable/sniperbarrel
	name = "sniper barrel"
	icon_state = "sniperbarrel"
	desc = "A heavy barrel. CANNOT BE REMOVED."
	slot = ATTACHMENT_SLOT_MUZZLE
	attach_features_flags = NONE
	accuracy_mod = 0.15
	scatter_mod = -3

/obj/item/attachable/sr81
	name = "auto sniper barrel"
	icon_state = "t81barrel"
	desc = "A heavy barrel. CANNOT BE REMOVED."
	slot = ATTACHMENT_SLOT_UNDER
	attach_features_flags = NONE
	pixel_shift_x = 7
	pixel_shift_y = 14
	accuracy_mod = 0
	scatter_mod = -1

/obj/item/attachable/smartbarrel
	name = "smartgun barrel"
	icon_state = "smartbarrel"
	desc = "A heavy rotating barrel. CANNOT BE REMOVED."
	slot = ATTACHMENT_SLOT_MUZZLE
	attach_features_flags = NONE

/obj/item/attachable/focuslens
	name = "M43 focused lens"
	desc = "Directs the beam into one specialized lens, allowing the lasgun to use the deadly focused bolts on overcharge, making it more like a high damage sniper."
	slot = ATTACHMENT_SLOT_MUZZLE
	icon_state = "focus"
	pixel_shift_x = 17
	pixel_shift_y = 13
	ammo_mod = /datum/ammo/energy/lasgun/m43/overcharge
	damage_mod = -0.15

/obj/item/attachable/widelens
	name = "M43 wide lens"
	desc = "Splits the lens into three, allowing the lasgun to use a deadly close-range blast on overcharge akin to a traditional pellet based shotgun shot."
	slot = ATTACHMENT_SLOT_MUZZLE
	icon_state = "wide"
	pixel_shift_x = 18
	pixel_shift_y = 15
	ammo_mod = /datum/ammo/energy/lasgun/m43/blast
	damage_mod = -0.15

/obj/item/attachable/heatlens
	name = "M43 heat lens"
	desc = "Changes the intensity and frequency of the laser. This makes your target be set on fire at a cost of upfront damage and penetration."
	slot = ATTACHMENT_SLOT_MUZZLE
	icon_state = "heat"
	pixel_shift_x = 18
	pixel_shift_y = 16
	ammo_mod = /datum/ammo/energy/lasgun/m43/heat
	damage_mod = -0.15

/obj/item/attachable/efflens
	name = "M43 efficient lens"
	desc = "Makes the lens smaller and lighter to use, allowing the lasgun to use its energy much more efficiently. \nDecreases energy output of the lasgun."
	slot = ATTACHMENT_SLOT_MUZZLE
	icon_state = "efficient"
	pixel_shift_x = 18
	pixel_shift_y = 14
	charge_mod = -5

/obj/item/attachable/sx16barrel
	name = "SX-16 barrel"
	desc = "The standard barrel on the SX-16. CANNOT BE REMOVED."
	slot = ATTACHMENT_SLOT_MUZZLE
	icon_state = "sx16barrel"
	attach_features_flags = NONE

/obj/item/attachable/pulselens
	name = "M43 pulse lens"
	desc = "Agitates the lens, allowing the lasgun to discharge at a rapid rate. \nAllows the weapon to be fired automatically."
	slot = ATTACHMENT_SLOT_MUZZLE
	icon_state = "pulse"
	pixel_shift_x = 18
	pixel_shift_y = 15
	damage_mod = -0.15
	gun_firemode_list_mod = list(GUN_FIREMODE_AUTOMATIC)

/obj/item/attachable/sgbarrel
	name = "SG-29 barrel"
	icon_state = "sg29barrel"
	desc = "A heavy barrel. CANNOT BE REMOVED."
	slot = ATTACHMENT_SLOT_MUZZLE
	attach_features_flags = NONE

/obj/item/attachable/t500_barrel
	name = "R-500 extended barrel"
	desc = "Cool barrel for a cool revolver."
	slot = ATTACHMENT_SLOT_MUZZLE
	delay_mod = -0.4 SECONDS
	icon = 'icons/obj/items/attachments/attachments_64.dmi'
	icon_state = "barrel"
	attach_shell_speed_mod = 1
	accuracy_mod = 0.15
	accuracy_unwielded_mod = 0.1
	scatter_mod = -3
	scatter_unwielded_mod = 3
	recoil_unwielded_mod = 1
	size_mod = 1
	pixel_shift_x = 0
	pixel_shift_y = 0

/obj/item/attachable/t500_barrel/short
	name = "R-500 compensator"
	desc = "Cool compensator for a cool revolver."
	delay_mod = -0.2 SECONDS
	icon_state = "shortbarrel"
	attach_shell_speed_mod = 0
	scatter_mod = -2
	recoil_mod = -0.5
	scatter_unwielded_mod = -5
	recoil_unwielded_mod = -1
	accuracy_mod = 0
	accuracy_unwielded_mod = 0.15
	size_mod = 0.5
