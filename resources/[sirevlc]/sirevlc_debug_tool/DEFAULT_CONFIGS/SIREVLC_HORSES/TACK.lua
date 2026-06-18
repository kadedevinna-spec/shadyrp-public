Config = Config or {}

--------------------------------------------------------------------------------------------------------------------------------------------
 
														-- HORSE TACK --
  
--------------------------------------------------------------------------------------------------------------------------------------------		   
--------------------------------------------------------------------------------------------------------------------------------------------
 
 
Config.EQUIPMENTS_TITLE = "Tack Categories"
Config.EQUIPMENTS = {
[1]  = {label =  "Saddles"    		, value = "SADDLES"    		,  desc = "Display the saddles menu"    , image = "items/generic_horse_equip_saddle.png"	},
[2]  = {label =  "Saddlebags" 		, value = "SADDLEBAGS" 		,  desc = "Display the saddlebags menu" , image = "items/generic_horse_equip_saddlebag.png"	},
[3]  = {label =  "Stirrups"   		, value = "STIRRUPS"   		,  desc = "Display the stirrups menu"   , image = "items/generic_horse_equip_stirrup.png"	},
[4]  = {label =  "Bedrolls"   		, value = "BEDROLLS"   		,  desc = "Display the bedrolls menu"   , image = "items/generic_horse_equip_bedroll.png"	},
[5]  = {label =  "Blankets"   		, value = "BLANKETS"   		,  desc = "Display the blankets menu"   , image = "items/generic_horse_equip_blanket.png"	},
[6]  = {label =  "Horns"      		, value = "HORNS"      		,  desc = "Display the horns menu"      , image = "items/generic_horse_equip_horn.png"	    },
[7]  = {label =  "Shoes"      		, value = "SHOES"      		,  desc = "Display the shoes menu"      , image = "items/horse_shoe.png"					},
[8]  = {label =  "Lanterns"   		, value = "LANTERNS"   		,  desc = "Display the lanterns menu"   , image = "items/generic_horse_equip_lantern.png"	},
[9]  = {label =  "Lassos"     		, value = "LASSOS"     		,  desc = "Display the lassos menu"  	, image = "items/weapon_lasso.png"	},
[10] = {label =  "Full Harnesses"   , value = "FULL_HARNESSES"  ,  desc = "Display the harnesses menu"  , image = "items/clothing_generic_suspenders.png"	},
[11] = {label =  "Holster"    		, value = "HOLSTERS"   		,  desc = "Display the holsters menu"   , image = "items/upgrade_offhand_holster.png"		},
[12] = {label =  "Masks"      		, value = "MASKS"      		,  desc = "Display the masks menu"      , image = "items/generic_horse_equip_mask.png"		},
[13] = {label =  "Bridles"    		, value = "BRIDLES"    		,  desc = "Display the bridles menu"    , image = "items/horse_bridles.png"			    	}, 
}
 
Config.HORSE_HAIR_TITLE = "Horse Hair"
Config.HORSE_HAIR = {
[1] = {label =  "Manes"      , value = "MANES"      ,  desc = "Display the manes menu"     , image = "items/generic_horse_equip_mane.png"		},
[2] = {label =  "Tails"      , value = "TAILS"      ,  desc = "Display the tails menu"     , image = "items/generic_horse_equip_tail.png"		},
[3] = {label =  "Mustaches"  , value = "MUSTACHES"  ,  desc = "Display the mustaches menu" , image = "items/horse_mustache.png"		},
[4] = {label =  "Feathers"   , value = "FEATHERS"   ,  desc = "Display the feathers menu" ,  image = "items/horse_feathers_icon.png"		},
[5] = {label =  "Eyelashes"  , value = "EYELASHES"  ,  desc = "Display the eyelashes menu" , image = "items/horse_eyelashes_icon.png"		},
} 
 
 
-- SOME TACK MAY NOT BE CUSTOMIZABLE BECAUSE CERTAIN BASE GAME TEXTURES DO NOT SUPPORT TINT CHANGES 
Config.SADDLES = {

-- NO SADDLE 
    [1] = {
        NAME  = "NO SADDLE",
        OPTIONS = {
            {STABLES_AVAILABILITY     = {1,2,3,4,5,6,7,8,9,10,11,12}, LABEL = "No saddle",     		 DESCRIPTION = "Remove that tack piece from your horse", DOLLARS =  0.0, GOLD = 0.0, TYPE = 0 , TINTA = 0   ,TINTB = 0  ,TINTC = 0  ,CUSTOMIZABLE = false, CUSTOM_ROLELOCK = false, CUSTOM_ROLES = {""}, CUSTOM_PLAYERLOCK = false, CUSTOM_PLAYERS = {""}, ROLELOCK = false, ROLES = {"none"}, PLAYERLOCK = false, PLAYERS = {""}, image = "items/generic_horse_equip_saddle.png"},					
        },
    },

-- SPECIAL SADDLES 
    [2] = {
        NAME  = "Special Saddles",
        OPTIONS = {
            {STABLES_AVAILABILITY     = {"ALL"}, LABEL = "Charro I",     			DESCRIPTION = "A nice piece of tack for your horse", DOLLARS =  185.0, GOLD = 0.0, TYPE = 1 , TINTA = 66   ,TINTB = 66  ,TINTC = 66   ,CUSTOMIZABLE = true,  CUSTOM_ROLELOCK = false, CUSTOM_ROLES = {""}, CUSTOM_PLAYERLOCK = false, CUSTOM_PLAYERS = {""}, ROLELOCK = false, ROLES = {"none"}, PLAYERLOCK = false, PLAYERS = {""}, image = "items/generic_horse_equip_saddle.png"},					
			{STABLES_AVAILABILITY     = {1,2,3,4,5,6,7,8,9,10,11,12}, LABEL = "Charro II",  			DESCRIPTION = "A nice piece of tack for your horse", DOLLARS =  165.0, GOLD = 0.0, TYPE = 2 , TINTA = 10   ,TINTB = 10  ,TINTC = 10   ,CUSTOMIZABLE = true,  CUSTOM_ROLELOCK = false, CUSTOM_ROLES = {""}, CUSTOM_PLAYERLOCK = false, CUSTOM_PLAYERS = {""}, ROLELOCK = false, ROLES = {"none"}, PLAYERLOCK = false, PLAYERS = {""}, image = "items/generic_horse_equip_saddle.png"},
			{STABLES_AVAILABILITY     = {1,2,3,4,5,6,7,8,9,10,11,12}, LABEL = "Trapper I",          	DESCRIPTION = "A nice piece of tack for your horse", DOLLARS =  180.0, GOLD = 0.0, TYPE = 3 , TINTA = 100  ,TINTB = 100 ,TINTC = 100  ,CUSTOMIZABLE = true,  CUSTOM_ROLELOCK = false, CUSTOM_ROLES = {""}, CUSTOM_PLAYERLOCK = false, CUSTOM_PLAYERS = {""}, ROLELOCK = false, ROLES = {"none"}, PLAYERLOCK = false, PLAYERS = {""}, image = "items/generic_horse_equip_saddle.png"},						
			{STABLES_AVAILABILITY     = {1,2,3,4,5,6,7,8,9,10,11,12}, LABEL = "Charro III Combo",  		DESCRIPTION = "A nice piece of tack for your horse", DOLLARS =  150.0, GOLD = 0.0, TYPE = 4 , TINTA =  66  ,TINTB = 66  ,TINTC = 66   ,CUSTOMIZABLE = true,  CUSTOM_ROLELOCK = false, CUSTOM_ROLES = {""}, CUSTOM_PLAYERLOCK = false, CUSTOM_PLAYERS = {""}, ROLELOCK = false, ROLES = {"none"}, PLAYERLOCK = false, PLAYERS = {""}, image = "items/generic_horse_equip_saddle.png"}, -- TINT CANT BE CHANGED 					
			{STABLES_AVAILABILITY     = {1,2,3,4,5,6,7,8,9,10,11,12}, LABEL = "Bounty Hunter I",  	    DESCRIPTION = "A nice piece of tack for your horse", DOLLARS =  169.0, GOLD = 0.0, TYPE = 5 , TINTA =  6   ,TINTB = 130 ,TINTC = 151  ,CUSTOMIZABLE = true,  CUSTOM_ROLELOCK = false, CUSTOM_ROLES = {""}, CUSTOM_PLAYERLOCK = false, CUSTOM_PLAYERS = {""}, ROLELOCK = false, ROLES = {"none"}, PLAYERLOCK = false, PLAYERS = {""}, image = "items/generic_horse_equip_saddle.png"},
     		{STABLES_AVAILABILITY     = {1,2,3,4,5,6,7,8,9,10,11,12}, LABEL = "Trapper II Combo",    	DESCRIPTION = "A nice piece of tack for your horse", DOLLARS =  150.0, GOLD = 0.0, TYPE = 6 , TINTA = 66   ,TINTB = 66  ,TINTC = 66   ,CUSTOMIZABLE = true,  CUSTOM_ROLELOCK = false, CUSTOM_ROLES = {""}, CUSTOM_PLAYERLOCK = false, CUSTOM_PLAYERS = {""}, ROLELOCK = false, ROLES = {"none"}, PLAYERLOCK = false, PLAYERS = {""}, image = "items/generic_horse_equip_saddle.png"}, -- TINT CANT BE CHANGED 
			{STABLES_AVAILABILITY     = {1,2,3,4,5,6,7,8,9,10,11,12}, LABEL = "Trapper III Combo",  	DESCRIPTION = "A nice piece of tack for your horse", DOLLARS =  170.0, GOLD = 0.0, TYPE = 7 , TINTA = 14   ,TINTB = 37  ,TINTC = 13   ,CUSTOMIZABLE = true,  CUSTOM_ROLELOCK = false, CUSTOM_ROLES = {""}, CUSTOM_PLAYERLOCK = false, CUSTOM_PLAYERS = {""}, ROLELOCK = false, ROLES = {"none"}, PLAYERLOCK = false, PLAYERS = {""}, image = "items/generic_horse_equip_saddle.png"},
			{STABLES_AVAILABILITY     = {1,2,3,4,5,6,7,8,9,10,11,12}, LABEL = "Trapper IV Combo",  		DESCRIPTION = "A nice piece of tack for your horse", DOLLARS =  180.0, GOLD = 0.0, TYPE = 8 , TINTA = 14   ,TINTB = 37  ,TINTC = 13   ,CUSTOMIZABLE = true,  CUSTOM_ROLELOCK = false, CUSTOM_ROLES = {""}, CUSTOM_PLAYERLOCK = false, CUSTOM_PLAYERS = {""}, ROLELOCK = false, ROLES = {"none"}, PLAYERLOCK = false, PLAYERS = {""}, image = "items/generic_horse_equip_saddle.png"},
			{STABLES_AVAILABILITY     = {1,2,3,4,5,6,7,8,9,10,11,12}, LABEL = "Cutting I",  		    DESCRIPTION = "A nice piece of tack for your horse", DOLLARS =  160.0, GOLD = 0.0, TYPE = 9 , TINTA = 17   ,TINTB = 31  ,TINTC = 10   ,CUSTOMIZABLE = true,  CUSTOM_ROLELOCK = false, CUSTOM_ROLES = {""}, CUSTOM_PLAYERLOCK = false, CUSTOM_PLAYERS = {""}, ROLELOCK = false, ROLES = {"none"}, PLAYERLOCK = false, PLAYERS = {""}, image = "items/generic_horse_equip_saddle.png"},
			{STABLES_AVAILABILITY     = {1,2,3,4,5,6,7,8,9,10,11,12}, LABEL = "Moonshiner ",  		    DESCRIPTION = "A nice piece of tack for your horse", DOLLARS =  160.0, GOLD = 0.0, TYPE = 10, TINTA = 254  ,TINTB = 118 ,TINTC = 119  ,CUSTOMIZABLE = true,  CUSTOM_ROLELOCK = false, CUSTOM_ROLES = {""}, CUSTOM_PLAYERLOCK = false, CUSTOM_PLAYERS = {""}, ROLELOCK = false, ROLES = {"none"}, PLAYERLOCK = false, PLAYERS = {""}, image = "items/generic_horse_equip_saddle.png"},
			{STABLES_AVAILABILITY     = {1,2,3,4,5,6,7,8,9,10,11,12}, LABEL = "Jim Milton",  		    DESCRIPTION = "A nice piece of tack for your horse", DOLLARS =  170.0, GOLD = 0.0, TYPE = 11, TINTA = 0    ,TINTB = 0 	,TINTC = 0 	  ,CUSTOMIZABLE = false, CUSTOM_ROLELOCK = false, CUSTOM_ROLES = {""}, CUSTOM_PLAYERLOCK = false, CUSTOM_PLAYERS = {""}, ROLELOCK = false, ROLES = {"none"}, PLAYERLOCK = false, PLAYERS = {""}, image = "items/generic_horse_equip_saddle.png"},
 			{STABLES_AVAILABILITY     = {1,2,3,4,5,6,7,8,9,10,11,12}, LABEL = "Rough Travelers",       	DESCRIPTION = "A nice piece of tack for your horse", DOLLARS =  100.0, GOLD = 0.0, TYPE = 12, TINTA = 21   ,TINTB = 6   ,TINTC = 7    ,CUSTOMIZABLE = true,  CUSTOM_ROLELOCK = false, CUSTOM_ROLES = {""}, CUSTOM_PLAYERLOCK = false, CUSTOM_PLAYERS = {""}, ROLELOCK = false, ROLES = {"none"}, PLAYERLOCK = false, PLAYERS = {""}, image = "items/generic_horse_equip_saddle.png"}, -- TINT CANT BE CHANGED 
 			{STABLES_AVAILABILITY     = {1,2,3,4,5,6,7,8,9,10,11,12}, LABEL = "Mother Hubbard I",      	DESCRIPTION = "A nice piece of tack for your horse", DOLLARS =  100.0, GOLD = 0.0, TYPE = 13, TINTA = 66   ,TINTB = 66  ,TINTC = 66   ,CUSTOMIZABLE = true,  CUSTOM_ROLELOCK = false, CUSTOM_ROLES = {""}, CUSTOM_PLAYERLOCK = false, CUSTOM_PLAYERS = {""}, ROLELOCK = false, ROLES = {"none"}, PLAYERLOCK = false, PLAYERS = {""}, image = "items/generic_horse_equip_saddle.png"}, --   
 			{STABLES_AVAILABILITY     = {1,2,3,4,5,6,7,8,9,10,11,12}, LABEL = "All Around",  			DESCRIPTION = "A nice piece of tack for your horse", DOLLARS =  100.0, GOLD = 0.0, TYPE = 14, TINTA = 66   ,TINTB = 66  ,TINTC = 66   ,CUSTOMIZABLE = true,  CUSTOM_ROLELOCK = false, CUSTOM_ROLES = {""}, CUSTOM_PLAYERLOCK = false, CUSTOM_PLAYERS = {""}, ROLELOCK = false, ROLES = {"none"}, PLAYERLOCK = false, PLAYERS = {""}, image = "items/generic_horse_equip_saddle.png"}, --   
 			{STABLES_AVAILABILITY     = {1,2,3,4,5,6,7,8,9,10,11,12}, LABEL = "Cutting II",  			DESCRIPTION = "A nice piece of tack for your horse", DOLLARS =  100.0, GOLD = 0.0, TYPE = 15, TINTA = 66   ,TINTB = 66  ,TINTC = 66   ,CUSTOMIZABLE = true,  CUSTOM_ROLELOCK = false, CUSTOM_ROLES = {""}, CUSTOM_PLAYERLOCK = false, CUSTOM_PLAYERS = {""}, ROLELOCK = false, ROLES = {"none"}, PLAYERLOCK = false, PLAYERS = {""}, image = "items/generic_horse_equip_saddle.png"}, --   
 			{STABLES_AVAILABILITY     = {1,2,3,4,5,6,7,8,9,10,11,12}, LABEL = "All Around II",  		DESCRIPTION = "A nice piece of tack for your horse", DOLLARS =  100.0, GOLD = 0.0, TYPE = 16, TINTA = 66   ,TINTB = 66  ,TINTC = 66   ,CUSTOMIZABLE = true,  CUSTOM_ROLELOCK = false, CUSTOM_ROLES = {""}, CUSTOM_PLAYERLOCK = false, CUSTOM_PLAYERS = {""}, ROLELOCK = false, ROLES = {"none"}, PLAYERLOCK = false, PLAYERS = {""}, image = "items/generic_horse_equip_saddle.png"}, --   
 			{STABLES_AVAILABILITY     = {1,2,3,4,5,6,7,8,9,10,11,12}, LABEL = "Cutting III",    		DESCRIPTION = "A nice piece of tack for your horse", DOLLARS =  100.0, GOLD = 0.0, TYPE = 17, TINTA = 66   ,TINTB = 66  ,TINTC = 66   ,CUSTOMIZABLE = true,  CUSTOM_ROLELOCK = false, CUSTOM_ROLES = {""}, CUSTOM_PLAYERLOCK = false, CUSTOM_PLAYERS = {""}, ROLELOCK = false, ROLES = {"none"}, PLAYERLOCK = false, PLAYERS = {""}, image = "items/generic_horse_equip_saddle.png"}, --   
        },
    },
	
-- CHARRO SADDLES 
    [3] = {
        NAME = "Charro Saddles Improved",
        OPTIONS = {
			{STABLES_AVAILABILITY     = {1,2,3,4,5,6,7,8,9,10,11,12}, LABEL = "Improved", 			 DESCRIPTION = "A nice piece of tack for your horse", 	DOLLARS =  45.0, GOLD = 0.0, TYPE = 18, TINTA = 10    ,TINTB = 10   , TINTC = 17   , CUSTOMIZABLE = true, CUSTOM_ROLELOCK = false, CUSTOM_ROLES = {""}, CUSTOM_PLAYERLOCK = false, CUSTOM_PLAYERS = {""}, ROLELOCK = false, ROLES = {"none"}, PLAYERLOCK = false, PLAYERS = {""}, image = "items/generic_horse_equip_saddle.png"},	
 		},
 	},		
    [4] = {
        NAME = "Charro Saddles New",
        OPTIONS = { 
 			{STABLES_AVAILABILITY     = {1,2,3,4,5,6,7,8,9,10,11,12}, LABEL = "New",          	     DESCRIPTION = "A nice piece of tack for your horse",  	 DOLLARS =  30.0, GOLD = 0.0, TYPE = 19, TINTA = 10    ,TINTB = 10   , TINTC = 17   , CUSTOMIZABLE = true, CUSTOM_ROLELOCK = false, CUSTOM_ROLES = {""}, CUSTOM_PLAYERLOCK = false, CUSTOM_PLAYERS = {""}, ROLELOCK = false, ROLES = {"none"}, PLAYERLOCK = false, PLAYERS = {""}, image = "items/generic_horse_equip_saddle.png"},	
 			},
 		},
    [5] = {
        NAME = "Charro Saddles Used",
        OPTIONS = { 
 			{STABLES_AVAILABILITY     = {1,2,3,4,5,6,7,8,9,10,11,12}, LABEL = "Used",          	 DESCRIPTION = "A nice piece of tack for your horse",	 DOLLARS =  20.0, GOLD = 0.0, TYPE = 20, TINTA = 10    ,TINTB = 10   , TINTC = 17   , CUSTOMIZABLE = true, CUSTOM_ROLELOCK = false, CUSTOM_ROLES = {""}, CUSTOM_PLAYERLOCK = false, CUSTOM_PLAYERS = {""}, ROLELOCK = false, ROLES = {"none"}, PLAYERLOCK = false, PLAYERS = {""}, image = "items/generic_horse_equip_saddle.png"},	
        },
    },
	
-- MCCLELLAN SADDLES	 
 
    [6] = {
        NAME = "Mclellan Improved",
        OPTIONS = {
 			{STABLES_AVAILABILITY     = {1,2,3,4,5,6,7,8,9,10,11,12}, LABEL = "Improved I", 		 DESCRIPTION = "A nice piece of tack for your horse",	 DOLLARS =  40.0, GOLD = 0.0, TYPE = 21, TINTA = 36    ,TINTB = 7   , TINTC = 66   , CUSTOMIZABLE = true, CUSTOM_ROLELOCK = false, CUSTOM_ROLES = {""}, CUSTOM_PLAYERLOCK = false, CUSTOM_PLAYERS = {""}, ROLELOCK = false, ROLES = {"none"}, PLAYERLOCK = false, PLAYERS = {""}, image = "items/generic_horse_equip_saddle.png"},	
  			},
 		},	
    [7] = {
        NAME = "Mclellan New",
        OPTIONS = {
 			{STABLES_AVAILABILITY     = {1,2,3,4,5,6,7,8,9,10,11,12}, LABEL = "New",       		 DESCRIPTION = "A nice piece of tack for your horse",	 DOLLARS =  30.0, GOLD = 0.0, TYPE = 22, TINTA = 8    ,TINTB = 9   , TINTC = 6   , CUSTOMIZABLE = true, CUSTOM_ROLELOCK = false, CUSTOM_ROLES = {""}, CUSTOM_PLAYERLOCK = false, CUSTOM_PLAYERS = {""}, ROLELOCK = false, ROLES = {"none"}, PLAYERLOCK = false, PLAYERS = {""}, image = "items/generic_horse_equip_saddle.png"},	
 			},
 		},			
    [8] = {
        NAME = "Mclellan Used",
        OPTIONS = {
  			{STABLES_AVAILABILITY     = {1,2,3,4,5,6,7,8,9,10,11,12}, LABEL = "Used",       		 DESCRIPTION = "A nice piece of tack for your horse",	 DOLLARS =  30.0, GOLD = 0.0, TYPE = 23, TINTA = 10    ,TINTB = 10   , TINTC = 10   , CUSTOMIZABLE = true, CUSTOM_ROLELOCK = false, CUSTOM_ROLES = {""}, CUSTOM_PLAYERLOCK = false, CUSTOM_PLAYERS = {""}, ROLELOCK = false, ROLES = {"none"}, PLAYERLOCK = false, PLAYERS = {""}, image = "items/generic_horse_equip_saddle.png"},	
 			},
 		},
		
 -- MOTHER HUBARD SADDLES
    [9] = {
        NAME = "Mother Hubbard Improved",
        OPTIONS = {
			{STABLES_AVAILABILITY     = {1,2,3,4,5,6,7,8,9,10,11,12}, LABEL = "Improved",  		 DESCRIPTION = "A nice piece of tack for your horse",	 DOLLARS =  40.0, GOLD = 0.0, TYPE = 24, TINTA = 10   ,TINTB = 14   , TINTC = 15   , CUSTOMIZABLE = true, CUSTOM_ROLELOCK = false, CUSTOM_ROLES = {""}, CUSTOM_PLAYERLOCK = false, CUSTOM_PLAYERS = {""}, ROLELOCK = false, ROLES = {"none"}, PLAYERLOCK = false, PLAYERS = {""}, image = "items/generic_horse_equip_saddle.png"},		
        },
    },
    [10] = {
        NAME = "Mother Hubbard New",
        OPTIONS = {
			{STABLES_AVAILABILITY     = {1,2,3,4,5,6,7,8,9,10,11,12}, LABEL = "New",  		 		 DESCRIPTION = "A nice piece of tack for your horse",    DOLLARS =  30.0, GOLD = 0.0, TYPE = 25, TINTA = 10   ,TINTB = 14   , TINTC = 15   , CUSTOMIZABLE = true, CUSTOM_ROLELOCK = false, CUSTOM_ROLES = {""}, CUSTOM_PLAYERLOCK = false, CUSTOM_PLAYERS = {""}, ROLELOCK = false, ROLES = {"none"}, PLAYERLOCK = false, PLAYERS = {""}, image = "items/generic_horse_equip_saddle.png"},		
 			
        },
    },	
    [11] = {
        NAME = "Mother Hubbard Used",
        OPTIONS = {
			{STABLES_AVAILABILITY     = {1,2,3,4,5,6,7,8,9,10,11,12}, LABEL = "Used",   			 DESCRIPTION = "A nice piece of tack for your horse",  	 DOLLARS =  22.0, GOLD = 0.0, TYPE = 26, TINTA = 10   ,TINTB = 14   , TINTC = 15   , CUSTOMIZABLE = true, CUSTOM_ROLELOCK = false, CUSTOM_ROLES = {""}, CUSTOM_PLAYERLOCK = false, CUSTOM_PLAYERS = {""}, ROLELOCK = false, ROLES = {"none"}, PLAYERLOCK = false, PLAYERS = {""}, image = "items/generic_horse_equip_saddle.png"},			
        },
    },		
	
 -- ROPPING SADDLES SADDLES 
    [12] = {
        NAME = "Roping Saddles Improved",
        OPTIONS = {
 			{STABLES_AVAILABILITY     = {1,2,3,4,5,6,7,8,9,10,11,12}, LABEL = "Improved",  		 DESCRIPTION = "A nice piece of tack for your horse", 	 DOLLARS =  40.0, GOLD = 0.0, TYPE = 27, TINTA = 42   ,TINTB = 42   , TINTC = 42, CUSTOMIZABLE = true, CUSTOM_ROLELOCK = false, CUSTOM_ROLES = {""}, CUSTOM_PLAYERLOCK = false, CUSTOM_PLAYERS = {""}, ROLELOCK = false, ROLES = {"none"}, PLAYERLOCK = false, PLAYERS = {""}, image = "items/generic_horse_equip_saddle.png"},	
        },
    },
 
    [13] = {
        NAME = "Roping Saddles New",
        OPTIONS = {
  			{STABLES_AVAILABILITY     = {1,2,3,4,5,6,7,8,9,10,11,12}, LABEL = "New",  				 DESCRIPTION = "A nice piece of tack for your horse",	  DOLLARS =  30.0, GOLD = 0.0, TYPE = 28, TINTA = 42   ,TINTB = 42   , TINTC = 42, CUSTOMIZABLE = true, CUSTOM_ROLELOCK = false, CUSTOM_ROLES = {""}, CUSTOM_PLAYERLOCK = false, CUSTOM_PLAYERS = {""}, ROLELOCK = false, ROLES = {"none"}, PLAYERLOCK = false, PLAYERS = {""}, image = "items/generic_horse_equip_saddle.png"},	
        },
    },
 
    [14] = {
        NAME = "Roping Saddles Used",
        OPTIONS = {
  			{STABLES_AVAILABILITY     = {1,2,3,4,5,6,7,8,9,10,11,12}, LABEL = "Used", 				 DESCRIPTION = "A nice piece of tack for your horse", 	  DOLLARS =  20.0, GOLD = 0.0, TYPE = 29, TINTA = 42   ,TINTB = 42   , TINTC = 42, CUSTOMIZABLE = true, CUSTOM_ROLELOCK = false, CUSTOM_ROLES = {""}, CUSTOM_PLAYERLOCK = false, CUSTOM_PLAYERS = {""}, ROLELOCK = false, ROLES = {"none"}, PLAYERLOCK = false, PLAYERS = {""}, image = "items/generic_horse_equip_saddle.png"},
 		},
 	},	
	
  -- CUTTING SADDLES SADDLES  
    [15] = {
        NAME = "Cutting Saddles Improved",
        OPTIONS = {
  			{STABLES_AVAILABILITY     = {1,2,3,4,5,6,7,8,9,10,11,12}, LABEL = "Improved",  		 DESCRIPTION = "A nice piece of tack for your horse",	  DOLLARS =  40.0, GOLD = 0.0, TYPE = 30, TINTA = 10   ,TINTB = 10   , TINTC = 10, CUSTOMIZABLE = true, CUSTOM_ROLELOCK = false, CUSTOM_ROLES = {""}, CUSTOM_PLAYERLOCK = false, CUSTOM_PLAYERS = {""}, ROLELOCK = false, ROLES = {"none"}, PLAYERLOCK = false, PLAYERS = {""}, image = "items/generic_horse_equip_saddle.png"},
 		},
 	},
    [16] = {
        NAME = "Cutting Saddles New",
        OPTIONS = {
  			{STABLES_AVAILABILITY     = {1,2,3,4,5,6,7,8,9,10,11,12}, LABEL = "New",  				 DESCRIPTION = "A nice piece of tack for your horse", 	  DOLLARS =  40.0, GOLD = 0.0, TYPE = 31, TINTA = 10   ,TINTB = 10   , TINTC = 10, CUSTOMIZABLE = true, CUSTOM_ROLELOCK = false, CUSTOM_ROLES = {""}, CUSTOM_PLAYERLOCK = false, CUSTOM_PLAYERS = {""}, ROLELOCK = false, ROLES = {"none"}, PLAYERLOCK = false, PLAYERS = {""}, image = "items/generic_horse_equip_saddle.png"},	
 		},
 	}, 
    [17] = {
        NAME = "Cutting Saddles Used",
        OPTIONS = {
  			{STABLES_AVAILABILITY     = {1,2,3,4,5,6,7,8,9,10,11,12}, LABEL = "Used",  			 DESCRIPTION = "A nice piece of tack for your horse",	  DOLLARS =  40.0, GOLD = 0.0, TYPE = 32, TINTA = 10   ,TINTB = 10   , TINTC = 10, CUSTOMIZABLE = true, CUSTOM_ROLELOCK = false, CUSTOM_ROLES = {""}, CUSTOM_PLAYERLOCK = false, CUSTOM_PLAYERS = {""}, ROLELOCK = false, ROLES = {"none"}, PLAYERLOCK = false, PLAYERS = {""}, image = "items/generic_horse_equip_saddle.png"},	 
        },
    },
	
	-- ALL AROUND SADDLES  
    [18] = {
        NAME = "All Around Saddles Improved",
        OPTIONS = {
  			{STABLES_AVAILABILITY     = {1,2,3,4,5,6,7,8,9,10,11,12}, LABEL = "Improved",  		 DESCRIPTION = "A nice piece of tack for your horse",	   DOLLARS =  40.0, GOLD = 0.0, TYPE = 33, TINTA = 17   ,TINTB = 13   , TINTC = 13, CUSTOMIZABLE = true, CUSTOM_ROLELOCK = false, CUSTOM_ROLES = {""}, CUSTOM_PLAYERLOCK = false, CUSTOM_PLAYERS = {""}, ROLELOCK = false, ROLES = {"none"}, PLAYERLOCK = false, PLAYERS = {""}, image = "items/generic_horse_equip_saddle.png"},	 
        },
    },
    [19] = {
        NAME = "All Around Saddles New",
        OPTIONS = {
  			{STABLES_AVAILABILITY     = {1,2,3,4,5,6,7,8,9,10,11,12}, LABEL = "New", 			 	 DESCRIPTION = "A nice piece of tack for your horse",	    DOLLARS =  30.0, GOLD = 0.0, TYPE = 34, TINTA = 17   ,TINTB = 13   , TINTC = 13, CUSTOMIZABLE = true, CUSTOM_ROLELOCK = false, CUSTOM_ROLES = {""}, CUSTOM_PLAYERLOCK = false, CUSTOM_PLAYERS = {""}, ROLELOCK = false, ROLES = {"none"}, PLAYERLOCK = false, PLAYERS = {""}, image = "items/generic_horse_equip_saddle.png"},	
        },
    },
	
    [20] = {
        NAME = "All Around Saddles Used",
        OPTIONS = {
  			{STABLES_AVAILABILITY     = {1,2,3,4,5,6,7,8,9,10,11,12}, LABEL = "Used",  			 DESCRIPTION = "A nice piece of tack for your horse", 		DOLLARS =  20.0, GOLD = 0.0, TYPE = 35, TINTA = 17   ,TINTB = 13   , TINTC = 13, CUSTOMIZABLE = true, CUSTOM_ROLELOCK = false, CUSTOM_ROLES = {""}, CUSTOM_PLAYERLOCK = false, CUSTOM_PLAYERS = {""}, ROLELOCK = false, ROLES = {"none"}, PLAYERLOCK = false, PLAYERS = {""}, image = "items/generic_horse_equip_saddle.png"},			
        },
    },	
	
	-- TRAIL SADDLES SADDLES 
    [21] = {
        NAME = "Trail Saddles Improved",
        OPTIONS = {
  			{STABLES_AVAILABILITY     = {1,2,3,4,5,6,7,8,9,10,11,12}, LABEL = "Improved",  		DESCRIPTION = "A nice piece of tack for your horse", 		DOLLARS =  40.0, GOLD = 0.0, TYPE = 36, TINTA = 10   ,TINTB = 10   , TINTC = 10, CUSTOMIZABLE = true, CUSTOM_ROLELOCK = false, CUSTOM_ROLES = {""}, CUSTOM_PLAYERLOCK = false, CUSTOM_PLAYERS = {""}, ROLELOCK = false, ROLES = {"none"}, PLAYERLOCK = false, PLAYERS = {""}, image = "items/generic_horse_equip_saddle.png"},		
        },
    },	
	
    [22] = {
        NAME = "Trail Saddles New",
        OPTIONS = {
  			{STABLES_AVAILABILITY     = {1,2,3,4,5,6,7,8,9,10,11,12}, LABEL = "New",  				DESCRIPTION = "A nice piece of tack for your horse",		DOLLARS =  30.0, GOLD = 0.0, TYPE = 37, TINTA = 10   ,TINTB = 10   , TINTC = 10, CUSTOMIZABLE = true, CUSTOM_ROLELOCK = false, CUSTOM_ROLES = {""}, CUSTOM_PLAYERLOCK = false, CUSTOM_PLAYERS = {""}, ROLELOCK = false, ROLES = {"none"}, PLAYERLOCK = false, PLAYERS = {""}, image = "items/generic_horse_equip_saddle.png"},	
 
        },
    },	
	
    [23] = {
        NAME = "Trail Saddles Used",
        OPTIONS = {
  			{STABLES_AVAILABILITY     = {1,2,3,4,5,6,7,8,9,10,11,12}, LABEL = "Used", 				DESCRIPTION = "A nice piece of tack for your horse",	    DOLLARS =  30.0, GOLD = 0.0, TYPE = 38, TINTA = 10   ,TINTB = 10   , TINTC = 10, CUSTOMIZABLE = true, CUSTOM_ROLELOCK = false, CUSTOM_ROLES = {""}, CUSTOM_PLAYERLOCK = false, CUSTOM_PLAYERS = {""}, ROLELOCK = false, ROLES = {"none"}, PLAYERLOCK = false, PLAYERS = {""}, image = "items/generic_horse_equip_saddle.png"},	
        },
    },
    [24] = {
        NAME = "Trader",
        OPTIONS = {
  			{STABLES_AVAILABILITY     = {1,2,3,4,5,6,7,8,9,10,11,12}, LABEL = "Trader", 		   DESCRIPTION = "A nice piece of tack for your horse",	    DOLLARS =  30.0, GOLD = 0.0, TYPE = 39, TINTA = 10   ,TINTB = 10   , TINTC = 10, CUSTOMIZABLE = false, CUSTOM_ROLELOCK = false, CUSTOM_ROLES = {""}, CUSTOM_PLAYERLOCK = false, CUSTOM_PLAYERS = {""}, ROLELOCK = false, ROLES = {"none"}, PLAYERLOCK = false, PLAYERS = {""}, image = "items/generic_horse_equip_saddle.png"},	
        },
    },	
    [25] = {
        NAME = "Foxmore",
        OPTIONS = {
  			{STABLES_AVAILABILITY     = {1,2,3,4,5,6,7,8,9,10,11,12}, LABEL = "Foxmore", 		   DESCRIPTION = "A nice piece of tack for your horse",	    DOLLARS =  30.0, GOLD = 0.0, TYPE = 40, TINTA = 0   ,TINTB = 0   , TINTC = 0, CUSTOMIZABLE = false, CUSTOM_ROLELOCK = false, CUSTOM_ROLES = {""}, CUSTOM_PLAYERLOCK = false, CUSTOM_PLAYERS = {""}, ROLELOCK = false, ROLES = {"none"}, PLAYERLOCK = false, PLAYERS = {""}, image = "items/generic_horse_equip_saddle.png"},	
        },
    },
    [26] = {
        NAME = "Collector",
        OPTIONS = {
  			{STABLES_AVAILABILITY     = {1,2,3,4,5,6,7,8,9,10,11,12}, LABEL = "Collector", 		   DESCRIPTION = "A nice piece of tack for your horse",	    DOLLARS =  30.0, GOLD = 0.0, TYPE = 41, TINTA = 0   ,TINTB = 0   , TINTC = 0, CUSTOMIZABLE = false, CUSTOM_ROLELOCK = false, CUSTOM_ROLES = {""}, CUSTOM_PLAYERLOCK = false, CUSTOM_PLAYERS = {""}, ROLELOCK = false, ROLES = {"none"}, PLAYERLOCK = false, PLAYERS = {""}, image = "items/generic_horse_equip_saddle.png"},	
        },
    },
	
    [27] = {
        NAME = "Big Valley Doublefork",
        OPTIONS = {
  			{STABLES_AVAILABILITY     = {1,2,3,4,5,6,7,8,9,10,11,12}, LABEL = "Big Valley Doublefork",  DESCRIPTION = "A nice piece of tack for your horse",	    DOLLARS =  30.0, GOLD = 0.0, TYPE = 42, TINTA = 0   ,TINTB = 0   , TINTC = 0, CUSTOMIZABLE = false, CUSTOM_ROLELOCK = false, CUSTOM_ROLES = {""}, CUSTOM_PLAYERLOCK = false, CUSTOM_PLAYERS = {""}, ROLELOCK = false, ROLES = {"none"}, PLAYERLOCK = false, PLAYERS = {""}, image = "items/generic_horse_equip_saddle.png"},	
        },
    },
	
    [28] = {
        NAME = "The Valentine",
        OPTIONS = {
  			{STABLES_AVAILABILITY     = {1,2,3,4,5,6,7,8,9,10,11,12}, LABEL = "The Valentine",  DESCRIPTION = "A nice piece of tack for your horse",	    DOLLARS =  30.0, GOLD = 0.0, TYPE = 43, TINTA = 252, TINTB = 204, TINTC = 244, CUSTOMIZABLE = false, CUSTOM_ROLELOCK = false, CUSTOM_ROLES = {""}, CUSTOM_PLAYERLOCK = false, CUSTOM_PLAYERS = {""}, ROLELOCK = false, ROLES = {"none"}, PLAYERLOCK = false, PLAYERS = {""}, image = "items/generic_horse_equip_saddle.png"},	
        },
    },


    [29] = {
        NAME = "Nacogdoches",
        OPTIONS = {
  			{STABLES_AVAILABILITY     = {1,2,3,4,5,6,7,8,9,10,11,12}, LABEL = "Nacogdoches #1",  DESCRIPTION = "A nice piece of tack for your horse",	    DOLLARS =  30.0, GOLD = 0.0, TYPE = 44, TINTA = 0, TINTB = 0, TINTC = 0, CUSTOMIZABLE = false, CUSTOM_ROLELOCK = false, CUSTOM_ROLES = {""}, CUSTOM_PLAYERLOCK = false, CUSTOM_PLAYERS = {""}, ROLELOCK = false, ROLES = {"none"}, PLAYERLOCK = false, PLAYERS = {""}, image = "items/generic_horse_equip_saddle.png"},	
  			{STABLES_AVAILABILITY     = {1,2,3,4,5,6,7,8,9,10,11,12}, LABEL = "Nacogdoches #2",  DESCRIPTION = "A nice piece of tack for your horse",	    DOLLARS =  30.0, GOLD = 0.0, TYPE = 46, TINTA = 0, TINTB = 0, TINTC = 0, CUSTOMIZABLE = false, CUSTOM_ROLELOCK = false, CUSTOM_ROLES = {""}, CUSTOM_PLAYERLOCK = false, CUSTOM_PLAYERS = {""}, ROLELOCK = false, ROLES = {"none"}, PLAYERLOCK = false, PLAYERS = {""}, image = "items/generic_horse_equip_saddle.png"},	
  			{STABLES_AVAILABILITY     = {1,2,3,4,5,6,7,8,9,10,11,12}, LABEL = "Nacogdoches #3",  DESCRIPTION = "A nice piece of tack for your horse",	    DOLLARS =  30.0, GOLD = 0.0, TYPE = 47, TINTA = 0, TINTB = 0, TINTC = 0, CUSTOMIZABLE = false, CUSTOM_ROLELOCK = false, CUSTOM_ROLES = {""}, CUSTOM_PLAYERLOCK = false, CUSTOM_PLAYERS = {""}, ROLELOCK = false, ROLES = {"none"}, PLAYERLOCK = false, PLAYERS = {""}, image = "items/generic_horse_equip_saddle.png"},	
  			{STABLES_AVAILABILITY     = {1,2,3,4,5,6,7,8,9,10,11,12}, LABEL = "Nacogdoches #4",  DESCRIPTION = "A nice piece of tack for your horse",	    DOLLARS =  30.0, GOLD = 0.0, TYPE = 49, TINTA = 0, TINTB = 0, TINTC = 0, CUSTOMIZABLE = false, CUSTOM_ROLELOCK = false, CUSTOM_ROLES = {""}, CUSTOM_PLAYERLOCK = false, CUSTOM_PLAYERS = {""}, ROLELOCK = false, ROLES = {"none"}, PLAYERLOCK = false, PLAYERS = {""}, image = "items/generic_horse_equip_saddle.png"},	
  			{STABLES_AVAILABILITY     = {1,2,3,4,5,6,7,8,9,10,11,12}, LABEL = "Nacogdoches #5",  DESCRIPTION = "A nice piece of tack for your horse",	    DOLLARS =  30.0, GOLD = 0.0, TYPE = 50, TINTA = 0, TINTB = 0, TINTC = 0, CUSTOMIZABLE = false, CUSTOM_ROLELOCK = false, CUSTOM_ROLES = {""}, CUSTOM_PLAYERLOCK = false, CUSTOM_PLAYERS = {""}, ROLELOCK = false, ROLES = {"none"}, PLAYERLOCK = false, PLAYERS = {""}, image = "items/generic_horse_equip_saddle.png"},	
  			{STABLES_AVAILABILITY     = {1,2,3,4,5,6,7,8,9,10,11,12}, LABEL = "Nacogdoches #6",  DESCRIPTION = "A nice piece of tack for your horse",	    DOLLARS =  30.0, GOLD = 0.0, TYPE = 51, TINTA = 0, TINTB = 0, TINTC = 0, CUSTOMIZABLE = false, CUSTOM_ROLELOCK = false, CUSTOM_ROLES = {""}, CUSTOM_PLAYERLOCK = false, CUSTOM_PLAYERS = {""}, ROLELOCK = false, ROLES = {"none"}, PLAYERLOCK = false, PLAYERS = {""}, image = "items/generic_horse_equip_saddle.png"},	
        },
    },


    [30] = {
        NAME = "The Blackwater",
        OPTIONS = {
  			{STABLES_AVAILABILITY     = {1,2,3,4,5,6,7,8,9,10,11,12}, LABEL = "The Blackwater",  DESCRIPTION = "A nice piece of tack for your horse",	    DOLLARS =  30.0, GOLD = 0.0, TYPE = 45, TINTA = 0, TINTB = 0, TINTC = 0, CUSTOMIZABLE = false, CUSTOM_ROLELOCK = false, CUSTOM_ROLES = {""}, CUSTOM_PLAYERLOCK = false, CUSTOM_PLAYERS = {""}, ROLELOCK = false, ROLES = {"none"}, PLAYERLOCK = false, PLAYERS = {""}, image = "items/generic_horse_equip_saddle.png"},	
        },
    },
	
    [31] = {
        NAME = "Upland",
        OPTIONS = {
  			{STABLES_AVAILABILITY     = {1,2,3,4,5,6,7,8,9,10,11,12}, LABEL = "Upland",  DESCRIPTION = "A nice piece of tack for your horse",	    DOLLARS =  30.0, GOLD = 0.0, TYPE = 48, TINTA = 0, TINTB = 0, TINTC = 0, CUSTOMIZABLE = false, CUSTOM_ROLELOCK = false, CUSTOM_ROLES = {""}, CUSTOM_PLAYERLOCK = false, CUSTOM_PLAYERS = {""}, ROLELOCK = false, ROLES = {"none"}, PLAYERLOCK = false, PLAYERS = {""}, image = "items/generic_horse_equip_saddle.png"},	
        },
    }, 
 
}

 
--------------------------------
       -- SADDLEBAGS --
--------------------------------

Config.SADDLEBAGS = {

    [1] = {
        NAME = "No Bags",
        OPTIONS = {
		{STABLES_AVAILABILITY     = {1,2,3,4,5,6,7,8,9,10,11,12}, LABEL = "No bags",  			 DESCRIPTION = "Remove that tack piece from your horse",	 	DOLLARS =  0.0, GOLD = 0.0, TYPE = 0, TINTA = 0    ,TINTB = 0     , TINTC = 0,   CUSTOMIZABLE = false, CUSTOM_ROLELOCK = false, CUSTOM_ROLES = {""}, CUSTOM_PLAYERLOCK = false, CUSTOM_PLAYERS = {""}, ROLELOCK = false, ROLES = {"none"}, PLAYERLOCK = false, PLAYERS = {""}, image = "items/generic_horse_equip_saddlebag.png"},	
         },
    },
	
    [2] = {
        NAME = "Bear Bags",
        OPTIONS = {
		{STABLES_AVAILABILITY     = {1,2,3,4,5,6,7,8,9,10,11,12}, LABEL = "Used",  			 DESCRIPTION = "A nice piece of tack for your horse",	 		DOLLARS =  30.0, GOLD = 0.0, TYPE = 1, TINTA = 31    ,TINTB = 2     , TINTC = 9,   CUSTOMIZABLE = true, CUSTOM_ROLELOCK = false, CUSTOM_ROLES = {""}, CUSTOM_PLAYERLOCK = false, CUSTOM_PLAYERS = {""}, ROLELOCK = false, ROLES = {"none"}, PLAYERLOCK = false, PLAYERS = {""}, image = "items/generic_horse_equip_saddlebag.png"},	
         },
    },
	
    [3] = {
        NAME = "Town Bags",
        OPTIONS = {
 		{STABLES_AVAILABILITY     = {1,2,3,4,5,6,7,8,9,10,11,12}, LABEL = "Used", 				DESCRIPTION = "A nice piece of tack for your horse",			 DOLLARS =  30.0, GOLD = 0.0, TYPE = 2, TINTA = 0   ,TINTB = 0   , TINTC = 60, CUSTOMIZABLE = true, CUSTOM_ROLELOCK = false, CUSTOM_ROLES = {""}, CUSTOM_PLAYERLOCK = false, CUSTOM_PLAYERS = {""}, ROLELOCK = false, ROLES = {"none"}, PLAYERLOCK = false, PLAYERS = {""}, image = "items/generic_horse_equip_saddlebag.png"},	
        },
    },
    [4] = {
        NAME = "Wapiti Bags",
        OPTIONS = {
 		{STABLES_AVAILABILITY     = {1,2,3,4,5,6,7,8,9,10,11,12}, LABEL = "Used",  			DESCRIPTION = "A nice piece of tack for your horse",			DOLLARS =  30.0, GOLD = 0.0, TYPE = 3, TINTA = 44   ,TINTB = 199   , TINTC = 44, CUSTOMIZABLE = true, CUSTOM_ROLELOCK = false, CUSTOM_ROLES = {""}, CUSTOM_PLAYERLOCK = false, CUSTOM_PLAYERS = {""}, ROLELOCK = false, ROLES = {"none"}, PLAYERLOCK = false, PLAYERS = {""}, image = "items/generic_horse_equip_saddlebag.png"},			
        },
    },
    [5] = {
        NAME = "Cowboy Bags",
        OPTIONS = {
 		{STABLES_AVAILABILITY     = {1,2,3,4,5,6,7,8,9,10,11,12}, LABEL = "Used",  		    DESCRIPTION = "A nice piece of tack for your horse",			DOLLARS =  30.0, GOLD = 0.0, TYPE = 4, TINTA = 4   ,TINTB = 25   , TINTC = 25, CUSTOMIZABLE = true, CUSTOM_ROLELOCK = false, CUSTOM_ROLES = {""}, CUSTOM_PLAYERLOCK = false, CUSTOM_PLAYERS = {""}, ROLELOCK = false, ROLES = {"none"}, PLAYERLOCK = false, PLAYERS = {""}, image = "items/generic_horse_equip_saddlebag.png"},	 	
        },
    },
    [6] = {
        NAME = "Travel Bags Used",
        OPTIONS = {
 		{STABLES_AVAILABILITY     = {1,2,3,4,5,6,7,8,9,10,11,12}, LABEL = "Used",  			DESCRIPTION = "A nice piece of tack for your horse",			DOLLARS =  30.0, GOLD = 0.0, TYPE = 5, TINTA = 27   ,TINTB = 2     , TINTC = 0,  CUSTOMIZABLE = true, CUSTOM_ROLELOCK = false, CUSTOM_ROLES = {""}, CUSTOM_PLAYERLOCK = false, CUSTOM_PLAYERS = {""}, ROLELOCK = false, ROLES = {"none"}, PLAYERLOCK = false, PLAYERS = {""}, image = "items/generic_horse_equip_saddlebag.png"},	
 		{STABLES_AVAILABILITY     = {1,2,3,4,5,6,7,8,9,10,11,12}, LABEL = "Used Large",    	DESCRIPTION = "A nice piece of tack for your horse",			DOLLARS =  30.0, GOLD = 0.0, TYPE = 6, TINTA = 27   ,TINTB = 0     , TINTC = 0,  CUSTOMIZABLE = true, CUSTOM_ROLELOCK = false, CUSTOM_ROLES = {""}, CUSTOM_PLAYERLOCK = false, CUSTOM_PLAYERS = {""}, ROLELOCK = false, ROLES = {"none"}, PLAYERLOCK = false, PLAYERS = {""}, image = "items/generic_horse_equip_saddlebag.png"},	
        },
    },
    [7] = {
        NAME = "Raccoon Bags",
        OPTIONS = {
  		{STABLES_AVAILABILITY     = {1,2,3,4,5,6,7,8,9,10,11,12}, LABEL = "Used",  			DESCRIPTION = "A nice piece of tack for your horse",			DOLLARS =  30.0, GOLD = 0.0, TYPE = 7, TINTA = 128   ,TINTB = 138    , TINTC = 189,  CUSTOMIZABLE = true, CUSTOM_ROLELOCK = false, CUSTOM_ROLES = {""}, CUSTOM_PLAYERLOCK = false, CUSTOM_PLAYERS = {""}, ROLELOCK = false, ROLES = {"none"}, PLAYERLOCK = false, PLAYERS = {""}, image = "items/generic_horse_equip_saddlebag.png"},		
        },
    },
    [8] = {
        NAME = "Adventurer Travel Bags",
        OPTIONS = {
  		{STABLES_AVAILABILITY     = {1,2,3,4,5,6,7,8,9,10,11,12}, LABEL = "Adventurer Travel Bag",   DESCRIPTION = "A nice piece of tack for your horse",		DOLLARS =  30.0, GOLD = 0.0, TYPE = 8, TINTA = 25   ,TINTB = 0    , TINTC = 0,  CUSTOMIZABLE = true, CUSTOM_ROLELOCK = false, CUSTOM_ROLES = {""}, CUSTOM_PLAYERLOCK = false, CUSTOM_PLAYERS = {""}, ROLELOCK = false, ROLES = {"none"}, PLAYERLOCK = false, PLAYERS = {""}, image = "items/generic_horse_equip_saddlebag.png"},				
        },
    },
    [9] = {
        NAME = "Mexican Bags",
        OPTIONS = {
  		{STABLES_AVAILABILITY     = {1,2,3,4,5,6,7,8,9,10,11,12}, LABEL = "Adventurer Travel Bag",   DESCRIPTION = "A nice piece of tack for your horse",		 DOLLARS =  30.0, GOLD = 0.0, TYPE = 9, TINTA = 118   ,TINTB = 0    , TINTC = 86,  CUSTOMIZABLE = true, CUSTOM_ROLELOCK = false, CUSTOM_ROLES = {""}, CUSTOM_PLAYERLOCK = false, CUSTOM_PLAYERS = {""}, ROLELOCK = false, ROLES = {"none"}, PLAYERLOCK = false, PLAYERS = {""}, image = "items/generic_horse_equip_saddlebag.png"},				
 
        },
    },
    [10] = {
        NAME = "Bounty Hunter Bags",
        OPTIONS = {
  		{STABLES_AVAILABILITY     = {1,2,3,4,5,6,7,8,9,10,11,12}, LABEL = "Bounty Hunter Bag",  	  DESCRIPTION = "A nice piece of tack for your horse",		 DOLLARS =  30.0, GOLD = 0.0, TYPE = 10, TINTA = 0   ,TINTB = 0    , TINTC = 0,  CUSTOMIZABLE = true, CUSTOM_ROLELOCK = false, CUSTOM_ROLES = {""}, CUSTOM_PLAYERLOCK = false, CUSTOM_PLAYERS = {""}, ROLELOCK = false, ROLES = {"none"}, PLAYERLOCK = false, PLAYERS = {""}, image = "items/generic_horse_equip_saddlebag.png"},	-- TINT CANT BE CHANGED 
        },
    },	
}
 
--------------------------------
	 --  STIRRUPS --
--------------------------------
-- KEEP IN MIND SOME SADDLE STIRRUPS CANT BE REMOVED AS THEY'RE PART OF THE SADDLE MODEL ITSELF 

Config.STIRRUPS = {
    [1] = {
        NAME = "No Stirrups",
        OPTIONS = {
  		{STABLES_AVAILABILITY     = {1,2,3,4,5,6,7,8,9,10,11,12}, LABEL = "No Stirrups", 			DESCRIPTION = "Remove that tack piece from your horse",	   DOLLARS =  0.0, GOLD = 0.0, TYPE = 0, TINTA = 0   ,TINTB = 0    , TINTC = 0,  CUSTOMIZABLE = false, CUSTOM_ROLELOCK = false, CUSTOM_ROLES = {""}, CUSTOM_PLAYERLOCK = false, CUSTOM_PLAYERS = {""}, ROLELOCK = false, ROLES = {"none"}, PLAYERLOCK = false, PLAYERS = {""}, image = "items/generic_horse_equip_stirrup.png"}, 	 
        },
    },
    [2] = {
        NAME = "Basic Iron",
        OPTIONS = {
  		{STABLES_AVAILABILITY     = {1,2,3,4,5,6,7,8,9,10,11,12}, LABEL = "Basic Iron", 			DESCRIPTION = "A nice piece of tack for your horse",	   DOLLARS =  30.0, GOLD = 0.0, TYPE = 1, TINTA = 172   ,TINTB = 197    , TINTC = 125,  CUSTOMIZABLE = false, CUSTOM_ROLELOCK = false, CUSTOM_ROLES = {""}, CUSTOM_PLAYERLOCK = false, CUSTOM_PLAYERS = {""}, ROLELOCK = false, ROLES = {"none"}, PLAYERLOCK = false, PLAYERS = {""}, image = "items/generic_horse_equip_stirrup.png"}, 	 
        },
    },
    [3] = {
        NAME = "Thin Iron",
        OPTIONS = {
   		{STABLES_AVAILABILITY     = {1,2,3,4,5,6,7,8,9,10,11,12}, LABEL = "Thin Iron",  		    DESCRIPTION = "A nice piece of tack for your horse",		DOLLARS =  30.0, GOLD = 0.0, TYPE = 2, TINTA = 61   ,TINTB = 254    , TINTC = 67,  CUSTOMIZABLE = true, CUSTOM_ROLELOCK = false, CUSTOM_ROLES = {""}, CUSTOM_PLAYERLOCK = false, CUSTOM_PLAYERS = {""}, ROLELOCK = false, ROLES = {"none"}, PLAYERLOCK = false, PLAYERS = {""}, image = "items/generic_horse_equip_stirrup.png"}, 	
        },
    },
    [4] = {
        NAME = "Used Iron",
        OPTIONS = {
   		{STABLES_AVAILABILITY     = {1,2,3,4,5,6,7,8,9,10,11,12}, LABEL = "Used Iron",  			DESCRIPTION = "A nice piece of tack for your horse",		DOLLARS =  20.0, GOLD = 0.0, TYPE = 3, TINTA = 19   ,TINTB = 3    , TINTC = 18,  CUSTOMIZABLE = false, CUSTOM_ROLELOCK = false, CUSTOM_ROLES = {""}, CUSTOM_PLAYERLOCK = false, CUSTOM_PLAYERS = {""}, ROLELOCK = false, ROLES = {"none"}, PLAYERLOCK = false, PLAYERS = {""}, image = "items/generic_horse_equip_stirrup.png"}, 	 
        },
    },
    [5] = {
        NAME = "Oval Iron",
        OPTIONS = {
   		{STABLES_AVAILABILITY     = {1,2,3,4,5,6,7,8,9,10,11,12}, LABEL = "Oval Iron",  			DESCRIPTION = "A nice piece of tack for your horse",		DOLLARS =  20.0, GOLD = 0.0, TYPE = 4, TINTA = 134   ,TINTB = 239    , TINTC = 13,  CUSTOMIZABLE = false, CUSTOM_ROLELOCK = false, CUSTOM_ROLES = {""}, CUSTOM_PLAYERLOCK = false, CUSTOM_PLAYERS = {""}, ROLELOCK = false, ROLES = {"none"}, PLAYERLOCK = false, PLAYERS = {""}, image = "items/generic_horse_equip_stirrup.png"}, 	
        },
    },
    [6] = {
        NAME = "Stirrups Specials",
        OPTIONS = {
   		{STABLES_AVAILABILITY     = {1,2,3,4,5,6,7,8,9,10,11,12}, LABEL = "Western Style I",   	DESCRIPTION = "A nice piece of tack for your horse",		DOLLARS =  20.0, GOLD = 0.0, TYPE = 5,  TINTA = 11    ,TINTB = 17   , TINTC = 22,   CUSTOMIZABLE = true, CUSTOM_ROLELOCK = false, CUSTOM_ROLES = {""}, CUSTOM_PLAYERLOCK = false, CUSTOM_PLAYERS = {""}, ROLELOCK = false, ROLES = {"none"}, PLAYERLOCK = false, PLAYERS = {""}, image = "items/generic_horse_equip_stirrup.png"}, 	
		{STABLES_AVAILABILITY     = {1,2,3,4,5,6,7,8,9,10,11,12}, LABEL = "Western Style II",  	DESCRIPTION = "A nice piece of tack for your horse",		DOLLARS =  20.0, GOLD = 0.0, TYPE = 6,  TINTA = 11    ,TINTB = 17   , TINTC = 22,   CUSTOMIZABLE = true, CUSTOM_ROLELOCK = false, CUSTOM_ROLES = {""}, CUSTOM_PLAYERLOCK = false, CUSTOM_PLAYERS = {""}, ROLELOCK = false, ROLES = {"none"}, PLAYERLOCK = false, PLAYERS = {""}, image = "items/generic_horse_equip_stirrup.png"},
		{STABLES_AVAILABILITY     = {1,2,3,4,5,6,7,8,9,10,11,12}, LABEL = "Western Style III", 	DESCRIPTION = "A nice piece of tack for your horse",		DOLLARS =  20.0, GOLD = 0.0, TYPE = 7,  TINTA = 8     ,TINTB = 9    , TINTC = 9,    CUSTOMIZABLE = true, CUSTOM_ROLELOCK = false, CUSTOM_ROLES = {""}, CUSTOM_PLAYERLOCK = false, CUSTOM_PLAYERS = {""}, ROLELOCK = false, ROLES = {"none"}, PLAYERLOCK = false, PLAYERS = {""}, image = "items/generic_horse_equip_stirrup.png"},
		{STABLES_AVAILABILITY     = {1,2,3,4,5,6,7,8,9,10,11,12}, LABEL = "Western Style IV",  	DESCRIPTION = "A nice piece of tack for your horse",		DOLLARS =  20.0, GOLD = 0.0, TYPE = 8,  TINTA = 254   ,TINTB = 7    , TINTC = 110,  CUSTOMIZABLE = true, CUSTOM_ROLELOCK = false, CUSTOM_ROLES = {""}, CUSTOM_PLAYERLOCK = false, CUSTOM_PLAYERS = {""}, ROLELOCK = false, ROLES = {"none"}, PLAYERLOCK = false, PLAYERS = {""}, image = "items/generic_horse_equip_stirrup.png"},
 		{STABLES_AVAILABILITY     = {1,2,3,4,5,6,7,8,9,10,11,12}, LABEL = "Safety I", 		    DESCRIPTION = "A nice piece of tack for your horse",		DOLLARS =  20.0, GOLD = 0.0, TYPE = 9,  TINTA = 0     ,TINTB = 0    , TINTC = 7,    CUSTOMIZABLE = true, CUSTOM_ROLELOCK = false, CUSTOM_ROLES = {""}, CUSTOM_PLAYERLOCK = false, CUSTOM_PLAYERS = {""}, ROLELOCK = false, ROLES = {"none"}, PLAYERLOCK = false, PLAYERS = {""}, image = "items/generic_horse_equip_stirrup.png"}, 
		{STABLES_AVAILABILITY     = {1,2,3,4,5,6,7,8,9,10,11,12}, LABEL = "Slipper I", 			DESCRIPTION = "A nice piece of tack for your horse",		DOLLARS =  20.0, GOLD = 0.0, TYPE = 10, TINTA = 11    ,TINTB = 17   , TINTC = 22,   CUSTOMIZABLE = true, CUSTOM_ROLELOCK = false, CUSTOM_ROLES = {""}, CUSTOM_PLAYERLOCK = false, CUSTOM_PLAYERS = {""}, ROLELOCK = false, ROLES = {"none"}, PLAYERLOCK = false, PLAYERS = {""}, image = "items/generic_horse_equip_stirrup.png"},
		{STABLES_AVAILABILITY     = {1,2,3,4,5,6,7,8,9,10,11,12}, LABEL = "Caged I", 		    DESCRIPTION = "A nice piece of tack for your horse",		DOLLARS =  20.0, GOLD = 0.0, TYPE = 11, TINTA = 254   ,TINTB = 7    , TINTC = 110,  CUSTOMIZABLE = true, CUSTOM_ROLELOCK = false, CUSTOM_ROLES = {""}, CUSTOM_PLAYERLOCK = false, CUSTOM_PLAYERS = {""}, ROLELOCK = false, ROLES = {"none"}, PLAYERLOCK = false, PLAYERS = {""}, image = "items/generic_horse_equip_stirrup.png"},
		{STABLES_AVAILABILITY     = {1,2,3,4,5,6,7,8,9,10,11,12}, LABEL = "Upland",   		    DESCRIPTION = "A nice piece of tack for your horse",		DOLLARS =  20.0, GOLD = 0.0, TYPE = 12, TINTA = 254   ,TINTB = 7    , TINTC = 110,  CUSTOMIZABLE = true, CUSTOM_ROLELOCK = false, CUSTOM_ROLES = {""}, CUSTOM_PLAYERLOCK = false, CUSTOM_PLAYERS = {""}, ROLELOCK = false, ROLES = {"none"}, PLAYERLOCK = false, PLAYERS = {""}, image = "items/generic_horse_equip_stirrup.png"},
        },
    },
}

--------------------------------
       -- BEDROLLS--
--------------------------------
Config.BEDROLLS = {

    [1] = {NAME = "No Bedroll",
        OPTIONS =  {
		{STABLES_AVAILABILITY     = {1,2,3,4,5,6,7,8,9,10,11,12}, LABEL = "No Bedroll",   		 DESCRIPTION = "Remove that tack piece from your horse",		DOLLARS =  0.0, GOLD = 0.0, TYPE = 0, TINTA = 0   ,TINTB = 0    , TINTC = 0,  CUSTOMIZABLE = false, CUSTOM_ROLELOCK = false, CUSTOM_ROLES = {""}, CUSTOM_PLAYERLOCK = false, CUSTOM_PLAYERS = {""}, ROLELOCK = false, ROLES = {"none"}, PLAYERLOCK = false, PLAYERS = {""}, image = "items/generic_horse_equip_bedroll.png"},
        },
    },
	
    [2] = {NAME = "Simple New",
        OPTIONS =  {
		{STABLES_AVAILABILITY     = {1,2,3,4,5,6,7,8,9,10,11,12}, LABEL = "Simple New",   		 DESCRIPTION = "A nice piece of tack for your horse",			DOLLARS =  20.0, GOLD = 0.0, TYPE = 1, TINTA = 150   ,TINTB = 150    , TINTC = 150,  CUSTOMIZABLE = true, CUSTOM_ROLELOCK = false, CUSTOM_ROLES = {""}, CUSTOM_PLAYERLOCK = false, CUSTOM_PLAYERS = {""}, ROLELOCK = false, ROLES = {"none"}, PLAYERLOCK = false, PLAYERS = {""}, image = "items/generic_horse_equip_bedroll.png"},
        },
    },
    [3] = {
        NAME = "Simple Used",
        OPTIONS =  {
 		{STABLES_AVAILABILITY     = {1,2,3,4,5,6,7,8,9,10,11,12}, LABEL = "Simple Used",   	DESCRIPTION = "A nice piece of tack for your horse",			DOLLARS =  20.0, GOLD = 0.0, TYPE = 2, TINTA = 243   ,TINTB = 214    , TINTC = 112,  CUSTOMIZABLE = true, CUSTOM_ROLELOCK = false, CUSTOM_ROLES = {""}, CUSTOM_PLAYERLOCK = false, CUSTOM_PLAYERS = {""}, ROLELOCK = false, ROLES = {"none"}, PLAYERLOCK = false, PLAYERS = {""}, image = "items/generic_horse_equip_bedroll.png"},
        },
    },
    [4] = {
        NAME = "Adventurer New",
        OPTIONS =  {
 		{STABLES_AVAILABILITY     = {1,2,3,4,5,6,7,8,9,10,11,12}, LABEL = "Adventurer New",   	DESCRIPTION = "A nice piece of tack for your horse",			DOLLARS =  20.0, GOLD = 0.0, TYPE = 3, TINTA = 163   ,TINTB = 8    , TINTC = 163,  CUSTOMIZABLE = true, CUSTOM_ROLELOCK = false, CUSTOM_ROLES = {""}, CUSTOM_PLAYERLOCK = false, CUSTOM_PLAYERS = {""}, ROLELOCK = false, ROLES = {"none"}, PLAYERLOCK = false, PLAYERS = {""}, image = "items/generic_horse_equip_bedroll.png"},	
        },
    },
    [5] = {
        NAME = "Adventurer Used",
        OPTIONS =  {
 		{STABLES_AVAILABILITY     = {1,2,3,4,5,6,7,8,9,10,11,12}, LABEL = "Adventurer Used",   DESCRIPTION = "A nice piece of tack for your horse",			DOLLARS =  20.0, GOLD = 0.0, TYPE = 4, TINTA = 163   ,TINTB = 67    , TINTC = 56,  CUSTOMIZABLE = true, CUSTOM_ROLELOCK = false, CUSTOM_ROLES = {""}, CUSTOM_PLAYERLOCK = false, CUSTOM_PLAYERS = {""}, ROLELOCK = false, ROLES = {"none"}, PLAYERLOCK = false, PLAYERS = {""}, image = "items/generic_horse_equip_bedroll.png"},	 
        },
    },
    [6] = {
        NAME = "Horse Trainer New",
        OPTIONS =  {
 		{STABLES_AVAILABILITY     = {1,2,3,4,5,6,7,8,9,10,11,12}, LABEL = "Simple New",   		DESCRIPTION = "A nice piece of tack for your horse",			DOLLARS =  20.0, GOLD = 0.0, TYPE = 5, TINTA = 65   ,TINTB = 151    , TINTC = 120,  CUSTOMIZABLE = true, CUSTOM_ROLELOCK = false, CUSTOM_ROLES = {""}, CUSTOM_PLAYERLOCK = false, CUSTOM_PLAYERS = {""}, ROLELOCK = false, ROLES = {"none"}, PLAYERLOCK = false, PLAYERS = {""}, image = "items/generic_horse_equip_bedroll.png"},	 
        },
    },
    [7] = {
        NAME = "Horse Trainer Used",
        OPTIONS =  {
 		{STABLES_AVAILABILITY     = {1,2,3,4,5,6,7,8,9,10,11,12}, LABEL = "Simple New",   		DESCRIPTION = "A nice piece of tack for your horse",			DOLLARS =  20.0, GOLD = 0.0, TYPE = 6, TINTA = 65   ,TINTB = 151    , TINTC = 120,  CUSTOMIZABLE = true, CUSTOM_ROLELOCK = false, CUSTOM_ROLES = {""}, CUSTOM_PLAYERLOCK = false, CUSTOM_PLAYERS = {""}, ROLELOCK = false, ROLES = {"none"}, PLAYERLOCK = false, PLAYERS = {""}, image = "items/generic_horse_equip_bedroll.png"},	
        },
    },
	
    [8] = {
    NAME = "Exotic",
    OPTIONS =  {
 		{STABLES_AVAILABILITY     = {1,2,3,4,5,6,7,8,9,10,11,12}, LABEL = "Exotic",   			DESCRIPTION = "A nice piece of tack for your horse",			DOLLARS =  20.0, GOLD = 0.0, TYPE = 7, TINTA = 163   ,TINTB = 67    , TINTC = 56,  CUSTOMIZABLE = true, CUSTOM_ROLELOCK = false, CUSTOM_ROLES = {""}, CUSTOM_PLAYERLOCK = false, CUSTOM_PLAYERS = {""}, ROLELOCK = false, ROLES = {"none"}, PLAYERLOCK = false, PLAYERS = {""}, image = "items/generic_horse_equip_bedroll.png"},		
    },
 },
}
 
--------------------------------
       --BLANKETS--
--------------------------------
Config.BLANKETS = {
     [1] = {
         NAME = "No Blanket",
         OPTIONS = {
 		{STABLES_AVAILABILITY     = {1,2,3,4,5,6,7,8,9,10,11,12}, LABEL = "No Blanket",   	  DESCRIPTION = "Remove that tack piece from your horse",			DOLLARS =  0.0, GOLD = 0.0, TYPE = 0, TINTA = 0   ,TINTB = 0    , TINTC = 0,  CUSTOMIZABLE = false, CUSTOM_ROLELOCK = false, CUSTOM_ROLES = {""}, CUSTOM_PLAYERLOCK = false, CUSTOM_PLAYERS = {""}, ROLELOCK = false, ROLES = {"none"}, PLAYERLOCK = false, PLAYERS = {""}, image = "items/generic_horse_equip_blanket.png"},	 
         },
     },
	 
     [2] = {
         NAME = "Jackson",
         OPTIONS = {
 		{STABLES_AVAILABILITY     = {1,2,3,4,5,6,7,8,9,10,11,12}, LABEL = "Jackson I",   	  DESCRIPTION = "A nice piece of tack for your horse",			DOLLARS =  20.0, GOLD = 0.0, TYPE = 1, TINTA = 12   ,TINTB = 27    , TINTC = 28,  CUSTOMIZABLE = true, CUSTOM_ROLELOCK = false, CUSTOM_ROLES = {""}, CUSTOM_PLAYERLOCK = false, CUSTOM_PLAYERS = {""}, ROLELOCK = false, ROLES = {"none"}, PLAYERLOCK = false, PLAYERS = {""}, image = "items/generic_horse_equip_blanket.png"},	 
         },
     },
	 
     [3] = {
        NAME = "Bearhug",
        OPTIONS = {
 		{STABLES_AVAILABILITY     = {1,2,3,4,5,6,7,8,9,10,11,12}, LABEL = "Bearhug I",   	 DESCRIPTION = "A nice piece of tack for your horse",			DOLLARS =  20.0, GOLD = 0.0, TYPE = 2, TINTA = 151   ,TINTB = 40    , TINTC = 218,  CUSTOMIZABLE = true, CUSTOM_ROLELOCK = false, CUSTOM_ROLES = {""}, CUSTOM_PLAYERLOCK = false, CUSTOM_PLAYERS = {""}, ROLELOCK = false, ROLES = {"none"}, PLAYERLOCK = false, PLAYERS = {""}, image = "items/generic_horse_equip_blanket.png"},	
        },
    },
    [4] = {
        NAME = "Lightning",
        OPTIONS = {
  		{STABLES_AVAILABILITY     = {1,2,3,4,5,6,7,8,9,10,11,12}, LABEL = "Lightning I",  	DESCRIPTION = "A nice piece of tack for your horse",			 DOLLARS =  20.0, GOLD = 0.0, TYPE = 3, TINTA = 48   ,TINTB = 28    , TINTC = 143,  CUSTOMIZABLE = true, CUSTOM_ROLELOCK = false, CUSTOM_ROLES = {""}, CUSTOM_PLAYERLOCK = false, CUSTOM_PLAYERS = {""}, ROLELOCK = false, ROLES = {"none"}, PLAYERLOCK = false, PLAYERS = {""}, image = "items/generic_horse_equip_blanket.png"},	 
        },
    },
    [5] = {
        NAME = "Showdown",
        OPTIONS = {
 		{STABLES_AVAILABILITY     = {1,2,3,4,5,6,7,8,9,10,11,12}, LABEL = "Showdown",   	DESCRIPTION = "A nice piece of tack for your horse",			DOLLARS =  20.0, GOLD = 0.0, TYPE = 4, TINTA = 71   ,TINTB = 234    , TINTC = 43,  CUSTOMIZABLE = true, CUSTOM_ROLELOCK = false, CUSTOM_ROLES = {""}, CUSTOM_PLAYERLOCK = false, CUSTOM_PLAYERS = {""}, ROLELOCK = false, ROLES = {"none"}, PLAYERLOCK = false, PLAYERS = {""}, image = "items/generic_horse_equip_blanket.png"},	 
        },
    },
    [6] = {
        NAME = "Maya",
        OPTIONS = {
 		{STABLES_AVAILABILITY     = {1,2,3,4,5,6,7,8,9,10,11,12}, LABEL = "Maya",   		DESCRIPTION = "A nice piece of tack for your horse",			DOLLARS =  20.0, GOLD = 0.0, TYPE = 5, TINTA = 123   ,TINTB = 36    , TINTC = 205,  CUSTOMIZABLE = true, CUSTOM_ROLELOCK = false, CUSTOM_ROLES = {""}, CUSTOM_PLAYERLOCK = false, CUSTOM_PLAYERS = {""}, ROLELOCK = false, ROLES = {"none"}, PLAYERLOCK = false, PLAYERS = {""}, image = "items/generic_horse_equip_blanket.png"},	 
        },
    },
    [7] = {
        NAME = "Bullseye",
        OPTIONS = {
 		{STABLES_AVAILABILITY     = {1,2,3,4,5,6,7,8,9,10,11,12}, LABEL = "Bullseye",   	DESCRIPTION = "A nice piece of tack for your horse",			DOLLARS =  20.0, GOLD = 0.0, TYPE = 6, TINTA = 114   ,TINTB = 31    , TINTC = 192,  CUSTOMIZABLE = true, CUSTOM_ROLELOCK = false, CUSTOM_ROLES = {""}, CUSTOM_PLAYERLOCK = false, CUSTOM_PLAYERS = {""}, ROLELOCK = false, ROLES = {"none"}, PLAYERLOCK = false, PLAYERS = {""}, image = "items/generic_horse_equip_blanket.png"},
		},
    },
    [8] = {
        NAME = "Tile",
        OPTIONS = {
 		{STABLES_AVAILABILITY     = {1,2,3,4,5,6,7,8,9,10,11,12}, LABEL = "Tile",   		DESCRIPTION = "A nice piece of tack for your horse",			DOLLARS =  20.0, GOLD = 0.0, TYPE = 7, TINTA = 114   ,TINTB = 31    , TINTC = 192,  CUSTOMIZABLE = true, CUSTOM_ROLELOCK = false, CUSTOM_ROLES = {""}, CUSTOM_PLAYERLOCK = false, CUSTOM_PLAYERS = {""}, ROLELOCK = false, ROLES = {"none"}, PLAYERLOCK = false, PLAYERS = {""}, image = "items/generic_horse_equip_blanket.png"},
        },
    },
    [9] = {
        NAME = "Mosaic",
        OPTIONS = {
 		{STABLES_AVAILABILITY     = {1,2,3,4,5,6,7,8,9,10,11,12}, LABEL = "Mosaic",  		DESCRIPTION = "A nice piece of tack for your horse",			 DOLLARS =  20.0, GOLD = 0.0, TYPE = 8, TINTA = 124   ,TINTB = 37    , TINTC = 204,  CUSTOMIZABLE = true, CUSTOM_ROLELOCK = false, CUSTOM_ROLES = {""}, CUSTOM_PLAYERLOCK = false, CUSTOM_PLAYERS = {""}, ROLELOCK = false, ROLES = {"none"}, PLAYERLOCK = false, PLAYERS = {""}, image = "items/generic_horse_equip_blanket.png"},	 
        },
    },
    [10] = {
        NAME = "Tidal Wave",
        OPTIONS = {
 		{STABLES_AVAILABILITY     = {1,2,3,4,5,6,7,8,9,10,11,12}, LABEL = "Tidal Wave",   DESCRIPTION = "A nice piece of tack for your horse",				DOLLARS =  20.0, GOLD = 0.0, TYPE = 9, TINTA = 120   ,TINTB = 28    , TINTC = 187,  CUSTOMIZABLE = true, CUSTOM_ROLELOCK = false, CUSTOM_ROLES = {""}, CUSTOM_PLAYERLOCK = false, CUSTOM_PLAYERS = {""}, ROLELOCK = false, ROLES = {"none"}, PLAYERLOCK = false, PLAYERS = {""}, image = "items/generic_horse_equip_blanket.png"},	 
        },
    },
    [11] = {
        NAME = "Basic",
        OPTIONS = {
 		{STABLES_AVAILABILITY     = {1,2,3,4,5,6,7,8,9,10,11,12}, LABEL = "Basic",  	   DESCRIPTION = "A nice piece of tack for your horse",		   DOLLARS =  20.0, GOLD = 0.0, TYPE = 10, TINTA = 123   ,TINTB = 28    , TINTC = 209,  CUSTOMIZABLE = true, CUSTOM_ROLELOCK = false, CUSTOM_ROLES = {""}, CUSTOM_PLAYERLOCK = false, CUSTOM_PLAYERS = {""}, ROLELOCK = false, ROLES = {"none"}, PLAYERLOCK = false, PLAYERS = {""}, image = "items/generic_horse_equip_blanket.png"},	 
        },
    },
    [12] = {
        NAME = "Striped",
        OPTIONS = {
 		{STABLES_AVAILABILITY     = {1,2,3,4,5,6,7,8,9,10,11,12}, LABEL = "Striped",      DESCRIPTION = "A nice piece of tack for your horse",			DOLLARS =  20.0, GOLD = 0.0, TYPE = 11, TINTA = 42   ,TINTB = 35    , TINTC = 204,  CUSTOMIZABLE = true, CUSTOM_ROLELOCK = false, CUSTOM_ROLES = {""}, CUSTOM_PLAYERLOCK = false, CUSTOM_PLAYERS = {""}, ROLELOCK = false, ROLES = {"none"}, PLAYERLOCK = false, PLAYERS = {""}, image = "items/generic_horse_equip_blanket.png"},	 
        },
    },
	
    [13] = {
        NAME = "Flower",
        OPTIONS = {
 		{STABLES_AVAILABILITY     = {1,2,3,4,5,6,7,8,9,10,11,12}, LABEL = "Exotic",   		DESCRIPTION = "A nice piece of tack for your horse",		DOLLARS =  20.0, GOLD = 0.0, TYPE = 12, TINTA = 121   ,TINTB = 29    , TINTC = 160,  CUSTOMIZABLE = true, CUSTOM_ROLELOCK = false, CUSTOM_ROLES = {""}, CUSTOM_PLAYERLOCK = false, CUSTOM_PLAYERS = {""}, ROLELOCK = false, ROLES = {"none"}, PLAYERLOCK = false, PLAYERS = {""}, image = "items/generic_horse_equip_blanket.png"},	 
 
        },
    },
    [14] = {
        NAME = "Special Blankets",
        OPTIONS = {
 		{STABLES_AVAILABILITY     = {1,2,3,4,5,6,7,8,9,10,11,12}, LABEL = "Alligator",   		DESCRIPTION = "A nice piece of tack for your horse",   DOLLARS =  20.0, GOLD = 0.0, TYPE = 13, TINTA = 14    ,TINTB = 11    , TINTC = 5,    CUSTOMIZABLE = true, CUSTOM_ROLELOCK = false, CUSTOM_ROLES = {""}, CUSTOM_PLAYERLOCK = false, CUSTOM_PLAYERS = {""}, ROLELOCK = false, ROLES = {"none"}, PLAYERLOCK = false, PLAYERS = {""}, image = "items/generic_horse_equip_blanket.png"},	 
 		{STABLES_AVAILABILITY     = {1,2,3,4,5,6,7,8,9,10,11,12}, LABEL = "Bison",       		DESCRIPTION = "A nice piece of tack for your horse",   DOLLARS =  20.0, GOLD = 0.0, TYPE = 14, TINTA = 20    ,TINTB = 36    , TINTC = 28,   CUSTOMIZABLE = true, CUSTOM_ROLELOCK = false, CUSTOM_ROLES = {""}, CUSTOM_PLAYERLOCK = false, CUSTOM_PLAYERS = {""}, ROLELOCK = false, ROLES = {"none"}, PLAYERLOCK = false, PLAYERS = {""}, image = "items/generic_horse_equip_blanket.png"},	 
 		{STABLES_AVAILABILITY     = {1,2,3,4,5,6,7,8,9,10,11,12}, LABEL = "Cougar",      		DESCRIPTION = "A nice piece of tack for your horse",   DOLLARS =  20.0, GOLD = 0.0, TYPE = 15, TINTA = 117   ,TINTB = 64    , TINTC = 0,    CUSTOMIZABLE = true, CUSTOM_ROLELOCK = false, CUSTOM_ROLES = {""}, CUSTOM_PLAYERLOCK = false, CUSTOM_PLAYERS = {""}, ROLELOCK = false, ROLES = {"none"}, PLAYERLOCK = false, PLAYERS = {""}, image = "items/generic_horse_equip_blanket.png"},	 
 		{STABLES_AVAILABILITY     = {1,2,3,4,5,6,7,8,9,10,11,12}, LABEL = "Wolf",   			DESCRIPTION = "A nice piece of tack for your horse",   DOLLARS =  20.0, GOLD = 0.0, TYPE = 16, TINTA = 37    ,TINTB = 56    , TINTC = 13,   CUSTOMIZABLE = true, CUSTOM_ROLELOCK = false, CUSTOM_ROLES = {""}, CUSTOM_PLAYERLOCK = false, CUSTOM_PLAYERS = {""}, ROLELOCK = false, ROLES = {"none"}, PLAYERLOCK = false, PLAYERS = {""}, image = "items/generic_horse_equip_blanket.png"},	
 		{STABLES_AVAILABILITY     = {1,2,3,4,5,6,7,8,9,10,11,12}, LABEL = "Bear",  	    		DESCRIPTION = "A nice piece of tack for your horse",   DOLLARS =  20.0, GOLD = 0.0, TYPE = 17, TINTA = 28    ,TINTB = 0     , TINTC = 122,  CUSTOMIZABLE = true, CUSTOM_ROLELOCK = false, CUSTOM_ROLES = {""}, CUSTOM_PLAYERLOCK = false, CUSTOM_PLAYERS = {""}, ROLELOCK = false, ROLES = {"none"}, PLAYERLOCK = false, PLAYERS = {""}, image = "items/generic_horse_equip_blanket.png"},	 
 		{STABLES_AVAILABILITY     = {1,2,3,4,5,6,7,8,9,10,11,12}, LABEL = "Bounty Hunter I",   	DESCRIPTION = "A nice piece of tack for your horse",   DOLLARS =  20.0, GOLD = 0.0, TYPE = 18, TINTA = 241   ,TINTB = 201   , TINTC = 201,  CUSTOMIZABLE = true, CUSTOM_ROLELOCK = false, CUSTOM_ROLES = {""}, CUSTOM_PLAYERLOCK = false, CUSTOM_PLAYERS = {""}, ROLELOCK = false, ROLES = {"none"}, PLAYERLOCK = false, PLAYERS = {""}, image = "items/generic_horse_equip_blanket.png"},	
         },
    },
    [15] = {
        NAME = "Scottish",
        OPTIONS = {
 		{STABLES_AVAILABILITY     = {1,2,3,4,5,6,7,8,9,10,11,12}, LABEL = "Scottish",  		DESCRIPTION = "A nice piece of tack for your horse",  DOLLARS =  20.0, GOLD = 0.0, TYPE = 19, TINTA = 215   ,TINTB = 122    , TINTC = 92,  CUSTOMIZABLE = true, CUSTOM_ROLELOCK = false, CUSTOM_ROLES = {""}, CUSTOM_PLAYERLOCK = false, CUSTOM_PLAYERS = {""}, ROLELOCK = false, ROLES = {"none"}, PLAYERLOCK = false, PLAYERS = {""}, image = "items/generic_horse_equip_blanket.png"},	 
        },
    },		
    [16] = {
        NAME = "Valentine",
        OPTIONS = {
 		{STABLES_AVAILABILITY     = {1,2,3,4,5,6,7,8,9,10,11,12}, LABEL = "Valentine",   		DESCRIPTION = "A nice piece of tack for your horse",  DOLLARS =  20.0, GOLD = 0.0, TYPE = 20, TINTA = 215   ,TINTB = 122    , TINTC = 92,  CUSTOMIZABLE = true, CUSTOM_ROLELOCK = false, CUSTOM_ROLES = {""}, CUSTOM_PLAYERLOCK = false, CUSTOM_PLAYERS = {""}, ROLELOCK = false, ROLES = {"none"}, PLAYERLOCK = false, PLAYERS = {""}, image = "items/generic_horse_equip_blanket.png"},	 		
        },
    },		
    [17] = {
        NAME = "Charleston",
        OPTIONS = {
 		{STABLES_AVAILABILITY     = {1,2,3,4,5,6,7,8,9,10,11,12}, LABEL = "Charleston",  	   DESCRIPTION = "A nice piece of tack for your horse",	  DOLLARS =  20.0, GOLD = 0.0, TYPE = 21, TINTA = 163   ,TINTB = 67    , TINTC = 56,  CUSTOMIZABLE = true, CUSTOM_ROLELOCK = false, CUSTOM_ROLES = {""}, CUSTOM_PLAYERLOCK = false, CUSTOM_PLAYERS = {""}, ROLELOCK = false, ROLES = {"none"}, PLAYERLOCK = false, PLAYERS = {""}, image = "items/generic_horse_equip_blanket.png"},	 		
        },
    },	
    [18] = {
        NAME = "Cadwell",
        OPTIONS = {
 		{STABLES_AVAILABILITY     = {1,2,3,4,5,6,7,8,9,10,11,12}, LABEL = "Cadwell",  		  DESCRIPTION = "A nice piece of tack for your horse",	 DOLLARS =  20.0, GOLD = 0.0, TYPE = 22, TINTA = 163   ,TINTB = 67    , TINTC = 56,  CUSTOMIZABLE = true, CUSTOM_ROLELOCK = false, CUSTOM_ROLES = {""}, CUSTOM_PLAYERLOCK = false, CUSTOM_PLAYERS = {""}, ROLELOCK = false, ROLES = {"none"}, PLAYERLOCK = false, PLAYERS = {""}, image = "items/generic_horse_equip_blanket.png"},	 		
        },
    },

    [19] = {
        NAME = "Trader",
        OPTIONS = {
 		{STABLES_AVAILABILITY     = {1,2,3,4,5,6,7,8,9,10,11,12}, LABEL = "Trader",  		  DESCRIPTION = "A nice piece of tack for your horse",	 DOLLARS =  20.0, GOLD = 0.0, TYPE = 23, TINTA = 120   ,TINTB = 8    , TINTC = 14,  CUSTOMIZABLE = true, CUSTOM_ROLELOCK = false, CUSTOM_ROLES = {""}, CUSTOM_PLAYERLOCK = false, CUSTOM_PLAYERS = {""}, ROLELOCK = false, ROLES = {"none"}, PLAYERLOCK = false, PLAYERS = {""}, image = "items/generic_horse_equip_blanket.png"},	 		
        },
    },	

    [20] = {
        NAME = "Naturalist",
        OPTIONS = {
 		{STABLES_AVAILABILITY     = {1,2,3,4,5,6,7,8,9,10,11,12}, LABEL = "Naturalist",  	  DESCRIPTION = "A nice piece of tack for your horse",	 DOLLARS =  20.0, GOLD = 0.0, TYPE = 24, TINTA = 0   ,TINTB = 0    , TINTC = 0,  CUSTOMIZABLE = false, CUSTOM_ROLELOCK = false, CUSTOM_ROLES = {""}, CUSTOM_PLAYERLOCK = false, CUSTOM_PLAYERS = {""}, ROLELOCK = false, ROLES = {"none"}, PLAYERLOCK = false, PLAYERS = {""}, image = "items/generic_horse_equip_blanket.png"},	 		
        },
    },	 
 
    [21] = {
        NAME = "Collector",
        OPTIONS = {
 		{STABLES_AVAILABILITY     = {1,2,3,4,5,6,7,8,9,10,11,12}, LABEL = "Collector",  	  DESCRIPTION = "A nice piece of tack for your horse",	 DOLLARS =  20.0, GOLD = 0.0, TYPE = 25, TINTA = 86, TINTB = 30,  TINTC = 25,  CUSTOMIZABLE = true, CUSTOM_ROLELOCK = false, CUSTOM_ROLES = {""}, CUSTOM_PLAYERLOCK = false, CUSTOM_PLAYERS = {""}, ROLELOCK = false, ROLES = {"none"}, PLAYERLOCK = false, PLAYERS = {""}, image = "items/generic_horse_equip_blanket.png"},	 		
        },
    },		
	
    [22] = {
        NAME = "Upland",
        OPTIONS = {
 		{STABLES_AVAILABILITY     = {1,2,3,4,5,6,7,8,9,10,11,12}, LABEL = "Upland",  	  DESCRIPTION = "A nice piece of tack for your horse",	 DOLLARS =  20.0, GOLD = 0.0, TYPE = 26, TINTA = 86, TINTB = 30,  TINTC = 25,  CUSTOMIZABLE = false, CUSTOM_ROLELOCK = false, CUSTOM_ROLES = {""}, CUSTOM_PLAYERLOCK = false, CUSTOM_PLAYERS = {""}, ROLELOCK = false, ROLES = {"none"}, PLAYERLOCK = false, PLAYERS = {""}, image = "items/generic_horse_equip_blanket.png"},	 		
        },
    },		
	
	
}

 
-------------------------------
       -- BRIDLES --
-------------------------------
Config.BRIDLES = {
     [1] = {
        NAME = "No bridle",
        OPTIONS = {
			{STABLES_AVAILABILITY     = {1,2,3,4,5,6,7,8,9,10,11,12}, LABEL = "No bridle",   DESCRIPTION = "Remove that tack piece from your horse",  DOLLARS =  0.0, GOLD = 0.0, TYPE = 0, TINTA = 0   ,TINTB = 0    , TINTC = 0,  CUSTOMIZABLE = false, CUSTOM_ROLELOCK = false, CUSTOM_ROLES = {""}, CUSTOM_PLAYERLOCK = false, CUSTOM_PLAYERS = {""}, ROLELOCK = false, ROLES = {"none"}, PLAYERLOCK = false, PLAYERS = {""}, image = "items/horse_bridles.png"},	
        },
    },	
	
    [2] = {
        NAME = "Bridle #1",
        OPTIONS = {
			{STABLES_AVAILABILITY     = {1,2,3,4,5,6,7,8,9,10,11,12}, LABEL = "Bridle #1",   DESCRIPTION = "A nice piece of tack for your horse",  DOLLARS =  15.0, GOLD = 0.0, TYPE = 1, TINTA = 166   ,TINTB = 41    , TINTC = 199,  CUSTOMIZABLE = true, CUSTOM_ROLELOCK = false, CUSTOM_ROLES = {""}, CUSTOM_PLAYERLOCK = false, CUSTOM_PLAYERS = {""}, ROLELOCK = false, ROLES = {"none"}, PLAYERLOCK = false, PLAYERS = {""}, image = "items/horse_bridles.png"},	
        },
    },	
    [3] = {
        NAME = "Bridle #2",
        OPTIONS = {			
			{STABLES_AVAILABILITY     = {1,2,3,4,5,6,7,8,9,10,11,12}, LABEL = "Bridle #2",   DESCRIPTION = "A nice piece of tack for your horse", DOLLARS =  15.0, GOLD = 0.0, TYPE = 2, TINTA = 27   ,TINTB = 75    , TINTC = 61,  CUSTOMIZABLE = true, CUSTOM_ROLELOCK = false, CUSTOM_ROLES = {""}, CUSTOM_PLAYERLOCK = false, CUSTOM_PLAYERS = {""}, ROLELOCK = false, ROLES = {"none"}, PLAYERLOCK = false, PLAYERS = {""}, image = "items/horse_bridles.png"},
        },
    },	
    [4] = {
        NAME = "Bridle #3",
        OPTIONS = {	
			{STABLES_AVAILABILITY     = {1,2,3,4,5,6,7,8,9,10,11,12}, LABEL = "Bridle #3",  DESCRIPTION = "A nice piece of tack for your horse",  DOLLARS =  15.0, GOLD = 0.0, TYPE = 3, TINTA = 0   ,TINTB = 0    , TINTC = 0,  CUSTOMIZABLE = false, CUSTOM_ROLELOCK = false, CUSTOM_ROLES = {""}, CUSTOM_PLAYERLOCK = false, CUSTOM_PLAYERS = {""}, ROLELOCK = false, ROLES = {"none"}, PLAYERLOCK = false, PLAYERS = {""}, image = "items/horse_bridles.png"},	
        },
    },	
    [5] = {
        NAME = "Bridle #4",
        OPTIONS = {	
			{STABLES_AVAILABILITY     = {1,2,3,4,5,6,7,8,9,10,11,12}, LABEL = "Bridle #4",  DESCRIPTION = "A nice piece of tack for your horse", DOLLARS =  15.0, GOLD = 0.0, TYPE = 4, TINTA = 0   ,TINTB = 0    , TINTC = 0,  CUSTOMIZABLE = true, CUSTOM_ROLELOCK = false, CUSTOM_ROLES = {""}, CUSTOM_PLAYERLOCK = false, CUSTOM_PLAYERS = {""}, ROLELOCK = false, ROLES = {"none"}, PLAYERLOCK = false, PLAYERS = {""}, image = "items/horse_bridles.png"},		
        },
    },	
    [6] = {
        NAME = "Bridle #5",
        OPTIONS = {	
		{STABLES_AVAILABILITY     = {1,2,3,4,5,6,7,8,9,10,11,12}, LABEL = "Bridle #5",      DESCRIPTION = "A nice piece of tack for your horse", DOLLARS =  15.0, GOLD = 0.0, TYPE = 5, TINTA = 21  ,TINTB = 21    , TINTC = 21,  CUSTOMIZABLE = true, CUSTOM_ROLELOCK = false, CUSTOM_ROLES = {""}, CUSTOM_PLAYERLOCK = false, CUSTOM_PLAYERS = {""}, ROLELOCK = false, ROLES = {"none"}, PLAYERLOCK = false, PLAYERS = {""}, image = "items/horse_bridles.png"},	
			
        },
    },	
    [7] = {
        NAME = "Bridle #6",
        OPTIONS = {	
 		{STABLES_AVAILABILITY     = {1,2,3,4,5,6,7,8,9,10,11,12}, LABEL = "Bridle #6",      DESCRIPTION = "A nice piece of tack for your horse", DOLLARS =  15.0, GOLD = 0.0, TYPE = 6, TINTA = 241  ,TINTB = 201    , TINTC = 201,  CUSTOMIZABLE = true, CUSTOM_ROLELOCK = false, CUSTOM_ROLES = {""}, CUSTOM_PLAYERLOCK = false, CUSTOM_PLAYERS = {""}, ROLELOCK = false, ROLES = {"none"}, PLAYERLOCK = false, PLAYERS = {""}, image = "items/horse_bridles.png"},
        },
    },	
    [8] = {
        NAME = "Bridle #7",
        OPTIONS = {	
 		{STABLES_AVAILABILITY     = {1,2,3,4,5,6,7,8,9,10,11,12}, LABEL = "Bridle #7",    DESCRIPTION = "A nice piece of tack for your horse",  DOLLARS =  15.0, GOLD = 0.0, TYPE = 7, TINTA = 0  ,TINTB = 0    , TINTC = 0,  CUSTOMIZABLE = true, CUSTOM_ROLELOCK = false, CUSTOM_ROLES = {""}, CUSTOM_PLAYERLOCK = false, CUSTOM_PLAYERS = {""}, ROLELOCK = false, ROLES = {"none"}, PLAYERLOCK = false, PLAYERS = {""}, image = "items/horse_bridles.png"},
			
        },
    },	
    [9] = {
        NAME = "Bridle #8",
        OPTIONS = {	 
 		{STABLES_AVAILABILITY     = {1,2,3,4,5,6,7,8,9,10,11,12}, LABEL = "Bridle #8",   DESCRIPTION = "A nice piece of tack for your horse",  DOLLARS =  15.0, GOLD = 0.0, TYPE = 8, TINTA = 241  ,TINTB = 201    , TINTC = 201,  CUSTOMIZABLE = false, CUSTOM_ROLELOCK = false, CUSTOM_ROLES = {""}, CUSTOM_PLAYERLOCK = false, CUSTOM_PLAYERS = {""}, ROLELOCK = false, ROLES = {"none"}, PLAYERLOCK = false, PLAYERS = {""}, image = "items/horse_bridles.png"},			
        },
    },
    [10] = {
        NAME = "Bridle #9",
        OPTIONS = {	
 		{STABLES_AVAILABILITY     = {1,2,3,4,5,6,7,8,9,10,11,12}, LABEL = "Bridle #9",      DESCRIPTION = "A nice piece of tack for your horse", DOLLARS =  15.0, GOLD = 0.0, TYPE = 9, TINTA = 0  ,TINTB = 0    , TINTC = 0,  CUSTOMIZABLE = false, CUSTOM_ROLELOCK = false, CUSTOM_ROLES = {""}, CUSTOM_PLAYERLOCK = false, CUSTOM_PLAYERS = {""}, ROLELOCK = false, ROLES = {"none"}, PLAYERLOCK = false, PLAYERS = {""}, image = "items/horse_bridles.png"},
        },
    },	
	
    [11] = {
        NAME = "Bridle #10",
        OPTIONS = {	
 		{STABLES_AVAILABILITY     = {1,2,3,4,5,6,7,8,9,10,11,12}, LABEL = "Bridle #10",      DESCRIPTION = "A nice piece of tack for your horse", DOLLARS =  15.0, GOLD = 0.0, TYPE = 10, TINTA = 241  ,TINTB = 201    , TINTC = 201,  CUSTOMIZABLE = true, CUSTOM_ROLELOCK = false, CUSTOM_ROLES = {""}, CUSTOM_PLAYERLOCK = false, CUSTOM_PLAYERS = {""}, ROLELOCK = false, ROLES = {"none"}, PLAYERLOCK = false, PLAYERS = {""}, image = "items/horse_bridles.png"},
        },
    },	
    [12] = {
        NAME = "Bridle #11",
        OPTIONS = {	
 		{STABLES_AVAILABILITY     = {1,2,3,4,5,6,7,8,9,10,11,12}, LABEL = "Bridle #11",      DESCRIPTION = "A nice piece of tack for your horse", DOLLARS =  15.0, GOLD = 0.0, TYPE = 11, TINTA = 241  ,TINTB = 201    , TINTC = 201,  CUSTOMIZABLE = true, CUSTOM_ROLELOCK = false, CUSTOM_ROLES = {""}, CUSTOM_PLAYERLOCK = false, CUSTOM_PLAYERS = {""}, ROLELOCK = false, ROLES = {"none"}, PLAYERLOCK = false, PLAYERS = {""}, image = "items/horse_bridles.png"},
        },
    },
    [13] = {
        NAME = "Bridle #12",
        OPTIONS = {	
 		{STABLES_AVAILABILITY     = {1,2,3,4,5,6,7,8,9,10,11,12}, LABEL = "Bridle #12",      DESCRIPTION = "A nice piece of tack for your horse", DOLLARS =  15.0, GOLD = 0.0, TYPE = 12, TINTA = 241  ,TINTB = 201    , TINTC = 201,  CUSTOMIZABLE = true, CUSTOM_ROLELOCK = false, CUSTOM_ROLES = {""}, CUSTOM_PLAYERLOCK = false, CUSTOM_PLAYERS = {""}, ROLELOCK = false, ROLES = {"none"}, PLAYERLOCK = false, PLAYERS = {""}, image = "items/horse_bridles.png"},
        },
    },

    [14] = {
        NAME = "Bridle #13",
        OPTIONS = {	
 		{STABLES_AVAILABILITY     = {1,2,3,4,5,6,7,8,9,10,11,12}, LABEL = "Bridle #13",      DESCRIPTION = "A nice piece of tack for your horse", DOLLARS =  15.0, GOLD = 0.0, TYPE = 13, TINTA = 241  ,TINTB = 201    , TINTC = 201,  CUSTOMIZABLE = true, CUSTOM_ROLELOCK = false, CUSTOM_ROLES = {""}, CUSTOM_PLAYERLOCK = false, CUSTOM_PLAYERS = {""}, ROLELOCK = false, ROLES = {"none"}, PLAYERLOCK = false, PLAYERS = {""}, image = "items/horse_bridles.png"},
        },
    },

    [15] = {
        NAME = "Bridle #14",
        OPTIONS = {	
 		{STABLES_AVAILABILITY     = {1,2,3,4,5,6,7,8,9,10,11,12}, LABEL = "Bridle #14",      DESCRIPTION = "A nice piece of tack for your horse", DOLLARS =  15.0, GOLD = 0.0, TYPE = 14, TINTA = 241  ,TINTB = 201    , TINTC = 201,  CUSTOMIZABLE = true, CUSTOM_ROLELOCK = false, CUSTOM_ROLES = {""}, CUSTOM_PLAYERLOCK = false, CUSTOM_PLAYERS = {""}, ROLELOCK = false, ROLES = {"none"}, PLAYERLOCK = false, PLAYERS = {""}, image = "items/horse_bridles.png"},
        },
    },

    [16] = {
        NAME = "Bridle #15",
        OPTIONS = {	
 		{STABLES_AVAILABILITY     = {1,2,3,4,5,6,7,8,9,10,11,12}, LABEL = "Bridle #15",      DESCRIPTION = "A nice piece of tack for your horse", DOLLARS =  15.0, GOLD = 0.0, TYPE = 15, TINTA = 241  ,TINTB = 201    , TINTC = 201,  CUSTOMIZABLE = true, CUSTOM_ROLELOCK = false, CUSTOM_ROLES = {""}, CUSTOM_PLAYERLOCK = false, CUSTOM_PLAYERS = {""}, ROLELOCK = false, ROLES = {"none"}, PLAYERLOCK = false, PLAYERS = {""}, image = "items/horse_bridles.png"},
        },
    },

    [17] = {
        NAME = "Bridle #16",
        OPTIONS = {	
 		{STABLES_AVAILABILITY     = {1,2,3,4,5,6,7,8,9,10,11,12}, LABEL = "Bridle #16",      DESCRIPTION = "A nice piece of tack for your horse", DOLLARS =  15.0, GOLD = 0.0, TYPE = 16, TINTA = 241  ,TINTB = 201    , TINTC = 201,  CUSTOMIZABLE = true, CUSTOM_ROLELOCK = false, CUSTOM_ROLES = {""}, CUSTOM_PLAYERLOCK = false, CUSTOM_PLAYERS = {""}, ROLELOCK = false, ROLES = {"none"}, PLAYERLOCK = false, PLAYERS = {""}, image = "items/horse_bridles.png"},
        },
    },

    [18] = {
        NAME = "Bridle #17",
        OPTIONS = {	
 		{STABLES_AVAILABILITY     = {1,2,3,4,5,6,7,8,9,10,11,12}, LABEL = "Bridle #17",      DESCRIPTION = "A nice piece of tack for your horse", DOLLARS =  15.0, GOLD = 0.0, TYPE = 17, TINTA = 241  ,TINTB = 201    , TINTC = 201,  CUSTOMIZABLE = true, CUSTOM_ROLELOCK = false, CUSTOM_ROLES = {""}, CUSTOM_PLAYERLOCK = false, CUSTOM_PLAYERS = {""}, ROLELOCK = false, ROLES = {"none"}, PLAYERLOCK = false, PLAYERS = {""}, image = "items/horse_bridles.png"},
        },
    },

    [19] = {
        NAME = "Bridle #18",
        OPTIONS = {	
 		{STABLES_AVAILABILITY     = {1,2,3,4,5,6,7,8,9,10,11,12}, LABEL = "Bridle #18",      DESCRIPTION = "A nice piece of tack for your horse", DOLLARS =  15.0, GOLD = 0.0, TYPE = 18, TINTA = 241  ,TINTB = 201    , TINTC = 201,  CUSTOMIZABLE = true, CUSTOM_ROLELOCK = false, CUSTOM_ROLES = {""}, CUSTOM_PLAYERLOCK = false, CUSTOM_PLAYERS = {""}, ROLELOCK = false, ROLES = {"none"}, PLAYERLOCK = false, PLAYERS = {""}, image = "items/horse_bridles.png"},
        },
    },

    [20] = {
        NAME = "Bridle #19",
        OPTIONS = {	
 		{STABLES_AVAILABILITY     = {1,2,3,4,5,6,7,8,9,10,11,12}, LABEL = "Bridle #19",      DESCRIPTION = "A nice piece of tack for your horse", DOLLARS =  15.0, GOLD = 0.0, TYPE = 19, TINTA = 241  ,TINTB = 201    , TINTC = 201,  CUSTOMIZABLE = false, CUSTOM_ROLELOCK = false, CUSTOM_ROLES = {""}, CUSTOM_PLAYERLOCK = false, CUSTOM_PLAYERS = {""}, ROLELOCK = false, ROLES = {"none"}, PLAYERLOCK = false, PLAYERS = {""}, image = "items/horse_bridles.png"},
        },
    },	
	
	[21] = {
		NAME = "Bridle #20",
		OPTIONS = {	
		{STABLES_AVAILABILITY     = {1,2,3,4,5,6,7,8,9,10,11,12}, LABEL = "Bridle #20",      DESCRIPTION = "A nice piece of tack for your horse", DOLLARS =  15.0, GOLD = 0.0, TYPE = 20, TINTA = 241  ,TINTB = 201    , TINTC = 201,  CUSTOMIZABLE = true, CUSTOM_ROLELOCK = false, CUSTOM_ROLES = {""}, CUSTOM_PLAYERLOCK = false, CUSTOM_PLAYERS = {""}, ROLELOCK = false, ROLES = {"none"}, PLAYERLOCK = false, PLAYERS = {""}, image = "items/horse_bridles.png"},
		},
    },	
	
	[22] = {
		NAME = "Bridle #21",
		OPTIONS = {	
		{STABLES_AVAILABILITY     = {1,2,3,4,5,6,7,8,9,10,11,12}, LABEL = "Bridle #21",      DESCRIPTION = "A nice piece of tack for your horse", DOLLARS =  15.0, GOLD = 0.0, TYPE = 21, TINTA = 25  ,TINTB = 91    , TINTC = 88,  CUSTOMIZABLE = true, CUSTOM_ROLELOCK = false, CUSTOM_ROLES = {""}, CUSTOM_PLAYERLOCK = false, CUSTOM_PLAYERS = {""}, ROLELOCK = false, ROLES = {"none"}, PLAYERLOCK = false, PLAYERS = {""}, image = "items/horse_bridles.png"},
		},
    },	
	
}


--------------------------------
       -- HORNS --
--------------------------------

Config.HORNS = {

    [1] = {
        NAME = "No Horn",
        OPTIONS = {
 		{STABLES_AVAILABILITY     = {1,2,3,4,5,6,7,8,9,10,11,12}, LABEL = "No Horn",     DESCRIPTION = "Remove that tack piece from your horse", DOLLARS =  0.0, GOLD = 0.0, TYPE = 0, TINTA = 0  ,TINTB = 0    , TINTC = 0,  CUSTOMIZABLE = false, CUSTOM_ROLELOCK = false, CUSTOM_ROLES = {""}, CUSTOM_PLAYERLOCK = false, CUSTOM_PLAYERS = {""}, ROLELOCK = false, ROLES = {"none"}, PLAYERLOCK = false, PLAYERS = {""}, image = "items/generic_horse_equip_horn.png"},
        },
    },
	
    [2] = {
        NAME = "Basic Horn",
        OPTIONS = {
 		{STABLES_AVAILABILITY     = {1,2,3,4,5,6,7,8,9,10,11,12}, LABEL = "Basic ",     DESCRIPTION = "A nice piece of tack for your horse", DOLLARS =  15.0, GOLD = 0.0, TYPE = 1, TINTA = 23  ,TINTB = 8    , TINTC = 9,  CUSTOMIZABLE = true, CUSTOM_ROLELOCK = false, CUSTOM_ROLES = {""}, CUSTOM_PLAYERLOCK = false, CUSTOM_PLAYERS = {""}, ROLELOCK = false, ROLES = {"none"}, PLAYERLOCK = false, PLAYERS = {""}, image = "items/generic_horse_equip_horn.png"},
        },
    },
    [3] = {
        NAME = "Long Horn",
        OPTIONS = {
 		{STABLES_AVAILABILITY     = {1,2,3,4,5,6,7,8,9,10,11,12}, LABEL = "Long ",      DESCRIPTION = "A nice piece of tack for your horse", DOLLARS =  15.0, GOLD = 0.0, TYPE = 2, TINTA = 25  ,TINTB = 36    , TINTC = 36,  CUSTOMIZABLE = true, CUSTOM_ROLELOCK = false, CUSTOM_ROLES = {""}, CUSTOM_PLAYERLOCK = false, CUSTOM_PLAYERS = {""}, ROLELOCK = false, ROLES = {"none"}, PLAYERLOCK = false, PLAYERS = {""}, image = "items/generic_horse_equip_horn.png"},
        },
    },
    [4] = {
        NAME = "Ornemental Horn",
        OPTIONS = {
 		{STABLES_AVAILABILITY     = {1,2,3,4,5,6,7,8,9,10,11,12}, LABEL = "Ornemental",  DESCRIPTION = "A nice piece of tack for your horse", DOLLARS =  15.0, GOLD = 0.0, TYPE = 3, TINTA = 10  ,TINTB = 23    , TINTC = 0,  CUSTOMIZABLE = true, CUSTOM_ROLELOCK = false, CUSTOM_ROLES = {""}, CUSTOM_PLAYERLOCK = false, CUSTOM_PLAYERS = {""}, ROLELOCK = false, ROLES = {"none"}, PLAYERLOCK = false, PLAYERS = {""}, image = "items/generic_horse_equip_horn.png"},
        },
    },
    [5] = {
        NAME = "Short Horn",
        OPTIONS = {
 		{STABLES_AVAILABILITY     = {1,2,3,4,5,6,7,8,9,10,11,12}, LABEL = "Ornemental",  DESCRIPTION = "A nice piece of tack for your horse",  DOLLARS =  15.0, GOLD = 0.0, TYPE = 4, TINTA = 19  ,TINTB = 238    , TINTC = 204,  CUSTOMIZABLE = true, CUSTOM_ROLELOCK = false, CUSTOM_ROLES = {""}, CUSTOM_PLAYERLOCK = false, CUSTOM_PLAYERS = {""}, ROLELOCK = false, ROLES = {"none"}, PLAYERLOCK = false, PLAYERS = {""}, image = "items/generic_horse_equip_horn.png"}, 
        },
    },
    [6] = {
        NAME = "Specials",
        OPTIONS = {
 		{STABLES_AVAILABILITY     = {1,2,3,4,5,6,7,8,9,10,11,12}, LABEL = "Eagle",   		  	DESCRIPTION = "A nice piece of tack for your horse", DOLLARS =  15.0, GOLD = 0.0, TYPE = 5 , TINTA = 0   ,TINTB = 64    , TINTC = 125,  CUSTOMIZABLE = true, CUSTOM_ROLELOCK = false, CUSTOM_ROLES = {""}, CUSTOM_PLAYERLOCK = false, CUSTOM_PLAYERS = {""}, ROLELOCK = false, ROLES = {"none"}, PLAYERLOCK = false, PLAYERS = {""}, image = "items/generic_horse_equip_horn.png"}, 
 		{STABLES_AVAILABILITY     = {1,2,3,4,5,6,7,8,9,10,11,12}, LABEL = "Snake",   		  	DESCRIPTION = "A nice piece of tack for your horse", DOLLARS =  15.0, GOLD = 0.0, TYPE = 6,  TINTA = 10  ,TINTB = 8     , TINTC = 0,    CUSTOMIZABLE = true, CUSTOM_ROLELOCK = false, CUSTOM_ROLES = {""}, CUSTOM_PLAYERLOCK = false, CUSTOM_PLAYERS = {""}, ROLELOCK = false, ROLES = {"none"}, PLAYERLOCK = false, PLAYERS = {""}, image = "items/generic_horse_equip_horn.png"},		
 		{STABLES_AVAILABILITY     = {1,2,3,4,5,6,7,8,9,10,11,12}, LABEL = "Leather Ringed",     DESCRIPTION = "A nice piece of tack for your horse", DOLLARS =  15.0, GOLD = 0.0, TYPE = 7,  TINTA = 65  ,TINTB = 0     , TINTC = 36,   CUSTOMIZABLE = true, CUSTOM_ROLELOCK = false, CUSTOM_ROLES = {""}, CUSTOM_PLAYERLOCK = false, CUSTOM_PLAYERS = {""}, ROLELOCK = false, ROLES = {"none"}, PLAYERLOCK = false, PLAYERS = {""}, image = "items/generic_horse_equip_horn.png"},	 		
 		{STABLES_AVAILABILITY     = {1,2,3,4,5,6,7,8,9,10,11,12}, LABEL = "Iron Horn",   	 	DESCRIPTION = "A nice piece of tack for your horse", DOLLARS =  15.0, GOLD = 0.0, TYPE = 8 , TINTA = 64  ,TINTB = 0     , TINTC =  0,   CUSTOMIZABLE = true, CUSTOM_ROLELOCK = false, CUSTOM_ROLES = {""}, CUSTOM_PLAYERLOCK = false, CUSTOM_PLAYERS = {""}, ROLELOCK = false, ROLES = {"none"}, PLAYERLOCK = false, PLAYERS = {""}, image = "items/generic_horse_equip_horn.png"},	 		
 		{STABLES_AVAILABILITY     = {1,2,3,4,5,6,7,8,9,10,11,12}, LABEL = "Iron Horn 2",   		DESCRIPTION = "A nice piece of tack for your horse", DOLLARS =  15.0, GOLD = 0.0, TYPE = 9 , TINTA = 31  ,TINTB = 51    , TINTC =  27,  CUSTOMIZABLE = true, CUSTOM_ROLELOCK = false, CUSTOM_ROLES = {""}, CUSTOM_PLAYERLOCK = false, CUSTOM_PLAYERS = {""}, ROLELOCK = false, ROLES = {"none"}, PLAYERLOCK = false, PLAYERS = {""}, image = "items/generic_horse_equip_horn.png"},	 		
 		{STABLES_AVAILABILITY     = {1,2,3,4,5,6,7,8,9,10,11,12}, LABEL = "Metalworked Horn",   DESCRIPTION = "A nice piece of tack for your horse", DOLLARS =  15.0, GOLD = 0.0, TYPE = 10, TINTA = 6   ,TINTB = 0     , TINTC =  0,   CUSTOMIZABLE = true, CUSTOM_ROLELOCK = false, CUSTOM_ROLES = {""}, CUSTOM_PLAYERLOCK = false, CUSTOM_PLAYERS = {""}, ROLELOCK = false, ROLES = {"none"}, PLAYERLOCK = false, PLAYERS = {""}, image = "items/generic_horse_equip_horn.png"},	 		
 		{STABLES_AVAILABILITY     = {1,2,3,4,5,6,7,8,9,10,11,12}, LABEL = "Metal Wraped Horn",  DESCRIPTION = "A nice piece of tack for your horse", DOLLARS =  15.0, GOLD = 0.0, TYPE = 11, TINTA = 0   ,TINTB = 59    , TINTC =  1,   CUSTOMIZABLE = true, CUSTOM_ROLELOCK = false, CUSTOM_ROLES = {""}, CUSTOM_PLAYERLOCK = false, CUSTOM_PLAYERS = {""}, ROLELOCK = false, ROLES = {"none"}, PLAYERLOCK = false, PLAYERS = {""}, image = "items/generic_horse_equip_horn.png"},	 		
 		{STABLES_AVAILABILITY     = {1,2,3,4,5,6,7,8,9,10,11,12}, LABEL = "Silver Horn", 	  	DESCRIPTION = "A nice piece of tack for your horse", DOLLARS =  15.0, GOLD = 0.0, TYPE = 12, TINTA = 6   ,TINTB = 0     , TINTC =  0,   CUSTOMIZABLE = true, CUSTOM_ROLELOCK = false, CUSTOM_ROLES = {""}, CUSTOM_PLAYERLOCK = false, CUSTOM_PLAYERS = {""}, ROLELOCK = false, ROLES = {"none"}, PLAYERLOCK = false, PLAYERS = {""}, image = "items/generic_horse_equip_horn.png"},	 		
 		{STABLES_AVAILABILITY     = {1,2,3,4,5,6,7,8,9,10,11,12}, LABEL = "Wooden Horn", 	  	DESCRIPTION = "A nice piece of tack for your horse", DOLLARS =  15.0, GOLD = 0.0, TYPE = 13, TINTA = 65  ,TINTB = 0     , TINTC =  36,  CUSTOMIZABLE = true, CUSTOM_ROLELOCK = false, CUSTOM_ROLES = {""}, CUSTOM_PLAYERLOCK = false, CUSTOM_PLAYERS = {""}, ROLELOCK = false, ROLES = {"none"}, PLAYERLOCK = false, PLAYERS = {""}, image = "items/generic_horse_equip_horn.png"},	 		
 		{STABLES_AVAILABILITY     = {1,2,3,4,5,6,7,8,9,10,11,12}, LABEL = "Gold Horn", 	 		DESCRIPTION = "A nice piece of tack for your horse", DOLLARS =  15.0, GOLD = 0.0, TYPE = 14, TINTA = 24  ,TINTB = 0     , TINTC =  0,   CUSTOMIZABLE = true, CUSTOM_ROLELOCK = false, CUSTOM_ROLES = {""}, CUSTOM_PLAYERLOCK = false, CUSTOM_PLAYERS = {""}, ROLELOCK = false, ROLES = {"none"}, PLAYERLOCK = false, PLAYERS = {""}, image = "items/generic_horse_equip_horn.png"},	 		
        },
    },
}

--------------------------------
       -- MANES --
--------------------------------

Config.MANES = {
    [1] = {
        NAME = "NO MANE",
        OPTIONS = {
 		{STABLES_AVAILABILITY     = {1,2,3,4,5,6,7,8,9,10,11,12}, LABEL = "NO MANE", 	 	DESCRIPTION = "A nice touch of customization for your horse",  DOLLARS =  0.0, GOLD = 0.0, TYPE = 0, TEXTURE = 1, TINTA = 0  , TINTB = 0     , TINTC =  0,   CUSTOMIZABLE = true, CUSTOM_ROLELOCK = false, CUSTOM_ROLES = {""}, CUSTOM_PLAYERLOCK = false, CUSTOM_PLAYERS = {""}, ROLELOCK = false, ROLES = {"none"}, PLAYERLOCK = false, PLAYERS = {""}, image = "items/generic_horse_equip_mane.png"},			
        },		
    },		
    [2] = {		
        NAME = "MANE TYPE 1",		
        OPTIONS = {		
 		{STABLES_AVAILABILITY     = {1,2,3,4,5,6,7,8,9,10,11,12}, LABEL = "MANE 1", 	 	DESCRIPTION = "A nice touch of customization for your horse", DOLLARS =   15.0, GOLD = 0.0, TYPE = 1, TEXTURE = 1, TINTA = 0  , TINTB = 0     , TINTC =  0,   CUSTOMIZABLE = true, CUSTOM_ROLELOCK = false, CUSTOM_ROLES = {""}, CUSTOM_PLAYERLOCK = false, CUSTOM_PLAYERS = {""}, ROLELOCK = false, ROLES = {"none"}, PLAYERLOCK = false, PLAYERS = {""}, image = "items/generic_horse_equip_mane.png"},		
        },		
    },		
     [3] = {		
        NAME = "MANE TYPE 2",		
         OPTIONS = {		
  		{STABLES_AVAILABILITY     = {1,2,3,4,5,6,7,8,9,10,11,12}, LABEL = "MANE 1", 	 	DESCRIPTION = "A nice touch of customization for your horse", DOLLARS =   15.0, GOLD = 0.0, TYPE = 2, TEXTURE = 1, TINTA = 0  ,TINTB = 0     , TINTC =  0,   CUSTOMIZABLE = true, CUSTOM_ROLELOCK = false, CUSTOM_ROLES = {""}, CUSTOM_PLAYERLOCK = false, CUSTOM_PLAYERS = {""}, ROLELOCK = false, ROLES = {"none"}, PLAYERLOCK = false, PLAYERS = {""}, image = "items/generic_horse_equip_mane.png"},	 
         },		
     }, 		
     [4] = {		
        NAME = "MANE TYPE 3",		
         OPTIONS = {		
  		{STABLES_AVAILABILITY     = {1,2,3,4,5,6,7,8,9,10,11,12}, LABEL = "MANE 1", 	 	DESCRIPTION = "A nice touch of customization for your horse", DOLLARS =   15.0, GOLD = 0.0, TYPE = 3, TEXTURE = 1, TINTA = 0  ,TINTB = 0     , TINTC =  0,   CUSTOMIZABLE = true, CUSTOM_ROLELOCK = false, CUSTOM_ROLES = {""}, CUSTOM_PLAYERLOCK = false, CUSTOM_PLAYERS = {""}, ROLELOCK = false, ROLES = {"none"}, PLAYERLOCK = false, PLAYERS = {""}, image = "items/generic_horse_equip_mane.png"},	 		 
         },
     }, 	
	[5] = {		
		NAME = "MANE TYPE 4",
			OPTIONS = {
  		{STABLES_AVAILABILITY     = {1,2,3,4,5,6,7,8,9,10,11,12}, LABEL = "MANE 1", 	 	DESCRIPTION = "A nice touch of customization for your horse", DOLLARS =   15.0, GOLD = 0.0, TYPE = 4, TEXTURE = 1, TINTA = 0  ,TINTB = 0     , TINTC =  0,   CUSTOMIZABLE = true, CUSTOM_ROLELOCK = false, CUSTOM_ROLES = {""}, CUSTOM_PLAYERLOCK = false, CUSTOM_PLAYERS = {""}, ROLELOCK = false, ROLES = {"none"}, PLAYERLOCK = false, PLAYERS = {""}, image = "items/generic_horse_equip_mane.png"},				
			},
		}, 	
    [6] = {
 	
        NAME = "MANE TYPE 5",
         OPTIONS = {
  		{STABLES_AVAILABILITY     = {1,2,3,4,5,6,7,8,9,10,11,12}, LABEL = "MANE 1",    	DESCRIPTION = "A nice touch of customization for your horse", DOLLARS =   15.0, GOLD = 0.0, TYPE = 5, TEXTURE = 1, TINTA = 0  ,TINTB = 0     , TINTC =  0,   CUSTOMIZABLE = true, CUSTOM_ROLELOCK = false, CUSTOM_ROLES = {""}, CUSTOM_PLAYERLOCK = false, CUSTOM_PLAYERS = {""}, ROLELOCK = false, ROLES = {"none"}, PLAYERLOCK = false, PLAYERS = {""}, image = "items/generic_horse_equip_mane.png"},			 
         },
     }, 
     [7] = {
        NAME = "MANE TYPE 6",
         OPTIONS = {
  		{STABLES_AVAILABILITY     = {1,2,3,4,5,6,7,8,9,10,11,12}, LABEL = "MANE 1", 	 	DESCRIPTION = "A nice touch of customization for your horse", DOLLARS =   15.0, GOLD = 0.0, TYPE = 6, TEXTURE = 1, TINTA = 0  ,TINTB = 0     , TINTC =  0,   CUSTOMIZABLE = true, CUSTOM_ROLELOCK = false, CUSTOM_ROLES = {""}, CUSTOM_PLAYERLOCK = false, CUSTOM_PLAYERS = {""}, ROLELOCK = false, ROLES = {"none"}, PLAYERLOCK = false, PLAYERS = {""}, image = "items/generic_horse_equip_mane.png"},		 
         },
     }, 
     [8] = {
        NAME = "MANE TYPE 7",
         OPTIONS = {
  		{STABLES_AVAILABILITY     = {1,2,3,4,5,6,7,8,9,10,11,12}, LABEL = "MANE 1", 	    DESCRIPTION = "A nice touch of customization for your horse", DOLLARS =   15.0, GOLD = 0.0, TYPE = 7, TEXTURE = 1, TINTA = 0  ,TINTB = 0     , TINTC =  0,   CUSTOMIZABLE = true, CUSTOM_ROLELOCK = false, CUSTOM_ROLES = {""}, CUSTOM_PLAYERLOCK = false, CUSTOM_PLAYERS = {""}, ROLELOCK = false, ROLES = {"none"}, PLAYERLOCK = false, PLAYERS = {""}, image = "items/generic_horse_equip_mane.png"},	
         },                                                                     
     },                                                                         
      [9] = {                                                                   
        NAME = "MANE TYPE 8",                                                   
        OPTIONS = {                                                             
  		{STABLES_AVAILABILITY     = {1,2,3,4,5,6,7,8,9,10,11,12}, LABEL = "MANE 1", 	    DESCRIPTION = "A nice touch of customization for your horse", DOLLARS =   15.0, GOLD = 0.0, TYPE = 8, TEXTURE = 1, TINTA = 0  ,TINTB = 0     , TINTC =  0,   CUSTOMIZABLE = true, CUSTOM_ROLELOCK = false, CUSTOM_ROLES = {""}, CUSTOM_PLAYERLOCK = false, CUSTOM_PLAYERS = {""}, ROLELOCK = false, ROLES = {"none"}, PLAYERLOCK = false, PLAYERS = {""}, image = "items/generic_horse_equip_mane.png"},			
        },                                                                      
    },                                                                          
		[10] = {                                                                
        NAME = "MANE TYPE 9",                                                   
         OPTIONS = {                                                            
		{STABLES_AVAILABILITY     = {1,2,3,4,5,6,7,8,9,10,11,12}, LABEL = "MANE 1", 	    DESCRIPTION = "A nice touch of customization for your horse", DOLLARS =   15.0, GOLD = 0.0, TYPE = 9, TEXTURE = 1, TINTA = 0  ,TINTB = 0     , TINTC =  0,   CUSTOMIZABLE = true, CUSTOM_ROLELOCK = false, CUSTOM_ROLES = {""}, CUSTOM_PLAYERLOCK = false, CUSTOM_PLAYERS = {""}, ROLELOCK = false, ROLES = {"none"}, PLAYERLOCK = false, PLAYERS = {""}, image = "items/generic_horse_equip_mane.png"},	
		},                                                                      
	},                                                                          
       [11] = {                                                                 
        NAME = "MANE TYPE 10",                                                  
         OPTIONS = {                                                            
		{STABLES_AVAILABILITY     = {1,2,3,4,5,6,7,8,9,10,11,12}, LABEL = "MANE 1", 	    DESCRIPTION = "A nice touch of customization for your horse", DOLLARS =   15.0, GOLD = 0.0, TYPE = 10, TEXTURE = 1, TINTA = 0  ,TINTB = 0     , TINTC =  0,   CUSTOMIZABLE = true, CUSTOM_ROLELOCK = false, CUSTOM_ROLES = {""}, CUSTOM_PLAYERLOCK = false, CUSTOM_PLAYERS = {""}, ROLELOCK = false, ROLES = {"none"}, PLAYERLOCK = false, PLAYERS = {""}, image = "items/generic_horse_equip_mane.png"},	
         },
     },  
       [12] = {
        NAME = "MANE TYPE 11",
         OPTIONS = {
		 {STABLES_AVAILABILITY     = {1,2,3,4,5,6,7,8,9,10,11,12}, LABEL = "MANE 1", 	    DESCRIPTION = "A nice touch of customization for your horse", DOLLARS =   15.0, GOLD = 0.0, TYPE = 11, TEXTURE = 1, TINTA = 0  ,TINTB = 0     , TINTC =  0,   CUSTOMIZABLE = true, CUSTOM_ROLELOCK = false, CUSTOM_ROLES = {""}, CUSTOM_PLAYERLOCK = false, CUSTOM_PLAYERS = {""}, ROLELOCK = false, ROLES = {"none"}, PLAYERLOCK = false, PLAYERS = {""}, image = "items/generic_horse_equip_mane.png"},	
         },
     }, 
      [13] = {
        NAME = "MANE TYPE 12",
         OPTIONS = {
		 {STABLES_AVAILABILITY     = {1,2,3,4,5,6,7,8,9,10,11,12}, LABEL = "MANE 1", 	   DESCRIPTION = "A nice touch of customization for your horse", DOLLARS =   15.0, GOLD = 0.0, TYPE = 12, TEXTURE = 1, TINTA = 0  ,TINTB = 0     , TINTC =  0,   CUSTOMIZABLE = true, CUSTOM_ROLELOCK = false, CUSTOM_ROLES = {""}, CUSTOM_PLAYERLOCK = false, CUSTOM_PLAYERS = {""}, ROLELOCK = false, ROLES = {"none"}, PLAYERLOCK = false, PLAYERS = {""}, image = "items/generic_horse_equip_mane.png"},
         },
     },	
 
     [14] = {
        NAME = "MANE TYPE 13",
         OPTIONS = {
		 {STABLES_AVAILABILITY     = {1,2,3,4,5,6,7,8,9,10,11,12}, LABEL = "MANE 1", 	   DESCRIPTION = "A nice touch of customization for your horse", DOLLARS =   15.0, GOLD = 0.0, TYPE = 13, TEXTURE = 1, TINTA = 0  ,TINTB = 0     , TINTC =  0,   CUSTOMIZABLE = true, CUSTOM_ROLELOCK = false, CUSTOM_ROLES = {""}, CUSTOM_PLAYERLOCK = false, CUSTOM_PLAYERS = {""}, ROLELOCK = false, ROLES = {"none"}, PLAYERLOCK = false, PLAYERS = {""}, image = "items/generic_horse_equip_mane.png"},			 
         },
     },	
 	
     [15] = {
        NAME = "MANE TYPE 14",
         OPTIONS = {
		 {STABLES_AVAILABILITY     = {1,2,3,4,5,6,7,8,9,10,11,12}, LABEL = "MANE 1", 	   DESCRIPTION = "A nice touch of customization for your horse", DOLLARS =   15.0, GOLD = 0.0, TYPE = 14, TEXTURE = 1, TINTA = 0          ,TINTB = 0          ,TINTC = 0  , CUSTOMIZABLE = true, CUSTOM_ROLELOCK = false, CUSTOM_ROLES = {""}, CUSTOM_PLAYERLOCK = false, CUSTOM_PLAYERS = {""}, ROLELOCK = false, ROLES = {"none"}, PLAYERLOCK = false, PLAYERS = {""}, image = "items/generic_horse_equip_mane.png"}, -- "mulepainted_01   		 
         },
     },	 
	 
     [16] = {
        NAME = "MANE TYPE 15",
         OPTIONS = {
		 {STABLES_AVAILABILITY     = {1,2,3,4,5,6,7,8,9,10,11,12}, LABEL = "MANE 1", 	   DESCRIPTION = "A nice touch of customization for your horse", DOLLARS =   15.0, GOLD = 0.0, TYPE = 15, TEXTURE = 1, TINTA = 0          ,TINTB = 0          ,TINTC = 0  , CUSTOMIZABLE = true, CUSTOM_ROLELOCK = false, CUSTOM_ROLES = {""}, CUSTOM_PLAYERLOCK = false, CUSTOM_PLAYERS = {""}, ROLELOCK = false, ROLES = {"none"}, PLAYERLOCK = false, PLAYERS = {""}, image = "items/generic_horse_equip_mane.png"}, -- "mulepainted_01   		 
         },
     },	 
	 
     [17] = {
        NAME = "MANE TYPE 16",
         OPTIONS = {
		 {STABLES_AVAILABILITY     = {1,2,3,4,5,6,7,8,9,10,11,12}, LABEL = "MANE 1", 	   DESCRIPTION = "A nice touch of customization for your horse", DOLLARS =   15.0, GOLD = 0.0, TYPE = 16, TEXTURE = 1, TINTA = 0          ,TINTB = 0          ,TINTC = 0  , CUSTOMIZABLE = true, CUSTOM_ROLELOCK = false, CUSTOM_ROLES = {""}, CUSTOM_PLAYERLOCK = false, CUSTOM_PLAYERS = {""}, ROLELOCK = false, ROLES = {"none"}, PLAYERLOCK = false, PLAYERS = {""}, image = "items/generic_horse_equip_mane.png"}, -- "mulepainted_01   		 
         },
     },		 
	 
}


-------------------------------
       -- TAILS --
-------------------------------
 
Config.TAILS = {
    [1] = {
        NAME = "NO TAIL",
        OPTIONS = {
 		 {STABLES_AVAILABILITY     = {1,2,3,4,5,6,7,8,9,10,11,12}, LABEL = "NO TAIL", 	 		DESCRIPTION = "A nice touch of customization for your horse", DOLLARS =   0.0, GOLD = 0.0, TYPE = 0, TEXTURE = 1, TINTA = 0          ,TINTB = 0   ,TINTC = 0  , CUSTOMIZABLE = true, CUSTOM_ROLELOCK = false, CUSTOM_ROLES = {""}, CUSTOM_PLAYERLOCK = false, CUSTOM_PLAYERS = {""}, ROLELOCK = false, ROLES = {"none"}, PLAYERLOCK = false, PLAYERS = {""}, image = "items/generic_horse_equip_tail.png"},
        },
    },
    [2] = {
        NAME = "TAIL TYPE 1",
        OPTIONS = {
 		 {STABLES_AVAILABILITY     = {1,2,3,4,5,6,7,8,9,10,11,12}, LABEL = "TAIL 1", 	 		DESCRIPTION = "A nice touch of customization for your horse", DOLLARS =   15.0, GOLD = 0.0, TYPE = 1, TEXTURE = 1, TINTA = 0          ,TINTB = 0   ,TINTC = 0  , CUSTOMIZABLE = true, CUSTOM_ROLELOCK = false, CUSTOM_ROLES = {""}, CUSTOM_PLAYERLOCK = false, CUSTOM_PLAYERS = {""}, ROLELOCK = false, ROLES = {"none"}, PLAYERLOCK = false, PLAYERS = {""}, image = "items/generic_horse_equip_tail.png"},
        },
    },
    [3] = {
        NAME = "TAIL TYPE 2",
        OPTIONS = {
 		 {STABLES_AVAILABILITY     = {1,2,3,4,5,6,7,8,9,10,11,12}, LABEL = "TAIL 1", 	 		DESCRIPTION = "A nice touch of customization for your horse", DOLLARS =   15.0, GOLD = 0.0, TYPE = 2, TEXTURE = 1, TINTA = 0          ,TINTB = 0   ,TINTC = 0  , CUSTOMIZABLE = true, CUSTOM_ROLELOCK = false, CUSTOM_ROLES = {""}, CUSTOM_PLAYERLOCK = false, CUSTOM_PLAYERS = {""}, ROLELOCK = false, ROLES = {"none"}, PLAYERLOCK = false, PLAYERS = {""}, image = "items/generic_horse_equip_tail.png"},		
        },
    },	
    [4] = {
        NAME = "TAIL TYPE 3",
        OPTIONS = {
 		 {STABLES_AVAILABILITY     = {1,2,3,4,5,6,7,8,9,10,11,12}, LABEL = "TAIL 1", 	 		DESCRIPTION = "A nice touch of customization for your horse", DOLLARS =   15.0, GOLD = 0.0, TYPE = 3, TEXTURE = 1, TINTA = 0          ,TINTB = 0    ,TINTC = 0  , CUSTOMIZABLE = true, CUSTOM_ROLELOCK = false, CUSTOM_ROLES = {""}, CUSTOM_PLAYERLOCK = false, CUSTOM_PLAYERS = {""}, ROLELOCK = false, ROLES = {"none"}, PLAYERLOCK = false, PLAYERS = {""}, image = "items/generic_horse_equip_tail.png"},	
        },
    },
    [5] = {
        NAME = "TAIL TYPE 4",
        OPTIONS = {
 		 {STABLES_AVAILABILITY     = {1,2,3,4,5,6,7,8,9,10,11,12}, LABEL = "TAIL 1", 	 		DESCRIPTION = "A nice touch of customization for your horse", DOLLARS =   15.0, GOLD = 0.0, TYPE = 4, TEXTURE = 1, TINTA = 0          ,TINTB = 0    ,TINTC = 0  , CUSTOMIZABLE = true, CUSTOM_ROLELOCK = false, CUSTOM_ROLES = {""}, CUSTOM_PLAYERLOCK = false, CUSTOM_PLAYERS = {""}, ROLELOCK = false, ROLES = {"none"}, PLAYERLOCK = false, PLAYERS = {""}, image = "items/generic_horse_equip_tail.png"},	
        },
    },
    [6] = {
        NAME = "TAIL TYPE 5",
        OPTIONS = {
 		 {STABLES_AVAILABILITY     = {1,2,3,4,5,6,7,8,9,10,11,12}, LABEL = "TAIL 1", 	 		 DESCRIPTION = "A nice touch of customization for your horse", DOLLARS =   15.0, GOLD = 0.0, TYPE = 5, TEXTURE = 1, TINTA = 0          ,TINTB = 0   ,TINTC = 0  , CUSTOMIZABLE = true, CUSTOM_ROLELOCK = false, CUSTOM_ROLES = {""}, CUSTOM_PLAYERLOCK = false, CUSTOM_PLAYERS = {""}, ROLELOCK = false, ROLES = {"none"}, PLAYERLOCK = false, PLAYERS = {""}, image = "items/generic_horse_equip_tail.png"},	
        },
    },	 
    [7] = {
        NAME = "TAIL TYPE 6",
        OPTIONS = {
		{STABLES_AVAILABILITY     = {1,2,3,4,5,6,7,8,9,10,11,12}, LABEL = "TAIL 1", 	 		 DESCRIPTION = "A nice touch of customization for your horse", DOLLARS =   15.0, GOLD = 0.0, TYPE = 6, TEXTURE = 1, TINTA =  0		   ,TINTB = 0    ,TINTC = 0   , CUSTOMIZABLE = true, CUSTOM_ROLELOCK = false, CUSTOM_ROLES = {""}, CUSTOM_PLAYERLOCK = false, CUSTOM_PLAYERS = {""}, ROLELOCK = false, ROLES = {"none"}, PLAYERLOCK = false, PLAYERS = {""}, image = "items/generic_horse_equip_tail.png"},
        },
    },	
    [8] = {
        NAME = "TAIL TYPE 7",
        OPTIONS = {
		{STABLES_AVAILABILITY     = {1,2,3,4,5,6,7,8,9,10,11,12}, LABEL = "TAIL 1" , 	 		 DESCRIPTION = "A nice touch of customization for your horse", DOLLARS =   15.0, GOLD = 0.0, TYPE = 7, TEXTURE = 1, TINTA =  0			,TINTB = 0    ,TINTC = 0   , CUSTOMIZABLE = true, CUSTOM_ROLELOCK = false, CUSTOM_ROLES = {""}, CUSTOM_PLAYERLOCK = false, CUSTOM_PLAYERS = {""}, ROLELOCK = false, ROLES = {"none"}, PLAYERLOCK = false, PLAYERS = {""}, image = "items/generic_horse_equip_tail.png"},
        },
    },		
}

-------------------------------
       -- MUSTACHES --
-------------------------------

Config.MUSTACHES = {
    [1] = {
        NAME = "NO MUSTACHE",
        OPTIONS = {
 		{STABLES_AVAILABILITY     = {1,2,3,4,5,6,7,8,9,10,11,12}, LABEL = "No Mustache", 	DESCRIPTION = "A nice touch of customization for your horse", DOLLARS = 0.0, GOLD = 0.0, TYPE = 0, TEXTURE = 1, TINTA = 0 ,  TINTB = 0  , TINTC = 0 ,   CUSTOMIZABLE = true, CUSTOM_ROLELOCK = false, CUSTOM_ROLES = {""}, CUSTOM_PLAYERLOCK = false, CUSTOM_PLAYERS = {""}, ROLELOCK = false, ROLES = {"none"}, PLAYERLOCK = false, PLAYERS = {""}, image = "items/generic_horse_equip_mustache.png" },			
		}, 
	},
    [2] = {
        NAME = "MUSTACHE TYPE 1",
        OPTIONS = {
 		{STABLES_AVAILABILITY     = {1,2,3,4,5,6,7,8,9,10,11,12}, LABEL = "MUSTACHE 1", 	DESCRIPTION = "A nice touch of customization for your horse", DOLLARS = 10.0, GOLD = 0.0, TYPE = 1, TEXTURE = 1, TINTA = 0 ,  TINTB = 0  , TINTC = 0 ,   CUSTOMIZABLE = true, CUSTOM_ROLELOCK = false, CUSTOM_ROLES = {""}, CUSTOM_PLAYERLOCK = false, CUSTOM_PLAYERS = {""}, ROLELOCK = false, ROLES = {"none"}, PLAYERLOCK = false, PLAYERS = {""}, image = "items/generic_horse_equip_mustache.png" },			
		},
    },

    [3] = {
        NAME = "MUSTACHE TYPE 2",
        OPTIONS = {
 		{STABLES_AVAILABILITY     = {1,2,3,4,5,6,7,8,9,10,11,12}, LABEL = "MUSTACHE 1",	DESCRIPTION = "A nice touch of customization for your horse", DOLLARS = 10.0, GOLD = 0.0, TYPE = 2, TEXTURE = 1, TINTA = 0 ,  TINTB = 0  , TINTC = 0 ,   CUSTOMIZABLE = true, CUSTOM_ROLELOCK = false, CUSTOM_ROLES = {""}, CUSTOM_PLAYERLOCK = false, CUSTOM_PLAYERS = {""}, ROLELOCK = false, ROLES = {"none"}, PLAYERLOCK = false, PLAYERS = {""}, image = "items/generic_horse_equip_mustache.png" },			
		},
    },

    [4] = {
        NAME = "MUSTACHE TYPE 3",
        OPTIONS = {
 		{STABLES_AVAILABILITY     = {1,2,3,4,5,6,7,8,9,10,11,12}, LABEL = "MUSTACHE 1", 	DESCRIPTION = "A nice touch of customization for your horse", DOLLARS = 10.0, GOLD = 0.0, TYPE = 3, TEXTURE = 1, TINTA = 0 ,  TINTB = 0  , TINTC = 0 ,   CUSTOMIZABLE = true, CUSTOM_ROLELOCK = false, CUSTOM_ROLES = {""}, CUSTOM_PLAYERLOCK = false, CUSTOM_PLAYERS = {""}, ROLELOCK = false, ROLES = {"none"}, PLAYERLOCK = false, PLAYERS = {""}, image = "items/generic_horse_equip_mustache.png" },			
		},
    },

    [5] = {
        NAME = "MUSTACHE TYPE 4",
        OPTIONS = {
 		{STABLES_AVAILABILITY     = {1,2,3,4,5,6,7,8,9,10,11,12}, LABEL = "MUSTACHE 1", 	DESCRIPTION = "A nice touch of customization for your horse", DOLLARS = 10.0, GOLD = 0.0, TYPE = 4, TEXTURE = 1, TINTA = 0 ,  TINTB = 0  , TINTC = 0 ,   CUSTOMIZABLE = true, CUSTOM_ROLELOCK = false, CUSTOM_ROLES = {""}, CUSTOM_PLAYERLOCK = false, CUSTOM_PLAYERS = {""}, ROLELOCK = false, ROLES = {"none"}, PLAYERLOCK = false, PLAYERS = {""}, image = "items/generic_horse_equip_mustache.png" },			
		},
    },		
}


Config.FEATHERS = {
    [1] = {
        NAME = "NO FEATHERS",
        OPTIONS = {
 		 {STABLES_AVAILABILITY     = {1,2,3,4,5,6,7,8,9,10,11,12}, LABEL = "No Feathers", 	DESCRIPTION = "A nice touch of customization for your horse", DOLLARS = 0.0, GOLD = 0.0, TYPE = 0, TEXTURE = 1, TINTA = 0 ,  TINTB = 0  , TINTC = 0 ,   CUSTOMIZABLE = true, CUSTOM_ROLELOCK = false, CUSTOM_ROLES = {""}, CUSTOM_PLAYERLOCK = false, CUSTOM_PLAYERS = {""}, ROLELOCK = false, ROLES = {"none"}, PLAYERLOCK = false, PLAYERS = {""}, image = "items/generic_horse_equip_mustache.png" },			   
		},	
	},	
	
    [2] = {
        NAME = "FEATHERS TYPE 1",
        OPTIONS = {
 		 {STABLES_AVAILABILITY     = {1,2,3,4,5,6,7,8,9,10,11,12}, LABEL = "FEATHERS 1", 	DESCRIPTION = "A nice touch of customization for your horse", DOLLARS = 0.0, GOLD = 0.0, TYPE = 1, TEXTURE = 1, TINTA = 0 ,  TINTB = 0  , TINTC = 0 ,   CUSTOMIZABLE = true, CUSTOM_ROLELOCK = false, CUSTOM_ROLES = {""}, CUSTOM_PLAYERLOCK = false, CUSTOM_PLAYERS = {""}, ROLELOCK = false, ROLES = {"none"}, PLAYERLOCK = false, PLAYERS = {""}, image = "items/generic_horse_equip_mustache.png" },			   
		},	
	},		
}


Config.EYELASHES = {
    [1] = {
        NAME = "EYELASHES TYPE 1",
        OPTIONS = {
 		 {STABLES_AVAILABILITY     = {1,2,3,4,5,6,7,8,9,10,11,12}, LABEL = "EYELASHES", 	DESCRIPTION = "A nice touch of customization for your horse", DOLLARS = 0.0, GOLD = 0.0, TYPE = 1, TEXTURE = 1, TINTA = 0 ,  TINTB = 0  , TINTC = 0 ,   CUSTOMIZABLE = true, CUSTOM_ROLELOCK = false, CUSTOM_ROLES = {""}, CUSTOM_PLAYERLOCK = false, CUSTOM_PLAYERS = {""}, ROLELOCK = false, ROLES = {"none"}, PLAYERLOCK = false, PLAYERS = {""}, image = "items/generic_horse_equip_mustache.png" },			   
		},	
	},		
}
 
 
-------------------------------
       -- SHOES --
-------------------------------

-- THESE CANT BE CUSTOMIZED !
Config.SHOES = {
    [1] = {
        NAME = "NO SHOES",
        OPTIONS = {
		{STABLES_AVAILABILITY     = {1,2,3,4,5,6,7,8,9,10,11,12}, LABEL = "NO SHOES"									,  DESCRIPTION = "Remove this element from your horse",  DOLLARS = 0.0, GOLD = 0.0, TYPE = 0, TINTA = 0    , TINTB = 0    , TINTC = 0   , CUSTOMIZABLE = false, CUSTOM_ROLELOCK = false, CUSTOM_ROLES = {""}, CUSTOM_PLAYERLOCK = false, CUSTOM_PLAYERS = {""}, ROLELOCK = false, ROLES = {"none"}, PLAYERLOCK = false, PLAYERS = {""}, image = "items/horse_shoe.png"},			
         },
    },

    [2] = {
        NAME = "SHOES",
        OPTIONS = {
		{STABLES_AVAILABILITY     = {1,2,3,4,5,6,7,8,9,10,11,12}, LABEL = "Standard Hooves"							,  DESCRIPTION = "A nice piece of tack for your horse", DOLLARS = 5.0, GOLD = 0.0, TYPE = 1, TINTA = 0    , TINTB = 0    , TINTC = 0   , CUSTOMIZABLE = false, CUSTOM_ROLELOCK = false, CUSTOM_ROLES = {""}, CUSTOM_PLAYERLOCK = false, CUSTOM_PLAYERS = {""}, ROLELOCK = false, ROLES = {"none"}, PLAYERLOCK = false, PLAYERS = {""}, image = "items/horse_shoe.png"},			
		{STABLES_AVAILABILITY     = {1,2,3,4,5,6,7,8,9,10,11,12}, LABEL = "Flaming Hooves" 							,  DESCRIPTION = "A nice piece of tack for your horse", DOLLARS = 5.0, GOLD = 0.0, TYPE = 2, TINTA = 0    , TINTB = 0    , TINTC = 0   , CUSTOMIZABLE = false, CUSTOM_ROLELOCK = false, CUSTOM_ROLES = {""}, CUSTOM_PLAYERLOCK = false, CUSTOM_PLAYERS = {""}, ROLELOCK = false, ROLES = {"none"}, PLAYERLOCK = false, PLAYERS = {""}, image = "items/horse_shoe.png"},			
        },
    }, 	
}

-------------------------------
       -- HOLSTERS --
-------------------------------
Config.HOLSTERS = {
    [1] =  {
        NAME = "NO HOLSTERS",
        OPTIONS = {	
 		 {STABLES_AVAILABILITY     = {1,2,3,4,5,6,7,8,9,10,11,12}, LABEL = "NO HOLSTER"                    			, DESCRIPTION = "Remove this element from your horse", DOLLARS = 0.0, GOLD = 0.0, TYPE = 0, TINTA = 0, TINTB = 0,  TINTC = 0, CUSTOMIZABLE = false, CUSTOM_ROLELOCK = false, CUSTOM_ROLES = {""}, CUSTOM_PLAYERLOCK = false, CUSTOM_PLAYERS = {""}, ROLELOCK = false, ROLES = {"none"}, PLAYERLOCK = false, PLAYERS = {""}, image = "items/generic_horse_equip_tail.png"},			
        },
    },
    [2] =  {
        NAME = "HOLSTERS",
        OPTIONS = {	
 		 {STABLES_AVAILABILITY     = {1,2,3,4,5,6,7,8,9,10,11,12}, LABEL = "Holster 1"                   				, DESCRIPTION = "A nice piece of tack for your horse", DOLLARS = 15.0, GOLD = 0.0, TYPE = 1, TINTA = 21, TINTB = 21,  TINTC = 21, CUSTOMIZABLE = true, CUSTOM_ROLELOCK = false, CUSTOM_ROLES = {""}, CUSTOM_PLAYERLOCK = false, CUSTOM_PLAYERS = {""}, ROLELOCK = false, ROLES = {"none"}, PLAYERLOCK = false, PLAYERS = {""}, image = "items/generic_horse_equip_tail.png"},			
        },
    },	
}

-------------------------------
       -- EXTRAS --
-------------------------------
 
Config.LANTERNS = {
    [1] = {
        NAME = "NO LANTERNS",
        OPTIONS = {
 		 {STABLES_AVAILABILITY     = {1,2,3,4,5,6,7,8,9,10,11,12}, LABEL = "NO LANTERNS"                	   		 	,DESCRIPTION = "Remove this element from your horse", 	DOLLARS = 0.0, GOLD = 0.0, TYPE = 0, TINTA = 0, TINTB = 0,  TINTC = 0, CUSTOMIZABLE = false, CUSTOM_ROLELOCK = false, CUSTOM_ROLES = {""}, CUSTOM_PLAYERLOCK = false, CUSTOM_PLAYERS = {""}, ROLELOCK = false, ROLES = {"none"}, PLAYERLOCK = false, PLAYERS = {""}, image = "items/generic_horse_equip_lantern.png"},				
        },
    },
 
    [2] = {
        NAME = "Lanterns and Harness",
        OPTIONS = {
 		 {STABLES_AVAILABILITY     = {1,2,3,4,5,6,7,8,9,10,11,12}, LABEL = "Lantern + Harness"                			,DESCRIPTION = "A nice piece of tack for your horse",    DOLLARS = 45.0, GOLD = 0.0, TYPE = 1, TINTA = 13, TINTB = 103,  TINTC = 101, CUSTOMIZABLE = true, CUSTOM_ROLELOCK = false, CUSTOM_ROLES = {""}, CUSTOM_PLAYERLOCK = false, CUSTOM_PLAYERS = {""}, ROLELOCK = false, ROLES = {"none"}, PLAYERLOCK = false, PLAYERS = {""}, image = "items/generic_horse_equip_lantern.png"},				
 		 {STABLES_AVAILABILITY     = {1,2,3,4,5,6,7,8,9,10,11,12}, LABEL = "Half Harness"                      		,DESCRIPTION = "A nice piece of tack for your horse",    DOLLARS = 45.0, GOLD = 0.0, TYPE = 2, TINTA = 13, TINTB = 103,  TINTC = 101, CUSTOMIZABLE = true, CUSTOM_ROLELOCK = false, CUSTOM_ROLES = {""}, CUSTOM_PLAYERLOCK = false, CUSTOM_PLAYERS = {""}, ROLELOCK = false, ROLES = {"none"}, PLAYERLOCK = false, PLAYERS = {""}, image = "items/generic_horse_equip_lantern.png"},
        },
    },
}

Config.FULL_HARNESSES = {	
    [1] = {
        NAME = "NO FULL HARNESS",
        OPTIONS = {
 		 {STABLES_AVAILABILITY     = {1,2,3,4,5,6,7,8,9,10,11,12}, LABEL = "NO HARNESS"                         		,DESCRIPTION = "Remove this element from your horse",    DOLLARS =   0.0, GOLD = 0.0, TYPE = 0, TINTA = 0, TINTB = 0,  TINTC = 0, CUSTOMIZABLE = false, CUSTOM_ROLELOCK = false, CUSTOM_ROLES = {""}, CUSTOM_PLAYERLOCK = false, CUSTOM_PLAYERS = {""}, ROLELOCK = false, ROLES = {"none"}, PLAYERLOCK = false, PLAYERS = {""}, image = "items/generic_horse_equip_lantern.png"},
        },
    },

    [2] = {
        NAME = "FULL HARNESS",
        OPTIONS = {
 		 {STABLES_AVAILABILITY     = {1,2,3,4,5,6,7,8,9,10,11,12}, LABEL = "Harness"                            		,DESCRIPTION = "A nice piece of tack for your horse",    DOLLARS =   80.0, GOLD = 0.0, TYPE = 1, TINTA = 0, TINTB = 0,  TINTC = 0, CUSTOMIZABLE = false, CUSTOM_ROLELOCK = false, CUSTOM_ROLES = {""}, CUSTOM_PLAYERLOCK = false, CUSTOM_PLAYERS = {""}, ROLELOCK = false, ROLES = {"none"}, PLAYERLOCK = false, PLAYERS = {""}, image = "items/generic_horse_equip_lantern.png"},
        },
    },
}
	
Config.LASSOS = {
    [1] = {
        NAME = "NO ACCESSORIES",
        OPTIONS = {                                                                                                                          
 		 {STABLES_AVAILABILITY     = {1,2,3,4,5,6,7,8,9,10,11,12}, LABEL = "NO ACCESSORIES"                     		,DESCRIPTION = "Remove this element from your horse",   DOLLARS = 0.0, GOLD = 0.0, TYPE = 0, TINTA = 0,   TINTB = 0,    TINTC = 0,   CUSTOMIZABLE = false, CUSTOM_ROLELOCK = false, CUSTOM_ROLES = {""}, CUSTOM_PLAYERLOCK = false, CUSTOM_PLAYERS = {""}, ROLELOCK = false, ROLES = {"none"}, PLAYERLOCK = false, PLAYERS = {""}, image = "items/generic_horse_equip_lantern.png"},
        },
	},
	
    [2] = {
        NAME = "ACCESSORIES",
        OPTIONS = {                                                                                                                          
 		 {STABLES_AVAILABILITY     = {1,2,3,4,5,6,7,8,9,10,11,12}, LABEL = "Lasso Right"                        		,DESCRIPTION = "A nice piece of tack for your horse", DOLLARS = 10.0, GOLD = 0.0, TYPE = 1 , TINTA = 0,   TINTB = 0,    TINTC = 0,   CUSTOMIZABLE = false, CUSTOM_ROLELOCK = false, CUSTOM_ROLES = {""}, CUSTOM_PLAYERLOCK = false, CUSTOM_PLAYERS = {""}, ROLELOCK = false, ROLES = {"none"}, PLAYERLOCK = false, PLAYERS = {""}, image = "items/generic_horse_equip_lantern.png"},
 		 {STABLES_AVAILABILITY     = {1,2,3,4,5,6,7,8,9,10,11,12}, LABEL = "Flask Right"                        		,DESCRIPTION = "A nice piece of tack for your horse", DOLLARS = 5.0,  GOLD = 0.0, TYPE = 2 , TINTA = 0,   TINTB = 0,    TINTC = 0,   CUSTOMIZABLE = false, CUSTOM_ROLELOCK = false, CUSTOM_ROLES = {""}, CUSTOM_PLAYERLOCK = false, CUSTOM_PLAYERS = {""}, ROLELOCK = false, ROLES = {"none"}, PLAYERLOCK = false, PLAYERS = {""}, image = "items/generic_horse_equip_lantern.png"},
 		 {STABLES_AVAILABILITY     = {1,2,3,4,5,6,7,8,9,10,11,12}, LABEL = "Lasso R + Flask R"                  		,DESCRIPTION = "A nice piece of tack for your horse", DOLLARS = 15.0, GOLD = 0.0, TYPE = 3 , TINTA = 0,   TINTB = 0,    TINTC = 0,   CUSTOMIZABLE = false, CUSTOM_ROLELOCK = false, CUSTOM_ROLES = {""}, CUSTOM_PLAYERLOCK = false, CUSTOM_PLAYERS = {""}, ROLELOCK = false, ROLES = {"none"}, PLAYERLOCK = false, PLAYERS = {""}, image = "items/generic_horse_equip_lantern.png"},
 		 {STABLES_AVAILABILITY     = {1,2,3,4,5,6,7,8,9,10,11,12}, LABEL = "Lasso Left"                         		,DESCRIPTION = "A nice piece of tack for your horse", DOLLARS = 10.0, GOLD = 0.0, TYPE = 4 , TINTA = 189, TINTB = 189,  TINTC = 254, CUSTOMIZABLE = false, CUSTOM_ROLELOCK = false, CUSTOM_ROLES = {""}, CUSTOM_PLAYERLOCK = false, CUSTOM_PLAYERS = {""}, ROLELOCK = false, ROLES = {"none"}, PLAYERLOCK = false, PLAYERS = {""}, image = "items/generic_horse_equip_lantern.png"},
 		 {STABLES_AVAILABILITY     = {1,2,3,4,5,6,7,8,9,10,11,12}, LABEL = "Lasso Rear Right"                   		,DESCRIPTION = "A nice piece of tack for your horse", DOLLARS = 10.0, GOLD = 0.0, TYPE = 5 , TINTA = 189, TINTB = 189,  TINTC = 254, CUSTOMIZABLE = false, CUSTOM_ROLELOCK = false, CUSTOM_ROLES = {""}, CUSTOM_PLAYERLOCK = false, CUSTOM_PLAYERS = {""}, ROLELOCK = false, ROLES = {"none"}, PLAYERLOCK = false, PLAYERS = {""}, image = "items/generic_horse_equip_lantern.png"},
        },
	},		
}	


-------------------------------
       -- MASKS --
-------------------------------

Config.MASKS = {
    [1] = {
        NAME = "NO MASK",
        OPTIONS = {
 		 {STABLES_AVAILABILITY     = {1,2,3,4,5,6,7,8,9,10,11,12}, LABEL = "NO MASK"                             ,DESCRIPTION = "Remove this element from your horse", DOLLARS =   0.0, GOLD = 0.0, TYPE = 0,  TINTA = 0,   TINTB = 0   , TINTC = 0 ,   CUSTOMIZABLE = false, CUSTOM_ROLELOCK = false, CUSTOM_ROLES = {""}, CUSTOM_PLAYERLOCK = false, CUSTOM_PLAYERS = {""}, ROLELOCK = false, ROLES = {"none"}, PLAYERLOCK = false, PLAYERS = {""}, image = "items/generic_horse_equip_mask.png" },			
         },
    },
	
    [2] = {
        NAME = "Buck Masks",
        OPTIONS = {
 		 {STABLES_AVAILABILITY     = {1,2,3,4,5,6,7,8,9,10,11,12}, LABEL = "Buck Mask 1"                         ,DESCRIPTION = "A nice piece of tack for your horse", DOLLARS =   10.0, GOLD = 0.0, TYPE = 1,  TINTA = 19,   TINTB = 21   , TINTC = 15 ,   CUSTOMIZABLE = true, CUSTOM_ROLELOCK = false, CUSTOM_ROLES = {""}, CUSTOM_PLAYERLOCK = false, CUSTOM_PLAYERS = {""}, ROLELOCK = false, ROLES = {"none"}, PLAYERLOCK = false, PLAYERS = {""}, image = "items/generic_horse_equip_mask.png" },			
 		 {STABLES_AVAILABILITY     = {1,2,3,4,5,6,7,8,9,10,11,12}, LABEL = "Buck Mask 2"                         ,DESCRIPTION = "A nice piece of tack for your horse", DOLLARS =   10.0, GOLD = 0.0, TYPE = 2,  TINTA = 78,   TINTB = 54   , TINTC = 78 ,   CUSTOMIZABLE = true, CUSTOM_ROLELOCK = false, CUSTOM_ROLES = {""}, CUSTOM_PLAYERLOCK = false, CUSTOM_PLAYERS = {""}, ROLELOCK = false, ROLES = {"none"}, PLAYERLOCK = false, PLAYERS = {""}, image = "items/generic_horse_equip_mask.png" },	
        },
    },
	
    [3] = {
        NAME = "Bison Masks",
        OPTIONS = {
 		 {STABLES_AVAILABILITY     = {1,2,3,4,5,6,7,8,9,10,11,12}, LABEL = "Bison Mask 1"                         ,DESCRIPTION = "A nice piece of tack for your horse", DOLLARS =   10.0, GOLD = 0.0, TYPE = 3, TINTA = 78 ,  TINTB = 54   , TINTC = 78 ,   CUSTOMIZABLE = true, CUSTOM_ROLELOCK = false, CUSTOM_ROLES = {""}, CUSTOM_PLAYERLOCK = false, CUSTOM_PLAYERS = {""}, ROLELOCK = false, ROLES = {"none"}, PLAYERLOCK = false, PLAYERS = {""}, image = "items/generic_horse_equip_mask.png" },			
 		 {STABLES_AVAILABILITY     = {1,2,3,4,5,6,7,8,9,10,11,12}, LABEL = "Bison Mask 2"                         ,DESCRIPTION = "A nice piece of tack for your horse", DOLLARS =   10.0, GOLD = 0.0, TYPE = 4, TINTA = 50 ,  TINTB = 235  , TINTC = 110,   CUSTOMIZABLE = true, CUSTOM_ROLELOCK = false, CUSTOM_ROLES = {""}, CUSTOM_PLAYERLOCK = false, CUSTOM_PLAYERS = {""}, ROLELOCK = false, ROLES = {"none"}, PLAYERLOCK = false, PLAYERS = {""}, image = "items/generic_horse_equip_mask.png" },	
 		 {STABLES_AVAILABILITY     = {1,2,3,4,5,6,7,8,9,10,11,12}, LABEL = "Bison Mask 3"                         ,DESCRIPTION = "A nice piece of tack for your horse", DOLLARS =   10.0, GOLD = 0.0, TYPE = 5, TINTA = 254,  TINTB = 186  , TINTC = 45 ,   CUSTOMIZABLE = true, CUSTOM_ROLELOCK = false, CUSTOM_ROLES = {""}, CUSTOM_PLAYERLOCK = false, CUSTOM_PLAYERS = {""}, ROLELOCK = false, ROLES = {"none"}, PLAYERLOCK = false, PLAYERS = {""}, image = "items/generic_horse_equip_mask.png" },			
 		 {STABLES_AVAILABILITY     = {1,2,3,4,5,6,7,8,9,10,11,12}, LABEL = "Bison Mask 4"                         ,DESCRIPTION = "A nice piece of tack for your horse", DOLLARS =   10.0, GOLD = 0.0, TYPE = 6, TINTA = 213,  TINTB = 104  , TINTC = 195,   CUSTOMIZABLE = true, CUSTOM_ROLELOCK = false, CUSTOM_ROLES = {""}, CUSTOM_PLAYERLOCK = false, CUSTOM_PLAYERS = {""}, ROLELOCK = false, ROLES = {"none"}, PLAYERLOCK = false, PLAYERS = {""}, image = "items/generic_horse_equip_mask.png" },			
 		 
        },
    },
	
    [4] = {
        NAME = "Ram Masks",
        OPTIONS = {
 		 {STABLES_AVAILABILITY     = {1,2,3,4,5,6,7,8,9,10,11,12}, LABEL = "Ram Mask 1"                       		,DESCRIPTION = "A nice piece of tack for your horse", DOLLARS =   10.0, GOLD = 0.0, TYPE = 7, TINTA = 57 ,  TINTB = 5    , TINTC = 33 ,   CUSTOMIZABLE = true, CUSTOM_ROLELOCK = false, CUSTOM_ROLES = {""}, CUSTOM_PLAYERLOCK = false, CUSTOM_PLAYERS = {""}, ROLELOCK = false, ROLES = {"none"}, PLAYERLOCK = false, PLAYERS = {""}, image = "items/generic_horse_equip_mask.png" },  
 		 {STABLES_AVAILABILITY     = {1,2,3,4,5,6,7,8,9,10,11,12}, LABEL = "Ram Mask 2"                       		,DESCRIPTION = "A nice piece of tack for your horse", DOLLARS =   10.0, GOLD = 0.0, TYPE = 8, TINTA = 54 ,  TINTB = 107  , TINTC = 102,   CUSTOMIZABLE = true, CUSTOM_ROLELOCK = false, CUSTOM_ROLES = {""}, CUSTOM_PLAYERLOCK = false, CUSTOM_PLAYERS = {""}, ROLELOCK = false, ROLES = {"none"}, PLAYERLOCK = false, PLAYERS = {""}, image = "items/generic_horse_equip_mask.png" },			
   		 
        },
    },
	
    [5] = {
        NAME = "Unicorn Masks",
        OPTIONS = {
 		 {STABLES_AVAILABILITY     = {1,2,3,4,5,6,7,8,9,10,11,12}, LABEL = "Unicorn Mask 1"                         ,DESCRIPTION = "A nice piece of tack for your horse", DOLLARS =   10.0, GOLD = 0.0, TYPE = 9, TINTA = 110,  TINTB = 138  , TINTC = 132,   CUSTOMIZABLE = true, CUSTOM_ROLELOCK = false, CUSTOM_ROLES = {""}, CUSTOM_PLAYERLOCK = false, CUSTOM_PLAYERS = {""}, ROLELOCK = false, ROLES = {"none"}, PLAYERLOCK = false, PLAYERS = {""}, image = "items/generic_horse_equip_mask.png" },			
 		 {STABLES_AVAILABILITY     = {1,2,3,4,5,6,7,8,9,10,11,12}, LABEL = "Unicorn Mask 2"                         ,DESCRIPTION = "A nice piece of tack for your horse", DOLLARS =   10.0, GOLD = 0.0, TYPE = 10, TINTA = 189,  TINTB = 48   , TINTC = 220,   CUSTOMIZABLE = true, CUSTOM_ROLELOCK = false, CUSTOM_ROLES = {""}, CUSTOM_PLAYERLOCK = false, CUSTOM_PLAYERS = {""}, ROLELOCK = false, ROLES = {"none"}, PLAYERLOCK = false, PLAYERS = {""}, image = "items/generic_horse_equip_mask.png" }, 
        },
    },
	
    [6] = {
        NAME = "Sabertooth Masks",
        OPTIONS = {
  		 {STABLES_AVAILABILITY     = {1,2,3,4,5,6,7,8,9,10,11,12}, LABEL = "Sabertooth Mask 1"                   	,DESCRIPTION = "A nice piece of tack for your horse", DOLLARS =   10.0, GOLD = 0.0, TYPE = 11, TINTA = 71 ,  TINTB = 155  , TINTC = 248,   CUSTOMIZABLE = true, CUSTOM_ROLELOCK = false, CUSTOM_ROLES = {""}, CUSTOM_PLAYERLOCK = false, CUSTOM_PLAYERS = {""}, ROLELOCK = false, ROLES = {"none"}, PLAYERLOCK = false, PLAYERS = {""}, image = "items/generic_horse_equip_mask.png" },			
         },
    },
	
    [7] = {
        NAME = "Snake Masks",
        OPTIONS = {
 		 {STABLES_AVAILABILITY     = {1,2,3,4,5,6,7,8,9,10,11,12}, LABEL = "Snake Mask 1"                        	,DESCRIPTION = "A nice piece of tack for your horse", DOLLARS =   10.0, GOLD = 0.0, TYPE = 12, TINTA = 17 ,  TINTB = 108  , TINTC = 88 ,   CUSTOMIZABLE = true, CUSTOM_ROLELOCK = false, CUSTOM_ROLES = {""}, CUSTOM_PLAYERLOCK = false, CUSTOM_PLAYERS = {""}, ROLELOCK = false, ROLES = {"none"}, PLAYERLOCK = false, PLAYERS = {""}, image = "items/generic_horse_equip_mask.png" },			
 		 {STABLES_AVAILABILITY     = {1,2,3,4,5,6,7,8,9,10,11,12}, LABEL = "Snake Mask 2"                        	,DESCRIPTION = "A nice piece of tack for your horse", DOLLARS =   10.0, GOLD = 0.0, TYPE = 13, TINTA = 17 ,  TINTB = 108  , TINTC = 88 ,   CUSTOMIZABLE = true, CUSTOM_ROLELOCK = false, CUSTOM_ROLES = {""}, CUSTOM_PLAYERLOCK = false, CUSTOM_PLAYERS = {""}, ROLELOCK = false, ROLES = {"none"}, PLAYERLOCK = false, PLAYERS = {""}, image = "items/generic_horse_equip_mask.png" },			
         },
    },
}