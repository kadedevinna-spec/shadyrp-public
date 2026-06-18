defaultRepairAttachedProp = {
    bone = "PH_L_Hand",
    position = vector3(-0.3750, -0.8500, 0.6500),
    rotation = vector3(-4.50, 81.00, 63.00),
}

defaultGrindstoneSharpenAttachedProp = {
    bone = "PH_R_Hand",
    position = vector3(0.1, 0.0, -0.3),
    rotation = vector3(3.0, 0.0, 263.0),
}

Config.MiningAnimations = {
    ["pickaxe"] = {
        [1] = {
            dict = "amb_work@world_human_pickaxe@wall@male_d@idle_a",
            name = "idle_c",
        },
        [2] = {
            dict = "amb_work@world_human_pickaxe@wall@male_d@idle_a",
            name = "idle_b",
        },
        [3] = {
            dict = "amb_work@world_human_pickaxe@wall@male_d@idle_b",
            name = "idle_d",
        },
        [4] = {
            dict = "amb_work@world_human_pickaxe@wall@male_d@idle_a",
            name = "idle_a",
        },
        ["low"] = {
            dict = "amb_work@world_human_sledgehammer@male@idle_a",
            name = "idle_a",
        }
    },
    ["shovel"] = {
        [1] = {
            dict = "amb_work@world_human_gravedig@working@male_b@idle_b",
            name = "idle_d",
        },
    },
}

Config.CarryAnimations = { -- if you wanna have a specific carry in hand animation per listed Type in Config.PickaxeData
    ["shovel"] = {
        dict = "mech_loco_m@generic@carry@pitchfork@two_hands@idle",
        name = "idle",
    },
}
Config.PickaxeData = {
    [1] = {
        Item = "pickaxe",                           -- Item name for the pickaxe
        model = "p_pickaxe01x",                     -- Prop name for the pickaxe
        name = "Pickaxe",                           -- Label for the pickaxe, used in the equip prompt
        SharpnessDeduct = { 0.5, 1.0 },             -- How much sharpness to deduct from the pickaxe per hit
        PermanentDurabilityDeduct = { 0.02, 0.04 }, -- Slow permanent durability burn per hit
        SharpnessPenaltyThreshold = 40,             -- No mining rate penalty above this sharpness percent
        SharpnessPenaltyMaxMultiplier = 2.0,        -- Mining duration multiplier at near 0 sharpness (not exactly 0, because of the SharpnessPenaltyMultiplierAtZero value below)
        SharpnessPenaltyMultiplierAtZero = 10.0,    -- Hard override multiplier when sharpness is exactly 0
        CantMineAtZeroSharpness = true,             -- If true, players cannot mine at 0 sharpness with this pickaxe, and it ignores the SharpnessPenaltyMultiplierAtZero value, instead it just doesn't allow mining at 0 sharpness at all
        AnvilRepair = {
            DurationMs = 20000,                     -- Repair animation duration in ms
            RequiredItemsByDurability = {
                -- Key is number of completed repairs. Tier [1] is first repair, [5] is fifth repair.
                [1] = { DurabilityIncrease = 80.0, RequiredItems = { { item = "iron_nugget", label = "Iron Nugget", amount = 1 }, { item = "borax", label = "Borax", amount = 1 } } }, -- Can be multiple item tables inside RequiredItems so it uses multiple items
                [2] = { DurabilityIncrease = 70.0, RequiredItems = { { item = "iron_nugget", label = "Iron Nugget", amount = 2 }, { item = "borax", label = "Borax", amount = 2 } } },
                [3] = { DurabilityIncrease = 60.0, RequiredItems = { { item = "iron_nugget", label = "Iron Nugget", amount = 3 }, { item = "borax", label = "Borax", amount = 3 } } },
                [4] = { DurabilityIncrease = 50.0, RequiredItems = { { item = "iron_nugget", label = "Iron Nugget", amount = 4 }, { item = "borax", label = "Borax", amount = 4 } } },
                [5] = { DurabilityIncrease = 40.0, RequiredItems = { { item = "iron_nugget", label = "Iron Nugget", amount = 5 }, { item = "borax", label = "Borax", amount = 5 } } },
            },
        },
        ItemIncrease = 0,               -- No additional items for this pickaxe
        EquipPrompt = "~t0~Pickaxe~q~", -- Change colors by changing after ~'
        propPosition = {
            hand = {
                bone = "PH_R_Hand", -- Bone name for the hand to attach the shovel to
                position = vector3(0.0, 0.0, 0.07),
                rotation = vector3(0.0, 0.0, 0.0)
            },
            back = {
                bone = "SM_rifle",
                position = vector3(0.4, -0.0, -0.5),
                rotation = vector3(-35.0, 0.0, 90.0)
            },
            wetstoneSharpen = {
                bone = "PH_R_Hand",
                position = vector3(0.1, 0.0, -0.25),
                rotation = vector3(0.0, 0.0, 270.0)
            },
            grindstoneSharpen = defaultGrindstoneSharpenAttachedProp,
            anvilRepair = defaultRepairAttachedProp
        }, -- Position and rotation of the prop
        Type = "pickaxe"
    },
    [2] = {
        Item = "pickaxe_steel",                      -- Item name for the steel pickaxe
        model = "pickaxe_steel",                     -- Prop name for the pickaxe
        name = "Steel Pickaxe",                      -- Label for the steel pickaxe, used in the equip prompt
        SharpnessDeduct = { 0.35, 0.7 },             -- How much sharpness to deduct from the steel pickaxe per hit
        PermanentDurabilityDeduct = { 0.015, 0.03 }, -- Slow permanent durability burn per hit
        SharpnessPenaltyThreshold = 35,              -- No mining rate penalty above this sharpness percent
        SharpnessPenaltyMaxMultiplier = 1.85,        -- Mining duration multiplier at 0 sharpness
        SharpnessPenaltyMultiplierAtZero = 10.0,     -- Hard override multiplier when sharpness is exactly 0
        CantMineAtZeroSharpness = true,              -- If true, players cannot mine at 0 sharpness with this pickaxe, and it ignores the SharpnessPenaltyMultiplierAtZero value, instead it just doesn't allow mining at 0 sharpness at all
        AnvilRepair = {
            DurationMs = 25000,
            RequiredItemsByDurability = {
                [1] = { DurabilityIncrease = 80.0, RequiredItems = { { item = "steel_nugget", label = "Steel Nugget", amount = 1 }, { item = "borax", label = "Borax", amount = 1 } } },
                [2] = { DurabilityIncrease = 70.0, RequiredItems = { { item = "steel_nugget", label = "Steel Nugget", amount = 2 }, { item = "borax", label = "Borax", amount = 2 } } },
                [3] = { DurabilityIncrease = 60.0, RequiredItems = { { item = "steel_nugget", label = "Steel Nugget", amount = 3 }, { item = "borax", label = "Borax", amount = 3 } } },
                [4] = { DurabilityIncrease = 50.0, RequiredItems = { { item = "steel_nugget", label = "Steel Nugget", amount = 4 }, { item = "borax", label = "Borax", amount = 4 } } },
                [5] = { DurabilityIncrease = 40.0, RequiredItems = { { item = "steel_nugget", label = "Steel Nugget", amount = 5 }, { item = "borax", label = "Borax", amount = 5 } } },
            },
        },
        ItemIncrease = { 0, 1 },                                                       -- Increase the amount of items to give by either 0 or 1
        EquipPrompt = "~COLOR_SOCIAL_CLUB_FEED_GREY_DARK_TO_LIGHT_3~Steel Pickaxe~q~", -- Change colors by changing after ~'
        propPosition = {
            hand = {
                bone = "PH_R_Hand", -- Bone name for the hand to attach the shovel to
                position = vector3(0.0, 0.0, 0.07),
                rotation = vector3(0.0, 0.0, 0.0)
            },
            back = {
                bone = "SM_rifle",
                position = vector3(0.4, -0.0, -0.5),
                rotation = vector3(-35.0, 0.0, 90.0)
            },
            wetstoneSharpen = {
                bone = "PH_R_Hand",
                position = vector3(0.1, 0.0, -0.25),
                rotation = vector3(0.0, 0.0, 270.0)
            },
            grindstoneSharpen = defaultGrindstoneSharpenAttachedProp,
            anvilRepair = defaultRepairAttachedProp
        }, -- Position and rotation of the prop
        Type = "pickaxe"
    },
    [3] = {
        Item = "pickaxe_silver",                     -- Item name for the diamond pickaxe
        model = "pickaxe_silver",                    -- Prop name for the pickaxe
        name = "Silver Titanium Pickaxe",            -- Label for the diamond pickaxe, used in the equip prompt
        SharpnessDeduct = { 0.25, 0.55 },            -- How much sharpness to deduct from the silver pickaxe per hit
        PermanentDurabilityDeduct = { 0.01, 0.025 }, -- Slow permanent durability burn per hit
        SharpnessPenaltyThreshold = 30,              -- No mining rate penalty above this sharpness percent
        SharpnessPenaltyMaxMultiplier = 1.7,         -- Mining duration multiplier at 0 sharpness
        SharpnessPenaltyMultiplierAtZero = 10.0,     -- Hard override multiplier when sharpness is exactly 0
        CantMineAtZeroSharpness = true,              -- If true, players cannot mine at 0 sharpness with this pickaxe, and it ignores the SharpnessPenaltyMultiplierAtZero value, instead it just doesn't allow mining at 0 sharpness at all
        AnvilRepair = {
            DurationMs = 25000,
            RequiredItemsByDurability = {
                [1] = { DurabilityIncrease = 80.0, RequiredItems = { { item = "titanium_nugget", label = "Titanium Nugget", amount = 1 }, { item = "borax", label = "Borax", amount = 1 } } },
                [2] = { DurabilityIncrease = 70.0, RequiredItems = { { item = "titanium_nugget", label = "Titanium Nugget", amount = 2 }, { item = "borax", label = "Borax", amount = 2 } } },
                [3] = { DurabilityIncrease = 60.0, RequiredItems = { { item = "titanium_nugget", label = "Titanium Nugget", amount = 3 }, { item = "borax", label = "Borax", amount = 3 } } },
                [4] = { DurabilityIncrease = 50.0, RequiredItems = { { item = "titanium_nugget", label = "Titanium Nugget", amount = 4 }, { item = "borax", label = "Borax", amount = 4 } } },
                [5] = { DurabilityIncrease = 40.0, RequiredItems = { { item = "titanium_nugget", label = "Titanium Nugget", amount = 5 }, { item = "borax", label = "Borax", amount = 5 } } },
            },
        },
        ItemIncrease = { 0, 2 },                                        -- Increase the amount of items to give by random number from 0 to 2
        EquipPrompt = "~COLOR_BLUELIGHT~Silver Titanium Pickaxe~q~~n~", -- Change colors by changing after ~'
        propPosition = {
            hand = {
                bone = "PH_R_Hand", -- Bone name for the hand to attach the shovel to
                position = vector3(0.0, 0.0, 0.07),
                rotation = vector3(0.0, 0.0, 0.0)
            },
            back = {
                bone = "SM_rifle",
                position = vector3(0.4, -0.0, -0.5),
                rotation = vector3(-35.0, 0.0, 90.0)
            },
            wetstoneSharpen = {
                bone = "PH_R_Hand",
                position = vector3(0.1, 0.0, -0.25),
                rotation = vector3(0.0, 0.0, 270.0)
            },
            grindstoneSharpen = defaultGrindstoneSharpenAttachedProp,
            anvilRepair = defaultRepairAttachedProp
        }, -- Position and rotation of the prop
        Type = "pickaxe"
    },
    [4] = {
        Item = "pickaxe_gold",                        -- Item name for the gold pickaxe
        model = "pickaxe_gold",                       -- Prop name for the pickaxe
        name = "Golden Titanium Pickaxe",             -- Label for the gold pickaxe, used in the equip prompt
        SharpnessDeduct = { 0.1, 0.5 },               -- How much sharpness to deduct from the gold pickaxe per hit
        PermanentDurabilityDeduct = { 0.006, 0.015 }, -- Slow permanent durability burn per hit
        SharpnessPenaltyThreshold = 25,               -- No mining rate penalty above this sharpness percent
        SharpnessPenaltyMaxMultiplier = 1.5,          -- Mining duration multiplier at 0 sharpness
        SharpnessPenaltyMultiplierAtZero = 10.0,      -- Hard override multiplier when sharpness is exactly 0
        CantMineAtZeroSharpness = true,               -- If true, players cannot mine at 0 sharpness with this pickaxe, and it ignores the SharpnessPenaltyMultiplierAtZero value, instead it just doesn't allow mining at 0 sharpness at all
        AnvilRepair = {
            DurationMs = 30000,
            RequiredItemsByDurability = {
                [1] = { DurabilityIncrease = 80.0, RequiredItems = { { item = "titanium_nugget", label = "Titanium Nugget", amount = 1 }, { item = "borax", label = "Borax", amount = 1 } } },
                [2] = { DurabilityIncrease = 70.0, RequiredItems = { { item = "titanium_nugget", label = "Titanium Nugget", amount = 2 }, { item = "borax", label = "Borax", amount = 2 } } },
                [3] = { DurabilityIncrease = 60.0, RequiredItems = { { item = "titanium_nugget", label = "Titanium Nugget", amount = 3 }, { item = "borax", label = "Borax", amount = 3 } } },
                [4] = { DurabilityIncrease = 50.0, RequiredItems = { { item = "titanium_nugget", label = "Titanium Nugget", amount = 4 }, { item = "borax", label = "Borax", amount = 4 } } },
                [5] = { DurabilityIncrease = 40.0, RequiredItems = { { item = "titanium_nugget", label = "Titanium Nugget", amount = 5 }, { item = "borax", label = "Borax", amount = 5 } } },
            },
        },
        ItemIncrease = { 1, 2 },                        -- Increase the amount of items to give by random number from 1 to 2
        EquipPrompt = "~t4~Golden Titanium Pickaxe~q~", -- Change colors by changing after ~'
        propPosition = {
            hand = {
                bone = "PH_R_Hand", -- Bone name for the hand to attach the shovel to
                position = vector3(0.0, 0.0, 0.07),
                rotation = vector3(0.0, 0.0, 0.0)
            },
            back = {
                bone = "SM_rifle",
                position = vector3(0.4, -0.0, -0.5),
                rotation = vector3(-35.0, 0.0, 90.0)
            },
            wetstoneSharpen = {
                bone = "PH_R_Hand",
                position = vector3(0.1, 0.0, -0.25),
                rotation = vector3(0.0, 0.0, 270.0)
            },
            grindstoneSharpen = defaultGrindstoneSharpenAttachedProp,
            anvilRepair = defaultRepairAttachedProp
        }, -- Position and rotation of the prop
        Type = "pickaxe"
    },
    [5] = {
        Item = "shovel",                            -- Item name for the shovel
        model = "p_shovel02x",                      -- Prop name for the shovel
        name = "Shovel",                            -- Label for the shovel, used in the equip prompt
        WetStoneSharpnessIncrease = 25,             -- Sharpness restored by sharpening stone for this tool
        SharpeningTimeMs = 20 * 1000,               -- Wetstone sharpening duration for this tool
        GrindstoneTimeMs = 15 * 1000,               -- Grindstone sharpening duration for this tool
        SharpnessDeduct = { 0.5, 1.0 },             -- How much sharpness to deduct from the shovel per hit
        PermanentDurabilityDeduct = { 0.02, 0.04 }, -- Slow permanent durability burn per hit
        SharpnessPenaltyThreshold = 40,             -- No mining rate penalty above this sharpness percent
        SharpnessPenaltyMaxMultiplier = 2.0,        -- Mining duration multiplier at near 0 sharpness (not exactly 0, because of the SharpnessPenaltyMultiplierAtZero value below)
        SharpnessPenaltyMultiplierAtZero = 10.0,    -- Hard override multiplier when sharpness is exactly 0
        CantMineAtZeroSharpness = true,             -- If true, players cannot mine at 0 sharpness with this shovel, and it ignores the SharpnessPenaltyMultiplierAtZero value, instead it just doesn't allow mining at 0 sharpness at all
        AnvilRepair = {
            DurationMs = 20000,                     -- Repair animation duration in ms
            RequiredItemsByDurability = {
                -- Key is number of completed repairs. Tier [1] is first repair, [5] is fifth repair.
                [1] = { DurabilityIncrease = 80.0, RequiredItems = { { item = "iron_nugget", label = "Iron Nugget", amount = 1 }, { item = "borax", label = "Borax", amount = 1 } } }, -- Can be multiple item tables inside RequiredItems so it uses multiple items
                [2] = { DurabilityIncrease = 70.0, RequiredItems = { { item = "iron_nugget", label = "Iron Nugget", amount = 2 }, { item = "borax", label = "Borax", amount = 2 } } },
                [3] = { DurabilityIncrease = 60.0, RequiredItems = { { item = "iron_nugget", label = "Iron Nugget", amount = 3 }, { item = "borax", label = "Borax", amount = 3 } } },
                [4] = { DurabilityIncrease = 50.0, RequiredItems = { { item = "iron_nugget", label = "Iron Nugget", amount = 4 }, { item = "borax", label = "Borax", amount = 4 } } },
                [5] = { DurabilityIncrease = 40.0, RequiredItems = { { item = "iron_nugget", label = "Iron Nugget", amount = 5 }, { item = "borax", label = "Borax", amount = 5 } } },
            },
        },
        ItemIncrease = 0,              -- No additional items for this pickaxe
        EquipPrompt = "~t0~Shovel~q~", -- Change colors by changing after ~'
        propPosition = {
            hand = {
                bone = "PH_R_Hand", -- Bone name for the hand to attach the shovel to
                position = vector3(0.0, 0.025, 0.0),
                rotation = vector3(0.0, 0.0, 0.0)
            },
            back = {
                bone = "SM_rifle",
                position = vector3(0.5, 0.0, -0.6),
                rotation = vector3(0.0, 40.0, 180.0)
            },
            wetstoneSharpen = {
                bone = "PH_R_Hand",
                position = vector3(0.0, 0.05, -0.6),
                rotation = vector3(0.0, 0.0, -5.0)
            },
            grindstoneSharpen = defaultGrindstoneSharpenAttachedProp,
            anvilRepair = {
                bone = "PH_L_Hand",
                position = vector3(-0.05, -1.05, 0.8),
                rotation = vector3(90.0, 0.0, 180.0),
            }
        }, -- Position and rotation of the prop
        Type = "shovel"
    },
}

Config.PickaxeSharpnessLabel = "Sharpness"
Config.PickaxeDurabilityLabel = "Durability"
Config.PickaxeTimesRepairedLabel = "Times Repaired"
Config.DisplayDurabilityAsTextRounded = true           -- If true, the sharpness text will be rounded to the nearest whole number, if false it will show decimals

Config.DefaultPickaxePermanentDurabilityDeduct = 0.015 -- fallback value for permanent durability burn if a pickaxe doesn't have its own defined in Config.PickaxeData

Config.MinerHatItem = "minerhat"

Config.WetStoneItem = "sharpeningstone"     -- Item name for the wetstone
Config.PickaxeWetStoneSharpnessIncrease = { -- How much sharpness to increase for each pickaxe when using a wetstone
    [1] = 25,
    [2] = 20,
    [3] = 15,
    [4] = 10,
    [5] = 15
}
Config.PickaxeWetStoneDurabilityIncrease = Config.PickaxeWetStoneSharpnessIncrease -- Legacy alias
Config.WetStoneDurabilityDecrease = 25                                             -- How much durability to decrease from the wetstone upon use
Config.SharpeningTime = {                                                          -- Sharpening time using sharpeningstone/wetstone for each pickaxe
    [1] = 20 * 1000,
    [2] = 10 * 1000,
    [3] = 40 * 1000,
    [4] = 60 * 1000,
    [5] = 20 * 1000
}

Config.Grindstone = true
Config.GrindstoneProp = "p_grindingwheel01x" -- Prop name for the grindstone
Config.GrindstoneTime = {                    -- Grind stone time for each pickaxe
    [1] = 15 * 1000,
    [2] = 25 * 1000,
    [3] = 35 * 1000,
    [4] = 55 * 1000,
    [5] = 15 * 1000
}

Config.RockCrushing = true                         -- Set to false to disable rock crushing
Config.RockCrushingChance = 1                      -- Chance division to get an item when crushing rocks what so ever, meaning you 1 out of Config.RockCrushingChance chance to get an item when crushing a rock, set to 1 to get the same chance as mining
Config.RockCrusherJobOnly = false                  -- Set to true to only allow players with the miner job to use the rock crusher, set to false to allow all players to use the rock crusher
Config.MinimumRockRequirement = 1                  -- The amount of rocks required to use the rock crusher, set to 0 or 1 to disable the requirement

Config.CrushableItemsCommand = "givecrushableitem" -- /givecrushableitem [item] [minelocation] [amount]

Config.RockCrusher = {
    RequiredItems = false,
    -- RequiredItems = {                     -- Items required to use the rock crusher
    --     [1] = {
    --         Item = "wateringcan_empty",   -- Item name for the required item
    --         Label = "Empty Bucket", -- Label for the required item
    --         RemoveItemChance = 0,         -- No chance to remove the item from the player
    --     },
    --     -- You can add or remove items here
    -- },
    Locations = {
        [1] = {                                                      -- Rock Crusher 1
            Blip = -813538438,                                       -- Set to true to show a blip on the map
            Name = "Annesburg Rock Crusher",                         -- Name for the rock crusher
            DumpCoords = vector4(2880.06, 1401.47, 68.7, 239.79),    -- Coords for the smelting prompt to show up
            CollectCoords = vector4(2954.71, 1374.85, 56.25, 68.11), -- Coords for the collect prompt to show up
            Marker = 1,                                              -- Marker type for the rock crusher
            MarkerColor = { r = 250, g = 238, b = 144 },             -- Marker color for the rock crusher
            MarkerScale = { x = 1.0, y = 1.0, z = 1.0 },             -- Marker scale for the rock crusher
        },
        -- Add more locations
    },
    CrushableItems = {      -- Items that can be crushed in the rock crusher
        [1] = {             -- Item 1
            Item = "rock",  -- Item name for the crushable item
            Label = "Rock", -- Label for the crushable item
            Description = "Crush rock into materials.",
            description = "Crush rock into materials.",
        },
        [2] = {
            Item = "stone",
            Label = "Stone",
            Description = "Crush stone into materials.",
            description = "Crush stone into materials.",
        },
        [3] = {
            Item = "sandstone",
            Label = "Sandstone",
            Description = "Crush sandstone into materials.",
            description = "Crush sandstone into materials.",
        },
        [4] = {
            Item = "limestone",
            Label = "Limestone",
            Description = "Crush limestone into materials.",
            description = "Crush limestone into materials.",
        },
        [5] = {
            Item = "sand",
            Label = "Sand",
            Description = "Process sand through the crusher.",
            description = "Process sand through the crusher.",
        }
        -- You can add or remove items here
    },
}
