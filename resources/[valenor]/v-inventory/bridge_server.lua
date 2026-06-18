
local Core = nil
local RSGCore = nil
local currentFramework = nil
local Locales = Config.Locales[Config.Language]

local ServerInventories = {} 
local ItemDefinitions = {}   
local ServerItemCount = 0
local GroundItems = {}       
local UsableItems = {}       

local DECAY_TIME = 30 * 60 
local vSyncing = {} -- Recursion guard for money sync <!-- id: sync_guard -->

local MosquitoBlacksmithItems = {
    blacksmith_forge = {
        name = "blacksmith_forge",
        label = "Blacksmith Forge",
        weight = 8.0,
        type = "item",
        image = "blacksmith_forge",
        can_remove = false,
        limit = 1,
    },
    blacksmith_forge_advanced = {
        name = "blacksmith_forge_advanced",
        label = "Advanced Blacksmith Forge",
        weight = 10.0,
        type = "item",
        image = "blacksmith_forge_advanced",
        can_remove = false,
        limit = 1,
    },
}

local function UpsertMosquitoBlacksmithItem(name, label, limit, canRemove, usable, weight)
    if not name or name == "forge" or name == "forge_advanced" then return end

    ItemDefinitions[name] = ItemDefinitions[name] or {
        name = name,
        label = label or name,
        weight = tonumber(weight) or 0.0,
        type = "item",
        image = name,
        can_remove = tostring(canRemove) == "1" or canRemove == true,
        limit = tonumber(limit) or 100,
        usable = tostring(usable) == "1" or usable == true,
        useable = tostring(usable) == "1" or usable == true,
    }
end

local function SeedMosquitoBlacksmithItems()
    local contents = LoadResourceFile("mosquito-mining-blacksmithing", "items.sql") or ""
    for itemName, label, limit, canRemove, _itemType, usable, weight in contents:gmatch("%('([^']+)',%s*'([^']*)',%s*([%d%.]+),%s*([01]),%s*'([^']+)',%s*([01]),%s*([%d%.]+)%)") do
        UpsertMosquitoBlacksmithItem(itemName, label, limit, canRemove, usable, weight)
    end

    for name, def in pairs(MosquitoBlacksmithItems) do
        ItemDefinitions[name] = ItemDefinitions[name] or def
    end
end

local function GetRSGCoreObject()
    if RSGCore and RSGCore.Functions then
        return RSGCore
    end

    local ok, core = pcall(function()
        return exports['rsg-core']:GetCoreObject()
    end)

    if ok and core and core.Functions then
        RSGCore = core
        return RSGCore
    end

    if not ok then
        print(("[v-inventory] RSG core export lookup failed: %s"):format(tostring(core)))
    end

    return nil
end

local function LoadRSGItemDefinitions()
    local core = GetRSGCoreObject()
    if not core or not core.Shared or not core.Shared.Items then
        SeedMosquitoBlacksmithItems()
        return
    end

    local count = 0
    for k, v in pairs(core.Shared.Items) do
        ItemDefinitions[k] = {
            name = k,
            label = v.label or k,
            weight = (tonumber(v.weight) or 0) / 1000,
            type = v.type,
            image = k,
            can_remove = (v.delete ~= nil) and v.delete or false,
        }
        count = count + 1
    end

    ServerItemCount = count
    SeedMosquitoBlacksmithItems()
end

local function EnsureFrameworkReady()
    if currentFramework == "rsg" and RSGCore then
        return true
    end

    if currentFramework == "vorp" and Core then
        return true
    end

    if GetResourceState('rsg-core') == 'started' then
        Config.Framework = 'rsg-core'
        currentFramework = "rsg"
        GetRSGCoreObject()
        LoadRSGItemDefinitions()
        return true
    end

    if GetResourceState('vorp_core') == 'started' or GetResourceState('vorp-core') == 'started' then
        Config.Framework = 'vorp'
        currentFramework = "vorp"
        Core = exports.vorp_core:GetCore()
        SeedMosquitoBlacksmithItems()
        return true
    end

    SeedMosquitoBlacksmithItems()
    return false
end


CreateThread(function()
    Wait(1000)

    for _ = 1, 20 do
        if EnsureFrameworkReady() then break end
        Wait(500)
    end
    
    if GetResourceState('rsg-core') == 'started' then
        Config.Framework = 'rsg-core'
        currentFramework = "rsg"
        RSGCore = exports['rsg-core']:GetCoreObject()
        
        -- Load RSG items into ItemDefinitions
        LoadRSGItemDefinitions()
    elseif GetResourceState('vorp_core') == 'started' or GetResourceState('vorp-core') == 'started' then
        Config.Framework = 'vorp'
        currentFramework = "vorp"
        Core = exports.vorp_core:GetCore()
        
        MySQL.query('SELECT * FROM items', {}, function(result)
            if result then
                for _, v in ipairs(result) do
                    local key = v.item or v.name or v.id
                    if key then
                        ItemDefinitions[key] = v
                    end
                end
                ServerItemCount = #result
            else
            end
            SeedMosquitoBlacksmithItems()
        end)
    end
    SeedMosquitoBlacksmithItems()
    print("Loaded " .. ServerItemCount .. " items")
end)

CreateThread(function()
    while true do
        Wait(60000)
        local time = os.time()
        for k, v in pairs(GroundItems) do
            if (time - v.timestamp) > DECAY_TIME then
                GroundItems[k] = nil
            end
        end
    end
end)

local function GetIdentifier(source)
    EnsureFrameworkReady()

    if currentFramework == "vorp" then
        local user = Core.getUser(source)
        if not user then return nil end
        local char = user.getUsedCharacter
        if not char then return nil end
        return char.charIdentifier
    elseif currentFramework == "rsg" then
        local core = GetRSGCoreObject()
        local user = core and core.Functions.GetPlayer(source)
        return user and user.PlayerData.citizenid or nil
    end

    if GetResourceState('rsg-core') == 'started' then
        local core = GetRSGCoreObject()
        local user = core and core.Functions.GetPlayer(source)
        return user and user.PlayerData and user.PlayerData.citizenid or nil
    end
end

local function GetSourceFromIdentifier(identifier)
    for _, src in ipairs(GetPlayers()) do
        local pSrc = tonumber(src)
        if GetIdentifier(pSrc) == identifier then
            return pSrc
        end
    end
    return nil
end

local function GetInventoryId(identifier, type)
    return string.format("%s:%s", identifier, type)
end

AddEventHandler('playerDropped', function()
    local src = source
    local droppedIdentifier = nil
    for invId, data in pairs(ServerInventories) do
        if data.viewers and data.viewers[src] then
            data.viewers[src] = nil
        end
    end
    -- Get identifier before source becomes invalid
    droppedIdentifier = GetIdentifier(src)
    -- Clean up player inventory from memory after delay (allows reconnect)
    if droppedIdentifier then
        SetTimeout(60000, function()
            local stillOnline = GetSourceFromIdentifier(droppedIdentifier)
            if not stillOnline then
                local invId = GetInventoryId(droppedIdentifier, "player")
                ServerInventories[invId] = nil
            end
        end)
    end
end)

-- Periodic stash memory cleanup: remove stashes with no viewers every 5 minutes
CreateThread(function()
    while true do
        Wait(300000) -- 5 minutes
        local cleaned = 0
        for invId, data in pairs(ServerInventories) do
            if not string.find(invId, ":player$") then
                local hasViewers = false
                if data.viewers then
                    for _ in pairs(data.viewers) do hasViewers = true break end
                end
                if not hasViewers then
                    ServerInventories[invId] = nil
                    cleaned = cleaned + 1
                end
            end
        end
        if cleaned > 0 then
            print(string.format("^3[v-inventory] Memory cleanup: removed %d unused stashes from cache.^7", cleaned))
        end
    end
end)

local function GetPlayer(source)
    if not source then return nil end
    EnsureFrameworkReady()
    
    if currentFramework == "vorp" and Core then
        return Core.getUser(source)
    elseif currentFramework == "rsg" and RSGCore then
        local core = GetRSGCoreObject()
        return core and core.Functions.GetPlayer(source) or nil
    end

    if GetResourceState('rsg-core') == 'started' then
        local core = GetRSGCoreObject()
        return core and core.Functions.GetPlayer(source) or nil
    end
    
    return nil
end

local function GetCharacter(source)
    EnsureFrameworkReady()

    local user = GetPlayer(source)
    if not user then return nil end
    
    if currentFramework == "vorp" then
        if type(user.getUsedCharacter) == 'function' then
            return user.getUsedCharacter()
        else
            return user.getUsedCharacter
        end
    elseif currentFramework == "rsg" then
        return {
            money = user.PlayerData.money['cash'] or 0,
            job = user.PlayerData.job.name,
            jobGrade = user.PlayerData.job.grade.level,
            identifier = user.PlayerData.citizenid,
            charIdentifier = user.PlayerData.citizenid,
            source = source,
            removeCurrency = function(_, amount)
                user.Functions.RemoveMoney('cash', amount)
            end,
            addCurrency = function(_, amount)
                user.Functions.AddMoney('cash', amount)
            end
        }
    end
    
    return nil
end


local function GetFrameworkMoney(source)
    if currentFramework == "vorp" then
        local u = Core.getUser(source)
        local c = u and u.getUsedCharacter
        return c and c.money or 0.0
    elseif currentFramework == "rsg" then
        local p = RSGCore.Functions.GetPlayer(source)
        return p and p.PlayerData.money['cash'] or 0.0
    end
    return 0.0
end

local function GetItemDef(itemName)
    if not itemName then return nil end
    local upperName = string.upper(itemName)
    local def = ItemDefinitions[itemName] or ItemDefinitions[upperName] or ItemDefinitions[string.lower(itemName)]
    
    -- Check Config.Weapons (case-insensitive)
    local weaponCfg = Config.Weapons and (Config.Weapons[itemName] or Config.Weapons[upperName])
    local isWeapon = weaponCfg or string.find(upperName, "WEAPON_")

    if isWeapon then
        local label = weaponCfg and weaponCfg.Label or (def and def.label) or upperName
        local weight = weaponCfg and weaponCfg.Weight or (def and def.weight) or Config.WeaponDefaults.Weight or 1.0
        local typeofweapon = "item_weapon"
        if RSGCore then typeofweapon = "weapon" end
        return {
            label = label,
            type = typeofweapon,
            weight = weight
        }
    end

    if def then 
        return {
            label = def.label or itemName,
            weight = def.weight or 0.0,
            type = def.type or "item",
            limit = def.limit or 100,
            can_remove = (def.can_remove ~= nil) and def.can_remove or false
        }
    end

    if upperName == "MONEY" then
        return {
            label = Config.MoneyItemLabel,
            limit = 1000000,
            type = "item_money",
            weight = 0.0,
            can_remove = true
        }
    end
    
    return nil
end

RegisterCommand("vinvitemdef", function(source, args)
    local itemName = args[1] or "blacksmith_forge"
    local raw = ItemDefinitions[itemName] or ItemDefinitions[string.upper(itemName)] or ItemDefinitions[string.lower(itemName)]
    local resolved = GetItemDef(itemName)

    print(("[v-inventory] itemdef %s raw=%s resolved=%s framework=%s"):format(
        itemName,
        json.encode(raw or false),
        json.encode(resolved or false),
        tostring(currentFramework)
    ))

    if source and source > 0 then
        TriggerClientEvent('ox_lib:notify', source, {
            title = resolved and ("itemdef found: " .. itemName) or ("itemdef missing: " .. itemName),
            description = resolved and ((resolved.label or itemName) .. " / weight " .. tostring(resolved.weight or 0)) or "No v-inventory definition.",
            type = resolved and "success" or "error",
            duration = 5000
        })
    end
end, false)

local function MergeMetadata(cacheMeta, dbMeta)
    if not dbMeta then return cacheMeta end
    if not cacheMeta then return dbMeta end
    
    local merged = {}
    -- Copy Cache first (default)
    for k, v in pairs(cacheMeta) do
        merged[k] = v
    end
    
    -- Keys that should ALWAYS be taken from DB if present (Xakra Managed keys)
    local dbAuthoritativeKeys = {
        ['dirt'] = true,
        ['soot'] = true,
        ['damage'] = true,
        ['comps'] = true,
        ['description'] = true -- Sometimes descriptions are updated externally
    }
    
    for k, v in pairs(dbMeta) do
        -- If key is managed by external script, force DB value
        if dbAuthoritativeKeys[k] then
            merged[k] = v
        -- If key is missing in Cache but exists in DB (e.g. new field added by external script), keep it
        elseif merged[k] == nil then
            merged[k] = v
        end
    end
    
    return merged
end

local function SaveInventory(identifier, type, ownerSrc)
    local invId = GetInventoryId(identifier, type)
    if type == "shop" then return end
    local cacheData = ServerInventories[invId]
    if not cacheData then return end
    
    -- "Smart Save": Fetch DB state to prevent overwriting external updates (e.g. xakra_weapons)
    MySQL.query('SELECT items FROM v_inventory WHERE identifier = ? AND type = ?', {identifier, type}, function(result)
        local dbItems = {}
        if result and result[1] then
            dbItems = json.decode(result[1].items) or {}
        end
        
        -- Create a map of DB items for fast lookup by Slot + Name (or Serial/ID for weapons?)
        -- Since Safe Inventory implies Slot consistency, Slot + Name is good.
        -- BUT if player Moved item, Slot changed in Cache but not DB?
        -- If Slot changed, we rely on Cache's Slot.
        -- Matching logic:
        -- Identify item by "Unique Characteristic".
        -- For Weapons: Serial Number.
        -- For Others: Name + Slot (Weak match).
        
        local dbWeaponMap = {}
        for _, item in ipairs(dbItems) do
            if item.metadata and (item.metadata.serial or item.metadata.id) then
                local id = item.metadata.serial or item.metadata.id
                dbWeaponMap[id] = item
            end
        end
        
        local itemsToSave = {}
        for _, cacheItem in ipairs(cacheData.items) do
            local finalItem = cacheItem
            
            -- Attempt to find corresponding DB item to merge metadata
            local dbMatch = nil
            
            -- 1. Try match by Serial (Strongest)
            if cacheItem.metadata and (cacheItem.metadata.serial or cacheItem.metadata.id) then
                local id = cacheItem.metadata.serial or cacheItem.metadata.id
                dbMatch = dbWeaponMap[id]
            end
            
            -- 2. If valid match found, merge metadata
            if dbMatch and dbMatch.metadata then
                cacheItem.metadata = MergeMetadata(cacheItem.metadata, dbMatch.metadata)
            end

            if cacheItem.type == "item_money" then
                cacheItem.metadata = {}
            end
            
            table.insert(itemsToSave, finalItem)
        end
        
        -- Now save the merged state
        local jsonItems = json.encode(itemsToSave)

        MySQL.query('INSERT INTO v_inventory (identifier, type, items) VALUES (?, ?, ?) ON DUPLICATE KEY UPDATE items = ?', {
            identifier, type, jsonItems, jsonItems
        }, function(res)
            -- Done
        end)
    end)
    
    if ownerSrc then
        TriggerEvent('v-inventory:server:NotifyUpdate', ownerSrc)
    end

    for src, _ in pairs(cacheData.viewers) do
        TriggerEvent('v-inventory:server:NotifyUpdate', src)
    end
end

local function LoadInventory(identifier, type)
    local invId = GetInventoryId(identifier, type)
    
    if ServerInventories[invId] then
        return ServerInventories[invId]
    end

    if type == "shop" then
        ServerInventories[invId] = { items = {}, viewers = {} }
        return ServerInventories[invId]
    end
    
    ServerInventories[invId] = {
        items = {},
        viewers = {}
    }
    
    local p = promise.new()
    
    MySQL.query('SELECT items FROM v_inventory WHERE identifier = ? AND type = ?', {identifier, type}, function(result)
        local items = {}
        if result and result[1] then
            items = json.decode(result[1].items) or {}
        elseif type == "player" and Config.StarterItems then
            for i, starter in ipairs(Config.StarterItems) do
                local def = GetItemDef(starter.name)
                table.insert(items, {
                    name = starter.name,
                    amount = starter.amount,
                    label = def and def.label or starter.name,
                    weight = def and def.weight or 0,
                    type = def and def.type or "item",
                    metadata = starter.metadata or {},
                    slot = i
                })
            end
        end

        if items then
            local needsSave = false
            for k, v in pairs(items) do
                local def = GetItemDef(v.name)
                if def then
                    v.label = def.label or v.label or v.name
                    v.weight = def.weight or v.weight or 0
                    v.type = def.type or v.type or "item"
                    v.limit = def.limit or v.limit or 100
                    v.image = (def.image or v.name) .. ".png"
                    v.can_remove = (def.can_remove ~= nil) and def.can_remove or false
                else
                    v.label = v.label or v.name
                    v.weight = v.weight or 0
                    v.image = v.name .. ".png"
                    v.can_remove = (v.can_remove ~= nil) and v.can_remove or false
                end
                
                if v.type == "item_weapon" or (v.name and string.find(string.upper(v.name), "WEAPON_")) or v.type == "weapon" then
                    if not v.metadata then v.metadata = {} end
                    
                    if currentFramework == "rsg" then
                         -- Alias metadata to info
                         v.info = v.metadata
                         
                         -- Handle Serial/Serie mapping
                         if not v.metadata.serial and not v.info.serie then
                             v.metadata.serial = string.upper(tostring(os.time()) .. math.random(100,999))
                             v.info.serie = v.metadata.serial
                             needsSave = true
                         elseif v.metadata.serial and not v.info.serie then
                             v.info.serie = v.metadata.serial
                         elseif v.info.serie and not v.metadata.serial then
                             v.metadata.serial = v.info.serie
                         end
                    else
                        if not v.metadata.serial then
                            v.metadata.serial = string.upper(tostring(os.time()) .. math.random(100,999))
                            needsSave = true
                        end
                    end
                end
                
                if currentFramework == "rsg" then
                    v.info = v.metadata
                    if v.metadata and v.metadata.serial then v.info.serie = v.metadata.serial end
                end
                
                if v.metadata and v.metadata.serial then
                    v.id = v.metadata.serial
                end

                if v.type == "item_money" then
                    v.metadata = {}
                end

                ServerInventories[invId].items = items
            end
            
            if needsSave then
                local jsonItems = json.encode(items)
                MySQL.query('INSERT INTO v_inventory (identifier, type, items) VALUES (?, ?, ?) ON DUPLICATE KEY UPDATE items = ?', {
                    identifier, type, jsonItems, jsonItems
                })
            end
        end
        p:resolve()
    end)
    
    Citizen.Await(p)
    return ServerInventories[invId]
end

local function SyncMoney(source)
    if not source or vSyncing[source] then return end
    vSyncing[source] = true
    
    local frameworkMoney = GetFrameworkMoney(source)
    local identifier = GetIdentifier(source)
    if not identifier then 
        vSyncing[source] = nil
        return 
    end
    
    local invId = GetInventoryId(identifier, "player")
    if not ServerInventories[invId] then LoadInventory(identifier, "player") end
    
    local data = ServerInventories[invId]
    if not data or not data.items then 
        vSyncing[source] = nil
        return 
    end
    
    -- Calculate total money already in inventory across all stacks
    -- Cleanup: Remove any 0 or negative money items first to avoid inaccurate inventoryMoney calculation
    for i = #data.items, 1, -1 do
        local item = data.items[i]
        if item.name == "money" then
            item.amount = tonumber(string.format("%.2f", item.amount or 0))
            if item.amount <= 0 then
                table.remove(data.items, i)
            end
        end
    end

    local inventoryMoney = 0
    for _, item in ipairs(data.items) do
        if item.name == "money" then
            inventoryMoney = inventoryMoney + (item.amount or 0)
        end
    end
    
    inventoryMoney = tonumber(string.format("%.2f", inventoryMoney))
    frameworkMoney = tonumber(string.format("%.2f", frameworkMoney))

    -- Only sync if inventory has LESS money than framework (safety/initial load/recovery)
    -- If inventory (stacks) sum up to frameworkMoney, we do nothing to preserve distribution
    local diff = tonumber(string.format("%.2f", frameworkMoney - inventoryMoney))
    
    if diff > 0 then
        -- Find a free slot
        local usedSlots = {}
        for _, item in ipairs(data.items) do
            if item.slot then
                usedSlots[item.slot] = true
            end
        end
        
        local freeSlot = 1
        while usedSlots[freeSlot] do
            freeSlot = freeSlot + 1
        end
        
        local def = GetItemDef("money")
        table.insert(data.items, {
            name = "money",
            amount = diff,
            label = def and def.label or "Para",
            weight = def and def.weight or 0,
            type = def and def.type or "item_money",
            metadata = {},
            slot = freeSlot
        })
        
        SaveInventory(identifier, "player", source)
    elseif diff < 0 then
        local excessToRemove = math.abs(diff)
        -- Iterate backwards to safely remove items from table
        for i = #data.items, 1, -1 do
            local item = data.items[i]
            if item.name == "money" then
                item.amount = tonumber(string.format("%.2f", item.amount))
                if item.amount >= excessToRemove then
                    item.amount = tonumber(string.format("%.2f", item.amount - excessToRemove))
                    excessToRemove = 0
                    if item.amount <= 0 then
                        table.remove(data.items, i)
                    end
                else
                    excessToRemove = tonumber(string.format("%.2f", excessToRemove - item.amount))
                    table.remove(data.items, i)
                end

                if excessToRemove <= 0 then
                    break
                end
            end
        end
        SaveInventory(identifier, "player", source)
    end
    
    vSyncing[source] = nil
end

local function GetTotalWeight(items)
    local w = 0
    for _, item in ipairs(items) do
        w = w + ((item.weight or 0) * item.amount)
    end
    return w
end

local function GetContainerLimit(type, id)
    if type == "player" then return Config.PlayerCapacity or 20.0 end
    if type == "stash" and Config.Stashes then
        for _, s in ipairs(Config.Stashes) do
            if s.name == id then return s.capacity end
            if s.type == "private" and string.find(id, "^" .. s.name .. "_") then
                return s.capacity
            end
        end
    end
    return 10000.0
end

local function AddItem(source, itemName, amount, metadata, containerType, containerId, slot)
    
    amount = tonumber(string.format("%.2f", amount or 1)) -- Force 2 decimal precision
    EnsureFrameworkReady()
    SeedMosquitoBlacksmithItems()
    local identifier = containerId
    local invType = containerType or "player"
    
    if not identifier then
        identifier = GetIdentifier(source)
    end
    if not identifier then
        print(("[v-inventory] AddItem failed: no identifier for source=%s item=%s"):format(tostring(source), tostring(itemName)))
        return false, "no inventory identifier"
    end
    
    local invData = LoadInventory(identifier, invType)
    local items = invData.items
    
    local itemDef = GetItemDef(itemName)
    if itemDef and (itemDef.type == "item_weapon" or itemDef.type == "weapon") then
        if not metadata then metadata = {} end
        
        if not metadata.ammo then
             metadata.ammo = Config.WeaponDefaults.DefaultAmmo or 0
        end
        
        if not metadata.durability then
             metadata.durability = Config.WeaponDefaults.Durability or 100.0
        end
        
        if currentFramework == "rsg" then
            if not metadata.serial and not metadata.serie then
                 metadata.serial = string.upper(tostring(os.time()) .. math.random(100,999))
                 metadata.serie = metadata.serial
            elseif metadata.serial and not metadata.serie then
                 metadata.serie = metadata.serial
            elseif metadata.serie and not metadata.serial then
                 metadata.serial = metadata.serie
            end
        else
            if not metadata.serial then
                 metadata.serial = string.upper(tostring(os.time()) .. math.random(100,999))
            end
        end
    end

    if Config.ContainerItems and Config.ContainerItems[itemName] then
        if not metadata then metadata = {} end
        if not metadata.containerId then
            local uniqueId = string.upper(tostring(os.time()) .. math.random(1000, 9999))
            metadata.containerId = "VLN_" .. uniqueId
            metadata.containerLabel = Config.ContainerItems[itemName].label
        end
    end

    if not itemDef then
        print(("[v-inventory] AddItem failed: missing item definition for %s"):format(tostring(itemName)))
        return false, "missing item definition: " .. tostring(itemName)
    end
    
    local maxStack = itemDef and itemDef.limit or 100 
    local label = itemDef and itemDef.label or itemName

    local weight = itemDef and itemDef.weight or 0.0

    local currentTotal = GetTotalWeight(items)
    local maxWeight = GetContainerLimit(invType, identifier)
    if (currentTotal + (weight * amount)) > maxWeight then
        VBridge.Notify(source, Locales.invFullWeight, 3000, 'error')
        print(("[v-inventory] AddItem failed: weight limit item=%s current=%.2f add=%.2f max=%.2f"):format(tostring(itemName), currentTotal, weight * amount, maxWeight))
        return false, "inventory weight limit"
    end
    
    local function AddToSlot(targetSlot)
        for _, item in ipairs(items) do
            if item.slot == targetSlot then
                local meta1 = (not item.metadata or (type(item.metadata) == "table" and next(item.metadata) == nil)) and "empty" or json.encode(item.metadata)
                local meta2 = (not metadata or (type(metadata) == "table" and next(metadata) == nil)) and "empty" or json.encode(metadata)
                
                if item.name == itemName and meta1 == meta2 then
                    item.amount = tonumber(string.format("%.2f", item.amount + amount))
                    return true
                else
                    return false
                end
            end
        end
        local newItem = {
            name = itemName,
            amount = amount,
            label = itemDef and itemDef.label or itemName,
            weight = itemDef and itemDef.weight or 0,
            type = itemDef and itemDef.type or "item",
            metadata = metadata,
            slot = targetSlot,
            can_remove = itemDef and itemDef.can_remove
        }
        if currentFramework == "rsg" then
            newItem.info = newItem.metadata
        end
        table.insert(items, newItem)
        return true
    end

    if slot then
        local success = AddToSlot(slot)
        if not success then return false, "target slot occupied" end
    else
        local stackFound = false
        for _, item in ipairs(items) do
            local meta1 = (not item.metadata or (type(item.metadata) == "table" and next(item.metadata) == nil)) and "empty" or json.encode(item.metadata)
            local meta2 = (not metadata or (type(metadata) == "table" and next(metadata) == nil)) and "empty" or json.encode(metadata)
            
            if item.name == itemName and meta1 == meta2 then
                item.amount = tonumber(string.format("%.2f", item.amount + amount))
                stackFound = true
                break
            end
        end
        
        if not stackFound then
            local usedSlots = {}
            for _, item in ipairs(items) do
                if item.slot then usedSlots[item.slot] = true end
            end
            
            local newSlot = 1
            while usedSlots[newSlot] do newSlot = newSlot + 1 end
            
            local newItem = {
                name = itemName,
                amount = amount,
                label = itemDef and itemDef.label or itemName,
                weight = itemDef and itemDef.weight or 0,
                type = itemDef and itemDef.type or "item",
                metadata = metadata,
                slot = newSlot,
                can_remove = itemDef and itemDef.can_remove
            }
            if currentFramework == "rsg" then
                newItem.info = newItem.metadata
            end
            table.insert(items, newItem)
        end
    end
    
    if currentFramework == "rsg" or GetResourceState('rsg-core') == 'started' then
        local core = GetRSGCoreObject()
        local Player = core and core.Functions.GetPlayer(source)
        if Player then
            Player.Functions.SetPlayerData('items', items)
        else
            print(("[v-inventory] AddItem warning: RSG player lookup failed for source=%s item=%s; saving inventory only"):format(tostring(source), tostring(itemName)))
        end
    end

    SaveInventory(identifier, invType, source)
    
    -- Sync framework money if this is a money item and it's the player's own inventory
    if itemName == "money" and invType == "player" then
        local targetSrc = GetSourceFromIdentifier(identifier)
        if targetSrc and not vSyncing[targetSrc] then
            vSyncing[targetSrc] = true
            if currentFramework == "vorp" then
                local character = GetCharacter(targetSrc)
                if character then character.addCurrency(0, amount) end
            elseif currentFramework == "rsg" then
                local player = GetPlayer(targetSrc)
                if player then player.Functions.AddMoney('cash', amount) end
            end
            vSyncing[targetSrc] = nil
        end
    end
    
    return true
end

local function AddMoney(source, amount, moneyType)
    if not source or not amount or amount <= 0 then return false end
    
    moneyType = moneyType or "cash"

    if moneyType == "cash" then
        return AddItem(source, "money", amount)
    end
    
    if currentFramework == "vorp" then
        local character = GetCharacter(source)
        if character then
            character.addCurrency(0, amount)
            return true
        end
    elseif currentFramework == "rsg" then
        local player = GetPlayer(source)
        if player then player.Functions.AddMoney(moneyType, amount) return true end
    end
    
    return false
end

local function RemoveItem(source, itemName, amount, containerType, containerId, slotId)
    amount = tonumber(string.format("%.2f", amount or 1)) -- Force 2 decimal precision

    local identifier = containerId
    local invType = containerType or "player"
    
    if not identifier then
        identifier = GetIdentifier(source)
    end

    if not identifier then 
        print("DEBUG: ERROR | No identifier found, returning false")
        return false 
    end
    
    local invData = LoadInventory(identifier, invType)
    if not invData then
        print("DEBUG: ERROR | LoadInventory returned nil")
        return false
    end

    local items = invData.items

    -- Logic for specific slot removal
    if slotId then
        for i, item in ipairs(items) do
            if item.slot == slotId then
                item.amount = tonumber(string.format("%.2f", item.amount or 0))
                if item.amount >= amount then
                    item.amount = tonumber(string.format("%.2f", item.amount - amount))
                    if item.amount <= 0 then
                        table.remove(items, i)
                    end
                    SaveInventory(identifier, invType, source)
                    
                    -- Sync framework money if this is a money item and it's the player's own inventory
                    if itemName == "money" and invType == "player" then
                        local targetSrc = GetSourceFromIdentifier(identifier)
                        if targetSrc and not vSyncing[targetSrc] then
                            vSyncing[targetSrc] = true
                            if currentFramework == "vorp" then
                                local character = GetCharacter(targetSrc)
                                if character then character.removeCurrency(0, amount) end
                            elseif currentFramework == "rsg" then
                                local player = GetPlayer(targetSrc)
                                if player then player.Functions.RemoveMoney('cash', amount) end
                            end
                            vSyncing[targetSrc] = nil
                        end
                    end
                    
                    return true
                end
                return false -- Slot found but not enough amount
            end
        end
        return false -- Slot not found
    end

    -- Logic for automatic removal (supports multi-stack)
    local totalAvailable = 0
    for _, item in ipairs(items) do
        if item.name == itemName then
            totalAvailable = totalAvailable + item.amount
        end
    end

    totalAvailable = tonumber(string.format("%.2f", totalAvailable))

    if totalAvailable < amount then
        return false
    end

    local remainingToRemove = amount
    -- Iterate backwards to safely remove items from table
    for i = #items, 1, -1 do
        local item = items[i]
        if item.name == itemName then
            if item.amount >= remainingToRemove then
                item.amount = item.amount - remainingToRemove
                remainingToRemove = 0
                if item.amount <= 0 then
                    table.remove(items, i)
                end
            else
                remainingToRemove = remainingToRemove - item.amount
                table.remove(items, i)
            end

            if remainingToRemove <= 0 then
                break
            end
        end
    end

    SaveInventory(identifier, invType, source)
    
    -- Sync framework money if this is a money item and it's the player's own inventory
    if itemName == "money" and invType == "player" then
        local targetSrc = GetSourceFromIdentifier(identifier)
        if targetSrc and not vSyncing[targetSrc] then
            vSyncing[targetSrc] = true
            if currentFramework == "vorp" then
                local character = GetCharacter(targetSrc)
                if character then character.removeCurrency(0, amount) end
            elseif currentFramework == "rsg" then
                local player = GetPlayer(targetSrc)
                if player then player.Functions.RemoveMoney('cash', amount) end
            end
            vSyncing[targetSrc] = nil
        end
    end
    
    return true
end

local function RemoveMoney(source, amount, moneyType)
    if not source or not amount or amount <= 0 then return false end
    
    moneyType = moneyType or "cash"

    if moneyType == "cash" then
        return RemoveItem(source, "money", amount)
    end
    
    if currentFramework == "vorp" then
        local character = GetCharacter(source)
        if character then
            character.removeCurrency(0, amount)
            return true
        end
    elseif currentFramework == "rsg" then
        local player = GetPlayer(source)
        if player then player.Functions.RemoveMoney(moneyType, amount) return true end
    end
    
    return false
end

local function GetItemCount(source, itemName)
    local identifier = GetIdentifier(source)
    if not identifier then return 0 end
    local inv = LoadInventory(identifier, "player")
    local count = 0
    if inv and inv.items then
        for _, v in ipairs(inv.items) do
            if v.name == itemName then
                count = count + (v.amount or 0)
            end
        end
    end
    return count
end

local function HasMoney(source, amount, moneyType)
    if not source or not amount then return false end
    
    local character = GetCharacter(source)
    if not character then return false end
    
    moneyType = moneyType or "cash"

    if moneyType == "cash" then
         return GetItemCount(source, "money") >= amount
    end
    
    if currentFramework == "vorp" then
        return (character.money or 0) >= amount
    elseif currentFramework == "rsg" then
        local player = GetPlayer(source)
        if player then
            local money = player.PlayerData.money[moneyType] or 0
            return money >= amount
        end
    end
    
    return false
end

local function GetNearbyDrops(source, maxDist)
    local plyPed = GetPlayerPed(source)
    local plyCoords = GetEntityCoords(plyPed)
    local drops = {}
    
    local usedSlots = {}
    
    for k, v in pairs(GroundItems) do
        local dist = #(plyCoords - v.coords)
        if dist <= (maxDist or 2.0) then
            for _, item in ipairs(v.items) do
                local displayItem = {}
                for key, val in pairs(item) do displayItem[key] = val end
                
                local targetSlot = tonumber(item.slot)
                
                if targetSlot and targetSlot > 0 and not usedSlots[targetSlot] then
                    displayItem.slot = targetSlot
                    usedSlots[targetSlot] = true
                else
                    local s = 1
                    while usedSlots[s] do s = s + 1 end
                    displayItem.slot = s
                    usedSlots[s] = true
                end
                
                displayItem.dropId = k
                displayItem.coords = v.coords
                
                table.insert(drops, displayItem)
            end
        end
    end
    return drops
end

local function NotifyDropsUpdate(coords)
    local players = nil
    if currentFramework == "vorp" then
        players = GetPlayers()
    elseif currentFramework == "rsg" then
        players = RSGCore.Functions.GetPlayers()
    else
        players = GetPlayers()
    end
    
    for _, src in ipairs(players) do
        local ped = GetPlayerPed(src)
        local pCoords = GetEntityCoords(ped)
        local dist = #(pCoords - coords)
        if dist < 20.0 then
             local drops = GetNearbyDrops(src, 20.0)
             TriggerClientEvent('v-inventory:client:UpdateDrops', src, drops)
        end
    end
end

local function CreateDrop(source, item, amount, metadata, slot)
    local coords = GetEntityCoords(GetPlayerPed(source))
    
    local id = os.time() .. math.random(100,999) 
    
    GroundItems[id] = {
        id = id,
        coords = coords,
        items = {
            {
                name = item.name,
                amount = amount,
                metadata = metadata,
                info = (currentFramework == "rsg" and metadata) or nil,
                label = item.label,
                image = item.image,
                type = item.type,
                weight = item.weight,
                type = item.type,
                weight = item.weight,
                slot = tonumber(slot) or 1,
                dropId = id
            }
        },
        timestamp = os.time()
    }
    
    SetTimeout(100, function() NotifyDropsUpdate(coords) end)
    return id
end



local function RemoveGroundItem(dropId, itemName, amount, slot)
    local drop = GroundItems[dropId]
    if not drop then return false end
    
    for i, item in ipairs(drop.items) do
        local match = false
        if slot then
            if item.slot == tonumber(slot) and item.name == itemName then match = true end
        else
            if item.name == itemName then match = true end
        end

        if match then
             if item.amount >= amount then
                local removedMetadata = item.metadata
                item.amount = item.amount - amount
                if item.amount <= 0 then
                    table.remove(drop.items, i)
                end
                
                if #drop.items == 0 then
                    GroundItems[dropId] = nil
                end
                
                SetTimeout(50, function() NotifyDropsUpdate(drop.coords) end)
                return true, removedMetadata
             end
        end
    end
    return false
end

local function AddGroundItem(source, item, amount, slot)
    local plyPed = GetPlayerPed(source)
    local plyCoords = GetEntityCoords(plyPed)
    
    local closestDropId = nil
    
    for k, v in pairs(GroundItems) do
        local dist = #(plyCoords - v.coords)
        if dist <= 5.0 then
             for _, existingItem in ipairs(v.items) do
                 if tonumber(existingItem.slot) == tonumber(slot) then
                     local meta1 = (not existingItem.metadata or (type(existingItem.metadata) == "table" and next(existingItem.metadata) == nil)) and "empty" or json.encode(existingItem.metadata)
                     local meta2 = (not item.metadata or (type(item.metadata) == "table" and next(item.metadata) == nil)) and "empty" or json.encode(item.metadata)
                     
                     if existingItem.name == item.name and meta1 == meta2 then
                         existingItem.amount = existingItem.amount + amount
                         SetTimeout(50, function() NotifyDropsUpdate(v.coords) end)
                         return k
                     else
                         return false
                     end
                 end
             end
        end
    end
    
    local newId = CreateDrop(source, item, amount, item.metadata, slot)
    return newId
end

local function GetItemDefinitions()
    return ItemDefinitions
end

local function GetJob(source)
    if currentFramework == "vorp" then
        local u = Core.getUser(source)
        local c = u and u.getUsedCharacter
        return c and c.job or "unemployed"
    elseif currentFramework == "rsg" then
        local p = RSGCore.Functions.GetPlayer(source)
        return p and p.PlayerData.job.name or "unemployed"
    end
    return "unemployed"
end

local function GetGrade(source)
    if currentFramework == "vorp" then
        local u = Core.getUser(source)
        local c = u and u.getUsedCharacter
        return c and c.jobGrade or 0
    elseif currentFramework == "rsg" then
        local p = RSGCore.Functions.GetPlayer(source)
        return p and p.PlayerData.job.grade.level or 0
    end
    return 0
end



local function FindWeaponItem(items, weaponId)
    if type(weaponId) == "number" then
        for _, v in ipairs(items) do
            if v.slot == weaponId then return v end
        end
    end
    if type(weaponId) == "string" then
        -- 1. Try Serial Match
        for _, v in ipairs(items) do
            if v.metadata and v.metadata.serial == weaponId then return v end
        end
        -- 2. Try Name Match
        for _, v in ipairs(items) do
            if v.name == weaponId then return v end
        end
    end
    return nil
end

local function ClearInventory(source, containerType, containerId)
    local identifier = containerId
    local invType = containerType or "player"
    if not identifier then
        identifier = GetIdentifier(source)
    end
    if not identifier then return false end
    
    local invId = GetInventoryId(identifier, invType)
    
    if not ServerInventories[invId] then
        LoadInventory(identifier, invType)
    end
    
    if ServerInventories[invId] then
        ServerInventories[invId].items = {}
        SaveInventory(identifier, invType, source)
        return true
    end
    
    return false
end



local function GetInventory(source, containerType, containerId)
    EnsureFrameworkReady()
    
    local identifier = containerId
    local invType = containerType or "player"
    if not identifier then identifier = GetIdentifier(source) end
    if not identifier then return {} end
    
    local data = LoadInventory(identifier, invType)
    
    if source then
        local invId = GetInventoryId(identifier, invType)
        ServerInventories[invId].viewers[source] = true
    end
    
    return data.items
end

local function RegisterViewer(source, containerType, containerId)
    local identifier = containerId
    local invType = containerType or "player"
    if not identifier then identifier = GetIdentifier(source) end
    if not identifier then return end
    
    local invId = GetInventoryId(identifier, invType)
    if not ServerInventories[invId] then LoadInventory(identifier, invType) end
    
    if ServerInventories[invId] then
        if not ServerInventories[invId].viewers then ServerInventories[invId].viewers = {} end
        ServerInventories[invId].viewers[source] = true
    end
end

local function UnregisterViewer(source, containerType, containerId)
     local identifier = containerId
    local invType = containerType or "player"
    if not identifier then identifier = GetIdentifier(source) end
    if not identifier then return end
    
    local invId = GetInventoryId(identifier, invType)
    if ServerInventories[invId] and ServerInventories[invId].viewers then
        ServerInventories[invId].viewers[source] = nil
    end
end

local function GetViewerCount(containerType, containerId)
    local identifier = containerId
    local invType = containerType or "player"
    if not identifier then return 0 end
    
    local invId = GetInventoryId(identifier, invType)
    if not ServerInventories[invId] or not ServerInventories[invId].viewers then
        return 0
    end
    
    local count = 0
    for _ in pairs(ServerInventories[invId].viewers) do
        count = count + 1
    end
    return count
end

local function SwapItem(source, fromSlot, toSlot, containerType, containerId)
    local identifier = containerId
    local invType = containerType or "player"
    if not identifier then identifier = GetIdentifier(source) end
    if not identifier then return false end
    
    local invData = LoadInventory(identifier, invType)
    if not invData then return false end
    local items = invData.items
    
    local fromItemIndex = nil
    local toItemIndex = nil
    
    for i, item in ipairs(items) do
        if item.slot == fromSlot then fromItemIndex = i end
        if item.slot == toSlot then toItemIndex = i end
    end
    
    if fromItemIndex then
        items[fromItemIndex].slot = toSlot
    else
        return false 
    end
    
    if toItemIndex then
        items[toItemIndex].slot = fromSlot
    end
    
    SaveInventory(identifier, invType, source)
    return true
end

local function GetMoney(source)
    return GetItemCount(source, "money")
end

local function GetGold(source)
    if currentFramework == "vorp" then
        local u = Core.getUser(source)
        local c = u and u.getUsedCharacter
        return c and c.gold or 0.0
    elseif currentFramework == "rsg" then
        local p = RSGCore.Functions.GetPlayer(source)
        return p and p.PlayerData.money['gold'] or 0.0
    end
    return 0.0
end

local function SetItemMetadata(source, slotId, metadata, containerType, containerId)
    local identifier = containerId
    local invType = containerType or "player"
    if not identifier then identifier = GetIdentifier(source) end
    if not identifier then return false end
    
    local invData = LoadInventory(identifier, invType)
    if not invData then return false end
    
    local items = invData.items
    local found = false
    for _, item in ipairs(items) do
        if item.slot == tonumber(slotId) then
            if not item.metadata then item.metadata = {} end
            if type(metadata) == "table" then
                for k, v in pairs(metadata) do
                    item.metadata[k] = v
                end
            end
            found = true
            break
        end
    end
    
    if found then
        SaveInventory(identifier, invType, source)
        return true
    end
    
    return false
end

local function CanCarryItem(source, itemName, amount)
    EnsureFrameworkReady()

    amount = tonumber(amount) or 1
    local identifier = GetIdentifier(source)
    if not identifier then return false end
    
    local invType = "player"
    
    local invData = LoadInventory(identifier, invType)
    local items = invData.items
    
    local itemDef = GetItemDef(itemName)
    if not itemDef then return false end
    local weight = itemDef.weight or 0.0
    local currentTotal = GetTotalWeight(items)
    local maxWeight = GetContainerLimit(invType, identifier)

    if (currentTotal + (weight * amount)) > maxWeight then
        return false
    end
    if itemDef.limit then
         local currentCount = 0
         for _, v in ipairs(items) do
             if v.name == itemName then currentCount = currentCount + v.amount end
         end
         if (currentCount + amount) > itemDef.limit then return false end
    end
    
    return true
end

local function UseItem(source, item)
    EnsureFrameworkReady()

    if not item or not item.name then return false end
    if currentFramework == "rsg" then
        if item.type == "item_money" then return false end
        local sendData = {}
        local itemDef = ItemDefinitions[item.name] or GetItemDef(item.name) or {}

        for k, v in pairs(itemDef) do
            sendData[k] = v
        end

        for k, v in pairs(item) do
            sendData[k] = v
        end

        sendData.name = item.name
        sendData.item = sendData.item or item.name
        sendData.itemName = sendData.itemName or item.name
        sendData.metadata = sendData.metadata or item.metadata or item.info or {}
        sendData.info = sendData.info or sendData.metadata
        sendData.limit = item.limit
        sendData.amount = 1
        sendData.count = 1
        return exports['rsg-inventory']:UseItem(source, sendData)
    elseif currentFramework == "vorp" then
        if UsableItems[item.name] then
            local arguments = {
                source = source,
                item = {
                    ---@deprecated -- same as item.id
                    mainid = ItemDefinitions[item.name].id,
                    item = item.name, -- for backwards compat
                    ---
                    metadata = item.metadata or {},
                    --percentage = item:getPercentage(),
                    isDegradable = ItemDefinitions[item.name].degradation ~= 0,
                    id = ItemDefinitions[item.name].id,
                    count = item.amount,
                    label = item.label,
                    name = item.name,
                    desc = ItemDefinitions[item.name].desc,
                    type = ItemDefinitions[item.name].type,
                    limit = ItemDefinitions[item.name].limit,
                    group = ItemDefinitions[item.name].groupId,
                    weight = ItemDefinitions[item.name].weight
                }
            }
            local success, result = pcall(UsableItems[item.name], arguments)
            if not success then
                print(string.format("^1[V-Inventory] Error executing usable item '%s': %s^7", item.name, result))
                return false
            end
            return true
        end
    end
end

local function CreateUsableItem(itemName, cb)
	if UsableItems[itemName] then
		print(string.format("^3[V-Inventory] Info: Item '%s' is being re-registered.^7", itemName))
	end
    UsableItems[itemName] = cb
end

local function GetUsableItemNames()
    local names = {}
    for name, _ in pairs(UsableItems) do
        table.insert(names, name)
    end
    return names
end

-- Ammunition usable items registration
local function GetAmmoItemDefinition(itemName)
    if not Config.AmmoItems then return nil end
    for group, ammos in pairs(Config.AmmoItems) do
        for ammoHashKey, data in pairs(ammos) do
             if data.item == itemName then
                 return data, ammoHashKey, group
             end
        end
    end
    return nil
end

-- Ammunition usable items registration
CreateThread(function()
    Wait(1000)
    if Config.AmmoItems then
        for groupHash, ammoList in pairs(Config.AmmoItems) do
            for ammoId, data in pairs(ammoList) do
                if data and data.item then
                    local itemName = string.lower(data.item)
                    CreateUsableItem(itemName, function(usageData)
                        local source = usageData.source
                        local item = usageData.item
                        
                        local state = Player(source).state
                        local equipped = state.equippedWeapon
                        
                        if not equipped or not equipped.slot and state.lastWeapon.group == "GROUP_BOW" then
                            equipped = state.lastWeapon
                        end

                        if not equipped or not equipped.slot then
                            VBridge.Notify(source, Config.Locales[Config.Language].needWeaponAmmo, 3000, 'error')
                            return
                        end
                        
                        local isAllowed = false
                        local weaponCfg = Config.Weapons and Config.Weapons[equipped.name]
                        
                        if weaponCfg and weaponCfg.AllowedAmmo then
                            if type(weaponCfg.AllowedAmmo) == "table" then
                                for _, allowed in ipairs(weaponCfg.AllowedAmmo) do
                                    if string.lower(allowed) == itemName then
                                        isAllowed = true
                                        break
                                    end
                                end
                            elseif string.lower(weaponCfg.AllowedAmmo) == itemName then
                                isAllowed = true
                            end
                        elseif equipped.group == groupHash then
                            isAllowed = true
                        end
                        
                        if not isAllowed then
                            VBridge.Notify(source, Config.Locales[Config.Language].wrongAmmo, 3000, 'error')
                            return
                        end
                        
                        local refillAmount = Config.AmmoDefaults.Amount or 30
                        if data.Amount then
                            refillAmount = data.Amount
                        end
                        
                        -- Use the specific ammo hash key from the loop (ammoId) as the type if needed, 
                        -- or let addBullets handle it if it takes generic types.
                        -- addBullets (Line 1534) takes (source, weaponId, type, amount). 
                        -- It calls SetItemMetadata.
                        -- NOTE: The original code passed `itemName` as `type`.
                        -- But `addBullets` implementation (Line 1534) IGNORES `type` argument!
                        -- It just adds to `metadata.ammo`.
                        -- BUT, the user wants DIFFERENT ammo types in metadata.
                        -- So I MUST update `addBullets` to support specific ammo types.
                        
                        local success = VBridge.addBullets(source, equipped.slot, ammoId, refillAmount)
                        if success then
                            VBridge.RemoveItem(source, itemName, 1, nil, nil, item.slot)
                            VBridge.Notify(source, Config.Locales[Config.Language].ammoRefilled, 3000, 'success')
                            
                            -- Update the client's ped ammo if they are holding the weapon
                            TriggerClientEvent('v-inventory:client:UpdatePedAmmo', source, {
                                slot = equipped.slot,
                                name = equipped.name,
                                ammo = exports[GetCurrentResourceName()]:getWeaponBullets(source, equipped.slot, ammoId), -- Pass ammoId to get correct count
                                ammoType = ammoId -- Send specific type update
                            })
                        else
                            VBridge.Notify(source, Config.Locales[Config.Language].ammoRefillError, 3000, 'error')
                        end
                    end)
                end
            end
        end
    end
end)


exports('AddItem', AddItem)
exports('RemoveItem', RemoveItem)
exports('ClearInventory', ClearInventory)
exports('GetInventory', GetInventory)
exports('SwapItem', SwapItem)
exports('RegisterViewer', RegisterViewer)
exports('UnregisterViewer', UnregisterViewer)
exports('GetViewerCount', GetViewerCount)
exports('GetIdentifier', GetIdentifier)
exports('GetItemCount', GetItemCount)
exports('CreateUsableItem', CreateUsableItem)
exports('RegisterUsableItem', CreateUsableItem)
exports('registerUsableItem', CreateUsableItem)
exports('GetAllItems', function() return ItemDefinitions end)
exports('ForceSave', function(source) 
    local identifier = GetIdentifier(source)
    if identifier then SaveInventory(identifier, "player") end
end)
exports('CreateDrop', CreateDrop)
exports('GetNearbyDrops', GetNearbyDrops)
exports('RemoveGroundItem', RemoveGroundItem)
exports('AddGroundItem', AddGroundItem)
exports('GetMoney', GetMoney)
exports('GetGold', GetGold)
exports('SetItemMetadata', SetItemMetadata)
exports('UseItem', UseItem)
exports('GetJob', GetJob)
exports('GetGrade', GetGrade)
exports('GetItemDefinitions', GetItemDefinitions)
exports('AddMoney', AddMoney)
exports('RemoveMoney', RemoveMoney)
exports('HasMoney', HasMoney)
exports('SyncMoney', SyncMoney)
exports('GetAmmoItemDefinition', GetAmmoItemDefinition)
exports('GetUsableItemNames', GetUsableItemNames)

exports('getItemCount', function(source, itemname) return GetItemCount(source, itemname)  end)
exports('getUserTotalCountItems', function(source) 
    local identifier = GetIdentifier(source)
    if not identifier then return 0 end
    local inv = LoadInventory(identifier, "player")
    local count = 0
    if inv and inv.items then
        for _, v in ipairs(inv.items) do
            count = count + (v.amount or 0)
        end
    end
    return count 
end)

exports('getUserInventoryItems', function(source) return GetInventory(source) end)
exports('getUserInventoryWeapons', function(source) 
    local items = GetInventory(source)
    local weapons = {}
    for _, v in ipairs(items) do
        if (v.name and string.find(string.upper(v.name), "WEAPON_")) or v.type == "item_weapon" then
            if v.metadata and v.metadata.serial then
                v.id = v.metadata.serial
            end
            table.insert(weapons, v)
        end
    end
    return weapons
end)

exports('addItem', function(source, item, amount, metadata) return AddItem(source, item, amount, metadata) end)
exports('createWeapon', function(source, item, metadata) return AddItem(source, item, 1, metadata) end)

exports('subItem', function(source, item, amount) return RemoveItem(source, item, amount) end) 
exports('removeItem', function(source, item, amount) return RemoveItem(source, item, amount) end)

local function SubItemByID(source, id, cb, allow, amount)
    amount = tonumber(amount) or 1
    if type(id) == "number" then
        local identifier = GetIdentifier(source)
        local inv = LoadInventory(identifier, "player")
        if inv and inv.items then
            local foundItem = nil
            for _, v in ipairs(inv.items) do
                if v.slot == id then
                    foundItem = v
                    break
                end
            end
            
            if foundItem then
                local itemName = foundItem.name
                local itemMetadata = foundItem.metadata
                local success = RemoveItem(source, itemName, amount, nil, nil, id)
                
                if success then
                    
                    if type(cb) == "function" then
                        cb(true)
                    end
                    return true
                end
            end
        end
    end
    
    if type(cb) == "function" then
        cb(false)
    end
    return false
end

exports('subItemID', SubItemByID)
exports('subItemById', SubItemByID)

exports('getInventory', function(source) return GetInventory(source) end)

exports('isInventoryFull', function(source)
    local identifier = GetIdentifier(source)
    if not identifier then return true end
    local inv = LoadInventory(identifier, "player")
    local max = GetContainerLimit("player", identifier)
    local current = GetTotalWeight(inv.items)
    return current >= max
end)

exports('canCarryWeapons', function(source, amount, empty, item) return CanCarryItem(source, item, amount) end)
exports('canCarryItem', function(source, item, amount) return CanCarryItem(source, item, amount) end)
exports('canCarryAmountItem', function(source, item, amount) return CanCarryItem(source, item, amount) end)
exports('exceedsItemLimit', function(source, item, amount) return not CanCarryItem(source, item, amount) end)
exports('exceedsInvLimit', function(source, item, amount) return not CanCarryItem(source, item, amount) end)

exports('registerWeapon', function(source, name, ammo, components)
    return AddItem(source, name, 1, { comps = components, ammo = ammo })
end)

exports('subWeapon', function(source, name)
    local items = GetInventory(source)
    local targetItem = FindWeaponItem(items, name)

    if targetItem then
          return RemoveItem(source, nil, 1, nil, nil, targetItem.slot)
    end
    return RemoveItem(source, name, 1) -- Fallback for pure name removal if FindWeaponItem fails or for non-weapon items (?)
end)

exports('deleteWeapon', function(source, id)
    local items = GetInventory(source)
    local targetItem = FindWeaponItem(items, id)
    
    if targetItem then
        return RemoveItem(source, nil, 1, nil, nil, targetItem.slot)
    end
    return false
end)

exports('getUserWeapon', function(source, name)
    local identifier = GetIdentifier(source)
    local inv = LoadInventory(identifier, "player")
    if inv and inv.items then
        return FindWeaponItem(inv.items, name)
    end
    return nil
end)

exports('getUserWeapons', function(source)
    local identifier = GetIdentifier(source)
    local inv = LoadInventory(identifier, "player")
    local weapons = {}
    if inv and inv.items then
        for _, v in ipairs(inv.items) do
            if (v.name and string.find(string.upper(v.name), "WEAPON_")) or v.type == "item_weapon" then
                table.insert(weapons, v)
            end
        end
    end
    return weapons
end)

exports('addBullets', function(source, weaponId, ammoType, amount)
    local identifier = GetIdentifier(source)
    local inv = LoadInventory(identifier, "player")
    local items = inv.items or {}
    
    local targetItem = FindWeaponItem(items, weaponId)

    if targetItem then
        local metadata = targetItem.metadata or {}
        local key = ammoType or "ammo"
        
        local currentAmmo = tonumber(metadata[key]) or 0
        
        local maxAmmo = Config.WeaponDefaults.MaxAmmo or 120
        if Config.Weapons and Config.Weapons[targetItem.name] and Config.Weapons[targetItem.name].MaxAmmo then
             maxAmmo = Config.Weapons[targetItem.name].MaxAmmo
        end
        
        if currentAmmo >= maxAmmo then
             return false
        end
        
        -- Note: 'data' variable was undefined in original code at line 1555 (copied context?), removing invalid check.
        -- Assuming strict check meant not overflowing max.
        if (currentAmmo + amount) > maxAmmo then
            -- Optional: cap at max instead of returning false?
            -- Original code returned false if strict?
            -- Let's just cap it as per original logic below strict check.
        end

        local newAmmo = currentAmmo + amount
        if newAmmo > maxAmmo then newAmmo = maxAmmo end
        
        metadata[key] = newAmmo
        return SetItemMetadata(source, targetItem.slot, metadata)
    end
    
    return false 
end)

exports('subBullets', function(source, weaponId, ammoType, amount) 
    local identifier = GetIdentifier(source)
    local inv = LoadInventory(identifier, "player")
    local items = inv.items or {}
    
    local targetItem = FindWeaponItem(items, weaponId)
    
    if targetItem then
        local metadata = targetItem.metadata or {}
        local key = ammoType or "ammo"
        local currentAmmo = tonumber(metadata[key]) or 0
        
        if currentAmmo >= amount then
            metadata[key] = currentAmmo - amount
            SetItemMetadata(source, targetItem.slot, metadata)
            return true
        end
    end
    
    return false 
end)

exports('getWeaponBullets', function(source, weaponId, ammoType) 
    local identifier = GetIdentifier(source)
    local inv = LoadInventory(identifier, "player")
    local items = inv.items or {}
    local targetItem = FindWeaponItem(items, weaponId)
    if targetItem then
        local key = ammoType or "ammo"
        return (targetItem.metadata and tonumber(targetItem.metadata[key])) or 0
    end
    return 0
end)

exports('getUserAmmo', function(source) 
    return {}
end)

exports('getItemMatchingMetadata', function(source, name, metadata)
    local identifier = GetIdentifier(source)
    local inv = LoadInventory(identifier, "player")
    if inv and inv.items then
        for _, v in ipairs(inv.items) do
            if v.name == name then
               local match = true
               if metadata then
                   for key, val in pairs(metadata) do
                       if not v.metadata or v.metadata[key] ~= val then
                           match = false
                           break
                       end
                   end
               end
               if match then return v end
            end
        end
    end
    return nil
end)


exports('GetPlayer', function(source) 
    if currentFramework == "vorp" then
        return Core.getUser(source)
    elseif currentFramework == "rsg" then
        return RSGCore.Functions.GetPlayer(source)
    end
    return nil
end)

exports('GetCharacter', function(source) 
    if currentFramework == "vorp" then 
        local u = Core.getUser(source) 
        return u and u.getUsedCharacter
    elseif currentFramework == "rsg" then
        return GetCharacter(source)
    end 
end)

exports('GetFramework', function()
    EnsureFrameworkReady()
    return currentFramework
end)

RegisterCommand('migratevorpinventory', function(source, args)
    if source ~= 0 then 
        return
    end

    print("^3[v-inventory] Starting VORP Inventory Migration...^7")
    
    MySQL.query('SELECT * FROM character_inventories', {}, function(invResults)
        if not invResults then 
            print("^1[v-inventory] Failed to fetch character_inventories or empty.^7")
            return 
        end
        
        MySQL.query('SELECT * FROM items_crafted', {}, function(craftedResults)
            local craftedMap = {}
            if craftedResults then
                for _, craft in ipairs(craftedResults) do
                    craftedMap[craft.id] = craft.metadata
                end
            end

            MySQL.query('SELECT * FROM loadout', {}, function(loadoutResults)
                local grouped = {}
                local weaponGrouped = {}

                for _, row in ipairs(invResults) do
                    local charId = row.character_id
                    if not grouped[charId] then grouped[charId] = {} end
                    table.insert(grouped[charId], row)
                end

                if loadoutResults then
                    for _, row in ipairs(loadoutResults) do
                         local charId = row.charidentifier or row.identifier -- Verify column name
                         if row.charidentifier then
                             charId = row.charidentifier
                         elseif row.identifier and tonumber(row.identifier) then
                             charId = tonumber(row.identifier)
                         end
                         
                         if charId then
                             if not weaponGrouped[charId] then weaponGrouped[charId] = {} end
                             table.insert(weaponGrouped[charId], row)
                         end
                    end
                end
                
                local count = 0
                local allCharIds = {}
                for k, _ in pairs(grouped) do allCharIds[k] = true end
                for k, _ in pairs(weaponGrouped) do allCharIds[k] = true end

                for charId, _ in pairs(allCharIds) do
                    local items = grouped[charId] or {}
                    local weapons = weaponGrouped[charId] or {}
                    
                    local identifier = tostring(charId) 
                    local invData = LoadInventory(identifier, "player")
                    local currentItems = invData and invData.items or {}
                    
                    local usedSlots = {}
                    for _, v in ipairs(currentItems) do
                         if v.slot then usedSlots[v.slot] = true end
                    end
                    
                    for _, item in ipairs(items) do
                         local meta = {}
                         if item.item_crafted_id and craftedMap[item.item_crafted_id] then
                             local success, decoded = pcall(json.decode, craftedMap[item.item_crafted_id])
                             if success then meta = decoded end
                         end
                         
                         local slot = 1
                         while usedSlots[slot] do slot = slot + 1 end
                         usedSlots[slot] = true
                         
                         local def = GetItemDef(item.item_name)
                         
                         table.insert(currentItems, {
                             name = item.item_name,
                             amount = item.amount,
                             label = def and def.label or item.item_name,
                             weight = def and def.weight or 0,
                             type = def and def.type or "item",
                             metadata = meta,
                             slot = slot
                         })
                    end

                    for _, wep in ipairs(weapons) do
                        local meta = {}
                        local ammoData = wep.ammo 
                        local components = wep.components
                        
                        if ammoData then
                             local success, result = pcall(json.decode, ammoData)
                             if success and type(result) == 'table' then
                                 for _, amount in pairs(result) do
                                     meta.ammo = amount 
                                     break
                                 end
                             end
                        end

                        if components then
                            local success, result = pcall(json.decode, components)
                            if success then meta.components = result end
                        end
                        
                        if wep.id then meta.serial = wep.id end

                        local slot = 1
                        while usedSlots[slot] do slot = slot + 1 end
                        usedSlots[slot] = true

                        local def = GetItemDef(wep.name)
                        table.insert(currentItems, {
                             name = wep.name,
                             amount = 1,
                             label = def and def.label or wep.name,
                             weight = def and def.weight or 0,
                             type = "item_weapon",
                             metadata = meta,
                             slot = slot
                        })
                    end
                    
                    SaveInventory(identifier, "player", nil)
                    count = count + 1
                    if count % 100 == 0 then
                        print(string.format("^3[v-inventory] Migrated %d characters...^7", count))
                    end
                end
                print(string.format("^2[v-inventory] Migration Finished. Total characters processed: %d^7", count))
            end)
        end)
    end)
end, true)

RegisterCommand("migratersginventory", function(source, args)
    if source ~= 0 then return end
    print("^3[v-inventory] Starting RSG migration...^7")

    local function processMigration(identifier, rsgItems)
        if not identifier or not rsgItems then return end
        
        -- Load existing v-inventory data to merge
        local invData = LoadInventory(identifier, "player")
        local currentItems = invData and invData.items or {}
        
        local usedSlots = {}
        for _, v in ipairs(currentItems) do
            if v.slot then usedSlots[v.slot] = true end
        end
        
        local itemsAdded = 0
        for _, rsgItem in pairs(rsgItems) do
            local item = rsgItem
            -- Handle potential format variations
            if not item.name and rsgItem.name then item = rsgItem end
            
            local itemName = item.name
            if itemName then
                local amount = item.amount or 1
                local metadata = item.info or item.metadata or {}
                local slot = tonumber(item.slot)
                
                -- If slot is occupied or invalid, find new slot
                if not slot or usedSlots[slot] then
                    slot = 1
                    while usedSlots[slot] do slot = slot + 1 end
                end
                usedSlots[slot] = true
                
                local def = GetItemDef(itemName)
                table.insert(currentItems, {
                    name = itemName,
                    amount = amount,
                    label = def and def.label or itemName,
                    weight = def and def.weight or 0,
                    type = def and def.type or "item",
                    metadata = metadata,
                    slot = slot
                })
                itemsAdded = itemsAdded + 1
            end
        end
        
        if itemsAdded > 0 then
            invData.items = currentItems
            SaveInventory(identifier, "player", nil)
        end
    end

    -- Step 1: Process 'players' table
    MySQL.query('SELECT citizenid, inventory FROM players', {}, function(pResults)
        local pCount = 0
        if pResults then
            for _, row in ipairs(pResults) do
                local identifier = row.citizenid
                local itemsJson = row.inventory
                if identifier and itemsJson then
                    local success, items = pcall(json.decode, itemsJson)
                    if success and items then
                        processMigration(identifier, items)
                        pCount = pCount + 1
                    end
                end
            end
            print(string.format("^3[v-inventory] Migrated %d inventories from 'players' table.^7", pCount))
        end

        -- Step 2: Process 'inventories' table
        MySQL.query('SELECT * FROM inventories', {}, function(invResults)
            local iCount = 0
            if invResults then
                for _, row in ipairs(invResults) do
                    local identifier = row.identifier
                    local itemsJson = row.items
                    if identifier and itemsJson then
                        local success, items = pcall(json.decode, itemsJson)
                        if success and items then
                            processMigration(identifier, items)
                            iCount = iCount + 1
                        end
                    end
                end
                print(string.format("^3[v-inventory] Migrated %d inventories from 'inventories' table.^7", iCount))
            end
            print(string.format("^2[v-inventory] RSG Migration Finished. Total inventories processed: %d^7", pCount + iCount))
        end)
    end)
end, true)

exports('Notify', function(source, msg, dur, type)
    if currentFramework == "vorp" then
        TriggerClientEvent("vorp:TipBottom", source, msg, dur)
    elseif currentFramework == "rsg" then
        TriggerClientEvent('ox_lib:notify', source, {
            title = msg,
            type = type or 'inform',
            duration = dur or 5000
        })
    end
end)

VBridge = {
    AddItem = AddItem,
    RemoveItem = RemoveItem,
    SwapItem = SwapItem,
    GetInventory = GetInventory,
    RegisterViewer = RegisterViewer,
    UnregisterViewer = UnregisterViewer,
    GetIdentifier = GetIdentifier,
    ForceSave = function(s) 
        local id = GetIdentifier(s)
        if id then SaveInventory(id, "player") end
    end,
    CreateDrop = CreateDrop,
    GetNearbyDrops = GetNearbyDrops,
    RemoveGroundItem = RemoveGroundItem,
    AddGroundItem = AddGroundItem,
    GetItemCount = GetItemCount,
    GetMoney = GetMoney,
    GetGold = GetGold,
    AddMoney = AddMoney,
    RemoveMoney = RemoveMoney,
    HasMoney = HasMoney,
    SyncMoney = SyncMoney,
    GetJob = GetJob,
    GetGrade = GetGrade,
    GetItemDefinitions = ItemDefinitions,
    GetFramework = function()
        EnsureFrameworkReady()
        return currentFramework
    end,
    Notify = function(s,m,d,t) exports[GetCurrentResourceName()]:Notify(s,m,d,t) end,
    addBullets = function(s,w,t,a) return exports[GetCurrentResourceName()]:addBullets(s,w,t,a) end,
    isCustomInventoryRegistered = function(id) return exports[GetCurrentResourceName()]:isCustomInventoryRegistered(id) end,
    getCustomInventoryData = function(id) return exports[GetCurrentResourceName()]:getCustomInventoryData(id) end,
    updateCustomInvData = function(data) return exports[GetCurrentResourceName()]:updateCustomInvData(data) end,
    openPlayerInventory = function(data) return exports[GetCurrentResourceName()]:openPlayerInventory(data) end,
    addItemsToCustomInventory = function(id, items, charId) return exports[GetCurrentResourceName()]:addItemsToCustomInventory(id, items, charId) end,
    addWeaponsToCustomInventory = function(id, weps, charId) return exports[GetCurrentResourceName()]:addWeaponsToCustomInventory(id, weps, charId) end,
    getCustomInventoryItemCount = function(id, itemName, craftedId) return exports[GetCurrentResourceName()]:getCustomInventoryItemCount(id, itemName, craftedId) end,
    getCustomInventoryWeaponCount = function(id, weaponName) return exports[GetCurrentResourceName()]:getCustomInventoryWeaponCount(id, weaponName) end,
    removeItemFromCustomInventory = function(id, itemName, amount, craftedId) return exports[GetCurrentResourceName()]:removeItemFromCustomInventory(id, itemName, amount, craftedId) end,
    getCustomInventoryItems = function(id) return exports[GetCurrentResourceName()]:getCustomInventoryItems(id) end,
    getCustomInventoryWeapons = function(id) return exports[GetCurrentResourceName()]:getCustomInventoryWeapons(id) end,
    updateCustomInventoryItem = function(id, slot, metadata, amount) return exports[GetCurrentResourceName()]:updateCustomInventoryItem(id, slot, metadata, amount) end,
    removeCustomInventoryWeaponById = function(id, weaponId) return exports[GetCurrentResourceName()]:removeCustomInventoryWeaponById(id, weaponId) end,
    removeWeaponFromCustomInventory = function(id, weaponName) return exports[GetCurrentResourceName()]:removeWeaponFromCustomInventory(id, weaponName) end,
    deleteCustomInventory = function(id) return exports[GetCurrentResourceName()]:deleteCustomInventory(id) end,
    GetInventoryId = GetInventoryId,
    ForceSaveStash = function(id) SaveInventory(id, "stash") end,
    DeleteCustomInventory = function(invId)
        local id = GetInventoryId(invId, "stash")
        if ServerInventories[id] then ServerInventories[id] = nil end
        MySQL.query('DELETE FROM v_inventory WHERE identifier = ? AND type = ?', {invId, "stash"})
        return true
    end,
    SetItemMetadata = SetItemMetadata,
}

exports('isCustomInventoryRegistered', function(id, cb)
    local invId = GetInventoryId(id, "stash")
    local registered = false
    if ServerInventories[invId] then
        registered = true
    else
        local p = promise.new()
        MySQL.query('SELECT 1 FROM v_inventory WHERE identifier = ? AND type = ?', {id, "stash"}, function(result)
            p:resolve(result and result[1] ~= nil)
        end)
        registered = Citizen.Await(p)
    end
    if type(cb) == "function" then cb(registered) end
    return registered
end)

exports('getCustomInventoryData', function(id, cb)
    local data = LoadInventory(id, "stash")
    if type(cb) == "function" then cb(data) end
    return data
end)

exports('updateCustomInvData', function(data, cb)
    local success = false
    if data and data.id then
        local invId = GetInventoryId(data.id, "stash")
        if ServerInventories[invId] then
             SaveInventory(data.id, "stash")
             success = true
        end
    end
    if type(cb) == "function" then cb(success) end
    return success
end)

exports('openPlayerInventory', function(data)
    if data and data.targetId then
        local targetIdentifier = GetIdentifier(data.targetId)
        if targetIdentifier then
            TriggerClientEvent('v-inventory:client:OpenInventory', data.targetId, { 
                type = "player", 
                id = targetIdentifier, 
                label = Locales.playerLabel .. " ("..data.targetId..")",
                slots = 80
            })
        end
    end
end)

exports('addItemsToCustomInventory', function(invId, items, charId, cb)
    local success = true
    for _, item in ipairs(items) do
        local added = AddItem(nil, item.name, item.amount, item.metadata, "stash", invId)
        if not added then success = false end
    end
    if type(cb) == "function" then cb(added) end
    return success
end)

exports('addWeaponsToCustomInventory', function(invId, weapons, charId, cb)
    local success = true
    for _, wep in ipairs(weapons) do
        local metadata = {
            serial = wep.custom_serial or string.upper(tostring(os.time()) .. math.random(100,999)),
            label = wep.custom_label,
            description = wep.custom_desc
        }
        if currentFramework == "rsg" then
            metadata.serie = metadata.serial
        end
        local added = AddItem(nil, wep.name, 1, metadata, "stash", invId)
        if not added then success = false end
    end
    if type(cb) == "function" then cb(success) end
    return success
end)

exports('getCustomInventoryItemCount', function(invId, itemName, itemCraftedId, cb)
    local inv = LoadInventory(invId, "stash")
    local count = 0
    if inv and inv.items then
        for _, v in ipairs(inv.items) do
            if v.name == itemName then
                if itemCraftedId then
                    if v.metadata and (v.metadata.craftedId == itemCraftedId or v.metadata.id == itemCraftedId) then
                        count = count + (v.amount or 0)
                    end
                else
                    count = count + (v.amount or 0)
                end
            end
        end
    end
    if type(cb) == "function" then cb(count) end
    return count
end)

exports('getCustomInventoryWeaponCount', function(invId, weaponName, cb)
    local inv = LoadInventory(invId, "stash")
    local count = 0
    if inv and inv.items then
        for _, v in ipairs(inv.items) do
            if v.name == weaponName then
                count = count + 1
            end
        end
    end
    if type(cb) == "function" then cb(count) end
    return count
end)

exports('removeItemFromCustomInventory', function(invId, itemName, amount, itemCraftedId, cb)
    local success = false
    if itemCraftedId then
        local inv = LoadInventory(invId, "stash")
        if inv and inv.items then
            for _, v in ipairs(inv.items) do
                if v.name == itemName and v.metadata and (v.metadata.craftedId == itemCraftedId or v.metadata.id == itemCraftedId) then
                    success = RemoveItem(nil, itemName, amount, "stash", invId, v.slot)
                    break
                end
            end
        end
    else
        success = RemoveItem(nil, itemName, amount, "stash", invId)
    end
    if type(cb) == "function" then cb(success and 1 or 0) end
    return success
end)

exports('getCustomInventoryItems', function(invId, cb)
    local inv = LoadInventory(invId, "stash")
    local items = inv and inv.items or {}
    if type(cb) == "function" then cb(items) end
    return items
end)

exports('getCustomInventoryWeapons', function(invId, cb)
    local inv = LoadInventory(invId, "stash")
    local weapons = {}
    if inv and inv.items then
        for _, v in ipairs(inv.items) do
            if (v.name and string.find(string.upper(v.name), "WEAPON_")) or v.type == "item_weapon" then
                table.insert(weapons, v)
            end
        end
    end
    if type(cb) == "function" then cb(weapons) end
    return weapons
end)

exports('updateCustomInventoryItem', function(invId, item_id, metadata, amount, cb)
    local success = SetItemMetadata(nil, item_id, metadata, "stash", invId)
    if success and amount then
        local inv = LoadInventory(invId, "stash")
        for _, v in ipairs(inv.items) do
             if v.slot == item_id then
                 v.amount = amount
                 SaveInventory(invId, "stash")
                 break
             end
        end
    end
    if type(cb) == "function" then cb(success) end
    return success
end)

exports('removeCustomInventoryWeaponById', function(invId, weapon_id, cb)
    local inv = LoadInventory(invId, "stash")
    local success = false
    if inv and inv.items then
        for _, v in ipairs(inv.items) do
            if v.metadata and (v.metadata.serial == weapon_id or v.metadata.id == weapon_id) then
                success = RemoveItem(nil, v.name, 1, "stash", invId, v.slot)
                break
            end
        end
    end
    if type(cb) == "function" then cb(success) end
    return success
end)

exports('removeWeaponFromCustomInventory', function(invId, weaponName, cb)
    local inv = LoadInventory(invId, "stash")
    local success = false
    if inv and inv.items then
        for _, v in ipairs(inv.items) do
            if v.name == weaponName then
                success = RemoveItem(nil, v.name, 1, "stash", invId, v.slot)
                break
            end
        end
    end
    if type(cb) == "function" then cb(success and 1 or 0) end
    return success
end)

exports('deleteCustomInventory', function(invId, cb)
    local id = GetInventoryId(invId, "stash")
    if ServerInventories[id] then
        ServerInventories[id] = nil
    end
    MySQL.query('DELETE FROM v_inventory WHERE identifier = ? AND type = ?', {invId, "stash"})
    if type(cb) == "function" then cb(true) end
    return true
end)

exports('GetConfig', function() return Config end)

exports('SetConfigShops', function(shops) Config.Shops = shops end)

exports('VBridge', function() return VBridge end)
