Config = {}

 
-- VERSION 4.13 - 18.03.26
 
--------------------------------------------------

			-- FRAMEWORK SELECTION --
			
-------------------------------------------------- 

-- TURN YOUR FRAMEWORK TO TRUE AND ALL THE OTHERS TO FALSE

Config.REDEMRP2          				 = false
Config.REDEMRP2023REBOOT 				 = false
Config.VORP              				 = false
Config.RSG               				 = true
 
Config.EnableEagleEye 					 = true  -- Enable Eagle eye to see the clues 
Config.EnableRunningEagleEye             = true  -- Enable Eagle while running

Config.CooldownEnabled                   = true  -- Enable / Disable the cooldown after every mission completed and every mission failed
Config.CooldownTimer                     = 4     -- In minutes Cooldown after every mission before you can do another one / 1 min minimum
 
--------------------------------------------------

			-- GENERAL OPTIONS --
			
-------------------------------------------------- 
 
Config.HERB_SPAWN_LIMIT                  = 120 	 -- THIS WILL LIMIT THE MAX NUMBER OF HERBS THAT CAN SPAWN IN THE AREA
 
Config.Debug 							 = false  -- This will display debug prints / only use if you encounter an issue
Config.Sirevlc_Horses_Is_Used            = true   -- Turn this to true if you're using sirevlc_horses

Config.TextHerbNotif 			   		 = "Herbs" 
Config.TextHerbNotifCantGatherMore 		 = "You can't gather more of this herb" 
Config.EnableGoldCurrencyNotifications   = true  -- ONLY FOR VORP  
 
--Config.DeleteDistance must be superior to Config.SpawnDistance !!
Config.DeleteDistance     				 = 90.0  -- If the player distance to any herb zone coords is > 160.0 then it will remove the herbs from the previous zone. I recommend not going over 200 since it's reaching the culling zone limit
Config.SpawnDistance      				 = 80.0  -- If the player distance to any herb zone coords is < 150.0 this will spawn the herbs.
Config.RoleRestriction    				 = false  -- ENABLE / DISABLE ROLES RESTRICTION FOR ALLOWING TO ACCESS HERBS SHOPS AND MISSIONS  
Config.Roles = { -- LIST THE ROLES ALLOWED TO GATHER AND ACCESS HERBS SHOPS
"trapper",
}
 
------------------
-- COMMANDS --
------------------
Config.Herbalist_Map_Command 		 = true  -- If set to true this will enable the herbalist compendium menu to display through this command. 
Config.Herbalist_Map_Command_Name 	 = "herbalist_map"
Config.Herbalist_Saddle_Command 	 = true 
Config.Herbalist_Saddle_Command_Name = "herbalistsaddle" 

-- LIST OF USABLE EVENTS :
--TriggerEvent("sirevlc_herbs_display_map")
--TriggerEvent("sirevlc_Herbalist_Saddle")

------------------
-- TRANSLATIONS --
------------------ 
Config.NoSellableHerbs             		 = "No sellable herbs" 
Config.DontHaveAllHerbsCollection  		 = "You don't have all the herbs from the collection" 
Config.NoSellableHerbsDesc         		 = "No sellable herbs detected"
Config.OwnedHerbs                  		 = "Owned Herbs"
Config.NoRole                      		 = "You dont have the right role"
Config.HerbsOpenMenuPromptTitleSub 		 = "Herbs Shop"
Config.SellAll                     		 = "Sell all"
Config.SellAllDesc                 		 = "Sell all herbs you have from your inventory"
Config.SellOne                     		 = "Sell one"
Config.SellOneDesc                 		 = "Sell only one herb from your inventory"
	
Config.StillCooldown                 	 = "You are still in cooldown"
 
Config.MissionObjective            		 = "Get to the zone and find the ~COLOR_GOLD~collectible herb"
Config.MissionObjective2           		 = "Find the ~COLOR_GOLD~herb~COLOR_WHITE~ in the area" 
Config.EmptyImage                  		 = "provision_wldflwr_agarita"

--------------------
-- HERBS TO SELL --
--------------------
-- THIS IS USED FOR THE HERBALIST SHOP 
Config.HerbsToSell = {
[1]  = {item ="provision_wldflwr_agarita", 		    	label ="Agarita", 				texturedict = "inventory_items_mp", 	image ="provision_wldflwr_agarita", 			dollarprice = 20.0, goldprice = 0.0, xp = 15},
[2]  = {item ="consumable_herb_alaskan_ginseng",    	label ="Alaskan Ginseng", 		texturedict = "INVENTORY_ITEMS", 		image ="consumable_herb_alaskan_ginseng", 		dollarprice = 2.0,  goldprice = 0.0, xp = 1},	 
[3]  = {item ="consumable_herb_american_ginseng",   	label ="American Ginseng", 		texturedict = "INVENTORY_ITEMS", 		image ="consumable_herb_american_ginseng", 		dollarprice = 2.0,  goldprice = 0.0, xp = 1},
[4]  = {item ="consumable_herb_bay_bolete", 			label ="Bay Bolete", 			texturedict = "INVENTORY_ITEMS", 		image ="consumable_herb_bay_bolete", 			dollarprice = 2.0,  goldprice = 0.0, xp = 1},
[5]  = {item ="provision_wldflwr_bitterweed", 			label ="Bitterweed", 			texturedict = "inventory_items_mp", 	image ="provision_wldflwr_bitterweed", 			dollarprice = 25.0, goldprice = 0.0, xp = 15},
[6]  = {item ="consumable_herb_black_berry", 			label ="Blackberry", 			texturedict = "INVENTORY_ITEMS", 		image ="consumable_herb_black_berry", 			dollarprice = 2.0,  goldprice = 0.0, xp = 1},
[7]  = {item ="consumable_herb_black_currant", 			label ="Black Currant",			texturedict = "INVENTORY_ITEMS", 		image ="consumable_herb_black_currant", 		dollarprice = 2.0,  goldprice = 0.0, xp = 1},
[8]  = {item ="provision_wldflwr_blood_flower",			label ="Blood flower",			texturedict = "inventory_items_mp", 	image ="provision_wldflwr_blood_flower", 		dollarprice = 30.0, goldprice = 0.0, xp = 15},
[9]  = {item ="consumable_herb_burdock_root", 			label ="Burdock Root", 			texturedict = "INVENTORY_ITEMS", 		image ="consumable_herb_burdock_root", 			dollarprice = 2.0,  goldprice = 0.0, xp = 1},
[10] = {item ="provision_wldflwr_cardinal_flower", 		label ="Cardinal Flower",   	texturedict = "inventory_items_mp", 	image ="provision_wldflwr_cardinal_flower", 	dollarprice = 20.0, goldprice = 0.0, xp = 15},
[11] = {item ="consumable_herb_chanterelles", 			label ="Chanterelles", 			texturedict = "INVENTORY_ITEMS", 		image ="consumable_herb_chanterelles",			dollarprice = 2.0,  goldprice = 0.0, xp = 1},
[12] = {item ="provision_wldflwr_chocolate_daisy",  	label ="Chocolate Daisy",   	texturedict = "inventory_items_mp", 	image ="provision_wldflwr_chocolate_daisy", 	dollarprice = 17.0, goldprice = 0.0, xp = 15},
[13] = {item ="consumable_herb_common_bulrush", 		label ="Common Bulrush", 		texturedict = "INVENTORY_ITEMS", 		image ="consumable_herb_common_bulrush", 		dollarprice = 2.0,  goldprice = 0.0, xp = 1},
[14] = {item ="provision_wldflwr_creek_plum", 			label ="Creek Plum", 			texturedict = "inventory_items_mp",     image ="provision_wldflwr_creek_plum", 			dollarprice = 22.0, goldprice = 0.0, xp = 15},
[15] = {item ="consumable_herb_creeping_thyme", 		label ="Creeping Thyme", 		texturedict = "INVENTORY_ITEMS", 		image ="consumable_herb_creeping_thyme", 		dollarprice = 2.0,  goldprice = 0.0, xp = 1},
[16] = {item ="consumable_herb_desert_sage", 			label ="Desert Sage", 		    texturedict = "INVENTORY_ITEMS", 		image ="consumable_herb_desert_sage",  			dollarprice = 2.0,  goldprice = 0.0, xp = 1},
[17] = {item ="consumable_herb_english_mace", 			label ="English Mace", 			texturedict = "INVENTORY_ITEMS", 		image ="consumable_herb_english_mace", 			dollarprice = 2.0,  goldprice = 0.0, xp = 1},
[18] = {item ="consumable_herb_evergreen_huckleberry",  label ="Evergreen Huckleberry", texturedict = "INVENTORY_ITEMS", 		image ="consumable_herb_evergreen_huckleberry", dollarprice = 2.0,  goldprice = 0.0, xp = 1},
[19] = {item ="consumable_herb_golden_currant",			label ="Golden Currant", 		texturedict = "INVENTORY_ITEMS", 		image ="consumable_herb_golden_currant", 		dollarprice = 2.0,  goldprice = 0.0, xp = 1},
[20] = {item ="consumable_herb_harrietum", 				label ="Harrietum Officinalis", texturedict = "inventory_items_mp", 	image ="consumable_herb_harrietum", 			dollarprice = 2.0,  goldprice = 0.0, xp = 1},
[21] = {item ="consumable_herb_hummingbird_sage", 		label ="Hummingbird Sage", 		texturedict = "INVENTORY_ITEMS", 		image ="consumable_herb_hummingbird_sage", 		dollarprice = 2.0,  goldprice = 0.0, xp = 1},
[22] = {item ="consumable_herb_indian_tobacco", 		label ="Indian Tobacco", 		texturedict = "INVENTORY_ITEMS", 		image ="consumable_herb_indian_tobacco", 		dollarprice = 2.0,  goldprice = 0.0, xp = 1},
[23] = {item ="consumable_herb_milkweed", 				label ="Milkweed", 				texturedict = "INVENTORY_ITEMS", 		image ="consumable_herb_milkweed", 				dollarprice = 2.0,  goldprice = 0.0, xp = 1},
[24] = {item ="consumable_herb_oleander_sage", 			label ="Oleander Sage", 		texturedict = "INVENTORY_ITEMS", 		image ="consumable_herb_oleander_sage", 		dollarprice = 2.0,  goldprice = 0.0, xp = 1},
[25] = {item ="consumable_herb_oregano", 				label ="Oregano", 				texturedict = "INVENTORY_ITEMS", 		image ="consumable_herb_oregano", 				dollarprice = 2.0,  goldprice = 0.0, xp = 1},
[26] = {item ="consumable_herb_parasol_mushroom",		label ="Parasol Mushroom", 		texturedict = "INVENTORY_ITEMS", 		image ="consumable_herb_parasol_mushroom", 		dollarprice = 2.0,  goldprice = 0.0, xp = 1},
[27] = {item ="consumable_herb_prairie_poppy", 			label ="Prairie Poppy", 		texturedict = "INVENTORY_ITEMS", 		image ="consumable_herb_prairie_poppy", 		dollarprice = 2.0,  goldprice = 0.0, xp = 1},
[28] = {item ="consumable_herb_rams_head", 				label ="Ram's Head",			texturedict = "INVENTORY_ITEMS", 		image ="consumable_herb_rams_head", 			dollarprice = 2.0,  goldprice = 0.0, xp = 1},
[29] = {item ="consumable_herb_red_raspberry", 			label ="Red Raspberry",			texturedict = "INVENTORY_ITEMS", 		image ="consumable_herb_red_raspberry", 		dollarprice = 2.0,  goldprice = 0.0, xp = 1},
[30] = {item ="consumable_herb_red_sage", 				label ="Red Sage", 				texturedict = "INVENTORY_ITEMS", 		image ="consumable_herb_red_sage", 				dollarprice = 2.0,  goldprice = 0.0, xp = 1},
[31] = {item ="provision_wldflwr_texas_blue_bonnet", 	label ="Texas Blue Bonnet", 	texturedict = "inventory_items_mp", 	image ="provision_wldflwr_texas_blue_bonnet", 	dollarprice = 27.0, goldprice = 0.0, xp = 15},
[32] = {item ="consumable_herb_violet_snowdrop", 		label ="Violet Snowdrop", 		texturedict = "INVENTORY_ITEMS", 		image ="consumable_herb_violet_snowdrop", 		dollarprice = 2.0,  goldprice = 0.0, xp = 1},
[33] = {item ="consumable_herb_wild_carrots", 			label ="Wild Carrot", 			texturedict = "INVENTORY_ITEMS", 		image ="consumable_herb_wild_carrots",  		dollarprice = 2.0,  goldprice = 0.0, xp = 1},
[34] = {item ="consumable_herb_wild_feverfew", 			label ="Wild Feverfew", 		texturedict = "INVENTORY_ITEMS", 		image ="consumable_herb_wild_feverfew", 		dollarprice = 2.0,  goldprice = 0.0, xp = 1},
[35] = {item ="consumable_herb_wild_mint", 				label ="Wild Mint", 			texturedict = "INVENTORY_ITEMS", 		image ="consumable_herb_wild_mint", 			dollarprice = 2.0,  goldprice = 0.0, xp = 1},
[36] = {item ="provision_wldflwr_wild_rhubarb", 		label ="Wild Rhubarb", 			texturedict = "inventory_items_mp", 	image ="provision_wldflwr_wild_rhubarb", 		dollarprice = 30.0, goldprice = 0.0, xp = 15},
[37] = {item ="consumable_herb_wintergreen_berry", 		label ="Wintergreen Berry",		texturedict = "INVENTORY_ITEMS", 		image ="consumable_herb_wintergreen_berry", 	dollarprice = 2.0,  goldprice = 0.0, xp = 1},
[38] = {item ="provision_wldflwr_wisteria", 			label ="Wisteria",  			texturedict = "inventory_items_mp",	    image ="provision_wldflwr_wisteria", 			dollarprice = 28.0, goldprice = 0.0, xp = 15},
[39] = {item ="consumable_herb_yarrow", 				label ="Yarrow", 				texturedict = "INVENTORY_ITEMS", 		image ="consumable_herb_yarrow", 	 			dollarprice = 2.0,  goldprice = 0.0, xp = 1},
}  
 
 
--------------------
	-- MAIN MENU --
-------------------- 
--HERE YOU CAN CHANGE THE LABEL, DESC AND IMAGE
Config.TextNotifGoldSign = "Gold"
Config.MainMenu = {
[1]  = {label = "Sell Herbs",       value = "action01", desc = "Select which herb you want to sell"          ,		   image = "items/consumable_herb_indian_tobacco.png" },
[2]  = {label = "Express Sell",     value = "action02", desc = "Sell All herbs you have in your inventory"   ,		   image = "items/provision_shop_sell.png" },
[3]  = {label = "Sell collections", value = "action03", desc = "Sell herbs as a whole set", 				  		   image = "items/provision_wldflwr_set.png" },
[4]  = {label = "Start mission",    value = "action04", desc = "Start a mission to get some special herbs", 		   image = "items/upgrade_pouch_loot.png" },
[5]  = {label = "Check XP",   	    value = "action05", desc = "Check your current role xp", 		 				   image = "items/generic_season_skill.png" },
}                                                                                                                       
 
-----------------------------
-- **LIST OF EATING EFFECTS**
-----------------------------
-- "none"
-- "vomit"
-- "hallucinations" 

-- list of triggerable events : 
-- TriggerEvent('sirevlc_herbs_effect',"vomit") 
-- TriggerEvent('sirevlc_herbs_effect',"hallucinations") 
-- TriggerEvent('sirevlc_herbs_effect',"boost",health int, stamina float) 
-- TriggerEvent('sirevlc_herbs_effect',"extraboost",health int, stamina float) 
 
-------------------------------
	-- MISSIONS HERBS  -- 
-------------------------------
-- THESE ARE THE HERBS THAT YOU WILL GET BY STARTING A MISSION AT THE HERBALIST 
 
Config.MissionStartedTitle = "Mission Started"
Config.MissionHerbalist    = "Herbalist" 
 
Config.Missions_herbs = {
 	[1] = {
 		herb 		     = "COMPOSITE_LOOTABLE_AGARITA_DEF", -- COMPOSITE USED 
 		CompositeID      = -834461873, -- COMPOSITE ID 
        Label            = "Agarita",  -- LABEL / YOU CAN EDIT IT 
 		StartingDistrict = {"all"},	   -- THIS MISSION WILL BE AVALAIBLE IF STARTED FROM CERTAIN DISTRICT. IF SET TO "all" THE MISSION CAN BE STARTED FROM ALL DISTRICTS.
 	    EatHealthAdd     = 20,				
 	    EatStaminaAdd    = 20.0, -- FLOAT
 	    EatHealthBoost   = 0.0,  -- FLOAT
 	    EatStaminaBoost  = 0.0,  -- FLOAT
 	    Effect 			 = "none", -- SEE THE EATING EFFECT LIST ABOVE 
 			 coords = {
   				 {-1805.8369140625, -2835.743408203125, 15.06635951995849  ,60.0, 20.0}, --{X ,Y, Z, SPAWN DISTANCE, BLIP ZONE RADIUS}
  				 {-2451.9716796875, -2848.07373046875, 70.99944305419922   ,60.0, 20.0},
  				 {-3387.46240234375, -2885.2109375, -4.70879554748535      ,60.0, 20.0},
  				 {-3659.58203125, -1844.745849609375, 41.42263412475586    ,60.0, 20.0},
 				 {-4296.953125, -2227.775634765625, 29.01308441162109      ,60.0, 20.0},
 				 {-5422.09912109375, -2452.216796875, -1.3701673746109     ,60.0, 20.0},
 				 {-5745.15185546875, -3381.433349609375, -21.92086601257324,60.0, 20.0},
 				 {-5314.3515625, -3999.313232421875, -9.16192722320556     ,60.0, 20.0},
 				 {-4405.55029296875, -3875.29736328125, -24.10308456420898 ,60.0, 20.0},
 				 {-3998.552978515625, -3706.9599609375, 45.15883255004883  ,60.0, 20.0}, 
 			 },
        MaxHerbCanBeGathered = 1, --THE MAXIMUM NUMBER OF HERBS THAT CAN BE GATHERED IN A SESSION
 		xp    	             = 20,
        items = {
            {"provision_wldflwr_agarita", "Agarita", "inventory_items_mp", "provision_wldflwr_agarita", 1}, -- {ITEM DB NAME, LABEL, TEXTURE DICT, TEXTURE IMAGE, AMOUNT}
        },
    },
 
  	[2] = {
  		herb 		     = "COMPOSITE_LOOTABLE_BITTERWEED_DEF",
  		CompositeID      = -1697318509,
         Label            = "Bitterweed",
  		StartingDistrict = {"all"},
  	    EatHealthAdd     = 20,
  	    EatStaminaAdd    = 20.0, -- FLOAT
  	    EatHealthBoost   = 0.0,  -- FLOAT
  	    EatStaminaBoost  = 0.0,  -- FLOAT
  	    Effect 			 = "none",
  			 coords = {
  				 {-2521.256103515625, 577.0933837890625, 138.5227813720703  ,60.0, 20.0},
  				 {-2277.389892578125, 479.5504455566406, 125.66878509521484 ,60.0, 20.0},
  				 {-2225.7548828125, 556.239013671875, 117.94788360595703    ,60.0, 20.0},
  				 {-2027.311767578125, 601.828369140625, 117.4671630859375   ,60.0, 20.0},
  				 {-2408.051513671875, 735.2550048828125, 131.43527221679688 ,60.0, 20.0},
  				 {-1709.093017578125, 317.81878662109375, 110.9906005859375 ,60.0, 20.0},
  				 {2371.821533203125, 857.0501098632812, 77.25337982177734   ,60.0, 20.0},
  				 {2525.596923828125, 1186.8028564453125, 159.76918029785156 ,60.0, 20.0},
  				 {2275.179931640625, 1130.1197509765625, 128.01361083984375 ,60.0, 20.0},
  			 },
         MaxHerbCanBeGathered = 1,
  		 xp    	             = 20,
         items = {
             {"provision_wldflwr_bitterweed", "Bitterweed", "inventory_items_mp", "provision_wldflwr_bitterweed", 1},
         },
     },	
  	
  	[3] = {
  		herb 		     = "COMPOSITE_LOOTABLE_BLOODFLOWER_DEF",
  		CompositeID      = -1490607613,
         Label            = "Blood Flower",
  		StartingDistrict = {"all"},
  	    EatHealthAdd     = 20,
  	    EatStaminaAdd    = 20.0, -- FLOAT
  	    EatHealthBoost   = 0.0,  -- FLOAT
  	    EatStaminaBoost  = 0.0,  -- FLOAT
  	    Effect 			 = "none",
  			 coords = {
  				 {2231.70263671875, -422.1961364746094, 41.87713623046875 , 60.0, 20.0},
  				 {2446.629150390625, -584.5507202148438, 41.83866119384765, 60.0, 20.0},
  				 {2328.429931640625, -834.9791259765625, 41.56283950805664, 60.0, 20.0},
  				 {1961.260498046875, -477.9689636230469, 41.73916244506836, 60.0, 20.0},
  				 {1794.7606201171875, -519.7068481445312, 42.3913345336914, 60.0, 20.0},
  			 },
         MaxHerbCanBeGathered = 1,
  		xp    	             = 20,
         items = {
             {"provision_wldflwr_blood_flower", "Blood flower", "inventory_items_mp", "provision_wldflwr_blood_flower", 1},
         },
     },		
  	
  	[4] = {
  		herb 		     = "COMPOSITE_LOOTABLE_CARDINAL_FLOWER_DEF",
  		CompositeID      = 1175863601,
         Label           = "Cardinal FLower",
  		StartingDistrict = {"all"},
  	    EatHealthAdd     = 20,
  	    EatStaminaAdd    = 20.0, -- FLOAT
  	    EatHealthBoost   = 0.0,  -- FLOAT
  	    EatStaminaBoost  = 0.0,  -- FLOAT
  	    Effect 			 = "none",
  			 coords = {
  				 {1949.5989990234375, -1929.3311767578125, 41.76754760742187,60.0, 20.0},
  				 {2078.153564453125, -1872.575927734375, 41.99472045898437	,60.0, 20.0},
  				 {2038.65576171875, -1629.0242919921875, 41.8931884765625	,60.0, 20.0},
  				 {1925.6600341796875, -1178.0938720703125, 42.36078643798828,60.0, 20.0},
  				 {1875.3795166015625, -576.8333740234375, 43.27846908569336	,60.0, 20.0},
  
  			 },
         MaxHerbCanBeGathered = 1,
  		 xp    	              = 20,
         items = {
             {"provision_wldflwr_cardinal_flower", "Cardinal Flower", "inventory_items_mp", "provision_wldflwr_cardinal_flower", 1},
         },
     },		
  
  	[5] = {
  		herb 		     = "COMPOSITE_LOOTABLE_CHOC_DAISY_DEF",
  		CompositeID      = 988637426,
        Label            = "Chocolate Daisy",
  		StartingDistrict = {"all"},
  	    EatHealthAdd     = 20,
  	    EatStaminaAdd    = 20.0, -- FLOAT
  	    EatHealthBoost   = 0.0,  -- FLOAT
  	    EatStaminaBoost  = 0.0,  -- FLOAT
  	    Effect 			 = "none",
  			 coords = {
  				 {-1707.272705078125, -1189.3984375, 81.10189056396484		,60.0,20.0},
  				 {-1498.8604736328125, -1131.818359375, 74.22039031982422	,60.0,20.0},
  				 {-1406.0498046875, -1042.8922119140625, 74.28760528564453	,60.0,20.0},
  				 {-859.1424560546875, -884.1261596679688, 41.97923278808594	,60.0,20.0},
  				 {-753.8005981445312, -850.9891967773438, 52.66934585571289	,60.0,20.0},
  				 {-546.1978759765625, -566.6471557617188, 45.35386657714844	,60.0,20.0},
  				 {-325.8641052246094, -479.2782287597656, 69.74298095703125	,60.0,20.0},
  				 {-96.309814453125, -547.7133178710938, 60.0782585144043	,60.0,20.0},
  				 {163.5857696533203, -520.9869384765625, 65.58894348144531	,60.0,20.0},
  
  			 },
         MaxHerbCanBeGathered = 1,
  		xp    	             = 20,
         items = {
             {"provision_wldflwr_chocolate_daisy", "Chocolate Daisy", "inventory_items_mp", "provision_wldflwr_chocolate_daisy", 1},
         },
     },		
  
  
  	[6] = {
  	herb 		       = "COMPOSITE_LOOTABLE_CREEKPLUM_DEF",
  	CompositeID        = -1964504874,
    Label         	   = "Creek Plum",
  	StartingDistrict   = {"all"},
      EatHealthAdd     = 20,
      EatStaminaAdd    = 20.0, -- FLOAT
      EatHealthBoost   = 0.0,  -- FLOAT
      EatStaminaBoost  = 0.0,  -- FLOAT
      Effect 			 = "none",
  		 coords = {
  			 {-1820.5867919921875, -932.3973999023438, 106.2804946899414,60.0,20.0},
  			 {-2104.993408203125, -565.0439453125, 136.39810180664062   ,60.0,20.0},
  			 {-1603.4755859375, -722.0354614257812, 135.9131317138672   ,60.0,20.0},
  			 {795.791748046875, -1439.349609375, 52.97907257080078      ,60.0,20.0},
  			 {1215.087158203125, -2081.54150390625, 57.90670776367187   ,60.0,20.0},
  			 {1402.1190185546875, -1993.5709228515625, 54.82129669189453,60.0,20.0},
  		 },
        MaxHerbCanBeGathered = 1,
 		xp    	             = 20,
        items = {
            {"provision_wldflwr_creek_plum", "Creek Plum", "inventory_items_mp", "provision_wldflwr_creek_plum", 1},
        },
    },	
  
  
   	[7] = {
  		herb 		     = "COMPOSITE_LOOTABLE_TEXAS_BONNET_DEF",
  		CompositeID      = -2015527411,
          Label          = "Texas Bluebonnet",
  		StartingDistrict = {"all"},
  	    EatHealthAdd     = 20,
  	    EatStaminaAdd    = 20.0, -- FLOAT
  	    EatHealthBoost   = 0.0,  -- FLOAT
  	    EatStaminaBoost  = 0.0,  -- FLOAT
  	    Effect 			 = "none",
  			 coords = {
  				 {-1008.1371459960938, -1755.536376953125, 73.83460998535156,60.0,20.0},
  				 {-1048.2265625, -1716.760986328125, 79.60924530029297		,60.0,20.0},
  				 {-1166.8873291015625, -1857.2349853515625, 59.9553604125976,60.0,20.0},
  				 {-1329.1060791015625, -1888.8729248046875, 62.2827033996582,60.0,20.0},
  				 {-1632.5107421875, -2148.3115234375, 47.37868499755859		,60.0,20.0},
  				 {-4710.29638671875, -3735.53076171875, 12.04802799224853	,60.0,20.0},
  				 {-5086.88623046875, -3514.884521484375, 3.43989515304565	,60.0,20.0},
   
  			 },
          MaxHerbCanBeGathered = 1,
 		  xp    	           = 20,
          items = {
              {"provision_wldflwr_texas_blue_bonnet", "Texas Bluebonnet", "inventory_items_mp", "provision_wldflwr_texas_blue_bonnet", 1},
          },
      },		
  	
  	
   	[8] = {
  		herb 		     = "COMPOSITE_LOOTABLE_WILD_RHUBARB_DEF",
  		CompositeID      = -2029085880,
          Label          = "Wild Rhubarb",
  		StartingDistrict = {"all"},
  	    EatHealthAdd     = 20,
  	    EatStaminaAdd    = 20.0, -- FLOAT
  	    EatHealthBoost   = 0.0,  -- FLOAT
  	    EatStaminaBoost  = 0.0,  -- FLOAT
  	    Effect 			 = "none",
  			 coords = {
  				 {-4878.21533203125, -2826.125732421875, -3.51478028297424,60.0,20.0},
  				 {-4802.23046875, -2507.469482421875, 2.23786258697509	  ,60.0,20.0},
  				 {-4358.69140625, -2846.267333984375, -14.31571674346923  ,60.0,20.0},
  				 {-4199.0517578125, -2419.42724609375, 23.14792442321777  ,60.0,20.0},
  				 {-4102.13671875, -2199.06494140625, -4.00135231018066	  ,60.0,20.0},
  				 {-3733.042724609375, -2048.3134765625, -5.83817481994628 ,60.0,20.0},
  			 },
          MaxHerbCanBeGathered = 1,
  		  xp    	           = 20,
          items = {
              {"provision_wldflwr_wild_rhubarb", "Wild Rhubarb", "inventory_items_mp", "provision_wldflwr_wild_rhubarb", 1},
          },
      },	
  
  
   	[9] = {
  		herb 		     = "COMPOSITE_LOOTABLE_WISTERIA_DEF",
  		CompositeID      = -204942356,
        Label          	 = "Wisteria",
  		StartingDistrict = {"all"},
  	    EatHealthAdd     = 20,
  	    EatStaminaAdd    = 20.0, -- FLOAT
  	    EatHealthBoost   = 0.0,  -- FLOAT
  	    EatStaminaBoost  = 0.0,  -- FLOAT
  	    Effect 			 = "none",
  			 coords = {
  				 {-2425.862060546875, -1534.5465087890625, 165.54359436035156,60.0,20.0},
  				 {-2349.92138671875, -1859.74951171875, 105.97200012207031	 ,60.0,20.0},
  				 {-2257.21875, -1877.34130859375, 121.0241928100586			 ,60.0,20.0},
  				 {-2164.07568359375, -1809.8033447265625, 140.65301513671875 ,60.0,20.0},
  				 {-2430.221435546875, -1534.99462890625, 165.35018920898438	 ,60.0,20.0},
  				 {-2256.768310546875, -1519.01513671875, 144.37091064453125	 ,60.0,20.0},
  				 {-2106.755859375, -1661.309326171875, 140.0100860595703	 ,60.0,20.0},
  																			  
  			 },
          MaxHerbCanBeGathered = 1,
  		  xp    	           = 20,
          items = {
              {"provision_wldflwr_wisteria", "Wisteria", "inventory_items_mp", "provision_wldflwr_wisteria", 1},
          },
      },	

}

-------------------------------
-- HERBS COLLECTIONS -- 
-------------------------------
-- SET YOUR HERB COLLECTIONS HERE !

Config.Collections = {
 [1] = { 
 label = "The exquisite",
 image = "items/provision_wldflwr_set.png",
 items = {
	[1] = {item ="consumable_herb_alaskan_ginseng",  itemcount = 1},
	[2] = {item ="consumable_herb_american_ginseng", itemcount = 1},
	[3] = {item ="consumable_herb_wild_mint",        itemcount = 1},
 },
	itemreward  = "provision_herbalist_saddle",
	description = "x1 Alaskan Ginseng".."<br>".."x1 American Ginseng".."<br>".."x1 Wild Mint".."<br>".."Item reward: Herbalist Saddle",
	dollarprice = 250.0,
	goldprice   = 10.0,
	xp          = 20.0,
  }
}
 
-------------------------------

	-- CLASSIC HERBS -- 

-------------------------------
 -- THESE ARE THE CLASSIC HERBS 
 -- THESE ARE SORTED BY DISTRICTS CHECK THE Config.Herbs_Districts TABLE BELOW
 
Config.Herbs = {
 	[1] = {
		 herb                 = "COMPOSITE_LOOTABLE_ALASKAN_GINSENG_ROOT_DEF", -- HERB COMPOSITE 
		 CompositeID          = -1194833913, -- COMPOSITE ID 
 		 EatHealthAdd         = 20,   -- INTEGER
		 EatStaminaAdd        = 20.0, -- FLOAT
		 EatHealthBoost       = 0.0,  -- FLOAT
		 EatStaminaBoost      = 0.0,  -- FLOAT
		 Effect 			  = "none",		 
         MaxHerbSpawnLimit    = 3,  	-- THE MAXIMUM NUMBER OF HERBS THAT CAN SPAWN AT A SINGLE HERB SPAWN LOCATION 
         MaxSpawnChance       = 50, 	-- THE CHANCE THAT THE MAXIMUM NUMBER OF HERBS WILL SPAWN
         MaxHerbCanBeGathered = 5,		-- THE MAXIMUM NUMBER OF HERBS THAT CAN BE GATHERED IN A SESSION
		 WaterPlant           = false, 	-- IS THIS PLANT SHOULD SPAWN NEAR WATER 
         items = {
             {"consumable_herb_alaskan_ginseng", "Alaskan Ginseng", "INVENTORY_ITEMS", "consumable_herb_alaskan_ginseng", 1},	-- {ITEM DB NAME, LABEL, TEXTURE DICT, TEXTURE IMAGE, AMOUNT}
         },
     },
  	
	[2] = {
          herb                 = "COMPOSITE_LOOTABLE_AMERICAN_GINSENG_ROOT_DEF",
	      CompositeID          = -781771732,
 		  EatHealthAdd         = 20,
		  EatStaminaAdd        = 20.0, -- FLOAT
		  EatHealthBoost       = 0.0,  -- FLOAT
		  EatStaminaBoost      = 0.0,  -- FLOAT
		  Effect 			   = "none",		  
          MaxHerbSpawnLimit    = 2,
          MaxSpawnChance       = 50,		  
          MaxHerbCanBeGathered = 5,
		  WaterPlant           = false, 
          items = {
              {"consumable_herb_american_ginseng", "American Ginseng", "INVENTORY_ITEMS", "consumable_herb_american_ginseng", 1},
          },
      },
	  
  	[3] = {
		  herb		        	= "COMPOSITE_LOOTABLE_BAY_BOLETE_DEF",
	      CompositeID       	= -1202590500,		
 		  EatHealthAdd      	= 20,
		  EatStaminaAdd     	= 20.0, -- FLOAT
		  EatHealthBoost    	= 0.0,  -- FLOAT
		  EatStaminaBoost   	= 0.0,  -- FLOAT
		  Effect 				= "none",		  
          MaxHerbSpawnLimit 	= 3,
          MaxSpawnChance    	= 50,		  
          MaxHerbCanBeGathered  = 30,
		  WaterPlant            = false, 
          items = {
              {"consumable_herb_bay_bolete", "Bay Bolete", "INVENTORY_ITEMS", "consumable_herb_bay_bolete", 1},
          },
      },
 
	  
  	[4] = {	
            herb 		          = "COMPOSITE_LOOTABLE_BLACK_BERRY_DEF",
	        CompositeID           = -550091683,		
 		    EatHealthAdd          = 20,
		    EatStaminaAdd         = 20.0, -- FLOAT
			EatHealthBoost        = 0.0,  -- FLOAT
			EatStaminaBoost       = 0.0,  -- FLOAT
		    Effect 			      = "none",			
            MaxHerbSpawnLimit     = 3,
            MaxSpawnChance        = 50,			
            MaxHerbCanBeGathered  = 30,
		    WaterPlant            = false,			
            items = {
                {"consumable_herb_black_berry", "Blackberry", "INVENTORY_ITEMS", "consumable_herb_black_berry", 1},
            },
        },	
		
		
  	[5] = {	
          herb 		           = "COMPOSITE_LOOTABLE_BLACK_CURRANT_DEF",
		  CompositeID          = -190820666,
 	      EatHealthAdd         = 20,
	      EatStaminaAdd        = 20.0, -- FLOAT
	      EatHealthBoost       = 0.0, -- FLOAT
	      EatStaminaBoost      = 0.0, -- FLOAT
	      Effect 			   = "none",		  
          MaxHerbSpawnLimit    = 3,
          MaxSpawnChance       = 50,		  
          MaxHerbCanBeGathered = 5,
          canGatherMore		   = 1,
		  WaterPlant           = false,		  
          items = {
              {"consumable_herb_black_currant", "Black Currant", "INVENTORY_ITEMS", "consumable_herb_black_currant", 1},
          },
      },	
 
		
	[6] = {
              herb 		           = "COMPOSITE_LOOTABLE_BURDOCK_ROOT_DEF",
			  CompositeID          = 63835692,			   
 	          EatHealthAdd         = 20,
	          EatStaminaAdd        = 20.0, -- FLOAT
	          EatHealthBoost       = 0.0, -- FLOAT
	          EatStaminaBoost      = 0.0, -- FLOAT
	          Effect 			   = "none",			  
              MaxHerbSpawnLimit    = 2,
              MaxSpawnChance       = 50,			  
              MaxHerbCanBeGathered = 5,
		      WaterPlant           = false,				  
              items = {
                  {"consumable_herb_burdock_root", "Burdock Root", "INVENTORY_ITEMS", "consumable_herb_burdock_root", 1},
              },
          },
 
	[7] = {
           herb 	            = "COMPOSITE_LOOTABLE_CHANTERELLES_DEF",
		   CompositeID          = -1524011012,			
 	       EatHealthAdd         = 20,
	       EatStaminaAdd        = 20.0, -- FLOAT
	       EatHealthBoost       = 0.0, -- FLOAT
	       EatStaminaBoost      = 0.0, -- FLOAT
	       Effect 			    = "none",		   
           MaxHerbSpawnLimit    = 2,
           MaxSpawnChance       = 50,		   
           MaxHerbCanBeGathered = 5,
		   WaterPlant           = false,		   
           items = {
               {"consumable_herb_chanterelles", "Chanterelles", "INVENTORY_ITEMS", "consumable_herb_chanterelles", 1},
           },
       },
 
		
	[8] = { 
          herb                 = "COMPOSITE_LOOTABLE_COMMON_BULRUSH_DEF",
		  CompositeID          = -1291682103,		   
 	      EatHealthAdd         = 20,
	      EatStaminaAdd        = 20.0, -- FLOAT
	      EatHealthBoost       = 0.0, -- FLOAT
	      EatStaminaBoost      = 0.0, -- FLOAT
	      Effect 			   = "none",		  
          MaxHerbSpawnLimit    = 3,
          MaxSpawnChance       = 100,		  
          MaxHerbCanBeGathered = 5,
		  WaterPlant           = true,		  
          items = {
              {"consumable_herb_common_bulrush", "Common Bulrush", "INVENTORY_ITEMS", "consumable_herb_common_bulrush", 1},
          },
        },
 
	[9] = { 
          herb                 = "COMPOSITE_LOOTABLE_CREEPING_THYME_DEF",
		  CompositeID          = 2129486088,	   
 	      EatHealthAdd         = 20,
	      EatStaminaAdd        = 20.0, -- FLOAT
	      EatHealthBoost       = 0.0, -- FLOAT
	      EatStaminaBoost      = 0.0, -- FLOAT
	      Effect 			   = "none",		  
          MaxHerbSpawnLimit    = 3,
          MaxSpawnChance       = 50,		  
          MaxHerbCanBeGathered = 5,
		  WaterPlant           = false,		  
          items = {
              {"consumable_herb_creeping_thyme", "Creeping Thyme", "INVENTORY_ITEMS", "consumable_herb_creeping_thyme", 1},
          },
      },
	  
	[10] = { 
         herb                 = "COMPOSITE_LOOTABLE_DESERT_SAGE_DEF",
		 CompositeID          = 1640283709,		  
 	     EatHealthAdd         = 20,
	     EatStaminaAdd        = 20.0, -- FLOAT
	     EatHealthBoost       = 0.0, -- FLOAT
	     EatStaminaBoost      = 0.0, -- FLOAT
	     Effect 		      = "none",		 
         MaxHerbSpawnLimit    = 3,
         MaxSpawnChance       = 50,		 
         MaxHerbCanBeGathered = 5,
		 WaterPlant           = false,		 
         items = {
             {"consumable_herb_desert_sage", "Desert Sage", "INVENTORY_ITEMS", "consumable_herb_desert_sage", 1},
         },
     },	
	 
	[11] = { 
          herb                 = "COMPOSITE_LOOTABLE_ENGLISH_MACE_DEF",
		  CompositeID          = -177017064,		   
 	      EatHealthAdd         = 20,
	      EatStaminaAdd        = 20.0, -- FLOAT
	      EatHealthBoost       = 0.0, -- FLOAT
	      EatStaminaBoost      = 0.0, -- FLOAT
	      Effect 		       = "none",		  
          MaxHerbSpawnLimit    = 3,
          MaxSpawnChance       = 50,
          MaxHerbCanBeGathered = 5,
		  WaterPlant           = false,		  
          items = {
              {"consumable_herb_english_mace", "English Mace", "INVENTORY_ITEMS", "consumable_herb_english_mace", 1},
          },
      },
	  
	[12] = { 
         herb 		          = "COMPOSITE_LOOTABLE_EVERGREEN_HUCKLEBERRY_DEF",
		 CompositeID          = -231430744,			
 	     EatHealthAdd         = 20,
	     EatStaminaAdd        = 20.0, -- FLOAT
	     EatHealthBoost       = 0.0, -- FLOAT
	     EatStaminaBoost      = 0.0, -- FLOAT
	     Effect 		      = "none",		 
         MaxHerbSpawnLimit    = 2,
         MaxSpawnChance       = 50,
         MaxHerbCanBeGathered = 5,
		 WaterPlant           = false,		 
         items = {
             {"consumable_herb_evergreen_huckleberry", "Evergreen Huckleberry", "INVENTORY_ITEMS", "consumable_herb_evergreen_huckleberry", 1},
         },
     },	
	 
	[13] = { 
          herb                 = "COMPOSITE_LOOTABLE_GOLDEN_CURRANT_DEF",
		  CompositeID          = -1298766667,			   
 	      EatHealthAdd         = 20,
	      EatStaminaAdd        = 20.0, -- FLOAT
	      EatHealthBoost       = 0.0, -- FLOAT
	      EatStaminaBoost      = 0.0, -- FLOAT
	      Effect 		       = "none",		  
          MaxHerbSpawnLimit    = 3,
          MaxSpawnChance       = 50,		  
          MaxHerbCanBeGathered = 5,
		  WaterPlant           = false,		  
 
          items = {
              {"consumable_herb_golden_currant", "Golden Currant", "INVENTORY_ITEMS", "consumable_herb_golden_currant", 1},
          },
      },	
	  
	[14] = { 	
		  herb                 = "COMPOSITE_LOOTABLE_HARRIETUM_OFFICINALIS_DEF",
		  CompositeID          = -317883624,		   
 	      EatHealthAdd         = 20,
	      EatStaminaAdd        = 20.0, -- FLOAT
	      EatHealthBoost       = 0.0, -- FLOAT
	      EatStaminaBoost      = 0.0, -- FLOAT
	      Effect 		       = "none",		  
          MaxHerbSpawnLimit    = 2,
          MaxSpawnChance       = 50,		  
          MaxHerbCanBeGathered = 2,
		  WaterPlant           = false,		  
          items = {
              {"consumable_herb_harrietum", "Harrietum Officinalis", "inventory_items_mp", "consumable_herb_harrietum", 1},
          },
      },
	  
	[15] = { 
          herb                 = "COMPOSITE_LOOTABLE_HUMMINGBIRD_SAGE_DEF",
		  CompositeID          = 68963282,		   
 	      EatHealthAdd         = 20,
	      EatStaminaAdd        = 20.0, -- FLOAT
	      EatHealthBoost       = 0.0, -- FLOAT
	      EatStaminaBoost      = 0.0, -- FLOAT
	      Effect 		       = "none",		  
          MaxHerbSpawnLimit    = 3,
          MaxSpawnChance       = 50,		  
          MaxHerbCanBeGathered = 5,
		  WaterPlant           = false, 
          items = {
              {"consumable_herb_hummingbird_sage", "Hummingbird Sage", "INVENTORY_ITEMS", "consumable_herb_hummingbird_sage", 1},
          },
      },	

	[16] = { 
            herb 		         = "COMPOSITE_LOOTABLE_INDIAN_TOBACCO_DEF",
		    CompositeID          = 316930447,				
 	        EatHealthAdd         = 20,
	        EatStaminaAdd        = 20.0, -- FLOAT
	        EatHealthBoost       = 0.0,  -- FLOAT
	        EatStaminaBoost      = 0.0,  -- FLOAT
	        Effect 		         = "none",			
            MaxHerbSpawnLimit    = 3,
            MaxSpawnChance       = 50,			
            MaxHerbCanBeGathered = 5,
		    WaterPlant           = false,			
            items = {
                {"consumable_herb_indian_tobacco", "Indian Tobacco", "INVENTORY_ITEMS", "consumable_herb_indian_tobacco", 1},
            },
        },
		
	[17] = { 
		  herb                 = "COMPOSITE_LOOTABLE_MILKWEED_DEF",
		  CompositeID          = -1944784826,			  
 	      EatHealthAdd         = 20,
	      EatStaminaAdd        = 20.0, -- FLOAT
	      EatHealthBoost       = 0.0, -- FLOAT
	      EatStaminaBoost      = 0.0, -- FLOAT
	      Effect 		       = "none",			  
          MaxHerbSpawnLimit    = 2,
          MaxSpawnChance       = 50,		  
          MaxHerbCanBeGathered = 5,
		  WaterPlant           = false,		  
          items = {
              {"consumable_herb_milkweed", "Milkweed", "INVENTORY_ITEMS", "consumable_herb_milkweed", 1},
          },
      },	
	  
	[18] = { 
          herb 		           = "COMPOSITE_LOOTABLE_OLEANDER_SAGE_DEF",
	      CompositeID          = 454655011,		   
 	      EatHealthAdd         = 20,
	      EatStaminaAdd        = 20.0, -- FLOAT
	      EatHealthBoost       = 0.0, -- FLOAT
	      EatStaminaBoost      = 0.0, -- FLOAT
	      Effect 		       = "vomit",		  
          MaxHerbSpawnLimit    = 3,
          MaxSpawnChance       = 50,		  
          MaxHerbCanBeGathered = 5,
		  WaterPlant           = false,
          items = {
              {"consumable_herb_oleander_sage", "Oleander Sage", "INVENTORY_ITEMS", "consumable_herb_oleander_sage", 1},
          },
      },
	  
	[19] = {
         herb                 = "COMPOSITE_LOOTABLE_OREGANO_DEF",
	     CompositeID          = 2033030310,	  
 	     EatHealthAdd         = 20,
	     EatStaminaAdd        = 20.0, -- FLOAT
	     EatHealthBoost       = 0.0, -- FLOAT
	     EatStaminaBoost      = 0.0, -- FLOAT
	     Effect 		      = "none",		 
         MaxHerbSpawnLimit    = 3,
         MaxSpawnChance       = 50,		 
         MaxHerbCanBeGathered = 5,
		 WaterPlant           = false,		 
         items = {
             {"consumable_herb_oregano", "Oregano", "INVENTORY_ITEMS", "consumable_herb_oregano", 1},
         },
     },		
	 
	[20] = {
          herb                 = "COMPOSITE_LOOTABLE_PARASOL_MUSHROOM_DEF",
	      CompositeID          = 926616681,		   
 	      EatHealthAdd         = 20,
	      EatStaminaAdd        = 20.0, -- FLOAT
	      EatHealthBoost       = 0.0, -- FLOAT
	      EatStaminaBoost      = 0.0, -- FLOAT
	      Effect 		       = "hallucinations",		  
          MaxHerbSpawnLimit    = 3,
          MaxSpawnChance       = 50,		  
          MaxHerbCanBeGathered = 5,
		  WaterPlant           = false,		  
          items = {
              {"consumable_herb_parasol_mushroom", "Parasol Mushroom", "INVENTORY_ITEMS", "consumable_herb_parasol_mushroom", 1},
          },
      },
	  
	[21] = {
          herb                 = "COMPOSITE_LOOTABLE_PRAIRIE_POPPY_DEF",
	      CompositeID          = -423117050,	
 	      EatHealthAdd         = 20,
	      EatStaminaAdd        = 20.0, -- FLOAT
	      EatHealthBoost       = 0.0, -- FLOAT
	      EatStaminaBoost      = 0.0, -- FLOAT
	      Effect 		       = "none",		  
          MaxHerbSpawnLimit    = 2,
          MaxSpawnChance       = 50,		  
          MaxHerbCanBeGathered = 5,
		  WaterPlant           = false,		  
          items = {
              {"consumable_herb_prairie_poppy", "Prairie Poppy", "INVENTORY_ITEMS", "consumable_herb_prairie_poppy", 1},
          },
      },	
	  
 	[22] = { 
          herb 		           = "COMPOSITE_LOOTABLE_RAMS_HEAD_DEF",
	      CompositeID          = 76556053,	   
 	      EatHealthAdd         = 20,
	      EatStaminaAdd        = 20.0, -- FLOAT
	      EatHealthBoost       = 0.0, -- FLOAT
	      EatStaminaBoost      = 0.0, -- FLOAT
	      Effect 		       = "none",		  
          MaxHerbSpawnLimit    = 3,
          MaxSpawnChance       = 50,		  
          MaxHerbCanBeGathered = 5,
		  WaterPlant           = false,		  
          items = {
              {"consumable_herb_rams_head", "Ram's Head", "INVENTORY_ITEMS", "consumable_herb_rams_head", 1},
          },
      },	
  	
 	[23] = {   	
          herb                 = "COMPOSITE_LOOTABLE_RED_RASPBERRY_DEF",
	      CompositeID          = -1326233925,	 	   
 	      EatHealthAdd         = 20,
	      EatStaminaAdd        = 20.0, -- FLOAT
	      EatHealthBoost       = 0.0, -- FLOAT
	      EatStaminaBoost      = 0.0, -- FLOAT
	      Effect 		       = "none",		  
          MaxHerbSpawnLimit    = 2,
          MaxSpawnChance       = 50,		  
          MaxHerbCanBeGathered = 5,
		  WaterPlant           = false,		  
          items = {
              {"consumable_herb_red_raspberry", "Red Raspberry", "INVENTORY_ITEMS", "consumable_herb_red_raspberry", 1},
          },
      },
	  
  	[24] = { 	
          herb                 = "COMPOSITE_LOOTABLE_RED_SAGE_DEF",
	      CompositeID          = -1333051172,		   
 	      EatHealthAdd         = 20,
	      EatStaminaAdd        = 20.0, -- FLOAT
	      EatHealthBoost       = 0.0, -- FLOAT
	      EatStaminaBoost      = 0.0, -- FLOAT
	      Effect 		       = "none",		  
          MaxHerbSpawnLimit    = 2,
          MaxSpawnChance       = 50,		  
          MaxHerbCanBeGathered = 5,
		  WaterPlant           = false,		  
          items = {
              {"consumable_herb_red_sage", "Red Sage", "INVENTORY_ITEMS", "consumable_herb_red_sage", 1},
          },
      },	
 
	  
 	
  	[25] = { 
          herb 		        	= "COMPOSITE_LOOTABLE_VIOLET_SNOWDROP_DEF",
	      CompositeID       	= -1019761233,			   
 	      EatHealthAdd      	= 20,
	      EatStaminaAdd     	= 20.0, -- FLOAT
	      EatHealthBoost    	= 0.0, -- FLOAT
	      EatStaminaBoost   	= 0.0, -- FLOAT
	      Effect 		    	= "none",		  
          MaxHerbSpawnLimit     = 1,
          MaxSpawnChance        = 50,		  
          MaxHerbCanBeGathered  = 5,
		  WaterPlant            = false,		  
          items = {
              {"consumable_herb_violet_snowdrop", "Violet Snowdrop", "INVENTORY_ITEMS", "consumable_herb_violet_snowdrop", 1},
          },
      },	
	  
  	[26] = { 
          herb              	= "COMPOSITE_LOOTABLE_WILD_CARROT_DEF",
	      CompositeID       	= -780853522,	   
 	      EatHealthAdd      	= 20,
	      EatStaminaAdd     	= 20.0, -- FLOAT
	      EatHealthBoost    	= 0.0, -- FLOAT
	      EatStaminaBoost   	= 0.0, -- FLOAT
	      Effect 		    	= "none",		  
          MaxHerbSpawnLimit     = 3,
          MaxSpawnChance        = 50,		  
          MaxHerbCanBeGathered  = 5,
		  WaterPlant            = false,		  
          items = {
              {"consumable_herb_wild_carrots", "Wild Carrot", "INVENTORY_ITEMS", "consumable_herb_wild_carrots", 1},
          },
      },
	  
  	[27] = { 
       herb                     = "COMPOSITE_LOOTABLE_WILD_FEVERFEW_DEF",
	   CompositeID              = 561391114,		   
 	      EatHealthAdd          = 20,
	      EatStaminaAdd         = 20.0, -- FLOAT
	      EatHealthBoost        = 0.0, -- FLOAT
	      EatStaminaBoost       = 0.0, -- FLOAT
	      Effect 		        = "none",		  
          MaxHerbSpawnLimit     = 3,
          MaxSpawnChance        = 50,		  
          MaxHerbCanBeGathered  = 5,
		  WaterPlant            = false, 
          items = {
              {"consumable_herb_wild_feverfew", "Wild Feverfew", "INVENTORY_ITEMS", "consumable_herb_wild_feverfew", 1},
          },
      },
 
   	[28] = { 
          herb 				     = "COMPOSITE_LOOTABLE_WILD_MINT_DEF",
	      CompositeID            = -351933124,	   
 	      EatHealthAdd           = 20,
	      EatStaminaAdd          = 20.0, -- FLOAT
	      EatHealthBoost         = 0.0, -- FLOAT
	      EatStaminaBoost        = 0.0, -- FLOAT
	      Effect 		         = "none",		  
          MaxHerbSpawnLimit      = 3,
          MaxSpawnChance         = 50,		  
          MaxHerbCanBeGathered   = 5,
		  WaterPlant             = false,		  
          items = {
              {"consumable_herb_wild_mint", "Wild Mint", "INVENTORY_ITEMS", "consumable_herb_wild_mint", 1},
          },
      },
 
	  
   	[29] = {  
          herb 					 = "COMPOSITE_LOOTABLE_WINTERGREEN_BERRY_DEF",
	      CompositeID            = 1057523711,		   
 	      EatHealthAdd           = 20,
	      EatStaminaAdd          = 20.0, -- FLOAT
	      EatHealthBoost         = 0.0, -- FLOAT
	      EatStaminaBoost        = 0.0, -- FLOAT
	      Effect 		         = "none",		  
          MaxHerbSpawnLimit      = 1,
          MaxSpawnChance         = 50,		  
          MaxHerbCanBeGathered   = 5,
		  WaterPlant             = false,		  
          items = {
              {"consumable_herb_wintergreen_berry", "Wintergreen Berry", "INVENTORY_ITEMS", "consumable_herb_wintergreen_berry", 1},
          },
      },
 

   	[30] = {  	
          herb 					= "COMPOSITE_LOOTABLE_YARROW_DEF",
	      CompositeID           = 918835244,		   
 	      EatHealthAdd          = 20,
	      EatStaminaAdd         = 20.0, -- FLOAT
	      EatHealthBoost        = 0.0, -- FLOAT
	      EatStaminaBoost       = 0.0, -- FLOAT
	      Effect 		        = "none",		  
          MaxHerbSpawnLimit     = 3,
          MaxSpawnChance        = 50,		  
          MaxHerbCanBeGathered  = 5,
		  WaterPlant            = false,		  
          items = {
              {"consumable_herb_yarrow", "Yarrow", "INVENTORY_ITEMS", "consumable_herb_yarrow", 1},
          }, 
      },		
}

 	
	
-- CHOOSE WHICH HERB SPAWN IN EACH DISTRICT

Config.Herbs_Districts = {  
	district_bayou_nwa = {
		{"COMPOSITE_LOOTABLE_HUMMINGBIRD_SAGE_DEF", 40}, -- {COMPOSITEID, CHANCE OF SPAWNING / 100},
		{"COMPOSITE_LOOTABLE_CHANTERELLES_DEF", 30},
		{"COMPOSITE_LOOTABLE_OLEANDER_SAGE_DEF", 50},  
 		{"COMPOSITE_LOOTABLE_HARRIETUM_OFFICINALIS_DEF", 5},
		{"COMPOSITE_LOOTABLE_EVERGREEN_HUCKLEBERRY_DEF", 50},
 		{"COMPOSITE_LOOTABLE_COMMON_BULRUSH_DEF", 80},
		{"COMPOSITE_LOOTABLE_YARROW_DEF", 70},
		{"COMPOSITE_LOOTABLE_HUMMINGBIRD_SAGE_DEF", 30},
	},
	district_big_valley = {
	 	{"COMPOSITE_LOOTABLE_RAMS_HEAD_DEF", 20},
		{"COMPOSITE_LOOTABLE_HARRIETUM_OFFICINALIS_DEF", 5},
		{"COMPOSITE_LOOTABLE_GOLDEN_CURRANT_DEF", 40},
		{"COMPOSITE_LOOTABLE_BURDOCK_ROOT_DEF", 60},
		{"COMPOSITE_LOOTABLE_WILD_MINT_DEF", 60},
		{"COMPOSITE_LOOTABLE_INDIAN_TOBACCO_DEF", 60},
 		{"COMPOSITE_LOOTABLE_BAY_BOLETE_DEF", 20},
		{"COMPOSITE_LOOTABLE_COMMON_BULRUSH_DEF", 80},
	},
	district_cholla_springs = {
		{"COMPOSITE_LOOTABLE_BLACK_CURRANT_DEF", 40},
		{"COMPOSITE_LOOTABLE_DESERT_SAGE_DEF", 60},
		{"COMPOSITE_LOOTABLE_PARASOL_MUSHROOM_DEF", 30},
 		{"COMPOSITE_LOOTABLE_RED_RASPBERRY_DEF", 30},
	},
	district_cumberland_forest = {
		{"COMPOSITE_LOOTABLE_YARROW_DEF", 50},
		{"COMPOSITE_LOOTABLE_HARRIETUM_OFFICINALIS_DEF", 5},
		{"COMPOSITE_LOOTABLE_GOLDEN_CURRANT_DEF", 40},
		{"COMPOSITE_LOOTABLE_OREGANO_DEF", 30},
		{"COMPOSITE_LOOTABLE_CHANTERELLES_DEF", 30},
		{"COMPOSITE_LOOTABLE_WILD_CARROT_DEF", 30},
		{"COMPOSITE_LOOTABLE_WILD_MINT_DEF", 60},
	},
	district_gaptooth_ridge = {
		{"COMPOSITE_LOOTABLE_RED_RASPBERRY_DEF", 30},
		{"COMPOSITE_LOOTABLE_BLACK_CURRANT_DEF", 50},
		{"COMPOSITE_LOOTABLE_OREGANO_DEF", 50},
 		{"COMPOSITE_LOOTABLE_PARASOL_MUSHROOM_DEF", 30},

	},
	district_great_plains = {
		{"COMPOSITE_LOOTABLE_PRAIRIE_POPPY_DEF", 20},
		{"COMPOSITE_LOOTABLE_GOLDEN_CURRANT_DEF", 40},
		{"COMPOSITE_LOOTABLE_BURDOCK_ROOT_DEF", 60},
		{"COMPOSITE_LOOTABLE_WILD_MINT_DEF", 60},
		{"COMPOSITE_LOOTABLE_ALASKAN_GINSENG_ROOT_DEF", 5},
		{"COMPOSITE_LOOTABLE_INDIAN_TOBACCO_DEF", 60},
		{"COMPOSITE_LOOTABLE_CREEPING_THYME_DEF", 30},
		{"COMPOSITE_LOOTABLE_WILD_CARROT_DEF", 30},
	},
	district_grizzlies_east = {
		{"COMPOSITE_LOOTABLE_VIOLET_SNOWDROP_DEF", 40},
		{"COMPOSITE_LOOTABLE_RED_RASPBERRY_DEF", 30},
		{"COMPOSITE_LOOTABLE_RAMS_HEAD_DEF", 20},
		{"COMPOSITE_LOOTABLE_ENGLISH_MACE_DEF", 30},
 		{"COMPOSITE_LOOTABLE_PARASOL_MUSHROOM_DEF", 30},
 		{"COMPOSITE_LOOTABLE_AMERICAN_GINSENG_ROOT_DEF", 30},
		{"COMPOSITE_LOOTABLE_YARROW_DEF", 70},
 	},
	district_grizzlies_west = {
		{"COMPOSITE_LOOTABLE_VIOLET_SNOWDROP_DEF", 40},
		{"COMPOSITE_LOOTABLE_RAMS_HEAD_DEF", 10},
		{"COMPOSITE_LOOTABLE_HARRIETUM_OFFICINALIS_DEF", 5},
		{"COMPOSITE_LOOTABLE_ENGLISH_MACE_DEF", 30},
		{"COMPOSITE_LOOTABLE_ALASKAN_GINSENG_ROOT_DEF", 5},
 		{"COMPOSITE_LOOTABLE_PARASOL_MUSHROOM_DEF", 20},
 		{"COMPOSITE_LOOTABLE_AMERICAN_GINSENG_ROOT_DEF", 30},
		{"COMPOSITE_LOOTABLE_YARROW_DEF", 60},
 	},
	district_heartlands = {
		{"COMPOSITE_LOOTABLE_YARROW_DEF", 50},
		{"COMPOSITE_LOOTABLE_WILD_MINT_DEF", 50},
		{"COMPOSITE_LOOTABLE_HUMMINGBIRD_SAGE_DEF", 40},
 		{"COMPOSITE_LOOTABLE_GOLDEN_CURRANT_DEF", 40},
		{"COMPOSITE_LOOTABLE_BLACK_BERRY_DEF", 50},
		{"COMPOSITE_LOOTABLE_WILD_CARROT_DEF", 50},
		{"COMPOSITE_LOOTABLE_AMERICAN_GINSENG_ROOT_DEF", 20},
		{"COMPOSITE_LOOTABLE_PARASOL_MUSHROOM_DEF", 20},
 		{"COMPOSITE_LOOTABLE_EVERGREEN_HUCKLEBERRY_DEF", 15},
		{"COMPOSITE_LOOTABLE_COMMON_BULRUSH_DEF", 80},
	},
	district_hennigans_stead = {
		{"COMPOSITE_LOOTABLE_WILD_FEVERFEW_DEF", 20},
		{"COMPOSITE_LOOTABLE_RED_RASPBERRY_DEF", 20},
		{"COMPOSITE_LOOTABLE_WILD_MINT_DEF", 60},
 		{"COMPOSITE_LOOTABLE_INDIAN_TOBACCO_DEF", 60},
		{"COMPOSITE_LOOTABLE_MILKWEED_DEF", 30},
	},
	district_rio_bravo = {
		{"COMPOSITE_LOOTABLE_DESERT_SAGE_DEF", 60},
		{"COMPOSITE_LOOTABLE_PARASOL_MUSHROOM_DEF", 20},
  		{"COMPOSITE_LOOTABLE_RED_SAGE_DEF", 30},
		{"COMPOSITE_LOOTABLE_ENGLISH_MACE_DEF", 30},
	},
	district_roanoke_ridge = {
		{"COMPOSITE_LOOTABLE_OREGANO_DEF", 30},
		{"COMPOSITE_LOOTABLE_CREEPING_THYME_DEF", 30},
		{"COMPOSITE_LOOTABLE_CHANTERELLES_DEF", 20},
		{"COMPOSITE_LOOTABLE_HUMMINGBIRD_SAGE_DEF", 40},
 		{"COMPOSITE_LOOTABLE_WINTERGREEN_BERRY_DEF", 30},
	},
 	district_scarlett_meadows = {
 		{"COMPOSITE_LOOTABLE_YARROW_DEF", 60},
 		{"COMPOSITE_LOOTABLE_RED_RASPBERRY_DEF", 40},
 		{"COMPOSITE_LOOTABLE_OREGANO_DEF", 80},
 		{"COMPOSITE_LOOTABLE_OLEANDER_SAGE_DEF", 60},  
 		{"COMPOSITE_LOOTABLE_MILKWEED_DEF", 50},
 		{"COMPOSITE_LOOTABLE_INDIAN_TOBACCO_DEF", 50},
 		{"COMPOSITE_LOOTABLE_HUMMINGBIRD_SAGE_DEF", 40},
  		{"COMPOSITE_LOOTABLE_AMERICAN_GINSENG_ROOT_DEF", 30},
  		{"COMPOSITE_LOOTABLE_GOLDEN_CURRANT_DEF", 40},
 		{"COMPOSITE_LOOTABLE_COMMON_BULRUSH_DEF", 80},
  	},
 
	district_tall_trees = {
		{"COMPOSITE_LOOTABLE_BURDOCK_ROOT_DEF", 50},
		{"COMPOSITE_LOOTABLE_BLACK_BERRY_DEF", 50},
		{"COMPOSITE_LOOTABLE_BAY_BOLETE_DEF", 20},
 		{"COMPOSITE_LOOTABLE_CREEPING_THYME_DEF", 50},
		{"COMPOSITE_LOOTABLE_WILD_CARROT_DEF", 40},
		{"COMPOSITE_LOOTABLE_BLACK_BERRY_DEF", 50},
		{"COMPOSITE_LOOTABLE_RED_RASPBERRY_DEF", 30},
		{"COMPOSITE_LOOTABLE_RAMS_HEAD_DEF", 10},
		{"COMPOSITE_LOOTABLE_PARASOL_MUSHROOM_DEF", 30},
		{"COMPOSITE_LOOTABLE_AMERICAN_GINSENG_ROOT_DEF", 30},
	},
	 district_guarma = {
		{"COMPOSITE_LOOTABLE_OLEANDER_SAGE_DEF", 60},
		{"COMPOSITE_LOOTABLE_BLACK_BERRY_DEF", 50},	
		{"COMPOSITE_LOOTABLE_INDIAN_TOBACCO_DEF", 50},		
	},
}


Config.Herbs_CompendiumTitle     = "Herbs Compendium"
Config.Herbs_Compendium_nuifocus = false
Config.Herbs_Compendium = {
    [1] = {
        label    = "Alaskan Ginseng",
        mapimage = "items/map_camp_location_grizzlies.png",
        image    = "items/consumable_herb_alaskan_ginseng.png",
        desc     = "Alaskan Ginseng has large palmate leaves thorny stems and small red fruits The Alaskan Ginseng is usually found growing across Ambarino",
    },

    [2] = {
        label    = "American Ginseng",
        mapimage = "items/map_camp_location_big_valley.png",
        image    = "items/consumable_herb_american_ginseng.png",
        desc     = "American Ginseng has large palmate leavessmooth stems and small cluster of red berries found growing across West Elizabeth",
    },

    [3] = {
        label    = "Bay Bolete",
        mapimage = "items/map_camp_location_tall_trees.png",
        image    = "items/consumable_herb_bay_bolete.png",
        desc     = "Bay Bolete has an orange or brown cap This singular fungi often grows can be spotted growing in moist ground such as Tall Trees in West Elizabeth and New Hanover",
    },

    [4] = {
        label    = "Blackberry",
        mapimage = "items/map_camp_location_heartlands.png",
        image    = "items/consumable_herb_black_berry.png",
        desc     = "Blackberry shrubs has serrated leaves and black fruits These shrubs grow  in West Elizabeth as well as New Hanover",
    },

    [5] = {
        label    = "Black Currant",
        mapimage = {"items/map_camp_location_gaptooth_ridge.png"},
        image    = "items/consumable_herb_black_currant.png",
        desc     = "Blackcurrant is recognizable by its green leaves and clusters of small round black berries. These can be found in Gaptooth Ridge and Cholla Springs in New Austin",
    },

    [6] = {
        label    = "Burdock Root",
        mapimage = "items/map_camp_location_big_valley.png",
        image    = "items/consumable_herb_burdock_root.png",
        desc     = "Burdock are tall with dark green leafy bushes and are easily noticeable in a light colored environment  These are found in New Elizabeth especially Big Valley and Great Plains district",
    },

    [7] = {
        label    = "Chanterelles",
        mapimage = "items/map_camp_location_cumberland_forest.png",
        image    = "items/consumable_herb_chanterelles.png",
        desc     = "Chanterelles are yellow fungi that grow in clusters  These are recognizable by their color range from white  to orange These can be found across the Bayou  and New Hanover",
    },

    [8] = {
        label    = "Common Bulrush",
        mapimage = "items/map_camp_location_heartlands.png",
        image    = "items/consumable_herb_common_bulrush.png",
        desc     = "Common Bulrush has long leaves and brown staminate flowers  These can be found in almost all regions near water",
    },

    [9] = {
        label    = "Creeping Thyme",
        mapimage = "items/map_camp_location_heartlands.png",
        image    = "items/consumable_herb_creeping_thyme.png",
        desc     = "Creeping Thyme has woody stems small green leaves  and tiny purple bell shaped flowers  it can be found everywhere",
    },

    [10] = {
        label    = "Desert Sage",
        mapimage = "items/map_camp_location_gaptooth_ridge.png",
        image    = "items/consumable_herb_desert_sage.png",
        desc     = "Desert Sage is recognizable by its purple floral bracts  This type of sage can be found in New Austin  especially Gaptooth Ridge and Rio Bravo",
    },

    [11] = {
        label    = "English Mace",
        mapimage = "items/map_camp_location_rio_bravo.png",
        image    = "items/consumable_herb_english_mace.png",
        desc     = "English Mace is recognizable by its long stems  serrated leaves and numerous small yellow  flowers These can be found growing  in New Austin and Ambarino",
    },

    [12] = {
        label    = "Evergreen Huckleberry",
        mapimage = "items/map_camp_location_bayou_nwa.png",
        image    = "items/consumable_herb_evergreen_huckleberry.png",
        desc     = "Evergreen Huckleberry has sharp evergreeen leaves  and black berries these are found  in the Bayou and New Hanover",
    },

    [13] = {
        label    = "Golden Currant",
        mapimage = "items/map_camp_location_great_plains.png",
        image    = "items/consumable_herb_golden_currant.png",
        desc     = "Golden Currant are recognized by their yellow petals and golden berries  these can be found in West Elizabeth  New Hanover and Hennigans Stead",
    },

    [14] = {
        label    = "Harrietum Officinalis",
        mapimage = "items/map_camp_location_big_valley.png",
        image    = "items/consumable_herb_harrietum.png",
        desc     = "Discovered by Harriet Davenport these are  tiny scarlet and amethyst flowers  and can be found in every state",
    },

    [15] = {
        label    = "Hummingbird Sage",
        mapimage = "items/map_camp_location_bayou_nwa.png",
        image    = "items/consumable_herb_hummingbird_sage.png",
        desc     = "Hummingbird Sage has square stems and  deep purple flowers  It can be found in Lemoyne  West Elizabeth and New Hanover ",
    },

    [16] = {
        label    = "Indian Tobacco",
        mapimage = "items/map_camp_location_scarlett_meadows.png",
        image    = "items/consumable_herb_indian_tobacco.png",
        desc     = "Indian Tobacco has serrated leaves and lilac flowers  it can be found growing in West Elizabeth  New Hanover and Lemoyne",
    },

    [17] = {
        label    = "Milkweed",
        mapimage = "items/map_camp_location_scarlett_meadows.png",
        image    = "items/consumable_herb_milkweed.png",
        desc     = "Milkweed has large stems and leaves  and clusters of lilac flowers  it can be seen in Lemoyne and Hennigan Stead",
    },

    [18] = {
        label    = "Oleander Sage",
        mapimage = "items/map_camp_location_bayou_nwa.png",
        image    = "items/consumable_herb_oleander_sage.png",
        desc     = "Oleander Sage has thin leaves  and small five petal pink flowers  it can be found in Bayou Nwa",
    },

    [19] = {
        label    = "Oregano",
        mapimage = "items/map_camp_location_heartlands.png",
        image    = "items/consumable_herb_oregano.png",
        desc     = "Oregano has oval shaped leaves and purple sprouting flowers  it can be found in most places",
    },

    [20] = {
        label    = "Parasol Mushroom",
        mapimage = "items/map_camp_location_heartlands.png",
        image    = "items/consumable_herb_parasol_mushroom.png",
        desc     = "Parasol Mushroom is a fungi  that has a domed shape pileus  these can be found in most places",
    },

    [21] = {
        label    = "Prairie Poppy",
        mapimage = "items/map_camp_location_great_plains.png",
        image    = "items/consumable_herb_prairie_poppy.png",
        desc     = "The Prairie Poppy has long stems  and golden yellow cup shaped flowers  This plant is found in West Elizabeth  especially the Great plains district",
    },

    [22] = {
        label    = "Ram's Head",
        mapimage = "items/map_camp_location_grizzlies.png",
        image    = "items/consumable_herb_rams_head.png",
        desc     = "Rams Head can be identified by the clustered formation  This type of fungi can be found  in West Elizabeth and Ambarino",
    },

    [23] = {
        label    = "Red Raspberry",
        mapimage = "items/map_camp_location_grizzlies.png",
        image    = "items/consumable_herb_red_raspberry.png",
        desc     = "Red Raspberry plant has large size and bright red berries  These can be found in most states",
    },

    [24] = {
        label    = "Red Sage",
        mapimage = "items/map_camp_location_rio_bravo.png",
        image    = "items/consumable_herb_red_sage.png",
        desc     = "Red Sage has dark red flower heads  surrounded by dark green leaves  It is found in Rio Bravo",
    },

    [25] = {
        label    = "Violet Snowdrop",
        mapimage = "items/map_camp_location_grizzlies.png",
        image    = "items/consumable_herb_violet_snowdrop.png",
        desc     = "Violet Snowdrop has short stems  long leaves and violet bell shaped flowers  These can be found in Ambarino",
    },

    [26] = {
        label    = "Wild Carrot",
        mapimage = "items/map_camp_location_heartlands.png",
        image    = "items/consumable_herb_wild_carrots.png",
        desc     = "Wild Carrot has long thin stems  and white clustered flowers  These can be found in most states",
    },

    [27] = {
        label    = "Wild Feverfew",
        mapimage = "items/map_camp_location_hannigans_stead.png",
        image    = "items/consumable_herb_wild_feverfew.png",
        desc     = "It has white flowers on green leaf  beds and are found in Hennigan Stead",
    },

    [28] = {
        label    = "Wild Mint",
        mapimage = "items/map_camp_location_heartlands.png",
        image    = "items/consumable_herb_wild_mint.png",
        desc     = "Wild Mint has square stems  pale purple flowers and fragrant leaves  It can be found in most places",
    },

    [29] = {
        label    = "Wintergreen Berry",
        mapimage = "items/map_camp_location_grizzlies.png",
        image    = "items/consumable_herb_wintergreen_berry.png",
        desc     = "Wintergreen Berry has evergreen leaves  and red berries It can be found  in Ambarino and New Hanover",
    },

    [30] = {
        label    = "Yarrow",
        mapimage = "items/map_camp_location_scarlett_meadows.png",
        image    = "items/consumable_herb_yarrow.png",
        desc     = "It has long thin stems and red clusters  of flowers It can be found  in New Hanover and Lemoyne",
    },
}


----------------------------------
		-- HERBS SHOPS --
---------------------------------- 

Config.HerbalistOpenMenuPromptTitle  = "Herbalist"
Config.HerbalistShopPromptDistance   = 2.0
Config.HerbalistOpenMenuPrompt       = 0xC7B5340A -- ENTER 

Config.HerbShopRolesRoleRestriction = true 
Config.HerbShopRoles = { -- ALLOWED ROLES TO OPEN THE HERB SHOP 
"horsetrainer"
}
 
Config.HerbShops = {
[1] = {["name"] = "Saint Denis",   ["blipenabled"] = true, ["blipname"] = "Herbalist Shop", ["blipsprite"] = 669307703, ["coords"] = vector3(2585.96044921875, -1009.7344970703125, 44.26974868774414), 	["cameracoords"] = {a= 2588.57,  b= -1011.44, c= 44.86,  d= -5.60, e= 0.00, f= 99.39,  g= 50.00}},
[2] = {["name"] = "Strawberry",    ["blipenabled"] = true, ["blipname"] = "Herbalist Shop", ["blipsprite"] = 669307703, ["coords"] = vector3(-1785.4560546875, -367.61920166015625, 160.3992156982422),  	["cameracoords"] = {a= -1787.22, b= -368.33, c= 160.78, d= 1.33, e= 0.00, f= -56.08, g= 50.0} },
}

Config.CreatePeds = true
Config.Peds = {
[1] = {["name"] = "Saint Denis",    ["pedmodel"] = "cs_exoticcollector",    ["pedcoords"] = vector3(2586.414306640625, -1011.4839477539062, 44.23998260498047),      ["pedheading"] = -85.0,   ["scenariotype"] = "WORLD_HUMAN_WAITING_IMPATIENT"},
[2] = {["name"] = "Strawberry",     ["pedmodel"] = "cs_herbalist",  	    ["pedcoords"] = vector3(-1785.4560546875, -367.61920166015625, 160.3992156982422),       ["pedheading"] = 100.0,   ["scenariotype"] = "WORLD_HUMAN_WAITING_IMPATIENT"},
} 


 
 
----------------------------
		--ROLE XP--
----------------------------
--THIS IS WHERE YOU SET UP THE REWARDS AND XP FOR THE BUILT-IN ROLE XP SYSTEM (WORKS ON HERBALIST ROLE ONLY)
Config.RoleXpenabled         = false
Config.MaxXp  		         = 99999 --(Max Role level is 100)
Config.NewLevelTitle         = "Herbalist"
Config.NewLevelText          = "You are now level"
Config.NewXpText             = "XP +"
Config.NewLevelAdditemsText  = "Rewards:"
Config.CurrentLevelText      = "LEVEL: "
 
--  /!\ THE GOLD REWARD IS ONLY EFFECTIVE ON VORP FRAMEWORK /!\
 
Config.RoleXp = {
[1]    = {requiredxp = 100  ,  rewarditem1QT = 1, rewarditem1 = nil, item1name = "Hay", rewarditem2QT = 1, rewarditem2 = nil, item2name = "Carrot", rewarditem3QT = 1, rewarditem3 = nil, item3name = "Horse Reviver", rewardmoney = 100.0,  rewardgold = 0.0},
[2]    = {requiredxp = 200  ,  rewarditem1QT = 1, rewarditem1 = nil, item1name = "Hay", rewarditem2QT = 1, rewarditem2 = nil, item2name = "Carrot", rewarditem3QT = 1, rewarditem3 = nil, item3name = "Horse Reviver", rewardmoney = 100.0,  rewardgold = 0.0},
[3]    = {requiredxp = 300  ,  rewarditem1QT = 1, rewarditem1 = nil, item1name = nil, rewarditem2QT = 1, rewarditem2 = nil, item2name = nil, rewarditem3QT = 1, rewarditem3 = nil, item3name = nil, rewardmoney = 100.0, rewardgold = 0.0},
[4]    = {requiredxp = 400  ,  rewarditem1QT = 1, rewarditem1 = nil, item1name = nil, rewarditem2QT = 1, rewarditem2 = nil, item2name = nil, rewarditem3QT = 1, rewarditem3 = nil, item3name = nil, rewardmoney = 100.0, rewardgold = 0.0},
[5]    = {requiredxp = 500  ,  rewarditem1QT = 1, rewarditem1 = nil, item1name = nil, rewarditem2QT = 1, rewarditem2 = nil, item2name = nil, rewarditem3QT = 1, rewarditem3 = nil, item3name = nil, rewardmoney = 100.0, rewardgold = 0.0},
[6]    = {requiredxp = 600  ,  rewarditem1QT = 1, rewarditem1 = nil, item1name = nil, rewarditem2QT = 1, rewarditem2 = nil, item2name = nil, rewarditem3QT = 1, rewarditem3 = nil, item3name = nil, rewardmoney = 100.0, rewardgold = 0.0},
[7]    = {requiredxp = 700  ,  rewarditem1QT = 1, rewarditem1 = nil, item1name = nil, rewarditem2QT = 1, rewarditem2 = nil, item2name = nil, rewarditem3QT = 1, rewarditem3 = nil, item3name = nil, rewardmoney = 100.0, rewardgold = 0.0},
[8]    = {requiredxp = 800  ,  rewarditem1QT = 1, rewarditem1 = nil, item1name = nil, rewarditem2QT = 1, rewarditem2 = nil, item2name = nil, rewarditem3QT = 1, rewarditem3 = nil, item3name = nil, rewardmoney = 100.0, rewardgold = 0.0},
[9]    = {requiredxp = 900  ,  rewarditem1QT = 1, rewarditem1 = nil, item1name = nil, rewarditem2QT = 1, rewarditem2 = nil, item2name = nil, rewarditem3QT = 1, rewarditem3 = nil, item3name = nil, rewardmoney = 100.0, rewardgold = 0.0},
[10]   = {requiredxp = 1000 ,  rewarditem1QT = 1, rewarditem1 = nil, item1name = nil, rewarditem2QT = 1, rewarditem2 = nil, item2name = nil, rewarditem3QT = 1, rewarditem3 = nil, item3name = nil, rewardmoney = 100.0, rewardgold = 0.0},
[11]   = {requiredxp = 1100 ,  rewarditem1QT = 1, rewarditem1 = nil, item1name = nil, rewarditem2QT = 1, rewarditem2 = nil, item2name = nil, rewarditem3QT = 1, rewarditem3 = nil, item3name = nil, rewardmoney = 100.0, rewardgold = 0.0},
[12]   = {requiredxp = 1200 ,  rewarditem1QT = 1, rewarditem1 = nil, item1name = nil, rewarditem2QT = 1, rewarditem2 = nil, item2name = nil, rewarditem3QT = 1, rewarditem3 = nil, item3name = nil, rewardmoney = 100.0, rewardgold = 0.0},
[13]   = {requiredxp = 1300 ,  rewarditem1QT = 1, rewarditem1 = nil, item1name = nil, rewarditem2QT = 1, rewarditem2 = nil, item2name = nil, rewarditem3QT = 1, rewarditem3 = nil, item3name = nil, rewardmoney = 100.0, rewardgold = 0.0},
[14]   = {requiredxp = 1400 ,  rewarditem1QT = 1, rewarditem1 = nil, item1name = nil, rewarditem2QT = 1, rewarditem2 = nil, item2name = nil, rewarditem3QT = 1, rewarditem3 = nil, item3name = nil, rewardmoney = 100.0, rewardgold = 0.0},
[15]   = {requiredxp = 1500 ,  rewarditem1QT = 1, rewarditem1 = nil, item1name = nil, rewarditem2QT = 1, rewarditem2 = nil, item2name = nil, rewarditem3QT = 1, rewarditem3 = nil, item3name = nil, rewardmoney = 100.0, rewardgold = 0.0},
[16]   = {requiredxp = 1600 ,  rewarditem1QT = 1, rewarditem1 = nil, item1name = nil, rewarditem2QT = 1, rewarditem2 = nil, item2name = nil, rewarditem3QT = 1, rewarditem3 = nil, item3name = nil, rewardmoney = 100.0, rewardgold = 0.0},
[17]   = {requiredxp = 1700 ,  rewarditem1QT = 1, rewarditem1 = nil, item1name = nil, rewarditem2QT = 1, rewarditem2 = nil, item2name = nil, rewarditem3QT = 1, rewarditem3 = nil, item3name = nil, rewardmoney = 100.0, rewardgold = 0.0},
[18]   = {requiredxp = 1800 ,  rewarditem1QT = 1, rewarditem1 = nil, item1name = nil, rewarditem2QT = 1, rewarditem2 = nil, item2name = nil, rewarditem3QT = 1, rewarditem3 = nil, item3name = nil, rewardmoney = 100.0, rewardgold = 0.0},
[19]   = {requiredxp = 1900 ,  rewarditem1QT = 1, rewarditem1 = nil, item1name = nil, rewarditem2QT = 1, rewarditem2 = nil, item2name = nil, rewarditem3QT = 1, rewarditem3 = nil, item3name = nil, rewardmoney = 100.0, rewardgold = 0.0},
[20]   = {requiredxp = 2000 ,  rewarditem1QT = 1, rewarditem1 = nil, item1name = nil, rewarditem2QT = 1, rewarditem2 = nil, item2name = nil, rewarditem3QT = 1, rewarditem3 = nil, item3name = nil, rewardmoney = 100.0, rewardgold = 0.0},
[21]   = {requiredxp = 2100 ,  rewarditem1QT = 1, rewarditem1 = nil, item1name = nil, rewarditem2QT = 1, rewarditem2 = nil, item2name = nil, rewarditem3QT = 1, rewarditem3 = nil, item3name = nil, rewardmoney = 100.0, rewardgold = 0.0},
[22]   = {requiredxp = 2200 ,  rewarditem1QT = 1, rewarditem1 = nil, item1name = nil, rewarditem2QT = 1, rewarditem2 = nil, item2name = nil, rewarditem3QT = 1, rewarditem3 = nil, item3name = nil, rewardmoney = 100.0, rewardgold = 0.0},
[23]   = {requiredxp = 2300 ,  rewarditem1QT = 1, rewarditem1 = nil, item1name = nil, rewarditem2QT = 1, rewarditem2 = nil, item2name = nil, rewarditem3QT = 1, rewarditem3 = nil, item3name = nil, rewardmoney = 100.0, rewardgold = 0.0},
[24]   = {requiredxp = 2400 ,  rewarditem1QT = 1, rewarditem1 = nil, item1name = nil, rewarditem2QT = 1, rewarditem2 = nil, item2name = nil, rewarditem3QT = 1, rewarditem3 = nil, item3name = nil, rewardmoney = 100.0, rewardgold = 0.0},
[25]   = {requiredxp = 2500 ,  rewarditem1QT = 1, rewarditem1 = nil, item1name = nil, rewarditem2QT = 1, rewarditem2 = nil, item2name = nil, rewarditem3QT = 1, rewarditem3 = nil, item3name = nil, rewardmoney = 100.0, rewardgold = 0.0},
[26]   = {requiredxp = 2600 ,  rewarditem1QT = 1, rewarditem1 = nil, item1name = nil, rewarditem2QT = 1, rewarditem2 = nil, item2name = nil, rewarditem3QT = 1, rewarditem3 = nil, item3name = nil, rewardmoney = 100.0, rewardgold = 0.0},
[27]   = {requiredxp = 2700 ,  rewarditem1QT = 1, rewarditem1 = nil, item1name = nil, rewarditem2QT = 1, rewarditem2 = nil, item2name = nil, rewarditem3QT = 1, rewarditem3 = nil, item3name = nil, rewardmoney = 100.0, rewardgold = 0.0},
[28]   = {requiredxp = 2800 ,  rewarditem1QT = 1, rewarditem1 = nil, item1name = nil, rewarditem2QT = 1, rewarditem2 = nil, item2name = nil, rewarditem3QT = 1, rewarditem3 = nil, item3name = nil, rewardmoney = 100.0, rewardgold = 0.0},
[29]   = {requiredxp = 2900 ,  rewarditem1QT = 1, rewarditem1 = nil, item1name = nil, rewarditem2QT = 1, rewarditem2 = nil, item2name = nil, rewarditem3QT = 1, rewarditem3 = nil, item3name = nil, rewardmoney = 100.0, rewardgold = 0.0},
[30]   = {requiredxp = 3000 ,  rewarditem1QT = 1, rewarditem1 = nil, item1name = nil, rewarditem2QT = 1, rewarditem2 = nil, item2name = nil, rewarditem3QT = 1, rewarditem3 = nil, item3name = nil, rewardmoney = 100.0, rewardgold = 0.0},
[31]   = {requiredxp = 3100 ,  rewarditem1QT = 1, rewarditem1 = nil, item1name = nil, rewarditem2QT = 1, rewarditem2 = nil, item2name = nil, rewarditem3QT = 1, rewarditem3 = nil, item3name = nil, rewardmoney = 100.0, rewardgold = 0.0},
[32]   = {requiredxp = 3200 ,  rewarditem1QT = 1, rewarditem1 = nil, item1name = nil, rewarditem2QT = 1, rewarditem2 = nil, item2name = nil, rewarditem3QT = 1, rewarditem3 = nil, item3name = nil, rewardmoney = 100.0, rewardgold = 0.0},
[33]   = {requiredxp = 3300 ,  rewarditem1QT = 1, rewarditem1 = nil, item1name = nil, rewarditem2QT = 1, rewarditem2 = nil, item2name = nil, rewarditem3QT = 1, rewarditem3 = nil, item3name = nil, rewardmoney = 100.0, rewardgold = 0.0},
[34]   = {requiredxp = 3400 ,  rewarditem1QT = 1, rewarditem1 = nil, item1name = nil, rewarditem2QT = 1, rewarditem2 = nil, item2name = nil, rewarditem3QT = 1, rewarditem3 = nil, item3name = nil, rewardmoney = 100.0, rewardgold = 0.0},
[35]   = {requiredxp = 3500 ,  rewarditem1QT = 1, rewarditem1 = nil, item1name = nil, rewarditem2QT = 1, rewarditem2 = nil, item2name = nil, rewarditem3QT = 1, rewarditem3 = nil, item3name = nil, rewardmoney = 100.0, rewardgold = 0.0},
[36]   = {requiredxp = 3600 ,  rewarditem1QT = 1, rewarditem1 = nil, item1name = nil, rewarditem2QT = 1, rewarditem2 = nil, item2name = nil, rewarditem3QT = 1, rewarditem3 = nil, item3name = nil, rewardmoney = 100.0, rewardgold = 0.0},
[37]   = {requiredxp = 3700 ,  rewarditem1QT = 1, rewarditem1 = nil, item1name = nil, rewarditem2QT = 1, rewarditem2 = nil, item2name = nil, rewarditem3QT = 1, rewarditem3 = nil, item3name = nil, rewardmoney = 100.0, rewardgold = 0.0},
[38]   = {requiredxp = 3800 ,  rewarditem1QT = 1, rewarditem1 = nil, item1name = nil, rewarditem2QT = 1, rewarditem2 = nil, item2name = nil, rewarditem3QT = 1, rewarditem3 = nil, item3name = nil, rewardmoney = 100.0, rewardgold = 0.0},
[39]   = {requiredxp = 3900 ,  rewarditem1QT = 1, rewarditem1 = nil, item1name = nil, rewarditem2QT = 1, rewarditem2 = nil, item2name = nil, rewarditem3QT = 1, rewarditem3 = nil, item3name = nil, rewardmoney = 100.0, rewardgold = 0.0},
[40]   = {requiredxp = 4000 ,  rewarditem1QT = 1, rewarditem1 = nil, item1name = nil, rewarditem2QT = 1, rewarditem2 = nil, item2name = nil, rewarditem3QT = 1, rewarditem3 = nil, item3name = nil, rewardmoney = 100.0, rewardgold = 0.0},
[41]   = {requiredxp = 4100 ,  rewarditem1QT = 1, rewarditem1 = nil, item1name = nil, rewarditem2QT = 1, rewarditem2 = nil, item2name = nil, rewarditem3QT = 1, rewarditem3 = nil, item3name = nil, rewardmoney = 100.0, rewardgold = 0.0},
[42]   = {requiredxp = 4200 ,  rewarditem1QT = 1, rewarditem1 = nil, item1name = nil, rewarditem2QT = 1, rewarditem2 = nil, item2name = nil, rewarditem3QT = 1, rewarditem3 = nil, item3name = nil, rewardmoney = 100.0, rewardgold = 0.0},
[43]   = {requiredxp = 4300 ,  rewarditem1QT = 1, rewarditem1 = nil, item1name = nil, rewarditem2QT = 1, rewarditem2 = nil, item2name = nil, rewarditem3QT = 1, rewarditem3 = nil, item3name = nil, rewardmoney = 100.0, rewardgold = 0.0},
[44]   = {requiredxp = 4400 ,  rewarditem1QT = 1, rewarditem1 = nil, item1name = nil, rewarditem2QT = 1, rewarditem2 = nil, item2name = nil, rewarditem3QT = 1, rewarditem3 = nil, item3name = nil, rewardmoney = 100.0, rewardgold = 0.0},
[45]   = {requiredxp = 4500 ,  rewarditem1QT = 1, rewarditem1 = nil, item1name = nil, rewarditem2QT = 1, rewarditem2 = nil, item2name = nil, rewarditem3QT = 1, rewarditem3 = nil, item3name = nil, rewardmoney = 100.0, rewardgold = 0.0},
[46]   = {requiredxp = 4600 ,  rewarditem1QT = 1, rewarditem1 = nil, item1name = nil, rewarditem2QT = 1, rewarditem2 = nil, item2name = nil, rewarditem3QT = 1, rewarditem3 = nil, item3name = nil, rewardmoney = 100.0, rewardgold = 0.0},
[47]   = {requiredxp = 4700 ,  rewarditem1QT = 1, rewarditem1 = nil, item1name = nil, rewarditem2QT = 1, rewarditem2 = nil, item2name = nil, rewarditem3QT = 1, rewarditem3 = nil, item3name = nil, rewardmoney = 100.0, rewardgold = 0.0},
[48]   = {requiredxp = 4800 ,  rewarditem1QT = 1, rewarditem1 = nil, item1name = nil, rewarditem2QT = 1, rewarditem2 = nil, item2name = nil, rewarditem3QT = 1, rewarditem3 = nil, item3name = nil, rewardmoney = 100.0, rewardgold = 0.0},
[49]   = {requiredxp = 4900 ,  rewarditem1QT = 1, rewarditem1 = nil, item1name = nil, rewarditem2QT = 1, rewarditem2 = nil, item2name = nil, rewarditem3QT = 1, rewarditem3 = nil, item3name = nil, rewardmoney = 100.0, rewardgold = 0.0},
[50]   = {requiredxp = 5000 ,  rewarditem1QT = 1, rewarditem1 = nil, item1name = nil, rewarditem2QT = 1, rewarditem2 = nil, item2name = nil, rewarditem3QT = 1, rewarditem3 = nil, item3name = nil, rewardmoney = 100.0, rewardgold = 0.0},
[51]   = {requiredxp = 5100 ,  rewarditem1QT = 1, rewarditem1 = nil, item1name = nil, rewarditem2QT = 1, rewarditem2 = nil, item2name = nil, rewarditem3QT = 1, rewarditem3 = nil, item3name = nil, rewardmoney = 100.0, rewardgold = 0.0},
[52]   = {requiredxp = 5200 ,  rewarditem1QT = 1, rewarditem1 = nil, item1name = nil, rewarditem2QT = 1, rewarditem2 = nil, item2name = nil, rewarditem3QT = 1, rewarditem3 = nil, item3name = nil, rewardmoney = 100.0, rewardgold = 0.0},
[53]   = {requiredxp = 5300 ,  rewarditem1QT = 1, rewarditem1 = nil, item1name = nil, rewarditem2QT = 1, rewarditem2 = nil, item2name = nil, rewarditem3QT = 1, rewarditem3 = nil, item3name = nil, rewardmoney = 100.0, rewardgold = 0.0},
[54]   = {requiredxp = 5400 ,  rewarditem1QT = 1, rewarditem1 = nil, item1name = nil, rewarditem2QT = 1, rewarditem2 = nil, item2name = nil, rewarditem3QT = 1, rewarditem3 = nil, item3name = nil, rewardmoney = 100.0, rewardgold = 0.0},
[55]   = {requiredxp = 5500 ,  rewarditem1QT = 1, rewarditem1 = nil, item1name = nil, rewarditem2QT = 1, rewarditem2 = nil, item2name = nil, rewarditem3QT = 1, rewarditem3 = nil, item3name = nil, rewardmoney = 100.0, rewardgold = 0.0},
[56]   = {requiredxp = 5600 ,  rewarditem1QT = 1, rewarditem1 = nil, item1name = nil, rewarditem2QT = 1, rewarditem2 = nil, item2name = nil, rewarditem3QT = 1, rewarditem3 = nil, item3name = nil, rewardmoney = 100.0, rewardgold = 0.0},
[57]   = {requiredxp = 5700 ,  rewarditem1QT = 1, rewarditem1 = nil, item1name = nil, rewarditem2QT = 1, rewarditem2 = nil, item2name = nil, rewarditem3QT = 1, rewarditem3 = nil, item3name = nil, rewardmoney = 100.0, rewardgold = 0.0},
[58]   = {requiredxp = 5800 ,  rewarditem1QT = 1, rewarditem1 = nil, item1name = nil, rewarditem2QT = 1, rewarditem2 = nil, item2name = nil, rewarditem3QT = 1, rewarditem3 = nil, item3name = nil, rewardmoney = 100.0, rewardgold = 0.0},
[59]   = {requiredxp = 5900 ,  rewarditem1QT = 1, rewarditem1 = nil, item1name = nil, rewarditem2QT = 1, rewarditem2 = nil, item2name = nil, rewarditem3QT = 1, rewarditem3 = nil, item3name = nil, rewardmoney = 100.0, rewardgold = 0.0},
[60]   = {requiredxp = 6000 ,  rewarditem1QT = 1, rewarditem1 = nil, item1name = nil, rewarditem2QT = 1, rewarditem2 = nil, item2name = nil, rewarditem3QT = 1, rewarditem3 = nil, item3name = nil, rewardmoney = 100.0, rewardgold = 0.0},
[61]   = {requiredxp = 6100 ,  rewarditem1QT = 1, rewarditem1 = nil, item1name = nil, rewarditem2QT = 1, rewarditem2 = nil, item2name = nil, rewarditem3QT = 1, rewarditem3 = nil, item3name = nil, rewardmoney = 100.0, rewardgold = 0.0},
[62]   = {requiredxp = 6200 ,  rewarditem1QT = 1, rewarditem1 = nil, item1name = nil, rewarditem2QT = 1, rewarditem2 = nil, item2name = nil, rewarditem3QT = 1, rewarditem3 = nil, item3name = nil, rewardmoney = 100.0, rewardgold = 0.0},
[63]   = {requiredxp = 6300 ,  rewarditem1QT = 1, rewarditem1 = nil, item1name = nil, rewarditem2QT = 1, rewarditem2 = nil, item2name = nil, rewarditem3QT = 1, rewarditem3 = nil, item3name = nil, rewardmoney = 100.0, rewardgold = 0.0},
[64]   = {requiredxp = 6400 ,  rewarditem1QT = 1, rewarditem1 = nil, item1name = nil, rewarditem2QT = 1, rewarditem2 = nil, item2name = nil, rewarditem3QT = 1, rewarditem3 = nil, item3name = nil, rewardmoney = 100.0, rewardgold = 0.0},
[65]   = {requiredxp = 6500 ,  rewarditem1QT = 1, rewarditem1 = nil, item1name = nil, rewarditem2QT = 1, rewarditem2 = nil, item2name = nil, rewarditem3QT = 1, rewarditem3 = nil, item3name = nil, rewardmoney = 100.0, rewardgold = 0.0},
[66]   = {requiredxp = 6600 ,  rewarditem1QT = 1, rewarditem1 = nil, item1name = nil, rewarditem2QT = 1, rewarditem2 = nil, item2name = nil, rewarditem3QT = 1, rewarditem3 = nil, item3name = nil, rewardmoney = 100.0, rewardgold = 0.0},
[67]   = {requiredxp = 6700 ,  rewarditem1QT = 1, rewarditem1 = nil, item1name = nil, rewarditem2QT = 1, rewarditem2 = nil, item2name = nil, rewarditem3QT = 1, rewarditem3 = nil, item3name = nil, rewardmoney = 100.0, rewardgold = 0.0},
[68]   = {requiredxp = 6800 ,  rewarditem1QT = 1, rewarditem1 = nil, item1name = nil, rewarditem2QT = 1, rewarditem2 = nil, item2name = nil, rewarditem3QT = 1, rewarditem3 = nil, item3name = nil, rewardmoney = 100.0, rewardgold = 0.0},
[69]   = {requiredxp = 6900 ,  rewarditem1QT = 1, rewarditem1 = nil, item1name = nil, rewarditem2QT = 1, rewarditem2 = nil, item2name = nil, rewarditem3QT = 1, rewarditem3 = nil, item3name = nil, rewardmoney = 100.0, rewardgold = 0.0},
[70]   = {requiredxp = 7000 ,  rewarditem1QT = 1, rewarditem1 = nil, item1name = nil, rewarditem2QT = 1, rewarditem2 = nil, item2name = nil, rewarditem3QT = 1, rewarditem3 = nil, item3name = nil, rewardmoney = 100.0, rewardgold = 0.0},
[71]   = {requiredxp = 7100 ,  rewarditem1QT = 1, rewarditem1 = nil, item1name = nil, rewarditem2QT = 1, rewarditem2 = nil, item2name = nil, rewarditem3QT = 1, rewarditem3 = nil, item3name = nil, rewardmoney = 100.0, rewardgold = 0.0},
[72]   = {requiredxp = 7200 ,  rewarditem1QT = 1, rewarditem1 = nil, item1name = nil, rewarditem2QT = 1, rewarditem2 = nil, item2name = nil, rewarditem3QT = 1, rewarditem3 = nil, item3name = nil, rewardmoney = 100.0, rewardgold = 0.0},
[73]   = {requiredxp = 7300 ,  rewarditem1QT = 1, rewarditem1 = nil, item1name = nil, rewarditem2QT = 1, rewarditem2 = nil, item2name = nil, rewarditem3QT = 1, rewarditem3 = nil, item3name = nil, rewardmoney = 100.0, rewardgold = 0.0},
[74]   = {requiredxp = 7400 ,  rewarditem1QT = 1, rewarditem1 = nil, item1name = nil, rewarditem2QT = 1, rewarditem2 = nil, item2name = nil, rewarditem3QT = 1, rewarditem3 = nil, item3name = nil, rewardmoney = 100.0, rewardgold = 0.0},
[75]   = {requiredxp = 7500 ,  rewarditem1QT = 1, rewarditem1 = nil, item1name = nil, rewarditem2QT = 1, rewarditem2 = nil, item2name = nil, rewarditem3QT = 1, rewarditem3 = nil, item3name = nil, rewardmoney = 100.0, rewardgold = 0.0},
[76]   = {requiredxp = 7600 ,  rewarditem1QT = 1, rewarditem1 = nil, item1name = nil, rewarditem2QT = 1, rewarditem2 = nil, item2name = nil, rewarditem3QT = 1, rewarditem3 = nil, item3name = nil, rewardmoney = 100.0, rewardgold = 0.0},
[77]   = {requiredxp = 7700 ,  rewarditem1QT = 1, rewarditem1 = nil, item1name = nil, rewarditem2QT = 1, rewarditem2 = nil, item2name = nil, rewarditem3QT = 1, rewarditem3 = nil, item3name = nil, rewardmoney = 100.0, rewardgold = 0.0},
[78]   = {requiredxp = 7800 ,  rewarditem1QT = 1, rewarditem1 = nil, item1name = nil, rewarditem2QT = 1, rewarditem2 = nil, item2name = nil, rewarditem3QT = 1, rewarditem3 = nil, item3name = nil, rewardmoney = 100.0, rewardgold = 0.0},
[79]   = {requiredxp = 7900 ,  rewarditem1QT = 1, rewarditem1 = nil, item1name = nil, rewarditem2QT = 1, rewarditem2 = nil, item2name = nil, rewarditem3QT = 1, rewarditem3 = nil, item3name = nil, rewardmoney = 100.0, rewardgold = 0.0},
[80]   = {requiredxp = 8000 ,  rewarditem1QT = 1, rewarditem1 = nil, item1name = nil, rewarditem2QT = 1, rewarditem2 = nil, item2name = nil, rewarditem3QT = 1, rewarditem3 = nil, item3name = nil, rewardmoney = 100.0, rewardgold = 0.0},
[81]   = {requiredxp = 8100 ,  rewarditem1QT = 1, rewarditem1 = nil, item1name = nil, rewarditem2QT = 1, rewarditem2 = nil, item2name = nil, rewarditem3QT = 1, rewarditem3 = nil, item3name = nil, rewardmoney = 100.0, rewardgold = 0.0},
[82]   = {requiredxp = 8200 ,  rewarditem1QT = 1, rewarditem1 = nil, item1name = nil, rewarditem2QT = 1, rewarditem2 = nil, item2name = nil, rewarditem3QT = 1, rewarditem3 = nil, item3name = nil, rewardmoney = 100.0, rewardgold = 0.0},
[83]   = {requiredxp = 8300 ,  rewarditem1QT = 1, rewarditem1 = nil, item1name = nil, rewarditem2QT = 1, rewarditem2 = nil, item2name = nil, rewarditem3QT = 1, rewarditem3 = nil, item3name = nil, rewardmoney = 100.0, rewardgold = 0.0},
[84]   = {requiredxp = 8400 ,  rewarditem1QT = 1, rewarditem1 = nil, item1name = nil, rewarditem2QT = 1, rewarditem2 = nil, item2name = nil, rewarditem3QT = 1, rewarditem3 = nil, item3name = nil, rewardmoney = 100.0, rewardgold = 0.0},
[85]   = {requiredxp = 8500 ,  rewarditem1QT = 1, rewarditem1 = nil, item1name = nil, rewarditem2QT = 1, rewarditem2 = nil, item2name = nil, rewarditem3QT = 1, rewarditem3 = nil, item3name = nil, rewardmoney = 100.0, rewardgold = 0.0},
[86]   = {requiredxp = 8600 ,  rewarditem1QT = 1, rewarditem1 = nil, item1name = nil, rewarditem2QT = 1, rewarditem2 = nil, item2name = nil, rewarditem3QT = 1, rewarditem3 = nil, item3name = nil, rewardmoney = 100.0, rewardgold = 0.0},
[87]   = {requiredxp = 8700 ,  rewarditem1QT = 1, rewarditem1 = nil, item1name = nil, rewarditem2QT = 1, rewarditem2 = nil, item2name = nil, rewarditem3QT = 1, rewarditem3 = nil, item3name = nil, rewardmoney = 100.0, rewardgold = 0.0},
[88]   = {requiredxp = 8800 ,  rewarditem1QT = 1, rewarditem1 = nil, item1name = nil, rewarditem2QT = 1, rewarditem2 = nil, item2name = nil, rewarditem3QT = 1, rewarditem3 = nil, item3name = nil, rewardmoney = 100.0, rewardgold = 0.0},
[89]   = {requiredxp = 8900 ,  rewarditem1QT = 1, rewarditem1 = nil, item1name = nil, rewarditem2QT = 1, rewarditem2 = nil, item2name = nil, rewarditem3QT = 1, rewarditem3 = nil, item3name = nil, rewardmoney = 100.0, rewardgold = 0.0},
[90]   = {requiredxp = 9000 ,  rewarditem1QT = 1, rewarditem1 = nil, item1name = nil, rewarditem2QT = 1, rewarditem2 = nil, item2name = nil, rewarditem3QT = 1, rewarditem3 = nil, item3name = nil, rewardmoney = 100.0, rewardgold = 0.0},
[91]   = {requiredxp = 9100 ,  rewarditem1QT = 1, rewarditem1 = nil, item1name = nil, rewarditem2QT = 1, rewarditem2 = nil, item2name = nil, rewarditem3QT = 1, rewarditem3 = nil, item3name = nil, rewardmoney = 100.0, rewardgold = 0.0},
[92]   = {requiredxp = 9200 ,  rewarditem1QT = 1, rewarditem1 = nil, item1name = nil, rewarditem2QT = 1, rewarditem2 = nil, item2name = nil, rewarditem3QT = 1, rewarditem3 = nil, item3name = nil, rewardmoney = 100.0, rewardgold = 0.0},
[93]   = {requiredxp = 9300 ,  rewarditem1QT = 1, rewarditem1 = nil, item1name = nil, rewarditem2QT = 1, rewarditem2 = nil, item2name = nil, rewarditem3QT = 1, rewarditem3 = nil, item3name = nil, rewardmoney = 100.0, rewardgold = 0.0},
[94]   = {requiredxp = 9400 ,  rewarditem1QT = 1, rewarditem1 = nil, item1name = nil, rewarditem2QT = 1, rewarditem2 = nil, item2name = nil, rewarditem3QT = 1, rewarditem3 = nil, item3name = nil, rewardmoney = 100.0, rewardgold = 0.0},
[95]   = {requiredxp = 9500 ,  rewarditem1QT = 1, rewarditem1 = nil, item1name = nil, rewarditem2QT = 1, rewarditem2 = nil, item2name = nil, rewarditem3QT = 1, rewarditem3 = nil, item3name = nil, rewardmoney = 100.0, rewardgold = 0.0},
[96]   = {requiredxp = 9600 ,  rewarditem1QT = 1, rewarditem1 = nil, item1name = nil, rewarditem2QT = 1, rewarditem2 = nil, item2name = nil, rewarditem3QT = 1, rewarditem3 = nil, item3name = nil, rewardmoney = 100.0, rewardgold = 0.0},
[97]   = {requiredxp = 9700 ,  rewarditem1QT = 1, rewarditem1 = nil, item1name = nil, rewarditem2QT = 1, rewarditem2 = nil, item2name = nil, rewarditem3QT = 1, rewarditem3 = nil, item3name = nil, rewardmoney = 100.0, rewardgold = 0.0},
[98]   = {requiredxp = 9800 ,  rewarditem1QT = 1, rewarditem1 = nil, item1name = nil, rewarditem2QT = 1, rewarditem2 = nil, item2name = nil, rewarditem3QT = 1, rewarditem3 = nil, item3name = nil, rewardmoney = 100.0, rewardgold = 0.0},
[99]   = {requiredxp = 9900 ,  rewarditem1QT = 1, rewarditem1 = nil, item1name = nil, rewarditem2QT = 1, rewarditem2 = nil, item2name = nil, rewarditem3QT = 1, rewarditem3 = nil, item3name = nil, rewardmoney = 100.0, rewardgold = 0.0},
[100]  = {requiredxp = 10000,  rewarditem1QT = 1, rewarditem1 = nil, item1name = nil, rewarditem2QT = 1, rewarditem2 = nil, item2name = nil, rewarditem3QT = 1, rewarditem3 = nil, item3name = nil, rewardmoney = 100.0, rewardgold = 0.0},
}


-- COMPOSITE LIST 

-- "COMPOSITE_LOOTABLE_AGARITA_DEF",                                             -- 0x35835260
-- "COMPOSITE_LOOTABLE_ALASKAN_GINSENG_ROOT_DEF",                                -- 0x791CB060
-- "COMPOSITE_LOOTABLE_AMERICAN_GINSENG_ROOT_DEF",                               -- 0xA8C87FE6
-- "COMPOSITE_LOOTABLE_BAY_BOLETE_DEF",                                          -- 0xD0EE5547
-- "COMPOSITE_LOOTABLE_BITTERWEED_DEF",                                          -- 0xC64C3DD6
-- "COMPOSITE_LOOTABLE_BLACK_BERRY_DEF",                                         -- 0x218ACC70
-- "COMPOSITE_LOOTABLE_BLACK_CURRANT_DEF",                                       -- 0x8A7249DF
-- "COMPOSITE_LOOTABLE_BLOODFLOWER_DEF",                                         -- 0x0325F1BB
-- "COMPOSITE_LOOTABLE_BURDOCK_ROOT_DEF",                                        -- 0xB12DCCFC
-- "COMPOSITE_LOOTABLE_CARDINAL_FLOWER_DEF",                                     -- 0x0CEE3AC1
-- "COMPOSITE_LOOTABLE_CHANTERELLES_DEF",                                        -- 0x52329977
-- "COMPOSITE_LOOTABLE_CHOC_DAISY_DEF",                                          -- 0x94CBA1BA
-- "COMPOSITE_LOOTABLE_COMMON_BULRUSH_DEF",                                      -- 0x0E008DF3
-- "COMPOSITE_LOOTABLE_CREEKPLUM_DEF",                                           -- 0x694E84DD
-- "COMPOSITE_LOOTABLE_CREEPING_THYME_DEF",                                      -- 0x58F87EA3
-- "COMPOSITE_LOOTABLE_DESERT_SAGE_DEF",                                         -- 0x934CDF53
-- "COMPOSITE_LOOTABLE_ENGLISH_MACE_DEF",                                        -- 0x131DAC12
-- "COMPOSITE_LOOTABLE_EVERGREEN_HUCKLEBERRY_DEF",                               -- 0xCFA5E0D2
-- "COMPOSITE_LOOTABLE_GOLDEN_CURRANT_DEF",                                      -- 0xC8B01F47
-- "COMPOSITE_LOOTABLE_HARRIETUM_OFFICINALIS_DEF",                               -- 0xCDF5AE40
-- "COMPOSITE_LOOTABLE_HUMMINGBIRD_SAGE_DEF",                                    -- 0x2781F602
-- "COMPOSITE_LOOTABLE_INDIAN_TOBACCO_DEF",                                      -- 0x7C9228C5
-- "COMPOSITE_LOOTABLE_MILKWEED_DEF",                                            -- 0x7E2FD03E
-- "COMPOSITE_LOOTABLE_OLEANDER_SAGE_DEF",                                       -- 0xAB009D3B
 
-- "COMPOSITE_LOOTABLE_OREGANO_DEF",                                             -- 0x52902D4F
-- "COMPOSITE_LOOTABLE_PARASOL_MUSHROOM_DEF",                                    -- 0xB716E0C5
-- "COMPOSITE_LOOTABLE_PRAIRIE_POPPY_DEF",                                       -- 0x22A9A3F5
-- "COMPOSITE_LOOTABLE_RAMS_HEAD_DEF",                                           -- 0xDBDD6BA6
-- "COMPOSITE_LOOTABLE_RED_RASPBERRY_DEF",                                       -- 0x1B68A274
-- "COMPOSITE_LOOTABLE_RED_SAGE_DEF",                                            -- 0xD3D1E587
-- "COMPOSITE_LOOTABLE_SALTBUSH_DEF",                                            -- 0xC5333EEE
-- "COMPOSITE_LOOTABLE_TEXAS_BONNET_DEF",                                        -- 0x86A0FBB0
-- "COMPOSITE_LOOTABLE_VIOLET_SNOWDROP_DEF",                                     -- 0x1F3E2AA9
-- "COMPOSITE_LOOTABLE_WILD_CARROT_DEF",                                         -- 0x22C2756C
-- "COMPOSITE_LOOTABLE_WILD_FEVERFEW_DEF",                                       -- 0xC528406F
-- "COMPOSITE_LOOTABLE_WILD_MINT_DEF",                                           -- 0x6B70E62C
-- "COMPOSITE_LOOTABLE_WILD_RHUBARB_DEF",                                        -- 0x16969442
-- "COMPOSITE_LOOTABLE_WINTERGREEN_BERRY_DEF",                                   -- 0x0B6751EF
-- "COMPOSITE_LOOTABLE_WISTERIA_DEF",                                            -- 0xD46AB32E
-- "COMPOSITE_LOOTABLE_YARROW_DEF",                                              -- 0x17C723C8

-- ITEM LIST 
--provision_wldflwr_agarita	 
--provision_wldflwr_bitterweed	 
--provision_wldflwr_blood_flower	 
--provision_wldflwr_cardinal_flower	 
--provision_wldflwr_chocolate_daisy	 
--provision_wldflwr_creek_plum	 
--provision_wldflwr_texas_blue_bonnet	 
--provision_wldflwr_wild_rhubarb	 
--provision_wldflwr_wisteria	 
--consumable_herb_alaskan_ginseng	 
--consumable_herb_american_ginseng 
--consumable_herb_bay_bolete	 
--consumable_herb_black_berry	 
--consumable_herb_black_currant	 
--consumable_herb_burdock_root	 
--consumable_herb_chanterelles	 
--consumable_herb_common_bulrush	 
--consumable_herb_creeping_thyme	 
--consumable_herb_currant 
--consumable_herb_desert_sage	 
--consumable_herb_english_mace	 
--consumable_herb_evergreen_huckleberry	 
--consumable_herb_ginseng	 
--consumable_herb_golden_currant 
--consumable_herb_harrietum
--consumable_herb_hummingbird_sage 
--consumable_herb_indian_tobacco 
--consumable_herb_milkweed	 
--consumable_herb_oleander_sage 
--consumable_herb_oregano 
--consumable_herb_parasol_mushroom 
--consumable_herb_prairie_poppy	 
--consumable_herb_rams_head		 
--consumable_herb_red_raspberry	 
--consumable_herb_red_sage	 
--consumable_herb_sage		 
--consumable_herb_saltbush	 
--consumable_herb_violet_snowdrop	 
--consumable_herb_wild_carrots	 
--consumable_herb_wild_feverfew	 
--consumable_herb_wild_mint		 
--consumable_herb_wintergreen_berry	 
--consumable_herb_yarrow	 