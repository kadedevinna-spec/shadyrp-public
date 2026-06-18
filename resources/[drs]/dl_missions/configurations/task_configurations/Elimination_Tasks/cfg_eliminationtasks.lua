----------------------------------------------------------------
-- TASK KONFIGURATION FOR ELIMINATION TASKS (Type 4)
----------------------------------------------------------------
-- Here we define all the elimination tasks that can be used in the missions. You can create as many tasks as you want and use them in different missions. Just make sure to give them a unique name and configure them according to your needs.
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
-- ELIMINATION TASKS (Type 4)
----------------------------------------------------------------

Config.Tasks["kill_wolves_5"] = {
    type = 4, -- Task Type
    title = "Wolf Plague", -- Task Title
    description = "Kill 5 wolves", -- Task Description
    
    targetAmount = 5, -- Numbers of enemies to kill
    
    targetNames = {"A_C_Wolf", "A_C_Wolf_Medium", "A_C_Wolf_Small", "MP_A_C_Wolf_01"}, -- Entity-Hash/Name
    
    -- OPTIONAL: Weapon Requirement
    weaponRequirement = {}, -- nil = Any weapon, "WEAPON_RIFLE_SPRINGFIELD" = Specific weapon
    
    restartable = true
}


Config.Tasks["kill_wolves_30"] = {
    type = 4, -- Task Type
    title = "Wolf Plague", -- Task Title
    description = "Kill 30 wolves", -- Task Description
    
    targetAmount = 30, -- Numbers of enemies to kill
    
    targetNames = {"A_C_Wolf", "A_C_Wolf_Medium", "A_C_Wolf_Small", "MP_A_C_Wolf_01"}, -- Entity-Hash/Name
    
    -- OPTIONAL: Weapon Requirement
    weaponRequirement = {}, -- nil = Any weapon, "WEAPON_RIFLE_SPRINGFIELD" = Specific weapon
    
    restartable = true
}


Config.Tasks["hunt_deer_bow"] = {
    type = 4, -- Task Type
    title = "Deer Hunting", -- Task Title
    description = "Hunt 5 deer with a bow", -- Task Description
    
    targetAmount = 5, -- Numbers of enemies to kill
    
    targetNames = {"A_C_Deer_01","MP_A_C_Deer_01"}, -- Entity-Hash/Name
    
    -- OPTIONAL: Weapon Requirement
    weaponRequirement = {"WEAPON_BOW"}, -- nil = Any weapon, "WEAPON_RIFLE_SPRINGFIELD" = Specific weapon
    
    restartable = true
}



--------------------------------------------------------------------------------------------------------
/*
Config.Tasks["kill_wolves_5"] = {
    type = 4, -- Task Type
    title = "Wolf Plague", -- Task Title
    description = "Kill 5 wolves", -- Task Description
    
    targetAmount = 5, -- Numbers of enemies to kill
    
    targetNames = {"A_C_Wolf", "A_C_Wolf_Medium", "A_C_Wolf_Small", "MP_A_C_Wolf_01"}, -- Entity-Hash/Name
    
    -- OPTIONAL: Weapon Requirement
    weaponRequirement = {"WEAPON_RIFLE_SPRINGFIELD", "WEAPON_BOW"}, -- nil = Any weapon, "WEAPON_RIFLE_SPRINGFIELD" = Specific weapon
    
    restartable = true
}
*/
---------------------------------------------------------------------------------------------------------------------------------------
