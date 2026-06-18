local RSGCore = exports['rsg-core']:GetCoreObject()

local SHOPS = {}
local OWNED_STORE_IDS = {}
local currentStoreId = nil
local uiOpen = false
local clerkRespawnAt = {} -- storeId → GetGameTimer() when clerk should respawn
local ownedRefreshBusy = false

function GS_IsStoreUiOpen()
    return uiOpen
end

local function isClerkAlive(ped)
    return ped and DoesEntityExist(ped) and not IsPedDeadOrDying(ped, true)
end

function GS_IsClerkAlive(ped)
    return isClerkAlive(ped)
end

function GS_GetNearestClerkDist()
    local pcoords = GetEntityCoords(PlayerPedId())
    local nearest = nil
    for _, entry in pairs(SHOPS) do
        if entry.ped and DoesEntityExist(entry.ped) then
            local d = #(pcoords - GetEntityCoords(entry.ped))
            if not nearest or d < nearest then nearest = d end
        end
    end
    return nearest
end

function GS_FindStoreByPed(targetPed)
    if not targetPed or targetPed == 0 then return nil, nil end
    for storeId, entry in pairs(SHOPS) do
        if entry.ped == targetPed then return storeId, entry end
    end
    return nil, nil
end

function GS_GetStoreClerk(storeId)
    local entry = SHOPS[storeId]
    if entry and entry.ped and DoesEntityExist(entry.ped) then return entry.ped end
    return nil
end

function GS_IsOwnedStoreClient(storeId)
    if type(storeId) ~= 'string' then return false end
    local entry = SHOPS[storeId]
    return OWNED_STORE_IDS[storeId] == true or (entry and entry.owned == true) or false
end

function GS_GetClientStores()
    return SHOPS
end

function GS_GetClerkSpawn(storeId)
    local def = (SHOPS[storeId] and SHOPS[storeId].def) or (Config.Stores and Config.Stores[storeId])
    local c = def and def.npc and def.npc.coords
    if not c then return nil end
    return vector4(c.x, c.y, c.z - 1.0, c.w or 0.0)
end

function GS_GetCashRegister(storeId)
    local def = (SHOPS[storeId] and SHOPS[storeId].def) or (Config.Stores and Config.Stores[storeId])
    if not def then return nil end

    local reg = def.cashRegister
    if reg then
        if type(reg) == 'vector4' then return reg end
        if type(reg) == 'table' and reg.x and reg.y and reg.z then
            return vector4(reg.x + 0.0, reg.y + 0.0, reg.z + 0.0, reg.w or 0.0)
        end
    end

    local c = def.npc and def.npc.coords
    if not c then return nil end
    local h = math.rad(c.w or 0.0)
    local fx, fy = -math.sin(h), math.cos(h)
    local rx, ry = math.cos(h), math.sin(h)
    return vector4(c.x + fx * 0.9 + rx * 0.35, c.y + fy * 0.9 + ry * 0.35, c.z + 0.05, c.w or 0.0)
end

local function storeNpcCoords(def)
    local c = def and def.npc and def.npc.coords
    if not c then return nil end
    return vector3(c.x + 0.0, c.y + 0.0, c.z + 0.0)
end

local function resolveOpenStoreId(storeId)
    local entry = SHOPS[storeId]
    if not entry or entry.owned then return storeId end

    local center = storeNpcCoords(entry.def)
    if not center then return storeId end

    local radius = (Config.OwnedStores and Config.OwnedStores.openPreferenceRadius) or 6.0
    local bestId, bestDist = nil, nil
    for ownedId, ownedEntry in pairs(SHOPS) do
        if ownedEntry and ownedEntry.owned and ownedEntry.def then
            local ownedCenter = storeNpcCoords(ownedEntry.def)
            if ownedCenter then
                local dist = #(center - ownedCenter)
                if dist <= radius and (not bestDist or dist < bestDist) then
                    bestId, bestDist = ownedId, dist
                end
            end
        end
    end

    return bestId or storeId
end

function GS_GetVisualStoreId(storeId)
    local entry = SHOPS[storeId]
    if not entry or not entry.owned then return storeId end

    local center = storeNpcCoords(entry.def)
    if not center then return storeId end

    local radius = (Config.OwnedStores and Config.OwnedStores.visualFallbackRadius)
        or (Config.ShelfStoreRadius or 28.0)
    local bestId, bestDist = nil, nil
    for baseId, baseEntry in pairs(SHOPS) do
        if baseEntry and not baseEntry.owned and Config.Stores and Config.Stores[baseId] then
            local baseCenter = storeNpcCoords(baseEntry.def)
            if baseCenter then
                local dist = #(center - baseCenter)
                if dist <= radius and (not bestDist or dist < bestDist) then
                    bestId, bestDist = baseId, dist
                end
            end
        end
    end

    return bestId or storeId
end

function GS_GetClerks()
    local list = {}
    for storeId, entry in pairs(SHOPS) do
        if isClerkAlive(entry.ped) then
            list[#list + 1] = { ped = entry.ped, storeId = storeId }
        end
    end
    return list
end

--- After `ensure`/restart, orphans can sit on the spawn capsule — purge before spawning.
local CLERK_PURGE_RADIUS = (Config.NpcRestartPurgeRadius ~= nil and Config.NpcRestartPurgeRadius) or 3.25

local function loadModel(modelHash)
    if not modelHash or modelHash == 0 then return false end
    RequestModel(modelHash, false)
    local deadline = GetGameTimer() + 10000
    while not HasModelLoaded(modelHash) do
        if GetGameTimer() > deadline then return false end
        Wait(10)
    end
    return true
end

local function pedMayBeDeletedAsClerk(ped, excludePed)
    if type(ped) ~= 'number' or ped == 0 or ped == excludePed then return false end
    if not DoesEntityExist(ped) then return false end
    if ped == PlayerPedId() then return false end
    if IsPedAPlayer and IsPedAPlayer(ped) then return false end
    -- Never delete a live networked ped we don't own — it belongs to another client.
    -- Dead networked peds are orphans from a previous run; allow deleting those.
    if NetworkGetEntityIsNetworked(ped) and not NetworkHasControlOfEntity(ped) then
        if not IsPedDeadOrDying(ped, true) then return false end
    end
    return true
end

local function findExistingNetworkedClerk(modelHash, cx, cy, cz)
    local pool
    local ok = pcall(function() pool = GetGamePool('CPed') end)
    if not ok or type(pool) ~= 'table' then return nil end
    local center = vector3(cx, cy, cz)
    for _, ped in ipairs(pool) do
        if DoesEntityExist(ped)
            and NetworkGetEntityIsNetworked(ped)
            and not IsPedDeadOrDying(ped, true)
            and GetEntityModel(ped) == modelHash
            and #(GetEntityCoords(ped) - center) <= CLERK_PURGE_RADIUS
        then
            return ped
        end
    end
    return nil
end

--- Hard delete scripted clerk (resource stop); RedM sometimes needs MissionEntity + both natives.
local function deleteShopPedEntity(ped)
    if not ped or ped == 0 or not DoesEntityExist(ped) then return end
    NetworkRequestControlOfEntity(ped)
    local deadline = GetGameTimer() + 750
    while not NetworkHasControlOfEntity(ped) and GetGameTimer() < deadline do
        Wait(0)
    end
    SetEntityAsMissionEntity(ped, true, true)
    DeletePed(ped)
    Wait(0)
    if DoesEntityExist(ped) then
        DeleteEntity(ped)
    end
end

--- Leftover clerks from failed stop / restart order (same model + near spawn XYZ).
local function purgeOrphanClerksNear(modelHash, cx, cy, cz, excludePed)
    local center = vector3(cx, cy, cz)
    local pool
    local okPool = pcall(function()
        pool = GetGamePool('CPed')
    end)
    if not okPool or type(pool) ~= 'table' then return end
    for _, ped in ipairs(pool) do
        if pedMayBeDeletedAsClerk(ped, excludePed) and GetEntityModel(ped) == modelHash then
            if #(GetEntityCoords(ped) - center) <= CLERK_PURGE_RADIUS then
                deleteShopPedEntity(ped)
            end
        end
    end
end

local function cleanupShopEntry(entry)
    if entry.blip and DoesBlipExist(entry.blip) then
        RemoveBlip(entry.blip)
        entry.blip = nil
    end
    if entry.ped and entry.ped ~= 0 then
        deleteShopPedEntity(entry.ped)
        entry.ped = nil
    end
end

local function clerkRespawnDelayMs()
    local rob = Config.Robbery or {}
    local ms = rob.clerkRespawnMs
    if type(ms) == 'number' and ms > 0 then return ms end
    return rob.cooldown or (30 * 60 * 1000)
end

local function startClerkIdleAnims(ped)
    local cfg = Config.ClerkIdleAnims
    if not cfg or cfg.enabled == false then return end

    local dict  = cfg.dict
    local clips = cfg.clips
    if type(dict) ~= 'string' or type(clips) ~= 'table' or #clips == 0 then return end

    CreateThread(function()
        Wait(cfg.startDelay or 2500)

        RequestAnimDict(dict)
        local deadline = GetGameTimer() + 6000
        while not HasAnimDictLoaded(dict) and GetGameTimer() < deadline do
            Wait(100)
        end
        if not HasAnimDictLoaded(dict) then return end

        local minHold  = cfg.minHoldDuration or 6000
        local maxHold  = cfg.maxHoldDuration or 12000
        local minPause = cfg.minPauseBetween or 2000
        local maxPause = cfg.maxPauseBetween or 5000
        local blendIn  = cfg.blendIn  or 2.0
        local blendOut = cfg.blendOut or 2.0

        while DoesEntityExist(ped) and not IsPedDeadOrDying(ped, true) do
            -- Skip task calls while another client owns the ped (robbery in progress)
            if NetworkGetEntityIsNetworked(ped) and not NetworkHasControlOfEntity(ped) then
                Wait(500)
            elseif not GS_IsClerkBusy(ped) then
                local clip = clips[math.random(#clips)]
                local hold = math.random(minHold, maxHold)

                -- flag 1 = looped, -1 duration = engine controls length; we stop it after `hold` ms
                TaskPlayAnim(ped, dict, clip, blendIn, -blendOut, -1, 1, 0.0, false, false, false)

                local finish = GetGameTimer() + hold
                while GetGameTimer() < finish do
                    if GS_IsClerkBusy(ped) then break end
                    Wait(200)
                end

                -- Smooth stop — StopAnimTask blends out naturally
                if not GS_IsClerkBusy(ped) then
                    StopAnimTask(ped, dict, clip, blendOut)
                    Wait(math.floor((1.0 / blendOut) * 1000) + 100)
                end
            end

            local pause = math.random(minPause, maxPause)
            Wait(pause)
        end

        RemoveAnimDict(dict)
    end)
end

local function spawnShopClerk(storeId, entry)
    local def = entry.def
    local c = def and def.npc and def.npc.coords
    if not c then return nil end

    local modelName = def.npc.model
    local hash = type(modelName) == 'string' and joaat(modelName) or modelName
    if not hash or hash == 0 or not loadModel(hash) then
        print(('[general_store] Failed to load clerk model %s (%s)'):format(tostring(modelName), storeId))
        return nil
    end

    -- Reuse a networked clerk already spawned by another client at this location
    local existing = findExistingNetworkedClerk(hash, c.x, c.y, c.z)
    if existing then
        entry.ped = existing
        startClerkIdleAnims(existing)
        return existing
    end

    purgeOrphanClerksNear(hash, c.x, c.y, c.z, nil)

    -- isNetwork = true so all players see this ped
    local ped = CreatePed(hash, c.x, c.y, c.z - 1.0, c.w, true, false, false, false)
    if not ped or ped == 0 then return nil end
    NetworkRegisterEntityAsNetworked(ped)

    Citizen.InvokeNative(0x283978A15512B2FE, ped, true)
    SetEntityCanBeDamaged(ped, false)
    SetEntityInvincible(ped, true)
    FreezeEntityPosition(ped, true)
    SetBlockingOfNonTemporaryEvents(ped, true)
    entry.ped = ped
    startClerkIdleAnims(ped)
    return ped
end

function GS_ScheduleClerkRespawn(storeId)
    if type(storeId) ~= 'string' or not SHOPS[storeId] then return end
    clerkRespawnAt[storeId] = GetGameTimer() + clerkRespawnDelayMs()
end

local function respawnShopClerk(storeId)
    local entry = SHOPS[storeId]
    if not entry then return end

    if entry.ped and DoesEntityExist(entry.ped) then
        if not IsPedDeadOrDying(entry.ped, true) then return end
        deleteShopPedEntity(entry.ped)
        entry.ped = nil
    end

    spawnShopClerk(storeId, entry)
    clerkRespawnAt[storeId] = nil
    TriggerEvent('general_store:client:clerkRespawned', storeId)
end

local function closeUi()
    if not uiOpen then return end
    uiOpen = false
    currentStoreId = nil
    SetNuiFocus(false, false)
    SendNUIMessage({ action = 'close' })
    GS_DestroyStoreFaceCam()
    GS_ClearDisplayCache()
    TriggerEvent('general_store:client:WorldPreviewClear')
end

function GS_CloseStoreUi()
    closeUi()
end

-- NPC interact uses animated DrawText3D module (client_drawtext3d.lua)

local function openShop(storeId)
    if uiOpen then return end
    if GS_IsRobberyActive and GS_IsRobberyActive() then return end
    storeId = resolveOpenStoreId(storeId)
    local entry = SHOPS[storeId]
    if not isClerkAlive(entry and entry.ped) then return end
    RSGCore.Functions.TriggerCallback('general_store:server:getOpenPayload', function(payload)
        local canManageEmptyStore = payload and payload.management and payload.management.canOpen
        if not payload or ((not payload.catalog or #payload.catalog == 0) and not canManageEmptyStore) then
            exports.general_store:ShowTooltip('Store unavailable.', 3500)
            return
        end
        currentStoreId = storeId
        uiOpen = true
        local entry = SHOPS[storeId]
        local clerk = entry and entry.ped
        if clerk and DoesEntityExist(clerk) then
            GS_CreateStoreFaceCam(clerk, storeId)
        end
        SetNuiFocus(true, true)
        SendNUIMessage({ action = 'open', data = payload })
    end, storeId)
end

local function createShopBlip(def)
    local c = def and def.npc and def.npc.coords
    local b = def and def.blip
    if not (b and b.enabled and c) then return nil end

    local style = b.style or 1664425300
    local coords = vector3(c.x, c.y, c.z)
    local blip = Citizen.InvokeNative(0x554D9D53F696D002, style, coords)
    SetBlipSprite(blip, b.sprite or Config.BlipSprite, 1)
    SetBlipScale(blip, b.scale or 0.2)
    Citizen.InvokeNative(0x9CB1A1623062F402, blip, b.name or def.label)
    return blip
end

local function ensureShopClerk(storeId, entry)
    if not storeId or not entry or not entry.def then return end

    if entry.ped and DoesEntityExist(entry.ped) then
        if IsPedDeadOrDying(entry.ped, true) and not clerkRespawnAt[storeId] then
            GS_ScheduleClerkRespawn(storeId)
        end
        return
    end

    spawnShopClerk(storeId, entry)
end

local function ensureMissingClerks()
    for storeId, entry in pairs(SHOPS) do
        ensureShopClerk(storeId, entry)
    end
end

local function setupShopEntry(storeId, def, owned)
    if not storeId or not def then return end
    if SHOPS[storeId] then
        local entry = SHOPS[storeId]
        entry.def = def
        entry.owned = owned == true
        if entry.blip and DoesBlipExist(entry.blip) then
            RemoveBlip(entry.blip)
            entry.blip = nil
        end
        entry.blip = createShopBlip(def)
        if owned then OWNED_STORE_IDS[storeId] = true end
        ensureShopClerk(storeId, entry)
        return
    end
    local entry = { def = def, owned = owned == true }
    SHOPS[storeId] = entry
    if owned then OWNED_STORE_IDS[storeId] = true end
    ensureShopClerk(storeId, entry)
    entry.blip = createShopBlip(def)
end

RegisterNetEvent('general_store:client:ownedStoreUpsert', function(storeId, def)
    setupShopEntry(storeId, def, true)
end)

local function refreshOwnedStores()
    if ownedRefreshBusy then return end
    ownedRefreshBusy = true

    RSGCore.Functions.TriggerCallback('general_store:server:getOwnedStores', function(stores)
        for _, store in ipairs(stores or {}) do
            setupShopEntry(store.id, store, true)
        end
        ownedRefreshBusy = false
        ensureMissingClerks()
    end)

    CreateThread(function()
        Wait(8000)
        ownedRefreshBusy = false
    end)
end

-- ——— spawn ———

CreateThread(function()
    -- Stagger spawn so the first-connected client creates networked peds and
    -- later clients find them in the entity pool instead of creating duplicates.
    local stagger = math.min(GetPlayerServerId(PlayerId()) * 400, 4000)
    Wait(stagger)

    for storeId, def in pairs(Config.Stores or {}) do
        setupShopEntry(storeId, def, false)
    end

    refreshOwnedStores()
    Wait(10000)
    refreshOwnedStores()
    ensureMissingClerks()
end)

RegisterNetEvent('RSGCore:Client:OnPlayerLoaded', function()
    CreateThread(function()
        Wait(2500)
        refreshOwnedStores()
        Wait(2500)
        ensureMissingClerks()
    end)
end)

CreateThread(function()
    Wait(12000)
    while true do
        ensureMissingClerks()
        Wait(15000)
    end
end)

CreateThread(function()
    while true do
        local sleep = 2000
        local now = GetGameTimer()

        for storeId, atMs in pairs(clerkRespawnAt) do
            if now >= atMs then
                respawnShopClerk(storeId)
            else
                sleep = 500
            end
        end

        Wait(sleep)
    end
end)

CreateThread(function()
    while true do
        Wait(2500)
        for storeId, entry in pairs(SHOPS) do
            if entry.ped and DoesEntityExist(entry.ped) and IsPedDeadOrDying(entry.ped, true) and not clerkRespawnAt[storeId] then
                GS_ScheduleClerkRespawn(storeId)
            end
        end
    end
end)

AddEventHandler('onResourceStop', function(res)
    if res ~= GetCurrentResourceName() then return end
    SetNuiFocus(false, false)
    uiOpen = false
    currentStoreId = nil
    GS_TeardownAll()
    for _, entry in pairs(SHOPS) do
        cleanupShopEntry(entry)
    end

    --- Final sweep by config coords (lost handles / failed delete)
    for storeId, def in pairs(Config.Stores or {}) do
        local c = def.npc and def.npc.coords
        if c then
            local modelName = def.npc.model
            local hash = type(modelName) == 'string' and joaat(modelName) or modelName
            if hash and hash ~= 0 then
                purgeOrphanClerksNear(hash, c.x, c.y, c.z, nil)
            end
        end
    end

    SHOPS = {}
    clerkRespawnAt = {}
end)

-- ——— proximity / interaction loop ———

CreateThread(function()
    local loc = Config.Locale or {}
    local clerkWasNearby = {}
    local clerkFading = {}

    while true do
        local sleep = 1000
        if not uiOpen then
            local ped = PlayerPedId()
            local pcoords = GetEntityCoords(ped)
            for storeId, entry in pairs(SHOPS) do
                local shopPed = entry.ped
                if shopPed and DoesEntityExist(shopPed) then
                    local sc = GetEntityCoords(shopPed)
                    local dist = #(pcoords - sc)
                    if dist < (Config.DrawDistance or 14.0) and isClerkAlive(shopPed) then
                        sleep = 0
                        local clerkAnimId = 'entity_' .. tostring(shopPed)
                        if dist < (Config.InteractDistance or 2.8) then
                            local robberyActive = GS_IsRobberyActive and GS_IsRobberyActive()
                            if not robberyActive then
                                local title = loc.interact_title or 'Store'
                                local hint = loc.interact_hint or '[G] Open'
                                if not clerkWasNearby[storeId] then
                                    GS_EnsureDrawTextEnter(clerkAnimId)
                                    clerkFading[storeId] = nil
                                end
                                GS_DrawText3D(shopPed, title .. '\n' .. hint)
                                clerkWasNearby[storeId] = true
                                if IsControlJustReleased(0, Config.OpenKey or 0x760A9C6F) then
                                    openShop(storeId)
                                    Wait(400)
                                end
                            else
                                clerkWasNearby[storeId] = nil
                                clerkFading[storeId] = nil
                            end
                        else
                            if clerkWasNearby[storeId] then
                                GS_StartDrawTextExit(clerkAnimId)
                                clerkFading[storeId] = shopPed
                                clerkWasNearby[storeId] = false
                            end
                            if clerkFading[storeId] and DoesEntityExist(clerkFading[storeId]) then
                                local title = loc.interact_title or 'Store'
                                local hint = loc.interact_hint or '[G] Open'
                                GS_DrawText3D(clerkFading[storeId], title .. '\n' .. hint)
                                if not GS_IsDrawTextActive(clerkAnimId) then
                                    clerkFading[storeId] = nil
                                end
                            end
                        end
                    else
                        clerkWasNearby[storeId] = nil
                        clerkFading[storeId] = nil
                    end
                else
                    clerkWasNearby[storeId] = nil
                    clerkFading[storeId] = nil
                end
            end
        end
        Wait(sleep)
    end
end)

CreateThread(function()
    local lookX = joaat('INPUT_LOOK_LR')
    local lookY = joaat('INPUT_LOOK_UD')
    local atk = joaat('INPUT_ATTACK')
    local aim = joaat('INPUT_AIM')
    while true do
        if uiOpen then
            DisableControlAction(0, lookX, true)
            DisableControlAction(0, lookY, true)
            DisableControlAction(0, atk, true)
            DisableControlAction(0, aim, true)
            Wait(0)
        else
            Wait(250)
        end
    end
end)

-- ——— NUI ———

RegisterNUICallback('close', function(_, cb)
    closeUi()
    cb('ok')
end)

RegisterNUICallback('checkout', function(body, cb)
    if GS_IsRobberyActive and GS_IsRobberyActive() then
        cb({ ok = false })
        return
    end
    if not currentStoreId or type(body) ~= 'table' then
        cb({ ok = false })
        return
    end
    TriggerServerEvent('general_store:server:purchase', currentStoreId, body.cart or {})
    cb({ ok = true })
end)

RegisterNUICallback('sellToStore', function(body, cb)
    if GS_IsRobberyActive and GS_IsRobberyActive() then
        cb({ ok = false, error = 'robbery_active' })
        return
    end
    if not currentStoreId or type(body) ~= 'table' then
        cb({ ok = false, error = 'no_store' })
        return
    end
    body.storeId = currentStoreId
    RSGCore.Functions.TriggerCallback('general_store:server:sellToOwnedStore', function(result)
        cb(result or { ok = false })
    end, body)
end)

RegisterNUICallback('refreshStorePayload', function(_, cb)
    if not currentStoreId then
        cb({ ok = false })
        return
    end
    RSGCore.Functions.TriggerCallback('general_store:server:getOpenPayload', function(payload)
        cb({ ok = payload ~= nil, payload = payload })
    end, currentStoreId)
end)

local function ownedManagementCallback(name, body, cb)
    if not currentStoreId then
        cb({ ok = false, error = 'no_store' })
        return
    end
    body = type(body) == 'table' and body or {}
    body.storeId = currentStoreId
    RSGCore.Functions.TriggerCallback(name, function(result)
        cb(result or { ok = false })
    end, body)
end

RegisterNUICallback('manageGet', function(_, cb)
    if not currentStoreId then
        cb({ ok = false, error = 'no_store' })
        return
    end
    RSGCore.Functions.TriggerCallback('general_store:server:getOwnedManagement', function(result)
        cb(result or { ok = false })
    end, currentStoreId)
end)

RegisterNUICallback('manageSaveDetails', function(body, cb)
    ownedManagementCallback('general_store:server:updateOwnedDetails', body, cb)
end)

RegisterNUICallback('manageAddStock', function(body, cb)
    ownedManagementCallback('general_store:server:addOwnedStock', body, cb)
end)

RegisterNUICallback('manageUpdateItem', function(body, cb)
    ownedManagementCallback('general_store:server:updateOwnedItem', body, cb)
end)

RegisterNUICallback('manageRemoveItem', function(body, cb)
    ownedManagementCallback('general_store:server:removeOwnedItem', body, cb)
end)

RegisterNUICallback('manageWithdraw', function(_, cb)
    if not currentStoreId then
        cb({ ok = false, error = 'no_store' })
        return
    end
    RSGCore.Functions.TriggerCallback('general_store:server:withdrawOwnedRegister', function(result)
        cb(result or { ok = false })
    end, currentStoreId)
end)

RegisterNUICallback('manageDeposit', function(body, cb)
    ownedManagementCallback('general_store:server:depositOwnedRegister', body, cb)
end)

RegisterNUICallback('manageUpdateBuyItem', function(body, cb)
    ownedManagementCallback('general_store:server:updateOwnedBuyItem', body, cb)
end)

RegisterNUICallback('manageRemoveBuyItem', function(body, cb)
    ownedManagementCallback('general_store:server:removeOwnedBuyItem', body, cb)
end)

RegisterNUICallback('manageHireStaff', function(body, cb)
    ownedManagementCallback('general_store:server:hireOwnedStaff', body, cb)
end)

RegisterNUICallback('manageFireStaff', function(body, cb)
    ownedManagementCallback('general_store:server:fireOwnedStaff', body, cb)
end)

RegisterNUICallback('worldPreview', function(data, cb)
    if type(data) ~= 'table' or not uiOpen then
        cb({ ok = false })
        return
    end
    local sid = data.storeId
    if type(sid) ~= 'string' or sid ~= currentStoreId then
        cb({ ok = false })
        return
    end
    local item = data.item
    if item == nil or item == false or item == '' then
        GS_ClearDisplayPropOnly()
        TriggerEvent('general_store:client:WorldPreviewClear')
        cb({ ok = true })
        return
    end

    local prop = data.propModel or data.prop
    if type(prop) ~= 'string' or prop == '' then
        GS_ClearDisplayPropOnly()
        TriggerEvent('general_store:client:WorldPreviewClear')
        cb({ ok = true })
        return
    end

    GS_ShowcaseSpawn(sid, prop, data.propType, data.propRotation)

    TriggerEvent(
        'general_store:client:WorldPreviewItem',
        sid,
        item,
        data.label,
        data.price,
        prop,
        data.propType,
        data.propRotation
    )
    cb({ ok = true })
end)

RegisterNUICallback('rotateDisplay', function(data, cb)
    if not uiOpen or type(data) ~= 'table' then
        cb({ ok = false })
        return
    end
    GS_ShowcaseRotate(data.yaw, data.pitch)
    cb({ ok = true })
end)

RegisterNUICallback('refreshBalance', function(body, cb)
    local mt = body and body.moneyType or Config.DefaultMoneyType
    RSGCore.Functions.TriggerCallback('general_store:server:getBalance', function(bal)
        cb({ balance = bal })
    end, mt)
end)

AddEventHandler('general_store:client:WorldPreviewItem', function(
    storeId,
    itemName,
    label,
    price,
    prop,
    propType,
    propRotation
)
    --- Showcase is handled in `worldPreview` NUI callback; keep this event for other resources.
end)

AddEventHandler('general_store:client:WorldPreviewClear', function()
    --- Internal cleanup already ran from NUI; hook only for extensions.
end)

RegisterNetEvent('general_store:client:purchaseResult', function(success, code, newBalance)
    SendNUIMessage({
        action = 'purchaseResult',
        success = success,
        code = code,
        balance = newBalance,
    })
end)

RegisterNetEvent('general_store:client:stockUpdate', function(storeId, stockDelta)
    SendNUIMessage({
        action  = 'stockUpdate',
        storeId = storeId,
        stock   = stockDelta,
    })
end)
