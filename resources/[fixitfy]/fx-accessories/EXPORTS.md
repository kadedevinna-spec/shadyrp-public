# FX-Accessories — Exports

All exports are **server-side** only.

---

## isAttached
Returns whether an item is currently attached to a player.
```lua
-- returns: boolean
exports['fx-accessories']:isAttached(serverId, itemName)
```

## getAttachments
Returns a table of all items attached to a player.
```lua
-- returns: table { [itemName] = true, ... } or {}
exports['fx-accessories']:getAttachments(serverId)
```

## attachItem
Attaches an item to a player. Applies all normal checks (gender, limit, RequireItem).
```lua
-- returns: boolean (false if invalid params)
exports['fx-accessories']:attachItem(serverId, itemName)
```

## removeItem
Removes an attached item from a player.
```lua
-- returns: boolean (false if item was not attached)
exports['fx-accessories']:removeItem(serverId, itemName)
```

---

## Examples

```lua
-- Check if player has an item attached
if exports['fx-accessories']:isAttached(source, "blackbag") then
    -- do something
end

-- Remove all attachments from a player
local items = exports['fx-accessories']:getAttachments(source)
for itemName in pairs(items) do
    exports['fx-accessories']:removeItem(source, itemName)
end

-- Attach an item from another resource
exports['fx-accessories']:attachItem(source, "blackbag")
```

---

> `itemName` must match a key in `Config.Items` (case-sensitive).  
> `serverId` is `source` on the server or `GetPlayerServerId(PlayerId())` on the client.
