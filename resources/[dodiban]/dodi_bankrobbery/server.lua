-------------------------------------------------------
---- SERVIDOR - SISTEMA DE RONDAS ----
-------------------------------------------------------

local activeRoundSystems = {}
local allRoundNetworkIds = {} -- Tabela global com todos os network IDs de todas as rondas

-- Event para registrar guardas networked no servidor
RegisterNetEvent('rounds:registerNetworkGuards')
AddEventHandler('rounds:registerNetworkGuards', function(locationId, networkData)
    local playerId = source
    
    local guardCount = 0
    for _ in pairs(networkData) do guardCount = guardCount + 1 end
    -- -- print("^5[ROUNDS SERVER] Registrando " .. guardCount .. " guardas para " .. locationId .. " (Player: " .. playerId .. ")")
    
    -- Armazenar dados da ronda
    if not activeRoundSystems[locationId] then
        activeRoundSystems[locationId] = {
            host = playerId,
            guards = {},
            lastActivity = GetGameTimer()
        }
    end
    
    -- Atualizar dados dos guardas
    for guardId, data in pairs(networkData) do
        activeRoundSystems[locationId].guards[guardId] = {
            networkId = data.networkId,
            coords = data.coords,
            heading = data.heading,
            detectionRadius = data.detectionRadius,
            host = playerId
        }
        
        -- Adicionar à tabela global de network IDs
        allRoundNetworkIds[data.networkId] = {
            locationId = locationId,
            guardId = guardId,
            host = playerId,
            coords = data.coords
        }
    end
    
    -- Sincronizar com outros players
    TriggerClientEvent('rounds:syncNetworkGuards', -1, locationId, networkData, playerId)
end)

-- Event para detecção de player (para determinar quem deve atacar)
RegisterNetEvent('rounds:playerDetected')
AddEventHandler('rounds:playerDetected', function(locationId, guardId, targetPlayerId)
    local sourcePlayer = source
    
    -- -- print("^6[ROUNDS SERVER] Player detectado - " .. locationId .. "/" .. guardId .. " -> Player " .. targetPlayerId)
    
    -- Verificar se a ronda existe
    if not activeRoundSystems[locationId] or not activeRoundSystems[locationId].guards[guardId] then
        -- -- print("^1[ROUNDS SERVER] Ronda ou guarda não encontrado")
        return
    end
    
    -- Atualizar atividade
    activeRoundSystems[locationId].lastActivity = GetGameTimer()
    
    -- Converter client ID para server ID do target
    local targetServerPlayerId = targetPlayerId -- Já vem como server ID
    
    -- Enviar comando de combate para todos os clients
    TriggerClientEvent('rounds:setCombatTarget', -1, locationId, guardId, targetServerPlayerId)
end)

-- Event para quando player toca em guarda
RegisterNetEvent('rounds:playerTouchedGuard')
AddEventHandler('rounds:playerTouchedGuard', function(locationId, guardId, targetPlayerId)
    local sourcePlayer = source
    
    -- -- print("^1[ROUNDS SERVER] Player tocou guarda - " .. locationId .. "/" .. guardId .. " -> Player " .. targetPlayerId)
    
    -- Verificar se a ronda existe
    if not activeRoundSystems[locationId] or not activeRoundSystems[locationId].guards[guardId] then
        -- -- print("^1[ROUNDS SERVER] Ronda ou guarda não encontrado para toque")
        return
    end
    
    -- Atualizar atividade
    activeRoundSystems[locationId].lastActivity = GetGameTimer()
    
    -- Notificar todos os players sobre o toque (para alertar outros guardas)
    TriggerClientEvent('rounds:guardTouchedAlert', -1, locationId, guardId, targetPlayerId)
    
    -- Forçar combate imediato
    TriggerClientEvent('rounds:setCombatTarget', -1, locationId, guardId, targetPlayerId)
end)

-- Event para quando guarda testemunha morte de outro guarda
RegisterNetEvent('rounds:guardWitnessedDeath')
AddEventHandler('rounds:guardWitnessedDeath', function(locationId, witnessGuardId, deadGuardId)
    local sourcePlayer = source
    
    -- -- print("^1[ROUNDS SERVER] " .. witnessGuardId .. " testemunhou morte de " .. deadGuardId .. " em " .. locationId)
    
    -- Verificar se a ronda existe
    if not activeRoundSystems[locationId] then
        -- -- print("^1[ROUNDS SERVER] Ronda não encontrada para testemunha de morte")
        return
    end
    
    -- Atualizar atividade
    activeRoundSystems[locationId].lastActivity = GetGameTimer()
    
    -- Notificar todos os clients sobre a testemunha
    TriggerClientEvent('rounds:guardWitnessedDeathAlert', -1, locationId, witnessGuardId, deadGuardId)
    
    -- Encontrar o player mais próximo do guarda morto para atacar
    local players = GetPlayers()
    local closestPlayer = nil
    local closestDistance = 999999.0
    
    for _, playerId in ipairs(players) do
        local playerPed = GetPlayerPed(playerId)
        if playerPed then
            -- Aqui seria ideal ter as coordenadas do guarda morto, mas vamos usar o evento para alertar
            local playerIdNum = tonumber(playerId)
            if playerIdNum then
                TriggerClientEvent('rounds:searchForPlayerNearDeath', playerIdNum, locationId, witnessGuardId, deadGuardId)
            end
        end
    end
end)

-- Event para quando player é ameaçado por estar armado
RegisterNetEvent('rounds:playerThreatened')
AddEventHandler('rounds:playerThreatened', function(locationId, guardId, targetPlayerId)
    local sourcePlayer = source
    
    -- -- print("^3[ROUNDS SERVER] Player " .. targetPlayerId .. " foi ameaçado por " .. guardId .. " em " .. locationId .. " (arma não guardada)")
    
    -- Verificar se a ronda existe
    if not activeRoundSystems[locationId] then
        -- -- print("^1[ROUNDS SERVER] Ronda não encontrada para ameaça")
        return
    end
    
    -- Atualizar atividade
    activeRoundSystems[locationId].lastActivity = GetGameTimer()
    
    -- Notificar todos os clients sobre a ameaça
    TriggerClientEvent('rounds:playerThreatenedAlert', -1, locationId, guardId, targetPlayerId)
end)

-- Event para quando guarda ouve tiros
RegisterNetEvent('rounds:guardHeardGunfire')
AddEventHandler('rounds:guardHeardGunfire', function(locationId, guardId, shooterPlayerId)
    local playerId = source
    
    -- -- print("^1[ROUNDS SERVER] Guarda ouviu tiros - " .. locationId .. "/" .. guardId .. " -> Atirador Player " .. shooterPlayerId)
    
    -- Notificar todos os clients sobre os tiros
    TriggerClientEvent('rounds:gunfireDetectedAlert', -1, locationId, guardId, shooterPlayerId)
end)

-- Event para quando uma ronda é completada
RegisterNetEvent('rounds:roundCompleted')
AddEventHandler('rounds:roundCompleted', function(locationId)
    local playerId = source
    
    -- -- print("^2[ROUNDS SERVER] Ronda " .. locationId .. " completada por Player " .. playerId)
    
    -- Remover network IDs da tabela global
    if activeRoundSystems[locationId] then
        for guardId, guardData in pairs(activeRoundSystems[locationId].guards) do
            if allRoundNetworkIds[guardData.networkId] then
                allRoundNetworkIds[guardData.networkId] = nil
            end
        end
    end
    
    -- Remover sistema ativo
    activeRoundSystems[locationId] = nil
    
    -- Notificar todos os clients
    TriggerClientEvent('rounds:roundCompletedByServer', -1, locationId, playerId)
end)

-- Event para limpar ronda específica
RegisterNetEvent('rounds:cleanupRound')
AddEventHandler('rounds:cleanupRound', function(locationId)
    local playerId = source
    
    -- -- print("^3[ROUNDS SERVER] Limpando ronda " .. locationId .. " solicitado por Player " .. playerId)
    
    if activeRoundSystems[locationId] then
        -- Remover network IDs da tabela global
        for guardId, guardData in pairs(activeRoundSystems[locationId].guards) do
            if allRoundNetworkIds[guardData.networkId] then
                allRoundNetworkIds[guardData.networkId] = nil
            end
        end
        
        activeRoundSystems[locationId] = nil
        TriggerClientEvent('rounds:forceCleanupRound', -1, locationId)
    end
end)

-- Função para verificar sistemas ativos (limpeza automática)
Citizen.CreateThread(function()
    while true do
        Wait(60000) -- Verifica a cada minuto
        
        local currentTime = GetGameTimer()
        local toRemove = {}
        
        for locationId, system in pairs(activeRoundSystems) do
            -- Remove sistemas inativos há mais de 10 minutos
            if currentTime - system.lastActivity > 600000 then
                -- -- print("^3[ROUNDS SERVER] Removendo sistema inativo: " .. locationId)
                table.insert(toRemove, locationId)
            end
        end
        
        for _, locationId in ipairs(toRemove) do
            activeRoundSystems[locationId] = nil
        end
    end
end)

-- -- Comando para admin verificar status do servidor
-- RegisterCommand('rounds_server_status', function(source, args, rawCommand)
--     if source == 0 then -- Console apenas
--         -- -- print("^6=== STATUS DO SERVIDOR DE RONDAS ===")
        
--         local totalSystems = 0
--         for locationId, system in pairs(activeRoundSystems) do
--             totalSystems = totalSystems + 1
--             local guardCount = 0
--             for _ in pairs(system.guards) do guardCount = guardCount + 1 end
            
--             -- -- print("^2" .. locationId .. ":")
--             -- -- print("  Host: Player " .. system.host)
--             -- -- print("  Guardas: " .. guardCount)
--             -- -- print("  Última atividade: " .. math.floor((GetGameTimer() - system.lastActivity) / 1000) .. "s atrás")
--         end
        
--         -- -- print("^6Total: " .. totalSystems .. " sistemas ativos")
--     end
-- end, true)

-- -- Comando para forçar limpeza de ronda específica
-- RegisterCommand('force_cleanup_round', function(source, args, rawCommand)
--     if source == 0 and args[1] then -- Console apenas
--         local locationId = args[1]
        
--         if activeRoundSystems[locationId] then
--             activeRoundSystems[locationId] = nil
--             TriggerClientEvent('rounds:forceCleanupRound', -1, locationId)
--             -- -- print("^2[ROUNDS SERVER] Ronda " .. locationId .. " forçadamente limpa")
--         else
--             -- -- print("^1[ROUNDS SERVER] Ronda " .. locationId .. " não encontrada")
--         end
--     end
-- end, true)

-- Event para limpeza global de todos os peds de rondas
RegisterNetEvent('rounds:globalCleanup')
AddEventHandler('rounds:globalCleanup', function()
    local playerId = source
    
    -- -- print("^1[ROUNDS SERVER] FORÇA BRUTA GLOBAL solicitada por Player " .. playerId)
    
    -- Disparar força bruta em TODOS os clients imediatamente
    TriggerClientEvent('rounds:forceDeleteAllRoundPeds', -1)
    
    -- Limpar tabelas do servidor
    allRoundNetworkIds = {}
    activeRoundSystems = {}
    
    -- -- print("^1[ROUNDS SERVER] Força bruta enviada para todos os clients")
end)

-- Event quando o servidor vai parar - enviar network IDs para limpeza específica
AddEventHandler('onResourceStop', function(resourceName)
    if GetCurrentResourceName() == resourceName then
        local totalNetworkIds = 0
        for networkId, data in pairs(allRoundNetworkIds) do
            totalNetworkIds = totalNetworkIds + 1
        end
        
        if totalNetworkIds > 0 then
            -- -- print("^3[ROUNDS SERVER] Script parando - enviando " .. totalNetworkIds .. " network IDs específicos para limpeza")
            TriggerClientEvent('rounds:cleanupNetworkIds', -1, allRoundNetworkIds)
            Citizen.Wait(1000) -- Aguardar limpeza
        else
            -- -- print("^2[ROUNDS SERVER] Script parando - nenhum network ID para limpar")
        end
    end
end)

-- -- Comando para debug dos network IDs
-- RegisterCommand('debug_rounds_server', function(source, args, rawCommand)
--     -- -- print("^6[ROUNDS SERVER DEBUG] Network IDs armazenados:")
--     local totalIds = 0
--     for networkId, data in pairs(allRoundNetworkIds) do
--         totalIds = totalIds + 1
--         -- -- print("  NetworkID: " .. networkId .. " - " .. data.guardId .. " (Host: " .. data.host .. ")")
--     end
--     -- -- print("^6[ROUNDS SERVER DEBUG] Total: " .. totalIds .. " network IDs")
    
--     -- -- print("^6[ROUNDS SERVER DEBUG] Sistemas ativos:")
--     local totalSystems = 0
--     for locationId, system in pairs(activeRoundSystems) do
--         totalSystems = totalSystems + 1
--         local guardCount = 0
--         for _ in pairs(system.guards) do guardCount = guardCount + 1 end
--         -- -- print("  " .. locationId .. ": " .. guardCount .. " guardas (Host: " .. system.host .. ")")
--     end
--     -- -- print("^6[ROUNDS SERVER DEBUG] Total: " .. totalSystems .. " sistemas")
-- end, true)

-------------------------------------------------------
---- EVENTOS DOS GERADORES ----
-------------------------------------------------------

-- Evento para sincronizar explosões de geradores
RegisterServerEvent('generators:explodeGenerator')
AddEventHandler('generators:explodeGenerator', function(generatorCoords, generatorId)
    local sourcePlayer = source
    
    -- -- print("^1[GENERATORS SERVER] Player " .. sourcePlayer .. " explodiu gerador: " .. generatorId)
    
    -- Enviar para todos os outros players
    TriggerClientEvent('generators:clientExplodeGenerator', -1, generatorCoords, generatorId, sourcePlayer)
end)

-- Evento para sincronizar sabotagem completa de geradores
RegisterServerEvent('generators:sabotageGenerator')
AddEventHandler('generators:sabotageGenerator', function(generatorId)
    local sourcePlayer = source
    
    -- -- print("^2[GENERATORS SERVER] Player " .. sourcePlayer .. " sabotou gerador: " .. generatorId)
    
    -- Enviar para todos os outros players
    TriggerClientEvent('generators:clientSabotageGenerator', -1, generatorId, sourcePlayer)
end)

-------------------------------------------------------
---- EVENTOS DOS HOSTAGES ----
-------------------------------------------------------

local allHostageNetworkIds = {} -- Tabela global para rastrear todos os network IDs dos hostages

-- Evento para registrar network IDs dos hostages
RegisterServerEvent('hostages:registerNetworkHostages')
AddEventHandler('hostages:registerNetworkHostages', function(networkIds, systemName)
    local source = source
    -- -- print("^2[HOSTAGES SERVER] Player " .. source .. " registrou " .. #networkIds .. " hostages do sistema: " .. systemName)
    
    -- Adicionar à lista global
    for _, netId in ipairs(networkIds) do
        table.insert(allHostageNetworkIds, netId)
    end
    
    -- -- print("^5[HOSTAGES SERVER] Total de hostages registrados: " .. #allHostageNetworkIds)
end)

-- Evento para limpeza de sistema específico
RegisterServerEvent('hostages:cleanupSystem')
AddEventHandler('hostages:cleanupSystem', function(systemName)
    local source = source
    -- -- print("^3[HOSTAGES SERVER] Player " .. source .. " solicitou limpeza do sistema: " .. systemName)
    
    -- Aqui poderia implementar lógica específica por sistema se necessário
    -- Por enquanto, mantém a lista global intacta
end)

-- Evento para limpeza global de hostages
RegisterServerEvent('hostages:globalCleanup')
AddEventHandler('hostages:globalCleanup', function()
    local source = source
    -- -- print("^3[HOSTAGES SERVER] Player " .. source .. " solicitou limpeza global de hostages")
    
    if #allHostageNetworkIds > 0 then
        -- -- print("^3[HOSTAGES SERVER] Enviando " .. #allHostageNetworkIds .. " network IDs para limpeza...")
        TriggerClientEvent('hostages:cleanupNetworkIds', -1, allHostageNetworkIds)
        allHostageNetworkIds = {} -- Limpar lista após enviar
    else
        -- -- print("^1[HOSTAGES SERVER] Nenhum hostage registrado para limpeza")
    end
end)

-- Limpeza automática quando resource para
AddEventHandler('onResourceStop', function(resourceName)
    if GetCurrentResourceName() ~= resourceName then
        return
    end
    
    -- -- print("^3[HOSTAGES SERVER] Resource parando - enviando limpeza de hostages...")
    
    if #allHostageNetworkIds > 0 then
        TriggerClientEvent('hostages:cleanupNetworkIds', -1, allHostageNetworkIds)
    end
end)

-------------------------------------------------------
---- EVENTOS DE CAPTURA DE HOSTAGES ----
-------------------------------------------------------

-- Event para quando um hostage é capturado
RegisterServerEvent('hostages:captured')
AddEventHandler('hostages:captured', function(networkId, hostageId)
    local playerId = source
    local playerName = GetPlayerName(playerId)
    
    -- -- print("^5[HOSTAGES SERVER] Player " .. playerName .. " (" .. playerId .. ") capturou hostage: " .. hostageId .. " (NetID: " .. networkId .. ")")
    
    -- Sincronizar com outros players
    TriggerClientEvent('hostages:syncCapture', -1, networkId, hostageId, playerName)
end)

-- Event para quando um hostage é liberado
RegisterServerEvent('hostages:released')
AddEventHandler('hostages:released', function(networkId, hostageId)
    local playerId = source
    local playerName = GetPlayerName(playerId)
    
    -- -- print("^5[HOSTAGES SERVER] Player " .. playerName .. " (" .. playerId .. ") liberou hostage: " .. hostageId .. " (NetID: " .. networkId .. ")")
    
    -- Sincronizar com outros players
    TriggerClientEvent('hostages:syncRelease', -1, networkId, hostageId)
end)

-------------------------------------------------------
---- EVENTOS DE CONTROLE DE HOSTAGES POR LOBBY ----
-------------------------------------------------------

-- Event para solicitar controle de hostage para membros do lobby
RegisterServerEvent('hostages:requestControlForLobby')
AddEventHandler('hostages:requestControlForLobby', function(networkId, hostageId)
    local playerId = source
    
    -- -- print("^3[HOSTAGES SERVER] Player " .. playerId .. " solicitou controle de hostage: " .. hostageId .. " (NetID: " .. networkId .. ")")
    
    -- Verificar se o player está em um lobby ativo
    local isInLobby = exports.bank_lobby:IsPlayerInActiveLobby(playerId)
    if not isInLobby then
        -- -- print("^1[HOSTAGES SERVER] Player " .. playerId .. " não está em lobby ativo - negando controle")
        return
    end
    
    -- Obter membros do lobby
    local lobbyMembers = exports.bank_lobby:GetPlayerLobbyMembers(playerId)
    if not lobbyMembers or #lobbyMembers == 0 then
        -- -- print("^1[HOSTAGES SERVER] Não foi possível obter membros do lobby para player " .. playerId)
        return
    end
    
    -- -- print("^2[HOSTAGES SERVER] Player " .. playerId .. " está em lobby com " .. #lobbyMembers .. " membros")
    
    -- Enviar comando de request control para todos os membros do lobby
    for _, memberId in ipairs(lobbyMembers) do
        if memberId ~= playerId then -- Não precisa enviar para quem solicitou
            -- -- print("^5[HOSTAGES SERVER] Enviando request control para membro do lobby: " .. memberId)
            TriggerClientEvent('hostages:requestControlFromLobby', memberId, networkId, hostageId, playerId)
        end
    end
end)

-- Event para quando player quer interagir com hostage (mirar, capturar, etc)
RegisterServerEvent('hostages:requestInteraction')
AddEventHandler('hostages:requestInteraction', function(networkId, hostageId, interactionType)
    local playerId = source
    
    -- -- print("^3[HOSTAGES SERVER] Player " .. playerId .. " quer interagir (" .. interactionType .. ") com hostage: " .. hostageId)
    
    -- Verificar se o player está em um lobby ativo
    local isInLobby = exports.bank_lobby:IsPlayerInActiveLobby(playerId)
    if not isInLobby then
        -- -- print("^1[HOSTAGES SERVER] Player " .. playerId .. " não está em lobby - interação negada")
        TriggerClientEvent('hostages:interactionDenied', playerId, hostageId, "Você precisa estar em um lobby ativo")
        return
    end
    
    -- Obter membros do lobby
    local lobbyMembers = exports.bank_lobby:GetPlayerLobbyMembers(playerId)
    if not lobbyMembers or #lobbyMembers == 0 then
        -- -- print("^1[HOSTAGES SERVER] Erro ao obter membros do lobby para player " .. playerId)
        TriggerClientEvent('hostages:interactionDenied', playerId, hostageId, "Erro no sistema de lobby")
        return
    end
    
    -- -- print("^2[HOSTAGES SERVER] Permitindo interação - enviando para " .. #lobbyMembers .. " membros do lobby")
    
    -- Enviar permissão de interação para todos os membros do lobby
    for _, memberId in ipairs(lobbyMembers) do
        TriggerClientEvent('hostages:allowInteraction', memberId, networkId, hostageId, interactionType, playerId)
    end
end)

-- Event específico para ameaça com arma ao banker (para sincronizar movimento)
RegisterServerEvent('hostages:bankerThreatened')
AddEventHandler('hostages:bankerThreatened', function(networkId, bankerData)
    local playerId = source
    
    -- -- print("^3[HOSTAGES SERVER] Player " .. playerId .. " ameaçou o banker - sincronizando movimento")
    
    -- Verificar se o player está em um lobby ativo
    local isInLobby = exports.bank_lobby:IsPlayerInActiveLobby(playerId)
    if not isInLobby then
        -- -- print("^1[HOSTAGES SERVER] Player " .. playerId .. " não está em lobby - ameaça negada")
        return
    end
    
    -- Obter membros do lobby
    local lobbyMembers = exports.bank_lobby:GetPlayerLobbyMembers(playerId)
    if not lobbyMembers or #lobbyMembers == 0 then
        -- -- print("^1[HOSTAGES SERVER] Erro ao obter membros do lobby para ameaça ao banker")
        return
    end
    
    -- -- print("^2[HOSTAGES SERVER] Sincronizando ameaça ao banker para " .. #lobbyMembers .. " membros do lobby")
    
    -- Enviar evento de ameaça ao banker para todos os membros do lobby
    for _, memberId in ipairs(lobbyMembers) do
        TriggerClientEvent('hostages:syncBankerThreat', memberId, networkId, bankerData, playerId)
    end
end)

-- Event para quando banker para de ser ameaçado (parar movimento)
RegisterServerEvent('hostages:bankerThreatStopped')
AddEventHandler('hostages:bankerThreatStopped', function(networkId, bankerData)
    local playerId = source
    
    -- -- print("^3[HOSTAGES SERVER] Player " .. playerId .. " parou de ameaçar o banker - sincronizando parada")
    
    -- Verificar se o player está em um lobby ativo
    local isInLobby = exports.bank_lobby:IsPlayerInActiveLobby(playerId)
    if not isInLobby then
        return
    end
    
    -- Obter membros do lobby
    local lobbyMembers = exports.bank_lobby:GetPlayerLobbyMembers(playerId)
    if not lobbyMembers or #lobbyMembers == 0 then
        return
    end
    
    -- -- print("^2[HOSTAGES SERVER] Sincronizando parada de ameaça ao banker para " .. #lobbyMembers .. " membros do lobby")
    
    -- Enviar evento de parada de ameaça ao banker para todos os membros do lobby
    for _, memberId in ipairs(lobbyMembers) do
        TriggerClientEvent('hostages:syncBankerThreatStop', memberId, networkId, bankerData, playerId)
    end
end)

-------------------------------------------------------
---- CONTROLE DE ESTADO DAS PAREDES DOS BANCOS ----
-------------------------------------------------------

-- Tabela para controlar estado das paredes dos bancos
local bankWallStates = {
    ["Rhodes Bank"] = {
        isOpen = false,
        lastChanged = 0,
        changedBy = nil
    },
    ["Saint Denis Bank"] = {
        isOpen = false,
        lastChanged = 0,
        changedBy = nil
    }
}

-- Função para verificar se parede pode ser alterada
local function CanChangeWallState(bankName, playerId)
    local state = bankWallStates[bankName]
    if not state then return false end
    
    -- Evitar spam - mínimo 2 segundos entre mudanças
    local currentTime = GetGameTimer()
    if currentTime - state.lastChanged < 2000 then
        return false
    end
    
    return true
end

-- Event para abrir parede do banco (bomba/explosão)
RegisterNetEvent('bankrobbery:openBankWall')
AddEventHandler('bankrobbery:openBankWall', function(bankName)
    local src = source
    local playerName = GetPlayerName(src) or "Unknown"
    
    if not CanChangeWallState(bankName, src) then
        -- -- print("^1[BANK WALLS] Mudança de estado negada para " .. bankName .. " (spam protection)")
        return
    end
    
    local state = bankWallStates[bankName]
    if state.isOpen then
        -- -- print("^3[BANK WALLS] " .. bankName .. " já está aberto - ignorando")
        return
    end
    
    -- -- print("^2[BANK WALLS] Abrindo " .. bankName .. " (Player: " .. playerName .. ")")
    
    -- Atualizar estado
    state.isOpen = true
    state.lastChanged = GetGameTimer()
    state.changedBy = src
    
    -- Executar ações específicas por banco
    if bankName == "Rhodes Bank" then
        local coords = vector3(1288.11, -1315.277, 78.399)
        local rayfireObjects = {"des_rho_bankwall"}
        
        -- Executar rayfire
        TriggerClientEvent('bankrobbery:syncRayfire', -1, coords, rayfireObjects, bankName)
        
        -- Aguardar rayfire e abrir interior
        Citizen.SetTimeout(2000, function()
            TriggerClientEvent('bankrobbery:syncInteriorOpen', -1, bankName, 29442, {"rhobank_int_walla"}, {"rhobank_int_wallb"})
        end)
        
    elseif bankName == "Saint Denis Bank" then
        local coords = vector3(2653.033, -1291.999, 52.246)
        local rayfireObjects = {"des_nbd1_bankwall", "des_nbd1_bankwall_int"}
        
        -- Remover IMAP primeiro
        TriggerClientEvent('bankrobbery:syncImap', -1, 1017355491, "remove", bankName)
        
        -- Aguardar e executar rayfire
        Citizen.SetTimeout(500, function()
            TriggerClientEvent('bankrobbery:syncRayfire', -1, coords, rayfireObjects, bankName)
        end)
    end
    
    -- -- print("^2[BANK WALLS] " .. bankName .. " aberto e sincronizado para todos os players")
end)

-- Event para fechar parede do banco (reset/início de assalto)
RegisterNetEvent('bankrobbery:closeBankWall')
AddEventHandler('bankrobbery:closeBankWall', function(bankName)
    local src = source
    local playerName = GetPlayerName(src) or "Unknown"
    
    if not CanChangeWallState(bankName, src) then
        -- -- print("^1[BANK WALLS] Mudança de estado negada para " .. bankName .. " (spam protection)")
        return
    end
    
    local state = bankWallStates[bankName]
    if not state.isOpen then
        -- -- print("^3[BANK WALLS] " .. bankName .. " já está fechado - ignorando")
        return
    end
    
    -- -- print("^2[BANK WALLS] Fechando " .. bankName .. " (Player: " .. playerName .. ")")
    
    -- Atualizar estado
    state.isOpen = false
    state.lastChanged = GetGameTimer()
    state.changedBy = src
    
    -- Executar ações específicas por banco
    if bankName == "Rhodes Bank" then
        local coords = vector3(1288.11, -1315.277, 78.399)
        local rayfireObjects = {"des_rho_bankwall"}
        
        -- Resetar rayfire
        TriggerClientEvent('bankrobbery:syncRayfireReset', -1, coords, rayfireObjects, bankName)
        
        -- Fechar interior
        TriggerClientEvent('bankrobbery:syncInteriorClose', -1, bankName, 29442, {"rhobank_int_wallb"}, {"rhobank_int_walla"})
        
    elseif bankName == "Saint Denis Bank" then
        local coords = vector3(2653.033, -1291.999, 52.246)
        local rayfireObjects = {"des_nbd1_bankwall", "des_nbd1_bankwall_int"}
        
        -- Resetar rayfire
        TriggerClientEvent('bankrobbery:syncRayfireReset', -1, coords, rayfireObjects, bankName)
        
        -- Restaurar IMAP
        TriggerClientEvent('bankrobbery:syncImap', -1, 1017355491, "request", bankName)
    end
    
    -- -- print("^2[BANK WALLS] " .. bankName .. " fechado e sincronizado para todos os players")
end)

-- Event para verificar estado atual da parede
RegisterNetEvent('bankrobbery:checkWallState')
AddEventHandler('bankrobbery:checkWallState', function(bankName)
    local src = source
    local state = bankWallStates[bankName]
    
    if state then
        TriggerClientEvent('bankrobbery:receiveWallState', src, bankName, state.isOpen)
        -- -- print("^6[BANK WALLS] Estado de " .. bankName .. " enviado para player " .. src .. ": " .. tostring(state.isOpen))
    end
end)

-- Event para inicializar banco (fechar todas as paredes)
RegisterNetEvent('bankrobbery:initializeBank')
AddEventHandler('bankrobbery:initializeBank', function(bankName)
    local src = source
    local playerName = GetPlayerName(src) or "Unknown"
    
    -- -- print("^2[BANK WALLS] Inicializando " .. bankName .. " (Player: " .. playerName .. ") - fechando paredes")
    -- -- print("^6[BANK WALLS DEBUG] Estado atual antes da inicialização:")
    
    local state = bankWallStates[bankName]
    if state then
        -- -- print("^6[BANK WALLS DEBUG] " .. bankName .. " - isOpen: " .. tostring(state.isOpen))
        -- Forçar fechamento independente do estado atual
        state.isOpen = false
        state.lastChanged = GetGameTimer()
        state.changedBy = src
        -- -- print("^6[BANK WALLS DEBUG] Estado forçado para fechado")
    else
        -- -- print("^1[BANK WALLS DEBUG] Estado não encontrado para: " .. bankName)
    end
    
    -- Executar fechamento
    if bankName == "Rhodes Bank" then
        local coords = vector3(1288.11, -1315.277, 78.399)
        local rayfireObjects = {"des_rho_bankwall"}
        
        TriggerClientEvent('bankrobbery:syncRayfireReset', -1, coords, rayfireObjects, bankName)
        TriggerClientEvent('bankrobbery:syncInteriorClose', -1, bankName, 29442, {"rhobank_int_wallb"}, {"rhobank_int_walla"})
        
    elseif bankName == "Saint Denis Bank" then
        local coords = vector3(2653.033, -1291.999, 52.246)
        local rayfireObjects = {"des_nbd1_bankwall", "des_nbd1_bankwall_int"}
        
        TriggerClientEvent('bankrobbery:syncRayfireReset', -1, coords, rayfireObjects, bankName)
        TriggerClientEvent('bankrobbery:syncImap', -1, 1017355491, "request", bankName)
    end
    
    -- -- print("^2[BANK WALLS] " .. bankName .. " inicializado com paredes fechadas")
end)

-- -- Comando para debug do estado das paredes
-- RegisterCommand('debug_bank_walls', function(source, args, rawCommand)
--     local src = source
    
--     -- -- print("^6[BANK WALLS DEBUG] Estado das paredes:")
--     for bankName, state in pairs(bankWallStates) do
--         -- -- print("  " .. bankName .. ":")
--         -- -- print("    Aberto: " .. tostring(state.isOpen))
--         -- -- print("    Última mudança: " .. tostring(state.lastChanged))
--         -- -- print("    Mudado por: " .. tostring(state.changedBy))
        
--         if state.lastChanged > 0 then
--             local timeSince = GetGameTimer() - state.lastChanged
--             -- -- print("    Há: " .. math.floor(timeSince / 1000) .. " segundos")
--         end
--     end
-- end, true)

-------------------------------------------------------
---- EVENTOS DE RAYFIRE DOS BANCOS ----
-------------------------------------------------------

-- Event para sincronizar rayfires dos bancos
RegisterServerEvent('bankrobbery:syncRayfire')
AddEventHandler('bankrobbery:syncRayfire', function(coords, rayfireObjects, bankName)
    local sourcePlayer = source
    local players = GetPlayers()
    
    -- -- print("^2[BANK RAYFIRE SERVER] Player " .. sourcePlayer .. " executou rayfire em " .. bankName)
    -- -- print("^2[BANK RAYFIRE SERVER] Objetos: " .. table.concat(rayfireObjects, ", "))
    
    -- Primeiro, executar no próprio player que solicitou
    -- -- print("^5[BANK RAYFIRE SERVER] Enviando rayfire para o próprio player " .. sourcePlayer)
    TriggerClientEvent('bankrobbery:syncRayfire', sourcePlayer, coords, rayfireObjects, bankName)
    
    -- Depois enviar para todos os outros players próximos
    for _, player in ipairs(players) do
        local playerId = tonumber(player)
        if playerId and playerId ~= sourcePlayer then
            local playerPed = GetPlayerPed(playerId)
            if playerPed then
                local playerCoords = GetEntityCoords(playerPed)
                local distance = #(coords - playerCoords)
                
                -- Só sincronizar para players próximos
                if distance <= 100.0 then
                    -- -- print("^5[BANK RAYFIRE SERVER] Sincronizando rayfire para player " .. playerId .. " (distância: " .. math.floor(distance) .. "m)")
                    TriggerClientEvent('bankrobbery:syncRayfire', playerId, coords, rayfireObjects, bankName)
                end
            end
        end
    end
end)

-- Event para sincronizar abertura de interior entre todos os players
RegisterNetEvent('bankrobbery:syncInteriorOpen')
AddEventHandler('bankrobbery:syncInteriorOpen', function(bankName, interiorId, setsToDeactivate, setsToActivate)
    local src = source
    -- -- print("^3[BANK INTERIOR SERVER] Player " .. src .. " abrindo interior para " .. bankName)
    -- -- print("^3[BANK INTERIOR SERVER] Interior ID: " .. interiorId)
    if setsToDeactivate then
        -- -- print("^3[BANK INTERIOR SERVER] Desativar: " .. table.concat(setsToDeactivate, ", "))
    end
    if setsToActivate then
        -- -- print("^3[BANK INTERIOR SERVER] Ativar: " .. table.concat(setsToActivate, ", "))
    end
    
    -- Enviar para todos os players
    TriggerClientEvent('bankrobbery:syncInteriorOpen', -1, bankName, interiorId, setsToDeactivate, setsToActivate)
end)

-- Event para sincronizar fechamento de interior entre todos os players
RegisterNetEvent('bankrobbery:syncInteriorClose')
AddEventHandler('bankrobbery:syncInteriorClose', function(bankName, interiorId, setsToDeactivate, setsToActivate)
    local src = source
    -- -- print("^3[BANK INTERIOR SERVER] Player " .. src .. " fechando interior para " .. bankName)
    -- -- print("^3[BANK INTERIOR SERVER] Interior ID: " .. interiorId)
    if setsToDeactivate then
        -- -- print("^3[BANK INTERIOR SERVER] Desativar: " .. table.concat(setsToDeactivate, ", "))
    end
    if setsToActivate then
        -- -- print("^3[BANK INTERIOR SERVER] Ativar: " .. table.concat(setsToActivate, ", "))
    end
    
    -- Enviar para todos os players
    TriggerClientEvent('bankrobbery:syncInteriorClose', -1, bankName, interiorId, setsToDeactivate, setsToActivate)
end)

-- Event para sincronizar IMAP entre todos os players
RegisterNetEvent('bankrobbery:syncImap')
AddEventHandler('bankrobbery:syncImap', function(imapId, action, bankName)
    local src = source
    -- -- print("^3[BANK IMAP SERVER] Player " .. src .. " " .. action .. " IMAP " .. imapId .. " para " .. bankName)
    
    -- Enviar para todos os players
    TriggerClientEvent('bankrobbery:syncImap', -1, imapId, action, bankName)
end)

-- Event para sincronizar reset de rayfire entre todos os players
RegisterNetEvent('bankrobbery:syncRayfireReset')
AddEventHandler('bankrobbery:syncRayfireReset', function(coords, rayfireObjects, bankName)
    local src = source
    -- -- print("^3[BANK RAYFIRE RESET SERVER] Player " .. src .. " resetando rayfire para " .. bankName)
    -- -- print("^3[BANK RAYFIRE RESET SERVER] Objetos: " .. table.concat(rayfireObjects, ", "))
    
    -- Enviar para todos os players
    TriggerClientEvent('bankrobbery:syncRayfireReset', -1, coords, rayfireObjects, bankName)
end)

-------------------------------------------------------
---- EVENTOS DAS PORTAS DO BANCO ----
-------------------------------------------------------

-- Event para chutar porta (pitch)
RegisterServerEvent('bankdoors:kickDoor')
AddEventHandler('bankdoors:kickDoor', function(doorId)
    local sourcePlayer = source
    local playerName = GetPlayerName(sourcePlayer)
    
    -- -- print("^2[BANK DOORS SERVER] Player " .. playerName .. " (" .. sourcePlayer .. ") chutou porta: " .. doorId)
    
    -- Enviar para todos os players para sincronizar o chute
    TriggerClientEvent('bankdoors:kickDoorOpen', -1, doorId)
    
    -- Atualizar GlobalState para manter sincronização
    if GlobalState.bankDoorStates == nil then
        GlobalState.bankDoorStates = {}
    end
    
    GlobalState.bankDoorStates[doorId] = false -- Porta agora está aberta
    
    -- -- print("^2[BANK DOORS SERVER] Porta " .. doorId .. " chutada e sincronizada para todos os players")
end)

-------------------------------------------------------
---- EVENTOS DAS NOTAS COM COMBINAÇÕES ----
-------------------------------------------------------

-- Evento para coletar nota com combinação (integra com server_usableitems.lua)
RegisterServerEvent('dodi_bankrobbery:collectNoteWithCombination')
AddEventHandler('dodi_bankrobbery:collectNoteWithCombination', function(noteType, vaultId, combination)
    local src = source
    local playerName = GetPlayerName(src)
    
    -- -- print("^5[NOTES SERVER] Player " .. playerName .. " (" .. src .. ") coletou nota " .. noteType .. " com combinação " .. combination .. " para cofre " .. vaultId)
    
    -- Marca que é uma coleta de combinação para evitar notificação duplicada
    _G.isCombiNoteCollection = true
    _G.combiNoteSource = src -- Passa o source correto
    
    -- Chama o evento existente do server_usableitems.lua para dar o item
    TriggerEvent('dodi_bankrobbery:collectNote', noteType, src)
    
    -- Limpa as flags
    _G.isCombiNoteCollection = nil
    _G.combiNoteSource = nil
    
    -- Notificação especial para combinação descoberta
    TriggerClientEvent('dodi_notifys:NotifyLeft', src, GetLanguageText("server", "combinacaoDescoberta"), GetLanguageText("server", "vault") .. vaultId .. ": " .. combination, "generic_textures", "tick", 4000)
end)

-------------------------------------------------------
---- EVENTOS DOS HOSTAGES ----
-------------------------------------------------------

-- Evento para limpeza global de hostages (usado pelo auto reset)
RegisterNetEvent('hostages:globalCleanup')
AddEventHandler('hostages:globalCleanup', function()
    local src = source
    local playerName = GetPlayerName(src) or "Unknown"
    
    -- -- print("^2[HOSTAGES SERVER] Limpeza global solicitada por " .. playerName .. " (" .. src .. ")")
    
    -- Enviar comando de limpeza para TODOS os clientes conectados
    TriggerClientEvent('hostages:executeGlobalCleanup', -1)
    
    -- Enviar notificação apenas para quem solicitou a limpeza
    TriggerClientEvent('dodi_notifys:NotifyLeft', src, 
        GetLanguageText("server", "hostagesLimpos"), 
        GetLanguageText("server", "hostagesRemovedGlobally"), 
        "generic_textures", 
        "tick", 
        3000
    )
    
    -- -- print("^2[HOSTAGES SERVER] Comando de limpeza enviado para todos os clientes")
end)

-- Evento para limpeza de sistema específico
RegisterNetEvent('hostages:cleanupSystem')
AddEventHandler('hostages:cleanupSystem', function(systemName)
    local src = source
    local playerName = GetPlayerName(src) or "Unknown"
    
    -- -- print("^2[HOSTAGES SERVER] Limpeza do sistema " .. systemName .. " por " .. playerName .. " (" .. src .. ")")
    
    -- Enviar para todos os clientes para sincronizar
    TriggerClientEvent('hostages:syncSystemCleanup', -1, systemName)
end)

-------------------------------------------------------
---- EVENTOS DAS NOTAS (SINCRONIZAÇÃO) ----
-------------------------------------------------------

-- Evento para gerar e sincronizar notas para todos da lobby
RegisterNetEvent('notes:generateForLobby')
AddEventHandler('notes:generateForLobby', function(locationName, maxNotes, roundId)
    local src = source
    local playerName = GetPlayerName(src) or "Unknown"
    
    -- -- print("^2[NOTES SERVER] Gerando notas sincronizadas para " .. locationName .. " (Player: " .. playerName .. ", Max: " .. maxNotes .. ")")
    
    -- Gerar dados sincronizados no servidor (seed baseado no tempo + roundId para consistência)
    local seed = GetGameTimer() + (roundId and GetHashKey(roundId) or 0)
    math.randomseed(seed)
    
    -- Simular a mesma lógica do cliente mas no servidor
    local syncData = {
        seed = seed,
        locationName = locationName,
        maxNotes = maxNotes,
        roundId = roundId,
        timestamp = GetGameTimer()
    }
    
    -- -- print("^2[NOTES SERVER] Enviando dados sincronizados (seed: " .. seed .. ") para todos da lobby")
    
    -- Enviar para TODOS os clientes da lobby
    TriggerClientEvent('notes:receiveSyncData', -1, syncData)
end)

-- Tabela para controlar notas spawnadas por lobby
local spawnedNotesControl = {}

-- Evento para sincronizar coleta de nota para todos da lobby
RegisterNetEvent('notes:collectForLobby')
AddEventHandler('notes:collectForLobby', function(spawnId, noteType, vaultId, combination)
    local src = source
    local playerName = GetPlayerName(src) or "Unknown"
    
    -- -- print("^2[NOTES SERVER] Player " .. playerName .. " coletou nota " .. spawnId .. " (Tipo: " .. noteType .. ")")
    
    -- Marcar nota como coletada no controle do servidor
    if spawnedNotesControl[spawnId] then
        spawnedNotesControl[spawnId].collected = true
        spawnedNotesControl[spawnId].collectedBy = src
        spawnedNotesControl[spawnId].collectedAt = GetGameTimer()
    end
    
    -- Enviar para TODOS os clientes para remover a nota
    TriggerClientEvent('notes:syncNoteCollection', -1, spawnId, src, playerName)
    
    -- -- print("^2[NOTES SERVER] Coleta de nota sincronizada para todos os clientes")
end)

-- Evento para registrar notas spawnadas no servidor
RegisterNetEvent('notes:registerSpawnedNotes')
AddEventHandler('notes:registerSpawnedNotes', function(notesData)
    local src = source
    local playerName = GetPlayerName(src) or "Unknown"
    
    -- -- print("^2[NOTES SERVER] Registrando " .. #notesData .. " notas spawnadas por " .. playerName)
    
    -- Limpar controle anterior
    spawnedNotesControl = {}
    
    -- Registrar novas notas
    for _, noteData in ipairs(notesData) do
        spawnedNotesControl[noteData.spawnId] = {
            spawnId = noteData.spawnId,
            noteType = noteData.noteType,
            vaultId = noteData.vaultId,
            combination = noteData.combination,
            coords = noteData.coords,
            spawnedAt = GetGameTimer(),
            collected = false,
            collectedBy = nil,
            collectedAt = nil
        }
    end
    
    -- -- print("^2[NOTES SERVER] " .. #notesData .. " notas registradas no controle do servidor")
end)

-- Evento para limpar controle de notas
RegisterNetEvent('notes:clearSpawnedControl')
AddEventHandler('notes:clearSpawnedControl', function()
    local src = source
    local playerName = GetPlayerName(src) or "Unknown"
    
    -- -- print("^2[NOTES SERVER] Limpando controle de notas spawnadas (solicitado por " .. playerName .. ")")
    spawnedNotesControl = {}
end)

-- -- Comando para debug do controle de notas no servidor
-- RegisterCommand('debug_notes_server', function(source, args, rawCommand)
--     local src = source
    
--     -- -- print("^6[NOTES SERVER DEBUG] Estado do controle de notas:")
--     -- -- print("  Total de notas registradas: " .. GetTableSize(spawnedNotesControl))
    
--     for spawnId, noteData in pairs(spawnedNotesControl) do
--         -- -- print("  " .. spawnId .. ":")
--         -- -- print("    Tipo: " .. noteData.noteType)
--         -- -- print("    Cofre: " .. tostring(noteData.vaultId))
--         -- -- print("    Combinação: " .. tostring(noteData.combination))
--         -- -- print("    Coletada: " .. tostring(noteData.collected))
--         if noteData.collected then
--             -- -- print("    Coletada por: " .. tostring(noteData.collectedBy))
--             -- -- print("    Coletada em: " .. tostring(noteData.collectedAt))
--         end
--         -- -- print("    Spawnada em: " .. tostring(noteData.spawnedAt))
--     end
-- end, true) -- true = server only

-- Função auxiliar para contar elementos em tabela
function GetTableSize(t)
    local count = 0
    if t then
        for _ in pairs(t) do
            count = count + 1
        end
    end
    return count
end

        -- -- print("^2[ROUNDS SERVER] Sistema de rondas do servidor carregado!")
        -- -- print("^2[BANK RAYFIRE SERVER] Sistema de rayfire dos bancos carregado!")
        -- -- print("^2[BANK DOORS SERVER] Sistema de portas do banco carregado!")
        -- -- print("^2[NOTES SERVER] Sistema de notas com combinações carregado!")
        -- -- print("^2[HOSTAGES SERVER] Sistema de hostages do servidor carregado!")
        -- -- print("^2[NOTES SYNC SERVER] Sistema de sincronização de notas carregado!")

-------------------------------------------------------
---- SISTEMA DE CONTROLE DE HOSTAGES ----
-------------------------------------------------------

-- Tabela para rastrear quem está controlando cada hostage
local hostageControllers = {}

-- Evento para reivindicar controle de um hostage
RegisterNetEvent('hostages:claimControl')
AddEventHandler('hostages:claimControl', function(hostageNetworkId, hostageId)
    local source = source
    
 --   print("^2[HOSTAGE CONTROL] Jogador " .. source .. " reivindicou controle do hostage " .. hostageId)
    
    -- Registrar controle
    hostageControllers[hostageNetworkId] = {
        playerId = source,
        hostageId = hostageId,
        claimTime = os.time()
    }
    
    -- Notificar todos os outros jogadores
    TriggerClientEvent('hostages:hostageControlClaimed', -1, hostageNetworkId, hostageId, source)
end)

-- Evento para liberar controle de um hostage
RegisterNetEvent('hostages:releaseControl')
AddEventHandler('hostages:releaseControl', function(hostageNetworkId, hostageId)
    local source = source
    
 --   print("^3[HOSTAGE CONTROL] Jogador " .. source .. " liberou controle do hostage " .. hostageId)
    
    -- Verificar se realmente era o controlador
    local controller = hostageControllers[hostageNetworkId]
    if controller and controller.playerId == source then
        -- Remover controle
        hostageControllers[hostageNetworkId] = nil
        
        -- Notificar todos os jogadores
        TriggerClientEvent('hostages:hostageControlReleased', -1, hostageNetworkId, hostageId, source)
    end
end)

-- Limpeza quando jogador desconecta
AddEventHandler('playerDropped', function(reason)
    local source = source
    
    -- Liberar todos os hostages controlados por este jogador
    for networkId, controller in pairs(hostageControllers) do
        if controller.playerId == source then
          --  print("^3[HOSTAGE CONTROL] Liberando controle do hostage " .. controller.hostageId .. " (jogador desconectou)")
            
            -- Remover controle
            hostageControllers[networkId] = nil
            
            -- Notificar outros jogadores
            TriggerClientEvent('hostages:hostageControlReleased', -1, networkId, controller.hostageId, source)
        end
    end
end)

-- -- Comando para debug do controle de hostages (server)
-- RegisterCommand('debug_hostage_control_server', function(source, args, rawCommand)
--   --  print("^6[HOSTAGE CONTROL SERVER DEBUG] Hostages sendo controlados:")
    
--     local count = 0
--     for networkId, controller in pairs(hostageControllers) do
--         count = count + 1
--      --   print("  - NetworkID: " .. networkId .. " | Hostage: " .. controller.hostageId .. " | Player: " .. controller.playerId)
--     end
    
--   --  print("  Total: " .. count .. " hostages sendo controlados")
    
--     if source > 0 then
--         TriggerClientEvent('chat:addMessage', source, {
--             color = {255, 255, 0},
--             multiline = true,
--             args = {"[DEBUG]", count .. " hostages sendo controlados - check server console"}
--         })
--     end
-- end, true)

--------------------------------------------------------
---- SISTEMA DE REGISTRO DE HOSTAGES PARA LOBBY ----
--------------------------------------------------------

-- Event para registrar hostage para membros do lobby
RegisterServerEvent('hostages:registerHostageForLobby')
AddEventHandler('hostages:registerHostageForLobby', function(networkId, hostageId)
    local playerId = source
    
    -- Verificar se o player está em um lobby ativo
    if GetResourceState('bank_lobby') ~= 'started' then
        return
    end
    
    local isInLobby = exports.bank_lobby:IsPlayerInActiveLobby(playerId)
    if not isInLobby then
        return
    end
    
    -- Obter membros do lobby
    local lobbyMembers = exports.bank_lobby:GetPlayerLobbyMembers(playerId)
    if not lobbyMembers or #lobbyMembers == 0 then
        return
    end
    
  --  print("^2[HOSTAGES SERVER] Registrando hostage " .. hostageId .. " (NetID: " .. networkId .. ") para " .. #lobbyMembers .. " membros do lobby")
    
    -- Enviar registro para todos os membros do lobby
    for _, memberId in ipairs(lobbyMembers) do
        TriggerClientEvent('hostages:registerValidHostage', memberId, networkId, hostageId)
    end
end)

-- Event para remover registro de hostage quando é deletado
RegisterServerEvent('hostages:unregisterHostageForLobby')
AddEventHandler('hostages:unregisterHostageForLobby', function(networkId)
    local playerId = source
    
    -- Verificar se o player está em um lobby ativo
    if GetResourceState('bank_lobby') ~= 'started' then
        return
    end
    
    local isInLobby = exports.bank_lobby:IsPlayerInActiveLobby(playerId)
    if not isInLobby then
        return
    end
    
    -- Obter membros do lobby
    local lobbyMembers = exports.bank_lobby:GetPlayerLobbyMembers(playerId)
    if not lobbyMembers or #lobbyMembers == 0 then
        return
    end
    
  --  print("^3[HOSTAGES SERVER] Removendo registro de hostage (NetID: " .. networkId .. ") para " .. #lobbyMembers .. " membros do lobby")
    
    -- Enviar remoção para todos os membros do lobby
    for _, memberId in ipairs(lobbyMembers) do
        TriggerClientEvent('hostages:unregisterHostage', memberId, networkId)
    end
end)

-------------------------------------------------------
---- SISTEMA DE NOTIFICAÇÕES POLICIAIS ----
-------------------------------------------------------

-- Função para verificar se um player tem job de polícia
local function IsPlayerPolice(playerId)
    if not Config.PoliceNotifications.enabled then
        return false
    end
    
    -- RSGCore Framework
    local RSGCore = exports['rsg-core']:GetCoreObject()
    local Player = RSGCore.Functions.GetPlayer(playerId)
    
    if not Player or not Player.PlayerData or not Player.PlayerData.job then
        return false
    end
    
    local playerJob = Player.PlayerData.job.name
    
    -- Verificar se o job está na lista de jobs policiais
    if playerJob then
        for _, policeJob in ipairs(Config.PoliceNotifications.policeJobs) do
            if playerJob == policeJob then
                return true
            end
        end
    end
    
    return false
end

-- Função para obter todos os policiais online
local function GetOnlinePolice()
    local policeList = {}
    local players = GetPlayers()
    
    for _, playerId in ipairs(players) do
        local playerIdNum = tonumber(playerId)
        if playerIdNum and IsPlayerPolice(playerIdNum) then
            table.insert(policeList, playerIdNum)
        end
    end
    
    return policeList
end

-- Event para notificar polícia sobre assalto ao banco
RegisterNetEvent('rounds:notifyPoliceRobbery')
AddEventHandler('rounds:notifyPoliceRobbery', function(locationId, bankName, bankCoords)
    local source = source
    
    if not Config.PoliceNotifications.enabled then
        return
    end
    
    -- Obter todos os policiais online
    local policeList = GetOnlinePolice()
    
    if #policeList == 0 then
        -- print("^3[POLICE NOTIFY] Nenhum policial online para notificar sobre assalto em " .. bankName)
        return
    end
    
    -- print("^2[POLICE NOTIFY] Notificando " .. #policeList .. " policiais sobre assalto em " .. bankName)
    
    -- Enviar notificação para todos os policiais
    for _, policeId in ipairs(policeList) do
        TriggerClientEvent('rounds:receivePoliceNotification', policeId, locationId, bankName, bankCoords)
    end
    
    -- Log do assalto
    -- print("^1[BANK ROBBERY] Assalto iniciado em " .. bankName .. " por Player " .. source .. " - " .. #policeList .. " policiais notificados")
end)

-- Event para quando uma ronda é iniciada (detectar automaticamente)
RegisterNetEvent('rounds:roundStartedServer')
AddEventHandler('rounds:roundStartedServer', function(locationId)
    local source = source
    
    if not Config.PoliceNotifications.enabled then
        return
    end
    
    -- Obter informações do banco baseado no locationId
    local bankInfo = nil
    local bankCoords = nil
    
    if Config.Rounds and Config.Rounds.Locations and Config.Rounds.Locations[locationId] then
        local config = Config.Rounds.Locations[locationId]
        bankInfo = {
            name = config.displayName or locationId,
            coords = config.bankLocation
        }
        bankCoords = config.bankLocation
    end
    
    if bankInfo and bankCoords then
        -- Notificar polícia automaticamente
        TriggerEvent('rounds:notifyPoliceRobbery', locationId, bankInfo.name, bankCoords)
    else
        -- print("^3[POLICE NOTIFY] Informações do banco não encontradas para locationId: " .. locationId)
    end
end)
