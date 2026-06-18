--- Server side of clerk robbery — pays player, enforces cooldown, alerts police.

local RSGCore = exports['rsg-core']:GetCoreObject()

-- storeId → epoch ms when this store can be robbed again
local cooldowns = {}
-- storeId → source (first player currently aiming / robbing this clerk)
local aimHolders = {}
-- storeId → { holder = source, reaction = 'surrender' | 'fight' }
local clerkReactions = {}
local function cfg()
    return Config.Robbery or {}
end

local function clearReactionForSource(src)
    for storeId, data in pairs(clerkReactions) do
        if data.holder == src then
            clerkReactions[storeId] = nil
        end
    end
end

local function rollClerkReaction()
    local chance = cfg().clerkFightChance or 0.0
    if chance <= 0.0 then return 'surrender' end
    if chance >= 1.0 then return 'fight' end
    return math.random() < chance and 'fight' or 'surrender'
end

local function isEnabled()
    return cfg().enabled ~= false
end

local function clearHolderForSource(src)
    for storeId, holder in pairs(aimHolders) do
        if holder == src then
            aimHolders[storeId] = nil
        end
    end
    clearReactionForSource(src)
end

local function storeOnCooldown(storeId)
    local until_ms = cooldowns[storeId]
    if not until_ms then return false end
    if GetGameTimer() >= until_ms then
        cooldowns[storeId] = nil
        return false
    end
    return true
end

local function rollReward()
    local lo = math.max(1, cfg().rewardMin or 50)
    local hi = math.max(lo, cfg().rewardMax or 250)
    return math.random(lo, hi)
end

local function rollRegisterReward()
    local lo = math.max(1, cfg().registerRewardMin or cfg().rewardMin or 80)
    local hi = math.max(lo, cfg().registerRewardMax or cfg().rewardMax or 250)
    return math.random(lo, hi)
end

local function storeLabel(storeId)
    local def = (Config.Stores or {})[storeId]
    if def and def.label and def.label ~= '' then
        return def.label
    end
    return tostring(storeId)
end

local function formatPoliceAlert(template, storeId)
    local label = storeLabel(storeId)
    local base  = template or 'General Store robbery in progress!'
    if base:find('%%s') then
        return string.format(base, label)
    end
    return ('%s — %s'):format(base, label)
end

local function alertPolice(src, storeId, alertText)
    if type(storeId) ~= 'string' then return end

    local ped     = GetPlayerPed(src)
    local coords  = GetEntityCoords(ped)
    local players = RSGCore.Functions.GetRSGPlayers()
    local text    = formatPoliceAlert(alertText, storeId)
    local c       = cfg()
    local needDuty = c.alertLeoMustBeOnDuty ~= false

    print(('[general_store] alertPolice storeId=%s text=%s needDuty=%s'):format(storeId, text, tostring(needDuty)))

    local sent = 0
    for _, v in pairs(players) do
        local job = v.PlayerData and v.PlayerData.job
        print(('[general_store]   player %s job=%s type=%s onduty=%s'):format(
            tostring(v.PlayerData and v.PlayerData.source),
            job and job.name or 'nil',
            job and job.type or 'nil',
            tostring(job and job.onduty)
        ))
        if job and job.type == 'leo' and (not needDuty or job.onduty) then
            TriggerClientEvent('rsg-lawman:client:lawmanAlert', v.PlayerData.source, coords, text)
            sent = sent + 1
        end
    end
    print(('[general_store] alertPolice sent to %d player(s)'):format(sent))
end

RSGCore.Functions.CreateCallback('general_store:server:claimRobberyAim', function(source, cb, storeId)
    if not isEnabled() then cb(false) return end
    if type(storeId) ~= 'string' or not (Config.Stores or {})[storeId] then cb(false) return end

    local holder = aimHolders[storeId]
    if holder and holder ~= source then
        cb(false, 'busy')
        return
    end

    if storeOnCooldown(storeId) then
        local left = cooldowns[storeId] - GetGameTimer()
        if left > 0 then
            TriggerClientEvent('general_store:client:storeRobberyCooldown', source, storeId, left)
        end
        cb(false, 'cooldown')
        return
    end

    local reactionData = clerkReactions[storeId]
    if holder == source and reactionData and reactionData.holder == source then
        cb(true, reactionData.reaction)
        return
    end

    local reaction = rollClerkReaction()
    aimHolders[storeId] = source
    clerkReactions[storeId] = { holder = source, reaction = reaction }
    cb(true, reaction)
end)

RSGCore.Functions.CreateCallback('general_store:server:getRobberyCooldowns', function(_, cb)
    local out = {}
    for storeId, untilMs in pairs(cooldowns) do
        local left = untilMs - GetGameTimer()
        if left > 0 then
            out[storeId] = left
        else
            cooldowns[storeId] = nil
        end
    end
    cb(out)
end)

-- Syncs clerk surrender anim to nearby players (excluding robber who already plays it locally)
RegisterNetEvent('general_store:server:syncClerkAnim', function(netId, dict, clip, flag, duration, looped)
    local src     = source
    local srcPed  = GetPlayerPed(src)
    local srcPos  = GetEntityCoords(srcPed)
    local players = RSGCore.Functions.GetRSGPlayers()

    for _, v in pairs(players) do
        local tgt = v.PlayerData.source
        if tgt ~= src then
            local tgtPos = GetEntityCoords(GetPlayerPed(tgt))
            if #(srcPos - tgtPos) <= 60.0 then
                TriggerClientEvent('general_store:client:syncClerkAnim', tgt, netId, dict, clip, flag or 1, duration or -1)
            end
        end
    end
end)

RegisterNetEvent('general_store:server:syncClerkAnimStop', function(netId)
    local src     = source
    local srcPed  = GetPlayerPed(src)
    local srcPos  = GetEntityCoords(srcPed)
    local players = RSGCore.Functions.GetRSGPlayers()

    for _, v in pairs(players) do
        local tgt = v.PlayerData.source
        if tgt ~= src then
            local tgtPos = GetEntityCoords(GetPlayerPed(tgt))
            if #(srcPos - tgtPos) <= 60.0 then
                TriggerClientEvent('general_store:client:syncClerkAnimStop', tgt, netId)
            end
        end
    end
end)

RegisterNetEvent('general_store:server:releaseRobberyAim', function(storeId)
    local src = source
    if type(storeId) == 'string' and aimHolders[storeId] == src then
        aimHolders[storeId] = nil
        local data = clerkReactions[storeId]
        if data and data.holder == src then
            clerkReactions[storeId] = nil
        end
    end
end)

RegisterNetEvent('general_store:server:clerkFightback', function(storeId)
    local src = source
    if not isEnabled() then return end
    if type(storeId) ~= 'string' or not (Config.Stores or {})[storeId] then return end
    if aimHolders[storeId] ~= src then return end

    local data = clerkReactions[storeId]
    if not data or data.holder ~= src or data.reaction ~= 'fight' then return end

    -- Track robber so we can notify them when clerk dies
    clerkReactions[storeId].src = src

    alertPolice(src, storeId, cfg().clerkFightAlertText or cfg().alertText)

    pcall(function()
        TriggerEvent('rsg-lawman:server:updateoutlawstatus', 180, 'general_store_clerk_fight')
    end)
end)

-- Robber client notifies server that clerk died — server sends register lootable back to them
RegisterNetEvent('general_store:server:clerkKilledInFight', function(storeId)
    local src = source
    if type(storeId) ~= 'string' or not (Config.Stores or {})[storeId] then return end
    -- Validate src is the legit robber for this store
    local data = clerkReactions[storeId]
    if not data or (data.holder ~= src and data.src ~= src) then return end
    TriggerClientEvent('general_store:client:markRegisterLootable', src, storeId)
end)

RegisterNetEvent('general_store:server:robRegister', function(storeId)
    local src = source
    if not isEnabled() then return end
    if type(storeId) ~= 'string' or not (Config.Stores or {})[storeId] then return end

    if storeOnCooldown(storeId) then
        local left = cooldowns[storeId] - GetGameTimer()
        if left > 0 then
            TriggerClientEvent('general_store:client:storeRobberyCooldown', src, storeId, left)
        end
        TriggerClientEvent('general_store:client:robberyResult', src, false, 'cooldown', 0, storeId)
        return
    end

    local Player = RSGCore.Functions.GetPlayer(src)
    if not Player then return end

    local reward    = rollRegisterReward()
    local moneyType = (cfg().moneyType or 'cash'):lower()

    Player.Functions.AddMoney(moneyType, reward, 'general-store-register-robbery')

    local cdMs = cfg().cooldown or (30 * 60 * 1000)
    cooldowns[storeId] = GetGameTimer() + cdMs
    aimHolders[storeId] = nil
    clerkReactions[storeId] = nil

    TriggerClientEvent('general_store:client:storeRobberyCooldown', -1, storeId, cdMs)

    alertPolice(src, storeId, cfg().alertText)
    pcall(function()
        TriggerEvent('rsg-lawman:server:updateoutlawstatus', 250, 'general_store_robbery')
    end)

    TriggerClientEvent('general_store:client:robberyResult', src, true, 'register_ok', reward, storeId)
end)

AddEventHandler('playerDropped', function()
    clearHolderForSource(source)
end)

RegisterNetEvent('general_store:server:robClerk', function(storeId)
    local src = source

    if not isEnabled() then
        TriggerClientEvent('general_store:client:robberyResult', src, false, 'disabled', 0)
        return
    end

    if type(storeId) ~= 'string' or not (Config.Stores or {})[storeId] then
        TriggerClientEvent('general_store:client:robberyResult', src, false, 'unknown_store', 0)
        return
    end

    if aimHolders[storeId] ~= src then
        TriggerClientEvent('general_store:client:robberyResult', src, false, 'not_holder', 0)
        return
    end

    local reactionData = clerkReactions[storeId]
    if reactionData and reactionData.holder == src and reactionData.reaction == 'fight' then
        TriggerClientEvent('general_store:client:robberyResult', src, false, 'clerk_fighting', 0, storeId)
        return
    end

    if storeOnCooldown(storeId) then
        local left = cooldowns[storeId] - GetGameTimer()
        if left > 0 then
            TriggerClientEvent('general_store:client:storeRobberyCooldown', src, storeId, left)
        end
        TriggerClientEvent('general_store:client:robberyResult', src, false, 'cooldown', 0, storeId)
        return
    end

    local Player = RSGCore.Functions.GetPlayer(src)
    if not Player then
        TriggerClientEvent('general_store:client:robberyResult', src, false, 'no_player', 0)
        return
    end

    local reward    = rollReward()
    local moneyType = (cfg().moneyType or 'cash'):lower()

    Player.Functions.AddMoney(moneyType, reward, 'general-store-robbery')
    local cdMs = cfg().cooldown or (30 * 60 * 1000)
    cooldowns[storeId] = GetGameTimer() + cdMs

    TriggerClientEvent('general_store:client:storeRobberyCooldown', -1, storeId, cdMs)

    alertPolice(src, storeId, cfg().alertText)

    -- Player gets a small "wanted" bump if you use rsg-lawman outlaw status
    pcall(function()
        TriggerEvent('rsg-lawman:server:updateoutlawstatus', 250, 'general_store_robbery')
    end)

    TriggerClientEvent('general_store:client:robberyResult', src, true, 'ok', reward, storeId)
end)
