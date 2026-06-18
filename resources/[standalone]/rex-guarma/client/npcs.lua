local spawnedPeds = {}
lib.locale()

CreateThread(function()
    while true do
        Wait(1000)
        local playerCoords = GetEntityCoords(PlayerPedId())

        for k, v in pairs(Config.PortLocations or {}) do
            local dist = #(playerCoords - v.npccoords.xyz)

            if dist < Config.DistanceSpawn then
                if not spawnedPeds[k] then
                    spawnedPeds[k] = { spawnedPed = NearPed(v.npcmodel, v.npccoords, v.currentport) }
                end
            elseif spawnedPeds[k] and dist > Config.DistanceSpawn + 10 then
                if Config.FadeIn then
                    for i = 255, 0, -51 do
                        Wait(50)
                        SetEntityAlpha(spawnedPeds[k].spawnedPed, i, false)
                    end
                end
                DeletePed(spawnedPeds[k].spawnedPed)
                spawnedPeds[k] = nil
            end
        end
    end
end)

function NearPed(model, coords, currentport)
    RequestModel(model)
    while not HasModelLoaded(model) do Wait(10) end

    local ped = CreatePed(model, coords.x, coords.y, coords.z - 1.0, coords.w, false, true)
    SetEntityAlpha(ped, 0, false)
    Citizen.InvokeNative(0x283978A15512B2FE, ped, true)
    FreezeEntityPosition(ped, true)
    SetEntityInvincible(ped, true)
    SetBlockingOfNonTemporaryEvents(ped, true)

    if Config.FadeIn then
        for i = 0, 255, 51 do
            Wait(50)
            SetEntityAlpha(ped, i, false)
        end
    end

    exports.ox_target:addLocalEntity(ped, {
        {
            name = 'guarma_port_npc',
            icon = 'far fa-eye',
            label = locale('cl_lang_14'),
            onSelect = function()
                TriggerEvent('rex-guarma:client:mainmenu', currentport)
            end,
            distance = 3.0
        }
    })

    return ped
end

AddEventHandler('onResourceStop', function(resource)
    if resource ~= GetCurrentResourceName() then return end
    for _, v in pairs(spawnedPeds) do
        if DoesEntityExist(v.spawnedPed) then
            DeletePed(v.spawnedPed)
        end
    end
end)
