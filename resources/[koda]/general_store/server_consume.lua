--- Registers general_store consumables as useable items (independent from rsg-consume).

local RSGCore = exports['rsg-core']:GetCoreObject()

local function consumablesEnabled()
    return Config.ConsumablesEnabled ~= false
end

local function resolveConsumableRow(itemName)
    if type(itemName) ~= 'string' then return nil, nil end
    local key = itemName:lower()
    local row = Config.Consumables and (Config.Consumables[key] or Config.Consumables[itemName])
    if not row then return nil, key end
    return row, (row.item or key):lower()
end

local function registerConsumables()
    if not consumablesEnabled() then return end

    local registered = 0
    local skipped = 0

    for _, row in pairs(Config.Consumables or {}) do
        if row.enabled == false then goto continue end

        local canonical = (row.item or ''):lower()
        if canonical == '' then goto continue end

        if not RSGCore.Shared.Items[canonical] then
            skipped = skipped + 1
            print(('^3[general_store]^0 Consumable %q skipped — not in RSGCore.Shared.Items yet.'):format(canonical))
            goto continue
        end

        RSGCore.Functions.CreateUseableItem(canonical, function(source, item)
            TriggerClientEvent('general_store:client:useConsumable', source, item.name or canonical)
        end)
        registered = registered + 1

        ::continue::
    end

    print(('^2[general_store]^0 Consumables registered: %d (%d waiting for core items)'):format(registered, skipped))
end

CreateThread(function()
    Wait(1500)
    registerConsumables()
end)

RegisterNetEvent('general_store:server:consumeItem', function(itemName)
    local src = source
    if not consumablesEnabled() then return end

    local row, canonical = resolveConsumableRow(itemName)
    if not row then return end

    local Player = RSGCore.Functions.GetPlayer(src)
    if not Player then return end

    if not Player.Functions.RemoveItem(canonical, 1) then return end

    if RSGCore.Shared.Items[canonical] then
        TriggerClientEvent('rsg-inventory:client:ItemBox', src, RSGCore.Shared.Items[canonical], 'remove', 1)
    end

    if row.effects then
        TriggerClientEvent('general_store:client:applyConsumeEffects', src, row.effects)
    end
end)

RegisterNetEvent('general_store:server:broadcastConsumeAnim', function(itemName)
    local src = source
    if type(itemName) ~= 'string' or itemName == '' then return end

    local srcPed   = GetPlayerPed(src)
    local srcCoords = GetEntityCoords(srcPed)
    local players  = RSGCore.Functions.GetRSGPlayers()

    for _, v in pairs(players) do
        local tgt = v.PlayerData.source
        if tgt ~= src then
            local tgtPed    = GetPlayerPed(tgt)
            local tgtCoords = GetEntityCoords(tgtPed)
            if #(srcCoords - tgtCoords) <= 30.0 then
                TriggerClientEvent('general_store:client:consumeAnimRemote', tgt, src, itemName)
            end
        end
    end
end)

--- Optional runtime registration from another resource.
exports('RegisterConsumable', function(itemName, row)
    if type(itemName) ~= 'string' or type(row) ~= 'table' then return false end
    Config.Consumables = Config.Consumables or {}
    local key = itemName:lower()
    Config.Consumables[key] = row
    if RSGCore.Shared.Items[key] then
        RSGCore.Functions.CreateUseableItem(key, function(source, item)
            TriggerClientEvent('general_store:client:useConsumable', source, item.name or key)
        end)
        return true
    end
    return false
end)
