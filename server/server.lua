local QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent('sw-consumables:server:removeItem', function(item, amount)
	local src = source
    local Player = QBCore.Functions.GetPlayer(source)
	exports.sw_lib:RemoveItem(src, item, amount)
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

-- Duplication Detection

local expectedResource = 'sw-consumables'
local currentResource = GetCurrentResourceName()

local function DetectDuplicates()
	if currentResource ~= expectedResource then
		Wait(4000)
		TriggerEvent('sw-consumables:server:stopDuplicate', currentResource)
	end
end

DetectDuplicates()

RegisterNetEvent(currentResource..':server:stopDuplicate', function(resource)
	Wait(1000)
	print(('^1[ERROR]^7 This script has been modified, please ensure it is named "%s"'):format(expectedResource))
	StopResource(resource)
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