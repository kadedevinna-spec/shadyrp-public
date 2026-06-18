if Config.framework == 'redemrp2022' then
    Inventory = {}

    function RetrievePlayer (targetID)
        local Player = {}
        TriggerEvent("redemrp:getPlayerFromId", targetID, function(player)
            print("Job: ", player.getJob())
            Player = player
        end)
        return Player
    end
    

    
    function GetCharJob(targetID)
        return RetrievePlayer(targetID).getJob()
    end
    
    function GetCharIdentifier(targetID)
        return RetrievePlayer(targetID).getIdentifier()
    end
    
    function GetCharFirstname(targetID)
        return RetrievePlayer(targetID).getFirstname()
    end
    
    function GetCharLastname(targetID)
        return RetrievePlayer(targetID).getLastname()
    end
    
    function GetCharMoney(targetID)
        return RetrievePlayer(targetID).get("money")
    end
    
    function RemoveCurrency(targetID, amount)
        local Player = RetrievePlayer(targetID)
        Player.removeMoney(amount)
    end
    
    function GetCharGroup(targetID)
        return RetrievePlayer(targetID).getGroup()
    end


    function GiveTelegram(src, telegram)
        local _meta = {}
        _meta.data = telegram
        local ItemData = Inventory.getItem(src, Config.TelegramItem, _meta)
        if ItemData.ItemAmount == 0 then
            ItemData.AddItem(1)
        end
    end

    function RegisterUsableItems()
        RegisterServerEvent("RegisterUsableItem:"..Config.TelegramItem)
        AddEventHandler("RegisterUsableItem:"..Config.TelegramItem, function(source, _data)
            local _source = source
            local data = _data
            local contenu = data.meta.data
            TriggerEvent("redemrp_inventory:closeinv")
            TriggerClientEvent("messageData", _source, contenu)
        end)
    end

    function DoesRecipientExist(recipientfirstname, recipientlastname, callback)
        MySQL.query("SELECT * FROM characters WHERE lastname = @lastname AND firstname = @firstname",
            {firstname = recipientfirstname, lastname = recipientlastname},
            function(result)
                if result and #result > 0 then
                    callback(true) -- Call the callback with true if recipient exists
                else
                    callback(false) -- Call the callback with false if recipient doesn't exist
                end
            end
        )
    end
end
