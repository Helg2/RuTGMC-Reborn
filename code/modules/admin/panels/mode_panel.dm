ADMIN_VERB(mode_panel, R_ADMIN, "Mode Panel", "View the gamemode panel", ADMIN_CATEGORY_FUN)
	if(!SSticker?.mode || !SSevacuation)
		return

	var/dat
	var/ref = "[REF(user.holder)];[HrefToken()]"

	dat += "Current Game Mode: <B>[SSticker.mode.name]</B><BR>"
	dat += "Round Duration: <B>[worldtime2text()]</B><BR>"

	var/rulerless_countdown = SSticker.mode.get_hivemind_collapse_countdown()
	if(rulerless_countdown)
		dat += "<b>Orphan hivemind collapse in [rulerless_countdown] seconds.</b><br>"

	//RUTGMC EDIT ADDITION BEGIN - DISTRESS
	var/siloless_countdown = SSticker.mode.get_siloless_collapse_countdown()
	if(siloless_countdown)
		dat += "<b>Silo less hive collapse in [siloless_countdown] seconds.</b><br>"
	//RUTGMC EDIT ADDITION END

	dat += "<b>Evacuation:</b> "
	switch(SSevacuation.evac_status)
		if(EVACUATION_STATUS_STANDING_BY)
			dat += "STANDING BY"
		if(EVACUATION_STATUS_INITIATING)
			dat += "IN PROGRESS: [SSevacuation.get_status_panel_eta()]"
		if(EVACUATION_STATUS_COMPLETE)
			dat += "COMPLETE"

	dat += "<br>"

	dat += "<a href='byond://?src=[ref];evac_authority=init_evac'>Initiate Evacuation</a><br>"
	dat += "<a href='byond://?src=[ref];evac_authority=cancel_evac'>Cancel Evacuation</a><br>"
	dat += "<a href='byond://?src=[ref];evac_authority=toggle_evac'>Toggle Evacuation Permission</a><br>"
	dat += "<a href='byond://?src=[ref];evac_authority=force_evac'>Force Evacuation Now</a><br>"

	dat += "<br>"

	dat += "<b>Self Destruct:</b> "
	switch(SSevacuation.dest_status)
		if(NUKE_EXPLOSION_INACTIVE)
			dat += "INACTIVE"
		if(NUKE_EXPLOSION_ACTIVE)
			dat += "ACTIVE"
		if(NUKE_EXPLOSION_IN_PROGRESS)
			dat += "IN PROGRESS"
		if(NUKE_EXPLOSION_FINISHED)
			dat += "FINISHED"

	dat += "<br>"

	dat += "<a href='byond://?src=[ref];evac_authority=init_dest'>Unlock Self Destruct control panel for humans</a><br>"
	dat += "<a href='byond://?src=[ref];evac_authority=cancel_dest'>Lock Self Destruct control panel for humans</a><br>"
	dat += "<a href='byond://?src=[ref];evac_authority=use_dest'>Destruct the [SSmapping.configs[SHIP_MAP].map_name] NOW</a><br>"
	dat += "<a href='byond://?src=[ref];evac_authority=toggle_dest'>Toggle Self Destruct Permission</a><br>"

	dat += "<br><br>"

	dat += "<br><table cellspacing=5><tr><td><B>Corporate Liaisons</B></td><td></td><td></td></tr>"
	for(var/i in GLOB.human_mob_list)
		var/mob/living/carbon/human/H = i
		if(!iscorporateliaisonjob(H.job))
			continue
		dat += "<tr><td><a href='byond://?priv_msg=[REF(H)]'>[H.real_name]</a>[H.client ? "" : " <i>(logged out)</i>"][H.stat == DEAD ? " <b><font color=red>(DEAD)</font></b>" : ""]</td>"
		dat += "<td>[get_area(get_turf(H))]</td>"
		dat += "<td><a href='byond://?src=[ref];playerpanel=[REF(H)]'>PP</A></td></TR>"
		dat += "</table>"



	dat += "<table cellspacing=5><tr><td><B>Aliens</B></td><td></td><td></td></tr>"
	for(var/i in GLOB.alive_xeno_list_hive[XENO_HIVE_NORMAL])
		var/mob/living/carbon/xenomorph/X = i
		dat += "<tr><td><a href='byond://?priv_msg=[REF(X)]'>[X.real_name]</a>[X.client ? "" : " <i>(logged out)</i>"]</td>"
		dat += "<td>[get_area(get_turf(X))]</td>"
		dat += "<td><a href='byond://?src=[ref];playerpanel=[REF(X)]'>PP</A></td></TR>"
	dat += "</table>"


	dat += "<br><table cellspacing=5><tr><td><B>Survivors</B></td><td></td><td></td></tr>"
	for(var/i in GLOB.human_mob_list)
		var/mob/living/carbon/human/H = i
		if(!issurvivorjob(H.job))
			continue
		dat += "<tr><td><a href='byond://?priv_msg=[REF(H)]'>[H.real_name]</a>[H.client ? "" : " <i>(logged out)</i>"][H.stat == DEAD ? " <b><font color=red>(DEAD)</font></b>" : ""]</td>"
		dat += "<td>[get_area(get_turf(H))]</td>"
		dat += "<td><a href='byond://?src=[ref];playerpanel=[REF(H)]'>PP</A></td></TR>"
	dat += "</table>"

	log_admin("[key_name(user)] opened the mode panel.")

	var/datum/browser/browser = new(user.mob, "modepanel", "<div align='center'>Mode Panel</div>", 600, 500)
	browser.set_content(dat)
	browser.open()
