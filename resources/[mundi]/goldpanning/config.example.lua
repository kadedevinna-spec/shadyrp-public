-- ===============================================
-- GOLD PANNING CONFIGURATION
-- ===============================================
-- This script supports both VORP and RSG frameworks!
-- The framework is auto-detected - no configuration needed.
-- ===============================================

Config = {}

Config.debug = false -- Enable/disable debug output (set to true for troubleshooting)

-- ===============================================
-- INTERACTION SYSTEM
-- ===============================================
-- Set to "ox_target" to use ox_target for interactions (requires ox_target to be loaded before the script in your server.cfg)
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
            key = 0xF3830D8E -- J key
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

-- ===============================================
-- ITEM CONFIGURATION
-- ===============================================
-- These item names must match your inventory database!
-- For VORP: Check your vorp_inventory items table
-- For RSG: Check your rsg-inventory/shared/items.lua
Config.cradleProp = "p_goldcradlestand01x" -- Prop name for the gold panning cradle 
Config.waterItem = "fullbucket" -- Water item needed for panning 
Config.emptyWaterItem = "bucket" -- Empty water can returned after use 
Config.sedimentItem = "river_sediment" -- Item received when collecting at riverbed 
Config.mudBucketItem = "mud_bucket" -- Item needed to collect sediment 
Config.goldPanItem = "goldpan" -- Gold pan tool item 
Config.goldReward = "gold_flakes" -- Gold flakes reward item
Config.extraReward = "gold_nugget" -- Extra reward item (rare)

-- ===============================================
-- GOLD PAN DEGRADATION
-- ===============================================
Config.GoldPanDegradation = {
    enabled = true,           -- Enable/disable gold pan degradation
    degradeChance = 100,      -- 100% chance to degrade on use (always degrades)
    degradeAmount = 3,        -- How much to degrade per use (3 durability per use)
    maxDurability = 100,      -- Max durability of a gold pan (~33 uses before breaking)
    breakNotification = "Your gold pan broke from wear and tear!"
}

-- ===============================================
-- REWARD SYSTEM
-- ===============================================
Config.Rewards = {
    -- This controls how much the minigame performance affects the outcome.
    -- A higher value means a good minigame score gives a better chance for rare loot.
    minigameMultiplierInfluence = 0.2, -- Very low - skill matters less, luck matters more

    -- Defines the chances for getting 0, 1, 2, or 3 gold flakes.
    -- Weights determine relative probability (higher weight = more common)
    flakes = {
        {amount = 0, weight = 80}, -- 80% chance to find nothing
        {amount = 1, weight = 14}, -- 14% chance - uncommon
        {amount = 2, weight = 4},  -- 4% chance - rare
        {amount = 3, weight = 2}   -- 2% chance - very rare
    },

    -- Defines the chances for getting gold nuggets (separate roll from flakes)
    -- Nuggets are EXTREMELY RARE finds
    nuggets = {
        {amount = 0, weight = 98},   -- 98% chance to find no nugget
        {amount = 1, weight = 1.5},  -- 1.5% chance - extremely rare
        {amount = 2, weight = 0.5}   -- 0.5% chance - legendary
    }
}

-- ===============================================
-- CRADLE & TIMING SETTINGS
-- ===============================================
Config.cradlePlacementDistance = 1.5
Config.cradleInteractionDistance = 2.0
Config.mixTime = 12000 -- Building animation time (ms)
Config.pourTime = 8000 -- Pouring animation time (ms)
Config.sedimentPerPan = 5 -- Amount of sediment consumed per pan
Config.waterPerPan = 1 -- Amount of water consumed per pan
Config.cradleModel = "p_goldcradlestand01x" -- Model name for cradle 
Config.cradleLabel = "Gold Wash Cradle"
Config.cradleIcon = "fas fa-bowl-rice"

-- ===============================================
-- NOTIFICATIONS
-- ===============================================
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

-- ===============================================
-- DEPLETION SYSTEM
-- ===============================================
Config.Depletion = {
    enabled = true,
    depletionRate = 0.01, -- How much each pan depletes the area (1% per pan)
    recoveryRate = 0.005, -- How much recovers per minute (0.5% per minute)
    minYield = 0.1, -- Minimum yield multiplier when depleted (10% of normal)
    
    -- Grid-based depletion (each 500m x 500m area depletes independently)
    minSuccessfulPans = 5, -- Minimum pans before depletion
    maxSuccessfulPans = 12, -- Maximum pans before depletion
}

-- ===============================================
-- ACTION COOLDOWNS (prevent spam)
-- ===============================================
Config.actionCooldowns = {
    collectWater = 3, -- 3 seconds between water collections
    collectSediment = 3, -- 3 seconds between sediment collections
    pourWater = 2, -- 2 seconds between pouring water
    pourSediment = 2, -- 2 seconds between pouring sediment
    pickupCradle = 2, -- 2 seconds between cradle pickups
}

-- ===============================================
-- WEATHER EFFECTS
-- ===============================================
Config.WeatherEffects = {
    enabled = true,
    
    -- Weather multipliers for gold yield and success rate
    weatherConditions = {
        -- Clear/Sunny: Best conditions
        SUNNY = { yield = 1.0, successRate = 1.0, speedPenalty = 1.0 },
        CLEAR = { yield = 1.0, successRate = 1.0, speedPenalty = 1.0 },
        
        -- Cloudy: Slightly reduced
        CLOUDS = { yield = 0.95, successRate = 0.95, speedPenalty = 1.05 },
        OVERCAST = { yield = 0.9, successRate = 0.9, speedPenalty = 1.1 },
        
        -- Rain: Significantly harder
        RAIN = { yield = 0.7, successRate = 0.7, speedPenalty = 1.3 },
        DRIZZLE = { yield = 0.8, successRate = 0.8, speedPenalty = 1.2 },
        THUNDER = { yield = 0.5, successRate = 0.6, speedPenalty = 1.5 },
        
        -- Fog: Poor visibility
        FOG = { yield = 0.75, successRate = 0.75, speedPenalty = 1.25 },
        
        -- Snow: Very difficult
        SNOW = { yield = 0.4, successRate = 0.5, speedPenalty = 1.8 },
        BLIZZARD = { yield = 0.3, successRate = 0.4, speedPenalty = 2.0 },
        
        -- High activity weather
        HIGHPRESSURE = { yield = 0.6, successRate = 0.65, speedPenalty = 1.4 },
    },
    
    showWeatherNotification = true,
    notificationDuration = 5000,
}

-- ===============================================
-- LOCATION MULTIPLIERS
-- ===============================================
Config.LocationMultipliers = {
    river = 0.6,   -- Rivers have reduced gold
    creek = 0.4,   -- Creeks have less gold
    lake = 0.3,    -- Lakes have poor gold
    pond = 0.2,    -- Ponds have very little gold
    swamp = 0.1,   -- Swamps have terrible gold yield
    ocean = 0      -- Ocean has almost no gold
}

-- ===============================================
-- GOLD RUSH LOCATIONS
-- ===============================================
-- Yields and difficulty randomize on server start
Config.GoldRushLocations = {
    enabled = true,
    
    locations = {
        { coords = vector3(331.85, 1246.01, 186.44), radius = 100.0, label = "Dakota River" },
        { coords = vector3(-1640.32, -1361.89, 83.47), radius = 100.0, label = "Upper Montana River" },
        { coords = vector3(-1814.42, 624.28, 129.64), radius = 80.0, label = "Little Creek River" },
        { coords = vector3(1145.33, -723.19, 73.08), radius = 60.0, label = "Elysian Pool" },
        { coords = vector3(2144.52, -761.84, 42.33), radius = 90.0, label = "Kamassa River" },
        { coords = vector3(1550.18, 436.48, 88.99), radius = 70.0, label = "O'Creagh's Run" },
        { coords = vector3(-1405.42, -2301.89, 43.42), radius = 85.0, label = "Owanjila Lake" },
        { coords = vector3(-1753.88, -2408.44, 42.98), radius = 95.0, label = "San Luis River" },
        { coords = vector3(2458.67, -387.12, 41.86), radius = 110.0, label = "Lannahechee River" },
        { coords = vector3(745.33, -1311.77, 43.21), radius = 65.0, label = "Stillwater Creek" },
    },
    
    showLocationNotification = false, -- Keep gold rush zones mysterious
    notificationDuration = 5000,
    
    -- Randomization settings (applied on server restart)
    randomization = {
        minYield = 0.8,
        maxYield = 1.3,
        minSpeed = 35,
        maxSpeed = 50,
    }
}

-- ===============================================
-- TIME OF DAY EFFECTS
-- ===============================================
Config.TimeOfDayBonus = {
    enabled = true,
    dawn = 0.95,     -- 5am-8am
    day = 1.0,       -- 8am-6pm
    dusk = 0.9,      -- 6pm-8pm
    night = 0.7      -- 8pm-5am
}

-- ===============================================
-- WATER TYPES (zone detection)
-- ===============================================
Config.waterTypes = {
    -- Lakes
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
    -- Rivers
    {hash = "WATER_ARROYO_DE_LA_VIBORA", type = "river", label = "Arroyo de la Vibora"},
    {hash = "WATER_BEARTOOTH_BECK", type = "river", label = "Beartooth Beck"},
    {hash = "WATER_DAKOTA_RIVER", type = "river", label = "Dakota River"},
    {hash = "WATER_KAMASSA_RIVER", type = "river", label = "Kamassa River"},
    {hash = "WATER_LANNAHECHEE_RIVER", type = "river", label = "Lannahechee River"},
    {hash = "WATER_LITTLE_CREEK_RIVER", type = "river", label = "Little Creek River"},
    {hash = "WATER_LOWER_MONTANA_RIVER", type = "river", label = "Lower Montana River"},
    {hash = "WATER_SAN_LUIS_RIVER", type = "river", label = "San Luis River"},
    {hash = "WATER_UPPER_MONTANA_RIVER", type = "river", label = "Upper Montana River"},
    -- Swamp
    {hash = "WATER_BAYOU_NWA", type = "swamp", label = "Bayou Nwa"},
    -- Ocean
    {hash = "WATER_BAHIA_DE_LA_PAZ", type = "ocean", label = "Bahia de la Paz"},
    -- Creeks
    {hash = "WATER_DEADBOOT_CREEK", type = "creek", label = "Deadboot Creek"},
    {hash = "WATER_DEWBERRY_CREEK", type = "creek", label = "Dewberry Creek"},
    {hash = "WATER_HAWKS_EYE_CREEK", type = "creek", label = "Hawks Eye Creek"},
    {hash = "WATER_RINGNECK_CREEK", type = "creek", label = "Ringneck Creek"},
    {hash = "WATER_SPIDER_GORGE", type = "creek", label = "Spider Gorge"},
    {hash = "WATER_STILLWATER_CREEK", type = "creek", label = "Stillwater Creek"},
    {hash = "WATER_WHINYARD_STRAIT", type = "creek", label = "Whinyard Strait"},
    -- Ponds
    {hash = "WATER_CAIRN_LAKE", type = "pond", label = "Cairn Lake"},
    {hash = "WATER_CATTIAL_POND", type = "pond", label = "Cattial Pond"},
    {hash = "WATER_HOT_SPRINGS", type = "pond", label = "Hot Springs"},
    {hash = "WATER_MATTLOCK_POND", type = "pond", label = "Mattlock Pond"},
    {hash = "WATER_MOONSTONE_POND", type = "pond", label = "Moonstone Pond"},
    {hash = "WATER_SOUTHFIELD_FLATS", type = "pond", label = "Southfield Flats"},
}
