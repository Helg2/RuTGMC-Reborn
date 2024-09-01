#define HUG_RANGE 1
#define HUGGER_POUNCE_RANGE 6
#define HUGGER_POUNCE_PARALYZE_DURATION 1 SECONDS
#define HUGGER_POUNCE_STANDBY_DURATION 1 SECONDS
#define HUGGER_POUNCE_WINDUP_DURATION 1 SECONDS
#define HUGGER_POUNCE_SPEED 2


// ***************************************
// *********** Hug
// ***************************************

/datum/action/ability/activable/xeno/pounce/hugger
	desc = "Leap at your target, tackling and disarming them, or if close enough hug it."
	ability_cost = 25
	cooldown_duration = 5 SECONDS
	keybinding_signals = list(KEYBINDING_NORMAL = COMSING_XENOABILITY_HUGGER_POUNCE)
	pounce_range = HUGGER_POUNCE_RANGE
	///Where do we start the leap from
	var/start_turf

/datum/action/ability/activable/xeno/pounce/hugger/pounce_complete()
	. = ..()
	var/mob/living/carbon/xenomorph/caster = owner
	caster.icon_state = "[caster.xeno_caste.caste_name] Walking"

/datum/action/ability/activable/xeno/pounce/hugger/trigger_pounce_effect(mob/living/living_target)
	//TODO: I NEED ACTUAL HUGGERS SOUND DAMMED
	playsound(get_turf(living_target), 'sound/voice/alien/larva/roar3.ogg', 25, TRUE)

	var/mob/living/carbon/xenomorph/facehugger/caster = owner
	caster.set_throwing(FALSE)
	caster.forceMove(get_turf(living_target))
	if(ishuman(living_target))
		var/mob/living/carbon/human/human_target = living_target
		//Check whether we hugged the target or just knocked it down
		if(get_dist(start_turf, human_target) <= HUG_RANGE)
			caster.try_attach(human_target)
		else
			human_target.Paralyze(HUGGER_POUNCE_PARALYZE_DURATION)
			caster.Immobilize(HUGGER_POUNCE_STANDBY_DURATION)

/datum/action/ability/activable/xeno/pounce/hugger/use_ability(atom/target)
	if(owner.layer != MOB_LAYER)
		owner.layer = MOB_LAYER
		var/datum/action/ability/xeno_action/xenohide/hide_action = owner.actions_by_path[/datum/action/ability/xeno_action/xenohide]
		hide_action?.button?.cut_overlay(mutable_appearance('icons/Xeno/actions.dmi', "selected_purple_frame", ACTION_LAYER_ACTION_ICON_STATE, FLOAT_PLANE)) // Removes Hide action icon border
	if(owner.buckled)
		owner.buckled.unbuckle_mob(owner)

	var/mob/living/carbon/xenomorph/caster = owner
	if(!do_after(caster, HUGGER_POUNCE_WINDUP_DURATION, IGNORE_HELD_ITEM, caster, BUSY_ICON_DANGER, extra_checks = CALLBACK(src, PROC_REF(can_use_ability), target, FALSE, ABILITY_USE_BUSY)))
		return fail_activate()

	caster.icon_state = "[caster.xeno_caste.caste_name] Thrown"

	RegisterSignal(owner, COMSIG_MOVABLE_MOVED, PROC_REF(movement_fx))
	RegisterSignal(owner, COMSIG_XENO_OBJ_THROW_HIT, PROC_REF(object_hit))
	RegisterSignal(owner, COMSIG_XENOMORPH_LEAP_BUMP, PROC_REF(mob_hit))
	RegisterSignal(owner, COMSIG_MOVABLE_POST_THROW, PROC_REF(pounce_complete))
	SEND_SIGNAL(owner, COMSIG_XENOMORPH_POUNCE)

	caster.xeno_flags |= XENO_LEAPING // this is needed for throwing code
	caster.pass_flags |= PASS_FIRE
	caster.pass_flags ^= PASS_MOB

	start_turf = get_turf(caster)
	if(ishuman(target) && get_turf(target) == start_turf)
		mob_hit(caster, target)
	else
		caster.throw_at(target, pounce_range, HUGGER_POUNCE_SPEED, caster)
	addtimer(CALLBACK(src, PROC_REF(reset_pass_flags)), 0.6 SECONDS)
	succeed_activate()
	add_cooldown()
	return TRUE

//AI stuff
/datum/action/ability/activable/xeno/pounce/hugger/ai_should_use(atom/target)
	if(!ishuman(target))
		return FALSE
	if(!line_of_sight(owner, target, HUG_RANGE))
		return FALSE
	if(!can_use_ability(target, override_flags = ABILITY_IGNORE_SELECTED_ABILITY))
		return FALSE
	if(target.get_xeno_hivenumber() == owner.get_xeno_hivenumber())
		return FALSE
	action_activate()
	LAZYINCREMENT(owner.do_actions, target)
	addtimer(CALLBACK(src, PROC_REF(decrease_do_action), target), HUGGER_POUNCE_WINDUP_DURATION)
	return TRUE

///Decrease the do_actions of the owner
/datum/action/ability/activable/xeno/pounce/hugger/proc/decrease_do_action(atom/target)
	LAZYDECREMENT(owner.do_actions, target)

#undef HUG_RANGE
#undef HUGGER_POUNCE_RANGE
#undef HUGGER_POUNCE_PARALYZE_DURATION
#undef HUGGER_POUNCE_STANDBY_DURATION
#undef HUGGER_POUNCE_WINDUP_DURATION
#undef HUGGER_POUNCE_SPEED
