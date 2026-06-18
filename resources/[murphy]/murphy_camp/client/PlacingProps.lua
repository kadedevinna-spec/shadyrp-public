ShowingLimitation = false

RegisterNetEvent("murphy_camp:placecampfire", function(key)
    local current_town = GetTownNameAtCoords(meCoords)
    if current_town == false or Config.BannedCity[current_town] == false then
        local propsetdata = nil
        if Config.Campfire[key].props then 
            propsetdata = CreatePropWithMouse(Config.Campfire[key].props, 1, 15.0)
        elseif Config.Campfire[key].propset then
            propsetdata = CreatePropsetWithMouse(Config.Campfire[key].propset[1], 1, 15.0)
        end
        ShowingLimitation = false
        if propsetdata ~= nil then
            local propscoords = vector3(propsetdata.coords.x, propsetdata.coords.y, propsetdata.coords.z)
            for k, v in pairs(Camps) do
                local campfirecoords = v
                local distance = #(meCoords - campfirecoords)

                if closestDistance == nil or distance < closestDistance then
                    closestDistance = distance
                    closestCampfire = v
                end
            end

            if closestCampfire then
                local campfirecoords = closestCampfire
                if #(propscoords - campfirecoords) > Config.InterdictionRadius then
                    TriggerServerEvent("murphy_camp:savecampfire", key, propsetdata)
                else
                    TriggerEvent('murphy_camp:ShowAdvancedRightNotification', Translate[19], "itemtype_textures" , "itemtype_camp" , "COLOR_WHITE", 4000)
                end
            else
                TriggerServerEvent("murphy_camp:savecampfire", key, propsetdata)
            end
        end
    else
        TriggerEvent('murphy_camp:ShowAdvancedRightNotification', Translate[20], "itemtype_textures" , "itemtype_camp" , "COLOR_WHITE", 4000)

    end
end)

RegisterNetEvent("murphy_camp:placefurnitures", function(key)
    local playerPed = PlayerPedId()
    local playerPos = GetEntityCoords(playerPed)
    local closestDistance = nil
    local closestCampfire = nil
    for k, v in pairs(Camps) do
        local campfirecoords = v
        local distance = #(playerPos - campfirecoords)

        if closestDistance == nil or distance < closestDistance then
            closestDistance = distance
            closestCampfire = v
            closestCampfireID = k
        end
    end
    if closestCampfire then
        if closestDistance and closestDistance < Config.DisplayDistance then
            local  model = SpawnedCamps[closestCampfireID].campfire.model
            for key, value in pairs(Config.Campfire) do
                if value.propset then
                    if tablesAreEqual(model, value.propset) then
                        radius = value.radius
                        maxstash = value.stashlimit
                        break
                    end
                elseif value.props then
                    if value.props == model then
                        radius = value.radius
                        maxstash = value.stashlimit
                        break
                    end
                end
            end
            local campfirecoords = vector3(SpawnedCamps[closestCampfireID].campfire.coords.x, SpawnedCamps[closestCampfireID].campfire.coords.y, SpawnedCamps[closestCampfireID].campfire.coords.z)
            if #(playerPos - campfirecoords) < radius then
                TriggerEvent("murphy_camp:DrawMarker", campfirecoords, radius)
                local offset = GetOffsetFromEntityInWorldCoords(playerPed, 0, 1.0, 0)
                if Config.Furnitures[key].props then
                    local propsetdata = CreatePropWithMouse(Config.Furnitures[key].props, 1, 15.0)
                    ShowingLimitation = false
                    if propsetdata ~= nil then
                        local propscoords = vector3(propsetdata.coords.x, propsetdata.coords.y, propsetdata.coords.z)
                        if #(propscoords - campfirecoords) < radius then
                            TriggerServerEvent("murphy_camp:savefurnitures", key, propsetdata, closestCampfireID, maxstash)
                        else
                            TriggerEvent('murphy_notify:Tip', Translate[21], 4000)
                        end
                    end
                end
                if Config.Furnitures[key].propset then
                    local model = nil
                    if type(Config.Furnitures[key].propset) == "string" then
                        model = Config.Furnitures[key].propset
                    elseif type(Config.Furnitures[key].propset) == "table" then
                        model = Config.Furnitures[key].propset[1]
                    end
                    local propsetdata = CreatePropsetWithMouse(model, 1, 15.0)
                    ShowingLimitation = false
                    if propsetdata ~= nil then
                        local propscoords = vector3(propsetdata.coords.x, propsetdata.coords.y, propsetdata.coords.z)
                        if #(propscoords - campfirecoords) < radius then
                            TriggerServerEvent("murphy_camp:savefurnitures", key, propsetdata, closestCampfireID, maxstash)
                        else
                            TriggerEvent('murphy_notify:Tip', Translate[21], 4000)
                        end
                    end
                end
            else
                TriggerEvent('murphy_notify:Tip', Translate[21], 4000)
            end
        else
            TriggerEvent('murphy_notify:Tip', Translate[21], 4000)
        end
    else TriggerEvent('murphy_notify:Tip', Translate[21], 4000) end
end)

RegisterNetEvent("murphy_camp:DrawMarker", function(coords, radius)
    ShowingLimitation = true
    local _coords = coords
    while ShowingLimitation do
        Citizen.Wait(0)
        Citizen.InvokeNative(0x2A32FAA57B937173,0x94FDAE17,_coords.x,_coords.y,_coords.z-10.0,0,0,0,0,0,0,radius*2,radius*2,12.0,114,200,200,250,0, 0, 2, 0, 0, 0, 0)
    end
end)