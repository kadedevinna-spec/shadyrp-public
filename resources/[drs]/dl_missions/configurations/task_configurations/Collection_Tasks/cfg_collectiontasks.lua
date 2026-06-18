----------------------------------------------------------------
-- TASK KONFIGURATION FOR COLLECTION TASKS (Type 2)
----------------------------------------------------------------
-- Here we define all the collection tasks that can be used in the missions. You can create as many tasks as you want and use them in different missions. Just make sure to give them a unique name and configure them according to your needs.
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
-- COLLECTION TASKS (Type 2)
----------------------------------------------------------------


-- Example Task: Collect a lost diary, this diary is a Quest Item and can be used in future / other tasks. Carry Animation can be defined in the cfg_task_items.lua file for the "lost_diary" item.
Config.Tasks["collect_diary"] = {
    type = 2, -- Task Type
    title = "Lost Diary", -- Task Title
    description = "Find the lost diary", -- Task Description
    
    targetAmount = 1, -- Numbers of items to collect

    isQuestItem = true, -- false = Inventory Item, true = Quest Item, if its a Quest Item, you have to define it in the cfg_task_items.lua file
    itemName = "lost_diary", -- Item-Name of the Inventory Item or Item Name of the Quest Item
    saveQuestItem = true, -- Save the Quest Item in database to be used in future tasks

    collectionType = "position", -- position or vehicle

    -- OPTIONAL: Collection Positions (if its a Quest-Item) (Positions where the Item can be collected)
    targetPosition = {
        {x = -178.68, y = 648.09, z = 113.36}, -- {x = 100.0, y = 200.0, z = 30.0, h = 20.0, radius = 50.0} radius = spawn radius of the entity
    },

    blip = {
        coords = { -- if not provided use the corresponding coords from targetPosition
            {x = -168.68, y = 648.09, z = 113.36},
        }, 
        sprite = 748106308,
        color = "BLIP_MODIFIER_MP_COLOR_10",
        scale = 0.8,
        name = "Lost Diary",
        zoneradius = 10.0, -- if this value is greater than 0, an Area Blip will be created instead of a normal one
    },

    -- OPTIONAL: Vehicle Collection Only relevant if collectionType = "vehicle"
    vehicleCollection = {
        useVehicleMissionRef = "", -- Reference to a vehicle that was spawned through the mission, e.g. does not despawn when the task is completed -> Other tasks can interact with this vehicle e.g. Collection Task (taking boxes out of vehicle)
    },

    restartable = true
}


-- Example Task: The System checks if the player has the required amount of bread in his inventory to complete the task.
Config.Tasks["collect_bread"] = {
    type = 2,
    title = "Fresh Bread",
    description = "Collect fresh Bread",
    
    targetAmount = 5, -- Numbers of items to collect
    isQuestItem = false, 
    itemName = "bread", 

    saveQuestItem = false, 

    collectionType = "position", -- position or vehicle

    -- OPTIONAL: Collection Positions (if Quest-Item)
    targetPosition = {
        {x = -178.68, y = 648.09, z = 113.36}, -- {x = 100.0, y = 200.0, z = 30.0, radius = 50.0}
    },

    vehicleCollection = {
        useVehicleMissionRef = "", 
    },

    restartable = true
}

-- Example Task: Collect wooden crates, these crates are Quest Items and can be used in future / other tasks. The player has to go to the defined positions and pick up the crates, after picking up the crates, they will be added to the player's inventory as Quest Items.
Config.Tasks["collect_crates"] = {
    type = 2,
    title = "Pick up the wooden crates",
    description = "Find and pick up the wooden crates",
    
    targetAmount = 3, -- Numbers of items to collect

    isQuestItem = true, -- false = Inventory Item, true = Quest Item
    itemName = "wooden_crate", -- Item-Name of the Inventory Item or Item Name of the Quest Item
    saveQuestItem = true, -- Save the Quest Item in database to be used in future tasks ?

    collectionType = "position", -- position or vehicle

    -- OPTIONAL: Collection Positions (if its a Quest-Item)
    targetPosition = {
        {x = -193.07, y = 631.27, z = 112.40},
        {x = -191.96, y = 633.60, z = 112.37},
        {x = -194.87, y = 628.48, z = 112.40},
    },

    blip = {
        coords = {}, 
        sprite = 748106308,
        color = "BLIP_MODIFIER_MP_COLOR_10",
        scale = 0.8,
        name = "Create",
        zoneradius = 0, -- if this value is greater than 0, an Area Blip will be created instead of a normal one
    },

    -- OPTIONAL: Vehicle Collection Only relevant if collectionType = "vehicle"
    vehicleCollection = {
        useVehicleMissionRef = "", -- Reference to a vehicle that was spawned through the mission, e.g. does not despawn when the task is completed -> Other tasks can interact with this vehicle e.g. Collection Task (taking boxes out of vehicle)
    },
    
    restartable = false
}

-- Example Task: Collect wooden crates, these crates are Quest Items and can be used in future / other tasks. The player has to go to the defined positions and pick up the crates, after picking up the crates, they will be added to the player's inventory as Quest Items.
Config.Tasks["collect_barrels"] = {
    type = 2,
    title = "Pick up the wooden Barrels",
    description = "Find and pick up the wooden barrels",
    
    targetAmount = 3, -- Numbers of items to collect

    isQuestItem = true, -- false = Inventory Item, true = Quest Item
    itemName = "heavy_barrel", -- Item-Name of the Inventory Item or Item Name of the Quest Item
    saveQuestItem = true, -- Save the Quest Item in database to be used in future tasks ?

    collectionType = "position", -- position or vehicle

    -- OPTIONAL: Collection Positions (if its a Quest-Item)
    targetPosition = {
        {x = -726.14, y = -1259.37, z = 43.73},
        {x = -726.78, y = -1259.88, z = 43.73},
        {x = -727.37, y = -1259.49, z = 43.73},
    },

    blip = {
        coords = {}, 
        sprite = 748106308,
        color = "BLIP_MODIFIER_MP_COLOR_10",
        scale = 0.8,
        name = "Barrel",
        zoneradius = 0, -- if this value is greater than 0, an Area Blip will be created instead of a normal one
    },

    -- OPTIONAL: Vehicle Collection Only relevant if collectionType = "vehicle"
    vehicleCollection = {
        useVehicleMissionRef = "", -- Reference to a vehicle that was spawned through the mission, e.g. does not despawn when the task is completed -> Other tasks can interact with this vehicle e.g. Collection Task (taking boxes out of vehicle)
    },
    
    restartable = false
}




--------------------------------------------------------------------------------------------------------------------------------------
/*
Config.Tasks["UNIQUE_TASK_NAME"] = {
    type = 2,
    title = "TASK TITLE",
    description = "TASK DESCRIPTION",
    
    targetAmount = 3, -- Numbers of items to collect

    isQuestItem = true, -- false = Inventory Item, true = Quest Item
    itemName = "ITEM_NAME", -- Item-Name of the Inventory Item or Item Name of the Quest Item
    saveQuestItem = true, -- Save the Quest Item in database to be used in future tasks ?

    collectionType = "position", -- position or vehicle

    -- OPTIONAL: Collection Positions (if its a Quest-Item)
    targetPosition = {
        {x = -193.07, y = 631.27, z = 112.40},
        {x = -191.96, y = 633.60, z = 112.37},
        {x = -194.87, y = 628.48, z = 112.40},
    },

    blip = {
        coords = {}, 
        sprite = 748106308,
        color = "BLIP_MODIFIER_MP_COLOR_10",
        scale = 0.8,
        name = "Create",
        zoneradius = 0, -- if this value is greater than 0, an Area Blip will be created instead of a normal one
    },

    -- OPTIONAL: Vehicle Collection Only relevant if collectionType = "vehicle"
    vehicleCollection = {
        useVehicleMissionRef = "", -- Reference to a vehicle that was spawned through the mission, e.g. does not despawn when the task is completed -> Other tasks can interact with this vehicle e.g. Collection Task (taking boxes out of vehicle)
    },
    
    restartable = false
}
*/
--------------------------------------------------------------------------------------------------------------------------------------

----------------------------------------------------------------
-- SHADYRP CUSTOM COLLECTION TASKS
----------------------------------------------------------------

Config.Tasks["shadyrp_collect_sealed_ledger"] = {
    type = 2,
    title = "Recover the Ledger",
    description = "Search the old camp north of Valentine and recover the sealed ledger.",

    targetAmount = 1,

    isQuestItem = true,
    itemName = "shadyrp_sealed_ledger",
    saveQuestItem = true,

    collectionType = "position",

    targetPosition = {
        {x = -178.68, y = 648.09, z = 113.36},
    },

    blip = {
        coords = {
            {x = -178.68, y = 648.09, z = 113.36},
        },
        sprite = 748106308,
        color = "BLIP_MODIFIER_MP_COLOR_10",
        scale = 0.8,
        name = "Sealed Ledger",
        zoneradius = 10.0,
    },

    vehicleCollection = {
        useVehicleMissionRef = "",
    },

    restartable = false
}
