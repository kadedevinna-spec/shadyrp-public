Config.BlastMiningEnabled = true
Config.NetworkRockProps = false -- If true, the rock props will be networked to all players, but fill up networked object pool

Config.DynamiteForJobOnly = false -- If true, the player will only be able to use the dynamite if they have one of the configred jobs in config.lua.
Config.DynamiteAroundMinesOnly = true -- If true, the player will only be able to use the dynamite if they are around a mine
Config.DynamiteItem = "miningdynamite" -- This item will give the player a dynamite weapon & ammo, and set it to weak, you can not use this and just use the dynamite weapon and ammo item in the framework.
Config.DynamtieItemCount = 3 -- The amount of dynamite to give the player per item use. 8 is the max

Config.DynamiteCrateItem = "miningdynamitecrate" -- This is the item that will be used to blow up the rocks, you can use any item you want, but it must be a weapon item.
Config.CrateProp = "p_dynamitecrate02x"
Config.MiningDynamiteCrateCount = 10 -- The number of dynamite sticks a crate can hold
Config.MiningDynamiteCrateInteractDistance = 1.5 -- The distance to interact with the crate, you can set this to 1.0 to make it harder to use, or 3.0 to make it easier.

Config.DynamiteDamageModifier = 0.05 -- This is the damage modifier for the dynamite, you can set it to as low as 0.05 to make it weak, or 1.0 to make it normal, or any other value you want.
Config.ExplosionTypes = { -- The types of explosion to detect for, Checkout https://github.com/femga/rdr3_discoveries/tree/master/graphics/explosions add and remove whatever you want
    [25] = 2.0,     -- [Explosion type] = Explosion radius -- Regular Dynamite
    [26] = 10.0,    -- Dynamite Bundle/Stack
    [27] = 2.0,     -- Volatile Dynamite
    [31] = 2.0,     -- Dynamite Arrow
}

Config.RockDespawnTime = 300 -- The time in seconds for the rocks to despawn after being blown up

Config.BlastMining = {
    ["Tumbleweed Gold Mine"] = { 
        multiplier = 1.0, 
        breakAmount = 10,
        PropAmount = math.random(10, 30),
        RockProps = {
            ["s_rock_beechers_02"] = 0.3,
            ["roa_rock_scree_sim_10"] = 0.3,
            ["roa_rock_scree_sim_11"] = 0.2,
            ["p_coalpile01x"] = 0.2
        }
    },
    ["Annesburg Coal Mine"] = { 
        multiplier = 1.3, 
        breakAmount = 10,
        PropAmount = 20,
        RockProps = {
            ["s_rock_beechers_02"] = 0.3,
            ["roa_rock_scree_sim_10"] = 0.3,
            ["roa_rock_scree_sim_11"] = 0.2,
            ["p_coalpile01x"] = 0.2
        }
    },
    ["Butcher's Creek Abandoned Mine"] = { 
        multiplier = 1.0, 
        breakAmount = 10,
        PropAmount = math.random(10, 30),
        RockProps = {
            ["s_rock_beechers_02"] = 0.3,
            ["roa_rock_scree_sim_10"] = 0.3,
            ["roa_rock_scree_sim_11"] = 0.2,
            ["p_coalpile01x"] = 0.2
        }
    },
    ["Devil's Cave"] = { 
        multiplier = 1.0, 
        breakAmount = 10,
        PropAmount = math.random(10, 30),
        RockProps = {
            ["s_rock_beechers_02"] = 0.3,
            ["roa_rock_scree_sim_10"] = 0.3,
            ["roa_rock_scree_sim_11"] = 0.2,
            ["p_coalpile01x"] = 0.2
        }
    },
    ["Northpoint Mine"] = { 
        multiplier = 1.0, 
        breakAmount = 10,
        PropAmount = math.random(10, 30),
        RockProps = {
            ["s_rock_beechers_02"] = 0.3,
            ["roa_rock_scree_sim_10"] = 0.3,
            ["roa_rock_scree_sim_11"] = 0.2,
            ["p_coalpile01x"] = 0.2
        }
    },
    ["Mount Shann Cave"] = { 
        multiplier = 1.0, 
        breakAmount = 10,
        PropAmount = math.random(10, 30),
        RockProps = {
            ["s_rock_beechers_02"] = 0.3,
            ["roa_rock_scree_sim_10"] = 0.3,
            ["roa_rock_scree_sim_11"] = 0.2,
            ["p_coalpile01x"] = 0.2
        }
    },
    ["Beaver Hallow Cave"] = { 
        multiplier = 1.0, 
        breakAmount = 10,
        PropAmount = math.random(10, 30),
        RockProps = {
            ["s_rock_beechers_02"] = 0.3,
            ["roa_rock_scree_sim_10"] = 0.3,
            ["roa_rock_scree_sim_11"] = 0.2,
            ["p_coalpile01x"] = 0.2
        }
    },
    ["Twin Rocks Gang Camp"] = { 
        multiplier = 1.0, 
        breakAmount = 10,
        PropAmount = math.random(10, 30),
        RockProps = {
            ["s_rock_beechers_02"] = 0.3,
            ["roa_rock_scree_sim_10"] = 0.3,
            ["roa_rock_scree_sim_11"] = 0.2,
            ["p_coalpile01x"] = 0.2
        }
    },
    ["Zirkel Cave"] = { 
        multiplier = 1.0, 
        breakAmount = 10,
        PropAmount = math.random(10, 30),
        RockProps = {
            ["s_rock_beechers_02"] = 0.3,
            ["roa_rock_scree_sim_10"] = 0.3,
            ["roa_rock_scree_sim_11"] = 0.2,
            ["p_coalpile01x"] = 0.2
        }
    },
    ["Dinosaur Cave"] = { 
        multiplier = 1.0, 
        breakAmount = 10,
        PropAmount = math.random(10, 30),
        RockProps = {
            ["s_rock_beechers_02"] = 0.3,
            ["roa_rock_scree_sim_10"] = 0.3,
            ["roa_rock_scree_sim_11"] = 0.2,
            ["p_coalpile01x"] = 0.2
        }
    },
    ["Giantman's Cave"] = { 
        multiplier = 1.0, 
        breakAmount = 10,
        PropAmount = math.random(10, 30),
        RockProps = {
            ["s_rock_beechers_02"] = 0.3,
            ["roa_rock_scree_sim_10"] = 0.3,
            ["roa_rock_scree_sim_11"] = 0.2,
            ["p_coalpile01x"] = 0.2
        }
    },
    ["Heartlands Oil pit"] = { 
        multiplier = 1.0, 
        breakAmount = 10,
        PropAmount = math.random(10, 30),
        RockProps = {
            ["s_rock_beechers_02"] = 0.3,
            ["roa_rock_scree_sim_10"] = 0.3,
            ["roa_rock_scree_sim_11"] = 0.2,
            ["p_coalpile01x"] = 0.2
        }
    },
    ["Bacchus Ridge Cave"] = { 
        multiplier = 1.0, 
        breakAmount = 10,
        PropAmount = math.random(10, 30),
        RockProps = {
            ["p_rockthrow02x"] = 0.5,
            ["bgv_rock_scree_sim_10"] = 0.3,
            ["bgv_rock_scree_sim_11"] = 0.2,
        }
    },
    ["Mount Shann Collapsed Mine"] = { 
        multiplier = 1.0, 
        breakAmount = 10,
        PropAmount = math.random(10, 30),
        RockProps = {
            ["s_rock_beechers_02"] = 0.3,
            ["roa_rock_scree_sim_10"] = 0.3,
            ["roa_rock_scree_sim_11"] = 0.2,
            ["p_coalpile01x"] = 0.2
        }
    },
    ["Guarma Cave"] = { 
        multiplier = 1.0, 
        breakAmount = 10,
        PropAmount = math.random(10, 30),
        RockProps = {
            ["s_rock_beechers_02"] = 0.3,
            ["roa_rock_scree_sim_10"] = 0.3,
            ["roa_rock_scree_sim_11"] = 0.2,
            ["p_coalpile01x"] = 0.2
        }
    },
    ['Montana River Shore'] = { 
        multiplier = 1.0, 
        breakAmount = 10,
        PropAmount = math.random(10, 30),
        RockProps = {
            ["s_rock_beechers_02"] = 0.3,
            ["roa_rock_scree_sim_10"] = 0.3,
            ["roa_rock_scree_sim_11"] = 0.2,
            ["p_coalpile01x"] = 0.2
        }
    },
}