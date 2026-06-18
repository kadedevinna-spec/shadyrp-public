-- ===============================================
-- M-BACKPACKS - VORP INVENTORY ITEMS
-- ===============================================
-- Author: Mundi
-- Description: SQL inserts for backpack items (VORP Framework)
-- 
-- NOTE: Uses INSERT IGNORE to skip items that already exist in your database.
--       Existing items will NOT be modified.
-- ===============================================

-- ===============================================
-- BACKPACK ITEMS
-- ===============================================

-- Small Backpack (Tier 1)
INSERT IGNORE INTO `items` (`item`, `label`, `limit`, `can_remove`, `type`, `usable`, `desc`) VALUES
('backpack_tier1', 'Small Backpack', 1, 1, 'item_standard', 1, 'A small worn satchel with limited storage. Use to open.');

-- Medium Backpack (Tier 2)
INSERT IGNORE INTO `items` (`item`, `label`, `limit`, `can_remove`, `type`, `usable`, `desc`) VALUES
('backpack_tier2', 'Medium Backpack', 1, 1, 'item_standard', 1, 'A sturdy leather backpack with decent storage. Use to open.');

-- Large Backpack (Tier 3)
INSERT IGNORE INTO `items` (`item`, `label`, `limit`, `can_remove`, `type`, `usable`, `desc`) VALUES
('backpack_tier3', 'Large Backpack', 1, 1, 'item_standard', 1, 'A spacious rucksack for serious travelers. Use to open.');

-- ===============================================
-- OPTIONAL: CREATE BACKPACK STASH TABLE
-- (Only needed if you don't already have character_inventories table)
-- ===============================================

-- VORP typically uses character_inventories for custom containers
-- This table should already exist if you have vorp_inventory installed
-- If not, uncomment and run the following:

/*
CREATE TABLE IF NOT EXISTS `character_inventories` (
    `id` int(11) NOT NULL AUTO_INCREMENT,
    `character_id` int(11) DEFAULT NULL,
    `inventory_type` varchar(255) NOT NULL,
    `item` varchar(255) NOT NULL,
    `amount` int(11) NOT NULL DEFAULT 1,
    `metadata` longtext DEFAULT NULL,
    PRIMARY KEY (`id`),
    KEY `inventory_type` (`inventory_type`),
    KEY `character_id` (`character_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
*/
