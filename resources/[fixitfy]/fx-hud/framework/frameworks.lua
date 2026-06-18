

LoadTimeout = 5 
Framework = "none"
onPlayerLoadEvent = "none" 
invVersion = "1.0"

if GetResourceState('rsg-core') == 'started' then
    Framework = "RSG"
    LoadTimeout = 5
    onPlayerLoadEvent = "RSGCore:Client:OnPlayerLoaded"
    invVersion = GetResourceMetadata("rsg-inventory", 'version', 0)
    print("^2[INFO]^0 Framework selected: ^3" .. Framework .. "^0")
elseif GetResourceState('vorp_core') == 'started' then
    Framework = "VORP"
    onPlayerLoadEvent = "vorp:SelectedCharacter" 
    LoadTimeout = 5
    invVersion = GetResourceMetadata("vorp_inventory", 'version', 0)
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

if IsDuplicityVersion() then
    if Framework == "VORP" then
        --#### SERVER SIDE ####--
        local VorpCore = exports.vorp_core:GetCore()
        VorpInv = {}
        VorpInv = exports.vorp_inventory:vorp_inventoryApi()
        

        function FXRegisterUsableItem(itemname, callBack)
            local parsedVer = invVersion and tonumber(tostring(invVersion):match("^(%d+%.?%d*)"))
            if parsedVer and parsedVer >= 4.0 then
                exports.vorp_inventory:registerUsableItem(itemname, function(data)
                    local array = {
                        source = data.source,                  
                        item = data.item.name,                
                        id = data.item.id or nil,             
                        metadata = data.item.metadata or {},   
                        isDegradable = data.item.isDegradable, 
                        percentage = data.item.percentage,    
                        label = data.item.label,
                        unique = true                  
                    }
            
                    callBack(array)
                end)
            else
                VorpInv.RegisterUsableItem(itemname, function(data)
                    local array = {
                        source = data.source,                  
                        item = data.item.item,                
                        id = data.item.mainid or nil,             
                        metadata = data.item.metadata or {},   
                        isDegradable = false, 
                        percentage = false,    
                        label = data.item.label,
                        unique = true     
                    }
                    callBack(array)
                end)
            end
        end

        function FXRegisterCallback(eventName, callBack)
            VorpCore.addRpcCallback(eventName, function(source, cb, ...)
                callBack(source,cb,...)
            end)
        end
        
        function FXCloseInventory(src)
            exports.vorp_inventory:closeInventory(src)
        end

        function FXLockInventory(src)
            --TriggerClientEvent('vorp_inventory:Client:DisableInventory',src, true)
        end

        function FXUnlockInventory(src)
            --TriggerClientEvent('vorp_inventory:Client:DisableInventory',src, false)
        end
        function FXRemoveItem(src,itemName,itemCount,Metadata, ItemId)
            local parsedVer = invVersion and tonumber(tostring(invVersion):match("^(%d+%.?%d*)"))
            if parsedVer and parsedVer >= 4.0 then
                exports.vorp_inventory:subItemById(src,ItemId)
            else
                exports.vorp_inventory:subItem(src, itemName, itemCount, Metadata)
            end
        end

        function FXAddItem(src, itemName, itemCount, Metadata, degradation, percentage)
            local allow = false 
            local degradation = degradation and os.time() or nil
            local percentage = percentage or nil
        
            exports.vorp_inventory:addItem(src, itemName, itemCount, Metadata, nil, allow, degradation, percentage)
        end
        
        function FXUpdateMetadata(src, itemId, metadata)
            if src and itemId and metadata then
                exports.vorp_inventory:setItemMetadata(src, itemId, metadata)
            else
                print("[FXUpdateMetadata] Missing parameter(s): src="..tostring(src)..", itemId="..tostring(itemId)..", metadata="..json.encode(metadata or {}))
            end
        end
        
        function FXGetPlayerData(src)
            local User = VorpCore.getUser(src)
            if not User then return false end
            local Character = User.getUsedCharacter
            local array = {
                charIdentifier = Character.charIdentifier,
                cash = Character.money,
                gold = Character.gold,
                admin = User.getGroup == "admin",
                group = User.getGroup,
                job = Character.job,
            }
            return array
        end
    elseif Framework == "RSG" then
        --#### SERVER SIDE ####--
        RSGCore = exports['rsg-core']:GetCoreObject()
        function FXRegisterUsableItem(itemname, callBack)
            RSGCore.Functions.CreateUseableItem(itemname, function(source, item)
                local array = {
                    source = source,                       
                    item = item.name,   
                    metadata = item.info or {},                     
                    label = item.label,
                    unique = item.unique             
                }
        
                callBack(array)
            end)
        end
        
        
        function FXRegisterCallback(eventName, callBack)
            RSGCore.Functions.CreateCallback(eventName, function(source, cb, ...)
                callBack(source,cb,...)
            end)
        end
        
        function FXCloseInventory(src)
            TriggerClientEvent("rsg-inventory:client:closeinv", src)
        end        
        
        function FXLockInventory(src)
            local player = Player(src)
            player.state.inv_busy = true
        end

        function FXUnlockInventory(src)
            local player = Player(src)
            player.state.inv_busy = false
        end

        function FXRemoveItem(src,itemName,itemCount,Metadata, ItemId)
            local Player = RSGCore.Functions.GetPlayer(src)
            local foundslot = false
            for slot,item in pairs(Player.PlayerData.items) do
                if item.name:lower() == itemName:lower() then
                    if Metadata and Metadata.remainingUsage ~= nil then
                        if item.info and item.info.remainingUsage == Metadata.remainingUsage then
                            foundslot = slot
                            break
                        end
                    else
                        foundslot = slot
                        break
                    end
                end
            end
            if not foundslot then return false end
            Wait(100)
            -- Player.Functions.RemoveItem(itemName, itemCount,foundslot)
            exports['rsg-inventory']:RemoveItem(src, itemName, itemCount, foundslot, 'fx-hud:FXRemoveItem')
        end
        
        function FXAddItem(src, itemName, itemCount, Metadata, degradation, percentage)
            -- Player.Functions.AddItem(itemName, itemCount,Metadata)

            exports['rsg-inventory']:AddItem(src, itemName, itemCount, false, Metadata, 'fx-hud:AddItem')

        end
        
        function FXGetPlayerData(src)
            local Player = RSGCore.Functions.GetPlayer(src)
            return {
                charIdentifier = Player and Player.PlayerData.citizenid or "nil",
                cash = Player and Player.PlayerData.money['cash'] or 0,
                gold = Player and Player.PlayerData.money['bank'] or 0,
                admin = Player and RSGCore.Functions.HasPermission(src, 'admin') or false
            }
        end
        
    end
else
    if Framework == "VORP" then
        --#### CLIENT SIDE ####--
        VorpCore = exports.vorp_core:GetCore()
        function FXTriggerServerCallback(eventName,callBack,...)
            VorpCore.RpcCall(eventName,function(...)
                callBack(...)
            end,...)
        end

        function FXLockInventory()
            TriggerEvent('vorp_inventory:Client:DisableInventory',true)
        end

        function FXUnlockInventory()
            TriggerEvent('vorp_inventory:Client:DisableInventory',false)
        end

    elseif Framework == "RSG" then
        RSGCore = exports['rsg-core']:GetCoreObject()

        function FXTriggerServerCallback(eventName,callBack,...)
            RSGCore.Functions.TriggerCallback(eventName,function(...)
                callBack(...)
            end,...)
        end

        function FXLockInventory()
            LocalPlayer.state:set('inv_busy', true, true)
        end

        function FXUnlockInventory()
            LocalPlayer.state:set('inv_busy', false, true)
        end
    
    end
end


