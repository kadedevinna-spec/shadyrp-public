
-----------------------------------------------------------
--[[ Functions  ]]--
-----------------------------------------------------------

-- @param actionIndex (int) : returns the index of the action location [1,2,3,4..].
-- @param data (table form) : returns the data related to the location action from Config.Robberies.
OnExecuteActionType = function(actionIndex, data)

    local actionType = data.ExecuteActionType

    TriggerEvent("tp_libs:ExecuteServerCallBack", "tp_banks:callbacks:hasRequiredItem", function(hasRequiredItem)

        if hasRequiredItem then

            local player      = PlayerPedId()
            local RobberyData = GetRobberyData()

            RobberyData.PerformingAction = true

            if actionType == 'lockpick' then

                TaskStandStill(player, -1)  
                FreezeEntityPosition(player,true)

                local res = exports["lockpick"]:lockpick()

                if res then 
                  TriggerServerEvent("tp_banks:server:onBankRobberyVaultReward", RobberyData.RobberyBankName, actionIndex)

                  -- If success, we don't want the player to loot the same vault, we block it.
                  Config.Robberies[RobberyData.RobberyBankName][actionIndex].isLooted = true

                else
                    TriggerServerEvent("tp_libs:sendNotification", nil, Locales['ROBBERY_VAULT_ATTEMPT_FAILED'], 'error')						
                end

                Wait(1000)
                RobberyData.PerformingAction = false

                TaskStandStill(player, 1)  
                ClearPedSecondaryTask(player)
                RemoveAnimDict("script_proc@rustling@olar@player_picklock")
                FreezeEntityPosition(player,false)		

            elseif actionType == 'safe' then
    
                TaskStandStill(player, -1)  
                FreezeEntityPosition(player,true)

                local res = exports.gtp_safecracking:StartSafeCrackingMiniGame(6) -- I use gtp_safecracking, you can change it to yours.

                if res then 
                    TriggerServerEvent("tp_banks:server:onBankRobberyVaultReward", RobberyData.RobberyBankName, actionIndex)

                    -- If success, we don't want the player to loot the same vault, we block it.
                    Config.Robberies[RobberyData.RobberyBankName][actionIndex].isLooted = true
                else
                    TriggerServerEvent("tp_libs:sendNotification", nil, Locales['ROBBERY_VAULT_ATTEMPT_FAILED'], 'error')					
                end

                Wait(1000)
                RobberyData.PerformingAction = false

                TaskStandStill(player, 1)  
                ClearPedSecondaryTask(player)
                RemoveAnimDict("script_proc@rustling@olar@player_picklock")
                FreezeEntityPosition(player,false)		

            end
    
        else
            TriggerServerEvent("tp_libs:sendNotification", nil, string.format(Locales['ROBBERY_NOT_ENOUGH_ITEM_QUANTITY'], data.RequiredItem.label), 'error')
        end

    end, { item = data.RequiredItem.name, remove = data.RequiredItem.remove } )
end


-----------------------------------------------------------
--[[ Threads  ]]--
-----------------------------------------------------------

-- The following thread is used for lockpicking, to perform animations when isLockpicking active.
Citizen.CreateThread(function()

	while true do
		Citizen.Wait(1000)

		if GetRobberyData().PerformingAction then

			local playerPed = PlayerPedId()

			if not IsEntityPlayingAnim(playerPed, "script_proc@rustling@olar@player_picklock", "base", 3) then

				local waiting = 0

				RequestAnimDict("script_proc@rustling@olar@player_picklock")

				while not HasAnimDictLoaded("script_proc@rustling@olar@player_picklock") do
					waiting = waiting + 100
					Citizen.Wait(10)
					if waiting > 5000 then
						break
					end
				end

				Wait(100)
				TaskPlayAnim(playerPed, 'script_proc@rustling@olar@player_picklock', 'base', 8.0, 8.0, 120000, 31, 0, true, 0, false, 0, false)
			end 
		end

	end

end)

if Config.DoorSystemSetDoorStates then

    Citizen.CreateThread(function()

        local DoorHashesList = GetDoorHashesList() -- tp-client_doorhashes.lua

        for door, state in pairs(DoorHashesList) do

            if not IsDoorRegisteredWithSystem(door) then 
                Citizen.InvokeNative(0xD99229FE93B46286, door, 1, 1, 0, 0, 0, 0)  
            end

            DoorSystemSetDoorState(door, state)

        end

    end)

end