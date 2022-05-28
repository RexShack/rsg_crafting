Config = {}

Config.BPOCopyTime = 30000

-- blueprint original shop items
Config.InvensionShop = {
	[1] = 	{ name = "bposhovel",	price = 500, amount = 1, info = {}, type = "item", slot = 1, }, -- crafting level 0
	[2] = 	{ name = "bpopickaxe",	price = 500, amount = 1, info = {}, type = "item", slot = 2, }, -- crafting level 0
}

-- blueprint original shope locations
Config.InvensionShopLocations = {
	{name = 'Invension Shop', coords = vector3(2516.7561, 2285.0756, 177.35156),	showblip = true},
}

-- blueprint original shop npc
Config.CraftingNpc = {
	[1] = { ["Model"] = "CS_crackpotRobot", ["Pos"] = vector3(2516.7561, 2285.0756, 177.35156 -1), ["Heading"] = 246.71557 }, -- robot
}