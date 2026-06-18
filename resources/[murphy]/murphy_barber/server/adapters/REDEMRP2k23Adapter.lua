if Config.framework == "REDEMRP2k23" then
    Inventory = {}

    TriggerEvent("redemrp_inventory:getData", function(data)
        Inventory = data
    end)

    local RedEM = exports["redem_roleplay"]:RedEM()


    function GetCharJob(targetID)
        local user = RedEM.GetPlayer(targetID)
        if user then
            job = RedEM.GetPlayer(targetID).job
        else
            job = nil
        end
        return job
    end

    function GetCharJobGrade(targetID)
        local user = RedEM.GetPlayer(targetID)
        if user then
            jobgrade = RedEM.GetPlayer(targetID).jobgrade
        else
            jobgrade = nil
        end
        return jobgrade
    end

    function GetCharIdentifier(targetID)
        return RedEM.GetPlayer(targetID).citizenid
    end

    function GetCharFirstname(targetID)
        return RedEM.GetPlayer(targetID).firstname
    end

    function GetCharLastname(targetID)
        return RedEM.GetPlayer(targetID).lastname
    end

    function GetCharMoney(targetID)
        return RedEM.GetPlayer(targetID).money
    end

    function RemoveCurrency(targetID, amount)
        RedEM.GetPlayer(targetID).RemoveMoney(tonumber(amount))
    end

    function AddCurrency(targetID, amount)
        RedEM.GetPlayer(targetID).AddMoney(tonumber(amount))
    end

    function GetCharGroup(targetID)
        return RedEM.GetPlayer(targetID).group
    end

    function GiveItem(src, item, amount, meta)
        local _meta = meta
        local ItemData = Inventory.getItem(src, item, _meta)
        local result = ItemData.AddItem(amount)
        return result
    end

    function RemoveItem(src, item, amount, meta)
        local _meta = meta
        local ItemData = Inventory.getItem(src, item, _meta)
        local result = ItemData.RemoveItem(amount)
        return result
    end

    function GetItemAmount(src, item)
        local ItemData = Inventory.getItem(src, item)
        return ItemData.ItemAmount
    end

    RegisterServerEvent("RegisterUsableItem:" .. Config.OverlayItem)
    AddEventHandler("RegisterUsableItem:" .. Config.OverlayItem, function(source, _data)
        local _source = source
        local outfit_id = tonumber(_data.meta.presetid)
        TriggerClientEvent("murphy_barber:makeupitem", _source, outfit_id)
    end)


    Callback.register('murphy_barber:GetCharSkinTone', function(source, male, characterid)
        if Config.murphy_creator == false then
            local _source = source
            local albedo = nil
            local identifier, charid
            if characterid then
                print ("Character ID: " .. characterid)
                print ("Update needed to support this feature")
            else
                local user = RedEM.GetPlayer(_source)
                identifier = user.identifier
                charid = user.charid
            end
            MySQL.query("SELECT * FROM skins WHERE `identifier`=@identifier AND `charid`=@charid;",
                { identifier = identifier, charid }, function(skins)
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
                end
            end)
            repeat
                Wait(0)
            until albedo ~= nil
            -- print ("ALBEDO: " .. albedo)
            return albedo
        end
    end)
end
