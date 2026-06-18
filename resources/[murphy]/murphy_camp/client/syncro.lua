Camps = {}
SpawnedCamps = {}
SpawnedSmoke = {}
Blips = {}
charid = nil
CampIsAdmin = false

Citizen.CreateThread(function()
    Wait(5000)
    Callback.triggerServer('murphy_camp:IsCampAdmin', function(isAdmin)
        CampIsAdmin = isAdmin == true
    end)
end)
-- Blip refresh loop. Uses the batched GetAllCampsLite callback so the server
-- only handles 1 round-trip per player per tick, instead of 1 + N (where N
-- is the total number of camps on the server). On heavily-used servers this
-- reduces network/CPU load by an order of magnitude.
Citizen.CreateThread(function()
    print("^2[Camp]^0 Initializing camps...")
    Wait(5000)
    print("^2[Camp]^0 Camps initialized.")
    while true do
        Callback.triggerServer('murphy_camp:GetAllCampsLite', function(camps, characterid)
            charid = tostring(characterid)
            -- Reset Camps to the batched coords (preserves the existing
            -- vector3-only shape that PlacingProps.lua and the proximity
            -- spawn loop rely on).
            local nextCamps = {}
            for k, v in pairs(camps or {}) do
                nextCamps[k] = v.coords
            end
            Camps = nextCamps

            -- Drop blips for camps that disappeared since last tick.
            for k in pairs(Blips) do
                if not camps[k] then
                    RemoveBlip(Blips[k])
                    Blips[k] = nil
                end
            end

            -- Create / remove blips based on ownership without an extra
            -- GetCampComponents callback per camp.
            for k, v in pairs(camps or {}) do
                if not Blips[k] then
                    if charid == v.charid then
                        Blips[k] = Createblip(v.coords, Translate[2], "blip_campfire")
                    elseif GetAccess(charid, v.charid, v.guests) then
                        Blips[k] = Createblip(v.coords, Translate[3], "blip_campfire")
                    end
                else
                    if not GetAccess(charid, v.charid, v.guests) then
                        RemoveBlip(Blips[k])
                        Blips[k] = nil
                    end
                end
            end
        end)
        Wait(60000)
    end
end)

local notif = {}
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1000)
        local playerPos = GetEntityCoords(PlayerPedId())
        for k, v in pairs(SpawnedCamps) do
            local campfirecoords = vector3(v.campfire.coords.x, v.campfire.coords.y, v.campfire.coords.z)
            if #(playerPos - campfirecoords) < 10.0 then
                if v.campfire.accessgranted then
                    if v.campfire.fuel and notif[k] == nil then
                        notif[k] = true
                        ShowTopNotif(Translate[2], Translate[31][1] .. v.campfire.fuel .. Translate[31][2], 10000)
                        Citizen.SetTimeout(30 * 60 * 1000, function()
                            notif[k] = nil
                        end)
                    end
                end
            end
        end
    end
end)

Citizen.CreateThread(function()
    if Config.Campfiresmoke then
        --- SMOKE ON CAMPFIRE
        Citizen.CreateThread(function()
            while true do
                Citizen.Wait(1000)
                local playerPos = GetEntityCoords(PlayerPedId())
                for campid, coords in pairs(Camps) do
                    local campfirecoords = coords
                    if #(playerPos - campfirecoords) < 2000.0 then
                        if not SpawnedSmoke[campid] then
                            -- print("^2[Camp]^0 Spawning smoke for camp with ID: " .. tostring(campid))
                            local current_ptfx_dictionary = "scr_campfires"
                            local current_ptfx_name = "ent_amb_campfire_smoke_distance"
                            local scale = 1.5
                            if not Citizen.InvokeNative(0x65BB72F29138F5D6, GetHashKey(current_ptfx_dictionary)) then                         -- HasNamedPtfxAssetLoaded
                                Citizen.InvokeNative(0xF2B2353BBC0D4E8F, GetHashKey(current_ptfx_dictionary))                                 -- RequestNamedPtfxAsset
                                local counter = 0
                                while not Citizen.InvokeNative(0x65BB72F29138F5D6, GetHashKey(current_ptfx_dictionary)) and counter <= 300 do -- while not HasNamedPtfxAssetLoaded
                                    Citizen.Wait(0)
                                end
                            end
                            if Citizen.InvokeNative(0x65BB72F29138F5D6, GetHashKey(current_ptfx_dictionary)) then -- HasNamedPtfxAssetLoaded
                                Citizen.InvokeNative(0xA10DB07FC234DD12, current_ptfx_dictionary)                 -- UseParticleFxAsset

                                current_ptfx_handle_id = Citizen.InvokeNative(0xBA32867E86125D3A, current_ptfx_name,
                                    campfirecoords.x, campfirecoords.y, campfirecoords.z, 0.0, 0.0, 0.0, scale, 0, 0, 0,
                                    true)
                                SpawnedSmoke[campid] = current_ptfx_handle_id
                                --current_ptfx_handle_id =  Citizen.InvokeNative(0x8F90AB32E1944BDE,current_ptfx_name,PlayerPedId(),ptfx_offcet_x,ptfx_offcet_y,ptfx_offcet_z,ptfx_rot_x,ptfx_rot_y,ptfx_rot_z,ptfx_scale,ptfx_axis_x,ptfx_axis_y,ptfx_axis_z)    -- StartNetworkedParticleFxLoopedOnEntity
                            else
                                print("cant load ptfx dictionary!")
                            end
                        end
                    else
                        if SpawnedSmoke[campid] then
                            -- print("^2[Camp]^0 Smoke for camp with ID: " .. tostring(campid) .. " exists, removing it.")
                            if Citizen.InvokeNative(0x9DD5AFF561E88F2A, SpawnedSmoke[campid]) then    -- DoesParticleFxLoopedExist
                                Citizen.InvokeNative(0x459598F579C98929, SpawnedSmoke[campid], false) -- RemoveParticleFx
                            end
                            SpawnedSmoke[campid] = nil
                        end
                    end
                end
            end
        end)
    end
end)


Callback.register('murphy_camp:UpdateCamp', function(campid, data)
    if SpawnedCamps[campid] then
        local success = RemoveCamp(campid, SpawnedCamps[campid])
        RemoveBlip(Blips[campid])
        print("^2[Camp]^0 Removing camp with ID: " .. tostring(campid))
        Wait(1000)
        if success then
            if data then
                local newdata = SpawnCamp(campid, data)
                if newdata then
                    SpawnedCamps[campid] = newdata
                    local campfirecoords = vector3(newdata.campfire.coords.x, newdata.campfire.coords.y,
                        newdata.campfire.coords.z)
                    if not Blips[campid] then
                        if charid == newdata.charid then
                            Blips[campid] = Createblip(campfirecoords, Translate[2], "blip_campfire")
                        elseif GetAccess(charid, newdata.charid, newdata.guests) then
                            Blips[campid] = Createblip(campfirecoords, Translate[3], "blip_campfire")
                        end
                    elseif Blips[campid] then
                        if not GetAccess(charid, newdata.charid, newdata.guests) then
                            RemoveBlip(Blips[campid])
                        end
                    end
                else
                    SpawnedCamps[campid] = nil
                    RemoveBlip(Blips[campid])
                    print("^1[Camp]^0 Failed to spawn camp with ID: " .. tostring(campid))
                end
            else
                if SpawnedSmoke[campid] then
                    -- print("^2[Camp]^0 Smoke for camp with ID: " .. tostring(campid) .. " exists, removing it.")
                    if Citizen.InvokeNative(0x9DD5AFF561E88F2A, SpawnedSmoke[campid]) then    -- DoesParticleFxLoopedExist
                        Citizen.InvokeNative(0x459598F579C98929, SpawnedSmoke[campid], false) -- RemoveParticleFx
                    end
                    SpawnedSmoke[campid] = nil
                end
                Camps[campid] = nil
                SpawnedCamps[campid] = nil
                print("^1[Camp]^0 No data provided to update camp with ID: " .. tostring(campid))
            end
        else
            print("^1[Camp]^0 Failed to update camp with ID: " .. tostring(campid))
        end
    else
        if not Camps[campid] then
            Camps[campid] = vector3(data.campfire.coords.x, data.campfire.coords.y, data.campfire.coords.z)
        end
    end
end)

Citizen.CreateThread(function()
    while not charid or charid == 0 do Wait(500) end -- Wait for charid to be loaded (camps data is ready)
    while true do
        local playerCoords = GetEntityCoords(PlayerPedId())
        if charid and charid ~= 0 then
            for campid, coords in pairs(Camps) do
                if #(coords - playerCoords) < Config.DisplayDistance then
                    if not SpawnedCamps[campid] then
                        Callback.triggerServer('murphy_camp:GetCampComponents', function(data)
                            if data then
                                local newdata = SpawnCamp(campid, data)
                                if newdata then
                                    SpawnedCamps[campid] = newdata
                                else
                                    print("^1[Camp]^0 Failed to spawn camp with ID: " .. tostring(campid))
                                end
                            end
                        end, campid)
                    else
                        if #(coords - playerCoords) < 10.0 then
                            if Config.InviteInteract and charid == SpawnedCamps[campid].charid then
                                if not SpawnedCamps[campid].campfire.playerinteract then
                                    print("^2[Camp]^0 Adding global player interaction for camp: " .. campid)
                                    SpawnedCamps[campid].campfire.playerinteract = true
                                    exports.murphy_interact:addGlobalPlayerInteraction({
                                        distance = 6.0,
                                        interactDst = 3.0,
                                        offset = vec3(0.0, 0.0, 0.3),
                                        id = 'murphy_camp:guest',
                                        options = {
                                            name = 'interact:actionPlayer',
                                            label = Translate[8],
                                            action = function(entity, _, _, serverId)
                                                TriggerServerEvent("murphy_camp:inviteguests", campid, serverId)
                                            end,
                                        }
                                    })
                                end
                            end
                        else
                            if SpawnedCamps[campid].campfire.playerinteract then
                                exports.murphy_interact:RemoveGlobalPlayerInteraction('murphy_camp:guest')
                                SpawnedCamps[campid].campfire.playerinteract = nil
                            end
                        end
                    end
                else
                    if SpawnedCamps[campid] then
                        local success = RemoveCamp(campid, SpawnedCamps[campid])
                        if success then
                            SpawnedCamps[campid] = nil
                        else
                            print("^1[Camp]^0 Failed to remove camp with ID: " .. tostring(campid))
                        end
                    end
                end
            end
        end
        Wait(5000)
    end
end)

AddEventHandler('onResourceStop', function(res)
    if res == GetCurrentResourceName() then
        for k, v in pairs(SpawnedCamps) do
            if SpawnedSmoke[k] then
                -- print("^2[Camp]^0 Smoke for camp with ID: " .. tostring(campid) .. " exists, removing it.")
                if Citizen.InvokeNative(0x9DD5AFF561E88F2A, SpawnedSmoke[k]) then    -- DoesParticleFxLoopedExist
                    Citizen.InvokeNative(0x459598F579C98929, SpawnedSmoke[k], false) -- RemoveParticleFx
                end
                SpawnedSmoke[k] = nil
            end

            RemoveEverything(k, v)
        end
        for k, v in pairs(Blips) do
            if v then
                RemoveBlip(v)
            end
        end
    end
end)



function SpawnCamp(id, data)
    local prop = nil
    local campfirerota = data.campfire.rota
    local campfirecoords = vector3(data.campfire.coords.x, data.campfire.coords.y, data.campfire.coords.z)

    if data.campfire.propset then
        data.campfire.entity = {}
        for index, model in pairs(data.campfire.model) do
            if index > 1 then
                prop = _Propset:new(model, campfirecoords, false, true, campfirerota)
            else
                prop = _Propset:new(model, campfirecoords, false, false, campfirerota)
            end
            table.insert(data.campfire.entity, prop.id)
        end
    else
        prop = _Prop:new(data.campfire.model, campfirecoords, false)
        SetEntityCoords(prop.id, campfirecoords)
        if type(campfirerota) == "table" then
            campfirerota = campfirerota.z
        end
        SetEntityHeading(prop.id, campfirerota)
        FreezeEntityPosition(prop.id, true)
        data.campfire.entity = prop.id
    end
    InitFirePrompt(charid, id, data)

    local veg_radius = 3.0
    local veg_Flags = 1 + 2 + 4 + 8 + 16 + 32 + 64 + 128 +
        256               -- implement to all debris, grass, bush, etc...
    local veg_ModType = 1 -- 1 | VMT_Cull
    data.campfire.veg = Citizen.InvokeNative(0xFA50F79257745E74, campfirecoords, veg_radius, veg_ModType,
        veg_Flags, 0);    -- ADD_VEG_MODIFIER_SPHERE

    for key, value in pairs(data.props) do
        print("Spawning furniture: " .. key)
        local furniturecoords = vector3(value.coords.x, value.coords.y, value.coords.z)
        local furniturerota = value.rota
        local furnituremodel = value.model
        local furniture
        if value.propset == false then
            local furniture = _Prop:new(furnituremodel, furniturecoords, false)
            value.entity = furniture.id
            SetEntityCoords(furniture.id, furniturecoords)
            if type(furniturerota) == "number" then
                furniturerota = vector3(0.0, 0.0, furniturerota)
            end
            SetEntityRotation(furniture.id, furniturerota.x, furniturerota.y, furniturerota.z, 2, false)
            local interacthandle = InitPropsPrompt(furnituremodel, furniture.id, key, value, id, data)
            local minDim, maxDim = GetModelDimensions(GetEntityModel(interacthandle))
            local objectSize = #(maxDim - minDim) /
                2                                              -- Approximation de la taille de l'objet
            local veg_radius = math.max(objectSize * 1.5, 2.0) -- Ajuster le radius avec un minimum de 2.0
            local veg_Flags = 1 + 2 + 4 + 8 + 16 + 32 + 64 + 128 +
                256                                            -- implement to all debris, grass, bush, etc...
            local veg_ModType = 1                              -- 1 | VMT_Cull
            value.veg = Citizen.InvokeNative(0xFA50F79257745E74, GetEntityCoords(interacthandle),
                veg_radius, veg_ModType, veg_Flags, 0);        -- ADD_VEG_MODIFIER_SPHERE
            PlaceEntityOnGroundProperly(furniture.id)          -- Place the prop on the ground properly
            FreezeEntityPosition(furniture.id, true)
        elseif value.propset == true then
            value.entity = {}
            for index, model in pairs(furnituremodel) do
                if index > 1 then
                    furniture = _Propset:new(model, furniturecoords, false, true, furniturerota)
                else
                    furniture = _Propset:new(model, furniturecoords, false, false, furniturerota)
                end
                -- furniture.move(furniturecoords)
                -- furniture.rotate(furniturerota)
                table.insert(value.entity, furniture.id)
            end
            local interacthandle = InitPropsPrompt(furnituremodel[1], value.entity[1], key, value, id, data)
            local veg_radius = 3.5
            local veg_Flags = 1 + 2 + 4 + 8 + 16 + 32 + 64 + 128 +
                256                                     -- implement to all debris, grass, bush, etc...
            local veg_ModType = 1                       -- 1 | VMT_Cull
            value.veg = Citizen.InvokeNative(0xFA50F79257745E74, GetEntityCoords(interacthandle),
                veg_radius, veg_ModType, veg_Flags, 0); -- ADD_VEG_MODIFIER_SPHERE
        end
        value.currentcoords = value.coords
    end

    print("^2[Camp]^0 Successfully spawned camp with ID: " .. tostring(id))
    return data
end

local function GetCurrentCamp()
    local playerPed = PlayerPedId()
    for id, coords in pairs(Camps) do
        if SpawnedCamps[id] then
            local campCoords = vector3(SpawnedCamps[id].campfire.coords.x, SpawnedCamps[id].campfire.coords.y,
                SpawnedCamps[id].campfire.coords.z)
            if #(GetEntityCoords(playerPed) - campCoords) < 10.0 then
                if GetAccess(charid, SpawnedCamps[id].charid, SpawnedCamps[id].guests) then
                    return id
                end
            end
        end
    end
    return nil
end

local function GetClosestPlayer()
    local players, closestDistance, closestPlayer = GetActivePlayers(), -1, -1
    local playerPed, playerId = PlayerPedId(), PlayerId()
    for k, v in pairs(players) do
        if v ~= playerId then
            local tgt = GetPlayerPed(v)
            local distance = #(GetEntityCoords(playerPed) - GetEntityCoords(tgt))
            if closestDistance == -1 or closestDistance > distance then
                closestPlayer = v
                closestDistance = distance
            end
        end
    end
    return closestDistance, closestPlayer
end

Citizen.CreateThread(function()
    if Config.InviteCommand then
        RegisterCommand(Config.InviteCommand, function(source, args, raw)
            local closestDistance, targetid = GetClosestPlayer()
            local currentCamp = GetCurrentCamp()
            if currentCamp then
                if targetid and targetid ~= -1 then
                    if closestDistance < 5.0 then
                        TriggerServerEvent("murphy_camp:inviteguests", currentCamp, GetPlayerServerId(targetid))
                    end
                end
            end
        end)
    end

    if Config.RemoveInviteCommand then
        RegisterCommand(Config.RemoveInviteCommand, function(source, args, raw)
            local closestDistance, targetid = GetClosestPlayer()
            local currentCamp = GetCurrentCamp()
            if currentCamp then
                if targetid and targetid ~= -1 then
                    if closestDistance < 5.0 then
                        TriggerServerEvent("murphy_camp:removeguests", currentCamp, GetPlayerServerId(targetid))
                    end
                end
            end
        end)
    end
end)


function RemoveCamp(id, data)
    if data.campfire.playerinteract then
        exports.murphy_interact:RemoveGlobalPlayerInteraction('murphy_camp:guest')
        data.campfire.playerinteract = nil
    end
    if SpawnedSmoke[id] then
        -- print("^2[Camp]^0 Smoke for camp with ID: " .. tostring(campid) .. " exists, removing it.")
        if Citizen.InvokeNative(0x9DD5AFF561E88F2A, SpawnedSmoke[id]) then    -- DoesParticleFxLoopedExist
            Citizen.InvokeNative(0x459598F579C98929, SpawnedSmoke[id], false) -- RemoveParticleFx
        end
        SpawnedSmoke[id] = nil
    end
    if data.campfire.entity then
        exports.murphy_interact:RemoveInteraction(data.campfire.interacthandle, data.campfire.interacthandle)
        data.campfire.accessgranted = false
        if type(data.campfire.entity) == "table" then
            for _, entity in pairs(data.campfire.entity) do
                DeletePropset(entity, false, false)
            end
        else
            SetEntityAsMissionEntity(data.campfire.entity)
            DeleteObject(data.campfire.entity)
        end
        data.campfire.entity = nil
        Citizen.InvokeNative(0x9CF1836C03FB67A2, Citizen.PointerValueIntInitialized(data.campfire.veg), 0) -- REMOVE_VEG_MODIFIER_SPHERE
        data.campfire.veg = nil
        if data.campfire.murphy_craft then
            TriggerEvent("murphy_craft:RemoveCraftTable", data.campfire.murphy_craft)
        end
        for key, value in pairs(data.props) do
            exports.murphy_interact:RemoveInteraction(value.interacthandle, value.interacthandle)
            value.accessgranted = false
            if value.murphy_craft then
                TriggerEvent("murphy_craft:RemoveCraftTable", value.murphy_craft)
            end
            local crafttable =
            {
                name = "Feu de camp",                                             -- Blip name
                cat = { "food" },                                                 -- Categories available at this crafting table
                coords = vector3(value.coords.x, value.coords.y, value.coords.z), -- Coordinates of the crafting table
                radius = 5.0,                                                     -- Radius around the crafting table where players have access to those categories

            }
            if value.entity then
                if type(value.entity) == "table" then
                    for _, entity in pairs(value.entity) do
                        SetEntityAsMissionEntity(entity)
                        DeletePropset(entity, false, false)
                    end
                else
                    SetEntityAsMissionEntity(value.entity)
                    DeleteObject(value.entity)
                end
                value.entity = nil
            end
            Citizen.InvokeNative(0x9CF1836C03FB67A2, Citizen.PointerValueIntInitialized(value.veg), 0) -- REMOVE_VEG_MODIFIER_SPHERE
            value.veg = nil
        end
        print("^2[Camp]^0 Successfully removed camp with ID: " .. tostring(id))
        return true
    end
end
