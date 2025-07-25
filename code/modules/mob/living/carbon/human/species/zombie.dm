/datum/species/zombie
	name = "Zombie"
	icobase = 'icons/mob/human_races/r_husk.dmi'
	total_health = 125
	species_flags = NO_BREATHE|NO_SCAN|NO_BLOOD|NO_POISON|NO_PAIN|NO_CHEM_METABOLIZATION|NO_STAMINA|HAS_UNDERWEAR|HEALTH_HUD_ALWAYS_DEAD|PARALYSE_RESISTANT
	lighting_alpha = LIGHTING_PLANE_ALPHA_MOSTLY_INVISIBLE
	see_in_dark = 8
	blood_color = "#110a0a"
	hair_color = "#000000"
	slowdown = 0.5
	default_language_holder = /datum/language_holder/zombie
	has_organ = list(
		ORGAN_SLOT_HEART = /datum/internal_organ/heart,
		ORGAN_SLOT_LUNGS = /datum/internal_organ/lungs,
		ORGAN_SLOT_LIVER = /datum/internal_organ/liver,
		ORGAN_SLOT_STOMACH = /datum/internal_organ/stomach,
		ORGAN_SLOT_KIDNEYS = /datum/internal_organ/kidneys,
		ORGAN_SLOT_BRAIN = /datum/internal_organ/brain,
		ORGAN_SLOT_APPENDIX = /datum/internal_organ/appendix,
		ORGAN_SLOT_EYES = /datum/internal_organ/eyes
	)
	death_message = "seizes up and falls limp..."
	///Sounds made randomly by the zombie
	var/list/sounds = list('sound/hallucinations/growl1.ogg','sound/hallucinations/growl2.ogg','sound/hallucinations/growl3.ogg','sound/hallucinations/veryfar_noise.ogg','sound/hallucinations/wail.ogg')
	///Time before resurrecting if dead
	var/revive_time = 1 MINUTES
	///How much burn and burn damage can you heal every Life tick (half a sec)
	var/heal_rate = 10
	var/faction = FACTION_ZOMBIE
	var/claw_type = /obj/item/weapon/zombie_claw

/datum/species/zombie/on_species_gain(mob/living/carbon/human/H, datum/species/old_species)
	. = ..()
	H.set_undefibbable()
	H.faction = faction
	H.language_holder = new default_language_holder()
	H.set_oxy_loss(0)
	H.set_tox_loss(0)
	H.set_clone_loss(0)
	H.dropItemToGround(H.r_hand, TRUE)
	H.dropItemToGround(H.l_hand, TRUE)
	if(istype(H.wear_id, /obj/item/card/id))
		var/obj/item/card/id/id = H.wear_id
		id.access = list() // A bit gamey, but let's say ids have a security against zombies
		id.iff_signal = NONE
	H.equip_to_slot_or_del(new claw_type, SLOT_R_HAND)
	H.equip_to_slot_or_del(new claw_type, SLOT_L_HAND)
	var/datum/atom_hud/health_hud = GLOB.huds[DATA_HUD_MEDICAL_OBSERVER]
	health_hud.add_hud_to(H)
	H.job = new /datum/job/zombie //Prevent from skewing the respawn timer if you take a zombie, it's a ghost role after all
	for(var/datum/action/action AS in H.actions)
		action.remove_action(H)
	var/datum/action/rally_zombie/rally_zombie = new
	rally_zombie.give_action(H)
	var/datum/action/set_agressivity/set_zombie_behaviour = new
	set_zombie_behaviour.give_action(H)

/datum/species/zombie/post_species_loss(mob/living/carbon/human/H)
	. = ..()
	var/datum/atom_hud/health_hud = GLOB.huds[DATA_HUD_MEDICAL_OBSERVER]
	health_hud.remove_hud_from(H)
	qdel(H.r_hand)
	qdel(H.l_hand)
	for(var/datum/action/action AS in H.actions)
		action.remove_action(H)

/datum/species/zombie/handle_unique_behavior(mob/living/carbon/human/H)
	if(prob(10))
		playsound(get_turf(H), pick(sounds), 50)

	if(H.health != total_health)
		H.heal_limbs(heal_rate)

	for(var/organ_slot in has_organ)
		var/datum/internal_organ/internal_organ = H.get_organ_slot(organ_slot)
		internal_organ?.heal_organ_damage(1)
	H.update_health()

/datum/species/zombie/handle_death(mob/living/carbon/human/H)
	if(H.on_fire)
		addtimer(CALLBACK(src, PROC_REF(fade_out_and_qdel_in), H), 1 MINUTES)
		return
	if(!H.has_working_organs())
		SSmobs.stop_processing(H) // stopping the processing extinguishes the fire that is already on, so that's a hack around
		addtimer(CALLBACK(src, PROC_REF(fade_out_and_qdel_in), H), 1 MINUTES)
		return
	SSmobs.stop_processing(H)
	addtimer(CALLBACK(H, TYPE_PROC_REF(/mob/living/carbon/human, revive_to_crit), TRUE, FALSE), revive_time)

/// We start fading out the human and qdel them in set time
/datum/species/zombie/proc/fade_out_and_qdel_in(mob/living/carbon/human/H, time = 5 SECONDS)
	fade_out(H, our_time = time)
	QDEL_IN(H, time)

/datum/species/zombie/fast
	name = "Fast zombie"
	slowdown = 0

/datum/species/zombie/fast/on_species_gain(mob/living/carbon/human/H, datum/species/old_species)
	. = ..()
	H.transform = matrix().Scale(0.8, 0.8)

/datum/species/zombie/fast/post_species_loss(mob/living/carbon/human/H)
	. = ..()
	H.transform = matrix().Scale(1/(0.8), 1/(0.8))

/datum/species/zombie/tank
	name = "Tank zombie"
	slowdown = 1
	heal_rate = 20
	total_health = 250

/datum/species/zombie/tank/on_species_gain(mob/living/carbon/human/H, datum/species/old_species)
	. = ..()
	H.transform = matrix().Scale(1.2, 1.2)

/datum/species/zombie/tank/post_species_loss(mob/living/carbon/human/H)
	. = ..()
	H.transform = matrix().Scale(1/(1.2), 1/(1.2))

/datum/species/zombie/strong
	name = "Strong zombie" //These are zombies created from marines, they are stronger, but of course rarer
	slowdown = -0.5
	heal_rate = 20
	total_health = 200

/datum/species/zombie/strong/on_species_gain(mob/living/carbon/human/H, datum/species/old_species)
	. = ..()
	H.color = COLOR_DARK_BROWN

/datum/species/zombie/strong/post_species_loss(mob/living/carbon/human/H, datum/species/old_species)
	. = ..()
	H.color = null

/datum/species/zombie/psi_zombie
	name = "Psi zombie" //reanimated by psionic ability
	slowdown = -0.5
	heal_rate = 20
	total_health = 200
	faction = FACTION_SECTOIDS
	claw_type = /obj/item/weapon/zombie_claw/no_zombium

/datum/species/zombie/smoker
	name = "Smoker zombie"

/datum/species/zombie/smoker/on_species_gain(mob/living/carbon/human/H, datum/species/old_species)
	. = ..()
	var/datum/action/ability/emit_gas/emit_gas = new
	emit_gas.give_action(H)

/particles/smoker_zombie
	icon = 'icons/effects/particles/smoke.dmi'
	icon_state = list("smoke_1" = 1, "smoke_2" = 1, "smoke_3" = 2)
	width = 100
	height = 100
	count = 5
	spawning = 4
	lifespan = 9
	fade = 10
	grow = 0.2
	velocity = list(0, 0)
	position = generator(GEN_CIRCLE, 10, 10, NORMAL_RAND)
	drift = generator(GEN_VECTOR, list(0, -0.15), list(0, 0.15))
	gravity = list(0, 0.4)
	scale = generator(GEN_VECTOR, list(0.3, 0.3), list(0.9,0.9), NORMAL_RAND)
	rotation = 0
	spin = generator(GEN_NUM, 10, 20)

/datum/action/rally_zombie
	name = "Rally Zombies"
	action_icon_state = "rally_minions"
	action_icon = 'icons/Xeno/actions/general.dmi'

/datum/action/rally_zombie/action_activate()
	owner.balloon_alert(owner, "Zombies Rallied!")
	SEND_GLOBAL_SIGNAL(COMSIG_GLOB_AI_MINION_RALLY, owner)
	var/datum/action/set_agressivity/set_agressivity = owner.actions_by_path[/datum/action/set_agressivity]
	if(set_agressivity)
		SEND_SIGNAL(owner, COMSIG_ESCORTING_ATOM_BEHAVIOUR_CHANGED, set_agressivity.zombies_agressive) //New escorting ais should have the same behaviour as old one

/datum/action/set_agressivity
	name = "Set other zombie behavior"
	action_icon_state = "minion_agressive"
	action_icon = 'icons/Xeno/actions/general.dmi'
	///If zombies should be agressive
	var/zombies_agressive = TRUE

/datum/action/set_agressivity/action_activate()
	zombies_agressive = !zombies_agressive
	SEND_SIGNAL(owner, COMSIG_ESCORTING_ATOM_BEHAVIOUR_CHANGED, zombies_agressive)
	update_button_icon()

/datum/action/set_agressivity/update_button_icon()
	action_icon_state = zombies_agressive ? "minion_agressive" : "minion_passive"
	return ..()

/obj/item/weapon/zombie_claw
	name = "claws"
	hitsound = 'sound/weapons/slice.ogg'
	icon_state = "zombie_claw_left"
	base_icon_state = "zombie_claw"
	force = 20
	sharp = IS_SHARP_ITEM_BIG
	edge = TRUE
	attack_verb = list("claws", "slashes", "tears", "rips", "dices", "cuts", "bites")
	item_flags = CAN_BUMP_ATTACK|DELONDROP
	attack_speed = 8 //Same as unarmed delay
	pry_capable = IS_PRY_CAPABLE_FORCE
	///How much zombium are transferred per hit. Set to zero to remove transmission
	var/zombium_per_hit = 5

/obj/item/weapon/zombie_claw/Initialize(mapload)
	. = ..()
	ADD_TRAIT(src, TRAIT_NODROP, ABSTRACT_ITEM_TRAIT)

/obj/item/weapon/zombie_claw/melee_attack_chain(mob/user, atom/target, params, rightclick)
	if(ishuman(target))
		var/mob/living/carbon/human/human_target = target
		if(human_target.stat == DEAD)
			return
		human_target.reagents.add_reagent(/datum/reagent/zombium, zombium_per_hit * 0.01 * get_soft_armor(BIO))
	return ..()

/obj/item/weapon/zombie_claw/afterattack(atom/target, mob/user, has_proximity, click_parameters)
	. = ..()
	if(!has_proximity)
		return
	if(!istype(target, /obj/machinery/door/airlock))
		return
	if(user.do_actions)
		return

	target.balloon_alert_to_viewers("[user] starts to open [target]", "You start to pry open [target]")
	if(!do_after(user, 4 SECONDS, IGNORE_HELD_ITEM, target))
		return
	var/obj/machinery/door/airlock/door = target
	playsound(user.loc, 'sound/effects/metal_creaking.ogg', 25, 1)
	if(door.locked)
		to_chat(user, span_warning("\The [target] is bolted down tight."))
		return FALSE
	if(door.welded)
		to_chat(user, span_warning("\The [target] is welded shut."))
		return FALSE
	if(door.density) //Make sure it's still closed
		door.open(TRUE)

/obj/item/weapon/zombie_claw/equipped(mob/user, slot)
	. = ..()
	if(slot == SLOT_L_HAND)
		icon_state = "[base_icon_state]_right"
	else if(slot == SLOT_R_HAND)
		icon_state = "[base_icon_state]_left"

/obj/item/weapon/zombie_claw/no_zombium
	zombium_per_hit = 0

// ***************************************
// *********** Emit Gas
// ***************************************
/datum/action/ability/emit_gas
	name = "Emit Gas"
	action_icon_state = "emit_neurogas"
	action_icon = 'icons/Xeno/actions/defiler.dmi'
	desc = "Use to emit a cloud of blinding smoke."
	cooldown_duration = 40 SECONDS
	keybind_flags = ABILITY_KEYBIND_USE_ABILITY|ABILITY_IGNORE_SELECTED_ABILITY
	keybinding_signals = list(
		KEYBINDING_NORMAL = COMSIG_XENOABILITY_EMIT_NEUROGAS,
	)
	/// Used for particles. Holds the particles instead of the mob. See particle_holder for documentation.
	var/obj/effect/abstract/particle_holder/particle_holder
	/// smoke type created when the grenade is primed
	var/datum/effect_system/smoke_spread/smoketype = /datum/effect_system/smoke_spread/bad
	///radius this smoke grenade will encompass
	var/smokeradius = 4
	///The duration of the smoke in 2 second ticks
	var/smoke_duration = 9

/datum/action/ability/emit_gas/on_cooldown_finish()
	playsound(owner.loc, 'sound/effects/alien/newlarva.ogg', 50, 0)
	to_chat(owner, span_xenodanger("We feel our smoke filling us once more. We can emit gas again."))
	toggle_particles(TRUE)
	return ..()

/datum/action/ability/emit_gas/action_activate()
	var/datum/effect_system/smoke_spread/smoke = new smoketype()
	var/turf/owner_turf = get_turf(owner)
	playsound(owner_turf, 'sound/effects/smoke_bomb.ogg', 25, TRUE)
	smoke.set_up(smokeradius, owner_turf, smoke_duration)
	smoke.start()
	toggle_particles(FALSE)

	add_cooldown()
	succeed_activate()

	owner.record_war_crime()

/datum/action/ability/emit_gas/ai_should_start_consider()
	return TRUE

/datum/action/ability/emit_gas/ai_should_use(atom/target)
	var/mob/living/L = owner
	if(!iscarbon(target))
		return FALSE
	if(get_dist(target, owner) > 2 && L.health > 50)
		return FALSE
	if(!can_use_action(override_flags = ABILITY_IGNORE_SELECTED_ABILITY))
		return FALSE
	if(!line_of_sight(owner, target))
		return FALSE
	return TRUE

/// Toggles particles on or off
/datum/action/ability/emit_gas/proc/toggle_particles(activate)
	if(!activate)
		QDEL_NULL(particle_holder)
		return

	particle_holder = new(owner, /particles/smoker_zombie)
	particle_holder.pixel_y = 6

/datum/action/ability/emit_gas/give_action(mob/living/L)
	. = ..()
	toggle_particles(TRUE)

/datum/action/ability/emit_gas/remove_action(mob/living/L)
	. = ..()
	QDEL_NULL(particle_holder)

/datum/action/ability/emit_gas/Destroy()
	. = ..()
	QDEL_NULL(particle_holder)
