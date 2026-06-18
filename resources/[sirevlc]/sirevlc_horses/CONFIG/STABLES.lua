Config = Config or {}
--------------------------------------
      --STABLES CONFIGURATION--
-------------------------------------- 

-- CAMERA NATIVE USED: 0x40C23491CE83708E
-- FOV = Field of view
-- CAMERA1EXAMPLE = {FLOAT POSX, FLOAT POSY,FLOAT POSZ, FLOAT ROTX, FLOAT ROTY, FLOAT ROTZ, FLOAT FOV},

Config.Stables = {
    [1] = {
        name                    = "Valentine Stables",
        title_given             = "Valentine Stables",														    -- TITLE GIVEN TO THE HORSE 
		blipenabled             = true,
		blipsprite              = -643888085,
        blipcoords              = {-366.69, 787.06, 116.16},	
        pedenabled              = true,							   												-- AMBIENT PED ENABLED
        pedmodel                = "u_m_m_bwmstablehand_01",							   							-- AMBIENT PED MODEL
        pedscenario             = "WORLD_HUMAN_WAITING_IMPATIENT",							   					-- AMBIENT PED SCENARI0
        pedcoords               = {-366.69, 787.06, 116.16, -92.0},							   			    	-- AMBIENT PED COORDS AND HEADING 		
        promptcoords            = {-366.69, 787.06, 116.16},							   						-- PROMPT OPENING COORDS 
        promptdistance          = 1.5,								  								   			-- PROMPT OPENING DISTANCE
        horsepos                = {-373.49, 786.71, 116.10, -90.0},												-- HORSE POSITION DURING MENU PREVIEW (x,y,z,heading)
		horsepreviewcamoffset   = {3.0, 3.0},                                                                   -- HORSE PREVIEW CAM X AND Y COORDS OFFSET VALUES WHEN ACCESSING THE PREVIEW FOR THE FIRST TIME (MUST BE FLOAT)
		introcamerapos          = {-350.23, 777.28, 120.35, -6.37,  0.00, 46.36,   50.00},		 	   			-- CAMERA VIEW WHEN YOU'RE ENTERING THE STABLE IN CUTSCENE MODE {FLOAT POSX, FLOAT POSY,FLOAT POSZ, FLOAT ROTX, FLOAT ROTY, FLOAT ROTZ, FLOAT FOV},
		menucamera              = {-367.49, 788.41, 116.36, 1.69,   0.00, -26.87,  50.00},		 	   			-- CAMERA VIEW WHEN YOU'RE IN THE MAIN STABLE MENU		
		breeding_camera         = {-353.12, 775.99, 117.46, -9.76, 0.00, 134.79, 50.0},		 	   				-- ONLY EFFECTIVE IF OWNING SIREVLC_BREEDING - CAMERA VIEW FOR THE BREEDING PROCESS		
		breeding_menu_enabled   = true,																			-- ONLY EFFECTIVE IF OWNING SIREVLC_BREEDING - ENABLE / DISABLE MENU BREEDING ACCESS FOR THAT STABLE
 		breeding_price = {																						-- ONLY EFFECTIVE IF OWNING SIREVLC_BREEDING - BREEDING PRICE 
		[1] = {DATABASE_JOB_LABEL = "OTHER_JOBS",   GOLD = 0.0, DOLLARS = 500.0}, 							    -- ONLY EFFECTIVE IF OWNING SIREVLC_BREEDING - EVERY OTHER JOB THAN THE ONES LISTED BELOW WILL HAVE THIS PRICE 
		[2] = {DATABASE_JOB_LABEL = "horsetrainer", GOLD = 0.0, DOLLARS = 500.0}, 							     
		},		
 		breeding_stallion_pos = {-356.10, 770.27, 116.42, 55.33},												-- ONLY EFFECTIVE IF OWNING SIREVLC_BREEDING - STALLION PREVIEW POS 		
		breeding_mare_pos     = {-359.10, 772.69, 116.46, -126.0},												-- ONLY EFFECTIVE IF OWNING SIREVLC_BREEDING - MARE PREVIEW POS 	
		breeding_foal_pos     = {-357.35, 771.50, 116.11, -36.0},												-- ONLY EFFECTIVE IF OWNING SIREVLC_BREEDING - FOAL PREVIEW POS 
 		neutering_price = {
		[1] = {DATABASE_JOB_LABEL = "OTHER_JOBS", GOLD = 0.0, DOLLARS = 300.0}, 							    -- EVERY OTHER JOB THAN THE ONES LISTED BELOW WILL HAVE THIS PRICE 
		},	
 		rename_price = {
		[1] = {DATABASE_JOB_LABEL = "OTHER_JOBS", GOLD = 0.0, DOLLARS = 10.0}, 							    	-- EVERY OTHER JOB THAN THE ONES LISTED BELOW WILL HAVE THIS PRICE 
		},	
 		set_custom_title_price = {
		[1] = {DATABASE_JOB_LABEL = "OTHER_JOBS", GOLD = 0.0, DOLLARS = 10.0}, 							    	-- EVERY OTHER JOB THAN THE ONES LISTED BELOW WILL HAVE THIS PRICE 
		},		
 		wagons_menu_enabled   = true,						
		rolerestriction       = true, 															 	  			-- ENABLE / DISABLE ROLE LOCK FOR THIS STABLE | YOU CANT ENABLE PLAYER RESTRICTION AND ROLE RESTRICTION AT THE SAME TIME !
		rolesallowed          = {  																				-- IF rolerestriction = TRUE THEN LIST THE ROLES ALLOWED TO ACCESS THE STABLE HERE
		[1] = {Role = "OTHER_JOBS", Menu_Options_Enabled = {main_menu = true, breed_horse_menu = true, custom_eyes = true, custom_coat = true, transfer_horse = true, check_horseshoe = true, custom_coat_gene = true, custom_scale = true, display_owned = true, heal_horse = true, purchase_horse = true, purchase_horse_tack = true, horse_barber = true,  set_horse_tack = true, sell_horse = true, delete_horse = true, sell_horse_tack = true, set_custom_title = true, rename_horse = true, spawn_horse = true, neuter_horse = true, show_parents_info = true, change_horse_personality = true},},	 -- EVERY OTHER JOBS THAN THE ONES LISTED BELOW WILL GET THESE VALUES  	
  		},
 
		playersrestriction    = false,																   			-- ENABLE / DISABLE PLAYER LOCK FOR THIS STABLE | YOU CANT ENABLE PLAYER RESTRICTION AND ROLE RESTRICTION AT THE SAME TIME !
		playersallowed        = {
 		[1] = {IDENTIFIER = "OTHER_PLAYERS",  CHARID = "OTHER_PLAYERS",  Menu_Options_Enabled = {main_menu = true, breed_horse_menu = true, custom_eyes = true, custom_coat = true, transfer_horse = true, check_horseshoe = true, custom_coat_gene = true, custom_scale = true, display_owned = true, heal_horse = true, purchase_horse = true, purchase_horse_tack = true, horse_barber = true,  set_horse_tack = true, sell_horse = true, delete_horse = true, sell_horse_tack = true, set_custom_title = true, rename_horse = true, spawn_horse = true, neuter_horse = true, show_parents_info = true, change_horse_personality = true},},   -- EVERY OTHER PLAYER THAN THE ONES LISTED BELOW WILL GET THESE VALUES  
 		[2] = {IDENTIFIER = "steam:99", CHARID = 1, Menu_Options_Enabled = {main_menu = true, breed_horse_menu = true, custom_eyes = true, custom_coat = true, transfer_horse = true, check_horseshoe = true, custom_coat_gene = true, custom_scale = true, display_owned = true, heal_horse = true, purchase_horse = true, purchase_horse_tack = true, horse_barber = true,  set_horse_tack = true, sell_horse = true, delete_horse = true, sell_horse_tack = true, set_custom_title = true, rename_horse = true, spawn_horse = true, neuter_horse = true, show_parents_info = true, change_horse_personality = true},}, 	   -- IF playersrestriction = TRUE THEN LIST THE ROLES ALLOWED TO ACCESS THE STABLE HERE   
		},	
		
		exitcamerapos         = {-353.20, 795.49, 116.13, 10.01, 0.00, 131.23, 50.00}, 		 	       			-- CAMERA VIEW WHEN YOU EXIT THE STABLE
		playergotocoords      = {-358.09, 787.30, 116.16, -91.0, 0.0},    										-- COORDS WHERE THE PLAYER IS HEADING WHEN EXITING THE STABLE
		healing_price         = 20.0, 																	   		-- HEALING PRICE
		purchase_multiplier   = 1.0,																	   		-- MULTIPLIER APPLIED TO THE RESULT OF THE PURCHASE PRICE CALCULATION  
		sell_multiplier  	  = 1.0,  																	   		-- MULTIPLIER APPLIED TO THE RESULT OF THE SELLING PRICE CALCULATION  
        wagonpos 			  = {-373.64, 775.70, 116.14, -87.04},											    -- WAGON POS ON MENU PREVIEW
		wagonpreviewcamoffset = {8.0, -5.0},																	-- HORSE PREVIEW CAM X AND Y COORDS OFFSET VALUES WHEN ACCESSING THE PREVIEW FOR THE FIRST TIME		
		wagonspawnpos 		  = {-366.30, 805.59, 115.94, -87.23},												-- WAGON SPAWN POS	
    },
	
 
    [2] = {
        name                  = "Blackwater Stables",
		title_given           = "Blackwater Stables", 
		blipenabled           = true,
		blipsprite            = -643888085,		
        blipcoords     	      = {-861.71, -1366.38, 43.54},		
        pedenabled            = true,	
        pedmodel              = "u_m_m_bwmstablehand_01",							   						 
        pedscenario           = "WORLD_HUMAN_WAITING_IMPATIENT",							   				 	
        pedcoords             = {-861.71, -1366.38, 43.54, -97.0},							   			 
        promptcoords          = {-861.71, -1366.38, 43.54},
		promptdistance        = 2.0,
        horsepos              = {-864.27, -1361.97, 43.59, -178.34},
		horsepreviewcamoffset = {3.0, -3.0},                                                                   
		introcamerapos        = {-843.67, -1380.75, 48.19, -3.98,   0.00,  41.33,   50.00},			  
		menucamera            = {-873.34, -1362.55, 43.41, 1.20,    0.00,  -84.10,  50.00},	
		breeding_camera       = {-864.30, -1362.21, 45.75, -12.89, 0.00, -179.69, 50.0},		 	   				 
		breeding_menu_enabled = true,																			 						
 		breeding_price = {
		[1] = {DATABASE_JOB_LABEL = "OTHER_JOBS", GOLD = 0.0, DOLLARS = 500.0}, 							 
 
		},																		                             
		breeding_stallion_pos = {-860.83, -1370.78, 43.58, -0.51},											 
		breeding_mare_pos     = {-867.74, -1370.82, 43.60, -8.89},											 
		breeding_foal_pos     = {-864.23, -1370.85, 43.59, -0.46},                                           
 		neutering_price = {                                                                                  
		[1] = {DATABASE_JOB_LABEL = "OTHER_JOBS", GOLD = 0.0, DOLLARS = 300.0}, 							 
		},	                                                                                                 
 		rename_price = {                                                                                     
		[1] = {DATABASE_JOB_LABEL = "OTHER_JOBS", GOLD = 0.0, DOLLARS = 10.0}, 							     
		},	                                                                                                 
 		set_custom_title_price = {                                                                           
		[1] = {DATABASE_JOB_LABEL = "OTHER_JOBS", GOLD = 0.0, DOLLARS = 10.0}, 							     
		},	                                                                                                 
		wagons_menu_enabled   = true,					                                                     
		rolerestriction       = false, 															 	  			 
		rolesallowed          = {  																				 
		[1] = {Role = "OTHER_JOBS", Menu_Options_Enabled = {main_menu = true, breed_horse_menu = true, custom_eyes = true, custom_coat = true, transfer_horse = true, check_horseshoe = true, custom_coat_gene = true, custom_scale = true, display_owned = true, heal_horse = true, purchase_horse = true, purchase_horse_tack = true, horse_barber = true,  set_horse_tack = true, sell_horse = true, delete_horse = true, sell_horse_tack = true, set_custom_title = true, rename_horse = true, spawn_horse = true, neuter_horse = true, show_parents_info = true, change_horse_personality = true},},	 -- EVERY OTHER JOBS THAN THE ONES LISTED BELOW WILL GET THESE VALUES  	
  		},
 
		playersrestriction    = false,																   		 
		playersallowed        = {
 		[1] = {IDENTIFIER = "OTHER_PLAYERS",  CHARID = "OTHER_PLAYERS",  Menu_Options_Enabled = {main_menu = true, breed_horse_menu = true, custom_eyes = true, custom_coat = true, transfer_horse = true, check_horseshoe = true, custom_coat_gene = true, custom_scale = true, display_owned = true, heal_horse = true, purchase_horse = true, purchase_horse_tack = true, horse_barber = true,  set_horse_tack = true, sell_horse = true, delete_horse = true, sell_horse_tack = true, set_custom_title = true, rename_horse = true, spawn_horse = true, neuter_horse = true, show_parents_info = true, change_horse_personality = true},},   -- EVERY OTHER PLAYER THAN THE ONES LISTED BELOW WILL GET THESE VALUES  
 		[2] = {IDENTIFIER = "steam:99", CHARID = 1, Menu_Options_Enabled = {main_menu = true, breed_horse_menu = true, custom_eyes = true, custom_coat = true, transfer_horse = true, check_horseshoe = true, custom_coat_gene = true, custom_scale = true, display_owned = true, heal_horse = true, purchase_horse = true, purchase_horse_tack = true, horse_barber = true,  set_horse_tack = true, sell_horse = true, delete_horse = true, sell_horse_tack = true, set_custom_title = true, rename_horse = true, spawn_horse = true, neuter_horse = true, show_parents_info = true, change_horse_personality = true},}, 	   -- IF playersrestriction = TRUE THEN LIST THE ROLES ALLOWED TO ACCESS THE STABLE HERE   
		},		
		exitcamerapos         = {-848.68, -1357.88, 43.03, 12.00, 0.00, 135.56, 50.00},				  
		playergotocoords      = {-853.51, -1366.35, 43.57, -95.08},  
		healing_price         = 20.0, 																	   		 
		purchase_multiplier   = 1.0 ,																	   		 
		sell_multiplier  	  = 1.0 ,
        wagonpos			  = {-866.92, -1382.97, 43.50, -90.0},
		wagonpreviewcamoffset = {8.0, -2.0},													 		
		wagonspawnpos		  = {-873.82, -1389.68, 43.53, -169.0},		
    },
	
    [3] = {
        name                	= "Saint Denis Stables",
        title_given         	= "Saint Denis Stables",
		blipenabled         	= true,
		blipsprite          	= -643888085,	
        blipcoords          	= {2503.153, -1442.725, 46.312},	
        pedenabled            	= true,							   										 
        pedmodel                = "u_m_m_bwmstablehand_01",							   						 
        pedscenario             = "WORLD_HUMAN_WAITING_IMPATIENT",
        pedcoords             	= {2501.70, -1443.74, 46.31, -45.00},			
        promptcoords        	= {2501.70, -1443.74, 46.31},
		promptdistance      	= 1.5,
        horsepos            	= {2502.71, -1451.30, 46.25, -1.79},
		horsepreviewcamoffset 	= {3.0, 3.0},                                                                    
		introcamerapos      	= {2491.38, -1424.04, 49.86, -5.16,  0.00, -142.98, 50.00},			             
		menucamera          	= {2504.75, -1445.39, 46.66, 1.21,   0.00, 89.81,   50.00},			             
		breeding_camera         = {2501.82, -1446.87, 48.38, -15.41, 0.00, -88.82, 50.0},		 	   			 
		breeding_menu_enabled   = true,																			 
 		breeding_price = {                                                                                       
		[1] = {DATABASE_JOB_LABEL = "OTHER_JOBS", GOLD = 0.0, DOLLARS = 500.0}, 							     
																												 
		},																			                             
		breeding_stallion_pos   = {2509.05, -1443.70, 46.34, 90.23},											 
		breeding_mare_pos       = {2509.24, -1450.00, 46.31, 87.34},											 
		breeding_foal_pos       = {2508.64, -1447.06, 46.27, 89.54},		                                     
 		neutering_price = {                                                                                      
		[1] = {DATABASE_JOB_LABEL = "OTHER_JOBS", GOLD = 0.0, DOLLARS = 300.0}, 							     
		},	                                                                                                     
 		rename_price = {                                                                                         
		[1] = {DATABASE_JOB_LABEL = "OTHER_JOBS", GOLD = 0.0, DOLLARS = 10.0}, 							    	 
		},	                                                                                                     
 		set_custom_title_price = {                                                                               
		[1] = {DATABASE_JOB_LABEL = "OTHER_JOBS", GOLD = 0.0, DOLLARS = 10.0}, 							    	 
		},			                                                                                             
		wagons_menu_enabled		 = true,					                                                         
		rolerestriction       = false, 															 	  			 
		rolesallowed          = {  																				 
		[1] = {Role = "OTHER_JOBS", Menu_Options_Enabled = {main_menu = true, breed_horse_menu = true, custom_eyes = true, custom_coat = true, transfer_horse = true, check_horseshoe = true,  custom_coat_gene = true, custom_scale = true, display_owned = true, heal_horse = true, purchase_horse = true, purchase_horse_tack = true, horse_barber = true,  set_horse_tack = true, sell_horse = true, delete_horse = true, sell_horse_tack = true, set_custom_title = true, rename_horse = true, spawn_horse = true, neuter_horse = true, show_parents_info = true, change_horse_personality = true},},	 -- EVERY OTHER JOBS THAN THE ONES LISTED BELOW WILL GET THESE VALUES  	
  		},
 
		playersrestriction    = false,																   		 
		playersallowed        = {
 		[1] = {IDENTIFIER = "OTHER_PLAYERS",  CHARID = "OTHER_PLAYERS",  Menu_Options_Enabled = {main_menu = true, breed_horse_menu = true, custom_eyes = true, custom_coat = true, transfer_horse = true, check_horseshoe = true, custom_coat_gene = true, custom_scale = true, display_owned = true, heal_horse = true, purchase_horse = true, purchase_horse_tack = true, horse_barber = true,  set_horse_tack = true, sell_horse = true, delete_horse = true, sell_horse_tack = true, set_custom_title = true, rename_horse = true, spawn_horse = true, neuter_horse = true, show_parents_info = true, change_horse_personality = true},},   -- EVERY OTHER PLAYER THAN THE ONES LISTED BELOW WILL GET THESE VALUES  
 		[2] = {IDENTIFIER = "steam:99", CHARID = 1, Menu_Options_Enabled = {main_menu = true, breed_horse_menu = true, custom_eyes = true, custom_coat = true, transfer_horse = true, check_horseshoe = true, custom_coat_gene = true, custom_scale = true, display_owned = true, heal_horse = true, purchase_horse = true, purchase_horse_tack = true, horse_barber = true,  set_horse_tack = true, sell_horse = true, delete_horse = true, sell_horse_tack = true, set_custom_title = true, rename_horse = true, spawn_horse = true, neuter_horse = true, show_parents_info = true, change_horse_personality = true},}, 	   -- IF playersrestriction = TRUE THEN LIST THE ROLES ALLOWED TO ACCESS THE STABLE HERE   
		},		
		exitcamerapos      		= { 2502.49, -1424.84, 45.90, 8.51, 0.00, -179.49, 50.0}, 			  
		playergotocoords   		= {2502.02, -1431.83, 46.23, 0.0},   
		healing_price      		= 20.0,																	    
		purchase_multiplier   	= 1.0,																	   		 
		sell_multiplier  	  	= 1.0,
        wagonpos 				= {2500.21, -1418.25, 45.92, -178.0},
		wagonpreviewcamoffset   = {4.0, -7.0},		
		wagonspawnpos 			= {2507.09, -1404.01, 46.08, 89.04},		
    },
	
    [4] = {
        name               	  = "Dewberry Creek Stables",
        title_given        	  = "Dewberry Creek Stables",	
		blipenabled        	  = true,
		blipsprite         	  = -643888085,		
        blipcoords         	  = {1213.45, -184.56, 101.32},	
        pedenabled            = true,							   										 
        pedmodel              = "u_m_m_bwmstablehand_01",							   						 
        pedscenario           = "WORLD_HUMAN_WAITING_IMPATIENT",
        pedcoords             = {1213.45, -184.56, 101.32, 58.00},			
        promptcoords       	  = {1213.45, -184.56, 101.32},
		promptdistance     	  = 2.0,
        horsepos           	  = {1204.69, -195.95, 101.29, -71.93},
		horsepreviewcamoffset = {3.0, 3.0},                                                                    
		introcamerapos     	  = {1213.88, -174.17, 104.71, -5.21,  0.00, 155.84,  50.00},			           
		menucamera         	  = {1213.82, -186.68, 100.93, 1.22,   0.00, -144.06, 50.00},			           
		breeding_camera       = {1217.92, -220.82, 101.18, -1.01, 0.00, -72.21, 50.0},		 	   			 
		breeding_menu_enabled = true,																		 
 		breeding_price = {                                                                                     
		[1] = {DATABASE_JOB_LABEL = "OTHER_JOBS", GOLD = 0.0, DOLLARS = 500.0}, 							   
		},																			                           
		breeding_stallion_pos = {1223.48, -216.51, 100.68, -147.15},										 
		breeding_mare_pos     = {1225.62, -220.48, 100.72, 40.05},											   
		breeding_foal_pos     = {1224.62, -218.40, 100.73, 119.84},		                                       
 		neutering_price = {                                                                                    
		[1] = {DATABASE_JOB_LABEL = "OTHER_JOBS", GOLD = 0.0, DOLLARS = 300.0}, 							   
		},	                                                                                                   
 		rename_price = {                                                                                       
		[1] = {DATABASE_JOB_LABEL = "OTHER_JOBS", GOLD = 0.0, DOLLARS = 10.0}, 							     
		},	                                                                                                   
 		set_custom_title_price = {                                                                             
		[1] = {DATABASE_JOB_LABEL = "OTHER_JOBS", GOLD = 0.0, DOLLARS = 10.0}, 							   
		},		                                                                                           
		wagons_menu_enabled   = true,					                                                   
		rolerestriction       = false, 															 	  			 
		rolesallowed          = {  																				 
		[1] = {Role = "OTHER_JOBS", Menu_Options_Enabled = {main_menu = true, breed_horse_menu = true, custom_eyes = true, custom_coat = true, transfer_horse = true, check_horseshoe = true, custom_coat_gene = true, custom_scale = true, display_owned = true, heal_horse = true, purchase_horse = true, purchase_horse_tack = true, horse_barber = true,  set_horse_tack = true, sell_horse = true, delete_horse = true, sell_horse_tack = true, set_custom_title = true, rename_horse = true, spawn_horse = true, neuter_horse = true, show_parents_info = true, change_horse_personality = true},},	 -- EVERY OTHER JOBS THAN THE ONES LISTED BELOW WILL GET THESE VALUES  	
  		},
 
		playersrestriction    = false,																   		 
		playersallowed        = {
 		[1] = {IDENTIFIER = "OTHER_PLAYERS",  CHARID = "OTHER_PLAYERS",  Menu_Options_Enabled = {main_menu = true, breed_horse_menu = true, custom_eyes = true, custom_coat = true, transfer_horse = true, check_horseshoe = true, custom_coat_gene = true, custom_scale = true, display_owned = true, heal_horse = true, purchase_horse = true, purchase_horse_tack = true, horse_barber = true,  set_horse_tack = true, sell_horse = true, delete_horse = true, sell_horse_tack = true, set_custom_title = true, rename_horse = true, spawn_horse = true, neuter_horse = true, show_parents_info = true, change_horse_personality = true},},   -- EVERY OTHER PLAYER THAN THE ONES LISTED BELOW WILL GET THESE VALUES  
 		[2] = {IDENTIFIER = "steam:99", CHARID = 1, Menu_Options_Enabled = {main_menu = true, breed_horse_menu = true, custom_eyes = true, custom_coat = true, transfer_horse = true, check_horseshoe = true, custom_coat_gene = true, custom_scale = true, display_owned = true, heal_horse = true, purchase_horse = true, purchase_horse_tack = true, horse_barber = true,  set_horse_tack = true, sell_horse = true, delete_horse = true, sell_horse_tack = true, set_custom_title = true, rename_horse = true, spawn_horse = true, neuter_horse = true, show_parents_info = true, change_horse_personality = true},}, 	   -- IF playersrestriction = TRUE THEN LIST THE ROLES ALLOWED TO ACCESS THE STABLE HERE   
		},			
		exitcamerapos         = {1206.66, -193.85, 102.72, -6.74, 0.00, -73.27, 50.00},				     
		playergotocoords      = { 1205.95, -182.55, 101.15, 0.0},   
		healing_price      	  = 20.0,																	    
		purchase_multiplier   = 1.0,																	   		 
		sell_multiplier  	  = 1.0,
        wagonpos			  = {1212.49, -181.71, 101.04, 14.73},
		wagonpreviewcamoffset = {8.0, 8.0},                                                                 
		wagonspawnpos 		  = {1224.59, -199.74, 101.22, -73.06},		
    },
	
	
    [5] = {
        name             	  = "Van Horn Stables",
        title_given      	  = "Van Horn Stables",			
		blipenabled      	  = true,
		blipsprite       	  = -643888085,	
        blipcoords       	  = {2963.19921875, 795.87, 51.40},	
        pedenabled            = true,							   										 
        pedmodel              = "u_m_m_bwmstablehand_01",							   						 
        pedscenario           = "WORLD_HUMAN_WAITING_IMPATIENT",
        pedcoords             = {2963.19921875, 795.87, 51.40, 90.0},		
        promptcoords     	  = {2963.19921875, 795.87, 51.40},
		promptdistance   	  = 1.5,
        horsepos         	  = { 2969.74, 796.34, 51.33, 85.0},
		horsepreviewcamoffset = {3.0, 3.0},                                                                    
		introcamerapos   	  = {2949.83, 805.00, 53.14, -2.48,  0.00, -126.83, 40.00},				           
		menucamera       	  = {2969.31, 795.09, 51.62, -1.83,  0.00, -179.09, 40.00},	                       
		breeding_camera       = {2966.25, 771.64, 52.49, -9.59, 0.00, 171.14, 50.0},		 	   			 
		breeding_menu_enabled = true,																		 
 		breeding_price = {                                                                                     
		[1] = {DATABASE_JOB_LABEL = "OTHER_JOBS", GOLD = 0.0, DOLLARS = 500.0}, 							   
 
		},																			                           
		breeding_stallion_pos = {2967.48, 764.93, 51.32, 68.46},											 
		breeding_mare_pos     = {2963.00, 764.86, 51.32, -58.19},											   
		breeding_foal_pos     = {2965.15, 765.58, 51.33, 7.44},		                                           
 		neutering_price = {                                                                                    
		[1] = {DATABASE_JOB_LABEL = "OTHER_JOBS", GOLD = 0.0, DOLLARS = 300.0}, 							   
		},	                                                                                                   
 		rename_price = {                                                                                       
		[1] = {DATABASE_JOB_LABEL = "OTHER_JOBS", GOLD = 0.0, DOLLARS = 10.0}, 							     
		},	                                                                                                   
 		set_custom_title_price = {                                                                             
		[1] = {DATABASE_JOB_LABEL = "OTHER_JOBS", GOLD = 0.0, DOLLARS = 10.0}, 							   	   
		},			                                                                                           
		wagons_menu_enabled   = true,					                                                       
		rolerestriction       = false, 															 	  			 
		rolesallowed          = {  																				 
		[1] = {Role = "OTHER_JOBS", Menu_Options_Enabled = {main_menu = true, breed_horse_menu = true, custom_eyes = true, custom_coat = true, transfer_horse = true, check_horseshoe = true, custom_coat_gene = true, custom_scale = true, display_owned = true, heal_horse = true, purchase_horse = true, purchase_horse_tack = true, horse_barber = true,  set_horse_tack = true, sell_horse = true, delete_horse = true, sell_horse_tack = true, set_custom_title = true, rename_horse = true, spawn_horse = true, neuter_horse = true, show_parents_info = true, change_horse_personality = true},},	 -- EVERY OTHER JOBS THAN THE ONES LISTED BELOW WILL GET THESE VALUES  	
  		},
 
		playersrestriction    = false,																   		 
		playersallowed        = {
 		[1] = {IDENTIFIER = "OTHER_PLAYERS",  CHARID = "OTHER_PLAYERS",  Menu_Options_Enabled = {main_menu = true, breed_horse_menu = true, custom_eyes = true, custom_coat = true, transfer_horse = true, check_horseshoe = true, custom_coat_gene = true, custom_scale = true, display_owned = true, heal_horse = true, purchase_horse = true, purchase_horse_tack = true, horse_barber = true,  set_horse_tack = true, sell_horse = true, delete_horse = true, sell_horse_tack = true, set_custom_title = true, rename_horse = true, spawn_horse = true, neuter_horse = true, show_parents_info = true, change_horse_personality = true},},   -- EVERY OTHER PLAYER THAN THE ONES LISTED BELOW WILL GET THESE VALUES  
 		[2] = {IDENTIFIER = "steam:99", CHARID = 1, Menu_Options_Enabled = {main_menu = true, breed_horse_menu = true, custom_eyes = true, custom_coat = true, transfer_horse = true, check_horseshoe = true, custom_coat_gene = true, custom_scale = true, display_owned = true, heal_horse = true, purchase_horse = true, purchase_horse_tack = true, horse_barber = true,  set_horse_tack = true, sell_horse = true, delete_horse = true, sell_horse_tack = true, set_custom_title = true, rename_horse = true, spawn_horse = true, neuter_horse = true, show_parents_info = true, change_horse_personality = true},}, 	   -- IF playersrestriction = TRUE THEN LIST THE ROLES ALLOWED TO ACCESS THE STABLE HERE   
		},	
		exitcamerapos         = { 2951.12,  795.92,  50.86, 11.12, 0.00, -89.80, 50.00}, 			     
		playergotocoords      = {2955.27, 795.87, 51.39, 0.0},  
		healing_price      	  = 20.0,																	    
		purchase_multiplier   = 1.0,																	   		 
		sell_multiplier  	  = 1.0,
        wagonpos 			  = {2954.51, 805.21, 51.36, 153.68},
		wagonpreviewcamoffset = {3.0, -5.0},	
		wagonspawnpos 		  = {2943.91, 784.54, 51.31, -137.0},		
    },
	
    [6] = {
        name                  = "Colter Stables",
        title_given           = "Colter Stables",		
		blipenabled           = true,
		blipsprite            = -643888085,		
        blipcoords            = { -1334.52, 2400.99, 307.21},
        pedenabled            = true,							   										 
        pedmodel              = "u_m_m_bwmstablehand_01",							   						 
        pedscenario           = "WORLD_HUMAN_WAITING_IMPATIENT",
        pedcoords             = {-1334.52, 2400.99, 307.21, -29.0},			
        promptcoords          = {-1334.52, 2400.99, 307.21},
		promptdistance        = 2.0,
        horsepos              = { -1336.51, 2396.69, 307.11, -26.99},
		horsepreviewcamoffset = {3.0, 3.0},                                                                     
		introcamerapos        = { -1321.58, 2407.67, 310.90, -4.78,  0.00,  111.65,  50.00},		            
		menucamera            = { -1333.95, 2397.01, 307.90, -5.58,  0.00,  66.20,   50.00},		            
		breeding_camera       = {-1333.32, 2396.50, 309.08, -14.34, 0.00, 65.61, 50.0},		 	   				 
		breeding_menu_enabled = true,																			 
 		breeding_price = {                                                                                      
		[1] = {DATABASE_JOB_LABEL = "OTHER_JOBS", GOLD = 0.0, DOLLARS = 500.0}, 							    
 		},																			                            
		breeding_stallion_pos = {-1341.90 , 2397.21, 306.91, -112.0},											 
		breeding_mare_pos     = {-1339.43 , 2402.96, 306.91, -114.0},											 
		breeding_foal_pos     = {-1340.85 , 2400.13, 306.91, -113.0},			                                
 		neutering_price = {                                                                                     
		[1] = {DATABASE_JOB_LABEL = "OTHER_JOBS", GOLD = 0.0, DOLLARS = 300.0}, 							    
		},	                                                                                                    
 		rename_price = {                                                                                        
		[1] = {DATABASE_JOB_LABEL = "OTHER_JOBS", GOLD = 0.0, DOLLARS = 10.0}, 							    	 
		},	                                                                                                    
 		set_custom_title_price = {                                                                              
		[1] = {DATABASE_JOB_LABEL = "OTHER_JOBS", GOLD = 0.0, DOLLARS = 10.0}, 							    	 
		},			                                                                                            
		wagons_menu_enabled   = true,					                                                        
		rolerestriction       = false, 															 	  			 
		rolesallowed          = {  																				 
		[1] = {Role = "OTHER_JOBS", Menu_Options_Enabled = {main_menu = true, breed_horse_menu = true, custom_eyes = true, custom_coat = true, transfer_horse = true, check_horseshoe = true, custom_coat_gene = true, custom_scale = true, display_owned = true, heal_horse = true, purchase_horse = true, purchase_horse_tack = true, horse_barber = true,  set_horse_tack = true, sell_horse = true, delete_horse = true, sell_horse_tack = true, set_custom_title = true, rename_horse = true, spawn_horse = true, neuter_horse = true, show_parents_info = true, change_horse_personality = true},},	 -- EVERY OTHER JOBS THAN THE ONES LISTED BELOW WILL GET THESE VALUES  	
  		},
 
		playersrestriction    = false,																   		 
		playersallowed        = {
 		[1] = {IDENTIFIER = "OTHER_PLAYERS",  CHARID = "OTHER_PLAYERS",  Menu_Options_Enabled = {main_menu = true, breed_horse_menu = true, custom_eyes = true, custom_coat = true, transfer_horse = true, check_horseshoe = true, custom_coat_gene = true, custom_scale = true, display_owned = true, heal_horse = true, purchase_horse = true, purchase_horse_tack = true, horse_barber = true,  set_horse_tack = true, sell_horse = true, delete_horse = true, sell_horse_tack = true, set_custom_title = true, rename_horse = true, spawn_horse = true, neuter_horse = true, show_parents_info = true, change_horse_personality = true},},   -- EVERY OTHER PLAYER THAN THE ONES LISTED BELOW WILL GET THESE VALUES  
 		[2] = {IDENTIFIER = "steam:99", CHARID = 1, Menu_Options_Enabled = {main_menu = true, breed_horse_menu = true, custom_eyes = true, custom_coat = true, transfer_horse = true, check_horseshoe = true, custom_coat_gene = true, custom_scale = true, display_owned = true, heal_horse = true, purchase_horse = true, purchase_horse_tack = true, horse_barber = true,  set_horse_tack = true, sell_horse = true, delete_horse = true, sell_horse_tack = true, set_custom_title = true, rename_horse = true, spawn_horse = true, neuter_horse = true, show_parents_info = true, change_horse_personality = true},}, 	   -- IF playersrestriction = TRUE THEN LIST THE ROLES ALLOWED TO ACCESS THE STABLE HERE   
		},	
		exitcamerapos         = { -1330.13, 2410.20, 307.13, 6.50, 0.00, 156.50, 50.00}, 			    
		playergotocoords      = {-1332.06, 2406.27, 307.37, 0.0}, 	
		healing_price      	  = 20.0,																	    
		purchase_multiplier   = 1.0,																	   		 
		sell_multiplier  	  = 1.0,
        wagonpos 			  = {-1349.50, 2417.86, 307.01, 154.23},
		wagonpreviewcamoffset = {6.0, -5.0},			
		wagonspawnpos 		  = {-1333.01, 2382.69, 305.94, 118.09},		
    }, 
 
    [7] = { 
        name                  = "Tumbleweed Stables",
        title_given           = "Tumbleweed Stables",			
		blipenabled           = true,
		blipsprite            = -643888085,	
        blipcoords            = { -5513.84, -3044.29, -2.38},		
        pedenabled            = true,							   										 
        pedmodel              = "u_m_m_bwmstablehand_01",							   						 
        pedscenario           = "WORLD_HUMAN_WAITING_IMPATIENT",
        pedcoords             = {-5515.35, -3046.56, -2.39, -47.02},	
        promptcoords          = {-5515.35, -3046.56, -2.39, -47.02},
		promptdistance        = 2.0,2.0,
        horsepos              = { -5520.10,  -3044.29, -2.38, -95.0}, 
		horsepreviewcamoffset = {3.0, 3.0},                                                                    
		introcamerapos        = {-5499.48, -3054.33, 3.89,  -6.32,  0.00, 46.46,   50.00}, 			           
		menucamera            = {-5514.21, -3042.11, -2.25, 0.02,   0.00, 30.36,   50.00}, 			           
		breeding_camera       = {-5530.55, -3044.21, -0.31, -10.61, 0.00, 152.84, 50.0},		 	   		 
		breeding_menu_enabled = true,																		 
 		breeding_price = {                                                                                     
		[1] = {DATABASE_JOB_LABEL = "OTHER_JOBS", GOLD = 0.0, DOLLARS = 500.0}, 							   
 		},																			                           
		breeding_stallion_pos = {-5532.08, -3052.20, -1.95, 55.05},	 										 
		breeding_mare_pos     = {-5535.84, -3050.14, -1.57, -111.69},										 
		breeding_foal_pos     = {-5534.09, -3051.13, -1.68, -20.10},	                                       
 		neutering_price = {                                                                                    
		[1] = {DATABASE_JOB_LABEL = "OTHER_JOBS", GOLD = 0.0, DOLLARS = 300.0}, 							   
		},	                                                                                                   
 		rename_price = {                                                                                       
		[1] = {DATABASE_JOB_LABEL = "OTHER_JOBS", GOLD = 0.0, DOLLARS = 10.0}, 							     
		},	                                                                                                   
 		set_custom_title_price = {                                                                             
		[1] = {DATABASE_JOB_LABEL = "OTHER_JOBS", GOLD = 0.0, DOLLARS = 10.0}, 							     
		},			                                                                                           
		wagons_menu_enabled   = true,					                                                       
		rolerestriction       = false, 															 	  			 
		rolesallowed          = {  																				 
		[1] = {Role = "OTHER_JOBS", Menu_Options_Enabled = {main_menu = true, breed_horse_menu = true, custom_eyes = true, custom_coat = true, transfer_horse = true, check_horseshoe = true, custom_coat_gene = true, custom_scale = true, display_owned = true, heal_horse = true, purchase_horse = true, purchase_horse_tack = true, horse_barber = true,  set_horse_tack = true, sell_horse = true, delete_horse = true, sell_horse_tack = true, set_custom_title = true, rename_horse = true, spawn_horse = true, neuter_horse = true, show_parents_info = true, change_horse_personality = true},},	 -- EVERY OTHER JOBS THAN THE ONES LISTED BELOW WILL GET THESE VALUES  	
  		},
 
		playersrestriction    = false,																   		 
		playersallowed        = {
 		[1] = {IDENTIFIER = "OTHER_PLAYERS",  CHARID = "OTHER_PLAYERS",  Menu_Options_Enabled = {main_menu = true, breed_horse_menu = true, custom_eyes = true, custom_coat = true, transfer_horse = true, check_horseshoe = true, custom_coat_gene = true, custom_scale = true, display_owned = true, heal_horse = true, purchase_horse = true, purchase_horse_tack = true, horse_barber = true,  set_horse_tack = true, sell_horse = true, delete_horse = true, sell_horse_tack = true, set_custom_title = true, rename_horse = true, spawn_horse = true, neuter_horse = true, show_parents_info = true, change_horse_personality = true},},   -- EVERY OTHER PLAYER THAN THE ONES LISTED BELOW WILL GET THESE VALUES  
 		[2] = {IDENTIFIER = "steam:99", CHARID = 1, Menu_Options_Enabled = {main_menu = true, breed_horse_menu = true, custom_eyes = true, custom_coat = true, transfer_horse = true, check_horseshoe = true, custom_coat_gene = true, custom_scale = true, display_owned = true, heal_horse = true, purchase_horse = true, purchase_horse_tack = true, horse_barber = true,  set_horse_tack = true, sell_horse = true, delete_horse = true, sell_horse_tack = true, set_custom_title = true, rename_horse = true, spawn_horse = true, neuter_horse = true, show_parents_info = true, change_horse_personality = true},}, 	   -- IF playersrestriction = TRUE THEN LIST THE ROLES ALLOWED TO ACCESS THE STABLE HERE   
		},		
		exitcamerapos         = { -5503.02,  -3035.50, -3.53, 17.43, 0.00, 137.44, 50.00}, 			   
		playergotocoords      = {-5507.75, -3044.43, -2.60, 0.0}, 	
		healing_price      	  = 20.0,																	    
		purchase_multiplier   = 1.0,																	   		 
		sell_multiplier  	  = 1.0,
        wagonpos 		 	  = {-5544.81, -3045.82, -1.19, 6.02},
		wagonpreviewcamoffset = {8.0, -5.0},			
		wagonspawnpos	 	  = {-5528.43, -3074.17, -1.77, -81.0},			
    },
	
    [8] = { 
        name                  = "Strawberry Stables",
        title_given           = "Strawberry Stables",			
		blipenabled           = true,
		blipsprite            = -643888085,		
        blipcoords            = {-1817.35, -562.37, 156.06},		
        pedenabled            = true,							   										 
        pedmodel              = "u_m_m_bwmstablehand_01",							   						 
        pedscenario           = "WORLD_HUMAN_WAITING_IMPATIENT",
        pedcoords             = {-1817.35, -562.37, 156.06, -142.0},	
        promptcoords          = {-1817.35, -562.37, 156.06},	
		promptdistance        = 2.0,
        horsepos              = { -1821.85, -561.37, 156.06, -108.0},
		horsepreviewcamoffset = {3.0, 3.0},                                                                    
		introcamerapos        = {-1806.73, -576.16, 159.52, -4.69,  0.00, 34.20,   50.00},			           
		menucamera            = {-1817.18, -570.00, 157.53, -10.80, 0.00, 42.62,   50.00},			           
		breeding_camera       = {-1818.53, -574.52, 157.09, -7.93, 0.00, 115.20, 50.0},		 	   			 
		breeding_menu_enabled = true,																		 
 		breeding_price = {                                                                                     
		[1] = {DATABASE_JOB_LABEL = "OTHER_JOBS", GOLD = 0.0, DOLLARS = 500.0}, 							   
 
		},																			                           
		breeding_stallion_pos = {-1825.06591796875, -579.9232788085938, 155.88902282714844, 22.0},			 
		breeding_mare_pos     = {-1827.272216796875, -576.0126953125, 155.93235778808594, -135.0},			 
		breeding_foal_pos     = {-1825.6044921875, -577.6376953125, 155.89637756347656, -45.0   },			   
 		neutering_price = {                                                                                    
		[1] = {DATABASE_JOB_LABEL = "OTHER_JOBS", GOLD = 0.0, DOLLARS = 300.0}, 							   
		},	                                                                                                   
 		rename_price = {                                                                                       
		[1] = {DATABASE_JOB_LABEL = "OTHER_JOBS", GOLD = 0.0, DOLLARS = 10.0}, 							     
		},	                                                                                                   
 		set_custom_title_price = {                                                                             
		[1] = {DATABASE_JOB_LABEL = "OTHER_JOBS", GOLD = 0.0, DOLLARS = 10.0}, 							     
		},			                                                                                           
		wagons_menu_enabled   = true,					                                                       
		rolerestriction       = false, 															 	  			 
		rolesallowed          = {  																				 
		[1] = {Role = "OTHER_JOBS", Menu_Options_Enabled = {main_menu = true, breed_horse_menu = true, custom_eyes = true, custom_coat = true, transfer_horse = true, check_horseshoe = true, custom_coat_gene = true, custom_scale = true, display_owned = true, heal_horse = true, purchase_horse = true, purchase_horse_tack = true, horse_barber = true,  set_horse_tack = true, sell_horse = true, delete_horse = true, sell_horse_tack = true, set_custom_title = true, rename_horse = true, spawn_horse = true, neuter_horse = true, show_parents_info = true, change_horse_personality = true},},	 -- EVERY OTHER JOBS THAN THE ONES LISTED BELOW WILL GET THESE VALUES  	
  		},
 
		playersrestriction    = false,																   		 
		playersallowed        = {
 		[1] = {IDENTIFIER = "OTHER_PLAYERS",  CHARID = "OTHER_PLAYERS",  Menu_Options_Enabled = {main_menu = true, breed_horse_menu = true, custom_eyes = true, custom_coat = true, transfer_horse = true, check_horseshoe = true, custom_coat_gene = true, custom_scale = true, display_owned = true, heal_horse = true, purchase_horse = true, purchase_horse_tack = true, horse_barber = true,  set_horse_tack = true, sell_horse = true, delete_horse = true, sell_horse_tack = true, set_custom_title = true, rename_horse = true, spawn_horse = true, neuter_horse = true, show_parents_info = true, change_horse_personality = true},},   -- EVERY OTHER PLAYER THAN THE ONES LISTED BELOW WILL GET THESE VALUES  
 		[2] = {IDENTIFIER = "steam:99", CHARID = 1, Menu_Options_Enabled = {main_menu = true, breed_horse_menu = true, custom_eyes = true, custom_coat = true, transfer_horse = true, check_horseshoe = true, custom_coat_gene = true, custom_scale = true, display_owned = true, heal_horse = true, purchase_horse = true, purchase_horse_tack = true, horse_barber = true,  set_horse_tack = true, sell_horse = true, delete_horse = true, sell_horse_tack = true, set_custom_title = true, rename_horse = true, spawn_horse = true, neuter_horse = true, show_parents_info = true, change_horse_personality = true},}, 	   -- IF playersrestriction = TRUE THEN LIST THE ROLES ALLOWED TO ACCESS THE STABLE HERE   
		},	
		exitcamerapos         = {-1808.29,-558.87, 155.08, 20.84, 0.00, 121.90, 50.00}, 			 
		playergotocoords      = {-1811.32, -564.27, 155.96, -103.36}, 
		healing_price      	  = 20.0,																	    
		purchase_multiplier   = 1.0,																	   		 
		sell_multiplier  	  = 1.0,
        wagonpos 			  = {-1833.29, -575.06, 155.90, -106.0},
		wagonpreviewcamoffset = {8.0, -5.0},		
		wagonspawnpos 		  = {-1798.63, -547.17, 156.03, -46.24},		
    },
	
	[9] = {  
        name                  = "Mcfarlane Ranch Stables",
        title_given           = "Mcfarlane Ranch Stables",		
		blipenabled           = true,
		blipsprite            = -643888085,		
        blipcoords            = {-2402.64, -2374.02, 61.18},		
        pedenabled            = true,							   										 
        pedmodel              = "u_m_m_bwmstablehand_01",							   						 
        pedscenario           = "WORLD_HUMAN_WAITING_IMPATIENT",
        pedcoords             = {-2402.64, -2374.02, 61.18, 76.76},
        promptcoords          = {-2402.64, -2374.02, 61.18},
		promptdistance        = 2.0,
        horsepos              = {-2404.59, -2365.87, 61.12, 122.60},
		horsepreviewcamoffset = {3.0, 3.0},                                                                   	 
		introcamerapos        = {-2372.44, -2385.69, 65.96, -3.72,  0.00, 91.90,   50.00}, 				         
		menucamera            = {-2394.83, -2380.83, 60.97, 10.53,  0.00, -59.63,  50.00}, 				         
		breeding_camera       = {-2413.85, -2384.23, 62.83, -9.17, 0.00, -176.30, 50.0},		 	   			 
		breeding_menu_enabled = true,																			 
 		breeding_price = {                                                                                       
		[1] = {DATABASE_JOB_LABEL = "OTHER_JOBS", GOLD = 0.0, DOLLARS = 500.0}, 							     
 
		},																			                             
		breeding_stallion_pos = {-2416.33, -2395.17, 61.19, -67.72},											 
		breeding_mare_pos     = {-2410.81, -2392.20, 61.14, 81.39},											     
		breeding_foal_pos     = {-2412.41, -2393.36, 61.14, 32.67},		                                         
 		neutering_price = {                                                                                      
		[1] = {DATABASE_JOB_LABEL = "OTHER_JOBS", GOLD = 0.0, DOLLARS = 300.0}, 							     
		},	                                                                                                     
 		rename_price = {                                                                                         
		[1] = {DATABASE_JOB_LABEL = "OTHER_JOBS", GOLD = 0.0, DOLLARS = 10.0}, 							    	 
		},	                                                                                                     
 		set_custom_title_price = {                                                                               
		[1] = {DATABASE_JOB_LABEL = "OTHER_JOBS", GOLD = 0.0, DOLLARS = 10.0}, 							    	 
		},			                                                                                             
		wagons_menu_enabled   = true,					                                                         
		rolerestriction       = false, 															 	  			 
		rolesallowed          = {  																				 
		[1] = {Role = "OTHER_JOBS", Menu_Options_Enabled = {main_menu = true, breed_horse_menu = true, custom_eyes = true, custom_coat = true, transfer_horse = true, check_horseshoe = true, custom_coat_gene = true, custom_scale = true, display_owned = true, heal_horse = true, purchase_horse = true, purchase_horse_tack = true, horse_barber = true,  set_horse_tack = true, sell_horse = true, delete_horse = true, sell_horse_tack = true, set_custom_title = true, rename_horse = true, spawn_horse = true, neuter_horse = true, show_parents_info = true, change_horse_personality = true},},	 -- EVERY OTHER JOBS THAN THE ONES LISTED BELOW WILL GET THESE VALUES  	
  		},
 
		playersrestriction    = false,																   		 
		playersallowed        = {
 		[1] = {IDENTIFIER = "OTHER_PLAYERS",  CHARID = "OTHER_PLAYERS",  Menu_Options_Enabled = {main_menu = true, breed_horse_menu = true, custom_eyes = true, custom_coat = true, transfer_horse = true, check_horseshoe = true, custom_coat_gene = true, custom_scale = true, display_owned = true, heal_horse = true, purchase_horse = true, purchase_horse_tack = true, horse_barber = true,  set_horse_tack = true, sell_horse = true, delete_horse = true, sell_horse_tack = true, set_custom_title = true, rename_horse = true, spawn_horse = true, neuter_horse = true, show_parents_info = true, change_horse_personality = true},},   -- EVERY OTHER PLAYER THAN THE ONES LISTED BELOW WILL GET THESE VALUES  
 		[2] = {IDENTIFIER = "steam:99", CHARID = 1, Menu_Options_Enabled = {main_menu = true, breed_horse_menu = true, custom_eyes = true, custom_coat = true, transfer_horse = true, check_horseshoe = true, custom_coat_gene = true, custom_scale = true, display_owned = true, heal_horse = true, purchase_horse = true, purchase_horse_tack = true, horse_barber = true,  set_horse_tack = true, sell_horse = true, delete_horse = true, sell_horse_tack = true, set_custom_title = true, rename_horse = true, spawn_horse = true, neuter_horse = true, show_parents_info = true, change_horse_personality = true},}, 	   -- IF playersrestriction = TRUE THEN LIST THE ROLES ALLOWED TO ACCESS THE STABLE HERE   
		},	
		exitcamerapos         = {-2387.50, -2390.88, 61.31, 6.35, 0.00, 28.48, 50.00}, 					 
		playergotocoords      = {-2389.23, -2383.45, 61.11, 0.0},  
		healing_price      	  = 20.0,																	    
		purchase_multiplier   = 1.0,																	   		 
		sell_multiplier  	  = 1.0,
        wagonpos 			   = {-2403.89, -2389.91, 61.09, -111.0}, 
		wagonpreviewcamoffset  = {8.0, -5.0},		
		wagonspawnpos 		   = {-2395.46, -2370.60, 61.09, -111.44},		
    },
 
	[10] = { 
        name                  = "Guarma Stables",
        title_given           = "Guarma Stables",		
		blipenabled           = true,
		blipsprite            = -643888085,		
        blipcoords            = {1496.12, -7068.43, 76.86}, 
        pedenabled            = true,							   										 
        pedmodel              = "u_m_m_bwmstablehand_01",							   						 
        pedscenario           = "WORLD_HUMAN_WAITING_IMPATIENT",
        pedcoords             = {1496.12, -7068.43, 76.86, 90.0}, 		
        promptcoords          = {1496.12, -7068.43, 76.86},  
		promptdistance        = 2.0,
        horsepos              = {1496.19, -7072.86, 76.93, 69.82},
		horsepreviewcamoffset = {3.0, 3.0},                                                                   
		introcamerapos        = {1515.93, -7066.14, 80.46,  -4.00, 0.00, 112.33, 50.00}, 		              
		menucamera            = {1494.35, -7070.46, 77.13,  11.08, 0.00, -93.35, 50.00}, 		              
		breeding_camera       = {1492.98, -7075.51, 78.15, -8.71, 0.00, -85.22, 50.0},		 	   			  
		breeding_menu_enabled = true,																		  
 		breeding_price = {                                                                                    
		[1] = {DATABASE_JOB_LABEL = "OTHER_JOBS", GOLD = 0.0, DOLLARS = 500.0}, 							  
		},																			                          
		breeding_stallion_pos = {1499.10, -7073.04, 76.91, 159.03},											  
		breeding_mare_pos     = {1500.15, -7076.43, 77.15, 53.54},											  
		breeding_foal_pos     = {1498.87, -7075.05, 77.03, 100.28},		                                      
 		neutering_price = {                                                                                   
		[1] = {DATABASE_JOB_LABEL = "OTHER_JOBS", GOLD = 0.0, DOLLARS = 300.0}, 							  
		},	                                                                                                  
 		rename_price = {                                                                                      
		[1] = {DATABASE_JOB_LABEL = "OTHER_JOBS", GOLD = 0.0, DOLLARS = 10.0}, 							      
		},	                                                                                                  
 		set_custom_title_price = {                                                                            
		[1] = {DATABASE_JOB_LABEL = "OTHER_JOBS", GOLD = 0.0, DOLLARS = 10.0}, 							      
		},		                                                                                               
		wagons_menu_enabled   = true,					                                                       
		rolerestriction       = false, 															 	  			 
		rolesallowed          = {  																				 
		[1] = {Role = "OTHER_JOBS", Menu_Options_Enabled = {main_menu = true, breed_horse_menu = true, custom_eyes = true, custom_coat = true, transfer_horse = true, check_horseshoe = true, custom_coat_gene = true, custom_scale = true, display_owned = true, heal_horse = true, purchase_horse = true, purchase_horse_tack = true, horse_barber = true,  set_horse_tack = true, sell_horse = true, delete_horse = true, sell_horse_tack = true, set_custom_title = true, rename_horse = true, spawn_horse = true, neuter_horse = true, show_parents_info = true, change_horse_personality = true},},	 -- EVERY OTHER JOBS THAN THE ONES LISTED BELOW WILL GET THESE VALUES  	
  		},
 
		playersrestriction    = false,																   		 
		playersallowed        = {
 		[1] = {IDENTIFIER = "OTHER_PLAYERS",  CHARID = "OTHER_PLAYERS",  Menu_Options_Enabled = {main_menu = true, breed_horse_menu = true, custom_eyes = true, custom_coat = true, transfer_horse = true, check_horseshoe = true, custom_coat_gene = true, custom_scale = true, display_owned = true, heal_horse = true, purchase_horse = true, purchase_horse_tack = true, horse_barber = true,  set_horse_tack = true, sell_horse = true, delete_horse = true, sell_horse_tack = true, set_custom_title = true, rename_horse = true, spawn_horse = true, neuter_horse = true, show_parents_info = true, change_horse_personality = true},},   -- EVERY OTHER PLAYER THAN THE ONES LISTED BELOW WILL GET THESE VALUES  
 		[2] = {IDENTIFIER = "steam:99", CHARID = 1, Menu_Options_Enabled = {main_menu = true, breed_horse_menu = true, custom_eyes = true, custom_coat = true, transfer_horse = true, check_horseshoe = true, custom_coat_gene = true, custom_scale = true, display_owned = true, heal_horse = true, purchase_horse = true, purchase_horse_tack = true, horse_barber = true,  set_horse_tack = true, sell_horse = true, delete_horse = true, sell_horse_tack = true, set_custom_title = true, rename_horse = true, spawn_horse = true, neuter_horse = true, show_parents_info = true, change_horse_personality = true},}, 	   -- IF playersrestriction = TRUE THEN LIST THE ROLES ALLOWED TO ACCESS THE STABLE HERE   
		},				
		exitcamerapos         = {1503.75, -7069.19, 77.81, -5.33, 0.00, 119.15, 50.00}, 			  
		playergotocoords      = {1501.23 , -7080.35 , 77.27 },    
 		healing_price      	  = 20.0,																	    
		purchase_multiplier   = 1.0,																	   		 
		sell_multiplier  	  = 1.0,
        wagonpos 			  = {1485.19, -7095.90, 75.17, 23.31},
		wagonpreviewcamoffset = {8.0, -5.0},		
		wagonspawnpos 		  = {1505.12, -7116.18, 75.22, 35.0},		
    },
 
	[11] = { 
        name                  = "Wapiti Stables",
        title_given           = "Wapiti Stables",			
		blipenabled           = true,
		blipsprite            = -643888085,		
        blipcoords            = { 487.31, 2222.31, 247.10},	
        pedenabled            = true,							   										 
        pedmodel              = "u_m_m_bwmstablehand_01",							   						 
        pedscenario           = "WORLD_HUMAN_WAITING_IMPATIENT",
        pedcoords             = {487.31, 2222.31, 247.10, 90.0}, 			
        promptcoords          = { 487.31, 2222.31, 247.10},
	    promptdistance        = 2.0,		
        horsepos              = { 487.15, 2215.18, 247.09, 5.84},
		horsepreviewcamoffset = {3.0, 3.0},                                                                   
		introcamerapos        = {481.04, 2239.04, 253.00, -10.79, 0.00, 160.35, 50.00}, 				      
		menucamera            = {483.34, 2219.07, 247.40, -4.05,  0.00, 108.12, 50.00}, 				      
		breeding_camera       = {486.63, 2222.62, 248.90, -12.44, 0.00, -170.54, 15.19},		 	   		 
		breeding_menu_enabled = true,																		 
 		breeding_price = {                                                                                    
		[1] = {DATABASE_JOB_LABEL = "OTHER_JOBS", GOLD = 0.0, DOLLARS = 500.0}, 							  
		},																			                          
		breeding_stallion_pos = {489.7463684082031, 2215.6552734375, 247.27993774414062, 75.0},				 
		breeding_mare_pos     = {485.6665344238281, 2214.927978515625, 247.02560424804688, -59.0},			 
		breeding_foal_pos     = {487.80, 2215.67, 247.16, 15.0},	                                          
 		neutering_price = {                                                                                   
		[1] = {DATABASE_JOB_LABEL = "OTHER_JOBS", GOLD = 0.0, DOLLARS = 300.0}, 							  
		},	                                                                                                  
 		rename_price = {                                                                                      
		[1] = {DATABASE_JOB_LABEL = "OTHER_JOBS", GOLD = 0.0, DOLLARS = 10.0}, 							     
		},	                                                                                                  
 		set_custom_title_price = {                                                                            
		[1] = {DATABASE_JOB_LABEL = "OTHER_JOBS", GOLD = 0.0, DOLLARS = 10.0}, 							     
		},			                                                                                          
		wagons_menu_enabled   = true,					                                                      
		rolerestriction       = false, 															 	  			 
		rolesallowed          = {  																				 
		[1] = {Role = "OTHER_JOBS", Menu_Options_Enabled = {main_menu = true, breed_horse_menu = true, custom_eyes = true, custom_coat = true, transfer_horse = true, check_horseshoe = true, custom_coat_gene = true, custom_scale = true, display_owned = true, heal_horse = true, purchase_horse = true, purchase_horse_tack = true, horse_barber = true,  set_horse_tack = true, sell_horse = true, delete_horse = true, sell_horse_tack = true, set_custom_title = true, rename_horse = true, spawn_horse = true, neuter_horse = true, show_parents_info = true, change_horse_personality = true},},	 -- EVERY OTHER JOBS THAN THE ONES LISTED BELOW WILL GET THESE VALUES  	
  		},
 
		playersrestriction    = false,																   		 
		playersallowed        = {
 		[1] = {IDENTIFIER = "OTHER_PLAYERS",  CHARID = "OTHER_PLAYERS",  Menu_Options_Enabled = {main_menu = true, breed_horse_menu = true, custom_eyes = true, custom_coat = true, transfer_horse = true, check_horseshoe = true, custom_coat_gene = true, custom_scale = true, display_owned = true, heal_horse = true, purchase_horse = true, purchase_horse_tack = true, horse_barber = true,  set_horse_tack = true, sell_horse = true, delete_horse = true, sell_horse_tack = true, set_custom_title = true, rename_horse = true, spawn_horse = true, neuter_horse = true, show_parents_info = true, change_horse_personality = true},},   -- EVERY OTHER PLAYER THAN THE ONES LISTED BELOW WILL GET THESE VALUES  
 		[2] = {IDENTIFIER = "steam:99", CHARID = 1, Menu_Options_Enabled = {main_menu = true, breed_horse_menu = true, custom_eyes = true, custom_coat = true, transfer_horse = true, check_horseshoe = true, custom_coat_gene = true, custom_scale = true, display_owned = true, heal_horse = true, purchase_horse = true, purchase_horse_tack = true, horse_barber = true,  set_horse_tack = true, sell_horse = true, delete_horse = true, sell_horse_tack = true, set_custom_title = true, rename_horse = true, spawn_horse = true, neuter_horse = true, show_parents_info = true, change_horse_personality = true},}, 	   -- IF playersrestriction = TRUE THEN LIST THE ROLES ALLOWED TO ACCESS THE STABLE HERE   
		},		
		exitcamerapos         = { 473.47, 2230.61, 248.13, -6.87, 0.00, -112.79, 50.00}, 				 
		playergotocoords      = {481.46, 2230.33, 247.32 },    
 		healing_price      	  = 20.0,																	    
		purchase_multiplier   = 1.0,																	   		 
		sell_multiplier  	  = 1.0,
        wagonpos 			  = {484.32, 2228.08, 247.13, -87.09},
		wagonpreviewcamoffset = {8.0, -5.0},		
		wagonspawnpos 		  = {493.04, 2245.29, 248.10, -141.32},		
    },
	
	[12] = { 
        name                  = "Little Creek Stables",
        title_given           = "Little Creek Stables",			
		blipenabled           = true,
		blipsprite            = -643888085,		
        blipcoords            = {-2215.39, 728.84, 123.00}, 
        pedenabled            = true,							   										 
        pedmodel              = "u_m_m_bwmstablehand_01",							   						 
        pedscenario           = "WORLD_HUMAN_WAITING_IMPATIENT",
        pedcoords             = {-2215.39, 728.84, 123.00, -151.0}, 		
        promptcoords          = {-2215.39, 728.84, 123.00},  
		promptdistance        = 2.0,
        horsepos              = { -2225.82, 704.11, 122.03, -62.99},
		horsepreviewcamoffset = {3.0, 3.0},                                                                    
		introcamerapos        = {-2188.68, 719.41, 127.78, -3.58,  0.00, 75.99, 50.0}, 			                
		menucamera            = {-2214.54, 709.75, 121.79, 13.23,  0.00, 22.43, 50.0}, 			                
		breeding_camera       = {-2239.97, 694.19, 123.19, -9.51, 0.00, -21.16, 50.0},		 	   				 
		breeding_menu_enabled = true,																			 
 		breeding_price = {                                                                                      
		[1] = {DATABASE_JOB_LABEL = "OTHER_JOBS", GOLD = 0.0, DOLLARS = 500.0}, 							    
 
		},																			                            
		breeding_stallion_pos = {-2238.71, 703.71, 121.54, -109.0},												 
		breeding_mare_pos     = {-2234.67, 701.59, 121.51, 60.5},											    
		breeding_foal_pos     = {-2236.89, 702.30, 121.47, 3.2},							                    
		wagons_menu_enabled   = true,	                                                                        
 		neutering_price = {                                                                                     
		[1] = {DATABASE_JOB_LABEL = "OTHER_JOBS", GOLD = 0.0, DOLLARS = 300.0}, 							    
		},	                                                                                                    
 		rename_price = {                                                                                        
		[1] = {DATABASE_JOB_LABEL = "OTHER_JOBS", GOLD = 0.0, DOLLARS = 10.0}, 							    	 
		},	                                                                                                    
 		set_custom_title_price = {                                                                              
		[1] = {DATABASE_JOB_LABEL = "OTHER_JOBS", GOLD = 0.0, DOLLARS = 10.0}, 							    	 
		},			                                                                                            
		rolerestriction       = false, 															 	  			 
		rolesallowed          = {  																				 
		[1] = {Role = "OTHER_JOBS", Menu_Options_Enabled = {main_menu = true, breed_horse_menu = true, custom_eyes = true, custom_coat = true, transfer_horse = true, check_horseshoe = true, custom_coat_gene = true, custom_scale = true, display_owned = true, heal_horse = true, purchase_horse = true, purchase_horse_tack = true, horse_barber = true,  set_horse_tack = true, sell_horse = true, delete_horse = true, sell_horse_tack = true, set_custom_title = true, rename_horse = true, spawn_horse = true, neuter_horse = true, show_parents_info = true, change_horse_personality = true},},	 -- EVERY OTHER JOBS THAN THE ONES LISTED BELOW WILL GET THESE VALUES  	
  		},
 
		playersrestriction    = false,																   		 
		playersallowed        = {
 		[1] = {IDENTIFIER = "OTHER_PLAYERS",  CHARID = "OTHER_PLAYERS",  Menu_Options_Enabled = {main_menu = true, breed_horse_menu = true, custom_eyes = true, custom_coat = true, transfer_horse = true, check_horseshoe = true, custom_coat_gene = true, custom_scale = true, display_owned = true, heal_horse = true, purchase_horse = true, purchase_horse_tack = true, horse_barber = true,  set_horse_tack = true, sell_horse = true, delete_horse = true, sell_horse_tack = true, set_custom_title = true, rename_horse = true, spawn_horse = true, neuter_horse = true, show_parents_info = true, change_horse_personality = true},},   -- EVERY OTHER PLAYER THAN THE ONES LISTED BELOW WILL GET THESE VALUES  
 		[2] = {IDENTIFIER = "steam:99", CHARID = 1, Menu_Options_Enabled = {main_menu = true, breed_horse_menu = true, custom_eyes = true, custom_coat = true, transfer_horse = true, check_horseshoe = true, custom_coat_gene = true, custom_scale = true, display_owned = true, heal_horse = true, purchase_horse = true, purchase_horse_tack = true, horse_barber = true,  set_horse_tack = true, sell_horse = true, delete_horse = true, sell_horse_tack = true, set_custom_title = true, rename_horse = true, spawn_horse = true, neuter_horse = true, show_parents_info = true, change_horse_personality = true},}, 	   -- IF playersrestriction = TRUE THEN LIST THE ROLES ALLOWED TO ACCESS THE STABLE HERE   
		},
		exitcamerapos         = {-2205.61, 713.19, 122.10, 15.77, 0.00, 31.50, 50.00},				 
		playergotocoords      = {-2209.53, 720.60, 122.58}, 
		healing_price      	  = 20.0,																	    
		purchase_multiplier   = 1.0,																	   		 
		sell_multiplier  	  = 1.0,
        wagonpos 			  = {-2232.93, 724.81, 122.77, -153.21},
		wagonpreviewcamoffset = {8.0, -5.0},		
		wagonspawnpos 		  = {-2160.19, 673.04, 120.11, 130.0},		
    },
	[13] = { 
        name                  = "Pronghorn Stables",
        title_given           = "Pronghorn Stables",			
		blipenabled           = true,
		blipsprite            = -643888085,		
        blipcoords            = {-2556.3320, 403.3824, 148.2386}, 
        pedenabled            = true,							   										 
        pedmodel              = "u_m_m_bwmstablehand_01",							   						 
        pedscenario           = "WORLD_HUMAN_WAITING_IMPATIENT",
        pedcoords             = {-2556.3320, 403.3824, 148.2386, 92.7343}, 		
        promptcoords          = {-2556.3320, 403.3824, 148.2386},  
		promptdistance        = 2.0,
        horsepos              = {-2554.0066, 399.7073, 148.1630, 95.1685},
		horsepreviewcamoffset = {-2.75, -2.50},                                                                    
		introcamerapos        = {-2557.43, 397.44, 148.69, -3.64,  0.00, -74.64, 50.0}, 			                
		menucamera            = {-2569.62, 387.12, 149.98, 2.56,  0.00, -31.83, 50.0}, 			                
		breeding_camera       = {-2239.97, 694.19, 123.19, -9.51, 0.00, -21.16, 50.0},		 	   				 
		breeding_menu_enabled = true,																			 
 		breeding_price = {                                                                                      
		[1] = {DATABASE_JOB_LABEL = "OTHER_JOBS", GOLD = 0.0, DOLLARS = 500.0}, 							    
 
		},																			                            
		breeding_stallion_pos = {-2238.71, 703.71, 121.54, -109.0},												 
		breeding_mare_pos     = {-2234.67, 701.59, 121.51, 60.5},											    
		breeding_foal_pos     = {-2236.89, 702.30, 121.47, 3.2},							                    
		wagons_menu_enabled   = true,	                                                                        
 		neutering_price = {                                                                                     
		[1] = {DATABASE_JOB_LABEL = "OTHER_JOBS", GOLD = 0.0, DOLLARS = 300.0}, 							    
		},	                                                                                                    
 		rename_price = {                                                                                        
		[1] = {DATABASE_JOB_LABEL = "OTHER_JOBS", GOLD = 0.0, DOLLARS = 10.0}, 							    	 
		},	                                                                                                    
 		set_custom_title_price = {                                                                              
		[1] = {DATABASE_JOB_LABEL = "OTHER_JOBS", GOLD = 0.0, DOLLARS = 10.0}, 							    	 
		},			                                                                                            
		rolerestriction       = false, 															 	  			 
		rolesallowed          = {  																				 
		[1] = {Role = "OTHER_JOBS", Menu_Options_Enabled = {main_menu = true, breed_horse_menu = true, custom_eyes = true, custom_coat = true, transfer_horse = true, check_horseshoe = true, custom_coat_gene = true, custom_scale = true, display_owned = true, heal_horse = true, purchase_horse = true, purchase_horse_tack = true, horse_barber = true,  set_horse_tack = true, sell_horse = true, delete_horse = true, sell_horse_tack = true, set_custom_title = true, rename_horse = true, spawn_horse = true, neuter_horse = true, show_parents_info = true, change_horse_personality = true},},	 -- EVERY OTHER JOBS THAN THE ONES LISTED BELOW WILL GET THESE VALUES  	
  		},
 
		playersrestriction    = false,																   		 
		playersallowed        = {
 		[1] = {IDENTIFIER = "OTHER_PLAYERS",  CHARID = "OTHER_PLAYERS",  Menu_Options_Enabled = {main_menu = true, breed_horse_menu = true, custom_eyes = true, custom_coat = true, transfer_horse = true, check_horseshoe = true, custom_coat_gene = true, custom_scale = true, display_owned = true, heal_horse = true, purchase_horse = true, purchase_horse_tack = true, horse_barber = true,  set_horse_tack = true, sell_horse = true, delete_horse = true, sell_horse_tack = true, set_custom_title = true, rename_horse = true, spawn_horse = true, neuter_horse = true, show_parents_info = true, change_horse_personality = true},},   -- EVERY OTHER PLAYER THAN THE ONES LISTED BELOW WILL GET THESE VALUES  
 		[2] = {IDENTIFIER = "steam:99", CHARID = 1, Menu_Options_Enabled = {main_menu = true, breed_horse_menu = true, custom_eyes = true, custom_coat = true, transfer_horse = true, check_horseshoe = true, custom_coat_gene = true, custom_scale = true, display_owned = true, heal_horse = true, purchase_horse = true, purchase_horse_tack = true, horse_barber = true,  set_horse_tack = true, sell_horse = true, delete_horse = true, sell_horse_tack = true, set_custom_title = true, rename_horse = true, spawn_horse = true, neuter_horse = true, show_parents_info = true, change_horse_personality = true},}, 	   -- IF playersrestriction = TRUE THEN LIST THE ROLES ALLOWED TO ACCESS THE STABLE HERE   
		},
		exitcamerapos         = {-2205.61, 713.19, 122.10, 15.77, 0.00, 31.50, 50.00},				 
		playergotocoords      = {-2209.53, 720.60, 122.58}, 
		healing_price      	  = 20.0,																	    
		purchase_multiplier   = 1.0,																	   		 
		sell_multiplier  	  = 1.0,
        wagonpos 			  = {-2232.93, 724.81, 122.77, -153.21},
		wagonpreviewcamoffset = {8.0, -5.0},		
		wagonspawnpos 		  = {-2160.19, 673.04, 120.11, 130.0},		
    },
		[14] = { 
        name                  = "Still Waters",
        title_given           = "Still Waters",			
		blipenabled           = false,
		blipsprite            = -643888085,		
        blipcoords            = {-2556.3320, 403.3824, 148.2386}, 
        pedenabled            = false,							   										 
        pedmodel              = "u_m_m_bwmstablehand_01",							   						 
        pedscenario           = "WORLD_HUMAN_WAITING_IMPATIENT",
        pedcoords             = {2254.4424, -138.9538, 46.5081, 75.7385}, 		
        promptcoords          = {2254.4424, -138.9538, 46.5081},  
		promptdistance        = 2.0,
        horsepos              = {2247.1138, -145.3113, 46.5447, 6.3526},
		horsepreviewcamoffset = {-2.75, 3.00},                                                                    
		introcamerapos        = {2245.30, -123.64, 57.89, -21.03,  0.00, -139.13, 61.0}, 			                
		menucamera            = {2245.30, -123.64, 57.89, -21.03,  0.00, -139.13, 61.0}, 			                
		breeding_camera       = {-2239.97, 694.19, 123.19, -9.51, 0.00, -21.16, 50.0},		 	   				 
		breeding_menu_enabled = true,																			 
 		breeding_price = {                                                                                      
		[1] = {DATABASE_JOB_LABEL = "OTHER_JOBS", GOLD = 0.0, DOLLARS = 500.0}, 							    
 
		},																			                            
		breeding_stallion_pos = {2273.5723, -168.1174, 42.3426, 72.7630},												 
		breeding_mare_pos     = {2273.5984, -172.6077, 41.9074, 19.6285},											    
		breeding_foal_pos     = {2275.1877, -171.3763, 42.0587, 59.6328},							                    
		wagons_menu_enabled   = true,	                                                                        
 		neutering_price = {                                                                                     
		[1] = {DATABASE_JOB_LABEL = "OTHER_JOBS", GOLD = 0.0, DOLLARS = 300.0}, 							    
		},	                                                                                                    
 		rename_price = {                                                                                        
		[1] = {DATABASE_JOB_LABEL = "OTHER_JOBS", GOLD = 0.0, DOLLARS = 10.0}, 							    	 
		},	                                                                                                    
 		set_custom_title_price = {                                                                              
		[1] = {DATABASE_JOB_LABEL = "OTHER_JOBS", GOLD = 0.0, DOLLARS = 10.0}, 							    	 
		},			                                                                                            
		rolerestriction       = false, 															 	  			 
		rolesallowed          = {  																				 
		[1] = {Role = "OTHER_JOBS", Menu_Options_Enabled = {main_menu = true, breed_horse_menu = true, custom_eyes = true, custom_coat = true, transfer_horse = true, check_horseshoe = true, custom_coat_gene = true, custom_scale = true, display_owned = true, heal_horse = true, purchase_horse = true, purchase_horse_tack = true, horse_barber = true,  set_horse_tack = true, sell_horse = true, delete_horse = true, sell_horse_tack = true, set_custom_title = true, rename_horse = true, spawn_horse = true, neuter_horse = true, show_parents_info = true, change_horse_personality = true},},	 -- EVERY OTHER JOBS THAN THE ONES LISTED BELOW WILL GET THESE VALUES  	
  		},
 
		playersrestriction    = false,																   		 
		playersallowed        = {
 		[1] = {IDENTIFIER = "OTHER_PLAYERS",  CHARID = "OTHER_PLAYERS",  Menu_Options_Enabled = {main_menu = true, breed_horse_menu = true, custom_eyes = true, custom_coat = true, transfer_horse = true, check_horseshoe = true, custom_coat_gene = true, custom_scale = true, display_owned = true, heal_horse = true, purchase_horse = true, purchase_horse_tack = true, horse_barber = true,  set_horse_tack = true, sell_horse = true, delete_horse = true, sell_horse_tack = true, set_custom_title = true, rename_horse = true, spawn_horse = true, neuter_horse = true, show_parents_info = true, change_horse_personality = true},},   -- EVERY OTHER PLAYER THAN THE ONES LISTED BELOW WILL GET THESE VALUES  
 		[2] = {IDENTIFIER = "steam:99", CHARID = 1, Menu_Options_Enabled = {main_menu = true, breed_horse_menu = true, custom_eyes = true, custom_coat = true, transfer_horse = true, check_horseshoe = true, custom_coat_gene = true, custom_scale = true, display_owned = true, heal_horse = true, purchase_horse = true, purchase_horse_tack = true, horse_barber = true,  set_horse_tack = true, sell_horse = true, delete_horse = true, sell_horse_tack = true, set_custom_title = true, rename_horse = true, spawn_horse = true, neuter_horse = true, show_parents_info = true, change_horse_personality = true},}, 	   -- IF playersrestriction = TRUE THEN LIST THE ROLES ALLOWED TO ACCESS THE STABLE HERE   
		},
		exitcamerapos         = {-2205.61, 713.19, 122.10, 15.77, 0.00, 31.50, 50.00},				 
		playergotocoords      = {-2209.53, 720.60, 122.58}, 
		healing_price      	  = 20.0,																	    
		purchase_multiplier   = 1.0,																	   		 
		sell_multiplier  	  = 1.0,
        wagonpos 			  = {-2232.93, 724.81, 122.77, -153.21},
		wagonpreviewcamoffset = {8.0, -5.0},		
		wagonspawnpos 		  = {-2160.19, 673.04, 120.11, 130.0},		
    },
}
 