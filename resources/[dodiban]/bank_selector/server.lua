local bankCooldowns = {}
local globalRobberyCooldown = 0 -- Global cooldown timestamp
local activeRobberies = {} -- Currently active robberies (multiple allowed)
local playerCooldowns = {} -- Per-player cooldowns for bank selection

-- NPC System Variables
local currentNPCLocation = nil
local npcSpawnTimer = 0
local registeredNPCs = {} -- NetworkIDs de NPCs válidos registrados

-- Initialize bank cooldowns
Citizen.CreateThread(function()
    for _, bank in ipairs(Config.BankSelector.banks) do
        bankCooldowns[bank.id] = 0
    end
end)

-- NPC System Functions
local function GetRandomNPCLocation()
    if not Config.BankSelector.npc_system.enabled then
        return nil
    end
    
    local locations = Config.BankSelector.npc_system.spawn_locations
    if #locations == 0 then
        return nil
    end
    
    local randomIndex = math.random(1, #locations)
    return locations[randomIndex]
end

local function SpawnNPCAtNewLocation()
    if not Config.BankSelector.npc_system.enabled then
        return
    end
    
    local newLocation = GetRandomNPCLocation()
    if not newLocation then
        -- print("^1[BANK SELECTOR NPC] No spawn locations configured")
        return
    end
    
    -- Ensure we don't spawn at the same location twice in a row
    if currentNPCLocation and currentNPCLocation.name and newLocation.name and currentNPCLocation.name == newLocation.name then
        -- Try to get a different location
        local attempts = 0
        while newLocation and newLocation.name and currentNPCLocation.name == newLocation.name and attempts < 5 do
            newLocation = GetRandomNPCLocation()
            attempts = attempts + 1
        end
    end
    
    currentNPCLocation = newLocation
    -- print("^2[BANK SELECTOR NPC] New NPC location selected: " .. (newLocation.name or "Unknown"))
    
    -- Notify all clients about the new NPC location
    TriggerClientEvent('bank_selector:spawnNPC', -1, newLocation)
    
    -- Notify players about the new location (removed global notification)
    -- Players will see the NPC when they get close to it
    -- local message = string.format(Config.BankSelector.npc_system.notifications.npc_spawned, newLocation.name or "Unknown")
    -- TriggerClientEvent('bank_selector:npcNotification', -1, message)
end

-- NPC Timer System
Citizen.CreateThread(function()
    if not Config.BankSelector.npc_system.enabled then
        -- print("^1[BANK SELECTOR NPC] NPC system is DISABLED in config")
        return
    end
    
    -- print("^2[BANK SELECTOR NPC] NPC system starting - initial spawn in 30 seconds")
    
    -- Initial spawn after 30 seconds
    Citizen.Wait(30000)
    SpawnNPCAtNewLocation()
    
    -- Timer loop for location changes
    while true do
        local intervalMs = Config.BankSelector.npc_system.spawn_interval * 60 * 1000 -- Convert minutes to milliseconds
        -- print("^3[BANK SELECTOR NPC] Next location change in " .. Config.BankSelector.npc_system.spawn_interval .. " minutes")
        Citizen.Wait(intervalMs)
        
        -- print("^3[BANK SELECTOR NPC] Timer triggered - changing NPC location")
        SpawnNPCAtNewLocation()
        
        -- Notify about location change (removed global notification)
        -- Players will discover the new location naturally
        -- TriggerClientEvent('bank_selector:npcNotification', -1, Config.BankSelector.npc_system.notifications.npc_moved)
    end
end)

-- Event to get current bank cooldowns
RegisterNetEvent('bank_selector:getBankCooldowns')
AddEventHandler('bank_selector:getBankCooldowns', function()
    local source = source
    TriggerClientEvent('bank_selector:updateBankCooldowns', source, bankCooldowns)
    
    -- Also send current NPC location if available
    if currentNPCLocation then
        -- print("^2[BANK SELECTOR NPC] Sending current NPC location to player " .. source .. ": " .. currentNPCLocation.name)
        TriggerClientEvent('bank_selector:spawnNPC', source, currentNPCLocation)
    end
end)

-- Function to check global robbery cooldown
local function IsGlobalRobberyCooldownActive()
    return globalRobberyCooldown > os.time()
end

-- Function to get remaining global cooldown in minutes
local function GetGlobalCooldownRemaining()
    if not IsGlobalRobberyCooldownActive() then
        return 0
    end
    return math.ceil((globalRobberyCooldown - os.time()) / 60)
end

-- Function to check if player is on cooldown
local function IsPlayerOnCooldown(playerId)
    if not Config.BankSelector.player_cooldown.enabled then
        return false
    end
    
    return playerCooldowns[playerId] and playerCooldowns[playerId] > os.time()
end

-- Function to get remaining player cooldown in minutes
local function GetPlayerCooldownRemaining(playerId)
    if not IsPlayerOnCooldown(playerId) then
        return 0
    end
    return math.ceil((playerCooldowns[playerId] - os.time()) / 60)
end

-- Function to set player cooldown
local function SetPlayerCooldown(playerId)
    if Config.BankSelector.player_cooldown.enabled then
        playerCooldowns[playerId] = os.time() + (Config.BankSelector.player_cooldown.cooldown_minutes * 60)
        -- print("^3[BANK SELECTOR] Player " .. playerId .. " cooldown set for " .. Config.BankSelector.player_cooldown.cooldown_minutes .. " minutes")
    end
end

-- Function to check if player is in a valid lobby
local function CheckPlayerLobbyStatus(playerId)
    if not Config.BankSelector.player_cooldown.require_lobby then
        return true, nil -- No lobby required
    end
    
    -- Check if bank_lobby resource exists
    if GetResourceState('bank_lobby') ~= 'started' then
        -- print("^1[BANK SELECTOR] bank_lobby resource not available")
        return false, "Lobby system not available"
    end
    
    -- Check if player is in a lobby
    local isInLobby = exports.bank_lobby:IsPlayerInActiveLobby(playerId)
    if not isInLobby then
        return false, Config.BankSelector.notifications.not_in_lobby
    end
    
    -- Check minimum lobby members if required
    if Config.BankSelector.player_cooldown.min_lobby_members > 0 then
        local lobbyMembers = exports.bank_lobby:GetPlayerLobbyMembers(playerId)
        if #lobbyMembers < Config.BankSelector.player_cooldown.min_lobby_members then
            local message = string.format(Config.BankSelector.notifications.lobby_too_small, Config.BankSelector.player_cooldown.min_lobby_members)
            return false, message
        end
    end
    
    return true, nil
end

-- Function to start global robbery cooldown
local function StartGlobalRobberyCooldown()
    if Config.BankSelector.robbery_integration.enabled and Config.BankSelector.robbery_integration.global_cooldown_enabled then
        globalRobberyCooldown = os.time() + (Config.BankSelector.robbery_integration.global_cooldown * 60)
        -- print("^3[BANK SELECTOR] Global robbery cooldown started: " .. Config.BankSelector.robbery_integration.global_cooldown .. " minutes")
    end
end

-- Event when a bank is selected
RegisterNetEvent('bank_selector:selectBank')
AddEventHandler('bank_selector:selectBank', function(bankId, bankData)
    local source = source
    
    -- Validate bank data
    local validBank = nil
    for _, bank in ipairs(Config.BankSelector.banks) do
        if bank.id == bankId then
            validBank = bank
            break
        end
    end
    
    if not validBank then
        -- print("^1[BANK SELECTOR] Invalid bank selected: " .. tostring(bankId))
        TriggerClientEvent('bank_selector:robberyResult', source, false, "Invalid bank")
        return
    end
    
    -- Check if player is in a valid lobby
    local lobbyValid, lobbyError = CheckPlayerLobbyStatus(source)
    if not lobbyValid then
        -- print("^1[BANK SELECTOR] Player " .. source .. " lobby check failed: " .. tostring(lobbyError))
        TriggerClientEvent('bank_selector:robberyResult', source, false, lobbyError)
        return
    end
    
    -- Check player cooldown
    if IsPlayerOnCooldown(source) then
        local remainingMinutes = GetPlayerCooldownRemaining(source)
        local message = string.format(Config.BankSelector.notifications.player_on_cooldown, remainingMinutes)
        -- print("^1[BANK SELECTOR] Player " .. source .. " is on cooldown: " .. remainingMinutes .. " minutes remaining")
        TriggerClientEvent('bank_selector:robberyResult', source, false, message)
        return
    end
    
    -- Check global robbery cooldown first (only if enabled)
    if Config.BankSelector.robbery_integration.enabled and Config.BankSelector.robbery_integration.global_cooldown_enabled and IsGlobalRobberyCooldownActive() then
        local remainingMinutes = GetGlobalCooldownRemaining()
        local message = string.format(Config.BankSelector.notifications.global_cooldown_active, remainingMinutes)
        -- print("^1[BANK SELECTOR] Global cooldown active: " .. remainingMinutes .. " minutes remaining")
        TriggerClientEvent('bank_selector:robberyResult', source, false, message)
        return
    end
    
    -- Check if bank is on cooldown
    if bankCooldowns[bankId] and bankCooldowns[bankId] > os.time() then
        -- print("^1[BANK SELECTOR] Bank " .. bankId .. " is on cooldown")
        TriggerClientEvent('bank_selector:robberyResult', source, false, Config.BankSelector.notifications.bank_on_cooldown)
        return
    end
    
    -- Check if there's already an active robbery for this specific bank
    if activeRobberies[bankId] then
        -- print("^1[BANK SELECTOR] Robbery already active for this bank: " .. bankId)
        TriggerClientEvent('bank_selector:robberyResult', source, false, "This bank is already being robbed")
        return
    end
    
    -- Check if global limit is reached (only if global cooldown is enabled)
    if Config.BankSelector.robbery_integration.global_cooldown_enabled then
        local activeCount = 0
        for _ in pairs(activeRobberies) do activeCount = activeCount + 1 end
        if activeCount >= 1 then -- Only 1 robbery at a time if global cooldown enabled
            -- print("^1[BANK SELECTOR] Global robbery limit reached")
            TriggerClientEvent('bank_selector:robberyResult', source, false, "Another robbery is already in progress")
            return
        end
    end
    
    -- Start robbery if integration is enabled
    if Config.BankSelector.robbery_integration.enabled then
        local roundId = Config.BankSelector.robbery_integration.bank_round_mapping[bankId]
        if not roundId then
            -- print("^1[BANK SELECTOR] No round mapping found for bank: " .. bankId)
            TriggerClientEvent('bank_selector:robberyResult', source, false, "Bank not configured for robbery")
            return
        end
        
        -- Check if dodi_bankrobbery resource exists
        if GetResourceState('dodi_bankrobbery') ~= 'started' then
            -- print("^1[BANK SELECTOR] dodi_bankrobbery resource not started")
            TriggerClientEvent('bank_selector:robberyResult', source, false, "Robbery system not available")
            return
        end
        
        -- Start the round
        -- print("^2[BANK SELECTOR] Starting robbery: " .. bankId .. " -> " .. roundId)
        TriggerClientEvent('bank_selector:startRobbery', source, roundId, validBank)
        
        -- Set active robbery for this specific bank
        activeRobberies[bankId] = {
            bankId = bankId,
            roundId = roundId,
            playerId = source,
            startTime = os.time(),
            bankData = validBank
        }
        
        -- Start global cooldown
        StartGlobalRobberyCooldown()
        
        -- Set bank cooldown ONLY for the selected bank
        bankCooldowns[bankId] = os.time() + (validBank.cooldown * 60)
        
        -- Set player cooldown
        SetPlayerCooldown(source)
        
        -- Update all clients with new cooldown (only the specific bank)
        TriggerClientEvent('bank_selector:updateBankCooldowns', -1, bankCooldowns)
        
        -- Notify only the player who started the robbery
        if Config.BankSelector.robbery_integration.start_notifications.enabled then
            local message = string.format(Config.BankSelector.robbery_integration.start_notifications.message_template, validBank.name)
            -- Always notify only the player who started, not all players
            TriggerClientEvent('bank_selector:robberyNotification', source, message)
        end
        
        -- print("^2[BANK SELECTOR] Robbery started: " .. validBank.name .. " by player " .. source)
        
        -- Auto cleanup timer
        if Config.BankSelector.robbery_integration.auto_cleanup.enabled then
            Citizen.CreateThread(function()
                Citizen.Wait(Config.BankSelector.robbery_integration.auto_cleanup.cleanup_delay)
                
                -- Check if robbery is still active and cleanup if needed
                if activeRobberies[bankId] then
                    -- print("^3[BANK SELECTOR] Auto cleanup triggered for " .. bankId)
                    TriggerEvent('bank_selector:robberyEnded', bankId, roundId, false)
                end
            end)
        end
    else
        -- Legacy behavior - just set cooldown and trigger event
        bankCooldowns[bankId] = os.time() + (validBank.cooldown * 60)
        TriggerClientEvent('bank_selector:updateBankCooldowns', -1, bankCooldowns)
        TriggerClientEvent('bank_selector:bankSelected', source, bankId, validBank)
        -- print("Bank " .. validBank.name .. " selected by player " .. source)
    end
end)

-- Function to manually set bank cooldown (for admin commands or other scripts)
function SetBankCooldown(bankId, cooldownMinutes)
    if bankCooldowns[bankId] then
        bankCooldowns[bankId] = os.time() + (cooldownMinutes * 60)
        TriggerClientEvent('bank_selector:updateBankCooldowns', -1, bankCooldowns)
        return true
    end
    return false
end

-- Function to clear bank cooldown (for admin commands or other scripts)
function ClearBankCooldown(bankId)
    if bankCooldowns[bankId] then
        bankCooldowns[bankId] = 0
        TriggerClientEvent('bank_selector:updateBankCooldowns', -1, bankCooldowns)
        return true
    end
    return false
end

-- Function to get bank cooldown status
function GetBankCooldown(bankId)
    if bankCooldowns[bankId] then
        local remaining = bankCooldowns[bankId] - os.time()
        return remaining > 0 and remaining or 0
    end
    return 0
end

-- Function to clear player cooldown (for admin commands or other scripts)
function ClearPlayerCooldown(playerId)
    if playerCooldowns[playerId] then
        playerCooldowns[playerId] = 0
        return true
    end
    return false
end

-- Function to get player cooldown status
function GetPlayerCooldown(playerId)
    if playerCooldowns[playerId] then
        local remaining = playerCooldowns[playerId] - os.time()
        return remaining > 0 and remaining or 0
    end
    return 0
end

-- Export functions for other scripts
exports('SetBankCooldown', SetBankCooldown)
exports('ClearBankCooldown', ClearBankCooldown)
exports('GetBankCooldown', GetBankCooldown)
exports('GetAllBankCooldowns', function() return bankCooldowns end)
exports('ClearPlayerCooldown', ClearPlayerCooldown)
exports('GetPlayerCooldown', GetPlayerCooldown)
exports('GetAllPlayerCooldowns', function() return playerCooldowns end)
exports('IsPlayerOnCooldown', IsPlayerOnCooldown)
exports('GetPlayerCooldownRemaining', GetPlayerCooldownRemaining)

-- -- Admin commands (you may want to add permission checks)
-- RegisterCommand(Config.BankSelector.commands.clear_cooldown, function(source, args, rawCommand)
--     if source == 0 then -- Console only
--         if args[1] then
--             local bankId = args[1]
--             if ClearBankCooldown(bankId) then
--                 -- print("Cleared cooldown for bank: " .. bankId)
--             else
--                 -- print("Invalid bank ID: " .. bankId)
--             end
--         else
--             -- print("Usage: clearbankcd <bankId>")
--         end
--     end
-- end, false)

-- RegisterCommand(Config.BankSelector.commands.set_cooldown, function(source, args, rawCommand)
--     if source == 0 then -- Console only
--         if args[1] and args[2] then
--             local bankId = args[1]
--             local minutes = tonumber(args[2])
--             if minutes and SetBankCooldown(bankId, minutes) then
--                 -- print("Set cooldown for bank " .. bankId .. " to " .. minutes .. " minutes")
--             else
--                 -- print("Invalid bank ID or cooldown time")
--             end
--         else
--             -- print("Usage: setbankcd <bankId> <minutes>")
--         end
--     end
-- end, false)

-- RegisterCommand(Config.BankSelector.commands.check_cooldowns, function(source, args, rawCommand)
--     if source == 0 then -- Console only
--         -- print("Current bank cooldowns:")
--         for bankId, cooldownTime in pairs(bankCooldowns) do
--             local remaining = cooldownTime - os.time()
--             if remaining > 0 then
--                 -- print(bankId .. ": " .. math.ceil(remaining / 60) .. " minutes remaining")
--             else
--                 -- print(bankId .. ": Available")
--             end
--         end
        
--         -- print("\nCurrent player cooldowns:")
--         for playerId, cooldownTime in pairs(playerCooldowns) do
--             local remaining = cooldownTime - os.time()
--             if remaining > 0 then
--                 -- print("Player " .. playerId .. ": " .. math.ceil(remaining / 60) .. " minutes remaining")
--             else
--                 -- print("Player " .. playerId .. ": Available")
--             end
--         end
--     end
-- end, false)

-- -- Admin command to clear player cooldown
-- RegisterCommand('clearplayercd', function(source, args, rawCommand)
--     if source == 0 then -- Console only
--         if args[1] then
--             local playerId = tonumber(args[1])
--             if playerId and ClearPlayerCooldown(playerId) then
--                 -- print("Cleared cooldown for player: " .. playerId)
--             else
--                 -- print("Invalid player ID or player not on cooldown: " .. tostring(args[1]))
--             end
--         else
--             -- print("Usage: clearplayercd <playerId>")
--         end
--     end
-- end, false)

-- -- Admin command to check specific player cooldown
-- RegisterCommand('checkplayercd', function(source, args, rawCommand)
--     if source == 0 then -- Console only
--         if args[1] then
--             local playerId = tonumber(args[1])
--             if playerId then
--                 local remaining = GetPlayerCooldown(playerId)
--                 if remaining > 0 then
--                     -- print("Player " .. playerId .. " cooldown: " .. math.ceil(remaining / 60) .. " minutes remaining")
--                 else
--                     -- print("Player " .. playerId .. " cooldown: Available")
--                 end
--             else
--                 -- print("Invalid player ID: " .. tostring(args[1]))
--             end
--         else
--             -- print("Usage: checkplayercd <playerId>")
--         end
--     end
-- end, false)

-- Event when robbery ends (success or failure)
RegisterNetEvent('bank_selector:robberyEnded')
AddEventHandler('bank_selector:robberyEnded', function(bankId, roundId, success)
    -- print("^3[BANK SELECTOR] Robbery ended: " .. tostring(bankId) .. " -> " .. tostring(roundId) .. " (Success: " .. tostring(success) .. ")")
    
    -- Clear active robbery for this specific bank
    if activeRobberies[bankId] then
        activeRobberies[bankId] = nil
        -- print("^2[BANK SELECTOR] Active robbery cleared for: " .. bankId)
    end
    
    -- Note: Individual bank cooldown continues regardless of success/failure
    -- Global cooldown only applies if enabled
end)

-- Event to get global cooldown status
RegisterNetEvent('bank_selector:getGlobalCooldown')
AddEventHandler('bank_selector:getGlobalCooldown', function()
    local source = source
    local remaining = GetGlobalCooldownRemaining()
    TriggerClientEvent('bank_selector:globalCooldownUpdate', source, remaining, IsGlobalRobberyCooldownActive())
end)

-- Event to check player cooldown status
RegisterNetEvent('bank_selector:checkPlayerCooldown')
AddEventHandler('bank_selector:checkPlayerCooldown', function()
    local source = source
    local remaining = GetPlayerCooldown(source)
    local remainingMinutes = math.ceil(remaining / 60)
    
    if remaining > 0 then
        TriggerClientEvent('bank_selector:robberyResult', source, false, 
            string.format("You are on cooldown for %d minutes", remainingMinutes))
    else
        TriggerClientEvent('bank_selector:robberyResult', source, true, "You can select a bank")
    end
    
    -- print("^6[BANK SELECTOR] Player " .. source .. " cooldown check: " .. 
    --     (remaining > 0 and (remainingMinutes .. " minutes remaining") or "Available"))
end)

-- Function to clear global cooldown (admin only)
function ClearGlobalRobberyCooldown()
    globalRobberyCooldown = 0
    activeRobberies = {}
    -- print("^2[BANK SELECTOR] Global robbery cooldown cleared")
    return true
end

-- Function to get active robberies info
function GetActiveRobberies()
    return activeRobberies
end

-- Function to get active robbery count
function GetActiveRobberyCount()
    local count = 0
    for _ in pairs(activeRobberies) do
        count = count + 1
    end
    return count
end

-- Export functions for other scripts
exports('ClearGlobalRobberyCooldown', ClearGlobalRobberyCooldown)
exports('GetActiveRobberies', GetActiveRobberies)
exports('GetActiveRobberyCount', GetActiveRobberyCount)
exports('GetGlobalCooldownRemaining', GetGlobalCooldownRemaining)
exports('IsGlobalRobberyCooldownActive', IsGlobalRobberyCooldownActive)

-- -- Admin command to clear global cooldown
-- RegisterCommand('clearglobalcd', function(source, args, rawCommand)
--     if source == 0 then -- Console only
--         if ClearGlobalRobberyCooldown() then
--             -- print("Global robbery cooldown cleared")
--         end
--     end
-- end, false)

-- -- Admin command to check global cooldown
-- RegisterCommand('checkglobalcd', function(source, args, rawCommand)
--     if source == 0 then -- Console only
--         local remaining = GetGlobalCooldownRemaining()
--         if remaining > 0 then
--             -- print("Global robbery cooldown: " .. remaining .. " minutes remaining")
--         else
--             -- print("Global robbery cooldown: Not active")
--         end
        
--         local activeCount = GetActiveRobberyCount()
--         -- print("Active robberies: " .. activeCount)
--         for bankId, robbery in pairs(activeRobberies) do
--             -- print("  " .. bankId .. " by player " .. robbery.playerId .. " (started: " .. os.date("%H:%M:%S", robbery.startTime) .. ")")
--         end
--     end
-- end, false)

-- NPC System Events
RegisterNetEvent('bank_selector:requestNPCLocation')
AddEventHandler('bank_selector:requestNPCLocation', function()
    local source = source
    if currentNPCLocation then
        TriggerClientEvent('bank_selector:spawnNPC', source, currentNPCLocation)
    end
end)

RegisterNetEvent('bank_selector:npcInteraction')
AddEventHandler('bank_selector:npcInteraction', function()
    local source = source
    -- print("^2[BANK SELECTOR NPC] Player " .. source .. " interacted with NPC")
    
    -- Trigger the force bank selector opening on client
    TriggerClientEvent('bank_selector:openFromNPC', source)
end)

-- Export functions for NPC system
exports('GetCurrentNPCLocation', function() return currentNPCLocation end)
exports('ForceNPCLocationChange', function() SpawnNPCAtNewLocation() end)

-- -- Admin command to manually change NPC location
-- RegisterCommand('changenpc', function(source, args, rawCommand)
--     if source == 0 then -- Console only
--         SpawnNPCAtNewLocation()
--         -- print("NPC location changed manually")
--     end
-- end, false)

-- -- Admin command to force initial NPC spawn
-- RegisterCommand('forcenpc', function(source, args, rawCommand)
--     if source == 0 then -- Console only
--         if not currentNPCLocation then
--             SpawnNPCAtNewLocation()
--             -- print("Initial NPC location set manually")
--         else
--             -- print("NPC location already set: " .. currentNPCLocation.name)
--         end
--     end
-- end, false)

-- -- Admin command to check current NPC location
-- RegisterCommand('checknpc', function(source, args, rawCommand)
--     if source == 0 then -- Console only
--         if currentNPCLocation then
--             -- print("Current NPC location: " .. currentNPCLocation.name .. 
--                --   " (" .. currentNPCLocation.x .. ", " .. currentNPCLocation.y .. ", " .. currentNPCLocation.z .. ")")
--         else
--             -- print("No NPC currently spawned")
--         end
--     end
-- end, false)

-- Event for when player spawns/joins server
AddEventHandler('playerSpawned', function(source)
    -- Send current NPC location to newly spawned player
    if currentNPCLocation then
        -- print("^2[BANK SELECTOR NPC] Player " .. source .. " spawned - sending NPC location: " .. currentNPCLocation.name)
        TriggerClientEvent('bank_selector:spawnNPC', source, currentNPCLocation)
    end
end)

-- Alternative event for RSG-Core
RegisterNetEvent('RSGCore:Server:PlayerLoaded')
AddEventHandler('RSGCore:Server:PlayerLoaded', function(Player)
    local source = Player.PlayerData.source
    -- Send current NPC location to newly loaded player
    if currentNPCLocation then
        -- print("^2[BANK SELECTOR NPC] Player " .. source .. " loaded - sending NPC location: " .. currentNPCLocation.name)
        TriggerClientEvent('bank_selector:spawnNPC', source, currentNPCLocation)
    end
end)

--------------------------------------------------------
---- SISTEMA DE REGISTRO DE NPCs PARA SINCRONIZAÇÃO ----
--------------------------------------------------------

-- Event para registrar NPC para sincronização entre players
RegisterServerEvent('bank_selector:registerNPCForSync')
AddEventHandler('bank_selector:registerNPCForSync', function(networkId, locationName)
    local playerId = source
    
    -- Registrar NPC como válido
    registeredNPCs[networkId] = {
        locationName = locationName,
        registeredAt = os.time(),
        registeredBy = playerId
    }
    
    -- print("^2[BANK SELECTOR NPC] NPC registrado para sincronização: " .. locationName .. " (NetID: " .. networkId .. ") por player " .. playerId)
    
    -- Enviar registro para todos os outros players
    TriggerClientEvent('bank_selector:registerValidNPC', -1, networkId, locationName)
end)

-- Event para remover registro de NPC quando é deletado
RegisterServerEvent('bank_selector:unregisterNPCForSync')
AddEventHandler('bank_selector:unregisterNPCForSync', function(networkId)
    if registeredNPCs[networkId] then
        local npcData = registeredNPCs[networkId]
        registeredNPCs[networkId] = nil
        -- print("^3[BANK SELECTOR NPC] NPC removido do registro: " .. npcData.locationName)
        
        -- Enviar remoção para todos os players
        TriggerClientEvent('bank_selector:unregisterNPC', -1, networkId)
    end
end)

-- Função para limpar NPCs registrados antigos (mais de 1 hora)
local function CleanupOldRegisteredNPCs()
    local currentTime = os.time()
    local maxAge = 60 * 60 -- 1 hora
    
    for networkId, data in pairs(registeredNPCs) do
        if currentTime - data.registeredAt > maxAge then
            registeredNPCs[networkId] = nil
            -- print("^3[BANK SELECTOR NPC] NPC expirado removido: " .. data.locationName)
        end
    end
end

-- Thread para limpeza periódica
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(300000) -- 5 minutos
        CleanupOldRegisteredNPCs()
    end
end)
