# M-Deliveries

Wagon delivery and smuggling system for RedM. Legal and illegal contracts, reputation progression, law enforcement, gang ambushes, posse co-op, and a custom NUI clipboard. Works with VORP and RSG.

---

## Table of Contents

- [Features](#features)
- [Requirements](#requirements)
- [Installation](#installation)
- [Configuration Overview](#configuration-overview)
- [How It Works](#how-it-works)
- [The NUI Clipboard](#the-nui-clipboard)
- [Reputation & Progression](#reputation--progression)
- [Legal vs Illegal Missions](#legal-vs-illegal-missions)
- [Posse System](#posse-system)
- [Law Enforcement System](#law-enforcement-system)
- [Gang Ambush System](#gang-ambush-system)
- [Wagon Maintenance](#wagon-maintenance)
- [Player Commands](#player-commands)
- [Admin Commands](#admin-commands)
- [Discord Logging](#discord-logging)
- [Localization](#localization)
- [Database](#database)
- [Troubleshooting](#troubleshooting)

---

## Features

### Deliveries
- Legal and illegal contracts: general freight, agricultural goods, hemp, moonshine, mixed contraband
- Multi-stop routes from single-stop hauls up to 7-stop runs across the map
- 11 wagon types with different sizes and cargo capacities
- Missions are generated dynamically with random names, destinations, and story flavor
- Pay scales with route distance, cargo type, risk, and delivery bonuses
- Timer per mission based on route length, color shifts as time runs low

### Progression
- 30-level reputation system tracked per foreman (Annesburg rep is separate from Saint Denis, etc.)
- Bigger wagons, more stops, illegal work, and better contracts unlock as you level up
- 5 mission tiers: Short Haul, Standard, Long Haul, Cross-Country, Marathon
- Lifetime stats tracked per player (deliveries, earnings, success rate, etc.)

### Interaction
- Custom NUI clipboard with 5 tabs: Jobs, Active, Posse, Stats, Guide
- Works with ox_target or prompts (auto-detected, configurable)
- Package carry system with animated bone-attached props, 11 package models
- Optional player profile pictures in the NUI (can be disabled in config)

### Law Enforcement
- Alerts go out to online law officers with a map circle showing the wagon's area
- 5 jurisdiction offices: LSO, NHSO, WESO, NARO, USMO
- NPC witnesses spot illegal cargo and try to flee and report. You can stop them
- Minesweep inspection minigame (can be toggled off in config)
- Full workflow: inspect cargo, seize wagon, take evidence, deliver to law office, impound

### Combat
- Gang ambushes trigger randomly during deliveries based on risk
- Some gang members are mounted and pursue your wagon
- If you go down, gang AI can steal the wagon
- Flee 300m to escape or fight it out for a survival bonus

### Posse
- Up to 4 players per group with payment split sliders
- All members earn equal rep
- If the leader disconnects, leadership transfers automatically (15 min rejoin window)

### Other
- VORP and RSG frameworks (auto-detected)
- Anti-exploit: rate limiting, distance checks, wagon inventory whitelisting
- Discord webhook logging with 17 events across 4 categories
- 5 languages: English, French, Spanish, Portuguese, Russian
- Reconnect within 15 minutes to resume a delivery after a crash/disconnect
- Custom notification system with sound and configurable placement

---

## Requirements

| Dependency | Required |
|------------|----------|
| [ox_lib](https://github.com/overextended/ox_lib) | Yes |
| [oxmysql](https://github.com/overextended/oxmysql) | Yes |
| `vorp_core` + `vorp_inventory` | For VORP |
| `rsg-core` + `rsg-inventory` | For RSG |
| [ox_target](https://github.com/overextended/ox_target) | Recommended (falls back to prompts if absent) |

---

## Installation

### Step 1: Add the Resource
Extract and place the `M-Deliveries` folder into your server's `resources` directory (e.g. inside a `[Mundi]` folder).

### Step 2: Import the Database
Run `sql/database.sql` on your MySQL database. This creates all 5 required tables using `CREATE TABLE IF NOT EXISTS`, safe to run on an existing database.

### Step 3: Add Items to Your Framework

#### For VORP:
Run `sql/vorp_items.sql` on your database to register delivery items.

#### For RSG:
Copy the item definitions from `sql/rsg_items.lua` into your `RSGShared.Items` table in `rsg-core/shared/items.lua`.

### Step 4: Update Your Server Config
Add to your `server.cfg`:

```cfg
ensure ox_lib
ensure oxmysql
ensure vorp_core          # OR rsg-core
ensure vorp_inventory     # OR rsg-inventory
ensure ox_target          # Optional but recommended
ensure M-Deliveries
```

### Step 5: Configure
Open `shared/config.lua` and tweak whatever you need. Framework is auto-detected.

### Step 6: Restart
Start the server. The script picks up your framework automatically and runs any needed database migrations.

---

## Configuration Overview

Everything is in `shared/config.lua`. The file is split into labeled sections. Use `Ctrl+F` with these tags to jump around:

| Section Tag | What It Controls |
|---|---|
| `[CORE]` | Framework, interaction system, debug, language, prompt keys |
| `[UI]` | Notifications, blips, entity markers, menu colors |
| `[REPUTATION]` | Rep system, decay, level titles, per-foreman tracking |
| `[MISSIONS]` | Legal/illegal toggles, time restrictions, cooldowns, deposits, timers |
| `[PACKAGES]` | Package models, wagon inventory, cargo presets, item requirements |
| `[WAGONS]` | Wagon types, sizes, capacities, mission restrictions |
| `[REWARDS]` | Payment settings, distance pay, bonuses, item rewards |
| `[AMBUSH]` | Ambush chance, enemies, weapons, spawn patterns, mounted gangs |
| `[LAW]` | Law alerts, jurisdictions, witnesses, inspection minigame, evidence offices |
| `[LOCATIONS]` | Foreman NPCs, dropoff pools, town definitions |

Additional config files:
- `shared/config_discord.lua`: Discord webhook URLs, event toggles, embed colors
- `locale/*.lua`: All translatable text strings

Every major system has a master toggle. Don't want ambushes? `Config.Ambush.enabled = false`. Don't need law alerts? `Config.LawAlerts.enabled = false`. Disabled systems do nothing.

---

## How It Works

1. **Find a Foreman.** Visit one of the delivery foremen scattered across the map (Annesburg, Saint Denis, Strawberry, Tumbleweed). They appear as blips on your map.
2. **Open the Clipboard.** Interact with the foreman to open the NUI delivery menu.
3. **Choose a Contract.** Browse available legal or illegal jobs. Each shows the destination, cargo type, payment estimate, and risk level.
4. **Select Your Cargo.** For illegal runs, choose your cargo type and provide the required items from your inventory.
5. **Load the Wagon.** Pick up packages from the foreman's table and carry them to your wagon. Walk to the wagon and load them in.
6. **Hit the Road.** Follow the route markers on your map to each delivery stop.
7. **Deliver the Goods.** At each stop, unload packages and deliver them to the dropoff point.
8. **Get Paid.** After the final stop, return to a foreman or complete the delivery from the NUI to collect your earnings.

### What Can Go Wrong
- **Gang Ambushes.** Armed gangs may attack you on the road. Fight or flee.
- **Law Enforcement.** If you're running illegal cargo, law officers get alerts and can inspect your wagon.
- **NPC Witnesses.** Townfolk may spot your illegal goods and run to report to the law.
- **Wagon Damage.** Rough driving damages your wagon. Too much damage and you'll need repairs.
- **Time Limit.** Every contract has a timer. Run out and you fail the mission.

---

## The NUI Clipboard

The menu has 5 tabs:

| Tab | What It Shows |
|---|---|
| **Jobs** | Available legal and illegal contracts with payment estimates, cargo types, and risk badges |
| **Active** | Your current delivery progress: stops completed, packages remaining, and a complete button |
| **Posse** | Form a group, invite nearby players, set payment splits, manage your delivery posse |
| **Stats** | Lifetime statistics: total deliveries, earnings, success rate, reputation, posse missions |
| **Guide** | The Freight Hauler's Handbook: step-by-step instructions, terrain tips, and repair guides |

Players can also set a profile picture (URL). The clipboard shows risk badges and cooldown timers. Profile pictures can be disabled in config with `Config.UI.profilePicture = false`, which replaces them with a static cowboy silhouette.

---

## Reputation & Progression

Rep is tracked **per foreman**. Your standing with the Annesburg foreman is separate from Saint Denis.

### How You Earn Rep
- Completing deliveries (scales with distance, packages, and stops)
- Illegal missions earn 1.8x reputation
- Surviving ambushes grants bonus rep
- Group missions give all members equal rep

### How You Lose Rep
- Failing a delivery
- Having your wagon destroyed
- Running out of time
- Getting your cargo seized by law enforcement

### What Rep Unlocks

| Level | Unlocks |
|---|---|
| 1 | Small wagons, Short Haul missions |
| 3 | Medium wagons |
| 5 | Standard missions, Long Haul missions |
| 8 | Large wagons |
| 10 | Hemp smuggling (illegal) |
| 15 | Moonshine smuggling (illegal), Cross-Country missions |
| 20 | Mixed contraband (illegal), Marathon missions |

### Level Titles
Greenhorn → Novice Hauler → Journeyman → Experienced Driver → Veteran Hauler → Expert Freighter → Master Smuggler → Elite Runner → Legendary Hauler

---

## Legal vs Illegal Missions

### Legal Missions
- Available during configurable daytime hours
- No item requirements, cargo is provided
- Lower risk, lower pay
- 3 cargo presets: General, Agricultural, Freight
- No law enforcement interaction

### Illegal Missions
- Available during configurable nighttime hours (or always, if time restrictions are disabled)
- **Players must provide their own contraband items** from inventory
- Higher pay (2.1x multiplier), higher risk
- Triggers law enforcement alerts when law officers are online
- 3 cargo presets:
  - **Hemp.** Requires cured hemp + empty crates
  - **Moonshine.** 3 quality tiers (Original, Blueflame, Red) with scaling pay
  - **Mixed.** Hemp and moonshine combined

### Minimum Law Requirement
Illegal missions only show up when enough law officers are online (default: 4). Configurable in `Config.LawAlerts.minLawRequirement`.

---

## Posse System

Any player can form a delivery posse for co-op runs.

- **Up to 4 players** per posse
- Payment split sliders. The leader decides how money is divided
- All members earn equal rep regardless of split
- NUI shows nearby players you can invite
- If the leader disconnects, leadership passes to the next member
- 15-minute rejoin window for disconnected leaders

---

## Law Enforcement System

Law players have their own side of the delivery system.

### How It Works
1. Smuggler starts an illegal delivery. After a random delay and distance gate, law officers in that jurisdiction get a map alert
2. A circle appears on their map showing the wagon's rough area, updates based on witnesses, town proximity, jurisdiction crossings
3. Law finds the wagon, uses **Inspect Cargo**
4. If the minesweep minigame is on, it's a grid search where you find evidence cells without hitting too many innocent ones. Grid size scales with evidence count (3x3, 4x4, 5x5)
5. If minigame is off, a timed search animation plays and evidence is found automatically
6. If illegal cargo is found, law can open the storage, seize the wagon, carry evidence packages to a law office dropoff
7. After evidence is processed, the wagon can be impounded

### Alert Triggers
| Trigger | Description |
|---|---|
| Initial alert | Random delay after wagon leaves the foreman area |
| NPC Witness | Townfolk spot illegal cargo and flee to report. Intercept them to prevent the alert |
| In-town detection | High chance of detection when driving through towns with illegal cargo |
| Traveling detection | Periodic low chance while traveling on roads |
| Jurisdiction crossing | Alert fires when entering a new law jurisdiction |

### Minesweep Toggle
Set `Config.LawAlerts.inspectionMinigame` to `true` or `false` in config. When disabled, law officers still play a search animation but evidence is discovered automatically without the minigame.

---

## Gang Ambush System

Random armed encounters during deliveries, chance based on risk level.

### How It Works
- Every 10 seconds during a delivery, there's a risk-based chance of ambush
- Higher risk missions and illegal cargo increase the chance
- Ambushes are blocked near towns (250m safe zone) and close to start/end points
- Enemies spawn from 3 patterns: Roadside, Hill, or Pincer formation
- Some gang members spawn on horseback and pursue your wagon
- If you're downed, gang AI may try to steal your wagon

### Fighting or Fleeing
- **Fight.** Kill all enemies to clear the ambush and earn a survival bonus
- **Flee.** Get 300m away from the ambush zone and maintain distance for 5 minutes

### Ambush Scaling

| Factor | Effect |
|---|---|
| Mission risk level | Higher risk = more frequent ambushes |
| Illegal cargo | +25% ambush chance, +20 risk |
| Player level | More enemies at higher levels |
| Escalation tiers | 4 difficulty levels with different enemy counts and weapon tiers |

---

## Wagon Maintenance

### Repairing Your Wagon
If your wagon takes damage during a delivery, you can repair it on the spot.

**Required materials:**
- 2x Wood Planks (`wood_plank`)
- 4x Nails (`nails`)

Use the **Repair Wagon** option on the wagon (appears when damaged). Check current health with **Check Wagon Status**.

### Replacing the Horse
If your draft horse dies or becomes detached:

1. Find a wild or untamed horse nearby (not owned by another player)
2. Lead or lasso it within **15 meters** of your wagon
3. Use the **Replace Wagon Horse** option on the wagon
4. Cargo, blips, and wagon targets are all preserved through the swap

---

## Player Commands

Available to all players. Autocomplete suggestions show up as you type.

| Command | Description |
|---|---|
| `/deliverytime` | Check remaining time on your active delivery |
| `/deliverystatus` | View current delivery status: cooldowns, package count, wagon health |
| `/wagonunstuck` | Unstick your delivery wagon if it gets stuck or frozen |
| `/resetpackage` | Reset package carry state (only works when not on an active delivery) |
| `/cancelpreview` | Cancel a stuck package placement preview |
| `/resetdeliverynui` | Emergency reset if the delivery menu gets stuck open |
| `/acceptposseinvite` | Accept a pending posse invitation |
| `/declineposseinvite` | Decline a pending posse invitation |

---

## Admin Commands

Requires admin, superadmin, or moderator group. Suggestions show in chat for admins.

| Command | Description |
|---|---|
| `/delivery_addrep <id> <amount> [foremanId]` | Add reputation to a player (omit foremanId for all foremen) |
| `/delivery_removerep <id> <amount> [foremanId]` | Remove reputation from a player |
| `/delivery_setrep <id> <amount> <foremanId>` | Set exact reputation for a specific foreman |
| `/delivery_setlevel <id> <level> <foremanId>` | Set a player's level for a specific foreman |
| `/delivery_checkrep <id>` | View a player's reputation and level breakdown |
| `/delivery_stats <id>` | View full delivery statistics for a player |
| `/delivery_resetstats <id>` | Reset a player's stats (keeps reputation and level) |
| `/delivery_check <id>` | View a player's active delivery details |
| `/delivery_activeall` | List all active deliveries on the server |
| `/delivery_cancel <id>` | Force-cancel a player's delivery |
| `/delivery_givemoney <id> <amount>` | Give cash to a player |
| `/delivery_help` | Show all admin commands in chat |

`<id>` = the player's server ID (shown in the player list).

---

## Discord Logging

Configure in `shared/config_discord.lua`. Set webhook URLs per category and toggle events individually.

### Webhook Categories

| Category | Events |
|---|---|
| **Missions** | Delivery started, completed, failed, cancelled |
| **Economy** | High-value payouts, level ups, milestones |
| **Law** | Inspections, seizures, evidence deliveries |
| **Admin** | All admin command usage |

### Notable Events
- **Ambush triggers and survivals** with location data
- **High-value delivery alerts** ($100+ payouts, configurable threshold)
- **Milestone tracking** (10, 25, 50, 100, 250, 500, 1000 deliveries)
- **Group delivery completions** with member lists

Set `DiscordConfig.enabled = false` to disable all logging.

---

## Localization

Includes 5 languages:

| File | Language |
|---|---|
| `locale/en.lua` | English (default) |
| `locale/fr.lua` | French |
| `locale/es.lua` | Spanish |
| `locale/pt.lua` | Portuguese |
| `locale/ru.lua` | Russian |

Set your language in config:
```lua
Config.Core.language = "en"  -- Change to "fr", "es", "pt", "ru", etc.
```

### Adding Your Own Language
1. Copy `locale/_template.lua` and rename it to your language code (e.g. `de.lua` for German)
2. Change `Locales["xx"]` to `Locales["de"]` at the top of the file
3. Translate the strings on the right side of each `=`
4. Do NOT change the key names on the left side
5. Preserve `%s`, `%d` placeholders and HTML tags like `<strong>`, `<em>`
6. Save as UTF-8 (without BOM)
7. Set `Config.Core.language = "de"` in your config

The template file includes instructions at the top.

---

## Database

5 MySQL tables, created by `sql/database.sql`:

| Table | Purpose |
|---|---|
| `smuggle_reputation` | Per-foreman reputation for each player |
| `smuggle_stats` | Lifetime player statistics and profile picture |
| `smuggle_groups` | Active delivery posses |
| `smuggle_group_members` | Posse membership tracking |
| `smuggle_location_stats` | Per-foreman delivery and earnings statistics |

Migrations run on startup. If you update to a newer version, missing columns get added automatically.

---

## Troubleshooting

### The NUI menu won't open
- Make sure `ox_lib` is started before `M-Deliveries` in your `server.cfg`
- Use `/resetdeliverynui` to force-close a stuck menu
- Check the F8 console for errors

### Wagons don't spawn
- Verify your foreman locations in config have valid wagon spawn coordinates
- Ensure the wagon models exist in your game build
- Check that `ox_target` or the prompt system is working (test with another script)

### Items not loading for illegal missions
- For VORP: Run `sql/vorp_items.sql` on your database
- For RSG: Add item definitions from `sql/rsg_items.lua` to your shared items
- Restart your inventory resource after adding items

### Law alerts not triggering
- Check `Config.LawAlerts.enabled` is `true`
- Verify `Config.LawAlerts.minLawRequirement`. You need that many law officers online
- Make sure law job names in `Config.LawAlerts.jurisdictions` match your framework's job names exactly

### Reputation not saving
- Ensure `oxmysql` is running and connected to your database
- Check that `smuggle_reputation` table exists (run `sql/database.sql`)
- Enable `Config.Core.debug = true` and check F8 for database errors

### Package carry animation stuck
- Use `/resetpackage` to clear the carry state
- If in a delivery, complete or abandon it first

---

## File Structure (Accessible Files)

These files are not escrowed and can be edited:

```
M-Deliveries/
├── shared/
│   ├── config.lua              -- All configurable settings
│   ├── config_discord.lua      -- Discord webhook configuration
│   └── locale.lua              -- Locale system loader
├── locale/
│   ├── en.lua                  -- English
│   ├── fr.lua                  -- French
│   ├── es.lua                  -- Spanish
│   ├── pt.lua                  -- Portuguese
│   ├── ru.lua                  -- Russian
│   └── _template.lua           -- Template for new translations
├── sql/
│   ├── database.sql            -- Database schema
│   ├── vorp_items.sql          -- VORP item definitions
│   └── rsg_items.lua           -- RSG item definitions
├── fxmanifest.lua              -- Resource manifest
└── README.md                   -- This file
```

All other files (client scripts, server scripts, NUI) are escrowed through Tebex.

---
