Framework = "none"
onPlayerLoadEvent = "none" 
LoadTimeout = 5
oxInv = GetResourceState('ox_inventory') == 'started'
if GetResourceState('rsg-core') == 'started' and GetResourceState('rsg-inventory') == 'started' then
    Framework = "RSG"
    LoadTimeout = 5
    onPlayerLoadEvent = "RSGCore:Client:OnPlayerLoaded"
    print("^2[INFO]^0 Framework selected: ^3" .. Framework .. "^0")
elseif GetResourceState('rsg-core') == 'started' and oxInv then
    Framework = "RSG-OXINVENTORY"
    LoadTimeout = 5
    onPlayerLoadEvent = "RSGCore:Client:OnPlayerLoaded"
    print("^2[INFO]^0 Framework selected: ^3" .. Framework .. "^0")
elseif GetResourceState('vorp_core') == 'started' then
    Framework = "VORP"
    onPlayerLoadEvent = "vorp:SelectedCharacter" 
    LoadTimeout = 5
    print("^2[INFO]^0 Framework selected: ^3" .. Framework .. "^0")
else
    Citizen.CreateThread(function()
        while true do
            Citizen.Wait(2000)
            print("^1[ERROR]^0 No suitable framework found. ^2Please install ^3vorp_core^2 or ^3rsg-core^2.")
            print("^1[ERROR]^0 Make sure to start ^3fx-idcard^0 after the frameworks in your ^2server.cfg^0 file.")
        end
    end)
end 

if Framework == "VORP" then
    if IsDuplicityVersion() then
        VorpCore = {}
        VorpInv = {}
    
        TriggerEvent("getCore", function(core)
            VorpCore = core
        end)
        ServerRPC = exports.vorp_core:ServerRpcCall()
        VorpInv = exports.vorp_inventory:vorp_inventoryApi()
    
        function FXRegisterUsableItem(itemName, callback)
            VorpInv.RegisterUsableItem(itemName, function(data)
                callback({source = data.source, item = data.item})
            end)
        end
    
        function FXRegisterCallback(eventName, callback)
            ServerRPC.Callback.Register(eventName, function(source, cb, ...)
                callback(source, function(result)
                    cb(result)
                end, ...)
            end)
        end
    
        function FXCloseInventory(src)
            VorpInv.CloseInv(src)
        end
        
        function FXRemoveItem(src, itemName, itemCount, metadata)
            if string.sub(itemName, 1, string.len("WEAPON_")) == "WEAPON_" or tonumber(itemName) then
                return VorpInv.subWeapon(src, itemName)
            else
                return VorpInv.subItem(src, itemName, itemCount, metadata)
            end
        end
    
        function FXAddItem(src, itemName, itemCount, metadata)
            if string.sub(itemName, 1, string.len("WEAPON_")) == "WEAPON_" or tonumber(itemName) then
                return VorpInv.giveWeapon(src, itemName, 0)
            else
                return VorpInv.addItem(src, itemName, itemCount, metadata)
            end
        end
        function FXCanCarry(src,item,count)
            if string.sub(item, 1, string.len("WEAPON_")) == "WEAPON_" or string.sub(item, 1, string.len("WEAPON_")) == "weapon_" then
                return exports.vorp_inventory:canCarryWeapons(src, count, nil, item)
            else
                return VorpInv.canCarryItem(src, item, count)
            end
        end
        function FXHaveMoney(src, moneyType, amount)
            local User = VorpCore.getUser(src)
            local Character = User.getUsedCharacter
            if moneyType == "cash" and Character.money >= amount then
                return true
            elseif moneyType == "gold" and Character.gold >= amount then
                return true
            end
            return false
        end
    
        function FXRemoveMoney(src, moneyType, amount)
            local User = VorpCore.getUser(src)
            local Character = User.getUsedCharacter
            local vorpMoneyType = moneyType == "gold" and 1 or 0
            Character.removeCurrency(vorpMoneyType, amount)
        end
    
        function FXAddMoney(src, moneyType, amount)
            local User = VorpCore.getUser(src)
            local Character = User.getUsedCharacter
            local vorpMoneyType = moneyType == "gold" and 1 or 0
            Character.addCurrency(vorpMoneyType, amount)
        end
    
        function FXGetPlayerData(src)
            local User = VorpCore.getUser(src)
            local Character = User.getUsedCharacter
            return {
                firstname = Character.firstname,
                lastname = Character.lastname,
                job = Character.job,
                grade = Character.jobGrade,
                charIdentifier = Character.charIdentifier,
                cash = Character.money,
                gold = Character.gold
            }
        end
    
        function FXGetUserInventory(src, cb)
            local inventory = {}
            exports.vorp_inventory:getUserInventoryItems(src, function(items)
                for _, item in pairs(items) do
                    inventory[#inventory + 1] = item
                end
                exports.vorp_inventory:getUserInventoryWeapons(src, function(weapons)
                    for _, weapon in pairs(weapons) do
                        inventory[#inventory + 1] = weapon
                    end
                    cb(inventory)
                end)
            end)
        end
    else
        VorpCore = {}
        TriggerEvent("getCore", function(core)
            VorpCore = core
        end)
        local ClientRPC = exports.vorp_core:ClientRpcCall()
        function FXTriggerServerCallback(eventName, callback, ...)
            ClientRPC.Callback.TriggerAsync(eventName, function(...)
                callback(...)
            end, ...)
        end
    end
elseif Framework == "RSG" then
    if IsDuplicityVersion() then
        --[[
            Server Side
        ]]
        RSGCore = exports['rsg-core']:GetCoreObject()
    
        oxInv = GetResourceState('ox_inventory') == 'started' 
    
        
        function FXRegisterCallback(eventName, callBack,...)
            RSGCore.Functions.CreateCallback(eventName, function(source, cb, ...)
                callBack(source,cb,...)
            end)
        end
        
        function FXCloseInventory(src)
            if oxInv then
                TriggerClientEvent("fx-trade:client:CloseInventory", src)
            else
                TriggerClientEvent("rsg-inventory:client:closeinv", src)
            end 
        end
    
        function FXRemoveItem(src, itemName, itemCount, slot)
            local result
            if oxInv then
                result = exports.ox_inventory:RemoveItem(src, itemName, itemCount, nil, slot, false)
            else
                local Player = RSGCore.Functions.GetPlayer(src)
                result = Player.Functions.RemoveItem(itemName, itemCount, slot)
            end
            return result
        end
        
        
        function FXAddItem(src,itemName,itemCount,Metadata)
            
            if oxInv then
                return exports.ox_inventory:AddItem(src, itemName, itemCount, Metadata, false)
            else
                local Player = RSGCore.Functions.GetPlayer(src)
                return Player.Functions.AddItem(itemName, itemCount,nil,Metadata)
            end
        end
        
       function FXGetItem(src,ItemName)
            local Player = RSGCore.Functions.GetPlayer(src)
            local founditem = false
            for slot,item in pairs(Player.PlayerData.items) do
                if item.name:lower() == ItemName:lower() then
                    founditem = item
                    break
                end
            end
            return founditem
        end
       
        function FXGetItemCount(src,ItemName)
            local Player = RSGCore.Functions.GetPlayer(src)
            local founditemcount = 0
            for slot,item in pairs(Player.PlayerData.items) do
                if item.name:lower() == ItemName:lower() then
                    founditemcount = item.amount
                    break
                end
            end
            return founditemcount
        end
        
        function FXHaveMoney(src,moneytype,count)
            local Player = RSGCore.Functions.GetPlayer(src)
            if Player.PlayerData.money["cash"] >= count and moneytype == "cash" then
                return true
            elseif Player.PlayerData.money["bank"] >= count and moneytype == "gold" then
                return true
            end 
            return false
        end
        function FXRemoveMoney(src,moneytype,count)
            local Player = RSGCore.Functions.GetPlayer(src)
            if moneytype == "cash" then
                Player.Functions.RemoveMoney('cash', count, 'fx-trade')
            else
                Player.Functions.RemoveMoney('bank', count, 'fx-trade')
            end
            return true
        end
        function FXAddMoney(src,moneytype,count)
            local Player = RSGCore.Functions.GetPlayer(src)
            if moneytype == "cash" then
                Player.Functions.AddMoney('cash', count, 'fx-trade')
            else
                Player.Functions.AddMoney('bank', count, 'fx-trade')
            end
            return true
        end
        function FXGetPlayerData(src)
            local Player = RSGCore.Functions.GetPlayer(src)
            local array = {
                firstname = Player.PlayerData.charinfo.firstname,
                lastname = Player.PlayerData.charinfo.firstname,
                job = Player.PlayerData.job.name,
                grade = Player.PlayerData.job.grade.level,
                charIdentifier = Player.PlayerData.citizenid,
                cash = Player.PlayerData.money["cash"],
                gold = Player.PlayerData.money["bank"],
            }
            return array
        end
       
        function FXGetUserInActive(charid)
            for _, source in pairs(GetPlayers()) do
                local User = RSGCore.Functions.GetPlayer(src)
                if charid == Player.PlayerData.citizenid then
                    return source
                end
            end
        end
    
        function FXCanCarry(src,item,count)
            if oxInv then
                return exports.ox_inventory:CanCarryItem(src, item, count)
            else
                return true
            end
        end
    
        function FXGetUserInventory(src,cb)
            if oxInv then
                local playerItems = exports.ox_inventory:GetInventoryItems(src)
                cb(playerItems)
            else
                local Player = RSGCore.Functions.GetPlayer(src)
                cb(Player.PlayerData.items)
            end
        end
    else
        RSGCore = exports['rsg-core']:GetCoreObject()
    
        RegisterNetEvent("fx-trade:client:CloseInventory", function()
            exports.ox_inventory:closeInventory()
        end)
        
        function FXTriggerServerCallback(eventName,callBack,...)
            RSGCore.Functions.TriggerCallback(eventName,function(...)
                callBack(...)
            end,...)
        end
    end
elseif Framework == "RSG-OXINVENTORY" then
    if IsDuplicityVersion() then
        --[[
            Server Side
        ]]
        RSGCore = exports['rsg-core']:GetCoreObject()
    
        oxInv = GetResourceState('ox_inventory') == 'started' 
    
        
        function FXRegisterCallback(eventName, callBack,...)
            RSGCore.Functions.CreateCallback(eventName, function(source, cb, ...)
                callBack(source,cb,...)
            end)
        end
        
        function FXCloseInventory(src)
            if oxInv then
                TriggerClientEvent("fx-trade:client:CloseInventory", src)
            else
                TriggerClientEvent("rsg-inventory:client:closeinv", src)
            end 
        end
    
        function FXRemoveItem(src,itemName,itemCount,slot)
            if oxInv then
                return exports.ox_inventory:RemoveItem(src, itemName, itemCount, nil, slot, false)
            else
                local Player = RSGCore.Functions.GetPlayer(src)
                return Player.Functions.RemoveItem(itemName, itemCount,slot)
            end
    
        end
        
        function FXAddItem(src,itemName,itemCount,Metadata)
            
            if oxInv then
                return exports.ox_inventory:AddItem(src, itemName, itemCount, Metadata, false)
            else
                local Player = RSGCore.Functions.GetPlayer(src)
                return Player.Functions.AddItem(itemName, itemCount,nil,Metadata)
            end
        end
        
       function FXGetItem(src,ItemName)
            local Player = RSGCore.Functions.GetPlayer(src)
            local founditem = false
            for slot,item in pairs(Player.PlayerData.items) do
                if item.name:lower() == ItemName:lower() then
                    founditem = item
                    break
                end
            end
            return founditem
        end
       
        function FXGetItemCount(src,ItemName)
            local Player = RSGCore.Functions.GetPlayer(src)
            local founditemcount = 0
            for slot,item in pairs(Player.PlayerData.items) do
                if item.name:lower() == ItemName:lower() then
                    founditemcount = item.amount
                    break
                end
            end
            return founditemcount
        end
        
        function FXHaveMoney(src,moneytype,count)
            local Player = RSGCore.Functions.GetPlayer(src)
            if Player.PlayerData.money["cash"] >= count and moneytype == "cash" then
                return true
            elseif Player.PlayerData.money["bank"] >= count and moneytype == "gold" then
                return true
            end 
            return false
        end
        function FXRemoveMoney(src,moneytype,count)
            local Player = RSGCore.Functions.GetPlayer(src)
            if moneytype == "cash" then
                Player.Functions.RemoveMoney('cash', count, 'fx-trade')
            else
                Player.Functions.RemoveMoney('bank', count, 'fx-trade')
            end
            return true
        end
        function FXAddMoney(src,moneytype,count)
            local Player = RSGCore.Functions.GetPlayer(src)
            if moneytype == "cash" then
                Player.Functions.AddMoney('cash', count, 'fx-trade')
            else
                Player.Functions.AddMoney('bank', count, 'fx-trade')
            end
            return true
        end
        function FXGetPlayerData(src)
            local Player = RSGCore.Functions.GetPlayer(src)
            local array = {
                firstname = Player.PlayerData.charinfo.firstname,
                lastname = Player.PlayerData.charinfo.firstname,
                job = Player.PlayerData.job.name,
                grade = Player.PlayerData.job.grade.level,
                charIdentifier = Player.PlayerData.citizenid,
                cash = Player.PlayerData.money["cash"],
                gold = Player.PlayerData.money["bank"],
            }
            return array
        end
       
        function FXGetUserInActive(charid)
            for _, source in pairs(GetPlayers()) do
                local User = RSGCore.Functions.GetPlayer(src)
                if charid == Player.PlayerData.citizenid then
                    return source
                end
            end
        end
    
        function FXCanCarry(src,item,count)
            if oxInv then
                return exports.ox_inventory:CanCarryItem(src, item, count)
            else
                return true
            end
        end
    
        function FXGetUserInventory(src,cb)
            if oxInv then
                local playerItems = exports.ox_inventory:GetInventoryItems(src)
                cb(playerItems)
            else
                local Player = RSGCore.Functions.GetPlayer(src)
                cb(Player.PlayerData.items)
            end
        end
    else
        RSGCore = exports['rsg-core']:GetCoreObject()
    
        RegisterNetEvent("fx-trade:client:CloseInventory", function()
            exports.ox_inventory:closeInventory()
        end)
        
        function FXTriggerServerCallback(eventName,callBack,...)
            RSGCore.Functions.TriggerCallback(eventName,function(...)
                callBack(...)
            end,...)
        end
    end
end

