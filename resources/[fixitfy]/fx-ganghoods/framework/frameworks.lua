Framework = "none"
onPlayerLoadEvent = "none" 
LoadTimeout = 5
if GetResourceState('rsg-core') == 'started' then
    Framework = "RSG"
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


CurrentBookId = nil

if Framework == "VORP" then
    if IsDuplicityVersion() then
    --[[
        Server Side
    ]]
    VorpCore = {}

    TriggerEvent("getCore", function(core)
        VorpCore = core
    end)

    VorpInv = {}
    VorpInv = exports.vorp_inventory:vorp_inventoryApi()
    
    function FXRegisterCallback(eventName, callBack,...)
        VorpCore.addRpcCallback(eventName, function(source, cb, ...)
            callBack(source,cb,...)
        end)
    end
    
    function FXCloseInventory(src)
        VorpInv.CloseInv(src)
    end
    
    function FXRemoveItem(src,itemName,itemCount,Metadata)
        if string.sub(itemName, 1, string.len("WEAPON_")) == "WEAPON_" or string.sub(itemName, 1, string.len("WEAPON_")) == "weapon_" then
            for i=1, itemCount do
                exports.vorp_inventory:getUserInventoryWeapons(src, function(result)
                    for k,v in pairs(result) do
          
                        if v.name == itemName then
                            VorpInv.subWeapon(src, v.id)
                            break
                        end
                    end
                end)
      
            end
        else
            VorpInv.subItem(src, itemName, itemCount, Metadata)
        end
    end

    function FXGetItemCount(src, ItemName, cb)
        if string.sub(ItemName, 1, 7) == "WEAPON_" then
            exports.vorp_inventory:getUserInventoryWeapons(src, function(weaponData)
                local weaponCount = 0
                for _, weapon in pairs(weaponData) do
                    if weapon.name == ItemName then
                        weaponCount = weaponCount + 1
                    end
                end
                cb(weaponCount or 0)
            end)
        else
            local retval = exports.vorp_inventory:getUserInventoryItems(src)
            if not retval then
                cb(0)
                return
            end
            
            local itemCount = 0
            for key, value in pairs(retval) do
                if value.name == ItemName then
                    itemCount = itemCount + value.count
                end
            end
            
            cb(itemCount)
        end
    end
    
    function FXGetPlayerData(src)
        local User = VorpCore.getUser(src)
        local array = {}
        if not User then
            return array
        end
        local Character = User.getUsedCharacter
        array = {
            charid = Character.charIdentifier,       
            firstname = Character.firstname,
            lastname = Character.lastname,
            job = Character.job,
            grade = Character.jobGrade,
            admin = User.getGroup == "admin"
        }
        return array
    end

    else
    --[[
        Client Side
    ]]    

        VorpCore = {}
        TriggerEvent("getCore", function(core)
            VorpCore = core
        end)

        function FXTriggerServerCallback(eventName,callBack,...)
            VorpCore.RpcCall(eventName,function(...)
                callBack(...)
            end,...)
        end
    end
elseif Framework == "RSG" then
    if IsDuplicityVersion() then
        --[[
            Server Side
        ]]
        RSGCore = exports['rsg-core']:GetCoreObject()
        
        function FXRegisterCallback(eventName, callBack,...)
            RSGCore.Functions.CreateCallback(eventName, function(source, cb, ...)
                callBack(source,cb,...)
            end)
        end

        function FXCloseInventory(src)
            TriggerClientEvent("rsg-inventory:client:closeinv", src)
        end
        
        function FXRemoveItem(src,itemName,itemCount,Metadata)
            local Player = RSGCore.Functions.GetPlayer(src)
            local foundslot = false
            for slot,item in pairs(Player.PlayerData.items) do
                if item.name:lower() == itemName:lower() then
                    if Metadata then
                        if item.info.privateID == Metadata.privateID then
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
            Player.Functions.RemoveItem(itemName, itemCount,foundslot)
        end
    
        function FXGetItemCount(src, ItemName, cb)
            local Player = RSGCore.Functions.GetPlayer(src)
            if not Player or not Player.PlayerData or not Player.PlayerData.items then
                cb(0)
                return
            end
            local foundItem = 0
            for _, item in pairs(Player.PlayerData.items) do
                if item.name and item.name:lower() == ItemName:lower() then
                    foundItem = item.amount
                    break
                end
            end
            cb(foundItem or 0)
        end

        function FXGetPlayerData(src)
            local Player = RSGCore.Functions.GetPlayer(src)
            local array = {
                charid = Player.PlayerData.citizenid,
                firstname = Player.PlayerData.charinfo.firstname,
                lastname = Player.PlayerData.charinfo.firstname,
                job = Player.PlayerData.job.name,
                grade = Player.PlayerData.job.grade.level,
                charid = Player.PlayerData.citizenid,
                admin = Player and RSGCore.Functions.HasPermission(src, 'admin') or false
            }
            return array
        end
    
    else
    --[[
        Client Side
    ]]    
        RSGCore = exports['rsg-core']:GetCoreObject()

        function FXTriggerServerCallback(eventName,callBack,...)
            RSGCore.Functions.TriggerCallback(eventName,function(...)
                callBack(...)
            end,...)
        end
    end
end
