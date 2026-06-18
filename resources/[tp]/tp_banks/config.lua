
Config = {}

Config.DevMode    = false
Config.Debug      = false

Config.PromptKey      = { key = 0x760A9C6F, label = 'Banking Account ' } -- G
Config.VaultPromptKey = { key = 0xCEFD9220, label = 'Vault ' } -- E

-- RobberyActionKey is used for the vault actions (lockpicking, safe cracking).
Config.RobberyActionKey = 0x760A9C6F -- G

-- The following is only when a notification sent while Banking is open (It has its own notification system).
Config.NotificationColors = {
    ['error']   = "rgba(255, 0, 0, 0.79)",
    ['success'] = "rgba(0, 255, 0, 0.79)",
    ['info']    = "rgba(0, 0, 255, 0.79)"
}

-----------------------------------------------------------
--[[ General ]]--
-----------------------------------------------------------

-- The cost for a player to create a bank account (one-time).
-- @param item    : In case the money is an item, set the item name, for example: item = "gold", item = "dollars" (it will skip account parameter.)
-- @param account : In case the money is NOT an item, you can use "CASH" or "GOLD".
-- @param cost    : The registration cost.
Config.BankRegistryCost = { Item = false, Account = 'CASH', Cost = 5 }

-- The required amount for a player to create a bank joint account from his main bank account - (one-time).
Config.BankJointAccountCost = 5 -- ALWAYS CASH.

-- The specified update timer is for the Government Bank Accounts to update their status duration of a robbery.
Config.UpdateTimer = 10

-- The transaction action limitations, to prevent players to deposit, withdraw or transfer
-- lower than the configurable amount.
Config.TransactionLimitations = { 
    Deposit  = { ['CASH'] = 10, ['GOLD'] = 1 }, -- Minimum
    Transfer = 20, -- Minimum (ONLY CASH AVAILABLE)
}

-- The transaction action fees on deposit, withdraw or iban transfers based on the account type.
Config.TransactionFees = {

    ['DEFAULT_ACCOUNT'] = { -- Default Account (Personal)
        Deposit  = { ['CASH'] = 0,   ['GOLD'] = 0  }, -- %
        Withdraw = { ['CASH'] = 0,   ['GOLD'] = 0  }, -- %
        Transfer =  10, -- % (ONLY CASH AVAILABLE)
    },

    ['JOINT_ACCOUNT'] = { -- Joint Account (Shared)
        Deposit  = { ['CASH'] = 2,   ['GOLD'] = 0 },  -- %
        Withdraw = { ['CASH'] = 2,   ['GOLD'] = 0 },  -- %
        Transfer = 15, -- % (ONLY CASH AVAILABLE)
    },

}

-- Auto-Tax is a system to withdraw automatically a percentage of the total account money.
-- For example, if someone has 100 dollars and @WithdrawPercentage is 5%, it will withdraw 5 dollars every x @Duration.
-- @Duration: Set the duration value to 0 if you don't want any auto-tax.
Config.AutoTax = {

    -- Updates the auto-tax duration (if enabled) every 5 minutes by default for better server performance.
    UpdateTimer = 5,

    ['DEFAULT_ACCOUNT'] = { -- Default Account (Personal)
        Enabled  = true,
        Duration = 10080, -- Time in minutes (every 7 days in minutes by default)
        WithdrawPercentage = 5,
    },

    ['JOINT_ACCOUNT'] = { -- Joint Account (Shared)
        Enabled  = true,
        Duration = 10080, -- Time in minutes (every 7 days in minutes by default)
        WithdrawPercentage = 5,
    },
}

-- The specified Command is used to reset an IBAN TAX Duration or reset the duration of a robbed bank.
-- The IBAN for the Government Bank Accounts are the same as Config.Banks (VALENTINE, RHODES, etc.).
Config.ResetDurationCommand = { 
    Command    = 'resetibanduration', 
    Suggestion = 'The specified Command is used to reset an IBAN TAX Duration or reset the duration of a robbed bank.',

    -- The specified discord roles will be able to execute the Config.Commands.
    PermittedDiscordRoles  = { 11111111111111, 111111111111111111 },
    
    -- The following groups will be able to execute the Config.Commands.
    AllowlistedGroups = { 'admin' },

}

-- How many members should be able to be added on a Joint Account and have access?
Config.JointAccountMaximumMembers = 4 -- Default is (4) Members + Account Owner = 5 in total.

-- If you don't want to include first IBAN letters, set it the text to empty ( Config.FirstIBANLetters = "" )
Config.FirstIBANLetters = "GR"

-- NPC Rendering Distance which is deleting the npc when being away from the bank.
Config.NPCRenderingDistance = 20.0

-- The year of your server which is based and playing on.
Config.Year = 1890

-- Unlocking Bank Doors.
Config.DoorSystemSetDoorStates = true

-- Set to false if you don't have TP Containers or want to use the Framework storage system.
-- (!) In case the storage system of your framework is not functional, it might not be supported.
Config.tp_containers = { 
    Enabled  = true, 
    Cost     = 50, -- ONLY CASH (FROM BANK ACCOUNT)
    VaultWeightCapacity = 50.0, -- CHANGE IT BASED ON YOUR PREFERENCES (RSG DOES NOT HAVE FLOAT VALUES).

    Notify = "Your bank account does not have enough money to buy the vault.",
}

Config.Options = {
    ['TRANSFERS']        = true, -- Set to false to prevent the players to perform transfers.
    ['JOINT_ACCOUNTS']   = true, -- Set to false to prevent the players to create joint accounts.
}

-----------------------------------------------------------
--[[ Job Salaries ]]--
-----------------------------------------------------------

Config.Salaries = {

    Enabled = false,

    -- Set to false if you don't want to add this transaction into the transaction records.
    -- It can be very frequently based on the salary durations.
    AddSalaryOnTransactionHistory = true,

    Jobs = {

        ['medic'] = { -- JOB NAME (EXAMPLE)

            -- How often should the player receive a salary?
            SalaryDuration = 60, -- Time in minutes (every 1 hour by default).

            -- Salary based on the player job grades.
            Grades = { 
                [0] = 3, -- CASH ONLY.
                [1] = 5, -- CASH ONLY.
            },
        },
        ['stillwaters'] = { -- JOB NAME (EXAMPLE)

            -- How often should the player receive a salary?
            SalaryDuration = 60, -- Time in minutes (every 1 hour by default).

            -- Salary based on the player job grades.
            Grades = { 
                [1] = 3, -- CASH ONLY.
                [2] = 5, -- CASH ONLY.
                [3] = 5, -- CASH ONLY.
                [4] = 1000, -- CASH ONLY.
            },
        },

    },

}

-----------------------------------------------------------
--[[ Bank Locations ]]--
-----------------------------------------------------------

Config.Banks = {

    ['VALENTINE'] = {

        Name = "Valentine Bank",

        Coords = {x = -308.50, y = 776.24, z = 118.75},
        ActionDistance = 1.2,

        Vaults = { -- TP Containers Support (If tp_containers is false, vault coords will not be functional.)
            { 
                 Coords = { x = -9999.0, y = -9999.0, z = -9999.0 }, 
                 ActionDistance = 0.1
            },
        },

        Hours = { Enabled = false, Opening = 7, Closing = 21 },

        BlipData = {
            Enabled = true,
            Title   = "Valentine Bank",
            Sprite  = -2128054417,

            OpenBlipModifier = 'BLIP_MODIFIER_MP_COLOR_32',
            DisplayClosedHours = { Enabled = false, Sprite = -2128054417, BlipModifier = "BLIP_MODIFIER_MP_COLOR_2" },
        },

        NPCData = {
            Enabled = true,
            Model = "S_M_M_BankClerk_01",

            Coords = { x = -308.02, y = 773.82, z = 116.7, h = 18.69},
        },

        Robbery = {

            CanBeRobbed = true,
            
            PoliceJobs = { 'police' },
            MinimumPolice = 0,

            -- Set to false if you want the specified bank to be robbed any day.
            -- Example: PermittedDays = false,
            PermittedDays = false,
            
            StartActionDistance = 4.5, -- The distance to start a robbery while a player is holding a weapon and start shooting.

            -- The specified option cancels an active robbery when the player who started it, leaves the area.
            CancelRobberyDistance = 20.0,
            CancelRobberyTime     = 10, -- Time in seconds (Time to be out of radius before cancelling).

            -- 300 After 5 minutes as default, the Robbery will be successfully start for actions.
            StartTimeCooldown = 10, -- Time in seconds.
            ConvertTimeToText = "5",

            -- The cooldown duration for the players to be able to rob again the specified bank.
            -- (!) 1. In case you are using @PermittedDays, you have to check between the permitted days and the cooldown duration
            -- so it won't skip the permitted day if its the next day, if its not the same day, 24 hours is enough.
            -- (!) 2. In case you are NOT using @PermittedDays, set the proper cooldown duration so the players will be able to rob the
            -- specified bank location again.
            CooldownDuration  = 0, -- Time in minutes (24 HOURS BY DEFAULT).
        },

    },

    ['RHODES'] = {
        Name = "Rhodes Bank",

        Coords = {x = 1294.14, y = -1303.06, z = 77.04},
        ActionDistance = 1.2,

        Vaults = { -- TP Containers Support (If tp_containers is false, vault coords will not be functional.)
            { 
                Coords = { x = -9999.0, y = -9999.0, z = -9999.0 }, 
                ActionDistance = 1.2
            },
        },

        TransactionFees = {
            ['DEPOSIT']  = 2,  -- %
            ['TRANSFER'] = 10, -- %
        },

        Hours = { Enabled = false, Opening = 7, Closing = 21 },

        BlipData = {
            Enabled = true,
            Title   = "Rhodes Bank",
            Sprite  = -2128054417,

            OpenBlipModifier = 'BLIP_MODIFIER_MP_COLOR_32',
            DisplayClosedHours = { Enabled = true, Sprite = -2128054417, BlipModifier = "BLIP_MODIFIER_MP_COLOR_2" },
        },

        NPCData = {
            Enabled = true,
            Model = "S_M_M_BankClerk_01",

            Coords = { x = 1292.84, y = -1304.74, z = 76.04, h = 327.08},
        },

        Robbery = {

            CanBeRobbed = true,
            
            PoliceJobs = { 'police' },
            MinimumPolice = 0,

            -- Set to false if you want the specified bank to be robbed any day.
            -- Example: PermittedDays = false,
            PermittedDays = false,
            
            StartActionDistance = 5.0, -- The distance to start a robbery while a player is holding a weapon and start shooting.

            -- The specified option cancels an active robbery when the player who started it, leaves the area.
            CancelRobberyDistance = 20.0,
            CancelRobberyTime     = 10, -- Time in seconds (Time to be out of radius before cancelling).

            -- 600 After 10 minutes as default, the Robbery will be successfully start for actions.
            StartTimeCooldown  = 10, -- Time in seconds.
            ConvertTimeToText  = "10",

            -- The cooldown duration for the players to be able to rob again the specified bank.
            -- (!) 1. In case you are using @PermittedDays, you have to check between the permitted days and the cooldown duration
            -- so it won't skip the permitted day if its the next day, if its not the same day, 24 hours is enough.
            -- (!) 2. In case you are NOT using @PermittedDays, set the proper cooldown duration so the players will be able to rob the
            -- specified bank location again.
            CooldownDuration  = 0, -- Time in minutes (24 HOURS BY DEFAULT).
        },


    },

    ['SAINTDENIS'] = {
        Name = "Saint Denis Bank",

        Coords = {x = 2644.08, y = -1292.21, z = 52.29},
        ActionDistance = 1.2,

        Vaults = { -- TP Containers Support (If tp_containers is false, vault coords will not be functional.)
            { 
                Coords = { x = -9999.0, y = -9999.0, z = -9999.0 }, 
                ActionDistance = 1.2
            },
        },

        TransactionFees = {
            ['DEPOSIT']  = 2,  -- %
            ['TRANSFER'] = 10, -- %
        },

        Hours = { Enabled = true, Opening = 7, Closing = 21 },

        BlipData = {
            Enabled = true,
            Title   = "Saint Denis Bank",
            Sprite  = -2128054417,

            OpenBlipModifier = 'BLIP_MODIFIER_MP_COLOR_32',
            DisplayClosedHours = { Enabled = true, Sprite = -2128054417, BlipModifier = "BLIP_MODIFIER_MP_COLOR_2" },
        },

        NPCData = {
            Enabled = true,
            Model = "S_M_M_BankClerk_01",

            Coords = { x = 2645.12, y = -1294.37, z = 51.25, h = 30.64},
        },

        Robbery = {

            CanBeRobbed = true,
            
            PoliceJobs = { 'police' },
            MinimumPolice = 5,

            -- Set to false if you want the specified bank to be robbed any day.
            -- Example: PermittedDays = false,
            PermittedDays = {"WEDNESDAY", "SUNDAY"},
            
            StartActionDistance = 5.0, -- The distance to start a robbery while a player is holding a weapon and start shooting.

            -- The specified option cancels an active robbery when the player who started it, leaves the area.
            CancelRobberyDistance = 30.0,
            CancelRobberyTime     = 10, -- Time in seconds (Time to be out of radius before cancelling).

            -- 1200 After 20 minutes as default, the Robbery will be successfully start for actions.
            StartTimeCooldown = 1200, -- Time in seconds.
            ConvertTimeToText = "20",

            -- The cooldown duration for the players to be able to rob again the specified bank.
            -- (!) 1. In case you are using @PermittedDays, you have to check between the permitted days and the cooldown duration
            -- so it won't skip the permitted day if its the next day, if its not the same day, 24 hours is enough.
            -- (!) 2. In case you are NOT using @PermittedDays, set the proper cooldown duration so the players will be able to rob the
            -- specified bank location again.
            CooldownDuration  = 1440, -- Time in minutes (24 HOURS BY DEFAULT).
        },

    },

    ['BLACKWATER'] = {
        Name = "Blackwater Bank",

        Coords = {x = -813.18, y = -1277.60, z = 43.68},
        ActionDistance = 1.2,

        Vaults = { -- TP Containers Support (If tp_containers is false, vault coords will not be functional.)
            { 
                Coords = { x = -9999.0, y = -9999.0, z = -9999.0 }, 
                ActionDistance = 1.2
            },
        },

        TransactionFees = {
            ['DEPOSIT']  = 2,  -- %
            ['TRANSFER'] = 10, -- %
        },

        Hours = { Enabled = true, Opening = 7, Closing = 21 },

        BlipData = {
            Enabled = true,
            Title   = "Blackwater Bank",
            Sprite  = -2128054417,

            OpenBlipModifier = 'BLIP_MODIFIER_MP_COLOR_32',
            DisplayClosedHours = { Enabled = true, Sprite = -2128054417, BlipModifier = "BLIP_MODIFIER_MP_COLOR_2" },
        },

        NPCData = {
            Enabled = true,
            Model = "S_M_M_BankClerk_01",

            Coords = { x = -813.18, y = -1275.42, z = 42.64, h = 176.86},
        },

        Robbery = {

            CanBeRobbed = true,
            
            PoliceJobs = { 'police' },
            MinimumPolice = 4,

            -- Set to false if you want the specified bank to be robbed any day.
            -- Example: PermittedDays = false,
            PermittedDays = {"THURSDAY"},
            
            StartActionDistance = 5.0, -- The distance to start a robbery while a player is holding a weapon and start shooting.

            -- The specified option cancels an active robbery when the player who started it, leaves the area.
            CancelRobberyDistance = 20.0,
            CancelRobberyTime     = 10, -- Time in seconds (Time to be out of radius before cancelling).

            -- 1200 After 20 minutes as default, the Robbery will be successfully start for actions.
            StartTimeCooldown = 1200, -- Time in seconds.
            ConvertTimeToText = "20",

            -- The cooldown duration for the players to be able to rob again the specified bank.
            -- (!) 1. In case you are using @PermittedDays, you have to check between the permitted days and the cooldown duration
            -- so it won't skip the permitted day if its the next day, if its not the same day, 24 hours is enough.
            -- (!) 2. In case you are NOT using @PermittedDays, set the proper cooldown duration so the players will be able to rob the
            -- specified bank location again.
            CooldownDuration  = 1440, -- Time in minutes (24 HOURS BY DEFAULT).
        },

    },

    ['ARMADILLO'] = {
        Name = "Armadillo Bank",

        Coords = {x = -3664.05, y = -2626.57, z = -13.58},
        ActionDistance = 1.2,

        Vaults = { -- TP Containers Support (If tp_containers is false, vault coords will not be functional.)
            { 
                Coords = { x = -9999.0, y = -9999.0, z = -9999.0 }, 
                ActionDistance = 1.2
            },
        },
        
        TransactionFees = {
            ['DEPOSIT']  = 2,  -- %
            ['TRANSFER'] = 10, -- %
        },

        Hours = { Enabled = true, Opening = 7, Closing = 21 },

        BlipData = {
            Enabled = true,
            Title   = "Armadillo Bank",
            Sprite  = -2128054417,

            OpenBlipModifier = 'BLIP_MODIFIER_MP_COLOR_32',
            DisplayClosedHours = { Enabled = true, Sprite = -2128054417, BlipModifier = "BLIP_MODIFIER_MP_COLOR_2" },
        },

        NPCData = {
            Enabled = true,
            Model = "S_M_M_BankClerk_01",

            Coords = { x = -3663.98, y = -2628.69, z = -14.58, h = 358.15},
        },

        Robbery = {
            CanBeRobbed = false, -- DISABLED BY DEFAULT, DOES NOT EXIST ON CONFIG.ROBBERIES.

            PoliceJobs = { 'police' },
            MinimumPolice = 4,

            -- Set to false if you want the specified bank to be robbed any day.
            -- Example: PermittedDays = false,
            PermittedDays = false,
            
            StartActionDistance = 5.0, -- The distance to start a robbery while a player is holding a weapon and start shooting.

            -- The specified option cancels an active robbery when the player who started it, leaves the area.
            CancelRobberyDistance = 20.0,
            CancelRobberyTime     = 10, -- Time in seconds (Time to be out of radius before cancelling).

            -- 1200 After 20 minutes as default, the Robbery will be successfully start for actions.
            StartTimeCooldown = 1200, -- Time in seconds.
            ConvertTimeToText = "20",

            -- The cooldown duration for the players to be able to rob again the specified bank.
            -- (!) 1. In case you are using @PermittedDays, you have to check between the permitted days and the cooldown duration
            -- so it won't skip the permitted day if its the next day, if its not the same day, 24 hours is enough.
            -- (!) 2. In case you are NOT using @PermittedDays, set the proper cooldown duration so the players will be able to rob the
            -- specified bank location again.
            CooldownDuration  = 1440, -- Time in minutes (24 HOURS BY DEFAULT).
        },

    }
}

-----------------------------------------------------------
--[[ Robberies ]]--
-----------------------------------------------------------

Config.Robberies = {

    ['VALENTINE'] = { -- <- MUST BE THE SAME NAME AS Config.Banks.

        [1] = { 

            Coords = {x = -308.676, y = 765.2438, z = 118.70, h = 14.472027778625}, 
            ActionDistance = 0.3, -- MUST BE VERY CLOSE DISTANCE SO IT WON'T INTERACT WITH THE OTHER ONES.

            Label = "~e~Press G To Unlock Documents Vault",
            DisplayLabelDistance = 5.0,

            ExecuteActionType = "lockpick",
    
            RequiredItem = { name = "lockpick", label = "Lockpick", remove = true },
    
            -- @param withdrawFromBankAccount : To withdraw a percent from the government total bank account of valentine.
            -- Set: withdrawFromBankAccount = 0 to disable it.
            Accounts = {
              ['CASH'] = { min = 0, max = 0, withdrawFromBankAccount = 5 }, -- @withdrawFromBankAccount to PERCENT (%).
              ['GOLD'] = { min = 0, max = 0 }, -- GOVERNMENT BANK ACCOUNTS DOES NOT SUPPORT GOLD, THE GIVEN GOLD IS ALWAYS FROM THE SYSTEM.
            },
    
            ItemRewards = {

                TotalGivenItems = 2,

                -- To cancel item rewards, set Items = false
                Items = {
                    { name = "goldcoin",     label = "Gold Coin",     quantity = { min = 1, max = 2 }, chance = 100 },
                    { name = "goldfragment", label = "Gold Fragment", quantity = { min = 1, max = 2 }, chance = 70 },
                },

            },

        },
      
        [2] = { 
              
            Coords = {x = -308.223, y = 762.6579, z = 118.70, h = 193.15171813965}, 
            ActionDistance = 0.3, -- MUST BE VERY CLOSE DISTANCE SO IT WON'T INTERACT WITH THE OTHER ONES.

            Label = "~e~Press G To Unlock Documents Vault",
            DisplayLabelDistance = 5.0,

            ExecuteActionType = "lockpick",
    
            RequiredItem = { name = "lockpick", label = "Lockpick", remove = true },
    
            -- @param withdrawFromBankAccount : To withdraw a percent from the government total bank account of valentine.
            -- Set: withdrawFromBankAccount = 0 to disable it.
            Accounts = {
                ['CASH'] = { min = 0, max = 0, withdrawFromBankAccount = 5 }, -- @withdrawFromBankAccount to PERCENT (%).
                ['GOLD'] = { min = 0, max = 0 }, -- GOVERNMENT BANK ACCOUNTS DOES NOT SUPPORT GOLD, THE GIVEN GOLD IS ALWAYS FROM THE SYSTEM.
            },  
    
            ItemRewards = {

                TotalGivenItems = 2,

                -- To cancel item rewards, set Items = false
                Items = {
                    { name = "goldcoin",     label = "Gold Coin",     quantity = { min = 1, max = 2 }, chance = 100 },
                    { name = "goldfragment", label = "Gold Fragment", quantity = { min = 1, max = 2 }, chance = 70 },
                },

            },

        },
      
        [3] = { 
            Coords = {x = -309.248, y = 764.9139, z = 118.70, h = 106.23197174072}, 
            ActionDistance = 0.3, -- MUST BE VERY CLOSE DISTANCE SO IT WON'T INTERACT WITH THE OTHER ONES.

            Label = "~e~Press G To Crack Safe Vault",
            DisplayLabelDistance = 5.0,

            ExecuteActionType = "safe",
            
            RequiredItem = { name = "safecracking", label = "Hearing Tool", remove = false },
    
            -- @param withdrawFromBankAccount : To withdraw a percent from the government total bank account of valentine.
            -- Set: withdrawFromBankAccount = 0 to disable it.
            Accounts = {
                ['CASH'] = { min = 0, max = 0, withdrawFromBankAccount = 5 }, -- @withdrawFromBankAccount to PERCENT (%).
                ['GOLD'] = { min = 0, max = 0 }, -- GOVERNMENT BANK ACCOUNTS DOES NOT SUPPORT GOLD, THE GIVEN GOLD IS ALWAYS FROM THE SYSTEM.
            },  
    
            ItemRewards = {

                TotalGivenItems = 1,

                -- To cancel item rewards, set Items = false
                Items = {
                    { name = "goldcoin", label = "Gold Coin", quantity = { min = 2, max = 3 }, chance = 100 },
                },

            },

        },
  
        [4] = { 
            Coords = {x = -309.001, y = 763.8175, z = 118.70, h = 101.49152374268}, 
            ActionDistance = 0.3, -- MUST BE VERY CLOSE DISTANCE SO IT WON'T INTERACT WITH THE OTHER ONES.

            Label = "~e~Press G To Crack Safe Vault",
            DisplayLabelDistance = 5.0,

            ExecuteActionType = "safe",
            
            RequiredItem = { name = "safecracking", label = "Hearing Tool", remove = false },
    
            -- @param withdrawFromBankAccount : To withdraw a percent from the government total bank account of valentine.
            -- Set: withdrawFromBankAccount = 0 to disable it.
            Accounts = {
                ['CASH'] = { min = 0, max = 0, withdrawFromBankAccount = 5 }, -- @withdrawFromBankAccount to PERCENT (%).
                ['GOLD'] = { min = 0, max = 0 }, -- GOVERNMENT BANK ACCOUNTS DOES NOT SUPPORT GOLD, THE GIVEN GOLD IS ALWAYS FROM THE SYSTEM.
            },  
    
            ItemRewards = {

                TotalGivenItems = 1,

                -- To cancel item rewards, set Items = false
                Items = {
                    { name = "goldcoin", label = "Gold Coin", quantity = { min = 2, max = 3 }, chance = 100 },
                },

            },

        },
  
        [5] = { 
            Coords = {x = -308.897, y = 762.8575, z = 118.70, h = 113.36629486084}, 
            ActionDistance = 0.3, -- MUST BE VERY CLOSE DISTANCE SO IT WON'T INTERACT WITH THE OTHER ONES.

            Label = "~e~Press G To Crack Safe Vault",
            DisplayLabelDistance = 5.0,

            ExecuteActionType = "safe",
            
            RequiredItem = { name = "safecracking", label = "Hearing Tool", remove = false },
    
            -- @param withdrawFromBankAccount : To withdraw a percent from the government total bank account of valentine.
            -- Set: withdrawFromBankAccount = 0 to disable it.
            Accounts = {
                ['CASH'] = { min = 0, max = 0, withdrawFromBankAccount = 5 }, -- @withdrawFromBankAccount to PERCENT (%).
                ['GOLD'] = { min = 0, max = 0 }, -- GOVERNMENT BANK ACCOUNTS DOES NOT SUPPORT GOLD, THE GIVEN GOLD IS ALWAYS FROM THE SYSTEM.
            },  
    
            ItemRewards = {

                TotalGivenItems = 1,

                -- To cancel item rewards, set Items = false
                Items = {
                    { name = "goldcoin", label = "Gold Coin", quantity = { min = 2, max = 3 }, chance = 100 },
                },

            },

        },
    },

    ['RHODES'] = { -- <- MUST BE THE SAME NAME AS Config.Banks.

        [1] = { 
            Coords = {x = 1286.468, y = -1315.40, z = 77.039, h = 148.10264587402}, 
            ActionDistance = 0.3, -- MUST BE VERY CLOSE DISTANCE SO IT WON'T INTERACT WITH THE OTHER ONES.

            Label = "~e~Press G To Unlock Documents Vault",
            DisplayLabelDistance = 5.0,

            ExecuteActionType = "lockpick",
    
            RequiredItem = { name = "lockpick", label = "Lockpick", remove = true },
    
            -- @param withdrawFromBankAccount : To withdraw a percent from the government total bank account of valentine.
            -- Set: withdrawFromBankAccount = 0 to disable it.
            Accounts = {
                ['CASH'] = { min = 0, max = 0, withdrawFromBankAccount = 5 }, -- @withdrawFromBankAccount to PERCENT (%).
                ['GOLD'] = { min = 0, max = 0 }, -- GOVERNMENT BANK ACCOUNTS DOES NOT SUPPORT GOLD, THE GIVEN GOLD IS ALWAYS FROM THE SYSTEM.
            },  
    
            ItemRewards = {

                TotalGivenItems = 1,

                -- To cancel item rewards, set Items = false
                Items = {
                    { name = "goldcoin", label = "Gold Coin", quantity = { min = 2, max = 3 }, chance = 100 },
                },

            },

        },
    
        [2] = { 

            Coords = {x = 1288.132, y = -1313.46, z = 77.039, h = 322.96502685547}, 
            ActionDistance = 0.3, -- MUST BE VERY CLOSE DISTANCE SO IT WON'T INTERACT WITH THE OTHER ONES.

            Label = "~e~Press G To Unlock Documents Vault",
            DisplayLabelDistance = 5.0,

            ExecuteActionType = "lockpick",
    
            RequiredItem = { name = "lockpick", label = "Lockpick", remove = true },

            -- @param withdrawFromBankAccount : To withdraw a percent from the government total bank account of valentine.
            -- Set: withdrawFromBankAccount = 0 to disable it.
            Accounts = {
                ['CASH'] = { min = 0, max = 0, withdrawFromBankAccount = 5 }, -- @withdrawFromBankAccount to PERCENT (%).
                ['GOLD'] = { min = 0, max = 0 }, -- GOVERNMENT BANK ACCOUNTS DOES NOT SUPPORT GOLD, THE GIVEN GOLD IS ALWAYS FROM THE SYSTEM.
            },  
    
            ItemRewards = {

                TotalGivenItems = 1,

                -- To cancel item rewards, set Items = false
                Items = {
                    { name = "goldcoin", label = "Gold Coin", quantity = { min = 2, max = 3 }, chance = 100 },
                },

            },

        },

        [3] = { 
            Coords = {x = 1287.130, y = -1315.57, z = 77.039, h = 244.24691772461}, 
            ActionDistance = 0.3, -- MUST BE VERY CLOSE DISTANCE SO IT WON'T INTERACT WITH THE OTHER ONES.

            Label = "~e~Press G To Crack Safe Vault",
            DisplayLabelDistance = 5.0,

            ExecuteActionType = "safe",
            
            RequiredItem = { name = "safecracking", label = "Hearing Tool", remove = false },

            -- @param withdrawFromBankAccount : To withdraw a percent from the government total bank account of valentine.
            -- Set: withdrawFromBankAccount = 0 to disable it.
            Accounts = {
                ['CASH'] = { min = 0, max = 0, withdrawFromBankAccount = 5 }, -- @withdrawFromBankAccount to PERCENT (%).
                ['GOLD'] = { min = 0, max = 0 }, -- GOVERNMENT BANK ACCOUNTS DOES NOT SUPPORT GOLD, THE GIVEN GOLD IS ALWAYS FROM THE SYSTEM.
            },  
    
            ItemRewards = {

                TotalGivenItems = 1,

                -- To cancel item rewards, set Items = false
                Items = {
                    { name = "goldcoin", label = "Gold Coin", quantity = { min = 2, max = 3 }, chance = 100 },
                },

            },

        },
    
        [4] = { 

            Coords = {x = 1287.710, y = -1314.81, z = 77.039, h = 242.46014404297}, 
            ActionDistance = 0.3, -- MUST BE VERY CLOSE DISTANCE SO IT WON'T INTERACT WITH THE OTHER ONES.

            Label = "~e~Press G To Crack Safe Vault",
            DisplayLabelDistance = 5.0,

            ExecuteActionType = "safe",
            
            RequiredItem = { name = "safecracking", label = "Hearing Tool", remove = false },

            -- @param withdrawFromBankAccount : To withdraw a percent from the government total bank account of valentine.
            -- Set: withdrawFromBankAccount = 0 to disable it.
            Accounts = {
                ['CASH'] = { min = 0, max = 0, withdrawFromBankAccount = 5 }, -- @withdrawFromBankAccount to PERCENT (%).
                ['GOLD'] = { min = 0, max = 0 }, -- GOVERNMENT BANK ACCOUNTS DOES NOT SUPPORT GOLD, THE GIVEN GOLD IS ALWAYS FROM THE SYSTEM.
            },  
    
            ItemRewards = {

                TotalGivenItems = 1,

                -- To cancel item rewards, set Items = false
                Items = {
                    { name = "goldcoin", label = "Gold Coin", quantity = { min = 2, max = 3 }, chance = 100 },
                },

            },

        },
    
        [5] = { 

            Coords = {x = 1288.405, y = -1314.03, z = 77.039, h = 236.73678588867}, 
            ActionDistance = 0.3, -- MUST BE VERY CLOSE DISTANCE SO IT WON'T INTERACT WITH THE OTHER ONES.

            Label = "~e~Press G To Crack Safe Vault",
            DisplayLabelDistance = 5.0,

            ExecuteActionType = "safe",
            
            RequiredItem = { name = "safecracking", label = "Hearing Tool", remove = false },

            -- @param withdrawFromBankAccount : To withdraw a percent from the government total bank account of valentine.
            -- Set: withdrawFromBankAccount = 0 to disable it.
            Accounts = {
                ['CASH'] = { min = 0, max = 0, withdrawFromBankAccount = 5 }, -- @withdrawFromBankAccount to PERCENT (%).
                ['GOLD'] = { min = 0, max = 0 }, -- GOVERNMENT BANK ACCOUNTS DOES NOT SUPPORT GOLD, THE GIVEN GOLD IS ALWAYS FROM THE SYSTEM.
            },  
    
            ItemRewards = {

                TotalGivenItems = 1,

                -- To cancel item rewards, set Items = false
                Items = {
                    { name = "goldcoin", label = "Gold Coin", quantity = { min = 2, max = 3 }, chance = 100 },
                },

            },

        },

    },

    ['SAINTDENIS'] = { -- <- MUST BE THE SAME NAME AS Config.Banks.

        [1] = { 
            Coords = {x = 2640.891, y = -1301.84, z = 52.246, h = 120.25629425049}, 
            ActionDistance = 0.3, -- MUST BE VERY CLOSE DISTANCE SO IT WON'T INTERACT WITH THE OTHER ONES.

            Label = "~e~Press G To Unlock Documents Vault",
            DisplayLabelDistance = 5.0,

            ExecuteActionType = "lockpick",
    
            RequiredItem = { name = "lockpick", label = "Lockpick", remove = true },

            -- @param withdrawFromBankAccount : To withdraw a percent from the government total bank account of valentine.
            -- Set: withdrawFromBankAccount = 0 to disable it.
            Accounts = {
                ['CASH'] = { min = 0, max = 0, withdrawFromBankAccount = 5 }, -- @withdrawFromBankAccount to PERCENT (%).
                ['GOLD'] = { min = 0, max = 0 }, -- GOVERNMENT BANK ACCOUNTS DOES NOT SUPPORT GOLD, THE GIVEN GOLD IS ALWAYS FROM THE SYSTEM.
            },  
    
            ItemRewards = {

                TotalGivenItems = 1,

                -- To cancel item rewards, set Items = false
                Items = {
                    { name = "goldcoin", label = "Gold Coin", quantity = { min = 2, max = 3 }, chance = 100 },
                },

            },

        },

        [2] = { 
            Coords = {x = 2642.950, y = -1306.25, z = 52.246, h = 127.1852722168}, 
            ActionDistance = 0.3, -- MUST BE VERY CLOSE DISTANCE SO IT WON'T INTERACT WITH THE OTHER ONES.

            Label = "~e~Press G To Unlock Documents Vault",
            DisplayLabelDistance = 5.0,

            ExecuteActionType = "lockpick",
    
            RequiredItem = { name = "lockpick", label = "Lockpick", remove = true },

            -- @param withdrawFromBankAccount : To withdraw a percent from the government total bank account of valentine.
            -- Set: withdrawFromBankAccount = 0 to disable it.
            Accounts = {
                ['CASH'] = { min = 0, max = 0, withdrawFromBankAccount = 5 }, -- @withdrawFromBankAccount to PERCENT (%).
                ['GOLD'] = { min = 0, max = 0 }, -- GOVERNMENT BANK ACCOUNTS DOES NOT SUPPORT GOLD, THE GIVEN GOLD IS ALWAYS FROM THE SYSTEM.
            },  
    
            ItemRewards = {

                TotalGivenItems = 1,

                -- To cancel item rewards, set Items = false
                Items = {
                    { name = "goldcoin", label = "Gold Coin", quantity = { min = 2, max = 3 }, chance = 100 },
                },

            },

        },

        [3] = { 
            Coords = {x = 2645.535, y = -1305.95, z = 52.246, h = 313.06442260742}, 
            ActionDistance = 0.3, -- MUST BE VERY CLOSE DISTANCE SO IT WON'T INTERACT WITH THE OTHER ONES.

            Label = "~e~Press G To Unlock Documents Vault",
            DisplayLabelDistance = 5.0,

            ExecuteActionType = "lockpick",
    
            RequiredItem = { name = "lockpick", label = "Lockpick", remove = true },

            -- @param withdrawFromBankAccount : To withdraw a percent from the government total bank account of valentine.
            -- Set: withdrawFromBankAccount = 0 to disable it.
            Accounts = {
                ['CASH'] = { min = 0, max = 0, withdrawFromBankAccount = 5 }, -- @withdrawFromBankAccount to PERCENT (%).
                ['GOLD'] = { min = 0, max = 0 }, -- GOVERNMENT BANK ACCOUNTS DOES NOT SUPPORT GOLD, THE GIVEN GOLD IS ALWAYS FROM THE SYSTEM.
            },  
    
            ItemRewards = {

                TotalGivenItems = 1,

                -- To cancel item rewards, set Items = false
                Items = {
                    { name = "goldcoin", label = "Gold Coin", quantity = { min = 2, max = 3 }, chance = 100 },
                },

            },

        },
    
        [4] = { 
            Coords = {x = 2644.734, y = -1304.31, z = 52.246, h = 310.48950195313}, 
            ActionDistance = 0.3, -- MUST BE VERY CLOSE DISTANCE SO IT WON'T INTERACT WITH THE OTHER ONES.

            Label = "~e~Press G To Unlock Documents Vault",
            DisplayLabelDistance = 5.0,

            ExecuteActionType = "lockpick",
    
            RequiredItem = { name = "lockpick", label = "Lockpick", remove = true },

            -- @param withdrawFromBankAccount : To withdraw a percent from the government total bank account of valentine.
            -- Set: withdrawFromBankAccount = 0 to disable it.
            Accounts = {
                ['CASH'] = { min = 0, max = 0, withdrawFromBankAccount = 5 }, -- @withdrawFromBankAccount to PERCENT (%).
                ['GOLD'] = { min = 0, max = 0 }, -- GOVERNMENT BANK ACCOUNTS DOES NOT SUPPORT GOLD, THE GIVEN GOLD IS ALWAYS FROM THE SYSTEM.
            },  
    
            ItemRewards = {

                TotalGivenItems = 1,

                -- To cancel item rewards, set Items = false
                Items = {
                    { name = "goldcoin", label = "Gold Coin", quantity = { min = 2, max = 3 }, chance = 100 },
                },

            },

        },

    },

    ['BLACKWATER'] = { -- <- MUST BE THE SAME NAME AS Config.Banks.

        [1] = { 

            Coords = {x = -821.021, y = -1274.64, z = 43.645, h = 102.07998657227}, 
            ActionDistance = 0.3, -- MUST BE VERY CLOSE DISTANCE SO IT WON'T INTERACT WITH THE OTHER ONES.

            Label = "~e~Press G To Unlock Documents Vault",
            DisplayLabelDistance = 5.0,

            ExecuteActionType = "lockpick",
    
            RequiredItem = { name = "lockpick", label = "Lockpick", remove = true },
    
            -- @param withdrawFromBankAccount : To withdraw a percent from the government total bank account of valentine.
            -- Set: withdrawFromBankAccount = 0 to disable it.
            Accounts = {
                ['CASH'] = { min = 0, max = 0, withdrawFromBankAccount = 5 }, -- @withdrawFromBankAccount to PERCENT (%).
                ['GOLD'] = { min = 0, max = 0 }, -- GOVERNMENT BANK ACCOUNTS DOES NOT SUPPORT GOLD, THE GIVEN GOLD IS ALWAYS FROM THE SYSTEM.
            },  
    
            ItemRewards = {

                TotalGivenItems = 1,

                -- To cancel item rewards, set Items = false
                Items = {
                    { name = "goldcoin", label = "Gold Coin", quantity = { min = 2, max = 3 }, chance = 100 },
                },

            },

        },

        [2] = { 
            Coords = {x = -820.942, y = -1273.60, z = 43.646, h = 99.129974365234}, 
            ActionDistance = 0.3, -- MUST BE VERY CLOSE DISTANCE SO IT WON'T INTERACT WITH THE OTHER ONES.

            Label = "~e~Press G To Unlock Documents Vault",
            DisplayLabelDistance = 5.0,

            ExecuteActionType = "lockpick",
    
            RequiredItem = { name = "lockpick", label = "Lockpick", remove = true },
    
            -- @param withdrawFromBankAccount : To withdraw a percent from the government total bank account of valentine.
            -- Set: withdrawFromBankAccount = 0 to disable it.
            Accounts = {
                ['CASH'] = { min = 0, max = 0, withdrawFromBankAccount = 5 }, -- @withdrawFromBankAccount to PERCENT (%).
                ['GOLD'] = { min = 0, max = 0 }, -- GOVERNMENT BANK ACCOUNTS DOES NOT SUPPORT GOLD, THE GIVEN GOLD IS ALWAYS FROM THE SYSTEM.
            },  
    
            ItemRewards = {

                TotalGivenItems = 1,

                -- To cancel item rewards, set Items = false
                Items = {
                    { name = "goldcoin", label = "Gold Coin", quantity = { min = 2, max = 3 }, chance = 100 },
                },

            },

        },

        [3] = { 
            Coords = {x = -820.062, y = -1273.45, z = 43.651, h = 5.0368585586548}, 
            ActionDistance = 0.3, -- MUST BE VERY CLOSE DISTANCE SO IT WON'T INTERACT WITH THE OTHER ONES.

            Label = "~e~Press G To Crack Safe Vault",
            DisplayLabelDistance = 5.0,

            ExecuteActionType = "safe",
            
            RequiredItem = { name = "safecracking", label = "Hearing Tool", remove = false },
    
            -- @param withdrawFromBankAccount : To withdraw a percent from the government total bank account of valentine.
            -- Set: withdrawFromBankAccount = 0 to disable it.
            Accounts = {
                ['CASH'] = { min = 0, max = 0, withdrawFromBankAccount = 5 }, -- @withdrawFromBankAccount to PERCENT (%).
                ['GOLD'] = { min = 0, max = 0 }, -- GOVERNMENT BANK ACCOUNTS DOES NOT SUPPORT GOLD, THE GIVEN GOLD IS ALWAYS FROM THE SYSTEM.
            },  
    
            ItemRewards = {

                TotalGivenItems = 1,

                -- To cancel item rewards, set Items = false
                Items = {
                    { name = "goldcoin", label = "Gold Coin", quantity = { min = 2, max = 3 }, chance = 100 },
                },

            },

        },

        [4] = { 
            Coords = {x = -818.603, y = -1273.45, z = 43.661, h = 12.877991676331}, 
            ActionDistance = 0.3, -- MUST BE VERY CLOSE DISTANCE SO IT WON'T INTERACT WITH THE OTHER ONES.

            Label = "~e~Press G To Crack Safe Vault",
            DisplayLabelDistance = 5.0,

            ExecuteActionType = "safe",
            
            RequiredItem = { name = "safecracking", label = "Hearing Tool", remove = false },
    
            -- @param withdrawFromBankAccount : To withdraw a percent from the government total bank account of valentine.
            -- Set: withdrawFromBankAccount = 0 to disable it.
            Accounts = {
                ['CASH'] = { min = 0, max = 0, withdrawFromBankAccount = 5 }, -- @withdrawFromBankAccount to PERCENT (%).
                ['GOLD'] = { min = 0, max = 0 }, -- GOVERNMENT BANK ACCOUNTS DOES NOT SUPPORT GOLD, THE GIVEN GOLD IS ALWAYS FROM THE SYSTEM.
            },  
    
            ItemRewards = {

                TotalGivenItems = 1,

                -- To cancel item rewards, set Items = false
                Items = {
                    { name = "goldcoin", label = "Gold Coin", quantity = { min = 2, max = 3 }, chance = 100 },
                },

            },

        },

    },

}

-----------------------------------------------------------
--[[ Discord Webhook Logs ]]--
-----------------------------------------------------------

-- (!) Checkout tp_libs/server/webhooks.lua to modify the webhook urls.

Config.DiscordWebhooking = {

    ['TRANSACTIONS'] = { -- Used for transactions, such as deposit, withdraw, transfers.
        Enabled = true,
        Color = 10038562,
    },

    ['ROBBERIES'] = { -- Used for bank robberies.
        Enabled = false,
        Color = 10038562,
    },

}