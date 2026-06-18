Config = {}
 
-- version 2.41 - 18.01.25

Config.RoleRestriction   					= false
Config.REDEMRP2 		 					= false 
Config.REDEMRP2023REBOOT 					= false
Config.VORP 			 					= false
Config.RSG 				 					= true


--List of roles enabled to open the menu if Config.RoleRestriction = true
Config.Roles = {
"trapper",
}
 
-------------------------------------------
               --MENU --
-------------------------------------------

Config.SireVLC_Cooking_And_Crafting_Used     = true  	  -- IF SET TO TRUE IT WILL PREVENT THE CAMPFIRE PROMPT TO APPEAR WHEN USING THE COOKING AND CRAFTING RESOURCE
Config.GeneralMenuIsUsed 					 = false   	  -- ONLY TURN TO TRUE IF YOU ARE USING THIS GENERAL MENU SCRIPT FROM TEBEX : https://sire-vlc-scripts.tebex.io/package/5765603
Config.MenuActive							 = true  
Config.OpenMenuKey 							 = 0xA1FDE2A6 -- [6] BY DEFAULT 
Config.EnableNotifications 					 = true
Config.DrunkMusic 							 = true  
Config.LockTowns  							 = false 	  -- THIS WILL PREVENT TO SPAWN CAMPING OBJECTS IN TOWNS 
 
Config.EnableCommands           			 = true 

--------------------------------------------
		--EVENT LINES TO CALL--
-------------------------------------------
-- CHECK LATEST ADDED EVENTS IN THE ACTIONS AND EMOTES BELOW 
-- Don't forget to use TriggerclientEvent and define your source if using these server side

--TriggerEvent("sirevlc_rp_overhaul_menu","mainmenu")
--TriggerEvent("sirevlc_rp_overhaul_menu","campingmenu")
--TriggerEvent("sirevlc_rp_overhaul_menu","tents")
--TriggerEvent("sirevlc_rp_overhaul_menu","beds")
--TriggerEvent("sirevlc_rp_overhaul_menu","campfires")
--TriggerEvent("sirevlc_rp_overhaul_menu","rugs")
--TriggerEvent("sirevlc_rp_overhaul_menu","chairs")
--TriggerEvent("sirevlc_rp_overhaul_menu","logs")
--TriggerEvent("sirevlc_rp_overhaul_menu","hitchposts")
--TriggerEvent("sirevlc_rp_overhaul_menu","clearcamp")
--TriggerEvent("sirevlc_rp_overhaul_menu","clothesoptions")
--TriggerEvent("sirevlc_rp_overhaul_menu","removeclothes")
--TriggerEvent("sirevlc_rp_overhaul_menu","emotesoptionsmenu")
--TriggerEvent("sirevlc_rp_overhaul_menu","actionsmenu")
--TriggerEvent("sirevlc_rp_overhaul_menu","weaponsoptions")
--TriggerEvent("sirevlc_rp_overhaul_menu","playnearestscenario")
--TriggerEvent("sirevlc_rp_overhaul_menu","bandanaon")
--TriggerEvent("sirevlc_rp_overhaul_menu","bandanaoff") 
 
--TriggerEvent("sirevlc_rp_overhaul_menu","walkstyle1")
--TriggerEvent("sirevlc_rp_overhaul_menu","walkstyle2")
--TriggerEvent("sirevlc_rp_overhaul_menu","walkstyle3")
--TriggerEvent("sirevlc_rp_overhaul_menu","walkstyle4")
--TriggerEvent("sirevlc_rp_overhaul_menu","walkstyle5")
--TriggerEvent("sirevlc_rp_overhaul_menu","walkstyle6")
--TriggerEvent("sirevlc_rp_overhaul_menu","walkstyle7")
--TriggerEvent("sirevlc_rp_overhaul_menu","walkstyle8")
--TriggerEvent("sirevlc_rp_overhaul_menu","walkstyle9")
--TriggerEvent("sirevlc_rp_overhaul_menu","walkstyle10")
--TriggerEvent("sirevlc_rp_overhaul_menu","walkstyle11")
--TriggerEvent("sirevlc_rp_overhaul_menu","walkstyle12")
--TriggerEvent("sirevlc_rp_overhaul_menu","walkstyle13")      --"Slightly Drunk"
--TriggerEvent("sirevlc_rp_overhaul_menu","walkstyle14")      --"Very Drunk"	
--TriggerEvent("sirevlc_rp_overhaul_menu","walkstyle15")      --"Smashed"
--TriggerEvent("sirevlc_rp_overhaul_menu","walkstyle16")      --"Forced Fall"	
--TriggerEvent("sirevlc_rp_overhaul_menu","removewalkstyle")
  
--TriggerEvent("sirevlc_rp_overhaul_menu","weapon_crossed")
--TriggerEvent("sirevlc_rp_overhaul_menu","weapon_shoulder")
--TriggerEvent("sirevlc_rp_overhaul_menu","lantern_hip")
--TriggerEvent("sirevlc_rp_overhaul_menu","clear_weapon")

 
 
-- These lines trigger the object placement. Different categories are available, note that the tent category disable the collision.
-- So you can put any object from the game that you want on the second value. 
-- Third value is inventory item name.
-- Fourth value is enabling the item removal after placing it (true / false) 
-- Don't forget to use TriggerclientEvent and define your source if using these server side
 
-- TriggerEvent("placecampingitems", "putyourgameobjecthere"(STRING), "hitchpost", inventoryitemname(STRING), enableitemremoval(BOOL))
  
--categories are :
--hitchpost
--tent
--log
--bed
--campfire
--rug

--Even if your object doesnt relate to these categories above it should work
 
-------------------------------------------
           --TEXTS TRANSLATIONS--
-------------------------------------------

Config.PromptDelete = "Delete"
Config.PromptPlace  = "Place"
Config.PromptUp     = "Up"
Config.PromptDown   = "Down"
Config.PromptRight  = "Right"
Config.PromptLeft   = "Left"
 
 
-- CAMPING NOTIFICATIONS
Config.TextNotifWildernessTitle 			= "Wilderness"

Config.TextNotifWildernessBed 			 	= "Placing Bed..."
Config.TextNotifWildernessPlacedBed 	 	= "Bed placed"
	
Config.TextNotifWildernessCampfire 		 	= "Placing Campfire..."
Config.TextNotifWildernessCampfirePlaced 	= "Campfire placed"
	
Config.TextNotifWildernessLog			 	= "Placing Woodlog..."
Config.TextNotifWildernessLogPlaced 	 	= "Woodlog placed"
	
Config.TextNotifWildernessChair 		 	= "Placing Chair..."
Config.TextNotifWildernessChairPlaced 	 	= "Chair Placed"
	
Config.TextNotifWildernessTent 			 	= "Placing Tent..."
Config.TextNotifWildernessTentPlaced 	 	= "Tent Placed"

Config.TextNotifWildernessHitchpost 		= "Placing hitchpost..."
Config.TextNotifWildernessHitchpostPlaced 	= "Hitchpost Placed"

Config.TextNotifWildernessRug 				= "Placing Rug..."
Config.TextNotifWildernessRugPlaced 		= "Rug Placed"

Config.TextNotifWildernessCampCleared 		= "Camp cleared"
 
Config.TextNotifStarsTitle 					= "Stars"
Config.TextNotifStarsSub 					= "Studying..."
Config.TextNotifStarsSub2 					= "Its not Night time yet"
Config.TextNotifNotInWater					 = "You are not in water !" 
 
 
 
---------------------------- 
----------------------------  
		--MAIN MENU--
---------------------------- 
---------------------------- 

--Here you can remove certain options if you want to: just add -- in front of the line  
Config.TextMenuTitle   = "Main Menu"
Config.MainMenu = {
	{label = 'Wilderness Camp', value = "action01",  desc = 'Wilderness Camp',    image='items/kit_camp_simple.png'},
	{label = 'Actions',         value = "action02",  desc = 'Actions',            image='items/emote_action_smoke_cigarette_classy_1.png'},
	{label = 'Clothing',        value = "action03",  desc = 'Clothing',           image='items/clothing_generic_outfit.png'},
	{label = 'Weapons Options', value = "action04",  desc = 'Weapons Options',    image='items/online_options_offensive.png'},	
	{label = 'Clear Props',     value = "action05",  desc = 'Clear Props',        image='items/upgrade_fsh_bait_lure_none.png'},	
}


---------------------------- 
	--CLOTHING  MENU--
---------------------------- 
--Here you can remove certain options if you want to: just add -- in front of the line 

Config.TextMenuClothingTitle   = "Clothing Options"
Config.ClothingMenu = {
	{label = 'Remove / Reput Clothes',  value = "action01", desc = 'Remove your clothes',      image='items/upgrade_fsh_bait_lure_none.png'},
	{label = 'Clothes Options', 		value = "action02", desc = 'Options for your clothes', image='items/kit_bandana.png'},
}


---------------------------- 
---------------------------- 
	--CAMPING STUFF--
---------------------------- 
---------------------------- 

---------------------------- 
	--CAMPING TENTS--
----------------------------
--Here you can remove certain options if you want to: just add -- in front of the line 

Config.StopActionCommand = "stopaction"   -- TriggerEvent("sirevlc_animations", "StopActionCommand")    end)
Config.ClearCampCommand  = "clearcamp"    -- TriggerEvent("sirevlc_animations", "ClearCampCommand")     end)

Config.TextMenuCampingTentsTitle = "Tents"
Config.CampingTents = {
	{label = "The Wanderer",         value = "action01", obj = "p_tentarmypup01x"    ,   desc = "The Wanderer"        },
	{label = "The Blackwater",       value = "action02", obj = "p_ambtentplaid01x"   ,   desc = "The Blackwater"      },
	{label = "The Trapper",          value = "action03", obj = "p_ambtenthide01x"    ,   desc = "The Trapper"         },
	{label = "The Navajo",           value = "action04", obj = "p_ambtentrug01x"     ,   desc = "The Navajo"          },
	{label = "The Naturalist",       value = "action05", obj = "p_ambtentpatch01x"   ,   desc = "The Naturalist"      },
	{label = "The Leather",          value = "action06", obj = "p_amb_tent01x"       ,   desc = "The Leather"         },
	{label = "The Scarlett Meadows", value = "action07", obj = "p_amb_tent02x"    	 ,   desc = "The Scarlett Meadows"},
	{label = "The Perfectionist",    value = "action08", obj = "p_gangtentlemoyne01x",   desc = "The Perfectionist"   },
	{label = "The Survivalist",      value = "action09", obj = "p_ambtentswamp01x"   ,   desc = "The Survivalist"     },
	{label = "The Great Plains",     value = "action10", obj = "s_TENTWEDGE02B"      ,   desc = "The Great Plains"    },
	{label = "The King And Queen",   value = "action11", obj = "p_tent_leento03x"    ,   desc = "The King And Queen"  },
	{label = "The Pioneer",          value = "action12", obj = "p_amb_tent03x"     	 ,   desc = "The Pioneer"         },
	{label = "The Burlap",           value = "action13", obj = "p_ambtentburlap01x"  ,   desc = "The Burlap"          },
	{label = "The Lagras",           value = "action14", obj = "p_ambtentdebris01x"  ,   desc = "The Lagras"          },
	{label = "The Oil Skinned",      value = "action15", obj = "p_ambtentoilskin01x" ,   desc = "The Oil Skinned"     },
	{label = "The Survivalist#02",   value = "action16", obj = "p_ambtentscrub01x"   ,   desc = "The Survivalist#02"  },
    {label = "The Survivalist#03",   value = "action17", obj = "p_ambtentsticks01x"  ,   desc = "The Survivalist#03"  },
  --{label = "Insert Label Here",    value = "action18", obj= "yourobjecthere",   desc = "Insert Desc Here"},
}

 

---------------------------- 
	--CAMPING BEDS--
----------------------------

--Here you can remove certain options if you want to: just add -- in front of the line 
Config.TextMenuCampingBedsTitle = "Beds"
Config.CampingBeds = {
	{label = "The Mountain Man",  value = "action01", obj = "s_bedrollopen01x",   desc = "The Mountain Man"  },
	{label = "The Explorer",      value = "action02", obj = "P_BEDROLLOPEN01X",   desc = "The Explorer"      },
	{label = "The Morgan",        value = "action03", obj = "s_bedarthur01x"  ,   desc = "The Morgan"        },
	{label = "The Recruit",       value = "action04", obj = "s_craftedbed01x" ,   desc = "The Recruit"       },
	{label = "The Night Folk",    value = "action05", obj = "p_ambbed01x"     ,   desc = "The Night Folk"    },
    {label = "The Wapiti#01",     value = "action06", obj = "p_bedindian01x"  ,   desc = "The Wapiti#01"     },
    {label = "The Wapiti#02",     value = "action07", obj = "p_bedindian02x"  ,   desc = "The Wapiti#02"     },
    {label = "The Wapiti#03",     value = "action08", obj = "p_bedindian04x"  ,   desc = "The Wapiti#03"     },
-- {label = "Insert Label Here",   value = "action08", obj= "yourobjecthere",   desc = "Insert Desc Here" },
}
 
---------------------------- 
	--CAMPING CAMPFIRE--
----------------------------

--Here you can remove certain options if you want to: just add -- in front of the line 
Config.TextMenuCampingCampfireTitle = "Campfire"
Config.CampingCampfire = {
	    {label = "Campfire#01", value = "action01", obj= "p_campfire05x_script"     , desc = "Campfire#01"},
	    {label = "Campfire#02", value = "action02", obj= "p_campfire03x"            , desc = "Campfire#02"},	
	    {label = "Campfire#03", value = "action03", obj= "p_campfire_coloursmoke01x", desc = "Campfire#03"},
	    {label = "Campfire#04", value = "action04", obj= "p_campfirecombined03x"    , desc = "Campfire#04"},	
	    {label = "Campfire#05", value = "action05", obj= "s_campfire02x"            , desc = "Campfire#05"},	
--{label = "Insert Label Here", value = "action06", obj= "yourobjecthere", desc = "Insert Desc Here"},		
}
 
----------------------------
	-- CAMPING HITCHPOSTS --
----------------------------
--Here you can remove certain options if you want to: just add -- in front of the line 
Config.TextMenuCampingHitchpostsTitle = "Hitchposts"
Config.CampingHitchposts = {
	{label = "Hitchpost Small",  value = "action01", obj= "p_hitchingpost04x",  desc = "Hitchpost#01"},
	{label = "Hitchpost Medium", value = "action02", obj= "P_HITCHINGPOST05X",  desc = "Hitchpost#02"},
	{label = "Hitchpost Large",  value = "action03", obj= "p_hitchingpost01x",  desc = "Hitchpost#03"},
	--{label = "Label Here",  value = "action04", obj = "yourobjecthere",  desc = "Desc Here"},
}
 
 
----------------------------
	-- CAMPING LOGS --
----------------------------

--Here you can remove certain options if you want to: just add -- in front of the line 
Config.TextMenuCampingLogsTitle = "Logs"
Config.CampingLogs = {
	{label = "Sit",                 value = "action01", obj= "",                desc = "Sit on the nearest chair or log"},
	{label = "Bolger Glade Log",    value = "action02", obj= "p_bench_log01x",  desc = "Bolger Glade Log"    },
	{label = "Diablo Ridge Log",    value = "action03", obj= "p_bench_log02x",  desc = "Diablo Ridge Log"    },
	{label = "Aurora Bassin Log",   value = "action04", obj= "p_bench_log03x",  desc = "Aurora Bassin Log"   },
	{label = "Plainview Log",       value = "action05", obj= "p_bench_log04x",  desc = "Plainview Log"       },
	{label = "Puerto Cuchillo Log", value = "action06", obj= "p_bench_log05x",  desc = "Puerto Cuchillo Log" },
	{label = "Cotorra Spring Log",  value = "action07", obj= "p_bench_log06x",  desc = "Cotorra Spring Log"  },
	{label = "Brandywine Log",      value = "action08", obj= "p_bench_log07x",  desc = "Brandywine Log"      },
	--{label = "Label Here",        value = "action09", obj= "yourobjecthere",  desc = "Desc Here",     },
}
 
----------------------------
	--CAMPING CHAIRS--
----------------------------
--Here you can remove certain options if you want to: just add -- in front of the line 
Config.TextMenuCampingChairsTitle = "Chairs"
Config.CampingChairs = {
	{label = "Sit",              value = "action01", obj= "",                        desc = "Sit on the nearest chair or log"},
	{label = "Camping Stool",    value = "action02", obj= "s_stoolfoldingstatic01x", desc = "Camping Stool"   },
	{label = "Small Chair",      value = "action03", obj= "s_chair04x"             , desc = "Small Chair"     },
	{label = "Dining Chair",     value = "action04", obj= "p_diningchairs01x"      , desc = "Dining Chair"    },
	{label = "Rawson Chair#01",  value = "action05", obj= "p_gen_chair06x"         , desc = "Rawson Chair#01" },
	{label = "Rawson Chair#02",  value = "action06", obj= "p_gen_chair07x"         , desc = "Rawson Chair#02" },
	{label = "Rawson Chair#03",  value = "action07", obj= "p_gen_chair08x"         , desc = "Rawson Chair#03" },
	{label = "Windsor Chair#01", value = "action08", obj= "p_windsorchair01x"      , desc = "Windsor Chair#01"},
	{label = "Windsor Chair#02", value = "action09", obj= "p_windsorchair02x"      , desc = "Windsor Chair#02"},
	{label = "Windsor Chair#03", value = "action10", obj= "p_windsorchair03x"      , desc = "Windsor Chair#03"},
	{label = "Wooden Chair",     value = "action11", obj= "p_woodenchair01x"       , desc = "Wooden Chair"    },
	--{label = "LABEL HERE",       value = "action12", obj= "yourobjecthere", desc = "DESC HERE"   },
}
 
----------------------------
	--CAMPING RUGS--
----------------------------
--Here you can remove certain options if you want to: just add -- in front of the line 
Config.TextMenuCampingRugsTitle = "Rugs"
Config.CampingRugs = {
	{label = "Rug#01", value = "action01", obj= "P_AMBFLOORRUG01x", desc = "Rug#01"},
	{label = "Rug#02", value = "action02", obj= "P_CS_RUG01X"     , desc = "Rug#02"},
--{label = "LABEL HERE", value = "action03", obj= "yourobjecthere", desc = "DESC HERE"},
}
 
----------------------------
	--CAMPING MENU--
----------------------------
Config.TextMenuCampingTitle   = "Camping"   
Config.MenuCamping = {
	{label = "Tents"      , value = "action01", desc = "Tents"      , image= "items/sirevlc_tent.png"},
	{label = "Beds"       , value = "action02", desc = "Beds"       , image= "items/sirevlc_bed.png" },
	{label = "Campfire"   , value = "action03", desc = "Campfire"   , image= "items/kit_camp_simple.png"},
	{label = "Logs"       , value = "action04", desc = "Logs"       , image= "items/sirevlc_log.png"},
	{label = "Rugs"       , value = "action05", desc = "Rugs"       , image= "items/sirevlc_rug.png"},
	{label = "Chairs"     , value = "action06", desc = "Chairs"     , image= "items/sirevlc_chair.png"},
	{label = "Hitchposts" , value = "action07", desc = "Hitchposts" , image= "items/sirevlc_hitchpost.png"},
	{label = "Clear Camp" , value = "action08", desc = "Clear Camp" , image= "items/upgrade_fsh_bait_lure_none.png"},
}
	
 
----------------------------
  --REMOVE CLOTHING MENU--
----------------------------
Config.MenuRemoveClothesTitle   = "Remove Clothes"
Config.MenuRemoveClothes = {
		{label = 'Remove All'          , value = "action01", desc = 'Remove All'          , image='items/emote_reaction_shrug_1.png'},
       	{label = "Accessories"         , value = "action02", desc = "Accessories"         , image='items/clothing_generic_belt_accs.png'},
		{label = "Loadouts"            , value = "action03", desc = "Loadouts"            , image='items/upgrade_bandolier.png'},
        {label = "Belts"               , value = "action04", desc = "Belts"               , image='items/clothing_belts.png'},
		{label = "Belt_buckles"        , value = "action05", desc = "Belt_buckles"        , image='items/provision_buckle_gold.png'},
		{label = "Boots"               , value = "action06", desc = "Boots"               , image='items/clothing_generic_boots.png'},
		{label = "Boot_accessories"    , value = "action07", desc = "Boot_accessories"    , image='items/clothing_hl_player_spurs.png'},
		{label = "Chaps"               , value = "action08", desc = "Chaps"               , image='items/clothing_generic_chaps.png'},
		{label = "Cloaks"              , value = "action09", desc = "Cloaks"              , image='items/clothing_generic_cloak.png'},
		{label = "Coats"               , value = "action10", desc = "Coats"               , image='items/clothing_generic_f_coat.png'},
		{label = "Coats_closed"        , value = "action11", desc = "Coats_closed"        , image='items/clothing_generic_coat.png'},
		{label = "Dresses"             , value = "action12", desc = "Dresses"             , image='items/clothing_generic_dress.png'},
		{label = "Eyewear"             , value = "action13", desc = "Eyewear"             , image='items/generic_clothing_glasses.png'},
		{label = "Gloves"              , value = "action14", desc = "Gloves"              , image='items/clothing_generic_glove.png'},
		{label = "Gunbelts"            , value = "action15", desc = "Gunbelts"            , image='items/clothing_generic_gunbelt.png'},
		{label = "Hats"                , value = "action16", desc = "Hats"                , image='items/clothing_generic_hat.png'},
		{label = "Holsters_left"       , value = "action17", desc = "Holsters_left"       , image='items/upgrade_offhand_holster.png'},
		{label = "Jewelry_rings_left"  , value = "action18", desc = "Jewelry_rings_left"  , image='items/provision_ring_platinum.png'},
		{label = "Jewelry_rings_right" , value = "action19", desc = "Jewelry_rings_right" , image='items/provision_signet_ring.png'},
		{label = "Necties"             , value = "action20", desc = "Necties"             , image='items/clothing_generic_neckerchief.png'},
		{label = "Neckwear"            , value = "action21", desc = "Neckwear"            , image='items/clothing_generic_scarf.png'},
		{label = "Shirts_full"         , value = "action22", desc = "Shirts_full"         , image='items/clothing_generic_f_shirt.png'},
		{label = "Pants"               , value = "action23", desc = "Pants"               , image='items/clothing_generic_f_pants.png'},
		{label = "Ponchos"             , value = "action24", desc = "Ponchos"             , image='items/clothing_generic_poncho.png'},
		{label = "Spats"               , value = "action25", desc = "Spats"               , image='items/clothing_generic_spats.png'},
		{label = "Suspenders"          , value = "action26", desc = "Suspenders"          , image='items/clothing_generic_suspenders.png'},
		{label = "Vests"               , value = "action27", desc = "Vests"               , image='items/clothing_generic_vest.png'},				
}

---------------------------- 
--CLOTHES OPTIONS MENU--
----------------------------
--Here you can remove certain options if you want to: just add -- in front of the line like this :
--{label = 'Pocket Mirror', value = "action01", desc = 'Impress everyone by pulling this action'},
Config.TextMenuClothesOptionsTitle = "Clothes"
Config.ClothingMenuOptions = {
        {label = "Bandana On"       , value = "action01",  desc = "Bandana On"       , image = "items/kit_bandana.png"              },
		{label = "Bandana Off"      , value = "action02",  desc = "Bandana Off"      , image = "items/kit_bandana.png"              },
		{label = "Roll Down Sleeves", value = "action03",  desc = "Roll Down Sleeves", image = "items/clothing_generic_f_shirt.png" },
		{label = "Roll Up Sleeves"  , value = "action04",  desc = "Roll Up Sleeves"  , image = "items/clothing_generic_f_shirt.png" },
		{label = "Tuck Pants out"   , value = "action05",  desc = "Tuck Pants out"   , image = "items/clothing_generic_f_pants.png" },
		{label = "Tuck Pants in"    , value = "action06",  desc = "Tuck Pants in"    , image = "items/clothing_generic_boots.png"   },
		{label = "Tuck Corset in"   , value = "action07",  desc = "Tuck Corset in"   , image = "items/clothing_generic_corset.png"  },
		{label = "Tuck Corset Out"  , value = "action08",  desc = "Tuck Corset Out"  , image = "items/clothing_generic_corset.png"  },
		{label = "Button Collar"    , value = "action09",  desc = "Button Collar"    , image = "items/clothing_generic_f_shirt.png" },
		{label = "Unbutton Collar"  , value = "action10",  desc = "Unbutton Collar"  , image = "items/clothing_generic_f_shirt.png" },
}
 
----------------------------  
	--ACTIONS MENU--
---------------------------- 
--Here you can remove certain options if you want to: just add -- in front of the line like this :
--{label = 'Pocket Mirror', value = "action01", desc = 'Impress everyone by pulling this action'},
Config.TextMenuActionsTitle   = "Actions"    
Config.MenuActions = {
        {label = "Music"   ,                   value = "action1", desc = "Music"   ,                  image='items/generic_camp_song.png'},
		{label = "Sitting",                    value = "action2", desc = "Sitting",                   image='items/sit.png'},
		{label = "Standing / Roles",           value = "action3", desc = "Standing",                  image='items/emote_dance_old_a.png'},
		{label = "Emotes"        ,             value = "action4", desc = "Emotes"        ,            image='items/emote_reaction_point_and_laugh.png'},
		{label = "Study The Stars",            value = "action5", desc = "Study The Stars",           image='items/sirevlc_moon.png'},
		{label = "Walkstyles",                 value = "action7", desc = "Walkstyles",                image='items/emote_dance_awkward_a.png'},
	    {label = "Play Nearest Scenario"   ,   value = "action8", desc = "Play Nearest Scenario"   ,  image='items/emote_reaction_shake_head.png'},
		{label = "Stop action"   ,             value = "action6", desc = "Stop action"   ,            image='items/emote_action_stop_here.png'},	
}

---------------------------- 
--WALKSTYLES MENU--
---------------------------- 
--Here you can remove certain options if you want to: just add -- in front of the line like this :
--{label = 'Pocket Mirror', value = "action01", desc = 'Impress everyone by pulling this action'},
Config.MenuWalkstylesTitle   = "Walkstyles"    
Config.MenuWalkstyles = {
	    {label = "Remove Walkstyle"   ,value = "action12", desc = "Remove Walk"   },        
        {label = "Casual"             ,value = "action01", desc = "Casual"        },     -- walkstyle1
		{label = "Crazy"              ,value = "action02", desc = "Crazy"         },     -- walkstyle2
		{label = "Easy Rider"         ,value = "action03", desc = "Easy Rider"    },     -- walkstyle3
		{label = "Greenhorn"          ,value = "action04", desc = "Greenhorn"     },     -- walkstyle4
		{label = "Flamboyant"         ,value = "action05", desc = "Flamboyant"    },     -- walkstyle5
	    {label = "Gunslinger"         ,value = "action06", desc = "Gunslinger"    },     -- walkstyle6
		{label = "Drunk"              ,value = "action07", desc = "Drunk"         },     -- walkstyle7
	    {label = "Inquisitive"        ,value = "action08", desc = "Inquisitive"   },     -- walkstyle8
	    {label = "Refined"            ,value = "action09", desc = "Refined"       },     -- walkstyle9
	    {label = "Silent Type"        ,value = "action10", desc = "Silent Type"   },     -- walkstyle10
	    {label = "Veteran"            ,value = "action11", desc = "Veteran"       },     -- walkstyle11
	    {label = "Veteran"            ,value = "action11", desc = "Veteran"       },     -- walkstyle12
		{label = "Slightly Drunk"     ,value = "action13", desc = "Slightly Drunk"},     -- walkstyle13
		{label = "Very Drunk"         ,value = "action14", desc = "Very Drunk"    },	 -- walkstyle14
		{label = "Completely Smashed" ,value = "action15", desc = "Smashed"       },     -- walkstyle15
		{label = "Forced Fall"        ,value = "action16", desc = "Forced Fall"   },	 -- walkstyle16
}
	
 
---------------------------- 
--STANDING ACTIONS MENU--
---------------------------- 

--Here you can remove certain options if you want to: just add -- in front of the line like this :
--{label = 'Pocket Mirror', value = "action01", desc = 'Impress everyone by pulling this action'},

Config.StandingActionsMenuTitle = "Standing"
Config.StandingActionsMenu = {
		{label = 'Police',    value = "action01", desc = 'Police' , image = "items/clothing_hat_000_police.png"},
		{label = 'Trading',   value = "action02", desc = 'Trader' , image = "items/money_moneystack.png"},
		{label = 'Smoking',   value = "action03", desc = 'Smoking', image = "items/emote_action_smoke_cigarette_classy_1.png"},
		{label = 'Washing',   value = "action04", desc = 'Washing', image = "items/emote_clap.png"},
		{label = 'Stance',    value = "action05", desc = 'Stances', image = "items/emote_dance_old_a.png"},	
		{label = 'Saloon',    value = "action06", desc = 'Saloon',  image = "items/emote_action_drinking_drifter_1.png"},	
}
 
Config.StandingPoliceMenuTitle = "Police"
Config.StandingPoliceMenu = {
		{label = 'Arrest Hands Up',    value = "action01",  desc = 'Arrest Hands Up'    },
		{label = 'Frightened',         value = "action02",  desc = 'Frightened'         },	
		{label = 'Frightened on knees',value = "action03",  desc = 'Frightened on knees'},			
		{label = 'On knees crying',    value = "action04",  desc = 'On knees Dramatic'  },	
		{label = 'On knees hands up',  value = "action05",  desc = 'On knees hands up'  },
		{label = 'Arrest Hands Up#2',  value = "action06",  desc = 'Arrest Hands Up'	},		
} 

Config.StandingPoliceMenuCommand01 = "handsup"        -- TriggerEvent("sirevlc_animations", "StandingPoliceMenuCommand01") 
Config.StandingPoliceMenuCommand02 = "frightened"     -- TriggerEvent("sirevlc_animations", "StandingPoliceMenuCommand02")    
Config.StandingPoliceMenuCommand03 = "kneesfear"      -- TriggerEvent("sirevlc_animations", "StandingPoliceMenuCommand03") 
Config.StandingPoliceMenuCommand04 = "kneesdrama"     -- TriggerEvent("sirevlc_animations", "StandingPoliceMenuCommand04") 
Config.StandingPoliceMenuCommand05 = "kneehandsup"    -- TriggerEvent("sirevlc_animations", "StandingPoliceMenuCommand05") 
Config.StandingPoliceMenuCommand06 = "handsup2"	      -- TriggerEvent("sirevlc_animations", "StandingPoliceMenuCommand06") 
 
 
Config.StandingTradingMenuTitle = "Trading"
Config.StandingTradingMenu = {
		{label = 'Inspect',       value = "action01", desc = 'Inspect'	 	 },		
		{label = 'Shopkeeper',    value = "action02", desc = 'Shopkeeper'	 },	
		{label = 'Write Notebook',value = "action03", desc = 'Write Notebook'},	
		{label = 'Give money',    value = "action04", desc = 'Give Money'	 },			
}  
 
Config.StandingTradingMenuCommand01  = "inspect"       -- TriggerEvent("sirevlc_animations", "StandingTradingMenuCommand01")
Config.StandingTradingMenuCommand02  = "shopkeeper"    -- TriggerEvent("sirevlc_animations", "StandingTradingMenuCommand02")
Config.StandingTradingMenuCommand03  = "notebook"      -- TriggerEvent("sirevlc_animations", "StandingTradingMenuCommand03")
Config.StandingTradingMenuCommand04  = "givemon"       -- TriggerEvent("sirevlc_animations", "StandingTradingMenuCommand04")
 
 
Config.StandingSmokingMenuTitle = "Smoking"
Config.StandingSmokingMenu = {
		{label = 'Smoking Cigar',     value = "action01", desc = 'Smoking Cigar'           },
		{label = 'Smoking Cigarette', value = "action02", desc = 'Smoking Cigarette'       },
		{label = 'Smoke#01',          value = "action03", desc = 'Smoke#01'                },
		{label = 'Smoke#02',          value = "action04", desc = 'Smoke#02'                },		
}   


Config.StandingSmokingMenuCommand01  = "cigar"        -- TriggerEvent("sirevlc_animations", "StandingSmokingMenuCommand01")
Config.StandingSmokingMenuCommand02  = "cigarette"    -- TriggerEvent("sirevlc_animations", "StandingSmokingMenuCommand02")
Config.StandingSmokingMenuCommand03  = "smoke1"       -- TriggerEvent("sirevlc_animations", "StandingSmokingMenuCommand03")
Config.StandingSmokingMenuCommand04  = "smoke2"       -- TriggerEvent("sirevlc_animations", "StandingSmokingMenuCommand04")

 
Config.StandingWashingMenuTitle = "Washing"
Config.StandingWashingMenu = {
	{label = 'Wash Yourself',  value = "action01", desc = 'Wash Yourself'},
}  
 
Config.StandingWashingMenuCommand01  = "wash"        -- TriggerEvent("sirevlc_animations", "StandingWashingMenuCommand01")
  
 
Config.StandingPosingMenuTitle = "Posing"
Config.StandingPosingMenu = {
	{label = 'Fan',                     value = "action01", desc = 'Fan'                    },
	{label = 'Pocket Mirror',           value = "action02", desc = 'Pocket Mirror'          },
	{label = 'Leaning Wall#01',         value = "action03", desc = 'Leaning Post'           },	
	{label = 'Leaning Wall#02',         value = "action04", desc = 'Leaning Post'           },	
	{label = 'Standing#01',             value = "action05", desc = 'Standing#01'            },
	{label = 'Standing#02',             value = "action06", desc = 'Standing#02'            },
	{label = 'Standing#03',             value = "action07", desc = 'Standing#03'            },
	{label = 'Standing#04',             value = "action08", desc = 'Standing#04'            },
	{label = 'Standing#05',             value = "action09", desc = 'Standing#05'            },	
	{label = 'Check Pistol',            value = "action10", desc = 'Checking pistol'        },	
	{label = 'Leaning and whittling',   value = "action11", desc = 'Leaning and whittling'  },		
} 

Config.StandingPosingMenuCommand01 = "fan"                -- TriggerEvent("sirevlc_animations", "StandingPosingMenuCommand01")  
Config.StandingPosingMenuCommand02 = "pocketmirror"       -- TriggerEvent("sirevlc_animations", "StandingPosingMenuCommand02")
Config.StandingPosingMenuCommand03 = "leaningpost1"       -- TriggerEvent("sirevlc_animations", "StandingPosingMenuCommand03") 
Config.StandingPosingMenuCommand04 = "leaningpost2"       -- TriggerEvent("sirevlc_animations", "StandingPosingMenuCommand04") 
Config.StandingPosingMenuCommand05 = "standing1"          -- TriggerEvent("sirevlc_animations", "StandingPosingMenuCommand05")
Config.StandingPosingMenuCommand06 = "standing2"          -- TriggerEvent("sirevlc_animations", "StandingPosingMenuCommand06")
Config.StandingPosingMenuCommand07 = "standing3"          -- TriggerEvent("sirevlc_animations", "StandingPosingMenuCommand07")
Config.StandingPosingMenuCommand08 = "standing4"          -- TriggerEvent("sirevlc_animations", "StandingPosingMenuCommand08")
Config.StandingPosingMenuCommand09 = "standing5"          -- TriggerEvent("sirevlc_animations", "StandingPosingMenuCommand09")
Config.StandingPosingMenuCommand10 = "checkpistol1"       -- TriggerEvent("sirevlc_animations", "StandingPosingMenuCommand10") 
Config.StandingPosingMenuCommand11 = "leanwhitt"          -- TriggerEvent("sirevlc_animations", "StandingPosingMenuCommand11")
 
 
Config.StandingBarMenuTitle = "Bar"
Config.StandingBarMenu = {
	{label = "Drink Champagne",      value = "action01", desc = "Drink Champagne"  },
	{label = "Serving Counter",      value = "action02", desc = "Serving Counter"  },
	{label = "Customer Waiting",     value = "action03", desc = "Customer Waiting" },
	{label = "Customer Waiting#02",  value = "action04", desc = "Customer Waiting" },
} 
 
Config.StandingBarMenuCommand01 = "fan"                -- TriggerEvent("sirevlc_animations", "StandingBarMenuCommand01")  
Config.StandingBarMenuCommand02 = "pocketmirror"       -- TriggerEvent("sirevlc_animations", "StandingBarMenuCommand02")
Config.StandingBarMenuCommand03 = "leaningpost1"       -- TriggerEvent("sirevlc_animations", "StandingBarMenuCommand03") 
Config.StandingBarMenuCommand04 = "leaningpost2"       -- TriggerEvent("sirevlc_animations", "StandingBarMenuCommand04") 
 
 
 
--------------------------------
   -- WEAPONS OPTIONS MENU -- 
-------------------------------- 
--Here you can remove certain options if you want: just add -- in front of the line like this :
--{label = 'Pocket Mirror', value = "action01", desc = 'Impress everyone by pulling this action'},
Config.TextWeaponsOptionsTitle   			= "Weapons Menu"    
Config.TextWeaponsOptionsLabel01 			= 'Rifle Position: Crossed' 
Config.TextWeaponsOptionsLabel02 			= 'Rifle Position: Shoulder'
Config.TextWeaponsOptionsLabel03 			= 'Lantern On Hip'          
Config.TextWeaponsOptionsLabel04 			= 'Reset'    
 
Config.TextWeaponsOptionsDescriptionLabel01 = 'Equip your weapon in hands before'       
Config.TextWeaponsOptionsDescriptionLabel02 = 'Equip your weapon in hands before'
Config.TextWeaponsOptionsDescriptionLabel03 = 'Lantern On Hip'
Config.TextWeaponsOptionsDescriptionLabel04 = 'Reset'          
 
 
  
------------------------------------
     -- SITTING ACTIONS MENU -- 
------------------------------------ 

--Here you can remove certain options if you want: just add -- in front of the line like this :
--{label = 'Pocket Mirror', value = "action01", desc = 'Impress everyone by pulling this action'},
Config.SittingActionsMenuTitle = "Sitting"
Config.SittingActionsMenu = {
        {label = 'Pose#01',         value = "action01", desc = 'Impress everyone by pulling this action'},
		{label = 'Pose#02',         value = "action10", desc = 'Impress everyone by pulling this action'},
		{label = 'Pose#03',         value = "action11", desc = 'Impress everyone by pulling this action'},		
		{label = 'Relax',           value = "action02", desc = 'Impress everyone by pulling this action'},
		{label = 'Like A Lady',     value = "action03", desc = 'Impress everyone by pulling this action'},
		{label = 'Drink',           value = "action04", desc = 'Impress everyone by pulling this action'},
		{label = 'Coffee',          value = "action05", desc = 'Impress everyone by pulling this action'},
		{label = 'F:Sketch M:Pose', value = "action06", desc = 'Impress everyone by pulling this action'},
		{label = 'Read a Book',     value = "action07", desc = 'Impress everyone by pulling this action'},
		{label = 'Smoke',           value = "action08", desc = 'Impress everyone by pulling this action'},
		{label = 'Read Newspaper',  value = "action09", desc = 'Impress everyone by pulling this action'},
}
 
Config.SittingActionsMenuCommand01 = "pose1"        -- TriggerEvent("sirevlc_animations", "SittingActionsMenuCommand01")  
Config.SittingActionsMenuCommand02 = "relax"        -- TriggerEvent("sirevlc_animations", "SittingActionsMenuCommand02")  
Config.SittingActionsMenuCommand03 = "likealady"    -- TriggerEvent("sirevlc_animations", "SittingActionsMenuCommand03")  
Config.SittingActionsMenuCommand04 = "drink"       	-- TriggerEvent("sirevlc_animations", "SittingActionsMenuCommand04")  
Config.SittingActionsMenuCommand05 = "sipcoffee"   	-- TriggerEvent("sirevlc_animations", "SittingActionsMenuCommand05")  
Config.SittingActionsMenuCommand06 = "sketchpose"   -- TriggerEvent("sirevlc_animations", "SittingActionsMenuCommand06")  
Config.SittingActionsMenuCommand07 = "readbook"   	-- TriggerEvent("sirevlc_animations", "SittingActionsMenuCommand07")  
Config.SittingActionsMenuCommand08 = "smoke3"  		-- TriggerEvent("sirevlc_animations", "SittingActionsMenuCommand08")  
Config.SittingActionsMenuCommand09 = "newspaper"    -- TriggerEvent("sirevlc_animations", "SittingActionsMenuCommand09")  
Config.SittingActionsMenuCommand10 = "pose2"        -- TriggerEvent("sirevlc_animations", "SittingActionsMenuCommand10")  
Config.SittingActionsMenuCommand11 = "pose3"        -- TriggerEvent("sirevlc_animations", "SittingActionsMenuCommand11")  
 
 
----------------------------  
  -- MUSIC ACTIONS MENU --
---------------------------- 

--Here you can remove certain options if you want: Just add -- in front of the line like this :
--{label = 'Pocket Mirror', value = "action01", desc = 'Impress everyone by pulling this action'},

Config.MusicActionsMenuTitle = "Music" 
Config.MusicActionsMenu = {
        {label = 'Guitar#01',         value = "action01", desc = "Impress everyone with that action" },
		{label = 'Guitar#02',         value = "action02", desc = "Impress everyone with that action" },
		{label = 'Guitar#03',         value = "action03", desc = "Impress everyone with that action" },
		{label = 'Trumpet',           value = "action04", desc = "Impress everyone with that action" },
 	
}
 
 
 Config.MusicActionsMenuCommand01 = "guitar1"  -- TriggerEvent("sirevlc_animations", "MusicActionsMenuCommand01")  
 Config.MusicActionsMenuCommand02 = "guitar2"  -- TriggerEvent("sirevlc_animations", "MusicActionsMenuCommand02")  
 Config.MusicActionsMenuCommand03 = "guitar3"  -- TriggerEvent("sirevlc_animations", "MusicActionsMenuCommand03")  
 Config.MusicActionsMenuCommand04 = "trumpet"  -- TriggerEvent("sirevlc_animations", "MusicActionsMenuCommand04")  
 
 
 
 
---------------------------- 
	--EMOTES MENUS--
---------------------------- 
Config.TextMenuEmotesTitle   		    = "Emotes Menu"    
Config.TextMenuEmotesLabel01 		    = 'Reaction'
Config.TextMenuEmotesLabel02 		    = 'Action'  
Config.TextMenuEmotesLabel03 		    = 'Taunts'  
Config.TextMenuEmotesLabel04 		    = 'Greets'  
Config.TextMenuEmotesLabel05 		    = 'TwirlGun'
Config.TextMenuEmotesLabel06 		    = 'Dances'    
 
Config.TextMenuEmotesDescriptionLabel01 = "Impress everyone with that action"
Config.TextMenuEmotesDescriptionLabel02 = "Impress everyone with that action"
Config.TextMenuEmotesDescriptionLabel03 = "Impress everyone with that action"
Config.TextMenuEmotesDescriptionLabel04 = "Impress everyone with that action"
Config.TextMenuEmotesDescriptionLabel05 = "Impress everyone with that action"
Config.TextMenuEmotesDescriptionLabel06 = "Impress everyone with that action"

---------------------------- 
--REACTIONS EMOTES MENU
---------------------------- 

Config.TextMenuEmotesReactionsLabel01 			 = "Amazed"               
Config.TextMenuEmotesReactionsLabel02 			 = "Applause"             
Config.TextMenuEmotesReactionsLabel03 			 = "Beg For mercy"        
Config.TextMenuEmotesReactionsLabel04 			 = "Clap along"           
Config.TextMenuEmotesReactionsLabel05 			 = "Facepalm"             
Config.TextMenuEmotesReactionsLabel06 			 = "Hangover"             
Config.TextMenuEmotesReactionsLabel07 			 = "How dare you"         
Config.TextMenuEmotesReactionsLabel08 			 = "Hurl"                 
Config.TextMenuEmotesReactionsLabel09 			 = "Hush your mouth"      
Config.TextMenuEmotesReactionsLabel10 			 = "Jovial laugh"         
Config.TextMenuEmotesReactionsLabel11 			 = "Nod head"             
Config.TextMenuEmotesReactionsLabel12 			 = "Phew"                 
Config.TextMenuEmotesReactionsLabel13 			 = "Pointlaugh"           
Config.TextMenuEmotesReactionsLabel14 			 = "Scared"               
Config.TextMenuEmotesReactionsLabel15 			 = "Shakehead"            
Config.TextMenuEmotesReactionsLabel16 			 = "Shot"                 
Config.TextMenuEmotesReactionsLabel17 			 = "Shrug"                
Config.TextMenuEmotesReactionsLabel18 			 = "Shuffle"              
Config.TextMenuEmotesReactionsLabel19 			 = "Slow clap"            
Config.TextMenuEmotesReactionsLabel20 			 = "Sniffing"             
Config.TextMenuEmotesReactionsLabel21 			 = "Sob"                  
Config.TextMenuEmotesReactionsLabel22 			 = "Surrender"            
Config.TextMenuEmotesReactionsLabel23 			 = "Thanks"               
Config.TextMenuEmotesReactionsLabel24 			 = "This guy"             
Config.TextMenuEmotesReactionsLabel25 			 = "Thumbsdown"           
Config.TextMenuEmotesReactionsLabel26 			 = "Wag finger"           
Config.TextMenuEmotesReactionsLabel27 			 = "Who me"               
Config.TextMenuEmotesReactionsLabel28 			 = "Yeehaw"               


-- EMOTE COMMAND : 
Config.emotesreactionscommand01 				 = "amazed"              -- TriggerEvent("sirevlc_emotes_trigger", "emotesreactionscommand01")
Config.emotesreactionscommand02 				 = "applause"            -- TriggerEvent("sirevlc_emotes_trigger", "emotesreactionscommand02")
Config.emotesreactionscommand03 				 = "beg"                 -- TriggerEvent("sirevlc_emotes_trigger", "emotesreactionscommand03")
Config.emotesreactionscommand04 				 = "clapalong"           -- TriggerEvent("sirevlc_emotes_trigger", "emotesreactionscommand04")
Config.emotesreactionscommand05 				 = "facepalm"            -- TriggerEvent("sirevlc_emotes_trigger", "emotesreactionscommand05")
Config.emotesreactionscommand06 				 = "hangover"            -- TriggerEvent("sirevlc_emotes_trigger", "emotesreactionscommand06")
Config.emotesreactionscommand07 				 = "dare"                -- TriggerEvent("sirevlc_emotes_trigger", "emotesreactionscommand07")
Config.emotesreactionscommand08 				 = "hurl"                -- TriggerEvent("sirevlc_emotes_trigger", "emotesreactionscommand08")
Config.emotesreactionscommand09 				 = "hush"                -- TriggerEvent("sirevlc_emotes_trigger", "emotesreactionscommand09")
Config.emotesreactionscommand10 				 = "jovial laugh"        -- TriggerEvent("sirevlc_emotes_trigger", "emotesreactionscommand10")
Config.emotesreactionscommand11 				 = "nodhead"             -- TriggerEvent("sirevlc_emotes_trigger", "emotesreactionscommand11")
Config.emotesreactionscommand12 				 = "phew"                -- TriggerEvent("sirevlc_emotes_trigger", "emotesreactionscommand12")
Config.emotesreactionscommand13 				 = "pointlaugh"          -- TriggerEvent("sirevlc_emotes_trigger", "emotesreactionscommand13")
Config.emotesreactionscommand14 				 = "scared"              -- TriggerEvent("sirevlc_emotes_trigger", "emotesreactionscommand14")
Config.emotesreactionscommand15 				 = "shakehead"           -- TriggerEvent("sirevlc_emotes_trigger", "emotesreactionscommand15")
Config.emotesreactionscommand16 				 = "shot"                -- TriggerEvent("sirevlc_emotes_trigger", "emotesreactionscommand16")
Config.emotesreactionscommand17 				 = "shrug"               -- TriggerEvent("sirevlc_emotes_trigger", "emotesreactionscommand17")
Config.emotesreactionscommand18 				 = "shuffle"             -- TriggerEvent("sirevlc_emotes_trigger", "emotesreactionscommand18")
Config.emotesreactionscommand19 				 = "slowclap"            -- TriggerEvent("sirevlc_emotes_trigger", "emotesreactionscommand19")
Config.emotesreactionscommand20 				 = "sniff"               -- TriggerEvent("sirevlc_emotes_trigger", "emotesreactionscommand20")
Config.emotesreactionscommand21 				 = "sob"                 -- TriggerEvent("sirevlc_emotes_trigger", "emotesreactionscommand21")
Config.emotesreactionscommand22 				 = "surrender"           -- TriggerEvent("sirevlc_emotes_trigger", "emotesreactionscommand22")
Config.emotesreactionscommand23 				 = "thanks"              -- TriggerEvent("sirevlc_emotes_trigger", "emotesreactionscommand23")
Config.emotesreactionscommand24 				 = "thisguy"             -- TriggerEvent("sirevlc_emotes_trigger", "emotesreactionscommand24")
Config.emotesreactionscommand25 				 = "thumbsdown"          -- TriggerEvent("sirevlc_emotes_trigger", "emotesreactionscommand25")
Config.emotesreactionscommand26 				 = "wagfinger"           -- TriggerEvent("sirevlc_emotes_trigger", "emotesreactionscommand26")
Config.emotesreactionscommand27 				 = "whome"               -- TriggerEvent("sirevlc_emotes_trigger", "emotesreactionscommand27")
Config.emotesreactionscommand28 				 = "yeehaw"              -- TriggerEvent("sirevlc_emotes_trigger", "emotesreactionscommand28")


 
Config.TextMenuEmotesReactionsDescriptionLabel01 = "Use that Reaction Emote"
Config.TextMenuEmotesReactionsDescriptionLabel02 = "Use that Reaction Emote"
Config.TextMenuEmotesReactionsDescriptionLabel03 = "Use that Reaction Emote"
Config.TextMenuEmotesReactionsDescriptionLabel04 = "Use that Reaction Emote"
Config.TextMenuEmotesReactionsDescriptionLabel05 = "Use that Reaction Emote"
Config.TextMenuEmotesReactionsDescriptionLabel06 = "Use that Reaction Emote"
Config.TextMenuEmotesReactionsDescriptionLabel07 = "Use that Reaction Emote"
Config.TextMenuEmotesReactionsDescriptionLabel08 = "Use that Reaction Emote"
Config.TextMenuEmotesReactionsDescriptionLabel09 = "Use that Reaction Emote"
Config.TextMenuEmotesReactionsDescriptionLabel10 = "Use that Reaction Emote"
Config.TextMenuEmotesReactionsDescriptionLabel11 = "Use that Reaction Emote"
Config.TextMenuEmotesReactionsDescriptionLabel12 = "Use that Reaction Emote"
Config.TextMenuEmotesReactionsDescriptionLabel13 = "Use that Reaction Emote"
Config.TextMenuEmotesReactionsDescriptionLabel14 = "Use that Reaction Emote"
Config.TextMenuEmotesReactionsDescriptionLabel15 = "Use that Reaction Emote"
Config.TextMenuEmotesReactionsDescriptionLabel16 = "Use that Reaction Emote"
Config.TextMenuEmotesReactionsDescriptionLabel17 = "Use that Reaction Emote"
Config.TextMenuEmotesReactionsDescriptionLabel18 = "Use that Reaction Emote"
Config.TextMenuEmotesReactionsDescriptionLabel19 = "Use that Reaction Emote"
Config.TextMenuEmotesReactionsDescriptionLabel20 = "Use that Reaction Emote"
Config.TextMenuEmotesReactionsDescriptionLabel21 = "Use that Reaction Emote"
Config.TextMenuEmotesReactionsDescriptionLabel22 = "Use that Reaction Emote"
Config.TextMenuEmotesReactionsDescriptionLabel23 = "Use that Reaction Emote"
Config.TextMenuEmotesReactionsDescriptionLabel24 = "Use that Reaction Emote"
Config.TextMenuEmotesReactionsDescriptionLabel25 = "Use that Reaction Emote"
Config.TextMenuEmotesReactionsDescriptionLabel26 = "Use that Reaction Emote"
Config.TextMenuEmotesReactionsDescriptionLabel27 = "Use that Reaction Emote"
Config.TextMenuEmotesReactionsDescriptionLabel28 = "Use that Reaction Emote"
 
---------------------------- 
--ACTIONS EMOTES MENU
---------------------------- 
Config.TextMenuEmotesActionsLabel01 		     = "Air banjo"                  
Config.TextMenuEmotesActionsLabel02 		     = "Beckon"                     
Config.TextMenuEmotesActionsLabel03 		     = "Biting gold coin"           
Config.TextMenuEmotesActionsLabel04 		     = "Blow kiss"                  
Config.TextMenuEmotesActionsLabel05 		     = "Boast"                      
Config.TextMenuEmotesActionsLabel06 		     = "Check pocket watch"         
Config.TextMenuEmotesActionsLabel07 		     = "Coin flip"                  
Config.TextMenuEmotesActionsLabel08 		     = "Fist pump"                  
Config.TextMenuEmotesActionsLabel09 		     = "Flex"                       
Config.TextMenuEmotesActionsLabel10 		     = "Follow me"                  
Config.TextMenuEmotesActionsLabel11 		     = "Hissy fit"                  
Config.TextMenuEmotesActionsLabel12 		     = "Howl"                       
Config.TextMenuEmotesActionsLabel13 		     = "Hypnosis pocketwatch"       
Config.TextMenuEmotesActionsLabel14 		     = "Idea"                       
Config.TextMenuEmotesActionsLabel15 		     = "Lets craft"                 
Config.TextMenuEmotesActionsLabel16 		     = "Lets fish"                  
Config.TextMenuEmotesActionsLabel17 		     = "Lets go"                    
Config.TextMenuEmotesActionsLabel18 		     = "Lets play cards"            
Config.TextMenuEmotesActionsLabel19 		     = "Listen"                     
Config.TextMenuEmotesActionsLabel20 		     = "Look distance"              
Config.TextMenuEmotesActionsLabel21 		     = "Look yonder"                
Config.TextMenuEmotesActionsLabel22 		     = "New threads"                
Config.TextMenuEmotesActionsLabel23 		     = "Point"                      
Config.TextMenuEmotesActionsLabel24 		     = "Posse up"                   
Config.TextMenuEmotesActionsLabel25 		     = "Prayer"                     
Config.TextMenuEmotesActionsLabel26 		     = "Prospector jig"             
Config.TextMenuEmotesActionsLabel27 		     = "Rock paper scissors"        
Config.TextMenuEmotesActionsLabel28 		     = "Scheme"                     
Config.TextMenuEmotesActionsLabel29 		     = "Shoot hip"                  
Config.TextMenuEmotesActionsLabel30 		     = "Skyward shooting"           
Config.TextMenuEmotesActionsLabel31 		     = "Smoke cigar"                
Config.TextMenuEmotesActionsLabel32 		     = "Smoke cigarette"            
Config.TextMenuEmotesActionsLabel33 		     = "Snot rocket"                
Config.TextMenuEmotesActionsLabel34 		     = "Spin and aim"               
Config.TextMenuEmotesActionsLabel35 		     = "Spit"                       
Config.TextMenuEmotesActionsLabel36 		     = "Spooky"                     
Config.TextMenuEmotesActionsLabel37 		     = "Stop here"                  
Config.TextMenuEmotesActionsLabel38 		     = "Take notes"                 
Config.TextMenuEmotesActionsLabel39 		     = "Wet your whistle"           

Config.emotesactionscommands01 		  			 = "airbanjo"            		 -- TriggerEvent("sirevlc_emotes_trigger", "emotesactionscommands01")
Config.emotesactionscommands02 		  			 = "beckon"              		 -- TriggerEvent("sirevlc_emotes_trigger", "emotesactionscommands02")
Config.emotesactionscommands03 		  			 = "gold"                		 -- TriggerEvent("sirevlc_emotes_trigger", "emotesactionscommands03")
Config.emotesactionscommands04 		  			 = "blowkiss"            		 -- TriggerEvent("sirevlc_emotes_trigger", "emotesactionscommands04")
Config.emotesactionscommands05 		  			 = "boast"               		 -- TriggerEvent("sirevlc_emotes_trigger", "emotesactionscommands05")
Config.emotesactionscommands06 		  			 = "checkpocket"         		 -- TriggerEvent("sirevlc_emotes_trigger", "emotesactionscommands06")
Config.emotesactionscommands07 		  			 = "coinflip"            		 -- TriggerEvent("sirevlc_emotes_trigger", "emotesactionscommands07")
Config.emotesactionscommands08 		  			 = "fistpump"            		 -- TriggerEvent("sirevlc_emotes_trigger", "emotesactionscommands08")
Config.emotesactionscommands09 		  			 = "flex"                		 -- TriggerEvent("sirevlc_emotes_trigger", "emotesactionscommands09")
Config.emotesactionscommands10 		  			 = "followme"            		 -- TriggerEvent("sirevlc_emotes_trigger", "emotesactionscommands10")
Config.emotesactionscommands11 		  			 = "hissyfit"            		 -- TriggerEvent("sirevlc_emotes_trigger", "emotesactionscommands11")
Config.emotesactionscommands12 		  			 = "howl"                		 -- TriggerEvent("sirevlc_emotes_trigger", "emotesactionscommands12")
Config.emotesactionscommands13 		  			 = "hypnos"              		 -- TriggerEvent("sirevlc_emotes_trigger", "emotesactionscommands13")
Config.emotesactionscommands14 		  			 = "idea"                		 -- TriggerEvent("sirevlc_emotes_trigger", "emotesactionscommands14")
Config.emotesactionscommands15 		  			 = "letscraft"           		 -- TriggerEvent("sirevlc_emotes_trigger", "emotesactionscommands15")
Config.emotesactionscommands16 		  			 = "letsfish"            		 -- TriggerEvent("sirevlc_emotes_trigger", "emotesactionscommands16")
Config.emotesactionscommands17 		  			 = "letsgo"              		 -- TriggerEvent("sirevlc_emotes_trigger", "emotesactionscommands17")
Config.emotesactionscommands18 		  			 = "playcards"           		 -- TriggerEvent("sirevlc_emotes_trigger", "emotesactionscommands18")
Config.emotesactionscommands19 		  			 = "listen"              		 -- TriggerEvent("sirevlc_emotes_trigger", "emotesactionscommands19")
Config.emotesactionscommands20 		  			 = "lookdistance"        		 -- TriggerEvent("sirevlc_emotes_trigger", "emotesactionscommands20")
Config.emotesactionscommands21 		  			 = "lookyonder"          		 -- TriggerEvent("sirevlc_emotes_trigger", "emotesactionscommands21")
Config.emotesactionscommands22 		  			 = "newthreads"          		 -- TriggerEvent("sirevlc_emotes_trigger", "emotesactionscommands22")
Config.emotesactionscommands23 		  			 = "point"               		 -- TriggerEvent("sirevlc_emotes_trigger", "emotesactionscommands23")
Config.emotesactionscommands24 		  			 = "posseup"             		 -- TriggerEvent("sirevlc_emotes_trigger", "emotesactionscommands24")
Config.emotesactionscommands25 		  			 = "prayer"              		 -- TriggerEvent("sirevlc_emotes_trigger", "emotesactionscommands25")
Config.emotesactionscommands26 		  			 = "prospectorjig"       		 -- TriggerEvent("sirevlc_emotes_trigger", "emotesactionscommands26")
Config.emotesactionscommands27 		  			 = "rockpaperscissors"   		 -- TriggerEvent("sirevlc_emotes_trigger", "emotesactionscommands27")
Config.emotesactionscommands28 		  			 = "scheme"              		 -- TriggerEvent("sirevlc_emotes_trigger", "emotesactionscommands28")
Config.emotesactionscommands29 		  			 = "shoothip"            		 -- TriggerEvent("sirevlc_emotes_trigger", "emotesactionscommands29")
Config.emotesactionscommands30 		  			 = "skywardshooting"     		 -- TriggerEvent("sirevlc_emotes_trigger", "emotesactionscommands30")
Config.emotesactionscommands31 		  			 = "smokecigar"          		 -- TriggerEvent("sirevlc_emotes_trigger", "emotesactionscommands31")
Config.emotesactionscommands32 		  			 = "smokecigarette"      		 -- TriggerEvent("sirevlc_emotes_trigger", "emotesactionscommands32")
Config.emotesactionscommands33 		  			 = "snotrocket"          		 -- TriggerEvent("sirevlc_emotes_trigger", "emotesactionscommands33")
Config.emotesactionscommands34 		  			 = "spinandaim"          		 -- TriggerEvent("sirevlc_emotes_trigger", "emotesactionscommands34")
Config.emotesactionscommands35 		  			 = "spit"                		 -- TriggerEvent("sirevlc_emotes_trigger", "emotesactionscommands35")
Config.emotesactionscommands36 		  			 = "spooky"              		 -- TriggerEvent("sirevlc_emotes_trigger", "emotesactionscommands36")
Config.emotesactionscommands37 		  			 = "stophere"            		 -- TriggerEvent("sirevlc_emotes_trigger", "emotesactionscommands37")
Config.emotesactionscommands38 		  			 = "takenotes"           		 -- TriggerEvent("sirevlc_emotes_trigger", "emotesactionscommands38")
Config.emotesactionscommands39 		  			 = "wetyourwhistle"      		 -- TriggerEvent("sirevlc_emotes_trigger", "emotesactionscommands39")
         
Config.TextMenuEmotesActionsDescriptionLabel01 = "Use that Action Emote"
Config.TextMenuEmotesActionsDescriptionLabel02 = "Use that Action Emote"
Config.TextMenuEmotesActionsDescriptionLabel03 = "Use that Action Emote"
Config.TextMenuEmotesActionsDescriptionLabel04 = "Use that Action Emote"
Config.TextMenuEmotesActionsDescriptionLabel05 = "Use that Action Emote"
Config.TextMenuEmotesActionsDescriptionLabel06 = "Use that Action Emote"
Config.TextMenuEmotesActionsDescriptionLabel07 = "Use that Action Emote"
Config.TextMenuEmotesActionsDescriptionLabel08 = "Use that Action Emote"
Config.TextMenuEmotesActionsDescriptionLabel09 = "Use that Action Emote"
Config.TextMenuEmotesActionsDescriptionLabel10 = "Use that Action Emote"
Config.TextMenuEmotesActionsDescriptionLabel11 = "Use that Action Emote"
Config.TextMenuEmotesActionsDescriptionLabel12 = "Use that Action Emote"
Config.TextMenuEmotesActionsDescriptionLabel13 = "Use that Action Emote"
Config.TextMenuEmotesActionsDescriptionLabel14 = "Use that Action Emote"
Config.TextMenuEmotesActionsDescriptionLabel15 = "Use that Action Emote"
Config.TextMenuEmotesActionsDescriptionLabel16 = "Use that Action Emote"
Config.TextMenuEmotesActionsDescriptionLabel17 = "Use that Action Emote"
Config.TextMenuEmotesActionsDescriptionLabel18 = "Use that Action Emote"
Config.TextMenuEmotesActionsDescriptionLabel19 = "Use that Action Emote"
Config.TextMenuEmotesActionsDescriptionLabel20 = "Use that Action Emote"
Config.TextMenuEmotesActionsDescriptionLabel21 = "Use that Action Emote"
Config.TextMenuEmotesActionsDescriptionLabel22 = "Use that Action Emote"
Config.TextMenuEmotesActionsDescriptionLabel23 = "Use that Action Emote"
Config.TextMenuEmotesActionsDescriptionLabel24 = "Use that Action Emote"
Config.TextMenuEmotesActionsDescriptionLabel25 = "Use that Action Emote"
Config.TextMenuEmotesActionsDescriptionLabel26 = "Use that Action Emote"
Config.TextMenuEmotesActionsDescriptionLabel27 = "Use that Action Emote"
Config.TextMenuEmotesActionsDescriptionLabel28 = "Use that Action Emote"
Config.TextMenuEmotesActionsDescriptionLabel29 = "Use that Action Emote"
Config.TextMenuEmotesActionsDescriptionLabel30 = "Use that Action Emote"
Config.TextMenuEmotesActionsDescriptionLabel31 = "Use that Action Emote"
Config.TextMenuEmotesActionsDescriptionLabel32 = "Use that Action Emote"
Config.TextMenuEmotesActionsDescriptionLabel33 = "Use that Action Emote"
Config.TextMenuEmotesActionsDescriptionLabel34 = "Use that Action Emote"
Config.TextMenuEmotesActionsDescriptionLabel35 = "Use that Action Emote"
Config.TextMenuEmotesActionsDescriptionLabel36 = "Use that Action Emote"
Config.TextMenuEmotesActionsDescriptionLabel37 = "Use that Action Emote"
Config.TextMenuEmotesActionsDescriptionLabel38 = "Use that Action Emote"
Config.TextMenuEmotesActionsDescriptionLabel39 = "Use that Action Emote"
 
---------------------------- 
--TAUNTS EMOTES MENU -- 
---------------------------- 
Config.TextMenuEmotesTauntsLabel01			  = "Best Shot"        
Config.TextMenuEmotesTauntsLabel02			  = "Boohoo"           
Config.TextMenuEmotesTauntsLabel03			  = "Chicken"          
Config.TextMenuEmotesTauntsLabel04			  = "Cock snook"       
Config.TextMenuEmotesTauntsLabel05			  = "Cougar snarl"     
Config.TextMenuEmotesTauntsLabel06			  = "Cruising bruising"
Config.TextMenuEmotesTauntsLabel07			  = "Cuckoo"           
Config.TextMenuEmotesTauntsLabel08			  = "Fiddlehead "      
Config.TextMenuEmotesTauntsLabel09			  = "Finger slinger "  
Config.TextMenuEmotesTauntsLabel10			  = "Flip off"         
Config.TextMenuEmotesTauntsLabel11			  = "Frighten"         
Config.TextMenuEmotesTauntsLabel12			  = "Gorilla chest"    
Config.TextMenuEmotesTauntsLabel13			  = "Im watching you"  
Config.TextMenuEmotesTauntsLabel14			  = "Insignificant"    
Config.TextMenuEmotesTauntsLabel15			  = "Provoke"          
Config.TextMenuEmotesTauntsLabel16			  = "Ripper"           
Config.TextMenuEmotesTauntsLabel17			  = "Throat slit"      
Config.TextMenuEmotesTauntsLabel18			  = "Up yours"         
Config.TextMenuEmotesTauntsLabel19			  = "Versus"           
Config.TextMenuEmotesTauntsLabel20			  = "Warcry"           
Config.TextMenuEmotesTauntsLabel21			  = "You stink"      

Config.emotestauntscommands01			  	  = "bestshot"                           -- TriggerEvent("sirevlc_emotes_trigger", "emotestauntscommands01") end)
Config.emotestauntscommands02			  	  = "boohoo"                             -- TriggerEvent("sirevlc_emotes_trigger", "emotestauntscommands02") end)
Config.emotestauntscommands03			  	  = "chicken"                            -- TriggerEvent("sirevlc_emotes_trigger", "emotestauntscommands03") end)
Config.emotestauntscommands04			  	  = "cocksnook"                          -- TriggerEvent("sirevlc_emotes_trigger", "emotestauntscommands04") end)
Config.emotestauntscommands05			  	  = "cougarsnarl"                        -- TriggerEvent("sirevlc_emotes_trigger", "emotestauntscommands05") end)
Config.emotestauntscommands06			  	  = "cruising"                           -- TriggerEvent("sirevlc_emotes_trigger", "emotestauntscommands06") end)
Config.emotestauntscommands07			  	  = "cuckoo"                             -- TriggerEvent("sirevlc_emotes_trigger", "emotestauntscommands07") end)
Config.emotestauntscommands08			  	  = "fiddlehead"                         -- TriggerEvent("sirevlc_emotes_trigger", "emotestauntscommands08") end)
Config.emotestauntscommands09			  	  = "fingerslinger"                      -- TriggerEvent("sirevlc_emotes_trigger", "emotestauntscommands09") end)
Config.emotestauntscommands10			  	  = "flipoff"                            -- TriggerEvent("sirevlc_emotes_trigger", "emotestauntscommands10") end)
Config.emotestauntscommands11			  	  = "frighten"                           -- TriggerEvent("sirevlc_emotes_trigger", "emotestauntscommands11") end)
Config.emotestauntscommands12			  	  = "gorillachest"                       -- TriggerEvent("sirevlc_emotes_trigger", "emotestauntscommands12") end)
Config.emotestauntscommands13			  	  = "watchingyou"                        -- TriggerEvent("sirevlc_emotes_trigger", "emotestauntscommands13") end)
Config.emotestauntscommands14			  	  = "insignificant"                      -- TriggerEvent("sirevlc_emotes_trigger", "emotestauntscommands14") end)
Config.emotestauntscommands15			  	  = "provoke"                            -- TriggerEvent("sirevlc_emotes_trigger", "emotestauntscommands15") end)
Config.emotestauntscommands16			  	  = "ripper"                             -- TriggerEvent("sirevlc_emotes_trigger", "emotestauntscommands16") end)
Config.emotestauntscommands17			  	  = "throatslit"                         -- TriggerEvent("sirevlc_emotes_trigger", "emotestauntscommands17") end)
Config.emotestauntscommands18			  	  = "upyours"                            -- TriggerEvent("sirevlc_emotes_trigger", "emotestauntscommands18") end)
Config.emotestauntscommands19			  	  = "versus"                             -- TriggerEvent("sirevlc_emotes_trigger", "emotestauntscommands19") end)
Config.emotestauntscommands20			  	  = "warcry"                             -- TriggerEvent("sirevlc_emotes_trigger", "emotestauntscommands20") end)
Config.emotestauntscommands21			  	  = "stink"                              -- TriggerEvent("sirevlc_emotes_trigger", "emotestauntscommands21") end)
           
Config.TextMenuEmotesTauntsDescriptionLabel01 = "Use that taunt emote"
Config.TextMenuEmotesTauntsDescriptionLabel02 = "Use that taunt emote"
Config.TextMenuEmotesTauntsDescriptionLabel03 = "Use that taunt emote"
Config.TextMenuEmotesTauntsDescriptionLabel04 = "Use that taunt emote"
Config.TextMenuEmotesTauntsDescriptionLabel05 = "Use that taunt emote"
Config.TextMenuEmotesTauntsDescriptionLabel06 = "Use that taunt emote"
Config.TextMenuEmotesTauntsDescriptionLabel07 = "Use that taunt emote"
Config.TextMenuEmotesTauntsDescriptionLabel08 = "Use that taunt emote"
Config.TextMenuEmotesTauntsDescriptionLabel09 = "Use that taunt emote"
Config.TextMenuEmotesTauntsDescriptionLabel10 = "Use that taunt emote"
Config.TextMenuEmotesTauntsDescriptionLabel11 = "Use that taunt emote"
Config.TextMenuEmotesTauntsDescriptionLabel12 = "Use that taunt emote"
Config.TextMenuEmotesTauntsDescriptionLabel13 = "Use that taunt emote"
Config.TextMenuEmotesTauntsDescriptionLabel14 = "Use that taunt emote"
Config.TextMenuEmotesTauntsDescriptionLabel15 = "Use that taunt emote"
Config.TextMenuEmotesTauntsDescriptionLabel16 = "Use that taunt emote"
Config.TextMenuEmotesTauntsDescriptionLabel17 = "Use that taunt emote"
Config.TextMenuEmotesTauntsDescriptionLabel18 = "Use that taunt emote"
Config.TextMenuEmotesTauntsDescriptionLabel19 = "Use that taunt emote"
Config.TextMenuEmotesTauntsDescriptionLabel20 = "Use that taunt emote"
Config.TextMenuEmotesTauntsDescriptionLabel21 = "Use that taunt emote"
 
---------------------------- 
-- GREETS EMOTES MENU --
---------------------------- 
Config.TextMenuEmotesGreetsLabel01			  = "Fancy bow"      
Config.TextMenuEmotesGreetsLabel02			  = "Flying kiss"    
Config.TextMenuEmotesGreetsLabel03			  = "Gentle Wave"     
Config.TextMenuEmotesGreetsLabel04			  = "Get over here"  
Config.TextMenuEmotesGreetsLabel05			  = "Glad"           
Config.TextMenuEmotesGreetsLabel06			  = "Handshake"    
Config.TextMenuEmotesGreetsLabel07			  = "Hat flick "     
Config.TextMenuEmotesGreetsLabel08			  = "Hat tip"       
Config.TextMenuEmotesGreetsLabel09			  = "Hey you"       
Config.TextMenuEmotesGreetsLabel10			  = "Outpour"       
Config.TextMenuEmotesGreetsLabel11			  = "Respectful bow "
Config.TextMenuEmotesGreetsLabel12			  = "Rough housing " 
Config.TextMenuEmotesGreetsLabel13			  = "Seven"         
Config.TextMenuEmotesGreetsLabel14			  = "Subtle wave"   
Config.TextMenuEmotesGreetsLabel15			  = "Tada"          
Config.TextMenuEmotesGreetsLabel16			  = "Thumbs up"     
Config.TextMenuEmotesGreetsLabel17			  = "Tough"         
Config.TextMenuEmotesGreetsLabel18			  = "Wave near" 

Config.emotesgreetscommands01			  = "fancybow"                                    -- TriggerEvent("sirevlc_emotes_trigger", "emotesgreetscommands01") end)
Config.emotesgreetscommands02			  = "flyingkiss"                                  -- TriggerEvent("sirevlc_emotes_trigger", "emotesgreetscommands02") end)
Config.emotesgreetscommands03			  = "gentlewave"                                  -- TriggerEvent("sirevlc_emotes_trigger", "emotesgreetscommands03") end)
Config.emotesgreetscommands04			  = "getoverhere"                                 -- TriggerEvent("sirevlc_emotes_trigger", "emotesgreetscommands04") end)
Config.emotesgreetscommands05			  = "glad"                                        -- TriggerEvent("sirevlc_emotes_trigger", "emotesgreetscommands05") end)
Config.emotesgreetscommands06			  = "handshake"                                   -- TriggerEvent("sirevlc_emotes_trigger", "emotesgreetscommands06") end)
Config.emotesgreetscommands07			  = "hatflick"                                    -- TriggerEvent("sirevlc_emotes_trigger", "emotesgreetscommands07") end)
Config.emotesgreetscommands08			  = "hattip"                                      -- TriggerEvent("sirevlc_emotes_trigger", "emotesgreetscommands08") end)
Config.emotesgreetscommands09			  = "heyyou"                                      -- TriggerEvent("sirevlc_emotes_trigger", "emotesgreetscommands09") end)
Config.emotesgreetscommands10			  = "outpour"                                     -- TriggerEvent("sirevlc_emotes_trigger", "emotesgreetscommands10") end)
Config.emotesgreetscommands11			  = "respectfulbow"                               -- TriggerEvent("sirevlc_emotes_trigger", "emotesgreetscommands11") end)
Config.emotesgreetscommands12			  = "roughhousing"                                -- TriggerEvent("sirevlc_emotes_trigger", "emotesgreetscommands12") end)
Config.emotesgreetscommands13			  = "seven"                                       -- TriggerEvent("sirevlc_emotes_trigger", "emotesgreetscommands13") end)
Config.emotesgreetscommands14			  = "subtlewave"                                  -- TriggerEvent("sirevlc_emotes_trigger", "emotesgreetscommands14") end)
Config.emotesgreetscommands15			  = "tada"                                        -- TriggerEvent("sirevlc_emotes_trigger", "emotesgreetscommands15") end)
Config.emotesgreetscommands16			  = "thumbsup"                                    -- TriggerEvent("sirevlc_emotes_trigger", "emotesgreetscommands16") end)
Config.emotesgreetscommands17			  = "tough"                                       -- TriggerEvent("sirevlc_emotes_trigger", "emotesgreetscommands17") end)
Config.emotesgreetscommands18			  = "wavenear"                                    -- TriggerEvent("sirevlc_emotes_trigger", "emotesgreetscommands18") end)
         
Config.TextMenuEmotesGreetsDescriptionLabel01 = "Use that Greet Emote"
Config.TextMenuEmotesGreetsDescriptionLabel02 = "Use that Greet Emote"
Config.TextMenuEmotesGreetsDescriptionLabel03 = "Use that Greet Emote"
Config.TextMenuEmotesGreetsDescriptionLabel04 = "Use that Greet Emote"
Config.TextMenuEmotesGreetsDescriptionLabel05 = "Use that Greet Emote"
Config.TextMenuEmotesGreetsDescriptionLabel06 = "Use that Greet Emote"
Config.TextMenuEmotesGreetsDescriptionLabel07 = "Use that Greet Emote"
Config.TextMenuEmotesGreetsDescriptionLabel08 = "Use that Greet Emote"
Config.TextMenuEmotesGreetsDescriptionLabel09 = "Use that Greet Emote"
Config.TextMenuEmotesGreetsDescriptionLabel10 = "Use that Greet Emote"
Config.TextMenuEmotesGreetsDescriptionLabel11 = "Use that Greet Emote"
Config.TextMenuEmotesGreetsDescriptionLabel12 = "Use that Greet Emote"
Config.TextMenuEmotesGreetsDescriptionLabel13 = "Use that Greet Emote"
Config.TextMenuEmotesGreetsDescriptionLabel14 = "Use that Greet Emote"
Config.TextMenuEmotesGreetsDescriptionLabel15 = "Use that Greet Emote"
Config.TextMenuEmotesGreetsDescriptionLabel16 = "Use that Greet Emote"
Config.TextMenuEmotesGreetsDescriptionLabel17 = "Use that Greet Emote"
Config.TextMenuEmotesGreetsDescriptionLabel18 = "Use that Greet Emote"
 
---------------------------- 
--DANCES EMOTES MENU
---------------------------- 
Config.TextMenuEmotesDancesLabel01			  = "Awkward"  
Config.TextMenuEmotesDancesLabel02			  = "Carefree#A" 
Config.TextMenuEmotesDancesLabel03			  = "Carefree#B" 
Config.TextMenuEmotesDancesLabel04			  = "Confident#A"
Config.TextMenuEmotesDancesLabel05			  = "Confident#B"
Config.TextMenuEmotesDancesLabel06			  = "Drunk#A"    
Config.TextMenuEmotesDancesLabel07			  = "Drunk#B"    
Config.TextMenuEmotesDancesLabel08			  = "Formal"   
Config.TextMenuEmotesDancesLabel09			  = "Graceful" 
Config.TextMenuEmotesDancesLabel10			  = "Old"      
Config.TextMenuEmotesDancesLabel11			  = "Wild#A"     
Config.TextMenuEmotesDancesLabel12			  = "Wild#B"    

Config.emotesdancescommands01			  = "awkward"                         -- TriggerEvent("sirevlc_emotes_trigger", "emotesdancescommands01") end)
Config.emotesdancescommands02			  = "carefreea"                       -- TriggerEvent("sirevlc_emotes_trigger", "emotesdancescommands02") end)
Config.emotesdancescommands03			  = "carefreeb"                       -- TriggerEvent("sirevlc_emotes_trigger", "emotesdancescommands03") end)
Config.emotesdancescommands04			  = "confidenta"                      -- TriggerEvent("sirevlc_emotes_trigger", "emotesdancescommands04") end)
Config.emotesdancescommands05			  = "confidentb"                      -- TriggerEvent("sirevlc_emotes_trigger", "emotesdancescommands05") end)
Config.emotesdancescommands06			  = "drunka"                          -- TriggerEvent("sirevlc_emotes_trigger", "emotesdancescommands06") end)
Config.emotesdancescommands07			  = "drunkb"                          -- TriggerEvent("sirevlc_emotes_trigger", "emotesdancescommands07") end)
Config.emotesdancescommands08			  = "formal"                          -- TriggerEvent("sirevlc_emotes_trigger", "emotesdancescommands08") end)
Config.emotesdancescommands09			  = "graceful"                        -- TriggerEvent("sirevlc_emotes_trigger", "emotesdancescommands09") end)
Config.emotesdancescommands10			  = "old"                             -- TriggerEvent("sirevlc_emotes_trigger", "emotesdancescommands10") end)
Config.emotesdancescommands11			  = "wilda"                           -- TriggerEvent("sirevlc_emotes_trigger", "emotesdancescommands11") end)
Config.emotesdancescommands12			  = "wildb"                           -- TriggerEvent("sirevlc_emotes_trigger", "emotesdancescommands12") end)
     
Config.TextMenuEmotesDancesDescriptionLabel01 = "Use that dance emote"
Config.TextMenuEmotesDancesDescriptionLabel02 = "Use that dance emote"
Config.TextMenuEmotesDancesDescriptionLabel03 = "Use that dance emote"
Config.TextMenuEmotesDancesDescriptionLabel04 = "Use that dance emote"
Config.TextMenuEmotesDancesDescriptionLabel05 = "Use that dance emote"
Config.TextMenuEmotesDancesDescriptionLabel06 = "Use that dance emote"
Config.TextMenuEmotesDancesDescriptionLabel07 = "Use that dance emote"
Config.TextMenuEmotesDancesDescriptionLabel08 = "Use that dance emote"
Config.TextMenuEmotesDancesDescriptionLabel09 = "Use that dance emote"
Config.TextMenuEmotesDancesDescriptionLabel10 = "Use that dance emote"
Config.TextMenuEmotesDancesDescriptionLabel11 = "Use that dance emote"
Config.TextMenuEmotesDancesDescriptionLabel12 = "Use that dance emote"
  
---------------------------- 
-- TWIRL GUNS EMOTES MENU
---------------------------- 
Config.TextMenuEmotesTwirlGunLabel01 			= "Reverse spin"     
Config.TextMenuEmotesTwirlGunLabel02 			= "Spin up"         
Config.TextMenuEmotesTwirlGunLabel03 			= "Reverse spin up"  
Config.TextMenuEmotesTwirlGunLabel04 			= "Alternating flips"
Config.TextMenuEmotesTwirlGunLabel05 			= "Shoulder toss"    
Config.TextMenuEmotesTwirlGunLabel06 			= "Figure eight toss"

Config.emotestwirlguncommands01 				= "reversespin"                  -- TriggerEvent("sirevlc_emotes_trigger", "emotestwirlguncommands01") end)
Config.emotestwirlguncommands02 				= "spinup"                       -- TriggerEvent("sirevlc_emotes_trigger", "emotestwirlguncommands02") end)
Config.emotestwirlguncommands03 				= "reversespinup"                -- TriggerEvent("sirevlc_emotes_trigger", "emotestwirlguncommands03") end)
Config.emotestwirlguncommands04 				= "altflips"                     -- TriggerEvent("sirevlc_emotes_trigger", "emotestwirlguncommands04") end)
Config.emotestwirlguncommands05 				= "shouldertoss"                 -- TriggerEvent("sirevlc_emotes_trigger", "emotestwirlguncommands05") end)
Config.emotestwirlguncommands06 				= "figeighttoss"                 -- TriggerEvent("sirevlc_emotes_trigger", "emotestwirlguncommands06") end)
      
Config.TextMenuEmotesTwirlGunDescriptionLabel01 = "Reverse spin"     
Config.TextMenuEmotesTwirlGunDescriptionLabel02 = "Spin up"         
Config.TextMenuEmotesTwirlGunDescriptionLabel03 = "Reverse spin up"  
Config.TextMenuEmotesTwirlGunDescriptionLabel04 = "Alternating flips"
Config.TextMenuEmotesTwirlGunDescriptionLabel05 = "Shoulder toss"    
Config.TextMenuEmotesTwirlGunDescriptionLabel06 = "Figure eight toss"
 
 	
Config.Texts = {
hours = ":",
temperatures = "°",
}