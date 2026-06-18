-- ===============================================
-- M-BACKPACKS - RSG INVENTORY ITEMS
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
-- Copy the backpack images to:
-- resources/[inventory]/rsg-inventory/html/images/
-- 
-- You can use these free backpack images or create your own:
-- - backpack_tier1.png (small satchel)
-- - backpack_tier2.png (medium leather backpack)
-- - backpack_tier3.png (large rucksack)
-- ===============================================

--[[
-- ============ START COPYING HERE ============

    -- ===============================================
    -- M-BACKPACKS ITEMS
    -- ===============================================
    
    ['backpack_tier1'] = {
        name = 'backpack_tier1',
        label = 'Small Backpack',
        weight = 500,
        type = 'item',
        image = 'backpack_tier1.png',
        unique = true,
        useable = true,
        shouldClose = true,
        combinable = nil,
        description = 'A small worn satchel with limited storage. Use to open.',
        decay = nil,
        delete = false
    },

    ['backpack_tier2'] = {
        name = 'backpack_tier2',
        label = 'Medium Backpack',
        weight = 750,
        type = 'item',
        image = 'backpack_tier2.png',
        unique = true,
        useable = true,
        shouldClose = true,
        combinable = nil,
        description = 'A sturdy leather backpack with decent storage. Use to open.',
        decay = nil,
        delete = false
    },

    ['backpack_tier3'] = {
        name = 'backpack_tier3',
        label = 'Large Backpack',
        weight = 1000,
        type = 'item',
        image = 'backpack_tier3.png',
        unique = true,
        useable = true,
        shouldClose = true,
        combinable = nil,
        description = 'A spacious rucksack for serious travelers. Use to open.',
        decay = nil,
        delete = false
    },

-- ============ END COPYING HERE ============
]]

-- ===============================================
-- RSG INVENTORY DATABASE TABLE
-- ===============================================
-- RSG-Inventory uses the 'inventories' table for stashes
-- This table should already exist if you have rsg-inventory installed
-- If not, run the following SQL:

/*
CREATE TABLE IF NOT EXISTS `inventories` (
    `identifier` varchar(255) NOT NULL,
    `items` longtext DEFAULT NULL,
    PRIMARY KEY (`identifier`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
*/
