Config = Config or {} 
-------------------------------------------------------  
-------------------------------------------------------   
------------------------------------------------------- 

--////////////////////////////////////////////////////--
				-- PERSONALITIES --		
--////////////////////////////////////////////////////--	

-------------------------------------------------------  
-------------------------------------------------------  
-------------------------------------------------------   

-- DEFAULT PERSONALITIES TYPE : 
-- "DISTRUSTFUL" 	 
-- "SENSITIVE" 		 
-- "EASY_GOING" 	  
-- "SOCIAL" 		 
-- "FEARFUL" 		 
-- "ALOOF"			 
-- "CHALLENGING"	 
-- "DANGEROUS"		 
-- "PLAYFUL"		 
-- "MUD_MAGNET"		 
 
Config.PERSONALITY_ENABLED              = true    	 -- IF SET TO TRUE THIS WILL ENABLE HORSE PERSONALITY SYSTEM / KEEP IN MIND WITHOUT METABOLISM ENABLED PERSONALITIES WILL NEVER EVOLVE	
Config.HORSE_KICK_ON_DEMAND_HASHKEY 	= 0x07CE1E61 -- IF HORSE KICK EFFECT IS ENABLED YOU'LL BE ABLE TO KICK PEDS AROUND YOU
Config.PERSONALITY_EFFECT_CHECK_DELAY	= 5  		 -- EVERY X MINUTE ONE OF THESE PERSONALITY EFFECTS WILL BE TRIGGERED IF VALUE = true OR VALUE > 0 
Config.PERSONALITY_EVOLUTION_ENABLED	= true       -- ENABLE / DISABLE THE PERSONALITY EVOLUTION SYSTEM BETWEEN BONDING STAGES  		 

Config.KICK_ON_DEMAND_RESTRICTION 		= false       -- IF SET TO TRUE KICK ON DEMAND WILL BE RESTRICTED IN THE FOLLOWING ZONES :
Config.KICK_ON_DEMAND_RESTRICTION_ZONES = {
 [1] = {LABEL = "VALENTINE", COORDS = {-295.45, 738.44, 117.74}, RADIUS = 200.0},
}


 
Config.PERSONALITIES = {

[1] = {PERSONALITY        			= "DISTRUSTFUL",
	   LABEL        				= "Distrustful", -- LABEL THAT WILL APPEAR IN MENU AND NOTIFICATIONS
	   LOVE_RESULT_THRESHOLD 		= 50, -- IF LOVE LVL < LOVE_RESULT_THRESHOLD THEN NEGATIVE EVOLUTION. IF LOVE LVL > LOVE_RESULT_THRESHOLD THEN POSITIVE EVOLUTION. IF LOVE LVL = LOVE_RESULT_THRESHOLD THEN THE PERSONALITY STAYS THE SAME. THIS WILL BE MEASURED BETWEEN BONDING STAGES (4 in total) 
	   POSITIVE_EVOLUTION 			= "SOCIAL", 
	   NEGATIVE_EVOLUTION 			= "DANGEROUS", 
	   STABLE_PRICE_CHANGE_DOLLARS 	= 100, 
	   STABLE_PRICE_CHANGE_GOLD    	= 10, 
	   EFFECTS = {  
		[1]  = {ENABLED = true,	 NAME = "HORSE_CALLS_DELAY"  				 , LABEL = "Calls Delay",         		VALUE = 1    },  -- HOW MANY SECONDS IT WILL TAKE TO YOUR HORSE TO FOLLOW OR START TO GET TO YOU WHEN SPAWNED
		[2]  = {ENABLED = true,	 NAME = "HORSE_SKIP_COMMANDS"				 , LABEL = "Skip Commands",       		VALUE = 20   },  -- WHAT ARE THE CHANCES YOUR HORSE IS GOING TO SKIP COMMANDS WHEN ASKING TO FOLLOW IF THIS EFFECT IS RANDOMLY SELECTED
 		[3]  = {ENABLED = true,	 NAME = "HORSE_ATTACK_HUMANS"				 , LABEL = "Kick Humans",       		VALUE = 100  },  -- WHAT ARE THE CHANCES YOUR HORSE IS GOING TO ATTACK HUMANS IF THIS EFFECT IS RANDOMLY SELECTED
 		[4]  = {ENABLED = true,	 NAME = "HORSE_ATTACK_ANIMALS"				 , LABEL = "Kick Animals",       		VALUE = 100  },  -- WHAT ARE THE CHANCES YOUR HORSE IS GOING TO ATTACK ANIMALS IF THIS EFFECT IS RANDOMLY SELECTED
 		[5]  = {ENABLED = true,  NAME = "HORSE_ANIMALS_FEAR" 				 , LABEL = "Special animal fear", 
				ANIMAL_LIST = { [1] = {MODEL = "a_c_cow"  	  , LABEL = "Cow" },
								[2] = {MODEL = "a_c_sheep_01" , LABEL = "Sheep"},
							 	[3] = {MODEL = "HORSES" ,       LABEL = "Horses", GENDER = "BOTH"},  							 	 -- IF MODEL JUST SET TO "HORSES", IT WILL FEAR ALL HORSES AND GENDER PARAM WILL BE TAKEN INTO ACCOUNT / GENDER CAN BE "MALE" "FEMALE" "BOTH"
					},
				},
		[6]  = {ENABLED = true,  NAME = "HORSE_KICK_ON_DEMAND"        		 , LABEL = "Horse Kick on demand"     				},
		[7]  = {ENABLED = true,  NAME = "HORSE_LACK_OF_CARE_RESISTANCE"      , LABEL = "Lack of care resistance"  				},   -- IF METABOLISM IS ENABLED AND LACK_OF_CARE_RESISTANCE = true, THE HORSE WILL NOT BE AFFECTED BY STAT PENALTIES
		[8]  = {ENABLED = true,  NAME = "HORSE_RANDOMLY_THROW_RIDER"         , LABEL = "Throw rider",   			VALUE  = 100},
 		[9]  = {ENABLED = true,  NAME = "HORSE_RANDOMLY_FLEE"    		     , LABEL = "Randomly flee", 			VALUE  = 100},
		[10] = {ENABLED = false, NAME = "HORSE_CLUMSINESS"			         , LABEL = "Clumsiness",    			VALUE  = 100},   -- IF SET TO > 0 YOUR HORSE WILL NOT AUTOMATICALLY JUMP OBSTACLES AND WILL SOMETIMES FALL DEPENDING ON THE CLUMSINESS LEVEL 
		[11] = {ENABLED = false, NAME = "HORSE_RANDOMLY_FOLLOW"			     , LABEL = "Randomly Follow",    		VALUE  = 100},   -- YOUR HORSE WILL RANDOMLY FOLLOW NEARBY HUMAN OR ANIMAL  
		[12] = {ENABLED = false, NAME = "HORSE_BUCKING"			    		 , LABEL = "Bucking",    				VALUE  = 100},	 -- YOUR HORSE WILL RANDOMLY BUCK
		[13] = {ENABLED = false, NAME = "HORSE_WALLOW"			    		 , LABEL = "Wallow",    				VALUE  = 100},	 -- YOUR HORSE WILL RANDOMLY WALLOW	
		[14] = {ENABLED = false, NAME = "HORSE_DEFEND"			    		 , LABEL = "Defend", 				    VALUE  = 0	},	 -- YOUR HORSE WILL DEFEND YOU AGAINST ATTACKERS, VALUE IS THE BONDING LEVEL
		},	
	},
 
[2] = {PERSONALITY        			= "SENSITIVE",
	   LABEL        				= "Sensitive",
	   LOVE_RESULT_THRESHOLD 		= 50, 
	   POSITIVE_EVOLUTION 			= "SENSITIVE", 
	   NEGATIVE_EVOLUTION 			= "DISTRUSTFUL", 
 	   STABLE_PRICE_CHANGE_DOLLARS  = 100, 
	   STABLE_PRICE_CHANGE_GOLD     = 10,
	   EFFECTS = {  
		[1]  = {ENABLED = false, NAME = "HORSE_CALLS_DELAY"  				 , LABEL = "Calls Delay",         		VALUE = 1    },   
		[2]  = {ENABLED = false, NAME = "HORSE_SKIP_COMMANDS"				 , LABEL = "Skip Commands",       		VALUE = 20   },   
 		[3]  = {ENABLED = true,  NAME = "HORSE_ATTACK_HUMANS"				 , LABEL = "Kick Humans",       		VALUE = 100  }, 
 		[4]  = {ENABLED = false, NAME = "HORSE_ATTACK_ANIMALS"				 , LABEL = "Kick Animals",       		VALUE = 100  }, 
 		[5]  = {ENABLED = true,  NAME = "HORSE_ANIMALS_FEAR" 				 , LABEL = "Special animal fear", 
				ANIMAL_LIST = {  
								  [1] = {MODEL = "HUMANS" ,  LABEL = "Humans"},  							
					},
				},
		[6]  = {ENABLED = true,  NAME = "HORSE_KICK_ON_DEMAND"        		 , LABEL = "Horse Kick on demand"     				},
		[7]  = {ENABLED = false, NAME = "HORSE_LACK_OF_CARE_RESISTANCE"      , LABEL = "Lack of care resistance"  				},  
		[8]  = {ENABLED = true,  NAME = "HORSE_RANDOMLY_THROW_RIDER"         , LABEL = "Throw rider",   			VALUE  = 100},  
 		[9]  = {ENABLED = true,  NAME = "HORSE_RANDOMLY_FLEE"    		     , LABEL = "randomly flee", 			VALUE  = 100},  
		[10] = {ENABLED = false, NAME = "HORSE_CLUMSINESS"			         , LABEL = "Clumsiness",    			VALUE  = 100}, 
		[11] = {ENABLED = false, NAME = "HORSE_RANDOMLY_FOLLOW"			     , LABEL = "Randomly Follow",    		VALUE  = 100},   
		[12] = {ENABLED = false, NAME = "HORSE_BUCKING"			    		 , LABEL = "Bucking",    				VALUE  = 100},	
		[13] = {ENABLED = false, NAME = "HORSE_WALLOW"			    		 , LABEL = "Wallow",    				VALUE  = 100},	
		[14] = {ENABLED = false, NAME = "HORSE_DEFEND"			    		 , LABEL = "Defend", 				    VALUE  = 0	},	 -- YOUR HORSE WILL DEFEND YOU AGAINST ATTACKERS, VALUE IS THE BONDING LEVEL	
		},		
	},

[3] = {PERSONALITY        			= "EASY_GOING",
	   LABEL        				= "Easy Going", 
	   LOVE_RESULT_THRESHOLD 		= 50,
	   POSITIVE_EVOLUTION 			= "SENSITIVE", 
	   NEGATIVE_EVOLUTION 			= "ALOOF", 
 	   STABLE_PRICE_CHANGE_DOLLARS	= 100, 
	   STABLE_PRICE_CHANGE_GOLD   	= 10,
	   EFFECTS = {  
		[1]  = {ENABLED = false, NAME = "HORSE_CALLS_DELAY"  				 , LABEL = "Calls Delay",         		VALUE = 1    },  
		[2]  = {ENABLED = false, NAME = "HORSE_SKIP_COMMANDS"				 , LABEL = "Skip Commands",       		VALUE = 0  	 },  
 		[3]  = {ENABLED = false, NAME = "HORSE_ATTACK_HUMANS"				 , LABEL = "Kick Humans",       		VALUE = 100  },  
 		[4]  = {ENABLED = false, NAME = "HORSE_ATTACK_ANIMALS"				 , LABEL = "Kick Animals",       		VALUE = 100  },  
 		[5]  = {ENABLED = false, NAME = "HORSE_ANIMALS_FEAR" 				 , LABEL = "Special animal fear", 
				ANIMAL_LIST = { [1] = {MODEL = "a_c_deer_01" , LABEL = "Deer"},
								[2] = {MODEL = "a_c_skunk_01" , LABEL = "Skunk"},
 
					},
				},
		[6]  = {ENABLED = false, NAME = "HORSE_KICK_ON_DEMAND"        		 , LABEL = "Horse Kick on demand"     				}, 
		[7]  = {ENABLED = false, NAME = "HORSE_LACK_OF_CARE_RESISTANCE"      , LABEL = "Lack of care resistance"  				}, 
		[8]  = {ENABLED = false, NAME = "HORSE_RANDOMLY_THROW_RIDER"         , LABEL = "Throw rider",   			VALUE  = 100}, 
 		[9]  = {ENABLED = false, NAME = "HORSE_RANDOMLY_FLEE"    		     , LABEL = "randomly flee", 			VALUE  = 100}, 
		[10] = {ENABLED = false, NAME = "HORSE_CLUMSINESS"			         , LABEL = "Clumsiness",    			VALUE  = 100}, 
		[11] = {ENABLED = true,  NAME = "HORSE_RANDOMLY_FOLLOW"			     , LABEL = "Randomly Follow",    		VALUE  = 100},   
		[12] = {ENABLED = false, NAME = "HORSE_BUCKING"			    		 , LABEL = "Bucking",    				VALUE  = 100},	
		[13] = {ENABLED = true,  NAME = "HORSE_WALLOW"			    		 , LABEL = "Wallow",    				VALUE  = 100},	
		[14] = {ENABLED = true,  NAME = "HORSE_DEFEND"			    		 , LABEL = "Defend", 				    VALUE  = 0	},	 -- YOUR HORSE WILL DEFEND YOU AGAINST ATTACKERS, VALUE IS THE BONDING LEVEL
		
		},		
	},

[4] = {PERSONALITY       			= "SOCIAL", 
	   LABEL        				= "Social", 
	   LOVE_RESULT_THRESHOLD 		= 50,
	   POSITIVE_EVOLUTION 			= "SENSITIVE", 
	   NEGATIVE_EVOLUTION 			= "ALOOF", 
 	   STABLE_PRICE_CHANGE_DOLLARS 	= 100, 
	   STABLE_PRICE_CHANGE_GOLD    	= 10,
	   EFFECTS = {  
		[1]  = {ENABLED = false,  NAME = "HORSE_CALLS_DELAY"  				 , LABEL = "Calls Delay",         		VALUE = 1  }, 
		[2]  = {ENABLED = false,  NAME = "HORSE_SKIP_COMMANDS"				 , LABEL = "Skip Commands",       		VALUE = 0  }, 
 		[3]  = {ENABLED = false,  NAME = "HORSE_ATTACK_HUMANS"				 , LABEL = "Kick Humans",       		VALUE = 100  }, 
 		[4]  = {ENABLED = false,  NAME = "HORSE_ATTACK_ANIMALS"				 , LABEL = "Kick Animals",       		VALUE = 100  }, 
 		[5]  = {ENABLED = false,  NAME = "HORSE_ANIMALS_FEAR" 				 , LABEL = "Special animal fear", 
				ANIMAL_LIST = { [1] = {MODEL = "a_c_deer_01" , LABEL = "Deer"},
								[2] = {MODEL = "a_c_skunk_01" , LABEL = "Skunk"},
							--	[3] = {MODEL = "HORSES" ,       LABEL = "Horses", GENDER = "BOTH"},  -- IF MODEL JUST SET TO "HORSES", IT WILL FEAR ALL HORSES AND GENDER PARAM WILL BE TAKEN INTO ACCOUNT / GENDER CAN BE "MALE" "FEMALE" "BOTH"
					},
				},
		[6]  = {ENABLED = false, NAME = "HORSE_KICK_ON_DEMAND"        		 , LABEL = "Horse Kick on demand"     				},  
		[7]  = {ENABLED = false, NAME = "HORSE_LACK_OF_CARE_RESISTANCE"      , LABEL = "Lack of care resistance"  				},  
		[8]  = {ENABLED = false, NAME = "HORSE_RANDOMLY_THROW_RIDER"         , LABEL = "Throw rider",   			VALUE  = 100},  
 		[9]  = {ENABLED = true,  NAME = "HORSE_RANDOMLY_FLEE"    		     , LABEL = "randomly flee", 			VALUE  = 100},  
		[10] = {ENABLED = false, NAME = "HORSE_CLUMSINESS"			         , LABEL = "Clumsiness",    			VALUE  = 100}, 
		[11] = {ENABLED = true,  NAME = "HORSE_RANDOMLY_FOLLOW"			     , LABEL = "Randomly Follow",    		VALUE  = 100},   
		[12] = {ENABLED = false, NAME = "HORSE_BUCKING"			    		 , LABEL = "Bucking",    				VALUE  = 100},		
		[13] = {ENABLED = true,  NAME = "HORSE_WALLOW"			    		 , LABEL = "Wallow",    				VALUE  = 100},	
		[14] = {ENABLED = false, NAME = "HORSE_DEFEND"			    		 , LABEL = "Defend", 				    VALUE  = 0	},	 -- YOUR HORSE WILL DEFEND YOU AGAINST ATTACKERS, VALUE IS THE BONDING LEVEL
		
		},		
	},


[5] = {PERSONALITY        			= "FEARFUL",
	   LABEL        				= "Fearful",
	   LOVE_RESULT_THRESHOLD 		= 50, 
	   POSITIVE_EVOLUTION 			= "SOCIAL", 
	   NEGATIVE_EVOLUTION 			= "CHALLENGING", 
	   STABLE_PRICE_CHANGE_DOLLARS 	= 100, 
	   STABLE_PRICE_CHANGE_GOLD    	= 10,
	   EFFECTS = {  
		[1]  = {ENABLED = true,  NAME = "HORSE_CALLS_DELAY"  				 , LABEL = "Calls Delay",         		VALUE = 1  }, 
		[2]  = {ENABLED = true,  NAME = "HORSE_SKIP_COMMANDS"				 , LABEL = "Skip Commands",       		VALUE = 20  }, 
 		[3]  = {ENABLED = true,  NAME = "HORSE_ATTACK_HUMANS"				 , LABEL = "Kick Humans",       		VALUE = 100  }, 
 		[4]  = {ENABLED = true,  NAME = "HORSE_ATTACK_ANIMALS"				 , LABEL = "Kick Animals",       		VALUE = 100  }, 
 		[5]  = {ENABLED = true,  NAME = "HORSE_ANIMALS_FEAR" 				 , LABEL = "Special animal fear", 
				ANIMAL_LIST = { 
							   [1] = {MODEL = "HUMANS" ,  LABEL = "Humans"},
  					},
				},
		[6]  = {ENABLED = false, NAME = "HORSE_KICK_ON_DEMAND"        		 , LABEL = "Horse Kick on demand"     				},  
		[7]  = {ENABLED = true,  NAME = "HORSE_LACK_OF_CARE_RESISTANCE"      , LABEL = "Lack of care resistance"  				},  
		[8]  = {ENABLED = true,  NAME = "HORSE_RANDOMLY_THROW_RIDER"         , LABEL = "Throw rider",   			VALUE  = 100},  
 		[9]  = {ENABLED = true,  NAME = "HORSE_RANDOMLY_FLEE"    		     , LABEL = "randomly flee", 			VALUE  = 100},  
		[10] = {ENABLED = true,  NAME = "HORSE_CLUMSINESS"			         , LABEL = "Clumsiness",    			VALUE  = 100}, 
		[11] = {ENABLED = true,  NAME = "HORSE_RANDOMLY_FOLLOW"			     , LABEL = "Randomly Follow",    		VALUE  = 100},   
		[12] = {ENABLED = true,  NAME = "HORSE_BUCKING"			    		 , LABEL = "Bucking",    				VALUE  = 100},	
		[13] = {ENABLED = false, NAME = "HORSE_WALLOW"			    		 , LABEL = "Wallow",    				VALUE  = 100},	
		[14] = {ENABLED = false, NAME = "HORSE_DEFEND"			    		 , LABEL = "Defend", 				    VALUE  = 0	},	 -- YOUR HORSE WILL DEFEND YOU AGAINST ATTACKERS, VALUE IS THE BONDING LEVEL
		
		},		
	},		
	
  					 
[6] = {PERSONALITY        			= "ALOOF",
	   LABEL        				= "Aloof", 
	   LOVE_RESULT_THRESHOLD 		= 50,
	   POSITIVE_EVOLUTION 			= "SOCIAL", 
	   NEGATIVE_EVOLUTION 			= "CHALLENGING", 
	   STABLE_PRICE_CHANGE_DOLLARS 	= 100, 
	   STABLE_PRICE_CHANGE_GOLD    	= 10,
	   EFFECTS = {  
		[1]  = {ENABLED = false, NAME = "HORSE_CALLS_DELAY"  				 , LABEL = "Calls Delay",         	VALUE = 1  }, 
		[2]  = {ENABLED = false, NAME = "HORSE_SKIP_COMMANDS"				 , LABEL = "Skip Commands",       	VALUE = 20  }, 
 		[3]  = {ENABLED = true,  NAME = "HORSE_ATTACK_HUMANS"				 , LABEL = "Kick Humans",       	VALUE = 100  }, 
 		[4]  = {ENABLED = true,  NAME = "HORSE_ATTACK_ANIMALS"				 , LABEL = "Kick Animals",       	VALUE = 100  }, 
 		[5]  = {ENABLED = false, NAME = "HORSE_ANIMALS_FEAR" 				 , LABEL = "Special animal fear", 
				ANIMAL_LIST = { [1] = {MODEL = "a_c_deer_01" , LABEL = "Deer"},
								[2] = {MODEL = "a_c_skunk_01" , LABEL = "Skunk"},
 					},
				},
		[6]  = {ENABLED = false, NAME = "HORSE_KICK_ON_DEMAND"        		, LABEL = "Horse Kick on demand"     		    },  
		[7]  = {ENABLED = true,  NAME = "HORSE_LACK_OF_CARE_RESISTANCE" 	, LABEL = "Lack of care resistance"  		    },  
		[8]  = {ENABLED = false, NAME = "HORSE_RANDOMLY_THROW_RIDER"    	, LABEL = "Throw rider",   			VALUE  = 100},  
 		[9]  = {ENABLED = true,  NAME = "HORSE_RANDOMLY_FLEE"    			, LABEL = "randomly flee", 			VALUE  = 100},  
		[10] = {ENABLED = false, NAME = "HORSE_CLUMSINESS"			    	, LABEL = "Clumsiness",    			VALUE  = 100}, 
		[11] = {ENABLED = false, NAME = "HORSE_RANDOMLY_FOLLOW"				, LABEL = "Randomly Follow",    	VALUE  = 100},   
		[12] = {ENABLED = false, NAME = "HORSE_BUCKING"			    		, LABEL = "Bucking",    			VALUE  = 100},	
		[13] = {ENABLED = false, NAME = "HORSE_WALLOW"			    		, LABEL = "Wallow",    				VALUE  = 100},	
		[14] = {ENABLED = false, NAME = "HORSE_DEFEND"			    		 , LABEL = "Defend", 				    VALUE  = 0	},	 -- YOUR HORSE WILL DEFEND YOU AGAINST ATTACKERS, VALUE IS THE BONDING LEVEL
		
		},		
	},
 

[7] = {PERSONALITY        			= "CHALLENGING",
	   LABEL        				= "Challenging",
	   LOVE_RESULT_THRESHOLD 		= 50,
	   POSITIVE_EVOLUTION 			= "EASY_GOING", 
	   NEGATIVE_EVOLUTION 			= "DANGEROUS", 
 	   STABLE_PRICE_CHANGE_DOLLARS 	= 100, 
	   STABLE_PRICE_CHANGE_GOLD    	= 10,
	   EFFECTS = {  
		[1]  = {ENABLED = true,  NAME = "HORSE_CALLS_DELAY"  				 , LABEL = "Calls Delay",         		VALUE = 1   }, 
		[2]  = {ENABLED = true,  NAME = "HORSE_SKIP_COMMANDS"				 , LABEL = "Skip Commands",       		VALUE = 20  }, 
 		[3]  = {ENABLED = false, NAME = "HORSE_ATTACK_HUMANS"				 , LABEL = "Kick Humans",       		VALUE = 100  }, 
 		[4]  = {ENABLED = false, NAME = "HORSE_ATTACK_ANIMALS"				 , LABEL = "Kick Animals",       		VALUE = 100  }, 
 		[5]  = {ENABLED = false, NAME = "HORSE_ANIMALS_FEAR" 				 , LABEL = "Special animal fear", 
				ANIMAL_LIST = { [1] = {MODEL = "a_c_deer_01" , LABEL = "Deer"},
								[2] = {MODEL = "a_c_skunk_01" , LABEL = "Skunk"},
							--	[3] = {MODEL = "HORSES" ,       LABEL = "Horses", GENDER = "BOTH"},  -- IF MODEL JUST SET TO "HORSES", IT WILL FEAR ALL HORSES AND GENDER PARAM WILL BE TAKEN INTO ACCOUNT / GENDER CAN BE "MALE" "FEMALE" "BOTH"	
					},
				},
		[6]  = {ENABLED = false, NAME = "HORSE_KICK_ON_DEMAND"        		 , LABEL = "Horse Kick on demand"     				}, 
		[7]  = {ENABLED = false, NAME = "HORSE_LACK_OF_CARE_RESISTANCE"      , LABEL = "Lack of care resistance"  				}, 
		[8]  = {ENABLED = false, NAME = "HORSE_RANDOMLY_THROW_RIDER"         , LABEL = "Throw rider",   			VALUE  = 100}, 
 		[9]  = {ENABLED = true,  NAME = "HORSE_RANDOMLY_FLEE"    		     , LABEL = "randomly flee", 			VALUE  = 100}, 
		[10] = {ENABLED = true,  NAME = "HORSE_CLUMSINESS"			         , LABEL = "Clumsiness",    			VALUE  = 100}, 
		[11] = {ENABLED = false, NAME = "HORSE_RANDOMLY_FOLLOW"			     , LABEL = "Randomly Follow",    		VALUE  = 100},   
		[12] = {ENABLED = true,  NAME = "HORSE_BUCKING"			    		 , LABEL = "Bucking",    				VALUE  = 100},		
		[13] = {ENABLED = false, NAME = "HORSE_WALLOW"			    		 , LABEL = "Wallow",    				VALUE  = 100},	
		[14] = {ENABLED = false, NAME = "HORSE_DEFEND"			    		 , LABEL = "Defend", 				    VALUE  = 0	},	 -- YOUR HORSE WILL DEFEND YOU AGAINST ATTACKERS, VALUE IS THE BONDING LEVEL
		
		},		
	},



[8] = {PERSONALITY        			= "DANGEROUS",
	   LABEL        				= "Dangerous", 
	   LOVE_RESULT_THRESHOLD 		= 50,
	   POSITIVE_EVOLUTION 			= "ALOOF", 
	   NEGATIVE_EVOLUTION 			= "DANGEROUS", 
	   STABLE_PRICE_CHANGE_DOLLARS 	= 100, 
	   STABLE_PRICE_CHANGE_GOLD    	= 10,
	   EFFECTS = {  
		[1]  = {ENABLED = false, NAME = "HORSE_CALLS_DELAY"  				 , LABEL = "Calls Delay",         		VALUE = 1  },  
		[2]  = {ENABLED = false, NAME = "HORSE_SKIP_COMMANDS"				 , LABEL = "Skip Commands",       		VALUE = 20  },  
 		[3]  = {ENABLED = true,  NAME = "HORSE_ATTACK_HUMANS"				 , LABEL = "Kick Humans",       		VALUE = 50  },  
 		[4]  = {ENABLED = true,  NAME = "HORSE_ATTACK_ANIMALS"				 , LABEL = "Kick Animals",       		VALUE = 50  },  
 		[5]  = {ENABLED = true,  NAME = "HORSE_ANIMALS_FEAR" 				 , LABEL = "Special animal fear", 
				ANIMAL_LIST = { 
							--  [1] = {MODEL = "a_c_deer_01" , LABEL = "Deer"},
							--	[2] = {MODEL = "a_c_skunk_01" , LABEL = "Skunk"},
								[1] = {MODEL = "HORSES" ,       LABEL = "Horses", GENDER = "BOTH"},  -- IF MODEL JUST SET TO "HORSES", IT WILL FEAR ALL HORSES AND GENDER PARAM WILL BE TAKEN INTO ACCOUNT / GENDER CAN BE "MALE" "FEMALE" "BOTH"
					},
				},
		[6]  = {ENABLED = true,  NAME = "HORSE_KICK_ON_DEMAND"        		 , LABEL = "Horse Kick on demand"     				},  
		[7]  = {ENABLED = true,  NAME = "HORSE_LACK_OF_CARE_RESISTANCE"      , LABEL = "Lack of care resistance"  				},  
		[8]  = {ENABLED = true,  NAME = "HORSE_RANDOMLY_THROW_RIDER"         , LABEL = "Throw rider",   			VALUE  = 100},  
 		[9]  = {ENABLED = true,  NAME = "HORSE_RANDOMLY_FLEE"    		     , LABEL = "randomly flee", 			VALUE  = 100},  
		[10] = {ENABLED = true,  NAME = "HORSE_CLUMSINESS"			         , LABEL = "Clumsiness",    			VALUE  = 100},  
		[11] = {ENABLED = true,  NAME = "HORSE_RANDOMLY_FOLLOW"			     , LABEL = "Randomly Follow",    		VALUE  = 100},   
		[12] = {ENABLED = true,  NAME = "HORSE_BUCKING"			    		 , LABEL = "Bucking",    				VALUE  = 100},		
		[13] = {ENABLED = false, NAME = "HORSE_WALLOW"			    		 , LABEL = "Wallow",    				VALUE  = 100},	
		[14] = {ENABLED = false, NAME = "HORSE_DEFEND"			    		 , LABEL = "Defend", 				    VALUE  = 0	},	 -- YOUR HORSE WILL DEFEND YOU AGAINST ATTACKERS, VALUE IS THE BONDING LEVEL
		
		},	
	},

[9] = {PERSONALITY        			= "PLAYFUL",
	   LABEL        				= "Playful", 
	   LOVE_RESULT_THRESHOLD 		= 50,
	   POSITIVE_EVOLUTION 			= "SOCIAL", 
	   NEGATIVE_EVOLUTION 			= "DISTRUSTFUL", 
	   STABLE_PRICE_CHANGE_DOLLARS 	= 100, 
	   STABLE_PRICE_CHANGE_GOLD     = 10,
	   EFFECTS = {  
		[1]  = {ENABLED = true,  NAME = "HORSE_CALLS_DELAY"  				 , LABEL = "Calls Delay",         		VALUE = 1  },  
		[2]  = {ENABLED = true,  NAME = "HORSE_SKIP_COMMANDS"				 , LABEL = "Skip Commands",       		VALUE = 20  },  
 		[3]  = {ENABLED = false, NAME = "HORSE_ATTACK_HUMANS"				 , LABEL = "Kick Humans",       		VALUE = 50  },  
 		[4]  = {ENABLED = false, NAME = "HORSE_ATTACK_ANIMALS"				 , LABEL = "Kick Animals",       		VALUE = 50  },  
 		[5]  = {ENABLED = false, NAME = "HORSE_ANIMALS_FEAR" 				 , LABEL = "Special animal fear", 
				ANIMAL_LIST = { [1] = {MODEL = "a_c_deer_01" , LABEL = "Deer"},
								[2] = {MODEL = "a_c_skunk_01" , LABEL = "Skunk"},
							--	[3] = {MODEL = "HORSES" ,       LABEL = "Horses", GENDER = "BOTH"},  -- IF MODEL JUST SET TO "HORSES", IT WILL FEAR ALL HORSES AND GENDER PARAM WILL BE TAKEN INTO ACCOUNT / GENDER CAN BE "MALE" "FEMALE" "BOTH"						
					},
				},
		[6]  = {ENABLED = false, NAME = "HORSE_KICK_ON_DEMAND"        		 , LABEL = "Horse Kick on demand"     				}, 
		[7]  = {ENABLED = false, NAME = "HORSE_LACK_OF_CARE_RESISTANCE"      , LABEL = "Lack of care resistance"  				}, 
		[8]  = {ENABLED = true,  NAME = "HORSE_RANDOMLY_THROW_RIDER"         , LABEL = "Throw rider",   			VALUE  = 100}, 
 		[9]  = {ENABLED = true,  NAME = "HORSE_RANDOMLY_FLEE"    		     , LABEL = "randomly flee", 			VALUE  = 100}, 
		[10] = {ENABLED = false, NAME = "HORSE_CLUMSINESS"			         , LABEL = "Clumsiness",    			VALUE  = 100}, 
		[11] = {ENABLED = true,  NAME = "HORSE_RANDOMLY_FOLLOW"			     , LABEL = "Randomly Follow",    		VALUE  = 100},   
		[12] = {ENABLED = true,  NAME = "HORSE_BUCKING"			    		 , LABEL = "Bucking",    				VALUE  = 100},
		[13] = {ENABLED = true,  NAME = "HORSE_WALLOW"			    		 , LABEL = "Wallow",    				VALUE  = 100},	
		[14] = {ENABLED = false, NAME = "HORSE_DEFEND"			    		 , LABEL = "Defend", 				    VALUE  = 0	},	 -- YOUR HORSE WILL DEFEND YOU AGAINST ATTACKERS, VALUE IS THE BONDING LEVEL
		
		},		
	},
 		 
[10] = {PERSONALITY        	 		= "MUD_MAGNET",
	   LABEL        				= "Mud Magnet",
	   LOVE_RESULT_THRESHOLD 		= 50, 
	   POSITIVE_EVOLUTION    		= "EASY_GOING", 
	   NEGATIVE_EVOLUTION    		= "DISTRUSTFUL", 
	   STABLE_PRICE_CHANGE_DOLLARS  = 100, 
	   STABLE_PRICE_CHANGE_GOLD     = 10,
	   EFFECTS = {  
		[1]  = {ENABLED = false, NAME = "HORSE_CALLS_DELAY"  				 , LABEL = "Calls Delay",         		VALUE = 1   }, 
		[2]  = {ENABLED = false, NAME = "HORSE_SKIP_COMMANDS"				 , LABEL = "Skip Commands",       		VALUE = 20  }, 
 		[3]  = {ENABLED = false, NAME = "HORSE_ATTACK_HUMANS"				 , LABEL = "Kick Humans",       		VALUE = 50  }, 
 		[4]  = {ENABLED = false, NAME = "HORSE_ATTACK_ANIMALS"				 , LABEL = "Kick Animals",       		VALUE = 50  }, 
 		[5]  = {ENABLED = false, NAME = "HORSE_ANIMALS_FEAR" 				 , LABEL = "Special animal fear", 
				ANIMAL_LIST = { [1] = {MODEL = "a_c_deer_01" , LABEL = "Deer"},
								[2] = {MODEL = "a_c_skunk_01" , LABEL = "Skunk"},
							--	[3] = {MODEL = "HORSES" ,       LABEL = "Horses", GENDER = "BOTH"},  -- IF MODEL JUST SET TO "HORSES", IT WILL FEAR ALL HORSES AND GENDER PARAM WILL BE TAKEN INTO ACCOUNT / GENDER CAN BE "MALE" "FEMALE" "BOTH"							
					},
				},
		[6]  = {ENABLED = false, NAME = "HORSE_KICK_ON_DEMAND"        		 , LABEL = "Horse Kick on demand"     				}, 
		[7]  = {ENABLED = false, NAME = "HORSE_LACK_OF_CARE_RESISTANCE"      , LABEL = "Lack of care resistance"  				}, 
		[8]  = {ENABLED = true,  NAME = "HORSE_RANDOMLY_THROW_RIDER"         , LABEL = "Throw rider",   			VALUE  = 100}, 
 		[9]  = {ENABLED = true,  NAME = "HORSE_RANDOMLY_FLEE"    		     , LABEL = "randomly flee", 			VALUE  = 100}, 
		[10] = {ENABLED = true,  NAME = "HORSE_CLUMSINESS"			         , LABEL = "Clumsiness",    			VALUE  = 100}, 
		[11] = {ENABLED = true,  NAME = "HORSE_RANDOMLY_FOLLOW"			     , LABEL = "Randomly Follow",    		VALUE  = 100},   
		[12] = {ENABLED = false, NAME = "HORSE_BUCKING"			    		 , LABEL = "Bucking",    				VALUE  = 100},	
		[13] = {ENABLED = true,  NAME = "HORSE_WALLOW"			    		 , LABEL = "Wallow",    				VALUE  = 100},	
		[14] = {ENABLED = false, NAME = "HORSE_DEFEND"			    		 , LABEL = "Defend", 				    VALUE  = 0	},	 -- YOUR HORSE WILL DEFEND YOU AGAINST ATTACKERS, VALUE IS THE BONDING LEVEL
		
		},		
	},
 
}


 
-------------------------------------------------------  
-------------------------------------------------------   
------------------------------------------------------- 

--////////////////////////////////////////////////////--
				-- METABOLISM --		
--////////////////////////////////////////////////////--	

-------------------------------------------------------  
-------------------------------------------------------  
-------------------------------------------------------   

Config.METABOLISM_ENABLED               			   					= true    -- IF SET TO TRUE THIS WILL ENABLE HORSE METABOLISM SYSTEM 
Config.HORSE_DEBUFF_NOTIF_ENABLED   				   					= true    -- IF SET TO TRUE IT WILL DISPLAY THE LIST OF DEBUFF ON HORSE SPAWN AND METABOLISM UPDATE 
Config.HORSE_DEBUFF_NOTIF           				   					= "ACTIVE DEBUFF EFFECTS:" 
Config.HORSE_DEBUFF_NOTIF_DURATION  				   					= 6000

Config.METABOLISM_NOTIF		   					   						= true    -- IF TRUE IT WILL DISPLAY THE METABOLISM INCREASE AND DECREASE NOTIFICATIONS ON THE RIGHT 
 
Config.METABOLISM_CHECK 		   					   					= 15      -- EVERY x MINUTES THE SCRIPT WILL APPLY METABOLISM DECREASE 
Config.METABOLISM_HUNGER_LVL_DECREASE   			   					= -10     -- AT EVERYCHECK IT WILL DECREASE HUNGER BY THIS VALUE
Config.METABOLISM_THIRST_LVL_DECREASE   			   					= -10     -- AT EVERYCHECK IT WILL DECREASE THIRST BY THIS VALUE 
 
Config.METABOLISM_PEE_CHECK                                             = 10       -- IF THE HORSE PEE METABOLISM EFFECT IS ENABLED, EVERY X MINUTES IT WILL TRIGGER THE HORSE ANIMATION TO PEE 
 
-- LOVE_THRESHOLD MAX VALUE IS 100
-- HUNGER_AND_THIRST_THRESHOLD IS 400
-- GALLOP RESTRICTION WILL BE AUTOMATICALLY ENABLED IF THE HORSE OVERWEIGHT IS EFFECTIVE   
 
Config.METABOLISM_EFFECTS = {
[1] = {EFFECT_NAME = "METABOLISM_EFFECT_HORSE_NOT_REACTING_TO_CALL" , LABEL = "No reaction to calls"  	, ENABLED = true,  COMPARISON = "INFERIOR", HUNGER = 40, THIRST = 40, LOVE = false }, -- IF LOVE_THRESHOLD < 50 or HUNGER_AND_THIRST_THRESHOLD < 100 THEN IT WILL ENABLE THAT EFFECT IN GAME
[2] = {EFFECT_NAME = "METABOLISM_EFFECT_HORSE_LOWERING_HEAD" 		, LABEL = "Lower head" 		        , ENABLED = true,  COMPARISON = "INFERIOR", HUNGER = 40, THIRST = 40, LOVE = false },
[3] = {EFFECT_NAME = "METABOLISM_EFFECT_HORSE_NOT_FOLLOWING" 		, LABEL = "Refuse to follow" 	  	, ENABLED = true,  COMPARISON = "INFERIOR", HUNGER = 10, THIRST = 10, LOVE = false },
[4] = {EFFECT_NAME = "METABOLISM_EFFECT_HORSE_GALLOP_RESTRICTION" 	, LABEL = "Gallop restriction"	    , ENABLED = false, COMPARISON = "INFERIOR", HUNGER = 40, THIRST = 40, LOVE = false },
[5] = {EFFECT_NAME = "METABOLISM_EFFECT_HORSE_PEE" 					, LABEL = "Horse Pee"	    		, ENABLED = true,  COMPARISON = "SUPERIOR", HUNGER = false, THIRST = 100, LOVE = false }, -- IF  HUNGER_AND_THIRST_THRESHOLD > 200 THEN IT WILL ENABLE THAT EFFECT IN GAME
[6] = {EFFECT_NAME = "METABOLISM_EFFECT_HORSE_OVERWEIGHT" 			, LABEL = "Horse Overweight"	    , ENABLED = true,  COMPARISON = "SUPERIOR", HUNGER = 100, THIRST = false, LOVE = false },  
}
 
Config.METABOLISM = {   -- IF THIRST + HUNGER <= x WHAT LEVEL IS LOVE CAPPED  ?
[1] = { TITLE = "LOVE_CAP", 
		PENALTY = {
		{LEVEL = 400,  LOVE_CAPPED = 100 },
		{LEVEL = 200,  LOVE_CAPPED = 100 },
		{LEVEL = 180,  LOVE_CAPPED = 100 },
		{LEVEL = 140,  LOVE_CAPPED = 100 },
		{LEVEL = 120,  LOVE_CAPPED = 100 },
		{LEVEL = 100,  LOVE_CAPPED = 80  },
		{LEVEL = 80,   LOVE_CAPPED = 70  },
		{LEVEL = 60,   LOVE_CAPPED = 60  },
		{LEVEL = 40,   LOVE_CAPPED = 50  },
		{LEVEL = 20,   LOVE_CAPPED = 40  },
		{LEVEL = 0,    LOVE_CAPPED = 30  },
	   }, 
}, 

[2] = { TITLE = "STAMINA_STAT_PENALTY", 
		PENALTY = {
		{LEVEL = 200, LVL_DECREASE = 0},
		{LEVEL = 180, LVL_DECREASE = 0},
		{LEVEL = 160, LVL_DECREASE = 0},
		{LEVEL = 140, LVL_DECREASE = 0},
		{LEVEL = 120, LVL_DECREASE = 0},
		{LEVEL = 100, LVL_DECREASE = 0},
		{LEVEL = 80,  LVL_DECREASE = 1},
		{LEVEL = 60,  LVL_DECREASE = 2},
		{LEVEL = 40,  LVL_DECREASE = 3},
		{LEVEL = 20,  LVL_DECREASE = 4},
		{LEVEL = 0,   LVL_DECREASE = 5},
	}, 
}, 
	   
[3] = { TITLE = "HEALTH_STAT_PENALTY", 
		PENALTY = {
		{LEVEL = 200, LVL_DECREASE = 0},
		{LEVEL = 180, LVL_DECREASE = 0},
		{LEVEL = 160, LVL_DECREASE = 0},
		{LEVEL = 140, LVL_DECREASE = 0},
		{LEVEL = 120, LVL_DECREASE = 0},
		{LEVEL = 100, LVL_DECREASE = 0},
		{LEVEL = 80,  LVL_DECREASE = 1},
		{LEVEL = 60,  LVL_DECREASE = 2},
		{LEVEL = 40,  LVL_DECREASE = 3},
		{LEVEL = 20,  LVL_DECREASE = 4},
		{LEVEL = 0,   LVL_DECREASE = 5},
	   }, 
},

[4] = { TITLE = "COURAGE_STAT_PENALTY", 
		PENALTY = {
		{LEVEL = 200, LVL_DECREASE = 0},
		{LEVEL = 180, LVL_DECREASE = 0},
		{LEVEL = 160, LVL_DECREASE = 1},
		{LEVEL = 140, LVL_DECREASE = 2},
		{LEVEL = 120, LVL_DECREASE = 3},
		{LEVEL = 100, LVL_DECREASE = 4},
		{LEVEL = 80,  LVL_DECREASE = 5},
		{LEVEL = 60,  LVL_DECREASE = 6},
		{LEVEL = 40,  LVL_DECREASE = 7},
		{LEVEL = 20,  LVL_DECREASE = 8},
		{LEVEL = 0,   LVL_DECREASE = 9},
	   }, 
},  


[5] = { TITLE = "AGILITY_STAT_PENALTY", 
		PENALTY = {
		{LEVEL = 200, LVL_DECREASE = 0},
		{LEVEL = 180, LVL_DECREASE = 0},
		{LEVEL = 160, LVL_DECREASE = 1},
		{LEVEL = 140, LVL_DECREASE = 2},
		{LEVEL = 120, LVL_DECREASE = 3},
		{LEVEL = 100, LVL_DECREASE = 4},
		{LEVEL = 80,  LVL_DECREASE = 5},
		{LEVEL = 60,  LVL_DECREASE = 6},
		{LEVEL = 40,  LVL_DECREASE = 7},
		{LEVEL = 20,  LVL_DECREASE = 8},
		{LEVEL = 0,   LVL_DECREASE = 9},
	   }, 
},  
 
	   
[6] = { TITLE = "SPEED_STAT_PENALTY", 
		PENALTY = {
		{LEVEL = 200, LVL_DECREASE = 0},
		{LEVEL = 180, LVL_DECREASE = 0},
		{LEVEL = 160, LVL_DECREASE = 1},
		{LEVEL = 140, LVL_DECREASE = 2},
		{LEVEL = 120, LVL_DECREASE = 3},
		{LEVEL = 100, LVL_DECREASE = 4},
		{LEVEL = 80,  LVL_DECREASE = 5},
		{LEVEL = 60,  LVL_DECREASE = 6},
		{LEVEL = 40,  LVL_DECREASE = 7},
		{LEVEL = 20,  LVL_DECREASE = 8},
		{LEVEL = 0,   LVL_DECREASE = 9},
	   }, 
},  

[7] = { TITLE = "ACCELERATION_STAT_PENALTY", 
		PENALTY = {
		{LEVEL = 200, LVL_DECREASE = 0},
		{LEVEL = 180, LVL_DECREASE = 0},
		{LEVEL = 160, LVL_DECREASE = 1},
		{LEVEL = 140, LVL_DECREASE = 2},
		{LEVEL = 120, LVL_DECREASE = 3},
		{LEVEL = 100, LVL_DECREASE = 4},
		{LEVEL = 80,  LVL_DECREASE = 5},
		{LEVEL = 60,  LVL_DECREASE = 6},
		{LEVEL = 40,  LVL_DECREASE = 7},
		{LEVEL = 20,  LVL_DECREASE = 8},
		{LEVEL = 0,   LVL_DECREASE = 9},
	   }, 
	}, 
}


Config.LOVE = { -- IF LOVE < 100 WHAT PENALTY DOES THE HORSE GETS IN ITS STATS 
 
[1] = { TITLE = "STAMINA_STAT_PENALTY", 
		PENALTY = {
		{LEVEL = 100, LVL_DECREASE = 0},
		{LEVEL = 90,  LVL_DECREASE = 0},
		{LEVEL = 80,  LVL_DECREASE = 0},
		{LEVEL = 70,  LVL_DECREASE = 0},
		{LEVEL = 60,  LVL_DECREASE = 0},
		{LEVEL = 50,  LVL_DECREASE = 0},
		{LEVEL = 40,  LVL_DECREASE = 0},
		{LEVEL = 30,  LVL_DECREASE = 0},
		{LEVEL = 20,  LVL_DECREASE = 0},
		{LEVEL = 10,  LVL_DECREASE = 0},
		{LEVEL = 0,   LVL_DECREASE = 0},
	   }, 
}, 
	   
[2] = { TITLE = "HEALTH_STAT_PENALTY", 
		PENALTY = {
		{LEVEL = 100, LVL_DECREASE = 0},
		{LEVEL = 90,  LVL_DECREASE = 0},
		{LEVEL = 80,  LVL_DECREASE = 0},
		{LEVEL = 70,  LVL_DECREASE = 0},
		{LEVEL = 60,  LVL_DECREASE = 0},
		{LEVEL = 50,  LVL_DECREASE = 0},
		{LEVEL = 40,  LVL_DECREASE = 0},
		{LEVEL = 30,  LVL_DECREASE = 0},
		{LEVEL = 20,  LVL_DECREASE = 0},
		{LEVEL = 10,  LVL_DECREASE = 0},
		{LEVEL = 0,   LVL_DECREASE = 0},
	   }, 
},

[3] = { TITLE = "COURAGE_STAT_PENALTY", 
		PENALTY = {
		{LEVEL = 100, LVL_DECREASE = 0},
		{LEVEL = 90,  LVL_DECREASE = 0},
		{LEVEL = 80,  LVL_DECREASE = 0},
		{LEVEL = 70,  LVL_DECREASE = 0},
		{LEVEL = 60,  LVL_DECREASE = 0},
		{LEVEL = 50,  LVL_DECREASE = 0},
		{LEVEL = 40,  LVL_DECREASE = 0},
		{LEVEL = 30,  LVL_DECREASE = 0},
		{LEVEL = 20,  LVL_DECREASE = 0},
		{LEVEL = 10,  LVL_DECREASE = 0},
		{LEVEL = 0,   LVL_DECREASE = 0},
	   }, 
},  


[4] = { TITLE = "AGILITY_STAT_PENALTY", 
		PENALTY = {
		{LEVEL = 100, LVL_DECREASE = 0},
		{LEVEL = 90,  LVL_DECREASE = 0},
		{LEVEL = 80,  LVL_DECREASE = 0},
		{LEVEL = 70,  LVL_DECREASE = 0},
		{LEVEL = 60,  LVL_DECREASE = 0},
		{LEVEL = 50,  LVL_DECREASE = 0},
		{LEVEL = 40,  LVL_DECREASE = 0},
		{LEVEL = 30,  LVL_DECREASE = 0},
		{LEVEL = 20,  LVL_DECREASE = 0},
		{LEVEL = 10,  LVL_DECREASE = 0},
		{LEVEL = 0,   LVL_DECREASE = 0},
	   }, 
},  
 
	   
[5] = { TITLE = "SPEED_STAT_PENALTY", 
		PENALTY = {
		{LEVEL = 100, LVL_DECREASE = 0},
		{LEVEL = 90,  LVL_DECREASE = 0},
		{LEVEL = 80,  LVL_DECREASE = 0},
		{LEVEL = 70,  LVL_DECREASE = 0},
		{LEVEL = 60,  LVL_DECREASE = 0},
		{LEVEL = 50,  LVL_DECREASE = 0},
		{LEVEL = 40,  LVL_DECREASE = 0},
		{LEVEL = 30,  LVL_DECREASE = 0},
		{LEVEL = 20,  LVL_DECREASE = 0},
		{LEVEL = 10,  LVL_DECREASE = 0},
		{LEVEL = 0,   LVL_DECREASE = 0},
	   }, 
},  

[6] = { TITLE = "ACCELERATION_STAT_PENALTY", 
		PENALTY = {
		{LEVEL = 100, LVL_DECREASE = 0},
		{LEVEL = 90,  LVL_DECREASE = 0},
		{LEVEL = 80,  LVL_DECREASE = 0},
		{LEVEL = 70,  LVL_DECREASE = 0},
		{LEVEL = 60,  LVL_DECREASE = 0},
		{LEVEL = 50,  LVL_DECREASE = 0},
		{LEVEL = 40,  LVL_DECREASE = 0},
		{LEVEL = 30,  LVL_DECREASE = 0},
		{LEVEL = 20,  LVL_DECREASE = 0},
		{LEVEL = 10,  LVL_DECREASE = 0},
		{LEVEL = 0,   LVL_DECREASE = 0},
	   }, 
}, 

 

}