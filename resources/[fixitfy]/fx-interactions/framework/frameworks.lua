Framework = "none"
onPlayerLoadEvent = "none" 
LoadTimeout = 5
if GetResourceState('rsg-core') == 'started' then
    Framework = "RSG"
    LoadTimeout = 5
    onPlayerLoadEvent = "RSGCore:Client:OnPlayerLoaded"
    print("^2[INFO]^0 Framework selected: ^3" .. Framework .. "^0")
elseif GetResourceState('vorp_core') == 'started' then
    Framework = "VORP"
    onPlayerLoadEvent = "vorp:SelectedCharacter" 
    LoadTimeout = 5
    print("^2[INFO]^0 Framework selected: ^3" .. Framework .. "^0")
else
    Citizen.CreateThread(function()
        while true do
            Citizen.Wait(2000)
            print("^1[ERROR]^0 No suitable framework found. ^2Please install ^3vorp_core^2 or ^3rsg-core^2.")
            print("^1[ERROR]^0 Make sure to start ^3fx-idcard^0 after the frameworks in your ^2server.cfg^0 file.")
        end
    end)
end 


if Framework == "VORP" then
    if IsDuplicityVersion() then
        --[[
            Server Side
        ]]
        VorpCore = {}
        
        TriggerEvent("getCore", function(core)
            VorpCore = core
        end)
    
        VorpInv = {}
        VorpInv = exports.vorp_inventory:vorp_inventoryApi()
        
        function FXRegisterCallback(eventName, callBack,...)
            VorpCore.addRpcCallback(eventName, function(source, cb, ...)
                callBack(source,cb,...)
            end)
        end
    
        function FXGetPlayerData(src)
            local User = VorpCore.getUser(src)
            local array = {}
            if not User then
                return array
            end
            local Character = User.getUsedCharacter
            array = {
                charid = Character.charIdentifier,       
                firstname = Character.firstname,
                lastname = Character.lastname,
                job = Character.job,
                grade = Character.jobGrade,
                admin = User.getGroup == "admin",
            }
            return array
        end

    else
    --[[
        Client Side
    ]]    

        VorpCore = {}
        TriggerEvent("getCore", function(core)
            VorpCore = core
        end)

        function FXTriggerServerCallback(eventName,callBack,...)
            VorpCore.RpcCall(eventName,function(...)
                callBack(...)
            end,...)
        end

        function UseTargetForChair(obj)
            if not DoesEntityExist(obj) or targetAdded[obj] then return end
            targetAdded[obj] = true
        
            local usingOx = GetResourceState("ox_target") == "started"
            local usingMurphy = GetResourceState("murphy_interact") == "started"
            local usingPcInteraction = GetResourceState("pc_interaction") == "started"
        
            local model = GetEntityModel(obj)
            local bathOpt = findOptionByModel(Config.BathingOptions, model)
            local isBathObj = (bathOpt ~= nil)
        
            local label = isBathObj and Locale("interaction_label_bath") or Locale("interaction_label")
            local icon  = isBathObj and "fas fa-shower" or "fas fa-chair"
        
            if usingOx then
                exports.ox_target:addLocalEntity(obj, {
                    {
                        name = isBathObj and "fx-interactions:bath_obj" or "fx-interactions:chair",
                        label = label,
                        icon = icon,
                        iconColor = "orange",
                        distance = 2.0,
                        onSelect = function(data)
                            TriggerEvent("fx-interactions:openMenu", data.entity or nil)
                        end
                    }
                })
        
            elseif usingMurphy then
                exports.murphy_interact:AddLocalEntityInteraction({
                    entity = obj,
                    id = (isBathObj and 'fx_interactions_bath_' or 'fx_interactions_chair_') .. obj,
                    name = isBathObj and 'fx-interactions:bath_obj' or 'fx-interactions:chair',
                    title = label,
                    distance = 3.0,
                    interactDst = 1.5,
                    options = {
                        {
                            label = label,
                            action = function(entity)
                                TriggerEvent("fx-interactions:openMenu", entity or nil)
                            end
                        }
                    }
                })
        
            elseif usingPcInteraction then
                local Interaction = exports['pc_interaction']:GetApi()
        
                Interaction.CreateEntityInteraction(
                    (isBathObj and "fx_bathobj_" or "fx_chair_") .. obj,
                    obj,
                    {
                        {
                            text = label,
                            onSelect = function(self, entity)
                                TriggerEvent("fx-interactions:openMenu", entity)
                            end
                        }
                    },
                    3.0,
                    1.5
                )
            else
                print("[fx-interactions] ❌ No compatible target or interaction system found (ox_target, murphy_interact, pc_interaction).")
            end
        end
        
        function UseTargetForBath()
            if not Config.BathingLocations then return end
        
            local usingOx      = GetResourceState("ox_target") == "started"
            local usingMurphy  = GetResourceState("murphy_interact") == "started"
            local usingPc      = GetResourceState("pc_interaction") == "started"
        
            for index, bath in ipairs(Config.BathingLocations) do
                local label = Locale("interaction_label_bath")
        
                if usingOx then
                    exports.ox_target:addSphereZone({
                        coords = vec3(bath.x, bath.y, bath.z),
                        radius = bath.radius or 2.0,
                        debug = false,
                        options = {
                            {
                                name = "fx-interactions:bath:" .. tostring(index), 
                                label = label,
                                icon = "fas fa-shower",
                                distance = 2.0,
                    
                                canInteract = function()
                                    return not FX_AIMING_ENTITY_INTERACTION
                                end,
                    
                                onSelect = function()
                                    TriggerEvent("fx-interactions:openMenu", {
                                        isBath = true,
                                        bathData = {
                                            x = bath.x, y = bath.y, z = bath.z,
                                            heading = bath.heading or 0.0,
                                            effect = bath.effect or "clean",
                                            animations = Config.BathingAnimations or {}
                                        }
                                    })
                                end
                            }
                        }
                    })
                    
        
                elseif usingMurphy then
                    exports.murphy_interact:AddInteraction({
                        coords     = vec3(bath.x, bath.y, bath.z),
                        id         = "fx_interactions_bath_" .. tostring(index),
                        name       = "fx-interactions:bath",
                        title      = label,
                        distance   = 4.0,
                        interactDst= 2.0,
                        options = {
                            {
                                label = label,
                                action = function()
                                    TriggerEvent("fx-interactions:openMenu", {
                                        isBath = true,
                                        bathData = {
                                            x = bath.x, y = bath.y, z = bath.z,
                                            heading = bath.heading or 0.0,
                                            effect = bath.effect or "clean",
                                            animations = Config.BathingAnimations or {}
                                        }
                                    })
                                end
                            }
                        }
                    })
        
                elseif usingPc then
                    local Interaction = exports['pc_interaction']:GetApi()
        
                    Interaction.CreateInteraction(
                        "fx_bath_" .. tostring(index),        -- Benzersiz ID
                        vector3(bath.x, bath.y, bath.z),     -- Pozisyon
                        {
                            {
                                text = label,
                                onSelect = function(self, entity)
                                    TriggerEvent("fx-interactions:openMenu", {
                                        isBath = true,
                                        bathData = {
                                            x = bath.x, y = bath.y, z = bath.z,
                                            heading = bath.heading or 0.0,
                                            effect = bath.effect or "clean",
                                            animations = Config.BathingAnimations or {}
                                        }
                                    })
                                end
                            }
                        },
                        bath.renderDistance or 5.0,  -- Kaç metreden ikon görünsün
                        bath.interactDistance or 2.0 -- Kaç metrede kullanılabilsin
                    )        
                else
                    print("[fx-interactions] ❌ No compatible target system found (ox_target, murphy_interact, pc_interaction).")
                    return
                end
            end
        end
        
    end
elseif Framework == "RSG" then
    if IsDuplicityVersion() then
        --[[
            Server Side
        ]]
        RSGCore = exports['rsg-core']:GetCoreObject()
        
        function FXRegisterCallback(eventName, callBack,...)
            RSGCore.Functions.CreateCallback(eventName, function(source, cb, ...)
                callBack(source,cb,...)
            end)
        end

        function FXGetPlayerData(src)
            local Player = RSGCore.Functions.GetPlayer(src)
            local array = {
                charid = Player.PlayerData.citizenid,
                firstname = Player.PlayerData.charinfo.firstname,
                lastname = Player.PlayerData.charinfo.firstname,
                job = Player.PlayerData.job.name,
                grade = Player.PlayerData.job.grade.level,
                charid = Player.PlayerData.citizenid,
                admin = Player and RSGCore.Functions.HasPermission(src, 'admin') or false,
            }
            return array
        end
    
    else
    --[[
        Client Side
    ]]    
        RSGCore = exports['rsg-core']:GetCoreObject()

        function FXTriggerServerCallback(eventName,callBack,...)
            RSGCore.Functions.TriggerCallback(eventName,function(...)
                callBack(...)
            end,...)
        end

        function UseTargetForChair(obj)
            if not DoesEntityExist(obj) or targetAdded[obj] then return end
            targetAdded[obj] = true
        
            local usingOx = GetResourceState("ox_target") == "started"
            local usingMurphy = GetResourceState("murphy_interact") == "started"
            local usingPcInteraction = GetResourceState("pc_interaction") == "started"
        
            local model = GetEntityModel(obj)
            local bathOpt = findOptionByModel(Config.BathingOptions, model)
            local isBathObj = (bathOpt ~= nil)
        
            local label = isBathObj and Locale("interaction_label_bath") or Locale("interaction_label")
            local icon  = isBathObj and "fas fa-shower" or "fas fa-chair"
        
            if usingOx then
                exports.ox_target:addLocalEntity(obj, {
                    {
                        name = isBathObj and "fx-interactions:bath_obj" or "fx-interactions:chair",
                        label = label,
                        icon = icon,
                        iconColor = "orange",
                        distance = 2.0,
                        onSelect = function(data)
                            TriggerEvent("fx-interactions:openMenu", data.entity or nil)
                        end
                    }
                })
        
            elseif usingMurphy then
                exports.murphy_interact:AddLocalEntityInteraction({
                    entity = obj,
                    id = (isBathObj and 'fx_interactions_bath_' or 'fx_interactions_chair_') .. obj,
                    name = isBathObj and 'fx-interactions:bath_obj' or 'fx-interactions:chair',
                    title = label,
                    distance = 3.0,
                    interactDst = 1.5,
                    options = {
                        {
                            label = label,
                            action = function(entity)
                                TriggerEvent("fx-interactions:openMenu", entity or nil)
                            end
                        }
                    }
                })
        
            elseif usingPcInteraction then
                local Interaction = exports['pc_interaction']:GetApi()
        
                Interaction.CreateEntityInteraction(
                    (isBathObj and "fx_bathobj_" or "fx_chair_") .. obj,
                    obj,
                    {
                        {
                            text = label,
                            onSelect = function(self, entity)
                                TriggerEvent("fx-interactions:openMenu", entity)
                            end
                        }
                    },
                    3.0,
                    1.5
                )
            else
                print("[fx-interactions] ❌ No compatible target or interaction system found (ox_target, murphy_interact, pc_interaction).")
            end
        end
        
        
        function UseTargetForBath()
            if not Config.BathingLocations then return end
        
            local usingOx      = GetResourceState("ox_target") == "started"
            local usingMurphy  = GetResourceState("murphy_interact") == "started"
            local usingPc      = GetResourceState("pc_interaction") == "started"
        
            for index, bath in ipairs(Config.BathingLocations) do
                local label = Locale("interaction_label_bath")
        
                if usingOx then
                    exports.ox_target:addSphereZone({
                        coords = vec3(bath.x, bath.y, bath.z),
                        radius = bath.radius or 2.0,
                        debug = false,
                        options = {
                            {
                                name = "fx-interactions:bath:" .. tostring(index), 
                                label = label,
                                icon = "fas fa-shower",
                                distance = 2.0,
                    
                                canInteract = function()
                                    return not FX_AIMING_ENTITY_INTERACTION
                                end,
                    
                                onSelect = function()
                                    TriggerEvent("fx-interactions:openMenu", {
                                        isBath = true,
                                        bathData = {
                                            x = bath.x, y = bath.y, z = bath.z,
                                            heading = bath.heading or 0.0,
                                            effect = bath.effect or "clean",
                                            animations = Config.BathingAnimations or {}
                                        }
                                    })
                                end
                            }
                        }
                    })
                    
        
                elseif usingMurphy then
                    exports.murphy_interact:AddInteraction({
                        coords     = vec3(bath.x, bath.y, bath.z),
                        id         = "fx_interactions_bath_" .. tostring(index),
                        name       = "fx-interactions:bath",
                        title      = label,
                        distance   = 4.0,
                        interactDst= 2.0,
                        options = {
                            {
                                label = label,
                                action = function()
                                    TriggerEvent("fx-interactions:openMenu", {
                                        isBath = true,
                                        bathData = {
                                            x = bath.x, y = bath.y, z = bath.z,
                                            heading = bath.heading or 0.0,
                                            effect = bath.effect or "clean",
                                            animations = Config.BathingAnimations or {}
                                        }
                                    })
                                end
                            }
                        }
                    })
        
                elseif usingPc then
                    local Interaction = exports['pc_interaction']:GetApi()
        
                    Interaction.CreateInteraction(
                        "fx_bath_" .. tostring(index),        -- Benzersiz ID
                        vector3(bath.x, bath.y, bath.z),     -- Pozisyon
                        {
                            {
                                text = label,
                                onSelect = function(self, entity)
                                    TriggerEvent("fx-interactions:openMenu", {
                                        isBath = true,
                                        bathData = {
                                            x = bath.x, y = bath.y, z = bath.z,
                                            heading = bath.heading or 0.0,
                                            effect = bath.effect or "clean",
                                            animations = Config.BathingAnimations or {}
                                        }
                                    })
                                end
                            }
                        },
                        bath.renderDistance or 5.0,  -- Kaç metreden ikon görünsün
                        bath.interactDistance or 2.0 -- Kaç metrede kullanılabilsin
                    )        
                else
                    print("[fx-interactions] ❌ No compatible target system found (ox_target, murphy_interact, pc_interaction).")
                    return
                end
            end
        end
        
    end
end
