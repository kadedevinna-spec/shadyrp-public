----------------------------------------------------------------
-- Doctor Missions
----------------------------------------------------------------
Config.Missions["Doctor"] = {}

-- These Missions are in the Doctor Category and are Probably Job Locked to the Doctor Job

Config.Missions["Doctor"]["bandaging"] = {
    title = "Bandaging", -- Mission Title
    description = "Learn how to use bandages to heal yourself and others", -- Mission Description
    missionImage = "mission_travel.png",
    
    tasks = {
        "use_bandages_5",
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