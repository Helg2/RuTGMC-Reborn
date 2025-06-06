/atom/movable/screen/plane_master
	screen_loc = "CENTER"
	icon_state = "blank"
	appearance_flags = PLANE_MASTER|NO_CLIENT_COLOR
	blend_mode = BLEND_OVERLAY
	plane = LOWEST_EVER_PLANE
	var/show_alpha = 255
	var/hide_alpha = 0

	//--rendering relay vars--
	///integer: what plane we will relay this planes render to
	var/render_relay_plane = RENDER_PLANE_GAME
	///bool: Whether this plane should get a render target automatically generated
	var/generate_render_target = TRUE
	///integer: blend mode to apply to the render relay in case you dont want to use the plane_masters blend_mode
	var/blend_mode_override
	///reference to render relay screen object to avoid backdropping multiple times
	var/atom/movable/render_plane_relay/relay

	/// If our plane master allows for offsetting
	/// Mostly used for planes that really don't need to be duplicated, like the hud planes
	var/allows_offsetting = TRUE
	/// Our offset from our "true" plane, see below
	var/offset
	/// When rendering multiz, lower levels get their own set of plane masters
	/// Real plane here represents the "true" plane value of something, ignoring the offset required to handle lower levels
	var/real_plane

	/// list of current relays this plane is utilizing to render
	var/list/atom/movable/render_plane_relay/relays = list()

	/// If this plane master should be hidden from the player at roundstart
	/// We do this so PMs can opt into being temporary, to reduce load on clients
	var/start_hidden = FALSE
	/// If this plane master is being forced to hide.
	/// Hidden PMs will dump ANYTHING relayed or drawn onto them. Be careful with this
	/// Remember: a hidden plane master will dump anything drawn directly to it onto the output render. It does NOT hide its contents
	/// Use alpha for that
	var/force_hidden = FALSE

	/// If this plane should be scaled by multiz
	/// Planes with this set should NEVER be relay'd into each other, as that will cause visual fuck
	var/multiz_scaled = TRUE

	/// Bitfield that describes how this plane master will render if its z layer is being "optimized"
	/// If a plane master is NOT critical, it will be completely dropped if we start to render outside a client's multiz boundary prefs
	/// Of note: most of the time we will relay renders to non critical planes in this stage. so the plane master will end up drawing roughly "in order" with its friends
	/// This is NOT done for parallax and other problem children, because the rules of BLEND_MULTIPLY appear to not behave as expected :(
	/// This will also just make debugging harder, because we do fragile things in order to ensure things operate as epected. I'm sorry
	/// Compile time
	/// See [code\__DEFINES\layers.dm] for our bitflags
	var/critical = NONE

	/// If this plane master is outside of our visual bounds right now
	var/is_outside_bounds = FALSE

/atom/movable/screen/plane_master/proc/Show(override)
	alpha = override || show_alpha

/// Shows a plane master to the passed in mob
/// Override this to apply unique effects and such
/// Returns TRUE if the call is allowed, FALSE otherwise
/atom/movable/screen/plane_master/proc/show_to(mob/mymob)
	SHOULD_CALL_PARENT(TRUE)
	if(force_hidden)
		return FALSE

	var/client/our_client = mymob?.canon_client
	// Alright, let's get this out of the way
	// Mobs can move z levels without their client. If this happens, we need to ensure critical display settings are respected
	// This is done here. Mild to severe pain but it's nessesary
	if(check_outside_bounds())
		if(!(critical & PLANE_CRITICAL_DISPLAY))
			return FALSE
		if(!our_client)
			return TRUE
		our_client.screen += src

		if(!(critical & PLANE_CRITICAL_NO_RELAY))
			our_client.screen += relays
			return TRUE
		return TRUE

	if(!our_client)
		return TRUE

	our_client.screen += src
	our_client.screen += relays
	return TRUE

/// Hook to allow planes to work around is_outside_bounds
/// Return false to allow a show, true otherwise
/atom/movable/screen/plane_master/proc/check_outside_bounds()
	return is_outside_bounds

/atom/movable/screen/plane_master/proc/Hide(override)
	alpha = override || hide_alpha

/// Hides a plane master from the passeed in mob
/// Do your effect cleanup here
/atom/movable/screen/plane_master/proc/hide_from(mob/oldmob)
	SHOULD_CALL_PARENT(TRUE)
	var/client/their_client = oldmob?.client
	if(!their_client)
		return
	their_client.screen -= src
	their_client.screen -= relays

/// Forces this plane master to hide, until unhide_plane is called
/// This allows us to disable unused PMs without breaking anything else
/atom/movable/screen/plane_master/proc/hide_plane(mob/cast_away)
	force_hidden = TRUE
	hide_from(cast_away)

/// Disables any forced hiding, allows the plane master to be used as normal
/atom/movable/screen/plane_master/proc/unhide_plane(mob/enfold)
	force_hidden = FALSE
	show_to(enfold)

/atom/movable/screen/plane_master/proc/outside_bounds(mob/relevant)
	if(force_hidden || is_outside_bounds)
		return
	is_outside_bounds = TRUE
	// If we're of critical importance, AND we're below the rendering layer
	if(critical & PLANE_CRITICAL_DISPLAY)
		// We here assume that your render target starts with *
		if(critical & PLANE_CRITICAL_CUT_RENDER && render_target)
			render_target = copytext_char(render_target, 2)
		if(!(critical & PLANE_CRITICAL_NO_RELAY))
			return
		var/client/our_client = relevant.client
		if(our_client)
			for(var/atom/movable/render_plane_relay/relay as anything in relays)
				our_client.screen -= relay

		return
	hide_from(relevant)

/atom/movable/screen/plane_master/proc/inside_bounds(mob/relevant)
	is_outside_bounds = FALSE
	if(critical & PLANE_CRITICAL_DISPLAY)
		// We here assume that your render target starts with *
		if(critical & PLANE_CRITICAL_CUT_RENDER && render_target)
			render_target = "*[render_target]"

		if(!(critical & PLANE_CRITICAL_NO_RELAY))
			return
		var/client/our_client = relevant.client
		if(our_client)
			for(var/atom/movable/render_plane_relay/relay as anything in relays)
				our_client.screen += relay

		return
	show_to(relevant)

//Why do plane masters need a backdrop sometimes? Read https://secure.byond.com/forum/?post=2141928
//Trust me, you need one. Period. If you don't think you do, you're doing something extremely wrong.
/atom/movable/screen/plane_master/proc/backdrop(mob/mymob)
	SHOULD_CALL_PARENT(TRUE)
	if(!isnull(render_relay_plane))
		relay_render_to_plane(mymob, render_relay_plane)

///Things rendered on "openspace"; holes in multi-z
/atom/movable/screen/plane_master/openspace_backdrop
	name = "open space backdrop plane master"
	plane = OPENSPACE_BACKDROP_PLANE
	appearance_flags = PLANE_MASTER
	blend_mode = BLEND_MULTIPLY
	alpha = 255
	render_relay_plane = RENDER_PLANE_GAME

/atom/movable/screen/plane_master/openspace
	name = "open space plane master"
	plane = OPENSPACE_PLANE
	appearance_flags = PLANE_MASTER
	render_relay_plane = RENDER_PLANE_GAME

/atom/movable/screen/plane_master/openspace/Initialize(mapload, datum/hud/hud_owner)
	. = ..()
	add_filter("first_stage_openspace", 1, drop_shadow_filter(color = "#04080FAA", size = -10))
	add_filter("second_stage_openspace", 2, drop_shadow_filter(color = "#04080FAA", size = -15))
	add_filter("third_stage_openspace", 3, drop_shadow_filter(color = "#04080FAA", size = -20))

///Contains just the floor
/atom/movable/screen/plane_master/floor
	name = "floor plane master"
	plane = FLOOR_PLANE
	appearance_flags = PLANE_MASTER
	blend_mode = BLEND_OVERLAY

/atom/movable/screen/plane_master/floor/backdrop(mob/living/mymob)
	. = ..()
	clear_filters()
	if(!istype(mymob) || !mymob.eye_blurry || SEND_SIGNAL(mymob, COMSIG_LIVING_UPDATE_PLANE_BLUR) & COMPONENT_CANCEL_BLUR)
		return
	add_filter("eye_blur", 1, gauss_blur_filter(clamp(mymob.eye_blurry * 0.1, 0.6, 3)))

///Contains most things in the game world
/atom/movable/screen/plane_master/game_world
	name = "game world plane master"
	plane = GAME_PLANE
	appearance_flags = PLANE_MASTER //should use client color
	blend_mode = BLEND_OVERLAY

/atom/movable/screen/plane_master/game_world/backdrop(mob/living/mymob)
	. = ..()
	clear_filters()
	add_filter("AO", 1, drop_shadow_filter(x = 0, y = -2, size = 4, color = "#04080FAA"))
	if(!istype(mymob) || !mymob.eye_blurry || SEND_SIGNAL(mymob, COMSIG_LIVING_UPDATE_PLANE_BLUR) & COMPONENT_CANCEL_BLUR)
		return
	add_filter("eye_blur", 1, gauss_blur_filter(clamp(mymob.eye_blurry * 0.1, 0.6, 3)))

//Holds the seethrough versions (done using image overrides) of large objects. Mouse transparent, so you can click through them.
/atom/movable/screen/plane_master/seethrough
	name = "Seethrough"
	plane = SEETHROUGH_PLANE
	mouse_opacity = MOUSE_OPACITY_TRANSPARENT
	render_relay_plane = RENDER_PLANE_GAME

/**
 * Plane master handling byond internal blackness
 * vars are set as to replicate behavior when rendering to other planes
 * do not touch this unless you know what you are doing
 */
/atom/movable/screen/plane_master/blackness
	name = "darkness plane master"
	plane = BLACKNESS_PLANE
	mouse_opacity = MOUSE_OPACITY_TRANSPARENT
	blend_mode = BLEND_MULTIPLY
	appearance_flags = PLANE_MASTER | NO_CLIENT_COLOR | PIXEL_SCALE
	//byond internal end
	render_relay_plane = RENDER_PLANE_GAME


/*!
 * This system works by exploiting BYONDs color matrix filter to use layers to handle emissive blockers.
 *
 * Emissive overlays are pasted with an atom color that converts them to be entirely some specific color.
 * Emissive blockers are pasted with an atom color that converts them to be entirely some different color.
 * Emissive overlays and emissive blockers are put onto the same plane.
 * The layers for the emissive overlays and emissive blockers cause them to mask eachother similar to normal BYOND objects.
 * A color matrix filter is applied to the emissive plane to mask out anything that isn't whatever the emissive color is.
 * This is then used to alpha mask the lighting plane.
 */

///Contains all lighting objects
/atom/movable/screen/plane_master/lighting
	name = "lighting plane master"
	plane = LIGHTING_PLANE
	blend_mode_override = BLEND_MULTIPLY
	mouse_opacity = MOUSE_OPACITY_TRANSPARENT

/atom/movable/screen/plane_master/lighting/backdrop(mob/mymob)
	. = ..()
	mymob.overlay_fullscreen("lighting_backdrop", /atom/movable/screen/fullscreen/lighting_backdrop/backplane)
	mymob.overlay_fullscreen("lighting_backdrop_lit_secondary", /atom/movable/screen/fullscreen/lighting_backdrop/lit_secondary)

/atom/movable/screen/plane_master/lighting/Initialize(mapload, datum/hud/hud_owner)
	. = ..()
	add_filter("emissives", 1, alpha_mask_filter(render_source = EMISSIVE_RENDER_TARGET, flags = MASK_INVERSE))
	add_filter("object_lighting", 2, alpha_mask_filter(render_source = O_LIGHTING_VISUAL_RENDER_TARGET, flags = MASK_INVERSE))

/**
 * Handles emissive overlays and emissive blockers.
 */
/atom/movable/screen/plane_master/emissive
	name = "emissive plane master"
	plane = EMISSIVE_PLANE
	mouse_opacity = MOUSE_OPACITY_TRANSPARENT
	render_target = EMISSIVE_RENDER_TARGET
	render_relay_plane = null

/atom/movable/screen/plane_master/emissive/Initialize(mapload, datum/hud/hud_owner)
	. = ..()
	add_filter("em_block_masking", 1, color_matrix_filter(GLOB.em_mask_matrix))

/atom/movable/screen/plane_master/above_lighting
	name = "above lighting plane master"
	plane = ABOVE_LIGHTING_PLANE
	appearance_flags = PLANE_MASTER //should use client color
	blend_mode = BLEND_OVERLAY
	render_relay_plane = RENDER_PLANE_GAME

///Contains space parallax
/atom/movable/screen/plane_master/parallax
	name = "parallax plane master"
	plane = PLANE_SPACE_PARALLAX
	blend_mode = BLEND_MULTIPLY
	mouse_opacity = MOUSE_OPACITY_TRANSPARENT

/atom/movable/screen/plane_master/parallax_white
	name = "parallax whitifier plane master"
	plane = PLANE_SPACE

/atom/movable/screen/plane_master/camera_static
	name = "camera static plane master"
	plane = CAMERA_STATIC_PLANE
	appearance_flags = PLANE_MASTER
	blend_mode = BLEND_OVERLAY

/atom/movable/screen/plane_master/o_light_visual
	name = "overlight light visual plane master"
	plane = O_LIGHTING_VISUAL_PLANE
	render_target = O_LIGHTING_VISUAL_RENDER_TARGET
	mouse_opacity = MOUSE_OPACITY_TRANSPARENT
	blend_mode = BLEND_MULTIPLY
	blend_mode_override = BLEND_MULTIPLY

/atom/movable/screen/plane_master/fullscreen
	name = "fullscreen alert plane"
	plane = FULLSCREEN_PLANE
	render_relay_plane = RENDER_PLANE_NON_GAME
	mouse_opacity = MOUSE_OPACITY_TRANSPARENT

/atom/movable/screen/plane_master/gravpulse
	name = "gravpulse plane"
	mouse_opacity = MOUSE_OPACITY_TRANSPARENT
	plane = GRAVITY_PULSE_PLANE
	render_target = GRAVITY_PULSE_RENDER_TARGET
	blend_mode = BLEND_ADD
	blend_mode_override = BLEND_ADD
	render_relay_plane = null

/atom/movable/screen/plane_master/balloon_chat
	name = "balloon alert plane"
	plane = BALLOON_CHAT_PLANE
	render_relay_plane = RENDER_PLANE_NON_GAME

/atom/movable/screen/plane_master/pipecrawl
	name = "pipecrawl plane master"
	plane = ABOVE_HUD_LAYER
	appearance_flags = PLANE_MASTER
	blend_mode = BLEND_OVERLAY

/atom/movable/screen/plane_master/pipecrawl/Initialize(mapload)
	. = ..()
	// Makes everything on this plane slightly brighter
	// Has a nice effect, makes thing stand out
	color = list(1.2,0,0,0, 0,1.2,0,0, 0,0,1.2,0, 0,0,0,1, 0,0,0,0)
	// This serves a similar purpose, I want the pipes to pop
	add_filter("pipe_dropshadow", 1, drop_shadow_filter(x = -1, y= -1, size = 1, color = "#0000007A"))

