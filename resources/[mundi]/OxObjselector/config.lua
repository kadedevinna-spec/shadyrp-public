Config = {}

-- ================================================================================================
-- GENERAL SETTINGS
-- ================================================================================================

-- Language/Locale setting
-- Available languages: 'en' (English), 'fr' (French), 'sr' (Serbian), 'es' (Spanish), 'de' (German), 'pl' (Polish), 'pt' (Portuguese)
Config.Locale = 'en'

-- Interaction distance for ox_target
Config.InteractionDistance = 2.0

-- Enable debug prints
Config.Debug = false

-- ================================================================================================
-- OBJECT INTERACTIONS CONFIGURATION
-- ================================================================================================
-- This config allows you to define custom object models and their associated interactions.
-- Each object type can have multiple categories of interactions with different scenarios.
-- 
-- HOW TO ADD YOUR OWN OBJECTS:
-- 1. Add your object models to the appropriate category or create a new one
-- 2. Define the interaction categories with scenarios
-- 3. Set quick access options for common interactions
-- 4. Configure positioning offsets for proper character placement
-- ================================================================================================

-- ================================================================================================
-- OBJECT MODELS
-- ================================================================================================
-- Add the prop/model names for each object type
-- You can find model names using tools like CodeWalker or in-game prop spawners
--
-- CUSTOM OFFSETS (Optional):
-- You can specify custom positioning for individual objects using this format:
-- {model = "model_name", offsetX = 0.0, offsetY = 0.0, offsetZ = 0.0, headingOffset = 0.0}
--
-- If no custom offset is specified, the default from Config.Interactions will be used.
--
-- Example:
-- Chairs = {
--     "p_chair01x",  -- Uses default offsets
--     {model = "p_chair02x", offsetX = 0.5, offsetY = 0.2, offsetZ = 0.3, headingOffset = 90.0},  -- Custom offsets
-- }

Config.Objects = {
    -- ============================================================================================
    -- SEATING
    -- ============================================================================================
    Chairs = {
        -- Example with custom offsets (uncomment and modify as needed):
        -- {model = "mp005_s_posse_col_chair01x", offsetX = 0.0, offsetY = 0.0, offsetZ = 0.5, headingOffset = 180.0},
        
        "mp005_s_posse_col_chair01x", "mp005_s_posse_foldingchair_01x", "mp005_s_posse_trad_chair01x",
        "p_ambchair01x", "p_ambchair02x", "p_armchair01x", "p_bistrochair01x", "p_bench20x",
        "p_benchpiano02x", "p_chair02x", "p_chair04x", "p_chair05x", "p_chair06x", "p_chair07x",
        "p_chair09x", "p_chair_10x", "p_chair11x", "p_chair12bx", "p_chair12x", "p_chair13x",
        "p_chair14x", "p_chair15x", "p_chair16x", "p_chair17x", "p_chair18x", "p_chair19x",
        "p_chair20x", "p_chair21x", "p_chair21x_fussar", "p_chair22x", "p_chair23x", "p_chair24x",
        "p_chair25x", "p_chair26x", "p_chair27x", "p_chair30x", "p_chair31x", "p_chair37x",
        "p_chair38x", "p_chair_barrel04b", "p_chaircomfy01x", "p_chaircomfy02", "p_chaircomfy03x",
        "p_chaircomfy04x", "p_chaircomfy05x", "p_chaircomfy06x", "p_chaircomfy07x", "p_chaircomfy08x",
        "p_chaircomfy09x", "p_chaircomfy10x", "p_chaircomfy11x", "p_chaircomfy12x", "p_chaircomfy14x",
        "p_chaircomfy17x", "p_chaircomfy18x", "p_chaircomfy22x", "p_chaircomfy23x", "p_chairdoctor01x",
        "p_chair_crate02x", "p_chair_crate15x", "p_chair_cs05x", "p_chairdesk01x", "p_chairdesk02x",
        "p_chairdining01x", "p_chairdining02x", "p_chairdining03x", "p_chaireagle01x", "p_chairfolding02x",
        "p_chairhob01x", "p_chairhob02x", "p_chairmed01x", "p_chairmed02x", "p_chairoffice02x",
        "p_chairpokerfancy01x", "p_chairporch01x", "p_chair_privatedining01x", "p_chairrocking02x",
        "p_chairrocking03x", "p_chairrocking04x", "p_chairrocking05x", "p_chairrocking06x",
        "p_chairrustic01x", "p_chairrustic02x", "p_chairrustic03x", "p_chairrustic04x", "p_chairrustic05x",
        "p_chairsalon01x", "p_chairvictorian01x", "p_chairwhite01x", "p_chairwicker01x", "p_chairwicker02x",
        "p_cs_electricchair01x", "p_diningchairs01x", "p_gen_chair07x", "p_oldarmchair01x", "p_pianochair01x",
        "p_privatelounge_chair01x", "p_rockingchair01x", "p_rockingchair02x", "p_rockingchair03x",
        "p_seatbench01x", "p_settee02bx", "p_settee03x", "p_settee03bx", "p_sit_chairwicker01b",
        "p_stool01x", "p_stool02x", "p_stool03x", "p_stool04x", "p_stool05x", "p_stool06x",
        "p_stool07x", "p_stool08x", "p_stool09x", "p_stool10x", "p_stool12x", "p_stool13x",
        "p_stool14x", "p_stoolcomfy01x", "p_stoolcomfy02x", "p_stoolfolding01bx", "p_stoolfolding01x",
        "p_stoolwinter01x", "o_stoolfoldingstatic01x", "p_theaterchair01b01x", "p_windsorchair01x",
        "p_windsorchair02x", "p_windsorchair03x", "p_woodbench02x", "p_woodendeskchair01x", "s_bench01x",
        "p_barstool01x"
    },

    Benches = {
        "p_bench03x", "p_bench06x", "p_bench08bx", "p_bench09x", "p_bench15_mjr", "p_bench15x",
        "p_bench18x", "p_benchch01x", "p_benchironnbx01x", "p_bench_log01x", "p_bench_log02x",
        "p_bench_log03x", "p_bench_log04x", "p_bench_log05x", "p_bench_log06x", "p_bench_log07x",
        "p_bench_logsnow07x", "p_benchnbx02x", "p_benchnbx03x", "p_couch01x", "p_couch02x",
        "p_couch05x", "p_couch06x", "p_couch08x", "p_couch09x", "p_couch10x", "p_couch11x",
        "p_couchwicker01x", "p_hallbench01x", "p_loveseat01x", "p_settee01x", "p_settee04x",
        "p_settee_05x", "p_sit_chairwicker01a", "p_sofa02x", "p_windsorbench01x"
    },

    -- ============================================================================================
    -- SLEEPING & RESTING
    -- ============================================================================================
    Beds = {
        "p_bed14x", "p_bed17x", "p_bed21x", "p_bedbunk03x", "p_bedindian02x", "p_cot01x",
        "p_bed01x", "p_bed02x", "p_bed04x", "p_bed05x", "p_bed06x", "p_bed07x",
        "p_bed08x", "p_bed09x", "p_bed10x", "p_bed11x", "p_bed12x", "p_bed13x", "p_bed15x",
        "p_bed16x", "p_bed18x", "p_bed19x", "p_bed20x", "p_bed22x", "p_bed23x"
    },

    Beds2 = {
        "p_bed03x"
    },

    -- ============================================================================================
    -- MUSICAL INSTRUMENTS
    -- ============================================================================================
    Pianos = {
        "p_piano03x", "p_piano02x", "p_nbxpiano01x", "p_nbmpiano01x", "sha_man_piano01"
    },

    -- ============================================================================================
    -- MEDICAL & HYGIENE
    -- ============================================================================================
    MedicalObjects = {
        "p_bandage01x", "p_bandage02x", "p_bandage03x", "p_cs_bandage01x", "p_cs_bandage02x",
        "p_boxmedmedical01x", "p_medicalchart01x", "p_medicalchart02x"
    }

    -- Note: Bath and WashBasin objects are configured in bath_config.lua
}

-- ================================================================================================
-- INTERACTION CATEGORIES
-- ================================================================================================
-- Define the categories and scenarios for each object type
-- Format:
-- {
--     name = 'category_id',
--     label = 'Display Name',
--     icon = 'fontawesome_icon_name',
--     scenarios = {
--         {label = "Action Name", scenario = "SCENARIO_NAME"}
--     }
-- }

Config.Interactions = {
    -- ============================================================================================
    -- CHAIR INTERACTIONS
    -- ============================================================================================
    Chairs = {
        {
            name = 'basic',
            label = 'Basic Sitting',
            icon = 'chair',
            scenarios = {
                {label = "Sit", scenario = "PROP_HUMAN_SEAT_CHAIR", offsetX = 0.0, offsetY = 0.0, offsetZ = 0.5, headingOffset = 180.0},
                {label = "Sit (Generic)", scenario = "GENERIC_SEAT_CHAIR_SCENARIO", male = true, offsetX = 0.0, offsetY = 0.0, offsetZ = 0.5, headingOffset = 180.0},
                {label = "Sit at Table", scenario = "GENERIC_SEAT_CHAIR_TABLE_SCENARIO", offsetX = 0.0, offsetY = 0.0, offsetZ = 0.5, headingOffset = 180.0},
                {label = "Sit on Porch", scenario = "PROP_HUMAN_SEAT_CHAIR_PORCH", offsetX = 0.0, offsetY = 0.0, offsetZ = 0.5, headingOffset = 180.0},
            }
        },
        {
            name = 'social',
            label = 'Social Activities',
            icon = 'users',
            scenarios = {
                {label = "Drink", scenario = "PROP_HUMAN_SEAT_CHAIR_TABLE_DRINKING", offsetX = 0.0, offsetY = 0.0, offsetZ = 0.5, headingOffset = 180.0},
                {label = "Smoke", scenario = "PROP_HUMAN_SEAT_CHAIR_SMOKING", offsetX = 0.0, offsetY = 0.0, offsetZ = 0.5, headingOffset = 180.0},
                {label = "Cigar", scenario = "PROP_HUMAN_SEAT_CHAIR_CIGAR", male = true, offsetX = 0.0, offsetY = 0.0, offsetZ = 0.5, headingOffset = 180.0},
            }
        },
        {
            name = 'work',
            label = 'Work & Crafting',
            icon = 'tools',
            scenarios = {
                {label = "Whittle", scenario = "MP_LOBBY_PROP_HUMAN_SEAT_CHAIR_WHITTLE", offsetX = 0.0, offsetY = 0.0, offsetZ = 0.5, headingOffset = 180.0},
                {label = "Clean Rifle", scenario = "PROP_HUMAN_SEAT_CHAIR_CLEAN_RIFLE", offsetX = 0.0, offsetY = 0.0, offsetZ = 0.5, headingOffset = 180.0},
                {label = "Clean Saddle", scenario = "PROP_HUMAN_SEAT_CHAIR_CLEAN_SADDLE", offsetX = 0.0, offsetY = 0.0, offsetZ = 0.5, headingOffset = 180.0},
                {label = "Crab Trap", scenario = "PROP_HUMAN_SEAT_CHAIR_CRAB_TRAP", male = true, offsetX = 0.0, offsetY = 0.0, offsetZ = 0.5, headingOffset = 180.0},
                {label = "Knitting", scenario = "PROP_HUMAN_SEAT_CHAIR_KNITTING", female = true, offsetX = 0.0, offsetY = 0.0, offsetZ = 0.5, headingOffset = 180.0},
            }
        },
        {
            name = 'badass',
            label = 'Badass Poses',
            icon = 'user-ninja',
            scenarios = {
                {label = "Sit Badass", scenario = "MP_LOBBY_PROP_HUMAN_SEAT_CHAIR_KNIFE_BADASS", offsetX = 0.0, offsetY = 0.0, offsetZ = 0.5, headingOffset = 180.0},
                {label = "Knife Badass", scenario = "PROP_HUMAN_SEAT_CHAIR_KNIFE_BADASS", male = true, offsetX = 0.0, offsetY = 0.0, offsetZ = 0.5, headingOffset = 180.0},
            }
        },
        {
            name = 'music',
            label = 'Play Music',
            icon = 'music',
            scenarios = {
                {label = "Guitar", scenario = "PROP_HUMAN_SEAT_CHAIR_GUITAR", offsetX = 0.0, offsetY = 0.0, offsetZ = 0.5, headingOffset = 180.0},
                {label = "Banjo", scenario = "PROP_HUMAN_SEAT_CHAIR_BANJO", male = true, offsetX = 0.0, offsetY = 0.0, offsetZ = 0.5, headingOffset = 180.0},
            }
        },
        {
            name = 'leisure',
            label = 'Leisure Activities',
            icon = 'book-reader',
            scenarios = {
                {label = "Grooming (Rough)", scenario = "PROP_HUMAN_SEAT_CHAIR_GROOMING_GROSS", male = true, offsetX = 0.0, offsetY = 0.0, offsetZ = 0.5, headingOffset = 180.0},
                {label = "Grooming (Posh)", scenario = "PROP_HUMAN_SEAT_CHAIR_GROOMING_POSH", female = true, offsetX = 0.0, offsetY = 0.0, offsetZ = 0.5, headingOffset = 180.0},
                {label = "Read Book", scenario = "PROP_HUMAN_SEAT_CHAIR_READING", female = true, offsetX = 0.0, offsetY = 0.0, offsetZ = 0.5, headingOffset = 180.0},
            }
        },

    },

    -- ============================================================================================
    -- BENCH INTERACTIONS
    -- ============================================================================================
    Benches = {
        {
            name = 'basic',
            label = 'Basic Sitting',
            icon = 'couch',
            scenarios = {
                {label = "Sit", scenario = "PROP_HUMAN_SEAT_BENCH", offsetX = 0.0, offsetY = 0.0, offsetZ = 0.5, headingOffset = 180.0},
                {label = "Sit (Generic)", scenario = "GENERIC_SEAT_BENCH_SCENARIO", offsetX = 0.0, offsetY = 0.0, offsetZ = 0.5, headingOffset = 180.0},
            }
        },
        {
            name = 'social',
            label = 'Social Activities',
            icon = 'users',
            scenarios = {
                {label = "Drink", scenario = "MP_LOBBY_PROP_HUMAN_SEAT_BENCH_PORCH_DRINKING", offsetX = 0.0, offsetY = 0.0, offsetZ = 0.5, headingOffset = 180.0},
                {label = "Smoke", scenario = "MP_LOBBY_PROP_HUMAN_SEAT_BENCH_PORCH_SMOKING", offsetX = 0.0, offsetY = 0.0, offsetZ = 0.5, headingOffset = 180.0},
            }
        },
        {
            name = 'music',
            label = 'Play Music',
            icon = 'music',
            scenarios = {
                {label = "Mandolin", scenario = "PROP_HUMAN_SEAT_BENCH_MANDOLIN", male = true, offsetX = 0.0, offsetY = 0.0, offsetZ = 0.5, headingOffset = 180.0},
                {label = "Concertina", scenario = "PROP_HUMAN_SEAT_BENCH_CONCERTINA", male = true, offsetX = 0.0, offsetY = 0.0, offsetZ = 0.5, headingOffset = 180.0},
                {label = "Fiddle", scenario = "PROP_HUMAN_SEAT_BENCH_FIDDLE", female = true, offsetX = 0.0, offsetY = 0.0, offsetZ = 0.5, headingOffset = 180.0},
                {label = "Jaw Harp", scenario = "PROP_HUMAN_SEAT_BENCH_JAW_HARP", male = true, offsetX = 0.0, offsetY = 0.0, offsetZ = 0.5, headingOffset = 180.0},
            }
        }
    },

    -- ============================================================================================
    -- BED INTERACTIONS
    -- ============================================================================================
    Beds = {
        {
            name = 'sleeping',
            label = 'Sleeping Positions',
            icon = 'bed',
            scenarios = {
                {label = "Sleep on Pillow", scenario = "PROP_HUMAN_SLEEP_BED_PILLOW", offsetX = 0.0, offsetY = 0.0, offsetZ = 0.5, headingOffset = 180.0},
                {label = "Sleep (High Pillow)", scenario = "PROP_HUMAN_SLEEP_BED_PILLOW_HIGH", male = true, offsetX = 0.0, offsetY = 0.0, offsetZ = 0.5, headingOffset = 180.0},
                {label = "Sleep on Ground (Arm)", scenario = "WORLD_HUMAN_SLEEP_GROUND_ARM", offsetX = 0.0, offsetY = 0.0, offsetZ = 0.5, headingOffset = 180.0},
                {label = "Sleep on Ground (Pillow)", scenario = "WORLD_HUMAN_SLEEP_GROUND_PILLOW", offsetX = 0.0, offsetY = 0.0, offsetZ = 0.5, headingOffset = 180.0},
                {label = "Sit & Fall Asleep", scenario = "WORLD_HUMAN_SIT_FALL_ASLEEP", offsetX = 0.0, offsetY = 0.0, offsetZ = 0.5, headingOffset = 180.0},
                {label = "Sleep on Bedroll", scenario = "WORLD_PLAYER_SLEEP_BEDROLL", offsetX = 0.0, offsetY = 0.0, offsetZ = 0.5, headingOffset = 180.0},
                {label = "Sleep on Ground", scenario = "WORLD_PLAYER_SLEEP_GROUND", offsetX = 0.0, offsetY = 0.0, offsetZ = 0.5, headingOffset = 180.0},
            }
        }
    },

    Beds2 = {
        {
            name = 'sleeping2',
            label = 'Sleeping Positions 2',
            icon = 'bed',
            scenarios = {
                {label = "Sleep on Pillow", scenario = "PROP_HUMAN_SLEEP_BED_PILLOW", offsetX = 0.0, offsetY = 0.0, offsetZ = 0.5, headingOffset = 270},
                {label = "Sleep (High Pillow)", scenario = "PROP_HUMAN_SLEEP_BED_PILLOW_HIGH", male = true, offsetX = 0.0, offsetY = 0.0, offsetZ = 0.5, headingOffset = 270},
                {label = "Sleep on Ground (Arm)", scenario = "WORLD_HUMAN_SLEEP_GROUND_ARM", offsetX = 0.0, offsetY = 0.0, offsetZ = 0.5, headingOffset = 270},
                {label = "Sleep on Ground (Pillow)", scenario = "WORLD_HUMAN_SLEEP_GROUND_PILLOW", offsetX = 0.0, offsetY = 0.0, offsetZ = 0.5, headingOffset = 270},
                {label = "Sit & Fall Asleep", scenario = "WORLD_HUMAN_SIT_FALL_ASLEEP", offsetX = 0.0, offsetY = 0.0, offsetZ = 0.5, headingOffset = 270},
                {label = "Sleep on Bedroll", scenario = "WORLD_PLAYER_SLEEP_BEDROLL", offsetX = 0.0, offsetY = 0.0, offsetZ = 0.5, headingOffset = 270},
                {label = "Sleep on Ground", scenario = "WORLD_PLAYER_SLEEP_GROUND", offsetX = 0.0, offsetY = 0.0, offsetZ = 0.5, headingOffset = 270},
            }
        }
    },
    
    -- ============================================================================================
    -- PIANO INTERACTIONS
    -- ============================================================================================
    Pianos = {
        {
            name = 'playing',
            label = 'Playing Piano',
            icon = 'music',
            scenarios = {
                {label = "Play Piano (Male)", scenario = "PROP_HUMAN_PIANO", male = true, offsetX = 0.0, offsetY = -0.70, offsetZ = 0.5, headingOffset = 0.0},
                {label = "Play Piano (Female)", scenario = "PROP_HUMAN_ABIGAIL_PIANO", female = true, offsetX = 0.0, offsetY = -0.70, offsetZ = 0.5, headingOffset = 0.0},
            }
        }
    },



    -- ============================================================================================
    -- MEDICAL INTERACTIONS
    -- ============================================================================================
    MedicalObjects = {
        {
            name = 'treatment',
            label = 'Medical Treatment',
            icon = 'medkit',
            scenarios = {
                {label = "Organize Supplies", scenario = "WORLD_HUMAN_CROUCH_INSPECT", offsetX = 0.0, offsetY = 0.0, offsetZ = 0.0, headingOffset = 180.0},
                {label = "Examine Bandages", scenario = "WORLD_HUMAN_STAND_INSPECT", offsetX = 0.0, offsetY = 0.0, offsetZ = 0.0, headingOffset = 180.0},
            }
        }
    }
}

-- ================================================================================================
-- QUICK ACCESS CONFIGURATIONS
-- ================================================================================================
-- Define quick access buttons that appear first in ox_target menu
-- Format:
-- {
--     label = 'Button Label',
--     icon = 'fontawesome_icon',
--     scenario = 'SCENARIO_NAME',
--     offsetX = 0.0, offsetY = 0.0, offsetZ = 0.0, headingOffset = 0.0
-- }

Config.QuickAccess = {
    Chairs = {
        {
            label = 'Sit Down',
            icon = 'fas fa-chair',
            scenario = 'PROP_HUMAN_SEAT_CHAIR',
            offsetX = 0.0, offsetY = 0.0, offsetZ = 0.5, headingOffset = 180.0
        }
    },

    Benches = {
        {
            label = 'Sit on Bench',
            icon = 'fas fa-chair',
            scenario = 'PROP_HUMAN_SEAT_BENCH',
            offsetX = 0.0, offsetY = 0.0, offsetZ = 0.5, headingOffset = 180.0
        }
    },

    Beds = {
        {
            label = 'Sleep on Pillow',
            icon = 'fas fa-bed',
            scenario = 'PROP_HUMAN_SLEEP_BED_PILLOW',
            offsetX = 0.0, offsetY = 0.0, offsetZ = 0.5, headingOffset = 180.0
        }
    },

    Pianos = {
        {
            label = 'Play Piano',
            icon = 'fas fa-music',
            scenario = 'PROP_HUMAN_ABIGAIL_PIANO',
            offsetX = 0.0, offsetY = -0.70, offsetZ = 0.5, headingOffset = 0.0
        }
    },


}
