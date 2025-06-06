/*
	The relay idles until it receives information. It then passes on that information
	depending on where it came from.

	The relay is needed in order to send information pass Z levels. It must be linked
	with a HUB, the only other machine that can send/receive pass Z levels.
*/
/obj/machinery/telecomms/relay
	name = "telecommunication relay"
	icon_state = "relay"
	desc = "A mighty piece of hardware used to send massive amounts of data far away."
	telecomms_type = /obj/machinery/telecomms/relay
	density = TRUE
	use_power = IDLE_POWER_USE
	idle_power_usage = 30
	netspeed = 5
	long_range_link = 1
	circuit = /obj/item/circuitboard/machine/telecomms/relay
	var/broadcasting = 1
	var/receiving = 1

/obj/machinery/telecomms/relay/receive_information(datum/signal/subspace/signal, obj/machinery/telecomms/machine_from)
	// Add our level and send it back
	var/turf/T = get_turf(src)
	if(can_send(signal) && T)
		signal.levels |= T.z

/// Checks to see if it can send/receive.
/obj/machinery/telecomms/relay/proc/can(datum/signal/signal)
	if(!on)
		return FALSE
	if(!is_freq_listening(signal))
		return FALSE
	return TRUE

/obj/machinery/telecomms/relay/proc/can_send(datum/signal/signal)
	if(!can(signal))
		return FALSE
	return broadcasting

/obj/machinery/telecomms/relay/proc/can_receive(datum/signal/signal)
	if(!can(signal))
		return FALSE
	return receiving

//Preset Relay
/obj/machinery/telecomms/relay/preset
	network = "tcommsat"

/obj/machinery/telecomms/relay/Initialize(mapload)
	. = ..()
	if(length(autolinkers)) //We want lateloaded presets to autolink (lateloaded aways/ruins/shuttles)
		return INITIALIZE_HINT_LATELOAD

/obj/machinery/telecomms/relay/preset/station
	id = "Station Relay"
	autolinkers = list("s_relay")

/obj/machinery/telecomms/relay/preset/telecomms
	id = "Telecomms Relay"
	autolinkers = list("relay")

/obj/machinery/telecomms/relay/preset/telecomms/ground/Initialize(mapload)
	. = ..()
	GLOB.ground_telecomms_relay += src

/obj/machinery/telecomms/relay/preset/telecomms/ground/Destroy()
	. = ..()
	GLOB.ground_telecomms_relay -= src

//proper cicbackup relay
/obj/machinery/telecomms/relay/preset/telecomms/cicbackup
	on = 0
	id = "Backup Telecomms Relay"
	autolinkers = list("relay")

/obj/machinery/telecomms/relay/preset/telecomms/onboard
	icon_state = ""
	invisibility = INVISIBILITY_MAXIMUM

/obj/machinery/telecomms/relay/preset/telecomms/onboard/nondense
	density = FALSE
