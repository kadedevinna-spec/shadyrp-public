

local Core = nil
local RSGCore = nil
local currentFramework = nil

local function DetectFramework()
    if not Config.Framework then
        if GetResourceState('rsg-core') == 'started' then
            Config.Framework = 'rsg-core'
        elseif GetResourceState('vorp_core') == 'started' or GetResourceState('vorp-core') == 'started' then
            Config.Framework = 'vorp'
        end
    end

    if Config.Framework == 'rsg-core' then
        currentFramework = "rsg"
        RSGCore = exports['rsg-core'] and exports['rsg-core']:GetCoreObject() or nil
        return RSGCore ~= nil
    elseif Config.Framework == 'vorp' then
        currentFramework = "vorp"
        Core = exports.vorp_core and exports.vorp_core:GetCore() or nil
        return Core ~= nil
    end

    return false
end

CreateThread(function()
    Wait(500)
    local warned = false
    while not DetectFramework() do
        if not warned then
           print("^1[v-bridge]^7 UYARI: Not found supported framework ! (rsg-core or vorp_core)")
           print("^1[v-bridge]^7 Bridge not work.")
            warned = true
        end
        Wait(2000)
    end

    if currentFramework == "rsg" then
       print("^2[v-bridge]^7 RSG Core  succesfully worked")
    elseif currentFramework == "vorp" then
       print("^2[v-bridge]^7 VORP Core succesfully worked!")
    end

   print("^2[v-bridge]^7 Server-side succesfully worked! Framework: " .. (currentFramework or "Bilinmiyor"))
end)


---@return string|nil
local function GetFramework()
    return currentFramework
end

---@param source number
---@return table|nil
local function GetPlayer(source)
    if not source then return nil end
    
    if currentFramework == "vorp" and Core then
        return Core.getUser(source)
    elseif currentFramework == "rsg" and RSGCore then
        return RSGCore.Functions.GetPlayer(source)
    end
    
    return nil
end

local function ResolveLicense(source, user)
    local license = user and user.PlayerData and user.PlayerData.license or nil
    if not license and GetPlayerIdentifierByType then
        license = GetPlayerIdentifierByType(source, "license")
    end
    if not license and GetPlayerIdentifier then
        license = GetPlayerIdentifier(source, 0)
    end
    return license
end

---@param source number
---@return table|nil
local function GetCharacter(source)
    local user = GetPlayer(source)
    if not user then return nil end
    
    if currentFramework == "vorp" then
        if type(user.getUsedCharacter) == 'function' then
            return user.getUsedCharacter()
        else
            return user.getUsedCharacter
        end
    elseif currentFramework == "rsg" then
        local citizenid = user.PlayerData.citizenid
        local cid = user.PlayerData.cid or user.PlayerData.charIdentifier or user.PlayerData.charidentifier
            or user.PlayerData.characterId or (user.PlayerData.metadata and user.PlayerData.metadata.cid)
        local license = ResolveLicense(source, user)
        return {
            money = user.PlayerData.money['cash'] or 0,
            job = user.PlayerData.job.name,
            jobGrade = user.PlayerData.job.grade.level,
            identifier = license or citizenid,
            charIdentifier = cid or citizenid,
            citizenid = citizenid,
            cid = cid,
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

---@param source number
---@return table|nil
local function GetPlayerData(source)
    local character = GetCharacter(source)
    if not character then return nil end
    
    return {
        money = character.money or 0,
        job = character.job,
        grade = character.jobGrade or character.grade,
        identifier = character.identifier or character.charIdentifier,
        source = source
    }
end


---@param source number
---@param amount number
---@param moneyType string|nil 
---@return boolean
local function AddMoney(source, amount, moneyType)
    if not source or not amount or amount <= 0 then return false end
    
    local player = GetPlayer(source)
    if not player then return false end
    
    moneyType = moneyType or "cash"
    
    if currentFramework == "vorp" then
        local character = GetCharacter(source)
        if character then
            character.addCurrency(0, amount)
            return true
        end
    elseif currentFramework == "rsg" then
        player.Functions.AddMoney(moneyType, amount)
        return true
    end
    
    return false
end

---@param source number
---@param amount number
---@param moneyType string|nil
---@return boolean
local function RemoveMoney(source, amount, moneyType)
    if not source or not amount or amount <= 0 then return false end
    
    local player = GetPlayer(source)
    if not player then return false end
    
    moneyType = moneyType or "cash"
    
    if currentFramework == "vorp" then
        local character = GetCharacter(source)
        if character then
            character.removeCurrency(0, amount)
            return true
        end
    elseif currentFramework == "rsg" then
        player.Functions.RemoveMoney(moneyType, amount)
        return true
    end
    
    return false
end

---@param source number
---@param amount number
---@param moneyType string|nil 
---@return boolean
local function HasMoney(source, amount, moneyType)
    if not source or not amount then return false end
    
    local character = GetCharacter(source)
    if not character then return false end
    
    moneyType = moneyType or "cash"
    
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


---@param source number
---@param itemName string
---@param amount number
---@param metadata table|nil
---@return boolean
local function AddItem(source, itemName, amount, metadata)
    if not source or not itemName or not amount or amount <= 0 then return false end
    
    if currentFramework == "vorp" then
        if itemName:find("^WEAPON_") then
            return exports.vorp_inventory:createWeapon(source, itemName, metadata or {["ammo"] = 0}, {})
        else
            return exports.vorp_inventory:addItem(source, itemName, amount, metadata)
        end
    elseif currentFramework == "rsg" then
        local player = GetPlayer(source)
        if player then
            return player.Functions.AddItem(itemName, amount, false, metadata)
        end
    end
    
    return false
end

---@param source number
---@param itemName string
---@param amount number
---@param weaponId number|nil 
---@return boolean
local function RemoveItem(source, itemName, amount, weaponId)
    if not source or not itemName or not amount or amount <= 0 then return false end
    
    if currentFramework == "vorp" then
        if itemName:find("^WEAPON_") and weaponId then
            return exports.vorp_inventory:subWeapon(source, weaponId)
        else
            return exports.vorp_inventory:subItem(source, itemName, amount)
        end
    elseif currentFramework == "rsg" then
        local player = GetPlayer(source)
        if player then
            return player.Functions.RemoveItem(itemName, amount)
        end
    end
    
    return false
end

---@param source number
---@param itemName string
---@param amount number
---@return boolean
local function HasItem(source, itemName, amount)
    if not source or not itemName then return false end
    amount = amount or 1
    
    if currentFramework == "vorp" then
        local items = exports.vorp_inventory:getUserInventoryItems(source)
        for _, item in pairs(items) do
            if item.name == itemName then
                return (item.count or 0) >= amount
            end
        end
        return false
    elseif currentFramework == "rsg" then
        local player = GetPlayer(source)
        if player then
            local item = player.Functions.GetItemByName(itemName)
            return item and (item.amount or 0) >= amount
        end
    end
    
    return false
end

---@param source number
---@param itemName string
---@param amount number
---@return boolean
local function CanCarryItem(source, itemName, amount)
    if not source or not itemName or not amount then return false end
    
    if currentFramework == "vorp" then
        if itemName:find("^WEAPON_") then
            return exports.vorp_inventory:canCarryWeapons(source, 1, nil, itemName)
        else
            return exports.vorp_inventory:canCarryItem(source, itemName, amount)
        end
    elseif currentFramework == "rsg" then
        return exports['rsg-inventory']:CanAddItem(source, itemName, amount)
    end
    
    return false
end

---@param source number
---@return table
local function GetInventory(source)
    if not source then return {} end
    
    if currentFramework == "vorp" then
        return exports.vorp_inventory:getUserInventoryItems(source) or {}
    elseif currentFramework == "rsg" then
        local player = GetPlayer(source)
        if player then
            return player.PlayerData.items or {}
        end
    end
    
    return {}
end


---@param source number|nil 
---@param message string
---@param duration number|nil
---@param notifyType string|nil 
local function Notify(source, message, duration, notifyType)
    if not message then return end
    duration = duration or 5000
    
    if currentFramework == "vorp" then
        if source then
            TriggerClientEvent("vorp:TipBottom", source, message, duration)
        else
           print("^3[v-bridge]^7 " .. message)
        end
    elseif currentFramework == "rsg" then
        if source then
            local type = notifyType or 'inform'
            if notifyType == 'success' then
                type = 'success'
            elseif notifyType == 'error' then
                type = 'error'
            elseif notifyType == 'warning' then
                type = 'warning'
            else
                type = 'inform'
            end
            
            TriggerClientEvent('ox_lib:notify', source, {
                title = message,
                type = type,
                duration = duration
            })
        else
           print("^3[v-bridge]^7 " .. message)
        end
    else
       print("^3[v-bridge]^7 " .. message)
    end
end


---@param source number
---@return string|nil, number|nil
local function GetJob(source)
    local character = GetCharacter(source)
    if not character then return nil, nil end
    return character.job, character.jobGrade or character.grade
end

---@param source number
---@param jobName string
---@param grade number|nil
---@return boolean
local function HasJob(source, jobName, grade)
    local job, jobGrade = GetJob(source)
    if not job or job ~= jobName then return false end
    if grade then
        return jobGrade == grade
    end
    
    return true
end

exports('GetFramework', GetFramework)
exports('GetPlayer', GetPlayer)
exports('GetCharacter', GetCharacter)
exports('GetPlayerData', GetPlayerData)
exports('AddMoney', AddMoney)
exports('RemoveMoney', RemoveMoney)
exports('HasMoney', HasMoney)
exports('AddItem', AddItem)
exports('RemoveItem', RemoveItem)
exports('HasItem', HasItem)
exports('CanCarryItem', CanCarryItem)
exports('GetInventory', GetInventory)
exports('Notify', Notify)
exports('GetJob', GetJob)
exports('HasJob', HasJob)


VBridge = {
    GetFramework = GetFramework,
    GetPlayer = GetPlayer,
    GetCharacter = GetCharacter,
    GetPlayerData = GetPlayerData,
    AddMoney = AddMoney,
    RemoveMoney = RemoveMoney,
    HasMoney = HasMoney,
    AddItem = AddItem,
    RemoveItem = RemoveItem,
    HasItem = HasItem,
    CanCarryItem = CanCarryItem,
    GetInventory = GetInventory,
    Notify = Notify,
    GetJob = GetJob,
    HasJob = HasJob
}


