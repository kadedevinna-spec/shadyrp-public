RegisterNUICallback("closeoutfitmenu", function(body, resultCallback)
    OpenPresetMenu(false)
    OpenShopMenu(false)
    OutfitPrice = 0
    TriggerEvent("murphy_barber:loadbarberoverlay")
    ClearPedTasks(PlayerPedId())
end)

baseHeading = nil
angleOffset = nil
currentH, currentZ, currentR = 0, 0, 180
RegisterNUICallback("cameraChange", function(body, resultCallback)
    local cam = body.cameraName
    local value = tonumber(body.value)
    if cam == "H" then
        -- Handle H camera change
        c_offset = scale(value, 1, 360, -0.3, 0.3)
        camera(c_zoom, c_offset)
        local boneIndex = GetEntityBoneIndexByName(PlayerPedId(), "skel_head")
        local boneCoords = GetWorldPositionOfEntityBone(PlayerPedId(), boneIndex)
        local focus = #(GetCamCoord(ClothingCamera) - boneCoords)
        SetCamFocusDistance(ClothingCamera, focus)
        if currentH >= value then
            PlaySound("Amount_Increase", "HUD_Donate_Sounds")
        else
            PlaySound("Amount_Decrease",
                "HUD_Donate_Sounds")
        end
        currentH = value
    end

    if cam == "Z" then
        CamFov = scale(value, 1, 360, 25, 50)
        SetCamFov(ClothingCamera, CamFov)
        local boneIndex = GetEntityBoneIndexByName(PlayerPedId(), "skel_head")
        local boneCoords = GetWorldPositionOfEntityBone(PlayerPedId(), boneIndex)
        local focus = #(GetCamCoord(ClothingCamera) - boneCoords)
        SetCamFocusDistance(ClothingCamera, focus)
        if currentZ >= value then
            PlaySound("Amount_Increase", "HUD_Donate_Sounds")
        else
            PlaySound("Amount_Decrease",
                "HUD_Donate_Sounds")
        end
        currentZ = value
    end

    if cam == "R" then
        local ped = PlayerPedId()
        if MannequinPed then ped = MannequinPed end

        -- Mise à jour de la position de la caméra
        camera(c_zoom, c_offset)

        local focus = #(GetCamCoord(ClothingCamera) - GetEntityCoords(ped))
        SetCamFocusDistance(ClothingCamera, focus)

        if currentR >= value then
            PlaySound("Amount_Increase", "HUD_Donate_Sounds")
        else
            PlaySound("Amount_Decrease", "HUD_Donate_Sounds")
        end
        currentR = value
    end
end)

RegisterNUICallback("createNewOutfit", function(body, resultCallback)
    -- PlaySound("SELECT", "HUD_SHOP_SOUNDSET")
    OpenShopMenu(true)
end)

local playinganim = false
local currentcategory = nil

RegisterNUICallback("itemValue", function(body, resultCallback)
    local value = tonumber(body.item)
    local category = body.category
    local menu = body.menu
    if value then
        if overlays_info[category] then
            PlaySound("Amount_Increase", "HUD_Donate_Sounds")
            local name = category
            local visibility = 1
            if value == 0 then
                visibility = 0
            end
            local tx_id = value
            if value == 0 then
                tx_id = 1
            end
            
            -- Preserve existing overlay settings if changing style
            local var = 0
            local opacity = 1.0
            local palette_id = 1
            local palette_color_primary = 0
            local palette_color_secondary = 0
            local palette_color_tertiary = 0
            
            -- Get current overlay values to preserve contextual data
            for k, v in pairs(overlay_all_layers) do
                if v.name == name and v.visibility > 0 then
                    var = v.var or 0
                    opacity = v.opacity or 1.0
                    palette_id = v.palette_id or 1
                    palette_color_primary = v.palette_color_primary or 0
                    palette_color_secondary = v.palette_color_secondary or 0
                    palette_color_tertiary = v.palette_color_tertiary or 0
                    break
                end
            end
            
            local tx_color_type = 0
            if name == "scars" or name == "scars2" or name == "scars3" or name == "spots" or name == "disc" or name == "complex" or name == "acne" or name == "ageing" or name == "moles" or name == "freckles" then
                tx_color_type = 1
            end
            
            OverlayChange(name,visibility,tx_id,0,0,tx_color_type,1.0,0,palette_id,palette_color_primary,palette_color_secondary,palette_color_tertiary,var,opacity)
        else
            Change(value, category, "model")
            if hairstyleCache[category].model > value then
                PlaySound("Amount_Decrease", "HUD_Donate_Sounds")
            else
                PlaySound("Amount_Increase", "HUD_Donate_Sounds")
            end
        end
        UpdateContextualDatas(value, category)
        if not playinganim then
            playinganim = true
            ChangehairstyleAnim()
            playinganim = false
            IdleAnim()
        end
    else
        if not overlays_info[category] then
            if hairstyleCache[category].model == 0 then
                if ContextualDataOn then
                    ContextualDataOn = false
                    PlaySound("SELECT", "HUD_PLAYER_MENU")
                    SendNUIMessage(
                        {
                            type = "hidecontextualDatas",

                        }
                    )
                end
            elseif hairstyleCache[category].model > 0 then
                -- if ContextualDataOn == false then
                UpdateContextualDatas(hairstyleCache[category].model, category)
                -- end
            end
            if currentcategory ~= category then
                PlaySound("Amount_Increase", "HUD_Donate_Sounds")
            end
        end
    end
    currentcategory = category
    CalculatePrice()
end)

RegisterNUICallback("varValue", function(body, resultCallback)
    local value = tonumber(body.item)
    local category = body.category
    local reference
    if overlays_info[category] then
        local name = category
        local advancedValue = body.advancedValue
        local itemValue = body.itemValue
        for k,v in pairs(overlay_all_layers) do
            if v.name==name then
                if advancedValue == "Opacity" then
                    itemValue = scale(itemValue, 0, 100, 0.0, 1.0)
                    if v.opacity > itemValue then
                        PlaySound("Amount_Decrease", "HUD_Donate_Sounds")
                    else
                        PlaySound("Amount_Increase", "HUD_Donate_Sounds")
                    end
                    v.opacity = itemValue
                end
                if advancedValue == "Palette" then
                    if v.palette_id > tonumber(itemValue) then
                        PlaySound("Amount_Decrease", "HUD_Donate_Sounds")
                    else
                        PlaySound("Amount_Increase", "HUD_Donate_Sounds")
                    end
                    v.palette_id = tonumber(itemValue)
                end
                local visibility = v.visibility
                local tx_id = v.tx_id_index
                local var = v.var
                if value then
                    if var > value then
                        PlaySound("Amount_Decrease", "HUD_Donate_Sounds")
                    else
                        PlaySound("Amount_Increase", "HUD_Donate_Sounds")
                    end
                    var = value
                end
                local tx_color_type = v.tx_color_type
                local opacity = v.opacity
                local palette_id = v.palette_id
                local palette_color_primary = v.palette_color_primary
                local palette_color_secondary = v.palette_color_secondary
                local palette_color_tertiary = v.palette_color_tertiary
                OverlayChange(name,visibility,tx_id,0,0,tx_color_type,1.0,0,palette_id,palette_color_primary,palette_color_secondary,palette_color_tertiary,var,opacity)
            end 
        end
    else
        if type(hairstyleCache[category].texture) == "table" then
            reference = hairstyleCache[category].texture.palette or hairstyleCache[category].texture.model
        else
            reference = hairstyleCache[category].texture
        end
        if reference > value then
            PlaySound("Amount_Decrease", "HUD_Donate_Sounds")
        else
            PlaySound("Amount_Increase", "HUD_Donate_Sounds")
        end
        if category == "bodies_upper" or category == "bodies_lower" then
            if value then
                ChangeSkin(category, hairstyleCache[category].model, "variants", value)
            end
        else
            Change(hairstyleCache[category].model, category, "variants", value)
        end
    end
end)

RegisterNUICallback("tintValue", function(body, resultCallback)
    local value = tonumber(body.value)
    local tintId = tonumber(body.tintId)
    local category = body.category
    local reference
    if overlays_info[category] then
        local name = category
        for k,v in pairs(overlay_all_layers) do
            if v.name==name then
                local visibility = v.visibility
                local tx_id = v.tx_id_index
                local var = v.var
                -- if value then
                --     var = value
                -- end
                local tx_color_type = v.tx_color_type
                local opacity = v.opacity
                local palette_id = v.palette_id
                if tintId == 1 then
                    v.palette_color_primary = value
                end
                local palette_color_primary = v.palette_color_primary
                if tintId == 2 then
                    v.palette_color_secondary = value
                end
                local palette_color_secondary = v.palette_color_secondary
                if tintId == 3 then
                    v.palette_color_tertiary = value
                end
                local palette_color_tertiary = v.palette_color_tertiary
                OverlayChange(name,visibility,tx_id,0,0,tx_color_type,1.0,0,palette_id,palette_color_primary,palette_color_secondary,palette_color_tertiary,var,opacity)
            end 
        end
    else
        if type(hairstyleCache[category].texture) == "table" then
            reference = hairstyleCache[category].texture["tint" .. tostring(tintId - 1)]
        else
            reference = 0
        end
        if reference > value then
            PlaySound("Amount_Decrease",
                "HUD_Donate_Sounds")
        else
            PlaySound("Amount_Increase", "HUD_Donate_Sounds")
        end
        Change(hairstyleCache[category].model, category, tintId, value)
    end
end)

RegisterNUICallback("resetOutfit", function(body, resultCallback)
    local ped = PlayerPedId()
    RemoveAllBarber(ped)
    RemoveOverlays(ped)
    local gender = "female"
    if IsPedMale(ped) then gender = "male" end
    for k, v in pairs(MURPHY_ASSETS[gender]) do
        hairstyleCache[k] = {}
        hairstyleCache[k].model = 0
        hairstyleCache[k].texture = 0
    end
    CalculatePrice()
    PlaySound("UNAFFORDABLE", "Ledger_Sounds")
end)

RegisterNUICallback("backToOutfitList", function(body, resultCallback)
    OpenShopMenu(false)
    PlaySound("BACK", "HUD_SHOP_SOUNDSET")
    TriggerEvent("murphy_barber:loadbarberoverlay")
end)

RegisterNUICallback("closeMyOutfitMenu", function(body, resultCallback)
    
    -- Callback.triggerServer('murphy_clothing:GetCurrenthairstyle', function(datatable, id)
    --     if datatable then
    --         TriggerEvent("murphy_hairstyle:clotheitem",datatable, id)
    --     end
    -- end)
end)

RegisterNUICallback("showOutfit", function(body, resultCallback)
    local id = body.outfit
    local ped = PlayerPedId()
    PlaySound("SELECT", "HUD_PLAYER_MENU")
    Callback.triggerServer('murphy_barber:GetPreset', function(datatable, gender,permanent, makeup)
        if datatable then
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
            TriggerEvent("murphy_barber:clotheitem", datatable, id, true)
        end
    end, id)
end)

RegisterNUICallback("modifyOutfit", function(body, resultCallback)
    local id = body.outfit
    local price = body.price
    Callback.triggerServer('murphy_barber:GetPreset', function(datatable, gender,permanent, makeup)
        if datatable then

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
            TriggerEvent("murphy_barber:clotheitem", datatable, id, true)
            OutfitPrice = price
            OpenShopMenu(true, id)
            Wait(300)
            CalculatePrice()
        end
    end, id)
end)

RegisterNUICallback("recoverOutfit", function(body, resultCallback)
    local id = body.outfit
    local name = body.name
    local price = body.price
    Callback.triggerServer('murphy_barber:GivePreset', function(result)
        if result then
            OpenPresetMenu(false)
            TriggerEvent("murphy_barber:clotheitem", hairstyleCache, id)
            PlaySound("PURCHASE", "Ledger_Sounds")
        else
            PlaySound("UNAFFORDABLE", "Ledger_Sounds")
        end
    end, id, name, price)
end)

RegisterNUICallback("deleteOutfit", function(body, resultCallback)
    local id = body.outfit
    Callback.triggerServer('murphy_barber:DeletePreset', function(result)
        if result then
            OpenPresetMenu(true, true)
        else
            PlaySound("UNAFFORDABLE", "Ledger_Sounds")
        end
    end, id)
end)

---- SAVE ----
RegisterNUICallback("createOutfit", function(body, resultCallback)
    local name = body.outfitName
    local price = CalculatePrice()
    local ped = PlayerPedId()
    local gender = false
    if IsPedMale(ped) then gender = true end
    Callback.triggerServer('murphy_barber:SavePreset', function(result, outfitid)
        if result then
            OpenShopMenu(false)
            TriggerEvent("murphy_barber:clotheitem", hairstyleCache, outfitid)
            PlaySound("PURCHASE", "Ledger_Sounds")
        else
            PlaySound("UNAFFORDABLE", "Ledger_Sounds")
        end
    end, hairstyleCache, overlay_all_layers, name, price, gender)
end)

RegisterNUICallback("saveOutfit", function(body, resultCallback)
    local outfitid = body.outfitid
    local price = CalculatePrice()
    Callback.triggerServer('murphy_barber:ModifyPreset', function(result)
        if result then
            OpenShopMenu(false)
            TriggerEvent("murphy_barber:clotheitem", hairstyleCache, outfitid)
            PlaySound("PURCHASE", "Ledger_Sounds")
        else
            PlaySound("UNAFFORDABLE", "Ledger_Sounds")
        end
    end, hairstyleCache, overlay_all_layers, outfitid, price)
end)
