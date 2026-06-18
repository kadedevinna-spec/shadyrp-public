----------------------------------------------------------------
-- WEEKLY MISSIONS
----------------------------------------------------------------

Config.Missions["Weekly"] = {}

Config.Missions["Weekly"]["track_repairs"] = {
    title = "Town Hero",
    description = "Help the town by repairing damaged tracks around the area",
    missionImage = "mission_hero.png",
    
    sequentialTasks = false,  -- false = every task can be completed in random order, true = tasks need to be completed in the order they are listed in the config
    tasks = {
        "track_repair",
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