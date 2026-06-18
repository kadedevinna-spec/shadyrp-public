-- TASK KONFIGURATION FOR USE TASKS (Type 7)
----------------------------------------------------------------
-- Here we define all the use tasks that can be used in the missions. You can create as many tasks as you want and use them in different missions. Just make sure to give them a unique name and configure them according to your needs.
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
-- USE TASKS (Typ 7)
----------------------------------------------------------------

Config.Tasks["use_bandages_5"] = {
    type = 7, -- Task Type
    title = "Bandage Practice", -- Task Title
    description = "Use 5 bandages", -- Task Description
    
    targetAmount = 5, -- How much of the item needs to be used/consumed
    
    itemNames = {"bandage"}, -- The Items that are counting for this quest
    
    restartable = true
}

Config.Tasks["drink_whiskey_3"] = {
    type = 7,
    title = "Whiskey Drinker",
    description = "Drink 3 whiskeys",
    targetAmount = 3,
    itemNames = {"whiskey"},
    restartable = true
}

Config.Tasks["smoke_cigars_10"] = {
    type = 7,
    title = "Cigar Smoker",
    description = "Smoke 10 cigars",
    targetAmount = 10,
    itemNames = {"cigar"},
    restartable = true
}
