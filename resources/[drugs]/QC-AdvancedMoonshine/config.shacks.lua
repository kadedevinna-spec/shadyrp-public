-- ═══════════════════════════════════════════════════════════════
--  MOONSHINE SHACK CONFIGURATION
-- ═══════════════════════════════════════════════════════════════

Config.Shacks = {
    Enabled = true,

    -- Unified shack settings (no more tier categorization)
    DefaultSettings = {
        MaxStills = 6,  -- Unified max
        MaxBarStock = 200,
        Price = 1000,  -- Changed from 2500 (1890s RedM pricing)

        -- NPC models for all shack employees (shared across all shacks)
        NPCModels = {
            manager = 'mp_outlaw1_males_01',
            master_brewer = 'mp_a_m_m_moonshinemakers_01',
            delivery_man = 'a_m_m_moonshiners_01',
            stocker = 'a_m_m_moonshiners_01'
        }
    },

    -- Rentable Shack Locations Around The Map
    Locations = {
        -- Lemoyne Shack
        {
            id = 1,
            name = "Lemoyne Moonshine Shack",
            entrance = vector3(1784.90, -821.65, 42.86), -- Teleport entrance point
            interior = vector4(1785.01, -821.53, 191.01, 314.72), -- Inside coords
            exit = vector3(1785.03, -821.38, 192.60), -- Exit point inside
            outside = vector4(1784.65, -821.87, 42.86, 134.88), -- Exit destination outside
            interior_id = 77313, -- RDR3 interior ID for entity sets (VERIFIED)
            entity_prefix = "mp006", -- Entity set prefix for this interior
            imaps = {0xCB28C7F6, 0x0FE8850C, 0x8BE643CA}, -- Required IMaps for interior
            blip = {
                sprite = 'blip_business_moonshine',
                scale = 0.2,
                name = "Moonshine Shack"
            },
            npcs = {
                manager = vector4(1792.48, -814.39, 191.60, 133.30),
                brewer = vector4(1793.44, -819.45, 189.40, 10.02),
                delivery = vector4(1790.55, -818.81, 188.40, 12.84),
                stocker = vector4(1786.47, -814.59, 188.40, 251.16)
            },
            interactions = {
                -- Distillery/brewing equipment interaction point
                distillery = vector4(1794.97, -819.48, 189.88, 223.4),
                -- Storage stash interaction points (activated when shelf_wall upgrades are purchased)
                storage_1 = vector4(1793.29, -815.59, 189.40, 313.40),
                storage_2 = vector4(1790.13, -811.99, 189.40, 291.81)
            },
            supplies_dropoff = vector3(1787.6, -827.8, 41.5),
            delivery_wagon = vector4(1780.0, -830.0, 41.5, 135.0) -- Wagon spawn for telegram deliveries
        },
        -- Cattail Pond Shack
        {
            id = 2,
            name = "Cattail Pond Moonshine Shack",
            entrance = vector3(-1085.63, 714.14, 103.32),
            interior = vector4(-1085.63, 714.14, 84.23, 104.45),
            exit = vector3(-1085.63, 714.14, 84.23),
            outside = vector4(-1085.63, 714.14, 104.32, 303.27),
            interior_id = 77569, -- RDR3 interior ID for entity sets
            entity_prefix = "mp007", -- Entity set prefix for this interior
            imaps = {0xCB28C7F6, 0x0FE8850C, 0x8BE643CA}, -- Required IMaps for interior
            blip = {
                sprite = 'blip_business_moonshine',
                scale = 0.2,
                name = "Moonshine Shack"
            },
            npcs = {
                manager = vector4(-1094.73, 710.22, 83.23, 300.89),
                brewer = vector4(-1095.54, 714.19, 80.04, 240.17),
                delivery = vector4(-1083.28, 709.58, 103.20, 211.12),
                stocker = vector4(-1090.50, 706.00, 80.04, 180.00)
            },
            interactions = {
                -- TODO: Add coordinates for Cattail Pond shack
                distillery = vector4(0.0, 0.0, 0.0, 0.0),
                storage_1 = vector4(0.0, 0.0, 0.0, 0.0),
                storage_2 = vector4(0.0, 0.0, 0.0, 0.0)
            },
            supplies_dropoff = vector3(-1080.5, 709.0, 103.0),
            delivery_wagon = vector4(-1078.0, 710.0, 103.0, 110.0) -- Wagon spawn for telegram deliveries
        },
        -- New Austin Shack
        {
            id = 3,
            name = "New Austin Moonshine Shack",
            entrance = vector3(-2769.23, -3048.90, 11.38),
            interior = vector4(-2769.34, -3048.75, -8.70, 60.58),
            exit = vector3(-2769.3, -3048.87, -9.7),
            outside = vector4(-2769.35, -3049.00, 11.38, 243.99),
            interior_id = 78337, -- RDR3 interior ID for entity sets
            entity_prefix = "mp007", -- Entity set prefix for this interior
            imaps = {0xCB28C7F6, 0x0FE8850C, 0x8BE643CA}, -- Required IMaps for interior
            blip = {
                sprite = 'blip_business_moonshine',
                scale = 0.2,
                name = "Moonshine Shack"
            },
            npcs = {
                manager = vector4(-2777.85, -3044.20, -12.70, 244.63),
                brewer = vector4(-2775.51, -3040.88, -12.90, 190.72),
                delivery = vector4(-2767.49, -3045.85, 10.28, 241.52),
                stocker = vector4(-2772.00, -3048.00, -12.90, 200.00)
            },
            interactions = {
                -- TODO: Add coordinates for New Austin shack
                distillery = vector4(0.0, 0.0, 0.0, 0.0),
                storage_1 = vector4(0.0, 0.0, 0.0, 0.0),
                storage_2 = vector4(0.0, 0.0, 0.0, 0.0)
            },
            supplies_dropoff = vector3(-2767.0, -3043.0, 10.0),
            delivery_wagon = vector4(-2765.0, -3040.0, 10.0, 90.0) -- Wagon spawn for telegram deliveries
        },
        -- Hanover Shack
        {
            id = 4,
            name = "Hanover Moonshine Shack",
            entrance = vector3(1627.64, 822.9, 144.03),
            interior = vector4(1627.64, 822.9, 123.94, 0.0),
            exit = vector3(1627.64, 822.9, 123.94),
            outside = vector4(1627.64, 822.9, 144.03, 151.71),
            interior_id = 78593, -- RDR3 interior ID for entity sets
            entity_prefix = "mp007", -- Entity set prefix for this interior
            imaps = {0xCB28C7F6, 0x0FE8850C, 0x8BE643CA}, -- Required IMaps for interior
            blip = {
                sprite = 'blip_business_moonshine',
                scale = 0.2,
                name = "Moonshine Shack"
            },
            npcs = {
                manager = vector4(1631.62, 832.22, 123.94, 162.12),
                brewer = vector4(1635.06, 829.67, 120.74, 94.06),
                delivery = vector4(1630.19, 820.30, 143.78, 154.96),
                stocker = vector4(1628.00, 827.00, 120.74, 120.00)
            },
            interactions = {
                -- TODO: Add coordinates for Hanover shack
                distillery = vector4(0.0, 0.0, 0.0, 0.0),
                storage_1 = vector4(0.0, 0.0, 0.0, 0.0),
                storage_2 = vector4(0.0, 0.0, 0.0, 0.0)
            },
            supplies_dropoff = vector3(1630.0, 818.0, 143.5),
            delivery_wagon = vector4(1628.0, 815.0, 143.5, 200.0) -- Wagon spawn for telegram deliveries
        },
        -- Manzanita Post Shack
        {
            id = 5,
            name = "Manzanita Post Moonshine Shack",
            entrance = vector3(-1861.7, -1722.17, 108.35),
            interior = vector4(-1861.70, -1722.17, 89.25, 152.63),
            exit = vector3(-1861.7, -1722.17, 88.35),
            outside = vector4(-1861.7, -1722.17, 108.35, 0.0),
            interior_id = 79105, -- RDR3 interior ID for entity sets
            entity_prefix = "mp006", -- Entity set prefix for this interior
            imaps = {0xCB28C7F6, 0x0FE8850C, 0x8BE643CA}, -- Required IMaps for interior
            blip = {
                sprite = 'blip_business_moonshine',
                scale = 0.2,
                name = "Moonshine Shack"
            },
            npcs = {
                manager = vector4(-1866.81, -1731.36, 88.25, 332.88),
                brewer = vector4(-1869.98, -1728.49, 85.06, 284.52),
                delivery = vector4(-1858.77, -1722.22, 108.24, 331.18),
                stocker = vector4(-1863.00, -1726.00, 85.06, 300.00)
            },
            interactions = {
                -- TODO: Add coordinates for Manzanita Post shack
                distillery = vector4(0.0, 0.0, 0.0, 0.0),
                storage_1 = vector4(0.0, 0.0, 0.0, 0.0),
                storage_2 = vector4(0.0, 0.0, 0.0, 0.0)
            },
            supplies_dropoff = vector3(-1857.0, -1725.0, 108.0),
            delivery_wagon = vector4(-1855.0, -1727.0, 108.0, 330.0) -- Wagon spawn for telegram deliveries
        }
    }
}

-- ═══════════════════════════════════════════════════════════════
--  INTERIOR UPGRADES (ENTITY SETS)
--  Order: Equipment → Storage → Shack Expansions
-- ═══════════════════════════════════════════════════════════════

Config.InteriorUpgrades = {
    -- 1. BREWING EQUIPMENT (First in menu)
    equipment = {
        label = "Brewing Equipment",
        icon = "upgrade",
        description = "Upgrade your moonshine production equipment",
        slot_limit = 1, -- Only 1 still configuration active
        upgrades = {
            {
                id = "still_01",
                name = "Basic Still",
                description = "Standard moonshine distillation setup",
                entity_set = "mp006_mshine_Still_01",
                icon = "upgrade",
                cost = 300,
                reputation_required = 0, -- Starting equipment
                benefits = "Standard production rate",
                production = {
                    speed_multiplier = 1.0, -- Base speed
                    batch_size = 2, -- Multiplier per brew (2x portable still output)
                    max_batches = 6, -- Max ingredient batches at once
                    quality = "standard" -- standard/high/premium
                }
            },
            {
                id = "still_02",
                name = "Improved Still",
                description = "Enhanced distillation equipment",
                entity_set = "mp006_mshine_Still_02",
                icon = "upgrade",
                cost = 600,
                reputation_required = 200,
                benefits = "+10% production speed",
                production = {
                    speed_multiplier = 1.1, -- 10% faster
                    batch_size = 2, -- Multiplier per brew (2x portable still output)
                    max_batches = 10, -- Max ingredient batches at once
                    quality = "standard"
                }
            },
            {
                id = "still_03",
                name = "Advanced Still",
                description = "Professional-grade distillation system",
                entity_set = "mp006_mshine_Still_03",
                icon = "upgrade",
                cost = 1000,
                reputation_required = 400,
                benefits = "+20% production speed, higher quality",
                production = {
                    speed_multiplier = 1.2, -- 20% faster
                    batch_size = 2, -- Multiplier per brew (2x portable still output)
                    max_batches = 16, -- Max ingredient batches at once
                    quality = "high"
                }
            },
        }
    },

    -- 2. STORAGE (Second in menu) - Note: Labels are swapped from IDs
    storage = {
        label = "Storage Props",
        icon = "upgrade",
        description = "Add storage shelves to your shack",
        slot_limit = 10, -- Can own both shelves
        upgrades = {
            {
                id = "shelf_wall_1", -- ID is shelf_wall_1 but labeled as #2
                name = "Wall Shelving #1",
                description = "Display shelves for bottles and supplies - adds storage access point",
                entity_set = "mp006_mshine_shelfwall1",
                icon = "upgrade",
                cost = 300,
                reputation_required = 0,
                benefits = "Adds storage stash access"
            },
            {
                id = "shelf_wall_2", -- ID is shelf_wall_2 but labeled as #1
                name = "Wall Shelving #2",
                description = "Premium display shelving - adds storage access point",
                entity_set = "mp006_mshine_shelfwall2",
                icon = "upgrade",
                cost = 500,
                reputation_required = 100,
                benefits = "Adds storage stash access"
            }

        }
    },

    -- 3. SHACK EXPANSIONS (Third in menu - has subcategories)
    expansions = {
        label = "Shack Expansions",
        icon = "upgrade",
        description = "Expand your shack to unlock new areas and features",

        -- Subcategories within expansions
        categories = {
            -- Saloon Expansion (main expansion)
            saloon = {
                label = "Saloon Expansion",
                icon = "upgrade",
                description = "Requires 500 Reputation to be able to purchase",
                slot_limit = 2, -- Expansion + wall removal
                upgrades = {
                    {
                        id = "expansion_saloon",
                        name = "Saloon Expansion",
                        description = "Remove the blockade and expand into a full saloon with entertainment area",
                        entity_set = "mp006_mshine_still_blockoff1",
                        icon = "upgrade",
                        cost = 1500,
                        reputation_required = 500,
                        benefits = "Unlocks Entertainment, Decorations, and Themes",
                        removes_on_activate = true -- This entity set should be REMOVED, not added
                    },
                    {
                        id = "band_1b",
                        name = "Remove Entertainment Wall",
                        description = "Remove the wall blocking the entertainment area (reveals piano area)",
                        entity_set = "mp006_mshine_band1b",
                        icon = "upgrade",
                        cost = 250,
                        reputation_required = 500, -- Same as saloon expansion
                        benefits = "Opens up entertainment area",
                        removes_on_activate = true -- This wall should be REMOVED
                    }
                }
            },

            -- Entertainment (bands)
            entertainment = {
                label = "Entertainment",
                icon = "music",
                description = "Add live music to entertain your patrons",
                slot_limit = 1, -- Only 1 band active at a time
                upgrade_required = "expansion_saloon",
                upgrades = {
                    {
                        id = "band_1c",
                        name = "Wooden Fancy Wall",
                        description = "Decorative wooden wall panel for the entertainment area",
                        entity_set = "mp006_mshine_band1c",
                        icon = "upgrade",
                        cost = 600,
                        reputation_required = 600,
                        benefits = "Elegant wooden decoration"
                    },
                    {
                        id = "band_2",
                        name = "Piano & Band Section",
                        description = "Premium entertainment setup with piano and band area",
                        entity_set = "mp006_mshine_band2",
                        icon = "music",
                        cost = 750,
                        reputation_required = 700,
                        benefits = "Full entertainment area with live music"
                    }
                }
            },

            -- Misc (furniture, decorations)
            misc = {
                label = "Furniture & Decorations",
                icon = "upgrade",
                description = "Add furniture and wall decorations to your shack",
                slot_limit = 10,
                upgrade_required = "expansion_saloon",
                upgrades = {
                    -- Picture sets (only 1 active)
                    {
                        id = "pic_01",
                        name = "Picture Set #1",
                        description = "Classic landscape paintings",
                        entity_set = "mp006_mshine_pic_01",
                        icon = "upgrade",
                        cost = 50,
                        reputation_required = 0,
                        benefits = "Minor visual enhancement",
                        slot_limit = 1
                    },
                    {
                        id = "pic_02",
                        name = "Picture Set #2",
                        description = "Portrait collection",
                        entity_set = "mp006_mshine_pic_02",
                        icon = "upgrade",
                        cost = 50,
                        reputation_required = 0,
                        benefits = "Minor visual enhancement",
                        slot_limit = 1
                    },
                    {
                        id = "pic_03",
                        name = "Picture Set #3",
                        description = "Western art collection",
                        entity_set = "mp006_mshine_pic_03",
                        icon = "upgrade",
                        cost = 75,
                        reputation_required = 100,
                        benefits = "Minor visual enhancement",
                        slot_limit = 1
                    },
                    {
                        id = "pic_04",
                        name = "Picture Set #4",
                        description = "Vintage photographs",
                        entity_set = "mp006_mshine_pic_04",
                        icon = "upgrade",
                        cost = 75,
                        reputation_required = 100,
                        benefits = "Minor visual enhancement",
                        slot_limit = 1
                    },
                    {
                        id = "pic_05",
                        name = "Picture Set #5",
                        description = "Wildlife artwork",
                        entity_set = "mp006_mshine_pic_05",
                        icon = "upgrade",
                        cost = 100,
                        reputation_required = 200,
                        benefits = "Minor visual enhancement",
                        slot_limit = 1
                    },
                    {
                        id = "pic_06",
                        name = "Picture Set #6",
                        description = "Historical scenes",
                        entity_set = "mp006_mshine_pic_06",
                        icon = "upgrade",
                        cost = 100,
                        reputation_required = 200,
                        benefits = "Minor visual enhancement",
                        slot_limit = 1
                    },
                    {
                        id = "pic_07",
                        name = "Picture Set #7",
                        description = "Abstract art pieces",
                        entity_set = "mp006_mshine_pic_07",
                        icon = "upgrade",
                        cost = 125,
                        reputation_required = 300,
                        benefits = "Minor visual enhancement",
                        slot_limit = 1
                    },
                    {
                        id = "pic_08",
                        name = "Picture Set #8",
                        description = "Wanted posters collection",
                        entity_set = "mp006_mshine_pic_08",
                        icon = "upgrade",
                        cost = 125,
                        reputation_required = 300,
                        benefits = "Minor visual enhancement",
                        slot_limit = 1
                    },
                    {
                        id = "pic_09",
                        name = "Picture Set #9",
                        description = "Premium oil paintings",
                        entity_set = "mp006_mshine_pic_09",
                        icon = "upgrade",
                        cost = 150,
                        reputation_required = 400,
                        benefits = "Minor visual enhancement",
                        slot_limit = 1
                    },
                    {
                        id = "pic_10",
                        name = "Picture Set #10",
                        description = "Rare artwork collection",
                        entity_set = "mp006_mshine_pic_10",
                        icon = "upgrade",
                        cost = 200,
                        reputation_required = 500,
                        benefits = "Minor visual enhancement",
                        slot_limit = 1
                    }
                }
            },

            -- Themes
            themes = {
                label = "Interior Themes",
                icon = "upgrade",
                description = "Add decorative themes to your shack (only 1 theme can be active)",
                slot_limit = 1, -- Only 1 theme active at a time
                upgrade_required = "expansion_saloon",
                upgrades = {
                    {
                        id = "theme_christmas",
                        name = "Christmas Theme",
                        description = "Festive holiday decorations and seasonal charm",
                        entity_set = "mp006_mshine_theme_christmas",
                        icon = "upgrade",
                        cost = 500,
                        reputation_required = 100,
                        benefits = "Seasonal festive atmosphere"
                    },
                    {
                        id = "theme_gothic",
                        name = "Gothic Theme",
                        description = "Dark and mysterious decor with gothic elements",
                        entity_set = "mp006_mshine_theme003",
                        icon = "upgrade",
                        cost = 600,
                        reputation_required = 400,
                        benefits = "Dark atmospheric theme"
                    },
                    {
                        id = "theme_hunter",
                        name = "Hunter's Lodge Theme",
                        description = "Rustic hunting trophies and wilderness decor",
                        entity_set = "mp006_mshine_theme004",
                        icon = "upgrade",
                        cost = 450,
                        reputation_required = 300,
                        benefits = "Rugged frontier atmosphere"
                    },
                    {
                        id = "theme_spanish",
                        name = "Spaniard Theme",
                        description = "Beautiful Spanish-themed interior transformation with VIP backstage quarters",
                        entity_set = "mp006_mshine_dressing_5",
                        icon = "upgrade",
                        cost = 750,
                        reputation_required = 30,
                        benefits = "Stunning Spanish decor, premium atmosphere"
                    }
                }
            }
        }
    }
}

Config.ShackSuppliers = {
    RefreshTime = '*/15 * * * *', -- Every 15 minutes (cron timing)
    ActiveSuppliers = 3, -- How many suppliers to select from the list

    -- Blip Configuration
    Blip = {
        Sprite = 'blip_moonshine_vat', -- Blip icon
        Scale = 0.2 -- Blip size
    },

    -- GPS Route Color (always enabled)
    GPSRouteColor = 'COLOR_RED', -- GPS route color (COLOR_GREEN, COLOR_YELLOW, COLOR_RED, etc.)

    Locations = {
        { id = "supplier_1", name = "Cumberland Forest Trapper", coords = vector4(562.91, 1339.36, 181.65, 36.63), npc_model = "mp_re_moonshinecamp_males_01", wagon = vector4(565.11, 1339.30, 181.19, 350.05)},
        { id = "supplier_2", name = "Big Valley Hunter", coords = vector4(-1261.38, 1545.40, 298.54, 154.28), npc_model = "mp_re_moonshinecamp_males_01", wagon = vector4(-1264.41, 1546.49, 297.78, 81.95) },
        { id = "supplier_3", name = "Roanoke Ridge Moonshiner", coords = vector4(2699.15, 1335.91, 94.78, 339.93), npc_model = "mp_re_moonshinecamp_males_01", wagon = vector4(2700.15, 1332.67, 94.42, 301.09) },
        { id = "supplier_4", name = "Bayou Nwa Fence", coords = vector4(933.16, -1385.88, 57.19, 171.48), npc_model = "mp_re_moonshinecamp_males_01", wagon = vector4(933.94, -1378.85, 57.18, 114.00) },
        { id = "supplier_5", name = "Armadillo General Store", coords = vector4(-3715.4, -2598.6, -14.6, 90.0), npc_model = "mp_re_moonshinecamp_males_01", wagon = vector4(-3716.24, -2590.83, -14.20, 183.50) },
        { id = "supplier_6", name = "Blackwater Tailor", coords = vector4(-1023.22, -1693.71, 78.12, 161.96), npc_model = "mp_re_moonshinecamp_males_01", wagon = vector4(-1019.90, -1692.63, 77.62, 193.16)},
        { id = "supplier_7", name = "Strawberry Butcher", coords = vector4(-1898.71, -380.43, 178.25, 288.68), npc_model = "mp_re_moonshinecamp_males_01", wagon = vector4(-1901.55, -371.56, 180.13, 199.97)},
        { id = "supplier_8", name = "Annesburg Doctor", coords = vector4(2843.29, 1683.03, 129.28, 249.49), npc_model = "mp_re_moonshinecamp_males_01", wagon = vector4(2836.55, 1678.76, 129.13, 271.14)},
        { id = "supplier_9", name = "Rhodes Gunsmith", coords = vector4(1205.78, -1462.58, 64.58, 257.63), npc_model = "mp_re_moonshinecamp_males_01", wagon = vector4(1202.65, -1462.97, 64.37, 223.61)},
        { id = "supplier_10", name = "Valentine Saloon Owner", coords = vector4(-285.09, 980.36, 133.02, 235.04), npc_model = "mp_re_moonshinecamp_males_01", wagon = vector4(-291.34, 980.90, 133.45, 169.37)}
    }
}

Config.SupplyRunRewards = {
    corn = 20,
    sugar = 20,
    water = 20,
    consumable_yeast = 20,
    moonshine_empty_jug = 20
}

-- ═══════════════════════════════════════════════════════════════
--  DELIVERY SYSTEM CONFIGURATION
-- ═══════════════════════════════════════════════════════════════

Config.Deliveries = {
    -- How often delivery offers refresh (in minutes)
    RefreshInterval = 5,

    -- Minimum stock required to accept deliveries
    MinStockRequired = 100,

    -- Number of offers based on reputation (max 1000)
    OffersByReputation = {
        {minRep = 0, maxRep = 99, offerCount = 2},      -- Low rep: 2 offers
        {minRep = 100, maxRep = 249, offerCount = 3},   -- Medium-low: 3 offers
        {minRep = 250, maxRep = 499, offerCount = 4},   -- Medium: 4 offers
        {minRep = 500, maxRep = 749, offerCount = 5},   -- Medium-high: 5 offers
        {minRep = 750, maxRep = 1000, offerCount = 6}   -- High rep: 6 offers
    },

    -- Wagon configuration
    Wagon = {
        Model = 'wagon05x',              -- Supply wagon model
        Propset = 'pg_rc_ridethelightning01x'  -- Wagon appearance propset
    },

    -- Delivery locations around the map
    Locations = {
        -- Valentine area
        {
            id = 'valentine_saloon',
            name = 'Valentine Saloon',
            contact = 'Uncle',
            headshot = 'headshot_uncle',
            coords = vector3(-314.77, 826.00, 119.32),
            heading = 90.0,
            region = 'Heartlands',
            tier = 'standard',
            reputationRequired = 0,
            baseReward = {min = 150, max = 250},
            reputationGain = {min = 2, max = 4},
            image = 'location_heartlands'
        },
        {
            id = 'valentine_hotel',
            name = 'Smithfield\'s Saloon',
            contact = 'Karen Jones',
            headshot = 'headshot_karen',
            coords = vector3(-220.24, 751.64, 117.05),
            heading = 270.0,
            region = 'Heartlands',
            tier = 'standard',
            reputationRequired = 0,
            baseReward = {min = 140, max = 230},
            reputationGain = {min = 2, max = 4},
            image = 'location_heartlands'
        },
        -- Strawberry area
        {
            id = 'strawberry_welcome',
            name = 'Strawberry Welcome Center',
            contact = 'Tilly Jackson',
            headshot = 'headshot_tilly',
            coords = vector3(-1790.49, -375.32, 159.38),
            heading = 135.0,
            region = 'Big Valley',
            tier = 'standard',
            reputationRequired = 10,
            baseReward = {min = 180, max = 280},
            reputationGain = {min = 3, max = 5},
            image = 'location_big_valley'
        },
        -- Rhodes area
        {
            id = 'rhodes_parlour',
            name = 'Rhodes Parlour House',
            contact = 'Abigail Roberts',
            headshot = 'headshot_abigail',
            coords = vector3(1343.09, -1355.27, 78.53),
            heading = 270.0,
            region = 'Scarlett Meadows',
            tier = 'standard',
            reputationRequired = 0,
            baseReward = {min = 160, max = 260},
            reputationGain = {min = 2, max = 4},
            image = 'location_scarlett_meadows'
        },
        {
            id = 'rhodes_general',
            name = 'Rhodes General Store',
            contact = 'Simon Pearson',
            headshot = 'headshot_pearson',
            coords = vector3(1369.96, -1379.94, 78.72),
            heading = 180.0,
            region = 'Scarlett Meadows',
            tier = 'standard',
            reputationRequired = 5,
            baseReward = {min = 155, max = 255},
            reputationGain = {min = 2, max = 4},
            image = 'location_scarlett_meadows'
        },
        -- Saint Denis area (premium)
        {
            id = 'saintdenis_saloon',
            name = 'Bastille Saloon',
            contact = 'Dutch van der Linde',
            headshot = 'headshot_dutch',
            coords = vector3(2617.76, -1223.48, 53.30),
            heading = 90.0,
            region = 'Bayou Nwa',
            tier = 'premium',
            reputationRequired = 40,
            baseReward = {min = 300, max = 450},
            reputationGain = {min = 5, max = 8},
            image = 'location_bayou_nwa'
        },
        {
            id = 'saintdenis_market',
            name = 'Saint Denis Market',
            contact = 'Hosea Matthews',
            headshot = 'headshot_hosea',
            coords = vector3(2838.59, -1321.50, 46.28),
            heading = 0.0,
            region = 'Bayou Nwa',
            tier = 'premium',
            reputationRequired = 50,
            baseReward = {min = 320, max = 480},
            reputationGain = {min = 5, max = 8},
            image = 'location_bayou_nwa'
        },
        -- Blackwater area (premium)
        {
            id = 'blackwater_saloon',
            name = 'Blackwater Saloon',
            contact = 'Sadie Adler',
            headshot = 'headshot_sadie',
            coords = vector3(-801.86, -1314.19, 43.55),
            heading = 90.0,
            region = 'Great Plains',
            tier = 'premium',
            reputationRequired = 60,
            baseReward = {min = 350, max = 500},
            reputationGain = {min = 6, max = 10},
            image = 'location_great_plains'
        },
        -- Tumbleweed area
        {
            id = 'tumbleweed_saloon',
            name = 'Tumbleweed Saloon',
            contact = 'Bill Williamson',
            headshot = 'headshot_bill',
            coords = vector3(-5522.44, -2920.34, -2.23),
            heading = 270.0,
            region = 'Hennigan\'s Stead',
            tier = 'standard',
            reputationRequired = 15,
            baseReward = {min = 190, max = 290},
            reputationGain = {min = 3, max = 5},
            image = 'location_hannigans_stead'
        },
        -- Annesburg area (premium)
        {
            id = 'annesburg_mine',
            name = 'Annesburg Mine Office',
            contact = 'Charles Smith',
            headshot = 'headshot_charles',
            coords = vector3(2922.40, 1287.79, 44.41),
            heading = 180.0,
            region = 'Roanoke Ridge',
            tier = 'premium',
            reputationRequired = 70,
            baseReward = {min = 380, max = 530},
            reputationGain = {min = 7, max = 11},
            image = 'location_roanoke_ridge'
        },
        -- Armadillo area
        {
            id = 'armadillo_saloon',
            name = 'Armadillo Saloon',
            contact = 'Javier Escuella',
            headshot = 'headshot_javier',
            coords = vector3(-3684.07, -2615.29, -14.08),
            heading = 270.0,
            region = 'Cholla Springs',
            tier = 'standard',
            reputationRequired = 100,
            baseReward = {min = 200, max = 320},
            reputationGain = {min = 3, max = 6},
            image = 'location_cholla_springs'
        },
        -- Van Horn area
        {
            id = 'vanhorn_trading',
            name = 'Van Horn Trading Post',
            contact = 'Lenny Summers',
            headshot = 'headshot_lenny',
            coords = vector3(2982.61, 561.34, 44.44),
            heading = 0.0,
            region = 'Roanoke Ridge',
            tier = 'standard',
            reputationRequired = 150,
            baseReward = {min = 220, max = 340},
            reputationGain = {min = 4, max = 6},
            image = 'location_roanoke_ridge'
        },
        -- Cannibal Town area
        {
            id = 'cannabal_town',
            name = 'Cannibal Town',
            contact = 'Sean MacGuire',
            headshot = 'headshot_sean',
            coords = vector3(2550.11, 777.93, 75.34),
            heading = 90.0,
            region = 'Heartlands',
            tier = 'standard',
            reputationRequired = 200,
            baseReward = {min = 240, max = 360},
            reputationGain = {min = 4, max = 7},
            image = 'location_heartlands'
        },
        -- Lagras area
        {
            id = 'lagras_shack',
            name = 'Lagras Trading Post',
            contact = 'Micah Bell',
            headshot = 'headshot_micah',
            coords = vector3(2091.80, -585.66, 41.51),
            heading = 180.0,
            region = 'Bayou Nwa',
            tier = 'premium',
            reputationRequired = 300,
            baseReward = {min = 280, max = 420},
            reputationGain = {min = 5, max = 8},
            image = 'location_bayou_nwa'
        },
        -- Manzanita Post area
        {
            id = 'manzanita_post',
            name = 'Manzanita Post',
            contact = 'John Marston',
            headshot = 'headshot_john',
            coords = vector3(-1653.94, -1381.67, 84.00),
            heading = 270.0,
            region = 'Tall Trees',
            tier = 'premium',
            reputationRequired = 400,
            baseReward = {min = 320, max = 470},
            reputationGain = {min = 6, max = 9},
            image = 'location_tall_trees'
        },
        -- Wapiti area
        {
            id = 'wapiti_reservation',
            name = 'Wapiti Indian Reservation',
            contact = 'Eagle Flies',
            headshot = 'headshot_eagle_flies',
            coords = vector3(498.09, 2229.23, 246.69),
            heading = 0.0,
            region = 'Grizzlies',
            tier = 'premium',
            reputationRequired = 500,
            baseReward = {min = 360, max = 520},
            reputationGain = {min = 7, max = 10},
            image = 'location_grizzlies'
        },
        -- Emerald Station (high rep)
        {
            id = 'emerald_station',
            name = 'Emerald Trading Station',
            contact = 'Arthur Morgan',
            headshot = 'headshot_arthur',
            coords = vector3(1511.51, 439.52, 89.76),
            heading = 180.0,
            region = 'Grizzlies',
            tier = 'elite',
            reputationRequired = 650,
            baseReward = {min = 420, max = 600},
            reputationGain = {min = 8, max = 12},
            image = 'location_grizzlies'
        },
        -- Snow Town (very high rep)
        {
            id = 'snow_town',
            name = 'Grizzles Town',
            contact = 'Landon Ricketts',
            headshot = 'headshot_swanson',
            coords = vector3(-1358.00, 2397.57, 306.79),
            heading = 270.0,
            region = 'Lannahechee River',
            tier = 'elite',
            reputationRequired = 800,
            baseReward = {min = 480, max = 680},
            reputationGain = {min = 9, max = 13},
            image = 'location_grizzlies'
        },
        -- McFarlanes Ranch (max rep only)
        {
            id = 'mcfar_ranch',
            name = 'McFarlanes Ranch',
            contact = 'Alberto Fussar',
            headshot = 'headshot_trelawny',
            coords = vector3(-2334.41, -2419.18, 61.99),
            heading = 0.0,
            region = 'Guarma',
            tier = 'elite',
            reputationRequired = 950,
            baseReward = {min = 550, max = 800},
            reputationGain = {min = 10, max = 15},
            image = 'location_cholla_springs'
        }
    }
}