----------------------------------------------------------------
-- MONTHLY MISSIONS
----------------------------------------------------------------

Config.Missions["Monthly"] = {}

Config.Missions["Monthly"]["master_hunter"] = {
    title = "Master Hunter",
    description = "Become the best hunter in the region",
    missionImage = "mission_master_hunter.png",
    
    sequentialTasks = false,  -- false = every task can be completed in random order, true = tasks need to be completed in the order they are listed in the config
    tasks = {
        "kill_wolves_30",
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