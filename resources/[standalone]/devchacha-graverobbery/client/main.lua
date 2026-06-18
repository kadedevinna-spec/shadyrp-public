local RSGCore = exports['rsg-core']:GetCoreObject()
lib.locale()

local RobbedGraves = {}
local createdDirtPiles = {}
local shovelObject = nil
local isDigging = false
local isPraying = false

local function LoadAnimDict(dict)
    RequestAnimDict(dict)
    local timeout = 0
    while not HasAnimDictLoaded(dict) do
        Wait(100)
        timeout = timeout + 1
        if timeout > 50 then return false end
    end
    return true
end

local function LoadModel(model)
    local hash = type(model) == 'string' and GetHashKey(model) or model
    RequestModel(hash)
    local timeout = 0
    while not HasModelLoaded(hash) do
        Wait(10)
        timeout = timeout + 1
        if timeout > 100 then return nil end
    end
    return hash
end

local function AttachShovel(ped)
    local cfg = Config.Digging
    local hash = LoadModel(cfg.ShovelModel)
    if not hash then return nil end

    local coords = GetEntityCoords(ped)
    local boneIndex = GetEntityBoneIndexByName(ped, cfg.AttachBone)

    shovelObject = CreateObject(hash, coords, true, true, true)
    SetCurrentPedWeapon(ped, `WEAPON_UNARMED`, true)

    AttachEntityToEntity(
        shovelObject, ped, boneIndex,
        cfg.AttachOffset.x, cfg.AttachOffset.y, cfg.AttachOffset.z,
        cfg.AttachRotation.x, cfg.AttachRotation.y, cfg.AttachRotation.z,
        true, true, false, true, 1, true
    )
    return shovelObject
end

local function DetachShovel()
    if shovelObject and DoesEntityExist(shovelObject) then
        DeleteObject(shovelObject)
    end
    shovelObject = nil
end

local function CanInteractWithGrave(entity)
    if isDigging then return false end
    if isPraying then return false end
    if RobbedGraves[entity] then return false end
    return true
end

local function CanPrayAtGrave(entity)
    if isDigging then return false end
    if isPraying then return false end
    return true
end

local function DoSkillCheck()
    if not Config.SkillCheck or not Config.SkillCheck.Enabled then
        return true
    end
    return lib.skillCheck(Config.SkillCheck.Difficulty, Config.SkillCheck.Keys)
end

local function StartDigging(entity)
    if isDigging then return end
    if RobbedGraves[entity] then
        lib.notify({ type = 'error', description = locale('cooldown') })
        return
    end

    if Config.NightOnly then
        local hour = GetClockHours()
        if hour >= 5 and hour < 22 then
            lib.notify({ type = 'error', description = locale('night_only') })
            return
        end
    end

    if Config.RequiredItem then
        local hasItem = RSGCore.Functions.HasItem(Config.RequiredItem, 1)
        if not hasItem then
            lib.notify({ type = 'error', description = locale('need_shovel') })
            return
        end
    end

    local graveCoords = GetEntityCoords(entity)
    local cooldownKey = string.format("%.0f_%.0f_%.0f", graveCoords.x, graveCoords.y, graveCoords.z)

    local onCooldown = lib.callback.await('devchacha-graverobbery:server:CheckCooldown', false, cooldownKey)
    if onCooldown then
        lib.notify({ type = 'error', description = locale('cooldown') })
        return
    end

    if not DoSkillCheck() then
        lib.notify({ type = 'error', description = locale('skill_failed') })
        return
    end

    isDigging = true
    local ped = cache.ped
    local cfg = Config.Digging

    if not LoadAnimDict(cfg.AnimDict) then
        isDigging = false
        return
    end

    AttachShovel(ped)
    FreezeEntityPosition(ped, true)
    TaskPlayAnim(ped, cfg.AnimDict, cfg.AnimName, 3.0, 3.0, -1, 1, 0, false, false, false)

    local success = lib.progressCircle({
        duration = cfg.Duration,
        label = locale('digging'),
        useWhileDead = false,
        canCancel = true,
        disable = {
            move = true,
            combat = true,
            car = true,
            mouse = false,
        },
        anim = {
            dict = cfg.AnimDict,
            clip = cfg.AnimName,
            flag = 1,
        },
    })

    FreezeEntityPosition(ped, false)
    ClearPedTasks(ped)
    DetachShovel()

    if not success then
        isDigging = false
        lib.notify({ type = 'warning', description = locale('cancelled') })
        return
    end

    RobbedGraves[entity] = true

    if Config.DirtPile and Config.DirtPile.Enabled then
        local dirtModel = Config.DirtPile.Model
        RequestModel(dirtModel)
        while not HasModelLoaded(dirtModel) do
            Wait(1)
        end

        local playerCoords = GetEntityCoords(ped)
        local forwardVector = GetEntityForwardVector(ped)
        local offsetFwd = Config.DirtPile.OffsetForward or 0.6
        local offsetZ = Config.DirtPile.OffsetZ or -1.0

        local objX = playerCoords.x + forwardVector.x * offsetFwd
        local objY = playerCoords.y + forwardVector.y * offsetFwd
        local objZ = playerCoords.z + offsetZ

        local dirtPile = CreateObject(GetHashKey(dirtModel), objX, objY, objZ, true, true, false)
        table.insert(createdDirtPiles, dirtPile)
        SetModelAsNoLongerNeeded(GetHashKey(dirtModel))
    end

    TriggerServerEvent('devchacha-graverobbery:server:RobGrave', cooldownKey)

    local roll = math.random(100)
    if roll <= Config.Police.AlertChance then
        local pos = GetEntityCoords(ped)
        local pedHandle, nearPed = FindFirstPed()
        local snitched = false
        if pedHandle ~= -1 then
            repeat
                if not IsPedAPlayer(nearPed) and not IsPedDeadOrDying(nearPed) then
                    local dist = #(GetEntityCoords(nearPed) - pos)
                    if dist < Config.Police.AlertRadius then
                        snitched = true
                        break
                    end
                end
                local found
                found, nearPed = FindNextPed(pedHandle)
            until not found
            EndFindPed(pedHandle)
        end

        if snitched then
            lib.notify({ type = 'warning', description = locale('someone_saw'), duration = 8000 })
            TriggerServerEvent('devchacha-graverobbery:server:AlertPolice', graveCoords)
        end
    end

    isDigging = false
end

local function StartPraying(entity)
    if isPraying or isDigging then return end

    isPraying = true
    local ped = cache.ped

    local animData = Config.PrayAnim[math.random(#Config.PrayAnim)]
    local dict = animData[1]
    local clip = animData[2]

    if not LoadAnimDict(dict) then
        isPraying = false
        return
    end

    lib.notify({ type = 'info', description = locale('praying_start') })
    TaskPlayAnim(ped, dict, clip, 3.0, 3.0, -1, 1, 0, false, false, false)
    lib.showTextUI(locale('praying_stop_hint'), { position = 'left-center', icon = 'pray' })

    CreateThread(function()
        while isPraying do
            Wait(0)
            if IsControlJustPressed(0, 0x156F7119) or IsControlJustPressed(0, 0xDE794E3E) then
                break
            end
            if not IsEntityPlayingAnim(ped, dict, clip, 3) then
                break
            end
        end

        ClearPedTasks(ped)
        lib.hideTextUI()
        isPraying = false
    end)
end

CreateThread(function()
    exports.ox_target:addModel(Config.GraveModels, {
        {
            label = locale('rob_grave'),
            icon = 'fas fa-skull-crossbones',
            distance = 2.5,
            canInteract = function(entity)
                return CanInteractWithGrave(entity)
            end,
            onSelect = function(data)
                StartDigging(data.entity)
            end
        },
        {
            label = locale('pray_grave'),
            icon = 'fas fa-hands-praying',
            distance = 2.5,
            canInteract = function(entity)
                return CanPrayAtGrave(entity)
            end,
            onSelect = function(data)
                StartPraying(data.entity)
            end
        }
    })

    if Config.Debug then
        print('[GraveRobbery] ox_target registered.')
    end
end)

RegisterNetEvent('devchacha-graverobbery:client:policeAlert', function(coords)
    lib.notify({
        title = locale('police_alert_title'),
        description = locale('police_alert_msg'),
        type = 'error',
        icon = 'skull',
        duration = 10000
    })
    PlaySoundFrontend("Core_Fill_Up", "Consumption_Sounds", true, 0)

    if coords then
        local blip = Citizen.InvokeNative(0x554D9D53F696D002, 1664425300, coords.x, coords.y, coords.z)
        Citizen.InvokeNative(0x74F74D3207ED525C, blip, 1702671897, true)

        local blipName = CreateVarString(10, 'LITERAL_STRING', locale('police_blip_name'))
        Citizen.InvokeNative(0x9CB1A1623062F402, blip, blipName)

        StartGpsMultiRoute(GetHashKey("COLOR_RED"), true, true)
        AddPointToGpsMultiRoute(coords.x, coords.y, coords.z)
        SetGpsMultiRouteRender(true)

        SetTimeout(Config.Police.BlipDuration * 1000, function()
            if DoesBlipExist(blip) then
                RemoveBlip(blip)
            end
            ClearGpsMultiRoute()
        end)
    end
end)

AddEventHandler('onResourceStop', function(resourceName)
    if GetCurrentResourceName() ~= resourceName then return end
    DetachShovel()
    if isDigging then
        FreezeEntityPosition(cache.ped, false)
        ClearPedTasks(cache.ped)
    end
    for _, obj in ipairs(createdDirtPiles) do
        if DoesEntityExist(obj) then
            DeleteObject(obj)
        end
    end
    createdDirtPiles = {}
    lib.hideTextUI()
end)
