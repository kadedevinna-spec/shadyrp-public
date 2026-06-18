MGuard.Teleports = {
    -- Categories for organization
    Categories = { 'Towns', 'Camps', 'Shops', 'Nature', 'Special' },

    -- Preset locations
    Locations = {
        -- ═══════════════════ TOWNS ═══════════════════
        { name = 'Valentine',         category = 'Towns', x = -279.40, y = 791.37, z = 118.40 },
        { name = 'Rhodes',            category = 'Towns', x = 1293.51, y = -1306.06, z = 76.90 },
        { name = 'Strawberry',        category = 'Towns', x = -1790.60, y = -378.35, z = 160.10 },
        { name = 'Blackwater',        category = 'Towns', x = -813.18, y = -1282.80, z = 43.26 },
        { name = 'Saint Denis',       category = 'Towns', x = 2650.12, y = -1279.70, z = 46.24 },
        { name = 'Annesburg',         category = 'Towns', x = 2929.30, y = 1326.48, z = 44.62 },
        { name = 'Van Horn',          category = 'Towns', x = 2994.90, y = 561.20, z = 44.58 },
        { name = 'Tumbleweed',        category = 'Towns', x = -5510.80, y = -2938.30, z = -1.62 },
        { name = 'Armadillo',         category = 'Towns', x = -3653.17, y = -2597.78, z = -13.67 },
        { name = 'Emerald Ranch',     category = 'Towns', x = 1434.54, y = 327.19, z = 87.93 },
        { name = 'Lagras',            category = 'Towns', x = 2121.30, y = -610.77, z = 42.10 },
        { name = 'Butcher Creek',     category = 'Towns', x = 2564.03, y = 846.71, z = 81.31 },
        { name = 'Colter',            category = 'Towns', x = -1362.40, y = 2399.87, z = 307.86 },
        { name = 'Wapiti',            category = 'Towns', x = 523.84, y = 2228.70, z = 244.40 },
        { name = 'Benedict Point',    category = 'Towns', x = -5292.50, y = -3625.70, z = -23.89 },

        -- ═══════════════════ CAMPS ═══════════════════
        { name = 'Horseshoe Overlook',  category = 'Camps', x = 427.89, y = 495.94, z = 107.30 },
        { name = 'Clemens Point',       category = 'Camps', x = 1535.82, y = -1160.50, z = 71.50 },
        { name = 'Shady Belle',         category = 'Camps', x = 2234.76, y = -1155.22, z = 44.12 },
        { name = 'Lakay',              category = 'Camps', x = 1963.21, y = -704.50, z = 41.88 },
        { name = 'Beaver Hollow',      category = 'Camps', x = 2194.54, y = 689.23, z = 99.88 },
        { name = 'Pronghorn Ranch',    category = 'Camps', x = -2355.70, y = -780.70, z = 147.44 },
        { name = 'Beechers Hope',      category = 'Camps', x = -1619.94, y = -1416.53, z = 81.98 },
        { name = 'Manzanita Post',     category = 'Camps', x = -2146.17, y = -1483.87, z = 104.30 },
        { name = 'Adler Ranch',        category = 'Camps', x = -1375.95, y = 2397.38, z = 311.74 },
        { name = 'MacFarlanes Ranch',  category = 'Camps', x = -2310.80, y = -2418.00, z = 61.12 },

        -- ═══════════════════ SHOPS ═══════════════════
        { name = 'General Store (Valentine)',   category = 'Shops', x = -312.19, y = 766.87, z = 117.66 },
        { name = 'General Store (Rhodes)',      category = 'Shops', x = 1288.94, y = -1286.37, z = 76.90 },
        { name = 'General Store (Strawberry)',  category = 'Shops', x = -1792.15, y = -384.35, z = 160.88 },
        { name = 'General Store (Blackwater)',  category = 'Shops', x = -781.68, y = -1311.29, z = 43.98 },
        { name = 'General Store (Saint Denis)', category = 'Shops', x = 2571.04, y = -1137.16, z = 46.49 },
        { name = 'Tailor (Saint Denis)',        category = 'Shops', x = 2558.50, y = -1153.79, z = 46.27 },
        { name = 'Gunsmith (Valentine)',        category = 'Shops', x = -289.39, y = 750.42, z = 117.31 },
        { name = 'Gunsmith (Saint Denis)',      category = 'Shops', x = 2607.35, y = -1221.43, z = 53.36 },
        { name = 'Doctor (Valentine)',          category = 'Shops', x = -282.59, y = 803.57, z = 118.71 },
        { name = 'Doctor (Saint Denis)',        category = 'Shops', x = 2725.72, y = -1224.89, z = 49.86 },
        { name = 'Stables (Valentine)',         category = 'Shops', x = -360.54, y = 775.27, z = 116.03 },
        { name = 'Stables (Blackwater)',        category = 'Shops', x = -860.14, y = -1336.89, z = 43.51 },
        { name = 'Fence (Emerald Ranch)',       category = 'Shops', x = 1574.14, y = 319.50, z = 89.98 },
        { name = 'Fence (Saint Denis)',         category = 'Shops', x = 2665.50, y = -1247.50, z = 46.24 },
        { name = 'Barber (Saint Denis)',        category = 'Shops', x = 2647.90, y = -1165.50, z = 46.24 },

        -- ═══════════════════ NATURE ═══════════════════
        { name = 'Owanjila Dam',       category = 'Nature', x = -1566.54, y = -49.50, z = 133.40 },
        { name = 'Donner Falls',       category = 'Nature', x = -1009.73, y = 1679.64, z = 190.92 },
        { name = 'Elysian Pool',       category = 'Nature', x = 1694.73, y = 658.93, z = 74.26 },
        { name = 'Moonstone Pond',     category = 'Nature', x = 1101.20, y = 1695.37, z = 189.68 },
        { name = 'Lake Isabella',      category = 'Nature', x = -772.51, y = 1846.99, z = 196.00 },
        { name = 'Lake Owanjila',      category = 'Nature', x = -1681.97, y = -244.46, z = 110.97 },
        { name = 'Flat Iron Lake',     category = 'Nature', x = 1185.26, y = -1716.98, z = 43.00 },
        { name = 'Aurora Basin',       category = 'Nature', x = -2558.05, y = -1131.87, z = 86.51 },
        { name = 'Dakota River',       category = 'Nature', x = -577.20, y = 471.00, z = 97.14 },
        { name = 'Kamassa River',      category = 'Nature', x = 2470.85, y = 195.10, z = 62.95 },

        -- ═══════════════════ SPECIAL ═══════════════════
        { name = 'Sisika Penitentiary',  category = 'Special', x = 3366.44, y = -640.68, z = 40.55 },
        { name = 'Guarma Beach',         category = 'Special', x = 1303.32, y = -6925.15, z = 43.61 },
        { name = 'Braithwaite Manor',    category = 'Special', x = 1037.86, y = -1701.94, z = 46.48 },
        { name = 'Cornwall Kerosene',    category = 'Special', x = -286.50, y = 676.41, z = 113.89 },
        { name = 'Hanging Dog Ranch',    category = 'Special', x = -2068.14, y = 461.43, z = 141.18 },
        { name = 'Fort Wallace',         category = 'Special', x = 665.28, y = 1517.24, z = 199.40 },
        { name = 'Fort Mercer',          category = 'Special', x = -4152.10, y = -3098.58, z = 16.64 },
        { name = 'Thieves Landing',      category = 'Special', x = -1453.35, y = -2090.56, z = 41.60 },
        { name = 'Annesburg Mine',       category = 'Special', x = 2857.84, y = 1312.82, z = 44.62 },
        { name = 'Limpany Ruins',        category = 'Special', x = -248.44, y = 572.65, z = 109.86 },
    },
}
