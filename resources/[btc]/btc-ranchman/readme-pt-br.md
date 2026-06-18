# btc-ranchman 2

`btc-ranchman` e um script completo de rancho para RedM. Ele permite comprar, vender, administrar e manter ranchos com animais vivos, funcionarios, caixa, tarefas, impostos, producao, reproducao, abate, lojas de animais, ataques ao rancho e integracoes opcionais com outros recursos.


## Recursos principais

- Compra, criacao, exclusao e transferencia de ranchos.
- Sistema de funcionarios com cargos e permissoes.
- Caixa do rancho para deposito, saque, impostos e protecao contra raids.
- Inventario/stash por rancho.
- Animais por curral/area: bovinos, aves, suinos, ovelhas, cabras, cavalos e animais customizados.
- Loja de animais com estoque dinamico por NPC.
- Venda de animais para NPC, com requisitos de idade, saude e fertilidade.
- Alimentacao individual e alimentacao em massa.
- Cochos por tipo de animal, capacidade e melhorias.
- Crescimento, fome, peso, saude, fertilidade, gestacao e nascimento.
- Ovos fertilizados e chocadeira para aves.
- Producao de leite, la, ovos e coleta/limpeza conforme o tipo do animal.
- Ferrete/marca do dono no animal.
- Integracao opcional com `btc-stable` para transferir/importar cavalos.
- Abatedouro configuravel com recompensas por sexo e especie.
- Sistema de raids com barra de ameaca, bandidos/lobos e perda de animais em caso de derrota.
- Webhooks globais e webhook individual por rancho.
- Compatibilidade opcional com `btc-houses`.
- Hooks abertos para economia, impostos, compra, transferencia, exclusao e animacoes.

## Dependencias

Obrigatorias:

- `btc-core`

Usadas pelo script ou recomendadas:

- `ox_lib`, se voce usar a notificacao padrao configurada em `config.lua`.
- `btc-houses`, opcional, para vincular a compra do rancho a uma propriedade.
- `btc-stable`, opcional, para integracao de cavalos.
- `btc-business`, opcional, como exemplo para receber impostos do rancho.

No `server.cfg`, garanta que as dependencias iniciem antes do recurso:

```cfg
ensure btc-core
ensure btc-ranchman
```

## Banco de dados

> **Aviso para quem usava o btc-ranchman V1:** antes de instalar e iniciar o `btc-ranchman 2`, remova da database todas as tabelas antigas do `btc-ranchman V1`. A 2 usa uma estrutura diferente de dados; se as tabelas antigas forem mantidas, o script pode iniciar com erros, dados quebrados ou comportamento incorreto.

As tabelas sao verificadas e criadas automaticamente na inicializacao:

- `btc_ranchman`: dados principais do rancho, dono, nome, dinheiro, funcionarios, tarefas, impostos, webhook, cochos e ameaca.
- `btc_ranchman_animals`: animais salvos por rancho.
- `btc_ranchman_eggs`: ovos salvos por rancho.
- `btc_ranchman_settings`: configuracoes salvas pelo painel/admin.
- `btc_ranchman_hibernating_animals`: animais ativos salvos durante desligamentos/restarts.

O script tambem adiciona colunas ausentes em `btc_ranchman` quando necessario.


## Como o jogador usa

1. Compra ou cria um rancho pelo prompt, item de documento ou integracao externa.
2. Acessa o menu do rancho no ponto `MenuLocation`.
3. Compra animais nos NPCs traders configurados em `Config.Shops`.
4. Leva os animais ate o curral do rancho e guarda no tipo correto.
5. Mantem os cuidados do rancho: estrume, feno, reparo e agua.
6. Alimenta os animais, cura, aumenta fertilidade e gerencia reproducao/producao.
7. Vende animais, abate animais ou transfere cavalos para a estrebaria quando configurado.
8. Mantem o caixa com dinheiro suficiente para impostos, melhorias e protecao.

## Cargos

Os cargos usam os labels definidos no locale:

- `0`: Novato
- `1`: Peao
- `2`: Capataz
- `3`: Patrao

O dono do rancho e tratado como grau maximo. Algumas acoes, como webhook, funcionarios, transferencia e melhorias, dependem do grau do jogador.

## Configuracoes gerais (`config/config.lua`)

### Webhook

| Configuracao | Explicacao |
| --- | --- |
| `Config.UrlIcon` | Imagem principal usada nos embeds de webhook. |
| `Config.UrlIconThumb` | Thumbnail usada nos embeds de webhook. |
| `Config.WebhookColor` | Cor decimal do embed. |
| `Config.WebhookUrl` | URL global do Discord webhook. Vazio desativa o webhook global. |

### Geral

| Configuracao | Explicacao |
| --- | --- |
| `Config.Locale` | Idioma do script. Valores existentes: `en-us` e `pt-br`. |
| `Config.MenuStyle` | `default` usa menu nativo RedM. `other` usa UI customizada do `btc-core`. |
| `Config.Debug` | Ativa logs extras no console. |
| `Config.DisableRealWeight` | Se `true`, animais podem atingir peso maximo mesmo sendo jovens. |
| `Config.UnemployedJob` | Job aplicado/removido quando o jogador deixa ou perde cargo ligado ao rancho. |
| `Config.AllowSelfResign` | Se `false`, funcionario nao consegue se demitir sozinho. |
| `Config.TaxIntervalDays` | Intervalo, em dias, entre cobrancas de imposto. |
| `Config.TaxAmount` | Valor global do imposto. Use `0` para desativar impostos globais. |
| `Config.TaxCurrencyType` | Moeda usada para imposto e caixa do rancho: `cash` ou `gold`. |

### Compatibilidade com `btc-houses`

| Configuracao | Explicacao |
| --- | --- |
| `Config.BtcHousesCompat.Enabled` | Liga/desliga a compatibilidade com `btc-houses`. |
| `RequireHouseOwnership` | Se `true`, o jogador so compra o rancho se possuir a propriedade vinculada. |
| `HidePromptIfLinked` | Se `true`, ranchos vinculados nao exibem prompt de compra do `btc-ranchman`; a compra fica pelo painel do `btc-houses`. Tambem valida donos no startup. |

### Teclas

`Config.Keys` define os inputs usados pelos prompts:

| Chave | Uso |
| --- | --- |
| `openRanch` | Abrir menu do rancho. |
| `storeAnimal` | Guardar animal no rancho/curral. |
| `openAnimalStore` | Abrir loja de animais. |
| `sellAnimal` | Vender animal para NPC. |
| `followMe` | Mandar animal seguir o jogador. |
| `feedingAnimal` | Alimentar animal. |
| `carryAnimal` | Carregar/largar animal pequeno. |
| `slaughterhouse` | Interagir com abatedouro. |

### Tarefas do rancho

`Config.Chores` controla a qualidade de manutencao por tipo de tarefa.

| Configuracao | Explicacao |
| --- | --- |
| `TickRateInMinutes` | Intervalo em minutos em que a qualidade do rancho diminui. Tambem alimenta o crescimento da ameaca das raids. |
| `poop` | Tarefa de limpar estrume. |
| `hay` | Tarefa de juntar/limpar feno. |
| `repair` | Tarefa de reparo. |
| `water` | Tarefa de agua. |

Cada tarefa pode ter:

| Campo | Explicacao |
| --- | --- |
| `increase` | Quanto a tarefa aumenta a qualidade ao ser concluida. |
| `decrease` | Quanto a qualidade cai a cada tick. |
| `time` | Duracao da animacao/tarefa em segundos ou unidade usada pela funcao correspondente. |
| `needItem` | `false` ou lista de itens necessarios. Cada item aceita `itemName`, `qnt`, `removeItem` e `degradation`. |
| `returnItem` | `false` ou lista de itens devolvidos ao finalizar. `qnt` pode ser numero ou intervalo `{ min, max }`. |

### Itens

| Configuracao | Explicacao |
| --- | --- |
| `Config.UseBrandingIron` | Ativa/desativa uso do ferrete. |
| `Config.Items.sick.item` | Item usado para curar animal. |
| `Config.Items.sick.rate` | Quanto de saude o item recupera. |
| `Config.Items.fertility.item` | Item usado para aumentar fertilidade. |
| `Config.Items.fertility.rate` | Quanto de fertilidade o item recupera. |
| `Config.Items.ranch.create` | Item usavel para criar/comprar rancho por documento. |
| `Config.Items.ranch.delete` | Item usavel para deletar rancho. |
| `Config.Items.brandingIron.item` | Item usado como ferrete. |
| `Config.Items.brandingIron.degradation` | Degradacao aplicada ao item de ferrete. |

### Venda para NPC

| Configuracao | Explicacao |
| --- | --- |
| `Config.NpcSell.enabled` | Se `false`, NPC nao compra animais. |
| `Config.NpcSell.blocked` | Lista de tipos bloqueados para venda, mesmo com venda habilitada. |

### Loja de animais

| Configuracao | Explicacao |
| --- | --- |
| `Config.AnimalsSellShop` | Quantidade de animais aleatorios no estoque de cada trader ao iniciar o servidor. |
| `Config.AllPlayersCanOpenShop` | Se `true`, qualquer jogador abre a loja. Se `false`, apenas donos/funcionarios. |
| `Config.ShopBlip` | Blip dos NPCs traders. |
| `Config.AreaBlips` | Blips dos currais por tipo de animal, visiveis para dono/funcionarios. |
| `Config.Shops` | Lista de NPCs traders e animais vendidos por local. |
| `Config.shopAnimalStatus` | Status inicial dos animais gerados na loja por tipo. |

Cada entrada em `Config.Shops` usa:

| Campo | Explicacao |
| --- | --- |
| `Name` | Nome exibido da loja/NPC. |
| `Coords` | Local e heading do NPC trader. |
| `AnimalCoords` | Local onde o animal comprado aparece/preview. |
| `Animals` | Lista de tipos vendidos nesse trader. |
| `Model` | Modelo do NPC. |
| `Outfit` | Outfit do NPC. |

### Cochos

| Configuracao | Explicacao |
| --- | --- |
| `Config.TroughUpgrades` | Custo de melhoria de cocho por tipo de animal e nivel. |
| `moneyType` | Tipo de pagamento: `cash`, `gold` ou nome de item de inventario. |
| `amount` | Valor ou quantidade necessaria para comprar a melhoria. |
| `Config.WaterProps` | Lista de props reconhecidos como cochos/agua no mundo. |

### Notificacao

A funcao `Notify(message, timer, type, source)` fica no final do `config.lua`. Por padrao ela usa `ox_lib:notify`. Troque essa funcao se o seu servidor usa outro sistema de notificacao.

## Configuracoes dos ranchos (`config/config_ranchs.lua`)

### Globais

| Configuracao | Explicacao |
| --- | --- |
| `Config.MaxRanchesPerPlayer` | Maximo de ranchos por jogador. Use `false` para nao limitar. |
| `Config.NotAllowTransferRanch` | Se `true`, bloqueia transferencia de propriedade. |
| `Config.ShowBlipEveryone` | Se `true`, todos veem blips de ranchos. Se `false`, apenas donos/funcionarios. |
| `Config.ShowBlipEveryoneCommand` | Nome do comando que mostra todos os blips temporariamente ao jogador (30s). Defina como `false` para que os blips dos ranchos disponiveis para compra fiquem **sempre** visiveis, sem precisar de comando (requer `Config.ShowBlipEveryone = true`). |
| `Config.AllowLeaveRanch` | Se `true`, funcionarios podem sair pelo menu. |
| `Config.ShowWebhookButton` | Se `true`, funcionarios com grau 3 ou mais podem ver/alterar webhook do rancho. |
| `Config.RanchBlip` | Blip usado para ranchos. |
| `Config.Npc.Model` | Modelo padrao do NPC no menu do rancho. |
| `Config.Npc.Outfit` | Outfit padrao desse NPC. |
| `Config.Stash.weight` | Peso padrao do stash do rancho. |
| `Config.Stash.slots` | Slots padrao do stash do rancho. |

### `Config.Ranchs`

Cada rancho e uma entrada numerica, onde a chave e o ID do rancho:

```lua
Config.Ranchs = {
    [1] = {
        RanchName = 'Dakota Ranch',
        Job = false,
        JobOwnerGrade = 3,
        RanchPriceMoney = 1000,
        RanchPriceGold = 1000,
        TaxAmount = 500,
        MenuLocation = vec4(-626.34, -60.96, 82.86, 65.55),
        MaxAnimals = 50,
        Stash = { weight = 1000, slots = 300 },
        Animals = {
            Cattle = {
                Menu = vec4(-621.87, -12.01, 86.65, 129.04),
                Area = {
                    vec3(-623.56, -7.51, 86.65),
                    vec3(-611.61, -0.51, 86.82),
                },
            },
        },
    },
}
```

Campos do rancho:

| Campo | Explicacao |
| --- | --- |
| `RanchName` | Nome padrao exibido no prompt/menu. |
| `Job` | Job vinculado ao rancho ou `false` para nao usar job. |
| `JobOwnerGrade` | Grau aplicado ao dono quando `Job` esta ativo. |
| `RanchPriceMoney` | Preco em dinheiro. Use `false` para nao vender por dinheiro. |
| `RanchPriceGold` | Preco em ouro. Use `false` para nao vender por ouro. |
| `TaxAmount` | Imposto especifico desse rancho. Sobrescreve `Config.TaxAmount`. |
| `MenuLocation` | Coordenada do menu/NPC do rancho. |
| `MaxAnimals` | Capacidade desse rancho quando `Config.MaxAnimalsToAll = false`. |
| `Stash.weight` | Peso do stash desse rancho. |
| `Stash.slots` | Slots do stash desse rancho. |
| `Animals` | Currais/areas disponiveis para cada tipo de animal nesse rancho. |

Campos de cada tipo em `Animals`:

| Campo | Explicacao |
| --- | --- |
| `Menu` | Local do prompt de curral/animal para esse tipo. |
| `Area` | Poligono com `vec3` que delimita a area onde animais desse tipo ficam. |
| `Prop` | Usado em aves. Se `true`, cria prop de galinheiro; se `false`, nao cria. |

Para adicionar um tipo de animal a um rancho, ele precisa existir em `Config.Animals` e tambem ter uma area propria dentro de `Config.Ranchs[id].Animals`.

## Configuracoes dos animais (`config/config_animals.lua`)

### Gerais

| Configuracao | Explicacao |
| --- | --- |
| `Config.MaxFollowingAnimals` | Maximo de animais seguindo um jogador ao mesmo tempo. |
| `Config.MaxAnimalsToAll` | Numero global de animais por rancho. Use `false` para usar `MaxAnimals` de cada rancho. |
| `Config.AnimalLifeMultiplier` | Multiplica o atributo de saude para o HP real no jogo. |
| `Config.AnimalInvincible` | Se `true`, animais fora do rancho nao morrem. |
| `Config.AnimalTickRateInMinutes` | Intervalo em que animais envelhecem, perdem fome, mudam status ou morrem. |
| `Config.AnimalPromptDistance` | Distancia para aparecer prompt de interacao no animal. |
| `Config.AnimalWanderRadius` | Raio de movimento livre do animal. Use float, como `10.0`. |
| `Config.FeedingTime` | Duracao da animacao de alimentar em milissegundos. |

### Taxas (`Config.Rate`)

| Configuracao | Explicacao |
| --- | --- |
| `notDie` | Se `true`, animais nao morrem por fome ou idade. |
| `pregnancy` | Quanto a gestacao avanca a cada tick. |
| `minFertility` | Fertilidade minima para tentar reproducao. |
| `inseminationCooldown` | Minutos ate a femea poder tentar reproducao de novo. |
| `maleBreedingCooldown` | Minutos ate o macho poder reproduzir de novo. |
| `hunger` | Quanto de fome o animal perde por tick. |
| `age` | Quanto de idade o animal ganha por tick. `0.0104` equivale a cerca de 1 ano a cada 24h reais. |
| `outsideDropMultiplier` | Multiplicador de perdas quando o animal esta fora do rancho. |
| `outsideMultiplier` | Multiplicador de ganhos quando o animal esta fora do rancho. |
| `health.healthSick` | Abaixo desse valor, animal e considerado doente e nao recupera naturalmente. |
| `health.minHungry` | Fome minima antes de perder saude. |
| `health.rate` | Taxa de ganho/perda de saude por tick. |
| `fertility.minHealth` | Saude minima antes de perder fertilidade. |
| `fertility.minHungry` | Fome minima antes de perder fertilidade. |
| `fertility.rate` | Taxa de ganho/perda de fertilidade por tick. |

### Reproducao de equinos

`Config.HorseBreedingRules` define o subtipo do filhote conforme macho e femea:

- `Horse` com `Horse` gera `Horse`.
- `Donkey` com `Horse` gera `Mule`.
- Valores com `/`, como `Horse/Donkey`, indicam chance de 50% para cada resultado.

### Estrutura de `Config.Animals`

Cada tipo de animal possui comportamento proprio. Campos comuns:

| Campo | Explicacao |
| --- | --- |
| `MaxStats.age` | Idade maxima. |
| `MaxStats.weight` | Peso maximo. |
| `MaxStats.pregnancy` | Tempo total de gestacao. |
| `TroughCapacity` | Capacidade base do cocho desse tipo. |
| `FertilAge` | Idade minima para reproducao. |
| `FertilizationChance` | Chance percentual de fecundacao. |
| `PriceConfig.BasePrice` | Preco base de compra. |
| `PriceConfig.perKg` | Valor adicional por kg. |
| `PriceConfig.SellRatio` | Percentual usado no preco de venda ao NPC. |
| `PriceConfig.SaleRequirements` | Requisitos minimos para venda: `health`, `fertility`, `age`. |
| `Food.minHungry` | Fome minima antes do animal perder peso. |
| `Food.weight` | Peso ganho ou perdido por tick. |
| `FoodItems` | Itens aceitos para alimentar esse animal. |

Cada entrada em `FoodItems` usa:

| Campo | Explicacao |
| --- | --- |
| `item` | Nome do item no inventario. |
| `amount` | Quantidade consumida. |
| `foodAmount` | Quanto de fome o animal recupera. |

### Producao por tipo

| Bloco | Usado por | Explicacao |
| --- | --- | --- |
| `Milk` | Bovinos e cabras | Permite ordenhar. Usa `item`, `itemAmount`, `cooldown` e `minChildrens`. |
| `EggLaying` | Aves e perus | Permite botar ovos, fertilizar ovos e chocar filhotes. |
| `Cleaning` | Suinos | Permite coleta/limpeza com recompensa configurada. |
| `Wool` | Ovelhas | Permite tosquia. Usa `item`, `itemAmount`, `cooldown` e `minAge`. |
| `Training` | Cavalos | Permite treinar, vender treinado e aplicar multiplicador de valor. |

### Cavalos

O bloco `Config.Animals.Horse` possui configuracoes extras:

| Campo | Explicacao |
| --- | --- |
| `MaxStats.training` | Treinamento maximo. |
| `Training.cooldown` | Minutos entre sessoes de treino. |
| `Training.increment` | Percentual ganho por treino. |
| `Training.sellMultiplier` | Multiplicador aplicado na venda quando treinamento chega a 100%. |
| `PriceConfig.HorseBasePrice` | Preco base especifico por modelo/pelagem. |
| `StableIntegration` | Se `true`, ativa integracao com `btc-stable`. |
| `BtcStableExport` | Estrebaria destino ao transferir cavalo para `btc-stable`. |
| `NotAllowedCoats` | Lista de modelos bloqueados na loja, nascimento e importacao. |

Os modelos, racas e pelagens ficam em `shared/functions.lua`, no bloco `Config.EncryptedAnimals.Horse`.

## Novos animais (`config/config_new_animals.lua`)

Este arquivo mostra o fluxo para adicionar novos tipos de animal. O exemplo incluido adiciona `Turkey`.

Checklist para novo animal:

1. Criar `Config.Animals.NomeDoAnimal`.
2. Definir `MaxStats`, `TroughCapacity`, `FertilAge`, `Food`, `FoodItems` e `PriceConfig`.
3. Escolher apenas uma logica de producao: `Milk`, `Wool`, `Cleaning`, `EggLaying` ou nenhuma.
4. Definir `Female` e `Male` com `Label`, `Spawn.Model` e `Spawn.Outfits`.
5. Adicionar area propria em `config_ranchs.lua` para cada rancho que aceita esse animal.
6. Adicionar imagens em `images/` com nomes `NomeDoAnimal_Female.png` e `NomeDoAnimal_Male.png`.
7. Se quiser abate, adicionar o animal em `config_slaughterhouse.lua`.

Novos animais nao devem seguir a logica especial de cavalos (`Training` e `StableIntegration`) e nao podem ser carregados pelo jogador.

## Abatedouro (`config/config_slaughterhouse.lua`)

| Configuracao | Explicacao |
| --- | --- |
| `Config.Slaughterhouse.Enable` | Liga/desliga o abatedouro. |
| `BlipModel` | Blip do abatedouro ou `false` para nao exibir. |
| `MaxAnimalDistace` | Distancia maxima do animal para permitir abate. |
| `Locations` | Pontos de abatedouro com label, coordenada, modelo e outfit do NPC. |
| `Slaughter` | Requisitos e recompensas por tipo de animal e sexo. |

Cada local em `Locations` usa:

| Campo | Explicacao |
| --- | --- |
| `Label` | Nome exibido. |
| `Coords` | Coordenada e heading do NPC. |
| `NpcModel` | Modelo do NPC. |
| `NpcOutfit` | Outfit do NPC. |

Cada entrada em `Slaughter` usa:

| Campo | Explicacao |
| --- | --- |
| `SlaughterRequirements.Weight` | Peso minimo. |
| `SlaughterRequirements.Health` | Saude minima. |
| `SlaughterRequirements.Fertility` | Fertilidade minima. |
| `SlaughterRequirements.Age` | Idade minima. |
| `Rewards.Items` | Lista de itens recebidos ou `false`. |
| `Rewards.Money` | Dinheiro recebido ou `false`. |

## Raids (`config/config_raids.lua`)

As raids funcionam como uma barra de ameaca. A cada tick das tarefas do rancho, a ameaca sobe. Ao chegar em 100%, se houver dono ou funcionario online, uma raid e iniciada.

| Configuracao | Explicacao |
| --- | --- |
| `Config.Raids.Enabled` | Liga/desliga raids. |
| `ThreatIncreasePerTick` | Percentual de ameaca adicionado a cada tick de tarefas. |
| `SkipIfNoAnimals` | Se `true`, ranchos sem animais nao acumulam ameaca. |
| `RaidTypes` | Tipos de raid disponiveis. |
| `AnimalDeathChanceOnLoss` | Chance percentual por animal morrer se a raid for perdida. |
| `Protection.Enabled` | Ativa pagamento para reduzir ameaca. |
| `Protection.CostPerPercent` | Custo em dinheiro do rancho por 1% reduzido. |
| `Protection.MinReduction` | Reducao minima por pagamento. |
| `Protection.MaxReduction` | Reducao maxima por pagamento. |

Cada tipo em `RaidTypes` usa:

| Campo | Explicacao |
| --- | --- |
| `name` | Nome interno/exibido do tipo. |
| `chance` | Peso relativo para sortear esse tipo. |
| `MinAttackers` | Minimo de atacantes. |
| `MaxAttackers` | Maximo de atacantes. |
| `Models` | Modelos dos atacantes. |
| `Weapons` | Armas usadas. Use `nil` para animais selvagens. |
| `SpawnRadius` | Raio de spawn a partir do `MenuLocation`. |
| `DurationSeconds` | Tempo limite para vencer a raid. |

## Funcoes abertas (`shared/open_functions.lua`)

Este arquivo foi feito para customizar comportamento sem mexer no nucleo.

| Funcao/Configuracao | Explicacao |
| --- | --- |
| `PlayerStartRanchChore(chore, ranchId)` | Hook chamado ao iniciar tarefa. |
| `PlayerFinishRanchChore(chore, ranchId)` | Hook chamado ao finalizar tarefa. |
| `CarryAnim(targetPed)` | Animacao para carregar animal. |
| `DetachAnimal(targetPed)` | Solta animal carregado. |
| `BrandingIronAnim()` | Animacao de marcar animal. |
| `BrandingIronMark(netId, animalData)` | Define nome gravado no ferrete e chama o servidor. |
| `StartMilking(netId, animalData)` | Animacao e evento de ordenha. |
| `StartWool(netId, animalData)` | Animacao e evento de tosquia. |
| `StartCleaning(netId, animalData)` | Animacao e evento de limpeza/coleta. |
| `FeedingAnim(ped, animalType)` | Animacao de alimentacao. |
| `Config.useOtherWaterLogic` | Se `true`, usa a logica customizada de agua abaixo. |
| `CheckWaterItem()` | Hook para validar item/condicao de agua customizada. |

## Hooks de impostos e economia (`server/taxes.lua`)

| Funcao/Configuracao | Explicacao |
| --- | --- |
| `GetPayedTaxes(ranchId, money)` | Chamado quando imposto e pago. Pode enviar valor para governo/banco/business. |
| `WhenBuyRanch(ranchId, playerSource)` | Hook apos compra/criacao de rancho. |
| `WhoCanBuyRanch(ranchId, playerSource)` | Retorne `false` para bloquear compra. |
| `WhenTransferRanch(ranchId, oldOwnerSource, newOwnerSource)` | Hook apos transferencia de rancho. |
| `WhoCanTransferRanch(ranchId, oldOwnerSource, newOwnerSource)` | Retorne `false` para bloquear transferencia. |
| `WhenDeleteRanch(ranchId)` | Hook apos exclusao de rancho. |
| `useOtherTaxesApply` | Se `true`, ignora a cobranca padrao e chama sua logica customizada. |
| `UseOtherTaxesApply(ranchId, ranchMoney)` | Logica customizada para imposto automatico. |
| `WhenNeedPayTaxesWithMenu(ranchId, playerSource)` | Logica customizada ao pagar imposto pelo menu. |

Para reativar um rancho por logica customizada, use:

```lua
UpdateRanchField(ranchId, 'status', 'active')
UpdateTaxDate(ranchId)
```

Para interditar:

```lua
UpdateRanchField(ranchId, 'status', 'foreclosed')
```

## Exports

Exports disponiveis no servidor:

| Export | Retorno/Uso |
| --- | --- |
| `IsRanchOwner(ranchId, citizenId)` | Retorna `true` se o `citizenId` for dono do rancho. |
| `AssignRanchOwner(src, ranchId, ranchName)` | Define dono sem cobrar pagamento, util para `btc-houses`. |
| `DeleteRanch(ranchId)` | Remove rancho do banco/cache e atualiza clientes. |
| `TransferRanchOwner(oldSrc, newSrc, ranchId, ranchName)` | Transfere propriedade para outro jogador. |
| `GetAllRanchApiData(cb)` | Retorna dados de ranchos, contagem de animais e ovos para APIs/admin. |

Exemplo:

```lua
local isOwner = exports['btc-ranchman']:IsRanchOwner(1, citizenId)
```

## Integracoes opcionais

### `btc-houses`

Quando `Config.BtcHousesCompat.Enabled = true`, o script pode exigir que o jogador seja dono da propriedade vinculada ao rancho antes de comprar. Tambem pode esconder prompts de compra de ranchos gerenciados pelo `btc-houses`.


### `btc-stable`

Quando `Config.Animals.Horse.StableIntegration = true`, cavalos podem ser transferidos para a estrebaria e importados de volta ao rancho.


### `btc-business`

Nao e obrigatorio. O arquivo `server/taxes.lua` mostra um exemplo de envio dos impostos pagos para uma administracao/governo.

## Localizacao

`Config.Locale` define qual tabela em `shared/locale.lua` sera usada:

```lua
Config.Locale = 'pt-br'
```

Idiomas existentes:

- `pt-br`
- `en-us`

Para editar textos, altere apenas os valores dentro do idioma desejado. Evite mudar os indices numericos, pois o codigo usa esses indices diretamente.

## Imagens dos animais

A UI espera imagens em `images/` seguindo o padrao:

```text
Tipo_Female.png
Tipo_Male.png
```

Exemplos:

- `Cattle_Female.png`
- `Cattle_Male.png`
- `Turkey_Female.png`
- `Turkey_Male.png`

Para novos animais, o nome antes de `_Female` ou `_Male` deve ser identico a chave usada em `Config.Animals`.

## Dicas de configuracao

- Ao criar um novo rancho, sempre defina `MenuLocation`, `MaxAnimals`, `Stash` e pelo menos um tipo em `Animals`.
- Ao adicionar um novo tipo de animal, configure tambem area no rancho, imagem na UI e, se necessario, abatedouro.
- Mantenha `AnimalTickRateInMinutes` e `Chores.TickRateInMinutes` em valores razoaveis. Valores muito baixos podem pesar o servidor.
- Se `Config.MaxAnimalsToAll` for um numero, ele sobrescreve a capacidade individual dos ranchos.
- Se `TaxAmount = 0`, impostos globais ficam desativados, mas um rancho ainda pode ter `TaxAmount` proprio maior que zero.
- Se usar `btc-houses`, inicie `btc-houses` antes ou junto do `btc-ranchman`.
- Se usar `btc-stable`, deixe `StableIntegration = true` apenas quando o recurso estiver instalado e funcional.

## Troubleshooting

**O rancho nao aparece para compra**

- Verifique se o rancho nao tem dono em `btc_ranchman`.
- Verifique `Config.BtcHousesCompat.HidePromptIfLinked`.
- Verifique se `btc-houses` esta exigindo propriedade vinculada.

**O animal nao aparece ou nao pode ser guardado**

- Confira se o tipo existe em `Config.Animals`.
- Confira se o rancho possui `Animals[Tipo]` em `config_ranchs.lua`.
- Confira se a area possui pontos `vec3` validos.
- Confira se a imagem do animal segue o nome correto.

**O jogador nao consegue comprar**

- Confira `Config.MaxRanchesPerPlayer`.
- Confira `RanchPriceMoney`, `RanchPriceGold` e saldo do jogador.
- Confira `WhoCanBuyRanch` em `server/taxes.lua`.
- Se usa job, confira se o jogador ja possui outro job e se `setPlayerJob` funciona no framework.

**Impostos nao cobram**

- Confira `Config.TaxAmount`, `Config.TaxIntervalDays` e `TaxAmount` do rancho.
- Confira se o rancho esta `active`.
- Confira se `useOtherTaxesApply` nao esta ativado sem logica implementada.

**Raids nao acontecem**

- Confira `Config.Raids.Enabled`.
- Confira se o rancho tem animais quando `SkipIfNoAnimals = true`.
- Confira se ha dono ou funcionario online quando a ameaca chega a 100%.

