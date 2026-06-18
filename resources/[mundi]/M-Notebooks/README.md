# M-Notebooks — The Ultimate Notebook System for RedM

A premium personal notebook system for RedM with handwriting-style NUI, full drawing support, wall pinning, animations, admin tools, Discord logging, and dual-framework support for both **VORP** and **RSG-Core**.

---

## Feature Overview

### Notebook System
- **Per-character notebooks** — Every character gets their own persistent notebook stored in MySQL. Multiple characters, multiple notebooks.
- **100+ pages** — Up to 200 configurable pages per notebook, with page flip animations and sound effects.
- **Handwriting NUI** — Western-themed parchment UI with 7 handwriting fonts, 7 ink colors, adjustable text size, and optional lined paper.
- **Freehand drawing** — Draw directly on any page with a gradual eraser tool. Drawings save alongside text.
- **Text blocks** — Drag and position text anywhere on the page. Multiple text blocks per page supported.
- **Image embedding** — Paste image URLs onto any page with drag-to-reposition and rotation.
- **Custom title & cover date** — Players can rename their notebook and edit the cover date. Owner name displayed on the cover.
- **Pen requirement** — Writing requires a pen item in inventory (toggle on/off in config). Reading always works.
- **Inventory-based** — Must have the notebook item in your inventory to use it. Fully integrated with VORP or RSG inventory.

### Torn Pages & Pinning
- **Tear out pages** — Rip any page out of the notebook. The page content (text, drawings, images) is preserved as item metadata on a "Torn Page" item.
- **Use torn pages** — Read the torn page from inventory, or place it on a wall.
- **Pin notes to walls** — Full 3D placement system with raycast wall detection, scroll-to-rotate, arrow-key height adjustment, and a ghost preview prop.
- **Player-chosen duration** — When pinning, players pick how long the note stays: 1h, 4h, 8h, 24h, or 48h (fully configurable in config).
- **Auto-expiration** — Server-side cleanup thread runs on a configurable interval, automatically removing expired pinned notes and cleaning up world props for all players.
- **Persistent through restarts** — Pinned notes are stored in the database and automatically reload for all connected players when the resource starts.
- **ox_target interaction** — Read or delete pinned notes via ox_target. Owners can always delete their own notes. Admins can delete any note.
- **Per-player & server-wide limits** — Configurable max pinned notes per player and total max across the server.

### Animations & Props
- **Native scenario support** — Uses `WORLD_HUMAN_WRITE_NOTEBOOK` scenario for natural-looking notebook use. Fully automatic prop handling.
- **Fallback raw animations** — Optional manual animation system with separate male/female anim dicts and a physical journal prop attached to the player's hand.
- **Writing animation** — Separate idle/writing animations that switch dynamically based on player input.
- **Page flip sounds** — Subtle ambient sound effects on page turn.

### Framework Support
- **VORP Framework** — Full support for vorp_core + vorp_inventory (items, notifications, permissions).
- **RSG-Core Framework** — Full support for rsg-core + rsg-inventory. Switch frameworks with a single config line.
- **Framework bridge architecture** — Clean abstraction layer means zero code duplication. All API differences handled behind the scenes.

---

## Admin & Moderation Tools

M-Notebooks includes a full suite of admin tools designed for server staff who need to moderate written content.

### In-Game Admin Commands

| Command | Description |
|---------|-------------|
| `/notebookadmin <player_id>` | View any online player's notebook(s). If the player has multiple notebooks, an ox_lib selection menu appears. Opens the notebook in read-only admin mode. |
| `/notebookadmin <player_id> <notebook_db_id>` | Open a specific notebook directly by database ID. |
| `/notebooklog <player_id>` | Send **all** of a player's notebook content to Discord as rich embeds for offline review. |
| `/notebooklog <player_id> <notebook_db_id>` | Send a specific notebook to Discord. |

- Permission-gated — Only staff with configured admin groups (e.g., `"admin"`, `"god"`) can use these commands.
- Multi-notebook support — Each character can have multiple notebooks; the admin menu lists them all with page counts.

### Discord Webhook Logging

- **Torn page logging** — Whenever a player tears a page out, the full content (text, images, drawing count) is sent to Discord.
- **Title change logging** — Notebook title renames are logged with player info and notebook ID.
- **Pinned note logging** — New pinned notes and deletions are logged with coordinates and content preview.
- **Full notebook dump** — The `/notebooklog` command sends the entire notebook as multi-embed Discord messages (handles large notebooks with pagination, up to 10 embeds per message).

---

## Player Commands

| Command | Description |
|---------|-------------|
| `/notebook` | Open your notebook (also works via inventory item use) |
| `/resetnotebook` | Emergency NUI reset if the UI gets stuck |

---

## Dependencies

| Dependency | Link |
|------------|------|
| ox_lib | [GitHub](https://github.com/overextended/ox_lib) |
| ox_target | [GitHub](https://github.com/overextended/ox_target) | or VORP version (https://github.com/MrTerabyteLK/ox_target)
| oxmysql | [GitHub](https://github.com/overextended/oxmysql) |
| vorp_core + vorp_inventory | Required if using VORP framework |
| rsg-core + rsg-inventory | Required if using RSG framework |

---

## Installation

1. Place `M-Notebooks` in your resources folder.
2. Run `database.sql` in your MySQL database (creates tables + inventory items).
3. Add `ensure M-Notebooks` to your `server.cfg` — **after** all dependencies.
4. Open `shared/config.lua` and set `Config.Core.framework` to `"VORP"` or `"RSG"`.
5. Configure any settings you want to change (all clearly documented in the config).
6. Restart your server.

---

## Inventory Items

The `database.sql` file automatically inserts/updates these items:

| Item | Label | Usable | Description |
|------|-------|--------|-------------|
| `notebook` | Notebook | Yes | Leather-bound personal notebook for writing. |
| `pen` | Pen | No | Ink pen required for writing. |
| `torn_page` | Torn Page | Yes | A page torn from a notebook. Use to read or pin to a wall. |

> **Note:** If using RSG-Core, you may need to add the items to your RSG items database instead. The SQL provided is for the VORP `items` table format.

---

## Configuration

Every aspect of the script is configurable through a single, well-documented config file with clear section headers.

### Config Sections

| Section | What it controls |
|---------|-----------------|
| **[CORE]** | Framework selection (`VORP` / `RSG`), debug mode |
| **[ITEMS]** | Item names, pen requirement toggle, pen consume-on-use |
| **[NOTEBOOK]** | Default/max pages, character limit, title/cover settings |
| **[ANIMATIONS]** | Scenario toggle, male/female anim dicts, book prop model, bone attachment |
| **[PINNING]** | Max pins per player/server, pin prop, ox_target distance, placement controls, expiration durations, cleanup interval, Discord webhook |
| **[UI]** | Ink colors (7), fonts (7), default font/color/size, lined paper toggle, paper style |
| **[COMMANDS]** | Command names, optional keybind |
| **[MESSAGES]** | All notification strings (easy to translate) |
| **[ADMIN]** | Admin webhook URL, logging toggles, admin command name, permission groups |

---

## File Structure

```
M-Notebooks/
├── fxmanifest.lua               # Resource manifest
├── database.sql                 # Database tables + items
├── README.md
├── shared/
│   └── config.lua               # All configurable settings
├── client/
│   ├── framework.lua            # Client framework bridge (VORP/RSG)
│   ├── nui.lua                  # NUI communication handler
│   ├── main.lua                 # Core client — animations, items, commands
│   └── pinned.lua               # Pinned notes — placement, props, ox_target
├── server/
│   ├── framework.lua            # Server framework bridge (VORP/RSG)
│   └── main.lua                 # Database CRUD, item management, admin tools
└── nui/
    ├── index.html               # Main NUI page
    ├── style.css                # Parchment western theme
    ├── script.js                # Full notebook JS logic
    ├── sound/                   # Page flip & interaction sounds
    └── images/
        ├── book.png
        ├── paper.png
        └── stackofpaper.png
```

---

## Technical Highlights

- **Lua 5.4** — Modern Lua with full integer support.
- **ox_lib callbacks** — Server-client communication via ox_lib for reliability.
- **oxmysql** — All database operations use parameterized queries (no SQL injection).
- **Framework bridge pattern** — All VORP/RSG API calls go through a unified bridge. Adding a third framework in the future is trivial.
- **Soft-delete for pins** — Expired notes are marked `expired = 1` rather than deleted, preserving data for admin review.
- **Cleanup on resource stop** — All world props, ox_target entities, and animations are properly cleaned up when the resource stops or restarts.
- **Persistent state** — Notebooks and pinned notes survive server restarts. Pinned notes auto-reload for all connected players on resource start.

---

## Support

For questions, bugs, or feature requests, reach out through discord(https://discord.gg/Nng77jKReK).
