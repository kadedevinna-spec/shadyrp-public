Config = {}

-- V4.0 - 10.02.26

Config.RoleRestriction   = false
Config.REDEMRP2023REBOOT = false
Config.VORP              = false
Config.RSG               = false
  
-- List of roles enabled to trigger the spawn event if Config.RoleRestriction = true
-- This will check the player's role set in the framework's character table
Config.Roles = {
"horsetrainer",
}
 
------------------------------------------------
		 --TEXT TRANSLATIONS--
------------------------------------------------
 
Config.TEXTHideoutNotification       = "Something strange is going on around you"
Config.BlipName                      = "Strangers"
--
Config.TEXTHideoutLeaderKilled       = "Leader Killed"
Config.TEXTHideoutNotificationSub    = 'Gangs Hideouts'
--
Config.TEXTRewardLeaderKilled 		 = "Camp Leader Killed"
Config.TEXTReward             		 = "Your reward: "
Config.TEXTCurrency           		 = "$"

Config.TEXTAmbushNotificationTitle   = "Survive the ambush"
Config.TEXTAmbushNotificationTitle2  = "Objective Completed"
Config.TEXTAmbushNotificationSub     = "Gang Territory"

 
------------------------------------------------
				-- GENERAL OPTIONS --
------------------------------------------------
Config.DeathCooldown                = 30   -- Number of seconds when all enemies are dead before the game automatically delete their corpses
Config.EnemyAccuracy 				= 90   -- Choose between 0-100
Config.EnableNotifications 		    = true -- Enable / disable notifications  
Config.Luck   						= 100  -- Chances of spawning each time you enter the zone (NO FLOAT !)
Config.Reward 						= 10   -- Reward when you kill a camp leader
Config.Cooldown 					= 30   -- Cooldown in minutes before chances to trigger another enemy spawn 

------------------------------------------------
					--COORDS--
------------------------------------------------

-------------------------------------
		-- SCENARIO1 | AMBUSH --
-------------------------------------
 
Config.AmbushCoords  =  {
 [1]  = {coords = vector3(1480.6788330078125, -1045.1220703125,    54.55728912353515), numberofpedstocreate = 3, weapon1 = "weapon_repeater_henry" , weapon2 = "weapon_revolver_cattleman", radius = 100.0, cancelmissiondistance = 150.0, reward_dollars = 15.0, reward_gold = 0.0, reward_item = { {ITEM = "consumable_apple", LABEL = "Apple" , COUNT = 1, TXT_DICT = "INVENTORY_ITEMS", TXT_IMAGE = "consumable_apple" },  } }, --if your distance radius is less than 100.0 it will trigger the event (depending on the luck you set above)
 [2]  = {coords = vector3(929.2782592773438,  -1147.8634033203125, 53.76697540283203), numberofpedstocreate = 3, weapon1 = "weapon_repeater_henry" , weapon2 = "weapon_revolver_cattleman", radius = 100.0, cancelmissiondistance = 150.0, reward_dollars = 15.0, reward_gold = 0.0, reward_item = { "" } }, 
 [3]  = {coords = vector3(848.3673706054688,  -1030.735107421875,  51.9388198852539),  numberofpedstocreate = 3, weapon1 = "weapon_repeater_henry" , weapon2 = "weapon_revolver_cattleman", radius = 100.0, cancelmissiondistance = 150.0, reward_dollars = 15.0, reward_gold = 0.0, reward_item = { "" } },
 [4]  = {coords = vector3(1161.22412109375,   -913.2122802734375,  67.68029022216797), numberofpedstocreate = 3, weapon1 = "weapon_repeater_henry" , weapon2 = "weapon_revolver_cattleman", radius = 100.0, cancelmissiondistance = 150.0, reward_dollars = 15.0, reward_gold = 0.0, reward_item = { "" } },
 [5]  = {coords = vector3(1090.36083984375,   -569.14501953125,    89.49297332763672), numberofpedstocreate = 3, weapon1 = "weapon_repeater_henry" , weapon2 = "weapon_revolver_cattleman", radius = 100.0, cancelmissiondistance = 150.0, reward_dollars = 15.0, reward_gold = 0.0, reward_item = { "" } },
 [6]  = {coords = vector3(1245.94287109375,   -438.205322265625,   90.61476135253906), numberofpedstocreate = 3, weapon1 = "weapon_repeater_henry" , weapon2 = "weapon_revolver_cattleman", radius = 100.0, cancelmissiondistance = 150.0, reward_dollars = 15.0, reward_gold = 0.0, reward_item = { "" } },
 [7]  = {coords = vector3(1245.94287109375,   -438.205322265625,   90.61476135253906), numberofpedstocreate = 3, weapon1 = "weapon_repeater_henry" , weapon2 = "weapon_revolver_cattleman", radius = 100.0, cancelmissiondistance = 150.0, reward_dollars = 15.0, reward_gold = 0.0, reward_item = { "" } },
 [8]  = {coords = vector3(1090.36083984375,   -569.14501953125,    89.49297332763672), numberofpedstocreate = 3, weapon1 = "weapon_repeater_henry" , weapon2 = "weapon_revolver_cattleman", radius = 100.0, cancelmissiondistance = 150.0, reward_dollars = 15.0, reward_gold = 0.0, reward_item = { "" } },
 [9]  = {coords = vector3(1161.22412109375,   -913.2122802734375,  67.68029022216797), numberofpedstocreate = 3, weapon1 = "weapon_repeater_henry" , weapon2 = "weapon_revolver_cattleman", radius = 100.0, cancelmissiondistance = 150.0, reward_dollars = 15.0, reward_gold = 0.0, reward_item = { "" } },
 [10] = {coords = vector3(848.3673706054688,  -1030.735107421875,  51.9388198852539),  numberofpedstocreate = 3, weapon1 = "weapon_repeater_henry" , weapon2 = "weapon_revolver_cattleman", radius = 100.0, cancelmissiondistance = 150.0, reward_dollars = 15.0, reward_gold = 0.0, reward_item = { "" } },
 }
 
-------------------------------------------------
	-- SCENARIO 2 | SPAWNING AT CAMP --
-------------------------------------------------

-- COORDS HERE REPRESENTS THE CENTER OF ZONE THAT WILL TRIGGER THE SPAWN. THE NPCS WILL SPAWN IN THESE CAMPS, ROAM AROUND AND GET HOSTILE IF YOU GET CLOSE TO THEM (distancebeforehostility)
-- MAKE SURE THEY SPAWN IN CAMPS SO THEY HAVE SCENARIOS THAT CAN BE PLAYED AROUND OTHERWISE THEY WILL STAND STILL
-- MAKE SURE THAT distancebeforehostility < radius
-- WHEN TESTING THE COORDS MAKE SURE YOU'RE FURTHER THAN DISTANCEBFOREHOSTILITY. IF YOU'RE TOO CLOSE IT WILL NOT WORK
 
Config.CampCoords = {
[1]  = {coords = vector3(1111.248046875,      -1990.471923828125,  54.86635589599609), numberofpedstocreate = 3, weapon1 = "weapon_repeater_henry" , weapon2 = "weapon_revolver_cattleman", radius = 100.0, distancebeforehostility = 30.0, cancelmissiondistance = 150.0, reward_dollars = 15.0, reward_gold = 0.0, reward_item = { "" } },
[2]  = {coords = vector3(1584.2919921875,     -1835.4140625,       52.39669036865234), numberofpedstocreate = 3, weapon1 = "weapon_repeater_henry" , weapon2 = "weapon_revolver_cattleman", radius = 100.0, distancebeforehostility = 30.0, cancelmissiondistance = 150.0, reward_dollars = 15.0, reward_gold = 0.0, reward_item = { "" } },
[3]  = {coords = vector3(1879.2672119140625,  -1848.2978515625,    42.6175651550293),  numberofpedstocreate = 3, weapon1 = "weapon_repeater_henry" , weapon2 = "weapon_revolver_cattleman", radius = 100.0, distancebeforehostility = 30.0, cancelmissiondistance = 150.0, reward_dollars = 15.0, reward_gold = 0.0, reward_item = { "" } },
[4]  = {coords = vector3(1879.2672119140625,  -1848.2978515625,    42.6175651550293),  numberofpedstocreate = 3, weapon1 = "weapon_repeater_henry" , weapon2 = "weapon_revolver_cattleman", radius = 100.0, distancebeforehostility = 30.0, cancelmissiondistance = 150.0, reward_dollars = 15.0, reward_gold = 0.0, reward_item = { "" } },
[5]  = {coords = vector3(1896.6490478515625,  -1839.564208984375,  42.59579849243164), numberofpedstocreate = 3, weapon1 = "weapon_repeater_henry" , weapon2 = "weapon_revolver_cattleman", radius = 100.0, distancebeforehostility = 30.0, cancelmissiondistance = 150.0, reward_dollars = 15.0, reward_gold = 0.0, reward_item = { "" } },
[6]  = {coords = vector3(1962.684326171875,   -1879.3118896484375, 41.89815521240234), numberofpedstocreate = 3, weapon1 = "weapon_repeater_henry" , weapon2 = "weapon_revolver_cattleman", radius = 100.0, distancebeforehostility = 30.0, cancelmissiondistance = 150.0, reward_dollars = 15.0, reward_gold = 0.0, reward_item = { "" } },
[7]  = {coords = vector3(2081.3271484375,     -1823.1434326171875, 41.56819534301758), numberofpedstocreate = 3, weapon1 = "weapon_repeater_henry" , weapon2 = "weapon_revolver_cattleman", radius = 100.0, distancebeforehostility = 30.0, cancelmissiondistance = 150.0, reward_dollars = 15.0, reward_gold = 0.0, reward_item = { "" } },
[8]  = {coords = vector3(1998.3197021484375,  -1611.685302734375,  41.90655136108398), numberofpedstocreate = 3, weapon1 = "weapon_repeater_henry" , weapon2 = "weapon_revolver_cattleman", radius = 100.0, distancebeforehostility = 30.0, cancelmissiondistance = 150.0, reward_dollars = 15.0, reward_gold = 0.0, reward_item = { "" } },
[9]  = {coords = vector3(1962.684326171875,   -1879.3118896484375, 41.89815521240234), numberofpedstocreate = 3, weapon1 = "weapon_repeater_henry" , weapon2 = "weapon_revolver_cattleman", radius = 100.0, distancebeforehostility = 30.0, cancelmissiondistance = 150.0, reward_dollars = 15.0, reward_gold = 0.0, reward_item = { "" } },
[10] = {coords = vector3(1962.684326171875,   -1879.3118896484375, 41.89815521240234), numberofpedstocreate = 3, weapon1 = "weapon_repeater_henry" , weapon2 = "weapon_revolver_cattleman", radius = 100.0, distancebeforehostility = 30.0, cancelmissiondistance = 150.0, reward_dollars = 15.0, reward_gold = 0.0, reward_item = { "" } },
}
 
------------------------------------------------
			 --TIME OF ACTIVITY--
------------------------------------------------
--This is where you set their time of activity
Config.ActivityHour0  = true --midnight
Config.ActivityHour1  = true
Config.ActivityHour2  = true
Config.ActivityHour3  = true
Config.ActivityHour4  = true
Config.ActivityHour5  = true
Config.ActivityHour6  = true
Config.ActivityHour7  = true
Config.ActivityHour8  = true
Config.ActivityHour9  = true
Config.ActivityHour10 = true
Config.ActivityHour11 = true
Config.ActivityHour12 = true
Config.ActivityHour13 = true
Config.ActivityHour14 = true
Config.ActivityHour15 = true
Config.ActivityHour16 = true
Config.ActivityHour17 = true
Config.ActivityHour18 = true
Config.ActivityHour19 = true
Config.ActivityHour20 = true
Config.ActivityHour21 = true
Config.ActivityHour22 = true
Config.ActivityHour23 = true
Config.ActivityHour24 = true
------------------------------------------------
                --HOSTILITY EVENT--
------------------------------------------------
--For those who have custom scripts that makes you respawn in the area where you got killed, insert this event at the end of your respawn script.
--This will ensure that the NPCS are still hostile towards you.

-- TriggerEvent("HatePlayerGang_LEMOYNE_RAIDERS") --
											  
 