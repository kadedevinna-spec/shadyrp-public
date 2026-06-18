-- TASK KONFIGURATION FOR TRAVEL TASKS (Type 1)
----------------------------------------------------------------
-- Here we define all the travel tasks that can be used in the missions. You can create as many tasks as you want and use them in different missions. Just make sure to give them a unique name and configure them according to your needs.
----------------------------------------------------------------

Config = Config or {}
Config.Tasks = Config.Tasks or {}

----------------------------------------------------------------
-- TASK TYPES:
-- 1 = Travel      (Cover distance)
-- 2 = Collection  (Collect items, quest or inventory items)
-- 3 = Delivery    (Deliver/place items at NPC, position or vehicle (quest or inventory items))
-- 4 = Elimination (Kill enemies)
-- 5 = Patrol      (Reach specific points)
-- 6 = Talk        (Talk to NPC)
-- 7 = Use         (Use/consume inventory item)
-- 8 = Interaction (Interact at coords e.g. repair fence, clean windows, mine stone, etc.)
-- 9 = Integration (Integrate with other scripts, this task can only be completed through an export function)


----------------------------------------------------------------
----------------------------------------------------------------
-- TRAVEL TASKS (Type 1)
----------------------------------------------------------------

Config.Tasks["travel_horse_5km"] = {
    type = 1, -- Task Type
    title = "Ride 1 Kilometer", -- Task Title
    description = "Travel 1000 meters on horseback", -- Task Description
    targetAmount = 1000, -- Target Amount in Meters
    vehicleRequirement = { -- horse, boat, wagon, train, foot -- If empty then any means of transportation is allowed
        "horse",
    },
    restartable = true
}


Config.Tasks["travel_any_3km"] = {
    type = 1,
    title = "Traveler",
    description = "Travel 3 kilometers by any means",
    targetAmount = 3000,
    vehicleRequirement = {},
    restartable = true
}


Config.Tasks["travel_any_20km"] = {
    type = 1,
    title = "Traveler",
    description = "Travel 20 kilometers (any means)",
    targetAmount = 20000,
    vehicleRequirement = {},
    restartable = true
}


Config.Tasks["travel_boat_2km"] = {
    type = 1,
    title = "Boat Traveler",
    description = "Travel 2 kilometers by boat",
    targetAmount = 2000,
    vehicleRequirement = {
        "boat"
    },
    restartable = true
}

------------------------------------------------------------------------------------------------
/*
Config.Tasks["UNIQUE_TASK_NAME"] = {
    type = 1, -- Task Type
    title = "TASK_TITLE", -- Task Title
    description = "TASK_DESCRIPTION", -- Task Description
    targetAmount = 1000, -- Target Amount in Meters
    vehicleRequirement = { -- horse, boat, wagon, train, foot
        "horse",
    },
    restartable = true
}
*/

----------------------------------------------------------------
-- SHADYRP CUSTOM TRAVEL TASKS
----------------------------------------------------------------

Config.Tasks["shadyrp_ledger_ride_out"] = {
    type = 1,
    title = "Ride 750 Meters",
    description = "Ride 750 meters on horseback. This objective only progresses while you are mounted.",
    targetAmount = 750,
    vehicleRequirement = {
        "horse",
    },
    restartable = false
}

Config.Tasks["shadyrp_outlaw_ride_clear"] = {
    type = 1,
    title = "Put Distance Behind You",
    description = "Ride 500 meters on horseback after planting the false trail.",
    targetAmount = 500,
    vehicleRequirement = {
        "horse",
    },
    restartable = false
}
