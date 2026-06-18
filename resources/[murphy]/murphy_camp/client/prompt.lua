---- PLACEMENT PROMPT ----
promptGroups = {}
function InitPrompts()
    CreatePromptButton('placement', Translate[4], 'INPUT_SELECT_NEXT_WEAPON')
    CreatePromptButton('placement', Translate[5], 'INPUT_SELECT_PREV_WEAPON')
    CreatePromptButton('placement', Translate[6], 'INPUT_FRONTEND_ACCEPT', 1000)
    CreatePromptButton('placement', Translate[7], 'INPUT_FRONTEND_CANCEL', 1000)
end

function IsPromptCompleted(group, key)
    if UiPromptHasHoldMode(promptGroups[group].prompts[key]) then
        if PromptHasHoldModeCompleted(promptGroups[group].prompts[key]) then
            Wait(0)
            return true
        end
    else
        if IsControlJustPressed(0, GetHashKey(key)) then
            Wait(0)
            return true
        end
    end
    return false
end

function CreatePromptButton(group, str, key, holdTime)
    -- Check if group exist
    if (promptGroups[group] == nil) then
        promptGroups[group] = {
            group = GetRandomIntInRange(0, 0xffffff),
            prompts = {}
        }
    end
    promptGroups[group].prompts[key] = PromptRegisterBegin()
    PromptSetControlAction(promptGroups[group].prompts[key], GetHashKey(key))
    str = CreateVarString(10, 'LITERAL_STRING', str)
    PromptSetText(promptGroups[group].prompts[key], str)
    PromptSetEnabled(promptGroups[group].prompts[key], true)
    PromptSetVisible(promptGroups[group].prompts[key], true)
    if holdTime then
        PromptSetHoldMode(promptGroups[group].prompts[key], holdTime)
    end
    PromptSetGroup(promptGroups[group].prompts[key], promptGroups[group].group)
    PromptRegisterEnd(promptGroups[group].prompts[key])
end

function DisplayPrompt(group, str)
    local promptName = CreateVarString(10, 'LITERAL_STRING', str)
    PromptSetActiveGroupThisFrame(promptGroups[group].group, promptName)
end

InitPrompts()

function InitPropsPrompt(furnituremodel, furniture, key, data, k, v)
    if data.propset == true then
        local itemset = CreateItemset(true)
        local size = GetEntitiesFromPropset(furniture, itemset, 0, false, false)
        local interactionentity
        local interactionindex
        for i, value in pairs(Config.Furnitures) do
            if (value.propset and value.propset[1] == furnituremodel) then
                if value.interactionentity then
                    interactionentity = value.interactionentity
                end
            end
        end
        if interactionentity then
            local atempt = 0
            while atempt < 10 and size == nil and size == false do
                Wait(10)
                size = GetEntitiesFromPropset(data.entity[1], itemset, 0, false, false)
                atempt = atempt + 1
            end
            if size ~= nil and size ~= false then
                if tonumber(size) > 0 then
                    for i = 0, size - 1 do
                        if GetHashKey(interactionentity) == GetEntityModel(GetIndexedItemInItemset(i, itemset)) then
                            FreezeEntityPosition(GetIndexedItemInItemset(i, itemset), true)
                            interactionindex = i
                        end
                    end
                end
            else
                interactionindex = 1
            end
        else
            interactionindex = 1
        end
        data.interacthandle = GetIndexedItemInItemset(interactionindex, itemset)
        if IsItemsetValid(itemset) then
            DestroyItemset(itemset)
        end
    end

    local interaction = nil
    local scenarios = nil
    local stockage = nil
    local murphy_craft = nil
    local stable = nil
    local options = {}
    for _, value in pairs(Config.Furnitures) do
        if (value.propset and value.propset[1] == furnituremodel) or value.props == furnituremodel then
            if value.interaction then
                interaction = value.interaction
            end
            if value.scenarios then
                scenarios = value.scenarios
            end
            if value.inventory then
                stockage = value.inventory
            end
            if value.murphy_craft then
                murphy_craft = value.murphy_craft
            end
            if value.stable then
                stable = value.stable
            end
        end
    end
    if stable ~= nil then
        print("Stable is not nil, this should not happen")
        TriggerEvent('dust_stable:registerStable', k, vector3(data.coords.x, data.coords.y, data.coords.z)) -- Register a default stable
        data.stable = true
    end
    if interaction ~= nil then
        local index = 1
        for _, settings in pairs(interaction) do
            table.insert(options, index, {
                label = settings.text,
                action = function(entity, coords, args)
                    local data = {
                        id = key
                    }
                    TriggerEvent("murphy_camp:PropInteraction:" .. settings.type, data)
                end
            })
            index = index + 1
        end
    end
    if murphy_craft ~= nil then
        local crafttable = {
            name = murphy_craft.name,                                      -- Blip name
            cat = murphy_craft.categories,                                 -- Categories available at this crafting table
            coords = vector3(data.coords.x, data.coords.y, data.coords.z), -- Coordinates of the crafting table
            radius = murphy_craft
                .radius                                                    -- Radius around the crafting table where players have access to those categories

        }

        if murphy_craft.blip then
            crafttable.blip = {                                      --- Blip configuration for the crafting table, set to nil if you don't want a blip

                hash = murphy_craft.blip.hash,                       -- Blip hash
                modifier = murphy_craft.blip.modifier,               -- Blip modifier
                displaydistance = murphy_craft.blip.displaydistance, -- Distance at which the blip is displayed, nil to display it always
                scale = murphy_craft.blip.scale                      -- Scale of the blip
            }
        end
        data.murphy_craft = crafttable
        TriggerEvent("murphy_craft:RegisterCraftTable", crafttable)
    end
    if scenarios ~= nil then
        for i, value in pairs(scenarios) do
            table.insert(options, {
                label = value.text,
                action = function(entity, coords, args)
                    local DataStruct = DataView.ArrayBuffer(256 * 4)
                    local is_data_exists = Citizen.InvokeNative(0x345EC3B7EBDE1CB5, GetEntityCoords(PlayerPedId()), 3.5,
                        DataStruct:Buffer(), 10)
                    if is_data_exists ~= false then
                        for index = 1, is_data_exists, 1 do
                            local scenario = DataStruct:GetInt32(8 * index)
                            local hash = GetScenarioPointType(scenario)
                            if GetHashKey(value.hash) == hash then
                                PedPlayingScenarios = true
                                TaskUseScenarioPoint(PlayerPedId(), scenario, "", -1.0, true, false, 0, false, -1.0,
                                    true)
                                -- exports.murphy_interact:RemoveInteraction(data.interacthandle, data.interacthandle)
                                -- InitPropsPrompt(furnituremodel, furniture, key, data, k, v)
                            end
                        end
                    end
                end
            })
        end
    end
    -- if PedPlayingScenarios then
    -- 	table.insert(options, {
    -- 		label = "Arrêter l'animation",
    -- 		action = function(entity, coords, args)
    -- 			PedPlayingScenarios = false
    -- 			ClearPedTasks(PlayerPedId())
    -- 			exports.murphy_interact:RemoveInteraction(data.interacthandle, data.interacthandle)
    -- 			InitPropsPrompt(furnituremodel, furniture, key, data, k, v)
    -- 		end,
    -- 	})
    -- end
    -- local access = false
    -- if data.accessgranted and not GetAccess(charid, v.charid, v.guests) then
    -- 	access = true
    -- 	exports.murphy_interact:RemoveInteraction(data.interacthandle, data.interacthandle)
    -- 	InitPropsPrompt(furnituremodel, furniture, key, data, k, v)
    -- end
    -- if GetAccess(charid, v.charid, v.guests) and not data.accessgranted then
    data.accessgranted = true
    if stockage ~= nil then
        table.insert(options, {
            label = Translate[11],
            canInteract = function()
                return GetAccess(charid, v.charid, v.guests)
            end,
            action = function(entity, coords, args)
                TriggerServerEvent("murphy_camp:OpenStash", "camp_" .. k .. "_" .. key, stockage)
            end
        })
    end
    if data.propset == true then
        table.insert(options, {
            label = Translate[9],
            canInteract = function()
                return GetAccess(charid, v.charid, v.guests)
            end,
            action = function(entity, coords, args)
                local stableempty = nil
                if data.stable then
                    Callback.triggerServer("murphy_camp:IsStableEmpty", function(result)
                        stableempty = result
                        print("Stable empty check result: " .. tostring(stableempty))
                    end, k)
                    repeat
                        Wait(100)
                        print("Waiting for stable empty check result...")
                    until stableempty ~= nil
                else
                    stableempty = true
                end

                if stableempty then
                    local campfirecoords = vector3(v.campfire.coords.x, v.campfire.coords.y, v.campfire.coords.z)
                    for _, value in pairs(Config.Campfire) do
                        if value.propset then
                            if value.propset[1] == v.campfire.model[1] then
                                radius = value.radius
                                break
                            end
                        else
                            if value.props == v.campfire.model then
                                radius = value.radius
                                break
                            end
                        end
                    end
                    for index, valeur in pairs(data.entity) do
                        DeletePropset(valeur, false, false)
                    end
                    TriggerEvent("murphy_camp:DrawMarker", campfirecoords, radius)
                    exports.murphy_interact:RemoveInteraction(data.interacthandle, data.interacthandle)
                    local propsetdata = CreatePropsetWithMouse(data.model[1], 1, 15.0)
                    ShowingLimitation = false
                    if propsetdata ~= nil then
                        local propscoords =
                            vector3(propsetdata.coords.x, propsetdata.coords.y, propsetdata.coords.z)
                        if #(propscoords - campfirecoords) < radius then
                            data.accessgranted = false
                            TriggerServerEvent("murphy_camp:updateprops", k, key, propsetdata)
                            if data.murphy_craft then
                                TriggerEvent("murphy_craft:RemoveCraftTable", data.murphy_craft)
                            end
                            if data.stable then
                                TriggerEvent('dust_stable:removeStable', k)
                            end
                            Wait(400)

                            -- data.interacthandle = nil
                            -- data.entity = nil
                            Citizen.InvokeNative(0x9CF1836C03FB67A2, Citizen.PointerValueIntInitialized(data.veg), 0)     -- REMOVE_VEG_MODIFIER_SPHERE
                            data.veg = nil
                        else
                            data.accessgranted = false
                            -- data.interacthandle = nil
                            -- data.entity = nil
                            Citizen.InvokeNative(0x9CF1836C03FB67A2, Citizen.PointerValueIntInitialized(data.veg), 0)     -- REMOVE_VEG_MODIFIER_SPHERE
                            data.veg = nil
                            TriggerEvent('murphy_camp:ShowAdvancedRightNotification', Translate[21],
                                "itemtype_textures", "itemtype_camp", "COLOR_WHITE", 4000)
                        end
                    else
                        exports.murphy_interact:RemoveInteraction(data.interacthandle, data.interacthandle)
                        data.accessgranted = false
                        data.entity = nil
                        Citizen.InvokeNative(0x9CF1836C03FB67A2, Citizen.PointerValueIntInitialized(data.veg), 0)     -- REMOVE_VEG_MODIFIER_SPHERE
                        data.veg = nil
                    end
                else
                    TriggerEvent('murphy_camp:ShowAdvancedRightNotification',
                        "Il reste des chevaux dans l'écurie, veuillez les retirer et les mettre dans une autre écurie",
                        "itemtype_textures", "itemtype_camp", "COLOR_WHITE", 4000)
                end
            end
        })
        table.insert(options, {
            label = Translate[10],
            canInteract = function()
                return GetAccess(charid, v.charid, v.guests)
            end,
            action = function(entity, coords, args)
                local stableempty = nil
                if data.stable then
                    Callback.triggerServer("murphy_camp:IsStableEmpty", function(result)
                        if result then
                            TriggerServerEvent("murphy_camp:deleteprops", k, key)
                            print(k)
                            TriggerEvent('dust_stable:removeStable', k)
                            Wait(1000)
                            DeletePropset(data.entity[1], false, false)
                            exports.murphy_interact:RemoveInteraction(data.interacthandle, data.interacthandle)
                            data.entity[1] = nil
                            Citizen.InvokeNative(0x9CF1836C03FB67A2, Citizen.PointerValueIntInitialized(data.veg), 0)     -- REMOVE_VEG_MODIFIER_SPHERE
                            data.veg = nil
                        else
                            TriggerEvent('murphy_camp:ShowAdvancedRightNotification',
                                "Il reste des chevaux dans l'écurie, veuillez les retirer et les mettre dans une autre écurie",
                                "itemtype_textures", "itemtype_camp", "COLOR_WHITE", 4000)
                        end
                    end, k)
                else
                    TriggerServerEvent("murphy_camp:deleteprops", k, key)
                    Wait(1000)
                    DeletePropset(data.entity[1], false, false)
                    exports.murphy_interact:RemoveInteraction(data.interacthandle, data.interacthandle)
                    data.entity[1] = nil
                    Citizen.InvokeNative(0x9CF1836C03FB67A2, Citizen.PointerValueIntInitialized(data.veg), 0)     -- REMOVE_VEG_MODIFIER_SPHERE
                    data.veg = nil
                end
            end
        })
    else
        table.insert(options, {
            label = Translate[9],
            canInteract = function()
                return GetAccess(charid, v.charid, v.guests)
            end,
            action = function(entity, coords, args)
                local stableempty = nil
                if data.stable then
                    Callback.triggerServer("murphy_camp:IsStableEmpty", function(result)
                        stableempty = result
                    end, k)
                    repeat
                        Wait(100)
                    until stableempty ~= nil
                else
                    stableempty = true
                end

                if stableempty then
                    local campfirecoords = vector3(v.campfire.coords.x, v.campfire.coords.y, v.campfire.coords.z)
                    for _, value in pairs(Config.Campfire) do
                        for _, value in pairs(Config.Campfire) do
                            if value.props == v.campfire.model then
                                radius = value.radius
                                break
                            end
                        end
                    end
                    TriggerEvent("murphy_camp:DrawMarker", campfirecoords, radius)
                    SetEntityAsMissionEntity(data.entity)
                    DeleteObject(data.entity)
                    exports.murphy_interact:RemoveInteraction(data.interacthandle, data.interacthandle)
                    local propsetdata = CreatePropWithMouse(data.model, 1, 15.0)
                    ShowingLimitation = false
                    if propsetdata ~= nil then
                        local propscoords =
                            vector3(propsetdata.coords.x, propsetdata.coords.y, propsetdata.coords.z)
                        if #(propscoords - campfirecoords) < radius then
                            data.accessgranted = false
                            TriggerServerEvent("murphy_camp:updateprops", k, key, propsetdata)
                            if data.murphy_craft then
                                TriggerEvent("murphy_craft:RemoveCraftTable", data.murphy_craft)
                            end
                            if data.stable then
                                TriggerEvent('dust_stable:removeStable', k)
                            end
                            Wait(400)
                            Citizen.InvokeNative(0x9CF1836C03FB67A2, Citizen.PointerValueIntInitialized(data.veg), 0)     -- REMOVE_VEG_MODIFIER_SPHERE
                            data.veg = nil

                            -- data.entity = nil
                        else
                            data.accessgranted = false
                            -- data.entity = nil
                            Citizen.InvokeNative(0x9CF1836C03FB67A2, Citizen.PointerValueIntInitialized(data.veg), 0)     -- REMOVE_VEG_MODIFIER_SPHERE
                            data.veg = nil
                            TriggerEvent('murphy_camp:ShowAdvancedRightNotification', Translate[21],
                                "itemtype_textures", "itemtype_camp", "COLOR_WHITE", 4000)
                        end
                    else
                        exports.murphy_interact:RemoveInteraction(data.interacthandle, data.interacthandle)
                        data.accessgranted = false
                        data.entity = nil
                        Citizen.InvokeNative(0x9CF1836C03FB67A2, Citizen.PointerValueIntInitialized(data.veg), 0)     -- REMOVE_VEG_MODIFIER_SPHERE
                        data.veg = nil
                    end
                else
                    TriggerEvent('murphy_camp:ShowAdvancedRightNotification',
                        "Il reste des chevaux dans l'écurie, veuillez les retirer et les mettre dans une autre écurie",
                        "itemtype_textures", "itemtype_camp", "COLOR_WHITE", 4000)
                end
            end
        })
        table.insert(options, {
            label = Translate[10],
            canInteract = function()
                return GetAccess(charid, v.charid, v.guests)
            end,
            action = function(entity, coords, args)
                local stableempty = nil
                if data.stable then
                    Callback.triggerServer("murphy_camp:IsStableEmpty", function(result)
                        stableempty = result
                    end, k)
                    repeat
                        Wait(100)
                    until stableempty ~= nil
                else
                    stableempty = true
                end

                if stableempty then
                    TriggerServerEvent("murphy_camp:deleteprops", k, key)
                    TriggerEvent('dust_stable:removeStable', k)
                    Wait(1000)
                    SetEntityAsMissionEntity(data.entity)
                    DeleteObject(data.entity)
                    exports.murphy_interact:RemoveInteraction(data.interacthandle, data.interacthandle)
                    data.accessgranted = false
                    data.entity = nil
                    Citizen.InvokeNative(0x9CF1836C03FB67A2, Citizen.PointerValueIntInitialized(data.veg), 0)     -- REMOVE_VEG_MODIFIER_SPHERE
                    data.veg = nil
                else
                    TriggerEvent('murphy_camp:ShowAdvancedRightNotification',
                        "Il reste des chevaux dans l'écurie, veuillez les retirer et les mettre dans une autre écurie",
                        "itemtype_textures", "itemtype_camp", "COLOR_WHITE", 4000)
                end
            end
        })
    end
    if stockage ~= nil then
        table.insert(options, {
            label = Translate[12],
            canInteract = function()
                return not GetAccess(charid, v.charid, v.guests)
            end,
            action = function(entity, coords, args)
                TriggerServerEvent("murphy_camp:asklockpick", "camp_" .. k .. "_" .. key, weight, v.charid,
                    v.guests, v.campfire.coords)
            end
        })
    end

    if data.propset == true then
        if next(options) ~= nil then
            exports.murphy_interact:AddInteraction({
                coords = (GetEntityCoords(data.interacthandle) + vec3(0.0, 0.0, 1.0)),
                id = data.interacthandle, -- needed for removing interactions
                distance = 6.0,           -- optional
                interactDst = 3.0,        -- optional
                options = options
            })
        end
    else
        if next(options) ~= nil then
            data.interacthandle = furniture
            exports.murphy_interact:AddInteraction({
                coords = (GetEntityCoords(data.interacthandle) + vec3(0.0, 0.0, 1.0)),
                id = data.interacthandle, -- needed for removing interactions
                distance = 6.0,           -- optional
                interactDst = 3.0,        -- optional
                options = options
            })
        end
    end

    -- data.entity[1] = furniture
    return data.interacthandle
end

function InitFirePrompt(charid, k, v)
    local data = v.campfire
    if data.propset == true then
        local itemset = CreateItemset(true)
        local size = GetEntitiesFromPropset(data.entity[1], itemset, 0, false, false)
        local interactionentity
        local interactionindex
        for i, value in pairs(Config.Campfire) do
            if value.propset then
                if tablesAreEqual(value.propset, data.model) then
                    if value.interactionentity then
                        interactionentity = value.interactionentity
                    end
                end
            end
        end
        if interactionentity then
            local atempt = 0
            while atempt < 10 and size == nil and size == false do
                Wait(10)
                size = GetEntitiesFromPropset(data.entity[1], itemset, 0, false, false)
                atempt = atempt + 1
            end
            if size ~= nil and size ~= false then
                if tonumber(size) > 0 then
                    for i = 0, size - 1 do
                        if GetHashKey(interactionentity) == GetEntityModel(GetIndexedItemInItemset(i, itemset)) then
                            FreezeEntityPosition(GetIndexedItemInItemset(i, itemset), true)
                            interactionindex = i
                        end
                    end
                end
            else
                interactionindex = 1
            end
        else
            interactionindex = 1
        end
        data.interacthandle = GetIndexedItemInItemset(interactionindex, itemset)
        if IsItemsetValid(itemset) then
            DestroyItemset(itemset)
        end
    else
        data.interacthandle = data.entity
    end
    local crafttable = {
        name = "Feu de camp",                                          -- Blip name
        cat = { "food" },                                              -- Categories available at this crafting table
        coords = vector3(data.coords.x, data.coords.y, data.coords.z), -- Coordinates of the crafting table
        radius = 5.0                                                   -- Radius around the crafting table where players have access to those categories

    }
    TriggerEvent("murphy_craft:RegisterCraftTable", crafttable)
    local options = {}
    if Config.CookInteractionFire then
        table.insert(options, {
            label = Translate[13],
            action = function(entity, coords, args)
                TriggerEvent("murphy_craft:OpenCraftingMenu", "camp_campfire", v.charid)
            end
        })
    end
    if data.accessgranted and not GetAccess(charid, v.charid, v.guests) then
        exports.murphy_interact:RemoveInteraction(data.interacthandle, data.interacthandle)
    end
    data.accessgranted = true
    table.insert(options, {
        label = Translate[9],
        canInteract = function()
            return GetAccess(charid, v.charid, v.guests)
        end,
        action = function(entity, coords, args)
            if next(v.props) == nil then
                if data.murphy_craft then
                    TriggerEvent("murphy_craft:RemoveCraftTable", data.murphy_craft)
                end
                if data.propset == true then
                    exports.murphy_interact:RemoveInteraction(data.interacthandle, data.interacthandle)

                    for index, valeur in pairs(data.entity) do
                        DeletePropset(valeur, false, false)
                    end
                    local propsetdata = CreatePropsetWithMouse(data.model[1], 1, 15.0)
                    if propsetdata ~= nil then
                        TriggerServerEvent("murphy_camp:updatecampfire", k, propsetdata)
                        Wait(1000)
                        data.entity = nil

                        RemoveBlip(data.blip)
                        data.blip = nil
                        if data.ptfx then
                            if Citizen.InvokeNative(0x9DD5AFF561E88F2A, data.ptfx) then    -- DoesParticleFxLoopedExist
                                Citizen.InvokeNative(0x459598F579C98929, data.ptfx, false) -- RemoveParticleFx
                            end
                            data.ptfx = nil
                        end
                        Citizen.InvokeNative(0x9CF1836C03FB67A2, Citizen.PointerValueIntInitialized(data.veg), 0) -- REMOVE_VEG_MODIFIER_SPHERE
                        data.veg = nil
                        data.accessgranted = false
                    else
                        data.accessgranted = false
                        data.entity = nil
                        Citizen.InvokeNative(0x9CF1836C03FB67A2, Citizen.PointerValueIntInitialized(data.veg), 0) -- REMOVE_VEG_MODIFIER_SPHERE
                        data.veg = nil
                        RemoveBlip(data.blip)
                        data.blip = nil
                        if data.ptfx then
                            if Citizen.InvokeNative(0x9DD5AFF561E88F2A, data.ptfx) then    -- DoesParticleFxLoopedExist
                                Citizen.InvokeNative(0x459598F579C98929, data.ptfx, false) -- RemoveParticleFx
                            end
                            data.ptfx = nil
                        end
                    end
                else
                    SetEntityAsMissionEntity(data.entity)
                    DeleteObject(data.entity)

                    local propsetdata = CreatePropWithMouse(data.model, 1, 15.0)
                    if propsetdata ~= nil then
                        TriggerServerEvent("murphy_camp:updatecampfire", k, propsetdata)
                        Wait(400)
                        data.accessgranted = false
                        data.entity = nil
                        Citizen.InvokeNative(0x9CF1836C03FB67A2, Citizen.PointerValueIntInitialized(data.veg), 0) -- REMOVE_VEG_MODIFIER_SPHERE
                        data.veg = nil
                        RemoveBlip(data.blip)
                        data.blip = nil
                        exports.murphy_interact:RemoveInteraction(data.interacthandle, data.interacthandle)
                        if data.ptfx then
                            if Citizen.InvokeNative(0x9DD5AFF561E88F2A, data.ptfx) then    -- DoesParticleFxLoopedExist
                                Citizen.InvokeNative(0x459598F579C98929, data.ptfx, false) -- RemoveParticleFx
                            end
                            data.ptfx = nil
                        end
                    else
                        data.accessgranted = false
                        data.entity = nil
                        Citizen.InvokeNative(0x9CF1836C03FB67A2, Citizen.PointerValueIntInitialized(data.veg), 0) -- REMOVE_VEG_MODIFIER_SPHERE
                        data.veg = nil
                        RemoveBlip(data.blip)
                        data.blip = nil
                        if data.ptfx then
                            if Citizen.InvokeNative(0x9DD5AFF561E88F2A, data.ptfx) then    -- DoesParticleFxLoopedExist
                                Citizen.InvokeNative(0x459598F579C98929, data.ptfx, false) -- RemoveParticleFx
                            end
                            data.ptfx = nil
                        end
                        exports.murphy_interact:RemoveInteraction(data.interacthandle, data.interacthandle)
                    end
                end
            else
                TriggerEvent('murphy_camp:ShowAdvancedRightNotification', Translate[17], "itemtype_textures",
                    "itemtype_camp", "COLOR_WHITE", 4000)
            end
        end
    })
    table.insert(options, {
        label = Translate[10],
        canInteract = function()
            return GetAccess(charid, v.charid, v.guests)
        end,
        action = function(entity, coords, args)
            if next(v.props) == nil then
                if data.murphy_craft then
                    TriggerEvent("murphy_craft:RemoveCraftTable", data.murphy_craft)
                end
                TriggerServerEvent("murphy_camp:deletecampfire", k)
                Wait(1000)
                if data.propset == true then
                    DeletePropset(data.entity, false, false)
                else
                    SetEntityAsMissionEntity(data.entity)
                    DeleteObject(data.entity)
                end
                exports.murphy_interact:RemoveInteraction(data.interacthandle, data.interacthandle)
                data.entity = nil
                Citizen.InvokeNative(0x9CF1836C03FB67A2, Citizen.PointerValueIntInitialized(data.veg), 0) -- REMOVE_VEG_MODIFIER_SPHERE
                data.veg = nil
                RemoveBlip(data.blip)
                data.blip = nil
                if data.ptfx then
                    if Citizen.InvokeNative(0x9DD5AFF561E88F2A, data.ptfx) then    -- DoesParticleFxLoopedExist
                        Citizen.InvokeNative(0x459598F579C98929, data.ptfx, false) -- RemoveParticleFx
                    end
                    data.ptfx = nil
                end
            else
                TriggerEvent('murphy_camp:ShowAdvancedRightNotification', Translate[17], "itemtype_textures",
                    "itemtype_camp", "COLOR_WHITE", 4000)
            end
        end
    })
    data.fuel = v.fuel
    table.insert(options, {
        label = v.fuel .. Translate[15],
        canInteract = function()
            return Config.CampDecay and GetAccess(charid, v.charid, v.guests)
        end,
        action = function(entity, coords, args)
            local input = TextEntry(Translate[16], 0, 3)
            if input and input ~= "" then
                TriggerServerEvent("murphy_camp:addfuel", k, input)
            end
        end
    })
    table.insert(options, {
        label = Translate[14],
        canInteract = function()
            return tostring(charid) == tostring(v.charid)
        end,
        action = function(entity, coords, args)
            TriggerServerEvent("murphy_camp:resetguests", k)
        end
    })
    table.insert(options, {
        label = Translate[33],
        canInteract = function()
            if not v.props or next(v.props) == nil then return false end
            if Config.RemoveAllFurnitureMode == "owner" then
                return tostring(charid) == tostring(v.charid)
            elseif Config.RemoveAllFurnitureMode == "admin" then
                return CampIsAdmin == true
            end
            return false
        end,
        action = function(entity, coords, args)
            TriggerServerEvent("murphy_camp:deleteallprops", k)
        end
    })
    if next(options) ~= nil then
        exports.murphy_interact:AddInteraction({
            coords = (GetEntityCoords(data.interacthandle) + vec3(0.0, 0.0, 1.0)),
            id = data.interacthandle, -- needed for removing interactions
            distance = 6.0,           -- optional
            interactDst = 3.0,        -- optional
            options = options
        })
    end
end

RegisterNetEvent("murphy_camp:dolockpick", function(stashid, open, weight, onlineplayers, campcoords)
    local accessgranted = false
    for k, v in pairs(onlineplayers) do
        local playercoords = v
        local campcoords = vector3(campcoords.x, campcoords.y, campcoords.z)
        if #(playercoords - campcoords) < Config.LockpickDistance then
            accessgranted = true
            break
        end
    end
    if accessgranted then
        if open == false then
            ClearPedTasks(PlayerPedId())
            local result = exports.murphy_lockpick.StartLockPick() -- return "result lockpicking"
            if result then
                TriggerServerEvent("murphy_camp:OpenStash", stashid, weight)
                TriggerServerEvent("murphy_camp:isopen", stashid)
            end
            ClearPedTasks(PlayerPedId())
        elseif open == true then
            TriggerServerEvent("murphy_camp:OpenStash", stashid, weight)
        end
    else
        TriggerEvent('murphy_camp:ShowAdvancedRightNotification', Translate[22], "itemtype_textures", "itemtype_camp",
            "COLOR_WHITE", 4000)
    end
end)

Citizen.CreateThread(function()
    while true do
        Wait(0)
        if PedPlayingScenarios then
            if IsControlJustPressed(0, 0x8FD015D8) or IsControlJustPressed(0, 0x7065027D) or
                IsControlJustPressed(0, 0xD27782E3) or IsControlJustPressed(0, 0xB4E465B4) then
                PedPlayingScenarios = false
                ClearPedTasks(PlayerPedId())
            end
        end
    end
end)
