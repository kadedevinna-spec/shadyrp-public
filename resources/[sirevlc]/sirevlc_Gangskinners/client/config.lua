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
 [1]  = {coords = vector3(-1922.3226318359375, -1573.43798828125, 109.68811798095703), numberofpedstocreate = 3, weapon1 = "weapon_melee_machete" , weapon2 = "weapon_repeater_henry", radius = 100.0, cancelmissiondistance = 150.0, reward_dollars = 15.0, reward_gold = 0.0, reward_item = { {ITEM = "consumable_apple", LABEL = "Apple" , COUNT = 1, TXT_DICT = "INVENTORY_ITEMS", TXT_IMAGE = "consumable_apple" },  } }, --if your distance radius is less than 100.0 it will trigger the event (depending on the luck you set above)
 [2]  = {coords = vector3(-2126.261962890625,  -916.2949829101562,105.030517578125),   numberofpedstocreate = 3, weapon1 = "weapon_melee_machete" , weapon2 = "weapon_repeater_henry", radius = 100.0, cancelmissiondistance = 150.0, reward_dollars = 15.0, reward_gold = 0.0, reward_item = { "" } }, 
 [3]  = {coords = vector3(-2022.5162353515625, -880.89501953125,  98.38633728027344),  numberofpedstocreate = 3, weapon1 = "weapon_melee_machete" , weapon2 = "weapon_repeater_henry", radius = 100.0, cancelmissiondistance = 150.0, reward_dollars = 15.0, reward_gold = 0.0, reward_item = { "" } },
 [4]  = {coords = vector3(-1922.3226318359375, -1573.43798828125, 109.68811798095703), numberofpedstocreate = 3, weapon1 = "weapon_melee_machete" , weapon2 = "weapon_repeater_henry", radius = 100.0, cancelmissiondistance = 150.0, reward_dollars = 15.0, reward_gold = 0.0, reward_item = { "" } },
 [5]  = {coords = vector3(-2126.261962890625,  -916.2949829101562,105.030517578125),   numberofpedstocreate = 3, weapon1 = "weapon_melee_machete" , weapon2 = "weapon_repeater_henry", radius = 100.0, cancelmissiondistance = 150.0, reward_dollars = 15.0, reward_gold = 0.0, reward_item = { "" } },
 [6]  = {coords = vector3(-2022.5162353515625, -880.89501953125,  98.38633728027344),  numberofpedstocreate = 3, weapon1 = "weapon_melee_machete" , weapon2 = "weapon_repeater_henry", radius = 100.0, cancelmissiondistance = 150.0, reward_dollars = 15.0, reward_gold = 0.0, reward_item = { "" } },
 [7]  = {coords = vector3(-1922.3226318359375, -1573.43798828125, 109.68811798095703), numberofpedstocreate = 3, weapon1 = "weapon_melee_machete" , weapon2 = "weapon_repeater_henry", radius = 100.0, cancelmissiondistance = 150.0, reward_dollars = 15.0, reward_gold = 0.0, reward_item = { "" } },
 [8]  = {coords = vector3(-2126.261962890625,  -916.2949829101562,105.030517578125),   numberofpedstocreate = 3, weapon1 = "weapon_melee_machete" , weapon2 = "weapon_repeater_henry", radius = 100.0, cancelmissiondistance = 150.0, reward_dollars = 15.0, reward_gold = 0.0, reward_item = { "" } },
 [9]  = {coords = vector3(-2022.5162353515625, -880.89501953125,  98.38633728027344),  numberofpedstocreate = 3, weapon1 = "weapon_melee_machete" , weapon2 = "weapon_repeater_henry", radius = 100.0, cancelmissiondistance = 150.0, reward_dollars = 15.0, reward_gold = 0.0, reward_item = { "" } },
 [10] = {coords = vector3(-1922.3226318359375, -1573.43798828125, 109.68811798095703), numberofpedstocreate = 3, weapon1 = "weapon_melee_machete" , weapon2 = "weapon_repeater_henry", radius = 100.0, cancelmissiondistance = 150.0, reward_dollars = 15.0, reward_gold = 0.0, reward_item = { "" } },
 }
 
 


-------------------------------------------------
	-- SCENARIO 2 | SPAWNING AT CAMP --
-------------------------------------------------

-- COORDS HERE REPRESENTS THE CENTER OF ZONE THAT WILL TRIGGER THE SPAWN. THE NPCS WILL SPAWN IN THESE CAMPS, ROAM AROUND AND GET HOSTILE IF YOU GET CLOSE TO THEM (distancebeforehostility)
-- MAKE SURE THEY SPAWN IN CAMPS SO THEY HAVE SCENARIOS THAT CAN BE PLAYED AROUND OTHERWISE THEY WILL STAND STILL
-- MAKE SURE THAT distancebeforehostility < radius
-- WHEN TESTING THE COORDS MAKE SURE YOU'RE FURTHER THAN DISTANCEBFOREHOSTILITY. IF YOU'RE TOO CLOSE IT WILL NOT WORK
 
Config.CampCoords = {
 
[1]  = {coords = vector3(-2493.814208984375, -1466.4189453125,    147.65501403808594), numberofpedstocreate = 3, weapon1 = "weapon_bow" , weapon2 = "weapon_repeater_henry", radius = 100.0, distancebeforehostility = 30.0, cancelmissiondistance = 150.0, reward_dollars = 15.0, reward_gold = 0.0, reward_item = { "" } },
[2]  = {coords = vector3(-2578.378662109375, -1387.2049560546875, 149.28221130371094), numberofpedstocreate = 3, weapon1 = "weapon_bow" , weapon2 = "weapon_repeater_henry", radius = 100.0, distancebeforehostility = 30.0, cancelmissiondistance = 150.0, reward_dollars = 15.0, reward_gold = 0.0, reward_item = { "" } },
[3]  = {coords = vector3(-2255.816162109375, -1336.9541015625,    132.76153564453125), numberofpedstocreate = 3, weapon1 = "weapon_bow" , weapon2 = "weapon_repeater_henry", radius = 100.0, distancebeforehostility = 30.0, cancelmissiondistance = 150.0, reward_dollars = 15.0, reward_gold = 0.0, reward_item = { "" } },
[4]  = {coords = vector3(-2102.697509765625, -1262.784423828125,  122.96192932128906), numberofpedstocreate = 3, weapon1 = "weapon_bow" , weapon2 = "weapon_repeater_henry", radius = 100.0, distancebeforehostility = 30.0, cancelmissiondistance = 150.0, reward_dollars = 15.0, reward_gold = 0.0, reward_item = { "" } },
[5]  = {coords = vector3(-1933.3536376953125,-1414.1282958984375, 108.23129272460938), numberofpedstocreate = 3, weapon1 = "weapon_bow" , weapon2 = "weapon_repeater_henry", radius = 100.0, distancebeforehostility = 30.0, cancelmissiondistance = 150.0, reward_dollars = 15.0, reward_gold = 0.0, reward_item = { "" } },
[6]  = {coords = vector3(-1949.1280517578125,-1834.4031982421875, 118.2333984375),     numberofpedstocreate = 3, weapon1 = "weapon_bow" , weapon2 = "weapon_repeater_henry", radius = 100.0, distancebeforehostility = 30.0, cancelmissiondistance = 150.0, reward_dollars = 15.0, reward_gold = 0.0, reward_item = { "" } },
[7]  = {coords = vector3(-2065.56787109375,  -1903.61767578125,   112.66111755371094), numberofpedstocreate = 3, weapon1 = "weapon_bow" , weapon2 = "weapon_repeater_henry", radius = 100.0, distancebeforehostility = 30.0, cancelmissiondistance = 150.0, reward_dollars = 15.0, reward_gold = 0.0, reward_item = { "" } },
[8]  = {coords = vector3(-2012.74609375,     -1825.6795654296875, 114.00813293457031), numberofpedstocreate = 3, weapon1 = "weapon_bow" , weapon2 = "weapon_repeater_henry", radius = 100.0, distancebeforehostility = 30.0, cancelmissiondistance = 150.0, reward_dollars = 15.0, reward_gold = 0.0, reward_item = { "" } },
[9]  = {coords = vector3(-2198.188720703125, -1560.5047607421875, 150.52687072753906), numberofpedstocreate = 3, weapon1 = "weapon_bow" , weapon2 = "weapon_repeater_henry", radius = 100.0, distancebeforehostility = 30.0, cancelmissiondistance = 150.0, reward_dollars = 15.0, reward_gold = 0.0, reward_item = { "" } },
[10] = {coords = vector3(-2491.876953125,    -1464.99609375,      147.67922973632812), numberofpedstocreate = 3, weapon1 = "weapon_bow" , weapon2 = "weapon_repeater_henry", radius = 100.0, distancebeforehostility = 30.0, cancelmissiondistance = 150.0, reward_dollars = 15.0, reward_gold = 0.0, reward_item = { "" } }, 
}
 

------------------------------------------------
			 --TIME OF ACTIVITY--
------------------------------------------------
--This is where you set their time of activity
Config.ActivityHour0  = true --MIDNIGHT
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

-- TriggerEvent("HatePlayerGang_SKINNERS") --
											  
 