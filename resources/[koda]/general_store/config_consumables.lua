--- Per-item consumable scenes — prop + anim defined on each row (edit freely).
--- Item must exist in RSGCore.Shared.Items with useable = true.

Config.ConsumablesEnabled = true

Config.ConsumeSettings = {
    useHud = true,
    blockInventory = true,
    defaultDuration = 4800,
}

-- RDR2 native alcohol system (same approach as rsg-consume).
Config.Alcohol = {
    drunkThreshold   = 20,      -- 1 brandy (30 pts) = drunk immediately
    decreaseAmount   = 1,
    decreaseInterval = 5000,
    maxLevel         = 500,
    drunkEffectName  = 'PlayerDrunk01',
    drunkWalkLevel   = 0.95,
}

--[[
  prop   = world model spawned in hand
  attach = { bone, x, y, z, rx, ry, rz }
  attachFemale = optional female offsets
  anim   = single clip OR sequence (used as FALLBACK when native fails):
      { dict, clip, flag?, duration? }
      { sequence = { { dict, clip, flag?, duration?, delay? }, ... } }
  native = PRIMARY interaction (tried first, on foot AND mounted):
      { type = 'interaction',   hash, itemHash?, duration? }
      { type = 'interaction_2', propBone, interactionHash, itemHash?, p7?, duration? }
  animMounted = LEGACY fallback for mounted only (only used when no `native` field)
  duration = scene ms (client waits this long before removing item)
  effects  = { hunger, thirst, stress, alcohol }  -- alcohol = RDR2 drunk points (see Config.Alcohol)
  notify   = { title, text, type?, duration? }    -- shown after scene completes
               type: 'inform' | 'success' | 'error' | 'warning'  (default 'inform')
               omit field entirely = silent | false = also silent
  enabled  = false  -- set to disable without removing the entry
]]
Config.Consumables = {
    biscuits = {
        item = 'biscuits',
        prop = 'p_biscuitsandwich01x',
        duration = 3000,
        attach = { bone = 'SKEL_L_Finger01', x = 0.04, y = -0.03, z = -0.01, rx = 0.0, ry = 19.0, rz = 46.0 },
        attachFemale = { bone = 'SKEL_L_Finger01', x = 0.03, y = -0.025, z = -0.008, rx = 0.0, ry = 16.0, rz = 40.0 },
        native = { type = 'interaction', hash = 'EAT_MULTI_BITE_FOOD_SPHERE_D8-2_SANDWICH_QUICK_LEFT_HAND', duration = 3000 },
        anim   = { dict = 'mech_inventory@eating@multi_bite@sphere_d8-2_sandwich', clip = 'quick_left_hand', flag = 31 },
        effects = { hunger = 20, thirst = 0, stress = 4 },
    },

    canstrawberries = {
        item = 'canstrawberries',
        prop = 's_canstrawberries01x',
        duration = 2750,
        attach = { bone = 'SKEL_L_Finger00', x = 0.10, y = -0.03, z = 0.02, rx = 20.0, ry = -70.0, rz = -20.0 },
        attachFemale = { bone = 'SKEL_L_Finger00', x = 0.08, y = -0.025, z = 0.018, rx = 18.0, ry = -68.0, rz = -18.0 },
        native = { type = 'interaction', hash = 'EAT_CANNED_FOOD_CYLINDER@D8-2_H10-5_QUICK_LEFT', duration = 2750, throw = true },
        anim   = { dict = 'mech_inventory@eating@canned_food@cylinder@d8-2_h10-5', clip = 'left_hand', flag = 31 },
        effects = { hunger = 18, thirst = 12, stress = 3 },
    },

    canpineapple = {
        item = 'canpineapple',
        prop = 's_canpineapple01x',
        duration = 2750,
        attach = { bone = 'SKEL_L_Finger00', x = 0.10, y = -0.03, z = 0.02, rx = 20.0, ry = -70.0, rz = -20.0 },
        attachFemale = { bone = 'SKEL_L_Finger00', x = 0.08, y = -0.025, z = 0.018, rx = 18.0, ry = -68.0, rz = -18.0 },
        native = { type = 'interaction', hash = 'EAT_CANNED_FOOD_CYLINDER@D8-2_H10-5_QUICK_LEFT', duration = 2750, throw = true },
        anim   = { dict = 'mech_inventory@eating@canned_food@cylinder@d8-2_h10-5', clip = 'left_hand', flag = 31 },
        effects = { hunger = 16, thirst = 14, stress = 3 },
    },

    cornedbeef = {
        item = 'cornedbeef',
        prop = 's_cornedbeef01x',
        duration = 2750,
        attach = { bone = 'SKEL_L_Finger00', x = 0.10, y = -0.03, z = 0.02, rx = 20.0, ry = -70.0, rz = -20.0 },
        attachFemale = { bone = 'SKEL_L_Finger00', x = 0.08, y = -0.025, z = 0.018, rx = 18.0, ry = -68.0, rz = -18.0 },
        native = { type = 'interaction', hash = 'EAT_CANNED_FOOD_CYLINDER@D8-2_H10-5_QUICK_LEFT', duration = 2750, throw = true },
        anim   = { dict = 'mech_inventory@eating@canned_food@cylinder@d8-2_h10-5', clip = 'left_hand', flag = 31 },
        effects = { hunger = 35, thirst = 0, stress = 5 },
    },

    canpeas = {
        item = 'canpeas',
        prop = 's_canpeas01x',
        duration = 2750,
        attach = { bone = 'SKEL_L_Finger00', x = 0.10, y = -0.03, z = 0.02, rx = 20.0, ry = -70.0, rz = -20.0 },
        attachFemale = { bone = 'SKEL_L_Finger00', x = 0.08, y = -0.025, z = 0.018, rx = 18.0, ry = -68.0, rz = -18.0 },
        native = { type = 'interaction', hash = 'EAT_CANNED_FOOD_CYLINDER@D8-2_H10-5_QUICK_LEFT', duration = 2750, throw = true },
        anim   = { dict = 'mech_inventory@eating@canned_food@cylinder@d8-2_h10-5', clip = 'left_hand', flag = 31 },
        effects = { hunger = 14, thirst = 4, stress = 2 },
    },

    cancorn = {
        item = 'cancorn',
        prop = 's_cancorn01x',
        duration = 2750,
        attach = { bone = 'SKEL_L_Finger00', x = 0.10, y = -0.03, z = 0.02, rx = 20.0, ry = -70.0, rz = -20.0 },
        attachFemale = { bone = 'SKEL_L_Finger00', x = 0.08, y = -0.025, z = 0.018, rx = 18.0, ry = -68.0, rz = -18.0 },
        native = { type = 'interaction', hash = 'EAT_CANNED_FOOD_CYLINDER@D8-2_H10-5_QUICK_LEFT', duration = 2750, throw = true },
        anim   = { dict = 'mech_inventory@eating@canned_food@cylinder@d8-2_h10-5', clip = 'left_hand', flag = 31 },
        effects = { hunger = 16, thirst = 4, stress = 2 },
    },

    canpeaches = {
        item = 'canpeaches',
        prop = 's_canpeaches01x',
        duration = 2750,
        attach = { bone = 'SKEL_L_Finger00', x = 0.10, y = -0.03, z = 0.02, rx = 20.0, ry = -70.0, rz = -20.0 },
        attachFemale = { bone = 'SKEL_L_Finger00', x = 0.08, y = -0.025, z = 0.018, rx = 18.0, ry = -68.0, rz = -18.0 },
        native = { type = 'interaction', hash = 'EAT_CANNED_FOOD_CYLINDER@D8-2_H10-5_QUICK_LEFT', duration = 2750, throw = true },
        anim   = { dict = 'mech_inventory@eating@canned_food@cylinder@d8-2_h10-5', clip = 'left_hand', flag = 31 },
        effects = { hunger = 15, thirst = 10, stress = 3 },
    },

    canbeans = {
        item = 'canbeans',
        prop = 's_canbeans01x',
        duration = 2750,
        attach = { bone = 'SKEL_L_Finger00', x = 0.10, y = -0.03, z = 0.02, rx = 20.0, ry = -70.0, rz = -20.0 },
        attachFemale = { bone = 'SKEL_L_Finger00', x = 0.08, y = -0.025, z = 0.018, rx = 18.0, ry = -68.0, rz = -18.0 },
        native = { type = 'interaction', hash = 'EAT_CANNED_FOOD_CYLINDER@D8-2_H10-5_QUICK_LEFT', duration = 2750, throw = true },
        anim   = { dict = 'mech_inventory@eating@canned_food@cylinder@d8-2_h10-5', clip = 'left_hand', flag = 31 },
        effects = { hunger = 22, thirst = 0, stress = 3 },
    },

    chocolatebar = {
        item = 'chocolatebar',
        prop = 's_chocolatebar02x',
        duration = 3000,
        attach = { bone = 'SKEL_L_Finger01', x = 0.04, y = -0.03, z = -0.01, rx = 0.0, ry = 19.0, rz = 46.0 },
        attachFemale = { bone = 'SKEL_L_Finger01', x = 0.03, y = -0.025, z = -0.008, rx = 0.0, ry = 16.0, rz = 40.0 },
        native = { type = 'interaction', hash = 'EAT_MULTI_BITE_FOOD_SPHERE_D8-2_SANDWICH_QUICK_LEFT_HAND', duration = 3000 },
        anim   = { dict = 'mech_inventory@eating@multi_bite@sphere_d8-2_sandwich', clip = 'quick_left_hand', flag = 31 },
        effects = { hunger = 12, thirst = 0, stress = 8 },
    },

    cheesewedge = {
        item = 'cheesewedge',
        prop = 's_cheesewedge1x',
        duration = 3000,
        attach = { bone = 'SKEL_L_Finger01', x = 0.04, y = -0.03, z = -0.01, rx = 0.0, ry = 19.0, rz = 46.0 },
        attachFemale = { bone = 'SKEL_L_Finger01', x = 0.03, y = -0.025, z = -0.008, rx = 0.0, ry = 16.0, rz = 40.0 },
        native = { type = 'interaction', hash = 'EAT_MULTI_BITE_FOOD_WEDGE_A4-2_B0-75_W8_H9-4_CHEESE_QUICK_BITES_LEFT_HAND', duration = 3000 },
        anim   = { dict = 'mech_inventory@eating@multi_bite@sphere_d8-2_sandwich', clip = 'quick_left_hand', flag = 31 },
        effects = { hunger = 22, thirst = 0, stress = 4 },
    },

    salted_beef = {
        item = 'salted_beef',
        prop = 'p_meatchunk_sm01x',
        duration = 3000,
        attach = { bone = 'SKEL_L_Finger01', x = 0.04, y = -0.03, z = -0.01, rx = 0.0, ry = 19.0, rz = 46.0 },
        attachFemale = { bone = 'SKEL_L_Finger01', x = 0.03, y = -0.025, z = -0.008, rx = 0.0, ry = 16.0, rz = 40.0 },
        native = { type = 'interaction', hash = 'EAT_MULTI_BITE_FOOD_PINCH_ROD_D2-5_H19_CARROT_QUICK_BITES_LEFT_HAND', duration = 3000 },
        anim   = { dict = 'mech_inventory@eating@multi_bite@sphere_d8-2_sandwich', clip = 'quick_left_hand', flag = 31 },
        effects = { hunger = 30, thirst = -4, stress = 3 },
    },

    salted_venison = {
        item = 'salted_venison',
        prop = 'p_meatchunk_sm01x',
        duration = 3000,
        attach = { bone = 'SKEL_L_Finger01', x = 0.04, y = -0.03, z = -0.01, rx = 0.0, ry = 19.0, rz = 46.0 },
        attachFemale = { bone = 'SKEL_L_Finger01', x = 0.03, y = -0.025, z = -0.008, rx = 0.0, ry = 16.0, rz = 40.0 },
        native = { type = 'interaction', hash = 'EAT_MULTI_BITE_FOOD_PINCH_ROD_D2-5_H19_CARROT_QUICK_BITES_LEFT_HAND', duration = 3000 },
        anim   = { dict = 'mech_inventory@eating@multi_bite@sphere_d8-2_sandwich', clip = 'quick_left_hand', flag = 31 },
        effects = { hunger = 32, thirst = -4, stress = 3 },
    },

    oatcakes = {
        item = 'oatcakes',
        prop = 'p_biscuitsandwich01x',
        duration = 3000,
        attach = { bone = 'SKEL_L_Finger01', x = 0.04, y = -0.03, z = -0.01, rx = 0.0, ry = 19.0, rz = 46.0 },
        attachFemale = { bone = 'SKEL_L_Finger01', x = 0.03, y = -0.025, z = -0.008, rx = 0.0, ry = 16.0, rz = 40.0 },
        native = { type = 'interaction', hash = 'EAT_MULTI_BITE_FOOD_SPHERE_D8-2_SANDWICH_QUICK_LEFT_HAND', duration = 3000 },
        anim   = { dict = 'mech_inventory@eating@multi_bite@sphere_d8-2_sandwich', clip = 'quick_left_hand', flag = 31 },
        effects = { hunger = 24, thirst = 0, stress = 4 },
    },

    brandy = {
        item = 'brandy',
        prop = 's_brandy01x',
        duration = 4000,
        attach = { bone = 'PH_R_HAND', x = 0.0, y = 0.0, z = 0.04, rx = 0.0, ry = 0.0, rz = 0.0 },
        attachFemale = { bone = 'PH_R_HAND', x = 0.0, y = 0.0, z = 0.035, rx = 0.0, ry = 0.0, rz = 0.0 },
        native = { type = 'interaction', hash = 'DRINK_Bottle_Oval_L5-5W9-5H10_Neck_A6_B2-5_QUICK_RIGHT_HAND', duration = 4000, throw = true },
        anim = {
            sequence = {
                { dict = 'mech_inventory@drinking@bottle_cylinder_d1-3_h30-5_neck_a13_b2-5', clip = 'uncork', flag = 31, duration = 500, delay = 500 },
                { dict = 'mech_inventory@drinking@bottle_cylinder_d1-3_h30-5_neck_a13_b2-5', clip = 'chug_a', flag = 31, duration = -1 },
            },
        },
        effects = { hunger = 0, thirst = 6, stress = 8, alcohol = 30 },
    },

    rum = {
        item = 'rum',
        prop = 's_inv_rum01x',
        duration = 4000,
        attach = { bone = 'PH_R_HAND', x = 0.0, y = 0.0, z = 0.04, rx = 0.0, ry = 0.0, rz = 0.0 },
        attachFemale = { bone = 'PH_R_HAND', x = 0.0, y = 0.0, z = 0.035, rx = 0.0, ry = 0.0, rz = 0.0 },
        native = { type = 'interaction', hash = 'DRINK_Bottle_Oval_L6-5W12H9-5_Neck_A12-5_B4_QUICK_RIGHT_HAND', duration = 4000, throw = true },
        anim = {
            sequence = {
                { dict = 'mech_inventory@drinking@bottle_cylinder_d1-3_h30-5_neck_a13_b2-5', clip = 'uncork', flag = 31, duration = 500, delay = 500 },
                { dict = 'mech_inventory@drinking@bottle_cylinder_d1-3_h30-5_neck_a13_b2-5', clip = 'chug_a', flag = 31, duration = -1 },
            },
        },
        effects = { hunger = 0, thirst = 6, stress = 8, alcohol = 25 },
    },

    -- Cigarette — native QUICK_SMOKE handles spawn, lighting, mouth prop entirely.
    -- No manual prop needed; the game engine manages the cigarette + lighter.
    cigarette = {
        item = 'cigarette',
        duration = 5500,
        native = {
            type     = 'interaction',
            hash     = 'QUICK_SMOKE_CIGARETTE_LEFT_HAND',
            duration = 5500,
        },
        anim = { dict = 'mech_pickup@system@lh@use', clip = '2h_tabacco', flag = 31 },
        effects = { hunger = 0, thirst = -3, stress = 12 },
    },

    -- Cigar — native also auto-spawns a matchstick in the left hand for lighting.
    cigar = {
        item = 'cigar',
        duration = 7500,
        native = {
            type      = 'interaction',
            hash      = 'QUICK_SMOKE_CIGAR_LEFT_HAND',
            itemHash  = 'p_cigar02x',
            duration  = 7500,
        },
        anim = { dict = 'mech_pickup@system@lh@use', clip = '2h_tabacco', flag = 31 },
        effects = { hunger = 0, thirst = -3, stress = 15 },
    },

    whiskey = {
        item = 'whiskey',
        prop = 's_inv_whiskey01x',
        duration = 4000,
        attach = { bone = 'PH_R_HAND', x = 0.0, y = 0.0, z = 0.04, rx = 0.0, ry = 0.0, rz = 0.0 },
        attachFemale = { bone = 'PH_R_HAND', x = 0.0, y = 0.0, z = 0.035, rx = 0.0, ry = 0.0, rz = 0.0 },
        native = { type = 'interaction', hash = 'DRINK_Bottle_Oval_L5-5W9-5H10_Neck_A6_B2-5_QUICK_RIGHT_HAND', duration = 4000, throw = true },
        anim = {
            sequence = {
                { dict = 'mech_inventory@drinking@bottle_cylinder_d1-3_h30-5_neck_a13_b2-5', clip = 'uncork', flag = 31, duration = 500, delay = 500 },
                { dict = 'mech_inventory@drinking@bottle_cylinder_d1-3_h30-5_neck_a13_b2-5', clip = 'chug_a', flag = 31, duration = -1 },
            },
        },
        effects = { hunger = 0, thirst = 5, stress = 10, alcohol = 35 },
    },

    gin = {
        item = 'gin',
        prop = 's_inv_gin01x',
        duration = 4000,
        attach = { bone = 'PH_R_HAND', x = 0.0, y = 0.0, z = 0.04, rx = 0.0, ry = 0.0, rz = 0.0 },
        attachFemale = { bone = 'PH_R_HAND', x = 0.0, y = 0.0, z = 0.035, rx = 0.0, ry = 0.0, rz = 0.0 },
        native = { type = 'interaction', hash = 'DRINK_Bottle_Oval_L6-5W12H9-5_Neck_A12-5_B4_QUICK_RIGHT_HAND', duration = 4000, throw = true },
        anim = {
            sequence = {
                { dict = 'mech_inventory@drinking@bottle_cylinder_d1-3_h30-5_neck_a13_b2-5', clip = 'uncork', flag = 31, duration = 500, delay = 500 },
                { dict = 'mech_inventory@drinking@bottle_cylinder_d1-3_h30-5_neck_a13_b2-5', clip = 'chug_a', flag = 31, duration = -1 },
            },
        },
        effects = { hunger = 0, thirst = 5, stress = 9, alcohol = 28 },
    },

    -- Chewing tobacco — open tin prop + two-handed chew animation
    tobacco = {
        item = 'tobacco',
        prop = 's_tabaccoused01x',
        duration = 3600,
        attach = { bone = 'SKEL_L_Finger01', x = 0.03, y = -0.02, z = 0.0, rx = 0.0, ry = 12.0, rz = 24.0 },
        attachFemale = { bone = 'SKEL_L_Finger01', x = 0.025, y = -0.018, z = 0.0, rx = 0.0, ry = 10.0, rz = 20.0 },
        anim = { dict = 'mech_pickup@system@lh@use', clip = '2h_tabacco', flag = 31 },
        effects = { hunger = 0, thirst = -2, stress = 10 },
    },
}
