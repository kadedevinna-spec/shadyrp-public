Config = {}

Config.OpenInventoryKey = 0xC1989F95 -- "I"

Config.Language = "en" -- "en"

Config.Locales = {
    ['en'] = {
        inventoryTitle = "INVENTORY",
        inventoryDesc = "Description of inventory",
        idLabel = "ID",
        filterLabel = "Filter",
        filterDefault = "Default",
        filterAZ = "A-Z",
        filterZA = "Z-A",
        searchPlaceholder = "Search...",
        weightTitle = "Weight",
        noMetadata = "No Metadata Found",
        amountTitle = "Amount",
        useItem = "Use",
        giveItem = "Give",
        buyItem = "Buy Item",
        takeOffClothes = "Take Off Clothes",
        wearClothes = "Wear Clothes",
        exitInventory = "Exit The Inventory",
        customButton = "Custom Button",
        
        groundLabel = "GROUND",
        stashLabel = "Stash",
        shopLabel = "Shop",
        playerLabel = "Player",
        robberyLabel = "Robbery",
        
        noPlayerFound = "Player not found!",
        usageOpenInv = "Usage: /openinv [ID]",
        targetTooFar = "Target is too far!",
        needWeapon = "You need a weapon!",
        robberyStarted = "Robbery Started",
        cantUseInv = "You cannot use inventory while being robbed!",
        cantRemoveItem = "You cannot remove this item!",
        itemAdded = "Item added.",
        itemAddFailed = "Item could not be added!",
        invFull = "Inventory full!",
        giveSuccess = "Item given.",
        receiveSuccess = "Item received.",
        cantCarry = "Target cannot carry this item!",
        noMoney = "Not enough money!",
        buySuccess = "Item bought.",
        ammoRefilled = "Ammo refilled.",
        wrongAmmo = "Wrong ammo type!",
        needWeaponAmmo = "You need a weapon to reload!",
        noAccess = "You don't have access!",
        weaponBroken = "This weapon is broken!",
        
        noPlayersNearby = "No one nearby!",
        robbingProgress = "Robbing...",
        robPrompt = "Rob",
        openShopPrompt = "Open Shop",
        openStashPrompt = "Open Stash",
        invFullWeight = "Inventory full! (Weight Limit)",
        givePrompt = "Give Item",
        cancelPrompt = "Cancel",

        -- Server Commands / Extras
        metadataError = "Metadata JSON error! Giving normal item.",
        giveItemUsage = "Usage: /giveitem [item] [amount] [json_metadata]",
        itemAdded = "%s (x%s) added.",
        itemAddError = "Item could not be added.",
        invalidId = "Invalid ID",
        inventoryCleared = "Inventory cleared: %s",
        inventoryClearError = "Inventory could not be cleared (Invalid ID?)",
        notEnoughItems = "Not enough items!",
        ammoRefillError = "Not enough capacity or weapon full!",
        itemNotFound = "Item not found!",
        itemRemoveFailed = "Item could not be removed!",
        
        -- Logs
        robberyLog = "Player **%s** (%s) started robbing Player **%s** (%s).",
        itemTaken = "Player **%s** (%s) took **%s** x%s from **%s**. (Drop ID: %s)",
        itemDropped = "Player **%s** (%s) dropped **%s** x%s from **%s**. (Drop ID: %s)",
        transferLog = "Player **%s** (%s) transferred **%s** x%s.\n**Source:** %s (%s)\n**Target:** %s (%s)",
        usedItemLog = "Player **%s** (%s) used **%s**.",
        giveLog = "Player **%s** (%s) gave **%s** x%s to Player **%s** (%s).",
        buyLog = "Player **%s** (%s) bought **%s** x%s from **%s**. Total: $%.2f",
        
        -- Log Titles
        logTitleItemTaken = "Item Taken From Ground",
        logTitleItemDropped = "Item Dropped To Ground",
        logTitleTransfer = "Inventory Transfer",
        logTitleUsed = "Item Used",
        logTitleGiven = "Item Given",
        logTitleBuy = "Item Bought",
        
        -- New Translations
        containerIdMissing = "Container ID missing!",
        containerNestError = "You cannot put a container inside another container!",
        knownIdentifiers = "Known Identifiers:\n",
        adminLabel = "Admin: Player",

        shopNotFound = "Shop not found!",
    },
    ['tr'] = {
        inventoryTitle = "ENVANTER",
        inventoryDesc = "Envanterinizi buradan yönetebilirsiniz.",
        idLabel = "KİMLİK",
        filterLabel = "Filtre",
        filterDefault = "Varsayılan",
        filterAZ = "A-Z",
        filterZA = "Z-A",
        searchPlaceholder = "Ara...",
        weightTitle = "Ağırlık",
        noMetadata = "Veri Bulunamadı",
        amountTitle = "Miktar",
        useItem = "Kullan",
        giveItem = "Ver",
        buyItem = "Satın Al",
        takeOffClothes = "Kıyafetleri Çıkar",
        wearClothes = "Kıyafetleri Giy",
        exitInventory = "Envanteri Kapat",
        customButton = "Özel Buton",

        groundLabel = "YER",
        stashLabel = "Depo",
        shopLabel = "Market",
        playerLabel = "Oyuncu",
        robberyLabel = "Soygun",

        noPlayerFound = "Oyuncu bulunamadı!",
        usageOpenInv = "Kullanım: /openinv [ID]",
        targetTooFar = "Hedef çok uzakta!",
        needWeapon = "Silahın olması gerekiyor!",
        robberyStarted = "Soygun Başladı",
        cantUseInv = "Soyulurken envanteri kullanamazsın!",
        cantRemoveItem = "Bu eşyayı çıkaramazsın!",
        itemAdded = "Eşya eklendi.",
        itemAddFailed = "Eşya eklenemedi!",
        invFull = "Envanter dolu!",
        giveSuccess = "Eşya verildi.",
        receiveSuccess = "Eşya alındı.",
        cantCarry = "Hedef oyuncu bunu taşıyamaz!",
        noMoney = "Yeterli paran yok!",
        buySuccess = "Eşya satın alındı.",
        ammoRefilled = "Mermi dolduruldu.",
        wrongAmmo = "Yanlış mermi tipi!",
        needWeaponAmmo = "Mermi doldurmak için silaha ihtiyacın var!",
        noAccess = "Erişim izniniz yok!",
        weaponBroken = "Bu silah bozuk!",

        noPlayersNearby = "Yakınlarda kimse yok!",
        robbingProgress = "Soyuluyor...",
        robPrompt = "Soy",
        openShopPrompt = "Marketi Aç",
        openStashPrompt = "Depoyu Aç",
        invFullWeight = "Envanter dolu! (Ağırlık Limiti)",
        givePrompt = "Eşyayı Ver",
        cancelPrompt = "İptal Et",

        -- Server Commands / Extras
        metadataError = "Metadata JSON hatası! Normal item veriliyor.",
        giveItemUsage = "Kullanım: /giveitem [item] [miktar] [json_metadata]",
        itemAdded = "%s (x%s) eklendi.",
        itemAddError = "Item eklenemedi.",
        invalidId = "Geçersiz ID",
        inventoryCleared = "Envanter temizlendi: %s",
        inventoryClearError = "Envanter temizlenemedi (ID Geçersiz mi?)",
        notEnoughItems = "Yeterli eşya yok!",
        ammoRefillError = "Mermi kapasitesi yetersiz veya silah dolu!",
        itemNotFound = "Eşya bulunamadı!",
        itemRemoveFailed = "Eşya kaldırılamadı!",

        -- Logs
        robberyLog = "Oyuncu **%s** (%s), Oyuncu **%s** (%s) adlı kişiyi soymaya başladı.",
        itemTaken = "Oyuncu **%s** (%s), yerden **%s** x%s eşyasını **%s** aldı. (Drop ID: %s)",
        itemDropped = "Oyuncu **%s** (%s), **%s** yere **%s** x%s eşyasını attı. (Drop ID: %s)",
        transferLog = "Oyuncu **%s** (%s), **%s** x%s eşyasını transfer etti.\n**Kaynak:** %s (%s)\n**Hedef:** %s (%s)",
        usedItemLog = "Oyuncu **%s** (%s), **%s** eşyasını kullandı.",
        giveLog = "Oyuncu **%s** (%s), Oyuncu **%s** (%s) adlı kişiye **%s** x%s verdi.",
        buyLog = "Oyuncu **%s** (%s), **%s** dükkanından **%s** x%s satın aldı. Toplam: $%.2f",

        -- Log Titles
        logTitleItemTaken = "Yerden Eşya Alındı",
        logTitleItemDropped = "Yere Eşya Atıldı",
        logTitleTransfer = "Envanter Transferi",
        logTitleUsed = "Eşya Kullanıldı",
        logTitleGiven = "Eşya Verildi",
        logTitleBuy = "Eşya Satın Alındı",
        
        -- New Translations
        containerIdMissing = "Konteyner ID eksik!",
        containerNestError = "Bir çantayı başka bir çantanın içine koyamazsın!",
        knownIdentifiers = "Bilinen Kimlikler:\n",
        adminLabel = "Admin: Oyuncu",

        shopNotFound = "Market bulunamadı!",
    }
}

-- Framework is auto-detected, but if you want to set it manually:
-- Config.Framework = "rsg-core" -- or "vorp"

Config.MoneyItemLabel = "Money"


-- "nearby" : Old behavior (Give to closest player automatically)
-- "targeting" : New behavior (Close inventory, show markers, use prompts to select player)
Config.GiveSystem = "targeting"

Config.DropSettings = {
    Type = "prop", -- "prop" or "marker"
    Model = "p_satchel01x", -- Prop model name
    MaxDistance = 2.0, -- Distance to see ground inventory
    DecayTime = 30 * 60 -- 30 Minutes
}

Config.CloseOtherNuis = function()
    -- TriggerEvent("vorp:CloseOtherNuis") 
end

Config.OpenOtherNuis = function()
    -- TriggerEvent("vorp:OpenOtherNuis") 
end

-- List of items that cannot be removed, given, or deleted from inventory
Config.PermanentItems = {
    -- "money", -- Money can now be removed from inventory
    -- "rock", -- Example permanent item
    -- Add items here that you don't want to be deleted
}

-- Starter items given when a new character is created
Config.StarterItems = {
    { name = "water", amount = 5 },
    { name = "bread", amount = 5 },
    { name = 'weapon_melee_knife', amount = 1 },
    { name = 'joint_purp', amount = 1 },
    -- { name = "weapon_revolver_cattleman", amount = 1, metadata = { ammo = 20 } }, -- example
}

Config.PlayerCapacity = 200.0 -- Max Player Weight from UI

Config.OnRobberyBlockKeys = {
    0xCEFD9220,
    0x5181713D,
    0xD244E9DD,
    0x07CE1E61,
    0xF84FA74F,
    0xB2F377E8,
    0x8FFC75D6,
    0x8FD015D8,
    0xFDA83190,
    0x4D8FB4C1,
    0xB4E465B4,
    0x7065027D,
    0x4CC0E2FE,
    0x2277FAE9,
    0xDE794E3E
}


Config.Stashes = {
    {
        name = "strawberry_public",
        label = "Strawberry Public Stash",
        coords = vector3(-1767.41, -381.42, 157.73), -- Example coords
        type = "public",  -- private/public
        capacity = 50,
        slots = 40,
        prop = "p_strongbox_muddy_01x"
    },
    {
        name = "strawberry_private",
        label = "Strawberry Private Stash",
        coords = vector3(-1763.89, -380.76, 157.74),
        type = "private",
        capacity = 20,
        slots = 10,
        prop = "p_chest01x"
    },
    {
        name = "police_stash",
        label = "Emergency Services Stash",
        coords = vector3(-180.0, 620.0, 114.0),
        type = "public", -- public or private
        job = {"police", "sheriff"}, -- List of allowed jobs
        grade = {1, 2, 3, 4, 5},     -- List of allowed grades
        capacity = 100,
        slots = 80,
        prop = "p_office_chest01x"
    }
}

Config.DeleteStashesOnRestart = {
   -- "police_trash",
}

-- Markmets (Shops)
Config.Shops = {
    {
        name = "medical_store",
        label = "Medical Store",
        coords = vector3(-178.0, 625.0, 114.0), -- Example coords
        job = "nurse", -- Anyone can use it
        items = {
            { name = "bread", label = "Bread", price = 1.50, maxBuy = 20 },
            { name = "water", label = "Water", price = 0.50, maxBuy = 20 },
            { name = "stone", label = "Stone", price = 2.00, maxBuy = 2 },
        },
        type = "shop"
    },
    {
        name = "sheriff_armory",
        label = "Sheriff's Armory",
        coords = vector3(-764.74, -1272.34, 44.04),
        job = {"police", "sheriff"}, -- all, "police" example
        grade = 0, -- Grade 0 and up
        items = {
            { name = "bread", label = "Sheriff Bread", price = 0.50, maxBuy = 20 },
        },
        type = "shop"
    }
}

Config.WeaponDefaults = {
    Durability = 100.0,
    DecayRate = 0.5,
    DefaultAmmo = 0,
    MaxAmmo = 120,
    Weight = 1.0
}

-- If no weapon settings have been configured for this section, whichever of the bullets listed below is used is directly added to the weapon
-- and 30 bullets are added by default.
Config.Weapons = {

    --Revolevers
    ["WEAPON_REVOLVER_SCHOFIELD"] = {
        Label = "Revolver Schofield",
        Weight = 4.0,
        DecayRate = 0.2,
        AllowedAmmo = {"ammorevolvernormal", "ammorevolverexpress", "ammorevolverexplosive", "ammorevolvervelocity", "ammorevolversplitpoint" },
        MaxAmmo = 60
    },
    ["WEAPON_REVOLVER_NAVY"] = {
        Label = "Revolver Navy",
        Weight = 4.0,
        DecayRate = 0.2,
        AllowedAmmo = {"ammorevolvernormal", "ammorevolverexpress", "ammorevolverexplosive", "ammorevolvervelocity", "ammorevolversplitpoint" },
        MaxAmmo = 60
    },
    ["WEAPON_REVOLVER_NAVY_CROSSOVER"] = {
        Label = "Revolver Navy",
        Weight = 4.0,
        DecayRate = 0.2,
        AllowedAmmo = {"ammorevolvernormal", "ammorevolverexpress", "ammorevolverexplosive", "ammorevolvervelocity", "ammorevolversplitpoint" },
        MaxAmmo = 60
    },
    ["WEAPON_REVOLVER_LEMAT"] = {
        Label = "Revolver Lemat",
        Weight = 4.0,
        DecayRate = 0.2,
        AllowedAmmo = {"ammorevolvernormal", "ammorevolverexpress", "ammorevolverexplosive", "ammorevolvervelocity", "ammorevolversplitpoint" },
        MaxAmmo = 60
    },
    ["WEAPON_REVOLVER_DOUBLEACTION"] = {
        Label = "Revolver Double Action",
        Weight = 4.0,
        DecayRate = 0.2,
        AllowedAmmo = {"ammorevolvernormal", "ammorevolverexpress", "ammorevolverexplosive", "ammorevolvervelocity", "ammorevolversplitpoint" },
        MaxAmmo = 60
    },
    ["WEAPON_REVOLVER_CATTLEMAN"] = {
        Label = "Revolver Cattleman",
        Weight = 4.0,
        DecayRate = 0.2,
        AllowedAmmo = {"ammorevolvernormal", "ammorevolverexpress", "ammorevolverexplosive", "ammorevolvervelocity", "ammorevolversplitpoint" },
        MaxAmmo = 60
    },
    ["WEAPON_REVOLVER_CATTLEMAN_MEXICAN"] = {
        Label = "Mexican Cattleman",
        Weight = 4.0,
        DecayRate = 0.2,
        AllowedAmmo = {"ammorevolvernormal", "ammorevolverexpress", "ammorevolverexplosive", "ammorevolvervelocity", "ammorevolversplitpoint" },
        MaxAmmo = 60
    },

    -- Pistols
    ["WEAPON_PISTOL_SEMIAUTO"] = {
        Label = "Pistol Semi-Auto",
        DecayRate = 0.2,
        Weight = 4.0,
        AllowedAmmo = {"ammopistolnormal", "ammopistolexpress", "ammopistolexplosive", "ammopistolvelocity", "ammopistolsplitpoint" },
        MaxAmmo = 60
    },
    ["WEAPON_PISTOL_MAUSER"] = {
        Label = "Pistol Mauser",
        DecayRate = 0.2,
        Weight = 4.0,
        AllowedAmmo = {"ammopistolnormal", "ammopistolexpress", "ammopistolexplosive", "ammopistolvelocity", "ammopistolsplitpoint" },
        MaxAmmo = 60
    },
    ["WEAPON_PISTOL_VOLCANIC"] = {
        Label = "Pistol Volcanic",
        DecayRate = 0.2,
        Weight = 4.0,
        AllowedAmmo = {"ammopistolnormal", "ammopistolexpress", "ammopistolexplosive", "ammopistolvelocity", "ammopistolsplitpoint" },
        MaxAmmo = 60
    },
    ["WEAPON_PISTOL_M1899"] = {
        Label = "Pistol M1899",
        DecayRate = 0.2,
        Weight = 4.0,
        AllowedAmmo = {"ammopistolnormal", "ammopistolexpress", "ammopistolexplosive", "ammopistolvelocity", "ammopistolsplitpoint" },
        MaxAmmo = 60
    },

    -- Repeaters
    ["WEAPON_REPEATER_WINCHESTER"] = {
        Label = "Winchester Repeater",
        DecayRate = 0.2,
        Weight = 4.0,
        AllowedAmmo = {"ammorepeaternormal", "ammorepeaterexpress", "ammorepeaterexplosive", "ammorepeatervelocity", "ammorepeatersplitpoint" },
        MaxAmmo = 60
    },
    ["WEAPON_REPEATER_HENRY"] = {
        Label = "Henry Reapeater",
        DecayRate = 0.2,
        Weight = 4.0,
        AllowedAmmo = {"ammorepeaternormal", "ammorepeaterexpress", "ammorepeaterexplosive", "ammorepeatervelocity", "ammorepeatersplitpoint" },
        MaxAmmo = 60
    },
    ["WEAPON_REPEATER_EVANS"] = {
        Label = "Evans Repeater",
        DecayRate = 0.2,
        Weight = 4.0,
        AllowedAmmo = {"ammorepeaternormal", "ammorepeaterexpress", "ammorepeaterexplosive", "ammorepeatervelocity", "ammorepeatersplitpoint" },
        MaxAmmo = 60
    },
    ["WEAPON_REPEATER_CARBINE"] = {
        Label = "Carabine Reapeater",
        DecayRate = 0.2,
        Weight = 4.0,
        AllowedAmmo = {"ammorepeaternormal", "ammorepeaterexpress", "ammorepeaterexplosive", "ammorepeatervelocity", "ammorepeatersplitpoint" },
        MaxAmmo = 60
    },

    -- Rifles
    ["WEAPON_RIFLE_VARMINT"] = {
        Label = "Varmint Rifle",
        DecayRate = 0.2,
        Weight = 4.0,
        AllowedAmmo = {"ammoriflenormal", "ammorifleexpress", "ammorifleexplosive", "ammoriflevelocity", "ammoriflesplitpoint" },
        MaxAmmo = 60
    },
    ["WEAPON_RIFLE_SPRINGFIELD"] = {
        Label = "Springfield Rifle",
        DecayRate = 0.2,
        Weight = 4.0,
        AllowedAmmo = {"ammoriflenormal", "ammorifleexpress", "ammorifleexplosive", "ammoriflevelocity", "ammoriflesplitpoint" },
        MaxAmmo = 60
    },
    ["WEAPON_RIFLE_ELEPHANT"] = {
        Label = "Elephant Rifle",
        DecayRate = 0.2,
        Weight = 4.0,
        AllowedAmmo = {"ammoriflenormal", "ammorifleexpress", "ammorifleexplosive", "ammoriflevelocity", "ammoriflesplitpoint" },
        MaxAmmo = 60
    },
    ["WEAPON_RIFLE_BOLTACTION"] = {
        Label = "BoltAction Rifle",
        DecayRate = 0.2,
        Weight = 4.0,
        AllowedAmmo = {"ammoriflenormal", "ammorifleexpress", "ammorifleexplosive", "ammoriflevelocity", "ammoriflesplitpoint" },
        MaxAmmo = 60
    },
    ["WEAPON_SNIPERRIFLE_ROLLINGBLOCK"] = {
        Label = "Rolling Block Rifle",
        DecayRate = 0.2,
        Weight = 4.0,
        AllowedAmmo = {"ammoriflenormal", "ammorifleexpress", "ammorifleexplosive", "ammoriflevelocity", "ammoriflesplitpoint" },
        MaxAmmo = 60
    },
    ["WEAPON_SNIPERRIFLE_CARCANO"] = {
        Label = "Carcano Rifle",
        DecayRate = 0.2,
        Weight = 4.0,
        AllowedAmmo = {"ammoriflenormal", "ammorifleexpress", "ammorifleexplosive", "ammoriflevelocity", "ammoriflesplitpoint" },
        MaxAmmo = 60
    },

    -- Shotgun
    ["WEAPON_SHOTGUN_SEMIAUTO"] = {
        Label = "Semi-Auto Shotgun",
        DecayRate = 0.2,
        Weight = 4.0,
        AllowedAmmo = {"ammoshotgunnormal", "ammoshotgunhotincendiary", "ammoshotgunslugexplosive", "ammoshotgunslug" },
        MaxAmmo = 30
    },
    ["WEAPON_SHOTGUN_SAWEDOFF"] = {
        Label = "Sawedoff Shotgun",
        DecayRate = 0.2,
        Weight = 4.0,
        AllowedAmmo = {"ammoshotgunnormal", "ammoshotgunhotincendiary", "ammoshotgunslugexplosive", "ammoshotgunslug" },
        MaxAmmo = 30
    },
    ["WEAPON_SHOTGUN_REPEATING"] = {
        Label = "Repeating Shotgun",
        DecayRate = 0.2,
        Weight = 4.0,
        AllowedAmmo = {"ammoshotgunnormal", "ammoshotgunhotincendiary", "ammoshotgunslugexplosive", "ammoshotgunslug" },
        MaxAmmo = 30
    },
    ["WEAPON_SHOTGUN_DOUBLEBARREL_EXOTIC"] = {
        Label = "Double Barrel Exotic Shotgun",
        DecayRate = 0.2,
        Weight = 4.0,
        AllowedAmmo = {"ammoshotgunnormal", "ammoshotgunhotincendiary", "ammoshotgunslugexplosive", "ammoshotgunslug" },
        MaxAmmo = 30
    },
    ["WEAPON_SHOTGUN_PUMP"] = {
        Label = "Pump Shotgun",
        DecayRate = 0.2,
        Weight = 4.0,
        AllowedAmmo = {"ammoshotgunnormal", "ammoshotgunhotincendiary", "ammoshotgunslugexplosive", "ammoshotgunslug" },
        MaxAmmo = 30
    },
    ["WEAPON_SHOTGUN_DOUBLEBARREL"] = {
        Label = "Double Barrel Shotgun",
        DecayRate = 0.2,
        Weight = 4.0,
        AllowedAmmo = {"ammoshotgunnormal", "ammoshotgunhotincendiary", "ammoshotgunslugexplosive", "ammoshotgunslug" },
        MaxAmmo = 30
    },

    -- Bows
    ["WEAPON_BOW"] = {
        Label = "Bow",
        DecayRate = 0.2,
        Weight = 4.0,
        AllowedAmmo = {"ammoarrownormal", "ammoarrowdynamite", "ammoarrowfire", "ammoarrowimproved", "ammoarrowsmallgame", "ammoarrowpoison" },
        MaxAmmo = 20
    },
    ["WEAPON_BOW_IMPROVED"] = {
        Label = "Improved Bow",
        DecayRate = 0.2,
        Weight = 4.0,
        AllowedAmmo = {"ammoarrownormal", "ammoarrowdynamite", "ammoarrowfire", "ammoarrowimproved", "ammoarrowsmallgame", "ammoarrowpoison" },
        MaxAmmo = 20
    },

}

-- Ammo Item Settings
Config.AmmoDefaults = {
    Amount = 30 -- Default bullets added per item
}

Config.AmmoItems = {
    [`GROUP_PISTOL`] = {
        ["AMMO_PISTOL"] = { item = "ammopistolnormal", Amount = 30 },
        ["AMMO_PISTOL_EXPRESS"] = { item = "ammopistolexpress", Amount = 30 },
        ["AMMO_PISTOL_EXPRESS_EXPLOSIVE"] = { item = "ammopistolexplosive", Amount = 30 },
        ["AMMO_PISTOL_HIGH_VELOCITY"] = { item = "ammopistolvelocity", Amount = 30 },
        ["AMMO_PISTOL_SPLIT_POINT"] = { item = "ammopistolsplitpoint", Amount = 30 },
    },

    [`GROUP_REPEATER`] = {
        ["AMMO_REPEATER"] = { item = "ammorepeaternormal", Amount = 30 },
        ["AMMO_REPEATER_EXPRESS"] = { item = "ammorepeaterexpress", Amount = 30 },
        ["AMMO_REPEATER_EXPRESS_EXPLOSIVE"] = { item = "ammorepeaterexplosive", Amount = 30 },
        ["AMMO_REPEATER_HIGH_VELOCITY"] = { item = "ammorepeatervelocity", Amount = 30 },
        ["AMMO_REPEATER_SPLIT_POINT"] = { item = "ammorepeatersplitpoint", Amount = 30 },
    },

    [`GROUP_REVOLVER`] = {
        ["AMMO_REVOLVER"] = { item = "ammorevolvernormal", Amount = 30 },
        ["AMMO_REVOLVER_EXPRESS"] = { item = "ammorevolverexpress", Amount = 30 },
        ["AMMO_REVOLVER_EXPRESS_EXPLOSIVE"] = { item = "ammorevolverexplosive", Amount = 30 },
        ["AMMO_REVOLVER_HIGH_VELOCITY"] = { item = "ammorevolvervelocity", Amount = 30 },
        ["AMMO_REVOLVER_SPLIT_POINT"] = { item = "ammorevolversplitpoint", Amount = 30 },
    },

    [`GROUP_RIFLE`] = {
        ["AMMO_RIFLE"] = { item = "ammoriflenormal", Amount = 30 },
        ["AMMO_RIFLE_ELEPHANT"] = { item = "ammoriflelephant", Amount = 30 },
        ["AMMO_RIFLE_EXPRESS"] = { item = "ammorifleexpress", Amount = 30 },
        ["AMMO_RIFLE_EXPRESS_EXPLOSIVE"] = { item = "ammorifleexplosive", Amount = 30 },
        ["AMMO_RIFLE_HIGH_VELOCITY"] = { item = "ammoriflevelocity", Amount = 30 },
        ["AMMO_RIFLE_SPLIT_POINT"] = { item = "ammoriflesplitpoint", Amount = 30 },
        ["AMMO_22"] = { item = "ammo22", Amount = 30 },
        ["AMMO_22_TRANQUILIZER"] = { item = "ammo22tranquilizer", Amount = 30 },
    },

    [`GROUP_SNIPER`] = {
        ["AMMO_RIFLE"] = { item = "ammoriflenormal", Amount = 30 },
        ["AMMO_RIFLE_EXPRESS"] = { item = "ammorifleexpress", Amount = 30 },
        ["AMMO_RIFLE_EXPRESS_EXPLOSIVE"] = { item = "ammorifleexplosive", Amount = 30 },
        ["AMMO_RIFLE_HIGH_VELOCITY"] = { item = "ammoriflevelocity", Amount = 30 },
        ["AMMO_RIFLE_SPLIT_POINT"] = { item = "ammoriflesplitpoint", Amount = 30 },
    },

    [`GROUP_SHOTGUN`] = {
        ["AMMO_SHOTGUN"] = { item = "ammoshotgunnormal", Amount = 30 },
        ["AMMO_SHOTGUN_BUCKSHOT_INCENDIARY"] = { item = "ammoshotgunhotincendiary", Amount = 30 },
        ["AMMO_SHOTGUN_SLUG_EXPLOSIVE"] = { item = "ammoshotgunslugexplosive", Amount = 30 },
        ["AMMO_SHOTGUN_SLUG"] = { item = "ammoshotgunslug", Amount = 30 },
    },

    [`GROUP_BOW`] = {
        ["AMMO_ARROW"] = { item = "ammoarrownormal", Amount = 30 },
        ["AMMO_ARROW_DYNAMITE"] = { item = "ammoarrowdynamite", Amount = 30 },
        ["AMMO_ARROW_FIRE"] = { item = "ammoarrowfire", Amount = 30 },
        ["AMMO_ARROW_IMPROVED"] = { item = "ammoarrowimproved", Amount = 30 },
        ["AMMO_ARROW_SMALL_GAME"] = { item = "ammoarrowsmallgame", Amount = 30 },
        ["AMMO_ARROW_POISON"] = { item = "ammoarrowpoison", Amount = 30 },
    },

    [`GROUP_THROWN`] = {
        ["AMMO_THROWING_KNIVES"] = { item = "ammothrowingknives", Amount = 30 },
        ["AMMO_TOMAHAWK"] = { item = "ammotomahawk", Amount = 30 },
        ["AMMO_POISONBOTTLE"] = { item = "ammopoisonbottle", Amount = 30 },
        ["AMMO_BOLAS"] = { item = "ammobolas", Amount = 30 },
        ["AMMO_BOLAS_HAWKMOTH"] = { item = "ammobolashawkmoth", Amount = 30 },
        ["AMMO_BOLAS_INTERTWINED"] = { item = "ammobolasintertwined", Amount = 30 },
        ["AMMO_BOLAS_IRONSPIKED"] = { item = "ammobolasironspiked", Amount = 30 },
        ["AMMO_DYNAMITE"] = { item = "ammodynamite", Amount = 30 },
        ["AMMO_DYNAMITE_VOLATILE"] = { item = "ammodynamitevolatile", Amount = 30 },
        ["AMMO_MOLOTOV"] = { item = "ammomolotov", Amount = 30 },
        ["AMMO_MOLOTOV_VOLATILE"] = { item = "ammomolotovvolatile", Amount = 30 },
        ["AMMO_HATCHET_HUNTER"] = { item = "ammohatchethunter", Amount = 30 },
        ["AMMO_HATCHET_DOUBLE_BIT"] = { item = "ammohatchetdoublebit", Amount = 30 },
        ["AMMO_HATCHET_HEWING"] = { item = "ammohatchethewing", Amount = 30 },
        ["AMMO_HATCHET_VIKING"] = { item = "ammohatchetviking", Amount = 30 },
        ["AMMO_HATCHET"] = { item = "ammohatchet", Amount = 30 },
        ["AMMO_HATCHET_CLEAVER"] = { item = "ammohatchetcleaver", Amount = 30 },
    },

    [`GROUP_PETROLCAN`] = {
        ["AMMO_MOONSHINEJUG_MP"] = { item = "AMMO_MOONSHINEJUG_MP", Amount = 30 },
    },
}

-- menu-3-button custom button settings
Config.CustomButton = {
    enabled = true,
    label = "Trade",
    icon = "button-icon-3", -- CSS class for icon or ./img/camp_icon.png
    action = "command", --  'client', 'server', or 'command'
    -- If action is 'client', 'server', or 'command', provide:
    -- event = "event_name",
    -- command = "command_name"
    command = "trade"
}

-- Show/Hide clothing menu (menu-2-group)
Config.ShowClothingMenu = true -- Set to true to show clothing toggle buttons

-- Logging Settings (Server-Side Only)
if IsDuplicityVersion() then
    Config.LogsEnabled = true
    Config.Webhooks = {
        ['default'] = "",
        ['robbery'] = "",
        ['give']    = "",
        ['stash']   = "",
        ['shop']    = "",
    }
end

-- Robbery Mechanism
Config.Robbery = { -- Your hands up animation
    AllowHandsUp = true,        -- Allow robbing players with hands up
    AllowLassoed = true,        -- Allow robbing lassoed players
    AllowHogtied = true,        -- Allow robbing hogtied players
    HandsUpAnim = {
        dict = "script_proc@robberies@homestead@lonnies_shack@deception",
        anim = "hands_up_loop",
        flag = 3
    },
    AllowDead = true,           -- Allow robbing dead players
    NeedWeapon = true,          -- Require a weapon to rob
    RobTime = 1000,             -- Time in milliseconds to perform the robbery 
    Animation = { -- Rob animation
        dict = "script_proc@robberies@coach@comp2@stop_coach",  
        anim = "take_hostage_attacker",
        flag = 29
    }
}
-- Container Items (Bags, Cases, etc.)
Config.ContainerItems = {
    ["bag"] = {
        slots = 15,
        capacity = 50.0,
        label = "Bag",
        blacklist = { "bag", "box" } -- Items that cannot be put inside this container
    },
    ["box"] = {
        slots = 10,
        capacity = 30.0,
        label = "Small Box",
        blacklist = { "bag", "box" }
    }
}
