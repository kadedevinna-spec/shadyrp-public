Config.QuestItems = {
    
    -- Wooden Crate
    wooden_crate = { -- Unique Item Name referencing the itemName that is setted up in the task configs
        label = "Wooden Crate", -- Quest Item Label
        model = "mp005_p_mp_collectorbox01x", -- Quest Item Model (must be a valid model in the game) (for visuel representation)

        -- Carry Animation
        carryAnimation = {
            enabled = true,
            dict = "mech_carry_box",
            name = "idle",
            attachBone = 7966,  -- SKEL_R_Hand
            placement = {
                x = 0.0, y = 0.0, z = 0.0,
                xRot = -0.0, yRot = 0.0, zRot = 0.0
            }
        }
    },
    

    -- Wooden Plank
    wooden_plank = {
        label = "Wooden Plank",
        model = "p_woodplank01x",
        
        carryAnimation = {
            enabled = true,
            dict = "mech_loco_m@generic@carry@box@front@idle",
            name = "idle",
            attachBone = 7966,
            placement = {
                x = -0.2, y = -0.1, z = -0.10,
                xRot = 0.0, yRot = 0.0, zRot = 0.0
            }
        }
    },


    -- Lost Diary
    lost_diary = {
        label = "Lost Diary",
        model = "p_paper03x",

        -- No carry Animation
        carryAnimation = {
            enabled = false
        }
    },
    
    -- Heavy Barrel
    heavy_barrel = {
        label = "Heavy Barrel",
        model = "p_barrel02x",
        
        carryAnimation = {
            enabled = true,
            dict = "amb_work@prop_vehicle_wagon@lumber_load@4@shoulder_lumber@male_a@base",
            name = "base",
            attachBone = 7966,
            placement = {
                x = 0.15, y = -1.25, z = 0.0,
                xRot = -90.0, yRot = 0.0, zRot = 0.0
            }
        }
    },

    ----------------------------------------------------------------
    -- SHADYRP CUSTOM QUEST ITEMS
    ----------------------------------------------------------------

    shadyrp_sealed_ledger = {
        label = "Sealed Ledger",
        model = "p_paper03x",

        carryAnimation = {
            enabled = false
        }
    }

}
