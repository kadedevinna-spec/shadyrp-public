Config = {}
Config.Language = "en"
Config.DebugHudData = false -- If true, the hud data will be printed in the console every time it is updated. Useful for debugging and creating custom huds.
Config.Debug = false -- If true, debug logs (e.g. hideHud calls) will be printed in the F8 console.
Config.Locale = {
    ["en"] = {
        ["loaded"] = "Hud data loaded!", 
        ["saved"] = "Hud data saved!", 
        ["coldmessage"] = "It's cold, you're cold!", 
        ["hotmessage"] = "It's so hot, you're burning up!", 
        ["onlyhorse"] = "You can only use it on a horse!", 
        ["hunger"] = "You're hungry!", 
        ["thirsty"] = "You're thirsty!", 
        ["usableitem"] = "Bon Appetit!", 
        ["promptsmoketitle"] = "Smoking Interaction", 
        ["stopsmoking"] = "Stop Smoking", 
        ["smoke"] = "Smoke", 
        ["stance"] = "Stance", 
        ["dragmessage"] = "You can change the location of the huds by dragging them with the mouse!", 
        ["remainingUsage"] = "Remaining Usage: ${val}",
        ["bandage"] = "Using bandages..",
        ["itemIsDegradable"] = "${label} is spoilt and unusable",
        ["notuniqueItem"] = "Item Name: ${itemName}, since this item is not set as unique, the usageLimit property cannot be used. Notify the server owner.",
        ["animationinprogress"] = "You cannot use another item while you have an active animation!",
        ["progressBar"] = "You used ${item}..",
        ["neartown"] = "Near",
        ["unkownneartown"] = "Unknown Near",
        ["levelup"] = "Congratulations! You've leveled up to level ~t2~${level}!",
        ["invalid_params"] = "Invalid parameters. Usage: /command [playerId] [value]",
        ["xp_removed"] = "Successfully removed ${xp} XP from player ${playerId}.",
        ["xp_lost"] = "You have lost ${xp} XP.",
        ["xp_added"] = "You have given ${xp} XP to player ${playerId}.",
        ["xp_received"] = "You have received ${xp} XP.",
        ["current_xp"] = "Player ${playerId} has ${xp} XP.",
        ["current_level"] = "Player ${playerId} is currently at level ${level}.",
        ["no_permission"] = "You do not have permission to use this command.",
        ["item_cooldown"] = "You must wait ${seconds} seconds before using ${item} again.",
        ["missingRequiredItem"] = "You do not have the necessary elements to use this item..",
        ["cantuseitemwater"] = "You can't use this item while you're in water!",
        ["interaction_failed"] = "The interaction failed. Please try again later.",
        ["hometitle"] = "HOME",
        ["coloringtitle"] = "COLORING",
        ["resizingtitle"] = "RESIZING",
        --- UI PANEL ---
        ["ui_setting_title"]      = "SETTING",
        ["ui_default_settings"]   = "DEFAULT SETTINGS",
        ["ui_change_position"]    = "CHANGE POSITION",
        ["ui_huds_tab"]           = "HUDS",
        ["ui_stats_tab"]          = "STATS",
        ["ui_hide_show"]          = "HIDE/SHOW",
        ["ui_progress"]           = "PROGRESS",
        ["ui_icon"]               = "ICON",
        ["ui_huds_title"]         = "HUDS",
        ["ui_select_all"]         = "SELECT ALL",
        ["ui_stats_title"]        = "STATS",
        ["ui_description"]        = "HUDs are divided into two colors. The first is the color of the outer progress bar, and the second is the color of the icon inside the circular bar. The color of the icon/image for the player's and horse's health and stamina does not change.",
        ["ui_description_step1"]  = "First, click on the HUD whose color you want to change.",
        --- NOTIFY LABELS ---
        ["notify_success"]  = "SUCCESS",
        ["notify_error"]    = "ERROR",
        ["notify_info"]     = "INFO",
        ["notify_warning"]  = "WARNING",
        ["notify_announce"] = "ANNOUNCE",
        --- HUD NAMES ---
        ["hud_health"]        = "Health",
        ["hud_stamina"]       = "Stamina",
        ["hud_hunger"]        = "Hunger",
        ["hud_thirst"]        = "Thirst",
        ["hud_stress"]        = "Stress",
        ["hud_pvp"]           = "PVP",
        ["hud_armour"]        = "Armour",
        ["hud_dirty"]         = "Dirty",
        ["hud_microphone"]    = "Microphone",
        ["hud_temp"]          = "Temperature",
        ["hud_onesync"]       = "OneSync",
        ["hud_alcohol"]       = "Alcohol",
        ["hud_horse_health"]  = "Horse Health",
        ["hud_horse_stamina"] = "Horse Stamina",
        ["hud_horse_dirty"]   = "Horse Dirty",
        ["hud_level"]         = "Level",
        --- MENU ---
        ["pvpoff_notify"] = "You are now friendly to everyone!",
        ["pvpon_notify"] = "You are now unfriendly to everyone!",
        ["pvpoff_chat"] = "You have set your PVP status to OFF. You will not be able to attack or be attacked by other players.",
        ["pvpon_chat"] = "You have set your PVP status to ON. You can now attack and be attacked by other players.",
        ["system"] = "SYSTEM",
    },
}

-- img/core = hud icon
-- meter = outer progress
Config.currentHudColorData = {
    ["#health-core"] = "#ffffff",
    ["#stamina-core"] = "#ffffff",
    ["#hunger-core"] = "#ffffff",
    ["#thirst-core"] = "#ffffff",
    ["#pvp-core"] = "#ffffff",
    ["#stress-core"] = "#ffffff",
    ["#dirty-core"] = "#ffffff",
    ["#armour-core"] = "#ffffff",
    ["#microphone-core"] = "#ffffff",
    ["#temp-core"] = "#ffffff",
    ["#onesync-core"] = "#ffffff",
    ["#alcohol-core"] = "#ffffff",
    ["#level-core"] = "#ffffff",
    ["#horse-health-core"] = "#ffffff",
    ["#horse-stamina-core"] = "#ffffff",
    ["#horse-dirty-core"] = "#ffffff",

    ["#health-meter"] = "#ffffff",
    ["#stamina-meter"] = "#ffffff",
    ["#hunger-meter"] = "#ffffff",
    ["#thirst-meter"] = "#ffffff",
    ["#pvp-meter"] = "#ffffff",
    ["#armour-meter"] = "#ffffff",
    ["#stress-meter"] = "#ffffff",
    ["#dirty-meter"] = "#ffffff",
    ["#microphone-meter"] = "#ffffff",
    ["#temp-meter"] = "#ffffff",
    ["#onesync-meter"] = "#ffffff",
    ["#alcohol-meter"] = "#ffffff",
    ["#level-meter"] = "#ffffff",
    ["#horse-health-meter"] = "#ffffff",
    ["#horse-stamina-meter"] = "#ffffff",
    ["#horse-dirty-meter"] = "#ffffff"
}

local function generateHudLayout(data)
    local hudClasses = {
        ".alcohol", ".onesync", ".temp", ".microphone", ".horse-stamina",
        ".dirty", ".horse-dirty", ".level", ".horse-health", ".thirst",
        ".stress", ".pvp", ".armour", ".hunger", ".stamina", ".health"
    }
    local layout = {}
    for _, class in pairs(hudClasses) do
        layout[class] = {
            position = "relative",
            display = "flex",
            left = "0%",
            top = data.top,
            width = data.width,
            height = data.height,
            borderRadius = "50%",
            overflow = "visible",
            statImgWidth = "25%"
        }
    end
    layout[".cash"] = { position = "absolute", left = "70.5%", top = "96.8%", width = "auto", height = "auto", fontSize = "1.2vh" }
    layout[".gold"] = { position = "absolute", left = "75.5%", top = "96.8%", width = "auto", height = "auto", fontSize = "1.2vh" }
    layout[".hour"] = { position = "absolute", left = "79.5%", top = "96.8%", width = "auto", height = "auto", fontSize = "1.2vh" }
    layout[".id"] = { position = "absolute", left = "83.5%", top = "96.8%", width = "auto", height = "auto", fontSize = "1.2vh" }
    layout[".locations"] = { position = "absolute", left = "0.2%", top = "90%", width = "auto", height = "auto", fontSize = "1.0vh", areaFontSize = "1.2vh", txtFontSize = "1.3vh"}
    layout[".notify-container"] = { position = "absolute", right = "0%", top = "15%", width = "16%", height = "max-content"}
    return layout
end

Config.currentHudPositionData = {
    ["1920x1080"] = generateHudLayout({width = "2.0%", height = "3.5%", top = "96%"}),
    ["2560x1440"] = generateHudLayout({width = "1.9%", height = "3.3%", top = "96.5%"}),
    ["2560x1080"] = generateHudLayout({width = "1.9%", height = "3.3%", top = "96.5%"}),
    ["1280x720"] = generateHudLayout({width = "2.5%", height = "4.5%", top = "96%"}),
    ["1600x900"] = generateHudLayout({width = "2.2%", height = "4.0%", top = "96%"}),
    ["3440x1440"] = generateHudLayout({width = "1.9%", height = "3.3%", top = "96.5%"}),
    ["3840x2160"] = generateHudLayout({width = "1.9%", height = "3.3%", top = "96.2%"})
}

-- NEW UPDATE

Config.armourHash = {

    male = {
        [1] = 989985828,
        [2] = 1631153824,
        [3] = 1814257258,
        [4] = 2051996353,
        [5] = 2262143950,
        [6] = 2465639440,
        [7] = 2706655435,
        [8] = 3377502403,
        [9] = 3817803097,
        [10] = 4170970969
    },

    female = {
        [1] = 899778996,
        [2] = 1177299657,
        [3] = 1953793889,
        [4] = 2637027539,
        [5] = 2763804176,
        [6] = 2927139856,
        [7] = 2949676568,
        [8] = 3130168220,
        [9] = 3885755822,
        [10] = 4048158986
    }
}

Config.ArmourSettings = {
    maxArmour = 600,
    useArmourClothing = true,
    forceEquip = true, -- If true, the player's armour will be forced to be equipped with the specified clothing item. If false, the player can choose whether to equip the armour or not.
    commandCoat = "coat", -- Command to equip/unequip coat armour / Fixed to coat because of the way the system works
    maleArmour = Config.armourHash.male[2],
    femaleArmour = Config.armourHash.female[6],
    armourCategory = 0x72E6EF74,
    animation = {
        use = true,
        dict = "mech_inventory@clothing@outfit_change",
        anim = "outfit_change_unarmed",
    },
}

Config.InGameAdminHudLoadCommand = "hudload" -- Command to load your hud /only run client (admin)
Config.CmdHudLoadAllPlayerCommand = "loadhud" -- Command to load hud for all players /only run server cmd
Config.UsePvpSystem = false -- If false, the pvp system will be disabled, and the pvp command will not work. You can still use the /pvp command to change your pvp status, but it won't affect your interactions with other players.
Config.PvpCommand = "pvp" -- /pvp on or /pvp off (Friendly or Unfriendly to all players)
Config.AnnounceCommand = "duyuru" -- /duyuru text (Notify All Players)
Config.CombatLogDeath = true -- if false, when you exit dead and enter the game, your health and stamina will be full.
Config.DisableNumbersAboveCores = false -- NEW!!!
Config.HealAdminCommand = "heal" -- /heal id or /heal
Config.DegreeUnit = "C" -- OR F (Temp Setting) If you set it to “F” you must update the maximum temperature and coldness values in Config.Temperature.
Config.HudMenuCommand = "hudmenu"
Config.UseMapCode = true        -- If there is a map setting in another script, set it to false. For example, if vorp_core's script works
Config.mapTypeOnFoot = 1        -- Radar type when on foot. 0 = Off, 1 = Regular, 2 = Expanded, 3 = Simple (compass).
Config.mapTypeOnMount = 1       -- Radar type when on horse. Same options as on foot.
Config.SaveStatusInterval = 10 -- Minute
Config.LiveCacheSyncIntervalMs = 10000 -- Millisecond. Periodic sync (only when values changed).

Config.DisableRedmCores = false

Config.SpeakerSettings = {
    ShowDistance = 15, --- 15m show icon
    SpeakerIconHash = GetHashKey('SPEAKER'), -- https://pastebin.com/xx6rEgiG
    SpeakerIconColor = GetHashKey('COLOR_YELLOWSTRONG'), --- https://github.com/femga/rdr3_discoveries/blob/master/useful_info_from_rpfs/colours/README.md
}

Config.HudAutoHide = true  -- For example, if stress is 0, it will be hidden automatically.

Config.HideHuds = { -- Set to true if there is a hud you do not want to use
    -- STATS
    cash = false,
    gold = false,
    logo = false,
    hour = false,
    id = false,
    locations = false,
    -- HUD
    level = false,
    dirty = false,
    stress = false,
    pvp = false,
    armour = false,
    alcohol = false,
    temp = false,
    onesync = false,
}

Config.VoiceAndProximity = {
    ShowSpeakerIcon    = true,                                     -- Speaker icon above talking players
    VoiceRangeChangeUi = true,                                     -- Popup above character when range changes
    ShowRangeCircle    = true,                                     -- Ground circle when voice range changes
    CircleShowTime     = 3,                                        -- Seconds the circle stays visible
    CircleRangeColors  = {                                         -- Her voice range için ayrı renk
        ["3.0"]  = { Hex = "#5b9bd5" },                           -- Fısıltı  → mavi
        ["7.0"]  = { Hex = "#c8922a" },                           -- Normal   → amber
        ["15.0"] = { Hex = "#e07b2a" },                           -- Yüksek   → turuncu
        ["32.0"] = { Hex = "#d94040" },                           -- Çığlık   → kırmızı
    },
}

Config.VoiceChat = "pma-voice" -- "saltychat" -- pma-voice -- yaca (If you are using mumble, leave it as pma-voice.)
Config.VoiceChatDistances = { ---- should be the same as the values in your sound script.
    ["3.0"] = 25,
    ["7.0"] = 50,
    ["15.0"] = 75,
    ["32.0"] = 100,
}

Config.Levels = {
    --[level] = needed xp,
    [1] = 1000, -- needed xp
    [2] = 2000, -- needed xp
    [3] = 3000, -- needed xp
    [4] = 4000, -- needed xp
    [5] = 5000, -- needed xp
    [6] = 6000, -- needed xp
    [7] = 7000, -- needed xp
    [8] = 8000, -- needed xp
    [9] = 9000 -- needed xp
}

Config.Temperature = {
    -- General settings for temperature effects
    cold = -15,  -- Temperature value considered cold (below this threshold is cold)
    hot = 50,    -- Temperature value considered hot (above this threshold is hot)
    Damage = 5,  -- The amount of damage taken due to extreme temperatures
    showNotify = true,  -- Show temperature notifications to the player
    checkSecond = 10,   -- Interval (in seconds) for temperature checks
    imgColorChangeOnValue = true, -- Enable image color change based on temperature

    -- Color gradient settings based on temperature ranges for HUD display
    Colors = {
        cold = { 
            valueRange = {5, -40},  -- Temperature range for cold effect
            colors = {
                { threshold = 5, r = 89, g = 189, b = 255 },   -- Starting color
                { threshold = -5, r = 4, g = 130, b = 214 },    -- Mid-range color
                { threshold = -15, r = 0, g = 93, b = 214 },    -- Final cold color
            }
        },
        hot = { 
            valueRange = {5, 50},  -- Temperature range for hot effect
            colors = {
                { threshold = 10, r = 255, g = 247, b = 105 },  -- Starting color
                { threshold = 20, r = 230, g = 182, b = 9 },    -- Mid-range color
                { threshold = 30, r = 255, g = 101, b = 18 },    --  Final hot color 
            }
        }
    },
    -- WearingValues: Clothing insulation values to reduce temperature effects
    WearingValues = {
        ["hat"] = 1.0,    -- How much insulation a hat provides
        ["shirt"] = 1.0,  -- How much insulation a shirt provides
        ["pants"] = 2.0,  -- Insulation provided by pants
        ["boots"] = 2.5,  -- Insulation provided by boots
        ["coat"] = 4.0,   -- A full coat provides high insulation
        ["opencoat"] = 2.0, -- An open coat provides less insulation than a full coat
        ["gloves"] = 1.0,  -- Insulation from gloves
        ["vest"] = 1.0,    -- Insulation from a vest
        ["poncho"] = 2.0,  -- Ponchos provide moderate insulation
        ["skirts"] = 0.5,  -- Skirts provide minimal insulation
        ["chaps"] = 2.0    -- Chaps provide moderate insulation
    }
}

-- The following configuration shows the refresh/recharge of the outer and inner core values. 
-- If you want more detailed information about these settings, take a look at the loops in c/opensource.lua.
Config.RechargeHuds = {
    health = {
        recharge = true,
        SetPlayerHealthRechargeMultiplier = 1.3,
        reChargeTime = 1,
    },
    stamina = {
        recharge = true,
        rechargeSwimming = true, -- If you want stamina to recharge while swimming, set it to true c/opensource.lua line 287
        rechargeSwimmingValue = 5, -- How much stamina will be recharged while swimming (When you stop swimming with the paddle shift, your stamina begins to recover.)
        SetPlayerStaminaRechargeMultiplier = 1.3,
        reChargeTime = 1,
    },
    horsehealth = {
        recharge = true,
        SetHealthRechargeMultiplier = 1.2,
        reChargeTime = 1,
    },
    horsestamina = {
        recharge = false, --- If your stable script doesn't have anything about horse stamina regeneration, set it to true, but most stable scripts do regenerate horse stamina
        SetStaminaRechargeMultiplier = 1.2,
        reChargeTime = 1,
    },
    healthCore = {
        recharge = true,
        rechargeValue = 1, -- Decimal numbers such as 0.5 are not used in Core values, only whole numbers are supported
        reChargeTime = 4,
    },
    staminaCore = {
        recharge = true,
        rechargeValue = 1, -- Decimal numbers such as 0.5 are not used in Core values, only whole numbers are supported
        reChargeTime = 4,
    },
    horsehealthCore = {
        recharge = true,
        rechargeValue = 1, -- Decimal numbers such as 0.5 are not used in Core values, only whole numbers are supported
        reChargeTime = 4,
    },
    horsestaminaCore = {
        recharge = true,
        rechargeValue = 1, -- Decimal numbers such as 0.5 are not used in Core values, only whole numbers are supported
        reChargeTime = 4,
    },
}

Config.CheckHungerAndThirstTick = 120 -- second
Config.decreaseSprintRemoveValueTick = 1 -- Second
Config.HudSettings = {
    Stress = { -- or false
        speeding = true, -- or false (Will it gain stress when running fast or running with the wagon?)
        shooting = false, -- or false (Will the stress level increase when shooting?)
        speedingValue = 33.0, -- If the player's speed exceeds 35.0, the stress level will start to increase. horse and vagon maximum speed 35.0 player run 17.5
        speedStress = 1.0, -- How much stress the player will gain every 1 second if they exceed the speedingValue limit
        shootingchange = 100, -- 1-100 What percentage chance the player will win stress when he shoots
        shootingStress = 1.0, -- How much stress will the player gain when he shoots
        shakeScreenValue = 70, -- If the stress level is greater than shakeScreenValue, the player's screen will dim and light up (If you don't want to use it, leave it as 101)
        ShakeGameplayCam = { -- Stress Effect
            Effect = "SMALL_EXPLOSION_SHAKE",
            Value = 0.32,
        }
    },
    Dirty = { -- or false
        minimumDirtyValue = 80,
        flyEffect = true, -- NEW !!
        AutoMessage = false,
        emoteMessage = "do The person emits bad odours",
        checkMinute = 3,
    },
    Stamina = {
        SetPlayerStaminaSprintDepletionMultiplier = false, --- or 1.0-1.1-1.2... Reduce endurance when running - SetPlayerStaminaSprintDepletionMultiplier = 1.0 means default stamina decrease, SetPlayerStaminaSprintDepletionMultiplier = 1.2 means 20% more stamina decrease when sprinting
        removeHealthOnNoStamina = true, -- Remove Health in the Absence of Stamina
        removeHealthOnNoStaminaValue = 10, -- The player's health (max 600) will be reduced by 25 every 5 seconds, for example
        removeHealthOnNoStaminaWait = 5, -- How many seconds will a player's health drop
    },
    Hunger = {
        decreaseValue = 0.3, 
        decreaseSprintRemoveValue = false, 
        decreaseOnRunningValue = 0.2, 
        hotValue = 45.0, -- Hot Decrease
        decreaseOnHotValue = 1.0,
        decreaseOnRemoveHealthValue = 15, --- or false (If the hunger value is less than 0, the player's health will decrease by the specified value)
    },
    Thirst = {
        decreaseValue = 0.3, 
        decreaseSprintRemoveValue = true, 
        decreaseOnRunningValue = 0.3, 
        hotValue = 45.0, -- Hot Decrease
        decreaseOnHotValue = 1.0,
        decreaseOnRemoveHealthValue = 15, --- or false (If the thirst value is less than 0, the player's health will decrease by the specified value)
    },
    Alcohol = {
        minimumValue = 70,
        drunkWalking = true, -- if true, your gait will resemble a drunken walk according to the alcohol level
        alcoholEffect = false,-- alcohol level if true on the screen if above the minimumValue starts the effect entered in effectName
        effectName = "PlayerDrunkSaloon1",
        AutoMessage = false,
        emoteMessage = "do The person smells of alcohol",
        checkMinute = 5,
        ResetAlcohol = {
            decreaseOnAlcohol = 10, -- If the alcohol value is above %85, a decrease occurs until 0
            RemoveAlcoholValue = 5, -- Every 4 seconds the alcohol level will decrease by 5 values
            RemoveTime = 10, -- RemoveAlcoholValue will drop the RemoveAlcoholValue value from the alcohol value every specified second
        }
    },
    Level = {
        useLevel = true, -- If false, level and experience system will be disabled
        autoExpLoop = {
            enable = true, -- If true, the player will gain experience automatically at specified intervals
            expValue = 20, -- The amount of experience the player will gain at each interval
            loopTime = 5, -- The interval (in minutes) at which the player gains experience
        }
    }
}

function Notify(data)
    local text = data.text or "No message" 
    local time = data.time or 5000  
    local type = data.type or "info" 
    local dict = data.dict
    local icon = data.icon
    local color = data.color or 0
    local src = data.source

    if IsDuplicityVersion() then
        if Framework == "RSG" then
            -- TriggerClientEvent('ox_lib:notify', src, { title = text, type = type, duration = time })
            TriggerClientEvent("fx-hud:client:showNotify",src, text, time, type)
        elseif Framework == "VORP" then
            if icon then
                TriggerClientEvent('vorp:ShowAdvancedRightNotification', src, text, dict, icon, color, time)
            else
                -- TriggerClientEvent("vorp:TipBottom",src, text, time, type)
                TriggerClientEvent("fx-hud:client:showNotify",src, text, time, type)
            end
        end
    else
        if Framework == "RSG" then
            -- TriggerEvent('ox_lib:notify', { title = text, type = type, duration = time })
            TriggerEvent("fx-hud:client:showNotify", text, time, type)
        elseif Framework == "VORP" then
            if icon then
                TriggerEvent("vorp:ShowAdvancedRightNotification", text, dict, icon, color, time)
            else
                -- TriggerEvent("vorp:TipBottom", text, time, type)
                TriggerEvent("fx-hud:client:showNotify", text, time, type)
            end
        end
    end
end

function Locale(key,subs)
    local translate = Config.Locale[Config.Language][key] and Config.Locale[Config.Language][key] or "Config.Locale["..Config.Language.."]["..key.."] doesn't exits"
    subs = subs and subs or {}
    for k, v in pairs(subs) do
        local templateToFind = '%${' .. k .. '}'
        translate = translate:gsub(templateToFind, tostring(v))
    end
    return tostring(translate)
end
