Config = {}

-- ═══════════════════════════════════════════════════════════════
--  NPC CONFIGURATION
-- ═══════════════════════════════════════════════════════════════
Config.Vendor = {
    Enabled = true,
    Name = "Old Coot McGraw",
    Model = "cs_mp_moonshiner",
    Location = vector4(1235.36, -2326.19, 44.22, 355.90),

    Blip = {
        Enabled = true,
        Sprite = "blip_mp_role_moonshiner",
        Name = "Moonshine Vendor",
        Scale = 0.2
    },

    TrustRequirement = {
        RecipesRequired = 3
    },

    Shop = {
        {
            item = "still_build",
            label = "Basic Still Kit",
            price = 500,
            amount = 1,
            description = "Everything you need to start brewin'",
            levelRequired = 1,
            trustRequired = false,
            category = "Equipment"
        },
        {
            item = "moonshine_barrel",
            label = "Moonshine Barrel",
            price = 150,
            amount = 1,
            description = "For upgrading barrel to basic still",
            levelRequired = 1,
            trustRequired = false,
            category = "Equipment"
        },
        {
            item = "moonshine_pot_distillery",
            label = "Distillery Pot",
            price = 200,
            amount = 1,
            description = "For upgrading barrel to basic still",
            levelRequired = 1,
            trustRequired = false,
            category = "Equipment"
        },
        {
            item = "coal_ore",
            label = "Coal (x10)",
            price = 20,
            amount = 10,
            description = "Fuel for your still",
            levelRequired = 1,
            trustRequired = false,
            category = "Ingredients"
        },
        {
            item = "consumable_yeast",
            label = "Yeast (x5)",
            price = 20,
            amount = 5,
            description = "Essential for fermentation",
            levelRequired = 1,
            trustRequired = false,
            category = "Ingredients"
        },
        {
            item = "moonshine_pipe",
            label = "Copper Pipe",
            price = 100,
            amount = 1,
            description = "For still upgrades (Requires Trust)",
            levelRequired = 5,
            trustRequired = true,
            category = "Upgrade Parts"
        },
        {
            item = "moonshine_condenser",
            label = "Condenser Unit",
            price = 180,
            amount = 1,
            description = "For still upgrades (Requires Trust)",
            levelRequired = 5,
            trustRequired = true,
            category = "Upgrade Parts"
        },
        {
            item = "metal_components",
            label = "Metal Components (x5)",
            price = 50,
            amount = 5,
            description = "For repairs and upgrades (Requires Trust)",
            levelRequired = 5,
            trustRequired = true,
            category = "Upgrade Parts"
        },
        {
            item = "bolts",
            label = "Bolts (x10)",
            price = 25,
            amount = 10,
            description = "For still upgrades (Requires Trust)",
            levelRequired = 5,
            trustRequired = true,
            category = "Upgrade Parts"
        },
        {
            item = "bnuts",
            label = "Bolt Nuts (x10)",
            price = 20,
            amount = 10,
            description = "For still upgrades (Requires Trust)",
            levelRequired = 5,
            trustRequired = true,
            category = "Upgrade Parts"
        },
        {
            item = "nails",
            label = "Nails (x20)",
            price = 15,
            amount = 20,
            description = "For upgrading barrel to basic still",
            levelRequired = 1,
            trustRequired = false,
            category = "Upgrade Parts"
        }
    }
}

Config.Boss = {
    Enabled = true,
    Name = "Marcus \"The Distiller\" Kane",
    Model = "msp_mob1_males_01",
    Location = vector4(1339.17, -2287.48, 48.75, 76.20),

    IntroductionRequirements = {
        Level = 10,
        RecipesRequired = 4
    },

    Blip = {
        Enabled = true,
        Sprite = "blip_business_moonshine",
        Name = "Moonshine Boss",
        Scale = 0.2
    },

    TaxRate = 0.15,

    Shop = {
        {
            item = "wood_planks",
            label = "Wood Planks (x20)",
            price = 40,
            amount = 20,
            description = "For shack repairs and upgrades"
        },
        {
            item = "nails",
            label = "Nails (x50)",
            price = 30,
            amount = 50,
            description = "For shack construction"
        },
        {
            item = "metal_components",
            label = "Metal Components (x10)",
            price = 100,
            amount = 10,
            description = "For advanced shack equipment"
        },
        {
            item = "bar_counter",
            label = "Bar Counter",
            price = 500,
            amount = 1,
            description = "Upgrade your shack with a proper bar"
        },
        {
            item = "shack_stove",
            label = "Cast Iron Stove",
            price = 300,
            amount = 1,
            description = "Keep your shack warm and cook mash faster"
        },
        {
            item = "shack_table",
            label = "Wooden Table Set",
            price = 200,
            amount = 1,
            description = "Tables and chairs for customers"
        },
        {
            item = "shack_lighting",
            label = "Oil Lamp Set",
            price = 150,
            amount = 1,
            description = "Better lighting attracts more customers"
        },
        {
            item = "shack_decoration",
            label = "Decorative Set",
            price = 250,
            amount = 1,
            description = "Make your shack look respectable"
        }
    }
}

-- ═══════════════════════════════════════════════════════════════
--  DISTILLERY SYSTEM (Portable Stills)
-- ═══════════════════════════════════════════════════════════════

Config.DistilleryItem = 'still_build'
Config.DestroyItem = "dynamite"

--  PLACEMENT SYSTEM (Portable Stills)

Config.Placement = {
    MaxStillsPerPlayer = 5,
    MinDistance = 10.0,
    PlacementTime = 15000,
    Animation = {
        scenario = "WORLD_HUMAN_SLEDGEHAMMER"
    },
    Controls = {
        Cancel = 0xF84FA74F,     -- Backspace
        Confirm = 0x07CE1E61,    -- Space
        RotateLeft = 0xA65EBAB4, -- Left Arrow
        RotateRight = 0xDEB34313 -- Right Arrow
    }
}

Config.Distillery = {
    -- Fuel Configuration
    Fuel = {
        Item = "coal_ore",
        Label = "Coal",
        MaxCapacity = 100,
        BurnRate = 1
    },

    -- Damage & Repair System
    Damage = {
        Enabled = true,
        FragmentationEnabled = true,
        DamagePerBullet = 5.0,
        ExplosionThreshold = 20.0,
        RepairItem = "metal_components",
        RepairAmount = 3,
        RepairTime = 15000,

        LootOnDestroy = {
            {item = "moonshine_pipe", chance = 0.3},
            {item = "bolts", chance = 0.5},
            {item = "metal_components", chance = 0.4}
        }
    },

    -- Shack Distillery Repair (Explosions)
    Repair = {
        Materials = {
            {item = "wood", amount = 5},
            {item = "metal", amount = 3},
            {item = "copper", amount = 1}
        },
        Cost = {
            baseCost = 500,
            perHealthPoint = 10
        }
    },

    -- Upgrade Stages (Portable Stills)
    Stages = {
        [1] = {
            Name = "Barrel",
            Model = "mp006_p_mnshn_barrel02x",
            Functional = false,
            UpgradeTime = 10000,
            UpgradeItems = {
                {item = "moonshine_barrel", label = "Barrel", amount = 1},
                {item = "moonshine_pot_distillery", label = "Distillary Pot", amount = 1},
                {item = "nails", label = "Nails", amount = 5},
            },
            NextStage = 2
        },
        [2] = {
            Name = "Basic Still",
            Model = "mp006_p_moonshiner_still02x",
            DamagedModel = "mp006_p_moonshiner_still02x_dmg",
            Functional = true,
            Category = "basic",
            Health = 100.0,
            MaxBatches = 3, -- Can brew max 3 batches at once
            UpgradeTime = 20000,
            UpgradeItems = {
                {item = "bolts", label = "Bolts", amount = 5},
                {item = "bnuts", label = "Bolt Nuts", amount = 5},
                {item = "moonshine_pipe", label = "Moonshine Pipe", amount = 1},
                {item = "moonshine_condenser", label = "Moonshine Condenser", amount = 1},
                {item = "metal_components", label = "Metal Components", amount = 2},
            },
            NextStage = 3
        },
        [3] = {
            Name = "Advanced Still",
            Model = "mp006_p_moonshiner_still03x",
            DamagedModel = "mp006_p_moonshiner_still03x_dmg",
            Functional = true,
            Category = "advanced",
            Health = 150.0,
            MaxBatches = 8, -- Can brew max 8 batches at once
            UpgradeTime = nil,
            UpgradeItems = nil,
            NextStage = nil
        }
    }
}

-- ═══════════════════════════════════════════════════════════════
--  BREWING RECIPES & INGREDIENTS
-- ═══════════════════════════════════════════════════════════════
--  Two-Step Brewing Process:
--  STEP 1: Base Ingredients → Mash (45-60 seconds, no minigame)
--  STEP 2: Mash → Moonshine (5 minutes, with minigame)
-- ═══════════════════════════════════════════════════════════════

Config.Recipes = {
    -- Items that cause EXPLOSIONS and heavy damage (50 health)
    ExplosiveItems = {
        -- Weapons (pattern match)
        "weapon_",  -- Pattern: ANY item starting with "weapon_"

        -- Ammunition (pattern match)
        "ammo_",    -- Pattern: ANY item starting with "ammo_"

        -- Explosives
        "dynamite",
        "dynamite_volatile",
        "ammo_dynamite",
        "ammo_dynamite_volatile",
        "gunpowder",
        "explosive",
    },

    -- Proof Boosting Ingredients (Consumed during brewing, increase alcohol %)
    ProofBoosters = {
        ["honey"] = {
            proofIncrease = 5,
            flavorEffect = "sweet",
            maxPerBrew = 2
        },
        ["molasses"] = {
            proofIncrease = 8,
            flavorEffect = "rich",
            maxPerBrew = 1
        },
        ["special_yeast"] = {
            proofIncrease = 10,
            flavorEffect = "smooth",
            maxPerBrew = 1
        },
        ["copper_shavings"] = {
            proofIncrease = 3,
            qualityBoost = 10,
            maxPerBrew = 1
        }
    },

    -- STEP 1: MASH BREWING (Base Ingredients → Mash)
    mash = {
        basic = {
            name = "Basic Mash",
            output = "consumable_mash",
            cookTime = 45,
            ingredients = {
                {item = "corn", amount = 5},
                {item = "water", amount = 3},
                {item = "sugar", amount = 2},
                {item = "consumable_yeast", amount = 1}
            },
            xp = 25,
            minigame = {
                minTemp = 350,
                maxTemp = 650,
                optimalTemp = 500
            }
        },
        alaskan = {
            name = "Alaskan Mash",
            output = "consumable_mash_alaskan",
            cookTime = 50,
            ingredients = {
                {item = "corn", amount = 5},
                {item = "water", amount = 3},
                {item = "sugar", amount = 2},
                {item = "consumable_yeast", amount = 1},
                {item = "berries", amount = 3}
            },
            xp = 50,
            minigame = {
                minTemp = 350,
                maxTemp = 650,
                optimalTemp = 500
            }
        },
        american = {
            name = "American Mash",
            output = "consumable_mash_american",
            cookTime = 50,
            ingredients = {
                {item = "corn", amount = 7},
                {item = "water", amount = 3},
                {item = "sugar", amount = 3},
                {item = "consumable_yeast", amount = 1},
                {item = "wheat", amount = 2}
            },
            xp = 50,
            minigame = {
                minTemp = 350,
                maxTemp = 650,
                optimalTemp = 500
            }
        },
        apple_crumb = {
            name = "Apple Crumb Mash",
            output = "consumable_mash_apple_crumb",
            cookTime = 55,
            ingredients = {
                {item = "apple", amount = 8},
                {item = "water", amount = 3},
                {item = "sugar", amount = 4},
                {item = "consumable_yeast", amount = 1},
                {item = "cinnamon", amount = 2}
            },
            xp = 60,
            minigame = {
                minTemp = 350,
                maxTemp = 650,
                optimalTemp = 500
            }
        },
        blackberry = {
            name = "Blackberry Mash",
            output = "consumable_mash_blackberry",
            cookTime = 50,
            ingredients = {
                {item = "blackberry", amount = 10},
                {item = "water", amount = 3},
                {item = "sugar", amount = 3},
                {item = "consumable_yeast", amount = 1}
            },
            xp = 55,
            minigame = {
                minTemp = 350,
                maxTemp = 650,
                optimalTemp = 500
            }
        },
        peach = {
            name = "Peach Mash",
            output = "consumable_mash_peach",
            cookTime = 50,
            ingredients = {
                {item = "peach", amount = 8},
                {item = "water", amount = 3},
                {item = "sugar", amount = 3},
                {item = "consumable_yeast", amount = 1}
            },
            xp = 55,
            minigame = {
                minTemp = 350,
                maxTemp = 650,
                optimalTemp = 500
            }
        },
        plum = {
            name = "Plum Mash",
            output = "consumable_mash_plum",
            cookTime = 50,
            ingredients = {
                {item = "plum", amount = 8},
                {item = "water", amount = 3},
                {item = "sugar", amount = 3},
                {item = "consumable_yeast", amount = 1}
            },
            xp = 55,
            minigame = {
                minTemp = 350,
                maxTemp = 650,
                optimalTemp = 500
            }
        },
        raspberry = {
            name = "Raspberry Mash",
            output = "consumable_mash_raspberry",
            cookTime = 50,
            ingredients = {
                {item = "raspberry", amount = 10},
                {item = "water", amount = 3},
                {item = "sugar", amount = 3},
                {item = "consumable_yeast", amount = 1}
            },
            xp = 55,
            minigame = {
                minTemp = 350,
                maxTemp = 650,
                optimalTemp = 500
            }
        },
        tropical_punch = {
            name = "Tropical Punch Mash",
            output = "consumable_mash_tropical_punch",
            cookTime = 60,
            ingredients = {
                {item = "pineapple", amount = 5},
                {item = "orange", amount = 5},
                {item = "water", amount = 3},
                {item = "sugar", amount = 4},
                {item = "consumable_yeast", amount = 1}
            },
            xp = 70,
            minigame = {
                minTemp = 350,
                maxTemp = 650,
                optimalTemp = 500
            }
        },
        wild_cider = {
            name = "Wild Cider Mash",
            output = "consumable_mash_wild_cider",
            cookTime = 55,
            ingredients = {
                {item = "crabapple", amount = 10},
                {item = "water", amount = 3},
                {item = "honey", amount = 2},
                {item = "consumable_yeast", amount = 1}
            },
            xp = 65,
            minigame = {
                minTemp = 350,
                maxTemp = 650,
                optimalTemp = 500
            }
        }
    },

    -- STEP 2: MOONSHINE BREWING (Mash → Moonshine)
    moonshine = {
        basic = {
            name = "Basic Moonshine",
            output = "consumable_alcohol_moonshine",
            cookTime = 300,
            ingredients = {
                {item = "consumable_mash", amount = 1}
            },
            xp = 50,
            proof = { min = 30, max = 45, absoluteMax = 55 },
            minigame = {
                minTemp = 480,
                maxTemp = 620,
                optimalTemp = 550
            }
        },
        alaskan = {
            name = "Alaskan Moonshine",
            output = "consumable_alcohol_moonshine_alaskan",
            cookTime = 320,
            ingredients = {
                {item = "consumable_mash_alaskan", amount = 1}
            },
            xp = 100,
            proof = { min = 50, max = 70, absoluteMax = 80 },
            minigame = {
                minTemp = 500,
                maxTemp = 640,
                optimalTemp = 570
            }
        },
        american = {
            name = "American Moonshine",
            output = "consumable_alcohol_moonshine_american",
            cookTime = 320,
            ingredients = {
                {item = "consumable_mash_american", amount = 1}
            },
            xp = 100,
            proof = { min = 40, max = 60, absoluteMax = 70 },
            minigame = {
                minTemp = 500,
                maxTemp = 640,
                optimalTemp = 570
            }
        },
        apple_crumb = {
            name = "Apple Crumb Moonshine",
            output = "consumable_alcohol_moonshine_apple_crumb",
            cookTime = 340,
            ingredients = {
                {item = "consumable_mash_apple_crumb", amount = 1}
            },
            xp = 120,
            proof = { min = 28, max = 42, absoluteMax = 52 },
            minigame = {
                minTemp = 510,
                maxTemp = 650,
                optimalTemp = 580
            }
        },
        blackberry = {
            name = "Blackberry Moonshine",
            output = "consumable_alcohol_moonshine_blackberry",
            cookTime = 330,
            ingredients = {
                {item = "consumable_mash_blackberry", amount = 1}
            },
            xp = 110,
            proof = { min = 32, max = 48, absoluteMax = 58 },
            minigame = {
                minTemp = 505,
                maxTemp = 645,
                optimalTemp = 575
            }
        },
        peach = {
            name = "Peach Moonshine",
            output = "consumable_alcohol_moonshine_peach",
            cookTime = 330,
            ingredients = {
                {item = "consumable_mash_peach", amount = 1}
            },
            xp = 110,
            proof = { min = 30, max = 45, absoluteMax = 55 },
            minigame = {
                minTemp = 505,
                maxTemp = 645,
                optimalTemp = 575
            }
        },
        plum = {
            name = "Plum Moonshine",
            output = "consumable_alcohol_moonshine_plum",
            cookTime = 330,
            ingredients = {
                {item = "consumable_mash_plum", amount = 1}
            },
            xp = 110,
            proof = { min = 31, max = 46, absoluteMax = 56 },
            minigame = {
                minTemp = 505,
                maxTemp = 645,
                optimalTemp = 575
            }
        },
        raspberry = {
            name = "Raspberry Moonshine",
            output = "consumable_alcohol_moonshine_raspberry",
            cookTime = 330,
            ingredients = {
                {item = "consumable_mash_raspberry", amount = 1}
            },
            xp = 110,
            proof = { min = 33, max = 49, absoluteMax = 59 },
            minigame = {
                minTemp = 505,
                maxTemp = 645,
                optimalTemp = 575
            }
        },
        tropical_punch = {
            name = "Tropical Punch Moonshine",
            output = "consumable_alcohol_moonshine_tropical_punch",
            cookTime = 360,
            ingredients = {
                {item = "consumable_mash_tropical_punch", amount = 1}
            },
            xp = 140,
            proof = { min = 20, max = 35, absoluteMax = 45 },
            minigame = {
                minTemp = 520,
                maxTemp = 660,
                optimalTemp = 590
            }
        },
        wild_cider = {
            name = "Wild Cider Moonshine",
            output = "consumable_alcohol_moonshine_wild_cider",
            cookTime = 350,
            ingredients = {
                {item = "consumable_mash_wild_cider", amount = 1}
            },
            xp = 130,
            proof = { min = 25, max = 40, absoluteMax = 50 },
            minigame = {
                minTemp = 515,
                maxTemp = 655,
                optimalTemp = 585
            }
        }
    },

    -- FAILED BREWS (Wrong Ingredients)
    failed = {
        poor_moonshine = {
            name = "Poor Moonshine",
            output = "consumable_alcohol_poor_moonshine",
            cookTime = 45,
            xp = 2,  -- Fixed 2 XP for poor moonshine
            proof = { min = 15, max = 25, absoluteMax = 30 },
            ingredients = {
                {item = "water", amount = 3},
                {item = "corn", amount = 2}
            }
        },
        gunk_juice = {
            name = "Gunk Juice",
            output = "consumable_gunk_juice",
            cookTime = 30,
            xp = 1,  -- Fixed 1 XP for gunk juice (minimal reward)
            proof = { min = 5, max = 10, absoluteMax = 12 }
        }
    }
}
-- ═══════════════════════════════════════════════════════════════
--  XP & PROGRESSION SYSTEM
-- ═══════════════════════════════════════════════════════════════
Config.XP = {
    Enabled = true,
    MaxLevel = 50,

    XPPerLevel = function(level)
        return math.floor(100 * (level ^ 1.5))
    end,

    Rewards = {
        BrewSuccess = 25,
        BrewPerfect = 50,
        BrewFailed = 5,
        StillUpgrade = 100,
        FirstBrew = 200,
        ShackPurchase = 500
    },

    Perks = {
        [10] = {name = "efficient_1", label = "Efficient I", desc = "10% less fuel", fuelReduction = 0.1},
        [20] = {name = "quality_1", label = "Quality Boost", desc = "+10% quality", qualityBonus = 0.1},
        [30] = {name = "explosion_resist", label = "Steady Hand", desc = "50% less explosions", explosionReduction = 0.5},
        [40] = {name = "efficient_2", label = "Efficient II", desc = "20% less fuel", fuelReduction = 0.2},
        [50] = {name = "master", label = "Master Brewer", desc = "+25% XP, +15% quality", xpBonus = 0.25, qualityBonus = 0.15}
    }
}

-- ═══════════════════════════════════════════════════════════════
--  TEMPERATURE MINIGAME SYSTEM
-- ═══════════════════════════════════════════════════════════════
Config.Temperature = {
    StartTemp = 400,
    DangerTemp = 700,
    ExplosionTemp = 900,
    FreezingTemp = 250,

    -- Difficulty Tiers (XP-based progression)
    DifficultyTiers = {
        -- NOVICE (0-499 XP) - EXTREMELY HARD
        {
            minXP = 0,
            maxXP = 499,
            duration = 15,
            riseRate = 18,
            fallRate = 3,
            optimalTemp = 500,
            minTemp = 350,
            maxTemp = 650
        },
        -- APPRENTICE (500-1499 XP)
        {
            minXP = 500,
            maxXP = 1499,
            duration = 20,
            riseRate = 14,
            fallRate = 4,
            optimalTemp = 500,
            minTemp = 350,
            maxTemp = 650
        },
        -- SKILLED (1500-2999 XP)
        {
            minXP = 1500,
            maxXP = 2999,
            duration = 25,
            riseRate = 11,
            fallRate = 5,
            optimalTemp = 500,
            minTemp = 350,
            maxTemp = 650
        },
        -- EXPERT (3000-4999 XP)
        {
            minXP = 3000,
            maxXP = 4999,
            duration = 30,
            riseRate = 8,
            fallRate = 6,
            optimalTemp = 500,
            minTemp = 350,
            maxTemp = 650
        },
        -- MASTER (5000+ XP)
        {
            minXP = 5000,
            maxXP = 999999,
            duration = 40,
            riseRate = 6,
            fallRate = 8,
            optimalTemp = 500,
            minTemp = 350,
            maxTemp = 650
        }
    }
}

-- ═══════════════════════════════════════════════════════════════
--  EFFECTS & SOUNDS
-- ═══════════════════════════════════════════════════════════════

Config.Effects = {
    Smoke = {
        dict = "core",
        name = "ent_amb_stove_pipe_smoke_darker",
        offset = vector3(0.0, 0.15, 1.3),
        scale = 4.0
    },

    Explosion = {
        type = 27,
        vfx = "exp_grd_moonshine",
        shake = true,
        shakeIntensity = 5.0
    }
}

Config.Sounds = {
    UseInteractSound = true,
    BrewSound = "moonshineDeep",
    ExplosionSound = "explosion"
}

--------------------------------------------DO NOT TOUCH-------------------------------------------------
Config.BuildMoonshineMetadata = function(...)
    local args = { ... }

    local recipeKey = args[1]
    local recipeData = type(args[2]) == "table" and args[2] or {}
    local quality = tonumber(args[3]) or 0
    local alcohol = tonumber(args[4]) or 0
    local batchId = args[5] or tostring(os.time())

    return {
        recipe = recipeKey or recipeData.key or "unknown",
        recipeName = recipeData.name or recipeData.label or recipeKey or "Moonshine",
        quality = quality,
        alcohol = alcohol,
        batchId = batchId,
        brewedAt = os.time()
    }
end

-- Add metatable to Config.Distillery to support both Config.Distillery[n] and Config.Distillery.Stages[n]
setmetatable(Config.Distillery, {
    __index = function(t, k)
        -- If accessing with a number, forward to Stages
        if type(k) == "number" then
            return rawget(t, "Stages")[k]
        end
        -- Otherwise, use the normal table lookup
        return rawget(t, k)
    end
})