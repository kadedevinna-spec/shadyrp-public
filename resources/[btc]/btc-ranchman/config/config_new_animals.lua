--[[
╔══════════════════════════════════════════════════════════════════╗
║           HOW TO ADD NEW ANIMAL TYPES                            ║
╠══════════════════════════════════════════════════════════════════╣
║                                                                  ║
║  1. Copy one of the blocks below as a template.                  ║
║                                                                  ║
║  2. Choose ONE production logic (only one field):                ║
║     • Milk (like Cattle/Goats):                                  ║
║         Milk = { item, itemAmount, cooldown, minChildrens }      ║
║     • Wool (like Sheep):                                         ║
║         Wool = { item, itemAmount, cooldown, minAge }            ║
║     • Cleaning (like Swine):                                     ║
║         Cleaning = { item, amount, cooldown }                    ║
║     • Eggs (like Poultry):                                       ║
║         EggLaying = { EggItem, EggItemAmount,                    ║
║             CheckIntervalInMinutes, LayEggCooldownInMinutes,     ║
║             FertilizationChance, ChickenBirthTimeInMinutes }     ║
║     • No production: do not add any of these fields.             ║
║                                                                  ║
║  3. Fill Female and Male with Label (visible name) and Spawn     ║
║     (Model = RDR2 model, Outfits = variation indices).           ║
║     Never follow the Horse logic (Training, StableIntegration).  ║
║     New animals CANNOT be carried by the player.                 ║
║                                                                  ║
║  4. Add an OWN area in config_ranchs.lua                         ║
║     for each ranch that will use the animal:                     ║
║     Animals = { MeuAnimal = { Menu = vec4(...), Area = {...} } } ║
║     Without an area the animal will have no spawn location or    ║
║     interaction.                                                 ║
║                                                                  ║
║  5. Add the images in images/ (128×128 PNG, transparent          ║
║     background):                                                 ║
║       MyAnimal_Female.png  and  MyAnimal_Male.png                ║
║     The name must be IDENTICAL to the Config.Animals[?] key.     ║
║                                                                  ║
║  6. If you want slaughter, add in config_slaughterhouse.lua:     ║
║     MeuAnimal = {                                                ║
║         Male   = { SlaughterRequirements = {...}, Rewards={} },  ║
║         Female = { SlaughterRequirements = {...}, Rewards={} },  ║
║     }                                                            ║
║                                                                  ║
╚══════════════════════════════════════════════════════════════════╝
--]]

-- ── Turkey: follows Poultry logic (EggLaying field) ──────────────
-- Females lay eggs automatically; males increase fertilization.
-- No normal pregnancy (EggLaying excludes the pregnancy system).
Config.Animals.Turkey = {
    MaxStats       = { age = 10, weight = 15, pregnancy = 28 },
    TroughCapacity = 200,
    FertilAge      = 0.6,
    EggLaying      = {
        CheckIntervalInMinutes    = 15,
        LayEggFertilityThreshold  = 1,
        LayEggCooldownInMinutes   = 45,
        FertilizationChance       = 30,           -- % per fertile male per female
        ChickenBirthTimeInMinutes = 120,
        EggItem                   = 'egg', -- change to your server's item
        EggItemAmount             = 3,
    },
    Food           = { minHungry = 10, weight = 0.3 },
    FoodItems      = {
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
    PriceConfig    = {
        BasePrice = 2,
        perKg = 0.20,
        SellRatio = 0.60,
        SaleRequirements = { health = 70, fertility = 50, age = 0.5 },
    },
    Female         = { Label = 'Turkey Female', Spawn = { Model = 'a_c_turkey_01', Outfits = { [1] = 'Normal' } } },
    Male           = { Label = 'Turkey', Spawn = { Model = 'a_c_turkey_01', Outfits = { [2] = 'Normal' } } },
}
