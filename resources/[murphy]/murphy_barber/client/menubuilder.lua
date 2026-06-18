local menucategories = {
    male = {
        categories = { "barber", "lifestyle", "makeup" },
        barber = {
            "hairstabble", "hair", "hair_bonnet", "beardstabble", "beard", "beards_complete", "beards_chin",
            "beards_chops", "beards_mustache"
        },

        makeup = {
            "eyeliners", "lipsticks", "shadows", "paintedmasks", "blush", "blush2", "foundation",
        },

        lifestyle = {
            "eyebrows", "scars", "scars2", "scars3", "acne", "ageing", "complex", "disc", "freckles", "grime", "moles",
            "spots"
        },

    },
    female = {
        categories = { "barber", "lifestyle", "makeup" },
        barber = {
            "hair", "hair_bonnet", "beard", "beards_complete", "beards_chin", "beards_chops", "beards_mustache"
        },

        makeup = {
            "eyeliners", "lipsticks", "shadows", "paintedmasks", "blush", "blush2", "foundation",
        },

        lifestyle = {
            "eyebrows", "scars", "scars2", "scars3", "acne", "ageing", "complex", "disc", "freckles", "grime", "moles",
            "spots"
        },
    }
}



SelectedGender = "female"
if Config.MenuCommand then
    RegisterCommand(Config.MenuCommand, function()
        OpenPresetMenu(true)
    end, false)
end

function OpenPresetMenu(show, skipanim)
    if not show then
        SendNUIMessage(
            {
                type = "closeOutfitListMenu",

            }
        )
        PlaySound("INFO_HIDE", "HUD_SHOP_SOUNDSET")
        ClearPedTasks(PlayerPedId())
        SetNuiFocus(false, false)
        CreatorLight = false
        ContextualDataOn = false
        KillCamera()
        baseHeading = nil
        angleOffset = nil
        currentH, currentZ, currentR = 0, 0, 180
        -- SwitchOffCam()
        CurrentPrice = 0
    elseif show then
        local displaymenu = false
        if skipanim ~= true then
            local scenario_coords
            local DataStruct = DataView.ArrayBuffer(256 * 4)
            local is_data_exists = Citizen.InvokeNative(0x345EC3B7EBDE1CB5, GetEntityCoords(PlayerPedId()), 3.5,
                DataStruct:Buffer(), 10)
            if is_data_exists ~= false then
                for i = 1, is_data_exists, 1 do
                    local scenario = DataStruct:GetInt32(8 * i)
                    local hash = GetScenarioPointType(scenario)
                    if `PROP_PLAYER_BARBER_SEAT` == hash then
                        local optional_conditional_anim_hash = "PROP_HUMAN_SEAT_CHAIR_GENERIC_FEMALE_B"
                        if IsPedMale(PlayerPedId()) then
                            optional_conditional_anim_hash =
                            "PROP_HUMAN_SEAT_CHAIR_GENERIC_MALE_B"
                        end
                        -- Citizen.InvokeNative(0xCCDAE6324B6A821C, PlayerPedId(), scenario, optional_conditional_anim_hash, -1, 1, 0, 0, -1.0, 1)
                        -- Citizen.InvokeNative(0xCCDAE6324B6A821C, PlayerPedId(), scenario, optional_conditional_anim_hash, 0, true, false, 0, false, -1.0, false)
                        TaskUseScenarioPoint(PlayerPedId(), scenario, 0, 0, true);
                        scenario_coords = GetScenarioPointCoords(scenario, true)
                    end
                end
            end
            if not scenario_coords then
                local chairs = { "p_barberchair03x", "p_barberchair01x", "p_barberchair02x" }
                local itemSet = CreateItemset(true)
                local size = Citizen.InvokeNative(0x59B57C4B06531E1E, GetEntityCoords(PlayerPedId()), 10.0, itemSet, 3,
                    Citizen.ResultAsInteger())
                if size > 0 then
                    for index = 0, size - 1 do
                        local prop = GetIndexedItemInItemset(index, itemSet) -- Add entity in itemSet
                        local model = GetEntityModel(prop)
                        for k, v in pairs(chairs) do
                            if model == GetHashKey(v) then
                                local scenario = Citizen.InvokeNative(0x794AB1379A74064D, prop,
                                    GetHashKey("PROP_PLAYER_BARBER_SEAT"), 0.0, 0.12, 0.75423, 180.0, 1, 1, true);
                                Citizen.InvokeNative(0x5AF19B6CC2115D34, scenario, 23, true);
                                Citizen.InvokeNative(0x5AF19B6CC2115D34, scenario, 25, true);
                                scenario_coords = GetScenarioPointCoords(scenario, true)
                                local optional_conditional_anim_hash = "PROP_HUMAN_SEAT_CHAIR_GENERIC_FEMALE_B"
                                if IsPedMale(PlayerPedId()) then
                                    optional_conditional_anim_hash =
                                    "PROP_HUMAN_SEAT_CHAIR_GENERIC_MALE_B"
                                end
                                -- Citizen.InvokeNative(0xCCDAE6324B6A821C, PlayerPedId(), scenario, optional_conditional_anim_hash, -1, 1, 0, 0, -1.0, 1)
                                TaskUseScenarioPoint(PlayerPedId(), scenario, 0, 0, true);
                            end
                        end
                    end
                end
                if IsItemsetValid(itemSet) then
                    DestroyItemset(itemSet)
                end
            end
            local attempt = 0
            repeat
                Wait(1000)
                attempt = attempt + 1
                if scenario_coords then
                    local distance = #(GetEntityCoords(PlayerPedId()) - scenario_coords)
                    if distance < 0.2 then
                        Wait(1500)
                        play_anim("script_common@barber_shop@hair_cut", "idle_plyr", -1, 25, 15)
                        Wait(1000)
                        displaymenu = true
                    end
                else
                    print("No barberchair found")
                end
            until displaymenu or attempt > 15
        else
            displaymenu = true
        end
        if displaymenu then
            Callback.triggerServer('murphy_barber:GetCurrentPresetList', function(datatable)
                if datatable then
                    local presets = {}
                    for k, v in pairs(datatable) do
                        table.insert(presets, {
                            id = v.outfit_id,
                            name = v.name,
                            Value = v.price
                        })
                    end
                    camera(c_zoom, c_offset)
                    Light()
                    SendNUIMessage(
                        {
                            type = "openOutfitListMenu",
                            outfits = presets
                        }
                    )
                    PlaySound("INFO", "HUD_SHOP_SOUNDSET")
                    SetNuiFocus(true, true)
                end
            end)
        end
    end
end

SelectedGender = "male"
Playerjob, PlayerJobGrade = nil, nil
Actualalbedo = nil
function OpenShopMenu(show, outfitid)
    if not show then
        SendNUIMessage(
            {
                type = "closeOutfitMenu",

            }
        )
        SetNuiFocus(false, false)
        PlaySound("INFO_HIDE", "HUD_SHOP_SOUNDSET")
        ClearPedTasks(PlayerPedId())
        CreatorLight = false
        ContextualDataOn = false
        KillCamera()
        baseHeading = nil
        angleOffset = nil
        currentH, currentZ, currentR = 0, 0, 180
        -- SwitchOffCam()
        CurrentPrice = 0
    elseif show then
        SendNUIMessage(
            {
                type = "closeOutfitListMenu",

            }
        )
        PlaySound("INFO_HIDE", "HUD_SHOP_SOUNDSET")
        local ped = PlayerPedId()
        local showoverlay = false
        if GetHead(ped) ~= 0 then
            showoverlay = true
            Actualalbedo = nil
            Callback.triggerServer("murphy_barber:GetCharSkinTone", function(result)
                Actualalbedo = result
            end, IsPedMale(ped))
            local albedoTimeout = 100
            repeat
                Wait(100)
                albedoTimeout = albedoTimeout - 1
                if Config.Debug then print("Waiting for albedo") end
            until Actualalbedo ~= nil or albedoTimeout <= 0
            if albedoTimeout <= 0 then
                if Config.Debug then print("^1[Murphy Barber] Warning: albedo callback timed out^7") end
            end
        end
        RemoveAllBarber(ped)
        Callback.triggerServer('murphy_barber:GetCurrentHairs', function(datatable, id, makeup, permanent)
            if IsPedMale(ped) then SelectedGender = "male" else SelectedGender = "female" end
            if outfitid then
                -- RemoveOverlays(ped)
                if datatable then
                    hairstyleCache = datatable
                    for k, v in pairs(MURPHY_ASSETS[SelectedGender]) do
                        if hairstyleCache[k] == nil then
                            hairstyleCache[k] = {}
                            hairstyleCache[k].model = 0
                            hairstyleCache[k].texture = 0
                        end
                    end
                    OldhairstyleCache = deepcopy(hairstyleCache)
                end
                overlay_all_layers = deepcopy(baseoverlay)
                for k, v in pairs(overlay_all_layers) do
                    for key, value in pairs(makeup) do
                        if v.name == value.name then
                            -- Replace direct assignment with field updates
                            for field, val in pairs(value) do
                                overlay_all_layers[k][field] = val
                            end
                        end
                    end
                    for key, value in pairs(permanent) do
                        if v.name == value.name then
                            -- Replace direct assignment with field updates
                            for field, val in pairs(value) do
                                overlay_all_layers[k][field] = val
                            end
                        end
                    end
                end
                if showoverlay then
                    UpdateOverlay(ped)
                end
            else
                if showoverlay then
                    RemoveOverlays(ped)
                end
                hairstyleCache = {}
                for k, v in pairs(MURPHY_ASSETS[SelectedGender]) do
                    if hairstyleCache[k] == nil then
                        hairstyleCache[k] = {}
                        hairstyleCache[k].model = 0
                        hairstyleCache[k].texture = 0
                    end
                end
                OldhairstyleCache = deepcopy(hairstyleCache)
            end
            local categories = {}

            for _, k in ipairs(menucategories[SelectedGender].categories) do
                if k == "makeup" or k == "lifestyle" then
                    if showoverlay then
                        table.insert(categories,
                            { id = k, name = k, image = "./img/categories/" .. k .. ".png" })
                    end
                else
                    table.insert(categories,
                        { id = k, name = k, image = "./img/categories/" .. k .. ".png" })
                end
            end

            local items = {}
            for key, value in pairs(menucategories[SelectedGender]) do
                for index, cat in pairs(value) do
                    if MURPHY_ASSETS[SelectedGender][cat] == nil then
                        -- print("Category not found: " .. cat)
                    else
                        if next(MURPHY_ASSETS[SelectedGender][cat]) ~= nil then
                            if tostring(key) ~= "categories" then
                                table.insert(items, {
                                    id = cat,
                                    name = Lang.Categories[cat] or cat,
                                    category = key,
                                    totalAmount = #MURPHY_ASSETS[SelectedGender][cat],
                                    selectorType = "slider",
                                    contextual = "variation",
                                    value = hairstyleCache[cat].model or 0,
                                })
                            end
                        end
                    end
                    if showoverlay then
                        for overlay, v in pairs(overlays_info) do
                            local cache = nil
                            if overlay == cat then
                                for k, value in pairs(overlay_all_layers) do
                                    if value.name == cat then
                                        -- Replace direct assignment with field updates
                                        if overlay_all_layers[k].tx_id_index ~= nil then
                                            cache = overlay_all_layers[k].tx_id_index
                                        end
                                    end
                                end
                                table.insert(items, {
                                    id = cat,
                                    name = Lang.Categories[cat] or cat,
                                    category = key,
                                    totalAmount = #overlays_info[cat],
                                    selectorType = "slider",
                                    contextual = "variation",
                                    value = cache or 0,
                                })
                            end
                        end
                    end
                end
            end



            if not outfitid then
                SendNUIMessage(
                    {
                        type = "openOutfitMenu",
                        categories = categories,
                        items = items
                    }
                )
            else
                SendNUIMessage(
                    {
                        type = "openOutfitMenu",
                        menu = "modify",
                        outfitId = outfitid,
                        categories = categories,
                        items = items
                    }
                )
            end

            PlaySound("INFO", "HUD_SHOP_SOUNDSET")
            SetNuiFocus(true, true)
        end)
    end
end

AddEventHandler('onResourceStop', function(resource)
    if resource == GetCurrentResourceName() then
        OpenPresetMenu(false)
        KillCamera()
        ClearPedTasksImmediately(PlayerPedId())
        TaskClearLookAt(PlayerPedId())
    end
end)
