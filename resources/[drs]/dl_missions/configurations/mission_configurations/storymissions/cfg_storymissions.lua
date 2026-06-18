----------------------------------------------------------------
-- STORY MISSIONS
----------------------------------------------------------------

Config.StoryMissions = {}


Config.StoryMissions["introduction"] = { -- Unique Mission Name

    title = "Welcome to Valentine", -- Mission Title
    description = "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet.",
    missionImage = "valentine01.jpg",
    
    
    -- Optional: Should a Mission Vehicle be spawned for this mission?
    missionVehicles = {
        delivery1 = { -- Vehicle Identifier, to be used in the tasks if necessary
            model = "supplywagon",
            blip = {
                sprite = 564457427,
                color = "BLIP_MODIFIER_MP_COLOR_10",
                scale = 0.8,
                name = "Supply Wagon"
            },
            spawnPositions = {
                {x = -229.20, y = 633.85, z = 113.11, h=234.34},
                {x = -219.67, y = 644.42, z = 113.13, h=225.57},
            },
            cargoPropset = "crates"
        },
    },

    sequentialTasks = false,  -- false = every task can be completed in random order, true = tasks need to be completed in the order they are listed in the config
    tasks = { -- List of Tasks that need to be completed for this mission, the tasks need to be defined in the task configuration files
        "travel_any_20km",
        "collect_diary",
        "deliver_quest_letter",
        'collect_crates',
        'deliver_crates',
    },
      
    -- Optional: NPC that gives the mission, if no NPC is defined, the mission can only be started through followUpMissions, export functions or the SpecificMissionGivers
    npc = {
        name = "Priest Sullivan",
        model = "cs_sdpriest",
        coords = vector4(-231.73, 796.54, 123.63, 117.33),
        spawnDistance = 30.0,

        -- Optional: Blips for the Mission NPC
        blip = {
            coords = vector3(-231.73, 796.54, 123.63), -- offsetcoords, if you want the blip to be on a seperate position. if not provided use the coords from npc
            sprite = 748106308,
            color = "BLIP_MODIFIER_MP_COLOR_10",
            scale = 0.8,
            name = "Priest Sullivan",
            zoneradius = 0, -- If greater than 0, it will create an area blip instead of a normal blip
        },

        animation = {
            useanim = false,
            dict = "amb@world_human_stand_mobile@male@text@enter",
            name = "enter",
            flag = 1,
            isScenario = true, -- If true, the animation will be played as a scenario, if false, the animation will be played as a normal animation
            scenario = "MP_LOBBY_PROP_HUMAN_SEAT_BENCH_PORCH_SMOKING",
            scenarioProp = "p_diningchairs01x",
            scenarioPosOffset = vector4(0.0, 0.0, 0.4, 180.0), -- Only relevant if isScenario is true, defines the offset for the scenario position, so the position where the scenario will be played is coords + scenarioPosOffset
        },

        dialog  = {
            -- Dialog for the beginning of the mission -> When you accept the mission
            -- 'audio' is optional and defines the path to an audio file that will be played while the dialog is shown
            beginning = {
                {text = "Thank you for buying my Script! To change this text you can edit the cfg_storymissions.lua file.", time=7000, audio=""},
                {text = "If you wanna add Audio to it you can put your audio files in the html/audios folder and assign them in the cfg_storymissions.lua file.", time=9000, audio=""},
                {text = "With /myMissions you can view your current Missions!.", time=6000, audio=""},
            },
            -- Dialog for the completion of the mission -> Before the mission is removed and you receive the reward
            completed = {
                {text = "You handled yourself well and took the first step on your path.", time=8000, audio=""},
                {text = "Take this reward as a sign of trust. May it help you on the road ahead.", time=6000, audio=""},
            }
        }
    },

    -- Rewards
    reward = {
        currency = {
            money = 100,
            gold = 5,
            xp = 200
        },
        items = {
            {name = "bread", amount = 5},
            {name = "water", amount = 3}
        },
        -- Events that are triggered if the mission is turned in
        events = { 
            -- type can be "event" or "clientEvent", isServerEvent is only necessary if type is "event" to differ between client and server events, if type is "clientEvent" it will automatically be a client event
            {eventName = "dl_missions:server:testCall", eventData = {"bread", 5}, type="event", isServerEvent = true}, -- This example would trigger like this: AddEventHandler('dl_missions:server:testCall', function(source, itemName, itemAmount)
            {eventName = "exports.dl_missions:getActiveMissionIDsByPlayerId", eventData = {}, type="exportFunction"} -- This example would execute like this: exports.vorp_inventory:canCarryItem(source, "bread", 5)
        }
    },


    -- Optional: Prerequisite Missions -> If you have completed these missions, you can start this mission
    requiredMissions = {},  -- These Mission have to be completed and turned in to unlock the Mission
    
    followUpMissions = {}, -- These missions will be automatically ACTIVATED when the mission is completed -> No NPC interactions needed to start the mission
    failMissionsOnComplete = {} -- These missions will be FAILED if they are active, or will be Locked if they are not yet completed, when the 'introduction' mission is completed in this case.

}


Config.StoryMissions["lawfulllife"] = {

    title = "A Faithful Life",
    description = "The Sheriff of Valentine told you to get to know the city and its inhabitants. Visit the Gunsmith Shop and Speak to the Doctor to get them to know you.",
    missionImage = "",
    
    sequentialTasks = false,  -- false = every task can be completed in random order, true = tasks need to be completed in the order they are listed in the config
    tasks = {
        "patrol_scout_val_gunsmith",
        "speak_medic",
    },
    
    reward = {
        currency = {
            money = 100,
            gold = 5,
            xp = 200,
        },
        items = {
            {name = "bread", amount = 5},
            {name = "water", amount = 3}
        },
        events = {
            {eventName = "dl_missions:server:testCall", eventData = {}, type="event", isServerEvent = true}, 
            {eventName = "exports.vorp_inventory:canCarryItem", eventData = {"bread", "5"}, type="exportFunction"}
        }
    },
    
    npc = {
        name = "Sheriff Owens",
        model = "CS_SheriffOwens",
        coords = vector4(-277.08, 804.03, 119.38, 336.69),
        spawnDistance = 20.0,

        animation = {
            useanim = true,
            dict = "amb@world_human_stand_mobile@male@text@enter",
            name = "enter",
            flag = 1,
            isScenario = true,
            scenario = "MP_LOBBY_PROP_HUMAN_SEAT_BENCH_PORCH_SMOKING",
            scenarioProp = "p_diningchairs01x",
            scenarioPosOffset = vector4(0.0, 0.0, 0.4, 180.0),
        },

        blip = {
            coords = vector3(-276.53, 808.32, 119.38),
            sprite = 748106308,
            color = "BLIP_MODIFIER_MP_COLOR_10",
            scale = 0.8,
            name = "Sheriff Owens",
            zoneradius = 0.0,
        },

        dialog  = {
            beginning = {
                {text = "Hello Stranger, the Priest already told me about you.", time=3000},
                {text = "If you wanna life in my city you have to know your way around. Go see the Gunsmith and the Doctor.", time=3000},
            },
            completed = {
                {text = "Well done! You visited the Gunsmith and the Doctor.", time=2000},
                {text = "Now you can explore the city on your own! Here is some small help for you!", time=3000}
            }
        }
    },

    requiredMissions = {"introduction"}, -- As we can see this 'lawfulllife' mission can only be started if the 'introduction' mission is completed and turned in
    followUpMissions = {},

    failMissionsOnComplete = {"evillife"} -- As we can see if we complete the 'lawfulllife' mission, the 'evillife' mission will be failed, so the player can only choose one of the two missions to start with and lock out the other one.

}


Config.StoryMissions["evillife"] = {

    title = "Gangsters Paradise",
    description = "Colm O'Driscoll seems to like you, and told you to get something done for him.",
    missionImage = "",
    restartable = false,

    sequentialTasks = false,  -- false = every task can be completed in random order, true = tasks need to be completed in the order they are listed in the config
    tasks = {
        "kill_wolves_5",
        "smoke_cigars_10"
    },
    
    reward = {
        currency = {
            money = 100,
            gold = 5,
            xp = 200
        },
        items = {
            {name = "bread", amount = 5},
            {name = "water", amount = 3}
        },
        events = {
            {eventName = "dl_missions:server:testCall", eventData = {}, type="event", isServerEvent = true},
            {eventName = "exports.vorp_inventory:canCarryItem", eventData = {"bread", "5"}, type="exportFunction"}
        }
    },
    
    npc = {
        name = "Colm O'Driscoll",
        model = "cs_colmodriscoll",
        coords = vector4(-545.89, 389.27, 87.08, 180.72),
        spawnDistance = 20.0,

        animation = {
            useanim = true,
            dict = "amb@world_human_stand_mobile@male@text@enter",
            name = "enter",
            flag = 1,
            isScenario = true,
            scenario = "PROP_HUMAN_SEAT_CHAIR_CIGAR",
            scenarioProp = "p_stoolfolding01x",
            scenarioPosOffset = vector4(0.0, 0.0, 0.4, 180.0),
        },

        dialog  = {
            beginning = {
                {text = "Hey there. Who are you? I have not seen that face around Valentine before.", time=12000, audio="evillife/evillife_driscoll_1.mp3"},
                {text = "New in town, then. Walking up to strangers in back alleys takes nerve. I like that.", time=8000, audio="evillife/evillife_driscoll_2.mp3"},
                {text = "If you are not too worried about the law, we may get along just fine. Listen up.", time=8000, audio="evillife/evillife_driscoll_3.mp3"},
                {text = "Show me what you can do. Handle five wolves and smoke a few cigars while you are at it.", time=13000, audio="evillife/evillife_driscoll_4.mp3"},
                {text = "Come back when it is done. Now get out of my sight.", time=5000, audio="evillife/evillife_driscoll_5.mp3"},
            },
            completed = {
                {text = "Look who came back. Did you actually finish it?", time=4000, audio="evillife/evillife_driscoll_6.mp3"},
                {text = "I did not expect much, but you proved useful. Here is your reward.", time=9000, audio="evillife/evillife_driscoll_7.mp3"},
            }
        }
    },

    requiredMissions = {"introduction"}, -- As we can see this 'lawfulllife' mission can only be started if the 'introduction' mission is completed and turned in
    
    followUpMissions = {},
    failMissionsOnComplete = {"lawfulllife"} -- As we can see if we complete the 'evillife' mission, the 'lawfulllife' mission will be failed, so the player can only choose one of the two missions to start with and lock out the other one.

}


Config.StoryMissions["becoming_saloon"] = {

    title = "Help for the Saloon",
    description = "Help the saloon owner with his problems and get to know the town better",
    missionImage = "",
    restartable = false,
    
    sequentialTasks = false,  -- false = every task can be completed in random order, true = tasks need to be completed in the order they are listed in the config
    tasks = {
        "patrol_scout_val_saloon",
    },
    
    reward = {
        currency = {
            money = 100,
            gold = 5,
            xp = 200
        },
        items = {
            {name = "bread", amount = 5},
            {name = "water", amount = 3}
        },
        events = {
            {eventName = "dl_missions:server:testCall", eventData = {}, type="event", isServerEvent = true},
            {eventName = "exports.vorp_inventory:canCarryItem", eventData = {"bread", "5"}, type="exportFunction"}
        }
    },
    
    npc = {
        name = "Sheriff Owens",
        model = "CS_SheriffOwens",
        coords = vector4(-277.08, 804.03, 119.38, 336.69),
        spawnDistance = 20.0,

        blip = {
            sprite = 748106308,
            color = "BLIP_MODIFIER_MP_COLOR_10",
            scale = 0.8,
            name = "Sheriff Owens",
            zoneradius = 10.0,
        },

        animation = {
            useanim = true,
            dict = "amb@world_human_stand_mobile@male@text@enter",
            name = "enter",
            flag = 1,
            isScenario = true,
            scenario = "MP_LOBBY_PROP_HUMAN_SEAT_CHAIR_WHITTLE",
            scenarioProp = "p_diningchairs01x",
            scenarioPosOffset = vector4(0.0, 0.0, 0.4, 180.0),
        },

        dialog  = {
            beginning = {
                {text = "Hello stranger. I have not seen you around here before.", time=3000},
                {text = "Introduce yourself to the gunsmith and the doctor.", time=3000},
            },
            completed = {
                {text = "Thanks for the help. You are new in town, aren't you? Have a few drinks on me.", time=2000},
                {text = "Stop by the hotel and speak with Lady Meyer. She may have a room for you.", time=3000}
            }
        }
    },

    requiredMissions = {"lawfulllife"},
    
    followUpMissions = {}, 
    failMissionsOnComplete = {}

}


Config.StoryMissions["room_for_you"] = {

    title = "Room for You",
    description = "Speak with Lady Meyer and see if she has a place for you to stay.",
    missionImage = "",
    restartable = false,
    
    sequentialTasks = false,  -- false = every task can be completed in random order, true = tasks need to be completed in the order they are listed in the config
    tasks = {
        "speak_mayjor",
    },
    
    reward = {
        currency = {
            money = 100,
            gold = 5,
            xp = 200
        },
        items = {
            {name = "bread", amount = 5},
            {name = "water", amount = 3}
        },
        events = { 
            {eventName = "dl_missions:server:testCall", eventData = {}, type="event", isServerEvent = true},
            {eventName = "exports.vorp_inventory:canCarryItem", eventData = {"bread", "5"}, type="exportFunction"}
        }
    },
    
    npc = {
        name = "Lady Meyer",
        model = "am_valentinedoctors_females_01",
        coords = vector4(-329.72, 774.2, 116.44, 266.93),
        spawnDistance = 20.0, 

        blip = {
            sprite = 748106308,
            color = "BLIP_MODIFIER_MP_COLOR_10",
            scale = 0.8,
            name = "Lady Meyer",
            zoneradius = 0,
        },

        animation = {
            useanim = false,
            dict = "amb@world_human_stand_mobile@male@text@enter",
            name = "enter",
            flag = 1,
            isScenario = true,
            scenario = "MP_LOBBY_PROP_HUMAN_SEAT_BENCH_PORCH_SMOKING",
            scenarioProp = "p_diningchairs01x",
            scenarioPosOffset = vector4(0.0, 0.0, 0.4, 180.0),
        },

        dialog  = {
            beginning = {
                {text = "You must be the new face everyone is talking about.", time=3000},
                {text = "If you need a room, I may be able to help.", time=3000},
            },
            completed = {
                {text = "Good work. You handled that quickly.", time=2000},
                {text = "Here are the keys for room 1C. The first week is on the house.", time=3000}
            }
        }
    },

    requiredMissions = {"becoming_saloon"},
    
    followUpMissions = {}, 
    failMissionsOnComplete = {}

}



---------------------------------------------------------------------------------------------------------------------
-- TEMPALTE ----
/*
Config.StoryMissions["UNIQUE_MISSION_NAME"] = { -- Unique Mission Name

    title = "Welcome to Valentine", -- Mission Title
    description = "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet.",
    missionImage = "valentine01.jpg", -- Image that is shown in the Mission Menu, should be located in html/images/taskimages
    
    -- Optional: Should a Mission Vehicle be spawned for this mission?
    missionVehicles = {
        delivery1 = { -- Vehicle Identifier, to be used in the tasks if necessary
            model = "supplywagon",
            blip = {
                sprite = 564457427,
                color = "BLIP_MODIFIER_MP_COLOR_10",
                scale = 0.8,
                name = "Lieferwagen"
            },
            spawnPositions = {
                {x = -229.20, y = 633.85, z = 113.11, h=234.34},
                {x = -219.67, y = 644.42, z = 113.13, h=225.57},
            },
            cargoPropset = "crates"
        },
    },

    sequentialTasks = false,  -- false = every task can be completed in random order, true = tasks need to be completed in the order they are listed in the config
    tasks = { -- List of Tasks that need to be completed for this mission, the tasks need to be defined in the task configuration files
        "travel_any_20km",
        "collect_diary",
        "deliver_quest_letter",
        'collect_crates',
        'deliver_crates',
    },
      
    -- Optional: NPC that gives the mission, if no NPC is defined, the mission can only be started through followUpMissions, export functions or the SpecificMissionGivers
    npc = {
        name = "Priester Sullivan",
        model = "cs_sdpriest",
        coords = vector4(-231.73, 796.54, 123.63, 117.33),
        spawnDistance = 30.0,

        -- Optional: Blips for the Mission NPC
        blip = {
            coords = vector3(-231.73, 796.54, 123.63), -- offsetcoords, if you want the blip to be on a seperate position. if not provided use the coords from npc
            sprite = 748106308,
            color = "BLIP_MODIFIER_MP_COLOR_10",
            scale = 0.8,
            name = "Priester Sullivan",
            zoneradius = 0, -- If greater than 0, it will create an area blip instead of a normal blip
        },

        animation = {
            useanim = false, -- Should a animation or scenario be played
            dict = "amb@world_human_stand_mobile@male@text@enter",
            name = "enter",
            flag = 1,
            isScenario = true, -- If true, the animation will be played as a scenario, if false, the animation will be played as a normal animation
            scenario = "MP_LOBBY_PROP_HUMAN_SEAT_BENCH_PORCH_SMOKING",
            scenarioProp = "p_diningchairs01x",
            scenarioPosOffset = vector4(0.0, 0.0, 0.4, 180.0), -- Only relevant if isScenario is true, defines the offset for the scenario position, so the position where the scenario will be played is coords + scenarioPosOffset
        },

        dialog  = {
            -- Dialog for the beginning of the mission -> When you accept the mission
            -- 'audio' is optional and defines the path to an audio file that will be played while the dialog is shown
            beginning = {
                {text = "Sei gegrüßt, mein Kind… und willkommen auf Legends RP. Der Herr hat dich nach Valentine geführt – eine Stadt voller Sünden, aber auch voller neuer Wege.", time=13000, audio="introduction/priester_introduction_1.mp3"},
                {text = "Viele, die hier ankommen, tragen eine Last mit sich… doch jeder erhält die Chance, einen neuen Anfang zu wagen.", time=9000, audio="introduction/priester_introduction_2.mp3"},
                {text = "Ich will dir die Grundlagen zeigen, damit du deinen Weg mit Bedacht und Stärke gehen kannst.", time=6000, audio="introduction/priester_introduction_3.mp3"},
                {text = "Halte deine Augen offen… denn selbst an den dunkelsten Orten birgt Valentine Möglichkeiten für jene, die sie erkennen.", time=8000, audio="introduction/priester_introduction_4.mp3"},
                {text = "Mit /myMissions rufst du die aktuellen Missionen auf", time=4000, audio="introduction/priester_introduction_5.mp3"},
                {text = "Lege die Kilometer zurück, belade die Kutsche und melde dich beim Sheriff nachdem du das Tagebuch gefunden hast. Danach kommst du zu mir für deine Belohnung!", time=9000, audio="introduction/priester_introduction_7.mp3"},
                {text = "Aber nun genug OOC Talk, ab an die Arbeit mein Kind. Husch ! Husch !", time=6000, audio="introduction/priester_introduction_6.mp3"},
            },
            -- Dialog for the completion of the mission -> Before the mission is removed and you receive the reward
            completed = {
                {text = "Du hast dich wacker geschlagen… und den ersten Schritt auf deinem Pfad getan.", time=8000, audio="introduction/priester_introduction_8.mp3"},
                {text = "Nimm diese Belohnung als Zeichen… möge sie dich auf deinem weiteren Weg begleiten.", time=6000, audio="introduction/priester_introduction_9.mp3"},
            }
        }
    },

    -- Rewards
    reward = {
        currency = {
            money = 100,
            gold = 5,
            xp = 200
        },
        items = {
            {name = "bread", amount = 5},
            {name = "water", amount = 3}
        },
        events = { -- Server Events that are triggered if the mission is turned in
            {eventName = "dl_missions:server:testCall", eventData = {}, type="event", isServerEvent = true},    -- type can be "event" or "clientEvent", isServerEvent is only necessary if type is "event" to differ between client and server events, if type is "clientEvent" it will automatically be a client event
            {eventName = "exports.vorp_inventory:canCarryItem", eventData = {"bread", "5"}, type="exportFunction"}
        }
    },


    -- Optional: Prerequisite Missions -> If you have completed these missions, you can start this mission
    requiredMissions = {},  -- These Mission have to be completed and turned in to unlock the Mission
    
    followUpMissions = {}, -- These missions will be automatically ACTIVATED when the mission is completed -> No NPC interactions needed to start the mission
    failMissionsOnComplete = {} -- These missions will be FAILED if they are active, or will be Locked if they are not yet completed, when the 'introduction' mission is completed in this case.

}
*/
--------------------------------------------------------------------------------------------------------------

----------------------------------------------------------------
-- SHADYRP CUSTOM STORY MISSIONS
----------------------------------------------------------------

Config.StoryMissions["shadyrp_blackwater_ledger"] = {

    title = "The Blackwater Ledger",
    description = "Recover a sealed ledger, question a witness, check the Valentine bank records, then return to Elias Crowe and choose whether the truth belongs to the law or the outlaws.",
    missionImage = "valentine01.jpg",
    restartable = false,

    sequentialTasks = true,
    tasks = {
        "shadyrp_ledger_ride_out",
        "shadyrp_collect_sealed_ledger",
        "shadyrp_question_martha",
        "shadyrp_check_valentine_bank",
        "shadyrp_copy_bank_records",
        "shadyrp_return_to_elias_choice",
    },

    npc = {
        name = "Elias Crowe",
        model = "a_m_m_huntertravelers_cool_01",
        coords = vector4(-172.70, 625.20, 114.03, 125.0),
        spawnDistance = 25.0,

        blip = {
            coords = vector3(-172.70, 625.20, 114.03),
            sprite = 748106308,
            color = "BLIP_MODIFIER_MP_COLOR_10",
            scale = 0.8,
            name = "Elias Crowe",
            zoneradius = 0,
        },

        animation = {
            useanim = false,
            dict = "amb@world_human_stand_mobile@male@text@enter",
            name = "enter",
            flag = 1,
            isScenario = false,
            scenario = "",
            scenarioProp = "",
            scenarioPosOffset = vector4(0.0, 0.0, 0.0, 0.0),
        },

        dialog = {
            beginning = {
                {text = "Do not look at me too long. I am already being watched.", time = 5000, audio = ""},
                {text = "A ledger was taken from Blackwater. Names, payments, favors. Enough ink to bury half a town.", time = 9000, audio = ""},
                {text = "Recover it from the old camp, speak to Martha near the saloon, then compare the book against the Valentine bank records.", time = 10000, audio = ""},
                {text = "When you know what is inside, come back to me. Then you decide who gets the truth.", time = 8000, audio = ""},
            },
            completed = {
                {text = "So the numbers matched. I wish I could say I was surprised.", time = 7000, audio = ""},
                {text = "There are two roads now. Take the ledger to Deputy Clara at the jail, or carry it to Colm's runner at the ridge camp.", time = 11000, audio = ""},
                {text = "Choose carefully. Once one side owns that ledger, the other path closes for good.", time = 9000, audio = ""},
            }
        }
    },

    reward = {
        currency = {
            money = 125,
            xp = 250
        },
        items = {
            {name = "bread", amount = 2},
            {name = "water", amount = 2}
        },
        events = {}
    },

    requiredMissions = {},
    followUpMissions = {
        "shadyrp_blackwater_ledger_law",
        "shadyrp_blackwater_ledger_outlaw",
    },
    failMissionsOnComplete = {}
}

Config.StoryMissions["shadyrp_blackwater_ledger_law"] = {

    title = "The Honest Ledger",
    description = "Trust the law with the sealed ledger, protect the witness, and help Deputy Clara move before the corrupt names can bury the evidence.",
    missionImage = "valentine01.jpg",
    restartable = false,

    sequentialTasks = true,
    tasks = {
        "shadyrp_law_deliver_ledger",
        "shadyrp_law_speak_deputy_clara",
        "shadyrp_law_warn_martha",
        "shadyrp_law_post_notice",
        "shadyrp_law_report_elias",
    },

    npc = {
        name = "Deputy Clara Bell",
        model = "a_f_m_valtownfolk_01",
        coords = vector4(-274.18, 802.31, 119.39, 333.0),
        spawnDistance = 25.0,

        blip = {
            coords = vector3(-274.18, 802.31, 119.39),
            sprite = 748106308,
            color = "BLIP_MODIFIER_MP_COLOR_10",
            scale = 0.8,
            name = "Deputy Clara Bell",
            zoneradius = 0,
        },

        animation = {
            useanim = false,
            dict = "",
            name = "",
            flag = 1,
            isScenario = false,
            scenario = "",
            scenarioProp = "",
            scenarioPosOffset = vector4(0.0, 0.0, 0.0, 0.0),
        },

        dialog = {
            beginning = {
                {text = "If Elias sent you, keep that ledger covered. Half the county would pay to see it vanish.", time = 8000, audio = ""},
                {text = "File it on the evidence desk, then speak to me. We move quiet until I know which names are clean.", time = 9000, audio = ""},
            },
            completed = {
                {text = "The papers are filed and Martha has been warned. That buys us time.", time = 7000, audio = ""},
                {text = "The honest road is rarely the safe one, but today it held. Take this and keep your eyes open.", time = 9000, audio = ""},
            }
        }
    },

    reward = {
        currency = {
            money = 175,
            xp = 350
        },
        items = {
            {name = "bread", amount = 2},
            {name = "water", amount = 2}
        },
        events = {}
    },

    requiredMissions = {"shadyrp_blackwater_ledger"},
    followUpMissions = {},
    failMissionsOnComplete = {"shadyrp_blackwater_ledger_outlaw"}
}

Config.StoryMissions["shadyrp_blackwater_ledger_outlaw"] = {

    title = "The Dirty Ledger",
    description = "Hand the ledger to Colm's runner, plant a false trail, and make sure the wrong names never reach a courtroom.",
    missionImage = "valentine01.jpg",
    restartable = false,

    sequentialTasks = true,
    tasks = {
        "shadyrp_outlaw_deliver_ledger",
        "shadyrp_outlaw_speak_runner",
        "shadyrp_outlaw_plant_false_trail",
        "shadyrp_outlaw_ride_clear",
        "shadyrp_outlaw_final_contact",
    },

    npc = {
        name = "Silas Reed",
        model = "cs_oddfellowspinhead",
        coords = vector4(-536.25, 386.62, 87.12, 210.0),
        spawnDistance = 25.0,

        blip = {
            coords = vector3(-536.25, 386.62, 87.12),
            sprite = 748106308,
            color = "BLIP_MODIFIER_MP_COLOR_10",
            scale = 0.8,
            name = "Silas Reed",
            zoneradius = 0,
        },

        animation = {
            useanim = true,
            dict = "amb_rest_lean@world_human_lean@wall@smoking@male_a@base",
            name = "base",
            flag = 1,
            isScenario = false,
            scenario = "",
            scenarioProp = "",
            scenarioPosOffset = vector4(0.0, 0.0, 0.0, 0.0),
        },

        dialog = {
            beginning = {
                {text = "You brought the book? Good. Do not hand it to me yet. Put it in the drop so nobody sees our hands touch.", time = 10000, audio = ""},
                {text = "After that, I need you to muddy the trail west of camp. Then meet Nettie. She pays the quiet ones.", time = 10000, audio = ""},
            },
            completed = {
                {text = "The ledger is gone, the trail is crooked, and the law is chasing dust.", time = 8000, audio = ""},
                {text = "Colm likes useful people. That is not a compliment exactly, but it is profitable.", time = 9000, audio = ""},
            }
        }
    },

    reward = {
        currency = {
            money = 225,
            xp = 300
        },
        items = {
            {name = "bread", amount = 1},
            {name = "water", amount = 1}
        },
        events = {}
    },

    requiredMissions = {"shadyrp_blackwater_ledger"},
    followUpMissions = {},
    failMissionsOnComplete = {"shadyrp_blackwater_ledger_law"}
}
