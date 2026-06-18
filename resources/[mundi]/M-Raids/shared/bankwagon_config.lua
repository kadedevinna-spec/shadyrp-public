-- ============================================================================
--                    BANK WAGON ROBBERY CONFIGURATION
-- ============================================================================

BankWagonConfig = {}

-- ============================================================================
--                              DEBUG
-- ============================================================================
BankWagonConfig.Debug = false -- Essential logs only

-- ============================================================================
--                          ACTIVATION
-- ============================================================================
-- Activation Modes:
-- "npc_only"  = Players must visit a Fence NPC to get route plans (exchange items for intel)
-- "item_only" = Players can use route_plans item directly from inventory
-- "both"      = Either method works
BankWagonConfig.Activation = {
    mode = "both", -- "npc_only", "item_only", or "both"
    
    -- Route Plans Item (what the player uses to start the robbery)
    routePlansItem = {
        name = "route_plans",
        label = "Bank Wagon Route Plans",
        consumeOnUse = true -- Whether to consume the item when starting robbery
    },
    
    -- Fence NPCs (underground contacts who trade intel for information)
    -- Players bring "intel folders" from fort raids and exchange them for route plans
    fenceEnabled = true,
    fenceLocations = {
        {
            model = "mp_u_m_m_outlaw_arrestedthief_01",
            coords = vector3(2718.355, -1310.203, 47.068),
            heading = 180.0,
            scenario = "WORLD_HUMAN_SMOKE_CIGAR",
            blipEnabled = false, -- Set to true to show on map
            blipSprite = 1475879922,
            blipName = "Fence",
            
            -- What the player must bring to this fence
            requiredItems = {
                { name = "intel_folder", label = "Intelligence Folder", amount = 3 }
            },
            consumeItems = true,
            
            -- What the fence gives in return
            rewardItems = {
                { name = "route_plans", label = "Bank Wagon Route Plans", amount = 1 }
            },
            
            dialogue = {
                enabled = true,
                greetingDistance = 3.0,
                resetDistance = 50.0,
                lines = {
                    greeting = "Psst... you got something for me?",
                    steps = {
                        { label = "I have intel", text = "Let me see what you got... Hmm, this is good stuff. Military schedules, guard rotations...", anim = "talk" },
                        { label = "What can you give me?", text = "Bring me {requirements} and I can piece together a bank wagon route. Those things carry a fortune.", anim = "talk" },
                        { label = "Make the trade", text = "Pleasure doing business. Here's your route plans. Use 'em wisely.", anim = "give_map", action = "trade" }
                    },
                    missingItem = "You need to bring me %s first. Raid the forts, grab their intel."
                }
            }
        },
        {
            model = "mp_u_m_m_fos_roguethief_01",
            coords = vector3(464.441, 621.672, 112.572),
            heading = -102.0,
            scenario = "WORLD_HUMAN_SMOKE_CIGAR",
            blipEnabled = false,
            blipSprite = 1475879922,
            blipName = "Fence",
            
            requiredItems = {
                { name = "intel_folder", label = "Intelligence Folder", amount = 3 }
            },
            consumeItems = true,
            
            rewardItems = {
                { name = "route_plans", label = "Bank Wagon Route Plans", amount = 1 }
            },
            
            dialogue = {
                enabled = true,
                greetingDistance = 3.0,
                resetDistance = 50.0,
                lines = {
                    greeting = "You look like someone with information to sell.",
                    steps = {
                        { label = "I got intel from some raids i have done yeah so?", text = "Well, well... looks like you've been busy. This is quality information.", anim = "talk" },
                        { label = "What's it worth?", text = "Bring me {requirements} and I'll give you bank wagon routes. Worth a fortune.", anim = "talk" },
                        { label = "Deal", text = "Smart choice. Take these route plans. Hit the wagon when you're ready.", anim = "give_map", action = "trade" }
                    },
                    missingItem = "Come back when you got %s. The forts are full of intel if you're brave enough."
                }
            }
        }
    },
    
    -- Dialogue Animations
    dialogueAnimations = {
        talk = { type = "scenario", name = "WORLD_HUMAN_STAND_IMPATIENT" },
        give_map = { type = "scenario", name = "WORLD_HUMAN_WRITE_NOTEBOOK" },
        player_take_map = { type = "anim", dict = "mech_inspection@letter@base", anim = "hold", flag = 49, duration = -1, prop = "s_mollyloveletter" }
    }
}

-- ============================================================================
--                          ANIMATIONS
-- ============================================================================
BankWagonConfig.Animations = {
    readingMap = {
        dict = "mech_inspection@letter@base",
        anim = "hold",
        flag = 49,
        duration = 5000,
        prop = "s_mollyloveletter",
        propOffset = {
            pos = vector3(0.13, 0.07, -0.11),
            rot = vector3(-57.0, -99.0, 0.0)
        },
        cancelable = true,
        disableControls = true
    }
}

-- ============================================================================
--                              ROUTES
-- ============================================================================
BankWagonConfig.Routes = {
    [1] = {
        name = "Tumbleweed to Armadillo",
        enabled = true,
        wagonModel = "stagecoach004_2x",
        proximitySpawnDistance = 250.0,
        jurisdiction = "NARO",
        minLawmen = 0,
        cooldownMinutes = 60,
        
        startPoint = vector4(-5673.20, -2507.97, -11.19, -72.33),
        endPoint = vector3(-3718.45, -2610.51, -13.38),
        
        dynamitePreparationTime = 30000, -- Time in ms to prepare and place dynamite (30 seconds for testing)
        
        blip = {
            location = vector3(-5673.20, -2507.97, -11.19),
            sprite = 778811758,
            name = "Bank Wagon"
        },
        
        driver = {
            model = "s_m_m_valdeputy_01",
            weapon = "weapon_revolver_cattleman"
        },
        
        convoyRiders = {
            enabled = true,
            count = 4,
            models = { "s_m_m_valdeputy_01", "s_m_m_armdeputy_01" },
            horseModels = { "A_C_Horse_TennesseeWalker_BlackRabicano", "A_C_Horse_KentuckySaddle_Grey" },
            formation = {
                { x = -3.0, y = 12.0 },
                { x = 3.0, y = 12.0 },
                { x = -6.0, y = 0.0 },
                { x = 6.0, y = -10.0 }
            }
        },
        
        warWagon = {
            enabled = false, -- Set to true to include war wagon with gatling gun
            model = "warwagon2",
            guards = {
                count = 2, -- Number of guards in the war wagon
                model = "s_m_m_valdeputy_01",
                health = 150, -- Increased health for war wagon guards
                accuracy = 85
            },
            offset = { x = 0.0, y = -20.0 } -- Position behind the main wagon
        },
        
        wagonGuards = {
            count = 4,
            model = "s_m_m_valdeputy_01"
        }
    },
    
    [2] = {
        name = "Armadillo to Tumbleweed",
        enabled = true,
        wagonModel = "stagecoach004_2x",
        proximitySpawnDistance = 250.0,
        jurisdiction = "NARO",
        minLawmen = 2,
        cooldownMinutes = 60,
        
        startPoint = vector4(-3486.39, -2637.29, -13.22, 135.32),
        endPoint = vector3(-5569.56, -2957.35, -0.61),
        
        dynamitePreparationTime = 30000, -- Time in ms to prepare and place dynamite (30 seconds for testing)
        
        blip = {
            location = vector3(-3486.39, -2637.29, -13.22),
            sprite = 778811758,
            name = "Bank Wagon"
        },
        
        driver = {
            model = "s_m_m_valdeputy_01",
            weapon = "weapon_revolver_cattleman"
        },
        
        convoyRiders = {
            enabled = true,
            count = 4,
            models = { "s_m_m_valdeputy_01" },
            horseModels = { "A_C_Horse_TennesseeWalker_BlackRabicano", "A_C_Horse_KentuckySaddle_Grey" },
            formation = {
                { x = -3.0, y = 12.0 },
                { x = 3.0, y = 12.0 },
                { x = -6.0, y = 0.0 },
                { x = 6.0, y = -10.0 }
            }
        },
        
        warWagon = {
            enabled = false, -- Set to true to include war wagon with gatling gun
            model = "warwagon2",
            guards = {
                count = 2, -- Number of guards in the war wagon
                model = "s_m_m_valdeputy_01",
                health = 150, -- Increased health for war wagon guards
                accuracy = 85
            },
            offset = { x = 0.0, y = -20.0 } -- Position behind the main wagon
        },
        
        wagonGuards = {
            count = 6,
            model = "s_m_m_valdeputy_01"
        }
    },
    
    [3] = {
        name = "Saint Denis to Annesburg",
        enabled = true,
        wagonModel = "stagecoach004_2x",
        proximitySpawnDistance = 500.0,
        jurisdiction = "LSO",
        minLawmen = 0,
        cooldownMinutes = 60,
        startPoint = vector4(2179.14, -950.04, 41.67, -76.42),
        endPoint = vector3(2921.058, 1288.167, 44.319),
        
        dynamitePreparationTime = 30000, -- Time in ms to prepare and place dynamite (30 seconds for testing)
        
        blip = {
            location = vector3(2174.08, -951.16, 42.23),
            sprite = 778811758,
            name = "Bank Wagon"
        },
        
        driver = {
            model = "s_m_m_valdeputy_01",
            weapon = "weapon_revolver_cattleman"
        },
        
        convoyRiders = {
            enabled = true,
            count = 4,
            models = { "s_m_m_valdeputy_01" },
            horseModels = { "A_C_Horse_KentuckySaddle_Grey" },
            spawnPositions = {
                vector4(2184.013, -941.147, 41.257, 269.037),   -- Front left
                vector4(2187.447, -956.923, 41.448, 284.877),   -- Front right
                vector4(2164.193, -944.221, 41.458, 291.447),  -- Back left
                vector4(2170.561, -963.568, 42.715, 327.683)   -- Back right
            }
        },
        
        warWagon = {
            enabled = true, -- Set to true to include war wagon with gatling gun
            model = "warwagon2",
            spawnPosition = vector4(2166.889, -953.670, 42.439, 281.015), -- Fixed spawn position
            guards = {
                count = 2, -- Number of guards in the war wagon
                model = "s_m_m_valdeputy_01",
                health = 150, -- Increased health for war wagon guards
                accuracy = 45
            }
        },
        
        wagonGuards = {
            count = 4,
            model = "s_m_m_valdeputy_01"
        }
    },
    
    [4] = {
        name = "Valentine to Manzanita Post",
        enabled = true,
        wagonModel = "stagecoach004_2x",
        proximitySpawnDistance = 250.0,
        jurisdiction = "NHSO",
        minLawmen = 2,
        cooldownMinutes = 60,
        
        startPoint = vector4(-175.19, 655.93, 113.56, 104.29),
        endPoint = vector3(-1953.65, -1629.18, 116.17),
        
        dynamitePreparationTime = 30000, -- Time in ms to prepare and place dynamite (30 seconds for testing)
        
        blip = {
            location = vector3(-680.04, 336.99, 90.67),
            sprite = 778811758,
            name = "Bank Wagon"
        },
        
        driver = {
            model = "s_m_m_valdeputy_01",
            weapon = "weapon_revolver_cattleman"
        },
        
        convoyRiders = {
            enabled = true,
            count = 4,
            models = { "s_m_m_valdeputy_01" },
            horseModels = { "A_C_Horse_TennesseeWalker_BlackRabicano" },
            formation = {
                { x = -3.0, y = 12.0 },
                { x = 3.0, y = 12.0 },
                { x = -6.0, y = 0.0 },
                { x = 6.0, y = -10.0 }
            }
        },
        
        warWagon = {
            enabled = true, -- Set to true to include war wagon with gatling gun
            model = "warwagon2",
            guards = {
                count = 2, -- Number of guards in the war wagon
                model = "s_m_m_valdeputy_01",
                health = 150, -- Increased health for war wagon guards
                accuracy = 85
            },
            offset = { x = 0.0, y = -20.0 } -- Position behind the main wagon
        },
        
        wagonGuards = {
            count = 6,
            model = "s_m_m_valdeputy_01"
        }
    }
}

-- ============================================================================
--                          NPC COMBAT
-- ============================================================================
BankWagonConfig.NPCCombat = {
    proximityTrigger = {
        enabled = true,
        range = 30.0,
        delay = 15.0  -- Increased from 5 to 15 seconds to avoid engaging passersby
    },
    
    guards = {
        accuracy = 80,
        health = 100,
        combatMovement = 1,
        weapons = { "weapon_repeater_carbine", "weapon_revolver_cattleman", "weapon_shotgun_pump" }
    },
    
    convoy = {
        accuracy = 80,
        health = 100,
        combatMovement = 2,
        weapons = { "weapon_repeater_winchester", "weapon_revolver_schofield" }
    },
    
    warWagon = {
        accuracy = 45, -- Default accuracy for war wagon guards (reduced for balance)
        health = 150, -- Default health for war wagon guards
        combatMovement = 1, -- Stay in vehicle
        weapons = { "weapon_repeater_carbine", "weapon_revolver_schofield" },
        threatDetection = {
            enabled = true,
            proximityRadius = 15.0, -- Distance to detect nearby players
            aimingRadius = 30.0 -- Distance to detect players aiming at them
        }
    }
}

-- ============================================================================
--                     AI PERFORMANCE OPTIMIZATION
-- ============================================================================
-- Controls how often various AI systems check their conditions
-- Higher values = better performance but slightly less responsive NPCs
-- Lower values = more CPU usage but more reactive NPCs
BankWagonConfig.AIPerformance = {
    -- Death monitoring (checking if NPCs are dead/should be cleaned up)
    deathCheckInterval = 3000, -- Check every 3 seconds (default: 3000ms)
    
    -- Combat state monitoring (checking if NPCs are in combat)
    combatCheckInterval = 3000, -- Check every 3 seconds (increased to prevent server hitches and crashes)
}

-- ============================================================================
--                     HYBRID MODE (CLIENT + SERVER)
-- ============================================================================
-- Distributes workload between client and server for better performance
-- and anti-cheat protection
BankWagonConfig.HybridMode = {
    enabled = true,
    
    -- Server-side validation (prevents client-side cheating)
    validation = {
        validateNPCDeaths = true,
        maxKillDistance = 1000, -- Maximum distance (meters) for valid NPC kills
        logSuspiciousKills = true
    }
}

-- ============================================================================
--                          DYNAMITE
-- ============================================================================
BankWagonConfig.Dynamite = {
    -- If the player steals the wagon and gets this far from ALL living NPCs,
    -- they can place dynamite without killing the escorts first
    farFromNPCDistance = 80.0, -- Distance in meters
}

BankWagonConfig.Minigame = {
    enabled = true,
    dynamiteItem = "dynamite",
    
    -- Heat dissipation system (cooldown before placing dynamite)
    heatDissipation = {
        enabled = true, -- Set to false to allow immediate dynamite placement
        requireAllGuardsDead = true, -- If true, all guards must die; if false, use threshold below
        guardDeathThreshold = 0.75, -- If requireAllGuardsDead is false, % of guards that must be dead (0.75 = 75%)
        timeAfterGuardsDead = 2.0 -- Time in minutes to wait after guards dead/threshold met (0.5 = 30 seconds)
    },
    
    progressBar = {
        duration = 10000,
        label = "Placing dynamite...",
        cancellable = true,
        animation = {
            dict = "script_story@mud5@ig@ig_5_plant_dynamite",
            anim = "ig5_plant_light_front_arthur"
        }
    },
    
    placementPoints = {
        location1 = { offset = vector3(0.87, 0, 0.59), rotation = vector3(8, -18, 90) },
        location2 = { offset = vector3(-0.92, 0, 0.59), rotation = vector3(8, -18, 90) }
    },
    
    fuseTime = 8000,
    
    explosion = {
        type = 27,
        damageScale = 3.0,
        cameraShake = 3.0,
        isAudible = true,
        isInvisible = false
    },
    
    controls = {
        place = 0x760A9C6F
    }
}

-- ============================================================================
--                              LOOT
-- ============================================================================
BankWagonConfig.Loot = {
    enabled = true,
    scatterRadius = { min = 5, max = 6 },
    minItems = 3,
    maxItems = 6,
    
    moneyBagReward = { min = 40, max = 150 },
    
    -- Glow effect for ground loot and chests (pickup light like herbs/cabinets)
    glow = {
        enabled = false,         -- Disabled: pickup light native causes FPS drops near explosion sites
    },
    
    pools = {
        standard = { "moneybag", "goldbar" },
        high_value = { "goldbar", "goldbar", "goldbar", "moneybag" },
        low_value = { "moneybag" }
    },
    
    items = {
        moneybag = {
            name = "moneybag",
            label = "Money Bag",
            model = "p_moneybag02x",
            min = 1,
            max = 3
        },
        goldbar = {
            name = "goldbar",
            label = "Gold Bar",
            model = "s_pickup_goldbar01x",
            min = 1,
            max = 2
        }
    },
    
    -- ===================================================================
    --                    LOOT CHESTS (Strongboxes)
    -- ===================================================================
    -- Chests spawn alongside money bags and gold bars on the ground
    -- Players interact with them using VORP inventory (like raid chests)
    chests = {
        enabled = true,
        model = 'mp001_p_mp_strongbox01x_lrg',  -- Army strongbox (same as raid chests)
        count = { min = 1, max = 2 },            -- How many chests spawn per explosion
        spawnRadius = { min = 3.0, max = 5.0 },  -- Distance from explosion center
        
        -- Inventory settings (VORP custom inventory)
        inventory = {
            limit = 10,                  -- Max inventory slots per chest
            acceptWeapons = true,       -- Allow weapons in chest
            shared = true,               -- Multiple players can loot same chest
            ignoreItemStackLimit = true   -- Ignore item stack limits
        },
        
        -- Items to seed into chests (chance-based, like raid loot)
        items = {
            { name = 'moneybag', chance = 80, quantity = { min = 1, max = 3 }, label = 'Money Bag' },
            { name = 'goldbar', chance = 40, quantity = { min = 1, max = 2 }, label = 'Gold Bar' },
            { name = 'intel_folder', chance = 30, quantity = 1, label = 'Intel Folder' }
        },
        
        -- Interaction settings
        interactDistance = 2.5,
        promptLabel = 'Search Strongbox',
        
        -- Search animation (played before inventory opens)
        searchAnimation = {
            enabled = true,
            dict = "amb_misc@world_human_concertina_pickup@male_a@base",
            anim = "base",
            duration = 2000,
            label = 'Searching strongbox...'
        }
    },
    
    pickupDistance = 1.0,
    pickupAnimation = {
        dict = "amb_misc@world_human_concertina_pickup@male_a@base",
        anim = "base",
        duration = 1000
    }
}

-- ============================================================================
--                          LAW ALERTS
-- ============================================================================
BankWagonConfig.LawAlerts = {
    enabled = true,
    useJurisdictions = true,
    useRouteJurisdiction = true,
    alertOnJurisdictionChange = true,
    
    -- Timing: 'exact' or 'random'
    timingMode = 'random',
    
    -- Exact mode trigger points: 'convoy_attacked', 'guards_cleared', 'dynamite_placed', 'explosion'
    triggerPoint = 'dynamite_placed',
    
    -- Random mode settings
    randomAfterStage = 'convoy_attacked',
    randomDelay = { min = 30, max = 120 },
    
    -- Alert display settings
    notification = {
        title = "Bank Wagon Robbery",
        initialMessage = "Bank Wagon under attack!",
        updateInterval = 45000,
        updateMessage = "Last seen near: ",
        blipEnabled = true,
        blipRadius = 150.0,
        blipDuration = 120000
    },
    
    -- Jurisdictions - Using actual zone hashes from the game
    -- Zone hashes are returned by native 0x43AD8FC02B429D33 (GetZoneAtPosition)
    -- ZoneTypeId: 0 = State, 10 = District, 1 = Town
    jurisdictions = {
        ["LSO"] = {
            name = "Lemoyne Sheriff's Office",
            lawJobs = { "LSO" },
            -- State hashes (ZoneTypeId 0)
            stateHashes = { 10837344 }, -- state_lemoyne (Lemoyne)
            -- District hashes (ZoneTypeId 10)
            districtHashes = { 
                2025841068,   -- district_bayou_nwa
                1308232528,   -- district_bluewater_marsh
                -864275692    -- district_scarlett_meadows
            },
            -- Town hashes (ZoneTypeId 1)
            townHashes = {
                -765540529,   -- town_saintdenis
                2046780049,   -- town_rhodes
                894611678     -- settlement_lagras
            }
        },
        ["NHSO"] = {
            name = "New Hanover Sheriff's Office",
            lawJobs = { "NHSO" },
            stateHashes = { -1289136221 }, -- state_new_hanover (NewHanover)
            districtHashes = { 
                131399519,    -- district_heartlands
                178647645,    -- district_roanoake_ridge
                1835499550    -- district_cumberland_forest
            },
            townHashes = {
                459833523,    -- town_valentine
                7359335,      -- town_annesburg
                2126321341,   -- town_vanhorn
                350117545     -- settlement_emerald_ranch
            }
        },
        ["WESO"] = {
            name = "West Elizabeth Sheriff's Office",
            lawJobs = { "WESO" },
            stateHashes = { 
                1246494439,   -- state_west_elizabeth (WestElizabeth)
                -1247148211,  -- LowerWestElizabeth
                -1973391500   -- UpperWestElizabeth
            },
            districtHashes = {
                476637847,    -- district_great_plains
                1684533001,   -- district_tall_trees
                822658194,    -- district_big_valley
                1645618177,   -- district_grizzlies (west)
                -120156735    -- district_grizzlies (east)
            },
            townHashes = {
                1053078005,   -- town_blackwater
                427683330,    -- town_strawberry
                1463094051    -- settlement_manzanita_post
            }
        },
        ["NARO"] = {
            name = "New Austin Rangers Office",
            lawJobs = { "NARO" },
            stateHashes = { 2045157995 }, -- state_new_austin (NewAustin)
            districtHashes = {
                892930832,    -- district_hennigans_stead
                -2145992129,  -- district_rio_bravo
                -108848014,   -- district_cholla_springs
                -2066240242   -- district_gaptooth_ridge
            },
            townHashes = {
                -744494798,   -- town_armadillo
                -1524959147,  -- town_tumbleweed
                -1532919875   -- town_macfarlanes_ranch
            }
        },
        ["AMSO"] = {
            name = "Ambarino Sheriff's Office",
            lawJobs = { "NHSO" }, -- Falls under NHSO jurisdiction typically
            stateHashes = { -221059932 }, -- state_ambarino (Ambarino)
            districtHashes = {
                1645618177,   -- district_grizzlies (west) - shared with WESO
                -120156735    -- district_grizzlies (east) - shared with WESO
            },
            townHashes = {
                -735849380    -- settlement_wapiti
            }
        },
        ["USMO"] = {
            name = "US Marshals Office",
            lawJobs = { "USMO" },
            stateHashes = {},
            districtHashes = {},
            townHashes = {}
        }
    },
    
    fallbackLawJobs = { "LSO", "NHSO", "WESO", "NARO", "USMO" }
}

-- ============================================================================
--                          NOTIFICATIONS
-- ============================================================================
BankWagonConfig.Notifications = {
    soundEnabled = true,
    soundName = 'INFO',
    soundRef = 'HUD_SHOP_SOUNDSET',
    -- All notification messages are managed through locale files.
    -- Edit locales/en.lua (or the appropriate language file) to customise them.
}

-- ============================================================================
--                          SPAWNING
-- ============================================================================
BankWagonConfig.Spawning = {
    useProximitySpawn = true,
    playerProximity = 200.0,
    despawnDistance = 500.0,
    
    blip = {
        sprite = 1838354131,
        scale = 0.8,
        modifier = "BLIP_MODIFIER_PULSE_FOREVER"
    },
    
    wagonSpeed = 6.0,
    wagonDrivingStyle = 786603,
    
    -- Lifetime & stuck detection
    wagonLifetime = 1800,
    stuckCheckInterval = 15000,  -- Check every 15 seconds (was 10)
    stuckThreshold = 3.0,        -- Must move at least 3m per check (was 2)
    stuckTimeout = 45            -- Seconds before first unstick attempt (was 30)
}

-- ============================================================================
--                       JOB RESTRICTIONS
-- ============================================================================
-- Configure which jobs can/cannot participate in bank wagon robberies
-- and which jobs the NPC guards will be friendly towards
BankWagonConfig.JobRestrictions = {
    enabled = true,
    
    -- Jobs that CANNOT start/participate in bank wagon robberies (blacklist)
    -- Law enforcement / friendly jobs that should not be able to rob wagons
    blockedJobs = { 'LSO', 'NHSO', 'WESO', 'NARO', 'USMO' },
    
    -- Jobs that NPC guards will NOT attack (law enforcement)
    -- Guards will be friendly to these jobs and ignore them
    -- These jobs also won't trigger guard aggression when nearby
    friendlyJobs = { 'LSO', 'NHSO', 'WESO', 'NARO', 'USMO' },
    
    -- Job WHITELIST — only these jobs can start/participate in bank wagon robberies
    -- Set to nil to allow any job that is not in blockedJobs (default behaviour)
    -- Set to a list of job names to restrict participation to those jobs only
    -- Example: allowedJobs = { 'outlaw', 'vagabond', 'hunter' }
    allowedJobs = nil, -- nil = any non-blocked job can participate
    -- Job denial messages are managed through locale files.
    -- Edit locales/en.lua: bw_law_denial and bw_fence_not_allowed
}

-- ============================================================================
--                          CLEANUP
-- ============================================================================
BankWagonConfig.Cleanup = {
    autoCleanupDelay = 600000
}

return BankWagonConfig
