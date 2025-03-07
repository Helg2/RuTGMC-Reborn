// ***************************************
// *********** Stomp
// ***************************************
/datum/action/ability/activable/xeno/stomp
	name = "Stomp"
	action_icon_state = "stomp"
	desc = "Knocks all adjacent targets away and down. Deals extra damage if on the same turf with the target. "
	ability_cost = 100
	cooldown_duration = 20 SECONDS
	keybind_flags = ABILITY_KEYBIND_USE_ABILITY
	keybinding_signals = list(KEYBINDING_NORMAL = COMSIG_XENOABILITY_STOMP)

/datum/action/ability/activable/xeno/stomp/use_ability(atom/A)
	var/mob/living/carbon/xenomorph/X = owner
	succeed_activate()
	add_cooldown()

	GLOB.round_statistics.crusher_stomps++
	SSblackbox.record_feedback(FEEDBACK_TALLY, "round_statistics", 1, "crusher_stomps")

	playsound(X.loc, 'sound/effects/bang.ogg', 25, 0)
	X.visible_message(span_xenodanger("[X] smashes into the ground!"), \
	span_xenodanger("We smash into the ground!"))
	X.create_stomp() //Adds the visual effect. Wom wom wom

	for(var/mob/living/M in range(1, get_turf(X)))
		if(X.issamexenohive(M) || M.stat == DEAD || isnestedhost(M))
			continue
		var/damage = X.xeno_caste.stomp_damage
		if(get_dist(M, X) == 0) //If we're on top of our victim, give him the full impact
			GLOB.round_statistics.crusher_stomp_victims++
			SSblackbox.record_feedback(FEEDBACK_TALLY, "round_statistics", 1, "crusher_stomp_victims")
			M.take_overall_damage(damage, BRUTE, MELEE, updating_health = TRUE, penetration = 100, max_limbs = 3)
			M.Paralyze(3 SECONDS)
			to_chat(M, span_highdanger("You are stomped on by [X]!"))
			shake_camera(M, 3, 3)
		else
			step_away(M, X, 1) //Knock away
			shake_camera(M, 2, 2)
			to_chat(M, span_highdanger("You reel from the shockwave of [X]'s stomp!"))
			M.take_overall_damage(damage * 0.5, BRUTE, MELEE, updating_health = TRUE, max_limbs = 3)
			M.Paralyze(0.5 SECONDS)

/datum/action/ability/activable/xeno/stomp/ai_should_start_consider()
	return TRUE

/datum/action/ability/activable/xeno/stomp/ai_should_use(atom/target)
	if(!iscarbon(target))
		return FALSE
	if(get_dist(target, owner) > 1)
		return FALSE
	if(!can_use_ability(target, override_flags = ABILITY_IGNORE_SELECTED_ABILITY))
		return FALSE
	if(target.get_xeno_hivenumber() == owner.get_xeno_hivenumber())
		return FALSE
	return TRUE

// ***************************************
// *********** Cresttoss
// ***************************************
/datum/action/ability/activable/xeno/cresttoss
	name = "Crest Toss Away"
	action_icon_state = "cresttoss_away"
	desc = "Fling an adjacent target away from you. Shares the cooldown with the Crest Toss Behind!"
	ability_cost = 75
	cooldown_duration = 12 SECONDS
	keybinding_signals = list(
		KEYBINDING_NORMAL = COMSIG_XENOABILITY_CRESTTOSS,
	)
	target_flags = ABILITY_MOB_TARGET
	var/tossing_away = TRUE
	var/ability_for_cooldown = /datum/action/ability/activable/xeno/cresttoss/behind

/datum/action/ability/activable/xeno/cresttoss/on_cooldown_finish()
	var/mob/living/carbon/xenomorph/X = owner
	to_chat(X, span_xenowarning("<b>We can now crest toss again.</b>"))
	playsound(X, 'sound/effects/alien/newlarva.ogg', 50, 0, 1)
	return ..()

/datum/action/ability/activable/xeno/cresttoss/can_use_ability(atom/A, silent = FALSE, override_flags)
	. = ..()
	if(!.)
		return FALSE
	if(!owner.Adjacent(A) || isarmoredvehicle(A) || !ismovable(A))
		return FALSE
	var/atom/movable/movable_atom = A
	if(movable_atom.anchored)
		return FALSE
	if(isliving(A))
		var/mob/living/L = A
		if(L.stat == DEAD || isnestedhost(L)) //no bully
			return FALSE

/datum/action/ability/activable/xeno/cresttoss/use_ability(atom/movable/A)
	var/mob/living/carbon/xenomorph/X = owner
	var/toss_distance = X.xeno_caste.crest_toss_distance
	var/toss_direction
	var/turf/throw_origin = get_turf(X)
	var/turf/target_turf = throw_origin //throw distance is measured from the xeno itself
	var/big_mob_message

	X.face_atom(A) //Face towards the target so we don't look silly

	if(!X.issamexenohive(A)) //xenos should be able to fling xenos into xeno passable areas!
		for(var/obj/effect/forcefield/fog/fog in throw_origin)
			A.balloon_alert(X, "Cannot, fog")
			return fail_activate()
	if(isliving(A))
		var/mob/living/L = A
		if(L.mob_size >= MOB_SIZE_BIG) //Penalize toss distance for big creatures
			toss_distance = FLOOR(toss_distance * 0.5, 1)
			big_mob_message = ", struggling mightily to heft its bulk"
	else if(ismecha(A))
		toss_distance = FLOOR(toss_distance * 0.5, 1)
		big_mob_message = ", struggling mightily to heft its bulk"

	if(!tossing_away)
		toss_direction = get_dir(A, X)
	else
		toss_direction = get_dir(X, A)

	var/turf/temp
	for(var/x in 1 to toss_distance)
		temp = get_step(target_turf, toss_direction)
		if(!temp)
			break
		target_turf = temp

	X.icon_state = "Crusher Charging" //Momentarily lower the crest for visual effect

	X.visible_message(span_xenowarning("\The [X] flings [A] away with its crest[big_mob_message]!"), \
	span_xenowarning("We fling [A] away with our crest[big_mob_message]!"))

	succeed_activate()

	A.forceMove(throw_origin)
	A.throw_at(target_turf, toss_distance, 1, X, TRUE, TRUE)

	//Handle the damage
	if(!X.issamexenohive(A) && isliving(A)) //Friendly xenos don't take damage.
		var/damage = toss_distance * 6
		var/mob/living/L = A
		L.take_overall_damage(damage, BRUTE, MELEE, updating_health = TRUE)
		shake_camera(L, 2, 2)
		playsound(A, pick('sound/weapons/alien_claw_block.ogg','sound/weapons/alien_bite2.ogg'), 50, 1)

	add_cooldown()
	addtimer(CALLBACK(X, TYPE_PROC_REF(/mob, update_icons)), 3)

	var/datum/action/ability/xeno_action/toss = X.actions_by_path[ability_for_cooldown]
	if(toss)
		toss.add_cooldown()

/datum/action/ability/activable/xeno/cresttoss/behind
	name = "Crest Toss Behind"
	action_icon_state = "cresttoss_behind"
	desc = "Fling an adjacent target behind you. Also works over barricades. Shares the cooldown with the Crest Toss Away!"
	keybinding_signals = list(
		KEYBINDING_NORMAL = COMSIG_XENOABILITY_CRESTTOSS_BEHIND,
	)
	tossing_away = FALSE
	ability_for_cooldown = /datum/action/ability/activable/xeno/cresttoss

/datum/action/ability/activable/xeno/cresttoss/ai_should_start_consider()
	return TRUE

/datum/action/ability/activable/xeno/cresttoss/ai_should_use(atom/target)
	if(!iscarbon(target))
		return FALSE
	if(get_dist(target, owner) > 1)
		return FALSE
	if(!can_use_ability(target, override_flags = ABILITY_IGNORE_SELECTED_ABILITY))
		return FALSE
	if(target.get_xeno_hivenumber() == owner.get_xeno_hivenumber())
		return FALSE
	return TRUE

// ***************************************
// *********** Advance
// ***************************************
/datum/action/ability/activable/xeno/advance
	name = "Rapid Advance"
	action_icon_state = "crest_defense"
	desc = "Charges up the crushers charge in place, then unleashes the full bulk of the crusher at the target location. Does not crush in diagonal directions."
	ability_cost = 175
	cooldown_duration = 30 SECONDS
	keybinding_signals = list(
		KEYBINDING_NORMAL = COMSIG_XENOABILITY_ADVANCE,
	)
	///Max charge range
	var/advance_range = 7

/datum/action/ability/activable/xeno/advance/on_cooldown_finish()
	to_chat(owner, span_xenowarning("<b>We can now rapidly charge forward again.</b>"))
	playsound(owner, 'sound/effects/alien/newlarva.ogg', 50, 0, 1)
	return ..()

/datum/action/ability/activable/xeno/advance/can_use_ability(atom/A, silent = FALSE, override_flags)
	. = ..()
	if(!.)
		return FALSE

	if(get_dist(owner, A) > advance_range)
		return FALSE


/datum/action/ability/activable/xeno/advance/use_ability(atom/A)
	var/mob/living/carbon/xenomorph/X = owner
	X.face_atom(A)
	X.set_canmove(FALSE)
	if(!do_after(X, 1 SECONDS, NONE, X, BUSY_ICON_DANGER) || (QDELETED(A)) || X.z != A.z)
		if(!X.stat)
			X.set_canmove(TRUE)
		return fail_activate()
	X.set_canmove(TRUE)

	var/datum/action/ability/xeno_action/ready_charge/charge = X.actions_by_path[/datum/action/ability/xeno_action/ready_charge]
	var/aimdir = get_dir(X, A)
	if(charge)
		charge.charge_on(FALSE)
		charge.do_stop_momentum(FALSE) //Reset charge so next_move_limit check_momentum() does not cuck us and 0 out steps_taken
		charge.do_start_crushing()
		charge.valid_steps_taken = charge.max_steps_buildup - 1
		charge.charge_dir = aimdir //Set dir so check_momentum() does not cuck us
	for(var/i=0 to max(get_dist(X, A), advance_range))
		if(i % 2)
			new /obj/effect/temp_visual/after_image(get_turf(X), X)
		X.Move(get_step(X, aimdir), aimdir)
		aimdir = get_dir(X, A)
	succeed_activate()
	add_cooldown()

/datum/action/ability/activable/xeno/advance/ai_should_start_consider()
	return TRUE

/datum/action/ability/activable/xeno/advance/ai_should_use(atom/target)
	if(!iscarbon(target))
		return FALSE
	if(!can_use_ability(target, override_flags = ABILITY_IGNORE_SELECTED_ABILITY))
		return FALSE
	if(target.get_xeno_hivenumber() == owner.get_xeno_hivenumber())
		return FALSE
	return TRUE

// ***************************************
// *********** Regenerate Skin
// ***************************************
/datum/action/ability/xeno_action/regenerate_skin/crusher
	name = "Regenerate Armor"
	action_icon_state = "regenerate_skin"
	desc = "Regenerate your hard exoskeleton armor, removing all sunder."
	use_state_flags = ABILITY_TARGET_SELF|ABILITY_IGNORE_SELECTED_ABILITY
	ability_cost = 400
	cooldown_duration = 90 SECONDS
	keybind_flags = ABILITY_KEYBIND_USE_ABILITY
	keybinding_signals = list(
		KEYBINDING_NORMAL = COMSIG_XENOABILITY_REGENERATE_SKIN,
	)

/datum/action/ability/xeno_action/regenerate_skin/crusher/on_cooldown_finish()
	var/mob/living/carbon/xenomorph/X = owner
	to_chat(X, span_notice("We feel we are ready to shred our armor and grow another."))
	return ..()

/datum/action/ability/xeno_action/regenerate_skin/crusher/action_activate()
	var/mob/living/carbon/xenomorph/crusher/X = owner

	if(!can_use_action(TRUE))
		return fail_activate()

	if(X.on_fire)
		to_chat(X, span_xenowarning("We can't use that while on fire."))
		return fail_activate()

	X.emote("roar")
	X.visible_message(span_warning("The armor on \the [X] shreds and a new layer can be seen in it's place!"),
		span_notice("We shed our armor, showing the fresh new layer underneath!"))

	X.do_jitter_animation(1000)
	X.adjust_sunder(-50)
	add_cooldown()
	return succeed_activate()
