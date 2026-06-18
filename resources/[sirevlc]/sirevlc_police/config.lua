
Config = {}
 
-- Version 1.5 - 10.09.25
-- Turn your framework to true and all the others to false. This is to check jobs

Config.RoleRestriction   = false
Config.REDEMRP2023REBOOT = false
Config.VORP              = false
Config.RSG               = true
 
Config.Debug			 = false  
--List of roles that WILL NOT trigger the police spawn if they commit the crime if Config.RoleRestriction = true
Config.Roles = {
"police",
}
 
Config.EnemyBlipName 		= "Lawman"
 
Config.ALLOWEDWEAPONS = { -- LIST OF WEAPONS ALLOWED TO BE USED AND THAT WON'T TRIGGER THE POLICE
	`WEAPON_UNARMED`,
	-842959696,
	-1569615261,
--	`WEAPON_BOW_IMPROVED`,
--	`WEAPON_FISHINGROD`,
--	`WEAPON_KIT_BINOCULARS`,
--	`WEAPON_KIT_BINOCULARS_IMPROVED`,
--	`WEAPON_KIT_CAMERA`,
--	`WEAPON_KIT_CAMERA_ADVANCED`,
--	`WEAPON_KIT_METAL_DETECTOR`,
--	`WEAPON_LASSO`,
--	`WEAPON_LASSO_REINFORCED`,
--	`WEAPON_MELEE_CLEAVER`,
--	`WEAPON_MELEE_DAVY_LANTERN`,
--	`WEAPON_MELEE_HAMMER`,
--	`WEAPON_MELEE_HATCHET`,
--	`WEAPON_MELEE_HATCHET_HUNTER`,
--	`WEAPON_MELEE_KNIFE`,
--	`WEAPON_MELEE_KNIFE_HORROR`,
--	`WEAPON_MELEE_KNIFE_JAWBONE`,
--	`WEAPON_MELEE_KNIFE_RUSTIC`,
--	`WEAPON_MELEE_KNIFE_TRADER`,
--	`WEAPON_MELEE_LANTERN`,
--	`WEAPON_MELEE_LANTERN_HALLOWEEN`,
--	`WEAPON_MELEE_MACHETE`,
--	`WEAPON_MELEE_MACHETE_COLLECTOR`,
--	`WEAPON_MELEE_MACHETE_HORROR`,
--	`WEAPON_MELEE_TORCH`,
--	`WEAPON_MOONSHINEJUG_MP`,
--	`WEAPON_PISTOL_M1899`,
--	`WEAPON_PISTOL_MAUSER`,
--	`WEAPON_PISTOL_SEMIAUTO`,
--	`WEAPON_PISTOL_VOLCANIC`,
--	`WEAPON_REPEATER_CARBINE`,
--	`WEAPON_REPEATER_EVANS`,
--	`WEAPON_REPEATER_HENRY`,
--	`WEAPON_REPEATER_WINCHESTER`,
--	`WEAPON_REVOLVER_CATTLEMAN`,
--	`WEAPON_REVOLVER_CATTLEMAN_MEXICAN`,
--	`WEAPON_REVOLVER_DOUBLEACTION`,
--	`WEAPON_REVOLVER_DOUBLEACTION_GAMBLER`,
--	`WEAPON_REVOLVER_LEMAT`,
--	`WEAPON_REVOLVER_NAVY`,
--	`WEAPON_REVOLVER_NAVY_CROSSOVER`,
--	`WEAPON_REVOLVER_SCHOFIELD`,
--	`WEAPON_RIFLE_BOLTACTION`,
--	`WEAPON_RIFLE_ELEPHANT`,
--	`WEAPON_RIFLE_SPRINGFIELD`,
--	`WEAPON_RIFLE_VARMINT`,
--	`WEAPON_SHOTGUN_DOUBLEBARREL`,
--	`WEAPON_SHOTGUN_PUMP`,
--	`WEAPON_SHOTGUN_REPEATING`,
--	`WEAPON_SHOTGUN_SAWEDOFF`,
--	`WEAPON_SHOTGUN_SEMIAUTO`,
--	`WEAPON_SNIPERRIFLE_CARCANO`,
--	`WEAPON_SNIPERRIFLE_ROLLINGBLOCK`,
--	`WEAPON_THROWN_BOLAS`,
--	`WEAPON_THROWN_BOLAS_HAWKMOTH`,
--	`WEAPON_THROWN_BOLAS_INTERTWINED`,
--	`WEAPON_THROWN_BOLAS_IRONSPIKED`,
--	`WEAPON_THROWN_DYNAMITE`,
--	`WEAPON_THROWN_MOLOTOV`,
--	`WEAPON_THROWN_POISONBOTTLE`,
--	`WEAPON_THROWN_THROWING_KNIVES`,
--	`WEAPON_THROWN_TOMAHAWK`,
--	`WEAPON_THROWN_TOMAHAWK_ANCIENT`,

}
-------------------------------------------------------------------------------
				          -- GENERAL TRANSLATIONS --
------------------------------------------------------------------------------- 
Config.TEXTPoliceAlert              = "WANTED" 
Config.TEXTPoliceAlertSub           = "POLICE IS COMING" 
--                                  
Config.TextPoliceEndOfChase         = "ESCAPED"
Config.TextPoliceEndOfChasesub      = "POLICE STOPPED THE CHASE"
--
Config.TEXTPoliceAlertAssaultSub    = "ASSAULT"
 
-------------------------------------------------------------------------------
						--SCRIPT CONFIGURATION--
------------------------------------------------------------------------------- 


-- PARAMS LIST : 
-- centerzonecoords : the center of the zone where the crime will be detected
-- radius           : from that center, the radius of crime detection
-- pedmodel         : ped model used
-- policespawncoords: where the police will spawn
-- weapon1          : first weapon that they can equip  (this will randomly be chosen between weapon1 and weapon2 )
-- weapon2          : second weapon that they can equip (this will randomly be chosen between weapon1 and weapon2 )
-- health           : the amount of health the police peds have
-- policecooldown   : the cooldown required before the police automatically stop chasing you (in minutes) 
-- poliveinvicible  : are the police peds spawned through the script invincible or not
 
Config.Police = {

[1]  = {centerzonecoords = vector3(-290.94305419921875, 734.415771484375,    117.43962097167969), radius = 170.0, pedmodel = "a_m_m_valdeputyresident_01", policespawncoords = vector3(-276.3995361328125, 810.00537109375,     119.37688446044922), numberofpedstocreate = 10, weapon1 = "weapon_revolver_cattleman" , weapon2 = "weapon_rifle_bolt_action", health = 100 , policecooldown = 10, policeinvicible = false }, -- VALENTINE
[2]  = {centerzonecoords = vector3(-799.2973022460938,  -1316.4456787109375, 43.60391235351562) , radius = 200.0, pedmodel = "s_m_m_ambientblwpolice_01",  policespawncoords = vector3(-764.1717529296875, -1269.4093017578125, 44.04134368896484),  numberofpedstocreate = 10, weapon1 = "weapon_revolver_cattleman" , weapon2 = "weapon_rifle_bolt_action", health = 100 , policecooldown = 10, policeinvicible = false }, -- BLACKWATER
[3]  = {centerzonecoords = vector3(-1804.5823974609375, -404.25775146484375, 154.07200622558594), radius = 120.0, pedmodel = "a_m_m_strdeputyresident_01", policespawncoords = vector3(-1809.540771484375, -350.42059326171875, 164.65406799316406), numberofpedstocreate = 10, weapon1 = "weapon_revolver_cattleman" , weapon2 = "weapon_rifle_bolt_action", health = 100 , policecooldown = 10, policeinvicible = false }, -- STRAWBERRY
[4]  = {centerzonecoords = vector3(-5512.77685546875,   -2940.746826171875,  -2.10357570648193) , radius = 120.0, pedmodel = "a_m_m_armdeputyresident_01", policespawncoords = vector3(-5529.97802734375,  -2928.287353515625,  -1.36092638969421),  numberofpedstocreate = 10, weapon1 = "weapon_revolver_cattleman" , weapon2 = "weapon_rifle_bolt_action", health = 100 , policecooldown = 10, policeinvicible = false }, -- TUMBLEWEED
[5]  = {centerzonecoords = vector3(-3707.22216796875,   -2612.533935546875,  -13.75928592681884), radius = 120.0, pedmodel = "a_m_m_armdeputyresident_01", policespawncoords = vector3(-3622.104248046875, -2602.96728515625,   -13.34250450134277), numberofpedstocreate = 10, weapon1 = "weapon_revolver_cattleman" , weapon2 = "weapon_rifle_bolt_action", health = 100 , policecooldown = 10, policeinvicible = false }, -- ARMADILLO
[6]  = {centerzonecoords = vector3(1307.4217529296875,  -1292.3609619140625, 75.79313659667969) , radius = 120.0, pedmodel = "a_m_m_rhddeputyresident_01", policespawncoords = vector3(1361.3035888671875, -1300.978515625,     77.76056671142578),  numberofpedstocreate = 10, weapon1 = "weapon_revolver_cattleman" , weapon2 = "weapon_rifle_bolt_action", health = 100 , policecooldown = 10, policeinvicible = false }, -- RHODES
[7]  = {centerzonecoords = vector3(2612.107666015625,   -1271.7657470703125, 52.70360565185547) , radius = 330.0, pedmodel = "s_m_m_ambientsdpolice_01"  , policespawncoords = vector3(2488.468994140625,  -1313.80224609375,   48.86573791503906),  numberofpedstocreate = 10, weapon1 = "weapon_revolver_cattleman" , weapon2 = "weapon_rifle_bolt_action", health = 100 , policecooldown = 10, policeinvicible = false }, -- SAINT DENIS 
[8]  = {centerzonecoords = vector3(2959.2890625,        531.40625,           44.44278335571289) , radius = 100.0, pedmodel = "a_m_m_asbdeputyresident_01", policespawncoords = vector3(2933.85791015625,   561.0029907226562,   44.95191955566406),  numberofpedstocreate = 10, weapon1 = "weapon_revolver_cattleman" , weapon2 = "weapon_rifle_bolt_action", health = 100 , policecooldown = 10, policeinvicible = false }, -- VAN HORN 
[9]  = {centerzonecoords = vector3(2929.720947265625,   1332.70849609375,    44.07649612426758) , radius = 170.0, pedmodel = "a_m_m_asbdeputyresident_01", policespawncoords = vector3(2907.049072265625,  1311.461669921875,   44.93824005126953),  numberofpedstocreate = 10, weapon1 = "weapon_revolver_cattleman" , weapon2 = "weapon_rifle_bolt_action", health = 100 , policecooldown = 10, policeinvicible = false }, -- ANNESBURG
[10] = {centerzonecoords = vector3(1347.1072998046875,  -7005.2099609375,    53.6906509399414)  , radius = 200.0, pedmodel = "s_m_m_fussarhenchman_01"   , policespawncoords = vector3(1462.7813720703125, -7128.263671875,     75.89987182617188),  numberofpedstocreate = 10, weapon1 = "weapon_revolver_cattleman" , weapon2 = "weapon_rifle_bolt_action", health = 100 , policecooldown = 10, policeinvicible = false }, -- GUARMA
[11] = {centerzonecoords = vector3(3211.935302734375, -552.1647338867188, 42.94091796875)       , radius = 200.0, pedmodel = "s_m_m_fussarhenchman_01"   , policespawncoords = vector3(3244.015869140625, -596.3850708007812, 43.06084442138672),    numberofpedstocreate = 10, weapon1 = "weapon_revolver_cattleman" , weapon2 = "weapon_rifle_bolt_action", health = 100 , policecooldown = 10, policeinvicible = false }, -- GUARMA
[12] = {centerzonecoords = vector3(2805.6282, -1183.6942, 47.4280)                              , radius = 200.0, pedmodel = "s_m_m_ambientsdpolice_01"  , policespawncoords = vector3(2879.9587, -1187.4924, 46.0075),                              numberofpedstocreate = 10, weapon1 = "weapon_revolver_cattleman" , weapon2 = "weapon_rifle_bolt_action", health = 100 , policecooldown = 10, policeinvicible = false }, -- SD Slums

}
 
 