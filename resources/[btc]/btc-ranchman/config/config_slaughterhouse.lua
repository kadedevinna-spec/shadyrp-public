Config.Slaughterhouse = {
    Enable = true,                                -- if true the Slaughterhouse will be available
    BlipModel = 'blip_mp_game_animal_protection', -- Or false to not show the blip
    MaxAnimalDistace = 10,
    Locations = {
        SaintDenis = {
            Label = 'Saint Denis Slaughterhouse',
            Coords = vec4(2340.08, -1433.21, 45.56, 356.67),
            NpcModel = 'a_m_m_nbxdockworkers_01',
            NpcOutfit = 1,
        },

        EmeraldRanch = {
            Label = 'EmeraldRanch Slaughterhouse',
            Coords = vec4(1430.47, 269.85, 90.08, 67.02),
            NpcModel = 'a_m_m_nbxdockworkers_01',
            NpcOutfit = 1,
        },
    },

    Slaughter = {
        Cattle = {
            Male = {
                SlaughterRequirements = {
                    Weight = 1,
                    Health = 1,
                    Fertility = 0,
                    Age = 1,
                },
                Rewards = {
                    Items = { { item = 'cowmeat', amount = 5 } }, -- or false for none
                    Money = 100,                                  -- or false for none
                },
            },
            Female = {
                SlaughterRequirements = {
                    Weight = 200,
                    Health = 100,
                    Fertility = 0,
                    Age = 5,
                },
                Rewards = {
                    Items = { { item = 'beef', amount = 10 }, { item = 'milk', amount = 1 } }, -- or false for none
                    Money = 80,                                                                -- or false for none
                },
            },
        },

        -- ── Custom animals ────────────────────────────────────────
        Turkey = {
            Male = {
                SlaughterRequirements = { Weight = 5, Health = 50, Fertility = 0, Age = 0 },
                Rewards = { Items = { { item = 'turkey_meat', amount = 3 } }, Money = 10 },
            },
            Female = {
                SlaughterRequirements = { Weight = 4, Health = 50, Fertility = 0, Age = 0 },
                Rewards = { Items = { { item = 'turkey_meat', amount = 2 } }, Money = 8 },
            },
        },

    }
}
