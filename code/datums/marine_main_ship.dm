GLOBAL_DATUM_INIT(marine_main_ship, /datum/marine_main_ship, new)

// datum for stuff specifically related to the marine main ship like theseus
/datum/marine_main_ship

	var/obj/structure/orbital_cannon/orbital_cannon
	var/list/ob_type_fuel_requirements

	var/obj/structure/ship_rail_gun/rail_gun

	var/maint_all_access = FALSE

	var/security_level = SEC_LEVEL_GREEN

/datum/marine_main_ship/proc/make_maint_all_access()
	maint_all_access = TRUE
	priority_announce("Требование доступа для всех технических тоннелей отменено.", "Внимание!", "На корабле объявлена чрезвычайная ситуация.", sound = 'sound/misc/notice1.ogg', color_override = "grey")

/datum/marine_main_ship/proc/revoke_maint_all_access()
	maint_all_access = FALSE
	priority_announce("Требование доступа для всех технических тоннелей было возвращено.", "Внимание!", "Отбой Тревоги.", sound = 'sound/misc/notice2.ogg', color_override = "grey")

/datum/marine_main_ship/proc/set_security_level(level, announce = TRUE)
	switch(level)
		if("green")
			level = SEC_LEVEL_GREEN
		if("blue")
			level = SEC_LEVEL_BLUE
		if("red")
			level = SEC_LEVEL_RED
		if("delta")
			level = SEC_LEVEL_DELTA

	if(level <= SEC_LEVEL_BLUE)
		for(var/obj/effect/soundplayer/deltaplayer/alarmplayer AS in GLOB.ship_alarms)
			alarmplayer.loop_sound.stop(alarmplayer)
		for(var/obj/machinery/light/mainship/light AS in GLOB.mainship_lights)
			if(istype(light, /obj/machinery/light/mainship/small))
				light.base_icon_state = "bulb"
			else
				light.base_icon_state = "tube"
			var/area/A = get_area(light)
			if(!A.power_light || light.status != LIGHT_OK) //do not adjust unpowered or broken bulbs
				continue
			light.light_color = light.bulb_colour
			light.light_range = light.brightness
			light.update_light()
			light.update_appearance(UPDATE_ICON)
	else
		for(var/obj/effect/soundplayer/deltaplayer/alarmplayer AS in GLOB.ship_alarms)
			if(level != SEC_LEVEL_DELTA)
				alarmplayer.loop_sound.stop(alarmplayer)
			else
				alarmplayer.loop_sound.start(alarmplayer)
		for(var/obj/machinery/light/mainship/light AS in GLOB.mainship_lights)
			if(istype(light, /obj/machinery/light/mainship/small))
				light.base_icon_state = "bulb_red"
			else
				light.base_icon_state = "tube_red"
			var/area/A = get_area(light)
			if(!A.power_light || light.status != LIGHT_OK) //do not adjust unpowered or broken bulbs
				continue
			light.light_color = COLOR_SOMEWHAT_LIGHTER_RED
			light.light_range = 7.5
			if(prob(75)) //randomize light range on most lights, patchy lighting gives a sense of danger
				var/rangelevel = pick(5.5,6.0,6.5,7.0)
				if(prob(15))
					rangelevel -= pick(0.5,1.0,1.5,2.0)
				light.light_range = rangelevel
			light.update_light()
			light.update_appearance(UPDATE_ICON)

	//Will not be announced if you try to set to the same level as it already is
	if(level >= SEC_LEVEL_GREEN && level <= SEC_LEVEL_DELTA && level != security_level)
		switch(level)
			if(SEC_LEVEL_GREEN)
				if(announce)
					priority_announce("Всё стабильно.", title = "Код Зеленый", sound = 'sound/AI/code_green.ogg', color_override = "green")
				security_level = SEC_LEVEL_GREEN
				for(var/obj/machinery/status_display/SD in GLOB.machines)
					if(is_mainship_level(SD.z))
						SD.set_picture("default")
			if(SEC_LEVEL_BLUE)
				if(security_level < SEC_LEVEL_BLUE)
					if(announce)
						priority_announce("На борту потенциально враждебная деятельность. Требуются тщательные проверки.", title = "Код Синий", sound = 'sound/AI/code_blue_elevated.ogg')
				else
					if(announce)
						priority_announce("Возможны остатки враждебной деятельности. Требуются тщательные проверки.", title = "Код Синий", sound = 'sound/AI/code_blue_lowered.ogg')
				security_level = SEC_LEVEL_BLUE
				for(var/obj/machinery/status_display/SD in GLOB.machines)
					if(is_mainship_level(SD.z))
						SD.set_picture("default")
			if(SEC_LEVEL_RED)
				if(security_level < SEC_LEVEL_RED)
					if(announce)
						priority_announce("Существует непосредственная угроза судну. Боеспособному персоналу надлежит организовать защиту экипажа.", title = "Код Красный", sound = 'sound/AI/code_red_elevated.ogg', color_override = "red")
				else
					if(announce)
						priority_announce("Существует непосредственная угроза судну. Боеспособному персоналу требуется разобраться с остальными проблемами.", title = "Код Красный", type = ANNOUNCEMENT_PRIORITY, sound = 'sound/AI/code_red_lowered.ogg', color_override = "red")
					/*
					var/area/A
					for(var/obj/machinery/power/apc/O in machines)
						if(is_mainship_level(O.z))
							A = O.loc.loc
							A.toggle_evacuation()
					*/

				security_level = SEC_LEVEL_RED

				for(var/obj/machinery/status_display/SD in GLOB.machines)
					if(is_mainship_level(SD.z))
						SD.set_picture("redalert")
			if(SEC_LEVEL_DELTA)
				if(announce)
					priority_announce(
						type = ANNOUNCEMENT_PRIORITY,
						title = "Код Дельта",
						message = "Контроль над ситуацией полностью потерян. Всему персоналу требуется сделать всё ради предотвращения распространения опасности на другие объекты.",
						sound = 'sound/misc/airraid.ogg',
						channel_override = SSsounds.random_available_channel(),
						color_override = "purple"
					)
				security_level = SEC_LEVEL_DELTA
				for(var/obj/machinery/door/poddoor/shutters/mainship/D in GLOB.machines)
					if(D.id == "sd_lockdown")
						D.open()
				for(var/obj/machinery/status_display/SD in GLOB.machines)
					if(is_mainship_level(SD.z))
						SD.set_picture("redalert")

		for(var/obj/machinery/firealarm/FA in GLOB.machines)
			if(is_mainship_level(FA.z))
				FA.update_icon()
	else
		return

/datum/marine_main_ship/proc/get_security_level(sec = security_level)
	switch(sec)
		if(SEC_LEVEL_GREEN)
			return "green"
		if(SEC_LEVEL_BLUE)
			return "blue"
		if(SEC_LEVEL_RED)
			return "red"
		if(SEC_LEVEL_DELTA)
			return "delta"

/datum/marine_main_ship/proc/seclevel2num(seclevel)
	switch( lowertext(seclevel) )
		if("green")
			return SEC_LEVEL_GREEN
		if("blue")
			return SEC_LEVEL_BLUE
		if("red")
			return SEC_LEVEL_RED
		if("delta")
			return SEC_LEVEL_DELTA
