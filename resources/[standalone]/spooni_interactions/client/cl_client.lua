-- RSG-Core Framework Integration
local RSGCore = exports['rsg-core']:GetCoreObject()

local CanStartInteraction = true
local CurrentInteraction = nil
local StartingCoords = nil

local promptGroup = GetRandomIntInRange(0, 0xffffff)
local InteractPrompt = nil
local CancelPrompt = nil
local CurrentStyleIndex = 1
local CurrentStyleList = {}
local OpenStyleMenu -- forward declaration

local function TableCount(t)
    local count = 0
    for _ in pairs(t) do count = count + 1 end
    return count
end

local function GetTableKeys(t)
    local keys = {}
    for k, v in pairs(t) do
        table.insert(keys, tostring(k))
    end
    return keys
end

-- Removed legacy EnumerateEntities function - no longer needed with ox_target

local function HasCompatibleModel(entity, models)
    local entityModel = GetEntityModel(entity)
    for _, model in ipairs(models) do
        if entityModel == GetHashKey(model) then
            return model
        end
    end
    return nil
end

-- Legacy functions removed - replaced by ox_target system

local function PlayAnimation(ped, anim)
    if not DoesAnimDictExist(anim.dict) then
        return
    end
    RequestAnimDict(anim.dict)
    while not HasAnimDictLoaded(anim.dict) do
        Wait(0)
    end
    TaskPlayAnim(ped, anim.dict, anim.name, 0.0, 0.0, -1, 1, 1.0, false, false, false, "", false)
    RemoveAnimDict(anim.dict)
end

local function StartInteractionAtCoords(interaction)
    local x, y, z, h = interaction.x, interaction.y, interaction.z, interaction.heading
    if not StartingCoords then
        StartingCoords = GetEntityCoords(PlayerPedId())
    end
    ClearPedTasksImmediately(PlayerPedId())
    FreezeEntityPosition(PlayerPedId(), true)
    if interaction.scenario then
        TaskStartScenarioAtPosition(PlayerPedId(), GetHashKey(interaction.scenario), x, y, z, h, -1, false, true)
    elseif interaction.animation then
        SetEntityCoordsNoOffset(PlayerPedId(), x, y, z)
        SetEntityHeading(PlayerPedId(), h)
        PlayAnimation(PlayerPedId(), interaction.animation)
    end
    if interaction.effect then
        Config.Effects[interaction.effect]()
    end
    CurrentInteraction = interaction
end

local function StartInteractionAtObject(interaction)
    local objectHeading = GetEntityHeading(interaction.object)
    local objectCoords = GetEntityCoords(interaction.object)
    local r = math.rad(objectHeading)
    local cosr = math.cos(r)
    local sinr = math.sin(r)
    local x = interaction.x * cosr - interaction.y * sinr + objectCoords.x
    local y = interaction.y * cosr + interaction.x * sinr + objectCoords.y
    local z = interaction.z + objectCoords.z
    local h = interaction.heading + objectHeading
    interaction.x, interaction.y, interaction.z, interaction.heading = x, y, z, h
    StartInteractionAtCoords(interaction)
end

local function IsCompatible(t, ped)
    return not t.isCompatible or t.isCompatible(ped)
end

-- Legacy functions removed - replaced by ox_target system

local function menuStartInteraktion(data)
    if data.object then
        StartInteractionAtObject(data)
    else
        StartInteractionAtCoords(data)
    end
end

local function StopInteraction()
    CurrentInteraction = nil
    ClearPedTasksImmediately(PlayerPedId())
    FreezeEntityPosition(PlayerPedId(), false)
    if StartingCoords then
        SetEntityCoordsNoOffset(PlayerPedId(), StartingCoords.x, StartingCoords.y, StartingCoords.z)
        StartingCoords = nil
    end
end

-- Removed old vorp_menu functions - replaced by ox_target + ox_lib system

CreateThread(function()
    while true do
        CanStartInteraction = not IsPedDeadOrDying(PlayerPedId()) and not IsPedInCombat(PlayerPedId())
        Wait(1000)
    end
end)

AddEventHandler('onResourceStop', function(resourceName)
    if (GetCurrentResourceName() ~= resourceName) then
      return
    end
    StopInteraction()
end)

isAreaBanned = function (coords)
	for k,v in pairs(Config.BannedAreas) do
        local dist = GetDistanceBetweenCoords(coords.x,coords.y,coords.z,v.x,v.y,v.z,true)
		if dist < v.r then
			return true
		end
	end
	return false
end

-- ox_target Integration Functions
local function GetInteractionLabel(interaction)
    return 'Interactions' -- Simple fallback since Translation might not be ready
end
local function GetInteractionLabel(interaction)
    local baseLabel = Translation[Config.Locale]['menu_title']
    if interaction.label then
        baseLabel = baseLabel .. Translation[Config.Locale]['menu_' .. interaction.label]
    end
    return baseLabel
end

local function GetTargetCoords(entity, interaction)
    local entityCoords = GetEntityCoords(entity)
    local heading = GetEntityHeading(entity)
    
    if interaction.x or interaction.y or interaction.z then
        local forwardX = math.sin(math.rad(heading + (interaction.heading or 0)))
        local forwardY = math.cos(math.rad(heading + (interaction.heading or 0)))
        
        return vector3(
            entityCoords.x + (interaction.x or 0) * forwardX + (interaction.y or 0) * forwardY,
            entityCoords.y + (interaction.x or 0) * forwardY - (interaction.y or 0) * forwardX,
            entityCoords.z + (interaction.z or 0)
        )
    end
    
    return entityCoords
end

local function CanInteractWithObject(entity, interaction)
    -- Check if player can start interaction
    if not CanStartInteraction then return false end
    
    -- Check banned areas
    local playerCoords = GetEntityCoords(PlayerPedId())
    if isAreaBanned(playerCoords) then return false end
    
    -- Check ped compatibility
    if interaction.isCompatible and not interaction.isCompatible(PlayerPedId()) then
        return false
    end
    
    return true
end

local function CreateContextMenu(availableOptions, entity, interaction)
    local contextMenu = {}

    
    -- Add scenario options
    for _, option in ipairs(availableOptions) do
        table.insert(contextMenu, {
            title = option.labelText,
            icon = 'fas fa-chair',
            onSelect = function()
                
                option.callback(option.data)
            end
        })
    end
    
    -- Add cancel option at the end
    table.insert(contextMenu, {
        title = 'Cancel',
        icon = 'fas fa-times',
        onSelect = function()
            
            -- Just close the menu, no position restoration
        end
    })
    
    -- Register and show the context menu
    lib.registerContext({
        id = 'spooni_interaction_menu',
        title = 'Interactions',
        options = contextMenu
    })
    
    lib.showContext('spooni_interaction_menu')

end

local function StartInteractionMenu(entity, interaction)
    
    
    if not CanInteractWithObject(entity, interaction) then 
        return 
    end
    
    -- Store starting position for cancel functionality
    if not StartingCoords then
        StartingCoords = GetEntityCoords(PlayerPedId())
        
    end
    

    
    -- Try to resolve scenario references from globals
    local scenarios = interaction.scenarios
    local animations = interaction.animations
    
    -- If scenarios is nil, try to determine from object type  
    if not scenarios then
        local modelName = HasCompatibleModel(entity, interaction.objects)
        if modelName then
            
            -- Map model types to scenario globals
            if modelName:match("bed") or modelName:match("mattress") or modelName:match("cot") then
                scenarios = BedScenarios
                
            elseif modelName:match("chair") or modelName:match("bench") or modelName:match("stool") then
                scenarios = GenericChairAndBenchScenarios  
                
            elseif modelName:match("piano") then
                scenarios = PianoScenarios
                
            elseif modelName:match("bath") then
                scenarios = BathAnimations
                
            elseif modelName:match("pole") then
                scenarios = PoleAnimations
                
            end
        end
    end
    
    -- If scenarios is a string reference, try to resolve it from global scope
    if scenarios and type(scenarios) ~= "table" then
        local globalName = tostring(scenarios)
        scenarios = _G[globalName]
        
    end
    
    -- If animations is a string reference, try to resolve it from global scope  
    if animations and type(animations) ~= "table" then
        local globalName = tostring(animations)
        animations = _G[globalName]
        
    end
    
    -- Build available options similar to old system
    local availableOptions = {}
    

    if scenarios then
        
        if type(scenarios) == "table" then
            
            for _, scenario in ipairs(scenarios) do
                -- Check scenario compatibility
                local canUseScenario = true
                if scenario.isCompatible and not scenario.isCompatible(PlayerPedId()) then
                    canUseScenario = false
                   
                end
                
                if canUseScenario then
                    
                    local interactionData = {
                        x = interaction.x or 0,
                        y = interaction.y or 0,
                        z = interaction.z or 0,
                        heading = interaction.heading or 0,
                        scenario = scenario.name,
                        object = entity,
                    modelName = HasCompatibleModel(entity, interaction.objects),
                    distance = #(GetEntityCoords(PlayerPedId()) - GetEntityCoords(entity)),
                    label = interaction.label,
                    effect = interaction.effect,
                    labelText = scenario.label,
                    labelText2 = interaction.labelText,
                    targetCoords = GetTargetCoords(entity, interaction)
                }
                
                table.insert(availableOptions, {
                    labelText = scenario.label,
                    data = interactionData,
                callback = function(data)
                    CurrentStyleList = scenarios
                    CurrentStyleIndex = 1
                    menuStartInteraktion(data)
                end
                })
                end
            end
        end
    end

    
    if animations then
        
        for _, animation in ipairs(animations) do
            local interactionData = {
                x = interaction.x or 0,
                y = interaction.y or 0,
                z = interaction.z or 0,
                heading = interaction.heading or 0,
                animation = animation,
                object = entity,
                modelName = HasCompatibleModel(entity, interaction.objects),
                distance = #(GetEntityCoords(PlayerPedId()) - GetEntityCoords(entity)),
                label = interaction.label,
                effect = interaction.effect,
                labelText = animation.label,
                labelText2 = interaction.labelText,
                targetCoords = GetTargetCoords(entity, interaction)
            }
            
            table.insert(availableOptions, {
                labelText = animation.label,
                data = interactionData,
            callback = function(data)
                CurrentStyleList = animations
                CurrentInteraction = data
                menuStartInteraktion(data)
            end
            })
        end
    end
    
    
    
    if #availableOptions > 0 then
        CreateContextMenu(availableOptions, entity, interaction)
    end
end

-- Register all object targets on resource start
-- Function to fix config references after globals are loaded
local function FixConfigReferences()
    
    
    for i, interaction in ipairs(Config.Interactions) do
        -- Fix objects reference
        if not interaction.objects and interaction._originalObjects then
            -- Handle case where original reference was lost
            if interaction._originalObjects == "GenericChairs" then
                interaction.objects = GenericChairs
                
            end
        elseif type(interaction.objects) == "string" then
            -- Handle string reference
            local globalName = interaction.objects
            local globalRef = _G[globalName]
            if globalRef then
                interaction.objects = globalRef
               
            end
        end
        
        -- Fix scenarios reference
        if type(interaction.scenarios) == "string" then
            local globalName = interaction.scenarios
            local globalRef = _G[globalName]
            if globalRef then
                interaction.scenarios = globalRef
                
            end
        end
    end
end

local function RegisterInteractionTargets()
    
    
    -- Fix any broken global references first
    FixConfigReferences()
    
    -- Collect all unique models from interactions
    local registeredModels = {}
    
    for _, interaction in ipairs(Config.Interactions) do
        if interaction.objects then
            -- Resolve objects if it's a global reference
            local objects = interaction.objects
            if type(objects) ~= "table" then
                -- Try to resolve global reference
                local globalName = tostring(objects)
                objects = _G[globalName]
                if not objects then
                    goto continue
                end
            end
            
            for _, model in ipairs(objects) do
                if not registeredModels[model] then
                    registeredModels[model] = {}
                end
                table.insert(registeredModels[model], interaction)
            end
        end
        ::continue::
    end
    
    
    
    -- Register each model with ox_target
    for model, interactions in pairs(registeredModels) do
        
        
        local targetOptions = {}
        
        for _, interaction in ipairs(interactions) do
            local interactionLabel = 'Interactions'
            if interaction.label then
                interactionLabel = interactionLabel .. ' (' .. string.upper(string.sub(interaction.label, 1, 1)) .. string.sub(interaction.label, 2) .. ')'
            end
            
            table.insert(targetOptions, {
                name = 'spooni_interact_' .. model .. '_' .. (#targetOptions + 1),
                icon = 'fas fa-hand-paper',
                label = interactionLabel,
                onSelect = function(data)
                    
                    StartInteractionMenu(data.entity, interaction)
                end,
                distance = interaction.radius or 2.0,
                canInteract = function(entity)
                    local canInteract = CanInteractWithObject(entity, interaction)
                    
                    return canInteract
                end
            })
        end
        
        exports.ox_target:addModel(GetHashKey(model), targetOptions)
        
    end
    
    -- Register coordinate-based interactions (like baths)
    for _, interaction in ipairs(Config.Interactions) do
        if interaction.x and interaction.y and interaction.z and not interaction.objects then
            exports.ox_target:addSphereZone({
                coords = vector3(interaction.x, interaction.y, interaction.z),
                radius = interaction.radius or 2.0,
                options = {
                    {
                        name = 'interact_coords_' .. interaction.x .. '_' .. interaction.y,
                        icon = 'fas fa-hand-paper',
                        label = GetInteractionLabel(interaction),
                        onSelect = function()
                            -- Handle coordinate-based interaction
                            local interactionData = {
                                x = interaction.x,
                                y = interaction.y,
                                z = interaction.z,
                                heading = interaction.heading or 0,
                                label = interaction.label,
                                effect = interaction.effect,
                                targetCoords = vector3(interaction.x, interaction.y, interaction.z)
                            }
                            
                            -- Add scenarios if available
                            if interaction.scenarios and #interaction.scenarios > 0 then
                                local firstScenario = interaction.scenarios[1]
                                if not firstScenario.isCompatible or firstScenario.isCompatible(PlayerPedId()) then
                                    interactionData.scenario = firstScenario.name
                                    interactionData.labelText = firstScenario.label
                                end
                            end
                            
                            -- Add animations if available  
                            if interaction.animations and #interaction.animations > 0 then
                                local firstAnimation = interaction.animations[1]
                                if not firstAnimation.isCompatible or firstAnimation.isCompatible(PlayerPedId()) then
                                    interactionData.animation = firstAnimation
                                    interactionData.labelText = firstAnimation.label
                                end
                            end
                            
                            StartInteractionAtCoords(interactionData)
                        end,
                        canInteract = function()
                            return CanInteractWithObject(PlayerPedId(), interaction)
                        end
                    }
                }
            })
        end
    end 
end

-- Initialize ox_target on resource start
CreateThread(function()
    Wait(5000) -- Wait for ox_target and all dependencies to be ready
    RegisterInteractionTargets()
end)

-- Handle cancel commands
RegisterCommand('c', function()
    if CurrentInteraction then
        StopInteraction()
    end
end, false)

RegisterCommand('cancel', function()
    if CurrentInteraction then
        StopInteraction()
    end
end, false)

local UIPrompt = {}

UIPrompt.activate = function(title)
    local label = CreateVarString(10, 'LITERAL_STRING', title)
    PromptSetActiveGroupThisFrame(promptGroup, label)
end

UIPrompt.initialize = function()
    -- เปลี่ยนท่า (E)
    InteractPrompt = PromptRegisterBegin()
    PromptSetControlAction(InteractPrompt, 0xCEFD9220) -- E
    PromptSetText(InteractPrompt, CreateVarString(10, 'LITERAL_STRING', "Change Style"))
    PromptSetEnabled(InteractPrompt, true)
    PromptSetVisible(InteractPrompt, true)
    PromptSetStandardMode(InteractPrompt, true)
    PromptSetGroup(InteractPrompt, promptGroup)
    PromptRegisterEnd(InteractPrompt)

    -- ยกเลิก (J)
    CancelPrompt = PromptRegisterBegin()
    PromptSetControlAction(CancelPrompt, 0xF3830D8E) -- J
    PromptSetText(CancelPrompt, CreateVarString(10, 'LITERAL_STRING', "Cancel"))
    PromptSetEnabled(CancelPrompt, true)
    PromptSetVisible(CancelPrompt, true)
    PromptSetStandardMode(CancelPrompt, true)
    PromptSetGroup(CancelPrompt, promptGroup)
    PromptRegisterEnd(CancelPrompt)
end

CreateThread(function()
    UIPrompt.initialize()

    while true do
        Wait(0)

        if CurrentInteraction then
            UIPrompt.activate("Sitting")

            -- กด E เปิดเมนู
            if PromptHasStandardModeCompleted(InteractPrompt) then
                OpenStyleMenu()
            end

            -- กด J ยกเลิก
            if PromptHasStandardModeCompleted(CancelPrompt) then
                StopInteraction()
            end
        else
            Wait(500)
        end
    end
end)

OpenStyleMenu = function()

    if not CurrentStyleList or #CurrentStyleList == 0 then return end

    local options = {}

    for _, style in ipairs(CurrentStyleList) do
        table.insert(options, {
            title = style.label,
            icon = 'fas fa-chair',
            onSelect = function()

                ClearPedTasksImmediately(PlayerPedId())

                if style.name then
                    TaskStartScenarioAtPosition(
                        PlayerPedId(),
                        GetHashKey(style.name),
                        CurrentInteraction.x,
                        CurrentInteraction.y,
                        CurrentInteraction.z,
                        CurrentInteraction.heading,
                        -1,
                        false,
                        true
                    )
                elseif style.dict then
                    PlayAnimation(PlayerPedId(), style)
                end
            end
        })
    end

    lib.registerContext({
        id = 'spooni_style_menu',
        title = 'Change Sitting Style',
        options = options
    })

    lib.showContext('spooni_style_menu')
end