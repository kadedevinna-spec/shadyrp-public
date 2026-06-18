Config = {}

Config.DevMode = false

-- HUD Element Visibility Toggles
-- Set any element to false to completely disable it (both visually and functionally)
Config.HUDElements = {
    -- Player stats (circle icons)
    Health = true,          -- Sağlık göstergesi
    Stamina = true,         -- Dayanıklılık göstergesi
    Hunger = true,          -- Açlık göstergesi
    Thirst = true,          -- Su/susuzluk göstergesi
    Stress = false,          -- Stres göstergesi (beyin ikonu) - false yapınca stres sistemi de kapanır
    Bath = true,            -- Temizlik/banyo göstergesi - false yapınca banyo sistemi de kapanır
    Toilet = true,          -- Mesane/tuvalet göstergesi - false yapınca işeme sistemi de kapanır
    Temperature = false,     -- Sıcaklık göstergesi - false yapınca sıcaklık sistemi de kapanır

    -- Horse (at binince görünür)
    HorseSpeed = true,      -- At hız ve stamina çubuğu (.horse-hud-group)
    HorseHealth = true,     -- At sağlık dairesi
    HorseDurability = true, -- At dayanıklılık dairesi

    -- Info bar (sol üst)
    Time = true,            -- Saat göstergesi
    Date = true,            -- Tarih göstergesi
    Weather = true,         -- Hava durumu ve sıcaklık
    PlayerID = true,        -- Oyuncu ID göstergesi
    Money = true,           -- Para/bakiye göstergesi

    -- Navigation
    Compass = true,         -- Pusula (üst orta)

    -- Voice
    Voice = true,           -- Ses/konuşma göstergesi

    -- Weapons
    WeaponPrimary = true,   -- Birincil silah HUD (sağ el)
    WeaponSecondary = true, -- İkincil silah HUD (sol el / çift tabanca)
}

-- HUD Theme/Color Settings
-- This sets the primary accent color for the entire HUD
-- Players cannot change this - it's server-wide setting
-- Available themes:
--   "default"  (Cream)
--   "crimson"  (Red)
--   "gold"     (Yellow)
--   "emerald"  (Green)
--   "sapphire" (Blue)
--   "amethyst" (Purple)
Config.HUDTheme = "default"

-- Real-Time Date System
-- Date advances by 1 day every time in-game clock reaches the specified hour
Config.DateSystem = {
    Enabled = true,                      -- Enable/disable date system
    StartDate = {                        -- Starting date (used only when no save file exists)
        Day = 23,
        Month = 1,                       -- May
        Year = 1903
    },
    AdvanceHour = 0,                     -- Hour (0-23) when date advances (0 = midnight, 12 = noon)
    SaveFile = "date_data.json",         -- JSON file to store current date (in resource folder)
}

-- Face/Hand Washing System
-- Allows players to wash their hands/face at water sources (troughs, barrels, etc.)
Config.WashingSettings = {
    Enabled = true,                      -- Enable/disable washing system
    Distance = 2.0,                      -- Detection distance from water props
    WashTime = 5,                        -- Washing duration in seconds
    BathBonus = 20,                      -- Bath/cleanliness bonus when washing (0-100)
    Props = {                            -- Water source props that can be used for washing
        'p_watertrough02x',
        'p_barrel_ladle01x',
        'p_barrelladle1x_savage',
        'p_barrel_wash01x',
        'p_watertrough01x',
        'p_bucket01x',
        'p_bucket02x',
    }
}

-- Poison/Venom Detection System
-- Detects snake bites and poison damage, shows green vignette effect
-- NOTE: This does NOT apply damage, only visual feedback for game's poison mechanics
Config.PoisonSettings = {
    Enabled = true,                      -- Enable/disable poison detection
    Duration = 60000,                    -- How long vignette stays active in ms (60 seconds)
    CheckInterval = 500,                 -- How often to check for poison damage in ms
}

-- Voice System Selection
-- Options: "mumble" or "saltychat"
-- mumble = Default RedM Mumble VOIP (uses MumbleIsPlayerTalking native)
-- saltychat = SaltyChat integration (uses SaltyChat_TalkStateChanged event)
Config.VoiceSystem = "mumble"

-- Framework Selection
-- Options: "vorp" or "rsg"
-- vorp = VORPCore Framework
-- rsg = RSG Framework (RSGCore)
Config.Framework = "rsg"

-- Inventory System (automatically set based on framework, but can be overridden)
-- vorp = vorp_inventory
-- rsg = rsg-inventory
Config.Inventory = "rsg" -- "vorp" or "rsg"

-- Character Commands (used for bathing system)
-- IMPORTANT: Your appearance/character script MUST have these commands
-- vorp_character has "rc" (reload character) and "undress" by default
-- rsg-appearance or other scripts may have different commands
Config.ReloadCharacterCommand = "rc"      -- Command to reload/dress character
Config.UndressCharacterCommand = "undress" -- Command to undress character

-- Commands
Config.Commands = {
    Heal = "heal",                           -- Command to restore all stats (hunger, thirst, stress, etc.)
    Pee = "pee",                             -- Command to pee/urinate (Turkish: ise)
}

Config.BathingSettings = {
    Enabled = true,
    DirtSystemEnabled = true,            -- Enable/disable progressive dirt visuals (decals/sweat). Default: true
    DecayInterval = 180000,              -- 3 minutes (180000ms) - how often cleanliness decreases
    DecayAmount = 1,                     -- Cleanliness decrease per tick
    FirstBathStatus = 100,               -- Starting cleanliness (100 = fully clean)

    DirtLevels = {
        {
            threshold = 80,
            stage = 1,
            sweat = 0.2,
            decals = {}  -- Sadece hafif ter
        },
        {
            threshold = 60,
            stage = 2,
            sweat = 0.4,
            decals = { "CC_DUSTY_full_Body_A" }  -- Hafif toz
        },
        {
            threshold = 40,
            stage = 3,
            sweat = 0.6,
            decals = { "CC_DUSTY_full_Body_A", "PD_Face_Dirt", "PD_Mud_Hands" }
        },
        {
            threshold = 20,
            stage = 4,
            sweat = 0.8,
            decals = { "CC_DUSTY_full_Body_A", "PD_Face_Dirt", "PD_Mud_Hands", "PD_Mud_Arm_L_NoFade", "PD_Mud_Arm_R_NoFade", "PD_Mud_Front_NoFade" }
        },
        {
            threshold = 0,
            stage = 5,
            sweat = 1.0,
            decals = { "CC_DUSTY_full_Body_A", "PD_Face_Dirt", "PD_Mud_Hands", "PD_Mud_Arm_L_NoFade", "PD_Mud_Arm_R_NoFade", "PD_Mud_Front_NoFade", "PD_Mud_Back_NoFade", "PD_Mud_Head_NoFade", "PD_Mud_Feet_NoFade", "PD_Outhouse_Muck_Body_Face" }
        },
    },

    Price = 0.05,                        -- Normal bath price

    -- Bath house locations
Locations = {
        ["Valentine"] = {
            coords = vector3(-320.56, 762.41, 117.44),
            blipName = "Bath House",
        },
        ["SaintDenis"] = {
            coords = vector3(2632.6, -1223.79, 59.59),
            blipName = "Bath House",
        },
        ["Strawberry"] = {
            coords = vector3(-1816.45, -372.44, 166.50),
            blipName = "Bath House",
        },
        ["Blackwater"] = {
            coords = vector3(-822.82, -1315.72, 43.58),
            blipName = "Bath House",
        },
        ["VanHorn"] = {
            coords = vector3(2986.31, 568.27, 47.85),
            blipName = "Bath House",
        },
        ["Rhodes"] = {
            coords = vector3(1340.11, -1379.6, 84.28),
            blipName = "Bath House",
        },
        ["Annesburg"] = {
            coords = vector3(2950.42, 1332.15, 44.44),
            blipName = "Bath House",
        },
    },
}

Config.MetabolismSettings = {
    EveryTimeStatusDown = 120000,          -- Time interval (in milliseconds) for status drop.
    DamageInterval = 5000,                -- Time interval (in milliseconds) for hunger/thirst damage (separate from status drop).

    HowAmountThirstWhileRunning = 4,     -- Thirst decrease amount while running.
    HowAmountHungerWhileRunning = 2,     -- Hunger decrease amount while running.
    HowAmountThirst = 2,                 -- Thirst decrease amount while idle.
    HowAmountHunger = 1,                 -- Hunger decrease amount while idle.
    FirstHungerStatus = 100,             -- Starting value for hunger (100 is full).
    FirstThirstStatus = 100,             -- Starting value for thirst (100 is full).

    OnRespawnHungerStatus = 100,         -- Hunger value after respawn.
    OnRespawnThirstStatus = 100,         -- Thirst value after respawn.

    -- Damage settings when hunger/thirst reaches 0
    DamageWhenHungry = 2,                -- Health damage per tick when hunger is 0.
    DamageWhenThirsty = 2,               -- Health damage per tick when thirst is 0.
    DamageWhenBoth = 3,                 -- Health damage per tick when both are 0.

    -- Warning thresholds
    WarningThreshold = 30,               -- Show warning effects below this value.
    CriticalThreshold = 10,              -- Show critical effects below this value.
}

-- Screen effect settings (DISABLED by default - can enable if desired)
Config.ScreenEffects = {
    Enabled = false,                     -- Set to true to enable screen effects for low hunger/thirst
    WarningEffect = "PlayerDrunkSaloon1", -- Effect when hunger/thirst is low (below WarningThreshold)
    CriticalEffect = "PlayerDrunkSaloon2", -- Effect when hunger/thirst is critical (below CriticalThreshold)
}

-- Stamina settings
Config.StaminaSettings = {
    Enabled = true,                      -- Enable/disable stamina penalties.

    -- Stamina regen multipliers based on hunger level
    -- 1.0 = normal, 0.5 = half speed, 0.0 = no regen
    NormalRegenMultiplier = 1.0,         -- Hunger > 50
    LowRegenMultiplier = 0.8,            -- Hunger 25-50 (half regen speed)
    WarningRegenMultiplier = 0.5,        -- Hunger 10-25 (very slow regen)
    CriticalRegenMultiplier = 0.3,       -- Hunger < 10 (no regen)

    -- Thresholds
    LowThreshold = 40,                   -- Below this: reduced regen
    WarningThreshold = 20,               -- Below this: very slow regen
    CriticalThreshold = 8,              -- Below this: no regen
}

-- Weather effects
Config.WeatherEffects = {
    Enabled = true,                      -- Enable/disable weather effects.

    -- Hot weather (thirst decreases faster in hot weather)
    HotWeathers = {
        "SUNNY", "HIGHPRESSURE", "DRIZZLE"
    },
    HotThirstMultiplier = 1.5,           -- Thirst decreases 1.5x faster in hot weather.

    -- Cold weather (hunger decreases faster in cold weather)
    ColdWeathers = {
        "SNOW", "BLIZZARD", "SNOWLIGHT", "WHITEOUT", "GROUNDBLIZZARD"
    },
    ColdHungerMultiplier = 1.5,          -- Hunger decreases 1.5x faster in cold weather.

    -- Rain (slight thirst recovery in rain)
    RainWeathers = {
        "RAIN", "THUNDER", "DRIZZLE"
    },
    RainThirstRecovery = 1,              -- Thirst recovery per tick in rain (up to max).
    RainThirstRecoveryMax = 30,          -- Maximum thirst recovery from rain.
}

-- Temperature settings
Config.TemperatureSettings = {
    Enabled = true,                      -- Enable/disable temperature system.
    UpdateInterval = 5000,               -- Temperature check interval (1 second).

    -- Temperature thresholds (Celsius)
    VeryHotThreshold = 34,               -- Above this: extreme heat effects.
    VeryColdThreshold = -5,              -- Below this: extreme cold effects.

    -- Health damage from extreme temperatures (per tick)
    VeryHotDamage = 1,                   -- Damage when very hot.
    VeryColdDamage = 1,                  -- Damage when very cold.
}

-- Bladder/Toilet settings
Config.BladderSettings = {
    Enabled = true,
    FirstBladderStatus = 100,            -- Starting bladder level (100 = full, needs to pee)
    DecayInterval = 60000,               -- How often bladder fills up (1 minute = 60000ms)
    DecayAmount = 1,                     -- Bladder increase per tick (fills up over time)
    WarningThreshold = 20,               -- Below this, start showing warnings
    WarningInterval = 25,                 -- Show warning every X% drop below threshold
    CriticalThreshold = 15,              -- Below this %, screen turns red
    MinBladderToPee = 80,                -- Can't pee if bladder is above this value
}

-- Alcohol settings
Config.AlcoholSettings = {
    Enabled = true,                      -- Enable/disable alcohol thirst system.
    ThirstMultiplier = 2.0,              -- Thirst decrease multiplier when alcohol is active (2.0 = 2x faster).
    Duration = 25000,                     -- TEST: 5 saniye (normali 60000).
    StressReduction = 30,                -- Stress reduction amount when drinking alcohol.
    RefreshCommand = "rc",               -- Command to refresh character skin after drunk effect ends (resets walking animation).
                                         -- VORP default: "rc" | RSG default: "rc" | Change this if your server uses different command.
}

-- Vomit/Overeating settings
Config.VomitSettings = {
    Enabled = true,                      -- Enable/disable vomit system when overeating.
    HungerThreshold = 100,               -- If hunger is at or above this value and player eats, they will vomit.
    HungerAfterVomit = 85,               -- Hunger level after vomiting (percentage).
    VomitDuration = 5000,                -- Vomit animation duration in milliseconds.
    OvereatCount = 5,                    -- How many times player must eat while full before vomiting.
}

-- Voice Range Circle settings (shows circle when pressing F11 to change voice mode)
Config.VoiceCircleSettings = {
    Enabled = true,                      -- Enable/disable voice range circle visualization.
    Duration = 3000,                     -- How long the circle shows in milliseconds.
    ShowNotification = true,             -- Show notification with mode name and distance.
    ModeNames = {
        [1] = "Whisper",                 -- Whisper mode name (Mode 1)
        [2] = "Normal",                  -- Normal mode name (Mode 2)
        [3] = "Shout",                   -- Shout mode name (Mode 3)
    },
}

-- Smoking settings (Cigarette/Cigar)
Config.SmokingSettings = {
    Enabled = true,                      -- Enable/disable smoking effects system.
    InitialStressReduction = 15,         -- Initial stress reduction when smoking starts.
    PeriodicStressReduction = 3,         -- Stress reduction per interval during smoking.
    PeriodicInterval = 5000,             -- Interval for periodic stress reduction (5 seconds = 5000ms).
    Duration = 30000,                    -- Smoking effect duration in milliseconds (30 seconds = 30000ms).
    ThirstMultiplier = 1.3,              -- Thirst decrease multiplier when smoking (1.3 = 1.3x faster).
    HungerMultiplier = 1.2,              -- Hunger decrease multiplier when smoking (1.2 = 1.2x faster).
}

-- Stress settings
Config.StressSettings = {
    Enabled = true,                      -- Enable/disable stress system.
    MaxStress = 100,                     -- Maximum stress level.

    -- Stress gain amounts
    StressOnShoot = 2,                   -- Stress gained per shot fired.
    StressOnPunch = 2,                   -- Stress gained per punch/melee attack.

    -- Stress reduction
    StressDecayRate = 1,                 -- Stress decrease amount per tick.
    StressDecayInterval = 60000,         -- Stress decay interval (1 minute = 60000ms).

    StressReductionFood = 0,             -- Stress reduction when eating food.
    StressReductionDrink = 0,            -- Stress reduction when drinking water/beverages.

    -- Camera shake settings (using ShakeGameplayCam native)
    ShakeThreshold = 60,                 -- Stress level when camera shake starts.
    ShakeType = "JOLT_SHAKE",            -- Shake animation type. Options: "HAND_SHAKE", "JOLT_SHAKE", "VIBRATE_SHAKE", "ROAD_VIBRATION_SHAKE", "DRUNK_SHAKE", "SKY_DIVING_SHAKE"
    MinShakeIntensity = 0.6,             -- Minimum shake intensity at threshold (60% stress)
    MaxShakeIntensity = 1.0,             -- Maximum shake intensity at max stress (100%)
    DynamicIntensity = true,             -- Enable dynamic intensity based on stress level
}

-- Notification Settings
Config.NotificationSettings = {
    -- Hunger/Thirst/Bath (Decreasing Values)
    StartThreshold = 30,      -- Start notifying when value is below this % (e.g. 30%)
    Interval = 10,            -- Notify every X% drop (e.g. at 20%, 10%)
    
    -- Stress (Increasing Value)
    StressStartThreshold = 70, -- Start notifying when stress is above this %
    StressInterval = 10,       -- Notify every X% increase

    -- Temperature
    TempNotifyInterval = 10000, -- Time in ms between damage notifications

    -- Messages
    ShowHunger = true,
    ShowThirst = true,
    ShowStress = true,
    ShowBath = true,
    ShowTemp = true,
    ShowToilet = true
}

-- Consumable items configuration
-- Thirst/Hunger values converted from 1000 scale to 100 scale (divided by 10)
-- Effect: Screen effect name (from AnimpostfxPlay). EffectDuration: Duration in minutes.
-- IsAlcohol: If true, increases thirst drain rate by AlcoholSettings.ThirstMultiplier for AlcoholSettings.Duration.
Config.ItemsToUse = {
    -- # Alcohols
    { Name = "whisky", Thirst = -10, Hunger = 0, Stamina = -5, PropName = "s_inv_whiskey02x", Animation = "drink", Effect = "PlayerDrunkSaloon1", EffectDuration = 1, IsAlcohol = true },
    { Name = "wine", Thirst = -5, Hunger = 5, Stamina = -3, PropName = "p_bottlewine01x", Animation = "drink", Effect = "PlayerDrunkSaloon1", EffectDuration = 1, IsAlcohol = true },
    { Name = "vodka", Thirst = -15, Hunger = 0, Stamina = -8, PropName = "p_bottlemedicine09x", Animation = "drink", Effect = "PlayerDrunkSaloon1", EffectDuration = 1, IsAlcohol = true },
    { Name = "beer", Thirst = 10, Hunger = 8, Stamina = 5, PropName = "p_bottlejd01x", Animation = "drink", Effect = "PlayerDrunkSaloon1", EffectDuration = 1, IsAlcohol = true },
    { Name = "tequila", Thirst = -12, Hunger = 0, Stamina = -6, PropName = "p_bottlechampagne01x", Animation = "drink", Effect = "PlayerDrunkSaloon1", EffectDuration = 1, IsAlcohol = true },
    { Name = "tropicalPunchMoonshine", Thirst = -8, Hunger = 3, Stamina = -10, PropName = "p_masonjarmoonshine01x", Animation = "drink", Effect = "PlayerDrunkSaloon1", EffectDuration = 1, IsAlcohol = true },
    { Name = "wildCiderMoonshine", Thirst = 5, Hunger = 10, Stamina = -5, PropName = "p_masonjarmoonshine01x", Animation = "drink", Effect = "PlayerDrunkSaloon1", EffectDuration = 1, IsAlcohol = true },
    { Name = "raspberryale", Thirst = 15, Hunger = 12, Stamina = 8, PropName = "p_bottlebeer01a", Animation = "drink", Effect = "PlayerDrunkSaloon1", EffectDuration = 1, IsAlcohol = true },
    { Name = "blackberryale", Thirst = 15, Hunger = 12, Stamina = 8, PropName = "p_bottlebeer01a", Animation = "drink", Effect = "PlayerDrunkSaloon1", EffectDuration = 1, IsAlcohol = true },
    { Name = "absinthe", Thirst = -20, Hunger = 0, Stamina = -15, PropName = "p_bottlewine01x", Animation = "drink", Effect = "PlayerDrunkSaloon2", EffectDuration = 2, IsAlcohol = true },
    { Name = "alcohol", Thirst = -10, Hunger = 0, Stamina = -5, PropName = "p_bottlejd01x", Animation = "drink", Effect = "PlayerDrunkSaloon1", EffectDuration = 1, IsAlcohol = true },
    -- { Name = "itemname", Thirst = 0, Hunger = 0, Stamina = 0, PropName = "exampleprop", Animation = "drink", Effect = "PlayerDrunkSaloon1", EffectDuration = 1, IsAlcohol = true },

    -- # Regular drinks
    { Name = "water", Thirst = 60, Hunger = 0, Stamina = 5, PropName = "p_bottlejd01x", Animation = "drink" },
    { Name = "milk", Thirst = 35, Hunger = 25, Stamina = 15, PropName = "p_bottlejd01x", Animation = "drink" },
    -- { Name = "itemname", Thirst = 0, Hunger = 0, Stamina = 0, PropName = "exampleprop", Animation = "drink" },

    -- # Coffee and Teas
    { Name = "consumable_coffee", Thirst = 25, Hunger = 2, Stamina = 30, PropName = "p_mugcoffee01x", Animation = "coffee" },
    { Name = "consumable_chocolatecoffee", Thirst = 20, Hunger = 15, Stamina = 25, PropName = "p_mugcoffee01x", Animation = "coffee" },
    { Name = "chamomile_tea", Thirst = 40, Hunger = 1, Stamina = 20, PropName = "p_mugcoffee01x", Animation = "coffee" },
    { Name = "pu_erh_tea", Thirst = 40, Hunger = 1, Stamina = 25, PropName = "p_mugcoffee01x", Animation = "coffee" },
    { Name = "herbal_tea", Thirst = 45, Hunger = 1, Stamina = 15, PropName = "p_mugcoffee01x", Animation = "coffee" },
    { Name = "oolong_tea", Thirst = 40, Hunger = 1, Stamina = 22, PropName = "p_mugcoffee01x", Animation = "coffee" },
    { Name = "coffee", Thirst = 25, Hunger = 2, Stamina = 30, PropName = "p_mugcoffee01x", Animation = "coffee" },
    { Name = "orange_juice", Thirst = 45, Hunger = 12, Stamina = 12, PropName = "p_mugcoffee01x", Animation = "coffee" },
    { Name = "lemonade", Thirst = 50, Hunger = 8, Stamina = 10, PropName = "p_mugcoffee01x", Animation = "coffee" },
    { Name = "hot_chocolate", Thirst = 30, Hunger = 20, Stamina = 18, PropName = "p_mugcoffee01x", Animation = "coffee" },
    { Name = "oyster_cocktail", Thirst = 35, Hunger = 18, Stamina = 20, PropName = "p_mugcoffee01x", Animation = "coffee" },
    { Name = "cocktail", Thirst = 35, Hunger = 18, Stamina = 20, PropName = "p_mugcoffee01x", Animation = "coffee" },
    { Name = "chocolate_milk", Thirst = 35, Hunger = 25, Stamina = 20, PropName = "p_mugcoffee01x", Animation = "coffee" },
    { Name = "strawberry_punch", Thirst = 48, Hunger = 10, Stamina = 12, PropName = "p_mugcoffee01x", Animation = "coffee" },
    { Name = "strawberry_soda", Thirst = 45, Hunger = 8, Stamina = 8, PropName = "p_mugcoffee01x", Animation = "coffee" },
    { Name = "strawberry_lemonade", Thirst = 50, Hunger = 10, Stamina = 10, PropName = "p_mugcoffee01x", Animation = "coffee" },
    { Name = "strawberry_shrub", Thirst = 42, Hunger = 8, Stamina = 10, PropName = "p_mugcoffee01x", Animation = "coffee" },
    { Name = "strawberry_cordial", Thirst = 40, Hunger = 12, Stamina = 12, PropName = "p_mugcoffee01x", Animation = "coffee" },
    -- { Name = "itemname", Thirst = 0, Hunger = 0, Stamina = 0, PropName = "exampleprop", Animation = "coffee" },

    -- # Soup and Bowl dishes
    { Name = "consumable_fruitsalad", Thirst = 20, Hunger = 35, Stamina = 18, PropName = "p_bowl04x_stew", Animation = "stew" },
    { Name = "consumable_meat_greavy", Thirst = 15, Hunger = 65, Stamina = 35, PropName = "p_bowl04x_stew", Animation = "stew" },
    { Name = "consumable_soup", Thirst = 15, Hunger = 65, Stamina = 35, PropName = "p_bowl04x_stew", Animation = "stew" },
    
    -- # Canned Foods
    { Name = "consumable_kidneybeans_can", Thirst = 5, Hunger = 30, Stamina = 15, PropName = "p_can01x", Animation = "beans" },
    { Name = "consumable_salmon_can", Thirst = 5, Hunger = 35, Stamina = 20, PropName = "p_can01x", Animation = "beans" },

    -- # Cigarette & Tobacco
    { Name = "cigarette", Thirst = -5, Hunger = -2, Stamina = 15, Stress = 50, PropName = "p_cigarette01x", Animation = "cigarette", IsSmoking = true },
    { Name = "cigar", Thirst = -8, Hunger = -3, Stamina = 25, Stress = 50, PropName = "p_cigar02x", Animation = "cigar", IsSmoking = true },

    -- # Fruits
    { Name = "apple", Thirst = 15, Hunger = 12, Stamina = 8, PropName = "p_apple01x", Animation = "eat" },
    { Name = "banana", Thirst = 12, Hunger = 18, Stamina = 12, PropName = "p_banana01x", Animation = "eat" },
    { Name = "consumable_peach", Thirst = 18, Hunger = 14, Stamina = 10, PropName = "p_peach01x", Animation = "eat" },
    { Name = "consumable_pear", Thirst = 16, Hunger = 13, Stamina = 9, PropName = "p_pear01x", Animation = "eat" },
    { Name = "blueberry", Thirst = 8, Hunger = 5, Stamina = 4, PropName = "p_blackberry01x", Animation = "eat" },
    { Name = "consumable_herb_evergreen_huckleberry", Thirst = 6, Hunger = 4, Stamina = 3, PropName = "s_inv_huckleberry01x", Animation = "eat" },
    { Name = "consumable_herb_wintergreen_berry", Thirst = 7, Hunger = 4, Stamina = 3, PropName = "s_inv_wintergreen01x", Animation = "eat" },

    -- # Vegetables
    { Name = "carrots", Thirst = 10, Hunger = 15, Stamina = 8, PropName = "p_carrot01x", Animation = "eat" },
    { Name = "corn", Thirst = 8, Hunger = 25, Stamina = 12, PropName = "p_corn01x", Animation = "eat" },
    { Name = "potato", Thirst = 5, Hunger = 35, Stamina = 15, PropName = "p_potato01x", Animation = "eat" },
    { Name = "consumable_veggies", Thirst = 12, Hunger = 20, Stamina = 12, PropName = "p_carrot01x", Animation = "eat" },

    -- # Meats
    { Name = "consumable_meat_bird", Thirst = -3, Hunger = 50, Stamina = 28, PropName = "p_cs_meatstew01x", Animation = "eat" },
    { Name = "consumable_meat_buck", Thirst = -15, Hunger = 60, Stamina = 35, PropName = "p_cs_meatstew01x", Animation = "eat" },
    { Name = "consumable_meat_gristly", Thirst = -10, Hunger = 58, Stamina = 32, PropName = "p_cs_meatstew01x", Animation = "eat" },
    { Name = "consumable_meat_lilmature", Thirst = -5, Hunger = 62, Stamina = 35, PropName = "p_cs_meatstew01x", Animation = "eat" },
    { Name = "consumable_meat_mature", Thirst = -5, Hunger = 48, Stamina = 26, PropName = "p_cs_meatstew01x", Animation = "eat" },
    { Name = "meat", Thirst = -5, Hunger = 55, Stamina = 30, PropName = "p_cs_meatstew01x", Animation = "eat" },
    { Name = "Gamey_Meat", Thirst = -3, Hunger = 52, Stamina = 30, PropName = "p_cs_meatstew01x", Animation = "eat" },
    { Name = "consumable_meat_big_game_cooked", Thirst = -3, Hunger = 52, Stamina = 30, PropName = "p_cs_meatstew01x", Animation = "eat" },
    { Name = "consumable_meat_exotic_bird_cooked", Thirst = -3, Hunger = 52, Stamina = 30, PropName = "p_cs_meatstew01x", Animation = "eat" },
    { Name = "consumable_meat_game_cooked", Thirst = -3, Hunger = 52, Stamina = 30, PropName = "p_cs_meatstew01x", Animation = "eat" },
    { Name = "consumable_meat_gristly_mutton_cooked", Thirst = -3, Hunger = 52, Stamina = 30, PropName = "p_cs_meatstew01x", Animation = "eat" },
    { Name = "consumable_meat_plump_bird_cooked", Thirst = -3, Hunger = 52, Stamina = 30, PropName = "p_cs_meatstew01x", Animation = "eat" },
    { Name = "consumable_meat_prime_beef_cooked", Thirst = -3, Hunger = 52, Stamina = 30, PropName = "p_cs_meatstew01x", Animation = "eat" },
    { Name = "consumable_meat_tender_pork_cooked", Thirst = -3, Hunger = 52, Stamina = 30, PropName = "p_cs_meatstew01x", Animation = "eat" },
    { Name = "consumable_meat_succulent_fish_cooked", Thirst = -3, Hunger = 52, Stamina = 30, PropName = "p_cs_meatstew01x", Animation = "eat" },
    { Name = "consumable_meat_stringy_cooked", Thirst = -3, Hunger = 52, Stamina = 30, PropName = "p_cs_meatstew01x", Animation = "eat" },

    -- # Fishs
    { Name = "fried_perch", Thirst = 5, Hunger = 42, Stamina = 24, PropName = "p_fish01x", Animation = "eat" },
    { Name = "consumable_bluegil", Thirst = 8, Hunger = 38, Stamina = 22, PropName = "p_fish01x", Animation = "eat" },
    { Name = "consumable_salmon", Thirst = 6, Hunger = 45, Stamina = 26, PropName = "p_fish01x", Animation = "eat" },
    { Name = "consumable_trout", Thirst = 7, Hunger = 40, Stamina = 23, PropName = "p_fish01x", Animation = "eat" },
    { Name = "cookedbluegil", Thirst = 5, Hunger = 48, Stamina = 28, PropName = "p_fish01x", Animation = "eat" },

    -- # Breakfast and Meals
    { Name = "consumable_breakfast", Thirst = 10, Hunger = 45, Stamina = 25, PropName = "s_oatcakes01x", Animation = "eat" },
    { Name = "egg", Thirst = 2, Hunger = 20, Stamina = 12, PropName = "p_egg01x", Animation = "eat" },
    { Name = "eggs", Thirst = 3, Hunger = 35, Stamina = 20, PropName = "p_egg01x", Animation = "eat" },
    { Name = "boiledegg", Thirst = 5, Hunger = 25, Stamina = 15, PropName = "p_egg01x", Animation = "eat" },

    -- # Bread and Baked
    { Name = "bread", Thirst = -3, Hunger = 40, Stamina = 18, PropName = "p_bread_08_ab_slice_a", Animation = "eat" },
    { Name = "consumable_pretzel", Thirst = -5, Hunger = 22, Stamina = 10, PropName = "s_crackers01x", Animation = "eat" },

    -- # Desserts
    { Name = "consumable_caramel", Thirst = -2, Hunger = 15, Stamina = 8, PropName = "s_candybag01x", Animation = "eat" },
    { Name = "consumable_chocolate", Thirst = -2, Hunger = 18, Stamina = 12, PropName = "s_chocolatebar01x", Animation = "eat" },
    { Name = "consumable_peppermint", Thirst = 3, Hunger = 8, Stamina = 5, PropName = "s_candybag01x", Animation = "eat" },
    { Name = "consumable_horsepeppermints", Thirst = 3, Hunger = 7, Stamina = 4, PropName = "s_oatcakes01x", Animation = "eat" },
    { Name = "consumable_lemondrops", Thirst = 4, Hunger = 10, Stamina = 6, PropName = "s_candybag01x", Animation = "eat" },
    { Name = "honey", Thirst = -3, Hunger = 25, Stamina = 20, PropName = "s_honey01x", Animation = "eat" },
    { Name = "consumable_grapejelly", Thirst = -2, Hunger = 22, Stamina = 12, PropName = "s_jampot01x", Animation = "eat" },
    { Name = "consumable_peachjelly", Thirst = -1, Hunger = 24, Stamina = 13, PropName = "s_jampot01x", Animation = "eat" },
    { Name = "consumable_raspberryjelly", Thirst = -1, Hunger = 23, Stamina = 12, PropName = "s_jampot01x", Animation = "eat" },

    -- ==================== MEDIC ====================
    { Name = "bandage", Thirst = 0, Hunger = 0, Stamina = 0, PropName = "p_cs_bandage01x", Animation = "bandage", FullHeal = true },
}

-- Weapon display names configuration
-- Format: [WeaponHash] = "Display Name"
Config.WeaponNames = {
    -- Close Combat Weapons
    [`WEAPON_MELEE_KNIFE`] = "Knife",
    [`WEAPON_MELEE_KNIFE_JAWBONE`] = "Jawbone Knife",
    [`WEAPON_MELEE_KNIFE_TRADER`] = "Trader Knife",
    [`WEAPON_MELEE_KNIFE_HORROR`] = "Horror Knife",
    [`WEAPON_MELEE_KNIFE_RUSTIC`] = "Rustic Knife",
    [`WEAPON_MELEE_MACHETE`] = "Machete",
    [`WEAPON_MELEE_MACHETE_HORROR`] = "Horror Machete",
    [`WEAPON_MELEE_MACHETE_COLLECTOR`] = "Collector Machete",
    [`WEAPON_MELEE_HATCHET`] = "Hatchet",
    [`WEAPON_MELEE_HATCHET_HUNTER`] = "Hunter Hatchet",
    [`WEAPON_MELEE_HATCHET_DOUBLE_BIT`] = "Double Bit Hatchet",
    [`WEAPON_MELEE_CLEAVER`] = "Cleaver",
    [`WEAPON_MELEE_TORCH`] = "Torch",
    [`WEAPON_MELEE_LANTERN`] = "Lantern",
    [`WEAPON_MELEE_DAVY_LANTERN`] = "Davy Lantern",
    [`WEAPON_MELEE_LANTERN_HALLOWEEN`] = "Halloween Lantern",

    -- Pistols
    [`WEAPON_PISTOL_VOLCANIC`] = "Volcanic Pistol",
    [`WEAPON_PISTOL_M1899`] = "Pistol M1899 ",
    [`WEAPON_PISTOL_SEMIAUTO`] = "Semi Auto Pistol",
    [`WEAPON_PISTOL_MAUSER`] = "Mauser Pistol",

    -- Repeaters
    [`WEAPON_REPEATER_EVANS`] = "Evans Repeater",
    [`WEAPON_REPEATER_HENRY`] = "Henry Repeater",
    [`WEAPON_REPEATER_WINCHESTER`] = "Winchester Repeater",
    [`WEAPON_REPEATER_CARBINE`] = "Carbine Repeater",

    -- Revolvers
    [`WEAPON_REVOLVER_CATTLEMAN`] = "Cattleman Revolver",
    [`WEAPON_REVOLVER_CATTLEMAN_MEXICAN`] = "Cattleman Mexican",
    [`WEAPON_REVOLVER_DOUBLEACTION`] = "Double Action Revolver",
    [`WEAPON_REVOLVER_DOUBLEACTION_GAMBLER`] = "Doubleaction Gambler Revolver",
    [`WEAPON_REVOLVER_SCHOFIELD`] = "Schofield Revolver",
    [`WEAPON_REVOLVER_LEMAT`] = "LeMat Revolver",
    [`WEAPON_REVOLVER_NAVY`] = "Navy Revolver",
    [`WEAPON_REVOLVER_NAVY_CROSSOVER`] = "Navy Crossover",

    -- Rifles
    [`WEAPON_RIFLE_BOLTACTION`] = "Boltaction Rifle",
    [`WEAPON_RIFLE_SPRINGFIELD`] = "Springfield Rifle",
    [`WEAPON_RIFLE_VARMINT`] = "Varmint Rifle",
    [`WEAPON_RIFLE_ELEPHANT`] = "Elephant Rifle",

    -- Shotguns
    [`WEAPON_SHOTGUN_DOUBLEBARREL`] = "Doublebarrel Shotgun",
    [`WEAPON_SHOTGUN_DOUBLEBARREL_EXOTIC`] = "Doublebarrel Exotic Shotgun",
    [`WEAPON_SHOTGUN_SAWEDOFF`] = "Sawedoff",
    [`WEAPON_SHOTGUN_PUMP`] = "Pump Shotgun",
    [`WEAPON_SHOTGUN_REPEATING`] = "Repeating Shotgun",
    [`WEAPON_SHOTGUN_SEMIAUTO`] = "Semi Auto Shotgun",

    -- Sniper Rifles
    [`WEAPON_SNIPERRIFLE_CARCANO`] = "Carcano Rifle",
    [`WEAPON_SNIPERRIFLE_ROLLINGBLOCK`] = "Rolling Block Rifle",

    -- Projectile Weapons
    [`WEAPON_THROWN_DYNAMITE`] = "Dynamite",
    [`WEAPON_THROWN_MOLOTOV`] = "Molotov",
    [`WEAPON_THROWN_THROWING_KNIVES`] = "Throwing Knives",
    [`WEAPON_THROWN_TOMAHAWK`] = "Tomahawk",
    [`WEAPON_THROWN_TOMAHAWK_ANCIENT`] = "Ancient Tomahawk",
    [`WEAPON_THROWN_BOLAS`] = "Bolas",
    [`WEAPON_THROWN_BOLAS_HAWKMOTH`] = "Hawkmoth Bolas",
    [`WEAPON_THROWN_BOLAS_IRONSPIKED`] = "Iron Spiked Bolas",
    [`WEAPON_THROWN_BOLAS_INTERTWINED`] = "Intertwined Bolas",
    [`WEAPON_THROWN_POISONBOTTLE`] = "Poison Bottle",

    -- Bows
    [`WEAPON_BOW`] = "Bow",
    [`WEAPON_BOW_IMPROVED`] = "Improved Bow",

    -- Private Item
    [`WEAPON_LASSO`] = "Lasso",
    [`WEAPON_LASSO_REINFORCED`] = "Reinforced Lasso",
    [`WEAPON_FISHINGROD`] = "Fishing Rod",
    [`WEAPON_KIT_CAMERA`] = "Camera",
    [`WEAPON_KIT_CAMERA_ADVANCED`] = "Advanced Camera",
    [`WEAPON_KIT_BINOCULARS`] = "Dürbün",
    [`WEAPON_KIT_BINOCULARS_IMPROVED`] = "Improved Binoculars",
    [`WEAPON_KIT_METAL_DETECTOR`] = "Metal Detector",
    [`WEAPON_MOONSHINEJUG_MP`] = "Moonshine Jug",

    -- Undermed
    [`WEAPON_UNARMED`] = "Undermed"
}

-- Weapon icon file names configuration
-- Format: [WeaponHash] = "filename.png"
Config.WeaponIcons = {
    -- Melee Weapons
    [`WEAPON_MELEE_KNIFE`] = "weapon_melee_knife.png",
    [`WEAPON_MELEE_KNIFE_JAWBONE`] = "weapon_melee_knife_jawbone.png",
    [`WEAPON_MELEE_KNIFE_TRADER`] = "weapon_melee_knife_trader.png",
    [`WEAPON_MELEE_MACHETE`] = "weapon_melee_machete.png",
    [`WEAPON_MELEE_MACHETE_HORROR`] = "weapon_melee_machete_horror.png",
    [`WEAPON_MELEE_MACHETE_COLLECTOR`] = "weapon_melee_machete_collector.png",
    [`WEAPON_MELEE_HATCHET`] = "weapon_melee_hatchet.png",
    [`WEAPON_MELEE_HATCHET_HUNTER`] = "weapon_melee_hatchet_hunter.png",
    [`WEAPON_MELEE_HATCHET_DOUBLE_BIT`] = "weapon_melee_hatchet_double_bit.png",
    [`WEAPON_MELEE_CLEAVER`] = "weapon_melee_cleaver.png",
    [`WEAPON_MELEE_TORCH`] = "weapon_melee_torch.png",
    [`WEAPON_MELEE_LANTERN`] = "weapon_melee_lantern.png",
    [`WEAPON_MELEE_DAVY_LANTERN`] = "weapon_melee_davy_lantern.png",

    -- Pistols
    [`WEAPON_PISTOL_VOLCANIC`] = "weapon_pistol_volcanic.png",
    [`WEAPON_PISTOL_M1899`] = "weapon_pistol_m1899.png",
    [`WEAPON_PISTOL_SEMIAUTO`] = "weapon_pistol_semiauto.png",
    [`WEAPON_PISTOL_MAUSER`] = "weapon_pistol_mauser.png",

    -- Repeaters
    [`WEAPON_REPEATER_EVANS`] = "weapon_repeater_evans.png",
    [`WEAPON_REPEATER_HENRY`] = "weapon_repeater_henry.png",
    [`WEAPON_REPEATER_WINCHESTER`] = "weapon_repeater_winchester.png",
    [`WEAPON_REPEATER_CARBINE`] = "weapon_repeater_carbine.png",

    -- Revolvers
    [`WEAPON_REVOLVER_CATTLEMAN`] = "weapon_revolver_cattleman.png",
    [`WEAPON_REVOLVER_CATTLEMAN_MEXICAN`] = "weapon_revolver_cattleman_mexican.png",
    [`WEAPON_REVOLVER_DOUBLEACTION`] = "weapon_revolver_doubleaction.png",
    [`WEAPON_REVOLVER_DOUBLEACTION_GAMBLER`] = "weapon_revolver_doubleaction_gambler.png",
    [`WEAPON_REVOLVER_SCHOFIELD`] = "weapon_revolver_schofield.png",
    [`WEAPON_REVOLVER_SCHOFIELD_GOLDEN`] = "weapon_revolver_schofield_golden.png",
    [`WEAPON_REVOLVER_SCHOFIELD_CALLOWAY`] = "weapon_revolver_schofield_calloway.png",
    [`WEAPON_REVOLVER_LEMAT`] = "weapon_revolver_lemat.png",
    [`WEAPON_REVOLVER_NAVY`] = "weapon_revolver_navy.png",
    [`WEAPON_REVOLVER_NAVY_CROSSOVER`] = "weapon_revolver_navy_crossover.png",

    -- Rifles
    [`WEAPON_RIFLE_BOLTACTION`] = "weapon_rifle_boltaction.png",
    [`WEAPON_RIFLE_SPRINGFIELD`] = "weapon_rifle_springfield.png",
    [`WEAPON_RIFLE_VARMINT`] = "weapon_rifle_varmint.png",
    [`WEAPON_RIFLE_ELEPHANT`] = "weapon_rifle_elephant.png",

    -- Shotguns
    [`WEAPON_SHOTGUN_DOUBLEBARREL`] = "weapon_shotgun_doublebarrel.png",
    [`WEAPON_SHOTGUN_DOUBLEBARREL_EXOTIC`] = "weapon_shotgun_doublebarrel_exotic.png",
    [`WEAPON_SHOTGUN_SAWEDOFF`] = "weapon_shotgun_sawedoff.png",
    [`WEAPON_SHOTGUN_PUMP`] = "weapon_shotgun_pump.png",
    [`WEAPON_SHOTGUN_REPEATING`] = "weapon_shotgun_repeating.png",
    [`WEAPON_SHOTGUN_SEMIAUTO`] = "weapon_shotgun_semiauto.png",

    -- Sniper Rifles
    [`WEAPON_SNIPERRIFLE_CARCANO`] = "weapon_sniperrifle_carcano.png",
    [`WEAPON_SNIPERRIFLE_ROLLINGBLOCK`] = "weapon_sniperrifle_rollingblock.png",

    -- Thrown Weapons
    [`WEAPON_THROWN_DYNAMITE`] = "weapon_thrown_dynamite.png",
    [`WEAPON_THROWN_MOLOTOV`] = "weapon_thrown_molotov.png",
    [`WEAPON_THROWN_THROWING_KNIVES`] = "weapon_thrown_throwing_knives.png",
    [`WEAPON_THROWN_TOMAHAWK`] = "weapon_thrown_tomahawk.png",
    [`WEAPON_THROWN_TOMAHAWK_ANCIENT`] = "weapon_thrown_tomahawk_ancient.png",
    [`WEAPON_THROWN_BOLAS`] = "weapon_thrown_bolas.png",
    [`WEAPON_THROWN_POISONBOTTLE`] = "weapon_thrown_poisonbottle.png",

    -- Bows
    [`WEAPON_BOW`] = "weapon_bow.png",
    [`WEAPON_BOW_IMPROVED`] = "weapon_bow_improved.png",

    -- Special Items
    [`WEAPON_LASSO`] = "weapon_lasso.png",
    [`WEAPON_LASSO_REINFORCED`] = "weapon_lasso_reinforced.png",
    [`WEAPON_FISHINGROD`] = "weapon_fishingrod.png",
    [`WEAPON_KIT_CAMERA`] = "weapon_kit_camera.png",
    [`WEAPON_KIT_CAMERA_ADVANCED`] = "weapon_kit_camera_advanced.png",
    [`WEAPON_KIT_BINOCULARS`] = "weapon_kit_binoculars.png",
    [`WEAPON_KIT_METAL_DETECTOR`] = "weapon_kit_detector.png",
    [`WEAPON_MOONSHINEJUG_MP`] = "weapon_moonshinejug.png",

    -- Unarmed
    [`WEAPON_UNARMED`] = "weapon_blank.png"
}


Config.HUDLayouts = {
    standart = {
        [".details-group > .time:first"] = {
            position = "fixed",
            left = "2.6042vw",
            top = "2.0833vw",
            marginLeft = "0vw",
            marginTop = "0vw",
            transform = "none"
        },
        [".details-group > .date"] = {
            position = "fixed",
            left = "9.3750vw",
            top = "2.0833vw",
            marginLeft = "0vw",
            marginTop = "0vw",
            transform = "none"
        },
        [".details-group > .weather-group"] = {
            position = "fixed",
            left = "18.2292vw",
            top = "2.0833vw",
            marginLeft = "0vw",
            marginTop = "0vw",
            transform = "none"
        },
        [".details-group > .time:last"] = {
            position = "fixed",
            left = "2.6042vw",
            top = "4.6875vw",
            marginLeft = "0vw",
            marginTop = "0vw",
            transform = "none"
        },
        [".details-group > .money"] = {
            position = "fixed",
            left = "8.8542vw",
            top = "4.6875vw",
            marginLeft = "0vw",
            marginTop = "0vw",
            transform = "none"
        },
        [".weapon-hud-group"] = {
            position = "fixed",
            left = "83.0729vw",
            top = "2.6042vw",
            marginLeft = "0vw",
            marginTop = "0vw",
            transform = "none"
        },
        [".weapon-hud-group-secondary"] = {
            position = "fixed",
            left = "83.0729vw",
            top = "6.1979vw",
            marginLeft = "0vw",
            marginTop = "0vw",
            transform = "none"
        },
        [".horse-hud-group"] = {
            position = "fixed",
            left = "85.4167vw",
            top = "47.9167vw",
            marginLeft = "0vw",
            marginTop = "0vw",
            transform = "none"
        },
        [".horse-health"] = {
            position = "fixed",
            left = "40.0977vw",
            top = "51.0417vw",
            marginLeft = "0vw",
            marginTop = "0vw",
            transform = "none"
        },
        [".horse-durabilty"] = {
            position = "fixed",
            left = "43.2292vw",
            top = "51.0417vw",
            marginLeft = "0vw",
            marginTop = "0vw",
            transform = "none"
        },
        [".temparature-group"] = {
            position = "fixed",
            left = "36.9735vw",
            top = "51.0417vw",
            marginLeft = "0vw",
            marginTop = "0vw",
            transform = "none"
        },
        [".voice"] = {
            position = "fixed",
            left = "15.0000vw",
            top = "47.8125vw",
            marginLeft = "0vw",
            marginTop = "0vw",
            transform = "none"
        },
        [".health"] = {
            position = "fixed",
            left = "15.1042vw",
            top = "51.0417vw",
            marginLeft = "0vw",
            marginTop = "0vw",
            transform = "none"
        },
        [".stamina"] = {
            position = "fixed",
            left = "18.2292vw",
            top = "51.0417vw",
            marginLeft = "0vw",
            marginTop = "0vw",
            transform = "none"
        },
        [".hunger"] = {
            position = "fixed",
            left = "24.4792vw",
            top = "51.0417vw",
            marginLeft = "0vw",
            marginTop = "0vw",
            transform = "none"
        },
        [".water"] = {
            position = "fixed",
            left = "21.3542vw",
            top = "51.0417vw",
            marginLeft = "0vw",
            marginTop = "0vw",
            transform = "none"
        },
        [".brain"] = {
            position = "fixed",
            left = "27.6042vw",
            top = "51.0417vw",
            marginLeft = "0vw",
            marginTop = "0vw",
            transform = "none"
        },
        [".bath"] = {
            position = "fixed",
            left = "33.8542vw",
            top = "51.0417vw",
            marginLeft = "0vw",
            marginTop = "0vw",
            transform = "none"
        },
        [".toilet"] = {
            position = "fixed",
            left = "30.7292vw",
            top = "51.0417vw",
            marginLeft = "0vw",
            marginTop = "0vw",
            transform = "none"
        },
        [".compass"] = {
            position = "fixed",
            left = "50vw",
            top = "2vw",
            marginLeft = "-10vw", -- Half of default width (20vw)
            marginTop = "0vw",
            transform = "none"
        }
    },
    normal = {
        [".details-group > .time:first"] = {
            position = "fixed",
            left = "3.1250vw",
            top = "1.0417vw",
            marginLeft = "0vw",
            marginTop = "0vw",
            transform = "none"
        },
        [".details-group > .date"] = {
            position = "fixed",
            left = "3.1250vw",
            top = "3.1250vw",
            marginLeft = "0vw",
            marginTop = "0vw",
            transform = "none"
        },
        [".details-group > .weather-group"] = {
            position = "fixed",
            left = "3.1250vw",
            top = "5.2083vw",
            marginLeft = "0vw",
            marginTop = "0vw",
            transform = "none"
        },
        [".details-group > .time:last"] = {
            position = "fixed",
            left = "3.1250vw",
            top = "9.3750vw",
            marginLeft = "0vw",
            marginTop = "0vw",
            transform = "none"
        },
        [".details-group > .money"] = {
            position = "fixed",
            left = "3.1250vw",
            top = "7.2917vw",
            marginLeft = "0vw",
            marginTop = "0vw",
            transform = "none"
        },
        [".weapon-hud-group"] = {
            position = "fixed",
            left = "83.0729vw",
            top = "2.6042vw",
            marginLeft = "0vw",
            marginTop = "0vw",
            transform = "none"
        },
        [".weapon-hud-group-secondary"] = {
            position = "fixed",
            left = "83.0729vw",
            top = "6.1979vw",
            marginLeft = "0vw",
            marginTop = "0vw",
            transform = "none"
        },
        [".horse-hud-group"] = {
            position = "fixed",
            left = "85.4167vw",
            top = "47.9167vw",
            marginLeft = "0vw",
            marginTop = "0vw",
            transform = "none"
        },
        [".horse-health"] = {
            position = "fixed",
            left = "92.1875vw",
            top = "44.2708vw",
            marginLeft = "0vw",
            marginTop = "0vw",
            transform = "none"
        },
        [".horse-durabilty"] = {
            position = "fixed",
            left = "95.3125vw",
            top = "44.2708vw",
            marginLeft = "0vw",
            marginTop = "0vw",
            transform = "none"
        },
        [".temparature-group"] = {
            position = "fixed",
            left = "94.7917vw",
            top = "22.9167vw",
            marginLeft = "0vw",
            marginTop = "0vw",
            transform = "none"
        },
        [".voice"] = {
            position = "fixed",
            left = "14.5833vw",
            top = "50.5208vw",
            marginLeft = "0vw",
            marginTop = "0vw",
            transform = "none"
        },
        [".health"] = {
            position = "fixed",
            left = "94.7917vw",
            top = "7.2917vw",
            marginLeft = "0vw",
            marginTop = "0vw",
            transform = "none"
        },
        [".stamina"] = {
            position = "fixed",
            left = "94.7917vw",
            top = "10.4167vw",
            marginLeft = "0vw",
            marginTop = "0vw",
            transform = "none"
        },
        [".hunger"] = {
            position = "fixed",
            left = "94.7917vw",
            top = "13.5417vw",
            marginLeft = "0vw",
            marginTop = "0vw",
            transform = "none"
        },
        [".water"] = {
            position = "fixed",
            left = "94.7917vw",
            top = "16.6667vw",
            marginLeft = "0vw",
            marginTop = "0vw",
            transform = "none"
        },
        [".brain"] = {
            position = "fixed",
            left = "94.7917vw",
            top = "19.7917vw",
            marginLeft = "0vw",
            marginTop = "0vw",
            transform = "none"
        },
        [".bath"] = {
            position = "fixed",
            left = "94.7917vw",
            top = "29.1667vw",
            marginLeft = "0vw",
            marginTop = "0vw",
            transform = "none"
        },
        [".toilet"] = {
            position = "fixed",
            left = "94.7917vw",
            top = "26.0417vw",
            marginLeft = "0vw",
            marginTop = "0vw",
            transform = "none"
        }
    },
    story = {
        [".details-group > .time:first"] = {
            position = "fixed",
            left = "2.6042vw",
            top = "2.0825vw",
            marginLeft = "0vw",
            marginTop = "0vw",
            transform = "none"
        },
        [".details-group > .date"] = {
            position = "fixed",
            left = "9.3750vw",
            top = "2.0825vw",
            marginLeft = "0vw",
            marginTop = "0vw",
            transform = "none"
        },
        [".details-group > .weather-group"] = {
            position = "fixed",
            left = "18.2292vw",
            top = "2.0825vw",
            marginLeft = "0vw",
            marginTop = "0vw",
            transform = "none"
        },
        [".details-group > .time:last"] = {
            position = "fixed",
            left = "2.6042vw",
            top = "4.6875vw",
            marginLeft = "0vw",
            marginTop = "0vw",
            transform = "none"
        },
        [".details-group > .money"] = {
            position = "fixed",
            left = "8.8542vw",
            top = "4.6875vw",
            marginLeft = "0vw",
            marginTop = "0vw",
            transform = "none"
        },
        [".weapon-hud-group"] = {
            position = "fixed",
            left = "83.0719vw",
            top = "2.6042vw",
            marginLeft = "0vw",
            marginTop = "0vw",
            transform = "none"
        },
        [".weapon-hud-group-secondary"] = {
            position = "fixed",
            left = "83.0719vw",
            top = "6.1971vw",
            marginLeft = "0vw",
            marginTop = "0vw",
            transform = "none"
        },
        [".compass"] = {
            position = "fixed",
            left = "40.0000vw",
            top = "1.9995vw",
            marginLeft = "0vw",
            marginTop = "0vw",
            transform = "none"
        },
        [".horse-hud-group"] = {
            position = "fixed",
            left = "85.4167vw",
            top = "47.9167vw",
            marginLeft = "0vw",
            marginTop = "0vw",
            transform = "none"
        },
        [".horse-health"] = {
            position = "fixed",
            left = "1.0417vw",
            top = "49.4792vw",
            marginLeft = "0vw",
            marginTop = "0vw",
            transform = "none"
        },
        [".horse-durabilty"] = {
            position = "fixed",
            left = "1.0417vw",
            top = "46.3542vw",
            marginLeft = "0vw",
            marginTop = "0vw",
            transform = "none"
        },
        [".temparature-group"] = {
            position = "fixed",
            left = "14.5833vw",
            top = "48.9583vw",
            marginLeft = "0vw",
            marginTop = "0vw",
            transform = "none"
        },
        [".voice"] = {
            position = "fixed",
            left = "17.1875vw",
            top = "50.5208vw",
            marginLeft = "0vw",
            marginTop = "0vw",
            transform = "none"
        },
        [".health"] = {
            position = "fixed",
            left = "9.3750vw",
            top = "40.1042vw",
            marginLeft = "0vw",
            marginTop = "0vw",
            transform = "none"
        },
        [".stamina"] = {
            position = "fixed",
            left = "6.2500vw",
            top = "40.1042vw",
            marginLeft = "0vw",
            marginTop = "0vw",
            transform = "none"
        },
        [".hunger"] = {
            position = "fixed",
            left = "11.9792vw",
            top = "41.6667vw",
            marginLeft = "0vw",
            marginTop = "0vw",
            transform = "none"
        },
        [".water"] = {
            position = "fixed",
            left = "3.6458vw",
            top = "41.1458vw",
            marginLeft = "0vw",
            marginTop = "0vw",
            transform = "none"
        },
        [".brain"] = {
            position = "fixed",
            left = "14.5833vw",
            top = "46.3542vw",
            marginLeft = "0vw",
            marginTop = "0vw",
            transform = "none"
        },
        [".bath"] = {
            position = "fixed",
            left = "1.5625vw",
            top = "43.2292vw",
            marginLeft = "0vw",
            marginTop = "0vw",
            transform = "none"
        },
        [".toilet"] = {
            position = "fixed",
            left = "14.0625vw",
            top = "43.7500vw",
            marginLeft = "0vw",
            marginTop = "0vw",
            transform = "none"
        }
    }
}
