Config = {}

-- Version 1.3 - 27.04.26

--------------------------------------------------
			--FRAMEWORK SELECTION--
-------------------------------------------------- 
--Turn your framework to true and all the others to false

Config.REDEMRP2          				 = false
Config.REDEMRP2023REBOOT 				 = false
Config.VORP              				 = false
Config.RSG   						     = true
 
-- DEBUG
Config.Debug = false

-- PRICE  
Config.Price = 00.0

-- PROMPTS KEYS    
Config.TicketToNewHanoverPrompt = 0x9959A6F0 -- C
Config.TicketToGuarmaPrompt     = 0x7F8D09B8 -- V
 
Config.TicketSellerPed 			= true       -- Spawn Ticket sellers peds
Config.Cutscene        			= true       -- Turn to false if for some reason you can't acess the cutscene area
 
-- TRANSLATIONS 
Config.TextGuarma              = "Ship"
Config.TextTravel              = "Travel"
Config.TextNoMoney             = "You dont have enough money"
Config.BoatTicket              = "Boat Ticket"
Config.GuarmaLoadingScreen     = "Guarma"
Config.NewHanoverLoadingScreen = "New Hanover"
Config.BoatSailing             = "Your boat is sailing"
Config.text1                   = "Guarma Ship"
Config.text2                   = "New Hanover Ship"
Config.WelcomeToGuarma         = "Welcome to Guarma"
Config.WelcomeToNewHanover     = "Welcome to New Hanover"

Config.BuyTicketToGuarma       = "Buy Ticket to Guarma"
Config.BuyTicketToNewHanover   = "Buy Ticket to New Hanover"


-- COORDS 
Config.Blip_GUARMA_coords 	   = vector3(1276.04833984375, -6855.23046875,    43.31963348388672)   	    -- MAP BLIP COORDS 
Config.Blip_US_coords     	   = vector3(2781.91650390625, -1522.87158203125, 45.8206672668457)	        -- MAP BLIP COORDS 
 
Config.NPC_GUARMA_coords 	   = vector4(1276.04833984375, -6855.23046875, 43.31963348388672, 0.0)   	-- NPC COORDS 
Config.NPC_US_coords     	   = vector4(2781.91650390625, -1522.87158203125, 45.8206672668457, 31.38)  -- NPC COORDS 
 
Config.Prompt_GUARMA_coords    = vector3(1274.8712158203125, -6854.6298828125, 43.31931686401367)       -- PROMPT COORDS 
Config.Prompt_US_coords        = vector3(2781.6806640625, -1522.2318115234375, 45.82070541381836)       -- PROMPT COORDS 


Config.GuarmaTPCoords          = vector3(1267.03, -6852.97, 43.31)
Config.UsTPCoords              = vector3(2669.11279296875, -1546.360107421875, 45.96977615356445)