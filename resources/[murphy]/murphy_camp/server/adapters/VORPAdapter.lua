if Config.framework == 'vorp' then
    VorpInv = exports.vorp_inventory:vorp_inventoryApi()
    
    local VorpCore = {}
    
    TriggerEvent("getCore",function(core)
        VorpCore = core
    end)
    
    
    function GetCharJob(targetID) 
        local user = VorpCore.getUser(targetID)
        if user then 
            job = VorpCore.getUser(targetID).getUsedCharacter.job
        else job = nil end
        return job
    end

    function GetCharJobGrade(targetID) 
        local user = VorpCore.getUser(targetID)
        if user then 
            job = VorpCore.getUser(targetID).getUsedCharacter.jobGrade
        else job = nil end
        return job
    end
    
    function GetCharIdentifier(targetID)
        local user = VorpCore.getUser(targetID)
        if not user then return nil end
        return tostring(user.getUsedCharacter.charIdentifier)
    end
    
    function GetCharFirstname(targetID)
        local user = VorpCore.getUser(targetID)
        if not user then return nil end
        return user.getUsedCharacter.firstname
    end
    
    function GetCharLastname(targetID)
        local user = VorpCore.getUser(targetID)
        if not user then return nil end
        return user.getUsedCharacter.lastname
    end
    
    function GetCharMoney(targetID)
        local user = VorpCore.getUser(targetID)
        if not user then return nil end
        return user.getUsedCharacter.money
    end
    
    function RemoveCurrency(targetID, amount)
        VorpCore.getUser(targetID).getUsedCharacter.removeCurrency(0, amount)
    end
    
    function GetCharGroup(targetID)
        local user = VorpCore.getUser(targetID)
        if not user then return nil end
        return user.getUsedCharacter.group
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

    RegisterServerEvent("murphy_camp:OpenStash", function(stashid, weight)
        local src = source
        OpenStash(src, stashid, weight)
    end)


    function OpenStash(src, stash, weight)
        if exports.vorp_inventory:isCustomInventoryRegistered(stash) then
            VorpInv.OpenInv(src, stash)
        else
            --- register custom inventory
            exports.vorp_inventory:registerInventory({ 
            id = stash,
            name = stash,
            limit = weight,
            acceptWeapons = true,
            shared = true,
            limitedItems = {},
            ignoreItemStackLimit = true,
            whitelistItems = false,
            PermissionTakeFrom = {},
            PermissionMoveTo = {},
            UsePermissions = false,
            UseBlackList = false,
            BlackListItems = {},
            whitelistWeapons = false,
            limitedWeapons = {} 
        })
        VorpInv.OpenInv(src, stash)
        end
    end

    Citizen.CreateThread(function ()
        Wait(1000)
        for k, v in pairs(Config.Campfire) do
            VorpInv.RegisterUsableItem(v.item, function (_data)
                local data = _data
                local _source = data.source
                VorpInv.CloseInv(_source)
                TriggerClientEvent("murphy_camp:placecampfire", _source, k)
            end)
        end

        for k, v in pairs(Config.Furnitures) do
            VorpInv.RegisterUsableItem(v.item, function (_data)
                local data = _data
                local _source = data.source
                VorpInv.CloseInv(_source)
                TriggerClientEvent("murphy_camp:placefurnitures", _source, k)
            end)
        end
    end)

    --- Returns an array of { name, amount, metadata } for the items stored in `stashid`.
    --- Returns an empty table if the stash is not registered or empty.
    function GetStashItems(stashid)
        if not exports.vorp_inventory:isCustomInventoryRegistered(stashid) then
            return {}
        end
        local raw = exports.vorp_inventory:getCustomInventoryItems(stashid) or {}
        local out = {}
        for _, it in pairs(raw) do
            local name   = it.name or it.itemName or it.item
            local amount = tonumber(it.count or it.amount or it.quantity or 0) or 0
            if name and amount > 0 then
                out[#out + 1] = { name = name, amount = amount, metadata = it.metadata or it.meta }
            end
        end
        return out
    end

    --- Wipes every item from `stashid` and unregisters the custom inventory.
    function ClearStash(stashid)
        if exports.vorp_inventory:isCustomInventoryRegistered(stashid) then
            exports.vorp_inventory:removeInventory(stashid)
        end
    end

end
