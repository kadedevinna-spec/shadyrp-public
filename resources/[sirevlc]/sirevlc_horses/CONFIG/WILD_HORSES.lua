Config = Config or {}
  
---------------------------------------------------
---------------------------------------------------
    -- WILD HORSES ADOPTING AND SELLING --	
---------------------------------------------------
---------------------------------------------------
Config.WILD_HORSES_COOLDOWN 				= false 		-- IF TRUE THE WILD HORSE COOLDOWN WILL BE EFFECTIVE (make sure you have imported sirevlc_wild_horses_cooldown in your database)
Config.WILD_HORSES_COOLDOWN_OFFLINE 		= true 			-- IF TRUE THE WILD HORSE COOLDOWN WILL ALSO PROGRESS WHILE THE PLAYER IS OFFLINE
Config.WILD_HORSES_COOLDOWN_HOUR_OR_MINUTE  = "MINUTE" 		-- CAN BE "HOUR" or "MINUTE"
Config.WILD_HORSES_COOLDOWN_COOLDOWN 		= 5				-- SET THE DESIRED TIME HERE 

Config.WILD_HORSE_BUYERS = {
    [1] = {
		BLIP_ENABLED 	 	= true, 
		BLIP_NAME    	 	= "Wild Horse Buyer",
		BLIP_SPRITE  	 	= 564457427,
        BLIP_POS         	= vector3(722.02, -832.31, 49.93),
        PROMPT_POS       	= vector3(722.02, -832.31, 49.93),
        PROMPT_DIST      	= 4.0,
		ADOPT_MAIN_TITLE 	= "Rhodes Stables",
    },
	
    [2] = {
		BLIP_ENABLED 		= true,
		BLIP_NAME    		= "Wild Horse Buyer",
		BLIP_SPRITE  		= 564457427,		
        BLIP_POS 			= vector3( 1409.90, 273.48, 89.53),
        PROMPT_POS 			= vector3( 1409.90, 273.48, 89.53),
		PROMPT_DIST     	= 4.0,
		ADOPT_MAIN_TITLE    = "Emerald Ranch Stables",
    },
	
    [3] = {
		BLIP_ENABLED     	= true,
		BLIP_NAME   	 	= "Wild Horse Buyer",
		BLIP_SPRITE 	 	= 564457427,		
        BLIP_POS 	   	 	= vector3(-5525.79, -3028.31, -1.97),
        PROMPT_POS 	   	 	= vector3(-5525.79, -3028.31, -1.97),
		PROMPT_DIST      	= 4.0,
		ADOPT_MAIN_TITLE 	= "Tumbleweed Stables",
    },	
	
      [4] = {
  		BLIP_ENABLED     	= true,
  		BLIP_NAME   	 	= "test Horse Buyer",
  		BLIP_SPRITE 	 	= 564457427,		
          BLIP_POS 	   	 	= vector3(-392.47, 826.58, 116.42),
          PROMPT_POS 	   	 	= vector3(-392.47, 826.58, 116.42),
  		PROMPT_DIST      	= 4.0,
  		ADOPT_MAIN_TITLE 	= "test Stables",
      },		
}
 
Config.WILD_HORSES_JOB_LOCKED	 = true 
Config.WILD_HORSES_JOB_LIST	     = {
[1] = {JOB = "OTHER_JOBS", CAN_SELL = true, CAN_ADOPT = true, WILD_HORSE_BUYERS_ACCESS = {1,2,3,4} },
[2] = {JOB = "horsetrainer", CAN_SELL = true, CAN_ADOPT = true, WILD_HORSE_BUYERS_ACCESS = {1,2,3} },
}
 
 Config.WILD_HORSES_PLAYER_LOCKED = false 
 Config.WILD_HORSES_PLAYER_LIST	     = {
 [1] = {IDENTIFIER = "OTHER_PLAYERS", CHARID = "OTHER_PLAYERS", CAN_SELL = true, CAN_ADOPT = true, WILD_HORSE_BUYERS_ACCESS = {1,2,3} },
 [2] = {IDENTIFIER = "steam:99", CHARID = 99, CAN_SELL = true, CAN_ADOPT = true, WILD_HORSE_BUYERS_ACCESS = {1,2,3} },
 } 
 
 
-----------------------------------------------------
      -- WILD HORSES TABLE REFERENCE -- 
----------------------------------------------------- 
-- HORSES REFERENCES WILL BE TAKEN FROM THE MAIN HORSES TABLE. 

Config.WILD_HORSES = {
	[1]   = {MODEL = "a_c_horse_americanpaint_greyovero",                 CATEGORY_INDEX = 15, HORSE_INDEX = 1,    ADOPT_ENABLED = true, SELL_ENABLED = true, ADOPT_DOLLARS = 600.0, ADOPT_GOLD = 0.0, SELL_DOLLARS = 30.0, SELL_GOLD = 0.0	},
	[2]   = {MODEL = "a_c_horse_americanpaint_overo",                     CATEGORY_INDEX = 15, HORSE_INDEX = 2,    ADOPT_ENABLED = true, SELL_ENABLED = true, ADOPT_DOLLARS = 600.0, ADOPT_GOLD = 0.0, SELL_DOLLARS = 30.0, SELL_GOLD = 0.0	},
	[3]   = {MODEL = "a_c_horse_americanpaint_splashedwhite",             CATEGORY_INDEX = 15, HORSE_INDEX = 3,    ADOPT_ENABLED = true, SELL_ENABLED = true, ADOPT_DOLLARS = 600.0, ADOPT_GOLD = 0.0, SELL_DOLLARS = 30.0, SELL_GOLD = 0.0	},
	[4]   = {MODEL = "a_c_horse_americanpaint_tobiano",                   CATEGORY_INDEX = 15, HORSE_INDEX = 4,    ADOPT_ENABLED = true, SELL_ENABLED = true, ADOPT_DOLLARS = 600.0, ADOPT_GOLD = 0.0, SELL_DOLLARS = 30.0, SELL_GOLD = 0.0	},
	[5]   = {MODEL = "a_c_horse_americanstandardbred_black",              CATEGORY_INDEX = 16, HORSE_INDEX = 5,    ADOPT_ENABLED = true, SELL_ENABLED = true, ADOPT_DOLLARS = 600.0, ADOPT_GOLD = 0.0, SELL_DOLLARS = 30.0, SELL_GOLD = 0.0	},
	[6]   = {MODEL = "a_c_horse_americanstandardbred_buckskin",           CATEGORY_INDEX = 16, HORSE_INDEX = 4,    ADOPT_ENABLED = true, SELL_ENABLED = true, ADOPT_DOLLARS = 600.0, ADOPT_GOLD = 0.0, SELL_DOLLARS = 30.0, SELL_GOLD = 0.0	},
	[7]   = {MODEL = "a_c_horse_americanstandardbred_lightbuckskin",      CATEGORY_INDEX = 16, HORSE_INDEX = 3,    ADOPT_ENABLED = true, SELL_ENABLED = true, ADOPT_DOLLARS = 600.0, ADOPT_GOLD = 0.0, SELL_DOLLARS = 30.0, SELL_GOLD = 0.0	},
	[8]   = {MODEL = "a_c_horse_americanstandardbred_palominodapple",     CATEGORY_INDEX = 16, HORSE_INDEX = 2,    ADOPT_ENABLED = true, SELL_ENABLED = true, ADOPT_DOLLARS = 600.0, ADOPT_GOLD = 0.0, SELL_DOLLARS = 30.0, SELL_GOLD = 0.0	},
	[9]   = {MODEL = "a_c_horse_americanstandardbred_silvertailbuckskin", CATEGORY_INDEX = 16, HORSE_INDEX = 1,    ADOPT_ENABLED = true, SELL_ENABLED = true, ADOPT_DOLLARS = 600.0, ADOPT_GOLD = 0.0, SELL_DOLLARS = 30.0, SELL_GOLD = 0.0	},
	[10]  = {MODEL = "a_c_horse_andalusian_darkbay",                      CATEGORY_INDEX = 17, HORSE_INDEX = 3,    ADOPT_ENABLED = true, SELL_ENABLED = true, ADOPT_DOLLARS = 600.0, ADOPT_GOLD = 0.0, SELL_DOLLARS = 30.0, SELL_GOLD = 0.0	},
	[11]  = {MODEL = "a_c_horse_andalusian_perlino",                      CATEGORY_INDEX = 17, HORSE_INDEX = 2,    ADOPT_ENABLED = true, SELL_ENABLED = true, ADOPT_DOLLARS = 600.0, ADOPT_GOLD = 0.0, SELL_DOLLARS = 30.0, SELL_GOLD = 0.0	},
	[12]  = {MODEL = "a_c_horse_andalusian_rosegray",                     CATEGORY_INDEX = 17, HORSE_INDEX = 1,    ADOPT_ENABLED = true, SELL_ENABLED = true, ADOPT_DOLLARS = 600.0, ADOPT_GOLD = 0.0, SELL_DOLLARS = 30.0, SELL_GOLD = 0.0	},
	[13]  = {MODEL = "a_c_horse_appaloosa_blacksnowflake",                CATEGORY_INDEX = 18, HORSE_INDEX = 5,    ADOPT_ENABLED = true, SELL_ENABLED = true, ADOPT_DOLLARS = 600.0, ADOPT_GOLD = 0.0, SELL_DOLLARS = 30.0, SELL_GOLD = 0.0	},
	[14]  = {MODEL = "a_c_horse_appaloosa_blanket",                       CATEGORY_INDEX = 18, HORSE_INDEX = 1,    ADOPT_ENABLED = true, SELL_ENABLED = true, ADOPT_DOLLARS = 600.0, ADOPT_GOLD = 0.0, SELL_DOLLARS = 30.0, SELL_GOLD = 0.0	},
	[15]  = {MODEL = "a_c_horse_appaloosa_brownleopard",                  CATEGORY_INDEX = 18, HORSE_INDEX = 2,    ADOPT_ENABLED = true, SELL_ENABLED = true, ADOPT_DOLLARS = 600.0, ADOPT_GOLD = 0.0, SELL_DOLLARS = 30.0, SELL_GOLD = 0.0	},
	[16]  = {MODEL = "a_c_horse_appaloosa_fewspotted_pc",                 CATEGORY_INDEX = 18, HORSE_INDEX = 6,    ADOPT_ENABLED = true, SELL_ENABLED = true, ADOPT_DOLLARS = 600.0, ADOPT_GOLD = 0.0, SELL_DOLLARS = 30.0, SELL_GOLD = 0.0	},
	[17]  = {MODEL = "a_c_horse_appaloosa_leopard",                       CATEGORY_INDEX = 18, HORSE_INDEX = 7,    ADOPT_ENABLED = true, SELL_ENABLED = true, ADOPT_DOLLARS = 600.0, ADOPT_GOLD = 0.0, SELL_DOLLARS = 30.0, SELL_GOLD = 0.0	},
	[18]  = {MODEL = "a_c_horse_appaloosa_leopardblanket",                CATEGORY_INDEX = 18, HORSE_INDEX = 3,    ADOPT_ENABLED = true, SELL_ENABLED = true, ADOPT_DOLLARS = 600.0, ADOPT_GOLD = 0.0, SELL_DOLLARS = 30.0, SELL_GOLD = 0.0	},
	[19]  = {MODEL = "a_c_horse_arabian_black",                           CATEGORY_INDEX = 41, HORSE_INDEX = 13,   ADOPT_ENABLED = true, SELL_ENABLED = true, ADOPT_DOLLARS = 600.0, ADOPT_GOLD = 0.0, SELL_DOLLARS = 30.0, SELL_GOLD = 0.0	},
	[20]  = {MODEL = "a_c_horse_arabian_grey",                            CATEGORY_INDEX = 41, HORSE_INDEX = 7,    ADOPT_ENABLED = true, SELL_ENABLED = true, ADOPT_DOLLARS = 600.0, ADOPT_GOLD = 0.0, SELL_DOLLARS = 30.0, SELL_GOLD = 0.0	},
	[21]  = {MODEL = "a_c_horse_arabian_redchestnut",                     CATEGORY_INDEX = 41, HORSE_INDEX = 6,    ADOPT_ENABLED = true, SELL_ENABLED = true, ADOPT_DOLLARS = 600.0, ADOPT_GOLD = 0.0, SELL_DOLLARS = 30.0, SELL_GOLD = 0.0	},
	[22]  = {MODEL = "a_c_horse_arabian_redchestnut_pc",                  CATEGORY_INDEX = 41, HORSE_INDEX = 5,    ADOPT_ENABLED = true, SELL_ENABLED = true, ADOPT_DOLLARS = 600.0, ADOPT_GOLD = 0.0, SELL_DOLLARS = 30.0, SELL_GOLD = 0.0	},
	[23]  = {MODEL = "a_c_horse_arabian_rosegreybay",                     CATEGORY_INDEX = 41, HORSE_INDEX = 4,    ADOPT_ENABLED = true, SELL_ENABLED = true, ADOPT_DOLLARS = 600.0, ADOPT_GOLD = 0.0, SELL_DOLLARS = 30.0, SELL_GOLD = 0.0	},
	[24]  = {MODEL = "a_c_horse_arabian_warpedbrindle_pc",                CATEGORY_INDEX = 41, HORSE_INDEX = 3,    ADOPT_ENABLED = true, SELL_ENABLED = true, ADOPT_DOLLARS = 600.0, ADOPT_GOLD = 0.0, SELL_DOLLARS = 30.0, SELL_GOLD = 0.0	},
	[25]  = {MODEL = "a_c_horse_arabian_white",                           CATEGORY_INDEX = 41, HORSE_INDEX = 1,    ADOPT_ENABLED = true, SELL_ENABLED = true, ADOPT_DOLLARS = 600.0, ADOPT_GOLD = 0.0, SELL_DOLLARS = 30.0, SELL_GOLD = 0.0	},
	[26]  = {MODEL = "a_c_horse_ardennes_bayroan",                        CATEGORY_INDEX = 3,  HORSE_INDEX = 3,	   ADOPT_ENABLED = true, SELL_ENABLED = true, ADOPT_DOLLARS = 600.0, ADOPT_GOLD = 0.0, SELL_DOLLARS = 30.0, SELL_GOLD = 0.0	},
	[27]  = {MODEL = "a_c_horse_ardennes_irongreyroan",                   CATEGORY_INDEX = 3,  HORSE_INDEX = 2,	   ADOPT_ENABLED = true, SELL_ENABLED = true, ADOPT_DOLLARS = 600.0, ADOPT_GOLD = 0.0, SELL_DOLLARS = 30.0, SELL_GOLD = 0.0	},
	[28]  = {MODEL = "a_c_horse_ardennes_strawberryroan",                 CATEGORY_INDEX = 3,  HORSE_INDEX = 1,	   ADOPT_ENABLED = true, SELL_ENABLED = true, ADOPT_DOLLARS = 600.0, ADOPT_GOLD = 0.0, SELL_DOLLARS = 30.0, SELL_GOLD = 0.0	},
	[29]  = {MODEL = "a_c_horse_belgian_blondchestnut",                   CATEGORY_INDEX = 4,  HORSE_INDEX = 2,	   ADOPT_ENABLED = true, SELL_ENABLED = true, ADOPT_DOLLARS = 600.0, ADOPT_GOLD = 0.0, SELL_DOLLARS = 30.0, SELL_GOLD = 0.0	},
	[30]  = {MODEL = "a_c_horse_belgian_mealychestnut",                   CATEGORY_INDEX = 4,  HORSE_INDEX = 2,	   ADOPT_ENABLED = true, SELL_ENABLED = true, ADOPT_DOLLARS = 600.0, ADOPT_GOLD = 0.0, SELL_DOLLARS = 30.0, SELL_GOLD = 0.0	},
	[31]  = {MODEL = "a_c_horse_breton_grullodun",                        CATEGORY_INDEX = 7,  HORSE_INDEX = 6,    ADOPT_ENABLED = true, SELL_ENABLED = true, ADOPT_DOLLARS = 600.0, ADOPT_GOLD = 0.0, SELL_DOLLARS = 30.0, SELL_GOLD = 0.0	},
	[32]  = {MODEL = "a_c_horse_breton_mealydapplebay",                   CATEGORY_INDEX = 7,  HORSE_INDEX = 5,    ADOPT_ENABLED = true, SELL_ENABLED = true, ADOPT_DOLLARS = 600.0, ADOPT_GOLD = 0.0, SELL_DOLLARS = 30.0, SELL_GOLD = 0.0	},
	[33]  = {MODEL = "a_c_horse_breton_redroan",                          CATEGORY_INDEX = 7,  HORSE_INDEX = 4,    ADOPT_ENABLED = true, SELL_ENABLED = true, ADOPT_DOLLARS = 600.0, ADOPT_GOLD = 0.0, SELL_DOLLARS = 30.0, SELL_GOLD = 0.0	},
	[34]  = {MODEL = "a_c_horse_breton_sealbrown",                        CATEGORY_INDEX = 7,  HORSE_INDEX = 3,    ADOPT_ENABLED = true, SELL_ENABLED = true, ADOPT_DOLLARS = 600.0, ADOPT_GOLD = 0.0, SELL_DOLLARS = 30.0, SELL_GOLD = 0.0	},
	[35]  = {MODEL = "a_c_horse_breton_sorrel",                           CATEGORY_INDEX = 7,  HORSE_INDEX = 2,    ADOPT_ENABLED = true, SELL_ENABLED = true, ADOPT_DOLLARS = 600.0, ADOPT_GOLD = 0.0, SELL_DOLLARS = 30.0, SELL_GOLD = 0.0	},
	[36]  = {MODEL = "a_c_horse_breton_steelgrey",                        CATEGORY_INDEX = 7,  HORSE_INDEX = 1,    ADOPT_ENABLED = true, SELL_ENABLED = true, ADOPT_DOLLARS = 600.0, ADOPT_GOLD = 0.0, SELL_DOLLARS = 30.0, SELL_GOLD = 0.0	},
	[37]  = {MODEL = "a_c_horse_buell_warvets",                           CATEGORY_INDEX = 20, HORSE_INDEX = 4,    ADOPT_ENABLED = true, SELL_ENABLED = true, ADOPT_DOLLARS = 600.0, ADOPT_GOLD = 0.0, SELL_DOLLARS = 30.0, SELL_GOLD = 0.0	},
	[38]  = {MODEL = "a_c_horse_criollo_baybrindle",                      CATEGORY_INDEX = 19, HORSE_INDEX = 6,    ADOPT_ENABLED = true, SELL_ENABLED = true, ADOPT_DOLLARS = 600.0, ADOPT_GOLD = 0.0, SELL_DOLLARS = 30.0, SELL_GOLD = 0.0	},
	[39]  = {MODEL = "a_c_horse_criollo_bayframeovero",                   CATEGORY_INDEX = 19, HORSE_INDEX = 5,    ADOPT_ENABLED = true, SELL_ENABLED = true, ADOPT_DOLLARS = 600.0, ADOPT_GOLD = 0.0, SELL_DOLLARS = 30.0, SELL_GOLD = 0.0	},
	[40]  = {MODEL = "a_c_horse_criollo_blueroanovero",                   CATEGORY_INDEX = 19, HORSE_INDEX = 4,    ADOPT_ENABLED = true, SELL_ENABLED = true, ADOPT_DOLLARS = 600.0, ADOPT_GOLD = 0.0, SELL_DOLLARS = 30.0, SELL_GOLD = 0.0	},
	[41]  = {MODEL = "a_c_horse_criollo_dun",                             CATEGORY_INDEX = 19, HORSE_INDEX = 3,    ADOPT_ENABLED = true, SELL_ENABLED = true, ADOPT_DOLLARS = 600.0, ADOPT_GOLD = 0.0, SELL_DOLLARS = 30.0, SELL_GOLD = 0.0	},
	[42]  = {MODEL = "a_c_horse_criollo_marblesabino",                    CATEGORY_INDEX = 19, HORSE_INDEX = 2,    ADOPT_ENABLED = true, SELL_ENABLED = true, ADOPT_DOLLARS = 600.0, ADOPT_GOLD = 0.0, SELL_DOLLARS = 30.0, SELL_GOLD = 0.0	},
	[43]  = {MODEL = "a_c_horse_criollo_sorrelovero",                     CATEGORY_INDEX = 19, HORSE_INDEX = 1,    ADOPT_ENABLED = true, SELL_ENABLED = true, ADOPT_DOLLARS = 600.0, ADOPT_GOLD = 0.0, SELL_DOLLARS = 30.0, SELL_GOLD = 0.0	},
	[44]  = {MODEL = "a_c_horse_dutchwarmblood_chocolateroan",            CATEGORY_INDEX = 20, HORSE_INDEX = 1,    ADOPT_ENABLED = true, SELL_ENABLED = true, ADOPT_DOLLARS = 600.0, ADOPT_GOLD = 0.0, SELL_DOLLARS = 30.0, SELL_GOLD = 0.0	},
	[45]  = {MODEL = "a_c_horse_dutchwarmblood_sealbrown",                CATEGORY_INDEX = 20, HORSE_INDEX = 2,    ADOPT_ENABLED = true, SELL_ENABLED = true, ADOPT_DOLLARS = 600.0, ADOPT_GOLD = 0.0, SELL_DOLLARS = 30.0, SELL_GOLD = 0.0	},
	[46]  = {MODEL = "a_c_horse_dutchwarmblood_sootybuckskin",            CATEGORY_INDEX = 20, HORSE_INDEX = 3,    ADOPT_ENABLED = true, SELL_ENABLED = true, ADOPT_DOLLARS = 600.0, ADOPT_GOLD = 0.0, SELL_DOLLARS = 30.0, SELL_GOLD = 0.0	},
	[47]  = {MODEL = "a_c_horse_eagleflies",                              CATEGORY_INDEX = 15, HORSE_INDEX = 5,    ADOPT_ENABLED = true, SELL_ENABLED = true, ADOPT_DOLLARS = 600.0, ADOPT_GOLD = 0.0, SELL_DOLLARS = 30.0, SELL_GOLD = 0.0 },
	[48]  = {MODEL = "a_c_horse_gang_bill",                               CATEGORY_INDEX = 3,  HORSE_INDEX = 4,    ADOPT_ENABLED = true, SELL_ENABLED = true, ADOPT_DOLLARS = 600.0, ADOPT_GOLD = 0.0, SELL_DOLLARS = 30.0, SELL_GOLD = 0.0 },
	[49]  = {MODEL = "a_c_horse_gang_charles",                            CATEGORY_INDEX = 18, HORSE_INDEX = 4,    ADOPT_ENABLED = true, SELL_ENABLED = true, ADOPT_DOLLARS = 600.0, ADOPT_GOLD = 0.0, SELL_DOLLARS = 30.0, SELL_GOLD = 0.0 },
	[50]  = {MODEL = "a_c_horse_gang_charles_endlesssummer",              CATEGORY_INDEX = 15, HORSE_INDEX = 6,    ADOPT_ENABLED = true, SELL_ENABLED = true, ADOPT_DOLLARS = 600.0, ADOPT_GOLD = 0.0, SELL_DOLLARS = 30.0, SELL_GOLD = 0.0 },
	[51]  = {MODEL = "a_c_horse_gang_dutch",                              CATEGORY_INDEX = 41, HORSE_INDEX = 2,    ADOPT_ENABLED = true, SELL_ENABLED = true, ADOPT_DOLLARS = 600.0, ADOPT_GOLD = 0.0, SELL_DOLLARS = 30.0, SELL_GOLD = 0.0 },
	[52]  = {MODEL = "a_c_horse_gang_hosea",                              CATEGORY_INDEX = 43, HORSE_INDEX = 13,   ADOPT_ENABLED = true, SELL_ENABLED = true, ADOPT_DOLLARS = 600.0, ADOPT_GOLD = 0.0, SELL_DOLLARS = 30.0, SELL_GOLD = 0.0 },
	[53]  = {MODEL = "a_c_horse_gang_javier",                             CATEGORY_INDEX = 18, HORSE_INDEX = 9,    ADOPT_ENABLED = true, SELL_ENABLED = true, ADOPT_DOLLARS = 600.0, ADOPT_GOLD = 0.0, SELL_DOLLARS = 30.0, SELL_GOLD = 0.0 },
	[54]  = {MODEL = "a_c_horse_gang_john",                               CATEGORY_INDEX = 21, HORSE_INDEX = 5,    ADOPT_ENABLED = true, SELL_ENABLED = true, ADOPT_DOLLARS = 600.0, ADOPT_GOLD = 0.0, SELL_DOLLARS = 30.0, SELL_GOLD = 0.0 },
	[55]  = {MODEL = "a_c_horse_gang_karen",                              CATEGORY_INDEX = 27, HORSE_INDEX = 4,    ADOPT_ENABLED = true, SELL_ENABLED = true, ADOPT_DOLLARS = 600.0, ADOPT_GOLD = 0.0, SELL_DOLLARS = 30.0, SELL_GOLD = 0.0 },
	[56]  = {MODEL = "a_c_horse_gang_kieran",                             CATEGORY_INDEX = 33, HORSE_INDEX = 12,   ADOPT_ENABLED = true, SELL_ENABLED = true, ADOPT_DOLLARS = 600.0, ADOPT_GOLD = 0.0, SELL_DOLLARS = 30.0, SELL_GOLD = 0.0 },
	[57]  = {MODEL = "a_c_horse_gang_lenny",                              CATEGORY_INDEX = 26, HORSE_INDEX = 21,   ADOPT_ENABLED = true, SELL_ENABLED = true, ADOPT_DOLLARS = 600.0, ADOPT_GOLD = 0.0, SELL_DOLLARS = 30.0, SELL_GOLD = 0.0 },
	[58]  = {MODEL = "a_c_horse_gang_micah",                              CATEGORY_INDEX = 24, HORSE_INDEX = 8,    ADOPT_ENABLED = true, SELL_ENABLED = true, ADOPT_DOLLARS = 600.0, ADOPT_GOLD = 0.0, SELL_DOLLARS = 30.0, SELL_GOLD = 0.0 },
	[59]  = {MODEL = "a_c_horse_gang_sadie",                              CATEGORY_INDEX = 43, HORSE_INDEX = 8,    ADOPT_ENABLED = true, SELL_ENABLED = true, ADOPT_DOLLARS = 600.0, ADOPT_GOLD = 0.0, SELL_DOLLARS = 30.0, SELL_GOLD = 0.0 },
	[60]  = {MODEL = "a_c_horse_gang_sadie_endlesssummer",                CATEGORY_INDEX = 26, HORSE_INDEX = 9,    ADOPT_ENABLED = true, SELL_ENABLED = true, ADOPT_DOLLARS = 600.0, ADOPT_GOLD = 0.0, SELL_DOLLARS = 30.0, SELL_GOLD = 0.0 },
	[61]  = {MODEL = "a_c_horse_gang_sean",                               CATEGORY_INDEX = 16, HORSE_INDEX = 1,    ADOPT_ENABLED = true, SELL_ENABLED = true, ADOPT_DOLLARS = 600.0, ADOPT_GOLD = 0.0, SELL_DOLLARS = 30.0, SELL_GOLD = 0.0 },
	[62]  = {MODEL = "a_c_horse_gang_trelawney",                          CATEGORY_INDEX = 18, HORSE_INDEX = 2,    ADOPT_ENABLED = true, SELL_ENABLED = true, ADOPT_DOLLARS = 600.0, ADOPT_GOLD = 0.0, SELL_DOLLARS = 30.0, SELL_GOLD = 0.0 },
	[63]  = {MODEL = "a_c_horse_gang_uncle",                              CATEGORY_INDEX = 33, HORSE_INDEX = 8,    ADOPT_ENABLED = true, SELL_ENABLED = true, ADOPT_DOLLARS = 600.0, ADOPT_GOLD = 0.0, SELL_DOLLARS = 30.0, SELL_GOLD = 0.0 },
	[64]  = {MODEL = "a_c_horse_gang_uncle_endlesssummer",                CATEGORY_INDEX = 6,  HORSE_INDEX = 7,    ADOPT_ENABLED = true, SELL_ENABLED = true, ADOPT_DOLLARS = 600.0, ADOPT_GOLD = 0.0, SELL_DOLLARS = 30.0, SELL_GOLD = 0.0 },
	[65]  = {MODEL = "a_c_horse_gypsycob_palominoblagdon",                CATEGORY_INDEX = 13, HORSE_INDEX = 6,    ADOPT_ENABLED = true, SELL_ENABLED = true, ADOPT_DOLLARS = 600.0, ADOPT_GOLD = 0.0, SELL_DOLLARS = 30.0, SELL_GOLD = 0.0 },
	[66]  = {MODEL = "a_c_horse_gypsycob_piebald",                        CATEGORY_INDEX = 13, HORSE_INDEX = 1,    ADOPT_ENABLED = true, SELL_ENABLED = true, ADOPT_DOLLARS = 600.0, ADOPT_GOLD = 0.0, SELL_DOLLARS = 30.0, SELL_GOLD = 0.0 },
	[67]  = {MODEL = "a_c_horse_gypsycob_skewbald",                       CATEGORY_INDEX = 13, HORSE_INDEX = 8,    ADOPT_ENABLED = true, SELL_ENABLED = true, ADOPT_DOLLARS = 600.0, ADOPT_GOLD = 0.0, SELL_DOLLARS = 30.0, SELL_GOLD = 0.0 },
	[68]  = {MODEL = "a_c_horse_gypsycob_splashedbay",                    CATEGORY_INDEX = 13, HORSE_INDEX = 11,   ADOPT_ENABLED = true, SELL_ENABLED = true, ADOPT_DOLLARS = 600.0, ADOPT_GOLD = 0.0, SELL_DOLLARS = 30.0, SELL_GOLD = 0.0 },
	[69]  = {MODEL = "a_c_horse_gypsycob_splashedpiebald",                CATEGORY_INDEX = 13, HORSE_INDEX = 9,    ADOPT_ENABLED = true, SELL_ENABLED = true, ADOPT_DOLLARS = 600.0, ADOPT_GOLD = 0.0, SELL_DOLLARS = 30.0, SELL_GOLD = 0.0 },
	[70]  = {MODEL = "a_c_horse_gypsycob_whiteblagdon",                   CATEGORY_INDEX = 13, HORSE_INDEX = 10,   ADOPT_ENABLED = true, SELL_ENABLED = true, ADOPT_DOLLARS = 600.0, ADOPT_GOLD = 0.0, SELL_DOLLARS = 30.0, SELL_GOLD = 0.0 },
	[71]  = {MODEL = "a_c_horse_hungarianhalfbred_darkdapplegrey",        CATEGORY_INDEX = 21, HORSE_INDEX = 4,    ADOPT_ENABLED = true, SELL_ENABLED = true, ADOPT_DOLLARS = 600.0, ADOPT_GOLD = 0.0, SELL_DOLLARS = 30.0, SELL_GOLD = 0.0 },
	[72]  = {MODEL = "a_c_horse_hungarianhalfbred_flaxenchestnut",        CATEGORY_INDEX = 21, HORSE_INDEX = 3,    ADOPT_ENABLED = true, SELL_ENABLED = true, ADOPT_DOLLARS = 600.0, ADOPT_GOLD = 0.0, SELL_DOLLARS = 30.0, SELL_GOLD = 0.0 },
	[73]  = {MODEL = "a_c_horse_hungarianhalfbred_liverchestnut",         CATEGORY_INDEX = 21, HORSE_INDEX = 2,    ADOPT_ENABLED = true, SELL_ENABLED = true, ADOPT_DOLLARS = 600.0, ADOPT_GOLD = 0.0, SELL_DOLLARS = 30.0, SELL_GOLD = 0.0 },
	[74]  = {MODEL = "a_c_horse_hungarianhalfbred_piebaldtobiano",        CATEGORY_INDEX = 21, HORSE_INDEX = 1,    ADOPT_ENABLED = true, SELL_ENABLED = true, ADOPT_DOLLARS = 600.0, ADOPT_GOLD = 0.0, SELL_DOLLARS = 30.0, SELL_GOLD = 0.0 },
	[75]  = {MODEL = "a_c_horse_john_endlesssummer",                      CATEGORY_INDEX = 42, HORSE_INDEX = 16,   ADOPT_ENABLED = true, SELL_ENABLED = true, ADOPT_DOLLARS = 600.0, ADOPT_GOLD = 0.0, SELL_DOLLARS = 30.0, SELL_GOLD = 0.0 },
	[76]  = {MODEL = "a_c_horse_kentuckysaddle_black",                    CATEGORY_INDEX = 22, HORSE_INDEX = 2,    ADOPT_ENABLED = true, SELL_ENABLED = true, ADOPT_DOLLARS = 600.0, ADOPT_GOLD = 0.0, SELL_DOLLARS = 30.0, SELL_GOLD = 0.0 },
	[77]  = {MODEL = "a_c_horse_kentuckysaddle_buttermilkbuckskin_pc",    CATEGORY_INDEX = 22, HORSE_INDEX = 3,    ADOPT_ENABLED = true, SELL_ENABLED = true, ADOPT_DOLLARS = 600.0, ADOPT_GOLD = 0.0, SELL_DOLLARS = 30.0, SELL_GOLD = 0.0 },
	[78]  = {MODEL = "a_c_horse_kentuckysaddle_chestnutpinto",            CATEGORY_INDEX = 22, HORSE_INDEX = 4,    ADOPT_ENABLED = true, SELL_ENABLED = true, ADOPT_DOLLARS = 600.0, ADOPT_GOLD = 0.0, SELL_DOLLARS = 30.0, SELL_GOLD = 0.0 },
	[79]  = {MODEL = "a_c_horse_kentuckysaddle_grey",                     CATEGORY_INDEX = 22, HORSE_INDEX = 1,    ADOPT_ENABLED = true, SELL_ENABLED = true, ADOPT_DOLLARS = 600.0, ADOPT_GOLD = 0.0, SELL_DOLLARS = 30.0, SELL_GOLD = 0.0 },
	[80]  = {MODEL = "a_c_horse_KentuckySaddle_Silverbay",                CATEGORY_INDEX = 22, HORSE_INDEX = 5,    ADOPT_ENABLED = true, SELL_ENABLED = true, ADOPT_DOLLARS = 600.0, ADOPT_GOLD = 0.0, SELL_DOLLARS = 30.0, SELL_GOLD = 0.0 },
	[81]  = {MODEL = "a_c_horse_kladruber_black",                         CATEGORY_INDEX = 23, HORSE_INDEX = 6,    ADOPT_ENABLED = true, SELL_ENABLED = true, ADOPT_DOLLARS = 600.0, ADOPT_GOLD = 0.0, SELL_DOLLARS = 30.0, SELL_GOLD = 0.0 },
	[82]  = {MODEL = "a_c_horse_kladruber_cremello",                      CATEGORY_INDEX = 23, HORSE_INDEX = 5,    ADOPT_ENABLED = true, SELL_ENABLED = true, ADOPT_DOLLARS = 600.0, ADOPT_GOLD = 0.0, SELL_DOLLARS = 30.0, SELL_GOLD = 0.0 },
	[83]  = {MODEL = "a_c_horse_kladruber_dapplerosegrey",                CATEGORY_INDEX = 23, HORSE_INDEX = 4,    ADOPT_ENABLED = true, SELL_ENABLED = true, ADOPT_DOLLARS = 600.0, ADOPT_GOLD = 0.0, SELL_DOLLARS = 30.0, SELL_GOLD = 0.0 },
	[84]  = {MODEL = "a_c_horse_kladruber_grey",                          CATEGORY_INDEX = 23, HORSE_INDEX = 3,    ADOPT_ENABLED = true, SELL_ENABLED = true, ADOPT_DOLLARS = 600.0, ADOPT_GOLD = 0.0, SELL_DOLLARS = 30.0, SELL_GOLD = 0.0 },
	[85]  = {MODEL = "a_c_horse_kladruber_silver",                        CATEGORY_INDEX = 23, HORSE_INDEX = 2,    ADOPT_ENABLED = true, SELL_ENABLED = true, ADOPT_DOLLARS = 600.0, ADOPT_GOLD = 0.0, SELL_DOLLARS = 30.0, SELL_GOLD = 0.0 },
	[86]  = {MODEL = "a_c_horse_kladruber_white",                         CATEGORY_INDEX = 23, HORSE_INDEX = 1,    ADOPT_ENABLED = true, SELL_ENABLED = true, ADOPT_DOLLARS = 600.0, ADOPT_GOLD = 0.0, SELL_DOLLARS = 30.0, SELL_GOLD = 0.0 },
	[87]  = {MODEL = "a_c_horse_missourifoxtrotter_amberchampagne",       CATEGORY_INDEX = 24, HORSE_INDEX = 2,    ADOPT_ENABLED = true, SELL_ENABLED = true, ADOPT_DOLLARS = 600.0, ADOPT_GOLD = 0.0, SELL_DOLLARS = 30.0, SELL_GOLD = 0.0 },
	[88]  = {MODEL = "a_c_horse_missourifoxtrotter_blacktovero",          CATEGORY_INDEX = 24, HORSE_INDEX = 7,    ADOPT_ENABLED = true, SELL_ENABLED = true, ADOPT_DOLLARS = 600.0, ADOPT_GOLD = 0.0, SELL_DOLLARS = 30.0, SELL_GOLD = 0.0 },
	[89]  = {MODEL = "a_c_horse_missourifoxtrotter_blueroan",             CATEGORY_INDEX = 24, HORSE_INDEX = 3,    ADOPT_ENABLED = true, SELL_ENABLED = true, ADOPT_DOLLARS = 600.0, ADOPT_GOLD = 0.0, SELL_DOLLARS = 30.0, SELL_GOLD = 0.0 },
	[90]  = {MODEL = "a_c_horse_missourifoxtrotter_buckskinbrindle",      CATEGORY_INDEX = 24, HORSE_INDEX = 4,    ADOPT_ENABLED = true, SELL_ENABLED = true, ADOPT_DOLLARS = 600.0, ADOPT_GOLD = 0.0, SELL_DOLLARS = 30.0, SELL_GOLD = 0.0 },
	[91]  = {MODEL = "a_c_horse_missourifoxtrotter_dapplegrey",           CATEGORY_INDEX = 24, HORSE_INDEX = 6,    ADOPT_ENABLED = true, SELL_ENABLED = true, ADOPT_DOLLARS = 600.0, ADOPT_GOLD = 0.0, SELL_DOLLARS = 30.0, SELL_GOLD = 0.0 },
	[92]  = {MODEL = "a_c_horse_missourifoxtrotter_sablechampagne",       CATEGORY_INDEX = 24, HORSE_INDEX = 1,    ADOPT_ENABLED = true, SELL_ENABLED = true, ADOPT_DOLLARS = 600.0, ADOPT_GOLD = 0.0, SELL_DOLLARS = 30.0, SELL_GOLD = 0.0 },
	[93]  = {MODEL = "a_c_horse_missourifoxtrotter_silverdapplepinto",    CATEGORY_INDEX = 24, HORSE_INDEX = 5,    ADOPT_ENABLED = true, SELL_ENABLED = true, ADOPT_DOLLARS = 600.0, ADOPT_GOLD = 0.0, SELL_DOLLARS = 30.0, SELL_GOLD = 0.0 },
	[94]  = {MODEL = "a_c_horse_morgan_bay",                              CATEGORY_INDEX = 25, HORSE_INDEX = 2,    ADOPT_ENABLED = true, SELL_ENABLED = true, ADOPT_DOLLARS = 600.0, ADOPT_GOLD = 0.0, SELL_DOLLARS = 30.0, SELL_GOLD = 0.0 },
	[95]  = {MODEL = "a_c_horse_morgan_bayroan",                          CATEGORY_INDEX = 25, HORSE_INDEX = 3,    ADOPT_ENABLED = true, SELL_ENABLED = true, ADOPT_DOLLARS = 600.0, ADOPT_GOLD = 0.0, SELL_DOLLARS = 30.0, SELL_GOLD = 0.0 },
	[96]  = {MODEL = "a_c_horse_morgan_flaxenchestnut",                   CATEGORY_INDEX = 25, HORSE_INDEX = 4,    ADOPT_ENABLED = true, SELL_ENABLED = true, ADOPT_DOLLARS = 600.0, ADOPT_GOLD = 0.0, SELL_DOLLARS = 30.0, SELL_GOLD = 0.0 },
	[97]  = {MODEL = "a_c_horse_morgan_liverchestnut_pc",                 CATEGORY_INDEX = 25, HORSE_INDEX = 5,    ADOPT_ENABLED = true, SELL_ENABLED = true, ADOPT_DOLLARS = 600.0, ADOPT_GOLD = 0.0, SELL_DOLLARS = 30.0, SELL_GOLD = 0.0 },
	[98]  = {MODEL = "a_c_horse_morgan_palomino",                         CATEGORY_INDEX = 25, HORSE_INDEX = 1,    ADOPT_ENABLED = true, SELL_ENABLED = true, ADOPT_DOLLARS = 600.0, ADOPT_GOLD = 0.0, SELL_DOLLARS = 30.0, SELL_GOLD = 0.0 },
	[99]  = {MODEL = "a_c_horse_mp_mangy_backup",                         CATEGORY_INDEX = 50, HORSE_INDEX = 1,    ADOPT_ENABLED = true, SELL_ENABLED = true, ADOPT_DOLLARS = 600.0, ADOPT_GOLD = 0.0, SELL_DOLLARS = 30.0, SELL_GOLD = 0.0 },
	[100] = {MODEL = "a_c_horse_murfreebrood_mange_01",                   CATEGORY_INDEX = 50, HORSE_INDEX = 7,    ADOPT_ENABLED = true, SELL_ENABLED = true, ADOPT_DOLLARS = 600.0, ADOPT_GOLD = 0.0, SELL_DOLLARS = 30.0, SELL_GOLD = 0.0 },
	[101] = {MODEL = "a_c_horse_murfreebrood_mange_02",                   CATEGORY_INDEX = 50, HORSE_INDEX = 8,    ADOPT_ENABLED = true, SELL_ENABLED = true, ADOPT_DOLLARS = 600.0, ADOPT_GOLD = 0.0, SELL_DOLLARS = 30.0, SELL_GOLD = 0.0 },
	[102] = {MODEL = "a_c_horse_murfreebrood_mange_03",                   CATEGORY_INDEX = 50, HORSE_INDEX = 9,    ADOPT_ENABLED = true, SELL_ENABLED = true, ADOPT_DOLLARS = 600.0, ADOPT_GOLD = 0.0, SELL_DOLLARS = 30.0, SELL_GOLD = 0.0 },
	[103] = {MODEL = "a_c_horse_mustang_blackovero",                      CATEGORY_INDEX = 26, HORSE_INDEX = 8,    ADOPT_ENABLED = true, SELL_ENABLED = true, ADOPT_DOLLARS = 600.0, ADOPT_GOLD = 0.0, SELL_DOLLARS = 30.0, SELL_GOLD = 0.0 },
	[104] = {MODEL = "a_c_horse_mustang_buckskin",                        CATEGORY_INDEX = 26, HORSE_INDEX = 6,    ADOPT_ENABLED = true, SELL_ENABLED = true, ADOPT_DOLLARS = 600.0, ADOPT_GOLD = 0.0, SELL_DOLLARS = 30.0, SELL_GOLD = 0.0 },
	[105] = {MODEL = "a_c_horse_mustang_chestnuttovero",                  CATEGORY_INDEX = 26, HORSE_INDEX = 4,    ADOPT_ENABLED = true, SELL_ENABLED = true, ADOPT_DOLLARS = 600.0, ADOPT_GOLD = 0.0, SELL_DOLLARS = 30.0, SELL_GOLD = 0.0 },
	[106] = {MODEL = "a_c_horse_mustang_goldendun",                       CATEGORY_INDEX = 26, HORSE_INDEX = 5,    ADOPT_ENABLED = true, SELL_ENABLED = true, ADOPT_DOLLARS = 600.0, ADOPT_GOLD = 0.0, SELL_DOLLARS = 30.0, SELL_GOLD = 0.0 },
	[107] = {MODEL = "a_c_horse_mustang_grullodun",                       CATEGORY_INDEX = 26, HORSE_INDEX = 3,    ADOPT_ENABLED = true, SELL_ENABLED = true, ADOPT_DOLLARS = 600.0, ADOPT_GOLD = 0.0, SELL_DOLLARS = 30.0, SELL_GOLD = 0.0 },
	[108] = {MODEL = "a_c_horse_mustang_reddunovero",                     CATEGORY_INDEX = 26, HORSE_INDEX = 7,    ADOPT_ENABLED = true, SELL_ENABLED = true, ADOPT_DOLLARS = 600.0, ADOPT_GOLD = 0.0, SELL_DOLLARS = 30.0, SELL_GOLD = 0.0 },
	[109] = {MODEL = "a_c_horse_mustang_tigerstripedbay",                 CATEGORY_INDEX = 26, HORSE_INDEX = 2,    ADOPT_ENABLED = true, SELL_ENABLED = true, ADOPT_DOLLARS = 600.0, ADOPT_GOLD = 0.0, SELL_DOLLARS = 30.0, SELL_GOLD = 0.0 },
	[110] = {MODEL = "a_c_horse_mustang_wildbay",                         CATEGORY_INDEX = 26, HORSE_INDEX = 1,    ADOPT_ENABLED = true, SELL_ENABLED = true, ADOPT_DOLLARS = 600.0, ADOPT_GOLD = 0.0, SELL_DOLLARS = 30.0, SELL_GOLD = 0.0 },
	[111] = {MODEL = "a_c_horse_nokota_blueroan",                         CATEGORY_INDEX = 27, HORSE_INDEX = 3,    ADOPT_ENABLED = true, SELL_ENABLED = true, ADOPT_DOLLARS = 600.0, ADOPT_GOLD = 0.0, SELL_DOLLARS = 30.0, SELL_GOLD = 0.0 },
	[112] = {MODEL = "a_c_horse_nokota_reversedappleroan",                CATEGORY_INDEX = 27, HORSE_INDEX = 2,    ADOPT_ENABLED = true, SELL_ENABLED = true, ADOPT_DOLLARS = 600.0, ADOPT_GOLD = 0.0, SELL_DOLLARS = 30.0, SELL_GOLD = 0.0 },
	[113] = {MODEL = "a_c_horse_nokota_whiteroan",                        CATEGORY_INDEX = 27, HORSE_INDEX = 1,    ADOPT_ENABLED = true, SELL_ENABLED = true, ADOPT_DOLLARS = 600.0, ADOPT_GOLD = 0.0, SELL_DOLLARS = 30.0, SELL_GOLD = 0.0 },
	[114] = {MODEL = "a_c_horse_norfolkroadster_black",                   CATEGORY_INDEX = 34, HORSE_INDEX = 1,    ADOPT_ENABLED = true, SELL_ENABLED = true, ADOPT_DOLLARS = 600.0, ADOPT_GOLD = 0.0, SELL_DOLLARS = 30.0, SELL_GOLD = 0.0 },
	[115] = {MODEL = "a_c_horse_norfolkroadster_dappledbuckskin",         CATEGORY_INDEX = 34, HORSE_INDEX = 2,    ADOPT_ENABLED = true, SELL_ENABLED = true, ADOPT_DOLLARS = 600.0, ADOPT_GOLD = 0.0, SELL_DOLLARS = 30.0, SELL_GOLD = 0.0 },
	[116] = {MODEL = "a_c_horse_norfolkroadster_piebaldroan",             CATEGORY_INDEX = 34, HORSE_INDEX = 3,    ADOPT_ENABLED = true, SELL_ENABLED = true, ADOPT_DOLLARS = 600.0, ADOPT_GOLD = 0.0, SELL_DOLLARS = 30.0, SELL_GOLD = 0.0 },
	[117] = {MODEL = "a_c_horse_norfolkroadster_rosegrey",                CATEGORY_INDEX = 34, HORSE_INDEX = 4,    ADOPT_ENABLED = true, SELL_ENABLED = true, ADOPT_DOLLARS = 600.0, ADOPT_GOLD = 0.0, SELL_DOLLARS = 30.0, SELL_GOLD = 0.0 },
	[118] = {MODEL = "a_c_horse_norfolkroadster_speckledgrey",            CATEGORY_INDEX = 34, HORSE_INDEX = 5,    ADOPT_ENABLED = true, SELL_ENABLED = true, ADOPT_DOLLARS = 600.0, ADOPT_GOLD = 0.0, SELL_DOLLARS = 30.0, SELL_GOLD = 0.0 },
	[119] = {MODEL = "a_c_horse_norfolkroadster_spottedtricolor",         CATEGORY_INDEX = 34, HORSE_INDEX = 6,    ADOPT_ENABLED = true, SELL_ENABLED = true, ADOPT_DOLLARS = 600.0, ADOPT_GOLD = 0.0, SELL_DOLLARS = 30.0, SELL_GOLD = 0.0 },
	[120] = {MODEL = "a_c_horse_shire_darkbay",                           CATEGORY_INDEX = 5,  HORSE_INDEX = 3,    ADOPT_ENABLED = true, SELL_ENABLED = true, ADOPT_DOLLARS = 600.0, ADOPT_GOLD = 0.0, SELL_DOLLARS = 30.0, SELL_GOLD = 0.0 },
	[121] = {MODEL = "a_c_horse_shire_lightgrey",                         CATEGORY_INDEX = 5,  HORSE_INDEX = 2,    ADOPT_ENABLED = true, SELL_ENABLED = true, ADOPT_DOLLARS = 600.0, ADOPT_GOLD = 0.0, SELL_DOLLARS = 30.0, SELL_GOLD = 0.0 },
	[122] = {MODEL = "a_c_horse_shire_ravenblack",                        CATEGORY_INDEX = 5,  HORSE_INDEX = 1,    ADOPT_ENABLED = true, SELL_ENABLED = true, ADOPT_DOLLARS = 600.0, ADOPT_GOLD = 0.0, SELL_DOLLARS = 30.0, SELL_GOLD = 0.0 },
	[123] = {MODEL = "a_c_horse_suffolkpunch_redchestnut",                CATEGORY_INDEX = 6,  HORSE_INDEX = 2,    ADOPT_ENABLED = true, SELL_ENABLED = true, ADOPT_DOLLARS = 600.0, ADOPT_GOLD = 0.0, SELL_DOLLARS = 30.0, SELL_GOLD = 0.0 },
	[124] = {MODEL = "a_c_horse_suffolkpunch_sorrel",                     CATEGORY_INDEX = 6,  HORSE_INDEX = 1,    ADOPT_ENABLED = true, SELL_ENABLED = true, ADOPT_DOLLARS = 600.0, ADOPT_GOLD = 0.0, SELL_DOLLARS = 30.0, SELL_GOLD = 0.0 },
	[125] = {MODEL = "a_c_horse_tennesseewalker_blackrabicano",           CATEGORY_INDEX = 33, HORSE_INDEX = 6,    ADOPT_ENABLED = true, SELL_ENABLED = true, ADOPT_DOLLARS = 600.0, ADOPT_GOLD = 0.0, SELL_DOLLARS = 30.0, SELL_GOLD = 0.0 },
	[126] = {MODEL = "a_c_horse_tennesseewalker_chestnut",                CATEGORY_INDEX = 33, HORSE_INDEX = 5,    ADOPT_ENABLED = true, SELL_ENABLED = true, ADOPT_DOLLARS = 600.0, ADOPT_GOLD = 0.0, SELL_DOLLARS = 30.0, SELL_GOLD = 0.0 },
	[127] = {MODEL = "a_c_horse_tennesseewalker_dapplebay",               CATEGORY_INDEX = 33, HORSE_INDEX = 4,    ADOPT_ENABLED = true, SELL_ENABLED = true, ADOPT_DOLLARS = 600.0, ADOPT_GOLD = 0.0, SELL_DOLLARS = 30.0, SELL_GOLD = 0.0 },
	[128] = {MODEL = "a_c_horse_tennesseewalker_flaxenroan",              CATEGORY_INDEX = 33, HORSE_INDEX = 3,    ADOPT_ENABLED = true, SELL_ENABLED = true, ADOPT_DOLLARS = 600.0, ADOPT_GOLD = 0.0, SELL_DOLLARS = 30.0, SELL_GOLD = 0.0 },
	[129] = {MODEL = "a_c_horse_tennesseewalker_goldpalomino_pc",         CATEGORY_INDEX = 33, HORSE_INDEX = 2,    ADOPT_ENABLED = true, SELL_ENABLED = true, ADOPT_DOLLARS = 600.0, ADOPT_GOLD = 0.0, SELL_DOLLARS = 30.0, SELL_GOLD = 0.0 },
	[130] = {MODEL = "a_c_horse_tennesseewalker_mahoganybay",             CATEGORY_INDEX = 33, HORSE_INDEX = 7,    ADOPT_ENABLED = true, SELL_ENABLED = true, ADOPT_DOLLARS = 600.0, ADOPT_GOLD = 0.0, SELL_DOLLARS = 30.0, SELL_GOLD = 0.0 },
	[131] = {MODEL = "a_c_horse_tennesseewalker_redroan",                 CATEGORY_INDEX = 33, HORSE_INDEX = 1,    ADOPT_ENABLED = true, SELL_ENABLED = true, ADOPT_DOLLARS = 600.0, ADOPT_GOLD = 0.0, SELL_DOLLARS = 30.0, SELL_GOLD = 0.0 },
	[132] = {MODEL = "a_c_horse_thoroughbred_blackchestnut",              CATEGORY_INDEX = 42, HORSE_INDEX = 2,    ADOPT_ENABLED = true, SELL_ENABLED = true, ADOPT_DOLLARS = 600.0, ADOPT_GOLD = 0.0, SELL_DOLLARS = 30.0, SELL_GOLD = 0.0 },
	[133] = {MODEL = "a_c_horse_thoroughbred_bloodbay",                   CATEGORY_INDEX = 42, HORSE_INDEX = 3,    ADOPT_ENABLED = true, SELL_ENABLED = true, ADOPT_DOLLARS = 600.0, ADOPT_GOLD = 0.0, SELL_DOLLARS = 30.0, SELL_GOLD = 0.0 },
	[134] = {MODEL = "a_c_horse_thoroughbred_brindle",                    CATEGORY_INDEX = 42, HORSE_INDEX = 4,    ADOPT_ENABLED = true, SELL_ENABLED = true, ADOPT_DOLLARS = 600.0, ADOPT_GOLD = 0.0, SELL_DOLLARS = 30.0, SELL_GOLD = 0.0 },
	[135] = {MODEL = "a_c_horse_thoroughbred_dapplegrey",                 CATEGORY_INDEX = 42, HORSE_INDEX = 1,    ADOPT_ENABLED = true, SELL_ENABLED = true, ADOPT_DOLLARS = 600.0, ADOPT_GOLD = 0.0, SELL_DOLLARS = 30.0, SELL_GOLD = 0.0 },
	[136] = {MODEL = "a_c_horse_Thoroughbred_reversedappleblack",         CATEGORY_INDEX = 42, HORSE_INDEX = 5,    ADOPT_ENABLED = true, SELL_ENABLED = true, ADOPT_DOLLARS = 600.0, ADOPT_GOLD = 0.0, SELL_DOLLARS = 30.0, SELL_GOLD = 0.0 },
	[137] = {MODEL = "a_c_horse_turkoman_black",                          CATEGORY_INDEX = 43, HORSE_INDEX = 4,    ADOPT_ENABLED = true, SELL_ENABLED = true, ADOPT_DOLLARS = 600.0, ADOPT_GOLD = 0.0, SELL_DOLLARS = 30.0, SELL_GOLD = 0.0 },
	[138] = {MODEL = "a_c_horse_turkoman_chestnut",                       CATEGORY_INDEX = 43, HORSE_INDEX = 5,    ADOPT_ENABLED = true, SELL_ENABLED = true, ADOPT_DOLLARS = 600.0, ADOPT_GOLD = 0.0, SELL_DOLLARS = 30.0, SELL_GOLD = 0.0 },
	[139] = {MODEL = "a_c_horse_turkoman_darkbay",                        CATEGORY_INDEX = 43, HORSE_INDEX = 3,    ADOPT_ENABLED = true, SELL_ENABLED = true, ADOPT_DOLLARS = 600.0, ADOPT_GOLD = 0.0, SELL_DOLLARS = 30.0, SELL_GOLD = 0.0 },
	[140] = {MODEL = "a_c_horse_turkoman_gold",                           CATEGORY_INDEX = 43, HORSE_INDEX = 1,    ADOPT_ENABLED = true, SELL_ENABLED = true, ADOPT_DOLLARS = 600.0, ADOPT_GOLD = 0.0, SELL_DOLLARS = 30.0, SELL_GOLD = 0.0 },
	[141] = {MODEL = "a_c_horse_turkoman_grey",                           CATEGORY_INDEX = 43, HORSE_INDEX = 6,    ADOPT_ENABLED = true, SELL_ENABLED = true, ADOPT_DOLLARS = 600.0, ADOPT_GOLD = 0.0, SELL_DOLLARS = 30.0, SELL_GOLD = 0.0 },
	[142] = {MODEL = "a_c_horse_turkoman_perlino",                        CATEGORY_INDEX = 43, HORSE_INDEX = 7,    ADOPT_ENABLED = true, SELL_ENABLED = true, ADOPT_DOLLARS = 600.0, ADOPT_GOLD = 0.0, SELL_DOLLARS = 30.0, SELL_GOLD = 0.0 },
	[143] = {MODEL = "a_c_horse_turkoman_silver",                         CATEGORY_INDEX = 43, HORSE_INDEX = 2,    ADOPT_ENABLED = true, SELL_ENABLED = true, ADOPT_DOLLARS = 600.0, ADOPT_GOLD = 0.0, SELL_DOLLARS = 30.0, SELL_GOLD = 0.0 },
	[144] = {MODEL = "a_c_horse_winter02_01",                             CATEGORY_INDEX = 42, HORSE_INDEX = 2,    ADOPT_ENABLED = true, SELL_ENABLED = true, ADOPT_DOLLARS = 600.0, ADOPT_GOLD = 0.0, SELL_DOLLARS = 30.0, SELL_GOLD = 0.0 },
	[145] = {MODEL = "a_c_horsemule_01",                                  CATEGORY_INDEX = 42, HORSE_INDEX = 1,    ADOPT_ENABLED = true, SELL_ENABLED = true, ADOPT_DOLLARS = 600.0, ADOPT_GOLD = 0.0, SELL_DOLLARS = 30.0, SELL_GOLD = 0.0 },
	[146] = {MODEL = "a_c_horsemulepainted_01",                           CATEGORY_INDEX = 42, HORSE_INDEX = 13,   ADOPT_ENABLED = true, SELL_ENABLED = true, ADOPT_DOLLARS = 600.0, ADOPT_GOLD = 0.0, SELL_DOLLARS = 30.0, SELL_GOLD = 0.0 },
}                                                                                                                                                                                                                                                 
 
-----------------------------------
 -- WILD HORSE TAMING MINIGAME --
-----------------------------------
-- If enabled, when the player mounts a wild horse, a left/right mash minigame starts.
-- Fail = ragdoll + horse becomes wild again.
-- Success = notification + animations cleared.

Config.WILD_TAMING_MINIGAME_ENABLED      = true

Config.WILD_TAMING_PROMPT_GROUP_LABEL    = "Tame"
Config.WILD_TAMING_PROMPT_LEFT_LABEL     = "Lean Left"
Config.WILD_TAMING_PROMPT_RIGHT_LABEL    = "Lean Right"

-- Control hashes used by the prompts (change to whatever you prefer)
Config.WILD_TAMING_PROMPT_LEFT_KEY       = `INPUT_FRONTEND_LEFT` -- LEFT ARROW
Config.WILD_TAMING_PROMPT_RIGHT_KEY      = `INPUT_FRONTEND_RIGHT`-- RIGHT ARROW

-- Minigame tuning
Config.WILD_TAMING_STEPS                 = 13     -- HOW MANY PROMPT SWAPS ARE REQUIRED TO SUCCEED
Config.WILD_TAMING_MASHES_PER_STEP       = 5      -- MASHES REQUIRED FOR EACH STEP
Config.WILD_TAMING_STEP_TIME_MS          = 1600   -- TIME ALLOWED PER STEP
Config.WILD_TAMING_MAX_MISTAKES          = 1      -- ALLOWED FAILED/TIMEOUT STEPS BEFORE FAILING
 
-- BALANCE-MODE TUNING (NEW MINIGAME BEHAVIOR)
Config.WILD_TAMING_MIN_TOLERANCE         = -20   -- SLIDER TOLERANCE MIN
Config.WILD_TAMING_MAX_TOLERANCE         =  20   -- SLIDER TOLERANCE MAX
 
Config.WILD_TAMING_INPUT_STEP            =  12   -- added on each prompt press (left = -, right = +)
Config.WILD_TAMING_DRIFT_STEP            =  3    -- applied repeatedly to simulate the horse pushing you off balance
Config.WILD_TAMING_DRIFT_TICK_MS         =  200  -- drift tick rate
 
Config.WILD_TAMING_OUTSIDE_FAIL_MS       =  2500  -- if you stay outside tolerance for this long => fail
 
-- Cancel keys (if pressed during the minigame, it fails)
Config.WILD_TAMING_CANCEL_KEYS = {
    `INPUT_TOGGLE_HOLSTER`,
    `INPUT_OPEN_WHEEL_MENU`,
    -- `INPUT_ENTER`,
    `INPUT_HORSE_EXIT`,
}
 
 