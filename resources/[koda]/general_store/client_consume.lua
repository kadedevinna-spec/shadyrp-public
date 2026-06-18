--- Consumable scenes — reads prop / attach / anim from Config.Consumables per item.

local consumeBusy = false

-- ─── Alcohol (RDR2 natives — same as rsg-consume) ────────────────────────────
local alcoholCount  = 0
local drunkFxActive = false
local alcoholThread = false

-- SET_PED_INEBRIATION — controls drunk walk / stumble
local function setPedDrunk(ped, level)
    Citizen.InvokeNative(0x406CCF555B04FAD3, ped, 1, level)
end

local function alcoholCfg()
    return Config.Alcohol or {}
end

local function applyDrunkState(ped)
    local cfg = alcoholCfg()
    setPedDrunk(ped, cfg.drunkWalkLevel or 0.95)
    if not drunkFxActive then
        AnimpostfxPlay(cfg.drunkEffectName or 'PlayerDrunk01', 0, true)
        drunkFxActive = true
    end
end

local function clearDrunkState(ped)
    setPedDrunk(ped, 0.0)
    if drunkFxActive then
        AnimpostfxStop((alcoholCfg().drunkEffectName or 'PlayerDrunk01'))
        drunkFxActive = false
    end
end

local function syncDrunkState()
    local ped = PlayerPedId()
    local threshold = alcoholCfg().drunkThreshold or 50
    if alcoholCount >= threshold then
        applyDrunkState(ped)
    else
        clearDrunkState(ped)
    end
end

local function startAlcoholDecay()
    if alcoholThread then return end
    alcoholThread = true
    CreateThread(function()
        local cfg = alcoholCfg()
        while alcoholCount > 0 do
            syncDrunkState() -- re-apply in case ClearPedTasks / other scripts reset walk
            Wait(cfg.decreaseInterval or 5000)
            alcoholCount = math.max(0, alcoholCount - (cfg.decreaseAmount or 1))
            syncDrunkState()
        end
        clearDrunkState(PlayerPedId())
        alcoholThread = false
    end)
end

local function addAlcohol(amount)
    if not amount or amount == 0 then return end
    local cfg = alcoholCfg()
    alcoholCount = math.min(cfg.maxLevel or 500, math.max(0, alcoholCount + amount))
    syncDrunkState()
    startAlcoholDecay()
end
-- ──────────────────────────────────────────────────────────────────────────────

local function consumablesEnabled()
    return Config.ConsumablesEnabled ~= false
end

local function ped()
    return PlayerPedId()
end

local function isFemale(entity)
    return not IsPedMale(entity)
end

local function resolveConsumable(itemName)
    if type(itemName) ~= 'string' then return nil end
    local key = itemName:lower()
    local row = Config.Consumables and (Config.Consumables[key] or Config.Consumables[itemName])
    if not row then return nil end
    return row, (row.item or key):lower()
end

local function resolveAttach(entity, row)
    if isFemale(entity) and type(row.attachFemale) == 'table' then
        return row.attachFemale
    end
    return row.attach or { bone = 'PH_R_HAND', x = 0.0, y = 0.0, z = 0.0, rx = 0.0, ry = 0.0, rz = 0.0 }
end

local function hashOf(value)
    if type(value) == 'number' then return value end
    if type(value) ~= 'string' or value == '' then return 0 end
    return joaat(value)
end

local function loadAnimDict(dict)
    if not dict or dict == '' then return false end
    RequestAnimDict(dict)
    local deadline = GetGameTimer() + 5000
    while not HasAnimDictLoaded(dict) do
        if GetGameTimer() > deadline then return false end
        Wait(10)
    end
    return true
end

local function playAnimStep(entity, step)
    if not step or not step.dict or not step.clip then return false end
    if not loadAnimDict(step.dict) then return false end
    TaskPlayAnim(entity, step.dict, step.clip, 8.0, -8.0, step.duration or -1, step.flag or 31, 0.0, false, false, false)
    RemoveAnimDict(step.dict)
    return true
end

local function playConfiguredAnim(entity, animCfg)
    if type(animCfg) ~= 'table' then return end

    if type(animCfg.sequence) == 'table' then
        for i, step in ipairs(animCfg.sequence) do
            playAnimStep(entity, step)
            if step.delay and step.delay > 0 then
                Wait(step.delay)
            elseif i < #animCfg.sequence and step.duration and step.duration > 0 then
                Wait(step.duration)
            end
        end
        return
    end

    playAnimStep(entity, animCfg)
end

local function deletePropEntity(obj)
    if not obj or obj == 0 or not DoesEntityExist(obj) then return end
    DetachEntity(obj, true, true)
    SetEntityAsMissionEntity(obj, true, true)
    DeleteObject(obj)
    Wait(0)
    if DoesEntityExist(obj) then DeleteEntity(obj) end
end

-- Detach prop with physics so it falls/rolls naturally (like story mode).
-- Schedules a delayed cleanup after `delayMs` (default 8 s).
local function throwPropPhysics(obj, delayMs)
    if not obj or obj == 0 or not DoesEntityExist(obj) then return end
    DetachEntity(obj, true, false)
    SetEntityAsMissionEntity(obj, false, false)
    -- tiny downward nudge so it doesn't hover if the engine keeps it still
    ApplyForceToEntity(obj, 1, 0.0, 0.0, -0.3, 0, 0, 0, true, true, true, true, false, true)
    local deadline = delayMs or 8000
    CreateThread(function()
        Wait(deadline)
        if DoesEntityExist(obj) then
            SetEntityAsMissionEntity(obj, true, true)
            DeleteObject(obj)
            Wait(0)
            if DoesEntityExist(obj) then DeleteEntity(obj) end
        end
    end)
end

local function attachPropToPed(entity, modelName, attach)
    local hash = hashOf(modelName)
    if hash == 0 then return nil end
    RequestModel(hash, false)
    local deadline = GetGameTimer() + 6000
    while not HasModelLoaded(hash) do
        if GetGameTimer() > deadline then return nil end
        Wait(10)
    end

    local c = GetEntityCoords(entity)
    local obj = CreateObject(hash, c.x, c.y, c.z, true, false, false, false, false)
    if not obj or obj == 0 then return nil end

    local boneName = attach.bone or 'PH_R_HAND'
    local bone = GetEntityBoneIndexByName(entity, boneName)
    if bone == -1 then bone = GetEntityBoneIndexByName(entity, 'SKEL_R_Hand') end

    AttachEntityToEntity(
        obj, entity, bone,
        attach.x or 0.0, attach.y or 0.0, attach.z or 0.0,
        attach.rx or 0.0, attach.ry or 0.0, attach.rz or 0.0,
        true, true, false, true, 1, true
    )
    SetModelAsNoLongerNeeded(hash)
    return obj
end

local function onMountOrVehicle(entity)
    return IsPedOnMount(entity) or IsPedInAnyVehicle(entity, false)
end

-- Runs a TaskItemInteraction or TaskItemInteraction_2 native.
-- Returns true if a native task was started.
local function runNativeInteraction(entity, propEntity, nativeCfg)
    if type(nativeCfg) ~= 'table' then return false end

    if nativeCfg.type == 'interaction' then
        local h = hashOf(nativeCfg.hash)
        if h == 0 then return false end
        -- Pass prop model hash as item hash so the game can reference the right prop shape.
        -- nil / 0 also works (game uses default for that interaction state).
        local itemH = nativeCfg.itemHash and hashOf(nativeCfg.itemHash) or 0
        TaskItemInteraction(entity, itemH, h, true, 0, 0)
        return true
    end

    if nativeCfg.type == 'interaction_2' then
        local itemHash        = nativeCfg.itemHash and hashOf(nativeCfg.itemHash) or 0
        local propBone        = hashOf(nativeCfg.propBone)
        local interactionHash = hashOf(nativeCfg.interactionHash)
        if propBone == 0 or interactionHash == 0 then return false end
        TaskItemInteraction_2(entity, itemHash, propEntity, propBone, interactionHash, 1, 0, nativeCfg.p7 or 0.0)
        return true
    end

    return false
end

local function runConfiguredScene(entity, row)
    local duration   = row.duration or (Config.ConsumeSettings and Config.ConsumeSettings.defaultDuration) or 4800
    local propA, propB = nil, nil
    local useMounted = onMountOrVehicle(entity) and type(row.animMounted) == 'table'

    if row.prop then
        propA = attachPropToPed(entity, row.prop, resolveAttach(entity, row))
    end

    -- Priority 1: `native` field → used on foot AND mounted (replaces both anim and animMounted).
    -- The game handles the animation task; `anim` is kept only as a fallback if native fails.
    if type(row.native) == 'table' then
        local ok = runNativeInteraction(entity, propA, row.native)
        if ok then
            if row.native.duration then duration = row.native.duration end
        else
            -- Native failed (bad hash, etc.) → fall through to manual anim
            if row.anim then playConfiguredAnim(entity, row.anim) end
        end

    -- Priority 2: mounted-specific native fallback (legacy `animMounted` field).
    elseif useMounted then
        if runNativeInteraction(entity, propA, row.animMounted) and row.animMounted.duration then
            duration = row.animMounted.duration
        end

    -- Priority 3: manual prop + TaskPlayAnim (default for non-native items).
    elseif row.anim then
        playConfiguredAnim(entity, row.anim)
    end

    return propA, propB, duration
end

local function applyConsumeEffects(effects)
    if type(effects) ~= 'table' then return end

    local useHud = Config.ConsumeSettings.useHud ~= false
    if useHud then
        if effects.hunger and effects.hunger ~= 0 then
            TriggerEvent('hud:client:UpdateHunger', (LocalPlayer.state.hunger or 0) + effects.hunger)
        end
        if effects.thirst and effects.thirst ~= 0 then
            TriggerEvent('hud:client:UpdateThirst', (LocalPlayer.state.thirst or 0) + effects.thirst)
        end
        if effects.stress and effects.stress ~= 0 then
            TriggerEvent('hud:client:RelieveStress', effects.stress)
        end
    end
    -- alcohol is applied client-side in playConsumableScene (immediate, no server roundtrip)
end

local function playConsumableScene(itemName)
    if consumeBusy or not consumablesEnabled() then return end

    local row, canonical = resolveConsumable(itemName)
    if not row then return end
    if not row.prop and not row.anim and not row.animMounted and not row.native then
        print(('^3[general_store]^0 Consumable %q has no prop/anim/native configured.'):format(canonical))
        return
    end

    consumeBusy = true
    local entity = ped()
    local settings = Config.ConsumeSettings or {}

    if settings.blockInventory ~= false then
        LocalPlayer.state:set('inv_busy', true, true)
    end

    SetCurrentPedWeapon(entity, joaat('WEAPON_UNARMED'), true)

    -- Broadcast anim to nearby players before playing locally
    TriggerServerEvent('general_store:server:broadcastConsumeAnim', canonical)

    local propA, propB, duration = runConfiguredScene(entity, row)
    if not duration or duration <= 0 then
        consumeBusy = false
        deletePropEntity(propA)
        deletePropEntity(propB)
        if settings.blockInventory ~= false then
            LocalPlayer.state:set('inv_busy', false, true)
        end
        return
    end

    Wait(duration)
    ClearPedTasks(entity)

    -- Items with native.throw = true drop the prop with physics (like story mode).
    local usedNative = type(row.native) == 'table'
    local shouldThrow = usedNative and row.native.throw == true
    if shouldThrow then
        throwPropPhysics(propA)
    else
        deletePropEntity(propA)
    end
    deletePropEntity(propB)

    -- Apply alcohol immediately after drink (don't wait for server ack)
    if row.effects and row.effects.alcohol and row.effects.alcohol ~= 0 then
        addAlcohol(row.effects.alcohol)
    end

    -- Optional notify from config: notify = { title, text, type?, duration? }
    local notifyCfg = row.notify
    if type(notifyCfg) == 'table' then
        SendNUIMessage({
            action    = 'toast',
            toastType = notifyCfg.type or 'inform',
            title     = notifyCfg.title or 'Item used',
            msg       = notifyCfg.text or '',
            duration  = notifyCfg.duration or 3500,
        })
    end

    TriggerServerEvent('general_store:server:consumeItem', canonical)

    if settings.blockInventory ~= false then
        LocalPlayer.state:set('inv_busy', false, true)
    end
    consumeBusy = false
end

RegisterNetEvent('general_store:client:useConsumable', function(itemName)
    playConsumableScene(itemName)
end)

-- Plays the anim + prop on another player's ped (no effects/item removal — cosmetic only).
RegisterNetEvent('general_store:client:consumeAnimRemote', function(serverId, itemName)
    if serverId == GetPlayerServerId(PlayerId()) then return end

    local row = resolveConsumable(itemName)
    if not row then return end
    if not row.prop and not row.anim and not row.animMounted and not row.native then return end

    local targetPlayer = GetPlayerFromServerId(serverId)
    if not targetPlayer or targetPlayer == -1 then return end

    local targetPed = GetPlayerPed(targetPlayer)
    if not targetPed or targetPed == 0 or not DoesEntityExist(targetPed) then return end

    local duration = row.duration or (Config.ConsumeSettings and Config.ConsumeSettings.defaultDuration) or 4800

    CreateThread(function()
        local propObj = nil
        if row.prop then
            propObj = attachPropToPed(targetPed, row.prop, resolveAttach(targetPed, row))
        end

        -- Only use manual anim for remote players (natives are local engine tasks)
        if row.anim then
            playConfiguredAnim(targetPed, row.anim)
        end

        Wait(duration)
        ClearPedTasks(targetPed)

        local shouldThrow = type(row.native) == 'table' and row.native.throw == true
        if shouldThrow then
            throwPropPhysics(propObj)
        else
            deletePropEntity(propObj)
        end
    end)
end)

RegisterNetEvent('general_store:client:applyConsumeEffects', function(effects)
    applyConsumeEffects(effects)
end)

exports('PlayConsumableScene', playConsumableScene)
