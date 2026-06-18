if Config.framework == 'vorp' then
    RegisterNetEvent('vorp:SelectedCharacter')
    AddEventHandler('vorp:SelectedCharacter', function()
        Callback.triggerServer('murphy_clothing:GetCurrentClothes', function(datatable, id)
            if IsPedMale(PlayerPedId()) then SelectedGender = "male" else SelectedGender = "female" end
            Wait(1000)
    if type(baseskin) ~= "table" then
        baseskin = {}
    end

    -- Wait for the ped's base body components to be ready before capturing the skin.
    -- VORP + murphy_creator can finish loading the player model after vorp:SelectedCharacter
    -- fires; capturing too early yields false/0 hashes, which later make the body invisible
    -- when saved wearable states are re-applied on top of an invalid base.
    local ped = PlayerPedId()
    local readyAttempts = 0
    local upperHash, lowerHash
    repeat
        ped = PlayerPedId()
        upperHash = GetComponentEquiped(ped, "bodies_upper")
        lowerHash = GetComponentEquiped(ped, "bodies_lower")
        if (upperHash and upperHash ~= 0 and upperHash ~= false)
            and (lowerHash and lowerHash ~= 0 and lowerHash ~= false) then
            break
        end
        Wait(200)
        readyAttempts = readyAttempts + 1
    until readyAttempts >= 50 -- 10s safety cap

    -- Fallback: if the ped still has no base body components (VORP defaults on mp_male /
    -- mp_female without an outfit preset applied), force-equip the default preset so that
    -- bodies_upper / bodies_lower become resolvable before we capture and re-apply saved
    -- wearable states on top.
    if not upperHash or upperHash == 0 or upperHash == false
        or not lowerHash or lowerHash == 0 or lowerHash == false then
        ped = PlayerPedId()
        EquipMetaPedOutfitPreset(ped, 0, false)
        local fallbackAttempts = 0
        repeat
            Wait(200)
            ped = PlayerPedId()
            upperHash = GetComponentEquiped(ped, "bodies_upper")
            lowerHash = GetComponentEquiped(ped, "bodies_lower")
            fallbackAttempts = fallbackAttempts + 1
        until ((upperHash and upperHash ~= 0 and upperHash ~= false)
            and (lowerHash and lowerHash ~= 0 and lowerHash ~= false))
            or fallbackAttempts >= 15 -- 3s fallback cap
    end

    local equipped = GetCategoriesEquiped(ped)

    if not baseskin["bodies_upper"] or baseskin["bodies_upper"] == 0 or baseskin["bodies_upper"] == false then
        baseskin["bodies_upper"] = upperHash
        -- Store original albedo to preserve skin color
        if equipped[`bodies_upper`] then
            local index = equipped[`bodies_upper`].index
            local _, albedo, _, _ = GetMetaPedAssetGuids(ped, index)
            baseskin["bodies_upper_albedo"] = albedo
        end
    end

    if not baseskin["bodies_lower"] or baseskin["bodies_lower"] == 0 or baseskin["bodies_lower"] == false then
        baseskin["bodies_lower"] = lowerHash
        -- Store original albedo to preserve skin color
        if equipped[`bodies_lower`] then
            local index = equipped[`bodies_lower`].index
            local _, albedo, _, _ = GetMetaPedAssetGuids(ped, index)
            baseskin["bodies_lower_albedo"] = albedo
        end
    end

            if Config.Debug then
                print(string.format("Base skin loaded: Upper Body = %s (albedo: %s), Lower Body = %s (albedo: %s)",
                    tostring(baseskin["bodies_upper"]), tostring(baseskin["bodies_upper_albedo"]),
                    tostring(baseskin["bodies_lower"]), tostring(baseskin["bodies_lower_albedo"])))
            end

            -- Abort applying saved clothes if we still couldn't resolve a valid base body.
            -- Re-applying wearable states on top of an invalid hash is what produces the
            -- "invisible body" look reported by several clients.
            if not baseskin["bodies_upper"] or baseskin["bodies_upper"] == 0 or baseskin["bodies_upper"] == false
                or not baseskin["bodies_lower"] or baseskin["bodies_lower"] == 0 or baseskin["bodies_lower"] == false then
                print("^3[murphy_clothing] base body components not ready after 10s; skipping saved clothes load to avoid invisible body.^7")
                return
            end
            if datatable then
                local loadclothes = false
                for k, v in pairs(datatable) do
                    if v.model > 0 then
                        loadclothes = true
                        break
                    end
                end
                if loadclothes then
                    TriggerEvent("murphy_clothes:clotheitem",datatable, id)
                end
            end
        end)
    end)
    
        RegisterNetEvent('vorp_core:Client:OnPlayerRevive')
        AddEventHandler('vorp_core:Client:OnPlayerRevive', function ()
            Wait(500)
            Callback.triggerServer('murphy_clothing:GetCurrentClothes', function(datatable, id)
                if IsPedMale(PlayerPedId()) then SelectedGender = "male" else SelectedGender = "female" end
                if datatable then
                    local loadclothes = false
                    for k, v in pairs(datatable) do
                        if v.model > 0 then
                            loadclothes = true
                            break
                        end
                    end
                    if loadclothes then
                        TriggerEvent("murphy_clothes:clotheitem",datatable, id)
                    end
                end
            end)
        end)

        RegisterNetEvent('vorp_core:Client:OnPlayerRespawn')
        AddEventHandler('vorp_core:Client:OnPlayerRespawn', function ()
            Wait(500)
            Callback.triggerServer('murphy_clothing:GetCurrentClothes', function(datatable, id)
                if IsPedMale(PlayerPedId()) then SelectedGender = "male" else SelectedGender = "female" end
                if datatable then
                    local loadclothes = false
                    for k, v in pairs(datatable) do
                        if v.model > 0 then
                            loadclothes = true
                            break
                        end
                    end
                    if loadclothes then
                        TriggerEvent("murphy_clothes:clotheitem",datatable, id)
                    end
                end
            end)
        end)


        RegisterNetEvent("murphy_clothes:outfitchanged", function ()
            --- your corde
        end)
end