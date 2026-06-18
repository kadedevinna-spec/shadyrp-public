
local RSGCore = nil
local currentFramework = nil
local currentClothing = nil
local PlayerData = {
    money = 0,
    job = nil,
    grade = nil,
    identifier = nil
}

local function DetectClothingMenu()
    if Config.ClothingMenu then
        currentClothing = Config.ClothingMenu
        return currentClothing
    end

    if GetResourceState('v-appearance') == 'started' then
        currentClothing = 'v-appearance'
        return currentClothing
    end

    if GetResourceState('vorp_character') == 'started' or GetResourceState('vorp-character') == 'started' then
        currentClothing = 'vorp_character'
        return currentClothing
    end

    currentClothing = nil
    return currentClothing
end

local function RunAppearanceRestore()
    CreateThread(function()
        Wait(1000)
        local clothing = DetectClothingMenu()
        if clothing == 'v-appearance' then
            ExecuteCommand('refreshskin')
            return
        end

        if clothing == 'vorp_character' then
            ExecuteCommand('rc')
            return
        end

        if currentFramework == 'rsg' then
            ExecuteCommand('loadskin')
        end
    end)
end

CreateThread(function()
    Wait(500)
    local warned = false

    local function detectFramework()
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
            return true
        end

        return false
    end

    while not detectFramework() do
        if not warned then
           print("^1[v-bridge]^7 UYARI: Not found supported framework ! (rsg-core or vorp_core)")
           print("^1[v-bridge]^7 Bridge not work.")
            warned = true
        end
        Wait(2000)
    end

    if currentFramework == "rsg" then
       print("^2[v-bridge]^7 RSG Core client succesfully worked")
    elseif currentFramework == "vorp" then
       print("^2[v-bridge]^7 VORP Core client succesfully worked")
    end

   print("^2[v-bridge]^7 Client-side bridge not work! Framework: " .. (currentFramework or "Unkown"))

    UpdatePlayerData()
    DetectClothingMenu()
end)

---@return string|nil
local function GetFramework()
    return currentFramework
end

function UpdatePlayerData()
    if currentFramework == "vorp" then
        if LocalPlayer.state.Character then
            PlayerData.money = LocalPlayer.state.Character.Money or 0
            PlayerData.job = LocalPlayer.state.Character.Job
            PlayerData.grade = LocalPlayer.state.Character.Grade
            PlayerData.identifier = LocalPlayer.state.Character.charIdentifier
        end
    elseif currentFramework == "rsg" and RSGCore then
        local playerData = RSGCore.Functions.GetPlayerData()
        if playerData then
            PlayerData.money = playerData.money and playerData.money.cash or 0
            PlayerData.job = playerData.job and playerData.job.name
            PlayerData.grade = playerData.job and playerData.job.grade and playerData.job.grade.level
            PlayerData.identifier = playerData.citizenid
        end
    end
end

---@return table
local function GetPlayerData()
    UpdatePlayerData()
    return PlayerData
end

---@return number
local function GetMoney()
    UpdatePlayerData()
    return PlayerData.money or 0
end

---@return string|nil, number|nil
local function GetJob()
    UpdatePlayerData()
    return PlayerData.job, PlayerData.grade
end

---@param jobName string
---@param grade number|nil
---@return boolean
local function HasJob(jobName, grade)
    local job, jobGrade = GetJob()
    if not job or job ~= jobName then return false end
    
    if grade then
        return jobGrade == grade
    end
    
    return true
end


---@return table
local function GetInventory()
    if currentFramework == "vorp" then
        if exports.vorp_inventory and exports.vorp_inventory.getInventoryItems then
            return exports.vorp_inventory:getInventoryItems() or {}
        end
    elseif currentFramework == "rsg" and RSGCore then
        local playerData = RSGCore.Functions.GetPlayerData()
        if playerData then
            return playerData.items or {}
        end
    end
    
    return {}
end

---@param itemName string
---@param amount number|nil
---@return boolean
local function HasItem(itemName, amount)
    if not itemName then return false end
    amount = amount or 1
    
    local inventory = GetInventory()
    for _, item in pairs(inventory) do
        if item.name == itemName then
            local count = item.count or item.amount or 0
            return count >= amount
        end
    end
    
    return false
end

---@param itemName string
---@return number
local function GetItemCount(itemName)
    if not itemName then return 0 end
    
    local inventory = GetInventory()
    for _, item in pairs(inventory) do
        if item.name == itemName then
            return item.count or item.amount or 0
        end
    end
    
    return 0
end


---@param message string
---@param duration number|nil
---@param notifyType string|nil 
local function Notify(message, duration, notifyType)
    if not message then return end
    duration = duration or 5000
    
    if currentFramework == "vorp" then
        TriggerEvent("vorp:TipBottom", message, duration)
    elseif currentFramework == "rsg" then
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
        
        TriggerEvent('ox_lib:notify', {
            title = message,
            type = type,
            duration = duration
        })
    else
       print("^3[v-bridge]^7 " .. message)
    end
end

RegisterNetEvent('v-lib:notify')
AddEventHandler('v-lib:notify', function(message, _title, duration, notifyType)
    Notify(message, duration, notifyType)
end)

RegisterNetEvent('v-ped:notify')
AddEventHandler('v-ped:notify', function(message, notifyType)
    Notify(message, 3000, notifyType)
end)


if Config.Framework == 'rsg-core' then
    RegisterNetEvent('RSGCore:Client:OnPlayerLoaded', function()
        UpdatePlayerData()
    end)
    
    RegisterNetEvent('RSGCore:Player:SetPlayerData', function(val)
        if val.money then
            PlayerData.money = val.money.cash or 0
        end
        if val.job then
            PlayerData.job = val.job.name
            PlayerData.grade = val.job.grade.level
        end
    end)
    
    RegisterNetEvent('RSGCore:Client:OnMoneyChange', function()
        UpdatePlayerData()
    end)
end

if Config.Framework == 'vorp' then
    CreateThread(function()
        while true do
            Wait(1000)
            if LocalPlayer.state.Character then
                UpdatePlayerData()
            end
        end
    end)
end

RegisterNetEvent('v-ped:frameworkRestore')
AddEventHandler('v-ped:frameworkRestore', function()
    RunAppearanceRestore()
end)

RegisterNetEvent('v-peds:frameworkRestore')
AddEventHandler('v-peds:frameworkRestore', function()
    RunAppearanceRestore()
end)


exports('GetFramework', GetFramework)
exports('GetPlayerData', GetPlayerData)
exports('GetMoney', GetMoney)
exports('GetJob', GetJob)
exports('HasJob', HasJob)
exports('GetInventory', GetInventory)
exports('HasItem', HasItem)
exports('GetItemCount', GetItemCount)
exports('Notify', Notify)


VBridge = {
    GetFramework = GetFramework,
    GetPlayerData = GetPlayerData,
    GetMoney = GetMoney,
    GetJob = GetJob,
    HasJob = HasJob,
    GetInventory = GetInventory,
    HasItem = HasItem,
    GetItemCount = GetItemCount,
    Notify = Notify
}

-- Framework log is emitted after detection in the init thread.

