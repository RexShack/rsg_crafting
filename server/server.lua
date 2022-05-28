
-- get crafting rep
exports['qbr-core']:AddCommand('craftingrep', 'get your crafting reputation', {}, false, function(source)
    local src = source
	local Player = exports['qbr-core']:GetPlayer(src)
    local craftingRep = Player.PlayerData.metadata['craftingrep']
	TriggerClientEvent('rsg_notify:client:bottom_notifiy', src, 'Your Crafting Rep is: '..craftingRep, 5000)
end)

-- bpo shovel copy
exports['qbr-core']:CreateUseableItem('bposhovel', function(source, item)
    local src = source
    local Player = exports['qbr-core']:GetPlayer(src)
	------------------------
	local bpo = 'bposhovel'
	local bpc = 'bpcshovel'
	local name = 'Shovel'
	local repneeded = 0
	local copycost = 1 -- cash removed from copier
	------------------------
	local cashBalance = Player.PlayerData.money["cash"]
	if cashBalance >= copycost then
		Player.Functions.RemoveMoney("cash", copycost, "copy-bpo")
		TriggerClientEvent('rsg_crafting:client:makecopy', src, bpo, bpc, name, repneeded, copycost)
		TriggerClientEvent('rsg_notify:client:notifiy', src, '$'..copycost..' taken for the copy')
	else 
		TriggerClientEvent('rsg_notify:client:notifiy', src, 'you don\'t have enough cash to do that!')
	end
end)

-- use bpc shovel
exports['qbr-core']:CreateUseableItem('bpcshovel', function(source, item)
    local src = source
	TriggerClientEvent('rsg_crafting:client:shovel', src, item.name)
end)

-- bpo pickaxe copy
exports['qbr-core']:CreateUseableItem('bpopickaxe', function(source, item)
    local src = source
    local Player = exports['qbr-core']:GetPlayer(src)
	------------------------
	local bpo = 'bpopickaxe'
	local bpc = 'bpcpickaxe'
	local name = 'Pickaxe'
	local repneeded = 0
	local copycost = 1 -- cash removed from copier
	------------------------
	local cashBalance = Player.PlayerData.money["cash"]
	if cashBalance >= copycost then
		Player.Functions.RemoveMoney("cash", copycost, "copy-bpo")
		TriggerClientEvent('rsg_crafting:client:makecopy', src, bpo, bpc, name, repneeded, copycost)
		TriggerClientEvent('rsg_notify:client:notifiy', src, '$'..copycost..' taken for the copy')
	else 
		TriggerClientEvent('rsg_notify:client:notifiy', src, 'you don\'t have enough cash to do that!')
	end
end)

-- use bpc pickaxe
exports['qbr-core']:CreateUseableItem('bpcpickaxe', function(source, item)
    local src = source
	TriggerClientEvent('rsg_crafting:client:pickaxe', src, item.name)
end)