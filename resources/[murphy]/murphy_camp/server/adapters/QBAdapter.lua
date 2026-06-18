if Config.framework == 'qbr-core' then

    function GetCharIdentifier(targetID)
        targetID = tonumber(targetID)
        return exports['qbr-core']:GetPlayer(targetID).PlayerData.citizenid
    end

    function GetCharGroup(targetID)
        targetID = tonumber(targetID)
        local permissions = QBCore.Functions.GetPermissions(targetID)
        for k, v in pairs(permissions) do
            return k
        end
    end
    

    function RegisterUsableItems()
        QBCore.Functions.CreateUseableItem(Config.TelegramItem, function(source, item)
            local _source = source
            local Player = QBCore.Functions.GetPlayer(_source)
            if not Player.Functions.GetItemByName(item.name) then return end
            -- Trigger code here for what item should do
            local contenu = item.info.data
            TriggerClientEvent("messageData", _source, contenu)
        end)
    end



    RegisterServerEvent("murphy_safe:OpenStash", function(stashid, weight)
        local src = source
        TriggerClientEvent("murphy_safe:openstash", src, "stash", stashid, false, {
            maxweight = weight,
            slots = 25,
        })
    end)

    Citizen.CreateThread(function ()
        Wait(1000)
        for k, v in pairs(Config.safe) do
            QBCore.Functions.CreateUseableItem(v.item, function(source, item)
                local Player = QBCore.Functions.GetPlayer(source)
                if not Player.Functions.GetItemByName(item.name) then return end
                TriggerClientEvent("murphy_safe:createsafe", source, k)    
            end)
        end
    end)
    
    function DeleteStashes(stashid)
        MySQL.update('DELETE FROM stashitems WHERE `stash`=@stash', {stash = stashid })
    end

    function CreateStashes(generetedUid)
        MySQL.update(
            'INSERT INTO stashitems (`stash`) VALUES (@stash);',
            {
                stash = "safe_"..generetedUid
            }, function(rowsChanged)
        end)
    end


end

