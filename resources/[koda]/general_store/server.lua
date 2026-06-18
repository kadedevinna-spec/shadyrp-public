local RSGCore = exports['rsg-core']:GetCoreObject()

local RESOURCE = GetCurrentResourceName()

--- Basename-only PNG → `nui://<resource>/html/images/<file>`
local function storeThumbnailUrl(raw)
    if type(raw) ~= 'string' then return nil end
    local name = raw:gsub('\\', ''):gsub('/', '')
    if name == '' or name:find('%.%.') then return nil end
    if not name:lower():match('%.png$') then return nil end
    return ('nui://%s/html/images/%s'):format(RESOURCE, name)
end

local function resolveCatalogProp(row)
    return row.prop or row.propModel
end

--- Store catalog images come ONLY from config `image` → html/images/*. No inventory fallback.
local function resolveCatalogImage(row)
    if not row.image or row.image == '' then return nil end
    return storeThumbnailUrl(row.image)
end

local function getStore(storeId)
    if type(storeId) ~= 'string' then return nil end
    if GS_GetOwnedStore then
        local owned = GS_GetOwnedStore(storeId)
        if owned then return owned end
    end
    return Config.Stores[storeId]
end

local function validateCart(store, cart)
    if type(cart) ~= 'table' then return false, 'invalid_cart' end

    local priceMap = {}
    for _, r in ipairs(store.items or {}) do
        priceMap[r.item:lower()] = tonumber(r.price) or 0
    end

    local lines = {}
    local total = 0.0

    for _, line in ipairs(cart) do
        local name = line.item
        if type(name) ~= 'string' then return false, 'bad_item' end
        name = name:lower()
        local q = math.floor(tonumber(line.qty) or 0)
        if q < 1 or q > 500 then return false, 'bad_qty' end

        local unit = priceMap[name]
        if not unit or unit < 0 then return false, 'not_for_sale' end

        local def = RSGCore.Shared.Items[name]
        if not def then return false, 'unknown_item' end

        total = total + (unit * q)
        lines[#lines + 1] = { item = def.name, qty = q, unitPrice = unit }
    end

    if #lines == 0 or total <= 0 then return false, 'empty' end
    return true, lines, total
end

RSGCore.Functions.CreateCallback('general_store:server:getOpenPayload', function(source, cb, storeId)
    local store = getStore(storeId)
    local Player = RSGCore.Functions.GetPlayer(source)

    if not store or not Player then
        cb(nil)
        return
    end

    local moneyType = store.moneyType or Config.DefaultMoneyType
    local balance = Player.Functions.GetMoney(moneyType)
    if balance == false then balance = 0 end

    local stockMap
    if GS_GetOwnedStoreStockMap and GS_IsOwnedStore and GS_IsOwnedStore(storeId) then
        stockMap = GS_GetOwnedStoreStockMap(storeId)
    else
        stockMap = GS_GetStoreStockMap and GS_GetStoreStockMap(storeId) or nil
    end

    local catalog = {}
    for _, row in ipairs(store.items or {}) do
        local def = RSGCore.Shared.Items[row.item:lower()]
        if def then
            local prop = resolveCatalogProp(row)
            local thumbnail = resolveCatalogImage(row)
            if row.image and row.image ~= '' and not thumbnail then
                print(('^3[general_store]^0 Invalid image filename for %q in store %q: %s'):format(
                    row.item, storeId, tostring(row.image)
                ))
            end
            local stockEntry = stockMap and stockMap[def.name:lower()]
            catalog[#catalog + 1] = {
                item = def.name,
                label = def.label,
                description = def.description or '',
                price = tonumber(row.price) or 0,
                category = row.category,
                thumbnail = thumbnail,
                image = row.image,
                prop = prop,
                propModel = prop,
                propType = row.propType or (prop and 'object' or nil),
                propRotation = row.propRotation,
                stock    = stockEntry and stockEntry.current or nil,
                maxStock = stockEntry and stockEntry.max    or nil,
            }
        end
    end

    local management = nil
    local buyCatalog = {}
    if GS_IsOwnedStore and GS_IsOwnedStore(storeId) then
        local role = GS_GetOwnedStoreRole and GS_GetOwnedStoreRole(source, storeId) or nil
        buyCatalog = GS_GetOwnedBuyCatalog and GS_GetOwnedBuyCatalog(source, storeId) or {}
        if role then
            local managementPayload = GS_GetOwnedManagementPayload and GS_GetOwnedManagementPayload(source, storeId) or nil
            management = {
                canOpen = true,
                role = role,
                logo = store.logo or '',
                registerBalance = tonumber(store.balance) or 0,
                payload = managementPayload,
            }
        end
    end

    cb({
        storeId = storeId,
        title = store.label,
        logo = store.logo or '',
        owned = GS_IsOwnedStore and GS_IsOwnedStore(storeId) or false,
        management = management,
        buyCatalog = buyCatalog,
        moneyType = moneyType,
        balance = balance,
        categories = store.categories,
        catalog = catalog,
    })
end)

RSGCore.Functions.CreateCallback('general_store:server:getBalance', function(source, cb, moneyType)
    local Player = RSGCore.Functions.GetPlayer(source)
    if not Player then cb(0) return end
    moneyType = (moneyType or Config.DefaultMoneyType):lower()
    local bal = Player.Functions.GetMoney(moneyType)
    cb(bal == false and 0 or bal)
end)

RegisterNetEvent('general_store:server:purchase', function(storeId, cart)
    local src = source
    local store = getStore(storeId)
    local Player = RSGCore.Functions.GetPlayer(src)

    if not store or not Player then
        TriggerClientEvent('general_store:client:purchaseResult', src, false, 'unavailable', nil)
        return
    end

    local ok, linesOrKey, total = validateCart(store, cart)
    if not ok then
        TriggerClientEvent('general_store:client:purchaseResult', src, false, linesOrKey, nil)
        return
    end

    local lines, moneyType = linesOrKey, store.moneyType or Config.DefaultMoneyType
    moneyType = moneyType:lower()

    -- Stock check (before any money movement)
    if GS_CheckOwnedStock and GS_IsOwnedStore and GS_IsOwnedStore(storeId) then
        local stockOk = GS_CheckOwnedStock(storeId, lines)
        if not stockOk then
            TriggerClientEvent('general_store:client:purchaseResult', src, false, 'out_of_stock', nil)
            return
        end
    elseif GS_CheckStock then
        local stockOk, failItem = GS_CheckStock(storeId, lines)
        if not stockOk then
            TriggerClientEvent('general_store:client:purchaseResult', src, false, 'out_of_stock', nil)
            return
        end
    end

    for _, line in ipairs(lines) do
        local can, reason = exports['rsg-inventory']:CanAddItem(src, line.item, line.qty)
        if not can then
            TriggerClientEvent('general_store:client:purchaseResult', src, false, reason or 'inventory', nil)
            return
        end
    end

    local balance = Player.Functions.GetMoney(moneyType)
    if balance == false or balance < total then
        TriggerClientEvent('general_store:client:purchaseResult', src, false, 'no_money', balance)
        return
    end

    if not Player.Functions.RemoveMoney(moneyType, total, 'general-store') then
        TriggerClientEvent('general_store:client:purchaseResult', src, false, 'pay_failed', nil)
        return
    end

    for _, line in ipairs(lines) do
        local added = Player.Functions.AddItem(line.item, line.qty, nil, {}, 'general-store')
        if not added then
            Player.Functions.AddMoney(moneyType, total, 'general-store-refund')
            TriggerClientEvent('general_store:client:purchaseResult', src, false, 'give_failed', Player.Functions.GetMoney(moneyType))
            return
        end
    end

    -- Commit stock decrement only after all items are given successfully
    if GS_CommitOwnedPurchase and GS_IsOwnedStore and GS_IsOwnedStore(storeId) then
        GS_CommitOwnedPurchase(storeId, lines, total)
    elseif GS_CommitStock then
        GS_CommitStock(storeId, lines)
    end

    local newBal = Player.Functions.GetMoney(moneyType)
    TriggerClientEvent('general_store:client:purchaseResult', src, true, 'ok', newBal == false and 0 or newBal)
end)

RegisterNetEvent('general_store:server:buyShelfItem', function(storeId, itemName)
    local src = source
    if Config.EnableShelfPickups == false then
        TriggerClientEvent('general_store:client:shelfPurchaseResult', src, false, 'unavailable', nil, nil)
        return
    end

    local store = getStore(storeId)
    local Player = RSGCore.Functions.GetPlayer(src)

    if not store or not Player or type(itemName) ~= 'string' then
        TriggerClientEvent('general_store:client:shelfPurchaseResult', src, false, 'unavailable', nil, nil)
        return
    end

    itemName = itemName:lower()
    local row
    for _, r in ipairs(store.items or {}) do
        if r.item:lower() == itemName then
            row = r
            break
        end
    end

    local isOwnedStore = GS_IsOwnedStore and GS_IsOwnedStore(storeId)
    if not row or (not row.shelf and not isOwnedStore) then
        TriggerClientEvent('general_store:client:shelfPurchaseResult', src, false, 'not_for_sale', nil, nil)
        return
    end

    local def = RSGCore.Shared.Items[itemName]
    if not def then
        TriggerClientEvent('general_store:client:shelfPurchaseResult', src, false, 'unknown_item', nil, nil)
        return
    end

    local unit = tonumber(row.price) or 0
    if unit <= 0 then
        TriggerClientEvent('general_store:client:shelfPurchaseResult', src, false, 'not_for_sale', nil, nil)
        return
    end

    -- Stock check for shelf items
    if isOwnedStore and GS_CheckOwnedStock then
        local stockOk = GS_CheckOwnedStock(storeId, { { item = def.name, qty = 1 } })
        if not stockOk then
            TriggerClientEvent('general_store:client:shelfPurchaseResult', src, false, 'out_of_stock', nil, def.label)
            return
        end
    elseif GS_CheckStock then
        local stockOk = GS_CheckStock(storeId, { { item = def.name, qty = 1 } })
        if not stockOk then
            TriggerClientEvent('general_store:client:shelfPurchaseResult', src, false, 'out_of_stock', nil, def.label)
            return
        end
    end

    local moneyType = (store.moneyType or Config.DefaultMoneyType):lower()
    local can, reason = exports['rsg-inventory']:CanAddItem(src, def.name, 1)
    if not can then
        TriggerClientEvent('general_store:client:shelfPurchaseResult', src, false, reason or 'inventory', nil, def.label)
        return
    end

    local balance = Player.Functions.GetMoney(moneyType)
    if balance == false or balance < unit then
        TriggerClientEvent('general_store:client:shelfPurchaseResult', src, false, 'no_money', balance, def.label)
        return
    end

    if not Player.Functions.RemoveMoney(moneyType, unit, 'general-store-shelf') then
        TriggerClientEvent('general_store:client:shelfPurchaseResult', src, false, 'pay_failed', nil, def.label)
        return
    end

    local added = Player.Functions.AddItem(def.name, 1, nil, {}, 'general-store-shelf')
    if not added then
        Player.Functions.AddMoney(moneyType, unit, 'general-store-shelf-refund')
        TriggerClientEvent('general_store:client:shelfPurchaseResult', src, false, 'give_failed', Player.Functions.GetMoney(moneyType), def.label)
        return
    end

    if isOwnedStore and GS_CommitOwnedPurchase then
        GS_CommitOwnedPurchase(storeId, { { item = def.name, qty = 1 } }, unit)
    elseif GS_CommitStock then
        GS_CommitStock(storeId, { { item = def.name, qty = 1 } })
    end

    local newBal = Player.Functions.GetMoney(moneyType)
    TriggerClientEvent('general_store:client:shelfPurchaseResult', src, true, 'ok', newBal == false and 0 or newBal, def.label)
end)
