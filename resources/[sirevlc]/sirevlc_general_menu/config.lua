Config = {}

 
-- VERSION 4.05 - 16.02.26

-------------------------------------------
               -- MENU --
-------------------------------------------
Config.MenuActive        = false  
Config.OpenMenuKey       = 0x1CE6D9EB -- [2] by default 
Config.RoleRestriction   = false
 
--REMOVE ANY OPTIONS BY ADDING -- IN FRONT OF THE LINE LIKE THIS :
--{label = "Gameplay", value = "action02",  desc = "Gameplay", image='items/generic_season_skill_gold.png'},

--------------
--MAIN MENU--
--------------

Config.GeneralMenuTitle = "<p><span style='color:gold;'>Main Menu</span>"
Config.GeneralMenu = {
	{label = "Outfits Packs"               , value = "action01",  desc = "Outfits Packs", image='items/clothing_generic_outfit.png'},
	{label = "Gameplay"                    , value = "action02",  desc = "Gameplay",      image='items/generic_season_skill.png'},	
} 
 
------------
--OUTFITS--
------------

Config.OutfitsMenuTitle   = "<p><span style='color:gold;'>Outfits</span>"
Config.OutfitsMenu = {
		{label = "Natives"           , value = "action01",  desc = "Outfits Packs",            image = 'items/native_men_hair.png'},
		{label = "Dresses"           , value = "action02",  desc = "Dresses",                  image = 'items/clothing_generic_dress.png'},
		{label = "Ponchos"           , value = "action03",  desc = "Ponchos",                  image = 'items/clothing_generic_poncho.png'},
		{label = "Police"            , value = "action04",  desc = "Police",                   image = 'items/clothing_hat_000_police.png'},
		{label = "US Army"           , value = "action05",  desc = "US Army",                  image = 'items/clothing_item_sp_collectable_hat_mr1_045.png'},
		{label = "Guarma Army"       , value = "action06",  desc = "Guarma Army",              image = 'items/clothing_item_sp_collectable_hat_mr1_045.png'},
		{label = "Mexicans"          , value = "action07",  desc = "Mexican Outfits",          image = 'items/clothing_item_sp_collectable_hat_mr1_105.png'},
		{label = "Gentlemen"         , value = "action08",  desc = "Gentlemen Outfits",        image = 'items/clothing_hl_player_hat_006_1.png'},
		{label = "Maids and Doctors" , value = "action09",  desc = "Maids and Doctors",        image = 'items/sirevlc_maids_and_doctors.png'},
		{label = "Miners"            , value = "action10",  desc = "Miners",                   image = 'items/clothing_sp_dead_miner_hat_000_1.png'},
		{label = "Mob"            	 , value = "action11",  desc = "Mob",                      image = 'items/clothing_hl_player_hat_006_1.png'},
		{label = "Town - Females"    , value = "action12",  desc = "Town - Females",           image = 'items/clothing_generic_outfit.png'},
		{label = "Town - Males"      , value = "action13",  desc = "Town - Males",             image = 'items/clothing_generic_outfit.png'},
}  
------------------
  -- GAMEPLAY --
------------------

Config.GameplayMenuTitle   = "<p><span style='color:gold;'>Gameplay</span>"
Config.GameplayMenu = {
		{label = "Sleep"                    , value = "action01",  desc = "Outfits Packs",          image ='items/moon.png'},
		{label = "Horses"                   , value = "action02",  desc = "Outfits Packs",          image ='items/horse_spawn.png'},
		{label = "Photo Mode"               , value = "action03",  desc = "Outfits Packs",          image ='items/weapon_kit_camera_advanced.png'},		
		{label = "Naked Bodies"             , value = "action04",  desc = "Outfits Packs",          image ='items/emote_reaction_shrug_1.png'},
		{label = "RP Overhaul"              , value = "action05",  desc = "RP Overhaul",            image ='items/generic_season_skill.png'},
		{label = "Backpacks and lanterns"   , value = "action06",  desc = "Backpacks and lanterns", image ='items/lanternonhand.png'},	
		{label = "Crafting and Cooking"     , value = "action07",  desc = "Crafting and Cooking",   image ='items/upgrade_upg_mortar_pestle.png'},	
}  
 
 
-----------------
-- COMMANDS -- 
-----------------
------------
--OUTFITS--
------------
Config.menudoctor_enabled  	  = true -- this will enable the command
Config.menugentlemen_enabled  = true  
Config.menumexican_enabled    = true  
Config.menunatives_enabled    = true  
Config.menudresses_enabled    = true  
Config.menuponchos_enabled    = true  
Config.menupolice_enabled     = true  
Config.menuarmyus_enabled     = true  
Config.menuarmyguarma_enabled = true  
Config.menuminers_enabled     = true  
Config.menumob_enabled        = true  
Config.menutownfemale_enabled = true  
Config.menutownmale_enabled   = true  

Config.menusleep_enabled      = true
Config.menurphorses_enabled   = true
Config.menuphotomode_enabled  = true
Config.menunaked_enabled      = true
Config.menugameplay_enabled   = true
Config.menubackpacks_enabled  = true


Config.menudoctor     = "menudoctor"     -- sirevlc_maids_and_doctors
Config.menugentlemen  = "menugentlemen"  -- sirevlc_gentlemen_outfits
Config.menumexican    = "menumexican"    -- sirevlc_mexican_gang
Config.menunatives    = "menunatives"    -- sirevlc_eagle_flies natives outfits pack
Config.menudresses    = "menudresses"    -- sirevlc_dresses_pack
Config.menuponchos    = "menuponchos"    -- sirevlc_rio_bravo ponchos
Config.menupolice     = "menupolice"     -- sirevlc_law_and_order
Config.menuarmyus     = "menuarmyus"     -- sirevlc_us_army_menu
Config.menuarmyguarma = "menuarmyguarma" -- sirevlc_guarma_army_menu
Config.menuminers     = "menuminers"     -- sirevlc_miners
Config.menumob        = "menumob"        -- sirevlc_mob_outfits
Config.menutownfemale = "menutownfemale" -- sirevlc_mega_outfit_pack_females
Config.menutownmale   = "menutownmale"   -- sirevlc_mega_outfit_pack_males 
-------------
--GAMEPLAY--
-------------
Config.menusleep      = "menusleep"     -- sirevlc_sleep_system
Config.menurphorses   = "menurphorses"  -- sirevlc_horses_interactions
Config.menuphotomode  = "menuphotomode" -- sirevlc_photomode
Config.menunaked      = "menunaked"     -- sirevlc_birthday_suits
Config.menugameplay   = "menugameplay"  -- sirevlc_rp_overhaul
Config.menubackpacks  = "menubackpacks" -- sirevlc_backpacks_and_lanterns

---------------------
--MAIN MENUS EVENTS--
---------------------
--------------
--MAIN MENU--
--------------

--TriggerEvent("sirevlc_general_menu") 	
--TriggerEvent("sirevlc_general_menu","outfits") 	
--TriggerEvent("sirevlc_general_menu","gameplay") 	

------------
--OUTFITS--
------------

--TriggerEvent("sirevlc_eagle_flies", "mainmenu") 		   
--TriggerEvent("sirevlc_dress_pack_01","mainmenu")
--TriggerEvent("sirevlc_rio_bravo","mainmenu")		
--TriggerEvent("sirevlc_law_and_order_menu")	
--TriggerEvent("sirevlc_mexican_outfits","mainmenu")
--TriggerEvent("sirevlc_gentlemen_outfits","mainmenu")
--TriggerEvent("sirevlc_us_army","mainmenu")
--TriggerEvent("sirevlc_guarma_army","mainmenu")
--TriggerEvent("sirevlc_maids_and_doctors","mainmenu")
--TriggerEvent("sirevlc_miners","mainmenu")
--TriggerEvent("sirevlc_mob_outfits","mainmenu")

------------
--GAMEPLAY--
------------

--TriggerEvent("sirevlc_open_sleep_menu") 		   
--TriggerEvent("sirevlc_action_horse_menu")
--TriggerEvent("sirevlc_photomodemenu")		
--TriggerEvent("sirevlc_birthday_suit_menu")	
--TriggerEvent("sirevlc_rp_overhaul_menu","mainmenu")
--TriggerEvent("sirevlc_backpacks_and_lanterns_menu")	
-- TriggerEvent("sirevlc_cooking_and_crafting_open_menu")

-----------------------------------------------------------------------------------------------
									--KEYBINDS LIST--
-----------------------------------------------------------------------------------------------

--   -- Letters
--   ["A"] = 0x7065027D,
--   ["B"] = 0x4CC0E2FE,
--   ["C"] = 0x9959A6F0,
--   ["D"] = 0xB4E465B4,
--   ["E"] = 0xCEFD9220,
--   ["F"] = 0xB2F377E8,
--   ["G"] = 0x760A9C6F,
--   ["H"] = 0x24978A28,
--   ["I"] = 0xC1989F95,
--   ["J"] = 0xF3830D8E,
--   -- Missing K
--   ["L"] = 0x80F28E95,
--   ["M"] = 0xE31C6A41,
--   ["N"] = 0x4BC9DABB,
--   ["O"] = 0xF1301666,
--   ["P"] = 0xD82E0BD2,
--   ["Q"] = 0xDE794E3E,
--   ["R"] = 0xE30CD707,
--   ["S"] = 0xD27782E3,
--   -- Missing T
--   ["U"] = 0xD8F73058,
--   ["V"] = 0x7F8D09B8,
--   ["W"] = 0x8FD015D8,
--   ["X"] = 0x8CC9CD42,
--   -- Missing Y
--   ["Z"] = 0x26E9DC00,
--   -- Symbol Keys
--   ["RIGHTBRACKET"] = 0xA5BDCD3C,
--   ["LEFTBRACKET"] = 0x430593AA,
--   -- Mouse buttons
--   ["MOUSE1"] = 0x07CE1E61,
--   ["MOUSE2"] = 0xF84FA74F,
--   ["MOUSE3"] = 0xCEE12B50,
--   ["MWUP"] = 0x3076E97C,
--   -- Modifier Keys
--   ["CTRL"] = 0xDB096B85,
--   ["TAB"] = 0xB238FE0B,
--   ["SHIFT"] = 0x8FFC75D6,
--   ["SPACEBAR"] = 0xD9D0E1C0,
--   ["ENTER"] = 0xC7B5340A,
--   ["BACKSPACE"] = 0x156F7119,
--   ["LALT"] = 0x8AAA0AD4,
--   ["DEL"] = 0x4AF4D473,
--   ["PGUP"] = 0x446258B6,
--   ["PGDN"] = 0x3C3DD371,
--   -- Function Keys
--   ["F1"] = 0xA8E3F467,
--   ["F4"] = 0x1F6D95E5,
--   ["F6"] = 0x3C0A40F2,
--   -- Number Keys
--   ["1"] = 0xE6F612E4,
--   ["2"] = 0x1CE6D9EB,
--   ["3"] = 0x4F49CC4C,
--   ["4"] = 0x8F9F9E58,
--   ["5"] = 0xAB62E997,
--   ["6"] = 0xA1FDE2A6,
--   ["7"] = 0xB03A913B,
--   ["8"] = 0x42385422,
--   -- Arrow Keys
--   ["DOWN"] = 0x05CA7C52,
--   ["UP"] = 0x6319DB71,
--   ["LEFT"] = 0xA65EBAB4,
--   ["RIGHT"] = 0xDEB34313