/obj/item/reagent_containers
	name = "Container"
	desc = ""
	icon = 'icons/obj/items/chemistry.dmi'
	icon_state = null
	worn_icon_list = list(
		slot_l_hand_str = 'icons/mob/inhands/equipment/medical_left.dmi',
		slot_r_hand_str = 'icons/mob/inhands/equipment/medical_right.dmi',
	)
	throwforce = 3
	w_class = WEIGHT_CLASS_SMALL
	throw_speed = 1
	throw_range = 5
	var/init_reagent_flags
	var/amount_per_transfer_from_this = 5
	/// Used to adjust how many units are transfered/injected in a single click
	var/possible_transfer_amounts = list(5,10,15,25,30)
	var/volume = 30
	/// Can liquify/grind pills without needing fluid to dissolve.
	var/liquifier = FALSE
	var/list/list_reagents
	/// Whether we can restock this in a vendor without it having its starting reagents
	var/free_refills = TRUE

/obj/item/reagent_containers/Initialize(mapload)
	. = ..()
	create_reagents(volume, init_reagent_flags, list_reagents)
	if(!possible_transfer_amounts)
		verbs -= /obj/item/reagent_containers/verb/set_APTFT

/obj/item/reagent_containers/attack_self(mob/living/user)
	. = ..()
	afterattack(user, user) //If player uses the container, use it on themselves

/obj/item/reagent_containers/attack_self_alternate(mob/living/user)
	. = ..()
	change_transfer_amount(user)

/obj/item/reagent_containers/unique_action(mob/user, special_treatment)
	. = ..()
	change_transfer_amount(user)

///Opens a tgui_input_list and changes the transfer_amount of our container based on our selection
/obj/item/reagent_containers/proc/change_transfer_amount(mob/living/user)
	if(!possible_transfer_amounts)
		return FALSE
	var/result = tgui_input_list(user, "Amount per transfer from this:","[src]", possible_transfer_amounts)
	if(result)
		amount_per_transfer_from_this = result
	return TRUE

/obj/item/reagent_containers/verb/set_APTFT()
	set name = "Set transfer amount"
	set category = "IC.Object"
	set src in view(1)

	change_transfer_amount(usr)

//returns a text listing the reagents (and their volume) in the atom. Used by Attack logs for reagents in pills
/obj/item/reagent_containers/proc/get_reagent_list_text()
	if(reagents.reagent_list && length(reagents.reagent_list))
		var/datum/reagent/R = reagents.reagent_list[1]
		. = "[R.name]([R.volume]u)"
		if(length(reagents.reagent_list) < 2) return
		for (var/i = 2, i <= length(reagents.reagent_list), i++)
			R = reagents.reagent_list[i]
			if(!R) continue
			. += "; [R.name]([R.volume]u)"
	else
		. = "No reagents"

///True if this object currently contains at least its starting reagents, false otherwise. Extra reagents are ignored.
/obj/item/reagent_containers/proc/has_initial_reagents()
	for(var/reagent_to_check in list_reagents)
		if(reagents.get_reagent_amount(reagent_to_check) != list_reagents[reagent_to_check])
			return FALSE
	return TRUE
