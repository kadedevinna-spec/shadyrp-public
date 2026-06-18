Config.MenuGridStyle = true   -- Set to true to display the smeltable items in a grid style, set to false to display them in a list style

Config.Smelting = true        -- Set to false to disable smelting
Config.SmelterJobOnly = false -- Set to true to only allow players with the jobs below to use the smelter functionality in general, keep in mind that even if false only forge owners & employees will have access to placed forges
Config.SmelterJobs = {
    "gunsmith",
    "blacksmith",
    "miner"
}
Config.SmelterInteractDistance = 1.5          -- Distance to interact with the smelter, set to 0.0 to disable the interaction distance
Config.SmelterMarkerDistance = 20.0           -- Distance to draw the marker, set to 0.0 to disable the marker
Config.DisplayUnlockedItems = "all"           -- Set to "all" to display all unlocked items, set to false to not display any, or set to a number to display X amount of items forward

Config.ForgeObjectDespawnDistance = 80.0      -- Distance to despawn the forge objects, set to 0.0 to disable the despawn
Config.ForgeObjectRespawnDistance = 60.0      -- Distance to respawn the forge objects
Config.PlacementRotationBasedOnPlayer = false -- Set to true to rotate the objects based on the player's heading when placing them, set to false to use the default rotation

Config.Smelter = {
    RequiredItems = {             -- Items required globally to use the smelter, set to false if no items are required, here we have set an example of a shovel
        [1] = {                   -- Item 1
            Item = "shovel",      -- Item name for the required item
            Label = "Shovel",     -- Label for the required item
            RemoveItemChance = 5, -- Chance to remove the item from the player (5%), used to resemble the durability of the item
        },
        -- [2] = {
        --     Item = "smeltinglicense", -- Item name for the required item
        --     Label = "Smelting License", -- Label for the required item
        --     RemoveItemChance = 0, -- No chance to remove the item from the player
        -- },
        -- You can add or remove items here
    },
    Locations = {
        [1] = {                                                  -- Stationary Public Smelter #1
            Name = "Hearland Oil Fields Smelter",                -- Name for the rock crusher
            Blip = -813538438,                                   -- Set to true to show a blip on the map
            Coords = vector3(499.65, 677.91, 117.46),            -- Coords for the rock crusher
            promptHeading = 265.33,
            Marker = 0x94FDAE17,                                 -- Marker type for the rock crusher
            MarkerColor = { r = 250, g = 238, b = 144, a = 50 }, -- Marker color
            MarkerScale = { x = 1.5, y = 1.5, z = 0.75 },        -- Marker scale
        },
        -- [2] = {
        --     Name = "Heartland Oil Fields Smelter 2",
        --     Blip = -813538438,
        --     Coords = vector3(496.64, 684.05, 117.43),
        --     promptHeading = 38.31,
        --     Marker = 0x94FDAE17,
        --     MarkerColor = { r = 250, g = 238, b = 144, a = 70 },
        --     MarkerScale = { x = 1.5, y = 1.5, z = 1.5 },
        -- },
        -- You can add more locations here
    },
    SmeltableItems = {
        [1] = {
            SmeltedItem = "ironbar",
            SmeltedItemLabel = "Iron Bar",
            SmeltedAmount = 1,
            RequiredItems = {
                { Item = "coal", Amount = 1, Label = "Coal" },
                { Item = "iron", Amount = 4, Label = "Iron Ore" },
            },
            RequiredTools = {
                { Item = "barmold", Amount = 1, Label = "Bar Mold", OneForEach = true, RemoveItemChance = 0.1 }, -- OneForEach means that the amount required is multiplied by the inputted number by the player when smelting
            },
            ShovelingTime = 2 * 1000,
            SmeltingTime = 120 * 5000,
            ItemDestroyed = false,
            ExpRequirement = 0, -- Experience requirement to smelt the item, set to 0 if no experience is required
            ExpGain = 1.0,      -- Experience gain for smelting the item, set to 0 if no experience is gained
        },
        [2] = {
            SmeltedItem = "copperbar",
            SmeltedItemLabel = "Copper Bar",
            SmeltedAmount = 5,
            RequiredItems = {
                { Item = "copper", Amount = 5, Label = "Copper Ore" },
                { Item = "coal",   Amount = 2, Label = "Coal" },
            },
            RequiredTools = {
                { Item = "barmold", Amount = 5, Label = "Bar Mold", OneForEach = true, RemoveItemChance = 0.2 },
            },
            ShovelingTime = 7 * 1000,
            SmeltingTime = 120 * 5000,
            ItemDestroyed = false,
            ExpRequirement = 100, -- Experience requirement to smelt the item, set to 0 if no experience is required
            ExpGain = 2.0,        -- Experience gain for smelting the item, set to 0 if no experience is gained
        },
        [3] = {
            SmeltedItem = "glass",
            SmeltedItemLabel = "Glass",
            SmeltedAmount = 4,
            RequiredItems = {
                { Item = "sand",      Amount = 4, Label = "Sand" },
                { Item = "limestone", Amount = 2, Label = "Limestone" },
                { Item = "coal",      Amount = 1, Label = "Coal" },
            },
            ShovelingTime = 6 * 1000,
            SmeltingTime = 20 * 1000,
            ItemDestroyed = 30 * 1000,
            ExpRequirement = 50,
            ExpGain = 1.0, -- Experience gain for smelting the item, set to 0 if no experience is gained
        },
        [4] = {
            SmeltedItem = "gasoline",
            SmeltedItemLabel = "Gasoline",
            SmeltedAmount = 1,
            RequiredItems = {
                { Item = "crudeoil", Amount = 2, Label = "Crude Oil" },
                { Item = "ethanol",  Amount = 1, Label = "Ethanol" },
                { Item = "coal",     Amount = 1, Label = "Coal" },
            },
            ShovelingTime = 8 * 1000,
            SmeltingTime = 10 * 1000,
            ItemDestroyed = 60 * 1000,
            ExpRequirement = 4000,
            ExpGain = 0.3, -- Experience gain for smelting the item, set to 0 if no experience is gained
        },

        -- Add more smeltable items here
    },
}


Config.PlaceForgeCommand = "bs_mosquito_placeforge"           -- Internal command used by the hotfix bridge; players should use /placeforge.
Config.OnlyAllowInvisibleForgePlacementThroughCommand = false -- RSG bridge uses /placeforge for normal visible forge placement.

Config.ForgeBlip = -758970771                                 -- Set to 1 to disable the forge blip, or set to a valid blip ID to enable it
Config.ForgeBlipVisibleForEveryone = false                    -- Set to true to make the forge blip visible for everyone, set to false to only show it to players who can use or have placed the forge
Config.ForgeChoreTimeoutDuration = 300000                     -- Timeout duration for chores in milliseconds (5 minutes), this is so that players can't spam the same easy chore
Config.ForgeWoodItem = "wood"
Config.ForgeWoodHowMuchPerItem = 4
Config.FuelCarryWoodAmount = 5              -- The amount of wood that is carried when transferring from pile to forge
Config.FuelPerFirewood = 10                 -- How much fuel to add per firewood, 5 means that 1 firewood (a quarter of a log wood item in this case), will make %5 fuel
Config.FuelConsumptionInterval = 120 * 1000 -- Fuel consumption interval in milliseconds, 60000 ms means that the forge will consume fuel every 60 seconds
Config.FuelConsumptionRate = 1              -- Default passive fuel burn per interval. Used only if a forge model does not define fuelConsumptionRate.
Config.ForgeFireWoodItem = "firewood"
Config.ForgeWoodHatchetItem = {
    [1] = { Item = "lumberaxe", Label = "Lumber Axe", RemoveItemChance = 0.01 },
    [2] = { Item = "lumberaxe_steel", Label = "Steel Lumber Axe", RemoveItemChance = 0.005 },
}
Config.DefaultForgeCondition = { -- Default condition for newly placed forges
    fuel = 0,
    firewood = 0,
    cleanliness = 50,
    structureIntegrity = 50
}
Config.ToolObjectPlacementMaxRotation = {
    ["p_forge01x"] = { x = 10.0, y = 10.0, z = 180.0 },
    ["brick_forge"] = { x = 10.0, y = 10.0, z = 180.0 },
    ["p_nailbox01x"] = { x = 10.0, y = 10.0, z = 180.0 },
}
Config.ForgeModels = {
    [1] = {
        item = "blacksmith_forge",                   -- item name
        name = "Forge",                              -- name of the forge
        model = "p_forge01x",                        -- model name for the forge object
        minimumDistance = 1.0,                       -- Minimum distance to place the forge, set to 0.0 to disable the distance check
        zOffset = -0.15,                             -- How deep the model is placed in the ground, adjust if needed
        invisZOffset = 0.0,                          -- Z offset for the invisible forge object, adjust if needed to prevent floating or sinking
        promptOffset = vector4(0.0, 1.75, 0.5, 0.0), -- Offset for the prompt position
        fireOffset = vec4(0.111718, -0.456112, 0.65, 175.624583),
        marker = {
            scale = { x = 1.5, y = 1.5, z = 0.75 },    -- Scale of the marker
            color = { r = 139, g = 0, b = 0, a = 30 }, -- Color of the marker
        },
        smeltingSpeed = 0.8,                           -- Speed of smelting, faster than the basic forge
        fuelConsumptionRate = 1,                       -- Passive fuel burn per Config.FuelConsumptionInterval for this forge model
        conditionDeducts = {                           -- Condition deducts are a value < 1, that will be multiplied by the amount condition that will be required and deducted from the forge
            ["fuel"] = 0.5,                            -- Deduct 0.5 firewood per second of smelting
            ["cleanliness"] = 0.05,                    -- Deduct 0.05 cleanliness per second of smelting
            ["structureIntegrity"] = 0.01              -- Deduct 0.01 structure integrity per second of smelting
        },
        SmeltableItems = {
            [1] = {
                SmeltedItem = "iron_nugget",
                SmeltedItemLabel = "Iron Nugget",
                SmeltedAmount = 5,
                RequiredItems = {
                    { Item = "ironbar", Amount = 1, Label = "Iron Bar" },
                },
                ShovelingTime = 2 * 1000,
                SmeltingTime = 30 * 1000,
                ItemDestroyed = 5 * 1000,
                ExpRequirement = 0,
                ExpGain = 0.5,
            },
            [2] = {
                SmeltedItem = "copper_nugget",
                SmeltedItemLabel = "Copper Nugget",
                SmeltedAmount = 5,
                RequiredItems = {
                    { Item = "copperbar", Amount = 1, Label = "Copper Bar" },
                },
                ShovelingTime = 2 * 1000,
                SmeltingTime = 5 * 1000,
                ItemDestroyed = false,
                ExpRequirement = 0,
                ExpGain = 0.5,
            },
            [3] = {
                SmeltedItem = "silver_nugget",
                SmeltedItemLabel = "Silver Nugget",
                SmeltedAmount = 5,
                RequiredItems = {
                    { Item = "silverbar", Amount = 1, Label = "Silver Bar" },
                },
                ShovelingTime = 2 * 1000,
                SmeltingTime = 5 * 1000,
                ItemDestroyed = false,
                ExpRequirement = 0,
                ExpGain = 0.5,
            },
            [4] = {
                SmeltedItem = "gold_nugget",
                SmeltedItemLabel = "Gold Nugget",
                SmeltedAmount = 5,
                RequiredItems = {
                    { Item = "goldbar", Amount = 1, Label = "Gold Bar" },
                },
                ShovelingTime = 2 * 1000,
                SmeltingTime = 5 * 1000,
                ItemDestroyed = false,
                ExpRequirement = 0,
                ExpGain = 0.5,
            },
            [5] = {
                SmeltedItem = "titanium_nugget",
                SmeltedItemLabel = "Titanium Nugget",
                SmeltedAmount = 5,
                RequiredItems = {
                    { Item = "titaniumbar", Amount = 1, Label = "Titanium Bar" },
                },
                ShovelingTime = 2 * 1000,
                SmeltingTime = 5 * 1000,
                ItemDestroyed = false,
                ExpRequirement = 0,
                ExpGain = 0.5,
            },
            [6] = {
                SmeltedItem = "bluegoldnugget",
                SmeltedItemLabel = "Blue Gold Nugget",
                SmeltedAmount = 5,
                RequiredItems = {
                    { Item = "bluegold", Amount = 1, Label = "Blue Gold Bar" },
                },
                ShovelingTime = 2 * 1000,
                SmeltingTime = 5 * 1000,
                ItemDestroyed = false,
                ExpRequirement = 0,
                ExpGain = 0.5,
            },
            [7] = {
                SmeltedItem = "rosegoldnugget",
                SmeltedItemLabel = "Rose Gold Nugget",
                SmeltedAmount = 5,
                RequiredItems = {
                    { Item = "rosegold", Amount = 1, Label = "Rose Gold Bar" },
                },
                ShovelingTime = 2 * 1000,
                SmeltingTime = 5 * 1000,
                ItemDestroyed = false,
                ExpRequirement = 0,
                ExpGain = 0.5,
            },
            [8] = {
                SmeltedItem = "greengoldnugget",
                SmeltedItemLabel = "Green Gold Nugget",
                SmeltedAmount = 5,
                RequiredItems = {
                    { Item = "greengold", Amount = 1, Label = "Green Gold Bar" },
                },
                ShovelingTime = 2 * 1000,
                SmeltingTime = 5 * 1000,
                ItemDestroyed = false,
                ExpRequirement = 0,
                ExpGain = 0.5,
            },
            [9] = {
                SmeltedItem = "nickel_nugget",
                SmeltedItemLabel = "Nickel Nugget",
                SmeltedAmount = 5,
                RequiredItems = {
                    { Item = "nickelbar", Amount = 1, Label = "Nickel Bar" },
                },
                ShovelingTime = 2 * 1000,
                SmeltingTime = 5 * 1000,
                ItemDestroyed = false,
                ExpRequirement = 0,
                ExpGain = 0.5,
            },
            [10] = {
                SmeltedItem = "lead_nugget",
                SmeltedItemLabel = "Lead Nugget",
                SmeltedAmount = 5,
                RequiredItems = {
                    { Item = "leadbar", Amount = 1, Label = "Lead Bar" },
                },
                ShovelingTime = 2 * 1000,
                SmeltingTime = 5 * 1000,
                ItemDestroyed = false,
                ExpRequirement = 0,
                ExpGain = 0.5,
            },
            [11] = {
                SmeltedItem = "steel_nugget",
                SmeltedItemLabel = "Steel Nugget",
                SmeltedAmount = 5,
                RequiredItems = {
                    { Item = "steelbar", Amount = 1, Label = "Steel Bar" },
                },
                ShovelingTime = 2 * 1000,
                SmeltingTime = 15 * 1000,
                ItemDestroyed = false,
                ExpRequirement = 0,
                ExpGain = 0.5,
            },
        },
        conditionChores = {
            -------------------------- CLEAN FORGE --------------------------------------

            ["clean_forge"] = {
                [1] = {
                    label = "Scrub Firebox",
                    cleanlinessIncrease = 30,
                    offSetLocation = vec4(-0.9, 0.245, 1.0, 250.0),
                    animation = {
                        type = "scenario",
                        name = "WORLD_HUMAN_CLEAN_TABLE",
                        duration = 5000,
                    },
                },
                [2] = {
                    label = "Brush off Back",
                    cleanlinessIncrease = 15,
                    offSetLocation = vec4(-0.01, -1.5, 0.96, 0.9),
                    animation = {
                        type = "scenario",
                        name = "WORLD_HUMAN_HORSE_TEND_BRUSH_LINK",
                        duration = 20000
                    },
                },
                [3] = {
                    label = "Clean Forge Counter",
                    cleanlinessIncrease = 20,
                    offSetLocation = vec4(-0.05, 1.3, 1.0, 180.0),
                    animation = {
                        type = "scenario",
                        name = "WORLD_HUMAN_CLEAN_TABLE",
                        duration = 5000,
                    },
                }
            },

            -------------------------- REPAIR STRUCTURE --------------------------------------

            ["repair_structure"] = {
                [1] = {
                    label = "Chisel Off Damaged Brick",
                    structureIntegrityIncrease = 30,
                    offSetLocation = vec4(1.03, -0.47, 0.96, 100.0),
                    animation = {
                        type = "scenario",
                        name = "RANSACK_BRICK_WALL",
                        duration = 25000,
                    },
                }
            },

            -------------------------- ADD FUEL --------------------------------------

            ["add_fuel"] = {
                ["get_firewood"] = {
                    label = "Get Firewood",
                    prop = {
                        model = "p_cs_woodpile01x",
                        bone = "PH_L_Hand",
                        position = vector3(0.0, 0.0, 0.0),
                        rotation = vector3(0.0, 0.0, 0.0),
                        anim = {
                            dict = "mech_pickup@firewood",
                            name = "pickup_prop",
                            looped = false,
                            freeze = true,
                        }
                    },
                    animation = {
                        dict = "mech_pickup@firewood",
                        name = "pickup",
                        flag = 2,
                        duration = 2500,
                    }
                },
                ["add_firewood"] = {
                    label = "Add Firewood",
                    offSetLocation = vec4(-0.9, 0.245, 1.0, 250.0),
                    prop = {
                        model = "p_cs_woodpile01x",
                        bone = "PH_L_Hand",
                        position = vector3(0.0, 0.0, 0.0),
                        rotation = vector3(0.0, 0.0, 0.0),
                        anim = {
                            dict = "mech_pickup@firewood",
                            name = "fire_prop",
                            looped = false,
                            freeze = true,
                        }
                    },
                    animation = {
                        dict = "mech_pickup@firewood",
                        name = "fire",
                        flag = 28,
                        duration = 7000,
                        blendin = 8.0,
                    }
                },
                ["carry_firewood"] = {
                    label = "Carry Firewood",
                    prop = {
                        model = "p_cs_woodpile01x",
                        bone = "PH_L_Hand",
                        position = vector3(0.0, 0.0, 0.0),
                        rotation = vector3(0.0, 0.0, 0.0),
                        anim = {
                            dict = "mech_pickup@firewood",
                            name = "idle_prop",
                            looped = true,
                            freeze = true,
                        }
                    },
                    animation = {
                        dict = "mech_pickup@firewood",
                        name = "idle",
                        flag = 25,
                        ikFlag = (1 << 16),
                        filter = false
                    }
                },
                ["light_fire"] = {
                    label = "Light Fire",
                    offSetLocation = vec4(-0.9, 0.245, 1.0, 250.0),
                    prop = {
                        model = "p_match01x",
                        bone = "PH_R_Hand",
                        position = vector3(0.0, 0.0, 0.0),
                        rotation = vector3(0.0, 0.0, 0.0),
                        anim = {
                            dict = "amb_work@world_human_fire_start@male_a@base",
                            name = "base_prop",
                            looped = false,
                            freeze = true,
                        }
                    },
                    animation = {
                        dict = "script_amb@camp@fire@fire_poke@male@a",
                        name = "action",
                        flag = 28,
                        duration = -1.0,
                    }
                }
            },

            -------------------------- ADD FIREWOOD --------------------------------------

            ["add_firewood"] = {
                ["chop_wood"] = {
                    label = "Chop Wood",
                    prop = {
                        model = "p_axe01x",
                        bone = "PH_R_Hand",
                        position = vector3(0.0, 0.0, 0.0),
                        rotation = vector3(0.0, 0.0, 0.0),
                        anim = {
                            dict = "amb_work@prop_human_wood_chop@chop_front@male_a@stand_exit",
                            name = "exit_back_prop",
                            looped = false,
                            freeze = true,
                        }
                    },
                    animation = {
                        dict = "amb_work@prop_human_wood_chop@chop_front@male_a@stand_exit",
                        name = "exit_back",
                        flag = 2,
                        duration = 6000,
                        blendin = 80.0
                    }
                },
                ["pickup_wood"] = {
                    label = "Pickup Wood",
                    prop = {
                        model = "p_cs_woodpile01x",
                        bone = "PH_L_Hand",
                        position = vector3(0.0, 0.0, 0.0),
                        rotation = vector3(0.0, 0.0, 0.0),
                        anim = {
                            dict = "mech_pickup@firewood",
                            name = "pickup_prop",
                            looped = false,
                            freeze = true,
                        }
                    },
                    animation = {
                        dict = "mech_pickup@firewood",
                        name = "pickup",
                        flag = 2,
                        duration = 2500,
                    }
                },
                ["putdown_wood"] = {
                    label = "Put Down Firewood",
                    offSetLocation = vec4(-0.799316, -1.549560, 1.208786, 5.513885),
                    prop = {
                        model = "p_cs_woodpile01x",
                        bone = "PH_L_Hand",
                        position = vector3(0.0, 0.0, 0.0),
                        rotation = vector3(0.0, 0.0, 0.0),
                        anim = {
                            dict = "mech_pickup@firewood",
                            name = "putdown_prop",
                            looped = false,
                            freeze = true,
                        }
                    },
                    animation = {
                        dict = "mech_pickup@firewood",
                        name = "putdown",
                        flag = 2,
                        duration = 3400,
                    }
                },
                ["carry_firewood"] = {
                    label = "Carry Firewood",
                    prop = {
                        model = "p_cs_woodpile01x",
                        bone = "PH_L_Hand",
                        position = vector3(0.0, 0.0, 0.0),
                        rotation = vector3(0.0, 0.0, 0.0),
                        anim = {
                            dict = "mech_pickup@firewood",
                            name = "idle_prop",
                            looped = true,
                            freeze = true,
                        }
                    },
                    animation = {
                        dict = "mech_pickup@firewood",
                        name = "idle",
                        flag = 25,
                        ikFlag = (1 << 16),
                        filter = false
                    }
                }
            }
        }
    },
    [2] = {
        item = "blacksmith_forge_advanced",              -- item name
        name = "Blast Brick Forge",                      -- name of the forge
        model = "brick_forge",
        minimumDistance = 2.0,                           -- Minimum distance to place the forge, set to 0.0 to disable the distance check
        zOffset = -0.15,                                 -- How deep the model is placed in the ground, adjust if needed
        invisZOffset = -1.25,                            -- Additional Z offset applied when the forge is invisible, to prevent players from seeing it underground, adjust if needed
        promptOffset = vector4(-0.75, -2.0, 0.5, 180.0), -- Offset for the prompt position
        fireOffset = vector4(-0.8458251953125, 0.4, 0.20161437988281, 0.0),
        marker = {
            scale = { x = 1.5, y = 1.5, z = 0.75 },    -- Scale of the marker
            color = { r = 139, g = 0, b = 0, a = 30 }, -- Color of the marker
        },
        smeltingSpeed = 1.5,                           -- Speed of smelting, faster than the basic forge
        fuelConsumptionRate = 1,                       -- Passive fuel burn per Config.FuelConsumptionInterval for this forge model
        conditionDeducts = {                           -- Condition deducts are a value < 1, that will be multiplied by the amount condition that will be required and deducted from the forge
            ["fuel"] = 0.1,                            -- Deduct 0.1 firewood per second of smelting
            ["cleanliness"] = 0.01,                    -- Deduct 0.01 cleanliness per second of smelting
            ["structureIntegrity"] = 0.005             -- Deduct 0.005 structure integrity per second of smelting
        },
        SmeltableItems = {
            [1] = {
                SmeltedItem = "ironbar",
                SmeltedItemLabel = "Iron Bar",
                SmeltedAmount = 1,
                RequiredItems = {
                    { Item = "coal", Amount = 1, Label = "Coal" },
                    { Item = "iron", Amount = 4, Label = "Iron Ore" },
                },
                RequiredTools = {
                    { Item = "barmold", Amount = 1, Label = "Bar Mold", OneForEach = true, RemoveItemChance = 0.1 }, -- OneForEach means that the amount required is multiplied by the inputted number by the player when smelting
                },
                ShovelingTime = 2 * 1000,
                SmeltingTime = 10 * 1000,
                ItemDestroyed = false,
                ExpRequirement = 0, -- Experience requirement to smelt the item, set to 0 if no experience is required
                ExpGain = 1.0,      -- Experience gain for smelting the item, set to 0 if no experience is gained
            },
            [2] = {
                SmeltedItem = "copperbar",
                SmeltedItemLabel = "Copper Bar",
                SmeltedAmount = 5,
                RequiredItems = {
                    { Item = "copper", Amount = 5, Label = "Copper Ore" },
                    { Item = "coal",   Amount = 2, Label = "Coal" },
                },
                RequiredTools = {
                    { Item = "barmold", Amount = 5, Label = "Bar Mold", OneForEach = true, RemoveItemChance = 0.2 },
                },
                ShovelingTime = 7 * 1000,
                SmeltingTime = 20 * 1000,
                ItemDestroyed = false,
                ExpRequirement = 100, -- Experience requirement to smelt the item, set to 0 if no experience is required
                ExpGain = 2.0,        -- Experience gain for smelting the item, set to 0 if no experience is gained
            },
            [3] = {
                SmeltedItem = "pigironbar",
                SmeltedItemLabel = "Pig Iron Bar",
                SmeltedAmount = 4,
                RequiredItems = {
                    { Item = "iron",      Amount = 4, Label = "Iron Ore" },
                    { Item = "coal",      Amount = 2, Label = "Coal" },
                    { Item = "limestone", Amount = 1, Label = "Limestone" },
                },
                RequiredTools = {
                    { Item = "barmold", Amount = 4, Label = "Bar Mold", OneForEach = true, RemoveItemChance = 0.2 },
                },
                ShovelingTime = 8 * 1000,
                SmeltingTime = 24 * 1000,
                ItemDestroyed = false,
                ExpRequirement = 300,
                ExpGain = 3.0, -- Experience gain for smelting the item, set to 0 if no experience is gained
            },
            [4] = {
                SmeltedItem = "bluegold",
                SmeltedItemLabel = "Blue Gold Bar",
                SmeltedAmount = 1,
                RequiredItems = {
                    { Item = "bluegoldnugget", Amount = 10, Label = "Blue Gold Nugget" },
                    { Item = "gold_nugget",    Amount = 10, Label = "Gold Nugget" },
                    { Item = "coal",           Amount = 2,  Label = "Coal" },
                },
                RequiredTools = {
                    { Item = "barmold", Amount = 1, Label = "Bar Mold", OneForEach = true, RemoveItemChance = 0.2 },
                },
                ShovelingTime = 10 * 1000,
                SmeltingTime = 30 * 1000,
                ItemDestroyed = 60 * 1000,
                ExpRequirement = 1000,
                ExpGain = 5.0, -- Experience gain for smelting the item, set to 0 if no experience is gained
            },
            [5] = {
                SmeltedItem = "rosegold",
                SmeltedItemLabel = "Rose Gold Bar",
                SmeltedAmount = 1,
                RequiredItems = {
                    { Item = "rosegoldnugget", Amount = 10, Label = "Rose Gold Nugget" },
                    { Item = "gold_nugget",    Amount = 10, Label = "Gold Nugget" },
                    { Item = "coal",           Amount = 2,  Label = "Coal" },
                },
                RequiredTools = {
                    { Item = "barmold", Amount = 1, Label = "Bar Mold", OneForEach = true, RemoveItemChance = 0.2 },
                },
                ShovelingTime = 10 * 1000,
                SmeltingTime = 30 * 1000,
                ItemDestroyed = 60 * 1000,
                ExpRequirement = 5000,
                ExpGain = 10.0, -- Experience gain for smelting the item, set to 0 if no experience is gained
            },
            [6] = {
                SmeltedItem = "greengold",
                SmeltedItemLabel = "Green Gold Bar",
                SmeltedAmount = 1,
                RequiredItems = {
                    { Item = "greengoldnugget", Amount = 10, Label = "Green Gold Nugget" },
                    { Item = "gold_nugget",     Amount = 10, Label = "Gold Nugget" },
                    { Item = "coal",            Amount = 2,  Label = "Coal" },
                },
                RequiredTools = {
                    { Item = "barmold", Amount = 1, Label = "Bar Mold", OneForEach = true, RemoveItemChance = 0.2 },
                },
                ShovelingTime = 10 * 1000,
                SmeltingTime = 30 * 1000,
                ItemDestroyed = 60 * 1000,
                ExpRequirement = 2000,
                ExpGain = 7.0, -- Experience gain for smelting the item, set to 0 if no experience is gained
            },
            [7] = {
                SmeltedItem = "goldbar",
                SmeltedItemLabel = "Gold Bar",
                SmeltedAmount = 1,
                RequiredItems = {
                    { Item = "gold_nugget", Amount = 20, Label = "Gold Nugget" },
                    { Item = "coal",        Amount = 2,  Label = "Coal" },
                },
                RequiredTools = {
                    { Item = "barmold", Amount = 1, Label = "Bar Mold", OneForEach = true, RemoveItemChance = 0.2 },
                },
                ShovelingTime = 10 * 1000,
                SmeltingTime = 30 * 1000,
                ItemDestroyed = 60 * 1000,
                ExpRequirement = 500,
                ExpGain = 5.0, -- Experience gain for smelting the item, set to 0 if no experience is gained
            },
            [8] = {
                SmeltedItem = "silverbar",
                SmeltedItemLabel = "Silver Bar",
                SmeltedAmount = 1,
                RequiredItems = {
                    { Item = "silver", Amount = 2, Label = "Silver Ore" },
                    { Item = "coal",   Amount = 1, Label = "Coal" },
                },
                RequiredTools = {
                    { Item = "barmold", Amount = 1, Label = "Bar Mold", OneForEach = true, RemoveItemChance = 0.2 },
                },
                ShovelingTime = 8 * 1000,
                SmeltingTime = 24 * 1000,
                ItemDestroyed = false,
                ExpRequirement = 800,
                ExpGain = 3.0, -- Experience gain for smelting the item, set to 0 if no experience is gained
            },
            [9] = {
                SmeltedItem = "glass",
                SmeltedItemLabel = "Glass",
                SmeltedAmount = 2,
                RequiredItems = {
                    { Item = "sand",      Amount = 4, Label = "Sand" },
                    { Item = "limestone", Amount = 2, Label = "Limestone" },
                    { Item = "coal",      Amount = 1, Label = "Coal" },
                },
                ShovelingTime = 6 * 1000,
                SmeltingTime = 20 * 1000,
                ItemDestroyed = 30 * 1000,
                ExpRequirement = 50,
                ExpGain = 1.0, -- Experience gain for smelting the item, set to 0 if no experience is gained
            },
            [10] = {
                SmeltedItem = "gasoline",
                SmeltedItemLabel = "Gasoline",
                SmeltedAmount = 1,
                RequiredItems = {
                    { Item = "crudeoil", Amount = 2, Label = "Crude Oil" },
                    { Item = "ethanol",  Amount = 1, Label = "Ethanol" },
                    { Item = "coal",     Amount = 1, Label = "Coal" },
                },
                ShovelingTime = 8 * 1000,
                SmeltingTime = 10 * 1000,
                ItemDestroyed = 60 * 1000,
                ExpRequirement = 4000,
                ExpGain = 5.0, -- Experience gain for smelting the item, set to 0 if no experience is gained
            },
            [11] = {
                SmeltedItem      = "titaniumbar",
                SmeltedItemLabel = "Titanium Bar",
                SmeltedAmount    = 2,
                RequiredItems    = {
                    { Item = "titanium", Amount = 6, Label = "Titanium Ore" },
                    { Item = "nitrite",  Amount = 2, Label = "Nitrite" },
                    { Item = "coal",     Amount = 2, Label = "Coal" },
                },
                RequiredTools    = {
                    { Item = "barmold", Amount = 2, Label = "Bar Mold", OneForEach = true, RemoveItemChance = 0.2 },
                },
                ShovelingTime    = 10 * 1000,
                SmeltingTime     = 15 * 1000,
                ItemDestroyed    = false,
                ExpRequirement   = 5000,
                ExpGain          = 10.0, -- Experience gain for smelting the item, set to 0 if no experience is gained
            },
            [12] = {
                SmeltedItem      = "steelbar", --- for reference
                SmeltedItemLabel = "Steel Bar",
                SmeltedAmount    = 2,
                RequiredItems    = {
                    { Item = "pigironbar", Amount = 2, Label = "Pig Iron Bar" },
                    { Item = "nickel",     Amount = 2, Label = "Nickel" },
                    { Item = "coal",       Amount = 2, Label = "Coal" },
                },
                RequiredTools    = {
                    { Item = "barmold", Amount = 2, Label = "Bar Mold", OneForEach = true, RemoveItemChance = 0.2 },
                },
                ShovelingTime    = 10 * 1000,
                SmeltingTime     = 15 * 1000,
                ItemDestroyed    = false,
                ExpRequirement   = 5000,
                ExpGain          = 10.0, -- Experience gain for smelting the item, set to 0 if no experience is gained
            },
            [13] = {
                SmeltedItem = "glassbottle",
                SmeltedItemLabel = "Glass Bottle",
                SmeltedAmount = 4,
                RequiredItems = {
                    { Item = "glass", Amount = 1, Label = "Glass" },
                    { Item = "coal",  Amount = 1, Label = "Limestone" },
                },
                ShovelingTime = 6 * 1000,
                SmeltingTime = 20 * 1000,
                ItemDestroyed = 30 * 1000,
                ExpRequirement = 50,
                ExpGain = 1.0, -- Experience gain for smelting the item, set to 0 if no experience is gained
            },
            [14] = {
                SmeltedItem = "iron_nugget",
                SmeltedItemLabel = "Iron Nugget",
                SmeltedAmount = 1,
                RequiredItems = {
                    { Item = "ironbar", Amount = 1, Label = "Iron Bar" },
                },
                ShovelingTime = 2 * 1000,
                SmeltingTime = 5 * 1000,
                ItemDestroyed = false,
                ExpRequirement = 0,
                ExpGain = 0.5,
            },
            [15] = {
                SmeltedItem = "copper_nugget",
                SmeltedItemLabel = "Copper Nugget",
                SmeltedAmount = 1,
                RequiredItems = {
                    { Item = "copperbar", Amount = 1, Label = "Copper Bar" },
                },
                ShovelingTime = 2 * 1000,
                SmeltingTime = 5 * 1000,
                ItemDestroyed = false,
                ExpRequirement = 0,
                ExpGain = 0.5,
            },
            [16] = {
                SmeltedItem = "silver_nugget",
                SmeltedItemLabel = "Silver Nugget",
                SmeltedAmount = 1,
                RequiredItems = {
                    { Item = "silverbar", Amount = 1, Label = "Silver Bar" },
                },
                ShovelingTime = 2 * 1000,
                SmeltingTime = 5 * 1000,
                ItemDestroyed = false,
                ExpRequirement = 0,
                ExpGain = 0.5,
            },
            [17] = {
                SmeltedItem = "gold_nugget",
                SmeltedItemLabel = "Gold Nugget",
                SmeltedAmount = 1,
                RequiredItems = {
                    { Item = "goldbar", Amount = 1, Label = "Gold Bar" },
                },
                ShovelingTime = 2 * 1000,
                SmeltingTime = 5 * 1000,
                ItemDestroyed = false,
                ExpRequirement = 0,
                ExpGain = 0.5,
            },
            [18] = {
                SmeltedItem = "titanium_nugget",
                SmeltedItemLabel = "Titanium Nugget",
                SmeltedAmount = 1,
                RequiredItems = {
                    { Item = "titaniumbar", Amount = 1, Label = "Titanium Bar" },
                },
                ShovelingTime = 2 * 1000,
                SmeltingTime = 5 * 1000,
                ItemDestroyed = false,
                ExpRequirement = 0,
                ExpGain = 0.5,
            },
            [19] = {
                SmeltedItem = "bluegoldnugget",
                SmeltedItemLabel = "Blue Gold Nugget",
                SmeltedAmount = 1,
                RequiredItems = {
                    { Item = "bluegold", Amount = 1, Label = "Blue Gold Bar" },
                },
                ShovelingTime = 2 * 1000,
                SmeltingTime = 5 * 1000,
                ItemDestroyed = false,
                ExpRequirement = 0,
                ExpGain = 0.5,
            },
            [20] = {
                SmeltedItem = "rosegoldnugget",
                SmeltedItemLabel = "Rose Gold Nugget",
                SmeltedAmount = 1,
                RequiredItems = {
                    { Item = "rosegold", Amount = 1, Label = "Rose Gold Bar" },
                },
                ShovelingTime = 2 * 1000,
                SmeltingTime = 5 * 1000,
                ItemDestroyed = false,
                ExpRequirement = 0,
                ExpGain = 0.5,
            },
            [21] = {
                SmeltedItem = "greengoldnugget",
                SmeltedItemLabel = "Green Gold Nugget",
                SmeltedAmount = 1,
                RequiredItems = {
                    { Item = "greengold", Amount = 1, Label = "Green Gold Bar" },
                },
                ShovelingTime = 2 * 1000,
                SmeltingTime = 5 * 1000,
                ItemDestroyed = false,
                ExpRequirement = 0,
                ExpGain = 0.5,
            },
            [22] = {
                SmeltedItem = "nickel_nugget",
                SmeltedItemLabel = "Nickel Nugget",
                SmeltedAmount = 1,
                RequiredItems = {
                    { Item = "nickelbar", Amount = 1, Label = "Nickel Bar" },
                },
                ShovelingTime = 2 * 1000,
                SmeltingTime = 5 * 1000,
                ItemDestroyed = false,
                ExpRequirement = 0,
                ExpGain = 0.5,
            },
            [23] = {
                SmeltedItem = "lead_nugget",
                SmeltedItemLabel = "Lead Nugget",
                SmeltedAmount = 1,
                RequiredItems = {
                    { Item = "leadbar", Amount = 1, Label = "Lead Bar" },
                },
                ShovelingTime = 2 * 1000,
                SmeltingTime = 5 * 1000,
                ItemDestroyed = false,
                ExpRequirement = 0,
                ExpGain = 0.5,
            },
            -- Add more smeltable items here
        },
        conditionChores = {
            -------------------------- CLEAN FORGE --------------------------------------

            ["clean_forge"] = {
                [1] = {
                    label = "Scrub Firebox",
                    cleanlinessIncrease = 30,
                    offSetLocation = vec4(-0.799316, -1.549560, 1.208786, 5.513885),
                    animation = {
                        type = "animation",
                        base = { dict = "amb_work@world_human_twnrec_scrub_blood@floor@male_a@idle_c", name = "idle_g", duration = 30000 },
                        exit = { dict = "amb_work@world_human_twnrec_scrub_blood@floor@male_a@walk_exit_withprop", name = "exit_back", duration = 3000 },
                    },
                },
                [2] = {
                    label = "Brush off Back",
                    cleanlinessIncrease = 15,
                    offSetLocation = vec4(-0.377441, 1.804443, 1.053757, -173.233780),
                    animation = {
                        type = "scenario",
                        name = "WORLD_HUMAN_HORSE_TEND_BRUSH_LINK",
                        duration = 20000
                    },
                },
                [3] = {
                    label = "Clean Chimney",
                    cleanlinessIncrease = 35,
                    offSetLocation = vec4(-0.764892, -0.131958, 6.224778, 0.661285),
                    animation = {
                        type = "animation",
                        enter = { dict = "amb_work@prop_human_soak_skins@gus@stand_enter", name = "stand_enter_lf", duration = 3000, prop = { model = "mp005_p_mp_stirstick01x", delay = 1000 } },
                        base = { dict = "amb_work@prop_human_soak_skins@gus@base", name = "base", duration = 10000 },
                        exit = { dict = "amb_work@prop_human_soak_skins@gus@stand_exit", name = "stand_exit", duration = 3000 },
                    },
                },
                [4] = {
                    label = "Clean Forge Counter",
                    cleanlinessIncrease = 20,
                    offSetLocation = vec4(-2.351562, -0.094116, 1.253792, -83.733734),
                    animation = {
                        type = "scenario",
                        name = "WORLD_HUMAN_CLEAN_TABLE",
                        duration = 5000,
                    },
                }
            },

            -------------------------- REPAIR STRUCTURE --------------------------------------

            ["repair_structure"] = {
                [1] = {
                    label = "Fix Bellow",
                    structureIntegrityIncrease = 20,
                    offSetLocation = vec4(1.437206, 1.221445, 1.0, 192.651142),
                    animation = {
                        type = "scenario",
                        name = "PROP_HUMAN_REPAIR_WAGON_WHEEL_ON_LARGE",
                        duration = 20000,
                    },
                },
                [2] = {
                    label = "Fix Bello",
                    structureIntegrityIncrease = 20,
                    offSetLocation = vec4(1.547242, -0.089744, 1.2, 79.364975),
                    animation = {
                        type = "scenario",
                        name = "PROP_HUMAN_REPAIR_WAGON_WHEEL_ON_SMALL",
                        duration = 20000,
                    },
                },
                [3] = {
                    label = "Chisel Off Damaged Brick",
                    structureIntegrityIncrease = 30,
                    offSetLocation = vec4(-0.6, -0.50, 2.0, 359.857986),
                    animation = {
                        type = "scenario",
                        name = "RANSACK_BRICK_WALL",
                        duration = 25000,
                    },
                }
            },

            -------------------------- ADD FUEL --------------------------------------

            ["add_fuel"] = {
                ["get_firewood"] = {
                    label = "Get Firewood",
                    prop = {
                        model = "p_cs_woodpile01x",
                        bone = "PH_L_Hand",
                        position = vector3(0.0, 0.0, 0.0),
                        rotation = vector3(0.0, 0.0, 0.0),
                        anim = {
                            dict = "mech_pickup@firewood",
                            name = "pickup_prop",
                            looped = false,
                            freeze = true,
                        }
                    },
                    animation = {
                        dict = "mech_pickup@firewood",
                        name = "pickup",
                        flag = 2,
                        duration = 2500,
                    }
                },
                ["add_firewood"] = {
                    label = "Add Firewood",
                    offSetLocation = vec4(-0.799316, -1.549560, 1.208786, 5.513885),
                    prop = {
                        model = "p_cs_woodpile01x",
                        bone = "PH_L_Hand",
                        position = vector3(0.0, 0.0, 0.0),
                        rotation = vector3(0.0, 0.0, 0.0),
                        anim = {
                            dict = "mech_pickup@firewood",
                            name = "fire_prop",
                            looped = false,
                            freeze = true,
                        }
                    },
                    animation = {
                        dict = "mech_pickup@firewood",
                        name = "fire",
                        flag = 2,
                        duration = 7000,
                        blendin = 8.0,
                    }
                },
                ["carry_firewood"] = {
                    label = "Carry Firewood",
                    prop = {
                        model = "p_cs_woodpile01x",
                        bone = "PH_L_Hand",
                        position = vector3(0.0, 0.0, 0.0),
                        rotation = vector3(0.0, 0.0, 0.0),
                        anim = {
                            dict = "mech_pickup@firewood",
                            name = "idle_prop",
                            looped = true,
                            freeze = true,
                        }
                    },
                    animation = {
                        dict = "mech_pickup@firewood",
                        name = "idle",
                        flag = 25,
                        ikFlag = (1 << 16),
                        filter = false
                    }
                },
                ["light_fire"] = {
                    label = "Light Fire",
                    offSetLocation = vec4(-0.8, -1.55, 1.2, 10.0),
                    prop = {
                        model = "p_match01x",
                        bone = "PH_R_Hand",
                        position = vector3(0.0, 0.0, 0.0),
                        rotation = vector3(0.0, 0.0, 0.0),
                        anim = {
                            dict = "amb_work@world_human_fire_start@male_a@base",
                            name = "base_prop",
                            looped = false,
                            freeze = true,
                        }
                    },
                    animation = {
                        dict = "script_amb@camp@fire@fire_poke@male@a",
                        name = "action",
                        flag = 2,
                        duration = -1.0,
                    }
                }
            },

            -------------------------- ADD FIREWOOD --------------------------------------

            ["add_firewood"] = {
                ["chop_wood"] = {
                    label = "Chop Wood",
                    prop = {
                        model = "p_axe01x",
                        bone = "PH_R_Hand",
                        position = vector3(0.0, 0.0, 0.0),
                        rotation = vector3(0.0, 0.0, 0.0),
                        anim = {
                            dict = "amb_work@prop_human_wood_chop@chop_front@male_a@stand_exit",
                            name = "exit_back_prop",
                            looped = false,
                            freeze = true,
                        }
                    },
                    animation = {
                        dict = "amb_work@prop_human_wood_chop@chop_front@male_a@stand_exit",
                        name = "exit_back",
                        flag = 2,
                        duration = 6000,
                        blendin = 80.0
                    }
                },
                ["pickup_wood"] = {
                    label = "Pickup Wood",
                    prop = {
                        model = "p_cs_woodpile01x",
                        bone = "PH_L_Hand",
                        position = vector3(0.0, 0.0, 0.0),
                        rotation = vector3(0.0, 0.0, 0.0),
                        anim = {
                            dict = "mech_pickup@firewood",
                            name = "pickup_prop",
                            looped = false,
                            freeze = true,
                        }
                    },
                    animation = {
                        dict = "mech_pickup@firewood",
                        name = "pickup",
                        flag = 2,
                        duration = 2500,
                    }
                },
                ["putdown_wood"] = {
                    label = "Put Down Firewood",
                    offSetLocation = vec4(-0.799316, -1.549560, 1.208786, 5.513885),
                    prop = {
                        model = "p_cs_woodpile01x",
                        bone = "PH_L_Hand",
                        position = vector3(0.0, 0.0, 0.0),
                        rotation = vector3(0.0, 0.0, 0.0),
                        anim = {
                            dict = "mech_pickup@firewood",
                            name = "putdown_prop",
                            looped = false,
                            freeze = true,
                        }
                    },
                    animation = {
                        dict = "mech_pickup@firewood",
                        name = "putdown",
                        flag = 2,
                        duration = 3400,
                    }
                },
                ["carry_firewood"] = {
                    label = "Carry Firewood",
                    prop = {
                        model = "p_cs_woodpile01x",
                        bone = "PH_L_Hand",
                        position = vector3(0.0, 0.0, 0.0),
                        rotation = vector3(0.0, 0.0, 0.0),
                        anim = {
                            dict = "mech_pickup@firewood",
                            name = "idle_prop",
                            looped = true,
                            freeze = true,
                        }
                    },
                    animation = {
                        dict = "mech_pickup@firewood",
                        name = "idle",
                        flag = 25,
                        ikFlag = (1 << 16),
                        filter = false
                    }
                }
            }
        }
    },
}

Config.ForgeToolMaxDistance = 4.0
Config.ForgeUpgrades = {
    [1] = {
        ["grinding_wheel"] = {
            model = "p_grindingwheel01x", -- Model name for the grinding wheel
            zOffset = 0.0,                -- How deep the model is placed in the ground, adjust if needed
            ExpRequirement = 0,           -- No experience required for the grinding wheel
            Price = 20,                   -- Price to buy the grinding wheel
        },
        ["wood_stump"] = {
            model = "p_stumpwoodsplit02x", -- Model name for the wood stump
            zOffset = 0.035,               -- How deep the model is placed in the ground, adjust if needed
            ExpRequirement = 0,            -- No experience required for the wood stump
            Price = 15,                    -- Price to buy the wood stump
        },
        ["wood_storage"] = {
            model = "p_woodpile06x", -- Model name for the wood storage
            zOffset = 0.0,           -- How deep the model is placed in the ground, adjust if needed
            ExpRequirement = 0,      -- No experience required for the wood storage
            Price = 10,              -- Price to buy the wood storage
        },
        ["fire"] = {
            model = "p_campfire02x_dynamic",
            Offset = vec4(0.111718, -0.496112, 0.721011, 175.624583),
            zOffset = 0.0,
            ExpRequirement = 0, -- No experience required for the fire
            Price = 0           -- Do not allow players to buy the fire, it's automatically spawned when placing the forge and is purely automatic upon lighting the forge and players have 0 control over it.
        }
    },
    [2] = {
        ["grinding_wheel"] = {
            model = "p_grindingwheel01x", -- Model name for the grinding wheel
            zOffset = 0.0,                -- How deep the model is placed in the ground, adjust if needed
            ExpRequirement = 0,           -- No experience required for the grinding wheel
            Price = 20,                   -- Price to buy the grinding wheel
        },
        ["anvil"] = {
            model = "mosquito_anvil", -- Model name for the anvil
            zOffset = 0.0,            -- How deep the model is placed in the ground, adjust if needed
            ExpRequirement = 300,     -- Experience required to own the anvil
            Price = 30,               -- Price to buy the anvil
            Crafting = {
                [1] = {
                    CraftedItem = "hammerhead", -- The item that will be crafted
                    CraftedItemLabel = "Hammer Head",
                    CraftedAmount = 1,
                    CraftingTime = 10 * 1000, -- Time in ms to craft the hammer head (10 seconds)
                    ExpRequirement = 0,       -- No experience required to smelt the item, set to 0 if no experience is required
                    ExpGain = 5.0,            -- Experience gain for smelting the item, set to 0 if no experience is gained
                    RequiredItems = {
                        { Item = "steelbar", Amount = 1, Label = "Steel Bar" },
                    },
                    GiveBackItems = {
                        { Item = "hammerhead", Amount = 1, Label = "Hammer Head" },
                    },
                    AttachedProp = {
                        model = "p_hoofnippers01x",
                        bone = "PH_L_Hand",
                        position = vector3(-0.05, 0.03, 0.8),
                        rotation = vector3(275.0, 185.0, 180.0),
                    }
                },
                [2] = {
                    CraftedItem = "blacksmithhammer", -- The item that will be crafted
                    CraftedItemLabel = "Blacksmith Hammer",
                    CraftedAmount = 1,
                    CraftingTime = 15 * 1000, -- Time in ms to craft the hammer (15 seconds)
                    ExpRequirement = 0,       -- No experience required to craft the hammer
                    ExpGain = 7.0,            -- Experience gained when crafting the hammer
                    RequiredItems = {
                        { Item = "hammerhead",  Amount = 1, Label = "Hammer Head" },
                        { Item = "smallhandle", Amount = 1, Label = "Small Wooden Handle" },
                    },
                    GiveBackItems = {
                        { Item = "hammer", Amount = 1, Label = "Blacksmith Hammer" },
                    },
                    AttachedProp = {
                        model = "p_hoofnippers01x",
                        bone = "PH_L_Hand",
                        position = vector3(-0.05, 0.03, 0.8),
                        rotation = vector3(275.0, 185.0, 180.0),
                    }
                },
                [3] = {
                    CraftedItem = "nails",
                    CraftedItemLabel = "Nails",
                    CraftedAmount = 20,
                    ExpRequirement = 500, -- Experience requirement to craft the nails
                    ExpGain = 10.0,       -- Experience gained when crafting the nails
                    RequiredItems = {
                        { Item = "ironbar", Amount = 1, Label = "Iron Bar" },
                    },
                    GiveBackItems = {
                        { Item = "nails", Amount = 5, Label = "Nails" },
                    },
                    AttachedProp = {
                        model = "p_hoofnippers01x",
                        bone = "PH_L_Hand",
                        position = vector3(-0.05, 0.03, 0.8),
                        rotation = vector3(275.0, 185.0, 180.0),
                    }
                },
                [4] = {
                    CraftedItem = "armingsword",
                    CraftedItemLabel = "Arming Sword",
                    CraftedAmount = 1,
                    CraftingTime = 30 * 1000,  -- Time in ms to craft the armingsword (30 seconds)
                    ExpRequirement = 10000000, -- Experience required to craft the armingsword
                    ExpGain = 20.0,            -- Experience gained when crafting the armingsword
                    RequiredItems = {
                        { Item = "steelbar",     Amount = 2, Label = "Steel Bar" },
                        { Item = "leatherstrip", Amount = 1, Label = "Leather Strip" },
                        { Item = "smallhandle",  Amount = 1, Label = "Small Wooden Handle" },
                        { Item = "nails",        Amount = 3, Label = "Nails" },
                    },
                    GiveBackItems = {
                        { Item = "armingsword", Amount = 1, Label = "Arming Sword" },
                    },
                    AttachedProp = {
                        model = "p_hoofnippers01x",
                        bone = "PH_L_Hand",
                        position = vector3(-0.05, 0.03, 0.8),
                        rotation = vector3(275.0, 185.0, 180.0),
                    }
                },
                [5] = {
                    CraftedItem = "pickaxe_head",
                    CraftedItemLabel = "Pickaxe Head",
                    CraftedAmount = 1,
                    CraftingTime = 15 * 1000,
                    ExpRequirement = 0,
                    ExpGain = 6,
                    RequiredItems = {
                        { Item = "ironbar", Amount = 3, Label = "Iron Bar" },
                    },
                    GiveBackItems = {},
                    AttachedProp = {
                        model = "pickaxe_steel_head",
                        bone = "PH_L_Hand",
                        position = vector3(-0.025, -0.05, 0.775),
                        rotation = vector3(-15.0, 90.0, 35.0),
                    }
                },
                [6] = {
                    CraftedItem = "pickaxe_steel_head",
                    CraftedItemLabel = "Steel Pickaxe Head",
                    CraftedAmount = 1,
                    CraftingTime = 15 * 1000,
                    ExpRequirement = 300,
                    ExpGain = 8,
                    RequiredItems = {
                        { Item = "steelbar", Amount = 3, Label = "Steel Bar" },
                    },
                    GiveBackItems = {},
                    AttachedProp = {
                        model = "pickaxe_steel_head",
                        bone = "PH_L_Hand",
                        position = vector3(-0.025, -0.05, 0.775),
                        rotation = vector3(-15.0, 90.0, 35.0),
                    }
                },
                [7] = {
                    CraftedItem = "pickaxe_silver_head",
                    CraftedItemLabel = "Silver-Titanium Pickaxe Head",
                    CraftedAmount = 1,
                    CraftingTime = 15 * 1000,
                    ExpRequirement = 800,
                    ExpGain = 12,
                    RequiredItems = {
                        { Item = "titaniumbar", Amount = 3, Label = "Titanium Bar" },
                        { Item = "silverbar",   Amount = 3, Label = "Silver Bar" },
                    },
                    GiveBackItems = {},
                    AttachedProp = {
                        model = "pickaxe_silver_head",
                        bone = "PH_L_Hand",
                        position = vector3(-0.025, -0.05, 0.775),
                        rotation = vector3(-15.0, 90.0, 35.0),
                    }
                },
                [8] = {
                    CraftedItem = "pickaxe_gold_head",
                    CraftedItemLabel = "Gold-Titanium Pickaxe Head",
                    CraftedAmount = 1,
                    CraftingTime = 15 * 1000,
                    ExpRequirement = 1000,
                    ExpGain = 14,
                    RequiredItems = {
                        { Item = "titaniumbar", Amount = 3, Label = "Titanium Bar" },
                        { Item = "goldbar",     Amount = 3, Label = "Gold Bar" },
                    },
                    GiveBackItems = {},
                    AttachedProp = {
                        model = "pickaxe_gold_head",
                        bone = "PH_L_Hand",
                        position = vector3(-0.025, -0.05, 0.775),
                        rotation = vector3(-15.0, 90.0, 35.0),
                    }
                },
                [9] = {
                    CraftedItem = "pickaxe",
                    CraftedItemLabel = "Pickaxe",
                    CraftedAmount = 1,
                    CraftingTime = 15 * 1000,
                    ExpRequirement = 50,
                    ExpGain = 6,
                    RequiredItems = {
                        { Item = "wood",         Amount = 3, Label = "Big Wooden Handle" },
                        { Item = "pickaxe_head", Amount = 1, Label = "Pickaxe Head" },
                    },
                    GiveBackItems = {},
                    AttachedProp = {
                        model = "p_pickaxe01x",
                        bone = "PH_L_Hand",
                        position = vector3(-0.3750, -0.8500, 0.6500),
                        rotation = vector3(-4.50, 81.00, 63.00),
                    }
                },
                [10] = {
                    CraftedItem = "pickaxe_steel",
                    CraftedItemLabel = "Steel Pickaxe",
                    CraftedAmount = 1,
                    CraftingTime = 15 * 1000,
                    ExpRequirement = 300,
                    ExpGain = 8,
                    RequiredItems = {
                        { Item = "bighandle",          Amount = 1, Label = "Big Wooden Handle" },
                        { Item = "pickaxe_steel_head", Amount = 1, Label = "Steel Pickaxe Head" },
                    },
                    GiveBackItems = {},
                    AttachedProp = {
                        model = "pickaxe_steel",
                        bone = "PH_L_Hand",
                        position = vector3(-0.3750, -0.8500, 0.6500),
                        rotation = vector3(-4.50, 81.00, 63.00),
                    }
                },
                [11] = {
                    CraftedItem = "pickaxe_silver",
                    CraftedItemLabel = "Silver Titanium Pickaxe",
                    CraftedAmount = 1,
                    CraftingTime = 15 * 1000,
                    ExpRequirement = 700,
                    ExpGain = 10,
                    RequiredItems = {
                        { Item = "bighandle",           Amount = 1, Label = "Big Wooden Handle" },
                        { Item = "pickaxe_silver_head", Amount = 1, Label = "Silver Titanium Pickaxe Head" },
                    },
                    GiveBackItems = {},
                    AttachedProp = {
                        model = "pickaxe_silver",
                        bone = "PH_L_Hand",
                        position = vector3(-0.3750, -0.8500, 0.6500),
                        rotation = vector3(-4.50, 81.00, 63.00),
                    }
                },
                [12] = {
                    CraftedItem = "pickaxe_gold",
                    CraftedItemLabel = "Golden Titanium Pickaxe",
                    CraftedAmount = 1,
                    CraftingTime = 15 * 1000,
                    ExpRequirement = 900,
                    ExpGain = 12,
                    RequiredItems = {
                        { Item = "bighandle",         Amount = 1, Label = "Big Wooden Handle" },
                        { Item = "pickaxe_gold_head", Amount = 1, Label = "Golden Titanium Pickaxe Head" },
                    },
                    GiveBackItems = {},
                    AttachedProp = {
                        model = "pickaxe_gold",
                        bone = "PH_L_Hand",
                        position = vector3(-0.3750, -0.8500, 0.6500),
                        rotation = vector3(-4.50, 81.00, 63.00),
                    }
                },
                [13] = {
                    CraftedItem = "lumberaxe",
                    CraftedItemLabel = "Lumber Axe",
                    CraftedAmount = 1,
                    CraftingTime = 15 * 1000,
                    ExpRequirement = 150,
                    ExpGain = 8,
                    RequiredItems = {
                        { Item = "bighandle", Amount = 1, Label = "Big Wooden Handle" },
                        { Item = "ironbar",   Amount = 2, Label = "Iron Bar" },
                    },
                    GiveBackItems = {},
                    AttachedProp = {
                        model = "p_axe01x",
                        bone = "PH_L_Hand",
                        position = vector3(-0.225, -0.5, 0.65),
                        rotation = vector3(-75.0, 0.0, -18.0),
                    }
                },
                [14] = {
                    CraftedItem = "lumberaxe_steel",
                    CraftedItemLabel = "Steel Lumber Axe",
                    CraftedAmount = 1,
                    CraftingTime = 15 * 1000,
                    ExpRequirement = 250,
                    ExpGain = 10,
                    RequiredItems = {
                        { Item = "bighandle", Amount = 1, Label = "Big Wooden Handle" },
                        { Item = "ironbar",   Amount = 3, Label = "Iron Bar" },
                    },
                    GiveBackItems = {},
                    AttachedProp = {
                        model = "p_axe02x",
                        bone = "PH_L_Hand",
                        position = vector3(-0.225, -0.5, 0.65),
                        rotation = vector3(-75.0, 0.0, -18.0),
                    }
                },
                [15] = {
                    CraftedItem = "goldpan",
                    CraftedItemLabel = "Gold Pan",
                    CraftedAmount = 1,
                    CraftingTime = 15 * 1000,
                    ExpRequirement = 50,
                    ExpGain = 5,
                    RequiredItems = {
                        { Item = "ironbar", Amount = 3, Label = "Iron Bar" },
                    },
                    GiveBackItems = {},
                    AttachedProp = {
                        model = "p_hoofnippers01x",
                        bone = "PH_L_Hand",
                        position = vector3(-0.05, 0.03, 0.8),
                        rotation = vector3(275.0, 185.0, 180.0),
                    }
                },
                [16] = {
                    CraftedItem = "bolts",
                    CraftedItemLabel = "Bolts",
                    CraftedAmount = 10,
                    CraftingTime = 15 * 1000,
                    ExpRequirement = 75,
                    ExpGain = 6,
                    RequiredItems = {
                        { Item = "ironbar", Amount = 1, Label = "Iron Bar" },
                    },
                    GiveBackItems = {
                        { Item = "bolts", Amount = 10, Label = "Bolts" },
                    },
                    AttachedProp = {
                        model = "p_hoofnippers01x",
                        bone = "PH_L_Hand",
                        position = vector3(-0.05, 0.03, 0.8),
                        rotation = vector3(275.0, 185.0, 180.0),
                    }
                },
                [17] = {
                    CraftedItem = "chisel",
                    CraftedItemLabel = "Chisel",
                    CraftedAmount = 1,
                    CraftingTime = 15 * 1000,
                    ExpRequirement = 150,
                    ExpGain = 8,
                    RequiredItems = {
                        { Item = "ironbar",     Amount = 2, Label = "Iron Bar" },
                        { Item = "smallhandle", Amount = 1, Label = "Small Wooden Handle" },
                    },
                    GiveBackItems = {},
                    AttachedProp = {
                        model = "p_hoofnippers01x",
                        bone = "PH_L_Hand",
                        position = vector3(-0.05, 0.03, 0.8),
                        rotation = vector3(275.0, 185.0, 180.0),
                    }
                },
                [18] = {
                    CraftedItem = "ironhammer",
                    CraftedItemLabel = "Hammer",
                    CraftedAmount = 1,
                    CraftingTime = 15 * 1000,
                    ExpRequirement = 100,
                    ExpGain = 8,
                    RequiredItems = {
                        { Item = "ironbar",     Amount = 2, Label = "Iron Bar" },
                        { Item = "smallhandle", Amount = 1, Label = "Small Wooden Handle" },
                    },
                    GiveBackItems = {},
                    AttachedProp = {
                        model = "p_hoofnippers01x",
                        bone = "PH_L_Hand",
                        position = vector3(-0.05, 0.03, 0.8),
                        rotation = vector3(275.0, 185.0, 180.0),
                    }
                },
                [19] = {
                    CraftedItem = "horseshoe",
                    CraftedItemLabel = "Horseshoe",
                    CraftedAmount = 4,
                    CraftingTime = 5 * 1000,
                    ExpRequirement = 0,
                    ExpGain = 5,
                    RequiredItems = {
                        { Item = "ironbar", Amount = 2, Label = "Iron Bar" },
                    },
                    GiveBackItems = {},
                    CraftingTime = 5 * 1000,
                    AttachedProp = {
                        model = "p_hoofnippers01x",
                        bone = "PH_L_Hand",
                        position = vector3(-0.05, 0.03, 0.8),
                        rotation = vector3(275.0, 185.0, 180.0),
                    }
                },
                [20] = {
                    CraftedItem = "hoofhook",
                    CraftedItemLabel = "Hoof Hook",
                    CraftedAmount = 2,
                    CraftingTime = 5 * 1000,
                    ExpRequirement = 0,
                    ExpGain = 4,
                    RequiredItems = {
                        { Item = "ironbar",     Amount = 1, Label = "Iron Bar" },
                        { Item = "smallhandle", Amount = 1, Label = "Small Wooden Handle" },
                    },
                    GiveBackItems = {},
                    CraftingTime = 5 * 1000,
                    AttachedProp = {
                        model = "p_hoofnippers01x",
                        bone = "PH_L_Hand",
                        position = vector3(-0.05, 0.03, 0.8),
                        rotation = vector3(275.0, 185.0, 180.0),
                    }
                },
                [21] = {
                    CraftedItem = "spring",
                    CraftedItemLabel = "Spring",
                    CraftedAmount = 2,
                    CraftingTime = 15 * 1000,
                    ExpRequirement = 200,
                    ExpGain = 8,
                    RequiredItems = {
                        { Item = "ironbar", Amount = 2, Label = "Iron Bar" },
                    },
                    GiveBackItems = {},
                    AttachedProp = {
                        model = "p_hoofnippers01x",
                        bone = "PH_L_Hand",
                        position = vector3(-0.05, 0.03, 0.8),
                        rotation = vector3(275.0, 185.0, 180.0),
                    }
                },
                [22] = {
                    CraftedItem = "shellcasing",
                    CraftedItemLabel = "Shell Casing",
                    CraftedAmount = 20,
                    CraftingTime = 15 * 1000,
                    ExpRequirement = 200,
                    ExpGain = 8,
                    RequiredItems = {
                        { Item = "ironbar", Amount = 2, Label = "Iron Bar" },
                    },
                    GiveBackItems = {},
                    AttachedProp = {
                        model = "p_hoofnippers01x",
                        bone = "PH_L_Hand",
                        position = vector3(-0.05, 0.03, 0.8),
                        rotation = vector3(275.0, 185.0, 180.0),
                    }
                },
                [23] = {
                    CraftedItem = "revolverbarrel",
                    CraftedItemLabel = "Revolver Barrel",
                    CraftedAmount = 1,
                    CraftingTime = 15 * 1000,
                    ExpRequirement = 200,
                    ExpGain = 8,
                    RequiredItems = {
                        { Item = "revolvermold", Amount = 1, Label = "Revolver Part Mold" },
                        { Item = "ironbar",      Amount = 1, Label = "Iron Bar" },
                    },
                    GiveBackItems = {},
                    AttachedProp = {
                        model = "p_hoofnippers01x",
                        bone = "PH_L_Hand",
                        position = vector3(-0.05, 0.03, 0.8),
                        rotation = vector3(275.0, 185.0, 180.0),
                    }
                },
                [24] = {
                    CraftedItem = "revolvercylinder",
                    CraftedItemLabel = "Revolver Cylinder",
                    CraftedAmount = 1,
                    CraftingTime = 15 * 1000,
                    ExpRequirement = 200,
                    ExpGain = 8,
                    RequiredItems = {
                        { Item = "revolvermold", Amount = 1, Label = "Revolver Part Mold" },
                        { Item = "ironbar",      Amount = 1, Label = "Iron Bar" },
                    },
                    GiveBackItems = {},
                    AttachedProp = {
                        model = "p_hoofnippers01x",
                        bone = "PH_L_Hand",
                        position = vector3(-0.05, 0.03, 0.8),
                        rotation = vector3(275.0, 185.0, 180.0),
                    }
                },
                [25] = {
                    CraftedItem = "repeaterbarrel",
                    CraftedItemLabel = "Repeater Barrel",
                    CraftedAmount = 1,
                    CraftingTime = 15 * 1000,
                    ExpRequirement = 200,
                    ExpGain = 8,
                    RequiredItems = {
                        { Item = "repeatermold", Amount = 1, Label = "Repeater Barrel Mold" },
                        { Item = "ironbar",      Amount = 2, Label = "Iron Bar" },
                    },
                    GiveBackItems = {},
                    AttachedProp = {
                        model = "p_hoofnippers01x",
                        bone = "PH_L_Hand",
                        position = vector3(-0.05, 0.03, 0.8),
                        rotation = vector3(275.0, 185.0, 180.0),
                    }
                },
                [26] = {
                    CraftedItem = "repeaterreceiver",
                    CraftedItemLabel = "Repeater Receiver",
                    CraftedAmount = 1,
                    CraftingTime = 15 * 1000,
                    ExpRequirement = 200,
                    ExpGain = 8,
                    RequiredItems = {
                        { Item = "repeaterrecmold", Amount = 1, Label = "Repeater Receiver Mold" },
                        { Item = "ironbar",         Amount = 1, Label = "Iron Bar" },
                    },
                    GiveBackItems = {},
                    AttachedProp = {
                        model = "p_hoofnippers01x",
                        bone = "PH_L_Hand",
                        position = vector3(-0.05, 0.03, 0.8),
                        rotation = vector3(275.0, 185.0, 180.0),
                    }
                },
                [27] = {
                    CraftedItem = "riflebarrel",
                    CraftedItemLabel = "Rifle Barrel",
                    CraftedAmount = 1,
                    CraftingTime = 15 * 1000,
                    ExpRequirement = 200,
                    ExpGain = 8,
                    RequiredItems = {
                        { Item = "riflemold", Amount = 1, Label = "Rifle Barrel Mold" },
                        { Item = "ironbar",   Amount = 2, Label = "Iron Bar" },
                    },
                    GiveBackItems = {},
                    AttachedProp = {
                        model = "p_hoofnippers01x",
                        bone = "PH_L_Hand",
                        position = vector3(-0.05, 0.03, 0.8),
                        rotation = vector3(275.0, 185.0, 180.0),
                    }
                },
                [28] = {
                    CraftedItem = "riflereceiver",
                    CraftedItemLabel = "Rifle Reciever",
                    CraftedAmount = 1,
                    CraftingTime = 15 * 1000,
                    ExpRequirement = 200,
                    ExpGain = 8,
                    RequiredItems = {
                        { Item = "riflerecmold", Amount = 1, Label = "Rifle Receiver Mold" },
                        { Item = "ironbar",      Amount = 1, Label = "Iron Bar" },
                    },
                    GiveBackItems = {},
                    AttachedProp = {
                        model = "p_hoofnippers01x",
                        bone = "PH_L_Hand",
                        position = vector3(-0.05, 0.03, 0.8),
                        rotation = vector3(275.0, 185.0, 180.0),
                    }
                },
                [29] = {
                    CraftedItem = "pistolreceiver",
                    CraftedItemLabel = "Pistol Receiver",
                    CraftedAmount = 1,
                    CraftingTime = 15 * 1000,
                    ExpRequirement = 2500,
                    ExpGain = 8,
                    RequiredItems = {
                        { Item = "pistolmold", Amount = 1, Label = "Pistol Mold" },
                        { Item = "ironbar",    Amount = 1, Label = "Iron Bar" },
                    },
                    GiveBackItems = {},
                    AttachedProp = {
                        model = "p_hoofnippers01x",
                        bone = "PH_L_Hand",
                        position = vector3(-0.05, 0.03, 0.8),
                        rotation = vector3(275.0, 185.0, 180.0),
                    }
                },
                [30] = {
                    CraftedItem = "pistolbarrel",
                    CraftedItemLabel = "Pistol Barrel",
                    CraftedAmount = 1,
                    CraftingTime = 15 * 1000,
                    ExpRequirement = 2500,
                    ExpGain = 8,
                    RequiredItems = {
                        { Item = "pistolmold", Amount = 1, Label = "Pistol Mold" },
                        { Item = "ironbar",    Amount = 1, Label = "Iron Bar" },
                    },
                    GiveBackItems = {},
                    AttachedProp = {
                        model = "p_hoofnippers01x",
                        bone = "PH_L_Hand",
                        position = vector3(-0.05, 0.03, 0.8),
                        rotation = vector3(275.0, 185.0, 180.0),
                    }
                },
                [31] = {
                    CraftedItem = "shotgunbarrel",
                    CraftedItemLabel = "Shotgun Barrel",
                    CraftedAmount = 1,
                    CraftingTime = 15 * 1000,
                    ExpRequirement = 200,
                    ExpGain = 8,
                    RequiredItems = {
                        { Item = "shotgunmold", Amount = 1, Label = "Shotgun Barrel Mold" },
                        { Item = "ironbar",     Amount = 2, Label = "Iron Bar" },
                    },
                    GiveBackItems = {},
                    AttachedProp = {
                        model = "p_hoofnippers01x",
                        bone = "PH_L_Hand",
                        position = vector3(-0.05, 0.03, 0.8),
                        rotation = vector3(275.0, 185.0, 180.0),
                    }
                },
                [32] = {
                    CraftedItem = "pistolmagazine",
                    CraftedItemLabel = "Pistol Magazine (Blacksmith)",
                    CraftedAmount = 1,
                    CraftingTime = 45 * 1000,
                    ExpRequirement = 2500,
                    ExpGain = 8,
                    RequiredItems = {
                        { Item = "pistolmold", Amount = 1, Label = "Pistol Mold" },
                        { Item = "ironbar",    Amount = 1, Label = "Iron Bar" },
                    },
                    GiveBackItems = {},
                    AttachedProp = {
                        model = "p_hoofnippers01x",
                        bone = "PH_L_Hand",
                        position = vector3(-0.05, 0.03, 0.8),
                        rotation = vector3(275.0, 185.0, 180.0),
                    }
                },
                [33] = {
                    CraftedItem = "steelriflebarrel",
                    CraftedItemLabel = "Steel Rifle Barrel (Blacksmith)",
                    CraftedAmount = 1,
                    CraftingTime = 45 * 1000,
                    ExpRequirement = 2500,
                    ExpGain = 8,
                    RequiredItems = {
                        { Item = "riflemold", Amount = 1, Label = "Rifle Barrel Mold" },
                        { Item = "steelbar",  Amount = 1, Label = "Steel Bar" },
                        { Item = "ironbar",   Amount = 4, Label = "Iron Bar" },
                    },
                    GiveBackItems = {},
                    AttachedProp = {
                        model = "p_hoofnippers01x",
                        bone = "PH_L_Hand",
                        position = vector3(-0.05, 0.03, 0.8),
                        rotation = vector3(275.0, 185.0, 180.0),
                    }
                },
                [34] = {
                    CraftedItem = "steelriflereceiver",
                    CraftedItemLabel = "Steel Rifle Receiver (Blacksmith)",
                    CraftedAmount = 1,
                    CraftingTime = 45 * 1000,
                    ExpRequirement = 2500,
                    ExpGain = 8,
                    RequiredItems = {
                        { Item = "riflerecmold", Amount = 1, Label = "Rifle Receiver Mold" },
                        { Item = "steelbar",     Amount = 1, Label = "Steel Bar" },
                        { Item = "ironbar",      Amount = 4, Label = "Iron Bar" },
                    },
                    GiveBackItems = {},
                    AttachedProp = {
                        model = "p_hoofnippers01x",
                        bone = "PH_L_Hand",
                        position = vector3(-0.05, 0.03, 0.8),
                        rotation = vector3(275.0, 185.0, 180.0),
                    }
                },
                [35] = {
                    CraftedItem = "wagon_frame_straping",
                    CraftedItemLabel = "Wagon Frame Straping (Blacksmith)",
                    CraftedAmount = 1,
                    CraftingTime = 45 * 1000,
                    ExpRequirement = 200,
                    ExpGain = 8,
                    RequiredItems = {
                        { Item = "steelbar", Amount = 1, Label = "Steel Bar" },
                        { Item = "ironbar",  Amount = 2, Label = "Iron Bar" },
                    },
                    GiveBackItems = {},
                    AttachedProp = {
                        model = "p_hoofnippers01x",
                        bone = "PH_L_Hand",
                        position = vector3(-0.05, 0.03, 0.8),
                        rotation = vector3(275.0, 185.0, 180.0),
                    }
                },
                [36] = {
                    CraftedItem = "lockpick",
                    CraftedItemLabel = "Lockpick",
                    CraftedAmount = 1,
                    CraftingTime = 30 * 1000,
                    ExpRequirement = 1500,
                    ExpGain = 8,
                    RequiredItems = {
                        { Item = "steelbar",     Amount = 1, Label = "Steel Bar" },
                        { Item = "ironbar",      Amount = 1, Label = "Iron Bar" },
                        { Item = "lockpickmold", Amount = 1, Label = "Lock Pick Mold" },
                    },
                    GiveBackItems = {},
                    AttachedProp = {
                        model = "p_hoofnippers01x",
                        bone = "PH_L_Hand",
                        position = vector3(-0.05, 0.03, 0.8),
                        rotation = vector3(275.0, 185.0, 180.0),
                    }
                },
            }
        },
        ["wood_stump"] = {
            model = "p_stumpwoodsplit02x", -- Model name for the wood stump
            zOffset = 0.035,               -- How deep the model is placed in the ground, adjust if needed
            ExpRequirement = 0,            -- No experience required for the wood stump
            Price = 15,                    -- Price to buy the wood stump
        },
        ["wood_storage"] = {
            model = "p_woodpile06x", -- Model name for the wood storage
            zOffset = 0.0,           -- How deep the model is placed in the ground, adjust if needed
            ExpRequirement = 0,      -- No experience required for the wood storage
            Price = 10,              -- Price to buy the wood storage
        },
        ["scaffolding"] = {
            model = "mosquito_scaffolding",           -- Model name for the chimney scaffolding
            Offset = vector4(-0.7936, 0.5, 0.0, 0.0), -- Offset for the scaffolding model
            zOffset = 0.0,                            -- zOffset is included because it is applied in real time upon spawning the object rather than only when the model is oringinally placed
            ExpRequirement = 0,                       -- No experience required for the chimney scaffolding
            Price = 10,                               -- Price to buy the chimney scaffolding
        },
        ["ladder"] = {
            model = "mosquito_ladder",                                 -- Model name for the ladder
            Offset = {
                [1] = vector4(-1.890234, 1.850562, 0.40019, -69.8615), -- Offset for the ladder model
                [2] = vector4(-1.850562, -1.890234, 0.40019, 20.1385), -- Offset for the ladder model
                [3] = vector4(1.50234, -0.70562, 0.40019, 110.1385),   -- Front (opposite of back)
                [4] = vector4(0.45, 2.4, 0.3, 200.1385),               -- Right (90° clockwise from front / 270° from back)
            },
            zOffset = 0.0,
            -- vec3(2811.648926, 1363.012085, 71.655228) - vec3(2811.018799, 1363.656982, 71.705238) = vec3(-0.630127, 0.644897, 0.050010)
            ExpRequirement = 0, -- No experience required for the ladder
            Price = 5,          -- Price to buy the ladder
        },
        ["fire"] = {
            model = "p_campfire02x_dynamic",
            Offset = vector4(-0.75, 0.5, -1.2, 0.0),
            zOffset = 0.0,
            ExpRequirement = 0, -- No experience required for the fire
            Price = 0           -- Do not allow players to buy the fire, it's automatically spawned when placing the forge and is purely automatic upon lighting the forge and players have 0 control over it.
        }
    }
}
