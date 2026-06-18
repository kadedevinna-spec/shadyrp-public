Config.MiningExpAdminCommand = "giveminingexp" -- The command that is given to admins to allow setting players's mining exp to a certain amount, /giveminingexp <playerServerId> <expAmount>
Config.BlackExpAdminCommand = "giveblacksmithexp" -- The command that is given to admins to allow setting players's blacksmithing exp to a certain amount, /giveblacksmithexp <playerServerId> <expAmount>

Config.BlacksmithExpCommand = "blacksmithexp" -- Command for players to use to display blacksmith exp
Config.LevelSystemEnabled = true                  -- Set to false to disable the level system
Config.MinigExpCommand = "miningexp"
Config.ExpRewardNotif = true                      -- Set to false to disable the experience reward notification
Config.LevelUpNotif = true                        -- Set to false to disable the level up notification

-- FYI: THE BLACKSMITHING EXP SYSTEM IS SEPARATE FROM THE MINING EXP SYSTEM, YOU WILL FIND EVERYTHING RELATED TO BLACKSMITHING EXP IN config_tools.lua under Config.Smelter = {}

Config.LevelSystem = {
    [1] = {
        Experience = 100,                              -- experience to reach level 1, players start a level 0
        Reward = {
            Items = { { Item = "jade", Amount = 1 } }, -- You can add multiple items
            Money = 25,                                -- Money reward for reaching this level
        },
    },
    [2] = {
        Experience = 166,
        Reward = {
            Items = { { Item = "amethyst", Amount = 1 } },
            Money = 50,
            Money = 25,
        },
    },
    [3] = {
        Experience = 239,
        Reward = {
            Items = { { Item = "aquamarine", Amount = 1 } },
            Money = 75,
            Money = 25,
        },
    },
    [4] = {
        Experience = 320,
        Reward = {
            Items = { { Item = "amethyst", Amount = 1 } },
            Money = 100,
            Money = 30,
        },
    },
    [5] = {
        Experience = 409,
        Reward = {
            Items = { { Item = "jade", Amount = 1 }, { Item = "bluegoldnugget", Amount = 2 } },
            Money = 125,
            Money = 30,
        },
    },
    [6] = {
        Experience = 508,
        Reward = {
            Items = { { Item = "amethyst", Amount = 1 }, { Item = "bluegoldnugget", Amount = 2 } },
            Money = 150,
            Money = 30,
        },
    },
    [7] = {
        Experience = 617,
        Reward = {
            Items = { { Item = "aquamarine", Amount = 1 }, { Item = "bluegoldnugget", Amount = 2 } },
            Money = 175,
            Money = 35,
        },
    },
    [8] = {
        Experience = 738,
        Reward = {
            Items = { { Item = "amethyst", Amount = 1 }, { Item = "bluegoldnugget", Amount = 2 } },
            Money = 200,
            Money = 35,
        },
    },
    [9] = {
        Experience = 872,
        Reward = {
            Items = { { Item = "jade", Amount = 1 }, { Item = "bluegoldnugget", Amount = 2 } },
            Money = 225,
            Money = 35,
        },
    },
    [10] = {
        Experience = 1020,
        Reward = {
            Items = { { Item = "amethyst", Amount = 2 }, { Item = "bluegold", Amount = 2 }, { Item = "rosegoldnugget", Amount = 2 } },
            Money = 500,
            Money = 40,
        },
    },
    [11] = {
        Experience = 1509,
        Reward = {
            Items = { { Item = "jade", Amount = 3 }, { Item = "bluegold", Amount = 2 }, { Item = "bluegoldnugget", Amount = 3 }, { Item = "pickaxe", Amount = 1 } },
            Money = 262,
            Money = 40,
        },
    },
    [12] = {
        Experience = 1588,
        Reward = {
            Items = { { Item = "amethyst", Amount = 3 }, { Item = "bluegoldnugget", Amount = 3 } },
            Money = 287,
            Money = 40,
        },
    },
    [13] = {
        Experience = 1682,
        Reward = {
            Items = { { Item = "aquamarine", Amount = 3 }, { Item = "bluegoldnugget", Amount = 3 } },
            Money = 312,
            Money = 45,
        },
    },
    [14] = {
        Experience = 1794,
        Reward = {
            Items = { { Item = "jade", Amount = 3 }, { Item = "bluegoldnugget", Amount = 3 } },
            Money = 337,
            Money = 45,
        },
    },
    [15] = {
        Experience = 1928,
        Reward = {
            Items = { { Item = "amethyst", Amount = 3 }, { Item = "bluegoldnugget", Amount = 3 }, { Item = "pickaxe_silver", Amount = 1 } },
            Money = 362,
            Money = 45,
        },
    },
    [16] = {
        Experience = 2087,
        Reward = {
            Items = { { Item = "aquamarine", Amount = 3 }, { Item = "bluegoldnugget", Amount = 3 } },
            Money = 387,
            Money = 50,
        },
    },
    [17] = {
        Experience = 2275,
        Reward = {
            Items = { { Item = "jade", Amount = 3 }, { Item = "bluegoldnugget", Amount = 3 } },
            Money = 412,
            Money = 50,
        },
    },
    [18] = {
        Experience = 2496,
        Reward = {
            Items = { { Item = "amethyst", Amount = 3 }, { Item = "bluegoldnugget", Amount = 3 } },
            Money = 437,
            Money = 50,
        },
    },
    [19] = {
        Experience = 2755,
        Reward = {
            Items = { { Item = "aquamarine", Amount = 3 }, { Item = "bluegoldnugget", Amount = 3 } },
            Money = 462,
            Money = 55,
        },
    },
    [20] = {
        Experience = 3055,
        Reward = {
            Items = { { Item = "jade", Amount = 3 }, { Item = "rosegold", Amount = 2 }, { Item = "rosegoldnugget", Amount = 3 }, { Item = "pickaxe_gold", Amount = 1 } },
            Money = 700,
            Money = 55,
        },
    },
    [21] = {
        Experience = 3402,
        Reward = {
            Items = { { Item = "amethyst", Amount = 3 }, { Item = "rosegoldnugget", Amount = 3 } },
            Money = 700,
            Money = 55,
        },
    },
    [22] = {
        Experience = 3802,
        Reward = {
            Items = { { Item = "aquamarine", Amount = 3 }, { Item = "rosegoldnugget", Amount = 3 } },
            Money = 700,
            Money = 60,
        },
    },
    [23] = {
        Experience = 4262,
        Reward = {
            Items = { { Item = "jade", Amount = 3 }, { Item = "rosegoldnugget", Amount = 3 } },
            Money = 700,
            Money = 60,
        },
    },
    [24] = {
        Experience = 4791,
        Reward = {
            Items = { { Item = "amethyst", Amount = 3 }, { Item = "rosegoldnugget", Amount = 3 } },
            Money = 700,
            Money = 60,
        },
    },
    [25] = {
        Experience = 5400,
        Reward = {
            Items = { { Item = "aquamarine", Amount = 3 }, { Item = "greengold", Amount = 2 }, { Item = "greengoldnugget", Amount = 3 }, { Item = "pickaxe_gold", Amount = 1 } },
            Money = 700,
            Money = 65,
        },
    },
    [26] = {
        Experience = 6100,
        Reward = {
            Items = { { Item = "jade", Amount = 3 }, { Item = "greengoldnugget", Amount = 3 } },
            Money = 700,
            Money = 65,
        },
    },
    [27] = {
        Experience = 6904,
        Reward = {
            Items = { { Item = "amethyst", Amount = 3 }, { Item = "greengoldnugget", Amount = 3 } },
            Money = 700,
            Money = 65,
        },
    },
    [28] = {
        Experience = 7828,
        Reward = {
            Items = { { Item = "aquamarine", Amount = 3 }, { Item = "greengoldnugget", Amount = 3 } },
            Money = 700,
            Money = 70,
        },
    },
    [29] = {
        Experience = 8886,
        Reward = {
            Items = { { Item = "jade", Amount = 3 }, { Item = "greengoldnugget", Amount = 3 } },
            Money = 700,
            Money = 70,
        },
    },
    [30] = {
        Experience = 10000,
        Reward = {
            Items = { { Item = "amethyst", Amount = 3 }, { Item = "bluegold", Amount = 2 }, { Item = "bluegoldnugget", Amount = 3 }, { Item = "pickaxe_gold", Amount = 1 } },
            Money = 1000,
            Money = 70,
        },
    },
    [31] = {
        Experience = 11200,
        Reward = {
            Items = { { Item = "aquamarine", Amount = 3 }, { Item = "bluegoldnugget", Amount = 3 } },
            Money = 700,
            Money = 75,
        },
    },
    [32] = {
        Experience = 12544,
        Reward = {
            Items = { { Item = "jade", Amount = 3 }, { Item = "bluegoldnugget", Amount = 3 } },
            Money = 700,
            Money = 75,
        },
    },
    [33] = {
        Experience = 14048,
        Reward = {
            Items = { { Item = "amethyst", Amount = 3 }, { Item = "bluegoldnugget", Amount = 3 } },
            Money = 700,
            Money = 75,
        },
    },
    [34] = {
        Experience = 15734,
        Reward = {
            Items = { { Item = "aquamarine", Amount = 3 }, { Item = "bluegoldnugget", Amount = 3 } },
            Money = 700,
            Money = 80,
        },
    },
    [35] = {
        Experience = 17622,
        Reward = {
            Items = { { Item = "jade", Amount = 3 }, { Item = "rosegold", Amount = 2 }, { Item = "rosegoldnugget", Amount = 3 }, { Item = "pickaxe_gold", Amount = 1 } },
            Money = 700,
            Money = 80,
        },
    },
    [36] = {
        Experience = 19737,
        Reward = {
            Items = { { Item = "amethyst", Amount = 3 }, { Item = "rosegoldnugget", Amount = 3 } },
            Money = 700,
            Money = 80,
        },
    },
    [37] = {
        Experience = 22106,
        Reward = {
            Items = { { Item = "aquamarine", Amount = 3 }, { Item = "rosegoldnugget", Amount = 3 } },
            Money = 700,
            Money = 85,
        },
    },
    [38] = {
        Experience = 24758,
        Reward = {
            Items = { { Item = "jade", Amount = 3 }, { Item = "rosegoldnugget", Amount = 3 } },
            Money = 700,
            Money = 85,
        },
    },
    [39] = {
        Experience = 27728,
        Reward = {
            Items = { { Item = "amethyst", Amount = 3 }, { Item = "rosegoldnugget", Amount = 3 } },
            Money = 700,
            Money = 85,
        },
    },
    [40] = {
        Experience = 31056,
        Reward = {
            Items = { { Item = "aquamarine", Amount = 4 }, { Item = "greengold", Amount = 2 }, { Item = "greengoldnugget", Amount = 4 }, { Item = "pickaxe_gold", Amount = 1 } },
            Money = 1000,
            Money = 90,
        },
    },
    [41] = {
        Experience = 34782,
        Reward = {
            Items = { { Item = "jade", Amount = 4 }, { Item = "greengoldnugget", Amount = 4 } },
            Money = 800,
            Money = 90,
        },
    },
    [42] = {
        Experience = 38956,
        Reward = {
            Items = { { Item = "amethyst", Amount = 4 }, { Item = "greengoldnugget", Amount = 4 } },
            Money = 800,
            Money = 90,
        },
    },
    [43] = {
        Experience = 43632,
        Reward = {
            Items = { { Item = "aquamarine", Amount = 4 }, { Item = "greengoldnugget", Amount = 4 } },
            Money = 800,
            Money = 95,
        },
    },
    [44] = {
        Experience = 48848,
        Reward = {
            Items = { { Item = "jade", Amount = 4 }, { Item = "greengoldnugget", Amount = 4 } },
            Money = 800,
            Money = 95,
        },
    },
    [45] = {
        Experience = 54630,
        Reward = {
            Items = { { Item = "amethyst", Amount = 4 }, { Item = "bluegold", Amount = 2 }, { Item = "bluegoldnugget", Amount = 4 }, { Item = "pickaxe_gold", Amount = 1 } },
            Money = 800,
            Money = 95,
        },
    },
    [46] = {
        Experience = 61026,
        Reward = {
            Items = { { Item = "aquamarine", Amount = 4 }, { Item = "bluegoldnugget", Amount = 4 } },
            Money = 800,
            Money = 100,
        },
    },
    [47] = {
        Experience = 68149,
        Reward = {
            Items = { { Item = "jade", Amount = 4 }, { Item = "bluegoldnugget", Amount = 4 } },
            Money = 800,
            Money = 100,
        },
    },
    [48] = {
        Experience = 76127,
        Reward = {
            Items = { { Item = "amethyst", Amount = 4 }, { Item = "bluegoldnugget", Amount = 4 } },
            Money = 800,
            Money = 100,
        },
    },
    [49] = {
        Experience = 85088,
        Reward = {
            Items = { { Item = "aquamarine", Amount = 4 }, { Item = "bluegoldnugget", Amount = 4 } },
            Money = 800,
            Money = 105,
        },
    },
    [50] = {
        Experience = 95157,
        Reward = {
            Items = { { Item = "jade", Amount = 4 }, { Item = "bluegoldnugget", Amount = 4 }, { Item = "pickaxe_gold", Amount = 1 } },
            Money = 2000,
            Money = 150,
        },
    },
    [51] = {
        Experience = 98525,
        Reward = {
            Items = { { Item = "jade", Amount = 6 }, { Item = "greengold", Amount = 3 }, { Item = "greengoldnugget", Amount = 6 }, { Item = "pickaxe_gold", Amount = 1 } },
            Money = 800,
            Money = 105,
        },
    },
    [52] = {
        Experience = 108141,
        Reward = {
            Items = { { Item = "amethyst", Amount = 6 }, { Item = "greengoldnugget", Amount = 6 } },
            Money = 800,
            Money = 105,
        },
    },
    [53] = {
        Experience = 118457,
        Reward = {
            Items = { { Item = "aquamarine", Amount = 6 }, { Item = "greengoldnugget", Amount = 6 } },
            Money = 800,
            Money = 110,
        },
    },
    [54] = {
        Experience = 129500,
        Reward = {
            Items = { { Item = "jade", Amount = 6 }, { Item = "greengoldnugget", Amount = 6 } },
            Money = 800,
            Money = 110,
        },
    },
    [55] = {
        Experience = 141298,
        Reward = {
            Items = { { Item = "amethyst", Amount = 6 }, { Item = "greengoldnugget", Amount = 6 } },
            Money = 800,
            Money = 110,
        },
    },
    [56] = {
        Experience = 153878,
        Reward = {
            Items = { { Item = "aquamarine", Amount = 6 }, { Item = "bluegold", Amount = 3 }, { Item = "bluegoldnugget", Amount = 6 }, { Item = "pickaxe_gold", Amount = 1 } },
            Money = 800,
            Money = 115,
        },
    },
    [57] = {
        Experience = 167267,
        Reward = {
            Items = { { Item = "jade", Amount = 6 }, { Item = "bluegoldnugget", Amount = 6 } },
            Money = 800,
            Money = 115,
        },
    },
    [58] = {
        Experience = 181492,
        Reward = {
            Items = { { Item = "amethyst", Amount = 6 }, { Item = "bluegoldnugget", Amount = 6 } },
            Money = 800,
            Money = 115,
        },
    },
    [59] = {
        Experience = 196581,
        Reward = {
            Items = { { Item = "aquamarine", Amount = 6 }, { Item = "bluegoldnugget", Amount = 6 } },
            Money = 800,
            Money = 120,
        },
    },
    [60] = {
        Experience = 212560,
        Reward = {
            Items = { { Item = "jade", Amount = 6 }, { Item = "bluegoldnugget", Amount = 6 } },
            Money = 2000,
            Money = 120,
        },
    },
    [61] = {
        Experience = 229457,
        Reward = {
            Items = { { Item = "amethyst", Amount = 6 }, { Item = "rosegold", Amount = 3 }, { Item = "rosegoldnugget", Amount = 6 }, { Item = "pickaxe_gold", Amount = 1 } },
            Money = 900,
            Money = 120,
        },
    },
    [62] = {
        Experience = 247299,
        Reward = {
            Items = { { Item = "aquamarine", Amount = 6 }, { Item = "rosegoldnugget", Amount = 6 } },
            Money = 900,
            Money = 125,
        },
    },
    [63] = {
        Experience = 266112,
        Reward = {
            Items = { { Item = "jade", Amount = 6 }, { Item = "rosegoldnugget", Amount = 6 } },
            Money = 900,
            Money = 125,
        },
    },
    [64] = {
        Experience = 285924,
        Reward = {
            Items = { { Item = "amethyst", Amount = 6 }, { Item = "rosegoldnugget", Amount = 6 } },
            Money = 900,
            Money = 125,
        },
    },
    [65] = {
        Experience = 306761,
        Reward = {
            Items = { { Item = "aquamarine", Amount = 6 }, { Item = "rosegoldnugget", Amount = 6 } },
            Money = 900,
            Money = 130,
        },
    },
    [66] = {
        Experience = 328650,
        Reward = {
            Items = { { Item = "jade", Amount = 6 }, { Item = "greengold", Amount = 3 }, { Item = "greengoldnugget", Amount = 6 }, { Item = "pickaxe_gold", Amount = 1 } },
            Money = 900,
            Money = 130,
        },
    },
    [67] = {
        Experience = 351618,
        Reward = {
            Items = { { Item = "amethyst", Amount = 6 }, { Item = "greengoldnugget", Amount = 6 } },
            Money = 900,
            Money = 130,
        },
    },
    [68] = {
        Experience = 375692,
        Reward = {
            Items = { { Item = "aquamarine", Amount = 6 }, { Item = "greengoldnugget", Amount = 6 } },
            Money = 900,
            Money = 135,
        },
    },
    [69] = {
        Experience = 400899,
        Reward = {
            Items = { { Item = "jade", Amount = 6 }, { Item = "greengoldnugget", Amount = 6 } },
            Money = 900,
            Money = 135,
        },
    },
    [70] = {
        Experience = 427266,
        Reward = {
            Items = { { Item = "amethyst", Amount = 6 }, { Item = "greengoldnugget", Amount = 6 } },
            Money = 900,
            Money = 135,
        },
    },
    [71] = {
        Experience = 454819,
        Reward = {
            Items = { { Item = "aquamarine", Amount = 6 }, { Item = "bluegold", Amount = 3 }, { Item = "bluegoldnugget", Amount = 6 }, { Item = "pickaxe_gold", Amount = 1 } },
            Money = 900,
            Money = 140,
        },
    },
    [72] = {
        Experience = 483585,
        Reward = {
            Items = { { Item = "jade", Amount = 6 }, { Item = "bluegoldnugget", Amount = 6 } },
            Money = 900,
            Money = 140,
        },
    },
    [73] = {
        Experience = 513591,
        Reward = {
            Items = { { Item = "amethyst", Amount = 6 }, { Item = "bluegoldnugget", Amount = 6 } },
            Money = 900,
            Money = 140,
        },
    },
    [74] = {
        Experience = 544864,
        Reward = {
            Items = { { Item = "aquamarine", Amount = 6 }, { Item = "bluegoldnugget", Amount = 6 } },
            Money = 900,
            Money = 145,
        },
    },
    [75] = {
        Experience = 577431,
        Reward = {
            Items = { { Item = "jade", Amount = 6 }, { Item = "bluegoldnugget", Amount = 6 }, { Item = "pickaxe_gold", Amount = 1 } },
            Money = 2500,
            Money = 250,
        },
    },
}

-- I can't remember the exact formula for the experience curve, but it's similar to this
-- If you want to use an automated formula use this or something similar:
-- Config.LevelSystem = {}

-- local scale = 0.25
-- local baseXP = 0

-- for level = 1, 200 do
--     baseXP = baseXP + math.floor((level + 300 * 2 ^ (level / 7)) * scale)

--     Config.LevelSystem[level] = {
--         Experience = baseXP,
--         Reward = {
--             Items = {}, -- you can fill rewards manually or dynamically later
--             Money = math.floor(baseXP * 0.1), -- example: 10% of experience as money
--         },
--     }
--     print(string.format("Level: %d, Experience: %d", level, baseXP))
--     print("Reward Items: ", Config.LevelSystem[level].Reward.Items)
-- end
