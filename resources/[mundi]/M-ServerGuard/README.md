# M-ServerGuard

**Server monitoring, analytics & moderation for RedM**  
Works with **VORP**, **RSG**.

---

## Features

- **Real-time dashboard** — in-game NUI panel and browser web panel
- **Player monitoring** — sessions, positions, deaths, economy, identifiers
- **Anti-cheat** — teleport/speed/god mode/noclip/weapon/entity detection
- **Player screening** — trust score on connect using Steam API, VAC bans, alt-account checks, Discord membership. Full screening log with filter tabs and configurable thresholds from the dashboard.
- **Community ban list** — shared cross-server ban protection (optional)
- **Discord webhooks** — alerts, bans, screening results, economy anomalies, chat logs
- **Ban system** — HWID, IP, Steam, and Discord bans with appeal system
- **Watchlist** — flag specific players and monitor their items/activity
- **Economy analytics** — track money/gold/items, detect duplication and anomalies
- **Resource monitor** — track all running resources, start/stop from dashboard
- **Teleports** — preset and custom admin teleport locations
- **Blips** — place named admin markers on the live map
- **Reports** — player-submitted bug/rule reports
- **Leaderboards** — configurable stat leaderboards
- **txAdmin sync** — two-way sync with txAdmin: imports existing bans at startup and mirrors new bans in real-time. Optional write-back sends M-ServerGuard bans back into txAdmin.

---

## Requirements

- [oxmysql](https://github.com/overextended/oxmysql) (resource dependency)
- MySQL 8+ or MariaDB 10.1+
- RedM / FXServer
- A VORP or RSG framework

---

## Installation

### 1. Add the resource

Place the `M-ServerGuard` folder inside your `resources/[Mundi]/` directory (create the `[Mundi]` folder if it doesn't exist).

### 2. Import the database

Run the SQL file against your database:

```sql
-- In your MySQL client or HeidiSQL / phpMyAdmin:
SOURCE /path/to/M-ServerGuard/sql/M-ServerGuard.sql;
```

Or paste the contents of `sql/M-ServerGuard.sql` directly. Tables are created with `IF NOT EXISTS` so it is safe to run multiple times.

### 3. Add to server.cfg

```cfg
ensure oxmysql
ensure M-ServerGuard
```

### 4. Configure

Edit the files in the `configs/` folder (these are the only files you need to touch):

| File | Purpose |
|------|---------|
| `configs/config.lua` | General settings, permissions, screening, ban lists |
| `configs/anticheat.lua` | Anti-cheat thresholds and auto-actions |
| `configs/webhooks.lua` | Discord webhook URLs |
| `configs/web.lua` | Browser dashboard settings |
| `configs/teleports.lua` | Admin teleport presets |

---

## Configuration Guide

### Admin groups

In `configs/config.lua`, set which player groups can access the dashboard:

```lua
AdminGroups = { 'admin', 'superadmin', 'moderator', 'owner' },
```

These must match the groups used by your framework (VORP ACE groups / RSG job groups).

### Owner lock

Set your Steam identifier so your account always has owner rank:

```lua
OwnerSteam = 'steam:110000100000001', -- replace with your Steam hex
```

### Discord webhooks

In `configs/webhooks.lua`, set webhook URLs for each channel:

```lua
URLs = {
    AntiCheat    = 'https://discord.com/api/webhooks/...',
    AdminActions = 'https://discord.com/api/webhooks/...',
    Alerts       = 'https://discord.com/api/webhooks/...',
    Screening    = 'https://discord.com/api/webhooks/...',
    Bans         = 'https://discord.com/api/webhooks/...',
    -- leave '' to disable a category
},
```

Set `ServerName` to your server's display name (shown in embeds).

### Player screening (trust score)

In `configs/config.lua`, under `MGuard.Screening`:

```lua
SteamAPIKey = 'YOUR_STEAM_WEB_API_KEY',
CheckVACBans = true,
AlertThreshold = 50,   -- flag players scoring below this
DenyThreshold  = 0,    -- deny connection below this (0 = never auto-deny)
```

Get a free Steam API key at [steamcommunity.com/dev/apikey](https://steamcommunity.com/dev/apikey). Required for VAC ban / account age checks.

### Discord bot (optional — for guild membership checks)

In `configs/config.lua`, under `MGuard.Discord`:

```lua
BotToken = 'YOUR_BOT_TOKEN',
GuildID  = 'YOUR_SERVER_ID',
RequireMembership = false,    -- set true to kick non-members
```

Create a bot at [discord.com/developers/applications](https://discord.com/developers/applications). Enable the **Server Members Intent**.

---

## Opening the Dashboard

### In-game (recommended)
Use the command (default `guard`) or press **F10**:
```
/guard
```

The dashboard opens with your session auto-authenticated.

### Browser
1. Get a web token in-game:
   ```
   /mguardwebtoken
   ```
2. Open your browser at:
   ```
   http://YOUR_SERVER_IP:YOUR_PORT/M-ServerGuard/
   ```
3. Paste the token when prompted.

Set `ServerIP` in `configs/web.lua` to your local IP so the dashboard URL is printed correctly in startup logs.

---

## Community Ban List

M-ServerGuard includes a shared community ban list — a free alternative to V-Warden.

### How it works

All M-ServerGuard servers can check a shared JSON file on GitHub when players connect. If a player is on the list, they are flagged or denied depending on your settings.

### Enabling it

In `configs/config.lua`:

```lua
MGuard.GitHubBanList = {
    Enabled = true,
    Mode    = 'community',  -- uses the shared Mundi community list
    DenyIfListed = true,    -- hard deny if found; false = penalize trust score only
    Penalty = 80,
}
```

### Contributing your bans back

To share your server's bans with the community list:

```lua
MGuard.TxAdminSync = {
    Enabled = true,
    ContributeToCommunityList = true,  -- submit bans to shared repo
}
```

When this is enabled, bans issued via txAdmin or M-ServerGuard are automatically submitted to the community ban list via a GitHub pull request (no action needed from you).

### Using your own private ban list

If you want to maintain your own ban list instead of (or in addition to) the community list:

```lua
MGuard.GitHubBanList = {
    Enabled      = true,
    Mode         = 'private',
    PrivateURL   = 'https://raw.githubusercontent.com/YourUser/your-repo/main/bans.json',
    PrivateToken = '',  -- GitHub personal access token, only needed for private repos
    DenyIfListed = true,
}
```

### Ban list JSON format

Your `bans.json` must be a JSON array. Each entry can match on **steam**, **discord**, and/or **license**:

```json
[
  {
    "steam": "steam:110000100000001",
    "reason": "Aimbot",
    "by": "YourServerName",
    "permanent": true
  },
  {
    "discord": "discord:123456789012345678",
    "reason": "Racism / toxicity",
    "by": "YourServerName",
    "permanent": false
  },
  {
    "license": "license:abc123def456",
    "steam": "steam:110000100000002",
    "reason": "HWID alt ban evader",
    "by": "YourServerName",
    "permanent": true
  }
]
```

**Fields:**
| Field | Type | Required | Description |
|-------|------|----------|-------------|
| `steam` | string | optional | Steam hex identifier (`steam:xxxxxxx`) |
| `discord` | string | optional | Discord identifier (`discord:xxxxxxx`) |
| `license` | string | optional | Rockstar license (`license:xxxxxxx`) |
| `reason` | string | yes | Ban reason shown to player |
| `by` | string | optional | Server/staff name that issued the ban |
| `permanent` | bool | optional | `true` = permanent, `false` = temporary (informational only) |

At least one of `steam`, `discord`, or `license` is required per entry.

---

## txAdmin Sync

M-ServerGuard integrates with txAdmin in two directions.

### Automatic import (txAdmin → M-ServerGuard)

No configuration needed. At startup, M-ServerGuard reads your txAdmin `playersDB.json` and imports all existing bans and warnings. Going forward, every ban, unban, warn, kick, and whitelist action issued through txAdmin is automatically mirrored into M-ServerGuard's database in real-time.

This means:
- The Connections tab, Trust Score, and Screening flags all reflect txAdmin-issued bans
- You do **not** need to use M-ServerGuard's ban button — ban through txAdmin as normal and the script syncs
- Duplicate entries are skipped automatically

### Optional write-back (M-ServerGuard → txAdmin)

When write-back is enabled, bans issued through the M-ServerGuard web panel, `/gban` command, or anti-cheat also appear in txAdmin's ban list.

In `configs/config.lua`, under `MGuard.TxAdminSync`:

```lua
WriteBackEnabled = true,
TxAdminURL       = 'http://localhost:40120',  -- your txAdmin web panel URL
TxAdminUsername  = 'yourAdminUsername',
TxAdminPassword  = 'yourAdminPassword',
```

The txAdmin user must have ban permission. Write-back is fire-and-forget — if it fails (txAdmin unreachable), the ban still exists in M-ServerGuard.

### Non-standard install paths

M-ServerGuard auto-detects `playersDB.json` from the resource path. If your FXServer `resources` folder is **not** inside your txAdmin data folder (non-standard setup), set the path manually:

```lua
TxAdminDataPath = 'C:/txData/MyServerProfile.base/data',
-- or point directly to the file:
-- TxAdminDataPath = 'C:/txData/MyServerProfile.base/data/playersDB.json',
```

Leave empty for automatic detection (works for most setups).

---

## Cross-Server Ban Sync

If you run multiple servers on the same MySQL database, bans sync automatically:

```lua
MGuard.CrossServerSync = {
    Enabled      = true,
    DenyIfBanned = true,
    Penalty      = 70,
}
```

Both servers must point to the same `oxmysql` connection string.

---

## Permissions Reference

Roles (lowest → highest): `helper` → `moderator` → `admin` → `superadmin` → `owner`

Customize per-role permissions in `configs/config.lua` under `MGuard.Permissions.RolePermissions`.

The `owner` role has `'*'` (all permissions) and is tied to `OwnerSteam` — it cannot be demoted by anyone else in the dashboard.

---

## Updating

1. Replace the resource files (do **not** overwrite your `configs/` folder)
2. Restart the resource — `database.lua` runs migrations automatically on start
3. Run the new SQL file if the changelog mentions new tables

---

## Framework Support

| Framework | Status |
|-----------|--------|
| VORP | ✅ Full support |
| RSG | ✅ Full support |
| Standalone / other | ⚠️ Partial (bridge may need manual config) |

The bridge auto-detects your framework. If detection fails, set it manually in `bridge/shared.lua`.

---

## Support & Links

- **Tebex / Download:** [mundis.tebex.io](https://mundis.tebex.io)
- **Discord:** [discord.gg/Nng77jKReK](https://discord.gg/Nng77jKReK)
- **Issues / Bug reports:** Discord `#support` channel

---

## License

This resource is distributed via Tebex. You may not redistribute, resell, or share this resource outside of Tebex. Config files are unescrow'd and may be customized freely.
