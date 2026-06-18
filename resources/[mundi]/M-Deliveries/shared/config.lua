-- ╔═══════════════════════════════════════════════════════════════╗
-- ║           M-DELIVERIES SYSTEM - CONFIGURATION FILE            ║
-- ║                                                               ║
-- ║            NAVIGATION GUIDE (Use Ctrl+F to search):           ║
-- ║  • [CORE]       - Core framework settings                     ║
-- ║  • [UI]         - Blips, notifications, markers               ║
-- ║  • [REPUTATION] - Reputation & progression system             ║
-- ║  • [MISSIONS]   - Mission availability & restrictions         ║
-- ║  • [PACKAGES]   - Package types & cargo presets               ║
-- ║  • [WAGONS]     - Wagon types configuration                   ║
-- ║  • [REWARDS]    - Payment & item rewards                      ║
-- ║  • [AMBUSH]     - Gang ambush system                          ║
-- ║  • [LOCATIONS]  - Foreman & dropoff locations                 ║
-- ╚═══════════════════════════════════════════════════════════════╝

Config = {}

-- ╔═══════════════════════════════════════════════════════════════╗
-- ║                      [CORE] CORE SETTINGS                     ║
-- ╚═══════════════════════════════════════════════════════════════╝

Config.Core = {
    -- Framework & Interaction
    framework = "rsg",              -- Framework: "auto" (detect), "VORP" or "RSG"
    interactionSystem = "ox_target", -- Interaction: "auto" (detect ox_target), "ox_target" or "prompt"
    
    -- Debugging
    debug = false,                   -- Enable console debug prints (F8)
    verboseLogging = false,          -- Extra detailed logging
    
    -- Distances
    npcSpawnDistance = 25.0,         -- Distance to spawn/despawn NPCs
    interactionDistance = 2.0,       -- Interaction radius (meters)
    
    -- Language
    language = "en",                 -- Language code: "en", "es", "fr", etc.
    
    -- Job Restriction (empty = everyone can access foremen)
    -- Add job names that are ALLOWED to interact with delivery foremen.
    -- If the table is empty or nil, all players can access deliveries.
    -- Example: allowedJobs = {"deliveryman", "hauler", "courier"}
    allowedJobs = {},
    
    -- Prompt Keys (used only when interactionSystem = "prompt" or ox_target is absent)
    -- Keys are assigned positionally to whichever options are visible in the current context.
    -- canInteract filters hide irrelevant options, so the active slot count changes per situation.
    -- This is the default mapping per interaction context:
    --
    --   Foreman NPC:          Slot 1 = Talk to Foreman      Slot 2 = Take Package
    --   Delivery wagon:       Slot 1 = Take Package         Slot 2 = Load Package
    --                         Slot 3 = Open Wagon Cargo     Slot 4 = Repair Wagon
    --                         Slot 5 = Replace Horse        Slot 6 = Check Wagon Status
    --                         Slot 7 = Inspect Cargo (law)  Slot 8 = Open Storage (law)
    --   Delivery drop-off:    Slot 1 = Deliver Package      Slot 2 = Check Delivery Status
    --   Law wagon:            Slot 1 = Inspect Cargo        Slot 2 = Open Wagon Storage
    --                         Slot 3 = Seize Wagon          Slot 4 = Take Evidence
    --                         Slot 5 = Impound Wagon        Slot 6 = Repair Wagon
    --                         Slot 7 = Replace Horse
    --   Law evidence drop-off:Slot 1 = Deliver Evidence
    --   Carrying a package:   Slot 1 = Place Package  (on self)
    --
    -- Reorder, add, or remove entries to customise which physical keys fill each slot.
    promptKeys = {
        { hash = 0x760A9C6F, label = "G     (slot 1 — Talk/Take/Deliver/Inspect)" },
        { hash = 0xF3830D8E, label = "J     (slot 2 — Load Package / Check Status / Open Storage)" },
        { hash = 0xDE794E3E, label = "Q     (slot 3 — Open Wagon Cargo / Seize Wagon)" },
        { hash = 0xC7B5340A, label = "Enter (slot 4 — Repair Wagon / Take Evidence)" },
        { hash = 0x84543902, label = "H     (slot 5 — Replace Horse / Impound Wagon)" },
        { hash = 0xE30CD707, label = "R     (slot 6 — Check Wagon Status / Repair Wagon)" },
        { hash = 0xB2F377E8, label = "F     (slot 7 — Inspect Cargo law / Replace Horse law)" },
        { hash = 0x4CC0E2FE, label = "B     (slot 8 — Open Storage law)" },
    }
}

-- ╔═══════════════════════════════════════════════════════════════╗
-- ║                     [UI] UI & NOTIFICATIONS                   ║
-- ╚═══════════════════════════════════════════════════════════════╝

Config.UI = {
    -- Notification Settings
    notifications = {
        soundEnabled = true,
        defaultPlacement = 'top-left'  -- top-left, top-right, top-center, bottom-left, bottom-right, bottom-center
    },

    -- Profile Picture
    -- When enabled, players can set a custom profile picture URL in the NUI clipboard.
    -- When disabled, a static cowboy silhouette is shown instead.
    profilePicture = true,

    -- NPC Blips
    npcBlip = {
        enabled = true,
        sprite = -1103135225,            -- Blip icon hash
        scale = 0.3,
        color = 'BLIP_MODIFIER_MP_COLOR_32' -- White
    },
    
    -- Entity Blips (wagon, packages, etc)
    entityBlips = {
        wagon = {
            enabled = true,
            style = 1664425300,
            sprite = GetHashKey('blip_ambient_wagon'),
            name = "Delivery Wagon",
            modifier = 'BLIP_MODIFIER_MP_COLOR_32'
        },
        package = {
            enabled = true,
            style = 1664425300,
            sprite = -426139257,
            name = "Package",
            modifier = 'BLIP_MODIFIER_MP_COLOR_32'
        },
        smuggler = {
            enabled = true,
            style = 1664425300,
            sprite = -1103135225,
            name = "Delivery Foreman",
            modifier = 'BLIP_MODIFIER_MP_COLOR_32'
        }
    },
    
    -- Menu Colors
    menuColors = {
        legal = "#8B7355",      -- Brown for legal jobs
        illegal = "#2F4F4F",    -- Dark slate for illegal jobs
        locked = "#8B0000",     -- Dark red for locked content
        success = "#228B22",    -- Forest green for success
        warning = "#FF8C00",    -- Dark orange for warnings
        error = "#DC143C"       -- Crimson for errors
    }
}

-- ╔═══════════════════════════════════════════════════════════════╗
-- ║                [REPUTATION] REPUTATION & LEVEL SYSTEM         ║
-- ╚═══════════════════════════════════════════════════════════════╝

Config.Reputation = {
    enabled = true,
    persistence = true,              -- Save to database
    perNpc = true,                  -- Per-foreman reputation (each foreman has independent rep/level)
    maxReputation = 50000,           -- Maximum reputation points (for clamping)
    
    -- Reputation Rewards (what you earn)
    -- Example: 6-pkg hemp smuggling, 2 stops, ~1.5 miles = (1.8*6) + (6*4) + (2*6) = 46.8 * 1.8 illegal = ~84 rep
    repPerMile = 6,                  -- Rep earned per mile traveled (+20%)
    repPerPackage = 6,               -- Rep earned per package delivered (+20%)
    repPerStopBonus = 6,             -- Bonus rep per stop completed (+20%)
    illegalMultiplier = 1.8,         -- Rep multiplier for illegal missions (+20%)
    groupBonusRep = 12,              -- Bonus rep for group mission participants (+20%)
    
    -- Reputation Loss (per failure type)
    missionFailed = -15,             -- Rep lost for generic/unknown failure
    wagonStolen = -25,               -- Rep lost if wagon is stolen by gang
    wagonDestroyed = -20,            -- Rep lost if wagon is destroyed
    timeRanOut = -15,                -- Rep lost if mission timer expires
    lawSeized = -30,                 -- Rep lost if law enforcement seizes the wagon
    ambushSurvived = 6,              -- Bonus rep for surviving ambush (+20%)
    
    -- Level Calculation
    -- Formula: Each level requires baseRep + (level * multiplier) additional rep
    -- Level 2 = 80 rep, Level 5 = 350 rep, Level 10 = ~1,050 rep
    -- Level 15 = ~2,100 rep, Level 20 = ~3,500 rep, Level 30 = ~7,350 rep
    baseRep = 40,                    -- Base rep component per level
    levelMultiplier = 30,            -- Additional rep per level (linear scaling)
    maxLevel = 30,                   -- Maximum achievable level
    
    -- Unlock Requirements (per-operation level gates)
    smugglingUnlockLevel = 10,       -- Level needed for hemp smuggling (first illegal op)
    moonshineUnlockLevel = 15,       -- Level needed for Tier 1 moonshine smuggling
    mixedUnlockLevel = 20,           -- Level needed for mixed smuggling runs
    
    -- Level Unlocks (what unlocks at each level)
    unlocks = {
        { level = 1,  unlock = "Basic deliveries" },
        { level = 3,  unlock = "Medium cargo wagons" },
        { level = 5,  unlock = "Multi-stop routes (up to 3 stops)" },
        { level = 8,  unlock = "Large cargo wagons" },
        { level = 10, unlock = "Hemp smuggling (Night only)" },
        { level = 15, unlock = "Tier 1 Moonshine smuggling & Extended routes" },
        { level = 20, unlock = "Tier 2 Moonshine & Mixed smuggling" },
        { level = 25, unlock = "Tier 3 Moonshine smuggling" },
        { level = 30, unlock = "Legendary status" }
    },
    
    -- Level Titles (display in NUI) - Period-appropriate for 1899
    levelTitles = {
        { level = 1,  title = "Greenhorn",           color = "#808080" },
        { level = 3,  title = "Wagon Hand",          color = "#A0522D" },
        { level = 5,  title = "Freighter",           color = "#8B7355" },
        { level = 8,  title = "Trail Rider",         color = "#CD853F" },
        { level = 10, title = "Teamster",            color = "#DAA520" },
        { level = 15, title = "Hauler",              color = "#B8860B" },
        { level = 20, title = "Master Freighter",    color = "#FFD700" },
        { level = 25, title = "Trail Boss",          color = "#E5E4E2" },
        { level = 30, title = "Legendary Hauler",    color = "#B9F2FF" }
    },
    
    -- Reputation Decay (optional)
    decay = {
        enabled = false,
        ratePerDay = 5,              -- Points lost per real-world day
        minimumReputation = 0        -- Won't decay below this
    }
}

-- ╔═══════════════════════════════════════════════════════════════╗
-- ║                [GROUP] COOPERATIVE MISSIONS                   ║
-- ╚═══════════════════════════════════════════════════════════════╝

Config.GroupMissions = {
    enabled = true,
    maxGroupSize = 4,                -- Maximum players in a group (including leader)
    minLevelToLead = 1,              -- Minimum level to create a group
    inviteRange = 10.0,              -- Range to detect nearby players for invite
    leaderRejoinWindow = 900,        -- 15 minutes (900 seconds) for leader to rejoin and reclaim leadership
    
    -- Reward Distribution (GTA5 Heist Style)
    enablePaymentSliders = true,     -- Enable GTA5-style payment distribution sliders
    equalReputation = true,          -- All members get same reputation as leader
    defaultLeaderCut = 50,           -- Default leader money percentage
    defaultMemberCut = 50,           -- Default member money percentage (split among members)
    
    -- Group Messages
    messages = {
        inviteSent = Locale("m_group_invite_sent"),
        inviteReceived = Locale("m_group_invite_received"),
        joined = Locale("m_group_joined"),
        left = Locale("m_group_left"),
        groupFull = Locale("m_group_full"),
        notLeader = Locale("m_group_not_leader"),
        levelTooLow = Locale("m_group_level_too_low"),
        missionStarted = Locale("m_group_mission_started"),
        missionComplete = Locale("m_group_mission_complete")
    }
}

-- ╔═══════════════════════════════════════════════════════════════╗
-- ║                [DEPOSIT] MISSION DEPOSIT SYSTEM               ║
-- ╚═══════════════════════════════════════════════════════════════╝

Config.MissionDeposit = {
    enabled = true,                  -- Enable deposit system
    levelRange = {1, 15},            -- Only applies to levels 1-15
    amount = 10.0,                   -- Deposit amount in dollars
    refundOnSuccess = true,          -- Refund deposit when mission completed successfully
    loseOnFail = true,               -- Lose deposit if mission fails/abandoned
    
    messages = {
        depositTaken = Locale("m_deposit_taken"),
        depositRefunded = Locale("m_deposit_refunded"),
        depositLost = Locale("m_deposit_lost"),
        insufficientFunds = Locale("m_deposit_insufficient")
    }
}

-- ╔═══════════════════════════════════════════════════════════════╗
-- ║                [TIMER] MISSION TIMER DISPLAY                  ║
-- ╚═══════════════════════════════════════════════════════════════╝

Config.MissionTimer = {
    enabled = true,
    timePerMile = 5.0,               -- Minutes allowed per mile of distance (realistic horse pace ~4mph)
    minTime = 1200,                  -- Minimum time in seconds (20 minutes)
    maxTime = 2400,                  -- Maximum time in seconds (40 minutes)
    timeBonusPerStop = 300,          -- Bonus time in seconds per stop completed (5 minutes)
    
    -- Timer Display
    showDuration = 5000,             -- How long to show timer (ms)
    showInterval = 60000,            -- Show timer every 60 seconds (ms)
    lowTimeThreshold = 300,          -- Show more often when under 5 min (seconds)
    criticalTimeThreshold = 60,      -- Critical warning under 1 min (seconds)
    
    -- Timer Colors
    colors = {
        normal = "#FFFFFF",
        warning = "#FFA500",         -- Under 5 minutes
        critical = "#FF0000"         -- Under 1 minute
    }
}

-- ╔═══════════════════════════════════════════════════════════════╗
-- ║                [DISTANCE] PAY CALCULATION                     ║
-- ╚═══════════════════════════════════════════════════════════════╝

Config.DistancePay = {
    enabled = true,
    moneyPerMile = 8,                -- Base money per mile
    packageMultiplier = 1.15,        -- Multiplier per package (stacks: 2 pkg = 1.15, 3 pkg = 1.32, 4 pkg = 1.52)
    legalPayoutMultiplier = 0.81,    -- Multiplier for legal delivery payouts (0.81 = ~19% total reduction)
    illegalMultiplier = 2.10,        -- Multiplier for illegal cargo (+20%)
    
    -- Distance Calculation
    metersPerMile = 1609.34,         -- Conversion factor
    minPayment = 15,                 -- Minimum payment regardless of distance
    maxPayment = 700,                -- Maximum payment cap (raised for illegal moonshine tiers)
    
    -- Bonuses
    bonuses = {
        multiStop = 3,               -- Bonus per additional stop
        quickDelivery = 1.15,        -- Multiplier if delivered with >25% time remaining
        perfectDelivery = 1.25       -- Multiplier if no damage/incidents
    },
    
    -- Region Pay Multipliers (legal deliveries only)
    -- Harder terrain / more remote areas pay more to compensate for difficulty
    regionPayMultipliers = {
        tumbleweed_region   = 1.15,  -- Remote desert, rough narrow trails — pays 15% more
        strawberry_region   = 1.00,  -- Mountain passes, standard pay
        new_hanover_region  = 0.70,  -- Annesburg area, easy roads — pays 30% less
        saint_denis_region  = 0.85,  -- Flat city roads, easy runs — pays 15% less
    }
}

-- ╔═══════════════════════════════════════════════════════════════╗
-- ║                [MAP] MULTI-ROUTE SYSTEM                       ║
-- ╚═══════════════════════════════════════════════════════════════╝

Config.Map = {
    enabled = true,
    showAllStops = true,             -- Show route to all stops, not just current
    
    -- Route Colors (RedM Color hashes or standard colors)
    colors = {
        completed = "COLOR_BLUE",    -- Color for completed routes
        current = "COLOR_YELLOW",    -- Color for route to current stop
        upcoming = "COLOR_WHITE"     -- Color for routes to future stops
    },
    
    -- Route Display
    showStopNumbers = true,          -- Show numbered blips for stops
    animateRoute = true,             -- Subtle animation on route
    routeThickness = 1,              -- Route line thickness (1-3)
    
    -- Blip Settings
    blipStyles = {
        pending = {
            sprite = "blip_objective",
            color = "BLIP_MODIFIER_MP_COLOR_6",  -- Yellow
            scale = 0.5
        },
        current = {
            sprite = "blip_objective",
            color = "BLIP_MODIFIER_MP_COLOR_32", -- Green
            scale = 0.6
        },
        completed = {
            sprite = "blip_proc_loot_sold",
            color = "BLIP_MODIFIER_MP_COLOR_2",  -- Bright Green
            scale = 0.4
        },
        returnPoint = {
            sprite = "blip_ambient_vip",
            color = "BLIP_MODIFIER_MP_COLOR_4",  -- Blue
            scale = 0.6
        }
    },
    
    -- Notification Settings
    showRouteNotifications = true,   -- Notify when map route updates
    notifyOnStopComplete = true      -- Notify when reaching a stop
}

-- ╔═══════════════════════════════════════════════════════════════╗
-- ║              [MISSIONS] MISSION COOLDOWN                      ║
-- ╚═══════════════════════════════════════════════════════════════╝

Config.MissionCooldown = {
    enabled = true,                  -- Enable mission cooldown system
    legalDuration = 0,               -- Legal mission cooldown: DISABLED (no cooldown per-mission)
    illegalDuration = 1800,          -- Illegal mission cooldown: 30 minutes (1800 seconds)
    applyToGroup = true,             -- Apply cooldown to all group members
    showTimer = true,                -- Show countdown timer in NUI
    
    -- Messages
    messages = {
        onCooldown = Locale("m_cooldown_wait"),
        cooldownApplied = Locale("m_cooldown_applied"),
    }
}

-- ╔═══════════════════════════════════════════════════════════════╗
-- ║          [MISSIONS] LEGAL DELIVERY STREAK COOLDOWN            ║
-- ╚═══════════════════════════════════════════════════════════════╝

Config.StreakCooldown = {
    enabled = true,                  -- Enable streak-based cooldown for legal deliveries
    minDeliveries = 6,               -- Minimum consecutive deliveries before cooldown can trigger
    maxDeliveries = 10,              -- Maximum consecutive deliveries before cooldown is guaranteed
    cooldownDuration = 900,          -- Cooldown duration in seconds (15 minutes = 900)
    applyToGroup = true,             -- Apply streak cooldown to group members too
    resetOnIllegal = false,          -- Whether completing an illegal run resets the legal streak
    
    -- Messages
    messages = {
        streakCooldown = Locale("m_streak_cooldown"),
        streakCooldownApplied = Locale("m_streak_cooldown_applied"),
    }
}

-- ╔═══════════════════════════════════════════════════════════════╗
-- ║              [MISSIONS] FOREMAN ILLEGAL LOCK                  ║
-- ╚═══════════════════════════════════════════════════════════════╝

Config.ForemanCooldown = {
    enabled = true,                  -- Only one illegal smuggling run per foreman at a time
                                     -- Prevents law enforcement from being overwhelmed
                                     -- Legal deliveries are NOT affected (multiple legal runs allowed)
                                     -- Lock releases when the illegal run completes, fails, is cancelled, or player disconnects
    
    -- Messages
    messages = {
        foremanBusy = Locale("m_foreman_busy"),
    }
}

-- ╔═══════════════════════════════════════════════════════════════╗
-- ║              [MISSIONS] MISSION AVAILABILITY                  ║
-- ╚═══════════════════════════════════════════════════════════════╝

Config.MissionAvailability = {
    -- Global Mission Toggles
    enableLegalMissions = true,      -- Enable/disable ALL legal missions
    enableIllegalMissions = true,    -- Enable/disable ALL illegal missions
    enforceTimeRestrictions = true,   -- Enforce day/night restrictions (illegal = nighttime only; legal = always available)
    
    -- Mission Generation
    dynamicMissionGeneration = true, -- Generate random missions
    legalMissionsPerForeman = 3,     -- # of legal missions generated
    illegalMissionsPerForeman = 3,   -- # of illegal missions generated (slot1=hemp, slot2=moonshine, slot3=mixed)
    missionRefreshInterval = 300,    -- Seconds between mission refresh (0 = disabled)
    
    -- Time Restrictions (uses hour + minutes for precise transitions)
    -- Format: {startHour, endHour} in 24h decimal (e.g. 19.5 = 7:30 PM)
    legalTimeRange = {6.0, 21.0},           -- Legal: 6:00 AM to 9:00 PM
    illegalTimeRange = {21.0, 6.0},         -- Illegal: 9:00 PM to 6:00 AM (wraps midnight)
    -- Legacy integer arrays kept for backward compatibility
    legalHours = {6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20}, -- legacy fallback
    illegalHours = {21, 22, 23, 0, 1, 2, 3, 4, 5},                        -- legacy fallback
    
    -- Restriction Messages
    messages = {
        legalUnavailable = Locale("m_legal_unavailable"),  -- Not normally shown (legal is 24/7)
        illegalUnavailable = Locale("m_illegal_unavailable"),
        allMissionsDisabled = Locale("m_all_missions_disabled"),
        legalDisabled = Locale("m_legal_disabled"),
        illegalDisabled = Locale("m_illegal_disabled"),
        illegalLocked = Locale("m_illegal_locked"),
        noWorkAvailable = Locale("m_no_work")
    }
}

-- ╔═══════════════════════════════════════════════════════════════╗
-- ║               [PACKAGES] PACKAGE & CARGO SYSTEM               ║
-- ╚═══════════════════════════════════════════════════════════════╝

Config.PackageSystem = {
    enabled = true,
    
    -- Inventory Settings
    wagonCapacity = 50,              -- Max weight in wagon inventory
    checkInventoryLimits = true,     -- Check player weight/stack before pickup
    sharedWagonAccess = true,        -- Anyone can access wagon inventory
    
    -- Anti-Exploit: Distance restrictions
    maxWagonDeliveryDistance = 200.0, -- Max distance from dropoff to take packages from wagon (prevents foot delivery exploits)
    
    -- Whitelisted Items (only these can be stored in wagon)
    wagonWhitelist = {
        "delivery_package_small", "delivery_package_medium", "delivery_package_large", "delivery_package_big",
        "delivery_sugar_sack", "delivery_grain_sack", 
        "delivery_barrel", "delivery_oil_barrel",
        "delivery_moonshine_crate", "delivery_hemp_crate"
    },
    
    -- ═══════════════ PACKAGE MODELS & ANIMATIONS ═══════════════
    models = {
        -- ─────────── LEGAL CRATES ───────────
        ["delivery_package_small"] = {
            label = "Small Crate",
            model = 'p_crate03x',
            bone = "SKEL_L_Hand",
            offset = {x = 0.1, y = -0.1399, z = 0.21},
            rotation = {x = 263.2899, y = 619.19, z = 334.3},
            animDict = "mech_carry_box",
            anim = "idle",
            animFlag = 31,
            weight = 5,
            cargoType = "general"
        },
        ["delivery_package_medium"] = {
            label = "Medium Crate",
            model = 'p_crate03x',
            bone = "SKEL_L_Hand",
            offset = {x = 0.1, y = -0.1399, z = 0.21},
            rotation = {x = 263.2899, y = 619.19, z = 334.3},
            animDict = "mech_carry_box",
            anim = "idle",
            animFlag = 31,
            weight = 10,
            cargoType = "general"
        },
        ["delivery_package_large"] = {
            label = "Large Crate",
            model = 'p_crate03x',
            bone = "SKEL_L_Hand",
            offset = {x = 0.1, y = -0.1399, z = 0.21},
            rotation = {x = 263.2899, y = 619.19, z = 334.3},
            animDict = "mech_carry_box",
            anim = "idle",
            animFlag = 31,
            weight = 15,
            cargoType = "general"
        },
        ["delivery_package_big"] = {
            label = "Special Crate",
            model = 'p_crate03x',
            bone = "SKEL_L_Hand",
            offset = {x = 0.1, y = -0.1399, z = 0.21},
            rotation = {x = 263.2899, y = 619.19, z = 334.3},
            animDict = "mech_carry_box",
            anim = "idle",
            animFlag = 31,
            weight = 20,
            cargoType = "general"
        },
        
        -- ─────────── AGRICULTURAL GOODS ───────────
        ["delivery_sugar_sack"] = {
            label = "Sugar Sack",
            model = 'p_cs_sacksugarcornwall01x',
            bone = "SKEL_L_Hand",
            offset = {x = -0.04999999999999, y = 0.0101, z = 0.17999999999998},
            rotation = {x = 323.68989999999985, y = 705.8900000000004, z = 361.4000000000001},
            animDict = "mech_carry_box",
            anim = "idle",
            animFlag = 31,
            weight = 12,
            cargoType = "agricultural"
        },
        ["delivery_grain_sack"] = {
            label = "Grain Sack",
            model = 'mp005_p_cs_sackcorn01x',
            bone = "SKEL_L_Hand",
            offset = {x = -0.04999999999999, y = -0.0899, z = 0.17999999999998},
            rotation = {x = 320.68989999999985, y = 714.8900000000004, z = 361.4000000000001},
            animDict = "mech_carry_box",
            anim = "idle",
            animFlag = 31,
            weight = 12,
            cargoType = "agricultural"
        },
        
        -- ─────────── BARRELS ───────────
        ["delivery_barrel"] = {
            label = "Barrel",
            animDict = "mech_carry_box",
            anim = "idle",
            animFlag = 31,
            model = 'p_barrel010x',
            bone = "SKEL_L_Hand",
            offset = {x = -0.04999999999999, y = -0.0899, z = 0.17999999999998},
            rotation = {x = 320.68989999999985, y = 714.8900000000004, z = 361.4000000000001},
            weight = 18,
            cargoType = "barrel"
        },
        ["delivery_oil_barrel"] = {
            label = "Oil Barrel",
            animDict = "mech_carry_box",
            anim = "idle",
            animFlag = 31,
            model = 'p_barrel010x',
            bone = "SKEL_L_Hand",
            offset = {x = -0.04999999999999, y = -0.0899, z = 0.17999999999998},
            rotation = {x = 320.68989999999985, y = 714.8900000000004, z = 361.4000000000001},
            weight = 18,
            cargoType = "barrel"
        },
        
        -- ─────────── ILLEGAL CONTRABAND ───────────
        ["delivery_moonshine_crate"] = {
            label = "Moonshine Crate",
            animDict = "mech_carry_box",
            anim = "idle",
            animFlag = 31,
            model = 'p_bottlecrate_mil',
            bone = "SKEL_L_Hand",
            offset = {x = 0.1, y = -0.1399, z = 0.26},
            rotation = {x = 263.2899, y = 619.19, z = 334.3},
            weight = 15,
            cargoType = "illegal",
            illegal = true,
            nightOnly = true
        },
        ["delivery_hemp_crate"] = {
            label = "Hemp Crate",
            animDict = "mech_carry_box",
            anim = "idle",
            animFlag = 31,
            model = 'p_chair_crate02x',
            bone = "SKEL_L_Hand",
            offset = {x = 0.1, y = -0.1399, z = 0.21},
            rotation = {x = 263.2899, y = 619.19, z = 334.3},
            weight = 12,
            cargoType = "illegal",
            illegal = true,
            nightOnly = true
        },
        
        -- ─────────── UTILITY ITEMS ───────────
        ["crated"] = {
            label = "Crate",
            animDict = "mech_carry_box",
            anim = "idle",
            animFlag = 31,
            model = 'p_chair_crate02x',
            bone = "SKEL_L_Hand",
            offset = {x = 0.1, y = -0.1399, z = 0.21},
            rotation = {x = 263.2899, y = 619.19, z = 334.3},
            weight = 3,
            cargoType = "general"
        }
    },
    
    -- ═══════════════ CARGO PRESETS ═══════════════
    -- Define what packages appear in each mission type
    -- Format: {package = "item_name", count = {min, max}}
    cargoPresets = {
        -- ─── Legal Missions ───
        legal = {
            {package = "delivery_package_small", count = {2, 4}},
            {package = "delivery_sugar_sack", count = {1, 3}},
            {package = "delivery_barrel", count = {1, 2}}
        },
        legal_agricultural = {
            {package = "delivery_grain_sack", count = {3, 5}},
            {package = "delivery_sugar_sack", count = {2, 4}},
            {package = "delivery_package_medium", count = {1, 2}}
        },
        legal_freight = {
            {package = "delivery_package_large", count = {2, 3}},
            {package = "delivery_oil_barrel", count = {1, 2}},
            {package = "delivery_package_big", count = {1, 1}}
        },
        
        -- ─── Illegal Missions (smuggling) ───
        -- Hemp smuggling: player provides cured_hemp + crated items, foreman packs into hemp crates
        illegal_hemp = {
            {package = "delivery_hemp_crate", count = {6, 10}}
        },
        -- Moonshine smuggling: player provides moonshine items + crated items, foreman packs into moonshine crates
        illegal_moonshine = {
            {package = "delivery_moonshine_crate", count = {6, 10}}
        },
        -- Mixed smuggling: both hemp and moonshine in one run
        illegal_mixed = {
            {package = "delivery_moonshine_crate", count = {3, 5}},
            {package = "delivery_hemp_crate", count = {3, 5}}
        }
    }
}

-- ╔═══════════════════════════════════════════════════════════════╗
-- ║                  [WAGONS] WAGON TYPES                         ║
-- ╚═══════════════════════════════════════════════════════════════╝

Config.Wagons = {
    -- ═══════════════ WAGON TYPES ═══════════════
    types = {
        -- ─── Freight Wagons (Legal cargo) ───
        {
            model = "wagon02x",
            name = "Freight Wagon",
            cargo = "",
            light = "",
            description = "Heavy-duty freight wagon for bulk cargo operations",
            size = "large",
            missionTypes = {"legal", "legal_freight"},
            cargoCapacity = 12,
            suitableFor = {"general", "barrel"}
        },
        {
            model = "chuckwagon002x",
            name = "Trade Wagon",
            cargo = "",
            light = "",
            description = "Merchant's preferred wagon for valuable trade goods",
            size = "large",
            missionTypes = {"legal", "legal_freight"},
            cargoCapacity = 10,
            suitableFor = {"general", "barrel"}
        },
        {
            model = "utilliwag",
            name = "Utility Wagon",
            cargo = "",
            light = "",
            description = "Versatile utility wagon for diverse cargo transport",
            size = "medium",
            missionTypes = {"legal", "legal_agricultural"},
            cargoCapacity = 8,
            suitableFor = {"general", "agricultural"}
        },
        {
            model = "supplywagon",
            name = "Supply Wagon",
            cargo = "",
            light = "",
            description = "Reliable supply wagon for general deliveries",
            size = "medium",
            missionTypes = {"legal"},
            cargoCapacity = 9,
            suitableFor = {"general"}
        },
        
        -- ─── Agricultural Wagons (Farm goods) ───
        {
            model = "cart06",
            name = "Farm Cart",
            cargo = "",
            light = "",
            description = "Sturdy farm cart ideal for agricultural goods",
            size = "small",
            missionTypes = {"legal_agricultural"},
            cargoCapacity = 6,
            suitableFor = {"agricultural"}
        },
        {
            model = "wagon05x",
            name = "Produce Wagon",
            cargo = "",
            light = "",
            description = "Open wagon perfect for sacks and farm produce",
            size = "medium",
            missionTypes = {"legal_agricultural"},
            cargoCapacity = 8,
            suitableFor = {"agricultural", "general"}
        },
        
        -- ─── Smuggling Wagons (Illegal contraband) ───
        {
            model = "huntercart01",
            name = "Hunting Cart",
            cargo = "",
            light = "",
            description = "Inconspicuous hunting cart perfect for concealed cargo",
            size = "small",
            missionTypes = {"illegal_moonshine", "illegal_hemp", "illegal_mixed"},
            cargoCapacity = 7,
            suitableFor = {"illegal"},
            stealth = true
        },
        {
            model = "chuckwagon000x",
            name = "Chuck Wagon",
            cargo = "",
            light = "",
            description = "Cook wagon with hidden compartments for contraband",
            size = "medium",
            missionTypes = {"illegal_moonshine", "illegal_mixed"},
            cargoCapacity = 8,
            suitableFor = {"illegal"},
            stealth = true
        },
        {
            model = "wagon06x",
            name = "Covered Wagon",
            cargo = "",
            light = "",
            description = "Covered wagon ideal for hiding illegal goods",
            size = "large",
            missionTypes = {"illegal_moonshine", "illegal_hemp", "illegal_mixed"},
            cargoCapacity = 10,
            suitableFor = {"illegal"},
            stealth = true
        },
        
        -- ─── Small Carts (Quick runs) ───
        {
            model = "cart01",
            name = "Small Cart",
            cargo = "",
            light = "",
            description = "Light cart for quick deliveries",
            size = "small",
            missionTypes = {"legal"},
            cargoCapacity = 4,
            suitableFor = {"general"}
        },
        {
            model = "cart03",
            name = "Trader's Cart",
            cargo = "",
            light = "",
            description = "Compact cart for small-scale trading",
            size = "small",
            missionTypes = {"legal"},
            cargoCapacity = 5,
            suitableFor = {"general"}
        }
    }
}

-- ╔═══════════════════════════════════════════════════════════════╗
-- ║           [REWARDS] ITEM REQUIREMENTS & REWARDS               ║
-- ╚═══════════════════════════════════════════════════════════════╝

Config.Requirements = {
    enabled = true,                  -- Require items for illegal missions
    
    -- ═══════════════ CRATE ITEM SETTINGS ═══════════════
    -- The item name for empty crates that players must provide
    crateItemName = "crated",        -- Item name for empty crates in player inventory
    crateItemLabel = "Crate",        -- Display name for crates
    
    -- ═══════════════ HEMP SMUGGLING SETTINGS ═══════════════
    hemp = {
        itemName = "cured_hemp",                 -- Item name for cured hemp
        itemLabel = "Cured Hemp",                -- Display name
        hempPerCrate = 30,                       -- How much cured_hemp goes into one crate
        minCrates = 6,                           -- Minimum crates for a hemp mission
        maxCrates = 10,                          -- Maximum crates for a hemp mission
        -- Payment per hemp crate delivered
        payPerCrate = 40.00,                     -- Fixed payment per hemp crate ($40/crate, covers material cost + profit)
        -- Small chance 2-3 crates can share a drop-off location
        multiDropChance = 20,                    -- % chance a stop gets 2+ crates (never above 3)
        maxCratesPerStop = 3,                    -- Maximum crates that can share one drop-off
    },
    
    -- ═══════════════ MOONSHINE SMUGGLING SETTINGS ═══════════════
    moonshine = {
        minCrates = 6,                           -- Minimum crates for a moonshine mission
        maxCrates = 10,                          -- Maximum crates for a moonshine mission
        -- Moonshine types from fx-moonshinev2 (each is its own item)
        -- Payment is calculated per type of moonshine
        types = {
            {
                itemName = "moonshine_original",
                label = "Moonshine Original",
                amountPerCrate = 5,              -- How many moonshine items per crate
                payPerCrate = 48.00,             -- Tier 1: $48/crate (hemp × 1.2)
                unlockLevel = 15,                -- Delivery level required
            },
            {
                itemName = "moonshine_blueflame",
                label = "Moonshine Blueflame",
                amountPerCrate = 5,
                payPerCrate = 57.60,             -- Tier 2: $57.60/crate (T1 × 1.2)
                unlockLevel = 20,
            },
            {
                itemName = "moonshine_red",
                label = "Moonshine Red",
                amountPerCrate = 5,
                payPerCrate = 69.12,             -- Tier 3: $69.12/crate (T2 × 1.2)
                unlockLevel = 25,
            },
        },
        -- Small chance 2-3 crates can share a drop-off location
        multiDropChance = 15,                    -- % chance a stop gets 2+ crates
        maxCratesPerStop = 3,                    -- Maximum crates that can share one drop-off
    },
    
    -- ═══════════════ MIXED SMUGGLING SETTINGS ═══════════════
    mixed = {
        unlockLevel = 20,                        -- Requires hemp (10) + T1 moonshine (15) access
        minHempCrates = 3,                       -- Minimum hemp crates in a mixed run
        maxHempCrates = 5,
        minMoonshineCrates = 3,                  -- Minimum moonshine crates in a mixed run
        maxMoonshineCrates = 5,
    },
    
    -- ═══════════════ LEGACY PRESET REQUIREMENTS ═══════════════
    -- These are used by the server side CheckAndTakeRequiredItems function
    -- They are auto generated at mission start based on the above settings
    byPreset = {
        -- Legal missions (no requirements)
        ["legal"] = { required = false },
        ["legal_agricultural"] = { required = false },
        ["legal_freight"] = { required = false },
        
        -- Illegal hemp: requires cured_hemp + crates
        -- Actual amounts are calculated dynamically based on crate count
        ["illegal_hemp"] = {
            required = true,
            isDynamic = true,                    -- Flag: amounts calculated at mission start
            packagesInto = "hemp_crate",
            reputationRequired = 0,              -- Level gating handles access
            explanation = "Bring me your cured hemp and crates - I'll pack 'em tight for transport"
        },
        -- Illegal moonshine: requires moonshine items + crates
        ["illegal_moonshine"] = {
            required = true,
            isDynamic = true,
            packagesInto = "moonshine_crate",
            reputationRequired = 0,
            explanation = "Got moonshine? Bring it with crates and I'll get it ready for the road"
        },
        -- Illegal mixed: requires both hemp + moonshine + crates
        ["illegal_mixed"] = {
            required = true,
            isDynamic = true,
            packagesInto = {"moonshine_crate", "hemp_crate"},
            reputationRequired = 0,
            explanation = "Bring moonshine, hemp, and crates - I'll handle the logistics"
        }
    },
    
    messages = {
        insufficientItems = Locale("m_insufficient_items"),
        itemsTaken = Locale("m_items_taken"),
        requirementsNotMet = Locale("m_requirements_not_met"),
        reputationTooLow = Locale("m_reputation_too_low_cfg"),
        insufficientCrates = Locale("m_insufficient_crates"),
        cratesTaken = Locale("m_crates_taken"),
        hempPackaged = Locale("m_hemp_packaged_cfg"),
        moonshinePackaged = Locale("m_moonshine_packaged_cfg"),
        mixedPackaged = Locale("m_mixed_packaged_cfg")
    }
}

Config.Rewards = {
    -- Dynamic Reward Calculation
    -- Example: 2 mile trip, 3 packages, 20% risk = (2*8) + (3*2) + (20*0.1) = $24 base
    calculation = {
        basePrice = {2, 4},              -- Base payment per package ($2-4 per pkg)
        distanceMultiplier = {0.5, 1.5}, -- Distance bonus multiplier
        riskMultiplier = {0.1, 0.3},     -- Risk-based bonus (per risk %)
        packageBonus = {0.5, 1.0},       -- Bonus per extra package
        timeBonus = {1.0, 1.15}          -- Time completion bonus (up to 15%)
    },
    
    -- Item Rewards (with drop chances) - EMPTY for now, add items as needed
    possibleItems = {
        -- Example: {name = "item_name", amount = {min, max}, chance = percent}
    },
    
    -- Ambush Survival Bonuses
    ambushSurvivalBonus = {
        enabled = true,
        moneyBonus = 10,                 -- Extra money for surviving
        itemDrops = {
            -- Add items here if desired
        }
    }
}

-- ╔═══════════════════════════════════════════════════════════════╗
-- ║  WAGON REPAIR — Items required to repair a damaged wagon     ║
-- ╚═══════════════════════════════════════════════════════════════╝
Config.WagonRepair = {
    items = {
        { name = 'wood_plank', label = 'Wood Planks', amount = 2 },
        { name = 'nails',      label = 'Nails',       amount = 4 },
    }
}

Config.DynamicRuns = {
    enabled = true,
    
    -- ═══════════════ LEGAL MISSION NAMING ═══════════════
    -- More varied and period-appropriate mission names
    normalNamePrefixes = {
        -- Speed/Urgency based
        "Express", "Swift", "Quick", "Rapid", "Priority", "Urgent",
        -- Company/Business based
        "Merchant", "Union", "Guild", "Company", "Trade",
        -- Quality based
        "Premium", "Elite", "Standard", "Reliable", "Trusted",
        -- Regional
        "Western", "Frontier", "Valley", "Plains", "Mountain"
    },
    normalNameTypes = {
        "Delivery", "Transport", "Shipment", "Cargo Run", "Freight Run",
        "Goods Haul", "Supply Run", "Trade Route", "Merchandise Run"
    },
    normalNameSuffixes = {
        "Service", "Route", "Run", "Contract", "Mission", "Operation",
        "Order", "Commission", "Job", "Task"
    },
    
    -- ═══════════════ ILLEGAL MISSION NAMING ═══════════════
    namePrefixes = {
        "Covert", "Secret", "Underground", "Shadow", "Midnight", "Discreet",
        "Backdoor", "Hidden", "Silent", "Dark", "Ghost", "Phantom",
        "Quiet", "Hushed", "Veiled", "Masked", "Clandestine", "Stealthy"
    },
    nameTypes = {
        "Delivery", "Transport", "Shipment", "Cargo Run",
        "Contraband Run", "Black Market Delivery", "Moonshine Run",
        "Smuggling Operation", "Underground Trade", "Off-the-Books Haul"
    },
    nameSuffixes = {
        "Service", "Route", "Run", "Contract", "Mission", "Operation",
        "Exchange", "Deal", "Arrangement", "Understanding"
    },
    
    -- ═══════════════ MISSION MODIFIERS ═══════════════
    -- Special conditions that can modify missions
    missionModifiers = {
        -- Time-sensitive modifiers
        urgent = {
            namePrefix = "Urgent",
            timeMultiplier = 0.7,      -- 30% less time
            payMultiplier = 1.4,       -- 40% more pay
            description = "Time is critical - deliver as fast as possible!",
            chance = 15                 -- 15% chance
        },
        relaxed = {
            namePrefix = "Leisurely",
            timeMultiplier = 1.5,      -- 50% more time
            payMultiplier = 0.85,      -- 15% less pay
            description = "Take your time - no rush on this one.",
            chance = 20
        },
        -- Weather-based modifiers
        stormy = {
            namePrefix = "Storm",
            timeMultiplier = 1.3,
            payMultiplier = 1.25,
            description = "Bad weather expected - exercise caution.",
            chance = 10
        },
        -- Cargo condition modifiers
        fragile = {
            namePrefix = "Delicate",
            damageMultiplier = 2.0,    -- Cargo takes 2x damage
            payMultiplier = 1.3,
            description = "Handle with extreme care - fragile goods!",
            chance = 12
        },
        valuable = {
            namePrefix = "High-Value",
            riskIncrease = 15,
            payMultiplier = 1.5,
            description = "Exceptionally valuable cargo - expect attention.",
            chance = 10
        },
        -- Route modifiers
        scenic = {
            namePrefix = "Scenic",
            distanceMultiplier = 1.3,
            payMultiplier = 1.2,
            description = "Take the long way - avoid main roads.",
            chance = 15
        },
        direct = {
            namePrefix = "Direct",
            distanceMultiplier = 0.8,
            timeMultiplier = 0.8,
            payMultiplier = 1.1,
            description = "Straight shot - fastest route available.",
            chance = 12
        }
    },
    
    -- ═══════════════ MISSION STORY ELEMENTS ═══════════════
    -- Add flavor/backstory to missions
    storyElements = {
        legal = {
            clients = {
                "a local general store", "a rundown saloon", "a wealthy rancher",
                "the town doctor", "a mining company", "the railway station",
                "a hotel proprietor", "the blacksmith", "a traveling merchant",
                "the sheriff's office", "a church congregation", "the telegraph office",
                "a cattle baron", "the local tailor", "a photography studio"
            },
            goods = {
                "supplies", "provisions", "equipment", "medicine", "tools",
                "fabric", "hardware", "foodstuffs", "machinery parts", "books",
                "furniture", "agricultural supplies", "mining equipment", "weapons",
                "leather goods", "glassware", "clothing", "canned goods"
            },
            reasons = {
                "They're running low on stock.",
                "There's a big event coming up.",
                "Winter is approaching and they need to stock up.",
                "The previous shipment was lost.",
                "Business has been good and they need more.",
                "A special order came in from a customer.",
                "They're expanding their operation.",
                "The regular supplier let them down."
            }
        },
        illegal = {
            contacts = {
                "a discreet buyer", "an underground fence", "a corrupt official",
                "a rival gang", "a desperate farmer", "a shady bartender",
                "an anonymous benefactor", "a foreign trader", "a railroad worker",
                "a saloon owner in debt", "a crooked banker", "a mysterious stranger"
            },
            goods = {
                "moonshine", "contraband weapons", "stolen goods", "forged documents",
                "smuggled whiskey", "illegal gambling equipment", "banned substances",
                "black market medicine", "counterfeit money", "stolen artwork"
            },
            warnings = {
                "Keep your head down and don't draw attention.",
                "Stick to the back roads - eyes are everywhere.",
                "Word is there's trouble out on the trails - stay sharp.",
                "Rival outfits might try to jump the cargo.",
                "This is off the books - you were never here.",
                "Don't go asking questions about the cargo.",
                "The buyer spooks easy - be discreet.",
                "There's folks looking for this cargo - watch your back."
            }
        }
    },
    
    -- ═══════════════ PACKAGE CONFIGURATIONS (LEGACY but kept for reference) ═══════════════
    -- Now driven by Config.LevelProgression below - these are fallback only
    packageConfigs = {
        {minStops = 2, maxStops = 2, totalPackages = {3, 4}, name = "Short Haul", tier = 1, minLevel = 1},
        {minStops = 2, maxStops = 3, totalPackages = {4, 5}, name = "Standard Run", tier = 2, minLevel = 1},
        {minStops = 3, maxStops = 4, totalPackages = {5, 7}, name = "Long Haul", tier = 3, minLevel = 5},
        {minStops = 4, maxStops = 5, totalPackages = {6, 9}, name = "Extended", tier = 4, minLevel = 10},
        {minStops = 5, maxStops = 6, totalPackages = {8, 12}, name = "Marathon", tier = 5, minLevel = 20}
    },
    
    -- ═══════════════ MISSION DESCRIPTIONS ═══════════════
    -- More varied descriptions based on context
    descriptions = {
        "Deliver goods through dangerous territory - stay alert for bandits",
        "Transport valuable cargo to multiple locations - time is critical",
        "Move cargo under the cover of darkness - avoid unwanted attention",
        "Routine delivery - handle with care and stay on schedule",
        "Standard freight transport - follow the marked route"
    },
    
    -- ═══════════════ REWARD CALCULATION ═══════════════
    -- Balanced reward system: Base pay + per-package pay + stop bonuses
    rewardRanges = {
        basePrice = {4, 6},              -- Base payment for any mission ($4-6)
        perPackageRate = {1, 2},         -- Payment per package ($1-2 each)
        perStopBonus = {2, 3},           -- Bonus per delivery stop ($2-3 each)
        distanceMultiplier = {1.0, 1.3}, -- Distance bonus (1.0x to 1.3x)
        riskMultiplier = {1.0, 1.5},     -- Risk bonus for illegal (1.0x to 1.5x)
        packageBonus = {0.5, 1.0},       -- Extra bonus per package (legacy, kept for compatibility)
        timeBonus = {1.0, 1.15}          -- Time completion bonus
    },
    
    -- ═══════════════ ITEM REWARDS ═══════════════
    -- Empty for now - add items as needed for your economy
    possibleItems = {
        -- Example: {name = "item_name", amount = {min, max}, chance = percent}
    },
    
    -- ═══════════════ RISK LEVELS ═══════════════
    -- Lower risk levels for legal missions (5-35%), higher for illegal
    riskLevels = {5, 10, 15, 20, 25, 30, 35},
    baseRiskLevel = 10,
    
    -- ═══════════════ TIME LIMITS ═══════════════
    -- In milliseconds - calculated based on distance, these are category hints
    timeLimits = {
        express = 600000,    -- 10 minutes (short runs)
        urgent = 900000,     -- 15 minutes (medium runs)
        standard = 1500000   -- 25 minutes (long runs)
    }
}

-- ╔═══════════════════════════════════════════════════════════════╗
-- ║            [PROGRESSION] LEVEL-BASED PROGRESSION              ║
-- ║                                                               ║
-- ║  Controls how player level affects EVERYTHING:                ║
-- ║  • Mission tiers & difficulty                                 ║
-- ║  • Package/stop counts                                       ║
-- ║  • Payment scaling                                            ║
-- ║  • Risk & ambush difficulty                                   ║
-- ║  • Wagon access                                               ║
-- ║  • Mission variety (weighted random, not fixed)               ║
-- ╚═══════════════════════════════════════════════════════════════╝

Config.LevelProgression = {
    enabled = true,
    
    -- ═══════════════ MISSION TIERS ═══════════════
    -- Each tier defines a difficulty bracket for mission generation
    -- Missions are selected via weighted random - high level players CAN still
    -- get easy runs, but will more often see harder ones
    tiers = {
        {
            id = 1,
            name = "Short Haul",
            minLevel = 1,               -- Available from level 1
            packages = {2, 4},          -- 2-4 packages
            stops = {1, 2},             -- 1-2 drop-offs
            riskRange = {5, 15},        -- 5-15% risk (low ambush chance)
            wagonSizes = {"small"},     -- Only small carts
            payMultiplier = 1.0,        -- Base pay rate
            distanceRange = {300, 600}, -- Estimated meters per stop
        },
        {
            id = 2,
            name = "Standard Run",
            minLevel = 1,               -- Available from level 1
            packages = {3, 5},          -- 3-5 packages
            stops = {2, 3},             -- 2-3 drop-offs
            riskRange = {10, 25},       -- 10-25% risk
            wagonSizes = {"small", "medium"},
            payMultiplier = 1.15,       -- 15% more pay than Short Haul
            distanceRange = {400, 700},
        },
        {
            id = 3,
            name = "Long Haul",
            minLevel = 5,               -- Unlocks at level 5
            packages = {4, 7},          -- 4-7 packages
            stops = {3, 4},             -- 3-4 drop-offs
            riskRange = {15, 35},       -- 15-35% risk (medium ambush chance)
            wagonSizes = {"medium"},
            payMultiplier = 1.35,       -- 35% more pay
            distanceRange = {500, 800},
        },
        {
            id = 4,
            name = "Extended Route",
            minLevel = 10,              -- Unlocks at level 10
            packages = {5, 9},          -- 5-9 packages
            stops = {4, 5},             -- 4-5 drop-offs
            riskRange = {20, 45},       -- 20-45% risk (high ambush chance)
            wagonSizes = {"medium", "large"},
            payMultiplier = 1.55,       -- 55% more pay
            distanceRange = {500, 800},
        },
        {
            id = 5,
            name = "Marathon",
            minLevel = 20,              -- Unlocks at level 20
            packages = {7, 12},         -- 7-12 packages
            stops = {5, 7},             -- 5-7 drop-offs
            riskRange = {30, 60},       -- 30-60% risk (very dangerous)
            wagonSizes = {"large"},     -- Only big wagons can handle this
            payMultiplier = 1.8,        -- 80% more pay
            distanceRange = {600, 900},
        },
    },
    
    -- ═══════════════ TIER SELECTION WEIGHTS ═══════════════
    -- How likely each tier is to appear based on player level bracket
    -- Format: {tier1, tier2, tier3, tier4, tier5} - weights out of 100
    -- Players get VARIETY - even legendary haulers can roll a quick Short Haul
    tierWeights = {
        {maxLevel = 4,   weights = {55, 40, 5, 0, 0}},     -- Greenhorn: mostly easy, rare lucky Long Haul
        {maxLevel = 9,   weights = {20, 40, 35, 5, 0}},     -- Freighter: standard focus, some long hauls
        {maxLevel = 14,  weights = {10, 20, 40, 25, 5}},    -- Teamster: long haul core, extended opening up
        {maxLevel = 19,  weights = {5, 15, 25, 35, 20}},    -- Hauler: extended focus, marathon appearing
        {maxLevel = 24,  weights = {5, 10, 15, 35, 35}},    -- Master: big runs dominate
        {maxLevel = 30,  weights = {5, 5, 10, 30, 50}},     -- Legendary: marathon territory
    },
    
    -- ═══════════════ ILLEGAL MISSION TIER WEIGHTS ═══════════════
    -- Illegal missions have their own weight distribution (generally harder)
    illegalTierWeights = {
        {maxLevel = 19,  weights = {0, 30, 45, 25, 0}},     -- First access: standard-long haul
        {maxLevel = 24,  weights = {0, 10, 25, 40, 25}},    -- Experienced: extended focus
        {maxLevel = 30,  weights = {0, 5, 15, 35, 45}},     -- Veteran: marathon smuggling
    },
    
    -- ═══════════════ PAYMENT SCALING ═══════════════
    -- Level-based bonus applied ON TOP of tier payMultiplier (LEGAL RUNS ONLY)
    -- Illegal runs use FIXED per-crate pricing with NO level scaling
    payScale = {
        baseMultiplier = 1.0,           -- Everyone starts at 1.0x
        perLevelBonus = 0.025,          -- +2.5% per level for tier multiplier (Level 10 = 1.25x, Level 20 = 1.5x, Level 30 = 1.75x)
        maxMultiplier = 1.75,           -- Hard cap at 1.75x
        legalPerLevelFlat = 0.50,       -- +$0.50 per level added to legal run pay (Level 10 = +$5.00, Level 30 = +$15.00)
        
        -- Tier completion bonuses (extra % for completing higher tier missions) - LEGAL ONLY
        tierCompletionBonus = {
            [1] = 0,                    -- Short Haul: no bonus
            [2] = 0.05,                 -- Standard: +5% bonus
            [3] = 0.10,                 -- Long Haul: +10% bonus
            [4] = 0.15,                 -- Extended: +15% bonus
            [5] = 0.25,                 -- Marathon: +25% bonus
        },
    },
    
    -- ═══════════════ RISK SCALING ═══════════════
    -- How risk (ambush chance) scales with level on top of tier ranges
    riskScale = {
        perLevelBonus = 0.5,            -- +0.5% risk per level added to tier base
        maxRiskBonus = 15,              -- Maximum +15% from level scaling
        illegalRiskBonus = 30,          -- Flat +30% risk for illegal missions
        
        -- Ambush enemy scaling per tier
        ambushEnemyScale = {
            [1] = {2, 3},              -- Short Haul: 2-3 enemies
            [2] = {2, 4},              -- Standard: 2-4 enemies
            [3] = {3, 5},              -- Long Haul: 3-5 enemies
            [4] = {4, 6},              -- Extended: 4-6 enemies
            [5] = {5, 8},              -- Marathon: 5-8 enemies
        },
    },
    
    -- ═══════════════ WAGON ACCESS BY LEVEL ═══════════════
    -- Which wagon sizes are available at each level
    wagonAccess = {
        small = 1,                      -- Small carts from level 1
        medium = 3,                     -- Medium wagons from level 3
        large = 8,                      -- Large wagons from level 8
    },
    
    -- ═══════════════ MISSION COUNT ═══════════════
    -- How many missions each foreman offers (always the same, variety comes from tiers)
    missionCounts = {
        legal = 3,                      -- Always 3 legal missions
        illegal = 3,                    -- Always 3 illegal missions (hemp, moonshine, mixed)
    },
    
    -- ═══════════════ ILLEGAL CRATE SCALING ═══════════════
    -- How smuggling crate requirements scale with mission tier
    -- Overrides Config.Requirements min/max when a tier is selected
    illegalCrateScale = {
        [1] = {minCrates = 4, maxCrates = 6},     -- Short Haul: 4-6 crates
        [2] = {minCrates = 5, maxCrates = 8},     -- Standard: 5-8 crates
        [3] = {minCrates = 6, maxCrates = 10},    -- Long Haul: 6-10 crates
        [4] = {minCrates = 8, maxCrates = 12},    -- Extended: 8-12 crates
        [5] = {minCrates = 10, maxCrates = 15},   -- Marathon: 10-15 crates
    },
}

-- ╔═══════════════════════════════════════════════════════════════╗
-- ║                  [AMBUSH] GANG AMBUSH SYSTEM                  ║
-- ╚═══════════════════════════════════════════════════════════════╝

Config.Ambush = {
    enabled = true,
    baseChance = 20,                 -- Base ambush chance multiplier (20 = normal)
    checkInterval = 10000,           -- Check every 10 seconds (ms)
    minDistanceFromStart = 150,      -- Must be 150m from start before ambush possible
    minDistanceFromEnd = 75,         -- Must be 75m from next stop before ambush possible (avoid town ambushes)
    townSafeDistance = 250,          -- Flat distance from any town center where ambushes are blocked (meters)
    despawnDelay = 30000,            -- Cleanup NPCs after 30 seconds (ms)
    
    -- Enemy Count Scaling (based on player/mission level)
    enemyScaling = {
        minEnemies = 2,              -- Minimum enemies at any ambush
        maxEnemies = 8,              -- Maximum enemies at any ambush
        baseEnemies = 3,             -- Base number before level scaling
        enemiesPerLevel = 0.3,       -- Additional enemies per mission level (e.g., level 10 = +3 enemies)
        levelCap = 20                -- Stop scaling after this level
    },
    
    -- Wagon Theft AI Behavior
    wagonTheft = {
        enabled = true,              -- AI will attempt to steal wagon after killing players
        delayAfterKill = 5000,       -- Wait 5 seconds after last player death before stealing
        driveAwayDistance = 500,     -- AI drives wagon 500m away to fail mission
        failMissionOnTheft = true,   -- Mission fails when AI escapes with wagon
        theftMessage = "The gang has stolen your wagon! Mission failed."
    },
    
    -- Escalation Levels (risk-based)
    escalation = {
        low = {
            riskRange = {0, 20},
            ambushChance = 3,            -- 3% per check (checks every 10s)
            gangSize = {2, 3},
            aggressionLevel = 1,
            weaponTier = 1,
            chaseDistance = 600,
            description = "Small opportunistic gang"
        },
        medium = {
            riskRange = {21, 35},
            ambushChance = 5,            -- 5% per check
            gangSize = {3, 4},
            aggressionLevel = 2,
            weaponTier = 2,
            chaseDistance = 800,
            description = "Organized outlaw group"
        },
        high = {
            riskRange = {36, 100},
            ambushChance = 8,            -- 8% per check
            gangSize = {4, 6},
            aggressionLevel = 3,
            weaponTier = 3,
            chaseDistance = 1000,
            description = "Large, well-armed gang"
        },
        illegal = {
            riskRange = {36, 100},
            ambushChance = 15,           -- 15% per check for illegal cargo
            gangSize = {4, 8},
            aggressionLevel = 3,
            weaponTier = 3,
            chaseDistance = 1200,
            description = "Lawmen or rival smugglers"
        }
    },
    
    -- Illegal Cargo Bonuses
    illegalCargoBonus = {
        ambushChanceIncrease = 25,   -- +25% ambush chance
        riskLevelIncrease = 20,      -- +20 risk level
        rewardMultiplier = 1.75      -- 1.75x reward multiplier
    },
    
    -- Escape Mechanics
    escape = {
        enabled = true,
        requiredDistance = 300.0,    -- 300 meters away from gang before escape notification
        requiredTime = 300000,       -- 5 minutes (300 seconds) to fully escape
        checkInterval = 5000         -- Check every 5 seconds
    },
    
    -- Gang NPCs
    gangModels = {
        "g_m_m_unibanditos_01",
        "g_m_m_uniranchers_01",
        "g_m_y_uniexconfeds_02",
        "g_m_o_uniexconfeds_01",
        "mp_g_m_m_unibanditos_01"
    },
    
    -- Gang Horses
    gangHorses = {
        "a_c_horse_mustang_grullodun",
        "a_c_horse_mustang_wildbay",
        "a_c_horse_kentuckysaddle_black",
        "a_c_horse_appaloosa_brownleopard",
        "a_c_horse_americanpaint_tobiano"
    },
    
    -- Mounted Gang Members (for chasing fleeing players)
    mountedGangMembers = {
        enabled = true,
        spawnChance = 40,            -- 40% chance per gang member to spawn mounted
        minMounted = 1,              -- At least 1 mounted if any ambush triggers
        maxMounted = 3,              -- Maximum mounted gang members per ambush
        pursuitDistance = 1000.0,     -- How far mounted gang will chase (meters)
        mountedCombat = true         -- Allow mounted combat
    },
    
    -- Weapons by Tier
    weapons = {
        [1] = {"weapon_revolver_cattleman", "weapon_rifle_varmint"},
        [2] = {"weapon_repeater_carbine", "weapon_revolver_cattleman"},
        [3] = {"weapon_repeater_carbine", "weapon_revolver_schofield", "weapon_shotgun_sawedoff"},
        [4] = {"weapon_repeater_winchester", "weapon_revolver_schofield", "weapon_shotgun_repeating"}
    },
    
    -- Spawn Locations (relative to wagon - further distances feel more like ambush)
    spawnLocations = {
        {
            name = "Roadside Ambush",
            spawnOffsets = {
                vector3(60, 20, 0),    -- Right front
                vector3(60, -20, 0),   -- Right rear
                vector3(-60, 20, 0),   -- Left front
                vector3(-60, -20, 0),  -- Left rear
                vector3(80, 0, 0),     -- Far right
                vector3(-80, 0, 0),    -- Far left
            }
        },
        {
            name = "Hill Ambush",
            spawnOffsets = {
                vector3(50, 50, 5),    -- Front-right hill
                vector3(-50, 50, 5),   -- Front-left hill
                vector3(40, 60, 3),    -- Ahead-right
                vector3(-40, 60, 3),   -- Ahead-left
                vector3(0, 70, 4),     -- Directly ahead
                vector3(30, -50, 2),   -- Behind-right
            }
        },
        {
            name = "Pincer Ambush",
            spawnOffsets = {
                vector3(70, 40, 0),    -- Flanking right-front
                vector3(70, -40, 0),   -- Flanking right-rear
                vector3(-70, 40, 0),   -- Flanking left-front
                vector3(-70, -40, 0),  -- Flanking left-rear
                vector3(0, 80, 0),     -- Blocking ahead
                vector3(0, -60, 0),    -- Chasing from behind
            }
        }
    },
    
    -- Messages
    messages = {
        warning = Locale("m_ambush_warning"),
        start = Locale("m_ambush_start"),
        survived = Locale("m_ambush_survived_msg"),
        wagonStolen = Locale("m_wagon_stolen"),
        gangFled = Locale("m_gang_fled")
    }
}

-- ╔═══════════════════════════════════════════════════════════════╗
-- ║                  [LAW] Law Alert System                       ║
-- ╚═══════════════════════════════════════════════════════════════╝
Config.LawAlerts = {
    enabled = true,                  -- Master toggle for law alert system
    
    -- Inspection Minigame (Minesweep)
    -- When true, law must play a minesweep-style minigame to find evidence
    -- When false, law searches the wagon directly (timed animation, auto-discovers all evidence)
    inspectionMinigame = true,
    
    -- General Settings
    minLawRequirement = 4,           -- Minimum law players online to start smuggling & trigger alerts
    universalJurisdiction = "USMO", -- USMO counts alongside every jurisdiction check
    alertCooldown = 90,             -- Seconds between periodic position updates (fallback interval)
    
    -- Map Circle Alert Settings (shown to law players)
    mapAlert = {
        circleRadius = 150.0,        -- Radius of circle on map (medium, not too big/small)
        duration = 60,               -- How long circle stays on map in seconds (60s)
        blipSprite = "blip_ambient_law", -- Center blip icon
        blipModifier = "BLIP_MODIFIER_MP_COLOR_8", -- Red color
        circleModifier = "BLIP_MODIFIER_MP_COLOR_8", -- Circle color (red)
        playSound = true,            -- Play alert sound on INITIAL alert only
    },
    
    -- Initial Alert Settings (first alert for a wagon, once it leaves foreman area)
    -- Flow: packages loaded → random delay (delayMin-delayMax) → distance gate → alert fires
    initialAlert = {
        minDistanceFromForeman = 100.0, -- Must be this far from foreman before first alert can trigger
        delayMin = 30,               -- Minimum seconds after packages loaded before alert can fire
        delayMax = 90,               -- Maximum seconds after packages loaded for alert to fire
        title = "Smuggling Alert",   -- Title shown in notification
        message = "Suspicious wagon reported in %s territory", -- %s = jurisdiction
    },
    
    -- Position Update Settings (map circle moves when wagon is spotted)
    -- Updates triggered by: NPC witness escape, town proximity, jurisdiction crossing, periodic fallback
    positionUpdateCooldown = 45,     -- Minimum seconds between any two position updates
    
    -- Visual Settings (legacy, kept for backward compat)
    createBlips = true,              -- Create blips for law players
    blipSprite = "blip_ambient_law", -- Blip icon for alerts
    blipName = "Suspicious Activity",
    blipModifier = "BLIP_MODIFIER_MP_COLOR_8", -- Red color
    playSound = true,                -- Play alert sound for law players
    
    -- Alert Triggers (when alerts are sent)
    alertTriggers = {
        -- Alert when illegal mission starts (DISABLED - now uses initialAlert distance gate instead)
        missionStart = {
            enabled = false,         -- Disabled: alerts now fire after wagon leaves foreman area
            chance = 25,
            title = "Suspicious Activity",
            message = "A suspicious wagon has been reported leaving town",
            radius = 100.0,
            duration = 300000
        },
        
        -- Alert when loading illegal packages (DISABLED - no alerts during loading)
        packageLoading = {
            enabled = false,
            chance = 40,
            title = "Illegal Cargo Loading",
            message = "Witnesses report illegal goods being loaded into a wagon",
            radius = 75.0,
            duration = 240000        -- 4 minutes
        },
        
        -- Alert when crossing jurisdiction boundaries
        jurisdictionCrossing = {
            enabled = true,
            chance = 100,            -- 100% chance when crossing (always alert)
            title = "Suspect Crossing Jurisdiction",
            message = "Suspicious wagon spotted entering %s territory",
            radius = 50.0,
            duration = 180000        -- 3 minutes
        },
        
        -- Alert during delivery (periodic chance while traveling)
        travelingWithCargo = {
            enabled = true,
            chance = 15,             -- 15% chance per check
            checkInterval = 30000,   -- Check every 30 seconds
            title = "Suspicious Wagon Sighted",
            message = "A suspicious wagon has been reported in the area",
            radius = 100.0,
            duration = 180000
        },
        
        -- Alert when completing delivery (disabled - not useful)
        deliveryComplete = {
            enabled = false,
            chance = 0,              -- Disabled
            title = "Suspicious Exchange Reported",
            message = "A suspicious exchange has been reported",
            radius = 50.0,
            duration = 120000        -- 2 minutes
        },
        
        -- Alert if player is spotted in town with illegal cargo
        inTownWithCargo = {
            enabled = true,
            chance = 75,             -- 75% chance if in populated area
            title = "Illegal Contraband in Town",
            message = "Citizens report seeing illegal goods in %s",
            radius = 30.0,
            duration = 300000
        },
        
        -- Alert when NPC witnesses smuggling activity (interactive system)
        npcWitness = {
            enabled = true,
            chance = 40,             -- 40% chance when NPC spots wagon
            title = "Witness Report",
            message = "Civilian reported suspicious cargo wagon in the area",
            radius = 200.0,
            duration = 240000,       -- 4 minutes
            cooldown = 60,           -- 60 seconds cooldown to prevent spam from multiple NPCs
            detectionRadius = 50.0,  -- How close NPC must be to spot wagon (meters)
            checkInterval = 5000,    -- Check for NPCs every 5 seconds
            
            -- Grace period and safe zones
            gracePeriod = 30,        -- 30 seconds after mission start before witnesses can detect (gives player time to leave)
            foremanSafeRadius = 50.0, -- Safe zone around foreman location (no witnesses)
            
            -- Interactive witness system
            escapeDistance = 150.0,  -- Distance NPC must travel to successfully report (meters)
            chaseTime = 45,          -- How long to track fleeing NPC (seconds)
            
            -- NPC reactions when spotting illegal cargo
            reactions = {

                mountHorseChance = 30,   -- 30% chance NPC will try to mount nearby horse
                sprintSpeed = 3.0,       -- Sprint speed multiplier
                
                markWitness = true       -- Show blip on fleeing witness
            },
            
            -- Player feedback
            playerNotifications = {
                witnessed = Locale("m_witnessed"),
                fleeing = Locale("m_witness_fleeing"),
                escaped = Locale("m_witness_escaped"),
                silenced = Locale("m_witness_silenced")
            }
        }
    },
    
    -- Jurisdictions (law enforcement territories)
    -- To add jurisdiction: copy a section and modify lawJobs and zones
    jurisdictions = {
        ["LSO"] = {
            name = "Lemoyne Sheriff's Office",
            lawJobs = {"LSO"},
            zones = {
                -- Saint Denis (radius)
                {type = "radius", center = vector3(2635.0, -1300.0, 52.0), radius = 500.0},
                -- Rhodes (radius)
                {type = "radius", center = vector3(1360.0, -1300.0, 77.0), radius = 300.0},
                -- Lemoyne region (box)
                {type = "box", min = vector3(1000.0, -2000.0, 0.0), max = vector3(3000.0, -500.0, 300.0)}
            }
        },
        
        ["NHSO"] = {
            name = "New Hanover Sheriff's Office",
            lawJobs = {"NHSO"},
            zones = {
                -- Valentine (radius)
                {type = "radius", center = vector3(-180.0, 627.0, 114.0), radius = 400.0},
                -- Emerald Ranch (radius)
                {type = "radius", center = vector3(1400.0, 380.0, 90.0), radius = 250.0},
                -- Van Horn (radius)
                {type = "radius", center = vector3(2975.0, 570.0, 44.0), radius = 300.0},
                -- New Hanover region (box)
                {type = "box", min = vector3(-800.0, -400.0, 0.0), max = vector3(3200.0, 1500.0, 300.0)}
            }
        },
        
        ["WESO"] = {
            name = "West Elizabeth Sheriff's Office",
            lawJobs = {"WESO"},
            zones = {
                -- Strawberry (radius)
                {type = "radius", center = vector3(-1791.0, -592.0, 158.0), radius = 300.0},
                -- Blackwater (radius)
                {type = "radius", center = vector3(-813.0, -1324.0, 43.0), radius = 400.0},
                -- West Elizabeth region (box)
                {type = "box", min = vector3(-2500.0, -2000.0, 0.0), max = vector3(-200.0, 500.0, 300.0)}
            }
        },
        
        ["NARO"] = {
            name = "New Austin Rangers Office",
            lawJobs = {"NARO"},
            zones = {
                -- Tumbleweed (radius)
                {type = "radius", center = vector3(-5512.0, -2950.0, -2.0), radius = 300.0},
                -- Armadillo (radius)
                {type = "radius", center = vector3(-3685.0, -2593.0, -13.0), radius = 300.0},
                -- New Austin region (box)
                {type = "box", min = vector3(-6000.0, -3500.0, -50.0), max = vector3(-2000.0, -1500.0, 300.0)}
            }
        },
        
        ["USMO"] = {
            name = "US Marshals Office",
            lawJobs = {"USMO"},
            zones = {
                -- Federal jurisdiction (covers all areas)
                {type = "box", min = vector3(-6000.0, -3500.0, -50.0), max = vector3(3500.0, 2000.0, 300.0)}
            }
        }
    },
    
    -- Enhanced Features
    features = {
        -- Witness system (higher chance in populated areas)
        witnessSystem = {
            enabled = true,
            townAlertMultiplier = 2.0,   -- 2x alert chance in towns
            dayAlertMultiplier = 1.5,    -- 1.5x alert chance during day
            nightAlertMultiplier = 0.75  -- 0.75x alert chance at night
        },
        
        -- Escalation system (repeated offenses increase alert chance)
        escalation = {
            enabled = true,
            chanceIncreasePerOffense = 10, -- +10% per previous offense
            maxChanceIncrease = 50,        -- Max +50% increase
            resetTime = 3600               -- Reset after 1 hour
        },
        
        -- Multiple jurisdiction alerts
        multiJurisdictionAlerts = {
            enabled = true,
            alertAllJurisdictions = false, -- Alert all jurisdictions or just current
            alertAdjacentJurisdictions = true -- Alert neighboring jurisdictions
        }
    },
    
    -- Messages
    messages = {
        lawAlertReceived = Locale("m_law_alert_received"),
        notEnoughLaw = Locale("m_not_enough_law"),
        jurisdictionCrossed = Locale("m_jurisdiction_crossed"),
        lawNearby = Locale("m_law_nearby")
    },
    
    -- Law Office Evidence Drop-off Locations
    -- Where law can bring seized smuggling wagons to confiscate evidence
    lawOfficeDropoffs = {
        ["NARO"] = {
            label = "New Austin Rangers Office",
            coords = vector3(-3624.323, -2601.270, -13.393),
            radius = 100.0 -- How close the wagon needs to be to unload
        },
        ["WESO"] = {
            label = "West Elizabeth Sheriff's Office",
            coords = vector3(-766.232, -1271.825, 44.001),
            radius = 100.0
        },
        ["NHSO"] = {
            label = "New Hanover Sheriff's Office",
            coords = vector3(-277.406, 809.859, 119.330),
            radius = 100.0
        },
        ["LSO"] = {
            label = "Lemoyne Sheriff's Office",
            coords = vector3(2486.081, -1302.546, 48.777),
            radius = 100.0
        }
    }
}

-- ╔═══════════════════════════════════════════════════════════════╗
-- ║              [LOCATIONS] FOREMAN & DROPOFF LOCATIONS          ║
-- ╚═══════════════════════════════════════════════════════════════╝

Config.Locations = {
    -- ═══════════════ FOREMAN LOCATIONS ═══════════════
    foremen = {
        {
            id = "annesburg_smuggler",
            label = "Annesburg Foreman",
            description = "A delivery foreman handling goods transport",
            jurisdiction = "NHSO",
            npc = {
                model = "cs_creoleguy",
                coords = vector4(2875.68, 1359.78, 61.48, 143.32),
                scenario = "WORLD_HUMAN_CLIPBOARD",
                idleScenarios = {"WORLD_HUMAN_CLIPBOARD"}
            },
            wagonSpawn = vector4(2870.0, 1360.0, 62.0, 143.32),
            packageSpawn = vector4(2871.27, 1368.33, 62.64, 162.25),
            region = "new_hanover_region"
        },
        {
            id = "saint_denis_smuggler",
            label = "Saint Denis Foreman",
            jurisdiction = "LSO",
            npc = {
                model = "cs_mp_jeremiah_shaw",
                coords = vector4(2602.1404, -931.7067, 41.1613, 298.1486),
                scenario = "WORLD_HUMAN_WRITE_NOTEBOOK",
                idleScenarios = {"WORLD_HUMAN_WRITE_NOTEBOOK"}
            },
            wagonSpawn = vector4(2597.75, -911.45, 42.14, 90.0),
            packageSpawn = vector4(2597.94, -918.49, 42.09, 90.0),
            region = "saint_denis_region"
        },
        {
            id = "strawberry_smuggler",
            label = "Strawberry Foreman",
            jurisdiction = "WESO",
            npc = {
                model = "cs_mp_mradler",
                coords = vector4(-1831.90185546875, -596.9674072265625, 153.51, 294.75),
                scenario = "WORLD_HUMAN_LEAN_BACK_WALL",
                idleScenarios = {"WORLD_HUMAN_LEAN_BACK_WALL"}
            },
            wagonSpawn = vector4(-1821.3, -604.1, 154.46, 291.74),
            packageSpawn = vector4(-1822.38, -610.14, 154.51, 271.33),
            region = "strawberry_region"
        },
        {
            id = "tumbleweed_smuggler",
            label = "Tumbleweed Foreman",
            jurisdiction = "NARO",
            npc = {
                model = "cs_mp_alfredo_montez",
                coords = vector4(-5424.35, -2979.26, 8.3, 297.84),
                scenario = "WORLD_HUMAN_SMOKE_CIGAR",
                idleScenarios = {"WORLD_HUMAN_SMOKE_CIGAR"}
            },
            wagonSpawn = vector4(-5410.08, -2975.89, 9.71, 87.06),
            packageSpawn = vector4(-5410.93, -2979.84, 10.14, 77.79),
            region = "tumbleweed_region"
        }
    },
    
    -- ═══════════════ DROPOFF LOCATIONS ═══════════════
    dropoffs = {
        enabled = true,
        minDistance = 200,           -- Minimum distance for dropoff
        maxDistance = 6000,          -- Maximum distance for dropoff
        
        -- Routing
        routing = {
            maxStopsPerRun = 6,              -- Max stops (can be limited by player level)
            minDistanceBetweenStops = 200,   -- Min 200m between stops
            maxDistanceBetweenStops = 1500   -- Max 1500m between stops
        },
        
        -- Type Weights (higher = more likely)
        typeWeights = {
            warehouse = 30,
            dock = 25,
            industrial = 22,
            ranch = 20,
            business = 15,
            hideout = 12,
            barn = 10,
            camp = 8,
            cabin = 6
        },
        
        -- Location Pools by Region
        pools = {
            new_hanover_region = {
                {name = "Electrical Tower", coords = vector3(2502.3501, 2288.9604, 176.6050), heading = 349.5996, type = "industrial", weight = 10},
                {name = "Creek Trapper", coords = vector3(2080.6909, 1011.2450, 113.5019), heading = 105.2755, type = "business", weight = 8},
                {name = "Butchers Creek House", coords = vector3(2589.8037, 786.9436, 82.4812), heading = 75.6122, type = "cabin", weight = 6},
                {name = "VanHorn Depot", coords = vector3(2983.2454, 584.8481, 44.2026), heading = 262.5621, type = "warehouse", weight = 12},
                {name = "New Hanover Survival Shack", coords = vector3(2017.0464, 629.1309, 158.7210), heading = 51.9821, type = "hideout", weight = 7},
                {name = "New Hanover Outlaw Outpost", coords = vector3(-34.7538, 1217.2278, 172.8414), heading = 158.3566, type = "camp", weight = 8},
                {name = "Flatneck Station", coords = vector3(-324.7462, -353.0424, 88.0421), heading = 175.8912, type = "business", weight = 8},
                {name = "O'Creagh's Run House", coords = vector3(1702.5083, 1505.7845, 147.1438), heading = 291.6048, type = "cabin", weight = 6},
                {name = "Bacchus Train Station", coords = vector3(587.9743, 1680.0526, 187.7206), heading = 52.4226, type = "business", weight = 8},
                {name = "Annesburg Dock", coords = vector3(2985.5684, 1338.1813, 44.1658), heading = 277.9824, type = "dock", weight = 10},
                {name = "Big House Near VanHorn", coords = vector3(2831.0195, 275.3092, 48.1271), heading = 181.6325, type = "cabin", weight = 6},
                {name = "House Outback Of Valentine", coords = vector3(-276.8384, 914.5234, 128.0706), heading = 44.4097, type = "cabin", weight = 6},
                {name = "Emerald Station", coords = vector3(1518.7517, 446.0554, 90.7307), heading = 237.0623, type = "business", weight = 8},
                {name = "Roanoke Valley House", coords = vector3(2627.3555, 1688.3186, 115.4767), heading = 38.0558, type = "cabin", weight = 6},
                {name = "Outskirts VanHorn House", coords = vector3(2776.1484, 532.2252, 68.1690), heading = 66.1085, type = "cabin", weight = 6},
                {name = "Outskirts Butchers Creek House", coords = vector3(2692.6501, 896.8845, 91.9977), heading = 36.9424, type = "cabin", weight = 6},
                {name = "The Abandoned Rest", coords = vector3(362.08, -9.45, 104.76), heading = 0.0, type = "cabin", weight = 6},
                {name = "Flatneck Station Chicken House", coords = vector3(-74.74, -397.67, 71.62), heading = 0.0, type = "business", weight = 6}
            },
            strawberry_region = {
                {name = "Deadend Road", coords = vector3(-2431.52, -1001.01, 168.15), heading = 0.0, type = "hideout", weight = 7},
                {name = "Cats Got Your Tongue Shack", coords = vector3(-1093.1, 701.04, 104.21), heading = 0.0, type = "cabin", weight = 6},
                {name = "Shack North West of Little Creek", coords = vector3(-2463.481, 837.041, 142.637), heading = 0.0, type = "cabin", weight = 6},
                {name = "Aurora Basin", coords = vector3(-2578.425, -1376.733, 149.342), heading = 0.0, type = "hideout", weight = 8},
                {name = "Lost Ring Camp", coords = vector3(-1486.119, -766.100, 104.628), heading = 0.0, type = "camp", weight = 8},
                {name = "Shooter's Old Ranch", coords = vector3(-607.581, -42.216, 84.954), heading = 0.0, type = "ranch", weight = 8},
                {name = "Brotherly Camp", coords = vector3(-403.910, 1723.786, 215.950), heading = 0.0, type = "camp", weight = 8},
                {name = "Torture Shack", coords = vector3(-868.381, -743.870, 59.531), heading = 0.0, type = "hideout", weight = 7},
                {name = "Quaker's Cove", coords = vector3(-1203.644, -1944.972, 43.232), heading = 0.0, type = "dock", weight = 9},
                {name = "Mercy's Shack", coords = vector3(-2036.241, -1903.333, 110.130), heading = 0.0, type = "cabin", weight = 6},
                {name = "Blackwater's Mill", coords = vector3(-1063.575, -1646.296, 77.372), heading = 0.0, type = "industrial", weight = 8},
                {name = "Sacred Tree", coords = vector3(-1385.653, -1400.731, 94.459), heading = 0.0, type = "hideout", weight = 7},
                {name = "Wallace Station", coords = vector3(-1292.751, 394.748, 95.077), heading = 0.0, type = "business", weight = 8}
            },
            saint_denis_region = {
                {name = "Saint Denis Docks Warehouse", coords = vector3(2814.435, -1397.863, 45.344), heading = 0.0, type = "warehouse", weight = 12},
                {name = "Calliga Hall Shipping Dock", coords = vector3(1852.384, -1226.174, 42.360), heading = 0.0, type = "dock", weight = 10},
                {name = "Braithwaite Den", coords = vector3(1384.816, -2081.330, 52.017), heading = 0.0, type = "hideout", weight = 9},
                {name = "Braithwaite Stable", coords = vector3(976.600, -2017.342, 48.795), heading = 0.0, type = "business", weight = 8},
                {name = "Braithwaite Farmhand Houses", coords = vector3(852.925, -1920.240, 44.005), heading = 0.0, type = "cabin", weight = 6},
                {name = "Lakay Swamp", coords = vector3(2238.73, -767.93, 43.41), heading = 0.0, type = "hideout", weight = 7},
                {name = "Road to Sisika", coords = vector3(2879.225, -253.994, 42.488), heading = 0.0, type = "hideout", weight = 7},
                {name = "Shady Bell", coords = vector3(1899.311, -1896.625, 42.169), heading = 0.0, type = "hideout", weight = 8},
                {name = "Plagued Town", coords = vector3(1710.061, -388.152, 49.514), heading = 0.0, type = "cabin", weight = 6},
                {name = "Stinky House", coords = vector3(1809.492, -73.867, 56.423), heading = 0.0, type = "cabin", weight = 6},
                {name = "Burnt House", coords = vector3(1263.246, -412.078, 97.573), heading = 0.0, type = "cabin", weight = 6},
                {name = "Run Down Shack", coords = vector3(763.805, -853.208, 55.270), heading = 0.0, type = "cabin", weight = 6},
                {name = "Good Times Camp", coords = vector3(655.044, -1246.928, 43.621), heading = 0.0, type = "camp", weight = 8},
                {name = "Damned Shack", coords = vector3(2106.135, -294.435, 41.602), heading = 0.0, type = "cabin", weight = 6},
                {name = "Old Miner's Dream", coords = vector3(725.306, -460.917, 79.260), heading = 0.0, type = "industrial", weight = 8},
                {name = "Railway Warehouse", coords = vector3(2348.001, -1426.753, 45.483), heading = 0.0, type = "warehouse", weight = 10},
                {name = "Moving Camp", coords = vector3(1420.304, -1143.561, 75.058), heading = 0.0, type = "camp", weight = 8}
            },
            tumbleweed_region = {
                {name = "Twin Rocks", coords = vector3(-4414.118, -2202.875, 39.354), heading = 0.0, type = "hideout", weight = 8},
                {name = "Burnt Down Project", coords = vector3(-3845.07, -3010.79, -6.87), heading = 0.0, type = "industrial", weight = 6},
                {name = "Fort Mercer", coords = vector3(-4217.92, -3510.22, 37.09), heading = 0.0, type = "hideout", weight = 9},
                {name = "Tumbleweed Cave", coords = vector3(-5879.62, -2755.02, -4.11), heading = 0.0, type = "hideout", weight = 10},
                {name = "Gaptooth Mine", coords = vector3(-5999.05, -3130.53, -1.57), heading = 0.0, type = "industrial", weight = 7},
                {name = "San Luis River West", coords = vector3(-6449.19, -3536.19, -25.3), heading = 0.0, type = "hideout", weight = 8},
                {name = "Hennigans Stead", coords = vector3(-2707.61, -2366.49, 45.87), heading = 0.0, type = "cabin", weight = 6},
                {name = "Sages Depression Tree", coords = vector3(-3455.35, -2264.39, 0.92), heading = 0.0, type = "hideout", weight = 7},
                {name = "Plainview Camp", coords = vector3(-4691.25, -3754.04, 13.01), heading = 0.0, type = "camp", weight = 8},
                {name = "San Luis Fishmonger", coords = vector3(-2025.021, -3028.880, -10.158), heading = 0.0, type = "dock", weight = 8},
                {name = "Thieves Landing", coords = vector3(-1417.035, -2332.135, 43.006), heading = 0.0, type = "hideout", weight = 9},
                {name = "Old Ranch", coords = vector3(-3552.431, -3045.615, 11.895), heading = 0.0, type = "ranch", weight = 8},
                {name = "Armadillo Church", coords = vector3(-3318.831, -2848.857, -6.139), heading = 0.0, type = "business", weight = 7},
                {name = "Twin Rocks Camp", coords = vector3(-3960.031, -2151.277, -5.617), heading = 0.0, type = "camp", weight = 8},
                {name = "The Old Shack", coords = vector3(-4367.146, -2421.543, 19.803), heading = 0.0, type = "cabin", weight = 6},
                {name = "Rathskeller Fork", coords = vector3(-5201.435, -2110.938, 12.336), heading = 0.0, type = "business", weight = 8},
                {name = "Lake Don Julio Shack", coords = vector3(-3403.736, -3297.647, -5.336), heading = 0.0, type = "cabin", weight = 6},
                {name = "Where Ends Meet Port", coords = vector3(-1416.352, -2676.029, 42.172), heading = 0.0, type = "dock", weight = 9},
                {name = "Finger Point", coords = vector3(-5227.571, -3484.971, -20.576), heading = 0.0, type = "hideout", weight = 7},
                {name = "The Lost Shack", coords = vector3(-5843.375, -3742.470, -25.280), heading = 0.0, type = "cabin", weight = 6}
            }
        },
        
        -- ═══════════════ TOWN DEFINITIONS (for witness system) ═══════════════
        towns = {
            {name = "Valentine", center = vector3(-180.0, 627.0, 114.0), radius = 200.0, witnessMultiplier = 2.0},
            {name = "Saint Denis", center = vector3(2635.0, -1300.0, 52.0), radius = 400.0, witnessMultiplier = 2.5},
            {name = "Rhodes", center = vector3(1360.0, -1300.0, 77.0), radius = 150.0, witnessMultiplier = 1.8},
            {name = "Strawberry", center = vector3(-1791.0, -592.0, 158.0), radius = 120.0, witnessMultiplier = 1.7},
            {name = "Blackwater", center = vector3(-813.0, -1324.0, 43.0), radius = 180.0, witnessMultiplier = 2.0},
            {name = "Tumbleweed", center = vector3(-5512.0, -2950.0, -2.0), radius = 100.0, witnessMultiplier = 1.5},
            {name = "Armadillo", center = vector3(-3685.0, -2593.0, -13.0), radius = 120.0, witnessMultiplier = 1.6},
            {name = "Van Horn", center = vector3(2975.0, 570.0, 44.0), radius = 130.0, witnessMultiplier = 1.7},
            {name = "Annesburg", center = vector3(2934.0, 1289.0, 44.0), radius = 110.0, witnessMultiplier = 1.6},
            {name = "Emerald Ranch", center = vector3(1424.0, 340.0, 88.0), radius = 90.0, witnessMultiplier = 1.5},
            {name = "Lagras", center = vector3(2143.0, -561.0, 41.0), radius = 80.0, witnessMultiplier = 1.4}
        }
    }
}



-- ╔═══════════════════════════════════════════════════════════════════════════════╗
-- ║                    LEGACY COMPATIBILITY DO NOT MODIFY                         ║
-- ╚═══════════════════════════════════════════════════════════════════════════════╝
-- These mappings maintain backward compatibility with existing code DO NOT MODIFY

Config.Debug = Config.Core.debug
Config.Framework = Config.Core.framework
Config.Interact = Config.Core.interactionSystem
Config.DistanceSpawn = Config.Core.npcSpawnDistance
Config.InteractionDistance = Config.Core.interactionDistance
Config.Blip = Config.UI.npcBlip
Config.EntityBlips = Config.UI.entityBlips
Config.PackageSystem = {
    enabled = Config.PackageSystem.enabled,
    wagonCapacity = Config.PackageSystem.wagonCapacity,
    sharedWagonAccess = Config.PackageSystem.sharedWagonAccess,
    checkInventoryLimits = Config.PackageSystem.checkInventoryLimits,
    maxWagonDeliveryDistance = Config.PackageSystem.maxWagonDeliveryDistance,
    wagonWhitelist = Config.PackageSystem.wagonWhitelist,
    models = Config.PackageSystem.models,
    cargoPresets = Config.PackageSystem.cargoPresets
}
Config.SmuggleWagons = Config.Wagons.types
Config.MissionRequirements = {
    enabled = Config.Requirements.enabled,
    requirementsByPreset = Config.Requirements.byPreset,
    messages = Config.Requirements.messages,
    -- Pass through smuggling-specific settings for server-side use
    crateItemName = Config.Requirements.crateItemName,
    crateItemLabel = Config.Requirements.crateItemLabel,
    hemp = Config.Requirements.hemp,
    moonshine = Config.Requirements.moonshine,
    mixed = Config.Requirements.mixed
}
Config.GangAmbush = {
    enabled = Config.Ambush.enabled,
    chance = Config.Ambush.baseChance,
    checkInterval = Config.Ambush.checkInterval,
    minDistance = Config.Ambush.minDistanceFromStart,
    maxDistance = Config.Ambush.minDistanceFromEnd,
    gangSize = {3, 5},
    despawnTime = Config.Ambush.despawnDelay,
    escalationLevels = Config.Ambush.escalation,
    illegalCargoBonus = Config.Ambush.illegalCargoBonus,
    escapeTracking = Config.Ambush.escape,
    wagonTheft = Config.Ambush.wagonTheft,
    gangModels = Config.Ambush.gangModels,
    gangHorses = Config.Ambush.gangHorses,
    weaponTiers = Config.Ambush.weapons,
    locations = Config.Ambush.spawnLocations,
    survivalRewards = {
        bonusMoney = Config.Rewards.ambushSurvivalBonus.moneyBonus,
        bonusItems = Config.Rewards.ambushSurvivalBonus.itemDrops
    },
    messages = Config.Ambush.messages
}
Config.DynamicDropoffs = {
    enabled = Config.Locations.dropoffs.enabled,
    minDistance = Config.Locations.dropoffs.minDistance,
    maxDistance = Config.Locations.dropoffs.maxDistance,
    routing = Config.Locations.dropoffs.routing,
    typeWeights = Config.Locations.dropoffs.typeWeights,
    locationPools = Config.Locations.dropoffs.pools
}
Config.TimeRestrictions = {
    legalHours = Config.MissionAvailability.legalHours,
    illegalHours = Config.MissionAvailability.illegalHours,
    legalWarningMessage = Config.MissionAvailability.messages.legalUnavailable,
    illegalWarningMessage = Config.MissionAvailability.messages.illegalUnavailable,
    legalCompletionMessages = {"\"Good work! Here's your payment.\"", "\"Pleasure doing business with you.\""},
    illegalCompletionMessages = {"\"Hurry up! Let's get this done before people start asking questions.\"", "\"You're cutting it close with the daylight.\""},
    legalNoJobsMessage = Config.MissionAvailability.messages.legalUnavailable,
    illegalNoJobsMessage = Config.MissionAvailability.messages.illegalUnavailable,
    illegalJobsLockedMessage = Config.MissionAvailability.messages.illegalLocked
}
Config.Alerts = {
    enable = Config.LawAlerts.enabled,
    chance = Config.LawAlerts.alertTriggers.missionStart.chance
}
Config.RiskLevel = Config.DynamicRuns.baseRiskLevel
Config.SmuggleLocations = Config.Locations.foremen
Config.packageIcons = {"delivery_package_small", "delivery_package_medium", "delivery_package_large", "delivery_package_big"}

-- ╔═══════════════════════════════════════════════════════════════╗
-- ║                         END OF CONFIG                         ║
-- ╚═══════════════════════════════════════════════════════════════╝
