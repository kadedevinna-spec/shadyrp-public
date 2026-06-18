local RSGCore = exports['rsg-core']:GetCoreObject()
lib.locale()

-------------------------------------
-- blips
-------------------------------------
Citizen.CreateThread(function()
    for _, v in pairs(Config.PortLocations or {}) do  
        local blip = BlipAddForCoords(1664425300, v.coords)
        SetBlipSprite(blip, joaat(Config.Blip.blipSprite), true)
        SetBlipScale(blip, Config.Blip.blipScale)
        SetBlipName(blip, Config.Blip.blipName)
    end
end)

-------------------------------------
-- main menu
-------------------------------------
RegisterNetEvent('rex-guarma:client:mainmenu', function(currentport)
    local options = {
        {
            title = locale('cl_lang_1'),
            icon = 'fa-solid fa-ticket',
            onSelect = function()
                TriggerEvent('rex-guarma:client:buyticket')
            end,
        }
    }

    if currentport == 'stdenis' then
        table.insert(options, {
            title = locale('cl_lang_11'),
            icon = 'fa-solid fa-ferry',
            onSelect = function()
                TriggerServerEvent('rex-guarma:server:requestTravel', 'guarma')
            end
        })
        lib.registerContext({ id = 'guarma_main_menu', title = 'St Denis Port Menu', options = options })
    else
        table.insert(options, {
            title = locale('cl_lang_13'),
            icon = 'fa-solid fa-ferry',
            onSelect = function()
                TriggerServerEvent('rex-guarma:server:requestTravel', 'stdenis')
            end
        })
        lib.registerContext({ id = 'guarma_main_menu', title = locale('cl_lang_12'), options = options })
    end

    lib.showContext('guarma_main_menu')
end)
-------------------------------------
-- buy ticket
-------------------------------------
RegisterNetEvent('rex-guarma:client:buyticket', function()
    local input = lib.inputDialog(locale('cl_lang_1'), {
        {
            label = locale('cl_lang_2'),
            description = locale('cl_lang_3')..Config.TicketCost,
            type = 'number',
            min = 1,
            max = 10,
            required = true,
            icon = 'fa-solid fa-hashtag'
        },
    })

    if not input then return end
    TriggerServerEvent('rex-guarma:server:buyticket', input[1])
end)

-------------------------------------
-- perform travel
-------------------------------------
RegisterNetEvent('rex-guarma:client:performTravel', function(destination, token)
    if not token then return end -- prevent manual trigger

    DoScreenFadeOut(1000)
    Wait(1500)

    if destination == 'guarma' then
        Citizen.InvokeNative(0x1E5B70E53DB661E5, 0, 0, 0, locale('cl_lang_4'), locale('cl_lang_5'), locale('cl_lang_6'))
        Wait(3000)
        SetCinematicModeActive(true)
        Citizen.InvokeNative(0x74E2261D2A66849A, 1)
        Citizen.InvokeNative(0xA657EC9DBC6CC900, 1935063277)
        Citizen.InvokeNative(0xE8770EE02AEE45C2, 1)
        Citizen.InvokeNative(0x203BEFFDBE12E96A, cache.ped, 1268.4954, -6853.771, 43.318477 -1, 241.44442)
        Wait(2000)
        DoScreenFadeIn(2000)
        Wait(15000)
        SetCinematicModeActive(false)
    else -- stdenis
        Citizen.InvokeNative(0x1E5B70E53DB661E5, 0, 0, 0, locale('cl_lang_7'), locale('cl_lang_8'), locale('cl_lang_9'))
        Wait(3000)
        Citizen.InvokeNative(0x74E2261D2A66849A, 0)
        Citizen.InvokeNative(0xA657EC9DBC6CC900, -1868977180)
        Citizen.InvokeNative(0xE8770EE02AEE45C2, 0)
        Citizen.InvokeNative(0x203BEFFDBE12E96A, cache.ped, 2663.2485, -1544.214, 45.969753 -1, 266.12268)
        Wait(2000)
        DoScreenFadeIn(2000)
        SetCinematicModeActive(false)
    end

    ShutdownLoadingScreen()
end)

-------------------------------------
-- guarma world toggle
-------------------------------------
function SetGuarmaWorldhorizonActive(toggle) Citizen.InvokeNative(0x74E2261D2A66849A, toggle) end
function SetWorldWaterType(waterType) Citizen.InvokeNative(0xE8770EE02AEE45C2, waterType) end
function SetWorldMapType(mapType) Citizen.InvokeNative(0xA657EC9DBC6CC900, mapType) end
function IsInGuarma()
    local x, y, z = table.unpack(GetEntityCoords(cache.ped))
    return x >= 0 and y <= -4096
end

local GuarmaMode = false
CreateThread(function()
    while true do
        Wait(1000)
        if IsInGuarma() then
            if not GuarmaMode then
                SetGuarmaWorldhorizonActive(true)
                SetWorldWaterType(1)
                SetWorldMapType(1935063277) -- guarma hash
                GuarmaMode = true
            end
        else
            if GuarmaMode then
                SetGuarmaWorldhorizonActive(false)
                SetWorldWaterType(0)
                SetWorldMapType(-1868977180) -- world hash
                GuarmaMode = false
            end
        end
    end
end)
