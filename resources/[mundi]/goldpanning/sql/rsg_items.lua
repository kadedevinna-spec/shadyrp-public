-- ===============================================
-- GOLD PANNING - RSG FRAMEWORK ITEMS
-- ===============================================
-- Author: Mundi
-- Description: Items configuration for RSG Framework (rsg-core)
-- 
-- INSTALLATION INSTRUCTIONS:
-- 1. Open: resources/[framework]/rsg-core/shared/items.lua
-- 2. Find the RSGShared.Items = { section
-- 3. Copy ALL the items below (between the START and END markers)
-- 4. Paste them inside your RSGShared.Items table
-- 5. Save the file and restart your server
--
-- IMAGES:
-- Copy the images from goldpanning/html/img/items/ to:
-- resources/[inventory]/rsg-inventory/html/images/
-- ===============================================

--[[
-- ============ START COPYING HERE ============

    -- ===============================================
    -- GOLD PANNING ITEMS - Tools
    -- ===============================================
    
    ['goldpan'] = {
        name = 'goldpan',
        label = 'Gold Pan',
        weight = 500,
        type = 'item',
        image = 'goldpan.png',
        unique = false,
        useable = true,
        shouldClose = true,
        combinable = nil,
        description = 'A metal pan used for separating gold from river sediment.',
        decay = 10080, -- 7 days
        delete = false
    },

    ['p_goldcradlestand01x'] = {
        name = 'p_goldcradlestand01x',
        label = 'Gold Wash Cradle',
        weight = 5000,
        type = 'item',
        image = 'p_goldcradlestand01x.png',
        unique = false,
        useable = true,
        shouldClose = true,
        combinable = nil,
        description = 'A wooden cradle used for washing gold from sediment. Place near water to use.'
    },

    -- ===============================================
    -- GOLD PANNING ITEMS - Water & Sediment
    -- ===============================================

    ['bucket'] = {
        name = 'bucket',
        label = 'Empty Bucket',
        weight = 300,
        type = 'item',
        image = 'bucket.png',
        unique = false,
        useable = true,
        shouldClose = true,
        combinable = nil,
        description = 'An empty bucket. Use near water to fill it.'
    },

    ['fullbucket'] = {
        name = 'fullbucket',
        label = 'Water Bucket',
        weight = 1500,
        type = 'item',
        image = 'fullbucket.png',
        unique = false,
        useable = false,
        shouldClose = true,
        combinable = nil,
        description = 'A bucket filled with fresh water.'
    },

    ['mud_bucket'] = {
        name = 'mud_bucket',
        label = 'Mud Bucket',
        weight = 400,
        type = 'item',
        image = 'mud_bucket.png',
        unique = false,
        useable = true,
        shouldClose = true,
        combinable = nil,
        description = 'A sturdy bucket for collecting river sediment.'
    },

    ['river_sediment'] = {
        name = 'river_sediment',
        label = 'River Sediment',
        weight = 100,
        type = 'item',
        image = 'river_sediment.png',
        unique = false,
        useable = false,
        shouldClose = true,
        combinable = nil,
        description = 'Sediment collected from a riverbed.'
    },

    -- ===============================================
    -- GOLD PANNING ITEMS - Rewards
    -- ===============================================

    ['gold_flakes'] = {
        name = 'gold_flakes',
        label = 'Gold Flakes',
        weight = 50,
        type = 'item',
        image = 'gold_flakes.png',
        unique = false,
        useable = false,
        shouldClose = true,
        combinable = nil,
        description = 'Tiny flakes of gold.'
    },

    ['gold_nugget'] = {
        name = 'gold_nugget',
        label = 'Gold Nugget',
        weight = 200,
        type = 'item',
        image = 'gold_nugget.png',
        unique = false,
        useable = false,
        shouldClose = true,
        combinable = nil,
        description = 'A solid gold nugget! A rare and valuable find.'
    },

-- ============ STOP COPYING HERE ============
]]

-- ===============================================
-- CONFIGURATION REFERENCE
-- ===============================================
-- These items correspond to config.lua settings:
--
-- Config.cradleProp      = "p_goldcradlestand01x"  -- Placeable cradle
-- Config.waterItem       = "fullbucket"            -- Full water bucket
-- Config.emptyWaterItem  = "bucket"                -- Empty bucket
-- Config.sedimentItem    = "river_sediment"        -- River sediment
-- Config.mudBucketItem   = "mud_bucket"            -- Mud bucket for collecting
-- Config.goldPanItem     = "goldpan"               -- Gold pan tool
-- Config.goldReward      = "gold_flakes"           -- Gold flakes reward
-- Config.extraReward     = "gold_nugget"           -- Gold nugget reward (rare)
--
-- ===============================================
-- REQUIRED IMAGES (copy to rsg-inventory/html/images/)
-- ===============================================
-- goldpan.png
-- p_goldcradlestand01x.png
-- bucket.png
-- fullbucket.png
-- mud_bucket.png
-- river_sediment.png
-- gold_flakes.png
-- gold_nugget.png
--
-- ===============================================
-- TOTAL ITEMS: 8
-- ===============================================
