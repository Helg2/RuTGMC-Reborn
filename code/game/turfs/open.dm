//turfs with density = FALSE
/turf/open
	plane = FLOOR_PLANE
	minimap_color = MINIMAP_AREA_COLONY
	resistance_flags = PROJECTILE_IMMUNE|UNACIDABLE
	smoothing_groups = list(SMOOTH_GROUP_OPEN_FLOOR)
	/// Whether you can build things like barricades on this turf.
	var/allow_construction = TRUE
	/// Snow layer
	var/slayer = 0
	/// Whether the turf is wet (only used by floors).
	var/wet = 0
	var/shoefootstep = FOOTSTEP_FLOOR
	var/barefootstep = FOOTSTEP_HARD
	var/mediumxenofootstep = FOOTSTEP_HARD
	var/heavyxenofootstep = FOOTSTEP_GENERIC_HEAVY

/turf/open/examine(mob/user)
	. = ..()
	. += ceiling_desc()

/turf/open/do_acid_melt()
	. = ..()
	scrape_away()

///Checks if anything should override the turf's normal footstep sounds
/turf/open/proc/get_footstep_override(footstep_type)
	var/list/footstep_overrides = list()
	SEND_SIGNAL(src, COMSIG_FIND_FOOTSTEP_SOUND, footstep_overrides)
	if(!length(footstep_overrides))
		return

	var/override_sound
	var/index = 0
	for(var/i in footstep_overrides)
		if(footstep_overrides[i] > index)
			override_sound = i
			index = footstep_overrides[i]
	return override_sound

/turf/open/get_dumping_location()
	return src

// Beach

/turf/open/beach
	name = "beach"
	icon = 'icons/misc/beach.dmi'
	shoefootstep = FOOTSTEP_SAND
	barefootstep = FOOTSTEP_SAND
	mediumxenofootstep = FOOTSTEP_SAND

/turf/open/beach/sand
	name = "sand"
	icon_state = "sand"

/turf/open/beach/coastline
	name = "coastline"
	icon = 'icons/misc/beach2.dmi'
	icon_state = "sandwater"

//SHUTTLE 'FLOORS'
//not a child of turf/open/floor because shuttle floors are magic and don't behave like real floors.

/turf/open/shuttle
	name = "floor"
	icon_state = "floor"
	icon = 'icons/turf/shuttle.dmi'
	allow_construction = FALSE
	shoefootstep = FOOTSTEP_PLATING
	barefootstep = FOOTSTEP_HARD
	mediumxenofootstep = FOOTSTEP_PLATING

/turf/open/shuttle/check_alien_construction(mob/living/builder, silent = FALSE, planned_building)
	if(ispath(planned_building, /turf/closed/wall/)) // Shuttles move and will leave holes in the floor during transit
		if(!silent)
			to_chat(builder, span_warning("This place seems unable to support a wall."))
		return FALSE
	return ..()

/turf/open/shuttle/blackfloor
	icon_state = "floor7"

/turf/open/shuttle/dropship
	name = "floor"
	icon_state = "rasputin1"

/turf/open/shuttle/dropship/two
	icon_state = "rasputin2"

/turf/open/shuttle/dropship/three
	icon_state = "rasputin3"

/turf/open/shuttle/dropship/four
	icon_state = "rasputin4"

/turf/open/shuttle/dropship/five
	icon_state = "rasputin5"

/turf/open/shuttle/dropship/six
	icon_state = "rasputin6"

/turf/open/shuttle/dropship/seven
	icon_state = "rasputin7"

/turf/open/shuttle/dropship/eight
	icon_state = "rasputin8"

/turf/open/shuttle/dropship/nine
	icon_state = "rasputin9"

/turf/open/shuttle/dropship/ten
	icon_state = "rasputin10"

/turf/open/shuttle/dropship/eleven
	icon_state = "rasputin11"

/turf/open/shuttle/dropship/twelve
	icon_state = "rasputin12"

/turf/open/shuttle/dropship/thirteen
	icon_state = "rasputin13"

/turf/open/shuttle/dropship/fourteen
	icon_state = "floor6"

/turf/open/shuttle/dropship/fourteen
	icon_state = "rasputin14"

/turf/open/shuttle/dropship/fifteen
	icon_state = "rasputin15"

/turf/open/shuttle/dropship/sixteen
	icon_state = "rasputin16"

/turf/open/shuttle/dropship/seventeen
	icon_state = "rasputin17"

/turf/open/shuttle/dropship/eighteen
	icon_state = "rasputin18"

/turf/open/shuttle/dropship/nineteen
	icon_state = "rasputin19"

/turf/open/shuttle/dropship/twenty
	icon_state = "rasputin20"

/turf/open/shuttle/dropship/twentyone
	icon_state = "rasputin21"

/turf/open/shuttle/dropship/twentytwo
	icon_state = "rasputin22"

/turf/open/shuttle/dropship/twentythree
	icon_state = "rasputin23"

/turf/open/shuttle/dropship/twentyfour
	icon_state = "rasputin24"

/turf/open/shuttle/dropship/twentyfive
	icon_state = "rasputin25"

/turf/open/shuttle/dropship/twentysix
	icon_state = "rasputin26"

/turf/open/shuttle/dropship/twentyseven
	icon_state = "rasputin27"

/turf/open/shuttle/dropship/twentyeight
	icon_state = "rasputin28"

/turf/open/shuttle/dropship/twentynine
	icon_state = "rasputin29"

/turf/open/shuttle/dropship/thirty
	icon_state = "rasputin30"

/turf/open/shuttle/dropship/thirtyone
	icon_state = "rasputin31"

/turf/open/shuttle/dropship/thirtytwo
	icon_state = "rasputin32"

/turf/open/shuttle/dropship/thirtythree
	icon_state = "rasputin33"

/turf/open/shuttle/dropship/thirtyfour
	icon_state = "rasputin34"

/turf/open/shuttle/dropship/thirtyfive
	icon_state = "rasputin35"

/turf/open/shuttle/dropship/thirtysix
	icon_state = "rasputin36"

/turf/open/shuttle/dropship/thirtyseven
	icon_state = "rasputin37"

/turf/open/shuttle/dropship/thirtyeight
	icon_state = "rasputin38"

/turf/open/shuttle/dropship/thirtynine
	icon_state = "rasputin39"

/turf/open/shuttle/dropship/grating
	icon = 'icons/turf/elevator.dmi'
	icon_state = "floor_grating"

//not really plating, just the look
/turf/open/shuttle/plating
	name = "plating"
	icon = 'icons/turf/floors.dmi'
	icon_state = "plating"

/turf/open/floor/plating/heatinggrate
	icon_state = "heatinggrate"

/turf/open/shuttle/brig // Added this floor tile so that I have a seperate turf to check in the shuttle -- Polymorph
	name = "Brig floor"        // Also added it into the 2x3 brig area of the shuttle.
	icon_state = "floor4"

/turf/open/shuttle/escapepod
	icon = 'icons/turf/escapepods.dmi'
	icon_state = "floor3"

/turf/open/shuttle/escapepod/plain
	icon_state = "floor1"

/turf/open/shuttle/escapepod/zero
	icon_state = "floor0"

/turf/open/shuttle/escapepod/two
	icon_state = "floor2"

/turf/open/shuttle/escapepod/four
	icon_state = "floor4"

/turf/open/shuttle/escapepod/five
	icon_state = "floor5"

/turf/open/shuttle/escapepod/six
	icon_state = "floor6"

/turf/open/shuttle/escapepod/seven
	icon_state = "floor7"

/turf/open/shuttle/escapepod/eight
	icon_state = "floor8"

/turf/open/shuttle/escapepod/nine
	icon_state = "floor9"

/turf/open/shuttle/escapepod/ten
	icon_state = "floor10"

/turf/open/shuttle/escapepod/eleven
	icon_state = "floor11"

/turf/open/shuttle/escapepod/twelve
	icon_state = "floor12"

// Elevator floors
/turf/open/shuttle/elevator
	icon = 'icons/turf/elevator.dmi'
	icon_state = "floor"

/turf/open/shuttle/elevator/grating
	icon_state = "floor_grating"

// LAVA

/turf/open/lavaland
	icon = 'icons/turf/lava.dmi'
	plane = FLOOR_PLANE
	baseturfs = /turf/open/liquid/lava

/turf/open/lavaland/basalt
	name = "basalt"
	icon_state = "basalt"
	shoefootstep = FOOTSTEP_GRAVEL
	barefootstep = FOOTSTEP_GRAVEL
	mediumxenofootstep = FOOTSTEP_GRAVEL

/turf/open/lavaland/basalt/cave
	name = "cave"
	icon_state = "basalt_to_cave"

/turf/open/lavaland/basalt/cave/corner
	name = "cave"
	icon_state = "basalt_to_cave_corner"

/turf/open/lavaland/basalt/cave/autosmooth
	icon = 'icons/turf/floors/cave-basalt.dmi'
	icon_state = "cave-basalt-icon"
	base_icon_state = "cave-basalt"
	smoothing_flags = SMOOTH_BITMASK
	smoothing_groups = list(SMOOTH_GROUP_BASALT)
	canSmoothWith = list(
		SMOOTH_GROUP_BASALT,
		SMOOTH_GROUP_OPEN_FLOOR,
		SMOOTH_GROUP_MINERAL_STRUCTURES,
		SMOOTH_GROUP_WINDOW_FULLTILE,
		SMOOTH_GROUP_SURVIVAL_TITANIUM_WALLS,
		SMOOTH_GROUP_AIRLOCK,
		SMOOTH_GROUP_WINDOW_FRAME,
		SMOOTH_GROUP_SAND,
	)

/turf/open/lavaland/basalt/dirt
	name = "dirt"
	icon_state = "basalt_to_dirt"

/turf/open/lavaland/basalt/dirt/corner
	name = "dirt"
	icon_state = "basalt_to_dirt_corner"

/turf/open/lavaland/basalt/dirt/autosmoothing
	icon = 'icons/turf/floors/basalt-dirt.dmi'
	icon_state = "basalt-dirt-icon"
	base_icon_state = "basalt-dirt"
	smoothing_flags = SMOOTH_BITMASK
	smoothing_groups = list(SMOOTH_GROUP_BASALT)
	canSmoothWith = list(
		SMOOTH_GROUP_BASALT,
		SMOOTH_GROUP_OPEN_FLOOR,
		SMOOTH_GROUP_MINERAL_STRUCTURES,
		SMOOTH_GROUP_WINDOW_FULLTILE,
		SMOOTH_GROUP_SURVIVAL_TITANIUM_WALLS,
		SMOOTH_GROUP_AIRLOCK,
		SMOOTH_GROUP_WINDOW_FRAME,
	)

/turf/open/lavaland/basalt/glowing
	icon_state = "basaltglow"
	light_system = STATIC_LIGHT
	light_range = 4
	light_power = 0.75
	light_color = LIGHT_COLOR_LAVA
