Config = {}

-- For EXPORT and integration instructions, refer to the README.md.
-- The README.md also details how to connect this system with external skill trees or other frameworks with explicit instructions with specific examples for the params.

----  MAIN SETTINGS  ----
Config.CombatRoll = true          -- Activates the script... If you want to use the script as a dependency just for the exports, and not allow to roll from the script within, then set to false.
-- if Config.TakeOverDive below is set to false, then you can still dive by pressing SPACE, and you can rolling by pressing SHIFT + SPACE, applicable only when Config.RollOnlyWhenAiming is true
Config.TakeOverDive = false        -- if true then it will completely replace the dive with rolling,
-- I only suggest this if Config.SmoothCustom is true
Config.RollWhenAiming = true
Config.RollOnlyWhenAiming = false -- If set to false, then you allow rolling while not aiming by holding CONTROL + SPACE or if Config.TakeOverDive aim + space
-- This is a must if Config.RollOnlyWhenAiming is false, I suggest setting it to false if Config.RollOnlyWhenAiming = true
Config.SmoothCustom = true        -- if true then it will enable smooth custom animation transitions, but they're not accurate in direction since they don't immediately cancel player's tasks

Config.INPUT_DUCK = 'INPUT_DUCK' -- This is in order the player can customize the input for crouching

-- Keep in mind that if Config.INPUT_DUCK = 'INPUT_DUCK' and the option below is true then the player will crouch for a second before rolling making it look a little weird
Config.StillAllow_INPUT_DUCK_WhenAiming = true -- if true then it will allow the player to perform actions that Config.INPUT_DUCK performs (like crouch if Config.INPUT_DUCK = 'INPUT_DUCK') while aiming

----  PREFERENCE SETTINGS  ----
Config.RollCoolDown = 200          -- time in ms, to where the player can't roll again after rolling
Config.StaminaDrain = 20.0         -- How much stamina to drain per roll, 20.0 is how much is drained from diving
Config.StaminaRequirement = 10.0
Config.AllowFirstPersonCam = false -- if true then it will allow the first person camera

-- My personal favorite settings are


-- Config.CombatRoll = true           -- To activate the script obviously
-- Config.TakeOverDive = false        -- if true then it will completely replace the dive with rolling,
-- Config.RollOnlyWhenAiming = false  -- If set to false, then you allow rolling while not aiming by holding CONTROL + SPACE
-- Config.SmoothCustom = true         -- if true then it will enable smooth custom animation transitions, but they're not accurate in direction since they don't immediately cancel player's tasks

-- Config.RollCoolDown = 200          -- time in ms, to where the player can't roll again after rolling
-- Config.StaminaDrain = 20.0         -- How much stamina to drain per roll, 20.0 is how much is drained from diving
-- Config.StaminaRequirement = 10.0
-- Config.AllowFirstPersonCam = false -- if true then it will allow the first person camera
