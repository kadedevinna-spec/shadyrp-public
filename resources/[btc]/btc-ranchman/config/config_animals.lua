--------------------
--- General
--------------------

Config.MaxFollowingAnimals     = 5           -- maximum animals that can follow a player simultaneously
Config.MaxAnimalsToAll         = false       -- number → global cap applied to all ranches; false → each ranch uses its own MaxAnimals value
Config.AnimalLifeMultiplier    = 2           -- multiplies the health attribute for in-game HP (health=100, multiplier=2 → in-game HP=200)
Config.AnimalInvincible        = true        -- if true, animals outside the ranch never die 
Config.AnimalTickRateInMinutes = 15          -- every X minutes animals age, lose hunger, or die (below 15 not recommended)
Config.AnimalPromptDistance    = 1.5         -- distance in meters at which animal interaction prompts appear
Config.AnimalWanderRadius      = 10.0        -- radius in meters for animal free-roam; always use a float e.g. 10.0, 5.0
Config.PenAnimalSpawnDistance  = 60.0        -- local pen visuals are created only this close to their area
Config.PenAnimalDespawnDistance = 60.0       -- hysteresis prevents repeated spawn/despawn near the boundary
Config.MaxVisiblePenAnimals    = 12          -- maximum local pen animals per client across all nearby ranches
Config.PenAnimalSpawnBatch     = 2           -- maximum local pen animals created per management tick
Config.FeedingTime             = 8000        -- duration in ms of the feeding animation

--------------------
--- Rates
--------------------

Config.Rate = {
    notDie                = false,   -- if true all animals dont die for hunger or age
    pregnancy             = 4,      -- How much gestation time will increase with each Config.AnimalTickRateInMinutes. With 4, a cow (280) takes ~17.5 real hours.
    minFertility          = 20,     -- The minimum fertility the animal needs to have to attempt reproduction, whether male or female.
    inseminationCooldown  = 10,     -- how many minutes it takes to be able to try animal reproduction again.
    maleBreedingCooldown  = 10,     -- how many minutes the male must wait before being able to reproduce again.
    hunger                = 1.5,    -- Decreases hunger attribute by X each tick
    age                   = 0.0104, -- Increases age by X each tick (0.0104 = 1 year per 24 real hours)
    outsideDropMultiplier = 2,      -- when outside the ranch, DECAY rates are multiplied by this (e.g. health.rate 1.02 × 2 = 2.04 — degrades twice as fast)
    outsideMultiplier     = 0.5,    -- when outside the ranch, GAIN rates are multiplied by this (e.g. health.rate 1.20 × 0.5 = 0.60 — recovers half as fast)
    health                = {
        healthSick = 50,            -- if the animal's health is below X, it does not improve (sick animal)
        minHungry = 10,             -- minimum health for the animal to start losing health
        rate = 1.02
    },                              -- Decreases or increases health by X each tick
    fertility             = {
        minHealth = 50,             -- minimum health for the animal to start losing fertility
        minHungry = 10,             -- minimum hunger for the animal to start losing fertility
        rate = 1.02,                -- Decreases or increases fertility by X each tick
    }
}

-- Equine crossbreeding table.
-- [male subtype][female subtype] = offspring subtype.
-- Values with '/' indicate a 50% chance for each option.
Config.HorseBreedingRules = {
    Horse  = { Horse = 'Horse', Donkey = 'Horse/Donkey', Mule = 'Horse' },
    Donkey = { Horse = 'Mule', Donkey = 'Donkey', Mule = 'Donkey' },
    Mule   = { Horse = 'Horse/Mule', Donkey = 'Donkey', Mule = 'Donkey' },
}


Config.Animals = {

    Goats = {
        MaxStats = { age = 15, weight = 90, pregnancy = 150 }, -- Maximum attributes for this species
        TroughCapacity = 500,                                   -- maximum units in the trough for this type
        FertilAge = 1.0,
        FertilizationChance = 100,                              --- chance of fertilization success (%)
        Milk = {
            item = 'milk',
            itemAmount = 1,
            cooldown = 10,    -- in minutes
            minChildrens = 1, -- minimum number of offspring born to give milk
        },
        PriceConfig = {
            BasePrice  = 4,     -- base purchase price in the store
            perKg      = 0.05,  -- additional value per kg of live weight
            SellRatio  = 0.55,  -- sale = X% of the calculated purchase price
            SaleRequirements = {
                health    = 70, -- minimum health for sale (0-100)
                fertility = 50, -- minimum fertility for sale (0-100)
                age       = 1,  -- minimum age for sale
            },
        },
        Food = {
            minHungry = 10, -- minimum hunger for the animal to start losing weight
            weight = 2,     -- how much weight the animal gains or loses each tick
        },
        FoodItems = {
            corn = {
                item = 'corn',   -- item in db
                amount = 5,      -- how many items are needed
                foodAmount = 10, -- how much hunger the animal gains by eating the item
            },
            broccoli = {
                item = 'broccoli', -- item in db
                amount = 5,        -- how many items are needed
                foodAmount = 11,   -- how much hunger the animal gains by eating the item
            },
            tomato = {
                item = 'tomato', -- item in db
                amount = 5,      -- how many items are needed
                foodAmount = 12, -- how much hunger the animal gains by eating the item
            },
            consumable_haycube = {
                item = 'consumable_haycube', -- item in db
                amount = 2,                  -- how many items are needed
                foodAmount = 50,             -- how much hunger the animal gains by eating the item
            }
        },
    },

    Cattle = {
        MaxStats = { age = 20, weight = 700, pregnancy = 280 },
        TroughCapacity = 1000,     -- maximum units in the trough for this type
        FertilAge = 2.0,
        FertilizationChance = 100, --- chance of fertilization success (%)
        Milk = {
            item = 'milk',         --- if false the milking menu don't appear
            itemAmount = 2,
            cooldown = 10,         -- in minutes
            minChildrens = 1,      -- minimum number of offspring born to give milk
        },
        PriceConfig = {
            BasePrice  = 15,    -- base purchase price in the store
            perKg      = 0.05,  -- additional value per kg of live weight
            SellRatio  = 0.50,  -- sale = X% of the calculated purchase price
            SaleRequirements = {
                health    = 75, -- minimum health for sale (0-100)
                fertility = 55, -- minimum fertility for sale (0-100)
                age       = 2,  -- minimum age for sale
            },
        },
        Food = {
            minHungry = 10, -- minimum hunger for the animal to start losing weight
            weight = 10,    -- how much weight the animal gains or loses each tick
        },

        FoodItems = {
            corn = {
                item = 'corn',   -- item in db
                amount = 5,      -- how many items are needed
                foodAmount = 10, -- how much hunger the animal gains by eating the item
            },
            broccoli = {
                item = 'wheat',  -- item in db
                amount = 5,      -- how many items are needed
                foodAmount = 15, -- how much hunger the animal gains by eating the item
            },
            tomato = {
                item = 'sugarcane', -- item in db
                amount = 5,         -- how many items are needed
                foodAmount = 20,    -- how much hunger the animal gains by eating the item
            },
            consumable_haycube = {
                item = 'consumable_haycube', -- item in db
                amount = 2,                  -- how many items are needed
                foodAmount = 50,             -- how much hunger the animal gains by eating the item
            }
        },
    },

    Poultry = {
        MaxStats = { age = 8, weight = 4, pregnancy = 21, },
        TroughCapacity = 200, -- maximum units in the trough for this type
        FertilAge = 0.5,
        EggLaying = {
            CheckIntervalInMinutes = 15,     -- Every X minutes, it checks if the Poultry can lay eggs or if an egg will hatch (a value less than 15 is not recommended)
            LayEggFertilityThreshold = 1,    -- Minimum fertility to lay an egg
            LayEggCooldownInMinutes = 29,    -- Time in minutes between each egg per hen
            FertilizationChance = 30,        -- Chance (in %) of an egg being fertilized if there are roosters in the coop
            ChickenBirthTimeInMinutes = 120, -- How long (min) for an egg to hatch (must be greater than CheckIntervalInMinutes)
            EggItem = 'eggs',                --- if false the eggs menu don't appears
            EggItemAmount = 5,               -- how many eggs when collecting an egg
        },
        PriceConfig = {
            BasePrice  = 1,    -- base purchase price in the store
            perKg      = 0.50, -- additional value per kg of live weight
            SellRatio  = 0.60, -- sale = X% of the calculated purchase price
            SaleRequirements = {
                health    = 70, -- minimum health for sale (0-100)
                fertility = 50, -- minimum fertility for sale (0-100)
                age       = 0,  -- minimum age for sale
            },
        },
        Food = {
            minHungry = 10, -- minimum hunger for the animal to start losing weight
            weight = 0.1,   -- how much weight the animal gains or loses each tick
        },

        FoodItems = {
            corn = {
                item = 'corn',   -- item in db
                amount = 5,      -- how many items are needed
                foodAmount = 10, -- how much hunger the animal gains by eating the item
            },
            broccoli = {
                item = 'broccoli', -- item in db
                amount = 5,        -- how many items are needed
                foodAmount = 15,   -- how much hunger the animal gains by eating the item
            },
            tomato = {
                item = 'carrot', -- item in db
                amount = 5,      -- how many items are needed
                foodAmount = 20, -- how much hunger the animal gains by eating the item
            },
        },
    },

    Swine = {
        MaxStats = { age = 15, weight = 250, pregnancy = 114 },
        TroughCapacity = 600,      -- maximum units in the trough for this type
        FertilAge = 1.0,
        FertilizationChance = 100, --- chance of fertilization success (%)
        Cleaning = {
            item = 'fetilizer',    --- if false the eggs menu don't appears
            amount = 5,
            cooldown = 10,
        },

        PriceConfig = {
            BasePrice  = 6,     -- base purchase price in the store
            perKg      = 0.04,  -- additional value per kg of live weight
            SellRatio  = 0.55,  -- sale = X% of the calculated purchase price
            SaleRequirements = {
                health    = 70, -- minimum health for sale (0-100)
                fertility = 50, -- minimum fertility for sale (0-100)
                age       = 1,  -- minimum age for sale
            },
        },

        Food = {
            minHungry = 10, -- minimum hunger for the animal to start losing weight
            weight = 4,     -- how much weight the animal gains or loses each tick
        },

        FoodItems = {
            corn = {
                item = 'potato', -- item in db
                amount = 5,      -- how many items are needed
                foodAmount = 10, -- how much hunger the animal gains by eating the item
            },
            broccoli = {
                item = 'corn',   -- item in db
                amount = 5,      -- how many items are needed
                foodAmount = 15, -- how much hunger the animal gains by eating the item
            },
            tomato = {
                item = 'carrot', -- item in db
                amount = 5,      -- how many items are needed
                foodAmount = 20, -- how much hunger the animal gains by eating the item
            },
            consumable_haycube = {
                item = 'wheat',  -- item in db
                amount = 2,      -- how many items are needed
                foodAmount = 50, -- how much hunger the animal gains by eating the item
            }
        },
    },

    Sheep = {
        MaxStats = { age = 12, weight = 100, pregnancy = 152 },
        TroughCapacity = 500,      -- maximum units in the trough for this type
        FertilAge = 1.0,
        FertilizationChance = 100, --- chance of fertilization success (%)
        Wool = {
            item = 'wool',         --- if false the eggs menu don't appears
            itemAmount = 6,
            cooldown = 60,         -- in minutes
            minAge = 1,            -- minimum age to give wool
        },

        PriceConfig = {
            BasePrice  = 5,     -- base purchase price in the store
            perKg      = 0.05,  -- additional value per kg of live weight
            SellRatio  = 0.55,  -- sale = X% of the calculated purchase price
            SaleRequirements = {
                health    = 70, -- minimum health for sale (0-100)
                fertility = 55, -- minimum fertility for sale (0-100)
                age       = 1,  -- minimum age for sale
            },
        },
        Food = {
            minHungry = 10, -- minimum hunger for the animal to start losing weight
            weight = 2,     -- how much weight the animal gains or loses each tick
        },

        FoodItems = {
            corn = {
                item = 'corn',   -- item in db
                amount = 5,      -- how many items are needed
                foodAmount = 10, -- how much hunger the animal gains by eating the item
            },
            broccoli = {
                item = 'broccoli', -- item in db
                amount = 5,        -- how many items are needed
                foodAmount = 11,   -- how much hunger the animal gains by eating the item
            },
            tomato = {
                item = 'tomato', -- item in db
                amount = 5,      -- how many items are needed
                foodAmount = 12, -- how much hunger the animal gains by eating the item
            },
            consumable_haycube = {
                item = 'consumable_haycube', -- item in db
                amount = 2,                  -- how many items are needed
                foodAmount = 50,             -- how much hunger the animal gains by eating the item
            }
        },
    },

    -- ── Equines (Horse / Donkey / Mule) ─────────────────────────────────
    Horse = {
        -- Subtypes: 'Horse', 'Donkey', 'Mule'
        -- The subtype is defined in animalData.subtype of each animal.
        

        MaxStats = { age = 25, weight = 500, pregnancy = 340, training = 100 },
        TroughCapacity = 800,
        FertilAge = 3.0,
        FertilizationChance = 100,

        -- Basic training: mechanics analogous to Milk (cooldown between sessions)
        Training = {
            cooldown       = 30,  -- minutes between training sessions
            increment      = 15,  -- % of training gained per session
            sellMultiplier = 2.5, -- price multiplier when selling with training >= 100
        },

        PriceConfig = {
            BasePrice  = 50,    -- base purchase price in the store (used when the coat does not have its own price)
            perKg      = 0.05,  -- additional value per kg of live weight
            SellRatio  = 0.50,  -- sale = X% of the calculated purchase price (×Training.sellMultiplier if trained)
            SaleRequirements = {
                health    = 80, -- minimum health for sale (0-100)
                fertility = 60, -- minimum fertility for sale (0-100)
                age       = 5,  -- minimum age for sale
            },
            -- Base price per coat (optional). If the coat is not here, uses BasePrice above.
            -- Comparison is case-insensitive.
            HorseBasePrice = {
                -- Draft & Basic
                { model = 'A_C_Horse_MP_Mangy_Backup', BasePrice = 5 },
                { model = 'A_C_Donkey_01', BasePrice = 10 },
                { model = 'A_C_HorseMule_01', BasePrice = 15 },
                { model = 'A_C_HorseMulePainted_01', BasePrice = 15 },
                
                -- Riding
                { model = 'A_C_Horse_KentuckySaddle_Black', BasePrice = 60 },
                { model = 'A_C_Horse_KentuckySaddle_ButterMilkBuckskin_PC', BasePrice = 60 },
                { model = 'A_C_Horse_KentuckySaddle_ChestnutPinto', BasePrice = 60 },
                { model = 'A_C_Horse_KentuckySaddle_Grey', BasePrice = 60 },
                { model = 'A_C_Horse_KentuckySaddle_SilverBay', BasePrice = 60 },
                { model = 'a_c_horse_gang_uncle', BasePrice = 60 },
                { model = 'A_C_Horse_Morgan_Bay', BasePrice = 55 },
                { model = 'A_C_Horse_Morgan_BayRoan', BasePrice = 55 },
                { model = 'A_C_Horse_Morgan_FlaxenChestnut', BasePrice = 55 },
                { model = 'A_C_Horse_Morgan_LiverChestnut_PC', BasePrice = 55 },
                { model = 'A_C_Horse_Morgan_Palomino', BasePrice = 55 },
                { model = 'A_C_Horse_TennesseeWalker_BlackRabicano', BasePrice = 60 },
                { model = 'A_C_Horse_TennesseeWalker_Chestnut', BasePrice = 60 },
                { model = 'A_C_Horse_TennesseeWalker_DappleBay', BasePrice = 60 },
                { model = 'A_C_Horse_TennesseeWalker_FlaxenRoan', BasePrice = 60 },
                { model = 'A_C_Horse_TennesseeWalker_MahoganyBay', BasePrice = 60 },
                { model = 'A_C_Horse_TennesseeWalker_RedRoan', BasePrice = 60 },
                { model = 'A_C_Horse_TennesseeWalker_GoldPalomino_PC', BasePrice = 60 },

                -- Draft
                { model = 'A_C_Horse_SuffolkPunch_RedChestnut', BasePrice = 120 },
                { model = 'A_C_Horse_SuffolkPunch_Sorrel', BasePrice = 120 },
                { model = 'A_C_Horse_Belgian_BlondChestnut', BasePrice = 120 },
                { model = 'A_C_Horse_Belgian_MealyChestnut', BasePrice = 120 },
                { model = 'A_C_Horse_Shire_DarkBay', BasePrice = 120 },
                { model = 'A_C_Horse_Shire_LightGrey', BasePrice = 120 },
                { model = 'A_C_Horse_Shire_RavenBlack', BasePrice = 120 },

                -- Race
                { model = 'A_C_Horse_Nokota_BlueRoan', BasePrice = 130 },
                { model = 'A_C_Horse_Nokota_ReverseDappleRoan', BasePrice = 130 },
                { model = 'A_C_Horse_Nokota_WhiteRoan', BasePrice = 130 },
                { model = 'a_c_horse_gang_charles_endlesssummer', BasePrice = 130 },
                { model = 'a_c_horse_gang_karen', BasePrice = 130 },
                { model = 'A_C_Horse_Thoroughbred_BlackChestnut', BasePrice = 130 },
                { model = 'A_C_Horse_Thoroughbred_BloodBay', BasePrice = 130 },
                { model = 'A_C_Horse_Thoroughbred_Brindle', BasePrice = 130 },
                { model = 'A_C_Horse_Thoroughbred_DappleGrey', BasePrice = 130 },
                { model = 'A_C_Horse_Thoroughbred_ReverseDappleBlack', BasePrice = 130 },
                { model = 'A_C_Horse_AmericanStandardbred_Black', BasePrice = 130 },
                { model = 'A_C_Horse_AmericanStandardbred_Buckskin', BasePrice = 130 },
                { model = 'A_C_Horse_AmericanStandardbred_PalominoDapple', BasePrice = 130 },
                { model = 'A_C_Horse_AmericanStandardbred_SilverTailBuckskin', BasePrice = 130 },

                -- War
                { model = 'A_C_Horse_Ardennes_BayRoan', BasePrice = 150 },
                { model = 'A_C_Horse_Ardennes_IronGreyRoan', BasePrice = 150 },
                { model = 'A_C_Horse_Ardennes_StrawberryRoan', BasePrice = 150 },
                { model = 'a_c_horse_gang_bill', BasePrice = 150 },
                { model = 'A_C_Horse_HungarianHalfbred_DarkDappleGrey', BasePrice = 130 },
                { model = 'A_C_Horse_HungarianHalfbred_FlaxenChestnut', BasePrice = 130 },
                { model = 'A_C_Horse_HungarianHalfbred_LiverChestnut', BasePrice = 130 },
                { model = 'A_C_Horse_HungarianHalfbred_PiebaldTobiano', BasePrice = 130 },
                { model = 'a_c_horse_gang_john', BasePrice = 130 },
                { model = 'A_C_Horse_Andalusian_DarkBay', BasePrice = 475 },
                { model = 'A_C_Horse_Andalusian_Perlino', BasePrice = 475 },
                { model = 'A_C_Horse_Andalusian_RoseGray', BasePrice = 475 },

                -- Work
                { model = 'A_C_Horse_DutchWarmblood_ChocolateRoan', BasePrice = 150 },
                { model = 'A_C_Horse_DutchWarmblood_SealBrown', BasePrice = 150 },
                { model = 'A_C_Horse_DutchWarmblood_SootyBuckskin', BasePrice = 150 },
                { model = 'a_c_horse_buell_warvets', BasePrice = 150 },
                { model = 'A_C_Horse_Appaloosa_BlackSnowflake', BasePrice = 130 },
                { model = 'A_C_Horse_Appaloosa_Blanket', BasePrice = 130 },
                { model = 'A_C_Horse_Appaloosa_BrownLeopard', BasePrice = 130 },
                { model = 'A_C_Horse_Appaloosa_FewSpotted_PC', BasePrice = 130 },
                { model = 'A_C_Horse_Appaloosa_Leopard', BasePrice = 130 },
                { model = 'A_C_Horse_Appaloosa_LeopardBlanket', BasePrice = 130 },
                { model = 'a_c_horse_gang_charles', BasePrice = 130 },
                { model = 'a_c_horse_gang_uncle_endlesssummer', BasePrice = 130 },
                { model = 'A_C_Horse_AmericanPaint_Greyovero', BasePrice = 130 },
                { model = 'A_C_Horse_AmericanPaint_Overo', BasePrice = 130 },
                { model = 'A_C_Horse_AmericanPaint_SplashedWhite', BasePrice = 130 },
                { model = 'a_c_horse_eagleflies', BasePrice = 130 },
                { model = 'A_C_Horse_AmericanPaint_Tobiano', BasePrice = 130 },

                -- Multi_class
                { model = 'A_C_Horse_MissouriFoxTrotter_AmberChampagne', BasePrice = 1000 },
                { model = 'A_C_Horse_MissouriFoxTrotter_SableChampagne', BasePrice = 1000 },
                { model = 'A_C_Horse_MissouriFoxTrotter_SilverDapplePinto', BasePrice = 1000 },
                { model = 'a_c_horse_missourifoxtrotter_blueroan', BasePrice = 1000 },
                { model = 'a_c_horse_missourifoxtrotter_buckskinbrindle', BasePrice = 1000 },
                { model = 'a_c_horse_missourifoxtrotter_dapplegrey', BasePrice = 1000 },
                { model = 'a_c_horse_gang_micah', BasePrice = 1000 },
                { model = 'A_C_Horse_Mustang_GoldenDun', BasePrice = 500 },
                { model = 'A_C_Horse_Mustang_GrulloDun', BasePrice = 500 },
                { model = 'A_C_Horse_Mustang_TigerStripedBay', BasePrice = 500 },
                { model = 'A_C_Horse_Mustang_WildBay', BasePrice = 500 },
                { model = 'a_c_horse_mustang_buckskin', BasePrice = 500 },
                { model = 'a_c_horse_mustang_chestnuttovero', BasePrice = 500 },
                { model = 'a_c_horse_mustang_reddunovero', BasePrice = 500 },
                { model = 'a_c_horse_gang_lenny', BasePrice = 500 },
                { model = 'a_c_horse_gang_sadie_endlesssummer', BasePrice = 500 },
                { model = 'A_C_Horse_Turkoman_DarkBay', BasePrice = 1000 },
                { model = 'A_C_Horse_Turkoman_Gold', BasePrice = 1000 },
                { model = 'A_C_Horse_Turkoman_Silver', BasePrice = 1000 },
                { model = 'a_c_horse_turkoman_chestnut', BasePrice = 1000 },
                { model = 'a_c_horse_turkoman_grey', BasePrice = 1000 },
                { model = 'a_c_horse_turkoman_perlino', BasePrice = 1000 },
                { model = 'a_c_horse_gang_sadie', BasePrice = 1000 },
                { model = 'A_C_Horse_Breton_SteelGrey', BasePrice = 550 },
                { model = 'A_C_Horse_Breton_MealyDappleBay', BasePrice = 550 },
                { model = 'A_C_Horse_Breton_SealBrown', BasePrice = 550 },
                { model = 'A_C_Horse_Breton_GrulloDun', BasePrice = 550 },
                { model = 'A_C_Horse_Breton_Sorrel', BasePrice = 550 },
                { model = 'A_C_Horse_Breton_RedRoan', BasePrice = 550 },
                { model = 'A_C_Horse_Criollo_Dun', BasePrice = 150 },
                { model = 'A_C_Horse_Criollo_MarbleSabino', BasePrice = 150 },
                { model = 'A_C_Horse_Criollo_BayFrameOvero', BasePrice = 150 },
                { model = 'A_C_Horse_Criollo_BayBrindle', BasePrice = 150 },
                { model = 'A_C_Horse_Criollo_SorrelOvero', BasePrice = 150 },
                { model = 'A_C_Horse_Criollo_BlueRoanOvero', BasePrice = 150 },
                { model = 'A_C_Horse_Kladruber_Black', BasePrice = 550 },
                { model = 'A_C_Horse_Kladruber_Silver', BasePrice = 550 },
                { model = 'A_C_Horse_Kladruber_Cremello', BasePrice = 550 },
                { model = 'A_C_Horse_Kladruber_Grey', BasePrice = 550 },
                { model = 'A_C_Horse_Kladruber_DappleRoseGrey', BasePrice = 550 },
                { model = 'A_C_Horse_Kladruber_White', BasePrice = 550 },
                { model = 'A_C_HORSE_NORFOLKROADSTER_BLACK', BasePrice = 550 },
                { model = 'A_C_HORSE_NORFOLKROADSTER_SPECKLEDGREY', BasePrice = 550 },
                { model = 'A_C_HORSE_NORFOLKROADSTER_PIEBALDROAN', BasePrice = 550 },
                { model = 'A_C_HORSE_NORFOLKROADSTER_ROSEGREY', BasePrice = 550 },
                { model = 'A_C_HORSE_NORFOLKROADSTER_DAPPLEDBUCKSKIN', BasePrice = 550 },
                { model = 'A_C_HORSE_NORFOLKROADSTER_SPOTTEDTRICOLOR', BasePrice = 550 },
                { model = 'a_c_horse_gypsycob_piebald', BasePrice = 550 },
                { model = 'a_c_horse_gypsycob_skewbald', BasePrice = 550 },
                { model = 'a_c_horse_gypsycob_splashedbay', BasePrice = 550 },
                { model = 'a_c_horse_gypsycob_splashedpiebald', BasePrice = 550 },
                { model = 'a_c_horse_gypsycob_whiteblagdon', BasePrice = 550 },

                -- Superior
                { model = 'A_C_Horse_Arabian_Black', BasePrice = 850 },
                { model = 'A_C_Horse_Arabian_Grey', BasePrice = 850 },
                { model = 'A_C_Horse_Arabian_RedChestnut', BasePrice = 850 },
                { model = 'a_c_horse_arabian_redchestnut_pc', BasePrice = 850 },
                { model = 'A_C_Horse_Arabian_RoseGreyBay', BasePrice = 850 },
                { model = 'A_C_Horse_Arabian_WarpedBrindle_PC', BasePrice = 850 },
                { model = 'A_C_Horse_Arabian_White', BasePrice = 850 },
                { model = 'a_c_horse_gang_dutch', BasePrice = 850 },
            },
        },

        Food = { minHungry = 15, weight = 8 },

        FoodItems = {
            consumable_haycube = {
                item       = 'consumable_haycube',
                amount     = 1,
                foodAmount = 100,
            },
            corn = {
                item       = 'corn',
                amount     = 5,
                foodAmount = 10,
            },
        },

        -- Integration with btc-stable (false = disabled)
        StableIntegration = true,
        BtcStableExport = 'Valentine', -- to which stable the animal goes when removed from btc-ranchman

        -- Blocked coats: model strings ignored in the store, at birth, and when importing from btc-stable.
        -- Add any model string here to prevent that coat from being used.
        -- Comparison is case-insensitive.
        NotAllowedCoats = {
            -- Example: block white Arabian and Dutch's gang Pinto (VIP horses)
            -- 'A_C_Horse_Arabian_White',
            -- 'a_c_horse_gang_dutch',
        },
    },
}
