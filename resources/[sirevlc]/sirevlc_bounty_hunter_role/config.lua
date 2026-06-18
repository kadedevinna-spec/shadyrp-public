Config = {}

-- Version 1.80 - 04.01.26

--------------------------------------------------
			--FRAMEWORK SELECTION--
-------------------------------------------------- 
--Turn your framework to true and all the others to false
Config.REDEMRP2          				 = false
Config.REDEMRP2023REBOOT 				 = false
Config.VORP              				 = false
Config.RSG               				 = true

Config.CooldownEnabled                   = false       -- Enable / Disable the cooldown ( if that cooldown is effective the prompts to start missions won't show up until the cooldown is ended)   
Config.CooldownTimer                     = 30           -- In minutes / 1 min minimum

Config.CutscenesEnabled              	 = true        -- true or false depending if you want cutscenes at the start and end of mission to play | Set this to false if you can't access the police station
Config.IsBountyVisibleByOtherPlayers 	 = true 	   -- Is bounty target visible by the other players
Config.EnableNotifications               = true 
 
Config.EnableEagleEye                    = false        -- This will enable or disable the effects 
Config.EnableDeadEye                     = false        -- This will enable or disable the effects 

Config.StartMissionPromptDistance        = 1.25         -- Starting mission prompt distance 

Config.Debug 							 = false       -- THIS WILL SHOW DEBUG PRINTS IN THE PLAYER'S CONSOLE

------------------------------------
		-- ROLES RESTRICTION --
------------------------------------
Config.RoleRestriction               	 = false
Config.Roles = { -- List of roles allowed to do bounty hunting missions  
"bountyhunter",
"trapper",
"horsetrainer",
}
 
------------------------------------
	   -- DISCORD WEBHOOKS --
------------------------------------

Config.WebhookUrl                       = ""
Config.WebhookMainTitle                 = "Bounty Hunting Missions"
									    
Config.UseWebHookStartMission           = false 
Config.WebHookStartMissionText          = "started a bounty hunting mission" 

Config.UseWebHookEndMission             = false 
Config.WebHookEndMissionText            = "completed a bounty hunting mission for" 
Config.WebHookEndMissionFailedText      = "failed a bounty hunting mission" 
  
-- Exports : 
-- exports.sirevlc_bounty_hunter_role.GetBountyHunterMissionState()  
 
----------------------------
		--ROLE XP--
----------------------------

--THIS IS WHERE YOU SET UP THE REWARDS AND XP FOR THE BUILT-IN ROLE XP SYSTEM 
Config.RoleXpenabled         = true	-- If set to true you will have the role xp reward system enabled and it will save your progress in the database in the sirevlc_bounty_hunter_role table
Config.MaxXp  		         = 99999 --(Max Role level is 100)
Config.NewLevelTitle         = "Bounty Hunter"
Config.NewLevelText          = "You are now level"
Config.NewXpText             = "XP +"
Config.NewLevelAdditemsText  = "Rewards:"
Config.CurrentLevelText      = "LEVEL: "
 
  
-- THE GOLD REWARD IS ONLY EFFECTIVE ON VORP FRAMEWORK 
 
Config.RoleXp = {
[1]    = {requiredxp = 100  ,  rewarditem1QT = 1, rewarditem1 = "", item1name = "Hay", rewarditem2QT = 1, rewarditem2 = "", item2name = "Carrot", rewarditem3QT = 1, rewarditem3 = "", item3name = "Horse Reviver", rewardmoney = 300.0, rewardgold = 1.0},
[2]    = {requiredxp = 200  ,  rewarditem1QT = 1, rewarditem1 = "", item1name = "Hay", rewarditem2QT = 1, rewarditem2 = "", item2name = "Carrot", rewarditem3QT = 1, rewarditem3 = "", item3name = "Horse Reviver", rewardmoney = 25.0,  rewardgold = 1.0},
[3]    = {requiredxp = 300  ,  rewarditem1QT = 1, rewarditem1 = "", item1name = "", rewarditem2QT = 1, rewarditem2 = "", item2name = "", rewarditem3QT = 1, rewarditem3 = "", item3name = "", rewardmoney = 300, rewardgold = 1},
[4]    = {requiredxp = 400  ,  rewarditem1QT = 1, rewarditem1 = "", item1name = "", rewarditem2QT = 1, rewarditem2 = "", item2name = "", rewarditem3QT = 1, rewarditem3 = "", item3name = "", rewardmoney = 300, rewardgold = 1},
[5]    = {requiredxp = 500  ,  rewarditem1QT = 1, rewarditem1 = "", item1name = "", rewarditem2QT = 1, rewarditem2 = "", item2name = "", rewarditem3QT = 1, rewarditem3 = "", item3name = "", rewardmoney = 300, rewardgold = 1},
[6]    = {requiredxp = 600  ,  rewarditem1QT = 1, rewarditem1 = "", item1name = "", rewarditem2QT = 1, rewarditem2 = "", item2name = "", rewarditem3QT = 1, rewarditem3 = "", item3name = "", rewardmoney = 300, rewardgold = 1},
[7]    = {requiredxp = 700  ,  rewarditem1QT = 1, rewarditem1 = "", item1name = "", rewarditem2QT = 1, rewarditem2 = "", item2name = "", rewarditem3QT = 1, rewarditem3 = "", item3name = "", rewardmoney = 300, rewardgold = 1},
[8]    = {requiredxp = 800  ,  rewarditem1QT = 1, rewarditem1 = "", item1name = "", rewarditem2QT = 1, rewarditem2 = "", item2name = "", rewarditem3QT = 1, rewarditem3 = "", item3name = "", rewardmoney = 300, rewardgold = 1},
[9]    = {requiredxp = 900  ,  rewarditem1QT = 1, rewarditem1 = "", item1name = "", rewarditem2QT = 1, rewarditem2 = "", item2name = "", rewarditem3QT = 1, rewarditem3 = "", item3name = "", rewardmoney = 300, rewardgold = 1},
[10]   = {requiredxp = 1000 ,  rewarditem1QT = 1, rewarditem1 = "", item1name = "", rewarditem2QT = 1, rewarditem2 = "", item2name = "", rewarditem3QT = 1, rewarditem3 = "", item3name = "", rewardmoney = 300, rewardgold = 1},
[11]   = {requiredxp = 1100 ,  rewarditem1QT = 1, rewarditem1 = "", item1name = "", rewarditem2QT = 1, rewarditem2 = "", item2name = "", rewarditem3QT = 1, rewarditem3 = "", item3name = "", rewardmoney = 300, rewardgold = 1},
[12]   = {requiredxp = 1200 ,  rewarditem1QT = 1, rewarditem1 = "", item1name = "", rewarditem2QT = 1, rewarditem2 = "", item2name = "", rewarditem3QT = 1, rewarditem3 = "", item3name = "", rewardmoney = 300, rewardgold = 1},
[13]   = {requiredxp = 1300 ,  rewarditem1QT = 1, rewarditem1 = "", item1name = "", rewarditem2QT = 1, rewarditem2 = "", item2name = "", rewarditem3QT = 1, rewarditem3 = "", item3name = "", rewardmoney = 300, rewardgold = 1},
[14]   = {requiredxp = 1400 ,  rewarditem1QT = 1, rewarditem1 = "", item1name = "", rewarditem2QT = 1, rewarditem2 = "", item2name = "", rewarditem3QT = 1, rewarditem3 = "", item3name = "", rewardmoney = 300, rewardgold = 1},
[15]   = {requiredxp = 1500 ,  rewarditem1QT = 1, rewarditem1 = "", item1name = "", rewarditem2QT = 1, rewarditem2 = "", item2name = "", rewarditem3QT = 1, rewarditem3 = "", item3name = "", rewardmoney = 300, rewardgold = 1},
[16]   = {requiredxp = 1600 ,  rewarditem1QT = 1, rewarditem1 = "", item1name = "", rewarditem2QT = 1, rewarditem2 = "", item2name = "", rewarditem3QT = 1, rewarditem3 = "", item3name = "", rewardmoney = 300, rewardgold = 1},
[17]   = {requiredxp = 1700 ,  rewarditem1QT = 1, rewarditem1 = "", item1name = "", rewarditem2QT = 1, rewarditem2 = "", item2name = "", rewarditem3QT = 1, rewarditem3 = "", item3name = "", rewardmoney = 300, rewardgold = 1},
[18]   = {requiredxp = 1800 ,  rewarditem1QT = 1, rewarditem1 = "", item1name = "", rewarditem2QT = 1, rewarditem2 = "", item2name = "", rewarditem3QT = 1, rewarditem3 = "", item3name = "", rewardmoney = 300, rewardgold = 1},
[19]   = {requiredxp = 1900 ,  rewarditem1QT = 1, rewarditem1 = "", item1name = "", rewarditem2QT = 1, rewarditem2 = "", item2name = "", rewarditem3QT = 1, rewarditem3 = "", item3name = "", rewardmoney = 300, rewardgold = 1},
[20]   = {requiredxp = 2000 ,  rewarditem1QT = 1, rewarditem1 = "", item1name = "", rewarditem2QT = 1, rewarditem2 = "", item2name = "", rewarditem3QT = 1, rewarditem3 = "", item3name = "", rewardmoney = 300, rewardgold = 1},
[21]   = {requiredxp = 2100 ,  rewarditem1QT = 1, rewarditem1 = "", item1name = "", rewarditem2QT = 1, rewarditem2 = "", item2name = "", rewarditem3QT = 1, rewarditem3 = "", item3name = "", rewardmoney = 300, rewardgold = 1},
[22]   = {requiredxp = 2200 ,  rewarditem1QT = 1, rewarditem1 = "", item1name = "", rewarditem2QT = 1, rewarditem2 = "", item2name = "", rewarditem3QT = 1, rewarditem3 = "", item3name = "", rewardmoney = 300, rewardgold = 1},
[23]   = {requiredxp = 2300 ,  rewarditem1QT = 1, rewarditem1 = "", item1name = "", rewarditem2QT = 1, rewarditem2 = "", item2name = "", rewarditem3QT = 1, rewarditem3 = "", item3name = "", rewardmoney = 300, rewardgold = 1},
[24]   = {requiredxp = 2400 ,  rewarditem1QT = 1, rewarditem1 = "", item1name = "", rewarditem2QT = 1, rewarditem2 = "", item2name = "", rewarditem3QT = 1, rewarditem3 = "", item3name = "", rewardmoney = 300, rewardgold = 1},
[25]   = {requiredxp = 2500 ,  rewarditem1QT = 1, rewarditem1 = "", item1name = "", rewarditem2QT = 1, rewarditem2 = "", item2name = "", rewarditem3QT = 1, rewarditem3 = "", item3name = "", rewardmoney = 300, rewardgold = 1},
[26]   = {requiredxp = 2600 ,  rewarditem1QT = 1, rewarditem1 = "", item1name = "", rewarditem2QT = 1, rewarditem2 = "", item2name = "", rewarditem3QT = 1, rewarditem3 = "", item3name = "", rewardmoney = 300, rewardgold = 1},
[27]   = {requiredxp = 2700 ,  rewarditem1QT = 1, rewarditem1 = "", item1name = "", rewarditem2QT = 1, rewarditem2 = "", item2name = "", rewarditem3QT = 1, rewarditem3 = "", item3name = "", rewardmoney = 300, rewardgold = 1},
[28]   = {requiredxp = 2800 ,  rewarditem1QT = 1, rewarditem1 = "", item1name = "", rewarditem2QT = 1, rewarditem2 = "", item2name = "", rewarditem3QT = 1, rewarditem3 = "", item3name = "", rewardmoney = 300, rewardgold = 1},
[29]   = {requiredxp = 2900 ,  rewarditem1QT = 1, rewarditem1 = "", item1name = "", rewarditem2QT = 1, rewarditem2 = "", item2name = "", rewarditem3QT = 1, rewarditem3 = "", item3name = "", rewardmoney = 300, rewardgold = 1},
[30]   = {requiredxp = 3000 ,  rewarditem1QT = 1, rewarditem1 = "", item1name = "", rewarditem2QT = 1, rewarditem2 = "", item2name = "", rewarditem3QT = 1, rewarditem3 = "", item3name = "", rewardmoney = 300, rewardgold = 1},
[31]   = {requiredxp = 3100 ,  rewarditem1QT = 1, rewarditem1 = "", item1name = "", rewarditem2QT = 1, rewarditem2 = "", item2name = "", rewarditem3QT = 1, rewarditem3 = "", item3name = "", rewardmoney = 300, rewardgold = 1},
[32]   = {requiredxp = 3200 ,  rewarditem1QT = 1, rewarditem1 = "", item1name = "", rewarditem2QT = 1, rewarditem2 = "", item2name = "", rewarditem3QT = 1, rewarditem3 = "", item3name = "", rewardmoney = 300, rewardgold = 1},
[33]   = {requiredxp = 3300 ,  rewarditem1QT = 1, rewarditem1 = "", item1name = "", rewarditem2QT = 1, rewarditem2 = "", item2name = "", rewarditem3QT = 1, rewarditem3 = "", item3name = "", rewardmoney = 300, rewardgold = 1},
[34]   = {requiredxp = 3400 ,  rewarditem1QT = 1, rewarditem1 = "", item1name = "", rewarditem2QT = 1, rewarditem2 = "", item2name = "", rewarditem3QT = 1, rewarditem3 = "", item3name = "", rewardmoney = 300, rewardgold = 1},
[35]   = {requiredxp = 3500 ,  rewarditem1QT = 1, rewarditem1 = "", item1name = "", rewarditem2QT = 1, rewarditem2 = "", item2name = "", rewarditem3QT = 1, rewarditem3 = "", item3name = "", rewardmoney = 300, rewardgold = 1},
[36]   = {requiredxp = 3600 ,  rewarditem1QT = 1, rewarditem1 = "", item1name = "", rewarditem2QT = 1, rewarditem2 = "", item2name = "", rewarditem3QT = 1, rewarditem3 = "", item3name = "", rewardmoney = 300, rewardgold = 1},
[37]   = {requiredxp = 3700 ,  rewarditem1QT = 1, rewarditem1 = "", item1name = "", rewarditem2QT = 1, rewarditem2 = "", item2name = "", rewarditem3QT = 1, rewarditem3 = "", item3name = "", rewardmoney = 300, rewardgold = 1},
[38]   = {requiredxp = 3800 ,  rewarditem1QT = 1, rewarditem1 = "", item1name = "", rewarditem2QT = 1, rewarditem2 = "", item2name = "", rewarditem3QT = 1, rewarditem3 = "", item3name = "", rewardmoney = 300, rewardgold = 1},
[39]   = {requiredxp = 3900 ,  rewarditem1QT = 1, rewarditem1 = "", item1name = "", rewarditem2QT = 1, rewarditem2 = "", item2name = "", rewarditem3QT = 1, rewarditem3 = "", item3name = "", rewardmoney = 300, rewardgold = 1},
[40]   = {requiredxp = 4000 ,  rewarditem1QT = 1, rewarditem1 = "", item1name = "", rewarditem2QT = 1, rewarditem2 = "", item2name = "", rewarditem3QT = 1, rewarditem3 = "", item3name = "", rewardmoney = 300, rewardgold = 1},
[41]   = {requiredxp = 4100 ,  rewarditem1QT = 1, rewarditem1 = "", item1name = "", rewarditem2QT = 1, rewarditem2 = "", item2name = "", rewarditem3QT = 1, rewarditem3 = "", item3name = "", rewardmoney = 300, rewardgold = 1},
[42]   = {requiredxp = 4200 ,  rewarditem1QT = 1, rewarditem1 = "", item1name = "", rewarditem2QT = 1, rewarditem2 = "", item2name = "", rewarditem3QT = 1, rewarditem3 = "", item3name = "", rewardmoney = 300, rewardgold = 1},
[43]   = {requiredxp = 4300 ,  rewarditem1QT = 1, rewarditem1 = "", item1name = "", rewarditem2QT = 1, rewarditem2 = "", item2name = "", rewarditem3QT = 1, rewarditem3 = "", item3name = "", rewardmoney = 300, rewardgold = 1},
[44]   = {requiredxp = 4400 ,  rewarditem1QT = 1, rewarditem1 = "", item1name = "", rewarditem2QT = 1, rewarditem2 = "", item2name = "", rewarditem3QT = 1, rewarditem3 = "", item3name = "", rewardmoney = 300, rewardgold = 1},
[45]   = {requiredxp = 4500 ,  rewarditem1QT = 1, rewarditem1 = "", item1name = "", rewarditem2QT = 1, rewarditem2 = "", item2name = "", rewarditem3QT = 1, rewarditem3 = "", item3name = "", rewardmoney = 300, rewardgold = 1},
[46]   = {requiredxp = 4600 ,  rewarditem1QT = 1, rewarditem1 = "", item1name = "", rewarditem2QT = 1, rewarditem2 = "", item2name = "", rewarditem3QT = 1, rewarditem3 = "", item3name = "", rewardmoney = 300, rewardgold = 1},
[47]   = {requiredxp = 4700 ,  rewarditem1QT = 1, rewarditem1 = "", item1name = "", rewarditem2QT = 1, rewarditem2 = "", item2name = "", rewarditem3QT = 1, rewarditem3 = "", item3name = "", rewardmoney = 300, rewardgold = 1},
[48]   = {requiredxp = 4800 ,  rewarditem1QT = 1, rewarditem1 = "", item1name = "", rewarditem2QT = 1, rewarditem2 = "", item2name = "", rewarditem3QT = 1, rewarditem3 = "", item3name = "", rewardmoney = 300, rewardgold = 1},
[49]   = {requiredxp = 4900 ,  rewarditem1QT = 1, rewarditem1 = "", item1name = "", rewarditem2QT = 1, rewarditem2 = "", item2name = "", rewarditem3QT = 1, rewarditem3 = "", item3name = "", rewardmoney = 300, rewardgold = 1},
[50]   = {requiredxp = 5000 ,  rewarditem1QT = 1, rewarditem1 = "", item1name = "", rewarditem2QT = 1, rewarditem2 = "", item2name = "", rewarditem3QT = 1, rewarditem3 = "", item3name = "", rewardmoney = 300, rewardgold = 1},
[51]   = {requiredxp = 5100 ,  rewarditem1QT = 1, rewarditem1 = "", item1name = "", rewarditem2QT = 1, rewarditem2 = "", item2name = "", rewarditem3QT = 1, rewarditem3 = "", item3name = "", rewardmoney = 300, rewardgold = 1},
[52]   = {requiredxp = 5200 ,  rewarditem1QT = 1, rewarditem1 = "", item1name = "", rewarditem2QT = 1, rewarditem2 = "", item2name = "", rewarditem3QT = 1, rewarditem3 = "", item3name = "", rewardmoney = 300, rewardgold = 1},
[53]   = {requiredxp = 5300 ,  rewarditem1QT = 1, rewarditem1 = "", item1name = "", rewarditem2QT = 1, rewarditem2 = "", item2name = "", rewarditem3QT = 1, rewarditem3 = "", item3name = "", rewardmoney = 300, rewardgold = 1},
[54]   = {requiredxp = 5400 ,  rewarditem1QT = 1, rewarditem1 = "", item1name = "", rewarditem2QT = 1, rewarditem2 = "", item2name = "", rewarditem3QT = 1, rewarditem3 = "", item3name = "", rewardmoney = 300, rewardgold = 1},
[55]   = {requiredxp = 5500 ,  rewarditem1QT = 1, rewarditem1 = "", item1name = "", rewarditem2QT = 1, rewarditem2 = "", item2name = "", rewarditem3QT = 1, rewarditem3 = "", item3name = "", rewardmoney = 300, rewardgold = 1},
[56]   = {requiredxp = 5600 ,  rewarditem1QT = 1, rewarditem1 = "", item1name = "", rewarditem2QT = 1, rewarditem2 = "", item2name = "", rewarditem3QT = 1, rewarditem3 = "", item3name = "", rewardmoney = 300, rewardgold = 1},
[57]   = {requiredxp = 5700 ,  rewarditem1QT = 1, rewarditem1 = "", item1name = "", rewarditem2QT = 1, rewarditem2 = "", item2name = "", rewarditem3QT = 1, rewarditem3 = "", item3name = "", rewardmoney = 300, rewardgold = 1},
[58]   = {requiredxp = 5800 ,  rewarditem1QT = 1, rewarditem1 = "", item1name = "", rewarditem2QT = 1, rewarditem2 = "", item2name = "", rewarditem3QT = 1, rewarditem3 = "", item3name = "", rewardmoney = 300, rewardgold = 1},
[59]   = {requiredxp = 5900 ,  rewarditem1QT = 1, rewarditem1 = "", item1name = "", rewarditem2QT = 1, rewarditem2 = "", item2name = "", rewarditem3QT = 1, rewarditem3 = "", item3name = "", rewardmoney = 300, rewardgold = 1},
[60]   = {requiredxp = 6000 ,  rewarditem1QT = 1, rewarditem1 = "", item1name = "", rewarditem2QT = 1, rewarditem2 = "", item2name = "", rewarditem3QT = 1, rewarditem3 = "", item3name = "", rewardmoney = 300, rewardgold = 1},
[61]   = {requiredxp = 6100 ,  rewarditem1QT = 1, rewarditem1 = "", item1name = "", rewarditem2QT = 1, rewarditem2 = "", item2name = "", rewarditem3QT = 1, rewarditem3 = "", item3name = "", rewardmoney = 300, rewardgold = 1},
[62]   = {requiredxp = 6200 ,  rewarditem1QT = 1, rewarditem1 = "", item1name = "", rewarditem2QT = 1, rewarditem2 = "", item2name = "", rewarditem3QT = 1, rewarditem3 = "", item3name = "", rewardmoney = 300, rewardgold = 1},
[63]   = {requiredxp = 6300 ,  rewarditem1QT = 1, rewarditem1 = "", item1name = "", rewarditem2QT = 1, rewarditem2 = "", item2name = "", rewarditem3QT = 1, rewarditem3 = "", item3name = "", rewardmoney = 300, rewardgold = 1},
[64]   = {requiredxp = 6400 ,  rewarditem1QT = 1, rewarditem1 = "", item1name = "", rewarditem2QT = 1, rewarditem2 = "", item2name = "", rewarditem3QT = 1, rewarditem3 = "", item3name = "", rewardmoney = 300, rewardgold = 1},
[65]   = {requiredxp = 6500 ,  rewarditem1QT = 1, rewarditem1 = "", item1name = "", rewarditem2QT = 1, rewarditem2 = "", item2name = "", rewarditem3QT = 1, rewarditem3 = "", item3name = "", rewardmoney = 300, rewardgold = 1},
[66]   = {requiredxp = 6600 ,  rewarditem1QT = 1, rewarditem1 = "", item1name = "", rewarditem2QT = 1, rewarditem2 = "", item2name = "", rewarditem3QT = 1, rewarditem3 = "", item3name = "", rewardmoney = 300, rewardgold = 1},
[67]   = {requiredxp = 6700 ,  rewarditem1QT = 1, rewarditem1 = "", item1name = "", rewarditem2QT = 1, rewarditem2 = "", item2name = "", rewarditem3QT = 1, rewarditem3 = "", item3name = "", rewardmoney = 300, rewardgold = 1},
[68]   = {requiredxp = 6800 ,  rewarditem1QT = 1, rewarditem1 = "", item1name = "", rewarditem2QT = 1, rewarditem2 = "", item2name = "", rewarditem3QT = 1, rewarditem3 = "", item3name = "", rewardmoney = 300, rewardgold = 1},
[69]   = {requiredxp = 6900 ,  rewarditem1QT = 1, rewarditem1 = "", item1name = "", rewarditem2QT = 1, rewarditem2 = "", item2name = "", rewarditem3QT = 1, rewarditem3 = "", item3name = "", rewardmoney = 300, rewardgold = 1},
[70]   = {requiredxp = 7000 ,  rewarditem1QT = 1, rewarditem1 = "", item1name = "", rewarditem2QT = 1, rewarditem2 = "", item2name = "", rewarditem3QT = 1, rewarditem3 = "", item3name = "", rewardmoney = 300, rewardgold = 1},
[71]   = {requiredxp = 7100 ,  rewarditem1QT = 1, rewarditem1 = "", item1name = "", rewarditem2QT = 1, rewarditem2 = "", item2name = "", rewarditem3QT = 1, rewarditem3 = "", item3name = "", rewardmoney = 300, rewardgold = 1},
[72]   = {requiredxp = 7200 ,  rewarditem1QT = 1, rewarditem1 = "", item1name = "", rewarditem2QT = 1, rewarditem2 = "", item2name = "", rewarditem3QT = 1, rewarditem3 = "", item3name = "", rewardmoney = 300, rewardgold = 1},
[73]   = {requiredxp = 7300 ,  rewarditem1QT = 1, rewarditem1 = "", item1name = "", rewarditem2QT = 1, rewarditem2 = "", item2name = "", rewarditem3QT = 1, rewarditem3 = "", item3name = "", rewardmoney = 300, rewardgold = 1},
[74]   = {requiredxp = 7400 ,  rewarditem1QT = 1, rewarditem1 = "", item1name = "", rewarditem2QT = 1, rewarditem2 = "", item2name = "", rewarditem3QT = 1, rewarditem3 = "", item3name = "", rewardmoney = 300, rewardgold = 1},
[75]   = {requiredxp = 7500 ,  rewarditem1QT = 1, rewarditem1 = "", item1name = "", rewarditem2QT = 1, rewarditem2 = "", item2name = "", rewarditem3QT = 1, rewarditem3 = "", item3name = "", rewardmoney = 300, rewardgold = 1},
[76]   = {requiredxp = 7600 ,  rewarditem1QT = 1, rewarditem1 = "", item1name = "", rewarditem2QT = 1, rewarditem2 = "", item2name = "", rewarditem3QT = 1, rewarditem3 = "", item3name = "", rewardmoney = 300, rewardgold = 1},
[77]   = {requiredxp = 7700 ,  rewarditem1QT = 1, rewarditem1 = "", item1name = "", rewarditem2QT = 1, rewarditem2 = "", item2name = "", rewarditem3QT = 1, rewarditem3 = "", item3name = "", rewardmoney = 300, rewardgold = 1},
[78]   = {requiredxp = 7800 ,  rewarditem1QT = 1, rewarditem1 = "", item1name = "", rewarditem2QT = 1, rewarditem2 = "", item2name = "", rewarditem3QT = 1, rewarditem3 = "", item3name = "", rewardmoney = 300, rewardgold = 1},
[79]   = {requiredxp = 7900 ,  rewarditem1QT = 1, rewarditem1 = "", item1name = "", rewarditem2QT = 1, rewarditem2 = "", item2name = "", rewarditem3QT = 1, rewarditem3 = "", item3name = "", rewardmoney = 300, rewardgold = 1},
[80]   = {requiredxp = 8000 ,  rewarditem1QT = 1, rewarditem1 = "", item1name = "", rewarditem2QT = 1, rewarditem2 = "", item2name = "", rewarditem3QT = 1, rewarditem3 = "", item3name = "", rewardmoney = 300, rewardgold = 1},
[81]   = {requiredxp = 8100 ,  rewarditem1QT = 1, rewarditem1 = "", item1name = "", rewarditem2QT = 1, rewarditem2 = "", item2name = "", rewarditem3QT = 1, rewarditem3 = "", item3name = "", rewardmoney = 300, rewardgold = 1},
[82]   = {requiredxp = 8200 ,  rewarditem1QT = 1, rewarditem1 = "", item1name = "", rewarditem2QT = 1, rewarditem2 = "", item2name = "", rewarditem3QT = 1, rewarditem3 = "", item3name = "", rewardmoney = 300, rewardgold = 1},
[83]   = {requiredxp = 8300 ,  rewarditem1QT = 1, rewarditem1 = "", item1name = "", rewarditem2QT = 1, rewarditem2 = "", item2name = "", rewarditem3QT = 1, rewarditem3 = "", item3name = "", rewardmoney = 300, rewardgold = 1},
[84]   = {requiredxp = 8400 ,  rewarditem1QT = 1, rewarditem1 = "", item1name = "", rewarditem2QT = 1, rewarditem2 = "", item2name = "", rewarditem3QT = 1, rewarditem3 = "", item3name = "", rewardmoney = 300, rewardgold = 1},
[85]   = {requiredxp = 8500 ,  rewarditem1QT = 1, rewarditem1 = "", item1name = "", rewarditem2QT = 1, rewarditem2 = "", item2name = "", rewarditem3QT = 1, rewarditem3 = "", item3name = "", rewardmoney = 300, rewardgold = 1},
[86]   = {requiredxp = 8600 ,  rewarditem1QT = 1, rewarditem1 = "", item1name = "", rewarditem2QT = 1, rewarditem2 = "", item2name = "", rewarditem3QT = 1, rewarditem3 = "", item3name = "", rewardmoney = 300, rewardgold = 1},
[87]   = {requiredxp = 8700 ,  rewarditem1QT = 1, rewarditem1 = "", item1name = "", rewarditem2QT = 1, rewarditem2 = "", item2name = "", rewarditem3QT = 1, rewarditem3 = "", item3name = "", rewardmoney = 300, rewardgold = 1},
[88]   = {requiredxp = 8800 ,  rewarditem1QT = 1, rewarditem1 = "", item1name = "", rewarditem2QT = 1, rewarditem2 = "", item2name = "", rewarditem3QT = 1, rewarditem3 = "", item3name = "", rewardmoney = 300, rewardgold = 1},
[89]   = {requiredxp = 8900 ,  rewarditem1QT = 1, rewarditem1 = "", item1name = "", rewarditem2QT = 1, rewarditem2 = "", item2name = "", rewarditem3QT = 1, rewarditem3 = "", item3name = "", rewardmoney = 300, rewardgold = 1},
[90]   = {requiredxp = 9000 ,  rewarditem1QT = 1, rewarditem1 = "", item1name = "", rewarditem2QT = 1, rewarditem2 = "", item2name = "", rewarditem3QT = 1, rewarditem3 = "", item3name = "", rewardmoney = 300, rewardgold = 1},
[91]   = {requiredxp = 9100 ,  rewarditem1QT = 1, rewarditem1 = "", item1name = "", rewarditem2QT = 1, rewarditem2 = "", item2name = "", rewarditem3QT = 1, rewarditem3 = "", item3name = "", rewardmoney = 300, rewardgold = 1},
[92]   = {requiredxp = 9200 ,  rewarditem1QT = 1, rewarditem1 = "", item1name = "", rewarditem2QT = 1, rewarditem2 = "", item2name = "", rewarditem3QT = 1, rewarditem3 = "", item3name = "", rewardmoney = 300, rewardgold = 1},
[93]   = {requiredxp = 9300 ,  rewarditem1QT = 1, rewarditem1 = "", item1name = "", rewarditem2QT = 1, rewarditem2 = "", item2name = "", rewarditem3QT = 1, rewarditem3 = "", item3name = "", rewardmoney = 300, rewardgold = 1},
[94]   = {requiredxp = 9400 ,  rewarditem1QT = 1, rewarditem1 = "", item1name = "", rewarditem2QT = 1, rewarditem2 = "", item2name = "", rewarditem3QT = 1, rewarditem3 = "", item3name = "", rewardmoney = 300, rewardgold = 1},
[95]   = {requiredxp = 9500 ,  rewarditem1QT = 1, rewarditem1 = "", item1name = "", rewarditem2QT = 1, rewarditem2 = "", item2name = "", rewarditem3QT = 1, rewarditem3 = "", item3name = "", rewardmoney = 300, rewardgold = 1},
[96]   = {requiredxp = 9600 ,  rewarditem1QT = 1, rewarditem1 = "", item1name = "", rewarditem2QT = 1, rewarditem2 = "", item2name = "", rewarditem3QT = 1, rewarditem3 = "", item3name = "", rewardmoney = 300, rewardgold = 1},
[97]   = {requiredxp = 9700 ,  rewarditem1QT = 1, rewarditem1 = "", item1name = "", rewarditem2QT = 1, rewarditem2 = "", item2name = "", rewarditem3QT = 1, rewarditem3 = "", item3name = "", rewardmoney = 300, rewardgold = 1},
[98]   = {requiredxp = 9800 ,  rewarditem1QT = 1, rewarditem1 = "", item1name = "", rewarditem2QT = 1, rewarditem2 = "", item2name = "", rewarditem3QT = 1, rewarditem3 = "", item3name = "", rewardmoney = 300, rewardgold = 1},
[99]   = {requiredxp = 9900 ,  rewarditem1QT = 1, rewarditem1 = "", item1name = "", rewarditem2QT = 1, rewarditem2 = "", item2name = "", rewarditem3QT = 1, rewarditem3 = "", item3name = "", rewardmoney = 300, rewardgold = 1},
[100]  = {requiredxp = 10000,  rewarditem1QT = 1, rewarditem1 = "", item1name = "", rewarditem2QT = 1, rewarditem2 = "", item2name = "", rewarditem3QT = 1, rewarditem3 = "", item3name = "", rewardmoney = 300, rewardgold = 1},
}
 
 
 
------------------------------------------------
			    --PROMPTS --
------------------------------------------------
Config.PromptMissionType1StartTitle = "Short Mission" 
Config.PromptMissionType1Start      = 0x9959A6F0 -- C

Config.PromptMissionType2StartTitle = "Long Mission"
Config.PromptMissionType2Start      = 0x7F8D09B8 -- V    

Config.PromptMissionDeliverTitle    = "Deliver Bounty"
Config.PromptMissionDeliver         = 0xC7B5340A -- ENTER

Config.CheckCluePromptTitle         = "Inspect"
Config.CheckCluePrompt              = 0xC7B5340A -- ENTER
  
Config.CheckPlayerXpTitle       	= "Check Role XP"
Config.CheckPlayerXp           		= 0xC7B5340A -- ENTER
 
------------------------------------------------
			--TEXT TRANSLATIONS--
------------------------------------------------

Config.LastSeeNear                   = "Last seen near"
Config.TextBountyHunterMission       = "Bounty Hunter Mission"
Config.TextGoToBountyLocation        = "Go to the bounty location"
Config.TextMissionStarted            = "Mission Started"
Config.TextMissionClue               = "Track"
Config.TextMissionBountyHunter       = "Bounty Hunter"
Config.TextSearchZone                = "Search Zone"
Config.TextBountyTarget              = "Bounty Target"
Config.TextBountyHunting             = "Bounty Hunting"
Config.TextLookForClues              = "Look for ~COLOR_GOLD~clues~COLOR_WHITE~ in the area"
Config.TextBringTheBounty            = "~COLOR_WHITE~Bring the~COLOR_RED~ bounty~COLOR_WHITE~ to the sheriff office"
Config.TextCaptureOrKillBounty       = "~COLOR_WHITE~Capture or ~COLOR_RED~Kill ~COLOR_WHITE~the Bounty Target"
Config.TextFindTheTarget             = "~COLOR_WHITE~Find the ~COLOR_RED~Bounty Target~COLOR_WHITE~"

Config.TextMissionSuccess            = "~COLOR_GOLD~MISSION SUCCESS"
Config.TextMissionFailed             = "~e~ MISSION FAILED"
Config.TextMissionRestart            = "Restart The Mission"
Config.TextBountyAlive               = "Bounty Alive"
Config.TextBountyDead                = "Bounty Dead"
Config.TextYouHaveBeenPaid           = "~COLOR_GOLD~You have been paid $"
Config.TextClueFound                 = "You found a clue"
Config.TextNextKnownBountyLocation   = "Check the bounty location"
 
Config.TextDontHaveRole              = "You don't have the required role"
 
 
 
 
Config.SheriffOffices = {
		[1] = { 
        name = 'Valentine Sheriff Office', 
        blipenabled = true, 
        sprite  = 778811758, 
		coords  = {x= -271.3842, y= 803.6263, z= 119.3969},
		camera1 = {a= -280.83, b= 794.43, c= 118.95, d= 14.57, e= 0.00, f= -32.13, g= 60.00},
		camera2 = {a= -275.22, b= 796.23, c= 119.65, d= -0.55, e= 0.00, f= 10.70,  g= 50.00},
		camera3 = {a= -278.44, b= 803.94, c= 119.65, d= -0.30, e= 0.00, f= -57.77, g= 40.00},
		coordsaftercutscene = vector4(-277.5390930175781, 799.81787109375, 119.34535217285156, -140.0),
    },	
	
	    [2] = { 
        name = 'Strawberry Sheriff Office', 
        blipenabled = true, 
        sprite = 778811758,
		coords  = {x= -1802.0546, y= -358.5252, z= 163.8671},
		camera1 = {a= -1792.83, b= -349.57, c= 165.09, d= 3.33, e= 0.00, f= 119.50, g= 60.00},
		camera2 = {a= -1758.24, b= -455.82, c= 185.10, d= -6.93, e= 0.00, f= 39.95, g= 61.00},
		camera3 = {a= -1814.79, b= -350.26, c= 162.96, d= -22.97, e= 0.00, f= -160.59, g= 60.00},  
		coordsaftercutscene = vector4(-1803.016845703125, -356.4715270996094, 164.1223907470703, -140.0),
    },	
	
	    [3] = { 
        name = 'Blackwater Sheriff Office', 
        blipenabled = true, 
        sprite = 778811758, 
		coords =  {x= -767.1304, y= -1259.6434, z= 43.5832},
		camera1 = {a= -768.62, b= -1269.22, c= 45.08, d= -4.80, e= 0.00, f= -89.92, g= 60.00},
		camera2 = {a= -745.58, b= -1261.49, c= 44.85, d= 4.27,  e= 0.00, f= 126.02, g= 50.00},
		camera3 = {a= -723.89, b= -1264.64, c= 44.85, d= 0.24,  e= 0.00, f= -57.79, g= 40.00}, 
		coordsaftercutscene = vector4(-754.9749755859375, -1271.4931640625, 44.01133728027344, -87.0),
    },		
	
	    [4] = { 
        name = 'Armadillo Sheriff Office', 
        blipenabled = true, 
        sprite = 778811758,
		coords =  {x= -3623.8621,y= -2597.8047, z= -13.7346},		  
		camera1 = {a= -3622.30, b= -2603.18, c= -12.63, d= -2.13, e= 0.00, f= -154.95, g= 60.00},
		camera2 = {a= -3625.04, b= -2604.88, c= -13.09, d= -0.94, e= 0.00, f= 116.86,  g= 50.00},
		camera3 = {a= -3629.07, b= -2618.85, c= -14.01, d= 3.28,  e= 0.00, f= 63.00,   g= 40.00},
		coordsaftercutscene = vector4(-3627.48095703125, -2603.833251953125, -13.34522056579589, 157.0),
    },		
 
 	    [5] = { 
        name = 'Tumbleweed Sheriff Office', 
        blipenabled = true, 
        sprite = 778811758,
		coords =  {x= -5524.4990, y= -2926.0186, z= -2.0616},
		camera1 = {a= -5533.26, b= -2926.78, c= -0.95, d= 0.89,  e=0.00, f= -109.19, g= 60.00},
		camera2 = {a= -5530.88, b= -2934.85, c= -2.10, d= 5.80,  e=0.00, f= -106.85, g= 50.00},
		camera3 = {a= -5476.71, b= -2953.58, c= 4.80,  d= -4.78, e=0.00, f= 72.99,   g= 40.00},
		coordsaftercutscene = vector4(-5527.98876953125, -2934.7158203125, -1.95076715946197, -120.0),
	},		
	
 	    [6] = { 
        name = 'Rhodes Sheriff Office', 
        blipenabled = true, 
        sprite = 778811758, 
		coords =  {x= 1353.1360,y= -1305.7720, z= 76.9504},
		camera1 = {a= 1360.32, b= -1302.41, c= 78.18, d= -1.43, e= 0.00, f= -19.16, g= 60.00},
		camera2 = {a= 1354.92, b= -1316.59, c= 78.18, d= 1.59,  e= 0.00, f= -20.55, g= 50.00},
		camera3 = {a= 1365.31, b= -1314.55, c= 78.18, d= -0.93, e= 0.00, f= 74.89,  g= 40.00},
		coordsaftercutscene = vector4(1361.4595947265625, -1311.362548828125, 77.0335922241211, 103.0),
	},	
	
 	    [7] = { 
        name = 'Saint Denis Sheriff Office', 
        blipenabled = true, 
        sprite = 778811758,
		coords =  {x= 2514.4475, y= -1320.5682, z= 48.5776}, 
		camera1 = {a= 2494.00, b= -1308.93, c= 48.50, d= 22.19, e= 0.00, f= -89.00,  g= 60.00},
		camera2 = {a= 2482.93, b= -1312.99, c= 54.02, d= 3.10,  e= 0.00, f= -136.44, g= 50.00},
		camera3 = {a= 2494.33, b= -1318.35, c= 69.20, d= -0.55, e= 0.00, f= 33.45,   g= 40.00},
		coordsaftercutscene = vector4(2519.97509765625, -1306.7669677734375, 49.02158737182617, 109.0),
	},		
			
  	    [8] = { 
        name = 'Annesburg Sheriff Office', 
        blipenabled = true, 
        sprite = 778811758,
		coords =  {x= 2914.2993, y= 1305.7046, z= 44.2610},
		camera1 = {a= 2905.51, b= 1316.24, c= 45.60, d= -3.20, e= 0.00, f= -150.45, g= 60.00},
		camera2 = {a= 2921.86, b= 1306.96, c= 45.60, d= 6.50,  e= 0.00, f= 71.22,   g= 50.00},
		camera3 = {a= 2909.88, b= 1300.95, c= 45.34, d= 2.08,  e= 0.00, f= -22.69,  g= 40.00}, 
		coordsaftercutscene = vector4(2914.787353515625, 1303.9202880859375, 44.11423110961914, 24.5),
	},	 
}

 
--------------------------------------
	    -- BOUNTY LOCATIONS-- 
--------------------------------------
 
-- Find the music list here: https://github.com/femga/rdr3_discoveries/blob/master/audio/music_events/music_events.lua
 
 
 -- These missions will start from the district where the player is at. For example if the player starts the missions from the valentine sheriff office ( district heartlands) then the missions with the same district param will randomly be chosen.
 
Config.Missions = {

-- HEARTLANDS -- 

    [1]  = { name                = 'Bounty Target',  
			 model               = "mp_u_m_m_bountytarget_001", 
			 bountyscenario      = "MP_COOP_LOBBY_STANDING_A",
			 CountdownEnabled    = true,
			 CountdownTimer      = 20,
			 missionnetworked    = true,
			 enemies             = {
			 [1] = {model = "mp_g_m_m_animalpoachers_01", weapon = "weapon_revolver_cattleman", coords = vector4(177.6090850830078, 337.08343505859375, 120.46776580810547, 154.20), scenario = "MP_COOP_LOBBY_STANDING_A" },
			 },
			 district            = "district_heartlands", -- This mission will have a chance to trigger if the player is in this district when starting the mission. 
			 missioncoords       = vector3(180.3892059326172, 343.41766357421875, 120.6244888305664), 
			 bountycoords		 = vector4(180.3892059326172, 343.41766357421875, 120.6244888305664, 0.0), 
			 deliverycoords      = vector3(-271.3842, 803.6263, 119.3969), --VAL SHERIFF OFFICE 
			 musicenabled        = true, 
			 music               = "BOU1_START", 
			 EnnemiesCooldown    = 30,
			 EnnemyPedModel      = "mp_g_m_m_animalpoachers_01", -- ENEMY REINFORCEMENT WAVE PED MODEL 
			 ChanceOfSpawn       = 100,
			 NumberOfEnnemiesMin = 3,
			 NumberOfEnnemiesMax = 4,
			 aliveshortreward    = 30, 
			 alivelongreward     = 120, 
			 aliveshortxp        = 20, 
			 alivelongxp         = 120,
			 deadshortreward     = 30, 		 
			 deadlongreward      = 120,
			 deadshortxp         = 10,			 
			 deadlongxp          = 30, 
			},
 
 
    [2]  = { name                = 'Bounty Target',  
			 model               = "mp_u_f_m_bountytarget_001", 
			 bountyscenario      = "MP_COOP_LOBBY_STANDING_A",
			 CountdownEnabled    = true,
			 CountdownTimer      = 20,
			 missionnetworked    = true,
			 enemies             = {
			 [1] = {model = "mp_g_m_m_animalpoachers_01", weapon = "weapon_revolver_cattleman", coords = vector4(213.6729278564453, 1007.9149169921875, 189.22886657714844, -14.0), scenario = "MP_COOP_LOBBY_STANDING_A" },
			 [2] = {model = "mp_g_m_m_animalpoachers_01", weapon = "weapon_repeater_carbine",   coords = vector4(229.57408142089844, 997.3363037109375, 189.6605682373047, -69.77), scenario = "MP_COOP_LOBBY_STANDING_A" },
			 [3] = {model = "mp_g_m_m_animalpoachers_01", weapon = "weapon_repeater_carbine",   coords = vector4(202.37652587890625, 968.2504272460938, 190.31370544433594, 134.70), scenario = "MP_COOP_LOBBY_STANDING_A" },
			 },
			 district            = "district_heartlands", --This mission will have a chance to trigger if the player is in this district when starting the mission. 
			 missioncoords       = vector3(215.83885192871094, 1010.5267944335938, 189.0733642578125), 
			 bountycoords		 = vector4(213.416748046875, 1000.5734252929688, 189.64207458496094, 80.20), 
			 deliverycoords      = vector3(-271.3842, 803.6263, 119.3969), --VAL SHERIFF OFFICE
			 musicenabled        = true, 
			 music               = "BOU1_START", 
			 EnnemiesCooldown    = 30,
			 EnnemyPedModel      = "mp_g_m_m_animalpoachers_01", -- ENEMY REINFORCEMENT WAVE PED MODEL 
			 ChanceOfSpawn       = 100,
			 NumberOfEnnemiesMin = 3,
			 NumberOfEnnemiesMax = 4,
			 aliveshortreward    = 30, 
			 alivelongreward     = 120, 
			 aliveshortxp        = 20, 
			 alivelongxp         = 120,
			 deadshortreward     = 30, 		 
			 deadlongreward      = 120,
			 deadshortxp         = 10,			 
			 deadlongxp          = 30, 
			},	



    [3]  = { name                = 'Bounty Target',  
			 model               = "mp_u_m_m_bountytarget_002", 
			 bountyscenario      = "MP_COOP_LOBBY_STANDING_A",
			 CountdownEnabled    = true,
			 CountdownTimer      = 20,
			 missionnetworked    = true,
			 enemies             = {
			 [1] = {model = "mp_g_m_m_animalpoachers_01", weapon = "weapon_revolver_cattleman", coords = vector4(1167.387939453125, 753.367919921875, 98.5161361694336, -14.0), scenario = "MP_COOP_LOBBY_STANDING_A" },
			 [2] = {model = "mp_g_m_m_animalpoachers_01", weapon = "weapon_repeater_carbine",   coords = vector4(1183.8553466796875, 740.9578857421875, 101.54258728027344, -100.77), scenario = "MP_COOP_LOBBY_STANDING_A" },
			 [3] = {model = "mp_g_m_m_animalpoachers_01", weapon = "weapon_repeater_carbine",   coords = vector4(1141.023681640625, 730.1071166992188, 97.84725952148438, 126.0), scenario = "MP_COOP_LOBBY_STANDING_A" },
			 },
			 district            = "district_heartlands", --This mission will have a chance to trigger if the player is in this district when starting the mission. 
			 missioncoords       = vector3(1160.7860107421875, 734.4483642578125, 97.13967895507812), 
			 bountycoords		 = vector4(1160.7860107421875, 734.4483642578125, 97.13967895507812, 80.20), 
			 deliverycoords      = vector3(-271.3842, 803.6263, 119.3969), --VAL SHERIFF OFFICE
			 musicenabled        = true, 
			 music               = "BOU1_START", 
			 EnnemiesCooldown    = 30,
			 EnnemyPedModel      = "mp_g_m_m_animalpoachers_01", -- ENEMY REINFORCEMENT WAVE PED MODEL 
			 ChanceOfSpawn       = 100,
			 NumberOfEnnemiesMin = 3,
			 NumberOfEnnemiesMax = 4,
			 aliveshortreward    = 30, 
			 alivelongreward     = 120, 
			 aliveshortxp        = 20, 
			 alivelongxp         = 120,
			 deadshortreward     = 30, 		 
			 deadlongreward      = 120,
			 deadshortxp         = 10,			 
			 deadlongxp          = 30, 
			},	



    [4]  = { name                = 'Bounty Target',  
			 model               = "mp_u_m_m_bountytarget_003", 
			 bountyscenario      = "MP_COOP_LOBBY_STANDING_A",
			 CountdownEnabled    = true,
			 CountdownTimer      = 20,
			 missionnetworked    = true,
			 enemies             = {
			 [1] = {model = "mp_g_m_m_animalpoachers_01", weapon = "weapon_revolver_cattleman", coords = vector4(1170.6715087890625, 907.6061401367188, 118.26014709472656, -126.0), scenario = "MP_COOP_LOBBY_STANDING_A" },
			 [2] = {model = "mp_g_m_m_animalpoachers_01", weapon = "weapon_repeater_carbine",   coords = vector4(1173.419921875, 933.6943359375, 121.68536376953125, -21.0), scenario = "MP_COOP_LOBBY_STANDING_A" },
			 [3] = {model = "mp_g_m_m_animalpoachers_01", weapon = "weapon_repeater_carbine",   coords = vector4(1138.98193359375, 970.3977661132812, 126.2532730102539, 34.0), scenario = "MP_COOP_LOBBY_STANDING_A" },
			 },
			 district            = "district_heartlands", --This mission will have a chance to trigger if the player is in this district when starting the mission. 
			 missioncoords       = vector3(1156.526123046875, 912.0886840820312, 119.57254791259766), 
			 bountycoords		 = vector4(1156.526123046875, 912.0886840820312, 119.57254791259766, 80.20), 
			 deliverycoords      = vector3(-271.3842, 803.6263, 119.3969), --VAL SHERIFF OFFICE
			 musicenabled        = true, 
			 music               = "BOU1_START", 
			 EnnemiesCooldown    = 30,
			 EnnemyPedModel      = "mp_g_m_m_animalpoachers_01", -- ENEMY REINFORCEMENT WAVE PED MODEL 
			 ChanceOfSpawn       = 100,
			 NumberOfEnnemiesMin = 3,
			 NumberOfEnnemiesMax = 4,
			 aliveshortreward    = 30, 
			 alivelongreward     = 120, 
			 aliveshortxp        = 20, 
			 alivelongxp         = 120,
			 deadshortreward     = 30, 		 
			 deadlongreward      = 120,
			 deadshortxp         = 10,			 
			 deadlongxp          = 30, 
			},	
 
			
    [5]  = { name                = 'Bounty Target',  
			 model               = "mp_u_m_m_bountytarget_005", 
			 bountyscenario      = "MP_COOP_LOBBY_STANDING_A",
			 CountdownEnabled    = true,
			 CountdownTimer      = 20,
			 missionnetworked    = true,
			 enemies             = {
			 [1] = {model = "mp_g_m_m_animalpoachers_01", weapon = "weapon_revolver_cattleman", coords = vector4(988.5491333007812, 1001.6594848632812, 150.5536346435547, -126.0),  scenario = "MP_COOP_LOBBY_STANDING_A" },
			 [2] = {model = "mp_g_m_m_animalpoachers_01", weapon = "weapon_repeater_carbine",   coords = vector4(1005.2252807617188, 1000.2305908203125, 152.07904052734375, -21.0), scenario = "MP_COOP_LOBBY_STANDING_A" },
			 [3] = {model = "mp_g_m_m_animalpoachers_01", weapon = "weapon_repeater_carbine",   coords = vector4(1014.2506103515625, 990.8575439453125, 153.31088256835938, 34.0),   scenario = "MP_COOP_LOBBY_STANDING_A" },
			 },
			 district            = "district_heartlands", --This mission will have a chance to trigger if the player is in this district when starting the mission. 
			 missioncoords       = vector3(988.58740234375, 984.7420654296875, 150.72825622558594), 
			 bountycoords		 = vector4(988.58740234375, 984.7420654296875, 150.72825622558594, 80.20), 
			 deliverycoords      = vector3(-271.3842, 803.6263, 119.3969), --VAL SHERIFF OFFICE
			 musicenabled        = true, 
			 music               = "BOU1_START", 
			 EnnemiesCooldown    = 30,
			 EnnemyPedModel      = "mp_g_m_m_animalpoachers_01", -- ENEMY REINFORCEMENT WAVE PED MODEL 
			 ChanceOfSpawn       = 100,
			 NumberOfEnnemiesMin = 3,
			 NumberOfEnnemiesMax = 4,
			 aliveshortreward    = 30, 
			 alivelongreward     = 120, 
			 aliveshortxp        = 20, 
			 alivelongxp         = 120,
			 deadshortreward     = 30, 		 
			 deadlongreward      = 120,
			 deadshortxp         = 10,			 
			 deadlongxp          = 30, 
			},	
			
			
 
-- SCARLETT MEADOWS  

    [6]  = { name                = 'Bounty Target',  
			 model               = "mp_u_m_m_bountytarget_008", 
			 bountyscenario      = "MP_COOP_LOBBY_STANDING_A",
			 CountdownEnabled    = true,
			 CountdownTimer      = 20,
			 missionnetworked    = true,
			 enemies             = {
			 [1] = {model = "mp_g_m_o_uniexconfeds_01", weapon = "weapon_revolver_cattleman", coords = vector4(1321.152099609375, -2265.7041015625, 49.39135360717773, 47.84), scenario = "MP_COOP_LOBBY_STANDING_A" },
			 [2] = {model = "mp_g_m_o_uniexconfeds_01", weapon = "weapon_repeater_carbine",   coords = vector4(229.57408142089844, 997.3363037109375, 189.6605682373047, -69.77), scenario = "MP_COOP_LOBBY_STANDING_A" },
			 [3] = {model = "mp_g_m_o_uniexconfeds_01", weapon = "weapon_repeater_carbine",   coords = vector4(202.37652587890625, 968.2504272460938, 190.31370544433594, 134.70), scenario = "MP_COOP_LOBBY_STANDING_A" },
			 },
			 district            = "district_scarlett_meadows", --This mission will have a chance to trigger if the player is in this district when starting the mission. 
			 missioncoords       = vector3(1332.8604736328125, -2274.394287109375, 49.31209945678711), 
			 bountycoords		 = vector4(1321.2110595703125, -2285.886962890625, 50.55527877807617, -49.58), 
			 deliverycoords      = vector3(1353.1360, -1305.7720, 76.9504), -- RHODES SHERIFF OFFICE 
			 musicenabled        = true, 
			 music               = "BOU1_START", 
			 EnnemiesCooldown    = 30,
			 EnnemyPedModel      = "mp_g_m_o_uniexconfeds_01", -- ENEMY REINFORCEMENT WAVE PED MODEL 
			 ChanceOfSpawn       = 100,
			 NumberOfEnnemiesMin = 3,
			 NumberOfEnnemiesMax = 4,
			 aliveshortreward    = 30, 
			 alivelongreward     = 120, 
			 aliveshortxp        = 20, 
			 alivelongxp         = 120,
			 deadshortreward     = 30, 		 
			 deadlongreward      = 120,
			 deadshortxp         = 10,			 
			 deadlongxp          = 30, 
	 },
	 
    [7]  = { name                = 'Bounty Target',  
			 model               = "mp_u_m_m_bountytarget_009", 
			 bountyscenario      = "WORLD_HUMAN_SMOKE",
			 CountdownEnabled    = true,
			 CountdownTimer      = 20,
			 missionnetworked    = true,
			 enemies             = {
			 [1] = {model = "mp_g_m_o_uniexconfeds_01", weapon = "weapon_revolver_cattleman", coords = vector4(1584.273193359375, -1852.87255859375, 52.35340881347656, 158.0),   scenario = "MP_COOP_LOBBY_STANDING_A" },
			 [2] = {model = "mp_g_m_o_uniexconfeds_01", weapon = "weapon_repeater_carbine",   coords = vector4(1582.6646728515625, -1850.596923828125, 52.35340881347656, 70.33), scenario = "MP_COOP_LOBBY_STANDING_B" },
			 [3] = {model = "mp_g_m_o_uniexconfeds_01", weapon = "weapon_repeater_carbine",   coords = vector4(1551.092041015625, -1843.843994140625, 51.44508743286133, 70.33),  scenario = "WORLD_HUMAN_SMOKE" },
			 },
			 district            = "district_scarlett_meadows", --This mission will have a chance to trigger if the player is in this district when starting the mission. 
			 missioncoords       = vector3(1588.0926513671875, -1845.0120849609375, 52.35340881347656), 
			 bountycoords		 = vector4(1584.8070068359375, -1850.1644287109375, 52.35340881347656, -49.58), 
			 deliverycoords      = vector3(1353.1360, -1305.7720, 76.9504), -- RHODES SHERIFF OFFICE 
			 musicenabled        = true, 
			 music               = "BOU1_START", 
			 EnnemiesCooldown    = 30,
			 EnnemyPedModel      = "mp_g_m_o_uniexconfeds_01", -- ENEMY REINFORCEMENT WAVE PED MODEL 
			 ChanceOfSpawn       = 100,
			 NumberOfEnnemiesMin = 3,
			 NumberOfEnnemiesMax = 4,
			 aliveshortreward    = 30, 
			 alivelongreward     = 120, 
			 aliveshortxp        = 20, 
			 alivelongxp         = 120,
			 deadshortreward     = 30, 		 
			 deadlongreward      = 120,
			 deadshortxp         = 10,			 
			 deadlongxp          = 30, 
	 },	 
 
 
 
     [8]  = { name                = 'Bounty Target',  
			 model               = "mp_u_m_m_bountytarget_010", 
			 bountyscenario      = "WORLD_HUMAN_SMOKE",
			 CountdownEnabled    = true,
			 CountdownTimer      = 20,
			 missionnetworked    = true,
			 enemies             = {
			 [1] = {model = "mp_g_m_o_uniexconfeds_01", weapon = "weapon_revolver_cattleman", coords = vector4(980.2171630859375, -2008.4443359375, 46.52038192749023, 0.0),   scenario = "MP_COOP_LOBBY_STANDING_A" },
			 [2] = {model = "mp_g_m_o_uniexconfeds_01", weapon = "weapon_repeater_carbine",   coords = vector4(968.5087890625, -2011.3614501953125, 46.20207595825195, 88.0), scenario = "MP_COOP_LOBBY_STANDING_B" },
			 [3] = {model = "mp_g_m_o_uniexconfeds_01", weapon = "weapon_repeater_carbine",   coords = vector4(991.27978515625, -2011.49755859375, 47.28174209594726, -95.0),  scenario = "WORLD_HUMAN_SMOKE" },
			 },
			 district            = "district_scarlett_meadows", --This mission will have a chance to trigger if the player is in this district when starting the mission. 
			 missioncoords       = vector3(966.5847778320312, -2034.6014404296875, 46.04523468017578), 
			 bountycoords		 = vector4(976.7705078125, -2025.8983154296875, 48.84508895874023, -49.58), 
			 deliverycoords      = vector3(1353.1360, -1305.7720, 76.9504), -- RHODES SHERIFF OFFICE 
			 musicenabled        = true, 
			 music               = "BOU1_START", 
			 EnnemiesCooldown    = 30,
			 EnnemyPedModel      = "mp_g_m_o_uniexconfeds_01", -- ENEMY REINFORCEMENT WAVE PED MODEL 
			 ChanceOfSpawn       = 100,
			 NumberOfEnnemiesMin = 3,
			 NumberOfEnnemiesMax = 4,
			 aliveshortreward    = 30, 
			 alivelongreward     = 120, 
			 aliveshortxp        = 20, 
			 alivelongxp         = 120,
			 deadshortreward     = 30, 		 
			 deadlongreward      = 120,
			 deadshortxp         = 10,			 
			 deadlongxp          = 30, 
	 },	 
 
 
      [9]  = { name               = 'Bounty Target',  
			 model               = "mp_u_m_m_bountytarget_011", 
			 bountyscenario      = "WORLD_HUMAN_SMOKE",
			 CountdownEnabled    = true,
			 CountdownTimer      = 20,
			 missionnetworked    = true,
			 enemies             = {
			 [1] = {model = "mp_g_m_o_uniexconfeds_01", weapon = "weapon_revolver_cattleman", coords = vector4(1408.093505859375, -1876.153076171875, 58.27328109741211, -22.0),   scenario = "MP_COOP_LOBBY_STANDING_A" },
			 [2] = {model = "mp_g_m_o_uniexconfeds_01", weapon = "weapon_repeater_carbine",   coords = vector4(1423.7384033203125, -1888.512939453125, 54.4757080078125, -116.08), scenario = "MP_COOP_LOBBY_STANDING_B" },
			 [3] = {model = "mp_g_m_o_uniexconfeds_01", weapon = "weapon_repeater_carbine",   coords = vector4(1427.567626953125, -1878.3052978515625, 56.15375137329101, -60.33),  scenario = "WORLD_HUMAN_SMOKE" },
			 },
			 district            = "district_scarlett_meadows", --This mission will have a chance to trigger if the player is in this district when starting the mission. 
			 missioncoords       = vector3(1394.279296875, -1889.038818359375, 54.40170669555664), 
			 bountycoords		 = vector4(1394.279296875, -1889.038818359375, 54.40170669555664, -101.0), 
			 deliverycoords      = vector3(1353.1360, -1305.7720, 76.9504), -- RHODES SHERIFF OFFICE 
			 musicenabled        = true, 
			 music               = "BOU1_START", 
			 EnnemiesCooldown    = 30,
			 EnnemyPedModel      = "mp_g_m_o_uniexconfeds_01", -- ENEMY REINFORCEMENT WAVE PED MODEL 
			 ChanceOfSpawn       = 100,
			 NumberOfEnnemiesMin = 3,
			 NumberOfEnnemiesMax = 4,
			 aliveshortreward    = 30, 
			 alivelongreward     = 120, 
			 aliveshortxp        = 20, 
			 alivelongxp         = 120,
			 deadshortreward     = 30, 		 
			 deadlongreward      = 120,
			 deadshortxp         = 10,			 
			 deadlongxp          = 30, 
	 },	 
 
 
       [10]  = { name               = 'Bounty Target',  
			 model               = "mp_u_m_m_bountytarget_012", 
			 bountyscenario      = "WORLD_HUMAN_SMOKE",
			 CountdownEnabled    = true,
			 CountdownTimer      = 20,
			 missionnetworked    = true,
			 enemies             = {
			 [1] = {model = "mp_g_m_o_uniexconfeds_01", weapon = "weapon_revolver_cattleman", coords = vector4(1229.734375, -548.3810424804688, 68.54720306396484, 162.0),   scenario = "MP_COOP_LOBBY_STANDING_A" },
			 [2] = {model = "mp_g_m_o_uniexconfeds_01", weapon = "weapon_repeater_carbine",   coords = vector4(1222.371826171875, -568.7450561523438, 68.09954071044922, 86.08), scenario = "MP_COOP_LOBBY_STANDING_B" },
			 [3] = {model = "mp_g_m_o_uniexconfeds_01", weapon = "weapon_repeater_carbine",   coords = vector4(1207.59423828125, -593.8981323242188, 69.50665283203125, 59.0),  scenario = "WORLD_HUMAN_SMOKE" },
			 },
			 district            = "district_scarlett_meadows", --This mission will have a chance to trigger if the player is in this district when starting the mission. 
			 missioncoords       = vector3(1212.60400390625, -547.2745361328125, 70.60490417480469), 
			 bountycoords		 = vector4(1220.3951416015625, -541.5182495117188, 70.50072479248047, -85.0), 
			 deliverycoords      = vector3(1353.1360, -1305.7720, 76.9504), -- RHODES SHERIFF OFFICE 
			 musicenabled        = true, 
			 music               = "BOU1_START", 
			 EnnemiesCooldown    = 30,
			 EnnemyPedModel      = "mp_g_m_o_uniexconfeds_01", -- ENEMY REINFORCEMENT WAVE PED MODEL 
			 ChanceOfSpawn       = 100,
			 NumberOfEnnemiesMin = 3,
			 NumberOfEnnemiesMax = 4,
			 aliveshortreward    = 30, 
			 alivelongreward     = 120, 
			 aliveshortxp        = 20, 
			 alivelongxp         = 120,
			 deadshortreward     = 30, 		 
			 deadlongreward      = 120,
			 deadshortxp         = 10,			 
			 deadlongxp          = 30, 
	 },	 
 
 
 
 
 
 

 -- BAYOU NWA 
 
     [11]  = { name               = 'Bounty Target',  
			 model               = "mp_u_m_m_bountytarget_013", 
			 bountyscenario      = "WORLD_HUMAN_SMOKE",
			 CountdownEnabled    = true,
			 CountdownTimer      = 20,
			 missionnetworked    = true,
			 enemies             = {
			 [1] = {model = "mp_g_m_m_animalpoachers_01", weapon = "weapon_revolver_cattleman", coords = vector4(2264.6650390625, -765.8732299804688, 42.54679489135742, -151.0),   scenario = "MP_COOP_LOBBY_STANDING_A" },
			 [2] = {model = "mp_g_m_m_animalpoachers_01", weapon = "weapon_repeater_carbine",   coords = vector4(2269.260986328125, -766.81689453125, 42.21006393432617, 110.08), scenario = "MP_COOP_LOBBY_STANDING_B" },
			 [3] = {model = "mp_g_m_m_animalpoachers_01", weapon = "weapon_repeater_carbine",   coords = vector4(2267.931640625, -769.5584106445312, 42.28520584106445, 70.33),  scenario = "WORLD_HUMAN_SMOKE" },
			 },
			 district            = "district_bayou_nwa", --This mission will have a chance to trigger if the player is in this district when starting the mission. 
			 missioncoords       = vector3(2258.81103515625, -773.2982177734375, 42.92933654785156), 
			 bountycoords		 = vector4(2232.740234375, -773.3809204101562, 43.52445983886719, -101.0), 
			 deliverycoords      = vector3(2514.4475, -1320.5682, 48.5776), -- SAINT DENIS SHERIFF OFFICE 
			 musicenabled        = true, 
			 music               = "BOU1_START", 
			 EnnemiesCooldown    = 30,
			 EnnemyPedModel      = "mp_g_m_m_animalpoachers_01", -- ENEMY REINFORCEMENT WAVE PED MODEL 
			 ChanceOfSpawn       = 100,
			 NumberOfEnnemiesMin = 3,
			 NumberOfEnnemiesMax = 4,
			 aliveshortreward    = 30, 
			 alivelongreward     = 120, 
			 aliveshortxp        = 20, 
			 alivelongxp         = 120,
			 deadshortreward     = 30, 		 
			 deadlongreward      = 120,
			 deadshortxp         = 10,			 
			 deadlongxp          = 30, 
	 },	 
 
 
 
     [12]  = { name               = 'Bounty Target',  
			 model               = "mp_u_m_m_bountytarget_014", 
			 bountyscenario      = "WORLD_HUMAN_SMOKE",
			 CountdownEnabled    = true,
			 CountdownTimer      = 20,
			 missionnetworked    = true,
			 enemies             = {
			 [1] = {model = "mp_g_m_m_animalpoachers_01", weapon = "weapon_revolver_cattleman", coords = vector4(1891.9482421875, -761.1203002929688, 42.06461715698242, -174.0),   scenario = "MP_COOP_LOBBY_STANDING_A" },
			 [2] = {model = "mp_g_m_m_animalpoachers_01", weapon = "weapon_repeater_carbine",   coords = vector4(1911.7232666015625, -743.6522827148438, 43.61599731445312, -68.0), scenario = "MP_COOP_LOBBY_STANDING_B" },
			 [3] = {model = "mp_g_m_m_animalpoachers_01", weapon = "weapon_repeater_carbine",   coords = vector4(1895.03515625, -704.4154663085938, 42.24267959594726, 0.0),  scenario = "WORLD_HUMAN_SMOKE" },
			 },
			 district            = "district_bayou_nwa", --This mission will have a chance to trigger if the player is in this district when starting the mission. 
			 missioncoords       = vector3(1888.6529541015625, -748.291259765625, 41.801025390625), 
			 bountycoords		 = vector4(1878.3973388671875, -735.265625, 42.55817794799805, -111.0), 
			 deliverycoords      = vector3(2514.4475, -1320.5682, 48.5776), -- SAINT DENIS SHERIFF OFFICE 
			 musicenabled        = true, 
			 music               = "BOU1_START", 
			 EnnemiesCooldown    = 30,
			 EnnemyPedModel      = "mp_g_m_m_animalpoachers_01", -- ENEMY REINFORCEMENT WAVE PED MODEL 
			 ChanceOfSpawn       = 100,
			 NumberOfEnnemiesMin = 3,
			 NumberOfEnnemiesMax = 4,
			 aliveshortreward    = 30, 
			 alivelongreward     = 120, 
			 aliveshortxp        = 20, 
			 alivelongxp         = 120,
			 deadshortreward     = 30, 		 
			 deadlongreward      = 120,
			 deadshortxp         = 10,			 
			 deadlongxp          = 30, 
	 },	  
	 
 
     [13]  = { name               = 'Bounty Target',  
			 model               = "mp_u_m_m_bountytarget_015", 
			 bountyscenario      = "WORLD_HUMAN_SMOKE",
			 CountdownEnabled    = true,
			 CountdownTimer      = 20,
			 missionnetworked    = true,
			 enemies             = {
			 [1] = {model = "mp_g_m_m_animalpoachers_01", weapon = "weapon_revolver_cattleman", coords = vector4(1784.8792724609375, -808.5517578125, 42.53103637695312, 62.0),   scenario = "MP_COOP_LOBBY_STANDING_A" },
			 [2] = {model = "mp_g_m_m_animalpoachers_01", weapon = "weapon_repeater_carbine",   coords = vector4(1779.654052734375, -820.0050659179688, 42.714599609375, 157.0), scenario = "MP_COOP_LOBBY_STANDING_B" },
			 [3] = {model = "mp_g_m_m_animalpoachers_01", weapon = "weapon_repeater_carbine",   coords = vector4(1791.1297607421875, -827.7887573242188, 42.70098495483398, -122.0),  scenario = "WORLD_HUMAN_SMOKE" },
			 },
			 district            = "district_bayou_nwa", --This mission will have a chance to trigger if the player is in this district when starting the mission. 
			 missioncoords       = vector3(1791.620361328125, -825.01806640625, 42.58665466308594), 
			 bountycoords		 = vector4(1791.37255859375, -811.0012817382812, 42.63565444946289, -111.0), 
			 deliverycoords      = vector3(2514.4475, -1320.5682, 48.5776), -- SAINT DENIS SHERIFF OFFICE 
			 musicenabled        = true, 
			 music               = "BOU1_START", 
			 EnnemiesCooldown    = 30,
			 EnnemyPedModel      = "mp_g_m_m_animalpoachers_01", -- ENEMY REINFORCEMENT WAVE PED MODEL 
			 ChanceOfSpawn       = 100,
			 NumberOfEnnemiesMin = 3,
			 NumberOfEnnemiesMax = 4,
			 aliveshortreward    = 30, 
			 alivelongreward     = 120, 
			 aliveshortxp        = 20, 
			 alivelongxp         = 120,
			 deadshortreward     = 30, 		 
			 deadlongreward      = 120,
			 deadshortxp         = 10,			 
			 deadlongxp          = 30, 
	 },	  
 
     [14]  = { name               = 'Bounty Target',  
			 model               = "mp_u_m_m_bountytarget_016", 
			 bountyscenario      = "WORLD_HUMAN_SMOKE",
			 CountdownEnabled    = true,
			 CountdownTimer      = 20,
			 missionnetworked    = true,
			 enemies             = {
			 [1] = {model = "mp_g_m_m_animalpoachers_01", weapon = "weapon_revolver_cattleman", coords = vector4(2009.65478515625, -860.862060546875, 42.88164901733398, -144.0),   scenario = "MP_COOP_LOBBY_STANDING_A" },
			 [2] = {model = "mp_g_m_m_animalpoachers_01", weapon = "weapon_repeater_carbine",   coords = vector4(2017.767333984375, -839.5587158203125, 43.08549499511719, -52.0), scenario = "MP_COOP_LOBBY_STANDING_B" },
			 [3] = {model = "mp_g_m_m_animalpoachers_01", weapon = "weapon_repeater_carbine",   coords = vector4(2011.091796875, -826.8285522460938, 42.34523010253906, -7.0),  scenario = "WORLD_HUMAN_SMOKE" },
			 },
			 district            = "district_bayou_nwa", --This mission will have a chance to trigger if the player is in this district when starting the mission. 
			 missioncoords       = vector3(1997.2440185546875, -851.4971923828125, 42.62727355957031), 
			 bountycoords		 = vector4(1997.2440185546875, -851.4971923828125, 42.62727355957031, -111.0), 
			 deliverycoords      = vector3(2514.4475, -1320.5682, 48.5776), -- SAINT DENIS SHERIFF OFFICE 
			 musicenabled        = true, 
			 music               = "BOU1_START", 
			 EnnemiesCooldown    = 30,
			 EnnemyPedModel      = "mp_g_m_m_animalpoachers_01", -- ENEMY REINFORCEMENT WAVE PED MODEL 
			 ChanceOfSpawn       = 100,
			 NumberOfEnnemiesMin = 3,
			 NumberOfEnnemiesMax = 4,
			 aliveshortreward    = 30, 
			 alivelongreward     = 120, 
			 aliveshortxp        = 20, 
			 alivelongxp         = 120,
			 deadshortreward     = 30, 		 
			 deadlongreward      = 120,
			 deadshortxp         = 10,			 
			 deadlongxp          = 30, 
	 },	  
 	 	 
	 
	 
     [15]  = { name               = 'Bounty Target',  
			 model               = "mp_u_m_m_bountytarget_017", 
			 bountyscenario      = "WORLD_HUMAN_SMOKE",
			 CountdownEnabled    = true,
			 CountdownTimer      = 20,
			 missionnetworked    = true,
			 enemies             = {
			 [1] = {model = "mp_g_m_m_animalpoachers_01", weapon = "weapon_revolver_cattleman", coords = vector4(2026.7540283203125, -770.6776123046875, 42.50323486328125, -116.0),   scenario = "MP_COOP_LOBBY_STANDING_A" },
			 [2] = {model = "mp_g_m_m_animalpoachers_01", weapon = "weapon_repeater_carbine",   coords = vector4(2018.4112548828125, -784.2252197265625, 42.81750869750976, 161.0), scenario = "MP_COOP_LOBBY_STANDING_B" },
			 [3] = {model = "mp_g_m_m_animalpoachers_01", weapon = "weapon_repeater_carbine",   coords = vector4(2010.74853515625, -778.8842163085938, 42.61907958984375, 64.45),  scenario = "WORLD_HUMAN_SMOKE" },
			 },
			 district            = "district_bayou_nwa", --This mission will have a chance to trigger if the player is in this district when starting the mission. 
			 missioncoords       = vector3(2017.5445556640625, -772.0637817382812, 42.85274887084961), 
			 bountycoords		 = vector4(2017.5445556640625, -772.0637817382812, 42.85274887084961, -111.0), 
			 deliverycoords      = vector3(2514.4475, -1320.5682, 48.5776), -- SAINT DENIS SHERIFF OFFICE 
			 musicenabled        = true, 
			 music               = "BOU1_START", 
			 EnnemiesCooldown    = 30,
			 EnnemyPedModel      = "mp_g_m_m_animalpoachers_01", -- ENEMY REINFORCEMENT WAVE PED MODEL 
			 ChanceOfSpawn       = 100,
			 NumberOfEnnemiesMin = 3,
			 NumberOfEnnemiesMax = 4,
			 aliveshortreward    = 30, 
			 alivelongreward     = 120, 
			 aliveshortxp        = 20, 
			 alivelongxp         = 120,
			 deadshortreward     = 30, 		 
			 deadlongreward      = 120,
			 deadshortxp         = 10,			 
			 deadlongxp          = 30, 
	 },	  	 
 
 
  -- ROANOKE RIDGE 
  
     [16]  = { name               = 'Bounty Target',  
			 model               = "mp_u_m_m_bountytarget_018", 
			 bountyscenario      = "WORLD_HUMAN_SMOKE",
			 CountdownEnabled    = true,
			 CountdownTimer      = 20,
			 missionnetworked    = true,
			 
			 enemies             = {
			 [1] = {model = "g_m_m_unicriminals_01", weapon = "weapon_revolver_cattleman", coords = vector4(2285.942626953125, 1075.18994140625, 82.29084014892578, -151.0), scenario = "MP_COOP_LOBBY_STANDING_A" },
			 [2] = {model = "g_m_m_unicriminals_01", weapon = "weapon_repeater_carbine",   coords = vector4(2276.8779296875, 1061.8553466796875, 78.46512603759766, -85.08), scenario = "MP_COOP_LOBBY_STANDING_B" },
			 [3] = {model = "g_m_m_unicriminals_01", weapon = "weapon_repeater_carbine",   coords = vector4(2289.8486328125, 1049.783447265625, 79.00643157958984, -172.0),   scenario = "WORLD_HUMAN_SMOKE" },
			 },
			 
			 district            = "district_roanoke_ridge", --This mission will have a chance to trigger if the player is in this district when starting the mission. 
			 missioncoords       = vector3(2291.708251953125, 1066.409912109375, 81.34271240234375), 
			 bountycoords		 = vector4(2300.326171875, 1079.3570556640625, 85.91683197021484, 108.0), 
			 deliverycoords      = vector3(2914.2993, 1305.7046, 44.2610), -- ANNESBURG SHERIFF OFFICE 
			 musicenabled        = true, 
			 music               = "BOU1_START", 
			 EnnemiesCooldown    = 30,
			 EnnemyPedModel      = "g_m_m_unicriminals_01", -- ENEMY REINFORCEMENT WAVE PED MODEL 
			 ChanceOfSpawn       = 100,
			 NumberOfEnnemiesMin = 3,
			 NumberOfEnnemiesMax = 4,
			 aliveshortreward    = 30, 
			 alivelongreward     = 120, 
			 aliveshortxp        = 20, 
			 alivelongxp         = 120,
			 deadshortreward     = 30, 		 
			 deadlongreward      = 120,
			 deadshortxp         = 10,			 
			 deadlongxp          = 30, 
	 },	 
 
 
     [17]  = { name               = 'Bounty Target',  
			 model               = "mp_u_m_m_bountytarget_001", 
			 bountyscenario      = "WORLD_HUMAN_SMOKE",
			 CountdownEnabled    = true,
			 CountdownTimer      = 20,
			 missionnetworked    = true,
			 enemies             = {
			 [1] = {model = "g_m_m_unicriminals_01", weapon = "weapon_revolver_cattleman", coords = vector4(2278.017333984375, 1475.3905029296875, 83.09739685058594, -78.0),   scenario = "MP_COOP_LOBBY_STANDING_A" },
			 [2] = {model = "g_m_m_unicriminals_01", weapon = "weapon_repeater_carbine",   coords = vector4(2305.63330078125, 1470.963623046875, 83.1554946899414, -141.0), scenario = "MP_COOP_LOBBY_STANDING_B" },
			 [3] = {model = "g_m_m_unicriminals_01", weapon = "weapon_repeater_carbine",   coords = vector4(2308.63525390625, 1447.1002197265625, 83.42610168457031, -51.0),  scenario = "WORLD_HUMAN_SMOKE" },
			 },
			 district            = "district_roanoke_ridge", --This mission will have a chance to trigger if the player is in this district when starting the mission. 
			 missioncoords       = vector3(2356.778564453125, 1364.7886962890625, 106.13905334472656), 
			 bountycoords		 = vector4(2284.560791015625, 1454.9066162109375, 83.87967681884766, -46.0), 
			 deliverycoords      = vector3(2914.2993, 1305.7046, 44.2610), -- ANNESBURG SHERIFF OFFICE
			 musicenabled        = true, 
			 music               = "BOU1_START", 
			 EnnemiesCooldown    = 30,
			 EnnemyPedModel      = "g_m_m_unicriminals_01", -- ENEMY REINFORCEMENT WAVE PED MODEL 
			 ChanceOfSpawn       = 100,
			 NumberOfEnnemiesMin = 3,
			 NumberOfEnnemiesMax = 4,
			 aliveshortreward    = 30, 
			 alivelongreward     = 120, 
			 aliveshortxp        = 20, 
			 alivelongxp         = 120,
			 deadshortreward     = 30, 		 
			 deadlongreward      = 120,
			 deadshortxp         = 10,			 
			 deadlongxp          = 30, 
	 },	
	 
	

	
     [18]  = { name              = 'Bounty Target',  
			 model               = "mp_u_m_m_bountytarget_019", 
			 bountyscenario      = "WORLD_HUMAN_SMOKE",
			 CountdownEnabled    = true,
			 CountdownTimer      = 20,
			 missionnetworked    = true,
			 enemies             = {
			 [1] = {model = "g_m_m_unicriminals_01", weapon = "weapon_revolver_cattleman", coords = vector4(1603.271484375, 2187.8681640625, 323.10791015625, -120.0),         scenario = "MP_COOP_LOBBY_STANDING_A" },
			 [2] = {model = "g_m_m_unicriminals_01", weapon = "weapon_repeater_carbine",   coords = vector4(1586.1768798828125, 2185.592529296875, 323.71533203125, 127.0),    scenario = "MP_COOP_LOBBY_STANDING_B" },
			 [3] = {model = "g_m_m_unicriminals_01", weapon = "weapon_repeater_carbine",   coords = vector4(1577.2291259765625, 2196.2607421875, 324.12982177734375, 61.0), scenario = "WORLD_HUMAN_SMOKE" },
			 },
			 district            = "district_roanoke_ridge", --This mission will have a chance to trigger if the player is in this district when starting the mission. 
			 missioncoords       = vector3(1598.9471435546875, 2175.115478515625, 323.417236328125), 
			 bountycoords		 = vector4(1587.11865234375, 2193.334716796875, 324.3800048828125, -59.0), 
			 deliverycoords      = vector3(2914.2993, 1305.7046, 44.2610), -- ANNESBURG SHERIFF OFFICE
			 musicenabled        = true, 
			 music               = "BOU1_START", 
			 EnnemiesCooldown    = 30,
			 EnnemyPedModel      = "g_m_m_unicriminals_01", -- ENEMY REINFORCEMENT WAVE PED MODEL 
			 ChanceOfSpawn       = 100,
			 NumberOfEnnemiesMin = 3,
			 NumberOfEnnemiesMax = 4,
			 aliveshortreward    = 30, 
			 alivelongreward     = 120, 
			 aliveshortxp        = 20, 
			 alivelongxp         = 120,
			 deadshortreward     = 30, 		 
			 deadlongreward      = 120,
			 deadshortxp         = 10,			 
			 deadlongxp          = 30, 
	 },	 
	 
	 
	 
	 
	 
     [19]  = { name              = 'Bounty Target',  
			 model               = "mp_u_m_m_bountytarget_020", 
			 bountyscenario      = "WORLD_HUMAN_SMOKE",
			 CountdownEnabled    = true,
			 CountdownTimer      = 20,
			 missionnetworked    = true,
			 enemies             = {
			 [1] = {model = "g_m_m_unicriminals_01", weapon = "weapon_revolver_cattleman", coords = vector4(1212.548095703125, 1992.34814453125, 318.50537109375, -170.0),         scenario = "MP_COOP_LOBBY_STANDING_A" },
			 [2] = {model = "g_m_m_unicriminals_01", weapon = "weapon_repeater_carbine",   coords = vector4(1226.984619140625, 2000.4271240234375, 319.76300048828125, 127.0),    scenario = "MP_COOP_LOBBY_STANDING_B" },
			 [3] = {model = "g_m_m_unicriminals_01", weapon = "weapon_repeater_carbine",   coords = vector4(1220.1119384765625, 2029.05419921875, 321.88946533203125, 61.0), scenario = "WORLD_HUMAN_SMOKE" },
			 },
			 district            = "district_roanoke_ridge", --This mission will have a chance to trigger if the player is in this district when starting the mission. 
			 missioncoords       = vector3(1203.865966796875, 2007.4881591796875, 319.43365478515625), 
			 bountycoords		 = vector4(1203.865966796875, 2007.4881591796875, 319.43365478515625, -59.0), 
			 deliverycoords      = vector3(2914.2993, 1305.7046, 44.2610), -- ANNESBURG SHERIFF OFFICE
			 musicenabled        = true, 
			 music               = "BOU1_START", 
			 EnnemiesCooldown    = 30,
			 EnnemyPedModel      = "g_m_m_unicriminals_01", -- ENEMY REINFORCEMENT WAVE PED MODEL 
			 ChanceOfSpawn       = 100,
			 NumberOfEnnemiesMin = 3,
			 NumberOfEnnemiesMax = 4,
			 aliveshortreward    = 30, 
			 alivelongreward     = 120, 
			 aliveshortxp        = 20, 
			 alivelongxp         = 120,
			 deadshortreward     = 30, 		 
			 deadlongreward      = 120,
			 deadshortxp         = 10,			 
			 deadlongxp          = 30, 
	 },	 	 
	 
	 
	 
	 
     [20]  = { name               = 'Bounty Target',  
			 model               = "mp_u_m_m_bountytarget_021", 
			 bountyscenario      = "WORLD_HUMAN_SMOKE",
			 CountdownEnabled    = true,
			 CountdownTimer      = 20,
			 missionnetworked    = true,
			 enemies             = {
			 [1] = {model = "g_m_m_unicriminals_01", weapon = "weapon_revolver_cattleman", coords = vector4(2443.180419921875, 2101.992431640625, 172.85687255859375, 67.0),   scenario = "MP_COOP_LOBBY_STANDING_A" },
			 [2] = {model = "g_m_m_unicriminals_01", weapon = "weapon_repeater_carbine",   coords = vector4(2456.240966796875, 2104.7939453125, 172.63021850585938, -84.0),    scenario = "MP_COOP_LOBBY_STANDING_B" },
			 [3] = {model = "g_m_m_unicriminals_01", weapon = "weapon_repeater_carbine",   coords = vector4(2448.796875, 2089.02978515625, 172.80165100097656, 161.0),         scenario = "WORLD_HUMAN_SMOKE" },
			 },
			 district            = "district_roanoke_ridge", --This mission will have a chance to trigger if the player is in this district when starting the mission. 
			 missioncoords       = vector3(2451.189453125, 2116.884033203125, 172.20814514160156), 
			 bountycoords		 = vector4(2449.819580078125, 2099.127685546875, 173.27197265625, -59.0), 
			 deliverycoords      = vector3(2914.2993, 1305.7046, 44.2610), -- ANNESBURG SHERIFF OFFICE
			 musicenabled        = true, 
			 music               = "BOU1_START", 
			 EnnemiesCooldown    = 30,
			 EnnemyPedModel      = "g_m_m_unicriminals_01", -- ENEMY REINFORCEMENT WAVE PED MODEL 
			 ChanceOfSpawn       = 100,
			 NumberOfEnnemiesMin = 3,
			 NumberOfEnnemiesMax = 4,
			 aliveshortreward    = 30, 
			 alivelongreward     = 120, 
			 aliveshortxp        = 20, 
			 alivelongxp         = 120,
			 deadshortreward     = 30, 		 
			 deadlongreward      = 120,
			 deadshortxp         = 10,			 
			 deadlongxp          = 30, 
	 },	 	 
	 	 
	 
	 
  -- BIG VALLEY 	 
 
 
     [21]  = { name              = 'Bounty Target',  
			 model               = "mp_u_m_m_bountytarget_022", 
			 bountyscenario      = "WORLD_HUMAN_SMOKE",
			 CountdownEnabled    = true,
			 CountdownTimer      = 20,
			 missionnetworked    = true,
			 enemies             = {
			 [1] = {model = "g_m_m_unimountainmen_01", weapon = "weapon_revolver_cattleman", coords = vector4(-2700.30859375, -382.15130615234375, 149.59124755859375, -109.0), scenario = "MP_COOP_LOBBY_STANDING_A" },
			 [2] = {model = "g_m_m_unimountainmen_01", weapon = "weapon_repeater_carbine",   coords = vector4(-2716.218994140625, -393.7191162109375, 153.0091552734375, 154.0), scenario = "MP_COOP_LOBBY_STANDING_B" },
			 [3] = {model = "g_m_m_unimountainmen_01", weapon = "weapon_repeater_carbine",   coords = vector4(-2746.099365234375, -377.11041259765625, 151.0661163330078, -172.0),   scenario = "WORLD_HUMAN_SMOKE" },
			 },
			 district            = "district_big_valley", --This mission will have a chance to trigger if the player is in this district when starting the mission. 
			 missioncoords       = vector3(-2702.406494140625, -361.4646301269531, 148.871826171875), 
			 bountycoords		 = vector4(-2724.5498046875, -367.0191345214844, 149.3790740966797, 108.0), 
			 deliverycoords      = vector3(-1802.0546, -358.5252, 163.8671), -- STRAWBERRY SHERIFF OFFICE 
			 musicenabled        = true, 
			 music               = "BOU1_START", 
			 EnnemiesCooldown    = 30,
			 EnnemyPedModel      = "g_m_m_unimountainmen_01", -- ENEMY REINFORCEMENT WAVE PED MODEL 
			 ChanceOfSpawn       = 100,
			 NumberOfEnnemiesMin = 3,
			 NumberOfEnnemiesMax = 4,
			 aliveshortreward    = 30, 
			 alivelongreward     = 120, 
			 aliveshortxp        = 20, 
			 alivelongxp         = 120,
			 deadshortreward     = 30, 		 
			 deadlongreward      = 120,
			 deadshortxp         = 10,			 
			 deadlongxp          = 30, 
	 },	 
 
 
     [22]  = { name              = 'Bounty Target',  
			 model               = "mp_u_m_m_bountytarget_023", 
			 bountyscenario      = "WORLD_HUMAN_SMOKE",
			 CountdownEnabled    = true,
			 CountdownTimer      = 20,
			 missionnetworked    = true,
			 enemies             = {
			 [1] = {model = "g_m_m_unimountainmen_01", weapon = "weapon_revolver_cattleman", coords = vector4(-2746.503173828125, 137.52572631835938, 161.20285034179688, 168.0),   scenario = "MP_COOP_LOBBY_STANDING_A" },
			 [2] = {model = "g_m_m_unimountainmen_01", weapon = "weapon_repeater_carbine",   coords = vector4(-2726.563720703125, 189.0067138671875, 160.1929168701172, -12.0), scenario = "MP_COOP_LOBBY_STANDING_B" },
			 [3] = {model = "g_m_m_unimountainmen_01", weapon = "weapon_repeater_carbine",   coords = vector4(-2739.117431640625, 195.26870727539062, 162.13296508789062, 54.0),  scenario = "WORLD_HUMAN_SMOKE" },
			 },
			 district            = "district_big_valley", --This mission will have a chance to trigger if the player is in this district when starting the mission. 
			 missioncoords       = vector3(-2659.891357421875, 111.48251342773438, 166.0916748046875), 
			 bountycoords		 = vector4(-2730.4091796875, 159.32383728027344, 159.29461669921875, -46.0), 
			 deliverycoords      = vector3(-1802.0546, -358.5252, 163.8671), -- STRAWBERRY SHERIFF OFFICE 
			 musicenabled        = true, 
			 music               = "BOU1_START", 
			 EnnemiesCooldown    = 30,
			 EnnemyPedModel      = "g_m_m_unimountainmen_01", -- ENEMY REINFORCEMENT WAVE PED MODEL 
			 ChanceOfSpawn       = 100,
			 NumberOfEnnemiesMin = 3,
			 NumberOfEnnemiesMax = 4,
			 aliveshortreward    = 30, 
			 alivelongreward     = 120, 
			 aliveshortxp        = 20, 
			 alivelongxp         = 120,
			 deadshortreward     = 30, 		 
			 deadlongreward      = 120,
			 deadshortxp         = 10,			 
			 deadlongxp          = 30, 
	 },	 
	 
	 
	 
	 
     [23]  = { name              = 'Bounty Target',  
			 model               = "mp_u_m_m_bountytarget_024", 
			 bountyscenario      = "WORLD_HUMAN_SMOKE",
			 CountdownEnabled    = true,
			 CountdownTimer      = 20,
			 missionnetworked    = true,
			 enemies             = {
			 [1] = {model = "g_m_m_unimountainmen_01", weapon = "weapon_revolver_cattleman", coords = vector4(-2509.974853515625, 7.07417631149292, 177.03500366210938, -23.0),   scenario = "MP_COOP_LOBBY_STANDING_A" },
			 [2] = {model = "g_m_m_unimountainmen_01", weapon = "weapon_repeater_carbine",   coords = vector4(-2520.27294921875, 20.04145431518554, 175.7517852783203, 28.80), scenario = "MP_COOP_LOBBY_STANDING_B" },
			 [3] = {model = "g_m_m_unimountainmen_01", weapon = "weapon_repeater_carbine",   coords = vector4(-2532.532958984375, 21.71774673461914, 173.41184997558594, 54.0),  scenario = "WORLD_HUMAN_SMOKE" },
			 [4] = {model = "g_m_m_unimountainmen_01", weapon = "weapon_repeater_carbine",   coords = vector4(-2542.67822265625, 31.11196517944336, 172.63534545898438, 54.0),  scenario = "WORLD_HUMAN_SMOKE" },
			 [5] = {model = "g_m_m_unimountainmen_01", weapon = "weapon_repeater_carbine",   coords = vector4(-2560.698486328125, 0.94588077068328, 166.1030731201172, 110.0),  scenario = "WORLD_HUMAN_SMOKE" },
			 },
			 district            = "district_big_valley", --This mission will have a chance to trigger if the player is in this district when starting the mission. 
			 missioncoords       = vector3(-2534.046875, -5.98617696762085, 171.6216278076172), 
			 bountycoords		 = vector4(-2514.488525390625, -1.45730102062225, 175.5252227783203, -95.0), 
			 deliverycoords      = vector3(-1802.0546, -358.5252, 163.8671), -- STRAWBERRY SHERIFF OFFICE 
			 musicenabled        = true, 
			 music               = "BOU1_START", 
			 EnnemiesCooldown    = 30,
			 EnnemyPedModel      = "g_m_m_unimountainmen_01", -- ENEMY REINFORCEMENT WAVE PED MODEL 
			 ChanceOfSpawn       = 100,
			 NumberOfEnnemiesMin = 3,
			 NumberOfEnnemiesMax = 4,
			 aliveshortreward    = 30, 
			 alivelongreward     = 120, 
			 aliveshortxp        = 20, 
			 alivelongxp         = 120,
			 deadshortreward     = 30, 		 
			 deadlongreward      = 120,
			 deadshortxp         = 10,			 
			 deadlongxp          = 30, 
	 },	 
	 	 


     [24]  = { name              = 'Bounty Target',  
			 model               = "mp_u_m_m_bountytarget_025", 
			 bountyscenario      = "WORLD_HUMAN_SMOKE",
			 CountdownEnabled    = true,
			 CountdownTimer      = 20,
			 missionnetworked    = true,
			 enemies             = {
			 [1] = {model = "mp_g_m_m_animalpoachers_01", weapon = "weapon_revolver_cattleman", coords = vector4(-2794.841796875, 22.1733169555664, 159.73788452148438, 166.0),   scenario = "MP_COOP_LOBBY_STANDING_A" },
			 [2] = {model = "mp_g_m_m_animalpoachers_01", weapon = "weapon_repeater_carbine",   coords = vector4(-2781.484375, 8.97226047515869, 156.29539489746094, 28.80), scenario = "MP_COOP_LOBBY_STANDING_B" },
			 [3] = {model = "mp_g_m_m_animalpoachers_01", weapon = "weapon_repeater_carbine",   coords = vector4(-2766.168701171875, 17.43910980224609, 157.41978454589844, 54.0),  scenario = "WORLD_HUMAN_SMOKE" },
			 [4] = {model = "mp_g_m_m_animalpoachers_01", weapon = "weapon_repeater_carbine",   coords = vector4(-2766.6162109375, 35.62194061279297, 160.01426696777344, 54.0),  scenario = "WORLD_HUMAN_SMOKE" },
			 },
			 district            = "district_big_valley", --This mission will have a chance to trigger if the player is in this district when starting the mission. 
			 missioncoords       = vector3(-2790.199462890625, 33.29621124267578, 160.67123413085938), 
			 bountycoords		 = vector4(-2790.199462890625, 33.29621124267578, 160.67123413085938, 0.0), 
			 deliverycoords      = vector3(-1802.0546, -358.5252, 163.8671), -- STRAWBERRY SHERIFF OFFICE 
			 musicenabled        = true, 
			 music               = "BOU1_START", 
			 EnnemiesCooldown    = 30,
			 EnnemyPedModel      = "g_m_m_unimountainmen_01", -- ENEMY REINFORCEMENT WAVE PED MODEL 
			 ChanceOfSpawn       = 100,
			 NumberOfEnnemiesMin = 3,
			 NumberOfEnnemiesMax = 4,
			 aliveshortreward    = 30, 
			 alivelongreward     = 120, 
			 aliveshortxp        = 20, 
			 alivelongxp         = 120,
			 deadshortreward     = 30, 		 
			 deadlongreward      = 120,
			 deadshortxp         = 10,			 
			 deadlongxp          = 30, 
	 },	 	 
	 
	 
	 
	 
      [25]  = { name             = 'Bounty Target',  
			 model               = "mp_u_m_m_bountytarget_026", 
			 bountyscenario      = "WORLD_HUMAN_SMOKE",
			 CountdownEnabled    = true,
			 CountdownTimer      = 20,
			 missionnetworked    = true,
			 enemies             = {
			 [1] = {model = "mp_g_m_m_animalpoachers_01", weapon = "weapon_revolver_cattleman", coords = vector4(-1888.0908203125, 1323.50048828125, 199.61602783203125, 146.0),   scenario = "MP_COOP_LOBBY_STANDING_A" },
			 [2] = {model = "mp_g_m_m_animalpoachers_01", weapon = "weapon_repeater_carbine",   coords = vector4(-1878.995849609375, 1322.089111328125, 201.43899536132812, 25.3), scenario = "MP_COOP_LOBBY_STANDING_B" },
			 [3] = {model = "mp_g_m_m_animalpoachers_01", weapon = "weapon_repeater_carbine",   coords = vector4(-1879.4736328125, 1328.7880859375, 202.21316528320312, 86.0),  scenario = "WORLD_HUMAN_SMOKE" },
			 [4] = {model = "mp_g_m_m_animalpoachers_01", weapon = "weapon_repeater_carbine",   coords = vector4(-1887.4171142578125, 1351.479248046875, 203.27218627929688, 157.0),  scenario = "WORLD_HUMAN_SMOKE" },
			 },
			 district            = "district_big_valley", --This mission will have a chance to trigger if the player is in this district when starting the mission. 
			 missioncoords       = vector3(-1893.785400390625, 1341.0377197265625, 200.7223358154297), 
			 bountycoords		 = vector4(-1896.358642578125, 1333.606689453125, 200.0970916748047, 0.0), 
			 deliverycoords      = vector3(-1802.0546, -358.5252, 163.8671), -- STRAWBERRY SHERIFF OFFICE 
			 musicenabled        = true, 
			 music               = "BOU1_START", 
			 EnnemiesCooldown    = 30,
			 EnnemyPedModel      = "g_m_m_unimountainmen_01", -- ENEMY REINFORCEMENT WAVE PED MODEL 
			 ChanceOfSpawn       = 100,
			 NumberOfEnnemiesMin = 3,
			 NumberOfEnnemiesMax = 4,
			 aliveshortreward    = 30, 
			 alivelongreward     = 120, 
			 aliveshortxp        = 20, 
			 alivelongxp         = 120,
			 deadshortreward     = 30, 		 
			 deadlongreward      = 120,
			 deadshortxp         = 10,			 
			 deadlongxp          = 30, 
	 },	 	
	 
	 
 
   -- GREAT PLAINS 
 
     [26]  = { name              = 'Bounty Target',  
			 model               = "mp_u_m_m_bountytarget_027", 
			 bountyscenario      = "WORLD_HUMAN_SMOKE",
			 CountdownEnabled    = true,
			 CountdownTimer      = 20,
			 missionnetworked    = true,
			 enemies             = {
			 [1] = {model = "g_m_m_unimountainmen_01", weapon = "weapon_revolver_cattleman", coords = vector4(-1184.91845703125, -1953.669921875, 42.69272232055664, -28.0), scenario = "MP_COOP_LOBBY_STANDING_A" },
			 [2] = {model = "g_m_m_unimountainmen_01", weapon = "weapon_repeater_carbine",   coords = vector4(-1161.4046630859375, -1930.1407470703125, 42.40768051147461, -123.0), scenario = "MP_COOP_LOBBY_STANDING_B" },
			 [3] = {model = "g_m_m_unimountainmen_01", weapon = "weapon_repeater_carbine",   coords = vector4(-1182.9822998046875, -1966.0982666015625, 42.4338264465332, 150.0),   scenario = "WORLD_HUMAN_SMOKE" },
			 },
			 
			 district            = "district_great_plains", --This mission will have a chance to trigger if the player is in this district when starting the mission. 
			 missioncoords       = vector3(-1207.6617431640625, -1934.629638671875, 43.12089157104492), 
			 bountycoords		 = vector4(-1200.1085205078125, -1939.36083984375, 43.60062408447265, 108.0), 
			 deliverycoords      = vector3(-767.1304, -1259.6434, 43.5832), -- BLACKWATER SHERIFF OFFICE 
			 musicenabled        = true, 
			 music               = "BOU1_START", 
			 EnnemiesCooldown    = 30,
			 EnnemyPedModel      = "g_m_m_unimountainmen_01", -- ENEMY REINFORCEMENT WAVE PED MODEL 
			 ChanceOfSpawn       = 100,
			 NumberOfEnnemiesMin = 3,
			 NumberOfEnnemiesMax = 4,
			 aliveshortreward    = 30, 
			 alivelongreward     = 120, 
			 aliveshortxp        = 20, 
			 alivelongxp         = 120,
			 deadshortreward     = 30, 		 
			 deadlongreward      = 120,
			 deadshortxp         = 10,			 
			 deadlongxp          = 30, 
	 },	 
 
 
     [27]  = { name              = 'Bounty Target',  
			 model               = "mp_u_m_m_bountytarget_028", 
			 bountyscenario      = "WORLD_HUMAN_SMOKE",
			 CountdownEnabled    = true,
			 CountdownTimer      = 20,
			 missionnetworked    = true,
			 enemies             = {
			 [1] = {model = "g_m_m_unimountainmen_01", weapon = "weapon_revolver_cattleman", coords = vector4(-2576.174072265625, -1406.9583740234375, 145.8245086669922, 168.0),   scenario = "MP_COOP_LOBBY_STANDING_A" },
			 [2] = {model = "g_m_m_unimountainmen_01", weapon = "weapon_repeater_carbine",   coords = vector4(-2574.39892578125, -1376.1251220703125, 149.28375244140625, -67.0),   scenario = "MP_COOP_LOBBY_STANDING_B" },
			 [3] = {model = "g_m_m_unimountainmen_01", weapon = "weapon_repeater_carbine",   coords = vector4(-2607.044921875, -1366.07568359375, 153.2540283203125, -54.0),        scenario = "WORLD_HUMAN_SMOKE" },
			 },
			 district            = "district_great_plains", --This mission will have a chance to trigger if the player is in this district when starting the mission. 
			 missioncoords       = vector3(-2555.46728515625, -1370.1424560546875, 151.0469512939453), 
			 bountycoords		 = vector4(-2578.623291015625, -1382.657470703125, 149.25469970703125, -46.0), 
			 deliverycoords      = vector3(-767.1304, -1259.6434, 43.5832), -- BLACKWATER SHERIFF OFFICE 
			 musicenabled        = true, 
			 music               = "BOU1_START", 
			 EnnemiesCooldown    = 30,
			 EnnemyPedModel      = "g_m_m_unimountainmen_01", -- ENEMY REINFORCEMENT WAVE PED MODEL 
			 ChanceOfSpawn       = 100,
			 NumberOfEnnemiesMin = 3,
			 NumberOfEnnemiesMax = 4,
			 aliveshortreward    = 30, 
			 alivelongreward     = 120, 
			 aliveshortxp        = 20, 
			 alivelongxp         = 120,
			 deadshortreward     = 30, 		 
			 deadlongreward      = 120,
			 deadshortxp         = 10,			 
			 deadlongxp          = 30, 
	 },	 



      [28]  = { name              = 'Bounty Target',  
			 model               = "mp_u_m_m_bountytarget_029", 
			 bountyscenario      = "WORLD_HUMAN_SMOKE",
			 CountdownEnabled    = true,
			 CountdownTimer      = 20,
			 missionnetworked    = true,
			 enemies             = {
			 [1] = {model = "mp_g_m_m_animalpoachers_01", weapon = "weapon_revolver_cattleman", coords = vector4(-1865.7825927734375, -1196.5841064453125, 73.94335174560547, 0.0), scenario = "MP_COOP_LOBBY_STANDING_A" },
			 [2] = {model = "mp_g_m_m_animalpoachers_01", weapon = "weapon_repeater_carbine",   coords = vector4(-1892.1141357421875, -1195.5885009765625, 74.28242492675781, 55.0), scenario = "MP_COOP_LOBBY_STANDING_B" },
			 [3] = {model = "mp_g_m_m_animalpoachers_01", weapon = "weapon_repeater_carbine",   coords = vector4(-1896.993896484375, -1209.2425537109375, 79.06520080566406,  135.0), scenario = "WORLD_HUMAN_SMOKE" },
			 [4] = {model = "mp_g_m_m_animalpoachers_01", weapon = "weapon_repeater_carbine",   coords = vector4(-1892.2088623046875, -1221.6993408203125, 81.96515655517578, -110.0), scenario = "WORLD_HUMAN_SMOKE" },
			 [5] = {model = "mp_g_m_m_animalpoachers_01", weapon = "weapon_repeater_carbine",   coords = vector4(-1870.8797607421875, -1213.4803466796875, 80.04960632324219,  -94.0), scenario = "WORLD_HUMAN_SMOKE" },
			 },
			 
			 district            = "district_great_plains", --This mission will have a chance to trigger if the player is in this district when starting the mission. 
			 missioncoords       = vector3(-1867.728271484375, -1193.030517578125, 73.70655059814453), 
			 bountycoords		 = vector4(-1873.0765380859375, -1203.0308837890625, 74.5974349975586, 5.0), 
			 deliverycoords      = vector3(-767.1304, -1259.6434, 43.5832), -- BLACKWATER SHERIFF OFFICE 
			 musicenabled        = true, 
			 music               = "BOU1_START", 
			 EnnemiesCooldown    = 30,
			 EnnemyPedModel      = "g_m_m_unimountainmen_01", -- ENEMY REINFORCEMENT WAVE PED MODEL 
			 ChanceOfSpawn       = 100,
			 NumberOfEnnemiesMin = 3,
			 NumberOfEnnemiesMax = 4,
			 aliveshortreward    = 30, 
			 alivelongreward     = 120, 
			 aliveshortxp        = 20, 
			 alivelongxp         = 120,
			 deadshortreward     = 30, 		 
			 deadlongreward      = 120,
			 deadshortxp         = 10,			 
			 deadlongxp          = 30, 
	 },	 



      [29]  = { name              = 'Bounty Target',  
			 model               = "mp_u_m_m_bountytarget_030", 
			 bountyscenario      = "WORLD_HUMAN_SMOKE",
			 CountdownEnabled    = true,
			 CountdownTimer      = 20,
			 missionnetworked    = true,
			 enemies             = {
			 [1] = {model = "mp_g_m_m_animalpoachers_01", weapon = "weapon_revolver_cattleman", coords = vector4(-1954.3472900390625, -997.52734375, 95.20586395263672, 0.0), scenario = "MP_COOP_LOBBY_STANDING_A" },
			 [2] = {model = "mp_g_m_m_animalpoachers_01", weapon = "weapon_repeater_carbine",   coords = vector4(-1952.21142578125, -985.267333984375, 99.42821502685547, 55.0), scenario = "MP_COOP_LOBBY_STANDING_B" },
			 [3] = {model = "mp_g_m_m_animalpoachers_01", weapon = "weapon_repeater_carbine",   coords = vector4(-1939.1376953125, -973.4066162109375, 101.84318542480469, 0.0), scenario = "WORLD_HUMAN_SMOKE" },
			 [4] = {model = "mp_g_m_m_animalpoachers_01", weapon = "weapon_repeater_carbine",   coords = vector4(-1920.0960693359375, -975.701904296875, 102.67953491210938, -90.0), scenario = "WORLD_HUMAN_SMOKE" },
			 [5] = {model = "mp_g_m_m_animalpoachers_01", weapon = "weapon_repeater_carbine",   coords = vector4(-1921.7564697265625, -991.599365234375, 99.76557159423828, -143.0), scenario = "WORLD_HUMAN_SMOKE" },
			 },
			 
			 district            = "district_great_plains", --This mission will have a chance to trigger if the player is in this district when starting the mission. 
			 missioncoords       = vector3(-1941.91259765625, -997.5667724609375, 95.18051147460938), 
			 bountycoords		 = vector4(-1941.91259765625, -997.5667724609375, 95.18051147460938, 34.0), 
			 deliverycoords      = vector3(-767.1304, -1259.6434, 43.5832), -- BLACKWATER SHERIFF OFFICE 
			 musicenabled        = true, 
			 music               = "BOU1_START", 
			 EnnemiesCooldown    = 30,
			 EnnemyPedModel      = "g_m_m_unimountainmen_01", -- ENEMY REINFORCEMENT WAVE PED MODEL 
			 ChanceOfSpawn       = 100,
			 NumberOfEnnemiesMin = 3,
			 NumberOfEnnemiesMax = 4,
			 aliveshortreward    = 30, 
			 alivelongreward     = 120, 
			 aliveshortxp        = 20, 
			 alivelongxp         = 120,
			 deadshortreward     = 30, 		 
			 deadlongreward      = 120,
			 deadshortxp         = 10,			 
			 deadlongxp          = 30, 
	 },	 
 
 
 
  
      [30]  = { name             = 'Bounty Target',  
			 model               = "mp_u_m_m_bountytarget_031", 
			 bountyscenario      = "WORLD_HUMAN_SMOKE",
			 CountdownEnabled    = true,
			 CountdownTimer      = 20,
			 missionnetworked    = true,
			 enemies             = {
			 [1] = {model = "mp_g_m_m_animalpoachers_01", weapon = "weapon_revolver_cattleman", coords = vector4(-2107.7158203125, -1275.1136474609375, 122.35409545898438, 149.61), scenario = "MP_COOP_LOBBY_STANDING_A" },
			 [2] = {model = "mp_g_m_m_animalpoachers_01", weapon = "weapon_repeater_carbine",   coords = vector4(-2091.552490234375, -1277.5616455078125, 120.14313507080078, -131.0), scenario = "MP_COOP_LOBBY_STANDING_B" },
			 [3] = {model = "mp_g_m_m_animalpoachers_01", weapon = "weapon_repeater_carbine",   coords = vector4(-2075.197998046875, -1258.6903076171875, 120.03639221191406,-81.0), scenario = "WORLD_HUMAN_SMOKE" },
			 [4] = {model = "mp_g_m_m_animalpoachers_01", weapon = "weapon_repeater_carbine",   coords = vector4(-2079.01953125, -1239.4427490234375, 123.07909393310547, 0.0), scenario = "WORLD_HUMAN_SMOKE" },
			 [5] = {model = "mp_g_m_m_animalpoachers_01", weapon = "weapon_repeater_carbine",   coords = vector4(-2107.388427734375, -1224.364501953125, 128.9998321533203, 34.0), scenario = "WORLD_HUMAN_SMOKE" },
			 },
			 
			 district            = "district_great_plains", --This mission will have a chance to trigger if the player is in this district when starting the mission. 
			 missioncoords       = vector3(-2093.843505859375, -1254.654541015625, 123.0613784790039), 
			 bountycoords		 = vector4(-2101.5244140625, -1266.35986328125, 123.11579132080078, 34.0), 
			 deliverycoords      = vector3(-767.1304, -1259.6434, 43.5832), -- BLACKWATER SHERIFF OFFICE 
			 musicenabled        = true, 
			 music               = "BOU1_START", 
			 EnnemiesCooldown    = 30,
			 EnnemyPedModel      = "g_m_m_unimountainmen_01", -- ENEMY REINFORCEMENT WAVE PED MODEL 
			 ChanceOfSpawn       = 100,
			 NumberOfEnnemiesMin = 3,
			 NumberOfEnnemiesMax = 4,
			 aliveshortreward    = 30, 
			 alivelongreward     = 120, 
			 aliveshortxp        = 20, 
			 alivelongxp         = 120,
			 deadshortreward     = 30, 		 
			 deadlongreward      = 120,
			 deadshortxp         = 10,			 
			 deadlongxp          = 30, 
	 },	 
 
 
 
 
 
 
 
	 
   -- CHOLLA SPRINGS 
 
 
     [31]  = { name                = 'Bounty Target',  
			   model               = "mp_u_m_m_bountytarget_032", 
			   bountyscenario      = "WORLD_HUMAN_SMOKE",
			   CountdownEnabled    = true,
			   CountdownTimer      = 20,
			   missionnetworked    = true,
			 
			 enemies             = {
			 [1] = {model = "mp_g_m_m_unibanditos_01", weapon = "weapon_revolver_cattleman", coords = vector4(-3955.954345703125, -2130.8271484375, -0.1409361064434, 144.0),     scenario = "MP_COOP_LOBBY_STANDING_A" },
			 [2] = {model = "mp_g_m_m_unibanditos_01", weapon = "weapon_repeater_carbine",   coords = vector4(-3969.888916015625, -2135.583740234375, -5.50292682647705, -172.0), scenario = "MP_COOP_LOBBY_STANDING_B" },
			 [3] = {model = "mp_g_m_m_unibanditos_01", weapon = "weapon_repeater_carbine",   coords = vector4(-3965.3388671875, -2154.1611328125, -6.167818069458, 3.69),         scenario = "WORLD_HUMAN_SMOKE" },
			 },
			 
			 district            = "district_cholla_springs", -- This mission will have a chance to trigger if the player is in this district when starting the mission. 
			 missioncoords       = vector3(-3973.748291015625, -2151.792724609375, -6.68283033370971), 
			 bountycoords		 = vector4(-3956.655517578125, -2126.81396484375, -4.28656530380249, 108.0), 
			 deliverycoords      = vector3(-3623.8621, -2597.8047, -13.7346), -- ARMADILLO SHERIFF OFFICE 
			 musicenabled        = true, 
			 music               = "BOU1_START", 
			 EnnemiesCooldown    = 30,
			 EnnemyPedModel      = "mp_g_m_m_unibanditos_01", -- ENEMY REINFORCEMENT WAVE PED MODEL 
			 ChanceOfSpawn       = 100,
			 NumberOfEnnemiesMin = 3,
			 NumberOfEnnemiesMax = 4,
			 aliveshortreward    = 30, 
			 alivelongreward     = 120, 
			 aliveshortxp        = 20, 
			 alivelongxp         = 120,
			 deadshortreward     = 30, 		 
			 deadlongreward      = 120,
			 deadshortxp         = 10,			 
			 deadlongxp          = 30, 
	 },	 
 
 
 
     [32]  = { name              = 'Bounty Target',  
			 model               = "mp_u_m_m_bountytarget_033", 
			 bountyscenario      = "WORLD_HUMAN_SMOKE",
			 CountdownEnabled    = true,
			 CountdownTimer      = 20,
			 missionnetworked    = true,
			 enemies             = {
			 [1] = {model = "mp_g_m_m_unibanditos_01", weapon = "weapon_revolver_cattleman", coords = vector4(-3848.698974609375, -2988.124267578125, -6.98534870147705, 0.0),   scenario = "MP_COOP_LOBBY_STANDING_A" },
			 [2] = {model = "mp_g_m_m_unibanditos_01", weapon = "weapon_repeater_carbine",   coords = vector4(-3808.4453125, -2978.473876953125, -4.90553379058837, -67.0),      scenario = "MP_COOP_LOBBY_STANDING_B" },
			 [3] = {model = "mp_g_m_m_unibanditos_01", weapon = "weapon_repeater_carbine",   coords = vector4(-3812.7509765625, -3024.330322265625, -5.6420612335205, -157.0),   scenario = "WORLD_HUMAN_SMOKE" },
			 },
			 district            = "district_cholla_springs", -- This mission will have a chance to trigger if the player is in this district when starting the mission. 
			 missioncoords       = vector3(-3823.050048828125, -2987.2802734375, -6.22458696365356), 
			 bountycoords		 = vector4(-3847.604248046875, -3006.22119140625, -7.08629035949707, -46.0), 
			 deliverycoords      = vector3(-3623.8621, -2597.8047, -13.7346), -- ARMADILLO SHERIFF OFFICE 
			 musicenabled        = true, 
			 music               = "BOU1_START", 
			 EnnemiesCooldown    = 30,
			 EnnemyPedModel      = "mp_g_m_m_unibanditos_01", -- ENEMY REINFORCEMENT WAVE PED MODEL 
			 ChanceOfSpawn       = 100,
			 NumberOfEnnemiesMin = 3,
			 NumberOfEnnemiesMax = 4,
			 aliveshortreward    = 30, 
			 alivelongreward     = 120, 
			 aliveshortxp        = 20, 
			 alivelongxp         = 120,
			 deadshortreward     = 30, 		 
			 deadlongreward      = 120,
			 deadshortxp         = 10,			 
			 deadlongxp          = 30, 
	 },	 
	 
	 
	 
     [33]  = { name              = 'Bounty Target',  
			 model               = "mp_u_m_m_bountytarget_034", 
			 bountyscenario      = "WORLD_HUMAN_SMOKE",
			 CountdownEnabled    = true,
			 CountdownTimer      = 20,
			 missionnetworked    = true,
			 
			 enemies             = {
			 [1] = {model = "mp_g_m_m_unibanditos_01", weapon = "weapon_revolver_cattleman", coords = vector4(-4273.23046875, -3731.55810546875, -1.41871643066406, 0.0),  		scenario = "MP_COOP_LOBBY_STANDING_A" },
			 [2] = {model = "mp_g_m_m_unibanditos_01", weapon = "weapon_repeater_carbine",   coords = vector4(-4265.45654296875, -3716.17919921875, -1.14882957935333, -67.0),  scenario = "MP_COOP_LOBBY_STANDING_B" },
			 [3] = {model = "mp_g_m_m_unibanditos_01", weapon = "weapon_repeater_carbine",   coords = vector4(-4293.63916015625, -3718.7578125, 0.22889214754104, 0.0),   		scenario = "WORLD_HUMAN_SMOKE" },
			 [4] = {model = "mp_g_m_m_unibanditos_01", weapon = "weapon_repeater_carbine",   coords = vector4(-4309.11865234375, -3723.19775390625, 0.13885554671287, 101.0),   scenario = "WORLD_HUMAN_SMOKE" },
			 },
			 
			 district            = "district_cholla_springs", -- This mission will have a chance to trigger if the player is in this district when starting the mission. 
			 missioncoords       = vector3(-4278.5419921875, -3724.308349609375, -0.90527248382568), 
			 bountycoords		 = vector4(-4290.00732421875, -3726.1787109375, -0.29168534278869, -46.0), 
			 deliverycoords      = vector3(-3623.8621, -2597.8047, -13.7346), -- ARMADILLO SHERIFF OFFICE 
			 musicenabled        = true, 
			 music               = "BOU1_START", 
			 EnnemiesCooldown    = 30,
			 EnnemyPedModel      = "mp_g_m_m_unibanditos_01", -- ENEMY REINFORCEMENT WAVE PED MODEL 
			 ChanceOfSpawn       = 100,
			 NumberOfEnnemiesMin = 3,
			 NumberOfEnnemiesMax = 4,
			 aliveshortreward    = 30, 
			 alivelongreward     = 120, 
			 aliveshortxp        = 20, 
			 alivelongxp         = 120,
			 deadshortreward     = 30, 		 
			 deadlongreward      = 120,
			 deadshortxp         = 10,			 
			 deadlongxp          = 30, 
	 },	 
	 	 

	 
     [34]  = { name              = 'Bounty Target',  
			 model               = "mp_u_m_m_bountytarget_035", 
			 bountyscenario      = "WORLD_HUMAN_SMOKE",
			 CountdownEnabled    = true,
			 CountdownTimer      = 20,
			 missionnetworked    = true,
			 
			 enemies             = {
			 [1] = {model = "mp_g_m_m_unibanditos_01", weapon = "weapon_revolver_cattleman", coords = vector4(-4204.98828125, -3444.3759765625, 40.04697799682617, 61.0),   scenario = "MP_COOP_LOBBY_STANDING_A" },
			 [2] = {model = "mp_g_m_m_unibanditos_01", weapon = "weapon_repeater_carbine",   coords = vector4(-4198.41357421875, -3419.859375, 41.48068618774414, -149.0),      scenario = "MP_COOP_LOBBY_STANDING_B" },
			 [3] = {model = "mp_g_m_m_unibanditos_01", weapon = "weapon_repeater_carbine",   coords = vector4(-4186.31298828125, -3418.164306640625, 42.49353408813476, -54.0),   scenario = "WORLD_HUMAN_SMOKE" },
			 [4] = {model = "mp_g_m_m_unibanditos_01", weapon = "weapon_repeater_carbine",   coords = vector4(-4179.38916015625, -3440.54345703125, 41.48896026611328, 101.0),   scenario = "WORLD_HUMAN_SMOKE" },
			 },
			 
			 district            = "district_cholla_springs", -- This mission will have a chance to trigger if the player is in this district when starting the mission. 
			 missioncoords       = vector3(-4199.07080078125, -3436.030029296875, 37.08679580688476), 
			 bountycoords		 = vector4(-4223.66943359375, -3453.181396484375, 37.08088684082031, 150.0), 
			 deliverycoords      = vector3(-3623.8621, -2597.8047, -13.7346), -- ARMADILLO SHERIFF OFFICE 
			 musicenabled        = true, 
			 music               = "BOU1_START", 
			 EnnemiesCooldown    = 30,
			 EnnemyPedModel      = "mp_g_m_m_unibanditos_01", -- ENEMY REINFORCEMENT WAVE PED MODEL 
			 ChanceOfSpawn       = 100,
			 NumberOfEnnemiesMin = 3,
			 NumberOfEnnemiesMax = 4,
			 aliveshortreward    = 30, 
			 alivelongreward     = 120, 
			 aliveshortxp        = 20, 
			 alivelongxp         = 120,
			 deadshortreward     = 30, 		 
			 deadlongreward      = 120,
			 deadshortxp         = 10,			 
			 deadlongxp          = 30, 
	 },	 	 
	 
	 
	 
     [35]  = { name              = 'Bounty Target',  
			 model               = "mp_u_m_m_bountytarget_036", 
			 bountyscenario      = "WORLD_HUMAN_SMOKE",
			 CountdownEnabled    = true,
			 CountdownTimer      = 20,
			 missionnetworked    = true,
			 
			 enemies             = {
			 [1] = {model = "mp_g_m_m_unibanditos_01", weapon = "weapon_revolver_cattleman", coords = vector4(-3311.51708984375, -3428.924560546875, 48.7673454284668, 61.0),  scenario = "MP_COOP_LOBBY_STANDING_A" },
			 [2] = {model = "mp_g_m_m_unibanditos_01", weapon = "weapon_repeater_carbine",   coords = vector4(-3318.037841796875, -3455.513671875, 48.3586196899414, -149.0),  scenario = "MP_COOP_LOBBY_STANDING_B" },
			 [3] = {model = "mp_g_m_m_unibanditos_01", weapon = "weapon_repeater_carbine",   coords = vector4(-3378.6064453125, -3429.557861328125, 47.64809799194336, 65.16), scenario = "WORLD_HUMAN_SMOKE" },
			 [4] = {model = "mp_g_m_m_unibanditos_01", weapon = "weapon_repeater_carbine",   coords = vector4(-3381.45947265625, -3411.66455078125, 46.21714782714844, 0.0),   scenario = "WORLD_HUMAN_SMOKE" },
			 },
			 
			 district            = "district_cholla_springs", -- This mission will have a chance to trigger if the player is in this district when starting the mission. 
			 missioncoords       = vector3(-3341.04443359375, -3427.1162109375, 48.7626724243164), 
			 bountycoords		 = vector4(-3317.902099609375, -3444.223876953125, 48.77748489379883, 150.0), 
			 deliverycoords      = vector3(-3623.8621, -2597.8047, -13.7346), -- ARMADILLO SHERIFF OFFICE 
			 musicenabled        = true, 
			 music               = "BOU1_START", 
			 EnnemiesCooldown    = 30,
			 EnnemyPedModel      = "mp_g_m_m_unibanditos_01", -- ENEMY REINFORCEMENT WAVE PED MODEL 
			 ChanceOfSpawn       = 100,
			 NumberOfEnnemiesMin = 3,
			 NumberOfEnnemiesMax = 4,
			 aliveshortreward    = 30, 
			 alivelongreward     = 120, 
			 aliveshortxp        = 20, 
			 alivelongxp         = 120,
			 deadshortreward     = 30, 		 
			 deadlongreward      = 120,
			 deadshortxp         = 10,			 
			 deadlongxp          = 30, 
	 },	 	 
	 
 
   -- GAPTOOTH RIDGE --
 
 
     [36]  = { name                = 'Bounty Target',  
			   model               = "mp_u_m_m_bountytarget_037", 
			   bountyscenario      = "WORLD_HUMAN_SMOKE",
			   CountdownEnabled    = true,
			   CountdownTimer      = 20,
			   missionnetworked    = true,
			 
			 enemies             = {
			 [1] = {model = "mp_g_m_m_unibanditos_01", weapon = "weapon_revolver_cattleman", coords = vector4(-4838.63818359375, -2378.95849609375, 5.52265214920043, 144.0),     scenario = "MP_COOP_LOBBY_STANDING_A" },
			 [2] = {model = "mp_g_m_m_unibanditos_01", weapon = "weapon_repeater_carbine",   coords = vector4(-4802.03125, -2358.665771484375, 9.55938529968261, -37.0), scenario = "MP_COOP_LOBBY_STANDING_B" },
			 [3] = {model = "mp_g_m_m_unibanditos_01", weapon = "weapon_repeater_carbine",   coords = vector4(-4804.67822265625, -2417.568115234375, 10.98866271972656, 147.0),         scenario = "WORLD_HUMAN_SMOKE" },
			 },
			 
			 district            = "district_gaptooth_ridge", -- This mission will have a chance to trigger if the player is in this district when starting the mission. 
			 missioncoords       = vector3(-4802.41259765625, -2394.669677734375, 7.24094152450561), 
			 bountycoords		 = vector4(-4821.94189453125, -2372.331298828125, 6.36188650131225, 111.0), 
			 deliverycoords      = vector3(-5524.4990, -2926.0186, -2.0616), -- TUMBLEWEED SHERIFF OFFICE 
			 musicenabled        = true, 
			 music               = "BOU1_START", 
			 EnnemiesCooldown    = 30,
			 EnnemyPedModel      = "mp_g_m_m_unibanditos_01", -- ENEMY REINFORCEMENT WAVE PED MODEL 
			 ChanceOfSpawn       = 100,
			 NumberOfEnnemiesMin = 3,
			 NumberOfEnnemiesMax = 4,
			 aliveshortreward    = 30, 
			 alivelongreward     = 120, 
			 aliveshortxp        = 20, 
			 alivelongxp         = 120,
			 deadshortreward     = 30, 		 
			 deadlongreward      = 120,
			 deadshortxp         = 10,			 
			 deadlongxp          = 30, 
	 },	 
 
 
 
     [37]  = { name              = 'Bounty Target',  
			 model               = "mp_u_m_m_bountytarget_038", 
			 bountyscenario      = "WORLD_HUMAN_SMOKE",
			 CountdownEnabled    = true,
			 CountdownTimer      = 20,
			 missionnetworked    = true,
			 enemies             = {
			 [1] = {model = "mp_g_m_m_unibanditos_01", weapon = "weapon_revolver_cattleman", coords = vector4(-5103.69775390625, -2531.092529296875, -11.11421394348144, 152.0),   scenario = "MP_COOP_LOBBY_STANDING_A" },
			 [2] = {model = "mp_g_m_m_unibanditos_01", weapon = "weapon_repeater_carbine",   coords = vector4(-5104.0732421875, -2515.689697265625, -11.10091018676757, 25.0),      scenario = "MP_COOP_LOBBY_STANDING_B" },
			 [3] = {model = "mp_g_m_m_unibanditos_01", weapon = "weapon_repeater_carbine",   coords = vector4(-5073.9873046875, -2537.677978515625, -11.32081604003906, -142.0),   scenario = "WORLD_HUMAN_SMOKE" },
			 },
			 district            = "district_gaptooth_ridge", -- This mission will have a chance to trigger if the player is in this district when starting the mission. 
			 missioncoords       = vector3(-5082.693359375, -2522.037841796875, -11.23987388610839), 
			 bountycoords		 = vector4(-5095.60107421875, -2534.74072265625, -11.10941791534423, -158.0), 
			 deliverycoords      = vector3(-5524.4990, -2926.0186, -2.0616), -- TUMBLEWEED SHERIFF OFFICE 
			 musicenabled        = true, 
			 music               = "BOU1_START", 
			 EnnemiesCooldown    = 30,
			 EnnemyPedModel      = "mp_g_m_m_unibanditos_01", -- ENEMY REINFORCEMENT WAVE PED MODEL 
			 ChanceOfSpawn       = 100,
			 NumberOfEnnemiesMin = 3,
			 NumberOfEnnemiesMax = 4,
			 aliveshortreward    = 30, 
			 alivelongreward     = 120, 
			 aliveshortxp        = 20, 
			 alivelongxp         = 120,
			 deadshortreward     = 30, 		 
			 deadlongreward      = 120,
			 deadshortxp         = 10,			 
			 deadlongxp          = 30, 
	 },	 



     [38]  = { name              = 'Bounty Target',  
			 model               = "mp_u_m_m_bountytarget_039", 
			 bountyscenario      = "WORLD_HUMAN_SMOKE",
			 CountdownEnabled    = true,
			 CountdownTimer      = 20,
			 missionnetworked    = true,
			 enemies             = {
			 [1] = {model = "mp_g_m_m_unibanditos_01", weapon = "weapon_revolver_cattleman", coords = vector4(-5434.97900390625, -3656.002197265625, -22.13309288024902, 60.0),   scenario = "MP_COOP_LOBBY_STANDING_A" },
			 [2] = {model = "mp_g_m_m_unibanditos_01", weapon = "weapon_repeater_carbine",   coords = vector4(-5443.2421875, -3654.521240234375, -21.65597152709961, -82.0),      scenario = "MP_COOP_LOBBY_STANDING_B" },
			 [3] = {model = "mp_g_m_m_unibanditos_01", weapon = "weapon_repeater_carbine",   coords = vector4(-5073.9873046875, -2537.677978515625, -11.32081604003906, -142.0),  scenario = "WORLD_HUMAN_SMOKE" },
			 [4] = {model = "mp_g_m_m_unibanditos_01", weapon = "weapon_repeater_carbine",   coords = vector4(-5410.830078125, -3637.89892578125, -22.1075210571289, -18.0),      scenario = "MP_COOP_LOBBY_STANDING_C" },
			 [5] = {model = "mp_g_m_m_unibanditos_01", weapon = "weapon_repeater_carbine",   coords = vector4(-5418.572265625, -3671.821044921875, -22.01189422607422, -152.0),   scenario = "WORLD_HUMAN_SMOKE" },
			 },
			 
			 district            = "district_gaptooth_ridge", -- This mission will have a chance to trigger if the player is in this district when starting the mission. 
			 missioncoords       = vector3(-5403.35693359375, -3659.460205078125, -22.05120277404785), 
			 bountycoords		 = vector4(-5426.11181640625, -3656.039794921875, -22.14366912841797, 4.22), 
			 deliverycoords      = vector3(-5524.4990, -2926.0186, -2.0616), -- TUMBLEWEED SHERIFF OFFICE 
			 musicenabled        = true, 
			 music               = "BOU1_START", 
			 EnnemiesCooldown    = 30,
			 EnnemyPedModel      = "mp_g_m_m_unibanditos_01", -- ENEMY REINFORCEMENT WAVE PED MODEL 
			 ChanceOfSpawn       = 100,
			 NumberOfEnnemiesMin = 3,
			 NumberOfEnnemiesMax = 4,
			 aliveshortreward    = 30, 
			 alivelongreward     = 120, 
			 aliveshortxp        = 20, 
			 alivelongxp         = 120,
			 deadshortreward     = 30, 		 
			 deadlongreward      = 120,
			 deadshortxp         = 10,			 
			 deadlongxp          = 30, 
	 },	




     [39]  = { name              = 'Bounty Target',  
			 model               = "mp_u_m_m_bountytarget_044", 
			 bountyscenario      = "WORLD_HUMAN_SMOKE",
			 CountdownEnabled    = true,
			 CountdownTimer      = 20,
			 missionnetworked    = true,
			 enemies             = {
			 [1] = {model = "mp_g_m_m_unibanditos_01", weapon = "weapon_revolver_cattleman", coords = vector4(-5969.0126953125, -3169.348388671875, -24.70153999328613,  -131.0),   scenario = "MP_COOP_LOBBY_STANDING_A" },
			 [2] = {model = "mp_g_m_m_unibanditos_01", weapon = "weapon_repeater_carbine",   coords = vector4(-5968.32177734375, -3210.2197265625, -21.32961654663086, -176.0),   scenario = "MP_COOP_LOBBY_STANDING_B" },
			 [3] = {model = "mp_g_m_m_unibanditos_01", weapon = "weapon_repeater_carbine",   coords = vector4(-5983.74755859375, -3212.271240234375, -19.00679206848144, -52.0),  scenario = "WORLD_HUMAN_SMOKE" },
			 [4] = {model = "mp_g_m_m_unibanditos_01", weapon = "weapon_repeater_carbine",   coords = vector4(-5975.56689453125, -3234.2373046875, -21.55224418640136,  -164.0),   scenario = "MP_COOP_LOBBY_STANDING_C" },
			 [5] = {model = "mp_g_m_m_unibanditos_01", weapon = "weapon_repeater_carbine",   coords = vector4(-5965.08837890625, -3238.382080078125, -21.61991119384765, 125.0),  scenario = "WORLD_HUMAN_SMOKE" },
			 },
			 
			 district            = "district_gaptooth_ridge", -- This mission will have a chance to trigger if the player is in this district when starting the mission. 
			 missioncoords       = vector3(-5979.705078125, -3254.49609375, -21.58328437805175), 
			 bountycoords		 = vector4(-5979.9951171875, -3163.44140625, -26.65007781982422, -124.0), 
			 deliverycoords      = vector3(-5524.4990, -2926.0186, -2.0616), -- TUMBLEWEED SHERIFF OFFICE 
			 musicenabled        = true, 
			 music               = "BOU1_START", 
			 EnnemiesCooldown    = 30,
			 EnnemyPedModel      = "mp_g_m_m_unibanditos_01", -- ENEMY REINFORCEMENT WAVE PED MODEL 
			 ChanceOfSpawn       = 100,
			 NumberOfEnnemiesMin = 3,
			 NumberOfEnnemiesMax = 4,
			 aliveshortreward    = 30, 
			 alivelongreward     = 120, 
			 aliveshortxp        = 20, 
			 alivelongxp         = 120,
			 deadshortreward     = 30, 		 
			 deadlongreward      = 120,
			 deadshortxp         = 10,			 
			 deadlongxp          = 30, 
	 },		 
	 
	 
     [40]  = { name              = 'Bounty Target',  
			 model               = "mp_u_m_m_bountytarget_045", 
			 bountyscenario      = "WORLD_HUMAN_SMOKE",
			 CountdownEnabled    = true,
			 CountdownTimer      = 20,
			 missionnetworked    = true,
			 enemies             = {
			 [1] = {model = "mp_g_m_m_unibanditos_01", weapon = "weapon_revolver_cattleman", coords = vector4(-5847.673828125, -3733.57568359375, -25.35075759887695,  0.0),   scenario = "MP_COOP_LOBBY_STANDING_A" },
			 [2] = {model = "mp_g_m_m_unibanditos_01", weapon = "weapon_repeater_carbine",   coords = vector4(-5828.640625, -3722.991455078125, -25.84620475769043, -11.0),   scenario = "MP_COOP_LOBBY_STANDING_B" },
			 [3] = {model = "mp_g_m_m_unibanditos_01", weapon = "weapon_repeater_carbine",   coords = vector4(-5850.3515625, -3754.943359375, -25.22634124755859, 160.0),  scenario = "WORLD_HUMAN_SMOKE" },
			 [4] = {model = "mp_g_m_m_unibanditos_01", weapon = "weapon_repeater_carbine",   coords = vector4(-5833.52294921875, -3755.156982421875, -26.2850399017334,  -164.0),   scenario = "MP_COOP_LOBBY_STANDING_C" },
			 [5] = {model = "mp_g_m_m_unibanditos_01", weapon = "weapon_repeater_carbine",   coords = vector4(-5844.06982421875, -3744.383056640625, -25.24465751647949, -85.0),  scenario = "WORLD_HUMAN_SMOKE" },
			 },
			 
			 district            = "district_gaptooth_ridge", -- This mission will have a chance to trigger if the player is in this district when starting the mission. 
			 missioncoords       = vector3(-5847.83935546875, -3743.96533203125, -24.92003631591797), 
			 bountycoords		 = vector4(-5847.84765625, -3743.73779296875, -24.91436386108398, -124.0), 
			 deliverycoords      = vector3(-5524.4990, -2926.0186, -2.0616), -- TUMBLEWEED SHERIFF OFFICE 
			 musicenabled        = true, 
			 music               = "BOU1_START", 
			 EnnemiesCooldown    = 30,
			 EnnemyPedModel      = "mp_g_m_m_unibanditos_01", -- ENEMY REINFORCEMENT WAVE PED MODEL 
			 ChanceOfSpawn       = 100,
			 NumberOfEnnemiesMin = 3,
			 NumberOfEnnemiesMax = 4,
			 aliveshortreward    = 30, 
			 alivelongreward     = 120, 
			 aliveshortxp        = 20, 
			 alivelongxp         = 120,
			 deadshortreward     = 30, 		 
			 deadlongreward      = 120,
			 deadshortxp         = 10,			 
			 deadlongxp          = 30, 
	 },		 
 
} 

--------------------------------------------
--------------------------------------------

		 -- SEARCH CLUE ZONES --
			
--------------------------------------------
--------------------------------------------

----------------------
  -- NEW HANOVER --
----------------------

Config.Search_Zone = {

-- HEARTLANDS 
    [1]  = { name      = 'Search Zone', 
			district   = "district_heartlands",
			zonecoords = vector3(-559.3388061523438, 406.72369384765625, 86.52265167236328), 
			clues      = { -- These will randomly be picked
							[1] = {object = "p_bag01x",      objectcoords = vector4(-548.9600219726562, 393.7699890136719, 87.73999786376953, 0.0) },
							[2] = {object = "p_cigarbox02x", objectcoords = vector4(-552.6879272460938, 390.8014221191406, 86.91032409667969, 85.0) },
							[3] = {object = "p_cigarbox02x", objectcoords = vector4(-593.6423950195312, 411.2967529296875, 85.79067993164062, 0.0) },
							[4] = {object = "p_bag01x", 	 objectcoords = vector4(-538.48095703125, 385.1637878417969, 85.77456665039062, 0.0) },
 	
						},
			musicenabled     = true, 
			music            = "BOU1_START",
			CountdownEnabled = true,
			CountdownTimer   = 10,
			},
			
    [2]  = { name      = 'Search Zone', 
			district   = "district_heartlands",
			zonecoords = vector3(131.76785278320312, 161.37620544433594, 112.1143798828125),
			clues      = { -- These will randomly be picked
							[1] = {object = "p_bag01x", 	 objectcoords = vector4(135.47601318359375, 162.4168701171875, 111.19332122802734, 0.0)  },
							[2] = {object = "p_cigarbox02x", objectcoords = vector4(140.37660217285156, 149.3238067626953, 114.69894409179688, 0.0)  },
							[3] = {object = "p_cigarbox02x", objectcoords = vector4(126.72339630126953, 166.23886108398438, 112.40313720703125, 0.0) },
						},
						
			musicenabled     = true, 
			music            = "BOU1_START",
			CountdownEnabled = true,
			CountdownTimer   = 10,			
			},	



-- SCARLETT MEADOWS 
    [3]  = { name      = 'Search Zone', 
			district   = "district_scarlett_meadows",
			zonecoords = vector3(1747.60205078125, -1910.341552734375, 46.17458724975586),
			clues      = { -- These will randomly be picked
							[1] = {object = "p_bag01x", 	 objectcoords = vector4(1761.670654296875, -1896.6383056640625, 46.84756851196289, 0.0)  },
							[2] = {object = "p_cigarbox02x", objectcoords = vector4(1759.84814453125, -1879.19482421875, 45.72631454467773, 0.0)  },
							[3] = {object = "p_cigarbox02x", objectcoords = vector4(1758.5374755859375, -1921.4283447265625, 46.84765243530273, 0.0) },
						},
						
			musicenabled     = true, 
			music            = "BOU1_START",
			CountdownEnabled = true,
			CountdownTimer   = 10,			
			},
 
 
     [4]  = { name      = 'Search Zone', 
			district   = "district_scarlett_meadows",
			zonecoords = vector3(1391.2889404296875, -1729.315673828125, 69.20673370361328),
			clues      = { -- These will randomly be picked
							[1] = {object = "p_bag01x", 	 objectcoords = vector4(1390.6680908203125, -1732.3480224609375, 68.32926940917969, 108.0)  },
							[2] = {object = "p_cigarbox02x", objectcoords = vector4(1415.7802734375, -1750.4537353515625, 66.99751281738281, -172.0)  },
							[3] = {object = "p_cigarbox02x", objectcoords = vector4(1422.2523193359375, -1740.6907958984375, 67.28433990478516, -172.0) },
						},		
			musicenabled     = true, 
			music            = "BOU1_START",
			CountdownEnabled = true,
			CountdownTimer   = 10,			
			},
			
			
-- LEMOYNE BAYOU NWA	
     [5]  = { name     = 'Search Zone', 
			district   = "district_bayou_nwa",
			zonecoords = vector3(1708.0538330078125, -1004.3905639648438, 43.47010040283203),
			clues      = { -- These will randomly be picked
							[1] = {object = "p_bag01x", 	 objectcoords = vector4(1711.0465087890625, -1003.7031860351562, 42.43387222290039, -124.0)  },
							[2] = {object = "p_cigarbox02x", objectcoords = vector4(1706.7216796875, -1007.540771484375, 42.48928451538086, 170.0)  },
							[3] = {object = "p_cigarbox02x", objectcoords = vector4(1707.9625244140625, -1009.6332397460938, 40.84748077392578, 48.0) },
						},		
			musicenabled     = true, 
			music            = "BOU1_START",
			CountdownEnabled = true,
			CountdownTimer   = 10,			
			},			
			
			
			
     [6]  = { name     = 'Search Zone', 
			district   = "district_bayou_nwa",
			zonecoords = vector3(1755.1148681640625, -450.10211181640625, 46.98042678833008),
			clues      = { -- These will randomly be picked
							[1] = {object = "p_bag01x", 	 objectcoords = vector4(1734.7294921875, -424.67138671875, 47.11550140380859, 95.0)  },
							[2] = {object = "p_cigarbox02x", objectcoords = vector4(1739.7313232421875, -462.5683288574219, 46.6708869934082, 0.0)  },
							[3] = {object = "p_cigarbox02x", objectcoords = vector4(1774.707275390625, -462.16571044921875, 44.11669540405273, -59.0) },
						},		
			musicenabled     = true, 
			music            = "BOU1_START",
			CountdownEnabled = true,
			CountdownTimer   = 10,			
			},					
			
			
-- ROANOKE RIDGE 

     [7]  = { name     = 'Search Zone', 
			district   = "district_roanoke_ridge",
			zonecoords = vector3(2488.3203125, 770.6793823242188, 67.46126556396484),
			clues      = { -- These will randomly be picked
							[1] = {object = "p_bag01x", 	 objectcoords = vector4(2484.068603515625, 774.4617309570312, 66.27876281738281, -124.0)  },
							[2] = {object = "p_cigarbox02x", objectcoords = vector4(2474.28466796875, 759.947021484375, 67.3202133178711, 0.0)  },
							[3] = {object = "p_cigarbox02x", objectcoords = vector4(2483.731201171875, 757.1853637695312, 68.12351989746094, 48.0) },
						},		
			musicenabled     = true, 
			music            = "BOU1_START",
			CountdownEnabled = true,
			CountdownTimer   = 10,			
			},			
 
 
     [8]  = { name     = 'Search Zone', 
			district   = "district_roanoke_ridge",
			zonecoords = vector3(2683.693359375, 898.6437377929688, 91.72512817382812),
			clues      = { -- These will randomly be picked
							[1] = {object = "p_bag01x", 	 objectcoords = vector4(2690.629150390625, 904.9061279296875, 90.94332885742188, 106.0)  },
							[2] = {object = "p_cigarbox02x", objectcoords = vector4(2702.45263671875, 898.9925537109375, 90.69497680664062, 0.0)  },
							[3] = {object = "p_cigarbox02x", objectcoords = vector4(2694.537109375, 900.4345703125, 91.0018081665039, 0.0) },
						},		
			musicenabled     = true, 
			music            = "BOU1_START",
			CountdownEnabled = true,
			CountdownTimer   = 10,			
			},					
				
   -- BIG VALLEY 		
			
 
     [9]  = { name     = 'Search Zone', 
			district   = "district_big_valley",
			zonecoords = vector3(-2446.1591796875, 814.646484375, 138.80685424804688),
			clues      = { -- These will randomly be picked
							[1] = {object = "p_bag01x", 	 objectcoords = vector4(-2458.1923828125, 838.155517578125, 141.28587341308594, 11.39)  },
							[2] = {object = "p_cigarbox02x", objectcoords = vector4(-2460.063720703125, 842.5064086914062, 145.36866760253906, 0.0)  },
							[3] = {object = "p_cigarbox02x", objectcoords = vector4(-2458.469482421875, 840.5123291015625, 145.3811798095703, 48.0) },
						},		
			musicenabled     = true, 
			music            = "BOU1_START",
			CountdownEnabled = true,
			CountdownTimer   = 10,			
			},			
 
 
     [10]  = { name     = 'Search Zone', 
			district   = "district_big_valley",
			zonecoords = vector3(-2154.071533203125, 83.16213989257812, 310.10589599609375),
			clues      = { -- These will randomly be picked
							[1] = {object = "p_bag01x", 	 objectcoords = vector4(-2155.47607421875, 78.71353149414062, 309.79620361328125, 106.0)  },
							[2] = {object = "p_cigarbox02x", objectcoords = vector4(-2151.270751953125, 76.55451965332031, 309.7604675292969, 0.0)  },
							[3] = {object = "p_cigarbox02x", objectcoords = vector4(-2154.79833984375, 76.81807708740234, 309.7831115722656, 0.0) },
						},		
			musicenabled     = true, 
			music            = "BOU1_START",
			CountdownEnabled = true,
			CountdownTimer   = 10,			
	 },	
	 
	 
	 
   -- GREAT PLAINS  
			
 
     [11]  = { name     = 'Search Zone', 
			district   = "district_great_plains",
			zonecoords = vector3(-2492.55712890625, -1468.3641357421875, 147.7583770751953),
			clues      = { -- These will randomly be picked
							[1] = {object = "p_bag01x", 	 objectcoords = vector4(-2496.035888671875, -1459.84765625, 146.34593200683594, 11.39)  },
							[2] = {object = "p_cigarbox02x", objectcoords = vector4(-2497.812255859375, -1479.2252197265625, 146.64004516601562, 0.0)  },
							[3] = {object = "p_cigarbox02x", objectcoords = vector4(-2510.630859375, -1464.62939453125, 145.44102478027344, 48.0) },
						},		
			musicenabled     = true, 
			music            = "BOU1_START",
			CountdownEnabled = true,
			CountdownTimer   = 10,			
			},			
 
 
     [12]  = { name     = 'Search Zone', 
			district   = "district_great_plains",
			zonecoords = vector3(-2048.611572265625, -1907.9334716796875, 111.1463394165039),
			clues      = { -- These will randomly be picked
							[1] = {object = "p_bag01x", 	 objectcoords = vector4(-2039.5545654296875, -1905.800537109375, 109.13636779785156, 106.0)  },
							[2] = {object = "p_cigarbox02x", objectcoords = vector4(-2074.25927734375, -1901.2421875, 112.1037368774414, 0.0)  },
							[3] = {object = "p_cigarbox02x", objectcoords = vector4(-2091.301513671875, -1903.6627197265625, 112.98703002929688, 0.0) },
						},		
			musicenabled     = true, 
			music            = "BOU1_START",
			CountdownEnabled = true,
			CountdownTimer   = 10,			
	 },	
	 	 
	 
 
 
	 
	 
   -- CHOLLA SPRINGS
 
     [13]  = { name     = 'Search Zone', 
			district   = "district_cholla_springs",
			zonecoords = vector3(-3452.473388671875, -2256.828369140625, -0.89690506458282),
			clues      = { -- These will randomly be picked
							[1] = {object = "p_bag01x", 	 objectcoords = vector4(-3445.824462890625, -2265.5341796875, -2.09189081192016, 0.0)  },
							[2] = {object = "p_cigarbox02x", objectcoords = vector4(-3444.106201171875, -2249.1455078125, -2.7782700061798, 0.0)  },
							[3] = {object = "p_cigarbox02x", objectcoords = vector4(-3426.456298828125, -2261.664306640625, -5.08304977416992, 48.0) },
						},		
			musicenabled     = true, 
			music            = "BOU1_START",
			CountdownEnabled = true,
			CountdownTimer   = 10,			
			},			
 
 
     [14]  = { name     = 'Search Zone', 
			district   = "district_cholla_springs",
			zonecoords = vector3(-3751.138671875, -2055.527587890625, -4.66392040252685),
			clues      = { -- These will randomly be picked
							[1] = {object = "p_bag01x", 	 objectcoords = vector4(-3758.35888671875, -2053.064697265625, -4.58581638336181, 106.0)  },
							[2] = {object = "p_cigarbox02x", objectcoords = vector4(-3747.365966796875, -2068.533203125, -7.28567218780517, 0.0)  },
							[3] = {object = "p_cigarbox02x", objectcoords = vector4(-3776.096435546875, -2055.69580078125, -3.26442623138427, 0.0) },
						},		
			musicenabled     = true, 
			music            = "BOU1_START",
			CountdownEnabled = true,
			CountdownTimer   = 10,			
	 },		 
	 	 
		 
		 
   -- GAPTOOTH RIDGE 
 
     [15]  = { name     = 'Search Zone', 
			district   = "district_gaptooth_ridge",
			zonecoords = vector3(-5069.63037109375, -3128.52734375, -19.48567771911621),
			clues      = { -- These will randomly be picked
							[1] = {object = "p_bag01x", 	 objectcoords = vector4(-5063.8388671875, -3138.3310546875, -20.76437187194824, 0.0)  },
							[2] = {object = "p_cigarbox02x", objectcoords = vector4(-5082.923828125, -3146.2109375, -14.8985538482666, 0.0)  },
							[3] = {object = "p_cigarbox02x", objectcoords = vector4(-5048.34814453125, -3148.933837890625, -17.73367691040039, 48.0) },
						},		
			musicenabled     = true, 
			music            = "BOU1_START",
			CountdownEnabled = true,
			CountdownTimer   = 10,			
			},			
 
 
     [16]  = { name     = 'Search Zone', 
			district   = "district_gaptooth_ridge",
			zonecoords = vector3(-5217.61376953125, -3493.885498046875, -21.89435768127441),
			clues      = { -- These will randomly be picked
							[1] = {object = "p_bag01x", 	 objectcoords = vector4(-5210.5859375, -3486.6044921875, -22.90123748779297, 106.0)  },
							[2] = {object = "p_cigarbox02x", objectcoords = vector4(-5216.6318359375, -3478.67626953125, -22.57144165039062, 0.0)  },
							[3] = {object = "p_cigarbox02x", objectcoords = vector4(-5212.9306640625, -3463.809326171875, -22.77431869506836, 0.0) },
						},		
			musicenabled     = true, 
			music            = "BOU1_START",
			CountdownEnabled = true,
			CountdownTimer   = 10,			
	 },			 
 
 } 
 
 
 Config.EnnemyHorses = { --List of enabled enemy horses. These will then be chosen randomly 
 [1]  = {HorseModel = "a_c_horse_americanpaint_greyovero",  	}             ,
 [2]  = {HorseModel = "a_c_horse_americanpaint_overo", 			}             ,
 [3]  = {HorseModel = "a_c_horse_americanpaint_splashedwhite",  }             ,
 [4]  = {HorseModel = "a_c_horse_americanpaint_tobiano", }                    ,
 [5]  = {HorseModel = "a_c_horse_americanstandardbred_black", }               ,
 [6]  = {HorseModel = "a_c_horse_americanstandardbred_buckskin", }            ,
 [7]  = {HorseModel = "a_c_horse_americanstandardbred_lightbuckskin", }       ,
 [8]  = {HorseModel = "a_c_horse_americanstandardbred_palominodapple", }      ,
 [9]  = {HorseModel = "a_c_horse_americanstandardbred_silvertailbuckskin", }  ,
 [10] = {HorseModel = "a_c_horse_andalusian_darkbay", }                       ,
 [11] = {HorseModel = "a_c_horse_andalusian_perlino", }                       ,
 [12] = {HorseModel = "a_c_horse_andalusian_rosegray", }                      ,
 [13] = {HorseModel = "a_c_horse_appaloosa_blacksnowflake", }                 ,
 [14] = {HorseModel = "a_c_horse_appaloosa_blanket", }                        ,
 [15] = {HorseModel = "a_c_horse_appaloosa_brownleopard", }                   ,
 [16] = {HorseModel = "a_c_horse_appaloosa_fewspotted_pc", }                  ,
 [17] = {HorseModel = "a_c_horse_appaloosa_leopard", }                        ,
 [18] = {HorseModel = "a_c_horse_appaloosa_leopardblanket", }                 ,
 [19] = {HorseModel = "a_c_horse_arabian_black", }                            ,
 [20] = {HorseModel = "a_c_horse_arabian_grey", }                             ,
 [21] = {HorseModel = "a_c_horse_arabian_redchestnut", }                      ,
 [22] = {HorseModel = "a_c_horse_arabian_redchestnut_pc", }                   ,
 [23] = {HorseModel = "a_c_horse_arabian_rosegreybay", }                      ,
 [24] = {HorseModel = "a_c_horse_arabian_warpedbrindle_pc", }                 ,
 [25] = {HorseModel = "a_c_horse_arabian_white", }                            ,
 [26] = {HorseModel = "a_c_horse_ardennes_bayroan", }                         ,
 [27] = {HorseModel = "a_c_horse_ardennes_irongreyroan", }                    ,
 [28] = {HorseModel = "a_c_horse_ardennes_strawberryroan", }                  ,
 [29] = {HorseModel = "a_c_horse_belgian_blondchestnut", }                    ,
 [30] = {HorseModel = "a_c_horse_belgian_mealychestnut", }                    ,
 [31] = {HorseModel = "a_c_horse_breton_grullodun", }                         ,
 [32] = {HorseModel = "a_c_horse_breton_mealydapplebay", }                    ,
 [33] = {HorseModel = "a_c_horse_breton_redroan", }                           ,
 [34] = {HorseModel = "a_c_horse_breton_sealbrown", }                         ,
 [35] = {HorseModel = "a_c_horse_breton_sorrel", }                            ,
 [36] = {HorseModel = "a_c_horse_breton_steelgrey", }                         ,
 [37] = {HorseModel = "a_c_horse_buell_warvets", }                            ,
 [38] = {HorseModel = "a_c_horse_criollo_baybrindle", }                       ,
 [39] = {HorseModel = "a_c_horse_criollo_bayframeovero", }                    ,
 [40] = {HorseModel = "a_c_horse_criollo_blueroanovero", }                    ,
 [41] = {HorseModel = "a_c_horse_criollo_dun", }                              ,
 [42] = {HorseModel = "a_c_horse_criollo_marblesabino", }                     ,
 [43] = {HorseModel = "a_c_horse_criollo_sorrelovero", }                      ,
 [44] = {HorseModel = "a_c_horse_dutchwarmblood_chocolateroan", }             ,
 [45] = {HorseModel = "a_c_horse_dutchwarmblood_sealbrown", }                 ,
 [46] = {HorseModel = "a_c_horse_dutchwarmblood_sootybuckskin", }             ,
 }
 
-----------------------------------------------------------------------------------------------
									--KEYBINDS LIST--
-----------------------------------------------------------------------------------------------
--   -- Letters
--   ["B"] = 0x4CC0E2FE,
--   ["C"] = 0x9959A6F0,
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
--   ["P"] = 0xD82E0BD2,
--   -- Missing T
--   ["U"] = 0xD8F73058,
--   ["V"] = 0x7F8D09B8,
--   ["X"] = 0x8CC9CD42,
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
