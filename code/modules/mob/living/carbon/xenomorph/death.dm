/mob/living/carbon/xenomorph/proc/death_cry()
	playsound(loc, prob(50) ? 'sound/voice/alien/death.ogg' : 'sound/voice/alien/death2.ogg', 25, 1)

/mob/living/carbon/xenomorph/death(gibbing, deathmessage = "lets out a waning guttural screech, green blood bubbling from its maw.", silent)
	return ..() //we're just changing the death message

/mob/living/carbon/xenomorph/on_death()
	GLOB.alive_xeno_list -= src
	LAZYREMOVE(GLOB.alive_xeno_list_hive[hivenumber], src)
	GLOB.dead_xeno_list += src

	QDEL_NULL(current_aura)
	QDEL_NULL(leader_current_aura)

	hive?.on_xeno_death(src)
	hive?.update_tier_limits() //Update our tier limits.

	if(xeno_flags & XENO_ZOOMED)
		zoom_out()

	if(tier != XENO_TIER_MINION)
		GLOB.key_to_time_of_xeno_death[key] = world.time

	SSminimaps.remove_marker(src)
	set_light_on(FALSE)

	if(hud_used)
		if(hud_used.healths)
			hud_used.healths.icon_state = "health_dead"
		if(hud_used.staminas)
			hud_used.staminas.icon_state = "staminaloss200"
		if(hud_used.alien_plasma_display)
			hud_used.alien_plasma_display.icon_state = "power_display_0"
		if(hud_used.alien_evolve_display)
			hud_used.alien_evolve_display.icon_state = "evolve0"

	hud_set_plasma()
	med_hud_set_health()
	hud_update_primo()

	update_icons()
	hud_update_rank()

	death_cry()

	xeno_death_alert()

	hud_set_queen_overwatch() //updates the overwatch hud to remove the upgrade chevrons, gold star, etc

	GLOB.round_statistics.total_xeno_deaths++
	SSblackbox.record_feedback(FEEDBACK_TALLY, "round_statistics", 1, "total_xeno_deaths")

	switch (upgrade)
		if(XENO_UPGRADE_NORMAL)
			switch(tier)
				if(XENO_TIER_TWO)
					SSmonitor.stats.normal_T2--
				if(XENO_TIER_THREE)
					SSmonitor.stats.normal_T3--
				if(XENO_TIER_FOUR)
					SSmonitor.stats.normal_T4--
		if(XENO_UPGRADE_PRIMO)
			switch(tier)
				if(XENO_TIER_TWO)
					SSmonitor.stats.primo_T2--
				if(XENO_TIER_THREE)
					SSmonitor.stats.primo_T3--
				if(XENO_TIER_FOUR)
					SSmonitor.stats.primo_T4--

	eject_victim()

	to_chat(src,"<b>[span_deadsay("<p style='font-size:1.5em'><big>We have perished.</big><br><small>But it is not the end of us yet... wait until a newborn can rise in this world...</small></p>")]</b>")

	if(islaststandgamemode(SSticker.mode)) // snowflaky, but we need to cleanup
		addtimer(CALLBACK(src, PROC_REF(last_stand_death)), 1 MINUTES)

	return ..()

/mob/living/carbon/xenomorph/proc/xeno_death_alert()
	if(is_centcom_level(z))
		return
	if(xeno_caste.caste_flags & CASTE_DO_NOT_ANNOUNCE_DEATH)
		return
	var/area/A = get_area(src)
	xeno_message("Hive: \The [src] has <b>died</b>[A? " at [A]":""]!", "xenoannounce", xeno_caste.caste_flags & CASTE_DO_NOT_ALERT_LOW_LIFE ? 2 : 5, hivenumber)

/mob/living/carbon/xenomorph/gib()
	var/obj/effect/decal/remains/xeno/remains = new(get_turf(src))
	remains.icon = icon
	remains.pixel_x = pixel_x //For 2x2.

	SEND_SIGNAL(src, COMSIG_XENOMORPH_GIBBING)

	remains.icon = effects_icon
	remains.icon_state = xeno_caste.gib_anim

	check_blood_splash(50, BRUTE, 50)

	return ..()

/mob/living/carbon/xenomorph/gib_animation()
	new /obj/effect/overlay/temp/gib_animation/xeno(loc, 0, src, xeno_caste.gib_flick, effects_icon)

/mob/living/carbon/xenomorph/spawn_gibs()
	xgibs(get_turf(src))
	new /obj/effect/temp_visual/gib_particles(get_turf(src), get_blood_color())

/mob/living/carbon/xenomorph/dust_animation()
	new /obj/effect/overlay/temp/dust_animation(loc, 0, src, "dust-a")

/mob/living/carbon/xenomorph/proc/last_stand_death()
	if(QDELETED(src)) // in case we were gibbed
		return

	fade_out(src, our_time = 5 SECONDS)
	sleep(5 SECONDS)
	if(prob(25))
		new /obj/item/research_product/money/basic(loc)
	qdel(src)
