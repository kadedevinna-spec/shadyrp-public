--- Clerk robbery — aim weapon at NPC, NPC surrenders, hands over money, police alerted.

local RSGCore = exports['rsg-core']:GetCoreObject()

local function robberyEnabled()
    return Config.Robbery and Config.Robbery.enabled ~= false
end

local cfg = function() return Config.Robbery or {} end

local busyClerks        = {}
local storeCooldownUntil = {}   -- storeId → GetGameTimer() deadline
local surrenderingClerk = nil
local surrenderMode     = nil   -- 'aim' | 'post_robbery'
local activeStoreId    = nil
local holdStart        = nil
local aimLockStoreId    = nil    -- storeId we hold on the server (first aimer wins)
local pendingClaimStore = nil    -- waiting for server claim response
local lastClaimAttempt  = 0
local lastCooldownToast = {}
local aimLostAt         = nil
local holdSavedMs       = nil
local sessionReaction   = nil   -- 'surrender' | 'fight' from server roll
local fightingClerks    = {}    -- ped → storeId
local fightTriggered    = {}    -- ped → true while draw/combat is starting
local clerkFightTrack   = {}    -- ped → { pos, atMs, taskAtMs }
local clerkFightMode    = {}    -- ped → 'shoot' | 'walk' (avoids redundant retask)
local registerLootable  = {}    -- storeId → true
local registerRobBusy   = false

-- Returns true while a ped is in surrender or fight mode — idle anims should pause.
function GS_IsClerkBusy(ped)
    if not ped or ped == 0 then return false end
    if ped == surrenderingClerk then return true end
    if fightingClerks[ped] then return true end
    if fightTriggered[ped] then return true end
    return false
end

function GS_IsRobberyActive()
    return surrenderingClerk ~= nil or next(fightingClerks) ~= nil
end
local registerHold      = { storeId = nil, startMs = nil }

local function formatCooldownRemaining(ms)
    ms = math.max(0, ms or 0)
    local secs = math.ceil(ms / 1000)
    if secs >= 60 then
        return ('%d min'):format(math.ceil(secs / 60))
    end
    return ('%d sec'):format(secs)
end

local function cooldownRemainingMs(storeId)
    local untilMs = storeCooldownUntil[storeId]
    if not untilMs then return 0 end
    local left = untilMs - GetGameTimer()
    if left <= 0 then
        storeCooldownUntil[storeId] = nil
        return 0
    end
    return left
end

local function isStoreOnCooldown(storeId)
    return cooldownRemainingMs(storeId) > 0
end

local function setStoreCooldown(storeId, durationMs)
    if type(storeId) ~= 'string' or not durationMs then return end
    storeCooldownUntil[storeId] = GetGameTimer() + durationMs
end

local function notifyToast(title, msg, toastType, duration)
    SendNUIMessage({
        action    = 'toast',
        toastType = toastType or 'info',
        title     = title or '',
        msg       = msg or '',
        duration  = duration or 5000,
    })
end

local function showCooldownToast(storeId)
    if type(storeId) ~= 'string' or storeId == '' then return end

    local now = GetGameTimer()
    if lastCooldownToast[storeId] and (now - lastCooldownToast[storeId]) < 8000 then return end
    lastCooldownToast[storeId] = now

    local remaining = cooldownRemainingMs(storeId)
    local msg = remaining > 0
        and ('This store was already robbed. Wait %s.'):format(formatCooldownRemaining(remaining))
        or  'This store was already robbed recently.'

    notifyToast('Store Robbed', msg, 'error', 5000)
end

local function isClerkFighting(clerk)
    return clerk ~= nil and fightingClerks[clerk] ~= nil
end

-- Requests network ownership of a ped before issuing tasks.
-- Returns true if we have control (or the ped is not networked).
local function requestPedControl(ped)
    if not ped or not DoesEntityExist(ped) then return false end
    if not NetworkGetEntityIsNetworked(ped) then return true end
    if NetworkHasControlOfEntity(ped) then return true end
    -- Keep hammering the request — prevents the owner from silently reclaiming
    local deadline = GetGameTimer() + 3000
    while not NetworkHasControlOfEntity(ped) and GetGameTimer() < deadline do
        NetworkRequestControlOfEntity(ped)
        Wait(50)
    end
    return NetworkHasControlOfEntity(ped)
end

local function isAnyClerkFighting()
    for _ in pairs(fightingClerks) do return true end
    return false
end

local function releaseAimLock()
    if aimLockStoreId then
        TriggerServerEvent('general_store:server:releaseRobberyAim', aimLockStoreId)
        aimLockStoreId = nil
    end
    pendingClaimStore = nil
    if not isAnyClerkFighting() then
        sessionReaction = nil
    end
end

local function hasAimLock(storeId)
    return aimLockStoreId ~= nil and aimLockStoreId == storeId
end

local function requestAimLock(storeId)
    if hasAimLock(storeId) or pendingClaimStore == storeId then return end
    if GetGameTimer() - lastClaimAttempt < 400 then return end

    lastClaimAttempt = GetGameTimer()
    pendingClaimStore = storeId
    RSGCore.Functions.TriggerCallback('general_store:server:claimRobberyAim', function(ok, reason)
        if pendingClaimStore ~= storeId then return end
        pendingClaimStore = nil
        if ok then
            aimLockStoreId = storeId
            sessionReaction = (reason == 'fight') and 'fight' or 'surrender'
        elseif reason == 'cooldown' then
            showCooldownToast(storeId)
        end
    end, storeId)
end

local function isRobberyBusy()
    for _ in pairs(busyClerks) do return true end
    return false
end

local function releaseDist()
    return cfg().surrenderReleaseDistance or 10.0
end

local function aimReleaseDelay()
    return cfg().surrenderAimReleaseDelay or 3000
end

local function playerDistToClerk(clerk)
    if not clerk or not DoesEntityExist(clerk) then return 999.0 end
    return #(GetEntityCoords(PlayerPedId()) - GetEntityCoords(clerk))
end

local function playerInRobberyRange(clerk)
    return playerDistToClerk(clerk) <= (cfg().maxAimDistance or 6.0)
end

local function isPlayerArmed(playerPed)
    local _, weapon = GetCurrentPedWeapon(playerPed, true)
    return weapon ~= 0 and weapon ~= joaat('WEAPON_UNARMED')
end

local function canReceivePayout(clerk, storeId)
    if not hasAimLock(storeId) then return false end
    if not isPlayerArmed(PlayerPedId()) then return false end
    return playerInRobberyRange(clerk)
end

function GS_IsRobberyActive()
    if registerRobBusy then return true end
    if isAnyClerkFighting() then return true end
    if not aimLockStoreId then return false end
    if isRobberyBusy() then return true end
    if surrenderingClerk and DoesEntityExist(surrenderingClerk) then
        return playerDistToClerk(surrenderingClerk) <= releaseDist()
    end
    return false
end

local function isLocalPlayerDead()
    local player = PlayerPedId()
    return IsEntityDead(player) or IsPedDeadOrDying(player, true)
end

-- ─── Helpers (used by register loot block below AND by main robbery) ──────────
local function loadAnimDict(dict)
    if not dict or dict == '' then return false end
    if HasAnimDictLoaded(dict) then return true end
    RequestAnimDict(dict)
    local deadline = GetGameTimer() + 5000
    while not HasAnimDictLoaded(dict) do
        if GetGameTimer() > deadline then return false end
        Wait(10)
    end
    return true
end

local function loadModel(hash)
    if HasModelLoaded(hash) then return true end
    RequestModel(hash, false)
    local deadline = GetGameTimer() + 5000
    while not HasModelLoaded(hash) do
        if GetGameTimer() > deadline then return false end
        Wait(10)
    end
    return true
end

local function hashOf(value)
    if type(value) == 'number' then return value end
    if type(value) ~= 'string' or value == '' then return 0 end
    return joaat(value)
end

local function animLengthMs(dict, clip)
    local ok, dur = pcall(GetAnimDuration, dict, clip)
    if ok and type(dur) == 'number' and dur > 0 then
        return math.floor(dur * 1000)
    end
    return nil
end

local function registerDrawDist()
    return cfg().registerDrawDistance or 1.35
end

local function registerInteractDist()
    return cfg().registerInteractDistance or 1.20
end

local function registerRobKey()
    return cfg().registerRobKey or Config.OpenKey or 0x760A9C6F
end

local function registerHoldDurationMs()
    local ms = tonumber(cfg().registerHoldDurationMs)
    if not ms or ms < 250 then return 1400 end
    return ms
end

local function resetRegisterHold()
    registerHold.storeId = nil
    registerHold.startMs = nil
end

local function canLootRegister(storeId)
    if not storeId or not registerLootable[storeId] then return false end
    if registerRobBusy or isStoreOnCooldown(storeId) then return false end
    if isLocalPlayerDead() then return false end
    return true
end

local function markRegisterLootable(storeId)
    if not storeId then return end
    if isStoreOnCooldown(storeId) then return end
    registerLootable[storeId] = true
end

local function headingToward(from, to)
    return math.deg(math.atan(-(to.x - from.x), to.y - from.y))
end

local function playRegisterRobAnim(storeId)
    local reg = GS_GetCashRegister and GS_GetCashRegister(storeId)
    local a = cfg().registerAnim or {}
    if not reg or not loadAnimDict(a.dict) then return false end

    local ped = PlayerPedId()
    local pedPos = GetEntityCoords(ped)
    local regPos = vector3(reg.x, reg.y, reg.z)
    local duration = a.duration or animLengthMs(a.dict, a.clip) or 3200
    local spawnAt = math.floor(duration * (a.propSpawnPct or 0.42))

    SetEntityHeading(ped, headingToward(pedPos, regPos))
    Wait(0)

    TaskPlayAnim(ped, a.dict, a.clip, 8.0, -4.0, duration, a.flag or 0, 0.0, false, false, false)

    -- Spawn money prop mid-anim, attach to left thumb (SKEL_L_Finger00)
    local propHash = hashOf(cfg().moneyProp or 'p_worm_moneystack01x')
    local propEnt = nil
    if propHash ~= 0 and loadModel(propHash) then
        Wait(spawnAt)
        local cc = GetEntityCoords(ped)
        propEnt = CreateObject(propHash, cc.x, cc.y, cc.z + 0.5, true, false, false, false, false)
        if propEnt and propEnt ~= 0 then
            SetEntityCollision(propEnt, false, false)
            local att = cfg().registerPropAttach or {}
            local bone = GetEntityBoneIndexByName(ped, 'SKEL_L_Finger00')
            if bone == -1 then bone = GetEntityBoneIndexByName(ped, 'PH_L_HAND') end
            if bone == -1 then bone = 0 end
            AttachEntityToEntity(
                propEnt, ped, bone,
                att.x or 0.0, att.y or 0.0, att.z or 0.0,
                att.rx or 0.0, att.ry or 0.0, att.rz or 0.0,
                true, true, false, true, 1, true
            )
        end
        SetModelAsNoLongerNeeded(propHash)
        Wait(math.max(0, duration - spawnAt))
    else
        Wait(duration)
    end

    if propEnt and DoesEntityExist(propEnt) then
        DetachEntity(propEnt, true, true)
        SetEntityAsMissionEntity(propEnt, true, true)
        DeleteObject(propEnt)
    end

    ClearPedTasks(ped)
    return true
end

local function runRegisterRobbery(storeId)
    if not canLootRegister(storeId) then return end
    registerRobBusy = true
    registerLootable[storeId] = nil  -- consume immediately, prevent double trigger

    CreateThread(function()
        playRegisterRobAnim(storeId)
        TriggerServerEvent('general_store:server:robRegister', storeId)
        registerRobBusy = false
    end)
end

local function tickRegisterHold(storeId, canRob)
    if not canRob then
        resetRegisterHold()
        return 0.0
    end

    local key = registerRobKey()
    if IsControlPressed(0, key) then
        if registerHold.storeId ~= storeId or not registerHold.startMs then
            registerHold.storeId = storeId
            registerHold.startMs = GetGameTimer()
        end

        local elapsed = GetGameTimer() - registerHold.startMs
        local progress = math.min(1.0, elapsed / registerHoldDurationMs())
        if progress >= 1.0 then
            resetRegisterHold()
            runRegisterRobbery(storeId)
            return 1.0
        end
        return progress
    end

    resetRegisterHold()
    return 0.0
end

local function drawRegisterPrompt(storeId, holdProgress)
    local reg = GS_GetCashRegister and GS_GetCashRegister(storeId)
    if not reg then return end
    local loc = Config.Locale or {}
    local title = loc.register_rob_title or 'Cash register'
    local hint = loc.register_rob_hint or 'Hold [G] — Rob the till'
    GS_DrawText3DAtCoords('register_' .. storeId, vector3(reg.x, reg.y, reg.z), reg.w or 0.0, title .. '\n' .. hint, holdProgress or 0.0)
end

-- Camera forward vector from its rotation.
local function camForward()
    local rot = GetGameplayCamRot(2)
    local rz, rx = math.rad(rot.z), math.rad(rot.x)
    local cosX = math.abs(math.cos(rx))
    return vector3(-math.sin(rz) * cosX, math.cos(rz) * cosX, math.sin(rx))
end

-- Robust aim detection for RDR2/RedM: works with BOTH free aim and lock-on.
-- Strategy: player must be aiming (INPUT_AIM held or free-aiming), then we pick
-- the clerk that sits inside the camera's view cone within range.
local function getAimedClerk()
    local playerId  = PlayerId()
    local playerPed = PlayerPedId()

    local aiming = IsPlayerFreeAiming(playerId)
        or IsControlPressed(0, joaat('INPUT_AIM'))
        or IsControlPressed(0, joaat('INPUT_PLAYER_TARGET'))
    if not aiming then return nil end

    -- 1) Direct free-aim hit (when actually free aiming)
    local hit, ent = GetEntityPlayerIsFreeAimingAt(playerId)
    if hit and ent and ent ~= 0 then
        local storeId = GS_FindStoreByPed and GS_FindStoreByPed(ent) or nil
        local isOwned = GS_IsOwnedStoreClient and GS_IsOwnedStoreClient(storeId)
        if storeId and not isOwned and (not GS_IsClerkAlive or GS_IsClerkAlive(ent)) then return ent, storeId end
    end

    -- 2) Cone test against known clerks (covers lock-on / assisted aim)
    local clerks = GS_GetClerks and GS_GetClerks() or {}
    if #clerks == 0 then return nil end

    local cam = GetGameplayCamCoord()
    local fwd = camForward()
    local maxDist = cfg().maxAimDistance or 6.0
    local minDot  = cfg().aimConeDot or 0.93

    local best, bestStore, bestDot = nil, nil, minDot
    for _, c in ipairs(clerks) do
        local isOwned = GS_IsOwnedStoreClient and GS_IsOwnedStoreClient(c.storeId)
        if not isOwned then
            local cp   = GetEntityCoords(c.ped)
            local diff = cp - cam
            local dist = #(diff)
            if dist > 0.1 and dist <= maxDist then
                local dir = diff / dist
                local dot = dir.x * fwd.x + dir.y * fwd.y + dir.z * fwd.z
                if dot > bestDot then
                    best, bestStore, bestDot = c.ped, c.storeId, dot
                end
            end
        end
    end
    if best then return best, bestStore end
    return nil
end

-- ─── Animation pipeline ─────────────────────────────────────────────────────
local function isPlayingSurrender(clerk)
    local a = cfg().surrenderAnim
    if not a then return false end
    return IsEntityPlayingAnim(clerk, a.dict, a.clip, 3)
end

local function playSurrenderLoop(clerk)
    if not clerk or not DoesEntityExist(clerk) then return false end
    if isClerkFighting(clerk) then return false end
    if isPlayingSurrender(clerk) then return true end

    local a = cfg().surrenderAnim
    if not a or not loadAnimDict(a.dict) then return false end
    requestPedControl(clerk)
    FreezeEntityPosition(clerk, false)
    SetBlockingOfNonTemporaryEvents(clerk, true)
    TaskPlayAnim(clerk, a.dict, a.clip, 8.0, -8.0, -1, a.flag or 1, 0.0, false, false, false)
    return true
end

local function playHandoverAndDropProp(clerk)
    local a = cfg().handoverAnim or {}
    if not loadAnimDict(a.dict) then return false end

    -- Use the real clip length so timings scale to the actual animation.
    local realLen   = animLengthMs(a.dict, a.clip)
    local duration  = realLen or a.duration or 4500

    -- Drop point: prefer a fraction of the real clip; fall back to fixed ms.
    local dropPct   = a.dropAtPct or 0.65
    local dropAt    = math.floor(duration * dropPct)
    if not realLen and a.dropAt then dropAt = a.dropAt end

    -- Prop appears a bit before the toss (hand reaching the counter).
    local spawnAt   = math.max(0, dropAt - (a.spawnLeadMs or 1200))

    FreezeEntityPosition(clerk, false)
    ClearPedTasks(clerk)
    TaskPlayAnim(clerk, a.dict, a.clip, 8.0, -8.0, duration, a.flag or 0, 0.0, false, false, false)

    -- Pre-load prop while clerk is still bringing hand toward pocket
    local propHash   = hashOf(cfg().moneyProp or 'p_worm_moneystack01x')
    local propLoaded = propHash ~= 0 and loadModel(propHash)
    local propEnt    = nil

    Wait(spawnAt)

    if propLoaded then
        local cc = GetEntityCoords(clerk)
        propEnt = CreateObject(propHash, cc.x, cc.y, cc.z + 1.0, true, false, false, false, false)
        local att = cfg().moneyPropAttach or {}
        local boneName = att.bone or 'SKEL_R_Finger00'
        local bone = GetEntityBoneIndexByName(clerk, boneName)
        if bone == -1 then bone = GetEntityBoneIndexByName(clerk, 'PH_R_HAND') end
        AttachEntityToEntity(
            propEnt, clerk, bone,
            att.x or 0.08, att.y or -0.02, att.z or 0.015,
            att.rx or 18.0, att.ry or 72.0, att.rz or 22.0,
            true, true, false, true, 1, true
        )
        SetModelAsNoLongerNeeded(propHash)
    end

    Wait(math.max(0, dropAt - spawnAt))

    -- Detach + give it forward velocity so it flies toward the counter (not straight down).
    if propEnt and DoesEntityExist(propEnt) then
        local fwd   = GetEntityForwardVector(clerk)
        local speed = a.tossSpeed or 3.2
        local up    = a.tossUp or 1.4

        DetachEntity(propEnt, true, true)
        SetEntityProofs(propEnt, false, false, false, false, false, false, false, false)
        Citizen.InvokeNative(0xE6E14563B42DA690, propEnt, true) -- ActivatePhysics
        SetEntityVelocity(propEnt, fwd.x * speed, fwd.y * speed, up)
        -- Slight tumble for realism
        pcall(SetEntityAngularVelocity, propEnt, 0.0, 0.0, 2.0)

        CreateThread(function()
            Wait(20000)
            if DoesEntityExist(propEnt) then
                SetEntityAsMissionEntity(propEnt, true, true)
                DeleteObject(propEnt)
            end
        end)
    end

    -- Finish the animation
    Wait(math.max(0, duration - dropAt) + 100)
    ClearPedTasks(clerk)
    return true
end

local function resolveStoreIdForClerk(clerk)
    if activeStoreId then return activeStoreId end
    if clerk and fightingClerks[clerk] then return fightingClerks[clerk] end
    if clerk and GS_FindStoreByPed then return GS_FindStoreByPed(clerk) end
    return nil
end

local function returnClerkToSpawn(clerk, storeId)
    if not clerk or not DoesEntityExist(clerk) then return end
    storeId = storeId or resolveStoreIdForClerk(clerk)
    if not storeId then return end

    local spawn = GS_GetClerkSpawn and GS_GetClerkSpawn(storeId)
    if not spawn then return end

    -- Walk back in a separate thread so restoreClerk doesn't block
    CreateThread(function()
        if not DoesEntityExist(clerk) or IsPedDeadOrDying(clerk, true) then return end

        FreezeEntityPosition(clerk, false)
        SetEntityInvincible(clerk, true)
        SetBlockingOfNonTemporaryEvents(clerk, true)
        SetPedFleeAttributes(clerk, 0, true)
        RemoveAllPedWeapons(clerk, true, true)

        local dist = #(GetEntityCoords(clerk) - vector3(spawn.x, spawn.y, spawn.z))

        if dist > 0.5 then
            -- Use navmesh so the clerk navigates around obstacles
            TaskFollowNavMeshToCoord(clerk, spawn.x, spawn.y, spawn.z, 1.0, -1, 0.4, false, spawn.w or 0.0)

            local deadline = GetGameTimer() + 20000
            while GetGameTimer() < deadline do
                Wait(200)
                if not DoesEntityExist(clerk) or IsPedDeadOrDying(clerk, true) then return end
                local d = #(GetEntityCoords(clerk) - vector3(spawn.x, spawn.y, spawn.z))
                if d < 0.6 then break end
            end
        end

        if not DoesEntityExist(clerk) or IsPedDeadOrDying(clerk, true) then return end

        ClearPedTasksImmediately(clerk)
        SetEntityCoords(clerk, spawn.x, spawn.y, spawn.z, false, false, false, false)
        SetEntityHeading(clerk, spawn.w or 0.0)
        pcall(PlaceEntityOnGroundProperly, clerk, true)
        Wait(50)
        FreezeEntityPosition(clerk, true)
        SetEntityCanBeDamaged(clerk, false)
        SetEntityInvincible(clerk, true)
        SetBlockingOfNonTemporaryEvents(clerk, true)
    end)
end

local function restoreClerk(clerk, storeId)
    if not clerk or not DoesEntityExist(clerk) then return end

    local surrender = cfg().surrenderAnim
    local handover  = cfg().handoverAnim or {}

    if handover.dict and handover.clip then
        StopAnimTask(clerk, handover.dict, handover.clip, 1.0)
    end
    if surrender and surrender.dict and surrender.clip then
        StopAnimTask(clerk, surrender.dict, surrender.clip, 1.0)
    end

    -- Sync stop to nearby players
    local netId = NetworkGetNetworkIdFromEntity(clerk)
    if netId and netId ~= 0 then
        TriggerServerEvent('general_store:server:syncClerkAnimStop', netId)
    end

    ClearPedTasksImmediately(clerk)
    ClearPedTasks(clerk)
    SetPedKeepTask(clerk, false)

    -- Walk back async; freeze/invincible applied at destination inside returnClerkToSpawn
    returnClerkToSpawn(clerk, storeId)
end

local function clearSurrenderState(clerk)
    local ped = clerk or surrenderingClerk
    local storeId = resolveStoreIdForClerk(ped)
    if ped and DoesEntityExist(ped) then
        busyClerks[ped] = nil
        restoreClerk(ped, storeId)
    end
    releaseAimLock()
    surrenderingClerk = nil
    surrenderMode = nil
    activeStoreId = nil
    holdStart = nil
    holdSavedMs = nil
    aimLostAt = nil
end

local function pauseAimHold()
    if holdStart then
        holdSavedMs = GetGameTimer() - holdStart
        holdStart = nil
    end
end

local function resumeAimHold()
    if holdSavedMs then
        holdStart = GetGameTimer() - holdSavedMs
    end
end

local function markAimLost()
    if surrenderMode ~= 'aim' then return end
    if isRobberyBusy() then return end
    if aimLostAt then return end
    aimLostAt = GetGameTimer()
    pauseAimHold()
end

local function cancelAimLost()
    if not aimLostAt then return end
    aimLostAt = nil
    resumeAimHold()
end

local function tryFinishAimRelease()
    if surrenderMode ~= 'aim' or not aimLostAt then return end
    if isRobberyBusy() then return end

    local clerk = surrenderingClerk
    if clerk and playerDistToClerk(clerk) > releaseDist() then
        aimLostAt = nil
        holdSavedMs = nil
        clearSurrenderState(clerk)
        return
    end

    if GetGameTimer() - aimLostAt < aimReleaseDelay() then return end
    aimLostAt = nil
    holdSavedMs = nil
    clearSurrenderState(surrenderingClerk)
end

local function beginAimSurrender(clerk, storeId)
    if not clerk or not storeId then return end
    if surrenderMode == 'post_robbery' and surrenderingClerk == clerk then return end

    local resumeFromGrace = aimLostAt ~= nil
        and surrenderMode == 'aim'
        and surrenderingClerk == clerk
        and activeStoreId == storeId
    local starting = not resumeFromGrace
        and (surrenderMode ~= 'aim' or surrenderingClerk ~= clerk or activeStoreId ~= storeId)

    cancelAimLost()
    surrenderMode = 'aim'
    surrenderingClerk = clerk
    activeStoreId = storeId
    if starting then
        holdStart = GetGameTimer()
        holdSavedMs = nil
        -- Sync surrender anim to nearby players
        local netId = NetworkGetNetworkIdFromEntity(clerk)
        if netId and netId ~= 0 then
            local a = cfg().surrenderAnim
            if a and a.dict and a.clip then
                TriggerServerEvent('general_store:server:syncClerkAnim', netId, a.dict, a.clip, a.flag or 1, -1, true)
            end
        end
    end
    playSurrenderLoop(clerk)
end

local function endAimSurrender()
    if isAnyClerkFighting() then return end
    markAimLost()
end

local function clearClerkFightState(clerk, restoreAlive)
    local storeId = (clerk and fightingClerks[clerk]) or activeStoreId or resolveStoreIdForClerk(clerk)
    fightingClerks[clerk] = nil
    fightTriggered[clerk] = nil
    clerkFightTrack[clerk] = nil
    clerkFightMode[clerk]  = nil

    if restoreAlive and clerk and DoesEntityExist(clerk) and not IsPedDeadOrDying(clerk, true) then
        ClearPedTasksImmediately(clerk)
        ClearPedTasks(clerk)
        RemoveAllPedWeapons(clerk, true, true)
        restoreClerk(clerk, storeId)
    end

    -- Release aim lock AFTER marking register lootable so the server still has the holder
    sessionReaction = nil
    releaseAimLock()  -- sends releaseRobberyAim to server (clears aimHolders there)
    activeStoreId = nil
    holdStart = nil
    holdSavedMs = nil
    aimLostAt = nil
    surrenderingClerk = nil
    surrenderMode = nil
end

local function setClerkHostileToPlayer(clerk)
    local playerGroup = GetPedRelationshipGroupHash(PlayerPedId())
    local hostileGroup = joaat('REL_CRIMINALS')

    SetPedRelationshipGroupHash(clerk, hostileGroup)
    SetRelationshipBetweenGroups(5, hostileGroup, playerGroup)
end

local function isPlayerAimingAtClerk(clerk)
    if not clerk or not DoesEntityExist(clerk) then return false end
    local playerId = PlayerId()
    local aiming = IsPlayerFreeAiming(playerId)
        or IsControlPressed(0, joaat('INPUT_AIM'))
        or IsControlPressed(0, joaat('INPUT_PLAYER_TARGET'))
    if not aiming then return false end

    local hit, ent = GetEntityPlayerIsFreeAimingAt(playerId)
    if hit and ent == clerk then return true end

    return playerDistToClerk(clerk) <= (cfg().maxAimDistance or 6.0)
end

local function maintainClerkFightPosture(clerk)
    if not clerk or not DoesEntityExist(clerk) then return end
    FreezeEntityPosition(clerk, false)
    -- Do NOT block non-temporary events during combat — that freezes the combat AI
    SetPedFleeAttributes(clerk, 0, true)
    SetPedCombatAttributes(clerk, 17, true)  -- can use cover
    SetPedCombatAttributes(clerk, 46, true)  -- move to engage
    SetPedCombatAttributes(clerk, 5, true)   -- always fight
    SetPedCombatAttributes(clerk, 0, false)  -- don't disable combat
    SetPedCombatMovement(clerk, 2)           -- offensive
end

local function clerkFightEngageDist()
    return cfg().clerkFightEngageDistance or 2.8
end

local function isClerkFightStuck(clerk)
    if not clerk or not DoesEntityExist(clerk) then return false end
    local now = GetGameTimer()
    local pos = GetEntityCoords(clerk)
    local track = clerkFightTrack[clerk]

    if not track or not track.pos then
        clerkFightTrack[clerk] = { pos = pos, atMs = now, taskAtMs = track and track.taskAtMs or 0 }
        return false
    end

    if #(pos - track.pos) > 0.35 then
        track.pos = pos
        track.atMs = now
        return false
    end

    return (now - track.atMs) >= 1800
end

local function noteClerkFightTask(clerk)
    if not clerk then return end
    local track = clerkFightTrack[clerk] or {}
    track.taskAtMs = GetGameTimer()
    track.pos = GetEntityCoords(clerk)
    track.atMs = track.taskAtMs
    clerkFightTrack[clerk] = track
end

local FIRING_PATTERN_FULL_AUTO = joaat('FIRING_PATTERN_FULL_AUTO')

local function refreshClerkCombat(clerk, targetPed, force)
    if not clerk or not DoesEntityExist(clerk) then return end
    if IsPedDeadOrDying(clerk, true) then return end
    if isLocalPlayerDead() then return end
    if not targetPed or not DoesEntityExist(targetPed) then return end
    if IsEntityDead(targetPed) or IsPedDeadOrDying(targetPed, true) then return end

    local now        = GetGameTimer()
    local track      = clerkFightTrack[clerk] or {}
    local stuck      = isClerkFightStuck(clerk)
    local dist       = #(GetEntityCoords(clerk) - GetEntityCoords(targetPed))
    local shootRange = cfg().clerkShootRange or 10.0
    local moveSpeed  = cfg().clerkFightMoveSpeed or 3.0
    local engageDist = clerkFightEngageDist()
    local curMode    = clerkFightMode[clerk]
    local wantMode   = (dist <= shootRange) and 'shoot' or 'walk'

    -- Only retask when mode changes, stuck, or forced
    if not force and not stuck and curMode == wantMode
        and track.taskAtMs and (now - track.taskAtMs) < 1800 then
        return
    end

    maintainClerkFightPosture(clerk)

    local tp = GetEntityCoords(targetPed)

    if stuck or wantMode == 'walk' then
        -- Navigate toward player via navmesh — never teleports
        ClearPedTasks(clerk)
        TaskFollowNavMeshToCoord(clerk, tp.x, tp.y, tp.z, moveSpeed, -1, engageDist, false, 0.0)
        clerkFightMode[clerk] = 'walk'
    else
        -- Close enough: stand and shoot, no movement snap
        ClearPedTasks(clerk)
        TaskShootAtEntity(clerk, targetPed, -1, FIRING_PATTERN_FULL_AUTO)
        clerkFightMode[clerk] = 'shoot'
    end

    noteClerkFightTask(clerk)
end

local function prepareClerkForCombat(clerk)
    ClearPedTasksImmediately(clerk)
    ClearPedTasks(clerk)

    SetEntityInvincible(clerk, false)
    SetEntityCanBeDamaged(clerk, true)
    SetPedCanPlayAmbientAnims(clerk, false)
    SetPedCanPlayAmbientBaseAnims(clerk, false)

    maintainClerkFightPosture(clerk)

    SetPedCombatAbility(clerk, 2)
    SetPedSeeingRange(clerk, 80.0)
    SetPedHearingRange(clerk, 80.0)
    SetPedCombatRange(clerk, 3)
    SetPedAccuracy(clerk, cfg().clerkFightAccuracy or 55)
    pcall(SetPedCanBeTargettedByPlayer, clerk, PlayerId(), true)

    pcall(setClerkHostileToPlayer, clerk)
end

local function giveClerkFightWeapon(clerk, weaponHash, ammo)
    RemoveAllPedWeapons(clerk, true, true)
    GiveWeaponToPed(clerk, weaponHash, ammo, false, true)
    SetCurrentPedWeapon(clerk, weaponHash, true, 0, false, false)
end

local function endClerkFight(clerk)
    if not clerk then return end
    clearClerkFightState(clerk, true)
end

local function startClerkFight(clerk, storeId)
    if not clerk or not DoesEntityExist(clerk) then return end
    if fightTriggered[clerk] or isClerkFighting(clerk) then return end

    fightTriggered[clerk] = true
    holdStart = nil
    holdSavedMs = nil
    aimLostAt = nil
    surrenderingClerk = nil
    surrenderMode = nil

    CreateThread(function()
        if not DoesEntityExist(clerk) then
            fightTriggered[clerk] = nil
            return
        end

        requestPedControl(clerk)

        local surrender = cfg().surrenderAnim
        if surrender and surrender.dict and surrender.clip then
            StopAnimTask(clerk, surrender.dict, surrender.clip, 1.0)
        end
        ClearPedTasksImmediately(clerk)

        fightingClerks[clerk] = storeId
        activeStoreId = storeId

        prepareClerkForCombat(clerk)

        local weapon = hashOf(cfg().clerkFightWeapon or 'WEAPON_SHOTGUN_DOUBLEBARREL')
        local ammo   = cfg().clerkFightAmmo or 8
        giveClerkFightWeapon(clerk, weapon, ammo)

        Wait(cfg().clerkFightDrawDelayMs or 700)

        if not DoesEntityExist(clerk) or IsPedDeadOrDying(clerk, true) then
            markRegisterLootable(storeId)
            if GS_ScheduleClerkRespawn then GS_ScheduleClerkRespawn(storeId) end
            clearClerkFightState(clerk, false)
            return
        end

        local player = PlayerPedId()
        refreshClerkCombat(clerk, player, true)
        TriggerServerEvent('general_store:server:clerkFightback', storeId)
        notifyToast('Clerk Fightback', cfg().clerkFightToast or 'The clerk pulled a double-barrel shotgun!', 'error', 4500)
    end)
end

local function runRobbery(clerk, storeId)
    if isClerkFighting(clerk) or sessionReaction == 'fight' then return end
    if busyClerks[clerk] then return end
    if isStoreOnCooldown(storeId) then
        showCooldownToast(storeId)
        return
    end
    if not canReceivePayout(clerk, storeId) then return end

    busyClerks[clerk] = true

    if GS_CloseStoreUi then GS_CloseStoreUi() end

    if not isPlayingSurrender(clerk) then playSurrenderLoop(clerk) end
    surrenderingClerk = clerk
    activeStoreId = storeId
    Wait(1000)

    if not canReceivePayout(clerk, storeId) then
        busyClerks[clerk] = nil
        if playerDistToClerk(clerk) > releaseDist() then
            clearSurrenderState(clerk)
        end
        return
    end

    playHandoverAndDropProp(clerk)

    if not canReceivePayout(clerk, storeId) then
        busyClerks[clerk] = nil
        if playerDistToClerk(clerk) > releaseDist() then
            clearSurrenderState(clerk)
        end
        return
    end

    TriggerServerEvent('general_store:server:robClerk', storeId)

    surrenderMode = 'post_robbery'
    surrenderingClerk = clerk
    activeStoreId = storeId
    holdStart = nil
    playSurrenderLoop(clerk)

    busyClerks[clerk] = nil
end

-- ─── Robbery watcher ──────────────────────────────────────────────────────────
CreateThread(function()
    Wait(1500)
    RSGCore.Functions.TriggerCallback('general_store:server:getRobberyCooldowns', function(cds)
        if type(cds) ~= 'table' then return end
        for storeId, remaining in pairs(cds) do
            setStoreCooldown(storeId, remaining)
        end
    end)
end)

CreateThread(function()
    while true do
        local retaskMs = cfg().clerkFightRetaskMs or 350
        Wait(retaskMs)

        for clerk, _ in pairs(fightingClerks) do
            if not DoesEntityExist(clerk) or IsPedDeadOrDying(clerk, true) then
                local storeId = fightingClerks[clerk]
                if storeId then
                    markRegisterLootable(storeId)
                    -- Also confirm via server in case local watcher missed it
                    TriggerServerEvent('general_store:server:clerkKilledInFight', storeId)
                    if GS_ScheduleClerkRespawn then GS_ScheduleClerkRespawn(storeId) end
                end
                clearClerkFightState(clerk, false)
            elseif isLocalPlayerDead() then
                endClerkFight(clerk)
            else
                local resetDist = cfg().clerkFightResetDistance or releaseDist()
                if playerDistToClerk(clerk) > resetDist then
                    endClerkFight(clerk)
                else
                    local player = PlayerPedId()
                    maintainClerkFightPosture(clerk)
                    refreshClerkCombat(clerk, player, isPlayerAimingAtClerk(clerk))
                end
            end
        end
    end
end)

CreateThread(function()
    while true do
        local sleep = 250

        if robberyEnabled() then
            -- Post-robbery only: keep surrender until player walks away.
            if surrenderMode == 'post_robbery' and surrenderingClerk and DoesEntityExist(surrenderingClerk) then
                sleep = 50
                if playerDistToClerk(surrenderingClerk) > releaseDist() then
                    clearSurrenderState(surrenderingClerk)
                elseif not busyClerks[surrenderingClerk] and not isPlayingSurrender(surrenderingClerk) then
                    playSurrenderLoop(surrenderingClerk)
                end
            elseif surrenderMode == 'aim' and surrenderingClerk and DoesEntityExist(surrenderingClerk) then
                sleep = 50
                if aimLostAt then
                    tryFinishAimRelease()
                end
                if surrenderMode == 'aim'
                    and surrenderingClerk
                    and not busyClerks[surrenderingClerk]
                    and not isPlayingSurrender(surrenderingClerk)
                then
                    playSurrenderLoop(surrenderingClerk)
                end
            end

            -- Aim at clerk → claim server lock (first aimer only) → surrender + hold timer.
            if not (GS_IsStoreUiOpen and GS_IsStoreUiOpen()) and not isAnyClerkFighting() then
                local player = PlayerPedId()
                if isPlayerArmed(player) then
                    sleep = 50
                    local clerk, storeId = getAimedClerk()
                    if clerk and storeId and not busyClerks[clerk] and not isClerkFighting(clerk) then
                        local dist = #(GetEntityCoords(player) - GetEntityCoords(clerk))
                        if isStoreOnCooldown(storeId) then
                            showCooldownToast(storeId)
                            endAimSurrender()
                        elseif dist <= (cfg().maxAimDistance or 6.0) then
                            requestAimLock(storeId)

                            if hasAimLock(storeId) and not isStoreOnCooldown(storeId) then
                                if sessionReaction == 'fight' then
                                    startClerkFight(clerk, storeId)
                                else
                                    beginAimSurrender(clerk, storeId)

                                    if holdStart and GetGameTimer() - holdStart >= (cfg().aimHoldDuration or 4000) then
                                        holdStart = nil
                                        CreateThread(function()
                                            runRobbery(clerk, storeId)
                                        end)
                                    end
                                end
                            end
                        else
                            endAimSurrender()
                        end
                    elseif not isAnyClerkFighting() then
                        endAimSurrender()
                    end
                elseif not isAnyClerkFighting() then
                    endAimSurrender()
                end
            end
        end

        Wait(sleep)
    end
end)

CreateThread(function()
    local wasNearby = {}
    local fadingOut = {}

    while true do
        local sleep = 800

        if robberyEnabled() and not (GS_IsStoreUiOpen and GS_IsStoreUiOpen()) then
            local ped = PlayerPedId()
            local pcoords = GetEntityCoords(ped)
            local drawDist = registerDrawDist()
            local interactDist = registerInteractDist()
            local focusedStore = nil
            local focusedDist = nil

            for storeId, _ in pairs(registerLootable) do
                if canLootRegister(storeId) then
                    local reg = GS_GetCashRegister and GS_GetCashRegister(storeId)
                    if reg then
                        local dist = #(pcoords - vector3(reg.x, reg.y, reg.z))
                        if dist < drawDist and (not focusedDist or dist < focusedDist) then
                            focusedStore = storeId
                            focusedDist = dist
                        end
                    end
                elseif registerLootable[storeId] and not registerRobBusy then
                    -- Only clear if we're not mid-animation (busy = anim playing, keep lootable)
                    registerLootable[storeId] = nil
                end
            end

            if focusedStore then
                sleep = 0
                local canRob = focusedDist <= interactDist and not registerRobBusy
                local holdProgress = tickRegisterHold(focusedStore, canRob)
                local animId = 'register_' .. focusedStore

                if not wasNearby[focusedStore] then
                    GS_EnsureDrawTextEnter(animId)
                    fadingOut[focusedStore] = nil
                end
                drawRegisterPrompt(focusedStore, holdProgress)
                wasNearby[focusedStore] = true
            else
                resetRegisterHold()
                for storeId, _ in pairs(wasNearby) do
                    if wasNearby[storeId] then
                        GS_StartDrawTextExit('register_' .. storeId)
                        fadingOut[storeId] = storeId
                        wasNearby[storeId] = false
                    end
                end
            end

            for storeId, _ in pairs(fadingOut) do
                local animId = 'register_' .. storeId
                if fadingOut[storeId] and not (focusedStore == storeId) then
                    drawRegisterPrompt(storeId, 0.0)
                    if not GS_IsDrawTextActive(animId) then
                        fadingOut[storeId] = nil
                    end
                end
            end
        else
            resetRegisterHold()
        end

        Wait(sleep)
    end
end)

AddEventHandler('onResourceStop', function(res)
    if res ~= GetCurrentResourceName() then return end
    for clerk, _ in pairs(fightingClerks) do
        endClerkFight(clerk)
    end
    registerLootable = {}
    resetRegisterHold()
    releaseAimLock()
end)

AddEventHandler('general_store:client:clerkRespawned', function(storeId)
    if type(storeId) == 'string' then
        registerLootable[storeId] = nil
        resetRegisterHold()
    end
end)

-- Server confirms clerk died during fightback — mark register lootable
RegisterNetEvent('general_store:client:markRegisterLootable', function(storeId)
    if type(storeId) == 'string' and storeId ~= '' then
        markRegisterLootable(storeId)
    end
end)

-- Received from server: play surrender anim on a clerk entity (we are a bystander)
RegisterNetEvent('general_store:client:syncClerkAnim', function(netId, dict, clip, flag, duration)
    if not netId or netId == 0 then return end
    local clerk = NetworkGetEntityFromNetworkId(netId)
    if not clerk or clerk == 0 or not DoesEntityExist(clerk) then return end

    if not loadAnimDict(dict) then return end
    TaskPlayAnim(clerk, dict, clip, 8.0, -8.0, duration or -1, flag or 1, 0.0, false, false, false)
end)

RegisterNetEvent('general_store:client:syncClerkAnimStop', function(netId)
    if not netId or netId == 0 then return end
    local clerk = NetworkGetEntityFromNetworkId(netId)
    if not clerk or clerk == 0 or not DoesEntityExist(clerk) then return end
    ClearPedTasks(clerk)
end)

RegisterNetEvent('general_store:client:storeRobberyCooldown', function(storeId, durationMs)
    -- Cooldown only blocks repeat payouts — does not touch clerk animation state.
    setStoreCooldown(storeId, durationMs or (cfg().cooldown or (30 * 60 * 1000)))
    registerLootable[storeId] = nil
end)

RegisterNetEvent('general_store:client:robberyResult', function(success, reason, reward, storeId)
    if success then
        local msg = reason == 'register_ok'
            and ('You emptied the till — $%d.'):format(reward or 0)
            or  ('You took $%d from the till.'):format(reward or 0)
        notifyToast('Robbery', msg, 'success', 4500)
        if storeId then registerLootable[storeId] = nil end
    else
        local sid = storeId or activeStoreId
        local msg = 'Could not rob this store.'
        if reason == 'cooldown' then
            local remaining = sid and cooldownRemainingMs(sid) or 0
            msg = remaining > 0
                and ('This store was already robbed. Wait %s.'):format(formatCooldownRemaining(remaining))
                or  'This store was already robbed recently.'
        elseif reason == 'disabled' then
            msg = 'Store robberies are disabled.'
        elseif reason == 'clerk_fighting' then
            msg = 'The clerk is fighting back — no payout.'
        end
        notifyToast('Robbery Failed', msg, 'error', 5000)
    end
end)
