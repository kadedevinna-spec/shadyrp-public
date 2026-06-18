--- In-world shelf pickups: DrawText3D + hold key to buy (optional world props — off by default).

local RSGCore = exports['rsg-core']:GetCoreObject()

local SHELF_POINTS = {}
local SHELF_PROPS = {}
local shelfBusy = false
local shelfHold = { pointId = nil, startMs = nil }
local lastBoughtPoint = nil
local tryBuyShelfItem

local function shelfEnabled()
    return Config.EnableShelfPickups ~= false
end

local function shelfPropsEnabled()
    return shelfEnabled() and Config.EnableShelfProps == true
end

local function shelfTextDist()
    return Config.ShelfDrawTextDistance or 1.15
end

local function shelfBuyDist()
    return Config.ShelfBuyDistance or Config.ShelfDrawTextDistance or 1.25
end

local function shelfPropDrawDist()
    return Config.ShelfPropDrawDistance or 6.0
end

local function shelfStoreRadius()
    return Config.ShelfStoreRadius or 28.0
end

local function shelfBuyKey()
    return Config.ShelfBuyKey or Config.OpenKey or 0x760A9C6F
end

local function shelfHoldDurationMs()
    local ms = tonumber(Config.ShelfHoldDurationMs)
    if not ms or ms < 250 then return 1400 end
    return ms
end

local function resetShelfHold()
    shelfHold.pointId = nil
    shelfHold.startMs = nil
end

local function canBuyFocusedShelf(focused, pcoords, buyDist)
    if GS_IsRobberyActive and GS_IsRobberyActive() then return false end
    if not focused or shelfBusy then return false end
    local pedDist = #(pcoords - focused.coords)
    if pedDist > buyDist then return false end
    local clerkDist = GS_GetNearestClerkDist()
    if clerkDist and clerkDist < (Config.InteractDistance or 2.8) then return false end
    return true
end

--- Returns hold progress 0.0–1.0; triggers purchase when complete.
local function tickShelfHold(focused, canBuy)
    if not canBuy then
        resetShelfHold()
        return 0.0
    end

    local key = shelfBuyKey()
    if IsControlPressed(0, key) then
        if shelfHold.pointId ~= focused.id or not shelfHold.startMs then
            shelfHold.pointId = focused.id
            shelfHold.startMs = GetGameTimer()
        end

        local elapsed = GetGameTimer() - shelfHold.startMs
        local progress = math.min(1.0, elapsed / shelfHoldDurationMs())
        if progress >= 1.0 then
            resetShelfHold()
            tryBuyShelfItem(focused)
            return 1.0
        end
        return progress
    end

    resetShelfHold()
    return 0.0
end

local function shelfLookAtEnabled()
    return Config.ShelfLookAtPick ~= false
end

local function shelfLookDotMin()
    return Config.ShelfLookDotMin or 0.78
end

local function getGameplayCamForward()
    local rot = GetGameplayCamRot(2)
    local pitch = math.rad(rot.x)
    local heading = math.rad(rot.z)
    local cp = math.cos(pitch)
    return vector3(-math.sin(heading) * cp, math.cos(heading) * cp, math.sin(pitch))
end

local function shelfAimPoint(point)
    local c = point.coords
    return vector3(c.x, c.y, c.z + 0.16)
end

--- Pick one shelf in range: gameplay cam look-at (default) or closest if look-at disabled.
local function pickFocusedShelf(candidates, camPos, camFwd, pedCoords, textDist)
    if #candidates == 0 then return nil end
    if #candidates == 1 then return candidates[1] end

    if not shelfLookAtEnabled() then
        local best, bestDist = nil, textDist + 1.0
        for _, point in ipairs(candidates) do
            local dist = #(pedCoords - point.coords)
            if dist < bestDist then
                bestDist = dist
                best = point
            end
        end
        return best
    end

    local minDot = shelfLookDotMin()
    local best, bestDot, bestDist = nil, -1.0, 9999.0

    for _, point in ipairs(candidates) do
        local aim = shelfAimPoint(point)
        local dir = aim - camPos
        local dist = #dir
        if dist > 0.001 then
            dir = vector3(dir.x / dist, dir.y / dist, dir.z / dist)
            local dot = camFwd.x * dir.x + camFwd.y * dir.y + camFwd.z * dir.z
            if dot >= minDot then
                local take = false
                if not best then
                    take = true
                elseif dot > bestDot + 0.012 then
                    take = true
                elseif dot >= bestDot - 0.012 and dist < bestDist then
                    take = true
                end
                if take then
                    best = point
                    bestDot = dot
                    bestDist = dist
                end
            end
        end
    end

    return best
end

local function drawShelfPrompt(point, loc, holdProgress)
    local hint = loc.shelf_buy_hint or 'Hold [G] — %s ($%.2f)'
    local line1 = loc.shelf_buy_title or 'Shelf item'
    local line2 = hint:format(point.label, point.price)
    GS_DrawText3DAtCoords('shelf_' .. point.id, point.coords, point.heading, line1 .. '\n' .. line2, holdProgress or 0.0)
end

local function vec3FromShelf(raw)
    if type(raw) == 'vector3' then return raw end
    if type(raw) == 'vector4' then return vector3(raw.x, raw.y, raw.z) end
    if type(raw) == 'table' and raw.x and raw.y and raw.z then
        return vector3(raw.x + 0.0, raw.y + 0.0, raw.z + 0.0)
    end
    return nil
end

local function shelfHeading(row)
    local shelf = row and row.shelf
    if not shelf then return 0.0 end
    if type(shelf) == 'table' and shelf.heading then return shelf.heading + 0.0 end
    if type(shelf) == 'vector4' then return shelf.w + 0.0 end
    return 0.0
end

local function shelfCoords(row)
    if not row or not row.shelf then return nil end
    local shelf = row.shelf
    if type(shelf) == 'table' and shelf.coords then return vec3FromShelf(shelf.coords) end
    return vec3FromShelf(shelf)
end

local function rowHasValidShelf(row)
    if not row or type(row.item) ~= 'string' or row.item == '' then return false end
    if not row.shelf then return false end
    return shelfCoords(row) ~= nil
end

local function storeCenter(def)
    local npc = def and def.npc and def.npc.coords
    return npc and vector3(npc.x, npc.y, npc.z) or nil
end

local function addShelfPoint(storeId, row, center, shelfSource)
    shelfSource = shelfSource or row
    if not rowHasValidShelf(shelfSource) then return end

    local itemName = tostring(row.item or ''):lower()
    if itemName == '' then return end

    local coords = shelfCoords(shelfSource)
    local defItem = RSGCore.Shared.Items[itemName]
    SHELF_POINTS[#SHELF_POINTS + 1] = {
        id = storeId .. ':' .. itemName,
        storeId = storeId,
        item = itemName,
        price = tonumber(row.price) or 0,
        label = defItem and defItem.label or itemName,
        prop = row.prop or row.propModel or shelfSource.prop or shelfSource.propModel,
        propRotation = row.propRotation or shelfSource.propRotation,
        coords = coords,
        heading = shelfHeading(shelfSource),
        storeCenter = center,
        buyNotify = row.buyNotify,
    }
end

local function nearestOwnedStore(center)
    if not center or not GS_GetClientStores then return nil, nil end
    local bestId, bestDef, bestDist = nil, nil, nil
    for storeId, entry in pairs(GS_GetClientStores() or {}) do
        if entry and entry.owned and entry.def then
            local ownedCenter = storeCenter(entry.def)
            if ownedCenter then
                local dist = #(center - ownedCenter)
                if dist <= shelfStoreRadius() and (not bestDist or dist < bestDist) then
                    bestId, bestDef, bestDist = storeId, entry.def, dist
                end
            end
        end
    end
    return bestId, bestDef
end

local function buildOwnedShelfPoints(ownedStoreId, ownedDef, baseDef, baseCenter)
    local shelfRows = {}
    local byItem = {}
    local byItemIndex = {}
    for _, row in ipairs(baseDef.items or {}) do
        if rowHasValidShelf(row) then
            shelfRows[#shelfRows + 1] = row
            local itemName = tostring(row.item):lower()
            byItem[itemName] = row
            byItemIndex[itemName] = #shelfRows
        end
    end

    local usedSlots = {}
    local fallbackIndex = 1
    for _, row in ipairs(ownedDef.items or {}) do
        if (tonumber(row.stock) or 0) > 0 then
            local itemName = tostring(row.item or ''):lower()
            local slot = byItem[itemName]
            local slotIndex = byItemIndex[itemName]
            if not slot then
                while shelfRows[fallbackIndex] and usedSlots[fallbackIndex] do
                    fallbackIndex = fallbackIndex + 1
                end
                slot = shelfRows[fallbackIndex]
                slotIndex = fallbackIndex
                fallbackIndex = fallbackIndex + 1
            end
            if slot then
                if slotIndex then usedSlots[slotIndex] = true end
                addShelfPoint(ownedStoreId, row, baseCenter, slot)
            end
        end
    end
end

local function loadModel(hash)
    if not hash or hash == 0 then return false end
    RequestModel(hash, false)
    local deadline = GetGameTimer() + 8000
    while not HasModelLoaded(hash) do
        if GetGameTimer() > deadline then return false end
        Wait(10)
    end
    return true
end

local function deleteShelfProp(ent)
    if not ent or ent == 0 or not DoesEntityExist(ent) then return end
    SetEntityAsMissionEntity(ent, true, true)
    DeleteObject(ent)
    Wait(0)
    if DoesEntityExist(ent) then DeleteEntity(ent) end
end

local function spawnShelfProp(point)
    if point.propEntity and DoesEntityExist(point.propEntity) then return end
    if not point.prop or point.prop == '' then return end

    local hash = joaat(point.prop)
    if not loadModel(hash) then return end

    local c = point.coords
    local h = point.heading or 0.0
    local ent = CreateObject(hash, c.x, c.y, c.z, false, false, false, false, false)
    if not ent or ent == 0 then return end

    SetEntityHeading(ent, h)
    local rot = point.propRotation
    if type(rot) == 'table' then
        SetEntityRotation(ent, rot.x or 0.0, rot.y or 0.0, rot.z or h, 2, true)
    end
    FreezeEntityPosition(ent, true)
    SetEntityCollision(ent, false, false)
    SetEntityInvincible(ent, true)

    point.propEntity = ent
    SHELF_PROPS[#SHELF_PROPS + 1] = ent
end

local function despawnShelfProp(point)
    if point.propEntity then
        deleteShelfProp(point.propEntity)
        point.propEntity = nil
    end
end

local function despawnAllShelfProps()
    for _, point in ipairs(SHELF_POINTS) do
        despawnShelfProp(point)
    end
    for _, ent in ipairs(SHELF_PROPS) do
        deleteShelfProp(ent)
    end
    SHELF_PROPS = {}
end

local function buildShelfIndex()
    despawnAllShelfProps()
    SHELF_POINTS = {}
    for storeId, def in pairs(Config.Stores or {}) do
        local center = storeCenter(def)
        local ownedStoreId, ownedDef = nearestOwnedStore(center)

        if ownedStoreId and ownedDef then
            buildOwnedShelfPoints(ownedStoreId, ownedDef, def, center)
        else
            for _, row in ipairs(def.items or {}) do
                if rowHasValidShelf(row) then
                    addShelfPoint(storeId, row, center, row)
                end
            end
        end
    end
end

local function playerInsideStoreZone(pcoords, point)
    if not point.storeCenter then return true end
    return #(pcoords - point.storeCenter) <= shelfStoreRadius()
end

-- ─── Shelf pickup animation + prop in left hand ───────────────────────────────

local function loadAnimDict(dict)
    if HasAnimDictLoaded(dict) then return true end
    RequestAnimDict(dict)
    local deadline = GetGameTimer() + 2000
    while not HasAnimDictLoaded(dict) do
        if GetGameTimer() > deadline then return false end
        Wait(10)
    end
    return true
end

local function loadPropModel(modelHash)
    if HasModelLoaded(modelHash) then return true end
    RequestModel(modelHash, false)
    local deadline = GetGameTimer() + 2000
    while not HasModelLoaded(modelHash) do
        if GetGameTimer() > deadline then return false end
        Wait(10)
    end
    return true
end

-- Returns 'low', 'mid' or 'top' based on (shelfZ - playerFootZ).
-- Thresholds tunable via Config.ShelfAnimThresholds = { low = 0.35, high = 0.80 }
local function shelfHeightTier(shelfZ, playerZ)
    local diff = shelfZ - playerZ
    local t    = Config.ShelfAnimThresholds or {}
    local tLow = t.low  or 0.35
    local tTop = t.high or 0.80
    if diff <= tLow then return 'low'
    elseif diff <= tTop then return 'mid'
    else return 'top' end
end

-- Returns the heading (degrees) the player needs to face to look at shelfPos.
-- GTA/RDR convention: 0=north, 90=west (CCW). Forward = (-sin h, cos h).
-- So H = atan2(-dx, dy).
local function headingToward(from, to)
    return math.deg(math.atan(-(to.x - from.x), to.y - from.y))
end

-- Returns lateral tier 1-4:
--   1 = item is notably to the left  of the player's facing direction
--   2 = item is slightly to the left
--   3 = item is slightly to the right
--   4 = item is notably to the right
-- Uses the heading the player was turned to (not GetEntityForwardVector, avoids 1-frame lag).
local function shelfLateralTier(pedPos, shelfPos, facingHeading)
    local hr     = math.rad(facingHeading)
    -- forward = (-sin h, cos h).  right = rotate forward 90° CW = (cos h, sin h).
    local rightX =  math.cos(hr)
    local rightY =  math.sin(hr)
    local lateral = (shelfPos.x - pedPos.x) * rightX + (shelfPos.y - pedPos.y) * rightY

    local t  = Config.ShelfAnimLateralThresholds or {}
    local tL = t.farLeft  or -0.20   -- more negative → further left
    local tR = t.farRight or  0.20   -- more positive → further right
    if lateral < tL  then return 1
    elseif lateral < 0.0 then return 2
    elseif lateral < tR  then return 3
    else return 4 end
end

local function playShelfPickupWithProp(point)
    CreateThread(function()
        local ped     = PlayerPedId()
        local pedPos  = GetEntityCoords(ped)

        -- 1. Turn player to face the shelf item.
        local targetHeading = headingToward(pedPos, point.coords)
        SetEntityHeading(ped, targetHeading)
        Wait(0)   -- one frame so the engine registers the new heading

        -- 2. Select animation (height tier × lateral tier → dict @{low|mid|top}{1-4}).
        local heightTier  = shelfHeightTier(point.coords.z, pedPos.z)
        local lateralTier = shelfLateralTier(pedPos, point.coords, targetHeading)
        local animDict    = ('mech_inspection@store_shelf@%s%d'):format(heightTier, lateralTier)
        local animClip    = 'enter'
        local duration    = Config.ShelfAnimDuration or 1700

        if not loadAnimDict(animDict) then
            -- fallback to mid2 if the selected dict didn't load
            animDict = 'mech_inspection@store_shelf@mid2'
            if not loadAnimDict(animDict) then return end
        end

        -- 3. Pre-load the prop model so there's no stutter when attaching mid-animation.
        local propHash = nil
        local propKey  = point.prop
        if type(propKey) == 'string' and propKey ~= '' then
            local h = joaat(propKey)
            if loadPropModel(h) then propHash = h end
        end

        -- 4. Start animation immediately (prop not attached yet).
        TaskPlayAnim(ped, animDict, animClip, 8.0, -4.0, duration, 0, 0.0, false, false, false)
        RemoveAnimDict(animDict)

        -- 5. Wait until hand reaches the shelf (~40 % into the clip), then attach prop.
        local attachDelay = Config.ShelfPropAttachDelay or math.floor(duration * 0.40)
        Wait(attachDelay)

        local propEnt = nil
        if propHash then
            propEnt = CreateObject(propHash, pedPos.x, pedPos.y, pedPos.z + 0.5,
                                   false, false, false, false, false)
            if propEnt and propEnt ~= 0 then
                SetEntityCollision(propEnt, false, false)
                SetEntityInvincible(propEnt, true)
                local boneIdx = GetEntityBoneIndexByName(ped, 'PH_L_Hand')
                if boneIdx == -1 then
                    boneIdx = GetEntityBoneIndexByName(ped, 'SKEL_L_Finger00')
                end
                if boneIdx ~= -1 then
                    AttachEntityToEntity(
                        propEnt, ped, boneIdx,
                        0.0, 0.0, 0.0,
                        0.0, 0.0, 0.0,
                        false, false, false, false, 2, true
                    )
                end
            end
        end

        -- 6. Wait the rest of the animation then clean up.
        Wait(duration - attachDelay + 120)
        if propEnt and DoesEntityExist(propEnt) then
            DetachEntity(propEnt, true, false)
            SetEntityAsMissionEntity(propEnt, true, true)
            DeleteObject(propEnt)
            Wait(0)
            if DoesEntityExist(propEnt) then DeleteEntity(propEnt) end
        end
    end)
end

local function releaseShelfBusy()
    shelfBusy = false
    resetShelfHold()
end

tryBuyShelfItem = function(point)
    if shelfBusy then return end
    shelfBusy = true
    lastBoughtPoint = point

    TriggerServerEvent('general_store:server:buyShelfItem', point.storeId, point.item)

    if Config.ShelfPickupAnim ~= false then
        playShelfPickupWithProp(point)
    end

    SetTimeout(400, function()
        if shelfBusy then releaseShelfBusy() end
    end)
end

CreateThread(function()
    Wait(500)
    if shelfEnabled() then
        buildShelfIndex()
    end
    if not shelfPropsEnabled() then
        despawnAllShelfProps()
    end
end)

RegisterNetEvent('general_store:client:ownedStoreUpsert', function()
    SetTimeout(300, function()
        if shelfEnabled() then buildShelfIndex() end
        if not shelfPropsEnabled() then despawnAllShelfProps() end
    end)
end)

AddEventHandler('onResourceStop', function(res)
    if res ~= GetCurrentResourceName() then return end
    despawnAllShelfProps()
    SHELF_POINTS = {}
end)

CreateThread(function()
    local loc = Config.Locale or {}
    local wasNearby = {}
    local fadingOut = {}
    local spawnedProps = {}

    while true do
        local sleep = 800

        if shelfEnabled() and not GS_IsStoreUiOpen() and #SHELF_POINTS > 0 then
            if GS_IsRobberyActive and GS_IsRobberyActive() then
                resetShelfHold()
                sleep = 250
            else
            local ped = PlayerPedId()
            local pcoords = GetEntityCoords(ped)
            local camPos = GetGameplayCamCoord()
            local camFwd = getGameplayCamForward()
            local textDist = shelfTextDist()
            local buyDist = shelfBuyDist()
            local propDist = shelfPropDrawDist()
            local textCandidates = {}
            local focused = nil

            for _, point in ipairs(SHELF_POINTS) do
                if playerInsideStoreZone(pcoords, point) then
                    local dist = #(pcoords - point.coords)

                    if shelfPropsEnabled() and dist < propDist then
                        sleep = 0
                        if not spawnedProps[point.id] then
                            spawnShelfProp(point)
                            spawnedProps[point.id] = true
                        end
                    elseif spawnedProps[point.id] then
                        despawnShelfProp(point)
                        spawnedProps[point.id] = nil
                    end

                    if dist < textDist then
                        sleep = 0
                        textCandidates[#textCandidates + 1] = point
                    end
                elseif spawnedProps[point.id] then
                    despawnShelfProp(point)
                    spawnedProps[point.id] = nil
                    if wasNearby[point.id] then
                        GS_StartDrawTextExit('shelf_' .. point.id)
                        fadingOut[point.id] = point
                        wasNearby[point.id] = false
                    else
                        fadingOut[point.id] = nil
                    end
                end
            end

            focused = pickFocusedShelf(textCandidates, camPos, camFwd, pcoords, textDist)

            local shelfHoldProgress = 0.0
            if focused then
                local canBuy = canBuyFocusedShelf(focused, pcoords, buyDist)
                shelfHoldProgress = tickShelfHold(focused, canBuy)
            else
                resetShelfHold()
            end

            for _, point in ipairs(SHELF_POINTS) do
                local animId = 'shelf_' .. point.id
                local isFocused = focused and focused.id == point.id
                local pointHold = isFocused and shelfHoldProgress or 0.0

                if isFocused then
                    if not wasNearby[point.id] then
                        GS_EnsureDrawTextEnter(animId)
                        fadingOut[point.id] = nil
                    end
                    drawShelfPrompt(point, loc, pointHold)
                    wasNearby[point.id] = true
                elseif wasNearby[point.id] then
                    GS_StartDrawTextExit(animId)
                    fadingOut[point.id] = point
                    wasNearby[point.id] = false
                end

                if fadingOut[point.id] and not isFocused then
                    drawShelfPrompt(fadingOut[point.id], loc, 0.0)
                    if not GS_IsDrawTextActive(animId) then
                        fadingOut[point.id] = nil
                    end
                end
            end
            end
        elseif not shelfEnabled() then
            resetShelfHold()
            despawnAllShelfProps()
            spawnedProps = {}
            wasNearby = {}
            fadingOut = {}
        end

        Wait(sleep)
    end
end)

RegisterNetEvent('general_store:client:shelfPurchaseResult', function(success, code, newBalance, label)
    local loc   = Config.Locale or {}
    local point = lastBoughtPoint
    releaseShelfBusy()

    if success then
        local successMsg
        if point and point.buyNotify == false then
            -- explicit false = silent
        elseif point and type(point.buyNotify) == 'string' and point.buyNotify ~= '' then
            successMsg = point.buyNotify
        else
            successMsg = label or 'Item'
        end

        if successMsg then
            SendNUIMessage({
                action    = 'toast',
                toastType = 'success',
                title     = loc.shelf_success_title or 'Item purchased',
                msg       = successMsg,
                duration  = 3500,
            })
        end

        if GS_IsStoreUiOpen() and type(newBalance) == 'number' then
            SendNUIMessage({ action = 'purchaseResult', success = true, balance = newBalance })
        end
    else
        local errorMap = {
            no_money     = loc.shelf_no_money       or 'Insufficient funds.',
            inventory    = loc.shelf_inventory_full  or 'Not enough inventory space or weight.',
            not_for_sale = loc.shelf_not_for_sale    or 'Item not sold here.',
            unknown_item = loc.shelf_unknown_item    or 'Unknown item.',
            unavailable  = loc.shelf_unavailable     or 'Store unavailable.',
            pay_failed   = loc.shelf_pay_failed      or 'Payment failed.',
            give_failed  = loc.shelf_give_failed     or 'Could not grant item — refunded.',
        }
        local msg = errorMap[code] or loc.shelf_fail_generic or 'Purchase failed.'
        SendNUIMessage({
            action    = 'toast',
            toastType = 'error',
            title     = loc.shelf_fail_title or 'Purchase failed',
            msg       = msg,
            duration  = 4200,
        })
    end
end)
