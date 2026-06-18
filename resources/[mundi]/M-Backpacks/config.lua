Config = {}

-- ================================================================================================
-- LOCALE SETTINGS
-- ================================================================================================

Config.Locale = "en"                         -- Language for notifications (see locale.lua for available languages)

-- ================================================================================================
-- GENERAL SETTINGS
-- ================================================================================================

Config.Debug = false                         -- Enable debug prints (set to false in production)
-- Framework is now auto-detected! No need to set it manually.
-- Supports: VORP (vorp_core + vorp_inventory) and RSG (rsg-core + rsg-inventory)

-- ================================================================================================
-- RSG ITEM DECAY SETTINGS (RSG Framework Only)
-- ================================================================================================
-- Controls whether backpack ITEMS can decay/spoil when stored in stashes (bank, business, etc.)
-- When a backpack item decays to 0 quality and delete is true, it is permanently removed.
-- This means the backpack AND everything inside it is lost forever!
--
-- NOTE: This does NOT affect items INSIDE the backpack - only the backpack item itself.
-- Items inside backpacks follow their own decay rules from RSGCore.Shared.Items.

Config.RSGDecay = {
    enabled = false,                        -- false = backpacks NEVER decay (recommended, prevents accidental loss)
                                            -- true  = backpacks CAN decay (uses decayMinutes below)
    decayMinutes = nil,                     -- Time in minutes for backpack to go from 100 to 0 quality
                                            -- nil = no decay time (even if enabled=true, nil means no decay)
                                            -- 1440 = 24 hours, 10080 = 7 days, 43200 = 30 days
    deleteOnDecay = false,                  -- false = backpack stays at 0 quality but is NOT deleted
                                            -- true  = backpack is PERMANENTLY DELETED when quality hits 0
                                            --         WARNING: This destroys the backpack AND all items inside!
}

-- ================================================================================================
-- WEARABLE BACKPACK PROPS (Visual backpack on player's back)
-- ================================================================================================

Config.WearableProps = {
    enabled = false,                         -- Master toggle: true = show backpack props, false = disable entirely
    networked = false,                       -- true = other players can see your backpack (slightly more network load)
                                            -- false = only you see your backpack (better performance for high pop servers)
    
    -- Prop definitions for each backpack tier
    -- When a player has this backpack item in their inventory, the prop will appear on their back
    -- You can find more props at: https://redlookup.com/objects
    --
    -- HOW TO ADD CUSTOM PROPS FROM OTHER SCRIPTS (e.g., hawk_backpack, hawk_prop_native_backpack_2):
    --   1. The other script MUST be running so its streamed models are available
    --   2. Copy the 'model' name from that script's config
    --   3. Copy the 'position' (x, y, z) and 'rotation' (rx, ry, rz) values from that script's 'attach' table
    --   4. Add a new entry below matching your backpack item name from Config.Backpacks
    --
    -- IMPORTANT: The key (e.g., 'backpack_tier1') must match an item name in Config.Backpacks above!
    --            The 'model' must either be a base-game prop OR streamed by another running resource.
    props = {
        -- =============================================================================
        -- DEFAULT PROPS (base game models, always available)
        -- =============================================================================
        ['backpack_tier1'] = {
            model = 'p_ambpack04x',                         -- Small satchel prop
            position = vector3(-0.2, -0.1, 0.06),           -- Offset from bone (x, y, z)
            rotation = vector3(20.0, 0.0, -90.0),           -- Rotation (pitch, roll, yaw)
            bone = 'CP_Back',                               -- Bone to attach to (CP_Back for back)
        },
        ['backpack_tier2'] = {
            model = 'p_ambpack02x',                         -- Medium backpack prop
            position = vector3(-0.35, 0.0, 0.12),
            rotation = vector3(-70.0, 0.0, -90.0),
            bone = 'CP_Back',
        },
        ['backpack_tier3'] = {
            model = 'p_ambpack01x',                         -- Large backpack prop
            position = vector3(-0.5, 0.0, 0.08),
            rotation = vector3(-80.0, 0.0, -90.0),
            bone = 'CP_Back',
        },

        -- =============================================================================
        -- CUSTOM PROP EXAMPLES (from hawk_backpack / hawk_prop_native_backpack_2)
        -- Uncomment and rename the KEY to match YOUR backpack item name in Config.Backpacks
        -- These models require hawk_backpack or hawk_prop_native_backpack_2 to be running!
        -- =============================================================================

        -- Native bag from hawk_prop_native_backpack_2 (requires that resource running)
        -- ['your_item_name_here'] = {
        --     model = 'native_bag_02_001',
        --     position = vector3(-0.07, -0.02, -0.01),
        --     rotation = vector3(77.0, 0.0, 90.0),
        --     bone = 'CP_Back',
        -- },

        -- Native bag 2 from hawk_prop_native_backpack_2
        -- ['your_item_name_here'] = {
        --     model = 'native_bag_02_002',
        --     position = vector3(-0.41, -0.02, -0.06),
        --     rotation = vector3(77.0, 0.0, 91.0),
        --     bone = 'CP_Back',
        -- },

        -- Medic backpack from hawk_backpack (requires hawk_backpack running)
        -- ['your_item_name_here'] = {
        --     model = 'medic_backpack_001',
        --     position = vector3(-0.05, -0.02, 0.02),
        --     rotation = vector3(-74.0, 0.0, -89.0),
        --     bone = 'CP_Back',
        -- },

        -- Medic backpack 2 from hawk_backpack
        -- ['your_item_name_here'] = {
        --     model = 'medic_backpack_002',
        --     position = vector3(-0.07, -0.04, 0.03),
        --     rotation = vector3(-74.0, 0.0, -88.0),
        --     bone = 'CP_Back',
        -- },

        -- Explorer backpack from hawk_backpack
        -- ['your_item_name_here'] = {
        --     model = 'explorers_backpack_001',
        --     position = vector3(-0.52, 0.0, 0.02),
        --     rotation = vector3(-2.0, -80.0, 186.0),
        --     bone = 'CP_Back',
        -- },

        -- Small pack from hawk_backpack (model: backpack_005)
        -- ['your_item_name_here'] = {
        --     model = 'backpack_005',
        --     position = vector3(-0.11, -0.01, 0.09),
        --     rotation = vector3(-70.0, 1.0, -87.0),
        --     bone = 'CP_Back',
        -- },

        -- Pack from hawk_backpack (model: backpack_008)
        -- ['your_item_name_here'] = {
        --     model = 'backpack_008',
        --     position = vector3(-0.2, -0.04, 0.04),
        --     rotation = vector3(-73.0, 5.0, 275.0),
        --     bone = 'CP_Back',
        -- },

        -- Pack from hawk_backpack (model: backpack_009)
        -- ['your_item_name_here'] = {
        --     model = 'backpack_009',
        --     position = vector3(-0.2, -0.04, 0.04),
        --     rotation = vector3(-73.0, 5.0, 275.0),
        --     bone = 'CP_Back',
        -- },

        -- Base game worker pack (no extra resource needed)
        -- ['your_item_name_here'] = {
        --     model = 'p_ambpack05x',
        --     position = vector3(-0.53, 0.0, 0.0),
        --     rotation = vector3(0.0, 74.0, 0.0),
        --     bone = 'CP_Back',
        -- },

        -- Base game arrow bundle (no extra resource needed)
        -- ['your_item_name_here'] = {
        --     model = 'p_arrowbundle01x',
        --     position = vector3(-0.10, 0.0, 0.0),
        --     rotation = vector3(0.0, 0.0, 58.0),
        --     bone = 'CP_Back',
        -- },
    }
}

-- ================================================================================================
-- BACKPACK TIERS
-- ================================================================================================

Config.Backpacks = {
    ['backpack_tier1'] = {
        label = 'Small Backpack',
        slots = 25,
        weight = 100,                       -- Max weight in kg (separate from player inventory)
        tier = 1,
        description = 'A small worn satchel with limited storage',
        upgradeable = true,
        acceptWeapons = true,               -- Allow weapons to be stored
        shared = true,                      -- MUST be true so items persist when backpack is traded to another player
        ignoreItemStackLimit = true,       -- Respect item stack limits
        whitelistItems = {},                -- Empty = allow all items (or add specific items like {'water', 'bread'})
        blacklistItems = {'backpack_tier1', 'backpack_tier2', 'backpack_tier3'}  -- Prevent backpacks inside backpacks
    },
    ['backpack_tier2'] = {
        label = 'Medium Backpack',
        slots = 50,
        weight = 100,
        tier = 2,
        description = 'A sturdy leather backpack with decent storage',
        upgradeable = true,
        acceptWeapons = true,
        shared = true,                      -- MUST be true so items persist when backpack is traded to another player
        ignoreItemStackLimit = true,
        whitelistItems = {},
        blacklistItems = {'backpack_tier1', 'backpack_tier2', 'backpack_tier3'}  -- Prevent backpacks inside backpacks
    },
    ['backpack_tier3'] = {
        label = 'Large Backpack',
        slots = 100,
        weight = 100,
        tier = 3,
        description = 'A spacious rucksack',
        upgradeable = false,                -- Max tier
        acceptWeapons = true,
        shared = true,                      -- MUST be true so items persist when backpack is traded to another player
        ignoreItemStackLimit = true,
        whitelistItems = {},
        blacklistItems = {'backpack_tier1', 'backpack_tier2', 'backpack_tier3'}  -- Prevent backpacks inside backpacks
    }
}

-- ================================================================================================
-- INVENTORY RESTRICTIONS
-- ================================================================================================

Config.MaxBackpacksPerPlayer = 1            -- Maximum backpacks a regular player can carry

-- One Backpack Type Only - prevents carrying multiple different types of backpacks at once
-- When enabled: Player can only have ONE backpack total (can't have small + medium + large)
-- When disabled: Player can have one of EACH type (one small, one medium, one large - old behavior)
Config.OneBackpackTypeOnly = true           -- true = only one backpack regardless of type, false = one of each type allowed

-- Grace Period - how long (in minutes) players have to deal with excess backpacks before enforcement
-- Players will be warned immediately on login, then excess backpacks will be dropped after this time
Config.BackpackLimitGracePeriod = 60        -- 60 minutes (1 hour) grace period

-- Jobs that can carry multiple backpacks (for traders, merchants, etc.)
Config.SpecialJobs = {
    'merchant',
    'trader',
    'supplier'
}

-- Maximum backpacks for special jobs
Config.MaxBackpacksSpecialJob = 3

-- ================================================================================================
-- ITEM USE LOCK (Anti-Dupe Exploit Protection)
-- ================================================================================================
-- Prevents a duplication exploit where players could:
-- 1. Use an item (e.g., empty bucket at water source)
-- 2. Quickly move the item to their backpack before the server removes it
-- 3. The server fails to find/remove the item but still gives the new item
-- Result: Player has both items (duplicate)
--
-- This system AUTOMATICALLY detects when any item is used and temporarily blocks
-- it from being moved to a backpack. Works with ALL scripts including escrowed ones!

Config.ItemUseLock = {
    enabled = true,                         -- Enable automatic item use lock protection
    lockDuration = 10000,                    -- How long (in ms) to block moving an item after it's used
                                            -- 5000 = 5 seconds - enough time for most item swap operations
                                            -- Increase if your scripts have longer animations/delays
}

-- ================================================================================================
-- DISCORD WEBHOOK LOGGING
-- ================================================================================================

Config.Discord = {
    enabled = false,                         -- Enable Discord webhook logging
    webhook = '',                           -- Your Discord webhook URL (leave empty to disable)
    botName = 'M-Backpacks',               -- Bot name shown in Discord
    botAvatar = '',                         -- Avatar URL for the bot (optional)
    
    -- Embed Colors (decimal format)
    colors = {
        backpackOpened = 3066993,           -- Green - player opened backpack
        backpackCreated = 3447003,          -- Blue - new backpack created
        backpackTransferred = 15105570,     -- Gold - backpack traded between players
        itemAdded = 5763719,                -- Teal - item added to backpack
        itemRemoved = 15158332              -- Red - item removed from backpack
    },
    
    -- What to log (toggle each event type)
    logBackpackOpened = false,               -- Log when player opens a backpack
    logBackpackCreated = false,              -- Log when a new backpack is created (first use)
    logBackpackTransferred = true,          -- Log when backpack moves between players
    logItemsAdded = true,                   -- Log when items are put into backpacks
    logItemsRemoved = true,                 -- Log when items are taken from backpacks
    logExploitAttempts = true               -- Log when exploit attempts are blocked
}
