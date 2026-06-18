-------------------------------------------------------
---- BOMB MINIGAME - SERVER SIDE ----
-------------------------------------------------------

local activeBombs = {} -- Tabela para rastrear bombas ativas

-- Função para obter players da mesma lobby
local function GetLobbyPlayers(playerId)
    local lobbyPlayers = {}
    
    -- print("^6[BOMB DEBUG] Verificando lobby para player " .. playerId .. "^7")
    
    if GetResourceState('bank_lobby') == 'started' then
        -- print("^6[BOMB DEBUG] Bank_lobby está ativo^7")
        
        -- Usar export do bank_lobby para obter players da mesma lobby
        local success, players = pcall(function()
            return exports.bank_lobby:GetPlayerLobbyMembers(playerId)
        end)
        
        if success and players and type(players) == "table" and #players > 0 then
            lobbyPlayers = players
            -- print("^3[BOMB SERVER] Lobby encontrada com " .. #players .. " players:^7")
            for i, pId in ipairs(players) do
                local playerName = GetPlayerName(pId) or "Unknown"
                -- print("  - Player " .. pId .. " (" .. playerName .. ")")
            end
        else
            -- Sem lobby válida: não mostrar mini HUD para ninguém
            lobbyPlayers = {}
            -- print("^3[BOMB SERVER] Sem lobby válida - NÃO exibindo mini HUD^7")
        end
    else
        -- bank_lobby não ativo: não mostrar mini HUD para ninguém
        lobbyPlayers = {}
        -- print("^3[BOMB SERVER] Bank_lobby não encontrado - NÃO exibindo mini HUD^7")
    end
    
    return lobbyPlayers
end

-- Evento para sincronizar mini display
RegisterNetEvent('bombMinigame:syncMiniDisplay')
AddEventHandler('bombMinigame:syncMiniDisplay', function(show, remainingTime)
    local src = source
    
    if show then
        -- Ignorar solicitações inválidas
        if not remainingTime or remainingTime <= 0 then
            -- print("^3[BOMB SERVER] Ignorando showMiniDisplay com tempo inválido (" .. tostring(remainingTime) .. ")^7")
            return
        end
        -- Armazenar bomba ativa
        activeBombs[src] = {
            remainingTime = remainingTime,
            startTime = GetGameTimer()
        }
        
        -- print("^2[BOMB SERVER] Player " .. src .. " ativou bomba - Tempo: " .. remainingTime .. "s^7")
        
        -- Obter players da mesma lobby
        local lobbyPlayers = GetLobbyPlayers(src)
        
        -- Normalizar lista (suporta mapas/arrays)
        local normalized = {}
        if #lobbyPlayers == 0 then
            for k, v in pairs(lobbyPlayers) do
                if type(k) == 'number' and GetPlayerName(k) then
                    table.insert(normalized, k)
                elseif type(v) == 'number' and GetPlayerName(v) then
                    table.insert(normalized, v)
                end
            end
        else
            normalized = lobbyPlayers
        end
        
        -- Filtrar por segurança usando export ArePlayersInSameLobby se existir
        if GetResourceState('bank_lobby') == 'started' and exports.bank_lobby and exports.bank_lobby.ArePlayersInSameLobby then
            local filtered = {}
            for _, playerId in ipairs(normalized) do
                local ok, same = pcall(function()
                    return exports.bank_lobby:ArePlayersInSameLobby(src, playerId)
                end)
                if ok and same then
                    table.insert(filtered, playerId)
                end
            end
            normalized = filtered
        end
        
        -- Mostrar mini display apenas para players da lobby
        for _, playerId in ipairs(normalized) do
            TriggerClientEvent('bombMinigame:showMiniDisplay', playerId, remainingTime, true)
        end
        
        -- print("^2[BOMB SERVER] Mini display enviado para " .. #normalized .. " players da lobby^7")
        
        -- Iniciar thread de countdown para lobby
        CreateThread(function()
            local currentTime = remainingTime
            
            while currentTime > 0 and activeBombs[src] do
                Wait(1000)
                currentTime = currentTime - 1
                
                -- Atualizar lobby players
                local currentLobbyPlayers = GetLobbyPlayers(src)
                local normalizedUpdate = {}
                if #currentLobbyPlayers == 0 then
                    for k, v in pairs(currentLobbyPlayers) do
                        if type(k) == 'number' and GetPlayerName(k) then table.insert(normalizedUpdate, k) end
                        if type(v) == 'number' and GetPlayerName(v) then table.insert(normalizedUpdate, v) end
                    end
                else
                    normalizedUpdate = currentLobbyPlayers
                end
                for _, playerId in ipairs(normalizedUpdate) do
                    TriggerClientEvent('bombMinigame:updateMiniDisplay', playerId, currentTime)
                end
                
                if currentTime <= 0 then
                    -- Bomba explodiu
                    activeBombs[src] = nil
                    
                    -- Esconder para lobby players
                    for _, playerId in ipairs(normalizedUpdate) do
                        TriggerClientEvent('bombMinigame:hideMiniDisplay', playerId)
                    end
                    
                    -- print("^1[BOMB SERVER] Bomba do player " .. src .. " explodiu!^7")
                    break
                end
            end
        end)
    else
        -- Remover bomba ativa
        activeBombs[src] = nil
        
        -- Obter players da lobby e esconder mini display
        local lobbyPlayers = GetLobbyPlayers(src)
        for _, playerId in ipairs(lobbyPlayers) do
            TriggerClientEvent('bombMinigame:hideMiniDisplay', playerId)
        end
        
        -- print("^3[BOMB SERVER] Player " .. src .. " desativou bomba^7")
    end
end)

-- Evento quando player desconecta
AddEventHandler('playerDropped', function(reason)
    local src = source
    
    if activeBombs[src] then
        activeBombs[src] = nil
        
        -- Esconder mini display se não há mais bombas ativas
        local hasActiveBombs = false
        for _, _ in pairs(activeBombs) do
            hasActiveBombs = true
            break
        end
        
        if not hasActiveBombs then
            TriggerClientEvent('bombMinigame:hideMiniDisplay', -1)
            -- print("^3[BOMB SERVER] Última bomba removida - escondendo mini display^7")
        end
    end
end)

-- -- Comando para debug das bombas ativas
-- RegisterCommand('bombstatus', function(source, args, rawCommand)
--     local player = source
    
--     local count = 0
--     for playerId, bombData in pairs(activeBombs) do
--         count = count + 1
--         local elapsed = (GetGameTimer() - bombData.startTime) / 1000
--         local remaining = math.max(0, bombData.remainingTime - elapsed)
        
--         -- print("^6[BOMB DEBUG] Player " .. playerId .. " - Tempo restante: " .. math.floor(remaining) .. "s^7")
--     end
    
--     if count == 0 then
--         -- print("^6[BOMB DEBUG] Nenhuma bomba ativa^7")
--     else
--         -- print("^6[BOMB DEBUG] Total de bombas ativas: " .. count .. "^7")
--     end
-- end, false)

-- -- Comando para testar lobby
-- RegisterCommand('testlobby', function(source, args, rawCommand)
--     local player = source
--     local lobbyPlayers = GetLobbyPlayers(player)
    
--     -- print("^6[LOBBY TEST] Player " .. player .. " está em lobby com " .. #lobbyPlayers .. " players:^7")
--     for _, playerId in ipairs(lobbyPlayers) do
--         local playerName = GetPlayerName(playerId) or "Unknown"
--         -- print("  - Player " .. playerId .. " (" .. playerName .. ")")
--     end
-- end, false)

-- -- Comando para forçar esconder mini display (debug)
-- RegisterCommand('hideminibomb', function(source, args, rawCommand)
--     -- print("^3[BOMB DEBUG] Forçando esconder mini display para todos^7")
--     TriggerClientEvent('bombMinigame:hideMiniDisplay', -1)
    
--     -- Limpar bombas ativas
--     activeBombs = {}
--     -- print("^3[BOMB DEBUG] Bombas ativas limpas^7")
-- end, false)

-- print("^2[BOMB MINIGAME] Sistema de sincronização carregado (SERVER)!^7")
