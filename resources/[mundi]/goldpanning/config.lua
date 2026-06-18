Config = {}

Config.debug = false -- Enable/disable debug output (production ready)

-- ===============================================
-- LANGUAGE / LOCALE SYSTEM
-- ===============================================
-- Set your preferred language here: "en" (English), "sr" (Serbian), "fr" (French), "es" (Spanish)
-- You can add more languages in locale.lua
Config.Locale = "en" -- Options: "en", "sr", "fr", "es", or your custom language code

-- ===============================================
-- PROGRESS BAR SYSTEM
-- ===============================================
-- Choose which progress bar to use (can be customized in progressbar.lua)
-- Options: "builtin" or "custom"
Config.ProgressBar = "builtin" -- Default: uses built-in progress bar (no dependencies)

-- ===============================================
-- INTERACTION SYSTEM
-- ===============================================
-- Set to "ox_target" to use ox_target for interactions (requires ox_target needs to be loaded before the script in your server.cfg)
-- Set to "native" to use native RedM prompts (no additional dependencies)
Config.InteractionSystem = "native" -- Options: "ox_target" or "native"

-- Native prompt settings (only used when InteractionSystem = "native")
Config.NativePrompts = {
    interactionDistance = 2.0, -- Distance to show prompts
    holdTime = 800, -- How long to hold the prompt (ms)
    
    -- Configurable prompt keys and labels
    -- Key hashes: https://github.com/femga/rdr3_discoveries/blob/master/Controls/README.md
    prompts = {
        pour_sediment = {
            label = "Pour Sediment",
            key = 0x760A9C6F -- G key
        },
        pour_water = {
            label = "Pour Water",
            key = 0xE30CD707 -- R key
        },
        pan_gold = {
            label = "Pan for Gold",
            key = 0xB2F377E8 -- F key (changed from J to avoid wagon conflict)
        },
        pickup = {
            label = "Pick Up Cradle",
            key = 0xCEFD9220 -- E key
        }
    },
    
    -- Cradle placement keys (when placing cradle from inventory)
    placement = {
        place = {
            label = "Place",
            key = 0x760A9C6F -- G key
        },
        cancel = {
            label = "Cancel",
            key = 0xCEFD9220 -- E key
        }
    }
}

-- Placement mode settings
Config.PlacementMode = {
    rotateSpeed = 5.0,    -- Degrees per scroll tick
    heightSpeed = 0.01,   -- Height adjustment per frame (held)
    raycastDistance = 10.0 -- How far from camera to raycast
}

Config.cradleProp = "p_goldcradlestand01x" -- Prop name for the gold panning cradle 
Config.waterItem = "wateringbucket" -- Water item needed for panning 
Config.emptyWaterItem = "bucket" -- Empty water can returned after use 
Config.sedimentItem = "river_sediment" -- Item received when collecting at riverbed 
Config.mudBucketItem = "mud_bucket" -- Item needed to collect sediment 
Config.goldPanItem = "goldpan" -- Gold pan tool item 

-- GOLD PAN DEGRADATION
Config.GoldPanDegradation = {
    enabled = true,           -- Enable/disable gold pan degradation
    degradeChance = 100,      -- 100% chance to degrade on use (always degrades)
    degradeAmount = 3,        -- How much to degrade per use (3 durability per use)
    maxDurability = 100,      -- Max durability of a gold pan (~33 uses before breaking)
    breakNotification = "Your gold pan broke from wear and tear!"
}

-- CRADLE USE LIMIT
-- The cradle tracks how many panning sessions it can handle.
-- After all uses are spent, the player is notified and must pick it up (it's destroyed on pickup).
Config.CradleDegradation = {
    enabled = true,           -- Enable/disable cradle use tracking
    maxUses = 20,             -- Number of panning sessions before the cradle wears out
}

-- WATERING BUCKET DEGRADATION
Config.WateringBucketDegradation = {
    enabled = true,           -- Enable/disable watering bucket degradation
    degradeChance = 100,      -- 100% chance to degrade on use (always degrades)
    degradeAmount = 5,        -- How much to degrade per use (5 durability per use)
    maxDurability = 100,      -- Max durability of a watering bucket (~20 uses before breaking)
    breakNotification = "Your watering bucket broke from wear and tear!"
}

-- MUD BUCKET DEGRADATION
Config.MudBucketDegradation = {
    enabled = true,           -- Enable/disable mud bucket degradation
    degradeChance = 100,      -- 100% chance to degrade on use (always degrades)
    degradeAmount = 5,        -- How much to degrade per use (5 durability per use)
    maxDurability = 100,      -- Max durability of a mud bucket (~20 uses before breaking)
    breakNotification = "Your mud bucket broke from wear and tear!"
}

-- REWARD SYSTEM
Config.Rewards = {
    -- This controls how much the minigame performance (the multiplier from the client) affects the outcome.
    -- A higher value means a good minigame score gives a better chance for rare loot.
    minigameMultiplierInfluence = 0.3, -- Skill matters moderately

    -- Defines the chances for getting 0, 1, 2, or 3 gold flakes.
    -- The system will roll a 1-100 number.
    -- REBALANCED: Better base chances so players can find gold anywhere
    flakes = {
        -- Base chances before location/weather modifiers
        {amount = 0, weight = 30}, -- 30% chance to find nothing
        {amount = 1, weight = 43}, -- 43% chance for 1 flake - most common find
        {amount = 2, weight = 20}, -- 20% chance for 2 flakes - uncommon
        {amount = 3, weight = 7}   -- 7% chance for 3 flakes - rare
    },

    -- Defines the chances for getting gold nuggets. This is a separate roll from flakes.
    -- Nuggets are rare finds but not impossible
    nuggets = {
        {amount = 0, weight = 83}, -- 83% chance to find no nugget
        {amount = 1, weight = 13}, -- 13% chance for 1 nugget - rare but achievable
        {amount = 2, weight = 4}   -- 4% chance for 2 nuggets - very rare
    }
}

Config.goldReward = "gold_flakes" -- Item to give 

-- REWARD ITEMS
Config.extraReward = "gold_nugget" -- Extra reward item 
Config.cradlePlacementDistance = 1.5
Config.cradleInteractionDistance = 2.0
Config.mixTime = 12000 -- ms 
Config.pourTime = 8000 -- ms 
Config.sedimentPerPan = 5
Config.waterPerPan = 1
Config.cradleModel = "p_goldcradlestand01x" -- Model name for cradle 
Config.cradleLabel = "Gold Wash Cradle"
Config.cradleIcon = "fas fa-bowl-rice"

-- Configurable Notifications
Config.notifications = {
    pourWater = { message = "You must wait before pouring water again.", duration = 4000 },
    pourSediment = { message = "You must wait before pouring sediment again.", duration = 4000 },
    startMinigame = { message = "You must wait before panning for gold again.", duration = 4000 },
    pickupCradle = { message = "You must wait before picking up the cradle again.", duration = 4000 },
    missingWater = { message = "You need a full watering can to pour water.", duration = 4000 },
    missingSediment = { message = "You need river sediment to pour.", duration = 4000 },
    missingMudBucket = { message = "You need a mud bucket to collect sediment.", duration = 4000 },
    missingGoldPan = { message = "You need a gold pan to start panning.", duration = 4000 },
    notInRiver = { message = "You must be at a river to pan for gold!", duration = 4000 },
    cradleFailed = { message = "Failed to place cradle. Try again.", duration = 4000 },
    emptyWaterCan = { message = "You already have an empty watering can. Fill it before pouring again.", duration = 4000 },
    cradlePickedUp = { message = "Cradle picked up.", duration = 4000 },
    foundNothing = { message = "You found nothing this time.", duration = 4000 },
    foundGold = { message = "You found gold flakes!", duration = 4000 },
    foundNugget = { message = "You found a gold nugget!", duration = 4000 },
    notEnoughSpace = { message = "Not enough inventory space.", duration = 4000 }
}

-- DEPLETION SYSTEM (realistic resource management)
Config.Depletion = {
    enabled = true,
    
    -- Depletion settings
    depletionRate = 0.01, -- How much each pan depletes the area (1% per pan)
    recoveryRate = 0.005, -- How much recovers per minute (0.5% per minute)
    minYield = 0.1, -- Minimum yield multiplier when depleted (10% of normal)
    
    -- Grid-based depletion (each 500m x 500m area depletes independently)
    minSuccessfulPans = 5, -- Minimum pans before depletion (reduced from 7)
    maxSuccessfulPans = 12, -- Maximum pans before depletion (reduced from 17)
}

-- Basic action cooldowns (prevent spam of collection actions only)
Config.actionCooldowns = {
    collectWater = 3, -- 3 seconds between water collections
    collectSediment = 3, -- 3 seconds between sediment collections
    pourWater = 2, -- 2 seconds between pouring water
    pourSediment = 2, -- 2 seconds between pouring sediment
    pickupCradle = 2, -- 2 seconds between cradle pickups
}

-- WEATHER EFFECTS (realistic environmental impact)
-- REBALANCED: Less harsh penalties
Config.WeatherEffects = {
    enabled = true,
    
    -- Weather multipliers for gold yield and success rate
    weatherConditions = {
        -- Clear/Sunny: Best conditions
        SUNNY = { yield = 1.0, successRate = 1.0, speedPenalty = 1.0 },
        CLEAR = { yield = 1.0, successRate = 1.0, speedPenalty = 1.0 },
        
        -- Cloudy: Almost no penalty
        CLOUDS = { yield = 1.0, successRate = 1.0, speedPenalty = 1.0 },
        OVERCAST = { yield = 0.95, successRate = 0.95, speedPenalty = 1.05 },
        
        -- Rain: Mild penalty
        RAIN = { yield = 0.85, successRate = 0.85, speedPenalty = 1.15 },
        DRIZZLE = { yield = 0.9, successRate = 0.9, speedPenalty = 1.1 },
        THUNDER = { yield = 0.75, successRate = 0.8, speedPenalty = 1.25 },
        
        -- Fog: Slight penalty
        FOG = { yield = 0.9, successRate = 0.9, speedPenalty = 1.1 },
        
        -- Snow: Moderate penalty
        SNOW = { yield = 0.7, successRate = 0.75, speedPenalty = 1.3 },
        BLIZZARD = { yield = 0.5, successRate = 0.6, speedPenalty = 1.5 },
        
        -- High activity weather
        HIGHPRESSURE = { yield = 0.85, successRate = 0.85, speedPenalty = 1.15 },
    },
    
    -- Weather notification
    showWeatherNotification = true,
    notificationDuration = 5000,
}

-- Location-Based Rewards (different water types give different yields)
-- REBALANCED: Higher base multipliers so you can find gold anywhere
Config.LocationMultipliers = {
    river = 1.0,   -- Rivers are the best (standard rate)
    creek = 0.85,  -- Creeks are almost as good
    lake = 0.7,    -- Lakes are decent
    pond = 0.5,    -- Ponds are harder but still viable
    swamp = 0.3,   -- Swamps are poor but not impossible
    ocean = 0.1    -- Ocean is terrible but might get lucky
}

-- SPECIFIC HIGH-YIELD LOCATIONS (gold rush spots - randomized each restart!)
-- REBALANCED: These spots give BONUS gold, but you can still find gold elsewhere
Config.GoldRushLocations = {
    enabled = true,
    
    -- Pool of potential gold rush locations - yields randomize each restart
    -- These are BONUS multipliers on top of base chances (not required to find gold)
    locations = {
        -- Dakota River
        {
            coords = vector3(-424.095, 1066.368, 86.620),
            radius = 300.0,
            label = "Dakota River", -- Generic name, no hint of quality
        },
        
        -- Upper Montana River
        {
            coords = vector3(-2001.090, -1016.234, 74.541),
            radius = 300.0,
            label = "Upper Montana River",
        },
        
        -- Little Creek River
        {
            coords = vector3(-2082.134, 541.356, 116.195),
            radius = 300.0,
            label = "Little Creek River",
        },
        
        -- Elysian Pool
        {
            coords = vector3(2370.601, 930.430, 72.294),
            radius = 300.0,
            label = "Elysian Pool",
        },
        
        -- Kamassa River
        {
            coords = vector3(2293.968, 1291.467, 82.938),
            radius = 300.0,
            label = "Kamassa River",
        },
        
        -- O'Creagh's Run
        {
            coords = vector3(1623.081, 1451.826, 144.339),
            radius = 300.0,
            label = "O'Creagh's Run",
        },
        
        -- Owanjila Lake
        {
            coords = vector3(-2642.506, -355.543, 140.765),
            radius = 300.0,
            label = "Owanjila Lake",
        },
        
        -- San Luis River
        {
            coords = vector3(-1902.411, -3041.215, -13.055),
            radius = 300.0,
            label = "San Luis River",
        },
        
        -- Donner Falls
        {
            coords = vector3(600.278, 2076.783, 213.408),
            radius = 300.0,
            label = "Lannahechee River",
        },
        
        -- Stillwater Creek
        {
            coords = vector3(-527.167, -162.989, 40.731),
            radius = 300.0,
            label = "Stillwater Creek",
        },
    },
    
    -- Notification settings
    showLocationNotification = false, -- DISABLED: Don't notify players about gold rush zones (keep it mysterious)
    notificationDuration = 5000,
    
    -- Randomization settings (applied on server restart)
    -- Gold rush spots get a BONUS multiplier on top of base rates
    randomization = {
        minYield = 1.2,  -- Minimum bonus yield multiplier (20% bonus at worst gold rush spot)
        maxYield = 2.0,  -- Maximum bonus yield multiplier (100% bonus at best gold rush spot)
        minSpeed = 35,   -- Minimum minigame speed
        maxSpeed = 50,   -- Maximum minigame speed
    }
}

-- Time of Day Effects (realistic visibility and conditions)
-- REBALANCED: Less punishing penalties
Config.TimeOfDayBonus = {
    enabled = true,
    dawn = 1.0,      -- 5am-8am: Good (miners start early)
    day = 1.0,       -- 8am-6pm: Best conditions
    dusk = 0.95,     -- 6pm-8pm: Slightly harder
    night = 0.85     -- 8pm-5am: Harder but still viable
}

-- ===============================================
-- WATER ZONE RESTRICTION SYSTEM
-- ===============================================
-- Set to true to ONLY allow gold panning in specific zones defined below
-- Set to false to allow panning in any water (default behavior)
Config.RestrictToSpecificZones = false

-- If RestrictToSpecificZones = true, ONLY these polyzone areas will allow gold panning
-- Each zone uses coordinates and a radius (simple circle zones) or a polygon (for complex shapes)
-- Players MUST be inside one of these zones AND near water to gold pan
--
-- Optional: Add yieldMultiplier and speed to give zones gold rush bonuses!
-- yieldMultiplier = 1.5 means 50% more gold in this zone
-- speed = 30 means faster minigame speed (default is 40, lower = easier)
Config.AllowedPanningZones = {
    -- Simple circle zones (coords + radius)
    {
        name = "upper_montana_river",
        label = "Upper Montana River",
        type = "circle", -- Circle zone
        coords = vector3(-1640.32, -1361.89, 83.47),
        radius = 150.0, -- Large radius to cover the river area
        -- Optional gold rush settings (remove or set to nil to disable)
        yieldMultiplier = 1.3, -- 30% more gold here
        speed = 35 -- Slightly easier minigame
    },
    {
        name = "dakota_river_north",
        label = "Dakota River (North)",
        type = "circle",
        coords = vector3(331.85, 1246.01, 186.44),
        radius = 120.0,
        yieldMultiplier = 1.2, -- 20% more gold
        speed = 40 -- Normal speed
    },
    {
        name = "little_creek_river",
        label = "Little Creek River",
        type = "circle",
        coords = vector3(-1814.42, 624.28, 129.64),
        radius = 100.0,
        -- No yieldMultiplier = normal gold rates
    },
    -- You can add more zones here
    -- Example polygon zone (for irregular shapes):
    -- {
    --     name = "custom_area",
    --     label = "Custom Mining Area",
    --     type = "polygon",
    --     points = {
    --         vector2(-1600.0, -1400.0),
    --         vector2(-1550.0, -1400.0),
    --         vector2(-1550.0, -1300.0),
    --         vector2(-1600.0, -1300.0),
    --     },
    --     minZ = 75.0,
    --     maxZ = 95.0,
    --     yieldMultiplier = 2.0, -- Double gold!
    --     speed = 25 -- Easy minigame
    -- },
}

Config.waterTypes = { --https://github.com/femga/rdr3_discoveries/tree/master/zones
    {hash = "WATER_AURORA_BASIN", type = "lake", label = "Aurora Basin"},
    {hash = "WATER_BARROW_LAGOON", type = "lake", label = "Barrow Lagoon"},
    {hash = "WATER_CALMUT_RAVINE", type = "lake", label = "Calmut Ravine"},
    {hash = "WATER_ELYSIAN_POOL", type = "lake", label = "Elysian Pool"},
    {hash = "WATER_FLAT_IRON_LAKE", type = "lake", label = "Flat Iron Lake"},
    {hash = "WATER_HEARTLANDS_OVERFLOW", type = "lake", label = "Heartlands Overflow"},
    {hash = "WATER_LAKE_DON_JULIO", type = "lake", label = "Lake Don Julio"},
    {hash = "WATER_LAKE_ISABELLA", type = "lake", label = "Lake Isabella"},
    {hash = "WATER_O_CREAGHS_RUN", type = "lake", label = "O Creaghs Run"},
    {hash = "WATER_OWANJILA", type = "lake", label = "Owanjila"},
    {hash = "WATER_SEA_OF_CORONADO", type = "lake", label = "Sea of Coronado"},
    {hash = "WATER_ARROYO_DE_LA_VIBORA", type = "river", label = "Arroyo de la Vibora"},
    {hash = "WATER_BEARTOOTH_BECK", type = "river", label = "Beartooth Beck"},
    {hash = "WATER_DAKOTA_RIVER", type = "river", label = "Dakota River"},
    {hash = "WATER_KAMASSA_RIVER", type = "river", label = "Kamassa River"},
    {hash = "WATER_LANNAHECHEE_RIVER", type = "river", label = "Lannahechee River"},
    {hash = "WATER_LITTLE_CREEK_RIVER", type = "river", label = "Little Creek River"},
    {hash = "WATER_LOWER_MONTANA_RIVER", type = "river", label = "Lower Montana River"},
    {hash = "WATER_SAN_LUIS_RIVER", type = "river", label = "San Luis River"},
    {hash = "WATER_UPPER_MONTANA_RIVER", type = "river", label = "Upper Montana River"},
    {hash = "WATER_BAYOU_NWA", type = "swamp", label = "Bayou Nwa"},
    {hash = "WATER_BAHIA_DE_LA_PAZ", type = "ocean", label = "Bahia de la Paz"},
    {hash = "WATER_DEADBOOT_CREEK", type = "creek", label = "Deadboot Creek"},
    {hash = "WATER_DEWBERRY_CREEK", type = "creek", label = "Dewberry Creek"},
    {hash = "WATER_HAWKS_EYE_CREEK", type = "creek", label = "Hawks Eye Creek"},
    {hash = "WATER_RINGNECK_CREEK", type = "creek", label = "Ringneck Creek"},
    {hash = "WATER_SPIDER_GORGE", type = "creek", label = "Spider Gorge"},
    {hash = "WATER_STILLWATER_CREEK", type = "creek", label = "Stillwater Creek"},
    {hash = "WATER_WHINYARD_STRAIT", type = "creek", label = "Whinyard Strait"},
    {hash = "WATER_CAIRN_LAKE", type = "pond", label = "Cairn Lake"},
    {hash = "WATER_CATTIAL_POND", type = "pond", label = "Cattial Pond"},
    {hash = "WATER_HOT_SPRINGS", type = "pond", label = "Hot Springs"},
    {hash = "WATER_MATTLOCK_POND", type = "pond", label = "Mattlock Pond"},
    {hash = "WATER_MOONSTONE_POND", type = "pond", label = "Moonstone Pond"},
    {hash = "WATER_SOUTHFIELD_FLATS", type = "pond", label = "Southfield Flats"},

}
