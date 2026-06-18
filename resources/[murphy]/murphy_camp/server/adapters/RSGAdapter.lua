if Config.framework == 'rsg-core' then
    local CORE = exports['rsg-core']:GetCoreObject()

    function GetCharIdentifier(targetID)
        local charid = nil
        targetID = tonumber(targetID)
        if CORE.Functions.GetPlayer(targetID) then
            charid = tostring(CORE.Functions.GetPlayer(targetID).PlayerData.citizenid)
        end
        return charid
    end

    function GetCharGroup(targetID)
        targetID = tonumber(targetID)
        local permissions = CORE.Functions.GetPermission(targetID)
        for k, v in pairs(permissions) do
            return k
        end
    end

    function GetCharFirstname(targetID)
        targetID = tonumber(targetID)
        return CORE.Functions.GetPlayer(targetID).PlayerData.charinfo.firstname
    end

    function GetCharLastname(targetID)
        targetID = tonumber(targetID)
        return CORE.Functions.GetPlayer(targetID).PlayerData.charinfo.lastname
    end

    function GiveItem(src, item, amount, meta)
        local Player = CORE.Functions.GetPlayer(src)
        local _meta = meta
        local result = Player.Functions.AddItem(item, amount)
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

    RegisterServerEvent("murphy_safe:OpenStash", function(stashid, weight)
        local src = source
        TriggerClientEvent("murphy_safe:openstash", src, "stash", stashid, false, {
            maxweight = weight,
            slots = 25,
        })
    end)

    Citizen.CreateThread(function()
        Wait(1000)
        for k, v in pairs(Config.Campfire) do
            CORE.Functions.CreateUseableItem(v.item, function(source, item)
                local Player = CORE.Functions.GetPlayer(source)
                if not Player.Functions.GetItemByName(item.name) then return end
                TriggerClientEvent("murphy_camp:placecampfire", source, k)
            end)
        end
        for k, v in pairs(Config.Furnitures) do
            CORE.Functions.CreateUseableItem(v.item, function(source, item)
                local Player = CORE.Functions.GetPlayer(source)
                if not Player.Functions.GetItemByName(item.name) then return end
                TriggerClientEvent("murphy_camp:placefurnitures", source, k)
            end)
        end
    end)

    function DeleteStashes(stashid)
        MySQL.update('DELETE FROM stashitems WHERE `stash`=@stash', { stash = stashid })
    end

    function CreateStashes(generetedUid)
        MySQL.update(
            'INSERT INTO stashitems (`stash`) VALUES (@stash);',
            {
                stash = "safe_" .. generetedUid
            }, function(rowsChanged)
            end)
    end

    function GetStashWeight(src, stashid)
        local _src = src
        RSGCore.Functions.TriggerCallback('rsg-inventory:server:GetStashItems', _src, cb, stashid)
        if cb then
            if #cb == 0 then
                stashW = 0
            else
                stashW = 1
            end
        end
        return stashW
    end

    --- Returns an array of { name, amount, metadata } for the items stored in `stashid`.
    --- Reads directly from the `stashitems` table used by rsg-inventory.
    function GetStashItems(stashid)
        local result = MySQL.query.await('SELECT items FROM stashitems WHERE stash = ?', { stashid })
        if not result or #result == 0 or not result[1].items then return {} end
        local ok, decoded = pcall(json.decode, result[1].items)
        if not ok or type(decoded) ~= "table" then return {} end
        local out = {}
        for _, it in pairs(decoded) do
            local name   = it.name or it.item
            local amount = tonumber(it.amount or it.count or 0) or 0
            if name and amount > 0 then
                out[#out + 1] = { name = name, amount = amount, metadata = it.info or it.metadata }
            end
        end
        return out
    end

    --- Wipes every item stored in `stashid`.
    function ClearStash(stashid)
        MySQL.update('DELETE FROM stashitems WHERE stash = ?', { stashid })
    end
end
