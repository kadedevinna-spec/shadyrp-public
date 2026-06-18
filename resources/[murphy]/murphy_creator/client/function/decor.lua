-- Build DecorSettings from Config (for compatibility with existing code)
DecorSettings = {
    interior = Config.CharSelect.interior,
    interior_sets = Config.CharSelect.interior_sets,
    charselectcam = Config.CharSelect.camera,
    pedslots = {},
    props = Config.CharSelect.props or {}
}

local charSelectProps = {}

-- Convert scenario strings to hashes
for k, v in pairs(Config.CharSelect.pedslots) do
    DecorSettings.pedslots[k] = {
        coords = v.coords,
        heading = v.heading,
        scenario = v.scenario and GetHashKey(v.scenario) or nil,
        scenariopoint = v.scenariopoint and GetHashKey(v.scenariopoint) or nil
    }
end

function CleanupCharSelectProps()
    for _, object in pairs(charSelectProps) do
        if object and DoesEntityExist(object) then
            DeleteObject(object)
            if DoesEntityExist(object) then
                DeleteEntity(object)
            end
        end
    end

    charSelectProps = {}
end

function SpawnCharSelectProps()
    CleanupCharSelectProps()

    for _, prop in pairs(DecorSettings.props or {}) do
        local model = GetHashKey(prop.model)
        RequestModel(model)

        local timeout = 0
        while not HasModelLoaded(model) and timeout < 100 do
            Wait(50)
            timeout = timeout + 1
        end

        if HasModelLoaded(model) then
            local coords = prop.coords
            local spawnZ = coords.z + 1.0
            local object = CreateObject(model, coords.x, coords.y, spawnZ, false, false, false)

            if object and DoesEntityExist(object) then
                SetEntityHeading(object, prop.heading or 0.0)
                SetEntityAsMissionEntity(object, true, true)

                -- Let the engine settle the prop onto uneven ground before freezing it.
                if PlaceObjectOnGroundProperly then
                    PlaceObjectOnGroundProperly(object)
                elseif PlaceEntityOnGroundProperly then
                    PlaceEntityOnGroundProperly(object)
                else
                    local foundGround, groundZ = GetGroundZFor_3dCoord(coords.x, coords.y, coords.z + 5.0, false)
                    if foundGround then
                        SetEntityCoordsNoOffset(object, coords.x, coords.y, groundZ, false, false, false)
                    end
                end

                Wait(0)
                SetEntityCollision(object, false, false)
                if SetEntityCompletelyDisableCollision then
                    SetEntityCompletelyDisableCollision(object, false, false)
                end
                FreezeEntityPosition(object, true)
                table.insert(charSelectProps, object)
            end

            SetModelAsNoLongerNeeded(model)
        else
            DebugPrint("Failed to load charselect prop model: " .. tostring(prop.model))
        end
    end
end

Citizen.CreateThread(function()
    -- Load IMAPs
    if Config.CharSelect.imaps then
        for _, imap in pairs(Config.CharSelect.imaps) do
            RequestImap(GetHashKey(imap))
        end
    end
    
    -- Activate interior sets
    for k, v in pairs(DecorSettings.interior_sets) do
        if not IsInteriorEntitySetActive(DecorSettings.interior, v) then
            ActivateInteriorEntitySet(DecorSettings.interior, v)
        end
    end
end)

AddEventHandler("onResourceStop", function(resource)
    if resource == GetCurrentResourceName() then
        CleanupCharSelectProps()

        for k, v in pairs(DecorSettings.interior_sets) do
            if IsInteriorEntitySetActive(DecorSettings.interior, v) then
                DeactivateInteriorEntitySet(DecorSettings.interior, v, true)
            end
        end
    end
end)
