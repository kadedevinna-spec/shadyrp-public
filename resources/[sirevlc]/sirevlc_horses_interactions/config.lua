Config = {}

-- Version 4.06 - 23.02.26
 
-------------------------------------------
               --MENU --
-------------------------------------------
Config.MENU_ACTIVE   				 = true  
Config.OpenMenuKey  				 = 0x1F6D95E5 -- [F4] 
Config.OPEN_MENU_COMMAND_ENABLED     = true
Config.OPEN_MENU_COMMAND        	 = "horse_menu"
 
Config.NOTIFICATION_DURATION_1  	 = 5000

Config.DRINKING_DURATION  			 = 15 -- IN SECONDS
Config.GRAZING_DURATION   			 = 15 -- IN SECONDS

Config.FollowDistanceOffset 		 = 5.0 -- THE HORSE WILL AIM TO FOLLOW THIS DISTANCE BEHIND YOU
-- TO ENABLE OR DISABLE OPTIONS YOU CAN DIRECTLY DISABLE THEM IN THE MENUS BELOW.

-- SPECIAL EQUIPMENTS --

-- HERE YOU CAN ENABLE OR DISABLE A CATEGORY, TRANSLATE THE TEXTS AND CHANGE THE IMAGES. TO DISABLE ONe category just add -- in front of the line like this :
-- {LABEL = "SPECIAL SADDLE ONE", VALUE = "ACTION18", DESC = "SPECIAL SADDLE ONE"},
Config.HORSE_INFOS           = "HORSE INFOS" 
Config.HORSE_NAME            = "NAME: "
Config.HORSE_MAIN_TITLE 	 = "MAIN TITLE: "	 
Config.HORSE_SECOND_TITLE    = "SECOND TITLE: "   		 
Config.HORSE_XP  			 = "XP: "  			  				 
Config.HORSE_HUNGER 		 = "HUNGER: " 		
Config.HORSE_THIRST 		 = "THIRST: " 		
Config.HORSE_WEATHER		 = "WEATHER TYPE: " 		
Config.HORSE_LOVE 			 = "LOVE: " 			
Config.HORSE_BONDING_LEVEL   = "BONDING LEVEL: "  
Config.HORSE_PERSONALITY     = "PERSONALITY: "    
Config.HORSE_GENDER          = "GENDER: "         
Config.HORSE_BREED_NAME      = "BREED NAME: "     
Config.HORSE_COAT_NAME       = "COAT NAME: "      
Config.HORSE_AGE             = "AGE: "            
Config.HORSE_COURAGE         = "COURAGE: "        
Config.HORSE_AGILITY         = "AGILITY: "        
Config.HORSE_HEALTH          = "HEALTH: "         
Config.HORSE_STAMINA         = "STAMINA: "        
Config.HORSE_ACCELERATION    = "ACCELERATION: "   
Config.HORSE_SPEED           = "SPEED: "          
 
Config.HORSE_DISPLAYED_INFOS = {	
"HORSE_NAME",            
"HORSE_MAIN_TITLE", 	 
"HORSE_SECOND_TITLE",    
"HORSE_XP",  			 
"HORSE_HUNGER", 		 
"HORSE_THIRST", 		 
"HORSE_LOVE", 			 
"HORSE_BONDING_LEVEL", 
"HORSE_WEATHER",  
"HORSE_PERSONALITY",     
"HORSE_GENDER",          
"HORSE_BREED_NAME",      
"HORSE_COAT_NAME",       
"HORSE_AGE",             
"HORSE_COURAGE",         
"HORSE_AGILITY",         
"HORSE_HEALTH",          
"HORSE_STAMINA",        
"HORSE_ACCELERATION",    
"HORSE_SPEED",           
}
 
Config.EquipmentsCategoriesTitle = "NPC HORSE TACK"
Config.EquipmentsCategories = {										 
        {label = "Special Saddle V1"       , value = "action18",   command_enabled = true , command_label = "npc_tack18" , xp_lock = true, xp_required = 0, player_lock = true, player_list = {[1] = {identifier = "steam_99", charid = 1}}, job_lock = false, job_list = {"horsetrainer"}, desc = "Special Saddle V1"        }, -- SPECIAL SADDLES
        {label = "Special Saddle V2"       , value = "action19",   command_enabled = true , command_label = "npc_tack19" , xp_lock = true, xp_required = 0, player_lock = true, player_list = {[1] = {identifier = "steam_99", charid = 1}}, job_lock = false, job_list = {"horsetrainer"}, desc = "Special Saddle V2"        }, -- SPECIAL SADDLES
        {label = "Special Saddle V3"       , value = "action20",   command_enabled = true , command_label = "npc_tack20" , xp_lock = true, xp_required = 0, player_lock = true, player_list = {[1] = {identifier = "steam_99", charid = 1}}, job_lock = false, job_list = {"horsetrainer"}, desc = "Special Saddle V3"        }, -- SPECIAL SADDLES
        {label = "Special Saddle V4"       , value = "action21",   command_enabled = true , command_label = "npc_tack21" , xp_lock = true, xp_required = 0, player_lock = true, player_list = {[1] = {identifier = "steam_99", charid = 1}}, job_lock = false, job_list = {"horsetrainer"}, desc = "Special Saddle V4"        }, -- SPECIAL SADDLES		
        {label = "Mine full gear"          , value = "action07",   command_enabled = true , command_label = "npc_tack07" , xp_lock = true, xp_required = 0, player_lock = true, player_list = {[1] = {identifier = "steam_99", charid = 1}}, job_lock = false, job_list = {"horsetrainer"}, desc = "Mine full gear"           }, -- SPECIAL ROLE SADDLES 
        {label = "Mine half gear I"        , value = "action08",   command_enabled = true , command_label = "npc_tack08" , xp_lock = true, xp_required = 0, player_lock = true, player_list = {[1] = {identifier = "steam_99", charid = 1}}, job_lock = false, job_list = {"horsetrainer"}, desc = "Mine half gear I"         }, -- SPECIAL ROLE SADDLES 
        {label = "Trapper full gear"       , value = "action09",   command_enabled = true , command_label = "npc_tack09" , xp_lock = true, xp_required = 0, player_lock = true, player_list = {[1] = {identifier = "steam_99", charid = 1}}, job_lock = false, job_list = {"horsetrainer"}, desc = "Trapper full gear"        }, -- SPECIAL ROLE SADDLES 
        {label = "Moonshiner full gear"    , value = "action10",   command_enabled = true , command_label = "npc_tack10" , xp_lock = true, xp_required = 0, player_lock = true, player_list = {[1] = {identifier = "steam_99", charid = 1}}, job_lock = false, job_list = {"horsetrainer"}, desc = "Moonshiner full gear"     }, -- SPECIAL ROLE SADDLES 
        {label = "Traveller full gear I"   , value = "action11",   command_enabled = true , command_label = "npc_tack11" , xp_lock = true, xp_required = 0, player_lock = true, player_list = {[1] = {identifier = "steam_99", charid = 1}}, job_lock = false, job_list = {"horsetrainer"}, desc = "Traveller full gear I"    }, -- SPECIAL ROLE SADDLES 
        {label = "Traveller half gear I"   , value = "action12",   command_enabled = true , command_label = "npc_tack12" , xp_lock = true, xp_required = 0, player_lock = true, player_list = {[1] = {identifier = "steam_99", charid = 1}}, job_lock = false, job_list = {"horsetrainer"}, desc = "Traveller half gear I"    }, -- SPECIAL ROLE SADDLES 
        {label = "Traveller full gear II"  , value = "action13",   command_enabled = true , command_label = "npc_tack13" , xp_lock = true, xp_required = 0, player_lock = true, player_list = {[1] = {identifier = "steam_99", charid = 1}}, job_lock = false, job_list = {"horsetrainer"}, desc = "Traveller full gear II"   }, -- SPECIAL ROLE SADDLES																		  
        {label = "Blanket fur V1"          , value = "action04",   command_enabled = true , command_label = "npc_tack04" , xp_lock = true, xp_required = 0, player_lock = true, player_list = {[1] = {identifier = "steam_99", charid = 1}}, job_lock = false, job_list = {"horsetrainer"}, desc = "Blanket fur V1"           }, -- SPECIAL BLANKETS
        {label = "Blanket fur V2"          , value = "action05",   command_enabled = true , command_label = "npc_tack05" , xp_lock = true, xp_required = 0, player_lock = true, player_list = {[1] = {identifier = "steam_99", charid = 1}}, job_lock = false, job_list = {"horsetrainer"}, desc = "Blanket fur V2"           }, -- SPECIAL BLANKETS 
        {label = "Blanket fur V3"          , value = "action22",   command_enabled = true , command_label = "npc_tack22" , xp_lock = true, xp_required = 0, player_lock = true, player_list = {[1] = {identifier = "steam_99", charid = 1}}, job_lock = false, job_list = {"horsetrainer"}, desc = "Blanket fur V3"           }, -- SPECIAL BLANKETS
        {label = "Blanket fur V4"          , value = "action23",   command_enabled = true , command_label = "npc_tack23" , xp_lock = true, xp_required = 0, player_lock = true, player_list = {[1] = {identifier = "steam_99", charid = 1}}, job_lock = false, job_list = {"horsetrainer"}, desc = "Blanket fur V4"           }, -- SPECIAL BLANKETS
        {label = "Blanket fur V5"          , value = "action24",   command_enabled = true , command_label = "npc_tack24" , xp_lock = true, xp_required = 0, player_lock = true, player_list = {[1] = {identifier = "steam_99", charid = 1}}, job_lock = false, job_list = {"horsetrainer"}, desc = "Blanket fur V5"           }, -- SPECIAL BLANKETS
        {label = "Blanket fur V6"          , value = "action25",   command_enabled = true , command_label = "npc_tack25" , xp_lock = true, xp_required = 0, player_lock = true, player_list = {[1] = {identifier = "steam_99", charid = 1}}, job_lock = false, job_list = {"horsetrainer"}, desc = "Blanket fur V6"           }, -- SPECIAL BLANKETS
        {label = "Blanket fur V7"          , value = "action26",   command_enabled = true , command_label = "npc_tack26" , xp_lock = true, xp_required = 0, player_lock = true, player_list = {[1] = {identifier = "steam_99", charid = 1}}, job_lock = false, job_list = {"horsetrainer"}, desc = "Blanket fur V7"           }, -- SPECIAL BLANKETS
        {label = "Blanket fur V8"          , value = "action27",   command_enabled = true , command_label = "npc_tack27" , xp_lock = true, xp_required = 0, player_lock = true, player_list = {[1] = {identifier = "steam_99", charid = 1}}, job_lock = false, job_list = {"horsetrainer"}, desc = "Blanket fur V8"           }, -- SPECIAL BLANKETS	
        {label = "Harness one"             , value = "action01",   command_enabled = true , command_label = "npc_tack01" , xp_lock = true, xp_required = 0, player_lock = true, player_list = {[1] = {identifier = "steam_99", charid = 1}}, job_lock = false, job_list = {"horsetrainer"}, desc = "Harness one"              }, -- SPECIAL HARNESSES
        {label = "Harness two"             , value = "action02",   command_enabled = true , command_label = "npc_tack02" , xp_lock = true, xp_required = 0, player_lock = true, player_list = {[1] = {identifier = "steam_99", charid = 1}}, job_lock = false, job_list = {"horsetrainer"}, desc = "Harness two"              }, -- SPECIAL HARNESSES
        {label = "Harness three"           , value = "action03",   command_enabled = true , command_label = "npc_tack03" , xp_lock = true, xp_required = 0, player_lock = true, player_list = {[1] = {identifier = "steam_99", charid = 1}}, job_lock = false, job_list = {"horsetrainer"}, desc = "Harness three"            }, -- SPECIAL HARNESSES 	
        {label = "Bridle rope"             , value = "action06",   command_enabled = true , command_label = "npc_tack06" , xp_lock = true, xp_required = 0, player_lock = true, player_list = {[1] = {identifier = "steam_99", charid = 1}}, job_lock = false, job_list = {"horsetrainer"}, desc = "Bridle rope"              }, -- SPECIAL BRIDLES 
        {label = "Bridle rope"             , value = "action28",   command_enabled = true , command_label = "npc_tack28" , xp_lock = true, xp_required = 0, player_lock = true, player_list = {[1] = {identifier = "steam_99", charid = 1}}, job_lock = false, job_list = {"horsetrainer"}, desc = "Bridle rope"              }, -- SPECIAL BRIDLES
        {label = "Gun holster one"         , value = "action14",   command_enabled = true , command_label = "npc_tack14" , xp_lock = true, xp_required = 0, player_lock = true, player_list = {[1] = {identifier = "steam_99", charid = 1}}, job_lock = false, job_list = {"horsetrainer"}, desc = "Gun holster one"          }, -- SPECIAL GUN HOLSTERS
        {label = "Gun holster two"         , value = "action15",   command_enabled = true , command_label = "npc_tack15" , xp_lock = true, xp_required = 0, player_lock = true, player_list = {[1] = {identifier = "steam_99", charid = 1}}, job_lock = false, job_list = {"horsetrainer"}, desc = "Gun holster two"          }, -- SPECIAL GUN HOLSTERS
        {label = "Gun holster three"       , value = "action16",   command_enabled = true , command_label = "npc_tack16" , xp_lock = true, xp_required = 0, player_lock = true, player_list = {[1] = {identifier = "steam_99", charid = 1}}, job_lock = false, job_list = {"horsetrainer"}, desc = "Gun holster three"        }, -- SPECIAL GUN HOLSTERS
        {label = "Saddle bags on the front", value = "action17",   command_enabled = true , command_label = "npc_tack17" , xp_lock = true, xp_required = 0, player_lock = true, player_list = {[1] = {identifier = "steam_99", charid = 1}}, job_lock = false, job_list = {"horsetrainer"}, desc = "Saddle bags on the front" }, -- SPECIAL SADDLE BAGS 	
        {label = "Lantern Harness"         , value = "action29",   command_enabled = true , command_label = "npc_tack29" , xp_lock = true, xp_required = 0, player_lock = true, player_list = {[1] = {identifier = "steam_99", charid = 1}}, job_lock = false, job_list = {"horsetrainer"}, desc = "Lantern Harness"          }, -- SPECIAL LANTERN	
        {label = "Bag"                     , value = "action30",   command_enabled = true , command_label = "npc_tack30" , xp_lock = true, xp_required = 0, player_lock = true, player_list = {[1] = {identifier = "steam_99", charid = 1}}, job_lock = false, job_list = {"horsetrainer"}, desc = "Bag"                      }, -- SPECIAL BAG			
        {label = "BreastPlate V1"          , value = "action31",   command_enabled = true , command_label = "npc_tack31" , xp_lock = true, xp_required = 0, player_lock = true, player_list = {[1] = {identifier = "steam_99", charid = 1}}, job_lock = false, job_list = {"horsetrainer"}, desc = "BreastPlate V1"           }, -- SPECIAL BREASTPLATE			
        {label = "BreastPlate V2"          , value = "action32",   command_enabled = true , command_label = "npc_tack32" , xp_lock = true, xp_required = 0, player_lock = true, player_list = {[1] = {identifier = "steam_99", charid = 1}}, job_lock = false, job_list = {"horsetrainer"}, desc = "BreastPlate V2"           }, -- SPECIAL BREASTPLATE			
        {label = "BreastPlate V3"          , value = "action33",   command_enabled = true , command_label = "npc_tack33" , xp_lock = true, xp_required = 0, player_lock = true, player_list = {[1] = {identifier = "steam_99", charid = 1}}, job_lock = false, job_list = {"horsetrainer"}, desc = "BreastPlate V3"           }, -- SPECIAL BREASTPLATE			
        {label = "BreastPlate V4"          , value = "action34",   command_enabled = true , command_label = "npc_tack34" , xp_lock = true, xp_required = 0, player_lock = true, player_list = {[1] = {identifier = "steam_99", charid = 1}}, job_lock = false, job_list = {"horsetrainer"}, desc = "BreastPlate V4"           }, -- SPECIAL BREASTPLATE			
        {label = "BreastPlate V5"          , value = "action35",   command_enabled = true , command_label = "npc_tack35" , xp_lock = true, xp_required = 0, player_lock = true, player_list = {[1] = {identifier = "steam_99", charid = 1}}, job_lock = false, job_list = {"horsetrainer"}, desc = "BreastPlate V5"           }, -- SPECIAL BREASTPLATE			
        {label = "Black Bridle"            , value = "action36",   command_enabled = true , command_label = "npc_tack36" , xp_lock = true, xp_required = 0, player_lock = true, player_list = {[1] = {identifier = "steam_99", charid = 1}}, job_lock = false, job_list = {"horsetrainer"}, desc = "Black Bridle"             }, -- SPECIAL BLACK BRIDLE		
}

-- IF YOU WANT TO TRIGGER EVENTS FROM THE MENU WITH YOUR OWN SCRIPT/MENU/HUD ETC... HERE'S THE EVENT LIST :
 
-- TriggerEvent("SIREVLC_STABLES_NPC_TACK", "action18")  
-- TriggerEvent("SIREVLC_STABLES_NPC_TACK", "action19")  
-- TriggerEvent("SIREVLC_STABLES_NPC_TACK", "action20")  
-- TriggerEvent("SIREVLC_STABLES_NPC_TACK", "action21")  
-- TriggerEvent("SIREVLC_STABLES_NPC_TACK", "action07")  
-- TriggerEvent("SIREVLC_STABLES_NPC_TACK", "action08")  
-- TriggerEvent("SIREVLC_STABLES_NPC_TACK", "action09")  
-- TriggerEvent("SIREVLC_STABLES_NPC_TACK", "action10")  
-- TriggerEvent("SIREVLC_STABLES_NPC_TACK", "action11")  
-- TriggerEvent("SIREVLC_STABLES_NPC_TACK", "action12")  
-- TriggerEvent("SIREVLC_STABLES_NPC_TACK", "action13")  
-- TriggerEvent("SIREVLC_STABLES_NPC_TACK", "action04")  
-- TriggerEvent("SIREVLC_STABLES_NPC_TACK", "action05")  
-- TriggerEvent("SIREVLC_STABLES_NPC_TACK", "action22")  
-- TriggerEvent("SIREVLC_STABLES_NPC_TACK", "action23")  
-- TriggerEvent("SIREVLC_STABLES_NPC_TACK", "action24")  
-- TriggerEvent("SIREVLC_STABLES_NPC_TACK", "action25")  
-- TriggerEvent("SIREVLC_STABLES_NPC_TACK", "action26")  
-- TriggerEvent("SIREVLC_STABLES_NPC_TACK", "action27")  
-- TriggerEvent("SIREVLC_STABLES_NPC_TACK", "action01")  
-- TriggerEvent("SIREVLC_STABLES_NPC_TACK", "action02")  
-- TriggerEvent("SIREVLC_STABLES_NPC_TACK", "action03")  
-- TriggerEvent("SIREVLC_STABLES_NPC_TACK", "action06")  
-- TriggerEvent("SIREVLC_STABLES_NPC_TACK", "action28")  
-- TriggerEvent("SIREVLC_STABLES_NPC_TACK", "action14")  
-- TriggerEvent("SIREVLC_STABLES_NPC_TACK", "action15")  
-- TriggerEvent("SIREVLC_STABLES_NPC_TACK", "action16")  
-- TriggerEvent("SIREVLC_STABLES_NPC_TACK", "action17")  
-- TriggerEvent("SIREVLC_STABLES_NPC_TACK", "action29")  
-- TriggerEvent("SIREVLC_STABLES_NPC_TACK", "action30")  
-- TriggerEvent("SIREVLC_STABLES_NPC_TACK", "action31")  
-- TriggerEvent("SIREVLC_STABLES_NPC_TACK", "action32")  
-- TriggerEvent("SIREVLC_STABLES_NPC_TACK", "action33")  
-- TriggerEvent("SIREVLC_STABLES_NPC_TACK", "action34")  
-- TriggerEvent("SIREVLC_STABLES_NPC_TACK", "action35")  
-- TriggerEvent("SIREVLC_STABLES_NPC_TACK", "action36")  
 
 
-----------------
-- RIDING STYLE 
-----------------
--TriggerEvent("SIREVLC_STABLES_RIDING_NORMAL_POSITION")
--TriggerEvent("SIREVLC_STABLES_RIDING_SIDE_POSITION")
--TriggerEvent("SIREVLC_STABLES_PASSENGER_RIDING_NORMAL_POSITION")
--TriggerEvent("SIREVLC_STABLES_PASSENGER_RIDING_SIDE_POSITION")

----------------- 
-- OPEN MENUS -- 
-----------------
--TriggerEvent("SIREVLC_STABLES_HORSES_INTERACTIONS_MENU")
--TriggerEvent("SIREVLC_STABLES_TRICKS_MENU")
--TriggerEvent("SIREVLC_STABLES_SADDLE_HORSE_MENU")
--TriggerEvent("SIREVLC_STABLES_RIDING_STYLE")
--TriggerEvent("SIREVLC_STABLES_REMOVE_EQUIPMENT")
--TriggerEvent("SIREVLC_STABLES_ADD_EQUIPMENT")
 
-----------------
-- TRICKS --
-----------------
-- TriggerEvent("SIREVLC_STABLES_TRICKS", "GRAZING" )
-- TriggerEvent("SIREVLC_STABLES_TRICKS", "DRINKING" )
-- TriggerEvent("SIREVLC_STABLES_TRICKS", "SLEEPING"  )
-- TriggerEvent("SIREVLC_STABLES_TRICKS", "LAYING_DOWN")

-----------------
-- GENERAL ---
-----------------
-- TriggerEvent("SIREVLC_HORSES_SELL_MY_HORSE") -- START SELLING HORSE 
-- TriggerEvent("SIREVLC_HORSES_STOP_SELL_MY_HORSE") -- STOP SELLING HORSE 
-- TriggerEvent("SIREVLC_STABLES_SHOW_HORSE_INFOS") -- DISPLAY INFOS
-- TriggerEvent("SIREVLC_STABLES_TRICKS_STOP_ACTION") -- STOP ACTION (WILL NOT HAVE ANY EFFECT ON METABOLISM RELATED INTERACTIONS)

  
--MAIN HORSE MENU--
--HERE YOU CAN ENABLE OR DISABLE A CATEGORY, TRANSLATE THE TEXTS AND CHANGE THE IMAGES. TO DISABLE ONE CATEGORY JUST ADD -- IN FRONT OF THE LINE TO COMMENT IT OUT
 
Config.TextMenuMainTitle = "Horses Menu"
Config.ActionsHorsesMenu = {
		{label = 'Interactions',      			 			value = "action1",  desc = "Perform interactions with your horse tack"		    , image = 'items/generic_horse_equip_saddle.png'    },
		{label = 'Metabolism Interactions',         	    value = "action2",  desc = "Tricks for your horse"                    		    , image = 'items/cmpndm_turkoman.png'			    },
		{label = 'Riding Style' ,               			value = "action4",  desc = "Stop horse action"                        		    , image = 'items/emote_dance_confident_a.png'	    },
		{label = 'Add NPC special equipment',   			value = "action6",  desc = "Add NPC special equipment to your horse"  		    , image = 'items/generic_horse_equip_saddle.png'    },
		{label = 'Remove Horse tack',          			    value = "action5",  desc = "Remove Equipment from your horse"         		    , image = 'items/remove_saddle.png'				    },	
 		{label = 'Force Horse Inventory wheel',  			value = "action9",  desc = "Force Horse Inventory Wheel"              		    , image = 'items/generic_horse_equip_saddlebag.png' },
		{label = 'Stop Action',                  			value = "action3",  desc = "Stop the current action you're performing"          , image = 'items/upgrade_fsh_bait_lure_none.png'    },
		{label = 'Set Horse As Saddle Horse',    			value = "action7",  desc = "Set your current mounted horse as a saddle horse"   , image = 'items/satchel_nav_horse.png'			    },
		{label = 'Sell / transfer my horse',                value = "action10", desc = "Sell your horse"                          			, image = 'items/horse_purchase.png'			    },
		{label = 'Stop selling my horse',        			value = "action11", desc = "stop selling your horse"                  			, image = 'items/stop_horse_purchase.png'		    },
		{label = 'Display Infos',                			value = "action12", desc = "Display your current horse infos"         			, image = 'items/check_infos.png'				    },
		{label = 'Check horseshoe wear',                	value = "action13", desc = "Check horseshoe wear"         				    	, image = 'items/horse_shoe.png'				    },
}

 
--EQUIPMENT INTERACTIONS HORSE MENU--

Config.HORSE_INTERACTIONS_OPTIONS_TITLE = "Interactions"
Config.HORSE_INTERACTIONS_OPTIONS 		= {
		{label = "On Foot",  value = "action1",   desc = "Interactions on Foot",  image ='items/emote_dance_old_a.png'    	    },
		{label = "On Mount", value = "action2",   desc = "Interactions on Mount", image ='items/generic_horse_equip_saddle.png' },
}
 
-- MINOR INTERACTIONS 
Config.HORSE_INTERACTION_FOOT_TITLE = "On Foot"
Config.HORSE_INTERACTION_FOOT = {
		{label = "Secure Saddle",     		value = "SECURE_SADDLE",   	     xp_lock = true, xp_required = 0, player_lock = false, player_list = {[1] = {identifier = "steam_99", charid = 1}}, job_lock = false, job_list = {"horsetrainer"}, desc = "Secure Saddle",  					 image = 'items/secure_saddle.png'              },
 		{label = "Brush Horse#01",    		value = "BRUSHING_HORSE_1",    	 xp_lock = true, xp_required = 0, player_lock = false, player_list = {[1] = {identifier = "steam_99", charid = 1}}, job_lock = false, job_list = {"horsetrainer"}, desc = "Brush Horse#01", 					 image = 'items/brush_horse.png'                },
		{label = "Brush Horse#02",    		value = "BRUSHING_HORSE_2",    	 xp_lock = true, xp_required = 0, player_lock = false, player_list = {[1] = {identifier = "steam_99", charid = 1}}, job_lock = false, job_list = {"horsetrainer"}, desc = "Brush Horse#02", 					 image = 'items/brush_horse.png'                },
		{label = "Brush Horse#03",    		value = "BRUSHING_HORSE_3",    	 xp_lock = true, xp_required = 0, player_lock = false, player_list = {[1] = {identifier = "steam_99", charid = 1}}, job_lock = false, job_list = {"horsetrainer"}, desc = "Brush Horse#03", 					 image = 'items/brush_horse.png'                },
 	    {label = "Piss",              		value = "PISSING" ,			 	 xp_lock = true, xp_required = 0, player_lock = false, player_list = {[1] = {identifier = "steam_99", charid = 1}}, job_lock = false, job_list = {"horsetrainer"}, desc = "Make your horse relieve itself",    	 image = 'items/sirevlc_horse_piss.png'		    },
	    {label = "Wallow",       			value = "WALLOW",  	     		 xp_lock = true, xp_required = 0, player_lock = false, player_list = {[1] = {identifier = "steam_99", charid = 1}}, job_lock = false, job_list = {"horsetrainer"}, desc = "Wallow",                       		 image = 'items/horse_wallow_icon.png'		    },
     	{label = "Rear Up",            		value = "REAR_UP",  			 xp_lock = true, xp_required = 0, player_lock = false, player_list = {[1] = {identifier = "steam_99", charid = 1}}, job_lock = false, job_list = {"horsetrainer"}, desc = "Rear up !",                           image = 'items/horse_rear_up.png'	 		 	},
 	    {label = "Force Fall",         		value = "FORCE_FALL",  	     	 xp_lock = true, xp_required = 0, player_lock = false, player_list = {[1] = {identifier = "steam_99", charid = 1}}, job_lock = false, job_list = {"horsetrainer"}, desc = "This will make your horse fall",      image = 'items/cmpndm_appaloosa.png'  		 	},
	    {label = "Follow me horse",    		value = "FOLLOW_ME_HORSE",  	 xp_lock = true, xp_required = 0, player_lock = false, player_list = {[1] = {identifier = "steam_99", charid = 1}}, job_lock = false, job_list = {"horsetrainer"}, desc = "Follow me horse",    				 image = 'items/emote_action_follow_me.png'	    },
 	    {label = "Stop Following me horse", value = "STOP_FOLLOW_ME_HORSE",  xp_lock = true, xp_required = 0, player_lock = false, player_list = {[1] = {identifier = "steam_99", charid = 1}}, job_lock = false, job_list = {"horsetrainer"}, desc = "Follow me horse",    				 image = 'items/emote_action_follow_me.png'	    },
}
 
Config.HORSE_INTERACTION_MOUNT_TITLE = "On Mount"
Config.HORSE_INTERACTION_MOUNT = {
		{label = "Point Right",        		value = "POINT_RIGHT",   	 	 xp_lock = true, xp_required = 0, player_lock = false, player_list = {[1] = {identifier = "steam_99", charid = 1}}, job_lock = false, job_list = {"horsetrainer"}, desc = "Point Right",        				 image = 'items/emote_action_point_left.png'     },
		{label = "Point Left",         		value = "POINT_LEFT",   		 xp_lock = true, xp_required = 0, player_lock = false, player_list = {[1] = {identifier = "steam_99", charid = 1}}, job_lock = false, job_list = {"horsetrainer"}, desc = "Point Left",         				 image = 'items/emote_action_point.png'          },
		{label = "Check Saddle",  	   		value = "CHECK_SADDLE",       	 xp_lock = true, xp_required = 0, player_lock = false, player_list = {[1] = {identifier = "steam_99", charid = 1}}, job_lock = false, job_list = {"horsetrainer"}, desc = "Check Saddle Back",  				 image = 'items/generic_horse_equip_saddle.png'  },
 		{label = "Check Stirrups",     		value = "CHECK_STIRRUPS", 	 	 xp_lock = true, xp_required = 0, player_lock = false, player_list = {[1] = {identifier = "steam_99", charid = 1}}, job_lock = false, job_list = {"horsetrainer"}, desc = "Check Stirrups",     				 image = 'items/generic_horse_equip_stirrup.png' },
		{label = "Adjust Saddle",      		value = "ADJUST_SADDLE",   	 	 xp_lock = true, xp_required = 0, player_lock = false, player_list = {[1] = {identifier = "steam_99", charid = 1}}, job_lock = false, job_list = {"horsetrainer"}, desc = "Adjust Seat#1",      				 image = 'items/adjust_seat.png'                 },
		{label = "Pet Horse #1",       		value = "PET_HORSE_1",  		 xp_lock = true, xp_required = 0, player_lock = false, player_list = {[1] = {identifier = "steam_99", charid = 1}}, job_lock = false, job_list = {"horsetrainer"}, desc = "Pet Horse #1",       				 image = 'items/pet_horse.png'                   },
		{label = "Pet Horse #2",       		value = "PET_HORSE_2",  		 xp_lock = true, xp_required = 0, player_lock = false, player_list = {[1] = {identifier = "steam_99", charid = 1}}, job_lock = false, job_list = {"horsetrainer"}, desc = "Pet Horse #2",       				 image = 'items/pet_horse.png'                   },
		{label = "Pet Horse #3",       		value = "PET_HORSE_3",  		 xp_lock = true, xp_required = 0, player_lock = false, player_list = {[1] = {identifier = "steam_99", charid = 1}}, job_lock = false, job_list = {"horsetrainer"}, desc = "Pet Horse #3",       				 image = 'items/pet_horse.png'                   },
		{label = "Check Balance",      		value = "CHECK_BALANCE",  	 	 xp_lock = true, xp_required = 0, player_lock = false, player_list = {[1] = {identifier = "steam_99", charid = 1}}, job_lock = false, job_list = {"horsetrainer"}, desc = "Check Balance",      				 image = 'items/emote_dance_drunk_b.png'         },
 	    {label = "Lean on saddle",     		value = "LEAN_ON_SADDLE",  	 	 xp_lock = true, xp_required = 0, player_lock = false, player_list = {[1] = {identifier = "steam_99", charid = 1}}, job_lock = false, job_list = {"horsetrainer"}, desc = "Lean on saddle",     				 image = 'items/generic_horse_equip_saddle.png' },
 	    {label = "Go Wild",     			value = "GO_WILD",  	 		 xp_lock = true, xp_required = 0, player_lock = false, player_list = {[1] = {identifier = "steam_99", charid = 1}}, job_lock = false, job_list = {"horsetrainer"}, desc = "Lean on saddle",     				 image = 'items/generic_horse_equip_saddle.png' },
 
} 
 
-- TriggerEvent("SIREVLC_STABLES_INTERACTIONS",""SECURE_SADDLE"   )  
-- TriggerEvent("SIREVLC_STABLES_INTERACTIONS",""BRUSHING_HORSE_1")
-- TriggerEvent("SIREVLC_STABLES_INTERACTIONS",""BRUSHING_HORSE_2")
-- TriggerEvent("SIREVLC_STABLES_INTERACTIONS",""BRUSHING_HORSE_3")
-- TriggerEvent("SIREVLC_STABLES_INTERACTIONS",""BRUSHING_HORSE_4")
-- TriggerEvent("SIREVLC_STABLES_INTERACTIONS",""PISSING"         )
-- TriggerEvent("SIREVLC_STABLES_INTERACTIONS","WALLOW"    		  )
 
-- TriggerEvent("SIREVLC_STABLES_INTERACTIONS","POINT_RIGHT"   	)   
-- TriggerEvent("SIREVLC_STABLES_INTERACTIONS","POINT_LEFT"   	)   
-- TriggerEvent("SIREVLC_STABLES_INTERACTIONS","CHECK_SADDLE"   )   
-- TriggerEvent("SIREVLC_STABLES_INTERACTIONS","CHECK_STIRRUPS" )   
-- TriggerEvent("SIREVLC_STABLES_INTERACTIONS","ADJUST_SADDLE"  )   
-- TriggerEvent("SIREVLC_STABLES_INTERACTIONS","PET_HORSE_1"  	)   
-- TriggerEvent("SIREVLC_STABLES_INTERACTIONS","PET_HORSE_2"  	)   
-- TriggerEvent("SIREVLC_STABLES_INTERACTIONS","PET_HORSE_3"  	)   
-- TriggerEvent("SIREVLC_STABLES_INTERACTIONS","CHECK_BALANCE"  )   
-- TriggerEvent("SIREVLC_STABLES_INTERACTIONS","FOLLOW_ME_HORSE")   
-- TriggerEvent("SIREVLC_STABLES_INTERACTIONS","LEAN_ON_SADDLE" )   
-- TriggerEvent("SIREVLC_STABLES_INTERACTIONS","REAR_UP"  		)   
-- TriggerEvent("SIREVLC_STABLES_INTERACTIONS","FORCE_FALL"  	)   
-- TriggerEvent("SIREVLC_STABLES_INTERACTIONS","GO_WILD")   
   
 
-- STANDARD INTERACTIONS 
Config.MENU_METABOLISM_INTERACTIONS_TITLE  = "Tricks"
Config.MENU_METABOLISM_INTERACTIONS = {
	{label = "Graze",               value = "GRAZING",		    	 xp_lock = true, xp_required = 0, player_lock = false, player_list = {[1] = {identifier = "steam_99", charid = 1}}, job_lock = false, job_list = {"horsetrainer"}, desc = "Make your horse graze haypiles !",  image = 'items/horse_feed.png'        		 	},
	{label = "Drink",               value = "DRINKING",		    	 xp_lock = true, xp_required = 0, player_lock = false, player_list = {[1] = {identifier = "steam_99", charid = 1}}, job_lock = false, job_list = {"horsetrainer"}, desc = "Make your horse drink",             image = 'items/horse_drink5.png'      		 	},
  	{label = "Sleep",               value = "SLEEPING",  		     xp_lock = true, xp_required = 0, player_lock = false, player_list = {[1] = {identifier = "steam_99", charid = 1}}, job_lock = false, job_list = {"horsetrainer"}, desc = "Time to rest for your noble steed", image = 'items/horse_sleep.png'       		 	},
	{label = "Lay Down",            value = "LAYING_DOWN",  		 xp_lock = true, xp_required = 0, player_lock = false, player_list = {[1] = {identifier = "steam_99", charid = 1}}, job_lock = false, job_list = {"horsetrainer"}, desc = "Make your horse lay down",          image = 'items/horse_lay.png'		 		 	},
    {label = "Clean Shoes",   		value = "SHOE_CLEANING", 	     xp_lock = true, xp_required = 0, player_lock = false, player_list = {[1] = {identifier = "steam_99", charid = 1}}, job_lock = false, job_list = {"horsetrainer"}, desc = "Clean the shoes of your horse",     image = 'items/horse_shoe.png'					},
}
 
	
--RIDING STYLE MENU 
Config.HORSES_INTERACTION_RIDING_STYLE_TITLE  = "Riding Style" 
Config.HORSES_INTERACTION_RIDING_STYLE = {
        {label = "Normal Style",             value = "action1", desc = "Ride your horse normal style",   image ='items/ridenormal.png'},
		{label = "Side Saddle",              value = "action2", desc = "Ride your horse side saddled",   image ='items/emote_dance_confident_a.png'},
		{label = "Side Saddle Passenger",    value = "action3", desc = "Ride side saddle for passenger", image ='items/emote_dance_confident_a.png'},
		{label = "Normal Style Passenger",   value = "action4", desc = "Ride your horse normal style",   image ='items/ridenormal.png'},
}
 
--REMOVE EQUIPMENT MENU
Config.TextMenuRemoveEquipmentTitle1 = "Remove"
Config.MenuRemoveEquipment = {
	{label = "Saddle",          value = "action2",   desc = "Saddle",         image ='items/generic_horse_equip_saddle.png'}, 
	{label = "Saddlebags",      value = "action3",   desc = "Saddlebags",     image ='items/generic_horse_equip_saddlebag.png'}, 
	{label = "Stirrups",        value = "action4",   desc = "Stirrups",       image ='items/generic_horse_equip_stirrup.png'},
	{label = "Blankets",        value = "action5",   desc = "Blankets",       image ='items/generic_horse_equip_blanket.png'}, 
	{label = "Horns",           value = "action6",   desc = "Horns",          image ='items/generic_horse_equip_horn.png'}, 
	{label = "Bedrolls",        value = "action7",   desc = "Bedrolls",       image ='items/generic_horse_equip_bedroll.png'}, 
	{label = "Bridles",         value = "action8",   desc = "Bridles",        image ='items/horse_bridles.png'}, 
	{label = "Shoes",           value = "action9",   desc = "Shoes",          image ='items/horse_shoe.png'},  
	{label = "Extras",          value = "action10",  desc = "Extras",         image ='items/generic_horse_equip_lantern.png'}, 
	{label = "Masks",           value = "action11",  desc = "Masks",          image ='items/generic_horse_equip_mask.png'}, 
	{label = "Holsters",        value = "action12",  desc = "Holsters",       image ='items/generic_horse_equip_holster.png'}, 
}
 
--RESET EQUIPMENT MENU
Config.MenuResetBasicEquipmentTitle1 = "Reset"
Config.MenuResetBasicEquipment = {
		{label = "Saddle",          value = "action2",   desc = "Saddle",         image ='items/generic_horse_equip_saddle.png'}, 
		{label = "Saddlebags",      value = "action3",   desc = "Saddlebags",     image ='items/generic_horse_equip_saddlebag.png'}, 
		{label = "Stirrups",        value = "action4",   desc = "Stirrups",       image ='items/generic_horse_equip_stirrup.png'},
		{label = "Blankets",        value = "action5",   desc = "Blankets",       image ='items/generic_horse_equip_blanket.png'}, 
		{label = "Horns",           value = "action6",   desc = "Horns",          image ='items/generic_horse_equip_horn.png'}, 
		{label = "Bedrolls",        value = "action7",   desc = "Bedrolls",       image ='items/generic_horse_equip_bedroll.png'}, 
		{label = "Bridles",         value = "action8",   desc = "Bridles",        image ='items/horse_bridles.png'}, 
		{label = "Shoes",           value = "action9",   desc = "Shoes",          image ='items/horse_shoe.png'},  
		{label = "Extras",          value = "action10",  desc = "Extras",         image ='items/generic_horse_equip_lantern.png'}, 
		{label = "Masks",           value = "action11",  desc = "Masks",          image ='items/generic_horse_equip_mask.png'}, 
		{label = "Holsters",        value = "action12",  desc = "Holsters",       image ='items/generic_horse_equip_holster.png'}, 	
}
 
Config.TextMenuChooseEquipmentTitle = "Choose Tack"
Config.MenuChooseEquipment = {
		{label = "Basic Tack",             value = "action1",  desc = "Remove / Set Basic Tack",              image ='items/generic_horse_equip_saddle.png'},
	--	{label = "Special NPC Tack",       value = "action2",  desc = "Only Remove Special NPC Tack",         image ='items/generic_horse_equip_saddlebag.png'}, 
}
 
 
-------------------------------------------
           --NOTIFICATIONS--
------------------------------------------- 
Config.EnableNotifications   							 = true
Config.HORSES_INTERACTIONS_TXT_NOTIF_HORSE				 = "Horse"
Config.HORSES_INTERACTIONS_TXT_NOTIF_FOLLOW              = "Nearby horses are following you"
Config.HORSES_INTERACTIONS_TXT_NOTIF_STOP_FOLLOW         = "Nearby Horses stopped following you"
Config.HORSES_INTERACTIONS_TXT_NOTIF_ON_HORSE            = "You must be on your horse to perform this action"
Config.HORSES_INTERACTIONS_TXT_NOTIF_GET_CLOSER          = "Get closer to your horse"
Config.HORSES_INTERACTIONS_TXT_NOTIF_SADDLE_SECURED      = "Saddle secured !"
Config.HORSES_INTERACTIONS_TXT_NOTIF_ON_FOOT             = "You must be on foot to perform this action"
Config.HORSES_INTERACTIONS_TXT_NOTIF_SADDLE_HORSE        = "You have set this horse as your saddle horse !"
Config.HORSES_INTERACTIONS_TXT_NOTIF_NOT_ENOUGH_XP       = "Your horse doesnt have enough xp !"
Config.HORSES_INTERACTIONS_TXT_NOTIF_NO_ROLE     		 = "You don't have the right job for this"
Config.HORSES_INTERACTIONS_TXT_NOTIF_NOT_ALLOWED_PLAYER  = "You're not authorized to do this"
Config.HORSES_INTERACTIONS_TXT_NOTIF_CALL_HORSE_FIRST    = "You must call your horse first !"
Config.HORSES_INTERACTIONS_TXT_NOTIF_INJURED             = "Your horse is injured"
Config.HORSES_INTERACTIONS_TXT_NOTIF_REQUIRED_XP         = "Required XP: "

Config.HORSES_INTERACTIONS_TXT_NOTIF_GOING_DRINK    	 = "Your horse is drinking"
Config.HORSES_INTERACTIONS_TXT_NOTIF_GOING_GRAZE    	 = "Your horse is grazing" 
Config.HORSES_INTERACTIONS_TXT_NOTIF_NOTHING_GRAZE  	 = "No hay to graze here" 
Config.HORSES_INTERACTIONS_TXT_NOTIF_NOTHING_DRINK  	 = "Nothing to drink here" 

------------------------------------------
            --GAMEPLAY--
------------------------------------------
 
--CLEANING FEET BONUSES
--Base Stats are from 0 to 10
Config.CleaningFeetStatBonuses       = false
Config.CleaningFeetBonusHealth       = 2 --Health
Config.CleaningFeetBonusStamina      = 2 --Stamina
Config.CleaningFeetBonusCourage      = 2 --Courage
Config.CleaningFeetBonusAgility      = 2 --Agility
Config.CleaningFeetBonusSpeed        = 2 --Speed
Config.CleaningFeetBonusAcceleration = 2 --Acceleration
 
 
Config.GrazeObjects = {
"p_haypile01x",
"p_haypile02x",
"p_haypile03x",
"p_haypile04x",
"p_haybale01x",
"p_haybale03x",
"p_haybale04x",
"p_haybale04x",
"p_haybalecover01x",
"p_haybalecover02x",
"p_haybalecover03x",
"p_haybalestack01x",
"p_haybalestack02x",
"p_haybalestack03x",
"s_haybale01x",
"p_haybale01x_shad",
"p_haybalestack03x_shad",
}
 
Config.DrinkObjects = {
"p_watertrough01x",
"p_watertrough01x_new",
"p_watertrough02x",
"p_watertrough03x",
"p_watertroughsml01x",
}
 
 