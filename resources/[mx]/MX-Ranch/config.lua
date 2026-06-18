--[[
================================================================================
  MX-RANCH — SERVER CONFIG (config.lua)
================================================================================
  Main file for buyers: tune your server here.

  • config.lua     → items, ranch limits, stash, prices, weights, drops, market
  • defaults.lua   → hunger, thirst, minigame, XP, distances, anti-cheat (advanced)

  Both are merged on resource start (shared/locale.lua).
  Restart after edits: ensure MX-Ranch
================================================================================
]]

Config = Config or {}

-- =============================================================================
-- SERVER — general
-- =============================================================================

--- UI language (locales/en.json, locales/pt.json, …)
Config.LocaleLanguage = 'en'

--- true = only players with the ranch job (per ranch) can buy that ranch at the NPC
Config.RequireJobToBuy = true

--- How many ranches each player may own
Config.MaxRanchesPerPlayer = 1

--- Panel permissions: owner > manager > employee (number = minimum role level)
Config.Roles = {
    owner = 3,
    manager = 2,
    employee = 1,
}

--- Max hired workers per ranch
Config.MaxWorkers = 12

--- Animal limits
Config.MaxAnimalsPerRanch = 20   -- total on one ranch
Config.MaxAnimalsPerType = 4     -- max per species (cows, chickens, etc.)
Config.AdultGrowthHours = 2      -- hours until 100% growth (adult)

-- =============================================================================
-- ITEMS — vorp_inventory mapping
-- =============================================================================
-- Each key is used by the script; the value is the EXACT item name in your database.
-- Example: milking gives the player Config.Items.milk

Config.Items = {
    vaccine = 'vacine',        -- vaccinate sick animal
    hay = 'hay',                -- fill food trough
    water_refill = 'water_bucket', -- fill water trough
    milk = 'milk',             -- cow collection
    goat_milk = 'milk',        -- goat collection (can match milk)
    egg = 'eggs',              -- chicken collection
    wool = 'wool',             -- sheep shearing
    rake = 'ranch_rake',       -- clean manure on the ground
    manure = 'ranch_manure',   -- item received when cleaning manure
}

-- =============================================================================
-- PRICES — buy animals in /ranch panel ($)
-- =============================================================================

Config.AnimalPrices = {
    vacas = 180,
    galinhas = 35,
    porcos = 120,
    ovelhas = 95,
    cabras = 85,
}

-- =============================================================================
-- STRUCTURES — ranch panel shop
-- =============================================================================

--- Price in $ per structure (max one per type per ranch, except species-specific troughs)
Config.StructurePrices = {
    food_trough = 75,    -- food trough (per species)
    water_trough = 65,   -- water trough (per species)
    chicken_coop = 320,  -- chicken coop
    storage_chest = 280, -- shared ranch stash
}

--- World prop model — do not use random invalid names
Config.StructurePropModels = {
    food_trough = 'p_feedtrough01x',
    water_trough = 'p_watertrough01x',
    chicken_coop = 'p_chickencoopcart01x',
    storage_chest = 's_lootablemiscchest_wagon',
}

-- =============================================================================
-- ANIMAL WEIGHT (kg)
-- =============================================================================
-- Affects: visual scale, sell price, byWeight drop/sell amounts.
-- Weight increases as the animal grows toward max.

Config.AnimalWeightKg = {
    vacas = { min = 45, max = 220 },
    galinhas = { min = 1, max = 5 },
    porcos = { min = 18, max = 115 },
    ovelhas = { min = 10, max = 55 },
    cabras = { min = 8, max = 45 },
}

-- =============================================================================
-- DROPS — collect product (J on animal + minigame)
-- =============================================================================
-- How many items the player gets after a successful collect (milk, eggs, wool).

Config.ProductDrops = {
    --- Cow milk — amount scales with weight
    milk = {
        base = 1,         -- minimum items
        weightMult = 8,   -- multiplier from weight (weight/max × mult)
        maxAmount = 11,   -- cap on a full collect
    },
    --- Goat milk 
    goat_milk = { base = 1, weightMult = 8, maxAmount = 11 },
    --- Chicken eggs — 2 eggs if growth >= highGrowthMin %
    egg = { base = 1, highGrowth = 2, highGrowthMin = 70 },
    --- Sheep wool when shearing
    wool = { base = 1, weightMult = 6, maxAmount = 9 },
}

-- =============================================================================
-- LIVESTOCK MARKET — animals on walk + map NPC
-- =============================================================================
-- Extra rules (min growth, health, $ formula) are in defaults.lua → AnimalSell

Config.AnimalSell = {
    --- Minimum animal level (XP / walks) required to sell
    MinLevel = 1,

    ItemRewards = {
        --- false = cash only; true = also grant items below
        Enabled = true,

        --- Per species. Each row = one item.
        --- item = EXACT vorp_inventory name (used on sell)
        --- itemKey = optional: looks up Config.Items (if your DB name differs, e.g. meat → 'beef')
        --- count = fixed amount | min/max = random (without byWeight)
        --- byWeight = true → qty ≈ weight_kg × perKg, clamped by min and max

        vacas = {
            { item = 'meat', byWeight = true, perKg = 0.04, min = 2, max = 12 },
            { item = 'leather', byWeight = true, perKg = 0.015, min = 1, max = 5 },
        },
        galinhas = {
            { item = 'feather', min = 2, max = 6 },
            { item = 'meat', byWeight = true, perKg = 0.04, min = 2, max = 12 },
        },
        ovelhas = {
            { item = 'meat', byWeight = true, perKg = 0.04, min = 2, max = 12 },
            { item = 'leather', byWeight = true, perKg = 0.02, min = 1, max = 3 },
        },
        cabras = {
            { item = 'leather', byWeight = true, perKg = 0.05, min = 1, max = 4 },
        },
        porcos = {
            { item = 'meat', byWeight = true, perKg = 0.06, min = 2, max = 10 },
            { item = 'leather', byWeight = true, perKg = 0.02, min = 1, max = 4 },
        },
    },
}

-- =============================================================================
-- LIVESTOCK MARKET — map locations (blip + NPC)
-- =============================================================================
-- Player brings animals on WALK here and presses G at the NPC.
-- Other options (distance, NPC model, blip) are in defaults.lua → AnimalSellYard

Config.AnimalSellYard = {
    Locations = {
        -- x, y, z = position | w = NPC heading
        { x = -2446.3010, y = -2460.5691, z = 60.1715, w = 312.9421 },
        { x = -368.85, y = -256.38, z = 45.67, w = 0.0 },
    },
}

-- =============================================================================
-- RANCH STASH (storage_chest structure)
-- =============================================================================

Config.RanchStash = {
    Slots = 50,              -- stash inventory slots
    MaxWeight = 200000,      -- max weight (vorp_inventory)
    AcceptWeapons = true,    -- allow weapons in stash
    InteractDistance = 2.5,  -- distance to open with G
}

-- =============================================================================
-- DISCORD LOGS — player (per-ranch webhook in /ranch) + staff (global)
-- =============================================================================
-- Owner sets webhook URL in the General tab (like MX-Playerstore).
-- Staff webhook receives all ranch events + admin actions.

Config.Logs = {
    Enabled = true,
    EnableConsoleAudit = false,
    --- Global staff webhook (admin create/edit/delete, teleport, and duplicate of player events)
    DiscordStaffWebhook = '',
    Username = 'MX-Ranch Logs',
    AvatarUrl = '',
}
