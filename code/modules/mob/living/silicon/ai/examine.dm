/mob/living/silicon/ai/examine(mob/user)
	SHOULD_CALL_PARENT(FALSE) // TODO ai and human examine dont send examine signal
	var/msg = "<span class='info'><br>"

	if(stat == DEAD)
		msg += "[span_deadsay("It appears to be powered-down.")]<br>"
	else
		msg += "<span class='warning'>"
		if(get_brute_loss())
			if(get_brute_loss() < 30)
				msg += "It looks slightly dented.<br>"
			else
				msg += "<B>It looks severely dented!</B><br>"
		if(get_fire_loss())
			if(get_fire_loss() < 30)
				msg += "It looks slightly charred.<br>"
			else
				msg += "<B>Its casing is melted and heat-warped!</B><br>"

		if(stat == UNCONSCIOUS)
			msg += "It is non-responsive and displaying the text: \"RUNTIME: Sensory Overload, stack 26/3\".<br>"

		if(!client)
			msg += "[src]/Core.exe has stopped responding! Searching for a solution to the problem...<br>"

		msg += "</span>"

	msg += "</span>"

	return list(msg)
