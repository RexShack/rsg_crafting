local sharedItems = exports['qbr-core']:GetItems()

-- start invension shop
Citizen.CreateThread(function()
    for bpos, v in pairs(Config.InvensionShopLocations) do
        exports['qbr-core']:createPrompt(v.name, v.coords, 0xF3830D8E, 'Open ' .. v.name, {
            type = 'client',
            event = 'rsg_crafting:client:OpenInvensionShop',
        })
        if v.showblip == true then
            local StoreBlip = N_0x554d9d53f696d002(1664425300, v.coords)
            SetBlipSprite(StoreBlip, 1475879922, 1)
            SetBlipScale(StoreBlip, 0.2)
			Citizen.InvokeNative(0x9CB1A1623062F402, StoreBlip, v.name)
        end
    end
end)

RegisterNetEvent('rsg_crafting:client:OpenInvensionShop')
AddEventHandler('rsg_crafting:client:OpenInvensionShop', function()
    local ShopItems = {}
    ShopItems.label = "Invension Shop"
    ShopItems.items = Config.InvensionShop
    ShopItems.slots = #Config.InvensionShop
    TriggerServerEvent("inventory:server:OpenInventory", "shop", "InvensionShop_"..math.random(1, 99), ShopItems)
end)
-- end invension shop

-- shovel craftng
RegisterNetEvent('rsg_crafting:client:shovel')
AddEventHandler('rsg_crafting:client:shovel', function()
	local craftingrep = exports['qbr-core']:GetPlayerData().metadata["craftingrep"]
	if craftingrep >= 0 then
		exports['qbr-core']:TriggerCallback('QBCore:HasItem', function(hasItem)
			if hasItem then
				exports['qbr-core']:Progressbar("crafting-shovel", "Crafting a Shovel..", 30000, false, true, {
					disableMovement = true,
					disableCarMovement = false,
					disableMouse = false,
					disableCombat = true,
				}, {}, {}, {}, function() -- Done
					TriggerServerEvent('QBCore:Server:RemoveItem', "steel", 3)
					TriggerServerEvent('QBCore:Server:RemoveItem', "wood", 1)
					TriggerServerEvent('QBCore:Server:RemoveItem', "bpcshovel", 1)
					TriggerEvent("inventory:client:ItemBox", sharedItems["bpcshovel"], "remove")
					TriggerServerEvent('QBCore:Server:AddItem', "shovel", 1)
					TriggerEvent("inventory:client:ItemBox", sharedItems["shovel"], "add")
					TriggerServerEvent("QBCore:Server:SetMetaData", "craftingrep", exports['qbr-core']:GetPlayerData().metadata["craftingrep"] + 1)
					exports['rsg_notify']:DisplayNotification('shovel crafted', 5000)
					Wait(5000)
					exports['rsg_notify']:DisplayNotification('Crafting Reputation +1', 5000)
				end)
			else
				exports['rsg_notify']:DisplayNotification('need more crafting items', 5000)
			end
		end, { ['bpcshovel'] = 1, ['steel'] = 3, ['wood'] = 1 })
	else
		exports['rsg_notify']:DisplayNotification('not enough reputation - lvl 0 required!', 5000)
	end
end)

-- make copy from blueprint original
RegisterNetEvent('rsg_crafting:client:makecopy')
AddEventHandler('rsg_crafting:client:makecopy', function(bpo, bpc, name, repneeded, copycost)
	local craftingrep = exports['qbr-core']:GetPlayerData().metadata["craftingrep"]
	if craftingrep >= repneeded then
		exports['qbr-core']:TriggerCallback('QBCore:HasItem', function(hasItem)
			if hasItem then
				exports['qbr-core']:Progressbar('copy-'..name, 'Making a copy of '..name..'..', Config.BPOCopyTime, false, true, {
					disableMovement = true,
					disableCarMovement = false,
					disableMouse = false,
					disableCombat = true,
				}, {}, {}, {}, function() -- Done
					TriggerServerEvent('QBCore:Server:AddItem', bpc, 1)
					TriggerEvent("inventory:client:ItemBox", sharedItems[bpc], "add")
					exports['rsg_notify']:DisplayNotification(name..' copied', 5000)
				end)
			else
				exports['rsg_notify']:DisplayNotification('you don\'t have this blueprint original', 5000)
			end
		end, { [bpo] = 1 })
	else
		exports['rsg_notify']:DisplayNotification('not enough reputation - lvl '..repneeded..' required!', 5000)
	end
end)