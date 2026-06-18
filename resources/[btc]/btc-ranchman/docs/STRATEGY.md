# btc-ranchmanv2 — Estratégia de Reestruturação por Áreas de Animais

> **Leia este arquivo antes de qualquer conversa sobre este projeto.**
> Ele descreve as mudanças planejadas, a ordem de implementação e o estado atual de cada etapa.

---

## Contexto

O rancho está funcional. Estamos incrementando um sistema de **áreas por tipo de animal** (polígonos vec3), onde cada tipo de animal tem seu próprio menu, área de pasto, e medidores de chore independentes. O menu geral vira visão geral. Prompts aparecem apenas na mira. Animais guardados aparecem visualmente na área (client-only). Cavalos entram na estrutura mas sem lógica específica ainda.

---

## Nova Estrutura de Config (`shared/config.lua`)

```lua
[22] = {
    MenuLocation = vector4(-2556.93, 397.77, 148.10, 50.66), -- menu geral do rancho (overview apenas)
    MaxAnimals   = 50,

    Animals = {
        Cows = {
            Menu = vector4(x, y, z, h),              -- local do NPC/prompt/store deste tipo
            Area = { vec3(...), vec3(...), vec3(...), vec3(...) }, -- polígono do pasto
        },
        Goats    = { Menu = vector4(...), Area = { ... } },
        Pigs     = { Menu = vector4(...), Area = { ... } },
        Sheeps   = { Menu = vector4(...), Area = { ... } },
        Chickens = { Menu = vector4(...), Area = { ... } },  -- Menu = galinheiro
    },
},
```

**Regra**: Se `Animals[tipo]` não existir no rancho → rancho não suporta aquele animal.

**Cada `Menu` serve como**: ponto de NPC + prompt de abrir menu do tipo + prompt de guardar animais daquele tipo.

---

## Requisitos Transversais (aplicar em TODAS as etapas)

### 1. Comentários obrigatórios
Todo bloco de código novo ou modificado deve ter comentário explicando **o que faz e por quê**:
```lua
-- [REESTRUTURAÇÃO] Cada tipo de animal tem seu próprio menu/store em animalArea.Menu.
-- Iteramos Animals do rancho em vez do Coords antigo para criar um prompt por tipo.
for animalType, animalArea in pairs(ranchConfig.Animals) do
    ...
end
```

### 2. Traduções obrigatórias
- Strings Lua → `shared/locale.lua` (pt-br e en-us)
- Strings NUI/HTML → `html/locale.js`
- Zero strings hardcoded

### 3. Notificações dentro da NUI
Quando NUI está aberta (`nuiFocusEnabled = true`), notificações vão para dentro da NUI:
```lua
-- [REESTRUTURAÇÃO] Wrapper de notificação: dentro da NUI mostra internamente, fora usa Notify
function RanchNotify(msg, type)
    if nuiFocusEnabled then
        SendNUIMessage({ action = 'notification', message = msg, type = type })
    else
        Notify(msg, type)
    end
end
```

### 4. Separação de novas funcionalidades
Novas funcionalidades devem ser incluidas em novos arquivos, deixando melhor a organização e a compreensão do código.
```

---

## Arquivos Críticos

| Arquivo | O que muda |
|---------|-----------|
| `shared/config.lua` | Estrutura `Animals` por rancho em `Config.Animals` |
| `shared/open_functions.lua` | +6 funções de polígono no final (sem deps externas) |
| `client/client.lua` | `UpdateRanchElements()`: prompts/NPCs por tipo |
| `client/client_animal_manager.lua` | Prompt loop com mira; display de animais guardados |
| `client/client_ranch_chores.lua` | `startChore` com `animalType` + coords de polígono |
| `client/client_menu.lua` | Menus por tipo; menu geral = overview |
| `client/client_props.lua` | Migrar `Coords.ChickenCoop` → `Animals.Chickens.Menu` |
| `server/server.lua` | `handleChore` + `animalType`; migração DB |
| `server/server_animal_manager.lua` | Callback animais por tipo |
| `html/script.js` + `html/ui.html` | Overview + notificações internas |

---

## Funções de Polígono (`shared/open_functions.lua` — final do arquivo)

```lua
function PointInPolygon(polygon, x, y)        -- ray-casting 2D, ignora Z
function RandomPointInsidePolygon(polygon, attempts)  -- rejeição por bounding box
function RandomPointOnPolygonEdge(polygon)    -- ponto aleatório em aresta (para Repair)
function GetPolygonCentroid(polygon)          -- centroide (para wander + Z fallback)
function GetAnimalArea(ranchId, animalType)   -- nil-safe: retorna Animals[tipo] ou nil
function GetChoreValue(ranchChores, animalType, choreType) -- lê chore, suporta formato antigo e novo
```

---

## Migração de DB (`ranchChores` JSON)

**Formato antigo** (detectar pela chave `poop` na raiz):
```json
{ "poop": 100, "hay": 100, "repair": 100, "water": 100 }
```

**Formato novo** (por tipo de animal):
```json
{
  "Cows":  { "poop": 100, "hay": 100, "repair": 100, "water": 100 },
  "Goats": { "poop": 100, "hay": 100, "repair": 100, "water": 100 }
}
```

Migração automática no `InitializeDatabase` do `server.lua`. Idempotente.

---

## Lógica dos Chores por Área

- **repair**: `RandomPointOnPolygonEdge` → player vai até a borda do polígono
- **hay**: `RandomPointInsidePolygon` → spawn prop de feno no local sorteado
- **poop**: `RandomPointInsidePolygon` → spawn prop de cocô no local sorteado
- **water**: `RandomWaterInsidePolygon` → analisa se há alguma prop compativel com a tabela (config.waterprops), se houver seleciona uma delas e criar o prompt, se não houver props para isso, apenas escolhe um local aleatório

Cada área tem seus próprios medidores. Os medidores afetam apenas os animais daquele tipo naquela área.

---

## Animais Guardados Visíveis na Área (client-only)

- Loop a cada 5s: player <60m de algum `Animals[tipo].Menu` → busca animais guardados no server
- Spawnar peds locais (SEM rede, `CreatePed(..., false, false)`) dentro do polígono
- Prompt group com nome + stats do animal no título
- "Seguir" (só dono/funcionário) → `retrieveAnimalFromPen` → spawn real na rede + deletar ped local
- Player >80m → deletar todos os peds locais daquela área

---

## Prompt na Mira (aim-based)

No prompt loop de `cl_animal_manager.lua` (~linha 920):
- `GetTargetEntity()` já existe no arquivo (~linha 551) — reusar
- Condição: `dist < Config.AnimalPromptDistance AND targetEntity == ped`
- Loop de detecção: aumentar para ~3m (pré-filtro), mira é o filtro final

---

## Status das Etapas

| # | Etapa | Status |
|---|-------|--------|
| 0 | `docs/STRATEGY.md` criado no repo | ✅ Concluido |
| 1 | Config: estrutura `Animals` placeholder | ✅ Concluido  |
| 2 | Funções de polígono em `cl_area.lua.lua` | ✅ Concluido |
| 3 | Migração DB em `InitializeDatabase` | ✅ Concluido |
| 4 | Server chores com `animalType`, sem necessidade de compatibilidade com o antigo | ✅ Concluido |
| 5 | Client chores com coords de polígono | ✅ Concluido |
| 6 | `UpdateRanchElements`: 2 prompts por tipo em `animalArea.Menu` | ✅ Concluido |
| 7 | Prompts apenas na mira via `GetTargetEntity()` | ✅ Concluido |
| 8 | Menus por tipo; menu geral = overview | ✅ Concluido |
| 9 | Animais guardados visíveis na área (client-only) | ✅ Concluido |
| 10 | NUI overview + notificações internas | ✅ Concluido |
| 11 | Remover `Coords` antigo (limpeza final) | ✅ Concluido |

---

## Proteções contra Quebras

| O que quebra | Proteção durante migração |
|-------------|--------------------------|
| `ranchChores` formato antigo | `InitializeDatabase` migra + `GetChoreValue()` suporta ambos |
| Evento `storeFollowingAnimalsRanch` | Manter evento, internamente chama nova função genérica |

---

## Como Retomar em Nova Conversa

1. Ler este arquivo (`docs/STRATEGY.md`)
2. Verificar o Status das Etapas acima
3. Ler o arquivo da próxima etapa pendente se necessário, antes de editar
4. Sempre atualizar o ✅/⬜ nesta tabela ao concluir cada etapa
