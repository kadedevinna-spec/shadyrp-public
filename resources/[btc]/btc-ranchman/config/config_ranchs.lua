Config.MaxRanchesPerPlayer     = 1               -- maximum ranches a single player can own
Config.NotAllowTransferRanch   = false           -- if true, players cannot transfer ranch ownership to others
Config.ShowBlipEveryone        = true            -- if true, ranch blips are visible to all players; if false, only owners and employees
Config.ShowBlipEveryoneCommand = 'ranchBlips'    -- command name that temporarily shows all ranch blips to the caller (30 seconds). Set to false to make blips of ranches available for purchase ALWAYS visible without any command (requires Config.ShowBlipEveryone = true)
Config.ShowPurchasedRanchBlips = false           -- if true, ranches already purchased/active show a PERMANENT blip on the map for ALL players. Ranches still available for purchase appear only via Config.ShowBlipEveryoneCommand
Config.AllowLeaveRanch         = true            -- if true, players can leave a ranch from the management menu
Config.ShowWebhookButton       = true            -- if true, senior employees (grade ≥ 3) can view and update the ranch Discord webhook
Config.RanchBlip               = 'blip_predator' -- map blip hash for ranches

Config.Npc                     = {
    Model = 'a_m_m_nbxlaborers_01',
    Outfit = 10,
}

Config.Stash                   = {
    weight = 100,  -- maximum stash weight (RSG framework only)
    slots  = 3000, -- maximum stash item slots (RSG framework only)
}

Config.Ranchs                  = {
    [1] = {                                                    -- Ranch ID
        RanchName       = 'Dakota Ranch',                      -- Ranch Name if you want to use in prompt
        Job             = false,                               -- Or false 1.5.1
        JobOwnerGrade   = 3,                                   -- Job Owner Grade/Max Job Grade 1.5.1
        RanchPriceMoney = 1000,                                -- Or false to only use Ranch Document item
        RanchPriceGold  = 1000,                                -- Or false to only use Ranch Document item
        TaxAmount       = 500,                                 -- Tax amount per cycle (overrides Config.TaxAmount)
        MenuLocation    = vec4(-626.34, -60.96, 82.86, 65.55), -- Menu and NPC Location
        MaxAnimals      = 50,                                  -- Maximum animals in this ranch (only works if Config.MaxAnimalsToAll = false)
        Stash           = {
            weight = 1000,                                     -- maximum stash weight (RSG framework only)
            slots  = 300,                                      -- maximum stash item slots (RSG framework only)
        },
        Animals         = {
            Cattle  = {
                Menu = vec4(-621.87, -12.01, 86.65, 129.04), -- local prompt/store for this type
                Area = {
                    vec3(-623.5660, -7.5109, 86.6557),
                    vec3(-611.6179, -0.5142, 86.8202),
                    vec3(-605.7495, -11.0128, 86.6439),
                    vec3(-617.7772, -17.4185, 86.2398),
                    vec3(-619.5181, -14.1118, 86.4681),
                }, -- pasture polygon
            },
            Poultry = {
                Menu = vec4(-623.10, -24.42, 85.94, 55.85), -- local prompt/store
                Prop = true,                                -- if false dont have a CoopChoop Prop
                Area = {
                    vec3(-622.3358, -25.0399, 85.8219),
                    vec3(-618.0439, -22.4630, 85.7056),
                    vec3(-618.4145, -18.7969, 86.0599),
                    vec3(-620.5837, -17.2788, 86.2858),
                    vec3(-624.9540, -19.4229, 86.3058),
                    vec3(-626.6946, -22.8560, 86.0947),
                    vec3(-625.1841, -25.2897, 85.9551),
                },
            },
        },
    },
    [2] = {                                                     -- Ranch ID
        RanchName       = 'Cumberland Falls Ranch',             -- Ranch Name if you want to use in prompt
        Job             = false,                                -- Or false 1.5.1
        JobOwnerGrade   = 3,                                    -- Job Owner Grade/Max Job Grade 1.5.1
        RanchPriceMoney = 1000,                                 -- Or false to only use Ranch Document item
        RanchPriceGold  = 1000,                                 -- Or false to only use Ranch Document item
        TaxAmount       = 500,                                  -- Tax amount per cycle (overrides Config.TaxAmount)
        MenuLocation    = vec4(-861.71, 331.82, 96.41, 308.78), -- Menu and NPC Location
        MaxAnimals      = 50,                                   -- Maximum animals in this ranch (only works if Config.MaxAnimalsToAll = false)
        Stash           = {
            weight = 1000,                                      -- maximum stash weight (RSG framework only)
            slots  = 300,                                       -- maximum stash item slots (RSG framework only)
        },
        Animals         = {
            Cattle  = {
                Menu = vec4(-853.66, 350.88, 97.02, 268.74), -- local prompt/store for this type
                Area = {
                    vec3(-855.9928, 345.0074, 96.5231),
                    vec3(-858.3864, 344.9861, 96.4635),
                    vec3(-861.0724, 344.9465, 96.4455),
                    vec3(-864.2271, 345.7341, 96.4636),
                    vec3(-865.3341, 345.8386, 96.4553),
                    vec3(-865.4941, 344.2475, 96.4409),
                    vec3(-867.5137, 332.1000, 96.3716),
                    vec3(-870.3345, 316.7109, 96.1837),
                    vec3(-875.1487, 317.5231, 96.2576),
                    vec3(-881.3425, 318.8994, 96.1598),
                    vec3(-886.1192, 320.6652, 96.0852),
                    vec3(-888.7747, 323.2393, 96.1572),
                    vec3(-889.6578, 326.6710, 96.3033),
                    vec3(-888.7104, 331.3030, 96.3033),
                    vec3(-885.1976, 339.6100, 96.0266),
                    vec3(-882.7874, 343.9702, 96.0787),
                    vec3(-880.0594, 347.4797, 96.1075),
                    vec3(-873.4729, 353.8240, 96.1504),
                    vec3(-867.3339, 357.8274, 96.5044),
                    vec3(-853.5087, 358.6179, 97.2355),
                    vec3(-854.2471, 353.7537, 96.7313),
                }, -- pasture polygon
            },
            Goats   = {
                Menu = vec4(-853.01, 325.27, 95.80, 166.48), -- local prompt/store for this type
                Area = {
                    vec3(-858.2695, 325.5336, 96.0290),
                    vec3(-854.1056, 324.4754, 95.7881),
                    vec3(-849.9000, 323.2272, 95.6657),
                    vec3(-849.4072, 317.3988, 95.6419),
                    vec3(-850.2359, 313.5411, 95.7364),
                    vec3(-853.6733, 313.7003, 95.7608),
                    vec3(-858.0383, 314.1272, 95.6530),
                    vec3(-860.6746, 316.5146, 96.0560),
                    vec3(-859.8979, 321.1952, 95.9262),
                }, -- pasture polygon
            },
            Sheep   = {
                Menu = vec4(-868.97, 324.00, 95.98, 263.97), -- local prompt/store for this type
                Area = {
                    vec3(-867.6722, 327.3069, 96.1873),
                    vec3(-863.8739, 326.3084, 96.1451),
                    vec3(-860.3661, 325.6548, 96.1110),
                    vec3(-862.0565, 315.1965, 95.7950),
                    vec3(-863.7383, 315.3021, 95.8416),
                    vec3(-869.5198, 316.6247, 96.1550),
                    vec3(-868.3125, 322.0105, 96.1022),
                }, -- pasture polygon
            },
            Swine   = {
                Menu = vec4(-841.46, 358.88, 97.02, 96.00), -- local prompt/store for this type
                Area = {
                    vec3(-842.7750, 355.8405, 96.9497),
                    vec3(-842.3260, 358.8235, 96.9991),
                    vec3(-841.7935, 361.5772, 97.2000),
                    vec3(-841.0811, 371.6185, 97.0190),
                    vec3(-846.6230, 372.0838, 97.1345),
                    vec3(-848.3676, 372.0476, 97.1859),
                    vec3(-849.6461, 368.8679, 97.3395),
                    vec3(-850.3369, 365.5765, 97.4618),
                    vec3(-851.3320, 362.0613, 97.4361),
                    vec3(-852.2340, 358.2022, 97.2305),
                    vec3(-848.3668, 356.7878, 97.1947),
                }, -- pasture polygon
            },
            Poultry = {
                Menu = vec4(-803.66, 350.96, 96.75, 159.69), -- local prompt/store
                Prop = true,                                 -- if false dont have a CoopChoop Prop
                Area = {
                    vec3(-808.7213, 349.2130, 96.7992),
                    vec3(-812.8492, 349.5476, 96.8947),
                    vec3(-813.2735, 347.6010, 96.8825),
                    vec3(-814.7605, 341.6431, 96.6755),
                    vec3(-812.1941, 339.6750, 96.3804),
                    vec3(-804.6326, 340.0182, 96.2659),
                    vec3(-800.9926, 344.5786, 96.6362),
                    vec3(-799.1407, 354.0766, 96.6766),
                    vec3(-806.8233, 356.6362, 96.8382),
                    vec3(-808.1962, 352.7564, 96.8264),
                },
            },
        },
    },
    [3] = {                                                       -- Ranch ID
        RanchName       = 'Little Ranch Little Creek River',      -- Ranch Name if you want to use in prompt
        Job             = false,                                  -- Or false 1.5.1
        JobOwnerGrade   = 3,                                      -- Job Owner Grade/Max Job Grade 1.5.1
        RanchPriceMoney = 1000,                                   -- Or false to only use Ranch Document item
        RanchPriceGold  = 1000,                                   -- Or false to only use Ranch Document item
        TaxAmount       = 500,                                    -- Tax amount per cycle (overrides Config.TaxAmount)
        MenuLocation    = vec4(-1817.70, 652.63, 131.28, 176.29), -- Menu and NPC Location
        MaxAnimals      = 50,                                     -- Maximum animals in this ranch (only works if Config.MaxAnimalsToAll = false)
        Stash           = {
            weight = 1000,                                        -- maximum stash weight (RSG framework only)
            slots  = 300,                                         -- maximum stash item slots (RSG framework only)
        },
        Animals         = {
            Poultry = {
                Menu = vec4(-1822.78, 653.25, 131.78, 140.25), -- local prompt/store
                Prop = true,                                   -- if false dont have a CoopChoop Prop
                Area = {
                    vec3(-1820.5380, 647.3073, 131.3046),
                    vec3(-1822.1426, 650.8726, 131.5562),
                    vec3(-1824.3694, 653.0737, 131.8215),
                    vec3(-1825.6672, 651.8113, 131.8650),
                    vec3(-1823.7913, 649.2810, 131.4623),
                    vec3(-1824.1599, 647.5835, 131.3477),
                    vec3(-1822.7524, 645.8740, 131.2460),
                },
            },
            Goats   = {
                Menu = vec4(-1828.79, 636.11, 131.01, 129.27),
                Area = {
                    vec3(-1826.4860, 630.0498, 130.3077),
                    vec3(-1818.6163, 629.8228, 129.8042),
                    vec3(-1805.6232, 636.9637, 130.5493),
                    vec3(-1810.1008, 651.0938, 131.1206),
                    vec3(-1819.7615, 646.5370, 131.1729),
                    vec3(-1822.5663, 644.9111, 131.1966),
                    vec3(-1828.7733, 640.6371, 131.2607),
                    vec3(-1828.5858, 636.5551, 131.0152),
                },
            },
        },
    },
    [4] = {                                                       -- Ranch ID
        RanchName       = 'Hanging Dog Farm',                     -- Ranch Name if you want to use in prompt
        Job             = false,                                  -- Or false 1.5.1
        JobOwnerGrade   = 3,                                      -- Job Owner Grade/Max Job Grade 1.5.1
        RanchPriceMoney = 1000,                                   -- Or false to only use Ranch Document item
        RanchPriceGold  = 1000,                                   -- Or false to only use Ranch Document item
        TaxAmount       = 500,                                    -- Tax amount per cycle (overrides Config.TaxAmount)
        MenuLocation    = vec4(-2217.28, 728.39, 122.98, 271.95), -- Menu and NPC Location
        MaxAnimals      = 50,                                     -- Maximum animals in this ranch (only works if Config.MaxAnimalsToAll = false)
        Stash           = {
            weight = 1000,                                        -- maximum stash weight (RSG framework only)
            slots  = 300,                                         -- maximum stash item slots (RSG framework only)
        },
        Animals         = {
            Cattle  = {
                Menu = vec4(-2237.23, 682.30, 118.99, 222.79), -- local prompt/store
                Area = {
                    vec3(-2237.5940, 683.3730, 119.1045),
                    vec3(-2244.8640, 677.1605, 118.6778),
                    vec3(-2250.9580, 680.0889, 118.8842),
                    vec3(-2257.1868, 683.4180, 119.3403),
                    vec3(-2261.9153, 685.5542, 120.0062),
                    vec3(-2266.8567, 686.9091, 120.2207),
                    vec3(-2272.4546, 689.2789, 119.8911),
                    vec3(-2276.1648, 692.7415, 119.9978),
                    vec3(-2274.8381, 695.7284, 120.7784),
                    vec3(-2272.9426, 698.7833, 121.2389),
                    vec3(-2271.3867, 703.1570, 121.7642),
                    vec3(-2269.2810, 707.7759, 122.3264),
                    vec3(-2266.5525, 714.8774, 123.0098),
                    vec3(-2263.0845, 721.4852, 123.3888),
                    vec3(-2261.6494, 724.3882, 123.5032),
                    vec3(-2258.7805, 725.9482, 123.5065),
                    vec3(-2253.7566, 718.3500, 122.8765),
                    vec3(-2251.0830, 713.0347, 122.4786),
                    vec3(-2248.9873, 709.4260, 122.2716),
                    vec3(-2244.5166, 706.1401, 121.9415),
                    vec3(-2238.1533, 693.1522, 120.6533),
                    vec3(-2234.6396, 686.8165, 119.9207),
                },
            },
            Goats   = {
                Menu = vec4(-2224.95, 700.73, 121.84, 111.79),
                Area = {
                    vec3(-2229.5061, 699.7397, 121.6615),
                    vec3(-2231.4539, 698.6509, 121.5282),
                    vec3(-2237.4426, 695.8038, 120.9945),
                    vec3(-2236.3774, 692.8313, 120.6936),
                    vec3(-2233.7246, 687.2380, 120.0972),
                    vec3(-2232.5652, 687.6360, 120.2308),
                    vec3(-2226.8638, 693.2242, 121.3674),
                    vec3(-2227.7856, 696.0573, 121.4921),
                },
            },
            Sheep   = {
                Menu = vec4(-2229.15, 701.61, 121.78, 274.75),
                Area = {
                    vec3(-2229.8132, 700.6797, 121.7070),
                    vec3(-2231.4014, 703.8102, 121.8269),
                    vec3(-2233.9592, 709.4412, 122.0983),
                    vec3(-2237.0107, 707.7598, 121.9457),
                    vec3(-2241.7339, 705.3991, 121.7463),
                    vec3(-2240.6514, 701.8747, 121.5872),
                    vec3(-2238.1646, 696.8536, 121.1418),
                    vec3(-2233.8965, 698.6465, 121.3835),
                },
            },
            Swine   = {
                Menu = vec4(-2250.56, 712.58, 122.43, 343.94),
                Area = {
                    vec3(-2249.6252, 712.8978, 122.3808),
                    vec3(-2251.8691, 718.3221, 122.7219),
                    vec3(-2255.1001, 723.1412, 123.1750),
                    vec3(-2257.3674, 726.9122, 123.5083),
                    vec3(-2254.1011, 729.0635, 123.5821),
                    vec3(-2247.1758, 731.9510, 123.5261),
                    vec3(-2244.9319, 729.2561, 123.2705),
                    vec3(-2241.7402, 724.3882, 122.8754),
                    vec3(-2239.3296, 720.0787, 122.6383),
                    vec3(-2237.7888, 716.1031, 122.4158),
                    vec3(-2234.6978, 710.9970, 122.1605),
                    vec3(-2237.0786, 709.0356, 122.0207),
                    vec3(-2240.2407, 707.8834, 121.8954),
                    vec3(-2244.4363, 707.1716, 121.9231),
                },
            },
            Poultry = {
                Menu = vec4(-2169.08, 707.71, 122.29, 152.40),
                Prop = true,
                Area = {
                    vec3(-2170.7236, 705.4427, 122.2835),
                    vec3(-2169.4468, 703.4234, 122.0530),
                    vec3(-2165.9331, 703.1030, 121.6640),
                    vec3(-2160.5945, 705.8323, 121.7567),
                    vec3(-2160.7217, 709.9482, 122.1718),
                    vec3(-2163.9006, 714.1960, 122.3094),
                    vec3(-2167.9597, 713.7418, 122.2997),
                    vec3(-2171.6472, 711.2108, 122.3004),
                },
            },
        },
    },
    [5] = {                                                       -- Ranch ID
        RanchName       = 'Jhon Farm',                            -- Ranch Name if you want to use in prompt
        Job             = false,                                  -- Or false 1.5.1
        JobOwnerGrade   = 3,                                      -- Job Owner Grade/Max Job Grade 1.5.1
        RanchPriceMoney = 1000,                                   -- Or false to only use Ranch Document item
        RanchPriceGold  = 1000,                                   -- Or false to only use Ranch Document item
        TaxAmount       = 500,                                    -- Tax amount per cycle (overrides Config.TaxAmount)
        MenuLocation    = vec4(-1606.45, -1411.85, 81.94, 84.13), -- Menu and NPC Location
        MaxAnimals      = 50,                                     -- Maximum animals in this ranch (only works if Config.MaxAnimalsToAll = false)
        Stash           = {
            weight = 1000,                                        -- maximum stash weight (RSG framework only)
            slots  = 300,                                         -- maximum stash item slots (RSG framework only)
        },
        Animals         = {
            Cattle  = {
                Menu = vec4(-1599.25, -1432.49, 81.36, 300.80), -- local prompt/store
                Area = {
                    vec3(-1598.4370, -1431.8225, 81.3837),
                    vec3(-1599.3276, -1429.2229, 81.4525),
                    vec3(-1601.6764, -1425.5262, 81.5729),
                    vec3(-1599.3588, -1420.7587, 81.9497),
                    vec3(-1594.5482, -1410.2571, 81.9403),
                    vec3(-1592.4200, -1410.5741, 81.8851),
                    vec3(-1588.6667, -1410.4075, 81.3110),
                    vec3(-1585.1383, -1407.3739, 81.2572),
                    vec3(-1579.4888, -1405.4045, 81.2464),
                    vec3(-1575.7045, -1405.2179, 81.7449),
                    vec3(-1570.6804, -1407.5516, 81.9113),
                    vec3(-1563.5844, -1412.6348, 82.1357),
                    vec3(-1562.1254, -1420.6899, 82.2117),
                    vec3(-1563.7046, -1427.2545, 82.3137),
                    vec3(-1567.8325, -1434.2629, 82.3969),
                    vec3(-1576.9756, -1438.8645, 81.8920),
                    vec3(-1587.4929, -1439.9235, 81.6318),
                    vec3(-1592.1852, -1438.8756, 81.4209),
                },
            },
            Goats   = {
                Menu = vec4(-1591.33, -1409.44, 81.75, 177.64),
                Area = {
                    vec3(-1598.4370, -1431.8225, 81.3837),
                    vec3(-1599.3276, -1429.2229, 81.4525),
                    vec3(-1601.6764, -1425.5262, 81.5729),
                    vec3(-1599.3588, -1420.7587, 81.9497),
                    vec3(-1594.5482, -1410.2571, 81.9403),
                    vec3(-1592.4200, -1410.5741, 81.8851),
                    vec3(-1588.6667, -1410.4075, 81.3110),
                    vec3(-1585.1383, -1407.3739, 81.2572),
                    vec3(-1579.4888, -1405.4045, 81.2464),
                    vec3(-1575.7045, -1405.2179, 81.7449),
                    vec3(-1570.6804, -1407.5516, 81.9113),
                    vec3(-1563.5844, -1412.6348, 82.1357),
                    vec3(-1562.1254, -1420.6899, 82.2117),
                    vec3(-1563.7046, -1427.2545, 82.3137),
                    vec3(-1567.8325, -1434.2629, 82.3969),
                    vec3(-1576.9756, -1438.8645, 81.8920),
                    vec3(-1587.4929, -1439.9235, 81.6318),
                    vec3(-1592.1852, -1438.8756, 81.4209),
                },
            },
            Sheep   = {
                Menu = vec4(-1586.55, -1407.30, 81.26, 240.10),
                Area = {
                    vec3(-1598.4370, -1431.8225, 81.3837),
                    vec3(-1599.3276, -1429.2229, 81.4525),
                    vec3(-1601.6764, -1425.5262, 81.5729),
                    vec3(-1599.3588, -1420.7587, 81.9497),
                    vec3(-1594.5482, -1410.2571, 81.9403),
                    vec3(-1592.4200, -1410.5741, 81.8851),
                    vec3(-1588.6667, -1410.4075, 81.3110),
                    vec3(-1585.1383, -1407.3739, 81.2572),
                    vec3(-1579.4888, -1405.4045, 81.2464),
                    vec3(-1575.7045, -1405.2179, 81.7449),
                    vec3(-1570.6804, -1407.5516, 81.9113),
                    vec3(-1563.5844, -1412.6348, 82.1357),
                    vec3(-1562.1254, -1420.6899, 82.2117),
                    vec3(-1563.7046, -1427.2545, 82.3137),
                    vec3(-1567.8325, -1434.2629, 82.3969),
                    vec3(-1576.9756, -1438.8645, 81.8920),
                    vec3(-1587.4929, -1439.9235, 81.6318),
                    vec3(-1592.1852, -1438.8756, 81.4209),
                },
            },
            Swine   = {
                Menu = vec4(-1568.22, -1407.97, 81.96, 177.99),
                Area = {
                    vec3(-1598.4370, -1431.8225, 81.3837),
                    vec3(-1599.3276, -1429.2229, 81.4525),
                    vec3(-1601.6764, -1425.5262, 81.5729),
                    vec3(-1599.3588, -1420.7587, 81.9497),
                    vec3(-1594.5482, -1410.2571, 81.9403),
                    vec3(-1592.4200, -1410.5741, 81.8851),
                    vec3(-1588.6667, -1410.4075, 81.3110),
                    vec3(-1585.1383, -1407.3739, 81.2572),
                    vec3(-1579.4888, -1405.4045, 81.2464),
                    vec3(-1575.7045, -1405.2179, 81.7449),
                    vec3(-1570.6804, -1407.5516, 81.9113),
                    vec3(-1563.5844, -1412.6348, 82.1357),
                    vec3(-1562.1254, -1420.6899, 82.2117),
                    vec3(-1563.7046, -1427.2545, 82.3137),
                    vec3(-1567.8325, -1434.2629, 82.3969),
                    vec3(-1576.9756, -1438.8645, 81.8920),
                    vec3(-1587.4929, -1439.9235, 81.6318),
                    vec3(-1592.1852, -1438.8756, 81.4209),
                },
            },
            Poultry = {
                Menu = vec4(-1580.84, -1395.98, 81.14, 52.46),
                Prop = false,
                Area = {
                    vec3(-1583.5929, -1400.8116, 81.2695),
                    vec3(-1588.0957, -1398.9000, 81.3654),
                    vec3(-1586.6671, -1395.9055, 81.3276),
                    vec3(-1582.2885, -1397.9474, 81.2417),
                },
            },
        },
    },
    [6] = {                                                       -- Ranch ID
        RanchName       = 'Mc Farlanes Ranch',                    -- Ranch Name if you want to use in prompt
        Job             = false,                                  -- Or false 1.5.1
        JobOwnerGrade   = 3,                                      -- Job Owner Grade/Max Job Grade 1.5.1
        RanchPriceMoney = 1000,                                   -- Or false to only use Ranch Document item
        RanchPriceGold  = 1000,                                   -- Or false to only use Ranch Document item
        TaxAmount       = 500,                                    -- Tax amount per cycle (overrides Config.TaxAmount)
        MenuLocation    = vec4(-2403.13, -2379.20, 61.18, 63.19), -- Menu and NPC Location
        MaxAnimals      = 50,                                     -- Maximum animals in this ranch (only works if Config.MaxAnimalsToAll = false)
        Stash           = {
            weight = 1000,                                        -- maximum stash weight (RSG framework only)
            slots  = 300,                                         -- maximum stash item slots (RSG framework only)
        },
        Animals         = {
            Cattle  = {
                Menu = vec4(-2412.93, -2390.95, 61.19, 286.23), -- local prompt/store
                Area = {
                    vec3(-2411.6575, -2386.1765, 61.1755),
                    vec3(-2421.4348, -2376.3379, 61.1772),
                    vec3(-2427.6243, -2377.7236, 61.1748),
                    vec3(-2431.3672, -2376.4294, 61.1756),
                    vec3(-2438.9797, -2380.0684, 61.1756),
                    vec3(-2439.8176, -2374.4314, 61.1761),
                    vec3(-2441.3298, -2369.3433, 61.1767),
                    vec3(-2454.4978, -2347.6853, 61.1779),
                    vec3(-2472.1765, -2359.7454, 61.1761),
                    vec3(-2479.0459, -2368.4741, 61.1578),
                    vec3(-2481.2922, -2379.4934, 61.1780),
                    vec3(-2480.4993, -2385.3513, 61.1754),
                    vec3(-2477.6357, -2392.8914, 61.1753),
                    vec3(-2468.7622, -2408.1367, 61.1374),
                    vec3(-2460.5654, -2413.6938, 61.1814),
                    vec3(-2453.4756, -2415.3413, 61.1617),
                    vec3(-2448.6272, -2413.1211, 61.1773),
                    vec3(-2443.4373, -2405.1760, 61.1755),
                    vec3(-2436.3264, -2400.3152, 61.1755),
                },
            },
            Horse   = {
                Menu = vec4(-2402.06, -2364.87, 61.18, 325.21),
                Area = {
                    vec3(-2421.6653, -2357.6353, 61.1755),
                    vec3(-2419.1133, -2360.4255, 61.1755),
                    vec3(-2417.2131, -2364.4966, 61.1756),
                    vec3(-2417.2427, -2367.3142, 61.1755),
                    vec3(-2417.4109, -2369.1458, 61.1755),
                    vec3(-2419.9885, -2374.1897, 61.1755),
                    vec3(-2424.1301, -2376.4963, 61.1755),
                    vec3(-2432.4875, -2374.5664, 61.1755),
                    vec3(-2437.6548, -2376.0854, 61.1755),
                    vec3(-2439.5874, -2372.6204, 61.1788),
                    vec3(-2440.4788, -2367.9475, 61.1751),
                    vec3(-2439.6472, -2361.5930, 61.1755),
                    vec3(-2437.0703, -2357.8813, 61.1755),
                    vec3(-2430.2388, -2355.0637, 61.1755),
                    vec3(-2424.8975, -2356.0608, 61.1755),

                },
            },
            Goat    = {
                Menu = vec4(-2406.59, -2439.03, 60.17, 139.78),
                Area = {
                    vec3(-2423.3281, -2449.5273, 60.1722),
                    vec3(-2423.7781, -2443.2117, 60.1861),
                    vec3(-2410.8901, -2437.7021, 60.1759),
                    vec3(-2407.6658, -2439.7917, 60.1726),
                    vec3(-2401.9729, -2443.9807, 60.1716),
                    vec3(-2395.5398, -2451.0667, 60.1681),
                    vec3(-2394.9780, -2453.8577, 60.2014),
                    vec3(-2402.0940, -2458.7361, 60.1716),
                    vec3(-2402.3625, -2460.7437, 60.1717),
                    vec3(-2405.1707, -2461.5493, 60.1622),
                    vec3(-2401.8091, -2470.9927, 60.1827),
                    vec3(-2400.2390, -2478.8074, 60.1708),
                    vec3(-2410.9128, -2478.0232, 60.1506),
                    vec3(-2412.9714, -2478.6721, 60.2124),
                    vec3(-2419.8599, -2475.4758, 60.1714),
                    vec3(-2423.3948, -2461.9114, 60.1716),
                    vec3(-2423.2783, -2457.2578, 60.1715),
                },
            },
            Sheep   = {
                Menu = vec4(-2424.76, -2449.07, 60.17, 57.49),
                Area = {
                    vec3(-2423.3281, -2449.5273, 60.1722),
                    vec3(-2423.7781, -2443.2117, 60.1861),
                    vec3(-2410.8901, -2437.7021, 60.1759),
                    vec3(-2407.6658, -2439.7917, 60.1726),
                    vec3(-2401.9729, -2443.9807, 60.1716),
                    vec3(-2395.5398, -2451.0667, 60.1681),
                    vec3(-2394.9780, -2453.8577, 60.2014),
                    vec3(-2402.0940, -2458.7361, 60.1716),
                    vec3(-2402.3625, -2460.7437, 60.1717),
                    vec3(-2405.1707, -2461.5493, 60.1622),
                    vec3(-2401.8091, -2470.9927, 60.1827),
                    vec3(-2400.2390, -2478.8074, 60.1708),
                    vec3(-2410.9128, -2478.0232, 60.1506),
                    vec3(-2412.9714, -2478.6721, 60.2124),
                    vec3(-2419.8599, -2475.4758, 60.1714),
                    vec3(-2423.3948, -2461.9114, 60.1716),
                    vec3(-2423.2783, -2457.2578, 60.1715),
                },
            },
            Poultry = {
                Menu = vec4(-2420.30, -2428.61, 60.26, 194.16),
                Prop = false,
                Area = {
                    vec3(-2419.9939, -2430.0449, 60.3048),
                    vec3(-2417.7349, -2433.8298, 60.2885),
                    vec3(-2415.7000, -2434.7820, 60.2011),
                    vec3(-2412.2588, -2434.2915, 60.1717),
                    vec3(-2411.4268, -2435.9526, 60.1667),
                    vec3(-2413.5583, -2437.8284, 60.1911),
                    vec3(-2424.0430, -2442.5779, 60.1679),
                    vec3(-2426.1072, -2438.4304, 60.1769),
                    vec3(-2421.1958, -2436.2246, 60.2263),
                    vec3(-2420.9583, -2434.5322, 60.2898),
                    vec3(-2422.1824, -2430.0088, 60.2964),
                },
            },
        },
    },

    [11] = {                                                    -- Ranch ID
        RanchName       = 'Heartland Ranch',                    -- Ranch Name if you want to use in prompt
        Job             = false,                                -- Or false 1.5.1
        JobOwnerGrade   = 3,                                    -- Job Owner Grade/Max Job Grade 1.5.1
        RanchPriceMoney = 1000,                                 -- Or false to only use Ranch Document item
        RanchPriceGold  = 1000,                                 -- Or false to only use Ranch Document item
        TaxAmount       = 500,                                  -- Tax amount per cycle (overrides Config.TaxAmount)
        MenuLocation    = vec4(1129.18, 502.17, 96.22, 103.68), -- Menu and NPC Location
        MaxAnimals      = 50,                                   -- Maximum animals in this ranch (only works if Config.MaxAnimalsToAll = false)
        Stash           = {
            weight = 1000,                                      -- maximum stash weight (RSG framework only)
            slots  = 300,                                       -- maximum stash item slots (RSG framework only)
        },
        Animals         = {
            Cattle  = {
                Menu = vec4(1117.13, 505.12, 95.74, 244.50), -- local prompt/store for this type
                Area = {
                    vec3(1115.1406, 504.0266, 95.7273),
                    vec3(1106.8518, 499.5198, 95.6484),
                    vec3(1096.1586, 493.5304, 95.4541),
                    vec3(1090.0063, 490.1898, 95.6335),
                    vec3(1084.3606, 499.8127, 95.6356),
                    vec3(1108.0188, 514.8107, 94.3947),
                }, -- pasture polygon
            },
            Poultry = {
                Menu = vec4(1136.16, 501.00, 96.38, 194.67), -- local prompt/store
                Prop = true,                                 -- if false dont have a CoopChoop Prop
                Area = {
                    vec3(1134.4202, 500.3924, 96.2770),
                    vec3(1131.4037, 497.1910, 96.0403),
                    vec3(1133.9023, 494.4641, 96.0486),
                    vec3(1139.6501, 497.4080, 96.1904),
                    vec3(1137.2943, 502.1423, 96.5044),
                },
            },
            Horse   = {
                Menu = vec4(1172.27, 428.75, 92.78, 99.68),
                Area = {
                    vec3(1150.5691, 432.2751, 95.4869),
                    vec3(1163.7872, 420.5816, 93.5242),
                    vec3(1170.1985, 427.3931, 92.7551),
                    vec3(1173.7015, 433.6725, 92.8013),
                    vec3(1176.1388, 437.4162, 92.8085),
                    vec3(1184.8186, 432.2162, 92.6499),
                    vec3(1190.6010, 437.2148, 92.1682),
                    vec3(1197.6056, 445.5865, 92.4245),
                    vec3(1185.3688, 457.6369, 93.3040),
                    vec3(1168.5681, 447.7788, 93.9390),
                    vec3(1161.0981, 441.3599, 94.5347),
                },
            },
        },
    },

    [12] = {                                                    -- Ranch ID
        RanchName       = 'Hobbit Ranch',                       -- Ranch Name if you want to use in prompt
        Job             = false,                                -- Or false 1.5.1
        JobOwnerGrade   = 3,                                    -- Job Owner Grade/Max Job Grade 1.5.1
        RanchPriceMoney = 1000,                                 -- Or false to only use Ranch Document item
        RanchPriceGold  = 1000,                                 -- Or false to only use Ranch Document item
        TaxAmount       = 500,                                  -- Tax amount per cycle (overrides Config.TaxAmount)
        MenuLocation    = vec4(891.50, 257.42, 117.02, 106.68), -- Menu and NPC Location
        MaxAnimals      = 50,                                   -- Maximum animals in this ranch (only works if Config.MaxAnimalsToAll = false)
        Stash           = {
            weight = 1000,                                      -- maximum stash weight (RSG framework only)
            slots  = 300,                                       -- maximum stash item slots (RSG framework only)
        },
        Animals         = {
            Sheep   = {
                Menu = vec4(881.79, 254.16, 117.28, 280.13), -- local prompt/store for this type
                Area = {
                    vec3(890.7349, 248.8163, 117.8735),
                    vec3(887.7645, 247.7496, 117.7155),
                    vec3(886.1648, 249.8103, 117.5415),
                    vec3(884.1007, 251.1999, 117.3476),
                    vec3(882.7318, 252.0034, 117.4396),
                    vec3(882.9582, 258.2467, 117.0995),
                    vec3(883.7493, 264.7648, 116.5399),
                    vec3(886.4353, 265.1090, 116.6512),
                    vec3(889.8981, 265.4354, 116.6838),
                    vec3(890.6266, 263.2524, 116.9065),
                    vec3(891.0301, 262.2084, 117.0052),
                    vec3(891.5962, 260.0076, 117.1194),
                    vec3(891.4701, 254.4199, 117.1547),
                    vec3(890.3209, 253.3326, 117.6070),
                    vec3(890.7192, 249.5467, 117.8703),
                    vec3(889.6151, 252.1357, 117.5959),
                }, -- pasture polygon
            },
            Poultry = {
                Menu = vec4(891.90, 277.05, 116.18, 62.81), -- local prompt/store
                Prop = true,                                -- if false dont have a CoopChoop Prop
                Area = {
                    vec3(895.2557, 273.2578, 116.2252),
                    vec3(893.5189, 271.7701, 116.2502),
                    vec3(891.5460, 271.5610, 116.2746),
                    vec3(890.0438, 273.7862, 116.3158),
                    vec3(889.4042, 276.3178, 116.1065),
                    vec3(888.5425, 278.9841, 115.7916),
                    vec3(892.1089, 279.5989, 116.0049),
                    vec3(893.9716, 279.1019, 116.1629),
                    vec3(895.9692, 277.8333, 116.2144),
                    vec3(895.2618, 276.0439, 116.2067),
                },
            },
        },
    },

    [13] = {                                                    -- Ranch ID
        RanchName       = 'Flatneck station ranch',             -- Ranch Name if you want to use in prompt
        Job             = false,                                -- Or false 1.5.1
        JobOwnerGrade   = 3,                                    -- Job Owner Grade/Max Job Grade 1.5.1
        RanchPriceMoney = 1000,                                 -- Or false to only use Ranch Document item
        RanchPriceGold  = 1000,                                 -- Or false to only use Ranch Document item
        TaxAmount       = 500,                                  -- Tax amount per cycle (overrides Config.TaxAmount)
        MenuLocation    = vec4(-74.06, -388.75, 72.11, 220.29), -- Menu and NPC Location
        MaxAnimals      = 50,                                   -- Maximum animals in this ranch (only works if Config.MaxAnimalsToAll = false)
        Stash           = {
            weight = 1000,                                      -- maximum stash weight (RSG framework only)
            slots  = 300,                                       -- maximum stash item slots (RSG framework only)
        },
        Animals         = {
            Poultry = {
                Menu = vec4(-63.09, -404.48, 70.94, 175.84), -- local prompt/store
                Prop = false,                                -- if false dont have a CoopChoop Prop
                Area = {
                    vec3(-69.3721, -406.9181, 70.9434),
                    vec3(-66.0530, -406.1177, 70.8659),
                    vec3(-58.7472, -404.6014, 70.8465),
                    vec3(-58.3384, -405.9600, 70.9661),
                    vec3(-57.6537, -407.9451, 70.9445),
                    vec3(-56.0643, -408.4128, 70.6495),
                    vec3(-55.5799, -410.9255, 70.9452),
                    vec3(-57.0187, -411.3802, 70.5812),
                    vec3(-61.2665, -412.3535, 71.0586),
                    vec3(-61.4858, -411.6817, 71.1152),
                    vec3(-62.3966, -411.8016, 71.0182),
                    vec3(-66.0465, -412.5887, 70.5652),
                    vec3(-66.3531, -414.0407, 70.5830),
                    vec3(-67.4834, -414.2245, 70.5727),
                    vec3(-67.9541, -413.0065, 70.5732),
                    vec3(-68.6795, -409.4558, 70.6931),
                },
            },
        },
    },

    [14] = {                                                    -- Ranch ID
        RanchName       = 'Ranch near Emerald Ranch',           -- Ranch Name if you want to use in prompt
        Job             = false,                                -- Or false 1.5.1
        JobOwnerGrade   = 3,                                    -- Job Owner Grade/Max Job Grade 1.5.1
        RanchPriceMoney = 1000,                                 -- Or false to only use Ranch Document item
        RanchPriceGold  = 1000,                                 -- Or false to only use Ranch Document item
        TaxAmount       = 500,                                  -- Tax amount per cycle (overrides Config.TaxAmount)
        MenuLocation    = vec4(1778.62, 466.71, 112.61, 17.42), -- Menu and NPC Location
        MaxAnimals      = 50,                                   -- Maximum animals in this ranch (only works if Config.MaxAnimalsToAll = false)
        Stash           = {
            weight = 1000,                                      -- maximum stash weight (RSG framework only)
            slots  = 300,                                       -- maximum stash item slots (RSG framework only)
        },
        Animals         = {
            Poultry = {
                Menu = vec4(1772.38, 473.53, 111.88, 117.56), -- local prompt/store
                Prop = true,                                  -- if false dont have a CoopChoop Prop
                Area = {
                    vec3(1772.0371, 468.3808, 112.1782),
                    vec3(1769.1224, 467.3322, 112.1147),
                    vec3(1765.7892, 469.5048, 111.7171),
                    vec3(1764.6479, 473.6507, 111.4957),
                    vec3(1767.3892, 477.8975, 111.3871),
                    vec3(1771.1477, 479.0112, 111.1836),
                    vec3(1775.0682, 477.4864, 111.5063),
                    vec3(1777.4314, 474.8584, 112.0604),
                    vec3(1777.4446, 471.0011, 112.4519),
                    vec3(1775.0460, 468.8905, 112.4741),
                },
            },
        },
    },

    [15] = {                                                    -- Ranch ID
        RanchName       = 'Ranch near BluewaterMarsh',          -- Ranch Name if you want to use in prompt
        Job             = false,                                -- Or false 1.5.1
        JobOwnerGrade   = 3,                                    -- Job Owner Grade/Max Job Grade 1.5.1
        RanchPriceMoney = 1000,                                 -- Or false to only use Ranch Document item
        RanchPriceGold  = 1000,                                 -- Or false to only use Ranch Document item
        TaxAmount       = 500,                                  -- Tax amount per cycle (overrides Config.TaxAmount)
        MenuLocation    = vec4(2265.28, -137.81, 45.27, 96.97), -- Menu and NPC Location
        MaxAnimals      = 50,                                   -- Maximum animals in this ranch (only works if Config.MaxAnimalsToAll = false)
        Stash           = {
            weight = 1000,                                      -- maximum stash weight (RSG framework only)
            slots  = 300,                                       -- maximum stash item slots (RSG framework only)
        },
        Animals         = {
            Cattle = {
                Menu = vec4(2264.22, -107.77, 45.38, 278.84), -- local prompt/store
                Area = {
                    vec3(2265.2798, -107.3080, 45.3523),
                    vec3(2265.8818, -103.1894, 45.2279),
                    vec3(2267.8594, -98.2383, 45.2449),
                    vec3(2272.9246, -98.6149, 44.8818),
                    vec3(2282.1936, -99.9639, 44.6427),
                    vec3(2285.6899, -103.1608, 44.5662),
                    vec3(2287.5962, -107.7647, 44.4722),
                    vec3(2286.7017, -112.2437, 44.4979),
                    vec3(2284.3643, -116.6932, 44.5334),
                    vec3(2281.2839, -123.5368, 44.5794),
                    vec3(2280.3430, -128.1212, 44.6374),
                    vec3(2278.0190, -127.7966, 44.8019),
                    vec3(2277.2727, -129.2012, 44.8395),
                    vec3(2276.2119, -129.3671, 44.8617),
                    vec3(2274.8757, -128.9184, 44.8545),
                    vec3(2273.8821, -129.3831, 45.1236),
                    vec3(2271.3337, -129.1582, 44.8860),
                    vec3(2273.2068, -124.9517, 45.0061),
                    vec3(2270.5811, -123.4479, 45.1195),
                    vec3(2263.3528, -121.5944, 45.8465),
                    vec3(2263.5769, -119.8343, 45.7936),
                    vec3(2264.1946, -114.1695, 45.6644),
                },
            },
            Swine = {
                Menu = vec4(2262.00, -124.16, 45.87, 84.00), -- local prompt/store
                Area = {
                    vec3(2263.1775, -122.5374, 45.8306),
                    vec3(2265.4883, -123.0865, 45.6169),
                    vec3(2272.4143, -124.9939, 44.8960),
                    vec3(2271.2512, -129.2545, 44.9356),
                    vec3(2267.1865, -128.1431, 45.3902),
                    vec3(2262.6189, -126.3470, 45.7755),
                },
            },
            Sheep = {
                Menu = vec4(2252.77, -97.60, 45.66, 195.84), -- local prompt/store
                Area = {
                    vec3(2257.6233, -99.1886, 45.5291),
                    vec3(2257.7456, -101.2773, 45.6419),
                    vec3(2257.8323, -104.2208, 45.7176),
                    vec3(2257.4468, -106.9061, 45.8185),
                    vec3(2256.9834, -110.0399, 45.9189),
                    vec3(2256.3347, -113.1425, 45.9375),
                    vec3(2255.4443, -119.0106, 46.0662),
                    vec3(2251.7449, -122.0600, 46.2007),
                    vec3(2247.7551, -122.0174, 46.3642),
                    vec3(2243.5154, -121.3470, 46.6045),
                    vec3(2239.3101, -120.4767, 46.7368),
                    vec3(2239.4966, -116.6943, 46.2694),
                    vec3(2240.0747, -109.0685, 46.0457),
                    vec3(2240.9236, -103.9109, 46.0421),
                    vec3(2242.2700, -98.6246, 46.0379),
                    vec3(2246.3184, -97.7759, 45.8149),
                    vec3(2253.0898, -98.6054, 45.6869),
                },
            },
            Goats = {
                Menu = vec4(2239.98, -109.56, 46.06, 119.60), -- local prompt/store
                Area = {
                    vec3(2238.7175, -115.4930, 46.2656),
                    vec3(2238.3030, -120.3708, 46.7966),
                    vec3(2234.3293, -119.3307, 46.8151),
                    vec3(2231.2996, -118.4489, 47.1425),
                    vec3(2227.4980, -114.7336, 47.4698),
                    vec3(2227.1987, -110.5030, 47.3778),
                    vec3(2227.5969, -104.3854, 47.2243),
                    vec3(2228.0276, -99.7621, 47.2372),
                    vec3(2231.6765, -96.5425, 46.9853),
                    vec3(2234.4756, -96.6906, 46.6526),
                    vec3(2238.2021, -97.6687, 46.3365),
                    vec3(2241.0325, -98.9154, 46.1289),
                    vec3(2239.8638, -104.9945, 46.0683),
                    vec3(2239.4456, -107.9866, 46.0845),
                },
            },
            Poultry = {
                Menu = vec4(2252.95, -146.14, 46.19, 2.44), -- local prompt/store
                Prop = false,                               -- if false dont have a CoopChoop Prop
                Area = {
                    vec3(2252.1345, -154.4928, 45.9762),
                    vec3(2253.6243, -154.6609, 45.9561),
                    vec3(2253.8411, -153.6411, 46.0573),
                    vec3(2254.4695, -152.1963, 46.0515),
                    vec3(2254.2356, -149.4605, 46.1832),
                    vec3(2253.4514, -147.2053, 46.1812),
                    vec3(2251.7456, -147.1094, 46.2939),
                    vec3(2250.3494, -148.0181, 46.2474),
                    vec3(2249.7429, -151.3585, 46.1815),
                    vec3(2251.9395, -152.0708, 46.0987),
                    vec3(2252.2678, -153.6406, 46.0260),
                },
            },
        },
    },

    [16] = {                                                      -- Ranch ID
        RanchName       = 'Ranch near BrandWine Drop',            -- Ranch Name if you want to use in prompt
        Job             = false,                                  -- Or false 1.5.1
        JobOwnerGrade   = 3,                                      -- Job Owner Grade/Max Job Grade 1.5.1
        RanchPriceMoney = 1000,                                   -- Or false to only use Ranch Document item
        RanchPriceGold  = 1000,                                   -- Or false to only use Ranch Document item
        TaxAmount       = 500,                                    -- Tax amount per cycle (overrides Config.TaxAmount)
        MenuLocation    = vec4(2983.81, 2205.21, 166.20, 127.94), -- Menu and NPC Location
        MaxAnimals      = 50,                                     -- Maximum animals in this ranch (only works if Config.MaxAnimalsToAll = false)
        Stash           = {
            weight = 1000,                                        -- maximum stash weight (RSG framework only)
            slots  = 300,                                         -- maximum stash item slots (RSG framework only)
        },
        Animals         = {
            Sheep = {
                Menu = vec4(3009.99, 2197.73, 165.92, 281.74), -- local prompt/store
                Area = {
                    vec3(3011.4624, 2195.5881, 165.8733),
                    vec3(3010.7661, 2197.1597, 166.3699),
                    vec3(3010.1150, 2201.8682, 165.9027),
                    vec3(3007.5955, 2209.1746, 166.3947),
                    vec3(3009.5037, 2211.0002, 166.4312),
                    vec3(3011.6743, 2211.6370, 166.4564),
                    vec3(3014.8672, 2212.4358, 166.3844),
                    vec3(3015.6218, 2211.9692, 166.3422),
                    vec3(3016.8408, 2211.9602, 166.3154),
                    vec3(3019.2170, 2211.8916, 166.2280),
                    vec3(3021.5747, 2212.4480, 166.1935),
                    vec3(3022.9167, 2209.5566, 165.9892),
                    vec3(3024.8511, 2205.1743, 165.7480),
                    vec3(3024.6648, 2202.4688, 165.7100),
                    vec3(3023.5012, 2199.5859, 165.6728),
                    vec3(3022.0876, 2199.7246, 165.6914),
                    vec3(3020.6060, 2197.7231, 165.7098),
                    vec3(3020.1545, 2195.8188, 165.6718),
                    vec3(3018.1865, 2194.4324, 165.6990),
                    vec3(3015.1567, 2194.3042, 165.7016),
                    vec3(3013.6726, 2194.3916, 165.7431),
                },
            },
        },
    },

    [17] = {                                                    -- Ranch ID
        RanchName       = 'Braithwaite',                        -- Ranch Name if you want to use in prompt
        Job             = false,                                -- Or false 1.5.1
        JobOwnerGrade   = 3,                                    -- Job Owner Grade/Max Job Grade 1.5.1
        RanchPriceMoney = 1000,                                 -- Or false to only use Ranch Document item
        RanchPriceGold  = 1000,                                 -- Or false to only use Ranch Document item
        TaxAmount       = 500,                                  -- Tax amount per cycle (overrides Config.TaxAmount)
        MenuLocation    = vec4(966.29, -1837.43, 46.67, 22.87), -- Menu and NPC Location
        MaxAnimals      = 50,                                   -- Maximum animals in this ranch (only works if Config.MaxAnimalsToAll = false)
        Stash           = {
            weight = 1000,                                      -- maximum stash weight (RSG framework only)
            slots  = 300,                                       -- maximum stash item slots (RSG framework only)
        },
        Animals         = {
            Cattle  = {
                Menu = vec4(990.58, -2058.31, 46.65, 11.22), -- local prompt/store for this type
                Area = {
                    vec3(958.8730, -2048.5068, 45.4046),
                    vec3(968.0902, -2045.3523, 46.1201),
                    vec3(982.0946, -2044.2437, 46.3638),
                    vec3(995.8544, -2045.5797, 46.3743),
                    vec3(1013.7889, -2047.6287, 45.9629),
                    vec3(1019.1192, -2052.0447, 45.2364),
                    vec3(1019.4283, -2064.0901, 44.8383),
                    vec3(1018.2982, -2080.3130, 45.1188),
                    vec3(1012.5360, -2081.4507, 45.7823),
                    vec3(992.5843, -2079.7041, 45.3747),
                    vec3(982.6296, -2075.6328, 46.1008),
                    vec3(972.1050, -2064.3059, 46.3095),
                    vec3(963.9060, -2054.9578, 46.1122),
                    vec3(962.4969, -2052.4060, 45.9432),
                }, -- pasture polygon
            },
            Goats   = {
                Menu = vec4(1048.35, -1829.57, 48.80, 95.75), -- local prompt/store for this type
                Area = {
                    vec3(1054.6826, -1835.0731, 48.3960),
                    vec3(1069.8839, -1835.8110, 47.6592),
                    vec3(1072.6040, -1828.1548, 48.3064),
                    vec3(1071.8699, -1824.0743, 48.7746),
                    vec3(1064.2145, -1821.1781, 48.9055),
                    vec3(1058.3275, -1818.8904, 48.6109),
                    vec3(1056.0927, -1822.3628, 48.4372),
                    vec3(1055.1461, -1831.5345, 48.4360),
                    vec3(1055.7109, -1834.7826, 48.3822),
                }, -- pasture polygon
            },
            Sheep   = {
                Menu = vec4(999.26, -1818.13, 46.57, 291.60), -- local prompt/store for this type
                Area = {
                    vec3(999.4917, -1816.9287, 46.5203),
                    vec3(1006.3645, -1816.4559, 46.6270),
                    vec3(1006.2622, -1827.9220, 46.5478),
                    vec3(1005.3931, -1831.7153, 46.1835),
                    vec3(1003.1865, -1840.7944, 45.7676),
                    vec3(1002.2724, -1849.6573, 45.4792),
                    vec3(996.7706, -1852.9980, 45.7528),
                    vec3(992.1385, -1852.1854, 46.1153),
                    vec3(988.8790, -1846.9952, 46.5394),
                    vec3(988.7069, -1840.6055, 46.9072),
                    vec3(988.8354, -1830.3315, 46.7179),
                    vec3(988.8852, -1827.2842, 46.6617),
                    vec3(991.1855, -1824.5931, 46.5743),
                    vec3(995.4625, -1824.4136, 46.6189),
                    vec3(999.4372, -1823.3768, 46.6176),
                }, -- pasture polygon
            },
            Swine   = {
                Menu = vec4(1045.86, -1854.20, 49.28, 313.70), -- local prompt/store for this type
                Area = {
                    vec3(1049.6711, -1852.5558, 48.3913),
                    vec3(1047.9917, -1847.9841, 48.4108),
                    vec3(1047.6945, -1843.5878, 48.4258),
                    vec3(1065.2257, -1840.8284, 47.2848),
                    vec3(1066.8031, -1850.7795, 46.6078),
                    vec3(1066.9147, -1862.2383, 46.3610),
                    vec3(1056.4956, -1862.9044, 47.1942),
                    vec3(1051.5664, -1860.6521, 47.8587),
                }, -- pasture polygon
            },
            Poultry = {
                Menu = vec4(1010.33, -1888.41, 45.35, 31.40), -- local prompt/store
                Prop = false,                                 -- if false dont have a CoopChoop Prop
                Area = {
                    vec3(1015.6915, -1882.8391, 45.4482),
                    vec3(1023.6145, -1884.9830, 45.9168),
                    vec3(1023.6934, -1891.3225, 45.6188),
                    vec3(1023.4180, -1901.3252, 44.8320),
                    vec3(1019.4810, -1901.1771, 45.2472),
                    vec3(1013.6544, -1901.2716, 45.9855),
                    vec3(1011.2845, -1900.4135, 46.1503),
                    vec3(1012.6165, -1893.6208, 45.6641),
                    vec3(1012.8602, -1889.5217, 45.4302),
                    vec3(1012.6542, -1885.9760, 45.4232),
                },
            },
            Turkey  = {
                Menu = vec4(1023.99, -1809.40, 46.49, 61.47), -- local prompt/store
                Area = {
                    vec3(1026.6873, -1810.7408, 46.5591),
                    vec3(1028.5586, -1815.1282, 46.8244),
                    vec3(1030.8667, -1819.9127, 47.3683),
                    vec3(1028.7178, -1824.2622, 47.2273),
                    vec3(1024.2540, -1828.5867, 46.8178),
                    vec3(1019.5568, -1828.9662, 46.4260),
                    vec3(1016.4188, -1827.5466, 46.4718),
                    vec3(1016.3002, -1823.6298, 46.5868),
                    vec3(1017.4962, -1820.5220, 46.6029),
                    vec3(1016.0201, -1816.3295, 46.6093),
                    vec3(1016.8066, -1813.3855, 46.6004),
                    vec3(1022.8244, -1810.4584, 46.5393),
                },
            },
            Horse   = {
                Menu = vec4(962.81, -1832.57, 46.58, 73.27),
                Area = {
                    vec3(944.3974, -1847.6598, 45.1216),
                    vec3(947.2496, -1839.1725, 45.2436),
                    vec3(948.4958, -1828.3046, 45.1776),
                    vec3(950.1812, -1817.6407, 45.6795),
                    vec3(956.6987, -1814.2126, 46.4549),
                    vec3(968.3196, -1812.7057, 46.7909),
                    vec3(980.4725, -1812.7410, 46.4895),
                    vec3(985.7595, -1812.8296, 46.0993),
                    vec3(987.4709, -1820.9169, 46.5051),
                    vec3(987.0681, -1827.4478, 46.6571),
                    vec3(987.3620, -1840.2356, 46.9650),
                    vec3(976.8790, -1840.3732, 46.8366),
                    vec3(976.4989, -1834.6129, 46.7911),
                    vec3(975.9246, -1824.0822, 46.6552),
                    vec3(975.2516, -1820.0286, 46.6217),
                    vec3(968.5007, -1819.6538, 46.7624),
                    vec3(961.9034, -1820.1344, 46.6864),
                    vec3(961.1386, -1823.5499, 46.6526),
                    vec3(959.8936, -1833.3130, 46.4748),
                    vec3(960.6909, -1839.3947, 46.4757),
                    vec3(961.1209, -1844.1333, 46.3188),
                    vec3(961.0363, -1850.8829, 45.9495),
                    vec3(954.2338, -1851.0769, 45.5270),
                },
            },
        },
    },

    [18] = {                                                     -- Ranch ID
        RanchName       = 'Matoock Pond Ranch',                  -- Ranch Name if you want to use in prompt
        Job             = false,                                 -- Or false 1.5.1
        JobOwnerGrade   = 3,                                     -- Job Owner Grade/Max Job Grade 1.5.1
        RanchPriceMoney = 1000,                                  -- Or false to only use Ranch Document item
        RanchPriceGold  = 1000,                                  -- Or false to only use Ranch Document item
        TaxAmount       = 500,                                   -- Tax amount per cycle (overrides Config.TaxAmount)
        MenuLocation    = vec4(1375.58, -868.53, 70.11, 261.57), -- Menu and NPC Location
        MaxAnimals      = 50,                                    -- Maximum animals in this ranch (only works if Config.MaxAnimalsToAll = false)
        Stash           = {
            weight = 1000,                                       -- maximum stash weight (RSG framework only)
            slots  = 300,                                        -- maximum stash item slots (RSG framework only)
        },
        Animals         = {
            Cattle = {
                Menu = vec4(1426.12, -860.87, 60.02, 197.10), -- local prompt/store
                Area = {
                    vec3(1420.2460, -861.8268, 60.3583),
                    vec3(1417.3029, -861.8004, 60.5747),
                    vec3(1411.1887, -863.7844, 61.7456),
                    vec3(1408.6819, -865.2233, 62.1762),
                    vec3(1406.8751, -865.8474, 62.4700),
                    vec3(1408.0426, -868.0735, 62.3124),
                    vec3(1410.1539, -879.9647, 62.3178),
                    vec3(1410.2208, -882.9565, 62.0582),
                    vec3(1411.2100, -887.0161, 61.7721),
                    vec3(1412.5959, -890.4382, 61.6100),
                    vec3(1413.7162, -892.6920, 61.5345),
                    vec3(1417.8447, -897.9349, 61.1274),
                    vec3(1419.0966, -899.3197, 61.0178),
                    vec3(1422.2643, -900.7581, 60.3360),
                    vec3(1427.3921, -902.0106, 59.0842),
                    vec3(1429.6720, -902.4371, 58.3595),
                    vec3(1441.8400, -912.1610, 55.8275),
                    vec3(1449.9020, -918.5565, 54.1886),
                    vec3(1455.8087, -922.8178, 53.1801),
                    vec3(1459.5410, -925.1000, 52.6070),
                    vec3(1461.8981, -926.4785, 52.3136),
                    vec3(1465.9768, -928.7973, 52.1306),
                    vec3(1467.5702, -928.3427, 51.9565),
                    vec3(1469.2476, -925.4700, 51.6527),
                    vec3(1470.3044, -921.9064, 51.7520),
                    vec3(1471.1761, -919.5473, 51.9358),
                    vec3(1472.8766, -914.7448, 52.1698),
                    vec3(1474.2203, -911.3786, 52.9245),
                    vec3(1475.2980, -907.3473, 53.3072),
                    vec3(1476.4637, -903.6509, 53.6451),
                    vec3(1477.8149, -899.3122, 53.6651),
                    vec3(1477.6046, -895.3574, 53.7091),
                    vec3(1476.1346, -890.0635, 53.7329),
                    vec3(1474.9460, -885.6351, 53.9167),
                    vec3(1473.5796, -881.3208, 54.0654),
                    vec3(1470.3064, -869.8976, 53.8541),
                    vec3(1467.7628, -861.4362, 53.6137),
                    vec3(1465.3137, -861.5670, 53.7847),
                    vec3(1461.2013, -861.7753, 54.2681),
                    vec3(1458.0531, -861.9806, 54.6042),
                    vec3(1453.0685, -862.1886, 55.1363),
                    vec3(1448.6858, -861.8520, 55.8271),
                    vec3(1445.9160, -861.6785, 56.3719),
                    vec3(1443.7782, -861.5648, 56.7984),
                    vec3(1440.4735, -861.7410, 57.5875),
                    vec3(1437.7676, -861.8137, 58.0848),
                    vec3(1434.9445, -862.1259, 58.7552),
                    vec3(1431.9414, -861.9513, 59.4393),
                },
            },
            Goats = {
                Menu = vec4(1425.03, -853.66, 59.82, 176.75), -- local prompt/store
                Area = {
                    vec3(1425.0883, -852.6486, 59.8704),
                    vec3(1422.2539, -852.9055, 60.3299),
                    vec3(1418.8684, -853.0745, 61.0034),
                    vec3(1416.4802, -853.3008, 61.3512),
                    vec3(1413.9481, -853.5256, 61.7547),
                    vec3(1411.0011, -853.8681, 62.2462),
                    vec3(1404.7820, -856.3443, 63.4856),
                    vec3(1403.6632, -855.4879, 63.9161),
                    vec3(1402.4777, -852.2556, 64.5981),
                    vec3(1401.5171, -849.9109, 65.3789),
                    vec3(1399.7646, -844.6846, 65.6592),
                    vec3(1400.3292, -838.6288, 65.2190),
                    vec3(1400.0576, -835.8280, 65.1165),
                    vec3(1398.9291, -831.2087, 64.9661),
                    vec3(1399.3080, -827.4720, 64.2863),
                    vec3(1401.1805, -825.2994, 63.4278),
                    vec3(1402.9447, -823.8258, 62.6659),
                    vec3(1407.5022, -820.1221, 61.0979),
                    vec3(1412.4956, -819.4385, 60.1667),
                    vec3(1418.4128, -819.7628, 58.9681),
                    vec3(1423.5426, -820.0456, 57.9475),
                    vec3(1431.5382, -819.8812, 56.5018),
                    vec3(1437.0559, -820.2324, 55.8012),
                    vec3(1443.6296, -820.2008, 54.8004),
                    vec3(1454.4708, -819.7601, 53.3481),
                    vec3(1456.1154, -824.4296, 53.1333),
                    vec3(1457.7935, -830.9328, 52.7552),
                    vec3(1459.4630, -836.6354, 52.9487),
                    vec3(1461.4419, -842.9429, 53.5261),
                    vec3(1463.8069, -848.6879, 53.5406),
                    vec3(1465.6764, -852.2101, 53.5644),
                    vec3(1460.1307, -853.1204, 54.0764),
                    vec3(1455.0186, -853.3681, 54.7765),
                    vec3(1448.9045, -853.8438, 55.6862),
                    vec3(1443.5540, -853.3381, 56.6478),
                    vec3(1437.1622, -852.7715, 58.3375),
                    vec3(1432.9506, -852.7316, 59.1488),
                },
            },
            Sheep = {
                Menu = vec4(1399.00, -844.20, 65.76, 269.49), -- local prompt/store
                Area = {
                    vec3(1425.0883, -852.6486, 59.8704),
                    vec3(1422.2539, -852.9055, 60.3299),
                    vec3(1418.8684, -853.0745, 61.0034),
                    vec3(1416.4802, -853.3008, 61.3512),
                    vec3(1413.9481, -853.5256, 61.7547),
                    vec3(1411.0011, -853.8681, 62.2462),
                    vec3(1404.7820, -856.3443, 63.4856),
                    vec3(1403.6632, -855.4879, 63.9161),
                    vec3(1402.4777, -852.2556, 64.5981),
                    vec3(1401.5171, -849.9109, 65.3789),
                    vec3(1399.7646, -844.6846, 65.6592),
                    vec3(1400.3292, -838.6288, 65.2190),
                    vec3(1400.0576, -835.8280, 65.1165),
                    vec3(1398.9291, -831.2087, 64.9661),
                    vec3(1399.3080, -827.4720, 64.2863),
                    vec3(1401.1805, -825.2994, 63.4278),
                    vec3(1402.9447, -823.8258, 62.6659),
                    vec3(1407.5022, -820.1221, 61.0979),
                    vec3(1412.4956, -819.4385, 60.1667),
                    vec3(1418.4128, -819.7628, 58.9681),
                    vec3(1423.5426, -820.0456, 57.9475),
                    vec3(1431.5382, -819.8812, 56.5018),
                    vec3(1437.0559, -820.2324, 55.8012),
                    vec3(1443.6296, -820.2008, 54.8004),
                    vec3(1454.4708, -819.7601, 53.3481),
                    vec3(1456.1154, -824.4296, 53.1333),
                    vec3(1457.7935, -830.9328, 52.7552),
                    vec3(1459.4630, -836.6354, 52.9487),
                    vec3(1461.4419, -842.9429, 53.5261),
                    vec3(1463.8069, -848.6879, 53.5406),
                    vec3(1465.6764, -852.2101, 53.5644),
                    vec3(1460.1307, -853.1204, 54.0764),
                    vec3(1455.0186, -853.3681, 54.7765),
                    vec3(1448.9045, -853.8438, 55.6862),
                    vec3(1443.5540, -853.3381, 56.6478),
                    vec3(1437.1622, -852.7715, 58.3375),
                    vec3(1432.9506, -852.7316, 59.1488),
                },
            },
            Horse = {
                Menu = vec4(1385.04, -848.16, 68.58, 45.94), -- local prompt/store
                Area = {
                    vec3(1384.7822, -847.3231, 69.3170),
                    vec3(1379.2408, -850.0211, 69.0934),
                    vec3(1377.2588, -850.5459, 69.4247),
                    vec3(1376.7540, -848.9954, 69.7159),
                    vec3(1375.0627, -847.4374, 70.1133),
                    vec3(1373.9598, -847.5970, 70.3293),
                    vec3(1372.5426, -848.6359, 70.4861),
                    vec3(1372.7373, -851.2297, 70.0578),
                    vec3(1371.9879, -851.6207, 70.1783),
                    vec3(1371.5966, -852.7527, 70.1904),
                    vec3(1369.1705, -853.6502, 70.5017),
                    vec3(1365.1219, -851.2869, 70.8219),
                    vec3(1363.9667, -848.3952, 70.8987),
                    vec3(1363.2502, -844.8498, 70.9706),
                    vec3(1364.2740, -844.6266, 70.9717),
                    vec3(1366.4565, -843.2615, 70.9787),
                    vec3(1369.5366, -841.6843, 70.9414),
                    vec3(1373.0402, -839.9637, 70.8967),
                    vec3(1375.9620, -838.4497, 70.3935),
                    vec3(1375.8691, -836.1674, 70.4562),
                    vec3(1374.9766, -833.3497, 71.0130),
                    vec3(1378.6625, -831.3488, 70.8894),
                    vec3(1381.8612, -829.5262, 70.3765),
                    vec3(1384.1309, -828.3870, 70.2542),
                    vec3(1387.2008, -826.9174, 69.6052),
                    vec3(1390.1083, -826.6765, 69.0954),
                    vec3(1390.9729, -828.8921, 68.6018),
                    vec3(1391.5654, -830.4200, 68.2422),
                    vec3(1388.3992, -832.2527, 68.7260),
                    vec3(1386.9060, -832.6631, 68.8889),
                    vec3(1388.0271, -836.3995, 68.4388),
                    vec3(1390.4500, -842.1057, 68.4257),
                    vec3(1388.7361, -844.5225, 68.6266),
                    vec3(1386.8544, -845.8588, 68.6479),
                },
            },
        },
    },

    [19] = {                                                      -- Ranch ID
        RanchName       = 'Abandoned Ranch',                      -- Ranch Name if you want to use in prompt
        Job             = false,                                  -- Or false 1.5.1
        JobOwnerGrade   = 3,                                      -- Job Owner Grade/Max Job Grade 1.5.1
        RanchPriceMoney = 1000,                                   -- Or false to only use Ranch Document item
        RanchPriceGold  = 1000,                                   -- Or false to only use Ranch Document item
        TaxAmount       = 500,                                    -- Tax amount per cycle (overrides Config.TaxAmount)
        MenuLocation    = vec4(1934.33, -1886.47, 41.76, 358.46), -- Menu and NPC Location
        MaxAnimals      = 50,                                     -- Maximum animals in this ranch (only works if Config.MaxAnimalsToAll = false)
        Stash           = {
            weight = 1000,                                        -- maximum stash weight (RSG framework only)
            slots  = 300,                                         -- maximum stash item slots (RSG framework only)
        },
        Animals         = {
            Poultry = {
                Menu = vec4(1940.99, -1875.08, 41.98, 84.58), -- local prompt/store
                Prop = true,
                Area = {
                    vec3(1942.9443, -1880.6790, 42.0585),
                    vec3(1935.8043, -1877.5995, 41.8436),
                    vec3(1937.8470, -1870.0671, 41.7790),
                    vec3(1943.8606, -1871.7395, 41.9398),
                    vec3(1945.7329, -1875.0291, 41.9796),
                },
            },
        },
    },

    [20] = {                                                    -- Ranch ID
        RanchName       = 'Other Farm Near blackwater marsh',   -- Ranch Name if you want to use in prompt
        Job             = false,                                -- Or false 1.5.1
        JobOwnerGrade   = 3,                                    -- Job Owner Grade/Max Job Grade 1.5.1
        RanchPriceMoney = 1000,                                 -- Or false to only use Ranch Document item
        RanchPriceGold  = 1000,                                 -- Or false to only use Ranch Document item
        TaxAmount       = 500,                                  -- Tax amount per cycle (overrides Config.TaxAmount)
        MenuLocation    = vec4(1811.75, -54.45, 57.64, 147.02), -- Menu and NPC Location
        MaxAnimals      = 50,                                   -- Maximum animals in this ranch (only works if Config.MaxAnimalsToAll = false)
        Stash           = {
            weight = 1000,                                      -- maximum stash weight (RSG framework only)
            slots  = 300,                                       -- maximum stash item slots (RSG framework only)
        },
        Animals         = {
            Swine = {
                Menu = vec4(1817.40, -52.12, 57.94, 154.46), -- local prompt/store
                Area = {
                    vec3(1818.3105, -51.6720, 57.8709),
                    vec3(1818.7908, -52.1126, 57.9213),
                    vec3(1820.7556, -52.9137, 58.0262),
                    vec3(1823.6190, -53.6202, 58.2762),
                    vec3(1826.0875, -52.0829, 58.0922),
                    vec3(1827.9000, -50.8103, 57.8201),
                    vec3(1830.6006, -47.6195, 58.1544),
                    vec3(1828.8525, -45.7133, 58.0857),
                    vec3(1827.5775, -42.9265, 58.3439),
                    vec3(1825.3474, -40.6927, 58.4739),
                    vec3(1822.2253, -41.7711, 58.3815),
                    vec3(1819.2875, -43.7516, 58.4031),
                    vec3(1815.2977, -45.9276, 59.1902),
                    vec3(1816.6293, -48.6448, 58.2703),
                },
            },
        },
    },

    [21] = {                                                     -- Ranch ID
        RanchName       = 'Orange Farm',                         -- Ranch Name if you want to use in prompt
        Job             = false,                                 -- Or false 1.5.1
        JobOwnerGrade   = 3,                                     -- Job Owner Grade/Max Job Grade 1.5.1
        RanchPriceMoney = 1000,                                  -- Or false to only use Ranch Document item
        RanchPriceGold  = 1000,                                  -- Or false to only use Ranch Document item
        TaxAmount       = 500,                                   -- Tax amount per cycle (overrides Config.TaxAmount)
        MenuLocation    = vec4(2065.13, -823.25, 42.67, 163.16), -- Menu and NPC Location
        MaxAnimals      = 50,                                    -- Maximum animals in this ranch (only works if Config.MaxAnimalsToAll = false)
        Stash           = {
            weight = 1000,                                       -- maximum stash weight (RSG framework only)
            slots  = 300,                                        -- maximum stash item slots (RSG framework only)
        },
        Animals         = {
            Poultry = {
                Menu = vec4(2071.98, -836.27, 42.80, 246.26), -- local prompt/store
                Prop = true,
                Area = {
                    vec3(2070.2952, -838.6068, 42.8127),
                    vec3(2069.1223, -836.0143, 42.7844),
                    vec3(2069.1689, -833.5823, 42.7239),
                    vec3(2072.6902, -831.9305, 42.6091),
                    vec3(2078.0640, -833.7395, 42.3290),
                    vec3(2077.5579, -837.8208, 42.5002),
                    vec3(2073.5913, -840.5212, 42.6902),
                },
            },
        },
    },

    [22] = {                                                      -- Ranch ID
        RanchName       = 'Big Valley Ranch',                     -- Ranch Name if you want to use in prompt
        Job             = false,                                  -- Or false 1.5.1
        JobOwnerGrade   = 3,                                      -- Job Owner Grade/Max Job Grade 1.5.1
        RanchPriceMoney = 1000,                                   -- Or false to only use Ranch Document item
        RanchPriceGold  = 1000,                                   -- Or false to only use Ranch Document item
        TaxAmount       = 500,                                    -- Tax amount per cycle (overrides Config.TaxAmount)
        MenuLocation    = vec4(-2587.94, 409.76, 148.97, 124.75), -- Menu and NPC Location
        MaxAnimals      = 50,                                     -- Maximum animals in this ranch (only works if Config.MaxAnimalsToAll = false)
        Stash           = {
            weight = 1000,                                        -- maximum stash weight (RSG framework only)
            slots  = 300,                                         -- maximum stash item slots (RSG framework only)
        },
        Animals         = {
            Cattle = {
                Menu = vec4(-2552.82, 424.61, 147.92, 250.64), -- local prompt/store
                Area = {
                    vec3(-2551.6277, 420.6328, 148.4147),
                    vec3(-2551.5979, 424.1428, 148.0647),
                    vec3(-2551.8899, 431.3492, 147.3638),
                    vec3(-2545.7615, 431.4375, 147.5935),
                    vec3(-2542.6111, 431.4962, 147.6854),
                    vec3(-2534.6357, 431.7574, 147.7083),
                    vec3(-2534.9255, 427.1631, 147.7397),
                    vec3(-2534.7229, 420.7648, 147.9481),
                    vec3(-2534.8391, 416.5331, 148.2197),
                    vec3(-2534.8320, 412.6248, 148.3150),
                    vec3(-2534.7800, 405.9601, 148.2518),
                    vec3(-2539.8342, 405.8922, 148.3445),
                    vec3(-2548.8389, 405.9881, 148.3091),
                    vec3(-2559.0850, 406.0814, 148.3589),
                    vec3(-2558.5217, 410.1206, 148.4876),
                    vec3(-2558.7930, 416.7871, 148.6355),
                    vec3(-2553.0432, 416.7323, 148.6165),
                },
            },

            Sheep = {
                Menu = vec4(-2548.00, 447.68, 146.71, 175.76), -- local prompt/store
                Area = {
                    vec3(-2542.3455, 446.5916, 146.7302),
                    vec3(-2535.0547, 446.7397, 146.6869),
                    vec3(-2534.7700, 443.8008, 146.6029),
                    vec3(-2534.9131, 440.2940, 146.9282),
                    vec3(-2534.9575, 432.7925, 147.6944),
                    vec3(-2538.1196, 432.4852, 147.6400),
                    vec3(-2545.0789, 432.5224, 147.5568),
                    vec3(-2551.8743, 432.3475, 147.3343),
                    vec3(-2551.7686, 437.5787, 146.9997),
                    vec3(-2551.8076, 446.7697, 146.4381),
                },
            },
            Goats = {
                Menu = vec4(-2547.21, 474.07, 143.40, 203.74), -- local prompt/store
                Area = {
                    vec3(-2545.2712, 473.1686, 143.3490),
                    vec3(-2543.9199, 474.3281, 143.2833),
                    vec3(-2539.7021, 475.5394, 143.2721),
                    vec3(-2533.5554, 476.3788, 143.2372),
                    vec3(-2525.8081, 476.3099, 143.3620),
                    vec3(-2523.6436, 473.8224, 143.7047),
                    vec3(-2523.0359, 469.8927, 144.0057),
                    vec3(-2522.9727, 462.4665, 144.7828),
                    vec3(-2522.9856, 458.5909, 145.2636),
                    vec3(-2523.1855, 454.4969, 145.9183),
                    vec3(-2523.3215, 447.8996, 146.9426),
                    vec3(-2526.3689, 447.7616, 146.9031),
                    vec3(-2531.8572, 447.9683, 146.5678),
                    vec3(-2541.2715, 447.7995, 146.7040),
                    vec3(-2551.8145, 447.5017, 146.3598),
                    vec3(-2551.8066, 450.5501, 146.2706),
                    vec3(-2551.8867, 461.3303, 144.6964),
                    vec3(-2551.9822, 468.7406, 143.9205),
                },
            },
            Horse = {
                Menu = vec4(-2526.77, 404.90, 148.58, 168.80), -- local prompt/store
                Area = {
                    vec3(-2526.4282, 405.9347, 148.5761),
                    vec3(-2533.9092, 405.9435, 148.2886),
                    vec3(-2533.6614, 418.3899, 148.0778),
                    vec3(-2533.7031, 428.3971, 147.7768),
                    vec3(-2533.5916, 435.3611, 147.4748),
                    vec3(-2533.8777, 446.9559, 146.6583),
                    vec3(-2527.0920, 446.8610, 147.0086),
                    vec3(-2515.3438, 447.0767, 147.2729),
                    vec3(-2515.5208, 441.2827, 147.6998),
                    vec3(-2516.7998, 441.0050, 147.7245),
                    vec3(-2516.6711, 410.3994, 147.9687),
                    vec3(-2515.8347, 406.2051, 148.2828),
                    vec3(-2519.1516, 406.1259, 148.3767),
                },
            },
        },
    },

    [23] = {                                                    -- Ranch ID
        RanchName       = 'South Field Flats Ranch',            -- Ranch Name if you want to use in prompt
        Job             = false,                                -- Or false 1.5.1
        JobOwnerGrade   = 3,                                    -- Job Owner Grade/Max Job Grade 1.5.1
        RanchPriceMoney = 1000,                                 -- Or false to only use Ranch Document item
        RanchPriceGold  = 1000,                                 -- Or false to only use Ranch Document item
        TaxAmount       = 500,                                  -- Tax amount per cycle (overrides Config.TaxAmount)
        MenuLocation    = vec4(1129.34, -977.57, 68.82, 46.59), -- Menu and NPC Location
        MaxAnimals      = 50,                                   -- Maximum animals in this ranch (only works if Config.MaxAnimalsToAll = false)
        Stash           = {
            weight = 1000,                                      -- maximum stash weight (RSG framework only)
            slots  = 300,                                       -- maximum stash item slots (RSG framework only)
        },
        Animals         = {
            Poultry = {
                Menu = vec4(1146.25, -977.56, 68.14, 31.97), -- local prompt/store
                Prop = true,
                Area = {
                    vec3(1144.3678, -977.6532, 68.1020),
                    vec3(1137.9286, -973.8510, 68.2501),
                    vec3(1136.1819, -971.6428, 68.3943),
                    vec3(1139.7401, -963.9033, 68.1127),
                    vec3(1148.4038, -970.2963, 67.5998),
                    vec3(1146.6624, -974.5363, 67.8392),
                },
            },
        },
    },

    [24] = {                                                     -- Ranch ID
        RanchName       = 'Farm Near Rhodes',                    -- Ranch Name if you want to use in prompt
        Job             = false,                                 -- Or false 1.5.1
        JobOwnerGrade   = 3,                                     -- Job Owner Grade/Max Job Grade 1.5.1
        RanchPriceMoney = 1000,                                  -- Or false to only use Ranch Document item
        RanchPriceGold  = 1000,                                  -- Or false to only use Ranch Document item
        TaxAmount       = 500,                                   -- Tax amount per cycle (overrides Config.TaxAmount)
        MenuLocation    = vec4(1471.63, -1589.34, 72.32, 98.22), -- Menu and NPC Location
        MaxAnimals      = 50,                                    -- Maximum animals in this ranch (only works if Config.MaxAnimalsToAll = false)
        Stash           = {
            weight = 1000,                                       -- maximum stash weight (RSG framework only)
            slots  = 300,                                        -- maximum stash item slots (RSG framework only)
        },
        Animals         = {
            Poultry = {
                Menu = vec4(1467.73, -1579.59, 72.03, 159.01), -- local prompt/store
                Prop = true,
                Area = {
                    vec3(1467.7573, -1579.6287, 72.0278),
                    vec3(1470.6356, -1582.6240, 72.1810),
                    vec3(1471.8616, -1586.3989, 72.2487),
                    vec3(1467.6931, -1589.9949, 72.2028),
                    vec3(1462.0614, -1588.9308, 71.8312),
                    vec3(1460.2396, -1585.9115, 71.8385),
                    vec3(1463.1183, -1579.4769, 71.8427),
                },
            },
        },
    },

    [25] = {                                                     -- Ranch ID
        RanchName       = 'Eris field Farm',                     -- Ranch Name if you want to use in prompt
        Job             = false,                                 -- Or false 1.5.1
        JobOwnerGrade   = 3,                                     -- Job Owner Grade/Max Job Grade 1.5.1
        RanchPriceMoney = 1000,                                  -- Or false to only use Ranch Document item
        RanchPriceGold  = 1000,                                  -- Or false to only use Ranch Document item
        TaxAmount       = 500,                                   -- Tax amount per cycle (overrides Config.TaxAmount)
        MenuLocation    = vec4(1263.38, -412.17, 97.63, 172.18), -- Menu and NPC Location
        MaxAnimals      = 50,                                    -- Maximum animals in this ranch (only works if Config.MaxAnimalsToAll = false)
        Stash           = {
            weight = 1000,                                       -- maximum stash weight (RSG framework only)
            slots  = 300,                                        -- maximum stash item slots (RSG framework only)
        },
        Animals         = {
            Cattle = {
                Menu = vec4(1240.99, -389.17, 97.67, 285.45), -- local prompt/store
                Area = {
                    vec3(1240.3676, -389.1700, 97.6790),
                    vec3(1231.0083, -382.1659, 97.4943),
                    vec3(1220.4427, -374.1846, 97.0140),
                    vec3(1214.5184, -370.1418, 97.0967),
                    vec3(1207.4855, -366.3859, 97.1539),
                    vec3(1195.0106, -360.1950, 96.9501),
                    vec3(1185.7377, -371.3186, 95.0576),
                    vec3(1176.8419, -384.6845, 94.9272),
                    vec3(1166.7469, -398.4888, 93.7699),
                    vec3(1165.0494, -402.5484, 93.1699),
                    vec3(1163.5729, -405.4806, 92.5521),
                    vec3(1159.9980, -409.9020, 91.7413),
                    vec3(1156.0725, -414.0372, 91.7716),
                    vec3(1153.1550, -421.0323, 91.8693),
                    vec3(1147.3616, -429.5559, 92.4184),
                    vec3(1144.7465, -434.0244, 92.9983),
                    vec3(1149.1960, -438.8081, 91.7386),
                    vec3(1157.2618, -442.9388, 90.0769),
                    vec3(1161.9651, -445.3788, 89.4480),
                    vec3(1169.0653, -449.1068, 87.9898),
                    vec3(1175.6072, -453.3061, 86.3106),
                    vec3(1178.0430, -454.8175, 85.9925),
                    vec3(1188.5149, -458.9632, 86.0261),
                    vec3(1194.8176, -461.0794, 85.9145),
                    vec3(1199.7656, -457.8874, 86.6602),
                    vec3(1202.1375, -454.2559, 87.4990),
                    vec3(1205.0526, -449.7286, 88.5804),
                    vec3(1210.7286, -440.8757, 90.3045),
                    vec3(1214.6038, -434.3043, 91.0920),
                    vec3(1218.9279, -426.4674, 92.0316),
                    vec3(1224.4329, -417.1371, 93.1911),
                    vec3(1230.8201, -405.7034, 95.5087),
                    vec3(1235.3708, -397.5423, 96.6628),
                },
            },
        },
    },

    [26] = {                                                    -- Ranch ID
        RanchName       = 'Emerald Ranch',                      -- Ranch Name if you want to use in prompt
        Job             = false,                                -- Or false 1.5.1
        JobOwnerGrade   = 3,                                    -- Job Owner Grade/Max Job Grade 1.5.1
        RanchPriceMoney = 1000,                                 -- Or false to only use Ranch Document item
        RanchPriceGold  = 1000,                                 -- Or false to only use Ranch Document item
        TaxAmount       = 250,                                  -- Tax amount per cycle (overrides Config.TaxAmount)
        MenuLocation    = vec4(1407.82, 273.06, 89.53, 279.71), -- Menu and NPC Location
        MaxAnimals      = 50,                                   -- Maximum animals in this ranch (only works if Config.MaxAnimalsToAll = false)
        Stash           = {
            weight = 1000,                                      -- maximum stash weight (RSG framework only)
            slots  = 300,                                       -- maximum stash item slots (RSG framework only)
        },
        Animals         = {
            Cattle  = {
                Menu = vec4(1381.79, 305.18, 88.00, 2.22), -- local prompt/store for this type
                Area = {
                    vec3(1371.5966, 301.6320, 87.9491),
                    vec3(1380.8038, 303.6070, 88.0743),
                    vec3(1387.8149, 305.0924, 88.0241),
                    vec3(1396.3186, 307.1705, 88.3752),
                    vec3(1402.8903, 308.4716, 88.2433),
                    vec3(1409.3744, 310.2354, 88.3517),
                    vec3(1414.9908, 311.4365, 88.5364),
                    vec3(1416.1754, 305.2666, 88.5669),
                    vec3(1417.7992, 297.9180, 88.7971),
                    vec3(1418.9923, 291.7664, 89.1898),
                    vec3(1421.4247, 283.0134, 89.4740),
                    vec3(1418.8065, 282.0932, 89.4860),
                    vec3(1417.7411, 283.4858, 89.4788),
                    vec3(1412.1200, 281.7767, 89.4438),
                    vec3(1398.1971, 277.8712, 89.3612),
                    vec3(1391.9689, 279.8518, 88.9408),
                    vec3(1378.6528, 276.5755, 89.0521),
                    vec3(1375.5940, 288.0482, 88.3944),
                }, -- pasture polygon
            },
            Goats   = {
                Menu = vec4(1364.80, 301.37, 87.79, 354.52), -- local prompt/store for this type
                Area = {
                    vec3(1370.6073, 301.5626, 87.9498),
                    vec3(1374.0979, 290.4608, 88.2907),
                    vec3(1377.1334, 277.2347, 89.0338),
                    vec3(1367.1139, 272.8376, 88.9980),
                    vec3(1361.9556, 272.8476, 88.6277),
                    vec3(1360.1221, 280.8166, 88.5293),
                    vec3(1358.6223, 290.1350, 88.2437),
                    vec3(1356.9517, 298.3522, 87.8763),
                }, -- pasture polygon
            },
            Swine   = {
                Menu = vec4(1362.29, 311.70, 87.52, 190.68), -- local prompt/store for this type
                Area = {
                    vec3(1367.1577, 314.0962, 87.5268),
                    vec3(1362.5106, 313.1633, 87.5923),
                    vec3(1356.5508, 311.9655, 87.6549),
                    vec3(1355.3156, 316.6706, 87.8132),
                    vec3(1353.8894, 323.0142, 87.8453),
                    vec3(1355.3760, 327.7957, 87.9077),
                    vec3(1358.2982, 336.2512, 88.1500),
                    vec3(1361.8591, 338.6728, 88.2393),
                    vec3(1363.0461, 332.6387, 87.9611),
                    vec3(1365.4244, 321.5186, 87.6008),
                }, -- pasture polygon
            },
            Sheep   = {
                Menu = vec4(1374.36, 314.99, 87.79, 194.93), -- local prompt/store for this type
                Area = {
                    vec3(1367.9047, 314.3414, 87.5219),
                    vec3(1366.2943, 322.0037, 87.5775),
                    vec3(1364.5249, 330.2814, 87.7802),
                    vec3(1363.1837, 337.4564, 88.1858),
                    vec3(1361.5222, 345.7801, 88.3676),
                    vec3(1371.5575, 348.1938, 88.2249),
                    vec3(1372.9298, 343.9847, 88.1046),
                    vec3(1373.8363, 339.5677, 88.0472),
                    vec3(1376.3193, 329.5978, 87.9960),
                    vec3(1377.2456, 324.4185, 88.0366),
                    vec3(1379.5486, 316.7476, 88.0334),
                    vec3(1376.6700, 316.3455, 87.9527),
                }, -- pasture polygon
            },
            Poultry = {
                Menu = vec4(1393.83, 276.16, 89.05, 276.99), -- local prompt/store for this type
                Prop = false,                                -- if false dont have a CoopChoop Prop
                Area = {
                    vec3(1378.6078, 275.5057, 89.2385),
                    vec3(1384.2516, 276.6015, 88.5334),
                    vec3(1392.1116, 278.5229, 89.0226),
                    vec3(1393.4349, 272.3438, 89.1340),
                    vec3(1395.2070, 264.8291, 89.3937),
                    vec3(1385.4523, 259.5056, 89.7348),
                    vec3(1382.7294, 259.0805, 90.0390),
                    vec3(1379.4142, 271.7975, 89.6623),
                }, -- pasture polygon
            },
            Horse   = {
                Menu = vec4(1391.62, 319.38, 87.76, 25.18),
                Area = {
                    vec3(1420.9053, 326.4368, 88.5260),
                    vec3(1409.5756, 323.9306, 88.2592),
                    vec3(1399.4896, 321.8213, 88.0115),
                    vec3(1392.1394, 321.2648, 87.8143),
                    vec3(1389.9436, 323.8056, 87.8497),
                    vec3(1379.3309, 321.2123, 87.8886),
                    vec3(1377.8403, 327.9634, 88.0862),
                    vec3(1375.4358, 337.3034, 88.0071),
                    vec3(1373.8040, 344.7955, 88.0968),
                    vec3(1381.6670, 347.8154, 87.6462),
                    vec3(1386.9631, 347.2914, 87.5641),
                    vec3(1390.2780, 345.6934, 87.5670),
                    vec3(1393.8954, 348.0048, 87.5819),
                    vec3(1397.0294, 351.3820, 87.6075),
                    vec3(1402.5466, 353.0305, 87.6548),
                    vec3(1408.2576, 355.0472, 88.1852),
                    vec3(1414.0096, 347.8289, 88.1533),
                    vec3(1421.4478, 338.0944, 88.3324),
                    vec3(1421.3406, 331.6719, 88.5061),
                },
            },
            Turkey  = {
                Menu = vec4(1433.68, 379.57, 89.19, 168.97),
                Area = {
                    vec3(1431.8226, 359.0782, 88.9663),
                    vec3(1440.6376, 359.3710, 88.5567),
                    vec3(1440.6272, 382.2759, 89.4733),
                    vec3(1439.9750, 386.6425, 89.6133),
                    vec3(1437.2838, 384.2489, 89.4080),
                    vec3(1434.4938, 379.0661, 89.1799),
                    vec3(1432.6937, 374.2845, 89.1072),
                    vec3(1431.8655, 368.0884, 89.0930),
                    vec3(1431.2753, 362.7563, 88.9751),
                },
            },

        },
    },
}
