/// How long the chat message's spawn-in animation will occur for
#define CHAT_MESSAGE_SPAWN_TIME 0.2 SECONDS
/// How long the chat message will exist prior to any exponential decay
#define CHAT_MESSAGE_LIFESPAN 5 SECONDS
/// How long the chat message's end of life fading animation will occur for
#define CHAT_MESSAGE_EOL_FADE 0.7 SECONDS
/// Grace period for fade before we actually delete the chat message
#define CHAT_MESSAGE_GRACE_PERIOD (0.2 SECONDS)
/// Factor of how much the message index (number of messages) will account to exponential decay
#define CHAT_MESSAGE_EXP_DECAY 0.7
/// Factor of how much height will account to exponential decay
#define CHAT_MESSAGE_HEIGHT_DECAY 0.9
/// Approximate height in pixels of an 'average' line, used for height decay
#define CHAT_MESSAGE_APPROX_LHEIGHT 11
/// Max width of chat message in pixels
#define CHAT_MESSAGE_WIDTH 112
/// Max length of chat message in characters
#define CHAT_MESSAGE_MAX_LENGTH 110
/// Maximum precision of float before rounding errors occur (in this context)
#define CHAT_LAYER_Z_STEP 0.0001
/// The number of z-layer 'slices' usable by the chat message layering
#define CHAT_LAYER_MAX_Z (CHAT_LAYER_MAX - CHAT_LAYER) / CHAT_LAYER_Z_STEP

/**
 * # Chat Message Overlay
 *
 * Datum for generating a message overlay on the map
 */
/datum/chatmessage
	/// The visual element of the chat messsage
	var/image/message
	/// The location in which the message is appearing
	var/atom/message_loc
	/// The client who heard this message
	var/client/owned_by
	/// Contains the approximate amount of lines for height decay
	var/approx_lines
	/// The current index used for adjusting the layer of each sequential chat message such that recent messages will overlay older ones
	var/static/current_z_idx = 0
	/// When we started animating the message
	var/animate_start = 0
	/// Our animation lifespan, how long this message will last
	var/animate_lifespan = 0


/**
 * Constructs a chat message overlay
 *
 * Arguments:
 * * text - The text content of the overlay
 * * target - The target atom to display the overlay at
 * * owner - The mob that owns this overlay, only this mob will be able to view it
 * * extra_classes - Extra classes to apply to the span that holds the text
 * * lifespan - The lifespan of the message in deciseconds
 */
/datum/chatmessage/New(text, atom/target, mob/owner, list/extra_classes = list(), lifespan = CHAT_MESSAGE_LIFESPAN)
	. = ..()
	if (!istype(target))
		CRASH("Invalid target given for chatmessage")
	if(QDELETED(owner) || !istype(owner) || !owner.client)
		stack_trace("/datum/chatmessage created with [isnull(owner) ? "null" : "invalid"] mob owner")
		qdel(src)
		return
	INVOKE_ASYNC(src, PROC_REF(generate_image), text, target, owner, extra_classes, lifespan)

/datum/chatmessage/Destroy()
	if (!QDELING(owned_by))
		if(REALTIMEOFDAY < animate_start + animate_lifespan)
			stack_trace("Del'd before we finished fading, with [(animate_start + animate_lifespan) - REALTIMEOFDAY] time left")

		if (owned_by.seen_messages)
			LAZYREMOVEASSOC(owned_by.seen_messages, message_loc, src)
		owned_by.images.Remove(message)

	owned_by = null
	message_loc = null
	message = null
	return ..()


/**
 * Calls qdel on the chatmessage when its parent is deleted, used to register qdel signal
 */
/datum/chatmessage/proc/on_parent_qdel()
	SIGNAL_HANDLER
	qdel(src)


/**
 * Generates a chat message image representation
 *
 * Arguments:
 * * text - The text content of the overlay
 * * target - The target atom to display the overlay at
 * * owner - The mob that owns this overlay, only this mob will be able to view it
 * * extra_classes - Extra classes to apply to the span that holds the text
 * * lifespan - The lifespan of the message in deciseconds
 */
/datum/chatmessage/proc/generate_image(text, atom/target, mob/owner, list/extra_classes, lifespan)
	if(!owner.client)
		return
	// Register client who owns this message
	owned_by = owner.client
	RegisterSignal(owned_by, COMSIG_QDELETING, PROC_REF(on_parent_qdel))


	// Clip message
	var/maxlen = owned_by.prefs.max_chat_length
	if (length_char(text) > maxlen)
		text = copytext_char(text, 1, maxlen + 1) + "..." // BYOND index moment

	// Calculate target color if not already present
	if (!target.chat_color || target.chat_color_name != target.name)
		target.chat_color = colorize_string(target.name)
		target.chat_color_darkened = colorize_string(target.name, 0.85, 0.85)
		target.chat_color_name = target.name

	// Get rid of any URL schemes that might cause BYOND to automatically wrap something in an anchor tag
	var/static/regex/url_scheme = new(@"[A-Za-z][A-Za-z0-9+-\.]*:\/\/", "g")
	text = replacetext(text, url_scheme, "")

	// Reject whitespace
	var/static/regex/whitespace = new(@"^\s*$")
	if (whitespace.Find(text))
		qdel(src)
		return

	// Non mobs speakers can be small
	if (!ismob(target))
		extra_classes |= "small"

	// Why are you yelling?
	if(copytext_char(text, -2) == "!!")
		extra_classes |= SPAN_YELL

	// Append radio icon if from a virtual speaker
	if (extra_classes.Find("virtual-speaker"))
		var/image/r_icon = image('icons/UI_Icons/chat_icons.dmi', icon_state = "radio")
		text = "\icon[r_icon]&nbsp;[text]"
	else if (extra_classes.Find("emote"))
		var/image/r_icon = image('icons/UI_Icons/chat_icons.dmi', icon_state = "emote")
		text = "\icon[r_icon]&nbsp;[text]"

	// We dim italicized text to make it more distinguishable from regular text
	var/tgt_color = extra_classes.Find("italics") ? target.chat_color_darkened : target.chat_color


	var/complete_text = "<span style='color: [tgt_color]'><span class='center [extra_classes.Join(" ")]'>[owner.say_emphasis(text)]</span></span>"

	var/mheight
	WXH_TO_HEIGHT(owned_by.MeasureText(complete_text, null, CHAT_MESSAGE_WIDTH), mheight)

	if(!VERB_SHOULD_YIELD)
		return finish_image_generation(mheight, target, owner, complete_text, lifespan)

	var/datum/callback/our_callback = CALLBACK(src, PROC_REF(finish_image_generation), mheight, target, owner, complete_text, lifespan)
	SSrunechat.message_queue += our_callback
	return


///finishes the image generation after the MeasureText() call in generate_image().
///necessary because after that call the proc can resume at the end of the tick and cause overtime.
/datum/chatmessage/proc/finish_image_generation(mheight, atom/target, mob/owner, complete_text, lifespan)
	var/rough_time = REALTIMEOFDAY
	approx_lines = max(1, mheight / CHAT_MESSAGE_APPROX_LHEIGHT)
	var/starting_height = target.maptext_height

	// Translate any existing messages upwards, apply exponential decay factors to timers
	message_loc = isturf(target) ? target : get_atom_on_turf(target)
	if (owned_by.seen_messages)
		var/idx = 1
		var/combined_height = approx_lines
		for(var/datum/chatmessage/m as anything in owned_by.seen_messages[message_loc])
			combined_height += m.approx_lines

			var/time_spent = rough_time - m.animate_start
			var/time_before_fade = m.animate_lifespan - CHAT_MESSAGE_EOL_FADE

			// When choosing to update the remaining time we have to be careful not to update the
			// scheduled time once the EOL has been executed.
			var/continuing = 0
			if (time_spent >= time_before_fade)
				if(m.message.pixel_y < starting_height)
					var/max_height = m.message.pixel_y + m.approx_lines * CHAT_MESSAGE_APPROX_LHEIGHT - starting_height
					if(max_height > 0)
						animate(m.message, pixel_y = m.message.pixel_y + max_height, time = CHAT_MESSAGE_SPAWN_TIME, flags = continuing | ANIMATION_PARALLEL)
						continuing |= ANIMATION_CONTINUE
				else if(mheight + starting_height >= m.message.pixel_y)
					animate(m.message, pixel_y = m.message.pixel_y + mheight, time = CHAT_MESSAGE_SPAWN_TIME, flags = continuing | ANIMATION_PARALLEL)
					continuing |= ANIMATION_CONTINUE
				continue

			var/remaining_time = time_before_fade * (CHAT_MESSAGE_EXP_DECAY ** idx++) * (CHAT_MESSAGE_HEIGHT_DECAY ** combined_height)
			// Ensure we don't accidentially spike alpha up or something silly like that
			m.message.alpha = m.get_current_alpha(time_spent)
			if(remaining_time > 0)
				if(time_spent < CHAT_MESSAGE_SPAWN_TIME)
					// We haven't even had the time to fade in yet!
					animate(m.message, alpha = 255, CHAT_MESSAGE_SPAWN_TIME - time_spent, flags=continuing)
					continuing |= ANIMATION_CONTINUE
				// Stay faded in for a while, then
				animate(m.message, alpha = 255, time = remaining_time, flags=continuing)
				continuing |= ANIMATION_CONTINUE
				// Fade out
				animate(m.message, alpha = 0, time = CHAT_MESSAGE_EOL_FADE, flags=continuing)
				continuing |= ANIMATION_CONTINUE
				m.animate_lifespan = remaining_time + CHAT_MESSAGE_EOL_FADE
			else
				// Your time has come my son
				animate(m.message, alpha = 0, time = CHAT_MESSAGE_EOL_FADE, flags=continuing)
				continuing |= ANIMATION_CONTINUE
			// We run this after the alpha animate, because we don't want to interrup it, but also don't want to block it by running first
			// Sooo instead we do this. bit messy but it fuckin works
			if(m.message.pixel_y < starting_height)
				var/max_height = m.message.pixel_y + m.approx_lines * CHAT_MESSAGE_APPROX_LHEIGHT - starting_height
				if(max_height > 0)
					animate(m.message, pixel_y = m.message.pixel_y + max_height, time = CHAT_MESSAGE_SPAWN_TIME, flags = continuing | ANIMATION_PARALLEL)
					continuing |= ANIMATION_CONTINUE
			else if(mheight + starting_height >= m.message.pixel_y)
				animate(m.message, pixel_y = m.message.pixel_y + mheight, time = CHAT_MESSAGE_SPAWN_TIME, flags = continuing | ANIMATION_PARALLEL)
				continuing |= ANIMATION_CONTINUE

		// Reset z index if relevant
	if (current_z_idx >= CHAT_LAYER_MAX_Z)
		current_z_idx = 0

	// Build message image
	message = image(loc = message_loc, layer = CHAT_LAYER + CHAT_LAYER_Z_STEP * current_z_idx++)
	message.plane = GAME_PLANE
	message.appearance_flags = APPEARANCE_UI_IGNORE_ALPHA | KEEP_APART
	message.alpha = 0
	message.pixel_y = starting_height
	message.maptext_width = CHAT_MESSAGE_WIDTH
	message.maptext_height = mheight * 1.25 // We add extra because some characters are superscript, like actions
	message.maptext_x = (CHAT_MESSAGE_WIDTH - owner.bound_width) * -0.5
	message.maptext = MAPTEXT(complete_text)

	animate_start = rough_time
	animate_lifespan = lifespan

	// View the message
	LAZYADDASSOC(owned_by.seen_messages, message_loc, src)
	owned_by.images |= message

	// Fade in
	animate(message, alpha = 255, time = CHAT_MESSAGE_SPAWN_TIME)
	var/time_before_fade = lifespan - CHAT_MESSAGE_SPAWN_TIME - CHAT_MESSAGE_EOL_FADE
	// Stay faded in
	animate(alpha = 255, time = time_before_fade)
	// Fade out
	animate(alpha = 0, time = CHAT_MESSAGE_EOL_FADE)

	// Register with the runechat SS to handle destruction
	addtimer(CALLBACK(GLOBAL_PROC, GLOBAL_PROC_REF(qdel), src), lifespan + CHAT_MESSAGE_GRACE_PERIOD, TIMER_DELETE_ME, SSrunechat)

/datum/chatmessage/proc/get_current_alpha(time_spent)
	if(time_spent < CHAT_MESSAGE_SPAWN_TIME)
		return (time_spent / CHAT_MESSAGE_SPAWN_TIME) * 255

	var/time_before_fade = animate_lifespan - CHAT_MESSAGE_EOL_FADE
	if(time_spent <= time_before_fade)
		return 255

	return (1 - ((time_spent - time_before_fade) / CHAT_MESSAGE_EOL_FADE)) * 255

/**
 * Creates a message overlay at a defined location for a given speaker
 *
 * Arguments:
 * * speaker - The atom who is saying this message
 * * message_language - The language that the message is said in
 * * raw_message - The text content of the message
 * * spans - Additional classes to be added to the message
 * * message_mode - String relating to the mode of the message
 * * runechat_flags - Bitflags relating to the message
 */
/mob/proc/create_chat_message(atom/speaker, datum/language/message_language, raw_message, list/spans, message_mode, runechat_flags = NONE)
	// Ensure the list we are using, if present, is a copy so we don't modify the list provided to us
	spans = spans ? spans.Copy() : list()

	// Check for virtual speakers (aka hearing a message through a radio)
	var/atom/originalSpeaker = speaker
	if (istype(speaker, /atom/movable/virtualspeaker))
		var/atom/movable/virtualspeaker/v = speaker
		speaker = v.source
		spans |= "virtual-speaker"

	// Ignore virtual speaker (most often radio messages) from ourself
	if (originalSpeaker != src && speaker == src)
		return

	// Display visual above source
	if(runechat_flags & (COMBAT_MESSAGE|EMOTE_MESSAGE))
		new /datum/chatmessage(raw_message, speaker, src, (runechat_flags & EMOTE_MESSAGE ? list("emote", "italics") : list("italics")))
	else
		new /datum/chatmessage(lang_treat(speaker, message_language, raw_message, spans, null, TRUE), speaker, src, spans)


// Tweak these defines to change the available color ranges
#define CM_COLOR_SAT_MIN 0.6
#define CM_COLOR_SAT_MAX 0.7
#define CM_COLOR_LUM_MIN 0.65
#define CM_COLOR_LUM_MAX 0.75

/**
 * Gets a color for a name, will return the same color for a given string consistently within a round.atom
 *
 * Note that this proc aims to produce pastel-ish colors using the HSL colorspace. These seem to be favorable for displaying on the map.
 *
 * Arguments:
 * * name - The name to generate a color for
 * * sat_shift - A value between 0 and 1 that will be multiplied against the saturation
 * * lum_shift - A value between 0 and 1 that will be multiplied against the luminescence
 */
/datum/chatmessage/proc/colorize_string(name, sat_shift = 1, lum_shift = 1)
	// seed to help randomness
	var/static/rseed = rand(1,26)

	// get hsl using the selected 6 characters of the md5 hash
	var/hash = copytext(md5(name + GLOB.round_id), rseed, rseed + 6)
	var/h = hex2num(copytext(hash, 1, 3)) * (360 / 255)
	var/s = (hex2num(copytext(hash, 3, 5)) >> 2) * ((CM_COLOR_SAT_MAX - CM_COLOR_SAT_MIN) / 63) + CM_COLOR_SAT_MIN
	var/l = (hex2num(copytext(hash, 5, 7)) >> 2) * ((CM_COLOR_LUM_MAX - CM_COLOR_LUM_MIN) / 63) + CM_COLOR_LUM_MIN

	// adjust for shifts
	s *= clamp(sat_shift, 0, 1)
	l *= clamp(lum_shift, 0, 1)

	// convert to rgb
	var/h_int = round(h/60) // mapping each section of H to 60 degree sections
	var/c = (1 - abs(2 * l - 1)) * s
	var/x = c * (1 - abs((h / 60) % 2 - 1))
	var/m = l - c * 0.5
	x = (x + m) * 255
	c = (c + m) * 255
	m *= 255
	switch(h_int)
		if(0)
			return "#[num2hex(c, 2)][num2hex(x, 2)][num2hex(m, 2)]"
		if(1)
			return "#[num2hex(x, 2)][num2hex(c, 2)][num2hex(m, 2)]"
		if(2)
			return "#[num2hex(m, 2)][num2hex(c, 2)][num2hex(x, 2)]"
		if(3)
			return "#[num2hex(m, 2)][num2hex(x, 2)][num2hex(c, 2)]"
		if(4)
			return "#[num2hex(x, 2)][num2hex(m, 2)][num2hex(c, 2)]"
		if(5)
			return "#[num2hex(c, 2)][num2hex(m, 2)][num2hex(x, 2)]"
