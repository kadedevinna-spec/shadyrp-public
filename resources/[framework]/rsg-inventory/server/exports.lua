local RSGCore = nil
local Inventory = {}
local Shops = {}
local RegisteredShops = {}
local RegisteredUsables = {}
local RegisteredInventories = RegisteredInventories or {}

local VBridge = exports["v-inventory"]:VBridge()

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

local function cloneDefinition(def)
    local out = {}
    for key, value in pairs(def or {}) do
        out[key] = value
    end
    return out
end

local function upsertRsgCoreItem(name, label, limit, usable, weight)
    if not RSGCore or not RSGCore.Shared or type(RSGCore.Shared.Items) ~= "table" then return end
    if not name or name == "forge" or name == "forge_advanced" or RSGCore.Shared.Items[name] then return end

    local numericWeight = tonumber(weight) or 0.0
    RSGCore.Shared.Items[name] = {
        name = name,
        label = label or name,
        weight = numericWeight <= 20.0 and math.floor((numericWeight * 1000.0) + 0.5) or math.floor(numericWeight),
        type = "item",
        image = name .. ".png",
        unique = tonumber(limit) == 1,
        useable = tostring(usable) == "1" or usable == true,
        shouldClose = true,
        description = "Mosquito mining/blacksmithing item",
    }
end

local function SeedMosquitoBlacksmithItems()
    if not VBridge then return false end

    local definitions = VBridge.GetItemDefinitions
    if type(definitions) == "function" then
        local ok, result = pcall(definitions)
        definitions = ok and result or nil
    end

    if type(definitions) ~= "table" then
        local ok, result = pcall(function()
            return exports["v-inventory"]:GetAllItems()
        end)
        definitions = ok and result or nil
    end

    if type(definitions) ~= "table" then return false end

    local contents = LoadResourceFile("mosquito-mining-blacksmithing", "items.sql") or ""
    for itemName, label, limit, canRemove, _itemType, usable, weight in contents:gmatch("%('([^']+)',%s*'([^']*)',%s*([%d%.]+),%s*([01]),%s*'([^']+)',%s*([01]),%s*([%d%.]+)%)") do
        if itemName ~= "forge" and itemName ~= "forge_advanced" then
            definitions[itemName] = definitions[itemName] or {
                name = itemName,
                label = label,
                weight = tonumber(weight) or 0.0,
                type = "item",
                image = itemName,
                can_remove = tostring(canRemove) == "1",
                limit = tonumber(limit) or 100,
                usable = tostring(usable) == "1",
                useable = tostring(usable) == "1",
            }
            upsertRsgCoreItem(itemName, label, limit, usable, weight)
        end
    end

    for name, def in pairs(MosquitoBlacksmithItems) do
        definitions[name] = definitions[name] or cloneDefinition(def)
    end

    return true
end

if GetResourceState('rsg-core') == 'started' then
    RSGCore = exports['rsg-core']:GetCoreObject()
end

CreateThread(function()
    while not VBridge do
        Wait(100)
        VBridge = exports["v-inventory"]:VBridge()
    end

    if not RSGCore and GetResourceState('rsg-core') == 'started' then
        RSGCore = exports['rsg-core']:GetCoreObject()
    end

    SeedMosquitoBlacksmithItems()
    print("^2[rsg-inventory bridge] Loaded and ready^0")
end)

RegisterCommand("bsseeditems", function(source)
    local seeded = SeedMosquitoBlacksmithItems()
    print(("[rsg-inventory bridge] Mosquito blacksmith item seed %s"):format(seeded and "ok" or "failed"))

    if source and source > 0 then
        TriggerClientEvent('ox_lib:notify', source, {
            title = seeded and "Blacksmith item seed ok" or "Blacksmith item seed failed",
            type = seeded and "success" or "error",
            duration = 5000
        })
    end
end, false)

local function NormalizeInventoryItems(items)
    local normalized = {}
    local byName = {}
    local seen = {}

    for slot, item in pairs(items or {}) do
        if type(item) == "table" then
            local name = item.name or item.item or item.itemName
            local amount = tonumber(item.amount or item.count or item.quantity or item.qty or 0) or 0
            local realSlot = tonumber(item.slot or slot) or slot

            if name and amount > 0 then
                local key = tostring(realSlot) .. ":" .. tostring(name)

                if not seen[key] then
                    seen[key] = true

                    local fixed = {
                        name = name,
                        item = name,
                        itemName = name,
                        label = item.label or name,
                        amount = amount,
                        count = amount,
                        quantity = amount,
                        qty = amount,
                        slot = realSlot,
                        type = item.type or "item",
                        image = item.image or (name .. ".png"),
                        info = item.info or item.metadata or {},
                        metadata = item.metadata or item.info or {},
                        weight = item.weight or 0,
                        unique = item.unique or false,
                        useable = item.useable or item.usable or false,
                        shouldClose = item.shouldClose ~= false,
                        can_remove = item.can_remove
                    }

                    table.insert(normalized, fixed)
                    byName[name] = fixed
                end
            end
        end
    end

    for name, item in pairs(byName) do
        normalized[name] = item
    end

    local itemsArray = {}
    for i, item in ipairs(normalized) do
        itemsArray[i] = item
    end

    normalized.items = itemsArray

    return normalized
end

local function GetStashInventory(identifier)
    if not identifier then return {} end

    local items = VBridge.GetInventory(nil, "stash", identifier)
    if items and next(items) then return NormalizeInventoryItems(items) end

    items = VBridge.GetInventory(nil, "custom", identifier)
    if items and next(items) then return NormalizeInventoryItems(items) end

    items = VBridge.GetInventory(nil, "storage", identifier)
    if items and next(items) then return NormalizeInventoryItems(items) end

    return {}
end

local function FindItemInInventory(items, itemName)
    itemName = tostring(itemName or ''):lower()

    for _, item in pairs(items or {}) do
        if type(item) == 'table' then
            local name = tostring(item.name or item.item or item.itemName or ''):lower()
            local amount = tonumber(item.amount or item.count or item.quantity or item.qty or 0) or 0

            if name == itemName and amount > 0 then
                return item
            end
        end
    end

    return nil
end

Inventory.GetInventory = function(identifier)
    local src = tonumber(identifier)

    if src then
        local items = VBridge.GetInventory(src, "player", nil) or {}
        return NormalizeInventoryItems(items)
    end

    if identifier then
        return GetStashInventory(identifier)
    end

    return {}
end

Inventory.GetStashItems = function(identifier)
    return GetStashInventory(identifier)
end

Inventory.GetItemByName = function(identifier, itemName)
    if not identifier or not itemName then
        print("^1[rsg-inventory bridge] GetItemByName failed: missing identifier or itemName^0", identifier, itemName)
        return nil
    end

    local src = tonumber(identifier)
    local items = {}

    if src then
        local ok, result = pcall(function()
            return VBridge.GetInventory(src, "player", nil)
        end)

        if not ok then
            print("^1[rsg-inventory bridge] GetItemByName VBridge.GetInventory error:^0", result)
            return nil
        end

        items = result or {}
    else
        local ok, result = pcall(function()
            return GetStashInventory(identifier)
        end)

        if not ok then
            print("^1[rsg-inventory bridge] GetItemByName GetStashInventory error:^0", result)
            return nil
        end

        items = result or {}
    end

    local normalized = {}

    local okNormalize, normResult = pcall(function()
        return NormalizeInventoryItems(items)
    end)

    if okNormalize and normResult then
        normalized = normResult
    else
        print("^1[rsg-inventory bridge] GetItemByName NormalizeInventoryItems error:^0", normResult)
        normalized = items or {}
    end

    local okFind, foundItem = pcall(function()
        return FindItemInInventory(normalized, itemName)
    end)

    if not okFind then
        print("^1[rsg-inventory bridge] GetItemByName FindItemInInventory error:^0", foundItem)
        return nil
    end

    if foundItem then
        foundItem.name = foundItem.name or foundItem.item or foundItem.itemName or itemName
        foundItem.item = foundItem.item or foundItem.name
        foundItem.itemName = foundItem.itemName or foundItem.name
        foundItem.amount = foundItem.amount or foundItem.count or foundItem.quantity or foundItem.qty or 1
        foundItem.count = foundItem.count or foundItem.amount
        foundItem.quantity = foundItem.quantity or foundItem.amount
        foundItem.qty = foundItem.qty or foundItem.amount
        foundItem.info = foundItem.info or foundItem.metadata or {}
        foundItem.metadata = foundItem.metadata or foundItem.info or {}
    end

    return foundItem
end

Inventory.GetItemsByName = function(source, itemName)
    local items = Inventory.GetInventory(source)
    local found = {}

    for _, item in pairs(items or {}) do
        if type(item) == "table" and item.name == itemName then
            table.insert(found, item)
        end
    end

    return found
end

Inventory.HasItem = function(identifier, itemName, amount)
    amount = tonumber(amount) or 1

    local item = Inventory.GetItemByName(identifier, itemName)
    if not item then return false end

    local itemAmount = tonumber(item.amount or item.count or item.quantity or item.qty) or 0
    return itemAmount >= amount
end

Inventory.GetItemCount = function(source, itemName)
    if type(itemName) == "table" then
        local count = 0
        for _, name in ipairs(itemName) do
            count = count + (tonumber(Inventory.GetItemCount(source, name)) or 0)
        end
        return count
    end

    local count = tonumber(VBridge.GetItemCount(source, itemName)) or 0
    if count > 0 then return count end

    local function sumItems(items)
        local total = 0

        for _, item in pairs(items or {}) do
            if type(item) == "table" then
                local name = item.name or item.item or item.itemName
                if name == itemName then
                    total = total + (tonumber(item.amount or item.count or item.quantity or item.qty) or 0)
                end
            end
        end

        return total
    end

    local ok, items = pcall(function()
        return VBridge.GetInventory(source, "player", nil)
    end)

    if ok then
        count = sumItems(items)
        if count > 0 then return count end
    end

    local player = RSGCore and RSGCore.Functions and RSGCore.Functions.GetPlayer(source)
    if player and player.PlayerData and type(player.PlayerData.items) == "table" then
        count = sumItems(player.PlayerData.items)
    end

    return count
end

Inventory.GetItemBySlot = function(source, slot)
    local items = VBridge.GetInventory(source, "player", nil) or {}

    for _, item in pairs(items) do
        if type(item) == "table" and tonumber(item.slot) == tonumber(slot) then
            return item
        end
    end

    return nil
end

Inventory.GetSlotsByItem = function(items, itemName)
    local slots = {}
    if not items then return slots end

    for _, item in pairs(items) do
        if type(item) == "table" and item.name == itemName then
            table.insert(slots, item.slot)
        end
    end

    return slots
end

Inventory.GetFirstSlotByItem = function(items, itemName)
    if not items then return nil end

    for _, item in pairs(items) do
        if type(item) == "table" and item.name == itemName then
            return item.slot
        end
    end

    return nil
end

Inventory.AddItem = function(identifier, item, amount, slot, info, reason)
    print("^3[rsg-inventory bridge] AddItem called:^0", identifier, item, amount, slot, json.encode(info or {}))

    SeedMosquitoBlacksmithItems()
    amount = tonumber(amount) or 1
    local src = tonumber(identifier)

    if src then
        local added = VBridge.AddItem(src, item, amount, info or {}, "player", nil, slot)

        local player = RSGCore and RSGCore.Functions.GetPlayer(src)
        if player then
            local inventory = VBridge.GetInventory(src, "player", player.PlayerData.citizenid)
            player.Functions.SetPlayerData('items', inventory)
        end

        return added
    end

    return VBridge.AddItem(nil, item, amount, info or {}, "stash", identifier, slot)
end

Inventory.RemoveItem = function(identifier, itemName, amount, slot, reason)
    amount = tonumber(amount) or 1
    local src = tonumber(identifier)

    if src then
        return VBridge.RemoveItem(src, itemName, amount, "player", nil, slot)
    end

    return VBridge.RemoveItem(nil, itemName, amount, "stash", identifier, slot)
end

Inventory.CanAddItem = function(source, item, amount)
    SeedMosquitoBlacksmithItems()

    if exports["v-inventory"].canCarryItem then
        return exports["v-inventory"]:canCarryItem(source, item, amount)
    end

    return true
end

local function CallUsableCallback(callback, src, item, itemName)
    if not callback then
        print("^1[rsg-inventory bridge] Missing usable callback for:^0", tostring(itemName))
        return false
    end

    local ok, err = pcall(function()
        -- Normal Lua function
        if type(callback) == "function" then
            callback(src, item)
            return
        end

        -- Funcref/table from another resource.
        -- Do NOT index it directly unless protected.
        if type(callback) == "table" then
            local okIndex, tableCb = pcall(function()
                return callback.callback
                    or callback.cb
                    or callback.onUse
                    or callback.use
                    or callback.Use
            end)

            if okIndex and type(tableCb) == "function" then
                tableCb(src, item)
                return
            end

            -- Many CFX/RedM funcrefs show as table but are callable.
            callback(src, item)
            return
        end

        -- Last fallback for userdata/funcref-like values
        callback(src, item)
    end)

    if not ok then
        print("^1[rsg-inventory bridge] usable callback error for:^0", tostring(itemName), tostring(err))
        return false
    end

    return true
end

Inventory.CreateUsableItem = function(itemName, cb)
    if not itemName or not cb then
        print("^1[rsg-inventory bridge] CreateUsableItem failed:^0", tostring(itemName), type(cb))
        return false
    end

    print("^2[rsg-inventory bridge] Register usable item:^0", tostring(itemName), "callback type:", type(cb))

    -- Wrap the incoming callback so rsg-inventory always stores a real Lua function.
    -- This fixes callbacks passed from other resources that arrive as funcref tables.
    local wrappedCallback = function(src, item)
        return CallUsableCallback(cb, src, item, itemName)
    end

    RegisteredUsables[itemName] = wrappedCallback

    if RSGCore and RSGCore.Functions then
        RSGCore.Functions.UsableItems = RSGCore.Functions.UsableItems or {}
        RSGCore.Functions.UsableItems[itemName] = wrappedCallback
    end

    if GetResourceState("v-inventory") == "started" then
        exports["v-inventory"]:CreateUsableItem(itemName, function(src, item)
            print("^3[rsg-inventory bridge] v-inventory usable fired:^0", itemName, src, json.encode(item or {}))

            item = item or {}
            item.name = item.name or item.item or item.itemName or itemName

            local fullItem = nil

            if item.slot then
                fullItem = Inventory.GetItemBySlot(src, item.slot)
            end

            if not fullItem then
                fullItem = Inventory.GetItemByName(src, item.name)
            end

            if fullItem then
                item = fullItem
            end

            item.name = item.name or itemName
            item.item = item.item or item.name
            item.itemName = item.itemName or item.name
            item.amount = item.amount or item.count or item.quantity or item.qty or 1
            item.count = item.count or item.amount
            item.quantity = item.quantity or item.amount
            item.qty = item.qty or item.amount
            item.info = item.info or item.metadata or {}
            item.metadata = item.metadata or item.info or {}

            print("^3[rsg-inventory bridge] usable final item:^0", json.encode(item or {}))

            wrappedCallback(src, item)
        end)
    end

    return true
end

Inventory.CreateUseableItem = Inventory.CreateUsableItem

Inventory.CreateUseableItem = Inventory.CreateUsableItem

Inventory.UseItem = function(source, item)
    if not source or not item then
        return false
    end

    local itemName

    if type(item) == "table" then
        itemName = item.name or item.item or item.itemName
    else
        itemName = tostring(item)
        item = { name = itemName }
    end

    if not itemName then
        return false
    end

    local cb = RegisteredUsables[itemName]

    -- fallback: ask RSGCore in case the usable was registered there
    if not cb and RSGCore and RSGCore.Functions and RSGCore.Functions.CanUseItem then
        local usable = RSGCore.Functions.CanUseItem(itemName)

        if usable then
            local ok, result = pcall(function()
                return usable
            end)

            if ok and result then
                cb = result
            end
        end
    end

    if not cb then
        print("^1[rsg-inventory bridge] UseItem failed: no registered callback for:^0", itemName)
        return false
    end

    item.name = item.name or itemName
    item.item = item.item or item.name
    item.itemName = item.itemName or item.name
    item.info = item.info or item.metadata or {}
    item.metadata = item.metadata or item.info or {}

    print("^3[rsg-inventory bridge] UseItem calling callback:^0", itemName, source, json.encode(item or {}))

    local ok, err = pcall(function()
        cb(source, item)
    end)

if not ok then
    print("^1[rsg-inventory bridge] UseItem callback error for:^0", tostring(itemName), tostring(err))
    return false
end

    return true
end

Inventory.OpenInventoryById = function(source, targetId)
    local targetIdentifier = VBridge.GetIdentifier(targetId)

    if targetIdentifier then
        TriggerClientEvent('v-inventory:client:OpenInventory', source, {
            type = "player",
            id = targetIdentifier,
            label = "Player " .. targetId,
            slots = 80
        })

        return true
    end

    return false
end

Inventory.CloseInventory = function(source, identifier)
    TriggerEvent('v-inventory:server:CloseInventory', {
        type = "player",
        id = identifier
    })
end

Inventory.GetSlots = function(identifier)
    return 0, 80
end

Inventory.GetFreeWeight = function(source)
    return 10000
end

Inventory.GetTotalWeight = function(items)
    local weight = 0

    for _, item in pairs(items or {}) do
        if type(item) == "table" then
            weight = weight + ((tonumber(item.weight) or 0) * (tonumber(item.amount) or 0))
        end
    end

    return weight
end

Inventory.GetItemWeight = function(itemName)
    local defs = VBridge.GetItemDefinitions and VBridge.GetItemDefinitions() or {}
    return defs[itemName] and defs[itemName].weight or 0
end

Inventory.ClearInventory = function(source, filterItems)
    if VBridge.ClearInventory then
        return VBridge.ClearInventory(source)
    end

    return false
end

Inventory.ClearStash = function(identifier)
    return true
end

Inventory.SaveStash = function(identifier)
    return true
end

Inventory.SaveInventory = function(source, offline)
    if not offline then
        exports["v-inventory"]:ForceSave(source)
    end
end

Inventory.LoadInventory = function(source, citizenid)
    local inventory = VBridge.GetInventory(source, "player", citizenid) or {}

    local player = RSGCore and RSGCore.Functions.GetPlayer(source)
    if player then
        player.Functions.SetPlayerData('items', inventory)
    end

    return inventory
end

Inventory.SetInventory = function(source, items)
    if exports["v-inventory"].ClearInventory then
        exports["v-inventory"]:ClearInventory(source)
    end

    for _, item in pairs(items or {}) do
        if item.type ~= "item_money" then
            VBridge.AddItem(source, item.name, item.amount, item.info or item.metadata or {}, "player", nil, item.slot)
        end
    end

    local player = RSGCore and RSGCore.Functions.GetPlayer(source)
    if player then
        player.Functions.SetPlayerData('items', items or {})
    end
end

Inventory.SetItemData = function(source, itemName, key, val)
    return false
end

Inventory.ForceDropItem = function(source, item, amount, info, reason)
    if VBridge.CreateDrop then
        VBridge.CreateDrop(source, { name = item, label = item }, amount, info)
        return true
    end

    return false
end

Inventory.DeleteInventory = function(identifier)
    return true
end

Shops.SetupShopItems = function(items, shopData)
    local setupItems = {}
    if not items then return setupItems end

    local slot = 1

    for k, v in pairs(items) do
        if type(v) == 'table' then
            local itemName = v.name or v.item or v.itemName

            if itemName then
                table.insert(setupItems, {
                    name = itemName,
                    amount = v.amount or v.count or v.stock or v.defaultstock or 100,
                    defaultstock = v.defaultstock or v.amount or v.count or v.stock or 100,
                    price = v.price or v.cost or 0,
                    slot = v.slot or tonumber(k) or slot,
                    label = v.label or itemName,
                    info = v.info or v.metadata or {},
                    type = v.type or "item"
                })

                slot = slot + 1
            end
        elseif type(k) == 'string' then
            table.insert(setupItems, {
                name = k,
                amount = tonumber(v) or 100,
                defaultstock = tonumber(v) or 100,
                price = 0,
                slot = slot,
                label = k,
                info = {},
                type = "item"
            })

            slot = slot + 1
        end
    end

    return setupItems
end

Shops.CreateShop = function(shopData)
    if not shopData then return false end

    if not shopData.name then
        for key, data in pairs(shopData) do
            if type(data) == 'table' then
                data.name = data.name or key
                Shops.CreateShop(data)
            end
        end

        return true
    end

    local rawItems = shopData.items or shopData.products or shopData.inventory or {}
    local setupItems = Shops.SetupShopItems(rawItems, shopData)

    RegisteredShops[shopData.name] = {
        name = shopData.name,
        label = shopData.label or shopData.name,
        coords = shopData.coords,
        slots = shopData.slots or #setupItems,
        items = setupItems,
        persistentStock = shopData.persistentStock,
    }

    local ok, Config = pcall(function()
        return exports['v-inventory']:GetConfig()
    end)

    if ok and Config and Config.Shops then
        local found = false

        for i, shop in ipairs(Config.Shops) do
            if shop.name == shopData.name then
                Config.Shops[i] = RegisteredShops[shopData.name]
                found = true
                break
            end
        end

        if not found then
            table.insert(Config.Shops, RegisteredShops[shopData.name])
        end

        pcall(function()
            exports['v-inventory']:SetConfigShops(Config.Shops)
        end)
    end

    return true
end

Shops.OpenShop = function(source, name)
    if not name or not RegisteredShops[name] then return false end

    local shop = RegisteredShops[name]

    TriggerClientEvent('v-inventory:client:OpenInventory', source, {
        type = "shop",
        id = shop.name,
        label = shop.label,
        slots = shop.slots,
        items = shop.items
    })

    return true
end

Shops.RestockShop = function(shopName, percentage)
    return true
end

Shops.DoesShopExist = function(shopName)
    return RegisteredShops[shopName] ~= nil
end

RegisterNetEvent('inventory:server:OpenInventory', function(invType, invId, data)
    local src = source

    if type(invType) == 'table' then
        data = invType
        invType = data.type
        invId = data.id or data.name
    end

    if invType == 'stash' then
        local stashId = invId or (data and (data.id or data.name)) or ('stash_' .. tostring(src))

        TriggerClientEvent('v-inventory:client:OpenInventory', src, {
            type = "stash",
            id = stashId,
            label = (data and (data.label or data.title or data.name)) or stashId,
            slots = (data and data.slots) or 80,
            capacity = (data and (data.maxweight or data.maxWeight or data.capacity)) or 100000
        })

        return
    end

    if invType == 'player' then
        TriggerClientEvent('v-inventory:client:OpenInventory', src, {
            type = "player",
            id = tostring(src),
            label = "Player",
            slots = 80
        })
    end
end)

RegisterNetEvent('inventory:client:SetCurrentStash', function() end)
RegisterNetEvent('inventory:server:SaveInventory', function() end)

AddEventHandler('RSGCore:Server:PlayerLoaded', function(Player)
    local src = Player.PlayerData.source

    local methods = {
        AddItem = function(item, amount, slot, info, reason)
            return Inventory.AddItem(src, item, amount, slot, info, reason)
        end,
        RemoveItem = function(item, amount, slot, reason)
            return Inventory.RemoveItem(src, item, amount, slot, reason)
        end,
        GetItemBySlot = function(slot)
            return Inventory.GetItemBySlot(src, slot)
        end,
        GetItemByName = function(item)
            return Inventory.GetItemByName(src, item)
        end,
        GetItemsByName = function(item)
            return Inventory.GetItemsByName(src, item)
        end,
        ClearInventory = function(filterItems)
            return Inventory.ClearInventory(src, filterItems)
        end,
        SetInventory = function(items)
            return Inventory.SetInventory(src, items)
        end
    }

    for methodName, methodFunc in pairs(methods) do
        RSGCore.Functions.AddPlayerMethod(src, methodName, methodFunc)
    end
end)

Inventory.CreateInventory = function(identifier, data)
    if not identifier then
        return false
    end

    data = data or {}

    local stashData = {
        id = identifier,
        name = identifier,
        type = "stash",
        label = data.label and data.label ~= "" and data.label or identifier,
        slots = data.slots or data.maxSlots or 50,
        capacity = data.maxweight or data.maxWeight or data.capacity or 50000,
        maxweight = data.maxweight or data.maxWeight or data.capacity or 50000
    }

    RegisteredInventories[identifier] = stashData

    print("^2[rsg-inventory bridge] CreateInventory registered:^0", identifier, json.encode(stashData))

    -- v-inventory usually creates the actual stash when opened/used.
    -- This keeps QC Moonshine compatibility while also storing vault info for TP Banks.
    return true
end

Inventory.RegisterStash = Inventory.CreateInventory
Inventory.CreateStash = Inventory.CreateInventory


Inventory.OpenInventory = function(source, identifier, data)
    data = data or {}

    if not source then
        return false
    end

    local stashId = nil
    local stashData = {}

    -- If script passes a stash name/string:
    -- exports['rsg-inventory']:OpenInventory(src, 'bank_GR01061604565', data)
    if type(identifier) == "string" then
        stashId = identifier

        -- Prefer data remembered from CreateInventory, but allow passed data to override/fill blanks
        stashData = RegisteredInventories[stashId] or {}

        stashData.label = data.label or data.name or data.title or stashData.label or stashId
        stashData.slots = data.slots or data.maxSlots or stashData.slots or 80
        stashData.capacity = data.maxweight or data.maxWeight or data.capacity or stashData.capacity or stashData.maxweight or 100000
        stashData.maxweight = stashData.capacity
    end

    -- If script passes a table:
    -- exports['rsg-inventory']:OpenInventory(src, { id = 'stashid', label = 'Label' })
    if type(identifier) == "table" then
        local invData = identifier
        stashId = invData.id or invData.name or invData.identifier

        if stashId then
            stashData = RegisteredInventories[stashId] or {}

            stashData.label = invData.label or invData.name or invData.title or stashData.label or stashId
            stashData.slots = invData.slots or invData.maxSlots or stashData.slots or 80
            stashData.capacity = invData.maxweight or invData.maxWeight or invData.capacity or stashData.capacity or stashData.maxweight or 100000
            stashData.maxweight = stashData.capacity
            stashData.type = invData.type or stashData.type or "stash"
        end
    end

    if not stashId then
        return false
    end

    TriggerClientEvent('v-inventory:client:OpenInventory', source, {
        type = stashData.type or "stash",
        id = stashId,
        label = stashData.label or stashId,
        slots = stashData.slots or 80,
        capacity = stashData.capacity or stashData.maxweight or 100000
    })

    print("^2[rsg-inventory bridge] OpenInventory stash:^0", source, stashId, json.encode({
        label = stashData.label or stashId,
        slots = stashData.slots or 80,
        capacity = stashData.capacity or stashData.maxweight or 100000
    }))

    return true
end

local Exports = {
    LoadInventory = Inventory.LoadInventory,
    SaveInventory = Inventory.SaveInventory,
    SetInventory = Inventory.SetInventory,
    SetItemData = Inventory.SetItemData,
    GetItemWeight = Inventory.GetItemWeight,
    UseItem = Inventory.UseItem,

    GetSlotsByItem = Inventory.GetSlotsByItem,
    GetFirstSlotByItem = Inventory.GetFirstSlotByItem,
    GetItemBySlot = Inventory.GetItemBySlot,
    GetTotalWeight = Inventory.GetTotalWeight,
    GetItemByName = Inventory.GetItemByName,
    GetItemsByName = Inventory.GetItemsByName,
    GetSlots = Inventory.GetSlots,
    GetItemCount = Inventory.GetItemCount,
    CanAddItem = Inventory.CanAddItem,
    GetFreeWeight = Inventory.GetFreeWeight,
    ClearInventory = Inventory.ClearInventory,
    HasItem = Inventory.HasItem,

    CloseInventory = Inventory.CloseInventory,
    OpenInventoryById = Inventory.OpenInventoryById,
    ClearStash = Inventory.ClearStash,
    SaveStash = Inventory.SaveStash,
    OpenInventory = Inventory.OpenInventory,
    ForceDropItem = Inventory.ForceDropItem,
    AddItem = Inventory.AddItem,
    RemoveItem = Inventory.RemoveItem,
    GetInventory = Inventory.GetInventory,
    GetStashItems = Inventory.GetStashItems,

    CreateInventory = Inventory.CreateInventory,
    RegisterStash = Inventory.RegisterStash,
    CreateStash = Inventory.CreateStash,
    DeleteInventory = Inventory.DeleteInventory,

    CreateUsableItem = Inventory.CreateUsableItem,
    CreateUseableItem = Inventory.CreateUseableItem,

    CreateShop = Shops.CreateShop,
    OpenShop = Shops.OpenShop,
    RestockShop = Shops.RestockShop,
    DoesShopExist = Shops.DoesShopExist,
}

for k, v in pairs(Exports) do
    if v ~= nil then
        exports(k, v)
    else
        print("^1[rsg-inventory bridge] Missing export function:^0", k)
    end
end

print("^2[rsg-inventory bridge] exports.lua fully loaded^0")
