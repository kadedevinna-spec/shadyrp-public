# FX-Doorlock

Advanced door lock system for RedM (RDR3) servers. Supports VORP and RSG frameworks.

---

## Installation

1. Copy the `fx-doorlock` folder into your `resources` directory.
2. Add the following line to your `server.cfg`:

```
ensure fx-doorlock
```

3. Make sure one of the supported frameworks is running before `fx-doorlock` starts.

---

## Requirements
 
## Minigame Script : https://github.com/guf1ck/lockpick-system

| Dependency | Purpose |
|---|---|
| `vorp_core` **or** `rsg-core` | Framework (one required) |
| `lockpick` *(optional)* | Minigame integration |
| `ox_target` / `pc_interaction` / `murphy_interact` *(optional)* | Target system |

---

## Configuration

All settings are located in `config.lua`.

### General

```lua
Config.Debug    = false
Config.Language = 'en'  -- 'en' | 'tr'
```

### Commands

```lua
Config.Settings.Commands = {
    createdoor  = 'createdoor',   -- Scan and register a door in-game
    convertmenu = 'convertmenu',  -- Open the door converter UI
    customdoor  = 'customdoor',   -- Manage custom map doors
}
```

### Interaction & Display

```lua
Config.Settings.InteractDistance   = 3.0    -- Door interaction range (meters)
Config.Settings.CreatedoorDistance = 6.0    -- Scan range for /createdoor (meters)
Config.Settings.EnableDrawSprite   = true   -- Show lock/key icon on doors
Config.Settings.UseTarget          = false  -- Use target system instead of prompts
```

### Access Control

```lua
Config.Settings.CreatedoorJobs = {}         -- Jobs allowed to use /createdoor (empty = disabled)
Config.Settings.UseCommandGroups = {        -- Groups that can manage doors
    'admin',
    'mod',
}
```

### Lockpick

```lua
Config.Settings.Lockpick = {
    minigame            = true,        -- true = minigame, false = chance-based
    itemName            = 'lockpick',  -- Required item name ('' to disable check)
    remove              = true,        -- Remove item on successful pick
    removeOnFail        = true,        -- Remove item on failed pick
    progressbarDuration = 2000,        -- Progress bar duration (ms)
    time                = 6000,        -- Task bar duration (ms)
    chance              = 60,          -- Success chance 0-100 (simple mode only)
}
```

### Law Alert & Blip

When a lockpick attempt is made, nearby law officers can be alerted with a notification and a map blip.

```lua
Config.Settings.AlertJobs = {
    AlertChance   = 100,        -- Probability (0-100) an alert fires
    AlertDistance = 300.0,      -- Only alert officers within this range (meters)
    Jobs = {
        'sheriff',
        'police',
    },
    Notification = {
        title    = 'Breakin Attempt',
        message  = 'Someone is attempting to open a door',
        dict     = 'generic_textures',
        icon     = 'lock',
        color    = 'COLOR_WHITE',
        duration = 8000,
    },
    Blip = {
        hash     = 675509286,
        modifier = 'BLIP_MODIFIER_MP_COLOR_32',
        radius   = 5.0,
        duration = 60000,  -- Blip lifetime (ms)
    },
}
```

### Door Icon

Controls the position of the lock/key sprite drawn above doors.

```lua
Config.DoorIcon = {
    OffsetX  = 0.0,   -- Right axis (positive = handle side)
    OffsetY  = 0.0,   -- Forward axis
    OffsetZ  = 1.0,   -- Vertical offset from door center
    Width    = 0.015,
    Height   = 0.020,
    Rotation = 0.0,
}
```

### Input Prompts

Default key bindings for door interaction (when `UseTarget = false`):

| Key | Action |
|---|---|
| `G` | Interact (lock/unlock) |
| `L` | Pick Lock |

---

## Door Structure

Doors are stored in `saved_doors.lua` and managed automatically. Each door entry has the following fields:

```lua
{
    id           = 1775965860,           -- Unique door ID (auto-generated)
    name         = "sheriff_front_door", -- Display/reference name
    locked       = false,                -- Initial lock state
    lockpickable = true,                 -- Can this door be lockpicked?
    alertLaw     = false,                -- Alert law jobs on lockpick attempt?
    pairedDoorId = nil,                  -- Link to another door (opens/locks together)
    jobs         = { "sheriff" },        -- Jobs with access (empty = public)
    charIds      = {},                   -- Character IDs with individual access
    groups       = {},                   -- Framework groups with access
    iconOffsetX  = nil,                  -- Per-door icon offset (nil = use global)
    iconOffsetY  = nil,
    iconOffsetZ  = nil,
    doors        = {
        { objHash = 863645408, objCoords = vector3(-1071.38, 488.87, 92.35), objHeading = 9.90 },
    },
}
```

> `doors` supports multiple objects — useful for double doors that lock/unlock together.

---

## Custom Map Doors

For doors from custom map addons (ymap/ytyp) that are not part of the default RDR3 door list, add their hashes to `config_customdoor.lua`:

```lua
Config.CustomDoorHashs = {
    1630858834,   -- My custom map door
    1341869023,
}
```

Obtain door hashes using a developer tool such as **CodeX**. FX-Doorlock already includes ~1770 default RDR3 door hashes in `doorhashes.lua` — no need to add those.

---

## In-Game Commands

### `/createdoor`
Activates door scan mode. Click a door with your mouse to register it. Requires the `UseCommandGroups` permission or a job listed in `CreatedoorJobs`.

### `/convertmenu`
Opens a UI to paste and convert door tables from other scripts (supports `Config.DoorList`, `Config.Doors`, `Doors` formats).

### `/customdoor`
Manage doors added from custom map hashes.

---

## Target System Support

Set `UseTarget = true` in `config.lua` to use a target system instead of proximity prompts. FX-Doorlock will auto-detect which system is installed:

| Resource | System |
|---|---|
| `ox_target` | Supported |
| `pc_interaction` | Supported |
| `murphy_interact` | Supported |

If `UseTarget = true` but no supported resource is found, the script falls back to prompts automatically.

---

## Minigame Integration

By default, the lockpick uses the `lockpick` export. The integration is in `client/opensource.lua` and is designed to be swapped out for any minigame:

```lua
function StartLockpickMinigame(lp)
    -- Replace this with your own minigame export
    local result = exports['lockpick']:startLockpick()
    return result  -- Must return true (success) or false (fail/cancel)
end
```

Set `Config.Settings.Lockpick.minigame = false` to use simple chance-based picking instead.

---

## Framework Support

| Framework | Resource | Notes |
|---|---|---|
| VORP | `vorp_core` + `vorp_inventory` | Full support |
| RSG | `rsg-core` | Full support |

The framework is detected automatically at startup. A console error is printed every 2 seconds if no supported framework is found.

---

## Supported Notify Systems

FX-Doorlock sends notifications through your active framework:

| Framework | Method |
|---|---|
| RSG | `fx-hud:client:showNotify` |
| VORP | `vorp:TipBottom` / `vorp:ShowAdvancedRightNotification` |
| REDEMRP | `redem_roleplay:Tip` |

---

## Localization

Two languages are included out of the box: `en` (English) and `tr` (Turkish).

Change the active language in `config.lua`:

```lua
Config.Language = 'tr'
```

To add a new language, duplicate an existing locale block in `Config.Locale` and change the key:

```lua
Config.Locale['de'] = {
    ['door_locked']   = 'Tür ist jetzt gesperrt.',
    ['door_unlocked'] = 'Tür ist jetzt entsperrt.',
    -- ...
}
```

---

## File Overview

| File | Purpose |
|---|---|
| `config.lua` | Main configuration (settings, prompts, locale, notify) |
| `config_customdoor.lua` | Hashes for custom map addon doors |
| `doorhashes.lua` | Built-in RDR3 door hash list (~1770 entries) |
| `saved_doors.lua` | Auto-managed door registry (do not edit manually) |
| `saved_custom_doors.lua` | Auto-managed custom door registry |
| `framework/frameworks.lua` | Framework detection and abstraction layer |
| `client/main.lua` | Client sync, events, thread loops |
| `client/functions.lua` | Core client logic (lock/unlock, lockpick, scan) |
| `client/customdoor.lua` | Custom door client handling |
| `client/opensource.lua` | Minigame integration (swap here) |
| `server/main.lua` | Server authority, door persistence, command handling |
| `server/customdoor.lua` | Custom door server handling |
