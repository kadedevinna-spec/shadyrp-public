-- RedM compatibility: protected BTC code may call this FiveM-style Network wrapper.
Network = Network or {}

if not Network.SetNetworkIdCanMigrate then
    Network.SetNetworkIdCanMigrate = function(netId, canMigrate)
        if type(SetNetworkIdCanMigrate) == "function" then
            return SetNetworkIdCanMigrate(netId, canMigrate)
        end

        -- Some RedM builds do not expose this native by name; migration is optional here.
        return true
    end
end

local locale = Locale[Config.Locale]

Config.EncryptedAnimals = {
    -- Exemplo de um animal "especial"
    Cattle = {
        Female = {
            Label = locale[241],
            Spawn = {
                Model = 'a_c_cow',
                Outfits = {
                    [0] = locale[202],
                    [1] = locale[202],
                    [2] = locale[202],
                    [3] = locale[202],
                    [4] = locale[203],
                    [5] = locale[202],
                    [6] = locale[204],
                    [7] = locale[205],
                    [8] = locale[205],
                    [9] = locale[205],
                    [10] = locale[204],
                    [11] = locale[205],
                    [12] = locale[204],
                    [13] = locale[205],
                    [14] = locale[206],
                    [15] = locale[207],
                    [16] = locale[208],
                    [17] = locale[205],
                    [18] = locale[204],
                    [19] = locale[203],
                    [20] = locale[209],
                    [21] = locale[209],
                }
            },
        },
        Male = {
            Label = locale[240],
            Spawn = {
                Model = 'a_c_ox_01',
                Outfits = {
                    [0] = locale[210],
                    [1] = locale[211]
                }
            },
        },
    },

    Swine = {
        Female = {
            Label = locale[239],
            Spawn = {
                Model = 'a_c_pig_01',
                Outfits = {
                    [0] = locale[212],
                    [1] = locale[213],
                    [2] = locale[214],
                }
            },
        },
        Male = {
            Label = locale[238],
            Spawn = {
                Model = 'a_c_pig_01',
                Outfits = {
                    [0] = locale[212],
                    [1] = locale[213],
                    [2] = locale[214],
                }
            },
        },
    },

    Poultry = {
        Female = {
            Label = locale[237],
            Spawn = {
                Model = 'a_c_chicken_01',
                Outfits = {
                    [0] = locale[215],
                    [1] = locale[216],
                    [2] = locale[217],
                }
            },
        },
        Male = {
            Label = locale[236],
            Spawn = {
                Model = 'a_c_rooster_01',
                Outfits = {
                    [0] = locale[218],
                    [1] = locale[219],
                    [2] = locale[220],
                }
            },
        },
    },

    Sheep = {
        Female = {
            Label = locale[235],
            Spawn = {
                Model = 'a_c_sheep_01',
                Outfits = {
                    [0] = locale[221],
                    [1] = locale[221],
                    [2] = locale[222],
                    [3] = locale[222],
                    [4] = locale[223],
                    [5] = locale[223],
                    [6] = locale[224],
                    [7] = locale[224],
                    [8] = locale[225],
                    [9] = locale[225],
                    [10] = locale[225],
                }
            },
        },
        Male = {
            Label =  locale[234],
            Spawn = {
                Model = 'mp_a_c_bighornram_01',
                Outfits = {
                    [0] = locale[225],
                    [1] = locale[226],
                    [2] = locale[227],
                    [3] = locale[228],
                    [4] = locale[228],
                }
            },
        },
    },

    Goats = {
        Female = {
            Label = locale[233],
            Spawn = {
                Model = 'a_c_goat_01',
                Outfits = {
                    [0] =  locale[229],
                    [1] =  locale[230],
                    [2] =  locale[231],
                }
            },
        },
        Male = {
            Label = locale[232],
            Spawn = {
                Model = 'a_c_goat_01',
                Outfits = {
                    [0] =  locale[229],
                    [1] =  locale[230],
                    [2] =  locale[231],
                }
            },
        },
    },
    -- ── Equinos ───────────────────────────────────────────────────────────
    -- Horse[subtype]: Horse usa Breeds[breedKey].Coats[coatKey].model
    -- Donkey: modelo único.  Mule: Coats com dois modelos.
    -- Nomes de pelagem obtidos via GetHorseCoat(joaat(model)) + GetLabelText_2() no client.
    Horse = {
        Subtypes = { 'Horse', 'Donkey', 'Mule' },
        Horse = {
            Breeds = {
                mangy = {
                    label = 'Pangaré Desnutrido',
                    Coats = {
                        mangy = { model = 'A_C_Horse_MP_Mangy_Backup' },
                    },
                },
                kentucky_saddler = {
                    label = 'Kentucky Saddler',
                    Coats = {
                        black              = { model = 'A_C_Horse_KentuckySaddle_Black' },
                        buttermilk_buckskin= { model = 'A_C_Horse_KentuckySaddle_ButterMilkBuckskin_PC' },
                        chestnut_pinto     = { model = 'A_C_Horse_KentuckySaddle_ChestnutPinto' },
                        grey               = { model = 'A_C_Horse_KentuckySaddle_Grey' },
                        silver_bay         = { model = 'A_C_Horse_KentuckySaddle_SilverBay' },
                        gang_uncle         = { model = 'a_c_horse_gang_uncle' },
                    },
                },
                morgan = {
                    label = 'Morgan',
                    Coats = {
                        bay             = { model = 'A_C_Horse_Morgan_Bay' },
                        bay_roan        = { model = 'A_C_Horse_Morgan_BayRoan' },
                        flaxen_chestnut = { model = 'A_C_Horse_Morgan_FlaxenChestnut' },
                        liver_chestnut  = { model = 'A_C_Horse_Morgan_LiverChestnut_PC' },
                        palomino        = { model = 'A_C_Horse_Morgan_Palomino' },
                    },
                },
                tennessee_walker = {
                    label = 'Tennessee Walker',
                    Coats = {
                        black_rabicano  = { model = 'A_C_Horse_TennesseeWalker_BlackRabicano' },
                        chestnut        = { model = 'A_C_Horse_TennesseeWalker_Chestnut' },
                        dapple_bay      = { model = 'A_C_Horse_TennesseeWalker_DappleBay' },
                        flaxen_roan     = { model = 'A_C_Horse_TennesseeWalker_FlaxenRoan' },
                        mahogany_bay    = { model = 'A_C_Horse_TennesseeWalker_MahoganyBay' },
                        red_roan        = { model = 'A_C_Horse_TennesseeWalker_RedRoan' },
                        gold_palomino   = { model = 'A_C_Horse_TennesseeWalker_GoldPalomino_PC' },
                    },
                },
                suffolk_punch = {
                    label = 'Suffolk Punch',
                    Coats = {
                        red_chestnut = { model = 'A_C_Horse_SuffolkPunch_RedChestnut' },
                        sorrel       = { model = 'A_C_Horse_SuffolkPunch_Sorrel' },
                    },
                },
                belgian = {
                    label = 'Belga',
                    Coats = {
                        blond_chestnut = { model = 'A_C_Horse_Belgian_BlondChestnut' },
                        mealy_chestnut = { model = 'A_C_Horse_Belgian_MealyChestnut' },
                    },
                },
                shire = {
                    label = 'Shire',
                    Coats = {
                        dark_bay   = { model = 'A_C_Horse_Shire_DarkBay' },
                        light_grey = { model = 'A_C_Horse_Shire_LightGrey' },
                        raven_black= { model = 'A_C_Horse_Shire_RavenBlack' },
                    },
                },
                nokota = {
                    label = 'Nakota',
                    Coats = {
                        blue_roan          = { model = 'A_C_Horse_Nokota_BlueRoan' },
                        reverse_dapple_roan= { model = 'A_C_Horse_Nokota_ReverseDappleRoan' },
                        white_roan         = { model = 'A_C_Horse_Nokota_WhiteRoan' },
                        gang_charles_es    = { model = 'a_c_horse_gang_charles_endlesssummer' },
                        gang_karen         = { model = 'a_c_horse_gang_karen' },
                    },
                },
                thoroughbred = {
                    label = 'Puro-Sangue Inglês',
                    Coats = {
                        black_chestnut      = { model = 'A_C_Horse_Thoroughbred_BlackChestnut' },
                        blood_bay           = { model = 'A_C_Horse_Thoroughbred_BloodBay' },
                        brindle             = { model = 'A_C_Horse_Thoroughbred_Brindle' },
                        dapple_grey         = { model = 'A_C_Horse_Thoroughbred_DappleGrey' },
                        reverse_dapple_black= { model = 'A_C_Horse_Thoroughbred_ReverseDappleBlack' },
                    },
                },
                american_standardbred = {
                    label = 'Standardbred Americano',
                    Coats = {
                        black              = { model = 'A_C_Horse_AmericanStandardbred_Black' },
                        buckskin           = { model = 'A_C_Horse_AmericanStandardbred_Buckskin' },
                        palomino_dapple    = { model = 'A_C_Horse_AmericanStandardbred_PalominoDapple' },
                        silver_tail_buckskin={ model = 'A_C_Horse_AmericanStandardbred_SilverTailBuckskin' },
                    },
                },
                ardennes = {
                    label = 'Ardennes',
                    Coats = {
                        bay_roan       = { model = 'A_C_Horse_Ardennes_BayRoan' },
                        iron_grey_roan = { model = 'A_C_Horse_Ardennes_IronGreyRoan' },
                        strawberry_roan= { model = 'A_C_Horse_Ardennes_StrawberryRoan' },
                        gang_bill      = { model = 'a_c_horse_gang_bill' },
                    },
                },
                hungarian_halfbred = {
                    label = 'Mentiço Húngaro',
                    Coats = {
                        dark_dapple_grey= { model = 'A_C_Horse_HungarianHalfbred_DarkDappleGrey' },
                        flaxen_chestnut = { model = 'A_C_Horse_HungarianHalfbred_FlaxenChestnut' },
                        liver_chestnut  = { model = 'A_C_Horse_HungarianHalfbred_LiverChestnut' },
                        piebald_tobiano = { model = 'A_C_Horse_HungarianHalfbred_PiebaldTobiano' },
                        gang_john       = { model = 'a_c_horse_gang_john' },
                    },
                },
                andalusian = {
                    label = 'Andaluz',
                    Coats = {
                        dark_bay  = { model = 'A_C_Horse_Andalusian_DarkBay' },
                        perlino   = { model = 'A_C_Horse_Andalusian_Perlino' },
                        rose_gray = { model = 'A_C_Horse_Andalusian_RoseGray' },
                    },
                },
                dutch_warmblood = {
                    label = 'Warmblood Holandês',
                    Coats = {
                        chocolate_roan = { model = 'A_C_Horse_DutchWarmblood_ChocolateRoan' },
                        seal_brown     = { model = 'A_C_Horse_DutchWarmblood_SealBrown' },
                        sooty_buckskin = { model = 'A_C_Horse_DutchWarmblood_SootyBuckskin' },
                        gang_buell     = { model = 'a_c_horse_buell_warvets' },
                    },
                },
                appaloosa = {
                    label = 'Appaloosa',
                    Coats = {
                        black_snowflake   = { model = 'A_C_Horse_Appaloosa_BlackSnowflake' },
                        blanket           = { model = 'A_C_Horse_Appaloosa_Blanket' },
                        brown_leopard     = { model = 'A_C_Horse_Appaloosa_BrownLeopard' },
                        few_spotted       = { model = 'A_C_Horse_Appaloosa_FewSpotted_PC' },
                        leopard           = { model = 'A_C_Horse_Appaloosa_Leopard' },
                        leopard_blanket   = { model = 'A_C_Horse_Appaloosa_LeopardBlanket' },
                        gang_charles      = { model = 'a_c_horse_gang_charles' },
                        gang_uncle_es     = { model = 'a_c_horse_gang_uncle_endlesssummer' },
                    },
                },
                american_paint = {
                    label = 'Paint Horse Americano',
                    Coats = {
                        greyovero     = { model = 'A_C_Horse_AmericanPaint_Greyovero' },
                        overo         = { model = 'A_C_Horse_AmericanPaint_Overo' },
                        splashed_white= { model = 'A_C_Horse_AmericanPaint_SplashedWhite' },
                        tobiano       = { model = 'A_C_Horse_AmericanPaint_Tobiano' },
                        gang_eagleflies={ model = 'a_c_horse_eagleflies' },
                    },
                },
                missouri_fox_trotter = {
                    label = 'Missouri Fox Trotter',
                    Coats = {
                        amber_champagne  = { model = 'A_C_Horse_MissouriFoxTrotter_AmberChampagne' },
                        sable_champagne  = { model = 'A_C_Horse_MissouriFoxTrotter_SableChampagne' },
                        silver_dapple    = { model = 'A_C_Horse_MissouriFoxTrotter_SilverDapplePinto' },
                        blue_roan        = { model = 'a_c_horse_missourifoxtrotter_blueroan' },
                        buckskin_brindle = { model = 'a_c_horse_missourifoxtrotter_buckskinbrindle' },
                        dapple_grey      = { model = 'a_c_horse_missourifoxtrotter_dapplegrey' },
                        gang_micah       = { model = 'a_c_horse_gang_micah' },
                    },
                },
                mustang = {
                    label = 'Mustangue',
                    Coats = {
                        golden_dun      = { model = 'A_C_Horse_Mustang_GoldenDun' },
                        grullo_dun      = { model = 'A_C_Horse_Mustang_GrulloDun' },
                        tiger_striped   = { model = 'A_C_Horse_Mustang_TigerStripedBay' },
                        wild_bay        = { model = 'A_C_Horse_Mustang_WildBay' },
                        buckskin        = { model = 'a_c_horse_mustang_buckskin' },
                        chestnut_tovero = { model = 'a_c_horse_mustang_chestnuttovero' },
                        red_dun_overo   = { model = 'a_c_horse_mustang_reddunovero' },
                        gang_lenny      = { model = 'a_c_horse_gang_lenny' },
                        gang_sadie_es   = { model = 'a_c_horse_gang_sadie_endlesssummer' },
                    },
                },
                turkoman = {
                    label = 'Turcomeno',
                    Coats = {
                        dark_bay  = { model = 'A_C_Horse_Turkoman_DarkBay' },
                        gold      = { model = 'A_C_Horse_Turkoman_Gold' },
                        silver    = { model = 'A_C_Horse_Turkoman_Silver' },
                        chestnut  = { model = 'a_c_horse_turkoman_chestnut' },
                        grey      = { model = 'a_c_horse_turkoman_grey' },
                        perlino   = { model = 'a_c_horse_turkoman_perlino' },
                        gang_sadie= { model = 'a_c_horse_gang_sadie' },
                    },
                },
                breton = {
                    label = 'Bretão',
                    Coats = {
                        steel_grey      = { model = 'A_C_Horse_Breton_SteelGrey' },
                        mealy_dapple_bay= { model = 'A_C_Horse_Breton_MealyDappleBay' },
                        seal_brown      = { model = 'A_C_Horse_Breton_SealBrown' },
                        grullo_dun      = { model = 'A_C_Horse_Breton_GrulloDun' },
                        sorrel          = { model = 'A_C_Horse_Breton_Sorrel' },
                        red_roan        = { model = 'A_C_Horse_Breton_RedRoan' },
                    },
                },
                criollo = {
                    label = 'Crioulo',
                    Coats = {
                        dun             = { model = 'A_C_Horse_Criollo_Dun' },
                        marble_sabino   = { model = 'A_C_Horse_Criollo_MarbleSabino' },
                        bay_frame_overo = { model = 'A_C_Horse_Criollo_BayFrameOvero' },
                        bay_brindle     = { model = 'A_C_Horse_Criollo_BayBrindle' },
                        sorrel_overo    = { model = 'A_C_Horse_Criollo_SorrelOvero' },
                        blue_roan_overo = { model = 'A_C_Horse_Criollo_BlueRoanOvero' },
                    },
                },
                kladruber = {
                    label = 'Kladruber',
                    Coats = {
                        black           = { model = 'A_C_Horse_Kladruber_Black' },
                        silver          = { model = 'A_C_Horse_Kladruber_Silver' },
                        cremello        = { model = 'A_C_Horse_Kladruber_Cremello' },
                        grey            = { model = 'A_C_Horse_Kladruber_Grey' },
                        dapple_rose_grey= { model = 'A_C_Horse_Kladruber_DappleRoseGrey' },
                        white           = { model = 'A_C_Horse_Kladruber_White' },
                    },
                },
                norfolk_roadster = {
                    label = 'Norfolk Roadster',
                    Coats = {
                        black            = { model = 'A_C_HORSE_NORFOLKROADSTER_BLACK' },
                        speckled_grey    = { model = 'A_C_HORSE_NORFOLKROADSTER_SPECKLEDGREY' },
                        piebald_roan     = { model = 'A_C_HORSE_NORFOLKROADSTER_PIEBALDROAN' },
                        rose_grey        = { model = 'A_C_HORSE_NORFOLKROADSTER_ROSEGREY' },
                        dappled_buckskin = { model = 'A_C_HORSE_NORFOLKROADSTER_DAPPLEDBUCKSKIN' },
                        spotted_tricolor = { model = 'A_C_HORSE_NORFOLKROADSTER_SPOTTEDTRICOLOR' },
                    },
                },
                gypsy_cob = {
                    label = 'Gypsy Cob',
                    Coats = {
                        piebald         = { model = 'a_c_horse_gypsycob_piebald' },
                        skewbald        = { model = 'a_c_horse_gypsycob_skewbald' },
                        splashed_bay    = { model = 'a_c_horse_gypsycob_splashedbay' },
                        splashed_piebald= { model = 'a_c_horse_gypsycob_splashedpiebald' },
                        white_blagdon   = { model = 'a_c_horse_gypsycob_whiteblagdon' },
                    },
                },
                arabian = {
                    label = 'Puro-Sangue Árabe',
                    Coats = {
                        black           = { model = 'A_C_Horse_Arabian_Black' },
                        grey            = { model = 'A_C_Horse_Arabian_Grey' },
                        red_chestnut    = { model = 'A_C_Horse_Arabian_RedChestnut' },
                        red_chestnut_pc = { model = 'a_c_horse_arabian_redchestnut_pc' },
                        rose_grey_bay   = { model = 'A_C_Horse_Arabian_RoseGreyBay' },
                        warped_brindle  = { model = 'A_C_Horse_Arabian_WarpedBrindle_PC' },
                        white           = { model = 'A_C_Horse_Arabian_White' },
                        gang_dutch      = { model = 'a_c_horse_gang_dutch' },
                    },
                },
            },
        },
        Donkey = {
            label = 'Burro',
            model = 'A_C_Donkey_01',
        },
        Mule = {
            label = 'Mula',
            Coats = {
                standard = { model = 'A_C_HorseMule_01' },
                painted  = { model = 'A_C_HorseMulePainted_01' },
            },
        },
    },
    -- Você pode adicionar outros animais especiais aqui
}

Config.StaggerBatchSize = 20
Config.StaggerWaitTime = 50
