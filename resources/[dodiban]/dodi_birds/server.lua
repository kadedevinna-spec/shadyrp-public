local RSGCore = exports['rsg-core']:GetCoreObject()

-- Anti-cheat: Sessões de treino ativas e itens permitidos
local activeTrainingSessions = {} -- [source] = { birdId = id, startTime = time, allowedItems = {} }
local trainingCooldowns = {} -- [source] = lastTrainingEndTime

-- Função para obter itens permitidos do Config (executado no cliente e enviado ao servidor)
local function IsItemAllowedForTraining(itemName, allowedItems)
    if not allowedItems then return false end
    for _, item in ipairs(allowedItems) do
        if item == itemName then
            return true
        end
    end
    return false
end

-- Item usável para abrir o menu de pássaros
RSGCore.Functions.CreateUseableItem('bird_cage', function(source, item)
    local Player = RSGCore.Functions.GetPlayer(source)
    if not Player then return end
    
    TriggerClientEvent('dodi_birds:openMenu', source)
    exports['rsg-inventory']:CloseInventory(source)
end)

-- Auto-install database table on resource start
local function InitializeDatabase()
    local createTableQuery = [[
        CREATE TABLE IF NOT EXISTS `birds` (
            `id` INT(11) NOT NULL AUTO_INCREMENT,
            `charid` INT(11) NOT NULL,
            `identifier` VARCHAR(50) NOT NULL,
            `name` VARCHAR(100) NOT NULL,
            `type` VARCHAR(50) NOT NULL,
            `level` INT(11) NOT NULL DEFAULT 1,
            `xp` VARCHAR(20) NOT NULL DEFAULT '0 / 100',
            `price` INT(11) NOT NULL DEFAULT 0,
            `image` VARCHAR(255) DEFAULT NULL,
            `nickname` VARCHAR(100) DEFAULT '(no name)',
            `outfit` INT(11) NOT NULL DEFAULT 0,
            PRIMARY KEY (`id`),
            INDEX `idx_birds_identifier` (`identifier`),
            INDEX `idx_birds_charid` (`charid`)
        ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
    ]]
    
    exports.oxmysql:execute(createTableQuery, {}, function(result)
        if result then
            print("^2[dodi_birds]^0 Database table 'birds' verified/created successfully!")
        else
            print("^1[dodi_birds]^0 Failed to create database table 'birds'")
        end
    end)
end

-- Run database initialization when resource starts
AddEventHandler('onResourceStart', function(resourceName)
    if GetCurrentResourceName() ~= resourceName then return end
    
    Citizen.Wait(1000) -- Wait for oxmysql to be ready
    InitializeDatabase()
    print("^2[dodi_birds]^0 Resource started - Database initialized")
end)

-- Also run on script load (for restarts)
Citizen.CreateThread(function()
    Citizen.Wait(2000) -- Wait for dependencies
    InitializeDatabase()
end)

-- Buscar pássaros do jogador
RegisterServerEvent('dodi_birds:fetchPlayerBirds')
AddEventHandler('dodi_birds:fetchPlayerBirds', function()
    local _source = source
    local Player = RSGCore.Functions.GetPlayer(_source)
    if not Player then return end
    
    local identifier = Player.PlayerData.citizenid
    local charid = Player.PlayerData.cid or 1

    exports.oxmysql:execute(
        'SELECT * FROM birds WHERE identifier = ? AND charid = ?',
        { identifier, charid },
        function(birds)
            TriggerClientEvent('dodi_birds:receivePlayerBirds', _source, birds or {})
        end
    )
end)

-- Comprar e salvar pássaro no banco de dados
RegisterServerEvent("dodi_birds:saveBird")
AddEventHandler("dodi_birds:saveBird", function(bird)
    local _source = source
    local Player = RSGCore.Functions.GetPlayer(_source)
    if not Player then return end
    
    local identifier = Player.PlayerData.citizenid
    local charid = Player.PlayerData.cid or 1
    local price = tonumber(bird.price) or 0
    
    -- Verificar se o jogador tem dinheiro suficiente
    local playerCash = Player.PlayerData.money['cash'] or 0
    if playerCash < price then
        TriggerClientEvent('dodi_birds:ShowObjective', _source, Config.Locale.insufficientMoney or "Dinheiro insuficiente!", 5000)
        TriggerClientEvent('dodi_birds:purchaseFailed', _source)
        return
    end
    
    -- Descontar o dinheiro
    Player.Functions.RemoveMoney('cash', price, 'bird-purchase')

    exports.oxmysql:insert(
        "INSERT INTO birds (charid, identifier, name, type, level, xp, price, image, nickname, outfit) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)",
        {
            charid,
            identifier,
            bird.name,
            bird.type,
            bird.level,
            bird.xp,
            bird.price,
            bird.image,
            bird.nickname,
            bird.outfit or 0,
        },
        function(insertId)
            if insertId then
                TriggerClientEvent('dodi_birds:purchaseSuccess', _source, bird.name, price)
            else
                -- Devolve o dinheiro se falhou
                Player.Functions.AddMoney('cash', price, 'bird-purchase-refund')
                TriggerClientEvent('dodi_birds:ShowObjective', _source, "Falha ao salvar pássaro!", 5000)
                TriggerClientEvent('dodi_birds:purchaseFailed', _source)
            end
        end
    )
end)

-- Atualizar nome do pássaro
RegisterServerEvent('dodi_birds:updateBirdName')
AddEventHandler('dodi_birds:updateBirdName', function(birdId, nickname)
    local _source = source
    local Player = RSGCore.Functions.GetPlayer(_source)
    if not Player then return end
    
    local identifier = Player.PlayerData.citizenid
    local charid = Player.PlayerData.cid or 1

    exports.oxmysql:execute(
        'UPDATE birds SET nickname = ? WHERE id = ? AND identifier = ? AND charid = ?',
        { nickname, birdId, identifier, charid },
        function(affectedRows)
            if affectedRows then
                -- print(("Bird %d nickname updated to %s for player %s"):format(birdId, nickname, identifier))
            else
                -- print(("Failed to update bird %d for player %s"):format(birdId, identifier))
            end
        end
    )
end)

RegisterServerEvent('dodi_birds:gainXP')
AddEventHandler('dodi_birds:gainXP', function(birdId, xpGained)
    local _source = source
    local Player = RSGCore.Functions.GetPlayer(_source)
    if not Player then return end
    
    local identifier = Player.PlayerData.citizenid
    local charid = Player.PlayerData.cid or 1

    exports.oxmysql:execute(
        'SELECT name, level, xp FROM birds WHERE id = ? AND identifier = ? AND charid = ?',
        { birdId, identifier, charid },
        function(result)
            if result and #result > 0 then
                local bird = result[1]
                local birdName = bird.name
                local currentXP, maxXP = string.match(bird.xp, "(%d+) / (%d+)")
                currentXP = tonumber(currentXP) or 0
                maxXP = tonumber(maxXP) or 100
                local previousLevel = tonumber(bird.level) or 1
                local currentLevel = previousLevel

                local newXP = currentXP + xpGained
                local nextLevelXP = maxXP
                local leveledUp = false

                if newXP >= nextLevelXP then
                    currentLevel = currentLevel + 1
                    newXP = newXP - nextLevelXP
                    maxXP = currentLevel * 100
                    leveledUp = true
                end

                local newXPString = ("%d / %d"):format(newXP, maxXP)

                exports.oxmysql:execute(
                    'UPDATE birds SET xp = ?, level = ? WHERE id = ? AND identifier = ? AND charid = ?',
                    { newXPString, currentLevel, birdId, identifier, charid },
                    function(affectedRows)
                        if affectedRows then
                            TriggerClientEvent('dodi_birds:updateNUI', _source)
                            
                            if leveledUp then
                                TriggerClientEvent('dodi_birds:levelUpNotification', _source, birdName, currentLevel)
                            end
                        end
                    end
                )
            end
        end
    )
end)

-- Iniciar sessão de treino (chamado pelo cliente quando treino começa)
RegisterServerEvent('dodi_birds:startTrainingSession')
AddEventHandler('dodi_birds:startTrainingSession', function(birdId, allowedItems)
    local _source = source
    local Player = RSGCore.Functions.GetPlayer(_source)
    if not Player then return end
    
    local identifier = Player.PlayerData.citizenid
    local charid = Player.PlayerData.cid or 1
    
    -- Verificar se o jogador realmente possui esse pássaro
    exports.oxmysql:execute(
        'SELECT id FROM birds WHERE id = ? AND identifier = ? AND charid = ?',
        { birdId, identifier, charid },
        function(result)
            if result and #result > 0 then
                -- Verificar cooldown (30 segundos entre treinos)
                local currentTime = os.time()
                if trainingCooldowns[_source] and (currentTime - trainingCooldowns[_source]) < 30 then
                    print(("^1[ANTI-CHEAT]^0 Player %s tentou treinar muito rápido"):format(_source))
                    return
                end
                
                -- Registrar sessão de treino
                activeTrainingSessions[_source] = {
                    birdId = birdId,
                    startTime = currentTime,
                    allowedItems = allowedItems or {},
                    itemsGiven = 0,
                    maxItems = 3
                }
            else
                print(("^1[ANTI-CHEAT]^0 Player %s tentou iniciar treino com pássaro que não possui (ID: %s)"):format(_source, tostring(birdId)))
            end
        end
    )
end)

-- Finalizar sessão de treino
RegisterServerEvent('dodi_birds:endTrainingSession')
AddEventHandler('dodi_birds:endTrainingSession', function()
    local _source = source
    if activeTrainingSessions[_source] then
        trainingCooldowns[_source] = os.time()
        activeTrainingSessions[_source] = nil
    end
end)

-- PROTEGIDO: Dar item ao jogador (só funciona durante treino válido)
RegisterServerEvent('dodi_birds:giveItem')
AddEventHandler('dodi_birds:giveItem', function(itemName, quantity)
    local _source = source
    
    -- Anti-cheat: Verificar se existe sessão de treino ativa
    local session = activeTrainingSessions[_source]
    if not session then
        print(("^1[ANTI-CHEAT]^0 Player %s tentou dar item sem sessão de treino ativa"):format(_source))
        return
    end
    
    -- Anti-cheat: Verificar se o item está na lista de permitidos
    if not IsItemAllowedForTraining(itemName, session.allowedItems) then
        print(("^1[ANTI-CHEAT]^0 Player %s tentou dar item não permitido: %s"):format(_source, itemName))
        return
    end
    
    -- Anti-cheat: Verificar limite de itens por sessão
    if session.itemsGiven >= session.maxItems then
        print(("^1[ANTI-CHEAT]^0 Player %s atingiu limite de itens por treino"):format(_source))
        return
    end
    
    -- Anti-cheat: Limitar quantidade
    quantity = math.min(quantity or 1, 1)
    
    -- Anti-cheat: Verificar tempo de sessão (máximo 5 minutos)
    local currentTime = os.time()
    if (currentTime - session.startTime) > 300 then
        print(("^1[ANTI-CHEAT]^0 Player %s sessão de treino expirou"):format(_source))
        activeTrainingSessions[_source] = nil
        return
    end
    
    local Player = RSGCore.Functions.GetPlayer(_source)
    if not Player then return end

    local success = exports['rsg-inventory']:AddItem(_source, itemName, quantity)
    if success then
        session.itemsGiven = session.itemsGiven + 1
        TriggerClientEvent('rsg-inventory:client:ItemBox', _source, RSGCore.Shared.Items[itemName], 'add', quantity)
    end
end)

-- Limpar sessões quando jogador desconecta
AddEventHandler('playerDropped', function()
    local _source = source
    activeTrainingSessions[_source] = nil
    trainingCooldowns[_source] = nil
end)

-- Vender pássaro de volta para o sistema
RegisterServerEvent('dodi_birds:sellBirdToSystem')
AddEventHandler('dodi_birds:sellBirdToSystem', function(birdId)
    local _source = source
    local Player = RSGCore.Functions.GetPlayer(_source)
    if not Player then return end
    
    local identifier = Player.PlayerData.citizenid
    local charid = Player.PlayerData.cid or 1

    exports.oxmysql:execute(
        'SELECT * FROM birds WHERE id = ? AND identifier = ? AND charid = ?',
        { birdId, identifier, charid },
        function(result)
            if result and #result > 0 then
                local bird = result[1]
                local sellPrice = math.floor(bird.price * (Config.SellBackPercentage / 100))
                
                -- Remover o pássaro do banco de dados
                exports.oxmysql:execute(
                    'DELETE FROM birds WHERE id = ? AND identifier = ? AND charid = ?',
                    { birdId, identifier, charid },
                    function(affectedRows)
                        if affectedRows then
                            -- Adicionar dinheiro ao jogador
                            Player.Functions.AddMoney('cash', sellPrice, 'bird-sale')
                            
                            -- Verificar se o pássaro está spawnado e removê-lo
                            TriggerClientEvent('dodi_birds:checkAndRemoveBird', _source, birdId)
                            
                            TriggerClientEvent('dodi_birds:updateNUI', _source)
                            TriggerClientEvent('dodi_birds:ShowObjective', _source, string.format(Config.Locale.birdSold, sellPrice), 5000)
                        else
                            TriggerClientEvent('dodi_birds:ShowObjective', _source, Config.Locale.birdSoldFail, 5000)
                        end
                    end
                )
            else
                TriggerClientEvent('dodi_birds:ShowObjective', _source, Config.Locale.birdNotFound, 5000)
            end
        end
    )
end)

-- Iniciar oferta de venda para outro jogador
RegisterServerEvent('dodi_birds:offerBirdToPlayer')
AddEventHandler('dodi_birds:offerBirdToPlayer', function(targetId, birdId, price)
    local _source = source
    local Player = RSGCore.Functions.GetPlayer(_source)
    if not Player then return end
    
    local identifier = Player.PlayerData.citizenid
    local charid = Player.PlayerData.cid or 1
    
    -- Verificar se o alvo existe
    local TargetPlayer = RSGCore.Functions.GetPlayer(targetId)
    if not TargetPlayer then
        TriggerClientEvent('dodi_birds:notifyPlayer', _source, Config.Locale.targetPlayerNotFound)
        return
    end
    
    -- Verificar se o pássaro existe e pertence ao jogador
    exports.oxmysql:execute(
        'SELECT * FROM birds WHERE id = ? AND identifier = ? AND charid = ?',
        { birdId, identifier, charid },
        function(result)
            if result and #result > 0 then
                local bird = result[1]
                -- Enviar oferta para o jogador alvo
                TriggerClientEvent('dodi_birds:receiveBirdOffer', targetId, _source, birdId, bird, price)
                TriggerClientEvent('dodi_birds:ShowObjective', _source, Config.Locale.offerSent, 5000)
            else
                TriggerClientEvent('dodi_birds:ShowObjective', _source, Config.Locale.birdNotFound, 5000)
            end
        end
    )
end)

-- Aceitar oferta de compra de pássaro
RegisterServerEvent('dodi_birds:acceptBirdOffer')
AddEventHandler('dodi_birds:acceptBirdOffer', function(sellerId, birdId, price)
    local _source = source
    local BuyerPlayer = RSGCore.Functions.GetPlayer(_source)
    if not BuyerPlayer then return end
    
    local buyerIdentifier = BuyerPlayer.PlayerData.citizenid
    local buyerCharid = BuyerPlayer.PlayerData.cid or 1
    
    local SellerPlayer = RSGCore.Functions.GetPlayer(sellerId)
    if not SellerPlayer then
        TriggerClientEvent('dodi_birds:notifyPlayer', _source, Config.Locale.sellerNotFound)
        return
    end
    
    local sellerIdentifier = SellerPlayer.PlayerData.citizenid
    local sellerCharid = SellerPlayer.PlayerData.cid or 1
    
    -- Verificar se o comprador tem dinheiro suficiente
    local buyerCash = BuyerPlayer.PlayerData.money['cash'] or 0
    if buyerCash < price then
        TriggerClientEvent('dodi_birds:ShowObjective', _source, Config.Locale.insufficientMoney, 5000)
        TriggerClientEvent('dodi_birds:ShowObjective', sellerId, Config.Locale.buyerNoMoney, 5000)
        return
    end
    
    -- Verificar se o pássaro ainda existe e pertence ao vendedor
    exports.oxmysql:execute(
        'SELECT * FROM birds WHERE id = ? AND identifier = ? AND charid = ?',
        { birdId, sellerIdentifier, sellerCharid },
        function(result)
            if result and #result > 0 then
                local bird = result[1]
                
                -- Remover dinheiro do comprador
                BuyerPlayer.Functions.RemoveMoney('cash', price, 'bird-purchase')
                
                -- Adicionar dinheiro ao vendedor
                SellerPlayer.Functions.AddMoney('cash', price, 'bird-sale')
                
                -- Transferir o pássaro para o comprador
                exports.oxmysql:execute(
                    'UPDATE birds SET identifier = ?, charid = ? WHERE id = ?',
                    { buyerIdentifier, buyerCharid, birdId },
                    function(affectedRows)
                        if affectedRows then
                            -- Verificar se o pássaro está spawnado e removê-lo
                            TriggerClientEvent('dodi_birds:checkAndRemoveBird', sellerId, birdId)
                            
                            TriggerClientEvent('dodi_birds:ShowObjective', _source, string.format(Config.Locale.birdBoughtSuccess, price), 5000)
                            TriggerClientEvent('dodi_birds:ShowObjective', sellerId, string.format(Config.Locale.birdSoldSuccess, price), 5000)
                            
                            -- Atualizar UI para ambos os jogadores
                            TriggerClientEvent('dodi_birds:updateNUI', _source)
                            TriggerClientEvent('dodi_birds:updateNUI', sellerId)
                        else
                            -- Reverter a transação se falhar
                            BuyerPlayer.Functions.AddMoney('cash', price, 'bird-refund')
                            SellerPlayer.Functions.RemoveMoney('cash', price, 'bird-refund')
                            TriggerClientEvent('dodi_birds:ShowObjective', _source, Config.Locale.transferFailed, 5000)
                            TriggerClientEvent('dodi_birds:ShowObjective', sellerId, Config.Locale.transferFailed, 5000)
                        end
                    end
                )
            else
                TriggerClientEvent('dodi_birds:ShowObjective', _source, Config.Locale.birdNotFoundOrNotOwned, 5000)
                TriggerClientEvent('dodi_birds:ShowObjective', sellerId, Config.Locale.birdNotFoundOrNotYours, 5000)
            end
        end
    )
end)

-- Recusar oferta de compra de pássaro
RegisterServerEvent('dodi_birds:declineBirdOffer')
AddEventHandler('dodi_birds:declineBirdOffer', function(sellerId)
    local _source = source
    TriggerClientEvent('dodi_birds:ShowObjective', _source, Config.Locale.offerDeclined, 5000)
    TriggerClientEvent('dodi_birds:ShowObjective', sellerId, Config.Locale.yourOfferDeclined, 5000)
end)
