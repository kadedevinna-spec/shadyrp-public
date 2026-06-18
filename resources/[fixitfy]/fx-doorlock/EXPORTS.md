# FX-Doorlock — Server Exports

All exports are called from the **server side**.

---

## addDoorPermission

Grants a player (by server ID) permission to lock/unlock a specific door by name.  
The player's `charId` is resolved automatically via the framework and added permanently to the door's `charIds` list.

```lua
local result = exports['fx-doorlock']:addDoorPermission(source, doorname)
```

| Parameter  | Type     | Description                                        |
|------------|----------|----------------------------------------------------|
| `source`   | `number` | Server ID of the player to grant access to         |
| `doorname` | `string` | Door name as defined in fx-doorlock (`name` field) |

**Return value:**

| Value   | Meaning                                                          |
|---------|------------------------------------------------------------------|
| `true`  | Permission granted successfully (or was already present)         |
| `false` | No door found with the given name                                |
| `nil`   | Could not resolve the player's charId (player offline / invalid) |

**Example — house script:**
```lua
-- Call when a player purchases a house
local ok = exports['fx-doorlock']:addDoorPermission(source, 'house_bluewater_101_front')
if ok == true then
    -- permission granted
elseif ok == false then
    print('Door not found')
elseif ok == nil then
    print('Could not resolve charId')
end
```

> **Note:** The change is written to `saved_doors.lua` and synced to all clients immediately.  
> If the door has other restrictions (job, group, metalKey), this export only opens the charId channel — the others remain in place.

---

## canAccessDoor

Checks whether a player has access to a specific door without toggling it.

```lua
local result = exports['fx-doorlock']:canAccessDoor(source, doorId)
```

| Parameter | Type     | Description          |
|-----------|----------|----------------------|
| `source`  | `number` | Player's server ID   |
| `doorId`  | `number` | Door ID              |

**Return value:** `true` / `false` / `nil` (door not found)

---

## setDoorLocked

Locks or unlocks a door programmatically. Synced to all clients.

```lua
local ok = exports['fx-doorlock']:setDoorLocked(doorId, locked)
```

| Parameter | Type     | Description                        |
|-----------|----------|------------------------------------|
| `doorId`  | `number` | Door ID                            |
| `locked`  | `bool`   | `true` = lock, `false` = unlock    |

**Return value:** `true` on success, `false` if door not found.

---

## addCharId

Adds a `charId` directly to a door's access list by door ID.

```lua
local ok = exports['fx-doorlock']:addCharId(doorId, charId)
```

---

## removeCharId

Removes a `charId` from a door's access list by door ID.

```lua
local ok = exports['fx-doorlock']:removeCharId(doorId, charId)
```

---

## getDoor

Returns the door's runtime data table (read-only reference).

```lua
local door = exports['fx-doorlock']:getDoor(doorId)
```

---

## getAllDoors

Returns all doors' runtime data table (read-only reference).

```lua
local doors = exports['fx-doorlock']:getAllDoors()
```
