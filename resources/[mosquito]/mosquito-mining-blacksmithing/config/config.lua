Config = {}

Config.Debug = true  -- Set to false to enable print debug prints and initiate the script live.
Config.DrawDebugMarkers = false -- Set to false to disable drawing markers, this is useful for performance, but you won't see the markers on the map
Config.AllowMiningCancel = true -- Allows players to cancel mining before rewards are rolled/awarded
Config.AllowPublicForgeUse = false -- If true, anyone can use player-placed forges/tools (smelter, anvil, grindstone), ignoring owner/employee restrictions

-- legacy versions of vorp_inventory support, just a fallback in case you do get errors in the future.
Config.UseLegacyGetItem = false             -- true = getItemContainingMetadata | false = new getItem with manual callback
Config.UseLegacyMetadatUpdate = false -- true = subItem/addItem metadata updates | false = setItemMetadata in-place updates

Config.AdminAce = "mosquito.mining"

-- IGNORE THIS IF YOU DON'T NOTICE IT
-- -[ NODE FINDING AND CHECKING ]-
Config.CoordCheckerEfficiency = 3 -- How many times will the coord check function will be called per 50ms, the higher the more efficient the script but the more delayed.
Config.MineDistance = 2.0 -- Distance to interact with mine prompt
Config.UseLookAtNodePrompt = true -- If true, prompt shows up only when looking at the node; if false, prompt shows up based on distance only
Config.RayCastDistance = 4.0 -- Distance to raycast for the node, if the player is looking at the node, only if UseLookAtNodePrompt is true
Config.HighlightNodeProps = true -- Highlight the node props when the player is near them
Config.ShowNodeNumberInPrompt = true -- Show the node number in the prompt, this is useful for debugging and testing, set to false to disable it

-- Keep in mind that these are relatively performance heavy, but only if the player is mining with pickaxe in hand
-- -[ SMART MINING AND ANIMATIONs ]-
Config.SmartMiningAnimation = true -- This will calculate a position for the player's ped to walk to and then position himself properly, ensuring the animation plays realistically while facing the rock node almost 100% of the time.
Config.SmartZDifference = true   -- If true then it will play a "mining striking down" animation based on the ZDifference variable in each mine table in config_mines.lua
Config.InitSoundAudio = true -- If you have issues with the mining animation not playing any sound, then set this to true, it will force request the audio dict to be loaded

-- -[ PROMPTS AND UI DISPLAY ]-
-- No need to touch what's below if you don't care to change the UI
Config.DisplayDurabilityAsText = true -- It's relatively performance heavy to display the durability as a text, but you won't sense it.
Config.DisplayDurabilityPrompt = true -- Display the durability as a prompt, if the above is set to false, you can have either this or the one above, or both
Config.DisplayDurabilityPromptOnlyOnBack = true -- Display the durability as the prompt only when the pickaxe is unequipped
Config.DisplayDurabilityTextAlign = "top" -- Text alignment for the durability text, can be "top", "bottom", "left" or "right"
Config.DisplayTextOffset = {-1.0, 0.5} -- X, Y offset for the text

-- -[ MININGAME CONFIGURATION ]-
Config.MiniGame = true                   -- Set to false to disable the minigame and rely on probabilities only
Config.MiniGameAsMineAccurately = false -- If set to true, then mining using the minigame will be an option as "Mine Accurately" while keeping the prompt to mine normally using RNG and probablity chance
Config.MiniGameDynamicSpeed = true -- Set to true to make the minigame bar move at a linear dynamic speed, makes it less predictable
Config.MiniGameMaxIconSize = 0.5   -- Maximum size of the icons
-- You don't need to change this, since you can already change it in config_mines.lua for each specific mine and material based off their types and probabilities
Config.MiniGameOverAllIconSizeMultiplier = 1.0 -- Overall size of the icons multiplier, don't change without testing, you might destroy your probability balance
Config.MiniGameDifficultyForLowLevel = { -- if you set Config.MiniGameDifficultyForLowLevel = false, then the players just won't be able to mine in this mine at allow
    speed = 10.0,
    size = 0.5,
}
-- Config.MiniGameDifficultyForLowLevel = false -- Example of disabling the minigame completely for low level players

-- NOTE ⚠️: If you want mining using the minigame only, then set Config.MiniGameAsMineAccurately to false, while Config.MiniGame to true
-- Otherwise if Config.MiniGame is set to false, then the minigame will not be used at all

-- - -[ MINING JOBS CONFIGURATION ]-
Config.JobCommand = "job" -- this prints the command on screen, set to false to disable the job command
Config.MinerJobs = { -- These jobs only matter if the person is using a steel pickaxe, if they are using a normal pickaxe, then the jobProbability will be ignored
    "miner",
    "miner2",
    "gtmining",
    "erminer",
    "sdminer",
    "lpminer",
    "guarmamining",
}
-- if a jobProbability value is set for the item reward table in the config_mines, then it will overwrite this value
Config.MinerJobProbabilityIncrease = 1.5 -- Increase the chance of getting a rare item by double the chance if the player has the miner job, set to false to disable


Config.Controls = {
    EquipPickaxe = 0x6319DB71,       -- Up arrow
    Mine = 0x27D1C284,               -- R
    MineCancel = 0x156F7119,         -- Backspace
    PickUpDrop = 0x41AC83D1,         -- E
    Grindstone = 0x5415BE48,         -- G
    Smelter = 0x5415BE48,            -- G
    RockCrusher = 0x5415BE48,        -- G
    MineAccurate = 0xA1ABB953,       -- G
    Anvil = 0x5415BE48,              -- G
    AnvilRepair = 0x05CA7C52,        -- Down Arrow
    forgeRemoveControl = 0x05CA7C52, -- Down arrow
    choreControl = 0x39336A4F
}

-- -[ LIMITATIONS AND DISABLERS CONFIGURATION ]-
Config.WalkSpeed = 2.0 -- Walk/run speed while holding the pickaxe in hand, set to false to be able to run, and make sure to remove shift from the disabled controls
Config.UnarmedOnly = true -- if true then when holding the pickaxe, it forces the player to always be unarmed, leave true.
Config.DisabledControls = { -- Disable controls while shoveling, sharpening, this is to prevent the player from doing other things while mining, causing buggy animations
    0xB2F377E8, -- Attack
    0x07CE1E61, -- Melee Attack 1
    0x018C47CF, -- E
    0x2277FAE9, -- E
    0x91C9A817, -- E
    0xF84FA74F, -- MOUSE2
    0xCEE12B50, -- MOUSE3
    0x8FFC75D6, -- Shift
    0xD9D0E1C0, -- SPACE (Jump)
    0xF3830D8E, -- J
    0x80F28E95, -- L
    0xDB096B85, -- CTRL
    0xE30CD707, -- R
    0x3C0A40F2, -- Melee Block
    0xCF8A4ECA, -- Weapon Wheel
    0x6D0D35E2, -- Reload
    0x24B99FDE, -- Zoom
    0x7DA48D2A, -- X
    0x43CDA5B0, -- Z
    0x26E9DC00, -- Z
    0x06052D11, -- Q
    0x1ECA87D4, -- Q
    0xDE794E3E, -- Q
    0xE885EF16, -- Q
    0x8CC9CD42, -- X
    0x827E9EE8, -- X
    0xC1989F95,             -- I
}

Config.PickaxeInHandDisabledControls = { -- Disable controls while mining and sharpening, this is to prevent the player from doing other things while mining, causing buggy animations
    0xB2F377E8,             -- Attack
    0x07CE1E61,             -- Melee Attack 1
    0x018C47CF,             -- E
    0x2277FAE9,             -- E
    0x91C9A817,             -- E
    0xF84FA74F,             -- MOUSE2
    0xCEE12B50,             -- MOUSE3
    -- 0x8FFC75D6,             -- Shift
    0xD9D0E1C0,             -- SPACE (Jump)
    0xF3830D8E,             -- J
    0x80F28E95,             -- L
    -- 0xDB096B85,             -- CTRL
    0xE30CD707,             -- R
    0x3C0A40F2,             -- Melee Block
    0xCF8A4ECA,             -- Weapon Wheel
    0x6D0D35E2,             -- Reload
    0x24B99FDE,             -- Zoom
    0x7DA48D2A,             -- X
    0x43CDA5B0,             -- Z
    0x26E9DC00,             -- Z
    0x06052D11,             -- Q
    0x1ECA87D4,             -- Q
    0xDE794E3E,             -- Q
    0xE885EF16,             -- Q
    0x8CC9CD42,             -- X
    0x827E9EE8,             -- X
}

-- The path which we pull information from to display the item icons for the menus

imgPath = "<img style='max-height:64px;max-width:64px; float:%s; margin-top: -5px;' src='nui://" .. GetCurrentResourceName() .. "/item_imgs/%s.png'>"

imgPath2 = "<img style='max-height:96px;max-width:96px;float: center;'src='nui://" .. GetCurrentResourceName() .. "/imgs/%s.png'>"

imgPath3 = "<img style='max-height:32px;max-width:32px; vertical-align:middle; float:center;' src='nui://" .. GetCurrentResourceName() .. "/item_imgs/%s.png'>"

imgPath4 = "<img style='max-height:64px;max-width:64px; float:%s; filter:sepia(50%%) drop-shadow(2px 2px 4px rgba(0,0,0,0.5));' src='nui://" .. GetCurrentResourceName() .. "/item_imgs/%s.png'>"

imgPath5 = "<img style='max-height:64px;max-width:64px; float:%s; filter:brightness(50%%) grayscale(100%%);' src='nui://" .. GetCurrentResourceName() .. "/item_imgs/%s.png'>"

Divider = "<img style='margin-top: 10px;margin-bottom: 10px; margin-left: -10px;'src='nui://" .. GetCurrentResourceName() .. "/imgs/divider_line.png'>"

iconPath = "<img style='max-height:30px;max-width:30px;vertical-align:middle; float:left;' src='nui://" .. GetCurrentResourceName() .. "/imgs/%s.png'>"

iconPath2 = "<img style='max-height:30px;max-width:30px;vertical-align:middle; filter:brightness(130%%) grayscale(60%%); float:left;' src='nui://" .. GetCurrentResourceName() .. "/item_imgs/%s.png'>"

iconPath3 = "<img style='max-height:30px;max-width:30px;vertical-align:middle; filter:invert(0) brightness(0.5) grayscale(1); float:left;' src='nui://" .. GetCurrentResourceName() .. "/item_imgs/%s.png'>"

