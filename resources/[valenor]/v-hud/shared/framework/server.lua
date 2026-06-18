-- Framework Bridge - Server Side
-- Supports both VORPCore and RSGCore frameworks

Framework = {}
Framework.Core = nil
Framework.Inventory = nil

local isVorp = Config.Framework == "vorp"
local isRsg = Config.Framework == "rsg"

-- Initialize Core (synchronous to avoid race conditions)
if isVorp then
    Framework.Core = exports.vorp_core:GetCore()
    print("^2[v-hud]^7 Framework: VORPCore loaded")
elseif isRsg then
    Framework.Core = exports['rsg-core']:GetCoreObject()
    print("^2[v-hud]^7 Framework: RSGCore loaded")
end

-- ==================== PLAYER FUNCTIONS ====================

---Get user/player object from source
---@param source number Player server ID
---@return table|nil User object
function Framework.GetUser(source)
    if isVorp then
        return Framework.Core.getUser(source)
    elseif isRsg then
        Wait(500)
        return Framework.Core.Functions.GetPlayer(source)
    end
    return nil
end

---Get character data from user
---@param user table User object from GetUser
---@return table|nil Character data
function Framework.GetCharacter(user)
    if not user then return nil end

    if isVorp then
        return user.getUsedCharacter
    elseif isRsg then
        return user.PlayerData
    end
    return nil
end

---Get character identifier
---@param character table Character object
---@return number|string|nil Character identifier
function Framework.GetCharacterIdentifier(character)
    if not character then return nil end

    if isVorp then
        return character.charIdentifier
    elseif isRsg then
        return character.citizenid or character.cid
    end
    return nil
end

---Get player license
---@param source number Player server ID
---@return string|nil Player license
function Framework.GetPlayerLicense(source)
    return GetPlayerIdentifierByType(source, "license")
end

---Get player money (cash)
---@param character table Character object
---@return number Money amount
function Framework.GetMoney(character)
    if not character then return 0 end

    if isVorp then
        return character.money or 0
    elseif isRsg then
        if character.money then
            return character.money.cash or character.money['cash'] or 0
        end
        return 0
    end
    return 0
end

---Remove money from player
---@param source number Player server ID
---@param amount number Amount to remove
---@param moneyType? string Money type (default: cash)
---@return boolean Success
function Framework.RemoveMoney(source, amount, moneyType)
    moneyType = moneyType or "cash"

    if isVorp then
        local user = Framework.GetUser(source)
        if not user then return false end
        local character = Framework.GetCharacter(user)
        if not character then return false end

        -- VORP uses currency index: 0 = cash, 1 = gold
        local currencyIndex = 0
        if moneyType == "gold" then currencyIndex = 1 end

        character.removeCurrency(currencyIndex, amount)
        return true
    elseif isRsg then
        local player = Framework.GetUser(source)
        if not player then return false end

        return player.Functions.RemoveMoney(moneyType, amount, "v-hud")
    end
    return false
end

---Add money to player
---@param source number Player server ID
---@param amount number Amount to add
---@param moneyType? string Money type (default: cash)
---@return boolean Success
function Framework.AddMoney(source, amount, moneyType)
    moneyType = moneyType or "cash"

    if isVorp then
        local user = Framework.GetUser(source)
        if not user then return false end
        local character = Framework.GetCharacter(user)
        if not character then return false end

        local currencyIndex = 0
        if moneyType == "gold" then currencyIndex = 1 end

        character.addCurrency(currencyIndex, amount)
        return true
    elseif isRsg then
        local player = Framework.GetUser(source)
        if not player then return false end

        return player.Functions.AddMoney(moneyType, amount, "v-hud")
    end
    return false
end

-- ==================== CHARACTER STATUS FUNCTIONS ====================

---Set character status (hunger, thirst, etc.)
---@param source number Player server ID
---@param status string JSON encoded status
function Framework.SetStatus(source, status)
    if isVorp then
        local user = Framework.GetUser(source)
        if not user then return end
        local character = Framework.GetCharacter(user)
        if not character or not character.setStatus then return end
        character.setStatus(status)
    elseif isRsg then
        local player = Framework.GetUser(source)
        if not player then return end
        -- RSG uses metadata for status
        local statusData = json.decode(status)
        if statusData then
            if statusData.Hunger then
                player.Functions.SetMetaData('hunger', statusData.Hunger)
            end
            if statusData.Thirst then
                player.Functions.SetMetaData('thirst', statusData.Thirst)
            end
        end
    end
end

---Get character status
---@param source number Player server ID
---@return string|nil JSON encoded status
function Framework.GetStatus(source)
    if isVorp then
        local user = Framework.GetUser(source)
        if not user then return nil end
        local character = Framework.GetCharacter(user)
        if not character or not character.status then return nil end
        return character.status
    elseif isRsg then
        local player = Framework.GetUser(source)
        if not player then return nil end
        local metadata = player.PlayerData.metadata
        if metadata then
            return json.encode({
                Hunger = metadata.hunger or 100,
                Thirst = metadata.thirst or 100
            })
        end
        return nil
    end
    return nil
end

-- ==================== INVENTORY FUNCTIONS ====================

---Register a usable item
---@param itemName string Item name
---@param callback function Callback function(data)
function Framework.RegisterUsableItem(itemName, callback)
    local invType = Config.Inventory or Config.Framework

    if invType == "vorp" then
        exports.vorp_inventory:registerUsableItem(itemName, callback)
    elseif invType == "rsg" then
        -- RSG uses RSGCore's CreateUseableItem or rsg-inventory export
        if Framework.Core and Framework.Core.Functions then
            Framework.Core.Functions.CreateUseableItem(itemName, callback)
        else
            -- Fallback: wait for core to load
            CreateThread(function()
                while not Framework.Core do Wait(100) end
                Framework.Core.Functions.CreateUseableItem(itemName, callback)
            end)
        end
    end
end

---Remove item from player inventory
---@param source number Player server ID
---@param itemId number|string Item ID or slot
---@param amount? number Amount to remove (default: 1)
function Framework.RemoveItem(source, itemId, amount)
    amount = amount or 1
    local invType = Config.Inventory or Config.Framework

    if invType == "vorp" then
        exports.vorp_inventory:subItemById(source, itemId)
    elseif invType == "rsg" then
        -- RSG inventory uses item name and amount
        exports['rsg-inventory']:RemoveItem(source, itemId, amount)
    end
end

---Close player inventory
---@param source number Player server ID
function Framework.CloseInventory(source)
    local invType = Config.Inventory or Config.Framework

    if invType == "vorp" then
        exports.vorp_inventory:closeInventory(source)
    elseif invType == "rsg" then
        TriggerClientEvent('rsg-inventory:client:closeInventory', source)
    end
end

-- ==================== ADMIN FUNCTIONS ====================

---Check if player is admin
---@param source number Player server ID
---@return boolean Is admin
function Framework.IsAdmin(source)
    if source <= 0 then return true end -- Console is always admin

    if isRsg then
        -- RSG uses HasPermission for admin check
        if Framework.Core and Framework.Core.Functions then
            return Framework.Core.Functions.HasPermission(source, 'admin') or IsPlayerAceAllowed(source, 'command')
        end
    elseif isVorp then
        -- VORP uses ACE permissions
        return IsPlayerAceAllowed(source, 'command') or IsPlayerAceAllowed(source, 'admin')
    end

    -- Fallback to ACE permission
    return IsPlayerAceAllowed(source, 'command')
end

-- ==================== UTILITY FUNCTIONS ====================

---Get weather from weathersync
---@return string Weather name
function Framework.GetWeather()
    local success, weather = pcall(function()
        return exports.weathersync:getWeather()
    end)
    if success then
        return weather
    end
    return "SUNNY"
end

print("^3[v-hud]^7 Server Framework Bridge loaded - Mode: " .. (isVorp and "VORP" or (isRsg and "RSG" or "UNKNOWN")))
