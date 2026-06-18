print("^2[vorp_inventory bridge] server starting^0")

local VorpInventoryAPI = {}

-- EARLY EXPORT BOOTSTRAP (prevents startup race "No such export ...")
exports("vorp_inventoryApi", function()
    return VorpInventoryAPI
end)

exports("registerUsableItem", function(...)
    local fn = VorpInventoryAPI.registerUsableItem or VorpInventoryAPI.RegisterUsableItem
    if type(fn) == "function" then return fn(...) end
    return false
end)

exports("RegisterUsableItem", function(...)
    local fn = VorpInventoryAPI.RegisterUsableItem or VorpInventoryAPI.registerUsableItem
    if type(fn) == "function" then return fn(...) end
    return false
end)
local function callVorpInventoryApi(name, ...)
    local fn = VorpInventoryAPI[name]
    if type(fn) ~= "function" then
        local alt = name:sub(1, 1):upper() .. name:sub(2)
        fn = VorpInventoryAPI[alt]
    end
    if type(fn) == "function" then
        return fn(...)
    end
    return nil
end

exports("vorp_inventoryApi", function() return VorpInventoryAPI end)
exports("registerUsableItem", function(...) return callVorpInventoryApi("registerUsableItem", ...) end)
exports("RegisterUsableItem", function(...) return callVorpInventoryApi("RegisterUsableItem", ...) end)
local DebugVorpBridge = GetConvar and tostring(GetConvar("vorp_inventory_bridge_debug", "0")) == "1"

local function debugPrint(name, ...)
    if DebugVorpBridge then
        print(("^3[vorp_inventory bridge] %s^0"):format(name), ...)

        local target = tonumber((select(1, ...)))
        if target and target > 0 then
            local parts = {}
            for index = 1, math.min(select("#", ...), 6) do
                parts[#parts + 1] = tostring(select(index, ...))
            end

            TriggerClientEvent("chat:addMessage", target, {
                args = { "vorp_inventory bridge", ("%s %s"):format(tostring(name), table.concat(parts, " | ")) }
            })
        end
    end
end

local function safeCall(label, fn, fallback)
    local ok, result = pcall(fn)
    if ok then return result end

    print(("^1[vorp_inventory bridge] %s error:^0 %s"):format(label, tostring(result)))
    return fallback
end

local function isCallable(value)
    if type(value) == "function" then
        return true
    end

    if type(value) == "userdata" then
        return true
    end

    if type(value) == "table" then
        local mt = getmetatable(value)
        return mt and type(mt.__call) == "function"
    end

    return false
end

local function describeValue(value)
    local valueType = type(value)
    local pieces = { valueType }

    if valueType == "table" then
        local keys = {}
        for key, itemValue in pairs(value) do
            keys[#keys + 1] = ("%s:%s"):format(tostring(key), type(itemValue))
            if #keys >= 8 then break end
        end

        pieces[#pieces + 1] = "keys=" .. table.concat(keys, ",")

        local mt = getmetatable(value)
        if mt then
            pieces[#pieces + 1] = "mt=" .. tostring(mt)
            pieces[#pieces + 1] = "__call=" .. type(mt.__call)
        end
    else
        pieces[#pieces + 1] = tostring(value)
    end

    return table.concat(pieces, " ")
end

local function extractCallback(...)
    for index = 1, select("#", ...) do
        local value = select(index, ...)
        if isCallable(value) then return value end
    end

    return nil
end

local function invokeCallback(cb, ...)
    if not isCallable(cb) then return end

    local ok, err = pcall(cb, ...)
    if not ok then
        print(("^1[vorp_inventory bridge] callback error:^0 %s"):format(tostring(err)))
    end
end

local function invokeCarryCallback(cb, canCarry)
    if not isCallable(cb) then return end

    local ok, err = pcall(cb, canCarry)

    if not ok then
        print(("^1[vorp_inventory bridge] carry callback error:^0 %s"):format(tostring(err)))
    end
end

local function isSuccessResult(result)
    return result ~= nil and result ~= false
end

local function isEmptyTable(value)
    return type(value) ~= "table" or next(value) == nil
end

local function isCrusherRawItem(itemName)
    local name = tostring(itemName or ""):lower()
    return name == "rock"
        or name == "stone"
        or name == "sandstone"
        or name == "limestone"
        or name == "sand"
end

local function inventoryTraceShouldPrint(itemName)
    if DebugVorpBridge then return true end
    if type(GetConvar) == "function" and tostring(GetConvar("vorp_inventory_trace", "0")) == "1" then
        return true
    end
    return false
end

    local name = tostring(itemName or ""):lower()
    return isCrusherRawItem(itemName)
        or name == "pickaxe"
        or name == "pickaxe_steel"
        or name == "pickaxe_silver"
        or name == "pickaxe_gold"
end

local function inventoryTrace(action, source, itemName, detail)
    if inventoryTraceShouldPrint(itemName) then
        print(("[vorp_inventory bridge] %s source=%s item=%s %s"):format(
            tostring(action),
            tostring(source),
            tostring(itemName),
            tostring(detail or "")
        ))
    end
end

local MosquitoItemDefinitions

local function buildMosquitoItemDefinitions()
    if MosquitoItemDefinitions then return MosquitoItemDefinitions end

    local defs = {
        blacksmith_forge = {
            name = "blacksmith_forge",
            label = "Blacksmith Forge",
            description = "Blacksmith Forge",
            weight = 8.0,
            type = "item",
            image = "blacksmith_forge",
            can_remove = true,
            limit = 1,
            usable = true,
            useable = true,
        },
        blacksmith_forge_advanced = {
            name = "blacksmith_forge_advanced",
            label = "Advanced Blacksmith Forge",
            description = "Advanced Blacksmith Forge",
            weight = 10.0,
            type = "item",
            image = "blacksmith_forge_advanced",
            can_remove = true,
            limit = 1,
            usable = true,
            useable = true,
        },
    }

    local contents = LoadResourceFile("mosquito-mining-blacksmithing", "items.sql") or ""
    for itemName, label, limit, canRemove, _itemType, usable, weight in contents:gmatch("%('([^']+)',%s*'([^']*)',%s*([%d%.]+),%s*([01]),%s*'([^']+)',%s*([01]),%s*([%d%.]+)%)") do
        if itemName ~= "forge" and itemName ~= "forge_advanced" then
            defs[itemName] = {
                item = itemName,
                name = itemName,
                label = label,
                description = label,
                limit = tonumber(limit) or 100,
                can_remove = tostring(canRemove) == "1",
                type = "item_standard",
                usable = tostring(usable) == "1",
                useable = tostring(usable) == "1",
                weight = tonumber(weight) or 0.0,
            }
        end
    end

    MosquitoItemDefinitions = defs
    return MosquitoItemDefinitions
end

local function normalizeItem(item, forcedName)
    if type(item) ~= "table" then return nil end

    local name = item.name or item.item or item.itemName or forcedName
    if not name then return nil end

    local amount = tonumber(item.amount or item.count or item.quantity or item.qty or 1) or 1
    local metadata = item.metadata or item.info or {}
    local slot = tonumber(item.slot or item.id or item.mainid)
    local def = buildMosquitoItemDefinitions()[name] or {}
    local label = item.label or item.Label or item.displayName or def.label or name
    local description = item.description or item.desc or item.Description or def.description or label or name
    description = tostring(description)

    item.name = name
    item.item = item.item or name
    item.itemName = item.itemName or name
    item.itemId = item.itemId or slot or name
    item.label = label
    item.Label = item.Label or label
    item.description = description
    item.Description = item.Description or description
    item.desc = item.desc or item.description
    item.itemdesc = item.itemdesc or description
    item.itemDesc = item.itemDesc or description
    item.ItemDesc = item.ItemDesc or description
    item.itemDescription = item.itemDescription or description
    item.ItemDescription = item.ItemDescription or description
    item.text = item.text or description
    item.limit = tonumber(item.limit or def.limit or 100) or 100
    item.weight = tonumber(item.weight or def.weight or 0) or 0
    item.type = item.type or def.type or "item_standard"
    item.can_remove = item.can_remove
    if item.can_remove == nil then item.can_remove = def.can_remove ~= false end
    item.usable = item.usable
    if item.usable == nil then item.usable = def.usable == true end
    item.useable = item.useable
    if item.useable == nil then item.useable = item.usable == true end
    item.amount = amount
    item.count = amount
    item.quantity = amount
    item.qty = amount
    if type(metadata) ~= "table" then metadata = {} end
    metadata.description = metadata.description or description
    metadata.desc = metadata.desc or description
    metadata.label = metadata.label or label
    item.metadata = metadata
    item.info = metadata
    item.slot = slot or item.slot
    item.id = item.id or slot
    item.mainid = item.mainid or item.id

    if getmetatable(item) == nil then
        setmetatable(item, {
            __index = function(_, key)
                if key == "description" or key == "Description" or key == "desc" then
                    return description
                end

                return nil
            end
        })
    end

    return item
end

local function metadataMatches(itemMetadata, wantedMetadata)
    if isEmptyTable(wantedMetadata) then return true end
    if type(itemMetadata) ~= "table" then return false end

    for key, wantedValue in pairs(wantedMetadata) do
        local actualValue = itemMetadata[key]
        if type(wantedValue) == "table" then
            if not metadataMatches(actualValue, wantedValue) then return false end
        elseif actualValue ~= wantedValue then
            return false
        end
    end

    return true
end

local function getRsgPlayer(source)
    if not source or GetResourceState("rsg-core") ~= "started" then return nil end

    local ok, core = pcall(function()
        return exports["rsg-core"]:GetCoreObject()
    end)

    if not ok or not core or not core.Functions then return nil end

    local okPlayer, player = pcall(function()
        return core.Functions.GetPlayer(source)
    end)

    return okPlayer and player or nil
end

local function getRsgCitizenId(source)
    local player = getRsgPlayer(source)
    return player and player.PlayerData and player.PlayerData.citizenid or nil
end

local function appendInventoryItems(list, seen, items)
    if type(items) ~= "table" then return end

    local function addItem(item, fallbackSlot)
        if type(item) ~= "table" then return end

        local copy = {}
        for key, value in pairs(item) do
            copy[key] = value
        end

        if copy.slot == nil and tonumber(fallbackSlot) then
            copy.slot = tonumber(fallbackSlot)
        end

        local normalized = normalizeItem(copy)
        if not normalized then return end

        local key = tostring(normalized.slot or #list + 1) .. ":" .. normalized.name
        if seen[key] then return end

        seen[key] = true
        list[#list + 1] = normalized
    end

    for slot, item in ipairs(items) do
        addItem(item, slot)
    end

    for slot, item in pairs(items) do
        addItem(item, slot)
    end
end

local function getInventoryItems(source, cb)
    if not source then
        local empty = {}
        invokeCallback(cb, empty)
        return empty
    end

    local items = safeCall("rsg GetInventory", function()
        return exports["rsg-inventory"]:GetInventory(source)
    end, {}) or {}

    local list = {}
    local seen = {}

    appendInventoryItems(list, seen, items)

    local citizenId = getRsgCitizenId(source)
    local vItems = safeCall("v GetInventory", function()
        return exports["v-inventory"]:GetInventory(source, "player", citizenId)
    end, {}) or {}

    appendInventoryItems(list, seen, vItems)

    local player = getRsgPlayer(source)
    if player and player.PlayerData and type(player.PlayerData.items) == "table" then
        appendInventoryItems(list, seen, player.PlayerData.items)
    end

    invokeCallback(cb, list)
    return list
end

local function getItemByName(source, itemName, metadata)
    if not source or not itemName then return nil end

    if isEmptyTable(metadata) then
        local item = safeCall("GetItemByName", function()
            return exports["rsg-inventory"]:GetItemByName(source, itemName)
        end)

        local normalized = normalizeItem(item, itemName)
        if normalized then return normalized end
    end

    for _, item in ipairs(getInventoryItems(source)) do
        if item.name == itemName and metadataMatches(item.metadata or item.info, metadata) then
            return normalizeItem(item, itemName)
        end
    end

    if isEmptyTable(metadata) or isCrusherRawItem(itemName) then
        local count = safeCall("GetItemCount fallback", function()
            return exports["rsg-inventory"]:GetItemCount(source, itemName)
        end, 0)

        count = tonumber(count) or 0
        if count > 0 then
            inventoryTrace("getItem count fallback", source, itemName, ("count=%s"):format(tostring(count)))
            local def = buildMosquitoItemDefinitions()[itemName] or {}
            local label = def.label or itemName
            local description = def.description or label or itemName
            return normalizeItem({
                name = itemName,
                item = itemName,
                itemName = itemName,
                amount = count,
                count = count,
                quantity = count,
                qty = count,
                label = label,
                Label = label,
                description = description,
                Description = description,
                desc = description,
                itemdesc = description,
                itemDescription = description,
                metadata = { description = description, desc = description, label = label },
                info = { description = description, desc = description, label = label },
            }, itemName)
        end

        inventoryTrace("getItem count fallback empty", source, itemName, ("count=%s metadata=%s"):format(tostring(count), tostring(type(metadata))))
    else
        inventoryTrace("getItem count fallback skipped", source, itemName, ("metadata=%s"):format(tostring(type(metadata))))
    end

    return nil
end

local function normalizeItemNameArg(itemName)
    if type(itemName) == "table" then
        return itemName.name or itemName.item or itemName.itemName or itemName[1]
    end

    return itemName
end

local function normalizeGetItemArgs(itemName, ...)
    local cb = extractCallback(itemName, ...)
    local metadata = nil
    local resolvedItemName = normalizeItemNameArg(itemName)

    for index = 1, select("#", ...) do
        local value = select(index, ...)
        if not isCallable(value) then
            if type(value) == "table" and not metadata then
                metadata = value.metadata or value.info or value
            elseif not resolvedItemName and type(value) == "string" then
                resolvedItemName = value
            elseif type(value) == "table" and not resolvedItemName then
                resolvedItemName = normalizeItemNameArg(value)
            end
        end
    end

    if type(itemName) == "table" and not metadata then
        metadata = itemName.metadata or itemName.info
    end

    return resolvedItemName, metadata, cb
end

local function getItem(source, itemName, cbOrMetadata, maybeMetadata)
    local resolvedItemName, metadata, cb = normalizeGetItemArgs(itemName, cbOrMetadata, maybeMetadata)
    debugPrint("getItem", source, resolvedItemName)

    if not source or not resolvedItemName then
        inventoryTrace("getItem invalid", source, resolvedItemName, ("callback=%s"):format(tostring(type(cb))))
        invokeCallback(cb, nil)
        return nil
    end

    local item = getItemByName(source, resolvedItemName, metadata)
    item = normalizeItem(item, resolvedItemName)
    inventoryTrace("getItem result", source, resolvedItemName, ("found=%s count=%s callback=%s"):format(
        tostring(item ~= nil),
        tostring(item and (item.count or item.amount or item.quantity or item.qty) or 0),
        tostring(type(cb))
    ))
    inventoryTrace("getItem payload", source, resolvedItemName, ("description=%s desc=%s label=%s type=%s"):format(
        tostring(item and item.description),
        tostring(item and item.desc),
        tostring(item and item.label),
        tostring(item and type(item))
    ))
    invokeCallback(cb, item)
    return item
end

local function getItemContainingMetadata(source, itemName, metadataOrCb, cbOrMetadata)
    local resolvedItemName, metadata, cb = normalizeGetItemArgs(itemName, metadataOrCb, cbOrMetadata)
    debugPrint("getItemContainingMetadata", source, resolvedItemName)

    if not source or not resolvedItemName then
        inventoryTrace("getItemContainingMetadata invalid", source, resolvedItemName, ("callback=%s"):format(tostring(type(cb))))
        invokeCallback(cb, nil)
        return nil
    end

    local item = getItemByName(source, resolvedItemName, metadata)
    inventoryTrace("getItemContainingMetadata result", source, resolvedItemName, ("found=%s count=%s callback=%s"):format(
        tostring(item ~= nil),
        tostring(item and (item.count or item.amount or item.quantity or item.qty) or 0),
        tostring(type(cb))
    ))
    invokeCallback(cb, item)
    return item
end

local function getItemCount(source, itemName, cb, ...)
    local resolvedItemName = normalizeItemNameArg(itemName)
    debugPrint("getItemCount", source, resolvedItemName)

    cb = extractCallback(itemName, cb, ...)

    if not source or not resolvedItemName then
        invokeCallback(cb, 0)
        return 0
    end

    local count = safeCall("GetItemCount", function()
        return exports["rsg-inventory"]:GetItemCount(source, resolvedItemName)
    end, 0)

    count = math.floor(tonumber(count) or 0)
    if count > 0 then
        inventoryTrace("getItemCount result", source, resolvedItemName, ("count=%s source=rsg callback=%s"):format(tostring(count), tostring(type(cb))))
        debugPrint("getItemCount result", source, resolvedItemName, count)
        invokeCallback(cb, count)
        return count
    end

    local fallbackCount = 0
    for _, item in ipairs(getInventoryItems(source)) do
        if item.name == resolvedItemName then
            fallbackCount = fallbackCount + (tonumber(item.amount or item.count or item.quantity or item.qty) or 0)
        end
    end

    fallbackCount = math.floor(tonumber(fallbackCount) or 0)
    invokeCallback(cb, fallbackCount)
    inventoryTrace("getItemCount result", source, resolvedItemName, ("count=%s source=fallback callback=%s"):format(tostring(fallbackCount), tostring(type(cb))))
    debugPrint("getItemCount result", source, resolvedItemName, fallbackCount)
    return fallbackCount
end

RegisterCommand("bsrockcheck", function(source)
    if not source or source <= 0 then
        print("[vorp_inventory bridge] bsrockcheck must be run in-game")
        return
    end

    local counts = {}
    for _, itemName in ipairs({ "rock", "stone", "sandstone" }) do
        counts[#counts + 1] = ("%s=%s"):format(itemName, tostring(getItemCount(source, itemName)))
    end

    local sample = {}
    for _, item in ipairs(getInventoryItems(source)) do
        local name = tostring(item.name or "")
        if name:find("rock", 1, true) or name:find("stone", 1, true) or name:find("sand", 1, true) or name:find("ore", 1, true) or name == "coal" or name == "limestone" then
            sample[#sample + 1] = ("%s:%s"):format(name, tostring(item.count or item.amount or item.quantity or item.qty or 0))
        end
    end

    local msg = table.concat(counts, " ") .. " sample=" .. table.concat(sample, ", ")
    print(("[vorp_inventory bridge] bsrockcheck source=%s %s"):format(tostring(source), msg))
    TriggerClientEvent("chat:addMessage", source, { args = { "bsrockcheck", msg } })
end, false)

local function canCarryItem(source, itemName, amount, cb, ...)
    debugPrint("canCarryItem", source, itemName, amount)

    cb = extractCallback(amount, cb, ...)

    if type(amount) == "function" or amount == nil then
        amount = 1
    end

    if not source or not itemName then
        invokeCarryCallback(cb, false)
        return false
    end

    if type(itemName) == "table" then
        local canCarry = true

        for key, item in pairs(itemName) do
            local name = nil
            local count = 1

            if type(item) == "table" then
                name = item.name or item.item or item.itemName or item[1]
                count = tonumber(item.amount or item.count or item.quantity or item.qty or item[2] or 1) or 1
            elseif type(key) == "string" then
                name = key
                count = tonumber(item) or 1
            end

            if name and not canCarryItem(source, name, count) then
                canCarry = false
                break
            end
        end

        invokeCarryCallback(cb, canCarry)
        debugPrint("canCarryItem list result", source, "items", canCarry, "callback", type(cb))
        return canCarry
    end

    amount = tonumber(amount) or 1

    local result = safeCall("CanAddItem", function()
        return exports["rsg-inventory"]:CanAddItem(source, itemName, amount)
    end, true)

    local canCarry = result ~= false
    debugPrint("canCarryItem result", source, itemName, amount, canCarry, "raw", result, "callback", type(cb))
    invokeCarryCallback(cb, canCarry)
    return canCarry
end

local function canCarryItems(source, amount, cb)
    debugPrint("canCarryItems", source, amount)
    invokeCarryCallback(cb, true)
    return true
end

local function addItem(source, itemName, amount, metadata, cb, ...)
    debugPrint("addItem", source, itemName, amount)

    cb = extractCallback(amount, metadata, cb, ...)

    if type(amount) == "function" or amount == nil then
        amount = 1
    end

    if type(metadata) == "function" or type(metadata) ~= "table" then
        metadata = {}
    end

    if not source or not itemName then
        invokeCallback(cb, false)
        return false
    end

    amount = tonumber(amount) or 1

    local added = isSuccessResult(safeCall("AddItem", function()
        return exports["rsg-inventory"]:AddItem(source, itemName, amount, nil, metadata)
    end, false))

    if not added then
        added = isSuccessResult(safeCall("v AddItem", function()
            return exports["v-inventory"]:AddItem(source, itemName, amount, metadata)
        end, false))
    end

    debugPrint("addItem result", source, itemName, amount, added)
    if added then
        TriggerEvent("mosquito_blacksmith:server:inventoryItemAdded", source, itemName, amount)
    end
    invokeCallback(cb, added)
    return added
end

local function subItem(source, itemName, amount, metadata, cb, ...)
    debugPrint("subItem", source, itemName, amount)

    cb = extractCallback(amount, metadata, cb, ...)

    if type(amount) == "function" or amount == nil then
        amount = 1
    end

    if type(metadata) == "function" then
        metadata = nil
    end

    if not source or not itemName then
        invokeCallback(cb, false)
        return false
    end

    amount = tonumber(amount) or 1

    local slot = nil
    if type(metadata) == "table" and not isEmptyTable(metadata) then
        local item = getItemByName(source, itemName, metadata)
        slot = item and item.slot or nil
    end

    local removed = isSuccessResult(safeCall("RemoveItem", function()
        return exports["rsg-inventory"]:RemoveItem(source, itemName, amount, slot)
    end, false))

    if not removed then
        removed = isSuccessResult(safeCall("v RemoveItem", function()
            return exports["v-inventory"]:RemoveItem(source, itemName, amount, "player", nil, slot)
        end, false))
    end

    if removed and isCrusherRawItem(itemName) then
        TriggerEvent("mosquito_blacksmith:server:crusherRawRemoved", source, itemName, amount)
    end
    debugPrint("subItem result", source, itemName, amount, removed, "slot", slot)
    invokeCallback(cb, removed)
    return removed
end

local function subItemById(source, itemId, amount, cb, ...)
    debugPrint("subItemById", source, itemId, amount)

    cb = extractCallback(amount, cb, ...)

    if type(amount) == "function" or amount == nil then
        amount = 1
    end

    local numericId = tonumber(itemId)
    if not source or not numericId then
        invokeCallback(cb, false)
        return false
    end

    amount = tonumber(amount) or 1

    for _, item in ipairs(getInventoryItems(source)) do
        if tonumber(item.slot or item.id or item.mainid) == numericId then
            local removed = isSuccessResult(safeCall("RemoveItemById", function()
                return exports["rsg-inventory"]:RemoveItem(source, item.name, amount, numericId)
            end, false))

            invokeCallback(cb, removed)
            return removed
        end
    end

    invokeCallback(cb, false)
    return false
end

local function metadataCopy(value)
    local copy = {}
    if type(value) ~= "table" then return copy end

    for key, itemValue in pairs(value) do
        copy[key] = itemValue
    end

    return copy
end

local function setRsgItemMetadata(source, itemId, metadata)
    local player = getRsgPlayer(source)
    if not player or not player.PlayerData or type(player.PlayerData.items) ~= "table" then
        return false, "missing-player-items"
    end

    local slot = tonumber(itemId)
    local itemName = type(itemId) == "string" and itemId or nil
    if type(itemId) == "table" then
        slot = tonumber(itemId.slot or itemId.id or itemId.mainid or itemId.itemId)
        itemName = itemId.name or itemId.item or itemId.itemName
    end

    local targetKey = nil
    local targetItem = nil
    for key, item in pairs(player.PlayerData.items) do
        if type(item) == "table" then
            local itemSlot = tonumber(item.slot or key)
            local itemIdValue = tonumber(item.id or item.mainid or item.itemId)
            local itemNameValue = item.name or item.item or item.itemName
            if (slot and (itemSlot == slot or itemIdValue == slot))
                or (not slot and itemName and itemNameValue == itemName) then
                targetKey = key
                targetItem = item
                break
            end
        end
    end

    if not targetItem then
        return false, "item-not-found"
    end

    local newMetadata = metadataCopy(metadata)
    targetItem.info = newMetadata
    targetItem.metadata = newMetadata
    player.PlayerData.items[targetKey] = targetItem

    local ok, err = pcall(function()
        player.Functions.SetPlayerData("items", player.PlayerData.items)
    end)

    if not ok then
        return false, err
    end

    return true, targetItem.name or targetItem.item or targetItem.itemName or itemName or slot
end

local function setItemMetadata(source, itemId, metadata, amount, cb)
    debugPrint("setItemMetadata", source, itemId)

    if type(amount) == "function" and cb == nil then
        cb = amount
    end

    local lookupItemId = itemId
    if type(itemId) == "table" then
        itemId = itemId.slot or itemId.id or itemId.mainid or itemId.itemId
    end

    local slot = tonumber(itemId)
    if not source or (not slot and not itemId and type(lookupItemId) ~= "table") then
        invokeCallback(cb, false)
        return false
    end

    local result, detail = setRsgItemMetadata(source, lookupItemId or itemId, metadata or {})
    inventoryTrace("setItemMetadata rsg", source, detail or itemId, ("slot=%s result=%s sharpness=%s durability=%s"):format(
        tostring(slot),
        tostring(result),
        tostring(type(metadata) == "table" and metadata.sharpness or nil),
        tostring(type(metadata) == "table" and metadata.durability or nil)
    ))

    local fallbackSlot = slot
    if not fallbackSlot and type(lookupItemId) == "table" then
        fallbackSlot = tonumber(lookupItemId.slot or lookupItemId.id or lookupItemId.mainid or lookupItemId.itemId)
    end

    if not fallbackSlot then
        local lookupName = nil
        if type(lookupItemId) == "string" then
            lookupName = lookupItemId
        elseif type(lookupItemId) == "table" then
            lookupName = lookupItemId.name or lookupItemId.item or lookupItemId.itemName
        end

        if lookupName then
            for _, invItem in ipairs(getInventoryItems(source)) do
                local invName = invItem and (invItem.name or invItem.item or invItem.itemName)
                if invName == lookupName then
                    fallbackSlot = tonumber(invItem.slot or invItem.id or invItem.mainid or invItem.itemId)
                    if fallbackSlot then break end
                end
            end
        end
    end

    if not result and fallbackSlot then
        result = safeCall("SetItemMetadata v", function()
            return exports["v-inventory"]:SetItemMetadata(source, fallbackSlot, metadata or {})
        end, false) == true
    end

    invokeCallback(cb, result)
    return result
end

local function registerUsableItem(itemName, cbOrData)
    if not itemName or not cbOrData then
        print("^1[vorp_inventory bridge] registerUsableItem failed^0", tostring(itemName), type(cbOrData))
        return false
    end

    local originalCallback = cbOrData
    print("^2[vorp_inventory bridge] register usable item:^0", tostring(itemName), describeValue(originalCallback))

    local function resolveUsableCallback(callback)
        if isCallable(callback) then
            return callback
        end

        if type(callback) == "table" then
            local okIndex, tableCb = pcall(function()
                return callback.callback
                    or callback.cb
                    or callback.onUse
                    or callback.use
                    or callback.Use
            end)

            if okIndex and isCallable(tableCb) then
                return tableCb
            end
        end

        return nil
    end

    local function callUsableCallback(callback, source, item, data)
        local usableCb = resolveUsableCallback(callback)
        if not isCallable(usableCb) then
            return false, "missing-callback " .. describeValue(callback)
        end

        local attempts = {
            { "data", data },
            { "source-item", source, item },
            { "source-data", source, data },
        }

        local firstError = nil
        for _, attempt in ipairs(attempts) do
            local label = attempt[1]
            local ok, err = xpcall(function()
                return usableCb(table.unpack(attempt, 2))
            end, function(err)
                if debug and debug.traceback then
                    return debug.traceback(tostring(err), 2)
                end
                return tostring(err)
            end)

            if ok then
                if label ~= "data" then
                    debugPrint("usable callback signature", source, itemName, label)
                end
                return true, label
            end

            firstError = firstError or err
        end

        return false, firstError
    end

    local wrapperCallback = function(source, item)
        item = normalizeItem(item or {}, itemName) or { name = itemName, item = itemName, itemName = itemName, count = 1, amount = 1, metadata = {}, info = {} }

        local vorpData = {
            source = source,
            item = item,
            itemName = itemName,
            name = itemName,
            itemId = item.id or item.slot or itemName,
            id = item.id or item.slot,
            mainid = item.mainid or item.id or item.slot,
            metadata = item.metadata or item.info or {},
            info = item.info or item.metadata or {},
            amount = item.amount or item.count or 1,
            count = item.count or item.amount or 1,
            slot = item.slot
        }

        local ok, err = callUsableCallback(originalCallback, source, item, vorpData)
        if not ok then
            print("^1[vorp_inventory bridge] usable callback error for:^0", tostring(itemName), tostring(err))
        end
    end

    return safeCall("CreateUsableItem", function()
        return exports["rsg-inventory"]:CreateUsableItem(itemName, wrapperCallback)
    end, false) == true
end

local function getItemDB(itemName)
    local defs = safeCall("GetItemDefinitions", function()
        return exports["v-inventory"]:GetItemDefinitions()
    end, {}) or {}

    local mosquitoDefs = buildMosquitoItemDefinitions()

    if itemName then
        return defs[itemName] or mosquitoDefs[itemName]
    end

    for name, def in pairs(mosquitoDefs) do
        defs[name] = defs[name] or def
    end

    return defs
end

local function closeInventory(source)
    if source then
        TriggerClientEvent("rsg-inventory:client:closeInventory", source)
        TriggerClientEvent("v-inventory:client:CloseInventory", source)
    end
    return true
end

local function openInventory(source, invType, invId, data)
    TriggerEvent("inventory:server:OpenInventory", invType, invId, data)
    return true
end

VorpInventoryAPI.registerUsableItem = registerUsableItem
VorpInventoryAPI.RegisterUsableItem = registerUsableItem
VorpInventoryAPI.getItem = getItem
VorpInventoryAPI.GetItem = getItem
VorpInventoryAPI.getItemContainingMetadata = getItemContainingMetadata
VorpInventoryAPI.setItemMetadata = setItemMetadata
VorpInventoryAPI.SetItemMetadata = setItemMetadata
VorpInventoryAPI.getItemCount = getItemCount
VorpInventoryAPI.GetItemCount = getItemCount
VorpInventoryAPI.addItem = addItem
VorpInventoryAPI.AddItem = addItem
VorpInventoryAPI.subItem = subItem
VorpInventoryAPI.SubItem = subItem
VorpInventoryAPI.removeItem = subItem
VorpInventoryAPI.RemoveItem = subItem
VorpInventoryAPI.subItemById = subItemById
VorpInventoryAPI.SubItemById = subItemById
VorpInventoryAPI.canCarryItem = canCarryItem
VorpInventoryAPI.CanCarryItem = canCarryItem
VorpInventoryAPI.canCarryItems = canCarryItems
VorpInventoryAPI.CanCarryItems = canCarryItems
VorpInventoryAPI.getUserInventoryItems = getInventoryItems
VorpInventoryAPI.GetUserInventoryItems = getInventoryItems
VorpInventoryAPI.getUserInventory = getInventoryItems
VorpInventoryAPI.GetUserInventory = getInventoryItems
VorpInventoryAPI.getInventory = getInventoryItems
VorpInventoryAPI.GetInventory = getInventoryItems
VorpInventoryAPI.getItemDB = getItemDB
VorpInventoryAPI.GetItemDB = getItemDB
VorpInventoryAPI.closeInventory = closeInventory
VorpInventoryAPI.CloseInventory = closeInventory
VorpInventoryAPI.closeInv = closeInventory
VorpInventoryAPI.CloseInv = closeInventory
VorpInventoryAPI.openInventory = openInventory
VorpInventoryAPI.OpenInventory = openInventory
VorpInventoryAPI.addWeapon = function(source, weaponName, amount, metadata, cb, ...) return addItem(source, weaponName, amount or 1, metadata, cb, ...) end
VorpInventoryAPI.AddWeapon = VorpInventoryAPI.addWeapon
VorpInventoryAPI.subWeapon = function(source, weaponName, amount, cb, ...) return subItem(source, weaponName, amount or 1, nil, cb, ...) end
VorpInventoryAPI.SubWeapon = VorpInventoryAPI.subWeapon
VorpInventoryAPI.canCarryWeapons = function() return true end
VorpInventoryAPI.CanCarryWeapons = VorpInventoryAPI.canCarryWeapons
VorpInventoryAPI.getUserInventoryWeapons = function(source, cb)
    local weapons = {}
    for _, item in ipairs(getInventoryItems(source)) do
        if item.type == "item_weapon" or tostring(item.name):upper():find("WEAPON_", 1, true) then
            weapons[#weapons + 1] = item
        end
    end
    invokeCallback(cb, weapons)
    return weapons
end
VorpInventoryAPI.GetUserInventoryWeapons = VorpInventoryAPI.getUserInventoryWeapons

function vorp_inventoryApi()
    return VorpInventoryAPI
end

exports("vorp_inventoryApi", function() return VorpInventoryAPI end)

AddEventHandler("vorpCore:canCarryItems", canCarryItems)
AddEventHandler("vorpCore:canCarryItem", canCarryItem)

for exportName, fn in pairs(VorpInventoryAPI) do
    if type(fn) == "function" then
        exports(exportName, fn)
    end
end

print("^2[vorp_inventory bridge] server ready^0")
