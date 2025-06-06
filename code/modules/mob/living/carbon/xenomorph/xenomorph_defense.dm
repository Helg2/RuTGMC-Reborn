/*
Contains most of the procs that are called when a xeno is attacked by something
*/

/mob/living/carbon/xenomorph/screech_act(mob/living/carbon/xenomorph/queen/Q)
	return

/mob/living/carbon/xenomorph/has_smoke_protection()
	return TRUE

/mob/living/carbon/xenomorph/smoke_contact(obj/effect/particle_effect/smoke/S)
	var/protection = max(1 - get_permeability_protection() * S.bio_protection) //0.2 by default
	if(CHECK_BITFIELD(S.smoke_traits, SMOKE_EXTINGUISH))
		ExtinguishMob()
	if(CHECK_BITFIELD(S.smoke_traits, SMOKE_BLISTERING))
		adjust_fire_loss(12 * (protection + 0.6))
	if(CHECK_BITFIELD(S.smoke_traits, SMOKE_PLASMALOSS) && !CHECK_BITFIELD(xeno_caste.caste_flags, CASTE_PLASMADRAIN_IMMUNE))
		use_plasma(0.2 * xeno_caste.plasma_max * xeno_caste.plasma_regen_limit)
		apply_status_effect(/datum/status_effect/noplasmaregen, 5 SECONDS)
		if(prob(25))
			to_chat(src, span_xenowarning("We feel our plasma reserves being drained as we pass through the smoke."))
	if(CHECK_BITFIELD(S.smoke_traits, SMOKE_CHEM))
		S.reagents?.reaction(src, TOUCH, S.fraction)

/mob/living/carbon/xenomorph/Stun(amount, updating, ignore_canstun)
	amount *= 0.5 // half length
	return ..()

/mob/living/carbon/xenomorph/Paralyze(amount, updating, ignore_canstun)
	amount *= 0.2 // replaces the old knock_down -5
	return ..()

/mob/living/carbon/xenomorph/adjust_fire_stacks(add_fire_stacks)
	if(add_fire_stacks > 0 && ((xeno_caste.caste_flags & CASTE_FIRE_IMMUNE) || (HAS_TRAIT(src, TRAIT_NON_FLAMMABLE))))
		return
	return ..()

/mob/living/carbon/xenomorph/emote_gored()
	emote(prob(70) ? "hiss" : "roar")

/mob/living/carbon/xenomorph/IgniteMob()
	if(xeno_caste.caste_flags & CASTE_FIRE_IMMUNE)
		return
	. = ..()
	if(!.)
		return
	update_fire()

	for(var/obj/item/clothing/mask/facehugger/hugger in get_held_items())
		hugger.kill_hugger()
		dropItemToGround(hugger)
