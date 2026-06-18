Config = {}
 
-- VERSION 4.0  - 01.02.26
 
--------------------------------------------------
			-- FRAMEWORK SELECTION --
-------------------------------------------------- 

--Turn your framework to true and all the others to false
Config.REDEMRP2023REBOOT 				 = false
Config.VORP              				 = true
Config.RSG               				 = false


Config.Debug                             = false 
Config.INSTANCE_DELETE_DELAY			 = 100

Config.EnableNotifications               = true     -- Enable / Disable notifications  
Config.CallMyboatEverwyhere              = true     -- If enabled you will be able to spawn your boat everywhere by using the menu command "MENU_QUICK_ACCESS"
Config.StoreBoatAnywhere                 = true     -- Players can store their boat anywhere if true. If set to false, players can store their boat only when they're close to the boat shop
 
Config.SpawnBoatByCommand                = true 	-- If enabled the MENU_QUICK_ACCESS command will be enabled 
Config.SPAWN_COMMAND                     = "boat_menu"
 
Config.AutomaticboatDelete               = true
Config.AutomaticboatDeleteDistance       = 90
 
Config.RepairPrice      				 = 20 		-- Repair price in dollars at the boat shop 
 
Config.SharedStash                		 = true 	-- Turn this to true if you want boat stashes to be accessible by other players. It will automatically activate when the owner of the boat opens it's stash. Keep in mind the boat must be stopped and the "driver" seat unoccupied.						  
Config.StashRoleRestrictions      		 = false 
Config.StashRoles = {								-- Roles that are authorized to search other player's boats
"horsetrainer",
"averagerider",   
"trapper",
}

Config.Deep_Waters_Fix  				 = true     -- If true it will apply a fix to prevent boat from sinking in deep waters


Config.MIN_BIG_BOATS_DEPTH_SPAWN     	 = 0.0 		-- Minimum depth to allow big boats to spawn 

--v4.0 addition 
Config.STASH_NAME = "Boat"
--------------------------------------------------
		     -- BOAT OWNED LIMIT  --
-------------------------------------------------- 

--------------------------------- 
--  VORP STASH OPTIONS --
--------------------------------- 
Config.acceptWeapons        = true
Config.shared               = true
Config.ignoreItemStackLimit = true
Config.whitelistItems       = false
Config.UsePermissions       = false
Config.UseBlackList         = true
Config.whitelistWeapons     = false
-- see https://vorpcore.github.io/VORP_Documentation/api/inventory#inventory-custominventory for official documentation 
----------------------------------- 

--------------------------------------------------
		     -- DISCORD WEBHOOKS --
-------------------------------------------------- 

Config.WebhookUrl                        	= ""
Config.WebhookMainTitle                  	= "Boat Shop"
	
-- PURCHASE FROM BOAT SHOP EVENT --         	   
Config.UseWebhookPurchaseFromShop     	    = false  -- Turn to true if you want to use the Discord Webhook for this event
Config.WebhookPurchaseTitle                 = "Boat Purchase"
Config.WebhookPurchase                      = "Purchased a"
Config.WebhookPurchaseFor                   = "for"
Config.WebhookPurchase2                  	= "and"
Config.WebhookPurchase3                  	= "Gold"
	
-- PURCHASE FROM PLAYER EVENT --         	    
Config.UseWebhookPurchaseFromPlayer      	= false -- Turn to true if you want to use the Discord Webhook for this event
Config.WebhookPurchaseFromPlayer         	= "Purchased a boat from "
	
-- SOLD BOAT TO THE BOAT SHOP --               	               
Config.UseWebhookSold                    	= false -- Turn to true if you want to use the Discord Webhook for this event
Config.WebhookSoldTitle                  	= "Boat Sell"
Config.WebhookSoldBoatNamed             	= "sold a boat named"
Config.WebhookSoldBoatFor               	= "for"	
Config.WebhookSoldBoat2                 	= "and"	
Config.WebhookSoldBoat3                 	= "gold"

 
------------------- 
  --  PROMPTS  --
------------------- 
Config.PromptBoatShop    				    =  "Boat Shop"       
Config.PromptOpen        				    =  "Open Shop"           
Config.PromptSell        				    =  "Sell Boat"           
Config.PromptStash       				    =  "Open Stash"              
Config.PromptStashTitle  				    =  "Stash"  
Config.PromptStopSell    				    =  "Stop Selling"                
Config.PromptStore       				    =  "Store"     
Config.PromptStored      				    =  "Boat sent back to the nearest boat shop"     
Config.PromptCarry       				    =  "Carry"               
Config.PromptDrop        				    =  "Drop"                
Config.PromptBuyBoat     				    =  "Buy"                 
Config.PromptCamera      				    =  "Change Camera"       
Config.PromptCameraTitle 				    =  "Camera"       
 
 
Config.KeyPromptOpen        		        =  0x43DBF61F -- ENTER
Config.KeyPromptSell        		        =  0x43DBF61F -- ENTER	
Config.KeyPromptStash       		        =  0xD8F73058 -- U	
Config.KeyPromptSharedtash  		        =  0xD8F73058 -- U	
Config.KeyPromptStopSell  			        =  0xD8F73058 -- U	
Config.KeyPromptStore     			        =  0xD8CF0C95 -- C	
Config.KeyPromptCarry     			        =  0x8AAA0AD4 -- LEFT ALT 
Config.KeyPromptDrop      			        =  0x8AAA0AD4 -- LEFT ALT 	
Config.KeyPromptBuyBoat   			        =  0x43DBF61F -- ENTER	
Config.KeyPromptCamera    			        =  0xD8CF0C95 -- C	
 
------------------------
  --  GENERAL TEXT  --
------------------------ 
    Config.Boat                            = "Boats"
    Config.BoatMenu              		   = "Boat Menu"
    Config.CancelMission                   = "Cancel Mission"             -- For SIREVLC_BOATS_missions 
	Config.CancelMissionDesc               = "Cancel the ongoing Mission" -- For SIREVLC_BOATS_missions 
	Config.TextNotifAutomaticDelete        = "Your boat was too far away and has been sent back to the nearest boat shop"     
	Config.SpawnOccupied                   = "The spawn is occupied"			           
 	Config.BoatDestroyed                   = "Your boat has been destroyed"
	Config.BoatDestroyed2                  = "Go to the nearest boat shop to repair it"
	Config.PurchaseBoats                   = "Buy a boat"  
    Config.BoatShop                        = "Boat Shop"
    Config.SpawnSpotBusy                   = "The Spawn spot is busy"
    Config.StoreBoatFirst                  = "You must store your boat first"
    Config.SellToPlayer                    = "Sell Price:"
	Config.SoldBoat                        = "You sold your boat"	
	Config.SoldBoat2                       = "and"	
    Config.BuyBoatNoJob                    = "You dont have the required job to do this"
    Config.BuyBoatNoMoney                  = "You dont have enough money"
    Config.BoatPurchased                   = "You have purchased a boat"
    Config.CustomizationNoMoney            = "You dont have enough money"
    Config.ComponentPurchased              = "You bought a new component"
    Config.SellBoat                        = "Sell Boat"
    Config.BoatFarAway                     = "Your boat is too far away bring it closer"
    Config.AddName                         = "Add Name"
    Config.AddPrice                        = "Price:"
    Config.OpenShopNoJob                   = "You don't have the required job"
	
	Config.TextNotifGoldSign			   = "Gold" 
	Config.textNotifStartedSellingToPlayer = "You are now waiting for someone to purchase your boat"
	Config.TextNotifGoodCondition  		   = "Good Condition"
	Config.TextNotifDestroyed      		   = "Destroyed"
	Config.TextNotifNotDestroyed   		   = "Your boat is not destroyed"
	Config.TextNotifManageSpawn    		   = "Spawn Boat"
	Config.TextNotifManageSpawnDesc		   = "Spawn this boat"
	Config.TextNotifRepairFirst    		   = "Your boat is destroyed repair it first"
	Config.TextNotifBeInWater    		   = "You must be in water to make your boat spawn"
	Config.TextNotifRepaired       		   = "Your boat has been repaired"
	Config.TextNotifBoatSpawned    		   = "Boat Spawned"
	Config.TextNotifBoatNotDeepEnough      = "Water isn't deep enough here"
	Config.TextNotifOwnedboats     		   = "Owned Boats"
	Config.TextNotifWeightLimit    		   = "Weight Limit: "
 
    Config.PurchaseMenu                    = "Buy Boats"
    Config.Tints                           = "Tints"
    Config.Liveries                        = "Liveries"
    Config.Extras                          = "Extras"
    Config.Lanterns                        = "Lanterns"
    Config.PropSets                        = "Propsets"
    Config.OwnedBoats                      = "Owned Boats"
    Config.SelectBoat                      = "Select Boat"
    Config.BuyBoatDesc                     = "Select and buy"
    Config.BuyBoatJobDesc                  = "Buy Boat<br>Job Requirement:"
    Config.BoatManage                      = "Manage Boat"
    Config.ManageDesc                      = "Manage your Boat"
    Config.ManageSpawn                     = "Spawn Boat"
	Config.ManageSpawnDesc                 = "Spawn your boat"
    Config.ManageRepair                    = "Repair Boat"
    Config.ManageRepairDesc                = "Repair for $"
    Config.ManageDelete                    = "Sell Boat"
    Config.ManageDeleteDesc                = "Sell for $"
    Config.ManageCustomize                 = "Customize Boat"
    Config.ManageCustomizeDesc             = "Tints Liveries etc"
    Config.Customize                       = "Customize"
    Config.NoComponent                     = "No customization available for this boat"
	Config.ConfirmDeleteBoat               = "Confirm Delete"
	Config.No                              = "No"
	Config.Yes                             = "Yes"
	
--	v4.0 addition 
	Config.TextNotifNoValidLocker          = "There's no valid stash for this boat"
	Config.TextNotifDontOwnBoat		       = "You don't own any boats"
	Config.TextNotifStashlimit			   = "Stashlimit:"
	Config.TextBoatRepairState			   = "Wagon Condition:"
	Config.TextBoatRepairPrice			   = "Repair Price:"
	Config.TextNotifGoodCondition		   = "Good condition"
	Config.TextNotifDestroyed              = "Destroyed"
	Config.TextNotifBoatInfo               = "Boat info:"
	Config.TextNotifJobRequired			   = "Jobs:"
	Config.TextNotifOnlyForbiddenBoats     = "You only own forbidden boats in this shop"
	
-----------------------------------------
	 -- CAMERA SETTINGS -- 
-----------------------------------------
Config.CAMERA_KEY_CHANGE_TEXT              		= " CAMERA CONTROLS: \n Forward - W \n Backward - S \n Left - A \n Right - D \n Slide Forward - Q \n Slide Backwards - E \n Up - JUMP \n Down - SHIFT \n Speed Up - Mouse Wheel Up \n Speed Down - Mouse Wheel Down"
Config.CAMERA_KEY_NOTIF_DURATION            	= 3000

Config.MAX_CAM_DISTANCE                         = 30.0
Config.MAX_SPEED 	  							= 0.12
Config.SPEED 	  								= 0.10
Config.SPEED_MIN 	  							= 0.01
Config.SPEED_INCREASE 							= 0.01
				
Config.SPEED_MIN_ADJUSTMENT 					= 0.001
Config.SPEED_MAX_ADJUSTMENT 					= 100.0
Config.SPEED_INCREASE_ADJUST 					= 0.001
Config.SPEED_ADJUST 							= 0.01
Config.SPEED_ROTATE_INCREASE 					= 0.1
Config.SPEED_ROTATE 							= 1.0
				
Config.SPEED_INCREASE_KEY       				= {`INPUT_CREATOR_LT`, `INPUT_PREV_WEAPON`} -- PAGE UP, MOUSE WHEEL UP
Config.SPEED_DECREASE_KEY       				= {`INPUT_CREATOR_RT`, `INPUT_NEXT_WEAPON`} -- PAGE DOWN, MOUSE WHEEL DOWN
Config.CONTROL_UP               				= `INPUT_JUMP`   			 				-- SPACEBAR
Config.CONTROL_DOWN             				= `INPUT_SPRINT` 			 				-- SHIFT
Config.CONTROL_FORWARD          				= `INPUT_MOVE_UP_ONLY`    	 				-- W
Config.CONTROL_BACKWARD         				= `INPUT_MOVE_DOWN_ONLY`  	 				-- S
Config.CONTROL_LEFT             				= `INPUT_MOVE_LEFT_ONLY`  	 				-- A
Config.CONTROL_RIGHT            				= `INPUT_MOVE_RIGHT_ONLY` 	 				-- D
Config.SLIDE_LEFT            					= `INPUT_DIVE`   							-- Q
Config.SLIDE_RIGHT            					= `INPUT_GAME_MENU_TAB_RIGHT`				-- E 
 
-- LIST OF BOAT MODELS THAT CAN BE CARRIED 
Config.CarriableBoatModels = {
    `canoe`,
    `canoeTreeTrunk`,
    `pirogue2`,
    `pirogue`,
    `rowboat`,
    `rowboatSwamp02`,
    `rowboatSwamp`,
}

-- BOAT MODELS 
Config.BoatModels = {
    `boatsteam02x`,
    `canoe`,
    `canoeTreeTrunk`,
    `keelboat`,
    `pirogue2`,
    `pirogue`,
    `rowboat`,
    `rowboatSwamp02`,
    `rowboatSwamp`,
}
 
 
Config.BoatShops = {
    [1] = {
        name                  = "Blackwater",
        blipenabled           = true,
		blipname              = "Boat Shop",
        blipspritehash        = 2033397166,
		large_boats_enabled   = true,
        pos                   = vector3(-687.7609252929688, -1244.353759765625, 43.11135864257812), 		-- PROMPT AND BLIP LOCATION 
        boatpos               = vector4(-673.95, -1242.17, 40.5, 0.15),										-- BOAT POS FOR PREVIEW 
        boatpos_large         = vector4(-673.95, -1242.17, 40.5, 0.15),
        boatspawnpos_small    = vector4(-673.95, -1242.17, 40.5, 0.15),
        boatspawnpos_large    = vector4(-673.95, -1242.17, 40.5, 0.15),
		cameraoffset          = {3.0,3.0},		
        rolerestriction       = false,
        rolesallowed          = {"none"},
		sell_multiplier       = 0.5,		
		purchase_multiplier   = 1.0,		
    },
 
    [2] = {
        name              	  = "Fishing Cabin",
		blipenabled       	  = true,
		blipname          	  = "Boat Shop",
		blipspritehash    	  = 2033397166,
		large_boats_enabled   = false,
        pos               	  = vector3(340.72, -679.45, 42.78),
        boatpos 	          = vector4(334.13, -691.92, 40.5, 60.68),
        boatpos_large         = vector4(334.13, -691.92, 40.5, 60.68),
        boatspawnpos_small    = vector4(334.13, -691.92, 40.5, 60.68),
        boatspawnpos_large    = vector4(334.13, -691.92, 40.5, 60.68),
		cameraoffset      	  = {-5.0,5.0},
        rolerestriction   	  = false,
        rolesallowed      	  = {"none"},
		sell_multiplier   	  = 0.5,
		purchase_multiplier   = 1.0,		
    },	
 
    [3] = {
        name              		= "Rhodes",
		blipenabled       		= true,
		blipname          		= "Boat Shop",
		blipspritehash    		= 2033397166,
		large_boats_enabled     = true,		
        pos               		= vector3(618.6934204101562, -1258.929931640625, 41.70939636230469),
        boatpos           		= vector4(594.01, -1273.86, 40.50, 30.37),
        boatpos_large           = vector4(594.01, -1273.86, 40.50, 30.37),
        boatspawnpos_small      = vector4(594.01, -1273.86, 40.50, 30.37),
        boatspawnpos_large      = vector4(594.01, -1273.86, 40.50, 30.37),
		cameraoffset      		= {3.0,3.0},		
        rolerestriction   		= false,
        rolesallowed      		= {"none"},
		sell_multiplier   		= 0.5,
		purchase_multiplier  	= 1.0,		
    },	
	
    [4] = {
        name              	  = "Braithwaite Manor",
		blipenabled       	  = true,
		blipname          	  = "Boat Shop",
		blipspritehash    	  = 2033397166,
		large_boats_enabled   = true,		
        pos               	  = vector3(889.109130859375, -1776.858154296875, 42.13712310791015),
        boatpos           	  = vector4(870.45, -1763.31, 40.40, 46.44),
        boatpos_large         = vector4(870.45, -1763.31, 40.40, 46.44),
        boatspawnpos_small    = vector4(870.45, -1763.31, 40.40, 46.44),
        boatspawnpos_large    = vector4(870.45, -1763.31, 40.40, 46.44),
		cameraoffset      	  = {3.0,3.0},		
        rolerestriction   	  = false,
        rolesallowed      	  = {"none"},
		sell_multiplier   	  = 0.5,
		purchase_multiplier   = 1.0,		
    },	
	
    [5] = {
        name              	  = "Shady Belle",
		blipenabled       	  = true,
		blipname          	  = "Boat Shop",
		blipspritehash    	  = 2033397166,
		large_boats_enabled   = false,		
        pos               	  = vector3(2099.39599609375, -1813.479248046875, 42.83724594116211),
        boatpos           	  = vector4(2106.72 , -1808.62 , 40.40, 29.64),
        boatpos_large         = vector4(2106.72 , -1808.62 , 40.40, 29.64),
        boatspawnpos_small    = vector4(2106.72 , -1808.62 , 40.40, 29.64),
        boatspawnpos_large    = vector4(2106.72 , -1808.62 , 40.40, 29.64),
		cameraoffset      	  = {3.0,3.0},		
        rolerestriction   	  = false,
        rolesallowed      	  = {"none"},
		sell_multiplier   	  = 0.5,
		purchase_multiplier   = 1.0,		
    },		
	
    [6] = {
        name              	 = "Saint Denis",
		blipenabled       	 = true,
		blipname          	 = "Boat Shop",
		blipspritehash    	 = 2033397166,
		large_boats_enabled   = true,		
        pos               	 = vector3(2705.311279296875, -1531.4652099609375, 44.15935134887695),
        boatpos           	 = vector4(2730.22, -1600.11, 40.5, -67.79),
        boatpos_large        = vector4(2730.22, -1600.11, 40.5, -67.79),
        boatspawnpos_small   = vector4(2730.22, -1600.11, 40.5, -67.79),
        boatspawnpos_large   = vector4(2730.22, -1600.11, 40.5, -67.79),
		cameraoffset      	 = {3.0,3.0},		
        rolerestriction   	 = false,
        rolesallowed      	 = {"none"},
		sell_multiplier   	 = 0.5,
		purchase_multiplier  = 1.0,		
    },	
 
    [7] = {
        name              	 = "Bayou",
		blipenabled       	 = true,
		blipname          	 = "Boat Shop",
		blipspritehash    	 = 2033397166,
		large_boats_enabled  = false,		
        pos               	 = vector3(2006.1168212890625, -763.5479736328125, 41.89657211303711),
        boatpos           	 = vector4(1999.03, -768.02, 40.40, 38.62),
        boatpos_large        = vector4(1999.03, -768.02, 40.40, 38.62),
        boatspawnpos_small   = vector4(1999.03, -768.02, 40.40, 38.62),
        boatspawnpos_large   = vector4(1999.03, -768.02, 40.40, 38.62),
		cameraoffset      	 = {3.0,3.0},		
        rolerestriction   	 = false,
        rolesallowed      	 = {"none"},
		sell_multiplier   	 = 0.5,
		purchase_multiplier  = 1.0,		
    },	
 
    [8] = {
        name              		= "Caliga Hall",
		blipenabled       		= true,
		blipname          		= "Boat Shop",
		blipspritehash    		= 2033397166,
		large_boats_enabled     = false,		
        pos               		= vector3(1822.51953125, -1201.97802734375, 42.17754745483398),
        boatpos           		= vector4(1818.44, -1200.54, 40.40, 145.0),
        boatpos_large           = vector4(1818.44, -1200.54, 40.40, 145.0),
        boatspawnpos_small      = vector4(1818.44, -1200.54, 40.40, 145.0),
        boatspawnpos_large      = vector4(1818.44, -1200.54, 40.40, 145.0),
		cameraoffset      		= {3.0,3.0},		
        rolerestriction   		= false,
        rolesallowed      		= {"none"},
		sell_multiplier   		= 0.5,
		purchase_multiplier   	= 1.0,		
    },	
 
    [9] = {
        name              		= "Inbred Village",
		blipenabled       		= true,
		blipname          		= "Boat Shop",
		blipspritehash    		= 2033397166,
		large_boats_enabled     = false,		
        pos               		= vector3(2492.20, 796.43, 67.29),
        boatpos           		= vector4(2487.47, 800.08, 65.98, 140.0),
        boatpos_large           = vector4(2487.47, 800.08, 65.98, 140.0),
        boatspawnpos_small      = vector4(2487.47, 800.08, 65.98, 140.0),
        boatspawnpos_large      = vector4(2487.47, 800.08, 65.98, 140.0),
		cameraoffset      		= {3.0,3.0},		
        rolerestriction   		= false,
        rolesallowed      		= {"none"},
		sell_multiplier   		= 0.5,
		purchase_multiplier   	= 1.0,		
    },		
 
		[10] = {
        name             		= "Wapiti Reservation",
		blipenabled      		= true,
		blipname         		= "Boat Shop",
		blipspritehash   		= 2033397166,
		large_boats_enabled     = false,		
        pos              		= vector3(630.3692626953125, 2198.90869140625, 221.8800811767578),
        boatpos          		= vector4(640.92, 2195.98, 220.40, 77.09),
        boatpos_large           = vector4(640.92, 2195.98, 220.40, 77.09),
        boatspawnpos_small      = vector4(640.92, 2195.98, 220.40, 77.09),
        boatspawnpos_large      = vector4(640.92, 2195.98, 220.40, 77.09),
		cameraoffset     		= {3.0,3.0},		
        rolerestriction  		= false,
        rolesallowed     		= {"none"},
		sell_multiplier  		= 0.5,
		purchase_multiplier   	= 1.0,		
    },
 
	    [11] = {
        name              	 	= "San Luis River",
		blipenabled       	 	= true,
		blipname          	 	= "Boat Shop",
		blipspritehash    	 	= 2033397166,
		large_boats_enabled     = true,		
        pos               	 	= vector3(-2018.6434326171875, -3047.133056640625, -11.20542335510253),
        boatpos           	 	= vector4(-2012.03, -3056.71, -11.97, 117.32),
        boatpos_large           = vector4(-2012.03, -3056.71, -11.97, 117.32),
        boatspawnpos_small      = vector4(-2012.03, -3056.71, -11.97, 117.32), 
        boatspawnpos_large      = vector4(-2012.03, -3056.71, -11.97, 117.32), 		
		cameraoffset      	 	= {3.0,3.0},		
        rolerestriction   	 	= false,
        rolesallowed      	 	= {"none"},
		sell_multiplier   	 	= 0.5,
		purchase_multiplier  	= 1.0,		
    },
	
	    [12] = {
        name             		= "Van Horn",
		blipenabled      		= true,
		blipname         		= "Boat Shop",
		blipspritehash   		= 2033397166,
		large_boats_enabled     = true,		
        pos              		= vector3(2992.307373046875, 494.765625, 42.02073669433594),
        boatpos          		= vector4(3045.87, 511.78, 40.5, -5.13),
        boatpos_large           = vector4(3045.87, 511.78, 40.5, -5.13),
        boatspawnpos_small      = vector4(3045.87, 511.78, 40.5, -5.13),
        boatspawnpos_large      = vector4(3045.87, 511.78, 40.5, -5.13),
		cameraoffset     		= {3.0,3.0},		
        rolerestriction  		= false,
        rolesallowed     		= {"none"},
		sell_multiplier  		= 0.5,
		purchase_multiplier   	= 1.0,		
    },	
}
 
 
Config.ShopBoats = { 
    [1] = {
        name       = "Steam Boat",
        model      = `boatsteam02x`,
        price      = 1200,
        goldprice  = 0.0, -- THIS IS FOR VORP ONLY 
        jobreq     = false,
        jobs	   = {{DB_JOB = "horsetrainer", JOB_LABEL = "Horsetrainer" },},
		stashlimit = 20, -- THIS IS FOR VORP AND RSG ONLY
		slots      = 20, -- THIS IS FOR RSG ONLY		
    },
	
    [2] = {
        name       = "Canoe",
        model      = `canoe`,
        price      = 120,
		goldprice  = 0.0, -- THIS IS FOR VORP ONLY
        jobreq     = false,
        jobs	   = {{DB_JOB = "horsetrainer", JOB_LABEL = "Horsetrainer" },},		
 		stashlimit = 20, -- THIS IS FOR VORP AND RSG ONLY
		slots      = 20, -- THIS IS FOR RSG ONLY		
    },
	
    [3] = {
        name       = "Treetunk Canoe",
        model      = `canoeTreeTrunk`,
        price      = 100,
		goldprice  = 0.0, -- THIS IS FOR VORP ONLY
        jobreq     = false,
        jobs	   = {{DB_JOB = "horsetrainer", JOB_LABEL = "Horsetrainer" },},		
 		stashlimit = 20, -- THIS IS FOR VORP AND RSG ONLY
		slots      = 20, -- THIS IS FOR RSG ONLY		
    },
	
    [4] = {
        name       = "Keelboat",
        model      = `keelboat`,
        price      = 1300,
		goldprice  = 0.0, -- THIS IS FOR VORP ONLY
        jobreq     = false,
        jobs	   = {{DB_JOB = "horsetrainer", JOB_LABEL = "Horsetrainer" },},
		stashlimit = 20, -- THIS IS FOR VORP AND RSG ONLY
		slots      = 20, -- THIS IS FOR RSG ONLY		
    },
	
    [5] = {
        name       = "Pirogue",
        model      = `pirogue`,
        price      = 320,
		goldprice  = 0.0, -- THIS IS FOR VORP ONLY
        jobreq     = false,
        jobs	   = {{DB_JOB = "horsetrainer", JOB_LABEL = "Horsetrainer" },},
		stashlimit = 20, -- THIS IS FOR VORP AND RSG ONLY
		slots      = 20, -- THIS IS FOR RSG ONLY		
    },
	
    [6] = {
        name       = "Pirogue 2",
        model      = `pirogue2`,
        price      = 300,
		goldprice  = 0.0, -- THIS IS FOR VORP ONLY
        jobreq     = false,
        jobs	   = {{DB_JOB = "horsetrainer", JOB_LABEL = "Horsetrainer" },},
		stashlimit = 20, -- THIS IS FOR VORP AND RSG ONLY
		slots      = 20, -- THIS IS FOR RSG ONLY		
    },
	
    [7] = {
        name       = "Rowboat",
        model      = `rowboat`,
        price      = 670,
		goldprice  = 0.0, -- THIS IS FOR VORP ONLY
        jobreq     = false,
        jobs	   = {{DB_JOB = "horsetrainer", JOB_LABEL = "Horsetrainer" },},
		stashlimit = 20, -- THIS IS FOR VORP AND RSG ONLY
		slots      = 20, -- THIS IS FOR RSG ONLY		
    },
	
    [8] = {
        name       = "Rowboat Swamp",
        model      = `rowboatSwamp`,
        price      = 690,
		goldprice  = 0.0, -- THIS IS FOR VORP ONLY
        jobreq     = false,
        jobs	   = {{DB_JOB = "horsetrainer", JOB_LABEL = "Horsetrainer" },},
		stashlimit = 20, -- THIS IS FOR VORP AND RSG ONLY
		slots      = 20, -- THIS IS FOR RSG ONLY
    },
	
    [9] = {
        name       = "Rowboat Swamp 2",
        model      = `rowboatSwamp02`,
        price      = 690,
		goldprice  = 0.0, -- THIS IS FOR VORP ONLY
        jobreq     = false,
        jobs	   = {{DB_JOB = "horsetrainer", JOB_LABEL = "Horsetrainer" },},
		stashlimit = 20, -- THIS IS FOR VORP AND RSG ONLY
		slots      = 20, -- THIS IS FOR RSG ONLY		
		
    },
 
    [10] = {
        name       = "Horse Boat",
        model      = `horseBoat`,
        price      = 10000,
		goldprice  = 0.0, -- THIS IS FOR VORP ONLY
        jobreq     = false,
        jobs	   = {{DB_JOB = "horsetrainer", JOB_LABEL = "Horsetrainer" },},
		stashlimit = 200, -- THIS IS FOR VORP AND RSG ONLY
		slots      = 200, -- THIS IS FOR RSG ONLY		
		
    },

    [11] = {
        name       = "Tugboat #1",
        model      = `TugBoat2`,
        price      = 10000,
		goldprice  = 0.0, -- THIS IS FOR VORP ONLY
        jobreq     = false,
        jobs	   = {{DB_JOB = "horsetrainer", JOB_LABEL = "Horsetrainer" },},
		stashlimit = 200, -- THIS IS FOR VORP AND RSG ONLY
		slots      = 200, -- THIS IS FOR RSG ONLY		
		
    },

    [12] = {
        name       = "Tugboat #2",
        model      = `tugboat3`,
        price      = 10000,
		goldprice  = 0.0, -- THIS IS FOR VORP ONLY
        jobreq     = false,
        jobs	   = {{DB_JOB = "horsetrainer", JOB_LABEL = "Horsetrainer" },},
		stashlimit = 200, -- THIS IS FOR VORP AND RSG ONLY
		slots      = 200, -- THIS IS FOR RSG ONLY		
		
    },	
	
	
    [13] = {
        name       = "Turbine Boat",
        model      = `turbineboat`,
        price      = 10000,
		goldprice  = 0.0, -- THIS IS FOR VORP ONLY
        jobreq     = false,
        jobs	   = {{DB_JOB = "horsetrainer", JOB_LABEL = "Horsetrainer" },},
		stashlimit = 200, -- THIS IS FOR VORP AND RSG ONLY
		slots      = 200, -- THIS IS FOR RSG ONLY		
		
    },		
	
	
	
	
	
}
   
 
Config.Customization = {

    [1] = {
        Name = "Propsets",
 
        [`canoe`] = {
            {`pg_veh_canoe_01`,"Propset#1", 50},
            {`pg_veh_canoe_02`,"Propset#2", 50},
            {-1,"Delete Propset", 0},
        },
        [`canoeTreeTrunk`] = {
            {0,"NOT_AVAILABLE",0},
        },
        [`keelboat`] = {
            {`pg_veh_keelboat_01`,"Propset#1", 50},
            {`pg_veh_keelboat_02`,"Propset#2", 50},
            {`pg_veh_keelboat_03`,"Propset#3", 50},
            {-1,"Delete Propset", 0},
        },
	        [`boatsteam02x`] = {
            {`pg_veh_boatsteam02x_1`,"Propset#1", 50},
            {-1,"Delete Propset", 0},
        },	
		
        [`pirogue2`] = {
            {`pg_veh_pirogue_01`,"Propset#1", 50},
            {-1,"Delete Propset", 0},
        },
        [`pirogue`] = {
            {`pg_veh_pirogue_01`,"Propset#1", 50},
            {-1,"Delete Propset", 0},
        },
        [`rowboat`] = {
            {`pg_veh_rowboat_01`,"Propset#1", 50},
            {`pg_veh_rowboat_02`,"Propset#2", 50},
            {`pg_mp_veh_rowboat_supplies01`,"Supplies#1", 50},
            {`pg_mp_veh_rowboat_supplies02`,"Supplies#2", 50},
            {`pg_mp_veh_rowboat_supplies03`,"Supplies#3", 50},
            {`pg_mp_veh_rowboat_supplies04`,"Supplies#4", 50},
            {-1,"Delete Propset", 0},
        },
        [`rowboatSwamp02`] = {
            {`pg_veh_rowboatswamp_01`,"Propset#1", 50},
            {`pg_veh_rowboatswamp_02`,"Propset#2", 50},
            {-1,"Delete Propset", 0},
        },
        [`rowboatSwamp`] = {
            {`pg_veh_rowboatswamp_01`,			"Propset#1", 50},
            {`pg_veh_rowboatswamp_02`,			"Propset#2", 50},
            {`pg_mp_veh_rowboatSwamp_supplies01`, "Supplies#1", 50},
            {`pg_mp_veh_rowboatSwamp_supplies02`, "Supplies#2", 50},
            {`pg_mp_veh_rowboatSwamp_supplies03`, "Supplies#3", 50},
            {`pg_mp_veh_rowboatSwamp_supplies04`, "Supplies#4", 50},
            {-1,"Delete Propset", 0},
        },
		
        [`horseBoat`] = {
            {`pg_veh_horseBoat_1`,"Propset#1", 50},
            {`pg_veh_horseBoat_1_wreckage`,"Propset#2", 50},
            {-1,"Delete Propset", 0},
        },
		
        [`TugBoat2`] = {
            {`pg_veh_tugboat2_1`,"Propset#1", 50},
            {-1,"Delete Propset", 0},
        },
		
        [`tugboat3`] = {
            {`pg_moonshiner3_tugboat2_1`,"Propset#1", 50},
            {-1,"Delete Propset", 0},
        },
		
        [`turbineboat`] = {
            {0,"NOT_AVAILABLE",0},
        },
    },
	
    [2] = {
        Name = "Extras",
        [`canoe`] = {
            {-1,"NOT_AVAILABLE",0},
        },
		
        [`canoeTreeTrunk`] = {
            {-1,"NOT_AVAILABLE",0},
        },
		
        [`boatsteam02x`] = {
            {-1,"NOT_AVAILABLE",0},
        },	
		
        [`keelboat`] = {
            {5, "Extra#1", 50},
            {-1, "Remove Extras", 0},
        },
		
        [`pirogue2`] = {
            {0,"NOT_AVAILABLE",0},
        },
		
        [`pirogue`] = {
            {0,"NOT_AVAILABLE",0},
        },
		
        [`rowboat`] = {
            {1, "Extra#1", 50},
            {-1,"Remove Extras", 0},
        },
		
        [`rowboatSwamp02`] = {
            {5, "Extra#1", 50},
            {-1,"Remove Extras", 0},
        },
		
        [`rowboatSwamp`] = {
            {5, "Extra#1", 50},
            {-1,"Remove Extras", 0},
        },
		
        [`horseBoat`] = {
            {0,"NOT_AVAILABLE",0},
        },
		
        [`TugBoat2`] = {
            {1, "Extra#1", 50},
            {2, "Extra#2", 50},
            {-1,"Remove Extras", 0},
        },
		
        [`tugboat3`] = {
            {0,"NOT_AVAILABLE",0},
        },
		
        [`turbineboat`] = {
            {0,"NOT_AVAILABLE",0},
        },
    },
	
    [3] = {
        Name = "Lanterns",
        [`canoe`] = {
            {0,"NOT_AVAILABLE",0},
        },
		
        [`canoeTreeTrunk`] = {
            {0,"NOT_AVAILABLE",0},
        },
		
        [`boatsteam02x`] = {
            {0,"NOT_AVAILABLE",0},
        },	
		
        [`keelboat`] = {
            {`pg_veh_keelboat_lanterns_1`,"Lantern#1", 30},
            {-1,"Remove Lantern", 0},
        },
		
        [`pirogue2`] = {
            {0,"NOT_AVAILABLE",0},
        },
		
        [`pirogue`] = {
            {0,"NOT_AVAILABLE",0},
        },
		
        [`rowboat`] = {
            {`pg_veh_rowboat_lightupgrade_1`,"Lantern#1", 30},
            {`pg_veh_rowboat_lightupgrade_2`,"Lantern#2", 30},
            {`pg_veh_rowboat_lightupgrade_3`,"Lantern#3", 30},
            {-1,"Remove Lantern", 0},
        },
		
        [`rowboatSwamp02`] = {
            {0,"NOT_AVAILABLE",0},
        },
		
        [`rowboatSwamp`] = {
            {0,"NOT_AVAILABLE",0},
        },
		
        [`horseBoat`] = {
            {`pg_veh_horseboat_1_lights`,"Lantern#1", 30},
            {-1,"Remove Lantern", 0},
        },
		
        [`TugBoat2`] = {
            {`pg_veh_tugboat2_lights01x`,"Lantern#1", 30},
            {-1,"Remove Lantern", 0},
        },
		
        [`tugboat3`] = {
            {`pg_veh_tugboat2_lights01x`,"Lantern#1", 30},
            {-1,"Remove Lantern", 0},
        },
		
        [`turbineboat`] = {
            {`pg_veh_turbineboat01x_lights`,"Lantern#1", 30},
            {-1,"Remove Lantern", 0},
        },
    },
	
    [4] = {
        Name = "Liveries",
        [`canoe`] = {
            {0,"NOT_AVAILABLE",0},
        },
		
        [`canoeTreeTrunk`] = {
            {0,"NOT_AVAILABLE",0},
        },
		
        [`boatsteam02x`] = {
            {-1,"Remove Liveries", 0},		
            {0, "Annie May",          30},
            {1, "Calliope",           30},
            {2, "La Chuparrosa",      30},
            {3, "Magicienne",         30},
        },	
		
        [`keelboat`] = {
            {0,"NOT_AVAILABLE",0},
        },
		
        [`pirogue2`] = {
            {0,"NOT_AVAILABLE",0},
        },
		
        [`pirogue`] = {
            {0,"NOT_AVAILABLE",0},
        },
		
        [`rowboat`] = {
            {0,"NOT_AVAILABLE",0},
        },
		
        [`rowboatSwamp02`] = {
            {0,"NOT_AVAILABLE",0},
        },
		
        [`rowboatSwamp`] = {
            {0,"NOT_AVAILABLE",0},
        },
		
        [`horseBoat`] = {
            {0,"NOT_AVAILABLE",0},
        },
		
        [`TugBoat2`] = {
            {0,"NOT_AVAILABLE",0},
        },
		
        [`tugboat3`] = {
            {0,"NOT_AVAILABLE",0},
        },
		
        [`turbineboat`] = {
            {0,"NOT_AVAILABLE",0},
        },		
 
    },
	
    [5] =  {
        Name = "Tints",
        [`boatsteam02x`] = {
            {0,"Tint#1", 50},
            {1,"Tint#2", 50},
            {2,"Tint#3", 50},
            {3,"Tint#4", 50},
            {4,"Tint#5", 50},
            {5,"Tint#6", 50},
         },
        [`canoe`] = {
            {0,"Tint#1", 50},
            {1,"Tint#2", 50},
            {2,"Tint#3", 50},
            {3,"Tint#4", 50},
            {4,"Tint#5", 50},
         },
        [`canoeTreeTrunk`] = {
            {0,"Tint#1", 50},
         },
        [`keelboat`] = {
            {0,"Tint#1", 50},
            {1,"Tint#2", 50},
            {2,"Tint#3", 50},
            {3,"Tint#4", 50},
            {4,"Tint#5", 50},
         },
        [`pirogue2`] = {
            {0,"Tint#1", 50},
            {1,"Tint#2", 50},
            {2,"Tint#3", 50},
            {3,"Tint#4", 50},
            {4,"Tint#5", 50},
            {5,"Tint#6", 50},
            {6,"Tint#7", 50},
         },
        [`pirogue`] = {
            {0,"Tint#1", 50},
            {1,"Tint#2", 50},
            {2,"Tint#3", 50},
            {3,"Tint#4", 50},
            {4,"Tint#5", 50},
            {5,"Tint#6", 50},
         },
        [`rowboat`] = {
            {0,"Tint#1", 50},
            {1,"Tint#2", 50},
            {2,"Tint#3", 50},
            {3,"Tint#4", 50},
            {4,"Tint#5", 50},
            {5,"Tint#6", 50},
            {6,"Tint#7", 50},
         },
        [`rowboatSwamp02`] = {
            {0,"Tint#1", 50},
            {1,"Tint#2", 50},
            {2,"Tint#3", 50},
            {3,"Tint#4", 50},
            {4,"Tint#5", 50},
            {5,"Tint#6", 50},
         },
        [`rowboatSwamp`] = {
            {0,"Tint#1", 50},
            {1,"Tint#2", 50},
            {2,"Tint#3", 50},
            {3,"Tint#4", 50},
            {4,"Tint#5", 50},
            {5,"Tint#6", 50},
         },
		
        [`horseBoat`] = {
            {0,"Tint#1", 0},
         },
		
        [`TugBoat2`] = {
            {0, "Tint#1",0},
            {1, "Tint#2", 50},
            {2, "Tint#3", 50},
            {3, "Tint#4", 50},
            {4, "Tint#5", 50},
            {5, "Tint#6", 50},
            {6, "Tint#7", 50},
            {7, "Tint#8", 50},
            {8, "Tint#9", 50},
         },
		
        [`tugboat3`] = {
            {0, "Tint#1",0},
            {1, "Tint#2", 50},
            {2, "Tint#3", 50},
            {3, "Tint#4", 50},
        },
		
        [`turbineboat`] = {
            {0, "Tint#1",0},
        },		
 
		
    },
}

 
