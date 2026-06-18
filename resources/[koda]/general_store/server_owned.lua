local RSGCore = exports['rsg-core']:GetCoreObject()

local STORE_TABLE = 'general_store_owned_stores'
local ITEM_TABLE = 'general_store_owned_items'
local STAFF_TABLE = 'general_store_owned_staff'
local BUY_TABLE = 'general_store_owned_buy_items'

local ownedStores = {}
local ownedReady = false
local ROLE_LEVEL = { employee = 1, manager = 2, owner = 3 }

local function ownedEnabled()
    return Config.OwnedStores and Config.OwnedStores.enabled ~= false
end

local function notify(src, msg, msgType)
    if src == 0 then
        print(('[general_store] %s'):format(msg))
        return
    end
    TriggerClientEvent('chat:addMessage', src, {
        color = msgType == 'error' and { 255, 80, 80 } or { 220, 190, 120 },
        multiline = true,
        args = { 'General Store', msg },
    })
end

local function getCitizenId(src)
    local Player = RSGCore.Functions.GetPlayer(tonumber(src))
    return Player and Player.PlayerData and Player.PlayerData.citizenid or nil
end

local function isAdmin(src)
    if src == 0 then return true end
    local perm = (Config.OwnedStores and Config.OwnedStores.adminPermission) or 'admin'
    local ok, allowed = pcall(function()
        return RSGCore.Functions.HasPermission(src, perm)
    end)
    if ok and allowed then return true end
    return IsPlayerAceAllowed(src, ('general_store.%s'):format(perm)) or IsPlayerAceAllowed(src, 'command')
end

local function canManage(src, store)
    if not store then return false end
    if isAdmin(src) then return true end
    local cid = getCitizenId(src)
    if not cid then return false end
    if cid == store.owner then return true end
    return store.staff and store.staff[cid] ~= nil
end

local function getStoreRole(src, store)
    if not store then return nil end
    if isAdmin(src) then return 'owner' end
    local cid = getCitizenId(src)
    if not cid then return nil end
    if cid == store.owner then return 'owner' end
    local row = store.staff and store.staff[cid]
    return row and row.role or nil
end

local function hasRole(src, store, minRole)
    local role = getStoreRole(src, store)
    if not role then return false, nil end
    local needed = ROLE_LEVEL[minRole or 'employee'] or 1
    return (ROLE_LEVEL[role] or 0) >= needed, role
end

local function sanitizeStoreId(raw)
    if type(raw) ~= 'string' then return nil end
    local id = raw:lower():gsub('[^%w_%-]', '')
    if id == '' or #id > 60 then return nil end
    return 'owned_' .. id:gsub('^owned_', '')
end

local function clampPrice(raw)
    local price = tonumber(raw)
    if not price or price < 0 then return nil end
    return math.floor(price * 100 + 0.5) / 100
end

local function publicStore(store)
    return {
        id = store.id,
        label = store.label,
        logo = store.logo,
        description = store.description,
        moneyType = store.moneyType,
        blip = store.blip,
        npc = store.npc,
        categories = store.categories,
        items = store.items,
        owned = true,
    }
end

local function broadcastOwnedStore(store)
    TriggerClientEvent('general_store:client:ownedStoreUpsert', -1, store.id, publicStore(store))
end

local function makeOwnedStore(row)
    local blip = Config.OwnedStores.defaultBlip or {}
    local x = tonumber(row.x) or 0.0
    local y = tonumber(row.y) or 0.0
    local z = tonumber(row.z) or 0.0
    local h = tonumber(row.h) or 0.0
    return {
        id = row.id,
        owner = row.owner_citizenid,
        label = row.label or row.id,
        logo = row.logo or '',
        description = row.description or '',
        moneyType = row.money_type or Config.OwnedStores.defaultMoneyType or Config.DefaultMoneyType,
        balance = tonumber(row.balance) or 0,
        blip = {
            enabled = tonumber(row.blip_enabled) ~= 0,
            name = row.label or blip.name or 'Player Store',
            sprite = blip.sprite or Config.BlipSprite,
            scale = blip.scale or 0.2,
            style = blip.style or 1664425300,
        },
        npc = {
            model = row.ped_model or Config.OwnedStores.defaultPed,
            coords = vector4(x, y, z, h),
        },
        categories = {
            { id = 'all', label = 'All' },
            { id = 'owner_stock', label = 'Owner Stock' },
        },
        items = {},
        buyItems = {},
        staff = {},
        owned = true,
    }
end

local function defaultCatalogMeta(itemName)
    itemName = tostring(itemName or ''):lower()
    if itemName == '' then return {} end

    for _, store in pairs(Config.Stores or {}) do
        for _, row in ipairs(store.items or {}) do
            if tostring(row.item or ''):lower() == itemName then
                local prop = row.prop or row.propModel
                return {
                    image = row.image,
                    category = row.category,
                    prop = prop,
                    propType = row.propType or (prop and 'object' or nil),
                }
            end
        end
    end

    return {}
end

local function nilIfBlank(value)
    if value == nil or value == '' then return nil end
    return value
end

local function resolvedCategory(itemName, storedCategory, meta)
    meta = meta or defaultCatalogMeta(itemName)
    local stored = nilIfBlank(storedCategory)
    if stored and stored ~= 'owner_stock' and stored ~= 'sell_to_store' then
        return stored
    end
    return nilIfBlank(meta.category) or stored or 'owner_stock'
end

local function loadOwnedStores()
    if not ownedEnabled() then return end
    ownedReady = false
    MySQL.query(('SELECT * FROM `%s` WHERE enabled = 1'):format(STORE_TABLE), {}, function(rows)
        ownedStores = {}
        for _, row in ipairs(rows or {}) do
            ownedStores[row.id] = makeOwnedStore(row)
        end

        MySQL.query(('SELECT * FROM `%s`'):format(ITEM_TABLE), {}, function(itemRows)
            for _, row in ipairs(itemRows or {}) do
                local store = ownedStores[row.store_id]
                if store then
                    local meta = defaultCatalogMeta(row.item_name)
                    store.items[#store.items + 1] = {
                        item = row.item_name,
                        stock = tonumber(row.stock) or 0,
                        price = tonumber(row.price) or 0,
                        category = resolvedCategory(row.item_name, row.category, meta),
                        image = row.image or meta.image,
                        prop = nilIfBlank(row.prop) or meta.prop,
                        propType = nilIfBlank(row.prop_type) or meta.propType,
                    }
                end
            end

            MySQL.query(('SELECT * FROM `%s`'):format(STAFF_TABLE), {}, function(staffRows)
                for _, row in ipairs(staffRows or {}) do
                    local store = ownedStores[row.store_id]
                    local role = row.role == 'manager' and 'manager' or 'employee'
                    if store and row.citizenid and row.citizenid ~= store.owner then
                        store.staff[row.citizenid] = {
                            citizenid = row.citizenid,
                            role = role,
                            name = row.name or row.citizenid,
                        }
                    end
                end

                MySQL.query(('SELECT * FROM `%s` WHERE enabled = 1'):format(BUY_TABLE), {}, function(buyRows)
                    for _, row in ipairs(buyRows or {}) do
                        local store = ownedStores[row.store_id]
                        local itemName = row.item_name and tostring(row.item_name):lower() or nil
                        if store and itemName and itemName ~= '' then
                            store.buyItems[itemName] = {
                                item = itemName,
                                price = tonumber(row.price) or 0,
                            }
                        end
                    end

                    local count = 0
                    for _ in pairs(ownedStores) do count = count + 1 end
                    ownedReady = true
                    print(('[general_store] Owned stores ready - %d loaded.'):format(count))
                end)
            end)
        end)
    end)
end

local function ensureStoreColumn(columnName, ddl, done)
    MySQL.query(('SHOW COLUMNS FROM `%s` LIKE ?'):format(STORE_TABLE), { columnName }, function(rows)
        if rows and rows[1] then
            done()
            return
        end
        MySQL.query(('ALTER TABLE `%s` ADD COLUMN %s'):format(STORE_TABLE, ddl), {}, done)
    end)
end

AddEventHandler('onResourceStart', function(resourceName)
    if resourceName ~= GetCurrentResourceName() or not ownedEnabled() then return end
    MySQL.query(([[
        CREATE TABLE IF NOT EXISTS `%s` (
            `id` VARCHAR(60) NOT NULL,
            `owner_citizenid` VARCHAR(60) NOT NULL,
            `label` VARCHAR(80) NOT NULL,
            `money_type` VARCHAR(20) NOT NULL DEFAULT 'cash',
            `balance` DECIMAL(12,2) NOT NULL DEFAULT 0.00,
            `ped_model` VARCHAR(80) NOT NULL,
            `x` DOUBLE NOT NULL,
            `y` DOUBLE NOT NULL,
            `z` DOUBLE NOT NULL,
            `h` DOUBLE NOT NULL DEFAULT 0,
            `blip_enabled` TINYINT(1) NOT NULL DEFAULT 1,
            `enabled` TINYINT(1) NOT NULL DEFAULT 1,
            PRIMARY KEY (`id`),
            KEY `owner_citizenid` (`owner_citizenid`)
        ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
    ]]):format(STORE_TABLE), {}, function()
        ensureStoreColumn('logo', '`logo` VARCHAR(255) NULL', function()
            ensureStoreColumn('description', '`description` VARCHAR(255) NULL', function()
                MySQL.query(([[ 
                    CREATE TABLE IF NOT EXISTS `%s` (
                        `store_id` VARCHAR(60) NOT NULL,
                        `item_name` VARCHAR(80) NOT NULL,
                        `price` DECIMAL(10,2) NOT NULL DEFAULT 0.00,
                        `stock` INT NOT NULL DEFAULT 0,
                        `category` VARCHAR(40) NOT NULL DEFAULT 'owner_stock',
                        `image` VARCHAR(120) NULL,
                        `prop` VARCHAR(120) NULL,
                        `prop_type` VARCHAR(20) NULL,
                        PRIMARY KEY (`store_id`, `item_name`)
                    ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
                ]]):format(ITEM_TABLE), {}, function()
                    MySQL.query(([[ 
                        CREATE TABLE IF NOT EXISTS `%s` (
                            `store_id` VARCHAR(60) NOT NULL,
                            `citizenid` VARCHAR(60) NOT NULL,
                        `role` VARCHAR(20) NOT NULL DEFAULT 'employee',
                        `name` VARCHAR(80) NULL,
                        PRIMARY KEY (`store_id`, `citizenid`)
                    ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
                    ]]):format(STAFF_TABLE), {}, function()
                        MySQL.query(([[ 
                            CREATE TABLE IF NOT EXISTS `%s` (
                                `store_id` VARCHAR(60) NOT NULL,
                                `item_name` VARCHAR(80) NOT NULL,
                                `price` DECIMAL(10,2) NOT NULL DEFAULT 0.00,
                                `enabled` TINYINT(1) NOT NULL DEFAULT 1,
                                PRIMARY KEY (`store_id`, `item_name`)
                            ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
                        ]]):format(BUY_TABLE), {}, loadOwnedStores)
                    end)
                end)
            end)
        end)
    end)
end)

function GS_IsOwnedStore(storeId)
    return ownedStores[storeId] ~= nil
end

function GS_GetOwnedStore(storeId)
    return ownedStores[storeId]
end

function GS_GetOwnedStoreRole(src, storeId)
    return getStoreRole(src, ownedStores[storeId])
end

function GS_GetOwnedStoreStockMap(storeId)
    local store = ownedStores[storeId]
    if not store then return nil end
    local out = {}
    for _, row in ipairs(store.items or {}) do
        out[row.item:lower()] = { current = tonumber(row.stock) or 0, max = tonumber(row.stock) or 0 }
    end
    return out
end

function GS_CheckOwnedStock(storeId, lines)
    local store = ownedStores[storeId]
    if not store then return true end
    local stock = {}
    for _, row in ipairs(store.items or {}) do
        stock[row.item:lower()] = tonumber(row.stock) or 0
    end
    for _, line in ipairs(lines or {}) do
        local item = line.item:lower()
        if (stock[item] or 0) < (line.qty or 1) then return false, item end
    end
    return true
end

function GS_CommitOwnedPurchase(storeId, lines, total)
    local store = ownedStores[storeId]
    if not store then return end
    local delta = {}
    for _, line in ipairs(lines or {}) do
        local item = line.item:lower()
        for _, row in ipairs(store.items or {}) do
            if row.item:lower() == item then
                row.stock = math.max(0, (tonumber(row.stock) or 0) - (line.qty or 1))
                delta[item] = row.stock
                MySQL.update(
                    ('UPDATE `%s` SET stock = ? WHERE store_id = ? AND item_name = ?'):format(ITEM_TABLE),
                    { row.stock, storeId, item }
                )
                break
            end
        end
    end
    store.balance = (tonumber(store.balance) or 0) + (tonumber(total) or 0)
    MySQL.update(('UPDATE `%s` SET balance = ? WHERE id = ?'):format(STORE_TABLE), { store.balance, storeId })
    if next(delta) then
        TriggerClientEvent('general_store:client:stockUpdate', -1, storeId, delta)
    end
    broadcastOwnedStore(store)
end

local function findStoreItem(store, itemName)
    itemName = tostring(itemName or ''):lower()
    for index, row in ipairs(store.items or {}) do
        if row.item:lower() == itemName then return row, index end
    end
    return nil, nil
end

local function playerDisplayName(Player)
    local data = Player and Player.PlayerData or {}
    local charinfo = data.charinfo or {}
    local name = ((charinfo.firstname or '') .. ' ' .. (charinfo.lastname or '')):gsub('^%s+', ''):gsub('%s+$', '')
    if name ~= '' then return name end
    return data.name or data.citizenid or 'Unknown'
end

local function buildInventory(src)
    local Player = RSGCore.Functions.GetPlayer(src)
    local list = {}
    if not Player then return list end

    for _, item in pairs(Player.PlayerData.items or {}) do
        if type(item) == 'table' then
            local name = tostring(item.name or item.item or item.itemName or ''):lower()
            local amount = tonumber(item.amount or item.count or item.quantity or item.qty) or 0
            local def = name ~= '' and RSGCore.Shared.Items[name] or nil
            if def and amount > 0 then
                local meta = defaultCatalogMeta(name)
                list[#list + 1] = {
                    item = def.name,
                    label = def.label or def.name,
                    amount = amount,
                    image = meta.image or (name .. '.png'),
                    category = resolvedCategory(name, nil, meta),
                    prop = meta.prop,
                    propModel = meta.prop,
                    propType = meta.propType,
                }
            end
        end
    end

    table.sort(list, function(a, b)
        return tostring(a.label):lower() < tostring(b.label):lower()
    end)
    return list
end

local function staffList(store)
    local list = {}
    for _, row in pairs(store.staff or {}) do
        list[#list + 1] = {
            citizenid = row.citizenid,
            role = row.role,
            name = row.name or row.citizenid,
        }
    end
    table.sort(list, function(a, b)
        return tostring(a.name):lower() < tostring(b.name):lower()
    end)
    return list
end

local function itemList(store)
    local list = {}
    for _, row in ipairs(store.items or {}) do
        local def = RSGCore.Shared.Items[row.item:lower()]
        local meta = defaultCatalogMeta(row.item)
        local prop = nilIfBlank(row.prop) or meta.prop
        list[#list + 1] = {
            item = row.item,
            label = def and def.label or row.item,
            stock = tonumber(row.stock) or 0,
            price = tonumber(row.price) or 0,
            image = row.image or meta.image or (row.item .. '.png'),
            category = resolvedCategory(row.item, row.category, meta),
            prop = prop,
            propModel = prop,
            propType = nilIfBlank(row.propType) or meta.propType or (prop and 'object' or nil),
        }
    end
    table.sort(list, function(a, b)
        return tostring(a.label):lower() < tostring(b.label):lower()
    end)
    return list
end

local function buyList(store)
    local list = {}
    for _, row in pairs(store.buyItems or {}) do
        local def = RSGCore.Shared.Items[row.item:lower()]
        local meta = defaultCatalogMeta(row.item)
        list[#list + 1] = {
            item = row.item,
            label = def and def.label or row.item,
            price = tonumber(row.price) or 0,
            image = meta.image or (row.item .. '.png'),
            category = resolvedCategory(row.item, nil, meta),
            prop = meta.prop,
            propModel = meta.prop,
            propType = meta.propType,
        }
    end
    table.sort(list, function(a, b)
        return tostring(a.label):lower() < tostring(b.label):lower()
    end)
    return list
end

local function addStoreStock(store, itemName, qty, salePrice, image)
    local row = findStoreItem(store, itemName)
    local meta = defaultCatalogMeta(itemName)
    local price = clampPrice(salePrice) or 0
    image = tostring(image or meta.image or (itemName .. '.png')):sub(1, 120)

    if row then
        row.stock = (tonumber(row.stock) or 0) + qty
        price = tonumber(row.price) or price
        row.category = resolvedCategory(itemName, row.category, meta)
        row.prop = nilIfBlank(row.prop) or meta.prop
        row.propType = nilIfBlank(row.propType) or meta.propType
    else
        row = {
            item = itemName,
            stock = qty,
            price = price,
            category = resolvedCategory(itemName, nil, meta),
            image = image,
            prop = meta.prop,
            propType = meta.propType,
        }
        store.items[#store.items + 1] = row
    end

    MySQL.insert(
        ('INSERT INTO `%s` (store_id, item_name, price, stock, category, image, prop, prop_type) VALUES (?, ?, ?, ?, ?, ?, ?, ?) ON DUPLICATE KEY UPDATE stock = stock + VALUES(stock), category = VALUES(category), prop = IF(prop IS NULL OR prop = "", VALUES(prop), prop), prop_type = IF(prop_type IS NULL OR prop_type = "", VALUES(prop_type), prop_type)'):format(ITEM_TABLE),
        { store.id, itemName, price, qty, resolvedCategory(itemName, nil, meta), image, meta.prop or '', meta.propType or '' }
    )
    TriggerClientEvent('general_store:client:stockUpdate', -1, store.id, { [itemName] = row.stock })
    broadcastOwnedStore(store)
    return row
end

local function buildManagementPayload(src, store)
    local role = getStoreRole(src, store)
    if not role then return nil end
    local level = ROLE_LEVEL[role] or 0
    return {
        storeId = store.id,
        role = role,
        canEditDetails = level >= ROLE_LEVEL.manager,
        canManageStock = level >= ROLE_LEVEL.employee,
        canWithdraw = level >= ROLE_LEVEL.manager,
        canHire = level >= ROLE_LEVEL.manager,
        details = {
            label = store.label,
            logo = store.logo or '',
            description = store.description or '',
            balance = tonumber(store.balance) or 0,
            moneyType = store.moneyType or 'cash',
        },
        items = itemList(store),
        buyItems = buyList(store),
        inventory = buildInventory(src),
        staff = staffList(store),
    }
end

function GS_GetOwnedManagementPayload(src, storeId)
    local store = ownedStores[storeId]
    if not store then return nil end
    return buildManagementPayload(src, store)
end

function GS_GetOwnedBuyCatalog(src, storeId)
    local store = ownedStores[storeId]
    if not store then return {} end

    local inventory = buildInventory(src)
    local out = {}
    for _, inv in ipairs(inventory) do
        local wanted = store.buyItems and store.buyItems[inv.item:lower()]
        if wanted and tonumber(wanted.price) and tonumber(wanted.price) > 0 then
            local meta = defaultCatalogMeta(inv.item)
            local image = meta.image or inv.image or (inv.item .. '.png')
            out[#out + 1] = {
                item = inv.item,
                label = inv.label,
                description = 'The store is buying this item.',
                price = tonumber(wanted.price) or 0,
                category = resolvedCategory(inv.item, inv.category, meta),
                thumbnail = ('nui://%s/html/images/%s'):format(GetCurrentResourceName(), image),
                image = image,
                prop = meta.prop,
                propModel = meta.prop,
                propType = meta.propType,
                stock = inv.amount,
                amount = inv.amount,
                sellMode = true,
            }
        end
    end
    return out
end

local function cbManagement(src, cb, store)
    cb({ ok = true, payload = buildManagementPayload(src, store) })
end

RSGCore.Functions.CreateCallback('general_store:server:getOwnedStores', function(_, cb)
    local deadline = GetGameTimer() + 5000
    while ownedEnabled() and not ownedReady and GetGameTimer() < deadline do
        Wait(100)
    end

    local list = {}
    for _, store in pairs(ownedStores) do
        list[#list + 1] = publicStore(store)
    end
    cb(list)
end)

RSGCore.Functions.CreateCallback('general_store:server:getOwnedManagement', function(src, cb, storeId)
    local store = ownedStores[storeId]
    if not store then cb({ ok = false, error = 'not_owned_store' }) return end
    if not getStoreRole(src, store) then cb({ ok = false, error = 'access_denied' }) return end
    cbManagement(src, cb, store)
end)

RSGCore.Functions.CreateCallback('general_store:server:updateOwnedDetails', function(src, cb, data)
    local store = ownedStores[data and data.storeId]
    local allowed = store and hasRole(src, store, 'manager')
    if not allowed then cb({ ok = false, error = 'access_denied' }) return end

    local label = tostring(data.label or store.label):sub(1, 80)
    local logo = tostring(data.logo or ''):sub(1, 255)
    local description = tostring(data.description or ''):sub(1, 255)
    if label:gsub('%s+', '') == '' then label = store.label end

    store.label = label
    store.logo = logo
    store.description = description
    if store.blip then store.blip.name = label end

    MySQL.update(
        ('UPDATE `%s` SET label = ?, logo = ?, description = ? WHERE id = ?'):format(STORE_TABLE),
        { label, logo, description, store.id }
    )
    broadcastOwnedStore(store)
    cbManagement(src, cb, store)
end)

RSGCore.Functions.CreateCallback('general_store:server:addOwnedStock', function(src, cb, data)
    local store = ownedStores[data and data.storeId]
    local allowed = store and hasRole(src, store, 'employee')
    if not allowed then cb({ ok = false, error = 'access_denied' }) return end

    local itemName = tostring(data.item or ''):lower()
    local qty = math.floor(tonumber(data.qty) or 0)
    local price = clampPrice(data.price)
    local meta = defaultCatalogMeta(itemName)
    local image = tostring(data.image or meta.image or (itemName .. '.png')):sub(1, 120)
    if itemName == '' or qty < 1 or not price then cb({ ok = false, error = 'bad_input' }) return end
    local def = RSGCore.Shared.Items[itemName]
    if not def then cb({ ok = false, error = 'unknown_item' }) return end

    local count = exports['rsg-inventory']:GetItemCount(src, itemName) or 0
    if count < qty then cb({ ok = false, error = 'not_enough_items' }) return end
    if not exports['rsg-inventory']:RemoveItem(src, itemName, qty, nil) then
        cb({ ok = false, error = 'remove_failed' })
        return
    end

    local found = findStoreItem(store, itemName)
    if found then
        found.stock = (tonumber(found.stock) or 0) + qty
        found.price = price
        found.image = image
        found.category = resolvedCategory(itemName, found.category, meta)
        found.prop = nilIfBlank(found.prop) or meta.prop
        found.propType = nilIfBlank(found.propType) or meta.propType
    else
        found = {
            item = itemName,
            stock = qty,
            price = price,
            category = resolvedCategory(itemName, nil, meta),
            image = image,
            prop = meta.prop,
            propType = meta.propType,
        }
        store.items[#store.items + 1] = found
    end

    MySQL.insert(
        ('INSERT INTO `%s` (store_id, item_name, price, stock, category, image, prop, prop_type) VALUES (?, ?, ?, ?, ?, ?, ?, ?) ON DUPLICATE KEY UPDATE price = VALUES(price), stock = stock + VALUES(stock), category = VALUES(category), image = VALUES(image), prop = IF(prop IS NULL OR prop = "", VALUES(prop), prop), prop_type = IF(prop_type IS NULL OR prop_type = "", VALUES(prop_type), prop_type)'):format(ITEM_TABLE),
        { store.id, itemName, price, qty, resolvedCategory(itemName, nil, meta), image, meta.prop or '', meta.propType or '' }
    )
    TriggerClientEvent('general_store:client:stockUpdate', -1, store.id, { [itemName] = found.stock })
    broadcastOwnedStore(store)
    cbManagement(src, cb, store)
end)

RSGCore.Functions.CreateCallback('general_store:server:updateOwnedItem', function(src, cb, data)
    local store = ownedStores[data and data.storeId]
    local allowed = store and hasRole(src, store, 'manager')
    if not allowed then cb({ ok = false, error = 'access_denied' }) return end

    local itemName = tostring(data.item or ''):lower()
    local row = store and findStoreItem(store, itemName)
    local price = clampPrice(data.price)
    if not row or not price then cb({ ok = false, error = 'bad_input' }) return end
    row.price = price
    row.image = tostring(data.image or row.image or (itemName .. '.png')):sub(1, 120)

    MySQL.update(
        ('UPDATE `%s` SET price = ?, image = ? WHERE store_id = ? AND item_name = ?'):format(ITEM_TABLE),
        { row.price, row.image, store.id, itemName }
    )
    broadcastOwnedStore(store)
    cbManagement(src, cb, store)
end)

RSGCore.Functions.CreateCallback('general_store:server:removeOwnedItem', function(src, cb, data)
    local store = ownedStores[data and data.storeId]
    local allowed = store and hasRole(src, store, 'manager')
    if not allowed then cb({ ok = false, error = 'access_denied' }) return end

    local itemName = tostring(data.item or ''):lower()
    local row, index = findStoreItem(store, itemName)
    if not row then cb({ ok = false, error = 'bad_input' }) return end

    local stock = tonumber(row.stock) or 0
    if stock > 0 then
        local Player = RSGCore.Functions.GetPlayer(src)
        if not Player then cb({ ok = false, error = 'no_player' }) return end
        local can = exports['rsg-inventory']:CanAddItem(src, itemName, stock)
        if can == false then cb({ ok = false, error = 'inventory_full' }) return end
        Player.Functions.AddItem(itemName, stock, nil, {}, 'owned-general-store-pull-stock')
    end

    table.remove(store.items, index)
    MySQL.update(('DELETE FROM `%s` WHERE store_id = ? AND item_name = ?'):format(ITEM_TABLE), { store.id, itemName })
    TriggerClientEvent('general_store:client:stockUpdate', -1, store.id, { [itemName] = 0 })
    broadcastOwnedStore(store)
    cbManagement(src, cb, store)
end)

RSGCore.Functions.CreateCallback('general_store:server:withdrawOwnedRegister', function(src, cb, storeId)
    local store = ownedStores[storeId]
    local allowed = store and hasRole(src, store, 'manager')
    if not allowed then cb({ ok = false, error = 'access_denied' }) return end

    local amount = tonumber(store.balance) or 0
    if amount <= 0 then cb({ ok = false, error = 'empty_register' }) return end
    local Player = RSGCore.Functions.GetPlayer(src)
    if not Player then cb({ ok = false, error = 'no_player' }) return end

    store.balance = 0
    MySQL.update(('UPDATE `%s` SET balance = 0 WHERE id = ?'):format(STORE_TABLE), { store.id })
    Player.Functions.AddMoney(store.moneyType or 'cash', amount, 'owned-general-store-withdraw')
    cbManagement(src, cb, store)
end)

RSGCore.Functions.CreateCallback('general_store:server:depositOwnedRegister', function(src, cb, data)
    local store = ownedStores[data and data.storeId]
    local allowed = store and hasRole(src, store, 'manager')
    if not allowed then cb({ ok = false, error = 'access_denied' }) return end

    local amount = math.floor((tonumber(data.amount) or 0) * 100 + 0.5) / 100
    if amount <= 0 then cb({ ok = false, error = 'bad_input' }) return end

    local Player = RSGCore.Functions.GetPlayer(src)
    if not Player then cb({ ok = false, error = 'no_player' }) return end
    local moneyType = (store.moneyType or 'cash'):lower()
    local balance = Player.Functions.GetMoney(moneyType)
    if balance == false or balance < amount then cb({ ok = false, error = 'no_money' }) return end
    if not Player.Functions.RemoveMoney(moneyType, amount, 'owned-general-store-deposit') then
        cb({ ok = false, error = 'pay_failed' })
        return
    end

    store.balance = (tonumber(store.balance) or 0) + amount
    MySQL.update(('UPDATE `%s` SET balance = ? WHERE id = ?'):format(STORE_TABLE), { store.balance, store.id })
    cbManagement(src, cb, store)
end)

RSGCore.Functions.CreateCallback('general_store:server:updateOwnedBuyItem', function(src, cb, data)
    local store = ownedStores[data and data.storeId]
    local allowed = store and hasRole(src, store, 'manager')
    if not allowed then cb({ ok = false, error = 'access_denied' }) return end

    local itemName = tostring(data.item or ''):lower()
    local price = clampPrice(data.price)
    if itemName == '' or not price or price <= 0 then cb({ ok = false, error = 'bad_input' }) return end
    local def = RSGCore.Shared.Items[itemName]
    if not def then cb({ ok = false, error = 'unknown_item' }) return end

    store.buyItems[itemName] = { item = itemName, price = price }
    MySQL.insert(
        ('INSERT INTO `%s` (store_id, item_name, price, enabled) VALUES (?, ?, ?, 1) ON DUPLICATE KEY UPDATE price = VALUES(price), enabled = 1'):format(BUY_TABLE),
        { store.id, itemName, price }
    )
    cbManagement(src, cb, store)
end)

RSGCore.Functions.CreateCallback('general_store:server:removeOwnedBuyItem', function(src, cb, data)
    local store = ownedStores[data and data.storeId]
    local allowed = store and hasRole(src, store, 'manager')
    if not allowed then cb({ ok = false, error = 'access_denied' }) return end

    local itemName = tostring(data.item or ''):lower()
    if itemName == '' or not store.buyItems[itemName] then cb({ ok = false, error = 'bad_input' }) return end

    store.buyItems[itemName] = nil
    MySQL.update(('DELETE FROM `%s` WHERE store_id = ? AND item_name = ?'):format(BUY_TABLE), { store.id, itemName })
    cbManagement(src, cb, store)
end)

RSGCore.Functions.CreateCallback('general_store:server:sellToOwnedStore', function(src, cb, data)
    local store = ownedStores[data and data.storeId]
    if not store then cb({ ok = false, error = 'not_owned_store' }) return end

    local Player = RSGCore.Functions.GetPlayer(src)
    if not Player then cb({ ok = false, error = 'no_player' }) return end
    if type(data.cart) ~= 'table' or #data.cart == 0 then cb({ ok = false, error = 'empty' }) return end

    local lines = {}
    local total = 0.0
    for _, line in ipairs(data.cart) do
        local itemName = tostring(line.item or ''):lower()
        local qty = math.floor(tonumber(line.qty) or 0)
        local wanted = store.buyItems and store.buyItems[itemName]
        local def = RSGCore.Shared.Items[itemName]
        if itemName == '' or qty < 1 or qty > 500 or not wanted or not def then
            cb({ ok = false, error = 'not_buying' })
            return
        end
        local unit = tonumber(wanted.price) or 0
        if unit <= 0 then cb({ ok = false, error = 'not_buying' }) return end
        local count = exports['rsg-inventory']:GetItemCount(src, itemName) or 0
        if count < qty then cb({ ok = false, error = 'not_enough_items' }) return end
        total = total + (unit * qty)
        lines[#lines + 1] = { item = def.name, qty = qty, unit = unit, image = itemName .. '.png' }
    end

    if total <= 0 then cb({ ok = false, error = 'empty' }) return end
    if (tonumber(store.balance) or 0) < total then cb({ ok = false, error = 'store_no_money' }) return end

    for _, line in ipairs(lines) do
        if not exports['rsg-inventory']:RemoveItem(src, line.item, line.qty, nil) then
            cb({ ok = false, error = 'remove_failed' })
            return
        end
    end

    store.balance = (tonumber(store.balance) or 0) - total
    MySQL.update(('UPDATE `%s` SET balance = ? WHERE id = ?'):format(STORE_TABLE), { store.balance, store.id })
    for _, line in ipairs(lines) do
        addStoreStock(store, line.item, line.qty, line.unit, line.image)
    end
    Player.Functions.AddMoney(store.moneyType or 'cash', total, 'owned-general-store-bought-items')
    cb({
        ok = true,
        balance = Player.Functions.GetMoney((store.moneyType or 'cash'):lower()),
        storeBalance = store.balance,
        buyCatalog = GS_GetOwnedBuyCatalog(src, store.id),
        payload = buildManagementPayload(src, store),
    })
end)

RSGCore.Functions.CreateCallback('general_store:server:hireOwnedStaff', function(src, cb, data)
    local store = ownedStores[data and data.storeId]
    local allowed, actorRole = false, nil
    if store then allowed, actorRole = hasRole(src, store, 'manager') end
    if not allowed then cb({ ok = false, error = 'access_denied' }) return end

    local targetId = tonumber(data.targetId)
    local Target = targetId and RSGCore.Functions.GetPlayer(targetId)
    if not Target then cb({ ok = false, error = 'player_not_found' }) return end
    local cid = Target.PlayerData.citizenid
    if not cid or cid == store.owner then cb({ ok = false, error = 'cannot_hire_owner' }) return end

    local role = data.role == 'manager' and 'manager' or 'employee'
    if actorRole ~= 'owner' and role == 'manager' then
        cb({ ok = false, error = 'owner_only_manager' })
        return
    end

    local name = playerDisplayName(Target)
    store.staff[cid] = { citizenid = cid, role = role, name = name }
    MySQL.insert(
        ('INSERT INTO `%s` (store_id, citizenid, role, name) VALUES (?, ?, ?, ?) ON DUPLICATE KEY UPDATE role = VALUES(role), name = VALUES(name)'):format(STAFF_TABLE),
        { store.id, cid, role, name }
    )
    notify(targetId, ('You were hired at %s as %s.'):format(store.label, role), 'success')
    cbManagement(src, cb, store)
end)

RSGCore.Functions.CreateCallback('general_store:server:fireOwnedStaff', function(src, cb, data)
    local store = ownedStores[data and data.storeId]
    local allowed, actorRole = false, nil
    if store then allowed, actorRole = hasRole(src, store, 'manager') end
    if not allowed then cb({ ok = false, error = 'access_denied' }) return end

    local cid = tostring(data.citizenid or '')
    local row = store.staff and store.staff[cid]
    if not row then cb({ ok = false, error = 'not_staff' }) return end
    if actorRole ~= 'owner' and row.role == 'manager' then cb({ ok = false, error = 'owner_only_manager' }) return end

    store.staff[cid] = nil
    MySQL.update(('DELETE FROM `%s` WHERE store_id = ? AND citizenid = ?'):format(STAFF_TABLE), { store.id, cid })
    cbManagement(src, cb, store)
end)

local commands = Config.OwnedStores and Config.OwnedStores.commands or {}

RSGCore.Commands.Add(commands.create or 'gscreateowned', 'Create an owned general store', {
    { name = 'playerId', help = 'Owner server id' },
    { name = 'store_id', help = 'Short id, example: valentine_player_market' },
    { name = 'name', help = 'Store name' },
}, true, function(source, args)
    if not isAdmin(source) then notify(source, 'You do not have permission.', 'error') return end
    local target = tonumber(args[1])
    local TargetPlayer = target and RSGCore.Functions.GetPlayer(target)
    if not TargetPlayer then notify(source, 'Owner player not found.', 'error') return end
    local id = sanitizeStoreId(args[2])
    if not id then notify(source, 'Invalid store id.', 'error') return end
    if ownedStores[id] or (Config.Stores and Config.Stores[id]) then notify(source, 'That store id already exists.', 'error') return end

    local nameParts = {}
    for i = 3, #args do nameParts[#nameParts + 1] = args[i] end
    local label = table.concat(nameParts, ' ')
    if label == '' then label = 'Player General Store' end

    local ped = GetPlayerPed(source)
    local coords = GetEntityCoords(ped)
    local heading = GetEntityHeading(ped)
    local owner = TargetPlayer.PlayerData.citizenid
    local model = Config.OwnedStores.defaultPed
    local moneyType = Config.OwnedStores.defaultMoneyType or Config.DefaultMoneyType

    MySQL.insert(
        ('INSERT INTO `%s` (id, owner_citizenid, label, money_type, ped_model, x, y, z, h, blip_enabled) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)'):format(STORE_TABLE),
        { id, owner, label, moneyType, model, coords.x, coords.y, coords.z, heading, 1 },
        function()
            ownedStores[id] = makeOwnedStore({
                id = id,
                owner_citizenid = owner,
                label = label,
                money_type = moneyType,
                balance = 0,
                ped_model = model,
                x = coords.x,
                y = coords.y,
                z = coords.z,
                h = heading,
                blip_enabled = 1,
            })
            broadcastOwnedStore(ownedStores[id])
            notify(source, ('Created %s for %s.'):format(label, owner), 'success')
            if target ~= source then notify(target, ('You now own %s.'):format(label), 'success') end
        end
    )
end, 'admin')

RSGCore.Commands.Add(commands.setOwner or 'gssetowner', 'Transfer an owned general store to an online player', {
    { name = 'store_id', help = 'Owned store id' },
    { name = 'playerId', help = 'New owner server id' },
}, true, function(source, args)
    if not isAdmin(source) then notify(source, 'You do not have permission.', 'error') return end

    local id = sanitizeStoreId(args[1])
    local store = id and ownedStores[id]
    if not store then notify(source, 'Owned store not found.', 'error') return end

    local target = tonumber(args[2])
    local TargetPlayer = target and RSGCore.Functions.GetPlayer(target)
    if not TargetPlayer then notify(source, 'New owner player not found.', 'error') return end

    local owner = TargetPlayer.PlayerData.citizenid
    if not owner or owner == '' then notify(source, 'New owner citizenid not found.', 'error') return end

    store.owner = owner
    if store.staff then store.staff[owner] = nil end

    MySQL.update(('UPDATE `%s` SET owner_citizenid = ? WHERE id = ?'):format(STORE_TABLE), { owner, id })
    MySQL.update(('DELETE FROM `%s` WHERE store_id = ? AND citizenid = ?'):format(STAFF_TABLE), { id, owner })
    notify(source, ('%s owner is now %s.'):format(store.label, owner), 'success')
    if target ~= source then notify(target, ('You now own %s.'):format(store.label), 'success') end
end, 'admin')

RSGCore.Commands.Add(commands.addStock or 'gsaddstock', 'Add inventory items to an owned general store', {
    { name = 'store_id', help = 'Owned store id' },
    { name = 'item', help = 'Item name' },
    { name = 'qty', help = 'Quantity' },
    { name = 'price', help = 'Unit price' },
}, true, function(source, args)
    local id = sanitizeStoreId(args[1])
    local store = id and ownedStores[id]
    if not canManage(source, store) then notify(source, 'You do not own or manage that store.', 'error') return end
    local itemName = tostring(args[2] or ''):lower()
    local qty = math.floor(tonumber(args[3]) or 0)
    local price = clampPrice(args[4])
    local meta = defaultCatalogMeta(itemName)
    if itemName == '' or qty < 1 or not price then notify(source, 'Usage: /gsaddstock <store_id> <item> <qty> <price>', 'error') return end
    local def = RSGCore.Shared.Items[itemName]
    if not def then notify(source, 'Unknown item.', 'error') return end
    local count = exports['rsg-inventory']:GetItemCount(source, itemName) or 0
    if count < qty then notify(source, ('You only have %s %s.'):format(count, itemName), 'error') return end
    if not exports['rsg-inventory']:RemoveItem(source, itemName, qty, nil) then
        notify(source, 'Could not remove item from inventory.', 'error')
        return
    end

    local found
    for _, row in ipairs(store.items) do
        if row.item:lower() == itemName then found = row break end
    end
    if found then
        found.stock = (tonumber(found.stock) or 0) + qty
        found.price = price
        found.category = resolvedCategory(itemName, found.category, meta)
    else
        found = {
            item = itemName,
            stock = qty,
            price = price,
            category = resolvedCategory(itemName, nil, meta),
            image = meta.image or (itemName .. '.png'),
        }
        store.items[#store.items + 1] = found
    end

    MySQL.insert(
        ('INSERT INTO `%s` (store_id, item_name, price, stock, category, image) VALUES (?, ?, ?, ?, ?, ?) ON DUPLICATE KEY UPDATE price = VALUES(price), stock = stock + VALUES(stock), category = VALUES(category), image = VALUES(image)'):format(ITEM_TABLE),
        { id, itemName, price, qty, resolvedCategory(itemName, nil, meta), found.image }
    )
    TriggerClientEvent('general_store:client:stockUpdate', -1, id, { [itemName] = found.stock })
    notify(source, ('Added %sx %s to %s at $%s.'):format(qty, def.label or itemName, store.label, price), 'success')
end, 'user')

RSGCore.Commands.Add(commands.withdraw or 'gswithdraw', 'Withdraw an owned general store register', {
    { name = 'store_id', help = 'Owned store id' },
}, true, function(source, args)
    local id = sanitizeStoreId(args[1])
    local store = id and ownedStores[id]
    local allowed = store and hasRole(source, store, 'manager')
    if not allowed then notify(source, 'You do not own or manage that register.', 'error') return end
    local amount = tonumber(store.balance) or 0
    if amount <= 0 then notify(source, 'The register is empty.', 'inform') return end
    local Player = RSGCore.Functions.GetPlayer(source)
    if not Player then return end
    store.balance = 0
    MySQL.update(('UPDATE `%s` SET balance = 0 WHERE id = ?'):format(STORE_TABLE), { id })
    Player.Functions.AddMoney(store.moneyType or 'cash', amount, 'owned-general-store-withdraw')
    notify(source, ('Withdrew $%s from %s.'):format(amount, store.label), 'success')
end, 'user')

RSGCore.Commands.Add(commands.info or 'gsstoreinfo', 'Show owned general store info', {
    { name = 'store_id', help = 'Owned store id' },
}, true, function(source, args)
    local id = sanitizeStoreId(args[1])
    local store = id and ownedStores[id]
    if not canManage(source, store) then notify(source, 'You do not own or manage that store.', 'error') return end
    local staffCount = 0
    for _ in pairs(store.staff or {}) do staffCount = staffCount + 1 end
    notify(source, ('%s | owner: %s | balance: $%s | items: %s | staff: %s'):format(
        store.label,
        store.owner or 'unknown',
        store.balance or 0,
        #(store.items or {}),
        staffCount
    ), 'inform')
end, 'user')
