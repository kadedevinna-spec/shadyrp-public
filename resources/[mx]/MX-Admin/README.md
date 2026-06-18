# MX-Admin

Admin panel for RedM with `RSG` and `VORP` support.

## What this resource does

- Opens admin panel (`/staffmenu`)
- Player report system (`/report`)
- Discord role-based access control
- Staff actions (revive, heal, kick, ban, teleport, inventory, and more)
- Internal staff chat

## Requirements

- `ox_lib`
- `oxmysql`
- `rsg-core` or `vorp_core`
- `rsg-inventory` or `vorp_inventory`

## Quick install

1. Place the `MX-Admin` folder inside `resources`.
2. Add this to your `server.cfg`:
   - `ensure ox_lib`
   - `ensure oxmysql`
   - `ensure MX-Admin`
3. Restart your server.

## Basic configuration

### 1) `config.lua`

Set the essentials:

- `Config.Framework` (`auto`, `rsg`, or `vorp`)
- `Config.AdminUiLanguage` (panel language)
- General panel options (map, reports, quick commands, etc.)

### 2) `config_discord_staff.lua`

Set staff access:

- `GuildId`
- `BotToken`
- Role IDs in `Roles`
- Levels in `RoleRank`

> Important: never share your bot token or webhooks.

## How permissions work

- Admin access is validated by Discord roles.
- The permission matrix defines which commands each role can use.
- If strict mode is enabled, anything not explicitly allowed is denied.

## Main commands

- `/adminmenu` -> opens admin panel
- `/report` -> opens player report UI
- `nc` -> noclip (client shortcut)
- `wall` -> toggles wall mode

## Main panel features

- Player management (revive, heal, kick, ban, inventory, money, jobs)
- View and reply to reports
- Saved teleports
- Staff chat
- Dashboard and live map
- Ban management

## Database (summary)

Tables used by this resource (created/updated during usage):

- `mx_permission`
- `mx_reports`
- `mx_report_messages`
- `mx_report_nearby_players`
- `mx_teleports`
- `mx_staff_chat`
- `mx_staff_logins`
- `bans` (ban records)

## Folder structure

- `client/` -> client scripts
- `server/` -> server scripts
- `html/` -> NUI interface
- `shared/` -> shared files
- `translations/` -> panel text files

## Common issues

- Staff cannot open panel: review `GuildId`, `BotToken`, and role IDs.
- No permission for commands: check matrix in `mx_permission`.
- Inventory/item errors: ensure `rsg-inventory` or `vorp_inventory` is started.

---

If you want, I can also create a "basic + full" docs setup, keeping this file short and adding a `README_FULL.md` with all technical details.
