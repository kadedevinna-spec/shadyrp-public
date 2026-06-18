-- ===============================================
-- GOLD PANNING - VORP INVENTORY ITEMS
-- ===============================================
-- Author: Mundi
-- Description: SQL inserts for items required by the Gold Panning script
-- 
-- NOTE: Uses INSERT IGNORE to skip items that already exist in your database.
--       Existing items will NOT be modified.
-- ===============================================

-- ===============================================
-- TOOLS
-- ===============================================

-- Gold Pan (usable tool for panning)
INSERT IGNORE INTO `items` (`item`, `label`, `limit`, `can_remove`, `type`, `usable`, `desc`) VALUES
('goldpan', 'Gold Pan', 1, 1, 'item_standard', 1, 'A metal pan used for separating gold from river sediment.');

-- Gold Wash Cradle (placeable workstation)
INSERT IGNORE INTO `items` (`item`, `label`, `limit`, `can_remove`, `type`, `usable`, `desc`) VALUES
('p_goldcradlestand01x', 'Gold Wash Cradle', 1, 1, 'item_standard', 1, 'A wooden cradle used for washing gold from sediment. Place near water to use.');

-- ===============================================
-- WATER ITEMS
-- ===============================================

-- Empty Bucket (usable to collect water)
INSERT IGNORE INTO `items` (`item`, `label`, `limit`, `can_remove`, `type`, `usable`, `desc`) VALUES
('bucket', 'Empty Bucket', 5, 1, 'item_standard', 1, 'An empty bucket. Use near water to fill it.');

-- Full Bucket (water for the cradle)
INSERT IGNORE INTO `items` (`item`, `label`, `limit`, `can_remove`, `type`, `usable`, `desc`) VALUES
('fullbucket', 'Full Water Bucket', 5, 1, 'item_standard', 0, 'A bucket filled with water. Pour into a gold wash cradle.');

-- ===============================================
-- SEDIMENT ITEMS
-- ===============================================

-- Mud Bucket (usable to collect sediment)
INSERT IGNORE INTO `items` (`item`, `label`, `limit`, `can_remove`, `type`, `usable`, `desc`) VALUES
('mud_bucket', 'Mud Bucket', 1, 1, 'item_standard', 1, 'A sturdy bucket for collecting river sediment. Use near water to gather sediment.');

-- River Sediment (material collected from riverbed)
INSERT IGNORE INTO `items` (`item`, `label`, `limit`, `can_remove`, `type`, `usable`, `desc`) VALUES
('river_sediment', 'River Sediment', 50, 1, 'item_standard', 0, 'Sediment collected from a riverbed. May contain gold flakes.');

-- ===============================================
-- GOLD REWARDS
-- ===============================================

-- Gold Flakes (common reward)
INSERT IGNORE INTO `items` (`item`, `label`, `limit`, `can_remove`, `type`, `usable`, `desc`) VALUES
('gold_flakes', 'Gold Flakes', 100, 1, 'item_standard', 0, 'Tiny flakes of gold found while panning. Can be sold or refined.');

-- Gold Nugget (rare reward)
INSERT IGNORE INTO `items` (`item`, `label`, `limit`, `can_remove`, `type`, `usable`, `desc`) VALUES
('gold_nugget', 'Gold Nugget', 50, 1, 'item_standard', 0, 'A solid gold nugget! A rare and valuable find.');


-- ===============================================
-- ITEM CONFIGURATION REFERENCE
-- ===============================================
-- These are the config.lua item names and their purposes:
--
-- Config.cradleProp = "p_goldcradlestand01x"  -- Placeable cradle
-- Config.waterItem = "fullbucket"             -- Full water bucket (poured into cradle)
-- Config.emptyWaterItem = "bucket"            -- Empty bucket (used to collect water)
-- Config.sedimentItem = "river_sediment"      -- Sediment material (poured into cradle)
-- Config.mudBucketItem = "mud_bucket"         -- Bucket for collecting sediment
-- Config.goldPanItem = "goldpan"              -- Gold pan tool
-- Config.goldReward = "gold_flakes"           -- Gold flakes reward
-- Config.extraReward = "gold_nugget"          -- Gold nugget reward (rare)
--
-- ===============================================
-- TOTAL ITEMS: 8
-- ===============================================
