/obj/structure/sign/double/barsign
	icon = 'icons/obj/structures/barsigns.dmi'
	base_icon = 'icons/obj/structures/barsigns.dmi'
	icon_state = "off"
	anchored = TRUE

/obj/structure/sign/double/barsign/Initialize(mapload)
	. = ..()
	change_sign_on_init()

/obj/structure/sign/double/barsign/multitool_act(mob/living/user, obj/item/I)
	. = ..()
	var/sign_type = tgui_input_list(user, "What would you like to change the barsign to?", null, list("Off", "Pink Flamingo", "Magma Sea", "Limbo", "Rusty Axe", "Armok Bar", "Broken Drum", "Mead Bay", "The Damn Wall", "The Cavern", "Cindi Kate", "The Orchard", "The Saucy Clown", "The Clowns Head", "Whiskey Implant", "Carpe Carp", "Robust Roadhouse", "The Redshirt", "Maltese Falcon", "The Bark", "The Harmbaton", "The Singulo", "The Drunk Carp", "Scotch Servin Willys", "Officer Beersky", "The Cavern", "The Outer Spess", "Slippery Shots","The Grey Tide", "Honked N Loaded", "The Nest", "The Coderbus", "The Adminbus", "The Old Cock Inn", "The Wretched Hive", "The Robusta Cafe", "The Emergency Rum Party", "The Combo Cafe", "Vlad's Salad Bar", "The Shaken", "The Ale Nath", "The Aloha Snackbar", "The Net", "Maid Cafe", "The Lightbulb", "The Syndi Cat", "ERROR"))
	if(!sign_type)
		return

	sign_type = replacetext(lowertext(sign_type), " ", "")
	change_sign(sign_type)
	to_chat(user, "You change the barsign.")

/obj/structure/sign/double/barsign/proc/change_sign(Text)
	icon_state = "[Text]"
	//on = 0
	//brightness_on = 4 //uncomment these when the lighting fixes get in
	return

/obj/structure/sign/double/barsign/proc/change_sign_on_init()
	change_sign(pick(
	"pinkflamingo",
	"magmasea",
	"limbo",
	"rustyaxe",
	"armokbar",
	"brokendrum",
	"meadbay",
	"thedamnwall",
	"thecavern",
	"cindikate",
	"theorchard",
	"thesaucyclown",
	"theclownshead",
	"whiskeyimplant",
	"carpecarp",
	"robustroadhouse",
	"theredshirt",
	"maltesefalcon",
	"thebark",
	"theharmbaton",
	"thesingulo",
	"thedrunkcarp",
	"scotchservinwillys",
	"officerbeersky",
	"thecavern",
	"theouterspess",
	"slipperyshots",
	"thegreytide",
	"honkednloaded",
	"thenest",
	"thecoderbus",
	"theadminbus",
	"oldcockinn",
	"thewretchedhive",
	"robustacafe",
	"emergencyrumparty",
	"combocafe",
	"vladssaladbar",
	"theshaken",
	"thealenath",
	"alohasnackbar",
	"thenet",
	"maidcafe",
	"thelightbulb",
	"thesyndicat",
	"error",
	))

/obj/structure/sign/double/barsign/carp
	name = "The Drunk Carp"
	desc = "The Drunk Carp, Bar and Grill"
	icon_state = "thedrunkcarp"

/obj/structure/sign/double/barsign/carp/change_sign_on_init()
	change_sign("thedrunkcarp")
