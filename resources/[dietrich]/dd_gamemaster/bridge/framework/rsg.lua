-- RSG framework implementation

Bridge = Bridge or {}

local impl = {}

-- Preload RSG core where available
if GetResourceState and GetResourceState('rsg-core') == 'started' then
    Bridge.RSGCore = exports['rsg-core']:GetCoreObject()
end

function impl.getPlayerData(src)
    if Bridge.isServer then
        local ply = Bridge.RSGCore and Bridge.RSGCore.Functions.GetPlayer(src)
        local pd  = ply and ply.PlayerData
        if pd then
            return {
                identifier = pd.license,
                citizenid  = pd.citizenid,
                charid     = pd.cid,
                name       = pd.charinfo and (pd.charinfo.firstname .. ' ' .. pd.charinfo.lastname) or 'Unknown',
                money      = pd.money and pd.money.cash or 0,
                job        = pd.job and pd.job.name or 'unemployed',
                bounty     = pd.metadata and pd.metadata.bounty or 0,
                honor      = pd.metadata and pd.metadata.honor or 0,
                wantedLevel = pd.metadata and pd.metadata.wantedLevel or 0,
                isWanted   = pd.metadata and pd.metadata.isWanted or false,
                group      = pd.gang and pd.gang.name or (pd.job and pd.job.name or 'default'),
                isMale     = pd.charinfo and pd.charinfo.gender == 0,
                isPlayer   = true
            }
        end
    else
        local ply = Bridge.RSGCore and Bridge.RSGCore.Functions.GetPlayerData()
        if ply then
            return {
                charid     = ply.cid,
                citizenid  = ply.citizenid,
                name       = ply.charinfo and (ply.charinfo.firstname .. ' ' .. ply.charinfo.lastname) or 'Unknown',
                money      = ply.money and ply.money.cash or 0,
                job        = ply.job and ply.job.name or 'unemployed',
                bounty     = ply.metadata and ply.metadata.bounty or 0,
                honor      = ply.metadata and ply.metadata.honor or 0,
                wantedLevel = ply.metadata and ply.metadata.wantedLevel or 0,
                isWanted   = ply.metadata and ply.metadata.isWanted or false,
                group      = ply.gang and ply.gang.name or (ply.job and ply.job.name or 'default'),
                isMale     = ply.charinfo and ply.charinfo.gender == 0,
                isPlayer   = true
            }
        end
    end
    return {}
end

function impl.setJob(src, job)
    if Bridge.RSGCore then
        Bridge.RSGCore.Functions.GetPlayer(src).PlayerData.job.name = job
    end
end

function impl.getJob(src)
    if Bridge.RSGCore then
        local ply = Bridge.RSGCore.Functions.GetPlayer(src)
        local pd  = ply and ply.PlayerData
        return pd and pd.job and pd.job.name or 'unemployed'
    end
    return 'unemployed'
end

function impl.giveItem(src, item, amount)
    local ply = Bridge.RSGCore and Bridge.RSGCore.Functions.GetPlayer(src)
    if ply and ply.PlayerData and ply.PlayerData.Functions and ply.PlayerData.Functions.AddItem then
        ply.PlayerData.Functions.AddItem(item, amount)
    end
end

function impl.removeItem(src, item, amount)
    local ply = Bridge.RSGCore and Bridge.RSGCore.Functions.GetPlayer(src)
    if ply and ply.PlayerData and ply.PlayerData.Functions and ply.PlayerData.Functions.RemoveItem then
        ply.PlayerData.Functions.RemoveItem(item, amount)
    end
end

function impl.giveWeapon(src, weapon, ammo)
    local ply = Bridge.RSGCore and Bridge.RSGCore.Functions.GetPlayer(src)
    if ply and ply.PlayerData and ply.PlayerData.Functions and ply.PlayerData.Functions.AddWeapon then
        ply.PlayerData.Functions.AddWeapon(weapon, ammo)
    end
end

function impl.giveMoney(src, amount)
    local ply = Bridge.RSGCore and Bridge.RSGCore.Functions.GetPlayer(src)
    if ply and ply.PlayerData then
        ply.PlayerData.money.cash = amount
    end
end

function impl.removeMoney(src, amount)
    local ply = Bridge.RSGCore and Bridge.RSGCore.Functions.GetPlayer(src)
    if ply and ply.PlayerData then
        ply.PlayerData.money.cash = amount
    end
end

function impl.notify(title, text, dict, icon, duration, color, src)
    local notifyType = 'inform'
    if color == 'COLOR_RED' then
        notifyType = 'error'
    elseif color == 'COLOR_GREEN' then
        notifyType = 'success'
    end
    local notifyData = { description = text, duration = duration, type = notifyType }
    if Bridge.isClient then
        -- Match legacy usage (client side TriggerClientEvent)
        TriggerClientEvent('ox_lib:notify', notifyData)
    else
        TriggerClientEvent('ox_lib:notify', src, notifyData)
    end
end

function impl.reloadPlayerPed(src)
    -- Match existing behavior: RSG command
    ExecuteCommand('loadskin')
end

function impl.registerUsableItem(itemName, cb)
    if not Bridge.isServer then return end
    local ok, err = pcall(function()
        if Bridge.RSGCore and Bridge.RSGCore.Functions and Bridge.RSGCore.Functions.CreateUseableItem then
            Bridge.RSGCore.Functions.CreateUseableItem(itemName, function(src, item)
                local usedName = (item and item.name) or itemName
                cb(src, usedName)
            end)
        end
    end)
    if not ok then Bridge.Debug('[Bridge] registerUsableItem rsg error: ', err) end
end

function impl.closeInventory(src)
    if not Bridge.isServer then return end
    TriggerClientEvent('rsg-inventory:client:close', src)
end

function impl.hasItem(src, itemName, amount)
    amount = amount or 1
    local player = Bridge.RSGCore and Bridge.RSGCore.Functions.GetPlayer(src)
    local itemData = player and player.Functions and player.Functions.GetItemByName and player.Functions.GetItemByName(itemName)
    local itemCount = itemData and (itemData.count or itemData.amount) or 0
    return itemCount >= amount
end

Bridge._fw_rsg = impl

