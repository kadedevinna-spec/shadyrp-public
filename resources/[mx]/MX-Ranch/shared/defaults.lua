--[[
================================================================================
  MX-RANCH — DEFAULTS (defaults.lua)
================================================================================
  Base balance values. Buyers usually do NOT need to edit this — use config.lua
  for prices, items, coordinates, and drops.

  Merge (shared/locale.lua):
    1) Loads MXRanchInternalBalance + MXRanchConfigDefaults
    2) Merges with Config from config.lua
    3) Only fills keys that are nil in config (your config wins)

  Sections:
    A) MXRanchConfigDefaults — fallback if config.lua omits a top-level key
    B) MXRanchInternalBalance — hunger, troughs, walk, minigame, security…
    C) Animal types and weights (fallback)
================================================================================
]]

-- =============================================================================
-- A) FALLBACK — only applied if config.lua does NOT define the top-level key
-- =============================================================================
-- Example: if Config.Items is missing in config.lua, these item names are used.

MXRanchConfigDefaults = {
    LocaleLanguage = 'en',              -- default language if config does not set it
    Debug = false,                      -- extra console logs (development)
    Framework = 'rsg',                 -- 'auto' | 'vorp' — framework detection
    RequireJobToBuy = false,            -- buy ranch without job requirement
    MaxRanchesPerPlayer = 1,            -- ranches per player
    AdminGroups = { 'admin', 'god', 'superadmin' }, -- groups with admin commands
    NpcModel = 'a_m_m_vallaborer_01',   -- NPC model for ranch sales
    DefaultBlip = { sprite = 'blip_ambient_herd', scale = 0.28 }, -- ranch map blip
    --- RanchStash, Roles, limits, Items → config.lua (fallback only if missing)
    RanchStash = { Slots = 50, MaxWeight = 200000, AcceptWeapons = true, InteractDistance = 1.0 },
    Roles = { owner = 3, manager = 2, employee = 1 },
    MaxWorkers = 12,
    Items = {
        vaccine = 'vacine', hay = 'hay', water_refill = 'fullbucket',
        milk = 'milk_bucket', goat_milk = 'goat_milk_bucket', egg = 'egg_bucket',
        wool = 'wool_bucket', rake = 'Agarita', manure = 'manure_bucket',
    },
    MaxAnimalsPerRanch = 20,
    MaxAnimalsPerType = 4,
    AdultGrowthHours = 2,
    --- Discord audit logs (see also config.lua → Logs)
    Logs = {
        Enabled = true,
        EnableConsoleAudit = false,
        DiscordStaffWebhook = '',
        Username = 'MX-Ranch Logs',
        AvatarUrl = '',
    },
}

-- =============================================================================
-- B) INTERNAL BALANCE — gameplay, economy, anti-abuse
-- =============================================================================

MXRanchInternalBalance = {
    -- Payments and UI
    PaymentType = 'cash',               -- 'cash' or 'gold' for buy/sell
    UseJobRestriction = false,          -- global job lock (in addition to per-ranch)
    Locale = { Title = 'Ranch' },       -- NUI panel title
    SaveInterval = 120000,              -- ms between automatic DB saves
    BuyRanchNpcMaxDistance = 4.0,       -- max distance to buy-ranch NPC
    TickIntervalMs = 5000,              -- server loop interval (hunger, thirst, troughs)

    -- Hunger and thirst (per loop tick)
    HungerPerTick = 0.028,              -- hunger increase per tick
    ThirstPerTick = 0.031,              -- thirst increase per tick
    HealthLossThirst = 0.32,            -- health loss when thirst critical
    HealthLossHunger = 0.32,            -- health loss when hunger critical
    HealthRegenFromEating = 0.28,       -- health regen when eating at trough
    HealthRegenFromDrinkingExtra = 0.10, -- extra health when drinking

    -- Troughs (food and water)
    TroughCapacity = 200,               -- max capacity per trough
    TroughFillPerUse = 20,              -- fill amount per use (hay/water from inventory)
    TroughHungerFillPerTick = 1.25,     -- hunger reduced per tick when food available
    TroughThirstFillPerTick = 1.35,     -- thirst reduced per tick when water available
    TroughFoodDrainPerAnimalEat = 0.010,  -- food drained when an animal eats
    TroughWaterDrainPerAnimalEat = 0.010, -- water drained when an animal drinks
    TroughFoodPassiveDrain = 0.004,     -- passive food loss in trough
    TroughWaterPassiveDrain = 0.004,    -- passive water loss
    TroughPromptDistance = 2.0,         -- distance for G prompt on trough
    TroughPromptHoldMs = 900,           -- ms to hold G to fill
    TroughText3DDistance = 4.0,         -- 3D text distance (% full)

    -- Interaction distances (client)
    InteractionDistance = 3.2,        -- general ranch interactions
    AnimalPromptDistance = 2.2,       -- G on animal (vaccine, collect, walk)
    ChestPromptDistance = 1.5,        -- chest (if not using RanchStash.InteractDistance)
    AnimalScaleMin = 0.40,            -- minimum visual scale (young)
    AnimalScaleMax = 1.0,             -- maximum visual scale (adult)
    PlacementDistanceMax = 12.0,      -- max distance when placing animal/structure
    PlacementRayMaxDistance = 6.0,    -- ground raycast when placing
    AnimalHomeWanderRadiusM = 5.0,    -- fixed radius around spawn (not the panel slider)
    AnimalWanderRadius = 8.0,         -- default wander radius (panel slider)
    AnimalWanderRadiusMin = 5.0,        -- slider minimum
    AnimalWanderRadiusMax = 18.0,       -- slider maximum

    -- Animal world behavior
    AnimalBehavior = {
        PreventFlee = true,             -- animals do not flee from player
        FriendlyToPlayer = true,          -- friendly attitude
        NoCollisionWithPlayer = false,    -- true = walk through player (may glitch)
        ProximityStopM = 1.3,           -- stop near player at this distance
        ProximityReleaseExtraM = 0.85,  -- resume walking only after moving farther (avoids freeze)
    },

    -- Requirements to collect product (% growth)
    MinGrowthMilk = 50,                 -- min % to milk cow
    MinGrowthWool = 50,                 -- min % to shear sheep
    MinWeightShearFraction = 0.32,      -- min relative weight for wool (fraction of max)

    -- Cooldown between collects (milliseconds)
    ProductCooldowns = {
        MilkMs = 2100000,               -- cow (~35 min)
        GoatMilkMs = 1800000,           -- goat (~30 min)
        WoolMs = 3600000,               -- sheep (~60 min)
        EggMs = 480000,                 -- chicken (~8 min)
    },

    -- "Comfort" — growth bonus when owner is at the ranch
    Immersion = {
        Enabled = true,
        PresenceHeartbeatSec = 22,      -- ranch presence heartbeat interval
        PresenceStaleSec = 150,         -- no heartbeat = presence expires
        ComfortRegenPerTick = 0.08,     -- comfort rises when owner nearby
        ComfortDecayPerTick = 0.038,    -- comfort decays over time
        ComfortGrowthMinMult = 0.90,    -- growth multiplier (low comfort)
        ComfortGrowthMaxMult = 1.15,    -- growth multiplier (high comfort)
        ComfortDiseaseMult = 1.20,      -- disease chance multiplier (low comfort)
    },

    -- WALK — lead animals (XP, level, sell at market)
    AnimalWalk = {
        Enabled = true,
        MaxAnimalsPerWalk = 3,          -- animals per walk session
        ExpPerMeter = 0.022,            -- XP per meter traveled
        ExpPerSecond = 0.010,           -- XP per second while moving
        MaxExpGainPerTick = 0.48,       -- XP cap per tick (anti-farm)
        MaxExperience = 100.0,          -- XP for max level
        MaxLevel = 10,                  -- max animal level
        XpMinIntervalSec = 8,           -- min seconds between XP gains
        XpMinStepM = 0.50,              -- min distance between counted steps
        CooldownMs = 120000,            -- cooldown between starting walks
        FollowOffset = 2.8,             -- distance behind player (1st animal)
        FollowOffsetStep = 1.6,         -- spacing between animals in line
        MaxStartDistanceM = 35.0,       -- max animal distance to start walk
        MaxLeashDistanceM = 52.0,       -- walk cancels if exceeded
        LeashGraceMs = 5500,           -- grace ms before cancel
        MaxFollowDistanceM = 28.0,      -- max follow distance
        MaxSpeedMs = 18.0,              -- max valid speed (anti-teleport)
        DistanceCheckpointM = 6.0,      -- distance checkpoint for XP
        MinSpeedForDistanceM = 0.35,    -- min speed to count movement
        RequireInRanchToAddAnimal = true, -- add to walk only inside ranch zone
    },

    -- Disease and vaccine
    Disease = {
        NeglectChance = 0.0009,         -- chance per tick if hunger/thirst low
        SnakeBiteChance = 0.00015,      -- rare snake bite event
    },
    Vaccine = {
        HealthRestore = 35,             -- health restored when vaccinating
        InteractMaxDistance = 4.0,      -- server max distance to vaccinate
    },

    -- Collect minigame (milk, eggs, wool) — HTML UI
    ProductCollect = {
        MinProductPercent = 95,         -- animal product bar must be ≥ this
        Minigame = {
            Enabled = true,
            MilkHits = 10,              -- hits required (cow/goat) — server validates
            ShearPatches = 11,          -- shear patches (sheep)
            EggPecks = 7,               -- pecks (chicken)
            ItemImageBaseVorp = 'nui://vorp_inventory/html/img/items/',   -- VORP: vorp_inventory/html/img/items/
            ItemImageBaseRsg  = 'nui://rsg-inventory/html/images/',       -- RSG: rsg-inventory/html/images/
            -- ItemImageBase = '...'  -- optional: overrides both frameworks
            FallSpeedMin = 118,         -- min falling icon speed
            FallSpeedMax = 218,         -- max falling icon speed
            SpawnIntervalMs = 400,      -- interval between icon spawns
            GoodChance = 0.36,          -- green (click) vs red (avoid) probability
            MaxMisses = 2,              -- max mistakes before fail
            MaxOnScreen = 9,            -- simultaneous icons on screen
            DurationBufferSec = 1.0,    -- extra time buffer at end
            PartialRewardMult = 0.38,   -- reward multiplier on partial fail
            PartialMinAmount = 1,       -- min items on partial reward
            MinigameMinSec = 4,         -- minimum minigame duration
            SecPerCatch = 1.05,         -- server: seconds per possible catch (anti-macro)
        },
    },

    -- Sell price $ formula (items and MinLevel → config.lua AnimalSell)
    AnimalSell = {
        BaseFromBuyPrice = 0.42,        -- % of buy price as base
        GrowthBonus = 0.26,             -- bonus from growth %
        WeightBonus = 0.16,             -- bonus from weight
        ExperienceBonus = 0.30,         -- bonus from XP/level
        MinGrowth = 20,                 -- min growth % to sell
        MinHealth = 42,                 -- min health to sell
        MinLevel = 2,                   -- min level (config.MinLevel overrides if set)
        ItemRewards = {
            Enabled = false,            -- sell items normally come from config.lua
        },
    },

    -- Map market (coordinates → config.lua AnimalSellYard.Locations)
    AnimalSellYard = {
        Enabled = true,                 -- false = disable map markets
        InteractDistance = 5.0,         -- general zone distance
        NpcInteractDistance = 3.5,      -- G prompt distance at NPC
        MaxAnimalDistanceM = 22.0,      -- animal on walk must be ≤ this from NPC
        NpcModel = 'a_m_m_vallaborer_01',
        Blip = {
            sprite = 531267562,
            scale = 0.32,
            label = 'Livestock market',
        },
        Locations = {},                 -- filled from config.lua
    },

    -- Ground manure (realism + disease)
    Droppings = {
        Enabled = true,
        PoopChancePerTick = 0.16,       -- chance to spawn manure per tick
        PoopMinIntervalSec = 1800,      -- min seconds between manure from same animal
        MaxPerRanch = 12,               -- max piles per ranch
        PropModel = 'mp007_p_mp_horsepoop03x',
        FilthDiseaseThreshold = 4,      -- disease rises from N piles onward
        FilthSickChanceBase = 0.0018,
        FilthSickChancePerPile = 0.007,
        FilthSickChanceCap = 0.11,
        FilthHealthDrainPerPile = 0.032,
        CleanMaxDistance = 3.8,         -- distance to clean with rake
        ManurePerClean = 1,             -- manure items per clean
    },

    -- Anti-spam / anti-cheat — cooldowns between actions (ms)
    Security = {
        EventCooldownDefault = 450,
        CooldownBuyRanch = 2500,
        CooldownAnimalInteract = 750,
        CooldownFillTrough = 1400,
        CooldownBuyAnimal = 2200,
        CooldownBuyStructure = 2200,
        CooldownOpenStash = 900,
        CooldownUpdateAnimalPos = 220,      -- animal position sync
        CooldownSetAnimalWanderRadius = 350,
        CooldownCollectEggs = 1600,
        CooldownHireFire = 3500,
        CooldownDepositRanchCash = 1200,
        CooldownWithdrawRanchCash = 1200,
        CooldownRanchPresence = 8000,
        CooldownRequestSync = 2000,
        CooldownSetAnimalSpawn = 2500,
        CooldownAnimalWalk = 1200,          -- start/stop walk
        CooldownSellAnimal = 3500,          -- sell at market
        CooldownCollectProduct = 2200,      -- start collect
        CooldownPeekCollectProduct = 900,
        CooldownCompleteCollectMinigame = 600,
        CooldownApplyVaccine = 2800,
        CooldownRanchAnimBroadcast = 400,
        CooldownWalkHeartbeat = 1200,       -- walk heartbeat
        CooldownUpdateWebhook = 10000,
        CooldownAdminTeleport = 1200,
        CooldownAdminDeleteRanch = 2500,
        MaxPlacementDistanceFromPlayer = 32.0,
        MilkWeightBonusCap = 11,            -- milk drop weight bonus cap (server)
        WoolWeightBonusCap = 9,
        ServerAnimalInteractMaxDistance = 16.0, -- server validation distance
    },
}

-- =============================================================================
-- C) TYPES AND WEIGHTS — species list; weights overridden by Config.AnimalWeightKg
-- =============================================================================

MXRanchAnimalTypes = {
    vacas = true,
    galinhas = true,
    porcos = true,
    ovelhas = true,
    cabras = true,
}

--- min/max kg (fallback; config.lua AnimalWeightKg takes priority)
MXRanchWeightRanges = {
    cabras = { 8, 45 },
    galinhas = { 1, 5 },
    porcos = { 18, 115 },
    vacas = { 45, 220 },
    ovelhas = { 10, 55 },
}

--- Collect drops if config.lua does not define ProductDrops
MXRanchProductDropDefaults = {
    milk = { base = 1, weightMult = 8, maxAmount = 11 },
    goat_milk = { base = 1, weightMult = 8, maxAmount = 11 },
    egg = { base = 1, highGrowth = 2, highGrowthMin = 70 },
    wool = { base = 1, weightMult = 6, maxAmount = 9 },
}
