# btc-ranchman 2

`btc-ranchman` is a complete ranching script for RedM. It lets players buy, sell, manage, and maintain ranches with live animals, employees, cash boxes, chores, taxes, production, breeding, slaughterhouses, animal shops, ranch raids, and optional integrations with other resources.



## Main Features

- Ranch purchase, creation, deletion, and ownership transfer.
- Employee system with grades and permissions.
- Ranch cash box for deposits, withdrawals, taxes, and raid protection.
- Per-ranch inventory/stash.
- Animals by pen/area: cattle, poultry, swine, sheep, goats, horses, and custom animals.
- Animal trader shops with dynamic NPC stock.
- NPC animal selling with age, health, and fertility requirements.
- Individual feeding and mass feeding.
- Troughs by animal type, with capacity and upgrades.
- Growth, hunger, weight, health, fertility, pregnancy, and births.
- Fertilized eggs and incubator logic for birds.
- Milk, wool, egg, and cleaning/collection production depending on animal type.
- Branding iron/owner mark system.
- Horse training.
- Optional `btc-stable` integration to transfer/import horses.
- Configurable slaughterhouse with rewards by species and sex.
- Raid system with threat bar, bandits/wolves, and animal loss on defeat.
- Global webhooks and per-ranch webhooks.
- Optional `btc-houses` compatibility.
- Open hooks for economy, taxes, purchase, transfer, deletion, and animations.

## Dependencies

Required:

- `btc-core`

Used by the script or recommended:

- `ox_lib`, if you use the default notification function configured in `config.lua`.
- `btc-houses`, optional, to link ranch purchases to properties.
- `btc-stable`, optional, for horse integration.
- `btc-business`, optional, as an example destination for ranch taxes.

In `server.cfg`, make sure the dependencies start before this resource:

```cfg
ensure btc-core
ensure btc-ranchman
```

## Database

> **Important for btc-ranchman V1 users:** before installing and starting `btc-ranchman 2`, remove all old `btc-ranchman V1` tables from your database. 2 uses a different data structure; keeping old tables can make the script start with errors, broken data, or incorrect behavior.

The tables are checked and created automatically on startup:

- `btc_ranchman`: main ranch data, owner, name, money, employees, chores, taxes, webhook, troughs, and threat level.
- `btc_ranchman_animals`: animals saved by ranch.
- `btc_ranchman_eggs`: eggs saved by ranch.
- `btc_ranchman_settings`: settings saved by the admin panel/config system.
- `btc_ranchman_hibernating_animals`: active animals saved during shutdowns/restarts.

The script also adds missing columns to `btc_ranchman` when needed.

## Player Flow

1. Buy or create a ranch through the prompt, ranch document item, or external integration.
2. Access the ranch menu at the `MenuLocation`.
3. Buy animals from NPC traders configured in `Config.Shops`.
4. Bring animals to the ranch and store them in the correct animal pen.
5. Maintain the ranch chores: manure, hay, repair, and water.
6. Feed animals, heal them, improve fertility, and manage breeding/production.
7. Sell animals, slaughter animals, or transfer horses to the stable when configured.
8. Keep enough money in the ranch cash box for taxes, upgrades, and protection.

## Grades

Grades use the labels defined in the locale:

- `0`: Newbie
- `1`: Wrangler
- `2`: Foreman
- `3`: Boss

The ranch owner is treated as the highest grade. Some actions, such as webhook management, employee management, transfers, and trough upgrades, depend on the player's grade.

## General Settings (`config/config.lua`)

### Webhook

| Setting | Explanation |
| --- | --- |
| `Config.UrlIcon` | Main image used in webhook embeds. |
| `Config.UrlIconThumb` | Thumbnail used in webhook embeds. |
| `Config.WebhookColor` | Decimal embed color. |
| `Config.WebhookUrl` | Global Discord webhook URL. Empty disables the global webhook. |

### General

| Setting | Explanation |
| --- | --- |
| `Config.Locale` | Script language. Existing values: `en-us` and `pt-br`. |
| `Config.MenuStyle` | `default` uses the native RedM menu. `other` uses the custom `btc-core` UI. |
| `Config.Debug` | Enables extra console logs. |
| `Config.DisableRealWeight` | If `true`, animals can reach max weight even while young. |
| `Config.UnemployedJob` | Job applied/used when a player leaves or loses a ranch-linked job. |
| `Config.AllowSelfResign` | If `false`, employees cannot resign by themselves. |
| `Config.TaxIntervalDays` | Interval, in days, between tax charges. |
| `Config.TaxAmount` | Global tax amount. Use `0` to disable global taxes. |
| `Config.TaxCurrencyType` | Currency used for taxes and the ranch cash box: `cash` or `gold`. |

### `btc-houses` Compatibility

| Setting | Explanation |
| --- | --- |
| `Config.BtcHousesCompat.Enabled` | Enables/disables compatibility with `btc-houses`. |
| `RequireHouseOwnership` | If `true`, the player can only buy a ranch if they own the linked property. |
| `HidePromptIfLinked` | If `true`, ranches linked to `btc-houses` do not show the `btc-ranchman` purchase prompt; purchase happens through `btc-houses`. It also validates owners on startup. |

### Keys

`Config.Keys` defines the inputs used by prompts:

| Key | Usage |
| --- | --- |
| `openRanch` | Open the ranch menu. |
| `storeAnimal` | Store an animal in the ranch/pen. |
| `openAnimalStore` | Open the animal trader shop. |
| `sellAnimal` | Sell an animal to an NPC. |
| `followMe` | Make an animal follow the player. |
| `feedingAnimal` | Feed an animal. |
| `carryAnimal` | Carry/drop a small animal. |
| `slaughterhouse` | Interact with the slaughterhouse. |

### Ranch Chores

`Config.Chores` controls maintenance quality by chore type.

| Setting | Explanation |
| --- | --- |
| `TickRateInMinutes` | Interval in minutes where ranch quality decreases. This also drives raid threat growth. |
| `poop` | Manure cleaning chore. |
| `hay` | Hay/straw cleanup chore. |
| `repair` | Repair chore. |
| `water` | Water chore. |

Each chore can have:

| Field | Explanation |
| --- | --- |
| `increase` | How much the chore increases quality when completed. |
| `decrease` | How much quality drops each tick. |
| `time` | Animation/task duration in seconds or the unit used by the related function. |
| `needItem` | `false` or a list of required items. Each item supports `itemName`, `qnt`, `removeItem`, and `degradation`. |
| `returnItem` | `false` or a list of items returned on completion. `qnt` can be a number or a `{ min, max }` range. |

### Items

| Setting | Explanation |
| --- | --- |
| `Config.UseBrandingIron` | Enables/disables the branding iron system. |
| `Config.Items.sick.item` | Item used to heal an animal. |
| `Config.Items.sick.rate` | How much health the item restores. |
| `Config.Items.fertility.item` | Item used to increase fertility. |
| `Config.Items.fertility.rate` | How much fertility the item restores. |
| `Config.Items.ranch.create` | Usable item for creating/buying a ranch by document. |
| `Config.Items.ranch.delete` | Usable item for deleting a ranch. |
| `Config.Items.brandingIron.item` | Item used as the branding iron. |
| `Config.Items.brandingIron.degradation` | Degradation applied to the branding iron item. |

### NPC Selling

| Setting | Explanation |
| --- | --- |
| `Config.NpcSell.enabled` | If `false`, NPCs do not buy animals. |
| `Config.NpcSell.blocked` | List of animal types blocked from NPC selling, even when selling is enabled. |

### Animal Shops

| Setting | Explanation |
| --- | --- |
| `Config.AnimalsSellShop` | Number of random animals stocked in each trader shop on server start. |
| `Config.AllPlayersCanOpenShop` | If `true`, any player can open the shop. If `false`, only ranch owners/employees can. |
| `Config.ShopBlip` | Blip used for animal trader NPCs. |
| `Config.AreaBlips` | Pen blips by animal type, visible to owners/employees. |
| `Config.Shops` | List of trader NPCs and animals sold by location. |
| `Config.shopAnimalStatus` | Initial stats for animals generated in the shop by type. |

Each entry in `Config.Shops` uses:

| Field | Explanation |
| --- | --- |
| `Name` | Displayed shop/NPC name. |
| `Coords` | NPC trader position and heading. |
| `AnimalCoords` | Position where purchased/previewed animals appear. |
| `Animals` | List of animal types sold by that trader. |
| `Model` | NPC model. |
| `Outfit` | NPC outfit. |

### Troughs

| Setting | Explanation |
| --- | --- |
| `Config.TroughUpgrades` | Trough upgrade cost by animal type and level. |
| `moneyType` | Payment type: `cash`, `gold`, or an inventory item name. |
| `amount` | Required value or item quantity for the upgrade. |
| `Config.WaterProps` | List of world props recognized as troughs/water. |

### Notification

The `Notify(message, timer, type, source)` function is at the end of `config.lua`. By default it uses `ox_lib:notify`. Replace this function if your server uses another notification system.

## Ranch Settings (`config/config_ranchs.lua`)

### Global

| Setting | Explanation |
| --- | --- |
| `Config.MaxRanchesPerPlayer` | Maximum number of ranches per player. Use `false` for no limit. |
| `Config.NotAllowTransferRanch` | If `true`, blocks ownership transfers. |
| `Config.ShowBlipEveryone` | If `true`, everyone sees ranch blips. If `false`, only owners/employees do. |
| `Config.ShowBlipEveryoneCommand` | Command name that temporarily shows all ranch blips to the player (30s). Set to `false` to make blips of ranches available for purchase **always** visible with no command (requires `Config.ShowBlipEveryone = true`). |
| `Config.AllowLeaveRanch` | If `true`, employees can leave through the menu. |
| `Config.ShowWebhookButton` | If `true`, employees with grade 3 or higher can view/update the ranch webhook. |
| `Config.RanchBlip` | Blip used for ranches. |
| `Config.Npc.Model` | Default NPC model for the ranch menu. |
| `Config.Npc.Outfit` | Default outfit for that NPC. |
| `Config.Stash.weight` | Default ranch stash weight. |
| `Config.Stash.slots` | Default ranch stash slots. |

### `Config.Ranchs`

Each ranch is a numeric entry where the key is the ranch ID:

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

Ranch fields:

| Field | Explanation |
| --- | --- |
| `RanchName` | Default name shown in prompts/menus. |
| `Job` | Job linked to the ranch, or `false` to not use jobs. |
| `JobOwnerGrade` | Grade applied to the owner when `Job` is enabled. |
| `RanchPriceMoney` | Cash price. Use `false` to disable cash purchase. |
| `RanchPriceGold` | Gold price. Use `false` to disable gold purchase. |
| `TaxAmount` | Ranch-specific tax. Overrides `Config.TaxAmount`. |
| `MenuLocation` | Ranch menu/NPC coordinates. |
| `MaxAnimals` | Ranch capacity when `Config.MaxAnimalsToAll = false`. |
| `Stash.weight` | Stash weight for this ranch. |
| `Stash.slots` | Stash slots for this ranch. |
| `Animals` | Pens/areas available for each animal type in this ranch. |

Fields for each type in `Animals`:

| Field | Explanation |
| --- | --- |
| `Menu` | Pen/animal prompt location for this type. |
| `Area` | `vec3` polygon that defines where animals of this type stay. |
| `Prop` | Used for poultry. If `true`, creates the coop prop; if `false`, does not. |

To add an animal type to a ranch, it must exist in `Config.Animals` and must also have its own area inside `Config.Ranchs[id].Animals`.

## Animal Settings (`config/config_animals.lua`)

### General

| Setting | Explanation |
| --- | --- |
| `Config.MaxFollowingAnimals` | Maximum animals that can follow a player at the same time. |
| `Config.MaxAnimalsToAll` | Global animal limit per ranch. Use `false` to use each ranch's `MaxAnimals`. |
| `Config.AnimalLifeMultiplier` | Multiplies the health attribute into actual in-game HP. |
| `Config.AnimalInvincible` | If `true`, animals outside the ranch do not die. |
| `Config.AnimalTickRateInMinutes` | Interval where animals age, lose hunger, change status, or die. |
| `Config.AnimalPromptDistance` | Distance for animal interaction prompts to appear. |
| `Config.AnimalWanderRadius` | Free-roam radius for animals. Use a float, such as `10.0`. |
| `Config.FeedingTime` | Feeding animation duration in milliseconds. |

### Rates (`Config.Rate`)

| Setting | Explanation |
| --- | --- |
| `notDie` | If `true`, animals do not die from hunger or age. |
| `pregnancy` | How much pregnancy progresses each tick. |
| `minFertility` | Minimum fertility required to attempt breeding. |
| `inseminationCooldown` | Minutes until the female can attempt breeding again. |
| `maleBreedingCooldown` | Minutes until the male can breed again. |
| `hunger` | How much hunger the animal loses per tick. |
| `age` | How much age the animal gains per tick. `0.0104` is about 1 year every 24 real hours. |
| `outsideDropMultiplier` | Multiplier for losses when the animal is outside the ranch. |
| `outsideMultiplier` | Multiplier for gains when the animal is outside the ranch. |
| `health.healthSick` | Below this value, the animal is considered sick and does not recover naturally. |
| `health.minHungry` | Minimum hunger before the animal starts losing health. |
| `health.rate` | Health gain/loss rate per tick. |
| `fertility.minHealth` | Minimum health before the animal starts losing fertility. |
| `fertility.minHungry` | Minimum hunger before the animal starts losing fertility. |
| `fertility.rate` | Fertility gain/loss rate per tick. |

### Equine Breeding

`Config.HorseBreedingRules` defines the offspring subtype based on the male and female:

- `Horse` with `Horse` produces `Horse`.
- `Donkey` with `Horse` produces `Mule`.
- Values with `/`, such as `Horse/Donkey`, mean a 50% chance for each result.

### `Config.Animals` Structure

Each animal type has its own behavior. Common fields:

| Field | Explanation |
| --- | --- |
| `MaxStats.age` | Maximum age. |
| `MaxStats.weight` | Maximum weight. |
| `MaxStats.pregnancy` | Total pregnancy duration. |
| `TroughCapacity` | Base trough capacity for this type. |
| `FertilAge` | Minimum breeding age. |
| `FertilizationChance` | Fertilization chance percentage. |
| `PriceConfig.BasePrice` | Base purchase price. |
| `PriceConfig.perKg` | Additional value per kg. |
| `PriceConfig.SellRatio` | Percentage used for NPC sale price. |
| `PriceConfig.SaleRequirements` | Minimum sale requirements: `health`, `fertility`, `age`. |
| `Food.minHungry` | Minimum hunger before the animal loses weight. |
| `Food.weight` | Weight gained or lost per tick. |
| `FoodItems` | Items accepted for feeding this animal. |

Each `FoodItems` entry uses:

| Field | Explanation |
| --- | --- |
| `item` | Inventory item name. |
| `amount` | Quantity consumed. |
| `foodAmount` | How much hunger the animal restores. |

### Production by Type

| Block | Used by | Explanation |
| --- | --- | --- |
| `Milk` | Cattle and goats | Enables milking. Uses `item`, `itemAmount`, `cooldown`, and `minChildrens`. |
| `EggLaying` | Poultry and turkeys | Enables egg laying, egg fertilization, and hatching. |
| `Cleaning` | Swine | Enables cleaning/collection with configured rewards. |
| `Wool` | Sheep | Enables shearing. Uses `item`, `itemAmount`, `cooldown`, and `minAge`. |
| `Training` | Horses | Enables training, trained-horse sale, and value multiplier. |

### Horses

The `Config.Animals.Horse` block has extra settings:

| Field | Explanation |
| --- | --- |
| `MaxStats.training` | Maximum training. |
| `Training.cooldown` | Minutes between training sessions. |
| `Training.increment` | Percentage gained per training session. |
| `Training.sellMultiplier` | Multiplier applied on sale when training reaches 100%. |
| `PriceConfig.HorseBasePrice` | Specific base price by horse model/coat. |
| `StableIntegration` | If `true`, enables `btc-stable` integration. |
| `BtcStableExport` | Destination stable when transferring a horse to `btc-stable`. |
| `NotAllowedCoats` | List of models blocked from shop, birth, and import. |

Models, breeds, and coats are in `shared/functions.lua`, inside `Config.EncryptedAnimals.Horse`.

## New Animals (`config/config_new_animals.lua`)

This file shows the flow for adding new animal types. The included example adds `Turkey`.

Checklist for a new animal:

1. Create `Config.Animals.AnimalName`.
2. Define `MaxStats`, `TroughCapacity`, `FertilAge`, `Food`, `FoodItems`, and `PriceConfig`.
3. Choose only one production logic: `Milk`, `Wool`, `Cleaning`, `EggLaying`, or none.
4. Define `Female` and `Male` with `Label`, `Spawn.Model`, and `Spawn.Outfits`.
5. Add its own area in `config_ranchs.lua` for each ranch that accepts this animal.
6. Add images in `images/` named `AnimalName_Female.png` and `AnimalName_Male.png`.
7. If you want slaughter support, add the animal to `config_slaughterhouse.lua`.

New animals should not use the special horse logic (`Training` and `StableIntegration`) and cannot be carried by the player.

## Slaughterhouse (`config/config_slaughterhouse.lua`)

| Setting | Explanation |
| --- | --- |
| `Config.Slaughterhouse.Enable` | Enables/disables the slaughterhouse. |
| `BlipModel` | Slaughterhouse blip or `false` to hide it. |
| `MaxAnimalDistace` | Maximum animal distance allowed for slaughter. |
| `Locations` | Slaughterhouse points with label, coordinates, NPC model, and outfit. |
| `Slaughter` | Requirements and rewards by animal type and sex. |

Each location in `Locations` uses:

| Field | Explanation |
| --- | --- |
| `Label` | Displayed name. |
| `Coords` | NPC coordinates and heading. |
| `NpcModel` | NPC model. |
| `NpcOutfit` | NPC outfit. |

Each entry in `Slaughter` uses:

| Field | Explanation |
| --- | --- |
| `SlaughterRequirements.Weight` | Minimum weight. |
| `SlaughterRequirements.Health` | Minimum health. |
| `SlaughterRequirements.Fertility` | Minimum fertility. |
| `SlaughterRequirements.Age` | Minimum age. |
| `Rewards.Items` | List of received items or `false`. |
| `Rewards.Money` | Received money or `false`. |

## Raids (`config/config_raids.lua`)

Raids work like a threat bar. Each ranch chore tick increases threat. When it reaches 100%, if at least one owner or employee is online, a raid starts.

| Setting | Explanation |
| --- | --- |
| `Config.Raids.Enabled` | Enables/disables raids. |
| `ThreatIncreasePerTick` | Threat percentage added each chore tick. |
| `SkipIfNoAnimals` | If `true`, ranches with no animals do not gain threat. |
| `RaidTypes` | Available raid types. |
| `AnimalDeathChanceOnLoss` | Percentage chance per animal to die if the raid is lost. |
| `Protection.Enabled` | Enables payment to reduce threat. |
| `Protection.CostPerPercent` | Ranch cash cost per 1% threat reduction. |
| `Protection.MinReduction` | Minimum reduction per payment. |
| `Protection.MaxReduction` | Maximum reduction per payment. |

Each type in `RaidTypes` uses:

| Field | Explanation |
| --- | --- |
| `name` | Internal/displayed type name. |
| `chance` | Relative weight used when choosing this raid type. |
| `MinAttackers` | Minimum attackers. |
| `MaxAttackers` | Maximum attackers. |
| `Models` | Attacker models. |
| `Weapons` | Weapons used. Use `nil` for wild animals. |
| `SpawnRadius` | Spawn radius from `MenuLocation`. |
| `DurationSeconds` | Time limit to win the raid. |

## Open Functions (`shared/open_functions.lua`)

This file exists so you can customize behavior without changing the core logic.

| Function/Setting | Explanation |
| --- | --- |
| `disableMenuOptions.inventory` | Disables the inventory menu option. |
| `disableMenuOptions.managementCash` | Disables cash management. |
| `disableMenuOptions.managementEmployees` | Disables employee management. |
| `PlayerStartRanchChore(chore, ranchId)` | Hook called when starting a chore. |
| `PlayerFinishRanchChore(chore, ranchId)` | Hook called when finishing a chore. |
| `CarryAnim(targetPed)` | Animation for carrying an animal. |
| `DetachAnimal(targetPed)` | Drops the carried animal. |
| `BrandingIronAnim()` | Animal branding animation. |
| `BrandingIronMark(netId, animalData)` | Defines the branded name and calls the server. |
| `StartMilking(netId, animalData)` | Milking animation and event. |
| `StartWool(netId, animalData)` | Shearing animation and event. |
| `StartCleaning(netId, animalData)` | Cleaning/collection animation and event. |
| `FeedingAnim(ped, animalType)` | Feeding animation. |
| `Config.useOtherWaterLogic` | If `true`, uses the custom water logic below. |
| `CheckWaterItem()` | Hook to validate a custom water item/condition. |

## Tax and Economy Hooks (`server/taxes.lua`)

| Function/Setting | Explanation |
| --- | --- |
| `GetPayedTaxes(ranchId, money)` | Called when a tax is paid. Can send the value to government/bank/business logic. |
| `WhenBuyRanch(ranchId, playerSource)` | Hook after ranch purchase/creation. |
| `WhoCanBuyRanch(ranchId, playerSource)` | Return `false` to block purchase. |
| `WhenTransferRanch(ranchId, oldOwnerSource, newOwnerSource)` | Hook after ranch transfer. |
| `WhoCanTransferRanch(ranchId, oldOwnerSource, newOwnerSource)` | Return `false` to block transfer. |
| `WhenDeleteRanch(ranchId)` | Hook after ranch deletion. |
| `useOtherTaxesApply` | If `true`, ignores the default tax charge and calls your custom logic. |
| `UseOtherTaxesApply(ranchId, ranchMoney)` | Custom automatic tax logic. |
| `WhenNeedPayTaxesWithMenu(ranchId, playerSource)` | Custom tax payment logic from the menu. |

To reactivate a ranch through custom logic, use:

```lua
UpdateRanchField(ranchId, 'status', 'active')
UpdateTaxDate(ranchId)
```

To foreclose it:

```lua
UpdateRanchField(ranchId, 'status', 'foreclosed')
```

## Exports

Server exports:

| Export | Return/Usage |
| --- | --- |
| `IsRanchOwner(ranchId, citizenId)` | Returns `true` if the `citizenId` owns the ranch. |
| `AssignRanchOwner(src, ranchId, ranchName)` | Assigns an owner without charging payment, useful for `btc-houses`. |
| `DeleteRanch(ranchId)` | Removes the ranch from database/cache and updates clients. |
| `TransferRanchOwner(oldSrc, newSrc, ranchId, ranchName)` | Transfers ownership to another player. |
| `GetAllRanchApiData(cb)` | Returns ranch data, animal counts, and eggs for APIs/admin tools. |

Example:

```lua
local isOwner = exports['btc-ranchman']:IsRanchOwner(1, citizenId)
```

## Optional Integrations

### `btc-houses`

When `Config.BtcHousesCompat.Enabled = true`, the script can require the player to own the property linked to the ranch before buying it. It can also hide purchase prompts for ranches managed by `btc-houses`.


### `btc-stable`

When `Config.Animals.Horse.StableIntegration = true`, horses can be transferred to the stable and imported back into the ranch.


### `btc-business`

Not required. `server/taxes.lua` shows an example of sending paid taxes to an administration/government account.

## Localization

`Config.Locale` defines which table in `shared/locale.lua` will be used:

```lua
Config.Locale = 'pt-br'
```

Existing languages:

- `pt-br`
- `en-us`

To edit text, change only the values inside the desired language. Avoid changing numeric indexes, because the code uses those indexes directly.

## Animal Images

The UI expects images in `images/` following this pattern:

```text
Type_Female.png
Type_Male.png
```

Examples:

- `Cattle_Female.png`
- `Cattle_Male.png`
- `Turkey_Female.png`
- `Turkey_Male.png`

For new animals, the name before `_Female` or `_Male` must be identical to the key used in `Config.Animals`.

## Configuration Tips

- When creating a new ranch, always define `MenuLocation`, `MaxAnimals`, `Stash`, and at least one type in `Animals`.
- When adding a new animal type, also configure a ranch area, UI image, and slaughterhouse support if needed.
- Keep `AnimalTickRateInMinutes` and `Chores.TickRateInMinutes` at reasonable values. Very low values can hurt server performance.
- If `Config.MaxAnimalsToAll` is a number, it overrides individual ranch capacities.
- If `TaxAmount = 0`, global taxes are disabled, but a ranch can still have its own `TaxAmount` greater than zero.
- If you use `btc-houses`, start `btc-houses` before or together with `btc-ranchman`.
- If you use `btc-stable`, keep `StableIntegration = true` only when the resource is installed and working.

## Troubleshooting

**The ranch does not appear for purchase**

- Check that the ranch does not already have an owner in `btc_ranchman`.
- Check `Config.BtcHousesCompat.HidePromptIfLinked`.
- Check whether `btc-houses` requires ownership of the linked property.

**The animal does not appear or cannot be stored**

- Confirm that the type exists in `Config.Animals`.
- Confirm that the ranch has `Animals[Type]` in `config_ranchs.lua`.
- Confirm that the area has valid `vec3` points.
- Confirm that the animal image follows the correct name.

**The player cannot buy**

- Check `Config.MaxRanchesPerPlayer`.
- Check `RanchPriceMoney`, `RanchPriceGold`, and the player's balance.
- Check `WhoCanBuyRanch` in `server/taxes.lua`.
- If using jobs, check whether the player already has another job and whether `setPlayerJob` works in your framework.

**Taxes are not being charged**

- Check `Config.TaxAmount`, `Config.TaxIntervalDays`, and the ranch `TaxAmount`.
- Check whether the ranch status is `active`.
- Check that `useOtherTaxesApply` is not enabled without implemented logic.

**Raids are not happening**

- Check `Config.Raids.Enabled`.
- Check whether the ranch has animals when `SkipIfNoAnimals = true`.
- Check whether an owner or employee is online when threat reaches 100%.

