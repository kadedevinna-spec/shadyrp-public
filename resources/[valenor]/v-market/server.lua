local Core = nil
local RSGCore = nil
local currentFramework = nil

if Config.Framework == 'vorp' then
    currentFramework = "vorp"
    Core = exports.vorp_core and exports.vorp_core:GetCore() or nil
elseif Config.Framework == 'rsg-core' then
    currentFramework = "rsg"
    RSGCore = exports['rsg-core'] and exports['rsg-core']:GetCoreObject() or nil
else
    print("^1[v-market]^7 No supported framework found! Please install either VORP Core or RSG Core.")
    return
end

local ServerCallbacks = {}

local function RegisterServerCallback(name, cb)
    ServerCallbacks[name] = cb
end

RegisterServerEvent('valenor_market:server:triggerCallback')
AddEventHandler('valenor_market:server:triggerCallback', function(name, requestId, ...)
    local src = source
    if ServerCallbacks[name] then
        ServerCallbacks[name](src, function(...)
            TriggerClientEvent('valenor_market:client:serverCallback', src, requestId, ...)
        end, ...)
    else
        print(('[v-market] [^1ERROR^7] Server Callback "%s" does not exist'):format(name))
    end
end)

local function getUser(source)
    if currentFramework == "vorp" then
        return Core.getUser(source) --[[@as User]]
    elseif currentFramework == "rsg" then
        local player = RSGCore.Functions.GetPlayer(source)
        if player then
            return {
                getUsedCharacter = function()
                    return {
                        money = player.PlayerData.money['cash'],
                        removeCurrency = function(_, amount)
                            player.Functions.RemoveMoney('cash', amount)
                        end,
                        addCurrency = function(_, amount)
                            player.Functions.AddMoney('cash', amount)
                        end,
                        job = player.PlayerData.job.name,
                        jobGrade = player.PlayerData.job.grade.level
                    }
                end,
                getUsedCharacter = {
                    money = player.PlayerData.money['cash'],
                    job = player.PlayerData.job.name,
                    jobGrade = player.PlayerData.job.grade.level,
                    removeCurrency = function(_, amount)
                        player.Functions.RemoveMoney('cash', amount)
                    end,
                    addCurrency = function(_, amount)
                        player.Functions.AddMoney('cash', amount)
                    end,
                }
            }
        end

    end
    return nil
end

local function getCharacter(user)
    if not user then return nil end
    if type(user.getUsedCharacter) == 'function' then
        return user.getUsedCharacter()
    else
        return user.getUsedCharacter
    end
end

local function getBasicCharacterInfo(src)
    local user = getUser(src)
    if not user then return nil end
    local character = getCharacter(user)
    return {
        money = character.money or 0,
        job = character.job,
        grade = character.jobGrade
    }
end

local function inv_canCarry(src, itemName, amount, weaponId)
    if currentFramework == "vorp" then
        if itemName:upper():find("^WEAPON_") then
            local can = exports.vorp_inventory:canCarryWeapons(src, 1, nil, itemName)
            return can
        else
            return exports.vorp_inventory:canCarryItem(src, itemName, amount)
        end
    elseif currentFramework == "rsg" then
        local player = RSGCore.Functions.GetPlayer(src)
        if not player then return false end
        return exports['rsg-inventory']:CanAddItem(src, itemName, amount)
    end
    return false
end

local function inv_addItem(src, itemName, amount, metadata)
    if currentFramework == "vorp" then
        if itemName:upper():find("^WEAPON_") then
            if metadata == nil then
                exports.vorp_inventory:createWeapon(src, itemName, {["ammo"] = ammo})
            else
                local ammo = metadata and metadata.ammo or 0
                local components = metadata and metadata.components or {}
                exports.vorp_inventory:createWeapon(src, itemName, {["ammo"] = ammo}, components, metadata.comps, nil, nil, metadata.serial)
            end
            
            return true
        else
            return exports.vorp_inventory:addItem(src, itemName, amount, metadata)
        end
    elseif currentFramework == "rsg" then
        local player = RSGCore.Functions.GetPlayer(src)
        if not player then return false end
        return player.Functions.AddItem(itemName, amount, nil, metadata)
    end
    return false
end

local function inv_removeItem(src, itemName, amount, weaponId)
    if currentFramework == "vorp" then
        if itemName:upper():find("^WEAPON_") then
            if not weaponId then return false end
            if GetResourceState("v-inventory") == "started" then
                return exports.vorp_inventory:subWeapon(src, tostring(weaponId))
            else
                return exports.vorp_inventory:subWeapon(src, weaponId)
            end
        else
            return exports.vorp_inventory:subItem(src, itemName, amount)
        end
    elseif currentFramework == "rsg" then
        local player = RSGCore.Functions.GetPlayer(src)
        if not player then return false end
        -- weaponId in RSG context will be the slot
        return player.Functions.RemoveItem(itemName, amount, weaponId)
    end
    return false
end

local function inv_getUserInventoryItems(src)
    if currentFramework == "vorp" then
        return exports.vorp_inventory:getUserInventoryItems(src)
    elseif currentFramework == "rsg" then
        local player = RSGCore.Functions.GetPlayer(src)
        if not player then return {} end
        return player.PlayerData.items or {}
    end
    return {}
end

local function Lang(msg, vars)
    local text = Config.Lang[msg]
    if not text then return 'Translation not found for key: ' .. tostring(msg) end

    if vars then
        for k, v in pairs(vars) do
            text = text:gsub('{' .. k .. '}', tostring(v))
        end
    end
    return text
end



local function GetCustomMarketData(marketId)
    local result = MySQL.query.await('SELECT * FROM `v-market` WHERE id = ?', {marketId})
    if result and result[1] then
        local marketData = result[1]
        return {
            id = marketData.id,
            name = marketData.marketName,
            description = marketData.marketDescription,
            icon = marketData.marketIcon,
            items = json.decode(marketData.items or '[]'),
            case = marketData.case or 0
        }
    end
    return nil
end

local function UpdateCustomMarketData(marketId, data)
    MySQL.update.await('UPDATE `v-market` SET marketName = ?, marketDescription = ?, marketIcon = ?, items = ?, `case` = ? WHERE id = ?', {
        data.marketName,
        data.marketDescription,
        data.marketIcon,
        json.encode(data.items),
        data.case,
        marketId
    })
end

local function CreateDefaultCustomMarketData(marketConfig)
    return {
        id = marketConfig.id,
        name = marketConfig.name or "Custom Market " .. marketConfig.id,
        description = marketConfig.description or "A custom market",
        icon = marketConfig.icon or "market_icon",
        items = marketConfig.items or {},
        case = marketConfig.case or 0
    }
end

local function InsertCustomMarketToDatabase(marketData)
    MySQL.insert.await('INSERT INTO `v-market` (id, marketName, marketDescription, marketIcon, items, `case`) VALUES (?, ?, ?, ?, ?, ?)', {
        marketData.id,
        marketData.name,
        marketData.description,
        marketData.icon,
        json.encode(marketData.items),
        marketData.case
    })
end

local CustomMarketsData = {}



local function getItemImageUrl(itemName, existingImageUrl)
    if existingImageUrl and existingImageUrl ~= "" then
        return existingImageUrl
    end
    
    if currentFramework == "rsg" and RSGCore and RSGCore.Shared and RSGCore.Shared.Items then
        local itemData = RSGCore.Shared.Items[itemName]
        if itemData and itemData.image then
            return itemData.image
        end
    end
    
    return ""
end

local function processItemsForClient(items)
    local processedItems = {}
    for _, item in pairs(items) do
        local processedItem = {
            id = item.id,
            itemName = item.itemName,
            itemLabel = item.itemLabel or item.itemName,
            category = item.category,
            description = item.description or "",
            price = item.price,
            maxQuantityinStore = item.maxQuantityinStore,
            imageUrl = getItemImageUrl(item.itemName, item.imageUrl or "")
        }
        if item.weaponId then
            processedItem.weaponId = item.weaponId
        end
        if item.metadata then
            processedItem.metadata = item.metadata
        end
        table.insert(processedItems, processedItem)
    end
    return processedItems
end
CreateThread(function()
    for _, market in pairs(Config.customMarkets) do
        local dbData = GetCustomMarketData(market.id)
        if dbData then
            CustomMarketsData[market.id] = {
                config = market,
                db = dbData
            }
        else
            local defaultData = CreateDefaultCustomMarketData(market)
            InsertCustomMarketToDatabase(defaultData)
            
            local newDbData = GetCustomMarketData(market.id)
            if newDbData then
                CustomMarketsData[market.id] = {
                    config = market,
                    db = newDbData
                }
                print("^2[v-market]^7 Created new custom market in database: " .. newDbData.name .. " (ID: " .. market.id .. ")")
            end
        end
    end
end)

RegisterServerCallback("valenor_market:server:changeDetails", function(src, cb, data)
    local user = getUser(src)
    if not user then return cb(false) end
    local character = character and character.job and character or character -- handle different getUser returns
    local character = getCharacter(user)
    local job = character.job
    local grade = character.jobGrade
    
    local customMarket = nil
    for _, market in pairs(Config.customMarkets) do
        if market.id == data.marketId then
            customMarket = market
            break
        end
    end
    
    if not customMarket then
        Config.Notify(src, Config.Lang.market_invalid, 2000, Core)
        return cb(false)
    end
    
    if job ~= customMarket.job then
        Config.Notify(src, Config.Lang.market_access_denied, 2000, Core)
        return cb(false)
    end
    
    local hasGrade = false
    for _, allowedGrade in pairs(customMarket.grade) do
        if grade == allowedGrade then
            hasGrade = true
            break
        end
    end
    
    if not hasGrade then
        Config.Notify(src, Config.Lang.market_grade_required, 2000, Core)
        return cb(false)
    end
    
    UpdateCustomMarketData(data.marketId, {
        marketName = data.marketName,
        marketDescription = data.marketDescription,
        marketIcon = data.marketIcon,
        items = data.items or CustomMarketsData[data.marketId].db.items,
        case = data.case or CustomMarketsData[data.marketId].db.case
    })
    
     if CustomMarketsData[data.marketId] then
         CustomMarketsData[data.marketId].db = {
             name = data.marketName,
             description = data.marketDescription,
             icon = data.marketIcon,
             items = data.items or CustomMarketsData[data.marketId].db.items,
             case = data.case or CustomMarketsData[data.marketId].db.case
         }
     end
     
     local itemsToSend = data.items or CustomMarketsData[data.marketId].db.items
     local processedItems = processItemsForClient(itemsToSend)
     
     TriggerClientEvent("valenor_market:client:marketUpdated", -1, {
         marketId = data.marketId,
         name = data.marketName,
         description = data.marketDescription,
         icon = data.marketIcon,
         items = processedItems,
         case = data.case or CustomMarketsData[data.marketId].db.case
     })
     
     Config.Notify(src, Config.Lang.market_details_updated_successfully, 2000, Core)
     cb(true)
end)

RegisterServerCallback("valenor_market:server:purchase", function(src, cb, data)
    local user = getUser(src) --[[@as User]]  
    if not user then return cb(false) end -- is player in session?
    local character = getCharacter(user)
    local money = character.money
    
    local totalCost = 0
    local purchaseItems = {}

    -- print(json.encode(data))
    
    if data.marketId and data.marketId ~= 0 then
        local customMarketData = CustomMarketsData[data.marketId]
        if not customMarketData then
            Config.Notify(src, Config.Lang.market_not_found, 2000, Core)
            return cb(false)
        end
        
        for _, item in pairs(data.items) do
            local dbItem = nil
            local isWeapon = currentFramework == "vorp" and item.name:upper():find("^WEAPON_")
            
            if isWeapon and item.weaponId then
                for _, dbItemData in pairs(customMarketData.db.items) do
                    if dbItemData.itemName == item.name and tostring(dbItemData.weaponId) == tostring(item.weaponId) then
                        dbItem = dbItemData
                        break
                    end
                end
            else
                for _, dbItemData in pairs(customMarketData.db.items) do
                    if dbItemData.itemName:upper() == item.name:upper() then
                        dbItem = dbItemData
                        break
                    end
                end
            end
            
            if dbItem then
                local isWeapon = currentFramework == "vorp" and item.name:upper():find("^WEAPON_")
                local quantityToCheck = item.quantity
                
                if isWeapon and item.quantity > 1 then
                    Config.Notify(src, Lang("not_enough_items", { maxQuantityinStore = 1, quantity = item.quantity }), 4000, Core)
                    return cb(false)
                end
                
                if quantityToCheck > dbItem.maxQuantityinStore then
                    Config.Notify(src, Lang("not_enough_items", { maxQuantityinStore = dbItem.maxQuantityinStore, quantity = quantityToCheck }), 4000, Core)
                    return cb(false)
                end

                local finalQuantity = isWeapon and 1 or item.quantity
                local itemTotal = dbItem.price * finalQuantity
                totalCost = totalCost + itemTotal
                
                local purchaseItem = {
                    name = item.name,
                    quantity = finalQuantity,
                    price = dbItem.price,
                    total = itemTotal,
                    isWeapon = isWeapon,
                    metadata = dbItem.metadata
                }
                if isWeapon and dbItem.weaponId then
                    purchaseItem.weaponId = dbItem.weaponId
                end
                table.insert(purchaseItems, purchaseItem)
            end
        end
        
        if money < totalCost then
            Config.Notify(src, Config.Lang.not_enough_money, 2000, Core)
            return cb(false)
        end
        
        character.removeCurrency(0, totalCost)
        
        local newCaseAmount = customMarketData.db.case + totalCost
        UpdateCustomMarketData(data.marketId, {
            marketName = customMarketData.db.name,
            marketDescription = customMarketData.db.description,
            marketIcon = customMarketData.db.icon,
            items = customMarketData.db.items,
            case = newCaseAmount
        })
        
        CustomMarketsData[data.marketId].db.case = newCaseAmount
        
        TriggerClientEvent("valenor_market:client:caseUpdated", src, {
            marketId = data.marketId,
            newCase = newCaseAmount
        })
        
        local processedItems = processItemsForClient(customMarketData.db.items)
        
        TriggerClientEvent("valenor_market:client:marketUpdated", -1, {
            marketId = data.marketId,
            name = customMarketData.db.name,
            description = customMarketData.db.description,
            icon = customMarketData.db.icon,
            items = processedItems,
            case = newCaseAmount
        })
        
        for _, item in pairs(purchaseItems) do
            local canCarry = inv_canCarry(src, item.name, item.quantity, item.weaponId)
            -- print("[v-market] Purchase: canCarry", item.name, canCarry)
            if canCarry then
                local added = inv_addItem(src, item.name, item.quantity, item.metadata)
                if not added then
                    if Config.Payment == "cash" then
                        character.addCurrency(0, item.total)
                    else
                        inv_addItem(src, Config.Payment, item.total)
                    end
                    local refundedCaseAmount = customMarketData.db.case - item.total
                    UpdateCustomMarketData(data.marketId, {
                        marketName = customMarketData.db.name,
                        marketDescription = customMarketData.db.description,
                        marketIcon = customMarketData.db.icon,
                        items = customMarketData.db.items,
                        case = refundedCaseAmount
                    })
                    CustomMarketsData[data.marketId].db.case = refundedCaseAmount
                else
    
                    for i, marketItem in pairs(customMarketData.db.items) do
                        local matches = false
                        if item.isWeapon and item.weaponId then
                            matches = marketItem.itemName:upper() == item.name:upper() and tostring(marketItem.weaponId) == tostring(item.weaponId)
                        else
                            matches = marketItem.itemName == item.name
                        end
                        
                        if matches then
                            marketItem.maxQuantityinStore = marketItem.maxQuantityinStore - item.quantity
                            
                            if marketItem.maxQuantityinStore <= 0 then
                                table.remove(customMarketData.db.items, i)
                                Config.Notify(src, Config.Lang.item_out_of_stock:gsub("{itemName}", item.name), 3000, Core)
                            end

                            UpdateCustomMarketData(data.marketId, {
                                marketName = customMarketData.db.name,
                                marketDescription = customMarketData.db.description,
                                marketIcon = customMarketData.db.icon,
                                items = customMarketData.db.items,
                                case = newCaseAmount
                            })
                            
                            local processedItems = processItemsForClient(customMarketData.db.items)
                            
                            TriggerClientEvent("valenor_market:client:marketUpdated", -1, {
                                marketId = data.marketId,
                                name = customMarketData.db.name,
                                description = customMarketData.db.description,
                                icon = customMarketData.db.icon,
                                items = processedItems,
                                case = newCaseAmount
                            })
                            break
                        end
                    end
                end
            else
                if Config.Payment == "cash" then
                    character.addCurrency(0, item.total)
                else
                    inv_addItem(src, Config.Payment, item.total)
                end
                local refundedCaseAmount = customMarketData.db.case - item.total
                UpdateCustomMarketData(data.marketId, {
                    marketName = customMarketData.db.name,
                    marketDescription = customMarketData.db.description,
                    marketIcon = customMarketData.db.icon,
                    items = customMarketData.db.items,
                    case = refundedCaseAmount
                })
                CustomMarketsData[data.marketId].db.case = refundedCaseAmount
            end
        end
        
        UpdateCustomMarketData(data.marketId, {
            marketName = customMarketData.db.name,
            marketDescription = customMarketData.db.description,
            marketIcon = customMarketData.db.icon,
            items = customMarketData.db.items,
            case = newCaseAmount
        })
        
        local processedItems = processItemsForClient(customMarketData.db.items)
        
        TriggerClientEvent("valenor_market:client:marketUpdated", -1, {
            marketId = data.marketId,
            name = customMarketData.db.name,
            description = customMarketData.db.description,
            icon = customMarketData.db.icon,
            items = processedItems,
            case = newCaseAmount
        })
        
        Config.Notify(src, Config.Lang.purchase_successful .. " " .. totalCost, 4000, Core)
        cb(true)
    else
        if Config.MarketLimit and Config.MarketLimit > 0 then
            local totalQuantityInCart = 0
            for _, cartItem in pairs(data.items) do
                totalQuantityInCart = totalQuantityInCart + (cartItem.quantity or 0)
            end
            if totalQuantityInCart > Config.MarketLimit then
                Config.Notify(src, Config.Lang.purchase_limit_reached:gsub("{Config.MarketLimit}", Config.MarketLimit), 4000, Core)
                return cb(false)
            end
        end

        for _, item in pairs(data.items) do
            local configItem = nil
            for _, market in pairs(Config.markets) do
                for _, configItemData in pairs(market.items) do
                    if configItemData.itemName == item.name then
                        configItem = configItemData
                        break
                    end
                end
                if configItem then break end
            end
            
            if configItem then
                local isWeapon = currentFramework == "vorp" and item.name:find("^WEAPON_")
                local finalQuantity = isWeapon and 1 or item.quantity
                
                if isWeapon and item.quantity > 1 then
                    Config.Notify(src, Lang("not_enough_items", { maxQuantityinStore = 1, quantity = item.quantity }), 4000, Core)
                    return cb(false)
                end
                
                local itemTotal = configItem.price * finalQuantity
                totalCost = totalCost + itemTotal
                
                table.insert(purchaseItems, {
                    name = item.name,
                    quantity = finalQuantity,
                    price = configItem.price,
                    total = itemTotal
                })
            end
        end
        
        if money < totalCost then
            Config.Notify(src, Config.Lang.not_enough_money, 2000, Core)
            return cb(false)
        end
        
        character.removeCurrency(0, totalCost)
        for _, item in pairs(purchaseItems) do
            local canCarry = inv_canCarry(src, item.name, item.quantity, item.weaponId)
            if canCarry then
                local ok = inv_addItem(src, item.name, item.quantity)
                if not ok then
                    if Config.Payment == "cash" then
                        character.addCurrency(0, item.total)
                    else
                        inv_addItem(src, Config.Payment, item.total)
                    end
                end
            else
                if Config.Payment == "cash" then
                    character.addCurrency(0, item.total)
                else
                    inv_addItem(src, Config.Payment, item.total)
                end
            end
        end
        Config.Notify(src, Config.Lang.purchase_successful .. " " .. totalCost, 4000, Core)
        cb(true)
    end
end)

RegisterServerCallback("valenor_market:server:sellItem", function(src, cb, data)
    local user = getUser(src)
    if not user then return cb(false) end
    local character = getCharacter(user)
    
    local marketConfig = nil
    for _, market in pairs(Config.markets) do
        if market.name == data.marketName then
            marketConfig = market
            break
        end
    end
    
    if not marketConfig and Config.sellMarkets then
        for _, market in pairs(Config.sellMarkets) do
            if market.name == data.marketName then
                marketConfig = market
                break
            end
        end
    end

    if not marketConfig then
        Config.Notify(src, Config.Lang.market_not_found, 2000, Core)
        return cb(false)
    end

    local sellItemConfig = nil
    if marketConfig.sellItems then
        for _, item in pairs(marketConfig.sellItems) do
            if item.itemName == data.item.itemName then
                sellItemConfig = item
                break
            end
        end
    end

    if not sellItemConfig then
        Config.Notify(src, Config.Lang.sell_error, 2000, Core)
        return cb(false)
    end

    local quantity = data.quantity or 1
    local totalPrice = sellItemConfig.price * quantity

    -- Check if player has item
    -- VORP specific check for weapons if needed, but usually we just remove standard items or check count
    local playerInventory = inv_getUserInventoryItems(src)
    local hasEnough = false
    
    for _, invItem in pairs(playerInventory) do
        if invItem.name == data.item.itemName then
            local count = invItem.count or invItem.amount or 0
            if count >= quantity then
                hasEnough = true
            end
            break
        end
    end

    if not hasEnough then
        Config.Notify(src, Config.Lang.not_enough_items_in_inventory:gsub("{itemName}", data.item.itemName):gsub("{playerItemCount}", "0"):gsub("{quantityToAdd}", quantity), 4000, Core)
        return cb(false)
    end

    local removed = inv_removeItem(src, data.item.itemName, quantity)
    if removed then
        character.addCurrency(0, totalPrice)
        Config.Notify(src, Lang("sold_item", { quantity = quantity, itemName = data.item.itemName, totalPrice = totalPrice }), 4000, Core)
        cb(true)
    else
        Config.Notify(src, Config.Lang.sell_error, 2000, Core)
        cb(false)
    end
end)

RegisterServerCallback("valenor_market:server:sellItems", function(src, cb, data)
    local user = getUser(src)
    if not user then return cb(false) end
    local character = getCharacter(user)
    
    local marketName = data.marketName
    local itemsToSell = data.items
    
    -- Find the market config
    local marketConfig = nil
    for _, market in pairs(Config.markets) do
        if market.name == marketName then
            marketConfig = market
            break
        end
    end
    
    if not marketConfig and Config.sellMarkets then
        for _, market in pairs(Config.sellMarkets) do
            if market.name == marketName then
                marketConfig = market
                break
            end
        end
    end

    if not marketConfig then
        Config.Notify(src, Config.Lang.market_not_found, 2000, Core)
        return cb(false)
    end

    local totalSold = 0
    local totalEarned = 0
    
    for _, itemData in pairs(itemsToSell) do
        local sellItemConfig = nil
        if marketConfig.sellItems then
            for _, item in pairs(marketConfig.sellItems) do
                if item.itemName == itemData.name then
                    sellItemConfig = item
                    break
                end
            end
        end
        
        if sellItemConfig then
            local quantity = itemData.quantity or 1
            local totalPrice = sellItemConfig.price * quantity
            
            -- Check inventory (basic check)
             local playerInventory = inv_getUserInventoryItems(src)
             local hasEnough = false
             for _, invItem in pairs(playerInventory) do
                 if invItem.name == itemData.name then
                     local count = invItem.count or invItem.amount or 0
                     if count >= quantity then
                         hasEnough = true
                     end
                     break
                 end
             end
             
             if hasEnough then
                local removed = inv_removeItem(src, itemData.name, quantity)
                if removed then
                    totalEarned = totalEarned + totalPrice
                    totalSold = totalSold + 1
                end
             end
        end
    end
    
    if totalSold > 0 then
        character.addCurrency(0, totalEarned)
        Config.Notify(src, Config.Lang.sold_item:gsub("{quantity}", totalSold):gsub("{itemName}", "items"):gsub("{totalPrice}", totalEarned), 4000, Core)
        cb(true)
    else
        Config.Notify(src, Config.Lang.sell_error, 2000, Core)
        cb(false)
    end
end)

RegisterServerEvent("valenor_market:server:getCustomMarketData")
AddEventHandler("valenor_market:server:getCustomMarketData", function(marketId)
    local src = source
    local info = getBasicCharacterInfo(src)
    if not info then return end
    local customMarketData = CustomMarketsData[marketId]
    if customMarketData then
        local canManage = false
        local canWithdraw = false
        if info.job == customMarketData.config.job then
            for _, g in pairs(customMarketData.config.grade or {}) do
                if info.grade == g then canManage = true break end
            end
            for _, bg in pairs(customMarketData.config.bossGrade or {}) do
                if info.grade == bg then canWithdraw = true break end
            end
        end
        local processedItems = processItemsForClient(customMarketData.db.items)
        
        TriggerClientEvent("valenor_market:client:receiveCustomMarketData", src, {
            id = marketId,
            name = customMarketData.db.name,
            description = customMarketData.db.description,
            icon = customMarketData.db.icon,
            items = processedItems,
            case = customMarketData.db.case,
            coords = customMarketData.config.coords,
            category = customMarketData.config.category,
            showBlip = customMarketData.config.showBlip,
            managementAccess = canManage,
            canWithdraw = canWithdraw,
            playerMoney = info.money
        })
    end
end)

RegisterServerEvent("valenor_market:server:getPlayerInfo")
AddEventHandler("valenor_market:server:getPlayerInfo", function()
    local src = source
    local info = getBasicCharacterInfo(src)
    if not info then return end
    TriggerClientEvent("valenor_market:client:receivePlayerInfo", src, info)
end)

RegisterServerEvent("valenor_market:server:getPlayerCustomMarkets")
AddEventHandler("valenor_market:server:getPlayerCustomMarkets", function()
    local src = source
    local user = getUser(src)
    if not user then return end
    local playerMarkets = {}
    for marketId, marketData in pairs(CustomMarketsData) do
        table.insert(playerMarkets, {
            id = marketId,
            name = marketData.db.name,
            description = marketData.db.description,
            icon = marketData.db.icon,
            coords = marketData.config.coords,
            items = marketData.db.items,
            category = marketData.config.category,
            case = marketData.db.case,
            showBlip = marketData.config.showBlip,
            BlipSettings = marketData.config.BlipSettings,
            ped = marketData.config.ped,
            scenario = marketData.config.scenario
        })
    end
    TriggerClientEvent("valenor_market:client:receivePlayerCustomMarkets", src, playerMarkets)
end)

RegisterServerCallback("valenor_market:server:addItemToMarket", function(src, cb, data)
    local user = getUser(src)
    if not user then return cb(false) end
    local character = getCharacter(user)
    local job = character.job
    local grade = character.jobGrade
    if not data.marketId or data.marketId == 0 then
        Config.Notify(src, Config.Lang.market_invalid, 2000, Core)
        return cb(false)
    end
    
    local customMarketData = CustomMarketsData[data.marketId]
    if not customMarketData then
        Config.Notify(src, Config.Lang.market_not_found, 2000, Core)
        return cb(false)
    end
    
    if job ~= customMarketData.config.job then
        Config.Notify(src, Config.Lang.market_access_denied, 2000, Core)
        return cb(false)
    end
    
    local hasGrade = false
    for _, allowedGrade in pairs(customMarketData.config.grade) do
        if grade == allowedGrade then
            hasGrade = true
            break
        end
    end
    
    if not hasGrade then
        Config.Notify(src, Config.Lang.market_grade_required, 2000, Core)
        return cb(false)
    end
    
    if data.item then
        local isWeapon = currentFramework == "vorp" and data.item.itemName:upper():find("^WEAPON_")
        local quantityToAdd = isWeapon and 1 or (data.item.maxQuantityinStore or 1)

        if isWeapon then
            if not data.item.weaponId and not data.item.id then
                Config.Notify(src, "Silah için weaponId gerekli!", 3000, Core)
                return cb(false)
            end
            quantityToAdd = 1
        else
            local playerInventory = inv_getUserInventoryItems(src)
            local playerItemCount = 0
            
            for _, invItem in pairs(playerInventory) do
                if invItem.name == data.item.itemName then
                    playerItemCount = invItem.count or invItem.amount or 0
                    break
                end
            end
            
            if playerItemCount < quantityToAdd then
                Config.Notify(src, Lang("not_enough_items_in_inventory", { itemName = data.item.itemName, playerItemCount = playerItemCount, quantityToAdd = quantityToAdd }), 4000, Core)
                return cb(false)
            end
        end
        
        local merged = false
        if not isWeapon then
            for i, existing in pairs(customMarketData.db.items) do
                if existing.itemName == data.item.itemName then
                    local newQuantity = (existing.maxQuantityinStore or 0) + quantityToAdd
                    customMarketData.db.items[i] = {
                        id = existing.id or data.item.id,
                        itemName = existing.itemName,
                        itemLabel = existing.itemLabel or data.item.itemLabel or data.item.itemName,
                        category = existing.category, 
                        description = existing.description or data.item.description or "",
                        price = existing.price or data.item.price, 
                        maxQuantityinStore = newQuantity,
                        imageUrl = existing.imageUrl or data.item.imageUrl or ""
                    }
                    merged = true
                    break
                end
            end
        else

        end
        
        if not merged then
            local newItem = {
                id = data.item.id,
                itemName = data.item.itemName,
                itemLabel = data.item.itemLabel or data.item.itemName,
                category = data.item.category,
                description = data.item.description or "",
                price = data.item.price,
                maxQuantityinStore = quantityToAdd,
                imageUrl = data.item.imageUrl or ""
            }

            if isWeapon and data.item.weaponId then
                newItem.weaponId = data.item.weaponId
            end

            if data.item.metadata then
                newItem.metadata = data.item.metadata
            end
            table.insert(customMarketData.db.items, newItem)
        end

        local weaponIdToRemove = nil
        if isWeapon then
            weaponIdToRemove = data.item.weaponId or data.item.id
        end
        local removed = inv_removeItem(src, data.item.itemName, quantityToAdd, weaponIdToRemove)
        
        UpdateCustomMarketData(data.marketId, {
            marketName = customMarketData.db.name,
            marketDescription = customMarketData.db.description,
            marketIcon = customMarketData.db.icon,
            items = customMarketData.db.items,
            case = customMarketData.db.case
        })
        
        local processedItems = processItemsForClient(customMarketData.db.items)
        
        TriggerClientEvent("valenor_market:client:marketUpdated", -1, {
            marketId = data.marketId,
            name = customMarketData.db.name,
            description = customMarketData.db.description,
            icon = customMarketData.db.icon,
            items = processedItems,
            case = customMarketData.db.case
        })
        
        Config.Notify(src, Config.Lang.item_added_to_market, 2000, Core)
        cb(true)
    else
        cb(false)
    end
end)

RegisterServerCallback("valenor_market:server:updateMarketItem", function(src, cb, data)
    local user = getUser(src)
    if not user then return cb(false) end
    local character = getCharacter(user)
    local job = character.job
    local grade = character.jobGrade
    
    if not data.marketId or data.marketId == 0 then
        Config.Notify(src, Config.Lang.market_invalid, 2000, Core)
        return cb(false)
    end
    
    local customMarketData = CustomMarketsData[data.marketId]
    if not customMarketData then
        Config.Notify(src, Config.Lang.market_not_found, 2000, Core)
        return cb(false)
    end
    
    if job ~= customMarketData.config.job then
        Config.Notify(src, Config.Lang.market_access_denied, 2000, Core)
        return cb(false)
    end
    
    local hasGrade = false
    for _, allowedGrade in pairs(customMarketData.config.grade) do
        if grade == allowedGrade then
            hasGrade = true
            break
        end
    end
    
    if not hasGrade then
        Config.Notify(src, Config.Lang.market_grade_required, 2000, Core)
        return cb(false)
    end

    if data.item then
        local isWeapon = currentFramework == "vorp" and data.item.itemName:upper():find("^WEAPON_")
        local finalQuantity = data.item.maxQuantityinStore
        
        if isWeapon and data.item.maxQuantityinStore > 1 then
            Config.Notify(src, Lang("not_enough_items", { maxQuantityinStore = 1, quantity = data.item.maxQuantityinStore }), 4000, Core)
            return cb(false)
        end
        
        local oldQuantity = 0
        local itemName = ""
        local weaponId = nil
        
        for i, item in pairs(customMarketData.db.items) do
            local matches = false
            if isWeapon and data.item.weaponId then
                matches = item.itemName:upper() == data.item.itemName:upper() and tostring(item.weaponId) == tostring(data.item.weaponId)
            else
                matches = item.itemName == data.item.itemName
            end
            
            if matches then
                oldQuantity = item.maxQuantityinStore
                itemName = item.itemName
                weaponId = item.weaponId
                customMarketData.db.items[i] = {
                    id = data.item.id,
                    itemName = data.item.itemName,
                    itemLabel = data.item.itemLabel or data.item.itemName,
                    category = data.item.category,
                    description = data.item.description or "",
                    price = data.item.price,
                    maxQuantityinStore = finalQuantity,
                    imageUrl = data.item.imageUrl or "",
                    metadata = item.metadata
                }
                if isWeapon and weaponId then
                    customMarketData.db.items[i].weaponId = weaponId
                end
                break
            end
        end
        
        if not isWeapon then
            
            if finalQuantity > oldQuantity then
                local quantityToAdd = finalQuantity - oldQuantity
                if quantityToAdd > 0 and itemName ~= "" then
                    local playerInventory = inv_getUserInventoryItems(src)
                    local playerItemCount = 0
                    
                    for _, invItem in pairs(playerInventory) do
                        if invItem.name == itemName then
                            playerItemCount = invItem.count or invItem.amount
                            break
                        end
                    end
                    
                    if playerItemCount >= quantityToAdd then
                        inv_removeItem(src, itemName, quantityToAdd)
                        Config.Notify(src, Config.Lang.added_item_to_market:gsub("{itemName}", itemName), 3000, Core)
                    else
                        Config.Notify(src, Lang("not_enough_items_in_inventory", { itemName = itemName, playerItemCount = playerItemCount, quantityToAdd = quantityToAdd }), 4000, Core)
                        for i, item in pairs(customMarketData.db.items) do
                            if item.itemName == data.item.itemName then
                                customMarketData.db.items[i].maxQuantityinStore = oldQuantity
                                break
                            end
                        end
                        
                        local processedItems = processItemsForClient(customMarketData.db.items)
                        
                        TriggerClientEvent("valenor_market:client:marketUpdated", -1, {
                            marketId = data.marketId,
                            name = customMarketData.db.name,
                            description = customMarketData.db.description,
                            icon = customMarketData.db.icon,
                            items = processedItems,
                            case = customMarketData.db.case
                        })
                        return cb(false)
                    end
                end
            end
        end
        
        if finalQuantity <= 0 then
            for i = #customMarketData.db.items, 1, -1 do
                local matches = false
                local itemToRemove = customMarketData.db.items[i]
                
                if isWeapon and weaponId then
                    matches = itemToRemove.itemName:upper() == data.item.itemName:upper() and tostring(itemToRemove.weaponId) == tostring(weaponId)
                else
                    matches = itemToRemove.itemName == data.item.itemName
                end
                
                if matches then
                    if isWeapon and weaponId then
                        local canCarry = inv_canCarry(src, itemName, 1, weaponId)
                        if canCarry then
                            inv_addItem(src, itemName, 1, itemToRemove.metadata)
                            Config.Notify(src, Lang("returned_item", { quantityToReturn = 1, itemName = itemName }), 3000, Core)
                        else
                            Config.Notify(src, Lang("could_not_return_item", { quantityToReturn = 1, itemName = itemName }), 3000, Core)
                        end
                    else
                        if oldQuantity > 0 and itemName ~= "" then
                            if inv_canCarry(src, itemName, oldQuantity) then
                                inv_addItem(src, itemName, oldQuantity, itemToRemove.metadata)
                                Config.Notify(src, Lang("returned_item", { quantityToReturn = oldQuantity, itemName = itemName }), 3000, Core)
                            else
                                Config.Notify(src, Lang("could_not_return_item", { quantityToReturn = oldQuantity, itemName = itemName }), 3000, Core)
                            end
                        end
                    end
                    
                    table.remove(customMarketData.db.items, i)
                    Config.Notify(src, Config.Lang.item_removed_from_market:gsub("{itemName}", data.item.itemName), 3000, Core)
                    break
                end
            end
        end
        
        UpdateCustomMarketData(data.marketId, {
            marketName = customMarketData.db.name,
            marketDescription = customMarketData.db.description,
            marketIcon = customMarketData.db.icon,
            items = customMarketData.db.items,
            case = customMarketData.db.case
        })
        
        local processedItems = processItemsForClient(customMarketData.db.items)
        
        TriggerClientEvent("valenor_market:client:marketUpdated", -1, {
            marketId = data.marketId,
            name = customMarketData.db.name,
            description = customMarketData.db.description,
            icon = customMarketData.db.icon,
            items = processedItems,
            case = customMarketData.db.case
        })
        
        Config.Notify(src, Config.Lang.item_updated_successfully, 2000, Core)
        cb(true)
    else
        cb(false)
    end
end)

RegisterServerCallback("valenor_market:server:withdrawCash", function(src, cb, data)
    local user = getUser(src)
    if not user then return cb(false) end
    local character = getCharacter(user)
    local job = character.job
    local grade = character.jobGrade
    
    if not data.marketId or data.marketId == 0 then
        Config.Notify(src, Config.Lang.market_invalid, 2000, Core)
        return cb(false)
    end
    
    if not data.amount or data.amount <= 0 then
        Config.Notify(src, Config.Lang.invalid_amount, 2000, Core)
        return cb(false)
    end
    
    local customMarketData = CustomMarketsData[data.marketId]
    if not customMarketData then
        Config.Notify(src, Config.Lang.market_not_found, 2000, Core)
        return cb(false)
    end
    
    if job ~= customMarketData.config.job then
        Config.Notify(src, Config.Lang.market_access_denied, 2000, Core)
        return cb(false)
    end
    
    local hasBossGrade = false
    for _, bossGrade in pairs(customMarketData.config.bossGrade) do
        if grade == bossGrade then
            hasBossGrade = true
            break
        end
    end
    
    if not hasBossGrade then
        Config.Notify(src, Config.Lang.market_withdraw_cash_required, 2000, Core)
        return cb(false)
    end
    
    if customMarketData.db.case < data.amount then
        Config.Notify(src, Config.Lang.not_enough_cash_in_market_case:gsub("{case}", customMarketData.db.case), 4000, Core)
        return cb(false)
    end
    
    local newCaseAmount = customMarketData.db.case - data.amount
    UpdateCustomMarketData(data.marketId, {
        marketName = customMarketData.db.name,
        marketDescription = customMarketData.db.description,
        marketIcon = customMarketData.db.icon,
        items = customMarketData.db.items,
        case = newCaseAmount
    })
    
    CustomMarketsData[data.marketId].db.case = newCaseAmount
    
    if Config.Payment == "cash" then
        character.addCurrency(0, data.amount)
    else
        inv_addItem(src, Config.Payment, data.amount)
    end
    
    Config.Notify(src, Config.Lang.withdrew_cash_from_market_case:gsub("{amount}", data.amount), 3000, Core)
    
    TriggerClientEvent("valenor_market:client:caseUpdated", src, {
        marketId = data.marketId,
        newCase = newCaseAmount
    })
    
    local processedItems = processItemsForClient(customMarketData.db.items)
    
    TriggerClientEvent("valenor_market:client:marketUpdated", -1, {
        marketId = data.marketId,
        name = customMarketData.db.name,
        description = customMarketData.db.description,
        icon = customMarketData.db.icon,
        items = processedItems,
        case = newCaseAmount
    })
    cb(true)
end)

RegisterServerEvent("v-market:server:getUserWeapons")
AddEventHandler("v-market:server:getUserWeapons", function()
    local src = source
    if GetResourceState("v-inventory") ~= "started" then
        local weapons = exports.vorp_inventory:getUserInventoryWeapons(src)
        TriggerClientEvent("v-market:client:getUserWeapons", src, weapons)
    end
end)

RegisterServerCallback("valenor_market:server:getInventoryItems", function(src, cb)
    local items = inv_getUserInventoryItems(src)
    local weapons = {}
    
    if currentFramework == "vorp" then
        weapons = exports.vorp_inventory:getUserInventoryWeapons(src)
    elseif currentFramework == "rsg" then
        -- For RSG, we separate weapons from the items list for consistency
        local newItems = {}
        for _, item in pairs(items) do
            if item.name:upper():find("^WEAPON_") then
                table.insert(weapons, item)
            else
                table.insert(newItems, item)
            end
        end
        items = newItems
    end
    
    cb({ items = items, weapons = weapons })
end)

