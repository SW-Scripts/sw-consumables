local QBCore = exports['qb-core']:GetCoreObject()

local alcoholCount = 0

function AlcoholEffect()
	ShakeGameplayCam('DRUNK_SHAKE', 1.0)
	SetPedMotionBlur(GetPlayerPed(-1), true)
	SetPedMovementClipset(GetPlayerPed(-1), 'MOVE_M@DRUNK@SLIGHTLYDRUNK', true)
	SetPedIsDrunk(GetPlayerPed(-1), true)
	SetPedAccuracy(GetPlayerPed(-1), 0)
	DoScreenFadeIn(1000)
	Wait(120000) -- 2 minute
	ResetPedMovementClipset(GetPlayerPed(-1), 0)
	SetPedIsDrunk(GetPlayerPed(-1), false)
	SetPedMotionBlur(GetPlayerPed(-1), false)
	StopGameplayCamShaking(false)
end

function StrongAlcoholEffect()
	ShakeGameplayCam('DRUNK_SHAKE', 1.0)
	StartScreenEffect('SuccessMichael', 3.0, 0)
	SetPedMotionBlur(GetPlayerPed(-1), true)
	SetPedMovementClipset(GetPlayerPed(-1), 'MOVE_M@DRUNK@MODERATEDRUNK', true)
	SetPedIsDrunk(GetPlayerPed(-1), true)
	SetPedAccuracy(GetPlayerPed(-1), 0)
	DoScreenFadeIn(1000)
	Wait(120000) -- 2 minute
	DoScreenFadeOut(1000)
	Wait(1000)
	DoScreenFadeIn(1000)
	ResetPedMovementClipset(GetPlayerPed(-1), 0)
	SetPedIsDrunk(GetPlayerPed(-1), false)
	SetPedMotionBlur(GetPlayerPed(-1), false)
	StopGameplayCamShaking(false)
	StopScreenEffect('SuccessMichael')
end

RegisterNetEvent('sw-consumables:client:Eat', function(itemName, item)
	if Config.Food[item].enableEmote then
		exports.sw_lib:StartEmote(Config.Food[item].emoteName)
	end
	if Config.ProgressBar == 'qb' then
		QBCore.Functions.Progressbar('eat_item', Locale[Config.Language].info['eating']..exports.sw_lib:GetItemLabel(itemName), 12000, false, true, {
			disableMovement = false,
			disableCarMovement = false,
			disableMouse = false,
			disableCombat = true,
		}, {}, {}, {}, function() -- Done
			ClearPedTasks(PlayerPedId())
			TriggerServerEvent('sw-consumables:server:removeItem', itemName, 1)
			TriggerServerEvent('QBCore:Server:SetMetaData', 'hunger', QBCore.Functions.GetPlayerData().metadata['hunger'] + math.random(Config.Food[item].hunger[1], Config.Food[item].hunger[2]))
			TriggerServerEvent('QBCore:Server:SetMetaData', 'thirst', QBCore.Functions.GetPlayerData().metadata['thirst'] + math.random(Config.Food[item].thirst[1], Config.Food[item].thirst[2]))
			TriggerServerEvent('hud:server:RelieveStress', math.random(Config.Food[item].stress[1], Config.Food[item].stress[2]))
			exports.sw_lib:CancelEmote()
		end, function() -- Cancel
			ClearPedTasks(PlayerPedId())
			exports.sw_lib:CancelEmote()
			TriggerEvent('sw_lib:client:Notify', Locale[Config.Language].error['stop_eating'], 'error')
		end, itemName)
	elseif Config.ProgressBar == 'ox' then
		if lib.progressActive() then return false end
		if lib.progressCircle({
			label = Locale[Config.Language].info['eating']..exports.sw_lib:GetItemLabel(itemName),
			duration = 12000,
			position = 'bottom',
			useWhileDead = false,
			canCancel = true,
			disable = {
				move = false,
				car = false,
				combat = true,
				mouse = false,
				sprint = true
			},
			anim = {},
			prop = {},
		})
		then
			ClearPedTasks(PlayerPedId())
			TriggerServerEvent('sw-consumables:server:removeItem', itemName, 1)
			TriggerServerEvent('QBCore:Server:SetMetaData', 'hunger', QBCore.Functions.GetPlayerData().metadata['hunger'] + math.random(Config.Food[item].hunger[1], Config.Food[item].hunger[2]))
			TriggerServerEvent('QBCore:Server:SetMetaData', 'thirst', QBCore.Functions.GetPlayerData().metadata['thirst'] + math.random(Config.Food[item].thirst[1], Config.Food[item].thirst[2]))
			TriggerServerEvent('hud:server:RelieveStress', math.random(Config.Food[item].stress[1], Config.Food[item].stress[2]))
			exports.sw_lib:CancelEmote()
		else
			ClearPedTasks(PlayerPedId())
			exports.sw_lib:CancelEmote()
			TriggerEvent('sw_lib:client:Notify', Locale[Config.Language].error['stop_eating'], 'error')
		end
	end
end)

RegisterNetEvent('sw-consumables:client:Drink', function(itemName, item)
	if Config.Drinks[item].enableEmote then
		exports.sw_lib:StartEmote(Config.Drinks[item].emoteName)
	end
	if Config.ProgressBar == 'qb' then
		QBCore.Functions.Progressbar('drink_item', Locale[Config.Language].info['drinking']..exports.sw_lib:GetItemLabel(itemName), 12000, false, true, {
			disableMovement = false,
			disableCarMovement = false,
			disableMouse = false,
			disableCombat = true,
		}, {}, {}, {}, function() -- Done
			ClearPedTasks(PlayerPedId())
			TriggerServerEvent('sw-consumables:server:removeItem', itemName, 1)
			TriggerServerEvent('QBCore:Server:SetMetaData', 'hunger', QBCore.Functions.GetPlayerData().metadata['hunger'] + math.random(Config.Drinks[item].hunger[1], Config.Drinks[item].hunger[2]))
			TriggerServerEvent('QBCore:Server:SetMetaData', 'thirst', QBCore.Functions.GetPlayerData().metadata['thirst'] + math.random(Config.Drinks[item].thirst[1], Config.Drinks[item].thirst[2]))
			TriggerServerEvent('hud:server:RelieveStress', math.random(Config.Drinks[item].stress[1], Config.Drinks[item].stress[2]))
			exports.sw_lib:CancelEmote()
		end, function() -- Cancel
			ClearPedTasks(PlayerPedId())
			exports.sw_lib:CancelEmote()
			TriggerEvent('sw_lib:client:Notify', Locale[Config.Language].error['stop_drinking'], 'error')
		end, itemName)
	elseif Config.ProgressBar == 'ox' then
		if lib.progressActive() then return false end
		if lib.progressCircle({
			label = Locale[Config.Language].info['drinking']..exports.sw_lib:GetItemLabel(itemName),
			duration = 12000,
			position = 'bottom',
			useWhileDead = false,
			canCancel = true,
			disable = {
				move = false,
				car = false,
				combat = true,
				mouse = false,
				sprint = true
			},
			anim = {},
			prop = {},
		})
		then
			ClearPedTasks(PlayerPedId())
			TriggerServerEvent('sw-consumables:server:removeItem', itemName, 1)
			TriggerServerEvent('QBCore:Server:SetMetaData', 'hunger', QBCore.Functions.GetPlayerData().metadata['hunger'] + math.random(Config.Drinks[item].hunger[1], Config.Drinks[item].hunger[2]))
			TriggerServerEvent('QBCore:Server:SetMetaData', 'thirst', QBCore.Functions.GetPlayerData().metadata['thirst'] + math.random(Config.Drinks[item].thirst[1], Config.Drinks[item].thirst[2]))
			TriggerServerEvent('hud:server:RelieveStress', math.random(Config.Drinks[item].stress[1], Config.Drinks[item].stress[2]))
			exports.sw_lib:CancelEmote()
		else
			ClearPedTasks(PlayerPedId())
			exports.sw_lib:CancelEmote()
			TriggerEvent('sw_lib:client:Notify', Locale[Config.Language].error['stop_drinking'], 'error')
		end
	end
end)

RegisterNetEvent('sw-consumables:client:Alcohol', function(itemName, item)
	if Config.Alcohol[item].enableEmote then
		exports.sw_lib:StartEmote(Config.Alcohol[item].emoteName)
	end
	if Config.ProgressBar == 'qb' then
		QBCore.Functions.Progressbar('drink_alcohol_item', Locale[Config.Language].info['drinking']..exports.sw_lib:GetItemLabel(itemName), 12000, false, true, {
			disableMovement = false,
			disableCarMovement = false,
			disableMouse = false,
			disableCombat = true,
		}, {}, {}, {}, function() -- Done
			ClearPedTasks(PlayerPedId())
			TriggerServerEvent('sw-consumables:server:removeItem', itemName, 1)
			TriggerServerEvent('QBCore:Server:SetMetaData', 'hunger', QBCore.Functions.GetPlayerData().metadata['hunger'] + math.random(Config.Alcohol[item].hunger[1], Config.Alcohol[item].hunger[2]))
			TriggerServerEvent('QBCore:Server:SetMetaData', 'thirst', QBCore.Functions.GetPlayerData().metadata['thirst'] + math.random(Config.Alcohol[item].thirst[1], Config.Alcohol[item].thirst[2]))
			TriggerServerEvent('hud:server:RelieveStress', math.random(Config.Alcohol[item].stress[1], Config.Alcohol[item].stress[2]))
			alcoholCount = alcoholCount + 1
			if alcoholCount >= 2 and alcoholCount <= 3 then
				TriggerEvent('evidence:client:SetStatus', 'alcohol', 1000)
				AlcoholEffect()
			elseif alcoholCount >= 4 then
				TriggerEvent('evidence:client:SetStatus', 'heavyalcohol', 2000)
				StrongAlcoholEffect()
			end
			exports.sw_lib:CancelEmote()
		end, function() -- Cancel
			ClearPedTasks(PlayerPedId())
			exports.sw_lib:CancelEmote()
			TriggerEvent('sw_lib:client:Notify', Locale[Config.Language].error['stop_drinking'], 'error')
		end, itemName)
	elseif Config.ProgressBar == 'ox' then
		if lib.progressActive() then return false end
		if lib.progressCircle({
			label = Locale[Config.Language].info['drinking']..exports.sw_lib:GetItemLabel(itemName),
			duration = 12000,
			position = 'bottom',
			useWhileDead = false,
			canCancel = true,
			disable = {
				move = false,
				car = false,
				combat = true,
				mouse = false,
				sprint = true
			},
			anim = {},
			prop = {},
		})
		then
			ClearPedTasks(PlayerPedId())
			TriggerServerEvent('sw-consumables:server:removeItem', itemName, 1)
			TriggerServerEvent('QBCore:Server:SetMetaData', 'hunger', QBCore.Functions.GetPlayerData().metadata['hunger'] + math.random(Config.Alcohol[item].hunger[1], Config.Alcohol[item].hunger[2]))
			TriggerServerEvent('QBCore:Server:SetMetaData', 'thirst', QBCore.Functions.GetPlayerData().metadata['thirst'] + math.random(Config.Alcohol[item].thirst[1], Config.Alcohol[item].thirst[2]))
			TriggerServerEvent('hud:server:RelieveStress', math.random(Config.Alcohol[item].stress[1], Config.Alcohol[item].stress[2]))
			alcoholCount = alcoholCount + 1
			if alcoholCount >= 2 and alcoholCount <= 3 then
				TriggerEvent('evidence:client:SetStatus', 'alcohol', 1000)
				AlcoholEffect()
			elseif alcoholCount >= 4 then
				TriggerEvent('evidence:client:SetStatus', 'heavyalcohol', 2000)
				StrongAlcoholEffect()
			end
			exports.sw_lib:CancelEmote()
		else
			ClearPedTasks(PlayerPedId())
			exports.sw_lib:CancelEmote()
			TriggerEvent('sw_lib:client:Notify', Locale[Config.Language].error['stop_drinking'], 'error')
		end
	end
end)