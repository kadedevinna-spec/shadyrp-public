# M-Raids

**Two-in-one crime system for RedM.** Adds static fort/location raids and moving bank wagon robberies.

Framework support: **VORP** and **RSG** (auto-detected via `framework.lua`).

> **Load order requirement:** M-Raids must load **after** `Mundis-Minigames`. In your `server.cfg`, make sure `ensure Mundis-Minigames` appears before `ensure M-Raids`.

---

## What's Included

| Feature | Description |
|---|---|
| **Raids** | NPCs defend a location. Players fight through waves, then loot chests. |
| **Bank Wagons** | A guarded wagon travels a road. Players intercept, kill escorts, blow the wagon open, loot what falls out. |
| **Fence NPCs** | Underground contacts players visit to trade `intel_folder` items for `route_plans` (required to start a wagon robbery). |
| **Law Alerts** | Sends automatic notifications + map blips to law enforcement players when a raid or robbery hits a threshold. |
| **Jurisdictions** | Map is divided into zones (NARO, LSO, NHSO, WESO). Only one raid or wagon per zone at a time, each with its own cooldown. |
| **Loot system** | Chests with VORP inventory, minigames (padlock / lockpick), animations, timed access locks. |
| **Localization** | All player-facing text lives in `locales/`. Six languages included (en, de, es, fr, pt, ru). |

---

## Admin Commands

| Command | What it does |
|---|---|
| `/m_startraid <location>` | Force-start a raid (e.g. `fort_mercer`) |
| `/m_startbankwagon <id>` | Force-start a bank wagon route by number (default: 1) |
| `/m_endraid [id/location/all]` | End one or all active raids |
| `/m_endbankwagon [id/all]` | End one or all active wagons |
| `/m_resetcooldown [jurisdiction]` | Reset cooldowns |
| `/m_raidstatus` | List all active raids |

Admin = any player in `group.admin` (your existing txAdmin/server ACE groups).

---

## How Raids Work (Minimum Setup)

A raid only needs **3 things** to function:

```lua
fort_mercer = {
    name = "Fort Mercer",
    enabled = true,
    jurisdiction = "NARO",
    startPoint = vector4(...),   -- Where the start NPC stands
    startNPCModel = 's_m_m_...',
    -- At least one of: sentries, patrols, or waves
    sentries = { ... },
}
```

Everything else is optional. If you omit it, global defaults fill in.

---

## Per-Raid Optional Extras

These are all **opt-in**. Leave them out for a basic raid.

### Dialogue
NPC talks to the player before starting. Multi-step conversation, animations, custom lines.
```lua
dialogue = { enabled = true, lines = { greeting = "...", steps = { ... } } }
```
Omit entirely → NPC starts raid on prompt press, no dialogue.

### Required Items
```lua
requiredItem = { "raid_map", "explosives" },
consumeRequiredItem = true,
```
Omit → anyone can start (subject to job restrictions and cooldown).

### Friendly Jobs (blacklist)
```lua
friendlyJobs = { "NARO", "LSO" },  -- These jobs CANNOT start this raid
```
Omit → all jobs allowed (except global `Config.AllowedJobs` whitelist if set).

### Minimum Law Online
```lua
minLawCount = 2,  -- At least 2 law players must be online
```
Omit → no law requirement.

### Waves
```lua
waves = {
    { count = 4, models = { "s_m_m_army_01" } },
    { count = 6, models = { "s_m_m_army_01" }, leader = true },
}
```
Omit → raid ends when sentries/patrols are all dead (no reinforcement waves).

### Vault (Bank Vault mechanic)
Requires players to place dynamite on a vault door before loot unlocks.
```lua
vaults = { ... }
```
Omit → no vault. Loot chests open directly after 80% enemies cleared (or your `accessTimer`).

### Alarm System
```lua
alarm = { enabled = true, position = vector3(...) }
```
Players can disable it to reduce law alert chances.
Omit → no alarm.

### Turrets
```lua
turrets = { { position = vector4(...), model = "..." }, ... }
```
Omit → no mounted weapons.

### Law Alert Override (per-raid)
```lua
lawAlert = {
    timingMode = 'exact',
    triggerPoint = 'waves_cleared',
    jobs = { "NARO" },
}
```
Omit → uses global `Config.LawAlerts` settings.

### Loot Override (per-raid)
```lua
loot = {
    accessTimer = 2.0,   -- 2 minute wait before chests unlock
    items = {
        { name = 'goldbar', chance = 30 },
        { name = 'intel_folder', chance = 70 },
    }
}
```
Omit → uses global `Config.Loot` items and defaults.

---

## How Bank Wagons Work (Minimum Setup)

A route needs a start point, end point, wagon model, and at least a driver.

```lua
[1] = {
    name = "Tumbleweed to Armadillo",
    enabled = true,
    jurisdiction = "NARO",
    wagonModel = "stagecoach004_2x",
    startPoint = vector4(...),
    endPoint = vector3(...),
    driver = { model = "s_m_m_valdeputy_01", weapon = "weapon_revolver_cattleman" },
    cooldownMinutes = 60,
}
```

### Bank Wagon Optional Extras

| Field | Default if omitted |
|---|---|
| `convoyRiders` | No mounted escorts |
| `warWagon` | No war wagon / gatling gun |
| `wagonGuards` | No on-foot guards |
| `minLawmen` | No law requirement |
| `warWagon.enabled = true` | Disabled |
| `blip` | No map blip for the route start |

### How Players Start a Robbery
Controlled by `BankWagonConfig.Activation.mode`:
- `"npc_only"` — Must visit a Fence NPC and trade intel folders for route plans
- `"item_only"` — Use `route_plans` item directly from inventory
- `"both"` — Either works

---

## Loot: Raid vs Bank Wagon

| | Raids | Bank Wagons |
|---|---|---|
| **Chest type** | VORP stash inventory (players browse and take items) | Ground scatter + strongbox chest |
| **Ground items** | No | Yes — money bags and gold bars fly out on explosion |
| **Minigame to open** | Padlock or lockpick (configurable) | Hold-prompt animation (no minigame) |
| **Access lock** | 80% enemies cleared, or a timed delay | After dynamite explodes |

---

## Localization

All text is in `locales/<lang>.lua`. Switch language with:
```lua
Config.Locale = 'en'   -- en, de, es, fr, pt, ru
```
To add a language, copy `locales/en.lua`, rename it, translate the values.

---

## File Structure

```
shared/raid_config.lua        — All raid settings + global defaults
shared/bankwagon_config.lua   — All bank wagon settings
locales/                      — Translation files
client/client.lua             — Raid client logic
client/bankwagon_client.lua   — Bank wagon client logic
server/server.lua             — Raid server logic
server/bankwagon_server.lua   — Bank wagon server logic
server/bridge.lua             — VORP/RSG framework bridge
```
