 Config = {}
 
-- VERSION 4.11 - 09.05.26
 
--------------------------------------------------
			-- FRAMEWORK SELECTION --
-------------------------------------------------- 

-- TURN YOUR FRAMEWORK TO TRUE AND ALL THE OTHERS TO FALSE

Config.REDEMRP2023REBOOT 			   	 		= false
Config.VORP              			   	 		= false
Config.RSG               			   	 		= true

Config.Debug 									= false 
 
Config.NOTIFICATION_1_DURATION         	 		= 6000
			
Config.NOTIF_TEXT_HORSE_TITLE		   	 		= "Stables"
Config.MENU_TEXT_HORSE_NO_OWNED_HORSES 	 		= "You don't own any horses in this category"
Config.MENU_TEXT_HORSE_NO_OWNED_FOAL            = "You don't own any foal in this category"

Config.MENU_TEXT_HORSE_NO_FOAL 			 		= "You don't have any foal"
Config.NOTIF_TEXT_HORSE_NO_MONEY       	 		= "You don't have enough money for this"
Config.NOTIF_TEXT_HORSE_SUCCESSFUL       		= "Breeding successful"

Config.NOTIF_TEXT_HORSE_TOO_MANY       			= "You can't get a new foal since you have reached the owned horses limit"
 
 
Config.BREEDING_COOLDOWN_OFFLINE 				= true  -- IF TRUE YOUR FOALS BREEDING PHASE COOLDOWN WILL BE EFFECTIVE OFFLINE (TIMESTAMP COMPARISON WHEN PLAYER RELOGS) 
-- DOUBLE CHECK THAT YOU HAVE BREEDING_TIMESTAMP COLUMN IN YOUR sirevlc_horses_v3 DATABASE TABLE ! if not run this sql query (without the --): 
-- ALTER TABLE sirevlc_horses_v3
-- ADD COLUMN BREEDING_TIMESTAMP DATETIME NULL;

Config.BREEDING_COOLDOWN_TIMER_PHASE_1          = 30		 -- HOW MANY MINUTES ARE REQUIRED TO GET FROM PHASE 0 to PHASE 1 ?
Config.BREEDING_COOLDOWN_TIMER_PHASE_2          = 30 		 -- HOW MANY MINUTES ARE REQUIRED TO GET FROM PHASE 1 to PHASE 2 ?
Config.BREEDING_COOLDOWN_TIMER_PHASE_3          = 30		 -- HOW MANY MINUTES ARE REQUIRED TO GET FROM PHASE 2 to PHASE 3 ?
Config.BREEDING_COOLDOWN_TIMER_PHASE_4          = 30		 -- HOW MANY MINUTES ARE REQUIRED TO GET FROM PHASE 3 to PHASE 4 ?
		 
-- AGING SYSTEM		 
Config.AGING_HORSE_AGE_FOAL_PHASE_4   	 		= 9  		 -- HOW OLD ARE FOALS WHEN THEY BECOME ADULT ?
 
 
-- GENERAL CREATION COOLDOWN 
Config.BREEDING_CREATION_COOLDOWN               = false 	     -- THIS COOLDOWN IS A GENERAL COOLDOWN FOR THE BREEDING SYSTEM ITSELF ! NOT THE COOLDOWN BETWEEN PHASES !
Config.BREEDING_CREATION_COOLDOWN_TIME          = 30         -- IN MINUTES  

-----------------------------------
 
--------------------------------------------------
	       -- DISCORD WEBHOOKS --
-------------------------------------------------- 

Config.WEBHOOKURL                       	 		= ""
Config.WEBHOOKMAINTITLE                 	 		= "Stables"
		
Config.WEBHOOK_HORSE_BREEDING_CREATE_EVENT   		= false 

Config.WEBHOOK_HORSE_BREEDING_CREATE_EVENT_TITLE 	= "Breeding Creation" 

Config.WEBHOOK_BREEDING_PARENT_A_NAME        		= "STALLION NAME: "
Config.WEBHOOK_BREEDING_PARENT_A_BREED_NAME  		= "STALLION BREED: "
Config.WEBHOOK_BREEDING_PARENT_A_COAT_NAME   		= "STALLION COAT: "
Config.WEBHOOK_BREEDING_PARENT_A_GENE  		 		= "STALLION GENE: "
		
Config.WEBHOOK_BREEDING_PARENT_B_NAME        		= "MARE NAME: "
Config.WEBHOOK_BREEDING_PARENT_B_BREED_NAME  		= "MARE BREED: "
Config.WEBHOOK_BREEDING_PARENT_B_COAT_NAME   		= "MARE COAT: "
Config.WEBHOOK_BREEDING_PARENT_B_GENE  		 		= "MARE GENE: "
		
Config.WEBHOOK_BREEDING_FOAL_NAME        	 		= "FOAL NAME: "
Config.WEBHOOK_BREEDING_FOAL_BREED_NAME  	 		= "FOAL BREED: "
Config.WEBHOOK_BREEDING_FOAL_COAT_NAME   	 		= "FOAL COAT: "
Config.WEBHOOK_BREEDING_FOAL_GENE  	 		 		= "FOAL GENE : "
Config.WEBHOOK_BREEDING_FOAL_GENDER  	 	 		= "FOAL GENDER: "
		
Config.WEBHOOK_NAME        	 	 			 		= "HORSE NAME: 	"
Config.WEBHOOK_BREED_NAME        	 		 		= "BREED NAME: 	"
Config.WEBHOOK_COAT_NAME        	 		 		= "COAT NAME: 	"
Config.WEBHOOK_GENDER       	 			 		= "GENDER: 	"
Config.WEBHOOK_MALE       	 				 		= "Male"
Config.WEBHOOK_FEMALE      	 				 		= "Female"
Config.WEBHOOK_COAT       		 	 		 		= "COAT: 	"
Config.WEBHOOK_ACTION        	 			 		= "ACTION: "
Config.WEBHOOK_GOLD              			 		= "Gold	"	
Config.WEBHOOK_SELLER              			 		= "SELLER:	"	
Config.WEBHOOK_BUYER              			 		= "BUYER:	"	
Config.WEBHOOK_PRICE              			 		= "PRICE:	"	