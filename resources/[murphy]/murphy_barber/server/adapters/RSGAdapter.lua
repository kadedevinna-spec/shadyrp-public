if Config.framework == 'rsg-core' then
    local CORE = exports['rsg-core']:GetCoreObject()

    function GetCharJob(targetID)
        targetID = tonumber(targetID)
        local user = CORE.Functions.GetPlayer(targetID)
        if user then
            job = CORE.Functions.GetPlayer(targetID).PlayerData.job.name
        else
            job = nil
        end
        return job
    end

    function GetCharJobGrade(targetID)
        targetID = tonumber(targetID)
        local user = CORE.Functions.GetPlayer(targetID)
        if user then
            job = CORE.Functions.GetPlayer(targetID).PlayerData.job.grade.level
        else
            job = nil
        end
        return job
    end

    function GetCharIdentifier(targetID)
        targetID = tonumber(targetID)
        local player = CORE.Functions.GetPlayer(targetID)
        if not player then return nil end
        return player.PlayerData.citizenid
    end

    function GetCharFirstname(targetID)
        targetID = tonumber(targetID)
        return CORE.Functions.GetPlayer(targetID).PlayerData.charinfo.firstname
    end

    function GetCharLastname(targetID)
        targetID = tonumber(targetID)
        return CORE.Functions.GetPlayer(targetID).PlayerData.charinfo.lastname
    end

    function GetCharMoney(targetID)
        targetID = tonumber(targetID)
        return CORE.Functions.GetPlayer(targetID).PlayerData.money["cash"]
    end

    function RemoveCurrency(targetID, amount)
        targetID = tonumber(targetID)
        local Player = CORE.Functions.GetPlayer(targetID)
        Player.Functions.RemoveMoney("cash", amount)
    end

    function GetCharGroup(targetID)
        targetID = tonumber(targetID)
        local permissions = CORE.Functions.GetPermission(targetID)
        for k, v in pairs(permissions) do
            return k
        end
    end

    function GiveItem(src, item, amount, meta)
        local Player = CORE.Functions.GetPlayer(src)
        local _meta = meta or {}
        local result = Player.Functions.AddItem(item, amount, nil, _meta)
        return result
    end

    function RemoveItem(src, item, amount, meta)
        local Player = CORE.Functions.GetPlayer(src)
        local _meta = meta
        local result = Player.Functions.RemoveItem(item, amount)
        return result
    end

    function GetItemAmount(src, item)
        local Player = CORE.Functions.GetPlayer(src)
        local _meta = meta
        local result = Player.Functions.GetItemByName(item, amount)
        if result then
            amount = result.amount
        else
            amount = 0
        end

        return amount
    end

    CORE.Functions.CreateUseableItem(Config.OverlayItem, function(source, item)
        local _source = source
        local Player = CORE.Functions.GetPlayer(_source)
        if not Player.Functions.GetItemByName(item.name) then return end
        local outfit_id = item.info.presetid
        TriggerClientEvent("murphy_barber:makeupitem", _source, outfit_id)
    end)

    Callback.register('murphy_barber:GetCharSkinTone', function(source, male, characterid)
        if Config.murphy_creator == false then
            local _source = source
            local albedo = nil
            local player = CORE.Functions.GetPlayer(_source)
            local charid = characterid or (player and player.PlayerData.citizenid)
            MySQL.query("SELECT * FROM playerskins WHERE `citizenid`=@citizenid;", { citizenid = charid },
                function(skins)
                    if skins[1] then
                        local skin = skins[1].skin
                        local decoded = json.decode(skin)
                        local skin_tone = decoded.skin_tone
                        if male then
                            if tonumber(skin_tone) == 1 then
                                albedo = GetHashKey("mp_head_mr1_sc08_c0_000_ab")
                            elseif tonumber(skin_tone) == 2 then
                                albedo = GetHashKey("mp_head_mr1_sc03_c0_000_ab")
                            elseif tonumber(skin_tone) == 3 then
                                albedo = GetHashKey("mp_head_mr1_sc02_c0_000_ab")
                            elseif tonumber(skin_tone) == 4 then
                                albedo = GetHashKey("mp_head_mr1_sc04_c0_000_ab")
                            elseif tonumber(skin_tone) == 5 then
                                albedo = GetHashKey("MP_head_mr1_sc01_c0_000_ab")
                            elseif tonumber(skin_tone) == 6 then
                                albedo = GetHashKey("MP_head_mr1_sc05_c0_000_ab")
                            else
                                albedo = GetHashKey("mp_head_mr1_sc08_c0_000_ab")
                            end
                        else
                            if tonumber(skin_tone) == 1 then
                                albedo = GetHashKey("mp_head_fr1_sc08_c0_000_ab")
                            elseif tonumber(skin_tone) == 2 then
                                albedo = GetHashKey("mp_head_fr1_sc03_c0_000_ab")
                            elseif tonumber(skin_tone) == 3 then
                                albedo = GetHashKey("mp_head_fr1_sc02_c0_000_ab")
                            elseif tonumber(skin_tone) == 4 then
                                albedo = GetHashKey("mp_head_fr1_sc04_c0_000_ab")
                            elseif tonumber(skin_tone) == 5 then
                                albedo = GetHashKey("MP_head_fr1_sc01_c0_000_ab")
                            elseif tonumber(skin_tone) == 6 then
                                albedo = GetHashKey("mp_head_fr1_sc05_c0_000_ab")
                            else
                                albedo = GetHashKey("mp_head_fr1_sc08_c0_000_ab")
                            end
                        end
                    end
                end)
            repeat
                Wait(0)
            until albedo ~= nil
            return albedo
        else
            local _source = source
            local albedo = nil
            local charid = characterid or GetCharIdentifier(_source)
            MySQL.query("SELECT * FROM murphy_creator WHERE `charid`=@charid;", { charid = charid }, function(skins)
                if skins[1] then
                    local pedata = skins[1].peddata
                    local decoded = json.decode(pedata)
                    local albedoindex = decoded.skintone
                    local gender = "Female"
                    if male then gender = "Male" end
                    albedo = GetHashKey(DefaultChar[gender][albedoindex].HeadTexture[1])
                else
                    MySQL.query("SELECT * FROM playerskins WHERE `citizenid`=@citizenid;", { citizenid = charid },
                        function(skins)
                            if skins[1] then
                                local skin = skins[1].skin
                                local decoded = json.decode(skin)
                                local skin_tone = decoded.skin_tone
                                if male then
                                    if tonumber(skin_tone) == 1 then
                                        albedo = GetHashKey("mp_head_mr1_sc08_c0_000_ab")
                                    elseif tonumber(skin_tone) == 2 then
                                        albedo = GetHashKey("mp_head_mr1_sc03_c0_000_ab")
                                    elseif tonumber(skin_tone) == 3 then
                                        albedo = GetHashKey("mp_head_mr1_sc02_c0_000_ab")
                                    elseif tonumber(skin_tone) == 4 then
                                        albedo = GetHashKey("mp_head_mr1_sc04_c0_000_ab")
                                    elseif tonumber(skin_tone) == 5 then
                                        albedo = GetHashKey("MP_head_mr1_sc01_c0_000_ab")
                                    elseif tonumber(skin_tone) == 6 then
                                        albedo = GetHashKey("MP_head_mr1_sc05_c0_000_ab")
                                    else
                                        albedo = GetHashKey("mp_head_mr1_sc08_c0_000_ab")
                                    end
                                else
                                    if tonumber(skin_tone) == 1 then
                                        albedo = GetHashKey("mp_head_fr1_sc08_c0_000_ab")
                                    elseif tonumber(skin_tone) == 2 then
                                        albedo = GetHashKey("mp_head_fr1_sc03_c0_000_ab")
                                    elseif tonumber(skin_tone) == 3 then
                                        albedo = GetHashKey("mp_head_fr1_sc02_c0_000_ab")
                                    elseif tonumber(skin_tone) == 4 then
                                        albedo = GetHashKey("mp_head_fr1_sc04_c0_000_ab")
                                    elseif tonumber(skin_tone) == 5 then
                                        albedo = GetHashKey("MP_head_fr1_sc01_c0_000_ab")
                                    elseif tonumber(skin_tone) == 6 then
                                        albedo = GetHashKey("mp_head_fr1_sc05_c0_000_ab")
                                    else
                                        albedo = GetHashKey("mp_head_fr1_sc08_c0_000_ab")
                                    end
                                end
                            end
                        end)
                end
            end)
            repeat
                Wait(0)
            until albedo ~= nil
            return albedo
        end
    end)
end
