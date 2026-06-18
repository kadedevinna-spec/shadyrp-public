Config = {}
 
--Turn your framework to true and all the others to false. This is to check jobs

Config.RoleRestriction   = false
Config.REDEMRP2          = false
Config.REDEMRP2023REBOOT = false
Config.VORP              = false
Config.RSG               = true
Config.QBR               = false
 
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
Config.Luck   						= 50  -- Chances of spawning each time you enter the zone (NO FLOAT !)
Config.Reward 						= 10   -- Reward when you kill a camp leader
Config.Cooldown 					= 30   -- Cooldown in minutes before chances to trigger another enemy spawn 

------------------------------------------------
					--COORDS--
------------------------------------------------

-------------------------------------
		-- SCENARIO1 | AMBUSH --
-------------------------------------
 
Config.AmbushCoords  =  {
 [1]  = {coords = vector3(2361.176025390625, 1337.1895751953125, 105.8404769897461),  numberofpedstocreate = 3, weapon1 = "weapon_bow" , weapon2 = "weapon_melee_machete", radius = 100.0, cancelmissiondistance = 150.0}, --if your distance radius is less than 100.0 it will trigger the event (depending on the luck you set above)
 [2]  = {coords = vector3(2496.87841796875,  629.9010009765625,  69.48416137695312),  numberofpedstocreate = 3, weapon1 = "weapon_bow" , weapon2 = "weapon_melee_machete", radius = 100.0, cancelmissiondistance = 150.0}, 
 [3]  = {coords = vector3(2150.318115234375, 1097.7442626953125, 122.91704559326172), numberofpedstocreate = 3, weapon1 = "weapon_bow" , weapon2 = "weapon_melee_machete", radius = 100.0, cancelmissiondistance = 150.0}, 
 [4]  = {coords = vector3(2127.65625,        1401.4088134765625, 146.3177032470703),  numberofpedstocreate = 3, weapon1 = "weapon_bow" , weapon2 = "weapon_melee_machete", radius = 100.0, cancelmissiondistance = 150.0}, 
 [5]  = {coords = vector3(2300.171875,       1752.1590576171875, 107.19998168945312), numberofpedstocreate = 3, weapon1 = "weapon_bow" , weapon2 = "weapon_melee_machete", radius = 100.0, cancelmissiondistance = 150.0}, 
 [6]  = {coords = vector3(2762.661865234375, 2250.266357421875,  157.5478973388672),  numberofpedstocreate = 3, weapon1 = "weapon_bow" , weapon2 = "weapon_melee_machete", radius = 100.0, cancelmissiondistance = 150.0}, 
 [7]  = {coords = vector3(2873.53466796875,  1810.3851318359375, 131.95179748535156), numberofpedstocreate = 3, weapon1 = "weapon_bow" , weapon2 = "weapon_melee_machete", radius = 100.0, cancelmissiondistance = 150.0}, 
 [8]  = {coords = vector3(2300.171875,       1752.1590576171875, 107.19998168945312), numberofpedstocreate = 3, weapon1 = "weapon_bow" , weapon2 = "weapon_melee_machete", radius = 100.0, cancelmissiondistance = 150.0}, 
 [9]  = {coords = vector3(2496.87841796875,  629.9010009765625,  69.48416137695312),  numberofpedstocreate = 3, weapon1 = "weapon_bow" , weapon2 = "weapon_melee_machete", radius = 100.0, cancelmissiondistance = 150.0}, 
 [10] = {coords = vector3(2127.65625,        1401.4088134765625, 146.3177032470703) , numberofpedstocreate = 3, weapon1 = "weapon_bow" , weapon2 = "weapon_melee_machete", radius = 100.0, cancelmissiondistance = 150.0}, 
 }
 
 
-------------------------------------------------
	-- SCENARIO 2 | SPAWNING AT CAMP --
-------------------------------------------------

-- COORDS HERE REPRESENTS THE CENTER OF ZONE THAT WILL TRIGGER THE SPAWN. THE NPCS WILL SPAWN IN THESE CAMPS, ROAM AROUND AND GET HOSTILE IF YOU GET CLOSE TO THEM (distancebeforehostility)
-- MAKE SURE THEY SPAWN IN CAMPS SO THEY HAVE SCENARIOS THAT CAN BE PLAYED AROUND OTHERWISE THEY WILL STAND STILL
-- MAKE SURE THAT distancebeforehostility < radius
-- WHEN TESTING THE COORDS MAKE SURE YOU'RE FURTHER THAN DISTANCEBFOREHOSTILITY. IF YOU'RE TOO CLOSE IT WILL NOT WORK
 
Config.CampCoords = { 
	[1]  = {coords = vector3(2557.1328125,      790.7864990234375, 75.66871643066406)  , numberofpedstocreate = 3, weapon1 = "weapon_bow" , weapon2 = "weapon_melee_machete", radius = 100.0, distancebeforehostility = 30.0, cancelmissiondistance = 150.0}, 
	[2]  = {coords = vector3(2424.479248046875, 777.3343505859375, 68.34941864013672)  , numberofpedstocreate = 3, weapon1 = "weapon_bow" , weapon2 = "weapon_melee_machete", radius = 100.0, distancebeforehostility = 30.0, cancelmissiondistance = 150.0},   
	[3]  = {coords = vector3(2360.2841796875,   840.0453491210938, 79.39854431152344)  , numberofpedstocreate = 3, weapon1 = "weapon_bow" , weapon2 = "weapon_melee_machete", radius = 100.0, distancebeforehostility = 30.0, cancelmissiondistance = 150.0},   
	[4]  = {coords = vector3(2387.8203125,      1020.3250732421875,90.3494873046875)   , numberofpedstocreate = 3, weapon1 = "weapon_bow" , weapon2 = "weapon_melee_machete", radius = 100.0, distancebeforehostility = 30.0, cancelmissiondistance = 150.0},   
	[5]  = {coords = vector3(2467.918701171875, 1756.0477294921875,86.5899429321289)   , numberofpedstocreate = 3, weapon1 = "weapon_bow" , weapon2 = "weapon_melee_machete", radius = 100.0, distancebeforehostility = 30.0, cancelmissiondistance = 150.0},  
	[6]  = {coords = vector3(2351.42578125,     1405.6676025390625,103.04637908935547) , numberofpedstocreate = 3, weapon1 = "weapon_bow" , weapon2 = "weapon_melee_machete", radius = 100.0, distancebeforehostility = 30.0, cancelmissiondistance = 150.0},  
	[7]  = {coords = vector3(2349.403564453125, 1354.94384765625,  105.71797943115234) , numberofpedstocreate = 3, weapon1 = "weapon_bow" , weapon2 = "weapon_melee_machete", radius = 100.0, distancebeforehostility = 30.0, cancelmissiondistance = 150.0},  
	[8]  = {coords = vector3(2467.918701171875, 1756.0477294921875,86.5899429321289)   , numberofpedstocreate = 3, weapon1 = "weapon_bow" , weapon2 = "weapon_melee_machete", radius = 100.0, distancebeforehostility = 30.0, cancelmissiondistance = 150.0},  
	[9]  = {coords = vector3(2424.479248046875, 777.3343505859375, 68.34941864013672)  , numberofpedstocreate = 3, weapon1 = "weapon_bow" , weapon2 = "weapon_melee_machete", radius = 100.0, distancebeforehostility = 30.0, cancelmissiondistance = 150.0},  
	[10] = {coords = vector3(2351.42578125,     1405.6676025390625,103.04637908935547) , numberofpedstocreate = 3, weapon1 = "weapon_bow" , weapon2 = "weapon_melee_machete", radius = 100.0, distancebeforehostility = 30.0, cancelmissiondistance = 150.0}, 
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

-- TriggerEvent("HatePlayerGang_MURFREE") --
											  
 