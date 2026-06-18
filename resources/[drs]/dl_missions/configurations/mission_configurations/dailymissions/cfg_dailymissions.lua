----------------------------------------------------------------
-- DAILY MISSIONS
----------------------------------------------------------------
Config.Missions["Daily"] = {}



Config.Missions["Daily"]["traveler"] = {
    title = "Daily Traveler", -- Mission Title
    description = "Explore the world and travel around", -- Mission Description
    missionImage = "mission_travel.png", -- Mission Image that is shown in the Mission Menu, needs to be located in "html/images/taskimages/"
    
    sequentialTasks = false,  -- false = every task can be completed in random order, true = tasks need to be completed in the order they are listed in the config
    tasks = {
        "travel_horse_5km",
        "patrol_scout_gunsmith",
    },
    
    reward = {
        currency = {
            money = 100,
            gold = 5,
            xp = 200
        },
        items = {
            {name = "bread", amount = 5},
            {name = "water", amount = 3}
        },
        events = { -- Server Events that are triggered if the mission is turned in
            {eventName = "dl_missions:server:testCall", eventData = {}, type="event", isServerEvent = true},    -- type can be "event" or "clientEvent", isServerEvent is only necessary if type is "event" to differ between client and server events, if type is "clientEvent" it will automatically be a client event
            {eventName = "exports.vorp_inventory:canCarryItem", eventData = {"bread", "5"}, type="exportFunction"}
        }
    },
    
    restartable = true,
}



Config.Missions["Daily"]["hunter"] = { 
    title = "Hunter",
    description = "Go out into the wild and hunt some animals",
    missionImage = "mission_hunt.png",
    
    sequentialTasks = false,  -- false = every task can be completed in random order, true = tasks need to be completed in the order they are listed in the config
    tasks = {
        "kill_wolves_5",
        "hunt_deer_bow",
        "deliver_meat_butcher"
    },
    
    reward = {
        currency = {
            money = 100,
            gold = 5,
            xp = 200
        },
        items = {
            {name = "bread", amount = 5},
            {name = "water", amount = 3}
        },
        events = { -- Server Events that are triggered if the mission is turned in
            {eventName = "dl_missions:server:testCall", eventData = {}, type="event", isServerEvent = true},    -- type can be "event" or "clientEvent", isServerEvent is only necessary if type is "event" to differ between client and server events, if type is "clientEvent" it will automatically be a client event
            {eventName = "exports.vorp_inventory:canCarryItem", eventData = {"bread", "5"}, type="exportFunction"}
        }
    },
    
    restartable = true
}




----------------------------------------------------------------
-- CLEAN TEMPLATE FOR NON STORY MISSIONS
----------------------------------------------------------------
/*
Config.Missions["MISSION_CATEGORY_HERE"]["UNIQUE_MISSION_NAME_HERE"] = { -- 
    title = "Smokey Job", -- Mission Title
    description = "", -- Mission Description
    missionImage = "rhodes01.png", -- Mission Image that is shown in the Mission Menu, needs to be located in "html/images/taskimages/"
    
    sequentialTasks = false,  -- false = every task can be completed in random order, true = tasks need to be completed in the order they are listed in the config
    tasks = { -- List of Tasks that need to be completed for this mission, references the unique task names defined in Task Configurations
        "track_repair",
        "chimney_cleaning",
        "brooming",
        "fence_repair",
    },

    missionVehicles = { -- Spawning a Mission Vehicle that can be referenced by the tasks of the mission (that makes it possible that every task can interact with the same vehicle)
        delivery1 = { -- Vehicle Reference Name
            model = "supplywagon", -- Spawned Model of the Vehicle, needs to be a valid model that can be spawned in the game
            blip = {
                sprite = 564457427,
                color = "BLIP_MODIFIER_MP_COLOR_10",
                scale = 0.8,
                name = "Lieferwagen" -- Blip Name of the Vehicle
            },
            spawnPositions = { -- Possible Spawn Positions for the Mission Vehicle, the system will try to spawn the vehicle on one of the defined positions, if all positions are blocked it will keep trying until it can spawn the vehicle on one of the defined positions
                {x = -229.20, y = 633.85, z = 113.11, h=234.34},
                {x = -219.67, y = 644.42, z = 113.13, h=225.57},
            },
            cargoPropset = "crates" -- Cargo Propset can be defined in the cfg_vehiclepropset.lua
        },
    },

    reward = {
        currency = { -- Currency rewards that are rewarded to the player upon mission completion
            money = 100,
            gold = 5,
            xp = 200
        },
        items = { -- Items that are rewarded to the player upon mission completion
            {name = "bread", amount = 5},
            {name = "water", amount = 3}
        },
        events = { -- Server Events that are triggered if the mission is turned in
            {eventName = "dl_missions:server:testCall", eventData = {}, type="event", isServerEvent = true},    -- type can be "event" or "clientEvent", isServerEvent is only necessary if type is "event" to differ between client and server events, if type is "clientEvent" it will automatically be a client event
            {eventName = "exports.vorp_inventory:canCarryItem", eventData = {"bread", "5"}, type="exportFunction"}
        }
    },
    
    restartable = false
}
*/

















---------- DEBUG MISSIONS ------------------

Config.Missions["Daily"]["testmission"] = {
    title = "Smokey Job",
    description = "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet.",
    missionImage = "rhodes01.png",
    
    sequentialTasks = true,  -- false = every task can be completed in random order, true = tasks need to be completed in the order they are listed in the config
    tasks = {
        "track_repair",
        "chimney_cleaning",
        "brooming",
        "fence_repair",
        "ground_repair",
        "find_gunsmith",
        'mine_pickaxe',
        'open_admin_menu',
        'deliver_meat_butcher',
    },

    reward = {
        currency = {
            money = 100,
            gold = 5,
            xp = 200
        },
        items = {
            {name = "bread", amount = 5},
            {name = "water", amount = 3}
        },
        events = { -- Server Events that are triggered if the mission is turned in
            {eventName = "dl_missions:server:testCall", eventData = {}, type="event", isServerEvent = true},    -- type can be "event" or "clientEvent", isServerEvent is only necessary if type is "event" to differ between client and server events, if type is "clientEvent" it will automatically be a client event
            {eventName = "exports.vorp_inventory:canCarryItem", eventData = {"bread", "5"}, type="exportFunction"}
        }
    },
    
    restartable = false
}