Config = {}


---------------------------------
-- Webhook
---------------------------------
---
Config.UrlIcon           = 'https://i.postimg.cc/mDfmzj3D/Gemini-Generated-Image-b28dslb28dslb28d.png'
Config.UrlIconThumb      = 'https://i.postimg.cc/mDfmzj3D/Gemini-Generated-Image-b28dslb28dslb28d.png'
Config.WebhookColor      = 3037669 -- Decimal Color
Config.WebhookUrl        = ''
---------------------------------
-- General
---------------------------------

Config.Locale            = 'en-us'                      -- 'en-us' or 'pt-br'
Config.MenuStyle         = 'default'                    -- 'default' = native RedM menu; 'other' = custom btc-core UI
Config.Debug             = false
Config.DisableRealWeight = false                        -- if true, animals can reach max weight regardless of current age
Config.UnemployedJob     = 'unemployed'                 -- job name used for players without a job
Config.AllowSelfResign   = true                         -- if false, employees cannot resign from the ranch by themselves
Config.TaxIntervalDays = 7      -- interval in days for tax collection
Config.TaxAmount       = 500    -- amount to collect each cycle; set to 0 to disable taxes
Config.TaxCurrencyType = 'cash' -- 'cash' or 'gold' — also defines the currency accepted at the ranch cash box

---------------------------------
-- btc-houses Compatibility
---------------------------------
-- Only works if the btc-houses resource is active on the server.

Config.BtcHousesCompat = {
    Enabled = false, -- master toggle; enables all options below

    -- If true: the player can only buy a ranch if they already own the farm
    -- btc-houses linked to it (house.ranchId). Ensures that the purchase via
    -- the btc-ranchman menu does not bypass the ownership requirement.
    RequireHouseOwnership = true,

    -- If true: ranches whose ranchId is linked to a farm in btc-houses
    -- DO NOT show the purchase/id prompt in the world. The purchase only occurs through
    -- the btc-houses panel. On startup, validates that ranch owners also
    -- own the btc-houses property - if not, the ranch is removed.
    HidePromptIfLinked = true,
}

Config.Keys            = {
    openRanch = 'INPUT_CREATOR_ACCEPT',
    storeAnimal = 'INPUT_RELOAD',
    openAnimalStore = 'INPUT_INTERACT_OPTION1',
    sellAnimal = 'INPUT_RELOAD',
    followMe = 'INPUT_CREATOR_ACCEPT',
    feedingAnimal = 'INPUT_RELOAD',
    carryAnimal     = 'INPUT_INTERACT_OPTION1',
    slaughterhouse  = 'INPUT_INTERACT_OPTION1',
}


Config.Chores          = {
    TickRateInMinutes = 15, -- Every X minutes your ranch loses quality (recommended 15)
    poop = {
        increase = 15,
        decrease = 1.5,
        time = 20,   -- time is the duration of the task animation
        needItem = { -- needItem false or table =  { [1] = { itemName = 'fullbucket', qnt = 1}}
            [1] = { itemName = 'shovel', qnt = 1, removeItem = false, degradation = 0.1 },
        },
        returnItem = {                                       -- returnItem false or table = { [1] = { itemName = 'emptyBucket', qnt = 1}}
            [1] = { itemName = 'fertilizer', qnt = { 1, 3 }, -- 1 = qntMin and 3 = qntMax (is random)
            }
        }
    },
    hay = {
        increase = 20,
        decrease = 1.0,
        time = 20,
        needItem = { -- needItem false or table =  { [1] = { itemName = 'fullbucket', qnt = 1}}
            [1] = { itemName = 'rake', qnt = 1, removeItem = false, degradation = 0.1 },
        },
        returnItem = false, -- returnItem false or table = { [1] = { itemName = 'emptyBucket', qnt = 1}}
    },
    repair = {
        increase = 25,
        decrease = 0.5,
        time = 20,   -- time is the duration of the task animation
        needItem = { -- needItem false or table =  { [1] = { itemName = 'fullbucket', qnt = 1}}
            [1] = { itemName = 'hammer', qnt = 1, removeItem = false, degradation = 0.1 },
            [2] = { itemName = 'nails', qnt = 1, removeItem = true },
            [3] = { itemName = 'wood', qnt = 1, removeItem = true },
        },
        returnItem = false, -- returnItem false or table = { [1] = { itemName = 'emptyBucket', qnt = 1}}
    },
    water = {
        increase = 25,
        decrease = 2.0,
        needItem = { [1] = { itemName = 'fullbucket', qnt = 1, removeItem = true } }, -- needItem false or table =  { [1] = { itemName = 'fullbucket', qnt = 1}}
        returnItem = { [1] = { itemName = 'bucket', qnt = 1 } },                      -- returnItem false or table = { [1] = { itemName = 'emptyBucket', qnt = 1}}
    }
}


---------------------------------
-- Items
---------------------------------

Config.UseBrandingIron   = true
Config.Items                   = {
    sick = {
        item = 'consumable_herb_bay_bolete', -- item that improves the animal's health
        rate = 5,                            -- how much health an item gives to the animal
    },
    fertility = {
        item = 'consumable_herb_red_sage', -- item that improves fertility
        rate = 5,                          -- how much fertility an item gives to the animal
    },
    ranch = {
        create = 'ranchdocument',
        delete = 'ranchdelete',
    },
    brandingIron = {
        item = 'bread',
        degradation = 50,
    },


}

---------------------------------
-- Animal Trader
---------------------------------

Config.NpcSell = {
    enabled = true,       -- false = NPC does not buy any animal (disables the prompt and the event)
    blocked = {           -- blocked types even with enabled = true (case-insensitive)
        -- 'Horse',
        -- 'Cattle',
    },
}
Config.AnimalsSellShop         = 15          -- number of random animals stocked in each trader shop on server start
Config.AllPlayersCanOpenShop   = true        -- if true, any player can open the animal trader; if false, only ranch job holders or owners
Config.ShopBlip          = 'blip_mp_predator_hunt_mask' -- map blip hash for animal trader NPCs

-- Blip sprites for each animal area (pen) shown only to ranch owners/employees.
Config.AreaBlips = {
    Poultry = 'blip_ambient_herd_straggler',
    Cattle  = 'blip_ambient_herd_straggler',
    Swine   = 'blip_ambient_herd_straggler',
    Sheep   = 'blip_ambient_herd_straggler',
    Goats   = 'blip_ambient_herd_straggler',
    Turkey   = 'blip_ambient_herd_straggler',
    Horse   = 'blip_ambient_horse',
}

-- Each entry spawns one NPC animal trader.
-- Model overrides Config.Npc.Model for that individual shop.
-- To change all traders at once, update Config.Npc.Model above.
Config.Shops = {
    Strawberry = {
        Name = 'Animal Trader of Strawberry',
        Coords = vec4(-1822.83, -615.42, 155.01, 255.24),
        AnimalCoords = vec4(-1829.60, -574.32, 155.97, 202.46),
        Animals = { 'Poultry', 'Cattle', 'Swine', 'Goats', 'Sheep', 'Horse', 'Turkey' },
        Model = 'a_m_m_nbxlaborers_01',
        Outfit = 1,
    },
    Valentine = {
        Name = 'Animal Trader of Valentine',
        Coords = vector4(-228.25, 640.08, 113.29, 226.56),
        AnimalCoords = vec4(-266.08, 663.23, 113.36, 272.74),
        Animals = { 'Poultry', 'Cattle', 'Swine', 'Goats', 'Sheep', 'Horse' },
        Model = 'a_m_m_nbxlaborers_01',
        Outfit = 2,
    },
    BlackWater = {
        Name = 'Animal Trader of BlackWater',
        Coords = vector4(-955.21, -1336.39, 50.73, 234.47),
        AnimalCoords = vec4(-979.80, -1307.35, 51.99, 218.13),
        Animals = { 'Poultry', 'Cattle', 'Swine', 'Goats', 'Sheep', 'Horse' },
        Model = 'a_m_m_nbxlaborers_01',
        Outfit = 3,
    },
    Armadillo = {
        Name = 'Animal Trader of Armadillo',
        Coords = vector4(-3725.65, -2569.62, -13.88, 280.13),
        AnimalCoords = vec4(-3737.32, -2581.32, -14.03, 307.18),
        Animals = { 'Poultry', 'Cattle', 'Swine', 'Goats', 'Sheep', 'Horse' },
        Model = 'a_m_m_nbxlaborers_01',
        Outfit = 4,
    },
    TumbleWeed = {
        Name = 'Animal Trader of TumbleWeed',
        Coords = vector4(-5539.21, -3022.31, -1.27, 49.81),
        AnimalCoords = vec4(-5530.56, -3023.85, -1.54, 293.96),
        Animals = { 'Poultry', 'Cattle', 'Swine', 'Goats', 'Sheep', 'Horse' },
        Model = 'a_m_m_nbxlaborers_01',
        Outfit = 5,
    },
    Lemoyne = {
        Name = 'Animal Trader of Lemoyne',
        Coords = vector4(1200.51, -186.7, 101.17, 4.92),
        AnimalCoords = vec4(1212.62, -208.16, 101.08, 131.72),
        Animals = { 'Poultry', 'Cattle', 'Swine', 'Goats', 'Sheep', 'Horse' },
        Model = 'a_m_m_nbxlaborers_01',
        Outfit = 6,
    },
    SaintDenis = {
        Name = 'Animal Trader of Saint Denis',
        Coords = vector4(2573.03, -781.43, 42.36, 252.98),
        AnimalCoords = vec4(2556.21, -790.45, 42.36, 287.07),
        Animals = { 'Poultry', 'Cattle', 'Swine', 'Goats', 'Sheep', 'Horse' },
        Model = 'a_m_m_nbxlaborers_01',
        Outfit = 7,
    },
}

Config.shopAnimalStatus        = {
    Goats = {
        age = 1,         -- Young adults
        weight = 20,     -- Good starter weight
        health = 100,    -- Fully healthy
        fertility = 80,  -- Capable of breeding
        hungry = 80,     -- Not hungry right out the store
    },
    Cattle = {
        age = 2,         
        weight = 250,    
        health = 100,    
        fertility = 80, 
        hungry = 80,     
    },
    Poultry = {
        age = 0.5,       
        weight = 1.5,      
        health = 100,    
        fertility = 80, 
        hungry = 80,     
    },
    Swine = {
        age = 1,         
        weight = 40,     
        health = 100,    
        fertility = 80, 
        hungry = 80,     
    },
    Sheep = {
        age = 1,         
        weight = 30,     
        health = 100,    
        fertility = 80, 
        hungry = 80,     
    },
    Horse = {
        age = 4,         -- Minimum stable adult age is 3, typical sale age is 4
        weight = 400,    
        health = 100,    
        fertility = 100, 
        hungry = 100,     
    },
}


-- Trough upgrades by animal type.
-- Each level doubles the base capacity (TroughCapacity).
-- moneyType: 'cash' | 'gold' | any inventory item
Config.TroughUpgrades = {
    Cattle = {
        [1] = { moneyType = 'cash', amount = 500 },
        [2] = { moneyType = 'cash', amount = 1000 },
        [3] = { moneyType = 'cash', amount = 2000 },
    },
    Goats = {
        [1] = { moneyType = 'cash', amount = 300 },
        [2] = { moneyType = 'cash', amount = 600 },
        [3] = { moneyType = 'cash', amount = 1200 },
    },
    Poultry = {
        [1] = { moneyType = 'cash', amount = 150 },
        [2] = { moneyType = 'cash', amount = 300 },
        [3] = { moneyType = 'cash', amount = 600 },
    },
    Swine = {
        [1] = { moneyType = 'cash', amount = 400 },
        [2] = { moneyType = 'cash', amount = 800 },
        [3] = { moneyType = 'cash', amount = 1600 },
    },
    Sheep = {
        [1] = { moneyType = 'cash', amount = 350 },
        [2] = { moneyType = 'cash', amount = 700 },
        [3] = { moneyType = 'cash', amount = 1400 },
    },
    Horse = {
        [1] = { moneyType = 'cash', amount = 800 },
        [2] = { moneyType = 'cash', amount = 1600 },
        [3] = { moneyType = 'cash', amount = 3200 },
    },
}

Config.WaterProps = {
    'p_watertrough02x',
    'p_watertrough01x',
    'p_watertroughsml01x',
    'p_watertrough01x_new',
    'p_watertrough02x',
    'p_watertrough03x'
}

---------------------------------
-- Notify
---------------------------------

local isServerSide = IsDuplicityVersion()
function Notify(message, timer, type, source)
    -- local VORPcore = exports.vorp_core:GetCore() -- For vorp
    if timer then
        timer = timer
    else
        timer = 5000
    end
    local type = type or 'info'

    if isServerSide then
        TriggerClientEvent('ox_lib:notify', source, { title = message, type = type, duration = timer }) -- RSG
        -- VORPcore.NotifyRightTip(source, message, 4000) -- For vorp
    else
        -- VORPcore.NotifyRightTip(message, 4000) -- For vorp
        TriggerEvent('ox_lib:notify', { title = message, type = type, duration = timer }) -- RSG
    end
end
