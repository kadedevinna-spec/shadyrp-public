function IsPedChild(ped)
    return Citizen.InvokeNative(0x137772000DAF42C5, ped)
end

function IsPedAdult(ped)
    return IsPedHuman(ped) and not IsPedChild(ped)
end

function IsPedHumanMale(ped)
    return IsPedHuman(ped) and IsPedMale(ped)
end

function IsPedHumanFemale(ped)
    return IsPedHuman(ped) and not IsPedMale(ped)
end

function IsPedAdultMale(ped)
    return not IsPedChild(ped) and IsPedMale(ped)
end

function IsPedAdultFemale(ped)
    return not IsPedChild(ped) and not IsPedMale(ped)
end

GenericChairs = {
    'mp005_s_posse_col_chair01x',
    'mp005_s_posse_foldingchair_01x',
    'mp005_s_posse_trad_chair01x',
    'o_stoolfoldingstatic01x',
    'p_ambchair01x',
    'p_ambchair02x',
    'p_armchair01x',
    'p_bistrochair01x',
    'p_chair02x',
    'p_chair04x',
    'p_chair05x',
    'p_chair06x',
    'p_chair07x',
    'p_chair09x',
    'p_chair10x',
    'p_chair11x',
    'p_chair12bx',
    'p_chair12x',
    'p_chair13x',
    'p_chair14x',
    'p_chair15x',
    'p_chair16x',
    'p_chair17x',
    'p_chair18x',
    'p_chair19x',
    'p_chair20x',
    'p_chair21x',
    'p_chair21x_fussar',
    'p_chair22x',
    'p_chair23x',
    'p_chair24x',
    'p_chair25x',
    'p_chair26x',
    'p_chair27x',
    'p_chair30x',
    'p_chair31x',
    'p_chair37x',
    'p_chair38x',
    'p_chair_barrel04b',
    'p_chair_crate02x',
    'p_chair_crate15x',
    'p_chair_cs05x',
    'p_chairdesk01x',
    'p_chairdesk02x',
    'p_chairdining01x',
    'p_chairdining02x',
    'p_chairdining03x',
    'p_chaireagle01x',
    'p_chairfolding02x',
    'p_chairhob01x',
    'p_chairhob02x',
    'p_chairmed01x',
    'p_chairmed02x',
    'p_chairoffice02x',
    'p_chairpokerfancy01x',
    'p_chairporch01x',
    'p_chair_privatedining01x',
    'p_chairrocking02x',
    'p_chairrocking03x',
    'p_chairrocking04x',
    'p_chairrocking05x',
    'p_chairrocking06x',
    'p_chairrustic01x',
    'p_chairrustic02x',
    'p_chairrustic03x',
    'p_chairrustic04x',
    'p_chairrustic05x',
    'p_chairsalon01x',
    'p_chairvictorian01x',
    'p_chairwhite01x',
    'p_chairwicker01x',
    'p_chairwicker02x',
    'p_chaircomfy01x',
    'p_chaircomfy02',
    'p_chaircomfy03x',
    'p_chaircomfy04x',
    'p_chaircomfy05x',
    'p_chaircomfy06x',
    'p_chaircomfy07x',
    'p_chaircomfy08x',
    'p_chaircomfy09x',
    'p_chaircomfy10x',
    'p_chaircomfy11x',
    'p_chaircomfy12x',
    'p_chaircomfy14x',
    'p_chaircomfy17x',
    'p_chaircomfy18x',
    'p_chaircomfy22x',
    'p_chaircomfy23x',
    'p_chairdoctor01x',
    'p_cs_electricchair01x',
    'p_diningchairs01x',
    'p_gen_chair07x',
    'p_oldarmchair01x',
    'p_privatelounge_chair01x',
    'p_rockingchair01x',
    'p_rockingchair02x',
    'p_rockingchair03x',
    'p_settee01x',
    'p_settee02bx',
    'p_settee03x',
    'p_settee03bx',
    'p_settee04x',
    'p_sit_chairwicker01b',
    'p_stool01x',
    'p_stool02x',
    'p_stool03x',
    'p_stool04x',
    'p_stool05x',
    'p_stool07x',
    'p_stool08x',
    'p_stool09x',
    'p_stool10x',
    'p_stool12x',
    'p_stool13x',
    'p_stool14x',
    'p_stoolcomfy01x',
    'p_stoolcomfy02x',
    'p_stoolfolding01bx',
    'p_stoolfolding01x',
    'p_stoolwinter01x',
    'p_theaterchair01b01x',
    'p_windsorchair01x',
    'p_windsorchair02x',
    'p_windsorchair03x',
    'p_woodenchair01x',
    'p_woodendeskchair01x',
}

GenericBenches = {
    'p_bench03x',
    'p_bench06x',
    'p_bench08bx',
    'p_bench09x',
    'p_bench15_mjr',
    'p_bench15x',
    'p_bench16x',
    'p_bench18x',
    'p_bench20x',
    'p_benchch01x',
    'p_benchironnbx01x',
    'p_benchironnbx02x',
    'p_bench_log01x',
    'p_bench_log02x',
    'p_bench_log03x',
    'p_bench_log04x',
    'p_bench_log05x',
    'p_bench_log06x',
    'p_bench_log07x',
    'p_bench_logsnow07x',
    'p_benchnbx02x',
    'p_benchnbx03x',
    'p_couch01x',
    'p_couch02x',
    'p_couch05x',
    'p_couch06x',
    'p_couch08x',
    'p_couch09x',
    'p_couch10x',
    'p_couch11x',
    'p_couchwicker01x',
    'p_hallbench01x',
    'p_loveseat01x',
    'p_seatbench01x',
    'p_settee02x',
    'p_settee_05x',
    'p_sit_chairwicker01a',
    'p_sofa01x',
    'p_sofa02x',
    'p_windsorbench01x',
    'p_woodbench02x',
    's_bench01x',
}

GenericChairAndBenchScenarios = {
    {
        name = 'GENERIC_SEAT_BENCH_SCENARIO',
        label = 'Sit normally'
    },
    {
        name = 'MP_LOBBY_PROP_HUMAN_SEAT_BENCH_PORCH_DRINKING',
        label = 'Sit & Drink'
    },
    {
        name = 'MP_LOBBY_PROP_HUMAN_SEAT_BENCH_PORCH_SMOKING',
        label = 'Sit & Smoke'
    },
    {
        name = 'PROP_HUMAN_SEAT_CHAIR_LANGTON',
        isCompatible = IsPedHumanMale,
        label = 'Sit properly'
    },
    {
        name = 'MP_LOBBY_PROP_HUMAN_SEAT_CHAIR',
        label = 'Lounge'
    },
    {
        name = 'MP_LOBBY_PROP_HUMAN_SEAT_CHAIR_WHITTLE',
        label = 'Sit & Whittle'
    },
    {
        name = 'PROP_CAMP_FIRE_SEAT_CHAIR',
        label = 'Warm up'
    },
    {
        name = 'PROP_HUMAN_SEAT_BENCH_CONCERTINA',
        isCompatible = IsPedHumanMale,
        label = 'Play Concertina'
    },
    {
        name = 'PROP_HUMAN_SEAT_CHAIR_FAN',
        isCompatible = IsPedHumanFemale,
        label = 'Sit with Fan'
    },
    {
        name = 'PROP_HUMAN_SEAT_BENCH_JAW_HARP',
        isCompatible = IsPedHumanMale,
        label = 'Play Jaw Harp'
    },
    {
        name = 'PROP_HUMAN_SEAT_BENCH_MANDOLIN',
        isCompatible = IsPedHumanMale,
        label = 'Play Mandolin'
    },
    {
        name = 'PROP_HUMAN_SEAT_CHAIR',
        label = 'Sit'
    },
    {
        name = 'PROP_HUMAN_SEAT_CHAIR_BANJO',
        isCompatible = IsPedHumanMale,
        label = 'Play Banjo'
    },
    {
        name = 'PROP_HUMAN_SEAT_CHAIR_CIGAR',
        isCompatible = IsPedHumanMale,
        label = 'Smoke Cigar'
    },
    {
        name = 'PROP_HUMAN_SEAT_CHAIR_GROOMING_GROSS',
        isCompatible = IsPedHumanMale,
        label = 'Grooming'
    },
    {
        name = 'PROP_HUMAN_SEAT_CHAIR_GROOMING_POSH',
        isCompatible = IsPedHumanFemale,
        label = 'Posh Grooming'
    },
    {
        name = 'PROP_HUMAN_SEAT_CHAIR_GUITAR',
        isCompatible = IsPedHumanMale,
        label = 'Play Guitar'
    },
    {
        name = 'PROP_HUMAN_SEAT_CHAIR_KNIFE_BADASS',
        isCompatible = IsPedHumanMale,
        label = 'Sharpen Knife'
    },
    {
        name = 'PROP_HUMAN_SEAT_CHAIR_KNITTING',
        isCompatible = IsPedHumanFemale,
        label = 'Knitting'
    },
    {
        name = 'PROP_HUMAN_SEAT_CHAIR_PORCH',
        label = 'Porch Sitting'
    },
    {
        name = 'PROP_HUMAN_SEAT_CHAIR_READING',
        isCompatible = IsPedHumanFemale,
        label = 'Reading'
    },
    {
        name = 'PROP_HUMAN_SEAT_CHAIR_TABLE_DRINKING',
        label = 'Drink at Table'
    },
    {
        name = 'PROP_HUMAN_SEAT_BENCH_HARMONICA',
        label = 'Play Harmonica'
    },
    {
        name = 'PROP_HUMAN_SEAT_CHAIR_SMOKE_ROLL',
        label = 'Roll & Smoke'
    },
    {
        name = 'PROP_HUMAN_SEAT_CHAIR_FISHING_ROD',
        isCompatible = IsPedHumanMale,
        label = 'Sit & Fish'
    },
}

BedScenarios = {
    {
        name = 'PROP_HUMAN_SLEEP_BED_PILLOW',
        label = 'Side'
    },
    {
        name = 'PROP_HUMAN_SLEEP_BED_PILLOW_HIGH',
        isCompatible = IsPedHumanMale,
        label = 'Back'
    },
    {
        name = 'WORLD_HUMAN_SLEEP_GROUND_ARM',
        label = 'Stomach'
    },
    {
        name = 'WORLD_HUMAN_SLEEP_GROUND_PILLOW',
        label = 'Crossed legs'
    },
    {
        name = 'WORLD_HUMAN_SIT_FALL_ASLEEP',
        label = 'Squat'
    },
    {
        name = 'WORLD_PLAYER_SLEEP_BEDROLL',
        label = 'Snore'
    },
    {
        name = 'WORLD_PLAYER_SLEEP_GROUND',
        label = 'Ground Sleep'
    }
}

PianoScenarios = {
    {
        name = 'PROP_HUMAN_PIANO',
        isCompatible = IsPedHumanMale,
        label = 'Play Piano'
    },
    {
        name = 'PROP_HUMAN_PIANO_UPPERCLASS',
        isCompatible = IsPedHumanMale,
        label = 'Elegant Piano'
    },
    {
        name = 'PROP_HUMAN_PIANO_RIVERBOAT',
        isCompatible = IsPedHumanMale,
        label = 'Riverboat Piano'
    },
    {
        name = 'PROP_HUMAN_PIANO_SKETCHY',
        isCompatible = IsPedHumanMale,
        label = 'Sketchy Piano'
    },
    {
        name = 'PROP_HUMAN_ABIGAIL_PIANO',
        isCompatible = IsPedHumanFemale,
        label = 'Soft Piano'
    }
}

BathingAnimations = {
    {
        label = 'Bathe',
        dict = 'mini_games@bathing@regular@arthur',
        name = 'bathing_idle_02'
    },
    {
        label = 'Scrub Left Arm',
        dict = 'mini_games@bathing@regular@arthur',
        name = 'left_arm_scrub_medium'
    },
    {
        label = 'Scrub Right Arm',
        dict = 'mini_games@bathing@regular@arthur',
        name = 'right_arm_scrub_medium'
    },
    {
        label = 'Scrub Left Leg',
        dict = 'mini_games@bathing@regular@arthur',
        name = 'left_leg_scrub_medium'
    },
    {
        label = 'Scrub Right Leg',
        dict = 'mini_games@bathing@regular@arthur',
        name = 'right_leg_scrub_medium'
    }
}


DancingAnimations = {
    {
        label = 'Sword Dance',
        dict = 'script_shows@sworddance@act3_p1',
        name = 'dancer_sworddance'
    },
    {
        label = 'Can Can',
        dict = 'script_shows@cancandance@p2',
        name = 'cancandance_p2_fem1'
    },
    {
        label = 'Fire Dance',
        dict = 'script_shows@firebreather@act2_p1',
        name = 'dancer_dance'
    },
    {
        label = 'Snake Dance',
        dict = 'script_shows@snakedancer@act1_p1',
        name = 'dance_dancer'
    },
}
