local QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent('sw-consumables:server:removeItem', function(item, amount)
	local src = source
    local Player = QBCore.Functions.GetPlayer(source)
	Player.Functions.RemoveItem(item, amount)
	TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[item], 'remove', amount)
end)

CreateThread(function()
    for food, data in pairs(Config.Food) do
		QBCore.Functions.CreateUseableItem(data.name, function(source, item)
			TriggerClientEvent('sw-consumables:client:Eat', source, item.name, food)
		end)
	end
	for drink, data in pairs(Config.Drinks) do
		QBCore.Functions.CreateUseableItem(data.name, function(source, item)
			TriggerClientEvent('sw-consumables:client:Drink', source, item.name, drink)
		end)
	end
	for alcohol, data in pairs(Config.Alcohol) do
		QBCore.Functions.CreateUseableItem(data.name, function(source, item)
			TriggerClientEvent('sw-consumables:client:Alcohol', source, item.name, alcohol)
		end)
	end
end)

-- Check Version

local function VersionLog(_type, log)
	local color = _type == 'success' and '^2' or '^1'
	print(('^8[sw-consumables]%s %s^7'):format(color, log))
end

local function CheckMenuVersion()
	PerformHttpRequest('https://raw.githubusercontent.com/SH4UN-W/UpdateVersions/master/sw-consumables.txt', function(err, text, headers)
		local currentVersion = GetResourceMetadata(GetCurrentResourceName(), 'version')
		Wait(3000)
		if not text then
			VersionLog('error', 'Currently unable to run a version check.')
			return
		end
		--VersionLog('success', ('Current Version: %s'):format(currentVersion))
		--VersionLog('success', ('Latest Version: %s'):format(text))
		if text:gsub('%s+', '') == currentVersion:gsub('%s+', '') then
			VersionLog('success', 'You are running the latest version.')
		else
			VersionLog('error', ('You are currently running an outdated version, please update to version %s'):format(text))
		end
	end)
end

CheckMenuVersion()