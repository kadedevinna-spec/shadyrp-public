Config = {}
Config.Locale = "en"
Config.Framework = "rsgcore" -- Possible Options: "vorpcore", "rsgcore", "redemrp"
Config.RSGCoreInventoryMaxWeight = 120000 -- Only Necessary if using rsgcore | Use the Same value as in the rsg-inventory ressource for 'Config.MaxInventoryWeight'

Config.DevMode = false

-- CUTTING ITEMS
Config.UseItems = {
    {
        item = "axe",
        prop = "p_axe02x",
        usemetadata = false,
        removedureabilitybase = 100,
        durabilityremoved = 5,
        timeScale = 1.0
    }
}

-- SEED CONFIGURATIONS
Config.MaxPlantableSeeds = 100 -- MAX X AMOUNT OF TREES CAN BE PLANTED, TO PLANT ADDITIONAL TREES HAVE TO BE CUT
Config.MaxTreeLifeDuration = 10 -- TIME A PLANTED TREE SPAWNS IN DAYS BEFORE DYING (GETTING DELETED FROM DB)
Config.JobsAllowedToUseSeeds = {}
Config.SeedPlaceKey = 0xC7B5340A
Config.CancelSeedingKey = 0x156F7119
Config.RemoveSaplingKey = 0x26E9DC00
Config.TreeSeeds = {
    {seedItem = "tree_seed", treeModel = "p_tree_douglasfir_04", seedsNeeded = 5, timeToGrowth = 0.5} -- time to growth in hours
}

Config.TimetoCut = 15 -- in seconds
Config.TreeCutKey = 0x760A9C6F
Config.AllowedToCut = {} -- IF FILLED IN ONLY PLAYERS WITH X JOB CAN CUT TREES

Config.UseLogAnimation = true -- Uses LogAnimation if LogItem is in Inventory


Config.LogItem = "wood_log"
Config.LogProp = "p_cs_cedarlog02x"


Config.UseXPSystem = true -- XP WILL AFFECT TIME NEED TO CUT THE TREE
Config.GainedXP = 0.2
Config.MaxXPGainable = 3.0 -- MAX OVERALL GAINABLE XP
Config.MaxXPGainableByNonJobsForMultiplier = 2.3 -- MAX XP FOR NON JOBS FOR MULTIPLIER
Config.AddXPForLogCutting = true
Config.AddXPAmountForLogCutting = 0.1

Config.JobsForMultiplier = {}
Config.JobMultiplier = 1.5 -- IF THE PLAYER HAS ONE OF THE Config.JobsForMultiplier JOBS THE PLAYER WILL GAIN MORE XP IF THE XP SYSTEM IS SET TO TRUE
Config.XPTimeMultiplier = 0.8 -- FOR EVERY 1.0 XP SCALE X AMOUNT OF TIME NEEDED TO CUT DOWN | SO IF PLAYER HAS 2.0 XP this means the time needed to be cut is multiplied by 0.8 twice

Config.AllowLogDropping = true
Config.SpawnDroppedLogs = true -- If a player cancel the carry of a log animation, spawn the log in front of him. Otherwise the item despawns completly
Config.DisableSprintDuringAnim = true

Config.AllowCuttingDroppedLog = true
Config.DroppedLogCuttingTime = 10 -- in seconds scales with time multiplier
Config.LogCuttingKey = 0x26E9DC00
Config.AddLogCuttingItems = {
  {name = "wood", amount = 4},
  {name = "water", amount = 2},
}

Config.EnableLogStorageMarker = true
Config.LogStoragesType = 0x94FDAE17
Config.LogStorageMarkerR = 255
Config.LogStorageMarkerG = 255
Config.LogStorageMarkerB = 255
Config.LogStorageMarkerA = 100

Config.AllowSellMissions = true
Config.MaxDeliveryVehicleCapacity = 10 -- logs allowed to load on vehicle
Config.LogSellingPrice = 1.00
Config.DeliveryBlipSprite = 1012165077
Config.DeliveryBlipScale = 0.8

Config.TownRestrictions = {
    {name = "Annesburg", seedPlanting_allowed = true},
    {name = "Armadillo", seedPlanting_allowed = true},
    {name = "Blackwater", seedPlanting_allowed = true},
    {name = "Lagras", seedPlanting_allowed = true},
    {name = "Rhodes", seedPlanting_allowed = true},
    {name = "StDenis", seedPlanting_allowed = true},
    {name = "Strawberry", seedPlanting_allowed = true},
    {name = "Tumbleweed", seedPlanting_allowed = true},
    {name = "Valentine", seedPlanting_allowed = true},
    {name = "Vanhorn", seedPlanting_allowed = true}
}

Config.LogStorages = {

    {
        -- Strawberry
        storageID = 1,
        useprop = true,
        blip = 1904459580,
        propPosition = {x = -1366.03, y = -197.948, z = 101.50, h = 90.00},
        markerPosition = vector3(-1369.73, -201.077, 101.44),
        allowedJobs = {},
        maxLogs = 10, -- max logs you can store in storage place
        sellVehicleSpawn = {x = -1387.23, y = -222.398, z = 99.61, h = 168.26},
        sellPoints = {
            {x = -1825.58, y = -431.233, z = 158.93, h = 58.34}, -- Strawberry Wood Worker
            {x = -877.724, y = -1289.10, z = 41.887, h = 94.99}, -- Blackwater Wood Worker
            {x = 2876.137, y = -1181.16, z = 45.061, h = 13.92}, -- St. Denis Wood Worker
            {x = 2851.114, y = 1435.760, z = 67.310, h = 141.8} -- Annesburg Wood Worker
        }
    },

    -- DEV POS
    {
      storageID = 2,
      useprop = true,
      blip = 1904459580,
      propPosition = {x = -193.810, y = 642.4505, z = 112.32, h = 100.67},
      markerPosition = vector3(-191.770, 645.6208, 112.32),
      allowedJobs = {},
      maxLogs = 10, -- max logs you can store in storage place
      sellVehicleSpawn = {x = -197.624, y = 633.1280, z = 113.06, h=53.58},
      sellPoints = {
        {x = -225.934, y = 642.6433, z = 112.15, h = 230.03},
      }
    }

}

Config.GainableLogsFromTrees = {
    {name = "p_tree_pine_ponderosa_06", logs = 2},
    {name = "p_tree_pine_ponderosa_07", logs = 2},
    {name = "p_tree_engoak_02", logs = 3}
}

Config.TimeScaleTreeCutting = {
    {name = "p_tree_pine_ponderosa_06", timeScale = 1.5},
    {name = "p_tree_pine_ponderosa_07", timeScale = 1.5},
    {name = "p_tree_engoak_02", timeScale = 1.7},
}


-- REMOVES TREE IPL AT Lumberlocations
Config.DeactivatedIPL = {
  174727090,
  3600341732,
  3372049755,
}


-- WILL SPAWN TREES ON SCRIPT START / SERVER RESTART
Config.BaseLumberLocations = {
    {
        label = "Trees",
        coords = {x = -1214.20, y = -291.095, z = 105.85},
        blip = 1904459580, -- if you dont wanna use a blip set it to ""
        jobs = {},
        availableTrees = {
            {
                treemodel = "p_tree_douglasfir_04",
                coords = {x = -1377.97, y = -241.790, z = 99.39, h = 0.0}
            },
            {
                treemodel = "p_tree_pine_ponderosa_06",
                coords = {x = -1377.12, y = -248.256, z = 98.642, h = 0.0}
            },
            {
                treemodel = "p_tree_douglasfir_04",
                coords = {x = -1378.68, y = -254.956, z = 97.726, h = 0.0}
            },
            {
                treemodel = "p_tree_pine_ponderosa_06",
                coords = {x = -1370.51, y = -253.175, z = 98.426, h = 0.0}
            },
            {
                treemodel = "p_tree_douglasfir_04",
                coords = {x = -1375.84, y = -262.272, z = 97.773, h = 0.0}
            },
            {
                treemodel = "p_tree_pine_ponderosa_06",
                coords = {x = -1355.37, y = -254.462, z = 100.00, h = 0.0}
            },
            {
                treemodel = "p_tree_douglasfir_04",
                coords = {x = -1388.68, y = -259.900, z = 98.098, h = 0.0}
            },
            {
                treemodel = "p_tree_douglasfir_04",
                coords = {x = -1342.88, y = -232.719, z = 101.50, h = 0.0}
            },
            {
                treemodel = "p_tree_pine_ponderosa_06",
                coords = {x = -1348.33, y = -235.127, z = 102.00, h = 0.0}
            },
            {
                treemodel = "p_tree_pine_ponderosa_07",
                coords = {x = -1343.75, y = -240.704, z = 102.30, h = 0.0}
            },
            {
                treemodel = "p_tree_engoak_02",
                coords = {x = -1338.36, y = -237.725, z = 102.00, h = 0.0}
            },
            -- DEV POS
            {treemodel="p_tree_douglasfir_04",coords={x = -142.796, y = 624.2756, z = 113.66, h = 120.0}},
            {treemodel="p_tree_pine_ponderosa_06",coords={x = -145.4242706298828, y = 613.2131958007812, z = 113.93408203125, h = 122.0}},
        }
    },
}






Config.SawingStation = {
    {
        position = {x = -1397.74, y = -236.850, z = 98.532, h = 0.0},
        blip = 1904459580,
        jobLock = {}, -- lock workstation for specific jobs only
        convertableItems = {
            {
                label = "Planks",
                itemsNeeded = {"saw"}, --items needed for working, it automatically includes all "lossing items"
                items = {
                    itemsLoosing = {
                        {itemName = "wood", amount = 2}
                    },
                    gainedItems = {
                        {itemName = "wood_plank", amount = 2}
                    }
                },
                duration = 5 -- in seconds
            }
        }
    },

    -- DEV POS
    {
      position = {x = -173.454, y = 647.5367, z = 112.52, h = 319.52},
      blip = "",
      jobLock = {}, -- lock workstation for specific jobs only
      convertableItems = {
        {
          label = "Planken",
          itemsNeeded = {"saw"}, --items needed for working, it automatically includes all "lossing items"
          items = {
            itemsLoosing={
              {itemName="wood",amount=2},
            },
            gainedItems={
              {itemName="wood_plank",amount=4},
            }
          },
          duration = 5 -- in seconds
        },
      }
    }


}

Config.SplitStation = {
    {
        position = {x = -1416.54, y = -231.886, z = 99.48, h = -50.0},
        blip = 1904459580,
        jobLock = {}, -- lock workstation for specific jobs only
        items = {
            itemsLoosing = {
                {itemName = "wood", amount = 2}
            },
            gainedItems = {
                {itemName = "wood_small", amount = 2}
            }
        }
    },

    -- DEV POS
    {
      position = {x = -190.310, y = 657.4244, z = 112.23, h = 331.55},
      blip = 1904459580,
      jobLock = {}, -- lock workstation for specific jobs only
      items = {
        itemsLoosing={
          {itemName="wood",amount=2},
        },
        gainedItems={
          {itemName="wood_small",amount=2},
        }
      },
    }

}
