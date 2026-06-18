Config = {}
 
-- Version 1.6 - 14.11.25  
--Turn your framework to true and all the others to false. This is to check jobs

Config.RoleRestriction   = false
Config.REDEMRP2          = false
Config.REDEMRP2023REBOOT = false
Config.VORP              = false
Config.RSG               = false
Config.QBR               = false
 
-- List of roles enabled to trigger the spawn event if Config.RoleRestriction = true
-- This will check the player's role set in the framework's character table
Config.Roles = {
"horsetrainer",
}
 
------------------------------------------------
			-- TEXT TRANSLATIONS --
------------------------------------------------
 
Config.TEXTHideoutNotification       = "Something strange is going on around you"
Config.BlipName                      = "Strangers"

--
Config.TEXTHideoutLeaderKilled       = "Leader Killed"
Config.TEXTHideoutNotificationSub    = 'Gang Hideouts'
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
		       -- COORDS --
------------------------------------------------

-- I RECOMMEND TO NOT PUT A RADIUS ABOVE 200. THIS WILL LIKELY CAUSE NPCS TO SPAWN OUTSIDE OF PLAYER'S CULLING ZONE AND THEN ISSUES WITH SYNC WILL START TO APPEAR.

-------------------------------------
		-- SCENARIO1 | AMBUSH --
-------------------------------------

Config.AmbushCoords  =  {
  [1]  = {coords = vector3(2030.61, -419.802, 42.64), numberofpedstocreate = 3, weapon1 = "weapon_melee_machete" , weapon2 = "weapon_melee_machete", radius = 100.0, cancelmissiondistance = 150.0, reward_dollars = 15.0, reward_gold = 0.0, reward_item = { {ITEM = "consumable_apple", LABEL = "Apple" , COUNT = 1, TXT_DICT = "INVENTORY_ITEMS", TXT_IMAGE = "consumable_apple" },  } }, --if your distance radius is less than 100.0 it will trigger the event (depending on the luck you set above)
  [2]  = {coords = vector3(1991.68, -533.937, 41.57), numberofpedstocreate = 3, weapon1 = "weapon_melee_machete" , weapon2 = "weapon_melee_machete", radius = 100.0, cancelmissiondistance = 150.0, reward_dollars = 15.0, reward_gold = 0.0, reward_item = { "" } }, 
  [3]  = {coords = vector3(2109.09, -478.537, 41.72), numberofpedstocreate = 3, weapon1 = "weapon_melee_machete" , weapon2 = "weapon_melee_machete", radius = 100.0, cancelmissiondistance = 150.0, reward_dollars = 15.0, reward_gold = 0.0, reward_item = { "" } },
  [4]  = {coords = vector3(2172.25, -441.810, 41.63), numberofpedstocreate = 3, weapon1 = "weapon_melee_machete" , weapon2 = "weapon_melee_machete", radius = 100.0, cancelmissiondistance = 150.0, reward_dollars = 15.0, reward_gold = 0.0, reward_item = { "" } },
  [5]  = {coords = vector3(2249.40, -540.610, 41.80), numberofpedstocreate = 3, weapon1 = "weapon_melee_machete" , weapon2 = "weapon_melee_machete", radius = 100.0, cancelmissiondistance = 150.0, reward_dollars = 15.0, reward_gold = 0.0, reward_item = { "" } },
  [6]  = {coords = vector3(2382.96, -621.122, 41.53), numberofpedstocreate = 3, weapon1 = "weapon_melee_machete" , weapon2 = "weapon_melee_machete", radius = 100.0, cancelmissiondistance = 150.0, reward_dollars = 15.0, reward_gold = 0.0, reward_item = { "" } },
  [7]  = {coords = vector3(2376.13, -758.624, 42.02), numberofpedstocreate = 3, weapon1 = "weapon_melee_machete" , weapon2 = "weapon_melee_machete", radius = 100.0, cancelmissiondistance = 150.0, reward_dollars = 15.0, reward_gold = 0.0, reward_item = { "" } },
  [8]  = {coords = vector3(1842.04, -934.461, 42.53), numberofpedstocreate = 3, weapon1 = "weapon_melee_machete" , weapon2 = "weapon_melee_machete", radius = 100.0, cancelmissiondistance = 150.0, reward_dollars = 15.0, reward_gold = 0.0, reward_item = { "" } },
  [9]  = {coords = vector3(1702.12, -1123.20, 41.73), numberofpedstocreate = 3, weapon1 = "weapon_melee_machete" , weapon2 = "weapon_melee_machete", radius = 100.0, cancelmissiondistance = 150.0, reward_dollars = 15.0, reward_gold = 0.0, reward_item = { "" } },
  [10] = {coords = vector3(1658.78, -1000.06, 41.57), numberofpedstocreate = 3, weapon1 = "weapon_melee_machete" , weapon2 = "weapon_melee_machete", radius = 100.0, cancelmissiondistance = 150.0, reward_dollars = 15.0, reward_gold = 0.0, reward_item = { "" } },
}
 
-------------------------------------------------
	-- SCENARIO 2 | SPAWNING AT CAMP --
-------------------------------------------------

-- COORDS HERE REPRESENTS THE CENTER OF ZONE THAT WILL TRIGGER THE SPAWN. THE NPCS WILL SPAWN IN THESE CAMPS, ROAM AROUND AND GET HOSTILE IF YOU GET CLOSE TO THEM (distancebeforehostility)
-- MAKE SURE THEY SPAWN IN CAMPS SO THEY HAVE SCENARIOS THAT CAN BE PLAYED AROUND OTHERWISE THEY WILL STAND STILL
-- MAKE SURE THAT distancebeforehostility < radius
-- WHEN TESTING THE COORDS MAKE SURE YOU'RE FURTHER THAN DISTANCEBFOREHOSTILITY. IF YOU'RE TOO CLOSE IT WILL NOT WORK
 
 
 Config.CampCoords = {
    [1]  = {coords = vector3(1884.32,  -742.62,  41.87), numberofpedstocreate = 3, weapon1 = "weapon_melee_machete" , weapon2 = "weapon_melee_machete", radius = 100.0, distancebeforehostility = 30.0, cancelmissiondistance = 150.0, reward_dollars = 15.0, reward_gold = 0.0, reward_item = { "" } }, 
    [2]  = {coords = vector3(1930.21,  -728.26,  43.42), numberofpedstocreate = 3, weapon1 = "weapon_melee_machete" , weapon2 = "weapon_melee_machete", radius = 100.0, distancebeforehostility = 30.0, cancelmissiondistance = 150.0, reward_dollars = 15.0, reward_gold = 0.0, reward_item = { "" } }, 
    [3]  = {coords = vector3(2103.06, -284.66, 43.00),   numberofpedstocreate = 3, weapon1 = "weapon_melee_machete" , weapon2 = "weapon_melee_machete", radius = 100.0, distancebeforehostility = 30.0, cancelmissiondistance = 150.0, reward_dollars = 15.0, reward_gold = 0.0, reward_item = { "" } },
    [4]  = {coords = vector3(2250.38,  -769.43,  42.77), numberofpedstocreate = 3, weapon1 = "weapon_melee_machete" , weapon2 = "weapon_melee_machete", radius = 100.0, distancebeforehostility = 30.0, cancelmissiondistance = 150.0, reward_dollars = 15.0, reward_gold = 0.0, reward_item = { "" } },
    [5]  = {coords = vector3(2067.46, -853.12, 43.36),   numberofpedstocreate = 3, weapon1 = "weapon_melee_machete" , weapon2 = "weapon_melee_machete", radius = 100.0, distancebeforehostility = 30.0, cancelmissiondistance = 150.0, reward_dollars = 15.0, reward_gold = 0.0, reward_item = { "" } },
    [6]  = {coords = vector3(2017.93, -771.71, 42.85),   numberofpedstocreate = 3, weapon1 = "weapon_melee_machete" , weapon2 = "weapon_melee_machete", radius = 100.0, distancebeforehostility = 30.0, cancelmissiondistance = 150.0, reward_dollars = 15.0, reward_gold = 0.0, reward_item = { "" } },
    [7]  = {coords = vector3(2491.31, -420.07, 44.23),   numberofpedstocreate = 3, weapon1 = "weapon_melee_machete" , weapon2 = "weapon_melee_machete", radius = 100.0, distancebeforehostility = 30.0, cancelmissiondistance = 150.0, reward_dollars = 15.0, reward_gold = 0.0, reward_item = { "" } },
  --[8]  = {coords = vector3(2237.18, -144.41, 47.62),   numberofpedstocreate = 3, weapon1 = "weapon_melee_machete" , weapon2 = "weapon_melee_machete", radius = 100.0, distancebeforehostility = 30.0, cancelmissiondistance = 150.0, reward_dollars = 15.0, reward_gold = 0.0, reward_item = { "" } },
 }
 
 
 
 
------------------------------------------------
			 --TIME OF ACTIVITY--
------------------------------------------------
--This is where you set their time of activity
Config.ActivityHour0  = true -- MIDNIGHT
Config.ActivityHour1  = true
Config.ActivityHour2  = true
Config.ActivityHour3  = true
Config.ActivityHour4  = true
Config.ActivityHour5  = true
Config.ActivityHour6  = false
Config.ActivityHour7  = false
Config.ActivityHour8  = false
Config.ActivityHour9  = false
Config.ActivityHour10 = false
Config.ActivityHour11 = false
Config.ActivityHour12 = false
Config.ActivityHour13 = false
Config.ActivityHour14 = false
Config.ActivityHour15 = false
Config.ActivityHour16 = false
Config.ActivityHour17 = false
Config.ActivityHour18 = false
Config.ActivityHour19 = false
Config.ActivityHour20 = false
Config.ActivityHour21 = true
Config.ActivityHour22 = true
Config.ActivityHour23 = true
Config.ActivityHour24 = true
------------------------------------------------
                --HOSTILITY EVENT--
------------------------------------------------
--For those who have custom scripts that makes you respawn in the area where you got killed, insert this event at the end of your respawn script.
--This will ensure that the NPCS are still hostile towards you.

-- TriggerEvent("HatePlayerGang_NIGHT_FOLKS") --
											  
 