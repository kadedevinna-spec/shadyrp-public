-- TASK KONFIGURATION FOR PATROLTASKS (Type 5)
----------------------------------------------------------------
-- Here we define all the patrol tasks that can be used in the missions. You can create as many tasks as you want and use them in different missions. Just make sure to give them a unique name and configure them according to your needs.
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
-- PATROL TASKS (Typ 5)
----------------------------------------------------------------

Config.Tasks["patrol_scout_val_gunsmith"] = {
    type = 5,
    title = "Valentine Patrol",
    description = "Visit the Gunsmith in Valentine",
    
    targetAmount = 1, -- How many points need to be reached
    
    patrolType = "position", -- position = reach specific positions, player = find specific player

    -- Only used if patrolType = "player"
    targetCharacterIDs = {}, -- target CharacterID of the Player that should be found, if patrolType = "player" is used. If the player is not online no position is set and the task cant be completed.

    -- List of positions that need to be reached (if patrolType = "position")
    targetPosition = {
        {x = -279.51, y = 780.81, z = 119.5, radius = 3.0},
    },
    
    restartable = false
}



Config.Tasks["patrol_scout_gunsmith"] = {
    type = 5,
    title = "Regional Gunsmiths",
    description = "Visit the gunsmiths in Valentine, Rhodes, Saint Denis, and Strawberry",
    
    targetAmount = 4, 
    
    patrolType = "position", 

    targetCharacterIDs = {},

    targetPosition = {
        {x = -279.51, y = 780.81, z = 119.5, radius = 3.0},
        {x = 1325.34, y = -1321.76, z = 77.89, radius = 3.0},
        {x = 2715.42, y = -1284.24, z = 49.63, radius = 3.0},
        {x = -1839.06, y = -420.01, z = 161.66, radius = 3.0},
    },

    -- Optional
    blip = {
        coords = {}, 
        sprite = 748106308,
        color = "BLIP_MODIFIER_MP_COLOR_10",
        scale = 0.8,
        name = "Regional Gunsmith",
        zoneradius = 5.0, -- Wenn dieser Wert größer als 0 ist, wird ein Area Blip erstellt anstatt ein normaler
    },

    restartable = false
}



Config.Tasks["find_gunsmith"] = {
    type = 5,
    title = "Visit the Gunsmith",
    description = "Visit the gunsmith",
    
    targetAmount = 1,
    
    patrolType = "player",

    -- Nur genutzt wenn patrolType = "player" ist
    targetCharacterIDs = {1}, -- target CharacterID of the Player that should be found, if patrolType = "player" is used. If the player is not online no position is set and the task cant be completed.


    targetPosition = {
        {x = 1518.02, y = 436.2, z = 90.68, radius = 3.0}, -- Ignored because patrolType is set to "player"
    },

    blip = {
        coords = {}, 
        sprite = 748106308,
        color = "BLIP_MODIFIER_MP_COLOR_10",
        scale = 0.8,
        name = "Gunsmith",
        zoneradius = 0.0, -- Wenn dieser Wert größer als 0 ist, wird ein Area Blip erstellt anstatt ein normaler
    },

    restartable = false
}



Config.Tasks["patrol_scout_val_saloon"] = {
    type = 5,
    title = "Valentine Patrol",
    description = "Visit the saloon in Valentine",
    
    targetAmount = 1,
    
    patrolType = "position", 

    targetCharacterIDs = {}, 

    targetPosition = {
        {x = -307.8, y = 806.06, z = 118.98, radius = 4.0},
    },

    blip = {
        coords = {}, 
        sprite = 748106308,
        color = "BLIP_MODIFIER_MP_COLOR_10",
        scale = 0.8,
        name = "Saloon von Valentine",
        zoneradius = 5.0, 
    },

    restartable = false
}


----------------------------------------------------------------
/*

Config.Tasks["UNIQUE_TASK_NAME"] = {
    type = 5,
    title = "TASK_TITLE",
    description = "TASK_DESCRIPTION",
    
    targetAmount = 4, 
    
    patrolType = "position", 

    targetCharacterIDs = {},

    targetPosition = {
        {x = -279.51, y = 780.81, z = 119.5, radius = 3.0},
        {x = 1325.34, y = -1321.76, z = 77.89, radius = 3.0},
        {x = 2715.42, y = -1284.24, z = 49.63, radius = 3.0},
        {x = -1839.06, y = -420.01, z = 161.66, radius = 3.0},
    },

    blip = {
        coords = {}, 
        sprite = 748106308,
        color = "BLIP_MODIFIER_MP_COLOR_10",
        scale = 0.8,
        name = "Waffenladen der Region",
        zoneradius = 5.0, -- If this value is greater than 0, an Area Blip will be created instead of a normal one
    },

    restartable = false
}






*/
---------------------------------------------------------------

----------------------------------------------------------------
-- SHADYRP CUSTOM PATROL TASKS
----------------------------------------------------------------

Config.Tasks["shadyrp_check_valentine_bank"] = {
    type = 5,
    title = "Check the Bank Records",
    description = "Visit the Valentine bank and compare the ledger against the town books.",

    targetAmount = 1,

    patrolType = "position",

    targetCharacterIDs = {},

    targetPosition = {
        {x = -307.61, y = 775.35, z = 118.75, radius = 4.0},
    },

    blip = {
        coords = {},
        sprite = 748106308,
        color = "BLIP_MODIFIER_MP_COLOR_10",
        scale = 0.8,
        name = "Valentine Bank",
        zoneradius = 5.0,
    },

    restartable = false
}
