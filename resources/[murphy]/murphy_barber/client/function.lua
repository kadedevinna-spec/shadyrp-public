---- CAMERA ----
c_offset = 0.0
c_zoom = 0.7
CamFov = 40.0
ClothingCamera = nil

Citizen.CreateThread(function()
    if Config.murphy_creator then
        MURPHY_ASSETS = exports.murphy_creator:GetMurphyAssets()
    end
end)

function camera(zoom, offset)
    local playerPed
    if MannequinPed then
        playerPed = MannequinPed
    else
        playerPed = PlayerPedId()
    end
    local coords = GetEntityCoords(playerPed)

    -- Obtenir la position du crâne du personnage
    local boneIndex = GetEntityBoneIndexByName(playerPed, "skel_head")
    local boneCoords = GetWorldPositionOfEntityBone(playerPed, boneIndex)
    if not baseHeading then
        baseHeading = GetEntityHeading(playerPed)
        -- Stocker l'offset initial pour que 180 corresponde à baseHeading
        angleOffset = 90 - baseHeading
    end

    -- Calculer le heading cible directement
    local targetHeading = (currentR - angleOffset) % 360
    local angle = math.rad(targetHeading)
    local camX = boneCoords.x + (zoom * math.cos(angle))
    local camY = boneCoords.y + (zoom * math.sin(angle))
    local camZ = boneCoords.z + offset
    -- Création ou mise à jour de la caméra
    if not ClothingCamera then
        DestroyAllCams(true)
        ClothingCamera = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", camX, camY, camZ, 300.00,
            0.00, 0.00, 40.00, false, 0)
        SetCamActive(ClothingCamera, true)
        SetCamFov(ClothingCamera, CamFov)
        RenderScriptCams(true, true, 1000, true, true)
        DisplayHud(false)
        DisplayRadar(false)
    end

    -- Mise à jour de la position de la caméra (réutilisation au lieu de recréer)
    SetCamCoord(ClothingCamera, camX, camY, camZ)
    SetCamFov(ClothingCamera, CamFov)
    PointCamAtCoord(ClothingCamera, boneCoords.x, boneCoords.y, boneCoords.z)
end

function KillCamera()
    SetCamActive(ClothingCamera, false)
    RenderScriptCams(false, true, 500, true, true)
    DisplayHud(true)
    DisplayRadar(true)
    DestroyAllCams(true)
    ClothingCamera = nil
    initialCamOffset = nil
    initialHeading = nil
    CamFov = 40.0
    -- cameraprompt:setActive(false)
end

local lamp = nil
local lamp2 = nil
CreatorLight = false
function Light()
    Citizen.CreateThread(function()
        local ped = PlayerPedId()
        if lamp ~= nil and lamp2 ~= nil then
            return
        end
        CreatorLight = true
        Wait(1000)
        local lightCoords = GetOffsetFromEntityInWorldCoords(ped, 1.2, 1.2, 0.5)
        RequestModel(GetHashKey("p_lamphanging06x"))
        while not HasModelLoaded(GetHashKey("p_lamphanging06x")) do
            Wait(0)
        end
        if CreatorLight == false then
            return
        end
        lamp = CreateObject(GetHashKey("p_lamphanging06x"), lightCoords.x, lightCoords.y, lightCoords.z, false, true,
            true)
        -- PlaceEntityOnGroundProperly(lamp)
        SetEntityLightsEnabled(lamp, true)
        SetLightsTypeForEntity(lamp, 20)
        SetLightsColorForEntity(lamp, 255, 200, 170)
        SetLightsIntensityForEntity(lamp, 0.0)
        AttachEntityToEntity(lamp, ped, GetEntityBoneIndexByName(ped, 'skel_head'), -1.4, 1.3, 1.5, -36.0, -29.0, 21.0,
            false, false, false, false, 0, false)
        SetEntityAlpha(lamp, 0, false)

        lamp2 = CreateObject(GetHashKey("p_lamphanging06x"), lightCoords.x, lightCoords.y, lightCoords.z, false, true,
            true)
        -- PlaceEntityOnGroundProperly(lamp)
        SetEntityLightsEnabled(lamp2, true)
        SetLightsTypeForEntity(lamp2, 20)
        SetLightsColorForEntity(lamp2, 255, 200, 170)
        SetLightsIntensityForEntity(lamp2, 0.0)
        AttachEntityToEntity(lamp2, ped, GetEntityBoneIndexByName(ped, 'skel_head'), 1.0, -1.1, 1.3, 22.0, 39.0, -10.0,
            false, false, false, false, 0, false)
        SetEntityAlpha(lamp2, 0, false)
        if CreatorLight == false then
            return
        end

        -- Gradually increase the light intensity over 500ms

        local duration = 500
        local steps = 50
        local stepDuration = duration / steps
        local hour = GetClockHours()
        local factor, factor2
        if hour >= 6 and hour <= 20 then
            factor = 800.0
            factor2 = 700.0
        else
            factor = 100.0
            factor2 = 60.0
        end
        for i = 1, steps do
            local intensity = (i / steps) * factor
            local intensity2 = (i / steps) * factor2
            SetLightsIntensityForEntity(lamp, intensity)
            SetLightsIntensityForEntity(lamp2, intensity2)
            Wait(stepDuration)
        end

        while CreatorLight == true do
            local hour = GetClockHours()
            if hour >= 6 and hour <= 20 then
                SetLightsIntensityForEntity(lamp, 800.0)  -- Pleine intensité pendant la journée
                UpdateLightsOnEntity(lamp)
                SetLightsIntensityForEntity(lamp2, 700.0) -- Pleine intensité pendant la journée
                UpdateLightsOnEntity(lamp2)
            else
                SetLightsIntensityForEntity(lamp, 100.0) -- Intensité réduite la nuit
                UpdateLightsOnEntity(lamp)
                SetLightsIntensityForEntity(lamp2, 60.0) -- Pleine intensité pendant la journée
                UpdateLightsOnEntity(lamp2)
            end
            Wait(100)
        end
        DeleteObject(lamp)
        DeleteObject(lamp2)
        lamp = nil
        lamp2 = nil
    end)
end

function play_anim(dict, name, time, flag, ikflag)
    RequestAnimDict(dict)
    while not HasAnimDictLoaded(dict) do
        Citizen.Wait(100)
    end
    if ikflag == nil then
        ikflag = 0
    end
    TaskPlayAnim(PlayerPedId(), dict, name, 1.0, 1.0, time, flag, 0, true, ikflag, false, 0, false)
end

function PlaySound(action, soundset)
    PlaySoundFrontend(action, soundset, true, 0)
end

function scale(value, oldMin, oldMax, newMin, newMax)
    return (((value - oldMin) * (newMax - newMin)) / (oldMax - oldMin)) + newMin
end

function RemoveAllBarber(ped)
    local equipped = GetCategoriesEquiped(ped)
    local toremove = {
        "hair",
        "beard",
        "beards_chin",
        "beards_chops",
        "beards_mustache",
        "beards_complete",
        "hair_bonnet",
        "hats",
        "hat_accessories",
    }

    for category, data in pairs(equipped) do
        local isEssential = true
        for _, essential in ipairs(toremove) do
            if category == GetHashFromString(essential) then
                isEssential = false
                break
            end
        end

        if not isEssential then
            Citizen.InvokeNative(0xD710A5007C2AC539, ped, category, 0)
        end
    end


    NativeUpdatePedVariation(ped)
end

local lastanim = 0
function ChangehairstyleAnim()
    RequestAnimDict("script_common@barber_shop@hair_cut")
    while not HasAnimDictLoaded("script_common@barber_shop@hair_cut") do
        Citizen.Wait(0)
    end
    local anim
    if IsPedMale(PlayerPedId()) then
        anim = { "idle_alittle_more_plyr", "idle_approve_plyr", "idle_cut_n_shave_plyr", "idle_shaved_plyr",
            "idle_ok_plyr", "idle_checkout_short_plyr" }
    else
        anim = { "idle_alittle_more_plyr", "idle_approve_plyr", "idle_cut_n_shave_plyr", "idle_ok_plyr",
            "idle_checkout_short_plyr" }
    end
    local selectedanim = math.random(1, #anim)
    lastanim = selectedanim
    repeat selectedanim = math.random(1, #anim) until selectedanim ~= lastanim
    local timer = GetAnimDuration("script_common@barber_shop@hair_cut", anim[selectedanim])
    if CreatorLight == false then
        return
    end
    TaskPlayAnim(PlayerPedId(), "script_common@barber_shop@hair_cut", anim[selectedanim], 1.0, 1.0, -1, 25, 0, true, 15,
        0)
    Wait(timer * 1000 * 2)
    return true
end

local lastidle = 0
function IdleAnim()
    if MannequinPed then
        ped = MannequinPed
    else
        ped = PlayerPedId()
    end
    if OutfitMenuOpen == false then return end
    RequestAnimDict("script_common@barber_shop@hair_cut")
    while not HasAnimDictLoaded("script_common@barber_shop@hair_cut") do
        Citizen.Wait(0)
    end
    local idle = { "idle_plyr", "idle_plyr" }
    local selectedidle = math.random(1, #idle)
    lastidle = selectedidle
    repeat
        Wait(50)
        selectedidle = math.random(1, #idle)
    until selectedidle ~= lastidle
    if CreatorLight == false then
        return
    end
    TaskPlayAnim(ped, "script_common@barber_shop@hair_cut", idle[selectedidle], 1.0, 1.0, -1, 25, 0, true, 15, 0)
end

function Change(id, category, change_type, value)
    id = tonumber(id)
    if MannequinPed then
        ped = MannequinPed
    else
        ped = PlayerPedId()
    end
    local gender
    if IsPedMale(ped) then gender = "male" else gender = "female" end
    if id < 1 then
        if category == "cloaks" or category == "ponchos" or category == "capes" then
            local categories = { "cloaks", "ponchos", "capes" }
            for k, v in pairs(categories) do
                Citizen.InvokeNative(0xD710A5007C2AC539, ped, v, 0)
                Citizen.InvokeNative(0xD710A5007C2AC539, ped, GetHashKey(v), 0)
                local hexHash = v:match("0x[%x]+")
                local decimalHash = tonumber(hexHash)
                Citizen.InvokeNative(0xD710A5007C2AC539, ped, decimalHash, 0)
                Citizen.InvokeNative(0xD710A5007C2AC539, ped, hexHash, true)
                NativeUpdatePedVariation(ped)
            end
        elseif category == "beard" then
            Citizen.InvokeNative(0xD710A5007C2AC539, ped, 0xF8016BCA, 0)
            NativeUpdatePedVariation(ped)
        elseif category == "hair" then
            Citizen.InvokeNative(0xD710A5007C2AC539, ped, 0x864B03AE, 0)
            NativeUpdatePedVariation(ped)
        else
            Citizen.InvokeNative(0xD710A5007C2AC539, ped, category, 0)
            Citizen.InvokeNative(0xD710A5007C2AC539, ped, GetHashKey(category), 0)
            local hexHash = category:match("0x[%x]+")
            local decimalHash = tonumber(hexHash)
            Citizen.InvokeNative(0xD710A5007C2AC539, ped, decimalHash, 0)
            Citizen.InvokeNative(0xD710A5007C2AC539, ped, hexHash, true)
            NativeUpdatePedVariation(ped)
        end
        hairstyleCache[category].model = id
    else
        if change_type == "model" then
            hairstyleCache[category].model = id
            if MURPHY_ASSETS[gender][category][id].drawable then
                hairstyleCache[category].texture = {}
                local drawable = MURPHY_ASSETS[gender][category][id].drawable
                local albedo = MURPHY_ASSETS[gender][category][id].variants[1].albedo
                local normal = MURPHY_ASSETS[gender][category][id].variants[1].normal
                local material = MURPHY_ASSETS[gender][category][id].variants[1].material
                local palette = MURPHY_ASSETS[gender][category][id].variants[1].palette
                local tint0 = MURPHY_ASSETS[gender][category][id].variants[1].tint[1]
                local tint1 = MURPHY_ASSETS[gender][category][id].variants[1].tint[2]
                local tint2 = MURPHY_ASSETS[gender][category][id].variants[1].tint[3]
                hairstyleCache[category].texture.palette = 1
                hairstyleCache[category].texture.tint0 = tint0
                hairstyleCache[category].texture.tint1 = tint1
                hairstyleCache[category].texture.tint2 = tint2
                UpdateCustomhairstyle(ped, drawable, albedo, normal, material, palette, tint0, tint1, tint2)
                if Config.DevMode then
                    SendNUIMessage({
                        type = 'clipboard',
                        data = "moveAsset " ..
                            gender .. " " .. category .. " " .. MURPHY_ASSETS[gender][category][id].drawable
                    })
                    print("Clipboard",
                        "moveAsset " .. gender .. " " .. category .. " " .. MURPHY_ASSETS[gender][category][id].drawable)
                end
            else
                local hash = MURPHY_ASSETS[gender][category][id][1].hash
                NativeSetPedComponentEnabled(ped, hash, false, true, true)
                if category == "beard" then
                    local catHash = -134124598
                    while GetComponentIndexByCategory(ped, catHash) == -1 do Wait(0) end
                    local componentIndex = GetComponentIndexByCategory(ped, catHash)
                    local _, _drawable, _albedo, _normal, _material = GetMetaPedAssetGuids(ped, componentIndex)
                    local _palette, _tint0, _tint1, _tint2 = GetMetaPedAssetTint(ped, componentIndex)
                    RemoveShopItemFromPed(ped, hash, 0, 0, 0)
                    _palette = `metaped_tint_hair`
                    hairstyleCache[category].texture = {
                        model = 1,
                        tint0 = _tint0,
                        tint1 = _tint1,
                        tint2 = _tint2,
                    }
                    UpdateCustomhairstyle(ped, _drawable, _albedo, _normal, _material, _palette, _tint0, _tint1, _tint2)
                else
                    hairstyleCache[category].texture = 1
                end
            end
        else
            if MURPHY_ASSETS[gender][category][hairstyleCache[category].model].drawable then
                drawable = MURPHY_ASSETS[gender][category][hairstyleCache[category].model].drawable
                if change_type ~= "variants" then
                    albedo = MURPHY_ASSETS[gender][category][hairstyleCache[category].model].variants
                        [hairstyleCache[category].texture.palette].albedo
                    normal = MURPHY_ASSETS[gender][category][hairstyleCache[category].model].variants
                        [hairstyleCache[category].texture.palette].normal
                    material = MURPHY_ASSETS[gender][category][hairstyleCache[category].model].variants
                        [hairstyleCache[category].texture.palette].material
                    palette = MURPHY_ASSETS[gender][category][hairstyleCache[category].model].variants
                        [hairstyleCache[category].texture.palette].palette
                end
                if change_type == "variants" then
                    albedo = MURPHY_ASSETS[gender][category][hairstyleCache[category].model].variants[value].albedo
                    normal = MURPHY_ASSETS[gender][category][hairstyleCache[category].model].variants[value].normal
                    material = MURPHY_ASSETS[gender][category][hairstyleCache[category].model].variants[value].material
                    palette = MURPHY_ASSETS[gender][category][hairstyleCache[category].model].variants[value].palette
                    tint0 = tonumber(MURPHY_ASSETS[gender][category][hairstyleCache[category].model].variants[value]
                        .tint[1])
                    tint1 = tonumber(MURPHY_ASSETS[gender][category][hairstyleCache[category].model].variants[value]
                        .tint[2])
                    tint2 = tonumber(MURPHY_ASSETS[gender][category][hairstyleCache[category].model].variants[value]
                        .tint[3])

                    hairstyleCache[category].texture.palette = value
                    hairstyleCache[category].texture.tint0 = tint0 or 0
                    hairstyleCache[category].texture.tint1 = tint1 or 0
                    hairstyleCache[category].texture.tint2 = tint2 or 0
                elseif change_type == 1 then
                    hairstyleCache[category].texture.tint0 = value
                    tint0 = value
                    tint1 = hairstyleCache[category].texture.tint1
                    tint2 = hairstyleCache[category].texture.tint2
                elseif change_type == 2 then
                    hairstyleCache[category].texture.tint1 = value
                    tint0 = hairstyleCache[category].texture.tint0
                    tint1 = value
                    tint2 = hairstyleCache[category].texture.tint2
                elseif change_type == 3 then
                    hairstyleCache[category].texture.tint2 = value
                    tint0 = hairstyleCache[category].texture.tint0
                    tint1 = hairstyleCache[category].texture.tint1
                    tint2 = value
                end
                UpdateCustomhairstyle(ped, drawable, albedo, normal, material, palette, tint0, tint1, tint2)
            else
                local catHash


                if category == "beard" then
                    catHash = -134124598
                else
                    if type(category) ~= "number" then
                        catHash = joaat(category)
                    else
                        catHash = category
                    end
                end
                if change_type == "variants" then
                    if category == "beard" then
                        local hash = MURPHY_ASSETS[gender][category][hairstyleCache[category].model][value].hash
                        NativeSetPedComponentEnabled(ped, hash, false, true, true)
                        while GetComponentIndexByCategory(ped, catHash) == -1 do Wait(0) end
                        local componentIndex = GetComponentIndexByCategory(ped, catHash)
                        local _, _drawable, _albedo, _normal, _material = GetMetaPedAssetGuids(ped, componentIndex)
                        local _palette, _tint0, _tint1, _tint2 = GetMetaPedAssetTint(ped, componentIndex)
                        RemoveShopItemFromPed(ped, hash, 0, 0, 0)
                        _palette = `metaped_tint_hair`
                        hairstyleCache[category].texture = {
                            model = value,
                            tint0 = _tint0,
                            tint1 = _tint1,
                            tint2 = _tint2,
                        }
                        UpdateCustomhairstyle(ped, _drawable, _albedo, _normal, _material, _palette, _tint0, _tint1, _tint2)
                    else
                        hairstyleCache[category].texture = value
                        NativeSetPedComponentEnabled(ped,
                            MURPHY_ASSETS[gender][category][hairstyleCache[category].model][value].hash, false, true, true)
                    end
                elseif change_type == 1 then
                    if type(hairstyleCache[category].texture) == "table" then
                        while GetComponentIndexByCategory(ped, catHash) == -1 do Wait(0) end
                        local componentIndex = GetComponentIndexByCategory(ped, catHash)
                        local _, drawable, albedo, normal, material = GetMetaPedAssetGuids(ped, componentIndex)
                        local palette, tint0, tint1, tint2 = GetMetaPedAssetTint(ped, componentIndex)
                        hairstyleCache[category].texture.tint0 = value
                        tint0 = value
                        tint1 = hairstyleCache[category].texture.tint1
                        tint2 = hairstyleCache[category].texture.tint2
                        palette = `metaped_tint_hair`
                        UpdateCustomhairstyle(ped, drawable, albedo, normal, material, palette, tint0, tint1, tint2)
                    else
                        local model = hairstyleCache[category].texture
                        hairstyleCache[category].texture = {}
                        hairstyleCache[category].texture.model = model
                        while GetComponentIndexByCategory(ped, catHash) == -1 do Wait(0) end
                        local componentIndex = GetComponentIndexByCategory(ped, catHash)
                        local _, drawable, albedo, normal, material = GetMetaPedAssetGuids(ped, componentIndex)
                        local palette, tint0, tint1, tint2 = GetMetaPedAssetTint(ped, componentIndex)
                        tint0 = value
                        hairstyleCache[category].texture.tint0 = tint0
                        hairstyleCache[category].texture.tint1 = tint1
                        hairstyleCache[category].texture.tint2 = tint2
                        palette = `metaped_tint_hair`
                        UpdateCustomhairstyle(ped, drawable, albedo, normal, material, palette, tint0, tint1, tint2)
                    end
                elseif change_type == 2 then
                    if type(hairstyleCache[category].texture) == "table" then
                        while GetComponentIndexByCategory(ped, catHash) == -1 do Wait(0) end
                        local componentIndex = GetComponentIndexByCategory(ped, catHash)
                        local _, drawable, albedo, normal, material = GetMetaPedAssetGuids(ped, componentIndex)
                        local palette, tint0, tint1, tint2 = GetMetaPedAssetTint(ped, componentIndex)
                        hairstyleCache[category].texture.tint1 = value
                        tint0 = hairstyleCache[category].texture.tint0
                        tint1 = value
                        tint2 = hairstyleCache[category].texture.tint2
                        palette = `metaped_tint_hair`
                        UpdateCustomhairstyle(ped, drawable, albedo, normal, material, palette, tint0, tint1, tint2)
                    else
                        local model = hairstyleCache[category].texture
                        hairstyleCache[category].texture = {}
                        hairstyleCache[category].texture.model = model
                        while GetComponentIndexByCategory(ped, catHash) == -1 do Wait(0) end
                        local componentIndex = GetComponentIndexByCategory(ped, catHash)
                        local _, drawable, albedo, normal, material = GetMetaPedAssetGuids(ped, componentIndex)
                        local palette, tint0, tint1, tint2 = GetMetaPedAssetTint(ped, componentIndex)
                        tint1 = value
                        hairstyleCache[category].texture.tint0 = tint0
                        hairstyleCache[category].texture.tint1 = tint1
                        hairstyleCache[category].texture.tint2 = tint2
                        palette = `metaped_tint_hair`
                        UpdateCustomhairstyle(ped, drawable, albedo, normal, material, palette, tint0, tint1, tint2)
                    end
                elseif change_type == 3 then
                    if type(hairstyleCache[category].texture) == "table" then
                        while GetComponentIndexByCategory(ped, catHash) == -1 do Wait(0) end
                        local componentIndex = GetComponentIndexByCategory(ped, catHash)
                        local _, drawable, albedo, normal, material = GetMetaPedAssetGuids(ped, componentIndex)
                        local palette, tint0, tint1, tint2 = GetMetaPedAssetTint(ped, componentIndex)
                        hairstyleCache[category].texture.tint2 = value
                        tint0 = hairstyleCache[category].texture.tint0
                        tint1 = hairstyleCache[category].texture.tint1
                        tint2 = value
                        palette = `metaped_tint_hair`
                        UpdateCustomhairstyle(ped, drawable, albedo, normal, material, palette, tint0, tint1, tint2)
                    else
                        local model = hairstyleCache[category].texture
                        hairstyleCache[category].texture = {}
                        hairstyleCache[category].texture.model = model
                        while GetComponentIndexByCategory(ped, catHash) == -1 do Wait(0) end
                        local componentIndex = GetComponentIndexByCategory(ped, catHash)
                        local _, drawable, albedo, normal, material = GetMetaPedAssetGuids(ped, componentIndex)
                        local palette, tint0, tint1, tint2 = GetMetaPedAssetTint(ped, componentIndex)
                        tint2 = value
                        hairstyleCache[category].texture.tint0 = tint0
                        hairstyleCache[category].texture.tint1 = tint1
                        hairstyleCache[category].texture.tint2 = tint2
                        palette = `metaped_tint_hair`
                        UpdateCustomhairstyle(ped, drawable, albedo, normal, material, palette, tint0, tint1, tint2)
                    end
                end
            end
        end
    end
end

RegisterNetEvent('murphy_barber:clotheitem')
AddEventHandler('murphy_barber:clotheitem', function(hairstyleComponents, outfitid, overlay, target, charid, isLoadOnly, isCharselectPreview)
    Citizen.CreateThread(function()
        local _Target = target or PlayerPedId()
        
        -- Ensure the ped exists and is loaded before proceeding
        if not DoesEntityExist(_Target) then
            print("^1[Murphy Barber] Error: Target ped does not exist^7")
            return
        end
        
        -- Wait for ped components to be fully loaded
        local attempts = 0
        while not NativeHasPedComponentLoaded(_Target) do
            Wait(100)
            attempts = attempts + 1
            if attempts > 30 then
                print("^1[Murphy Barber] Error: Ped components not loaded after 3 seconds^7")
                return
            end
        end
        
        local gender
        if IsPedMale(_Target) then gender = "male" else gender = "female" end
        
        -- Use local cache for charselect preview to avoid polluting global cache
        local localHairstyleCache
        if isCharselectPreview then
            localHairstyleCache = deepcopy(hairstyleComponents) or {}
        else
            hairstyleCache = hairstyleComponents
            localHairstyleCache = hairstyleCache
        end
        
        for k, v in pairs(MURPHY_ASSETS[gender]) do
            if localHairstyleCache[k] == nil then
                localHairstyleCache[k] = {}
                localHairstyleCache[k].model = 0
                localHairstyleCache[k].texture = 0
            end
        end
        
        if not isCharselectPreview then
            OldhairstyleCache = deepcopy(localHairstyleCache)
        end
        
        Callback.triggerServer("murphy_barber:GetCurrentOverlays", function(makeup, permanent)
            -- Use local albedo for charselect preview to avoid polluting global Actualalbedo
            local localAlbedo = nil
            Callback.triggerServer("murphy_barber:GetCharSkinTone", function(result)
                localAlbedo = result
                if not isCharselectPreview then
                    Actualalbedo = result
                end
            end, IsPedMale(_Target), charid)
            local albedoTimeout = 100
            repeat
                Wait(100)
                albedoTimeout = albedoTimeout - 1
                if Config.Debug then print("Waiting for albedo") end
            until localAlbedo ~= nil or albedoTimeout <= 0
            if albedoTimeout <= 0 then
                if Config.Debug then print("^1[Murphy Barber] Warning: albedo callback timed out^7") end
                return
            end

            -- Additional check to ensure ped still exists and head is loaded
            if not DoesEntityExist(_Target) then
                print("^1[Murphy Barber] Error: Target ped no longer exists^7")
                return
            end
            
            -- Use local overlays for charselect preview
            local localOverlays
            if isCharselectPreview then
                localOverlays = deepcopy(baseoverlay)
            end
            
            if GetHead(_Target) ~= 0 then
                if overlay == false then
                    RemoveOverlays(_Target)
                    if isCharselectPreview then
                        -- Use local overlays for charselect preview
                        for k, v in pairs(localOverlays) do
                            for key, value in pairs(makeup) do
                                if v.name == value.name then
                                    for field, val in pairs(value) do
                                        localOverlays[k][field] = val
                                    end
                                end
                            end
                            for key, value in pairs(permanent) do
                                if v.name == value.name then
                                    for field, val in pairs(value) do
                                        localOverlays[k][field] = val
                                    end
                                end
                            end
                        end
                    else
                        overlay_all_layers = deepcopy(baseoverlay)
                        for k, v in pairs(overlay_all_layers) do
                            for key, value in pairs(makeup) do
                                if v.name == value.name then
                                    for field, val in pairs(value) do
                                        overlay_all_layers[k][field] = val
                                    end
                                end
                            end
                            for key, value in pairs(permanent) do
                                if v.name == value.name then
                                    for field, val in pairs(value) do
                                        overlay_all_layers[k][field] = val
                                    end
                                end
                            end
                        end
                    end
                end
                
                local overlaysToCheck = isCharselectPreview and localOverlays or overlay_all_layers
                for k, v in pairs(overlaysToCheck) do
                    if v.visibility > 0 then
                        UpdateOverlay(_Target, isCharselectPreview and localOverlays or nil, isCharselectPreview and localAlbedo or nil)
                        break
                    end
                end
            end
            
            local canloadhair = false
            for k, v in pairs(localHairstyleCache) do
                if v.model > 0 then
                    canloadhair = true
                    break
                end
            end
            -- print("Hairstyle data:", canloadhair)
            if canloadhair then
                -- Ensure ped still exists before applying hairstyles
                if DoesEntityExist(_Target) then
                    RemoveAllBarber(_Target)
                    Wait(100) -- Small delay to ensure removal is complete
                    ReequipAllhairstyle(_Target, isCharselectPreview and localHairstyleCache or nil)
                    -- Only save to database if this is NOT a load-only or charselect preview operation
                    if charid == nil and not isLoadOnly and not isCharselectPreview then
                        TriggerServerEvent("murphy_barber:updatehairstyle", hairstyleCache, overlay_all_layers, outfitid)
                    end
                else
                    print("^1[Murphy Barber] Error: Target ped disappeared before applying hairstyles^7")
                end
            end
        end, charid)
    end)
end)

local makeupon = 0
RegisterNetEvent('murphy_barber:makeupitem')
AddEventHandler('murphy_barber:makeupitem', function(outfitid)
    if GetHead(PlayerPedId()) ~= 0 then
        local _Target = PlayerPedId()
        if makeupon == outfitid then
            makeupon = 0
            Actualalbedo = nil
            Callback.triggerServer("murphy_barber:GetCharSkinTone", function(result)
                Actualalbedo = result
            end, IsPedMale(_Target))
            local albedoTimeout = 100
            repeat
                Wait(100)
                albedoTimeout = albedoTimeout - 1
                if Config.Debug then print("Waiting for albedo") end
            until Actualalbedo ~= nil or albedoTimeout <= 0
            if albedoTimeout <= 0 then
                if Config.Debug then print("^1[Murphy Barber] Warning: albedo callback timed out^7") end
                return
            end
            RemoveOverlays(_Target)
        else
            makeupon = outfitid
            Citizen.CreateThread(function()
                Callback.triggerServer('murphy_barber:GetPreset', function(datatable, gender, permanent, makeup)
                    Actualalbedo = nil
                    Callback.triggerServer("murphy_barber:GetCharSkinTone", function(result)
                        Actualalbedo = result
                    end, IsPedMale(_Target))
                    local albedoTimeout = 100
                    repeat
                        Wait(100)
                        albedoTimeout = albedoTimeout - 1
                        if Config.Debug then print("Waiting for albedo") end
                    until Actualalbedo ~= nil or albedoTimeout <= 0
                    if albedoTimeout <= 0 then
                        if Config.Debug then print("^1[Murphy Barber] Warning: albedo callback timed out^7") end
                        return
                    end
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
                        UpdateOverlay(_Target)
                    end
                end, outfitid)
            end)
        end
    end
end)


-------- OVERLAYS --------
local textureId = -1

function RemoveOverlays(ped)
    Callback.triggerServer("murphy_barber:GetCurrentOverlays", function(makeup, permanent)
        overlay_all_layers = deepcopy(baseoverlay)
        for k, v in pairs(overlay_all_layers) do
            for key, value in pairs(permanent) do
                if v.name == value.name then
                    -- Replace direct assignment with field updates
                    for field, val in pairs(value) do
                        overlay_all_layers[k][field] = val
                    end
                end
            end
        end
        Wait(200)
        UpdateOverlay(ped)
    end)
end

-- @param ped: The ped to apply overlays to
-- @param customOverlays: Optional custom overlay data (if nil, uses global overlay_all_layers)
-- @param customAlbedo: Optional custom albedo value (if nil, uses global Actualalbedo)
function UpdateOverlay(ped, customOverlays, customAlbedo)
    if IsPedMale(ped) then
        current_texture_settings = texture_types["male"]
    else
        current_texture_settings = texture_types["female"]
    end
    local albedo = customAlbedo or Actualalbedo
    local albedoTimeout = 1000
    repeat
        Citizen.Wait(0)
        albedoTimeout = albedoTimeout - 1
        albedo = customAlbedo or Actualalbedo
    until albedo ~= nil or albedoTimeout <= 0
    if albedoTimeout <= 0 then
        print("^1[Murphy Barber] Warning: albedo not available for overlay update^7")
        return
    end
    current_texture_settings.albedo = albedo
    if textureId ~= -1 then
        Citizen.InvokeNative(0xB63B9178D0F58D82, textureId) -- reset texture
        Citizen.InvokeNative(0x6BEFAA907B076859, textureId) -- remove texture
    end
    textureId = Citizen.InvokeNative(0xC5E7204F322E49EB, current_texture_settings.albedo, current_texture_settings
        .normal, current_texture_settings.material); -- create texture
    local attempts = 0
    repeat
        attempts = attempts + 1
        Citizen.InvokeNative(0xB63B9178D0F58D82, textureId)                      -- reset texture
        Citizen.InvokeNative(0x6BEFAA907B076859, textureId)                      -- remove texture
        textureId = Citizen.InvokeNative(0xC5E7204F322E49EB, current_texture_settings.albedo,
            current_texture_settings.normal, current_texture_settings.material); -- create texture
        Citizen.Wait(10)
    until textureId ~= -1 or attempts > 20
    local overlaysToUse = customOverlays or overlay_all_layers
    for k, v in pairs(overlaysToUse) do
        if v.visibility ~= 0 then
            local overlay_id = Citizen.InvokeNative(0x86BB5FF45F193A02, textureId, v.tx_id, v.tx_normal, v.tx_material,
                v.tx_color_type, v.tx_opacity, v.tx_unk);                                   -- create overlay
            if v.tx_color_type == 0 then
                Citizen.InvokeNative(0x1ED8588524AC9BE1, textureId, overlay_id, v.palette); -- apply palette
                Citizen.InvokeNative(0x2DF59FFE6FFD6044, textureId, overlay_id, v.palette_color_primary,
                    v.palette_color_secondary, v.palette_color_tertiary)                    -- apply palette colours
            end
            Citizen.InvokeNative(0x3329AAE2882FC8E4, textureId, overlay_id, v.var);         -- apply overlay variant
            Citizen.InvokeNative(0x6C76BC24F8BB709A, textureId, overlay_id, v.opacity);     -- apply overlay opacity
        end
    end
    while not Citizen.InvokeNative(0x31DC8D3F216D8509, textureId) do -- wait till texture fully loaded
        Citizen.Wait(0)
    end
    Citizen.InvokeNative(0x0B46E25761519058, ped, `heads`, textureId) -- apply texture to current component in category "heads"
    Citizen.InvokeNative(0x92DAABA2C1C10B0E, textureId)               -- update texture
    Citizen.InvokeNative(0xCC8CA3E88256E58F, ped, 0, 1, 1, 1, false); -- refresh ped components
    Citizen.InvokeNative(0x6BEFAA907B076859, textureId)               -- remove texture
end

function OverlayChange(name, visibility, tx_id, tx_normal, tx_material, tx_color_type, tx_opacity, tx_unk, palette_id,
                       palette_color_primary, palette_color_secondary, palette_color_tertiary, var, opacity)
    for k, v in pairs(overlay_all_layers) do
        if v.name == name then
            v.visibility = visibility
            if visibility ~= 0 then
                v.tx_id_index = tx_id
                v.palette_id = palette_id

                v.tx_normal = tx_normal
                v.tx_material = tx_material
                v.tx_color_type = tx_color_type
                v.tx_opacity = tx_opacity
                v.tx_unk = tx_unk
                if tx_color_type == 0 then
                    if color_palettes[palette_id] then
                        v.palette = color_palettes[palette_id][1]
                    end
                    v.palette_color_primary = palette_color_primary
                    v.palette_color_secondary = palette_color_secondary
                    v.palette_color_tertiary = palette_color_tertiary
                end
                if name == "shadows" or name == "eyeliners" or name == "lipsticks" then
                    v.var = var
                    v.tx_id = overlays_info[name][1].id
                else
                    v.var = 0
                    v.tx_id = overlays_info[name][tx_id].id
                end
                v.opacity = opacity
            end
        end
    end
    UpdateOverlay(PlayerPedId())
end

------------ NATIVE AND BASICS ----------------

-- @param ped: The ped to apply hairstyles to
-- @param customCache: Optional custom hairstyle cache (if nil, uses global hairstyleCache)
function ReequipAllhairstyle(ped, customCache)
    local gender
    if IsPedMale(ped) then gender = "male" else gender = "female" end
    local cacheToUse = customCache or hairstyleCache

    for category, data in pairs(cacheToUse) do
        if data.model and data.model > 0 and MURPHY_ASSETS[gender] and MURPHY_ASSETS[gender][category] and MURPHY_ASSETS[gender][category][data.model] then
            local drawable = MURPHY_ASSETS[gender][category][data.model].drawable
            if drawable then
                -- Handle legacy format where texture is a number instead of a table.
                -- Reading the default tints from the asset bank (not zeroing them) prevents
                -- hair/beard/overlays from re-applying as plain white on characters whose
                -- data was saved before the texture-table migration (barber 1.18.11+).
                if type(data.texture) ~= "table" then
                    local paletteIndex = data.texture or 1
                    local variant = MURPHY_ASSETS[gender][category][data.model].variants[paletteIndex]
                    local defaultTints = (variant and variant.tint) or {}
                    data.texture = {
                        model = paletteIndex,
                        palette = paletteIndex,
                        tint0 = defaultTints[1] or 0,
                        tint1 = defaultTints[2] or 0,
                        tint2 = defaultTints[3] or 0,
                    }
                end
                local albedo = MURPHY_ASSETS[gender][category][data.model].variants[data.texture.palette].albedo
                local normal = MURPHY_ASSETS[gender][category][data.model].variants[data.texture.palette].normal
                local material = MURPHY_ASSETS[gender][category][data.model].variants[data.texture.palette].material
                local palette = MURPHY_ASSETS[gender][category][data.model].variants[data.texture.palette].palette
                local tint0 = data.texture.tint0
                local tint1 = data.texture.tint1
                local tint2 = data.texture.tint2

                UpdateCustomhairstyle(ped, drawable, albedo, normal, material, palette, tint0, tint1, tint2)
            else
                if type(data.texture) == "table" then
                    NativeSetPedComponentEnabled(ped,
                        MURPHY_ASSETS[gender][category][tonumber(data.model)][tonumber(data.texture.model)].hash, false,
                        true,
                        true)
                    local catHash
                    if category == "beard" then
                        catHash = -134124598
                    else
                        if type(category) ~= "number" then
                            catHash = joaat(category)
                        else
                            catHash = category
                        end
                    end
                    while GetComponentIndexByCategory(ped, catHash) == -1 do Wait(0) end
                    local componentIndex = GetComponentIndexByCategory(ped, catHash)
                    local _, drawable, albedo, normal, material = GetMetaPedAssetGuids(ped, componentIndex)
                    local palette, t0, t1, t2 = GetMetaPedAssetTint(ped, componentIndex)
                    RemoveShopItemFromPed(ped,
                        MURPHY_ASSETS[gender][category][tonumber(data.model)][tonumber(data.texture.model)].hash, 0, 0, 0)
                    -- RemoveShopItemFromPed(ped, FullDB[gender][k][tonumber(v.model)][1].hash, 0, 0, 0)
                    local tint0 = data.texture.tint0
                    local tint1 = data.texture.tint1
                    local tint2 = data.texture.tint2
                    palette = `metaped_tint_hair`
                    UpdateCustomhairstyle(ped, drawable, albedo, normal, material, palette, tint0, tint1, tint2)
                else
                    NativeSetPedComponentEnabled(ped, tonumber(
                            MURPHY_ASSETS[gender][category][tonumber(data.model)][tonumber(data.texture)].hash), false,
                        true, true)
                    NativeUpdatePedVariation(ped)
                end
            end
        end
    end
end

function GetComponentIndexByCategory(ped, category)
    local numComponents = GetNumComponentsInPed(ped)
    for i = 0, numComponents - 1, 1 do
        local componentCategory = GetCategoryOfComponentAtIndex(ped, i)
        if componentCategory == category then
            return i
        end
    end
end

function NativeGetPedComponentCategory(isFemale, componentHash)
    return Citizen.InvokeNative(0x5FF9A878C3D115B8, componentHash, isFemale, true)
end

function NativeSetPedComponentEnabled(ped, componentHash, immediately, isMp)
    local categoryHash = NativeGetPedComponentCategory(not IsPedMale(ped), componentHash)
    NativeFixMeshIssues(ped, categoryHash)

    Citizen.InvokeNative(0xD3A7B003ED343FD9, ped, componentHash, immediately, isMp, true)
    NativeUpdatePedVariation(ped)
end

function NativeFixMeshIssues(ped, categoryHash)
    Citizen.InvokeNative(0x59BD177A1A48600A, ped, categoryHash)
end

function SetMetaPedTag(ped, drawable, albedo, normal, material, palette, tint0, tint1, tint2)
    Citizen.InvokeNative(0xBC6DF00D7A4A6819, ped, drawable, albedo, normal, material, palette, tint0, tint1, tint2)
end

function UpdatePedVariation(ped)
    Citizen.InvokeNative(0xAAB86462966168CE, ped, true)                           -- UNKNOWN "Fixes outfit"- always paired with _UPDATE_PED_VARIATION
    Citizen.InvokeNative(0xCC8CA3E88256E58F, ped, false, true, true, true, false) -- _UPDATE_PED_VARIATION
end

function UpdateCustomhairstyle(playerPed, drawable, albedo, normal, material, palette, tint0, tint1, tint2)
    while not NativeHasPedComponentLoaded(playerPed) do
        Wait(0)
    end
    local playerPed = playerPed
    local _drawable = tonumber(drawable)
    local _albedo = tonumber(albedo)
    local _normal = tonumber(normal)
    local _material = tonumber(material)
    local _palette = tonumber(palette)
    local _tint0 = tonumber(tint0)
    local _tint1 = tonumber(tint1)
    local _tint2 = tonumber(tint2)
    SetMetaPedTag(playerPed, _drawable, _albedo, _normal, _material, _palette, _tint0, _tint1, _tint2)
    UpdatePedVariation(playerPed)
end

function NativeUpdatePedVariation(ped)
    Citizen.InvokeNative(0x704C908E9C405136, ped)
    Citizen.InvokeNative(0xAAB86462966168CE, ped, true) -- UNKNOWN "Fixes outfit"- always paired with _UPDATE_PED_VARIATION
    Citizen.InvokeNative(0xCC8CA3E88256E58F, ped, false, true, true, true, false)
    while not NativeHasPedComponentLoaded(ped) do
        Wait(1)
    end
end

function GetNumComponentsInPed(ped)
    return Citizen.InvokeNative(0x90403E8107B60E81, ped, Citizen.ResultAsInteger())
end

function GetCategoryOfComponentAtIndex(ped, componentIndex)
    return Citizen.InvokeNative(0x9b90842304c938a7, ped, componentIndex, 0, Citizen.ResultAsInteger())
end

function NativeHasPedComponentLoaded(ped)
    return Citizen.InvokeNative(0xA0BC8FAED8CFEB3C, ped)
end

function GetCategoriesEquiped(ped)
    local equiped = {}
    local numComponent = GetNumComponentsInPed(ped) or 0
    for index = 0, numComponent - 1 do
        --Get current component
        local category = GetCategoryOfComponentAtIndex(ped, index)
        equiped[category] = {
            index = index,
        }
        if category == `neckwear` then
            equiped[`neckerchiefs`] = equiped[category]
            equiped[`neckerchiefs`].category = "neckerchiefs"
        elseif category == `neckerchiefs` then
            equiped[`neckwear`] = equiped[category]
            equiped[`neckwear`].category = "neckwear"
        end
    end
    --clear cached value
    local component = equiped
    return component
end

function GetHashFromString(value)
    if type(value) == "string" then
        local number = tonumber(value)
        if number then return number end
        return joaat(value)
    end
    return value
end

function deepcopy(orig)
    local orig_type = type(orig)
    local copy
    if orig_type == 'table' then
        copy = {}
        for orig_key, orig_value in next, orig, nil do
            copy[deepcopy(orig_key)] = deepcopy(orig_value)
        end
        setmetatable(copy, deepcopy(getmetatable(orig)))
    else -- number, string, boolean, etc
        copy = orig
    end
    return copy
end

function GetHead(ped)
    local numComponents = GetNumComponentsInPed(ped)
    for i = 0, numComponents - 1, 1 do
        local componentCategory = GetCategoryOfComponentAtIndex(ped, i)
        if componentCategory == `heads` then
            local shopitem = GetShopItemComponentAtIndex(ped, i, true)
            return shopitem
        end
    end
end

RegisterNetEvent('murphy_barber:loadbarberoverlay', function()
    if LocalPlayer and LocalPlayer.state and LocalPlayer.state.murphy_appearance_paused then
        return
    end
    -- Reset global caches to ensure clean state when selecting a character
    hairstyleCache = {}
    OldhairstyleCache = {}
    
    Callback.triggerServer('murphy_barber:GetCurrentHairs', function(datatable, outfitid, makeup, permanent)
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
            TriggerEvent("murphy_barber:clotheitem", datatable, outfitid, true, nil, nil, true)
        end
    end)
end)

RegisterNetEvent('murphy_barber:loadbarberoverlayOnCharacter', function(charid, ped)
    -- Wait for ped to be valid and fully loaded
    local attempts = 0
    while not DoesEntityExist(ped) or not NativeHasPedComponentLoaded(ped) do
        Wait(100)
        attempts = attempts + 1
        if attempts > 50 then
            print("^1[Murphy Barber] Error: Ped not loaded after 5 seconds for character " .. charid .. "^7")
            return
        end
    end

    Callback.triggerServer('murphy_barber:GetCurrentHairsOnCharacter', function(datatable, outfitid, makeup, permanent)
        if datatable then
            -- Use local overlays for charselect preview - DO NOT modify global overlay_all_layers
            local localOverlays = deepcopy(baseoverlay)
            for k, v in pairs(localOverlays) do
                for key, value in pairs(makeup) do
                    if v.name == value.name then
                        -- Replace direct assignment with field updates
                        for field, val in pairs(value) do
                            localOverlays[k][field] = val
                        end
                    end
                end
                for key, value in pairs(permanent) do
                    if v.name == value.name then
                        -- Replace direct assignment with field updates
                        for field, val in pairs(value) do
                            localOverlays[k][field] = val
                        end
                    end
                end
            end
            -- Wait an additional frame to ensure ped is ready
            Wait(100)
            -- Pass isCharselectPreview = true to use fully isolated local caches
            TriggerEvent("murphy_barber:clotheitem", datatable, outfitid, true, ped, charid, true, true)
        end
    end, charid)
end)

-- Reload hairstyles on resource restart (/rc)
AddEventHandler('onClientResourceStart', function(resource)
    if resource == GetCurrentResourceName() then
        -- Only reload if a ped exists (player already spawned)
        local ped = PlayerPedId()
        if ped and DoesEntityExist(ped) then
            Wait(2000)
            TriggerEvent("murphy_barber:loadbarberoverlay")
        end
    end
end)

AddEventHandler('onResourceStop', function(resource)
    if resource == GetCurrentResourceName() then
        DeleteObject(lamp)
        DeleteObject(lamp2)
    end
end)
