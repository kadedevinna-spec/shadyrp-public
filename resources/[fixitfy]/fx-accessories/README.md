# FX-Accessories

A RedM prop attachment system for VORP, RSG, and custom frameworks.  
Ships with **109 built-in animations**, **43 pre-configured items**, two player-facing menus, an in-game admin calibration panel, and a fully featured **in-world accessory store system**.

> **Last updated:** 2026-05-24

> **Supported Languages:** English (`en`) · Turkish (`tr`) · German (`de`)  
> Set your language in `config.lua` → `Config.Locale`

---

## Requirements

- RedM server with `cerulean` fx_version
- `lua54` enabled
- `/assetpacks` dependency

---

## Framework Support

- **VORP** — auto-detected via `vorp_core`
- **RSG** — auto-detected via `rsg-core`
- **None** — fallback, no inventory check

To add a custom framework, use the template at the bottom of `frameworks.lua`.

---

## Installation

1. Drop the resource folder into your server resources directory.
2. Add to `server.cfg` after your framework:

**VORP**
```cfg
ensure vorp_core
ensure vorp_inventory
ensure fx-accessories
```

**RSG**
```cfg
ensure rsg-core
ensure fx-accessories
```

3. Register items (see [Item Registration](#item-registration)).

---

## Commands

### Player

- `/objects` **(Default: F4)** — Opens the prop browser to equip accessories
- `/accmenu` — Opens the equipped accessories radial menu

Commands are configurable via `Config.OpenMenuCommands` in `config.lua`.

### Admin

- `/giveadminpanel <serverid>` *(In-game, ACE-gated)* — Opens the calibration panel for the target player
- `fxaccmenu <serverid>` *(Server console / RCON)* — Opens the calibration panel for the target player

To grant permanent self-access to non-admin staff, assign the ACE permission defined in `Config.AllowedAccAdmin` (default: `"acceditor"`).  
Players with this permission can open the panel themselves from the in-game radial menu.

---

## Configuration

General settings live in `config.lua`. Item definitions and attachment limits live in `config_items.lua`.

### Key Binding

```lua
Config.OpenMenuKey = {
    useKey = true,
    key    = 115, -- F4 | Full key list: https://cherrytree.at/misc/vk.htm
}

Config.MenuOpenMode = "both"  -- "keybind" | "command" | "both"
Config.MenuToggle   = true    -- true: key toggles open/close | false: key only opens
```

### Limits

> These settings are in `config_items.lua`.

- `Config.MaxAttachedLimit` — default `10` — max accessories per player
- `Config.CategoryLimits` — default `{}` — per-category cap, e.g. `{ Head = 1 }`
- `Config.RequireItem` — default `false` — require inventory ownership to equip

> When `RequireItem = true`, the server validates inventory every **6 seconds** and removes any item the player no longer owns.

### Animation Behaviour

- `Config.AnimationSetting` — default `"auto"` — `"auto"` = hold or play-once per item · `"forceStop"` = always stop after delay · `"disable"` = no animation
- `Config.AnimationDelay` — default `2000` ms — time before stopping the animation (`auto` and `forceStop`)

### UI & Visual

- `Config.AttachedCamFov` — default `0` — camera zoom on radial menu open (0–12, lower = closer)
- `Config.AttachedMenuOpenDelayMs` — default `170` ms — delay before radial menu appears after camera focus
- `Config.AccadminDenyMs` — default `2000` ms — how long the permission-denied subtitle shows
- `Config.UIAnimation.HoldDetachMs` — default `650` ms — hold duration to detach an item via the radial menu

`Config.UIAnimation` also controls radial node reveal style, speed, stagger, and distance. See `config.lua` for the full block.

### Night Menu Light

A point light placed above the player while the accessory menu is open, making it easier to see item previews at night.

```lua
Config.NightMenuLight = {
    Enabled   = true,
    Time      = { AlwaysOn = false, StartHour = 20.17, EndHour = 6 },
    Direction = { Mode = "top_down" },  -- "top_down" | "side_right" | "bottom_up" | "custom"
    Visual    = { ColorHex = "#d4e8ff", Range = 2.5, Intensity = 5.0 }
}
```

### Calibration Prop Outline

While the calibration panel is open, the target prop gets an orange draw-outline and a small point light so it stays visible during positioning.

```lua
Config.CalibOutline = {
    Enabled = true,
    Light   = { Enabled = true, ColorHex = "#d4e8ff", Range = 0.40, Intensity = 8.0 }
}
```

### Admin Panel Access

- `Config.AccadminAdminOnly` — default `true` — `true` = txAdmin only · `false` = use `AllowedAccAdmin` role
- `Config.AllowedAccAdmin` — default `"acceditor"` — ACE permission or framework group for panel access

---

## Player Menus

### Radial Menu (`/accmenu`)

Shows all currently equipped accessories grouped by body region.

- **Replay equip animation** — tap an item chip
- **Detach item** — hold an item chip (`HoldDetachMs`)
- **Rotate character preview** — Rotate button (centre)
- **Dress / Undress** — Toggle button — hides or restores all props without removing them
- **Open prop browser** — Objects button
- **Open admin panel** — Accadmin button (if permitted)

### Prop Browser (`/objects`)

Searchable browser filtered by gender and body category. Supports keyboard navigation (↑ ↓ Enter).

---

## Calibration Panel

The in-game calibration panel lets you build and position props visually in real-time without editing any files.

### Step 1 — Setup

- **Item Key** — unique identifier used in `config_items.lua`
- **Label** — display name shown in the player menu
- **Model** — pick from the live model browser
- **Gender** — `all` · `male` · `female`
- **Category** — `Head` · `Neck` · `Hand` · `Torso` · `Arm` · `Belt` · `Leg`
- **Animation** — equip animation (optional, picked from categorised list)
- **fixedRot** — world-fixed rotation vs. bone-relative
- **Calibrate As** — switch between male / female ped for this calibration session

Click **Import** to pre-fill all fields from an existing `config_items.lua` entry.

### Step 2 — Bone

Browse bones by body region (Head, Neck, Torso, Arms, Fingers, Waist) or search by name.  
The active region dot highlights which area has a selected bone.

### Step 3 — Calibration

Adjust position and rotation with live prop preview. Changes apply in real-time on the character.

**Keyboard shortcuts:**

- `↑ ↓ ← →` — move prop forward · back · left · right
- `Q` / `Z` — move prop up / down
- `C` / `V` — cycle active rotation axis (Pitch → Roll → Yaw)
- `B` — toggle active axis
- `W A S D` — camera movement
- `Space` / `Shift` — camera up / down

**Animation Control** (shown when the item has an animation):

- **Play / Pause** — start or pause the animation
- **Stop** — reset animation to the beginning
- **Frame step** — step one frame forward or backward
- **Scrub bar** — jump to any point in the animation timeline
- **Add Delay** — sets `AttachDelay` so the prop appears at the right moment mid-animation

### Step 4 — Output

Shows a summary card and a ready-to-paste `config_items.lua` entry.

- **Save** — saves the item to `reload_items.json` for later (see [Draft Storage](#draft-storage--reload_itemsjson))
- **Copy** — copies the config entry to clipboard
- **Item Registration** — opens Step 5 to generate framework registration code
- **+ New Item** — resets the wizard for a new item

### Step 5 — Item Registration

Generates the registration block for your inventory framework:

- **VORP SQL** — ready-to-run `INSERT` statement for your database
- **RSG Lua** — paste-ready entry for the RSG shared items file

---

## Item Definition

Items are defined in `config_items.lua`.

```lua
["itemkey"] = {
    Label         = "Display Name",
    Gender        = "all",           -- "all" | "male" | "female"
    Category      = "Hand",          -- Head | Neck | Arm | Hand | Torso | Belt | Leg
    Model         = `model_hash`,
    Anim          = "hold_pose",     -- optional; equip animation key
    AttachDelay   = 0.0,          -- optional; seconds before prop appears after animation starts
    AnimCut       = 1.2,          -- optional; stops the equip animation at this timestamp (seconds)
    AnimBlacklist = {           -- optional; hide prop while these animations are playing
        { "clipset_name", "anim_name" },
    },
    Attach   = {
        Male   = { BoneID = 24818, BoneName = "skel_r_hand", PX = 0.0, PY = 0.0, PZ = 0.0, Pitch = 0.0, Roll = 0.0, Yaw = 0.0, fixedRot = true },
        Female = { BoneID = 24818, BoneName = "skel_r_hand", PX = 0.0, PY = 0.0, PZ = 0.0, Pitch = 0.0, Roll = 0.0, Yaw = 0.0, fixedRot = true },
    }
},
```

`BoneName` is optional but aids the calibration panel's bone display. Bone IDs are in `libs/Male-Bones.md` and `libs/Female-Bones.md`.

Per-gender `Anim` override: add `Anim = "key"` inside a `Male` or `Female` attach block to use a different animation per gender.

---

## Draft Storage — `reload_items.json`

The calibration panel can save work-in-progress items so calibration data is not lost between sessions.

**Workflow:**
1. Calibrate your item (steps 1 → 3).
2. On the Output page, click **Save** — the item is written to `reload_items.json`.
3. Next session: open Import → **Saved** tab → click **Reload** to fetch the latest save from disk.
4. Select an item from the list, then **Load** to restore all fields and resume.
5. When done, copy the generated entry into `config_items.lua`. That is the permanent save.

> `reload_items.json` stores **one item at a time**. Every save overwrites the previous draft.  
> This file is not read by the game as a live accessory — it only feeds the admin panel's save/load feature.

**Saved tab controls:**

- **Reload** — re-reads `reload_items.json` from disk and refreshes the list
- **Copy** (per row) — copies the Lua config entry for that item to clipboard
- **Click a row** — selects the item; enables the Load button

---

## Notification Customization

By default the resource uses `fx-hud` (if running), the framework notification system, or chat as a fallback.

To override with your own handler, add this to `frameworks.lua` on the **client** side:

```lua
FX.SetNotifyHandler(function(text)
    TriggerEvent("my-hud:showNotify", text)
end)

-- Optional: change duration and type
FX.NotifyPrefs.time = 4000
FX.NotifyPrefs.type = "success"  -- "info" | "success" | "error"
```

---

## Item Registration

- **VORP** — import `fx_accessories.sql` (Section 1) into your database. Safe to re-run (`ON DUPLICATE KEY UPDATE`).
- **RSG** — use Section 2 from `fx_accessories.sql` and paste the Lua entries into your RSG shared items file.

The calibration panel's **Step 5 — Item Registration** can generate these blocks for any item automatically.

---

## Accessory Store System

The store system adds in-world accessory shops where players can browse, preview, and purchase accessories using cash or gold. Each store is fully self-contained and configured in `config_shops.lua`.

### How It Works

1. A client streaming thread checks player distance every 2 seconds.
2. When in range, the shop ped (and optional decoration wagon) spawns near the store coordinates.
3. A hold-prompt or `ox_target` interaction appears on the ped.
4. On interact, the server validates the player (job restriction, open hours, balance) and returns the item list.
5. The shop UI opens with the item catalogue, live balance, and a 3-D prop preview camera.
6. The player builds a cart and confirms the purchase — the server re-validates price and item name against `config_shops.lua` (NUI manipulation proof), deducts money, and adds the item to inventory.
7. The displayed balance refreshes automatically after each purchase without reopening the shop.

### Interaction Modes

- **Native hold-prompt** (RDR2 built-in) — set `useTarget = false` in `info`
- **`ox_target`** entity zone on ped — set `useTarget = true` (requires `ox_target` resource)

### Shop Panel Features

- **Category tabs** — filter items by body region: Neck, Hand, Head, Arm, Torso, Belt, Leg
- **Gender filter** — All · Male · Female toggle
- **Favourites tab** — star any item to pin it to a personal favourites list
- **Shopping cart** — add multiple items and buy them in one go
- **Live balance** — cash and gold shown and updated instantly after each purchase
- **3-D item preview** — spawns the accessory prop at `preview.coords` with a dedicated cinematic camera
- **Search bar** — text filter across all item labels

### Preview Camera Controls (in-shop)

- **Left-drag** — orbit camera around the preview prop
- **Right-drag** — zoom in / out
- `C` / `V` — rotate prop left / right
- `Q` / `E` — tilt prop up / down
- `X` — reset prop rotation and camera to defaults

### Adding a Store

Add a new block to `Config.Stores` in `config_shops.lua`. Every field is optional where noted.

```lua
Config.Stores = {
    ["mystore"] = {

        info = {
            storename  = "My Accessories Shop",   -- shown in the shop UI header
            promptitle = "Accessories Store",      -- shown on the hold-prompt / ox_target label
            useTarget  = false,                    -- false = native prompt | true = ox_target
            distance   = 2.0,                      -- interaction radius in metres
            coords     = vector4(0.0, 0.0, 0.0, 180.0),

            blip = {
                enabled = true,
                sprite  = -417940443,
                color   = "BLIP_MODIFIER_MP_COLOR_0",
                name    = "Accessories Store",
                scale   = 0.6,
            },

            -- allowed = false → always open | true → enforce open/close hours
            openTimeSetting = {
                allowed      = false,
                open         = 8,
                close        = 21,
                blipSprite   = -417940443,
                blipmodifier = "BLIP_MODIFIER_MP_COLOR_2",  -- blip color when closed
            },

            canInteract  = { func = true, error = "none" },
            requiredJobs = false,   -- false = all | { "doctor", "hunting" } = whitelist
        },

        previewLight = {    -- point light above the preview prop (nil = use Config.PreviewLight)
            Enabled   = true,
            Time      = { AlwaysOn = true },
            Direction = { Mode = "custom", CustomOffset = { X = 0.0, Y = 0.0, Z = 0.4 } },
            Visual    = { ColorHex = "#ffffff", Range = 3.5, Intensity = 22.0 },
        },

        ped = {
            enabled       = true,
            model         = "cs_mp_travellingsaleswoman",
            outfit        = 0,                             -- clothing preset (0 = default)
            spawnDistance = 30.0,                          -- spawn/despawn radius
            scenario      = "WORLD_HUMAN_SMOKE_NERVOUS_STRESSED",
            anim          = { animDict = "", animName = "" },  -- fallback when no scenario
        },

        preview = {
            enabled           = true,
            previewPropsCoord = vector4(0.0, 0.0, 0.0, 180.0),  -- prop spawn position and heading
            camCoords         = vector3(0.0, 0.0, 0.0),          -- absolute camera position
            camFov            = 40.0,
            autoRotate        = false,
        },

        wagon = { enabled = false },   -- set enabled = true and add model/coords for a deco wagon

        BuyItems = {
            { itemName = "pearlnecklace",  itemLabel = "Pearl Necklace",   gender = "all",  category = "Neck", price = 15.0 },
            { itemName = "skullmaskred",   itemLabel = "Skull Mask (Red)", gender = "all",  category = "Head", moneytype = "gold", price = 5.0 },
        },
    },
}
```

#### `info` Field Reference

- `storename` — title shown at the top of the shop UI
- `promptitle` — label on the native hold-prompt / ox_target option
- `useTarget` — `true` = ox_target on ped · `false` = native RDR2 hold-prompt
- `distance` — interaction radius in metres
- `coords` — `vector4` — ped spawn position and prompt zone centre
- `blip` — map blip; `enabled = false` hides it
- `openTimeSetting` — hour restriction; `allowed = false` skips the check entirely
- `canInteract` — `{ func = true, error = "none" }` — custom pre-check hook; `func = false` always blocks access
- `requiredJobs` — `false` = open to all · `{ "job1", "job2" }` = job whitelist

#### `ped` Field Reference

- `enabled` — `false` to skip ped spawning entirely
- `model` — ped model name (string)
- `outfit` — clothing preset index (0 = default)
- `spawnDistance` — distance at which the ped is spawned and despawned
- `scenario` — world scenario string — takes priority over `anim`
- `anim` — `{ animDict, animName }` — fallback when no scenario is set

#### `preview` Field Reference

- `enabled` — default `true` — enable the 3-D prop preview
- `previewPropsCoord` — `vector4` — prop spawn position and heading
- `camCoords` — `vector3` — absolute camera position in the world
- `camFov` — default `40.0` — preview camera field-of-view
- `autoRotate` — default `false` — prop slowly rotates for an automated display effect

#### `wagon` Field Reference

Set `enabled = false` to skip the wagon entirely. When enabled:

- `model` — vehicle or static prop model to spawn as the main wagon
- `coords` — `vector4` — wagon spawn position (may differ from `info.coords`)
- `spawnDistance` — distance at which the wagon is spawned and despawned
- `wagonProps` — list of decorative props to attach to or place near the wagon

Each entry in `wagonProps`:
```lua
{ model = "mp005_p_collectorwagon01b", attach = true, bone = 0,
  offset = vector3(0,0,0), rotation = vector3(0,0,0), collision = false }
```

#### `BuyItems` Field Reference

- `itemName` *(required)* — must match the key in `config_items.lua` and the inventory
- `itemLabel` *(required)* — display name shown in the shop UI
- `gender` *(required)* — `"all"` · `"male"` · `"female"` — shown only to matching gender
- `category` *(required)* — body region tab: `"Neck"` · `"Hand"` · `"Head"` · `"Arm"` · `"Torso"` · `"Belt"` · `"Leg"`
- `price` *(required)* — cost in the chosen currency
- `moneytype` *(optional)* — `"cash"` (default) or `"gold"`

### Global Preview Settings (`config_shops.lua`)

```lua
Config.PreviewLight = { ... }           -- fallback light when a store has no previewLight defined
Config.AutoRotatePreview        = false -- global default for preview.autoRotate
Config.PlacementCamFov          = 45.0 -- camera FOV fallback
Config.PlacementCamDist         = 2.2  -- camera distance fallback (used when camCoords is absent)
Config.PlacementCamHeight       = 0.85 -- camera height fallback (used when camCoords is absent)
Config.PlacementCamTargetZ      = 0.35 -- point-at Z fallback (used when camCoords is absent)
Config.ShopPreviewZOffset       = 0.30 -- prop height fallback (used when camCoords is absent)
Config.PlacementCamAngleOffset  = 87.0 -- angle offset fallback (used when camCoords is absent)
Config.OpenStoreKey = 0x2CD5343E       -- hold key for native prompt (default: ENTER)
```

Per-store `preview.*` values always override these globals. When a store provides `camCoords`, the distance/height/angle fallbacks are ignored.

### HUD Integration

The store hides the HUD on open and restores it on close. To point it at a different HUD resource, edit the two functions at the top of `config_shops.lua`:

```lua
Config.HideHud = function()
    if GetResourceState("fx-hud") == "started" then
        exports["fx-hud"]:hideHud()
    end
end

Config.ShowHud = function()
    if GetResourceState("fx-hud") == "started" then
        exports["fx-hud"]:showHud()
    end
end
```

### Store Localization

All shop-facing strings live in `locales.lua` under the `shop_` prefix and follow the active `Config.Locale`.

- `shop_nomoney` — `"You don't have enough money!"`
- `shop_nofunds_gold` — `"You don't have enough gold!"`
- `shop_shopisclose` — `"This shop is currently closed!"`
- `shop_dontaccess` — `"You don't have access to this shop!"`
- `shop_additems` — `"You bought ${count}x ${item}!"`
- `shop_promptstore` — `"Store"`
- `shop_cart_label` — `"Your Cart"`
- `shop_hint_camera` — `"Camera"`
- `shop_hint_rotate` — `"Rotate"`
- `shop_hint_tilt` — `"Tilt"`
- `shop_hint_reset` — `"Reset"`
- `shop_hint_add_cart` — `"Add to Cart"`

---

### Seasonal Events (`Config.SeasonalEvents`)

Date-range events that automatically apply discounts and surface exclusive items inside selected stores.

```lua
Config.SeasonalEvents = {
    enabled = true,   -- false disables the entire system

    christmas = {
        enabled          = true,
        label            = "Christmas Celebration",
        desc             = "Holiday accessories are here! Limited-time discount.",
        icon             = "mdi:christmas-tree",
        discountIcon     = "mdi:tag-outline",
        dateIcon         = "mdi:calendar-outline",
        announceDuration = 8,              -- seconds the announcement toast stays visible
        startDate        = { month = 12, day = 1  },
        endDate          = { month = 12, day = 31 },
        discount         = 15,             -- % discount applied to all BuyItems prices
        sendAnnouncement = "christmas",    -- /christmas → broadcasts the event notice
        seasonStore      = { "blackwater", "valentine" },
        seasonItems      = {
            { itemName = "snowflakering", itemLabel = "Snowflake Ring",
              gender = "all", category = "Hand", moneytype = "gold", price = 20.0 },
        },
    },

    -- halloween = { ... },
}
```

#### Field Reference

- `enabled` (root) — `false` disables the entire seasonal system
- `enabled` (event) — `false` skips only this event
- `label` — display name shown in the shop UI banner and announcement
- `desc` — subtitle text shown while the event is active
- `icon` — MDI icon key for the event badge
- `announceDuration` — seconds the broadcast toast is visible
- `startDate` / `endDate` — `{ month, day }` — event is active between these dates (inclusive)
- `discount` — percentage deducted from every `BuyItems` price in `seasonStore`
- `sendAnnouncement` — admin command suffix — `/christmas` sends the notice to all players
- `seasonStore` — list of `Config.Stores` keys that receive the discount
- `seasonItems` — extra items visible only while the event is active (same format as `BuyItems`)

Multiple events can be defined and run simultaneously if their date ranges overlap.

---

### Night Market (`Config.NightMarket`)

A wandering night-time vendor that appears at randomised locations between `openHour` and `closeHour`. Items carry rarity tiers and limited per-location stock that resets each time the NPC moves.

The placement fields — `ped`, `preview`, `previewLight`, `wagon` — follow the exact same structure as `Config.Stores` entries.

```lua
Config.NightMarket = {
    enabled          = false,
    storename        = "Night Market",
    sendAnnouncement = "nightmarket",   -- /nightmarket broadcasts the arrival notice
    label            = "Night Market",
    desc             = "The wandering merchant has arrived! Limited stock, 22:00-02:00.",
    icon             = "mdi:cart-variant",
    announceDuration = 8,

    openHour  = 22,
    closeHour = 7,

    blip = {
        enabled = false,
        sprite  = -417940443,
        color   = "BLIP_MODIFIER_MP_COLOR_3",
        name    = "Night Market",
        scale   = 0.7,
    },

    previewLight = {    -- same structure as Config.Stores previewLight
        Enabled   = true,
        Time      = { AlwaysOn = true },
        Direction = { Mode = "custom", CustomOffset = { X = 0.0, Y = 0.0, Z = 0.4 } },
        Visual    = { ColorHex = "#ffffff", Range = 3.5, Intensity = 22.0 },
    },

    ped = {             -- same structure as Config.Stores ped
        enabled       = true,
        model         = "cs_cassidy",
        outfit        = 0,
        spawnDistance = 30.0,
        scenario      = "WORLD_HUMAN_SMOKE_NERVOUS_STRESSED",
        anim          = { animDict = "", animName = "" },
    },

    preview = {         -- same structure as Config.Stores preview
        enabled           = true,
        previewPropsCoord = vector4(0.0, 0.0, 0.0, 0.0),
        camCoords         = vector3(0.0, 0.0, 0.0),
        camFov            = 45.0,
        autoRotate        = false,
    },

    wagon = { enabled = false },

    lowStockWarning = 30,   -- stock % at which the low-stock badge appears (0-100)

    coords = {
        { pos = vector4(-866.7064, -734.9441, 59.8482, 180.5280), spawnChance = 70 },
        -- { pos = vector4(2295.2837, -1175.8193, 42.8518, 285.7056), spawnChance = 50 },
    },

    BuyItems = {
        { itemName = "silverring",       itemLabel = "Silver Ring",      gender = "all",  category = "Hand",
          price = 3.0, tier = "COMMON",    limitedStock = 15 },
        { itemName = "skullmask",        itemLabel = "Skull Mask",       gender = "male", category = "Head",
          moneytype = "gold", price = 50.0, tier = "LEGENDARY", limitedStock = 3 },
        { itemName = "skullmaskred",     itemLabel = "Skull Mask (Red)", gender = "all",  category = "Head",
          moneytype = "gold", price = 800.0, tier = "EXCLUSIVE", limitedStock = 1 },
    },
}
```

#### Field Reference

- `enabled` — `false` disables the night market entirely
- `openHour` / `closeHour` — game-clock hours the market is active
- `sendAnnouncement` — admin command suffix to broadcast the arrival notice
- `announceDuration` — seconds the broadcast toast is visible
- `lowStockWarning` — stock percentage at which the yellow low-stock badge appears; last 1 unit is always red
- `ped` — same structure as `Config.Stores` — model, outfit, spawnDistance, scenario, anim
- `preview` — same structure as `Config.Stores` — previewPropsCoord, camCoords, camFov, autoRotate
- `previewLight` — same structure as `Config.Stores` — per-market preview light override
- `wagon` — same structure as `Config.Stores` — decorative wagon; `enabled = false` skips it
- `coords[].pos` — `vector4` — NPC spawn position and heading for this location
- `coords[].spawnChance` — `0–100` — probability this location is chosen each night cycle

The NPC cycles through the `coords` list in order; after the last entry it wraps back to the first. A `spawnChance` below 100 means the market may skip a location entirely for that night.

#### `BuyItems` Extra Fields

- `tier` — `"COMMON"` · `"RARE"` · `"LEGENDARY"` · `"EXCLUSIVE"` — displayed as a coloured badge
- `limitedStock` — maximum units available at the current location; resets when the NPC moves to a new position

---

## Server Exports

See [EXPORTS.md](EXPORTS.md) for the full export reference.

```lua
exports['fx-accessories']:isAttached(serverId, itemName)  -- boolean
exports['fx-accessories']:getAttachments(serverId)        -- table
exports['fx-accessories']:attachItem(serverId, itemName)  -- boolean
exports['fx-accessories']:removeItem(serverId, itemName)  -- boolean
```

---

## Files Overview

- `config.lua` *(editable)* — settings, keys, UI, lights
- `config_items.lua` *(editable)* — item definitions, attachment limits
- `config_shops.lua` *(editable)* — store definitions, seasonal events, night market
- `locales.lua` *(editable)* — player-facing text
- `frameworks.lua` *(edit only for custom framework)* — framework detection and notification bridge
- `reload_items.json` *(auto-managed)* — admin panel draft, save/load work-in-progress calibrations
- `fx_accessories.sql` *(run once)* — database item registration
- `fxmanifest.lua` *(do not edit)* — resource manifest
- `libs/animlib.lua` *(do not edit)* — animation library
- `libs/objects.lua` *(do not edit)* — prop model list for calibration panel
- `libs/Male-Bones.md` — bone ID reference (male)
- `libs/Female-Bones.md` — bone ID reference (female)

---

## Localization

Change active locale in `config.lua`:
```lua
Config.Locale = "en" -- "en" | "tr" | "de"
```

To add a new locale, copy an existing block in `locales.lua` and translate the strings.

---

## Troubleshooting

- **Items do not attach** — item exists in `config_items.lua`, gender matches, model is valid
- **Item icons missing** — PNG exists in `ui/assets/inventoryitemimages/` named `<itemName>.png`
- **Prop invisible after attach** — model hash is correct and included in assetpacks
- **Prop drifts during animation** — BoneID is IK-driven — switch to a stable bone (see `libs/Male-Bones.md`)
- **Item removed automatically** — `RequireItem = true` and player no longer has item in inventory
- **Calibration panel not visible** — check `Config.AccadminAdminOnly` and ACE permission setup
- **No notifications** — check if `fx-hud` is running or if a custom notify handler is set in `frameworks.lua`
