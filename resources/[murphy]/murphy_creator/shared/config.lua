Config = {}

Config.framework = 'rsg-core' -- Framework to use. Options: 'REDEMRP2k23', 'rsg-core', 'vorp', 'rdr3mp', 'rdr3mp-legacy'
Config.murphy_clothing = true -- Set to true if you are using murphy_clothing
Config.LoadSkinCommand = "mc" -- Command to load murphy_creator data
Config.DevMode = false -- Set to true to enable developer mode, which allows you to use the F3 key to open the character creator
Config.Debug = false -- Set to true to enable debug prints in the console
Config.CustomLoadingScreen = false -- Set to true if you use a custom loading screen script (e.g. midnightcode_loadingscreen). Murphy Creator will wait for your loading screen to close before showing character selection.

function DebugPrint(...)
    if Config.Debug then
        print("[murphy_creator]", ...)
    end
end
Config.Locale = "en" -- Language: 'en' for English, 'fr' for French
Config.GameYear = 1899 -- Current in-game year, used to calculate character age from birthdate

--[[
    ╔═══════════════════════════════════════════════════════════════════════════╗
    ║                    CHARACTER SELECT CONFIGURATION                          ║
    ╠═══════════════════════════════════════════════════════════════════════════╣
    ║  Configure the interior, camera, and character positions for charselect   ║
    ╚═══════════════════════════════════════════════════════════════════════════╝
]]

-- Interior Configuration
Config.CharSelect = {
    -- Interior ID (0 = no interior/exterior location)
    interior = 0,
    
    -- Player spawn position when opening charselect/creator
    playerSpawn = {
        coords = vector3(1009.0529, 1703.8906, 379.7562),
        heading = 314.6876,
    },
    
    -- IMAPs to load (comment out or remove if not needed)
    imaps = {},
    
    -- Interior entity sets to activate
    interior_sets = {},

    -- Decorative props spawned while character select is open
    props = {
        {
            model = "p_cs_cedarlog02x",
            coords = vector3(1011.291, 1694.961, 377.962),
            heading = 35.0,
        },
        {
            model = "p_cs_cedarlog02x",
            coords = vector3(1008.627, 1697.247, 378.118),
            heading = 145.0,
        },
        {
            model = "p_campfire01x",
            coords = vector3(1011.020, 1696.940, 378.187),
            heading = 0.0,
        },
    },
    
    -- Camera settings
    camera = {
        coords = vector3(1016.8000, 1705.1000, 380.9500), -- Camera position
        target = vector3(1010.9500, 1696.8500, 379.4500), -- Where the camera looks at
        fov = 40.0,                                      -- Field of view (lower = more zoom)
    },
    
    -- Character slot positions (add more if you increase the max slots in slots.lua)
    -- scenario = standing animation | scenariopoint = sitting/prop animation
    pedslots = {
        [1] = {
            coords = vector3(1011.8500, 1695.2000, 378.9500),
            heading = 332.00,
            scenario = "WORLD_HUMAN_STAND_IMPATIENT"
        },
        [2] = {
            coords = vector3(1008.8500, 1697.6000, 378.9500),
            heading = 112.00,
            scenario = "WORLD_HUMAN_DRINKING"
        },
        [3] = {
            coords = vector3(1012.8500, 1697.9500, 378.9500),
            heading = 241.10,
            scenario = "WORLD_HUMAN_SMOKE_NERVOUS_STRESSED"
        },
        [4] = {
            coords = vector3(1013.4000, 1695.8000, 378.9500),
            heading = 295.60,
            scenario = "WORLD_HUMAN_LEAN_BACK_WALL_SMOKING"
        },
        [5] = {
            coords = vector3(1009.6000, 1698.9000, 378.9500),
            heading = 144.10,
            scenario = "WORLD_HUMAN_LEAN_WALL_LEFT"
        },
        [6] = {
            coords = vector3(1007.4000, 1695.5000, 378.9500),
            heading = 68.30,
            scenario = "WORLD_HUMAN_BARTENDER_CLEAN_GLASS"
        },
        -- Add more slots here if needed (up to your max in Config.Slots.default)
        -- [7] = {
        --     coords = vector3(x, y, z),
        --     heading = 0.0,
        --     scenario = "WORLD_HUMAN_STAND_IMPATIENT"
        -- },
    },
}

--[[
    ╔═══════════════════════════════════════════════════════════════════════════╗
    ║                       CHARACTER SLOTS LIMITS                               ║
    ╠═══════════════════════════════════════════════════════════════════════════╣
    ║  Maximum number of characters per player (by role or identifier)          ║
    ║  Priority: identifier > role > default                                     ║
    ╚═══════════════════════════════════════════════════════════════════════════╝
]]

Config.Slots = {
    default = 3,  -- Default max characters for all players
    
    -- Role-based limits (overrides default)
    role = {
        superadmin = 5,
        admin = 5,
        -- vip = 8,  -- Example: VIP players get 8 slots
    },
    
    -- Specific player limits (overrides role and default)
    identifier = {
        -- ["steam:11000010c04648e"] = 10,  -- Example: specific player gets 10 slots
    }
}

--[[
    ╔═══════════════════════════════════════════════════════════════════════════╗
    ║                       PED MODEL PERMISSIONS                                ║
    ╠═══════════════════════════════════════════════════════════════════════════╣
    ║  Access to custom ped models in the character creator                     ║
    ║  Priority: identifier > role > default                                     ║
    ╚═══════════════════════════════════════════════════════════════════════════╝
]]

Config.PedPermission = {
    default = true,  -- true = access to ped models, false = no access
    
    role = {
        superadmin = true,
        admin = true,
    },
    
    identifier = {
        -- ["steam:11000010c04648e"] = true,
    }
}

--[[
    ╔═══════════════════════════════════════════════════════════════════════════╗
    ║                    CHARACTER DELETION PERMISSIONS                          ║
    ╠═══════════════════════════════════════════════════════════════════════════╣
    ║  Who can delete characters? (optional restriction)                        ║
    ║  Priority: identifier > role > default                                     ║
    ╚═══════════════════════════════════════════════════════════════════════════╝
]]

Config.CharacterDeletion = {
    enabled = true,           -- true = deletion enabled, false = no one can delete
    restrictToRoles = false,  -- false = everyone can delete, true = only allowed roles/identifiers
    
    -- If restrictToRoles = true, only these roles can delete characters
    role = {
        superadmin = true,
        admin = true,
        -- moderator = true,
    },
    
    -- Specific players who can always delete (overrides role)
    identifier = {
        -- ["steam:11000010c04648e"] = true,
    }
}

--[[
    ╔═══════════════════════════════════════════════════════════════════════════╗
    ║                       ADMIN COMMANDS                                       ║
    ╠═══════════════════════════════════════════════════════════════════════════╣
    ║  Admin commands for character management                                   ║
    ╚═══════════════════════════════════════════════════════════════════════════╝
]]

Config.Commands = {
    deleteCharacter = {
        enabled = true,                    -- Enable/disable the command
        command = "deletechar",            -- Command name: /deletechar [charidentifier]
        allowedRoles = {                   -- Roles allowed to use this command
            "superadmin",
            "admin",
        },
        allowedIdentifiers = {             -- Specific players allowed (steam identifier)
            -- "steam:11000010c04648e",
        }
    },
    
    -- "Second Chance" command - Reopen character customization menu for a player
    secondChance = {
        enabled = true,                    -- Enable/disable the command
        command = "secondchance",          -- Command name: /secondchance [playerid]
        allowedRoles = {                   -- Roles allowed to use this command
            "superadmin",
            "admin",
        },
        allowedIdentifiers = {             -- Specific players allowed (steam identifier)
            -- "steam:11000010c04648e",
        }
    }
}
