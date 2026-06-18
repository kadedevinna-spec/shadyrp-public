Config = {}
Config.ResourceName = "v-blackmarket"
Config.Debug = false

Config.Locations = {
    {
        id = "new_austin",
        label = "New Austin Black Market",
        npcModel = "gc_lemoynecaptive_males_01",
        tableModel = "p_bespoketable01x",
        coords = {
            x = -5395.28,
            y = -3664.72,
            z =  -24.97,
            heading = 180.96
        },
        requiredJob = "",
        requiredItem = "bm_key",
        items = {
            {
                itemName = "lumberaxe",
                category = "tools"
            },
            {
                itemName = "lockpick",
                category = "tools"
            },
            {
                itemName = "lockpick",
                category = "bombs"
            },
            {
                itemName = "moonshine",
                category = "alcohols"
            },
            {
                itemName = "Milk_weed",
                category = "seeds"
            },
            {
                itemName = "WEAPON_PISTOL_VOLCANIC",
                category = "weapon"
            }
        }
    },
}
Config.InteractionKey = 0x760A9C6F
Config.InteractionDistance = 2.5
Config.InteractionTextFormat = "Press [G] to open %s"

Config.Camera = {
    enabled = true,
    offset = {
        x = 2.0,
        y = -1.8,
        z = 1.2
    },
    rotation = {
        x = -20.0,
        y = 0.0,
        z = 0.0
    },
    fov = 30.0,
    transitionTime = 1000,
    smoothTransition = true
}
Config.ItemObject = {
    offset = {
        x = 0.0,
        y = 0.0,
        z = -0.2
    },
    rotateLeftKey = 0xDE794E3E,
    rotateRightKey = 0xCEFD9220,
    rotationSpeed = 3.0
} 
Config.ItemImagePath = "nui://v-inventory/web/dist/items/"
Config.FallbackImage = "nui://v-inventory/web/dist/items/consumable_package.png"

Config.UseVorpInventory = true
Config.VorpInventoryExport = "vorp_inventory"
Config.CurrencySymbol = "$"
Config.UseBankMoney = false

Config.Categories = {
    {
        id = "tools",
        label = "Tools & Equipment",
        icon = "category-tools",
        description = "Essential tools for your adventures"
    },
    {
        id = "bombs",
        label = "Explosives",
        icon = "category-bombs",
        description = "Dangerous explosives and ammunition"
    },
    {
        id = "alcohols",
        label = "Alcoholic Drinks",
        icon = "category-alcohols",
        description = "Fine spirits and strong drinks"
    },
    {
        id = "seeds",
        label = "Seeds & Plants",
        icon = "category-seeds",
        description = "Rare seeds and plant materials"
    },
    {
        id = "weapon",
        label = "Wildlife Goods",
        icon = "category-weapon",
        description = "Exotic animal parts and materials"
    }
}



Config.Items = {
    ["lumberaxe"] = {
        category = "tools",
        label = "Axe",
        description = "Lorem ipsum dolor sit amet consectetur adipiscing elit sed do eiusmod tempor incididunt ut labore.",
        price = 5,
        image = "pickaxe.png",
        maxPurchase = 10,
        propModel = "p_axe01x"
    },
    ["WEAPON_LASSO"] = {
        category = "tools",
        label = "Lasso",
        description = "lorem ipsum dolor sit amet consectetur adipiscing elit sed do eiusmod tempor incididunt ut labore",
        price = 5,
        image = "weapon_lasso_reinforced",
        maxPurchase = 10,
        propModel = "p_cs_melee_lasso01"
    },
    ["lockpick"] = {
        category = "tools",
        label = "Beartrap",
        description = "lorem ipsum dolor sit amet consectetur adipiscing elit sed do eiusmod tempor incididunt ut labore.",
        price = 5,
        image = "lockpick.png",
        maxPurchase = 10,
        propModel = "p_lockpick01x"
    },
    ["lockpick"] = {
        category = "bombs",
        label = "Beartrap",
        description = "A handy tool used for picking locks.",
        price = 5,
        image = "lockpick.png",
        maxPurchase = 10,
        propModel = "p_lockpick01x"
    },
    ["moonshine"] = {
        category = "tools",
        label = "Moonshine",
        description = "An illegally distilled and potent alcoholic beverage.",
        price = 5,
        image = "moonshine.png",
        maxPurchase = 10,
        propModel = "s_inv_moonshine01x"
    },
    ["Milk_weed"] = {
        category = "seeds",
        label = "AMilk Weed",
        description = "A plant with milky sap used for medicinal purposes.",
        price = 50,
        image = "Milk_Weed.png",
        maxPurchase = 10,
        propModel = "s_milkweed01x"
    },
    ["WEAPON_PISTOL_VOLCANIC"] = {
        category = "weapon",
        label = "Pistol Volcanicy",
        description = "an improved version of the Rocket Ball ammunition.",
        price = 25,
        image = "WEAPON_PISTOL_VOLCANIC.png",
        maxPurchase = 5,
        propModel = "w_pistol_mauser02"
    },
    ["revolvermold"] = {
        category = "tools",
        label = "Alligator Skin",
        description = "High quality alligator leather. Valuable material.",
        price = 150,
        image = "revolvermold.png",
        maxPurchase = 3,
        propModel = "aligators"
    },
    ["pickaxe"] = {
        category = "tools",
        label = "American Ginseng",
        description = "Medicinal herb with powerful properties.",
        price = 35,
        image = "pickaxe.png",
        maxPurchase = 15,
        propModel = "p_pickaxe01x"
    },
    ["lockpick"] = {
        category = "tools",
        label = "Dynamite Arrow",
        description = "Explosive ammunition. Handle with extreme care!",
        price = 75,
        image = "lockpick.png",
        maxPurchase = 20,
        propModel = "p_lockpick01x"
    },
    ["bm_key"] = {
        category = "tools",
        label = "Black Market Key",
        description = "A mysterious key that grants access to the Black Market.",
        price = 0,
        image = "bm_key.png",
        maxPurchase = 1,
        propModel = "p_cottonbox01x"
    }
}


Config.EnableAntiCheat = true
Config.MaxPurchaseDistance = 5.0
Config.PurchaseCooldown = 500


Config.Notifications = {
    success = "You purchased %s x%d for %s%d",
    noMoney = "You don't have enough money!",
    inventoryFull = "Your inventory is full!",
    tooFar = "You are too far from the Black Market!",
    cooldown = "Please wait before making another purchase!",
    noAccessItem = "You need %s to access this Black Market!",
    noJob = "You don't have the required job to access this Black Market!"
}

Config.KeyDropEvent = {
    enabled = true,
    itemName = "bm_key",
    spawnInterval = 60,
    despawnTime = 30,

    blip = {
        enabled = true,
        blipHash = -1282792512,
        blipColor = "BLIP_MODIFIER_MP_COLOR_1"
    },

    announcements = {
        spawn = "A Black Market Key has been dropped in %s! It will disappear in 10 minutes.",
        despawn = "The Black Market Key in %s has disappeared!",
        picked = "Someone picked up the Black Market Key in %s!"
    },

    notifications = {
        keyDropped = {
            title = "Black Market Key Dropped!",
            description = "A Black Market Key has been dropped in %s! It will disappear in 30 minutes."
        },
        keyPickedUp = {
            title = "Key Picked Up!",
            description = "Someone picked up the Black Market Key in %s!"
        },
        keyDisappeared = {
            title = "Key Disappeared!",
            description = "The Black Market Key in %s has disappeared!"
        }
    },

    spawnPoints = {
        ["Annesburg"]  = "2730.6, 1053.38, 81.3",
        ["Annesburg"]  = "2660.49, 1173.01, 122.7",
        ["Annesburg"]  = "2560.58, 1214.89, 161.77",
        ["Annesburg"]  = "2655.42, 1277.27, 117.96",
        ["Annesburg"]  = "2605.6, 1459.44, 82.07",
        ["Annesburg"]  = "2645.05, 1588.19, 130.47",
        ["Annesburg"]  = "2749.96, 1601.03, 151.81",
        ["Annesburg"]  = "3204.79, 1503.66, 49.94",
        ["Annesburg"]  = "3388.45, 1560.66, 73.47",
        ["Annesburg"] = "3097.28, 1736.77, 90.22",

        ["Van Horn"]  = "2784.25, 859.62, 72.85",
        ["Van Horn"]  = "2834.41, 787.88, 58.62",
        ["Van Horn"]  = "2650.11, 783.95, 90.36",
        ["Van Horn"]  = "2797.23, 733.13, 75.44",
        ["Van Horn"]  = "2579.7, 661.42, 82.54",
        ["Van Horn"]  = "2531.92, 640.86, 74.27",
        ["Van Horn"]  = "2571.77, 485.36, 66.63",
        ["Van Horn"]  = "2712.94, 555.96, 83.65",
        ["Van Horn"]  = "2672.07, 392.18, 81.9",
        ["Van Horn"] =  "2731.76, 411.6, 69.5",

        ["Valentine"]  = "-379.58, 999.69, 121.96",
        ["Valentine"]  = "-166.56, 1117.83, 125.02",
        ["Valentine"]  = "-33.89, 914.0, 210.05",
        ["Valentine"]  = "148.43, 971.77, 207.31",
        ["Valentine"]  = "125.55, 688.61, 145.44",
        ["Valentine"]  = "94.25, 599.05, 132.44",
        ["Valentine"]  = "-267.59, 160.0, 62.34",
        ["Valentine"]  = "-409.17, 298.31, 64.27",
        ["Valentine"]  = "-626.91, 576.91, 105.42",
        ["Valentine"] = "-134.13, 1176.95, 161.71",

        ["Rhodes"]  = "657.93, -1165.87, 45.67",
        ["Rhodes"]  = "899.49, -961.87, 61.33",
        ["Rhodes"]  = "674.97, -900.29, 44.84",
        ["Rhodes"]  = "758.5, -1433.2, 50.75",
        ["Rhodes"]  = "834.44, -478.35, 85.27",
        ["Rhodes"]  = "1124.96, -825.34, 84.13",
        ["Rhodes"]  = "1291.3, -912.92, 56.69",
        ["Rhodes"]  = "1569.6, -1181.79, 47.33",
        ["Rhodes"]  = "1346.66, -1673.54, 67.75",
        ["Rhodes"] = "1738.92, -1811.51, 51.79",

        ["Strawberry"]  = "-1973.08, -191.92, 210.32",
        ["Strawberry"]  = "-1805.82, -151.61, 230.24",
        ["Strawberry"]  = "-1872.29, -239.64, 194.48",
        ["Strawberry"]  = "-1982.03, -302.09, 191.1",
        ["Strawberry"]  = "-1669.3, -47.82, 163.05",
        ["Strawberry"]  = "-1595.43, -130.55, 144.33",
        ["Strawberry"]  = "-1622.62, -353.85, 174.09",
        ["Strawberry"]  = "-1912.41, -615.39, 131.76",
        ["Strawberry"]  = "-2118.69, -590.29, 135.11",
        ["Strawberry"] = "-2150.86, -364.25, 191.73",

        ["Blackwater"]  = "-675.73, -1589.87, 47.97",
        ["Blackwater"]  = "-729.49, -1771.74, 43.58",
        ["Blackwater"]  = "-851.57, -1944.99, 48.81",
        ["Blackwater"]  = "-1331.28, -1910.42, 59.22",
        ["Blackwater"]  = "-1457.58, -1047.26, 74.79",
        ["Blackwater"]  = "-1705.06, -1150.32, 78.22",
        ["Blackwater"]  = "-1889.75, -1395.99, 101.07",
        ["Blackwater"]  = "-1794.45, -1682.29, 105.76",
        ["Blackwater"]  = "-1722.63, -1947.23, 63.85",
        ["Blackwater"] = "-1555.53, -2001.59, 42.1",

        ["Armadillo"]  = "-3151.38, -2514.27, 73.15",
        ["Armadillo"]  = "-3314.06, -2538.15, 4.04",
        ["Armadillo"]  = "-3215.72, -2204.01, 15.72",
        ["Armadillo"]  = "-3379.41, -1919.62, -6.69",
        ["Armadillo"]  = "-3585.17, -1974.6, -3.28",
        ["Armadillo"]  = "-3621.71, -2265.62, -12.16",
        ["Armadillo"]  = "-3828.89, -2089.25, 9.01",
        ["Armadillo"]  = "-3972.89, -2731.04, -12.26",
        ["Armadillo"]  = "-3701.84, -2895.65, -4.85",
        ["Armadillo"] = "-3482.68, -2956.09, 4.45",

        ["Tumbleweed"]  = "-5340.76, -3006.25, 11.71",
        ["Tumbleweed"]  = "-5191.54, -2969.76, 12.84",
        ["Tumbleweed"]  = "-5280.57, -3285.0, -15.91",
        ["Tumbleweed"]  = "-5621.01, -3305.37, -22.21",
        ["Tumbleweed"]  = "-5819.84, -3179.21, 0.8",
        ["Tumbleweed"]  = "-5857.95, -2959.78, 3.25",
        ["Tumbleweed"]  = "-5698.84, -2746.89, -2.08",
        ["Tumbleweed"]  = "-5580.0, -2586.18, -8.16",
        ["Tumbleweed"]  = "-5415.21, -2486.83, -2.26",
        ["Tumbleweed"] = "-5407.36, -2589.23, -3.4",

        ["Saint Denis"]  = "1986.47, -1072.61, 42.08",
        ["Saint Denis"]  = "1815.73, -1124.91, 41.51",
        ["Saint Denis"]  = "1687.94, -1000.22, 41.98",
        ["Saint Denis"]  = "1687.94, -1000.22, 41.98",
        ["Saint Denis"]  = "1567.76, -892.23, 41.47",
        ["Saint Denis"]  = "1871.17, -861.21, 41.95",
        ["Saint Denis"]  = "2770.77, -596.08, 41.41",
        ["Saint Denis"]  = "2539.42, -495.22, 41.52",
        ["Saint Denis"]  = "2344.02, -579.14, 41.8",
        ["Saint Denis"] = "2211.4, -522.66, 41.51"
    }
}
