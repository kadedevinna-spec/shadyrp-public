local RSGCore = exports['rsg-core']:GetCoreObject()
lib.locale()

local LootedGraves = {}

lib.callback.register('devchacha-graverobbery:server:CheckCooldown', function(source, cooldownKey)
    if LootedGraves[cooldownKey] then
        return true
    end
    return false
end)

local function GetWeightedReward(rewards)
    local totalWeight = 0
    for _, r in ipairs(rewards) do
        totalWeight = totalWeight + (r.weight or 1)
    end

    local roll = math.random(totalWeight)
    local cumulative = 0
    for _, r in ipairs(rewards) do
        cumulative = cumulative + (r.weight or 1)
        if roll <= cumulative then
            local amount = math.random(r.min or 1, r.max or 1)
            return r.item, amount
        end
    end

    local fallback = rewards[1]
    return fallback.item, math.random(fallback.min or 1, fallback.max or 1)
end

RegisterNetEvent('devchacha-graverobbery:server:RobGrave', function(cooldownKey)
    local src = source
    local Player = RSGCore.Functions.GetPlayer(src)
    if not Player then return end

    local loot = Config.Loot
    if not loot then return end

    LootedGraves[cooldownKey] = true

    if Config.RequiredItem and Config.ConsumeItem then
        Player.Functions.RemoveItem(Config.RequiredItem, 1)
        TriggerClientEvent('inventory:client:ItemBox', src, RSGCore.Shared.Items[Config.RequiredItem], "remove")
    end

    local roll = math.random(100)
    if roll > (loot.chance or 75) then
        TriggerClientEvent('ox_lib:notify', src, { type = 'error', description = 'Nothing but dirt and bones...' })
        return
    end

    local item, amount = GetWeightedReward(loot.rewards)

    if item == 'gold_bar' and amount > 1 then
        amount = 1
    end

    if not RSGCore.Shared.Items[item] then
        print("[GraveRobbery] WARNING: Invalid item in config: " .. tostring(item))
        TriggerClientEvent('ox_lib:notify', src, { type = 'error', description = "Error: Item '" .. tostring(item) .. "' not registered!" })
        return
    end

    Player.Functions.AddItem(item, amount)
    TriggerClientEvent('inventory:client:ItemBox', src, RSGCore.Shared.Items[item], "add")

    local label = RSGCore.Shared.Items[item].label or item
    TriggerClientEvent('ox_lib:notify', src, {
        type = 'success',
        description = 'You found ' .. amount .. 'x ' .. label
    })

    if loot.cash then
        local cashAmount = math.random(loot.cash.min, loot.cash.max)
        if cashAmount > 0 then
            Player.Functions.AddMoney('cash', cashAmount, 'grave-robbery-loot')
            TriggerClientEvent('ox_lib:notify', src, {
                type = 'success',
                description = 'Found $' .. cashAmount .. ' in the coffin!'
            })
        end
    end
end)

RegisterNetEvent('devchacha-graverobbery:server:AlertPolice', function(coords)
    local players = RSGCore.Functions.GetRSGPlayers()

    if not players or type(players) ~= 'table' then
        players = RSGCore.Functions.GetPlayers()
    end

    local notifiedCount = 0
    for _, v in pairs(players) do
        local Player = nil
        local src = nil

        if type(v) == 'table' then
            Player = v
            src = Player.PlayerData.source
        else
            src = tonumber(v)
            Player = RSGCore.Functions.GetPlayer(src)
        end

        if Player then
            local job = Player.PlayerData.job.name
            for _, pJob in pairs(Config.Police.Jobs) do
                if job == pJob then
                    TriggerClientEvent('devchacha-graverobbery:client:policeAlert', src, coords)
                    TriggerClientEvent('ox_lib:notify', src, {
                        type = 'error',
                        description = 'Report: Grave Robbery in Progress!',
                        duration = 10000
                    })
                    notifiedCount = notifiedCount + 1
                end
            end
        end
    end

    if Config.Debug then
        print('[GraveRobbery] Police alerted: ' .. notifiedCount .. ' officers notified.')
    end
end)
