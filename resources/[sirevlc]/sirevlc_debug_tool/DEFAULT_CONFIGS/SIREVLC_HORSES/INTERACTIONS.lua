Config = Config or {}
-------------------------------------------------------  
-------------------------------------------------------   
------------------------------------------------------- 

--////////////////////////////////////////////////////--
				-- INTERACTIONS --		
--////////////////////////////////////////////////////--	

-------------------------------------------------------  
-------------------------------------------------------  
-------------------------------------------------------   
-------------------------------------
    -- LIST OF EVENTS --
-------------------------------------
-- LIST OF EVENTS TO USE IN YOUR EVENTS OR REGISTERUSABLEITEM EXPORTS (SEE ITEM TXT FILE)

--"BRUSHING"
--TriggerClientEvent("SIREVLC_STABLES_ITEM_INTERACTION", _source, "BRUSHING", item_name)

--"FEEDING"
--TriggerClientEvent("SIREVLC_STABLES_ITEM_INTERACTION", _source, "FEEDING", item_name)

--"OINTMENT"
--TriggerClientEvent("SIREVLC_STABLES_ITEM_INTERACTION", _source, "OINTMENT", item_name)

--"STIMULANT"
--TriggerClientEvent("SIREVLC_STABLES_ITEM_INTERACTION", _source, "STIMULANT", item_name) 

--"FEED_BOOST"
--TriggerClientEvent("SIREVLC_STABLES_ITEM_INTERACTION", _source, "FEED_BOOST", item_name) 

--"SHOE_CLEANING"
--TriggerClientEvent("SIREVLC_STABLES_ITEM_INTERACTION", _source, "SHOE_CLEANING", item_name) 

--"DRINKING"
--TriggerClientEvent("SIREVLC_STABLES_ITEM_INTERACTION", _source, "DRINKING", item_name) 

 
-- YOU CAN'T ADD MORE INTERACTIONS, THESE NEED TO BE HARDCODED.
Config.INTERACTIONS   = {

[1] = {ACTION    		 	   	   = "BRUSHING", 									  -- TABLE LABEL FOR THE INTERACTION, DON'T CHANGE IT.
	   XP_BONUS_ENABLED    	   	   = true, 											  -- ENABLE OR DISABLE XP BONUS
	   XP_BONUS_JOB_LOCKED 	  	   = false,											  -- JOB LOCK XP BONUS
	   XP_BONUS_PLAYER_LOCKED 	   = false,											  -- PLAYER LOCK XP BONUS 
	   XP_REQUIRED_ACTION_COUNT    = 5, 											  -- HOW MANY TIMES THIS ACTION IS REQUIRED TO BE PERFORMED BEFORE GIVING XP / IT WILL RESET EVERY TIME IT REACHES THIS VALUE 
	   XP_GIVEN_NO_LOCK            = 1,	   											  -- HOW MANY XP ARE GIVEN WHEN NO LOCK IS APPLIED
	   XP_BONUS_JOB_LIST         = {
		[1] = {JOB = "OTHER_ROLES", XP_GIVEN = 2},  								  -- EVERY OTHER ROLE THAN THE ONES LISTED BELOW WILL GET THIS AMOUNT OF XP 
		[2] = {JOB = "doctor",      XP_GIVEN = 1}, 
	   },
	   
	   XP_BONUS_PLAYER_LIST         = {
		[1] = {IDENTIFIER = "OTHER_PLAYERS", CHARID = "OTHER_PLAYERS", XP_GIVEN = 1}, -- EVERY OTHER PLAYER THAN THE ONES LISTED BELOW WILL GET THIS AMOUNT OF XP. IDENTIFIER SHOULD BE A STRING AND CHARID AN INTEGER.
		--[2] = {IDENTIFIER = "steam:999", CHARID = 1, XP_GIVEN = 1},  
	   },
	   	   
	   INTERACTION_ITEMS_ENABLED   = true, 
	   INTERACTION_ITEMS_LIST      = {
	    { ITEM = "kit_horse_brush", ITEMLABEL = "Horsebrush", TXTDICT = "inventory_items", TXTIMAGE = "kit_horse_brush", ITEMREMOVED = false, INTERACTION_HEALTH_BONUS = {ENABLED = false, AMOUNT = 0, OVERPOWER = 0.0}, INTERACTION_STAMINA_BONUS = {ENABLED = false, AMOUNT = 0, OVERPOWER = 0.0}, INTERACTION_HUNGER_BONUS = {ENABLED = false, AMOUNT = 30},INTERACTION_THIRST_BONUS = {ENABLED = false, AMOUNT = 0 }, INTERACTION_LOVE_BONUS = {ENABLED = true, AMOUNT = 10 },}, -- IF ONE OF THIS ITEM IS IN THE PLAYER INVENTORY IT WILL ALLOW THE INTERACTION TO HAPPEN THROUGH HORSE PROMPTS.
		},	   
  }, 
	
	
[2] = {ACTION      				   = "FEEDING", 
	   XP_BONUS_ENABLED    	   	   = true, 
	   XP_BONUS_JOB_LOCKED 	  	   = false,
	   XP_BONUS_PLAYER_LOCKED 	   = false,
	   XP_REQUIRED_ACTION_COUNT    = 5, 		 
	   XP_GIVEN_NO_LOCK            = 1,	
	   
	   XP_BONUS_JOB_LIST         = {
		[1] = {JOB = "OTHER_ROLES", XP_GIVEN = 1},  
	   },
	   
	   XP_BONUS_PLAYER_LIST         = {
		[1] = {IDENTIFIER = "OTHER_PLAYERS", CHARID = "OTHER_PLAYERS", XP_GIVEN = 1},  
	   },
	   
	   INTERACTION_ITEMS_ENABLED   = true, 
	   INTERACTION_ITEMS_LIST      = {
 	    { ITEM = "consumable_carrot", 	 ITEMLABEL = "Carrot",    TXTDICT = "inventory_items", TXTIMAGE = "consumable_carrot",    ITEMREMOVED = true, INTERACTION_HEALTH_BONUS = {ENABLED = true, AMOUNT = 50, OVERPOWER = 0.0 }, INTERACTION_STAMINA_BONUS = {ENABLED = true, AMOUNT = 50, OVERPOWER = 0.0 }, INTERACTION_HUNGER_BONUS = {ENABLED = true, AMOUNT = 30},INTERACTION_THIRST_BONUS = {ENABLED = false, AMOUNT = 0 }, INTERACTION_LOVE_BONUS = {ENABLED = true, AMOUNT = 10 }, },
	    { ITEM = "consumable_sugarcube", ITEMLABEL = "Sugarcube", TXTDICT = "inventory_items", TXTIMAGE = "consumable_sugarcube", ITEMREMOVED = true, INTERACTION_HEALTH_BONUS = {ENABLED = true, AMOUNT = 50, OVERPOWER = 0.0 }, INTERACTION_STAMINA_BONUS = {ENABLED = true, AMOUNT = 50, OVERPOWER = 0.0 }, INTERACTION_HUNGER_BONUS = {ENABLED = true, AMOUNT = 30},INTERACTION_THIRST_BONUS = {ENABLED = false, AMOUNT = 0 }, INTERACTION_LOVE_BONUS = {ENABLED = true, AMOUNT = 10 }, },
	    { ITEM = "consumable_haycube", 	 ITEMLABEL = "Haycube",   TXTDICT = "inventory_items", TXTIMAGE = "consumable_haycube",   ITEMREMOVED = true, INTERACTION_HEALTH_BONUS = {ENABLED = true, AMOUNT = 50, OVERPOWER = 0.0 }, INTERACTION_STAMINA_BONUS = {ENABLED = true, AMOUNT = 50, OVERPOWER = 0.0 }, INTERACTION_HUNGER_BONUS = {ENABLED = true, AMOUNT = 30},INTERACTION_THIRST_BONUS = {ENABLED = false, AMOUNT = 0 }, INTERACTION_LOVE_BONUS = {ENABLED = true, AMOUNT = 10 }, },
	    { ITEM = "consumable_apple", 	 ITEMLABEL = "Apple",     TXTDICT = "inventory_items", TXTIMAGE = "consumable_apple", 	  ITEMREMOVED = true, INTERACTION_HEALTH_BONUS = {ENABLED = true, AMOUNT = 50, OVERPOWER = 0.0 }, INTERACTION_STAMINA_BONUS = {ENABLED = true, AMOUNT = 50, OVERPOWER = 0.0 }, INTERACTION_HUNGER_BONUS = {ENABLED = true, AMOUNT = 30},INTERACTION_THIRST_BONUS = {ENABLED = false, AMOUNT = 0 }, INTERACTION_LOVE_BONUS = {ENABLED = true, AMOUNT = 10 }, },
 		},	     
	}, 

	
[3] = {ACTION      				   = "STIMULANT", 
	   XP_BONUS_ENABLED    	   	   = false, 
	   XP_BONUS_JOB_LOCKED 	  	   = false,
	   XP_BONUS_PLAYER_LOCKED 	   = false,
	   XP_REQUIRED_ACTION_COUNT    = 1, 		 
	   XP_GIVEN_NO_LOCK            = 1,	   
	   XP_BONUS_JOB_LIST         = {
		[1] = {JOB = "OTHER_ROLES", XP_GIVEN = 1}, 
	   },
	   
	   XP_BONUS_PLAYER_LIST         = {
		[1] = {IDENTIFIER = "OTHER_PLAYERS", CHARID = "OTHER_PLAYERS", XP_GIVEN = 1},  
	   },
	   
	   INTERACTION_ITEMS_ENABLED   = true, 
	   INTERACTION_ITEMS_LIST      = {
 	    { ITEM = "consumable_carrot", 	 ITEMLABEL = "Carrot",    TXTDICT = "inventory_items", TXTIMAGE = "consumable_carrot",     ITEMREMOVED = true, INTERACTION_HEALTH_BONUS = {ENABLED = true, AMOUNT = 50, OVERPOWER = 0.0 }, INTERACTION_STAMINA_BONUS = {ENABLED = true, AMOUNT = 50, OVERPOWER = 0.0 }, INTERACTION_HUNGER_BONUS = {ENABLED = true, AMOUNT = 30},INTERACTION_THIRST_BONUS = {ENABLED = false, AMOUNT = 0 }, INTERACTION_LOVE_BONUS = {ENABLED = true, AMOUNT = 10 },},
	    { ITEM = "consumable_sugarcube", ITEMLABEL = "Sugarcube", TXTDICT = "inventory_items", TXTIMAGE = "consumable_sugarcube",  ITEMREMOVED = true, INTERACTION_HEALTH_BONUS = {ENABLED = true, AMOUNT = 50, OVERPOWER = 0.0 }, INTERACTION_STAMINA_BONUS = {ENABLED = true, AMOUNT = 50, OVERPOWER = 0.0 }, INTERACTION_HUNGER_BONUS = {ENABLED = true, AMOUNT = 30},INTERACTION_THIRST_BONUS = {ENABLED = false, AMOUNT = 0 }, INTERACTION_LOVE_BONUS = {ENABLED = true, AMOUNT = 10 },},
	    { ITEM = "consumable_haycube", 	 ITEMLABEL = "Haycube",   TXTDICT = "inventory_items", TXTIMAGE = "consumable_haycube",    ITEMREMOVED = true, INTERACTION_HEALTH_BONUS = {ENABLED = true, AMOUNT = 50, OVERPOWER = 0.0 }, INTERACTION_STAMINA_BONUS = {ENABLED = true, AMOUNT = 50, OVERPOWER = 0.0 }, INTERACTION_HUNGER_BONUS = {ENABLED = true, AMOUNT = 30},INTERACTION_THIRST_BONUS = {ENABLED = false, AMOUNT = 0 }, INTERACTION_LOVE_BONUS = {ENABLED = true, AMOUNT = 10 },},
	    { ITEM = "consumable_apple", 	 ITEMLABEL = "Apple",     TXTDICT = "inventory_items", TXTIMAGE = "consumable_apple", 	   ITEMREMOVED = true, INTERACTION_HEALTH_BONUS = {ENABLED = true, AMOUNT = 50, OVERPOWER = 0.0 }, INTERACTION_STAMINA_BONUS = {ENABLED = true, AMOUNT = 50, OVERPOWER = 0.0 }, INTERACTION_HUNGER_BONUS = {ENABLED = true, AMOUNT = 30},INTERACTION_THIRST_BONUS = {ENABLED = false, AMOUNT = 0 }, INTERACTION_LOVE_BONUS = {ENABLED = true, AMOUNT = 10 },},
 		},	   
	}, 	
	
	
[4] = {ACTION      	  			 = "RIDING", 
 	   SECONDS_XP_CHECK  		 = 30, 										 
  	   XP_BONUS_ENABLED    	   	 = true,                                      
  	   XP_BONUS_JOB_LOCKED 	  	 = true,                                      
 	   XP_BONUS_PLAYER_LOCKED 	 = false,                                     
 	   XP_REQUIRED_ACTION_COUNT  = 10,  	-- 10 * 30 SECONDS_XP_CHECK = 300 seconds so every 5 minutes while riding the player will get the xp bonus if enabled.
 	   XP_GIVEN_NO_LOCK          = 10,	   
 	   XP_BONUS_JOB_LIST         = {									               
 		[1] = {JOB = "OTHER_ROLES", XP_GIVEN = 1}, 									   
 	   },
 	   XP_BONUS_PLAYER_LIST         = {
 		[1] = {IDENTIFIER = "OTHER_PLAYERS", CHARID = "OTHER_PLAYERS", XP_GIVEN = 1},  
 	   },   
 	   INTERACTION_HEALTH_BONUS    = {ENABLED = false,  AMOUNT = 0, OVERPOWER = 0.0}, 
 	   INTERACTION_STAMINA_BONUS   = {ENABLED = false,  AMOUNT = 0, OVERPOWER = 0.0}, 
 	   INTERACTION_HUNGER_BONUS    = {ENABLED = false,  AMOUNT = 0				   }, 
 	   INTERACTION_THIRST_BONUS    = {ENABLED = false,  AMOUNT = 0				   }, 
 	   INTERACTION_LOVE_BONUS      = {ENABLED = false,  AMOUNT = 0				   },  
 	}, 
 
[5] = {ACTION      				   = "HORSE_REVIVING", 
	   XP_BONUS_ENABLED    	   	   = false, 
	   XP_BONUS_JOB_LOCKED 	  	   = false,
	   XP_BONUS_PLAYER_LOCKED 	   = false,
	   XP_REQUIRED_ACTION_COUNT    = 5, 		 
	   XP_GIVEN_NO_LOCK            = 1,	   
	   XP_BONUS_JOB_LIST         = {
		[1] = {JOB = "OTHER_ROLES", XP_GIVEN = 1},  
	   },
	   XP_BONUS_PLAYER_LIST         = {
		[1] = {IDENTIFIER = "OTHER_PLAYERS", CHARID = "OTHER_PLAYERS", XP_GIVEN = 1},  
	   },
	   INTERACTION_ITEMS_ENABLED   = true, 
	   INTERACTION_ITEMS_LIST      = {
 		 { ITEM = "consumable_horse_reviver", 	 ITEMLABEL = "Horse Reviver",    TXTDICT = "inventory_items", TXTIMAGE = "consumable_horse_reviver",  ITEMREMOVED = true},
		},	   
	}, 

[6] = {ACTION      				   = "PATTING", 
	   XP_BONUS_ENABLED    	   	   = true, 
	   XP_BONUS_JOB_LOCKED 	  	   = false,
	   XP_BONUS_PLAYER_LOCKED 	   = false,
	   XP_REQUIRED_ACTION_COUNT    = 5, 
	   XP_GIVEN_NO_LOCK            = 1,
	   XP_BONUS_JOB_LIST           = {
		[1] = {JOB = "OTHER_ROLES", XP_GIVEN = 1},  
	   },   
	   XP_BONUS_PLAYER_LIST         = {
		[1] = {IDENTIFIER = "OTHER_PLAYERS", CHARID = "OTHER_PLAYERS", XP_GIVEN = 1 },  
	   },   
	   INTERACTION_HEALTH_BONUS    = {ENABLED = false,  AMOUNT = 0, OVERPOWER = 0.0 }, 
	   INTERACTION_STAMINA_BONUS   = {ENABLED = false,  AMOUNT = 0, OVERPOWER = 0.0 }, 
	   INTERACTION_HUNGER_BONUS    = {ENABLED = false,  AMOUNT = 0					}, 
	   INTERACTION_THIRST_BONUS    = {ENABLED = false,  AMOUNT = 0					}, 
	   INTERACTION_LOVE_BONUS      = {ENABLED = true,   AMOUNT = 10					},  
		},


[7] = {ACTION      				   = "GRAZING", 
	   XP_BONUS_ENABLED    	   	   = true, 
	   XP_BONUS_JOB_LOCKED 	  	   = false,
	   XP_BONUS_PLAYER_LOCKED 	   = false,
	   XP_REQUIRED_ACTION_COUNT    = 5, 
	   XP_GIVEN_NO_LOCK            = 1,
	   XP_BONUS_JOB_LIST           = {
		[1] = {JOB = "OTHER_ROLES", XP_GIVEN = 1},  
	   },   
	   XP_BONUS_PLAYER_LIST         = {
		[1] = {IDENTIFIER = "OTHER_PLAYERS", CHARID = "OTHER_PLAYERS", XP_GIVEN = 1},  
	   },   
	   INTERACTION_HEALTH_BONUS    = {ENABLED = false,  AMOUNT = 0, OVERPOWER = 0.0 }, 
	   INTERACTION_STAMINA_BONUS   = {ENABLED = false,  AMOUNT = 0, OVERPOWER = 0.0 }, 
	   INTERACTION_HUNGER_BONUS    = {ENABLED = true,   AMOUNT = 20					}, 
	   INTERACTION_THIRST_BONUS    = {ENABLED = false,  AMOUNT = 0 					}, 
	   INTERACTION_LOVE_BONUS      = {ENABLED = true,   AMOUNT = 10 			    },  
		},		
		
 
[8] = {ACTION      				   = "DRINKING", 
	   XP_BONUS_ENABLED    	   	   = true, 
	   XP_BONUS_JOB_LOCKED 	  	   = false,
	   XP_BONUS_PLAYER_LOCKED 	   = false,
	   XP_REQUIRED_ACTION_COUNT    = 5, 
	   XP_GIVEN_NO_LOCK            = 1,
	   XP_BONUS_JOB_LIST           = {
		[1] = {JOB = "OTHER_ROLES", XP_GIVEN = 1},  
	   },   
	   XP_BONUS_PLAYER_LIST         = {
		[1] = {IDENTIFIER = "OTHER_PLAYERS", CHARID = "OTHER_PLAYERS", XP_GIVEN = 1},  
	   },   
	   INTERACTION_ITEMS_ENABLED   = true, 
	   INTERACTION_ITEMS_LIST      = {
	    { ITEM = "consumable_haycube", 	 			 ITEMLABEL = "Hay",       TXTDICT = "inventory_items", TXTIMAGE = "consumable_haycube",    ITEMREMOVED = true, INTERACTION_HEALTH_BONUS = {ENABLED = false, AMOUNT = 0, OVERPOWER = 0.0 }, INTERACTION_STAMINA_BONUS = {ENABLED = false, AMOUNT = 50, OVERPOWER = 0.0 }, INTERACTION_HUNGER_BONUS = {ENABLED = false, AMOUNT = 0},INTERACTION_THIRST_BONUS = {ENABLED = true, AMOUNT = 50 }, INTERACTION_LOVE_BONUS = {ENABLED = true, AMOUNT = 10 },},
    		},	      
	   INTERACTION_HEALTH_BONUS    = {ENABLED = false,  AMOUNT = 0, OVERPOWER = 0.0 }, 
	   INTERACTION_STAMINA_BONUS   = {ENABLED = false,  AMOUNT = 0, OVERPOWER = 0.0 }, 
	   INTERACTION_HUNGER_BONUS    = {ENABLED = false,  AMOUNT = 0 					}, 
	   INTERACTION_THIRST_BONUS    = {ENABLED = true,   AMOUNT = 50 				}, 
	   INTERACTION_LOVE_BONUS      = {ENABLED = true,   AMOUNT = 10 			    },  
	  },			
		
		
[9] = {ACTION      				   = "LAYING_DOWN", 
	   XP_BONUS_ENABLED    	   	   = true, 
	   XP_BONUS_JOB_LOCKED 	  	   = false,
	   XP_BONUS_PLAYER_LOCKED 	   = false,
	   XP_REQUIRED_ACTION_COUNT    = 5, 
	   XP_GIVEN_NO_LOCK            = 1,
	   XP_BONUS_JOB_LIST           = {
		[1] = {JOB = "OTHER_ROLES", XP_GIVEN = 1},  
	   },   
	   XP_BONUS_PLAYER_LIST         = {
		[1] = {IDENTIFIER = "OTHER_PLAYERS", CHARID = "OTHER_PLAYERS", XP_GIVEN = 1},  
	   },   
	   INTERACTION_HEALTH_BONUS    = {ENABLED = false,  AMOUNT = 0, OVERPOWER = 0.0 }, 
	   INTERACTION_STAMINA_BONUS   = {ENABLED = false,  AMOUNT = 0, OVERPOWER = 0.0 }, 
	   INTERACTION_HUNGER_BONUS    = {ENABLED = false,  AMOUNT = 0 					}, 
	   INTERACTION_THIRST_BONUS    = {ENABLED = false,  AMOUNT = 0					}, 
	   INTERACTION_LOVE_BONUS      = {ENABLED = true,   AMOUNT = 10					},  
	  },		
	
	
[10] = {ACTION      			   = "SLEEPING", 
	   XP_BONUS_ENABLED    	   	   = true, 
	   XP_BONUS_JOB_LOCKED 	  	   = false,
	   XP_BONUS_PLAYER_LOCKED 	   = false,
	   XP_REQUIRED_ACTION_COUNT    = 5, 
	   XP_GIVEN_NO_LOCK            = 1,
	   XP_BONUS_JOB_LIST           = {
		[1] = {JOB = "OTHER_ROLES", XP_GIVEN = 1},  
	   },   
	   XP_BONUS_PLAYER_LIST         = {
		[1] = {IDENTIFIER = "OTHER_PLAYERS", CHARID = "OTHER_PLAYERS", XP_GIVEN = 1},  
	   },   
	   INTERACTION_HEALTH_BONUS    = {ENABLED = false,  AMOUNT = 0, OVERPOWER = 0.0}, 
	   INTERACTION_STAMINA_BONUS   = {ENABLED = false,  AMOUNT = 0, OVERPOWER = 0.0}, 
	   INTERACTION_HUNGER_BONUS    = {ENABLED = false,  AMOUNT = 0 				   }, 
	   INTERACTION_THIRST_BONUS    = {ENABLED = false,  AMOUNT = 0				   }, 
	   INTERACTION_LOVE_BONUS      = {ENABLED = true,   AMOUNT = 10 			   },  
	  },		



[11] = {ACTION      			   = "SHOE_CLEANING", 
	   XP_BONUS_ENABLED    	   	   = true, 
	   XP_BONUS_JOB_LOCKED 	  	   = false,
	   XP_BONUS_PLAYER_LOCKED 	   = false,
	   XP_REQUIRED_ACTION_COUNT    = 5, 		 
	   XP_GIVEN_NO_LOCK            = 1,	
	   
	   XP_BONUS_JOB_LIST         = {
		[1] = {JOB = "OTHER_ROLES", XP_GIVEN = 1},  
	   },
	   
	   XP_BONUS_PLAYER_LIST         = {
		[1] = {IDENTIFIER = "OTHER_PLAYERS", CHARID = "OTHER_PLAYERS", XP_GIVEN = 1},  
	   },
 
	   INTERACTION_ITEMS_ENABLED   = true, 
	   INTERACTION_ITEMS_LIST      = {
	    { ITEM = "kit_hoof_knife", ITEMLABEL = "Hoof Knife", TXTDICT = "inventory_items", TXTIMAGE = "provision_pen", ITEMREMOVED = false, INTERACTION_HEALTH_BONUS = {ENABLED = false, AMOUNT = 0, OVERPOWER = 0.0}, INTERACTION_STAMINA_BONUS = {ENABLED = false, AMOUNT = 0, OVERPOWER = 0.0}, INTERACTION_HUNGER_BONUS = {ENABLED = false, AMOUNT = 30},INTERACTION_THIRST_BONUS = {ENABLED = false, AMOUNT = 0 }, INTERACTION_LOVE_BONUS = {ENABLED = true, AMOUNT = 10 },}, -- IF ONE OF THIS ITEM IS IN THE PLAYER INVENTORY IT WILL ALLOW THE INTERACTION TO HAPPEN THROUGH HORSE PROMPTS.
		},			
		
	   INTERACTION_HEALTH_BONUS    = {ENABLED = true,  AMOUNT = 0,  OVERPOWER = 0.0 }, 
	   INTERACTION_STAMINA_BONUS   = {ENABLED = true,  AMOUNT = 0,  OVERPOWER = 0.0 }, 
	   INTERACTION_HUNGER_BONUS    = {ENABLED = true,  AMOUNT = 0,					}, 
	   INTERACTION_THIRST_BONUS    = {ENABLED = true,  AMOUNT = 0,					}, 
	   INTERACTION_LOVE_BONUS      = {ENABLED = true,  AMOUNT = 2,					}, 
	},
	
	
[12] = {ACTION      			   = "OINTMENT", 
	   XP_BONUS_ENABLED    	   	   = false, 
	   XP_BONUS_JOB_LOCKED 	  	   = false,
	   XP_BONUS_PLAYER_LOCKED 	   = false,
	   XP_REQUIRED_ACTION_COUNT    = 1, 		 
	   XP_GIVEN_NO_LOCK            = 1,	
	   
	   XP_BONUS_JOB_LIST         = {
		[1] = {JOB = "OTHER_ROLES", XP_GIVEN = 1},  
	   },
	   
	   XP_BONUS_PLAYER_LIST         = {
		[1] = {IDENTIFIER = "OTHER_PLAYERS", CHARID = "OTHER_PLAYERS", XP_GIVEN = 1},  
	   },
	   
	   INTERACTION_ITEMS_ENABLED   = false, 
	   INTERACTION_ITEMS_LIST      = {
	    { ITEM = "consumable_horse_ointment", 	 ITEMLABEL = "Horse Ointment",    TXTDICT = "inventory_items", TXTIMAGE = "consumable_horse_ointment", ITEMREMOVED = true,INTERACTION_HEALTH_BONUS = {ENABLED = true, AMOUNT = 50, OVERPOWER = 0.0 }, INTERACTION_STAMINA_BONUS = {ENABLED = true, AMOUNT = 50, OVERPOWER = 0.0 }, INTERACTION_HUNGER_BONUS = {ENABLED = true, AMOUNT = 30},INTERACTION_THIRST_BONUS = {ENABLED = false, AMOUNT = 0 }, INTERACTION_LOVE_BONUS = {ENABLED = true, AMOUNT = 10 },},
 		},	   
 
	},

[13] = {ACTION      			   = "FEED_BOOST", 
	   XP_BONUS_ENABLED    	   	   = false, 
	   XP_BONUS_JOB_LOCKED 	  	   = false,
	   XP_BONUS_PLAYER_LOCKED 	   = false,
	   XP_REQUIRED_ACTION_COUNT    = 1, 		 
	   XP_GIVEN_NO_LOCK            = 10,	   
	   XP_BONUS_JOB_LIST         = {
		[1] = {JOB = "OTHER_ROLES", XP_GIVEN = 1}, 
	   },
	   
	   XP_BONUS_PLAYER_LIST         = {
		[1] = {IDENTIFIER = "OTHER_PLAYERS", CHARID = "OTHER_PLAYERS", XP_GIVEN = 1},  
	   },
	   
	   INTERACTION_ITEMS_ENABLED   = true, 
	   INTERACTION_ITEMS_LIST      = {
	    { ITEM = "hay", 	 			 ITEMLABEL = "Hay",       TXTDICT = "inventory_items", TXTIMAGE = "consumable_haycube",    ITEMREMOVED = true, INTERACTION_HEALTH_BONUS = {ENABLED = true, AMOUNT = 50, OVERPOWER = 0.0 }, INTERACTION_STAMINA_BONUS = {ENABLED = true, AMOUNT = 50, OVERPOWER = 0.0 }, INTERACTION_HUNGER_BONUS = {ENABLED = true, AMOUNT = 30},INTERACTION_THIRST_BONUS = {ENABLED = false, AMOUNT = 0 }, INTERACTION_LOVE_BONUS = {ENABLED = true, AMOUNT = 10 },},
	    { ITEM = "consumable_carrot", 	 ITEMLABEL = "Carrot",    TXTDICT = "inventory_items", TXTIMAGE = "consumable_carrot",     ITEMREMOVED = true, INTERACTION_HEALTH_BONUS = {ENABLED = true, AMOUNT = 50, OVERPOWER = 0.0 }, INTERACTION_STAMINA_BONUS = {ENABLED = true, AMOUNT = 50, OVERPOWER = 0.0 }, INTERACTION_HUNGER_BONUS = {ENABLED = true, AMOUNT = 30},INTERACTION_THIRST_BONUS = {ENABLED = false, AMOUNT = 0 }, INTERACTION_LOVE_BONUS = {ENABLED = true, AMOUNT = 10 },},
	    { ITEM = "consumable_sugarcube", ITEMLABEL = "Sugarcube", TXTDICT = "inventory_items", TXTIMAGE = "consumable_sugarcube",  ITEMREMOVED = true, INTERACTION_HEALTH_BONUS = {ENABLED = true, AMOUNT = 50, OVERPOWER = 0.0 }, INTERACTION_STAMINA_BONUS = {ENABLED = true, AMOUNT = 50, OVERPOWER = 0.0 }, INTERACTION_HUNGER_BONUS = {ENABLED = true, AMOUNT = 30},INTERACTION_THIRST_BONUS = {ENABLED = false, AMOUNT = 0 }, INTERACTION_LOVE_BONUS = {ENABLED = true, AMOUNT = 10 },},
	    { ITEM = "consumable_haycube", 	 ITEMLABEL = "Haycube",   TXTDICT = "inventory_items", TXTIMAGE = "consumable_haycube",    ITEMREMOVED = true, INTERACTION_HEALTH_BONUS = {ENABLED = true, AMOUNT = 50, OVERPOWER = 0.0 }, INTERACTION_STAMINA_BONUS = {ENABLED = true, AMOUNT = 50, OVERPOWER = 0.0 }, INTERACTION_HUNGER_BONUS = {ENABLED = true, AMOUNT = 30},INTERACTION_THIRST_BONUS = {ENABLED = false, AMOUNT = 0 }, INTERACTION_LOVE_BONUS = {ENABLED = true, AMOUNT = 10 },},
	    { ITEM = "consumable_apple", 	 ITEMLABEL = "Apple",     TXTDICT = "inventory_items", TXTIMAGE = "consumable_apple", 	   ITEMREMOVED = true, INTERACTION_HEALTH_BONUS = {ENABLED = true, AMOUNT = 50, OVERPOWER = 0.0 }, INTERACTION_STAMINA_BONUS = {ENABLED = true, AMOUNT = 50, OVERPOWER = 0.0 }, INTERACTION_HUNGER_BONUS = {ENABLED = true, AMOUNT = 30},INTERACTION_THIRST_BONUS = {ENABLED = false, AMOUNT = 0 }, INTERACTION_LOVE_BONUS = {ENABLED = true, AMOUNT = 10 },},
 		},	    
	}, 	

[14] = {ACTION      	  		 = "LEADING", 
 	   SECONDS_XP_CHECK  		 = 30, 										 
  	   XP_BONUS_ENABLED    	   	 = true,                                      
  	   XP_BONUS_JOB_LOCKED 	  	 = true,                                      
 	   XP_BONUS_PLAYER_LOCKED 	 = false,                                     
 	   XP_REQUIRED_ACTION_COUNT  = 10,  	-- 10 * 30 SECONDS_XP_CHECK = 300 seconds so every 5 minutes while leading the player will get the xp bonus if enabled.
 	   XP_GIVEN_NO_LOCK          = 10,	   
 	   XP_BONUS_JOB_LIST         = {									               
 		[1] = {JOB = "OTHER_ROLES", XP_GIVEN = 1}, 									   
 	   },
 	   XP_BONUS_PLAYER_LIST         = {
 		[1] = {IDENTIFIER = "OTHER_PLAYERS", CHARID = "OTHER_PLAYERS", XP_GIVEN = 1},  
 	   },   
 	   INTERACTION_HEALTH_BONUS    = {ENABLED = false,  AMOUNT = 0, OVERPOWER = 0.0}, 
 	   INTERACTION_STAMINA_BONUS   = {ENABLED = false,  AMOUNT = 0, OVERPOWER = 0.0}, 
 	   INTERACTION_HUNGER_BONUS    = {ENABLED = false,  AMOUNT = 0				   }, 
 	   INTERACTION_THIRST_BONUS    = {ENABLED = false,  AMOUNT = 0				   }, 
 	   INTERACTION_LOVE_BONUS      = {ENABLED = false,  AMOUNT = 0				   },  
 	},  
	
[15] = {ACTION      	  		 = "LUNGING", 
 	   SECONDS_XP_CHECK  		 = 30, 										 
  	   XP_BONUS_ENABLED    	   	 = true,                                      
  	   XP_BONUS_JOB_LOCKED 	  	 = true,                                      
 	   XP_BONUS_PLAYER_LOCKED 	 = false,                                     
 	   XP_REQUIRED_ACTION_COUNT  = 10,  	-- 10 * 30 SECONDS_XP_CHECK = 300 seconds so every 5 minutes while lunging the player will get the xp bonus if enabled.
 	   XP_GIVEN_NO_LOCK          = 10,	   
 	   XP_BONUS_JOB_LIST         = {									               
 		[1] = {JOB = "OTHER_ROLES", XP_GIVEN = 1}, 									   
 	   },
 	   XP_BONUS_PLAYER_LIST         = {
 		[1] = {IDENTIFIER = "OTHER_PLAYERS", CHARID = "OTHER_PLAYERS", XP_GIVEN = 1},  
 	   },   
 	   INTERACTION_HEALTH_BONUS    = {ENABLED = false,  AMOUNT = 0, OVERPOWER = 0.0}, 
 	   INTERACTION_STAMINA_BONUS   = {ENABLED = false,  AMOUNT = 0, OVERPOWER = 0.0}, 
 	   INTERACTION_HUNGER_BONUS    = {ENABLED = false,  AMOUNT = 0				   }, 
 	   INTERACTION_THIRST_BONUS    = {ENABLED = false,  AMOUNT = 0				   }, 
 	   INTERACTION_LOVE_BONUS      = {ENABLED = false,  AMOUNT = 0				   },  
 	}, 	
 
}