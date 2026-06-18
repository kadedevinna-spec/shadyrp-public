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
 
-- I RECOMMEND TO NOT PUT A RADIUS ABOVE 150. THIS WILL LIKELY CAUSE NPCS TO SPAWN OUTSIDE OF PLAYER'S CULLING ZONE AND THEN ISSUES WITH SYNC WILL START TO APPEAR.

-------------------------------------
		-- SCENARIO1 | AMBUSH --
-------------------------------------
 
Config.AmbushCoords  =  {
 [1]   = {coords = vector3(-3052.61, -2465.97, 27.75)  , numberofpedstocreate = 3, weapon1 = "weapon_revolver_cattleman" , weapon2 = "weapon_repeater_evans", radius = 100.0, cancelmissiondistance = 150.0, reward_dollars = 15.0, reward_gold = 0.0, reward_item = { {ITEM = "consumable_apple", LABEL = "Apple" , COUNT = 1, TXT_DICT = "INVENTORY_ITEMS", TXT_IMAGE = "consumable_apple" },  } }, 
 [2]   = {coords = vector3(-2199.15, -2709.86, 58.76)  , numberofpedstocreate = 3, weapon1 = "weapon_revolver_cattleman" , weapon2 = "weapon_repeater_evans", radius = 100.0, cancelmissiondistance = 150.0, reward_dollars = 15.0, reward_gold = 0.0, reward_item = { "" } }, 
 [3]   = {coords = vector3(-3457.40, -2267.21, -0.84)  , numberofpedstocreate = 3, weapon1 = "weapon_revolver_cattleman" , weapon2 = "weapon_repeater_evans", radius = 100.0, cancelmissiondistance = 150.0, reward_dollars = 15.0, reward_gold = 0.0, reward_item = { "" } }, 
 [4]   = {coords = vector3(-4791.96, -2707.19, -14.43) , numberofpedstocreate = 3, weapon1 = "weapon_revolver_cattleman" , weapon2 = "weapon_repeater_evans", radius = 100.0, cancelmissiondistance = 150.0, reward_dollars = 15.0, reward_gold = 0.0, reward_item = { "" } }, 
 [5]   = {coords = vector3(-4672.10, -3248.55, 9.26)   , numberofpedstocreate = 3, weapon1 = "weapon_revolver_cattleman" , weapon2 = "weapon_repeater_evans", radius = 100.0, cancelmissiondistance = 150.0, reward_dollars = 15.0, reward_gold = 0.0, reward_item = { "" } }, 
 [6]   = {coords = vector3(-6224.96, -3711.22, -4.54)  , numberofpedstocreate = 3, weapon1 = "weapon_revolver_cattleman" , weapon2 = "weapon_repeater_evans", radius = 100.0, cancelmissiondistance = 150.0, reward_dollars = 15.0, reward_gold = 0.0, reward_item = { "" } }, 
 [7]   = {coords = vector3(-4470.43, -2721.57, -11.58) , numberofpedstocreate = 3, weapon1 = "weapon_revolver_cattleman" , weapon2 = "weapon_repeater_evans", radius = 100.0, cancelmissiondistance = 150.0, reward_dollars = 15.0, reward_gold = 0.0, reward_item = { "" } }, 
 [8]   = {coords = vector3(-4236.94, -2742.38, -1.38)  , numberofpedstocreate = 3, weapon1 = "weapon_revolver_cattleman" , weapon2 = "weapon_repeater_evans", radius = 100.0, cancelmissiondistance = 150.0, reward_dollars = 15.0, reward_gold = 0.0, reward_item = { "" } }, 
 [9]   = {coords = vector3(-2756.04, -3108.09, 7.52)   , numberofpedstocreate = 3, weapon1 = "weapon_revolver_cattleman" , weapon2 = "weapon_repeater_evans", radius = 100.0, cancelmissiondistance = 150.0, reward_dollars = 15.0, reward_gold = 0.0, reward_item = { "" } }, 
 [10]  = {coords = vector3(-1518.53, -2610.91, 61.93)  , numberofpedstocreate = 3, weapon1 = "weapon_revolver_cattleman" , weapon2 = "weapon_repeater_evans", radius = 100.0, cancelmissiondistance = 150.0, reward_dollars = 15.0, reward_gold = 0.0, reward_item = { "" } }, 
 }
 

-------------------------------------------------
	-- SCENARIO 2 | SPAWNING AT CAMP --
-------------------------------------------------

-- COORDS HERE REPRESENTS THE CENTER OF ZONE THAT WILL TRIGGER THE SPAWN. THE NPCS WILL SPAWN IN THESE CAMPS, ROAM AROUND AND GET HOSTILE IF YOU GET CLOSE TO THEM (distancebeforehostility)
-- MAKE SURE THEY SPAWN IN CAMPS SO THEY HAVE SCENARIOS THAT CAN BE PLAYED AROUND OTHERWISE THEY WILL STAND STILL
-- MAKE SURE THAT distancebeforehostility < radius
-- WHEN TESTING THE COORDS MAKE SURE YOU'RE FURTHER THAN DISTANCEBFOREHOSTILITY. IF YOU'RE TOO CLOSE IT WILL NOT WORK
 
Config.CampCoords = {
 
[1]  = {coords = vector3(-3880.413818359375,-3488.435546875,     62.22005462646484) ,  numberofpedstocreate = 3, weapon1 = "weapon_revolver_cattleman" , weapon2 = "weapon_repeater_evans", radius = 100.0, distancebeforehostility = 30.0, cancelmissiondistance = 150.0, reward_dollars = 15.0, reward_gold = 0.0, reward_item = { "" } },
[2]  = {coords = vector3(-4203.85546875,    -3438.2587890625,    37.0675048828125),    numberofpedstocreate = 3, weapon1 = "weapon_revolver_cattleman" , weapon2 = "weapon_repeater_evans", radius = 100.0, distancebeforehostility = 30.0, cancelmissiondistance = 150.0, reward_dollars = 15.0, reward_gold = 0.0, reward_item = { "" } },
[3]  = {coords = vector3(-4636.99951171875, -3363.104736328125,  21.86249351501465) ,  numberofpedstocreate = 3, weapon1 = "weapon_revolver_cattleman" , weapon2 = "weapon_repeater_evans", radius = 100.0, distancebeforehostility = 30.0, cancelmissiondistance = 150.0, reward_dollars = 15.0, reward_gold = 0.0, reward_item = { "" } },
[4]  = {coords = vector3(-4687.51220703125, -3753.118896484375,  13.05412292480468) ,  numberofpedstocreate = 3, weapon1 = "weapon_revolver_cattleman" , weapon2 = "weapon_repeater_evans", radius = 100.0, distancebeforehostility = 30.0, cancelmissiondistance = 150.0, reward_dollars = 15.0, reward_gold = 0.0, reward_item = { "" } },
[5]  = {coords = vector3(-5403.37939453125, -3660.27197265625,   -21.99400329589843),  numberofpedstocreate = 3, weapon1 = "weapon_revolver_cattleman" , weapon2 = "weapon_repeater_evans", radius = 100.0, distancebeforehostility = 30.0, cancelmissiondistance = 150.0, reward_dollars = 15.0, reward_gold = 0.0, reward_item = { "" } },
[6]  = {coords = vector3(-6000.125,         -3261.003173828125,  -21.54353904724121) , numberofpedstocreate = 3, weapon1 = "weapon_revolver_cattleman" , weapon2 = "weapon_repeater_evans", radius = 100.0, distancebeforehostility = 30.0, cancelmissiondistance = 150.0, reward_dollars = 15.0, reward_gold = 0.0, reward_item = { "" } },
[7]  = {coords = vector3(-5197.98876953125, -2125.55908203125,   12.2514591217041),    numberofpedstocreate = 3, weapon1 = "weapon_revolver_cattleman" , weapon2 = "weapon_repeater_evans", radius = 100.0, distancebeforehostility = 30.0, cancelmissiondistance = 150.0, reward_dollars = 15.0, reward_gold = 0.0, reward_item = { "" } },
[8]  = {coords = vector3(-5083.59423828125, -2523.585205078125,  -11.2331256866455) ,  numberofpedstocreate = 3, weapon1 = "weapon_revolver_cattleman" , weapon2 = "weapon_repeater_evans", radius = 100.0, distancebeforehostility = 30.0, cancelmissiondistance = 150.0, reward_dollars = 15.0, reward_gold = 0.0, reward_item = { "" } },
[9]  = {coords = vector3(-3968.1796875,     -2138.748046875,     -5.51893806457519) ,  numberofpedstocreate = 3, weapon1 = "weapon_revolver_cattleman" , weapon2 = "weapon_repeater_evans", radius = 100.0, distancebeforehostility = 30.0, cancelmissiondistance = 150.0, reward_dollars = 15.0, reward_gold = 0.0, reward_item = { "" } },
[10] = {coords = vector3(-2723.9111328125,  -2368.712646484375,  45.13905715942383) ,  numberofpedstocreate = 3, weapon1 = "weapon_revolver_cattleman" , weapon2 = "weapon_repeater_evans", radius = 100.0, distancebeforehostility = 30.0, cancelmissiondistance = 150.0, reward_dollars = 15.0, reward_gold = 0.0, reward_item = { "" } },
}
 
------------------------------------------------
			 --TIME OF ACTIVITY--
------------------------------------------------
--This is where you set their time of activity
Config.ActivityHour0  = true -- midnight
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

-- TriggerEvent("HatePlayerGang_DEL_LOBO") --
 