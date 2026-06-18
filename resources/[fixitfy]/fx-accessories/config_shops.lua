--  Fx-Accessories | config_shops.lua
--  Fixitfy Development
--  Accessory Shop System config.
--  Locale managed via locales.lua (Config.Locale).
-- ─────────────────────────────────────────────────────────────────────────────

--## Config.PreviewLight — fallback when a store has no previewLight defined.
Config.PreviewLight = {
    Enabled = true,
    Time = {
        AlwaysOn  = true,
        StartHour = 20,
        EndHour   = 6,
    },
    Direction = {
        Mode         = "custom",
        CustomOffset = { X = 0.0, Y = 0.0, Z = 1.2 },
    },
    Visual = {
        ColorHex  = "#ffffff",
        Range     = 2.0,
        Intensity = 20.0,
    },
}

Config.AutoRotatePreview        = false
Config.PlacementCamFov          = 45.0
Config.PlacementCamDist         = 2.2
Config.PlacementCamHeight       = 0.85
Config.PlacementCamTargetZ      = 0.35
Config.ShopPreviewZOffset       = 0.30
Config.PlacementCamAngleOffset  = 87.0

Config.HideHud = function()
    if GetResourceState("fx-hud") == "started" then
        exports["fx-hud"]:hideHud()
    end
end

Config.ShowHud = function()
    if GetResourceState("fx-hud") == "started" then
        exports["fx-hud"]:showHud()
    end
end

Config.OpenStoreKey = 0x2CD5343E  --## ENTER — full key list: https://cherrytree.at/misc/vk.htm

Config.Prompts = {
    ["store"] = {
        Label    = "Accessories Store",
        distance = 2.0,
        Keys = {
            [1] = {
                Key      = Config.OpenStoreKey or 0xC7B5340A,
                Label    = "Open Store",
                HoldTime = 700,
            },
        },
    },
}

-- ─────────────────────────────────────────────────────────────────────────────
--  Config.SeasonalEvents — Events active within a date range
--
--  seasonStore         : List of store keys to apply the discount to (keys from Config.Stores).
--  discount            : Percentage discount applied to BuyItems prices.
--  seasonItems         : Extra items shown only while the event is active.
--  sendAnnouncement    : Admin command name (e.g. /christmas → sends announcement to all players).
--  startDate / endDate : Start and end date in { month, day } format.
--  icons               : https://icon-sets.iconify.design/

Config.SeasonalEvents = {

    enabled = true,  -- false → disables the entire seasonal system

    valentines = {
        enabled          = true,   --## false = event completely disabled
        label            = "Valentines Day Event",
        desc             = "To celebrate Valentine's Day, select accessories are 20% off for one day only.. This is a test announcement for this video you can edit whatever you want here.",
        icon             = "mdi:heart",
        discountIcon     = "mdi:tag-outline",
        dateIcon         = "oui:calendar",
        announceDuration = 8,
        startDate        = { day = 2,  month = 6 },
        endDate          = { day = 30, month = 6 },
        discount         = 20,
        sendAnnouncement = "valentines",
        seasonStore      = { "blackwater", "valentine", "saintdenis" },
        seasonItems      = {
            { itemName = "testitem", itemLabel = "Proposal Ring", gender = "all", category = "Hand", moneytype = "gold", price = 20.0 },
        },
    },

    -- halloween = {
    --     enabled          = true,
    --     label            = "Halloween",
    --     desc             = "Dark accessories are back!",
    --     icon             = "mdi:halloween",
    --     announceDuration = 8,
    --     startDate        = { month = 10, day = 25 },
    --     endDate          = { month = 11, day = 1  },
    --     discount         = 15,
    --     sendAnnouncement = "halloween",
    --     seasonStore      = { "blackwater", "rhodes", "saintdenis" },
    --     seasonItems      = {},
    -- },
}

-- ─────────────────────────────────────────────────────────────────────────────
--  Config.NightMarket — Wandering Night Market (22:00–07:00 game time)
--
--  The coords list is processed in order; the NPC moves to a new coordinate each night.
--  After the last coordinate it wraps back to the first.
--  spawnChance: number 0-100. 0 = never spawns, 100 = always spawns.
--
--  BuyItems.tier         : "COMMON" | "RARE" | "LEGENDARY" | "EXCLUSIVE"
--  BuyItems.limitedStock : How many units can be sold (resets each time the NPC changes coordinate).
--
--  sendAnnouncement: When the admin types this command, an announcement is sent to all players.

Config.NightMarket = {

    enabled = true,  -- false → disables the night market system entirely

    storename        = "Night Market",  --## UI panel title
    sendAnnouncement = "nightmarket",
    label            = "Night Market",
    desc             = "The wandering merchant's cart has arrived! Limited stock, limited time. 22:00-02:00.",
    icon             = "mdi:cart-variant",
    discountIcon     = "mdi:tag-outline",
    dateIcon         = "oui:calendar",
    announceDuration = 8,

    openTimeSetting = {
        allowed      = true,                          --## true = time restriction active
        open         = 22,
        close        = 7,
        blipSprite   = -417940443,
        blipmodifier = "BLIP_MODIFIER_MP_COLOR_2",   --## blip color when closed
    },

    blip = {
        enabled = true,
        sprite  = -417940443,
        color   = "BLIP_MODIFIER_MP_COLOR_3",  -- different color: visually distinct from regular stores
        name    = "Night Market",
        scale   = 0.7,
    },

    promptitle   = "Night Market",       --## hold-prompt / ox_target label
    useTarget    = false,                --## false = RDR2 native hold-prompt | true = ox_target
    distance     = 2.0,                  --## interaction radius (metres)
    canInteract  = { func = true, error = "none" },
    requiredJobs = false,               --## false = everyone | { "job1", "job2" } = whitelist

    previewLight = {
        Enabled   = true,
        Time      = { AlwaysOn = true, StartHour = 20, EndHour = 6 },
        Direction = { Mode = "custom", CustomOffset = { X = 0.0, Y = 0.0, Z = 0.4 } },
        Visual    = { ColorHex = "#ffffff", Range = 3.5, Intensity = 22.0 },
    },

    ped = {
        enabled       = true,
        model         = "cs_cassidy",
        outfit        = 2,  --## Outfit preset: 0 = default, 1/2/3/4... = preset number
        spawnDistance = 30.0,
        scenario      = "WORLD_HUMAN_SMOKE_NERVOUS_STRESSED",
        anim          = { animDict = "", animName = "" },
    },

    preview = {
        enabled           = true,
        previewPropsCoord = vector4(-864.125732421875, -734.919189453125, 59.85603256225586, 15.99999046325683),
        camCoords         = vector3(-863.5361, -736.4968, 59.7335),
        camFov            = 45.0,
        autoRotate        = false,
    },

    wagon = {
        enabled       = false,
        spawnDistance = 80.0,
        model         = "mp005_p_collectorwagon01",
        coords        = vector4(0.0, 0.0, 0.0, 0.0),
        wagonProps    = {
            { model = "mp005_p_collectorwagon01b",     attach = true, bone = 0, offset = vector3(0,0,0), rotation = vector3(0,0,0), collision = false },
            { model = "mp005_p_collectorwagon01_draw", attach = true, bone = 0, offset = vector3(0,0,0), rotation = vector3(0,0,0), collision = false },
        },
    },

    --## Coordinate list — spawnChance is the probability of spawning at that point (0-100).
    coords = {
        {
            pos         = vector4(-861.8681, -733.9771, 59.6876, 179.2823), -- Blackwater
            spawnChance = 100,
        },
        -- {
        --     pos         = vector4(2295.2837, -1175.8193, 42.8518, 285.7056), -- Saint Denis
        --     spawnChance = 50,
        -- },
        -- {
        --     pos         = vector4(-551.3515, 396.5249, 88.1793, 45.8121), -- Valentine
        --     spawnChance = 60,
        -- },
        -- {
        --     pos         = vector4(1500.8165, -1473.6177, 72.6317, 309.1899), -- Rhodes
        --     spawnChance = 60,
        -- },
    },

    --## Low stock warning threshold: shown when stock falls to this percentage of limitedStock (0-100).
    --## Example: 30 → yellow warning when stock drops to 30% of max. The last unit is always red.
    lowStockWarning = 5,

    BuyItems = {
        --## tier: COMMON | RARE | LEGENDARY | EXCLUSIVE
        --## limitedStock: How many units can be sold at this location (resets when the coordinate changes).
        { itemName = "silverring",        itemLabel = "Silver Ring",           gender = "all",    category = "Hand", tier = "COMMON",    limitedStock = 15, price = 3.0 },
        { itemName = "goldenring",        itemLabel = "Golden Ring",           gender = "all",    category = "Hand", tier = "COMMON",    limitedStock = 10, price = 5.0 },
        { itemName = "bearclawnecklace",  itemLabel = "Bear Claw Necklace",    gender = "male",   category = "Neck", tier = "RARE",      limitedStock = 6,  price = 10.0 },
        { itemName = "redstonenecklace",  itemLabel = "Red Stone Necklace",    gender = "female", category = "Neck", tier = "RARE",      limitedStock = 5,  price = 15.0 },
        { itemName = "skullmask",         itemLabel = "Skull Mask",            gender = "male",   category = "Head", tier = "LEGENDARY", limitedStock = 3,  moneytype = "gold", price = 25.0 },
        { itemName = "marriageproposal",  itemLabel = "Proposal Ring",         gender = "all",    category = "Hand", tier = "LEGENDARY", limitedStock = 2,  moneytype = "gold", price = 50.0 },
        { itemName = "skullmaskred",      itemLabel = "Skull Mask (Red)",      gender = "all",    category = "Head", tier = "EXCLUSIVE", limitedStock = 1,  moneytype = "gold", price = 100.0 },
    },
}

--  STORES
--  ─────────────────────────────────────────────────────────────────────────
--  Each key is one store. Add a new ["key"] = {} block for a new store.
--
--  useTarget = false → RDR2 native hold prompt
--  useTarget = true  → ox_target
--
--  info.coords    — store / ped position (vector4)
--  preview.coords — prop spawn point (camera target)
--  wagon.coords   — vehicle spawn point (vector4)
--
--  Set wagon.enabled = false if no vehicle.


Config.Stores = {

    -- ─────────────────────────────────────────────────────────────────────────
    ["blackwater"] = {

        info = {
            storename  = "Blackwater Accessories Store",
            promptitle = "Accessories Store",
            useTarget  = true,
            distance   = 2.0,
            coords     = vector4(-727.4049, -1400.0812, 47.5100, 110.2443),

            blip = {
                enabled = true,
                sprite  = -417940443,
                color   = "BLIP_MODIFIER_MP_COLOR_0",
                name    = "Accessories Store",
                scale   = 0.6,
            },

            --## allowed = false: always open  |  true: restricted to open..close hours
            openTimeSetting = {
                allowed      = false,
                open         = 8,
                close        = 21,
                blipSprite   = -417940443,
                blipmodifier = "BLIP_MODIFIER_MP_COLOR_2",
            },

            canInteract  = { func = true, error = "none" },
            requiredJobs = false, --{"doctor", "hunting", "collector"},
        },

    
        previewLight = {
            Enabled   = true,
            Time      = { AlwaysOn = true, StartHour = 20, EndHour = 6 },
            Direction = { Mode = "custom", CustomOffset = { X = 0.0, Y = 0.0, Z = 0.4 } }, -- top_down | side_right | bottom_up | custom (uses CustomOffset)
            Visual    = { ColorHex = "#ffffff", Range = 3.5, Intensity = 22.0 },
        },

        ped = {
            enabled       = true,
            model         = "cs_mp_travellingsaleswoman",
            outfit        = 0,  --## Outfit preset: 0 = default, 1/2/3/4... = preset number
            spawnDistance = 30.0,
            scenario      = "WORLD_HUMAN_SMOKE_NERVOUS_STRESSED",
            anim          = { animDict = "", animName = "" },
        },

        preview = {
            enabled           = true,
            previewPropsCoord = vector4(-727.134033203125, -1404.18701171875, 47.73598556518555, -26.07616424560547),
            camCoords         = vector3(-728.2173, -1405.7424, 47.7228),
            camFov            = 50.0,
        },

        wagon = {
            enabled       = true,
            spawnDistance = 80.0,
            model         = "mp005_p_collectorwagon01",
            coords        = vector4(-726.0321044921875, -1401.2371826171875, 46.34293365478515, -24.46316528320312),
            wagonProps    = {
                { model = "mp005_p_collectorwagon01b",     attach = true, bone = 0, offset = vector3(0,0,0), rotation = vector3(0,0,0), collision = false },
                { model = "mp005_p_collectorwagon01_draw", attach = true, bone = 0, offset = vector3(0,0,0), rotation = vector3(0,0,0), collision = false },
            },
        },

        BuyItems = {
            -- HEAD (gold x5)
            { itemName = "skullmaskred",      itemLabel = "Skull Mask (Red)",        gender = "all",    category = "Head", moneytype = "gold", price = 500.0 },
            { itemName = "skullmaskmarked",   itemLabel = "Skull Mask (Marked)",     gender = "all",    category = "Head", moneytype = "gold", price = 600.0 },
            { itemName = "skullmaskgreen",    itemLabel = "Skull Mask (Green)",      gender = "all",    category = "Head", moneytype = "gold", price = 450.0 },
            { itemName = "skullmask",         itemLabel = "Skull Mask",              gender = "male",   category = "Head", moneytype = "gold", price = 400.0 },
            { itemName = "pigmask",           itemLabel = "Pig Mask",                gender = "male",   category = "Head", moneytype = "gold", price = 350.0 },
            -- HEAD (cash)
            { itemName = "pearlcrowns",       itemLabel = "Pearl Crown",             gender = "female", category = "Head", price = 9.0  },
            { itemName = "pearlearring",      itemLabel = "Pearl Earring",           gender = "female", category = "Head", price = 5.0  },
            { itemName = "greenarring",       itemLabel = "Green Earring",           gender = "female", category = "Head", price = 4.0  },
            { itemName = "ropeheadband",      itemLabel = "Rope Head Band",          gender = "male",   category = "Head", price = 4.0  },
            -- NECK
            { itemName = "pearlnecklace",     itemLabel = "Pearl Necklace",          gender = "female", category = "Neck", price = 8.0  },
            { itemName = "bluebrooch",        itemLabel = "Blue Brooch",             gender = "female", category = "Neck", price = 5.0  },
            { itemName = "jewelaryneck",      itemLabel = "Silver Necklace",         gender = "female", category = "Neck", price = 6.0  },
            { itemName = "redstonenecklace",  itemLabel = "Red Stone Necklace",      gender = "female", category = "Neck", price = 7.0  },
            { itemName = "bearclawnecklace",  itemLabel = "Bear Claw Necklace",      gender = "male",   category = "Neck", price = 6.0  },
            -- ARM
            { itemName = "largebraidedbag",   itemLabel = "Large Braided Bag",       gender = "all",    category = "Arm",  price = 6.0  },
            { itemName = "brownsmallbag",     itemLabel = "Brown Small Bag",         gender = "all",    category = "Arm",  price = 5.0  },
            -- TORSO
            { itemName = "babystroller",      itemLabel = "Baby Stroller",           gender = "all",    category = "Torso", price = 8.0  },
            { itemName = "babydoll",          itemLabel = "Baby Doll",               gender = "all",    category = "Torso", price = 7.0  },
            -- BELT
            { itemName = "hornaccessorybelt", itemLabel = "Horn Belt Accessory",     gender = "all",    category = "Belt", price = 6.0  },
            { itemName = "saddlebag",         itemLabel = "Saddle Bag",              gender = "male",   category = "Belt", price = 7.0  },
            -- HAND (all)
            { itemName = "marriageproposal",  itemLabel = "Marriage Proposal Ring",  gender = "all",    category = "Hand", price = 10.0 },
            { itemName = "goldenring",        itemLabel = "Golden Ring",             gender = "all",    category = "Hand", price = 8.0  },
            { itemName = "redstonering",      itemLabel = "Red Stone Ring",          gender = "all",    category = "Hand", price = 7.0  },
            { itemName = "goldenbracelett",   itemLabel = "Golden Bracelet",         gender = "all",    category = "Hand", price = 8.0  },
            { itemName = "photomachine",      itemLabel = "Photo Machine",           gender = "all",    category = "Hand", price = 9.0  },
            { itemName = "leatherhandbag",    itemLabel = "Leather Handbag",         gender = "all",    category = "Hand", price = 7.0  },
            { itemName = "moneybag",          itemLabel = "Money Bag",               gender = "all",    category = "Hand", price = 6.0  },
            { itemName = "redwineglass",      itemLabel = "Red Wine Glass",          gender = "all",    category = "Hand", price = 4.0  },
            { itemName = "whiteflag",         itemLabel = "White Flag",              gender = "all",    category = "Hand", price = 3.0  },
            { itemName = "brose",             itemLabel = "Red Rose",                gender = "all",    category = "Hand", price = 3.0  },
            { itemName = "candelabrum",       itemLabel = "Candelabrum",             gender = "all",    category = "Hand", price = 5.0  },
            -- HAND (female)
            { itemName = "gemstonebracelet",  itemLabel = "Gemstone Bracelet",       gender = "female", category = "Hand", price = 9.0  },
            { itemName = "goldenbracelettr",  itemLabel = "Golden Bracelet (R)",     gender = "female", category = "Hand", price = 8.0  },
            { itemName = "weddingringf",      itemLabel = "Wedding Ring",            gender = "female", category = "Hand", price = 7.0  },
            { itemName = "floweredsuitcase",  itemLabel = "Flowered Suitcase",       gender = "female", category = "Hand", price = 7.0  },
            { itemName = "smallredstonering", itemLabel = "Small Red Stone Ring",    gender = "female", category = "Hand", price = 6.0  },
            { itemName = "smallhandbag",      itemLabel = "Small Handbag",           gender = "female", category = "Hand", price = 6.0  },
            { itemName = "yellowparasol",     itemLabel = "Yellow Parasol",          gender = "female", category = "Hand", price = 6.0  },
            { itemName = "featherbracelet",   itemLabel = "Feather Bracelet",        gender = "female", category = "Hand", price = 5.0  },
            { itemName = "mirrorhand",        itemLabel = "Pocket Mirror",           gender = "female", category = "Hand", price = 4.0  },
            -- HAND (male)
            { itemName = "weddingringsilver", itemLabel = "Silver Wedding Ring",     gender = "male",   category = "Hand", price = 7.0  },
            { itemName = "brownhandbag",      itemLabel = "Brown Handbag",           gender = "male",   category = "Hand", price = 6.0  },
            { itemName = "silverring",        itemLabel = "Silver Ring",             gender = "male",   category = "Hand", price = 5.0  },
        },
    },

    -- ─────────────────────────────────────────────────────────────────────────
    ["valentine"] = {

        info = {
            storename  = "Accessories Store",
            promptitle = "Accessories Store",
            useTarget  = true,
            distance   = 2.0,
            coords     = vector4(-182.5830, 654.2992, 113.6160, 145.4085),

            blip = {
                enabled = true,
                sprite  = -417940443,
                color   = "BLIP_MODIFIER_MP_COLOR_0",
                name    = "Accessories Store",
                scale   = 0.6,
            },

            openTimeSetting = {
                allowed      = false,
                open         = 8,
                close        = 21,
                blipSprite   = -417940443,
                blipmodifier = "BLIP_MODIFIER_MP_COLOR_2",
            },

            canInteract  = { func = true, error = "none" },
            requiredJobs = false,
        },

        previewLight = {
            Enabled   = true,
            Time      = { AlwaysOn = true, StartHour = 20, EndHour = 6 },
            Direction = { Mode = "custom", CustomOffset = { X = 0.0, Y = 0.0, Z = 0.4 } }, -- top_down | side_right | bottom_up | custom (uses CustomOffset)
            Visual    = { ColorHex = "#ffffff", Range = 3.5, Intensity = 22.0 },
        },

        ped = {
            enabled       = true,
            model         = "cs_mp_travellingsaleswoman",
            outfit        = 0,  --## Outfit preset: 0 = default, 1/2/3/4... = preset number
            spawnDistance = 30.0,
            scenario      = "WORLD_HUMAN_SMOKE_NERVOUS_STRESSED",
            anim          = { animDict = "", animName = "" },
        },

        preview = {
            enabled           = true,
            previewPropsCoord = vector4(-179.40045166015625, 651.2310791015625, 113.91065216064453, 15.68494987487793),
            camCoords         = vector3(-179.2804, 650.2537, 113.7104),
            camFov            = 60.0,
        },

        wagon = {
            enabled       = true,
            spawnDistance = 80.0,
            model         = "mp005_p_collectorwagon01",
            coords        = vector4(-180.7271270751953, 654.3299560546875, 112.61045837402344, 18.99994468688965),
            wagonProps    = {
                { model = "mp005_p_collectorwagon01b",     attach = true, bone = 0, offset = vector3(0,0,0), rotation = vector3(0,0,0), collision = false },
                { model = "mp005_p_collectorwagon01_draw", attach = true, bone = 0, offset = vector3(0,0,0), rotation = vector3(0,0,0), collision = false },
            },
        },

        BuyItems = {
            -- HEAD (gold x5)
            { itemName = "skullmaskred",      itemLabel = "Skull Mask (Red)",        gender = "all",    category = "Head", moneytype = "gold", price = 500.0 },
            { itemName = "skullmaskmarked",   itemLabel = "Skull Mask (Marked)",     gender = "all",    category = "Head", moneytype = "gold", price = 600.0 },
            { itemName = "skullmaskgreen",    itemLabel = "Skull Mask (Green)",      gender = "all",    category = "Head", moneytype = "gold", price = 450.0 },
            { itemName = "skullmask",         itemLabel = "Skull Mask",              gender = "male",   category = "Head", moneytype = "gold", price = 400.0 },
            { itemName = "pigmask",           itemLabel = "Pig Mask",                gender = "male",   category = "Head", moneytype = "gold", price = 350.0 },
            -- HEAD (cash)
            { itemName = "pearlcrowns",       itemLabel = "Pearl Crown",             gender = "female", category = "Head", price = 9.0  },
            { itemName = "pearlearring",      itemLabel = "Pearl Earring",           gender = "female", category = "Head", price = 5.0  },
            { itemName = "greenarring",       itemLabel = "Green Earring",           gender = "female", category = "Head", price = 4.0  },
            { itemName = "ropeheadband",      itemLabel = "Rope Head Band",          gender = "male",   category = "Head", price = 4.0  },
            -- NECK
            { itemName = "pearlnecklace",     itemLabel = "Pearl Necklace",          gender = "female", category = "Neck", price = 8.0  },
            { itemName = "bluebrooch",        itemLabel = "Blue Brooch",             gender = "female", category = "Neck", price = 5.0  },
            { itemName = "jewelaryneck",      itemLabel = "Silver Necklace",         gender = "female", category = "Neck", price = 6.0  },
            { itemName = "redstonenecklace",  itemLabel = "Red Stone Necklace",      gender = "female", category = "Neck", price = 7.0  },
            { itemName = "bearclawnecklace",  itemLabel = "Bear Claw Necklace",      gender = "male",   category = "Neck", price = 6.0  },
            -- ARM
            { itemName = "largebraidedbag",   itemLabel = "Large Braided Bag",       gender = "all",    category = "Arm",  price = 6.0  },
            { itemName = "brownsmallbag",     itemLabel = "Brown Small Bag",         gender = "all",    category = "Arm",  price = 5.0  },
            -- TORSO
            { itemName = "babystroller",      itemLabel = "Baby Stroller",           gender = "all",    category = "Torso", price = 8.0  },
            { itemName = "babydoll",          itemLabel = "Baby Doll",               gender = "all",    category = "Torso", price = 7.0  },
            -- BELT
            { itemName = "hornaccessorybelt", itemLabel = "Horn Belt Accessory",     gender = "all",    category = "Belt", price = 6.0  },
            { itemName = "saddlebag",         itemLabel = "Saddle Bag",              gender = "male",   category = "Belt", price = 7.0  },
            -- HAND (all)
            { itemName = "marriageproposal",  itemLabel = "Marriage Proposal Ring",  gender = "all",    category = "Hand", price = 10.0 },
            { itemName = "goldenring",        itemLabel = "Golden Ring",             gender = "all",    category = "Hand", price = 8.0  },
            { itemName = "redstonering",      itemLabel = "Red Stone Ring",          gender = "all",    category = "Hand", price = 7.0  },
            { itemName = "goldenbracelett",   itemLabel = "Golden Bracelet",         gender = "all",    category = "Hand", price = 8.0  },
            { itemName = "photomachine",      itemLabel = "Photo Machine",           gender = "all",    category = "Hand", price = 9.0  },
            { itemName = "leatherhandbag",    itemLabel = "Leather Handbag",         gender = "all",    category = "Hand", price = 7.0  },
            { itemName = "moneybag",          itemLabel = "Money Bag",               gender = "all",    category = "Hand", price = 6.0  },
            { itemName = "redwineglass",      itemLabel = "Red Wine Glass",          gender = "all",    category = "Hand", price = 4.0  },
            { itemName = "whiteflag",         itemLabel = "White Flag",              gender = "all",    category = "Hand", price = 3.0  },
            { itemName = "brose",             itemLabel = "Red Rose",                gender = "all",    category = "Hand", price = 3.0  },
            { itemName = "candelabrum",       itemLabel = "Candelabrum",             gender = "all",    category = "Hand", price = 5.0  },
            -- HAND (female)
            { itemName = "gemstonebracelet",  itemLabel = "Gemstone Bracelet",       gender = "female", category = "Hand", price = 9.0  },
            { itemName = "goldenbracelettr",  itemLabel = "Golden Bracelet (R)",     gender = "female", category = "Hand", price = 8.0  },
            { itemName = "weddingringf",      itemLabel = "Wedding Ring",            gender = "female", category = "Hand", price = 7.0  },
            { itemName = "floweredsuitcase",  itemLabel = "Flowered Suitcase",       gender = "female", category = "Hand", price = 7.0  },
            { itemName = "smallredstonering", itemLabel = "Small Red Stone Ring",    gender = "female", category = "Hand", price = 6.0  },
            { itemName = "smallhandbag",      itemLabel = "Small Handbag",           gender = "female", category = "Hand", price = 6.0  },
            { itemName = "yellowparasol",     itemLabel = "Yellow Parasol",          gender = "female", category = "Hand", price = 6.0  },
            { itemName = "featherbracelet",   itemLabel = "Feather Bracelet",        gender = "female", category = "Hand", price = 5.0  },
            { itemName = "mirrorhand",        itemLabel = "Pocket Mirror",           gender = "female", category = "Hand", price = 4.0  },
            -- HAND (male)
            { itemName = "weddingringsilver", itemLabel = "Silver Wedding Ring",     gender = "male",   category = "Hand", price = 7.0  },
            { itemName = "brownhandbag",      itemLabel = "Brown Handbag",           gender = "male",   category = "Hand", price = 6.0  },
            { itemName = "silverring",        itemLabel = "Silver Ring",             gender = "male",   category = "Hand", price = 5.0  },
        },
    },

    -- ─────────────────────────────────────────────────────────────────────────
    ["strawberry"] = {

        info = {
            storename  = "Accessories Store",
            promptitle = "Accessories Store",
            useTarget  = true,
            distance   = 2.0,
            coords     = vector4(-1751.0306, -405.3857, 155.4906, 354.2188),

            blip = {
                enabled = true,
                sprite  = -417940443,
                color   = "BLIP_MODIFIER_MP_COLOR_0",
                name    = "Accessories Store",
                scale   = 0.6,
            },

            openTimeSetting = {
                allowed      = false,
                open         = 8,
                close        = 21,
                blipSprite   = -417940443,
                blipmodifier = "BLIP_MODIFIER_MP_COLOR_2",
            },

            canInteract  = { func = true, error = "none" },
            requiredJobs = false,
        },

        previewLight = {
            Enabled   = true,
            Time      = { AlwaysOn = true, StartHour = 20, EndHour = 6 },
            Direction = { Mode = "custom", CustomOffset = { X = 0.0, Y = 0.0, Z = 0.4 } }, -- top_down | side_right | bottom_up | custom (uses CustomOffset)
            Visual    = { ColorHex = "#ffffff", Range = 3.5, Intensity = 22.0 },
        },

        ped = {
            enabled       = true,
            model         = "cs_mp_travellingsaleswoman",
            outfit        = 0,  --## Outfit preset: 0 = default, 1/2/3/4... = preset number
            spawnDistance = 30.0,
            scenario      = "WORLD_HUMAN_SMOKE_NERVOUS_STRESSED",
            anim          = { animDict = "", animName = "" },
        },

        preview = {
            enabled           = true,
            previewPropsCoord = vector4(-1754.6026611328125, -405.9210510253906, 155.79280395507812, -117.22166442871094),
            camCoords         = vector3(-1756.3263, -405.1112, 156.3065),
            camFov            = 40.0,
        },

        wagon = {
            enabled       = true,
            spawnDistance = 80.0,
            model         = "mp005_p_collectorwagon01",
            coords        = vector4(-1751.572998046875, -407.0554504394531, 154.46951293945312, -113.68920135498047),
            wagonProps    = {
                { model = "mp005_p_collectorwagon01b",     attach = true, bone = 0, offset = vector3(0,0,0), rotation = vector3(0,0,0), collision = false },
                { model = "mp005_p_collectorwagon01_draw", attach = true, bone = 0, offset = vector3(0,0,0), rotation = vector3(0,0,0), collision = false },
            },
        }, 

        BuyItems = {
            -- HEAD (gold x5)
            { itemName = "skullmaskred",      itemLabel = "Skull Mask (Red)",        gender = "all",    category = "Head", moneytype = "gold", price = 500.0 },
            { itemName = "skullmaskmarked",   itemLabel = "Skull Mask (Marked)",     gender = "all",    category = "Head", moneytype = "gold", price = 600.0 },
            { itemName = "skullmaskgreen",    itemLabel = "Skull Mask (Green)",      gender = "all",    category = "Head", moneytype = "gold", price = 450.0 },
            { itemName = "skullmask",         itemLabel = "Skull Mask",              gender = "male",   category = "Head", moneytype = "gold", price = 400.0 },
            { itemName = "pigmask",           itemLabel = "Pig Mask",                gender = "male",   category = "Head", moneytype = "gold", price = 350.0 },
            -- HEAD (cash)
            { itemName = "pearlcrowns",       itemLabel = "Pearl Crown",             gender = "female", category = "Head", price = 9.0  },
            { itemName = "pearlearring",      itemLabel = "Pearl Earring",           gender = "female", category = "Head", price = 5.0  },
            { itemName = "greenarring",       itemLabel = "Green Earring",           gender = "female", category = "Head", price = 4.0  },
            { itemName = "ropeheadband",      itemLabel = "Rope Head Band",          gender = "male",   category = "Head", price = 4.0  },
            -- NECK
            { itemName = "pearlnecklace",     itemLabel = "Pearl Necklace",          gender = "female", category = "Neck", price = 8.0  },
            { itemName = "bluebrooch",        itemLabel = "Blue Brooch",             gender = "female", category = "Neck", price = 5.0  },
            { itemName = "jewelaryneck",      itemLabel = "Silver Necklace",         gender = "female", category = "Neck", price = 6.0  },
            { itemName = "redstonenecklace",  itemLabel = "Red Stone Necklace",      gender = "female", category = "Neck", price = 7.0  },
            { itemName = "bearclawnecklace",  itemLabel = "Bear Claw Necklace",      gender = "male",   category = "Neck", price = 6.0  },
            -- ARM
            { itemName = "largebraidedbag",   itemLabel = "Large Braided Bag",       gender = "all",    category = "Arm",  price = 6.0  },
            { itemName = "brownsmallbag",     itemLabel = "Brown Small Bag",         gender = "all",    category = "Arm",  price = 5.0  },
            -- TORSO
            { itemName = "babystroller",      itemLabel = "Baby Stroller",           gender = "all",    category = "Torso", price = 8.0  },
            { itemName = "babydoll",          itemLabel = "Baby Doll",               gender = "all",    category = "Torso", price = 7.0  },
            -- BELT
            { itemName = "hornaccessorybelt", itemLabel = "Horn Belt Accessory",     gender = "all",    category = "Belt", price = 6.0  },
            { itemName = "saddlebag",         itemLabel = "Saddle Bag",              gender = "male",   category = "Belt", price = 7.0  },
            -- HAND (all)
            { itemName = "marriageproposal",  itemLabel = "Marriage Proposal Ring",  gender = "all",    category = "Hand", price = 10.0 },
            { itemName = "goldenring",        itemLabel = "Golden Ring",             gender = "all",    category = "Hand", price = 8.0  },
            { itemName = "redstonering",      itemLabel = "Red Stone Ring",          gender = "all",    category = "Hand", price = 7.0  },
            { itemName = "goldenbracelett",   itemLabel = "Golden Bracelet",         gender = "all",    category = "Hand", price = 8.0  },
            { itemName = "photomachine",      itemLabel = "Photo Machine",           gender = "all",    category = "Hand", price = 9.0  },
            { itemName = "leatherhandbag",    itemLabel = "Leather Handbag",         gender = "all",    category = "Hand", price = 7.0  },
            { itemName = "moneybag",          itemLabel = "Money Bag",               gender = "all",    category = "Hand", price = 6.0  },
            { itemName = "redwineglass",      itemLabel = "Red Wine Glass",          gender = "all",    category = "Hand", price = 4.0  },
            { itemName = "whiteflag",         itemLabel = "White Flag",              gender = "all",    category = "Hand", price = 3.0  },
            { itemName = "brose",             itemLabel = "Red Rose",                gender = "all",    category = "Hand", price = 3.0  },
            { itemName = "candelabrum",       itemLabel = "Candelabrum",             gender = "all",    category = "Hand", price = 5.0  },
            -- HAND (female)
            { itemName = "gemstonebracelet",  itemLabel = "Gemstone Bracelet",       gender = "female", category = "Hand", price = 9.0  },
            { itemName = "goldenbracelettr",  itemLabel = "Golden Bracelet (R)",     gender = "female", category = "Hand", price = 8.0  },
            { itemName = "weddingringf",      itemLabel = "Wedding Ring",            gender = "female", category = "Hand", price = 7.0  },
            { itemName = "floweredsuitcase",  itemLabel = "Flowered Suitcase",       gender = "female", category = "Hand", price = 7.0  },
            { itemName = "smallredstonering", itemLabel = "Small Red Stone Ring",    gender = "female", category = "Hand", price = 6.0  },
            { itemName = "smallhandbag",      itemLabel = "Small Handbag",           gender = "female", category = "Hand", price = 6.0  },
            { itemName = "yellowparasol",     itemLabel = "Yellow Parasol",          gender = "female", category = "Hand", price = 6.0  },
            { itemName = "featherbracelet",   itemLabel = "Feather Bracelet",        gender = "female", category = "Hand", price = 5.0  },
            { itemName = "mirrorhand",        itemLabel = "Pocket Mirror",           gender = "female", category = "Hand", price = 4.0  },
            -- HAND (male)
            { itemName = "weddingringsilver", itemLabel = "Silver Wedding Ring",     gender = "male",   category = "Hand", price = 7.0  },
            { itemName = "brownhandbag",      itemLabel = "Brown Handbag",           gender = "male",   category = "Hand", price = 6.0  },
            { itemName = "silverring",        itemLabel = "Silver Ring",             gender = "male",   category = "Hand", price = 5.0  },
        },
    },

    -- ─────────────────────────────────────────────────────────────────────────
    ["rhodes"] = {

        info = {
            storename  = "Accessories Store",
            promptitle = "Accessories Store",
            useTarget  = true,
            distance   = 2.0,
            coords     = vector4(1330.4014, -1292.7606, 77.0210, 61.9213),

            blip = {
                enabled = true,
                sprite  = -417940443,
                color   = "BLIP_MODIFIER_MP_COLOR_0",
                name    = "Accessories Store",
                scale   = 0.6,
            },

            openTimeSetting = {
                allowed      = false,
                open         = 8,
                close        = 21,
                blipSprite   = -417940443,
                blipmodifier = "BLIP_MODIFIER_MP_COLOR_2",
            },

            canInteract  = { func = true, error = "none" },
            requiredJobs = false,
        },

        previewLight = {
            Enabled   = true,
            Time      = { AlwaysOn = true, StartHour = 20, EndHour = 6 },
            Direction = { Mode = "custom", CustomOffset = { X = 0.0, Y = 0.0, Z = 0.4 } }, -- top_down | side_right | bottom_up | custom (uses CustomOffset)
            Visual    = { ColorHex = "#ffffff", Range = 3.5, Intensity = 22.0 },
        },

        ped = {
            enabled       = true,
            model         = "cs_mp_travellingsaleswoman",
            outfit        = 0,  --## Outfit preset: 0 = default, 1/2/3/4... = preset number
            spawnDistance = 30.0,
            scenario      = "WORLD_HUMAN_SMOKE_NERVOUS_STRESSED",
            anim          = { animDict = "", animName = "" },
        },

        preview = {
            enabled           = true,
            previewPropsCoord = vector4(1331.9014, -1294.7606, 77.3210, 61.9213),
            camCoords         = vector3(1330.9014, -1296.2606, 77.8210),
            camFov            = 40.0,
        },

        wagon = {
            enabled       = false,
            spawnDistance = 80.0,
            model         = "mp005_p_collectorwagon01",
            coords        = vector4(1302.6114501953125, -1172.613525390625, 79.70960998535156, -12.99999141693115),
            wagonProps    = {
                { model = "mp005_p_collectorwagon01b",     attach = true, bone = 0, offset = vector3(0,0,0), rotation = vector3(0,0,0), collision = false },
                { model = "mp005_p_collectorwagon01_draw", attach = true, bone = 0, offset = vector3(0,0,0), rotation = vector3(0,0,0), collision = false },
            },
        },

        BuyItems = {
            -- HEAD (gold x5)
            { itemName = "skullmaskred",      itemLabel = "Skull Mask (Red)",        gender = "all",    category = "Head", moneytype = "gold", price = 500.0 },
            { itemName = "skullmaskmarked",   itemLabel = "Skull Mask (Marked)",     gender = "all",    category = "Head", moneytype = "gold", price = 600.0 },
            { itemName = "skullmaskgreen",    itemLabel = "Skull Mask (Green)",      gender = "all",    category = "Head", moneytype = "gold", price = 450.0 },
            { itemName = "skullmask",         itemLabel = "Skull Mask",              gender = "male",   category = "Head", moneytype = "gold", price = 400.0 },
            { itemName = "pigmask",           itemLabel = "Pig Mask",                gender = "male",   category = "Head", moneytype = "gold", price = 350.0 },
            -- HEAD (cash)
            { itemName = "pearlcrowns",       itemLabel = "Pearl Crown",             gender = "female", category = "Head", price = 9.0  },
            { itemName = "pearlearring",      itemLabel = "Pearl Earring",           gender = "female", category = "Head", price = 5.0  },
            { itemName = "greenarring",       itemLabel = "Green Earring",           gender = "female", category = "Head", price = 4.0  },
            { itemName = "ropeheadband",      itemLabel = "Rope Head Band",          gender = "male",   category = "Head", price = 4.0  },
            -- NECK
            { itemName = "pearlnecklace",     itemLabel = "Pearl Necklace",          gender = "female", category = "Neck", price = 8.0  },
            { itemName = "bluebrooch",        itemLabel = "Blue Brooch",             gender = "female", category = "Neck", price = 5.0  },
            { itemName = "jewelaryneck",      itemLabel = "Silver Necklace",         gender = "female", category = "Neck", price = 6.0  },
            { itemName = "redstonenecklace",  itemLabel = "Red Stone Necklace",      gender = "female", category = "Neck", price = 7.0  },
            { itemName = "bearclawnecklace",  itemLabel = "Bear Claw Necklace",      gender = "male",   category = "Neck", price = 6.0  },
            -- ARM
            { itemName = "largebraidedbag",   itemLabel = "Large Braided Bag",       gender = "all",    category = "Arm",  price = 6.0  },
            { itemName = "brownsmallbag",     itemLabel = "Brown Small Bag",         gender = "all",    category = "Arm",  price = 5.0  },
            -- TORSO
            { itemName = "babystroller",      itemLabel = "Baby Stroller",           gender = "all",    category = "Torso", price = 8.0  },
            { itemName = "babydoll",          itemLabel = "Baby Doll",               gender = "all",    category = "Torso", price = 7.0  },
            -- BELT
            { itemName = "hornaccessorybelt", itemLabel = "Horn Belt Accessory",     gender = "all",    category = "Belt", price = 6.0  },
            { itemName = "saddlebag",         itemLabel = "Saddle Bag",              gender = "male",   category = "Belt", price = 7.0  },
            -- HAND (all)
            { itemName = "marriageproposal",  itemLabel = "Marriage Proposal Ring",  gender = "all",    category = "Hand", price = 10.0 },
            { itemName = "goldenring",        itemLabel = "Golden Ring",             gender = "all",    category = "Hand", price = 8.0  },
            { itemName = "redstonering",      itemLabel = "Red Stone Ring",          gender = "all",    category = "Hand", price = 7.0  },
            { itemName = "goldenbracelett",   itemLabel = "Golden Bracelet",         gender = "all",    category = "Hand", price = 8.0  },
            { itemName = "photomachine",      itemLabel = "Photo Machine",           gender = "all",    category = "Hand", price = 9.0  },
            { itemName = "leatherhandbag",    itemLabel = "Leather Handbag",         gender = "all",    category = "Hand", price = 7.0  },
            { itemName = "moneybag",          itemLabel = "Money Bag",               gender = "all",    category = "Hand", price = 6.0  },
            { itemName = "redwineglass",      itemLabel = "Red Wine Glass",          gender = "all",    category = "Hand", price = 4.0  },
            { itemName = "whiteflag",         itemLabel = "White Flag",              gender = "all",    category = "Hand", price = 3.0  },
            { itemName = "brose",             itemLabel = "Red Rose",                gender = "all",    category = "Hand", price = 3.0  },
            { itemName = "candelabrum",       itemLabel = "Candelabrum",             gender = "all",    category = "Hand", price = 5.0  },
            -- HAND (female)
            { itemName = "gemstonebracelet",  itemLabel = "Gemstone Bracelet",       gender = "female", category = "Hand", price = 9.0  },
            { itemName = "goldenbracelettr",  itemLabel = "Golden Bracelet (R)",     gender = "female", category = "Hand", price = 8.0  },
            { itemName = "weddingringf",      itemLabel = "Wedding Ring",            gender = "female", category = "Hand", price = 7.0  },
            { itemName = "floweredsuitcase",  itemLabel = "Flowered Suitcase",       gender = "female", category = "Hand", price = 7.0  },
            { itemName = "smallredstonering", itemLabel = "Small Red Stone Ring",    gender = "female", category = "Hand", price = 6.0  },
            { itemName = "smallhandbag",      itemLabel = "Small Handbag",           gender = "female", category = "Hand", price = 6.0  },
            { itemName = "yellowparasol",     itemLabel = "Yellow Parasol",          gender = "female", category = "Hand", price = 6.0  },
            { itemName = "featherbracelet",   itemLabel = "Feather Bracelet",        gender = "female", category = "Hand", price = 5.0  },
            { itemName = "mirrorhand",        itemLabel = "Pocket Mirror",           gender = "female", category = "Hand", price = 4.0  },
            -- HAND (male)
            { itemName = "weddingringsilver", itemLabel = "Silver Wedding Ring",     gender = "male",   category = "Hand", price = 7.0  },
            { itemName = "brownhandbag",      itemLabel = "Brown Handbag",           gender = "male",   category = "Hand", price = 6.0  },
            { itemName = "silverring",        itemLabel = "Silver Ring",             gender = "male",   category = "Hand", price = 5.0  },
        },
    },
    -- ─────────────────────────────────────────────────────────────────────────
    ["saintdenis"] = {

        info = {
            storename  = "Accessories Store",
            promptitle = "Accessories Store",
            useTarget  = true,
            distance   = 2.0,
            coords     = vector4(2344.8582, -1104.1068, 46.2412, 180.7763),

            blip = {
                enabled = true,
                sprite  = -417940443,
                color   = "BLIP_MODIFIER_MP_COLOR_0",
                name    = "Accessories Store",
                scale   = 0.6,
            },

            openTimeSetting = {
                allowed      = false,
                open         = 8,
                close        = 21,
                blipSprite   = -417940443,
                blipmodifier = "BLIP_MODIFIER_MP_COLOR_2",
            },

            canInteract  = { func = true, error = "none" },
            requiredJobs = false,
        },

        previewLight = {
            Enabled   = true,
            Time      = { AlwaysOn = true, StartHour = 20, EndHour = 6 },
            Direction = { Mode = "custom", CustomOffset = { X = 0.0, Y = 0.0, Z = 0.4 } }, -- top_down | side_right | bottom_up | custom (uses CustomOffset)
            Visual    = { ColorHex = "#ffffff", Range = 3.5, Intensity = 22.0 },
        },

        ped = {
            enabled       = true,
            model         = "cs_mp_travellingsaleswoman",
            outfit        = 0,  --## Outfit preset: 0 = default, 1/2/3/4... = preset number
            spawnDistance = 30.0,
            scenario      = "WORLD_HUMAN_SMOKE_NERVOUS_STRESSED",
            anim          = { animDict = "", animName = "" },
        },

        preview = {
            enabled           = true,
            previewPropsCoord = vector4(2348.73828125, -1103.7918701171875, 46.70667572021484, 57.45610809326172),
            camCoords         = vector3(2350.4697, -1106.2122, 46.5906),
            camFov            = 50.0,
        },

        wagon = {
            enabled       = true,
            spawnDistance = 80.0,
            model         = "mp005_p_collectorwagon01",
            coords        = vector4(2345.967041015625, -1102.2598876953125, 45.1799201965332, 56.69422149658203),
            wagonProps    = {
                { model = "mp005_p_collectorwagon01b",     attach = true, bone = 0, offset = vector3(0,0,0), rotation = vector3(0,0,0), collision = false },
                { model = "mp005_p_collectorwagon01_draw", attach = true, bone = 0, offset = vector3(0,0,0), rotation = vector3(0,0,0), collision = false },
            },
        },

        BuyItems = {
            -- HEAD (gold x5)
            { itemName = "skullmaskred",      itemLabel = "Skull Mask (Red)",        gender = "all",    category = "Head", moneytype = "gold", price = 500.0 },
            { itemName = "skullmaskmarked",   itemLabel = "Skull Mask (Marked)",     gender = "all",    category = "Head", moneytype = "gold", price = 600.0 },
            { itemName = "skullmaskgreen",    itemLabel = "Skull Mask (Green)",      gender = "all",    category = "Head", moneytype = "gold", price = 450.0 },
            { itemName = "skullmask",         itemLabel = "Skull Mask",              gender = "male",   category = "Head", moneytype = "gold", price = 400.0 },
            { itemName = "pigmask",           itemLabel = "Pig Mask",                gender = "male",   category = "Head", moneytype = "gold", price = 350.0 },
            -- HEAD (cash)
            { itemName = "pearlcrowns",       itemLabel = "Pearl Crown",             gender = "female", category = "Head", price = 9.0  },
            { itemName = "pearlearring",      itemLabel = "Pearl Earring",           gender = "female", category = "Head", price = 5.0  },
            { itemName = "greenarring",       itemLabel = "Green Earring",           gender = "female", category = "Head", price = 4.0  },
            { itemName = "ropeheadband",      itemLabel = "Rope Head Band",          gender = "male",   category = "Head", price = 4.0  },
            -- NECK
            { itemName = "pearlnecklace",     itemLabel = "Pearl Necklace",          gender = "female", category = "Neck", price = 8.0  },
            { itemName = "bluebrooch",        itemLabel = "Blue Brooch",             gender = "female", category = "Neck", price = 5.0  },
            { itemName = "jewelaryneck",      itemLabel = "Silver Necklace",         gender = "female", category = "Neck", price = 6.0  },
            { itemName = "redstonenecklace",  itemLabel = "Red Stone Necklace",      gender = "female", category = "Neck", price = 7.0  },
            { itemName = "bearclawnecklace",  itemLabel = "Bear Claw Necklace",      gender = "male",   category = "Neck", price = 6.0  },
            -- ARM
            { itemName = "largebraidedbag",   itemLabel = "Large Braided Bag",       gender = "all",    category = "Arm",  price = 6.0  },
            { itemName = "brownsmallbag",     itemLabel = "Brown Small Bag",         gender = "all",    category = "Arm",  price = 5.0  },
            -- TORSO
            { itemName = "babystroller",      itemLabel = "Baby Stroller",           gender = "all",    category = "Torso", price = 8.0  },
            { itemName = "babydoll",          itemLabel = "Baby Doll",               gender = "all",    category = "Torso", price = 7.0  },
            -- BELT
            { itemName = "hornaccessorybelt", itemLabel = "Horn Belt Accessory",     gender = "all",    category = "Belt", price = 6.0  },
            { itemName = "saddlebag",         itemLabel = "Saddle Bag",              gender = "male",   category = "Belt", price = 7.0  },
            -- HAND (all)
            { itemName = "marriageproposal",  itemLabel = "Marriage Proposal Ring",  gender = "all",    category = "Hand", price = 10.0 },
            { itemName = "goldenring",        itemLabel = "Golden Ring",             gender = "all",    category = "Hand", price = 8.0  },
            { itemName = "redstonering",      itemLabel = "Red Stone Ring",          gender = "all",    category = "Hand", price = 7.0  },
            { itemName = "goldenbracelett",   itemLabel = "Golden Bracelet",         gender = "all",    category = "Hand", price = 8.0  },
            { itemName = "photomachine",      itemLabel = "Photo Machine",           gender = "all",    category = "Hand", price = 9.0  },
            { itemName = "leatherhandbag",    itemLabel = "Leather Handbag",         gender = "all",    category = "Hand", price = 7.0  },
            { itemName = "moneybag",          itemLabel = "Money Bag",               gender = "all",    category = "Hand", price = 6.0  },
            { itemName = "redwineglass",      itemLabel = "Red Wine Glass",          gender = "all",    category = "Hand", price = 4.0  },
            { itemName = "whiteflag",         itemLabel = "White Flag",              gender = "all",    category = "Hand", price = 3.0  },
            { itemName = "brose",             itemLabel = "Red Rose",                gender = "all",    category = "Hand", price = 3.0  },
            { itemName = "candelabrum",       itemLabel = "Candelabrum",             gender = "all",    category = "Hand", price = 5.0  },
            -- HAND (female)
            { itemName = "gemstonebracelet",  itemLabel = "Gemstone Bracelet",       gender = "female", category = "Hand", price = 9.0  },
            { itemName = "goldenbracelettr",  itemLabel = "Golden Bracelet (R)",     gender = "female", category = "Hand", price = 8.0  },
            { itemName = "weddingringf",      itemLabel = "Wedding Ring",            gender = "female", category = "Hand", price = 7.0  },
            { itemName = "floweredsuitcase",  itemLabel = "Flowered Suitcase",       gender = "female", category = "Hand", price = 7.0  },
            { itemName = "smallredstonering", itemLabel = "Small Red Stone Ring",    gender = "female", category = "Hand", price = 6.0  },
            { itemName = "smallhandbag",      itemLabel = "Small Handbag",           gender = "female", category = "Hand", price = 6.0  },
            { itemName = "yellowparasol",     itemLabel = "Yellow Parasol",          gender = "female", category = "Hand", price = 6.0  },
            { itemName = "featherbracelet",   itemLabel = "Feather Bracelet",        gender = "female", category = "Hand", price = 5.0  },
            { itemName = "mirrorhand",        itemLabel = "Pocket Mirror",           gender = "female", category = "Hand", price = 4.0  },
            -- HAND (male)
            { itemName = "weddingringsilver", itemLabel = "Silver Wedding Ring",     gender = "male",   category = "Hand", price = 7.0  },
            { itemName = "brownhandbag",      itemLabel = "Brown Handbag",           gender = "male",   category = "Hand", price = 6.0  },
            { itemName = "silverring",        itemLabel = "Silver Ring",             gender = "male",   category = "Hand", price = 5.0  },
        },
    },

}

