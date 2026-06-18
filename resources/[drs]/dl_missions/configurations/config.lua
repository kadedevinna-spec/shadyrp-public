Config = {}

Config.Locale = 'en'

Config.Debug = false -- If true, debug messages will be printed in the console

Config.NextQuestWithNPCs = true -- If true the next non story missions will be given by an NPC, if false the next non story missions will be given automatically without an NPC
Config.AlwaysSpawnStoryNPCs = true -- If true the NPCs for story missions will always be spawned, if false the NPCs for story missions will only be spawned if the player could activate the mission or turn it in -> has completed and wants the reward

Config.AdminGroups = {"admin","moderator"}

Config.InventoryItemsImagePath = "nui://v-inventory/web/dist/items/" -- The path to the images for the inventory items, this is used for the mission rewards if you want to give an item as a reward, the image will be shown in the mission complete menu
Config.DialogAudioVolume = 0.5 -- The volume for the dialog audio, this is used for the mission dialogs if you want to play an audio during the dialog, the volume will be set to this value

Config.OpenMissionUICommand = "myMissions"



-- This NPC Gives a Random Mission from a missionType/Category (Daily,Weekly,Doctor,etc) 
-- Mission Types can be defined in cfg_missionsettings.lua
Config.RandomMissionGivers = {

    {
        npcmodel = "a_m_m_huntertravelers_cool_01", -- NPC Model 
        npcname = "Jon Jonson", -- NPC Name
        coords = vector4(-246.3, 770.5, 120.1, 114.75), -- NPC Spawn Position
        spawnDistance = 20.0, 
        blip = {
            sprite = 564457427,
            coords = vector3(-246.3, 770.5, 120.1), -- Position of the Blip
            color = "BLIP_MODIFIER_MP_COLOR_10",
            scale = 0.8,
            name = "Jon Jonson", -- Blip Label
            zoneradius = 0, -- If higher than 0, the blip will be a zone blip with the defined radius, if 0, it will be a normal blip
        },
        animation = {
            useanim = false, -- Should a animation or scenario be played
            dict = "amb@world_human_stand_mobile@male@text@enter",
            name = "enter",
            flag = 1,
            isScenario = false, -- If true, the animation will be played as a scenario, if false, the animation will be played as a normal animation
            scenario = "",
            scenarioProp = "",
            scenarioPosOffset = vector4(0.0, 0.0, 0.0, 0.0), -- Only relevant if isScenario is true, defines the offset for the scenario position, so the position where the scenario will be played is coords + scenarioPosOffset
        },
        dialog = { -- Dialog for the mission given by this NPC
            beginning = {
                {text = "Hey du! Willkommen in unserer Stadt. Es ist schön, dich hier zu haben.", time=3000},
                {text = "Lass mich dir helfen, dich zurechtzufinden und die Grundlagen zu lernen.", time=3000},
                {text = "Es gibt viele Dinge zu tun und Orte zu entdecken. Lass uns gleich loslegen!", time=3000}
            },
            -- Dialog for when you complete the mission given by this NPC, this will only be shown if the mission that was given by this NPC is completed and you talk to the NPC again to turn in the mission and get the reward
            completed = {
                {text = "Gut gemacht! Du hast die Grundlagen gemeistert.", time=2000},
                {text = "Hier ist deine Belohnung. Viel Spaß in der Stadt!", time=3000}
            }
        },
        missionType = "Daily", -- Mission Type that this NPC gives a random mission from
        allowedJobs = {}, -- Which Jobs are allowed to receive a mission from this NPC, if the table is empty, all jobs can receive missions from this NPC
    },

}


-- This NPCs give a specific mission that is defined in the mission configurations
Config.SpecificMissionGivers = {

    {
        npcmodel = "am_valentinedoctors_females_01", -- NPC Model
        npcname = "Ronda Rousey", -- NPC Name
        coords = vector4(-330.0, 777.03, 117.4, 7.47), -- NPC Spawn Position
        spawnDistance = 20.0,
        blip = {
            sprite = 564457427,
            coords = vector3(-330.0, 777.03, 117.4), -- Position of the Blip
            color = "BLIP_MODIFIER_MP_COLOR_10",
            scale = 0.8,
            name = "Ronda Rousey", -- Blip Label
            zoneradius = 0, -- If higher than 0, the blip will be a zone blip with the defined radius, if 0, it will be a normal blip
        },
        animation = {
            useanim = true, -- Should a animation or scenario be played
            dict = "script_mp@bounty@satellite_dropoff",
            name = "sitting_idle_01_genstorymale",
            flag = 1,
            isScenario = true, -- If true, the animation will be played as a scenario, if false, the animation will be played as a normal animation
            scenario = "MP_LOBBY_PROP_HUMAN_SEAT_CHAIR_WHITTLE",
            scenarioProp = "p_bench06x",
            scenarioPosOffset = vector4(-0.5, 0.0, 0.5, 180.0), -- Only relevant if isScenario is true, defines the offset for the scenario position, so the position where the scenario will be played is coords + scenarioPosOffset
        },
        dialog = {
            beginning = {
                {text = "Oh Gott! Wer sind Sie? Und was wollen Sie von mir?", time=3000, audio="dailys/dailys_ronda_wersindsie.mp3"},
                {text = "Puh! Man kann hier in Valentine ja niemandem trauen. Gut das Sie nichts böses im Sinn haben.", time=7000, audio="dailys/dailys_ronda_puh.mp3"},
                {text = "Freut mich Sie kennenzulernen, endlich mal jemand der dieser schmutzigen Stadt etwas gutes will.", time=5000, audio="dailys/dailys_ronda_freutmich.mp3"},
                {text = "Ich hätte da ein paar Aufgaben für Sie, die Sie sich gerne mal anschauen könnten? Wenn es keine Umstände macht natürlich.", time=6000, audio="dailys/dailys_ronda_ichhätte.mp3"},
                {text = "Der Bahnabschnitt ist marode, die Schornsteine stinken, die Zäune und der Boden haben auch schon bessere Tage gesehen.", time=7000, audio="dailys/dailys_ronda_derbahn.mp3"},
                {text = "Ich habe Ihnen mal alle Aufgaben zugesteckt. Na dann! Auf auf, frisch ans Werk! Ich warte hier auf Sie.", time=7000, audio="dailys/dailys_ronda_ichhabe.mp3"},
            },
            completed = {
                {text = "Gut gemacht! Ich habe schon gehört das Sie fleißig waren!", time=7000, audio="dailys/dailys_ronda_gutgemacht.mp3"},
                {text = "Hier ist Ihre Belohnung. Ist doch gleich viel schöner hier!", time=7000, audio="dailys/dailys_ronda_hierist.mp3"},
            }
        },
        missionType = "Daily", -- Mission Type
        missionName = "testmission", -- Specific Mission identifier that this NPC gives
        allowedJobs = {}, -- Which Jobs are allowed to receive a mission from this NPC, if the table is empty, all jobs can receive missions from this NPC
    },

}
