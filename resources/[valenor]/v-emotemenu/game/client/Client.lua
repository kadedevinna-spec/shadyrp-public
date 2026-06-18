local currentNotificationRequester = nil
isInAnimation = false
currentAnimationData = nil
local maxDistance = Config.MaxDistance or 0.60
local originalPos = nil
local animPos = false
local attachedProps = {}
local attachedPropMeta = {}
local remotePropsByPlayer = {}
local remoteFrozenPlayers = {}
local BroadcastAllProps
local BroadcastWorldProps
local MoveWorldPropsByDelta
local RotateWorldPropsByDelta

local function VecToTable(vec)
    if not vec then return nil end
    return { x = vec.x + 0.0, y = vec.y + 0.0, z = vec.z + 0.0 }
end

local function TableToVector(tbl)
    if not tbl then return nil end
    return vector3(tbl.x or 0.0, tbl.y or 0.0, tbl.z or 0.0)
end

local function RotateOffsetByHeading(offset, heading)
    local rad = math.rad(heading or 0.0)
    local sinHeading = math.sin(rad)
    local cosHeading = math.cos(rad)

    local offX = offset.x or 0.0
    local offY = offset.y or 0.0
    local offZ = offset.z or 0.0

    local rotatedX = offX * cosHeading - offY * sinHeading
    local rotatedY = offX * sinHeading + offY * cosHeading

    return vector3(rotatedX, rotatedY, offZ)
end

local function EnsureEntityControl(entity)
    if not entity or entity == 0 or not DoesEntityExist(entity) then return false end
    if NetworkHasControlOfEntity(entity) then return true end

    local netId = NetworkGetNetworkIdFromEntity(entity)
    if netId and netId ~= 0 and SetNetworkIdCanMigrate then
        SetNetworkIdCanMigrate(netId, true)
    end

    local attempts = 0
    NetworkRequestControlOfEntity(entity)
    while attempts < 25 and not NetworkHasControlOfEntity(entity) do
        Citizen.Wait(0)
        NetworkRequestControlOfEntity(entity)
        attempts = attempts + 1
    end

    return NetworkHasControlOfEntity(entity)
end

function ClearAnimationProps(skipNetwork)
    if not attachedProps then
        attachedProps = {}
        return
    end

    local hadProps = false

    for _, prop in ipairs(attachedProps) do
        hadProps = true
        if DoesEntityExist(prop) then
            SetEntityAsMissionEntity(prop, true, true)
            DetachEntity(prop, true, true)
            DeleteObject(prop)
        end
        attachedPropMeta[prop] = nil
    end

    attachedProps = {}
    attachedPropMeta = {}

    if hadProps and not skipNetwork then
        TriggerServerEvent("v-emotemenu:server:clearProps")
    end
end

function AttachAnimationProps(animationData, attachToPed)
    ClearAnimationProps()

    if attachToPed == nil then
        attachToPed = true
    end

    if not animationData then return end

    local propOptions = animationData.propOptions
    if not propOptions and animationData.propOption then
        propOptions = { animationData.propOption }
    end

    if not propOptions then return end

    local playerPed = PlayerPedId()
    local createdProps = {}

    for _, option in pairs(propOptions) do
        if option then
            local propName = option.propName
            if propName and propName ~= "" then
                local propHash = GetHashKey(propName)
                if not IsModelValid(propHash) then
                    goto continue
                end

                RequestModel(propHash)
                local attempts = 0
                while not HasModelLoaded(propHash) and attempts < 100 do
                    Citizen.Wait(10)
                    attempts = attempts + 1
                    RequestModel(propHash)
                end

                if not HasModelLoaded(propHash) then
                    goto continue
                end

                local propEntity = CreateObject(propHash, 0.0, 0.0, 0.0, false, true, true)
                if propEntity and propEntity ~= 0 then
                    local boneIndex = option.propBone or 60309
                    local position = option.propPosition or vector3(0.0, 0.0, 0.0)
                    local rotation = option.propRotation or vector3(0.0, 0.0, 0.0)

                    if attachToPed then
                        AttachEntityToEntity(
                            propEntity,
                            playerPed,
                            GetPedBoneIndex(playerPed, boneIndex),
                            position.x, position.y, position.z,
                            rotation.x, rotation.y, rotation.z,
                            true, true, false, true, 1, true
                        )

                        table.insert(createdProps, {
                            entity = propEntity,
                            option = option,
                            position = nil,
                            heading = nil
                        })
                        attachedPropMeta[propEntity] = {
                            attachToPed = true,
                            option = option
                        }
                    else
                        local pedCoords = GetEntityCoords(playerPed)
                        local pedHeading = GetEntityHeading(playerPed)
                        local rotatedOffset = RotateOffsetByHeading(position, pedHeading)
                        local worldPos = vector3(
                            pedCoords.x + rotatedOffset.x,
                            pedCoords.y + rotatedOffset.y,
                            pedCoords.z + rotatedOffset.z
                        )

                        SetEntityCoordsNoOffset(propEntity, worldPos.x, worldPos.y, worldPos.z, false, false, false)
                        SetEntityRotation(propEntity, rotation.x or 0.0, rotation.y or 0.0, pedHeading + (rotation.z or 0.0), 2, true)
                        if option.placeOnGround ~= false then
                            PlaceObjectOnGroundProperly(propEntity)
                        end
                        FreezeEntityPosition(propEntity, true)

                        local finalPos = GetEntityCoords(propEntity)
                        local finalHeading = GetEntityHeading(propEntity)

                        table.insert(createdProps, {
                            entity = propEntity,
                            option = option,
                            position = finalPos,
                            heading = finalHeading
                        })
                        attachedPropMeta[propEntity] = {
                            attachToPed = false,
                            option = option,
                            worldPosition = finalPos,
                            heading = finalHeading
                        }
                    end

                    table.insert(attachedProps, propEntity)
                end

                SetModelAsNoLongerNeeded(propHash)
            end
        end
        ::continue::
    end

    if next(attachedPropMeta) ~= nil then
        BroadcastAllProps()
    end

    return createdProps
end

BroadcastAllProps = function()
    local pedProps = {}
    local worldProps = {}

    for prop, meta in pairs(attachedPropMeta) do
        if meta and DoesEntityExist(prop) then
            local option = meta.option or {}
            local entry = {
                propName = option.propName or "",
                propBone = option.propBone or 60309,
                propPosition = VecToTable(option.propPosition or vector3(0.0, 0.0, 0.0)),
                propRotation = VecToTable(option.propRotation or vector3(0.0, 0.0, 0.0)),
                placeOnGround = option.placeOnGround ~= false,
                worldPosition = VecToTable(meta.worldPosition),
                heading = meta.heading or 0.0
            }

            if meta.attachToPed then
                table.insert(pedProps, entry)
            else
                table.insert(worldProps, entry)
            end
        end
    end

    if #pedProps == 0 and #worldProps == 0 then
        TriggerServerEvent("v-emotemenu:server:clearProps")
        return
    end

    TriggerServerEvent("v-emotemenu:server:syncProps", {
        pedProps = pedProps,
        worldProps = worldProps
    })
end

local function ForEachWorldProp(cb)
    for prop, meta in pairs(attachedPropMeta) do
        if meta and meta.attachToPed == false and DoesEntityExist(prop) then
            cb(prop, meta)
        end
    end
end

BroadcastWorldProps = function()
    local worldProps = {}

    ForEachWorldProp(function(prop, meta)
        local option = meta.option or {}
        table.insert(worldProps, {
            propName = option.propName or "",
            propBone = option.propBone or 60309,
            propPosition = VecToTable(option.propPosition or vector3(0.0, 0.0, 0.0)),
            propRotation = VecToTable(option.propRotation or vector3(0.0, 0.0, 0.0)),
            worldPosition = VecToTable(meta.worldPosition or GetEntityCoords(prop)),
            heading = meta.heading or GetEntityHeading(prop),
            placeOnGround = option.placeOnGround ~= false
        })
    end)

    if #worldProps > 0 then
        TriggerServerEvent("v-emotemenu:server:updateWorldProps", worldProps)
    end
end

MoveWorldPropsByDelta = function(delta)
    if not delta then return end
    if math.abs(delta.x) < 0.0001 and math.abs(delta.y) < 0.0001 and math.abs(delta.z) < 0.0001 then return end

    local moved = false

    ForEachWorldProp(function(prop, meta)
        FreezeEntityPosition(prop, false)
        local coords = GetEntityCoords(prop)
        local newPos = vector3(coords.x + delta.x, coords.y + delta.y, coords.z + delta.z)
        SetEntityCoordsNoOffset(prop, newPos.x, newPos.y, newPos.z, false, false, false)
        FreezeEntityPosition(prop, true)
        meta.worldPosition = newPos
        moved = true
    end)

    if moved then
        BroadcastWorldProps()
    end
end

RotateWorldPropsByDelta = function(deltaHeading, pivot)
    if not deltaHeading or math.abs(deltaHeading) < 0.0001 then return end
    pivot = pivot or GetEntityCoords(PlayerPedId())

    local rad = math.rad(deltaHeading)
    local sinH = math.sin(rad)
    local cosH = math.cos(rad)
    local rotated = false

    ForEachWorldProp(function(prop, meta)
        FreezeEntityPosition(prop, false)
        local coords = GetEntityCoords(prop)
        local dx = coords.x - pivot.x
        local dy = coords.y - pivot.y
        local newX = pivot.x + (dx * cosH - dy * sinH)
        local newY = pivot.y + (dx * sinH + dy * cosH)
        SetEntityCoordsNoOffset(prop, newX, newY, coords.z, false, false, false)
        local newHeading = GetEntityHeading(prop) + deltaHeading
        SetEntityHeading(prop, newHeading)
        FreezeEntityPosition(prop, true)
        meta.worldPosition = vector3(newX, newY, coords.z)
        meta.heading = newHeading
        rotated = true
    end)

    if rotated then
        BroadcastWorldProps()
    end
end

local function UpdatePlayerPositionSmooth(playerPed, x, y, z)
    SetEntityCoordsNoOffset(playerPed, x, y, z, true, true)
end

local function UpdatePlayerHeadingSmooth(playerPed, heading)
    SetEntityHeading(playerPed, heading)
end

local function GetScenarioBaseTransform()
    for prop, meta in pairs(attachedPropMeta) do
        if meta and meta.attachToPed == false and DoesEntityExist(prop) then
            return meta.worldPosition or GetEntityCoords(prop), meta.heading or GetEntityHeading(prop)
        end
    end
    return nil, nil
end

local function RefreshScenarioIfActive(playerPed, coords, heading)
    local animData = currentAnimationData and currentAnimationData.data
    if not animData or not animData.scenario then return end

    local scenario = animData.scenario
    local scenarioHash = scenario
    if type(scenario) == "string" then
        scenarioHash = GetHashKey(scenario)
    end

    local headingOffset = animData.scenarioHeadingOffset or 0.0
    local seatOffset = animData.scenarioSeatOffset or vector3(0.0, 0.0, 0.0)

    local basePos, baseHeading = GetScenarioBaseTransform()
    if not basePos then
        basePos = coords
        baseHeading = heading
    end

    local scenarioHeading = baseHeading + headingOffset
    local seatWorldOffset = RotateOffsetByHeading(seatOffset, scenarioHeading)
    local scenarioPos = vector3(
        basePos.x + seatWorldOffset.x,
        basePos.y + seatWorldOffset.y,
        basePos.z + seatWorldOffset.z
    )

    ClearPedTasksImmediately(playerPed)
    TaskStartScenarioAtPosition(
        playerPed,
        scenarioHash,
        scenarioPos.x,
        scenarioPos.y,
        scenarioPos.z,
        scenarioHeading,
        -1,
        false,
        true
    )
    SetPedKeepTask(playerPed, true)
end

local function ClearRemoteWorldProps(sourceId)
    local entry = remotePropsByPlayer[sourceId]
    if not entry or not entry.world then return end
    for _, prop in ipairs(entry.world) do
        if DoesEntityExist(prop) then
            SetEntityAsMissionEntity(prop, true, true)
            DeleteObject(prop)
        end
    end
    entry.world = {}
end

local function ClearRemotePedProps(sourceId)
    local entry = remotePropsByPlayer[sourceId]
    if not entry or not entry.ped then return end
    for _, prop in ipairs(entry.ped) do
        if DoesEntityExist(prop) then
            SetEntityAsMissionEntity(prop, true, true)
            DeleteObject(prop)
        end
    end
    entry.ped = {}
end

local function ClearRemotePropsForSource(sourceId)
    local entry = remotePropsByPlayer[sourceId]
    if not entry then return end
    ClearRemoteWorldProps(sourceId)
    ClearRemotePedProps(sourceId)
    remotePropsByPlayer[sourceId] = nil
end

local function GetOrCreateRemoteEntry(sourceId)
    local entry = remotePropsByPlayer[sourceId]
    if not entry then
        entry = { ped = {}, world = {} }
        remotePropsByPlayer[sourceId] = entry
    end
    return entry
end

local function SpawnRemotePedProps(sourceId, ped, pedProps)
    if not pedProps or #pedProps == 0 then
        ClearRemotePedProps(sourceId)
        return
    end

    ClearRemotePedProps(sourceId)
    local entry = GetOrCreateRemoteEntry(sourceId)

    for _, propData in ipairs(pedProps) do
        local propName = propData.propName
        if propName and propName ~= "" then
            local propHash = GetHashKey(propName)
            if IsModelValid(propHash) then
                RequestModel(propHash)
                local attempts = 0
                while not HasModelLoaded(propHash) and attempts < 100 do
                    Citizen.Wait(10)
                    attempts = attempts + 1
                    RequestModel(propHash)
                end

                if HasModelLoaded(propHash) then
                    local obj = CreateObject(propHash, 0.0, 0.0, 0.0, false, true, true)
                    if obj and obj ~= 0 then
                        local offset = TableToVector(propData.propPosition) or vector3(0.0, 0.0, 0.0)
                        local rotation = TableToVector(propData.propRotation) or vector3(0.0, 0.0, 0.0)
                        AttachEntityToEntity(
                            obj,
                            ped,
                            GetPedBoneIndex(ped, propData.propBone or 60309),
                            offset.x, offset.y, offset.z,
                            rotation.x, rotation.y, rotation.z,
                            true, true, false, true, 1, true
                        )
                        table.insert(entry.ped, obj)
                    end
                    SetModelAsNoLongerNeeded(propHash)
                end
            end
        end
    end
end

local function SpawnRemoteWorldProps(sourceId, ped, worldProps)
    if not worldProps or #worldProps == 0 then
        ClearRemoteWorldProps(sourceId)
        return
    end

    ClearRemoteWorldProps(sourceId)
    local entry = GetOrCreateRemoteEntry(sourceId)

    for _, propData in ipairs(worldProps) do
        local propName = propData.propName
        if propName and propName ~= "" then
            local propHash = GetHashKey(propName)
            if IsModelValid(propHash) then
                RequestModel(propHash)
                local attempts = 0
                while not HasModelLoaded(propHash) and attempts < 100 do
                    Citizen.Wait(10)
                    attempts = attempts + 1
                    RequestModel(propHash)
                end

                if HasModelLoaded(propHash) then
                    local obj = CreateObject(propHash, 0.0, 0.0, 0.0, false, true, true)
                    if obj and obj ~= 0 then
                        local worldPos = TableToVector(propData.worldPosition) or GetEntityCoords(ped)
                        local rotation = TableToVector(propData.propRotation) or vector3(0.0, 0.0, 0.0)
                        SetEntityCoordsNoOffset(obj, worldPos.x, worldPos.y, worldPos.z, false, false, false)
                        SetEntityRotation(obj, rotation.x or 0.0, rotation.y or 0.0, propData.heading or 0.0, 2, true)
                        if propData.placeOnGround ~= false then
                            PlaceObjectOnGroundProperly(obj)
                        end
                        FreezeEntityPosition(obj, true)
                        table.insert(entry.world, obj)
                    end
                    SetModelAsNoLongerNeeded(propHash)
                end
            end
        end
    end
end

local function SpawnRemotePropsForSource(sourceId, ped, payload)
    if not payload then return end
    SpawnRemotePedProps(sourceId, ped, payload.pedProps)
    SpawnRemoteWorldProps(sourceId, ped, payload.worldProps)
end

RegisterNetEvent("v-emotemenu:client:syncProps", function(sourceId, payload)
    if sourceId == GetPlayerServerId(PlayerId()) then return end
    if not payload then
        ClearRemotePropsForSource(sourceId)
        return
    end

    Citizen.CreateThread(function()
        local attempts = 0
        while attempts < 30 do
            local targetPlayer = GetPlayerFromServerId(sourceId)
            if targetPlayer ~= -1 then
                local targetPed = GetPlayerPed(targetPlayer)
                if targetPed and targetPed ~= 0 then
                    SpawnRemotePropsForSource(sourceId, targetPed, payload)
                    return
                end
            end
            attempts = attempts + 1
            Citizen.Wait(100)
        end
    end)
end)

RegisterNetEvent("v-emotemenu:client:clearProps", function(sourceId)
    if sourceId == GetPlayerServerId(PlayerId()) then return end
    ClearRemotePropsForSource(sourceId)
end)

RegisterNetEvent("v-emotemenu:client:updateWorldProps", function(sourceId, worldProps)
    if sourceId == GetPlayerServerId(PlayerId()) then return end
    if not worldProps then return end

    Citizen.CreateThread(function()
        local attempts = 0
        while attempts < 30 do
            local targetPlayer = GetPlayerFromServerId(sourceId)
            if targetPlayer ~= -1 then
                local targetPed = GetPlayerPed(targetPlayer)
                if targetPed and targetPed ~= 0 then
                    if #worldProps == 0 then
                        ClearRemoteWorldProps(sourceId)
                    else
                        SpawnRemoteWorldProps(sourceId, targetPed, worldProps)
                    end
                    return
                end
            end
            attempts = attempts + 1
            Citizen.Wait(100)
        end
    end)
end)

function PlayScenarioAnimation(animationData)
    if not animationData or not animationData.scenario then return end

    local playerPed = PlayerPedId()
    ClearPedTasks(playerPed)
    ClearPedSecondaryTask(playerPed)

    local createdProps = AttachAnimationProps(animationData, false) or {}
    local targetPosition = GetEntityCoords(playerPed)
    local targetHeading = GetEntityHeading(playerPed)

    if #createdProps > 0 then
        local primaryProp = createdProps[1]
        if primaryProp.position then
            targetPosition = primaryProp.position
        end
        if primaryProp.heading then
            targetHeading = primaryProp.heading
        end
    end

    local scenarioHeadingOffset = animationData.scenarioHeadingOffset or 0.0
    local scenarioHeading = targetHeading + scenarioHeadingOffset
    local seatOffset = animationData.scenarioSeatOffset or vector3(0.0, 0.0, 0.0)
    local seatWorldOffset = RotateOffsetByHeading(seatOffset, scenarioHeading)
    targetPosition = vector3(
        targetPosition.x + seatWorldOffset.x,
        targetPosition.y + seatWorldOffset.y,
        targetPosition.z + seatWorldOffset.z
    )

    local scenario = animationData.scenario
    local scenarioHash = scenario
    if type(scenario) == "string" then
        scenarioHash = GetHashKey(scenario)
    end

    TaskStartScenarioAtPosition(
        playerPed,
        scenarioHash,
        targetPosition.x,
        targetPosition.y,
        targetPosition.z,
        scenarioHeading,
        -1,
        false,
        true
    )

    SetPedKeepTask(playerPed, true)
end

function _awaitShapeResult(handle)
    local retval, hit, endCoords, surfaceNormal, entityHit = GetShapeTestResult(handle)
    while retval == 1 do
        Wait(0)
        retval, hit, endCoords, surfaceNormal, entityHit = GetShapeTestResult(handle)
    end
    return hit == 1, endCoords, surfaceNormal, entityHit
end
function IsSpotBlockedByMap(ped, pos)
    local z = pos.z + 1           
    local r = 0.15                
    local half = 0.15                 

    local offsets = {
        vector3( half, 0.0, 0.0),
        vector3(-half, 0.0, 0.0),
        vector3( 0.0,  half, 0.0),
        vector3( 0.0, -half, 0.0),
    }

    for _, off in ipairs(offsets) do
        local p1 = vector3(pos.x - off.x, pos.y - off.y, z)
        local p2 = vector3(pos.x + off.x, pos.y + off.y, z)
        local handle = StartShapeTestCapsule(p1.x, p1.y, p1.z, p2.x, p2.y, p2.z, r, 511, ped, 7)
        local hit = _awaitShapeResult(handle)
        if hit then return true end
    end

    local from = GetEntityCoords(ped)
    local handle = StartShapeTestLosProbe(from.x, from.y, from.z + 1, pos.x, pos.y, pos.z + 1, 511, ped, 7)
    local hit = _awaitShapeResult(handle)
    if hit then return true end

    return false
end
RegisterNetEvent("v-emotemenu:client:syncPlayer", function(target, coords, heading, alpha, isFrozen)
    local targetId = GetPlayerFromServerId(target)
    local targetPed = GetPlayerPed(targetId)
    if targetId ~= nil and targetId ~= -1 and targetPed ~= nil and PlayerPedId() ~= targetPed then
        if EnsureEntityControl(targetPed) then
            SetEntityCoordsNoOffset(targetPed, coords.x, coords.y, coords.z, true, true)
            SetEntityHeading(targetPed, heading)
            if isFrozen then
                FreezeEntityPosition(targetPed, true)
                remoteFrozenPlayers[targetPed] = true
            else
                FreezeEntityPosition(targetPed, false)
                remoteFrozenPlayers[targetPed] = nil
            end
        end
        if alpha == 0 then
            ResetEntityAlpha(targetPed)
        else
            SetEntityAlpha(targetPed, alpha)
        end
    end
end)

RegisterCommand('emotemenu', function()
    SendNUIMessage({
        action = "OPEN_MENU",
        Animations = {
            {label = "Emotes", value = Valenor.Emotes},
            {label = "Expressions", value = Valenor.Expressions},
            {label = "Walks", value = Valenor.Walks},
            {label = "Dances", value = Valenor.Dances},
            {label = "Props", value = Valenor.Props},
        },
        LoveCategories = {
            {label = "Dance", value = Valenor.Love.Dance},
            {label = "Romance", value = Valenor.Love.Love},
            {label = "Erotic", value = Valenor.Love.Erotic},
        }
    })
    SetNuiFocus(true, true)
end)

RegisterCommand('e', function(source, args, rawCommand)
    if #args == 0 then return end
    
    local animationName = args[1]
    
    local animationData = nil
    local category = nil
    
    if Valenor.Expressions[animationName] then
        animationData = Valenor.Expressions[animationName]
        category = "Expressions"
    elseif Valenor.Emotes[animationName] then
        animationData = Valenor.Emotes[animationName]
        category = "Emotes"
    elseif Valenor.Walks[animationName] then
        animationData = Valenor.Walks[animationName]
        category = "Walks"
    elseif Valenor.Dances[animationName] then
        animationData = Valenor.Dances[animationName]
        category = "Dances"
    elseif Valenor.Props[animationName] then
        animationData = Valenor.Props[animationName]
        category = "Props"
    elseif Valenor.Love and Valenor.Love.Love and Valenor.Love.Love[animationName] then
        animationData = Valenor.Love.Love[animationName]
        category = "Love"
    elseif Valenor.Love and Valenor.Love.Erotic and Valenor.Love.Erotic[animationName] then
        animationData = Valenor.Love.Erotic[animationName]
        category = "Erotic"
    elseif Valenor.Love and Valenor.Love.Dance and Valenor.Love.Dance[animationName] then
        animationData = Valenor.Love.Dance[animationName]
        category = "Dance"
    end
    
    if animationData and category then
        TriggerServerEvent('v-emotemenu:server:playEmote', animationData)
        PlayAnimation(category, animationName, animationData)
    end
end, false)

RegisterCommand('stopanim', function()
    local playerPed = PlayerPedId()
    ResetEntityAlpha(playerPed)
    TriggerServerEvent("v-emotemenu:server:syncPlayer", GetEntityCoords(playerPed), GetEntityHeading(playerPed), 0, false)
    ClearAnimationProps()
    TriggerEvent('v-emotemenu:client:restoreCoupleCollision')
    ClearPedTasks(playerPed)
    ClearPedSecondaryTask(playerPed)
    Citizen.InvokeNative(0x0FEE4F80AC44A726, playerPed, true)
    isInAnimation = false
    animPos = false
    SendNUIMessage({action = "hideUI"})
end, false)

RegisterNUICallback('closeMenu', function(data, cb)
    ClonePreviewStop()
    SetNuiFocus(false, false)
    cb('ok')
end)

RegisterNUICallback('playAnimation', function(data, cb)
    local category = data.category
    local animationKey = data.animationKey
    local animationData = data.animationData
    currentAnimationData = {
        category = category,
        key = animationKey,
        data = animationData
    }
    
    PlayAnimation(category, animationKey, animationData)
    isInAnimation = true
    cb('ok')
end)

function PlayAnimation(category, animationKey, animationData)
    if animationData and animationData.scenario then
        PlayScenarioAnimation(animationData)
        return
    end

    if category == "Expressions" then
        PlayExpressionAnimation(category, animationKey, animationData)
    elseif category == "Walks" then
        PlayWalkAnimation(category, animationKey, animationData)
    elseif  category == "Erotic" or category == "Love" or category == "Dance" or category == "Romance" then
        PlayCoupleAnimation(category, animationKey, animationData)
    else
        PlayEmoteAnimation(category, animationKey, animationData)
    end

    AttachAnimationProps(animationData, true)
end

RegisterNUICallback('toggleLoveMenu', function(data, cb)
    local showLove = data.showLove
    
    if showLove then
        SendNUIMessage({
            action = "SHOW_LOVE_MENU",
            LoveCategories = {
                {label = "Dance", value = Valenor.Love.Dance},
                {label = "Romance", value = Valenor.Love.Love},
                {label = "Erotic", value = Valenor.Love.Erotic},
            }
        })
    else
        SendNUIMessage({
            action = "SHOW_MAIN_MENU",
            Animations = {
                {label = "Emotes", value = Valenor.Emotes},
                {label = "Expressions", value = Valenor.Expressions},
                {label = "Walks", value = Valenor.Walks},
                {label = "Dances", value = Valenor.Dances},
                {label = "Props", value = Valenor.Props},
            }
        })
    end
    
    cb('ok')
end)

Citizen.CreateThread(function()
    local function CancelActiveAnimation()
        local playerPed = PlayerPedId()
        if not playerPed or playerPed == 0 then return end

        ResetEntityAlpha(playerPed)
        TriggerServerEvent(
            "v-emotemenu:server:syncPlayer",
            GetEntityCoords(playerPed),
            GetEntityHeading(playerPed),
            0,
            false
        )
        ClearAnimationProps()
        TriggerEvent('v-emotemenu:client:restoreCoupleCollision')
        ClearPedTasks(playerPed)
        ClearPedSecondaryTask(playerPed)
        FreezeEntityPosition(playerPed, false)
        SetEntityCollision(playerPed, true, true)
        SetPedCanRagdoll(playerPed, true)
        Citizen.InvokeNative(0x0FEE4F80AC44A726, playerPed, true)
        isInAnimation = false
    end
    while true do
        if IsControlJustPressed(0, Config.Keybinds["HANDSUP_CANCEL_ANIM"]) then
            local wasHandsUp = IsHandsUpActive and IsHandsUpActive() or false
            CancelActiveAnimation()
            if Config.HandsUp then
                if RaiseHands and LowerHands then
                    if wasHandsUp then
                        LowerHands()
                    else
                        RaiseHands()
                    end
                end
            end
        end
        Citizen.Wait(0)
    end
end)

function disableControls()
    DisableAllControlActions(0)
    EnableControlAction(0, 0xD2047988, true)
    EnableControlAction(0, 0xA987235F, true)
    EnableControlAction(0, 0x156F7119, true)
end

local function GetEntityFrozenState(entity)
    if IsEntityPositionFrozen then
        return IsEntityPositionFrozen(entity)
    end

    return false
end

function animPosition()
    local playerPed = PlayerPedId()
    originalPos = GetEntityCoords(playerPed)
    local originalHeading = GetEntityHeading(playerPed)
    local playerCoords = originalPos
    local playerHeading = originalHeading
    local wasFrozen = GetEntityFrozenState(playerPed)
    FreezeEntityPosition(playerPed, false)
    local posChanged = false
    animPos = not animPos
    SendNUIMessage({action = "showUI"})

    TriggerServerEvent("v-emotemenu:server:syncPlayer", playerCoords, playerHeading, 255, true)

    local lastSyncTime = 0
    local syncInterval = 200
    local animPosAlpha = 255

    Citizen.CreateThread(function()
        while animPos do
            for alpha = 50, 255, 5 do
                if not animPos then break end
                animPosAlpha = alpha
                SetEntityAlpha(playerPed, alpha, false)
                Citizen.Wait(7)
            end
            for alpha = 255, 50, -5 do
                if not animPos then break end
                animPosAlpha = alpha
                SetEntityAlpha(playerPed, alpha, false)
                Citizen.Wait(7)
            end
        end
        animPosAlpha = 255
        ResetEntityAlpha(playerPed)
        TriggerServerEvent("v-emotemenu:server:syncPlayer", GetEntityCoords(playerPed), GetEntityHeading(playerPed), 255, true)
    end)

    while animPos do
        disableControls()
        local tempCoord = GetEntityCoords(PlayerPedId())
        local x = tempCoord.x
        local y = tempCoord.y
        local z = tempCoord.z
        local heading = GetEntityHeading(playerPed)
        local dist = GetDistanceBetweenCoords(playerCoords, tempCoord, true)
        local forwardVector = GetEntityForwardVector(playerPed)
        local rightVector = vector3(forwardVector.y, -forwardVector.x, 0)
        local currentData = currentAnimationData and currentAnimationData.data
        local scenarioActive = currentData and currentData.scenario

        if dist <= maxDistance then
            if IsDisabledControlJustPressed(0, Config.KeyBinds["W"]) then 
                local delta = vector3(forwardVector.x * 0.1, forwardVector.y * 0.1, 0.0)
                x = x + delta.x
                y = y + delta.y
                if scenarioActive then ClearPedTasksImmediately(playerPed) end
                UpdatePlayerPositionSmooth(playerPed, x, y, z)
                MoveWorldPropsByDelta(delta)
                posChanged = true
                RefreshScenarioIfActive(playerPed, vector3(x, y, z), heading)
                TriggerServerEvent("v-emotemenu:server:syncPlayer", vector3(x, y, z), heading, 255, true)
            end

            if IsDisabledControlJustPressed(0, Config.KeyBinds["S"]) then 
                local delta = vector3(-forwardVector.x * 0.1, -forwardVector.y * 0.1, 0.0)
                x = x + delta.x
                y = y + delta.y
                if scenarioActive then ClearPedTasksImmediately(playerPed) end
                UpdatePlayerPositionSmooth(playerPed, x, y, z)
                MoveWorldPropsByDelta(delta)
                posChanged = true
                RefreshScenarioIfActive(playerPed, vector3(x, y, z), heading)
                TriggerServerEvent("v-emotemenu:server:syncPlayer", vector3(x, y, z), heading, 255, true)
            end

            if IsDisabledControlJustPressed(0, Config.KeyBinds["A"]) then 
                local delta = vector3(-rightVector.x * 0.1, -rightVector.y * 0.1, 0.0)
                x = x + delta.x
                y = y + delta.y
                if scenarioActive then ClearPedTasksImmediately(playerPed) end
                UpdatePlayerPositionSmooth(playerPed, x, y, z)
                MoveWorldPropsByDelta(delta)
                posChanged = true
                RefreshScenarioIfActive(playerPed, vector3(x, y, z), heading)
                TriggerServerEvent("v-emotemenu:server:syncPlayer", vector3(x, y, z), heading, 255, true)
            end

            if IsDisabledControlJustPressed(0, Config.KeyBinds["D"]) then 
                local delta = vector3(rightVector.x * 0.1, rightVector.y * 0.1, 0.0)
                x = x + delta.x
                y = y + delta.y
                if scenarioActive then ClearPedTasksImmediately(playerPed) end
                UpdatePlayerPositionSmooth(playerPed, x, y, z)
                MoveWorldPropsByDelta(delta)
                posChanged = true
                RefreshScenarioIfActive(playerPed, vector3(x, y, z), heading)
                TriggerServerEvent("v-emotemenu:server:syncPlayer", vector3(x, y, z), heading, 255, true)
            end

            if IsDisabledControlJustPressed(0, Config.KeyBinds["Q"]) then
                local newZ = z + 0.1
                if newZ > playerCoords.z + maxDistance then
                    newZ = playerCoords.z + maxDistance
                end
                local dz = newZ - z
                z = newZ
                if scenarioActive then ClearPedTasksImmediately(playerPed) end
                UpdatePlayerPositionSmooth(playerPed, x, y, z)
                MoveWorldPropsByDelta(vector3(0.0, 0.0, dz))
                posChanged = true
                RefreshScenarioIfActive(playerPed, vector3(x, y, z), heading)
                TriggerServerEvent("v-emotemenu:server:syncPlayer", vector3(x, y, z), heading, 255, true)
            end

            if IsDisabledControlJustPressed(0, Config.KeyBinds["E"]) then
                local newZ = z - 0.1
                if newZ < playerCoords.z - maxDistance then
                    newZ = playerCoords.z - maxDistance
                end
                local dz = newZ - z
                z = newZ
                if scenarioActive then ClearPedTasksImmediately(playerPed) end
                UpdatePlayerPositionSmooth(playerPed, x, y, z)
                MoveWorldPropsByDelta(vector3(0.0, 0.0, dz))
                posChanged = true
                RefreshScenarioIfActive(playerPed, vector3(x, y, z), heading)
                TriggerServerEvent("v-emotemenu:server:syncPlayer", vector3(x, y, z), heading, 255, true)
            end

            if IsDisabledControlJustPressed(0, Config.KeyBinds["LEFT"]) then
                local newHeading = heading + 5.0
                if newHeading >= 360.0 then newHeading = newHeading - 360.0 end
                if scenarioActive then ClearPedTasksImmediately(playerPed) end
                UpdatePlayerHeadingSmooth(playerPed, newHeading)
                RotateWorldPropsByDelta(newHeading - heading, vector3(x, y, z))
                heading = newHeading
                posChanged = true
                RefreshScenarioIfActive(playerPed, vector3(x, y, z), heading)
                TriggerServerEvent("v-emotemenu:server:syncPlayer", vector3(x, y, z), newHeading, 255, true)
            end

            if IsDisabledControlJustPressed(0, Config.KeyBinds["RIGHT"]) then
                local newHeading = heading - 5.0
                if newHeading < 0.0 then newHeading = newHeading + 360.0 end
                if scenarioActive then ClearPedTasksImmediately(playerPed) end
                UpdatePlayerHeadingSmooth(playerPed, newHeading)
                RotateWorldPropsByDelta(newHeading - heading, vector3(x, y, z))
                heading = newHeading
                posChanged = true
                RefreshScenarioIfActive(playerPed, vector3(x, y, z), heading)
                TriggerServerEvent("v-emotemenu:server:syncPlayer", vector3(x, y, z), newHeading, 255, true)
            end

            if IsDisabledControlJustPressed(0, Config.KeyBinds["ENTER"]) then
                playerCoords  = vector3(x, y, z)
                playerHeading = heading
                
                if IsSpotBlockedByMap(playerPed, playerCoords) then
                    print("[POSITION] Position blocked by map")
                    SetEntityCoordsNoOffset(playerPed, originalPos.x, originalPos.y, originalPos.z, true, true)
                    SetEntityHeading(playerPed, originalHeading)
                end
                
                TriggerServerEvent("v-emotemenu:server:syncPlayer", playerCoords, playerHeading, 0, true)
                SendNUIMessage({action = "hideUI"})
                TriggerEvent('v-emotemenu:client:restoreCoupleCollision')
                posChanged = false
                break
            end

            if IsDisabledControlJustPressed(0, Config.KeyBinds["BACKSPACE"]) then
                posChanged = false
                SendNUIMessage({action = "hideUI"})
                local delta = vector3(originalPos.x - tempCoord.x, originalPos.y - tempCoord.y, originalPos.z - tempCoord.z)
                UpdatePlayerPositionSmooth(playerPed, originalPos.x, originalPos.y, originalPos.z)
                MoveWorldPropsByDelta(delta)
                local headingDelta = originalHeading - heading
                UpdatePlayerHeadingSmooth(playerPed, originalHeading)
                RotateWorldPropsByDelta(headingDelta, originalPos)
                RefreshScenarioIfActive(playerPed, originalPos, originalHeading)
                TriggerEvent('v-emotemenu:client:restoreCoupleCollision')
                break
            end
        else
            playerCoords = vector3(originalPos.x, originalPos.y, originalPos.z) 
            playerHeading = heading 
            UpdatePlayerPositionSmooth(PlayerPedId(), originalPos.x, originalPos.y, originalPos.z)
            MoveWorldPropsByDelta(vector3(originalPos.x - tempCoord.x, originalPos.y - tempCoord.y, originalPos.z - tempCoord.z))
            RefreshScenarioIfActive(playerPed, originalPos, originalHeading)
            TriggerServerEvent("v-emotemenu:server:syncPlayer", playerCoords, playerHeading, 0, true)
        TriggerEvent('v-emotemenu:client:restoreCoupleCollision')
        end

        local now = GetGameTimer()
        if now - lastSyncTime >= syncInterval then
            TriggerServerEvent("v-emotemenu:server:syncPlayer", GetEntityCoords(playerPed), heading, animPosAlpha, true)
            lastSyncTime = now
        end

        Wait(1)
    end

    animPos = false
    SendNUIMessage({action = "hideUI"})
    ResetEntityAlpha(playerPed)
    TriggerServerEvent(
        "v-emotemenu:server:syncPlayer",
        GetEntityCoords(playerPed),
        GetEntityHeading(playerPed),
        0,
        false
    )

    RefreshScenarioIfActive(playerPed, GetEntityCoords(playerPed), GetEntityHeading(playerPed))

    FreezeEntityPosition(playerPed, wasFrozen)
end

RegisterCommand(Config.AnimPosCommand, function (source, args, raw)
    if animPos == true then 
        Notify("Position mode is already active", "error", 4000)
        return 
    end
    animPosition()
end)

RegisterNUICallback('openPositionMode', function(data, cb)
    cb('ok')
    if animPos then return end
    if isInAnimation then
        SetNuiFocus(false, false)
        animPosition()
    else
        Notify("Select animation please", "error", 4000)
    end
end)

AddEventHandler('onResourceStop', function(resourceName)
    if GetCurrentResourceName() ~= resourceName then
        return
    end
    ClonePreviewStop()
    ClearAnimationProps()
    animPos = false
    ResetEntityAlpha(PlayerPedId())
    FreezeEntityPosition(PlayerPedId(), false)
    SendNUIMessage({action = "hideUI"})
    TriggerEvent('v-emotemenu:client:restoreCoupleCollision')
    for ped, _ in pairs(remoteFrozenPlayers) do
        if DoesEntityExist(ped) then
            FreezeEntityPosition(ped, false)
        end
    end
    remoteFrozenPlayers = {}
    for sourceId, _ in pairs(remotePropsByPlayer) do
        ClearRemotePropsForSource(sourceId)
    end
    remotePropsByPlayer = {}
end)
