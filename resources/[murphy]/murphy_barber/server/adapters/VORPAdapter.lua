if Config.framework == 'vorp' then
    VorpInv = exports.vorp_inventory:vorp_inventoryApi()

    local VorpCore = {}

    TriggerEvent("getCore", function(core)
        VorpCore = core
    end)


    function GetCharJob(targetID)
        local user = VorpCore.getUser(targetID)
        if user then
            job = VorpCore.getUser(targetID).getUsedCharacter.job
        else
            job = nil
        end
        return job
    end

    function GetCharJobGrade(targetID)
        local user = VorpCore.getUser(targetID)
        if user then
            job = VorpCore.getUser(targetID).getUsedCharacter.jobGrade
        else
            job = nil
        end
        return job
    end

    function GetCharIdentifier(targetID)
        local user = VorpCore.getUser(targetID)
        if user then
            charid = VorpCore.getUser(targetID).getUsedCharacter.charIdentifier
        else
            charid = nil
        end
        return charid
    end

    function GetCharFirstname(targetID)
        return VorpCore.getUser(targetID).getUsedCharacter.firstname
    end

    function GetCharLastname(targetID)
        return VorpCore.getUser(targetID).getUsedCharacter.lastname
    end

    function GetCharMoney(targetID)
        return VorpCore.getUser(targetID).getUsedCharacter.money
    end

    function RemoveCurrency(targetID, amount)
        VorpCore.getUser(targetID).getUsedCharacter.removeCurrency(0, amount)
    end

    function GetCharGroup(targetID)
        return VorpCore.getUser(targetID).getUsedCharacter.group
    end

    function GiveItem(src, item, amount, meta)
        local _meta = meta
        local result = VorpInv.addItem(src, item, amount, _meta)
        return result
    end

    function RemoveItem(src, item, amount, meta)
        local _meta = meta
        local result = VorpInv.subItem(src, item, amount, _meta)
        return result
    end

    function GetItemAmount(src, item)
        local ItemData = VorpInv.getItemCount(src, item)
        return ItemData
    end

    VorpInv.RegisterUsableItem(Config.OverlayItem, function(_data)
        local data = _data
        local _source = data.source
        local outfit_id = data.item.metadata.presetid
        TriggerClientEvent("murphy_barber:makeupitem", _source, outfit_id)
    end)

    Callback.register('murphy_barber:GetCharSkinTone', function(source, male, characterid)
        if Config.murphy_creator == false then
            local _source = source
            local albedo = nil
            local charid = characterid and tonumber(characterid) or tonumber(GetCharIdentifier(_source))
            MySQL.query("SELECT * FROM characters WHERE `charidentifier`=@charidentifier;", { charidentifier = charid },
                function(skins)
                    if skins[1] and skins[1].skinPlayer then
                        local ok, decoded = pcall(json.decode, skins[1].skinPlayer)
                        if ok and type(decoded) == 'table' then
                            albedo = decoded.albedo or 0
                        else
                            albedo = 0
                        end
                    else
                        -- No row or no skinPlayer column: fall through to the gender default.
                        albedo = 0
                    end
                end)
            -- Timeout guards against the callback never resolving (was an infinite loop
            -- when `decoded.albedo` was nil — players ended up with no hair on login).
            local waitTimeout = 5000
            repeat
                Wait(0)
                waitTimeout = waitTimeout - 1
            until albedo ~= nil or waitTimeout <= 0
            if not albedo then albedo = 0 end
            if albedo == 0 then
                if male then
                    albedo = GetHashKey("mp_head_mr1_sc08_c0_000_ab")
                else
                    albedo = GetHashKey("mp_head_fr1_sc08_c0_000_ab")
                end
            end
            return albedo
        else
            local _source = source
            local albedo = nil
            local charid = characterid or GetCharIdentifier(_source)
            -- print(charid, GetCharIdentifier(_source))
            MySQL.query("SELECT * FROM murphy_creator WHERE `charid`=@charid;", { charid = charid }, function(skins)
                if skins[1] then
                    local pedata = skins[1].peddata
                    local decoded = json.decode(pedata)
                    local albedoindex = decoded and decoded.skintone
                    local gender = "Female"
                    if male then gender = "Male" end
                    if albedoindex and DefaultChar[gender] and DefaultChar[gender][albedoindex] then
                        albedo = GetHashKey(DefaultChar[gender][albedoindex].HeadTexture[1])
                    else
                        albedo = 0
                    end
                else
                    MySQL.query("SELECT * FROM characters WHERE `charidentifier`=@charidentifier;",
                        { charidentifier = charid },
                        function(skins)
                            if skins[1] and skins[1].skinPlayer then
                                local skin = skins[1].skinPlayer
                                local decoded = json.decode(skin)
                                albedo = (decoded and decoded.albedo) or 0
                            else
                                -- No skin data anywhere: fall back to gender default.
                                albedo = 0
                            end
                        end)
                end
            end)
            local waitTimeout = 5000
            repeat
                Wait(0)
                waitTimeout = waitTimeout - 1
            until albedo ~= nil or waitTimeout <= 0
            if not albedo then albedo = 0 end
            if albedo == 0 then
                if male then
                    albedo = GetHashKey("mp_head_mr1_sc08_c0_000_ab")
                else
                    albedo = GetHashKey("mp_head_fr1_sc08_c0_000_ab")
                end
            end
            return albedo
        end
    end)

    if not Config.murphy_creator then
        RegisterNetEvent("vorpcharacter:reloadedskinlistener", function()
            local src = source
            Wait(1000)
            TriggerClientEvent("murphy_barber:loadbarberoverlay", src)
        end)
    end
end
