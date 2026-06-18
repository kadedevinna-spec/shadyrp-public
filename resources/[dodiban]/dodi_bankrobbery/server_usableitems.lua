local RSGCore = exports['rsg-core']:GetCoreObject()

-- Lista de todas as notas válidas
local validNotes = {
    "02_99_41_note",
    "49_10_32_note",
    "07_45_92_note",
    "38_11_64_note",
    "56_03_87_note",
    "21_74_09_note",
    "95_62_48_note",
    "13_80_27_note",
    "44_19_53_note",
    "68_07_36_note",
    "90_24_15_note",
    "72_33_08_note",
    "59_14_67_note",
    "81_06_25_note",
    "34_58_12_note",
    "17_83_40_note",
    "26_91_05_note",
    "63_39_78_note",
    "85_28_60_note"
}

-- Criar item usável para cada nota
for _, noteId in ipairs(validNotes) do
    RSGCore.Functions.CreateUseableItem(noteId, function(source, item)
        local Player = RSGCore.Functions.GetPlayer(source)
        if not Player then return end
        
        -- Debug
        -- -- print("^3[BANK NOTE DEBUG] Item usado: " .. noteId .. "^7")
        

        -- Notifica o jogador
        TriggerClientEvent('dodi_notifys:NotifyLeft', source, GetLanguageText("server", "bankNote"), GetLanguageText("server", "examinedBankNote"), "generic_textures", "tick", 4000)
        
        -- Triggera o evento da nota específica no cliente
        TriggerClientEvent('info_' .. noteId, source)
        
        -- -- print("^2[BANK NOTE] Jogador " .. source .. " usou " .. noteId .. "^7")
    end)
end

-- -- Comando para admins criarem bank_notes
-- RegisterCommand('createbanknote', function(source, args, rawCommand)
--     local Player = RSGCore.Functions.GetPlayer(source)
--     if not Player then 
--         -- -- print("^1[BANK NOTE] Player não encontrado para source: " .. tostring(source) .. "^7")
--         return 
--     end
    
--     -- -- print("^3[BANK NOTE] Comando executado por jogador: " .. source .. "^7")
    
--     if not args[1] then
--         TriggerClientEvent('dodi_notifys:NotifyLeft', source, GetLanguageText("server", "usoIncorreto"), GetLanguageText("server", "createBankNote"), "generic_textures", "cross", 4000)
--         -- -- print("^1[BANK NOTE] Argumentos insuficientes^7")
--         return
--     end
    
--     local noteId = args[1]
--     local amount = tonumber(args[2]) or 1
    
--     -- -- print("^3[BANK NOTE] Criando nota: " .. noteId .. " quantidade: " .. amount .. "^7")
    
--     -- Verifica se é um noteId válido
--     local isValidNote = false
--     for _, validNote in ipairs(validNotes) do
--         if noteId == validNote then
--             isValidNote = true
--             break
--         end
--     end
    
--     if not isValidNote then
--         TriggerClientEvent('dodi_notifys:NotifyLeft', source, GetLanguageText("server", "erro"), GetLanguageText("server", "invalidNoteId") .. noteId, "generic_textures", "cross", 4000)
--         -- -- print("^1[BANK NOTE] ID de nota inválido: " .. noteId .. "^7")
--         return
--     end
    
--     -- Cria o item específico
--     Player.Functions.AddItem(noteId, amount, false, {
--         description = "Bank note with important information",
--         created_at = os.date("%d/%m/%Y %H:%M:%S")
--     })
    
--     TriggerClientEvent('dodi_notifys:NotifyLeft', source, GetLanguageText("server", "notaCriada"), noteId .. GetLanguageText("server", "addedToInventory"), "generic_textures", "tick", 4000)
--     -- -- print("^2[BANK NOTE] Nota " .. noteId .. " criada com sucesso para jogador: " .. source .. "^7")
-- end)

-- BANK NOTES - Copy this to your items file
-- ["02_99_41_note"] = {name = "02_99_41_note", label = "Bank Note #02994", weight = 50, type = "item", image = "bank_note.png", shouldClose = true, useable = true},
-- ["49_10_32_note"] = {name = "49_10_32_note", label = "Bank Note #49103", weight = 50, type = "item", image = "bank_note.png", shouldClose = true, useable = true},
-- ["07_45_92_note"] = {name = "07_45_92_note", label = "Bank Note #07459", weight = 50, type = "item", image = "bank_note.png", shouldClose = true, useable = true},
-- ["38_11_64_note"] = {name = "38_11_64_note", label = "Bank Note #38116", weight = 50, type = "item", image = "bank_note.png", shouldClose = true, useable = true},
-- ["56_03_87_note"] = {name = "56_03_87_note", label = "Bank Note #56038", weight = 50, type = "item", image = "bank_note.png", shouldClose = true, useable = true},
-- ["21_74_09_note"] = {name = "21_74_09_note", label = "Bank Note #21740", weight = 50, type = "item", image = "bank_note.png", shouldClose = true, useable = true},
-- ["95_62_48_note"] = {name = "95_62_48_note", label = "Bank Note #95624", weight = 50, type = "item", image = "bank_note.png", shouldClose = true, useable = true},
-- ["13_80_27_note"] = {name = "13_80_27_note", label = "Bank Note #13802", weight = 50, type = "item", image = "bank_note.png", shouldClose = true, useable = true},
-- ["44_19_53_note"] = {name = "44_19_53_note", label = "Bank Note #44195", weight = 50, type = "item", image = "bank_note.png", shouldClose = true, useable = true},
-- ["68_07_36_note"] = {name = "68_07_36_note", label = "Bank Note #68073", weight = 50, type = "item", image = "bank_note.png", shouldClose = true, useable = true},
-- ["90_24_15_note"] = {name = "90_24_15_note", label = "Bank Note #90241", weight = 50, type = "item", image = "bank_note.png", shouldClose = true, useable = true},
-- ["72_33_08_note"] = {name = "72_33_08_note", label = "Bank Note #72330", weight = 50, type = "item", image = "bank_note.png", shouldClose = true, useable = true},
-- ["59_14_67_note"] = {name = "59_14_67_note", label = "Bank Note #59146", weight = 50, type = "item", image = "bank_note.png", shouldClose = true, useable = true},
-- ["81_06_25_note"] = {name = "81_06_25_note", label = "Bank Note #81062", weight = 50, type = "item", image = "bank_note.png", shouldClose = true, useable = true},
-- ["34_58_12_note"] = {name = "34_58_12_note", label = "Bank Note #34581", weight = 50, type = "item", image = "bank_note.png", shouldClose = true, useable = true},
-- ["17_83_40_note"] = {name = "17_83_40_note", label = "Bank Note #17834", weight = 50, type = "item", image = "bank_note.png", shouldClose = true, useable = true},
-- ["26_91_05_note"] = {name = "26_91_05_note", label = "Bank Note #26910", weight = 50, type = "item", image = "bank_note.png", shouldClose = true, useable = true},
-- ["63_39_78_note"] = {name = "63_39_78_note", label = "Bank Note #63397", weight = 50, type = "item", image = "bank_note.png", shouldClose = true, useable = true},
-- ["85_28_60_note"] = {name = "85_28_60_note", label = "Bank Note #85286", weight = 50, type = "item", image = "bank_note.png", shouldClose = true, useable = true},

-- =====================================================
-- TORCH TOOL SYSTEM
-- =====================================================

-- Item usável torch_tool
RSGCore.Functions.CreateUseableItem('torch_tool', function(source, item)
    local Player = RSGCore.Functions.GetPlayer(source)
    if not Player then return end
    
    -- Debug
    -- -- print("^3[TORCH TOOL DEBUG] Item usado por: " .. source .. "^7")
    
    -- Triggera evento no cliente para verificar proximidade com portas
    TriggerClientEvent('torch:checkDoorProximity', source)
    
    -- -- print("^2[TORCH TOOL] Verificando proximidade com portas para jogador: " .. source .. "^7")
end)

-- -- Comando para criar torch_tool (debug)
-- RegisterCommand('createtorch', function(source, args, rawCommand)
--     local Player = RSGCore.Functions.GetPlayer(source)
--     if not Player then return end
    
--     local amount = tonumber(args[1]) or 1
    
--     Player.Functions.AddItem('torch_tool', amount)
--     TriggerClientEvent('dodi_notifys:NotifyLeft', source, GetLanguageText("server", "torchTool"), GetLanguageText("server", "torchToolAdded"), "generic_textures", "tick", 4000)
    
--     -- -- print("^2[TORCH TOOL] Torch tool criada para jogador: " .. source .. " (quantidade: " .. amount .. ")^7")
-- end)

-- =====================================================
-- SISTEMA DE COLETA DE NOTAS SPAWNS
-- =====================================================

-- Evento para quando um player coleta uma nota do spawn
RegisterNetEvent('dodi_bankrobbery:collectNote')
AddEventHandler('dodi_bankrobbery:collectNote', function(noteType, sourceOverride)
    local source = sourceOverride or source -- Usa o source passado ou o source do evento
    local Player = RSGCore.Functions.GetPlayer(source)
    
    if not Player then 
        -- -- print("^1[NOTES COLLECT] Player não encontrado para source: " .. tostring(source) .. "^7")
        return 
    end
    
    -- Verifica se é um tipo de nota válido
    local isValidNote = false
    for _, validNote in ipairs(validNotes) do
        if noteType == validNote then
            isValidNote = true
            break
        end
    end
    
    if not isValidNote then
        -- -- print("^1[NOTES COLLECT] Tipo de nota inválido: " .. noteType .. "^7")
        TriggerClientEvent('dodi_notifys:NotifyLeft', source, GetLanguageText("server", "erro"), GetLanguageText("server", "invalidNoteType"), "generic_textures", "cross", 4000)
        return
    end
    
    -- Adiciona o item ao inventário do player
    Player.Functions.AddItem(noteType, 1, false, {
        description = "Bank note found during robbery",
        collected_at = os.date("%d/%m/%Y %H:%M:%S"),
        source = "spawn_collection"
    })
    
    -- Notifica o player (só se não for chamado pelo sistema de combinações)
    if not _G.isCombiNoteCollection then
        TriggerClientEvent('dodi_notifys:NotifyLeft', source, GetLanguageText("server", "notaColetada"), GetLanguageText("server", "youCollected") .. noteType, "generic_textures", "tick", 4000)
    end
    
    -- Log para debug
    -- -- print("^2[NOTES COLLECT] Jogador " .. source .. " coletou nota: " .. noteType .. "^7")
end)

-- =====================================================
-- SISTEMA DE DINAMITE
-- =====================================================

-- Item usável dynamite
RSGCore.Functions.CreateUseableItem('dynamite', function(source, item)
    local Player = RSGCore.Functions.GetPlayer(source)
    if not Player then return end
    
    -- Debug
    -- -- print("^3[DYNAMITE DEBUG] Item usado por: " .. source .. "^7")
    
    -- Triggera evento no cliente para verificar proximidade com portas/paredes
    TriggerClientEvent('dynamite:checkProximity', source)
    
    -- -- print("^2[DYNAMITE] Verificando proximidade com alvos para jogador: " .. source .. "^7")
end)

-- -- Comando para criar dynamite (debug)
-- RegisterCommand('createdynamite', function(source, args, rawCommand)
--     local Player = RSGCore.Functions.GetPlayer(source)
--     if not Player then return end
    
--     local amount = tonumber(args[1]) or 1
    
--     Player.Functions.AddItem('dynamite', amount)
--     TriggerClientEvent('dodi_notifys:NotifyLeft', source, GetLanguageText("server", "dynamite"), GetLanguageText("server", "dynamiteAdded"), "generic_textures", "tick", 4000)
    
--     -- -- print("^2[DYNAMITE] Dinamite criada para jogador: " .. source .. " (quantidade: " .. amount .. ")^7")
-- end)

-- Evento para consumir dinamite após uso bem-sucedido
RegisterNetEvent('dynamite:consumeItem')
AddEventHandler('dynamite:consumeItem', function()
    local source = source
    local Player = RSGCore.Functions.GetPlayer(source)
    
    if not Player then return end
    
    -- Remove 1 dinamite do inventário
    Player.Functions.RemoveItem('dynamite', 1)
    
    -- -- print("^2[DYNAMITE] Dinamite consumida pelo jogador: " .. source .. "^7")
end)

-- =====================================================
-- SISTEMA DE COFRES
-- =====================================================

-- Evento para quando um player abre um cofre
RegisterNetEvent('dodi_bankrobbery:openVault')
AddEventHandler('dodi_bankrobbery:openVault', function(vaultId, items, moneyConfig)
    local source = source
    local Player = RSGCore.Functions.GetPlayer(source)
    
    if not Player then 
        -- -- print("^1[VAULTS] Player não encontrado para source: " .. tostring(source) .. "^7")
        return 
    end
    
    local rewardText = {}
    
    -- Adiciona itens se existirem
    if items and #items > 0 then
        for _, itemName in ipairs(items) do
            Player.Functions.AddItem(itemName, 1, false, {
                description = "Item found in bank vault",
                vault_id = vaultId,
                opened_at = os.date("%d/%m/%Y %H:%M:%S")
            })
            
            table.insert(rewardText, itemName)
            -- -- print("^2[VAULTS] Item adicionado: " .. itemName .. " para jogador: " .. source .. "^7")
        end
    end
    
    -- Adiciona dinheiro aleatório se configurado
    if moneyConfig and moneyConfig.min and moneyConfig.max then
        local randomMoney = math.random(moneyConfig.min, moneyConfig.max)
        Player.Functions.AddMoney('cash', randomMoney)
        
        table.insert(rewardText, "$" .. randomMoney)
        -- -- print("^2[VAULTS] Dinheiro adicionado: $" .. randomMoney .. " para jogador: " .. source .. "^7")
    end
    
    -- Notifica o player
    if #rewardText > 0 then
        local rewardsText = table.concat(rewardText, ", ")
        TriggerClientEvent('dodi_notifys:NotifyLeft', source, GetLanguageText("server", "cofreAberto"), GetLanguageText("server", "rewards") .. rewardsText, "generic_textures", "tick", 4000)
    else
        TriggerClientEvent('dodi_notifys:NotifyLeft', source, GetLanguageText("server", "cofreVazio"), GetLanguageText("server", "vaultWasEmpty"), "generic_textures", "cross", 4000)
    end
    
    -- Log para debug
    if #rewardText > 0 then
        local rewardsText = table.concat(rewardText, ", ")
        -- -- print("^2[VAULTS] Jogador " .. source .. " abriu cofre: " .. vaultId .. " - Recompensas: " .. rewardsText .. "^7")
    else
        -- -- print("^3[VAULTS] Jogador " .. source .. " abriu cofre vazio: " .. vaultId .. "^7")
    end
end)

        -- -- print("^2[BANK LOBBY] Sistema de bank_note, torch_tool, dinamite, coleta de notas e cofres carregado com sucesso!^7")

-- =====================================================
-- SISTEMA DE MÁSCARA DE GÁS
-- =====================================================



-- Item usável gas_mask
RSGCore.Functions.CreateUseableItem('gas_mask', function(source, item)
    local Player = RSGCore.Functions.GetPlayer(source)
    if not Player then return end
    
    -- Debug
    -- -- print("^3[GAS MASK DEBUG] Item usado por: " .. source .. "^7")
    
    -- Triggera evento no cliente para equipar/remover máscara
    TriggerClientEvent('gasmask:toggle', source)
   
    -- -- print("^2[GAS MASK] Máscara de gás ativada para jogador: " .. source .. "^7")
end)

-- -- Comando para criar gas_mask (debug)
-- RegisterCommand('creategasmask', function(source, args, rawCommand)
--     local Player = RSGCore.Functions.GetPlayer(source)
--     if not Player then return end
    
--     local amount = tonumber(args[1]) or 1
    
--     Player.Functions.AddItem('gas_mask', amount, false, {
--         description = "Protective gas mask for toxic environments",
--         created_at = os.date("%d/%m/%Y %H:%M:%S")
--     })
    
--     TriggerClientEvent('dodi_notifys:NotifyLeft', source, GetLanguageText("server", "mascaraDeGas"), GetLanguageText("server", "gasMaskAdded"), "generic_textures", "tick", 4000)
    
--     -- -- print("^2[GAS MASK] Máscara de gás criada para jogador: " .. source .. " (quantidade: " .. amount .. ")^7")
-- end)

        -- -- print("^2[BANK LOBBY] Sistema de bank_note, torch_tool, dinamite, coleta de notas, cofres e máscara de gás carregado com sucesso!^7")

-- ITEMS TO ADD TO YOUR ITEMS FILE:
-- ["dynamite"] = {name = "dynamite", label = "Dynamite", weight = 200, type = "item", image = "dynamite.png", shouldClose = true, useable = true, description = "Explosive device for breaking through doors and walls"}
-- ["gas_mask"] = {name = "gas_mask", label = "Gas Mask", weight = 150, type = "item", image = "gas_mask.png", shouldClose = true, useable = true, description = "Protective mask against toxic gases"}