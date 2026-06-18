-------------------------------------------------------------------
-- VEHICLE PROPSETS (Native RDR2 Cargo Visuals)
-------------------------------------------------------------------

Config.VehiclePropsets = {
    
    -------------------------------------------------------------------
    -- logwagon (Standard Freight Wagon)
    -------------------------------------------------------------------
    supplywagon = {
        
        crates = {
            stages = {
                {amount = 0, value = -1},  -- Empty
                {amount = 1, value = "pg_teamster_supplywagon_gen"},  -- Light load
                {amount = 3, value = "pg_teamster_supplywagon_gen"},  -- Medium load
                {amount = 5, value = "pg_teamster_supplywagon_gen"},  -- Full load
            }
        },

    },
    

}