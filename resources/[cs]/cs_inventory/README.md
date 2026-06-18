# cs_inventory

Custom inventory UI for RedM — replaces vorp_inventory's NUI while keeping all its server-side logic intact.

---

## Requirements

- `vorp_core`
- `vorp_inventory` — **must use the patched version included in this package**
- `vorp_character`

---

## Installation

### Step 1 — Configure cs_inventory

Edit `cs_inventory/config.lua`:

```lua
Config = {
    ServerName      = "Your Server Name",  -- displayed in the UI header
    Lang            = 'en',               -- 'en' or 'fr'
    ClothingEnabled = true,               -- show clothing panel in inventory
}
```

---

### Step 2 — server.cfg

`cs_inventory` **must be ensured before** `vorp_inventory`:

```
ensure cs_inventory
ensure vorp_inventory
```

> If the order is wrong, vorp_inventory starts first and never hands off to cs_inventory.
> The inventory will either not open or open vorp's default UI instead of ours.

---

## What was patched in vorp_inventory

Two files need to be modified. If you are using the vorp_inventory included in this package, this is already done — skip this section.

If you updated vorp_inventory and need to re-apply the patches manually, follow the steps below.

---

### Patch 1 — `client/services/nuiService.lua`

Open the file and search for this line:

```lua
NUIService.OpenInv()
```

It appears inside the key press block that detects the `OpenKey` (I key). The surrounding context looks like this:

```lua
if not hogtied and not cuffed and not InventoryIsDisabled then
    -- ... optional walking code ...
        NUIService.OpenInv()   -- ← find this line
    end
end
```

Replace **only that line** with:

```lua
if GetResourceState('cs_inventory') == 'started' then
    TriggerEvent('cs_inventory:openInv')
else
    NUIService.OpenInv()
end
```

Without this patch → pressing I opens vorp's default NUI instead of cs_inventory.

---

### Patch 2 — `client/exports.lua`

Open the file and **add the following block at the very end**, after all existing exports:

```lua
-- cs_inventory: returns all items + weapons with full type info
exports('getFullInventory', function()
    if not UserInventory and not UserWeapons then return {} end
    local all = {}

    if UserInventory then
        for id, item in pairs(UserInventory) do
            local meta = item:getMetadata() or {}
            table.insert(all, {
                id             = id,
                name           = item:getName(),
                label          = meta.label or item:getLabel(),
                count          = item:getCount(),
                limit          = item:getLimit(),
                weight         = meta.weight or item:getWeight(),
                metadata       = meta,
                desc           = meta.description or item:getDesc(),
                type           = "item_standard",
                group          = item.group or 1,
                degradation    = item:getDegradation(),
                maxDegradation = item:getMaxDegradation(),
            })
        end
    end

    if UserWeapons then
        for _, weapon in pairs(UserWeapons) do
            table.insert(all, {
                id     = weapon:getId(),
                name   = weapon:getName(),
                label  = weapon:getCustomLabel() or weapon:getLabel(),
                count  = weapon:getTotalAmmoCount(),
                limit  = -1,
                weight = weapon:getWeight(),
                type   = "item_weapon",
                group  = 5,
                hash   = GetHashKey(weapon:getName()),
                used   = weapon:getUsed(),
                used2  = weapon:getUsed2(),
                serial = weapon:getSerialNumber(),
                desc   = weapon:getCustomDesc() or weapon:getDesc(),
            })
        end
    end

    return all
end)
```

Without this patch → cs_inventory cannot load the item list and the inventory will be empty.
