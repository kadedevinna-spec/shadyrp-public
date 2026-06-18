Config = {}
 
-- V4.0 - 10.02.26

Config.RoleRestriction   = false
Config.REDEMRP2023REBOOT = false
Config.VORP              = true
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

Config.TEXTAmbushNotificationTitle   = "Survive the ambush"
Config.TEXTAmbushNotificationTitle2  = "Objective Completed"
Config.TEXTAmbushNotificationSub     = "Gang Territory"
Config.TEXTSpaceLimit     			 = "You have reached the limit for this item: "
 ------------------------------------------------
				-- GENERAL OPTIONS --
------------------------------------------------
Config.DeathCooldown                = 30   -- Number of seconds when all enemies are dead before the game automatically delete their corpses
Config.EnemyAccuracy 				= 90   -- Choose between 0-100
Config.EnableNotifications 		    = true -- Enable / disable notifications  
Config.Luck   						= 100  -- Chances of spawning each time you enter the zone (NO FLOAT !)
 
Config.Cooldown 					= 30   -- Cooldown in minutes before chances to trigger another enemy spawn 

------------------------------------------------
					--COORDS--
------------------------------------------------

-- I RECOMMEND TO NOT PUT A RADIUS ABOVE 200. THIS WILL LIKELY CAUSE NPCS TO SPAWN OUTSIDE OF PLAYER'S CULLING ZONE AND THEN ISSUES WITH SYNC WILL START TO APPEAR.

-------------------------------------
		-- SCENARIO1 | AMBUSH --
-------------------------------------
 -- REWARD_GOLD IS ONLY FOR VORP ! 
 -- ITEM is the database name (VORP) or name that you've set in your framework inventory file for this item (RSG / REDEMRP)
 -- TXT_DICT is the texture directory
 -- TXT_image is the image, see 
 -- see https://github.com/femga/rdr3_discoveries/tree/master/useful_info_from_rpfs/textures
Config.AmbushCoords  =  {
 [1]  = {coords = vector3(787.8485717773438,  1180.86474609375,   138.177001953125)  , numberofpedstocreate = 3, weapon1 = "weapon_bow" , weapon2 = "weapon_bow", radius = 100.0, cancelmissiondistance = 150.0, reward_dollars = 15.0, reward_gold = 0.0, reward_item = { {ITEM = "consumable_apple", LABEL = "Apple" , COUNT = 1, TXT_DICT = "INVENTORY_ITEMS", TXT_IMAGE = "consumable_apple" },  } }, --if your distance radius is less than 100.0 it will trigger the event (depending on the luck you set above)
 [2]  = {coords = vector3(690.2235107421875,  1428.9705810546875, 180.60159301757812), numberofpedstocreate = 3, weapon1 = "weapon_bow" , weapon2 = "weapon_bow", radius = 100.0, cancelmissiondistance = 150.0, reward_dollars = 15.0, reward_gold = 0.0, reward_item = { {ITEM = "consumable_apple", LABEL = "Apple" , COUNT = 1, TXT_DICT = "INVENTORY_ITEMS", TXT_IMAGE = "consumable_apple" },  } }, 
 [3]  = {coords = vector3(649.3091430664062,  1892.4854736328125, 213.0820770263672) , numberofpedstocreate = 3, weapon1 = "weapon_bow" , weapon2 = "weapon_bow", radius = 100.0, cancelmissiondistance = 150.0, reward_dollars = 15.0, reward_gold = 0.0, reward_item = { {ITEM = "consumable_apple", LABEL = "Apple" , COUNT = 1, TXT_DICT = "INVENTORY_ITEMS", TXT_IMAGE = "consumable_apple" },  } }, 
 [4]  = {coords = vector3(275.2555847167969,  1827.1263427734375, 198.62234497070312), numberofpedstocreate = 3, weapon1 = "weapon_bow" , weapon2 = "weapon_bow", radius = 100.0, cancelmissiondistance = 150.0, reward_dollars = 15.0, reward_gold = 0.0, reward_item = { {ITEM = "consumable_apple", LABEL = "Apple" , COUNT = 1, TXT_DICT = "INVENTORY_ITEMS", TXT_IMAGE = "consumable_apple" },  } }, 
 [5]  = {coords = vector3(-214.0950469970703, 1742.7567138671875, 197.0233154296875) , numberofpedstocreate = 3, weapon1 = "weapon_bow" , weapon2 = "weapon_bow", radius = 100.0, cancelmissiondistance = 150.0, reward_dollars = 15.0, reward_gold = 0.0, reward_item = { {ITEM = "consumable_apple", LABEL = "Apple" , COUNT = 1, TXT_DICT = "INVENTORY_ITEMS", TXT_IMAGE = "consumable_apple" },  } }, 
 [6]  = {coords = vector3(-425.22137451171875,1507.920654296875,  197.08009338378906), numberofpedstocreate = 3, weapon1 = "weapon_bow" , weapon2 = "weapon_bow", radius = 100.0, cancelmissiondistance = 150.0, reward_dollars = 15.0, reward_gold = 0.0, reward_item = { {ITEM = "consumable_apple", LABEL = "Apple" , COUNT = 1, TXT_DICT = "INVENTORY_ITEMS", TXT_IMAGE = "consumable_apple" },  } }, 
 [7]  = {coords = vector3(2020.7664794921875, 890.744384765625,   128.7459259033203) , numberofpedstocreate = 3, weapon1 = "weapon_bow" , weapon2 = "weapon_bow", radius = 100.0, cancelmissiondistance = 150.0, reward_dollars = 15.0, reward_gold = 0.0, reward_item = { {ITEM = "consumable_apple", LABEL = "Apple" , COUNT = 1, TXT_DICT = "INVENTORY_ITEMS", TXT_IMAGE = "consumable_apple" },  } }, 
 [8]  = {coords = vector3(1566.6558837890625, 1662.5518798828125, 145.7175750732422) , numberofpedstocreate = 3, weapon1 = "weapon_bow" , weapon2 = "weapon_bow", radius = 100.0, cancelmissiondistance = 150.0, reward_dollars = 15.0, reward_gold = 0.0, reward_item = { {ITEM = "consumable_apple", LABEL = "Apple" , COUNT = 1, TXT_DICT = "INVENTORY_ITEMS", TXT_IMAGE = "consumable_apple" },  } }, 
 [9]  = {coords = vector3(1214.57177734375,   1953.173095703125,  313.302734375)     , numberofpedstocreate = 3, weapon1 = "weapon_bow" , weapon2 = "weapon_bow", radius = 100.0, cancelmissiondistance = 150.0, reward_dollars = 15.0, reward_gold = 0.0, reward_item = { {ITEM = "consumable_apple", LABEL = "Apple" , COUNT = 1, TXT_DICT = "INVENTORY_ITEMS", TXT_IMAGE = "consumable_apple" },  } }, 
 [10] = {coords = vector3(1377.1416015625,    1656.922119140625,  201.1234588623047) , numberofpedstocreate = 3, weapon1 = "weapon_bow" , weapon2 = "weapon_bow", radius = 100.0, cancelmissiondistance = 150.0, reward_dollars = 15.0, reward_gold = 0.0, reward_item = { {ITEM = "consumable_apple", LABEL = "Apple" , COUNT = 1, TXT_DICT = "INVENTORY_ITEMS", TXT_IMAGE = "consumable_apple" },  } }, 
 }
 
-------------------------------------------------
	   -- SCENARIO 2 | SPAWNING AT CAMP --
-------------------------------------------------

-- COORDS HERE REPRESENTS THE CENTER OF ZONE THAT WILL TRIGGER THE SPAWN. THE NPCS WILL SPAWN IN THESE CAMPS, ROAM AROUND AND GET HOSTILE IF YOU GET CLOSE TO THEM (distancebeforehostility)
-- MAKE SURE THEY SPAWN IN CAMPS SO THEY HAVE SCENARIOS THAT CAN BE PLAYED AROUND OTHERWISE THEY WILL STAND STILL
-- MAKE SURE THAT distancebeforehostility < radius
-- WHEN TESTING THE COORDS MAKE SURE YOU'RE FURTHER THAN DISTANCEBFOREHOSTILITY. IF YOU'RE TOO CLOSE IT WILL NOT WORK
 
Config.CampCoords = {
[1]  = {coords = vector3(-2667.581298828125, -1459.3355712890625, 146.2040557861328 ), numberofpedstocreate = 3, weapon1 = "weapon_bow" , weapon2 = "weapon_bow", radius = 100.0, distancebeforehostility = 30.0, cancelmissiondistance = 150.0, reward_dollars = 15.0, reward_gold = 0.0, reward_item = { {ITEM = "consumable_apple", LABEL = "Apple" , COUNT = 1, TXT_DICT = "INVENTORY_ITEMS", TXT_IMAGE = "consumable_apple" },  } }, 
[2]  = {coords = vector3(994.3679809570312,  989.8378295898438,   151.428466796875  ), numberofpedstocreate = 3, weapon1 = "weapon_bow" , weapon2 = "weapon_bow", radius = 100.0, distancebeforehostility = 30.0, cancelmissiondistance = 150.0, reward_dollars = 15.0, reward_gold = 0.0, reward_item = { {ITEM = "consumable_apple", LABEL = "Apple" , COUNT = 1, TXT_DICT = "INVENTORY_ITEMS", TXT_IMAGE = "consumable_apple" },  } }, 
[3]  = {coords = vector3(1929.6007080078125, 1964.650390625,      263.5680236816406 ), numberofpedstocreate = 3, weapon1 = "weapon_bow" , weapon2 = "weapon_bow", radius = 100.0, distancebeforehostility = 30.0, cancelmissiondistance = 150.0, reward_dollars = 15.0, reward_gold = 0.0, reward_item = { {ITEM = "consumable_apple", LABEL = "Apple" , COUNT = 1, TXT_DICT = "INVENTORY_ITEMS", TXT_IMAGE = "consumable_apple" },  } }, 
[4]  = {coords = vector3(456.61627197265625, 2239.828857421875,   247.9236297607422 ), numberofpedstocreate = 3, weapon1 = "weapon_bow" , weapon2 = "weapon_bow", radius = 100.0, distancebeforehostility = 30.0, cancelmissiondistance = 150.0, reward_dollars = 15.0, reward_gold = 0.0, reward_item = { {ITEM = "consumable_apple", LABEL = "Apple" , COUNT = 1, TXT_DICT = "INVENTORY_ITEMS", TXT_IMAGE = "consumable_apple" },  } }, 
[5]  = {coords = vector3(102.4827651977539,  1415.4659423828125,  167.68043518066406), numberofpedstocreate = 3, weapon1 = "weapon_bow" , weapon2 = "weapon_bow", radius = 100.0, distancebeforehostility = 30.0, cancelmissiondistance = 150.0, reward_dollars = 15.0, reward_gold = 0.0, reward_item = { {ITEM = "consumable_apple", LABEL = "Apple" , COUNT = 1, TXT_DICT = "INVENTORY_ITEMS", TXT_IMAGE = "consumable_apple" },  } }, 
[6]  = {coords = vector3(-4.50056266784668,  952.5202026367188,   210.97824096679688), numberofpedstocreate = 3, weapon1 = "weapon_bow" , weapon2 = "weapon_bow", radius = 100.0, distancebeforehostility = 30.0, cancelmissiondistance = 150.0, reward_dollars = 15.0, reward_gold = 0.0, reward_item = { {ITEM = "consumable_apple", LABEL = "Apple" , COUNT = 1, TXT_DICT = "INVENTORY_ITEMS", TXT_IMAGE = "consumable_apple" },  } }, 
[7]  = {coords = vector3(207.08033752441406, 997.6422729492188,   189.83253479003906), numberofpedstocreate = 3, weapon1 = "weapon_bow" , weapon2 = "weapon_bow", radius = 100.0, distancebeforehostility = 30.0, cancelmissiondistance = 150.0, reward_dollars = 15.0, reward_gold = 0.0, reward_item = { {ITEM = "consumable_apple", LABEL = "Apple" , COUNT = 1, TXT_DICT = "INVENTORY_ITEMS", TXT_IMAGE = "consumable_apple" },  } }, 
[8]  = {coords = vector3(275.3166809082031,  836.91748046875,     190.43125915527344), numberofpedstocreate = 3, weapon1 = "weapon_bow" , weapon2 = "weapon_bow", radius = 100.0, distancebeforehostility = 30.0, cancelmissiondistance = 150.0, reward_dollars = 15.0, reward_gold = 0.0, reward_item = { {ITEM = "consumable_apple", LABEL = "Apple" , COUNT = 1, TXT_DICT = "INVENTORY_ITEMS", TXT_IMAGE = "consumable_apple" },  } }, 
[9]  = {coords = vector3(-1582.5865478515625,496.5709533691406,   114.72482299804688), numberofpedstocreate = 3, weapon1 = "weapon_bow" , weapon2 = "weapon_bow", radius = 100.0, distancebeforehostility = 30.0, cancelmissiondistance = 150.0, reward_dollars = 15.0, reward_gold = 0.0, reward_item = { {ITEM = "consumable_apple", LABEL = "Apple" , COUNT = 1, TXT_DICT = "INVENTORY_ITEMS", TXT_IMAGE = "consumable_apple" },  } }, 
[10] = {coords = vector3(275.3166809082031,  836.91748046875,     190.43125915527344), numberofpedstocreate = 3, weapon1 = "weapon_bow" , weapon2 = "weapon_bow", radius = 100.0, distancebeforehostility = 30.0, cancelmissiondistance = 150.0, reward_dollars = 15.0, reward_gold = 0.0, reward_item = { {ITEM = "consumable_apple", LABEL = "Apple" , COUNT = 1, TXT_DICT = "INVENTORY_ITEMS", TXT_IMAGE = "consumable_apple" },  } }, 
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

-- TriggerEvent("HatePlayerGang_INDIANS") --
											  
 