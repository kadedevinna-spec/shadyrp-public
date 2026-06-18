# M-Telegrams

A period-authentic telegram and postal system for RedM. Players register at telegraph offices across the map, get assigned (or choose) a telegram ID, and communicate through written telegrams, physical parcels, and carrier birds. Built for RSG-Core and VORP frameworks.

Version 1.0.0

---

## Table of Contents

- [Requirements](#requirements)
- [Installation](#installation)
- [Configuration Overview](#configuration-overview)
- [Features](#features)
  - [Registration and Telegram IDs](#registration-and-telegram-ids)
  - [Composing and Sending](#composing-and-sending)
  - [Inbox, Sent, and Archive](#inbox-sent-and-archive)
  - [Contacts and Address Book](#contacts-and-address-book)
  - [Public Directory](#public-directory)
  - [Companies (Job-Based)](#companies-job-based)
  - [Player Businesses](#player-businesses)
  - [Parcel System](#parcel-system)
  - [Carrier Bird System](#carrier-bird-system)
  - [Telegram Paper Items](#telegram-paper-items)
  - [Player Personalization](#player-personalization)
  - [Checker Station](#checker-station)
  - [Admin Commands](#admin-commands)
- [Custom Notifications](#custom-notifications)
- [Station Setup](#station-setup)
- [Database](#database)
- [Discord Webhooks](#discord-webhooks)
- [M-Notebooks Compatibility](#m-notebooks-compatibility)
- [Troubleshooting](#troubleshooting)

---

## Requirements

- RedM server (FiveM/cfx.re platform)
- [ox_lib](https://github.com/overextended/ox_lib)
- [oxmysql](https://github.com/overextended/oxmysql)
- One of the following frameworks:
  - **RSG-Core** (`rsg-core`, `rsg-inventory`)
  - **VORP** (`vorp_core`, `vorp_inventory`)
- Optional:
- [ox_target](https://github.com/overextended/ox_target) (if using `ox_target` interaction mode)

---

## Installation

1. Place the `M-Telegrams` folder in your server's resources directory.
2. Import the database schema:
   - Run `sql/database.sql` against your MySQL database. This creates all 14 required tables. Safe to run on an existing database; it uses `CREATE TABLE IF NOT EXISTS` throughout and will not overwrite data.
3. Add inventory items. For RSG servers, the item definitions are handled in `sql/rsg_items.lua`. For VORP, run the INSERT statements at the bottom of `database.sql` (the `telegram_paper` item and bird-related items).
4. Open `shared/config.lua` and set `Config.Framework` to either `"RSG"` or `"VORP"`.
5. Add `ensure M-Telegrams` to your `server.cfg` (after your framework and ox_lib).
6. Start or restart your server.

The script runs automatic database migrations on startup. If you update to a newer version, any missing columns or tables are added automatically without manual SQL changes.

---

## Configuration Overview

All configuration lives in `shared/config.lua`. The file is split into numbered sections:

| Section | What It Controls |
|---|---|
| 1 | Framework, debug mode, locale, year |
| 2 | Telegram ID generation, custom IDs, VIP reservations, registration cost and fields |
| 3 | Profile pictures, signatures, custom stamps |
| 4 | Station locations, NPCs, blips, interaction mode |
| 5 | Compose options (fonts, colors, images, stamps, anonymous mode, costs, bulk messaging) |
| 6 | Inbox capacity, archive, telegram paper items |
| 7 | Contacts, telegram book, public directory |
| 8 | Job-based companies, player-created businesses |
| 9 | Notification position/content, animations, sounds |
| 10 | Display options (names in inbox/reader, avatars, timestamps) |
| 11 | Admin commands, checker station, auto-cleanup, Discord webhooks |
| 12 | Parcel system (fees, weight, delays, blocked items) |
| 13 | Carrier bird system (breeds, care, training, flight, XP, decay) |

Every feature has a master toggle. If you don't want parcels, set `Config.Parcels.enabled = false`. Same for birds, businesses, archive, directory, and so on. Disabled features are hidden from the UI entirely.

---

## Features

### Registration and Telegram IDs

Players visit any telegraph station on the map to register. Registration gives them a telegram ID used for all communication.

**ID Generation Modes:**

- `"random"` -- Generates a city prefix + random number, e.g. `VAL-4829`. If the player unregisters, the number is freed.
- `"charid"` -- Uses the character's database ID as the number. Deterministic and persistent even after unregistration.

**Custom IDs:**
When `Config.CustomTelegramId.enabled = true`, players can choose their own ID at registration. Configure whether the city prefix is locked (`useCityPrefix`), length limits, allowed characters, and blocked words.

**VIP / Reserved IDs:**
`Config.VipTelegramIds` lets you pre-assign specific telegram IDs to players by steam hex or character ID. Supports single IDs and ID pools for multi-character accounts.

**Unregistration:**
Players can cancel their service. Configurable refund percentage, message/contact deletion, cooldown before re-registration.

### Composing and Sending

Telegrams are written on a paper canvas with selectable fonts, ink colors, and optional image attachments. Players can draw on the telegram using a freehand canvas.

- **Rich Telegrams** -- Multiple font choices and ink color options, configured via `Config.RichTelegrams`.
- **Stamps** -- Optional decorative stamps with individual costs. The `Config.Stamps` table defines available stamps with images and prices.
- **City Postmarks** -- Telegrams show the city they were sent from. Configurable via `Config.CityStamps`.
- **Anonymous Mode** -- Certain jobs can send telegrams without revealing their identity. Controlled by `Config.Anonymous`.
- **Image Attachments** -- Embed images in telegrams. Domain allowlisting prevents abuse. `Config.ComposeImages` configures this.
- **Cost Per City** -- Each station can have different sending costs via `Config.TelegramCosts`.

### Inbox, Sent, and Archive

Standard inbox and sent views with pagination. Players can read, delete, and manage telegrams.

- **Archive** -- Move telegrams out of the inbox into an archive. Restore them at any time. Supports bulk archive/unarchive operations.
- **Inbox Capacity** -- Optional hard cap on inbox size. When exceeded, the oldest telegrams are auto-deleted. Configurable warning threshold.
- **Soft Delete** -- Deleting a telegram only hides it for that player. The other party still sees their copy.

### Contacts and Address Book

Players can save frequently-used telegram IDs as contacts with display names and optional notes. The contacts list is accessible from the compose screen for quick recipient selection.

- `Config.Contacts.maxContacts` controls the per-player limit.
- The Telegram Book system extends contacts with notes and is integrated alongside the standard contacts UI.

### Public Directory

Players can opt-in to a public listing that other players can browse at any station. Listings include a name, telegram ID, category, and description.

Categories are defined in `Config.PublicDirectory.categories`. Businesses can also be listed in the directory.

### Companies (Job-Based)

Companies are defined in `Config.Companies` and tied to specific job names. Players with the matching job see the Company tab with a shared inbox.

Owners (determined by job grade via `Config.CompanyTelegrams.ownerGradeMin`) can manage member access. Members can read and send telegrams on behalf of the company.

### Player Businesses

Players can create their own businesses independently of the job system. Each business gets a unique telegram ID (prefixed with `Config.BusinessTelegrams.idPrefix`), a shared inbox, and member management with read/send permissions.

- Creation cost, max businesses per player, max members, and max memberships are all configurable.
- Business members can be given individual read and send permissions by the owner.
- Businesses can list themselves in the public directory.

### Parcel System

Send physical inventory items to other players through the telegram office.

- **Weight and Fees** -- Parcels have a base fee plus weight-based surcharge. Weight display unit is configurable (grams, kg, pounds).
- **Delivery Delay** -- Optional real-world time delay before parcels become available for collection.
- **Collection Modes** -- `"station"` lets recipients collect from any office. `"sender"` requires collection at the originating station.
- **Blocked Items** -- Block specific items or entire item prefixes (e.g. all weapons) from being parceled.
- **Auto-Return** -- Uncollected parcels are returned to the sender after a configurable period.
- **Inventory Integration** -- The send panel reads the player's current inventory, with configurable auto-refresh.

### Carrier Bird System

A full pet ownership and delivery system. Players buy birds from a randomized shop at telegram offices, care for them, train them, and use them to send telegrams without visiting a station.

**Breeds:**
Three default breeds with different stats (Rock Pigeon, Homing Pigeon, Carrier Dove). Add custom breeds by copying the template in config.

**Care and Feeding:**
Birds have hunger and health stats that decay over real-world time (or only while the owner is online, configurable). Care items restore stats. Dead birds can be revived with medicine.

**Training:**
Training items grant XP and stat boosts with cooldowns and training durations. Birds level up and gain permanent stat improvements.

**Flight and Delivery:**
Flight time is calculated from distance and the bird's speed stat. After delivery the bird rests before it can fly again. Stamina reduces rest time. There is an optional death chance during flight.

**Item-Based Sending:**
Players can use a `telegram_paper` item in the world to compose a telegram and attach it to their bird on the ground, bypassing the telegram office entirely. The bird spawns in front of the player with a walk-to prompt and petting animation before flying off.

**Shop:**
The bird market rotates stock on a timer. Birds spawn with randomized stats and level-scaled pricing.

### Telegram Paper Items

Telegrams can be extracted from the inbox as physical inventory items (`telegram_paper`). These items carry the full telegram content as metadata. Using the item opens the telegram reader.

- `Config.TelegramItems.extractMode` controls whether extraction copies or removes the telegram from the inbox.
- `Config.TelegramItems.consumePaperOnSend` removes a paper item when sending via carrier bird.

Blank telegram papers open a compose screen with attached bird sending.

### Player Personalization

- **Profile Pictures** -- URL-based profile images with optional sepia/vintage filter. Shown in inbox lists, directory, contacts, and the telegram reader. Configurable per-job or per-identifier restrictions.
- **Signatures** -- Players draw a handwritten signature at registration. Can optionally be used as a stamp on outgoing telegrams.
- **Custom Stamps** -- Disabled by default. When enabled, players can set a custom stamp image URL.

### Checker Station

A restricted-access feature for government or admin roles. Look up any telegram ID to view their message history. Controlled by `Config.CheckerStation` with job and identifier restrictions.

### Admin Commands

All commands are defined in `Config.Admin`:

| Command | What It Does |
|---|---|
| `/telegramadmin <telegram_id>` | View any player's inbox and sent messages. Logged to Discord if enabled. |
| `/telegramnumber <old_id> <new_id>` | Change a player's telegram ID. Works from console or in-game. |
| `/telegramunregister <telegram_id>` | Force-unregister a player and clear their registration cache. |
| `/telegramid` | Shows your own telegram ID (no admin required). |

Admin commands check player groups defined in `Config.Admin.groups` and also support ACE permissions.

---

## Custom Notifications

M-Telegrams ships with its own built-in NUI notification system (toast-style popups that appear in-game). If you prefer to use a different notification system, the script provides a clean override mechanism.

### How It Works

Open `shared/notifications.lua`. You will find two functions:

- `Config.ClientNotify(text, duration, notifType)` -- Called for client-side notifications.
- `Config.ServerNotify(source, text, duration, notifType)` -- Called for server-side notifications.

By default both return `nil`, which tells the script to use its own NUI notifications. To use your own system, write your notification call inside the function and return `true`. Returning `true` suppresses the built-in notification so you don't get duplicates.

### Parameters

| Parameter | Type | Description |
|---|---|---|
| `text` | string | The notification message. |
| `duration` | number | Duration in milliseconds (default 4000). |
| `notifType` | string | One of `"info"`, `"success"`, `"warning"`, `"error"`. |
| `source` | number | (Server only) The player's server ID. |

### Examples

**ox_lib (client):**
```lua
function Config.ClientNotify(text, duration, notifType)
    lib.notify({
        title       = 'Telegram',
        description = text,
        type        = notifType,
        duration    = duration,
    })
    return true
end
```

**ox_lib (server):**
```lua
function Config.ServerNotify(source, text, duration, notifType)
    TriggerClientEvent('ox_lib:notify', source, {
        title       = 'Telegram',
        description = text,
        type        = notifType,
        duration    = duration,
    })
    return true
end
```

**rNotify (client):**
```lua
function Config.ClientNotify(text, duration, notifType)
    TriggerEvent('rNotify:NotifyLeft', text, notifType, duration)
    return true
end
```

**RSG-Core (client):**
```lua
function Config.ClientNotify(text, duration, notifType)
    TriggerEvent('RSGCore:Notify', text, notifType, duration)
    return true
end
```

**RSG-Core (server):**
```lua
function Config.ServerNotify(source, text, duration, notifType)
    TriggerClientEvent('RSGCore:Notify', source, text, notifType, duration)
    return true
end
```

**VORP (client):**
```lua
function Config.ClientNotify(text, duration, notifType)
    TriggerEvent('vorp:TipRight', text, duration)
    return true
end
```

You can use any notification resource. The pattern is the same: call the external system, then `return true` to prevent the built-in toast from also firing.

### Notification Settings in Config

`Config.Notifications` in the main config controls the built-in system's behavior:

- `onReceive` -- Notify when a telegram arrives while online.
- `onLogin` -- Notify on character load if unread telegrams exist.
- `onLoginDelaySeconds` -- Delay before the login notification fires (increase if it shows before the world loads).
- `position` -- Where the toast appears on screen. Options: `"top-right"`, `"top-left"`, `"top-center"`, `"bottom-right"`, `"bottom-left"`, `"bottom-center"`, `"center-left"`, `"center-right"`.
- `showSenderName`, `showSubject`, `showSenderId` -- Control what information appears in the notification. If all three are false, it just says "You received a telegram."
- `soundEnabled` -- Play a sound effect on notification.

---

## Station Setup

Stations are defined in `Config.Stations`. Each station has:

```lua
{
    name = "Valentine",
    city = "Valentine",
    coords = vector3(-178.83, 626.60, 114.08),
    blip = {
        enabled = true,
        sprite = 1861010125,
        label = "Telegram Office",
    },
    npc = {
        enabled = true,
        model = "mp_u_m_m_gunforhireclerk_01",
        coords = vector4(-177.94, 628.15, 113.08, 148.26),
    },
    jobLock = nil,
    checkerStation = false,
}
```

- `coords` -- Where the interaction point is.
- `blip` -- Map blip. Set `enabled = false` to hide.
- `npc` -- Telegraph clerk. Set `enabled = false` for no NPC (uses a sphere zone instead).
- `jobLock` -- Restrict access to specific jobs. `nil` = open to everyone.
- `checkerStation` -- Whether the checker tool is available at this station.

The interaction mode is set globally via `Config.InteractionMode`:
- `"ox_target"` -- Eye-based interaction using ox_target.
- `"prompt"` -- Classic RDR2 hold-key prompt.

NPCs spawn and despawn based on player proximity (30m spawn, 40m despawn) to avoid unnecessary entities.

---

## Database

The schema lives in `sql/database.sql`. It creates 14 tables:

| Table | Purpose |
|---|---|
| `m_telegrams_registrations` | Player registrations (telegram IDs, names, profile pics, signatures) |
| `m_telegrams_messages` | All telegrams (22 columns covering rich content, stamps, fonts, anonymity, fees) |
| `m_telegrams_contacts` | Player-saved contacts |
| `m_telegrams_book` | Extended contacts with notes (telegram book) |
| `m_telegrams_directory` | Public directory listings |
| `m_telegrams_companies` | Config-defined company registrations |
| `m_telegrams_company_members` | Company member assignments |
| `m_telegrams_businesses` | Player-created businesses |
| `m_telegrams_business_members` | Business member assignments with permissions |
| `m_telegrams_vip_ids` | VIP/reserved telegram ID assignments |
| `m_telegrams_parcels` | Parcel tracking (status, items, fees, delivery times) |
| `m_telegrams_birds` | Carrier bird ownership and stats |
| `m_telegrams_bird_training_log` | Training cooldown tracking |
| `m_telegrams_bird_deliveries` | Active bird delivery tracking |

The script runs automatic migrations on every startup. New columns and tables from updates are added without manual SQL intervention.

---

## Discord Webhooks

Enable logging in `Config.Discord`:

```lua
Config.Discord = {
    enabled = true,
    webhookUrl = "https://discord.com/api/webhooks/...",
    botName = "M-Telegrams",
    logRegistrations = true,
    logSentTelegrams = true,
    logBulkMessages = true,
    logAdminActions = true,
}
```

Parcel logging has its own toggles in `Config.Parcels`:
- `logSentParcels` -- Log when parcels are sent.
- `logReceivedParcels` -- Log when parcels are collected.

---

## M-Notebooks Compatibility

M-Telegrams can expose the player's address book to the M-Notebooks script. When enabled, a "Addresses" button appears inside the notebook UI showing the player's saved telegram contacts.

To enable, set `Config.TelegramBook.notebooksCompat = true` in M-Telegrams config. M-Notebooks must also be running and configured for this integration.

The address book data is snapshot-based: the notebook owner's contacts are fetched live and saved into the notebook. If someone else opens that notebook (stolen, found, etc.), they see the frozen snapshot as read-only.

---

## Troubleshooting

**Players cannot see the telegram office blip.**
Check that `blip.enabled = true` for the station in `Config.Stations`. Verify the `sprite` hash is valid. Some map mods move or remove vanilla buildings -- make sure the `coords` actually place the NPC inside the building.

**Registration fails with no error message.**
The player likely doesn't have enough money. Check `Config.RegistrationCost`. If using a custom ID, check `Config.CustomTelegramId` settings -- the ID might violate length, character, or blocked word rules. Enable `Config.Debug = true` and check the server console for details.

**Telegrams are not delivered / recipient says they never got it.**
The recipient must be registered. Verify with `/telegramid` or check the `m_telegrams_registrations` table. If both players are registered and it still fails, enable debug mode and check server console output during the send.

**NUI does not open when interacting with the NPC.**
If using `ox_target`, make sure ox_target is started before M-Telegrams in your `server.cfg`. If using `"prompt"` mode, check that `Config.PromptRange` and `Config.PromptKey` are correct. Verify the NPC model is valid and the `coords` vector4 heading faces toward the player approach direction.

**Notifications appear twice.**
You likely filled in `Config.ClientNotify` or `Config.ServerNotify` but forgot to `return true`. Without the return, the built-in NUI notification also fires. Make sure your override function returns `true`.

**Parcels stuck in "In Transit" forever.**
If `Config.Parcels.deliveryDelayMinutes` is set, parcels stay in transit for that duration. The transit-to-pending promotion runs every 60 seconds server-side. If parcels are still stuck after the delay has elapsed, check the server console for database errors and verify `m_telegrams_parcels` has the correct `deliver_at` timestamp.

**Carrier bird not spawning when using telegram paper item.**
The bird system requires `Config.CarrierBirds.enabled = true` and the player must own at least one bird with `healthy` status. Check that the bird is not resting, in training, in flight, sick, or dead. The paper item also needs to exist in the items table.

**Bird died unexpectedly.**
Birds lose hunger over time, and once hunger hits zero, health starts draining. If `Config.CarrierBirds.decayOnlyWhenOnline` is `false`, decay runs 24/7 even while the player is offline. Consider setting it to `true` on servers where players log in infrequently. Feed birds with care items to keep them alive.

**Database migration errors on startup.**
The auto-migration uses `ALTER TABLE ... ADD COLUMN` with an existence check. If you see errors, it usually means a table was created with a non-standard charset or engine. Make sure your database uses `utf8mb4` charset. You can also run `database.sql` manually to inspect the schema and compare.

**ox_target interaction not showing on NPC.**
Verify `Config.InteractionMode = "ox_target"`. The script uses `exports.ox_target:addLocalEntity()` on spawned NPCs. If the NPC model fails to load (invalid hash), no entity is created and no target is attached. Check that the `npc.model` string in the station config is a valid RDR3 ped model.

**Auto-cleanup deleting telegrams players still want.**
`Config.AutoCleanup` only deletes telegrams where both the sender and recipient have soft-deleted their copy. If only one side deleted it, it stays. Adjust `deleteAfterDays` or disable cleanup entirely with `enabled = false`.

**Custom notification system not working.**
Open `shared/notifications.lua` and make sure you edited the correct function (client vs server). The function must `return true` after calling your notification system. If you return `nil` or `false` or forget to return, the built-in NUI toast fires instead. Test with `Config.Debug = true` to confirm the script is reaching the notification code path.

---

## File Structure

```
M-Telegrams/
  fxmanifest.lua
  shared/
    config.lua            -- All configuration
    notifications.lua     -- Notification overrides
    locale.lua            -- Localization strings
  client/
    framework.lua         -- Framework abstraction (RSG/VORP)
    main.lua              -- Exports and key handlers
    nui.lua               -- NUI callback registrations
    stations.lua          -- Station spawning, blips, interaction
    notifications.lua     -- Bird animations, receive handlers, read animations
  server/
    framework.lua         -- Server framework abstraction
    database.lua          -- All database queries
    main.lua              -- Startup, migrations, background threads, item registration
    telegrams.lua         -- Core telegram logic (register, send, read, delete, etc.)
    contacts.lua          -- Contact CRUD callbacks
    companies.lua         -- Company registration and inbox
    parcels.lua           -- Parcel send, collect, return logic
    birds.lua             -- Carrier bird system (shop, care, train, flight, decay)
    admin.lua             -- Admin commands
    webhooks.lua          -- Discord webhook sender
  nui/
    index.html            -- Main NUI markup
    script.js             -- Core NUI logic
    script_parcels_birds.js -- Parcel and bird NUI logic
    style.css             -- Core styles
    style_parcels_birds.css -- Parcel and bird styles
    img/                  -- Stamps, city stamps, bird portraits, UI images
    sounds/               -- Sound effects
    fonts/                -- Custom fonts
  sql/
    database.sql          -- Full schema (14 tables)
    rsg_items.lua         -- RSG inventory item definitions
```
