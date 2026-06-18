# General Store (RSG-Core)

Modular general store resource for **RedM / RSG-Core**. Almost everything is driven by config — no Lua changes needed for new shops, items, shelves, consumables, or notifications.

## Dependencies

| Resource        | Required |
|-----------------|----------|
| `oxmysql`       | Yes (stock persistence) |
| `rsg-core`      | Yes      |
| `rsg-inventory` | Yes      |
| `rsg-lawman`    | Optional (police robbery alerts + blip) |

Add to `server.cfg`:

```cfg
ensure rsg-core
ensure rsg-inventory
ensure rsg-lawman
ensure general_store
```

## File overview

| File | Purpose |
|------|---------|
| `config.lua` | Stores, shelves, robbery, clerk idle anims, locale strings, stock config |
| `config_consumables.lua` | Useable item scenes (prop, anim, effects, notify) |
| `server_stock.lua` | Stock engine — state, persistence, restock timer (framework-agnostic) |
| `stock_save.json` | Auto-generated — current stock snapshot for all stores (do not edit by hand) |
| `html/images/` | Store catalog PNGs (`image` field in config) |
| `itens_rsg.txt` | Copy-paste entries for `rsg-core/shared/items.lua` |

**Escrow-safe (editable):** `config.lua`, `config_consumables.lua`, `server_stock.lua`, `fxmanifest.lua`, `README.md`, `itens_rsg.txt`

## Pre-configured stores

| ID | Location |
|----|----------|
| `valentine_general` | Valentine |
| `strawberry_general` | Strawberry |
| `blackwater_general` | Blackwater |
| `rhodes_general` | Rhodes |
| `saintdenis_general` | Saint Denis |
| `armadillo_general` | Armadillo |
| `tumbleweed_general` | Tumbleweed |

Tune NPC, till, camera, and shelf coords in-game with `/coords` after first spawn.

---

## Quick start — add a new store

Copy any existing block in `Config.Stores` and change the key + coords:

```lua
['my_town_general'] = {
    label = 'General Store — My Town',
    moneyType = Config.DefaultMoneyType,
    blip = { enabled = true, name = 'General Store', sprite = Config.BlipSprite, scale = 0.2, style = 1664425300 },
    npc = {
        model = 'U_M_M_NbxGeneralStoreOwner_01',
        coords = vector4(x, y, z, heading),
    },
    cashRegister = vector4(x, y, z, heading),  -- till loot after fightback death
    cameras = {
        catalog = {
            coords  = vector3(x, y, z),
            heading = 0.0,
            pitch   = -40.85,
            fov     = 42.5,
            easeIn  = 950,
            easeOut = 700,
        },
    },
    displayCase = {
        weapon = { coords = vector3(x, y, z), rotation = { x = 90.0, y = 0.0, z = 0.0 } },
        object = { coords = vector3(x, y, z), rotation = { x = 0.0, y = 0.0, z = 0.0 } },
    },
    categories = {
        { id = 'provisions', label = 'Provisions' },
        { id = 'drinks',     label = 'Drinks' },
    },
    items = {
        -- see "Add a catalog item" below
    },
},
```

Restart `general_store` after editing config.

---

## Stock system

Each item in each store has a limited stock that depletes as players buy.  
The UI shows the amount live and blocks purchase when stock reaches zero.

### Config

```lua
Config.Stock = {
    enabled   = true,
    defaultMax = 50,         -- used for items with no explicit stock field
    lowStockThreshold = 10,  -- below this, badge turns orange ("X left")
    restock = {
        enabled         = true,
        intervalMinutes = 30,      -- how often to auto-refill
        amount          = 'full',  -- 'full' = fill to max | number = units added per cycle
    },
}
```

### Per-item stock

Add `stock = N` to any item row. If omitted the `defaultMax` is used:

```lua
{ item = 'bread',   stock = 30, price = 0.35, category = 'provisions', ... },
{ item = 'whiskey', stock = 6,  price = 2.75, category = 'drinks',     ... },
-- stock = 0 → permanently unavailable, never restocked
```

### UI badges

| State | Badge | Colour |
|-------|-------|--------|
| Normal (> threshold) | `30 in stock` | Green |
| Low (≤ threshold) | `7 left` | Orange |
| Empty | `Sold Out` + greyed card + overlay | Red |

The badge on every open store UI updates in real-time when another player buys an item.

### MySQL persistence (`general_store_stock`)

Stock is saved in a MySQL table managed by **oxmysql**.  
The table is created automatically on `ensure general_store` — no manual SQL needed.

**Schema:**

```sql
CREATE TABLE IF NOT EXISTS `general_store_stock` (
    `store_id`      VARCHAR(60) NOT NULL,
    `item_name`     VARCHAR(60) NOT NULL,
    `current_stock` INT         NOT NULL DEFAULT 0,
    `max_stock`     INT         NOT NULL DEFAULT 50,
    PRIMARY KEY (`store_id`, `item_name`)
);
```

- On first start: inserts all config items with full stock
- On restart: loads saved values, clamps to current max (safe if you changed `stock = N` in config)
- On purchase: `UPDATE` for the bought item(s)
- On restock: `UPDATE` for every item that changed

### Resetting stock manually

| Goal | SQL |
|------|-----|
| Reset ALL stores | `DELETE FROM general_store_stock;` then `ensure general_store` |
| Reset one store | `DELETE FROM general_store_stock WHERE store_id = 'valentine_general';` |
| Reset one item | `UPDATE general_store_stock SET current_stock = max_stock WHERE store_id = '...' AND item_name = '...';` |

---

## Add a catalog item

1. **Register the item** in `rsg-core/shared/items.lua` (`useable = true` if consumable). See `itens_rsg.txt`.
2. **Add PNG** to `html/images/` (e.g. `bread.png`).
3. **Add row** to the store `items` table:

```lua
{
    item     = 'bread',
    price    = 0.35,
    category = 'provisions',
    image    = 'bread.png',       -- required — filename in html/images/
    prop     = 'p_bread01x',      -- world display / shelf pickup prop
    -- optional:
    shelf    = { coords = vector3(x, y, z), heading = 100.0 },
    buyNotify = 'You grab a loaf of bread.',  -- shelf success message; omit = item label; false = silent
},
```

### Shelf pickup

- Omit `shelf` → catalog / NUI only (no world pickup).
- `prop` on the item row = prop used during shelf pickup animation and display case.
- Hold **G** at shelf (`Config.ShelfBuyKey` / `Config.OpenKey`).
- Tune DrawText height: `Config.ShelfTextZOffset` (default `0.18`).

### Catalog images

- Images live **only** in `general_store/html/images/`.
- For inventory icons, copy the same PNG to `rsg-inventory/html/images/`.

---

## Consumables (`config_consumables.lua`)

Each useable item needs a row in `Config.Consumables` **and** must exist in `RSGCore.Shared.Items` with `useable = true`.

```lua
biscuits = {
    item = 'biscuits',
    prop = 'p_biscuitsandwich01x',
    duration = 3000,
    attach = { bone = 'SKEL_L_Finger01', x = 0.04, y = -0.03, z = -0.01, rx = 0.0, ry = 19.0, rz = 46.0 },
    attachFemale = { ... },  -- optional
    native = { type = 'interaction', hash = 'EAT_...', duration = 3000, throw = true },
    anim   = { dict = '...', clip = '...', flag = 31 },  -- fallback if native fails
    effects = { hunger = 20, thirst = 0, stress = 4, alcohol = 0 },
    notify = { title = 'Eating', text = 'You eat some biscuits.', type = 'inform', duration = 3000 },
    enabled = true,  -- false to disable without removing
},
```

| Field | Role |
|-------|------|
| `prop` | Model in hand while using |
| `native` | RDR2 interaction (preferred on foot + mounted) |
| `anim` | Manual fallback |
| `effects` | HUD hunger/thirst/stress; `alcohol` uses RDR2 drunk natives |
| `notify` | Toast after scene; omit = silent |

Props by context:

| Context | Config field |
|---------|----------------|
| Shelf pickup anim | `prop` on store `items[]` row |
| Eating / drinking | `prop` in `config_consumables.lua` |
| Robbery cash stack | `Config.Robbery.moneyProp` |

---

## Notifications (`Config.Locale`)

Shelf purchase toasts are fully configurable:

```lua
Config.Locale = {
    shelf_success_title  = 'Item purchased',
    shelf_fail_title     = 'Purchase failed',
    shelf_no_money       = 'Insufficient funds.',
    -- ...
}
```

Per-item override: `buyNotify` on the store item row.

---

## Clerk robbery

Enabled via `Config.Robbery.enabled = true`.

| Flow | Description |
|------|-------------|
| **Surrender** | Aim weapon at clerk → hold → cash handover |
| **Fightback** | Roll `clerkFightChance` → clerk uses shotgun |
| **Register** | Kill fighting clerk → hold **G** at `cashRegister` |

Police alerts use `rsg-lawman:client:lawmanAlert` with store name (`%s` in `alertText` / `clerkFightAlertText`).

**LEO requirements:** `job.type == 'leo'` and `onduty == true` (vallaw, rholaw, blklaw, strlaw, stdenlaw).

Testing without duty:

```lua
alertLeoMustBeOnDuty = false,
```

Cooldown is per-store, server-enforced (`Config.Robbery.cooldown`, default 30 min).

---

## Clerk idle animations

`Config.ClerkIdleAnims` — random stoic store anims while idle. Pauses during robbery/fight.

```lua
Config.ClerkIdleAnims = {
    enabled = true,
    dict    = 'script_amb@stores@store_arms_crossed_stoic',
    clips   = { 'idle_a', 'idle_b', ... },
    minHoldDuration = 5 * 60 * 1000,
    maxHoldDuration = 10 * 60 * 1000,
    blendIn  = 2.0,
    blendOut = 2.0,
}
```

---

## Exports

**Client**

```lua
exports['general_store']:PlayConsumableScene('biscuits')
exports['general_store']:ShowTooltip('Text', 3500)
```

**Server**

```lua
exports['general_store']:RegisterConsumable('my_item', { ... })
```

---

## Troubleshooting

| Issue | Fix |
|-------|-----|
| `Config = nil` / script errors on start | Syntax error in `config.lua` — usually missing comma before `shelf` or `prop` |
| Item not in catalog | Missing `image` in `html/images/` or item not in `RSGCore.Shared.Items` |
| Consumable does nothing | Add row to `config_consumables.lua` + `useable = true` in core items |
| Shelf DrawText too low/high | Adjust `Config.ShelfTextZOffset` |
| Police no alert | Must be LEO **on duty**; toggle duty at sheriff office or set `alertLeoMustBeOnDuty = false` for tests |
| Duplicate clerk after restart | `Config.NpcRestartPurgeRadius` purges same-model NPCs near spawn |
| Stock badge not showing | Ensure `server_stock.lua` is listed **before** `server.lua` in `fxmanifest.lua` |
| Stock not persisting | Check oxmysql is running and `mysql_connection_string` is set in `server.cfg` |
| Want to reset all stocks to max | `DELETE FROM general_store_stock;` then `ensure general_store` |
| Item stuck at 0 / never restocks | Check `Config.Stock.restock.enabled = true` and `intervalMinutes` is not 0 |
| Table not created | Check F8 / server console for oxmysql errors — usually a DB connection issue |

---

## Version

`0.2.0` — Stock system (per-item limits, sold-out UI, auto-restock, JSON persistence)
