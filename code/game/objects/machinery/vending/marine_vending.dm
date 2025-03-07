/obj/machinery/vending/weapon
	name = "automated weapons rack"
	desc = "An automated weapon rack hooked up to a colossal storage of standard-issue weapons."
	icon_state = "marinearmory"
	icon_vend = "marinearmory-vend"
	icon_deny = "marinearmory"
	wrenchable = FALSE
	product_ads = "If it moves, it's hostile!;How many enemies have you killed today?;Shoot first, perform autopsy later!;Your ammo is right here.;Guns!;Die, scumbag!;Don't shoot me bro!;Shoot them, bro.;Why not have a donut?"
	isshared = TRUE

	products = list(
		"Винтовки" = list(
			/obj/item/weapon/gun/rifle/ar12 = -1,
			/obj/item/ammo_magazine/rifle/ar12 = -1,
			/obj/item/ammo_magazine/rifle/ar12/ap = -1,
			/obj/item/ammo_magazine/rifle/ar12/hp = -1,
			/obj/item/weapon/gun/rifle/ar18 = -1,
			/obj/item/ammo_magazine/rifle/ar18 = -1,
			/obj/item/ammo_magazine/rifle/ar18/ap = -1,
			/obj/item/ammo_magazine/rifle/ar18/hp = -1,
			/obj/item/weapon/gun/shotgun/pump/lever/repeater = -1,
			/obj/item/ammo_magazine/packet/p4570 = -1,
			/obj/item/weapon/gun/shotgun/double/martini = -1,
			/obj/item/ammo_magazine/rifle/martini = -1,
			/obj/item/ammo_magazine/rifle/martini/white = -1,
			/obj/item/weapon/gun/rifle/type71 = -1,
			/obj/item/ammo_magazine/rifle/type71 = -1,
			/obj/item/ammo_magazine/rifle/type71/ap = -1,
			/obj/item/ammo_magazine/rifle/type71/hp = -1,
			/obj/item/weapon/gun/rifle/ar21 = -1,
			/obj/item/ammo_magazine/rifle/ar21 = -1,
			/obj/item/ammo_magazine/rifle/ar21/ap = -1,
			/obj/item/ammo_magazine/rifle/ar21/hp = -1,
		),
		"Пистолеты-пулемёты" = list(
			/obj/item/weapon/gun/smg/vector = -1,
			/obj/item/ammo_magazine/smg/vector = -1,
			/obj/item/ammo_magazine/smg/vector/ap = -1,
			/obj/item/ammo_magazine/smg/vector/hp = -1,
	),
		"Снайперские винтовки" = list(
			/obj/item/weapon/gun/rifle/dmr37 = -1,
			/obj/item/ammo_magazine/rifle/dmr37 = -1,
			/obj/item/weapon/gun/rifle/sr127= -1,
			/obj/item/ammo_magazine/rifle/sr127 = -1,
			/obj/item/weapon/gun/rifle/sniper/svd = -1,
			/obj/item/ammo_magazine/sniper/svd = -1,
		),
		"Энергетическое" = list(
			/obj/item/cell/lasgun/lasrifle = -1,
			/obj/item/weapon/gun/energy/lasgun/lasrifle/standard_marine_rifle = -1,
			/obj/item/weapon/gun/energy/lasgun/lasrifle/standard_marine_sniper = -1,
			/obj/item/weapon/gun/energy/lasgun/lasrifle/standard_marine_carbine = -1,
			/obj/item/weapon/gun/energy/lasgun/lasrifle/standard_marine_mlaser = -1,
			/obj/item/weapon/gun/energy/lasgun/lasrifle/standard_marine_pistol = -1,
			/obj/item/weapon/gun/energy/lasgun/lasrifle/tesla = -1,
		),
		"Дробовики" = list(
			/obj/item/weapon/gun/shotgun/pump/t35 = -1,
			/obj/item/weapon/gun/shotgun/combat/standardmarine = -1,
			/obj/item/weapon/gun/shotgun/combat/shq6 = -1,
			/obj/item/ammo_magazine/shotgun = -1,
			/obj/item/ammo_magazine/shotgun/buckshot = -1,
			/obj/item/ammo_magazine/shotgun/flechette = -1,
			/obj/item/ammo_magazine/shotgun/tracker = -1,
			/obj/item/weapon/gun/rifle/sh15 = -1,
			/obj/item/ammo_magazine/rifle/sh15_flechette = -1,
			/obj/item/ammo_magazine/rifle/sh15_slug = -1,
			/obj/item/storage/holster/belt/ts34/full = 5,
		),
		"Пулемёты" = list(
			/obj/item/weapon/gun/rifle/mg60 = -1,
			/obj/item/ammo_magazine/mg60 = -1,
			/obj/item/weapon/gun/mg27 = 5,
			/obj/item/ammo_magazine/mg27 = -1,
			/obj/item/storage/box/hsg102 = 1,
			/obj/item/weapon/gun/hmg08 = 1,
			/obj/item/ammo_magazine/hmg08 = 5,
			/obj/item/ammo_magazine/hmg08/small = 10,
		),
		"Ближний бой" = list(
			/obj/item/weapon/combat_knife = -1,
			/obj/item/attachable/bayonetknife = -1,
			/obj/item/stack/throwing_knife = -1,
			/obj/item/storage/belt/knifepouch = -1,
			/obj/item/storage/holster/blade/tomahawk/full = -1,
			/obj/item/storage/holster/blade/machete/full = -1,
			/obj/item/storage/holster/blade/harvester/full = -1,
			/obj/item/weapon/twohanded/spear/tactical = -1,
			/obj/item/weapon/twohanded/spear/tactical/harvester = -1,
			/obj/item/weapon/powerfist = -1,
			/obj/item/weapon/twohanded/glaive/harvester = -1,
			/obj/item/weapon/shield/riot/marine = 6,
			/obj/item/weapon/shield/riot/marine/deployable = 6,
			/obj/item/weapon/combat_knife/harvester = 12,
		),
		"Пистолеты" = list(
			/obj/item/weapon/gun/revolver/r44 = 5,
			/obj/item/ammo_magazine/revolver/r44 = -1,
			/obj/item/storage/briefcase/t500 = 10,
			/obj/item/ammo_magazine/revolver/t500 = -1,
			/obj/item/ammo_magazine/revolver/t500/slavs = -1,
			/obj/item/ammo_magazine/revolver/t312 = -1,
			/obj/item/weapon/gun/pistol/p17 = -1,
			/obj/item/ammo_magazine/pistol/p17 = -1,
			/obj/item/weapon/gun/pistol/vp70 = -1,
			/obj/item/ammo_magazine/pistol/vp70 = -1,
			/obj/item/ammo_magazine/pistol/vp70/hp = -1,
			/obj/item/ammo_magazine/pistol/vp70/incendiary = -1,
			/obj/item/weapon/gun/pistol/plasma_pistol = -1,
			/obj/item/ammo_magazine/pistol/plasma_pistol = -1,
			/obj/item/weapon/gun/shotgun/double/derringer = -1,
			/obj/item/ammo_magazine/pistol/derringer = -1,
		),
		"Гранаты" = list(
			/obj/item/weapon/gun/grenade_launcher/single_shot = 4,
			/obj/item/weapon/gun/grenade_launcher/multinade_launcher/unloaded = 2,
			/obj/item/weapon/gun/rifle/tx54 = 2,
			/obj/item/ammo_magazine/rifle/tx54 = 10,
			/obj/item/ammo_magazine/rifle/tx54/incendiary = 4,
			/obj/item/ammo_magazine/rifle/tx54/smoke = 4,
			/obj/item/ammo_magazine/rifle/tx54/smoke/tangle = 2,
			/obj/item/explosive/grenade = 20,
			/obj/item/explosive/grenade/m15 = 15,
			/obj/item/explosive/grenade/sticky = 5,
			/obj/item/explosive/grenade/sticky/trailblazer = 5,
			/obj/item/explosive/grenade/incendiary = 20,
			/obj/item/explosive/grenade/smokebomb = 10,
			/obj/item/explosive/grenade/smokebomb/cloak = 5,
			/obj/item/explosive/grenade/sticky/cloaker = 5,
			/obj/item/explosive/grenade/smokebomb/drain = 5,
			/obj/item/explosive/grenade/mirage = 10,
			/obj/item/storage/box/m94 = -1,
			/obj/item/storage/box/m94/cas = -1,
		),
		"Специализированное" = list(
			/obj/item/storage/box/crate/sentry = 4,
			/obj/item/weapon/gun/rifle/pepperball = 4,
			/obj/item/ammo_magazine/rifle/pepperball = -1,
			/obj/item/weapon/gun/flamer/big_flamer/marinestandard = 4,
			/obj/item/ammo_magazine/flamer_tank/large = 16,
			/obj/item/ammo_magazine/flamer_tank/large/G = 8,
			/obj/item/ammo_magazine/flamer_tank/backtank = 4,
			/obj/item/ammo_magazine/flamer_tank/water = -1,
			/obj/item/jetpack_marine = 3,
			/obj/item/bodybag/tarp = 10,
			/obj/item/mortar_kit/knee = 4,
			/obj/item/mortal_shell/knee = 40,
		),
		"Модули" = list(
			/obj/item/attachable/bayonet = -1,
			/obj/item/attachable/compensator = -1,
			/obj/item/attachable/extended_barrel = -1,
			/obj/item/attachable/suppressor = -1,
			/obj/item/attachable/heavy_barrel = -1,
			/obj/item/attachable/lace = -1,
			/obj/item/attachable/lace/t500 = -1,
			/obj/item/attachable/flashlight = -1,
			/obj/item/attachable/flashlight/under = -1,
			/obj/item/attachable/magnetic_harness = -1,
			/obj/item/attachable/reddot = -1,
			/obj/item/attachable/b7_scope = -1,
			/obj/item/attachable/motiondetector = -1,
			/obj/item/attachable/scope/marine = -1,
			/obj/item/attachable/scope/mini = -1,
			/obj/item/attachable/angledgrip = -1,
			/obj/item/attachable/verticalgrip = -1,
			/obj/item/attachable/foldable/bipod = -1,
			/obj/item/attachable/gyro = -1,
			/obj/item/attachable/lasersight = -1,
			/obj/item/attachable/burstfire_assembly = -1,
			/obj/item/weapon/gun/shotgun/combat/masterkey = -1,
			/obj/item/weapon/gun/grenade_launcher/underslung = -1,
			/obj/item/weapon/gun/energy/lasgun/lasrifle/pocket_beam = -1,
			/obj/item/weapon/gun/flamer/mini_flamer = -1,
			/obj/item/ammo_magazine/flamer_tank/mini = -1,
			/obj/item/ammo_magazine/flamer_tank/mini/G = 15,
			/obj/item/weapon/gun/rifle/pepperball/pepperball_mini = -1,
			/obj/item/ammo_magazine/rifle/pepperball/pepperball_mini = -1,
			/obj/item/attachable/stock/t76 = -1,
			/obj/item/attachable/flamer_nozzle = -1,
			/obj/item/attachable/flamer_nozzle/wide = -1,
			/obj/item/attachable/flamer_nozzle/long = -1,
		),
		"Коробки" = list(
			/obj/item/ammo_magazine/packet/p9mm = -1,
			/obj/item/ammo_magazine/packet/p9mm/ap = -1,
			/obj/item/ammo_magazine/packet/p9mm/hp = -1,
			/obj/item/ammo_magazine/packet/acp = -1,
			/obj/item/ammo_magazine/packet/acp/ap = -1,
			/obj/item/ammo_magazine/packet/acp/hp = -1,
			/obj/item/ammo_magazine/packet/rifle762X39 = -1,
			/obj/item/ammo_magazine/packet/p380acp = -1,
			/obj/item/ammo_magazine/packet/magnum = -1,
			/obj/item/ammo_magazine/packet/t500 = -1,
			/obj/item/ammo_magazine/packet/t500/qk = -1,
			/obj/item/ammo_magazine/packet/t500/slavs = -1,
			/obj/item/ammo_magazine/packet/t312 = -1,
			/obj/item/ammo_magazine/packet/p10x20mm = -1,
			/obj/item/ammo_magazine/packet/p10x24mm = -1,
			/obj/item/ammo_magazine/packet/p10x24mm/ap = -1,
			/obj/item/ammo_magazine/packet/p10x24mm/hp = -1,
			/obj/item/ammo_magazine/packet/p10x25mm = -1,
			/obj/item/ammo_magazine/packet/p10x25mm/ap = -1,
			/obj/item/ammo_magazine/packet/p10x25mm/hp = -1,
			/obj/item/ammo_magazine/packet/groza = -1,
			/obj/item/ammo_magazine/packet/groza/ap = -1,
			/obj/item/ammo_magazine/packet/groza/hp = -1,
			/obj/item/ammo_magazine/packet/p10x25mm = -1,
			/obj/item/ammo_magazine/packet/p10x26mm = -1,
			/obj/item/ammo_magazine/packet/p10x27mm = -1,
			/obj/item/ammo_magazine/packet/p86x70mm = -1,
			/obj/item/ammo_magazine/packet/svd762x54mmR = -1,
			/obj/item/ammo_magazine/packet/standardautoshotgun = -1,
			/obj/item/ammo_magazine/packet/standardautoshotgun/flechette = -1,
			/obj/item/ammo_magazine/packet/p4570 = -1,
			/obj/item/ammo_magazine/packet/long_special = -1,
			/obj/item/storage/box/visual/magazine = -1,
			/obj/item/storage/box/visual/grenade = -1,
			/obj/structure/closet/crate/mass_produced_crate = 5,
			/obj/structure/closet/crate/mass_produced_crate/alpha = 5,
			/obj/structure/closet/crate/mass_produced_crate/bravo = 5,
			/obj/structure/closet/crate/mass_produced_crate/charlie = 5,
			/obj/structure/closet/crate/mass_produced_crate/delta = 5,
			/obj/structure/closet/crate/mass_produced_crate/ammo = 5,
			/obj/structure/closet/crate/mass_produced_crate/construction = 5,
			/obj/structure/closet/crate/mass_produced_crate/explosives = 5,
			/obj/structure/closet/crate/mass_produced_crate/medical = 5,
			/obj/structure/closet/crate/mass_produced_crate/supply = 5,
			/obj/structure/closet/crate/mass_produced_crate/weapon = 5,
		),
		"Утилити" = list(
			/obj/item/flashlight/combat = -1,
			/obj/item/weapon/gun/grenade_launcher/single_shot/flare/marine = -1,
			/obj/item/tool/shovel/etool = -1,
			/obj/item/tool/extinguisher = -1,
			/obj/item/tool/extinguisher/mini = -1,
			/obj/item/assembly/signaler = -1,
			/obj/item/binoculars = -1,
			/obj/item/compass = -1,
			/obj/item/tool/hand_labeler = -1,
			/obj/item/toy/deck/kotahi = -1,
			/obj/item/toy/deck = -1,
			/obj/item/deployable_floodlight = 5,
		),
	)

	seasonal_items = list(
		SEASONAL_GUNS = "Сезонное",
		SEASONAL_HEAVY = "Сезонное тяжёлое вооружение",
	)

/obj/machinery/vending/weapon/crash
	products = list(
		"Винтовки" = list(
			/obj/item/weapon/gun/rifle/ar12 = -1,
			/obj/item/ammo_magazine/rifle/ar12 = -1,
			/obj/item/ammo_magazine/rifle/ar12/ap = -1,
			/obj/item/ammo_magazine/rifle/ar12/hp = -1,
			/obj/item/weapon/gun/rifle/ar18 = -1,
			/obj/item/ammo_magazine/rifle/ar18 = -1,
			/obj/item/ammo_magazine/rifle/ar18/ap = -1,
			/obj/item/ammo_magazine/rifle/ar18/hp = -1,
			/obj/item/weapon/gun/shotgun/pump/lever/repeater = -1,
			/obj/item/ammo_magazine/packet/p4570 = -1,
			/obj/item/weapon/gun/shotgun/double/martini = -1,
			/obj/item/ammo_magazine/rifle/martini = -1,
			/obj/item/ammo_magazine/rifle/martini/white = -1,
			/obj/item/weapon/gun/rifle/type71 = -1,
			/obj/item/ammo_magazine/rifle/type71 = -1,
			/obj/item/ammo_magazine/rifle/type71/ap = -1,
			/obj/item/ammo_magazine/rifle/type71/hp = -1,
			/obj/item/weapon/gun/rifle/ar21 = -1,
			/obj/item/ammo_magazine/rifle/ar21 = -1,
			/obj/item/ammo_magazine/rifle/ar21/ap = -1,
			/obj/item/ammo_magazine/rifle/ar21/hp = -1,
			/obj/item/weapon/gun/revolver/r44/coltrifle = -1,
			/obj/item/ammo_magazine/revolver/rifle = -1,

		),
		"Пистолеты-пулемёты" = list(
			/obj/item/weapon/gun/smg/vector = -1,
			/obj/item/ammo_magazine/smg/vector = -1,
			/obj/item/ammo_magazine/smg/vector/ap = -1,
			/obj/item/ammo_magazine/smg/vector/hp = -1,
		),
		"Энергетическое" = list(
			/obj/item/cell/lasgun/lasrifle = -1,
			/obj/item/weapon/gun/energy/lasgun/lasrifle/standard_marine_rifle = -1,
			/obj/item/weapon/gun/energy/lasgun/lasrifle/standard_marine_sniper = -1,
			/obj/item/weapon/gun/energy/lasgun/lasrifle/standard_marine_carbine = -1,
			/obj/item/weapon/gun/energy/lasgun/lasrifle/standard_marine_mlaser = -1,
			/obj/item/weapon/gun/energy/lasgun/lasrifle/standard_marine_pistol = -1,
			/obj/item/weapon/gun/energy/lasgun/lasrifle/tesla = -1,
		),
		"Снайперские винтовки" = list(
			/obj/item/weapon/gun/rifle/dmr37 = -1,
			/obj/item/ammo_magazine/rifle/dmr37 = -1,
			/obj/item/weapon/gun/rifle/sr127= -1,
			/obj/item/ammo_magazine/rifle/sr127 = -1,
			/obj/item/weapon/gun/rifle/sniper/svd = -1,
			/obj/item/ammo_magazine/sniper/svd = -1,
		),
		"Дробовики" = list(
			/obj/item/weapon/gun/shotgun/pump/t35 = -1,
			/obj/item/weapon/gun/shotgun/combat/standardmarine = -1,
			/obj/item/weapon/gun/shotgun/combat/shq6 = -1,
			/obj/item/ammo_magazine/shotgun = -1,
			/obj/item/ammo_magazine/shotgun/buckshot = -1,
			/obj/item/ammo_magazine/shotgun/flechette = -1,
			/obj/item/ammo_magazine/shotgun/tracker = -1,
			/obj/item/weapon/gun/rifle/sh15 = -1,
			/obj/item/ammo_magazine/rifle/sh15_flechette = -1,
			/obj/item/ammo_magazine/rifle/sh15_slug = -1,
			/obj/item/storage/holster/belt/ts34/full = 5,
		),
		"Пулемёты" = list(
			/obj/item/weapon/gun/rifle/mg60 = -1,
			/obj/item/ammo_magazine/mg60 = -1,
			/obj/item/weapon/gun/mg27 = 5,
			/obj/item/ammo_magazine/mg27 = -1,
		),
		"Ближний бой" = list(
			/obj/item/weapon/combat_knife = -1,
			/obj/item/attachable/bayonetknife = -1,
			/obj/item/stack/throwing_knife = -1,
			/obj/item/storage/belt/knifepouch = -1,
			/obj/item/storage/holster/blade/tomahawk/full = -1,
			/obj/item/storage/holster/blade/machete/full = -1,
			/obj/item/storage/holster/blade/harvester/full = -1,
			/obj/item/weapon/twohanded/spear/tactical = -1,
			/obj/item/weapon/twohanded/spear/tactical/harvester = -1,
			/obj/item/weapon/twohanded/glaive/harvester = -1,
			/obj/item/weapon/powerfist = -1,
			/obj/item/weapon/shield/riot/marine = 6,
			/obj/item/weapon/shield/riot/marine/deployable = 6,
			/obj/item/weapon/combat_knife/harvester = 12,
		),
		"Пистолеты" = list(
			/obj/item/weapon/gun/revolver/r44 = 5,
			/obj/item/ammo_magazine/revolver/r44 = -1,
			/obj/item/storage/briefcase/t500 = 10,
			/obj/item/ammo_magazine/revolver/t500 = -1,
			/obj/item/ammo_magazine/revolver/t500/slavs = -1,
			/obj/item/ammo_magazine/revolver/t312 = -1,
			/obj/item/weapon/gun/pistol/p17 = -1,
			/obj/item/ammo_magazine/pistol/p17 = -1,
			/obj/item/weapon/gun/pistol/vp70 = -1,
			/obj/item/ammo_magazine/pistol/vp70 = -1,
			/obj/item/ammo_magazine/pistol/vp70/hp = -1,
			/obj/item/ammo_magazine/pistol/vp70/incendiary = -1,
			/obj/item/weapon/gun/pistol/plasma_pistol = -1,
			/obj/item/ammo_magazine/pistol/plasma_pistol = -1,
			/obj/item/weapon/gun/shotgun/double/derringer = -1,
			/obj/item/ammo_magazine/pistol/derringer = -1,
		),
		"Гранаты" = list(
			/obj/item/weapon/gun/grenade_launcher/single_shot = 4,
			/obj/item/weapon/gun/grenade_launcher/multinade_launcher/unloaded = 2,
			/obj/item/explosive/grenade = 50,
			/obj/item/explosive/grenade/m15 = 10,
			/obj/item/explosive/grenade/sticky = 25,
			/obj/item/explosive/grenade/incendiary = 50,
			/obj/item/explosive/grenade/sticky/trailblazer = 25,
			/obj/item/explosive/grenade/smokebomb/cloak = 25,
			/obj/item/explosive/grenade/smokebomb/drain = 10,
			/obj/item/explosive/grenade/mirage = 100,
			/obj/item/storage/box/m94 = -1,
			/obj/item/storage/box/m94/cas = -1,
		),
		"Специализированное" = list(
			/obj/item/weapon/gun/rifle/pepperball = 4,
			/obj/item/ammo_magazine/rifle/pepperball = -1,
			/obj/item/weapon/gun/flamer/big_flamer/marinestandard = 4,
			/obj/item/ammo_magazine/flamer_tank/large = 30,
			/obj/item/ammo_magazine/flamer_tank/large/G = 15,
			/obj/item/ammo_magazine/flamer_tank/backtank = 4,
			/obj/item/ammo_magazine/flamer_tank/water = -1,
			/obj/item/jetpack_marine = 3,
		),
		"Модули" = list(
			/obj/item/attachable/bayonet = -1,
			/obj/item/attachable/compensator = -1,
			/obj/item/attachable/extended_barrel = -1,
			/obj/item/attachable/suppressor = -1,
			/obj/item/attachable/heavy_barrel = -1,
			/obj/item/attachable/lace = -1,
			/obj/item/attachable/lace/t500 = -1,
			/obj/item/attachable/flashlight = -1,
			/obj/item/attachable/flashlight/under = -1,
			/obj/item/attachable/magnetic_harness = -1,
			/obj/item/attachable/reddot = -1,
			/obj/item/attachable/b7_scope = -1,
			/obj/item/attachable/motiondetector = -1,
			/obj/item/attachable/scope/marine = -1,
			/obj/item/attachable/scope/mini = -1,
			/obj/item/attachable/angledgrip = -1,
			/obj/item/attachable/verticalgrip = -1,
			/obj/item/attachable/foldable/bipod = -1,
			/obj/item/attachable/gyro = -1,
			/obj/item/attachable/lasersight = -1,
			/obj/item/attachable/burstfire_assembly = -1,
			/obj/item/weapon/gun/shotgun/combat/masterkey = -1,
			/obj/item/weapon/gun/grenade_launcher/underslung = -1,
			/obj/item/weapon/gun/energy/lasgun/lasrifle/pocket_beam = -1,
			/obj/item/weapon/gun/flamer/mini_flamer = -1,
			/obj/item/ammo_magazine/flamer_tank/mini = -1,
			/obj/item/ammo_magazine/flamer_tank/mini/G = 15,
			/obj/item/weapon/gun/rifle/pepperball/pepperball_mini = -1,
			/obj/item/ammo_magazine/rifle/pepperball/pepperball_mini = -1,
			/obj/item/attachable/stock/t76 = -1,
			/obj/item/attachable/flamer_nozzle = -1,
			/obj/item/attachable/flamer_nozzle/wide = -1,
			/obj/item/attachable/flamer_nozzle/long = -1,
		),
		"Коробки" = list(
			/obj/item/ammo_magazine/packet/p9mm = -1,
			/obj/item/ammo_magazine/packet/p9mm/ap = -1,
			/obj/item/ammo_magazine/packet/p9mm/hp = -1,
			/obj/item/ammo_magazine/packet/acp = -1,
			/obj/item/ammo_magazine/packet/acp/ap = -1,
			/obj/item/ammo_magazine/packet/acp/hp = -1,
			/obj/item/ammo_magazine/packet/rifle762X39 = -1,
			/obj/item/ammo_magazine/packet/p380acp = -1,
			/obj/item/ammo_magazine/packet/magnum = -1,
			/obj/item/ammo_magazine/packet/t500 = -1,
			/obj/item/ammo_magazine/packet/t500/qk = -1,
			/obj/item/ammo_magazine/packet/t500/slavs = -1,
			/obj/item/ammo_magazine/packet/t312 = -1,
			/obj/item/ammo_magazine/packet/p10x20mm = -1,
			/obj/item/ammo_magazine/packet/p10x24mm = -1,
			/obj/item/ammo_magazine/packet/p10x24mm/ap = -1,
			/obj/item/ammo_magazine/packet/p10x24mm/hp = -1,
			/obj/item/ammo_magazine/packet/p10x25mm = -1,
			/obj/item/ammo_magazine/packet/p10x25mm/ap = -1,
			/obj/item/ammo_magazine/packet/p10x25mm/hp = -1,
			/obj/item/ammo_magazine/packet/groza = -1,
			/obj/item/ammo_magazine/packet/groza/ap = -1,
			/obj/item/ammo_magazine/packet/groza/hp = -1,
			/obj/item/ammo_magazine/packet/p10x25mm = -1,
			/obj/item/ammo_magazine/packet/p10x26mm = -1,
			/obj/item/ammo_magazine/packet/p10x27mm = -1,
			/obj/item/ammo_magazine/packet/p86x70mm = -1,
			/obj/item/ammo_magazine/packet/svd762x54mmR = -1,
			/obj/item/ammo_magazine/packet/standardautoshotgun = -1,
			/obj/item/ammo_magazine/packet/standardautoshotgun/flechette = -1,
			/obj/item/ammo_magazine/packet/p4570 = -1,
			/obj/item/ammo_magazine/packet/long_special = -1,
			/obj/item/storage/box/visual/magazine = -1,
			/obj/item/storage/box/visual/grenade = -1,
			/obj/structure/closet/crate/mass_produced_crate = 5,
			/obj/structure/closet/crate/mass_produced_crate/alpha = 5,
			/obj/structure/closet/crate/mass_produced_crate/bravo = 5,
			/obj/structure/closet/crate/mass_produced_crate/charlie = 5,
			/obj/structure/closet/crate/mass_produced_crate/delta = 5,
			/obj/structure/closet/crate/mass_produced_crate/ammo = 5,
			/obj/structure/closet/crate/mass_produced_crate/construction = 5,
			/obj/structure/closet/crate/mass_produced_crate/explosives = 5,
			/obj/structure/closet/crate/mass_produced_crate/medical = 5,
			/obj/structure/closet/crate/mass_produced_crate/supply = 5,
			/obj/structure/closet/crate/mass_produced_crate/weapon = 5,
		),
		"Утилити" = list(
			/obj/item/flashlight/combat = -1,
			/obj/item/weapon/gun/grenade_launcher/single_shot/flare/marine = -1,
			/obj/item/tool/shovel/etool = -1,
			/obj/item/tool/extinguisher = -1,
			/obj/item/tool/extinguisher/mini = -1,
			/obj/item/assembly/signaler = -1,
			/obj/item/binoculars = -1,
			/obj/item/compass = -1,
			/obj/item/tool/hand_labeler = -1,
			/obj/item/toy/deck/kotahi = -1,
			/obj/item/toy/deck = -1,
			/obj/item/deployable_floodlight = 5,
		),
	)

	seasonal_items = list(
		SEASONAL_GUNS = "Сезонное",
	)

/obj/machinery/vending/weapon/valhalla
	resistance_flags = INDESTRUCTIBLE
	use_power = NO_POWER_USE
	products = list(
		"Винтовки" = list(
			/obj/item/weapon/gun/rifle/ar12 = -1,
			/obj/item/ammo_magazine/rifle/ar12 = -1,
			/obj/item/ammo_magazine/rifle/ar12/ap = -1,
			/obj/item/ammo_magazine/rifle/ar12/hp = -1,
			/obj/item/weapon/gun/rifle/ar18 = -1,
			/obj/item/ammo_magazine/rifle/ar18 = -1,
			/obj/item/ammo_magazine/rifle/ar18/ap = -1,
			/obj/item/ammo_magazine/rifle/ar18/hp = -1,
			/obj/item/weapon/gun/shotgun/pump/lever/repeater = -1,
			/obj/item/ammo_magazine/packet/p4570 = -1,
			/obj/item/weapon/gun/shotgun/double/martini = -1,
			/obj/item/ammo_magazine/rifle/martini = -1,
			/obj/item/ammo_magazine/rifle/martini/white = -1,
			/obj/item/weapon/gun/rifle/type71 = -1,
			/obj/item/ammo_magazine/rifle/type71 = -1,
			/obj/item/ammo_magazine/rifle/type71/ap = -1,
			/obj/item/ammo_magazine/rifle/type71/hp = -1,
			/obj/item/weapon/gun/rifle/ar21 = -1,
			/obj/item/ammo_magazine/rifle/ar21 = -1,
			/obj/item/ammo_magazine/rifle/ar21/ap = -1,
			/obj/item/ammo_magazine/rifle/ar21/hp = -1,
		),
		"Пистолеты-пулемёты" = list(
			/obj/item/weapon/gun/smg/vector = -1,
			/obj/item/ammo_magazine/smg/vector = -1,
			/obj/item/ammo_magazine/smg/vector/ap = -1,
			/obj/item/ammo_magazine/smg/vector/hp = -1,
			/obj/item/ammo_magazine/smg/vector/incendiary = -1,
		),
		"Снайперские винтовки" = list(
			/obj/item/weapon/gun/rifle/dmr37 = -1,
			/obj/item/ammo_magazine/rifle/dmr37 = -1,
			/obj/item/weapon/gun/rifle/sr127= -1,
			/obj/item/ammo_magazine/rifle/sr127 = -1,
			/obj/item/weapon/gun/rifle/sniper/svd = -1,
			/obj/item/ammo_magazine/sniper/svd = -1,
			/obj/item/weapon/gun/revolver/r44/coltrifle = -1,
			/obj/item/ammo_magazine/revolver/rifle = -1,
		),
		"Энергетическое" = list(
			/obj/item/cell/lasgun/lasrifle = -1,
			/obj/item/weapon/gun/energy/lasgun/lasrifle/standard_marine_rifle = -1,
			/obj/item/weapon/gun/energy/lasgun/lasrifle/standard_marine_sniper = -1,
			/obj/item/weapon/gun/energy/lasgun/lasrifle/standard_marine_carbine = -1,
			/obj/item/weapon/gun/energy/lasgun/lasrifle/standard_marine_mlaser = -1,
			/obj/item/weapon/gun/energy/lasgun/lasrifle/standard_marine_pistol = -1,
			/obj/item/weapon/gun/energy/lasgun/lasrifle/tesla = -1,
		),
		"Дробовики" = list(
			/obj/item/weapon/gun/shotgun/pump/t35 = -1,
			/obj/item/weapon/gun/shotgun/combat/standardmarine = -1,
			/obj/item/weapon/gun/shotgun/combat/shq6 = -1,
			/obj/item/ammo_magazine/shotgun = -1,
			/obj/item/ammo_magazine/shotgun/buckshot = -1,
			/obj/item/ammo_magazine/shotgun/flechette = -1,
			/obj/item/ammo_magazine/shotgun/tracker = -1,
			/obj/item/weapon/gun/rifle/sh15 = -1,
			/obj/item/ammo_magazine/rifle/sh15_flechette = -1,
			/obj/item/ammo_magazine/rifle/sh15_slug = -1,
			/obj/item/weapon/gun/shotgun/double/marine = -1,
			/obj/item/storage/holster/belt/ts34/full = -1,
		),
		"Пулемёты" = list(
			/obj/item/weapon/gun/rifle/mg60 = -1,
			/obj/item/ammo_magazine/mg60 = -1,
			/obj/item/weapon/gun/mg27 = -1,
			/obj/item/ammo_magazine/mg27 = -1,
			/obj/item/storage/box/hsg102 = -1,
			/obj/item/weapon/gun/hmg08 = -1,
			/obj/item/ammo_magazine/hmg08 = -1,
			/obj/item/ammo_magazine/hmg08/small = -1,
		),
		"Ближний бой" = list(
			/obj/item/weapon/combat_knife = -1,
			/obj/item/attachable/bayonetknife = -1,
			/obj/item/stack/throwing_knife = -1,
			/obj/item/storage/belt/knifepouch = -1,
			/obj/item/storage/holster/blade/tomahawk/full = -1,
			/obj/item/storage/holster/blade/machete/full = -1,
			/obj/item/storage/holster/blade/harvester/full = -1,
			/obj/item/weapon/twohanded/spear/tactical = -1,
			/obj/item/weapon/twohanded/spear/tactical/harvester = -1,
			/obj/item/weapon/twohanded/glaive/harvester = -1,
			/obj/item/weapon/powerfist = -1,
			/obj/item/weapon/shield/riot/marine = -1,
			/obj/item/weapon/shield/riot/marine/deployable = -1,
			/obj/item/weapon/combat_knife/harvester = -1,
		),
		"Пистолеты" = list(
			/obj/item/weapon/gun/revolver/r44 = -1,
			/obj/item/ammo_magazine/revolver/r44 = -1,
			/obj/item/storage/briefcase/t500 = -1,
			/obj/item/ammo_magazine/revolver/t500 = -1,
			/obj/item/ammo_magazine/revolver/t500/slavs = -1,
			/obj/item/ammo_magazine/revolver/t312 = -1,
			/obj/item/weapon/gun/pistol/p17 = -1,
			/obj/item/ammo_magazine/pistol/p17 = -1,
			/obj/item/weapon/gun/pistol/vp70 = -1,
			/obj/item/ammo_magazine/pistol/vp70 = -1,
			/obj/item/ammo_magazine/pistol/vp70/hp = -1,
			/obj/item/ammo_magazine/pistol/vp70/incendiary = -1,
			/obj/item/weapon/gun/pistol/plasma_pistol = -1,
			/obj/item/ammo_magazine/pistol/plasma_pistol = -1,
			/obj/item/weapon/gun/shotgun/double/derringer = -1,
			/obj/item/ammo_magazine/pistol/derringer = -1,
		),
		"Гранаты" = list(
			/obj/item/weapon/gun/grenade_launcher/single_shot = -1,
			/obj/item/weapon/gun/grenade_launcher/multinade_launcher/unloaded = -1,
			/obj/item/weapon/gun/rifle/tx54 = -1,
			/obj/item/ammo_magazine/rifle/tx54 = -1,
			/obj/item/ammo_magazine/rifle/tx54/incendiary = -1,
			/obj/item/ammo_magazine/rifle/tx54/smoke = -1,
			/obj/item/ammo_magazine/rifle/tx54/smoke/dense = -1,
			/obj/item/ammo_magazine/rifle/tx54/smoke/tangle = -1,
			/obj/item/explosive/grenade = -1,
			/obj/item/explosive/grenade/m15 = -1,
			/obj/item/explosive/grenade/sticky = -1,
			/obj/item/explosive/grenade/sticky/trailblazer = -1,
			/obj/item/explosive/grenade/sticky/trailblazer/phosphorus = -1,
			/obj/item/explosive/grenade/sticky/cloaker = -1,
			/obj/item/explosive/grenade/incendiary = -1,
			/obj/item/explosive/grenade/smokebomb = -1,
			/obj/item/explosive/grenade/smokebomb/cloak = -1,
			/obj/item/explosive/grenade/smokebomb/drain = -1,
			/obj/item/explosive/grenade/mirage = -1,
			/obj/item/storage/box/m94 = -1,
			/obj/item/storage/box/m94/cas = -1,
		),
		"Специализированное" = list(
			/obj/item/weapon/gun/rifle/pepperball = -1,
			/obj/item/ammo_magazine/rifle/pepperball = -1,
			/obj/item/weapon/gun/flamer/big_flamer/marinestandard = -1,
			/obj/item/ammo_magazine/flamer_tank/large = -1,
			/obj/item/ammo_magazine/flamer_tank/large/G = -1,
			/obj/item/ammo_magazine/flamer_tank/backtank = -1,
			/obj/item/jetpack_marine = -1,
			/obj/item/bodybag/tarp = -1,
			/obj/item/mortar_kit/knee = 4,
			/obj/item/mortal_shell/knee = 40,
		),
		"Тяжёлое вооружение" = list(
			/obj/structure/closet/crate/mortar_ammo/mortar_kit = -1,
			/obj/structure/closet/crate/mortar_ammo/howitzer_kit = -1,
			/obj/structure/largecrate/supply/weapons/at36 = -1,
			/obj/item/storage/box/crate/sentry = -1,
			/obj/item/sentry_upgrade_kit = -1,
			/obj/item/storage/holster/backholster/rpg/full = -1,
			/obj/item/ammo_magazine/rocket/recoilless = -1,
			/obj/item/ammo_magazine/rocket/recoilless/light = -1,
			/obj/item/ammo_magazine/rocket/recoilless/heat = -1,
			/obj/item/ammo_magazine/rocket/recoilless/cloak = -1,
			/obj/item/ammo_magazine/rocket/recoilless/smoke = -1,
			/obj/item/ammo_magazine/rocket/recoilless/plasmaloss = -1,
		),
		"Модули" = list(
			/obj/item/attachable/bayonet = -1,
			/obj/item/attachable/compensator = -1,
			/obj/item/attachable/extended_barrel = -1,
			/obj/item/attachable/suppressor = -1,
			/obj/item/attachable/heavy_barrel = -1,
			/obj/item/attachable/lace = -1,
			/obj/item/attachable/lace/t500 = -1,
			/obj/item/attachable/flashlight = -1,
			/obj/item/attachable/flashlight/under = -1,
			/obj/item/attachable/magnetic_harness = -1,
			/obj/item/attachable/reddot = -1,
			/obj/item/attachable/b7_scope = -1,
			/obj/item/attachable/motiondetector = -1,
			/obj/item/attachable/scope/marine = -1,
			/obj/item/attachable/scope/mini = -1,
			/obj/item/attachable/angledgrip = -1,
			/obj/item/attachable/verticalgrip = -1,
			/obj/item/attachable/foldable/bipod = -1,
			/obj/item/attachable/gyro = -1,
			/obj/item/attachable/lasersight = -1,
			/obj/item/attachable/burstfire_assembly = -1,
			/obj/item/weapon/gun/shotgun/combat/masterkey = -1,
			/obj/item/weapon/gun/grenade_launcher/underslung = -1,
			/obj/item/weapon/gun/energy/lasgun/lasrifle/pocket_beam = -1,
			/obj/item/weapon/gun/flamer/mini_flamer = -1,
			/obj/item/ammo_magazine/flamer_tank/mini = -1,
			/obj/item/ammo_magazine/flamer_tank/mini/G = -1,
			/obj/item/weapon/gun/rifle/pepperball/pepperball_mini = -1,
			/obj/item/ammo_magazine/rifle/pepperball/pepperball_mini = -1,
			/obj/item/attachable/stock/t76 = -1,
			/obj/item/attachable/flamer_nozzle = -1,
			/obj/item/attachable/flamer_nozzle/wide = -1,
			/obj/item/attachable/flamer_nozzle/long = -1,
		),
		"Коробки" = list(
			/obj/item/ammo_magazine/packet/p9mm = -1,
			/obj/item/ammo_magazine/packet/p9mm/ap = -1,
			/obj/item/ammo_magazine/packet/p9mm/hp = -1,
			/obj/item/ammo_magazine/packet/p9mm/incendiary = -1,
			/obj/item/ammo_magazine/packet/acp = -1,
			/obj/item/ammo_magazine/packet/acp/ap = -1,
			/obj/item/ammo_magazine/packet/acp/hp = -1,
			/obj/item/ammo_magazine/packet/rifle762X39 = -1,
			/obj/item/ammo_magazine/packet/p380acp = -1,
			/obj/item/ammo_magazine/packet/magnum = -1,
			/obj/item/ammo_magazine/packet/t500 = -1,
			/obj/item/ammo_magazine/packet/t500/qk = -1,
			/obj/item/ammo_magazine/packet/t500/slavs = -1,
			/obj/item/ammo_magazine/packet/t312 = -1,
			/obj/item/ammo_magazine/packet/p10x20mm = -1,
			/obj/item/ammo_magazine/packet/p10x24mm = -1,
			/obj/item/ammo_magazine/packet/p10x24mm/ap = -1,
			/obj/item/ammo_magazine/packet/p10x24mm/hp = -1,
			/obj/item/ammo_magazine/packet/p10x24mm/incendiary = -1,
			/obj/item/ammo_magazine/packet/groza = -1,
			/obj/item/ammo_magazine/packet/groza/ap = -1,
			/obj/item/ammo_magazine/packet/groza/hp = -1,
			/obj/item/ammo_magazine/packet/p10x25mm = -1,
			/obj/item/ammo_magazine/packet/p10x25mm/ap = -1,
			/obj/item/ammo_magazine/packet/p10x25mm/hp = -1,
			/obj/item/ammo_magazine/packet/p10x26mm = -1,
			/obj/item/ammo_magazine/packet/p10x27mm = -1,
			/obj/item/ammo_magazine/packet/p86x70mm = -1,
			/obj/item/ammo_magazine/packet/standardautoshotgun = -1,
			/obj/item/ammo_magazine/packet/standardautoshotgun/flechette = -1,
			/obj/item/ammo_magazine/packet/p4570 = -1,
			/obj/item/ammo_magazine/packet/long_special = -1,
			/obj/item/storage/box/visual/magazine = -1,
			/obj/item/storage/box/visual/grenade = -1,
			/obj/structure/closet/crate/mass_produced_crate = -1,
			/obj/structure/closet/crate/mass_produced_crate/alpha = -1,
			/obj/structure/closet/crate/mass_produced_crate/bravo = -1,
			/obj/structure/closet/crate/mass_produced_crate/charlie = -1,
			/obj/structure/closet/crate/mass_produced_crate/delta = -1,
			/obj/structure/closet/crate/mass_produced_crate/ammo = -1,
			/obj/structure/closet/crate/mass_produced_crate/construction = -1,
			/obj/structure/closet/crate/mass_produced_crate/explosives = -1,
			/obj/structure/closet/crate/mass_produced_crate/medical = -1,
			/obj/structure/closet/crate/mass_produced_crate/supply = -1,
			/obj/structure/closet/crate/mass_produced_crate/weapon = -1,
		),
		"Утилити" = list(
			/obj/item/flashlight/combat = -1,
			/obj/item/weapon/gun/grenade_launcher/single_shot/flare/marine = -1,
			/obj/item/tool/shovel/etool = -1,
			/obj/item/tool/extinguisher = -1,
			/obj/item/tool/extinguisher/mini = -1,
			/obj/item/assembly/signaler = -1,
			/obj/item/binoculars = -1,
			/obj/item/compass = -1,
			/obj/item/tool/hand_labeler = -1,
			/obj/item/toy/deck/kotahi = -1,
			/obj/item/toy/deck = -1,
			/obj/item/deployable_floodlight = -1,
			/obj/item/fulton_extraction_pack = -1,
			/obj/item/facepaint/premium = -1,
		)
	)

/obj/machinery/vending/cigarette
	name = "cigarette machine" //OCD had to be uppercase to look nice with the new formating
	desc = "A specialized vending machine designed to contribute to your slow and uncomfortable death."
	product_slogans = "There's no better time to start smokin'.;\
		Smoke now, and win the adoration of your peers.;\
		They beat cancer centuries ago, so smoke away.;\
		If you're not smoking, you must be joking.;\
		Probably not bad for you!;\
		Don't believe the scientists!;\
		It's good for you!;\
		Don't quit, buy more!;\
		Smoke!;\
		Nicotine heaven.;\
		Best cigarettes since 2150.;\
		Don't be so hard on yourself, kid. Smoke a Lucky Star!;\
		Professionals. Better cigarettes for better people. Yes, better people."
	icon_state = "cigs"
	icon_vend = "cigs-vend"
	icon_deny = "cigs-deny"
	wrenchable = FALSE
	isshared = TRUE
	products = list(
		/obj/item/storage/fancy/cigarettes/luckystars = -1,
		/obj/item/storage/fancy/cigarettes/dromedaryco = -1,
		/obj/item/storage/fancy/cigarettes/kpack = -1,
		/obj/item/storage/fancy/cigarettes/lady_finger = -1,
		/obj/item/storage/fancy/cigarettes = -1,
		/obj/item/storage/fancy/chemrettes = -1,
		/obj/item/storage/box/matches = -1,
		/obj/item/tool/lighter/random = -1,
		/obj/item/tool/lighter/zippo = -1,
		/obj/item/clothing/mask/cigarette/cigar/havana = 5
	)

	premium = list(/obj/item/storage/fancy/cigar = 25)
	seasonal_items = list()

/obj/machinery/vending/cigarette/colony
	product_slogans = "Koorlander Gold, for the refined palate.;Lady Fingers, for the dainty smoker.;Lady Fingers, treat your palete with pink!;The big blue K means a cool fresh day!;For the taste that cools your mood, look for the big blue K!;Refined smokers go for Gold!;Lady Fingers are preferred by women who appreciate a cool smoke.;Lady Fingers are the number one cigarette this side of Gateway!;The tobacco connoisseur prefers Koorlander Gold.;For the cool, filtered feel, Lady Finger Cigarettes provide the smoothest draw of any cigarette on the market.;For the man who knows his place is at the top, Koorlander Gold shows the world that you're the best and no-one can say otherwise.;The Colonial Administration Bureau would like to remind you that smoking kills."
	product_ads = "For the taste that cools your mood, look for the big blue K!;Refined smokers go for Gold!;Lady Fingers are preferred by women who appreciate a cool smoke.;Lady Fingers are the number one cigarette this side of Gateway!;The tobacco connoisseur prefers Koorlander Gold.;For the cool, filtered feel, Lady Finger Cigarettes provide the smoothest draw of any cigarette on the market.;For the man who knows his place is at the top, Koorlander Gold shows the world that you're the best and no-one can say otherwise.;The Colonial Administration Bureau would like to remind you that smoking kills."
	products = list(
		/obj/item/storage/fancy/cigarettes/kpack = 15,
		/obj/item/storage/fancy/cigarettes/lady_finger = 15,
		/obj/item/storage/box/matches = 10,
		/obj/item/tool/lighter/random = 20,
	)

/obj/machinery/vending/cigarette/nopower
	use_power = NO_POWER_USE

/obj/machinery/vending/cigarette/valhalla
	resistance_flags = INDESTRUCTIBLE
	use_power = NO_POWER_USE
	products = list(
		/obj/item/storage/fancy/cigarettes/luckystars = -1,
		/obj/item/storage/fancy/chemrettes = -1,
		/obj/item/storage/box/matches = -1,
		/obj/item/tool/lighter/random = -1,
		/obj/item/tool/lighter/zippo = -1,
		/obj/item/clothing/mask/cigarette/cigar/havana = -1,
		/obj/item/storage/fancy/cigar = -1,
	)

/obj/machinery/vending/cargo_supply
	name = "\improper Operational Supplies Vendor"
	desc = "A large vendor for dispensing specialty and bulk supplies. Restricted to cargo personnel only."
	icon_state = "requisitionop"
	icon_vend = "requisitionop-vend"
	icon_deny = "requisitionop-deny"
	wrenchable = FALSE
	req_one_access = list(ACCESS_MARINE_CARGO, ACCESS_MARINE_LOGISTICS)
	products = list(
		"Surplus Special Equipment" = list(
			/obj/item/pinpointer = 1,
			/obj/item/supply_beacon = 1,
			/obj/item/explosive/plastique = 5,
			/obj/item/fulton_extraction_pack = 2,
			/obj/item/clothing/suit/storage/marine/boomvest = 20,
			/obj/item/radio/headset/mainship/marine/alpha = -1,
			/obj/item/radio/headset/mainship/marine/bravo = -1,
			/obj/item/radio/headset/mainship/marine/charlie = -1,
			/obj/item/radio/headset/mainship/marine/delta = -1,
		),
		"Mining Equipment" = list(
			/obj/item/minerupgrade/automatic = 1,
			/obj/item/minerupgrade/reinforcement = 1,
			/obj/item/minerupgrade/overclock = 1,
		),
		"Reqtorio Basics" = list(
			/obj/item/paper/factoryhowto = -1,
			/obj/machinery/fabricator/gunpowder = 2,
			/obj/machinery/fabricator/junk = 1,
			/obj/machinery/assembler = 10,
			/obj/machinery/splitter = -1,
			/obj/item/stack/conveyor/thirty = -1,
			/obj/item/conveyor_switch_construct = -1,
		),
		"Grenade Boxes" = list(
			/obj/item/storage/box/visual/grenade/frag = 1,
			/obj/item/storage/box/visual/grenade/incendiary = 2,
			/obj/item/storage/box/visual/grenade/m15 = 1,
			/obj/item/storage/box/visual/grenade/cloak = 1,
			/obj/item/storage/box/visual/grenade/sticky = 1,
			/obj/item/storage/box/visual/grenade/trailblazer = 1,
		),
		"Ammo Boxes" = list(
			/obj/item/big_ammo_box = -1,
			/obj/item/big_ammo_box/smg = -1,
			/obj/item/big_ammo_box/mg = -1,
			/obj/item/shotgunbox = -1,
			/obj/item/shotgunbox/buckshot = -1,
			/obj/item/shotgunbox/flechette = -1,
			/obj/item/shotgunbox/tracker = -1,
			/obj/item/storage/box/visual/magazine/compact/p14/full = -1,
			/obj/item/storage/box/visual/magazine/compact/p23/full = -1,
			/obj/item/storage/box/visual/magazine/compact/r44/full = -1,
			/obj/item/storage/box/visual/magazine/compact/p17/full = -1,
			/obj/item/storage/box/visual/magazine/compact/vp70/full = -1,
			/obj/item/storage/box/visual/magazine/compact/plasma_pistol/full = -1,
			/obj/item/storage/box/visual/magazine/compact/ar12/full = -1,
			/obj/item/storage/box/visual/magazine/compact/martini/full = -1,
			/obj/item/storage/box/visual/magazine/compact/lasrifle/marine/full = -1,
			/obj/item/storage/box/visual/magazine/compact/sh15/flechette/full = -1,
			/obj/item/storage/box/visual/magazine/compact/sh15/slug/full = -1,
			/obj/item/storage/box/visual/magazine/compact/dmr37/full = -1,
			/obj/item/storage/box/visual/magazine/compact/sr127/full = -1,
			/obj/item/storage/box/visual/magazine/compact/mg60/full = -1,
			/obj/item/storage/box/visual/magazine/compact/mg27/full = -1,
		),
		"Mecha Ammo" = list(
			/obj/item/mecha_ammo/vendable/pistol = -1,
			/obj/item/mecha_ammo/vendable/burstpistol = -1,
			/obj/item/mecha_ammo/vendable/smg = -1,
			/obj/item/mecha_ammo/vendable/burstrifle = -1,
			/obj/item/mecha_ammo/vendable/rifle = -1,
			/obj/item/mecha_ammo/vendable/shotgun = -1,
			/obj/item/mecha_ammo/vendable/lmg = -1,
			/obj/item/mecha_ammo/vendable/lightcannon = -1,
			/obj/item/mecha_ammo/vendable/heavycannon = -1,
			/obj/item/mecha_ammo/vendable/minigun = -1,
			/obj/item/mecha_ammo/vendable/sniper = -1,
			/obj/item/mecha_ammo/vendable/grenade = -1,
			/obj/item/mecha_ammo/vendable/flamer = -1,
			/obj/item/mecha_ammo/vendable/rpg = -1,
		)
	)

/obj/machinery/vending/lasgun
	name = "\improper Terra Experimental cell field charger"
	desc = "An automated power cell dispenser and charger. Used to recharge energy weapon power cells, including in the field. Has an internal battery that charges off the power grid when wrenched down."
	icon_state = "lascharger"
	icon_vend = "lascharger-vend"
	icon_deny = "lascharger-deny"
	wrenchable = TRUE
	drag_delay = FALSE
	anchored = FALSE
	idle_power_usage = 1
	active_power_usage = 50
	machine_current_charge = 50000 //integrated battery for recharging energy weapons. Normally 10000.
	machine_max_charge = 50000
	product_slogans = "Static Shock!;Power cell running low? Recharge here!;Need a charge?;Power up!;Electrifying!;Empower yourself!"
	products = list(
		/obj/item/cell/lasgun/lasrifle = 10, /obj/item/cell/lasgun/volkite/powerpack/marine = 2,
	)

/obj/machinery/vending/lasgun/Initialize(mapload)
	. = ..()
	update_icon()

/obj/machinery/vending/lasgun/update_icon_state()
	. = ..()
	if(machine_max_charge)
		switch(machine_current_charge / max(1,machine_max_charge))
			if(0.7 to 1)
				icon_state = "lascharger"
			if(0.51 to 0.75)
				icon_state = "lascharger_75"
			if(0.26 to 0.50)
				icon_state = "lascharger_50"
			if(0.01 to 0.25)
				icon_state = "lascharger_25"
			if(0)
				icon_state = "lascharger_0"

/obj/machinery/vending/lasgun/examine(mob/user)
	. = ..()
	. += "Internal battery charge: <b>[machine_current_charge]</b>/<b>[machine_max_charge]</b>"

/obj/machinery/vending/marineFood
	name = "\improper Marine Food and Drinks Vendor"
	desc = "Standard Issue Food and Drinks Vendor, containing standard military food and drinks."
	icon_state = "sustenance"
	icon_vend = "sustenance-vend"
	icon_deny = "sustenance-deny"
	wrenchable = FALSE
	isshared = TRUE
	product_ads = "Standard Issue Marine food!;It's good for you, and not the worst thing in the world.;Just fucking eat it.;You should have joined the Air Force if you wanted better food.;1200 calories in just a few bites!;Get that tabaso sauce to make it tasty!;Try the cornbread.;Try the pizza.;Try the pasta.;Try the tofu, wimp.;Try the pork.; 9 Flavors of Protein!; You'll never guess the mystery flavor!"
	products = list(
		/obj/item/reagent_containers/food/snacks/protein_pack = -1,
		/obj/item/reagent_containers/food/snacks/mre_pack/meal1 = -1,
		/obj/item/reagent_containers/food/snacks/mre_pack/meal2 = -1,
		/obj/item/reagent_containers/food/snacks/mre_pack/meal3 = -1,
		/obj/item/reagent_containers/food/snacks/mre_pack/meal4 = -1,
		/obj/item/reagent_containers/food/snacks/mre_pack/meal5 = -1,
		/obj/item/reagent_containers/food/snacks/mre_pack/meal6 = -1,
		/obj/item/storage/box/mre = -1,
		/obj/item/reagent_containers/food/drinks/flask/marine = -1,
	)
//Christmas inventory
/*
					/obj/item/reagent_containers/food/snacks/mre_pack/xmas1 = 25,
					/obj/item/reagent_containers/food/snacks/mre_pack/xmas2 = 25,
					/obj/item/reagent_containers/food/snacks/mre_pack/xmas3 = 25)*/

/obj/machinery/vending/marineFood/valhalla
	resistance_flags = INDESTRUCTIBLE
	use_power = NO_POWER_USE

/obj/machinery/vending/marineFood/som
	name = "\improper SOM Food and Drinks Vendor"
	faction = FACTION_SOM
	products = list(
		/obj/item/reagent_containers/food/snacks/protein_pack/som = -1,
		/obj/item/storage/box/mre/som = -1,
		/obj/item/reagent_containers/food/drinks/flask/marine = -1,
	)

/obj/machinery/vending/MarineMed
	name = "\improper MarineMed"
	desc = "Marine Medical drug dispenser - Provided by Nanotrasen Pharmaceuticals Division(TM)."
	icon_state = "marinemed"
	icon_vend = "marinemed-vend"
	icon_deny = "marinemed-deny"
	product_ads = "Go save some lives!;The best stuff for your medbay.;Only the finest tools.;All natural chemicals!;This stuff saves lives.;Don't you want some?"
	req_one_access = ALL_MARINE_ACCESS
	wrenchable = FALSE
	isshared = TRUE
	products = list(
		"Pill Bottles" = list(
			/obj/item/storage/pill_bottle/bicaridine = -1,
			/obj/item/storage/pill_bottle/kelotane = -1,
			/obj/item/storage/pill_bottle/tramadol = -1,
			/obj/item/storage/pill_bottle/tricordrazine = -1,
			/obj/item/storage/pill_bottle/ifosfamide = -1,
			/obj/item/storage/pill_bottle/combatmix = -1,
			/obj/item/storage/pill_bottle/dylovene = -1,
			/obj/item/storage/pill_bottle/dexalin = -1,
			/obj/item/storage/pill_bottle/paracetamol = -1,
			/obj/item/storage/pill_bottle/isotonic = -1,
			/obj/item/storage/pill_bottle/sugar = -1,
			/obj/item/storage/pill_bottle/doctor_delight = -1,
			/obj/item/storage/pill_bottle = -1,
		),
		"Auto Injector" = list(
			/obj/item/reagent_containers/hypospray/autoinjector/bicaridine = -1,
			/obj/item/reagent_containers/hypospray/autoinjector/kelotane = -1,
			/obj/item/reagent_containers/hypospray/autoinjector/tramadol = -1,
			/obj/item/reagent_containers/hypospray/autoinjector/tricordrazine = -1,
			/obj/item/reagent_containers/hypospray/autoinjector/dylovene = -1,
			/obj/item/reagent_containers/hypospray/autoinjector/combat = -1,
			/obj/item/reagent_containers/hypospray/autoinjector/isotonic = -1,
			/obj/item/reagent_containers/hypospray/autoinjector/inaprovaline = -1,
			/obj/item/reagent_containers/hypospray/autoinjector/spaceacillin = 20,
			/obj/item/reagent_containers/hypospray/autoinjector/hypervene = 20,
			/obj/item/reagent_containers/hypospray/autoinjector/alkysine = 20,
			/obj/item/reagent_containers/hypospray/autoinjector/imidazoline = 20,
			/obj/item/reagent_containers/hypospray/autoinjector/medicalnanites = 20,
			/obj/item/reagent_containers/hypospray/autoinjector/sulfasalazine = 20,
		),
		"Heal Pack" = list(
			/obj/item/stack/medical/heal_pack/gauze = -1,
			/obj/item/stack/medical/heal_pack/ointment = -1,
			/obj/item/stack/medical/splint = -1,
			/obj/item/stack/medical/heal_pack/advanced/bruise_pack = 50,
			/obj/item/stack/medical/heal_pack/advanced/burn_pack = 50,
		),
		"Misc" = list(
			/obj/item/defibrillator = 8,
			/obj/item/healthanalyzer = 16,
			/obj/item/bodybag/cryobag = 24,
		),
	)

/obj/machinery/vending/MarineMed/valhalla
	resistance_flags = INDESTRUCTIBLE
	use_power = NO_POWER_USE
	req_one_access = null
	products = list(
		"Pill Bottles" = list(
			/obj/item/storage/pill_bottle/bicaridine = -1,
			/obj/item/storage/pill_bottle/kelotane = -1,
			/obj/item/storage/pill_bottle/tramadol = -1,
			/obj/item/storage/pill_bottle/tricordrazine = -1,
			/obj/item/storage/pill_bottle/ifosfamide = -1,
			/obj/item/storage/pill_bottle/combatmix = -1,
			/obj/item/storage/pill_bottle/dylovene = -1,
			/obj/item/storage/pill_bottle/dexalin = -1,
			/obj/item/storage/pill_bottle/paracetamol = -1,
			/obj/item/storage/pill_bottle/isotonic = -1,
			/obj/item/storage/pill_bottle/sugar = -1,
			/obj/item/storage/pill_bottle/doctor_delight = -1,
			/obj/item/storage/pill_bottle = -1,
		),
		"Auto Injector" = list(
			/obj/item/reagent_containers/hypospray/autoinjector/bicaridine = -1,
			/obj/item/reagent_containers/hypospray/autoinjector/kelotane = -1,
			/obj/item/reagent_containers/hypospray/autoinjector/tramadol = -1,
			/obj/item/reagent_containers/hypospray/autoinjector/tricordrazine = -1,
			/obj/item/reagent_containers/hypospray/autoinjector/dylovene = -1,
			/obj/item/reagent_containers/hypospray/autoinjector/combat = -1,
			/obj/item/reagent_containers/hypospray/autoinjector/isotonic = -1,
			/obj/item/reagent_containers/hypospray/autoinjector/inaprovaline = -1,
			/obj/item/reagent_containers/hypospray/autoinjector/oxycodone = -1,
			/obj/item/reagent_containers/hypospray/autoinjector/hypervene = -1,
			/obj/item/reagent_containers/hypospray/autoinjector/alkysine = -1,
			/obj/item/reagent_containers/hypospray/autoinjector/imidazoline = -1,
			/obj/item/reagent_containers/hypospray/autoinjector/quickclot = -1,
			/obj/item/reagent_containers/hypospray/autoinjector/medicalnanites = -1,
			/obj/item/reagent_containers/hypospray/autoinjector/sulfasalazine = 20,
			/obj/item/reagent_containers/hypospray/autoinjector/russian_red = -1,
		),
		"Heal Pack" = list(
			/obj/item/stack/medical/heal_pack/gauze = -1,
			/obj/item/stack/medical/heal_pack/ointment = -1,
			/obj/item/stack/medical/heal_pack/advanced/bruise_pack = -1,
			/obj/item/stack/medical/heal_pack/advanced/burn_pack = -1,
			/obj/item/stack/medical/splint = -1,
		),
		"Misc" = list(
			/obj/item/defibrillator = -1,
			/obj/item/healthanalyzer = -1,
			/obj/item/healthanalyzer/gloves = -1,
			/obj/item/bodybag/cryobag = -1,
		),
		"Valhalla" = list(
			/obj/item/reagent_containers/hypospray/autoinjector/virilyth = -1,
			/obj/item/reagent_containers/hypospray/autoinjector/roulettium = -1,
			/obj/item/reagent_containers/hypospray/autoinjector/rezadone = -1,
			/obj/item/reagent_containers/hypospray/autoinjector/spaceacillin = -1,
			/obj/item/reagent_containers/hypospray/autoinjector/combat = -1,
			/obj/item/reagent_containers/hypospray/autoinjector/synaptizine = -1,
			/obj/item/reagent_containers/hypospray/autoinjector/neuraline = -1,
			/obj/item/reagent_containers/hypospray/autoinjector/peridaxon_plus = -1,
			/obj/item/reagent_containers/hypospray/autoinjector/quickclotplus = -1,
		))

/obj/machinery/vending/MarineMed/Blood
	name = "\improper MM Blood Dispenser"
	desc = "Marine Med brand Blood Pack dispensery."
	icon_state = "bloodvendor"
	icon_vend = "bloodvendor-vend"
	icon_deny = "bloodvendor-deny"
	product_slogans = "The best blood on the market!;Totally came from an ethical source!;O negative is the universal donor, use it!;Prevent hypovolemic shock starting today!"
	req_one_access = list(ACCESS_MARINE_MEDBAY, ACCESS_MARINE_CHEMISTRY, ACCESS_MARINE_MEDPREP)
	products = list(
		/obj/item/reagent_containers/blood/APlus = 5,
		/obj/item/reagent_containers/blood/AMinus = 5,
		/obj/item/reagent_containers/blood/BPlus = 5,
		/obj/item/reagent_containers/blood/BMinus = 5,
		/obj/item/reagent_containers/blood/OPlus = 5,
		/obj/item/reagent_containers/blood/OMinus = 5,
		/obj/item/reagent_containers/blood/empty = 10,
	)

/obj/machinery/vending/MarineMed/Blood/build_inventory(list/productlist, category)
	. = ..()
	var/temp_list[] = productlist
	var/obj/item/reagent_containers/blood/temp_path
	var/blood_type
	for(var/datum/vending_product/R AS in (product_records + coin_records))
		if(R.product_path in temp_list)
			temp_path = R.product_path
			blood_type = initial(temp_path.blood_type)
			R.product_name += blood_type? " [blood_type]" : ""
			temp_list -= R.product_path
			if(!length(temp_list)) break

/obj/machinery/vending/MarineMed/Blood/valhalla
	resistance_flags = INDESTRUCTIBLE
	use_power = NO_POWER_USE
	req_one_access = null
	products = list(
		/obj/item/reagent_containers/blood/APlus = -1,
		/obj/item/reagent_containers/blood/AMinus = -1,
		/obj/item/reagent_containers/blood/BPlus = -1,
		/obj/item/reagent_containers/blood/BMinus = -1,
		/obj/item/reagent_containers/blood/OPlus = -1,
		/obj/item/reagent_containers/blood/OMinus = -1,
		/obj/item/reagent_containers/blood/empty = -1,
	)

/obj/machinery/vending/armor_supply
	name = "\improper Surplus Armor Equipment Vendor"
	desc = "An automated equipment rack hooked up to a colossal storage of armor and accessories. Nanotrasen designed a new vendor that utilizes bluespace technology to send surplus equipment from outer colonies' sweatshops to your hands! Be grateful."
	icon_state = "surplus_armor"
	icon_vend = "surplus-vend"
	icon_deny = "surplus_armor-deny"
	isshared = TRUE
	wrenchable = FALSE
	product_ads = "You are out of uniform, marine! Where is your armor? Don't have any? You expect me to believe that, maggot?;Why wear heavy armor and unable to chase the enemy when you can go light and zoom by your peers?;Thank your armor later when you didn't die!;I remember PAS, do you remember PAS?;Time to paint the rainbow!;So many selections to choose from!"
	products = list(
		"Xenonauten" = list(
			/obj/item/clothing/suit/modular/xenonauten/light = -1,
			/obj/item/clothing/suit/modular/xenonauten = -1,
			/obj/item/clothing/suit/modular/xenonauten/heavy = -1,
			/obj/item/clothing/head/modular/m10x = -1,
			/obj/item/clothing/head/modular/m10x/heavy = -1,
			/obj/item/clothing/suit/modular/xenonauten/light/mk1 = -1,
			/obj/item/clothing/suit/modular/xenonauten/mk1 = -1,
			/obj/item/clothing/suit/modular/xenonauten/heavy/mk1 = -1,
			/obj/item/clothing/head/modular/m10x/mk1 = -1,
		),
		"Jaeger" = list(
			/obj/item/clothing/suit/modular/jaeger/light = -1,
			/obj/item/clothing/suit/modular/jaeger/light/skirmisher = -1,
			/obj/item/clothing/suit/modular/jaeger = -1,
			/obj/item/clothing/suit/modular/jaeger/eva = -1,
			/obj/item/clothing/suit/modular/jaeger/helljumper = -1,
			/obj/item/clothing/suit/modular/jaeger/ranger = -1,
			/obj/item/clothing/suit/modular/jaeger/heavy = -1,
			/obj/item/clothing/suit/modular/jaeger/heavy/assault = -1,
			/obj/item/clothing/suit/modular/jaeger/heavy/eod = -1,
			/obj/item/clothing/head/modular/marine/skirmisher = -1,
			/obj/item/clothing/head/modular/marine/scout = -1,
			/obj/item/clothing/head/modular/marine = -1,
			/obj/item/clothing/head/modular/marine/eva = -1,
			/obj/item/clothing/head/modular/marine/eva/skull = -1,
			/obj/item/clothing/head/modular/marine/helljumper = -1,
			/obj/item/clothing/head/modular/marine/ranger = -1,
			/obj/item/clothing/head/modular/marine/traditional = -1,
			/obj/item/clothing/head/modular/marine/gungnir = -1,
			/obj/item/clothing/head/modular/marine/assault = -1,
			/obj/item/clothing/head/modular/marine/eod = -1,
		),
		"Combat Robot" = list(
			/obj/item/clothing/suit/modular/robot/light = -1,
			/obj/item/clothing/suit/modular/robot = -1,
			/obj/item/clothing/suit/modular/robot/heavy = -1,
			/obj/item/clothing/head/modular/robot/light = -1,
			/obj/item/clothing/head/modular/robot = -1,
			/obj/item/clothing/head/modular/robot/heavy = -1,
		),
		"General" = list(
			/obj/item/clothing/suit/modular = -1,
			/obj/item/clothing/suit/modular/rownin = -1,
			/obj/item/clothing/suit/armor/bulletproof = -1,
			/obj/item/facepaint/green = -1,
			/obj/item/facepaint/sniper = -1,
			/obj/item/facepaint/black = -1,
			/obj/item/facepaint/brown = -1,
		),
		"Armor modules" = list(
			/obj/item/armor_module/storage/general = -1,
			/obj/item/armor_module/storage/ammo_mag = -1,
			/obj/item/armor_module/storage/integrated = -1,
			/obj/item/armor_module/storage/engineering = -1,
			/obj/item/armor_module/storage/medical = -1,
			/obj/item/armor_module/storage/injector = -1,
			/obj/item/armor_module/storage/grenade = -1,
			/obj/item/armor_module/module/welding = -1,
			/obj/item/armor_module/module/binoculars = -1,
			/obj/item/armor_module/module/artemis = -1,
			/obj/item/armor_module/module/tyr_head = -1,
			/obj/item/armor_module/module/antenna = -1,
			/obj/item/armor_module/module/motion_detector = -1,
			/obj/item/armor_module/module/mimir_environment_protection/mark1 = -1,
			/obj/item/armor_module/module/mimir_environment_protection/mimir_helmet/mark1 = -1,
			/obj/item/armor_module/module/tyr_extra_armor/mark1 = -1,
			/obj/item/armor_module/module/ballistic_armor = -1,
			/obj/item/armor_module/module/hod_head = -1,
			/obj/item/armor_module/module/better_shoulder_lamp = -1,
			/obj/item/armor_module/module/pluto = -1,
			/obj/item/armor_module/module/chemsystem = -1,
			/obj/item/armor_module/module/eshield = -1,
		),
		"Jaeger Mk.I chestpieces" = list(
			/obj/item/armor_module/armor/chest/marine/skirmisher = -1,
			/obj/item/armor_module/armor/chest/marine/skirmisher/scout = -1,
			/obj/item/armor_module/armor/chest/marine = -1,
			/obj/item/armor_module/armor/chest/marine/eva = -1,
			/obj/item/armor_module/armor/chest/marine/assault = -1,
			/obj/item/armor_module/armor/chest/marine/assault/eod = -1,
			/obj/item/armor_module/armor/chest/marine/helljumper = -1,
			/obj/item/armor_module/armor/chest/marine/ranger = -1,
		),
		"Jaeger Mk.I armpiece" = list(
			/obj/item/armor_module/armor/arms/marine/skirmisher = -1,
			/obj/item/armor_module/armor/arms/marine/scout = -1,
			/obj/item/armor_module/armor/arms/marine = -1,
			/obj/item/armor_module/armor/arms/marine/eva = -1,
			/obj/item/armor_module/armor/arms/marine/assault = -1,
			/obj/item/armor_module/armor/arms/marine/eod = -1,
			/obj/item/armor_module/armor/arms/marine/helljumper = -1,
			/obj/item/armor_module/armor/arms/marine/ranger = -1,
		),
		"Jaeger Mk.I legpiece" = list(
			/obj/item/armor_module/armor/legs/marine/skirmisher = -1,
			/obj/item/armor_module/armor/legs/marine/scout = -1,
			/obj/item/armor_module/armor/legs/marine = -1,
			/obj/item/armor_module/armor/legs/marine/eva = -1,
			/obj/item/armor_module/armor/legs/marine/assault = -1,
			/obj/item/armor_module/armor/legs/marine/eod = -1,
			/obj/item/armor_module/armor/legs/marine/scout = -1,
			/obj/item/armor_module/armor/legs/marine/helljumper = -1,
			/obj/item/armor_module/armor/legs/marine/ranger = -1,
		),
		"Jaeger Mk.I helmets" = list(
			/obj/item/clothing/head/modular/marine/old/skirmisher = -1,
			/obj/item/clothing/head/modular/marine/old/scout = -1,
			/obj/item/clothing/head/modular/marine/old = -1,
			/obj/item/clothing/head/modular/marine/old/open = -1,
			/obj/item/clothing/head/modular/marine/old/eva = -1,
			/obj/item/clothing/head/modular/marine/old/eva/skull = -1,
			/obj/item/clothing/head/modular/marine/old/assault = -1,
			/obj/item/clothing/head/modular/marine/old/eod = -1,
		),
	)

/obj/machinery/vending/armor_supply/valhalla
	resistance_flags = INDESTRUCTIBLE
	use_power = NO_POWER_USE

/obj/machinery/vending/uniform_supply
	name = "\improper Surplus Clothing Vendor"
	desc = "An automated equipment rack hooked up to a colossal storage of clothing and accessories. Nanotrasen designed a new vendor that utilizes bluespace technology to send surplus equipment from outer colonies' sweatshops to your hands! Be grateful."
	icon_state = "surplus_clothes"
	icon_vend = "surplus-vend"
	icon_deny = "surplus_clothes-deny"
	wrenchable = FALSE
	isshared = TRUE
	product_ads = "Be the musician that you parents never approve you of.;You gotta look good when you're in the battlefield.;We have all types of hats here!;What did one hat say to the other on the hiking trip? I'll wait here, you go on ahead;Sometimes, a beret is better than a helmet.;Drip is the priority, marine."
	products = list(
		"Uniforms" = list(
			/obj/item/clothing/under/marine/robotic = -1,
			/obj/item/clothing/under/marine = -1,
			/obj/item/clothing/under/marine/camo = -1,
			/obj/item/clothing/under/marine/camo/desert = -1,
			/obj/item/clothing/under/marine/camo/snow = -1,
			/obj/item/clothing/under/marine/orion_fatigue = -1,
			/obj/item/clothing/under/marine/red_fatigue = -1,
			/obj/item/clothing/under/marine/lv_fatigue = -1,
			/obj/item/clothing/under/marine/striped = -1,
			/obj/item/clothing/under/marine/slav = -1,
			/obj/item/clothing/under/marine/camo = -1,
			/obj/item/clothing/under/marine/veteran/marine = -1,
			/obj/item/clothing/under/marine/separatist = -1,
			/obj/item/clothing/under/marine/jaeger = -1,
			/obj/item/clothing/under/marine/squad/neck/delta = -1,
			/obj/item/clothing/under/marine/squad/neck/charile = -1,
			/obj/item/clothing/under/marine/squad/neck/bravo = -1,
			/obj/item/clothing/under/marine/squad/neck/alpha = -1,
			/obj/item/clothing/under/marine/squad/neck/foreign = -1,
			/obj/item/clothing/under/marine/whites = -1,
			/obj/item/clothing/under/marine/service = -1,
			/obj/item/clothing/suit/white_dress_jacket = -1,
			/obj/item/armor_module/armor/badge = -1,
			/obj/item/armor_module/armor/cape = -1,
			/obj/item/armor_module/armor/cape/kama = -1,
			/obj/item/armor_module/module/pt_belt = -1,
		),
		"Gloves" = list(
			/obj/item/clothing/gloves/marine = -1,
			/obj/item/clothing/gloves/marine/fingerless = -1,
			/obj/item/clothing/gloves/marine/veteran/marine = -1,
			/obj/item/clothing/gloves/marine/separatist = -1,
			/obj/item/clothing/gloves/white = -1,
		),
		"Shoes" = list(
			/obj/item/clothing/shoes/marine/full = -1,
			/obj/item/clothing/shoes/marine/brown/full = -1,
			/obj/item/clothing/shoes/marine/headskin = -1,
			/obj/item/clothing/shoes/marine/separatist = -1,
			/obj/item/clothing/shoes/cowboy = -1,
			/obj/item/clothing/shoes/white = -1,
		),
		"Webbings" = list(
			/obj/item/armor_module/storage/uniform/black_vest = -1,
			/obj/item/armor_module/storage/uniform/brown_vest = -1,
			/obj/item/armor_module/storage/uniform/white_vest = -1,
			/obj/item/armor_module/storage/uniform/webbing = -1,
			/obj/item/armor_module/storage/uniform/holster = -1,
		),
		"Belts" = list(
			/obj/item/storage/belt/marine = -1,
			/obj/item/storage/belt/shotgun = -1,
			/obj/item/storage/belt/shotgun/martini = -1,
			/obj/item/storage/belt/grenade = -1,
			/obj/item/belt_harness/marine = -1,
			/obj/item/storage/belt/sparepouch = -1,
			/obj/item/storage/holster/belt/pistol/t457 = -1,
			/obj/item/storage/holster/belt/revolver/t457 = -1,
			/obj/item/storage/holster/blade/tomahawk/full = -1,
			/obj/item/storage/holster/blade/machete/full = -1,
			/obj/item/storage/holster/blade/harvester/full = -1,
			/obj/item/weapon/twohanded/glaive/harvester = -1,
			/obj/item/storage/belt/utility/full =-1,
			/obj/item/storage/belt/medical_small = -1,
			/obj/item/storage/holster/belt/revolver/t500 = -1,
			/obj/item/storage/belt/mortar_belt = 4,
		),
		"Pouches" = list(
			/obj/item/storage/pouch/pistol = -1,
			/obj/item/storage/pouch/magazine/large = -1,
			/obj/item/storage/pouch/magazine/pistol/large = -1,
			/obj/item/storage/pouch/shotgun = -1,
			/obj/item/storage/holster/flarepouch/full = -1,
			/obj/item/storage/pouch/grenade = -1,
			/obj/item/storage/pouch/explosive = -1,
			/obj/item/storage/pouch/medkit = -1,
			/obj/item/storage/pouch/medical_injectors = -1,
			/obj/item/storage/pouch/pressurized_reagent_pouch/empty = -1,
			/obj/item/storage/pouch/pressurized_reagent_pouch/bktt = -1,
			/obj/item/storage/pouch/med_lolipops = -1,
			/obj/item/storage/pouch/construction = -1,
			/obj/item/storage/pouch/electronics = -1,
			/obj/item/storage/pouch/tools/full = -1,
			/obj/item/storage/pouch/field_pouch = -1,
			/obj/item/storage/pouch/general/large = -1,
			/obj/item/cell/lasgun/volkite/powerpack/marine = -1,
			/obj/item/storage/pouch/general/medium = -1,
		),
		"Headwear" = list(
			/obj/item/clothing/head/slouch = -1,
			/obj/item/clothing/head/headband/red = -1,
			/obj/item/clothing/head/headband/rambo = -1,
			/obj/item/clothing/head/headband/snake = -1,
			/obj/item/clothing/head/headband = -1,
			/obj/item/clothing/head/squad_headband/alpha = -1,
			/obj/item/clothing/head/squad_headband/bravo = -1,
			/obj/item/clothing/head/squad_headband/charlie = -1,
			/obj/item/clothing/head/squad_headband/delta = -1,
			/obj/item/clothing/head/squad_headband/foreign = -1,
			/obj/item/clothing/head/bandanna/grey = -1,
			/obj/item/clothing/head/bandanna/brown = -1,
			/obj/item/clothing/head/bandanna/red = -1,
			/obj/item/clothing/head/tgmcberet/tan = -1,
			/obj/item/clothing/head/tgmcberet/red = -1,
			/obj/item/clothing/head/tgmcberet/red2 = -1,
			/obj/item/clothing/head/tgmcberet/blueberet = -1,
			/obj/item/clothing/head/tgmcberet/darkgreen = -1,
			/obj/item/clothing/head/tgmcberet/green = -1,
			/obj/item/clothing/head/tgmcberet/snow = -1,
			/obj/item/clothing/head/tgmcberet/squad/alpha = -1,
			/obj/item/clothing/head/tgmcberet/squad/alpha/black = -1,
			/obj/item/clothing/head/tgmcberet/squad/bravo = -1,
			/obj/item/clothing/head/tgmcberet/squad/bravo/black = -1,
			/obj/item/clothing/head/tgmcberet/squad/charlie = -1,
			/obj/item/clothing/head/tgmcberet/squad/charlie/black = -1,
			/obj/item/clothing/head/tgmcberet/squad/delta = -1,
			/obj/item/clothing/head/tgmcberet/squad/delta/black = -1,
			/obj/item/clothing/head/tgmcberet/squad/foreign = -1,
			/obj/item/clothing/head/tgmcberet/squad/foreign/black = -1,
			/obj/item/clothing/head/tgmcberet/vdv = -1,
			/obj/item/clothing/head/tgmcberet/commando = -1,
			/obj/item/clothing/head/beret/marine = -1,
			/obj/item/clothing/head/tgmcberet = -1,
			/obj/item/clothing/head/white_dress = -1,
			/obj/item/clothing/head/garrisoncap = -1,
			/obj/item/clothing/head/serviceberet = -1,
			/obj/item/clothing/head/servicecap = -1,
			/obj/item/clothing/head/strawhat = -1,
		),
		"Masks" = list(
			/obj/item/clothing/mask/rebreather/scarf = -1,
			/obj/item/clothing/mask/bandanna/skull = -1,
			/obj/item/clothing/mask/bandanna/green = -1,
			/obj/item/clothing/mask/bandanna/white = -1,
			/obj/item/clothing/mask/bandanna/black = -1,
			/obj/item/clothing/mask/bandanna = -1,
			/obj/item/clothing/mask/bandanna/alpha = -1,
			/obj/item/clothing/mask/bandanna/bravo = -1,
			/obj/item/clothing/mask/bandanna/charlie = -1,
			/obj/item/clothing/mask/bandanna/delta = -1,
			/obj/item/clothing/mask/balaclava = -1,
			/obj/item/clothing/mask/rebreather = -1,
			/obj/item/clothing/mask/breath = -1,
			/obj/item/clothing/mask/gas = -1,
			/obj/item/clothing/mask/gas/tactical = -1,
			/obj/item/clothing/mask/gas/tactical/coif = -1,
			/obj/item/clothing/mask/gas/separatist = -1,
			/obj/item/clothing/mask/gas/veteran = -1,
			/obj/item/clothing/mask/gas/fullgas = -1,
			/obj/item/clothing/mask/gas/sgmask = -1,
			/obj/item/clothing/mask/gas/redmask = -1,
		),
		"Backpacks" = list(
			/obj/item/storage/backpack/marine/standard = -1,
			/obj/item/storage/backpack/marine/satchel = -1,
			/obj/item/storage/backpack/marine/satchel/green = -1,
			/obj/item/storage/backpack/marine/standard/molle = -1,
			/obj/item/storage/backpack/marine/satchel/molle = -1,
			/obj/item/storage/backpack/marine/standard/scav = -1,
			/obj/item/tool/weldpack/marinestandard = -1,
			/obj/item/storage/backpack/marine/satchel/tech = 2,
		),
		"Instruments" = list(
			/obj/item/instrument/violin = -1,
			/obj/item/instrument/piano_synth = -1,
			/obj/item/instrument/banjo = -1,
			/obj/item/instrument/guitar = -1,
			/obj/item/instrument/glockenspiel = -1,
			/obj/item/instrument/accordion = -1,
			/obj/item/instrument/trumpet = -1,
			/obj/item/instrument/saxophone = -1,
			/obj/item/instrument/trombone = -1,
			/obj/item/instrument/recorder = -1,
			/obj/item/instrument/harmonica = -1,
		),
		"Eyewear" = list(
			/obj/item/clothing/glasses/regular = -1,
			/obj/item/clothing/glasses/eyepatch = -1,
			/obj/item/clothing/glasses/sunglasses/fake/big = -1,
			/obj/item/clothing/glasses/sunglasses/fake/big/prescription = -1,
			/obj/item/clothing/glasses/sunglasses/fake = -1,
			/obj/item/clothing/glasses/sunglasses/fake/prescription = -1,
			/obj/item/clothing/glasses/mgoggles = -1,
			/obj/item/clothing/glasses/mgoggles/prescription = -1,
			/obj/item/clothing/glasses/orange = -1,
		),
		"Clothes bundles" = list(
			/obj/effect/vendor_bundle/white_dress = -1,
			/obj/effect/vendor_bundle/service_uniform = -1,
			/obj/effect/vendor_bundle/separatist_uniform = -1,
			/obj/effect/vendor_bundle/veteran_uniform = -1,
		)
	)

/obj/machinery/vending/uniform_supply/valhalla
	resistance_flags = INDESTRUCTIBLE
	use_power = NO_POWER_USE

/obj/machinery/vending/dress_supply
	name = "\improper TerraGovTech dress uniform vendor"
	desc = "An automated rack hooked up to a colossal storage of dress uniforms."
	icon_state = "marineuniform"
	icon_vend = "marineuniform_vend"
	icon_deny = "marineuniform"
	req_one_access = list(ACCESS_MARINE_LOGISTICS, ACCESS_MARINE_PREP, ACCESS_MARINE_CARGO)
	product_ads = "Hey! You! Stop looking like a turtle and start looking like a TRUE marine!;Dress whites, fresh off the ironing board!;Why kill in armor when you can kill in style?;These uniforms are so sharp you'd cut yourself just looking at them!"
	wrenchable = FALSE
	isshared = TRUE
	products = list(
		/obj/effect/vendor_bundle/white_dress = -1,
		/obj/item/clothing/under/marine/whites = -1,
		/obj/item/clothing/suit/white_dress_jacket = -1,
		/obj/item/clothing/head/white_dress = -1,
		/obj/item/clothing/shoes/white = -1,
		/obj/item/clothing/gloves/white = -1,
		/obj/effect/vendor_bundle/service_uniform = -1,
		/obj/item/clothing/under/marine/service = -1,
		/obj/item/clothing/head/garrisoncap = -1,
		/obj/item/clothing/head/servicecap = -1,
		/obj/item/clothing/under/marine/black_suit = -1,
	)

/obj/machinery/vending/dress_supply/valhalla
	resistance_flags = INDESTRUCTIBLE
	use_power = NO_POWER_USE

/obj/machinery/vending/valhalla_req
	name = "\improper TerraGovTech requisition vendor"
	desc = "An automated rack hooked up to a colossal storage of items."
	icon_state = "requisitionop"
	resistance_flags = INDESTRUCTIBLE
	use_power = NO_POWER_USE
	products = list(
		"Weapon" = list(
			/obj/item/weapon/gun/energy/lasgun/lasrifle/tesla = -1,
			/obj/item/cell/lasgun/lasrifle/recharger = -1,
			/obj/item/weapon/gun/rifle/railgun = -1,
			/obj/item/ammo_magazine/railgun = -1,
			/obj/item/ammo_magazine/railgun/smart = -1,
			/obj/item/ammo_magazine/railgun/hvap = -1,
			/obj/item/weapon/gun/rifle/tx8 = -1,
			/obj/item/ammo_magazine/rifle/tx8 = -1,
			/obj/item/ammo_magazine/rifle/tx8/impact = -1,
			/obj/item/ammo_magazine/rifle/tx8/incendiary = -1,
			/obj/item/ammo_magazine/packet/scout_rifle = -1,
			/obj/item/weapon/gun/energy/lasgun/lasrifle/xray = -1,
			/obj/item/weapon/gun/launcher/rocket/m57a4/t57 = -1,
			/obj/item/ammo_magazine/rocket/m57a4 = -1,
			/obj/item/weapon/gun/launcher/rocket/sadar/valhalla = -1,
			/obj/item/ammo_magazine/rocket/sadar = -1,
			/obj/item/ammo_magazine/rocket/sadar/unguided = -1,
			/obj/item/ammo_magazine/rocket/sadar/ap = -1,
			/obj/item/ammo_magazine/rocket/sadar/wp = -1,
			/obj/item/ammo_magazine/rocket/sadar/wp/unguided = -1,
			/obj/item/weapon/gun/shotgun/zx76 = -1,
			/obj/item/ammo_magazine/shotgun/incendiary = -1,
			/obj/item/weapon/gun/rifle/sr81 = -1,
			/obj/item/ammo_magazine/rifle/sr81 = -1,
			/obj/item/weapon/gun/rifle/sniper/antimaterial = -1,
			/obj/item/ammo_magazine/sniper = -1,
			/obj/item/ammo_magazine/rifle/sr81 = -1,
			/obj/item/weapon/gun/minigun/valhalla = -1,
			/obj/item/ammo_magazine/minigun_powerpack = -1,
			/obj/item/weapon/gun/rifle/sg29 = -1,
			/obj/item/ammo_magazine/sg29 = -1,
			/obj/item/weapon/gun/minigun/smart_minigun = -1,
			/obj/item/ammo_magazine/minigun_powerpack/smartgun = -1,
			/obj/item/ammo_magazine/packet/smart_minigun = -1,
			/obj/item/weapon/gun/launcher/rocket/oneuse = -1,
			/obj/item/storage/holster/belt/revolver/mateba/full = -1,
			/obj/item/ammo_magazine/revolver/mateba = -1,
			/obj/item/ammo_magazine/packet/mateba = -1,
			/obj/item/ammo_magazine/rifle/sr127/flak = -1,
			/obj/item/ammo_magazine/flamer_tank/backtank/X = -1,
			/obj/item/ammo_magazine/flamer_tank/backtank/G = -1,
			/obj/item/weapon/twohanded/rocketsledge = -1,
			/obj/item/explosive/grenade/training = -1,
			/obj/item/explosive/grenade/impact = -1,
			/obj/item/explosive/grenade/phosphorus = -1,
			/obj/item/explosive/grenade/chem_grenade/metalfoam = -1,
			/obj/item/explosive/grenade/smokebomb/neuro = -1,
			/obj/item/explosive/grenade/smokebomb/acid = -1,
			/obj/item/explosive/grenade/smokebomb/satrapine = -1,
			/obj/item/weapon/gun/rifle/m412l1_hpr = -1,
			/obj/item/ammo_magazine/m412l1_hpr = -1,
			/obj/item/weapon/gun/rifle/famas = -1,
			/obj/item/ammo_magazine/rifle/famas = -1,
		),
		"Mounted" = list(
			/obj/item/weapon/gun/atr22 = -1,
			/obj/item/ammo_magazine/atr22 = -1,
			/obj/item/ammo_magazine/atr22/flak = -1,
			/obj/item/weapon/gun/standard_minigun = -1,
			/obj/item/ammo_magazine/heavy_minigun = -1,
			/obj/item/weapon/gun/agls37 = -1,
			/obj/item/ammo_magazine/agls37 = -1,
			/obj/item/ammo_magazine/agls37/fragmentation = -1,
			/obj/item/ammo_magazine/agls37/incendiary = -1,
			/obj/item/ammo_magazine/agls37/flare = -1,
			/obj/item/ammo_magazine/agls37/cloak = -1,
			/obj/item/ammo_magazine/agls37/tanglefoot = -1,
			/obj/item/weapon/gun/heavy_isg = -1,
			/obj/item/ammo_magazine/heavy_isg/he = -1,
			/obj/item/ammo_magazine/heavy_isg/sabot = -1,
		),
		"Equipment" = list(
			/obj/item/clothing/glasses/hud/xenohud = -1,
			/obj/item/clothing/mask/gas/swat = -1,
			/obj/item/clothing/head/helmet/riot = -1,
			/obj/item/clothing/suit/storage/marine/specialist/valhalla = -1,
			/obj/item/clothing/head/helmet/marine/specialist = -1,
			/obj/item/clothing/gloves/marine/specialist = -1,
			/obj/item/clothing/suit/storage/marine/B17/valhalla = -1,
			/obj/item/clothing/head/helmet/marine/grenadier = -1,
			/obj/item/storage/backpack/marine/satchel/scout_cloak = -1,
			/obj/item/storage/backpack/marine/satchel/scout_cloak/sniper = -1,
			/obj/item/storage/belt/grenade/b17 = -1,
			/obj/item/armor_module/module/valkyrie_autodoc = -1,
			/obj/item/armor_module/module/fire_proof = -1,
			/obj/item/armor_module/module/fire_proof_helmet = -1,
			/obj/item/armor_module/module/tyr_extra_armor = -1,
			/obj/item/armor_module/module/tyr_head = -1,
			/obj/item/attachable/shoulder_mount = -1,
			/obj/item/armor_module/module/mimir_environment_protection = -1,
			/obj/item/armor_module/module/mimir_environment_protection/mimir_helmet = -1,
			/obj/item/armor_module/module/better_shoulder_lamp = -1,
			/obj/item/attachable/heatlens = -1,
			/obj/item/storage/backpack/lightpack = -1,
			/obj/item/clothing/suit/storage/marine/riot = -1,
			/obj/item/clothing/head/helmet/marine/riot = -1,
			/obj/item/clothing/suit/storage/marine/boomvest = -1,
		),
		"Assault Vehicle" = list(
			/obj/item/armored_weapon = -1,
			/obj/item/armored_weapon/ltaap = -1,
			/obj/item/armored_weapon/secondary_weapon = -1,
			/obj/item/ammo_magazine/tank/ltb_cannon = -1,
			/obj/item/ammo_magazine/tank/ltb_cannon/apfds = -1,
			/obj/item/ammo_magazine/tank/ltaap_chaingun = -1,
			/obj/item/ammo_magazine/tank/secondary_cupola = -1,
			/obj/item/ammo_magazine/tank/flamer = -1,
		),
		"Implants" = list(
			/obj/item/implanter/sandevistan = -1,
			/obj/item/implanter/suicide_dust = -1,
			/obj/item/implanter/blade = -1,
			/obj/item/implanter/cloak = -1,
			/obj/item/implanter/chem/blood = -1,
			/obj/item/implanter/chem = -1,
			/obj/item/implanter/neurostim = -1,
			/obj/item/implanter/implantator/combat/firearms = -1,
			/obj/item/implanter/implantator/combat/melee = -1,
			/obj/item/implanter/implantator/codex/medical = -1,
			/obj/item/implanter/implantator/codex/surgery = -1,
			/obj/item/implanter/implantator/codex/engineer = -1,
			/obj/item/implanter/implantator/codex/construct = -1,
			/obj/item/implanter/implantator/oper_system/leadership = -1,
		),
	)

/obj/machinery/vending/valhalla_seasonal_req
	name = "\improper TerraGovTech seasonal vendor"
	desc = "An automated rack hooked up to a colossal storage of items."
	icon_state = "requisitionop"
	resistance_flags = INDESTRUCTIBLE
	use_power = NO_POWER_USE
	products = list(
		"Seasonal" = list(
			/obj/item/weapon/gun/revolver/small = -1,
			/obj/item/ammo_magazine/revolver/small = -1,
			/obj/item/weapon/gun/revolver/single_action/m44 = -1,
			/obj/item/ammo_magazine/revolver = -1,
			/obj/item/weapon/gun/revolver/judge = -1,
			/obj/item/ammo_magazine/revolver/judge = -1,
			/obj/item/ammo_magazine/revolver/judge/buckshot = -1,
			/obj/item/weapon/gun/revolver/upp = -1,
			/obj/item/ammo_magazine/revolver/upp = -1,
			/obj/item/weapon/gun/pistol/g22 = -1,
			/obj/item/ammo_magazine/pistol/g22 = -1,
			/obj/item/weapon/gun/pistol/vp78 = -1,
			/obj/item/ammo_magazine/pistol/vp78 = -1,
			/obj/item/weapon/gun/pistol/heavy = -1,
			/obj/item/ammo_magazine/pistol/heavy = -1,
			/obj/item/weapon/gun/pistol/highpower = -1,
			/obj/item/ammo_magazine/pistol/highpower = -1,
			/obj/item/weapon/gun/smg/uzi = -1,
			/obj/item/ammo_magazine/smg/uzi = -1,
			/obj/item/weapon/gun/smg/m25 = -1,
			/obj/item/ammo_magazine/smg/m25 = -1,
			/obj/item/weapon/gun/smg/mp7 = -1,
			/obj/item/ammo_magazine/smg/mp7 = -1,
			/obj/item/weapon/gun/smg/skorpion = -1,
			/obj/item/ammo_magazine/smg/skorpion = -1,
			/obj/item/weapon/gun/revolver/cmb = -1,
			/obj/item/ammo_magazine/revolver/cmb = -1,
			/obj/item/weapon/gun/rifle/mkh = -1,
			/obj/item/ammo_magazine/rifle/mkh = -1,
			/obj/item/weapon/gun/smg/ppsh = -1,
			/obj/item/ammo_magazine/smg/ppsh = -1,
			/obj/item/ammo_magazine/smg/ppsh/extended = -1,
			/obj/item/weapon/gun/rifle/garand = -1,
			/obj/item/ammo_magazine/rifle/garand = -1,
			/obj/item/weapon/gun/pistol/m1911 = -1,
			/obj/item/ammo_magazine/pistol/m1911 = -1,
			/obj/item/weapon/gun/shotgun/combat = -1,
			/obj/item/weapon/gun/shotgun/pump = -1,
			/obj/item/weapon/gun/shotgun/pump/cmb = -1,
			/obj/item/weapon/gun/rifle/mpi_km = -1,
			/obj/item/ammo_magazine/rifle/mpi_km/plum = -1,
			/obj/item/ammo_magazine/packet/groza = -1,
			/obj/item/weapon/gun/rifle/m16 = -1,
			/obj/item/ammo_magazine/rifle/m16 = -1,
			/obj/item/ammo_magazine/packet/pnato = -1,
			/obj/item/weapon/gun/rifle/sniper/svd = -1,
			/obj/item/ammo_magazine/sniper/svd = -1,
			/obj/item/weapon/gun/rifle/m412 = -1,
			/obj/item/ammo_magazine/rifle = -1,
			/obj/item/weapon/gun/rifle/m41a = -1,
			/obj/item/ammo_magazine/rifle/m41a = -1,
			/obj/item/weapon/gun/rifle/type71/seasonal = -1,
			/obj/item/ammo_magazine/rifle/type71 = -1,
			/obj/item/weapon/gun/rifle/alf_machinecarbine = -1,
			/obj/item/ammo_magazine/rifle/alf_machinecarbine = -1,
			/obj/item/weapon/gun/shotgun/pump/lever = -1,
			/obj/item/weapon/gun/shotgun/pump/lever/mbx900 = -1,
			/obj/item/ammo_magazine/shotgun/mbx900 = -1,
			/obj/item/ammo_magazine/shotgun/mbx900/buckshot = -1,
			/obj/item/ammo_magazine/shotgun/mbx900/tracking = -1,
		),
		"Sons of Mars" = list(
			/obj/item/weapon/gun/rifle/som = -1,
			/obj/item/ammo_magazine/rifle/som = -1,
			/obj/item/ammo_magazine/handful/micro_grenade = -1,
			/obj/item/ammo_magazine/handful/micro_grenade/cluster = -1,
			/obj/item/ammo_magazine/handful/micro_grenade/smoke_burst = -1,
			/obj/item/weapon/gun/smg/som = -1,
			/obj/item/ammo_magazine/smg/som = -1,
			/obj/item/weapon/gun/shotgun/som = -1,
			/obj/item/weapon/gun/energy/lasgun/lasrifle/volkite/serpenta = -1,
			/obj/item/cell/lasgun/volkite/small = -1,
			/obj/item/weapon/gun/energy/lasgun/lasrifle/volkite/charger = -1,
			/obj/item/weapon/gun/energy/lasgun/lasrifle/volkite/caliver = -1,
			/obj/item/weapon/gun/energy/lasgun/lasrifle/volkite/culverin = -1,
			/obj/item/cell/lasgun/volkite = -1,
			/obj/item/cell/lasgun/volkite/powerpack = -1,
		),
		"ICC" = list(
			/obj/item/weapon/gun/rifle/icc_battlecarbine = -1,
			/obj/item/ammo_magazine/rifle/icc_battlecarbine = -1,
			/obj/item/weapon/gun/rifle/icc_confrontationrifle = -1,
			/obj/item/ammo_magazine/rifle/icc_confrontationrifle = -1,
			/obj/item/weapon/gun/rifle/icc_sharpshooter = -1,
			/obj/item/ammo_magazine/rifle/icc_sharpshooter = -1,
			/obj/item/weapon/gun/smg/icc_pdw = -1,
			/obj/item/ammo_magazine/smg/icc_pdw = -1,
			/obj/item/weapon/gun/smg/icc_machinepistol = -1,
			/obj/item/ammo_magazine/smg/icc_machinepistol = -1,
			/obj/item/ammo_magazine/smg/icc_machinepistol/hp = -1,
			/obj/item/weapon/gun/pistol/icc_dpistol = -1,
			/obj/item/ammo_magazine/pistol/icc_dpistol = -1,
			/obj/item/weapon/gun/rifle/icc_coilgun = -1,
			/obj/item/ammo_magazine/rifle/icc_coilgun = -1,
			/obj/item/weapon/gun/rifle/icc_autoshotgun = -1,
			/obj/item/ammo_magazine/rifle/icc_autoshotgun = -1,
			/obj/item/ammo_magazine/rifle/icc_autoshotgun/frag = -1,
			/obj/item/weapon/gun/shotgun/pump/trenchgun = -1,
			/obj/item/weapon/gun/rifle/icc_assaultcarbine = -1,
			/obj/item/weapon/gun/rifle/icc_assaultcarbine/export = -1,
			/obj/item/ammo_magazine/rifle/icc_assaultcarbine = -1,
			/obj/item/ammo_magazine/rifle/icc_assaultcarbine/export = -1,
			/obj/item/weapon/gun/rifle/dpm = -1,
			/obj/item/ammo_magazine/rifle/dpm = -1,
			/obj/item/weapon/gun/clf_heavyrifle = -1,
			/obj/item/shotgunbox/clf_heavyrifle = -1,
		),
		"PMC" = list(
			/obj/item/weapon/gun/rifle/sniper/elite = -1,
			/obj/item/ammo_magazine/sniper/elite = -1,
			/obj/item/weapon/gun/rifle/sg29/pmc = -1,
			/obj/item/ammo_magazine/sg29 = -1,
			/obj/item/weapon/gun/smg/m25/elite/pmc = -1,
			/obj/item/ammo_magazine/smg/m25/ap = -1,
			/obj/item/weapon/gun/rifle/m412/elite = -1,
			/obj/item/ammo_magazine/rifle/ap = -1,
		),
		"Misc" = list(
			/obj/item/weapon/gun/shotgun/double = -1,
			/obj/item/weapon/gun/shotgun/double/sawn = -1,
			/obj/item/weapon/gun/pistol/auto9 = -1,
			/obj/item/ammo_magazine/pistol/auto9 = -1,
		)
	)

/obj/machinery/vending/tool
	name = "YouTool"
	desc = "Tools for tools."
	icon_state = "tool"
	icon_deny = "tool-deny"
	icon_vend = "tool-vend"
	isshared = TRUE
	wrenchable = FALSE
	products = list(
		/obj/item/stack/cable_coil = -1,
		/obj/item/tool/crowbar = -1,
		/obj/item/tool/weldingtool = -1,
		/obj/item/tool/wirecutters = -1,
		/obj/item/tool/wrench = -1,
		/obj/item/tool/screwdriver = -1,
		/obj/item/tool/multitool = -1,
	)

/obj/machinery/vending/tool/nopower
	use_power = NO_POWER_USE

/obj/machinery/vending/tool/nopower/valhalla
	resistance_flags = INDESTRUCTIBLE

/obj/machinery/vending/mech_vendor
	name = "\improper Mech equipment vendor"
	desc = "An automated rack hooked up to a colossal storage of items."
	icon_state = "requisitionop"
	resistance_flags = INDESTRUCTIBLE
	use_power = NO_POWER_USE
	wrenchable = FALSE
	products = list(
		"Weapon" = list(
			/obj/item/mecha_parts/mecha_equipment/weapon/ballistic/pistol = -1,
			/obj/item/mecha_parts/mecha_equipment/weapon/ballistic/burstpistol = -1,
			/obj/item/mecha_parts/mecha_equipment/weapon/ballistic/smg = -1,
			/obj/item/mecha_parts/mecha_equipment/weapon/ballistic/burstrifle = -1,
			/obj/item/mecha_parts/mecha_equipment/weapon/ballistic/assault_rifle = -1,
			/obj/item/mecha_parts/mecha_equipment/weapon/ballistic/shotgun = -1,
			/obj/item/mecha_parts/mecha_equipment/weapon/ballistic/greyscale_lmg = -1,
			/obj/item/mecha_parts/mecha_equipment/weapon/ballistic/light_cannon = -1,
			/obj/item/mecha_parts/mecha_equipment/weapon/energy/laser_rifle = -1,
			/obj/item/mecha_parts/mecha_equipment/weapon/energy/laser_projector = -1,
			/obj/item/mecha_parts/mecha_equipment/weapon/energy/laser_smg = -1,
			/obj/item/mecha_parts/mecha_equipment/weapon/ballistic/heavy_cannon = -1,
			/obj/item/mecha_parts/mecha_equipment/weapon/ballistic/minigun = -1,
			/obj/item/mecha_parts/mecha_equipment/weapon/ballistic/launcher/grenadelauncher = -1,
			/obj/item/mecha_parts/mecha_equipment/weapon/ballistic/flamethrower = -1,
			/obj/item/mecha_parts/mecha_equipment/weapon/ballistic/rpg = -1,
			/obj/item/mecha_parts/mecha_equipment/laser_sword = -1,
			/obj/item/mecha_parts/mecha_equipment/weapon/energy/laser_spear = -1,
		),
		"Ammo" = list(
			/obj/item/mecha_ammo/vendable/lmg = -1,
			/obj/item/mecha_ammo/vendable/rifle = -1,
			/obj/item/mecha_ammo/vendable/burstrifle = -1,
			/obj/item/mecha_ammo/vendable/shotgun = -1,
			/obj/item/mecha_ammo/vendable/lightcannon = -1,
			/obj/item/mecha_ammo/vendable/heavycannon = -1,
			/obj/item/mecha_ammo/vendable/smg = -1,
			/obj/item/mecha_ammo/vendable/burstpistol = -1,
			/obj/item/mecha_ammo/vendable/pistol = -1,
			/obj/item/mecha_ammo/vendable/rpg = -1,
			/obj/item/mecha_ammo/vendable/minigun = -1,
			/obj/item/mecha_ammo/vendable/grenade = -1,
			/obj/item/mecha_ammo/vendable/flamer = -1,
		),
		"Equipment" = list(
			/obj/item/mecha_parts/mecha_equipment/armor/melee = -1,
			/obj/item/mecha_parts/mecha_equipment/armor/acid = -1,
			/obj/item/mecha_parts/mecha_equipment/armor/explosive = -1,
			/obj/item/mecha_parts/mecha_equipment/generator/greyscale = -1,
			/obj/item/mecha_parts/mecha_equipment/generator/greyscale/upgraded = -1,
			/obj/item/mecha_parts/mecha_equipment/energy_optimizer = -1,
			/obj/item/mecha_parts/mecha_equipment/melee_core = -1,
			/obj/item/mecha_parts/mecha_equipment/ability/dash = -1,
			/obj/item/mecha_parts/mecha_equipment/ability/smoke/cloak_smoke = -1,
		),
	)

/obj/machinery/vending/medical_uniform_supply
	name = "\improper Medical Clothing Vendor"
	desc = "A special medical vendor designed to supply you with various blood absorbing clothing!"
	icon = 'icons/obj/machines/vending.dmi'
	icon_state = "medidrobe"
	icon_vend = "medidrobe-vend"
	icon_deny = "medidrobe-deny"
	req_access = list(ACCESS_MARINE_MEDBAY, ACCESS_MARINE_CHEMISTRY) //only doctors and researchers can access these
	isshared = TRUE
	product_ads = "If they aren't bleeding, check again."
	products = list(
		"Medical Clothing" = list(
			/obj/item/clothing/under/rank/medical/blue = 3,
			/obj/item/clothing/under/rank/medical/green = 3,
			/obj/item/clothing/under/rank/medical/purple = 3,
			/obj/item/clothing/suit/storage/labcoat = 3,
			/obj/item/clothing/suit/surgical = 3,
			/obj/item/clothing/mask/surgical = 3,
			/obj/item/clothing/head/tgmcberet/medical = 3,
			/obj/item/storage/backpack/satchel/med = 3,
			/obj/item/clothing/gloves/latex = -1,
			/obj/item/clothing/shoes/white = -1,
		),
	)
