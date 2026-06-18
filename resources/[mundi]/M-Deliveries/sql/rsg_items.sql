
--     ═══════════════════════════════════════════════════════════════════════════
--     M-Deliveries RSG Framework Items
--     ═══════════════════════════════════════════════════════════════════════════
    
--     Copy/paste these entries into your rsg-core/shared/items.lua file,
--     inside the RSGShared.Items = { } table.
    
--     After adding items, restart rsg-core or the whole server.
    
--     NOTE: cured_hemp, moonshine_original, moonshine_blueflame, and moonshine_red
--     may already exist if you have other scripts (e.g. fx-moonshinev2, btc-harvest).
--     Check your items.lua before adding duplicates.
--     ═══════════════════════════════════════════════════════════════════════════


-- ═══════════════════════════════════════════════════
-- DELIVERY PACKAGES
-- ═══════════════════════════════════════════════════

delivery_package_small  = { name = 'delivery_package_small',  label = 'Small Crate',          weight = 500,  type = 'item', image = 'delivery_package_small.png',  unique = false, useable = false, decay = nil, delete = true, shouldClose = false, combinable = nil, description = 'A small delivery crate' },
delivery_package_medium = { name = 'delivery_package_medium', label = 'Medium Crate',         weight = 1000, type = 'item', image = 'delivery_package_medium.png', unique = false, useable = false, decay = nil, delete = true, shouldClose = false, combinable = nil, description = 'A medium delivery crate' },
delivery_package_large  = { name = 'delivery_package_large',  label = 'Large Crate',          weight = 1500, type = 'item', image = 'delivery_package_large.png',  unique = false, useable = false, decay = nil, delete = true, shouldClose = false, combinable = nil, description = 'A large delivery crate' },
delivery_package_big    = { name = 'delivery_package_big',    label = 'Special Crate',        weight = 2000, type = 'item', image = 'delivery_package_big.png',    unique = false, useable = false, decay = nil, delete = true, shouldClose = false, combinable = nil, description = 'A special heavy delivery crate' },

-- ═══════════════════════════════════════════════════
-- AGRICULTURAL GOODS
-- ═══════════════════════════════════════════════════

delivery_sugar_sack = { name = 'delivery_sugar_sack', label = 'Sugar Sack', weight = 1200, type = 'item', image = 'delivery_sugar_sack.png', unique = false, useable = false, decay = nil, delete = true, shouldClose = false, combinable = nil, description = 'A sack of sugar for delivery' },
delivery_grain_sack = { name = 'delivery_grain_sack', label = 'Grain Sack', weight = 1200, type = 'item', image = 'delivery_grain_sack.png', unique = false, useable = false, decay = nil, delete = true, shouldClose = false, combinable = nil, description = 'A sack of grain for delivery' },

-- ═══════════════════════════════════════════════════
-- BARRELS
-- ═══════════════════════════════════════════════════

delivery_barrel     = { name = 'delivery_barrel',     label = 'Barrel',     weight = 1800, type = 'item', image = 'delivery_barrel.png',     unique = false, useable = false, decay = nil, delete = true, shouldClose = false, combinable = nil, description = 'A delivery barrel' },
delivery_oil_barrel = { name = 'delivery_oil_barrel', label = 'Oil Barrel', weight = 1800, type = 'item', image = 'delivery_oil_barrel.png', unique = false, useable = false, decay = nil, delete = true, shouldClose = false, combinable = nil, description = 'A barrel of oil for delivery' },

-- ═══════════════════════════════════════════════════
-- ILLEGAL CONTRABAND
-- ═══════════════════════════════════════════════════

delivery_moonshine_crate = { name = 'delivery_moonshine_crate', label = 'Moonshine Crate', weight = 1500, type = 'item', image = 'delivery_moonshine_crate.png', unique = false, useable = false, decay = nil, delete = true, shouldClose = false, combinable = nil, description = 'A crate packed with moonshine bottles' },
delivery_hemp_crate      = { name = 'delivery_hemp_crate',      label = 'Hemp Crate',      weight = 1200, type = 'item', image = 'delivery_hemp_crate.png',      unique = false, useable = false, decay = nil, delete = true, shouldClose = false, combinable = nil, description = 'A crate packed with cured hemp' },

-- ═══════════════════════════════════════════════════
-- UTILITY ITEMS
-- ═══════════════════════════════════════════════════

crated = { name = 'crated', label = 'Crate', weight = 300, type = 'item', image = 'crated.png', unique = false, useable = false, decay = nil, delete = true, shouldClose = false, combinable = nil, description = 'An empty wooden crate, used for packing goods' },

-- ═══════════════════════════════════════════════════
-- SMUGGLING MATERIALS (player-provided items)
-- These may already exist from other scripts — check before adding!
-- ═══════════════════════════════════════════════════

cured_hemp          = { name = 'cured_hemp',          label = 'Cured Hemp',            weight = 50,  type = 'item', image = 'cured_hemp.png',          unique = false, useable = false, decay = nil, delete = true, shouldClose = false, combinable = nil, description = 'Dried and cured hemp, ready for transport' },
moonshine_original  = { name = 'moonshine_original',  label = 'Moonshine Original',    weight = 200, type = 'item', image = 'moonshine_original.png',  unique = false, useable = true,  decay = nil, delete = true, shouldClose = true,  combinable = nil, description = 'A bottle of original moonshine' },
moonshine_blueflame = { name = 'moonshine_blueflame', label = 'Moonshine Blueflame',   weight = 200, type = 'item', image = 'moonshine_blueflame.png', unique = false, useable = true,  decay = nil, delete = true, shouldClose = true,  combinable = nil, description = 'A bottle of strong blue flame moonshine' },
moonshine_red       = { name = 'moonshine_red',       label = 'Moonshine Red',         weight = 200, type = 'item', image = 'moonshine_red.png',       unique = false, useable = true,  decay = nil, delete = true, shouldClose = true,  combinable = nil, description = 'A bottle of premium red moonshine' },

-- ═══════════════════════════════════════════════════
-- REPAIR MATERIALS
-- These may already exist from other scripts — check before adding!
-- ═══════════════════════════════════════════════════

wood_plank = { name = 'wood_plank', label = 'Wood Plank', weight = 300, type = 'item', image = 'wood_plank.png', unique = false, useable = false, decay = nil, delete = true, shouldClose = false, combinable = nil, description = 'A sturdy wooden plank, useful for repairs' },
nails      = { name = 'nails',      label = 'Nails',      weight = 100, type = 'item', image = 'nails.png',      unique = false, useable = false, decay = nil, delete = true, shouldClose = false, combinable = nil, description = 'A handful of iron nails for construction and repairs' },