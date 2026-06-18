# Dodi Derby Horses — Racing

Full horse-racing system for **RedM**. Works out of the box with **RSG Core**; the same logic runs on **VORP**. Career, AI, lobbies, route editor, Hall of Fame, and NUI — tune almost everything from `config.lua`.

---

## Requirements

| Dependency | Why |
|---|---|
| **RSG Core** (`rsg-core`) *or* **VORP** (`vorp_core`) | Player identity, character id, first/last name (see [Framework](#framework-rsg-vs-vorp) below) |
| **mysql-async** | Career stats, player routes, Hall of Fame |
| **dodi_notifys** | In-game notifications ([repo / install](https://github.com/dodibanScripts/dodi_notifys/tree/main/dodi_notifys)) |

---

## Installation

1. Drop the `dodi_derbyhorse` folder into your resources directory.
2. Add `ensure dodi_derbyhorse` to your `server.cfg` (after your framework + DB; also `ensure dodi_notifys`).
3. Restart the server. The resource auto-creates the MySQL tables on first boot:
   - `derby_player_career` — wins, starts, reputation, display name.
   - `derby_player_routes` — player-created routes saved from the editor.
4. Open the menu in-game: `/derby`.

---

## Commands

| Command | Description |
|---|---|
| `/derby` | Open the main Racing menu (Career, Hall of Fame, Events, Player Races, Guide) |
| `/derbyedit` | Open/close the route editor side-panel |

Both command names are configurable in `config.lua` (`Config.UI.openCommand` / `Config.Editor.openCommand`).

---

## NUI Tabs Overview

| Tab | What it shows |
|---|---|
| **Career** | Your rider name, handicap title, wins, starts, reputation. |
| **Hall of Fame** | Server-wide leaderboard — top riders by reputation. |
| **Events** | Active lobbies you can join + catalog routes you can host. |
| **Player Races** | Routes created by players via the editor. Start races from here. |
| **How it works** | Quick in-game guide for new players. |

---

## How a Race Works (Player Guide)

1. **Open the menu** — `/derby` and go to **Events** or **Player Races**.
2. **Host or Join** — Pick a route and click Host, or join an existing lobby.
3. **Ride to the start** — Follow the GPS to checkpoint 1.
4. **Countdown** — Once enough riders arrive, 5-4-3-2-1 starts. Horses freeze.
5. **GO!** — Pass through the flag gates in order. A GPS arrow and blip guide you.
6. **Leaderboard** — A live leaderboard shows positions during the race.
7. **Finish** — Cross the last gate. After 1st place finishes, a timer gives everyone else 30 seconds.
8. **Results** — Position, time, and reputation earned appear on screen.
9. **Hall of Fame** — Your lifetime stats contribute to the server-wide leaderboard.

---

## Route Editor (creators)

1. Type `/derbyedit` to open the editor panel.
2. Press **E** or **PgDn** to place a checkpoint at your current position.
3. Repeat to build the route — the track preview updates live.
4. Press **TAB** to edit route name, region, surface, player limits, AI settings.
5. Click **Save** to store in the database. It appears in **Player Races** for everyone.
6. Routes can be deleted by their creator from the Player Races tab.


---

## Configuration Reference (`config.lua`)

> **Escrow users:** `config.lua` is the only file you need to edit.

### Language / Notifications

```lua
Config.Locale = 'en'   -- 'en', 'pt', or any key you add to Config.Languages
```

Every `dodi_notifys` message is stored in `Config.Languages`. To translate:
1. Copy the `en` block.
2. Rename the key (e.g. `de`, `es`, `fr`).
3. Translate the strings. Placeholders like `%d` and `%s` must stay.
4. Set `Config.Locale` to your new key.

### Main Menu & Editor

```lua
Config.UI = {
    openCommand = 'derby',
    openDescription = 'Open Derby Horse racing menu',
}

Config.Editor = {
    openCommand = 'derbyedit',
    openDescription = 'Open Derby Horse race route editor',
}
```

### Catalog Routes (built-in races)

`Config.CatalogRoutes` is a list of pre-made routes that show up in the **Events** tab. Each entry has:

| Field | Type | Description |
|---|---|---|
| `id` | string | Unique route identifier |
| `name` | string | Display name |
| `region` | string | Map region label |
| `surface` | string | Terrain description |
| `minPlayers` | number | Minimum riders to auto-start |
| `maxPlayers` | number | Max riders in lobby |
| `aiEnabled` | boolean | Spawn AI opponents |
| `aiCount` | number | How many AI riders (max 8) |
| `checkpoints` | table | List of `{ x, y, z }` world coordinates |
| `closedLoop` | boolean | `true` = circuit (finish = start), `false` = point-to-point |

### Race Settings (`Config.DerbyRace`)

| Key | Default | What it does |
|---|---|---|
| `countdownSec` | `5` | Seconds of countdown before GO |
| `lockMountDuringCountdown` | `true` | Freeze horse during countdown |
| `arriveStartRadiusM` | `22.0` | Distance to CP1 to count as "at start" |
| `arriveStartZTol` | `40.0` | Vertical tolerance for start detection |
| `snapToStartLine` | `true` | Teleport rider behind CP1 facing CP2 |
| `startLineupBackM` | `7.5` | Meters back from CP1 |
| `randomizeStartGridDepth` | `true` | Shuffle grid positions |
| `reputationOrderedStartGrid` | `true` | Grid order by reputation |
| `startGridCompactRows` | `true` | Fill gate width side-by-side |
| `checkpointHorseBoostEnabled` | `true` | Speed boost on gate pass |
| `checkpointHorseBoostMultiplier` | `150.0` | Boost strength |
| `checkpointHorseBoostDurationMs` | `22000` | Boost duration (ms) |
| `leaderboardIntervalMs` | `100` | Server→NUI sync rate for leaderboard |

### AI Opponents (`Config.DerbyAI`)

| Key | Default | What it does |
|---|---|---|
| `enabled` | `true` | Spawn AI at all |
| `count` | `8` | Number of AI riders (max 8) |
| `spawnDuringCountdown` | `true` | Appear during 5-4-3... |
| `freezeDuringCountdown` | `true` | Freeze AI during countdown |
| `approachSpeed` | `15.0` | AI gallop speed (0.5–15) |
| `retaskMs` | `900` | How often AI re-evaluates path |
| `buffHorseAttributes` | `true` | Buff AI horse stats |
| `horseSpeedRank` | `10` | AI horse speed (0–10) |
| `horseAccelRank` | `10` | AI horse acceleration (0–10) |
| `stuckClearAfterMs` | `4200` | Time before AI unstuck |
| `stuckRecenterAfterMs` | `3000` | Time before AI teleport to route |
| `horseModels` | table | List of horse model names |
| `riderModels` | table | List of rider ped model names |

Full AI tuning (lane offset, lookahead, turn handling, etc.) is documented inline in `config.lua`.

### Gate / Checkpoint Flags (`Config.DerbyGate`)

| Key | Default | What it does |
|---|---|---|
| `checkpointRadius` | `5.0` | Distance to count "passed" |
| `checkpointPassExtraM` | `2.75` | Extra margin for pass detection |
| `checkpointHorizontal2D` | `true` | Ignore Z axis for pass check |
| `defaultHalfWidth` | `3.5` | Half-width of gate flags |

### Career / Reputation (`Config.DerbyCareer`)

Reputation (XP) is awarded after each race based on finishing position.

```lua
Config.DerbyCareer = {
    catalog = {                              -- Official (catalog) routes
        xpByPlace = { 50, 36, 28, 22, 16, 12, 8, 5 },
        winBonusXp = 20,                     -- Extra XP for 1st place
        dnfXp = 6,                           -- XP for "did not finish"
    },
    custom = {                               -- Player-created routes
        xpByPlace = { 38, 28, 20, 14, 10, 7, 5, 3 },
        winBonusXp = 12,
        dnfXp = 4,
    },
    handicapTitles = {                       -- Rank titles by reputation
        { minRep = 0,    title = 'Rookie' },
        { minRep = 150,  title = 'Novice Rider' },
        { minRep = 400,  title = 'Handicapper' },
        { minRep = 800,  title = 'Stakes Rider' },
        { minRep = 1500, title = 'Derby Veteran' },
        { minRep = 3000, title = 'Turf Champion' },
    },
}
```

Add/remove/rename titles freely — they appear in **Career** and **Hall of Fame**.

### Hall of Fame (`Config.DerbyHallOfFame`)

```lua
Config.DerbyHallOfFame = {
    topCount = 25,   -- How many riders to show (5–100)
}
```

Rider names update automatically when they race. Sorted by reputation (descending), then wins, then fewest starts.

### Lobby / Multiplayer (`Config.DerbyLobby`)

| Key | Default | What it does |
|---|---|---|
| `defaultMinPlayers` | `2` | Riders needed to auto-start |
| `defaultMaxPlayers` | `8` | Max lobby size |
| `readyTimeoutSec` | `300` | Lobby timeout if not enough riders (seconds) |
| `hostCanForceStart` | `true` | Host can press F4 to start early |
| `finishTimerSec` | `30` | Time after 1st finisher for others to cross |
| `aiFirstFinishWinnerName` | `'A rival'` | Text shown if AI finishes first |


---

## Database Tables (auto-created)

### `derby_player_career`

| Column | Type | Description |
|---|---|---|
| `citizenid` | VARCHAR(64) PK | Stable character key (RSG: `citizenid` · VORP: usually `charIdentifier` stored here) |
| `wins` | INT | Total 1st-place finishes |
| `starts` | INT | Total race entries |
| `reputation` | INT | Cumulative XP |
| `display_name` | VARCHAR(120) | Character name (auto-updated) |
| `updated_at` | DATETIME | Last modification |

### `derby_player_routes`

| Column | Type | Description |
|---|---|---|
| `id` | INT PK | Auto-increment |
| `route_key` | VARCHAR(120) UNIQUE | Internal key |
| `title` | VARCHAR(120) | Route name |
| `description` | TEXT | Route description |
| `region` | VARCHAR(80) | Map region |
| `surface` | VARCHAR(80) | Terrain type |
| `checkpoints` | LONGTEXT | JSON array of `{x,y,z}` |
| `closed_loop` | TINYINT | 0 = point-to-point, 1 = circuit |
| `min_players` | INT | Minimum riders |
| `max_players` | INT | Maximum riders |
| `ai_enabled` | TINYINT | AI on/off |
| `ai_count` | INT | Number of AI |
| `created_by` | VARCHAR(80) | Creator display name |
| `created_by_citizenid` | VARCHAR(64) | Creator character id (same semantics as `citizenid` column) |
| `created_at` | DATETIME | Creation timestamp |

---

## Exports

| Side | Export | Description |
|---|---|---|
| Client | `exports.dodi_derbyhorse:OpenDerbyMainUI()` | Open the NUI menu from another script |
| Client | `exports.dodi_derbyhorse:IsDerbyRaceActive()` | Returns `true` if player is in a race |
| Client | `exports.dodi_derbyhorse:IsPlacementActive()` | Returns `true` if gate preview is active |

---

## Troubleshooting

| Problem | Fix |
|---|---|
| Menu doesn't open | Put `ensure dodi_derbyhorse` **after** your framework (`rsg-core` or `vorp_core`) and **mysql-async** in `server.cfg` |
| "Lobby error" on host | Make sure the route has at least 2 checkpoints |
| AI don't spawn | Verify model names in `Config.DerbyAI.horseModels` and `riderModels` are valid |
| Names show "Rider" in Hall of Fame | Names update when players race — old entries before the update won't have names until they race again |
| Notifications in wrong language | Set `Config.Locale` to match a key in `Config.Languages` |
| Tables not created | Ensure `mysql-async` is running and the database connection is configured |

---

## License

Redistribution or reverse-engineering is prohibited.
