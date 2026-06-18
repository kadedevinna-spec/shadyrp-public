# Dynamite System - Exports & Callbacks

## Fluxo Completo da Dinamite

### 1. **Sequência de Uso:**
1. Player usa item `dynamite`
2. Sistema verifica proximidade com alvos
3. **Animação Standing** (1 segundo)
4. **Animação Kneeling** (1 segundo) 
5. **PAUSA** - Player fica na animação kneeling
6. **Minigame da Bomba** abre automaticamente
7. Player configura tempo da bomba
8. **Callback** executa baseado no resultado
9. **Countdown** dinâmico baseado no tempo configurado
10. **Explosão** final

---

## Exports do Minigame (dodi_clockbomb_minigame)

### `StartBombMinigame(callback)`
```lua
exports.dodi_clockbomb_minigame:StartBombMinigame(function(success, data)
    if success then
        print("Bomba configurada! Tempo: " .. data.time .. " segundos")
        -- data.time = tempo configurado pelo player
        -- data.result = "exploded"
    else
        print("Minigame cancelado: " .. data.reason)
        -- data.reason = "cancelled", "already_open", etc.
    end
end)
```

### `IsBombMinigameOpen()`
```lua
local isOpen = exports.dodi_clockbomb_minigame:IsBombMinigameOpen()
```

### `CloseBombMinigame(success, data)`
```lua
exports.dodi_clockbomb_minigame:CloseBombMinigame(true, {time = 10, result = "forced"})
```

---

## Exports da Dinamite (dodi_bankrobbery)

### `UseDynamite(callback)`
**Uso completo da dinamite com callback customizado**
```lua
exports.dodi_bankrobbery:UseDynamite(function(success, data)
    if success then
        print("Explosão realizada!")
        print("Alvo: " .. data.target.description)
        print("Tempo da bomba: " .. data.bombTime .. "s")
        print("Resultado: " .. data.result)
    else
        print("Falha: " .. data.reason)
        print("Mensagem: " .. (data.message or "N/A"))
    end
end)
```

### `GetNearbyDynamiteTargets(coords, maxDistance)`
**Lista alvos próximos**
```lua
local targets = exports.dodi_bankrobbery:GetNearbyDynamiteTargets()
-- coords = coordenadas (opcional, padrão: player)
-- maxDistance = distância máxima (opcional, padrão: 10.0)

for _, targetInfo in ipairs(targets) do
    print("Alvo: " .. targetInfo.target.description)
    print("Distância: " .. targetInfo.distance .. "m")
    print("No alcance: " .. tostring(targetInfo.inRange))
end
```

### `GetDynamiteTargetInfo(targetType, targetId)`
**Informações de alvo específico**
```lua
-- Para portas
local doorTarget = exports.dodi_bankrobbery:GetDynamiteTargetInfo("door", 1)

-- Para paredes
local wallTarget = exports.dodi_bankrobbery:GetDynamiteTargetInfo("wall", "Saint Denis Bank")
```

### `CanUseDynamite(coords)`
**Verifica se pode usar dinamite**
```lua
local canUse, target, distance = exports.dodi_bankrobbery:CanUseDynamite()

if canUse then
    print("Pode usar dinamite no alvo: " .. target.description)
    print("Distância: " .. distance .. "m")
else
    print("Nenhum alvo válido próximo")
end
```

---

## Exemplos de Uso

### **Exemplo 1: Script Customizado de Dinamite**
```lua
-- Verificar se pode usar
local canUse, target = exports.dodi_bankrobbery:CanUseDynamite()

if canUse then
    -- Usar dinamite com callback customizado
    exports.dodi_bankrobbery:UseDynamite(function(success, data)
        if success then
            -- Dar recompensa ao player
            TriggerServerEvent('myscript:giveReward', data.target.type)
            
            -- Log da explosão
            print("Player explodiu: " .. data.target.description)
        else
            -- Punir por falha
            TriggerServerEvent('myscript:punishFailure', data.reason)
        end
    end)
else
    -- Notificar que não pode usar
    TriggerEvent('dodi_notifys:NotifyLeft', "Erro", "Nenhum alvo próximo", "generic_textures", "cross", 4000)
end
```

### **Exemplo 2: Sistema de Proximidade**
```lua
CreateThread(function()
    while true do
        local targets = exports.dodi_bankrobbery:GetNearbyDynamiteTargets(nil, 5.0)
        
        if #targets > 0 then
            local closest = targets[1]
            if closest.inRange then
                -- Mostrar prompt para usar dinamite
                DisplayHelpText("Pressione [E] para usar dinamite")
                
                if IsControlJustPressed(0, 0x26E9DC00) then -- E key
                    exports.dodi_bankrobbery:UseDynamite(function(success, data)
                        -- Handle resultado
                    end)
                end
            end
        end
        
        Wait(100)
    end
end)
```

---

## Dados de Callback

### **Success = true**
```lua
{
    target = {
        type = "door" | "wall",
        description = "Nome do alvo",
        coords = vector3(x, y, z),
        -- ... outros dados do alvo
    },
    bombTime = 10, -- tempo configurado no minigame
    result = "exploded"
}
```

### **Success = false**
```lua
{
    reason = "no_target" | "cancelled" | "animation_error" | "already_open",
    message = "Mensagem descritiva" -- opcional
}
```
