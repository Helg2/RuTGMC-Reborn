/** Balance datum

This is for tracking and storing balance values that are automatically added to the database on edit.

*/
GLOBAL_DATUM_INIT(balance, /datum/balance, new())


/datum/balance
	var/list/factions
	var/list/balance_values

/datum/balance/proc/Initialize()
	factions = list("marines", "xeno", "other")
	balance_values = list()
	for(var/faction in factions)
		balance_values[faction] = 0

	RegisterSignal(SSdcs, COMSIG_GLOB_MOB_LOGIN, PROC_REF(gain_points))
	RegisterSignal(SSdcs, COMSIG_GLOB_MOB_LOGOUT, PROC_REF(lose_points))
	RegisterSignal(SSdcs, COMSIG_GLOB_MOB_DEATH, PROC_REF(lose_points))

/datum/balance/proc/gain_points(datum/dcs, mob/source)
	SIGNAL_HANDLER
	if(!isliving(source))
		return FALSE
	var/mob/living/living = source
	switch(living.faction)
		if(FACTION_XENO)
			balance_values["xeno"]++
		if (FACTION_TERRAGOV)
			balance_values["marine"]++
		else
			balance_values["other"]++

	record_feedback()

/datum/balance/proc/lose_points(datum/dcs, mob/source)
	SIGNAL_HANDLER
	if(!isliving(source))
		return FALSE
	var/mob/living/living = source
	switch(living.faction)
		if(FACTION_XENO)
			balance_values["xeno"]--
		if (FACTION_TERRAGOV)
			balance_values["marine"]--
		else
			balance_values["other"]--

	record_feedback()

/datum/balance/proc/record_feedback()
	var/list/data = deep_copy_list(balance_values)
	data["timestamp"] = world.time
	SSblackbox.record_feedback(FEEDBACK_ASSOCIATIVE, "balance", 1, data)
