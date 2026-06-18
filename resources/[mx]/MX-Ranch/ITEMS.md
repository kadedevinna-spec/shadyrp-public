# MX-Ranch — Items

Register every item below in your inventory. Names must match **config.lua** (`Config.Items` and `Config.AnimalSell.ItemRewards`). After edits: `ensure MX-Ranch`.

## Config.Items mapping

| Config key | Item name | Used for |
|------------|-----------|----------|
| `vaccine` | `vacine` | Consumed when vaccinating a sick animal |
| `hay` | `hay` | Consumed (1×) when filling a food trough |
| `water_refill` | `water` | Consumed (1×) when filling a water trough |
| `milk` | `milk` | Given after cow milk collection |
| `goat_milk` | `milk` | Given after goat milk collection (same item as cow) |
| `egg` | `eggs` | Given after chicken egg collection |
| `wool` | `wool` | Given after sheep shearing |
| `rake` | `ranch_rake` | Required in inventory to clean manure |
| `manure` | `ranch_manure` | Given when cleaning manure |

## Livestock market (sell rewards)

When `Config.AnimalSell.ItemRewards.Enabled = true`: `meat`, `leather`, `feather` (per species in config.lua).

---

## VORP — SQL inserts

Run once on your MySQL database. Add images to `vorp_inventory/html/img/items/` (e.g. `hay.png`, `vacine.png`).

```sql
INSERT INTO `items` (`item`, `label`, `limit`, `can_remove`, `type`, `usable`, `desc`, `weight`) VALUES
('vacine', 'Animal Vaccine', 10, 1, 'item_standard', 1, 'Treats sick ranch animals.', 0.15),
('hay', 'Hay', 50, 1, 'item_standard', 0, 'Feed for ranch food troughs.', 0.50),
('water', 'Water Bucket', 20, 1, 'item_standard', 0, 'Refills ranch water troughs.', 1.00),
('milk', 'Milk', 30, 1, 'item_standard', 0, 'Fresh milk from cows or goats.', 0.40),
('eggs', 'Eggs', 30, 1, 'item_standard', 0, 'Eggs collected from chickens.', 0.10),
('wool', 'Wool', 30, 1, 'item_standard', 0, 'Wool sheared from sheep.', 0.35),
('ranch_rake', 'Ranch Rake', 1, 1, 'item_standard', 0, 'Clean manure in the ranch.', 1.20),
('ranch_manure', 'Manure', 50, 1, 'item_standard', 0, 'Collected from cleaning the ranch.', 0.60),
('meat', 'Raw Meat', 50, 1, 'item_standard', 0, 'Butchered at the livestock market.', 0.45),
('leather', 'Leather', 50, 1, 'item_standard', 0, 'Hide from livestock sales.', 0.30),
('feather', 'Feathers', 50, 1, 'item_standard', 0, 'Feathers from sold chickens.', 0.05);
```

---

## RSG — shared/items.lua

Copy into `rsg-core/shared/items.lua` inside the main items table. Add images to your inventory (e.g. `rsg-inventory/html/images/`).

```lua
['vacine'] = {
    name = 'vacine',
    label = 'Animal Vaccine',
    weight = 150,
    type = 'item',
    image = 'vacine.png',
    unique = false,
    useable = true,
    shouldClose = true,
    description = 'Treats sick ranch animals.',
},
['hay'] = {
    name = 'hay',
    label = 'Hay',
    weight = 200,
    type = 'item',
    image = 'hay.png',
    unique = false,
    useable = false,
    shouldClose = true,
    description = 'Feed for ranch food troughs.',
},
['water'] = {
    name = 'water',
    label = 'Water Bucket',
    weight = 500,
    type = 'item',
    image = 'water.png',
    unique = false,
    useable = false,
    shouldClose = true,
    description = 'Refills ranch water troughs.',
},
['milk'] = {
    name = 'milk',
    label = 'Milk',
    weight = 400,
    type = 'item',
    image = 'milk.png',
    unique = false,
    useable = false,
    shouldClose = true,
    description = 'Fresh milk from cows or goats.',
},
['eggs'] = {
    name = 'eggs',
    label = 'Eggs',
    weight = 100,
    type = 'item',
    image = 'eggs.png',
    unique = false,
    useable = false,
    shouldClose = true,
    description = 'Eggs collected from chickens.',
},
['wool'] = {
    name = 'wool',
    label = 'Wool',
    weight = 350,
    type = 'item',
    image = 'wool.png',
    unique = false,
    useable = false,
    shouldClose = true,
    description = 'Wool sheared from sheep.',
},
['ranch_rake'] = {
    name = 'ranch_rake',
    label = 'Ranch Rake',
    weight = 1200,
    type = 'item',
    image = 'ranch_rake.png',
    unique = false,
    useable = false,
    shouldClose = true,
    description = 'Clean manure in the ranch.',
},
['ranch_manure'] = {
    name = 'ranch_manure',
    label = 'Manure',
    weight = 600,
    type = 'item',
    image = 'ranch_manure.png',
    unique = false,
    useable = false,
    shouldClose = true,
    description = 'Collected from cleaning the ranch.',
},
['meat'] = {
    name = 'meat',
    label = 'Raw Meat',
    weight = 450,
    type = 'item',
    image = 'meat.png',
    unique = false,
    useable = false,
    shouldClose = true,
    description = 'Butchered at the livestock market.',
},
['leather'] = {
    name = 'leather',
    label = 'Leather',
    weight = 300,
    type = 'item',
    image = 'leather.png',
    unique = false,
    useable = false,
    shouldClose = true,
    description = 'Hide from livestock sales.',
},
['feather'] = {
    name = 'feather',
    label = 'Feathers',
    weight = 50,
    type = 'item',
    image = 'feather.png',
    unique = false,
    useable = false,
    shouldClose = true,
    description = 'Feathers from sold chickens.',
},
```

---

## Image files (both frameworks)

| Item | Image file |
|------|------------|
| vacine | vacine.png |
| hay | hay.png |
| water | water.png |
| milk | milk.png |
| eggs | eggs.png |
| wool | wool.png |
| ranch_rake | ranch_rake.png |
| ranch_manure | ranch_manure.png |
| meat | meat.png |
| leather | leather.png |
| feather | feather.png |

If you rename items in `config.lua`, change the SQL/RSG `name` and `item` fields to match.

---

MX-SCRIPTS
