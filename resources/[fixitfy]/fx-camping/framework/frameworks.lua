Framework        = "none"
onPlayerLoadEvent = "none"
LoadTimeout      = 5
FXTarget         = { system = nil }

if GetResourceState('rsg-core') == 'started' then
    Framework         = "RSG"
    onPlayerLoadEvent = "RSGCore:Client:OnPlayerLoaded"
    LoadTimeout       = 5
    Config.ItemImagePath = "nui://fx-camping/ui/assets/img/%s.png"
    print("^2[INFO]^0 Framework selected: ^3" .. Framework .. "^0")
elseif GetResourceState('vorp_core') == 'started' then
    Framework         = "VORP"
    onPlayerLoadEvent = "vorp:SelectedCharacter"
    LoadTimeout       = 5
    Config.ItemImagePath = "nui://fx-camping/ui/assets/img/%s.png"
    print("^2[INFO]^0 Framework selected: ^3" .. Framework .. "^0")
else
    Citizen.CreateThread(function()
        while true do
            Citizen.Wait(2000)
            print("^1[ERROR]^0 No suitable framework found. Please install vorp_core or rsg-core.")
        end
    end)
end

-- ─── SERVER ──────────────────────────────────────────────────────────────────

if IsDuplicityVersion() then

    if Framework == "VORP" then
        local VorpCore = exports.vorp_core:GetCore()
        local VorpInv  = exports.vorp_inventory

        -- Version check: warn if vorp_inventory is below 4.5
        local _invVer = GetResourceMetadata('vorp_inventory', 'version', 0) or '0'
        local function _parseVer(v)
            local major, minor = tostring(v):match("^(%d+)%.(%d+)")
            return tonumber(major) or 0, tonumber(minor) or 0
        end
        local _maj, _min = _parseVer(_invVer)
        if _maj < 4 or (_maj == 4 and _min < 5) then
            print("^1[fx-camping] WARNING: vorp_inventory version is '" .. _invVer .. "' — version 4.5 or higher is required.")
            print("^1[fx-camping] Please update: https://github.com/VORPCORE/vorp_inventory^0")
        end
        function FXRegisterCallback(eventName, callBack,...)
            VorpCore.addRpcCallback(eventName, function(source, cb, ...)
                callBack(source,cb,...)
            end)
        end

        function FXRegisterUsableItem(itemname, callBack)
            exports.vorp_inventory:registerUsableItem(itemname, function(data)
                local array = {
                    source = data.source,                  
                    item = data.item.name,                
                    id = data.item.id or nil,             
                    metadata = data.item.metadata or {},   
                    isDegradable = data.item.isDegradable, 
                    percentage = data.item.percentage,    
                    label = data.item.label                
                }
        
                callBack(array)
            end)
        end

        function FXGetPlayerData(src)
            local User = VorpCore.getUser(src)
            if not User then return nil end
            local Char = User.getUsedCharacter
            if not Char then return nil end
            return {
                charid    = Char.charIdentifier,
                job       = Char.job,
                firstname = Char.firstname,
                lastname  = Char.lastname,
            }
        end

        function FXGetPlayerGroup(src)
            local User = VorpCore.getUser(src)
            if User then return User.getGroup end
            return nil
        end

        function FXGetMoney(src)
            local User = VorpCore.getUser(src)
            if not User then return { cash = 0, gold = 0 } end
            local Char = User.getUsedCharacter
            if not Char then return { cash = 0, gold = 0 } end
            return { cash = Char.money or 0, gold = Char.gold or 0 }
        end

        function FXHasItem(src, item)
            local retval = VorpInv:getItem(src, item)
            return retval ~= nil and retval.count > 0
        end
        function FXGetItemCount(src, itemName)
            local retval = VorpInv:getItem(src, itemName)
            return (retval ~= nil and (retval.count or 0)) or 0
        end
        function FXCanCarry(src,item,count)
            if string.sub(item, 1, string.len("WEAPON_")) == "WEAPON_" or string.sub(item, 1, string.len("WEAPON_")) == "weapon_" then
                return exports.vorp_inventory:canCarryWeapons(src, count, nil, item)
            else
                return true
            end
        end
        
        function FXAddItem(src,itemName,itemCount, itemLabel,Metadata)
            if string.sub(itemName, 1, string.len("WEAPON_")) == "WEAPON_" or string.sub(itemName, 1, string.len("WEAPON_")) == "weapon_" then
                -- local serial = "PREMIUM-"..generateSerialNumber()
                for i=1, itemCount do
                    -- exports.vorp_inventory:createWeapon(src, itemName, {}, {}, {}, function(success)
                    -- end,serial,itemLabel)
                    exports.vorp_inventory:createWeapon(src, itemName, {}, {}, {}, function(success)
                    end)
                end
            else
                exports.vorp_inventory:addItem(src, itemName, itemCount, Metadata)
            end
        end

        function FXAddItemStacked(src, itemName, count, label)
            exports.vorp_inventory:getUserInventoryItems(src, function(data)
                local existingCount = 0
                local existingMeta  = nil
                local found         = false
                for _, v in pairs(data or {}) do
                    if v.name == itemName then
                        existingCount = v.count or v.amount or 0
                        existingMeta  = v.metadata or v.meta
                        found         = true
                        break
                    end
                end
                if found then
                    exports.vorp_inventory:subItem(src, itemName, existingCount, existingMeta)
                    exports.vorp_inventory:addItem(src, itemName, existingCount + count, nil)
                else
                    exports.vorp_inventory:addItem(src, itemName, count, nil)
                end
            end)
        end

        -- Admin-given items arrive with no metadata; this re-adds them with a description
        -- so VORP tracks them identically to store-bought items.
        function FXEnsureItemMeta(src, itemName, count, label, callback)
            if count and count > 0 then
                exports.vorp_inventory:subItem(src, itemName, count, nil)
                exports.vorp_inventory:addItem(src, itemName, count, { description = label or itemName })
            end
            if callback then callback() end
        end

        function FXRemoveItem(src,itemName,itemCount,Metadata)
            if Config.Debug then
                print(("^3[fx-camping:debug] FXRemoveItem src=%s item=%s count=%s"):format(
                    tostring(src), tostring(itemName), tostring(itemCount)))
            end
            if string.sub(itemName, 1, string.len("WEAPON_")) == "WEAPON_" or string.sub(itemName, 1, string.len("WEAPON_")) == "weapon_" then
                for i=1, itemCount do
                    exports.vorp_inventory:getUserInventoryWeapons(src, function(result)
                        for k,v in pairs(result) do
                            if v.name == itemName then
                                if Config.Debug then
                                    print(("^3[fx-camping:debug] subWeapon src=%s id=%s"):format(tostring(src), tostring(v.id)))
                                end
                                exports.vorp_inventory:subWeapon(src, v.id)
                                break
                            end
                        end
                    end)
                end
            else
                if Config.Debug then
                    print(("^3[fx-camping:debug] subItem src=%s item=%s count=%s"):format(
                        tostring(src), tostring(itemName), tostring(itemCount or 1)))
                end
                -- Pass nil (not {}) so VORP matches by name regardless of stored metadata
                exports.vorp_inventory:subItem(src, itemName, itemCount or 1, Metadata)
            end
        end
        function FXRemoveMoney(src,count, moneytype)
            local User = VorpCore.getUser(src)
            local Character = User.getUsedCharacter
            if moneytype == "cash" then
                Character.removeCurrency(0, count)
            else
                Character.removeCurrency(1, count)
            end
        end

        function FXAddMoney(src,count, moneytype)
            local User = VorpCore.getUser(src)
            local Character = User.getUsedCharacter
            if moneytype == "cash" then
                Character.addCurrency(0,count)
            else
                Character.addCurrency(1,count)
            end
        end
        function FXCloseInventory(src)
            exports.vorp_inventory:closeInventory(src)
        end

        function FXGetCharacterName(charId, callback)
            exports.oxmysql:execute(
                "SELECT firstname, lastname FROM characters WHERE charidentifier = @id LIMIT 1",
                { ["@id"] = tonumber(charId) },
                function(rows)
                    if rows and rows[1] then
                        callback((rows[1].firstname or "") .. " " .. (rows[1].lastname or ""))
                    else
                        callback(tostring(charId))
                    end
                end
            )
        end
        
        function FXGetUserInventory(src, cb)
            local array = { items = {}, weapons = {} }
        
            exports.vorp_inventory:getUserInventoryItems(src, function(data)
                for k, v in pairs(data or {}) do
                    local meta = v.metadata or v.meta or {}
        
                    local desc =
                        (type(meta) == "table" and meta.description) or
                        v.desc or v.description or
                        "Nice Item"
        
                    array.items[#array.items + 1] = {
                        id = v.id,
                        slot = v.slot,
                        name = v.name,
                        label = v.label or v.name,
                        count = v.count or v.amount or 0,
                        weight = v.weight,
                        limit = v.limit,
                        canUse = v.canUse,
                        isDegradable = v.isDegradable,
                        percentage = v.percentage,
                        group = v.group,
                        type = v.type,
                        desc = desc,
                        description = desc,     
                        metadata = meta
                    }
                end
        
                exports.vorp_inventory:getUserInventoryWeapons(src, function(data2)
                    for k, v in pairs(data2 or {}) do
                        array.weapons[#array.weapons + 1] = {
                            id = v.id,
                            name = v.name,
                            label = v.custom_label or v.label or v.name,
                            serial_number = v.serial_number,
                            -- keep field stable even if VORP weapon meta is missing
                            metadata = v.metadata or {},
                            desc = ("Serial Number: %s"):format(tostring(v.serial_number or "Unknown")),
                            description = ("Serial Number: %s"):format(tostring(v.serial_number or "Unknown"))
                        }
                    end
        
                    cb(array)
                end)
            end)
        end

        function FXUpdateInventorySlot(name, slots)
            exports.vorp_inventory:updateCustomInventorySlots(name, slots)
        end

        function FXRegisterCustomInventory(stashId, settings)
            exports.vorp_inventory:registerInventory({
                id                   = stashId,
                name                 = settings.name or stashId,
                limit                = settings.limit or 100,
                acceptWeapons        = settings.acceptWeapons or false,
                shared               = settings.shared ~= false,
                ignoreItemStackLimit = false,
                whitelistItems       = false,
                whitelistWeapons     = false,
                UseBlackList         = false,
                limitedItems         = false,
                limitedWeapons       = false,
                webhook              = false,
            })
        end

        function FXAddItemsToCustomInventory(stashId, items, charId, callback)
            -- items = { { itemName, count }, ... }
            -- VORP expects { name, amount } not { name, count }
            local vorpItems = {}
            for _, item in ipairs(items) do
                vorpItems[#vorpItems + 1] = { name = item.itemName, amount = item.count or 1 }
            end
            exports.vorp_inventory:addItemsToCustomInventory(stashId, vorpItems, charId, function(success)
                if callback then callback(success) end
            end)
        end

        function HandleCustomInventory(src, stashId, data, storageInfo, char)
            local inventoryName = data.shared and stashId or (stashId .. "_" .. char.charid)
            local stashData = {
                id = inventoryName,
                name = data.name,
                limit = data.limit or 100,
                acceptWeapons = data.acceptWeapons or false,
                shared = data.shared or false,
                ignoreItemStackLimit = data.ignoreItemStackLimit or false,
                whitelistItems = data.whitelistItems or false,
                whitelistWeapons = data.whitelistWeapons or false,
                UseBlackList = data.UseBlackList and true or false,
                limitedItems = data.limitedItems or false,
                limitedWeapons = data.limitedWeapons or false,
                webhook = data.webhook or false
            }
            exports.vorp_inventory:registerInventory(stashData)
            -- updateCustomInventoryData only exists in newer vorp_inventory versions
            pcall(function()
                exports.vorp_inventory:updateCustomInventoryData(inventoryName, stashData)
            end)
            Wait(300)
            FXUpdateInventorySlot(inventoryName, storageInfo.slot or 100)
            Wait(500)
            exports.vorp_inventory:openInventory(src, inventoryName)
        end

        function FXRemoveInventory(stashId, char, shared, callback)
            local inventoryName = shared and stashId or (stashId .. "_" .. char.charid)
            exports.vorp_inventory:removeInventory(inventoryName)
            exports.oxmysql:execute("DELETE FROM fx_stash WHERE name = @name", {
                ['@name'] = inventoryName
            }, function()
                if callback then callback(true, Locale('clearstash')) end
            end)
        end

    elseif Framework == "RSG" then
        local RSGCore = exports['rsg-core']:GetCoreObject()

        function FXRegisterCallback(eventName, callBack,...)
            RSGCore.Functions.CreateCallback(eventName, function(source, cb, ...)
                callBack(source,cb,...)
            end)
        end

        function FXRegisterUsableItem(itemname, callBack)
            RSGCore.Functions.CreateUseableItem(itemname, function(source, item)
                local array = {
                    source = source,                       
                    item = item.name,   
                    metadata = item.metadata or {},                     
                    label = item.label                  
                }
        
                callBack(array)
            end)
        end

        function FXGetPlayerData(src)
            local Player = RSGCore.Functions.GetPlayer(tonumber(src))
            if not Player then return nil end
            local charinfo = Player.PlayerData.charinfo or {}
            return {
                charid    = tonumber(Player.PlayerData.citizenid) or Player.PlayerData.citizenid,
                job       = Player.PlayerData.job and Player.PlayerData.job.name or nil,
                firstname = charinfo.firstname or "",
                lastname  = charinfo.lastname  or "",
            }
        end

        function FXGetPlayerGroup(src)
            if RSGCore.Functions.HasPermission(src, "admin") then return "admin" end
            if RSGCore.Functions.HasPermission(src, "mod")   then return "mod"   end
            return "user"
        end

        function FXGetMoney(src)
            local Player = RSGCore.Functions.GetPlayer(tonumber(src))
            if not Player or not Player.PlayerData or not Player.PlayerData.money then
                return { cash = 0, gold = 0 }
            end
            local m = Player.PlayerData.money
            return {
                cash = m.cash or m.money or 0,
                gold = m.gold or 0,
            }
        end

        function FXHasItem(src, item)
            local Player = RSGCore.Functions.GetPlayer(tonumber(src))
            if not Player or not Player.PlayerData or not Player.PlayerData.items then return false end
            for _, v in pairs(Player.PlayerData.items) do
                if v.name and v.name:lower() == item:lower() and v.amount > 0 then return true end
            end
            return false
        end
        function FXGetItemCount(src, itemName)
            if inventory == "ox_inventory" then
                local oxItems = exports.ox_inventory:GetInventoryItems(src)
                local total = 0
                for _, item in pairs(oxItems or {}) do
                    if item and item.name and item.name:lower() == itemName:lower() then
                        total = total + (item.count or 0)
                    end
                end
                return total
            end
            local Player = RSGCore.Functions.GetPlayer(tonumber(src))
            if not Player or not Player.PlayerData or not Player.PlayerData.items then return 0 end
            local total = 0
            for _, v in pairs(Player.PlayerData.items) do
                if v.name and v.name:lower() == itemName:lower() then
                    total = total + (v.amount or 0)
                end
            end
            return total
        end

        function FXAddItem(src, itemName, itemCount, itemLabel, Metadata)
            local Player = RSGCore.Functions.GetPlayer(src)
            if not Player then return end
        
            if type(Metadata) ~= "table" then Metadata = {} end
        
            if Metadata.description and not Metadata.info then
                Metadata.info = Metadata.description
                Metadata.description = nil
            end
        
            Metadata.label = itemLabel or Metadata.label or itemName
        
            if string.find(string.lower(itemName), "weapon_") and itemCount > 1 then
                for i = 1, itemCount do
                    Wait(200)
                    exports['rsg-inventory']:AddItem(src, itemName, 1, false, Metadata, 'fx-camping:FXAddItem')
                end
            else
                exports['rsg-inventory']:AddItem(src, itemName, itemCount, false, Metadata, 'fx-camping:FXAddItem')
            end
        end 
        function FXRemoveMoney(src,count, moneytype)
            local Player = RSGCore.Functions.GetPlayer(src)
            if moneytype == "cash" then
                Player.Functions.RemoveMoney('cash',count,"fx-store")
            else
                Player.Functions.RemoveMoney('bank',count,"fx-store")
            end
        end

        function FXAddMoney(src,count, moneytype)
            local Player = RSGCore.Functions.GetPlayer(src)
            if moneytype == "cash" then
                Player.Functions.AddMoney('cash',count,"fx-store")
            else
                Player.Functions.AddMoney('bank',count,"fx-store")
            end
        end
        function FXAddItemStacked(src, itemName, count, label)
            FXAddItem(src, itemName, count, label, nil)
        end

        function FXEnsureItemMeta(src, itemName, count, label, callback)
            -- RSG/ox_inventory handles items without metadata correctly; no fix needed
            if callback then callback() end
        end

        function FXRemoveItem(src,itemName,itemCount,Metadata)
            local Player = RSGCore.Functions.GetPlayer(src)
            if not Player then return false end
            local items = Player.PlayerData.items
            if not items then return false end
            local foundslot = false
            for slot, item in pairs(items) do
                if item and item.name and item.name:lower() == itemName:lower() then
                    if Metadata then
                        local info = item.info or {}
                        if info.privateID == Metadata.privateID then
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
            Player.Functions.RemoveItem(itemName, itemCount, foundslot)
        end
        function FXCanCarry(src,item,count)
            local canAdd, reason = exports['rsg-inventory']:CanAddItem(src, item,count)
            if canAdd then
                return true
            else
                return false
            end
        end
        function FXUpdateInventorySlot(name, FinalSlots)
            -- rsg'de gerek yok.
        end
        function HandleCustomInventory(src, name, data, storageInfo, character)
            local inventoryName = data.shared and name or (name .. "_" .. character.charid)
            local slots = storageInfo.slot and storageInfo.slot or 50
        
            local data = {
                maxweight = 1000000,
                slots = slots
            }

            if invVersion and invVersion:sub(1,1) == "1" then
                TriggerClientEvent('fx-stash:inventory:cl:OpenInventory',src, 'stash', inventoryName, data)
            else
                exports['rsg-inventory']:OpenInventory(src, inventoryName, data)
            end

        end
        
        function FXCloseInventory(src)
            TriggerClientEvent("rsg-inventory:client:closeinv", src)
        end

        function FXGetCharacterName(charId, callback)
            -- Try online players first (no DB query needed)
            local cid = tostring(charId)
            for _, pid in ipairs(GetPlayers()) do
                local pData = FXGetPlayerData(tonumber(pid))
                if pData and tostring(pData.charid) == cid then
                    local fn   = pData.firstname or ""
                    local ln   = pData.lastname  or ""
                    local name = ((fn .. " " .. ln):match("^%s*(.-)%s*$"))
                    callback(name ~= "" and name or cid)
                    return
                end
            end
            -- Player offline — citizenid is the best identifier available
            callback(cid)
        end

        function FXRegisterCustomInventory(stashId, settings)
            exports['rsg-inventory']:CreateInventory(stashId, {
                maxweight = 1000000,
                slots     = settings.limit or 200,
                label     = settings.name or stashId,
            })
        end

        function FXAddItemsToCustomInventory(stashId, items, charId, callback)
            local success = true
            for _, item in ipairs(items) do
                local ok = exports['rsg-inventory']:AddItem(stashId, item.itemName, item.count or 1, false, {}, 'fx-camping:wagonStash')
                if not ok then success = false end
            end
            exports['rsg-inventory']:SaveStash(stashId)
            if callback then callback(success) end
        end

        function FXRemoveInventory(name, character, shared, callback)
            local stashName = shared and name or (name .. "_" .. character.charid)
        
            exports.oxmysql:execute("SELECT * FROM inventories WHERE identifier = @identifier", {
                ['@identifier'] = stashName
            }, function(result)
                if result and #result > 0 then
                    exports.oxmysql:execute("DELETE FROM inventories WHERE identifier = @identifier", {
                        ['@identifier'] = stashName
                    }, function()
                        callback(true, Locale('clearstash')) 
                    end)
                else
                    callback(false, Locale('noinvid')) 
                end
            end)
        end  
        function FXGetUserInventory(src, cb)
            if inventory == "ox_inventory" then
                local oxItems = exports.ox_inventory:GetInventoryItems(src)
                local convertedItems = {}
        
                for _, item in pairs(oxItems) do
                    if item and item.name then
                        local description = ""
                        local metadata = item.metadata or {}
                        if metadata.description then
                            description = metadata.description
                        elseif item.description then
                            description = item.description
                        end
        
                        table.insert(convertedItems, {
                            slot = item.slot,
                            name = item.name,
                            label = item.label or item.name,
                            amount = item.count or 0,
                            image = "defaultimg.png",
                            info = metadata,
                            description = description
                        })
                    end
                end
        
                cb(convertedItems)
        
            else
                local Player = RSGCore.Functions.GetPlayer(src)
        
                if not Player or not Player.PlayerData or not Player.PlayerData.items then
                    print("Error: Failed to retrieve player data or inventory is empty.")
                    cb({})
                    return
                end
        
                local items = {}
                for k, v in pairs(Player.PlayerData.items) do
                    if type(v) == "table" and v.name and type(v.name) == "string" then
                        local description = ""
        
                        if v.info and v.info.description then
                            description = v.info.description
                        elseif v.description then
                            description = v.description
                        end
        
                        table.insert(items, {
                            slot = tonumber(v.slot) or k,
                            name = v.name,
                            label = v.label or "",
                            amount = v.amount or 0,
                            image = v.image or "defaultimg.png",
                            info = v.info or {},
                            description = description
                        })
                    end
                end
        
                cb(items)
            end
        end
    end

    -- Fallback: if no framework-specific implementation, always allow
    if not FXHasItem then
        function FXHasItem(_src, _item) return true end
        function FXRemoveItem(_src, _item) end
    end
    if not FXGetItemCount then
        function FXGetItemCount(_src, _item) return 1 end
    end

-- ─── CLIENT ──────────────────────────────────────────────────────────────────

else
    if Framework == "VORP" then
        local VorpCore = exports.vorp_core:GetCore()
        function FXTriggerServerCallback(eventName,callBack,...)
            VorpCore.RpcCall(eventName,function(...)
                callBack(...)
            end,...)
        end

    elseif Framework == "RSG" then
        local RSGCore = exports['rsg-core']:GetCoreObject()
        function FXTriggerServerCallback(eventName,callBack,...)
            RSGCore.Functions.TriggerCallback(eventName,function(...)
                callBack(...)
            end,...)
        end
    end

    -- ── Local char ID + job cache ─────────────────────────────────────────────
    local _localCharId = nil
    local _localJob    = nil
    function FXGetLocalCharId() return _localCharId end
    function FXGetLocalJob()    return _localJob    end

    function FXIsPlayerLoaded()
        if Framework == 'VORP' then
            return LocalPlayer.state.IsInSession == true
        elseif Framework == 'RSG' then
            return LocalPlayer.state.isLoggedIn == true
        end
        return false
    end

    local function fetchLocalCharId()
        FXTriggerServerCallback("fx-camping:server:getMyCharId", function(id, job)
            if id  then _localCharId = id  end
            if job then _localJob    = job end
        end)
    end

    -- Character select event: fires when the player selects their character
    if onPlayerLoadEvent ~= "none" then
        RegisterNetEvent(onPlayerLoadEvent)
        AddEventHandler(onPlayerLoadEvent, function()
            SetTimeout(LoadTimeout * 100, fetchLocalCharId)
        end)
    end

    -- Resource restart: fetch immediately if player is already in game
    CreateThread(function()
        Wait(500)
        if FXIsPlayerLoaded() then
            fetchLocalCharId()
        end
    end)
    -- Detect which target system is installed
    CreateThread(function()
        if not Config.Settings.UseTarget then return end
        if GetResourceState('ox_target') == 'started' then
            FXTarget.system = 'ox_target'
        elseif GetResourceState('pc_interaction') == 'started' then
            FXTarget.system = 'pc_interaction'
        elseif GetResourceState('murphy_interact') == 'started' then
            FXTarget.system = 'murphy_interact'
        else
            Config.Settings.UseTarget = false
            print('^1[fx-camping]^0 UseTarget is true but no supported target resource found. Falling back to prompts.')
        end
        print(('[fx-camping] Target system: %s'):format(FXTarget.system or 'none (prompts)'))
    end)

    -- Add target options to a door entity
    function FXTarget:AddDoor(entity, door)
        if not Config.Settings.UseTarget or not entity or not self.system then return end

        local function interactCb()
            TriggerEvent('fx-camping:local:targetInteract', door.id)
        end
        local function lockpickCb()
            TriggerEvent('fx-camping:local:targetLockpick', door.id)
        end

        local opts = {
            {
                label    = door.locked and 'Unlock Door' or 'Lock Door',
                icon     = door.locked and 'fas fa-lock-open' or 'fas fa-lock',
                onSelect = interactCb,
            },
        }
        -- Pick Lock option: only for locked + lockpickable doors (mirrors prompt[2] behaviour)
        if door.locked and door.lockpickable then
            opts[#opts + 1] = {
                label    = 'Pick Lock',
                icon     = 'fas fa-key',
                onSelect = lockpickCb,
            }
        end

        if self.system == 'ox_target' then
            exports.ox_target:addLocalEntity(entity, opts)
        elseif self.system == 'pc_interaction' then
            for _, o in ipairs(opts) do
                exports.pc_interaction:AddEntityInteraction({
                    entity = entity,
                    label  = o.label,
                    action = o.onSelect,
                })
            end
        elseif self.system == 'murphy_interact' then
            for _, o in ipairs(opts) do
                exports.murphy_interact:AddEntity({
                    entity     = entity,
                    label      = o.label,
                    onInteract = o.onSelect,
                })
            end
        end
    end

    -- Remove target options from a door entity
    function FXTarget:RemoveDoor(entity)
        if not Config.Settings.UseTarget or not entity or not self.system then return end
        if self.system == 'ox_target' then
            exports.ox_target:removeLocalEntity(entity)
        elseif self.system == 'pc_interaction' then
            exports.pc_interaction:RemoveEntityInteraction(entity)
        elseif self.system == 'murphy_interact' then
            exports.murphy_interact:RemoveEntity(entity)
        end
    end

    -- Add store target to a ped entity
    function FXTarget:AddStore(entity, storeKey, index, label)
        if not Config.Settings.UseTarget or not entity or not self.system then return end
        local opts = {
            {
                label    = label or "Open Store",
                icon     = "fas fa-store",
                onSelect = function()
                    TriggerEvent('fx-camping:local:openStore', storeKey, index)
                end,
            },
        }
        if self.system == 'ox_target' then
            exports.ox_target:addLocalEntity(entity, opts)
        elseif self.system == 'pc_interaction' then
            exports.pc_interaction:AddEntityInteraction({
                entity = entity,
                label  = opts[1].label,
                action = opts[1].onSelect,
            })
        elseif self.system == 'murphy_interact' then
            exports.murphy_interact:AddEntity({
                entity     = entity,
                label      = opts[1].label,
                onInteract = opts[1].onSelect,
            })
        end
    end

    -- Remove store target from a ped entity
    function FXTarget:RemoveStore(entity)
        if not Config.Settings.UseTarget or not entity or not self.system then return end
        if self.system == 'ox_target' then
            exports.ox_target:removeLocalEntity(entity)
        elseif self.system == 'pc_interaction' then
            exports.pc_interaction:RemoveEntityInteraction(entity)
        elseif self.system == 'murphy_interact' then
            exports.murphy_interact:RemoveEntity(entity)
        end
    end

end
