# MX-npcmedic

NPC medic / emergency call system for **RedM**. Players use a chat command (default `/callmedic`) to request a doctor NPC who travels to the downed player, plays a treatment animation, then revives them. Includes optional **RSG Core** and **VORP** bridges, real-medic job checks, cooldowns, and optional payment.

---

## Features

- **Command-based call** — Configurable command; server validates each request.
- **Real medic job gate** — Optionally block the NPC when enough players with the configured medic job are online (with duty support on RSG).
- **Minimum time dead** — Player must be dead for a configurable number of seconds before calling.
- **Cooldown** — Per-player cooldown after a successful call.
- **Payment (optional)** — Charge cash (RSG) or currency (VORP) on successful revive.
- **Immersion** — NPC spawns off-screen, walks or rides to the body, faces the player, uses a scenario animation, then revives **after** the animation.
- **Horse arrival (optional)** — Doctor can spawn far away, mount, ride in, dismount, treat, then remount and ride away (configurable).
- **Path recovery** — Repaths, move-rate tuning, and horse teleport recovery when navigation gets stuck.
- **Cleanup** — Session state, NPC/horse deletion on failure, disconnect, or resource stop.

---

## Requirements

| Dependency | Purpose |
|------------|---------|
| **ox_lib** | Notifications, callbacks, `lib.requestModel`, etc. |
| **rsg-core** | RSG framework (when `Config.Framework = 'auto'` or `'rsg'`) |
| **vorp_core** / **vorp_inventory** | VORP (when detected or forced) |

**Recommended (RSG):**

- `rsg-medic` — If `PreferRsgMedicRevive` is `true`, revives use `rsg-medic:client:playerRevive` for consistent metadata and HUD.

---

## Installation

1. Copy the `MX-npcmedic` folder into your `resources` directory.
2. Add to `server.cfg` (order matters):

   ```cfg
   ensure ox_lib
   ensure rsg-core
   ensure rsg-medic
   ensure MX-npcmedic
   ```

3. Adjust **`config.lua`** to match your server (command, job name, distances, prices).
4. Restart the server or `ensure MX-npcmedic`.

---

## Configuration Overview

All behaviour is driven by **`config.lua`**.

### Framework

| Option | Description |
|--------|-------------|
| `Config.Framework` | `'auto'`, `'rsg'`, or `'vorp'` — auto-detects RSG/VORP like other MX resources. |

### Command & timing

| Option | Description |
|--------|-------------|
| `Config.Command` | Chat command without `/` (default `callmedic`). |
| `Config.Cooldown` | Seconds before the same player can call again after a completed run. |
| `Config.SecondsDeadBeforeCall` | Minimum seconds dead before the command is allowed. |

### Real medics online

| Option | Description |
|--------|-------------|
| `Config.MedicJob` | Job name counted as a “real” medic (e.g. `medic`). |
| `Config.RequireMedicOnDuty` | RSG: only count medics **on duty**. |
| `Config.BlockIfMedicsOnline` | If `true`, NPC may be blocked when too many medics are online. |
| `Config.MaxMedicsOnlineAllowed` | Block when **online medic count > this value** (e.g. `0` = block if **any** medic is online). |

### NPC & movement

| Option | Description |
|--------|-------------|
| `MedicPedModel` | Doctor ped model. |
| `SpawnDistanceMin` / `SpawnDistanceMax` | Ring distance for spawn when **on foot**. |
| `SpawnDistanceMinHorse` / `SpawnDistanceMaxHorse` | Wider ring when **arriving on horse** (keeps spawn out of sight). |
| `PathTimeout` | Max time (ms) for approach pathfinding. |
| `TreatmentDuration` | Treatment animation length (ms). |
| `TreatmentScenario` | RedM scenario hash for treatment (e.g. crouch inspect). |

`TaskGoToEntity` uses **duration, stop distance, speed** in that order — do not swap distance and speed or the NPC may run instead of walk.

### Horse (optional)

| Option | Description |
|--------|-------------|
| `MedicArriveOnHorse` | Enable horse approach. |
| `MedicHorseModel` | Horse model (`a_c_horse_*`). |
| `MedicHorseStopDistance` | Stop distance to player before dismount. |
| `MedicHorseRideSpeed` | Ride speed parameter for `TaskGoToEntity` on the horse. |
| `MedicHorseRepathAttempts` | How many task re-issues before teleport recovery. |
| `MedicHorseTeleportRecoveryMax` | Max teleport steps toward the player if stuck. |
| `MedicHorseTeleportStep` | Meters per teleport step. |
| `MedicHorseStuckFailMs` | Time without progress after teleports exhausted → fail. |
| `MedicDeleteHorseAfterDismount` | If `true`, deletes horse at dismount (incompatible with leaving on horse). |
| `MedicDepartOnHorse` | After revive, walk to horse, remount, ride away, then delete both. |

### Departure

| Option | Description |
|--------|-------------|
| `PostRevivePauseMs` | Pause after revive before leaving. |
| `DepartWalkDistance` / `DepartWalkSpeed` | On-foot leave distance and speed. |
| `DepartRideDistance` / `DepartRideSpeed` | Horse leave distance and speed when `MedicDepartOnHorse` is on. |
| `DepartWalkTimeoutMs` | Max wait for arrival at leave point. |
| `DepartFadeOut` | Fade entities before delete. |

### Payment & revive

| Option | Description |
|--------|-------------|
| `UsePayment` / `Price` | Enable charge and amount. |
| `RsgMoneyType` | RSG money type (e.g. `cash`). |
| `ReviveHealthPercent` | Used for generic revive when not using `rsg-medic`. |
| `PreferRsgMedicRevive` | Use `rsg-medic` client revive when resource is running (RSG). |

### Notifications

| Option | Description |
|--------|-------------|
| `NotifyType` | `ox_lib` or fallback chat. |
| `NotifyTitleEnRoute` / `NotifyDurationEnRoute` | Title and duration for the “medic en route” alert. |
| `Config.Messages.*` | All user-facing strings (edit for your language). |

### Debug

| Option | Description |
|--------|-------------|
| `Config.Debug` | Extra prints on client/server (disable on production). |

---

## How It Works (Flow)

1. Player runs **`/callmedic`** (or your configured command).
2. **Server** checks: session not busy, cooldown, death time, medic count vs limits, money if payment enabled.
3. **Client** shows “medic en route” notification, finds a spawn point, creates ped (and horse if enabled).
4. **Approach** — On foot: `TaskGoToEntity` with correct parameters; on horse: mount, `TaskGoToEntity` on the **horse**, dismount near player, optional short walk to body.
5. **Treatment** — Scenario plays for `TreatmentDuration`; then **server** triggers revive (`rsg-medic` or generic client revive) and charges money if configured.
6. **Leave** — On foot and/or remount horse per config; fade optional; entities deleted.

---

## Troubleshooting

- **NPC runs instead of walks** — Check `NpcWalkSpeed`, `NpcGoToEntityStopDistance`, and `NpcMoveRateOverride`; ensure distance/speed are not swapped in custom edits.
- **Horse gets stuck** — Increase `MedicHorseTeleportRecoveryMax`, `MedicHorseTeleportStep`, or `PathTimeout`; reduce spawn distance if the route is impossible.
- **NPC medic blocked** — Adjust `MaxMedicsOnlineAllowed`, `BlockIfMedicsOnline`, or `MedicJob` to match your server jobs.
- **Revive wrong / no metadata** — Ensure `rsg-medic` is started and `PreferRsgMedicRevive` is `true` on RSG.

---

## File Structure

```
MX-npcmedic/
  fxmanifest.lua
  config.lua
  shared/framework.lua   # RSG / VORP auto-detection
  client/client.lua      # Spawn, path, animations, revive client logic
  server/server.lua      # Validation, medic count, payment, commands
  README.md
```

---

## Version

**1.0.0** — See `fxmanifest.lua` for metadata.

---

## License / Credits

Author: **MX**. Configure and use in accordance with your server rules and framework licenses.
