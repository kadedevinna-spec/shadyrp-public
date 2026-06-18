Config = {}

Config.Birds = {
    Scavenger = {
        { 
            name = "Vulture", 
            price = 50, 
            image = "images/animal_vulture_western.png", 
            requiredLevel = 0, 
            model = "a_c_vulture_01",
            outfits = {
                { name = "Default", value = 0 },
                { name = "Outfit 1", value = 2 },
                { name = "Outfit 2", value = 3 },
                { name = "Outfit 3", value = 4 },
            }
        },
        { 
            name = "Crow", 
            price = 30, 
            image = "images/animal_crow.png", 
            requiredLevel = 1, 
            model = "a_c_crow_01",
            outfits = {
                { name = "Default", value = 0 },
                { name = "Outfit 1", value = 1 }
            }
        },
    },
    Fishing = {
        { 
            name = "Pelican", 
            price = 70, 
            image = "images/animal_pelican_white.png", 
            requiredLevel = 2, 
            model = "a_c_pelican_01",
            outfits = {
                { name = "Default", value = 0 },
                { name = "Outfit 1", value = 1 },
                { name = "Outfit 2", value = 2 }
            }
        },
        { 
            name = "Heron", 
            price = 60, 
            image = "images/animal_heron_greatblue.png", 
            requiredLevel = 3, 
            model = "a_c_heron_01",
            outfits = {
                { name = "Default", value = 0 },
                { name = "Outfit 1", value = 1 }
            }
        },
    },
    Hunting = {
        { 
            name = "Eagle", 
            price = 100, 
            image = "images/animal_eagle_bald.png", 
            requiredLevel = 4, 
            model = "a_c_eagle_01",
            outfits = {
                { name = "Default", value = 0 },
                { name = "Outfit 1", value = 1 },
                { name = "Outfit 2", value = 2 }
            }
        },
        { 
            name = "Hawk", 
            price = 90, 
            image = "images/animal_hawk_redtailed.png", 
            requiredLevel = 5, 
            model = "a_c_hawk_01",
            outfits = {
                { name = "Default", value = 0 },
                { name = "Outfit 1", value = 1 }
            }
        },
    },
    Companion = {
        { 
            name = "Parrot", 
            price = 120, 
            image = "images/animal_parrot_scarlet.png", 
            requiredLevel = 3, 
            model = "a_c_parrot_01", -- Modelo do papagaio
            canSpeak = true, -- Capacidade de falar
            outfits = {
                { name = "Green", value = 0 },
                { name = "Blue", value = 1 },
                { name = "Red", value = 2 },
            }
        }
    }
}

Config.TrainingZones = {
    {
        name = "Mountains One",
        coords = vector3(-787.2094, 1183.464, 151.9899),
        radius = 200.0,
        bonuses = {
            Scavenger = {
                xpBonus = 15,
                itemRewards = {
                    {name = "a_c_fishrockbass_01_sm", label = "Fisher Rock Bass", chance = 20}, -- 20% chance
                    {name = "carrot", label = "Carrots", chance = 60}, -- 60% chance
                    {name = "sugarcube", label = "Sugar Cube", chance = 20}  -- 20% chance
                },
            },
            Hunting = {
                xpBonus = 20,
                itemRewards = {
                    {name = "meat", label = "Meat", chance = 40}, -- 40% chance
                    {name = "leather", label = "Leather", chance = 15} -- 15% chance
                },
            },
        },
    },
    {
        name = "Lake",
        coords = vector3(500.0, 1000.0, 50.0),
        radius = 150.0,
        bonuses = {
            Fishing = {
                xpBonus = 25,
                itemRewards = {
                    {name = "reptile_skin", label = "Reptile Skin", chance = 50}, -- 50% chance
                    {name = "animal_heart", label = "Animal Heart", chance = 10} -- 10% chance
                },
            },
        },
    },
}

Config.SellBackPercentage = 60 -- Porcentagem do valor original que o jogador recebe ao vender o pássaro de volta

-- ==========================================
-- LANGUAGE / LOCALE CONFIGURATION
-- ==========================================
Config.Locale = {
    -- Server notifications
    birdSold = "Bird sold for $%s",
    birdSoldFail = "Failed to sell the bird",
    birdNotFound = "Bird not found",
    targetPlayerNotFound = "Target player not found",
    offerSent = "Offer sent to player",
    sellerNotFound = "Seller not found",
    insufficientMoney = "Insufficient money",
    buyerNoMoney = "The buyer doesn't have enough money",
    birdBoughtSuccess = "Bird purchased successfully for $%s",
    birdSoldSuccess = "Bird sold successfully for $%s",
    transferFailed = "Failed to transfer the bird",
    birdNotFoundOrNotOwned = "Bird not found or no longer belongs to seller",
    birdNotFoundOrNotYours = "Bird not found or no longer belongs to you",
    offerDeclined = "Offer declined",
    yourOfferDeclined = "Your offer was declined",
    
    -- Client notifications
    xpGained = "~COLOR_GOLD~+%s XP~s~ - %s",
    levelUp = "~COLOR_GREEN~LEVEL UP!~s~ %s reached level ~COLOR_GOLD~%s~s~!",
    itemFound = "~COLOR_BLUE~Item Found!~s~ Your bird found: ~COLOR_GOLD~%s~s~",
    trainingStarted = "~COLOR_BLUE~Training Started~s~ - %s is exploring!",
    trainingComplete = "~COLOR_GREEN~Training Complete!~s~ - %s has returned!",
    cooldownActive = "~COLOR_ORANGE~Cooldown Active~s~ - %s needs to rest!",
    errorMessage = "~COLOR_RED~Error:~s~ %s",
    successMessage = "~COLOR_GREEN~Success:~s~ %s",
    birdSoldFlewAway = "Your bird was sold and flew away.",
    invalidOfferData = "Invalid offer data",
}

-- Menu tabs configuration (images and descriptions)
Config.MenuTabs = {
    home = {
        label = "Home",
        image = "images/home.png",
        description = "Overview of your bird collection"
    },
    shop = {
        label = "Shop",
        image = "images/shop.png",
        description = "Purchase new birds for your collection"
    },
    inventory = {
        label = "Your Birds",
        image = "images/birds.png",
        description = "Manage and train your owned birds"
    }
}

-- Home stats images configuration
Config.HomeStats = {
    totalBirds = {
        image = "images/birds.png"
    },
    trainerLevel = {
        image = "images/trainer.png"
    },
    bestBird = {
        image = "images/animal1.png" -- Default image when no birds owned
    }
}


