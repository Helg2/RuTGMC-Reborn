//DO NOT ADD MORE TO THIS FILE.
//Use vv_do_topic() for datums!
/client/proc/view_var_Topic(href, href_list, hsrc)
	if(!check_rights_for(src, R_VAREDIT) || !holder.CheckAdminHref(href, href_list))
		return
	var/target = GET_VV_TARGET
	vv_do_basic(target, href_list, href)
	if(isdatum(target))
		var/datum/D = target
		D.vv_do_topic(href_list)
	else if(islist(target))
		vv_do_list(target, href_list)
	if(href_list["vars"])
		var/datum/vars_target = locate(href_list["vars"])
		if(href_list["special_varname"]) // Some special vars can't be located even if you have their ref, you have to use this instead
			vars_target = vars_target.vars[href_list["special_varname"]]
		debug_variables(vars_target)

//Stuff below aren't in dropdowns/etc.

//~CARN: for renaming mobs (updates their name, real_name, mind.name, their ID/PDA and datacore records).

	if(href_list["rename"])
		if(!check_rights(NONE))
			return

		var/mob/M = locate(href_list["rename"]) in GLOB.mob_list
		if(!istype(M))
			to_chat(usr, "This can only be used on instances of type /mob", confidential = TRUE)
			return

		var/new_name = stripped_input(usr,"What would you like to name this mob?","Input a name",M.real_name,MAX_NAME_LEN)

		// If the new name is something that would be restricted by IC chat filters,
		// give the admin a warning but allow them to do it anyway if they want.
		if(is_ic_filtered(new_name) || is_soft_ic_filtered(new_name) && tgui_alert(usr, "Your selected name contains words restricted by IC chat filters. Confirm this new name?", "IC Chat Filter Conflict", list("Confirm", "Cancel")) == "Cancel")
			return

		if( !new_name || !M )
			return

		message_admins("Admin [key_name_admin(usr)] renamed [key_name_admin(M)] to [new_name].")
		M.fully_replace_character_name(M.real_name,new_name)
		vv_update_display(M, "name", new_name)
		vv_update_display(M, "real_name", M.real_name || "No real name")

	else if(href_list["rotatedatum"])
		if(!check_rights(NONE))
			return

		var/atom/A = locate(href_list["rotatedatum"])
		if(!istype(A))
			to_chat(usr, "This can only be done to instances of type /atom", confidential = TRUE)
			return

		switch(href_list["rotatedir"])
			if("right")
				A.setDir(turn(A.dir, -45))
			if("left")
				A.setDir(turn(A.dir, 45))
		vv_update_display(A, "dir", dir2text(A.dir))


	else if(href_list["adjustDamage"] && href_list["mobToDamage"])
		if(!check_rights(NONE))
			return

		var/mob/living/L = locate(href_list["mobToDamage"]) in GLOB.mob_list
		if(!istype(L))
			return

		var/Text = href_list["adjustDamage"]

		var/amount = input("Deal how much damage to mob? (Negative values here heal)","Adjust [Text]loss",0) as num|null

		if(isnull(amount))
			return

		if(!L)
			to_chat(usr, "Mob doesn't exist anymore", confidential = TRUE)
			return

		var/newamt
		switch(Text)
			if("brute")
				L.adjust_brute_loss(amount)
				newamt = L.get_brute_loss()
			if("fire")
				L.adjust_fire_loss(amount)
				newamt = L.get_fire_loss()
			if("toxin")
				L.adjust_tox_loss(amount)
				newamt = L.get_tox_loss()
			if("oxygen")
				L.adjust_oxy_loss(amount)
				newamt = L.get_oxy_loss()
			if("clone")
				L.adjust_clone_loss(amount)
				newamt = L.get_clone_loss()
			if("stamina")
				L.adjust_stamina_loss(amount)
				newamt = L.get_stamina_loss()
			else
				to_chat(usr, "You caused an error. DEBUG: Text:[Text] Mob:[L]", confidential = TRUE)
				return

		if(amount != 0)
			var/log_msg = "[key_name(usr)] dealt [amount] amount of [Text] damage to [key_name(L)]"
			message_admins("[key_name(usr)] dealt [amount] amount of [Text] damage to [ADMIN_LOOKUPFLW(L)]")
			log_admin(log_msg)
			admin_ticket_log(L, "<font color='blue'>[log_msg]</font>")
			vv_update_display(L, Text, "[newamt]")


	//Finally, refresh if something modified the list.
	if(href_list["datumrefresh"])
		var/datum/DAT = locate(href_list["datumrefresh"])
		if(isdatum(DAT) || istype(DAT, /client) || islist(DAT))
			debug_variables(DAT)
