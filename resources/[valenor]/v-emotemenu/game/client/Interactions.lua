local currentInteraction = nil
local nearbyInteractions = {}
local isInInteraction = false
local interactionProp = nil
local interactionCoord = nil

-- Key hash to name mapping for common keys
local keyHashToName = {
    [0x80F28E95] = "L",
    [0x07CE1E61] = "M",
    [0xD9D0E1C0] = "SPACE",
    [0xC7B5340A] = "E",
    [0x8FD015D8] = "W",
    [0x7065027D] = "A",
    [0x091178D0] = "S",
    [0x4D8FB4C1] = "D",
}

local function GetKeyName(keyHash)
    return keyHashToName[keyHash] or "L"
end

local function GetClosestProp(propsList, maxDistance)
    local playerPed = PlayerPedId()
    local playerCoords = GetEntityCoords(playerPed)
    local closestProp = nil
    local closestPropModel = nil
    local closestDistance = maxDistance

    for _, propModel in ipairs(propsList) do
        local propHash = GetHashKey(propModel)
        local prop = GetClosestObjectOfType(playerCoords.x, playerCoords.y, playerCoords.z, maxDistance, propHash, false, false, false)

        if prop and prop ~= 0 and DoesEntityExist(prop) then
            local propCoords = GetEntityCoords(prop)
            local distance = #(playerCoords - propCoords)

            if distance < closestDistance then
                closestDistance = distance
                closestProp = prop
                closestPropModel = propModel
            end
        end
    end

    return closestProp, closestPropModel, closestDistance
end

local function GetClosestCoordinate(coordsList, maxDistance)
    local playerPed = PlayerPedId()
    local playerCoords = GetEntityCoords(playerPed)
    local closestCoord = nil
    local closestDistance = maxDistance

    for _, coord in ipairs(coordsList) do
        -- coord is vector4(x, y, z, heading)
        local coordPos = vector3(coord.x, coord.y, coord.z)
        local distance = #(playerCoords - coordPos)

        if distance < closestDistance then
            closestDistance = distance
            closestCoord = coord -- Keep vector4 with heading
        end
    end

    return closestCoord, closestDistance
end

local function CheckNearbyInteractions()
    local playerPed = PlayerPedId()
    local playerCoords = GetEntityCoords(playerPed)
    nearbyInteractions = {}

    for interactionKey, interactionData in pairs(Config.Interactions) do
        local distance = interactionData.distance or 1.5
        local closestEntity = nil
        local closestPropModel = nil
        local closestDistance = distance

        if interactionData.interactionType == "prop" and interactionData.propsList then
            closestEntity, closestPropModel, closestDistance = GetClosestProp(interactionData.propsList, distance)
        elseif interactionData.interactionType == "coordinate" and interactionData.coordsList then
            closestEntity, closestDistance = GetClosestCoordinate(interactionData.coordsList, distance)
        end

        if closestEntity then
            table.insert(nearbyInteractions, {
                key = interactionKey,
                data = interactionData,
                entity = closestEntity,
                propModel = closestPropModel, -- Store prop model name
                distance = closestDistance
            })
        end
    end

    if #nearbyInteractions > 0 then
        table.sort(nearbyInteractions, function(a, b)
            return a.distance < b.distance
        end)

        currentInteraction = nearbyInteractions[1]

        local keyName = GetKeyName(currentInteraction.data.activationKey or 0x80F28E95)

        SendNUIMessage({
            action = "SHOW_INTERACTION",
            interaction = {
                title = currentInteraction.data.title,
                keyName = keyName
            }
        })
    else
        currentInteraction = nil
        SendNUIMessage({
            action = "HIDE_INTERACTION"
        })
    end
end

local function ApplyInteractionAnimation(interactionData, targetCoords, targetHeading, propModel)
    local playerPed = PlayerPedId()

    ClearPedTasks(playerPed)
    ClearPedSecondaryTask(playerPed)

    local animData = interactionData.animationData
    if not animData then return end

    -- Only apply propOffset for prop interactions
    if interactionData.interactionType == "prop" and propModel then
        -- Get prop-specific offset or use default
        local propOffsetData = Config.PropOffsets[string.lower(propModel)] or Config.DefaultPropOffset
        local offsetPos = propOffsetData.position or vector3(0.0, 0.0, 0.55)
        local headingOffset = propOffsetData.heading or 180.0

        -- Apply heading offset
        targetHeading = targetHeading + headingOffset

        -- Apply position offset (rotated by final heading)
        local rad = math.rad(targetHeading)
        local rotatedX = offsetPos.x * math.cos(rad) - offsetPos.y * math.sin(rad)
        local rotatedY = offsetPos.x * math.sin(rad) + offsetPos.y * math.cos(rad)

        targetCoords = vector3(
            targetCoords.x + rotatedX,
            targetCoords.y + rotatedY,
            targetCoords.z + offsetPos.z
        )
    end
    -- For coordinate interactions, targetCoords and targetHeading come directly from vector4

    SetEntityCoordsNoOffset(playerPed, targetCoords.x, targetCoords.y, targetCoords.z, false, false, false)
    SetEntityHeading(playerPed, targetHeading)

    if animData.scenario then
        local scenarioHash = animData.scenario
        if type(scenarioHash) == "string" then
            scenarioHash = GetHashKey(scenarioHash)
        end

        TaskStartScenarioAtPosition(
            playerPed,
            scenarioHash,
            targetCoords.x,
            targetCoords.y,
            targetCoords.z,
            targetHeading,
            -1,
            false,
            true
        )
        SetPedKeepTask(playerPed, true)
    elseif animData.dict and animData.name then
        RequestAnimDict(animData.dict)
        local attempts = 0
        while not HasAnimDictLoaded(animData.dict) and attempts < 100 do
            Citizen.Wait(10)
            attempts = attempts + 1
        end

        if HasAnimDictLoaded(animData.dict) then
            local options = animData.options or {}
            local loop = options.loop or false
            local movable = options.movable or false
            local stopLastFrame = options.stop_last_frame or false
            local flag = 0

            if not loop and not movable and not stopLastFrame then
                flag = 0
            elseif loop and not movable then
                flag = 1
            elseif not loop and not movable and stopLastFrame then
                flag = 2
            elseif not loop and movable and stopLastFrame then
                flag = 30
            elseif loop and movable then
                flag = 31
            elseif not loop and movable then
                flag = 28
            end

            TaskPlayAnim(playerPed, animData.dict, animData.name, 8.0, 8.0, -1, flag, 0.0, false, false, false)
            SetPedKeepTask(playerPed, true)
        end
    elseif animData.emote then
        local emoteHash = GetHashKey(animData.emote)
        if string.find(animData.emote, "KIT_EMOTE") then
            TaskEmote(playerPed, 0, 2, emoteHash, true, true, true, true, true)
        else
            TaskStartScenarioInPlace(playerPed, emoteHash, 0, true)
        end
    end

    isInInteraction = true
    SendNUIMessage({
        action = "HIDE_INTERACTION"
    })
end

local function ActivateInteraction()
    if not currentInteraction then return end

    local interactionData = currentInteraction.data
    local entity = currentInteraction.entity
    local propModel = currentInteraction.propModel

    local targetCoords = nil
    local targetHeading = 0.0

    if interactionData.interactionType == "prop" then
        targetCoords = GetEntityCoords(entity)
        targetHeading = GetEntityHeading(entity)
        interactionProp = entity
    elseif interactionData.interactionType == "coordinate" then
        -- entity is vector4(x, y, z, heading)
        targetCoords = vector3(entity.x, entity.y, entity.z)
        targetHeading = entity.w -- heading from vector4
        interactionCoord = entity
    end

    if targetCoords then
        ApplyInteractionAnimation(interactionData, targetCoords, targetHeading, propModel)
    end
end

local function StopInteraction()
    if not isInInteraction then return end

    local playerPed = PlayerPedId()
    ClearPedTasks(playerPed)
    ClearPedSecondaryTask(playerPed)

    isInInteraction = false
    interactionProp = nil
    interactionCoord = nil

    CheckNearbyInteractions()
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(500)

        if not isInInteraction then
            CheckNearbyInteractions()
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)

        if currentInteraction and not isInInteraction then
            if IsControlJustPressed(0, currentInteraction.data.activationKey or 0x80F28E95) then
                ActivateInteraction()
            end
        end

        if isInInteraction then
            if IsControlJustPressed(0, Config.Keybinds["HANDSUP_CANCEL_ANIM"]) then
                StopInteraction()
            end
        end
    end
end)

RegisterCommand('stopinteraction', function()
    StopInteraction()
end, false)
