if Config.framework == 'REDEMRP2k23' then
    RegisterNetEvent('redemrp_charselect:client:FinishSelection')
    AddEventHandler('redemrp_charselect:client:FinishSelection', function()
        TriggerEvent("murphy_barber:loadbarberoverlay")
    end)

    RegisterNetEvent('redemrp_respawn:client:Revived')
    AddEventHandler('redemrp_respawn:client:Revived', function()
        TriggerEvent("murphy_barber:loadbarberoverlay")
    end)
end
