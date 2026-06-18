if Config.framework == 'qbr-core' then


    function GetCharJob(targetID)
        targetID = tonumber(targetID)
        if not exports['qbr-core']:GetPlayer(targetID).PlayerData.job.onduty then
            return ''
        end
        return exports['qbr-core']:GetPlayer(targetID).PlayerData.job.name
    end

    function GetCharIdentifier(targetID)
        targetID = tonumber(targetID)
        return exports['qbr-core']:GetPlayer(targetID).PlayerData.citizenid
    end

    function GetCharFirstname(targetID)
        targetID = tonumber(targetID)
        return exports['qbr-core']:GetPlayer(targetID).PlayerData.charinfo.firstname
    end

    function GetCharLastname(targetID)
        targetID = tonumber(targetID)
        return exports['qbr-core']:GetPlayer(targetID).PlayerData.charinfo.lastname
    end

    function GetCharMoney(targetID)
        targetID = tonumber(targetID)
        return exports['qbr-core']:GetPlayer(targetID).PlayerData.money["cash"]
    end

    function RemoveCurrency(targetID, amount)
        targetID = tonumber(targetID)
        local Player = exports['qbr-core']:GetPlayer(src)
        Player.Functions.RemoveMoney("cash", amount)
    end

    function GetCharGroup(targetID)
        targetID = tonumber(targetID)
        local permissions = QBCore.Functions.GetPermissions(targetID)
        for k, v in pairs(permissions) do
            return k
        end
    end
    
    function GiveTelegram(src, telegram)
        local Player = CORE.Functions.GetPlayer(src)
        local _meta = {}
        _meta.data = telegram
        Player.Functions.RemoveItem(Config.TelegramItem, 1, false, _meta)
    end

    function RegisterUsableItems()
        CORE.Functions.CreateUseableItem(Config.TelegramItem, function(source, item)
            local _source = source
            local Player = CORE.Functions.GetPlayer(_source)
            if not Player.Functions.GetItemByName(item.name) then return end
            -- Trigger code here for what item should do
            local contenu = item.info.data
            TriggerClientEvent("messageData", _source, contenu)
        end)
    end

    function DoesRecipientExist(recipientfirstname, recipientlastname, callback)
        MySQL.query("SELECT * FROM players WHERE name = @name",
            {name = recipientfirstname.." "..recipientlastname},
            function(result)
                if result and #result > 0 then
                    callback(true) -- Call the callback with true if recipient exists
                else
                    callback(false) -- Call the callback with false if recipient doesn't exist
                end
            end
        )
    end

    function IsJobOnline(job)
        local result = false
        for _,targetId in ipairs(GetPlayers()) do
            local targetJob = GetCharJob(targetId)
            if targetJob == job then
                result = true
            end
        end
        return result
    end
end

