lib.locale()
Config = {}

Config.debug = true -- false to disable not for production!!!!!
Config.framework = "rsg" -- "rsg" for RSGCore
Config.interact = "ox_target" -- "ox_target" for ox_target | "rsg" for RSG prompts
Config.notify = "ox" -- "ox" for ox_lib | "rsg" for rsg core
Config.progressbar = "ox_lib" -- "ox_lib" for ox_lib | "custom" for custom
Config.cooldownSettings = {
    cooldown = 30, -- in minutes
    maxGravesBeforeCooldown = 5, -- max graves before cooldown starts for player
}

Config.ExtraItemNotify = false -- This is a custom request, it enables normal notifications on top of the item box that already exists for items recieved.

-- Grave reset timer settings
Config.graveResetSettings = {
    enabled = true, -- Enable automatic grave resets
    resetTime = 60, -- Time in minutes before graves reset (60 = 1 hour)
}

-- Only if using prompts
Config.Keybind = {
    rummageThroughDirt = "G" -- Keybind for rummaging through dirt
}

-- Prompt configuration
Config.Prompts = {
    RummageDirt = "Rummage through dirt"
}

Config.lawmen = {
    minLawmen = 0, -- Minimum lawmen required to start robbery
    jobType = 'leo', -- Job type for law enforcement
}

Config.lawmanAlerts = {
    enabled = true,
    chance = 100, -- 25% chance to alert lawmen when grave is robbed
    alertCooldown = 300, -- 5 minutes cooldown between alerts (in seconds)
    lastAlert = 0, -- Will be set dynamically
    blipTime = 5, -- 5 minutes blip time
}

Config.Animation = {
    Dig = {
        dict = 'amb_work@world_human_gravedig@working@male_b@idle_a',
        anim = 'idle_a',
        flag = 1,
    },
    Rummage = {
        dict = 'script_common@shared_scenarios@kneel@rummage@male_a@idle_c',
        anim = 'idle_h',
        flag = 1,
    }
}

Config.Progressbar = {
    duration = 15000,
}

Config.Graves = {
    --=@ Rhodes @=--
    { id = 1, coords = vec3(1284.86, -1245.25, 78.86), radius = 0.5, prompt = 'grave_1' },
    { id = 2, coords = vec3(1283.74, -1247.74, 78.36), radius = 0.5, prompt = 'grave_2' },
    { id = 3, coords = vec3(1281.17, -1240.90, 79.23), radius = 0.5, prompt = 'grave_3' },
    { id = 4, coords = vec3(1278.92, -1241.85, 78.93), radius = 0.5, prompt = 'grave_4' },
    { id = 5, coords = vec3(1276.85, -1242.74, 78.71), radius = 0.5, prompt = 'grave_5' },
    { id = 6, coords = vec3(1272.38, -1237.46, 78.91), radius = 0.5, prompt = 'grave_6' },
    { id = 7, coords = vec3(1274.49, -1236.39, 79.20), radius = 0.5, prompt = 'grave_7' },
    { id = 8, coords = vec3(1276.69, -1235.48, 79.40), radius = 0.5, prompt = 'grave_8' },
    { id = 9, coords = vec3(1269.41, -1234.53, 78.86), radius = 0.5, prompt = 'grave_9' },
    { id = 10, coords = vec3(1266.89, -1231.06, 79.02), radius = 0.5, prompt = 'grave_10' },
    { id = 11, coords = vec3(1270.87, -1230.45, 79.29), radius = 0.5, prompt = 'grave_11' },
    { id = 12, coords = vec3(1273.52, -1228.52, 79.62), radius = 0.5, prompt = 'grave_12' },
    { id = 13, coords = vec3(1276.77, -1229.11, 79.91), radius = 0.5, prompt = 'grave_13' },
    { id = 14, coords = vec3(1268.71, -1228.42, 79.32), radius = 0.5, prompt = 'grave_14' },
    { id = 15, coords = vec3(1270.71, -1224.13, 79.78), radius = 0.5, prompt = 'grave_15' },
    { id = 16, coords = vec3(1272.32, -1223.14, 79.98), radius = 0.5, prompt = 'grave_16' },
    { id = 17, coords = vec3(1274.38, -1222.94, 80.20), radius = 0.5, prompt = 'grave_17' },
    { id = 18, coords = vec3(1274.56, -1218.02, 80.67), radius = 0.5, prompt = 'grave_18' },
    { id = 19, coords = vec3(1279.62, -1214.03, 80.91), radius = 0.5, prompt = 'grave_19' },
    { id = 20, coords = vec3(1276.15, -1208.85, 81.59), radius = 0.5, prompt = 'grave_20' },
    { id = 21, coords = vec3(1290.65, -1209.46, 81.36), radius = 0.5, prompt = 'grave_21' },
    { id = 22, coords = vec3(1302.45, -1213.48, 80.08), radius = 0.5, prompt = 'grave_22' },
    { id = 23, coords = vec3(1296.35, -1209.90, 80.81), radius = 0.5, prompt = 'grave_23' },
    { id = 24, coords = vec3(1294.70, -1210.15, 80.96), radius = 0.5, prompt = 'grave_24' },
    { id = 25, coords = vec3(1292.65, -1214.06, 80.90), radius = 0.5, prompt = 'grave_25' },
    { id = 26, coords = vec3(1291.56, -1208.94, 81.35), radius = 0.5, prompt = 'grave_26' },
    { id = 27, coords = vec3(1295.64, -1215.23, 80.58), radius = 0.5, prompt = 'grave_27' },
    { id = 28, coords = vec3(1298.38, -1214.42, 80.36), radius = 0.5, prompt = 'grave_28' },
    { id = 29, coords = vec3(1297.00, -1212.40, 80.58), radius = 0.5, prompt = 'grave_29' },
    { id = 30, coords = vec3(1294.59, -1213.18, 80.76), radius = 0.5, prompt = 'grave_30' },
    { id = 31, coords = vec3(1295.71, -1212.86, 80.67), radius = 0.5, prompt = 'grave_31' },
    { id = 32, coords = vec3(1293.77, -1210.80, 80.98), radius = 0.5, prompt = 'grave_32' },
    { id = 33, coords = vec3(1292.35, -1211.25, 81.08), radius = 0.5, prompt = 'grave_33' },

    --=@ Valentine @=--
}

Config.models = {
    requiredItem = 'grave_shovel',
    durabilityLoss = 5, -- Quality lost per grave dig (25% = 4 uses before broken)
    maxDurability = 100, -- Maximum quality for new shovels (RSG default)
    gravePeds = {
        'a_f_m_armcholeracorpse_01',
        'a_f_m_unicorpse_01',
        'a_m_m_armcholeracorpse_01',
        -- Add more peds here to spawn
    },
    gravePedSpawnChance = 25, -- 10% chance to spawn a grave ped by default
    rewards = {
        {item = 'cent', label = 'Cents', min = 1, max = 99, chance = 100},
        {item = 'dollar', label = 'Dollars', min = 1, max = 5, chance = 100},
        {item = 'blood_money_clip', label = 'Bloodstained Money Clip', min = 1, max = 2, chance = 20},
        {item = 'house_key', label = 'house_key', min = 1, max = 1, chance = 10},
        {item = 'amethyst_necklace', label = 'Amethyst Necklace', min = 1, max = 1, chance = 5},
        {item = 'platinum_bracelet', label = 'Platinum Bracelet', min = 1, max = 1, chance = 5},
        {item = 'jewelry_box', label = 'Jewelry Box', min = 1, max = 1, chance = 5},
        {item = 'ruby_earrings', label = 'Ruby Earrings', min = 1, max = 1, chance = 5},
        {item = 'diamond_ring', label = 'Diamond Ring', min = 1, max = 1, chance = 5},
    },
}

return Config
