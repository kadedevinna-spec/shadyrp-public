Config = Config or {}
------------------------------------------
		--TRAINING SETTINGS--
------------------------------------------
-- FIND THE COMPLETE MUSIC LIST HERE https://github.com/femga/rdr3_discoveries/blob/master/audio/music_events/music_events.lua
-- IF YOU ARE ADDING MORE TRAININGS DON'T FORGET TO INCREASE THE TABLE INDEX (1,2,3 etc.)

-- FOR CAMERA POS SEE: https://redlookup.com/natives/?v=2&p=1&pp=50&s=0x40C23491CE83708E&at=0x40C23491CE83708E
-- CAMERA1EXAMPLE = {FLOAT POSX, FLOAT POSY, FLOAT POSZ, FLOAT ROTX, FLOAT ROTY, FLOAT ROTZ, FLOAT FOV},
-- I RECOMMEND USING THE SPOONER TO GET CAMERA COORDS, SEE THE FILE SECTION ON OUR DISCORD TO DOWNLOAD IT 

Config.AFTER_TRAINING_WALLOW          = true  -- IN CASE OF SUCCESS YOUR HORSE WILL HAPPILY ROLL ON THE GROUND 


-----------------------------------
-- LUNGING MINIGAME (SOFT / HARDCORE)
-----------------------------------
 
Config.LUNGING_DEBUG = false


Config.LUNGING_COMMAND_ENABLED = true 				-- IF TRUE IT WILL ENABLE A SOFT PRESET LUNGING COMMAND (DEFAULT METHOD IS BY ITEM USE)
Config.LUNGING_COMMAND         = "horse_lunging"

 
-- Anti-AFK: if the player is lunging without changing speed (walk/trot/gallop or slow/normal/fast)
-- for X minutes, the lunging is automatically stopped.
Config.LUNGING_ANTI_AFK_TIME = 5

Config.LUNGING_PROMPT_GROUP_LABEL = "Lunging"

-- Preset selection (optional helper menu). If you already start a preset directly,
-- you can ignore these two prompts.
Config.LUNGING_PROMPT_PRESET_SOFT_KEY   = `INPUT_CONTEXT` -- E
Config.LUNGING_PROMPT_PRESET_SOFT_TEXT  = "Soft"
Config.LUNGING_PROMPT_PRESET_HARD_KEY   = `INPUT_CREATOR_LT` -- Q
Config.LUNGING_PROMPT_PRESET_HARD_TEXT  = "Hardcore"

-- Main (gaits)
Config.LUNGING_PROMPT_WALK_KEY          = `INPUT_FRONTEND_UP`
Config.LUNGING_PROMPT_WALK_TEXT         = "Walk"
Config.LUNGING_PROMPT_TROT_KEY          = `INPUT_FRONTEND_LEFT`
Config.LUNGING_PROMPT_TROT_TEXT         = "Trot"
Config.LUNGING_PROMPT_GALLOP_KEY        = `INPUT_FRONTEND_RIGHT`
Config.LUNGING_PROMPT_GALLOP_TEXT       = "Gallop"
Config.LUNGING_PROMPT_STOP_KEY          = `INPUT_FRONTEND_ACCEPT`-- ENTER
Config.LUNGING_PROMPT_STOP_TEXT         = "Stop"

-- Change direction (orbit)
-- Default direction is RIGHT -> LEFT (DIRECTION = "LEFT" in CLIENT/MINIGAMES.lua)
Config.LUNGING_PROMPT_CHANGEDIR_KEY     = `INPUT_FRONTEND_DOWN`
Config.LUNGING_PROMPT_CHANGEDIR_TEXT    = "Change Direction"

-- Optional: alternate camera view during lunging (toggle)
Config.LUNGING_PROMPT_VIEW_KEY          = `INPUT_NEXT_CAMERA` -- V
Config.LUNGING_PROMPT_VIEW_TEXT         = "Change view"

-- Jump during lunging
Config.LUNGING_PROMPT_JUMP_KEY          = `INPUT_JUMP` -- SPACEBAR
Config.LUNGING_PROMPT_JUMP_TEXT         = "Jump"

-- Soft preset: speed submenu
Config.LUNGING_PROMPT_SLOW_KEY          = `INPUT_FRONTEND_UP`
Config.LUNGING_PROMPT_SLOW_TEXT         = "Slow"
Config.LUNGING_PROMPT_NORMAL_KEY        = `INPUT_FRONTEND_LEFT`
Config.LUNGING_PROMPT_NORMAL_TEXT       = "Normal"
Config.LUNGING_PROMPT_FAST_KEY          = `INPUT_FRONTEND_RIGHT`
Config.LUNGING_PROMPT_FAST_TEXT         = "Fast"
Config.LUNGING_PROMPT_RETURN_KEY        = `INPUT_FRONTEND_ACCEPT`-- ENTER
Config.LUNGING_PROMPT_RETURN_TEXT       = "Return"

-- Hardcore tuning (ROPE_SLIDER)
Config.LUNGING_HARDCORE_DURATION_MS     = 60000  -- total timer; ball goes fully right at the end
Config.LUNGING_HARDCORE_TOL_WIDTH_PCT   = 14     -- tolerance zone width (percent of the bar), placed behind the ball
Config.LUNGING_HARDCORE_OUTSIDE_FAIL_MS = 3000   -- how long you can stay outside tolerance before failing

-- Hardcore: random direction-change events ("Change direction" prompt)
-- During a warning, the horse icon flips and you have a short time to react.
Config.LUNGING_HARDCORE_DIRCHANGES_DEFAULT = 1   -- how many direction changes per run (default)
Config.LUNGING_HARDCORE_DIRCHANGE_GRACE_MS = 3000 -- time to change direction before slider movement reverses

Config.LUNGING_ZONE_RESTRICTION = false 
Config.LUNGING_ZONES = { 
{LABEL = "EXAMPLE1", COORDS = {-364.62, 818.00, 116.01}, RADIUS = 110.0},
{LABEL = "EXAMPLE2", COORDS = {-364.62, 818.00, 116.01}, RADIUS = 110.0},
}


Config.LUNGING_HARDCORE_SUCCESS_TEXT    = "Good job!"
Config.LUNGING_HARDCORE_FAIL_TEXT       = "You lost the rope!"
Config.LUNGING_HARDCORE_NO_ZONE         = "You are not authorized to do this here"
 
-- ON MOUNT + LEADING TRAININGS 
Config.HORSETRAININGSETTINGS = {
-- BLACKWATER --
[1] = { 
			  ENABLED                   = true,
			  TYPE                      = {ONMOUNT = true, LEADING = true, LUNGING = true},	-- If both ONMOUNT and LEADING are set to true, the system will use the average of their countdown and XP values 	  
			  PLAYER_INSTANCE           = false, 											-- IF TRUE IT WILL PUT THE PLAYER IN AN INSTANCE
			  PLAYERLOCK                = false,
			  PLAYER_LIST               = {
			  [1] = {TRAINING_ACCESS = true, IDENTIFIER = "OTHER_PLAYERS", CHARID = "OTHER_PLAYERS", XPGIVEN = {ONMOUNT = 30, LEADING = 30, LUNGING = 10}, COUNTDOWN = {ONMOUNT = 45, LEADING = 120, LUNGING = 60}},  
 			  },	
			  JOBLOCKED                 = true,
			  JOB_LIST                  = {
			  [1] = {TRAINING_ACCESS = true, LABEL = "OTHER_JOBS",  XPGIVEN = {ONMOUNT = 30, LEADING = 30, LUNGING = 10}, COUNTDOWN = {ONMOUNT = 45, LEADING = 120, LUNGING = 60}},  
 			  },			  
			  DEFAULT_XP	            = {ONMOUNT = 30, LEADING = 30 , LUNGING = 10},	
			  DEFAULT_COUNTDOWN	        = {ONMOUNT = 45, LEADING = 120, LUNGING = 60},
			  BLIPENABLED 				= true,
			  BLIPSPRITE      			= -1327110633,
			  BLIPNAME        			= "HORSE TRAINING",	 
			  BLIPCOORDS                = vector3(-948.1144409179688, -1339.1795654296875, 50.69696044921875), 	
			  PROMPTNAME                = "BLACKWATER STABLES",
			  PROMPTCOORDS              = vector3(-948.1144409179688, -1339.1795654296875, 50.69696044921875), 
			  PROMPTDISTANCE            = 5.0,
			  MUSICENABLED              = true,
			  MUSICUSED                 = "BOU1_START",			  
			  ---------------------------------
			  -- FOR ON MOUNT AND LEADING ONLY ! 
			  ---------------------------------
			  OBSTACLES_ENABLED         = true, 			  
			  OBSTACLES         		= { 
			  [1]  = {ENABLED = true, MODEL = "MP001_P_MP_JUMP_HAYBALESHORT01", COORDS = vector4(-962.64, -1338.97, 49.72, 87.99 ) },   
			  [2]  = {ENABLED = true, MODEL = "MP001_P_MP_JUMP_HAYBALESHORT01", COORDS = vector4(-973.30, -1333.05, 50.62, 0.0   ) },   
			  [3]  = {ENABLED = true, MODEL = "MP001_P_MP_JUMP_HAYBALESHORT01", COORDS = vector4(-972.74, -1319.99, 50.21, 0.0   ) },   
			  [4]  = {ENABLED = true, MODEL = "MP001_P_MP_JUMP_HAYBALESHORT01", COORDS = vector4(-964.46, -1305.18, 49.39, -88.0 ) },   
			  [5]  = {ENABLED = true, MODEL = "MP001_P_MP_JUMP_HAYBALESHORT01", COORDS = vector4(-947.61, -1305.44, 49.10, -84.20) },   
			  },
			  CUTSCENE 						= true,	
			  CAMERACUTSCENE         	    = { 
			  [1] = {DELAY = 2000, CAMERACOORDS = {-993.92, -1353.48, 57.49, -7.58, 0.00, -46.65, 50.00}, },
			  [2] = {DELAY = 2000, CAMERACOORDS = {-993.92, -1353.48, 57.49, -7.58, 0.00, -46.65, 50.00}, },
			  [3] = {DELAY = 2000, CAMERACOORDS = {-993.92, -1353.48, 57.49, -7.58, 0.00, -46.65, 50.00}, },
			  },

			  STARTPLAYERCOORDS         = vector4(-948.1144409179688, -1339.1795654296875, 50.69696044921875, 90.0),
			  CHECKPOINTS               = {
			  [1]  = { COORDS = vector3(-962.64, -1338.97, 49.72+0.7), DETECTIONDISTANCE = 3.0, RGB = {138,138,138} },
			  [2]  = { COORDS = vector3(-973.30, -1333.05, 50.62+0.7), DETECTIONDISTANCE = 3.0, RGB = {138,138,138} },
			  [3]  = { COORDS = vector3(-972.74, -1319.99, 50.21+0.7), DETECTIONDISTANCE = 3.0, RGB = {138,138,138} },
			  [4]  = { COORDS = vector3(-964.46, -1305.18, 49.36+0.7), DETECTIONDISTANCE = 3.0, RGB = {138,138,138} },
			  [5]  = { COORDS = vector3(-947.61, -1305.44, 49.09+0.7), DETECTIONDISTANCE = 3.0, RGB = {138,138,138} },
			  [6]  = { COORDS = vector3(-901.14, -1302.61, 42.46    ), DETECTIONDISTANCE = 3.0, RGB = {138,138,138} },
			  [7]  = { COORDS = vector3(-938.89, -1320.24, 49.22    ), DETECTIONDISTANCE = 3.0, RGB = {138,138,138} },
			  [8]  = { COORDS = vector3(-902.06, -1309.49, 42.43    ), DETECTIONDISTANCE = 3.0, RGB = {138,138,138} },
			  [9]  = { COORDS = vector3(-947.61, -1305.44, 49.09+0.7), DETECTIONDISTANCE = 3.0, RGB = {138,138,138} },
			  [10] = { COORDS = vector3(-973.30, -1333.05, 50.62+0.7), DETECTIONDISTANCE = 3.0, RGB = {138,138,138} },
			  [11] = { COORDS = vector3(-964.46, -1305.18, 49.36+0.7), DETECTIONDISTANCE = 3.0, RGB = {138,138,138} },
			  [12] = { COORDS = vector3(-947.61, -1305.44, 49.09+0.7), DETECTIONDISTANCE = 3.0, RGB = {138,138,138} },
			  [13] = { COORDS = vector3(-972.74, -1319.99, 50.21+0.7), DETECTIONDISTANCE = 3.0, RGB = {138,138,138} },
			  [14] = { COORDS = vector3(-962.64, -1338.97, 49.72+0.7), DETECTIONDISTANCE = 3.0, RGB = {138,138,138} },			  
			  },
			  
			  ---------------------------------
			  ---------------------------------
			  LUNGING_START_PLAYER_COORDS       = vector4(-1012.18, -1328.54, 58.00, -11.05),
			  LUNGING_OBSTACLES_ENABLED         = false, 
			  LUNGING_OBSTACLES         		= { 
			  [1]  = {ENABLED = true, MODEL = "MP001_P_MP_JUMP_HAYBALESHORT01", COORDS = vector4(-962.64, -1338.97, 49.72, 87.99 ) },      
			  },			  
 

}, 
	
-- SAINT DENIS 
[2] = { 
			  ENABLED                   = true,
			  TYPE                      = {ONMOUNT = true, LEADING = true, LUNGING = true},	  	  
			  PLAYER_INSTANCE           = false, 							 
			  PLAYERLOCK                = false,
			  PLAYER_LIST               = {
			  [1] = {TRAINING_ACCESS = true, IDENTIFIER = "OTHER_PLAYERS", CHARID = "OTHER_PLAYERS", XPGIVEN = {ONMOUNT = 30, LEADING = 30, LUNGING = 10}, COUNTDOWN = {ONMOUNT = 45, LEADING = 120, LUNGING = 60}},  
 			  },	
			  JOBLOCKED                 = true,
			  JOB_LIST                  = {
			  [1] = {TRAINING_ACCESS = true, LABEL = "OTHER_JOBS",  XPGIVEN = {ONMOUNT = 30, LEADING = 30, LUNGING = 10}, COUNTDOWN = {ONMOUNT = 45, LEADING = 120, LUNGING = 60}},  
 			  },			  
			  DEFAULT_XP	            = {ONMOUNT = 30, LEADING = 30 , LUNGING = 10},	
			  DEFAULT_COUNTDOWN	        = {ONMOUNT = 45, LEADING = 120, LUNGING = 60},
			  BLIPENABLED 				= true,
			  BLIPSPRITE      			= -1327110633,
			  BLIPNAME        		    = "HORSE TRAINING",	
			  BLIPCOORDS                = vector3(2563.87, -789.95, 42.36), 	
			  PROMPTNAME                = "SAINT DENIS STABLES",			  
			  PROMPTCOORDS              = vector3(2563.87, -789.95, 42.36), 
			  PROMPTDISTANCE            = 5.0,
			  MUSICENABLED              = true,
			  MUSICUSED                 = "BOU1_START",		
			  ---------------------------------
			  -- FOR ON MOUNT AND LEADING ONLY ! 
			  ---------------------------------			  
			  OBSTACLES_ENABLED         = true,  			  
			  OBSTACLES         		= { 
			  [1]  = {ENABLED = true, MODEL = "P_BARREL03X", COORDS = vector4(2563.04, -801.44, 41.37, 0.0) },   
			  [2]  = {ENABLED = true, MODEL = "P_BARREL03X", COORDS = vector4(2551.27, -808.40, 41.37, 0.0) },   
			  [3]  = {ENABLED = true, MODEL = "P_BARREL03X", COORDS = vector4(2561.09, -820.31, 41.35, 0.0) },   
			  [4]  = {ENABLED = true, MODEL = "P_BARREL03X", COORDS = vector4(2564.14, -843.82, 41.38, 0.0) },   
			  [5]  = {ENABLED = true, MODEL = "P_BARREL03X", COORDS = vector4(2573.92, -842.46, 41.25, 0.0) },   
			  [6]  = {ENABLED = true, MODEL = "P_BARREL03X", COORDS = vector4(2573.92, -842.46, 41.25, 0.0) },   
			  [7]  = {ENABLED = true, MODEL = "P_BARREL03X", COORDS = vector4(2573.92, -842.46, 41.25, 0.0) },   
			  [8]  = {ENABLED = true, MODEL = "P_BARREL03X", COORDS = vector4(2573.92, -842.46, 41.25, 0.0) },   
			  [9]  = {ENABLED = true, MODEL = "P_BARREL03X", COORDS = vector4(2573.92, -842.46, 41.25, 0.0) },   
   
			  },
			  CUTSCENE 						= true, 				  
			  CAMERACUTSCENE         	    = { 
			  [1] = {DELAY = 2000, CAMERACOORDS = {2548.37, -759.37, 46.38, -3.26, 0.00, -155.97, 50.00}, },
			  [2] = {DELAY = 2000, CAMERACOORDS = {2577.15, -843.31, 42.04, -0.29, 0.00,  48.56 , 50.00}, },
			  [3] = {DELAY = 2000, CAMERACOORDS = {2561.76, -803.26, 42.41,  0.99, 0.00, -5.61  , 50.00}, },
			  },

			  STARTPLAYERCOORDS         = vector4(2561.641845703125, -789.8933715820312, 42.29311752319336, -161.0),
			  CHECKPOINTS               = {
			  [1]  = { COORDS = vector3(2565.18, -800.85, 41.37), DETECTIONDISTANCE = 3.0 , RGB = {138,138,138} },
			  [2]  = { COORDS = vector3(2556.93, -805.10, 41.37), DETECTIONDISTANCE = 3.0 , RGB = {138,138,138} },
			  [3]  = { COORDS = vector3(2549.03, -809.74, 41.37), DETECTIONDISTANCE = 3.0 , RGB = {138,138,138} },
			  [4]  = { COORDS = vector3(2562.91, -821.65, 41.37), DETECTIONDISTANCE = 3.0 , RGB = {138,138,138} },
			  [5]  = { COORDS = vector3(2559.35, -818.44, 41.37), DETECTIONDISTANCE = 3.0 , RGB = {138,138,138} },
			  [6]  = { COORDS = vector3(2575.78, -841.97, 41.25), DETECTIONDISTANCE = 3.0 , RGB = {138,138,138} },
			  [7]  = { COORDS = vector3(2569.22, -840.36, 41.36), DETECTIONDISTANCE = 3.0 , RGB = {138,138,138} },
			  [8]  = { COORDS = vector3(2562.41, -845.39, 41.37), DETECTIONDISTANCE = 3.0 , RGB = {138,138,138} },
			  [9]  = { COORDS = vector3(2562.98, -819.76, 41.37), DETECTIONDISTANCE = 3.0 , RGB = {138,138,138} },
			  [10] = { COORDS = vector3(2558.75, -821.64, 41.37), DETECTIONDISTANCE = 3.0 , RGB = {138,138,138} },
			  [11] = { COORDS = vector3(2562.93, -799.57, 41.37), DETECTIONDISTANCE = 3.0 , RGB = {138,138,138} },
			  [12] = { COORDS = vector3(2552.63, -810.44, 41.37), DETECTIONDISTANCE = 3.0 , RGB = {138,138,138} },
			  [13] = { COORDS = vector3(2557.90, -805.29, 41.37), DETECTIONDISTANCE = 3.0 , RGB = {138,138,138} },
			  [14] = { COORDS = vector3(2568.99, -842.44, 41.39), DETECTIONDISTANCE = 3.0 , RGB = {138,138,138} },			  
			  },
			  ---------------------------------
			  ---------------------------------
			  LUNGING_START_PLAYER_COORDS       = vector4(2559.190673828125, -821.290771484375, 42.36025619506836, -156.0),
			  LUNGING_OBSTACLES_ENABLED         = false, 				  
			  LUNGING_OBSTACLES         		= { 
			  [1]  = {ENABLED = true, MODEL = "P_BARREL03X", COORDS = vector4(2563.04, -801.44, 41.37, 0.0) },      
			  },			  
  
	}, 

 
-- TUMBLEWEED
[3] = { 
			  ENABLED                   = true,
			  TYPE                      = {ONMOUNT = true, LEADING = true, LUNGING = true},	 
			  PLAYER_INSTANCE           = false, 							 
			  PLAYERLOCK                = false,
			  PLAYER_LIST               = {
			  [1] = {TRAINING_ACCESS = true, IDENTIFIER = "OTHER_PLAYERS", CHARID = "OTHER_PLAYERS", XPGIVEN = {ONMOUNT = 30, LEADING = 30, LUNGING = 10}, COUNTDOWN = {ONMOUNT = 45, LEADING = 120, LUNGING = 60}},  
 			  },	
			  JOBLOCKED                 = true,
			  JOB_LIST                  = {
			  [1] = {TRAINING_ACCESS = true, LABEL = "OTHER_JOBS",  XPGIVEN = {ONMOUNT = 30, LEADING = 30, LUNGING = 10}, COUNTDOWN = {ONMOUNT = 45, LEADING = 120, LUNGING = 60}},  
 			  },			  
			  DEFAULT_XP	            = {ONMOUNT = 30, LEADING = 30 , LUNGING = 10},	
			  DEFAULT_COUNTDOWN	        = {ONMOUNT = 45, LEADING = 120, LUNGING = 60},	
			  BLIPENABLED 				= true,
			  BLIPSPRITE      		    = -1327110633,
			  BLIPNAME        		    = "HORSE TRAINING",	  
			  BLIPCOORDS                = vector3(-4817.98, -2681.13, -13.09),
			  PROMPTNAME                = "TUMBLEWEED STABLES", 			  
			  PROMPTCOORDS              = vector3(-4817.98, -2681.13, -13.09), 
			  PROMPTDISTANCE            = 5.0,
			  MUSICENABLED              = true,
			  MUSICUSED                 = "BOU1_START",	
			  ---------------------------------
			  -- FOR ON MOUNT AND LEADING ONLY ! 
			  ---------------------------------			  
			  OBSTACLES_ENABLED         = true,  			  
			  OBSTACLES         		= { 
			  [1]  = {ENABLED = true, MODEL = "P_HAYBALESTACK01X", COORDS = vector4(-4801.72, -2682.67, -13.56,  0.0  ) },   
			  [2]  = {ENABLED = true, MODEL = "P_HAYBALESTACK01X", COORDS = vector4(-4793.88, -2683.80, -13.80, -19.50) },   
			  [3]  = {ENABLED = true, MODEL = "P_HAYBALESTACK01X", COORDS = vector4(-4786.26, -2685.85, -13.82, -19.0 ) },   
			  [4]  = {ENABLED = true, MODEL = "P_HAYBALESTACK01X", COORDS = vector4(-4790.59, -2675.63, -13.26, -15.0 ) },   
			  [5]  = {ENABLED = true, MODEL = "P_HAYBALESTACK01X", COORDS = vector4(-4795.07, -2694.42, -14.42,  0.0  ) },   
			  },
			  CUTSCENE 						= true, 				  
			  CAMERACUTSCENE         	    = { 
			  [1] = {DELAY = 2000, CAMERACOORDS = {-4753.97, -2738.65, -10.20, -2.24, 0.00, 43.20, 50.00}, },
			  [2] = {DELAY = 2000, CAMERACOORDS = {-4763.77, -2691.91, -11.95, -1.49, 0.00, 75.26, 50.00}, },
			  [3] = {DELAY = 2000, CAMERACOORDS = {-4814.03, -2682.54, -11.21, -1.54, 0.00, 70.69, 50.00}, },
			  },

			  STARTPLAYERCOORDS         = vector4(-4818.01, -2681.23, -12.19, -97.0),
			  CHECKPOINTS               = {
			  [1]  = { COORDS = vector3(-4794.92, -2696.57, -14.69 ), DETECTIONDISTANCE = 3.0 , RGB = {138,138,138}},
			  [2]  = { COORDS = vector3(-4776.79, -2685.49, -13.87 ), DETECTIONDISTANCE = 3.0 , RGB = {138,138,138}},
			  [3]  = { COORDS = vector3(-4790.39, -2673.62, -13.06 ), DETECTIONDISTANCE = 3.0 , RGB = {138,138,138}},
			  [4]  = { COORDS = vector3(-4798.60, -2683.21, -13.67 ), DETECTIONDISTANCE = 3.0 , RGB = {138,138,138}},
			  [5]  = { COORDS = vector3(-4805.28, -2682.76, -13.50 ), DETECTIONDISTANCE = 3.0 , RGB = {138,138,138}},
			  [6]  = { COORDS = vector3(-4790.78, -2693.25, -14.44 ), DETECTIONDISTANCE = 3.0 , RGB = {138,138,138}},
			  [7]  = { COORDS = vector3(-4799.26, -2694.66, -14.28 ), DETECTIONDISTANCE = 3.0 , RGB = {138,138,138}},
			  [8]  = { COORDS = vector3(-4786.39, -2677.04, -13.21 ), DETECTIONDISTANCE = 3.0 , RGB = {138,138,138}},
			  [9]  = { COORDS = vector3(-4795.14, -2675.02, -13.21 ), DETECTIONDISTANCE = 3.0 , RGB = {138,138,138}},
			  [10] = { COORDS = vector3(-4781.30, -2684.79, -13.21 ), DETECTIONDISTANCE = 3.0 , RGB = {138,138,138}},
			  [11] = { COORDS = vector3(-4790.21, -2684.84, -13.89 ), DETECTIONDISTANCE = 3.0 , RGB = {138,138,138}},
			  [12] = { COORDS = vector3(-4797.60, -2683.14, -13.69 ), DETECTIONDISTANCE = 3.0 , RGB = {138,138,138}},
			  [13] = { COORDS = vector3(-4808.70, -2682.90, -13.35 ), DETECTIONDISTANCE = 3.0 , RGB = {138,138,138}},
			  [14] = { COORDS = vector3(-4822.48, -2679.18, -13.17 ), DETECTIONDISTANCE = 3.0 , RGB = {138,138,138}},			  
			  },
			  ---------------------------------
			  ---------------------------------
			  LUNGING_START_PLAYER_COORDS   = vector4(-5541.1513671875, -3038.813232421875, -1.26071965694427, -130.0),
			  LUNGING_OBSTACLES_ENABLED     = false, 			  
			  LUNGING_OBSTACLES             = { 
			  [1]  = {ENABLED = true, MODEL = "P_HAYBALESTACK01X", COORDS = vector4(-4801.72, -2682.67, -13.56,  0.0  ) },        
			  },			  

		}, 
 

-- PRONGHORN RANCH
      [4] = {
			  ENABLED                   = true,
			  TYPE                      = {ONMOUNT = true, LEADING = true, LUNGING = true},   
			  PLAYER_INSTANCE           = false, 							 
			  PLAYERLOCK                = false,
			  PLAYER_LIST               = {
			  [1] = {TRAINING_ACCESS = true, IDENTIFIER = "OTHER_PLAYERS", CHARID = "OTHER_PLAYERS", XPGIVEN = {ONMOUNT = 30, LEADING = 30, LUNGING = 10}, COUNTDOWN = {ONMOUNT = 45, LEADING = 120, LUNGING = 60}},  
 			  },	
			  JOBLOCKED                 = true,
			  JOB_LIST                  = {
			  [1] = {TRAINING_ACCESS = true, LABEL = "OTHER_JOBS",  XPGIVEN = {ONMOUNT = 30, LEADING = 30, LUNGING = 10}, COUNTDOWN = {ONMOUNT = 45, LEADING = 120, LUNGING = 60}},  
 			  },			  
			  DEFAULT_XP	            = {ONMOUNT = 30, LEADING = 30 , LUNGING = 10},	
			  DEFAULT_COUNTDOWN	        = {ONMOUNT = 45, LEADING = 120, LUNGING = 60},	
			  BLIPENABLED 				= true,
			  BLIPSPRITE      			= -1327110633,
			  BLIPNAME        			= "HORSE TRAINING",	  
			  BLIPCOORDS                = vector3(-2537.83, 461.15,  144.45), 
			  PROMPTNAME                = "PRONGHORN RANCH",			  
			  PROMPTCOORDS              = vector3(-2537.83, 461.15,  144.45), 
			  PROMPTDISTANCE            = 5.0,
			  MUSICENABLED              = true,
			  MUSICUSED                 = "BOU1_START",	
			  ---------------------------------
			  -- FOR ON MOUNT AND LEADING ONLY ! 
			  ---------------------------------			  
			  OBSTACLES_ENABLED         = true,  			  
			  OBSTACLES         		= { 
			  [1]   = {ENABLED = true, MODEL = "MP001_P_MP_JUMP_FENCESHORT02", COORDS = vector4(-2561.05, 454.33, 144.46,  -7.99  ) },   
			  [2]   = {ENABLED = true, MODEL = "MP001_P_MP_JUMP_FENCESHORT02", COORDS = vector4(-2562.75, 431.69, 146.11,  -15.99 ) },   
			  [3]   = {ENABLED = true, MODEL = "MP001_P_MP_JUMP_FENCESHORT02", COORDS = vector4(-2576.14, 434.34, 146.19,  -15.99 ) },   
			  [4]   = {ENABLED = true, MODEL = "MP001_P_MP_JUMP_FENCESHORT02", COORDS = vector4(-2574.84, 453.35, 144.81,  -7.99  ) },   
			  [5]   = {ENABLED = true, MODEL = "P_BARREL02X", 				   COORDS = vector4(-2568.37, 446.99, 144.97,  0.0    ) },   
			  [6]   = {ENABLED = true, MODEL = "P_BARREL02X", 				   COORDS = vector4(-2568.40, 443.81, 145.23,  0.0    ) },   
			  [7]   = {ENABLED = true, MODEL = "P_BARREL02X", 				   COORDS = vector4(-2568.49, 440.27, 145.54,  0.0    ) },      
			  },                                                                                                                  
			  CUTSCENE 						= true, 				  
			  CAMERACUTSCENE         	    = { 
			  [1] = {DELAY = 2000, CAMERACOORDS = {-2570.45,  392.03, 152.67, -3.32, 0.00, -38.67 , 50.00}, },
			  [2] = {DELAY = 2000, CAMERACOORDS = {-2548.01,  482.26, 145.17, 1.84 , 0.00, 176.77 , 50.00}, },
			  [3] = {DELAY = 2000, CAMERACOORDS = {-2547.79,  469.42, 144.66, 4.48 , 0.00, -146.02, 50.00}, },
			  },

			  STARTPLAYERCOORDS         = vector4(-2545.42, 466.04, 143.99, 29.0),
			  CHECKPOINTS               = {
			  [1]  = { COORDS = vector3(-2561.05, 454.33, 144.46), DETECTIONDISTANCE = 3.0, RGB = {138,138,138} },
			  [2]  = { COORDS = vector3(-2562.75, 431.69, 146.11), DETECTIONDISTANCE = 3.0, RGB = {138,138,138} },
			  [3]  = { COORDS = vector3(-2576.14, 434.34, 146.19), DETECTIONDISTANCE = 3.0, RGB = {138,138,138} },
			  [4]  = { COORDS = vector3(-2574.84, 453.35, 144.81), DETECTIONDISTANCE = 3.0, RGB = {138,138,138} },
			  [5]  = { COORDS = vector3(-2568.88, 437.33, 145.79), DETECTIONDISTANCE = 3.0, RGB = {138,138,138} },
			  [6]  = { COORDS = vector3(-2568.36, 442.08, 145.38), DETECTIONDISTANCE = 3.0, RGB = {138,138,138} },
			  [7]  = { COORDS = vector3(-2568.25, 445.42, 145.09), DETECTIONDISTANCE = 3.0, RGB = {138,138,138} },
			  [8]  = { COORDS = vector3(-2568.25, 448.55, 144.85), DETECTIONDISTANCE = 3.0, RGB = {138,138,138} },
			  [9]  = { COORDS = vector3(-2568.25, 445.49, 145.09), DETECTIONDISTANCE = 3.0, RGB = {138,138,138} },
			  [10] = { COORDS = vector3(-2568.32, 442.02, 145.38), DETECTIONDISTANCE = 3.0, RGB = {138,138,138} },
			  [11] = { COORDS = vector3(-2568.44, 438.37, 145.70), DETECTIONDISTANCE = 3.0, RGB = {138,138,138} },
			  [12] = { COORDS = vector3(-2562.75, 431.69, 146.11), DETECTIONDISTANCE = 3.0, RGB = {138,138,138} },
			  [13] = { COORDS = vector3(-2574.84, 453.35, 144.81), DETECTIONDISTANCE = 3.0, RGB = {138,138,138} },
			  [14] = { COORDS = vector3(-2576.14, 434.34, 146.19), DETECTIONDISTANCE = 3.0, RGB = {138,138,138} },			  
			  },
			  ---------------------------------
			  ---------------------------------		
			  LUNGING_START_PLAYER_COORDS   = vector4(-2539.9375, 461.6824035644531, 144.37184143066406, 153.0),			  
			  LUNGING_OBSTACLES_ENABLED     = false, 			  
			  LUNGING_OBSTACLES             = { 
			  [1]  = {ENABLED = true, MODEL = "P_HAYBALESTACK01X", COORDS = vector4(-4801.72, -2682.67, -13.56,  0.0  ) },        
			  },				  
	}, 

-- DEWBERRY CREEK
      [5] = { 
			  ENABLED                   = true,
			  TYPE                      = {ONMOUNT = true, LEADING = true, LUNGING = true},	   
			  PLAYER_INSTANCE           = false, 						 
			  PLAYERLOCK                = false,
			  PLAYER_LIST               = {
			  [1] = {TRAINING_ACCESS = true, IDENTIFIER = "OTHER_PLAYERS", CHARID = "OTHER_PLAYERS", XPGIVEN = {ONMOUNT = 30, LEADING = 30, LUNGING = 10}, COUNTDOWN = {ONMOUNT = 45, LEADING = 120, LUNGING = 60}},  
 			  },	
			  JOBLOCKED                 = true,
			  JOB_LIST                  = {
			  [1] = {TRAINING_ACCESS = true, LABEL = "OTHER_JOBS",  XPGIVEN = {ONMOUNT = 30, LEADING = 30, LUNGING = 10}, COUNTDOWN = {ONMOUNT = 45, LEADING = 120, LUNGING = 60}},  
 			  },			  
			  DEFAULT_XP	            = {ONMOUNT = 30, LEADING = 30 , LUNGING = 10},	
			  DEFAULT_COUNTDOWN	        = {ONMOUNT = 45, LEADING = 120, LUNGING = 60},
			  BLIPENABLED 				= true,
			  BLIPSPRITE      		    = -1327110633,
			  BLIPNAME        		    = "HORSE TRAINING",	 
			  BLIPCOORDS                = vector3(1202.10, -210.11, 100.25), 
			  PROMPTNAME                = "DEWBERRY CREEK STABLES",			  
			  PROMPTCOORDS              = vector3(1202.10, -210.11, 100.25), 
			  PROMPTDISTANCE            = 5.0, 
			  MUSICENABLED              = true,
			  MUSICUSED                 = "BOU1_START",	
			  ---------------------------------
			  -- FOR ON MOUNT AND LEADING ONLY ! 
			  ---------------------------------			  
			  OBSTACLES_ENABLED         = true, 			  
			  OBSTACLES         		= { 
			  [1]  = {ENABLED = true, MODEL = "MP001_P_JUMPHURDLES01X", COORDS = vector4(1191.76, -226.36, 98.16 , -69.0) },   
			  [2]  = {ENABLED = true, MODEL = "MP001_P_JUMPHURDLES01X", COORDS = vector4(1181.07, -210.48, 99.41 , -51.0) },   
			  [3]  = {ENABLED = true, MODEL = "MP001_P_JUMPHURDLES01X", COORDS = vector4(1189.99, -202.61, 100.30, -57.0) },   
			  [4]  = {ENABLED = true, MODEL = "MP001_P_JUMPHURDLES01X", COORDS = vector4(1206.91, -223.28, 98.41 , -72.0) },   
			  [5]  = {ENABLED = true, MODEL = "MP001_P_JUMPHURDLES01X", COORDS = vector4(1193.11, -174.21, 99.19 , -74.0) },   
			  [5]  = {ENABLED = true, MODEL = "MP001_P_JUMPHURDLES01X", COORDS = vector4(1203.00, -233.10, 98.21 , -66.0) },   
			  },
			  CUTSCENE 						= true, 				  
			  CAMERACUTSCENE         	    = { 
			  [1] = {DELAY = 2000, CAMERACOORDS = {1191.58, -188.25,  102.37, -2.46,   0.00, -180.00,  50.00}, },
			  [2] = {DELAY = 2000, CAMERACOORDS = {1224.63, -234.75,  106.87, -14.05,  0.00, 46.33  ,  50.00}, },
			  [3] = {DELAY = 2000, CAMERACOORDS = {1183.75, -220.70,  101.37, -5.30,   0.00, 112.29 ,  50.00}, },
			  },

			  STARTPLAYERCOORDS         = vector4( 1173.39, -224.70, 98.67,-65.0),
			  CHECKPOINTS               = {
			  [1]  = { COORDS = vector3(1181.06, -210.47,  99.410 ), DETECTIONDISTANCE = 3.0, RGB = {138,138,138} },
			  [2]  = { COORDS = vector3(1189.98, -202.61,  100.30 ), DETECTIONDISTANCE = 3.0, RGB = {138,138,138} },
			  [3]  = { COORDS = vector3(1206.91, -223.27,  98.410 ), DETECTIONDISTANCE = 3.0, RGB = {138,138,138} },
			  [4]  = { COORDS = vector3(1191.76, -226.36,  98.160 ), DETECTIONDISTANCE = 3.0, RGB = {138,138,138} },
			  [5]  = { COORDS = vector3(1181.06, -210.47,  99.410 ), DETECTIONDISTANCE = 3.0, RGB = {138,138,138} },
			  [6]  = { COORDS = vector3(1189.98, -202.61,  100.30 ), DETECTIONDISTANCE = 3.0, RGB = {138,138,138} },
			  [7]  = { COORDS = vector3(1212.47, -207.13,  100.17 ), DETECTIONDISTANCE = 3.0, RGB = {138,138,138} },
			  [8]  = { COORDS = vector3(1197.62, -201.51,  100.55 ), DETECTIONDISTANCE = 3.0, RGB = {138,138,138} },
			  [9]  = { COORDS = vector3(1193.10, -174.21,  99.190 ), DETECTIONDISTANCE = 3.0, RGB = {138,138,138} },
			  [10] = { COORDS = vector3(1191.17, -194.11,  100.08 ), DETECTIONDISTANCE = 3.0, RGB = {138,138,138} },
			  [11] = { COORDS = vector3(1189.98, -202.61,  100.30 ), DETECTIONDISTANCE = 3.0, RGB = {138,138,138} },
			  [12] = { COORDS = vector3(1181.06, -210.47,  99.410 ), DETECTIONDISTANCE = 3.0, RGB = {138,138,138} },
			  [13] = { COORDS = vector3(1213.25, -229.19,  98.506 ), DETECTIONDISTANCE = 3.0, RGB = {138,138,138} },
			  [14] = { COORDS = vector3(1203.00, -233.10,  98.209 ), DETECTIONDISTANCE = 3.0, RGB = {138,138,138} },			  
			  },
			  ---------------------------------
			  ---------------------------------
			  LUNGING_START_PLAYER_COORDS   = vector4(1208.6173095703125, -214.50363159179688, 100.2734375, -5.0),		  			  
			  LUNGING_OBSTACLES_ENABLED     = false, 			  
			  LUNGING_OBSTACLES         	= { 
			  [1]  = {ENABLED = true, MODEL = "MP001_P_JUMPHURDLES01X", COORDS = vector4(1191.76, -226.36, 98.16 , -69.0) },       
			  },
		}, 	  
 
-- MCFARLANE RANCH 
      [6] = { 
			  ENABLED                   = true,
			  TYPE                      = {ONMOUNT = true, LEADING = true, LUNGING = true},	 	  
			  PLAYER_INSTANCE           = false, 						 
			  PLAYERLOCK                = false,
			  PLAYER_LIST               = {
			  [1] = {TRAINING_ACCESS = true, IDENTIFIER = "OTHER_PLAYERS", CHARID = "OTHER_PLAYERS", XPGIVEN = {ONMOUNT = 30, LEADING = 30, LUNGING = 10}, COUNTDOWN = {ONMOUNT = 45, LEADING = 120, LUNGING = 60}},  
 			  },	
			  JOBLOCKED                 = true,
			  JOB_LIST                  = {
			  [1] = {TRAINING_ACCESS = true, LABEL = "OTHER_JOBS",  XPGIVEN = {ONMOUNT = 30, LEADING = 30, LUNGING = 10}, COUNTDOWN = {ONMOUNT = 45, LEADING = 120, LUNGING = 60}},  
 			  },			  
			  DEFAULT_XP	            = {ONMOUNT = 30, LEADING = 30 , LUNGING = 10},	
			  DEFAULT_COUNTDOWN	        = {ONMOUNT = 45, LEADING = 120, LUNGING = 60},
			  BLIPENABLED 				= true,
			  BLIPSPRITE      			= -1327110633,
			  BLIPNAME        		    = "HORSE TRAINING",	  
			  BLIPCOORDS                = vector3(-2415.03, -2337.38, 61.20),	
			  PROMPTNAME                = "MCFARLANE RANCH STABLES",			  
			  PROMPTCOORDS              = vector3(-2415.03, -2337.38, 61.20), 
			  PROMPTDISTANCE            = 5.0,
			  MUSICENABLED              = true,
			  MUSICUSED                 = "BOU1_START",	
			  ---------------------------------
			  -- FOR ON MOUNT AND LEADING ONLY ! 
			  ---------------------------------			  
			  OBSTACLES_ENABLED         = true,  			  
			  OBSTACLES         		= { 
			  [1]   = {ENABLED = true, MODEL = "MP001_P_MP_JUMP_SACKSHORT01", 		COORDS = vector4(-2440.34, -2348.53, 60.18,  33.9   ) },   
			  [2]   = {ENABLED = true, MODEL = "MP001_P_MP_JUMP_SACKSHORT01", 		COORDS = vector4(-2438.98, -2350.55, 60.18,  -145.0 ) },   
			  [3]   = {ENABLED = true, MODEL = "P_BARREL01AX", 						COORDS = vector4(-2442.60, -2351.74, 60.17,  0.0    ) },   
			  [4]   = {ENABLED = true, MODEL = "P_BARREL01AX", 						COORDS = vector4(-2445.31, -2353.76, 60.17,  0.0    ) },   
			  [5]   = {ENABLED = true, MODEL = "P_BARREL01AX", 						COORDS = vector4(-2448.62, -2356.21, 60.17,  0.0    ) },   
			  [6]   = {ENABLED = true, MODEL = "MP001_P_MP_JUMP_HAYBALESHORT01", 	COORDS = vector4(-2463.06, -2365.89, 60.17,  -39.99 ) },   
			  [7]   = {ENABLED = true, MODEL = "MP001_P_MP_JUMP_HAYBALESHORT01", 	COORDS = vector4(-2466.49, -2382.47, 60.17,  14.0   ) },   
			  [8]   = {ENABLED = true, MODEL = "MP001_P_MP_JUMP_HAYBALESHORT01", 	COORDS = vector4(-2448.23, -2394.04, 60.17,  -74.99 ) },   
			  [9]   = {ENABLED = true, MODEL = "P_BARREL01AX", 						COORDS = vector4(-2429.01, -2366.63, 60.17,  0.0    ) },   
 			  },
			  CUTSCENE 						= true, 				  
			  CAMERACUTSCENE         	    = { 
			  [1] = {DELAY = 2000, CAMERACOORDS = {-2442.67, -2409.51, 62.04, -1.99,   0.00,  -15.80 , 50.00}, },
			  [2] = {DELAY = 2000, CAMERACOORDS = {-2429.34, -2369.07, 92.44, -88.60,  0.00,  30.45  , 50.00}, },
			  [3] = {DELAY = 2000, CAMERACOORDS = {-2420.84, -2336.14, 62.94, -7.12,   0.00,  -115.23, 50.00}, },
			  },

			  STARTPLAYERCOORDS         = vector4(-2414.09, -2339.14, 60.58, 118.20),
			  CHECKPOINTS               = {
			  [1]  = { COORDS = vector3(-2441.48, -2350.88, 60.17     ), DETECTIONDISTANCE = 3.0 , RGB = {138,138,138}},
			  [2]  = { COORDS = vector3(-2444.01, -2352.77, 60.17     ), DETECTIONDISTANCE = 3.0 , RGB = {138,138,138}},
			  [3]  = { COORDS = vector3(-2446.95, -2354.93, 60.17     ), DETECTIONDISTANCE = 3.0 , RGB = {138,138,138}},
			  [4]  = { COORDS = vector3(-2439.43, -2349.40, 60.17     ), DETECTIONDISTANCE = 3.0 , RGB = {138,138,138}},
			  [5]  = { COORDS = vector3(-2463.06, -2365.89, 60.21+0.5 ), DETECTIONDISTANCE = 3.0 , RGB = {138,138,138}},
			  [6]  = { COORDS = vector3(-2466.49, -2382.47, 60.25+0.5 ), DETECTIONDISTANCE = 3.0 , RGB = {138,138,138}},
			  [7]  = { COORDS = vector3(-2448.23, -2394.04, 60.25+0.5 ), DETECTIONDISTANCE = 3.0 , RGB = {138,138,138}},
			  [8]  = { COORDS = vector3(-2436.31, -2371.18, 60.17     ), DETECTIONDISTANCE = 3.0 , RGB = {138,138,138}},
			  [9]  = { COORDS = vector3(-2436.95, -2368.62, 60.17     ), DETECTIONDISTANCE = 3.0 , RGB = {138,138,138}},
			  [10] = { COORDS = vector3(-2424.47, -2363.71, 60.17     ), DETECTIONDISTANCE = 3.0 , RGB = {138,138,138}},
			  [11] = { COORDS = vector3(-2431.87, -2371.35, 60.17     ), DETECTIONDISTANCE = 3.0 , RGB = {138,138,138}},
			  [12] = { COORDS = vector3(-2448.23, -2394.04, 60.25+0.5 ), DETECTIONDISTANCE = 3.0 , RGB = {138,138,138}},
			  [13] = { COORDS = vector3(-2466.49, -2382.47, 60.25+0.5 ), DETECTIONDISTANCE = 3.0 , RGB = {138,138,138}},
			  [14] = { COORDS = vector3(-2463.06, -2365.89, 60.21+0.5 ), DETECTIONDISTANCE = 3.0 , RGB = {138,138,138}},			  
			  },
			  ---------------------------------
			  ---------------------------------		
			  LUNGING_START_PLAYER_COORDS    = vector4(-2430.090087890625, -2365.204345703125, 61.17550277709961, -69.0),  			  			  
			  LUNGING_OBSTACLES_ENABLED      = false, 			  
			  LUNGING_OBSTACLES         	 = { 
			  [1]   = {ENABLED = true, MODEL = "MP001_P_MP_JUMP_SACKSHORT01", 		COORDS = vector4(-2440.34, -2348.53, 60.18,  33.9   ) },       
			  },	  		  
}, 	

-- STRAWBERRY
      [7] = { 
			  ENABLED                   = true,
			  TYPE                      = {ONMOUNT = true, LEADING = true, LUNGING = true},   
			  PLAYER_INSTANCE           = true, 							 
			  PLAYERLOCK                = false,
			  PLAYER_LIST               = {
			  [1] = {TRAINING_ACCESS = true, IDENTIFIER = "OTHER_PLAYERS", CHARID = "OTHER_PLAYERS", XPGIVEN = {ONMOUNT = 30, LEADING = 30, LUNGING = 10}, COUNTDOWN = {ONMOUNT = 45, LEADING = 120, LUNGING = 60}},  
 			  },	
			  JOBLOCKED                 = true,
			  JOB_LIST                  = {
			  [1] = {TRAINING_ACCESS = true, LABEL = "OTHER_JOBS",  XPGIVEN = {ONMOUNT = 30, LEADING = 30, LUNGING = 10}, COUNTDOWN = {ONMOUNT = 45, LEADING = 120, LUNGING = 60}},  
 			  },			  
			  DEFAULT_XP	            = {ONMOUNT = 30, LEADING = 30 , LUNGING = 10},	
			  DEFAULT_COUNTDOWN	        = {ONMOUNT = 45, LEADING = 120, LUNGING = 60},
			  BLIPENABLED 				= true,
			  BLIPSPRITE      			= -1327110633,
			  BLIPNAME        		    = "HORSE TRAINING",	  
			  BLIPCOORDS                = vector3(-1800.08, -564.31, 156.0), 
			  PROMPTNAME                = "STRAWBERRY STABLES",			  
			  PROMPTCOORDS              = vector3(-1800.08, -564.31, 156.0), 
			  PROMPTDISTANCE            = 5.0, 
			  MUSICENABLED              = true,
			  MUSICUSED                 = "BOU1_START",		
			  ---------------------------------
			  -- FOR ON MOUNT AND LEADING ONLY ! 
			  ---------------------------------			  
			  OBSTACLES_ENABLED         = true, 			  
			  OBSTACLES         		= { 
			  [1]  = {ENABLED = true, MODEL = "MP001_P_MP_JUMP_HAYBALESHORT01",	COORDS = vector4(-1784.78, -561.57, 154.95, -55.0) },   
			  [2]  = {ENABLED = true, MODEL = "MP001_P_MP_JUMP_HAYBALESHORT01",	COORDS = vector4(-1797.83, -576.84, 154.99, -55.0) },   
			  [3]  = {ENABLED = true, MODEL = "MP001_P_MP_JUMP_HAYBALESHORT01",	COORDS = vector4(-1798.03, -556.62, 155.01, 161.0) },   
			  [4]  = {ENABLED = true, MODEL = "MP001_P_MP_JUMP_HAYBALESHORT01",	COORDS = vector4(-1803.51, -570.85, 154.83, 161.0) },     
 			  },
			  CUTSCENE 						= true, 				  
			  CAMERACUTSCENE         	    = { 
			  [1] = {DELAY = 2000, CAMERACOORDS = {-1814.20, -588.57,  157.48, -3.85, 0.00,  -51.60, 50.00,}, },
			  [2] = {DELAY = 2000, CAMERACOORDS = {-1783.57, -579.92,  156.80, -1.01, 0.00,  12.59 , 50.00,}, },
			  [3] = {DELAY = 2000, CAMERACOORDS = {-1785.86, -549.00,  156.66, 6.64,  0.00,  32.33 , 50.00,}, },
			  },

			  STARTPLAYERCOORDS         = vector4(-1787.85, -546.06, 156.32, -150.0),
			  CHECKPOINTS               = {
			  [1]  = { COORDS = vector3(-1784.78,  -561.57, 155.03+0.5), DETECTIONDISTANCE = 3.0, RGB = {138,138,138}},
			  [2]  = { COORDS = vector3(-1797.82,  -576.84, 154.99+0.5), DETECTIONDISTANCE = 3.0, RGB = {138,138,138}},
			  [3]  = { COORDS = vector3(-1803.51,  -570.84, 154.91+0.5), DETECTIONDISTANCE = 3.0, RGB = {138,138,138}},
			  [4]  = { COORDS = vector3(-1798.03,  -556.61, 155.09+0.5), DETECTIONDISTANCE = 3.0, RGB = {138,138,138}},
			  [5]  = { COORDS = vector3(-1784.78,  -561.57, 155.03+0.5), DETECTIONDISTANCE = 3.0, RGB = {138,138,138}},
			  [6]  = { COORDS = vector3(-1803.51,  -570.84, 154.91+0.5), DETECTIONDISTANCE = 3.0, RGB = {138,138,138}},
			  [7]  = { COORDS = vector3(-1797.82,  -576.84, 154.99+0.5), DETECTIONDISTANCE = 3.0, RGB = {138,138,138}},
			  [8]  = { COORDS = vector3(-1798.03,  -556.61, 155.09+0.5), DETECTIONDISTANCE = 3.0, RGB = {138,138,138}},
			  [9]  = { COORDS = vector3(-1784.78,  -561.57, 155.03+0.5), DETECTIONDISTANCE = 3.0, RGB = {138,138,138}},
			  [10] = { COORDS = vector3(-1797.82,  -576.84, 154.99+0.5), DETECTIONDISTANCE = 3.0, RGB = {138,138,138}},
			  [11] = { COORDS = vector3(-1803.51,  -570.84, 154.91+0.5), DETECTIONDISTANCE = 3.0, RGB = {138,138,138}},
			  [12] = { COORDS = vector3(-1784.78,  -561.57, 155.03+0.5), DETECTIONDISTANCE = 3.0, RGB = {138,138,138}},
			  [13] = { COORDS = vector3(-1798.03,  -556.61, 155.09+0.5), DETECTIONDISTANCE = 3.0, RGB = {138,138,138}},
			  [14] = { COORDS = vector3(-1794.35,  -566.89, 154.99+0.5), DETECTIONDISTANCE = 3.0, RGB = {138,138,138}},			  
			  },
			  ---------------------------------
			  ---------------------------------	
			  LUNGING_START_PLAYER_COORDS   = vector4(-1793.946533203125, -567.7968139648438, 155.98675537109375, 101.0),		  			  			  
			  LUNGING_OBSTACLES_ENABLED     = false, 			  
			  LUNGING_OBSTACLES         	= { 
			  [1]  = {ENABLED = true, MODEL = "MP001_P_MP_JUMP_HAYBALESHORT01",	COORDS = vector4(-1784.78, -561.57, 154.95, -55.0) },     
			  },		  
}, 	
 
-- VALENTINE 
      [8] = { 
			  ENABLED                   = true,
			  TYPE                      = {ONMOUNT = true, LEADING = true, LUNGING = true},   
			  PLAYER_INSTANCE           = true, 							 
			  PLAYERLOCK                = false,
			  PLAYER_LIST               = {
			  [1] = {TRAINING_ACCESS = true, IDENTIFIER = "OTHER_PLAYERS", CHARID = "OTHER_PLAYERS", XPGIVEN = {ONMOUNT = 30, LEADING = 30, LUNGING = 10}, COUNTDOWN = {ONMOUNT = 45, LEADING = 120, LUNGING = 60}},  
 			  },	
			  JOBLOCKED                 = true,
			  JOB_LIST                  = {
			 -- [1] = {TRAINING_ACCESS = true, LABEL = "OTHER_JOBS",  XPGIVEN = {ONMOUNT = 30, LEADING = 30, LUNGING = 10}, COUNTDOWN = {ONMOUNT = 45, LEADING = 120, LUNGING = 60}},  
			  [1] = {TRAINING_ACCESS = true, LABEL = "horsetrainer",  XPGIVEN = {ONMOUNT = 30, LEADING = 30, LUNGING = 10}, COUNTDOWN = {ONMOUNT = 45, LEADING = 120, LUNGING = 60}},  
 			  },			  
			  DEFAULT_XP	            = {ONMOUNT = 30, LEADING = 30 , LUNGING = 10},	
			  DEFAULT_COUNTDOWN	        = {ONMOUNT = 45, LEADING = 120, LUNGING = 60},	
			  BLIPENABLED 				= true,
			  BLIPSPRITE      		    = -1327110633,
			  BLIPNAME        			= "HORSE TRAINING",	
			  BLIPCOORDS                = vector3(-391.262, 778.792, 115.683), 	
			  PROMPTNAME                = "VALENTINE STABLES",			  
			  PROMPTCOORDS              = vector3(-391.262, 778.792, 115.683), 
			  PROMPTDISTANCE            = 5.0, 
			  MUSICENABLED              = true,
			  MUSICUSED                 = "BOU1_START",	
			  ---------------------------------
			  -- FOR ON MOUNT AND LEADING ONLY ! 
			  ---------------------------------			  
			  OBSTACLES_ENABLED         = false,  
			  OBSTACLES         		= { 
			  [1]  = {ENABLED = true, MODEL = "MP001_P_MP_JUMP_HAYBALESHORT01",	COORDS = vector4(0.0, 0.0, 0.0, 0.0) },   
			  [2]  = {ENABLED = true, MODEL = "MP001_P_MP_JUMP_HAYBALESHORT01",	COORDS = vector4(0.0, 0.0, 0.0, 0.0) },   
			  [3]  = {ENABLED = true, MODEL = "MP001_P_MP_JUMP_HAYBALESHORT01",	COORDS = vector4(0.0, 0.0, 0.0, 0.0) },   
			  [4]  = {ENABLED = true, MODEL = "MP001_P_MP_JUMP_HAYBALESHORT01",	COORDS = vector4(0.0, 0.0, 0.0, 0.0) },     
 			  },
			  CUTSCENE 						= false, 				  
			  CAMERACUTSCENE         	    = { 
			  [1] = {DELAY = 2000, CAMERACOORDS = {-377.71, 760.87, 119.49, -8.18, 0.00, 38.32 , 50.00}, },
			  [2] = {DELAY = 2000, CAMERACOORDS = {-397.34, 785.59, 115.52, 11.63, 0.00, -44.38, 50.00}, },
			  [3] = {DELAY = 2000, CAMERACOORDS = {-394.81, 785.98, 116.26, 12.33, 0.00, -1.65 , 50.00}, },
			  },

			  STARTPLAYERCOORDS         = vector4(-391.10, 778.66, 115.70, 99.10),
			  CHECKPOINTS               = {
			  [1]  = { COORDS = vector3(-393.48, 781.64, 114.76), DETECTIONDISTANCE = 3.0, RGB = {250,250,250}},
			  [2]  = { COORDS = vector3(-392.73, 775.66, 114.66), DETECTIONDISTANCE = 3.0, RGB = {250,250,250}},
			  [3]  = { COORDS = vector3(-393.00, 770.35, 114.74), DETECTIONDISTANCE = 3.0, RGB = {250,250,250}},
			  [4]  = { COORDS = vector3(-393.16, 775.18, 114.65), DETECTIONDISTANCE = 2.0, RGB = {250,250,250}},
			  [5]  = { COORDS = vector3(-393.53, 781.15, 114.75), DETECTIONDISTANCE = 3.0, RGB = {250,250,250}},
			  [6]  = { COORDS = vector3(-394.99, 786.48, 114.88), DETECTIONDISTANCE = 3.0, RGB = {250,250,250}},
			  [7]  = { COORDS = vector3(-383.76, 770.28, 115.12), DETECTIONDISTANCE = 3.0, RGB = {250,250,250}},
			  [8]  = { COORDS = vector3(-398.56, 770.01, 114.85), DETECTIONDISTANCE = 3.0, RGB = {250,250,250}},
			  [9]  = { COORDS = vector3(-400.00, 787.26, 114.88), DETECTIONDISTANCE = 3.0, RGB = {250,250,250}},
			  [10] = { COORDS = vector3(-385.71, 788.71, 114.86), DETECTIONDISTANCE = 3.0, RGB = {250,250,250}},
			  [11] = { COORDS = vector3(-394.61, 786.63, 114.88), DETECTIONDISTANCE = 3.0, RGB = {250,250,250}},
			  [12] = { COORDS = vector3(-393.49, 781.73, 114.76), DETECTIONDISTANCE = 3.0, RGB = {250,250,250}},
			  [13] = { COORDS = vector3(-392.69, 775.70, 114.66), DETECTIONDISTANCE = 3.0, RGB = {250,250,250}},
			  [14] = { COORDS = vector3(-392.69, 769.87, 114.76), DETECTIONDISTANCE = 2.0, RGB = {250,250,250}},			  
			  },
			  ---------------------------------
			  ---------------------------------			
			  LUNGING_START_PLAYER_COORDS   = vector4(-393.58, 778.25, 115.70, 91.55),		  			  			  			  
			  LUNGING_OBSTACLES_ENABLED     = false, 			  
			  LUNGING_OBSTACLES             = { 
			  [1]  = {ENABLED = true, MODEL = "MP001_P_MP_JUMP_HAYBALESHORT01",	COORDS = vector4(0.0, 0.0, 0.0, 0.0) },     
			  },			  
  
	}, 	
 
}  
 