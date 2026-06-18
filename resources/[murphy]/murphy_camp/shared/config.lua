Interaction                = {}
Config                     = {}
Config.framework           = "rsg-core"
--- Please select your framework ---
-- qbr-core
-- REDEMRP2k23
-- redemrp2022
-- rsg-core
-- vorp

Config.InviteCommand       = "inviteguest" --- set to false to disable
Config.RemoveInviteCommand  = "removeguest" --- set to false to disable
Config.InviteInteract      = true --- set to false to disable the murphy_interact invite prompt near campfire (you can still use the command)

Config.CampDecay           = true   --- true if you want decay over time for camp, player will have to add fuel in it
-- if there is no fuel anymore, all the camp will be deleted !!
Config.FuelItem            = "wood" -- every hour an item will be consumed
Config.OneFuelperDay     = true   -- if true, only one fuel item will be consumed per day, if false, every hour one item will be consumed
Config.MaxFuel             = 14    -- max fuel item in campfire, 168 means 168h = 1 week or 168 days depending on Config.OneFuelperDay 
Config.BasicFuel           = 2      -- default fuel in a new campfire
Config.murphy_stable       = true   --- true if you want to check if stable is empty before creating a camp
Config.CampLimit           = 2      --- number of campfire per player
Config.Campfiresmoke       = true   --- true if you want smoke effect on campfire
Config.DisplayDistance     = 150.0  --- display distance of camps
Config.InterdictionRadius  = 50.0   --- Minimum distance between two camps
Config.LockpickItem        = "lockpick"
Config.BreakDelay          = 600    --- in seconds (delay during the safe remain open for everyone after being opened)
Config.LockpickDistance    = 50.0   --- minimum distance required between the campfire and the owner or a guest to initiate a lockpick

--- "Remove all furniture" campfire option. Useful when a piece of furniture gets
--- stuck inside a wall/tree and the player can no longer interact with it.
--- mode:
---   "admin" : only players whose framework group is in AdminGroups can use it (no item refund)
---   "owner" : only the camp owner can use it (items are refunded)
Config.RemoveAllFurnitureMode   = "owner"
Config.RemoveAllFurnitureAdminGroups = { "admin", "superadmin" }

--- "Lost Objects" feature. When a camp runs out of fuel and despawns, all of its
--- furniture items AND the items stored inside its storage props (tents, chests,
--- wagons...) are sent to the owner's personal "lost objects" pile. The owner
--- can recover them from one of the recovery points configured below.
---
--- Each entry in `locations` defines a place where players can recover their
--- lost objects. If `ped` is provided, an NPC will be spawned with that model
--- and animation. If `ped` is omitted, only a murphy_interact prompt is created
--- at the given coords (useful to attach the option to an existing prop / sign).
Config.LostObjects = {
    enabled               = true,        -- master toggle for the feature
    transferStorageItems  = true,        -- also rescue items contained in storage props (tents, chests...)
    blip = {
        enabled = true,
        sprite  = 1861010125,            -- generic mail/document blip
        scale   = 0.25,
        label   = "Lost Objects",
    },
    locations = {
        {
            coords = vector3(-321.5, 776.3, 117.5),  -- adjust to your liking
            heading = 90.0,
            ped = {
                model    = "S_M_M_TrainStationWorker_01",
                outfit   = 0,                    -- VORP outfit preset, 0 = default
                scenario = "WORLD_HUMAN_WRITE_NOTEBOOK",
            },
        },
        -- Example: a second spot with just an interaction (no NPC spawned).
        -- {
        --     coords = vector3(2710.0, -1180.0, 50.0),
        --     -- no `ped` block → only a murphy_interact prompt appears at these coords
        -- },
    },
}

Config.BannedCity          = {
    Annesburg = true,
    Armadillo = true,
    Blackwater = true,
    BeechersHope = false,
    Braithwaite = false,
    Butcher = false,
    Caliga = false,
    Cornwall = false,
    Emerald = true,
    lagras = true,
    Manzanita = false,
    Rhodes = true,
    Siska = false,
    SaintDenis = true,
    Strawberry = true,
    Tumbleweed = true,
    Valentine = true,
    Vanhorn = true,
    Wallace = false,
    Wapiti = false,
    AguasdulcesFarm = false,
    AguasdulcesRuins = false,
    AguasdulcesVilla = false,
    Manicato = false
}

Config.CookInteractionFire = false

Config.Campfire            = {
    -- name = { ----- EXAMPLE CAMPFIRE -----
    --     item = "spit", -- item
    --     props = "p_campfire03x", --- props or propset (remember to change the name)
    --     radius = 7.0 --- radius around the campfire where props can be placed
    -- },
    base = { item = "spit", props = "p_campfire03x", radius = 7.0, stashlimit = 3 },
    firescrub = {
        item = "firescrub",
        propset = { "pg_ambient_camp_add_central_firescrub01", "pg_ambient_camp_add_central_seat04" },
        interactionentity = "p_campfirefresh01x",
        radius = 10.0,
        stashlimit = 4
    },
    advanced = { item = "campfire2", propset = { "pg_mp_possecamp_campfire_medium001x" }, radius = 15.0, stashlimit = 5 },
    crackheadS = { item = "campfire3", propset = { "pg_mp_campfire03x" }, radius = 20.0, stashlimit = 6}
    --crackheadL = { item = "spit", propset = {"pg_mp_possecamp_campfire_large002x"}, radius = 30.0, interactionentity = "p_campfirecombined02x" },
}

Config.Furnitures          = {
    -- name = { ------- EXAMPLE FOR PROPS -------
    --     item = "bancbuche", -- item
    --     props = "p_bench_log01x", -- prop
    --     interaction = nil, --- interaction (craft or other 'scripted' action), multiple possible
    --     inventory = nil, --- storage of the prop
    --     scenarios = nil, ---- animation (to test with ricx_scenarios)
    -- },
    -- name = { ------- EXAMPLE FOR PROPSET -------
    --     item = "moonshiner", -- item
    --     propset ={ "pg_mp_moonshinecamp03x"}, -- propset
    --     interactionentity = "p_still02x", -- prop on which the menu will be displayed
    --     interaction = {{text = "Distill", type = "moonshiner" }, {text = "Bottle", type = "moonshiner" }}, --- interaction (craft or other 'scripted' action), multiple possible
    --     inventory = 100, -- storage of the propset
    --     scenarios = {[1] = {text = "Sleep", hash = "PROP_PLAYER_SLEEP_TENT_A_FRAME" }}, ---- animation (to test with ricx_scenarios)
    -- },
    --------------------------------------
    --------------- TENTE ---------------
    --------------------------------------
    ----- trader ----
    tent_trader01 = {
        item = "tent_trader01",
        propset = {
            "pg_mp_possecamp_tent_trader01x",
            "pg_mp_possecamp_tent_trader01x_b",
            "pg_mp_possecamp_tent_trader01x_c"
        },
        interactionentity = "s_bedrollfurlined01x",
        interaction = nil,
        inventory = 80,
        scenarios = { { text = "Sit", hash = "PROP_HUMAN_SEAT_CHAIR" } }
    },
    tent_trader02 = {
        item = "tent_trader02",
        propset = {
            "pg_mp_possecamp_tent_trader02x",
            "pg_mp_possecamp_tent_trader02x_b",
            "pg_mp_possecamp_tent_trader02x_c"
        },
        interactionentity = "s_bedrollfurlined01x",
        interaction = nil,
        inventory = 80,
        scenarios = { { text = "Sit", hash = "PROP_HUMAN_SEAT_CHAIR" } }
    },
    tent_trader03 = {
        item = "tent_trader03",
        propset = {
            "pg_mp_possecamp_tent_trader03x",
            "pg_mp_possecamp_tent_trader03x_b",
            "pg_mp_possecamp_tent_trader03x_c"
        },
        interactionentity = "mp005_s_posse_tent_trader03x",
        interaction = nil,
        inventory = 80,
        scenarios = { { text = "Sit", hash = "PROP_HUMAN_SEAT_CHAIR" } }
    },
    tent_trader04 = {
        item = "tent_trader04",
        propset = {
            "pg_mp_possecamp_tent_trader04x",
            "pg_mp_possecamp_tent_trader04x_b",
            "pg_mp_possecamp_tent_trader04x_c"
        },
        interactionentity = "s_bedrollfurlined01x",
        interaction = nil,
        inventory = 80,
        scenarios = { { text = "Sit", hash = "PROP_HUMAN_SEAT_CHAIR" } }
    },
    tent_trader05 = {
        item = "tent_trader05",
        propset = {
            "pg_mp_possecamp_tent_trader05x",
            "pg_mp_possecamp_tent_trader05x_b",
            "pg_mp_possecamp_tent_trader05x_c"
        },
        interactionentity = "s_bedrollfurlined01x",
        interaction = nil,
        inventory = 80,
        scenarios = { { text = "Sit", hash = "PROP_HUMAN_SEAT_CHAIR" } }
    },
    tent_trader06 = {
        item = "tent_trader06",
        propset = {
            "pg_mp_possecamp_tent_trader06x",
            "pg_mp_possecamp_tent_trader06x_b",
            "pg_mp_possecamp_tent_trader06x_c"
        },
        interactionentity = "s_bedrollfurlined01x",
        interaction = nil,
        inventory = 80,
        scenarios = { { text = "Sit", hash = "PROP_HUMAN_SEAT_CHAIR" } }
    },
    tent_trader07 = {
        item = "tent_trader07",
        propset = {
            "pg_mp_possecamp_tent_trader07x",
            "pg_mp_possecamp_tent_trader07x_b",
            "pg_mp_possecamp_tent_trader07x_c"
        },
        interactionentity = "mp005_s_posse_goodsbundle01x",
        interaction = nil,
        inventory = 80,
        scenarios = { { text = "Sit", hash = "PROP_HUMAN_SEAT_CHAIR" } }
    },
    ----- bounty ----
    tent_bounty01 = {
        item = "tent_bounty01",
        propset = { "pg_mp_possecamp_tent_bounty01x", "pg_mp_possecamp_tent_trader01x_b" },
        interactionentity = "p_mattress04x",
        interaction = nil,
        inventory = 20,
        scenarios = { { text = "Sit", hash = "PROP_HUMAN_SEAT_CHAIR" } }
    },
    tent_bounty02 = {
        item = "tent_bounty02",
        propset = { "pg_mp_possecamp_tent_bounty02x", "pg_mp_possecamp_tent_trader02x_b" },
        interactionentity = "p_mattress04x",
        interaction = nil,
        inventory = 30,
        scenarios = { { text = "Sit", hash = "PROP_HUMAN_SEAT_CHAIR" } }
    },
    tent_bounty03 = {
        item = "tent_bounty03",
        propset = {
            "pg_mp_possecamp_tent_bounty03x",
            "pg_mp_possecamp_tent_trader03x_b",
            "pg_mp_possecamp_tent_trader03x_c"
        },
        interactionentity = "p_mattress04x",
        interaction = nil,
        inventory = 40,
        scenarios = { { text = "Sit", hash = "PROP_HUMAN_SEAT_CHAIR" } }
    },
    tent_bounty04 = {
        item = "tent_bounty04",
        propset = { "pg_mp_possecamp_tent_bounty04x", "pg_mp_possecamp_tent_trader04x_b" },
        interactionentity = "p_mattress04x",
        interaction = nil,
        inventory = 40,
        scenarios = { { text = "Sit", hash = "PROP_HUMAN_SEAT_CHAIR" } }
    },
    tent_bounty05 = {
        item = "tent_bounty05",
        propset = { "pg_mp_possecamp_tent_bounty05x", "pg_mp_possecamp_tent_trader05x_b" },
        interactionentity = "p_mattress04x",
        interaction = nil,
        inventory = 50,
        scenarios = { { text = "Sit", hash = "PROP_HUMAN_SEAT_CHAIR" } }
    },
    tent_bounty06 = {
        item = "tent_bounty06",
        propset = { "pg_mp_possecamp_tent_bounty06x", "pg_mp_possecamp_tent_trader06x_b" },
        interactionentity = "p_mattress04x",
        interaction = nil,
        inventory = 60,
        scenarios = { { text = "Sit", hash = "PROP_HUMAN_SEAT_CHAIR" } }
    },
    tent_bounty07 = {
        item = "tent_bounty07",
        propset = {
            "pg_mp_possecamp_tent_bounty07x",
            "pg_mp_possecamp_tent_trader07x_b",
            "pg_mp_possecamp_tent_trader03x_c"
        },
        interactionentity = "p_mattress04x",
        interaction = nil,
        inventory = 80,
        scenarios = { { text = "Sit", hash = "PROP_HUMAN_SEAT_CHAIR" } }
    },
    ----- collector ----
    tent_collector01 = {
        item = "tent_collector01",
        propset = { "pg_mp_possecamp_tent_collector01x", "pg_mp_possecamp_tent_trader01x_b" },
        interactionentity = "p_mattress04x",
        interaction = nil,
        inventory = 20,
        scenarios = { { text = "Sit", hash = "PROP_HUMAN_SEAT_CHAIR" } }
    },
    tent_collector02 = {
        item = "tent_collector02",
        propset = { "pg_mp_possecamp_tent_collector02x", "pg_mp_possecamp_tent_trader02x_b" },
        interactionentity = "p_mattress04x",
        interaction = nil,
        inventory = 30,
        scenarios = { { text = "Sit", hash = "PROP_HUMAN_SEAT_CHAIR" } }
    },
    tent_collector03 = {
        item = "tent_collector03",
        propset = {
            "pg_mp_possecamp_tent_collector03x",
            "pg_mp_possecamp_tent_trader03x_b",
            "pg_mp_possecamp_tent_trader03x_c"
        },
        interactionentity = "p_mattress04x",
        interaction = nil,
        inventory = 40,
        scenarios = { { text = "Sit", hash = "PROP_HUMAN_SEAT_CHAIR" } }
    },
    tent_collector04 = {
        item = "tent_collector04",
        propset = { "pg_mp_possecamp_tent_collector04x", "pg_mp_possecamp_tent_trader04x_b" },
        interactionentity = "p_mattress04x",
        interaction = nil,
        inventory = 40,
        scenarios = { { text = "Sit", hash = "PROP_HUMAN_SEAT_CHAIR" } }
    },
    tent_collector05 = {
        item = "tent_collector05",
        propset = { "pg_mp_possecamp_tent_collector05x", "pg_mp_possecamp_tent_trader05x_b" },
        interactionentity = "p_mattress04x",
        interaction = nil,
        inventory = 50,
        scenarios = { { text = "Sit", hash = "PROP_HUMAN_SEAT_CHAIR" } }
    },
    tent_collector06 = {
        item = "tent_collector06",
        propset = { "pg_mp_possecamp_tent_collector06x", "pg_mp_possecamp_tent_trader06x_b" },
        interactionentity = "p_mattress04x",
        interaction = nil,
        inventory = 60,
        scenarios = { { text = "Sit", hash = "PROP_HUMAN_SEAT_CHAIR" } }
    },
    tent_collector07 = {
        item = "tent_collector07",
        propset = { "pg_mp_possecamp_tent_collector07x", "pg_mp_possecamp_tent_trader07x_b" },
        interactionentity = "p_mattress04x",
        interaction = nil,
        inventory = 80,
        scenarios = { { text = "Sit", hash = "PROP_HUMAN_SEAT_CHAIR" } }
    },
    ----- survivor ----
    tent_survivor01 = {
        item = "tent_survivor01",
        propset = {
            "pg_mp_possecamp_tent_aframetent_survivor01",
            "pg_mp_possecamp_tent_aframetent_survivor01_b",
            "pg_mp_possecamp_tent_aframetent_survivor01_c"
        },
        interactionentity = "p_bedrollopen03x",
        interaction = nil,
        inventory = 20,
        scenarios = {
            { text = "Sleep", hash = "PROP_PLAYER_SLEEP_TENT_A_FRAME" },
            { text = "Sit",   hash = "PROP_HUMAN_SEAT_NO_BACK_COLLECTION" }
        }
    },
    tent_survivor02 = {
        item = "tent_survivor02",
        propset = {
            "pg_mp_possecamp_tent_coveredleanto_survivor01",
            "pg_mp_possecamp_tent_coveredleanto_survivor01_b",
            "pg_mp_possecamp_tent_coveredleanto_survivor01_c"
        },
        interactionentity = "p_bedrollopen03x",
        interaction = nil,
        inventory = 30,
        scenarios = nil
    },
    tent_survivor03 = {
        item = "tent_survivor03",
        propset = {
            "pg_mp_possecamp_tent_coveredtent_survivor01",
            "pg_mp_possecamp_tent_coveredtent_survivor01_b",
            "pg_mp_possecamp_tent_coveredtent_survivor01_c"
        },
        interactionentity = "p_tentmexican01x",
        interaction = nil,
        inventory = 40,
        scenarios = nil
    },
    tent_survivor04 = {
        item = "tent_survivor04",
        propset = {
            "pg_mp_possecamp_tent_openleanto_culture01",
            "pg_mp_possecamp_tent_openleanto_survivor01_b",
            "pg_mp_possecamp_tent_openleanto_survivor01_c"
        },
        interactionentity = "p_bedrollopen03x",
        interaction = nil,
        inventory = 40,
        scenarios = nil
    },
    tent_survivor05 = {
        item = "tent_survivor05",
        propset = {
            "pg_mp_possecamp_tent_simplebedroll_survivor01",
            "pg_mp_possecamp_tent_simplebedroll_survivor01_b",
            "pg_mp_possecamp_tent_simplebedroll_survivor01_c"
        },
        interactionentity = "p_bedrollopen03x",
        interaction = nil,
        inventory = 50,
        scenarios = nil
    },
    tent_survivor06 = {
        item = "tent_survivor06",
        propset = {
            "pg_mp_possecamp_tent_simpleleanto_survivor01",
            "pg_mp_possecamp_tent_simpleleanto_survivor01_b",
            "pg_mp_possecamp_tent_simpleleanto_survivor01_c"
        },
        interactionentity = "p_bedrollopen03x",
        interaction = nil,
        inventory = 60,
        scenarios = nil
    },
    tent_survivor07 = {
        item = "tent_survivor07",
        propset = {
            "pg_mp_possecamp_tent_tallleanto_survivor01",
            "pg_mp_possecamp_tent_tallleanto_survivor01_b",
            "pg_mp_possecamp_tent_tallleanto_survivor01_c"
        },
        interactionentity = "p_bedrollopen03x",
        interaction = nil,
        inventory = 80,
        scenarios = nil
    },
    ----- savage ----
    tent_savage01 = {
        item = "tent_savage01",
        propset = {
            "pg_mp_possecamp_tent_aframetent_survivor01",
            "pg_mp_possecamp_tent_aframetent_savage01_b",
            "pg_mp_possecamp_tent_aframetent_survivor01_c"
        },
        interactionentity = "p_bedrollopen03x",
        interaction = nil,
        inventory = 20,
        scenarios = {
            { text = "Sleep", hash = "PROP_PLAYER_SLEEP_TENT_A_FRAME" },
            { text = "Sit",   hash = "PROP_HUMAN_SEAT_NO_BACK_COLLECTION" }
        }
    },
    tent_savage02 = {
        item = "tent_savage02",
        propset = {
            "pg_mp_possecamp_tent_coveredleanto_survivor01",
            "pg_mp_possecamp_tent_coveredleanto_savage01_b",
            "pg_mp_possecamp_tent_coveredleanto_savage01_c"
        },
        interactionentity = "p_bedrollopen03x",
        interaction = nil,
        inventory = 30,
        scenarios = nil
    },
    tent_savage03 = {
        item = "tent_savage03",
        propset = { "pg_mp_possecamp_tent_coveredtent_survivor01", "pg_mp_possecamp_tent_coveredtent_savage01_b" },
        interactionentity = "p_tentmexican01x",
        interaction = nil,
        inventory = 40,
        scenarios = nil
    },
    tent_savage04 = {
        item = "tent_savage04",
        propset = {
            "pg_mp_possecamp_tent_openleanto_culture01",
            "pg_mp_possecamp_tent_openleanto_survivor01_b",
            "pg_mp_possecamp_tent_openleanto_savage01_c"
        },
        interactionentity = "p_awningbills01b",
        interaction = nil,
        inventory = 40,
        scenarios = nil
    },
    tent_savage05 = {
        item = "tent_savage05",
        propset = { "pg_mp_possecamp_tent_simpleleanto_survivor01", "pg_mp_possecamp_tent_simpleleanto_savage01_c" },
        interactionentity = "p_bedrollopen03x",
        interaction = nil,
        inventory = 50,
        scenarios = nil
    },
    tent_savage06 = {
        item = "tent_savage06",
        propset = {
            "pg_mp_possecamp_tent_tallleanto_survivor01",
            "pg_mp_possecamp_tent_tallleanto_savage01_b",
            "pg_mp_possecamp_tent_tallleanto_savage01_c"
        },
        interactionentity = "p_bedrollopen03x",
        interaction = nil,
        inventory = 60,
        scenarios = nil
    },
    ----- military ----
    tent_military01 = {
        item = "tent_military01",
        propset = {
            "pg_mp_possecamp_tent_aframetent_military01",
            "pg_mp_possecamp_tent_aframetent_military01_b",
            "pg_mp_possecamp_tent_aframetent_military01_c"
        },
        interactionentity = "p_bedrollopen01x",
        interaction = nil,
        inventory = 20,
        scenarios = nil
    },
    tent_military02 = {
        item = "tent_military02",
        propset = {
            "pg_mp_possecamp_tent_coveredleanto_military01",
            "pg_mp_possecamp_tent_coveredleanto_military01_b",
            "pg_mp_possecamp_tent_coveredleanto_military01_c"
        },
        interactionentity = "s_awningmil",
        interaction = nil,
        inventory = 30,
        scenarios = {
            { text = "Sleep", hash = "PROP_HUMAN_SLEEP_BED_PILLOW" },
            { text = "Sit",   hash = "PROP_HUMAN_SEAT_NO_BACK_COLLECTION" }
        }
    },
    tent_military03 = {
        item = "tent_military03",
        propset = {
            "pg_mp_possecamp_tent_coveredtent_military01",
            "pg_mp_possecamp_tent_coveredtent_military01_b",
            "pg_mp_possecamp_tent_coveredtent_military01_c"
        },
        interactionentity = "p_bedrollopen01x",
        interaction = nil,
        inventory = 40,
        scenarios = { { text = "Sleep", hash = "PROP_HUMAN_SLEEP_BED_PILLOW" } }
    },
    tent_military04 = {
        item = "tent_military04",
        propset = { "pg_mp_possecamp_tent_openleanto_culture01", "pg_mp_possecamp_tent_openleanto_military01_b" },
        interactionentity = "p_bedrollopen01x",
        interaction = nil,
        inventory = 40,
        scenarios = { { text = "Sit", hash = "PROP_HUMAN_SEAT_NO_BACK_COLLECTION" } }
    },
    tent_military05 = {
        item = "tent_military05",
        propset = {
            "pg_mp_possecamp_tent_simplebedroll_military01",
            "pg_mp_possecamp_tent_simplebedroll_military01_b",
            "pg_mp_possecamp_tent_simplebedroll_military01_c"
        },
        interactionentity = "p_cot01x",
        interaction = nil,
        inventory = 50,
        scenarios = {
            { text = "Sleep", hash = "PROP_HUMAN_SLEEP_BED_PILLOW" },
            { text = "Sit",   hash = "PROP_HUMAN_SEAT_NO_BACK_COLLECTION" }
        }
    },
    tent_military06 = {
        item = "tent_military06",
        propset = {
            "pg_mp_possecamp_tent_simpleleanto_military01",
            "pg_mp_possecamp_tent_simpleleanto_military01_b",
            "pg_mp_possecamp_tent_simpleleanto_military01_c"
        },
        interactionentity = "p_bedrollopen03x",
        interaction = nil,
        inventory = 60,
        scenarios = nil
    },
    tent_military07 = {
        item = "tent_military07",
        propset = {
            "pg_mp_possecamp_tent_tallleanto_military01",
            "pg_mp_possecamp_tent_tallleanto_military01_b",
            "pg_mp_possecamp_tent_tallleanto_military01_c"
        },
        interactionentity = "p_cot01x",
        interaction = nil,
        inventory = 80,
        scenarios = {
            { text = "Sleep", hash = "PROP_HUMAN_SLEEP_BED_PILLOW" },
            { text = "Sit",   hash = "PROP_HUMAN_SEAT_NO_BACK_COLLECTION" }
        }
    },
    ----- hobo ----
    tent_hobo01 = {
        item = "tent_hobo01",
        propset = {
            "pg_mp_possecamp_tent_aframetent_hobo01",
            "pg_mp_possecamp_tent_aframetent_hobo01_b",
            "pg_mp_possecamp_tent_aframetent_hobo01_c"
        },
        interactionentity = "p_bedrollopen03x",
        interaction = nil,
        inventory = 20,
        scenarios = {
            { text = "Sleep", hash = "PROP_PLAYER_SLEEP_TENT_A_FRAME" },
            { text = "Sit",   hash = "PROP_HUMAN_SEAT_NO_BACK_COLLECTION" }
        }
    },
    tent_hobo02 = {
        item = "tent_hobo02",
        propset = {
            "pg_mp_possecamp_tent_coveredleanto_hobo01",
            "pg_mp_possecamp_tent_coveredleanto_hobo01_b",
            "pg_mp_possecamp_tent_coveredleanto_hobo01_c"
        },
        interactionentity = "s_awninghob",
        interaction = nil,
        inventory = 30,
        scenarios = nil
    },
    tent_hobo03 = {
        item = "tent_hobo03",
        propset = {
            "pg_mp_possecamp_tent_coveredtent_hobo01",
            "pg_mp_possecamp_tent_coveredtent_hobo01_b",
            "pg_mp_possecamp_tent_coveredtent_hobo01_c"
        },
        interactionentity = "p_bedrollopen03x",
        interaction = nil,
        inventory = 40,
        scenarios = { { text = "Sit", hash = "PROP_HUMAN_SEAT_NO_BACK_COLLECTION" } }
    },
    tent_hobo04 = {
        item = "tent_hobo04",
        propset = {
            "pg_mp_possecamp_tent_openleanto_culture01",
            "pg_mp_possecamp_tent_openleanto_hobo01_b",
            "pg_mp_possecamp_tent_openleanto_hobo01_c"
        },
        interactionentity = "p_bedrollopen03x",
        interaction = nil,
        inventory = 40,
        scenarios = { { text = "Sit", hash = "PROP_HUMAN_SEAT_CHAIR" } }
    },
    tent_hobo05 = {
        item = "tent_hobo05",
        propset = {
            "pg_mp_possecamp_tent_simplebedroll_hobo01",
            "pg_mp_possecamp_tent_simplebedroll_hobo01_b",
            "pg_mp_possecamp_tent_simplebedroll_hobo01_c"
        },
        interactionentity = "p_bedrollopen03x",
        interaction = nil,
        inventory = 50,
        scenarios = { { text = "Sit", hash = "PROP_HUMAN_SEAT_NO_BACK_COLLECTION" } }
    },
    tent_hobo06 = {
        item = "tent_hobo06",
        propset = {
            "pg_mp_possecamp_tent_simpleleanto_hobo01",
            "pg_mp_possecamp_tent_simpleleanto_hobo01_b",
            "pg_mp_possecamp_tent_simpleleanto_hobo01_c"
        },
        interactionentity = "p_gangbed01x",
        interaction = nil,
        inventory = 60,
        scenarios = { { text = "Sit", hash = "PROP_HUMAN_SEAT_CHAIR" } }
    },
    tent_hobo07 = {
        item = "tent_hobo07",
        propset = {
            "pg_mp_possecamp_tent_tallleanto_hobo01",
            "pg_mp_possecamp_tent_tallleanto_hobo01_b",
            "pg_mp_possecamp_tent_tallleanto_hobo01_c"
        },
        interactionentity = "s_bedrollopen01x",
        interaction = nil,
        inventory = 80,
        scenarios = { { text = "Sit", hash = "PROP_HUMAN_SEAT_CHAIR" } }
    },
    ----- culture ----
    tent_culture01 = {
        item = "tent_culture01",
        propset = {
            "pg_mp_possecamp_tent_aframetent_culture01",
            "pg_mp_possecamp_tent_aframetent_culture01_b",
            "pg_mp_possecamp_tent_aframetent_culture01_c"
        },
        interactionentity = "p_ambtentplaid01x",
        interaction = nil,
        inventory = 20,
        scenarios = {
            { text = "Sleep", hash = "PROP_PLAYER_SLEEP_TENT_A_FRAME" },
            { text = "Sit",   hash = "PROP_HUMAN_SEAT_BENCH" }
        }
    },
    tent_culture02 = {
        item = "tent_culture02",
        propset = {
            "pg_mp_possecamp_tent_coveredleanto_culture01",
            "pg_mp_possecamp_tent_coveredleanto_culture01_b",
            "pg_mp_possecamp_tent_coveredleanto_culture01_c"
        },
        interactionentity = "s_awningcul",
        interaction = nil,
        inventory = 30,
        scenarios = { { text = "Draw", hash = "PROP_HUMAN_SEAT_CHAIR_SKETCHI" } }
    },
    tent_culture03 = {
        item = "tent_culture03",
        propset = {
            "pg_mp_possecamp_tent_coveredtent_culture01",
            "pg_mp_possecamp_tent_coveredtent_culture01_b",
            "pg_mp_possecamp_tent_coveredtent_culture01_c"
        },
        interactionentity = "s_tentdoctor01x",
        interaction = nil,
        inventory = 40,
        scenarios = nil
    },
    tent_culture04 = {
        item = "tent_culture04",
        propset = {
            "pg_mp_possecamp_tent_openleanto_culture01",
            "pg_mp_possecamp_tent_openleanto_culture01_b",
            "pg_mp_possecamp_tent_openleanto_culture01_c"
        },
        interactionentity = "p_awningbills01b",
        interaction = nil,
        inventory = 40,
        scenarios = { { text = "Draw", hash = "PROP_HUMAN_SEAT_CHAIR_SKETCHI" } }
    },
    tent_culture05 = {
        item = "tent_culture05",
        propset = {
            "pg_mp_possecamp_tent_simplebedroll_culture01",
            "pg_mp_possecamp_tent_simplebedroll_culture01_b",
            "pg_mp_possecamp_tent_simplebedroll_culture01_c"
        },
        interactionentity = "p_mattress04x",
        interaction = nil,
        inventory = 50,
        scenarios = nil
    },
    tent_culture06 = {
        item = "tent_culture06",
        propset = {
            "pg_mp_possecamp_tent_simpleleanto_culture01",
            "pg_mp_possecamp_tent_simpleleanto_culture01_b",
            "pg_mp_possecamp_tent_simpleleanto_culture01_c"
        },
        interactionentity = "p_bedrollopen03x",
        interaction = nil,
        inventory = 60,
        scenarios = nil
    },
    tent_culture07 = {
        item = "tent_culture07",
        propset = {
            "pg_mp_possecamp_tent_tallleanto_culture01",
            "pg_mp_possecamp_tent_tallleanto_culture01_b",
            "pg_mp_possecamp_tent_tallleanto_culture01_c"
        },
        interactionentity = "s_tentwedge02x",
        interaction = nil,
        inventory = 80,
        scenarios = { { text = "Draw", hash = "PROP_HUMAN_SEAT_CHAIR_SKETCHI" } }
    },
    ----- playertent -----
    playertent01 = {
        item = "playertent01",
        propset = {
            "pg_mp_posseCamp_playerTent_medium000x",
            "pg_mp_possecamp_playertent_medium000x_b",
            "pg_mp_possecamp_playertent_medium000x_b"
        },
        interactionentity = "p_bedrollopen03x",
        interaction = nil,
        inventory = 20,
        scenarios = nil
    },
    playertent02 = {
        item = "playertent02",
        propset = {
            "pg_mp_posseCamp_playerTent_large000x",
            "pg_mp_posseCamp_playerTent_large000x_b",
            "pg_mp_posseCamp_playerTent_large000x_c"
        },
        interactionentity = "p_bedrollopen01x",
        interaction = nil,
        inventory = 30,
        scenarios = nil
    },
    playertent03 = {
        item = "playertent03",
        propset = {
            "pg_mp_posseCamp_playerTent_large001x",
            "pg_mp_posseCamp_playerTent_large001x_b",
            "pg_mp_posseCamp_playerTent_large001x_c"
        },
        interactionentity = "p_bedrollopen03x",
        interaction = nil,
        inventory = 40,
        scenarios = nil
    },
    playertent04 = {
        item = "playertent04",
        propset = {
            "pg_mp_posseCamp_playerTent_large002x",
            "pg_mp_posseCamp_playerTent_large002x_b",
            "pg_mp_posseCamp_playerTent_large002x_c"
        },
        interactionentity = "p_tent_leento04x",
        interaction = nil,
        inventory = 40,
        scenarios = nil
    },
    playertent05 = {
        item = "playertent05",
        propset = {
            "pg_mp_posseCamp_playerTent_large003x",
            "pg_mp_posseCamp_playerTent_large003x_b",
            "pg_mp_posseCamp_playerTent_large003x_c"
        },
        interactionentity = "p_tent_leento02x",
        interaction = nil,
        inventory = 50,
        scenarios = nil
    },
    playertent06 = {
        item = "playertent06",
        propset = {
            "pg_mp_posseCamp_playerTent_large004x",
            "pg_mp_posseCamp_playerTent_large004x_b",
            "pg_mp_posseCamp_playerTent_large004x_c"
        },
        interactionentity = "p_tentarmypup01x",
        interaction = nil,
        inventory = 60,
        scenarios = nil
    },
    playertent07 = {
        item = "playertent07",
        propset = {
            "pg_mp_posseCamp_playerTent_large005x",
            "pg_mp_posseCamp_playerTent_large005x_b",
            "pg_mp_posseCamp_playerTent_large005x_c"
        },
        interactionentity = "p_tentmountainmen01x",
        interaction = nil,
        inventory = 80,
        scenarios = nil
    },
    --------------------------------------
    --------------- DECORATION ---------------
    --------------------------------------

    ----- table ----
    tablesimple = {
        item = "tablesimple",
        propset = { "pg_mp_posseCamp_decor_medium011x" },
        interactionentity = "p_table11x"
    },
    tableculture = {
        item = "tableculture",
        propset = { "pg_mp_possecamp_culture_medium011x" },
        interactionentity = "p_tablecul01x"
    },
    tablecolector = {
        item = "tablecolector",
        propset = { "pg_mp_possecamp_decor_col_table" },
        interactionentity = "p_table13x"
    },
    tablebounty = {
        item = "tablebounty",
        propset = { "pg_mp_possecamp_decor_bnty_table" },
        interactionentity = "mp005_s_posse_table_bountyhunter02x"
    },
    tabletrader = {
        item = "tabletrader",
        propset = { "pg_mp_possecamp_decor_trad_table" },
        interactionentity = "p_table13x"
    },
    tablehobo = { item = "tablehobo", propset = { "pg_mp_possecamp_hobo_medium011x" }, interactionentity = "p_table11x" },
    tablemilitary = {
        item = "tablemilitary",
        propset = { "pg_mp_possecamp_mil_medium011x" },
        interactionentity = "p_cratetablemil01x"
    },
    tablesavage = {
        item = "tablesavage",
        propset = { "pg_mp_possecamp_sav_medium011x" },
        interactionentity = "p_table31_largex"
    },
    tablesurvivor = {
        item = "tablesurvivor",
        propset = { "pg_mp_possecamp_surv_medium011x" },
        interactionentity = "p_table13x"
    },
    tablefood = { item = "tablefood", propset = { "pg_mp_possecamp_decor_medium010x" }, interactionentity = "p_table31x" },
    smalltable01 = {
        item = "smalltable01",
        propset = { "pg_ambient_camp_add_makeshifttable02" },
        interactionentity = "p_cratedamagedebris01x"
    },
    ---- other ----
    chairsavage = {
        item = "chairsavage",
        propset = { "pg_mp_possecamp_decor_medium009x" },
        interactionentity = "p_chairrusticsav01x"
    },
    sacrifice = {
        item = "sacrifice",
        propset = { "PG_MP_POSSECAMP_DECOR_SMALL001X_SECONDARY" },
        interactionentity = "p_tablesav01x"
    },
    explorertent = {
        item = "explorertent",
        propset = { "PG_MP_POSSECAMP_EXPLORERTENT01X" },
        interactionentity = "p_barrel09x"
    },
    toilet = { item = "toilet", propset = { "pg_mp_posseCamp_decor_small011x" }, interactionentity = "p_sawbucktable01x" },
    decorsurvival = {
        item = "decorsurvival",
        propset = { "pg_mp_possecamp_decor_large005x", "pg_mp_possecamp_decor_large005x_c" },
        interactionentity = "p_wall_wood_0001"
    },
    clothesline = {
        item = "clothesline",
        propset = { "pg_ambient_camp_add_clothesline01" },
        interactionentity = "p_tree_stump_06"
    },
    nativedecor = {
        item = "nativedecor",
        propset = { "pg_ambient_camp_add_native01" },
        interactionentity = "p_indianbackrest01x"
    },
    umbrella = {
        item = "umbrella",
        propset = { "pg_ambient_camp_add_umbrella01" },
        interactionentity = "p_chairfolding02x"
    },
    ---- lantern and torch ---
    torch01 = { item = "torch01", propset = { "pg_mp_posseCamp_decor_small000x" }, interactionentity = "p_barrel_cor01x" },
    lantern01 = {
        item = "lantern01",
        propset = { "pg_ambient_camp_add_gamepole01" },
        interactionentity = "p_trapperbackpack01x"
    },
    lantern02 = { item = "lantern02", propset = { "pg_ambient_camp_add_lamppost01" }, interactionentity = "p_crate03d" },
    ----- Useful -----
    medictable = {
        item = "medictable",
        propset = { "pg_mp_posseCamp_decor_medium008x" },
        interactionentity = "p_medbed01x",
        murphy_craft = {
            name = "Table de médecin",
            categories = { "docteur" },
            radius = 3.0,
            -- blip = {
            --     hash = "blip_mp_deliver_target", -- Blip hash
            --     modifier = "BLIP_MODIFIER_MP_COLOR_4", -- Blip modifier
            --     displaydistance = 20.0, -- Distance at which the blip is displayed, nil to display it always
            --     scale = 0.8
            -- }
        }
    },
    stewpot = {
        item = "stewpot",
        propset = { "pg_mp_possecamp_stewpot01x" },
        interactionentity = "p_campfirecombined01x",
        murphy_craft = {
            name = "Essentiel de cuisine",
            categories = { "food", "cuisinier" },
            radius = 3.0,
            -- blip = {
            --     hash = "blip_mp_deliver_target", -- Blip hash
            --     modifier = "BLIP_MODIFIER_MP_COLOR_4", -- Blip modifier
            --     displaydistance = 20.0, -- Distance at which the blip is displayed, nil to display it always
            --     scale = 0.8
            -- }
        }
    },

    pokertable = {
        item = "pokertable",
        propset = { "pg_mp_possecamp_pokertable01x" },
        interactionentity = "p_coverpronghorn01x"
    },
    merchantstand = {
        item = "merchantstand",
        propset = { "pg_mp_possecamp_merchanttent" },
        interactionentity = "p_tableset01x"
    },
    chest = {
        item = "chests",
        propset = { "pg_mp_posseCamp_lockbox_large000x" },
        interactionentity = "s_lootablebigbluechest02x",
        inventory = 25
    },
    fishingtent = { item = "fishingtent", propset = { "pg_mp_possecamp_fishingtent" }, interactionentity = "p_table34x" },
    butchertable = {
        item = "butchertable",
        propset = { "pg_mp_possecamp_butchertable02x" },
        interactionentity = "mp005_s_posse_butcher02x",
        interaction = { { text = "Découper la carcasse", type = "butcher" }, { text = "Faire du cuir avec une peau", type = "leather" } },
        -- murphy_craft = {
        --     name = "Table de boucher",
        --     categories = { "food" },
        --     radius = 3.0,
        --     -- blip = {
        --     --     hash = "blip_mp_deliver_target", -- Blip hash
        --     --     modifier = "BLIP_MODIFIER_MP_COLOR_4", -- Blip modifier
        --     --     displaydistance = 20.0, -- Distance at which the blip is displayed, nil to display it always
        --     --     scale = 0.8
        --     -- }
        -- }
    },
    butcherstation = {
        item = "butcherstation",
        propset = { "pg_ambient_camp_add_butcher01" },
        interactionentity = "p_gangtablemake02x",
        interaction = { { text = "Découper la carcasse", type = "butcher" }, { text = "Faire du cuir avec une peau", type = "leather" } },
        -- murphy_craft = {
        --     name = "Table de boucher",
        --     categories = { "food" },
        --     radius = 3.0,
        --     -- blip = {
        --     --     hash = "blip_mp_deliver_target", -- Blip hash
        --     --     modifier = "BLIP_MODIFIER_MP_COLOR_4", -- Blip modifier
        --     --     displaydistance = 20.0, -- Distance at which the blip is displayed, nil to display it always
        --     --     scale = 0.8
        --     -- }
        -- }
    },
    bath = { item = "bath", propset = { "pg_ambient_camp_add_bathtub01" }, interactionentity = "p_washtub02x" },
    laundry = { item = "laundry", propset = { "pg_ambient_camp_add_laundry" }, interactionentity = "p_sawbucktable01x" },
    exploreherb = {
        item = "exploreherb",
        propset = { "pg_ambient_camp_add_explore" },
        interactionentity = "p_telescope01x"
    },
    golddigger = {
        item = "golddigger",
        propset = { "pg_ambient_camp_add_mine" },
        interactionentity = "p_goldcradlestand01x"
    },
    pelt = { item = "pelt", propset = { "pg_ambient_camp_add_pelts01" }, interactionentity = "p_peltbeaver01x" },
    cookstation01 = {
        item = "cookstation01",
        propset = { "pg_ambient_camp_add_station" },
        interactionentity = "p_gangtablemake01x"
    },
    cookstation02 = {
        item = "cookstation02",
        propset = { "pg_ambient_camp_add_station02" },
        interactionentity = "p_sawbucktable01x"
    },
    workbench = {
        item = "workbench",
        props = "mp005_s_posse_ammotable04x",
        interactionentity = "p_sawbucktable01x",
                murphy_craft = {
            name = "Atelier d'armurier/bricoleur",
            categories = { "armurier", "bricoleur" },
            radius = 3.0,
            -- blip = {
            --     hash = "blip_mp_deliver_target", -- Blip hash
            --     modifier = "BLIP_MODIFIER_MP_COLOR_4", -- Blip modifier
            --     displaydistance = 20.0, -- Distance at which the blip is displayed, nil to display it always
            --     scale = 0.8
            -- }
        }
    },
    
    waterbarrel = {
        item = "waterbarrel",
        propset = { "pg_ambient_camp_add_water01" },
        interactionentity = "p_barrel_wash01x"
    },
    still = {
        item = "still",
        propset = { "pg_mp_moonshinecamp03x" },
        interactionentity = "p_still02x",
        interaction = { { text = "Distill", type = "moonshiner" } }
    },
    ---- horse enclosure ----
    horseenclosure01 = {
        item = "horseenclosure01",
        propset = { "PG_MP_POSSECAMP_HORSEENCLOSURE_LARGE000X" },
        interactionentity = "p_barrel05b",
    },
    horseenclosure02 = {
        item = "horseenclosure02",
        propset = { "PG_MP_POSSECAMP_HORSEENCLOSURE_EXTRALARGE000X" },
        interactionentity = "p_pitchfork03x",
    },
    horseenclosure03 = {
        item = "horseenclosure03",
        propset = { "pg_mp_posseCamp_horseEnclo_lrg_combined" },
        interactionentity = "p_barrel05b",
    },
    horseenclosure04 = {
        item = "horseenclosure04",
        propset = { "pg_mp_posseCamp_horseEnclo_exlrg_combined" },
        interactionentity = "p_pitchfork03x",
        stable = false
    },
    ---- wagon -----
    wagonbutcher = {
        item = "wagonbutcher",
        propset = { "pg_ambient_camp_add_packwagonbutcher01" },
        interactionentity = "p_chestmedice01x"
    },
    wagoncook = {
        item = "wagoncook",
        propset = { "pg_ambient_camp_add_packwagoncookprep01" },
        interactionentity = "s_chuckwagon01a"
    }
}
