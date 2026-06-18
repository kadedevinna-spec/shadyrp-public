# MX-Ranch

Full ranch system for RedM (RDR3), built for VORP or RSG servers. Players can buy and manage ranches, raise livestock, feed animals, collect products, hire crew, use a shared stash, walk animals to market, sell at livestock yards, and log activity to Discord. NUI panel styled for the MX-SCRIPTS line.

Version 2.0.0 — MX-SCRIPTS

---

## What the script includes

A player may own one or more ranches (per server limit) or work on someone else’s ranch. Inside the ranch zone, animals have hunger, thirst, health, growth, weight, experience level, and species-specific production (milk, eggs, wool). Food and water troughs are required; chickens need a coop; a shared storage chest holds items. Animals wander within a configurable radius, can get sick, be vaccinated, and manure on the ground can be cleaned with a rake. The owner manages ranch name, ranch wallet (deposits, withdrawals, sale income), Discord webhook, and hiring from the panel. Animal sales only happen at map livestock markets while the animal is on walk — sale money goes to the ranch wallet, not directly to the player’s pocket.

Admins create ranches on the map, edit price, job, owner, and position, delete ranches, and teleport to them. Server-side anti-spam, database persistence, and optional Discord logs (per-ranch channel and staff channel) are included.

---

## Requirements

ox_lib and oxmysql must be running on the server.

For economy and inventory: on VORP, vorp_core and vorp_inventory (auto-detected if Config.Framework is auto). On RSG, rsg-core and rsg-inventory.

Import install.sql into MySQL on first setup. The resource also creates and migrates tables on start, but running the SQL once avoids race issues.

---

## Installation

Copy the MX-Ranch folder into your server resources folder.

Register every inventory item the script uses — names must match Config.Items in config.lua and any sell-reward items in Config.AnimalSell (see ITEMS.md). Without registered items, filling troughs, vaccinating, collecting, or cleaning manure will fail or show warnings.

Ensure locales/en.json (and pt.json if using Portuguese) are listed in fxmanifest.

In server.cfg, start oxmysql and ox_lib before MX-Ranch, for example: ensure oxmysql, ensure ox_lib, ensure MX-Ranch.

Tune config.lua for your server (language, items, prices, limits, markets, webhooks). Restart after changes: ensure MX-Ranch.

---

## Configuration: config.lua and defaults.lua

config.lua is what buyers edit day to day: UI language, job requirement to buy a ranch, ranches per player, crew roles (owner, manager, employee), animal limits, inventory item names, animal and structure prices, weight ranges, collection drop amounts, livestock market rules (minimum level, items on sell), market coordinates, ranch stash settings, and Discord logs (global staff webhook).

shared/defaults.lua holds internal balance: hunger and thirst rates, trough capacity, collection minigame, walk XP, interaction distances, sell requirements, sell price formula, manure disease, anti-cheat cooldowns, and fallbacks when config omits a key. config.lua wins: defined keys are not overwritten; missing keys are filled from defaults.

---

## Languages

UI text and notifications come from JSON files in locales/ (English and Portuguese included). Set Config.LocaleLanguage to en or pt. Copy en.json for another language and add the file to the manifest.

---

## Ranches and purchase

Ranches exist on the map with an NPC, circular zone (radius), purchase price, and linked job. A player buys at the NPC (cash or gold per PaymentType in defaults), within NPC distance, ranch-per-player limit, and optionally RequireJobToBuy — only players with that ranch’s job can buy it.

Each ranch stores name, owner (VORP char identifier or RSG citizenid), ranch wallet balance, animal wander radius, NPC and zone center positions, and optional owner-set Discord webhook URL.

---

## Player panel — /ranch command

Opens the NUI with these sections:

**General** — Active ranch summary: rename ranch, animal count and total weight, ranch wallet (balance, deposit from pocket, withdraw per permission), Discord webhook (owner only; saves when entered).

**Animals** — Shop to buy cows, chickens, pigs, sheep, and goats. Purchase requires ground placement inside the ranch.

**Herd** — List of all ranch animals with stats, level/XP, walk controls, set spawn point, global wander radius slider, and livestock market sell hint.

**Structures** — Buy food trough, water trough (per species or generic), chicken coop, and storage chest. Placed in the world like animals.

**Crew** — Hire players by server ID, promote, demote, and fire. Owner appears in the list; managers and employees have different wallet and management permissions.

Players who are neither owner nor worker on any ranch cannot open the panel.

---

## Animals

Five species: cows, chickens, pigs, sheep, and goats. Each has buy price, min/max weight (visual scale and sell/drop bonuses), and per-ranch and per-species limits.

Over time they gain growth (to adult in configurable hours), weight, hunger, and thirst. If troughs have food and water, animals eat and drink automatically without standing at the trough. Low hunger or thirst reduces health; sickness can come from neglect, rare snake bite, or too much manure on the ground.

**Vaccinate** — Vaccine item in inventory, near a sick animal.

**Collect product** — Cow and goat: milk. Chicken: eggs. Sheep: wool. Requires minimum growth, full product bar, and UI minigame (falling items; catch green, avoid red). Partial reward on partial success. Cooldown between collects per species.

**Walk** — Up to three animals per walk; add inside the ranch, then they follow the player. Gain XP and level while moving; on-screen bar shows progress. Used to bring animals to the sell market. Send one animal back to the ranch during a walk for XP and a free slot.

**World HUD** — Health, product, and sickness (syringe) icons above animals; pigs do not show a product icon on the HUD to reduce clutter.

---

## Structures and troughs

Food and water troughs: fill from inventory (hay and water per config), 3D text shows fill level, drain as animals eat. Chicken coop: required for chicken logic. Storage chest: shared ranch inventory (slots and weight in config); owner and crew access per rules; open with G near the chest.

---

## Livestock market (sell)

Fixed map locations (coordinates in config.lua) with blip and NPC. Player starts a walk, brings the animal to the market, and presses G at the NPC — opens sell UI; selling is not done from /ranch.

Sell conditions: animal on walk, near NPC and animal, minimum growth and health, minimum level (configurable), active walk. Price uses base buy price, growth, weight, and experience. Money credits the ranch wallet. Optional item rewards (meat, leather, feathers, etc.) go to the seller’s inventory, fixed or weight-based amounts.

---

## Ranch wallet

Balance stored per ranch in the database. Managers can deposit from pocket; withdraw per permissions (usually manager/owner). Market sales credit this wallet automatically.

---

## Manure and cleaning

Animals drop manure in the ranch. Too much increases disease risk and drains health. Players clean with the rake item (configurable) and may receive a manure item (e.g. fertilizer) in inventory. Cap on droppings per ranch.

---

## Crew and permissions

Three levels: owner (highest), manager, employee. Owner: webhook, name, full wallet control. Manager: hire, fire, promote/demote below them, deposit and withdraw. Employee: base ranch and animal access. Config.Roles numeric values set the minimum role for each action.

---

## Discord logs

Similar to MX-Playerstore. Staff webhook in Config.Logs.DiscordStaffWebhook receives admin actions and generally the same ranch events. The owner sets a per-ranch webhook in the General tab; that ranch’s events also go there (if different from staff URL, no duplicate on the same URL).

Logged events include: ranch purchase, animals and structures, trough fills, collection, sale, hire and fire, deposits and withdrawals, manure cleanup, vaccine, webhook change, rename, admin create/edit/delete/teleport, and more. EnableConsoleAudit prints lines to the server console for debugging.

---

## Administration

**Admin panel** — /createranch with no arguments opens a list of all ranches: search, teleport, edit, delete, create ranch at current position.

**In-game command** (not from server console, player only):

- /createranch — No arguments opens the panel. With arguments: /createranch name job price radius creates a ranch for sale at the admin’s position.

Admin permission: groups in AdminGroups (admin, god, superadmin by default), or ACE mxranch.admin, or ACE command.createranch.

---

## Test command

/ranchtestprod — Without ranch ID: prepares all animals on the ranch where the admin stands. With ranch ID: that ranch only. Sets animals adult, max level, and product ready to collect (where the species produces). Useful for minigame and UI testing. Requires admin permission.

---

## Database

Tables: ranches (ranch data, owner, balance, webhook), ranch_animals (per-animal state), ranch_structures (troughs, coop, chest), ranch_workers (crew), ranch_droppings (manure). Deleting a ranch cascades to animals, structures, and workers.

---

## Security and performance

Per-action cooldowns (buy, sell, collect, walk, etc.) limit event abuse. Server distance checks on important interactions. Animal sync uses indexes and patches instead of rebuilding everything on small changes. Periodic saves (SaveInterval) instead of writing to the database on every animal movement.

---

## Files buyers can edit freely

config.lua and shared/defaults.lua are in escrow_ignore on the manifest for Tebex/escrow: change prices, items, and balance without decrypting the rest.

---

## Quick start for server owners

1. Install dependencies and SQL.
2. Register inventory items matching config (see ITEMS.md).
3. Fill config.lua (language, items, prices, markets, staff webhook).
4. Create ranches with /createranch or the admin panel.
5. Players buy at the NPC, use /ranch, raise livestock; market sales fill the ranch wallet.

For fine balance (hunger, minigame, XP), use defaults.lua. For economy and map, use config.lua.

---

MX-SCRIPTS — Respect license terms when redistributing the resource.
