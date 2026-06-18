--------------------------------------------------------------------
-- btc-ranchman — Raid System / Threat Bar
-- Similar to Conan's "Purge": the bar grows over time.
-- When it reaches 100% with at least 1 owner/employee online,
-- a raid is triggered (bandits or wolves).
--------------------------------------------------------------------

Config.Raids = {
    Enabled = true,

    -- % of threat added on each chore loop tick
    -- (the interval is the same as Config.Chores.TickRateInMinutes)
    ThreatIncreasePerTick = 1,

    -- If true, the bar does not grow in ranches with no animals
    SkipIfNoAnimals = true,

    -- Available raid types.
    -- chance: relative probability of being chosen
    --         (e.g., 60 vs 40 = 60% bandits, 40% wolves)
    RaidTypes = {
        {
            name            = 'Bandits',
            chance          = 51,
            MinAttackers    = 3,
            MaxAttackers    = 6,
            Models          = {
                'g_m_m_unibanditos_01',
            },
            Weapons         = {
                'weapon_repeatercarabine',
                'weapon_revolver_cattleman',
            },
            SpawnRadius     = 80.0,     -- meters from the MenuLocation
            DurationSeconds = 300,      -- time limit to win (seconds)
        },
        {
            name            = 'Wolves',
            chance          = 49,
            MinAttackers    = 4,
            MaxAttackers    = 8,
            Models          = {
                'a_c_wolf',
            },
            Weapons         = nil,      -- wolves use natural attack
            SpawnRadius     = 60.0,
            DurationSeconds = 240,
        },
    },

    -- % chance per animal to die if the raid is not contained
    AnimalDeathChanceOnLoss = 25,

    -- Protection payment: spends ranch money to reduce the bar
    Protection = {
        Enabled        = true,
        CostPerPercent = 50,    -- ranch $ per 1% of bar reduction
        MinReduction   = 5,     -- minimum reduction per payment (%)
        MaxReduction   = 30,    -- maximum reduction per payment (%)
    },
}
