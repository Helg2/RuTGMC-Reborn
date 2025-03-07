/obj/structure/extinguisher_cabinet
	name = "extinguisher cabinet"
	desc = "A small wall mounted cabinet designed to hold a fire extinguisher."
	icon = 'icons/obj/wallframes.dmi'
	icon_state = "extinguisher"
	pixel_x = -16
	pixel_y = -16
	anchored = TRUE
	density = FALSE
	var/obj/item/tool/extinguisher/has_extinguisher
	var/starter_extinguisher = /obj/item/tool/extinguisher
	var/opened = FALSE

/obj/structure/extinguisher_cabinet/Initialize(mapload, ndir)
	. = ..()
	if(ndir)
		dir = ndir
	switch(dir)
		if(NORTH)
			pixel_y -= 32
		if(SOUTH)
			pixel_y += 32
		if(EAST)
			pixel_x -= 32
		if(WEST)
			pixel_x += 32
	if(starter_extinguisher)
		has_extinguisher = new starter_extinguisher(src)
	update_icon()

/obj/structure/extinguisher_cabinet/attackby(obj/item/I, mob/user, params)
	. = ..()
	if(.)
		return

	if(istype(I, /obj/item/tool/extinguisher))
		if(has_extinguisher || !opened)
			return

		user.drop_held_item()
		contents += I
		has_extinguisher = I
		to_chat(user, span_notice("You place [I] in [src]."))
	opened = !opened
	update_icon()

/obj/structure/extinguisher_cabinet/attack_hand(mob/living/user)
	. = ..()
	if(.)
		return
	if(has_extinguisher)
		user.put_in_hands(has_extinguisher)
		to_chat(user, span_notice("You take [has_extinguisher] from [src]."))
		has_extinguisher = null
		opened = 1
	else
		opened = !opened
	update_icon()

/obj/structure/extinguisher_cabinet/update_icon_state()
	. = ..()
	icon_state = "[initial(icon_state)][opened]"

/obj/structure/extinguisher_cabinet/update_overlays()
	. = ..()
	if(opened && has_extinguisher)
		. += "extinguishero_[has_extinguisher.sprite_name]"

/obj/structure/extinguisher_cabinet/mini
	starter_extinguisher = /obj/item/tool/extinguisher/mini

/obj/structure/extinguisher_cabinet/empty
	starter_extinguisher = null
