local QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent('sw-consumables:shared:startEmote', function(emote)
	if Config.Animations == 'rpemotes' then
		TriggerEvent('animations:client:EmoteCommandStart', {emote})
	end
end)

RegisterNetEvent('sw-consumables:shared:cancelEmote', function()
	if Config.Animations == 'rpemotes' then
		exports['rpemotes']:EmoteCancel()
	end
end)