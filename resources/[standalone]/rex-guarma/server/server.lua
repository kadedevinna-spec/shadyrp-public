local RSGCore = exports['rsg-core']:GetCoreObject()
local TravelCooldown = {}
local BuyCooldown = {}
lib.locale()

-------------------------------------
-- buy ticket
-------------------------------------
RegisterNetEvent('rex-guarma:server:buyticket', function(amount)
    local src = source
    local Player = RSGCore.Functions.GetPlayer(src)
    if not Player then return end

    -- cooldown check
    local now = GetGameTimer()
    if BuyCooldown[src] and (now - BuyCooldown[src]) < (Config.BuyCooldown * 1000) then
        TriggerClientEvent('ox_lib:notify', src, { title = locale('sv_lang_3'), type = 'error' })
        return
    end
    BuyCooldown[src] = now

    -- sanitize amount
    amount = tonumber(amount)
    if not amount or amount < 1 or amount > Config.MaxTickets then
        TriggerClientEvent('ox_lib:notify', src, { title = locale('sv_lang_4'), type = 'error' })
        return
    end

    local totalCost = amount * Config.TicketCost
    local cash = Player.PlayerData.money['cash']

    if cash < totalCost then
        TriggerClientEvent('ox_lib:notify', src, { title = locale('sv_lang_2'), type = 'error', duration = 7000 })
        return
    end

    -- success
    Player.Functions.RemoveMoney('cash', totalCost)
    Player.Functions.AddItem('boat_ticket', amount)
    TriggerClientEvent('rsg-inventory:client:ItemBox', src, RSGCore.Shared.Items['boat_ticket'], 'add', amount)
    TriggerClientEvent('ox_lib:notify', src, { title = locale('sv_lang_1'), description = locale('sv_lang_5'):format(amount, totalCost), type = 'success', duration = 7000 })

    -- log
    print(("[rex-guarma] ^2%s (%s) bought %d boat tickets for $%d"):format(GetPlayerName(src), Player.PlayerData.citizenid, amount, totalCost))
end)

-------------------------------------
-- request travel
-------------------------------------
RegisterNetEvent('rex-guarma:server:requestTravel', function(destination)
    local src = source
    local Player = RSGCore.Functions.GetPlayer(src)
    if not Player then return end

    if not destination or (destination ~= 'guarma' and destination ~= 'stdenis') then
        return DropPlayer(src, "Invalid travel destination")
    end

    -- cooldown
    local now = GetGameTimer()
    if TravelCooldown[src] and (now - TravelCooldown[src]) < (Config.TravelCooldown * 1000) then
        TriggerClientEvent('ox_lib:notify', src, { title = locale('sv_lang_6'), type = 'error' })
        return
    end

    -- check and remove ticket
    if not Player.Functions.RemoveItem('boat_ticket', 1) then
        TriggerClientEvent('ox_lib:notify', src, { title = locale('sv_lang_7'), type = 'error' })
        return
    end

    TravelCooldown[src] = now

    -- one-time token
    local token = math.random(100000, 999999)
    TriggerClientEvent('rex-guarma:client:performTravel', src, destination, token)

    -- log
    print(("[rex-guarma] ^3%s (%s) traveled to %s"):format(GetPlayerName(src), Player.PlayerData.citizenid, destination))
end)

-------------------------------------
-- cleanup on disconnect
-------------------------------------
AddEventHandler('playerDropped', function()
    local src = source
    TravelCooldown[src] = nil
    BuyCooldown[src] = nil
end)
