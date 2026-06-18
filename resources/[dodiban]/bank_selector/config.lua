Config = {}

-- Bank Selector Configuration
Config.BankSelector = {
    -- Banks available for robbery
    banks = {
        {
            id = "valentine_bank",
            name = "Valentine Bank",
            description = "The heart of New Hanover's financial district",
            image = "bank_valentine.png",
            location = {x = -308.3, y = 776.0, z = 118.7},
            difficulty = "Easy",
            reward_range = {min = 500, max = 1500},
            cooldown = 60, -- minutes
            required_players = 2,
            security_level = 1,
            photos = {
                {
                    id = "layout", 
                    title = "Bank Layout", 
                    image = "bank_valentine_entrance.png", 
                    description = "Main floor layout and exits", 
                    position = {x = 100, y = 80, rotation = -12},
                    stack_photos = {
                        {title = "Main entrace", image = "bank_valentine_entrance.png", description = "Main entrance with a large window for the tellers"},
                        {title = "Manager room", image = "bank_valentine_manager_room.png", description = "Manager office and safe deposit boxes"},
                        {title = "Back door", image = "bank_valentine_back_door.png", description = "Back door reinforced with steel plates"}
                    }
                },
                {
                    id = "vault", 
                    title = "Vault Door", 
                    image = "bank_valentine_vault_exterior.png", 
                    description = "Heavy steel vault with time lock", 
                    position = {x = 850, y = 50, rotation = 8},
                    stack_photos = {
                        {title = "Vault Exterior", image = "bank_valentine_vault_exterior.png", description = "Heavy steel door with combination lock"},
                        {title = "Safe Deposit Boxes", image = "bank_valentine_vault_safe_deposit_boxes.png", description = "Safe deposit boxes inside the vault"},
                        {title = "Main safe", image = "bank_valentine_vault_main_safe.png", description = "Main safe inside the vault"}
                    }
                },
                {
                    id = "guards", 
                    title = "Security", 
                    image = "bank_valentine_guards.png", 
                    description = "6 guards, light patrol schedule", 
                    position = {x = 150, y = 300, rotation = 15},
                    stack_photos = {
                        {title = "Guard Stations", image = "bank_valentine_guards.png", description = "Four guards at main entrance and two at the back door"},
                        {title = "Wagon Schedule", image = "bank_valentine_wagon.png", description = "Twice a week"},
                        {title = "Alarm System", image = "bank_valentine_alarm.png", description = "Gas system used by the guards to detect intruders inside the vault"}
                    }
                },
                {
                    id = "escape", 
                    title = "Escape Routes", 
                    image = "bank_valentine_front_exit.png", 
                    description = "Multiple exit points available", 
                    position = {x = 900, y = 320, rotation = -5},
                    stack_photos = {
                        {title = "Front Exit", image = "bank_valentine_front_exit.png", description = "Main entrance with easy street access,the most dangerous option"},
                        {title = "Back Alley", image = "bank_valentine_back_alley.png", description = "Go straight to the back of the bank but the door is armored, you'll need to break it in."},
                        {title = "Side Window are blocked", image = "bank_valentine_side_window_blocked.png", description = "The windows are blocked by iron bars"}
                    }
                }
            }
        },
        {
            id = "rhodes_bank",
            name = "Rhodes Bank",
            description = "Lemoyne's most secure banking establishment",
            image = "bank_rhodes.png",
            location = {x = 1294.1, y = -1303.5, z = 77.0},
            difficulty = "Medium",
            reward_range = {min = 750, max = 2250},
            cooldown = 60, -- minutes
            required_players = 2,
            security_level = 2,
            photos = {
                {
                    id = "layout", 
                    title = "Bank Layout", 
                    image = "bank_rhodes_main_entrance.png", 
                    description = "Large bench with few doors", 
                    position = {x = 80, y = 120, rotation = 18},
                    stack_photos = {
                        {title = "Main Entrance", image = "bank_rhodes_main_entrance.png", description = "Main entrance, a door directly to the main hall"},
                        {title = "Fragile Wall", image = "bank_rhodes_fragile_wall.png", description = "A wall that can be broken with a bomb"},
                        {title = "Main Hall", image = "bank_rhodes_main_hall.png", description = "Main hall with one door to the vault"}
                    }
                },
                {
                    id = "vault", 
                    title = "Vault Door", 
                    image = "bank_rhodes_vault_exterior.png", 
                    description = "Reinforced vault with dual locks", 
                    position = {x = 920, y = 40, rotation = -10},
                    stack_photos = {
                        {title = "Vault exterior", image = "bank_rhodes_vault_exterior.png", description = "Vault exterior with a camera and a door"},
                        {title = "Safe deposit boxes", image = "bank_rhodes_safe_deposit_boxes.png", description = "Safe deposit boxes inside the vault"},
                        {title = "Main safe", image = "bank_rhodes_main_safe.png", description = "Main safe inside the vault"}
                    }
                },
                {
                    id = "guards", 
                    title = "Security", 
                    image = "bank_rhodes_guard_station.png", 
                    description = "3 guards, rotating shifts", 
                    position = {x = 120, y = 350, rotation = 6},
                    stack_photos = {
                        {title = "Guard Station", image = "bank_rhodes_guard_station.png", description = "Guard station with two guards at front door and two at the back door"},
                        {title = "Wagon Schedule", image = "bank_rhodes_wagon_schedule.png", description = "Wagon schedule with safes at main entrance"},
                        {title = "Alarm System", image = "bank_rhodes_alarm_system.png", description = "Alarm system for the gas system to detect intruders inside the vault"}
                    }
                },
                {
                    id = "escape", 
                    title = "Escape Routes", 
                    image = "bank_rhodes_front_exit.png", 
                    description = "Back alley and roof access", 
                    position = {x = 950, y = 280, rotation = -15},
                    stack_photos = {
                        {title = "Front Exit", image = "bank_rhodes_front_exit.png", description = "Main entrance with easy street access,the most dangerous option"},
                        {title = "Back Alley", image = "bank_rhodes_back_alley.png", description = "Go straight to the back of the bank but the door is armored,won't open"},
                        {title = "Side Window are blocked", image = "bank_rhodes_side_window_blocked.png", description = "The windows are blocked by iron bars"}
                    }
                }
            }
        },
        {
            id = "lemoyne_bank",
            name = "Lemoyne National Bank",
            description = "The most heavily fortified bank in the territories",
            image = "lemoyne_bank.png",
            location = {x = 2644.5, y = -1292.8, z = 52.2},
            difficulty = "Expert",
            reward_range = {min = 1500, max = 4500},
            cooldown = 60, -- minutes
            required_players = 2,
            security_level = 4,
            photos = {
                {
                    id = "layout", 
                    title = "Bank Layout", 
                    image = "lemoyne_bank_main_entrance.png", 
                    description = "Fortress-like structure with multiple levels", 
                    position = {x = 140, y = 100, rotation = 14},
                    stack_photos = {
                        {title = "Main Entrance", image = "lemoyne_bank_main_entrance.png", description = "Main entrance, a door directly to the main hall"},
                        {title = "Fragile Wall", image = "lemoyne_bank_fragile_wall.png", description = "A wall that can be broken with a bomb"},
                        {title = "Main Hall", image = "lemoyne_bank_main_hall.png", description = "Main hall with a camera and a door"}
                    }
                },
                {
                    id = "vault", 
                    title = "Vault Door", 
                    image = "lemoyne_bank_vault_exterior.png", 
                    description = "Military-grade vault with time locks", 
                    position = {x = 900, y = 30, rotation = -12},
                    stack_photos = {
                        {title = "Vault Exterior", image = "lemoyne_bank_vault_exterior.png", description = "Complex timing mechanism with multiple stages"},
                        {title = "Safe Deposit Boxes", image = "lemoyne_bank_safe_deposit_boxes.png", description = "Military-grade steel with blast resistance"},
                        {title = "Main Safe", image = "lemoyne_bank_main_safe.png", description = "Maximum security storage for high-value assets"}
                    }
                },
                {
                    id = "guards", 
                    title = "Security", 
                    image = "lemoyne_bank_guards.png", 
                    description = "6+ guards, constant surveillance", 
                    position = {x = 70, y = 360, rotation = 9},
                    stack_photos = {
                        {title = "Guard Force", image = "lemoyne_bank_guards.png", description = "Six highly trained security officers"},
                        {title = "Wagon Schedule", image = "lemoyne_bank_wagon.png", description = "Wagon schedule with safes at main entrance"},
                        {title = "Alarm System", image = "lemoyne_bank_alarm.png", description = "Alarm system for the gas system to detect intruders inside the vault"}
                    }
                },
                {
                    id = "escape", 
                    title = "Escape Routes", 
                    image = "lemoyne_bank_front_exit.png", 
                    description = "Heavily monitored, requires planning", 
                    position = {x = 850, y = 340, rotation = -20},
                    stack_photos = {
                        {title = "Front Exit", image = "lemoyne_bank_front_exit.png", description = "Main entrance with easy street access,the most dangerous option"},
                        {title = "Side Alley", image = "lemoyne_bank_side_alley.png", description = "Go straight to the side of the bank but the door is armored,won't open"},
                        {title = "Side Window are blocked", image = "lemoyne_bank_side_window_blocked.png", description = "The windows are blocked by iron bars"}
                    }
                }
            }
        }
    },
    
    -- UI Settings
    ui = {
        show_animations = true,
        selection_sound = true,
        auto_close_delay = false, -- UI stays open until user closes
        background_blur = true
    },
    
    -- Commands
    commands = {
        open_selector = "selectbank",
        clear_cooldown = "clearbankcd",
        set_cooldown = "setbankcd", 
        check_cooldowns = "checkbankcd"
    },
    
    -- Minimum distance from bank to open selector
    min_distance_from_bank = 100.0,
    
    -- Player cooldown settings
    player_cooldown = {
        enabled = true,                 -- Enable per-player cooldown
        cooldown_minutes = 2,          -- Minutes before player can select another bank
        require_lobby = true,           -- Require player to be in a lobby to select banks
        min_lobby_members = 0           -- Minimum lobby members required (0 = no minimum)
    },
    
    -- Notifications
    notifications = {
        bank_selected = "Bank selected: %s",
        bank_on_cooldown = "This bank is currently on cooldown",
        too_close_to_bank = "You cannot plan a heist while near a bank",
        global_cooldown_active = "Server robbery cooldown active. Wait %d minutes.",
        robbery_started = "Robbery started at %s",
        robbery_failed = "Failed to start robbery at %s",
        player_on_cooldown = "You must wait %d minutes before selecting another bank",
        not_in_lobby = "You must be in a lobby to select a bank",
        lobby_too_small = "Your lobby needs at least %d members to start a robbery"
    },
    
    -- Global Robbery System Integration
    robbery_integration = {
        enabled = true, -- Enable integration with dodi_bankrobbery rounds system
        global_cooldown_enabled = false, -- Enable global cooldown (prevents ALL robberies)
        global_cooldown = 60, -- Global cooldown in minutes between any robberies on server
        
        -- Bank to Round mapping
        bank_round_mapping = {
            valentine_bank = "valentine_ronda",
            rhodes_bank = "rhodes_ronda", 
            lemoyne_bank = "saint_denis_ronda"
        },
        
        -- Auto cleanup settings
        auto_cleanup = {
            enabled = true,
            cleanup_delay = 300000 -- 5 minutes - cleanup round if no activity
        },
        
        -- Notifications
        start_notifications = {
            enabled = true,
            notify_all_players = true, -- Notify all players when robbery starts
            message_template = "🏦 Bank robbery started at %s!"
        }
    },
    
    -- NPC Spawn System
    npc_system = {
        enabled = true,
        spawn_interval = 30, -- minutes between location changes
        
        -- NPC Model and appearance
        npc_model = "cs_guidomartelli", -- Police model for authority
        
        -- Random spawn locations across the map
        spawn_locations = {
            {x = 2796.043, y = -1257.994, z = 46.477, heading = 97.03, name = "Saint Denis"},
            -- {x = -1800.0, y = -375.0, z = 158.0, heading = 90.0, name = "Strawberry"},
            -- {x = 2930.0, y = 1348.0, z = 44.0, heading = 180.0, name = "Annesburg"},
            -- {x = 1346.0, y = -1312.0, z = 76.0, heading = 270.0, name = "Rhodes"},
            -- {x = -5487.0, y = -2939.0, z = -1.8, heading = 45.0, name = "Blackwater"},
            -- {x = -1786.0, y = -392.0, z = 158.0, heading = 0.0, name = "Strawberry Outskirts"},
            -- {x = 1225.0, y = -1294.0, z = 76.0, heading = 315.0, name = "Rhodes Outskirts"},
            -- {x = -3685.0, y = -2623.0, z = -13.0, heading = 225.0, name = "Armadillo"},
            -- {x = -813.0, y = -1324.0, z = 43.0, name = "Emerald Ranch"},
            -- {x = 2971.0, y = 560.0, z = 44.0, heading = 90.0, name = "Van Horn"},
            -- {x = -1430.0, y = 2404.0, z = 307.0, heading = 180.0, name = "Wallace Station"},
            -- {x = 1939.0, y = -1946.0, z = 42.0, heading = 270.0, name = "Braithwaite Manor Area"}
        },
        
        -- Prompt settings
        prompt = {
            text = "Talk to Bank Contact",
            key = 0xF84FA74F, -- ["MOUSE2"] key
            distance = 3.0,
            enabled = true
        },
        
        -- Spawn/Despawn distances
        spawn_distance = 30.0, -- Distance to spawn NPC when player approaches
        despawn_distance = 50.0, -- Distance to despawn NPC when player leaves
        
        -- Blip settings
        blip = {
            enabled = true,
            sprite = GetHashKey('blip_ambient_law'), -- Police badge icon
            scale = 0.8,
            name = "Bank Contact"
        },
        
        -- Notifications
        notifications = {
            npc_spawned = "A bank contact has appeared in %s",
            npc_moved = "The bank contact has moved to a new location",
            npc_interaction = "Bank contact available - Press G to talk"
        }
    }
}

-- ================================
--        LANGUAGE SYSTEM
-- ================================

-- Language Configuration
Config.Languages = {
    currentLanguage = "en-us",
    
    ["en-us"] = {
        -- Client Messages
        client = {
            -- Bank Selector
            bankSelector = "Bank Selector",
            bankSelectorAlreadyOpen = "Bank selector is already open",
            lobbyRequired = "Lobby Required",
            tooClose = "Too Close",
            
            -- Errors and Status
            error = "Error",
            robberySystemNotAvailable = "Robbery system not available",
            success = "Success",
            bankRobbery = "Bank Robbery",
            
            -- Robbery Messages
            robberyStarted = "Robbery Started",
            robberyStartedAt = "Bank robbery initiated at ",
            robberyFailed = "Robbery Failed",
            failedToStartRobberyAt = "Failed to start robbery at ",
            
            -- Test and Debug
            testIntegration = "Test Integration",
            testing = "Testing ",
            selection = " selection",
            cooldownDebug = "Cooldown Debug",
            checkConsoleForCooldownDetails = "Check console for cooldown details",
            forceBankSelector = "Force Bank Selector",
            uiOpenedBypassingChecks = "UI opened bypassing all checks",
            
            -- Lobby Status
            lobbyStatus = "Lobby Status",
            inLobby = "In lobby: ",
            members = " | Members: ",
            bankLobbyResourceNotAvailable = "Bank lobby resource not available",
            
            -- NPC System
            bankContact = "Bank Contact",
            selectYourTargetBank = "Select your target bank for the heist",
            npcDebug = "NPC Debug",
            checkConsoleForNPCDetails = "Check console for NPC system details",
            npcCleanup = "NPC Cleanup",
            npcSystemCleanedUp = "NPC system cleaned up",
            npcRequest = "NPC Request",
            requestingCurrentNPCLocation = "Requesting current NPC location",
            npcTest = "NPC Test",
            testingNPCInteraction = "Testing NPC interaction",
            registeredNPCs = "Registered NPCs",
            npcsRegistered = " NPCs registered - check console",
            
            -- Lobby System
            lobbyCreated = "Lobby Created",
            lobbyCreatedMessage = "Your lobby has been created successfully!"
        }
    }
}

-- Helper function to get language text
function GetLanguageText(category, key)
    local currentLang = Config.Languages.currentLanguage
    local langData = Config.Languages[currentLang]
    
    if not langData then
        print("^1[Bank Selector] Language not found: " .. tostring(currentLang) .. "^0")
        return key
    end
    
    if not langData[category] then
        print("^1[Bank Selector] Category not found: " .. tostring(category) .. "^0")
        return key
    end
    
    if not langData[category][key] then
        print("^1[Bank Selector] Key not found: " .. tostring(category) .. "." .. tostring(key) .. "^0")
        return key
    end
    
    return langData[category][key]
end