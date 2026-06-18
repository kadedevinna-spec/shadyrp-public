----------------------------------------------------------------
-- TASK KONFIGURATION FOR INTERACTION TASKS (Type 8)
----------------------------------------------------------------
-- Here we define all the interaction tasks that can be used in the missions. You can create as many tasks as you want and use them in different missions. Just make sure to give them a unique name and configure them according to your needs.
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
-- INTERACTION TASK (Typ 8)
----------------------------------------------------------------

Config.Tasks["track_repair"] = {
    type = 8, -- Task Type
    title = "Train Track Repair", -- Task Title
    description = "Repair the track", -- Task Description
    
    targetAmount = 2, -- Numbers of Interactions to perform, e.g. 2 different positions that need to be repaired
    
    -- Interaction-Positions
    targetPosition = {
        {x = -144.47, y = 654.54, z = 113.53, h=182.34},
        {x = -127.56, y = 664.94, z = 113.69, h=341.98},
    },
    
    drawMarker = true, -- Show a marker at the interaction position
    markerSettings = {type=0x94FDAE17, r=255, g=255, b=255, a=100, scaleX=1.0, scaleY=1.0, scaleZ=0.1}, -- Marker settings

    -- Optional: Needed Inventory Items for the interaction
    interactionEquipment = {
    }, 
    interactionOptions = {
        animation = {
            animationDuration = 10000, -- Time in ms the animation will be played
            animDict = "amb_work@world_human_sledgehammer@male@base",
            animName = "base",
        },
        prop = {
            spawnProp = "p_sledgehammer01x", -- Optional Spawned prop for the Animation
            propBone = 37709, -- Bone where the Prop is attached to
            propPlacement = {x=0.0, y=0.0, z=0.0, xRot=0.0, yRot=0.0, zRot=0.0} -- Offset for the Prop relative to the Bone
        }
    },

    blip = {
        coords = {}, 
        sprite = 748106308,
        color = "BLIP_MODIFIER_MP_COLOR_10",
        scale = 0.8,
        name = "Broken Train Track",
        zoneradius = 0, -- If this value is greater than 0, an Area Blip will be created instead of a normal one
    },

    restartable = false
}


Config.Tasks["chimney_cleaning"] = {
    type = 8,
    title = "Chimney Cleaning",
    description = "Clean the chimney",
    
    targetAmount = 1,
    
    targetPosition = {
        {x = -310.01, y = 807.5, z = 127.7, h=212.69},
    },

    drawMarker = true, 
    markerSettings = {type=0x94FDAE17, r=255, g=255, b=255, a=100, scaleX=1.0, scaleY=1.0, scaleZ=0.1},

    -- Optional:
    interactionEquipment = {},
    interactionOptions = {
        animation = {
            animationDuration = 10000,
            animDict = "amb_work@world_human_bartender@cleaning@glass@female_a@idle_a",
            animName = "idle_a",
        },
        prop = {
            spawnProp = "", 
            propBone = 37709,
            propPlacement = {x=0.0, y=0.0, z=0.0, xRot=0.0, yRot=0.0, zRot=0.0}
        }
    },

    blip = {
        coords = {}, 
        sprite = 748106308,
        color = "BLIP_MODIFIER_MP_COLOR_10",
        scale = 0.8,
        name = "Dirty Chimney",
        zoneradius = 0,
    },
    
    restartable = false
}


Config.Tasks["brooming"] = {
    type = 8,
    title = "Sweeping",
    description = "Clean the area",
    
    targetAmount = 1,
    
    targetPosition = {
        {x = -247.36, y = 769.67, z = 118.14, h=30.73},
    },
    
    drawMarker = true,
    markerSettings = {type=0x94FDAE17, r=255, g=255, b=255, a=100, scaleX=1.0, scaleY=1.0, scaleZ=0.1},

    interactionEquipment = {},
    interactionOptions = {
        animation = {
            animationDuration = 10000,
            animDict = "amb_work@world_human_broom@working@female_a@base",
            animName = "base",
        },
        prop = {
            spawnProp = "p_broom01x", 
            propBone = 7966, 
            propPlacement = {x=0.0, y=0.0, z=0.0, xRot=0.0, yRot=0.0, zRot=0.0} 
        }
    },

    blip = {
        coords = {}, 
        sprite = 748106308,
        color = "BLIP_MODIFIER_MP_COLOR_10",
        scale = 0.8,
        name = "Dirty Floor",
        zoneradius = 0,
    },
    
    restartable = false
}


Config.Tasks["fence_repair"] = {
    type = 8,
    title = "Fence Repair",
    description = "Repair the fence",
    
    targetAmount = 1,
    
    targetPosition = {
        {x = -256.73, y = 799.03, z = 119.13, h=289.44},
    },
    
    drawMarker = true,
    markerSettings = {type=0x94FDAE17, r=255, g=255, b=255, a=100, scaleX=1.0, scaleY=1.0, scaleZ=0.1},

    interactionEquipment = {},
    interactionOptions = {
        animation = {
            animationDuration = 10000,
            animDict = "amb_work@world_human_hammer@kneel@male_a@trans",
            animName = "base_trans_base",
        },
        prop = {
            spawnProp = "p_hammer01x",
            propBone = 7966,
            propPlacement = {x=0.0, y=0.0, z=0.0, xRot=0.0, yRot=0.0, zRot=0.0}
        }
    },

    blip = {
        coords = {}, 
        sprite = 748106308,
        color = "BLIP_MODIFIER_MP_COLOR_10",
        scale = 0.8,
        name = "Broken Fence",
        zoneradius = 0,
    },

    restartable = false
}


Config.Tasks["ground_repair"] = {
    type = 8,
    title = "Floor Repair",
    description = "Repair the floor boards",
    
    targetAmount = 3,
    
    targetPosition = {
        {x = -316.67, y = 779.93, z = 118.03, h=105.66},
        {x = -314.67, y = 771.88, z = 118.05, h=9.17},
        {x = -301.47, y = 782.97, z = 118.75, h=98.23},
    },
    
    drawMarker = true,
    markerSettings = {type=0x94FDAE17, r=255, g=255, b=255, a=100, scaleX=1.0, scaleY=1.0, scaleZ=0.1},

    interactionEquipment = {},
    interactionOptions = {
        animation = {
            animationDuration = 7000,
            animDict = "amb_work@world_human_hammer@ground@male_a@trans",
            animName = "base_trans_base",
        },
        prop = {
            spawnProp = "p_hammer01x",
            propBone = 7966,
            propPlacement = {x=0.0, y=0.0, z=0.0, xRot=0.0, yRot=0.0, zRot=0.0} 
        }
    },

    blip = {
        coords = {}, 
        sprite = 748106308,
        color = "BLIP_MODIFIER_MP_COLOR_10",
        scale = 0.8,
        name = "Broken Floor Board",
        zoneradius = 0, 
    },
    
    restartable = false
}


Config.Tasks["mine_pickaxe"] = {
    type = 8,
    title = "Mine Worker",
    description = "Work in the mine",
    
    targetAmount = 3,
    
    targetPosition = {
        {x = -2351.15, y = 110.1, z = 217.91, h = 103.81},
        {x = -2336.47, y = 107.38, z = 222.74, h = 246.57},
        {x = -2318.84, y = 93.75, z = 222.05, h = 244.6},
    },
    
    drawMarker = true,
    markerSettings = {type=0x94FDAE17, r=255, g=255, b=255, a=100, scaleX=1.0, scaleY=1.0, scaleZ=0.1},

    interactionEquipment = {
        {name = "pickaxe", amount = 1}
    },
    interactionOptions = {
        animation = {
            animationDuration = 15000,
            animDict = "script_common@shared_scenarios@event_area@world_human_pickaxe@male_a@idle_a",
            animName = "idle_a",
        },
        prop = {
            spawnProp = "p_pickaxe01x",
            propBone = 37709,
            propPlacement = {x=0.0, y=0.0, z=0.0, xRot=0.0, yRot=0.0, zRot=0.0}
        }
    },

    blip = {
        coords = {}, 
        sprite = 748106308,
        color = "BLIP_MODIFIER_MP_COLOR_10",
        scale = 0.8,
        name = "Mining Point",
        zoneradius = 0,
    },
    
    restartable = false
}

-------------------------------------------------------------------------------------------
/*
Config.Tasks["UNIQUE_TASK_NAME"] = {
    type = 8, -- Task Type
    title = "TASK_TITLE", -- Task Title
    description = "TASK_DESCRIPTION", -- Task Description
    
    targetAmount = 2, -- Numbers of Interactions to perform, e.g. 2 different positions that need to be repaired
    
    -- Interaction-Positions
    targetPosition = {
        {x = -144.47, y = 654.54, z = 113.53, h=182.34},
        {x = -127.56, y = 664.94, z = 113.69, h=341.98},
    },
    
    drawMarker = true, -- Show a marker at the interaction position
    markerSettings = {type=0x94FDAE17, r=255, g=255, b=255, a=100, scaleX=1.0, scaleY=1.0, scaleZ=0.1}, -- Marker settings

    -- Optional: Needed Inventory Items for the interaction
    interactionEquipment = {
    }, 
    interactionOptions = {
        animation = {
            animationDuration = 10000, -- Time in ms the animation will be played
            animDict = "amb_work@world_human_sledgehammer@male@base",
            animName = "base",
        },
        prop = {
            spawnProp = "p_sledgehammer01x", -- Optional Spawned prop for the Animation
            propBone = 37709, -- Bone where the Prop is attached to
            propPlacement = {x=0.0, y=0.0, z=0.0, xRot=0.0, yRot=0.0, zRot=0.0} -- Offset for the Prop relative to the Bone
        }
    },

    blip = {
        coords = {}, 
        sprite = 748106308,
        color = "BLIP_MODIFIER_MP_COLOR_10",
        scale = 0.8,
        name = "BLIP_LABEL",
        zoneradius = 0, -- If this value is greater than 0, an Area Blip will be created instead of a normal one
    },

    restartable = false
}
*/
-----------------------------------------------------------------------------------------------

----------------------------------------------------------------
-- SHADYRP CUSTOM INTERACTION TASKS
----------------------------------------------------------------

Config.Tasks["shadyrp_copy_bank_records"] = {
    type = 8,
    title = "Copy the Bank Records",
    description = "Copy the bank's matching entries so Sheriff Owens has proof beyond the ledger.",

    targetAmount = 1,

    targetPosition = {
        {x = -307.61, y = 775.35, z = 118.75, h = 15.0},
    },

    drawMarker = true,
    markerSettings = {type=0x94FDAE17, r=255, g=255, b=255, a=100, scaleX=1.0, scaleY=1.0, scaleZ=0.1},

    interactionEquipment = {},
    interactionOptions = {
        animation = {
            animationDuration = 6000,
            animDict = "mech_inventory@crafting@fallbacks",
            animName = "full_craft_and_stow",
        },
        prop = {
            spawnProp = "",
            propBone = 37709,
            propPlacement = {x=0.0, y=0.0, z=0.0, xRot=0.0, yRot=0.0, zRot=0.0}
        }
    },

    blip = {
        coords = {},
        sprite = 748106308,
        color = "BLIP_MODIFIER_MP_COLOR_10",
        scale = 0.8,
        name = "Bank Records",
        zoneradius = 0,
    },

    restartable = false
}

Config.Tasks["shadyrp_return_to_elias_choice"] = {
    type = 8,
    title = "Show Elias the Records",
    description = "Lay the copied bank records on Elias Crowe's papers so he can confirm what you found.",

    targetAmount = 1,

    targetPosition = {
        {x = -171.35, y = 626.55, z = 114.03, h = 125.0},
    },

    drawMarker = true,
    markerSettings = {type=0x94FDAE17, r=255, g=255, b=255, a=100, scaleX=1.0, scaleY=1.0, scaleZ=0.1},

    interactionEquipment = {},
    interactionOptions = {
        animation = {
            animationDuration = 5000,
            animDict = "mech_inventory@crafting@fallbacks",
            animName = "full_craft_and_stow",
        },
        prop = {
            spawnProp = "",
            propBone = 37709,
            propPlacement = {x=0.0, y=0.0, z=0.0, xRot=0.0, yRot=0.0, zRot=0.0}
        }
    },

    blip = {
        coords = {},
        sprite = 748106308,
        color = "BLIP_MODIFIER_MP_COLOR_10",
        scale = 0.8,
        name = "Elias's Papers",
        zoneradius = 0,
    },

    restartable = false
}

Config.Tasks["shadyrp_law_post_notice"] = {
    type = 8,
    title = "Post the Evidence Notice",
    description = "Post Deputy Clara's sealed notice on the Valentine jail board.",

    targetAmount = 1,

    targetPosition = {
        {x = -274.62, y = 806.92, z = 119.38, h = 155.0},
    },

    drawMarker = true,
    markerSettings = {type=0x94FDAE17, r=255, g=255, b=255, a=100, scaleX=1.0, scaleY=1.0, scaleZ=0.1},

    interactionEquipment = {},
    interactionOptions = {
        animation = {
            animationDuration = 5000,
            animDict = "mech_inventory@crafting@fallbacks",
            animName = "full_craft_and_stow",
        },
        prop = {
            spawnProp = "",
            propBone = 37709,
            propPlacement = {x=0.0, y=0.0, z=0.0, xRot=0.0, yRot=0.0, zRot=0.0}
        }
    },

    blip = {
        coords = {},
        sprite = 748106308,
        color = "BLIP_MODIFIER_MP_COLOR_10",
        scale = 0.8,
        name = "Jail Notice Board",
        zoneradius = 0,
    },

    restartable = false
}

Config.Tasks["shadyrp_outlaw_plant_false_trail"] = {
    type = 8,
    title = "Plant the False Trail",
    description = "Scatter false ledger scraps west of the ridge camp so the law chases the wrong rider.",

    targetAmount = 1,

    targetPosition = {
        {x = -571.20, y = 408.40, z = 87.92, h = 258.0},
    },

    drawMarker = true,
    markerSettings = {type=0x94FDAE17, r=255, g=255, b=255, a=100, scaleX=1.0, scaleY=1.0, scaleZ=0.1},

    interactionEquipment = {},
    interactionOptions = {
        animation = {
            animationDuration = 6000,
            animDict = "mech_inventory@crafting@fallbacks",
            animName = "full_craft_and_stow",
        },
        prop = {
            spawnProp = "",
            propBone = 37709,
            propPlacement = {x=0.0, y=0.0, z=0.0, xRot=0.0, yRot=0.0, zRot=0.0}
        }
    },

    blip = {
        coords = {},
        sprite = 748106308,
        color = "BLIP_MODIFIER_MP_COLOR_10",
        scale = 0.8,
        name = "False Trail",
        zoneradius = 0,
    },

    restartable = false
}
