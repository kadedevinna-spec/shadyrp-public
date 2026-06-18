-- VORP framework implementation

Bridge = Bridge or {}

local impl = {}

-- Preload VORP core where available (server only uses it for user/character)
if GetResourceState and GetResourceState('vorp_core') == 'started' then
    Bridge.VorpCore = exports.vorp_core:GetCore()
end

function impl.getPlayerData(src)
    if Bridge.isServer then
        local user = Bridge.VorpCore and Bridge.VorpCore.getUser(src)
        local char = user and user.getUsedCharacter
        if char then
            return {
                identifier = char.identifier,
                charid     = char.charIdentifier,
                name       = char.firstname and (char.firstname .. ' ' .. (char.lastname or '')) or 'Unknown',
                money      = char.money,
                job        = char.job,
                bounty     = char.bounty or 0,
                honor      = char.honor or 0,
                wantedLevel = char.wantedLevel or 0,
                isWanted   = (char.wantedLevel or 0) > 0,
                group      = char.group or 'default',
                isMale     = char.gender == 'Male',
                isPlayer   = true
            }
        end
    else
        local char = LocalPlayer and LocalPlayer.state and LocalPlayer.state.Character
        if char then
            return {
                charid     = char.CharId,
                name       = char.FirstName and (char.FirstName .. ' ' .. (char.LastName or '')) or 'Unknown',
                money      = char.Money,
                job        = char.Job,
                bounty     = char.Bounty or 0,
                honor      = char.Honor or 0,
                wantedLevel = char.WantedLevel or 0,
                isWanted   = (char.WantedLevel or 0) > 0,
                group      = char.Group or 'default',
                isMale     = char.Gender == 'Male',
                isPlayer   = true
            }
        end
    end
    return {}
end

function impl.setJob(src, job)
    if Bridge.VorpCore then
        Bridge.VorpCore.getUser(src).getUsedCharacter.setJob(job)
    end
end

function impl.getJob(src)
    if Bridge.VorpCore then
        local char = Bridge.VorpCore.getUser(src).getUsedCharacter
        return char and char.job or 'unemployed'
    end
    return 'unemployed'
end

function impl.giveItem(src, item, amount)
    if GetResourceState('vorp_inventory') == 'started' then
        exports.vorp_inventory:addItem(src, item, amount)
    end
end

function impl.removeItem(src, item, amount)
    if GetResourceState('vorp_inventory') == 'started' then
        exports.vorp_inventory:removeItem(src, item, amount)
    end
end

function impl.giveWeapon(src, weapon, ammo)
    if GetResourceState('vorp_inventory') == 'started' then
        exports.vorp_inventory:createWeapon(src, weapon, {}, {}, {}, function(success)
            if not success then
                print(('^3[WARNING] Failed to add weapon: %s^7'):format(weapon))
            end
        end)
    end
end

function impl.giveMoney(src, amount)
    if Bridge.VorpCore then
        Bridge.VorpCore.getUser(src).getUsedCharacter.addCurrency(0, amount)
    end
end

function impl.removeMoney(src, amount)
    if Bridge.VorpCore then
        Bridge.VorpCore.getUser(src).getUsedCharacter.removeCurrency(0, amount)
    end
end

function impl.notify(title, text, dict, icon, duration, color, src)
    if Bridge.isClient then
        if Bridge.VorpCore and Bridge.VorpCore.NotifyLeft then
            Bridge.VorpCore.NotifyLeft(title, text, dict, icon, duration, color)
        end
    else
        if Bridge.VorpCore and Bridge.VorpCore.NotifyLeft then
            Bridge.VorpCore.NotifyLeft(src, title, text, dict, icon, duration, color)
        end
    end
end

function impl.reloadPlayerPed(src)
    -- Match existing behavior: use VORP command
    ExecuteCommand('rc')
end

function impl.registerUsableItem(itemName, cb)
    if not Bridge.isServer then return end
    if GetResourceState('vorp_inventory') == 'started' then
        local ok, err = pcall(function()
            local res = (GetCurrentResourceName and GetCurrentResourceName()) or 'dd_gamemaster'
            exports.vorp_inventory:registerUsableItem(itemName, function(data)
                local src = (data and data.source) or source
                local usedName = (data and data.name) or itemName
                cb(src, usedName)
            end, res)
        end)
        if not ok then Bridge.Debug('[Bridge] registerUsableItem vorp error: ', err) end
    end
end

function impl.closeInventory(src)
    if not Bridge.isServer then return end
    TriggerClientEvent('vorp_inventory:CloseInv', src)
end

function impl.hasItem(src, itemName, amount)
    amount = amount or 1
    local itemCount = 0
    if GetResourceState('vorp_inventory') == 'started' then
        exports.vorp_inventory:getItemCount(src, function(result)
            itemCount = result
        end, itemName)
    end
    return itemCount >= amount
end

Bridge._fw_vorp = impl

