/*!
 * # Mecha defence explanation
 * Mechs focus is on a more heavy-but-slower damage approach
 * For this they have the following mechanics
 *
 * ## Backstab
 * Basically the tldr is that mechs are less flexible so we encourage good positioning, pretty simple
 * ## Armor modules
 * Pretty simple, adds armor, you can choose against what
 * ## Internal damage
 * When taking damage will force you to take some time to repair, encourages improvising in a fight
 * Targetting different def zones will damage them to encurage a more strategic approach to fights
 * where they target the "dangerous" modules
 */

///tries to deal internal damaget depending on the damage amount
/obj/vehicle/sealed/mecha/proc/try_deal_internal_damage(damage)
	if(damage < internal_damage_threshold)
		return
	if(!prob(internal_damage_probability))
		return
	var/internal_damage_to_deal = possible_int_damage
	internal_damage_to_deal &= ~mecha_flags
	if(internal_damage_to_deal)
		set_internal_damage(pick(bitfield2list(internal_damage_to_deal)))

/// tries to repair any internal damage and plays fluff for it
/obj/vehicle/sealed/mecha/proc/try_repair_int_damage(mob/user, flag_to_heal)
	balloon_alert(user, get_int_repair_fluff_start(flag_to_heal))
	log_message("[key_name(user)] starting internal damage repair for flag [flag_to_heal]", LOG_MECHA)
	if(!do_after(user, 10 SECONDS, NONE, src))
		balloon_alert(user, get_int_repair_fluff_fail(flag_to_heal))
		log_message("Internal damage repair for flag [flag_to_heal] failed.", LOG_MECHA, color="red")
		return
	clear_internal_damage(flag_to_heal)
	balloon_alert(user, get_int_repair_fluff_end(flag_to_heal))
	log_message("Finished internal damage repair for flag [flag_to_heal]", LOG_MECHA)

///gets the starting balloon alert flufftext
/obj/vehicle/sealed/mecha/proc/get_int_repair_fluff_start(flag)
	switch(flag)
		if(MECHA_INT_FIRE)
			return "activating internal fire supression..."
		if(MECHA_INT_CONTROL_LOST)
			return "recalibrating coordination system..."

///gets the successful finish balloon alert flufftext
/obj/vehicle/sealed/mecha/proc/get_int_repair_fluff_end(flag)
	switch(flag)
		if(MECHA_INT_FIRE)
			return "internal fire supressed"
		if(MECHA_INT_CONTROL_LOST)
			return "coordination re-established"

///gets the on-fail balloon alert flufftext
/obj/vehicle/sealed/mecha/proc/get_int_repair_fluff_fail(flag)
	switch(flag)
		if(MECHA_INT_FIRE)
			return "fire supression canceled"
		if(MECHA_INT_CONTROL_LOST)
			return "recalibration failed"

/obj/vehicle/sealed/mecha/proc/set_internal_damage(int_dam_flag)
	internal_damage |= int_dam_flag
	log_message("Internal damage of type [int_dam_flag].", LOG_MECHA)
	SEND_SOUND(occupants, sound('sound/machines/warning-buzzer.ogg',wait=0))

/obj/vehicle/sealed/mecha/proc/clear_internal_damage(int_dam_flag)
	if(internal_damage & int_dam_flag && int_dam_flag == MECHA_INT_FIRE)
		to_chat(occupants, "[icon2html(src, occupants)][span_boldnotice("Internal fire extinguished.")]")
	internal_damage &= ~int_dam_flag
