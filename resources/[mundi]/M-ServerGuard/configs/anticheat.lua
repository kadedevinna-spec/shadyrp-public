MGuard.AntiCheat = {
    Enabled = true,

    -- Teleport detection: max distance (coords) per 1-second tick
    -- RDR2 fastest horse at full gallop covers ~15 units/sec. 150 leaves huge buffer for lag.
    TeleportThreshold = 150.0,
    TeleportCooldown = 5, -- seconds before rechecking after a legitimate teleport

    -- On-foot speed hack (m/s). Measured RDR2 values:
    --   Walk ~1.5  |  Run ~4.5  |  Sprint ~7.5
    -- Threshold: 12.0 gives a 60% buffer above sprint for network jitter.
    MaxPlayerSpeed = 12.0,

    -- Mount (horse) speed hack (m/s). Measured RDR2 values:
    --   Walk ~2.5  |  Trot ~5  |  Canter ~8  |  Gallop ~14-16
    -- Threshold: 22.0 covers even the fastest racing horses with lag buffer.
    MaxMountSpeed = 22.0,

    -- Wagon / vehicle speed hack (m/s). Wagons top out around 10-12 m/s.
    -- 18.0 is generous even for steep downhill + lag.
    MaxVehicleSpeed = 18.0,

    -- God mode detection: check interval (seconds)
    GodModeCheckInterval = 30,

    -- Health anomaly: if player takes lethal damage but doesn't die
    HealthAnomalyThreshold = 3, -- consecutive anomalies before flagging

    -- Explosion spam: max explosions per minute from one player
    ExplosionSpamThreshold = 5,

    -- Event spam: max events per second from one source
    EventSpamThreshold = 50,
    EventSpamWindow = 5, -- seconds

    -- Money anomaly: flag if money changes by more than this without a tracked source
    MoneyAnomalyThreshold = 500,
    GoldAnomalyThreshold = 50,

    -- Item anomaly: flag if items appear without tracked source
    ItemSpawnDetection = true,

    -- Weapon spawn detection: flag if player acquires too many weapons rapidly
    WeaponSpawnThreshold = 5, -- max new weapons in 60 seconds

    -- Entity spawn spam detection
    -- Maximum entities a single player may spawn per window (rolling, in seconds).
    -- Exceeding any limit triggers EntitySpam detection.
    EntitySpawnLimits = {
        Enabled  = true,
        Peds     = 8,    -- scripted NPC spawns per window
        Vehicles = 4,    -- vehicle spawns per window
        Objects  = 15,   -- object/prop spawns per window
        Window   = 60,   -- rolling window in seconds
    },

    -- Model change detection: flag rapid ped model changes
    ModelChangeThreshold = 3, -- max model changes in 2 minutes

    -- Kill streak: rapid kills in a rolling window (combat triage / cheat aimbot)
    -- Normal PvP: 1-2 kills per fight. 6 kills in 5 min = suspicious.
    KillStreakThreshold = 6,
    KillStreakWindow = 300, -- seconds (5 minutes)

    -- Blacklisted events (events that should never come from clients)
    -- Add any server-only events from your installed scripts here
    BlacklistedEvents = {},

    -- Chat input filter (Lua string patterns — not PCRE regex)
    -- Messages matching any pattern are flagged in the chat log and reported.
    -- Set ChatFilterEnabled = false to disable blocking (still logs).
    ChatFilterEnabled = true,
    ChatFilterPatterns = {
        "drop%s+table",
        "select%s+%*%s+from",
        "insert%s+into",
        "or%s+1%s*=%s*1",
        "^/rcon",
        "^/noclip",
        "^/godmode",
        "^/money%s",
        "^/additem%s",
        "^/tpm%s",
    },

    -- Blacklisted weapons (native hashes — auto-removed from players if detected)
    -- These are story/NPC-only weapons that no legitimate MP player can obtain.
    -- Hashes verified against rdr3_discoveries-master/weapons/weapons.lua
    BlacklistedWeapons = {
        -- ── NPC character knives (story-only, never in any shop or loot table) ──
        0x14D3F94D, -- weapon_melee_knife_vampire      (vampire story quest)
        0xF79190B4, -- weapon_melee_broken_sword       (story fragment)
        0xDA54DD53, -- weapon_melee_knife_civil_war    (civil war relic)
        0x2BC12CDA, -- weapon_melee_knife_bear         (NPC Bear's knife)
        0x2C8DBB17, -- weapon_melee_knife_dutch        (Dutch's knife)
        0xE9245D38, -- weapon_melee_knife_micah        (Micah's knife)
        0xCE3C31A4, -- weapon_melee_knife_bill         (Bill's knife)
        0xFA66468E, -- weapon_melee_knife_javier       (Javier's knife)
        0xCACE760E, -- weapon_melee_knife_hosea        (Hosea's knife)
        0xB4774D3D, -- weapon_melee_knife_charles      (Charles's knife)
        0x2F3ECD37, -- weapon_melee_knife_kieran       (Kieran's knife)
        0x46E97B10, -- weapon_melee_knife_uncle        (Uncle's knife)
        0x9DD839AE, -- weapon_melee_knife_lenny        (Lenny's knife)
        0xAF5EEF08, -- weapon_melee_knife_sadie        (Sadie's knife)
        0x64514239, -- weapon_melee_knife_sean         (Sean's knife)
        0x1D7D0737, -- weapon_melee_knife_john         (John's knife)
        0x0C45B2DE, -- weapon_melee_knife_miner        (miner story knife)
        -- ── NPC character-specific firearms ──
        0x02300C65, -- weapon_revolver_doubleaction_micah
        0x00D427AD, -- weapon_revolver_doubleaction_micah_dualwield
        0xFA4B2D47, -- weapon_revolver_schofield_dutch
        0xD44A5A04, -- weapon_revolver_schofield_dutch_dualwield
        0x0247E783, -- weapon_revolver_schofield_calloway
        0x23C706CD, -- weapon_revolver_doubleaction_exotic
        0xF5E4207F, -- weapon_revolver_cattleman_pig   (cursed pig farmer weapon)
        0xE195D259, -- weapon_revolver_schofield_golden (story mission only)
        0xBE76397C, -- weapon_repeater_winchester_john
        0x7BD9C820, -- weapon_repeater_carbine_sadie
        0xD853C801, -- weapon_rifle_boltaction_bill
        0x8BA6AF0A, -- weapon_shotgun_doublebarrel_uncle
        0xFD9B510B, -- weapon_shotgun_semiauto_hosea
        0x21556EC2, -- weapon_sniperrifle_rollingblock_lenny
        0x4E328256, -- weapon_sniperrifle_rollingblock_exotic
        -- ── Story-only hatchets / collectibles ──
        0x076D4FAB, -- weapon_melee_hatchet_meleeonly  (NPC melee-only hatchet)
        0x21CCCA44, -- weapon_melee_ancient_hatchet    (ancient burial site collectible)
        0x74DC40ED, -- weapon_melee_hatchet_viking     (viking relic collectible)
        0x8F0FDE0E, -- weapon_melee_hatchet_double_bit_rusted
        0xE470B7AD, -- weapon_melee_hatchet_hunter_rusted
        -- ── NPC lanterns used as melee ──
        0xF62FB3A3, -- weapon_melee_lantern            (NPC melee lantern)
        0x3155643F, -- weapon_melee_lantern_electric
        -- ── Optional: throw weapons (uncomment to ban on your server) ──
        -- 0x73D8BA0A, -- weapon_thrown_dynamite
        -- 0x7BC4CDDC, -- weapon_thrown_molotov        (fire bottle)
        -- 0x5EF9FEC4, -- weapon_thrown_fire_bottle
        -- 0x7F21BFE2, -- weapon_thrown_poison_bottle
    },

    -- Blacklisted ammo types (hashes from rdr3_discoveries ammo_types.lua)
    -- These ammo types are auto-removed and reported on detection.
    BlacklistedAmmo = {
        -- ── Explosive projectiles ──
        0x6D926443, -- AMMO_RIFLE_EXPRESS_EXPLOSIVE
        0xBFCB2621, -- AMMO_SHOTGUN_BUCKSHOT_INCENDIARY
        0x2314B32A, -- AMMO_SHOTGUN_SLUG_EXPLOSIVE
        0xC1F57A79, -- AMMO_ARROW_DYNAMITE
        0x1C9D6E9D, -- AMMO_DYNAMITE
        0x321BA159, -- AMMO_DYNAMITE_VOLATILE
        0x5633F9D5, -- AMMO_MOLOTOV
        0x886C55D7, -- AMMO_MOLOTOV_VOLATILE
        0x46A648C2, -- AMMO_PISTOL_EXPRESS_EXPLOSIVE
        0x9C8B6796, -- AMMO_REPEATER_EXPRESS_EXPLOSIVE
        0x04A8EFBB, -- AMMO_REVOLVER_EXPRESS_EXPLOSIVE
        -- ── Vehicle/turret ammo — impossible for any player weapon ──
        0xB6976AA1, -- AMMO_CANNON
        0xBA2D509B, -- AMMO_TURRET
        -- ── Fire weapon ammo ──
        0x631C84FC, -- AMMO_MOONSHINEJUG
        0x656A2F3B, -- AMMO_MOONSHINEJUG_MP
        -- ── Impossible supernatural ammo ──
        0xABD7C401, -- AMMO_TOMAHAWK_HOMING
    },

    -- Weapons exempt from ammo type checks
    -- Bow uses many arrow subtypes legitimately; unarmed/lasso have no meaningful ammo
    AmmoWeaponWhitelist = {
        0xFDB8920D, -- WEAPON_BOW
        0x3B4D0B77, -- WEAPON_BOW_IMPROVED
        0x3B2B2E9A, -- WEAPON_LASSO
        0x6297E2A6, -- WEAPON_LASSO_REINFORCED
        0x397EB566, -- WEAPON_UNARMED
    },

    -- Ammo count hack: flag if any weapon has an impossibly large reserve
    -- Cheaters commonly set themselves to 999999 ammo via menu
    AmmoHackDetection = true,
    AmmoHackThreshold = 9999, -- flag if reserve ammo for any single weapon exceeds this

    -- Whitelist legitimate teleport sources (resource names that may teleport players)
    TeleportWhitelist = {
        'vorp_core', 'rsg-core', 'spawnmanager', 'vorp_character',
        'rsg-appearance', 'vorp_admin', 'rsg-adminmenu',
    },

    -- Blacklisted ped models (cheaters changing into animals/story NPCs)
    BlacklistedModels = {
        -- ── Dangerous animals (can grief/kill other players) ──
        'a_c_bear_01', 'a_c_bearblack_01', 'a_c_wolf', 'a_c_panther_01',
        'a_c_cougar_01', 'a_c_alligator_01', 'a_c_alligator_02', 'a_c_alligator_03',
        'a_c_buffalo_01', 'a_c_elk_01', 'a_c_moose_01', 'a_c_boar_01',
        'a_c_coyote_01', 'a_c_snake_01',
        -- Legendary variants (harder to kill, often spawned by cheaters)
        'a_c_boarlegendary_01', 'a_c_buffalo_tatanka_01',
        -- ── Story NPCs (spoofing their identity is a griefing tool) ──
        'cs_dutch', 'cs_micahbell', 'cs_billwilliamson', 'cs_javierescuella',
        'cs_lenny', 'cs_kieranduffy', 'cs_seanmacguire', 'cs_hoseamatthews',
        'cs_josiahtrelawny', 'cs_sadieadler', 'cs_charlessmith', 'cs_johnmarston',
        'cs_uncle', 'cs_arthurmorgan',
        -- Additional antagonist / cutscene NPCs
        'cs_colm', 'cs_bronte', 'cs_leviticus_cornwall',
        'cs_andreaborarquez', 'cs_abigailroberts', 'cs_maribethmasoson',
        'cs_cleet', 'cs_joe', 'cs_prisonguard',
    },

    -- Blacklisted vehicle models (military/overpowered/impossible for players)
    BlacklistedVehicles = {
        -- Gatling guns and turrets
        'gatlinggun', 'gatlingmaxim02', 'gatling_gun_yourmovie',
        'turretmaximcavalry01', 'turretgatling01',
        -- Armored / military
        'armoredbuggy01',
        -- Balloons (no combat use but flight = unfair positional advantage)
        'hotairballoon01',
        -- Cannon wagons and siege weapons
        'cannon_wagon', 'siegecannon01',
    },

    -- Invisibility detection (cheat menus often make player invisible)
    InvisibilityDetection = true,

    -- Noclip/flying detection
    -- 5.0 is far too low — bridges over rivers can be 15-40m above the water below.
    -- 28.0 ensures we only catch genuine hovering in open sky, not bridge traversal.
    -- NoclipConsecutiveChecks × 2s interval = how long they must hover before flagging.
    -- 6 checks = 12 seconds of continuous floating at altitude → very few false alarms.
    NoclipDetection = true,
    NoclipHeightThreshold = 28.0,
    NoclipConsecutiveChecks = 6,

    -- Max health fallback threshold (above this = cheat menu / stat editor).
    -- Runtime automatically raises this to 1200 on RSG to account for the
    -- 600 base max health PLUS health stat upgrades which can reach ~900+.
    MaxHealthThreshold = 250,

    -- Stamina hack detection (player on foot)
    -- Disabled by default — high false positive rate if server has stamina buff perks
    StaminaDetection = false,

    -- Deadeye god mode detection
    -- A cheat menu can lock deadeye permanently. We flag anyone keeping it
    -- active for more than MaxContinuousTicks × 2 seconds without stopping.
    DeadeyeProtection = {
        Enabled            = true,
        MaxContinuousTicks = 30,  -- ~60 seconds of uninterrupted deadeye
    },

    -- Suspicious revive detection
    -- Flags players who recover from a downed state impossibly fast (cheat menu instant revive)
    -- or too many times in a short window (revive loop exploit)
    SuspiciousReviveDetection = true,
    SuspiciousReviveMinTime = 3000,  -- ms — revival faster than this is flagged
    SuspiciousReviveMaxCount = 3,    -- flag after this many fast revives in the window
    SuspiciousReviveWindow = 120,    -- seconds — rolling window for counting revives

    -- Auto-actions on detection
    -- action: 'none' | 'alert' | 'kick' | 'ban'
    -- cooldown: seconds before the same detection type fires again for the same player
    AutoActions = {
        TeleportHack      = { action = 'alert', severity = 'high',     cooldown = 300  },
        SpeedHack         = { action = 'alert', severity = 'high',     cooldown = 300  },
        GodMode           = { action = 'alert', severity = 'high',     cooldown = 600  },
        ExplosionSpam     = { action = 'kick',  severity = 'critical', cooldown = 60   },
        EventSpam         = { action = 'kick',  severity = 'critical', cooldown = 60   },
        EntitySpam        = { action = 'kick',  severity = 'critical', cooldown = 60   },
        MoneyAnomaly      = { action = 'alert', severity = 'high',     cooldown = 300  },
        ItemAnomaly       = { action = 'alert', severity = 'medium',   cooldown = 300  },
        BlacklistedEvent  = { action = 'kick',  severity = 'critical', cooldown = 60   },
        ResourceInjection = { action = 'kick',  severity = 'critical', cooldown = 60   },
        WeaponSpawn       = { action = 'alert', severity = 'high',     cooldown = 300  },
        ModelMorph        = { action = 'alert', severity = 'medium',   cooldown = 300  },
        VehicleSpeedHack  = { action = 'alert', severity = 'high',     cooldown = 300  },
        BlacklistedModel  = { action = 'kick',  severity = 'critical', cooldown = 60   },
        BlacklistedWeapon = { action = 'alert', severity = 'high',     cooldown = 300  },
        BlacklistedVehicle= { action = 'kick',  severity = 'critical', cooldown = 60   },
        BlacklistedAmmo   = { action = 'alert', severity = 'high',     cooldown = 300  },
        Invisibility      = { action = 'alert', severity = 'high',     cooldown = 300  },
        Noclip            = { action = 'kick',  severity = 'critical', cooldown = 60   },
        SuspiciousRevive  = { action = 'alert', severity = 'medium',   cooldown = 300  },
        MaxHealthAnomaly  = { action = 'alert', severity = 'high',     cooldown = 300  },
        StaminaHack       = { action = 'alert', severity = 'medium',   cooldown = 300  },
        DeadeyeHack       = { action = 'alert', severity = 'high',     cooldown = 600  },
        ChatFilter        = { action = 'alert', severity = 'medium',   cooldown = 120  },
        KillStreak        = { action = 'alert', severity = 'high',     cooldown = 300  },
        AmmoHack          = { action = 'kick',  severity = 'critical', cooldown = 60   },
        CheatSignature    = { action = 'kick',  severity = 'critical', cooldown = 60   },
        DamageHack        = { action = 'alert', severity = 'high',     cooldown = 300  },
    },

    -- Ban duration for auto-ban (hours, 0 = permanent)
    AutoBanDuration = 0,

    -- Cheat signature detection: resource name patterns that indicate an injected cheat menu.
    -- Uses Lua plain-text substrings (case-insensitive via lower()).
    -- Be conservative — only add patterns with NO overlap with any legitimate resource name.
    CheatSignatureDetection = true,
    CheatSignaturePatterns = {
        'executor', 'injector', 'bypass_ac', 'noclip_menu',
        'god_mode', 'godmode_', 'moneymod', 'speedhack',
        'cheatengine', 'cheat_menu', '_trainer_hack', 'modmenu',
    },

    -- Damage hack: flag if a player delivers a kill shot from an extreme distance
    -- (far beyond what any scoped weapon can realistically do with accuracy).
    -- The rolling block sniper has max effective range ~200m in-game.
    -- 350.0 leaves a wide buffer while still catching obvious wall-hack kills.
    DamageHackDetection = true,
    MaxLegitimateKillDistance = 350.0, -- metres
}
