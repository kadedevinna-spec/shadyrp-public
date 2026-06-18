if Config.framework == "REDEMRP2k23" then
    Inventory = {}

    TriggerEvent("redemrp_inventory:getData", function (data)
        Inventory = data
    end)

    local RedEM = exports["redem_roleplay"]:RedEM()
       
    function GetCharIdentifier(targetID)
        local user = RedEM.GetPlayer(targetID)
        local charid = nil
        if user then
            charid = tostring(user.citizenid)
        end
        return charid
    end
    
    function GetCharFirstname(targetID)
        return RedEM.GetPlayer(targetID).firstname
    end
    
    function GetCharLastname(targetID)
        return RedEM.GetPlayer(targetID).lastname
    end
    
    function GetCharGroup(targetID)
        return RedEM.GetPlayer(targetID).group
    end

    function GetCharJob(targetID)
        local user = RedEM.GetPlayer(targetID)
        if user then 
            job = RedEM.GetPlayer(targetID).job
        else job = nil end
        return job
    end

    function GetCharJobGrade(targetID) 
        local user = RedEM.GetPlayer(targetID)
        if user then 
            jobgrade = RedEM.GetPlayer(targetID).jobgrade
        else jobgrade = nil end
        return jobgrade
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

    RegisterServerEvent("murphy_camp:OpenStash", function(stashid, weight)
        local src = source
        TriggerClientEvent("redemrp_inventory:OpenStash", src, stashid, weight)
    end)


    Citizen.CreateThread(function ()
        Wait(1000)
        for k, v in pairs(Config.Campfire) do
            RegisterServerEvent("RegisterUsableItem:"..v.item)
            AddEventHandler("RegisterUsableItem:"..v.item, function(source)  
                TriggerClientEvent("redemrp_inventory:closeinv", source)
                TriggerClientEvent("murphy_camp:placecampfire", source, k)

            end)
        end

        for k, v in pairs(Config.Furnitures) do
            RegisterServerEvent("RegisterUsableItem:"..v.item)
            AddEventHandler("RegisterUsableItem:"..v.item, function(source)  
                TriggerClientEvent("redemrp_inventory:closeinv", source)
                TriggerClientEvent("murphy_camp:placefurnitures", source, k)

            end)
        end
    end)

    function DeleteStashes(stashid)
        MySQL.update('DELETE FROM stashes WHERE `stashid`=@stashid', {stashid = stashid })
    end

    function CreateStashes(generetedUid)
        MySQL.update(
            'INSERT INTO stashes (`stashid`) VALUES (@stashid);',
            {
                stashid = "safe_"..generetedUid
            }, function(rowsChanged)
        end)
    end
    
    function GetStashWeight(src, stashid) --- make sure that the fucntion is exported in redemrp inventory
        local stashW = exports.redemrp_inventory.GetStashWeight(src, tostring(stashid))
        return stashW
    end

    --- Returns an array of { name, amount, metadata } for the items stored in `stashid`.
    --- Reads directly from the `stashes` table used by redemrp_inventory.
    function GetStashItems(stashid)
        local result = MySQL.query.await('SELECT items FROM stashes WHERE stashid = ?', { stashid })
        if not result or #result == 0 or not result[1].items then return {} end
        local ok, decoded = pcall(json.decode, result[1].items)
        if not ok or type(decoded) ~= "table" then return {} end
        local out = {}
        for _, it in pairs(decoded) do
            local name   = it.name or it.item
            local amount = tonumber(it.amount or it.count or 0) or 0
            if name and amount > 0 then
                out[#out + 1] = { name = name, amount = amount, metadata = it.meta or it.metadata }
            end
        end
        return out
    end

    --- Wipes every item stored in `stashid`.
    --- redemrp_inventory keeps stashes in memory and writes them back to DB every
    --- 5 minutes, so deleting the row alone would be undone on the next save.
    --- We also trigger the wipe event to clear the in-memory copy.
    function ClearStash(stashid)
        TriggerEvent("redemrp_inventory:server:wipestash", stashid)
        MySQL.update('DELETE FROM stashes WHERE stashid = ?', { stashid })
    end
end