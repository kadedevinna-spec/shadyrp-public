----------------------------------------------------------------
-- TASK KONFIGURATION FOR DELIVERY TASKS (Type 3)
----------------------------------------------------------------
-- Here we define all the delivery tasks that can be used in the missions. You can create as many tasks as you want and use them in different missions. Just make sure to give them a unique name and configure them according to your needs.
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
-- DELIVERY TASKS (Type 3)
----------------------------------------------------------------
 

-- Example Task: Deliver a lost diary to Sheriff Anderson (NPC), this diary is a Quest Item that got collected in a previous Collection Task. 
Config.Tasks["deliver_quest_letter"] = {
    type = 3, -- Task Type
    title = "Deliver the Diary", -- Task Title
    description = "Deliver the lost diary to Sheriff Anderson", -- Task Description
    targetAmount = 1, -- Number of items to deliver
    itemName = "lost_diary", -- Item-Name of the Inventory Item or Item Name of the Quest Item
    isQuestItem = true, -- false = Inventory Item, true = Quest Item, if its a Quest Item, you have to define it in the cfg_task_items.lua file
    
    deliveryType = "npc", -- npc or position or vehicle

    -- Delivery Position
    targetPosition = {x = 2814.75, y = -1427.45, z = 43.62, h=231.43}, -- if deliveryType = "npc" or "position", if it's "vehicle" then the vehicle position will be used because it is dynamic
    deliveryTime = 1500, -- Time in ms required to place the item (e.g., deliver package, place dynamite)

    -- OPTIONAL: NPC Dialog
    npcDelivery = {
        targetNPCModel = "cs_valsheriff", -- Optional, if the item has to be delivered to a specific NPC
        targetNPCName = "Sheriff Anderson",
        targetNPCAnimation = {
            useanim = true,
            dict = "amb_rest_lean@world_human_lean@wall@smoking@male_a@base",
            name = "base",
            flag = 1,
            isScenario = false, -- If true, the animation will be played as a scenario, if false, the animation will be played as a normal animation
            scenario = "",
            scenarioProp = "",
            scenarioPosOffset = vector4(0.0, 0.0, 0.0, 0.0), -- Only relevant if isScenario is true, defines the offset for the scenario position, so the position where the scenario will be played is coords + scenarioPosOffset
        },
        targetNPCDialogue = {
            {text="The diary. I have been looking everywhere for this.", time=4000, audio=""}, -- Written Dialog and optional audio file
            {text="You did not read it, did you?", time=2000, audio=""},
            {text="For your sake, I hope not.", time=3000, audio=""},
            {text="Whatever you saw, keep it to yourself. Understood?", time=8000, audio=""},
            {text="Thank you. Now get moving, and not a word to the priest.", time=10000, audio=""},
        },
    },

    blip = {
        coords = {}, 
        sprite = 748106308,
        color = "BLIP_MODIFIER_MP_COLOR_10",
        scale = 0.8,
        name = "Sheriff Anderson - Lost Diary",
        zoneradius = 0, -- If this value is greater than 0, an Area Blip will be created instead of a normal one
    },

    -- OPTIONAL: Vehicle Delivery Only relevant if deliveryType = "vehicle"
    vehicleDelivery = {
        useVehicleMissionRef = "", -- Reference to a vehicle that was spawned through the mission, despawns e.g. not when the task is completed -> Other tasks can interact with this vehicle e.g. Collection Task (taking boxes out of vehicle)
    },

    restartable = false
}


-- Example Task: Deliver wooden crates to a wagon, these crates are Quest Items that got collected in a previous Collection Task. The wagon is a vehicle that got spawned for the mission as a mission vehicle
Config.Tasks["deliver_crates"] = {
    type = 3,
    title = "Deliver Crates",
    description = "Deliver the wooden crates to the wagon",
    targetAmount = 3, 
    itemName = "wooden_crate",
    isQuestItem = true,
    
    deliveryType = "vehicle",

    targetPosition = {x = -278.41, y = 805.92, z = 118.38, h=0.0}, -- is ignored because deliveryType is "vehicle", the vehicle position will be used because it is dynamic
    deliveryTime = 2000,

    npcDelivery = {
        targetNPCModel = "CS_SheriffOwens",
        targetNPCName = "Sheriff Anderson",
        targetNPCAnimation = {
            useanim = false,
            dict = "amb_rest_lean@world_human_lean@wall@smoking@male_a@base",
            name = "base",
            flag = 1,
            isScenario = false, -- If true, the animation will be played as a scenario, if false, the animation will be played as a normal animation
            scenario = "",
            scenarioProp = "",
            scenarioPosOffset = vector4(0.0, 0.0, 0.0, 0.0), -- Only relevant if isScenario is true, defines the offset for the scenario position, so the position where the scenario will be played is coords + scenarioPosOffset
        },
        targetNPCDialogue = {
            {text="Ah, das Paket! Vielen Dank.", time=2000},
            {text="Das hat aber lange gedauert...", time=2000},
            {text="Hier, deine Belohnung.", time=2000}
        },
    },

    vehicleDelivery = {
        useVehicleMissionRef = "delivery1", -- Reference to the vehicle that got spawned from the mission
    },

    restartable = false
}

-- Example Task: Deliver wooden planks to a specific location
Config.Tasks["deliver_plank"] = {
    type = 3,
    title = "Deliver Planks",
    description = "Deliver the wooden planks to the wagon",
    targetAmount = 1, 
    itemName = "wooden_plank",
    isQuestItem = true,
    
    deliveryType = "position",

    targetPosition = {x = -751.81, y = -1226.57, z = 43.5, h=0.0}, -- used if deliveryType is "npc" or "position", if it's "vehicle" then the vehicle position will be used because it is dynamic

    deliveryTime = 2000,

    -- OPTIONAL: NPC Dialog
    npcDelivery = {
        targetNPCModel = "CS_SheriffOwens", 
        targetNPCName = "Sheriff Anderson",
        targetNPCAnimation = {
            useanim = false,
            dict = "amb_rest_lean@world_human_lean@wall@smoking@male_a@base",
            name = "base",
            flag = 1,
            isScenario = false, -- If true, the animation will be played as a scenario, if false, the animation will be played as a normal animation
            scenario = "",
            scenarioProp = "",
            scenarioPosOffset = vector4(0.0, 0.0, 0.0, 0.0), -- Only relevant if isScenario is true, defines the offset for the scenario position, so the position where the scenario will be played is coords + scenarioPosOffset
        },
        targetNPCDialogue = {
            {text="Ah, das Paket! Vielen Dank.", time=2000},
            {text="Das hat aber lange gedauert...", time=2000},
            {text="Hier, deine Belohnung.", time=2000}
        },
    },

    vehicleDelivery = {
        useVehicleMissionRef = "", 
    },

    restartable = false
}


-- Example Task: Deliver meat to the butcher, the meat is an inventory item
Config.Tasks["deliver_meat_butcher"] = {
    type = 3,
    title = "Meat delivery",
    description = "Deliver Deer Meat to the butcher in Valentine",
    targetAmount = 5, 
    itemName = "aligatormeat",
    isQuestItem = false,
    
    deliveryType = "npc",

    targetPosition = {x = -339.19, y = 767.43, z = 116.58, h = 90.98}, -- used if deliveryType is "npc" or "position", if it's "vehicle" then the vehicle position will be used because it is dynamic

    deliveryTime = 2000,

    -- OPTIONAL: NPC Dialog
    npcDelivery = {
        targetNPCModel = "u_m_m_valbutcher_01", 
        targetNPCName = "Butcher Johnson",
        targetNPCAnimation = {
            useanim = false,
            dict = "amb_rest_lean@world_human_lean@wall@smoking@male_a@base",
            name = "base",
            flag = 1,
            isScenario = false, -- If true, the animation will be played as a scenario, if false, the animation will be played as a normal animation
            scenario = "",
            scenarioProp = "",
            scenarioPosOffset = vector4(0.0, 0.0, 0.0, 0.0), -- Only relevant if isScenario is true, defines the offset for the scenario position, so the position where the scenario will be played is coords + scenarioPosOffset
        },
        targetNPCDialogue = {
            {text="Ah yes, the meat thank you", time=2000},
            {text="I hope its still fresh", time=2000},
        },
    },

    vehicleDelivery = {
        useVehicleMissionRef = "", 
    },

    restartable = false
}




--------------------------------------------------------------------------------------------------------------------------------------
/*
Config.Tasks["UNIQUE_TASK_NAME"] = {
    type = 3, -- Task Type
    title = "TASK_NAME", -- Task Title
    description = "TASK_DESCRIPTION", -- Task Description
    targetAmount = 1, -- Number of items to deliver
    itemName = "ITEM_NAME", -- Item-Name of the Inventory Item or Item Name of the Quest Item
    isQuestItem = true, -- false = Inventory Item, true = Quest Item, if its a Quest Item, you have to define it in the cfg_task_items.lua file
    
    deliveryType = "npc", -- npc or position or vehicle

    -- Delivery Position
    targetPosition = {x = 2814.75, y = -1427.45, z = 43.62, h=231.43}, -- if deliveryType = "npc" or "position", if it's "vehicle" then the vehicle position will be used because it is dynamic
    deliveryTime = 1500, -- Time in ms required to place the item (e.g., deliver package, place dynamite)

    -- OPTIONAL: NPC Dialog
    npcDelivery = {
        targetNPCModel = "NPC_MODEL", -- Optional, if the item has to be delivered to a specific NPC
        targetNPCName = "NPC_NAME",
        targetNPCAnimation = {
            useanim = true, -- If true, the animation will be played, if false, no animation or scenario will be played
            dict = "amb_rest_lean@world_human_lean@wall@smoking@male_a@base",
            name = "base",
            flag = 1,
            isScenario = false, -- If true, the animation will be played as a scenario, if false, the animation will be played as a normal animation
            scenario = "",
            scenarioProp = "",
            scenarioPosOffset = vector4(0.0, 0.0, 0.0, 0.0), -- Only relevant if isScenario is true, defines the offset for the scenario position, so the position where the scenario will be played is coords + scenarioPosOffset
        },
        targetNPCDialogue = {
            {text="Ah.... das Tagebuch! Das habe ich schon überall gesucht!!!.", time=4000, audio="tagebuch/tagebuch_anderson_1.mp3"}, -- Written Dialog and optional audio file
            {text="Hast du reingeschaut du Drecksschwein?", time=2000, audio="tagebuch/tagebuch_anderson_2.mp3"},
        },
    },

    blip = {
        coords = {}, 
        sprite = 748106308,
        color = "BLIP_MODIFIER_MP_COLOR_10",
        scale = 0.8,
        name = "BLIP_LABEL",
        zoneradius = 0, -- If this value is greater than 0, an Area Blip will be created instead of a normal one
    },

    -- OPTIONAL: Vehicle Delivery Only relevant if deliveryType = "vehicle"
    vehicleDelivery = {
        useVehicleMissionRef = "", -- Reference to a vehicle that was spawned through the mission, despawns e.g. not when the task is completed -> Other tasks can interact with this vehicle e.g. Collection Task (taking boxes out of vehicle)
    },

    restartable = false
}
*/
---------------------------------------------------------------------------------------------------------------------------------------

----------------------------------------------------------------
-- SHADYRP CUSTOM DELIVERY TASKS
----------------------------------------------------------------

Config.Tasks["shadyrp_deliver_ledger_sheriff"] = {
    type = 3,
    title = "File the Ledger",
    description = "Place the sealed ledger on the evidence desk inside the Valentine sheriff's office.",
    targetAmount = 1,
    itemName = "shadyrp_sealed_ledger",
    isQuestItem = true,

    deliveryType = "position",

    targetPosition = {x = -276.35, y = 803.42, z = 119.38, h = 336.69},
    deliveryTime = 2000,

    npcDelivery = {
        targetNPCModel = "CS_SheriffOwens",
        targetNPCName = "Sheriff Owens",
        targetNPCAnimation = {
            useanim = false,
            dict = "amb_rest_lean@world_human_lean@wall@smoking@male_a@base",
            name = "base",
            flag = 1,
            isScenario = false,
            scenario = "",
            scenarioProp = "",
            scenarioPosOffset = vector4(0.0, 0.0, 0.0, 0.0),
        },
        targetNPCDialogue = {},
    },

    blip = {
        coords = {},
        sprite = 748106308,
        color = "BLIP_MODIFIER_MP_COLOR_10",
        scale = 0.8,
        name = "Evidence Desk",
        zoneradius = 0,
    },

    vehicleDelivery = {
        useVehicleMissionRef = "",
    },

    restartable = false
}

Config.Tasks["shadyrp_law_deliver_ledger"] = {
    type = 3,
    title = "File the Evidence",
    description = "Place the sealed ledger on the evidence desk inside the Valentine sheriff's office.",
    targetAmount = 1,
    itemName = "shadyrp_sealed_ledger",
    isQuestItem = true,

    deliveryType = "position",

    targetPosition = {x = -276.35, y = 803.42, z = 119.38, h = 336.69},
    deliveryTime = 2000,

    npcDelivery = {
        targetNPCModel = "CS_SheriffOwens",
        targetNPCName = "Sheriff Owens",
        targetNPCAnimation = {
            useanim = false,
            dict = "",
            name = "",
            flag = 1,
            isScenario = false,
            scenario = "",
            scenarioProp = "",
            scenarioPosOffset = vector4(0.0, 0.0, 0.0, 0.0),
        },
        targetNPCDialogue = {},
    },

    blip = {
        coords = {},
        sprite = 748106308,
        color = "BLIP_MODIFIER_MP_COLOR_10",
        scale = 0.8,
        name = "Evidence Desk",
        zoneradius = 0,
    },

    vehicleDelivery = {
        useVehicleMissionRef = "",
    },

    restartable = false
}

Config.Tasks["shadyrp_outlaw_deliver_ledger"] = {
    type = 3,
    title = "Leave the Dead Drop",
    description = "Place the sealed ledger in the dead drop at the ridge camp. Do not hand it to anyone directly.",
    targetAmount = 1,
    itemName = "shadyrp_sealed_ledger",
    isQuestItem = true,

    deliveryType = "position",

    targetPosition = {x = -538.90, y = 390.55, z = 87.18, h = 205.0},
    deliveryTime = 2000,

    npcDelivery = {
        targetNPCModel = "cs_oddfellowspinhead",
        targetNPCName = "Colm's Runner",
        targetNPCAnimation = {
            useanim = false,
            dict = "",
            name = "",
            flag = 1,
            isScenario = false,
            scenario = "",
            scenarioProp = "",
            scenarioPosOffset = vector4(0.0, 0.0, 0.0, 0.0),
        },
        targetNPCDialogue = {},
    },

    blip = {
        coords = {},
        sprite = 748106308,
        color = "BLIP_MODIFIER_MP_COLOR_10",
        scale = 0.8,
        name = "Outlaw Dead Drop",
        zoneradius = 0,
    },

    vehicleDelivery = {
        useVehicleMissionRef = "",
    },

    restartable = false
}
