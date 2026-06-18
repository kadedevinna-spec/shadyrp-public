BathConfig = {}

-- ================================================================================================
-- GENERAL SETTINGS
-- ================================================================================================

BathConfig.Debug = false                    -- Enable debug prints
BathConfig.Enabled = true                   -- Enable/disable the entire system
BathConfig.EnableBathing = true             -- Enable/disable bathing in tubs
BathConfig.EnableWashing = true             -- Enable/disable washing at basins/water props
BathConfig.EnableRiverWashing = true        -- Enable/disable washing in rivers/lakes (wild water)

-- Key to wash/scrub while in bath
-- Common keys: G = 0x760A9C6F, X = 0x8FD015D8, E = 0xCEFD9220
BathConfig.ScrubKey = 0xCEFD9220

-- Key to exit bath (default: G = 0x760A9C6F)
BathConfig.ExitKey = 0x760A9C6F

BathConfig.Music = true                     -- Enable music during bathing
BathConfig.UseAnimationScenes = true        -- Use animation scenes (intro/outro) or simple bathing
BathConfig.AllowDeluxeBathing = true        -- Enable deluxe bathing with NPC helper

-- ================================================================================================
-- PRICING
-- ================================================================================================

BathConfig.NormalPrice = 2.50               -- Price for regular bathing
BathConfig.DeluxePrice = 5.00               -- Price for deluxe bathing

-- ================================================================================================
-- BATHING ZONES (Only used if UseAnimationScenes = true)
-- ================================================================================================

BathConfig.BathingZones = {
    ["SaintDenis"] = {
        dict = "script@mini_game@bathing@BATHING_INTRO_OUTRO_ST_DENIS",
        rag = vector4(2629.4, -1223.33, 58.57, -92.66),
        consumer = vector3(2632.6, -1223.79, 59.59),
        exit = vector4(2632.84, -1223.89, 59.64, 0.0),
        lady = `CS_BATHINGLADIES_01`,
        guy = `cs_aberdeenpigfarmer`,
        door = 779421929,
        blip = true                         -- Show blip on map for this location
    },
    ["Valentine"] = {
        dict = "script@mini_game@bathing@BATHING_INTRO_OUTRO_VALENTINE",
        rag = vector4(-317.37, 761.8, 116.44, 10.365),
        consumer = vector3(-320.56, 762.41, 117.44),
        exit = vector4(-320.5, 762.26, 116.43, 0.0),
        lady = `CS_BATHINGLADIES_01`,
        guy = `cs_aberdeenpigfarmer`,
        door = 142240370,
        blip = true
    },
    ["Annesburg"] = {
        dict = "script@mini_game@bathing@BATHING_INTRO_OUTRO_ANNESBURG",
        rag = vector4(2952.65, 1334.7, 43.44, -291.27),
        consumer = vector3(2950.42, 1332.15, 44.44),
        exit = vector4(2950.42, 1332.15, 44.44, 0.0),
        lady = `CS_BATHINGLADIES_01`,
        guy = `cs_aberdeenpigfarmer`,
        door = -201071322,
        blip = true
    },
    ["Strawberry"] = {
        dict = "script@mini_game@bathing@BATHING_INTRO_OUTRO_STRAWBERRY",
        rag = vector4(-1812.83, -373.23, 165.5, 1.206),
        consumer = vector3(-1816.45, -372.44, 166.50),
        exit = vector4(-1816.45, -372.44, 166.50, 0.0),
        lady = `CS_BATHINGLADIES_01`,
        guy = `cs_aberdeenpigfarmer`,
        door = 1256786197,
        blip = true
    },
    ["Blackwater"] = {
        dict = "script@mini_game@bathing@BATHING_INTRO_OUTRO_BLACKWATER",
        rag = vector4(-823.86, -1318.84, 42.68, -0.459),
        consumer = vector3(-822.82, -1315.72, 43.58),
        exit = vector4(-822.82, -1315.72, 43.58, 0.0),
        lady = `CS_BATHINGLADIES_01`,
        guy = `cs_aberdeenpigfarmer`,
        door = 1523300673,
        blip = true
    },
    ["Vanhorn"] = {
        dict = "script@mini_game@bathing@BATHING_INTRO_OUTRO_VANHORN",
        rag = vector4(2987.62, 573.21, 46.86, 83.841),
        consumer = vector3(2986.31, 568.27, 47.85),
        exit = vector4(2986.31, 568.27, 47.85, 0.0),
        lady = `CS_BATHINGLADIES_01`,
        guy = `cs_aberdeenpigfarmer`,
        door = 1102743282,
        blip = true
    },
    ["Rhodes"] = {
        dict = "script@mini_game@bathing@BATHING_INTRO_OUTRO_RHODES",
        rag = vector4(1336.85, -1378.04, 83.2897, 166.469),
        consumer = vector3(1340.11, -1379.6, 84.28),
        exit = vector4(1340.11, -1379.6, 84.28, 0.0),
        lady = `CS_BATHINGLADIES_01`,
        guy = `cs_aberdeenpigfarmer`,
        door = -1847993131,
        blip = true
    }
}

-- ================================================================================================
-- BATHING MODES/STAGES
-- ================================================================================================

BathConfig.BathingModes = {
    { 
        transition = "Scrub_Head",
        scrub_freq = 0.75,
        hold_power = 0.01
    },
    { 
        transition = "Scrub_Left_Arm",
        scrub_freq = 0.7,
        deluxe = true,
        hold_power = 0.01
    },
    { 
        transition = "Scrub_Right_Arm",
        scrub_freq = 0.5,
        deluxe = true,
        hold_power = 0.01
    },
    { 
        transition = "Scrub_Right_Leg",
        scrub_freq = 0.6,
        deluxe = true,
        hold_power = 0.01
    },
    { 
        transition = "Scrub_Left_Leg",
        scrub_freq = 0.7,
        deluxe = true,
        hold_power = 0.01
    }
}

-- ================================================================================================
-- UNDRESS/DRESS ELEMENTS
-- ================================================================================================

BathConfig.UndressElements = {
    { category = "hats", hash = 2569388135 },
    { category = "masks", hash = 1963323202 },
    { category = "masks_large", hash = 1249071452 },
    { category = "neckwear", hash = 1606587013 },
    { category = "shirts_full", hash = 539411565 },
    { category = "coats", hash = 0xE06D30CE },
    { category = "coats_closed", hash = 0x662AC34 },
    { category = "ponchos", hash = 2937336075 },
    { category = "cloaks", hash = 1008366797 },
    { category = "vests", hash = 1214179380 },
    { category = "gloves", hash = 3938320434 },
    { category = "gauntlets", hash = 2446236448 },
    { category = "chaps", hash = 822561179 },
    { category = "pants", hash = 491541130 },
    { category = "skirts", hash = 0xA0E3AB7F },
    { category = "boots", hash = 2004797167 },
    { category = "neckties", hash = 2056714954 },
    { category = "eyewear", hash = 98860198 },
    { category = "holsters_right", hash = 3118660097 },
    { category = "holsters_crossdraw", hash = 1237884315 },
    { category = "ammo_pistols", hash = 1058996709 },
    { category = "holsters_knife", hash = 2078766994 },
    { category = "holsters_left", hash = 3065385517 },
    { category = "ammo_rifles", hash = 3658361941 },
    { category = "loadouts", hash = 2206760584 },
    { category = "gunbelts", hash = 2603387785 },
    { category = "accessories", hash = 2044190614 },
    { category = "jewelry_rings_right", hash = 2053881099 },
    { category = "jewelry_rings_left", hash = 4050263331 },
    { category = "jewelry_bracelets", hash = 2076247897 },
    { category = "badges", hash = 1065301383 },
    { category = "satchels", hash = 2488290598 },
    { category = "spats", hash = 1363860714 },
    { category = "boot_accessories", hash = 410165049 },
    { category = "legs_accessories", hash = 4048825617 },
    { category = "belts", hash = 2798728390 },
    { category = "belt_buckles", hash = 4209578111 },
    { category = "suspenders", hash = 2272931063 },
    { category = "aprons", hash = 1995498098 },
    { category = "armor", hash = 1927737204 }
}

BathConfig.Special = { 
    ["shirts_full"] = 235,
    ["pants"] = 198
}

BathConfig.DressElements = {}

-- ================================================================================================
-- CAMERA SETTINGS
-- ================================================================================================

BathConfig.Camera = {
    enabled = true,
    fovOffset = 0.0,
    coordOffset = vector3(0.0, 0.4, 0.5)
}

-- ================================================================================================
-- POSITIONING
-- ================================================================================================

BathConfig.PlayerOffset = {
    x = 0.5,
    y = 0.0,
    z = -0.6,
    heading = 180.0
}

-- ================================================================================================
-- QUICK WASH SETTINGS
-- ================================================================================================

BathConfig.QuickWashDuration = 5000         -- Quick wash at basin duration (milliseconds)

-- ================================================================================================
-- ITEM-BASED WASHING
-- ================================================================================================

BathConfig.UseItems = true                 -- Enable item-based washing (requires items to wash)
BathConfig.WashItems = {"custom_beautyboutique_cowpokecleanser","custom_beautyboutique_lemonbalmbar","custom_beautyboutique_saddlesoap"}                   -- List of items that can be used for washing
BathConfig.RemoveItem = true               -- Remove item after use (if not using durability)

BathConfig.Durability = {
    Enable = false,                         -- Enable durability system
    MaxDurability = 100,                    -- Maximum durability
    RemoveDurability = 20,                  -- Durability removed per use
    NotifyBroken = true                     -- Notify when item breaks
}

-- ================================================================================================
-- ITEM EFFECTS (Visual effects shown on player when using items)
-- ================================================================================================

BathConfig.ItemEffects = {
    Enable = true,                          -- Enable visual effects system
    Duration = 7000,                        -- Effect duration in milliseconds (7 seconds default)
    RenderDistance = 5.0,                  -- Distance in which other players can see the effect
    
    -- Per-item effect configuration
    Effects = {
        ["custom_beautyboutique_cowpokecleanser"] = {
            text = "Pleasantly smells like fresh pine & mint",
            color = "#3b82f6",              -- Blue color (hex format)
            icon = "soap",                  -- Optional icon identifier
            duration = 7000                 -- Override duration for this item (7 seconds)
        },
        ["custom_beautyboutique_lemonbalmbar"] = {
            text = "Pleasantly smells like sweet citrus",
            color = "#fbbf24",              -- Yellow/amber color
            icon = "soap",
            duration = 7000
        },
        ["custom_beautyboutique_saddlesoap"] = {
            text = "Smells like Leather & Oil",
            color = "#a78bfa",              -- Purple color
            icon = "soap",
            duration = 7000
        },
        ["custom_beautyboutique_essencedefleurno4"] = {
            text = "Pleasantly smells of sweet florals",
            color = "#f472b6",              -- Pink color
            icon = "soap",
            duration = 7000
        }
    }
}

-- ================================================================================================
-- BATHTUB INTERACTIONS
-- ================================================================================================

BathConfig.Bathtubs = {
    Enabled = true,                         -- Enable bathtub interactions
    RequirePayment = true,                  -- Require payment to use bathtubs (uses BathConfig.NormalPrice)
    Distance = 2.0,                        -- Interaction distance
    
    Props = {
        "p_cs_bathtub01x",
        "p_cs_bathtub02x"
    }
}

-- ================================================================================================
-- PROP-BASED WASHING (Troughs, Barrels, Wells, etc.)
-- ================================================================================================

BathConfig.Water = {
    Enabled = true,                         -- Enable water prop washing
    Distance = 3.0,                         -- Interaction distance
    WalkToLocation = true,                  -- Character walks to the water before washing
    Duration = 5000,                        -- Washing duration (milliseconds)
    
    Props = {
        -- Wash basins
        "p_washbasin01x",
        "p_washbasin02x",
        "p_washbasin03x",
        "p_washbasinregal01x",
        "p_washbasinregal02x",
        "p_washbasinregal03x",
        "p_washbasinregal04x",
        
        -- Water troughs
        "p_watertrough01x",
        "p_watertrough02x",
        "p_watertrough03x",
        "p_watertroughsml01x",
        "p_watertroughhorse01x",
        
        -- Barrels with water
        "p_barrel_ladle01x",
        "p_barrelladle1x_savage",
        "p_barrel_wash01x",
        "p_barrelwater01x",
        "p_barrelwater02x",
        "p_barrelhalf02x",
        
        -- Water buckets
        "p_bucket01x",
        "p_bucket02x",
        "p_bucket03x",
        "p_bucket04x",
        "p_bucket05x",
        "p_bucketwater01x",
        "p_bucketwater02x",
        
        -- Wells and pumps
        "p_wellpumpnbx01x",
        "p_wellpump01x",
        "p_wellpump02x",
        "p_well01x",
        "p_well02bx",
        "p_well03x",
        "p_waterpump01x",
        
        -- Rain barrels
        "p_rainbarrel01x",
        "p_rainbarrel02x",
        "p_rainbarrel03x"
    }
}

-- ================================================================================================
-- ANIMATION TYPES
-- ================================================================================================

BathConfig.AnimationTypes = {
    barrel = {
        male = { 
            dict = "mp_amb_player@prop_player_wash_face_barrel@sober@male_a@base",
            name = "base"
        },
        female = { 
            dict = "amb_misc@world_human_wash_face_bucket@table@female_a@idle_d",
            name = "idle_j"
        }
    },
    bucket = {
        scenario = "WORLD_HUMAN_WASH_FACE_BUCKET_GROUND"
    },
    wading = {
        dict = "amb_misc@world_human_wash_wading@wash_off@male_b@wip_base",
        name = "wip_base"
    },
    table = {
        dict = "amb_misc@world_human_wash_face_bucket@table@male_a@idle_b",
        name = "idle_e"
    }
}
