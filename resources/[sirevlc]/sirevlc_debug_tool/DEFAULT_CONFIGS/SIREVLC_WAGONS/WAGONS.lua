Config = Config or {}

Config.wagons = {
    [1] = {
        Name = "Carts",
		Image = "items/sirevlc_wagon_small_wagon.png",
        Variants = {
            [1] = {
                name  		= "Cart#1",	-- Name displayed in menu
                model 		= `CART01`, -- Model used
                price 		= 550,		-- Dollar price
				gold  		= 10.0,		-- gold price (only for vorp)
                jobreq 		= false,	-- Enable or disable job purchase lock
                jobs 		= {{DB_JOB = "horsetrainer", JOB_LABEL = "Horsetrainer" },  }, -- Database name for the job and the label displayed in menu
				stashlimit 	= 30, 		-- stashlimit for the wagon
				stashslots 	= 30,		-- stashslots for the wagon (only for rsg)
            },
            [2] = {
                name  		= "Cart#2",
                model 		= `CART02`,
                price 		= 450,
				gold  		= 0.0,
                jobreq 		= false,
                jobs 		= {{DB_JOB = "horsetrainer", JOB_LABEL = "Horsetrainer" } },
				stashlimit 	= 30, 
				stashslots 	= 30,				
            },
            [3] = {
                name 		= "Cart#3",
                model 		= `CART03`,
                price 		= 600,
				gold  		= 0.0,
                jobreq  	= false,
                jobs 		= {{DB_JOB = "horsetrainer", JOB_LABEL = "Horsetrainer" } },
				stashlimit 	= 30, 
				stashslots 	= 30,				
            },
            [4] = {
                name 		= "Cart#4",
                model		= `CART04`,
                price		= 450,
				gold 		= 0.0,
                jobreq  	= false,
                jobs 		= {{DB_JOB = "horsetrainer", JOB_LABEL = "Horsetrainer" } },
				stashlimit 	= 30, 
				stashslots 	= 30,
            },
            [5] = {
                name  		= "Cart#5",
                model 		= `CART05`,
                price 		= 650,
				gold  		= 0.0,
                jobreq 		= false,
                jobs 		= {{DB_JOB = "horsetrainer", JOB_LABEL = "Horsetrainer" } },
				stashlimit 	= 30, 
				stashslots 	= 30,				
            },
            [6] = {
                name = "Cart#6",
                model = `CART06`,
                price = 700,
				gold  = 0.0,
                jobreq = false,
                jobs = {{DB_JOB = "horsetrainer", JOB_LABEL = "Horsetrainer" } },
				stashlimit 	= 30, 
				stashslots 	= 30,				
            },
            [7] = {
                name = "Cart#7",
                model = `CART07`,
                price = 650,
				gold  = 0.0,
                jobreq = false,
                jobs = {{DB_JOB = "horsetrainer", JOB_LABEL = "Horsetrainer" } },
				stashlimit 	= 30, 
				stashslots 	= 30,				
            },
            [8] = {
                name = "Cart#8",
                model = `CART08`,
                price = 450,
				gold  = 0.0,
                jobreq = false,
                jobs = {{DB_JOB = "horsetrainer", JOB_LABEL = "Horsetrainer" } },
				stashlimit 	= 30, 
				stashslots 	= 30,				
            },
            [9] = {
                name = "Buggy#1",
                model = `buggy01`,
                price = 580,
				gold  = 0.0,
                jobreq = false,
                jobs = {{DB_JOB = "horsetrainer", JOB_LABEL = "Horsetrainer" } },
				stashlimit 	= 30, 
				stashslots 	= 30,				
            },
            [10] = {
                name = "Buggy#2",
                model = `buggy02`,
                price = 430,
				gold  = 0.0,
                jobreq = false,
                jobs = {{DB_JOB = "horsetrainer", JOB_LABEL = "Horsetrainer" } },
				stashlimit 	= 30, 
				stashslots 	= 30,				
            },
            [11] = {
                name = "Buggy#3",
                model = `buggy03`,
                price = 460,
				gold  = 0.0,
                jobreq = false,
                jobs = {{DB_JOB = "horsetrainer", JOB_LABEL = "Horsetrainer" } },
				stashlimit 	= 30, 
				stashslots 	= 30,				
            },
        },
    },
	
    [2] = {
        Name = "Work Wagons",
		Image = "items/sirevlc_wagon_work_wagon.png",
        Variants = {
            [1] = {
                name = "Transport Coach#1",
                model = `CHUCKWAGON000X`,
                price = 850,
				gold  = 0.0,
                jobreq = false,
                jobs = {{DB_JOB = "horsetrainer", JOB_LABEL = "Horsetrainer" } },
				stashlimit 	= 30, 
				stashslots 	= 30,				
            },
            [2] = {
                name = "Transport Coach#2",
                model = `CHUCKWAGON002X`,
                price = 900,
				gold  = 0.0,
                jobreq = false,
                jobs = {{DB_JOB = "horsetrainer", JOB_LABEL = "Horsetrainer" } },
                stashlimit 	= 30, 
                stashslots 	= 30,

            },
            [3] = {
                name = "Coal Wagon",
                model = `coal_wagon`,
                price = 1300,
				gold  = 0.0,
                jobreq = false,
                jobs = {{DB_JOB = "horsetrainer", JOB_LABEL = "Horsetrainer" } },
                stashlimit 	= 30, 
                stashslots 	= 30,

            },
            [4] = {
                name = "Transport Coach#3",
                model = `gatchuck`,
                price = 1100,
				gold  = 0.0,
                jobreq = false,
                jobs = {{DB_JOB = "horsetrainer", JOB_LABEL = "Horsetrainer" } },
                stashlimit 	= 30, 
                stashslots 	= 30,

            },
            [5] = {
                name = "Log Wagon",
                model = `LOGWAGON`,
                price = 1150,
				gold  = 0.0,
                jobreq = false,
                jobs = {{DB_JOB = "horsetrainer", JOB_LABEL = "Horsetrainer" } },
                stashlimit 	= 30, 
                stashslots 	= 30,

            },
            [6] = {
                name = "Oil Wagon#1",
                model = `OILWAGON01X`,
                price = 1250,
				gold  = 0.0,
                jobreq = false,
                jobs = {{DB_JOB = "horsetrainer", JOB_LABEL = "Horsetrainer" } },
                stashlimit 	= 30, 
                stashslots 	= 30,

            },
            [7] = {
                name = "Oil Wagon#2",
                model = `oilWagon02x`,
                price = 1350,
				gold  = 0.0,
                jobreq = false,
                jobs = {{DB_JOB = "horsetrainer", JOB_LABEL = "Horsetrainer" } },
                stashlimit 	= 30, 
                stashslots 	= 30,

            },
            [8] = {
                name = "Supply Wagon",
                model = `supplywagon`,
                price = 1400,
				gold  = 0.0,
                jobreq = false,
                jobs = {{DB_JOB = "horsetrainer", JOB_LABEL = "Horsetrainer" } },
                stashlimit 	= 30, 
                stashslots 	= 30,

            },
            [9] = {
                name = "Utility Wagon",
                model = `utilliwag`,
                price = 1100,
				gold  = 0.0,
                jobreq = false,
                jobs = {{DB_JOB = "horsetrainer", JOB_LABEL = "Horsetrainer" } },
                stashlimit 	= 30, 
                stashslots 	= 30,

            },
        },
    },
	
    [3] = {
        Name = "Travelling Wagons",
		Image = "items/sirevlc_wagon_camp_wagon.png",		
        Variants = {
            [1] = {
                name = "Travel Wagon#1",
                model = `WAGON02X`,
                price = 1500,
				gold  = 0.0,
                jobreq = false,
                jobs = {{DB_JOB = "horsetrainer", JOB_LABEL = "Horsetrainer" } },
                stashlimit 	= 30, 
                stashslots 	= 30,

            },
            [2] = {
                name = "Travel Wagon#2",
                model = `WAGON03X`,
                price = 1250,
				gold  = 0.0,
                jobreq = false,
                jobs = {{DB_JOB = "horsetrainer", JOB_LABEL = "Horsetrainer" } },
                stashlimit 	= 30, 
                stashslots 	= 30,

            },
            [3] = {
                name = "Travel Wagon#3",
                model = `WAGON04X`,
                price = 1300,
				gold  = 0.0,
                jobreq = false,
                jobs = {{DB_JOB = "horsetrainer", JOB_LABEL = "Horsetrainer" } },
                stashlimit 	= 30, 
                stashslots 	= 30,

            },
            [4] = {
                name = "Travel Wagon#4",
                model = `WAGON05X`,
                price = 1400,
				gold  = 0.0,
                jobreq = false,
                jobs = {{DB_JOB = "horsetrainer", JOB_LABEL = "Horsetrainer" } },
                stashlimit 	= 30, 
                stashslots 	= 30,

            },
            [5] = {
                name = "Travel Wagon#5",
                model = `WAGON06X`,
                price = 1350,
				gold  = 0.0,
                jobreq = false,
                jobs = {{DB_JOB = "horsetrainer", JOB_LABEL = "Horsetrainer" } },
                stashlimit 	= 30, 
                stashslots 	= 30,

            },
 
        },
    },
	
    [4] = {
        Name = "Stagecoaches",
		Image = "items/sirevlc_wagon_stagecoach.png",			
        Variants = {
            [1] = {
                name = "Stagecoach#1",
                model = `COACH2`,
                price = 3500,
				gold  = 0.0,
                jobreq = false,
                jobs = {{DB_JOB = "horsetrainer", JOB_LABEL = "Horsetrainer" } },
                stashlimit 	= 30, 
                stashslots 	= 30,

            },
            [2] = {
                name = "Stagecoach#2",
                model = `COACH3`,
                price = 4500,
				gold  = 0.0,
                jobreq = false,
                jobs = {{DB_JOB = "horsetrainer", JOB_LABEL = "Horsetrainer" } },
                stashlimit 	= 30, 
                stashslots 	= 30,

            },
            [3] = {
                name = "Stagecoach#3",
                model = `coach3_cutscene`,
                price = 3500,
				gold  = 0.0,
                jobreq = false,
                jobs = {{DB_JOB = "horsetrainer", JOB_LABEL = "Horsetrainer" } },
                stashlimit 	= 30, 
                stashslots 	= 30,

            },
            [4] = {
                name = "Stagecoach#4",
                model = `COACH4`,
                price = 4000,
				gold  = 0.0,
                jobreq = false,
                jobs = {{DB_JOB = "horsetrainer", JOB_LABEL = "Horsetrainer" } },
                stashlimit 	= 30, 
                stashslots 	= 30,

            },
            [5] = {
                name = "Stagecoach#5",
                model = `COACH5`,
                price = 3500,
				gold  = 0.0,
                jobreq = false,
                jobs = {{DB_JOB = "horsetrainer", JOB_LABEL = "Horsetrainer" } },
                stashlimit 	= 30, 
                stashslots 	= 30,

            },
            [6] = {
                name = "Stagecoach#6",
                model = `COACH6`,
                price = 3200,
				gold  = 0.0,
                jobreq = false,
                jobs = {{DB_JOB = "horsetrainer", JOB_LABEL = "Horsetrainer" } },
                stashlimit 	= 30, 
                stashslots 	= 30,

            },
            [7] = {
                name = "Stagecoach#7",
                model = `STAGECOACH001X`,
                price = 3300,
				gold  = 0.0,
                jobreq = false,
                jobs = {{DB_JOB = "horsetrainer", JOB_LABEL = "Horsetrainer" } },
                stashlimit 	= 30, 
                stashslots 	= 30,

            },
            [8] = {
                name = "Stagecoach#8",
                model = `STAGECOACH002X`,
                price = 3450,
				gold  = 0.0,
                jobreq = false,
                jobs = {{DB_JOB = "horsetrainer", JOB_LABEL = "Horsetrainer" } },
                stashlimit 	= 30, 
                stashslots 	= 30,

            },
            [9] = {
                name = "Stagecoach#9",
                model = `STAGECOACH003X`,
                price = 3500,
				gold  = 0.0,
                jobreq = false,
                jobs = {{DB_JOB = "horsetrainer", JOB_LABEL = "Horsetrainer" } },
                stashlimit 	= 30, 
                stashslots 	= 30,

            },
            [10] = {
                name = "Armored Stagecoach#01",
                model = `STAGECOACH004X`,
                price = 4000,
				gold  = 0.0,
                jobreq = false,
				jobs = {{DB_JOB = "horsetrainer", JOB_LABEL = "Horsetrainer" } },
				stashlimit 	= 30, 
				stashslots 	= 30,

            },
            [11] = {
                name = "Armored Stagecoach#02",
                model = `STAGECOACH004_2x`,
                price = 30000,
				gold  = 0.0,
                jobreq = false,
				jobs = {{DB_JOB = "horsetrainer", JOB_LABEL = "Horsetrainer" } },
				stashlimit 	= 30, 
				stashslots 	= 30,

            },
            [12] = {
                name = "Stagecoach#12",
                model = `STAGECOACH005X`,
                price = 4500,
				gold  = 0.0,
                jobreq = false,
				jobs = {{DB_JOB = "horsetrainer", JOB_LABEL = "Horsetrainer" } },
				stashlimit 	= 30, 
				stashslots 	= 30,

            },
            [13] = {
                name = "Stagecoach#13",
                model = `STAGECOACH006X`,
                price = 3000,
				gold  = 0.0,
                jobreq = false,
				jobs = {{DB_JOB = "horsetrainer", JOB_LABEL = "Horsetrainer" } },
				stashlimit 	= 30, 
				stashslots 	= 30,

            },
        },
    },
	
    [5] = {
        Name = "Roles Wagons",
		Image = "items/sirevlc_wagon_army.png",			
        Variants = {
            [1] = {
                name = "Army Supply Wagon",
                model = `armysupplywagon`,
                price = 15000,
				gold  = 0.0,
                jobreq = false,
				jobs = {{DB_JOB = "horsetrainer", JOB_LABEL = "Horsetrainer" } },
				stashlimit 	= 30, 
				stashslots 	= 30,

            },
            [2] = {
                name = "Maxim Wagon#01",
                model = `gatchuck_2`,
                price = 30000,
				gold  = 0.0,
                jobreq = false,
				jobs = {{DB_JOB = "horsetrainer", JOB_LABEL = "Horsetrainer" } },
				stashlimit 	= 30, 
				stashslots 	= 30,

            },
            [3] = {
                name = "Police Wagon",
                model = `POLICEWAGON01X`,
                price = 15000,
				gold  = 0.0,
                jobreq = false,
				jobs = {{DB_JOB = "horsetrainer", JOB_LABEL = "Horsetrainer" } },
				stashlimit 	= 30, 
				stashslots 	= 30,

            },
            [4] = {
                name = "Maxim Wagon#02",
                model = `policeWagongatling01x`,
                price = 50000,
				gold  = 0.0,
                jobreq = false,
				jobs = {{DB_JOB = "horsetrainer", JOB_LABEL = "Horsetrainer" } },
				stashlimit 	= 30, 
				stashslots 	= 30,

            },
            [5] = {
                name = "Bounty Hunter Wagon",
                model = `bountywagon01x`,
                price = 15000,
				gold  = 0.0,
                jobreq = false,
				jobs = {{DB_JOB = "horsetrainer", JOB_LABEL = "Horsetrainer" } },
				stashlimit 	= 30, 
				stashslots 	= 30,

            },
            [6] = {
                name = "Hunting Cart",
                model = `huntercart01`,
                price = 1200,
				gold  = 0.0,
                jobreq = false,
				jobs = {{DB_JOB = "horsetrainer", JOB_LABEL = "Horsetrainer" } },
				stashlimit 	= 30, 
				stashslots 	= 30,

            },
            [7] = {
                name = "Armored Army Wagon",
                model = `wagonarmoured01x`,
                price = 20000,
				gold  = 0.0,
                jobreq = false,
				jobs = {{DB_JOB = "horsetrainer", JOB_LABEL = "Horsetrainer" } },
				stashlimit 	= 30, 
				stashslots 	= 30,

            },
            [8] = {
                name = "War Wagon",
                model = `warwagon2`,
                price = 50000,
				gold  = 0.0,
                jobreq = false,
				jobs = {{DB_JOB = "horsetrainer", JOB_LABEL = "Horsetrainer" } },
				stashlimit 	= 30, 
				stashslots 	= 30,

            },
            [9] = {
                name = "Prisoner Wagon",
                model = `wagonPrison01x`,
                price = 20000,
				gold  = 0.0,
                jobreq = false,
				jobs = {{DB_JOB = "horsetrainer", JOB_LABEL = "Horsetrainer" } },
				stashlimit 	= 30, 
				stashslots 	= 30,

            },
        },
    },
    [6] = {
        Name = "Special Wagons",
		Image = "items/sirevlc_wagon_specials.png",				
        Variants = {
            [1] = {
                name = "Circus Wagon#1",
                model = `wagonCircus01x`,
                price = 5000,
				gold  = 0.0,
                jobreq = false,
				jobs = {{DB_JOB = "horsetrainer", JOB_LABEL = "Horsetrainer" } },
				stashlimit 	= 30, 
				stashslots 	= 30,

            },
            [2] = {
                name = "Circus Wagon#2",
                model = `wagonCircus02x`,
                price = 5000,
				gold  = 0.0,
                jobreq = false,
				jobs = {{DB_JOB = "horsetrainer", JOB_LABEL = "Horsetrainer" } },
				stashlimit 	= 30, 
				stashslots 	= 30,

            },
            [3] = {
                name = "Dairy Wagon",
                model = `wagondairy01x`,
                price = 5000,
				gold  = 0.0,
                jobreq = false,
				jobs = {{DB_JOB = "horsetrainer", JOB_LABEL = "Horsetrainer" } },
				stashlimit 	= 30, 
				stashslots 	= 30,

            },
            [4] = {
                name = "Doctor Wagon",
                model = `wagonDoc01x`,
                price = 5000,
				gold  = 0.0,
                jobreq = false,
				jobs = {{DB_JOB = "horsetrainer", JOB_LABEL = "Horsetrainer" } },
				stashlimit 	= 30, 
				stashslots 	= 30,

            },
            [5] = {
                name = "Traveller Wagon#1",
                model = `wagontraveller01x`,
                price = 2000,
				gold  = 0.0,
                jobreq = false,
				jobs = {{DB_JOB = "horsetrainer", JOB_LABEL = "Horsetrainer" } },
				stashlimit 	= 30, 
				stashslots 	= 30,

            },
            [6] = {
                name = "Traveller Wagon#2",
                model = `wagonWork01x`,
                price = 5000,
				gold  = 0.0,
                jobreq = false,
				jobs = {{DB_JOB = "horsetrainer", JOB_LABEL = "Horsetrainer" } },
				stashlimit 	= 30, 
				stashslots 	= 30,

            },
        },
    }
}



------------------------------------
	   --WAGONS CUSTOMIZATION--
------------------------------------
--------------------------------------------------------------------
-- You can change two last values except if it's "NOEQUIPMENT"
-- Model,name,price
--------------------------------------------------------------------

Config.Customization = {
    [1] = {
        Name = "Propsets",
        [`cart01`] = {
            {0,"Remove element",0},
            {`pg_re_checkpoint02x_food`,                  "Propset#1",    50},
            {`pg_re_moonshineCampgroupCart01x`,           "Propset#2",   100},
            {`pg_teamster_cart01_breakables`,             "Propset#3",   100},
            {`pg_teamster_cart01_gen`,                    "Propset#4",   100},
            {`pg_teamster_cart01_tnt`,                    "Propset#5",   100},
            {`pg_veh_cart01_1`,                           "Propset#6",    50},
            {`pg_veh_cart01_2`,                           "Propset#7",    50},
            {`pg_veh_cart01_3`,                           "Propset#8",    50},
        },                                                                       
                                                                                 
        [`cart07`] = { 
            {0,"Remove element",0},        
            {`pg_teamster_cart07_breakables`,             "Propset#1",    48},
            {`pg_teamster_cart07_gen`,                    "Propset#2",    48},
            {`pg_teamster_cart07_tnt`,                    "Propset#3",    48},
            {`pg_veh_cart07_1`,                           "Propset#4",    48},
            {`pg_veh_cart07_2`,                           "Propset#5",    48},
        },                                                                       
        [`cart08`] = {  
            {0,"Remove element",0},            
            {`pg_teamster_cart08_breakables`,             "Propset#1",    35},
            {`pg_teamster_cart08_gen`,                    "Propset#2",    35},
            {`pg_teamster_cart08_tnt`,                    "Propset#3",    35},
            {`pg_veh_cart08_1`,                           "Propset#4",    35},
            {`pg_veh_cart08_2`,                           "Propset#5",    35},
        },
        
        [`chuckwagon000x`] = {
            {0,"Remove element",0},
            {`pg_teamster_chuckwagon000x_breakables`,   "Propset#01",    60},
            {`pg_teamster_chuckwagon000x_gen`,          "Propset#02",    45},
            {`pg_teamster_chuckwagon000x_tnt`,          "Propset#03",    150},
            {`pg_veh_chuckwagon000x_1`,                 "Propset#04",    35},
            {`pg_veh_chuckwagon000x_2`,                 "Propset#05",    35},
            {`pg_veh_chuckwagon000x_3`,                 "Propset#06",    35},
            {`pg_veh_chuckwagon000x_2a`,                "Propset#07",    35},
            {`pg_veh_chuckwagon000x_3a`,                "Propset#08",    35},
            {`pg_veh_chuckwagon000x_4`,                 "Propset#09",    35},
            {`pg_veh_chuckwagon000x_orange_1`,          "Propset#10",    45},
            {`pg_vehload_cotton01`,                     "Propset#11",    55},
            {`pg_vehload_crates01`,                     "Propset#12",    55},
            {`pg_vehload_haybale01`,                    "Propset#13",    55},
            {`pg_vehload_livestock01`,                  "Propset#14",    55},
            {`pg_vehload_lumber01`,                     "Propset#15",    55},
            {`pg_vehload_sacks01`,                      "Propset#16",    55},
            {`pg_vl_blacksmith01`,                      "Propset#17",    43},
            {`pg_vl_butcher01`,                         "Propset#18",    50},
            {`pg_vl_craftsman01`,                       "Propset#19",    50},
            {`pg_vl_delivery01`,                        "Propset#20",    50},
            {`pg_vl_farmer01`,                          "Propset#21",    50},
            {`pg_vl_farmer02`,                          "Propset#22",    50},
            {`pg_vl_ferrier01`,                         "Propset#23",    50},
            {`pg_vl_fisherman01`,                       "Propset#24",    50},
            {`pg_vl_hunter01`,                          "Propset#25",    50},
            {`pg_vl_rancher01`,                         "Propset#26",    64},
            {`pg_vl_rancher02`,                         "Propset#27",    64},
            {`pg_vl_rancher03`,                         "Propset#28",    64},
            {`pg_vl_rancher04`,                         "Propset#29",    64},
            {`pg_vl_rancher05`,                         "Propset#30",    64},
            {`pg_vl_tradesman01`,                       "Propset#31",    45},
            {`pg_vl_tradesman02`,                       "Propset#32",    45},
            {`pg_vl_tradesman03`,                       "Propset#33",    45},
            {`pg_vl_tradesman04`,                       "Propset#34",    45},
            {`pg_vl_movingFamily01`,                    "Propset#35",    45},            
            {`pg_re_fleeingfamily01x`,                  "Propset#36",    45},            
            {`pg_vl_travellingFamily01`,                "Propset#37",    45},
            {`pg_vl_travellingLabour01`,                "Propset#38",    45},
        },

        [`stagecoach005x`] = {
            {0,"Remove element",0},
            {`pg_veh_stagecoach005x_1`,                  "Propset#1",     100},
            {`pg_veh_stagecoach005x_2`,                  "Propset#2",     200},
        },

        [`supplywagon`] = {
            {0,"Remove element",0},
            {`pg_mission_cornwall1_01x`,                 "Propset#1",     46},
            {`pg_mp_moonshinebiz_supplies02x_supwag`,    "Propset#2",     46},
            {`pg_teamster_supplywagon_breakables`,       "Propset#3",     46},
            {`pg_teamster_supplywagon_gen`,              "Propset#4",     46},
            {`pg_teamster_supplywagon_tnt`,              "Propset#5",     46},
            {`pg_delivery_Cotton01x`,                    "Propset#6",     46},       
        },                                                                     

        [`utilliwag`] = {
            {0,"Remove element",0},
            {`pg_cs_marston101x`,                       "Propset#01",     35},
            {`pg_mission_marston1_supplies01x`,         "Propset#02",     35},
            {`pg_mission_marston1_supplies02x`,         "Propset#03",     35},
            {`pg_mission_marston2_postoffice01x`,       "Propset#04",     35},
            {`pg_mission_native2_01x`,                  "Propset#05",     35},
            {`pg_rc_dinoLady01x`,                       "Propset#06",     35},
            {`pg_teamster_utilitywag_breakables`,       "Propset#07",     35},
            {`pg_teamster_utilitywag_gen`,              "Propset#08",     35},
            {`pg_teamster_utilitywag_tnt`,              "Propset#09",     35},
            {`pg_veh_utilliwag_1`,                      "Propset#10",     35},
            {`pg_veh_utilliwag_2`,                      "Propset#11",     35},
            {`pg_veh_utilliwag_3`,                      "Propset#12",     35},
            {`pg_veh_utilliwag_orange_1`,               "Propset#13",     35},   
        },

        [`wagon02x`] = {
            {0,"Remove element",0},
            {`pg_vehload_cotton01`,                      "Propset#01", 45},        
            {`pg_gunforhire01x`,                         "Propset#02", 45},
            {`pg_gunforhire02x`,                         "Propset#03", 45},
            {`pg_gunforhire03x`,                         "Propset#04", 45},
            {`Pg_Mis_Mud1_Wagon02x`,                     "Propset#05", 45},
            {`Pg_Mis_Mud1_Wagon02x_NoLooseProps`,        "Propset#06", 45},
            {`pg_mission_caravanWagon02x`,               "Propset#07", 45},    
            {`pg_mission_mud1_wagon03x`,                 "Propset#08", 45},
            {`pg_re_supplyDelivery01x`,                  "Propset#09", 45},
            {`pg_sp_MarstonsWagon02x`,                   "Propset#10", 45},           
            {`pg_mission_ammoDeal`,                      "Propset#11", 45},
            {`pg_mission_marston7_lumber01x`,            "Propset#12", 45},
            {`pg_mission_marston7_lumber02x`,            "Propset#13", 45},
            {`pg_mission_marston7_lumber03x_doneloading`,"Propset#14", 45},
            {`pg_mission_tntwagon01x`,                   "Propset#15", 45},
            {`pg_teamster_wagon02x_tnt`,                 "Propset#16", 45},           
            {`pg_mission_trainRob4_Wagon02x_dynamite`,   "Propset#17", 150},           
            {`pg_mission_trainrob3_start01x`,            "Propset#18", 45},
            {`pg_mission_weaponsDeal`,                   "Propset#19", 45},
            {`pg_mission_winter1_4thwagon01x`,           "Propset#20", 45},
            {`pg_rc_BeauAndPene101x`,                    "Propset#21", 45},
            {`pg_rc_beauandpene201x`,                    "Propset#22", 45},
            {`pg_rc_forgiven601x`,                       "Propset#23", 45},
            {`pg_rc_saddiesupplies00x`,                  "Propset#24", 45},
            {`pg_rc_saddiesupplies01x`,                  "Propset#25", 45},           
            {`pg_rc_nativewagoncornwall01x`,             "Propset#26", 45},
            {`pg_re_armsdeal01x`,                        "Propset#27", 45},
            {`pg_re_odriscollwagon01x`,                  "Propset#28", 45},
            {`pg_re_supplydelivery_gsmith01x`,           "Propset#29", 45},
            {`pg_re_trainholdup01x`,                     "Propset#30", 45},
            {`pg_teamster_wagon02x_breakables`,          "Propset#31", 45},
            {`pg_teamster_wagon02x_gen`,                 "Propset#32", 45},
            {`pg_teamster_wagon02x_gen02`,               "Propset#33", 45},
            {`pg_wagon02xClimbtest01x`,                  "Propset#34", 45},
            {`pg_veh_wagon02x_1`,                        "Propset#35", 45},
            {`pg_veh_wagon02x_2`,                        "Propset#36", 45},
            {`pg_veh_wagon02x_3`,                        "Propset#37", 45},
            {`pg_vl_blacksmith01`,                       "Propset#38", 45},                        
            {`pg_vl_butcher01`,                          "Propset#39", 45},
            {`pg_vl_craftsman01`,                        "Propset#40", 45},
            {`pg_vl_delivery01`,                         "Propset#41", 45},
            {`pg_vl_farmer01`,                           "Propset#42", 45},
            {`pg_vl_farmer02`,                           "Propset#43", 45},
            {`pg_vl_ferrier01`,                          "Propset#44", 45},
            {`pg_vl_fisherman01`,                        "Propset#45", 45},
            {`pg_vl_hunter01`,                           "Propset#46", 45},
            {`pg_vl_movingFamily01`,                     "Propset#47", 45},
            {`pg_vl_rancher01`,                          "Propset#48", 45},
            {`pg_vl_rancher02`,                          "Propset#49", 45},
            {`pg_vl_rancher03`,                          "Propset#50", 45},
            {`pg_vl_rancher04`,                          "Propset#51", 45},
            {`pg_vl_rancher05`,                          "Propset#52", 45},
            {`pg_vl_tradesman01`,                        "Propset#53", 45},
            {`pg_vl_tradesman02`,                        "Propset#54", 45},
            {`pg_vl_tradesman03`,                        "Propset#55", 45},
            {`pg_vl_tradesman04`,                        "Propset#56", 45},
            {`pg_vl_travellingFamily01`,                 "Propset#57", 45},
            {`pg_vl_travellingLabour01`,                 "Propset#58", 45},
        },

        [`wagon04x`] = {
            {0,"Remove element",0},
            {`pg_gunforhire01x`,                       "Propset#01",   45},
            {`pg_gunforhire02x`,                       "Propset#02",   45},
            {`pg_gunforhire03x`,                       "Propset#03",   45},
            {`pg_mission_caravanWagon04x`,             "Propset#04",   45},
            {`pg_mission_mud1_jackwagon01x`,           "Propset#05",   45},
            {`pg_mission_mud1_wagon01x`,               "Propset#06",   45},
            {`pg_mission_mud1_wagon02x`,               "Propset#07",   45},
            {`pg_mission_winter1_keiranWag01x`,        "Propset#08",   45},
            {`pg_mission_winter1_wag04_01x`,           "Propset#09",   45},
            {`pg_teamster_wagon04x_breakables`,        "Propset#10",   45},
            {`pg_teamster_wagon04x_gen`,               "Propset#11",   45},
            {`pg_teamster_wagon04x_gen02`,             "Propset#12",   45},
            {`pg_teamster_wagon04x_tnt`,               "Propset#13",   150},
            {`pg_veh_wagon04x_1`,                      "Propset#14",   45},
            {`pg_veh_wagon04x_2`,                      "Propset#15",   45},
            {`pg_veh_wagon04x_3`,                      "Propset#16",   45},
            {`pg_vl_blacksmith01`,                     "Propset#17",   45},
            {`pg_vl_butcher01`,                        "Propset#18",   45},
            {`pg_vl_craftsman01`,                      "Propset#19",   45},
            {`pg_vl_delivery01`,                       "Propset#20",   45},
            {`pg_vl_farmer01`,                         "Propset#21",   45},
            {`pg_vl_farmer02`,                         "Propset#22",   45},
            {`pg_vl_ferrier01`,                        "Propset#23",   45},
            {`pg_vl_fisherman01`,                      "Propset#24",   45},
            {`pg_vl_hunter01`,                         "Propset#25",   45},
            {`pg_vl_movingFamily01`,                   "Propset#26",   45},
            {`pg_vl_rancher01`,                        "Propset#27",   45},
            {`pg_vl_rancher02`,                        "Propset#28",   45},
            {`pg_vl_rancher03`,                        "Propset#29",   45},
            {`pg_vl_rancher04`,                        "Propset#30",   45},
            {`pg_vl_rancher05`,                        "Propset#31",   45},
            {`pg_vl_tradesman01`,                      "Propset#32",   45},
            {`pg_vl_tradesman02`,                      "Propset#33",   45},
            {`pg_vl_tradesman03`,                      "Propset#34",   45},
            {`pg_vl_tradesman04`,                      "Propset#35",   45},
            {`pg_vl_travellingFamily01`,               "Propset#36",   45},
            {`pg_vl_travellingLabour01`,               "Propset#37",   45},
            {`pg_veh_germFam_wagon04x_01`,             "Propset#38",   45},     
        },

        [`wagon05x`] = {
            {0,"Remove element",0},
            {`pg_delivery_CKToil01x`,                   "Propset#01",    45},  
            {`pg_delivery_Orange01x`,                   "Propset#02",    45},  
            {`pg_gunforhire01x`,                        "Propset#03",    45},  
            {`pg_gunforhire02x`,                        "Propset#04",    45},  
            {`pg_gunforhire03x`,                        "Propset#05",    45},  
            {`pg_ls_soldier2_01x`,                      "Propset#06",    45},  
            {`pg_mission_bra1_wagon`,                   "Propset#07",    45},  
            {`pg_mission_brt1_jump01x`,                 "Propset#08",    45},  
            {`pg_mission_brt1_tomansion01x`,            "Propset#09",    45},  
            {`pg_mission_brt2`,                         "Propset#10",    45},  
            {`pg_mission_BRT2_escape01x`,               "Propset#11",    45},  
            {`pg_mission_brt3`,                         "Propset#12",    45},  
            {`pg_mission_caravanWagon05x`,              "Propset#13",    45},  
            {`pg_mission_moonshineSupplies`,            "Propset#14",    45},  
            {`pg_rc_ridethelightning01x`,               "Propset#15",    45},  
            {`pg_re_checkpoint01x`,                     "Propset#16",    45},  
            {`pg_re_savagewagon01x`,                    "Propset#17",    45},  
            {`pg_teamster_wagon05x_breakables`,         "Propset#18",    45},  
            {`pg_teamster_wagon05x_gen`,                "Propset#19",    45},  
            {`pg_teamster_wagon05x_tnt`,                "Propset#20",    150},  
            {`pg_veh_wagon05x_1`,                       "Propset#21",    45},  
            {`pg_veh_wagon05x_2`,                       "Propset#22",    45},  
            {`pg_veh_wagon05x_3`,                       "Propset#23",    45},  
            {`pg_veh_wagon05x_4`,                       "Propset#24",    45},  
            {`pg_veh_wagon05x_5`,                       "Propset#25",    45},  
            {`pg_veh_wagon05x_cotton`,                  "Propset#26",    45},  
        },

        [`wagon06x`] = {
            {0,"Remove element",0},
            {`pg_teamster_wagon06x_breakables`,          "Propset#1",     50},
            {`pg_teamster_wagon06x_gen`,                 "Propset#2",     50},
            {`pg_teamster_wagon06x_tnt`,                 "Propset#3",    100},
            {`pg_veh_wagon06x_1`,                        "Propset#4",     50},
            {`pg_veh_wagon06x_2`,                        "Propset#5",     50},
            {`pg_veh_wagon06x_3`,                        "Propset#6",     50},
        },

        [`CART02`] = {
            {0,"Remove element",0},
            {`pg_mission_caravanCart02x`,                "Propset#1",   100},
            {`pg_teamster_cart02_breakables`,            "Propset#2",    50},
            {`pg_teamster_cart02_gen`,                   "Propset#3",    50},
            {`pg_teamster_cart02_tnt`,                   "Propset#4",    150},    
        },

        [`cart03`] = {
            {0,"Remove element",0},
            {`pg_delivery_Coal02x`,                      "Propset#1",    50},
            {`pg_mp_moonshinebiz_supplies01x_cart03`,    "Propset#2",    50},
            {`pg_teamster_cart03_breakables`,            "Propset#3",    50},
            {`pg_teamster_cart03_gen`,                   "Propset#4",    50},
            {`pg_teamster_cart03_tnt`,                   "Propset#5",    150},
            {`pg_veh_cart03_1`,                          "Propset#6",    50},
            {`pg_veh_cart03_2`,                          "Propset#7",    50},
            {`pg_veh_cart03_barrels01x`,                 "Propset#8",    50},  
        },

        [`cart04`] = { 
            {0,"Remove element",0},
            {`pg_mission_caravanCart04x`,               "Propset#1",     50},  
            {`pg_teamster_cart04_breakables`,           "Propset#2",     50},  
            {`pg_teamster_cart04_gen`,                  "Propset#3",     50},
            {`pg_teamster_cart04_tnt`,                  "Propset#4",     150},
            {`pg_veh_cart04_1`,                         "Propset#5",     50},
            {`pg_veh_cart04_2`,                         "Propset#6",     50},     
        },

        [`cart06`] = {  
            {0,"Remove element",0},        
            {`pg_teamster_cart06_breakables`,           "Propset#1",     50},
            {`pg_teamster_cart06_gen`,                  "Propset#2",     50},
            {`pg_teamster_cart06_tnt`,                  "Propset#3",     150},
            {`pg_veh_cart06_1`,                         "Propset#4",     50},
            {`pg_veh_cart06_2`,                         "Propset#5",     50},  
        },

        [`coal_wagon`] = {
            {0,"Remove element",0},
            {`pg_delivery_Coal01x`,                   "Propset#01",      100},
        },                                                                     

        [`huntercart01`] = {                                                   
            {0,"Remove element",0},
            {`pg_mp005_huntingWagonTarp01`,           "Propset#01",      100},
        },                                                                     

        [`logwagon`] = {                                                       
            {0,"Remove element",0},
            {`pg_veh_logwagon_1`,                     "Propset#01",      100},
        },                                                                     

        [`logwagon2`] = {                                                      
            {0,"Remove element",0},
            {`pg_veh_logwagon2_1`,                    "Propset#01",      100},
        },                                                                     

        [`stagecoach003x`] = {                                                 
            {0,"Remove element",0},
            {`pg_veh_stagecoach003x_bootA`,            "Propset#01",     100},
        },                                                   

        [`stagecoach004x`] = {                               
            {0,"Remove element",0},
            {`pg_mission_utp2_coachLockbox`,           "Propset#1",     100},
            {`pg_teamster_armourwag_breakables`,       "Propset#2",     100},
            {`pg_teamster_armourwag_gen`,              "Propset#3",     100},
            {`pg_teamster_armourwag_tnt`,              "Propset#4",     100},
        },                                                                 

        [`stagecoach006x`] = {                                             
            {0,"Remove element",0},
            {`pg_veh_stagecoach006x_1`,                "Propset#1",     100},
            {`pg_veh_stagecoach006x_2`,                "Propset#2",     100},
        },

        [`CHUCKWAGON002X`] = {
            {0,"Remove element",0},
            {`pg_rc_exconfederates1_01x`,             "Propset#01",   100},
            {`pg_teamster_chuckwagon002x_breakables`, "Propset#02",   100},
            {`pg_teamster_chuckwagon002x_gen`,        "Propset#03",   100},
            {`pg_teamster_chuckwagon002x_tnt`,        "Propset#04",   100},
            {`pg_veh_chuckwagon002x_1`,               "Propset#05",   100},
            {`pg_veh_chuckwagon002x_2`,               "Propset#06",   100},
            {`pg_veh_chuckwagon002x_3`,               "Propset#07",   100},
            {`pg_vl_blacksmith01`,                    "Propset#08",   100},
            {`pg_vl_butcher01`,                       "Propset#09",   100},
            {`pg_vl_travellingLabour01`,              "Propset#10",   100},    
            {`pg_vl_craftsman01`,                     "Propset#11",   100},
            {`pg_vl_delivery01`,                      "Propset#12",   100},
            {`pg_vl_farmer01`,                        "Propset#13",   100},
            {`pg_vl_farmer02`,                        "Propset#14",   100},
            {`pg_vl_ferrier01`,                       "Propset#15",   100},
            {`pg_vl_fisherman01`,                     "Propset#16",   100},
            {`pg_vl_hunter01`,                        "Propset#17",   100},
            {`pg_vl_movingFamily01`,                  "Propset#18",   100},
            {`pg_vl_rancher01`,                       "Propset#19",   100},
            {`pg_vl_rancher02`,                       "Propset#20",   100},
            {`pg_vl_rancher03`,                       "Propset#21",   100},
            {`pg_vl_rancher04`,                       "Propset#22",   100},
            {`pg_vl_rancher05`,                       "Propset#23",   100},
            {`pg_vl_tradesman01`,                     "Propset#24",   100},
            {`pg_vl_tradesman02`,                     "Propset#25",   100},
            {`pg_vl_tradesman03`,                     "Propset#26",   100},
            {`pg_vl_tradesman04`,                     "Propset#27",   100},
            {`pg_vl_travellingFamily01`,              "Propset#28",   100},
        },

        [`supplywagon2`] = {
            {0,"Remove element",0},
            {`pg_mission_mud4_strauswag01x`,          "Propset#1",    100},  
            {`pg_mission_mud4_strauswag02x`,          "Propset#2",    100},  
        },                                                                 
                                                                         
        [`wagondairy01x`] = { 
            {0,"Remove element",0},
            {`pg_delivery_dairy01x`,                  "Propset#01",    100},  
        },

        [`STAGECOACH002X`] = {
            {0,"Remove element",0},
            {`pg_veh_stagecoach002x_1`,               "Propset#1",     100},  
            {`pg_veh_stagecoach002x_2`,               "Propset#2",     100},  
            {`pg_veh_stagecoach002x_bootA`,           "Propset#3",     100},  
        },                                                                 

        [`STAGECOACH001X`] = {
            {0,"Remove element",0},        
            {`pg_veh_stagecoach001x_1`,               "Propset#1",     100},  
            {`pg_veh_stagecoach001x_2`,               "Propset#2",     100},  
        },                                                                    

        [`COACH2`] = { 
            {0,"Remove element",0},
            {`pg_mission_mary3_01x`,                  "Propset#1",     100},  
            {`pg_re_coachrobbery01x`,                 "Propset#2",     100},  
            {`pg_veh_coach2_1`,                       "Propset#3",     100},  
            {`pg_veh_coach2_bootA`,                   "Propset#4",     100},  
        },                                                                    

        [`gatchuck`] = { 
            {0,"Remove element",0},
            {`pg_mission_native2_01x`,                "Propset#1",     100},  
            {`pg_teamster_payroll01x_gat`,            "Propset#2",     100},   
        },                                                                    

        [`armysupplywagon`] = { 
            {0,"Remove element",0},
            {`pg_rc_monroe1_01x`,                     "Propset#01",     100},  
        },

        -- NOEQUIPMENT entries: on garde seulement la table sans index numérotés
        [`bountywagon01x`] = {
            {0,"NOEQUIPMENT",0},
        },
        [`cart05`] = {
            {0,"NOEQUIPMENT",0},
        },        
        [`wagonCircus01x`] = {
            {0,"NOEQUIPMENT",0},
        },
        [`wagonCircus02x`] = {
            {0,"NOEQUIPMENT",0},
        },
        [`wagondoc01x`] = {
            {0,"NOEQUIPMENT",0},
        },
        [`buggy01`] = {
            {0,"NOEQUIPMENT",0},
        },
        [`buggy02`] = {
            {0,"NOEQUIPMENT",0},
        },
        [`buggy03`] = {
            {0,"NOEQUIPMENT",0},
        },        
        [`coach3`] = {
            {0,"NOEQUIPMENT",0},
        },
        [`coach3_cutscene`] = {
            {0,"NOEQUIPMENT",0},
        },
        [`coach4`] = {
            {0,"NOEQUIPMENT",0},
        },
        [`coach5`] = {
            {0,"NOEQUIPMENT",0},
        },
        [`coach6`] = {
            {0,"NOEQUIPMENT",0},
        },
        [`oilWagon01x`] = {
            {0,"NOEQUIPMENT",0},
        },
        [`oilWagon02x`] = {
            {0,"NOEQUIPMENT",0},
        },
        [`policeWagongatling01x`] = {
            {0,"NOEQUIPMENT",0},
        },
        [`wagonPrison01x`] = {
            {0,"NOEQUIPMENT",0},
        },
        [`wagontraveller01x`] = {
            {0,"NOEQUIPMENT",0},
        },
        [`wagonwork01x`] = {
            {0,"NOEQUIPMENT",0},
        },
        [`warwagon2`] = {
            {0,"NOEQUIPMENT",0},
        },
        [`POLICEWAGON01X`] = {
            {0,"NOEQUIPMENT",0},
        }, 
        [`gatchuck_2`] = {
            {0,"NOEQUIPMENT",0},
        }, 
        [`STAGECOACH004_2x`] = {
            {0,"NOEQUIPMENT",0},
        }, 
        [`wagonarmoured01x`] = {
            {0,"NOEQUIPMENT",0},
        },
        [`wagon03x`] = {
            {0,"NOEQUIPMENT",0},
        },
    },

    [2] = {
        Name = "Extras",

		[`POLICEWAGON01X`] = {
			{-1,"No extras", 0},
			{5,"Extra#1", 100},
		},
		
		[`gatchuck_2`] = {
			{-1,"No extras", 0},
			{5,"Extra#1", 100},
		},
		
		[`STAGECOACH004_2x`] = {
			{-1,"No extras", 0},
			{5,"Extra#1", 100},
			{6,"Extra#2", 100},
			{7,"Extra#3", 100},
		},
		
		[`STAGECOACH002X`] = {
			{-1,"No extras", 0},
			{1,"Extra#1", 100},
			{2,"Extra#2", 100},
		},
		
		[`STAGECOACH001X`] = {
			{-1,"No extras", 0},
			{1,"Extra#1", 100},
			{2,"Extra#2", 100},
		},
		
		[`COACH2`] = {
			{-1,"No extras", 0},
			{1,"Extra#1", 100},
			{2,"Extra#2", 100},
			{3,"Extra#3", 100},
			{5,"Extra#4", 100},
		},
		
		[`gatchuck`] = {
			{-1,"No extras", 0},
			{1,"Extra#1", 100},
			{2,"Extra#2", 100},
			{3,"Extra#3", 100},
			{4,"Extra#4", 100},
		},
		
		[`cart01`] = {
			{-1,"No extras", 0},
			{1, "Extra#1",100},
			{4, "Extra#2",100},
		},
		
		[`bountywagon01x`] = {
			{-1,"No extras", 0},
			{5,"Extra#1", 100},
		},
		
		[`cart05`] = {
			{-1,"No extras", 0},
			{1,"Extra#1", 100},
			{2,"Extra#2", 100},
			{3,"Extra#3", 100},
		},
		
		[`cart07`] = {
			{-1,"No extras", 0},
			{1,"Extra#1", 100},
		},
		
		[`cart08`] = {
			{-1,"No extras", 0},
			{4,"Extra#1", 100},
		},
		
		[`chuckwagon000x`] = {
			{-1,"No extras", 0},
			{1,"Extra#1", 100},
			{2,"Extra#2", 100},
			{3,"Extra#3", 100},
			{5,"Extra#4", 100},
		},
		
		[`CHUCKWAGON002X`] = {
			{-1,"No extras", 0},
			{1,"Extra#1", 100},
			{2,"Extra#2", 100},
			{3,"Extra#3", 100},
			{5,"Extra#4", 100},
		},
		
		[`stagecoach005x`] = {
			{-1,"No extras", 0},
			{1,"Extra#1", 100},
		},
		
		[`supplywagon`] = {
			{-1,"No extras", 0},
			{1,"Extra#1", 100},
			{2,"Extra#2", 100},
			{4,"Extra#3", 100},
		},
		
		[`utilliwag`] = {
			{-1,"No extras", 0},
			{2,"Extra 1", 100},
		},
		
		[`wagon02x`] = {
			{-1,"No extras", 0},
			{1,"Extra#1", 100},
			{2,"Extra#2", 100},
			{3,"Extra#3", 100},
			{5,"Extra#4", 100},
		},
		
		[`wagon04x`] = {
			{-1,"No extras", 0},
			{1,"Extra#1", 100},
			{2,"Extra#2", 100},
			{3,"Extra#3", 100},
			{5,"Extra#4", 100},
		},
		
		[`wagon05x`] = {
			{-1,"No extras", 0},
			{5,"Extra#1", 100},
		},
		
		[`wagon06x`] = {
			{-1,"No extras", 0},
			{0,"Extra#1", 100},
			{1,"Extra#2", 100},
			{2,"Extra#3", 100},
			{5,"Extra#4", 100},
		},


        [`wagonCircus01x`] = {
			{-1,"No extras", 0},		
            {1,"Extra#1", 100},
        },                      

        [`wagonCircus02x`] = {
			{-1,"No extras", 0},		
            {1,"Extra#1", 100},
        },                      

        [`wagondoc01x`] = { 
			{-1,"No extras", 0},		
            {1, "Extra#1", 100},
        },

        [`CART02`] = {
            {0,"NOEQUIPMENT",0},
        },

        [`buggy01`] = {
            {0,"NOEQUIPMENT",0},
        },

        [`buggy02`] = {
            {0,"NOEQUIPMENT",0},
        },

        [`buggy03`] = {
            {0,"NOEQUIPMENT",0},
        },

        [`cart03`] = {
            {0,"NOEQUIPMENT",0},
        },

        [`cart04`] = {
            {0,"NOEQUIPMENT",0},
        },

        [`cart06`] = {
            {0,"NOEQUIPMENT",0},
        },

        [`coach3`] = {
            {0,"NOEQUIPMENT",0},
        },

        [`coach3_cutscene`] = {
            {0,"NOEQUIPMENT",0},
        },

        [`coach4`] = {
            {0,"NOEQUIPMENT",0},
        },

        [`coach5`] = {
            {0,"NOEQUIPMENT",0},
        },

        [`coach6`] = {
            {0,"NOEQUIPMENT",0},
        },

        [`coal_wagon`] = {
            {0,"NOEQUIPMENT",0},
        },

        [`huntercart01`] = {
            {0,"NOEQUIPMENT",0},
        },

        [`logwagon`] = {
            {0,"NOEQUIPMENT",0},
        },

        [`logwagon2`] = {
            {0,"NOEQUIPMENT",0},
        },

        [`oilWagon01x`] = {
            {0,"NOEQUIPMENT",0},
        },

        [`oilWagon02x`] = {
            {0,"NOEQUIPMENT",0},
        },

        [`policeWagongatling01x`] = {
            {0,"NOEQUIPMENT",0},
        },

        [`stagecoach003x`] = {
            {0,"NOEQUIPMENT",0},
        },

        [`stagecoach004x`] = {
            {0,"NOEQUIPMENT",0},
        },

        [`stagecoach006x`] = {
            {0,"NOEQUIPMENT",0},
        },

        [`supplywagon2`] = {
            {0,"NOEQUIPMENT",0},
        },

        [`wagon03x`] = {
            {0,"NOEQUIPMENT",0},
        },

        [`wagonarmoured01x`] = {
            {0,"NOEQUIPMENT",0},
        },

        [`wagondairy01x`] = {
            {0,"NOEQUIPMENT",0},
        },

        [`wagonPrison01x`] = {
            {0,"NOEQUIPMENT",0},
        },

        [`wagontraveller01x`] = {
            {0,"NOEQUIPMENT",0},
        },

        [`wagonwork01x`] = {
            {0,"NOEQUIPMENT",0},
        },

        [`warwagon2`] = {
            {0,"NOEQUIPMENT",0},
        },

        [`armysupplywagon`] = {
            {0,"NOEQUIPMENT",0},
        },
    },


    [3] = {
        Name = "Lanterns",

 [`cart01`] = {
    {-1,"No lanterns", 0},
    {`pg_teamster_cart01_lightupgrade1`,"Upgrade#1",25},
    {`pg_teamster_cart01_lightupgrade2`,"Upgrade#2",50},
    {`pg_teamster_cart01_lightupgrade3`,"Upgrade#3",100},
    {`pg_veh_cart01_lanterns01`,        "Upgrade#4",40},
},

[`bountywagon01x`] = {
    {-1,"No lanterns", 0},
    {`pg_teamster_chuckwagon002x_lightupgrade1`,"Upgrade#1",50},
    {`pg_teamster_chuckwagon002x_lightupgrade2`,"Upgrade#2",100},
    {`pg_teamster_chuckwagon002x_lightupgrade3`,"Upgrade#3",150},
    {`pg_veh_chuckwagon002x_lanterns01`,        "Upgrade#4",100},
},

[`chuckwagon000x`] = {
    {-1,"No lanterns", 0},
    {`pg_teamster_chuckwagon000x_lightupgrade1`,"Upgrade#1",50},
    {`pg_teamster_chuckwagon000x_lightupgrade2`,"Upgrade#2",100},
    {`pg_teamster_chuckwagon000x_lightupgrade3`,"Upgrade#3",150},
    {`pg_veh_chuckwagon000x_lanterns`,          "Upgrade#4",100},
},

[`CHUCKWAGON002X`] = {
    {-1,"No lanterns", 0},
    {`pg_teamster_chuckwagon002x_lightupgrade1`,"Upgrade#1",50},
    {`pg_teamster_chuckwagon002x_lightupgrade2`,"Upgrade#2",100},
    {`pg_teamster_chuckwagon002x_lightupgrade3`,"Upgrade#3",150},
    {`pg_veh_chuckwagon002x_lanterns01`,        "Upgrade#4",50},
},

[`utilliwag`] = {
    {-1,"No lanterns", 0},
    {`pg_veh_utilliwag_lightupgrade_1`,"Upgrade#1",50},
    {`pg_veh_utilliwag_lightupgrade_2`,"Upgrade#2",100},
    {`pg_veh_utilliwag_lightupgrade_3`,"Upgrade#3",150},
    {`pg_veh_utilliwag_lanterns01`,    "Upgrade#4",100},
},

[`wagon02x`] = {
    {-1,"No lanterns", 0},
    {`pg_teamster_wagon02x_lightupgrade1`,"Upgrade#1",50},
    {`pg_teamster_wagon02x_lightupgrade2`,"Upgrade#2",100},
    {`pg_teamster_wagon02x_lightupgrade3`,"Upgrade#3",150},
    {`pg_veh_wagon02x_lanterns01`,        "Upgrade#4",100},
    {`pg_veh_wagonsuffrage_lanterns01`,   "Upgrade#5",100},
},

[`wagon04x`] = {
    {-1,"No lanterns", 0},
    {`pg_teamster_wagon04x_lightupgrade1`,"Upgrade#1",50},
    {`pg_teamster_wagon04x_lightupgrade2`,"Upgrade#2",100},
    {`pg_teamster_wagon04x_lightupgrade3`,"Upgrade#3",150},
    {`pg_veh_wagon04x_lanterns01`,        "Upgrade#4",100},
},

[`wagon05x`] = {
    {-1,"No lanterns", 0},
    {`pg_teamster_wagon05x_lightupgrade1`,"Upgrade#1",50},
    {`pg_teamster_wagon05x_lightupgrade2`,"Upgrade#2",100},
    {`pg_teamster_wagon05x_lightupgrade3`,"Upgrade#3",150},
    {`pg_veh_wagon05x_2_lanterns01`,      "Upgrade#4",50},
    {`pg_veh_wagon05x_lanterns01`,        "Upgrade#5",50},
    {`pg_veh_wagon05x_lanterns02`,        "Upgrade#6",50},
},

[`wagon06x`] = {
    {-1,"No lanterns", 0},
    {`pg_teamster_wagon06x_lightupgrade1`,"Upgrade#1",50},
    {`pg_teamster_wagon06x_lightupgrade2`,"Upgrade#2",100},
    {`pg_teamster_wagon06x_lightupgrade3`,"Upgrade#3",150},
},

[`cart06`] = {
    {-1,"No lanterns", 0},
    {`pg_re_deadbodies01x_lights`,      "Upgrade#1",100},
    {`pg_teamster_cart06_lightupgrade1`,"Upgrade#2",50},
    {`pg_teamster_cart06_lightupgrade2`,"Upgrade#3",100},
    {`pg_teamster_cart06_lightupgrade3`,"Upgrade#4",150},
    {`pg_veh_cart06_lanterns01`,        "Upgrade#5",100},
},

[`coal_wagon`] = {
    {-1,"No lanterns", 0},
    {`pg_teamster_coalwagon_lightupgrade1`,"Upgrade#1",50},
    {`pg_teamster_coalwagon_lightupgrade2`,"Upgrade#2",100},
    {`pg_teamster_coalwagon_lightupgrade3`,"Upgrade#3",100},
    {`pg_veh_coal_wagon_lanterns01`,       "Upgrade#4",100},
},

[`huntercart01`] = {
    {-1,"No lanterns", 0},
    {`pg_re_deadbodies01x_lights`,      "Upgrade#1",50},
    {`pg_teamster_cart06_lightupgrade1`,"Upgrade#2",50},
    {`pg_teamster_cart06_lightupgrade2`,"Upgrade#3",100},
    {`pg_teamster_cart06_lightupgrade3`,"Upgrade#4",150},
    {`pg_veh_cart06_lanterns01`,        "Upgrade#5",100},
},

[`policeWagongatling01x`] = {
    {-1,"No lanterns", 0},
    {`pg_veh_policeWagonGatling01x_lanterns01`,"Lantern",100},
},

[`stagecoach003x`] = {
    {-1,"No lanterns", 0},
    {`pg_veh_stagecoach003x_lanterns01`,"Lantern",100},
},

[`wagonarmoured01x`] = {
    {-1,"No lanterns", 0},
    {`pg_veh_wagonarmoured01x_lanterns01`,"Lantern",100},
},

[`wagonPrison01x`] = {
    {-1,"No lanterns", 0},
    {`pg_veh_wagonPrison01x_lanterns01`,"Lantern",100},
},

[`POLICEWAGON01X`] = {
    {-1,"No lanterns", 0},
    {`pg_veh_policeWagon01x_lanterns01`,"Lantern",100},
},

[`gatchuck`] = {
    {-1,"No lanterns", 0},
    {`pg_teamster_gatchuck_lightupgrade1`,"Upgrade#1",50},
    {`pg_teamster_gatchuck_lightupgrade2`,"Upgrade#2",100},
    {`pg_teamster_gatchuck_lightupgrade3`,"Upgrade#3",150},
    {`pg_veh_gatchuck_lanterns01`,        "Upgrade#4",100},
},

[`armysupplywagon`] = {
    {-1,"No lanterns", 0},
    {`pg_veh_ArmySupplyWagon_lanterns01`,"Lantern",100},
},
 
        -- NOEQUIPMENT

        [`cart05`] = {
            {0,"NOEQUIPMENT",0},
        },

        [`cart07`] = {
            {0,"NOEQUIPMENT",0},
        },

        [`cart08`] = {
            {0,"NOEQUIPMENT",0},
        },        

        [`stagecoach005x`] = {
            {0,"NOEQUIPMENT",0},
        },

        [`supplywagon`] = {
            {0,"NOEQUIPMENT",0},
        },        

        [`wagonCircus01x`] = {
            {0,"NOEQUIPMENT",0},
        },

        [`wagonCircus02x`] = {
            {0,"NOEQUIPMENT",0},
        },

        [`wagondoc01x`] = {
            {0,"NOEQUIPMENT",0},
        },

        [`CART02`] = {
            {0,"NOEQUIPMENT",0},
        },

        [`buggy01`] = {
            {0,"NOEQUIPMENT",0},
        },

        [`buggy02`] = {
            {0,"NOEQUIPMENT",0},
        },

        [`buggy03`] = {
            {0,"NOEQUIPMENT",0},
        },

        [`cart03`] = {
            {0,"NOEQUIPMENT",0},
        },

        [`cart04`] = {
            {0,"NOEQUIPMENT",0},
        },

        [`coach3`] = {
            {0,"NOEQUIPMENT",0},
        },

        [`coach3_cutscene`] = {
            {0,"NOEQUIPMENT",0},
        },

        [`coach4`] = {
            {0,"NOEQUIPMENT",0},
        },

        [`coach5`] = {
            {0,"NOEQUIPMENT",0},
        },

        [`coach6`] = {
            {0,"NOEQUIPMENT",0},
        },

        [`logwagon`] = {
            {0,"NOEQUIPMENT",0},
        },

        [`logwagon2`] = {
            {0,"NOEQUIPMENT",0},
        },

        [`oilWagon01x`] = {
            {0,"NOEQUIPMENT",0},
        },

        [`oilWagon02x`] = {
            {0,"NOEQUIPMENT",0},
        },

        [`stagecoach004x`] = {
            {0,"NOEQUIPMENT",0},
        },

        [`stagecoach006x`] = {
            {0,"NOEQUIPMENT",0},
        },

        [`supplywagon2`] = {
            {0,"NOEQUIPMENT",0},
        },

        [`wagon03x`] = {
            {0,"NOEQUIPMENT",0},
        },

        [`wagondairy01x`] = {
            {0,"NOEQUIPMENT",0},
        },

        [`wagontraveller01x`] = {
            {0,"NOEQUIPMENT",0},
        },

        [`wagonwork01x`] = {
            {0,"NOEQUIPMENT",0},
        },

        [`warwagon2`] = {
            {0,"NOEQUIPMENT",0},
        },

        [`gatchuck_2`] = {
            {0,"NOEQUIPMENT",0},
        }, 

        [`STAGECOACH004_2x`] = {
            {0,"NOEQUIPMENT",0},
        }, 

        [`STAGECOACH002X`] = {
            {0,"NOEQUIPMENT",0},
        }, 

        [`STAGECOACH001X`] = {
            {0,"NOEQUIPMENT",0},
        }, 

        [`COACH2`] = {
            {0,"NOEQUIPMENT",0},
        }, 
    },


    [4] = {
        Name = "Decorations",

		[`cart01`] = {
			{-1,"No Decorations", 0},
			{0,"Decoration#1",100},{1,"Decoration#2",100},{2,"Decoration#3",100},{3,"Decoration#4",100},
			{4,"Decoration#5",100},{5,"Decoration#6",100},{6,"Decoration#7",100},{7,"Decoration#8",100},
			{8,"Decoration#9",100},{9,"Decoration#10",100},{10,"Decoration#11",100},{11,"Decoration#12",100},
		},
		
		[`bountywagon01x`] = {
			{-1,"No Decorations", 0},
			{0,"Decoration#1",100},{1,"Decoration#2",100},{2,"Decoration#3",100},
		},
		
		[`cart05`] = {
			{-1,"No Decorations", 0},
			{0,"Decoration#1",100},{1,"Decoration#2",100},{2,"Decoration#3",100},{3,"Decoration#4",100},
			{4,"Decoration#5",100},{5,"Decoration#6",100},{6,"Decoration#7",100},{7,"Decoration#8",100},
			{8,"Decoration#9",100},{9,"Decoration#10",100},
		},
		
		[`cart07`] = {
			{-1,"No Decorations", 0},
			{0,"Decoration#1",100},{1,"Decoration#2",100},{2,"Decoration#3",100},{3,"Decoration#4",100},
			{4,"Decoration#5",100},{5,"Decoration#6",100},{6,"Decoration#7",100},{7,"Decoration#8",100},
			{8,"Decoration#9",100},{9,"Decoration#10",100},{10,"Decoration#11",100},{11,"Decoration#12",100},
		},
		
		[`cart08`] = {
			{-1,"No Decorations", 0},
			{0,"Decoration#1",100},{1,"Decoration#2",100},{2,"Decoration#3",100},{3,"Decoration#4",100},
			{4,"Decoration#5",100},{5,"Decoration#6",100},{6,"Decoration#7",100},{7,"Decoration#8",100},
			{8,"Decoration#9",100},{9,"Decoration#10",100},{10,"Decoration#11",100},{11,"Decoration#12",100},
			{12,"Decoration#13",100},{13,"Decoration#14",100},{14,"Decoration#15",100},{15,"Decoration#16",100},
		},

        [`chuckwagon000x`] = {
			{-1,"No Decorations", 0},		
            {0,  "Decoration#1", 100},
            {1,  "Decoration#2", 100},
            {2,  "Decoration#3", 100},
            {3,  "Decoration#4", 100},
            {4,  "Decoration#5", 100},
            {5,  "Decoration#6", 100},
            {6,  "Decoration#7", 100},
            {7,  "Decoration#8", 100},
            {8,  "Decoration#9", 100},
            {9,  "Decoration#10",100},
            {10, "Decoration#11",100},
        },

        [`stagecoach005x`] = {
			{-1,"No Decorations", 0},		
            {0, "Decoration#1", 100},
            {1, "Decoration#2", 100},
            {2, "Decoration#3", 100},
            {3, "Decoration#4", 100},
        },

        [`CHUCKWAGON002X`] = {
			{-1,"No Decorations", 0},		
            {0,  "Decoration#1", 100},
            {1,  "Decoration#2", 100},
            {2,  "Decoration#3", 100},
            {3,  "Decoration#4", 100},
            {4,  "Decoration#5", 100},
            {5,  "Decoration#6", 100},
            {6,  "Decoration#7", 100},
            {7,  "Decoration#8", 100},
            {8,  "Decoration#9", 100},
            {9,  "Decoration#10",100},
            {10, "Decoration#11",100},
        },

        [`supplywagon`] = {
			{-1,"No Decorations", 0},		
            {0,  "Decoration#1",  100},
            {1,  "Decoration#2",  100},
            {2,  "Decoration#3",  100},
            {3,  "Decoration#4",  100},
            {4,  "Decoration#5",  100},
            {5,  "Decoration#6",  100},
            {6,  "Decoration#7",  100},
            {7,  "Decoration#8",  100},
            {8,  "Decoration#9",  100},
            {9,  "Decoration#10", 100},
            {10, "Decoration#11", 100},
            {11, "Decoration#12", 100},
            {12, "Decoration#13", 100},
            {13, "Decoration#14", 100},
            {14, "Decoration#15", 100},
            {15, "Decoration#16", 100},
        },

        [`utilliwag`] = {
			{-1,"No Decorations", 0},		
            {0,  "Decoration#1",  100},
            {1,  "Decoration#2",  100},
            {2,  "Decoration#3",  100},
            {3,  "Decoration#4",  100},
            {4,  "Decoration#5",  100},
            {5,  "Decoration#6",  100},
            {6,  "Decoration#7",  100},
            {7,  "Decoration#8",  100},
            {8,  "Decoration#9",  100},
            {9,  "Decoration#10", 100},
            {10, "Decoration#11", 100},
            {11, "Decoration#12", 100},
            {12, "Decoration#13", 100},
            {13, "Decoration#14", 100},
            {14, "Decoration#15", 100},
            {15, "Decoration#16", 100},
        },

        [`wagon02x`] = {
			{-1,"No Decorations", 0},		
            {0,  "Decoration#01",100},
            {1,  "Decoration#02",100},
            {2,  "Decoration#03",100},
            {3,  "Decoration#04",100},
            {4,  "Decoration#05",100},
            {5,  "Decoration#06",100},
            {6,  "Decoration#07",100},
            {7,  "Decoration#08",100},
            {8,  "Decoration#09",100},
            {9,  "Decoration#10",100},
            {10, "Decoration#11",100},
            {11, "Decoration#12",100},
            {12, "Decoration#13",100},
            {13, "Decoration#14",100},
            {14, "Decoration#15",100},
            {15, "Decoration#16",100},
            {16, "Decoration#17",100},
        },

        [`wagon04x`] = {
			{-1,"No Decorations", 0},		
            {0,  "Decoration#01",100},
            {1,  "Decoration#02",100},
            {2,  "Decoration#03",100},
            {3,  "Decoration#04",100},
            {4,  "Decoration#05",100},
            {5,  "Decoration#06",100},
            {6,  "Decoration#07",100},
            {7,  "Decoration#08",100},
            {8,  "Decoration#09",100},
            {9,  "Decoration#10",100},
            {10, "Decoration#11",100},
            {11, "Decoration#12",100},
            {12, "Decoration#13",100},
            {13, "Decoration#14",100},
            {14, "Decoration#15",100},
            {15, "Decoration#16",100},
        },

        [`wagon05x`] = {
			{-1,"No Decorations", 0},		
            {0,  "Decoration#01",100},
            {1,  "Decoration#02",100},
            {2,  "Decoration#03",100},
            {3,  "Decoration#04",100},
            {4,  "Decoration#05",100},
            {5,  "Decoration#06",100},
            {6,  "Decoration#07",100},
            {7,  "Decoration#08",100},
            {8,  "Decoration#09",100},
            {9,  "Decoration#10",100},
            {10, "Decoration#11",100},
            {11, "Decoration#12",100},
            {12, "Decoration#13",100},
            {13, "Decoration#14",100},
            {14, "Decoration#15",100},
            {15, "Decoration#16",100},
            {16, "Decoration#17",100},
            {17, "Decoration#18",100},
            {18, "Decoration#19",100},
            {19, "Decoration#20",100},
        },

        [`wagon06x`] = {
			{-1,"No Decorations", 0},		
            {0,  "Decoration#01",100},
            {1,  "Decoration#02",100},
            {2,  "Decoration#03",100},
            {3,  "Decoration#04",100},
            {4,  "Decoration#05",100},
            {5,  "Decoration#06",100},
            {6,  "Decoration#07",100},
            {7,  "Decoration#08",100},
            {8,  "Decoration#09",100},
            {9,  "Decoration#10",100},
            {10, "Decoration#11",100},
            {11, "Decoration#12",100},
            {12, "Decoration#13",100},
            {13, "Decoration#14",100},
            {14, "Decoration#15",100},
            {15, "Decoration#16",100},
        },

        [`wagondoc01x`] = {		
		    {-1, "No decoration", 0},
            {0, "Decoration#01", 100},
        },

        [`CART02`] = {
			{-1,"No Decorations", 0},
            {0,  "Decoration#01",100},
            {1,  "Decoration#02",100},
            {2,  "Decoration#03",100},
            {3,  "Decoration#04",100},
            {4,  "Decoration#05",100},
            {5,  "Decoration#06",100},
            {6,  "Decoration#07",100},
            {7,  "Decoration#08",100},
            {8,  "Decoration#09",100},
            {9,  "Decoration#10",100},
            {10, "Decoration#11",100},
            {11, "Decoration#12",100},
            {12, "Decoration#13",100},
            {13, "Decoration#14",100},
            {14, "Decoration#15",100},
            {15, "Decoration#16",100},
        },

        [`buggy01`] = {
			{-1,"No Decorations", 0},
            {0,  "Decoration#01",100},
            {1,  "Decoration#02",100},
            {2,  "Decoration#03",100},
            {3,  "Decoration#04",100},
            {4,  "Decoration#05",100},
            {5,  "Decoration#06",100},
            {6,  "Decoration#07",100},
            {7,  "Decoration#08",100},
            {8,  "Decoration#09",100},
            {9,  "Decoration#10",100},
            {10, "Decoration#11",100},
            {11, "Decoration#12",100},
            {12, "Decoration#13",100},
            {13, "Decoration#14",100},
            {14, "Decoration#15",100},
        },

        [`buggy02`] = {
			{-1,"No Decorations", 0},
            {0,  "Decoration#01",100},
            {1,  "Decoration#02",100},
            {2,  "Decoration#03",100},
            {3,  "Decoration#04",100},
            {4,  "Decoration#05",100},
            {5,  "Decoration#06",100},
            {6,  "Decoration#07",100},
            {7,  "Decoration#08",100},
            {8,  "Decoration#09",100},
            {9,  "Decoration#10",100},
            {10, "Decoration#11",100},
            {11, "Decoration#12",100},
            {12, "Decoration#13",100},
            {13, "Decoration#14",100},
            {14, "Decoration#15",100},
        },

        [`buggy03`] = {
			{-1,"No Decorations", 0},
            {0,  "Decoration#01",100},
            {1,  "Decoration#02",100},
            {2,  "Decoration#03",100},
            {3,  "Decoration#04",100},
            {4,  "Decoration#05",100},
            {5,  "Decoration#06",100},
            {6,  "Decoration#07",100},
            {7,  "Decoration#08",100},
            {8,  "Decoration#09",100},
            {9,  "Decoration#10",100},
            {10, "Decoration#11",100},
            {11, "Decoration#12",100},
            {12, "Decoration#13",100},
            {13, "Decoration#14",100},
            {14, "Decoration#15",100},
        },

        [`cart03`] = {
		    {-1,"No Decorations", 0},
            {0,  "Decoration#01",100},
            {1,  "Decoration#02",100},
            {2,  "Decoration#03",100},
            {3,  "Decoration#04",100},
            {4,  "Decoration#05",100},
            {5,  "Decoration#06",100},
            {6,  "Decoration#07",100},
            {7,  "Decoration#08",100},
            {8,  "Decoration#09",100},
            {9,  "Decoration#10",100},
        },

        [`cart04`] = {
			{-1,"No Decorations", 0},
            {0, "Decoration#01",100},
            {1, "Decoration#02",100},
            {2, "Decoration#03",100},
            {3, "Decoration#04",100},
            {4, "Decoration#05",100},
            {5, "Decoration#06",100},
            {6, "Decoration#07",100},
        },

        [`cart06`] = {
		    {-1,"No Decorations", 0},
            {0,  "Decoration#01",100},
            {1,  "Decoration#02",100},
            {2,  "Decoration#03",100},
            {3,  "Decoration#04",100},
            {4,  "Decoration#05",100},
            {5,  "Decoration#06",100},
            {6,  "Decoration#07",100},
            {7,  "Decoration#08",100},
            {8,  "Decoration#09",100},
            {9,  "Decoration#10",100},
            {10, "Decoration#11",100},
            {11, "Decoration#12",100},
            {12, "Decoration#13",100},
        },

        [`coach3`] = {
		    {-1,"No Decorations", 0},
            {0,  "Decoration#01",100},
            {1,  "Decoration#02",100},
            {2,  "Decoration#03",100},
            {3,  "Decoration#04",100},
            {4,  "Decoration#05",100},
            {5,  "Decoration#06",100},
            {6,  "Decoration#07",100},
            {7,  "Decoration#08",100},
            {8,  "Decoration#09",100},
            {9,  "Decoration#10",100},
            {10, "Decoration#11",100},
            {11, "Decoration#12",100},
            {12, "Decoration#13",100},
        },

        [`coach3_cutscene`] = {
		    {-1,"No Decorations", 0},
            {0, "Decoration#01",100},
            {1, "Decoration#02",100},
            {2, "Decoration#03",100},
            {3, "Decoration#04",100},
        },

        [`coach4`] = {
		    {-1,"No Decorations", 0},
            {0,  "Decoration#01",100},
            {1,  "Decoration#02",100},
            {2,  "Decoration#03",100},
            {3,  "Decoration#04",100},
            {4,  "Decoration#05",100},
            {5,  "Decoration#06",100},
            {6,  "Decoration#07",100},
            {7,  "Decoration#08",100},
            {8,  "Decoration#09",100},
            {9,  "Decoration#10",100},
            {10, "Decoration#11",100},
            {11, "Decoration#12",100},
            {12, "Decoration#13",100},
            {13, "Decoration#14",100},
        },

        [`coach5`] = {
			{-1,"No Decorations", 0},
            {0,  "Decoration#01",100},
            {1,  "Decoration#02",100},
            {2,  "Decoration#03",100},
            {3,  "Decoration#04",100},
            {4,  "Decoration#05",100},
            {5,  "Decoration#06",100},
            {6,  "Decoration#07",100},
            {7,  "Decoration#08",100},
            {8,  "Decoration#09",100},
            {9,  "Decoration#10",100},
            {10, "Decoration#11",100},
            {11, "Decoration#12",100},
        },

        [`coach6`] = {
		    {-1,"No Decorations", 0},
            {0,  "Decoration#01",100},
            {1,  "Decoration#02",100},
            {2,  "Decoration#03",100},
            {3,  "Decoration#04",100},
            {4,  "Decoration#05",100},
            {5,  "Decoration#06",100},
            {6,  "Decoration#07",100},
            {7,  "Decoration#08",100},
            {8,  "Decoration#09",100},
            {9,  "Decoration#10",100},
            {10, "Decoration#11",100},
            {11, "Decoration#12",100},
            {12, "Decoration#13",100},
            {13, "Decoration#14",100},
            {14, "Decoration#15",100},
            {15, "Decoration#16",100},
        },

        [`coal_wagon`] = {
		    {-1,"No Decorations", 0},
            {0, "Decoration#01",100},
            {1, "Decoration#02",100},
            {2, "Decoration#03",100},
            {3, "Decoration#04",100},
        },

        [`huntercart01`] = {
		    {-1,"No Decorations", 0},
            {0, "Decoration#01",100},
            {1, "Decoration#02",100},
            {2, "Decoration#03",100},
            {3, "Decoration#04",100},
            {4, "Decoration#05",100},
            {5, "Decoration#06",100},
        },

        [`oilWagon01x`] = {
		    {-1,"No Decorations", 0},
            {0, "Decoration#01",100},
            {1, "Decoration#02",100},
            {2, "Decoration#03",100},
            {3, "Decoration#04",100},
            {4, "Decoration#05",100},
            {5, "Decoration#06",100},
        },

        [`oilWagon02x`] = {
		    {-1,"No Decorations", 0},
            {0, "Decoration#01",100},
            {1, "Decoration#02",100},
            {2, "Decoration#03",100},
            {3, "Decoration#04",100},
            {4, "Decoration#05",100},
            {5, "Decoration#06",100},
        },

        [`policeWagongatling01x`] = {
			{-1,"No Decorations", 0},
            {0, "Decoration#01",100},
        },

        [`stagecoach003x`] = {
		    {-1,"No Decorations", 0},
            {0, "Decoration#01",100},
            {1, "Decoration#02",100},
            {2, "Decoration#03",100},
            {3, "Decoration#04",100},
        },

        [`stagecoach004x`] = {
		    {-1,"No Decorations", 0},
            {0, "Decoration#01",100},
        },

        [`stagecoach006x`] = {
		    {-1,"No Decorations", 0},
            {0, "Decoration#01",100},
            {1, "Decoration#02",100},
            {2, "Decoration#03",100},
            {3, "Decoration#04",100},
        },

        [`supplywagon2`] = {
		    {-1,"No Decorations", 0},
            {0,  "Decoration#01",100},
            {1,  "Decoration#02",100},
            {2,  "Decoration#03",100},
            {3,  "Decoration#04",100},
            {4,  "Decoration#05",100},
            {5,  "Decoration#06",100},
            {6,  "Decoration#07",100},
            {7,  "Decoration#08",100},
            {8,  "Decoration#09",100},
            {9,  "Decoration#10",100},
            {10, "Decoration#11",100},
            {11, "Decoration#12",100},
            {12, "Decoration#13",100},
            {13, "Decoration#14",100},
            {14, "Decoration#15",100},
            {15, "Decoration#16",100},
        },

        [`wagon03x`] = {
		    {-1,"No Decorations", 0},
            {0,  "Decoration#01",100},
            {1,  "Decoration#02",100},
            {2,  "Decoration#03",100},
            {3,  "Decoration#04",100},
            {4,  "Decoration#05",100},
            {5,  "Decoration#06",100},
            {6,  "Decoration#07",100},
            {7,  "Decoration#08",100},
            {8,  "Decoration#09",100},
            {9,  "Decoration#10",100},
            {10, "Decoration#11",100},
            {11, "Decoration#12",100},
            {12, "Decoration#13",100},
            {13, "Decoration#14",100},
            {14, "Decoration#15",100},
            {15, "Decoration#16",100},
        },

 
        [`wagon05x`] = {
		    {-1,"No Decorations", 0},
            {0,  "Decoration#01",100},
            {1,  "Decoration#02",100},
            {2,  "Decoration#03",100},
            {3,  "Decoration#04",100},
            {4,  "Decoration#05",100},
            {5,  "Decoration#06",100},
            {6,  "Decoration#07",100},
            {7,  "Decoration#08",100},
            {8,  "Decoration#09",100},
            {9,  "Decoration#10",100},
            {10, "Decoration#11",100},
            {11, "Decoration#12",100},
            {12, "Decoration#13",100},
            {13, "Decoration#14",100},
            {14, "Decoration#15",100},
            {15, "Decoration#16",100},
            {16, "Decoration#17",100},
            {17, "Decoration#18",100},
            {18, "Decoration#19",100},
            {19, "Decoration#20",100},
        },

        [`wagonarmoured01x`] = {
		    {-1,"No Decorations", 0},
            {0,  "Decoration#01",100},
            {1,  "Decoration#02",100},
            {2,  "Decoration#03",100},
            {3,  "Decoration#04",100},
            {4,  "Decoration#05",100},
            {5,  "Decoration#06",100},
            {6,  "Decoration#07",100},
            {7,  "Decoration#08",100},
            {8,  "Decoration#09",100},
            {9,  "Decoration#10",100},
            {10, "Decoration#11",100},
            {11, "Decoration#12",100},
            {12, "Decoration#13",100},
            {13, "Decoration#14",100},
            {14, "Decoration#15",100},
            {15, "Decoration#16",100},
            {16, "Decoration#17",100},
            {17, "Decoration#18",100},
            {18, "Decoration#19",100},
            {19, "Decoration#20",100},
            {20, "Decoration#21",100},
            {21, "Decoration#22",100},
            {22, "Decoration#23",100},
            {23, "Decoration#24",100},
            {24, "Decoration#25",100},
            {25, "Decoration#26",100},
            {26, "Decoration#27",100},
            {27, "Decoration#28",100},
            {28, "Decoration#29",100},
            {29, "Decoration#30",100},
            {30, "Decoration#31",100},
        },

        [`wagondairy01x`] = {
		    {-1,"No Decorations", 0},	
            {0, "Decoration#1",100},
            {1, "Decoration#2",100},
        },

        [`wagontraveller01x`] = {
		    {-1,"No Decorations", 0},	
            {0, "Decoration#01",100},
        },

        [`wagonwork01x`] = {
		    {-1,"No Decorations", 0},	
            {0, "Decoration#01",100},
        },

        [`warwagon2`] = {
			{-1,"No Decorations", 0},	
            {0, "Decoration#1",100},
            {1, "Decoration#2",100},
            {2, "Decoration#3",100},
            {3, "Decoration#4",100},
        },

        [`POLICEWAGON01X`] = {
		    {-1,"No Decorations", 0},
            {0, "Decoration#01",100},
        }, 

        [`gatchuck_2`] = {
		    {-1,"No Decorations", 0},	
            {0,  "Decoration#01",100},
            {1,  "Decoration#02",100},
            {2,  "Decoration#03",100},
            {3,  "Decoration#04",100},
            {4,  "Decoration#05",100},
            {5,  "Decoration#06",100},
            {6,  "Decoration#07",100},
            {7,  "Decoration#08",100},
            {8,  "Decoration#09",100},
            {9,  "Decoration#10",100},
            {10, "Decoration#11",100},
            {11, "Decoration#12",100},
            {12, "Decoration#13",100},
            {13, "Decoration#14",100},
            {14, "Decoration#15",100},
            {15, "Decoration#16",100},
        }, 

        [`STAGECOACH004_2x`] = {
			{-1,"No Decorations", 0},		
            {0, "Decoration#1",100},
            {1, "Decoration#2",100},
            {2, "Decoration#3",100},
            {3, "Decoration#4",100},
            {4, "Decoration#5",100},
        }, 

        [`STAGECOACH002X`] = {
		    {-1,"No Decorations", 0},	
            {0, "Decoration#1",100},
            {1, "Decoration#2",100},
            {2, "Decoration#3",100},
            {3, "Decoration#4",100},
        }, 

        [`STAGECOACH001X`] = {
		    {-1,"No Decorations", 0},
            {0, "Decoration#1",100},
            {1, "Decoration#2",100},
            {2, "Decoration#3",100},
            {3, "Decoration#4",100},
        }, 

        [`COACH2`] = {
		    {-1,"No Decorations", 0},
            {0, "Decoration#1",100},
            {1, "Decoration#2",100},
            {2, "Decoration#3",100},
            {3, "Decoration#4",100},
        }, 

        [`gatchuck`] = {
			{-1,"No Decorations", 0},
            {0,  "Decoration#01",100},
            {1,  "Decoration#02",100},
            {2,  "Decoration#03",100},
            {3,  "Decoration#04",100},
            {4,  "Decoration#05",100},
            {5,  "Decoration#06",100},
            {6,  "Decoration#07",100},
            {7,  "Decoration#08",100},
            {8,  "Decoration#09",100},
            {9,  "Decoration#10",100},
            {10, "Decoration#11",100},
            {11, "Decoration#12",100},
            {12, "Decoration#13",100},
            {13, "Decoration#14",100},
            {14, "Decoration#15",100},
            {15, "Decoration#16",100},
        }, 
		
        [`armysupplywagon`] = {
			{-1,"No Decorations", 0},
            {0, "Decoration#01",100},
        },

        [`logwagon`] = {
            {0,"NOEQUIPMENT",0},
        },

        [`logwagon2`] = {
            {0,"NOEQUIPMENT",0},
        },      

        [`wagonPrison01x`] = {
            {0,"NOEQUIPMENT",0},
        },      

        [`wagonCircus01x`] = {
            {0,"NOEQUIPMENT",0},
        },

        [`wagonCircus02x`] = {
            {0,"NOEQUIPMENT",0},
        },      
    },


    [5] =  {
        Name = "Tints",

        [`cart01`] = {
            {0,"Tint#1", 100},
            {1,"Tint#2", 100},
            {2,"Tint#3", 100},
            {3,"Tint#4", 100},
            {4,"Tint#5", 100},
            {5,"Tint#6", 100},
            {6,"Tint#7", 100},
            {7,"Tint#8", 100},
            {8,"Tint#9", 100},
            {9,"Tint#10",100},
            {10,"Tint#11",100},
            {11,"Tint#12",100},
            {12,"Tint#13",100},
            {13,"Tint#14",100},
            {14,"Tint#15",100},
            {15,"Tint#16",100},
            {16,"Tint#17",100},
            {17,"Tint#18",100},
            {18,"Tint#19",100},
            {19,"Tint#20",100},
            {20,"Tint#21",100},
            {21,"Tint#22",100},
            {22,"Tint#23",100},
            {23,"Tint#24",100},
            {24,"Tint#25",100},
            {25,"Tint#26",100},
            {26,"Tint#27",100},
        },

        [`bountywagon01x`] = {
            {0,"Tint#1",100},
            {1,"Tint#2",100},
            {2,"Tint#3",100},
            {3,"Tint#4",100},
            {4,"Tint#5",100},
        },

        [`cart05`] = {
            {0,"Tint#1",100},
            {1,"Tint#2",100},
            {2,"Tint#3",100},
            {3,"Tint#4",100},
            {4,"Tint#5",100},
            {5,"Tint#6",100},
            {6,"Tint#7",100},
            {7,"Tint#8",100},
            {8,"Tint#9",100},
            {9,"Tint#10",100},
            {10,"Tint#11",100},
            {11,"Tint#12",100},
            {12,"Tint#13",100},
            {13,"Tint#14",100},
            {14,"Tint#15",100},
            {15,"Tint#16",100},
            {16,"Tint#17",100},
            {17,"Tint#18",100},
            {18,"Tint#19",100},
            {19,"Tint#20",100},
            {20,"Tint#21",100},
            {21,"Tint#22",100},
            {22,"Tint#23",100},
            {23,"Tint#24",100},
        },

        [`cart07`] = {
            {0,"Tint#1",100},
            {1,"Tint#2",100},
            {2,"Tint#3",100},
            {3,"Tint#4",100},
            {4,"Tint#5",100},
            {5,"Tint#6",100},
            {6,"Tint#7",100},
            {7,"Tint#8",100},
            {8,"Tint#9",100},
            {9,"Tint#10",100},
            {10,"Tint#11",100},
            {11,"Tint#12",100},
            {12,"Tint#13",100},
            {13,"Tint#14",100},
            {14,"Tint#15",100},
            {15,"Tint#16",100},
            {16,"Tint#17",100},
            {17,"Tint#18",100},
            {18,"Tint#19",100},
            {19,"Tint#20",100},
            {20,"Tint#21",100},
            {21,"Tint#22",100},
            {22,"Tint#23",100},
            {23,"Tint#24",100},
        },

        [`cart08`] = {
            {0,"Tint#1",100},
            {1,"Tint#2",100},
            {2,"Tint#3",100},
            {3,"Tint#4",100},
            {4,"Tint#5",100},
            {5,"Tint#6",100},
            {6,"Tint#7",100},
            {7,"Tint#8",100},
            {8,"Tint#9",100},
            {9,"Tint#10",100},
            {10,"Tint#11",100},
            {11,"Tint#12",100},
            {12,"Tint#13",100},
            {13,"Tint#14",100},
            {14,"Tint#15",100},
            {15,"Tint#16",100},
            {16,"Tint#17",100},
            {17,"Tint#18",100},
            {18,"Tint#19",100},
            {19,"Tint#20",100},
        },

        [`chuckwagon000x`] = {
            {0,"Tint#1",100},
            {1,"Tint#2",100},
            {2,"Tint#3",100},
            {3,"Tint#4",100},
            {4,"Tint#5",100},
            {5,"Tint#6",100},
            {6,"Tint#7",100},
            {7,"Tint#8",100},
            {8,"Tint#9",100},
            {9,"Tint#10",100},
            {10,"Tint#11",100},
            {11,"Tint#12",100},
            {12,"Tint#13",100},
            {13,"Tint#14",100},
            {14,"Tint#15",100},
        },

        [`CHUCKWAGON002X`] = {
            {0,"Tint#1",100},
            {1,"Tint#2",100},
            {2,"Tint#3",100},
            {3,"Tint#4",100},
            {4,"Tint#5",100},
            {5,"Tint#6",100},
            {6,"Tint#7",100},
            {7,"Tint#8",100},
            {8,"Tint#9",100},
            {9,"Tint#10",100},
            {10,"Tint#11",100},
            {11,"Tint#12",100},
            {12,"Tint#13",100},
            {13,"Tint#14",100},
            {14,"Tint#15",100},
        },

        [`stagecoach005x`] = {
            {0,"Tint#1",100},
            {1,"Tint#2",100},
            {2,"Tint#3",100},
            {3,"Tint#4",100},
        },

        [`supplywagon`] = {
            {0,"Tint#1",100},
            {1,"Tint#2",100},
            {2,"Tint#3",100},
            {3,"Tint#4",100},
            {4,"Tint#5",100},
            {5,"Tint#6",100},
            {6,"Tint#7",100},
            {7,"Tint#8",100},
            {8,"Tint#9",100},
            {9,"Tint#10",100},
            {10,"Tint#11",100},
            {11,"Tint#12",100},
            {12,"Tint#13",100},
            {13,"Tint#14",100},
            {14,"Tint#15",100},
            {15,"Tint#16",100},
        },

        [`utilliwag`] = {
            {0,"Tint#1",100},
            {1,"Tint#2",100},
            {2,"Tint#3",100},
            {3,"Tint#4",100},
            {4,"Tint#5",100},
            {5,"Tint#6",100},
            {6,"Tint#7",100},
            {7,"Tint#8",100},
            {8,"Tint#9",100},
            {9,"Tint#10",100},
            {10,"Tint#11",100},
            {11,"Tint#12",100},
            {12,"Tint#13",100},
            {13,"Tint#14",100},
            {14,"Tint#15",100},
            {15,"Tint#16",100},
            {16,"Tint#17",100},
        },

        [`wagon02x`] = {
            {0,"Tint#1",100},
            {1,"Tint#2",100},
            {2,"Tint#3",100},
            {3,"Tint#4",100},
            {4,"Tint#5",100},
            {5,"Tint#6",100},
            {6,"Tint#7",100},
            {7,"Tint#8",100},
            {8,"Tint#9",100},
            {9,"Tint#10",100},
            {10,"Tint#11",100},
            {11,"Tint#12",100},
            {12,"Tint#13",100},
            {13,"Tint#14",100},
            {14,"Tint#15",100},
            {15,"Tint#16",100},
            {16,"Tint#17",100},
            {17,"Tint#18",100},
            {18,"Tint#19",100},
            {19,"Tint#20",100},
            {20,"Tint#21",100},
            {21,"Tint#22",100},
        },

        [`wagon04x`] = {
            {0,"Tint#1",100},
            {1,"Tint#2",100},
            {2,"Tint#3",100},
            {3,"Tint#4",100},
            {4,"Tint#5",100},
            {5,"Tint#6",100},
            {6,"Tint#7",100},
            {7,"Tint#8",100},
            {8,"Tint#9",100},
            {9,"Tint#10",100},
            {10,"Tint#11",100},
            {11,"Tint#12",100},
            {12,"Tint#13",100},
            {13,"Tint#14",100},
            {14,"Tint#15",100},
            {15,"Tint#16",100},
            {16,"Tint#17",100},
            {17,"Tint#18",100},
            {18,"Tint#19",100},
            {19,"Tint#20",100},
            {20,"Tint#21",100},
        },

        [`wagon05x`] = {
            {0,"Tint#1",100},
            {1,"Tint#2",100},
            {2,"Tint#3",100},
            {3,"Tint#4",100},
            {4,"Tint#5",100},
            {5,"Tint#6",100},
            {6,"Tint#7",100},
            {7,"Tint#8",100},
            {8,"Tint#9",100},
            {9,"Tint#10",100},
            {10,"Tint#11",100},
            {11,"Tint#12",100},
            {12,"Tint#13",100},
            {13,"Tint#14",100},
            {14,"Tint#15",100},
            {15,"Tint#16",100},
            {16,"Tint#17",100},
            {17,"Tint#18",100},
            {18,"Tint#19",100},
            {19,"Tint#20",100},
        },

        [`wagon06x`] = {
            {0,"Tint#1",100},
            {1,"Tint#2",100},
            {2,"Tint#3",100},
            {3,"Tint#4",100},
            {4,"Tint#5",100},
            {5,"Tint#6",100},
            {6,"Tint#7",100},
            {7,"Tint#8",100},
            {8,"Tint#9",100},
            {9,"Tint#10",100},
            {10,"Tint#11",100},
            {11,"Tint#12",100},
            {12,"Tint#13",100},
            {13,"Tint#14",100},
            {14,"Tint#15",100},
            {15,"Tint#16",100},
        },

        [`wagonCircus01x`] = {
            {0,"Tint#1",100},
        },

        [`wagonCircus02x`] = {
            {0,"Tint#1",100},
        },

        [`wagondoc01x`] = {
            {0,"Tint#1",100},
        },

        [`CART02`] = {
            {0,"Tint#1",100},
            {1,"Tint#2",100},
            {2,"Tint#3",100},
            {3,"Tint#4",100},
            {4,"Tint#5",100},
            {5,"Tint#6",100},
            {6,"Tint#7",100},
            {7,"Tint#8",100},
            {8,"Tint#9",100},
            {9,"Tint#10",100},
            {10,"Tint#11",100},
            {11,"Tint#12",100},
            {12,"Tint#13",100},
            {13,"Tint#14",100},
            {14,"Tint#15",100},
            {15,"Tint#16",100},
            {16,"Tint#17",100},
            {17,"Tint#18",100},
            {18,"Tint#19",100},
            {19,"Tint#20",100},
            {20,"Tint#21",100},
            {21,"Tint#22",100},
            {22,"Tint#23",100},
            {23,"Tint#24",100},
        },

        [`buggy01`] = {
            {0,"Tint#1",100},
            {1,"Tint#2",100},
            {2,"Tint#3",100},
            {3,"Tint#4",100},
            {4,"Tint#5",100},
            {5,"Tint#6",100},
            {6,"Tint#7",100},
            {7,"Tint#8",100},
            {8,"Tint#9",100},
            {9,"Tint#10",100},
            {10,"Tint#11",100},
            {11,"Tint#12",100},
            {12,"Tint#13",100},
            {13,"Tint#14",100},
        },

        [`buggy02`] = {
            {0,"Tint#1",100},
            {1,"Tint#2",100},
            {2,"Tint#3",100},
            {3,"Tint#4",100},
            {4,"Tint#5",100},
            {5,"Tint#6",100},
            {6,"Tint#7",100},
            {7,"Tint#8",100},
            {8,"Tint#9",100},
            {9,"Tint#10",100},
            {10,"Tint#11",100},
            {11,"Tint#12",100},
            {12,"Tint#13",100},
            {13,"Tint#14",100},
            {14,"Tint#15",100},
            {15,"Tint#16",100},
        },

        [`buggy03`] = {
            {0,"Tint#1",100},
            {1,"Tint#2",100},
            {2,"Tint#3",100},
            {3,"Tint#4",100},
            {4,"Tint#5",100},
            {5,"Tint#6",100},
            {6,"Tint#7",100},
            {7,"Tint#8",100},
            {8,"Tint#9",100},
            {9,"Tint#10",100},
            {10,"Tint#11",100},
            {11,"Tint#12",100},
            {12,"Tint#13",100},
            {13,"Tint#14",100},
            {14,"Tint#15",100},
            {15,"Tint#16",100},
        },

        [`cart03`] = {
            {0,"Tint#1",100},
            {1,"Tint#2",100},
            {2,"Tint#3",100},
            {3,"Tint#4",100},
            {4,"Tint#5",100},
            {5,"Tint#6",100},
            {6,"Tint#7",100},
            {7,"Tint#8",100},
            {8,"Tint#9",100},
            {9,"Tint#10",100},
            {10,"Tint#11",100},
            {11,"Tint#12",100},
            {12,"Tint#13",100},
            {13,"Tint#14",100},
            {14,"Tint#15",100},
            {15,"Tint#16",100},
            {16,"Tint#17",100},
            {17,"Tint#18",100},
            {18,"Tint#19",100},
            {19,"Tint#20",100},
            {20,"Tint#21",100},
            {21,"Tint#22",100},
            {22,"Tint#23",100},
            {23,"Tint#24",100},
            {24,"Tint#25",100},
        },

        [`cart04`] = {
            {0,"Tint#1",100},
            {1,"Tint#2",100},
            {2,"Tint#3",100},
            {3,"Tint#4",100},
            {4,"Tint#5",100},
            {5,"Tint#6",100},
            {6,"Tint#7",100},
            {7,"Tint#8",100},
            {8,"Tint#9",100},
            {9,"Tint#10",100},
            {10,"Tint#11",100},
            {11,"Tint#12",100},
            {12,"Tint#13",100},
            {13,"Tint#14",100},
            {14,"Tint#15",100},
            {15,"Tint#16",100},
            {16,"Tint#17",100},
            {17,"Tint#18",100},
            {18,"Tint#19",100},
        },

        [`cart06`] = {
            {0,"Tint#1",100},
            {1,"Tint#2",100},
            {2,"Tint#3",100},
            {3,"Tint#4",100},
            {4,"Tint#5",100},
            {5,"Tint#6",100},
            {6,"Tint#7",100},
            {7,"Tint#8",100},
            {8,"Tint#9",100},
            {9,"Tint#10",100},
            {10,"Tint#11",100},
            {11,"Tint#12",100},
            {12,"Tint#13",100},
            {13,"Tint#14",100},
            {14,"Tint#15",100},
            {15,"Tint#16",100},
            {16,"Tint#17",100},
            {17,"Tint#18",100},
            {18,"Tint#19",100},
            {19,"Tint#20",100},
            {20,"Tint#21",100},
            {21,"Tint#22",100},
            {22,"Tint#23",100},
            {23,"Tint#24",100},
            {24,"Tint#25",100},
        },

        [`coach3`] = {
            {0,"Tint#1",100},
            {1,"Tint#2",100},
            {2,"Tint#3",100},
            {3,"Tint#4",100},
            {4,"Tint#5",100},
            {5,"Tint#6",100},
            {6,"Tint#7",100},
            {7,"Tint#8",100},
            {8,"Tint#9",100},
            {9,"Tint#10",100},
            {10,"Tint#11",100},
            {11,"Tint#12",100},
            {12,"Tint#13",100},
            {13,"Tint#14",100},
            {14,"Tint#15",100},
            {15,"Tint#16",100},
            {16,"Tint#17",100},
            {17,"Tint#18",100},
            {18,"Tint#19",100},
            {19,"Tint#20",100},
        },

        [`coach3_cutscene`] = {
            {0,"Tint#1",100},
            {1,"Tint#2",100},
            {2,"Tint#3",100},
            {3,"Tint#4",100},
            {4,"Tint#5",100},
            {5,"Tint#6",100},
            {6,"Tint#7",100},
            {7,"Tint#8",100},
            {8,"Tint#9",100},
            {9,"Tint#10",100},
        },

        [`coach4`] = {
            {0,"Tint#1",100},
            {1,"Tint#2",100},
            {2,"Tint#3",100},
            {3,"Tint#4",100},
            {4,"Tint#5",100},
            {5,"Tint#6",100},
            {6,"Tint#7",100},
            {7,"Tint#8",100},
            {8,"Tint#9",100},
            {9,"Tint#10",100},
            {10,"Tint#11",100},
            {11,"Tint#12",100},
            {12,"Tint#13",100},
            {13,"Tint#14",100},
            {14,"Tint#15",100},
            {15,"Tint#16",100},
            {16,"Tint#17",100},
            {17,"Tint#18",100},
            {18,"Tint#19",100},
            {19,"Tint#20",100},
        },

        [`coach5`] = {
            {0,"Tint#1",100},
            {1,"Tint#2",100},
            {2,"Tint#3",100},
            {3,"Tint#4",100},
            {4,"Tint#5",100},
            {5,"Tint#6",100},
            {6,"Tint#7",100},
            {7,"Tint#8",100},
            {8,"Tint#9",100},
            {9,"Tint#10",100},
            {10,"Tint#11",100},
            {11,"Tint#12",100},
            {12,"Tint#13",100},
            {13,"Tint#14",100},
            {14,"Tint#15",100},
            {15,"Tint#16",100},
            {16,"Tint#17",100},
            {17,"Tint#18",100},
            {18,"Tint#19",100},
            {19,"Tint#20",100},
        },

        [`coach6`] = {
            {0,"Tint#1",100},
            {1,"Tint#2",100},
            {2,"Tint#3",100},
            {3,"Tint#4",100},
            {4,"Tint#5",100},
            {5,"Tint#6",100},
            {6,"Tint#7",100},
            {7,"Tint#8",100},
            {8,"Tint#9",100},
            {9,"Tint#10",100},
            {10,"Tint#11",100},
            {11,"Tint#12",100},
            {12,"Tint#13",100},
            {13,"Tint#14",100},
            {14,"Tint#15",100},
            {15,"Tint#16",100},
            {16,"Tint#17",100},
            {17,"Tint#18",100},
            {18,"Tint#19",100},
            {19,"Tint#20",100},
        },

        [`coal_wagon`] = {
            {0,"Tint#1",100},
            {1,"Tint#2",100},
            {2,"Tint#3",100},
            {3,"Tint#4",100},
            {4,"Tint#5",100},
            {5,"Tint#6",100},
            {6,"Tint#7",100},
            {7,"Tint#8",100},
            {8,"Tint#9",100},
            {9,"Tint#10",100},
            {10,"Tint#11",100},
            {11,"Tint#12",100},
            {12,"Tint#13",100},
            {13,"Tint#14",100},
            {14,"Tint#15",100},
            {15,"Tint#16",100},
            {16,"Tint#17",100},
            {17,"Tint#18",100},
            {18,"Tint#19",100},
            {19,"Tint#20",100},
            {20,"Tint#21",100},
            {21,"Tint#22",100},
            {22,"Tint#23",100},
            {23,"Tint#24",100},
        },

        [`huntercart01`] = {
            {0,"Tint#1",100},
            {1,"Tint#2",100},
            {2,"Tint#3",100},
            {3,"Tint#4",100},
            {4,"Tint#5",100},
            {5,"Tint#6",100},
        },

        [`logwagon`] = {
            {0,"Tint#1",100},
            {1,"Tint#2",100},
            {2,"Tint#3",100},
            {3,"Tint#4",100},
            {4,"Tint#5",100},
        },

        [`logwagon2`] = {
            {0,"Tint#1",100},
            {1,"Tint#2",100},
            {2,"Tint#3",100},
            {3,"Tint#4",100},
            {4,"Tint#5",100},
        },

        [`oilWagon01x`] = {
            {0,"Tint#1",100},
            {1,"Tint#2",100},
            {2,"Tint#3",100},
            {3,"Tint#4",100},
            {4,"Tint#5",100},
            {5,"Tint#6",100},
            {6,"Tint#7",100},
            {7,"Tint#8",100},
            {8,"Tint#9",100},
            {9,"Tint#10",100},
            {10,"Tint#11",100},
            {11,"Tint#12",100},
            {12,"Tint#13",100},
            {13,"Tint#14",100},
        },

        [`oilWagon02x`] = {
            {0,"Tint#1",100},
            {1,"Tint#2",100},
            {2,"Tint#3",100},
            {3,"Tint#4",100},
            {4,"Tint#5",100},
            {5,"Tint#6",100},
            {6,"Tint#7",100},
            {7,"Tint#8",100},
            {8,"Tint#9",100},
            {9,"Tint#10",100},
            {10,"Tint#11",100},
            {11,"Tint#12",100},
        },

        [`policeWagongatling01x`] = {
            {0,"Tint#1",100},
            {1,"Tint#2",100},
            {2,"Tint#3",100},
        },

        [`stagecoach003x`] = {
            {0,"Tint#1",100},
            {1,"Tint#2",100},
            {2,"Tint#3",100},
            {3,"Tint#4",100},
        },

        [`stagecoach004x`] = {
            {0,"Tint#1",100},
            {1,"Tint#2",100},
            {2,"Tint#3",100},
        },

        [`stagecoach006x`] = {
            {0,"Tint#1",100},
            {1,"Tint#2",100},
            {2,"Tint#3",100},
            {3,"Tint#4",100},
            {4,"Tint#5",100},
            {5,"Tint#6",100},
            {6,"Tint#7",100},
        },

        [`supplywagon2`] = {
            {0,"Tint#1",100},
            {1,"Tint#2",100},
            {2,"Tint#3",100},
            {3,"Tint#4",100},
            {4,"Tint#5",100},
            {5,"Tint#6",100},
            {6,"Tint#7",100},
            {7,"Tint#8",100},
            {8,"Tint#9",100},
            {9,"Tint#10",100},
            {10,"Tint#11",100},
            {11,"Tint#12",100},
            {12,"Tint#13",100},
            {13,"Tint#14",100},
            {14,"Tint#15",100},
            {15,"Tint#16",100},
        },

        [`wagon03x`] = {
            {0,"Tint#1",100},
            {1,"Tint#2",100},
            {2,"Tint#3",100},
            {3,"Tint#4",100},
            {4,"Tint#5",100},
            {5,"Tint#6",100},
            {6,"Tint#7",100},
            {7,"Tint#8",100},
            {8,"Tint#9",100},
            {9,"Tint#10",100},
            {10,"Tint#11",100},
            {11,"Tint#12",100},
            {12,"Tint#13",100},
            {13,"Tint#14",100},
            {14,"Tint#15",100},
        },

        [`wagon05x`] = {
            {0,"Tint#1",100},
            {1,"Tint#2",100},
            {2,"Tint#3",100},
            {3,"Tint#4",100},
            {4,"Tint#5",100},
            {5,"Tint#6",100},
            {6,"Tint#7",100},
            {7,"Tint#8",100},
            {8,"Tint#9",100},
            {9,"Tint#10",100},
            {10,"Tint#11",100},
            {11,"Tint#12",100},
            {12,"Tint#13",100},
            {13,"Tint#14",100},
            {14,"Tint#15",100},
            {15,"Tint#16",100},
            {16,"Tint#17",100},
            {17,"Tint#18",100},
            {18,"Tint#19",100},
            {19,"Tint#20",100},
        },

        [`wagonarmoured01x`] = {
            {0,"Tint#1",100},
            {1,"Tint#2",100},
            {2,"Tint#3",100},
            {3,"Tint#4",100},
            {4,"Tint#5",100},
            {5,"Tint#6",100},
            {6,"Tint#7",100},
            {7,"Tint#8",100},
            {8,"Tint#9",100},
            {9,"Tint#10",100},
            {10,"Tint#11",100},
            {11,"Tint#12",100},
            {12,"Tint#13",100},
            {13,"Tint#14",100},
            {14,"Tint#15",100},
            {15,"Tint#16",100},
            {16,"Tint#17",100},
            {17,"Tint#18",100},
            {18,"Tint#19",100},
            {19,"Tint#20",100},
            {20,"Tint#21",100},
            {21,"Tint#22",100},
            {22,"Tint#23",100},
            {23,"Tint#24",100},
            {24,"Tint#25",100},
            {25,"Tint#26",100},
            {26,"Tint#27",100},
            {27,"Tint#28",100},
            {28,"Tint#29",100},
            {29,"Tint#30",100},
            {30,"Tint#31",100},
        },

        [`wagondairy01x`] = {
            {0,"Tint#1",100},
            {1,"Tint#2",100},
        },

        [`wagonPrison01x`] = {
            {0,"Tint#1",100},
            {1,"Tint#2",100},
            {2,"Tint#3",100},
            {3,"Tint#4",100},
            {4,"Tint#5",100},
            {5,"Tint#6",100},
            {6,"Tint#7",100},
        },

        [`wagontraveller01x`] = {
            {0,"Tint#1",100},
        },

        [`wagonwork01x`] = {
            {0,"Tint#1",100},
            {1,"Tint#2",100},
        },

        [`warwagon2`] = {
            {0,"Tint#1",100},
            {1,"Tint#2",100},
            {2,"Tint#3",100},
            {3,"Tint#4",100},
            {4,"Tint#5",100},
            {5,"Tint#6",100},
        },

        [`POLICEWAGON01X`] = {
            {0,"Tint#1",100},
            {1,"Tint#2",100},
            {2,"Tint#3",100},
        }, 

        [`gatchuck_2`] = {
            {0,"Tint#1",100},
            {1,"Tint#2",100},
            {2,"Tint#3",100},
            {3,"Tint#4",100},
            {4,"Tint#5",100},
            {5,"Tint#6",100},
            {6,"Tint#7",100},
            {7,"Tint#8",100},
            {8,"Tint#9",100},
            {9,"Tint#10",100},
            {10,"Tint#11",100},
            {11,"Tint#12",100},
            {12,"Tint#13",100},
            {13,"Tint#14",100},
            {14,"Tint#15",100},
            {15,"Tint#16",100},
        }, 

        [`STAGECOACH004_2x`] = {
            {0,"Tint#1",100},
            {1,"Tint#2",100},
            {2,"Tint#3",100},
            {3,"Tint#4",100},
            {4,"Tint#5",100},
        }, 

        [`STAGECOACH002X`] = {
            {0,"Tint#1",100},
            {1,"Tint#2",100},
            {2,"Tint#3",100},
            {3,"Tint#4",100},
        }, 

        [`STAGECOACH001X`] = {
            {0,"Tint#1",100},
            {1,"Tint#2",100},
            {2,"Tint#3",100},
            {3,"Tint#4",100},
        }, 

        [`COACH2`] = {
            {0,"Tint#1",100},
            {1,"Tint#2",100},
            {2,"Tint#3",100},
            {3,"Tint#4",100},
            {4,"Tint#5",100},
        }, 

        [`gatchuck`] = {
            {0,"Tint#1",100},
            {1,"Tint#2",100},
            {2,"Tint#3",100},
            {3,"Tint#4",100},
            {4,"Tint#5",100},
            {5,"Tint#6",100},
            {6,"Tint#7",100},
            {7,"Tint#8",100},
            {8,"Tint#9",100},
            {9,"Tint#10",100},
            {10,"Tint#11",100},
            {11,"Tint#12",100},
            {12,"Tint#13",100},
            {13,"Tint#14",100},
            {14,"Tint#15",100},
            {15,"Tint#16",100},
        }, 

        [`armysupplywagon`] = {
            {0,"Tint#1",100},
        },
    },
 
}