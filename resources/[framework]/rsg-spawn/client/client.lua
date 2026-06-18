local RSGCore = exports['rsg-core']:GetCoreObject()
lib.locale()

local CREATOR_ROOM_CENTER = vector3(-562.91, -3776.25, 237.63)
local CREATOR_ROOM_RADIUS = 30.0

local function shouldUseFallbackSpawn(position)
    if type(position) ~= 'table' or position.x == nil or position.y == nil or position.z == nil then
        return true
    end

    local pos = vector3(position.x + 0.0, position.y + 0.0, position.z + 0.0)
    return #(pos - CREATOR_ROOM_CENTER) <= CREATOR_ROOM_RADIUS
end

RegisterNetEvent('rsg-spawn:client:setupSpawnUI', function(cData, new)
    if new == false then
        TriggerEvent('rsg-spawn:client:existingplayer')
        exports.weathersync:setSyncEnabled(true)
    else
        TriggerEvent('rsg-spawn:client:newplayer')
    end
end)

RegisterNetEvent('rsg-spawn:client:existingplayer', function()
    local PlayerData = RSGCore.Functions.GetPlayerData()
    local isJailed = PlayerData.metadata["injail"]
    local firstname = PlayerData.charinfo.firstname
    local lastname = PlayerData.charinfo.lastname
    local citizenid = PlayerData.citizenid
    local randomIndex = math.random(1, #Config.RandomTips)
    local randomTip = Config.RandomTips[randomIndex]
    Citizen.InvokeNative(0x1E5B70E53DB661E5, 1122662550, 347053089, 0, firstname .. ' ' .. lastname,
        locale('cl_lang_1') .. citizenid, locale('cl_lang_2') .. ' ' .. randomTip)
    Wait(10000)

    DoScreenFadeOut(1000)
    exports['rsg-appearance']:ApplySkin()

    -- set player health
    local currentHealth = PlayerData.metadata["health"]
    local playerPed = PlayerPedId()
    local spawnCoords = PlayerData.position
    if shouldUseFallbackSpawn(spawnCoords) then
        spawnCoords = Config.SpawnLocation.coords
    end
    SetEntityHealth(playerPed, currentHealth)
    SetEntityCoords(playerPed, spawnCoords.x, spawnCoords.y, spawnCoords.z)
    SetEntityHeading(playerPed, spawnCoords.w or 0.0)
    FreezeEntityPosition(playerPed, false)
    SetEntityVisible(playerPed, true)

    if Config.AutoDualWield then
        Wait(2000)
        TriggerEvent('rsg-weapons:client:AutoDualWield')
    end

    ShutdownLoadingScreen()
    DoScreenFadeIn(1000)
    TriggerServerEvent('RSGCore:Server:OnPlayerLoaded')
    TriggerEvent('RSGCore:Client:OnPlayerLoaded')
end)

local function OpenNUI()
    SetNuiFocus(true, true)
    SendNUIMessage({
        type = "OPEN_SPAWN_MENU",
        locations = Config.SpawnLocations
    })
end

local function SpawnChar(coords)
    local PlayerData = RSGCore.Functions.GetPlayerData()
    local firstname = PlayerData.charinfo.firstname
    local lastname = PlayerData.charinfo.lastname
    local citizenid = PlayerData.citizenid
    local randomIndex = math.random(1, #Config.RandomTips)
    local randomTip = Config.RandomTips[randomIndex]
    Citizen.InvokeNative(0x1E5B70E53DB661E5, 1122662550, 347053089, 0, firstname .. ' ' .. lastname,
        locale('cl_lang_1') .. citizenid, locale('cl_lang_2') .. ' ' .. randomTip)
    Wait(10000)
    DoScreenFadeOut(1000)

    exports['rsg-appearance']:ApplySkin()
    local ped = PlayerPedId()

    SetEntityCoordsNoOffset(ped, coords, true, true, true)
    SetEntityHeading(ped, coords.w)
    FreezeEntityPosition(ped, false)
    FreezeEntityPosition(ped, false)
    SetEntityVisible(ped, true)
    if Config.AutoDualWield then
        Wait(2000)
        TriggerEvent('rsg-weapons:client:AutoDualWield')
    end
    ShutdownLoadingScreen()
    ExecuteCommand('revive')
    DoScreenFadeIn(1000)
    TriggerServerEvent('RSGCore:Server:OnPlayerLoaded')
    TriggerEvent('RSGCore:Client:OnPlayerLoaded')
end

RegisterNUICallback('spawnSelected', function(data, cb)
    SetNuiFocus(false, false)
    SendNUIMessage({ type = "CLOSE_MENU" })

    local chosenId = data.locationId

    for _, loc in pairs(Config.SpawnLocations) do
        if loc.id == chosenId then
            SpawnChar(loc.coords)
            break
        end
    end

    cb('ok')
end)


RegisterNetEvent('rsg-spawn:client:newplayer', function()
    if not Config.SelectLocations then
        SpawnChar(Config.SpawnLocation.coords)
    else
        OpenNUI()
    end
end)
