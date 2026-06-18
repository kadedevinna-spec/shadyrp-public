# Sistema de Dinamite - Bank Robbery

## Descrição
Sistema completo de dinamite para explodir portas do banco e paredes dos bancos de Saint Denis e Rhodes.

## Item Necessário
Adicione este item ao seu arquivo de itens:

```lua
["dynamite"] = {
    name = "dynamite", 
    label = "Dynamite", 
    weight = 200, 
    type = "item", 
    image = "dynamite.png", 
    shouldClose = true, 
    useable = true, 
    description = "Explosive device for breaking through doors and walls"
}
```

## Como Usar

### 1. Obter Dinamite
```lua
/createdynamite [quantidade]  -- Comando para criar dinamite (debug)
```

### 2. Usar Dinamite
1. Aproxime-se de uma porta do banco (até 3m) ou parede de banco (até 4m)
2. Use o item `dynamite` do inventário
3. O sistema verificará automaticamente se você está próximo a um alvo válido
4. Se estiver, executará a animação de colocação
5. Após 6 segundos (animação + delay), a explosão ocorrerá

### 3. Alvos Válidos

#### Portas do Banco:
- Porta do Cofre Principal (ID: 1)
- Porta Principal 1 (ID: 2) 
- Porta Da Entrada do Cofre (ID: 3)
- Porta do Cofre Secundário (ID: 4)
- Porta dos Fundos (ID: 5)

#### Paredes dos Bancos:
- **Saint Denis Bank**: Remove IMAP e executa rayfire das paredes
- **Rhodes Bank**: Executa rayfire e abre interior do banco

## Comandos de Debug

```lua
/debugdynamite     -- Mostra informações sobre alvos próximos
/testdynamite      -- Testa dinamite no alvo mais próximo (sem consumir item)
```

## Animações
O sistema usa as animações oficiais do RedM:
- `mech_weapons_special@placed_dynamite@standing` - "front_low"
- `mech_weapons_special@placed_dynamite@kneeling` - "enter"

## Efeitos Visuais
- Explosões duplas com diferentes tipos
- Notificações de countdown (3, 2, 1...)
- Integração completa com sistema de portas e paredes existente

## Integração
- **Portas**: Usa o sistema `bankdoors:kickDoorOpen` existente
- **Saint Denis**: Integra com sistema de IMAP e rayfire
- **Rhodes**: Integra com sistema de interior e rayfire
- **Inventário**: Consome automaticamente 1 dinamite por uso
