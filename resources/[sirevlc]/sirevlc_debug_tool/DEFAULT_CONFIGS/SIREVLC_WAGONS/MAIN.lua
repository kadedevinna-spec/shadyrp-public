Config = Config or {}

-- Version 4.07 - 11.02.26

-- EXPORTS 
-- exports.sirevlc_wagons.getWagonID()     -- returns wagon id 
-- exports.sirevlc_wagons.getWagonEntity() -- returns wagon entity
 
-- EVENTS 
-- TriggerEvent("sirevlc_wagons_remove_wagon")  -- THIS WILL REMOVE THE PLAYER WAGON
-- TriggerEvent("sirevlc_wagons_repair_hammer") -- THIS WILL TRIGGER THE REPAIR HAMMER ANIMATION
 
Config.Debug 					 		= false 

Config.SEND_BACK_NEAR_STABLES     		= false -- IF TRUE WAGONS CAN ONLY BE SENT BACK WHEN THE PLAYER IS NEAR A STABLE 
Config.SEND_BACK_STABLES_COORDS = { 			-- THIS WILL BE THE COORDS USED TO CHECK IF THE PLAYER IS CLOSE TO ONE OF THEM 
{-366.69, 787.06, 116.16}     ,
{-861.71, -1366.38, 43.54}    ,
{2503.153, -1442.725, 46.312} ,
{1213.45, -184.56, 101.32}    ,
{2963.19921875, 795.87, 51.40},
{-1334.52, 2400.99, 307.21}   ,
{-5513.84, -3044.29, -2.38}   ,
{-1817.35, -562.37, 156.06}   ,
{-2402.64, -2374.02, 61.18}   ,
{1496.12, -7068.43, 76.86}    ,
{487.31, 2222.31, 247.10}     ,
{-2215.39, 728.84, 123.00}    ,
} 
Config.SEND_BACK_NEAR_STABLES_DISTANCE 	= 50.0

Config.INSTANCE_DELETE_DELAY	 		= 1000  -- SET THE DELAY BEFORE REMOVING THE HORSE (ON SOME SERVERS DELAY MAY BE NEEDED AFTER INSTANCE CHANGE TO RETURN THE CORRECT ENTITY ID VALUES) 
Config.HuntingWagonExpansion 	 		= true  -- TURN THIS TO TRUE ONLY IF YOU ARE USING SIREVLC_HUNTING_WAGON EXPANSION 
--

Config.RESTRICT_SPAWN_ZONE_ENABLED  = false  -- IF TRUE IT WILL ENABLE SPAWN ZONE RESTRICTION
Config.RESTRICT_SPAWN_ZONE = {
[1] = {label = "example_1", coords = {-352.19, 795.08, 116.22},  distance = 100.0 }, -- LABEL, CENTER COORDS OF THE AREA, DETECTION DISTANCE (PLAYER <-> ZONE CENTER)
} 
 
-- ENABLE YOUR FRAMEWORK HERE. THIS WILL BE USED FOR OPENING STASH EVENTS
Config.REDEMRP2023REBOOT 		  = false 
Config.VORP              		  = true 
Config.RSG               		  = false 
 
Config.RSG_USE_CITIZEN_ID         = false             -- *WARNING* if true RSG will use citizen ID instead of char ID. Please note that you will need to reinstall your current db table with the current sirevlc_wagons.sql, therefore you will lose all your current owned wagons.
Config.CallMyWagonEverwyhere      = true       		  -- Not recommended unless you know what you are doing, this will allow your wagon to spawn everywhere (even in buildings so use it at your own risks :)) / If set to false it will spawn your wagon only on the nearest road (RDO LIKE)
Config.OpenSpawnWagonMenu_Enabled = true 			  -- if true it will enable the quick spawn wagon menu
Config.OpenSpawnWagonMenu         = 0xAB62E997 		  -- [5] key by default. / put Config.OpenSpawnWagonMenu = 0 to make the menu not accessible
Config.SpawnWagonMenu_Use_Command = true 		  	  -- if true this will register a command 
Config.SpawnWagonMenu_Command 	  = "wagon_menu" 	   

Config.EnableNotifications        = true 	   		  -- This will enable or disable general notifications (recommended to keep these)
 
-- WHEN SELLING TO STABLE, DIVIDE THE PRICE OF THE WAGON BY :
Config.SellDivider                = 2
Config.RepairPrice                = 20.0
Config.InvincibleWagons           = false    		  -- HORSES CAN STILL DETACH
Config.InvincibleHuntingWagons    = false    		  -- HORSES CAN STILL DETACH
 
Config.STASH_NAME                 = "Wagon Stash"     -- THIS WILL BE THE NAME DISPLAYED WHEN OPENING WAGON STASH
Config.SharedStash                = true 			  -- if you want wagons lockers to be accessible by other players		  
Config.StashRoleRestrictions      = true 		      -- This restricts access to the wagon locker to the jobs listed below. The wagon owner can still access their wagon locker regardless of their job.
Config.StashRoles = {								  -- JOBS that are authorized to search other player's wagons 
"horsetrainer",
"averagerider",   
"trapper",
}

-------------------------------
-- LOCKPICKING MINIGAME --
-------------------------------

Config.LOCKPICKING_ENABLED        				= true	 -- IF ENABLED PEOPLE WHO DON'T HAVE THE RIGHT JOB IN CONFIG.STASHROLES WILL BE ABLE TO LOCKPICK
Config.LOCKPICKING_ITEMS          				= {{ITEM = "lockpick", REMOVE = true}, {ITEM = "bread", REMOVE = false}, }  -- IF THE PLAYER HAS ONE OF THESE ITEMS IN ITS INVENTORY THE LOCKPICK ACTION WILL PERFORM
Config.LOCKPICK_DEBUG             				= false  -- PRINT DEBUG INFO IN F8 CONSOLE

-- Lockpick prompt (shown instead of the stash prompt when SharedStash=true and player has no access)
Config.PromptLockpickTitle   					= "Lockpick"
Config.PromptLockpick        					= 0xD8F73058 -- U (same key as locker by default)

-- Lockpick minigame keys (3 prompts will show in random order)
Config.LockpickMinigameKeys                   = { `INPUT_RELOAD`, `INPUT_INTERACT_LOCKON_NEG`, `INPUT_INTERACT_OPTION1` } -- E / F / G
Config.LockpickMinigamePressesPerStep         = 5
Config.LockpickMinigameStepTimeMs             = 2000
Config.LockpickMinigameTotalTimeMs            = 15000
Config.LockpickMinigameMaxMistakes            = 2
 
-- Lockpick notifications
Config.TextNotifWagonNoLockPickItem           = "You don't have any lockpick item"
Config.TextNotifWagonLockPickFailed           = "Lockpicking failed"
Config.TextNotifWagonLockPickSuccessful       = "Lockpicking successful"
 
Config.ENABLE_FLASH_PULSE        = true 	-- IF TRUE IT WILL ENABLE THE GAME PULSE EFFECT WHEN YOUR WAGON GETS SENT BACK TO STABLES
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

Config.WebhookUrl                        		= ""
Config.WebhookMainTitle                  		= "Stables"
		
-- PURCHASE FROM STABLE EVENT --         		   
Config.UseWebhookPurchaseFromStables     		= false  -- Turn to true if you want to use the Discord Webhook for this event
Config.WebhookPurchaseTitle              		= "Wagon Purchase"
Config.WebhookPurchase                   		= "purchased the "
Config.WebhookPurchaseFor                		= "for"
Config.WebhookPurchase2                  		= "and"
Config.WebhookPurchase3                  		= "gold"
		
-- PURCHASE FROM PLAYER EVENT --         		    
Config.UseWebhookPurchaseFromPlayer      		= false -- Turn to true if you want to use the Discord Webhook for this event
Config.WebhookPurchaseFromPlayer         		= "Purchased a wagon from "
		
-- SOLD WAGON TO STABLE --               		               
Config.UseWebhookSold                    		= false -- Turn to true if you want to use the Discord Webhook for this event
Config.WebhookSoldTitle                  		= "Wagon Sell"
Config.WebhookSoldWagonNamed             		= "sold a wagon named"
Config.WebhookSoldWagonFor               		= "for"	
Config.WebhookSoldWagon2                 		= "and"	
Config.WebhookSoldWagon3                 		= "gold"	

-------------------------------
		 --PROMPTS--
-------------------------------
Config.DISPLAY_PROMPT_DISTANCE                  = 2.0

Config.CameraChangeKey              			= 0xD8CF0C95 -- C
Config.wagonStable                  			= "Wagons"

Config.PromptSellTitle              			= "Sell Wagon"
Config.PromptSell                   			= 0x43DBF61F--ENTER
-- Prompt paging (prevents the hardcoded 5-prompts limit from hiding prompts)
-- Root page
Config.PromptGeneralTitle                       = "General"
Config.PromptGeneral                            = `INPUT_INTERACT_OPTION1`       -- G
 
-- Root page (only for special wagons)          
Config.PromptSpecialTitle                       = "Special Prompts"
Config.PromptSpecial                            = 0xD8CF0C95 -- C
 
-- Sub-pages                                    
Config.PromptBackTitle                          = "Return"
Config.PromptBack                               = `INPUT_INTERACT_LOCKON_NEG` -- F
 
Config.PromptWagonGroupTitle             	    = "Wagon"
Config.PromptLockerTitle            			= "Open Stash"
Config.PromptLocker                 			= 0xD8F73058 --U
 
Config.PromptStopSellTitle          			= "Stop Selling"
Config.PromptStopSell               			= 0xD8F73058 --U
 
Config.PromptStoreTitle             			= "Park In Stables"
Config.PromptStore                  			= 0xD8CF0C95 -- C
				
Config.PromptStoreAnimalTitle       			= "Store"                    -- USABLE WITH SIREVLC_HUNTING_WAGON EXPANSION ONLY 
Config.PromptStoreAnimal       	    			= 0x43DBF61F  -- ENTER       -- USABLE WITH SIREVLC_HUNTING_WAGON EXPANSION ONLY 
Config.PromptGetStoredTitle         			= "Get Carcasses"  			 -- USABLE WITH SIREVLC_HUNTING_WAGON EXPANSION ONLY 
Config.PromptGetStored         	    			= 0x8AAA0AD4  -- LALT        -- USABLE WITH SIREVLC_HUNTING_WAGON EXPANSION ONLY 
Config.HuntingWagonPrompt           			= "Hunting Wagon"            -- USABLE WITH SIREVLC_HUNTING_WAGON EXPANSION ONLY 
				
Config.PromptBuywagonTitle 						= "Buy"
Config.PromptBuywagon      						= 0x43DBF61F  -- ENTER

-- WAGON HEALTH (TARGET PROMPT)
Config.PromptWagonHealthTitle 					= "Wagon Health"
Config.PromptWagonHealth 						= `INPUT_OPEN_JOURNAL`   	 -- J  

---------------------------------------------
-- PRISON / ARMOURED / BOUNTY WAGONS
--------------------------------------------- 
-- Supported:
--  - wagonPrison01x
--  - wagonarmoured01x
--  - bountywagon01x
-------------------------------
-- Backward compatibility: Config.PrisonWagonModel is still accepted (single model)
Config.PrisonWagonModel                        = `wagonPrison01x` -- legacy single-model (optional)
Config.PrisonWagonModels                       = { `wagonPrison01x`, `wagonarmoured01x`, `bountywagon01x` }

-- Seats used for the rear/cage (the script will pick the first free)
Config.PrisonWagonRearSeats                    = {1, 2, 3, 4, 5, 6} -- default fallback
Config.PrisonWagonRearSeatsByModel             = {
    [`wagonPrison01x`]   = {1, 2, 3, 4, 5, 6},
    [`wagonarmoured01x`] = {1, 2, 3, 4, 5, 6},
    -- bounty wagon can have up to 10 seats
    [`bountywagon01x`]   = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10},
}

Config.PromptPrisonBoardTitle                  = "Get In (Rear)"
Config.PromptPrisonBoard                       = `INPUT_SWITCH_SHOULDER` -- X

Config.PromptPrisonExitTitle                   = "Get Out"
Config.PromptPrisonExit                        = `INPUT_VEH_EXIT` -- E

Config.PromptPrisonLockTitle                   = "Lock Wagon"
Config.PromptPrisonLock                        = `INPUT_CINEMATIC_CAM` -- G

Config.PromptPrisonUnlockTitle                 = "Unlock Wagon"
Config.PromptPrisonUnlock                      = `INPUT_CINEMATIC_CAM` -- G

-- Owner-only: while carrying a HUMAN ped, store them into the rear seat automatically
Config.PromptPrisonStowTitle                   = "Put In Wagon"
Config.PromptPrisonStow                        =  0x8AAA0AD4 -- L ALT

-- Owner-only: force all rear passengers out of the wagon (hold)
-- Prompt variable in client.lua: PROMPT_PRISON_FORCE_EXIT
Config.PromptPrisonForceExitTitle              = "Force Passengers Exit"
Config.PromptPrisonForceExit                   = `INPUT_RELOAD` -- R

Config.TextPrisonWagonLocked                   = "Prison wagon is locked"
 
Config.STASH_NAME = "Wagon"

-----------------------------------------
		-- STABLE CAMERA SETTINGS -- 
-----------------------------------------
Config.CAMERA_KEY_CHANGE_TEXT              		= " CAMERA CONTROLS: \n Forward - W \n Backward - S \n Left - A \n Right - D \n Slide Forward - Q \n Slide Backwards - E \n Up - JUMP \n Down - SHIFT \n Speed Up - Mouse Wheel Up \n Speed Down - Mouse Wheel Down"
Config.CAMERA_KEY_NOTIF_DURATION            	= 3000

Config.MAX_CAM_DISTANCE                         = 10.0
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

-------------------------------------------------
-------------------------------------------------
    Config.MENU_MANAGE = {
        {label = "Spawn wagon", 	 value = "Spawnwagon" ,  image = "items/sirevlc_wagon.png" 			},
        {label = "Repair wagon",     value = "Repairwagon",  image = "items/emote_lets_go_crafting.png" },
        {label = "Sell Wagon",       value = "Deletewagon",  image = "items/sirevlc_delete_wagon.png" 	},
        {label = "Customize wagon",  value = "Customize"  ,  image = "items/awards_set_f_010.png" 		},
    }
	Config.MENU_CUSTOMIZATION = { 
        {label = "Tints"      , value = "tints" ,        image = "items/sirevlc_wagons_tints.png"},
        {label = "decorations", value = "decorations" ,  image = "items/sirevlc_wagons_decorations.png"},
        {label = "Propsets"   , value = "propsets" ,     image = "items/sirevlc_wagons_propsets.png"},
        {label = "Lanterns"   , value = "lanterns" ,     image = "items/generic_horse_equip_lantern.png"},
        {label = "Extras"     , value = "extras" ,       image = "items/sirevlc_wagons_extras.png"},
	}
--------------------------------------------------
    --AUTOMATICALLY SEND BACK WAGON OPTION--
-------------------------------------------------- 
Config.AutomaticWagonDelete         		= true --If distance is superior to below it will automatically delete your wagon (check that you don't have an entity distance limit on your server)
Config.AutomaticWagonDeleteDistance 		= 90   
 
-------------------------------------------------
			-- WAGONS CONFIGURATION --
-------------------------------------------------
-- Here you can configure the stash limit for the wagons (FOR VORP AND RSG ONLY)
-- Slots are for RSG only you can leave them as it is if using VORP
 
-- YOU CAN CHANGE THE NAME, PRICE, IF A JOB IS REQUIRED OR NOT AND WHAT JOBS CAN BUY THE WAGON. EXAMPLE PROVIDED FOR CART#1 BELOW
-- GOLD PARAM IS FOR VORP ONLY !
 
------------------------------------
	--WAGON MODELS REFERENCED--
------------------------------------
--DONT TOUCH THIS
Config.wagonmodels = {
    `CART01`,
    `CART02`,
    `CART03`,
    `CART04`,
    `CART05`,
    `CART06`,
    `CART07`,
    `CART08`,
    `buggy01`,
    `buggy02`,
    `buggy03`,
    `CHUCKWAGON000X`,
    `CHUCKWAGON002X`,
    `coal_wagon`,
    `gatchuck`,
    `LOGWAGON`,
    `OILWAGON01X`,
    `oilWagon02x`,
    `supplywagon`,
    `utilliwag`,
    `WAGON02X`,
    `WAGON03X`,
    `WAGON04X`,
    `WAGON05X`,
    `WAGON06X`,
    `COACH2`,
    `COACH3`,
    `coach3_cutscene`,
    `COACH4`,
    `COACH5`,
    `COACH6`,
    `STAGECOACH001X`,
    `STAGECOACH002X`,
    `STAGECOACH003X`,
    `STAGECOACH004X`,
    `STAGECOACH004_2x`,
    `STAGECOACH005X`,
    `STAGECOACH006X`,
    `armysupplywagon`,
    `gatchuck_2`,
    `POLICEWAGON01X`,
    `policeWagongatling01x`,
    `bountywagon01x`,
    `huntercart01`,
    `wagonarmoured01x`,
    `warwagon2`,
    `wagonPrison01x`,
    `wagonCircus01x`,
    `wagonCircus02x`,
    `wagondairy01x`,
    `wagonDoc01x`,
    `wagontraveller01x`,
    `wagonWork01x`,
}

--DONT TOUCH THIS
Config.WagonMaximumAttachments = {
    [`CART01`] = 1,
    [`CART02`] = 1,
    [`CART03`] = 1,
    [`CART04`] = 1,
    [`CART05`] = 1,
    [`CART06`] = 1,
    [`CART07`] = 1,
    [`CART08`] = 1,
    [`buggy01`] = 1,
    [`buggy02`] = 1,
    [`buggy03`] = 1,
    [`CHUCKWAGON000X`] = 2,
    [`CHUCKWAGON002X`] = 2,
    [`coal_wagon`] = 1,
    [`gatchuck`] = 1,
    [`LOGWAGON`] = 2,
    [`OILWAGON01X`] = 2,
    [`oilWagon02x`] = 2,
    [`supplywagon`] = 2,
    [`utilliwag`] = 1,
    [`WAGON02X`] = 2,
    [`WAGON03X`] = 2,
    [`WAGON04X`] = 2,
    [`WAGON05X`] = 2,
    [`WAGON06X`] = 1,
    [`COACH2`] = 4,
    [`COACH3`] = 2,
    [`coach3_cutscene`] = 2,
    [`COACH4`] = 1,
    [`COACH5`] = 1,
    [`COACH6`] = 1,
    [`STAGECOACH001X`] = 2,
    [`STAGECOACH002X`] = 2,
    [`STAGECOACH003X`] = 2,
    [`STAGECOACH004X`] = 4,
    [`STAGECOACH004_2x`] = 2,
    [`STAGECOACH005X`] = 2,
    [`STAGECOACH006X`] = 2,
    [`armysupplywagon`] = 2,
    [`gatchuck_2`] = 1,
    [`POLICEWAGON01X`] = 2,
    [`policeWagongatling01x`] = 2,
    [`bountywagon01x`] = 1,
    [`huntercart01`] = 1,
    [`wagonarmoured01x`] = 1,
    [`warwagon2`] = 2,
    [`wagonPrison01x`] = 2,
    [`wagonCircus01x`] = 2,
    [`wagonCircus02x`] = 2,
    [`wagondairy01x`] = 1,
    [`wagonDoc01x`] = 2,
    [`wagontraveller01x`] = 1,
    [`wagonWork01x`] = 1,
} 

 
 