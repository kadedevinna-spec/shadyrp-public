--- Stock management — per-store, per-item with MySQL persistence (oxmysql) and auto-restock.

local DB_TABLE = 'general_store_stock'

-- stockData[storeId][itemName] = { current = N, max = N }
local stockData = {}
local stockReady = false

local function stockEnabled()
    return Config.Stock and Config.Stock.enabled ~= false
end

-- --- DB helpers -------------------------------------------------------------

local function dbSave(storeId, itemName, current)
    MySQL.update(
        ('UPDATE `%s` SET current_stock = ? WHERE store_id = ? AND item_name = ?'):format(DB_TABLE),
        { current, storeId, itemName },
        function() end
    )
end

-- --- Init -------------------------------------------------------------------

local function buildStockData()
    if not stockEnabled() then return end
    local defaultMax = tonumber(Config.Stock.defaultMax) or 50

    MySQL.query(('SELECT store_id, item_name, current_stock, max_stock FROM `%s`'):format(DB_TABLE), {}, function(rows)
        -- Index existing rows by store → item
        local saved = {}
        for _, row in ipairs(rows or {}) do
            if not saved[row.store_id] then saved[row.store_id] = {} end
            saved[row.store_id][row.item_name] = { current = row.current_stock, max = row.max_stock }
        end

        -- Merge config with DB; insert any missing rows
        for storeId, store in pairs(Config.Stores or {}) do
            stockData[storeId] = {}
            for _, item in ipairs(store.items or {}) do
                local name     = item.item:lower()
                local maxStock = item.stock ~= nil and tonumber(item.stock) or defaultMax
                local current

                if saved[storeId] and saved[storeId][name] then
                    -- Clamp saved value to current max (in case config changed)
                    current = math.max(0, math.min(maxStock, saved[storeId][name].current))
                else
                    -- New item not in DB yet — insert with full stock
                    current = maxStock
                    MySQL.insert(
                        ('INSERT IGNORE INTO `%s` (store_id, item_name, current_stock, max_stock) VALUES (?, ?, ?, ?)'):format(DB_TABLE),
                        { storeId, name, current, maxStock },
                        function() end
                    )
                end

                stockData[storeId][name] = { current = current, max = maxStock }
            end
        end

        stockReady = true
        local n = 0
        for _ in pairs(stockData) do n = n + 1 end
        print(('[general_store] Stock ready — %d stores loaded from DB.'):format(n))
    end)
end

-- Creates table on resource start, then loads stock into memory.
AddEventHandler('onResourceStart', function(resourceName)
    if resourceName ~= GetCurrentResourceName() then return end
    if not stockEnabled() then return end

    MySQL.query([[
        CREATE TABLE IF NOT EXISTS `general_store_stock` (
            `store_id`      VARCHAR(60) NOT NULL,
            `item_name`     VARCHAR(60) NOT NULL,
            `current_stock` INT         NOT NULL DEFAULT 0,
            `max_stock`     INT         NOT NULL DEFAULT 50,
            PRIMARY KEY (`store_id`, `item_name`)
        ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
    ]], {}, function()
        buildStockData()
    end)
end)

-- --- Public API (called from server.lua) ------------------------------------

--- Returns { itemName = { current, max }, ... } for the given store.
--- Returns nil when stock is disabled.
function GS_GetStoreStockMap(storeId)
    if not stockEnabled() then return nil end
    local data = stockData[storeId]
    if not data then return {} end
    local out = {}
    for name, s in pairs(data) do
        out[name] = { current = s.current, max = s.max }
    end
    return out
end

--- Returns true, nil if all lines can be fulfilled; false, itemName on first failure.
--- lines = { { item = 'bread', qty = 2 }, ... }
function GS_CheckStock(storeId, lines)
    if not stockEnabled() then return true, nil end
    local data = stockData[storeId]
    if not data then return true, nil end

    for _, line in ipairs(lines) do
        local name = line.item:lower()
        local s    = data[name]
        if s and s.current < (line.qty or 1) then
            return false, name
        end
    end
    return true, nil
end

--- Decrements stock for each line, persists to DB, and broadcasts delta to all clients.
--- Call only after GS_CheckStock passes.
function GS_CommitStock(storeId, lines)
    if not stockEnabled() then return end
    local data = stockData[storeId]
    if not data then return end

    local delta = {}
    for _, line in ipairs(lines) do
        local name = line.item:lower()
        local s    = data[name]
        if s then
            s.current = math.max(0, s.current - (line.qty or 1))
            delta[name] = s.current
            dbSave(storeId, name, s.current)
        end
    end

    if next(delta) then
        TriggerClientEvent('general_store:client:stockUpdate', -1, storeId, delta)
    end
end

-- --- Restock thread ---------------------------------------------------------

CreateThread(function()
    if not stockEnabled() then return end
    local rc = Config.Stock.restock or {}
    if rc.enabled == false then return end

    local intervalMs = math.max(60000, (tonumber(rc.intervalMinutes) or 30) * 60 * 1000)

    while true do
        Wait(intervalMs)

        if not stockReady then goto continue end

        for storeId, data in pairs(stockData) do
            local delta = {}
            for name, s in pairs(data) do
                if s.max > 0 then
                    local prev = s.current
                    if rc.amount == 'full' then
                        s.current = s.max
                    else
                        s.current = math.min(s.max, s.current + (tonumber(rc.amount) or s.max))
                    end
                    if s.current ~= prev then
                        delta[name] = s.current
                        dbSave(storeId, name, s.current)
                    end
                end
            end
            if next(delta) then
                TriggerClientEvent('general_store:client:stockUpdate', -1, storeId, delta)
            end
        end

        print(('[general_store] Stock restocked. Next in %d min.'):format(math.floor(intervalMs / 60000)))

        ::continue::
    end
end)
