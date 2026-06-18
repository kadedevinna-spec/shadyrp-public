-------------------------------------------
-------- PROP OPTIONS CONFIGURATION -------
Config.BedsOptions = {
    ["shared"] = {
        objects = {'p_bed20madex', 'p_cs_bed20madex', 'p_cs_pro_bed_unmade'},
        left = {x = 0.3, y = -0.2, z = 0.5, heading = 180.0},
        right = {x = -0.3, y = -0.2, z = 0.5, heading = 180.0},
    },
    ["standart"] = {
        objects = {'p_bed14x', 'p_bed17x', 'p_bed21x', 'p_bedindian02x', 'p_cot01x'},
        x = 0.0, y = 0.0, z = 0.5, heading = 180.0
    },
    ["standart2"] = {
        objects = {'p_ambbed01x', 'p_bed03x', 'p_bed09x', 'p_bedindian01x'},
        x = 0.0, y = 0.0, z = 0.5, heading = 270.0
    },
    ["p_bed05x"] = {
        objects = {'p_bed05x'},
        x = 0.0, y = -0.5, z = 0.5, heading = 180.0
    },
    ["standart4"] = {
        objects = {'p_bed10x', 'p_bed12x', 'p_bed13x', 'p_bed22x'},
        x = 0.0, y = -0.3, z = 0.8, heading = 180.0
    },
    ["p_bed20x"] = {
        objects = {'p_bed20x'},
        left = {x = 0.3, y = -0.2, z = 0.8, heading = 180.0},
        right = {x = -0.3, y = -0.2, z = 0.8, heading = 180.0},
    },
    ["bunk"] = {
        objects = {'p_bedbunk03x'},
        up = {x = 0.0, y = 0.0, z = 1.68, heading = 180.0},
        down = {x = 0.0, y = 0.0, z = 0.50, heading = 180.0},
    },
    ["bedroll"] = {
        objects = {'p_bedrollopen01x', 'p_re_bedrollopen01x', 'p_mattress04x'},
        x = 0.0, y = 0.0, z = 0.0, heading = 180.0
    },
    ["p_bedking01x"] = {
        objects = {'p_bedking01x'},
        x = 0.0, y = 0.0, z = 0.7, heading = 180.0,
        left = {x = -0.5, y = 0.5, z = 0.85, heading = 180.0},
        right = {x = 0.5, y = 0.5, z = 0.85, heading = 180.0},
    },
    ["p_bedking02x"] = {
        objects = {'p_bedking02x'},
        x = 0.0, y = 0.0, z = 0.5, heading = 180.0,
        left = {x = -0.5, y = 0.5, z = 0.5, heading = 180.0},
        right = {x = 0.5, y = 0.5, z = 0.5, heading = 180.0},
    },
    ["p_cs_bedsleptinbed08x"] = {
        objects = {'p_cs_bedsleptinbed08x'},
        left = {x = 0.3, y = -0.3, z = 0.5, heading = 270.0},
        right = {x = 0.3, y = 0.3, z = 0.5, heading = 270.0},
    },
    ["bedroll"] = {
        objects = {'p_bedrollopen01x','p_bedrollopen03x','p_re_bedrollopen01x','s_bedrollfurlined01x','s_bedrollopen01x','p_amb_mattress04x','p_mattress04x','p_mattress07x','p_mattresscombined01x'},
        x = 0.0, y = 0.0, z = 0.0, heading = 180.0,
    },
    ["otherbeds"] = {
        objects = {'p_cs_ann_wrkr_bed01x','p_cs_roc_hse_bed'},
        x = 0.1, y = 0.0, z = 0.85, heading = 180.0,
    },
    ["p_medbed01x"] = {
        objects = {'p_medbed01x'},
        x = 0.0, y = -0.1, z = 0.80, heading = -90.0,
    },
}

Config.PianoOptions = {
    ["standart"] = {
        objects = {'p_piano03x', 'p_piano02x', 'p_nbxpiano01x', 'p_nbmpiano01x'},
        x = 0.0, y = -0.70, z = 0.5, heading = 0.0,
    },
    ["plus"] = {
        objects = {'sha_man_piano01', 'pipeorgan'},
        x = 0.0, y = -0.75, z = 0.5, heading = 0.0
    },
}

Config.ChairOptions = {
    ["chairbar"] = {
        objects = {'p_chairtall01x', 'p_chairrusticsav01x', 'sdchurchchair'},
        x = 0.0, y = 0.0, z = 0.8, heading = 180.0
    },
    ["barstool"] = {
        objects = {'p_barstool01x'},
        x = 0.0, y = 0.0, z = 0.8, heading = 0.0
    },
}

Config.BenchesOptions = {
    ["p_benchlong05x"] = {
        objects = {'p_benchlong05x'},
        left = {x = 1.25, y = 0.0, z = 0.5, heading = 180.0},
        right = {x = -0.5, y = 0.0, z = 0.5, heading = 180.0},
        middle = {x = 0.4, y = 0.0, z = 0.5, heading = 180.0},
    },
    ["sharedbench"] = {
        objects = {'p_bench17x', 'p_benchbear01x'},
        left = {x = 0.3, y = 0.0, z = 0.5, heading = 180.0},
        right = {x = -0.3, y = 0.0, z = 0.5, heading = 180.0},
    },
    ["sdchurchbench"] = {
        objects = {'sdchurchbench'},
        left = {x = 0.5, y = -0.3, z = -0.375, heading = 180.0},
        right = {x = -0.5, y = -0.3, z = -0.375, heading = 180.0},
    },
    ["p_shoeshinestand01x"] = {
        objects = {'p_shoeshinestand01x'},
        left = {x = 0.45, y = 0.25, z = 1.2, heading = 180.0},
        right = {x = -0.45, y = 0.25, z = 1.2, heading = 180.0},
    },
    ["p_victoriansofa01x"] = {
        objects = {'p_victoriansofa01x'},
        left = {x = 0.45, y = -0.06, z = 0.55, heading = 180.0},
        right = {x = -0.45, y = -0.06, z = 0.55, heading = 180.0},
    },
    ["p_bench_log06x"] = {
        objects = {'p_bench_log06x'},
        left = {x = 0.40, y = -0.06, z = 0.55, heading = 180.0},
        right = {x = -0.40, y = -0.06, z = 0.55, heading = 180.0},
    },
    ["p_bench18x"] = {
        objects = {'p_bench18x'},
        left = {x = 0.40, y = -0.03, z = 0.45, heading = 180.0},
        right = {x = -0.40, y = -0.03, z = 0.45, heading = 180.0},
    },
    ["p_couch10x"] = {
        objects = {'p_couch10x'},
        left = {x = 0.45, y = -0.25, z = 0.50, heading = 180.0},
        right = {x = -0.45, y = -0.25, z = 0.50, heading = 180.0},
    },
    ["churchbench1"] = {
        objects = {'churchbench1'},
        left = {x = 0.10, y = -0.10, z = -0.25, heading = 180.0},
        right = {x = -1.40, y = -0.10, z = -0.25, heading = 180.0},
        middle = {x = -0.60, y = -0.10, z = -0.25, heading = 180.0},
    },
    ["p_chairconvoround01x"] = {
        objects = {'p_chairconvoround01x'},
        left = {x = -0.55, y = 0.70, z = 0.5, heading = 38.0},
        right = {x = -0.65, y = -0.65, z = 0.5, heading = 135.0},
        middle = {x = 0.65, y = 0.65, z = 0.5, heading = -46.0},
    },
    ["p_bench03x"] = {
        objects = {'p_bench03x', 'p_bench06x', 'p_bench08bx', 'p_bench09x', 'p_bench11x', 'p_bench15_mjr', 'p_bench15x', 'p_bench16x', 'p_benchch01x', 's_bench01x', 'p_hallbench01x'},
        left = {x = 0.40, y = -0.03, z = 0.50, heading = 180.0},
        right = {x = -0.40, y = -0.03, z = 0.50, heading = 180.0},
    },
}

Config.BathingOptions = {
    ["p_bath02x"] = {
        objects = {'p_bath02x'},
        x = 0.0, y = 0.5, z = 1.0, heading = 180.0,
        effect = 'clean'
    },
    ["p_bath03x"] = {
        objects = {'p_bath03x'},
        x = -0.5, y = 0.0, z = 0.65, heading = 270.0,
        effect = 'clean'
    }
}

Config.BathingLocations = {
    {
        x = -317.01651, y = 761.86, z = 117.45099,
        heading = 100.278, effect = 'clean'
    },
    {
        x = 2629.4099, y = -1223.7757, z = 59.6699,
        heading = 2.896, effect = 'clean'
    },
    {
        x = -1812.46838, y = -373.23529, z = 166.64999,
        heading = 92.105, effect = 'clean'
    },
    {
        x = 2952.804199, y = 1335.031494, z = 44.496986,
        heading = 154.996, effect = 'clean'
    },
    {
        x = 1336.350, y = -1377.972, z = 84.345,
        heading = -96.693, effect = 'clean'
    },
    {
        x = -823.362, y = -1318.832, z = 43.679,
        heading = 92.793, effect = 'clean'
    },
}


-- https://icon-sets.iconify.design/
-- You can change the icons as you like from the site above.
Config.ChairScenarios = {
    [1]  = {name = "GENERIC_SEAT_BENCH_SCENARIO", label = Locale("chair_bench"), icon = "game-icons:wooden-chair"},
    [2]  = {name = "MP_LOBBY_PROP_HUMAN_SEAT_BENCH_PORCH_DRINKING", label = Locale("chair_beer"), icon = "game-icons:wooden-chair"},
    [3]  = {name = "MP_LOBBY_PROP_HUMAN_SEAT_BENCH_PORCH_SMOKING", label = Locale("chair_cigarette"), icon = "game-icons:wooden-chair"},
    [4]  = {name = "PROP_HUMAN_SEAT_CHAIR_LANGTON", label = Locale("chair_cigarette_2"), icon = "game-icons:wooden-chair", onlyMale = true},
    [5]  = {name = "MP_LOBBY_PROP_HUMAN_SEAT_CHAIR", label = Locale("chair_sit"), icon = "game-icons:wooden-chair"},
    [6]  = {name = "MP_LOBBY_PROP_HUMAN_SEAT_CHAIR_WHITTLE", label = Locale("chair_whittle"), icon = "game-icons:wooden-chair"},
    [7]  = {name = "PROP_CAMP_FIRE_SEAT_CHAIR", label = Locale("chair_campfire"), icon = "game-icons:wooden-chair"},
    [8]  = {name = "PROP_HUMAN_SEAT_BENCH_CONCERTINA", label = Locale("chair_concertina"), icon = "game-icons:wooden-chair", onlyMale = true},
    [9]  = {name = "PROP_HUMAN_SEAT_CHAIR_FAN", label = Locale("chair_fan"), icon = "game-icons:wooden-chair"},
    [10] = {name = "PROP_HUMAN_SEAT_BENCH_JAW_HARP", label = Locale("chair_jaw_harp"), icon = "game-icons:wooden-chair", onlyMale = true},
    [11] = {name = "PROP_HUMAN_SEAT_BENCH_MANDOLIN", label = Locale("chair_mandolin"), icon = "game-icons:wooden-chair", onlyMale = true},
    [12] = {name = "PROP_HUMAN_SEAT_CHAIR", label = Locale("chair_chair"), icon = "game-icons:wooden-chair"},
    [13] = {name = "PROP_HUMAN_SEAT_CHAIR_BANJO", label = Locale("chair_banjo"), icon = "game-icons:wooden-chair", onlyMale = true},
    [14] = {name = "PROP_HUMAN_SEAT_CHAIR_CIGAR", label = Locale("chair_cigar"), icon = "game-icons:wooden-chair", onlyMale = true},
    [15] = {name = "PROP_HUMAN_SEAT_CHAIR_GROOMING_GROSS", label = Locale("chair_sad"), icon = "game-icons:wooden-chair", onlyMale = true},
    [16] = {name = "PROP_HUMAN_SEAT_CHAIR_GROOMING_POSH", label = Locale("chair_filing_nails"), icon = "game-icons:wooden-chair"},
    [17] = {name = "PROP_HUMAN_SEAT_CHAIR_GUITAR", label = Locale("chair_guitar"), icon = "game-icons:wooden-chair", onlyMale = true},
    [18] = {name = "PROP_HUMAN_SEAT_CHAIR_KNIFE_BADASS", label = Locale("chair_knife"), icon = "game-icons:wooden-chair", onlyMale = true},
    [19] = {name = "PROP_HUMAN_SEAT_CHAIR_KNITTING", label = Locale("chair_knitting"), icon = "game-icons:wooden-chair"},
    [20] = {name = "PROP_HUMAN_SEAT_CHAIR_PORCH", label = Locale("chair_porch"), icon = "game-icons:wooden-chair"},
    [21] = {name = "PROP_HUMAN_SEAT_CHAIR_READING", label = Locale("chair_reading"), icon = "game-icons:wooden-chair", onlyFemale = true},
    [22] = {name = "PROP_HUMAN_SEAT_CHAIR_TABLE_DRINKING", label = Locale("chair_beer_2"), icon = "game-icons:wooden-chair"},
    [23] = {name = "PROP_HUMAN_SEAT_BENCH_HARMONICA", label = Locale("chair_harmonica"), icon = "game-icons:wooden-chair", onlyMale = true},
    [24] = {name = "PROP_HUMAN_SEAT_CHAIR_SMOKE_ROLL", label = Locale("chair_roll_cigarette"), icon = "game-icons:wooden-chair"},
    [25] = {name = "PROP_HUMAN_SEAT_CHAIR_FISHING_ROD", label = Locale("chair_fishing_rod"), icon = "game-icons:wooden-chair", onlyMale = true},
}

Config.BedScenarios = {
    {
        name = 'PROP_HUMAN_SLEEP_BED_PILLOW',
        icon = "fluent:bed-20-filled",
        label = Locale("prop_human_sleep_bed_pillow")
    },
    {
        name = 'PROP_HUMAN_SLEEP_BED_PILLOW_HIGH',
        onlyMale = true,
        icon = "fluent:bed-20-filled",
        label = Locale("prop_human_sleep_bed_pillow_high")
    },
    {
        name = 'WORLD_HUMAN_SLEEP_GROUND_ARM',
        icon = "fluent:bed-20-filled",
        label = Locale("world_human_sleep_ground_arm")
    },
    {
        name = 'WORLD_HUMAN_SLEEP_GROUND_PILLOW',
        icon = "fluent:bed-20-filled",
        label = Locale("world_human_sleep_ground_pillow")
    },
    {
        name = 'WORLD_HUMAN_SIT_FALL_ASLEEP',
        icon = "fluent:bed-20-filled",
        label = Locale("world_human_sit_fall_asleep")
    },
    {
        name = 'WORLD_PLAYER_SLEEP_BEDROLL',
        icon = "fluent:bed-20-filled",
        label = Locale("world_player_sleep_bedroll")
    },
    {
        name = 'WORLD_PLAYER_SLEEP_GROUND',
        icon = "fluent:bed-20-filled",
        label = Locale("world_player_sleep_ground")
    }
}

Config.PianoScenarios = {
    {
        name = 'PROP_HUMAN_PIANO',
        onlyMale = true,
        icon = "game-icons:grand-piano",
        label = Locale("prop_human_piano")
    },
    {
        name = 'PROP_HUMAN_PIANO_UPPERCLASS',
        onlyMale = true,
        icon = "game-icons:grand-piano",
        label = Locale("prop_human_piano_upperclass")
    },
    {
        name = 'PROP_HUMAN_PIANO_RIVERBOAT',
        onlyMale = true,
        icon = "game-icons:grand-piano",
        label = Locale("prop_human_piano_riverboat")
    },
    {
        name = 'PROP_HUMAN_PIANO_SKETCHY',
        onlyMale = true,
        icon = "game-icons:grand-piano",
        label = Locale("prop_human_piano_sketchy")
    },
    {
        name = 'PROP_HUMAN_ABIGAIL_PIANO',
        onlyFemale = true,
        icon = "game-icons:grand-piano",
        label = Locale("prop_human_abigail_piano")
    }
}

Config.BathingAnimations = {
    {
        label = Locale("bath"),
        icon = "fa:bath",
        dict = 'mini_games@bathing@regular@arthur',
        name = 'bathing_idle_02'
    },
    {
        label = Locale("bath_scrub_left_arm"),
        icon = "fa:bath",
        dict = 'mini_games@bathing@regular@arthur',
        name = 'left_arm_scrub_medium'
    },
    {
        label = Locale("bath_scrub_right_arm"),
        icon = "fa:bath",
        dict = 'mini_games@bathing@regular@arthur',
        name = 'right_arm_scrub_medium'
    },
    {
        label = Locale("bath_scrub_left_leg"),
        icon = "fa:bath",
        dict = 'mini_games@bathing@regular@arthur',
        name = 'left_leg_scrub_medium'
    },
    {
        label = Locale("bath_scrub_right_leg"),
        icon = "fa:bath",
        dict = 'mini_games@bathing@regular@arthur',
        name = 'right_leg_scrub_medium'
    }
}