print("^2[vorp_inventory bridge] server starting^0")

local VorpInventoryAPI = {}
local DebugVorpBridge = false

local function debugPrint(name, ...)
    if DebugVorpBridge then
        print(("^3[vorp_inventory bridge] %s^0"):format(name), ...)
    end
end

local function safeCall(label, fn, fallback)
    local ok, result = pcall(fn)
    if ok then return result end

    print(("^1[vorp_inventory bridge] %s error:^0 %s"):format(label, tostring(result)))
    return fallback
end

local function isEmptyTable(value)
    return type(value) ~= "table" or next(value) == nil
end

local function normalizeItem(item, forcedName)
    if type(item) ~= "table" then return nil end

    local name = item.name or item.item or item.itemName or forcedName
    if not name then return nil end

    local amount = tonumber(item.amount or item.count or item.quantity or item.qty or 1) or 1
    local metadata = item.metadata or item.info or {}
    local slot = tonumber(item.slot or item.id or item.mainid)

    item.name = name
    item.item = item.item or name
    item.itemName = item.itemName or name
    item.itemId = item.itemId or slot or name
    item.label = item.label or name
    item.amount = amount
    item.count = amount
    item.quantity = amount
    item.qty = amount
    item.metadata = metadata
    item.info = metadata
    item.slot = slot or item.slot
    item.id = item.id or slot
    item.mainid = item.mainid or item.id

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

local function getInventoryItems(source)
    if not source then return {} end

    local items = safeCall("GetInventory", function()
        return exports["rsg-inventory"]:GetInventory(source)
    end, {}) or {}

    local list = {}
    local seen = {}

    for _, item in ipairs(items) do
        local normalized = normalizeItem(item)
        if normalized then
            local key = tostring(normalized.slot or #list + 1) .. ":" .. normalized.name
            if not seen[key] then
                seen[key] = true
                list[#list + 1] = normalized
            end
        end
    end

    if #list == 0 then
        for _, item in pairs(items) do
            if type(item) == "table" then
                local normalized = normalizeItem(item)
                if normalized then
                    local key = tostring(normalized.slot or #list + 1) .. ":" .. normalized.name
                    if not seen[key] then
                        seen[key] = true
                        list[#list + 1] = normalized
                    end
                end
            end
        end
    end

    return list
end

local function getItemByName(source, itemName, metadata)
    if not source or not itemName then return nil end

    if isEmptyTable(metadata) then
        local item = safeCall("GetItemByName", function()
            return exports["rsg-inventory"]:GetItemByName(source, itemName)
        end)

        return normalizeItem(item, itemName)
    end

    for _, item in ipairs(getInventoryItems(source)) do
        if item.name == itemName and metadataMatches(item.metadata or item.info, metadata) then
            return normalizeItem(item, itemName)
        end
    end

    return nil
end

local function getItem(source, itemName, cbOrMetadata, maybeMetadata)
    debugPrint("getItem", source, itemName)

    local cb = nil
    local metadata = nil

    if type(cbOrMetadata) == "function" then
        cb = cbOrMetadata
        metadata = maybeMetadata
    elseif type(cbOrMetadata) == "table" then
        metadata = cbOrMetadata
    end

    local item = getItemByName(source, itemName, metadata)

    if cb then cb(item) end
    return item
end

local function getItemContainingMetadata(source, itemName, metadataOrCb, cbOrMetadata)
    debugPrint("getItemContainingMetadata", source, itemName)

    local metadata = type(metadataOrCb) == "table" and metadataOrCb or cbOrMetadata
    local cb = type(metadataOrCb) == "function" and metadataOrCb or cbOrMetadata
    if type(cb) ~= "function" then cb = nil end

    local item = getItemByName(source, itemName, metadata)

    if cb then cb(item) end
    return item
end

local function getItemCount(source, itemName)
    debugPrint("getItemCount", source, itemName)

    if not source or not itemName then return 0 end

    local count = safeCall("GetItemCount", function()
        return exports["rsg-inventory"]:GetItemCount(source, itemName)
    end, 0)

    return tonumber(count) or 0
end

local function canCarryItem(source, itemName, amount)
    debugPrint("canCarryItem", source, itemName, amount)

    local result = safeCall("CanAddItem", function()
        return exports["rsg-inventory"]:CanAddItem(source, itemName, amount or 1)
    end, true)

    if result == nil then return true end
    return result == true
end

local function addItem(source, itemName, amount, metadata)
    debugPrint("addItem", source, itemName, amount)

    if not source or not itemName then return false end

    return safeCall("AddItem", function()
        return exports["rsg-inventory"]:AddItem(source, itemName, amount or 1, nil, metadata or {})
    end, false) == true
end

local function subItem(source, itemName, amount, metadata)
    debugPrint("subItem", source, itemName, amount)

    if not source or not itemName then return false end

    local slot = nil
    if type(metadata) == "table" and not isEmptyTable(metadata) then
        local item = getItemByName(source, itemName, metadata)
        slot = item and item.slot or nil
    end

    return safeCall("RemoveItem", function()
        return exports["rsg-inventory"]:RemoveItem(source, itemName, amount or 1, slot)
    end, false) == true
end

local function subItemById(source, itemId, amount)
    debugPrint("subItemById", source, itemId, amount)

    local numericId = tonumber(itemId)
    if not source or not numericId then return false end

    for _, item in ipairs(getInventoryItems(source)) do
        if tonumber(item.slot or item.id or item.mainid) == numericId then
            return safeCall("RemoveItemById", function()
                return exports["rsg-inventory"]:RemoveItem(source, item.name, amount or 1, numericId)
            end, false) == true
        end
    end

    return false
end

local function setItemMetadata(source, itemId, metadata, amount, cb)
    debugPrint("setItemMetadata", source, itemId)

    if type(amount) == "function" and cb == nil then
        cb = amount
    end

    if type(itemId) == "table" then
        itemId = itemId.slot or itemId.id or itemId.mainid
    end

    local slot = tonumber(itemId)
    if not source or not slot then
        if type(cb) == "function" then cb(false) end
        return false
    end

    local result = safeCall("SetItemMetadata", function()
        return exports["v-inventory"]:SetItemMetadata(source, slot, metadata or {})
    end, false) == true

    if type(cb) == "function" then cb(result) end
    return result
end

local function registerUsableItem(itemName, cbOrData)
    if not itemName or not cbOrData then
        print("^1[vorp_inventory bridge] registerUsableItem failed^0", tostring(itemName), type(cbOrData))
        return false
    end

    local originalCallback = cbOrData
    print("^2[vorp_inventory bridge] register usable item:^0", tostring(itemName), type(originalCallback))

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

        local ok, err = pcall(function()
            if type(originalCallback) == "function" then
                originalCallback(vorpData)
                return
            end

            if type(originalCallback) == "table" then
                local okIndex, tableCb = pcall(function()
                    return originalCallback.callback
                        or originalCallback.cb
                        or originalCallback.onUse
                        or originalCallback.use
                        or originalCallback.Use
                end)

                if okIndex and type(tableCb) == "function" then
                    tableCb(vorpData)
                    return
                end
            end

            originalCallback(vorpData)
        end)

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

    return itemName and defs[itemName] or defs
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
VorpInventoryAPI.canCarryItems = canCarryItem
VorpInventoryAPI.CanCarryItems = canCarryItem
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
VorpInventoryAPI.openInventory = openInventory
VorpInventoryAPI.OpenInventory = openInventory
VorpInventoryAPI.addWeapon = function(source, weaponName, amount, metadata) return addItem(source, weaponName, amount or 1, metadata) end
VorpInventoryAPI.AddWeapon = VorpInventoryAPI.addWeapon
VorpInventoryAPI.subWeapon = function(source, weaponName, amount) return subItem(source, weaponName, amount or 1) end
VorpInventoryAPI.SubWeapon = VorpInventoryAPI.subWeapon
VorpInventoryAPI.canCarryWeapons = function() return true end
VorpInventoryAPI.CanCarryWeapons = VorpInventoryAPI.canCarryWeapons
VorpInventoryAPI.getUserInventoryWeapons = function(source)
    local weapons = {}
    for _, item in ipairs(getInventoryItems(source)) do
        if item.type == "item_weapon" or tostring(item.name):upper():find("WEAPON_", 1, true) then
            weapons[#weapons + 1] = item
        end
    end
    return weapons
end
VorpInventoryAPI.GetUserInventoryWeapons = VorpInventoryAPI.getUserInventoryWeapons

function vorp_inventoryApi()
    return VorpInventoryAPI
end

exports("vorp_inventoryApi", function() return VorpInventoryAPI end)

for exportName, fn in pairs(VorpInventoryAPI) do
    if type(fn) == "function" then
        exports(exportName, fn)
    end
end

print("^2[vorp_inventory bridge] server ready^0")
