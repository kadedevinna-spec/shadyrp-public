if Config.framework == 'vorp' then
    if not Config.murphy_creator then
        RegisterNetEvent('vorp:SelectedCharacter')
        AddEventHandler('vorp:SelectedCharacter', function()
            Wait(3000)
            TriggerEvent("murphy_barber:loadbarberoverlay")
        end)

        RegisterNetEvent('vorp_core:Client:OnPlayerRevive')
        AddEventHandler('vorp_core:Client:OnPlayerRevive', function()
            Wait(3000)
            TriggerEvent("murphy_barber:loadbarberoverlay")
        end)

        RegisterNetEvent('vorp_core:Client:OnPlayerRespawn')
        AddEventHandler('vorp_core:Client:OnPlayerRespawn', function()
            Wait(3000)
            TriggerEvent("murphy_barber:loadbarberoverlay")
        end)
    end
end
