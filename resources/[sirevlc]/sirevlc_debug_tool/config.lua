Config = {}

-- SEE THE DEBUG TOOL GUIDE : 
-- https://www.sirevlc.com/debug-tool-guide

-- Version 1.91 - 06.03.26

Config.OPEN_COMMAND_ENABLED 		   = true
Config.OPEN_COMMAND 				   = "menu_debug"
 
Config.AUTO_OPEN_REPORT_MENU		   = false
 
Config.PRINT_REPORT_TO_CLIENT_CONSOLE  = true

-- =========================================================
-- OPTIONS
-- =========================================================

-- If true, the DB table analyzer will NOT report column order mismatches.
-- (Useful when you don't care about ORDINAL_POSITION differences.)
Config.DB_CHECK_IGNORE_ORDER_MISMATCH = true

-- If true, the config analyzer will report sparse numeric index tables
-- like {[1]=..., [3]=...} (missing [2]).
-- Disable if you intentionally use sparse numeric keys.
Config.CONFIG_CHECK_INDEX_GAPS = true
 
-- =========================================================
-- MULTI CONFIG SUPPORT
-- =========================================================
 
--  Exemple:
  Config.Targets = {
  
    SIREVLC_HORSES = {
    resourceName   = "sirevlc_horses", 		-- RESOURCE FOLDER NAME 
    defaultFolder  = "SIREVLC_HORSES",		-- FOLDER NAME IN DEBUG TOOL
	
    -- CONFIG COMPARING FILES LIST 
configs = {
  { label = "BREEDING",                   userConfigPath = "CONFIG/BREEDING.lua",                     defaultConfigPath = "BREEDING.lua" },
  { label = "BREEDS",                     userConfigPath = "CONFIG/BREEDS.lua",                       defaultConfigPath = "BREEDS.lua" },
  { label = "GENERAL_OPTIONS",            userConfigPath = "CONFIG/GENERAL_OPTIONS.lua",              defaultConfigPath = "GENERAL_OPTIONS.lua" },
  { label = "INTERACTIONS",               userConfigPath = "CONFIG/INTERACTIONS.lua",                 defaultConfigPath = "INTERACTIONS.lua" },
  { label = "MENUS",                      userConfigPath = "CONFIG/MENUS.lua",                        defaultConfigPath = "MENUS.lua" },
  { label = "PERSONALITY_AND_METABOLISM", userConfigPath = "CONFIG/PERSONALITY_AND_METABOLISM.lua",   defaultConfigPath = "PERSONALITY_AND_METABOLISM.lua" },
  { label = "STABLES",                    userConfigPath = "CONFIG/STABLES.lua",                      defaultConfigPath = "STABLES.lua" },
  { label = "TACK",                       userConfigPath = "CONFIG/TACK.lua",                         defaultConfigPath = "TACK.lua" },
  { label = "TRAININGS",                  userConfigPath = "CONFIG/TRAININGS.lua",                    defaultConfigPath = "TRAININGS.lua" },
  { label = "TRANSLATIONS",               userConfigPath = "CONFIG/TRANSLATIONS.lua",                 defaultConfigPath = "TRANSLATIONS.lua" },
  { label = "WILD_HORSES",                userConfigPath = "CONFIG/WILD_HORSES.lua",                  defaultConfigPath = "WILD_HORSES.lua" },
},
      userSQLPath      = "sirevlc_stables.sql",
      userSQLTableName = "sirevlc_horses_v3",
   },
   
    SIREVLC_WAGONS = {
    resourceName   = "sirevlc_wagons", 		-- RESOURCE FOLDER NAME 
    defaultFolder  = "SIREVLC_WAGONS",		-- FOLDER NAME IN DEBUG TOOL
    -- CONFIG COMPARING FILES LIST 
	configs = {
	{ label = "HUNTING_WAGON",             		userConfigPath = "CONFIG/HUNTING_WAGON.lua",                	defaultConfigPath = "HUNTING_WAGON.lua" },
	{ label = "MAIN",                      		userConfigPath = "CONFIG/MAIN.lua",                         	defaultConfigPath = "MAIN.lua" },
	{ label = "TRANSLATIONS",              		userConfigPath = "CONFIG/TRANSLATIONS.lua",              	    defaultConfigPath = "TRANSLATIONS.lua" },
	{ label = "WAGONS",             		  	userConfigPath = "CONFIG/WAGONS.lua",                		    defaultConfigPath = "WAGONS.lua" }, 
	},
      userSQLPath      = "",
      userSQLTableName = "",
   },  
 
    SIREVLC_BOATS = {
    resourceName   = "sirevlc_boats", 		-- RESOURCE FOLDER NAME 
    defaultFolder  = "SIREVLC_BOATS",		-- FOLDER NAME IN DEBUG TOOL
    -- CONFIG COMPARING FILES LIST 
	configs = {
	{ label = "CONFIG",              userConfigPath = "config.lua",                defaultConfigPath = "config.lua" },
	},
      userSQLPath      = "",
      userSQLTableName = "",
   },   
   
  
}
 
 
