if Config.framework == 'rsg-core' then
    RegisterNetEvent('RSGCore:Client:OnPlayerLoaded')
    AddEventHandler('RSGCore:Client:OnPlayerLoaded', function()
        Wait(3000)
        TriggerEvent("murphy_barber:loadbarberoverlay")
    end)

    RegisterNetEvent('rsg-medic:client:playerRevive')
    AddEventHandler('rsg-medic:client:playerRevive', function()
        Wait(3000)
        TriggerEvent("murphy_barber:loadbarberoverlay")
    end)

    RegisterNetEvent('rsg-medic:client:adminRevive')
    AddEventHandler('rsg-medic:client:adminRevive', function()
        Wait(3000)
        TriggerEvent("murphy_barber:loadbarberoverlay")
    end)
end
