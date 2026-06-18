Config = {}


-- VERSION 1.92 / 18.01.25
 
--------------------------------------------------
			--FRAMEWORK SELECTION--
-------------------------------------------------- 
--Turn your framework to true and all the others to false

Config.REDEMRP2          				 = false
Config.REDEMRP2023REBOOT 				 = false
Config.VORP              				 = true
Config.RSG               				 = false

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

-------------------------------------------
               --MENU --
-------------------------------------------
Config.MenuActive 		 		= true  
Config.OpenMenuKey 		 		= 0x1CE6D9EB -- [2] by default 
Config.BagStashKey 		 		= 0xA1FDE2A6 -- [6] by default , set it to 0 if you want to disable it

Config.Debug 				    = false  -- This will print debug prints in the user's console
Config.CommandIsActive          = true   -- If true this will enable the F8 command openbag to open your bag stash
Config.RemoveBackPackOnDeath    = true   -- If set to true it will remove the backpack and lantern when the player dies
Config.OnlyBackpacksMenu 	    = false  -- If you want to have only Backpacks Menu turn this to true and Config.MenuActive = false and Config.OnlyLanternsMenu = false
Config.OnlyLanternsMenu  	    = false  -- If you want to have only Lanterns Menu turn this to true and Config.MenuActive = false and Config.OnlyBackpacksMenu = false

--If you want to trigger the menu via another method than "is key pressed" call the event like this :
--TriggerEvent("sirevlc_backpacks_and_lanterns_menu")

--If you want to call the equipping of backpacks event use these lines :
--TriggerEvent("sirevlc_backpack01")
--TriggerEvent("sirevlc_backpack02")
--TriggerEvent("sirevlc_backpack03")
--TriggerEvent("sirevlc_backpack04")
--TriggerEvent("sirevlc_backpack05")
--TriggerEvent("sirevlc_backpack06")
--TriggerEvent("sirevlc_backpack07")
--TriggerEvent("sirevlc_backpack08")
--TriggerEvent("sirevlc_backpack09")
--TriggerEvent("sirevlc_backpack10")
--TriggerEvent("sirevlc_backpack11")
--TriggerEvent("sirevlc_backpack12")
 

--TriggerEvent("sirevlc_removebackpack")

--If you want to call the equipping of lanterns event use these lines :
--TriggerEvent("sirevlc_lanternback")
--TriggerEvent("sirevlc_lanternfront")
--TriggerEvent("sirevlc_lanternhand")
--TriggerEvent("sirevlc_lanternrifle")
--TriggerEvent("sirevlc_removelantern")

--This event will open the bag stash
--TriggerEvent("sirevlc_backpacks_open_stash")

-- If you want to check if the player is using a backpack or lantern (will return true) : 
-- exports.sirevlc_backpacksandlanterns.check_backpack()
-- exports.sirevlc_backpacksandlanterns.check_lantern()
 
 
 
-- *********** /!\ DONT FORGET TO CHANGE THE STASHLIMIT FOR RSG ! /!\ ******************* --
 
Config.Backpacks = {
 
      [1] = { 
	  ["backpack"]   = "backpack1", -- Don't change this one
	  ["stashlimit"] = 30, 			-- FOR VORP AND RSG ONLY / IF ON RSG IT SHOULD BE IN THOUSANDS 
	  ["stashslots"] = 30, 			-- FOR RSG ONLY 
	  },
	  
      [2] = { 
	  ["backpack"]   = "backpack2", -- Don't change this one
	  ["stashlimit"] = 100, 			-- FOR VORP AND RSG ONLY / IF ON RSG IT SHOULD BE IN THOUSANDS 
	  ["stashslots"] = 100, 			-- FOR RSG ONLY 
	  },	  

      [3] = { 
	  ["backpack"]   = "backpack3", -- Don't change this one
	  ["stashlimit"] = 200, 			-- FOR VORP AND RSG ONLY / IF ON RSG IT SHOULD BE IN THOUSANDS 
	  ["stashslots"] = 200, 			-- FOR RSG ONLY 
	  },
	  
      [4] = { 
	  ["backpack"]   = "backpack4", -- Don't change this one
	  ["stashlimit"] = 30, 			-- FOR VORP AND RSG ONLY / IF ON RSG IT SHOULD BE IN THOUSANDS 
	  ["stashslots"] = 30, 			-- FOR RSG ONLY 
	  },
	  
      [5] = { 
	  ["backpack"]   = "backpack5", -- Don't change this one
	  ["stashlimit"] = 30, 			-- FOR VORP AND RSG ONLY / IF ON RSG IT SHOULD BE IN THOUSANDS 
	  ["stashslots"] = 30, 			-- FOR RSG ONLY 
	  },
	  
      [6] = { 
	  ["backpack"]   = "backpack6", -- Don't change this one
	  ["stashlimit"] = 30, 			-- FOR VORP AND RSG ONLY / IF ON RSG IT SHOULD BE IN THOUSANDS 
	  ["stashslots"] = 30, 			-- FOR RSG ONLY 
	  },
	  
      [7] = { 
	  ["backpack"]   = "backpack7", -- Don't change this one
	  ["stashlimit"] = 30, 			-- FOR VORP AND RSG ONLY / IF ON RSG IT SHOULD BE IN THOUSANDS 
	  ["stashslots"] = 30, 			-- FOR RSG ONLY 
	  },
	  
      [8] = { 
	  ["backpack"]   = "backpack8", -- Don't change this one
	  ["stashlimit"] = 30, 			-- FOR VORP AND RSG ONLY / IF ON RSG IT SHOULD BE IN THOUSANDS 
	  ["stashslots"] = 30, 			-- FOR RSG ONLY 
	  },
	  
      [9] = { 
	  ["backpack"]   = "backpack9", -- Don't change this one
	  ["stashlimit"] = 30, 			-- FOR VORP AND RSG ONLY / IF ON RSG IT SHOULD BE IN THOUSANDS 
	  ["stashslots"] = 30, 			-- FOR RSG ONLY 
	  },
	  
      [10] = { 
	  ["backpack"]   = "backpack10", -- Don't change this one
	  ["stashlimit"] = 30, 			-- FOR VORP AND RSG ONLY / IF ON RSG IT SHOULD BE IN THOUSANDS 
	  ["stashslots"] = 30, 			-- FOR RSG ONLY 
	  },
	  
      [11] = { 
	  ["backpack"]   = "backpack11", -- Don't change this one
	  ["stashlimit"] = 30, 			-- FOR VORP AND RSG ONLY / IF ON RSG IT SHOULD BE IN THOUSANDS 
	  ["stashslots"] = 30, 			-- FOR RSG ONLY 
	  },
	  
	  
      [12] = { 
	  ["backpack"]   = "backpack12", -- Don't change this one
	  ["stashlimit"] = 30, 			-- FOR VORP AND RSG ONLY / IF ON RSG IT SHOULD BE IN THOUSANDS 
	  ["stashslots"] = 30, 			-- FOR RSG ONLY 
	  },
	  
}


-------------------------------------------
        -- TEXTS TRANSLATIONS --
-------------------------------------------
Config.TextMenuTitle   = "Backpacks and Lants."
Config.TextMenuLabel01 = 'Remove Backpack'      
Config.TextMenuLabel02 = 'Remove Lantern'       
Config.TextMenuLabel03 = 'The Miller Backpack'  
Config.TextMenuLabel04 = 'The Townfolk Backpack'
Config.TextMenuLabel05 = 'The Trapper Backpack' 
Config.TextMenuLabel06 = 'Cripps and Co. Bag'   
Config.TextMenuLabel07 = 'Rains Fall Basket'    
Config.TextMenuLabel08 = 'Small Olive Bedroll'  
Config.TextMenuLabel09 = 'The Explorer Backpack'
Config.TextMenuLabel10 = 'Small Grey Bedroll'   
Config.TextMenuLabel11 = 'Small Beige Bedroll'  
Config.TextMenuLabel12 = 'Wapiti Basket'        
Config.TextMenuLabel13 = 'The Ambarino Bag'     
Config.TextMenuLabel14 = 'Native Quiver'        
Config.TextMenuLabel15 = 'Lantern Back'         
Config.TextMenuLabel16 = 'Lantern Front'        
Config.TextMenuLabel17 = 'Lantern Hand'         
Config.TextMenuLabel18 = 'Lantern Rifle'

Config.TextMenuDescriptionLabel01 = 'Remove your backpack'                    
Config.TextMenuDescriptionLabel02 = 'Remove your lantern'                    
Config.TextMenuDescriptionLabel03 = 'Choose your backpack and lantern'        
Config.TextMenuDescriptionLabel04 = 'Choose your backpack and lantern'        
Config.TextMenuDescriptionLabel05 = 'Choose your backpack and lantern'        
Config.TextMenuDescriptionLabel06 = 'Choose your backpack and lantern'        
Config.TextMenuDescriptionLabel07 = 'Choose your backpack and lantern'        
Config.TextMenuDescriptionLabel08 = 'Choose your backpack and lantern'        
Config.TextMenuDescriptionLabel09 = 'Choose your backpack and lantern'        
Config.TextMenuDescriptionLabel10 = 'Choose your backpack and lantern'        
Config.TextMenuDescriptionLabel11 = 'Choose your backpack and lantern'        
Config.TextMenuDescriptionLabel12 = 'Choose your backpack and lantern'        
Config.TextMenuDescriptionLabel13 = 'Choose your backpack and lantern'        
Config.TextMenuDescriptionLabel14 = 'Choose your backpack and lantern'        
Config.TextMenuDescriptionLabel15 = 'fix your lantern on your belt back side' 
Config.TextMenuDescriptionLabel16 = 'fix your lantern on your belt front side'
Config.TextMenuDescriptionLabel17 = 'hold your lantern freely with your hand' 
Config.TextMenuDescriptionLabel18 = 'hold your lantern on your rifle'         



Config.NotifMain      		= "Backpacks"
Config.NotifLeaveMenu 		= "You must leave the menu first"
Config.NotifEquipBackpack   = "You must equip a backpack first"




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