Config = Config or {}
-------------------------------------
			-- MENUS --
------------------------------------- 
-- IMAGES ARE TAKEN FROM REDEMRP_MENU_BASE/HTML/ITEMS
Config.MENU_MAIN_TITLE  = "<p><span style='color:gold;'>Stable</span>" 
Config.MENU_MAIN 		= {
 	{label = "Horses",     value = "HORSES",     desc = "Access the horse menu",    image = 'items/cmpndm_ampaint.png'     },
 	{label = "Wagons",     value = "WAGONS",     desc = "Access the wagons menu",   image = 'items/sirevlc_wagon.png'      },
 	{label = "Breeding",   value = "BREEDING",   desc = "Access the breeding menu", image = 'items/horse_breeding_icon.png'},
}
 
Config.MENU_MAIN_HORSES_TITLE 	= "Horses"	
Config.MENU_MAIN_HORSES 		= {
     {label = "Owned Horses",    	  		  value = "display_owned", 		 	   desc = "Check owned horses",  								     image = 'items/cmpndm_ampaint.png'},
     {label = "Purchase Horse",       		  value = "purchase_horse",            desc = "Check all horses that can be purchased from the stables", image = 'items/horse_purchase.png'},
}	
 
 Config.MENU_HORSES_OWNED_MANAGE 		= {
{label = "Set as main horse",             	  value = "set_main_horse",     	 	desc = "Set this horse as your main horse",     				 image = 'items/animal_horse.png'					},
{label = "Heal horse",		  				  value = "heal_horse",       		 	desc = "Heal this horse for $20 dollars",       				 image = 'items/kit_role_naturalist_sample_kit.png'	},		
{label = "Horse barber",        		      value = "horse_barber",  		     	desc = "Customize your horse mane, tail and mustache",      	 image = 'items/horse_barber_icon.png'			    },
{label = "Purchase Horse Tack",        		  value = "purchase_horse_tack",     	desc = "Display the available horse tack",      				 image = 'items/generic_horse_equip_saddle.png'		},
{label = "Sell Horse Tack",  			      value = "sell_horse_tack",    	 	desc = "Sell horse tack",  					  					 image = 'items/remove_saddle.png'					},		
{label = "Set Horse Tack",      			  value = "set_horse_tack", 	     	desc = "Set Horse Tack", 					  					 image = 'items/generic_horse_equip_saddle.png'	    },
{label = "Sell horse",           			  value = "sell_horse",        		 	desc = "Sell your horse to the current stables",   				 image = 'items/money_moneystack.png'				},
{label = "Transfer horse",           		  value = "transfer_horse",        		desc = "Transfer your horse to another player",   				 image = 'items/purchase_horse.png'					},
{label = "Delete horse",           		      value = "delete_horse",        		desc = "Delete your horse",   									 image = 'items/money_moneystack.png'				},
{label = "Rename your horse",        		  value = "rename_horse",      		 	desc = "Rename your horse here",     	 		  				 image = 'items/document_horse_deed.png'			},
{label = "Set your custom title",        	  value = "set_custom_title",      	 	desc = "set your custom title here",     	 		  			 image = 'items/document_horse_deed.png'			},
{label = "Spawn Horse from the stables",      value = "spawn_horse",       		 	desc = "Spawn your horse from the stables",     				 image = 'items/animal_horse.png'					},
{label = "Geld / Spay",     			 	  value = "neuter_horse",       	 	desc = "Geld your stallion or spay your mare",     				 image = 'items/generic_barber_scissors.png'		},
{label = "Change Horse Personality",     	  value = "change_horse_personality",   desc = "Change your horse personality",     					 image = 'items/horse_personality_change_icon.png'	},
{label = "Check horseshoe wear",     	 	  value = "check_horseshoe",  		    desc = "Check the current horseshoewear",     					 image = 'items/generic_horse_mod.png'	},
}	
 
Config.TACK_CATEGORIES_MENU_CUSTOMIZATION_TITLE = "Colors"
 
-- YOU CAN CHANGE THE LABEL AND DESCRIPTION

Config.MENU_HORSES_CUSTOMIZATION_TITLE  = "Customizable Elements" 
Config.MENU_HORSES_CUSTOMIZATION 		= {
 {label = "Confirm",     value = "action11",  desc = "Customize this element", image = 'items/menu_icon_tick.png' },
 {label = "Gender", 	 value = "action01",  desc = "Customize this element", image = 'items/horse_gender_icon.png' },
 {label = "Eyes", 	     value = "action02",  desc = "Customize this element", image = 'items/horse_eyes_icon.png' },
 {label = "Head", 	     value = "action03",  desc = "Customize this element", image = 'items/horse_head_icon.png' },
 {label = "Coat", 	     value = "action04",  desc = "Customize this element", image = 'items/horse_coat_icon.png' },
 {label = "Mane",        value = "action05",  desc = "Customize this element", image = 'items/generic_horse_equip_mane.png' },
 {label = "Tail",   	 value = "action06",  desc = "Customize this element", image = 'items/generic_horse_equip_tail.png' },
 {label = "Feathers",    value = "action07",  desc = "Customize this element", image = 'items/horse_feathers_icon.png' },
 {label = "Mustache",    value = "action08",  desc = "Customize this element", image = 'items/horse_mustache.png' },
 {label = "Scale",       value = "action09",  desc = "Customize this element", image = 'items/horse_scale_icon.png' },
 {label = "Eyelashes",   value = "action10",  desc = "Customize this element", image = 'items/horse_eyelashes_icon.png' },
 -- V4.0 ADDITION :
 {label = "Gene selection", value = "action12",  desc = "Select your horse gene", image = 'items/horse_dna.png' },
 --
}
 
Config.MENU_HORSES_CUSTOMIZATION_RESTRICTED		= {
[1]   = {label = "Gender", 	    value = "action01",  desc = "Customize this element" },
[2]   = {label = "Confirm",     value = "action11",  desc = "Confirm your choice" },
}

-- V4.0 ADDITION :  
-- REMEMBER YOU CAN'T ADD YOUR OWN GENE, IT MUST BE ONE FROM BELOW TO BE RECOGNIZED BY THE BREEDING ENGINE
-- YOU CAN CHANGE THE label
 
Config.TXT_PATTERN_SOLID 		   = "SOLID"
Config.TXT_PATTERN_ZEBRA           = "Zebra"      
Config.TXT_PATTERN_LEOPARD         = "Leopard"    
Config.TXT_PATTERN_BLANKET         = "Blanket"    
Config.TXT_PATTERN_SNOWFLAKE       = "Snowflake"  
Config.TXT_PATTERN_FEW_SPOTTED     = "Few spotted"
Config.TXT_PATTERN_SABINO          = "Sabino"     
Config.TXT_PATTERN_TOBIANO         = "Tobiano"    
Config.TXT_PATTERN_OVERO           = "Overo"      
Config.TXT_PATTERN_TOVERO          = "Tovero"     
Config.TXT_PATTERN_SPLASHED        = "Splashed"   
Config.TXT_PATTERN_RABICANO        = "Rabicano"   
Config.TXT_PATTERN_BRINDLE         = "Brindle"    
Config.TXT_PATTERN_DUN             = "Dun"        
Config.TXT_PATTERN_ROAN            = "Roan"       
 
Config.MENU_HORSES_CUSTOMIZATION_GENE_PATTERN_SELECT_TITLE  = "Pattern Selection" 
Config.MENU_HORSES_CUSTOMIZATION_GENE_PATTERN_SELECT 		= {
 {label = "SOLID" 			 , value = "SOLID", pattern = "PATTERN_SOLID"      },
 {label = "ZEBRA" 			 , value = "ZB"	,   pattern = "PATTERN_ZEBRA"      },
 {label = "LEOPARD" 		 , value = "LP"	,   pattern = "PATTERN_LEOPARD"    },
 {label = "BLANKET" 		 , value = "BK"	,   pattern = "PATTERN_BLANKET"    },
 {label = "SNOWFLAKE" 		 , value = "SF"	,   pattern = "PATTERN_SNOWFLAKE"  },
 {label = "FEW SPOTTED" 	 , value = "FSP",   pattern = "PATTERN_FEW_SPOTTED"},
 {label = "SABINO" 			 , value = "SB"	,   pattern = "PATTERN_SABINO"     },
 {label = "TOBIANO" 		 , value = "TO"	,   pattern = "PATTERN_TOBIANO"    },
 {label = "OVERO" 			 , value = "O"	,   pattern = "PATTERN_OVERO"      },
 {label = "TOVERO" 			 , value = "TOV",   pattern = "PATTERN_TOVERO"     },
 {label = "SPLASHED WHITE" 	 , value = "SW"	,   pattern = "PATTERN_SPLASHED"   }, 
 {label = "RABICANO" 		 , value = "RB"	,   pattern = "PATTERN_RABICANO"   },
 {label = "BRINDLE" 		 , value = "BR"	,   pattern = "PATTERN_BRINDLE"    },
 {label = "DUN" 			 , value = "D"	,   pattern = "PATTERN_DUN"        },
 {label = "ROAN" 			 , value = "RN"	,   pattern = "PATTERN_ROAN"       },
}
 
Config.MENU_HORSES_CUSTOMIZATION_GENE_SOLID_SELECT_TITLE  = "Solid" 
Config.MENU_HORSES_CUSTOMIZATION_GENE_SOLID_SELECT 		 = {
 {label = "RED" 					, value = "R" 	     , color = "R" 	      ,pattern = "PATTERN_SOLID" },
 {label = "BLACK" 					, value = "BL" 	     , color = "BL" 	  ,pattern = "PATTERN_SOLID" },
 {label = "BAY" 					, value = "B"        , color = "B"        ,pattern = "PATTERN_SOLID" },
 {label = "FLAXEN CHESTNUT" 		, value = "R_FLX"    , color = "R_FLX"    ,pattern = "PATTERN_SOLID" },
 {label = "PANGARE CHESTNUT" 		, value = "R_P" 	 , color = "R_P" 	  ,pattern = "PATTERN_SOLID" },
 {label = "PANGARE BAY" 			, value = "B_P"      , color = "B_P"      ,pattern = "PATTERN_SOLID" },
 {label = "PALOMINO" 				, value = "R_CR"     , color = "R_CR"     ,pattern = "PATTERN_SOLID" },
 {label = "SMOKEY BLACK" 			, value = "BL_CR"    , color = "BL_CR"    ,pattern = "PATTERN_SOLID" },
 {label = "BUCKSKIN" 				, value = "B_CR"     , color = "B_CR"     ,pattern = "PATTERN_SOLID" },
 {label = "CREMELLO" 				, value = "R_CR2"    , color = "R_CR2"    ,pattern = "PATTERN_SOLID" },
 {label = "SMOKEY CREAM" 			, value = "BL_CR2"   , color = "BL_CR2"   ,pattern = "PATTERN_SOLID" },
 {label = "PERLINO" 				, value = "B_CR2"    , color = "B_CR2"    ,pattern = "PATTERN_SOLID" },
 {label = "GOLD CHAMPAGNE" 			, value = "R_CH"     , color = "R_CH"     ,pattern = "PATTERN_SOLID" },
 {label = "CLASSIC CHAMPAGNE"       , value = "BL_CH"	 , color = "BL_CH"	  ,pattern = "PATTERN_SOLID" },
 {label = "AMBER CHAMPAGNE"         , value = "B_CH"	 , color = "B_CH"	  ,pattern = "PATTERN_SOLID" },
 {label = "GOLD CREAM CHAMPAGNE" 	, value = "R_CR_CH"  , color = "R_CR_CH"  ,pattern = "PATTERN_SOLID" },
 {label = "CLASSIC CREAM CHAMPAGNE" , value = "BL_CR_CH" , color = "BL_CR_CH" ,pattern = "PATTERN_SOLID" },
 {label = "AMBER CREAM CHAMPAGNE"   , value = "B_CR_CH"  , color = "B_CR_CH"  ,pattern = "PATTERN_SOLID" },
 {label = "GREY" 					, value = "BL_G"     , color = "BL_G"     ,pattern = "PATTERN_SOLID" },
 {label = "ROSE GREY" 				, value = "R_G"      , color = "R_G"      ,pattern = "PATTERN_SOLID" },
 {label = "DOMINANT WHITE" 			, value = "BL_DW"    , color = "BL_DW"    ,pattern = "PATTERN_SOLID" },
 {label = "RED MUSHROOM"			, value = "R_M"      , color = "R_M"      ,pattern = "PATTERN_SOLID" },
 {label = "BAY MUSHROOM"			, value = "B_M"      , color = "B_M"      ,pattern = "PATTERN_SOLID" },
 {label = "SILVER BLACK" 			, value = "BL_Z"     , color = "BL_Z"     ,pattern = "PATTERN_SOLID" },
 {label = "SILVER BAY"				, value = "B_Z"      , color = "B_Z"      ,pattern = "PATTERN_SOLID" },
 {label = "SILVER SMOKEY BLACK"		, value = "BL_CR_Z"  , color = "BL_CR_Z"  ,pattern = "PATTERN_SOLID" },
 {label = "SILVER BUCKSKIN"         , value = "B_CR_Z"   , color = "B_CR_Z"   ,pattern = "PATTERN_SOLID" },
}
 
Config.MENU_HORSES_CUSTOMIZATION_GENE_ZEBRA_SELECT_TITLE  = "Zebra" 
Config.MENU_HORSES_CUSTOMIZATION_GENE_ZEBRA_SELECT 		= {
{label = "RED ZORSE",  				 		value = "R_ZB",  		color = "R" 	  , pattern = "PATTERN_ZEBRA", desc_center = "R_ZB"       },
{label = "BLACK ZORSE",  			 		value = "BL_ZB",  		color = "BL" 	  , pattern = "PATTERN_ZEBRA", desc_center = "BL_ZB"      },
{label = "BAY ZORSE",  				 		value = "B_ZB",  		color = "B"       , pattern = "PATTERN_ZEBRA", desc_center = "B_ZB"       },
{label = "FLAXEN CHESTNUT ZORSE",    		value = "R_FLX_ZB",  	color = "R_FLX"   , pattern = "PATTERN_ZEBRA", desc_center = "R_FLX_ZB"   },
{label = "PANGARE CHESTNUT ZORSE",   		value = "R_P_ZB",  		color = "R_P" 	  , pattern = "PATTERN_ZEBRA", desc_center = "R_P_ZB"     },
{label = "PANGARE BAY ZORSE", 		 		value = "B_P_ZB",  		color = "B_P"     , pattern = "PATTERN_ZEBRA", desc_center = "B_P_ZB"     },
{label = "PALOMINO ZORSE",  		 		value = "R_CR_ZB",  	color = "R_CR"    , pattern = "PATTERN_ZEBRA", desc_center = "R_CR_ZB"    },
{label = "SMOKEY BLACK ZORSE",  	 		value = "BL_CR_ZB",  	color = "BL_CR"   , pattern = "PATTERN_ZEBRA", desc_center = "BL_CR_ZB"   },
{label = "BUCKSKIN ZORSE",  		 		value = "B_CR_ZB",  	color = "B_CR"    , pattern = "PATTERN_ZEBRA", desc_center = "B_CR_ZB"    },
{label = "CREMELLO ZORSE",  		 		value = "R_CR2_ZB",  	color = "R_CR2"   , pattern = "PATTERN_ZEBRA", desc_center = "R_CR2_ZB"   },
{label = "SMOKEY CREAM ZORSE",  	 		value = "BL_CR2_ZB",  	color = "BL_CR2"  , pattern = "PATTERN_ZEBRA", desc_center = "BL_CR2_ZB"  },
{label = "PERLINO ZORSE",  			 		value = "B_CR2_ZB",  	color = "B_CR2"   , pattern = "PATTERN_ZEBRA", desc_center = "B_CR2_ZB"   },
{label = "GOLD CHAMPAGNE ZORSE",  	 		value = "R_CH_ZB",  	color = "R_CH"    , pattern = "PATTERN_ZEBRA", desc_center = "R_CH_ZB"    },
{label = "CLASSIC CHAMPAGNE ZORSE",  		value = "BL_CH_ZB",  	color = "BL_CH"	  , pattern = "PATTERN_ZEBRA", desc_center = "BL_CH_ZB"   },
{label = "AMBER CHAMPAGNE ZORSE",  	 		value = "B_CH_ZB",  	color = "B_CH"	  , pattern = "PATTERN_ZEBRA", desc_center = "B_CH_ZB"    },
{label = "GOLD CREAM CHAMPAGNE ZORSE",  	value = "R_CR_CH_ZB",   color = "R_CR_CH" , pattern = "PATTERN_ZEBRA", desc_center = "R_CR_CH_ZB" },
{label = "CLASSIC CREAM CHAMPAGNE ZORSE",  	value = "BL_CR_CH_ZB",  color = "BL_CR_CH", pattern = "PATTERN_ZEBRA", desc_center = "BL_CR_CH_ZB"},
{label = "AMBER CREAM CHAMPAGNE ZORSE",  	value = "B_CR_CH_ZB",   color = "B_CR_CH" , pattern = "PATTERN_ZEBRA", desc_center = "B_CR_CH_ZB" },
{label = "GREY ZORSE",  					value = "BL_G_ZB",  	color = "BL_G"    , pattern = "PATTERN_ZEBRA", desc_center = "BL_G_ZB"    },
{label = "ROSE GREY ZORSE",  				value = "R_G_ZB",  		color = "R_G"     , pattern = "PATTERN_ZEBRA", desc_center = "R_G_ZB"     },
{label = "DOMINANT WHITE ZORSE",  			value = "BL_DW_ZB",  	color = "BL_DW"   , pattern = "PATTERN_ZEBRA", desc_center = "BL_DW_ZB"   },
{label = "RED MUSHROOM ZORSE",  			value = "R_M_ZB",  		color = "R_M"     , pattern = "PATTERN_ZEBRA", desc_center = "R_M_ZB"     },
{label = "BAY MUSHROOM ZORSE",  			value = "B_M_ZB",  		color = "B_M"     , pattern = "PATTERN_ZEBRA", desc_center = "B_M_ZB"     },
{label = "SILVER BLACK ZORSE",  			value = "BL_Z_ZB", 	    color = "BL_Z"    , pattern = "PATTERN_ZEBRA", desc_center = "BL_Z_ZB"    },
{label = "SILVER BAY ZORSE",  				value = "B_Z_ZB",  		color = "B_Z"     , pattern = "PATTERN_ZEBRA", desc_center = "B_Z_ZB"     },
{label = "SILVER SMOKEY BLACK ZORSE",  		value = "BL_CR_Z_ZB",   color = "BL_CR_Z" , pattern = "PATTERN_ZEBRA", desc_center = "BL_CR_Z_ZB" },
{label = "SILVER BUCKSKIN ZORSE",  			value = "B_CR_Z_ZB",  	color = "B_CR_Z"  , pattern = "PATTERN_ZEBRA", desc_center = "B_CR_Z_ZB"  },
}
 
Config.MENU_HORSES_CUSTOMIZATION_GENE_LEOPARD_SELECT_TITLE  = "Leopard" 
Config.MENU_HORSES_CUSTOMIZATION_GENE_LEOPARD_SELECT 		= { 
{label = "RED LEOPARD",  				 		value = "R_LP",  		color = "R" 	  , pattern = "PATTERN_LEOPARD", desc_center = "R_LP"       },
{label = "BLACK LEOPARD",  			 		    value = "BL_LP",  		color = "BL" 	  , pattern = "PATTERN_LEOPARD", desc_center = "BL_LP"      },
{label = "BAY LEOPARD",  				 		value = "B_LP",  		color = "B"       , pattern = "PATTERN_LEOPARD", desc_center = "B_LP"       },
{label = "FLAXEN CHESTNUT LEOPARD",    		    value = "R_FLX_LP",  	color = "R_FLX"   , pattern = "PATTERN_LEOPARD", desc_center = "R_FLX_LP"   },
{label = "PANGARE CHESTNUT LEOPARD",   		    value = "R_P_LP",  		color = "R_P" 	  , pattern = "PATTERN_LEOPARD", desc_center = "R_P_LP"     },
{label = "PANGARE BAY LEOPARD", 		 		value = "B_P_LP",  		color = "B_P"     , pattern = "PATTERN_LEOPARD", desc_center = "B_P_LP"     },
{label = "PALOMINO LEOPARD",  		 		    value = "R_CR_LP",  	color = "R_CR"    , pattern = "PATTERN_LEOPARD", desc_center = "R_CR_LP"    },
{label = "SMOKEY BLACK LEOPARD",  	 		    value = "BL_CR_LP",  	color = "BL_CR"   , pattern = "PATTERN_LEOPARD", desc_center = "BL_CR_LP"   },
{label = "BUCKSKIN LEOPARD",  		 		    value = "B_CR_LP",  	color = "B_CR"    , pattern = "PATTERN_LEOPARD", desc_center = "B_CR_LP"    },
{label = "CREMELLO LEOPARD",  		 		    value = "R_CR2_LP",  	color = "R_CR2"   , pattern = "PATTERN_LEOPARD", desc_center = "R_CR2_LP"   },
{label = "SMOKEY CREAM LEOPARD",  	 		    value = "BL_CR2_LP",  	color = "BL_CR2"  , pattern = "PATTERN_LEOPARD", desc_center = "BL_CR2_LP"  },
{label = "PERLINO LEOPARD",  			 		value = "B_CR2_LP",  	color = "B_CR2"   , pattern = "PATTERN_LEOPARD", desc_center = "B_CR2_LP"   },
{label = "GOLD CHAMPAGNE LEOPARD",  	 		value = "R_CH_LP",  	color = "R_CH"    , pattern = "PATTERN_LEOPARD", desc_center = "R_CH_LP"    },
{label = "CLASSIC CHAMPAGNE LEOPARD",  		    value = "BL_CH_LP",  	color = "BL_CH"	  , pattern = "PATTERN_LEOPARD", desc_center = "BL_CH_LP"   },
{label = "AMBER CHAMPAGNE LEOPARD",  	 		value = "B_CH_LP",  	color = "B_CH"	  , pattern = "PATTERN_LEOPARD", desc_center = "B_CH_LP"    },
{label = "GOLD CREAM CHAMPAGNE LEOPARD",  	    value = "R_CR_CH_LP",   color = "R_CR_CH" , pattern = "PATTERN_LEOPARD", desc_center = "R_CR_CH_LP" },
{label = "CLASSIC CREAM CHAMPAGNE LEOPARD",  	value = "BL_CR_CH_LP",  color = "BL_CR_CH", pattern = "PATTERN_LEOPARD", desc_center = "BL_CR_CH_LP"},
{label = "AMBER CREAM CHAMPAGNE LEOPARD",  	    value = "B_CR_CH_LP",   color = "B_CR_CH" , pattern = "PATTERN_LEOPARD", desc_center = "B_CR_CH_LP" },
{label = "GREY LEOPARD",  					    value = "BL_G_LP",  	color = "BL_G"    , pattern = "PATTERN_LEOPARD", desc_center = "BL_G_LP"    },
{label = "ROSE GREY LEOPARD",  				    value = "R_G_LP",  		color = "R_G"     , pattern = "PATTERN_LEOPARD", desc_center = "R_G_LP"     },
{label = "DOMINANT WHITE LEOPARD",  			value = "BL_DW_LP",  	color = "BL_DW"   , pattern = "PATTERN_LEOPARD", desc_center = "BL_DW_LP"   },
{label = "RED MUSHROOM LEOPARD",  			    value = "R_M_LP",  		color = "R_M"     , pattern = "PATTERN_LEOPARD", desc_center = "R_M_LP"     },
{label = "BAY MUSHROOM LEOPARD",  			    value = "B_M_LP",  		color = "B_M"     , pattern = "PATTERN_LEOPARD", desc_center = "B_M_LP"     },
{label = "SILVER BLACK LEOPARD",  			    value = "BL_Z_LP", 	    color = "BL_Z"    , pattern = "PATTERN_LEOPARD", desc_center = "BL_Z_LP"    },
{label = "SILVER BAY LEOPARD",  				value = "B_Z_LP",  		color = "B_Z"     , pattern = "PATTERN_LEOPARD", desc_center = "B_Z_LP"     },
{label = "SILVER SMOKEY BLACK LEOPARD",  		value = "BL_CR_Z_LP",   color = "BL_CR_Z" , pattern = "PATTERN_LEOPARD", desc_center = "BL_CR_Z_LP" },
{label = "SILVER BUCKSKIN LEOPARD",  			value = "B_CR_Z_LP",  	color = "B_CR_Z"  , pattern = "PATTERN_LEOPARD", desc_center = "B_CR_Z_LP"  },
}
 
Config.MENU_HORSES_CUSTOMIZATION_GENE_BLANKET_SELECT_TITLE  = "Blanket" 
Config.MENU_HORSES_CUSTOMIZATION_GENE_BLANKET_SELECT 		= { 
{label = "RED BLANKET",  				 		value = "R_BK",  		color = "R" 	  , pattern = "PATTERN_BLANKET", desc_center = "R_BK"       },
{label = "BLACK BLANKET",  			 		    value = "BL_BK",  		color = "BL" 	  , pattern = "PATTERN_BLANKET", desc_center = "BL_BK"      },
{label = "BAY BLANKET",  				 		value = "B_BK",  		color = "B"       , pattern = "PATTERN_BLANKET", desc_center = "B_BK"       },
{label = "FLAXEN CHESTNUT BLANKET",    		    value = "R_FLX_BK",  	color = "R_FLX"   , pattern = "PATTERN_BLANKET", desc_center = "R_FLX_BK"   },
{label = "PANGARE CHESTNUT BLANKET",   		    value = "R_P_BK",  		color = "R_P" 	  , pattern = "PATTERN_BLANKET", desc_center = "R_P_BK"     },
{label = "PANGARE BAY BLANKET", 		 		value = "B_P_BK",  		color = "B_P"     , pattern = "PATTERN_BLANKET", desc_center = "B_P_BK"     },
{label = "PALOMINO BLANKET",  		 		    value = "R_CR_BK",  	color = "R_CR"    , pattern = "PATTERN_BLANKET", desc_center = "R_CR_BK"    },
{label = "SMOKEY BLACK BLANKET",  	 		    value = "BL_CR_BK",  	color = "BL_CR"   , pattern = "PATTERN_BLANKET", desc_center = "BL_CR_BK"   },
{label = "BUCKSKIN BLANKET",  		 		    value = "B_CR_BK",  	color = "B_CR"    , pattern = "PATTERN_BLANKET", desc_center = "B_CR_BK"    },
{label = "CREMELLO BLANKET",  		 		    value = "R_CR2_BK",  	color = "R_CR2"   , pattern = "PATTERN_BLANKET", desc_center = "R_CR2_BK"   },
{label = "SMOKEY CREAM BLANKET",  	 		    value = "BL_CR2_BK",  	color = "BL_CR2"  , pattern = "PATTERN_BLANKET", desc_center = "BL_CR2_BK"  },
{label = "PERLINO BLANKET",  			 		value = "B_CR2_BK",  	color = "B_CR2"   , pattern = "PATTERN_BLANKET", desc_center = "B_CR2_BK"   },
{label = "GOLD CHAMPAGNE BLANKET",  	 		value = "R_CH_BK",  	color = "R_CH"    , pattern = "PATTERN_BLANKET", desc_center = "R_CH_BK"    },
{label = "CLASSIC CHAMPAGNE BLANKET",  		    value = "BL_CH_BK",  	color = "BL_CH"	  , pattern = "PATTERN_BLANKET", desc_center = "BL_CH_BK"   },
{label = "AMBER CHAMPAGNE BLANKET",  	 		value = "B_CH_BK",  	color = "B_CH"	  , pattern = "PATTERN_BLANKET", desc_center = "B_CH_BK"    },
{label = "GOLD CREAM CHAMPAGNE BLANKET",  	    value = "R_CR_CH_BK",   color = "R_CR_CH" , pattern = "PATTERN_BLANKET", desc_center = "R_CR_CH_BK" },
{label = "CLASSIC CREAM CHAMPAGNE BLANKET",  	value = "BL_CR_CH_BK",  color = "BL_CR_CH", pattern = "PATTERN_BLANKET", desc_center = "BL_CR_CH_BK"},
{label = "AMBER CREAM CHAMPAGNE BLANKET",  	    value = "B_CR_CH_BK",   color = "B_CR_CH" , pattern = "PATTERN_BLANKET", desc_center = "B_CR_CH_BK" },
{label = "GREY BLANKET",  					    value = "BL_G_BK",  	color = "BL_G"    , pattern = "PATTERN_BLANKET", desc_center = "BL_G_BK"    },
{label = "ROSE GREY BLANKET",  				    value = "R_G_BK",  		color = "R_G"     , pattern = "PATTERN_BLANKET", desc_center = "R_G_BK"     },
{label = "DOMINANT WHITE BLANKET",  			value = "BL_DW_BK",  	color = "BL_DW"   , pattern = "PATTERN_BLANKET", desc_center = "BL_DW_BK"   },
{label = "RED MUSHROOM BLANKET",  			    value = "R_M_BK",  		color = "R_M"     , pattern = "PATTERN_BLANKET", desc_center = "R_M_BK"     },
{label = "BAY MUSHROOM BLANKET",  			    value = "B_M_BK",  		color = "B_M"     , pattern = "PATTERN_BLANKET", desc_center = "B_M_BK"     },
{label = "SILVER BLACK BLANKET",  			    value = "BL_Z_BK", 	    color = "BL_Z"    , pattern = "PATTERN_BLANKET", desc_center = "BL_Z_BK"    },
{label = "SILVER BAY BLANKET",  				value = "B_Z_BK",  		color = "B_Z"     , pattern = "PATTERN_BLANKET", desc_center = "B_Z_BK"     },
{label = "SILVER SMOKEY BLACK BLANKET",  		value = "BL_CR_Z_BK",   color = "BL_CR_Z" , pattern = "PATTERN_BLANKET", desc_center = "BL_CR_Z_BK" },
{label = "SILVER BUCKSKIN BLANKET",  			value = "B_CR_Z_BK",  	color = "B_CR_Z"  , pattern = "PATTERN_BLANKET", desc_center = "B_CR_Z_BK"  },

}
 
Config.MENU_HORSES_CUSTOMIZATION_GENE_SNOWFLAKE_SELECT_TITLE  = "Snowflake" 
Config.MENU_HORSES_CUSTOMIZATION_GENE_SNOWFLAKE_SELECT 		= { 
{label = "RED SNOWFLAKE",  				 		    value = "R_SF",  		color = "R" 	  , pattern = "PATTERN_SNOWFLAKE", desc_center = "R_SF"       },
{label = "BLACK SNOWFLAKE",  			 		    value = "BL_SF",  		color = "BL" 	  , pattern = "PATTERN_SNOWFLAKE", desc_center = "BL_SF"      },
{label = "BAY SNOWFLAKE",  				 		    value = "B_SF",  		color = "B"       , pattern = "PATTERN_SNOWFLAKE", desc_center = "B_SF"       },
{label = "FLAXEN CHESTNUT SNOWFLAKE",    		    value = "R_FLX_SF",  	color = "R_FLX"   , pattern = "PATTERN_SNOWFLAKE", desc_center = "R_FLX_SF"   },
{label = "PANGARE CHESTNUT SNOWFLAKE",   		    value = "R_P_SF",  		color = "R_P" 	  , pattern = "PATTERN_SNOWFLAKE", desc_center = "R_P_SF"     },
{label = "PANGARE BAY SNOWFLAKE", 		 		    value = "B_P_SF",  		color = "B_P"     , pattern = "PATTERN_SNOWFLAKE", desc_center = "B_P_SF"     },
{label = "PALOMINO SNOWFLAKE",  		 		    value = "R_CR_SF",  	color = "R_CR"    , pattern = "PATTERN_SNOWFLAKE", desc_center = "R_CR_SF"    },
{label = "SMOKEY BLACK SNOWFLAKE",  	 		    value = "BL_CR_SF",  	color = "BL_CR"   , pattern = "PATTERN_SNOWFLAKE", desc_center = "BL_CR_SF"   },
{label = "BUCKSKIN SNOWFLAKE",  		 		    value = "B_CR_SF",  	color = "B_CR"    , pattern = "PATTERN_SNOWFLAKE", desc_center = "B_CR_SF"    },
{label = "CREMELLO SNOWFLAKE",  		 		    value = "R_CR2_SF",  	color = "R_CR2"   , pattern = "PATTERN_SNOWFLAKE", desc_center = "R_CR2_SF"   },
{label = "SMOKEY CREAM SNOWFLAKE",  	 		    value = "BL_CR2_SF",  	color = "BL_CR2"  , pattern = "PATTERN_SNOWFLAKE", desc_center = "BL_CR2_SF"  },
{label = "PERLINO SNOWFLAKE",  			 		    value = "B_CR2_SF",  	color = "B_CR2"   , pattern = "PATTERN_SNOWFLAKE", desc_center = "B_CR2_SF"   },
{label = "GOLD CHAMPAGNE SNOWFLAKE",  	 		    value = "R_CH_SF",  	color = "R_CH"    , pattern = "PATTERN_SNOWFLAKE", desc_center = "R_CH_SF"    },
{label = "CLASSIC CHAMPAGNE SNOWFLAKE",  		    value = "BL_CH_SF",  	color = "BL_CH"	  , pattern = "PATTERN_SNOWFLAKE", desc_center = "BL_CH_SF"   },
{label = "AMBER CHAMPAGNE SNOWFLAKE",  	 		    value = "B_CH_SF",  	color = "B_CH"	  , pattern = "PATTERN_SNOWFLAKE", desc_center = "B_CH_SF"    },
{label = "GOLD CREAM CHAMPAGNE SNOWFLAKE",  	    value = "R_CR_CH_SF",   color = "R_CR_CH" , pattern = "PATTERN_SNOWFLAKE", desc_center = "R_CR_CH_SF" },
{label = "CLASSIC CREAM CHAMPAGNE SNOWFLAKE",  	    value = "BL_CR_CH_SF",  color = "BL_CR_CH", pattern = "PATTERN_SNOWFLAKE", desc_center = "BL_CR_CH_SF"},
{label = "AMBER CREAM CHAMPAGNE SNOWFLAKE",  	    value = "B_CR_CH_SF",   color = "B_CR_CH" , pattern = "PATTERN_SNOWFLAKE", desc_center = "B_CR_CH_SF" },
{label = "GREY SNOWFLAKE",  					    value = "BL_G_SF",  	color = "BL_G"    , pattern = "PATTERN_SNOWFLAKE", desc_center = "BL_G_SF"    },
{label = "ROSE GREY SNOWFLAKE",  				    value = "R_G_SF",  		color = "R_G"     , pattern = "PATTERN_SNOWFLAKE", desc_center = "R_G_SF"     },
{label = "DOMINANT WHITE SNOWFLAKE",  			    value = "BL_DW_SF",  	color = "BL_DW"   , pattern = "PATTERN_SNOWFLAKE", desc_center = "BL_DW_SF"   },
{label = "RED MUSHROOM SNOWFLAKE",  			    value = "R_M_SF",  		color = "R_M"     , pattern = "PATTERN_SNOWFLAKE", desc_center = "R_M_SF"     },
{label = "BAY MUSHROOM SNOWFLAKE",  			    value = "B_M_SF",  		color = "B_M"     , pattern = "PATTERN_SNOWFLAKE", desc_center = "B_M_SF"     },
{label = "SILVER BLACK SNOWFLAKE",  			    value = "BL_Z_SF", 	    color = "BL_Z"    , pattern = "PATTERN_SNOWFLAKE", desc_center = "BL_Z_SF"    },
{label = "SILVER BAY SNOWFLAKE",  				    value = "B_Z_SF",  		color = "B_Z"     , pattern = "PATTERN_SNOWFLAKE", desc_center = "B_Z_SF"     },
{label = "SILVER SMOKEY BLACK SNOWFLAKE",  		    value = "BL_CR_Z_SF",   color = "BL_CR_Z" , pattern = "PATTERN_SNOWFLAKE", desc_center = "BL_CR_Z_SF" },
{label = "SILVER BUCKSKIN SNOWFLAKE",  			    value = "B_CR_Z_SF",  	color = "B_CR_Z"  , pattern = "PATTERN_SNOWFLAKE", desc_center = "B_CR_Z_SF"  },
}
 
Config.MENU_HORSES_CUSTOMIZATION_GENE_FEWSPOTTED_SELECT_TITLE  = "Few Spotted" 
Config.MENU_HORSES_CUSTOMIZATION_GENE_FEWSPOTTED_SELECT 		= { 
{label = "RED FEW SPOTTED",  				 		    value = "R_FSP",  		    color = "R" 	  , pattern = "PATTERN_FEW_SPOTTED", desc_center = "R_FSP"       },
{label = "BLACK FEW SPOTTED",  			 		        value = "BL_FSP",  		    color = "BL" 	  , pattern = "PATTERN_FEW_SPOTTED", desc_center = "BL_FSP"      },
{label = "BAY FEW SPOTTED",  				 		    value = "B_FSP",  		    color = "B"       , pattern = "PATTERN_FEW_SPOTTED", desc_center = "B_FSP"       },
{label = "FLAXEN CHESTNUT FEW SPOTTED",    		        value = "R_FLX_FSP",  	    color = "R_FLX"   , pattern = "PATTERN_FEW_SPOTTED", desc_center = "R_FLX_FSP"   },
{label = "PANGARE CHESTNUT FEW SPOTTED",   		        value = "R_P_FSP",  		color = "R_P" 	  , pattern = "PATTERN_FEW_SPOTTED", desc_center = "R_P_FSP"     },
{label = "PANGARE BAY FEW SPOTTED", 		 		    value = "B_P_FSP",  		color = "B_P"     , pattern = "PATTERN_FEW_SPOTTED", desc_center = "B_P_FSP"     },
{label = "PALOMINO FEW SPOTTED",  		 		        value = "R_CR_FSP",  	    color = "R_CR"    , pattern = "PATTERN_FEW_SPOTTED", desc_center = "R_CR_FSP"    },
{label = "SMOKEY BLACK FEW SPOTTED",  	 		        value = "BL_CR_FSP",  	    color = "BL_CR"   , pattern = "PATTERN_FEW_SPOTTED", desc_center = "BL_CR_FSP"   },
{label = "BUCKSKIN FEW SPOTTED",  		 		        value = "B_CR_FSP",  	    color = "B_CR"    , pattern = "PATTERN_FEW_SPOTTED", desc_center = "B_CR_FSP"    },
{label = "CREMELLO FEW SPOTTED",  		 		        value = "R_CR2_FSP",  	    color = "R_CR2"   , pattern = "PATTERN_FEW_SPOTTED", desc_center = "R_CR2_FSP"   },
{label = "SMOKEY CREAM FEW SPOTTED",  	 		        value = "BL_CR2_FSP",  	    color = "BL_CR2"  , pattern = "PATTERN_FEW_SPOTTED", desc_center = "BL_CR2_FSP"  },
{label = "PERLINO FEW SPOTTED",  			 		    value = "B_CR2_FSP",  	    color = "B_CR2"   , pattern = "PATTERN_FEW_SPOTTED", desc_center = "B_CR2_FSP"   },
{label = "GOLD CHAMPAGNE FEW SPOTTED",  	 		    value = "R_CH_FSP",  	    color = "R_CH"    , pattern = "PATTERN_FEW_SPOTTED", desc_center = "R_CH_FSP"    },
{label = "CLASSIC CHAMPAGNE FEW SPOTTED",  		        value = "BL_CH_FSP",  	    color = "BL_CH"	  , pattern = "PATTERN_FEW_SPOTTED", desc_center = "BL_CH_FSP"   },
{label = "AMBER CHAMPAGNE FEW SPOTTED",  	 		    value = "B_CH_FSP",  	    color = "B_CH"	  , pattern = "PATTERN_FEW_SPOTTED", desc_center = "B_CH_FSP"    },
{label = "GOLD CREAM CHAMPAGNE FEW SPOTTED",  	        value = "R_CR_CH_FSP",      color = "R_CR_CH" , pattern = "PATTERN_FEW_SPOTTED", desc_center = "R_CR_CH_FSP" },
{label = "CLASSIC CREAM CHAMPAGNE FEW SPOTTED",  	    value = "BL_CR_CH_FSP",     color = "BL_CR_CH", pattern = "PATTERN_FEW_SPOTTED", desc_center = "BL_CR_CH_FSP"},
{label = "AMBER CREAM CHAMPAGNE FEW SPOTTED",  	        value = "B_CR_CH_FSP",      color = "B_CR_CH" , pattern = "PATTERN_FEW_SPOTTED", desc_center = "B_CR_CH_FSP" },
{label = "GREY FEW SPOTTED",  					        value = "BL_G_FSP",  	    color = "BL_G"    , pattern = "PATTERN_FEW_SPOTTED", desc_center = "BL_G_FSP"    },
{label = "ROSE GREY FEW SPOTTED",  				        value = "R_G_FSP",  		color = "R_G"     , pattern = "PATTERN_FEW_SPOTTED", desc_center = "R_G_FSP"     },
{label = "DOMINANT WHITE FEW SPOTTED",  			    value = "BL_DW_FSP",  	    color = "BL_DW"   , pattern = "PATTERN_FEW_SPOTTED", desc_center = "BL_DW_FSP"   },
{label = "RED MUSHROOM FEW SPOTTED",  			        value = "R_M_FSP",  		color = "R_M"     , pattern = "PATTERN_FEW_SPOTTED", desc_center = "R_M_FSP"     },
{label = "BAY MUSHROOM FEW SPOTTED",  			        value = "B_M_FSP",  		color = "B_M"     , pattern = "PATTERN_FEW_SPOTTED", desc_center = "B_M_FSP"     },
{label = "SILVER BLACK FEW SPOTTED",  			        value = "BL_Z_FSP", 	    color = "BL_Z"    , pattern = "PATTERN_FEW_SPOTTED", desc_center = "BL_Z_FSP"    },
{label = "SILVER BAY FEW SPOTTED",  				    value = "B_Z_FSP",  		color = "B_Z"     , pattern = "PATTERN_FEW_SPOTTED", desc_center = "B_Z_FSP"     },
{label = "SILVER SMOKEY BLACK FEW SPOTTED",  		    value = "BL_CR_Z_FSP",      color = "BL_CR_Z" , pattern = "PATTERN_FEW_SPOTTED", desc_center = "BL_CR_Z_FSP" },
{label = "SILVER BUCKSKIN FEW SPOTTED",  			    value = "B_CR_Z_FSP",  	    color = "B_CR_Z"  , pattern = "PATTERN_FEW_SPOTTED", desc_center = "B_CR_Z_FSP"  },
}

Config.MENU_HORSES_CUSTOMIZATION_GENE_SABINO_SELECT_TITLE  = "Sabino" 
Config.MENU_HORSES_CUSTOMIZATION_GENE_SABINO_SELECT 		= { 
{label = "RED SABINO",  				 		    value = "R_SB",  		    color = "R" 	  , pattern = "PATTERN_SABINO", desc_center = "R_SB"       },
{label = "BLACK SABINO",  			 		        value = "BL_SB",  		    color = "BL" 	  , pattern = "PATTERN_SABINO", desc_center = "BL_SB"      },
{label = "BAY SABINO",  				 		    value = "B_SB",  		    color = "B"       , pattern = "PATTERN_SABINO", desc_center = "B_SB"       },
{label = "FLAXEN CHESTNUT SABINO",    		        value = "R_FLX_SB",  	    color = "R_FLX"   , pattern = "PATTERN_SABINO", desc_center = "R_FLX_SB"   },
{label = "PANGARE CHESTNUT SABINO",   		        value = "R_P_SB",  		    color = "R_P" 	  , pattern = "PATTERN_SABINO", desc_center = "R_P_SB"     },
{label = "PANGARE BAY SABINO", 		 		        value = "B_P_SB",  		    color = "B_P"     , pattern = "PATTERN_SABINO", desc_center = "B_P_SB"     },
{label = "PALOMINO SABINO",  		 		        value = "R_CR_SB",  	    color = "R_CR"    , pattern = "PATTERN_SABINO", desc_center = "R_CR_SB"    },
{label = "SMOKEY BLACK SABINO",  	 		        value = "BL_CR_SB",  	    color = "BL_CR"   , pattern = "PATTERN_SABINO", desc_center = "BL_CR_SB"   },
{label = "BUCKSKIN SABINO",  		 		        value = "B_CR_SB",  	    color = "B_CR"    , pattern = "PATTERN_SABINO", desc_center = "B_CR_SB"    },
{label = "CREMELLO SABINO",  		 		        value = "R_CR2_SB",  	    color = "R_CR2"   , pattern = "PATTERN_SABINO", desc_center = "R_CR2_SB"   },
{label = "SMOKEY CREAM SABINO",  	 		        value = "BL_CR2_SB",  	    color = "BL_CR2"  , pattern = "PATTERN_SABINO", desc_center = "BL_CR2_SB"  },
{label = "PERLINO SABINO",  			 		    value = "B_CR2_SB",  	    color = "B_CR2"   , pattern = "PATTERN_SABINO", desc_center = "B_CR2_SB"   },
{label = "GOLD CHAMPAGNE SABINO",  	 		        value = "R_CH_SB",  	    color = "R_CH"    , pattern = "PATTERN_SABINO", desc_center = "R_CH_SB"    },
{label = "CLASSIC CHAMPAGNE SABINO",  		        value = "BL_CH_SB",  	    color = "BL_CH"	  , pattern = "PATTERN_SABINO", desc_center = "BL_CH_SB"   },
{label = "AMBER CHAMPAGNE SABINO",  	 		    value = "B_CH_SB",  	    color = "B_CH"	  , pattern = "PATTERN_SABINO", desc_center = "B_CH_SB"    },
{label = "GOLD CREAM CHAMPAGNE SABINO",  	        value = "R_CR_CH_SB",       color = "R_CR_CH" , pattern = "PATTERN_SABINO", desc_center = "R_CR_CH_SB" },
{label = "CLASSIC CREAM CHAMPAGNE SABINO",  	    value = "BL_CR_CH_SB",      color = "BL_CR_CH", pattern = "PATTERN_SABINO", desc_center = "BL_CR_CH_SB"},
{label = "AMBER CREAM CHAMPAGNE SABINO",  	        value = "B_CR_CH_SB",       color = "B_CR_CH" , pattern = "PATTERN_SABINO", desc_center = "B_CR_CH_SB" },
{label = "GREY SABINO",  					        value = "BL_G_SB",  	    color = "BL_G"    , pattern = "PATTERN_SABINO", desc_center = "BL_G_SB"    },
{label = "ROSE GREY SABINO",  				        value = "R_G_SB",  		    color = "R_G"     , pattern = "PATTERN_SABINO", desc_center = "R_G_SB"     },
{label = "DOMINANT WHITE SABINO",  			        value = "BL_DW_SB",  	    color = "BL_DW"   , pattern = "PATTERN_SABINO", desc_center = "BL_DW_SB"   },
{label = "RED MUSHROOM SABINO",  			        value = "R_M_SB",  		    color = "R_M"     , pattern = "PATTERN_SABINO", desc_center = "R_M_SB"     },
{label = "BAY MUSHROOM SABINO",  			        value = "B_M_SB",  		    color = "B_M"     , pattern = "PATTERN_SABINO", desc_center = "B_M_SB"     },
{label = "SILVER BLACK SABINO",  			        value = "BL_Z_SB", 	        color = "BL_Z"    , pattern = "PATTERN_SABINO", desc_center = "BL_Z_SB"    },
{label = "SILVER BAY SABINO",  				        value = "B_Z_SB",  		    color = "B_Z"     , pattern = "PATTERN_SABINO", desc_center = "B_Z_SB"     },
{label = "SILVER SMOKEY BLACK SABINO",  		    value = "BL_CR_Z_SB",       color = "BL_CR_Z" , pattern = "PATTERN_SABINO", desc_center = "BL_CR_Z_SB" },
{label = "SILVER BUCKSKIN SABINO",  			    value = "B_CR_Z_SB",  	    color = "B_CR_Z"  , pattern = "PATTERN_SABINO", desc_center = "B_CR_Z_SB"  },
}
 
Config.MENU_HORSES_CUSTOMIZATION_GENE_TOBIANO_SELECT_TITLE  = "Tobiano" 
Config.MENU_HORSES_CUSTOMIZATION_GENE_TOBIANO_SELECT 		= { 
{label = "RED TOBIANO",  				 		        value = "R_TO",  		        color = "R" 	  , pattern = "PATTERN_TOBIANO", desc_center = "R_TO"       },
{label = "BLACK TOBIANO",  			 		            value = "BL_TO",  		        color = "BL" 	  , pattern = "PATTERN_TOBIANO", desc_center = "BL_TO"      },
{label = "BAY TOBIANO",  				 		        value = "B_TO",  		        color = "B"       , pattern = "PATTERN_TOBIANO", desc_center = "B_TO"       },
{label = "FLAXEN CHESTNUT TOBIANO",    		            value = "R_FLX_TO",  	        color = "R_FLX"   , pattern = "PATTERN_TOBIANO", desc_center = "R_FLX_TO"   },
{label = "PANGARE CHESTNUT TOBIANO",   		            value = "R_P_TO",  		        color = "R_P" 	  , pattern = "PATTERN_TOBIANO", desc_center = "R_P_TO"     },
{label = "PANGARE BAY TOBIANO", 		 		        value = "B_P_TO",  		        color = "B_P"     , pattern = "PATTERN_TOBIANO", desc_center = "B_P_TO"     },
{label = "PALOMINO TOBIANO",  		 		            value = "R_CR_TO",  	        color = "R_CR"    , pattern = "PATTERN_TOBIANO", desc_center = "R_CR_TO"    },
{label = "SMOKEY BLACK TOBIANO",  	 		            value = "BL_CR_TO",  	        color = "BL_CR"   , pattern = "PATTERN_TOBIANO", desc_center = "BL_CR_TO"   },
{label = "BUCKSKIN TOBIANO",  		 		            value = "B_CR_TO",  	        color = "B_CR"    , pattern = "PATTERN_TOBIANO", desc_center = "B_CR_TO"    },
{label = "CREMELLO TOBIANO",  		 		            value = "R_CR2_TO",  	        color = "R_CR2"   , pattern = "PATTERN_TOBIANO", desc_center = "R_CR2_TO"   },
{label = "SMOKEY CREAM TOBIANO",  	 		            value = "BL_CR2_TO",  	        color = "BL_CR2"  , pattern = "PATTERN_TOBIANO", desc_center = "BL_CR2_TO"  },
{label = "PERLINO TOBIANO",  			 		        value = "B_CR2_TO",  	        color = "B_CR2"   , pattern = "PATTERN_TOBIANO", desc_center = "B_CR2_TO"   },
{label = "GOLD CHAMPAGNE TOBIANO",  	 		        value = "R_CH_TO",  	        color = "R_CH"    , pattern = "PATTERN_TOBIANO", desc_center = "R_CH_TO"    },
{label = "CLASSIC CHAMPAGNE TOBIANO",  		            value = "BL_CH_TO",  	        color = "BL_CH"	  , pattern = "PATTERN_TOBIANO", desc_center = "BL_CH_TO"   },
{label = "AMBER CHAMPAGNE TOBIANO",  	 		        value = "B_CH_TO",  	        color = "B_CH"	  , pattern = "PATTERN_TOBIANO", desc_center = "B_CH_TO"    },
{label = "GOLD CREAM CHAMPAGNE TOBIANO",  	            value = "R_CR_CH_TO",           color = "R_CR_CH" , pattern = "PATTERN_TOBIANO", desc_center = "R_CR_CH_TO" },
{label = "CLASSIC CREAM CHAMPAGNE TOBIANO",  	        value = "BL_CR_CH_TO",          color = "BL_CR_CH", pattern = "PATTERN_TOBIANO", desc_center = "BL_CR_CH_TO"},
{label = "AMBER CREAM CHAMPAGNE TOBIANO",  	            value = "B_CR_CH_TO",           color = "B_CR_CH" , pattern = "PATTERN_TOBIANO", desc_center = "B_CR_CH_TO" },
{label = "GREY TOBIANO",  					            value = "BL_G_TO",  	        color = "BL_G"    , pattern = "PATTERN_TOBIANO", desc_center = "BL_G_TO"    },
{label = "ROSE GREY TOBIANO",  				            value = "R_G_TO",  		        color = "R_G"     , pattern = "PATTERN_TOBIANO", desc_center = "R_G_TO"     },
{label = "DOMINANT WHITE TOBIANO",  			        value = "BL_DW_TO",  	        color = "BL_DW"   , pattern = "PATTERN_TOBIANO", desc_center = "BL_DW_TO"   },
{label = "RED MUSHROOM TOBIANO",  			            value = "R_M_TO",  		        color = "R_M"     , pattern = "PATTERN_TOBIANO", desc_center = "R_M_TO"     },
{label = "BAY MUSHROOM TOBIANO",  			            value = "B_M_TO",  		        color = "B_M"     , pattern = "PATTERN_TOBIANO", desc_center = "B_M_TO"     },
{label = "SILVER BLACK TOBIANO",  			            value = "BL_Z_TO", 	            color = "BL_Z"    , pattern = "PATTERN_TOBIANO", desc_center = "BL_Z_TO"    },
{label = "SILVER BAY TOBIANO",  				        value = "B_Z_TO",  		        color = "B_Z"     , pattern = "PATTERN_TOBIANO", desc_center = "B_Z_TO"     },
{label = "SILVER SMOKEY BLACK TOBIANO",  		        value = "BL_CR_Z_TO",           color = "BL_CR_Z" , pattern = "PATTERN_TOBIANO", desc_center = "BL_CR_Z_TO" },
{label = "SILVER BUCKSKIN TOBIANO",  			        value = "B_CR_Z_TO",  	        color = "B_CR_Z"  , pattern = "PATTERN_TOBIANO", desc_center = "B_CR_Z_TO"  },
} 
 
Config.MENU_HORSES_CUSTOMIZATION_GENE_OVERO_SELECT_TITLE  = "Overo" 
Config.MENU_HORSES_CUSTOMIZATION_GENE_OVERO_SELECT 		= { 
{label = "RED OVERO",  				 		            value = "R_O",  		        color = "R" 	  , pattern = "PATTERN_OVERO", desc_center = "R_O"       },
{label = "BLACK OVERO",  			 		            value = "BL_O",  		        color = "BL" 	  , pattern = "PATTERN_OVERO", desc_center = "BL_O"      },
{label = "BAY OVERO",  				 		            value = "B_O",  		        color = "B"       , pattern = "PATTERN_OVERO", desc_center = "B_O"       },
{label = "FLAXEN CHESTNUT OVERO",    		            value = "R_FLX_O",  	        color = "R_FLX"   , pattern = "PATTERN_OVERO", desc_center = "R_FLX_O"   },
{label = "PANGARE CHESTNUT OVERO",   		            value = "R_P_O",  		        color = "R_P" 	  , pattern = "PATTERN_OVERO", desc_center = "R_P_O"     },
{label = "PANGARE BAY OVERO", 		 		            value = "B_P_O",  		        color = "B_P"     , pattern = "PATTERN_OVERO", desc_center = "B_P_O"     },
{label = "PALOMINO OVERO",  		 		            value = "R_CR_O",  	            color = "R_CR"    , pattern = "PATTERN_OVERO", desc_center = "R_CR_O"    },
{label = "SMOKEY BLACK OVERO",  	 		            value = "BL_CR_O",  	        color = "BL_CR"   , pattern = "PATTERN_OVERO", desc_center = "BL_CR_O"   },
{label = "BUCKSKIN OVERO",  		 		            value = "B_CR_O",  	            color = "B_CR"    , pattern = "PATTERN_OVERO", desc_center = "B_CR_O"    },
{label = "CREMELLO OVERO",  		 		            value = "R_CR2_O",  	        color = "R_CR2"   , pattern = "PATTERN_OVERO", desc_center = "R_CR2_O"   },
{label = "SMOKEY CREAM OVERO",  	 		            value = "BL_CR2_O",  	        color = "BL_CR2"  , pattern = "PATTERN_OVERO", desc_center = "BL_CR2_O"  },
{label = "PERLINO OVERO",  			 		            value = "B_CR2_O",  	        color = "B_CR2"   , pattern = "PATTERN_OVERO", desc_center = "B_CR2_O"   },
{label = "GOLD CHAMPAGNE OVERO",  	 		            value = "R_CH_O",  	            color = "R_CH"    , pattern = "PATTERN_OVERO", desc_center = "R_CH_O"    },
{label = "CLASSIC CHAMPAGNE OVERO",  		            value = "BL_CH_O",  	        color = "BL_CH"	  , pattern = "PATTERN_OVERO", desc_center = "BL_CH_O"   },
{label = "AMBER CHAMPAGNE OVERO",  	 		            value = "B_CH_O",  	            color = "B_CH"	  , pattern = "PATTERN_OVERO", desc_center = "B_CH_O"    },
{label = "GOLD CREAM CHAMPAGNE OVERO",  	            value = "R_CR_CH_O",            color = "R_CR_CH" , pattern = "PATTERN_OVERO", desc_center = "R_CR_CH_O" },
{label = "CLASSIC CREAM CHAMPAGNE OVERO",  	            value = "BL_CR_CH_O",           color = "BL_CR_CH", pattern = "PATTERN_OVERO", desc_center = "BL_CR_CH_O"},
{label = "AMBER CREAM CHAMPAGNE OVERO",  	            value = "B_CR_CH_O",            color = "B_CR_CH" , pattern = "PATTERN_OVERO", desc_center = "B_CR_CH_O" },
{label = "GREY OVERO",  					            value = "BL_G_O",  	            color = "BL_G"    , pattern = "PATTERN_OVERO", desc_center = "BL_G_O"    },
{label = "ROSE GREY OVERO",  				            value = "R_G_O",  		        color = "R_G"     , pattern = "PATTERN_OVERO", desc_center = "R_G_O"     },
{label = "DOMINANT WHITE OVERO",  			            value = "BL_DW_O",  	        color = "BL_DW"   , pattern = "PATTERN_OVERO", desc_center = "BL_DW_O"   },
{label = "RED MUSHROOM OVERO",  			            value = "R_M_O",  		        color = "R_M"     , pattern = "PATTERN_OVERO", desc_center = "R_M_O"     },
{label = "BAY MUSHROOM OVERO",  			            value = "B_M_O",  		        color = "B_M"     , pattern = "PATTERN_OVERO", desc_center = "B_M_O"     },
{label = "SILVER BLACK OVERO",  			            value = "BL_Z_O", 	            color = "BL_Z"    , pattern = "PATTERN_OVERO", desc_center = "BL_Z_O"    },
{label = "SILVER BAY OVERO",  				            value = "B_Z_O",  		        color = "B_Z"     , pattern = "PATTERN_OVERO", desc_center = "B_Z_O"     },
{label = "SILVER SMOKEY BLACK OVERO",  		            value = "BL_CR_Z_O",            color = "BL_CR_Z" , pattern = "PATTERN_OVERO", desc_center = "BL_CR_Z_O" },
{label = "SILVER BUCKSKIN OVERO",  			            value = "B_CR_Z_O",  	        color = "B_CR_Z"  , pattern = "PATTERN_OVERO", desc_center = "B_CR_Z_O"  },
}
 
Config.MENU_HORSES_CUSTOMIZATION_GENE_TOVERO_SELECT_TITLE  = "Tovero" 
Config.MENU_HORSES_CUSTOMIZATION_GENE_TOVERO_SELECT 		= { 
{label = "RED TOVERO",  				 		            value = "R_TOV",  		            color = "R" 	  , pattern = "PATTERN_TOVERO", desc_center = "R_TOV"       },
{label = "BLACK TOVERO",  			 		                value = "BL_TOV",  		            color = "BL" 	  , pattern = "PATTERN_TOVERO", desc_center = "BL_TOV"      },
{label = "BAY TOVERO",  				 		            value = "B_TOV",  		            color = "B"       , pattern = "PATTERN_TOVERO", desc_center = "B_TOV"       },
{label = "FLAXEN CHESTNUT TOVERO",    		                value = "R_FLX_TOV",  	            color = "R_FLX"   , pattern = "PATTERN_TOVERO", desc_center = "R_FLX_TOV"   },
{label = "PANGARE CHESTNUT TOVERO",   		                value = "R_P_TOV",  		        color = "R_P" 	  , pattern = "PATTERN_TOVERO", desc_center = "R_P_TOV"     },
{label = "PANGARE BAY TOVERO", 		 		                value = "B_P_TOV",  		        color = "B_P"     , pattern = "PATTERN_TOVERO", desc_center = "B_P_TOV"     },
{label = "PALOMINO TOVERO",  		 		                value = "R_CR_TOV",  	            color = "R_CR"    , pattern = "PATTERN_TOVERO", desc_center = "R_CR_TOV"    },
{label = "SMOKEY BLACK TOVERO",  	 		                value = "BL_CR_TOV",  	            color = "BL_CR"   , pattern = "PATTERN_TOVERO", desc_center = "BL_CR_TOV"   },
{label = "BUCKSKIN TOVERO",  		 		                value = "B_CR_TOV",  	            color = "B_CR"    , pattern = "PATTERN_TOVERO", desc_center = "B_CR_TOV"    },
{label = "CREMELLO TOVERO",  		 		                value = "R_CR2_TOV",  	            color = "R_CR2"   , pattern = "PATTERN_TOVERO", desc_center = "R_CR2_TOV"   },
{label = "SMOKEY CREAM TOVERO",  	 		                value = "BL_CR2_TOV",  	            color = "BL_CR2"  , pattern = "PATTERN_TOVERO", desc_center = "BL_CR2_TOV"  },
{label = "PERLINO TOVERO",  			 		            value = "B_CR2_TOV",  	            color = "B_CR2"   , pattern = "PATTERN_TOVERO", desc_center = "B_CR2_TOV"   },
{label = "GOLD CHAMPAGNE TOVERO",  	 		                value = "R_CH_TOV",  	            color = "R_CH"    , pattern = "PATTERN_TOVERO", desc_center = "R_CH_TOV"    },
{label = "CLASSIC CHAMPAGNE TOVERO",  		                value = "BL_CH_TOV",  	            color = "BL_CH"	  , pattern = "PATTERN_TOVERO", desc_center = "BL_CH_TOV"   },
{label = "AMBER CHAMPAGNE TOVERO",  	 		            value = "B_CH_TOV",  	            color = "B_CH"	  , pattern = "PATTERN_TOVERO", desc_center = "B_CH_TOV"    },
{label = "GOLD CREAM CHAMPAGNE TOVERO",  	                value = "R_CR_CH_TOV",              color = "R_CR_CH" , pattern = "PATTERN_TOVERO", desc_center = "R_CR_CH_TOV" },
{label = "CLASSIC CREAM CHAMPAGNE TOVERO",  	            value = "BL_CR_CH_TOV",             color = "BL_CR_CH", pattern = "PATTERN_TOVERO", desc_center = "BL_CR_CH_TOV"},
{label = "AMBER CREAM CHAMPAGNE TOVERO",  	                value = "B_CR_CH_TOV",              color = "B_CR_CH" , pattern = "PATTERN_TOVERO", desc_center = "B_CR_CH_TOV" },
{label = "GREY TOVERO",  					                value = "BL_G_TOV",  	            color = "BL_G"    , pattern = "PATTERN_TOVERO", desc_center = "BL_G_TOV"    },
{label = "ROSE GREY TOVERO",  				                value = "R_G_TOV",  		        color = "R_G"     , pattern = "PATTERN_TOVERO", desc_center = "R_G_TOV"     },
{label = "DOMINANT WHITE TOVERO",  			                value = "BL_DW_TOV",  	            color = "BL_DW"   , pattern = "PATTERN_TOVERO", desc_center = "BL_DW_TOV"   },
{label = "RED MUSHROOM TOVERO",  			                value = "R_M_TOV",  		        color = "R_M"     , pattern = "PATTERN_TOVERO", desc_center = "R_M_TOV"     },
{label = "BAY MUSHROOM TOVERO",  			                value = "B_M_TOV",  		        color = "B_M"     , pattern = "PATTERN_TOVERO", desc_center = "B_M_TOV"     },
{label = "SILVER BLACK TOVERO",  			                value = "BL_Z_TOV", 	            color = "BL_Z"    , pattern = "PATTERN_TOVERO", desc_center = "BL_Z_TOV"    },
{label = "SILVER BAY TOVERO",  				                value = "B_Z_TOV",  		        color = "B_Z"     , pattern = "PATTERN_TOVERO", desc_center = "B_Z_TOV"     },
{label = "SILVER SMOKEY BLACK TOVERO",  		            value = "BL_CR_Z_TOV",              color = "BL_CR_Z" , pattern = "PATTERN_TOVERO", desc_center = "BL_CR_Z_TOV" },
{label = "SILVER BUCKSKIN TOVERO",  			            value = "B_CR_Z_TOV",  	            color = "B_CR_Z"  , pattern = "PATTERN_TOVERO", desc_center = "B_CR_Z_TOV"  },
}

Config.MENU_HORSES_CUSTOMIZATION_GENE_SPLASHED_WHITE_SELECT_TITLE  = "Splashed White" 
Config.MENU_HORSES_CUSTOMIZATION_GENE_SPLASHED_WHITE_SELECT 		= { 
{label = "RED SPLASHED",  				 		            value = "R_SW",  		           color = "R" 	  	  , pattern = "PATTERN_SPLASHED", desc_center = "R_SW"       },
{label = "BLACK SPLASHED",  			 		            value = "BL_SW",  		           color = "BL" 	  , pattern = "PATTERN_SPLASHED", desc_center = "BL_SW"      },
{label = "BAY SPLASHED",  				 		            value = "B_SW",  		           color = "B"        , pattern = "PATTERN_SPLASHED", desc_center = "B_SW"       },
{label = "FLAXEN CHESTNUT SPLASHED",    		            value = "R_FLX_SW",  	           color = "R_FLX"    , pattern = "PATTERN_SPLASHED", desc_center = "R_FLX_SW"   },
{label = "PANGARE CHESTNUT SPLASHED",   		            value = "R_P_SW",  		           color = "R_P" 	  , pattern = "PATTERN_SPLASHED", desc_center = "R_P_SW"     },
{label = "PANGARE BAY SPLASHED", 		 		            value = "B_P_SW",  		           color = "B_P"      , pattern = "PATTERN_SPLASHED", desc_center = "B_P_SW"     },
{label = "PALOMINO SPLASHED",  		 		                value = "R_CR_SW",  	           color = "R_CR"     , pattern = "PATTERN_SPLASHED", desc_center = "R_CR_SW"    },
{label = "SMOKEY BLACK SPLASHED",  	 		                value = "BL_CR_SW",  	           color = "BL_CR"    , pattern = "PATTERN_SPLASHED", desc_center = "BL_CR_SW"   },
{label = "BUCKSKIN SPLASHED",  		 		                value = "B_CR_SW",  	           color = "B_CR"     , pattern = "PATTERN_SPLASHED", desc_center = "B_CR_SW"    },
{label = "CREMELLO SPLASHED",  		 		                value = "R_CR2_SW",  	           color = "R_CR2"    , pattern = "PATTERN_SPLASHED", desc_center = "R_CR2_SW"   },
{label = "SMOKEY CREAM SPLASHED",  	 		                value = "BL_CR2_SW",  	           color = "BL_CR2"   , pattern = "PATTERN_SPLASHED", desc_center = "BL_CR2_SW"  },
{label = "PERLINO SPLASHED",  			 		            value = "B_CR2_SW",  	           color = "B_CR2"    , pattern = "PATTERN_SPLASHED", desc_center = "B_CR2_SW"   },
{label = "GOLD CHAMPAGNE SPLASHED",  	 		            value = "R_CH_SW",  	           color = "R_CH"     , pattern = "PATTERN_SPLASHED", desc_center = "R_CH_SW"    },
{label = "CLASSIC CHAMPAGNE SPLASHED",  		            value = "BL_CH_SW",  	           color = "BL_CH"	  , pattern = "PATTERN_SPLASHED", desc_center = "BL_CH_SW"   },
{label = "AMBER CHAMPAGNE SPLASHED",  	 		            value = "B_CH_SW",  	           color = "B_CH"	  , pattern = "PATTERN_SPLASHED", desc_center = "B_CH_SW"    },
{label = "GOLD CREAM CHAMPAGNE SPLASHED",  	                value = "R_CR_CH_SW",              color = "R_CR_CH"  , pattern = "PATTERN_SPLASHED", desc_center = "R_CR_CH_SW" },
{label = "CLASSIC CREAM CHAMPAGNE SPLASHED",  	            value = "BL_CR_CH_SW",             color = "BL_CR_CH" , pattern = "PATTERN_SPLASHED", desc_center = "BL_CR_CH_SW"},
{label = "AMBER CREAM CHAMPAGNE SPLASHED",  	            value = "B_CR_CH_SW",              color = "B_CR_CH"  , pattern = "PATTERN_SPLASHED", desc_center = "B_CR_CH_SW" },
{label = "GREY SPLASHED",  					                value = "BL_G_SW",  	           color = "BL_G"     , pattern = "PATTERN_SPLASHED", desc_center = "BL_G_SW"    },
{label = "ROSE GREY SPLASHED",  				            value = "R_G_SW",  		           color = "R_G"      , pattern = "PATTERN_SPLASHED", desc_center = "R_G_SW"     },
{label = "DOMINANT WHITE SPLASHED",  			            value = "BL_DW_SW",  	           color = "BL_DW"    , pattern = "PATTERN_SPLASHED", desc_center = "BL_DW_SW"   },
{label = "RED MUSHROOM SPLASHED",  			                value = "R_M_SW",  		           color = "R_M"      , pattern = "PATTERN_SPLASHED", desc_center = "R_M_SW"     },
{label = "BAY MUSHROOM SPLASHED",  			                value = "B_M_SW",  		           color = "B_M"      , pattern = "PATTERN_SPLASHED", desc_center = "B_M_SW"     },
{label = "SILVER BLACK SPLASHED",  			                value = "BL_Z_SW", 	               color = "BL_Z"     , pattern = "PATTERN_SPLASHED", desc_center = "BL_Z_SW"    },
{label = "SILVER BAY SPLASHED",  				            value = "B_Z_SW",  		           color = "B_Z"      , pattern = "PATTERN_SPLASHED", desc_center = "B_Z_SW"     },
{label = "SILVER SMOKEY BLACK SPLASHED",  		            value = "BL_CR_Z_SW",              color = "BL_CR_Z"  , pattern = "PATTERN_SPLASHED", desc_center = "BL_CR_Z_SW" },
{label = "SILVER BUCKSKIN SPLASHED",  			            value = "B_CR_Z_SW",  	           color = "B_CR_Z"   , pattern = "PATTERN_SPLASHED", desc_center = "B_CR_Z_SW"  },
}

Config.MENU_HORSES_CUSTOMIZATION_GENE_RABICANO_SELECT_TITLE  = "Rabicano" 
Config.MENU_HORSES_CUSTOMIZATION_GENE_RABICANO_SELECT 		= { 
{label = "RED RABICANO",  				 		            value = "R_RB",  		           color = "R" 	  	  , pattern = "PATTERN_RABICANO", desc_center = "R_RB"       },
{label = "BLACK RABICANO",  			 		            value = "BL_RB",  		           color = "BL" 	  , pattern = "PATTERN_RABICANO", desc_center = "BL_RB"      },
{label = "BAY RABICANO",  				 		            value = "B_RB",  		           color = "B"        , pattern = "PATTERN_RABICANO", desc_center = "B_RB"       },
{label = "FLAXEN CHESTNUT RABICANO",    		            value = "R_FLX_RB",  	           color = "R_FLX"    , pattern = "PATTERN_RABICANO", desc_center = "R_FLX_RB"   },
{label = "PANGARE CHESTNUT RABICANO",   		            value = "R_P_RB",  		           color = "R_P" 	  , pattern = "PATTERN_RABICANO", desc_center = "R_P_RB"     },
{label = "PANGARE BAY RABICANO", 		 		            value = "B_P_RB",  		           color = "B_P"      , pattern = "PATTERN_RABICANO", desc_center = "B_P_RB"     },
{label = "PALOMINO RABICANO",  		 		                value = "R_CR_RB",  	           color = "R_CR"     , pattern = "PATTERN_RABICANO", desc_center = "R_CR_RB"    },
{label = "SMOKEY BLACK RABICANO",  	 		                value = "BL_CR_RB",  	           color = "BL_CR"    , pattern = "PATTERN_RABICANO", desc_center = "BL_CR_RB"   },
{label = "BUCKSKIN RABICANO",  		 		                value = "B_CR_RB",  	           color = "B_CR"     , pattern = "PATTERN_RABICANO", desc_center = "B_CR_RB"    },
{label = "CREMELLO RABICANO",  		 		                value = "R_CR2_RB",  	           color = "R_CR2"    , pattern = "PATTERN_RABICANO", desc_center = "R_CR2_RB"   },
{label = "SMOKEY CREAM RABICANO",  	 		                value = "BL_CR2_RB",  	           color = "BL_CR2"   , pattern = "PATTERN_RABICANO", desc_center = "BL_CR2_RB"  },
{label = "PERLINO RABICANO",  			 		            value = "B_CR2_RB",  	           color = "B_CR2"    , pattern = "PATTERN_RABICANO", desc_center = "B_CR2_RB"   },
{label = "GOLD CHAMPAGNE RABICANO",  	 		            value = "R_CH_RB",  	           color = "R_CH"     , pattern = "PATTERN_RABICANO", desc_center = "R_CH_RB"    },
{label = "CLASSIC CHAMPAGNE RABICANO",  		            value = "BL_CH_RB",  	           color = "BL_CH"	  , pattern = "PATTERN_RABICANO", desc_center = "BL_CH_RB"   },
{label = "AMBER CHAMPAGNE RABICANO",  	 		            value = "B_CH_RB",  	           color = "B_CH"	  , pattern = "PATTERN_RABICANO", desc_center = "B_CH_RB"    },
{label = "GOLD CREAM CHAMPAGNE RABICANO",  	                value = "R_CR_CH_RB",              color = "R_CR_CH"  , pattern = "PATTERN_RABICANO", desc_center = "R_CR_CH_RB" },
{label = "CLASSIC CREAM CHAMPAGNE RABICANO",  	            value = "BL_CR_CH_RB",             color = "BL_CR_CH" , pattern = "PATTERN_RABICANO", desc_center = "BL_CR_CH_RB"},
{label = "AMBER CREAM CHAMPAGNE RABICANO",  	            value = "B_CR_CH_RB",              color = "B_CR_CH"  , pattern = "PATTERN_RABICANO", desc_center = "B_CR_CH_RB" },
{label = "GREY RABICANO",  					                value = "BL_G_RB",  	           color = "BL_G"     , pattern = "PATTERN_RABICANO", desc_center = "BL_G_RB"    },
{label = "ROSE GREY RABICANO",  				            value = "R_G_RB",  		           color = "R_G"      , pattern = "PATTERN_RABICANO", desc_center = "R_G_RB"     },
{label = "DOMINANT WHITE RABICANO",  			            value = "BL_DW_RB",  	           color = "BL_DW"    , pattern = "PATTERN_RABICANO", desc_center = "BL_DW_RB"   },
{label = "RED MUSHROOM RABICANO",  			                value = "R_M_RB",  		           color = "R_M"      , pattern = "PATTERN_RABICANO", desc_center = "R_M_RB"     },
{label = "BAY MUSHROOM RABICANO",  			                value = "B_M_RB",  		           color = "B_M"      , pattern = "PATTERN_RABICANO", desc_center = "B_M_RB"     },
{label = "SILVER BLACK RABICANO",  			                value = "BL_Z_RB", 	               color = "BL_Z"     , pattern = "PATTERN_RABICANO", desc_center = "BL_Z_RB"    },
{label = "SILVER BAY RABICANO",  				            value = "B_Z_RB",  		           color = "B_Z"      , pattern = "PATTERN_RABICANO", desc_center = "B_Z_RB"     },
{label = "SILVER SMOKEY BLACK RABICANO",  		            value = "BL_CR_Z_RB",              color = "BL_CR_Z"  , pattern = "PATTERN_RABICANO", desc_center = "BL_CR_Z_RB" },
{label = "SILVER BUCKSKIN RABICANO",  			            value = "B_CR_Z_RB",  	           color = "B_CR_Z"   , pattern = "PATTERN_RABICANO", desc_center = "B_CR_Z_RB"  },
}
 
Config.MENU_HORSES_CUSTOMIZATION_GENE_BRINDLE_SELECT_TITLE  = "Brindle" 
Config.MENU_HORSES_CUSTOMIZATION_GENE_BRINDLE_SELECT 		= { 
{label = "RED BRINDLE",  				 		            value = "R_BR",  		           color = "R" 	  	  , pattern = "PATTERN_BRINDLE", desc_center = "R_BR"       },
{label = "BLACK BRINDLE",  			 		                value = "BL_BR",  		           color = "BL" 	  , pattern = "PATTERN_BRINDLE", desc_center = "BL_BR"      },
{label = "BAY BRINDLE",  				 		            value = "B_BR",  		           color = "B"        , pattern = "PATTERN_BRINDLE", desc_center = "B_BR"       },
{label = "FLAXEN CHESTNUT BRINDLE",    		                value = "R_FLX_BR",  	           color = "R_FLX"    , pattern = "PATTERN_BRINDLE", desc_center = "R_FLX_BR"   },
{label = "PANGARE CHESTNUT BRINDLE",   		                value = "R_P_BR",  		           color = "R_P" 	  , pattern = "PATTERN_BRINDLE", desc_center = "R_P_BR"     },
{label = "PANGARE BAY BRINDLE", 		 		            value = "B_P_BR",  		           color = "B_P"      , pattern = "PATTERN_BRINDLE", desc_center = "B_P_BR"     },
{label = "PALOMINO BRINDLE",  		 		                value = "R_CR_BR",  	           color = "R_CR"     , pattern = "PATTERN_BRINDLE", desc_center = "R_CR_BR"    },
{label = "SMOKEY BLACK BRINDLE",  	 		                value = "BL_CR_BR",  	           color = "BL_CR"    , pattern = "PATTERN_BRINDLE", desc_center = "BL_CR_BR"   },
{label = "BUCKSKIN BRINDLE",  		 		                value = "B_CR_BR",  	           color = "B_CR"     , pattern = "PATTERN_BRINDLE", desc_center = "B_CR_BR"    },
{label = "CREMELLO BRINDLE",  		 		                value = "R_CR2_BR",  	           color = "R_CR2"    , pattern = "PATTERN_BRINDLE", desc_center = "R_CR2_BR"   },
{label = "SMOKEY CREAM BRINDLE",  	 		                value = "BL_CR2_BR",  	           color = "BL_CR2"   , pattern = "PATTERN_BRINDLE", desc_center = "BL_CR2_BR"  },
{label = "PERLINO BRINDLE",  			 		            value = "B_CR2_BR",  	           color = "B_CR2"    , pattern = "PATTERN_BRINDLE", desc_center = "B_CR2_BR"   },
{label = "GOLD CHAMPAGNE BRINDLE",  	 		            value = "R_CH_BR",  	           color = "R_CH"     , pattern = "PATTERN_BRINDLE", desc_center = "R_CH_BR"    },
{label = "CLASSIC CHAMPAGNE BRINDLE",  		                value = "BL_CH_BR",  	           color = "BL_CH"	  , pattern = "PATTERN_BRINDLE", desc_center = "BL_CH_BR"   },
{label = "AMBER CHAMPAGNE BRINDLE",  	 		            value = "B_CH_BR",  	           color = "B_CH"	  , pattern = "PATTERN_BRINDLE", desc_center = "B_CH_BR"    },
{label = "GOLD CREAM CHAMPAGNE BRINDLE",  	                value = "R_CR_CH_BR",              color = "R_CR_CH"  , pattern = "PATTERN_BRINDLE", desc_center = "R_CR_CH_BR" },
{label = "CLASSIC CREAM CHAMPAGNE BRINDLE",  	            value = "BL_CR_CH_BR",             color = "BL_CR_CH" , pattern = "PATTERN_BRINDLE", desc_center = "BL_CR_CH_BR"},
{label = "AMBER CREAM CHAMPAGNE BRINDLE",  	                value = "B_CR_CH_BR",              color = "B_CR_CH"  , pattern = "PATTERN_BRINDLE", desc_center = "B_CR_CH_BR" },
{label = "GREY BRINDLE",  					                value = "BL_G_BR",  	           color = "BL_G"     , pattern = "PATTERN_BRINDLE", desc_center = "BL_G_BR"    },
{label = "ROSE GREY BRINDLE",  				                value = "R_G_BR",  		           color = "R_G"      , pattern = "PATTERN_BRINDLE", desc_center = "R_G_BR"     },
{label = "DOMINANT WHITE BRINDLE",  			            value = "BL_DW_BR",  	           color = "BL_DW"    , pattern = "PATTERN_BRINDLE", desc_center = "BL_DW_BR"   },
{label = "RED MUSHROOM BRINDLE",  			                value = "R_M_BR",  		           color = "R_M"      , pattern = "PATTERN_BRINDLE", desc_center = "R_M_BR"     },
{label = "BAY MUSHROOM BRINDLE",  			                value = "B_M_BR",  		           color = "B_M"      , pattern = "PATTERN_BRINDLE", desc_center = "B_M_BR"     },
{label = "SILVER BLACK BRINDLE",  			                value = "BL_Z_BR", 	               color = "BL_Z"     , pattern = "PATTERN_BRINDLE", desc_center = "BL_Z_BR"    },
{label = "SILVER BAY BRINDLE",  				            value = "B_Z_BR",  		           color = "B_Z"      , pattern = "PATTERN_BRINDLE", desc_center = "B_Z_BR"     },
{label = "SILVER SMOKEY BLACK BRINDLE",  		            value = "BL_CR_Z_BR",              color = "BL_CR_Z"  , pattern = "PATTERN_BRINDLE", desc_center = "BL_CR_Z_BR" },
{label = "SILVER BUCKSKIN BRINDLE",  			            value = "B_CR_Z_BR",  	           color = "B_CR_Z"   , pattern = "PATTERN_BRINDLE", desc_center = "B_CR_Z_BR"  },
}

Config.MENU_HORSES_CUSTOMIZATION_GENE_DUN_SELECT_TITLE  = "Dun" 
Config.MENU_HORSES_CUSTOMIZATION_GENE_DUN_SELECT 		= { 
{label = "RED DUN",  				 		            value = "R_D",  		           color = "R" 	  	  , pattern = "PATTERN_DUN", desc_center = "R_D"       },
{label = "BLACK DUN",  			 		                value = "BL_D",  		           color = "BL" 	  , pattern = "PATTERN_DUN", desc_center = "BL_D"      },
{label = "BAY DUN",  				 		            value = "B_D",  		           color = "B"        , pattern = "PATTERN_DUN", desc_center = "B_D"       },
{label = "FLAXEN CHESTNUT DUN",    		                value = "R_FLX_D",  	           color = "R_FLX"    , pattern = "PATTERN_DUN", desc_center = "R_FLX_D"   },
{label = "PANGARE CHESTNUT DUN",   		                value = "R_P_D",  		           color = "R_P" 	  , pattern = "PATTERN_DUN", desc_center = "R_P_D"     },
{label = "PANGARE BAY DUN", 		 		            value = "B_P_D",  		           color = "B_P"      , pattern = "PATTERN_DUN", desc_center = "B_P_D"     },
{label = "PALOMINO DUN",  		 		                value = "R_CR_D",  	               color = "R_CR"     , pattern = "PATTERN_DUN", desc_center = "R_CR_D"    },
{label = "SMOKEY BLACK DUN",  	 		                value = "BL_CR_D",  	           color = "BL_CR"    , pattern = "PATTERN_DUN", desc_center = "BL_CR_D"   },
{label = "BUCKSKIN DUN",  		 		                value = "B_CR_D",  	               color = "B_CR"     , pattern = "PATTERN_DUN", desc_center = "B_CR_D"    },
{label = "CREMELLO DUN",  		 		                value = "R_CR2_D",  	           color = "R_CR2"    , pattern = "PATTERN_DUN", desc_center = "R_CR2_D"   },
{label = "SMOKEY CREAM DUN",  	 		                value = "BL_CR2_D",  	           color = "BL_CR2"   , pattern = "PATTERN_DUN", desc_center = "BL_CR2_D"  },
{label = "PERLINO DUN",  			 		            value = "B_CR2_D",  	           color = "B_CR2"    , pattern = "PATTERN_DUN", desc_center = "B_CR2_D"   },
{label = "GOLD CHAMPAGNE DUN",  	 		            value = "R_CH_D",  	               color = "R_CH"     , pattern = "PATTERN_DUN", desc_center = "R_CH_D"    },
{label = "CLASSIC CHAMPAGNE DUN",  		                value = "BL_CH_D",  	           color = "BL_CH"	  , pattern = "PATTERN_DUN", desc_center = "BL_CH_D"   },
{label = "AMBER CHAMPAGNE DUN",  	 		            value = "B_CH_D",  	               color = "B_CH"	  , pattern = "PATTERN_DUN", desc_center = "B_CH_D"    },
{label = "GOLD CREAM CHAMPAGNE DUN",  	                value = "R_CR_CH_D",               color = "R_CR_CH"  , pattern = "PATTERN_DUN", desc_center = "R_CR_CH_D" },
{label = "CLASSIC CREAM CHAMPAGNE DUN",  	            value = "BL_CR_CH_D",              color = "BL_CR_CH" , pattern = "PATTERN_DUN", desc_center = "BL_CR_CH_D"},
{label = "AMBER CREAM CHAMPAGNE DUN",  	                value = "B_CR_CH_D",               color = "B_CR_CH"  , pattern = "PATTERN_DUN", desc_center = "B_CR_CH_D" },
{label = "GREY DUN",  					                value = "BL_G_D",  	               color = "BL_G"     , pattern = "PATTERN_DUN", desc_center = "BL_G_D"    },
{label = "ROSE GREY DUN",  				                value = "R_G_D",  		           color = "R_G"      , pattern = "PATTERN_DUN", desc_center = "R_G_D"     },
{label = "DOMINANT WHITE DUN",  			            value = "BL_DW_D",  	           color = "BL_DW"    , pattern = "PATTERN_DUN", desc_center = "BL_DW_D"   },
{label = "RED MUSHROOM DUN",  			                value = "R_M_D",  		           color = "R_M"      , pattern = "PATTERN_DUN", desc_center = "R_M_D"     },
{label = "BAY MUSHROOM DUN",  			                value = "B_M_D",  		           color = "B_M"      , pattern = "PATTERN_DUN", desc_center = "B_M_D"     },
{label = "SILVER BLACK DUN",  			                value = "BL_Z_D", 	               color = "BL_Z"     , pattern = "PATTERN_DUN", desc_center = "BL_Z_D"    },
{label = "SILVER BAY DUN",  				            value = "B_Z_D",  		           color = "B_Z"      , pattern = "PATTERN_DUN", desc_center = "B_Z_D"     },
{label = "SILVER SMOKEY BLACK DUN",  		            value = "BL_CR_Z_D",               color = "BL_CR_Z"  , pattern = "PATTERN_DUN", desc_center = "BL_CR_Z_D" },
{label = "SILVER BUCKSKIN DUN",  			            value = "B_CR_Z_D",  	           color = "B_CR_Z"   , pattern = "PATTERN_DUN", desc_center = "B_CR_Z_D"  },
}

Config.MENU_HORSES_CUSTOMIZATION_GENE_ROAN_SELECT_TITLE  = "Roan" 
Config.MENU_HORSES_CUSTOMIZATION_GENE_ROAN_SELECT 		= { 
{label = "RED ROAN",  				 		            value = "R_RN",  		               color = "R" 	  	  , pattern = "PATTERN_ROAN", desc_center = "R_RN"       },
{label = "BLACK ROAN",  			 		            value = "BL_RN",  		               color = "BL" 	  , pattern = "PATTERN_ROAN", desc_center = "BL_RN"      },
{label = "BAY ROAN",  				 		            value = "B_RN",  		               color = "B"        , pattern = "PATTERN_ROAN", desc_center = "B_RN"       },
{label = "FLAXEN CHESTNUT ROAN",    		            value = "R_FLX_RN",  	               color = "R_FLX"    , pattern = "PATTERN_ROAN", desc_center = "R_FLX_RN"   },
{label = "PANGARE CHESTNUT ROAN",   		            value = "R_P_RN",  		               color = "R_P" 	  , pattern = "PATTERN_ROAN", desc_center = "R_P_RN"     },
{label = "PANGARE BAY ROAN", 		 		            value = "B_P_RN",  		               color = "B_P"      , pattern = "PATTERN_ROAN", desc_center = "B_P_RN"     },
{label = "PALOMINO ROAN",  		 		                value = "R_CR_RN",  	               color = "R_CR"     , pattern = "PATTERN_ROAN", desc_center = "R_CR_RN"    },
{label = "SMOKEY BLACK ROAN",  	 		                value = "BL_CR_RN",  	               color = "BL_CR"    , pattern = "PATTERN_ROAN", desc_center = "BL_CR_RN"   },
{label = "BUCKSKIN ROAN",  		 		                value = "B_CR_RN",  	               color = "B_CR"     , pattern = "PATTERN_ROAN", desc_center = "B_CR_RN"    },
{label = "CREMELLO ROAN",  		 		                value = "R_CR2_RN",  	               color = "R_CR2"    , pattern = "PATTERN_ROAN", desc_center = "R_CR2_RN"   },
{label = "SMOKEY CREAM ROAN",  	 		                value = "BL_CR2_RN",  	               color = "BL_CR2"   , pattern = "PATTERN_ROAN", desc_center = "BL_CR2_RN"  },
{label = "PERLINO ROAN",  			 		            value = "B_CR2_RN",  	               color = "B_CR2"    , pattern = "PATTERN_ROAN", desc_center = "B_CR2_RN"   },
{label = "GOLD CHAMPAGNE ROAN",  	 		            value = "R_CH_RN",  	               color = "R_CH"     , pattern = "PATTERN_ROAN", desc_center = "R_CH_RN"    },
{label = "CLASSIC CHAMPAGNE ROAN",  		            value = "BL_CH_RN",  	               color = "BL_CH"	  , pattern = "PATTERN_ROAN", desc_center = "BL_CH_RN"   },
{label = "AMBER CHAMPAGNE ROAN",  	 		            value = "B_CH_RN",  	               color = "B_CH"	  , pattern = "PATTERN_ROAN", desc_center = "B_CH_RN"    },
{label = "GOLD CREAM CHAMPAGNE ROAN",  	                value = "R_CR_CH_RN",                  color = "R_CR_CH"  , pattern = "PATTERN_ROAN", desc_center = "R_CR_CH_RN" },
{label = "CLASSIC CREAM CHAMPAGNE ROAN",  	            value = "BL_CR_CH_RN",                 color = "BL_CR_CH" , pattern = "PATTERN_ROAN", desc_center = "BL_CR_CH_RN"},
{label = "AMBER CREAM CHAMPAGNE ROAN",  	            value = "B_CR_CH_RN",                  color = "B_CR_CH"  , pattern = "PATTERN_ROAN", desc_center = "B_CR_CH_RN" },
{label = "GREY ROAN",  					                value = "BL_G_RN",  	               color = "BL_G"     , pattern = "PATTERN_ROAN", desc_center = "BL_G_RN"    },
{label = "ROSE GREY ROAN",  				            value = "R_G_RN",  		               color = "R_G"      , pattern = "PATTERN_ROAN", desc_center = "R_G_RN"     },
{label = "DOMINANT WHITE ROAN",  			            value = "BL_DW_RN",  	               color = "BL_DW"    , pattern = "PATTERN_ROAN", desc_center = "BL_DW_RN"   },
{label = "RED MUSHROOM ROAN",  			                value = "R_M_RN",  		               color = "R_M"      , pattern = "PATTERN_ROAN", desc_center = "R_M_RN"     },
{label = "BAY MUSHROOM ROAN",  			                value = "B_M_RN",  		               color = "B_M"      , pattern = "PATTERN_ROAN", desc_center = "B_M_RN"     },
{label = "SILVER BLACK ROAN",  			                value = "BL_Z_RN", 	                   color = "BL_Z"     , pattern = "PATTERN_ROAN", desc_center = "BL_Z_RN"    },
{label = "SILVER BAY ROAN",  				            value = "B_Z_RN",  		               color = "B_Z"      , pattern = "PATTERN_ROAN", desc_center = "B_Z_RN"     },
{label = "SILVER SMOKEY BLACK ROAN",  		            value = "BL_CR_Z_RN",                  color = "BL_CR_Z"  , pattern = "PATTERN_ROAN", desc_center = "BL_CR_Z_RN" },
{label = "SILVER BUCKSKIN ROAN",  			            value = "B_CR_Z_RN",  	               color = "B_CR_Z"   , pattern = "PATTERN_ROAN", desc_center = "B_CR_Z_RN"  },
}
 
--------------------
--------------------

-- /!\ ONLY EFFECTIVE IF OWNING SIREVLC_BREEDING /!\
Config.MENU_BREEDING_MAIN_TITLE  = "<p><span style='color:gold;'>BREEDING</span>" 
Config.MENU_BREEDING_MAIN 		 = {
 	{label = "Create",     			value = "CREATE",     desc = "Breed two horses together !",   					 				 image = 'items/breeding_create_icon.png'},
 	{label = "Manage",     			value = "MANAGE",     desc = "Access your current breeding",  					 				 image = 'items/horse_breeding_manage_icon.png'},
 	{label = "Check cooldown",      value = "CHECK",      desc = "Display the cooldown time for your foals that aren't born yet",  	 image = 'items/provision_folder_watches.png'},
 }
 
 
Config.MENU_BREEDING_CONFIRM_TITLE   		= "<p><span style='color:gold;'>Confirm Breeding</span>" 
Config.MENU_BREEDING_SELECT_STALLION 		= "SELECT STALLION" 
Config.MENU_BREEDING_SELECT_MARE     		= "SELECT MARE" 
Config.MENU_BREEDING_SELECT_MARE_SUB        = "Select a Mare to complete the breeding process" 
Config.MENU_BREEDING_SELECTED_STALLION_SUB  = "Select a stallion first to begin the breeding process" 
  
Config.MENU_BREEDING_CONFIRM 		= {
 	{label = "Yes",     value = "YES",     desc = "This will confirm the horse breeding process" },
 	{label = "No",      value = "NO",      desc = "This will cancel the horse breeding process"  },
}
 
Config.MENU_TEXT_CUSTOMIZATION_GENDER 	 			= "Gender"   
Config.MENU_TEXT_CUSTOMIZATION_FEATHER   			= "Feather"      
Config.MENU_TEXT_CUSTOMIZATION_MUSTACHE 			= "Mustache"    
Config.MENU_TEXT_CUSTOMIZATION_EYELASHES 			= "Eyelashes"    
Config.MENU_TEXT_CUSTOMIZATION_SCALE 	 			= "Scale"    
Config.MENU_TEXT_CUSTOMIZATION_REMOVE_TACK   	    = "Remove Tack"    
Config.MENU_TEXT_CUSTOMIZATION_REMOVE_TACK_DESC     = "Remove the tack this horse is currently wearing from this category"    
 
Config.MENU_TEXT_CUSTOMIZATION_TYPE_EYES 	  		= "Eyes Type"
Config.MENU_TEXT_CUSTOMIZATION_TYPE_HEAD 	  		= "Head Pattern"
Config.MENU_TEXT_CUSTOMIZATION_TYPE_COAT 	  		= "Coat Pattern"
Config.MENU_TEXT_CUSTOMIZATION_TYPE_MANE 	  		= "Mane Type"
Config.MENU_TEXT_CUSTOMIZATION_TYPE_TAIL 	  		= "Tail Type"
Config.MENU_TEXT_CUSTOMIZATION_TYPE_MUSTACHE 		= "Mustache Type"
Config.MENU_TEXT_CUSTOMIZATION_TYPE_FEATHER 		= "Feather Type"

Config.MENU_TEXT_CUSTOMIZATION_TEXTURE  		    = "Texture"
Config.MENU_TEXT_CUSTOMIZATION_PALETTE  		    = "Palette"
Config.MENU_TEXT_CUSTOMIZATION_TINTA 			    = "Tint A"
Config.MENU_TEXT_CUSTOMIZATION_TINTB 			    = "Tint B"
Config.MENU_TEXT_CUSTOMIZATION_TINTC 			    = "Tint C"
Config.MENU_TEXT_CUSTOMIZATION_CONFIRM			    = "Confirm"

Config.MENU_TEXT_CUSTOMIZATION_DESCRIPTION_TYPE 	= "Type"
Config.MENU_TEXT_CUSTOMIZATION_DESCRIPTION_TEXTURE  = "Texture"
Config.MENU_TEXT_CUSTOMIZATION_DESCRIPTION_TINTA 	= "Tint A"
Config.MENU_TEXT_CUSTOMIZATION_DESCRIPTION_TINTB 	= "Tint B"
Config.MENU_TEXT_CUSTOMIZATION_DESCRIPTION_TINTC 	= "Tint C"
Config.MENU_TEXT_CUSTOMIZATION_DESCRIPTION_SCALE	= "Select your horse Scale" 

  
Config.MENU_TEXT_HORSE_DELETED               		= "You deleted your horse"   
Config.MENU_TEXT_HORSE_GELD_SPAY             		= "Geld / Spay"   
Config.MENU_TEXT_HORSE_NEUTERING             		= "Neutering"   
Config.MENU_TEXT_HORSE_NEUTERING_DESC        		= "Horses that are neutered can't be used in the breeding process"   
Config.MENU_TEXT_HORSE_RENAME_LABEL          		= "Rename your horse"   
Config.MENU_TEXT_HORSE_RENAME_TITLE          		= "Horse Rename"   
Config.MENU_TEXT_HORSE_CUSTOM_TITLE    	     		= "Custom title"   
Config.MENU_TEXT_HORSE_SET_CUSTOM_TITLE      		= "Set Custom title"   
Config.MENU_TEXT_HORSE_AVAILABLE_PRESETS     		= "Available presets"   
Config.MENU_TEXT_HORSE_CONFIRM_DESC  		 		= "Confirm your choice"   
Config.MENU_TEXT_HORSE_DELETED  			 		= "Your horse has been deleted"   

Config.MENU_TEXT_CUSTOMIZATION_DESCRIPTION_PALETTE  = "Palette"
Config.MENU_TEXT_HORSE_BREEDING_PRICE       		= "Breeding Price"
Config.MENU_TEXT_HORSE_BREEDING_COOLDOWN_TITLE  	= "Breeding Cooldown"
Config.MENU_TEXT_HORSE_BREEDING_COOLDOWN  			= "Time Remaining: "
Config.MENU_TEXT_HORSE_NEW_GENOTYPE					= "New genotype applied: "
 