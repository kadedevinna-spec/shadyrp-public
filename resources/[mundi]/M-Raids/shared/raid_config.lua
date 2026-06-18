-- ============================================================================
--                         M-RAIDS CONFIGURATION
-- ============================================================================
-- Organized configuration file for the M-Raids System
--
-- HOW TO CONFIGURE:
--   * Global settings apply to ALL raids (e.g., Config.Loot.accessTimer)
--   * Per-raid settings override global defaults (e.g., raid.accessTimer)
--   * Set a value to nil to use the global default
--   * Set a value to false to explicitly disable a feature
--
-- TABLE OF CONTENTS:
--   1. General Settings         - Debug mode, admin permissions, commands
--   2. Timing & Cooldowns       - Raid cooldowns, travel timeout, access timers
--   3. Entity & Spawning        - Entity limits, spawn distribution, timing
--   4. GPS & Waypoints          - Map waypoints, blips, routes
--   5. Multiplayer Settings     - Hybrid mode, network optimization
--   6. Notifications & Sounds   - Notification settings
--   7. Law Alert System         - Automatic law enforcement alerts
--   8. Interaction System       - Prompts, interaction types, distances
--   9. Loot System              - Chests, animations, items, access control
--   10. Global NPC & Combat     - Default NPC behavior, weapons, combat
--   11. Raid Locations          - Individual raid configurations (TEMPLATE)
-- ============================================================================

Config = {}

-- ============================================================================
--                        1. GENERAL SETTINGS
-- ============================================================================

Config.Debug  = false                       -- Enable debug output (set true for troubleshooting)
Config.Locale = 'en'                        -- Language for player-facing messages (see locales/ folder)

Config.AdminAceGroup = 'raid.admin'         -- Ace permission for admin bypass (add to server.cfg: add_ace group.admin raid.admin allow)
Config.AdminGroups = {'admin', 'superadmin', 'mod'}  -- Fallback group names that can bypass cooldowns

-- Admin commands — usage examples:
--   /m_endraid              - End active raid
--   /m_endraid 123          - End raid with ID 123
--   /m_endraid fort_mercer  - End raid at fort_mercer location
--   /m_endraid all          - End all active raids
--   /m_endbankwagon         - End all bank wagon robberies
--   /m_endbankwagon 456     - End bank wagon with ID 456
--   /m_endbankwagon rhodes  - End bank wagon on "rhodes" route
--   /m_startraid fort_mercer - Start raid at fort_mercer
--   /m_resetcooldown        - Reset all raid cooldowns
--   /m_resetcooldown NARO   - Reset cooldown for NARO jurisdiction
--   /m_resetcooldown fort_mercer - Reset cooldown for fort_mercer location
Config.AdminCommands = {
  endRaid = {
    enabled = true,                         -- Enable /m_endraid command
    command = 'm_endraid',                    -- Command name
    allowConsole = true,                    -- Allow execution from server console
    requireAdmin = true                     -- Require admin permissions (uses AdminAceGroup/AdminGroups)
  },
  endBankWagon = {
    enabled = true,                         -- Enable /m_endbankwagon command
    command = 'm_endbankwagon',               -- Command name
    allowConsole = true,                    -- Allow execution from server console
    requireAdmin = true                     -- Require admin permissions (uses AdminAceGroup/AdminGroups)
  },
  startBankWagon = {
    enabled = true,                         -- Enable /m_startbankwagon command (testing only)
    command = 'm_startbankwagon',             -- Command name
    allowConsole = true,                    -- Allow execution from server console
    requireAdmin = true                     -- Require admin permissions
  },
  startRaid = {
    enabled = true,                         -- Enable /m_startraid command
    command = 'm_startraid',                  -- Command name
    allowConsole = true,                    -- Allow execution from server console
    requireAdmin = false                    -- Anyone can use (testing/gameplay)
  },
  resetCooldown = {
    enabled = true,                         -- Enable /m_resetcooldown command
    command = 'm_resetcooldown',            -- Command name
    allowConsole = true,                    -- Allow execution from server console
    requireAdmin = true                     -- Require admin permissions (uses AdminAceGroup/AdminGroups)
  },
  -- Status / diagnostic commands
  raidStatus = {
    enabled = true,                         -- Enable /m_raidstatus command
    command = 'm_raidstatus',               -- Command name
    allowConsole = true,                    -- Allow from server console
    requireAdmin = true                     -- Require admin permissions
  },
  testRaidWave = {
    enabled = true,                         -- Enable /m_testraidwave command
    command = 'm_testraidwave',             -- Command name
    allowConsole = false,
    requireAdmin = true
  },
  unlockRaidLoot = {
    enabled = true,                         -- Enable /m_unlockraidloot command
    command = 'm_unlockraidloot',           -- Command name
    allowConsole = true,
    requireAdmin = true
  },
  testLawAlert = {
    enabled = true,                         -- Enable /m_testlawalert command
    command = 'm_testlawalert',             -- Command name
    allowConsole = false,
    requireAdmin = true
  },
  -- Client-side debug commands
  testVault = {
    enabled = true,                         -- Enable /m_testvault command
    command = 'm_testvault',                -- Command name
    allowConsole = false,
    requireAdmin = true
  },
  clearVault = {
    enabled = true,                         -- Enable /m_clearvault command
    command = 'm_clearvault',               -- Command name
    allowConsole = false,
    requireAdmin = true
  },
  showNpcs = {
    enabled = true,                         -- Enable /m_shownpcs command
    command = 'm_shownpcs',                 -- Command name
    allowConsole = false,
    requireAdmin = true
  }
}

-- ============================================================================
--                        2. TIMING & COOLDOWNS
-- ============================================================================

-- RAID COOLDOWNS
Config.RaidCooldown = 30.0                  -- Cooldown between raids PER JURISDICTION (minutes)
Config.TravelTimeout = 10                    -- Time to reach raid location before cancellation (minutes)
Config.BodyCleanupDelay = 6                -- Minutes after raid completion to auto-cleanup dead NPC bodies and entities
                                            -- Set to 0 for instant cleanup on completion, nil to disable (rely on abandon timer)

-- RAID END CONDITION
-- Controls when the jurisdiction is freed and the raid cooldown starts.
--   'npcs_dead'  = Jurisdiction freed as soon as all NPCs/waves are dead (original behaviour).
--                  Chests can still be looted after, but another raid may start in same jurisdiction.
--   'all_looted' = Jurisdiction stays locked until ALL loot chests have been opened/claimed
--                  AND all NPCs/waves are dead. Prevents new raids until looting is finished.
Config.RaidEndCondition = 'all_looted'      -- 'npcs_dead' or 'all_looted'
Config.RaidEndLootTimeout = 15              -- Safety timeout (minutes) after NPCs are dead before
                                            -- forcing jurisdiction free even if chests aren't all looted.
                                            -- Set to 0 or nil to disable (rely only on abandon timer)

-- ENEMY BLIPS
-- Controls when blips appear on remaining raid NPCs so players can find them.
Config.EnemyBlipsEnabled = true              -- Set to false to disable enemy NPC blips entirely.
Config.EnemyBlipThreshold = 0               -- Show blips when this many (or fewer) enemies remain alive.
                                            -- Set to 0 to ALWAYS show blips on ALL NPCs (no threshold).
                                            -- Set to 5 to only show blips on the last 5 enemies, etc.

-- JURISDICTION SYSTEM
-- Multiple raids can run simultaneously in DIFFERENT jurisdictions
-- Only ONE raid per jurisdiction at a time (minor or major) - each has its own cooldown timer
Config.JurisdictionExclusive = true         -- If true, only ONE raid (minor or major) can run per jurisdiction at a time
                                            -- If false, multiple raids can run simultaneously in the same jurisdiction
Config.Jurisdictions = {
  NARO = { name = "New Austin", lawJobs = {"NARO"} },       -- New Austin Sheriff's Office
  LSO = { name = "Lemoyne", lawJobs = {"LSO"} },            -- Lemoyne Sheriff's Office
  NHSO = { name = "New Hanover", lawJobs = {"NHSO"} },      -- New Hanover Sheriff's Office
  WESO = { name = "West Elizabeth", lawJobs = {"WESO"} },   -- West Elizabeth Sheriff's Office
}

-- ============================================================================
--                        3. ENTITY SPAWNING SETTINGS
-- ============================================================================

-- ENTITY LIMITS
Config.MaxRaidEntities = 20                 -- Default maximum number of active raid entities (sentries + patrols + wave NPCs)
                                            -- Can be overridden per raid with 'maxEntities' field
                                            -- NOTE: Turrets do NOT count towards this limit
                                            -- WARNING: Increasing above 22 may cause game crashes
                                            -- With 150ms stagger delay: 22 NPCs + 3 turrets = 25 total entities spawned safely

-- SPAWN DISTRIBUTION (how sentries vs patrols are selected)
Config.SpawnDistribution = {
  mode = 'weighted',                        -- 'random' (truly random) or 'weighted' (use sentryChance)
  sentryChance = 0.60                       -- When mode='weighted': chance to spawn sentry vs patrol (0.0-1.0)
                                            -- 0.60 = 60% sentries, 40% patrols
                                            -- 0.50 = 50/50 split
                                            -- 0.70 = 70% sentries, 30% patrols
}

-- SPAWN TIMING (prevents entity overload crashes)
Config.SpawnTiming = {
  staggerDelay = 75,                        -- Delay between spawning each NPC (ms)
  turretDelay = 500,                        -- Delay after spawning turrets before spawning NPCs (ms)
}

-- ============================================================================
--                        4. GPS & WAYPOINT SETTINGS
-- ============================================================================

Config.Waypoint = {
  routeColor = "COLOR_RED",                 -- GPS route color
  blipEnabled = true,                       -- Show blip at destination
  blipSprite = "blip_ambient_bounty_hunter", -- Blip sprite name (hashed with GetHashKey)
  blipColor = "BLIP_MODIFIER_MP_COLOR_2",  -- Blip color modifier (red)
  blipScale = 0.2,                          -- Blip size
  blipName = "Raid Location",               -- Blip label on map
  arrivalDistance = 300.0,                  -- Distance to count as "arrived" and start spawning NPCs (meters)
  waypointClearDistance = 30.0,            -- Distance at which GPS route, blip and waypoint are removed (meters)
}

-- Active raid blip (shown at the raid boundary center while the raid is in progress)
Config.ActiveRaidBlip = {
  enabled = true,                            -- Show a blip at the raid location during an active raid
  sprite = "blip_ambient_bounty_hunter",     -- Blip sprite name (hashed with GetHashKey)
  color = "BLIP_MODIFIER_MP_COLOR_2",       -- Blip color modifier string (red)
  scale = 0.2,                               -- Blip size on map
  name = "Raid Location",                    -- Label shown on map hover
}

-- Start NPC map blip (shown at raid NPC locations on the map)
Config.StartNPCBlip = {
  enabled = false,                            -- Set false to disable start NPC blips entirely
  alwaysShowBlip = false,                     -- When true, blips are shown on the map at all times (even before NPC is spawned/discovered)
  sprite = "blip_ambient_eyewitness",        -- Blip sprite name (hashed with GetHashKey)
  color = "BLIP_MODIFIER_MP_COLOR_32",       -- Blip color modifier string
  scale = 0.2,                               -- Blip size on map
  name = "Raid Contact",                     -- Label shown on map hover
}

-- ============================================================================
--                        5. MULTIPLAYER & PERFORMANCE
-- ============================================================================

-- HYBRID MODE (Server Authority with Client AI)
Config.HybridMode = {
  enabled = true,                           -- Enable hybrid mode (server validation, anti-cheat, host migration)
  
  -- HOST PERFORMANCE MONITORING
  hostPerformance = {
    enabled = true,                         -- Monitor host performance and migrate if needed
    pingThreshold = 300,                    -- Max ping before considering host migration (ms)
    checkInterval = 30000,                  -- How often to check host performance (ms)
    migrationCooldown = 60000,              -- Cooldown between host migrations (ms)
  },
  
  -- SERVER VALIDATION (Lightweight)
  validation = {
    enabled = true,                         -- Server validates all NPC deaths and events
    maxKillDistance = 1000.0,               -- Maximum distance to allow kill (meters) - anti-cheat for suspiciously long kills
  },
}

-- AI PERFORMANCE (Network/Connection Lag Optimization)
Config.AIPerformance = {
  patrolCheckInterval = 1500,               -- How often patrols check for players/combat (ms)
  sentryCheckInterval = 1500,               -- How often sentries check for players/combat (ms)
  deathCheckInterval = 3000,                -- How often to check if NPC is dead (ms)
  boundaryCheckInterval = 4000,             -- How often to check if NPC is outside boundary (ms)
  combatWaitInterval = 1500,                -- How often to check combat status during engagement (ms)
}
-- NOTE: Higher intervals = better for high ping (150ms+), Lower intervals = more responsive AI for low ping (<50ms)

-- ============================================================================
--                        6. NOTIFICATIONS & SOUNDS
-- ============================================================================

Config.Notifications = {
  soundEnabled = true,                      -- Enable sound effects for notifications
  soundName = 'INFO',                       -- Sound set to use
  soundRef = 'HUD_SHOP_SOUNDSET'            -- Sound ref
}

-- ============================================================================
--                        7. LAW ALERT SYSTEM
-- ============================================================================

Config.LawAlerts = {
  enabled = true,                           -- Global toggle for law alerts
  
  -- TIMING MODE (can be overridden per raid)
  timingMode = 'random',                    -- 'exact' or 'random'
  
  -- EXACT MODE: Alert at specific raid milestone
  triggerPoint = 'sentries_cleared',              -- Options: 'raid_start', 'sentries_cleared', 'waves_cleared', 'loot_opened'
  
  -- RANDOM MODE: Random delay after sentries/patrols cleared
  randomDelay = {
    min = 30,                               -- Minimum seconds
    max = 180                               -- Maximum seconds
  },
  
  -- ALERT DISPLAY
  notification = {
    duration = 8000,                        -- Notification display time (ms)
    title = 'Fort Alarm',                   -- Notification title
    message = 'The alarm bells at %s are ringing!',  -- %s = location name
    icon = 'law'                            -- Notification icon
  },
  
  -- MAP BLIP
  blip = {
    radius = 150.0,                         -- Blip radius on map (meters)
    color = 2,                              -- Blip color (2 = red)
    alpha = 128,                            -- Blip transparency (0-255)
    duration = 60000                        -- Blip display time (ms)
  },
  
  -- DEFAULT LAW JOBS (can be overridden per raid)
  defaultJobs = {'WESO', 'NHSO', 'LSO', 'NARO', 'USMO'}
}

-- ============================================================================
--                     7b. JOB RESTRICTIONS (GLOBAL)
-- ============================================================================
-- allowedJobs — job WHITELIST applied globally to ALL raids.
--   nil  = any job can start a raid (default)
--   list = only these jobs can start a raid (in addition to the per-raid
--          friendlyJobs blacklist, which still applies independently)
-- Override per-raid by setting  allowedJobs = {...}  inside a raid table.
-- Example:  Config.AllowedJobs = { 'outlaw', 'vagabond' }
Config.AllowedJobs = nil

-- Denial message when a player's job is not in the whitelist.
-- Managed through locale files — edit locales/en.lua: check_allowed_jobs
-- Individual raid locations can still override via: allowedJobsMessage = "custom text"

-- ============================================================================
--                        8. INTERACTION SYSTEM
-- ============================================================================

Config.InteractionType = 'prompt'           -- 'prompt' or 'ox_target'

-- NATIVE PROMPT SETTINGS
Config.NativePrompt = {
  startRaid = {
    key = 0x760A9C6F,                       -- G key (RedM input hash)
    label = 'Start Raid',                   -- Text displayed on prompt
    holdDuration = 1000,                    -- Hold time in ms (0 = instant)
    maxDistance = 2.0                       -- Max distance to show prompt (meters)
  },
  lootChest = {
    key = 0x760A9C6F,                       -- G key
    label = 'Open Loot Chest',              -- Text displayed on prompt
    holdDuration = 1000,                    -- Hold time in ms
    maxDistance = 2.0                       -- Max distance (meters)
  }
}


-- ============================================================================
--                        8b. NPC DIALOGUE (REJECTION LINES)
-- ============================================================================
-- These are the lines the NPC says when a player tries to interact but
-- something is blocking the raid. Each reason has a table of random lines.
-- Use %s as a placeholder for dynamic values (minutes remaining, location name, item names, etc.)
-- The system picks a random line from the table each time.

Config.NPCDialogue = {
  -- When pre-check hasn't completed yet (server didn't respond in time)
  unavailable = {
    "Not right now, friend. Come back in a moment.",
    "Hold on... its not the right time yet.",
  },
  -- Fallback when no specific reason matches
  fallback = {
    "Not right now, friend. Come back another time.",
  },
  -- Cooldown active (%s = minutes remaining)
  cooldown = {
    "Place is too hot right now. Guards are still on edge... come back in about %s minutes.",
    "Ain't happening right now, friend. Come back in %s minutes when things cool down.",
    "Too much heat. Give it %s more minutes before we try anything.",
    "The guards doubled their patrols after what happened. Wait %s minutes.",
    "Patience, friend. We need about %s more minutes before we can make a move.",
  },
  -- Another raid already active in the jurisdiction (%s = location name)
  active_raid = {
    "Someone's already stirring up trouble at %s. Wait till that mess is over.",
    "There's already a job going on at %s. Can't do two at once.",
    "Not now. %s is already under attack. One fight at a time.",
  },
  -- Player missing required items (%s = item names)
  missing_items = {
    "You ain't ready for this. Come back when you have what we need: %s.",
    "Can't do it without the right supplies. You're missing: %s.",
    "Listen, I ain't sending you in unprepared. Go find: %s.",
  },
  -- Not enough law online
  not_enough_law = {
    "Not enough of them around for this to be worth the risk. Come back later.",
    "Need more lawmen out and about before we make our move. Too quiet right now.",
    "Ain't worth the trouble unless there's enough law to keep busy. Come back later.",
  },
  -- Law enforcement too close to the NPC
  law_nearby = {
    "Come back when it's safer, friend. Too many badges around here.",
    "Are you blind? There's law crawling all over. Get out of here.",
    "Not with the law this close. Come back when they've moved on.",
  },
  -- Player's job is not in the AllowedJobs whitelist
  allowed_jobs = {
    "This ain't the kind of work for someone in your line. Move along.",
    "Sorry friend, this job's not for your type.",
    "Can't help you with this one. Ain't your kind of business.",
  },
  -- Player IS law enforcement / friendly job
  friendly_job = {
    "Move along, lawman. Nothing for you here.",
    "I don't talk to badges.",
    "Best you keep walking, friend.",
    "Ain't got nothing to say to the law.",
    "Wrong place for your kind, sheriff.",
  },
}

-- ============================================================================
--                        9. LOOT SYSTEM (GLOBAL DEFAULTS)
-- ============================================================================
-- These settings control loot chests and item drops for ALL raids
-- Individual raids can override any of these settings in their config

Config.Loot = {
  
  -- ===================================================================
  --                    ACCESS CONTROL
  -- ===================================================================
  -- Controls when players can access loot chests/vaults after raid starts
  
  -- ACCESS TIMER (GLOBAL DEFAULT)
  -- When set to a number (minutes), players MUST WAIT before looting
  -- Timer starts when sentries/patrols are cleared
  -- When set to nil, uses the 80% enemy clear requirement instead
  --
  -- Options:
  --   nil     = Use 80% enemy clear requirement (default)
  --   false   = Force 80% clear (blocks raid timer overrides)
  --   number  = Timer in minutes (e.g., 2.5 = 2m 30s)
  --
  -- Per-Raid Override: Each raid can set its own `accessTimer` value
  -- Example: fort_mercer.accessTimer = 2.5  (overrides this global setting)
  
  accessTimer = nil,                          -- GLOBAL: nil = use 80% clear | number = timer in minutes
  
  -- ===================================================================
  --                    CHEST APPEARANCE & INTERACTION
  -- ===================================================================
  
  pickupDistance = 2.0,                       -- Distance to interact with loot (meters)
  boxModel = 'mp001_p_mp_strongbox01x_lrg',  -- Prop model for loot chests
  spawnRadius = 0.0,                          -- Spawn randomization jitter (meters, 0.0 = exact coords)
  defaultBoxCount = { min = 2, max = 3 },     -- Default box count range
  boxCapacity = 20,                           -- Max inventory slots per chest
  
  -- ===================================================================
  --                    MINIGAME SYSTEM (GLOBAL DEFAULT)
  -- ===================================================================
  -- Controls what minigame players must complete to open loot boxes
  -- Can be overridden per-raid or per-box
  --
  -- Global Options:
  --   enabled = false              - No minigames, instant loot access
  --   type = 'padlock'             - All boxes use padlock minigame
  --   type = 'lockpick'            - All boxes use lockpick minigame (future)
  --   type = 'random'              - Randomly choose from available types
  --
  -- Per-Raid Override: raid.loot.minigame = { type = 'lockpick', difficulty = 'hard' }
  -- Per-Box Override: raid.loot.minigames = { [1] = {...}, [2] = {...} }
  
  minigame = {
    enabled = true,                           -- Enable minigames globally
    type = 'random',                          -- Default: 'padlock', 'lockpick', 'random'
    
    -- PADLOCK SETTINGS (when type = 'padlock')
    digits = 3,                               -- Number of digits (2-5)
    code = 'random',                          -- 'random' or specific code like '1234'
    mode = 'hint',                            -- 'hint' or 'bruteforce'
    failurePenalty = 0,                       -- Seconds to wait after failure
    
    -- LOCKPICK SETTINGS (when type = 'lockpick')
    difficulty = 'medium',                    -- 'easy', 'medium', 'hard'
    requiredItem = 'lockpick',                -- Item required to attempt lockpick
    maxAttempts = 0,                          -- 0 = unlimited tries (as long as they have lockpicks), >0 = lock breaks after X tries
    
    -- RANDOM SELECTION (when type = 'random')
    randomPool = { 'padlock', 'lockpick' }    -- Types to randomly choose from
  },
  
  -- ===================================================================
  --                    LOOT AMOUNTS & ITEMS
  -- ===================================================================
  itemsPerBox = { min = 1, max = 3 },         -- Random item count per chest
  
  -- INVENTORY SETTINGS
  registerSettings = {
    limit = 20,                               -- Inventory slot limit
    acceptWeapons = true,                     -- Allow weapons in chest
    shared = true,                            -- Multiple players can loot same chest
    ignoreItemStackLimit = true,              -- Ignore item stack limits
    whitelistItems = nil                      -- Whitelist specific items (nil = all items)
  },
  
  -- ANIMATIONS
  animations = {
    enabled = true,                           -- Enable looting animation
    searchDict = 'script_mp@moonshiner@story_missions@moon2@ig3_stashsearch_find',
    searchAnim = 'stashsearch_find_male',
    duration = 5000,                          -- Animation length (ms)
    freezePlayer = true,                      -- Prevent movement during animation
    playDuringProgress = true,                -- Play animation during progress bar
    syncWithProgressBar = true,               -- Sync animation duration to match progress bar length
    freezeOnComplete = true,                  -- Freeze animation when progress bar completes
    freezeAtPercent = 0.95,                   -- Freeze at this percent of animation (0.0-1.0)
    resumeSpeed = 3.0,                        -- Speed multiplier when resuming after inventory closes
  },
  
  -- ITEM SELECTION (Default for raids that don't specify)
  itemSelection = {
    mode = 'random',                          -- 'all', 'random', or 'weighted'
    randomCount = { min = 1, max = 3 },       -- Items to pick if mode='random'
  },
  
  -- ===================================================================
  --                    ITEM QUANTITY CONFIGURATION
  -- ===================================================================
  -- How to specify item quantities in loot tables:
  --
  -- FORMAT 1: Simple (default quantity = 1)
  --   { name = 'goldbar', chance = 50 }
  --
  -- FORMAT 2: Fixed quantity
  --   { name = 'goldbar', chance = 50, quantity = 5 }
  --   Result: Always gives 5x goldbar when rolled successfully
  --
  -- FORMAT 3: Random quantity range
  --   { name = 'goldbar', chance = 50, quantity = {min = 2, max = 5} }
  --   Result: Gives 2-5x goldbar (random) when rolled successfully
  --
  -- FORMAT 4: With money reward
  --   { name = 'moneybag', chance = 60, quantity = 3, moneyReward = {min = 20, max = 80} }
  --   Result: 3x moneybag, each worth $20-$80
  --
  -- Example loot table:
  --   items = {
  --     { name = 'intel_folder', chance = 70, quantity = 1 },
  --     { name = 'goldbar', chance = 30, quantity = {min = 2, max = 4} },
  --     { name = 'lockpick', chance = 50, quantity = 3 },
  --     { name = 'moneybag', chance = 60, moneyReward = {min = 50, max = 150} }
  --   }
  
  defaultItemQuantity = 1,                    -- Default quantity when not specified
  
  -- PROGRESS BAR SETTINGS (Default for all raids)
  progressBar = {
    enabled = true,                           -- Enable progress bar during looting
    duration = 5000,                          -- Duration in milliseconds
    label = 'Searching chest...'              -- Display text
  }
}

-- ============================================================================
--                        10. GLOBAL NPC & COMBAT DEFAULTS
-- ============================================================================
-- These settings apply to ALL raids unless overridden per raid
-- Includes: Health, Accuracy, Combat Behavior, Weapons, Reinforcements

Config.Global = {}

-- NPC COMBAT & AI
Config.Global.AI = {
  -- HEALTH & DAMAGE
  healthBase = 120,                           -- Base NPC health
  leaderHealthMultiplier = 1.6,               -- Health multiplier for wave leaders
  accuracyBase = 80,                          -- Base accuracy (0-100)
  accuracyPerDifficulty = 20,                 -- Accuracy increase per difficulty level

  -- PERCEPTION & AWARENESS
  seeingRange = 80.0,                         -- How far NPCs can see enemies (meters)
  hearingRange = 40.0,                        -- How far NPCs can hear gunshots (meters)
  
  -- COMBAT BEHAVIOR
  combatMovement = 1,                         -- Movement style (0=stationary, 1=defensive, 2=offensive)
  combatAbilityBase = 1,                      -- Base combat ability (0-3)
  combatAbilityMax = 3,                       -- Maximum combat ability
  coverChance = 40,                           -- Chance to use cover (0-100)
  
  -- SPAWNING
  spawnJitter = 0.0,                          -- Random spawn position offset (meters)

  -- PATROL BEHAVIOR (for sentries and wave NPCs)
  patrolRadius = 30.0,                        -- Radius for random patrol waypoints (meters)
  patrolPoints = 4,                           -- Number of waypoints per patrol cycle
  patrolWaitTime = 3000,                      -- Wait time at each waypoint (ms)

  -- NPC ROLES (assigned to wave enemies)
  leaderPerWave = true,                       -- Spawn one leader per wave
  roles = {
    leader = { weapon = 'WEAPON_SHOTGUN_PUMP', healthMult = 1.2 },
    sniper = { weapon = 'WEAPON_SNIPERRIFLE_ROLLINGBLOCK', healthMult = 1.0 },
    ranged = { weapon = 'WEAPON_REPEATER_WINCHESTER', healthMult = 1.0 },
    melee = { weapon = 'WEAPON_REVOLVER_CATTLEMAN', healthMult = 1.0 },
    brute = { weapon = 'WEAPON_REVOLVER_DOUBLEACTION', healthMult = 1.1 }
  },

  -- WEAPON POOLS (randomly selected for NPCs)
  weaponPools = {
    snipers = {
      'WEAPON_SNIPERRIFLE_ROLLINGBLOCK',
      'WEAPON_SNIPERRIFLE_CARCANO'
    },
    shotguns = {
      'WEAPON_SHOTGUN_PUMP',
      'WEAPON_SHOTGUN_SEMIAUTO',
      'WEAPON_SHOTGUN_DOUBLEBARREL'
    },
    revolvers = {
      'WEAPON_REVOLVER_CATTLEMAN',
      'WEAPON_REVOLVER_SCHOFIELD',
      'WEAPON_REVOLVER_LEMAT',
      'WEAPON_REVOLVER_DOUBLEACTION'
    },
    repeaters = {
      'WEAPON_REPEATER_WINCHESTER',
      'WEAPON_REPEATER_HENRY',
      'WEAPON_REPEATER_EVANS',
      'WEAPON_REPEATER_CARBINE'
    },
    pistols = {
      'WEAPON_PISTOL_MAUSER',
      'WEAPON_PISTOL_M1899',
      'WEAPON_PISTOL_SEMIAUTO'
    }
  },

  -- REINFORCEMENTS (dynamic spawning during raid)
  reinforcements = {
    enabled = true,                           -- Enable reinforcement spawning
    
    -- TRIGGER MODE: When reinforcements spawn (works for raids WITH or WITHOUT waves)
    triggerMode = 'timer',                    -- 'threshold', 'timer', 'sentries_cleared', or 'random'
    thresholdPercent = 70,                    -- For 'threshold': Spawn when X% of wave remains (waves only)
    delaySeconds = 60,                        -- For 'timer': Seconds after sentries/patrols cleared OR wave starts
    randomChance = 30,                        -- For 'random': X% chance every check
    randomCheckInterval = 15,                 -- For 'random': Check every X seconds
    
    -- SPAWN FREQUENCY
    spawnFrequency = 'per_wave',              -- 'once', 'per_wave', or 'unlimited'
    
    count = 3,                                -- Number of reinforcements
    scaleMultiplier = 1.1,                    -- Difficulty scaling multiplier
    mountHorses = true,                       -- Spawn reinforcements on horses
  },
  
  -- DIFFICULTY SCALING
  difficulty = {
    playersDivisor = 2.0                      -- Player count / this = difficulty multiplier
  }
}

-- SENTRY DEFAULTS (guards at raid start)
Config.Global.SentryDefaults = {
  model = nil,                                -- Default model (nil = use raid's npcModels)
  weapon = nil,                               -- Default weapon (nil = auto-select from pools)
  
  -- RANGES
  aggroRange = 80.0,                          -- Engagement distance (meters)
  seeingRange = 80.0,                         -- Detection range (meters)
  hearingRange = 40.0,                        -- Sound detection range (meters)
  
  -- MOVEMENT
  unfreezeDistance = 20.0,                    -- Distance before sentries can move freely (meters)
                                              -- Sentries stay stationary until player gets within this range
                                              -- They can still shoot and react, just won't reposition
                                              -- Once unlocked, they can move, take cover, and chase
  leashDistance = 100.0,                      -- Max chase distance before returning (meters, 0 = infinite)
  leashStuckThreshold = 10,                   -- Kill sentry after this many consecutive leash triggers
                                              -- Prevents NPCs stuck in unreachable geometry from blocking raids
                                              -- Set to 0 or nil to disable (sentry stays stuck forever)
  
  -- PATROL
  patrolRoute = nil                           -- Patrol waypoints (nil = stationary)
}

-- TURRET DEFAULTS (mounted weapons)
Config.Global.TurretDefaults = {
  spawnMode = 'dynamic',                      -- 'static' (all) or 'dynamic' (random selection)
  dynamicCount = 3,                           -- Turret count in dynamic mode
  
  -- COMBAT
  fireRate = 2000,                            -- Time between shots (ms)
  accuracy = 30,                              -- Accuracy modifier (lower = more spread)
  range = 300.0,                              -- Engagement range (meters)
  
  -- BEHAVIOR
  breakable = true,                           -- Turrets break when gunner dies
  disableOnDeath = true,                      -- Disable turret when gunner dies
  dismountDistance = 5.0,                     -- Gunner dismounts at this range (meters)
  spawnGracePeriod = 10.0,                    -- Delay before dismount allowed (seconds)
  antiCheat = true                            -- Prevent gunner removal exploits
}


-- ============================================================================
--                        11. RAID LOCATIONS
-- ============================================================================
-- Define each raid location with specific configurations
-- 
-- HOW RAID SETTINGS WORK:
--   * Global defaults (Config.Loot, Config.Global, etc.) apply to ALL raids
--   * Per-raid settings OVERRIDE the global defaults
--   * Set to nil to use global default
--   * Set to false to explicitly disable
--
-- RAID CONFIGURATION SECTIONS (in order):
--   1. BASIC INFO               - Name, enabled status, jurisdiction
--   2. LOCATION & START         - Start point, NPC model, dialogue
--   3. REQUIREMENTS             - Required items, law count, friendly jobs
--   4. TIMING                   - Wave delays, access timers
--   5. ACCESS CONTROL           - When loot becomes available
--   6. BOUNDARY & RADIUS        - Raid area, notification radius
--   7. LAW ALERTS               - Law enforcement notification settings
--   8. NPC CONFIGURATION        - Models, weapons, behavior
--   9. LOOT SETTINGS            - Loot boxes, items (overrides Config.Loot)
--   10. POSITIONS               - Sentries, patrols, turrets, waves, loot
--   11. SPECIAL FEATURES        - Alarms, vaults, custom mechanics
-- ============================================================================

Config.Raids = {
  -- ==========================================================================
  --                         FORT MERCER RAID
  -- ==========================================================================
  --#region  NARO Fort Mercer
  fort_mercer = {
    
    -- ========================================================================
    --                    1. BASIC INFO
    -- ========================================================================
    name = "Fort Mercer",                     -- Display name
    enabled = true,                           -- Enable this raid
    jurisdiction = "NARO",                    -- Jurisdiction (NARO, LSO, NHSO, WESO)
    
    -- ========================================================================
    --                    2. LOCATION & START NPC
    -- ========================================================================
    startPoint = vector4(-4362.49, -3074.89, -9.92, 91.91),  -- Raid start NPC location
    startNPCModel = 's_m_m_fussarhenchman_01', -- Model for raid start NPC
    notifyRadius = 20.0,                      -- Radius to notify players about raid start
    
    -- START NPC SCENARIOS
    scenario = "WORLD_HUMAN_BADASS",           -- Initial scenario
    idleScenarios = {                         -- Scenarios to cycle through
      "WORLD_HUMAN_CLIPBOARD",
      "WORLD_HUMAN_SMOKING",
      "WORLD_HUMAN_STAND_WAITING"
    },
    scenarioCycleInterval = 2,                -- Minutes between scenario changes
    
    -- START NPC DIALOGUE
    dialogue = {
      enabled = true,                         -- Enable interactive dialogue
      greetingDistance = 3.0,                 -- Distance to trigger greeting
      resetDistance = 50.0,                   -- Distance to reset dialogue
      
      animations = {
        talk = { type = "scenario", name = "WORLD_HUMAN_STAND_IMPATIENT" },
        give_map = { type = "anim", dict = "mech_inspection@letter@base", anim = "grab", flag = 0, duration = 3000 },
        player_take_map = { type = "anim", dict = "mech_inspection@letter@base", anim = "hold", flag = 49, duration = -1, prop = "s_mollyloveletter" },
      },
      
      lines = {
        greeting = "look who's here",
        steps = {
          { label = "You think we can do this?", text = "We? who said anything about we?", anim = "talk" },
          { label = "Okay...", text = "Look I helped ya get this far but this is a federal fort we are talking about. Yall are on your own from here.", anim = "talk" },
          { label = "I hope you arent expecting a cut", text = "You already did enough for, those del lobo's were a pain in my ass. If you are looking for the fort I can mark it on your map.", anim = "give_map", playerAnim = "player_take_map", action = "start" }
        },
        missingItem = "You're not prepared. Bring me a %s and then we can talk."
      }
    },

    -- ========================================================================
    --                    3. REQUIREMENTS & RESTRICTIONS
    -- ========================================================================
    --requiredItem = {"crim_raid_fort_mercer_schedule","crim_raid_explosives_high","crim_raid_prototype_order"},                       -- Item required to start (e.g., 'raid_map')
    consumeRequiredItem = false,              -- Remove item after starting
    friendlyJobs = {"NARO", "USMO", "WESO", "LSO", "NHSO", "USDO"},  -- Jobs that CANNOT start this raid
    minLawCount = nil,                        -- Minimum law officers required (nil = no requirement)
    
    -- ========================================================================
    --                    4. TIMING
    -- ========================================================================
    waveDelay = 2.0,                          -- Delay between waves in MINUTES
    
    -- ========================================================================
    --                    5. ACCESS CONTROL (LOOT TIMER)
    -- ========================================================================
    -- Controls when players can access loot chests/vaults
    -- Overrides Config.Loot.accessTimer for this specific raid
    --
    -- Options:
    --   nil     = Use Config.Loot.accessTimer (global default)
    --   false   = Force 80% enemy clear requirement (ignore global timer)
    --   number  = Timer in minutes (e.g., 2.5 = 2 minutes 30 seconds)
    --
    -- How it works:
    --   * Timer starts when sentries/patrols are cleared
    --   * Players must wait this duration before looting
    --   * Overrides the default 80% enemy clear requirement
    
    accessTimer = 2.5,                        -- 2.5 minutes - wait after clearing sentries/patrols
    
    -- ========================================================================
    --                    6. BOUNDARY & RADIUS
    -- ========================================================================
    boundary = {
      center = vector3(-4209.71, -3458.6, 37.29),
      radius = 300.0                          -- Radius for abandonment, NPC tethering, raid blocking
    },
    
    -- ========================================================================
    --                    7. LAW ALERTS
    -- ========================================================================
    lawAlerts = {
      enabled = true,
      timingMode = 'random',                  -- 'exact' or 'random'
      triggerPoint = 'sentries_cleared',      -- For 'exact': raid_start, sentries_cleared, waves_cleared, loot_opened
      randomDelay = { min = 30, max = 180 },  -- For 'random': seconds after sentries/patrols cleared
      jobs = {'NARO'}                         -- Law jobs to alert (nil = use jurisdiction default)
    },
    
    -- ========================================================================
    --                    8. NPC CONFIGURATION
    -- ========================================================================
    
    -- NPC MODELS
    npcModels = { 's_m_y_army_01' },
    leaderModel = 's_m_y_army_01',

    -- PATROL BEHAVIOR (overrides Config.Global.SentryDefaults)
    patrolRadius = 40.0,                      -- Patrol radius (meters)
    patrolPoints = 3,                         -- Patrol waypoints count
    patrolWaitTime = 6000,                    -- Wait time at waypoints (ms)

    -- WEAPON POOLS (overrides Config.Global.WeaponPools)
    weaponPools = {
      snipers = { 'WEAPON_RIFLE_BOLTACTION', 'WEAPON_SNIPERRIFLE_ROLLINGBLOCK', 'WEAPON_SNIPERRIFLE_CARCANO' },
      repeaters = { 'WEAPON_REPEATER_WINCHESTER', 'WEAPON_REPEATER_HENRY', 'WEAPON_REPEATER_EVANS', 'WEAPON_REPEATER_CARBINE' },
      revolvers = { 'WEAPON_REVOLVER_CATTLEMAN', 'WEAPON_REVOLVER_SCHOFIELD', 'WEAPON_REVOLVER_LEMAT', 'WEAPON_REVOLVER_DOUBLEACTION' },
      rifles = { 'WEAPON_RIFLE_VARMINT', 'WEAPON_RIFLE_SPRINGFIELD' },
      shotguns = { 'WEAPON_SHOTGUN_PUMP', 'WEAPON_SHOTGUN_SEMIAUTO', 'WEAPON_SHOTGUN_DOUBLEBARREL' }
    },
    
    -- ========================================================================
    --                    10. POSITIONS (SENTRIES, PATROLS, TURRETS, WAVES, LOOT)
    -- ========================================================================
    -- Guards present at raid start
    -- Distribution controlled by Config.SpawnDistribution
    -- Format: vector4(x, y, z, heading) or { pos = vector4(...), weapon = '...', model = '...' }
    sentryPositions = {
      vector4(-4193.464, -3476.672, 41.431, 203.539),
      vector4(-4186.477, -3468.522, 41.530, 245.648),
      vector4(-4177.509, -3451.823, 41.527, 235.519),
      vector4(-4194.263, -3452.782, 44.609, 23.065),
      vector4(-4190.477, -3442.035, 41.531, 70.797),
      vector4(-4177.873, -3442.187, 41.521, 246.180),
      vector4(-4172.900, -3435.860, 42.521, 217.389),
      vector4(-4184.363, -3451.122, 44.551, 286.701),
      vector4(-4165.999, -3430.478, 42.551, 255.307),
      vector4(-4168.598, -3426.279, 42.509, 310.535),
      vector4(-4171.993, -3421.612, 42.519, 341.897),
      vector4(-4175.832, -3424.557, 42.536, 25.122),
      vector4(-4178.853, -3432.669, 42.531, 92.090),
      vector4(-4186.626, -3417.819, 42.543, 306.340),
      vector4(-4190.418, -3412.541, 41.531, 299.158),
      vector4(-4196.188, -3409.103, 41.531, 317.538),
      vector4(-4198.080, -3419.000, 41.531, 222.493),
      vector4(-4210.889, -3427.945, 41.531, 218.534),
      vector4(-4225.188, -3421.202, 41.531, 335.750),
      vector4(-4232.409, -3417.450, 41.531, 31.594),
      vector4(-4217.420, -3439.444, 41.531, 294.555),
      vector4(-4209.542, -3460.001, 45.343, 332.879),
      vector4(-4194.956, -3468.735, 45.319, 287.320),
      vector4(-4198.823, -3475.624, 44.660, 192.003),
      vector4(-4214.386, -3466.980, 44.640, 154.148),
      vector4(-4223.639, -3461.126, 44.673, 173.153),
      vector4(-4220.327, -3458.474, 44.990, 320.192),
      vector4(-4236.255, -3424.180, 45.531, 27.491),
      vector4(-4236.171, -3428.842, 45.531, 91.935),
      vector4(-4241.445, -3443.612, 43.639, 72.412),
      vector4(-4247.227, -3452.356, 41.459, 59.297),
      vector4(-4254.167, -3459.818, 41.327, 55.074),
      vector4(-4266.788, -3474.400, 41.371, 139.381),
      vector4(-4265.564, -3470.648, 41.305, 40.861),
      vector4(-4253.977, -3464.910, 41.309, 208.680),
      vector4(-4234.548, -3465.024, 41.531, 189.285),
      vector4(-4240.317, -3470.400, 41.531, 221.436),
      vector4(-4213.269, -3503.412, 42.701, 226.306),
      vector4(-4242.949, -3484.050, 37.138, 210.079),
      vector4(-4232.140, -3476.767, 37.138, 191.588),
      vector4(-4202.557, -3449.616, 37.133, 328.069),
      vector4(-4194.653, -3445.467, 37.147, 356.896),
      vector4(-4207.682, -3436.632, 37.138, 305.298),
      vector4(-4188.197, -3429.302, 37.138, 25.246),
      vector4(-4182.658, -3433.977, 37.106, 45.887),
      vector4(-4204.090, -3445.105, 40.102, 326.189),
      vector4(-4216.860, -3476.347, 41.002, 163.434),
      vector4(-4228.157, -3468.532, 41.002, 189.122),
      vector4(-4219.449, -3420.297, 45.098, 32.179),
      vector4(-4205.035, -3415.107, 45.694, 288.131),
      vector4(-4214.979, -3426.009, 45.600, 250.588),
      vector4(-4200.633, -3406.167, 45.505, 282.385),
      vector4(-4203.032, -3403.233, 45.203, 357.172)
    },

    -- ===================================================================
    --                    PATROL POSITIONS
    -- ===================================================================
    -- Roaming guards that move around
    patrols = {
       vector4(-4188.144, -3382.145, 38.085, 229.127),
       vector4(-4146.614, -3431.661, 37.038, 208.426),
       vector4(-4163.606, -3472.894, 37.038, 143.144),
       vector4(-4192.990, -3523.039, 37.034, 130.471),
       vector4(-4281.266, -3445.751, 35.505, 336.856),
       vector4(-4228.482, -3382.930, 36.639, 275.711)
    },

    -- ===================================================================
    --                    TURRETS
    -- ===================================================================
    -- NOTE: Turrets do NOT count towards Config.MaxRaidEntities limit so be careful
    turretSpawnMode = 'dynamic',               -- 'static' (all) or 'dynamic' (random selection)
    turretDynamicCount = 2,                   -- Count for dynamic mode
    
    turrets = {
      { position = vector4(-4217.89, -3452.93, 40.49, 321.15), vehicleModel = 'gatlingMaxim02', gunnerModel = 's_m_m_army_01', fireRate = 1500, accuracy = 25, range = 120.0, breakable = true, brokenModel = 's_maximtripod01x', disableOnDeath = false },
      { position = vector4(-4260.19091796875, -3470.062744140625, 40.76728439331055, -136.91372680664062), vehicleModel = 'gatlingMaxim02', gunnerModel = 's_m_y_army_01', fireRate = 1500, accuracy = 25, range = 120.0, breakable = true, brokenModel = 's_maximtripod01x', disableOnDeath = false },
      { position = vector4(-4233.94140625, -3426.70849609375, 45.43048477172851, -23.35373878479004), vehicleModel = 'gatlingMaxim02', gunnerModel = 's_m_m_army_01', fireRate = 1500, accuracy = 25, range = 120.0, breakable = true, brokenModel = 's_maximtripod01x', disableOnDeath = false }
    },

    -- ===================================================================
    --                    REINFORCEMENTS
    -- ===================================================================
    reinforcements = {
      enabled = true,
      triggerMode = 'random',              -- 'sentries_cleared', 'timer', 'threshold', or 'random'
      delaySeconds = 90,                      -- For 'timer': Seconds after sentries/patrols cleared (since waves disabled)
      thresholdPercent = 50,                  -- For 'threshold': Spawn when X% of wave enemies remain (waves only)
      spawnFrequency = 'once',                -- 'once', 'per_wave', or 'unlimited'
      count = 4,
      npcModels = { 's_m_y_army_01', 's_m_m_army_01' },
      horseModels = { 'A_C_Horse_KentuckySaddle_Grey', 'A_C_Horse_KentuckySaddle_Grey' },
    },

    reinforcementSpawnPoints = {
      vector3(-4471.281, -3517.285, 25.937),
      vector3(-4090.808, -3659.059, 47.161),
      vector3(-3995.996, -3321.339, 28.133),
      vector3(-4363.315, -3270.808, 21.402),
    },

    -- ===================================================================
    --                    WAVES
    -- ===================================================================
    wavesEnabled = false,
    waves = {
      -- Wave 1
      {
        npcCount = 5,
        behaviorProfile = 'defensive',
        aggroDistance = 100.0,
        spawnPoints = {
          vector4(-4236.010, -3426.512, 37.231, 168.857),
          vector4(-4232.479, -3420.509, 41.431, 230.703),
          vector4(-4229.546, -3428.334, 37.231, 141.455),
          vector4(-4246.438, -3464.759, 37.037, 148.816),
          vector4(-4243.950, -3449.317, 37.061, 244.653),
          vector4(-4220.851, -3506.089, 37.037, 62.499),
          vector4(-4223.143, -3479.138, 36.972, 53.114),
          vector4(-4186.392, -3463.729, 37.231, 59.092),
          vector4(-4198.453, -3411.810, 41.431, 189.293),
          vector4(-4240.219, -3443.638, 43.539, 191.899)
        }
      },
      -- -- Wave 2
      -- {
      --   npcCount = 5,
      --   behaviorProfile = 'aggressive',
      --   aggroDistance = 100.0,
      --   spawnPoints = {
      --     vector4(-4194.426, -3462.066, 37.331, 44.058),
      --     vector4(-4191.847, -3459.070, 37.331, 90.805),
      --     vector4(-4208.142, -3458.143, 37.326, 328.699),
      --     vector4(-4223.675, -3441.224, 37.138, 227.599),
      --     vector4(-4218.913, -3434.095, 37.138, 248.397),
      --     vector4(-4186.299, -3428.669, 37.138, 135.296),
      --     vector4(-4180.284, -3442.969, 37.134, 15.369),
      --     vector4(-4245.598, -3463.600, 37.137, 176.404),
      --     vector4(-4232.396, -3466.873, 37.129, 179.101)
      --   }
      -- }
    },

    -- ===================================================================
    --                    LOOT CONFIGURATION
    -- ===================================================================
    loot = {
      chestModel = 'mp001_p_mp_strongbox01x_lrg',  -- Army strongbox model
      boxCount = { min = 2, max = 3 },      -- Override default box count
      
      spawnPoints = {
        vector4(-4197.53271484375, -3465.44677734375, 40.49, 151.0),
        vector4(-4242.896484375, -3455.6025390625, 36.08000183105469, 135.0),
        vector4(-4249.2666015625, -3469.546630859375, 36.0874, -134.0),
      },
      
      -- ===================================================================
      --                    ITEM CONFIGURATION
      -- ===================================================================
      -- Supports multiple quantity formats:
      --   * Simple: { name = 'goldbar', chance = 50 } -> gives 1x
      --   * Fixed: { name = 'goldbar', chance = 50, quantity = 5 } -> gives 5x
      --   * Range: { name = 'goldbar', chance = 50, quantity = {min=2, max=5} } -> gives 2-5x
      
      items = {
        { name = 'intel_folder', chance = 70, quantity = 1 },                    -- Always 1x
        { name = 'moneybag', chance = 60, quantity = {min = 1, max = 3}, moneyReward = { min = 20, max = 80 } },  -- 1-3x moneybags
        { name = 'goldbar', chance = 30, quantity = {min = 2, max = 4} }        -- 2-4x goldbars
      },
      
      itemSelection = {
        mode = 'independent',                 -- Override: use independent mode
        maxItems = 2
      },
      
      -- ===================================================================
      --                    MINIGAME CONFIGURATION
      -- ===================================================================
      -- Three configuration modes available (use ONE at a time):
      
      -- MODE 1: SINGLE MINIGAME FOR ALL BOXES (simplest)
      -- All loot boxes in this raid use the same minigame
      minigame = {
        enabled = true,                       -- Enable minigame requirement
        type = 'random',                      -- Minigame type: 'padlock', 'lockpick', 'random'
        
        -- Padlock settings (when type = 'padlock')
        digits = 3,                           -- Number of digits (2-5)
        code = 'random',                      -- 'random' or specific code like '5827'
        mode = 'hint',                        -- 'hint' or 'bruteforce'
        failurePenalty = 0,                   -- Seconds to wait after failure
        
        -- Lockpick settings (when type = 'lockpick')
        difficulty = 'medium',                -- 'easy', 'medium', 'hard'
        requiredItem = 'lockpick',            -- Item consumed on use
        maxAttempts = 0,                      -- 0 = unlimited tries
      },
      
      -- MODE 2: PER-BOX ASSIGNMENT (most control)
      -- Assign specific minigame to each box by index
      -- Uncomment and comment out MODE 1 to use:
      --
      -- minigames = {
      --   [1] = {                             -- First box (spawnPoints[1])
      --     enabled = true,
      --     type = 'padlock',
      --     digits = 4,
      --     mode = 'hint'
      --   },
      --   [2] = {                             -- Second box (spawnPoints[2])
      --     enabled = true,
      --     type = 'lockpick',
      --     difficulty = 'hard',
      --     requiredItem = 'lockpick'
      --   },
      --   [3] = {                             -- Third box (spawnPoints[3])
      --     enabled = false                   -- No minigame, instant access
      --   }
      -- },
      
      -- MODE 3: RANDOM POOL (variety)
      -- Each box randomly picks ONE minigame from this pool
      -- Uncomment and comment out MODE 1 to use:
      --
      -- minigamePool = {
      --   {                                   -- Option 1: Easy padlock
      --     type = 'padlock',
      --     digits = 3,
      --     mode = 'hint'
      --   },
      --   {                                   -- Option 2: Hard padlock
      --     type = 'padlock',
      --     digits = 5,
      --     mode = 'basic'
      --   },
      --   {                                   -- Option 3: Lockpick (future)
      --     type = 'lockpick',
      --     difficulty = 'medium',
      --     requiredItem = 'lockpick'
      --   }
      -- }
    },
  },
  --#endregion
  -- ============================================================================
  --                            OLD CAMP RAID (West Elizabeth)
  -- ============================================================================
  --#region Old Camp
  old_camp = {
    -- ===================================================================
    --                    BASIC INFO
    -- ===================================================================
    name = "Old Camp",
    enabled = true,
    jurisdiction = "WESO",
    
    -- ===================================================================
    --                    START LOCATION
    -- ===================================================================
    startPoint = vector4(-314.9938049316406, -104.69685363769531, 47.04980850219726, 105.95447540283203),
    startNPCModel = 's_m_m_coachtaxidriver_01',
    notifyRadius = 20.0,
    
    -- ===================================================================
    --                    START NPC SCENARIOS
    -- ===================================================================
    scenario = "WORLD_HUMAN_GUARD",
    idleScenarios = {
      "WORLD_HUMAN_GUARD",
      "WORLD_HUMAN_GUARD_SCOUT",
      "WORLD_HUMAN_BADASS",
      "WORLD_HUMAN_STAND_WAITING",
      "WORLD_HUMAN_SMOKING",
      "WORLD_HUMAN_GUARD_LEAN_WALL"
    },
    scenarioCycleInterval = 2,
    
    -- ===================================================================
    --                    START NPC DIALOGUE
    -- ===================================================================
    dialogue = {
      enabled = true,
      greetingDistance = 3.0,
      resetDistance = 50.0,
      
      animations = {
        talk = { type = "scenario", name = "WORLD_HUMAN_STAND_IMPATIENT" },
        give_map = { type = "anim", dict = "mech_inspection@letter@base", anim = "grab", flag = 0, duration = 3000 },
        player_take_map = { type = "anim", dict = "mech_inspection@letter@base", anim = "hold", flag = 49, duration = -1, prop = "s_mollyloveletter" },
      },
      
      lines = {
        greeting = "You look like someone who ain't afraid to get their hands dirty.",
        steps = {
          { label = "What are you getting at?", text = "Doolin Gang got themselves a camp up in them mountains. Sheriff's got some arrangement with 'em, lets 'em do what they please.", anim = "talk" },
          { label = "Law's protecting them?", text = "That's right. Folks around here ain't happy about it, but nobody's got the spine to do nothing. Those boys are sitting on supplies they took from honest people.", anim = "talk" },
          { label = "Where can I find them?", text = "You got more guts than sense, I like that. Here's where they're holed up. Don't expect the law to come running when things get loud.", anim = "give_map", playerAnim = "player_take_map", action = "start" }
        },
        missingItem = "You're not prepared. Bring me a %s and then we can talk."
      }
    },
    
    -- ===================================================================
    --                    START REQUIREMENTS
    -- ===================================================================
    requiredItem = {"crim_raid_torn_map","crim_raid_doolin_will","crim_raid_mining_records"},
    consumeRequiredItem = true,
    
    -- ===================================================================
    --                    LAW ALERTS
    -- ===================================================================
    lawAlerts = {
      enabled = true,
      timingMode = 'random',
      triggerPoint = 'sentries_cleared',
      randomDelay = { min = 30, max = 180 },
      jobs = {'WESO'}
    },
    
    -- ===================================================================
    --                    RAID BOUNDARY
    -- ===================================================================
    boundary = {
      center = vector3(-1899.8541259765625, 1346.5023193359375, 201.2914581298828),
      radius = 500.0
    },
    
    -- ===================================================================
    --                    TIMING
    -- ===================================================================
    waveDelay = 3.0,
    accessTimer = 2.5,
    
    -- ===================================================================
    --                    NPC MODELS
    -- ===================================================================
    npcModels = { 'u_m_m_odriscollbrawler_01', 'u_m_m_bht_odriscolldrunk', 'u_m_m_bht_odriscollsleeping' },
    leaderModel = 'u_m_m_odriscollbrawler_01',
    
    -- ===================================================================
    --                    PATROL BEHAVIOR
    -- ===================================================================
    patrolRadius = 40.0,
    patrolPoints = 3,
    patrolWaitTime = 6000,
    
    -- ===================================================================
    --                    WEAPON POOLS
    -- ===================================================================
    weaponPools = {
      snipers = { 'WEAPON_RIFLE_BOLTACTION', 'WEAPON_SNIPERRIFLE_ROLLINGBLOCK', 'WEAPON_SNIPERRIFLE_CARCANO' },
      rifles = { 'WEAPON_RIFLE_SPRINGFIELD', 'WEAPON_RIFLE_BOLTACTION', 'WEAPON_REPEATER_WINCHESTER' },
      shotguns = { 'WEAPON_SHOTGUN_DOUBLEBARREL', 'WEAPON_SHOTGUN_PUMP' },
      repeaters = { 'WEAPON_REPEATER_CARBINE', 'WEAPON_REPEATER_WINCHESTER', 'WEAPON_REPEATER_HENRY' },
      revolvers = { 'WEAPON_REVOLVER_CATTLEMAN', 'WEAPON_REVOLVER_SCHOFIELD', 'WEAPON_REVOLVER_DOUBLEACTION' }
    },

    -- SPECIAL RULES
    friendlyJobs = {},  -- Empty = NPCs attack everyone (no protected jobs)
    minLawCount = nil,  -- Minimum law officers required (nil = no requirement)
    
    -- ===================================================================
    --                    SENTRY POSITIONS
    -- ===================================================================
    sentryPositions = {
      vector4(-1899.173, 1321.514, 199.294, 181.039),
      vector4(-1905.724, 1317.356, 198.561, 201.688),
      vector4(-1905.880, 1349.848, 202.234, 182.300),
      vector4(-1904.856, 1325.192, 199.431, 184.134),
      vector4(-1889.363, 1313.516, 199.138, 138.538),
      vector4(-1920.714, 1332.863, 207.929, 209.201),
      vector4(-1945.161, 1331.935, 212.772, 250.078),
      vector4(-1926.295, 1345.393, 207.598, 97.461),
      vector4(-1876.406, 1359.595, 211.488, 161.275),
      vector4(-1871.246, 1362.664, 211.499, 2.738),
      vector4(-1893.652, 1334.689, 200.047, 316.467),
      vector4(-1892.413, 1368.469, 206.080, 179.035),
      vector4(-1911.119, 1359.187, 207.545, 185.182),
      vector4(-1924.043, 1383.570, 216.805, 204.295),
      vector4(-1898.978, 1336.725, 203.959, 7.343),
      vector4(-1855.049, 1397.418, 232.183, 167.754),
      vector4(-1914.161, 1395.540, 234.043, 185.304),
      vector4(-1901.921, 1358.863, 203.596, 193.479)
    },
    
    -- ===================================================================
    --                    PATROL POSITIONS
    -- ===================================================================
    patrols = {
      vector4(-1882.924, 1367.294, 204.136, 189.952),
      vector4(-1899.583, 1346.420, 201.290, 283.677),
      vector4(-1922.269, 1356.127, 204.363, 63.027),
      vector4(-1853.046, 1358.609, 207.357, 165.383),
      vector4(-1864.099, 1327.517, 204.074, 144.306),
      vector4(-1895.940, 1281.675, 198.284, 107.170),
      vector4(-1933.979, 1282.584, 197.217, 285.327)
    },
    
    -- ===================================================================
    --                    TURRETS
    -- ===================================================================
    -- NOTE: Turrets do NOT count towards Config.MaxRaidEntities limit
    turretSpawnMode = 'dynamic',               -- 'static' (all) or 'dynamic' (random selection)
    turretDynamicCount = 0,                    -- No turrets
    
    turrets = {},  -- No turrets
    
    -- ===================================================================
    --                    REINFORCEMENTS
    -- ===================================================================
    reinforcements = {
      enabled = true,
      triggerMode = 'timer',
      delaySeconds = 60,
      thresholdPercent = 50,
      spawnFrequency = 'once',
      count = 2,
      npcModels = { 'u_m_m_odriscollbrawler_01', 'u_m_m_bht_odriscolldrunk' },
      horseModels = { 'A_C_Horse_KentuckySaddle_Grey', 'A_C_Horse_KentuckySaddle_Grey' },
    },

    reinforcementSpawnPoints = {
      vector3(-1723.319, 1360.880, 280.113),
    },
    
    -- ===================================================================
    --                    WAVES
    -- ===================================================================
    wavesEnabled = false,
    waves = {},  -- No waves
    
    -- ===================================================================
    --                    LOOT
    -- ===================================================================
    loot = {
      enabled = true,
      chestModel = 'mp001_p_mp_strongbox01x_lrg',  -- Army strongbox model
      boxCount = { min = 2, max = 5 },
      
      spawnPoints = {
        vector4(-1877.0281982421875, 1333.0452880859375, 200.2355, 79.89785766601562),
        vector4(-1892.962158203125, 1331.3009033203125, 198.1022, -89.73854064941406),
        vector4(-1875.8409423828125, 1361.7366943359375, 209.5038, -98.40721893310547),
        vector4(-1884.6072998046875, 1351.6453857421875, 201.2771, 171.8916778564453),
        vector4(-1898.82421875, 1360.07763671875, 201.2538, -1.27521288394927),
        vector4(-1909.52783203125, 1350.7425537109375, 200.4176, -92.42684936523438),
        vector4(-1893.1558837890625, 1332.612060546875, 201.9545, -88.39602661132812)
      },
      
      items = {
        { name = 'lockpick', chance = 40 },
        { name = 'goldbar', chance = 5 }
      },
      
      minigame = {
        enabled = true,
        type = 'random',
        digits = 4,
        code = 'random',
        mode = 'hint',
        difficulty = 'medium',
        requiredItem = 'lockpick',
        maxAttempts = 0
      }
    }
  },
  --#endregion
  -- ========================================================================
  --                      CIVIL WAR FIELD RAID (Lemoyne Raiders)
  -- ========================================================================
  --#region Civil War Field
  civil_war_field = {
    -- ===================================================================
    --                    BASIC INFO
    -- ===================================================================
    name = "Civil War Field",
    enabled = true,
    jurisdiction = "LSO",
    
    -- ===================================================================
    --                    START LOCATION
    -- ===================================================================
    startPoint = vector4(1892.4263916015625, -737.4635620117188, 42.23614883422851, -99.17572784423828),
    startNPCModel = 'g_m_y_uniexconfeds_01',
    notifyRadius = 20.0,
    
    -- ===================================================================
    --                    START NPC SCENARIOS
    -- ===================================================================
    scenario = "WORLD_HUMAN_SMOKING",
    idleScenarios = {
      "WORLD_HUMAN_SMOKING",
      "WORLD_HUMAN_SIT_GROUND",
      "WORLD_HUMAN_GUARD_LEAN_WALL",
      "WORLD_HUMAN_STAND_WAITING",
      "WORLD_HUMAN_WRITE"
    },
    scenarioCycleInterval = 2,
    
    -- ===================================================================
    --                    START NPC DIALOGUE
    -- ===================================================================
    dialogue = {
      enabled = true,
      greetingDistance = 3.0,
      resetDistance = 50.0,
      
      animations = {
        talk = { type = "scenario", name = "WORLD_HUMAN_STAND_IMPATIENT" },
        give_map = { type = "anim", dict = "mech_inspection@letter@base", anim = "grab", flag = 0, duration = 3000 },
        player_take_map = { type = "anim", dict = "mech_inspection@letter@base", anim = "hold", flag = 49, duration = -1, prop = "s_mollyloveletter" },
      },
      
      lines = {
        greeting = "I'm done with those damn Lemoyne Raiders and their foolish games.",
        steps = {
          { label = "What happened?", text = "They're out there playing soldier in the old civil war field. Military drills, discipline... it's all horseshit. I deserted those crazy bastards.", anim = "talk" },
          { label = "Why tell me this?", text = "They got supplies, weapons... things worth taking. And I want to see them get what's coming. Those boys think they're invincible.", anim = "talk" },
          { label = "Show me where", text = "Here. They're dug in good, but they ain't expecting trouble. Go give 'em hell for me, will ya?", anim = "give_map", playerAnim = "player_take_map", action = "start" }
        },
        missingItem = "You're not prepared. Bring me a %s and then we can talk."
      }
    },
    
    -- ===================================================================
    --                    START REQUIREMENTS
    -- ===================================================================
    requiredItem = "crim_raid_braithwaite_key",
    consumeRequiredItem = false,
    
    -- ===================================================================
    --                    LAW ALERTS
    -- ===================================================================
    lawAlerts = {
      enabled = true,
      timingMode = 'random',
      triggerPoint = 'sentries_cleared',
      randomDelay = { min = 30, max = 180 },
      jobs = {'LSO'}
    },
    
    -- ===================================================================
    --                    RAID BOUNDARY
    -- ===================================================================
    boundary = {
      center = vector3(1520.157, -1812.246, 54.525),
      radius = 250
    },
    
    -- ===================================================================
    --                    ALARM SYSTEM
    -- ===================================================================
    alarm = {
      enabled = false,
      name = "PRISON_ALARMS",  -- Alarm sound name
      location = vector3(1520.157, -1812.246, 54.525),  -- Where alarm sound originates
      triggerOn = 'combat_detected',  -- When to trigger: 'raid_start', 'combat_detected', 'sentries_cleared'
      disableLocation = vector3(1519.507, -1812.567, 53.575),  -- Wire cutting interaction point
      disableObject = {
        enabled = true,
        model = 's_dov_lab_panel02x',
        coords = vector4(1519.507, -1812.567, 53.575, -112.878),
        freeze = true
      },
      disableMinigame = {
        enabled = true,  -- Enable wire cutting minigame
        type = 'wirecutting',
        difficulty = 'medium'
      }
    },
    
    -- ===================================================================
    --                    TIMING for waves(empty)
    -- ===================================================================
    waveDelay = 3.0,                          -- Delay between waves (minutes)
    accessTimer = 2.5,                        -- Access timer for loot (minutes)
    
    -- ===================================================================
    --                    NPC MODELS
    -- ===================================================================
    npcModels = { 'g_m_y_uniexconfeds_01' },
    leaderModel = 'g_m_y_uniexconfeds_01',

    -- SPECIAL RULES
    friendlyJobs = {},  -- Empty = NPCs attack everyone
    minLawCount = 0,    -- Requires x LSO law officers online to start this raid
    
    -- ===================================================================
    --                    PATROL BEHAVIOR
    -- ===================================================================
    patrolRadius = 60.0,
    patrolPoints = 6,
    patrolWaitTime = 6000,
    
    -- ===================================================================
    --                    WEAPON POOLS
    -- ===================================================================
    weaponPools = {
      snipers = { 'WEAPON_RIFLE_BOLTACTION', 'WEAPON_SNIPERRIFLE_ROLLINGBLOCK' },
      rifles = { 'WEAPON_RIFLE_SPRINGFIELD', 'WEAPON_RIFLE_BOLTACTION', 'WEAPON_REPEATER_WINCHESTER' },
      shotguns = { 'WEAPON_SHOTGUN_DOUBLEBARREL', 'WEAPON_SHOTGUN_PUMP' },
      repeaters = { 'WEAPON_REPEATER_CARBINE', 'WEAPON_REPEATER_WINCHESTER', 'WEAPON_REPEATER_HENRY' },
      revolvers = { 'WEAPON_REVOLVER_CATTLEMAN', 'WEAPON_REVOLVER_SCHOFIELD', 'WEAPON_REVOLVER_LEMAT' }
    },
    
    -- ===================================================================
    --                    SENTRY POSITIONS
    -- ===================================================================
    sentryPositions = {
      vector4(1529.944, -1806.547, 53.764, 117.599),
      vector4(1515.315, -1828.484, 51.872, 284.801),
      vector4(1475.795, -1829.231, 54.297, 69.298),
      vector4(1585.110, -1846.611, 58.424, 70.222),
      vector4(1588.082, -1839.169, 58.595, 71.597),
      vector4(1503.314, -1825.877, 56.242, 22.894),
      vector4(1495.400, -1833.159, 56.223, 58.873),
      vector4(1488.557, -1830.137, 54.445, 331.037),
      vector4(1490.401, -1805.704, 55.900, 351.095),
      vector4(1516.606, -1794.235, 55.519, 17.522),
      vector4(1511.101, -1794.253, 55.647, 17.382),
      vector4(1517.242, -1812.172, 54.636, 357.959),
      -- vector4(1537.962, -1812.318, 52.608, 296.834),
      -- vector4(1502.290, -1848.594, 57.742, 329.198),
      -- vector4(1470.851, -1846.781, 55.830, 324.591),
      -- vector4(1540.750, -1829.954, 54.982, 31.217),
      -- vector4(1490.929, -1839.079, 53.946, 56.912),
      vector4(1511.708, -1807.144, 54.070, 274.417)
    },
    
    -- ===================================================================
    --                    PATROL POSITIONS
    -- ===================================================================
    patrols = {
      vector4(1518.562, -1807.473, 53.597, 257.276),
      vector4(1510.018, -1799.527, 54.709, 101.157),
      vector4(1494.764, -1819.435, 53.702, 199.101),
      vector4(1503.163, -1813.855, 54.009, 305.479),
      vector4(1519.009, -1817.296, 53.370, 283.070),
      vector4(1535.047, -1813.168, 52.165, 286.551),
      vector4(1536.421, -1802.682, 54.060, 38.330),
      vector4(1526.276, -1826.848, 50.411, 97.959),
      vector4(1511.653, -1829.822, 51.949, 2.578),
      -- vector4(1501.414, -1842.641, 54.502, 93.436),
      -- vector4(1485.395, -1839.904, 53.106, 139.842),
      -- vector4(1475.223, -1839.286, 52.766, 323.847),
      -- vector4(1479.260, -1823.448, 53.347, 29.413),
      vector4(1485.913, -1815.592, 54.299, 302.735)
    },
    
    -- ===================================================================
    --                    TURRETS
    -- ===================================================================
    -- NOTE: Turrets do NOT count towards Config.MaxRaidEntities limit
    turretSpawnMode = 'dynamic',               -- 'static' (all) or 'dynamic' (random selection)
    turretDynamicCount = 0,                    -- No turrets
    
    turrets = {},  -- No turrets
    
    -- ===================================================================
    --                    REINFORCEMENTS
    -- ===================================================================
    reinforcements = {
      enabled = true,
      triggerMode = 'timer',
      delaySeconds = 60,
      thresholdPercent = 50,
      spawnFrequency = 'once',
      count = 2,
      npcModels = { 'g_m_y_uniexconfeds_01', 'g_m_y_uniexconfeds_01' },
      horseModels = { 'A_C_Horse_KentuckySaddle_Black', 'A_C_Horse_KentuckySaddle_Black' },
    },
    
    reinforcementSpawnPoints = {
      vector3(1751.182, -1768.018, 51.312),
    },
    
    -- ===================================================================
    --                    WAVES
    -- ===================================================================
    wavesEnabled = true,
    waves = {},  -- No waves
    
    -- ===================================================================
    --                    LOOT
    -- ===================================================================
    loot = {
      enabled = true,
      chestModel = 'mp001_p_mp_strongbox01x_lrg',  -- Army strongbox model
      boxCount = { min = 2, max = 5 },
      
      spawnPoints = {
        vector4(1528.236572265625, -1808.1427001953125, 50.9795, -55.46686172485351),
        vector4(1496.9647216796875, -1805.399658203125, 52.8875, 48.35023880004883),
        vector4(1487.579833984375, -1827.2818603515625, 51.8149, -135.4188232421875),
        vector4(1521.7191162109375, -1796.8865966796875, 52.1377, -7.55720281600952),
        vector4(1586.953125, -1841.1524658203125, 56.5826, 70.06536102294922),
        vector4(1590.4437255859375, -1843.2000732421875, 50.3534, -107.63467407226562)
      },
      
      items = {
        { name = 'lockpick', chance = 40 },
        { name = 'goldbar', chance = 5 }
      },
      
      minigame = {
        enabled = true,
        type = 'random',
        digits = 4,
        code = 'random',
        mode = 'hint',
        difficulty = 'medium',
        requiredItem = 'lockpick',
        maxAttempts = 0
      }
    }
  },
  --#endregion
  -- ===================================================================
  --                        NHSO Grizzlies east MINOR Raid
  --#region Checklist
  --   [X] Basic Info
  --   [ ] Start Location
  --   [ ] Start NPC Scenarios
  --   [ ] Start NPC Dialogue
  --   [ ] Start Requirements
  --   [X] Law Alerts
  --   [X] Raid Boundary
  --   [X] Entity Limits 
  --   [X] Alarm System (disabled for now)
  --   [X] Timing
  --   [X] NPC Models
  --   [X] Special Rules
  --   [X] Sentry Positions (none for minor raid)
  --   [X] Patrol Positions (none for minor raid)
  --   [X] Turrets (none for minor raid)
  --   [X] Reinforcements (none for minor raid)
  --   [X] Waves (none for minor raid)
  --   [X] Loot
  --#endregion
  -- ===================================================================
  --#region Grizzlies East Tower Raid
  grizzlies_east_minor = {
    
    -- BASIC INFO
    name = "Grizzlies East Tower Raid",
    enabled = true,
    jurisdiction = "NHSO",
    
    -- START LOCATION
    startPoint = vector4(2450.487, 2100.865, 173.318, 163.214),
    startNPCModel = 's_m_m_micguard_01',
    notifyRadius = 20.0,
    
    -- START NPC SCENARIOS
    scenario = "WORLD_HUMAN_STAND_IMPATIENT",
    idleScenarios = {
      "WORLD_HUMAN_STAND_WAITING",
      "WORLD_HUMAN_SMOKING",
      "WORLD_HUMAN_GUARD_LEAN_WALL"
    },
    scenarioCycleInterval = 1,
    
    -- START NPC DIALOGUE
    dialogue = {
      enabled = true,
      greetingDistance = 3.0,
      resetDistance = 50.0,
      
      animations = {
        talk = { type = "scenario", name = "WORLD_HUMAN_STAND_IMPATIENT" },
        give_map = { type = "anim", dict = "mech_inspection@letter@base", anim = "grab", flag = 0, duration = 3000 },
        player_take_map = { type = "anim", dict = "mech_inspection@letter@base", anim = "hold", flag = 49, duration = -1, prop = "s_mollyloveletter" },
      },
      
      lines = {
        greeting = "Those damn marshals have been a thorn in my side around here.",
        steps = {
          { label = "What's the problem?", text = "They got themselves a cozy little outpost, thinking they're untouchable. Storing weapons, supplies, everything they need to keep their stranglehold on this territory.", anim = "talk" },
          { label = "Why tell me this?", text = "Because I'm tired of looking over my shoulder every five minutes. That marshal station is the heart of their operation - take it down and they lose their grip on the whole region.", anim = "talk" },
          { label = "I'll hit the outpost.", text = "That's what I like to hear. They got sentries posted all around, steady supply of deputies coming and going. But hit 'em right and you'll scatter 'em like rats. Here's where they're dug in.", anim = "give_map", playerAnim = "player_take_map", action = "start" }
        },
        missingItem = "You ain't ready to take on the marshals. Come back when you got yourself a %s."
      }
    },
    
    -- START REQUIREMENTS
    requiredItem = nil,
    consumeRequiredItem = false,
    
    -- LAW ALERTS
    lawAlerts = {
      enabled = true,
      timingMode = 'random',
      triggerPoint = 'sentries_cleared',
      randomDelay = { min = 30, max = 180 },
      jobs = {'NHSO'}
    },
    
    -- RAID BOUNDARY
    boundary = {
      center = vector3(1931.778, 1957.232, 264.169),
      radius = 250.0
    },
    
    -- ===================================================================
    --                    ENTITY LIMITS
    -- ===================================================================
    maxEntities = 22,  -- Override global Config.MaxRaidEntities for this raid (optional)
    
    -- ===================================================================
    --                    ALARM SYSTEM (DISABLED - TO BE IMPLEMENTED IN THE FUTURE)
    -- ===================================================================
    --[[ ALARM SYSTEM COMMENTED OUT - Audio not working yet
    alarm = {
      enabled = true,
      name = "FORT_ALARM",  -- Identifier for this alarm (not actual sound name - uses bell_school sound)
      location = vector3(348.829, 1487.227, 179.460),  -- Where alarm sound originates (fort center)
      triggerOn = 'combat_detected',  -- When to trigger: 'raid_start', 'combat_detected', 'sentries_cleared'
      disableObject = {
        enabled = true,
        model = 's_dov_lab_panel02x',  -- Electrical panel model
        coords = vector4(337.74310302734375, 1496.3299560546875, 180.15704345703125, -148.58297729492188),  -- Inside main building
        freeze = true
      },
      disableMinigame = {
        enabled = true,
        type = 'wirecutting',
        difficulty = 'medium'  -- easy, medium, hard
      }
    },
    ]]--
    
    -- ===================================================================
    --                    TIMING
    -- ===================================================================
    waveDelay = nil,  -- No waves
    
    -- ACCESS TIMER FOR LOOT
    accessTimer = 0.5,  -- 0.5 minutes wait after clearing sentries/patrols
    
    -- NPC MODELS
    npcModels = { 's_m_m_army_01' },
    leaderModel = 's_m_m_army_01',
    
    -- SPECIAL RULES
    friendlyJobs = {"NARO", "USMO", "WESO", "LSO", "NHSO", "USDO"},  -- Law jobs cannot start this raid
    minLawCount = nil,  -- Minimum law officers required to start raid (nil = no requirement)
    
    -- ===================================================================
    --                    PATROL BEHAVIOR
    -- ===================================================================
    patrolRadius = 40.0,
    patrolPoints = 4,
    patrolWaitTime = 5000,
    
    -- ===================================================================
    --                    WEAPON POOLS
    -- ===================================================================
    weaponPools = {
      snipers = { 'WEAPON_RIFLE_BOLTACTION', 'WEAPON_SNIPERRIFLE_ROLLINGBLOCK' },
      repeaters = { 'WEAPON_REPEATER_WINCHESTER', 'WEAPON_REPEATER_CARBINE' },
      revolvers = { 'WEAPON_REVOLVER_CATTLEMAN' },
      rifles = { 'WEAPON_RIFLE_SPRINGFIELD' },
      shotguns = { 'WEAPON_SHOTGUN_DOUBLEBARREL' }
    },
    
    -- ===================================================================
    --                    AI BEHAVIOR
    -- ===================================================================
    AI = {
      difficulty = {
        playersDivisor = 2.0,  -- Difficulty scales with players
      },
      accuracy = {
        base = 25,
        min = 15,
        max = 40
      },
      health = {
        base = 150,
        multiplier = 1.0
      },
      combat = {
        coverUsage = 30,
        flankingChance = 20,
        aggressiveness = 50
      }
    },
    
    -- ===================================================================
    --                    SENTRY POSITIONS
    -- ===================================================================
    sentryPositions = {
      vector4(1942.740, 1952.974, 265.751, 274.664),
      vector4(1948.275, 1942.094, 265.004, 247.131),
      vector4(1942.056, 1931.324, 264.444, 172.454),
      vector4(1932.874, 1930.956, 265.627, 140.791),
      vector4(1923.617, 1935.518, 264.397, 91.147),
      vector4(1924.031, 1953.929, 267.342, 51.912),
      vector4(1933.778, 1959.302, 263.788, 7.552),
    },
    
    
    -- ===================================================================
    --                    PATROL POSITIONS
    -- ===================================================================
    -- Roaming guards that move around
    patrols = {
      vector4(1882.505, 1968.348, 246.765, 59.414),
      vector4(1879.693, 1964.649, 246.791, 60.605),
      vector4(1944.975, 1995.188, 269.621, 292.087),
      vector4(1947.817, 1989.646, 269.130, 289.991),
      vector4(1940.414, 1989.065, 268.565, 110.013),
    },
    
    -- ===================================================================
    --                    TURRETS
    -- ===================================================================
    -- NOTE: Turrets do NOT count towards Config.MaxRaidEntities limit
    turretSpawnMode = 'dynamic',               -- 'static' (all) or 'dynamic' (random selection)
    turretDynamicCount = 0,                    -- No turrets
    
    turrets = {},  -- No turrets
    
    -- ===================================================================
    --                    SENTRY DEFAULTS (10m engagement range)
    -- ===================================================================
    sentryDefaults = {
      aggroRange = 80.0,  -- Sentries only engage when player is within 80 meters
      leashDistance = 30.0,  -- Return to spawn if more than 30m away
    },
    
    -- ===================================================================
    --                    REINFORCEMENTS
    -- ===================================================================
    reinforcements = {
      enabled = false,
      triggerMode = 'timer',
      delaySeconds = 60,
      thresholdPercent = 50,
      spawnFrequency = 'once',
      count = 2,
      npcModels = { 's_m_m_army_01' },
      horseModels = { 'A_C_Horse_KentuckySaddle_Grey' },
    },

    reinforcementSpawnPoints = {
      vector3(250.0, 1550.0, 180.0),
      vector3(450.0, 1450.0, 180.0),
      vector3(300.0, 1400.0, 180.0),
      vector3(400.0, 1550.0, 180.0),
    },

    -- ===================================================================
    --                    WAVES
    -- ===================================================================
    wavesEnabled = false,
    waves = {},  -- No waves
    
    -- ===================================================================
    --                    LOOT (only specify what's different from defaults)
    -- ===================================================================
    loot = {
      chestModel = 'mp001_p_mp_strongbox01x_lrg',  -- Army strongbox model
      boxCount = { min = 2, max = 4 },      -- Fixed 7 boxes
      
      spawnPoints = {
        vector4(1932.818, 1944.982, 262.06, 92.193),
        vector4(1935.039, 1944.242, 265.153, 189.956),
        vector4(1937.040, 1942.213, 264.73, 186.848),
        vector4(1935.776, 1963.547, 262.521, 66.534),
        vector4(1935.863, 1945.714, 272.396, 274.137),
        --vector4(319.653, 1507.48, 182.207, 65.377),
        --vector4(367.588, 1476.987, 179.221, -14.809),
        --vector4(341.86602783203125, 1470.510009765625, 178.7422332763672, 125.99999237060547),
        --vector4(366.5763244628906, 1489.8642578125, 179.67971801757812, -164.46083068847656),
      },
      
      items = {
        { name = 'intel_folder', chance = 70, quantity = 1 },
        { name = 'moneybag', chance = 60, quantity = {min = 1, max = 3}, moneyReward = { min = 20, max = 80 } },
        { name = 'goldbar', chance = 30 },
        { name = 'crim_raid_fort_wallace_schedule', chance = 100, quantity = 1 },
      },
      
      itemSelection = {
        mode = 'independent',
        maxItems = 3
      },
      
      -- Using global random minigame setting (padlock or lockpick)
      -- minigame config inherited from Config.Loot.minigame
    },
    
  },
  --#endregion
   -- ===================================================================
  --                        NHSO FORT WALLACE
  --#region Checklist
  --   [X] Basic Info
  --   [X] Start Location
  --   [X] Start NPC Scenarios
  --   [X] Start NPC Dialogue
  --   [ ] Start Requirements
  --   [X] Law Alerts
  --   [X] Raid Boundary
  --   [X] Entity Limits 
  --   [X] Alarm System (disabled for now)
  --   [X] Timing
  --   [X] NPC Models
  --   [X] Special Rules
  --   [X] Sentry Positions (none for minor raid)
  --   [X] Patrol Positions (none for minor raid)
  --   [X] Turrets (none for minor raid)
  --   [X] Reinforcements (none for minor raid)
  --   [X] Waves (none for minor raid)
  --   [ ] Loot
  --#endregion

  -- ===================================================================
  --#region Fort Wallace
  fort_wallace = {
    
    -- BASIC INFO
    name = "Fort Wallace",
    enabled = true,
    jurisdiction = "NHSO",
    
    -- START LOCATION
    startPoint = vector4(595.2523, 647.0803, 115.3605, -48.4295),
    startNPCModel = 's_m_m_micguard_01',
    notifyRadius = 20.0,
    
    -- START NPC SCENARIOS
    scenario = "WORLD_HUMAN_STAND_IMPATIENT",
    idleScenarios = {
      "WORLD_HUMAN_STAND_WAITING",
      "WORLD_HUMAN_SMOKING",
      "WORLD_HUMAN_GUARD_LEAN_WALL"
    },
    scenarioCycleInterval = 1,
    
    -- START NPC DIALOGUE
    dialogue = {
      enabled = true,
      greetingDistance = 3.0,
      resetDistance = 50.0,
      
      animations = {
        talk = { type = "scenario", name = "WORLD_HUMAN_STAND_IMPATIENT" },
        give_map = { type = "anim", dict = "mech_inspection@letter@base", anim = "grab", flag = 0, duration = 3000 },
        player_take_map = { type = "anim", dict = "mech_inspection@letter@base", anim = "hold", flag = 49, duration = -1, prop = "s_mollyloveletter" },
      },
      
      lines = {
        greeting = "Damn army's been making my life hell lately.",
        steps = {
          { label = "How so?", text = "Their patrols have been tighter than a drum. Can't move goods without tripping over some soldier. Smuggling routes are all dried up.", anim = "talk" },
          { label = "What's that got to do with me?", text = "Fort Wallace is the source of my problems. But here's the thing - if someone were to... stir things up there, the army would need to restock. More weapons flowing in means more opportunity for people like me.", anim = "talk" },
          { label = "You want me to attack the fort?", text = "I ain't saying nothing directly, but... chaos is good for business. Army gets rattled, they order more supplies, corrupt officers get nervous and make deals. Here's where they are. What you do with that information is your business.", anim = "give_map", playerAnim = "player_take_map", action = "start" }
        },
        missingItem = "You're not prepared. Bring me a %s and then we can talk."
      }
    },
    
    -- START REQUIREMENTS
    requiredItem = nil,
    consumeRequiredItem = false,
    
    -- LAW ALERTS
    lawAlerts = {
      enabled = true,
      timingMode = 'random',
      triggerPoint = 'sentries_cleared',
      randomDelay = { min = 30, max = 180 },
      jobs = {'NHSO'}
    },
    
    -- RAID BOUNDARY
    boundary = {
      center = vector3(348.829, 1487.227, 179.460),
      radius = 250.0
    },
    
    -- ===================================================================
    --                    ENTITY LIMITS
    -- ===================================================================
    maxEntities = 22,  -- Override global Config.MaxRaidEntities for this raid (optional)
    
    -- ===================================================================
    --                    ALARM SYSTEM (DISABLED - TO BE IMPLEMENTED IN THE FUTURE)
    -- ===================================================================
    --[[ ALARM SYSTEM COMMENTED OUT - Audio not working yet
    alarm = {
      enabled = true,
      name = "FORT_ALARM",  -- Identifier for this alarm (not actual sound name - uses bell_school sound)
      location = vector3(348.829, 1487.227, 179.460),  -- Where alarm sound originates (fort center)
      triggerOn = 'combat_detected',  -- When to trigger: 'raid_start', 'combat_detected', 'sentries_cleared'
      disableObject = {
        enabled = true,
        model = 's_dov_lab_panel02x',  -- Electrical panel model
        coords = vector4(337.74310302734375, 1496.3299560546875, 180.15704345703125, -148.58297729492188),  -- Inside main building
        freeze = true
      },
      disableMinigame = {
        enabled = true,
        type = 'wirecutting',
        difficulty = 'medium'  -- easy, medium, hard
      }
    },
    ]]--
    
    -- ===================================================================
    --                    TIMING
    -- ===================================================================
    waveDelay = nil,  -- No waves
    
    -- ACCESS TIMER FOR LOOT
    accessTimer = 0.5,  -- 0.5 minutes wait after clearing sentries/patrols
    
    -- NPC MODELS
    npcModels = { 's_m_m_army_01' },
    leaderModel = 's_m_m_army_01',
    
    -- SPECIAL RULES
    friendlyJobs = {"NARO", "USMO", "WESO", "LSO", "NHSO", "USDO"},  -- Law jobs cannot start this raid
    minLawCount = nil,  -- Minimum law officers required to start raid (nil = no requirement)
    
    -- ===================================================================
    --                    PATROL BEHAVIOR
    -- ===================================================================
    patrolRadius = 40.0,
    patrolPoints = 4,
    patrolWaitTime = 5000,
    
    -- ===================================================================
    --                    WEAPON POOLS
    -- ===================================================================
    weaponPools = {
      snipers = { 'WEAPON_RIFLE_BOLTACTION', 'WEAPON_SNIPERRIFLE_ROLLINGBLOCK' },
      repeaters = { 'WEAPON_REPEATER_WINCHESTER', 'WEAPON_REPEATER_CARBINE' },
      revolvers = { 'WEAPON_REVOLVER_CATTLEMAN' },
      rifles = { 'WEAPON_RIFLE_SPRINGFIELD' },
      shotguns = { 'WEAPON_SHOTGUN_DOUBLEBARREL' }
    },
    
    -- ===================================================================
    --                    AI BEHAVIOR
    -- ===================================================================
    AI = {
      difficulty = {
        playersDivisor = 2.0,  -- Difficulty scales with players
      },
      accuracy = {
        base = 25,
        min = 15,
        max = 40
      },
      health = {
        base = 150,
        multiplier = 1.0
      },
      combat = {
        coverUsage = 30,
        flankingChance = 20,
        aggressiveness = 50
      }
    },
    
    -- ===================================================================
    --                    SENTRY POSITIONS
    -- ===================================================================
    sentryPositions = {
      vector4(312.101, 1491.363, 186.790, 150.221),
      vector4(319.511, 1482.182, 185.388, 207.941),
      vector4(329.604, 1478.917, 183.506, 176.646),
      vector4(336.290, 1473.456, 183.381, 149.806),
      vector4(347.863, 1457.653, 185.537, 219.793),
      vector4(355.238, 1463.270, 183.713, 213.239),
      vector4(360.682, 1467.657, 183.691, 218.147),
      vector4(367.733, 1470.749, 184.639, 202.613),
      vector4(363.819, 1474.221, 184.610, 80.680),
      vector4(369.253, 1498.978, 183.375, 284.598),
      vector4(365.758, 1508.079, 183.321, 292.151),
      vector4(365.395, 1516.479, 184.823, 293.812),
      vector4(363.073, 1518.721, 184.818, 343.848),
      vector4(360.989, 1513.010, 184.818, 162.788),
      vector4(346.427, 1515.494, 184.740, 204.295),
      vector4(331.428, 1506.148, 186.787, 329.059),
      vector4(322.052, 1511.528, 189.801, 335.422),
      vector4(320.763, 1509.113, 192.766, 160.126),
      vector4(312.472, 1502.268, 186.770, 256.523),
      vector4(309.688, 1494.722, 186.779, 174.285),
      vector4(319.233, 1482.045, 185.395, 209.605),
      vector4(340.557, 1500.247, 180.827, 206.765),
    },
    
    -- ===================================================================
    --                    PATROL POSITIONS
    -- ===================================================================
    -- Roaming guards that move around
    patrols = {
      vector4(343.811, 1486.851, 179.591, 81.859),
      vector4(356.253, 1493.523, 180.013, 192.158),
      vector4(325.614, 1483.258, 180.295, 331.343),
      vector4(377.702, 1455.498, 178.278, 218.592),
      vector4(350.153, 1441.734, 176.551, 186.465),
      vector4(325.839, 1466.617, 179.340, 65.347),
      vector4(340.770, 1523.903, 183.198, 284.989),
      vector4(357.537, 1507.420, 180.017, 159.620),
    },
    
    -- ===================================================================
    --                    TURRETS
    -- ===================================================================
    -- NOTE: Turrets do NOT count towards Config.MaxRaidEntities limit
    turretSpawnMode = 'dynamic',               -- 'static' (all) or 'dynamic' (random selection)
    turretDynamicCount = 0,                    -- No turrets
    
    turrets = {},  -- No turrets
    
    -- ===================================================================
    --                    SENTRY DEFAULTS (10m engagement range)
    -- ===================================================================
    sentryDefaults = {
      aggroRange = 80.0,  -- Sentries only engage when player is within 80 meters
      leashDistance = 30.0,  -- Return to spawn if more than 30m away
    },
    
    -- ===================================================================
    --                    REINFORCEMENTS
    -- ===================================================================
    reinforcements = {
      enabled = false,
      triggerMode = 'timer',
      delaySeconds = 60,
      thresholdPercent = 50,
      spawnFrequency = 'once',
      count = 2,
      npcModels = { 's_m_m_army_01' },
      horseModels = { 'A_C_Horse_KentuckySaddle_Grey' },
    },

    reinforcementSpawnPoints = {
      vector3(250.0, 1550.0, 180.0),
      vector3(450.0, 1450.0, 180.0),
      vector3(300.0, 1400.0, 180.0),
      vector3(400.0, 1550.0, 180.0),
    },

    -- ===================================================================
    --                    WAVES
    -- ===================================================================
    wavesEnabled = false,
    waves = {},  -- No waves
    
    -- ===================================================================
    --                    LOOT (only specify what's different from defaults)
    -- ===================================================================
    loot = {
      chestModel = 'mp001_p_mp_strongbox01x_lrg',  -- Army strongbox model
      boxCount = { min = 2, max = 4 },      -- Fixed 7 boxes
      
      spawnPoints = {
        vector4(359.25, 1514.22, 183.83, 98.999),
        vector4(320.041, 1511.327, 190.75, 65.970),
        vector4(343.295, 1481.381, 177.625, 126.445),
        vector4(315.543, 1496.554, 179.356, 124.428),
        vector4(332.659, 1503.587, 179.978, -52.228),
        vector4(319.653, 1507.48, 181.207, 65.377),
        vector4(367.588, 1476.987, 178.221, -14.809),
        vector4(341.86602783203125, 1470.510009765625, 177.7422, 125.99999237060547),
        vector4(366.5763244628906, 1489.8642578125, 178.6797, -164.46083068847656),
      },
      
      items = {
        --{ name = 'intel_folder', chance = 70, quantity = 1 },
        { name = 'moneybag', chance = 60, quantity = {min = 2, max = 4}, moneyReward = { min = 20, max = 80 } },
        { name = 'goldbar', chance = 30 }
      },
      
      itemSelection = {
        mode = 'independent',
        maxItems = 3
      },
      
      -- Using global random minigame setting (padlock or lockpick)
      -- minigame config inherited from Config.Loot.minigame
    },
    
  },

  --#endregion
   -- ===================================================================
  --                        NHSO Old Broken Fort Minor Raid
  --#region Checklist
  --   [ ] Basic Info
  --   [X] Start Location
  --   [ ] Start NPC Scenarios
  --   [ ] Start NPC Dialogue
  --   [ ] Start Requirements
  --   [ ] Law Alerts
  --   [X] Raid Boundary
  --   [X] Entity Limits 
  --   [X] Alarm System (disabled for now)
  --   [X] Timing
  --   [ ] NPC Models
  --   [X] Special Rules
  --   [X] Sentry Positions (none for minor raid)
  --   [X] Patrol Positions (none for minor raid)
  --   [X] Turrets (none for minor raid)
  --   [X] Reinforcements (none for minor raid)
  --   [X] Waves (none for minor raid)
  --   [X] Loot Needs testing
  --#endregion
  -- ===================================================================
  --#region Old Broken Fort Minor Raid
  old_broken_fort_minor = {
    
    -- BASIC INFO
    name = "Old Broken Fort Raid",
    enabled = true,
    jurisdiction = "NHSO",
    
    -- START LOCATION
    startPoint = vector4(2820.623, 274.068, 47.147, 224.708),
    startNPCModel = 's_m_m_micguard_01',
    notifyRadius = 20.0,
    
    -- START NPC SCENARIOS
    scenario = "WORLD_HUMAN_STAND_IMPATIENT",
    idleScenarios = {
      "WORLD_HUMAN_STAND_WAITING",
      "WORLD_HUMAN_SMOKING",
      "WORLD_HUMAN_GUARD_LEAN_WALL"
    },
    scenarioCycleInterval = 1,
    
    -- START NPC DIALOGUE
    dialogue = {
      enabled = true,
      greetingDistance = 3.0,
      resetDistance = 50.0,
      
      animations = {
        talk = { type = "scenario", name = "WORLD_HUMAN_STAND_IMPATIENT" },
        give_map = { type = "anim", dict = "mech_inspection@letter@base", anim = "grab", flag = 0, duration = 3000 },
        player_take_map = { type = "anim", dict = "mech_inspection@letter@base", anim = "hold", flag = 49, duration = -1, prop = "s_mollyloveletter" },
      },
      
      lines = {
        greeting = "Those damn bandits have taken over the old marshal's fort. It's a real problem.",
        steps = {
          { label = "How bad is it?", text = "They've turned that abandoned fort into their stronghold. Using it to plan raids, store stolen goods, and organize their operations across the whole region. Sheriff can't touch 'em there.", anim = "talk" },
          { label = "Why tell me this?", text = "That fort is the heart of their operation. If someone were to hit 'em there, tear it apart, they'd scatter like rats. Without their base, they'd lose everything - their supplies, their organization, their nerve.", anim = "talk" },
          { label = "I'll raid the fort.", text = "Now that's what I like to hear. Those bandits think they're safe behind those old walls, but they're vulnerable if someone's got the guts to challenge 'em. Here's where they've dug in. Go show 'em that fort ain't theirs to keep.", anim = "give_map", playerAnim = "player_take_map", action = "start" }
        },
        missingItem = "You're not ready to take on that many bandits. Come back when you got yourself a %s."
      }
    },
    
    -- START REQUIREMENTS
    requiredItem = nil,
    consumeRequiredItem = false,
    
    -- LAW ALERTS
    lawAlerts = {
      enabled = true,
      timingMode = 'random',
      triggerPoint = 'sentries_cleared',
      randomDelay = { min = 30, max = 180 },
      jobs = {'NHSO'}
    },
    
    -- RAID BOUNDARY
    boundary = {
      center = vector3(2454.987, 290.983, 70.519),
      radius = 250.0
    },
    
    -- ===================================================================
    --                    ENTITY LIMITS
    -- ===================================================================
    maxEntities = 22,  -- Override global Config.MaxRaidEntities for this raid (optional)
    
    -- ===================================================================
    --                    ALARM SYSTEM (DISABLED - TO BE IMPLEMENTED IN THE FUTURE)
    -- ===================================================================
    --[[ ALARM SYSTEM COMMENTED OUT - Audio not working yet
    alarm = {
      enabled = true,
      name = "FORT_ALARM",  -- Identifier for this alarm (not actual sound name - uses bell_school sound)
      location = vector3(348.829, 1487.227, 179.460),  -- Where alarm sound originates (fort center)
      triggerOn = 'combat_detected',  -- When to trigger: 'raid_start', 'combat_detected', 'sentries_cleared'
      disableObject = {
        enabled = true,
        model = 's_dov_lab_panel02x',  -- Electrical panel model
        coords = vector4(337.74310302734375, 1496.3299560546875, 180.15704345703125, -148.58297729492188),  -- Inside main building
        freeze = true
      },
      disableMinigame = {
        enabled = true,
        type = 'wirecutting',
        difficulty = 'medium'  -- easy, medium, hard
      }
    },
    ]]--
    
    -- ===================================================================
    --                    TIMING
    -- ===================================================================
    waveDelay = nil,  -- No waves
    
    -- ACCESS TIMER FOR LOOT
    accessTimer = 0.5,  -- 0.5 minutes wait after clearing sentries/patrols
    
    -- NPC MODELS
    npcModels = { 's_m_m_army_01' },
    leaderModel = 's_m_m_army_01',
    
    -- SPECIAL RULES
    friendlyJobs = {"NARO", "USMO", "WESO", "LSO", "NHSO", "USDO"},  -- Law jobs cannot start this raid
    minLawCount = nil,  -- Minimum law officers required to start raid (nil = no requirement)
    
    -- ===================================================================
    --                    PATROL BEHAVIOR
    -- ===================================================================
    patrolRadius = 40.0,
    patrolPoints = 4,
    patrolWaitTime = 5000,
    
    -- ===================================================================
    --                    WEAPON POOLS
    -- ===================================================================
    weaponPools = {
      snipers = { 'WEAPON_RIFLE_BOLTACTION', 'WEAPON_SNIPERRIFLE_ROLLINGBLOCK' },
      repeaters = { 'WEAPON_REPEATER_WINCHESTER', 'WEAPON_REPEATER_CARBINE' },
      revolvers = { 'WEAPON_REVOLVER_CATTLEMAN' },
      rifles = { 'WEAPON_RIFLE_SPRINGFIELD' },
      shotguns = { 'WEAPON_SHOTGUN_DOUBLEBARREL' }
    },
    
    -- ===================================================================
    --                    AI BEHAVIOR
    -- ===================================================================
    AI = {
      difficulty = {
        playersDivisor = 2.0,  -- Difficulty scales with players
      },
      accuracy = {
        base = 25,
        min = 15,
        max = 40
      },
      health = {
        base = 150,
        multiplier = 1.0
      },
      combat = {
        coverUsage = 30,
        flankingChance = 20,
        aggressiveness = 50
      }
    },
    
    -- ===================================================================
    --                    SENTRY POSITIONS
    -- ===================================================================
    sentryPositions = {
      vector4(2435.749, 314.688, 68.654, 118.713),
      vector4(2456.646, 300.702, 70.284, 357.272),
      vector4(2448.592, 296.650, 70.228, 170.931),
      vector4(2450.836, 285.915, 70.451, 219.696),
      vector4(2454.267, 278.940, 70.569, 209.878),
      vector4(2448.569, 277.553, 74.728, 208.927),
      vector4(2452.220, 277.579, 74.916, 155.168),
      vector4(2458.629, 277.177, 75.441, 155.332),
      vector4(2440.854, 286.505, 74.230, 81.922),
      vector4(2441.712, 296.807, 74.165, 81.828),
      vector4(2441.694, 300.440, 74.335, 81.835),
      vector4(2464.683, 294.843, 74.820, 269.808),
      vector4(2459.601, 304.444, 74.844, 2.686),
      vector4(2466.096, 304.728, 76.555, 288.018),
    },
    
    -- ===================================================================
    --                    PATROL POSITIONS
    -- ===================================================================
    -- Roaming guards that move around
    patrols = {
      vector4(2454.842, 270.304, 70.089, 161.832),
      vector4(2469.928, 266.031, 70.941, 335.037),
      vector4(2474.500, 279.463, 71.510, 345.944),
      vector4(2475.079, 294.901, 71.859, 356.550),
      vector4(2473.478, 303.695, 73.369, 76.838),
      vector4(2458.032, 315.428, 71.073, 63.485),
      vector4(2441.937, 314.394, 68.664, 99.714),
      vector4(2433.094, 312.383, 68.880, 83.537),
      vector4(2430.780, 300.578, 69.084, 167.755),
      vector4(2430.531, 285.408, 68.239, 176.995),
    },
    
    -- ===================================================================
    --                    TURRETS
    -- ===================================================================
    -- NOTE: Turrets do NOT count towards Config.MaxRaidEntities limit
    turretSpawnMode = 'dynamic',               -- 'static' (all) or 'dynamic' (random selection)
    turretDynamicCount = 0,                    -- No turrets
    
    turrets = {},  -- No turrets
    
    -- ===================================================================
    --                    SENTRY DEFAULTS (10m engagement range)
    -- ===================================================================
    sentryDefaults = {
      aggroRange = 80.0,  -- Sentries only engage when player is within 80 meters
      leashDistance = 30.0,  -- Return to spawn if more than 30m away
    },
    
    -- ===================================================================
    --                    REINFORCEMENTS
    -- ===================================================================
    reinforcements = {
      enabled = false,
      triggerMode = 'timer',
      delaySeconds = 60,
      thresholdPercent = 50,
      spawnFrequency = 'once',
      count = 2,
      npcModels = { 's_m_m_army_01' },
      horseModels = { 'A_C_Horse_KentuckySaddle_Grey' },
    },

    reinforcementSpawnPoints = {
      vector3(250.0, 1550.0, 180.0),
      vector3(450.0, 1450.0, 180.0),
      vector3(300.0, 1400.0, 180.0),
      vector3(400.0, 1550.0, 180.0),
    },

    -- ===================================================================
    --                    WAVES
    -- ===================================================================
    wavesEnabled = false,
    waves = {},  -- No waves
    
    -- ===================================================================
    --                    LOOT (only specify what's different from defaults)
    -- ===================================================================
    loot = {
      chestModel = 'mp001_p_mp_strongbox01x_lrg',  -- Army strongbox model
      boxCount = { min = 2, max = 4 },      -- Fixed 7 boxes
      
      spawnPoints = {
        vector4(2461.332, 285.105, 70.032, 265.677),
        vector4(2449.371, 278.544, 69.536, 170.811),
        vector4(2447.062, 304.519, 69.348, 6.735),
        vector4(2443.588, 292.496, 66.333, 88.234),
        vector4(2446.789, 288.019, 66.261, 165.380),
        --vector4(319.653, 1507.48, 182.207, 65.377),
        --vector4(367.588, 1476.987, 179.221, -14.809),
        --vector4(341.86602783203125, 1470.510009765625, 178.7422332763672, 125.99999237060547),
        --vector4(366.5763244628906, 1489.8642578125, 179.67971801757812, -164.46083068847656),
      },
      
      items = {
        { name = 'intel_folder', chance = 70, quantity = 1 },
        { name = 'moneybag', chance = 60, quantity = {min = 1, max = 3}, moneyReward = { min = 20, max = 80 } },
        { name = 'goldbar', chance = 30 }
      },
      
      itemSelection = {
        mode = 'independent',
        maxItems = 3
      },
      
      -- Using global random minigame setting (padlock or lockpick)
      -- minigame config inherited from Config.Loot.minigame
    },
    
  },
  --#endregion
  -- ===================================================================
  --                        WESO Mnt Hagen Minor Raid
  --#region Checklist
  --   [ ] Basic Info
  --   [X] Start Location
  --   [ ] Start NPC Scenarios
  --   [ ] Start NPC Dialogue
  --   [ ] Start Requirements
  --   [ ] Law Alerts
  --   [ ] Raid Boundary
  --   [ ] Entity Limits 
  --   [ ] Alarm System (disabled for now)
  --   [ ] Timing
  --   [ ] NPC Models
  --   [ ] Special Rules
  --   [ ] Sentry Positions (none for minor raid)
  --   [ ] Patrol Positions (none for minor raid)
  --   [ ] Turrets (none for minor raid)
  --   [ ] Reinforcements (none for minor raid)
  --   [ ] Waves (none for minor raid)
  --   [ ] Loot
  --#endregion
  -- ===================================================================
  --#region Mnt Hagen Minor Raid
  mnt_hagen_minor = {
    
    -- BASIC INFO
    name = "Mount Hagen Minor Raid",
    enabled = true,
    jurisdiction = "WESO",
    
    -- START LOCATION
    startPoint = vector4(-1090.224, 703.148, 104.285, 228.551),
    startNPCModel = 's_m_m_micguard_01',
    notifyRadius = 20.0,
    
    -- START NPC SCENARIOS
    scenario = "WORLD_HUMAN_STAND_IMPATIENT",
    idleScenarios = {
      "WORLD_HUMAN_STAND_WAITING",
      "WORLD_HUMAN_SMOKING",
      "WORLD_HUMAN_GUARD_LEAN_WALL"
    },
    scenarioCycleInterval = 1,
    
    -- START NPC DIALOGUE
    dialogue = {
      enabled = true,
      greetingDistance = 3.0,
      resetDistance = 50.0,
      
      animations = {
        talk = { type = "scenario", name = "WORLD_HUMAN_STAND_IMPATIENT" },
        give_map = { type = "anim", dict = "mech_inspection@letter@base", anim = "grab", flag = 0, duration = 3000 },
        player_take_map = { type = "anim", dict = "mech_inspection@letter@base", anim = "hold", flag = 49, duration = -1, prop = "s_mollyloveletter" },
      },
      
      lines = {
        greeting = "Did the doc send you? I've got a proposition for you.",
        steps = {
          { label = "Depends, maybe for the right price", text = "Yeah sure whatever, Ive been hearing some rumors that the Doolin Gang are hiding something pretty valuable there.", anim = "talk" },
          { label = "What's that got to do with me?", text = "If you help me out, I might have a way for you to profit from it.", anim = "talk" },
          { label = "Yeah, I'm interested", text = "Head to the mine and find out what they're hiding.", anim = "give_map", playerAnim = "player_take_map", action = "start" }
        },
        missingItem = "You're not prepared. Bring me a %s and then we can talk."
      }
    },
    
    -- START REQUIREMENTS
    requiredItem = nil,
    consumeRequiredItem = false,
    
    -- LAW ALERTS
    lawAlerts = {
      enabled = true,
      timingMode = 'random',
      triggerPoint = 'sentries_cleared',
      randomDelay = { min = 30, max = 180 },
      jobs = {'NHSO'}
    },
    
    -- RAID BOUNDARY
    boundary = {
      center = vector4(-1398.132, 1148.957, 224.597, 236.799),
      radius = 250.0
    },
    
    -- ===================================================================
    --                    ENTITY LIMITS
    -- ===================================================================
    maxEntities = 22,  -- Override global Config.MaxRaidEntities for this raid (optional)
    
    -- ===================================================================
    --                    ALARM SYSTEM (DISABLED - TO BE IMPLEMENTED IN THE FUTURE)
    -- ===================================================================
    --[[ ALARM SYSTEM COMMENTED OUT - Audio not working yet
    alarm = {
      enabled = true,
      name = "FORT_ALARM",  -- Identifier for this alarm (not actual sound name - uses bell_school sound)
      location = vector3(348.829, 1487.227, 179.460),  -- Where alarm sound originates (fort center)
      triggerOn = 'combat_detected',  -- When to trigger: 'raid_start', 'combat_detected', 'sentries_cleared'
      disableObject = {
        enabled = true,
        model = 's_dov_lab_panel02x',  -- Electrical panel model
        coords = vector4(337.74310302734375, 1496.3299560546875, 180.15704345703125, -148.58297729492188),  -- Inside main building
        freeze = true
      },
      disableMinigame = {
        enabled = true,
        type = 'wirecutting',
        difficulty = 'medium'  -- easy, medium, hard
      }
    },
    ]]--
    
    -- ===================================================================
    --                    TIMING
    -- ===================================================================
    waveDelay = nil,  -- No waves
    
    -- ACCESS TIMER FOR LOOT
    accessTimer = 0.5,  -- 0.5 minutes wait after clearing sentries/patrols
    
    -- NPC MODELS
    npcModels = { 'u_m_m_odriscollbrawler_01', 'u_m_m_bht_odriscolldrunk', 'u_m_m_bht_odriscollsleeping' },
    leaderModel = 'u_m_m_odriscollbrawler_01',
    
    -- SPECIAL RULES
    friendlyJobs = {},  -- Law jobs cannot start this raid
    minLawCount = nil,  -- Minimum law officers required to start raid (nil = no requirement)
    
    -- ===================================================================
    --                    PATROL BEHAVIOR
    -- ===================================================================
    patrolRadius = 40.0,
    patrolPoints = 4,
    patrolWaitTime = 5000,
    
    -- ===================================================================
    --                    WEAPON POOLS
    -- ===================================================================
    weaponPools = {
      snipers = { 'WEAPON_RIFLE_BOLTACTION', 'WEAPON_SNIPERRIFLE_ROLLINGBLOCK' },
      repeaters = { 'WEAPON_REPEATER_WINCHESTER', 'WEAPON_REPEATER_CARBINE' },
      revolvers = { 'WEAPON_REVOLVER_CATTLEMAN' },
      rifles = { 'WEAPON_RIFLE_SPRINGFIELD' },
      shotguns = { 'WEAPON_SHOTGUN_DOUBLEBARREL' }
    },
    
    -- ===================================================================
    --                    AI BEHAVIOR
    -- ===================================================================
    AI = {
      difficulty = {
        playersDivisor = 2.0,  -- Difficulty scales with players
      },
      accuracy = {
        base = 25,
        min = 15,
        max = 40
      },
      health = {
        base = 150,
        multiplier = 1.0
      },
      combat = {
        coverUsage = 30,
        flankingChance = 20,
        aggressiveness = 50
      }
    },
    
    -- ===================================================================
    --                    SENTRY POSITIONS
    -- ===================================================================
    sentryPositions = {
      vector4(-1333.454, 1155.653, 200.651, 277.911),
      vector4(-1332.666, 1148.869, 199.953, 277.120),
      vector4(-1333.355, 1141.201, 198.682, 270.453),
      vector4(-1359.872, 1135.989, 209.262, 306.672),
      vector4(-1352.448, 1162.574, 217.109, 255.510),
      vector4(-1347.535, 1176.932, 216.259, 265.245),
      vector4(-1374.905, 1162.459, 224.575, 235.187),
      vector4(-1379.518, 1155.227, 223.907, 195.585),
      vector4(-1409.666, 1134.818, 225.441, 316.936),
      vector4(-1412.279, 1137.925, 225.618, 330.458),
      vector4(-1410.978, 1161.873, 226.664, 228.687),
      vector4(-1412.874, 1166.913, 226.618, 228.461),
      vector4(-1429.601, 1177.549, 226.535, 249.099),
      vector4(-1408.255, 1126.732, 229.286, 344.738),
      vector4(-1412.868, 1133.784, 230.614, 309.811),
      vector4(-1386.864, 1152.634, 225.082, 118.673),
    },
    
    -- ===================================================================
    --                    PATROL POSITIONS
    -- ===================================================================
    -- Roaming guards that move around
    patrols = {
      vector4(-1299.174, 1172.569, 190.348, 272.367),
      vector4(-1295.957, 1171.489, 188.966, 296.919),
      vector4(-1297.128, 1174.618, 189.985, 310.055),
      vector4(-1284.579, 1143.286, 182.725, 236.408),
      vector4(-1282.874, 1146.289, 181.744, 249.581),
      vector4(-1287.030, 1146.843, 183.192, 68.114),
    },
    
    
    -- ===================================================================
    --                    TURRETS
    -- ===================================================================
    -- NOTE: Turrets do NOT count towards Config.MaxRaidEntities limit
    turretSpawnMode = 'dynamic',               -- 'static' (all) or 'dynamic' (random selection)
    turretDynamicCount = 0,                    -- No turrets
    
    turrets = {},  -- No turrets
    
    -- ===================================================================
    --                    SENTRY DEFAULTS (10m engagement range)
    -- ===================================================================
    sentryDefaults = {
      aggroRange = 80.0,  -- Sentries only engage when player is within 80 meters
      leashDistance = 30.0,  -- Return to spawn if more than 30m away
    },
    
    -- ===================================================================
    --                    REINFORCEMENTS
    -- ===================================================================
    reinforcements = {
      enabled = false,
      triggerMode = 'timer',
      delaySeconds = 60,
      thresholdPercent = 50,
      spawnFrequency = 'once',
      count = 2,
      npcModels = { 's_m_m_army_01' },
      horseModels = { 'A_C_Horse_KentuckySaddle_Grey' },
    },

    reinforcementSpawnPoints = {
      vector3(250.0, 1550.0, 180.0),
      vector3(450.0, 1450.0, 180.0),
      vector3(300.0, 1400.0, 180.0),
      vector3(400.0, 1550.0, 180.0),
    },

    -- ===================================================================
    --                    WAVES
    -- ===================================================================
    wavesEnabled = false,
    waves = {},  -- No waves
    
    -- ===================================================================
    --                    LOOT (only specify what's different from defaults)
    -- ===================================================================
    loot = {
      chestModel = 'mp001_p_mp_strongbox01x_lrg',  -- Army strongbox model
      boxCount = { min = 2, max = 4 },      -- Fixed 7 boxes
      
      spawnPoints = {
        vector4(-1415.665, 1132.059, 224.597, 127.815),
        vector4(-1385.467, 1157.649, 224.275, 326.427),
        vector4(-1432.819, 1177.001, 225.436, 166.579),
        vector4(-1447.065, 1196.059, 225.403, 261.495),
       -- vector4(2446.789, 288.019, 67.261, 165.380),
        --vector4(319.653, 1507.48, 182.207, 65.377),
        --vector4(367.588, 1476.987, 179.221, -14.809),
        --vector4(341.86602783203125, 1470.510009765625, 178.7422332763672, 125.99999237060547),
        --vector4(366.5763244628906, 1489.8642578125, 179.67971801757812, -164.46083068847656),
      },
      
      items = {
        { name = 'intel_folder', chance = 70, quantity = 1 },
        { name = 'moneybag', chance = 60, quantity = {min = 1, max = 3}, moneyReward = { min = 20, max = 80 } },
        { name = 'goldbar', chance = 30 },
        { name = 'crim_raid_mining_records', chance = 50, quantity = 1 },
      },
      
      itemSelection = {
        mode = 'independent',
        maxItems = 3
      },
      
      -- Using global random minigame setting (padlock or lockpick)
      -- minigame config inherited from Config.Loot.minigame
    },
    
  },
  --#endregion
   -- ===================================================================
  --                        NARO Twin Rocks Minor Raid
  --#region Checklist
  --   [ ] Basic Info
  --   [ ] Start Location
  --   [ ] Start NPC Scenarios
  --   [ ] Start NPC Dialogue
  --   [ ] Start Requirements
  --   [ ] Law Alerts
  --   [X] Raid Boundary
  --   [X] Entity Limits 
  --   [ ] Alarm System (disabled for now)
  --   [ ] Timing
  --   [ ] NPC Models
  --   [ ] Special Rules
  --   [X] Sentry Positions (none for minor raid)
  --   [X] Patrol Positions (none for minor raid)
  --   [ ] Turrets (none for minor raid)
  --   [ ] Reinforcements (none for minor raid)
  --   [ ] Waves (none for minor raid)
  --   [ ] Loot
  --#endregion
  -- ===================================================================
  --#region Twin Rocks Minor Raid
  twin_rocks_minor = {
    
    -- BASIC INFO
    name = "Twin Rocks Minor Raid",
    enabled = true,
    jurisdiction = "NARO",
    
    -- START LOCATION
    startPoint = vector4(-3444.792, -2255.716, -0.839, 59.499),
    startNPCModel = 'MP_G_M_M_UniBanditos_01',
    notifyRadius = 20.0,
    
    -- START NPC SCENARIOS
    scenario = "WORLD_HUMAN_STAND_IMPATIENT",
    idleScenarios = {
      "WORLD_HUMAN_STAND_WAITING",
      "WORLD_HUMAN_SMOKING",
      "WORLD_HUMAN_GUARD_LEAN_WALL"
    },
    scenarioCycleInterval = 1,
    
    -- START NPC DIALOGUE
    dialogue = {
      enabled = true,
      greetingDistance = 3.0,
      resetDistance = 50.0,
      
      animations = {
        talk = { type = "scenario", name = "WORLD_HUMAN_STAND_IMPATIENT" },
        give_map = { type = "anim", dict = "mech_inspection@letter@base", anim = "grab", flag = 0, duration = 3000 },
        player_take_map = { type = "anim", dict = "mech_inspection@letter@base", anim = "hold", flag = 49, duration = -1, prop = "s_mollyloveletter" },
      },
      
      lines = {
        greeting = "Hey you! Yeah you, looking for work? I might have a job for you, but it's a bit risky.",
        steps = {
          { label = "How so?", text = "The del lobo's gang is planning something big, and it's causing trouble for everyone in the area.", anim = "talk" },
          { label = "Why should I care?", text = "Rumor has it they're preparing the job to end all jobs, something that can set you up for life.", anim = "talk" },
          { label = "So you want me to crash this meeting?", text = "Exactly. But be careful, it's not going to be easy.", anim = "give_map", playerAnim = "player_take_map", action = "start" }
        },
      },
    },
    
    -- START REQUIREMENTS
    requiredItem = nil,
    consumeRequiredItem = false,
    
    -- LAW ALERTS
    lawAlerts = {
      enabled = true,
      timingMode = 'random',
      triggerPoint = 'sentries_cleared',
      randomDelay = { min = 30, max = 180 },
      jobs = {'NHSO'}
    },
    
    -- RAID BOUNDARY
    boundary = {
      center = vector3(-3962.433, -2140.587, -5.168),
      radius = 250.0
    },
    
    -- ===================================================================
    --                    ENTITY LIMITS
    -- ===================================================================
    maxEntities = 22,  -- Override global Config.MaxRaidEntities for this raid (optional)
    
    -- ===================================================================
    --                    ALARM SYSTEM (DISABLED - TO BE IMPLEMENTED IN THE FUTURE)
    -- ===================================================================
    --[[ ALARM SYSTEM COMMENTED OUT - Audio not working yet
    alarm = {
      enabled = true,
      name = "FORT_ALARM",  -- Identifier for this alarm (not actual sound name - uses bell_school sound)
      location = vector3(348.829, 1487.227, 179.460),  -- Where alarm sound originates (fort center)
      triggerOn = 'combat_detected',  -- When to trigger: 'raid_start', 'combat_detected', 'sentries_cleared'
      disableObject = {
        enabled = true,
        model = 's_dov_lab_panel02x',  -- Electrical panel model
        coords = vector4(337.74310302734375, 1496.3299560546875, 180.15704345703125, -148.58297729492188),  -- Inside main building
        freeze = true
      },
      disableMinigame = {
        enabled = true,
        type = 'wirecutting',
        difficulty = 'medium'  -- easy, medium, hard
      }
    },
    ]]--
    
    -- ===================================================================
    --                    TIMING
    -- ===================================================================
    waveDelay = nil,  -- No waves
    
    -- ACCESS TIMER FOR LOOT
    accessTimer = 0.5,  -- 0.5 minutes wait after clearing sentries/patrols
    
    -- NPC MODELS
    npcModels = { 's_m_m_army_01' },
    leaderModel = 's_m_m_army_01',
    
    -- SPECIAL RULES
    friendlyJobs = {"NARO", "USMO", "WESO", "LSO", "NHSO", "USDO"},  -- Law jobs cannot start this raid
    minLawCount = nil,  -- Minimum law officers required to start raid (nil = no requirement)
    
    -- ===================================================================
    --                    PATROL BEHAVIOR
    -- ===================================================================
    patrolRadius = 40.0,
    patrolPoints = 4,
    patrolWaitTime = 5000,
    
    -- ===================================================================
    --                    WEAPON POOLS
    -- ===================================================================
    weaponPools = {
      snipers = { 'WEAPON_RIFLE_BOLTACTION', 'WEAPON_SNIPERRIFLE_ROLLINGBLOCK' },
      repeaters = { 'WEAPON_REPEATER_WINCHESTER', 'WEAPON_REPEATER_CARBINE' },
      revolvers = { 'WEAPON_REVOLVER_CATTLEMAN' },
      rifles = { 'WEAPON_RIFLE_SPRINGFIELD' },
      shotguns = { 'WEAPON_SHOTGUN_DOUBLEBARREL' }
    },
    
    -- ===================================================================
    --                    AI BEHAVIOR
    -- ===================================================================
    AI = {
      difficulty = {
        playersDivisor = 2.0,  -- Difficulty scales with players
      },
      accuracy = {
        base = 25,
        min = 15,
        max = 40
      },
      health = {
        base = 150,
        multiplier = 1.0
      },
      combat = {
        coverUsage = 30,
        flankingChance = 20,
        aggressiveness = 50
      }
    },
    
    -- ===================================================================
    --                    SENTRY POSITIONS
    -- ===================================================================
    sentryPositions = {
      vector4(-3976.169, -2154.843, -5.172, 86.862),
      vector4(-3973.638, -2150.329, -4.949, 94.558),
      vector4(-3975.157, -2145.821, -4.773, 103.476),
      vector4(-3964.945, -2146.166, -5.155, 168.639),
      vector4(-3958.765, -2146.399, -5.167, 178.584),
      vector4(-3950.832, -2143.673, -5.165, 219.357),
      vector4(-3947.819, -2137.506, -5.166, 257.664),
      vector4(-3949.025, -2130.935, -5.168, 287.834),
      vector4(-3954.476, -2125.988, -5.168, 331.453),
      vector4(-3960.852, -2124.670, -5.168, 359.144),
      vector4(-3969.152, -2125.758, -5.168, 27.892),
      vector4(-3974.814, -2130.168, -5.168, 61.759),
      vector4(-3977.413, -2136.698, -5.168, 85.434),
      vector4(-3976.532, -2142.924, -5.168, 103.267),
    },
    
    -- ===================================================================
    --                    PATROL POSITIONS
    -- ===================================================================
    -- Roaming guards that move around
    patrols = {
      vector4(-3962.117, -2182.815, -6.615, 187.392),
      vector4(-3996.333, -2174.461, -6.407, 23.727),
      vector4(-4013.372, -2139.781, -6.043, 8.562),
      vector4(-4001.763, -2111.952, -5.730, 348.511),
      vector4(-3980.698, -2089.279, -3.989, 277.208),
      vector4(-3943.718, -2078.083, 3.296, 222.737),
      vector4(-3919.293, -2091.897, 4.676, 226.686),
      vector4(-3911.698, -2114.194, 4.309, 152.853),
      vector4(-3904.253, -2142.268, 7.300, 121.886),
    },
    
    -- ===================================================================
    --                    TURRETS
    -- ===================================================================
    -- NOTE: Turrets do NOT count towards Config.MaxRaidEntities limit
    turretSpawnMode = 'dynamic',               -- 'static' (all) or 'dynamic' (random selection)
    turretDynamicCount = 0,                    -- No turrets
    
    turrets = {},  -- No turrets
    
    -- ===================================================================
    --                    SENTRY DEFAULTS (10m engagement range)
    -- ===================================================================
    sentryDefaults = {
      aggroRange = 80.0,  -- Sentries only engage when player is within 80 meters
      leashDistance = 30.0,  -- Return to spawn if more than 30m away
    },
    
    -- ===================================================================
    --                    REINFORCEMENTS
    -- ===================================================================
    reinforcements = {
      enabled = false,
      triggerMode = 'timer',
      delaySeconds = 60,
      thresholdPercent = 50,
      spawnFrequency = 'once',
      count = 2,
      npcModels = { 's_m_m_army_01' },
      horseModels = { 'A_C_Horse_KentuckySaddle_Grey' },
    },

    reinforcementSpawnPoints = {
      vector3(250.0, 1550.0, 180.0),
      vector3(450.0, 1450.0, 180.0),
      vector3(300.0, 1400.0, 180.0),
      vector3(400.0, 1550.0, 180.0),
    },

    -- ===================================================================
    --                    WAVES
    -- ===================================================================
    wavesEnabled = false,
    waves = {},  -- No waves
    
    -- ===================================================================
    --                    LOOT (only specify what's different from defaults)
    -- ===================================================================
    loot = {
      chestModel = 'mp001_p_mp_strongbox01x_lrg',  -- Army strongbox model
      boxCount = { min = 2, max = 4 },      -- Fixed 7 boxes
      
      spawnPoints = {
        vector4(-3964.506, -2122.839, -5.863, 139.859),
        vector4(-3963.263, -2151.312, -6.791, 297.557),
        vector4(-3961.417, -2123.093, -5.033, 330.934),
        vector4(-3961.899, -2120.780, -5.033, 230.581),
      },
      
      items = {
        { name = 'intel_folder', chance = 70, quantity = 1 },
        { name = 'moneybag', chance = 60, quantity = {min = 1, max = 3}, moneyReward = { min = 20, max = 80 } },
        { name = 'goldbar', chance = 30 },
        { name = 'crim_raid_fort_mercer_schedule', chance = 100, quantity = 1 },
      },
      
      itemSelection = {
        mode = 'independent',
        maxItems = 3
      },
      
      -- Using global random minigame setting (padlock or lockpick)
      -- minigame config inherited from Config.Loot.minigame
    },
    
  },
  --#endregion
  -- ===================================================================
  --                        NARO Mining camp Minor Raid
  --#region Checklist
  --   [ ] Basic Info
  --   [ ] Start Location
  --   [ ] Start NPC Scenarios
  --   [ ] Start NPC Dialogue
  --   [ ] Start Requirements
  --   [ ] Law Alerts
  --   [X] Raid Boundary
  --   [X] Entity Limits 
  --   [ ] Alarm System (disabled for now)
  --   [ ] Timing
  --   [ ] NPC Models
  --   [ ] Special Rules
  --   [X] Sentry Positions (none for minor raid)
  --   [X] Patrol Positions (none for minor raid)
  --   [ ] Turrets (none for minor raid)
  --   [ ] Reinforcements (none for minor raid)
  --   [ ] Waves (none for minor raid)
  --   [ ] Loot
  --#endregion
  -- ===================================================================
  --#region NARO Mining camp Minor Raid
  naro_mining_camp_minor = {
    
    -- BASIC INFO
    name = "Mining camp Minor Raid",
    enabled = true,
    jurisdiction = "NARO",
    
    -- START LOCATION
    startPoint = vector4(-2768.949, -3052.612, 11.180, 238.362),
    startNPCModel = 'MP_G_M_M_UniBanditos_01',
    notifyRadius = 20.0,
    
    -- START NPC SCENARIOS
    scenario = "WORLD_HUMAN_STAND_IMPATIENT",
    idleScenarios = {
      "WORLD_HUMAN_STAND_WAITING",
      "WORLD_HUMAN_SMOKING",
      "WORLD_HUMAN_GUARD_LEAN_WALL"
    },
    scenarioCycleInterval = 1,
    
    -- START NPC DIALOGUE
    dialogue = {
      enabled = true,
      greetingDistance = 3.0,
      resetDistance = 50.0,
      
      animations = {
        talk = { type = "scenario", name = "WORLD_HUMAN_STAND_IMPATIENT" },
        give_map = { type = "anim", dict = "mech_inspection@letter@base", anim = "grab", flag = 0, duration = 3000 },
        player_take_map = { type = "anim", dict = "mech_inspection@letter@base", anim = "hold", flag = 49, duration = -1, prop = "s_mollyloveletter" },
      },
      
      lines = {
        greeting = "Gday! You look like you can handle yourself in a fight. I might have a job for you, but it's a bit risky.",
        steps = {
          { label = "Are you talking to me?", text = "Yeah, I'm talking to you. I need someone who can handle themselves in a fight.", anim = "talk" },
          { label = "How can I help?", text = "Del lobbo's have been seen recently robbing the local mining camp for dymanite, it seems they built quite the bomb", anim = "talk" },
          { label = "Right, you want me to steal the stolen dynamite?", text = "Thats exactly right, im sure we can put it to good use.", anim = "give_map", playerAnim = "player_take_map", action = "start" }
        },
        missingItem = "You're not prepared. Bring me a %s and then we can talk."
      }
    },
    
    -- START REQUIREMENTS
    requiredItem = nil,
    consumeRequiredItem = false,
    
    -- LAW ALERTS
    lawAlerts = {
      enabled = true,
      timingMode = 'random',
      triggerPoint = 'sentries_cleared',
      randomDelay = { min = 30, max = 180 },
      jobs = {'NARO'}
    },
    
    -- RAID BOUNDARY
    boundary = {
      center = vector3(-2720.007, -2376.712, 45.100),
      radius = 250.0
    },
    
    -- ===================================================================
    --                    ENTITY LIMITS
    -- ===================================================================
    maxEntities = 22,  -- Override global Config.MaxRaidEntities for this raid (optional)
    
    -- ===================================================================
    --                    ALARM SYSTEM (DISABLED - TO BE IMPLEMENTED IN THE FUTURE)
    -- ===================================================================
    --[[ ALARM SYSTEM COMMENTED OUT - Audio not working yet
    alarm = {
      enabled = true,
      name = "FORT_ALARM",  -- Identifier for this alarm (not actual sound name - uses bell_school sound)
      location = vector3(348.829, 1487.227, 179.460),  -- Where alarm sound originates (fort center)
      triggerOn = 'combat_detected',  -- When to trigger: 'raid_start', 'combat_detected', 'sentries_cleared'
      disableObject = {
        enabled = true,
        model = 's_dov_lab_panel02x',  -- Electrical panel model
        coords = vector4(337.74310302734375, 1496.3299560546875, 180.15704345703125, -148.58297729492188),  -- Inside main building
        freeze = true
      },
      disableMinigame = {
        enabled = true,
        type = 'wirecutting',
        difficulty = 'medium'  -- easy, medium, hard
      }
    },
    ]]--
    
    -- ===================================================================
    --                    TIMING
    -- ===================================================================
    waveDelay = nil,  -- No waves
    
    -- ACCESS TIMER FOR LOOT
    accessTimer = 0.5,  -- 0.5 minutes wait after clearing sentries/patrols
    
    -- NPC MODELS
    npcModels = { 's_m_m_army_01' },
    leaderModel = 's_m_m_army_01',
    
    -- SPECIAL RULES
    friendlyJobs = {"NARO", "USMO", "WESO", "LSO", "NHSO", "USDO"},  -- Law jobs cannot start this raid
    minLawCount = nil,  -- Minimum law officers required to start raid (nil = no requirement)
    
    -- ===================================================================
    --                    PATROL BEHAVIOR
    -- ===================================================================
    patrolRadius = 40.0,
    patrolPoints = 4,
    patrolWaitTime = 5000,
    
    -- ===================================================================
    --                    WEAPON POOLS
    -- ===================================================================
    weaponPools = {
      snipers = { 'WEAPON_RIFLE_BOLTACTION', 'WEAPON_SNIPERRIFLE_ROLLINGBLOCK' },
      repeaters = { 'WEAPON_REPEATER_WINCHESTER', 'WEAPON_REPEATER_CARBINE' },
      revolvers = { 'WEAPON_REVOLVER_CATTLEMAN' },
      rifles = { 'WEAPON_RIFLE_SPRINGFIELD' },
      shotguns = { 'WEAPON_SHOTGUN_DOUBLEBARREL' }
    },
    
    -- ===================================================================
    --                    AI BEHAVIOR
    -- ===================================================================
    AI = {
      difficulty = {
        playersDivisor = 2.0,  -- Difficulty scales with players
      },
      accuracy = {
        base = 25,
        min = 15,
        max = 40
      },
      health = {
        base = 150,
        multiplier = 1.0
      },
      combat = {
        coverUsage = 30,
        flankingChance = 20,
        aggressiveness = 50
      }
    },
    
    -- ===================================================================
    --                    SENTRY POSITIONS
    -- ===================================================================
    sentryPositions = {
      vector4(-2730.596, -2386.897, 44.843, 79.806),
      vector4(-2728.187, -2373.721, 45.163, 80.074),
      vector4(-2721.094, -2358.189, 46.080, 70.789),
      vector4(-2716.140, -2330.926, 58.485, 181.650),
      vector4(-2698.012, -2336.692, 59.522, 191.798),
      vector4(-2681.937, -2358.976, 55.986, 97.318),
      vector4(-2685.566, -2386.316, 52.439, 98.982),
      vector4(-2711.682, -2403.137, 48.938, 348.464),
      vector4(-2762.570, -2394.933, 51.097, 318.487),
      vector4(-2769.162, -2401.180, 52.637, 137.150),
      vector4(-2761.487, -2401.751, 51.334, 315.980),
      vector4(-2789.050, -2411.875, 53.530, 83.791),
      vector4(-2791.539, -2414.833, 53.512, 84.180),
      vector4(-2785.044, -2411.800, 54.034, 67.063),
      vector4(-2822.958, -2387.994, 57.180, 294.614),
      vector4(-2820.697, -2391.888, 56.958, 285.480),
      vector4(-2822.483, -2397.070, 57.468, 186.936),
      vector4(-2801.405, -2349.634, 58.829, 286.957),
      vector4(-2792.406, -2358.173, 58.193, 207.009),
    },
    
    -- ===================================================================
    --                    PATROL POSITIONS
    -- ===================================================================
    -- Roaming guards that move around
    patrols = {
      vector4(-2787.476, -2372.753, 43.135, 88.600),
      vector4(-2792.042, -2368.308, 43.029, 177.446),
      vector4(-2793.203, -2372.190, 42.664, 357.571),
      vector4(-2802.557, -2395.530, 41.765, 179.859),
      vector4(-2809.180, -2388.960, 42.803, 72.081),
      vector4(-2820.806, -2370.028, 42.073, 78.818),
      vector4(-2823.965, -2362.163, 41.730, 77.769),
    },
    
    -- ===================================================================
    --                    TURRETS
    -- ===================================================================
    -- NOTE: Turrets do NOT count towards Config.MaxRaidEntities limit
    turretSpawnMode = 'dynamic',               -- 'static' (all) or 'dynamic' (random selection)
    turretDynamicCount = 0,                    -- No turrets
    
    turrets = {},  -- No turrets
    
    -- ===================================================================
    --                    SENTRY DEFAULTS (10m engagement range)
    -- ===================================================================
    sentryDefaults = {
      aggroRange = 80.0,  -- Sentries only engage when player is within 80 meters
      leashDistance = 30.0,  -- Return to spawn if more than 30m away
    },
    
    -- ===================================================================
    --                    REINFORCEMENTS
    -- ===================================================================
    reinforcements = {
      enabled = false,
      triggerMode = 'timer',
      delaySeconds = 60,
      thresholdPercent = 50,
      spawnFrequency = 'once',
      count = 2,
      npcModels = { 's_m_m_army_01' },
      horseModels = { 'A_C_Horse_KentuckySaddle_Grey' },
    },

    reinforcementSpawnPoints = {
      vector3(250.0, 1550.0, 180.0),
      vector3(450.0, 1450.0, 180.0),
      vector3(300.0, 1400.0, 180.0),
      vector3(400.0, 1550.0, 180.0),
    },

    -- ===================================================================
    --                    WAVES
    -- ===================================================================
    wavesEnabled = false,
    waves = {},  -- No waves
    
    -- ===================================================================
    --                    LOOT (only specify what's different from defaults)
    -- ===================================================================
    loot = {
      chestModel = 'mp001_p_mp_strongbox01x_lrg',  -- Army strongbox model
      boxCount = { min = 2, max = 4 },      -- Fixed 7 boxes
      
      spawnPoints = {
        vector4(-2720.918, -2390.094, 43.895, 104.305),
        vector4(-2713.730, -2368.125, 45.149, 346.227),
        vector4(-2710.495, -2367.408, 44.991, 36.440),
        vector4(-2704.279, -2358.992, 45.286, 112.557),
        vector4(-2704.373, -2363.046, 45.197, 42.314),
      },
      
      items = {
        { name = 'intel_folder', chance = 70, quantity = 1 },
        { name = 'moneybag', chance = 60, quantity = {min = 1, max = 3}, moneyReward = { min = 20, max = 80 } },
        { name = 'goldbar', chance = 30 },
        { name = 'crim_raid_explosives_high', chance = 100, quantity = 1 },
      },
      
      itemSelection = {
        mode = 'independent',
        maxItems = 3
      },
      
      -- Using global random minigame setting (padlock or lockpick)
      -- minigame config inherited from Config.Loot.minigame
    },
    
  },
  --#endregion
  -- ===================================================================
  --                       WESO Whinyard Strait Minor Raid
  --#region Checklist
  --   [ ] Basic Info
  --   [X] Start Location
  --   [ ] Start NPC Scenarios
  --   [ ] Start NPC Dialogue
  --   [ ] Start Requirements
  --   [ ] Law Alerts
  --   [X] Raid Boundary
  --   [X] Entity Limits 
  --   [X] Alarm System (disabled for now)
  --   [ ] Timing
  --   [ ] NPC Models
  --   [ ] Special Rules
  --   [X] Sentry Positions (none for minor raid)
  --   [X] Patrol Positions (none for minor raid)
  --   [X] Turrets (none for minor raid)
  --   [ ] Reinforcements (none for minor raid)
  --   [ ] Waves (none for minor raid)
  --   [X] Loot
  --#endregion
  -- ===================================================================
  --#region Whinyard Strait Minor Raid
  whinyard_strait_minor = {
    
    -- BASIC INFO
    name = "Whinyard Strait Minor Raid",
    enabled = true,
    jurisdiction = "WESO",
    
    -- START LOCATION
    startPoint = vector4(-155.833, 1487.463, 116.221, 204.992),
    startNPCModel = 'cs_strawberryoutlaw_01',
    notifyRadius = 20.0,
    
    -- START NPC SCENARIOS
    scenario = "WORLD_HUMAN_STAND_IMPATIENT",
    idleScenarios = {
      "WORLD_HUMAN_STAND_WAITING",
      "WORLD_HUMAN_SMOKING",
      "WORLD_HUMAN_GUARD_LEAN_WALL"
    },
    scenarioCycleInterval = 1,
    
    -- START NPC DIALOGUE
    dialogue = {
      enabled = true,
      greetingDistance = 3.0,
      resetDistance = 50.0,
      
      animations = {
        talk = { type = "scenario", name = "WORLD_HUMAN_STAND_IMPATIENT" },
        give_map = { type = "anim", dict = "mech_inspection@letter@base", anim = "grab", flag = 0, duration = 3000 },
        player_take_map = { type = "anim", dict = "mech_inspection@letter@base", anim = "hold", flag = 49, duration = -1, prop = "s_mollyloveletter" },
      },
      
      lines = {
        greeting = "Those damn weirdos have been ambushing locals again.",
        steps = {
          { label = "Who?", text = "THE MINERS or i dont know who they are really, but what i know is where they are camped out of this time.", anim = "talk" },
          { label = "okay?", text = "okay? well anyone with a brain bigger than his nose would know that camp probably has some good loot for the taking, and rid us of them.", anim = "talk" },
          { label = "You want me to rob the robbers?", text = "Yeah call it justice or whatever you want but you would definitely make a dime and make the area safer, here you go, do as you wish with them.", anim = "give_map", playerAnim = "player_take_map", action = "start" }
        },
        missingItem = "You're not prepared. Bring me a %s and then we can talk."
      }
    },
    
    -- START REQUIREMENTS
    requiredItem = nil,
    consumeRequiredItem = false,
    
    -- LAW ALERTS
    lawAlerts = {
      enabled = true,
      timingMode = 'random',
      triggerPoint = 'sentries_cleared',
      randomDelay = { min = 30, max = 180 },
      jobs = {'WESO'}
    },
    
    -- RAID BOUNDARY
    boundary = {
      center = vector3(-412.257, 1731.927, 216.306),
      radius = 250.0
    },
    
    -- ===================================================================
    --                    ENTITY LIMITS
    -- ===================================================================
    maxEntities = 22,  -- Override global Config.MaxRaidEntities for this raid (optional)
    
    -- ===================================================================
    --                    ALARM SYSTEM (DISABLED - TO BE IMPLEMENTED IN THE FUTURE)
    -- ===================================================================
    --[[ ALARM SYSTEM COMMENTED OUT - Audio not working yet
    alarm = {
      enabled = true,
      name = "FORT_ALARM",  -- Identifier for this alarm (not actual sound name - uses bell_school sound)
      location = vector3(348.829, 1487.227, 179.460),  -- Where alarm sound originates (fort center)
      triggerOn = 'combat_detected',  -- When to trigger: 'raid_start', 'combat_detected', 'sentries_cleared'
      disableObject = {
        enabled = true,
        model = 's_dov_lab_panel02x',  -- Electrical panel model
        coords = vector4(337.74310302734375, 1496.3299560546875, 180.15704345703125, -148.58297729492188),  -- Inside main building
        freeze = true
      },
      disableMinigame = {
        enabled = true,
        type = 'wirecutting',
        difficulty = 'medium'  -- easy, medium, hard
      }
    },
    ]]--
    
    -- ===================================================================
    --                    TIMING
    -- ===================================================================
    waveDelay = nil,  -- No waves
    
    -- ACCESS TIMER FOR LOOT
    accessTimer = 0.5,  -- 0.5 minutes wait after clearing sentries/patrols
    
    -- NPC MODELS
    npcModels = { 'u_m_m_odriscollbrawler_01', 'u_m_m_bht_odriscolldrunk', 'u_m_m_bht_odriscollsleeping' },
    leaderModel = 'u_m_m_odriscollbrawler_01',
    
    -- SPECIAL RULES
    friendlyJobs = {},  -- Law jobs cannot start this raid
    minLawCount = nil,  -- Minimum law officers required to start raid (nil = no requirement)
    
    -- ===================================================================
    --                    PATROL BEHAVIOR
    -- ===================================================================
    patrolRadius = 40.0,
    patrolPoints = 4,
    patrolWaitTime = 5000,
    
    -- ===================================================================
    --                    WEAPON POOLS
    -- ===================================================================
    weaponPools = {
      snipers = { 'WEAPON_RIFLE_BOLTACTION', 'WEAPON_SNIPERRIFLE_ROLLINGBLOCK' },
      repeaters = { 'WEAPON_REPEATER_WINCHESTER', 'WEAPON_REPEATER_CARBINE' },
      revolvers = { 'WEAPON_REVOLVER_CATTLEMAN' },
      rifles = { 'WEAPON_RIFLE_SPRINGFIELD' },
      shotguns = { 'WEAPON_SHOTGUN_DOUBLEBARREL' }
    },
    
    -- ===================================================================
    --                    AI BEHAVIOR
    -- ===================================================================
    AI = {
      difficulty = {
        playersDivisor = 2.0,  -- Difficulty scales with players
      },
      accuracy = {
        base = 25,
        min = 15,
        max = 40
      },
      health = {
        base = 150,
        multiplier = 1.0
      },
      combat = {
        coverUsage = 30,
        flankingChance = 20,
        aggressiveness = 50
      }
    },
    
    -- ===================================================================
    --                    SENTRY POSITIONS
    -- ===================================================================
    sentryPositions = {
      vector4(-400.397, 1709.421, 215.651, 208.282),
      vector4(-403.696, 1707.823, 215.720, 201.234),
      vector4(-418.889, 1718.647, 216.303, 209.069),
      vector4(-422.816, 1726.023, 216.316, 302.340),
      vector4(-428.812, 1742.040, 216.491, 322.577),
      vector4(-406.971, 1753.893, 216.392, 180.856),
      vector4(-398.089, 1754.757, 216.412, 180.023),
      vector4(-386.400, 1731.831, 216.442, 91.878),
      vector4(-393.918, 1724.325, 220.810, 243.983),
      vector4(-399.459, 1722.114, 220.416, 134.623),
      vector4(-403.772, 1734.217, 220.482, 63.296),
      vector4(-397.814, 1737.949, 220.131, 317.988),
      vector4(-416.325, 1744.502, 216.312, 197.417),
      vector4(-405.227, 1748.666, 216.295, 197.850),
    },
    
    -- ===================================================================
    --                    PATROL POSITIONS
    -- ===================================================================
    -- Roaming guards that move around
    patrols = {
      vector4(-419.881, 1695.940, 215.742, 158.973),
      vector4(-428.366, 1713.054, 217.736, 248.901),
      vector4(-432.079, 1731.293, 217.270, 256.993),
      vector4(-428.800, 1763.845, 217.206, 335.721),
      vector4(-405.910, 1772.638, 217.023, 256.448),
      vector4(-371.775, 1764.399, 217.381, 240.263),
      vector4(-364.731, 1745.262, 216.572, 234.884),
    },
    
    -- ===================================================================
    --                    TURRETS
    -- ===================================================================
    -- NOTE: Turrets do NOT count towards Config.MaxRaidEntities limit
    turretSpawnMode = 'dynamic',               -- 'static' (all) or 'dynamic' (random selection)
    turretDynamicCount = 0,                    -- No turrets
    
    turrets = {},  -- No turrets
    
    -- ===================================================================
    --                    SENTRY DEFAULTS (10m engagement range)
    -- ===================================================================
    sentryDefaults = {
      aggroRange = 80.0,  -- Sentries only engage when player is within 80 meters
      leashDistance = 30.0,  -- Return to spawn if more than 30m away
    },
    
    -- ===================================================================
    --                    REINFORCEMENTS
    -- ===================================================================
    reinforcements = {
      enabled = false,
      triggerMode = 'timer',
      delaySeconds = 60,
      thresholdPercent = 50,
      spawnFrequency = 'once',
      count = 2,
      npcModels = { 's_m_m_army_01' },
      horseModels = { 'A_C_Horse_KentuckySaddle_Grey' },
    },

    reinforcementSpawnPoints = {
      vector3(250.0, 1550.0, 180.0),
      vector3(450.0, 1450.0, 180.0),
      vector3(300.0, 1400.0, 180.0),
      vector3(400.0, 1550.0, 180.0),
    },

    -- ===================================================================
    --                    WAVES
    -- ===================================================================
    wavesEnabled = false,
    waves = {},  -- No waves
    
    -- ===================================================================
    --                    LOOT (only specify what's different from defaults)
    -- ===================================================================
    loot = {
      chestModel = 'mp001_p_mp_strongbox01x_lrg',  -- Army strongbox model
      boxCount = { min = 2, max = 4 },      -- Fixed 7 boxes
      
      spawnPoints = {
        vector4(-412.948, 1717.433, 215.301, 2.298),
        vector4(-420.255, 1733.775, 215.366, 219.752),
        vector4(-410.839, 1747.710, 215.294, 195.966),
        vector4(-426.392, 1738.887, 215.468, 30.342),
      },
      
      items = {
        { name = 'intel_folder', chance = 70, quantity = 1 },
        { name = 'moneybag', chance = 60, quantity = {min = 1, max = 3}, moneyReward = { min = 20, max = 80 } },
        { name = 'goldbar', chance = 30 },
        { name = 'crim_raid_doolin_will', chance = 100, quantity = 1 },
      },
      
      itemSelection = {
        mode = 'independent',
        maxItems = 3
      },
      
      -- Using global random minigame setting (padlock or lockpick)
      -- minigame config inherited from Config.Loot.minigame
    },
    
  },
  --#endregion

  -- ===================================================================
  --                        LSO Factory District Minor Raid
  --#region Checklist
  --   [ ] Basic Info
  --   [X] Start Location
  --   [ ] Start NPC Scenarios
  --   [ ] Start NPC Dialogue
  --   [ ] Start Requirements
  --   [X] Law Alerts
  --   [X] Raid Boundary
  --   [ ] Entity Limits 
  --   [X] Alarm System (disabled for now)
  --   [ ] Timing
  --   [ ] NPC Models
  --   [ ] Special Rules
  --   [X] Sentry Positions (none for minor raid)
  --   [X] Patrol Positions (none for minor raid)
  --   [ ] Turrets (none for minor raid)
  --   [ ] Reinforcements (none for minor raid)
  --   [ ] Waves (none for minor raid)
  --   [X] Loot -- still needs unique item
  --#endregion
  -- ===================================================================
  --#region LSO Factory District Minor Raid
  factory_district_minor = {
    
    -- BASIC INFO
    name = "Factory District Minor Raid",
    enabled = true,
    jurisdiction = "LSO",
    
    -- START LOCATION
    startPoint = vector4(2793.657, -1139.266, 47.385, 111.616),
    startNPCModel = 'rcsp_mrmayor_males_01',
    notifyRadius = 20.0,
    
    -- START NPC SCENARIOS
    scenario = "WORLD_HUMAN_STAND_IMPATIENT",
    idleScenarios = {
      "WORLD_HUMAN_STAND_WAITING",
      "WORLD_HUMAN_SMOKING",
      "WORLD_HUMAN_GUARD_LEAN_WALL"
    },
    scenarioCycleInterval = 1,
    
    -- START NPC DIALOGUE
    dialogue = {
      enabled = true,
      greetingDistance = 3.0,
      resetDistance = 50.0,
      
      animations = {
        talk = { type = "scenario", name = "WORLD_HUMAN_STAND_IMPATIENT" },
        give_map = { type = "anim", dict = "mech_inspection@letter@base", anim = "grab", flag = 0, duration = 3000 },
        player_take_map = { type = "anim", dict = "mech_inspection@letter@base", anim = "hold", flag = 49, duration = -1, prop = "s_mollyloveletter" },
      },
      
      lines = {
        greeting = "Those damn Lemoyne Raiders have been a thorn in my side.",
        steps = {
          { label = "What's the problem?", text = "They've been hitting the factory hard - stealing weapon parts, materials, everything we need for production. They got inside men working with 'em, making it real easy to move goods out.", anim = "talk" },
          { label = "Why not go to the law?", text = "The law? Ha! Half of 'em are in on it, or too scared to do anything about it. The Raiders have muscle, they got organization. Nobody's willing to stand up to 'em except someone like you.", anim = "talk" },
          { label = "I'll hit their camp.", text = "Now that's what I like to hear. They've been stashing everything at an old warehouse they're using as a base. Hit 'em where it hurts, take back what's ours. Here's where they're holed up - show 'em Saint Denis ain't their playground.", anim = "give_map", playerAnim = "player_take_map", action = "start" }
        },
        missingItem = "You're not ready to take on the Raiders. Come back when you got yourself a %s."
      }
    },
    
    -- START REQUIREMENTS
    requiredItem = nil,
    consumeRequiredItem = false,
    
    -- LAW ALERTS
    lawAlerts = {
      enabled = true,
      timingMode = 'random',
      triggerPoint = 'sentries_cleared',
      randomDelay = { min = 30, max = 180 },
      jobs = {'LSO'}
    },
    
    -- RAID BOUNDARY
    boundary = {
      center = vector3(2330.876, -1462.835, 45.992),
      radius = 250.0
    },
    
    -- ===================================================================
    --                    ENTITY LIMITS
    -- ===================================================================
    maxEntities = 22,  -- Override global Config.MaxRaidEntities for this raid (optional)
    
    -- ===================================================================
    --                    ALARM SYSTEM (DISABLED - TO BE IMPLEMENTED IN THE FUTURE)
    -- ===================================================================
    --[[ ALARM SYSTEM COMMENTED OUT - Audio not working yet
    alarm = {
      enabled = true,
      name = "FORT_ALARM",  -- Identifier for this alarm (not actual sound name - uses bell_school sound)
      location = vector3(348.829, 1487.227, 179.460),  -- Where alarm sound originates (fort center)
      triggerOn = 'combat_detected',  -- When to trigger: 'raid_start', 'combat_detected', 'sentries_cleared'
      disableObject = {
        enabled = true,
        model = 's_dov_lab_panel02x',  -- Electrical panel model
        coords = vector4(337.74310302734375, 1496.3299560546875, 180.15704345703125, -148.58297729492188),  -- Inside main building
        freeze = true
      },
      disableMinigame = {
        enabled = true,
        type = 'wirecutting',
        difficulty = 'medium'  -- easy, medium, hard
      }
    },
    ]]--
    
    -- ===================================================================
    --                    TIMING
    -- ===================================================================
    waveDelay = nil,  -- No waves
    
    -- ACCESS TIMER FOR LOOT
    accessTimer = 0.5,  -- 0.5 minutes wait after clearing sentries/patrols
    
    -- NPC MODELS
    npcModels = { 'g_m_y_uniexconfeds_01' },
    leaderModel = 'g_m_y_uniexconfeds_01',
    
    -- SPECIAL RULES
    friendlyJobs = {"NARO", "USMO", "WESO", "LSO", "NHSO", "USDO"},  -- Law jobs cannot start this raid
    minLawCount = nil,  -- Minimum law officers required to start raid (nil = no requirement)
    
    -- ===================================================================
    --                    PATROL BEHAVIOR
    -- ===================================================================
    patrolRadius = 40.0,
    patrolPoints = 4,
    patrolWaitTime = 5000,
    
    -- ===================================================================
    --                    WEAPON POOLS
    -- ===================================================================
    weaponPools = {
      snipers = { 'WEAPON_RIFLE_BOLTACTION', 'WEAPON_SNIPERRIFLE_ROLLINGBLOCK' },
      repeaters = { 'WEAPON_REPEATER_WINCHESTER', 'WEAPON_REPEATER_CARBINE' },
      revolvers = { 'WEAPON_REVOLVER_CATTLEMAN' },
      rifles = { 'WEAPON_RIFLE_SPRINGFIELD' },
      shotguns = { 'WEAPON_SHOTGUN_DOUBLEBARREL' }
    },
    
    -- ===================================================================
    --                    AI BEHAVIOR
    -- ===================================================================
    AI = {
      difficulty = {
        playersDivisor = 2.0,  -- Difficulty scales with players
      },
      accuracy = {
        base = 25,
        min = 15,
        max = 40
      },
      health = {
        base = 150,
        multiplier = 1.0
      },
      combat = {
        coverUsage = 30,
        flankingChance = 20,
        aggressiveness = 50
      }
    },
    
    -- ===================================================================
    --                    SENTRY POSITIONS
    -- ===================================================================
    sentryPositions = {
      vector4(2347.478, -1446.516, 45.978, 84.457),
      vector4(2346.591, -1433.354, 46.070, 1.026),
      vector4(2341.898, -1433.922, 46.062, 356.671),
      vector4(2334.986, -1433.942, 45.965, 358.515),
      vector4(2329.084, -1433.943, 45.869, 358.426),
      vector4(2322.938, -1444.644, 47.034, 267.416),
      vector4(2326.718, -1469.165, 52.129, 177.969),
      vector4(2332.572, -1469.166, 52.129, 167.779),
      vector4(2344.727, -1469.154, 52.129, 180.602),
      vector4(2359.099, -1465.698, 52.175, 13.239),
      vector4(2354.983, -1461.500, 46.184, 271.064),
      vector4(2354.476, -1455.964, 46.193, 273.710),
      vector4(2343.982, -1483.521, 46.985, 358.894),
      vector4(2325.322, -1488.708, 46.079, 325.246),
      vector4(2323.442, -1470.574, 45.997, 180.893),
      
    },
    
    -- ===================================================================
    --                    PATROL POSITIONS
    -- ===================================================================
    -- Roaming guards that move around
    patrols = {
      vector4(2340.929, -1418.309, 45.583, 106.016),
      vector4(2348.344, -1414.175, 45.465, 107.228),
      vector4(2340.683, -1413.092, 45.585, 189.268),
      vector4(2319.882, -1412.815, 45.583, 289.941),
      vector4(2320.923, -1408.161, 45.583, 296.558),
      vector4(2322.610, -1411.616, 45.583, 205.306),
      vector4(2290.192, -1414.731, 45.583, 308.176),
    },
    
    -- ===================================================================
    --                    TURRETS
    -- ===================================================================
    -- NOTE: Turrets do NOT count towards Config.MaxRaidEntities limit
    turretSpawnMode = 'dynamic',               -- 'static' (all) or 'dynamic' (random selection)
    turretDynamicCount = 0,                    -- No turrets
    
    turrets = {},  -- No turrets
    
    -- ===================================================================
    --                    SENTRY DEFAULTS (10m engagement range)
    -- ===================================================================
    sentryDefaults = {
      aggroRange = 80.0,  -- Sentries only engage when player is within 80 meters
      leashDistance = 30.0,  -- Return to spawn if more than 30m away
    },
    
    -- ===================================================================
    --                    REINFORCEMENTS
    -- ===================================================================
    reinforcements = {
      enabled = false,
      triggerMode = 'timer',
      delaySeconds = 60,
      thresholdPercent = 50,
      spawnFrequency = 'once',
      count = 2,
      npcModels = { 's_m_m_army_01' },
      horseModels = { 'A_C_Horse_KentuckySaddle_Grey' },
    },

    reinforcementSpawnPoints = {
      vector3(250.0, 1550.0, 180.0),
      vector3(450.0, 1450.0, 180.0),
      vector3(300.0, 1400.0, 180.0),
      vector3(400.0, 1550.0, 180.0),
    },

    -- ===================================================================
    --                    WAVES
    -- ===================================================================
    wavesEnabled = false,
    waves = {},  -- No waves
    
    -- ===================================================================
    --                    LOOT (only specify what's different from defaults)
    -- ===================================================================
    loot = {
      chestModel = 'mp001_p_mp_strongbox01x_lrg',  -- Army strongbox model
      boxCount = { min = 2, max = 4 },      -- Fixed 7 boxes
      
      spawnPoints = {
        vector4(2350.050, -1487.489, 45.978, 89.119),
        vector4(2329.324, -1464.399, 44.976, 267.345),
        vector4(2317.927, -1468.601, 51.084, 354.346),
        vector4(2299.540, -1468.619, 51.084, 359.974),
      },
      
      items = {
        { name = 'intel_folder', chance = 70, quantity = 1 },
        { name = 'moneybag', chance = 60, quantity = {min = 1, max = 3}, moneyReward = { min = 20, max = 80 } },
        { name = 'goldbar', chance = 30 },
        { name = 'crim_raid_shipping_ledger', chance = 100, quantity = 1 },
      },
      
      itemSelection = {
        mode = 'independent',
        maxItems = 3
      },
      
      -- Using global random minigame setting (padlock or lockpick)
      -- minigame config inherited from Config.Loot.minigame
    },
    
  },
  --#endregion
  
  -- ===================================================================
  --                        LSO Braithwaite Manor Minor Raid
  --#region Checklist
  --   [ ] Basic Info
  --   [X] Start Location
  --   [ ] Start NPC Scenarios
  --   [X] Start NPC Dialogue
  --   [ ] Start Requirements
  --   [X] Law Alerts
  --   [X] Raid Boundary
  --   [ ] Entity Limits 
  --   [X] Alarm System (disabled for now)
  --   [ ] Timing
  --   [ ] NPC Models
  --   [ ] Special Rules
  --   [X] Sentry Positions (none for minor raid)
  --   [X] Patrol Positions (none for minor raid)
  --   [X] Turrets (none for minor raid)
  --   [X] Reinforcements (none for minor raid)
  --   [X] Waves (none for minor raid)
  --   [X] Loot
  --#endregion
  -- ===================================================================
  --#region LSO Braithwaite Manor Minor Raid
  braithwaite_manor_minor = {
    
    -- BASIC INFO
    name = "Braithwaite Manor Raid",
    enabled = true,
    jurisdiction = "LSO",
    
    -- START LOCATION
    startPoint = vector4(689.064, -1256.727, 44.616, 60.482),
    startNPCModel = 'msp_mudtown3b_males_01',
    notifyRadius = 20.0,
    
    -- START NPC SCENARIOS
    scenario = "WORLD_HUMAN_STAND_IMPATIENT",
    idleScenarios = {
      "WORLD_HUMAN_STAND_WAITING",
      "WORLD_HUMAN_SMOKING",
      "WORLD_HUMAN_GUARD_LEAN_WALL"
    },
    scenarioCycleInterval = 1,
    
    -- START NPC DIALOGUE
    dialogue = {
      enabled = true,
      greetingDistance = 3.0,
      resetDistance = 50.0,
      
      animations = {
        talk = { type = "scenario", name = "WORLD_HUMAN_STAND_IMPATIENT" },
        give_map = { type = "anim", dict = "mech_inspection@letter@base", anim = "grab", flag = 0, duration = 3000 },
        player_take_map = { type = "anim", dict = "mech_inspection@letter@base", anim = "hold", flag = 49, duration = -1, prop = "s_mollyloveletter" },
      },
      
      lines = {
        greeting = "The Lemoyne Raiders have taken over this place. It's a damn mess.",
        steps = {
          { label = "What happened here?", text = "Those Raider fools marched in here like they own the place. Started ransacking the manor, taking supplies, weapons, anything valuable. The Braithwaites couldn't do nothing about it.", anim = "talk" },
          { label = "Why are you telling me this?", text = "Someone needs to drive them out. I ain't got the stomach for it, but you... you look like you got some fight in you. The Lemoyne Raiders have dug in deep here, but they're vulnerable.", anim = "talk" },
          { label = "I'll take them on.", text = "That's what I wanted to hear. They got their camp set up all over the manor grounds. Hit 'em hard and make 'em pay for what they done to this place. Here's the layout of where they're positioned.", anim = "give_map", playerAnim = "player_take_map", action = "start" }
        },
        missingItem = "You're not ready for this fight. Come back when you got yourself a %s."
      }
    },
    
    -- START REQUIREMENTS
    requiredItem = {"crim_raid_braithwaite_key", "crim_raid_burned_letter","crim_raid_shipping_ledger"},
    consumeRequiredItem = false,
    
    -- LAW ALERTS
    lawAlerts = {
      enabled = true,
      timingMode = 'random',
      triggerPoint = 'sentries_cleared',
      randomDelay = { min = 30, max = 180 },
      jobs = {'LSO', 'NHSO'}
    },
    
    -- RAID BOUNDARY
    boundary = {
      center = vector3(1010.953, -1770.203, 47.632),
      radius = 250.0
    },
    
    -- ===================================================================
    --                    ENTITY LIMITS
    -- ===================================================================
    maxEntities = 22,  -- Override global Config.MaxRaidEntities for this raid (optional)
    
    -- ===================================================================
    --                    ALARM SYSTEM (DISABLED - TO BE IMPLEMENTED IN THE FUTURE)
    -- ===================================================================
    --[[ ALARM SYSTEM COMMENTED OUT - Audio not working yet
    alarm = {
      enabled = true,
      name = "FORT_ALARM",  -- Identifier for this alarm (not actual sound name - uses bell_school sound)
      location = vector3(348.829, 1487.227, 179.460),  -- Where alarm sound originates (fort center)
      triggerOn = 'combat_detected',  -- When to trigger: 'raid_start', 'combat_detected', 'sentries_cleared'
      disableObject = {
        enabled = true,
        model = 's_dov_lab_panel02x',  -- Electrical panel model
        coords = vector4(337.74310302734375, 1496.3299560546875, 180.15704345703125, -148.58297729492188),  -- Inside main building
        freeze = true
      },
      disableMinigame = {
        enabled = true,
        type = 'wirecutting',
        difficulty = 'medium'  -- easy, medium, hard
      }
    },
    ]]--
    
    -- ===================================================================
    --                    TIMING
    -- ===================================================================
    waveDelay = nil,  -- No waves
    
    -- ACCESS TIMER FOR LOOT
    accessTimer = 0.5,  -- 0.5 minutes wait after clearing sentries/patrols
    
    -- NPC MODELS
    npcModels = { 'g_m_y_uniexconfeds_01' },
    leaderModel = 'g_m_y_uniexconfeds_01',
    
    -- SPECIAL RULES
    friendlyJobs = {"NARO", "USMO", "WESO", "LSO", "NHSO", "USDO"},  -- Law jobs cannot start this raid
    minLawCount = nil,  -- Minimum law officers required to start raid (nil = no requirement)
    
    -- ===================================================================
    --                    PATROL BEHAVIOR
    -- ===================================================================
    patrolRadius = 40.0,
    patrolPoints = 4,
    patrolWaitTime = 5000,
    
    -- ===================================================================
    --                    WEAPON POOLS
    -- ===================================================================
    weaponPools = {
      snipers = { 'WEAPON_RIFLE_BOLTACTION', 'WEAPON_SNIPERRIFLE_ROLLINGBLOCK' },
      repeaters = { 'WEAPON_REPEATER_WINCHESTER', 'WEAPON_REPEATER_CARBINE' },
      revolvers = { 'WEAPON_REVOLVER_CATTLEMAN' },
      rifles = { 'WEAPON_RIFLE_SPRINGFIELD' },
      shotguns = { 'WEAPON_SHOTGUN_DOUBLEBARREL' }
    },
    
    -- ===================================================================
    --                    AI BEHAVIOR
    -- ===================================================================
    AI = {
      difficulty = {
        playersDivisor = 2.0,  -- Difficulty scales with players
      },
      accuracy = {
        base = 25,
        min = 15,
        max = 40
      },
      health = {
        base = 150,
        multiplier = 1.0
      },
      combat = {
        coverUsage = 30,
        flankingChance = 20,
        aggressiveness = 50
      }
    },
    
    -- ===================================================================
    --                    SENTRY POSITIONS
    -- ===================================================================
    sentryPositions = {
      vector4(1012.505, -1768.546, 47.632, 28.124),
      vector4(1008.915, -1772.319, 52.044, 267.013),
      vector4(1012.239, -1766.467, 52.048, 94.749),
      vector4(1006.610, -1759.485, 52.100, 5.728),
      vector4(1001.470, -1759.471, 52.100, 6.414),
      vector4(997.007, -1771.422, 52.100, 90.937),
      vector4(1009.266, -1781.434, 52.100, 179.974),
      vector4(1021.965, -1781.182, 52.100, 180.170),
      vector4(1024.760, -1776.183, 52.100, 280.404),
      vector4(1025.347, -1765.488, 52.100, 280.221),
      vector4(1019.382, -1754.104, 46.660, 356.554),
      vector4(1005.041, -1753.731, 46.660, 0.377),
      vector4(990.836, -1763.115, 46.632, 90.288),
      vector4(991.266, -1782.442, 46.630, 90.301),
      vector4(1010.719, -1786.094, 46.660, 189.208),
      vector4(1022.919, -1787.387, 46.602, 190.779),
      vector4(1024.821, -1769.577, 47.655, 248.766),
      vector4(1025.333, -1759.945, 47.655, 287.702),
      vector4(998.257, -1760.214, 47.655, 88.779),
    },
    
    -- ===================================================================
    --                    PATROL POSITIONS
    -- ===================================================================
    -- Roaming guards that move around
    patrols = {
      vector4(996.897, -1702.122, 46.992, 287.216),
      vector4(994.767, -1697.045, 46.964, 17.845),
      vector4(988.976, -1700.438, 47.259, 108.704),
      vector4(1047.547, -1695.630, 46.957, 284.214),
      vector4(1052.871, -1697.442, 47.173, 278.679),
      vector4(1051.511, -1692.778, 47.090, 294.620),
      vector4(1060.240, -1805.812, 48.719, 157.785),
      vector4(1063.330, -1809.854, 49.128, 247.325),
      vector4(1065.917, -1806.316, 49.216, 336.229),
    },
    
    -- ===================================================================
    --                    TURRETS
    -- ===================================================================
    -- NOTE: Turrets do NOT count towards Config.MaxRaidEntities limit
    turretSpawnMode = 'dynamic',               -- 'static' (all) or 'dynamic' (random selection)
    turretDynamicCount = 0,                    -- No turrets
    
    turrets = {},  -- No turrets
    
    -- ===================================================================
    --                    SENTRY DEFAULTS (10m engagement range)
    -- ===================================================================
    sentryDefaults = {
      aggroRange = 80.0,  -- Sentries only engage when player is within 80 meters
      leashDistance = 30.0,  -- Return to spawn if more than 30m away
    },
    
    -- ===================================================================
    --                    REINFORCEMENTS
    -- ===================================================================
    reinforcements = {
      enabled = false,
      triggerMode = 'timer',
      delaySeconds = 60,
      thresholdPercent = 50,
      spawnFrequency = 'once',
      count = 2,
      npcModels = { 's_m_m_army_01' },
      horseModels = { 'A_C_Horse_KentuckySaddle_Grey' },
    },

    reinforcementSpawnPoints = {
      vector3(250.0, 1550.0, 180.0),
      vector3(450.0, 1450.0, 180.0),
      vector3(300.0, 1400.0, 180.0),
      vector3(400.0, 1550.0, 180.0),
    },

    -- ===================================================================
    --                    WAVES
    -- ===================================================================
    wavesEnabled = false,
    waves = {},  -- No waves
    
    -- ===================================================================
    --                    LOOT (only specify what's different from defaults)
    -- ===================================================================
    loot = {
      chestModel = 'mp001_p_mp_strongbox01x_lrg',  -- Army strongbox model
      boxCount = { min = 2, max = 4 },      -- Fixed 7 boxes
      
      spawnPoints = {
        vector4(1002.088, -1778.290, 51.044, 357.204),
        vector4(1034.247, -1776.680, 45.789, 39.592),
        vector4(988.757, -1779.172, 45.791, 244.271),
        vector4(1018.387, -1778.292, 46.631, 358.555),
      },
      
      items = {
        { name = 'intel_folder', chance = 70, quantity = 1 },
        { name = 'moneybag', chance = 60, quantity = {min = 1, max = 3}, moneyReward = { min = 20, max = 80 } },
        { name = 'goldbar', chance = 30 }
      },
      
      itemSelection = {
        mode = 'independent',
        maxItems = 3
      },
      
      -- Using global random minigame setting (padlock or lockpick)
      -- minigame config inherited from Config.Loot.minigame
    },
    
  },
  --#endregion
  
  -- ===================================================================
  --                        LSO Docks Manor Minor Raid
  --#region Checklist
  --   [ ] Basic Info
  --   [ ] Start Location
  --   [ ] Start NPC Scenarios
  --   [ ] Start NPC Dialogue
  --   [ ] Start Requirements
  --   [ ] Law Alerts
  --   [ ] Raid Boundary
  --   [ ] Entity Limits 
  --   [ ] Alarm System (disabled for now)
  --   [ ] Timing
  --   [ ] NPC Models
  --   [ ] Special Rules
  --   [ ] Sentry Positions (none for minor raid)
  --   [ ] Patrol Positions (none for minor raid)
  --   [ ] Turrets (none for minor raid)
  --   [ ] Reinforcements (none for minor raid)
  --   [ ] Waves (none for minor raid)
  --   [ ] Loot
  --#endregion
  -- ===================================================================
  --#region LSO Docks Minor Raid
  docks_minor = {
    
    -- BASIC INFO
    name = "Docks Raid",
    enabled = true,
    jurisdiction = "LSO",
    
    -- START LOCATION
    startPoint = vector4(2085.548, -1823.857, 41.670, 135.445),
    startNPCModel = 'msp_mudtown3b_males_01',
    notifyRadius = 20.0,
    
    -- START NPC SCENARIOS
    scenario = "WORLD_HUMAN_STAND_IMPATIENT",
    idleScenarios = {
      "WORLD_HUMAN_STAND_WAITING",
      "WORLD_HUMAN_SMOKING",
      "WORLD_HUMAN_GUARD_LEAN_WALL"
    },
    scenarioCycleInterval = 1,
    
    -- START NPC DIALOGUE
    dialogue = {
      enabled = true,
      greetingDistance = 3.0,
      resetDistance = 50.0,
      
      animations = {
        talk = { type = "scenario", name = "WORLD_HUMAN_STAND_IMPATIENT" },
        give_map = { type = "anim", dict = "mech_inspection@letter@base", anim = "grab", flag = 0, duration = 3000 },
        player_take_map = { type = "anim", dict = "mech_inspection@letter@base", anim = "hold", flag = 49, duration = -1, prop = "s_mollyloveletter" },
      },
      
    lines = {
      greeting = "You look like someone who knows how to handle themselves in a fight.",
      steps = {
        { label = "What do you want?", text = "The Lemoyne Raiders got a sweet operation running through the docks. They're smuggling weapons, supplies, everything through the port authority - got half the dock workers in their pocket.", anim = "talk" },
        { label = "Why tell me this?", text = "Because they're getting too bold, too organized. Moving shipment after shipment right under the law's nose. Someone needs to disrupt their operation, make 'em bleed a little.", anim = "talk" },
        { label = "I'll hit their operation.", text = "Now that's what I like to hear. They got lookouts positioned all over the docks, guards protecting their stash. Hit 'em hard and scatter their operation. Here's where they've been storing everything.", anim = "give_map", playerAnim = "player_take_map", action = "start" }
      },
      missingItem = "You ain't ready for this. Come back when you got yourself a %s."
    }
    },
    
    -- START REQUIREMENTS
    requiredItem = nil,
    consumeRequiredItem = false,
    
    -- LAW ALERTS
    lawAlerts = {
      enabled = true,
      timingMode = 'random',
      triggerPoint = 'sentries_cleared',
      randomDelay = { min = 30, max = 180 },
      jobs = {'LSO'}
    },
    
    -- RAID BOUNDARY
    boundary = {
      center = vector3(2762.646, -1509.637, 48.468),
      radius = 100.0
    },
    
    -- ===================================================================
    --                    ENTITY LIMITS
    -- ===================================================================
    maxEntities = 10,  -- Override global Config.MaxRaidEntities for this raid (optional)
    
    -- ===================================================================
    --                    ALARM SYSTEM (DISABLED - TO BE IMPLEMENTED IN THE FUTURE)
    -- ===================================================================
    --[[ ALARM SYSTEM COMMENTED OUT - Audio not working yet
    alarm = {
      enabled = true,
      name = "FORT_ALARM",  -- Identifier for this alarm (not actual sound name - uses bell_school sound)
      location = vector3(348.829, 1487.227, 179.460),  -- Where alarm sound originates (fort center)
      triggerOn = 'combat_detected',  -- When to trigger: 'raid_start', 'combat_detected', 'sentries_cleared'
      disableObject = {
        enabled = true,
        model = 's_dov_lab_panel02x',  -- Electrical panel model
        coords = vector4(337.74310302734375, 1496.3299560546875, 180.15704345703125, -148.58297729492188),  -- Inside main building
        freeze = true
      },
      disableMinigame = {
        enabled = true,
        type = 'wirecutting',
        difficulty = 'medium'  -- easy, medium, hard
      }
    },
    ]]--
    
    -- ===================================================================
    --                    TIMING
    -- ===================================================================
    waveDelay = nil,  -- No waves
    
    -- ACCESS TIMER FOR LOOT
    accessTimer = 0.5,  -- 0.5 minutes wait after clearing sentries/patrols
    
    -- NPC MODELS
    npcModels = { 'g_m_y_uniexconfeds_02', 'g_m_y_uniexconfeds_01' },
    leaderModel = 'g_m_y_uniexconfeds_02',
    
    -- SPECIAL RULES
    friendlyJobs = {"NARO", "USMO", "WESO", "LSO", "NHSO", "USDO"},  -- Law jobs cannot start this raid
    minLawCount = nil,  -- Minimum law officers required to start raid (nil = no requirement)
    
    -- ===================================================================
    --                    PATROL BEHAVIOR
    -- ===================================================================
    patrolRadius = 40.0,
    patrolPoints = 4,
    patrolWaitTime = 5000,
    
    -- ===================================================================
    --                    WEAPON POOLS
    -- ===================================================================
    weaponPools = {
      snipers = { 'WEAPON_RIFLE_BOLTACTION', 'WEAPON_SNIPERRIFLE_ROLLINGBLOCK' },
      repeaters = { 'WEAPON_REPEATER_WINCHESTER', 'WEAPON_REPEATER_CARBINE' },
      revolvers = { 'WEAPON_REVOLVER_CATTLEMAN' },
      rifles = { 'WEAPON_RIFLE_SPRINGFIELD' },
      shotguns = { 'WEAPON_SHOTGUN_DOUBLEBARREL' }
    },
    
    -- ===================================================================
    --                    AI BEHAVIOR
    -- ===================================================================
    AI = {
      difficulty = {
        playersDivisor = 2.0,  -- Difficulty scales with players
      },
      accuracy = {
        base = 25,
        min = 15,
        max = 40
      },
      health = {
        base = 150,
        multiplier = 1.0
      },
      combat = {
        coverUsage = 30,
        flankingChance = 20,
        aggressiveness = 50
      }
    },
    
    -- ===================================================================
    --                    SENTRY POSITIONS
    -- ===================================================================
    sentryPositions = {
      vector4(2782.403, -1537.568, 48.497, 292.923),
      vector4(2782.398, -1527.576, 47.066, 29.484),
      vector4(2772.911, -1497.457, 45.871, 25.415),
      vector4(2765.894, -1497.476, 45.871, 26.052),
      vector4(2786.674, -1546.063, 49.583, 33.629),
      vector4(2773.482, -1544.208, 48.437, 29.406),
      vector4(2764.011, -1528.907, 50.517, 114.991),
      vector4(2755.785, -1513.996, 48.422, 116.109),
      vector4(2752.971, -1508.354, 48.411, 116.118),
      vector4(2749.563, -1497.596, 50.558, 8.683),
      vector4(2756.239, -1497.386, 50.576, 10.615),
      vector4(2764.291, -1508.905, 48.478, 302.848),
    },
    
    -- ===================================================================
    --                    PATROL POSITIONS
    -- ===================================================================
    -- Roaming guards that move around
    patrols = {
      vector4(2733.851, -1488.901, 45.444, 359.949),
      vector4(2735.165, -1491.112, 45.444, 359.967),
      vector4(2733.352, -1492.692, 45.442, 179.814),
      vector4(2734.569, -1518.833, 45.444, 180.213),
      vector4(2731.902, -1520.569, 45.444, 167.421),
      vector4(2734.487, -1522.647, 45.444, 269.717),
      vector4(2759.438, -1452.976, 45.444, 341.022),
      vector4(2757.474, -1449.792, 45.444, 62.458),
      vector4(2762.722, -1446.468, 45.896, 262.506),
    },
    
    -- ===================================================================
    --                    TURRETS
    -- ===================================================================
    -- NOTE: Turrets do NOT count towards Config.MaxRaidEntities limit
    turretSpawnMode = 'dynamic',               -- 'static' (all) or 'dynamic' (random selection)
    turretDynamicCount = 0,                    -- No turrets
    
    turrets = {},  -- No turrets
    
    -- ===================================================================
    --                    SENTRY DEFAULTS (10m engagement range)
    -- ===================================================================
    sentryDefaults = {
      aggroRange = 80.0,  -- Sentries only engage when player is within 80 meters
      leashDistance = 30.0,  -- Return to spawn if more than 30m away
    },
    
    -- ===================================================================
    --                    REINFORCEMENTS
    -- ===================================================================
    reinforcements = {
      enabled = false,
      triggerMode = 'timer',
      delaySeconds = 60,
      thresholdPercent = 50,
      spawnFrequency = 'once',
      count = 2,
      npcModels = { 's_m_m_army_01' },
      horseModels = { 'A_C_Horse_KentuckySaddle_Grey' },
    },

    reinforcementSpawnPoints = {
      vector3(250.0, 1550.0, 180.0),
      vector3(450.0, 1450.0, 180.0),
      vector3(300.0, 1400.0, 180.0),
      vector3(400.0, 1550.0, 180.0),
    },

    -- ===================================================================
    --                    WAVES
    -- ===================================================================
    wavesEnabled = false,
    waves = {},  -- No waves
    
    -- ===================================================================
    --                    LOOT (only specify what's different from defaults)
    -- ===================================================================
    loot = {
      chestModel = 'mp001_p_mp_strongbox01x_lrg',  -- Army strongbox model
      boxCount = { min = 3, max = 4 },      -- Fixed 4 boxes
      
      spawnPoints = {
        vector4(2771.538, -1534.039, 47.436, 210.904),
        vector4(2774.770, -1532.055, 47.457, 211.639),
        vector4(2782.016, -1542.246, 47.49, 28.285),
        vector4(2777.005, -1545.887, 47.456, 29.748),
        vector4(2779.161, -1555.516, 48.528, 299.011),
        vector4(2788.545, -1547.958, 48.592, 125.399),
        vector4(2753.588, -1511.101, 47.412, 306.710),
        vector4(2755.719, -1502.668, 47.434, 210.602),
      },
      
      items = {
        { name = 'intel_folder', chance = 70, quantity = 1 },
        { name = 'moneybag', chance = 60, quantity = {min = 1, max = 3}, moneyReward = { min = 20, max = 80 } },
        { name = 'goldbar', chance = 30 },
        { name = 'crim_raid_shipping_ledger', chance = 100, quantity = 1 },
      },
      
      itemSelection = {
        mode = 'independent',
        maxItems = 3
      },
      
      -- Using global random minigame setting (padlock or lockpick)
      -- minigame config inherited from Config.Loot.minigame
    },
    
  },
  --#endregion
  -- ===================================================================
  --                        NARO Thieves Landing Minor Raid
  --#region Checklist
  --   [ ] Basic Info
  --   [ ] Start Location
  --   [ ] Start NPC Scenarios
  --   [ ] Start NPC Dialogue
  --   [ ] Start Requirements
  --   [ ] Law Alerts
  --   [ ] Raid Boundary
  --   [ ] Entity Limits 
  --   [ ] Alarm System (disabled for now)
  --   [ ] Timing
  --   [ ] NPC Models
  --   [ ] Special Rules
  --   [ ] Sentry Positions (none for minor raid)
  --   [ ] Patrol Positions (none for minor raid)
  --   [ ] Turrets (none for minor raid)
  --   [ ] Reinforcements (none for minor raid)
  --   [ ] Waves (none for minor raid)
  --   [ ] Loot
  --#endregion
  -- ===================================================================
  --#region NARO Thieves Landing Minor Raid
  thieves_landing = {
    
    -- BASIC INFO
    name = "Thieves Landing Raid",
    enabled = true,
    jurisdiction = "NARO",
    
    -- START LOCATION
    startPoint = vector4(-2575.733, -1377.388, 149.317, 336.208),
    startNPCModel = 'msp_mudtown3b_males_01',
    notifyRadius = 10.0,
    
    -- START NPC SCENARIOS
    scenario = "WORLD_HUMAN_STAND_IMPATIENT",
    idleScenarios = {
      "WORLD_HUMAN_STAND_WAITING",
      "WORLD_HUMAN_SMOKING",
      "WORLD_HUMAN_GUARD_LEAN_WALL"
    },
    scenarioCycleInterval = 1,
    
    -- START NPC DIALOGUE
    dialogue = {
      enabled = true,
      greetingDistance = 3.0,
      resetDistance = 50.0,
      
      animations = {
        talk = { type = "scenario", name = "WORLD_HUMAN_STAND_IMPATIENT" },
        give_map = { type = "anim", dict = "mech_inspection@letter@base", anim = "grab", flag = 0, duration = 3000 },
        player_take_map = { type = "anim", dict = "mech_inspection@letter@base", anim = "hold", flag = 49, duration = -1, prop = "s_mollyloveletter" },
      },
      
    lines = {
      greeting = "Howdy, fella. You look like someone who knows how to handle themselves in a fight.",
      steps = {
        { label = "Sure", text = "The del lobo's are gathering in one of their old strongholds, seems like they have something pretty decent to yap over.", anim = "talk" },
        { label = "Why tell me this?", text = "I need the del lobo's gone and im sure you want in on the loot they have.", anim = "talk" },
        { label = "I'll hit their operation.", text = "Wonderful. Here's where they've been storing everything.", anim = "give_map", playerAnim = "player_take_map", action = "start" }
      },
      missingItem = "You ain't ready for this. Come back when you got yourself a %s."
    }
    },
    
    -- START REQUIREMENTS
    requiredItem = nil,
    consumeRequiredItem = false,
    
    -- LAW ALERTS
    lawAlerts = {
      enabled = true,
      timingMode = 'random',
      triggerPoint = 'sentries_cleared',
      randomDelay = { min = 30, max = 180 },
      jobs = {'NARO'}
    },
    
    -- RAID BOUNDARY
    boundary = {
      center = vector3(-1422.363, -2315.456, 43.097),
      radius = 100.0
    },
    
    -- ===================================================================
    --                    ENTITY LIMITS
    -- ===================================================================
    maxEntities = 10,  -- Override global Config.MaxRaidEntities for this raid (optional)
    
    -- ===================================================================
    --                    ALARM SYSTEM (DISABLED - TO BE IMPLEMENTED IN THE FUTURE)
    -- ===================================================================
    --[[ ALARM SYSTEM COMMENTED OUT - Audio not working yet
    alarm = {
      enabled = true,
      name = "FORT_ALARM",  -- Identifier for this alarm (not actual sound name - uses bell_school sound)
      location = vector3(348.829, 1487.227, 179.460),  -- Where alarm sound originates (fort center)
      triggerOn = 'combat_detected',  -- When to trigger: 'raid_start', 'combat_detected', 'sentries_cleared'
      disableObject = {
        enabled = true,
        model = 's_dov_lab_panel02x',  -- Electrical panel model
        coords = vector4(337.74310302734375, 1496.3299560546875, 180.15704345703125, -148.58297729492188),  -- Inside main building
        freeze = true
      },
      disableMinigame = {
        enabled = true,
        type = 'wirecutting',
        difficulty = 'medium'  -- easy, medium, hard
      }
    },
    ]]--
    
    -- ===================================================================
    --                    TIMING
    -- ===================================================================
    waveDelay = nil,  -- No waves
    
    -- ACCESS TIMER FOR LOOT
    accessTimer = 0.5,  -- 0.5 minutes wait after clearing sentries/patrols
    
    -- NPC MODELS
    npcModels = { 'g_m_y_uniexconfeds_02', 'g_m_y_uniexconfeds_01' },
    leaderModel = 'g_m_y_uniexconfeds_02',
    
    -- SPECIAL RULES
    friendlyJobs = {"NARO", "USMO", "WESO", "LSO", "NHSO", "USDO"},  -- Law jobs cannot start this raid
    minLawCount = nil,  -- Minimum law officers required to start raid (nil = no requirement)
    
    -- ===================================================================
    --                    PATROL BEHAVIOR
    -- ===================================================================
    patrolRadius = 40.0,
    patrolPoints = 4,
    patrolWaitTime = 5000,
    
    -- ===================================================================
    --                    WEAPON POOLS
    -- ===================================================================
    weaponPools = {
      snipers = { 'WEAPON_RIFLE_BOLTACTION', 'WEAPON_SNIPERRIFLE_ROLLINGBLOCK' },
      repeaters = { 'WEAPON_REPEATER_WINCHESTER', 'WEAPON_REPEATER_CARBINE' },
      revolvers = { 'WEAPON_REVOLVER_CATTLEMAN' },
      rifles = { 'WEAPON_RIFLE_SPRINGFIELD' },
      shotguns = { 'WEAPON_SHOTGUN_DOUBLEBARREL' }
    },
    
    -- ===================================================================
    --                    AI BEHAVIOR
    -- ===================================================================
    AI = {
      difficulty = {
        playersDivisor = 2.0,  -- Difficulty scales with players
      },
      accuracy = {
        base = 25,
        min = 15,
        max = 40
      },
      health = {
        base = 150,
        multiplier = 1.0
      },
      combat = {
        coverUsage = 30,
        flankingChance = 20,
        aggressiveness = 50
      }
    },
    
    -- ===================================================================
    --                    SPECIAL RULES
    -- ===================================================================
    friendlyJobs = {"NARO", "USMO", "WESO", "LSO", "NHSO", "USDO"},  -- Law jobs cannot start this raid
    minLawCount = nil,  -- Minimum law officers required to start raid (nil = no requirement)
    
    -- ===================================================================
    --                    SENTRY POSITIONS
    -- ===================================================================
    sentryPositions = {
      vector4(-1453.697, -2336.099, 43.031, 109.944),
      vector4(-1455.676, -2328.573, 43.109, 104.060),
      vector4(-1424.539, -2325.848, 43.203, 48.213),
      vector4(-1418.527, -2326.709, 43.151, 355.426),
      vector4(-1414.371, -2327.109, 43.133, 350.148),
      vector4(-1392.450, -2333.117, 42.922, 280.999),
      vector4(-1387.602, -2320.541, 43.681, 271.171),
      vector4(-1388.140, -2311.941, 43.696, 271.061),
      vector4(-1396.564, -2305.217, 42.955, 74.970),
      vector4(-1386.528, -2289.084, 43.576, 11.010),
      vector4(-1373.206, -2289.721, 43.564, 8.926),
      vector4(-1366.411, -2288.430, 43.570, 333.593),
      vector4(-1357.801, -2287.216, 43.457, 82.112),
      vector4(-1351.917, -2287.727, 43.455, 275.254),
      vector4(-1351.755, -2303.822, 43.457, 180.720),
      vector4(-1358.413, -2308.931, 43.459, 82.066),
      vector4(-1358.672, -2300.208, 43.457, 78.701),
      vector4(-1421.536, -2280.348, 43.163, 7.622),
      vector4(-1417.646, -2280.866, 43.165, 0.277),
      vector4(-1407.007, -2276.216, 42.425, 318.255),
      vector4(-1445.552, -2309.151, 44.561, 256.788),
      vector4(-1446.048, -2312.115, 44.563, 263.453),
      vector4(-1451.439, -2302.011, 43.454, 69.029),
    },
    
    -- ===================================================================
    --                    PATROL POSITIONS
    -- ===================================================================
    -- Roaming guards that move around
    patrols = {
      vector4(-1470.516, -2298.695, 43.293, 33.184),
      vector4(-1473.689, -2301.056, 43.516, 36.973),
      vector4(-1468.697, -2304.014, 43.170, 215.641),
      vector4(-1454.885, -2271.218, 44.660, 339.063),
      vector4(-1451.016, -2271.801, 44.094, 318.250),
      vector4(-1408.430, -2232.407, 43.494, 349.173),
      vector4(-1410.489, -2229.456, 43.477, 348.061),
      vector4(-1405.508, -2228.530, 43.538, 337.006),
      vector4(-1483.006, -2333.727, 43.494, 95.313),
      vector4(-1484.983, -2328.063, 43.428, 11.555),
      vector4(-1479.943, -2332.813, 43.329, 190.251),
    },
    
    -- ===================================================================
    --                    TURRETS
    -- ===================================================================
    -- NOTE: Turrets do NOT count towards Config.MaxRaidEntities limit
    turretSpawnMode = 'dynamic',               -- 'static' (all) or 'dynamic' (random selection)
    turretDynamicCount = 0,                    -- No turrets
    
    turrets = {},  -- No turrets
    
    -- ===================================================================
    --                    SENTRY DEFAULTS (10m engagement range)
    -- ===================================================================
    sentryDefaults = {
      aggroRange = 80.0,  -- Sentries only engage when player is within 80 meters
      leashDistance = 30.0,  -- Return to spawn if more than 30m away
    },
    
    -- ===================================================================
    --                    REINFORCEMENTS
    -- ===================================================================
    reinforcements = {
      enabled = false,
      triggerMode = 'timer',
      delaySeconds = 60,
      thresholdPercent = 50,
      spawnFrequency = 'once',
      count = 2,
      npcModels = { 's_m_m_army_01' },
      horseModels = { 'A_C_Horse_KentuckySaddle_Grey' },
    },

    reinforcementSpawnPoints = {
      vector3(250.0, 1550.0, 180.0),
      vector3(450.0, 1450.0, 180.0),
      vector3(300.0, 1400.0, 180.0),
      vector3(400.0, 1550.0, 180.0),
    },

    -- ===================================================================
    --                    WAVES
    -- ===================================================================
    wavesEnabled = false,
    waves = {},  -- No waves
    
    -- ===================================================================
    --                    LOOT (only specify what's different from defaults)
    -- ===================================================================
    loot = {
      chestModel = 'mp001_p_mp_strongbox01x_lrg',  -- Army strongbox model
      boxCount = { min = 3, max = 4 },      -- Fixed 4 boxes
      
      spawnPoints = {
        vector4(-1399.287, -2330.374, 42.105, 131.389),
        vector4(-1389.703, -2337.553, 41.947, 347.608),
        vector4(-1372.657, -2319.055, 41.2, 7.673),
        vector4(-1355.055, -2310.596, 42.458, 357.543),
        vector4(-1352.040, -2287.957, 42.457, 89.009),
        vector4(-1425.596, -2283.738, 42.273, 84.037),
        vector4(-1426.903, -2291.367, 42.141, 87.659),
      },
      
      items = {
        { name = 'intel_folder', chance = 70, quantity = 1 },
        { name = 'moneybag', chance = 60, quantity = {min = 1, max = 3}, moneyReward = { min = 20, max = 80 } },
        { name = 'goldbar', chance = 30 },
        { name = 'crim_raid_prototype_order', chance = 100, quantity = 1 },
      },
      
      itemSelection = {
        mode = 'independent',
        maxItems = 3
      },
      
      -- Using global random minigame setting (padlock or lockpick)
      -- minigame config inherited from Config.Loot.minigame
    },
    
  },
  --#endregion
    
  -- ========================================================================
  --                      TEMPLATE RAID (Copy to create new raids)
  -- ========================================================================
  --[[
  template_raid = {
    name = "Template Raid",
    enabled = false,
    startPoint = vector3(0.0, 0.0, 0.0),
    
    -- ... other raid settings ...
    
    loot = {
      spawnPoints = {
        vector4(x, y, z, heading),
        -- ... more points
      },
      
      items = {
        { name = 'item_name', chance = 50 }
      },
      
      -- MINIGAME EXAMPLES - Choose ONE of the following modes:
      
      -- MODE 1: SINGLE MINIGAME (all boxes use same minigame)
      minigame = {
        enabled = true,
        type = 'padlock',
        digits = 4,
        code = 'random',
        mode = 'hint'
      },
      
      -- MODE 2: PER-BOX ASSIGNMENT (specific minigame per box index)
      -- minigames = {
      --   [1] = { type = 'padlock', digits = 4, mode = 'hint', failurePenalty = 0 },
      --   [2] = { type = 'lockpick', difficulty = 'hard', requiredItem = 'lockpick', consumeItem = true },
      --   [3] = { enabled = false }  -- Box 3 has no minigame
      -- },
      
      -- MODE 3: RANDOM POOL (each box randomly picks from pool on spawn)
      -- minigamePool = {
      --   { type = 'padlock', digits = 4, mode = 'hint' },
      --   { type = 'lockpick', difficulty = 'medium' },
      --   { type = 'padlock', digits = 6, mode = 'basic' }
      -- }
    }
  }
  --]]
}



-- ============================================================================
--                    AUTOMATIC CONFIGURATION MERGING (DO NOT MODIFY)
-- ============================================================================
-- Merges global defaults into each raid config (don't modify this section)

-- Deep merge function: recursively merges tables, raid config takes priority
local function deepMerge(default, override)
  local result = {}
  
  -- Copy all default values
  if default then
    for k, v in pairs(default) do
      if type(v) == 'table' then
        result[k] = deepMerge(v, nil) -- Deep copy tables
      else
        result[k] = v
      end
    end
  end
  
  -- Override with raid-specific values
  if override then
    for k, v in pairs(override) do
      if type(v) == 'table' and type(result[k]) == 'table' then
        result[k] = deepMerge(result[k], v) -- Recursive merge for nested tables
      else
        result[k] = v -- Direct override for primitives or new keys
      end
    end
  end
  
  return result
end

-- Apply global defaults to each raid configuration
for raidKey, raidCfg in pairs(Config.Raids) do
  raidCfg.AI = deepMerge(Config.Global.AI, raidCfg.AI)
  raidCfg.loot = deepMerge(Config.Loot, raidCfg.loot)
  raidCfg.sentryDefaults = deepMerge(Config.Global.SentryDefaults, raidCfg.sentryDefaults)
  raidCfg.turretDefaults = deepMerge(Config.Global.TurretDefaults, raidCfg.turretDefaults)
  raidCfg.notifyRadius = raidCfg.notifyRadius or 200.0
end

