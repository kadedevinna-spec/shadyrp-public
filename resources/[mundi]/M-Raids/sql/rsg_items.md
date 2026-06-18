# M-Raids — RSG Items Setup

RSG Framework items, all of these are optional and feel free to change them as you see fit, but these are the items used in the M-Raids script. If you want to use the same items, add them to your items list. If you want to change them, make sure to change the item names in the script config as well.

```
resources/[framework]/rsg-core/shared/items.lua
```

---

## How to add

Open `items.lua` and paste the entries below **inside** the existing items table (before the closing `}`).

---

## Items to add

```lua
    -- =========================================================================
    -- M-Raids Items
    -- =========================================================================

    -- Fence Trade Items
    intel_folder                    = { name = 'intel_folder',                    label = 'Intel Folder',                         weight = 100,  type = 'item', image = 'intel_folder.png',                    unique = false, useable = false, decay = nil, delete = true, shouldClose = false, combinable = nil, description = 'A folder containing important documents' },
    route_plans                     = { name = 'route_plans',                     label = 'Route Plans',                          weight = 100,  type = 'item', image = 'route_plans.png',                     unique = false, useable = true,  decay = nil, delete = true, shouldClose = false, combinable = nil, description = 'A route map for a final destination' },

    -- Robbery Tools
    dynamite                        = { name = 'dynamite',                        label = 'Dynamite',                             weight = 250,  type = 'ammo', image = 'dynamite.png',                        unique = false, useable = true,  shouldClose = true, description = 'Big dynamite, a good thing for opening safes' },
    lockpick                        = { name = 'lockpick',                        label = 'Lockpick',                             weight = 50,   type = 'item', image = 'lockpick.png',                        unique = false, useable = true,  shouldClose = true, description = 'A tool used to pick locks' },

    -- Loot Items
    moneybag                        = { name = 'moneybag',                        label = 'Money Bag',                            weight = 50,   type = 'item', image = 'moneybag.png',                        unique = false, useable = true,  shouldClose = true, description = 'A bag full of loot' },
    goldbar                         = { name = 'goldbar',                         label = 'Gold Bar',                             weight = 50,   type = 'item', image = 'goldbar.png',                         unique = false, useable = true,  shouldClose = true, description = 'A common gold ingot' },

    -- Raid Collectible / Intel Items
    crim_raid_torn_map              = { name = 'crim_raid_torn_map',              label = 'Torn Map',                             weight = 250,  type = 'item', image = 'crim_raid_torn_map.png',              unique = false, useable = false, shouldClose = true, description = 'A ripped map that seems to lead to a long abandoned mine.' },
    crim_raid_doolin_will           = { name = 'crim_raid_doolin_will',           label = "Grady Doolin's Last Will & Testament", weight = 150,  type = 'item', image = 'crim_raid_doolin_will.png',           unique = false, useable = false, shouldClose = true, description = 'A partially destroyed document.' },
    crim_raid_mining_records        = { name = 'crim_raid_mining_records',        label = 'Black Heaths Mining Records',          weight = 200,  type = 'item', image = 'crim_raid_mining_records.png',        unique = false, useable = false, shouldClose = true, description = 'A record detailing an abandoned mine up north.' },
    crim_raid_explosives_high       = { name = 'crim_raid_explosives_high',       label = 'High Quality Explosives',              weight = 2500, type = 'item', image = 'crim_raid_explosives_high.png',       unique = false, useable = false, shouldClose = true, description = 'A bundle of high-grade mining charges.' },
    crim_raid_fort_mercer_schedule  = { name = 'crim_raid_fort_mercer_schedule',  label = 'Fort Mercer Shift Schedule',           weight = 100,  type = 'item', image = 'crim_raid_fort_mercer_schedule.png',  unique = false, useable = false, shouldClose = true, description = 'A shift schedule for Fort Mercer.' },
    crim_raid_prototype_order       = { name = 'crim_raid_prototype_order',       label = 'Prototype Weapon Parts Order',         weight = 150,  type = 'item', image = 'crim_raid_prototype_order.png',       unique = false, useable = false, shouldClose = true, description = 'An order requesting prototype weapon shipments.' },
    crim_raid_fort_wallace_schedule = { name = 'crim_raid_fort_wallace_schedule', label = 'USMO Fort Wallace Schedule',           weight = 100,  type = 'item', image = 'crim_raid_fort_wallace_schedule.png', unique = false, useable = false, shouldClose = true, description = 'A USMO shift schedule containing valuable intel.' },
    crim_raid_shipping_ledger       = { name = 'crim_raid_shipping_ledger',       label = 'Red Star Line Shipping Ledger',        weight = 300,  type = 'item', image = 'crim_raid_shipping_ledger.png',       unique = false, useable = false, shouldClose = true, description = 'A ledger for a classified delivery at Saint Denis docks.' },
    crim_raid_burned_letter         = { name = 'crim_raid_burned_letter',         label = 'A Letter Partly Burned',               weight = 100,  type = 'item', image = 'crim_raid_burned_letter.png',         unique = false, useable = false, shouldClose = true, description = 'A letter detailing a shady deal between local officials and the Braithwaites.' },
    crim_raid_braithwaite_key       = { name = 'crim_raid_braithwaite_key',       label = 'Braithwaite Key',                      weight = 50,   type = 'item', image = 'crim_raid_braithwaite_key.png',       unique = false, useable = false, shouldClose = true, description = 'A key engraved with the Braithwaite family crest.' },
```