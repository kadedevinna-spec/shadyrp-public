-- ═══════════════════════════════════════════════════════════════════════════
-- M-Deliveries VORP Framework Items
-- ═══════════════════════════════════════════════════════════════════════════
--
-- Run these SQL queries in your database to register the items for VORP.
-- 
-- NOTE: cured_hemp, moonshine_original, moonshine_blueflame, and moonshine_red
-- may already exist if you have other scripts (e.g. fx-moonshinev2).
-- Check your `items` table before running to avoid duplicate key errors.
--
-- You can use: SELECT * FROM items WHERE item LIKE 'delivery_%' OR item IN ('crated','cured_hemp','moonshine_original','moonshine_blueflame','moonshine_red');
-- to check what already exists.
-- ═══════════════════════════════════════════════════════════════════════════

--- ═══════════════════════════════════════════════════════════════
-- DELIVERY ITEMS FOR VORP INVENTORY
-- ═══════════════════════════════════════════════════════════════
-- All items use the naming scheme: delivery_<item_name>
-- Run these INSERT statements to add delivery items to your database

-- ─────────── LEGAL CRATES ───────────
INSERT INTO `items` (`item`, `label`, `limit`, `can_remove`, `type`, `usable`, `desc`) VALUES
('delivery_package_small', 'Small Delivery Crate', 500, 1, 'item_standard', 1, 'A small wooden crate containing goods for delivery.'),
('delivery_package_medium', 'Medium Delivery Crate', 500, 1, 'item_standard', 1, 'A medium-sized wooden crate containing goods for delivery.'),
('delivery_package_large', 'Large Delivery Crate', 500, 1, 'item_standard', 1, 'A large wooden crate containing goods for delivery.'),
('delivery_package_big', 'Special Delivery Crate', 500, 1, 'item_standard', 1, 'A special large crate containing valuable goods for delivery.')
ON DUPLICATE KEY UPDATE `limit` = 500, `usable` = 1;

-- ─────────── AGRICULTURAL GOODS ───────────
INSERT INTO `items` (`item`, `label`, `limit`, `can_remove`, `type`, `usable`, `desc`) VALUES
('delivery_sugar_sack', 'Sugar Sack', 500, 1, 'item_standard', 1, 'A heavy burlap sack filled with refined sugar.'),
('delivery_grain_sack', 'Grain Sack', 500, 1, 'item_standard', 1, 'A burlap sack filled with harvested grain.')
ON DUPLICATE KEY UPDATE `limit` = 500, `usable` = 1;

-- ─────────── BARRELS ───────────
INSERT INTO `items` (`item`, `label`, `limit`, `can_remove`, `type`, `usable`, `desc`) VALUES
('delivery_barrel', 'Delivery Barrel', 500, 1, 'item_standard', 1, 'A sturdy wooden barrel for transporting liquids or goods.'),
('delivery_oil_barrel', 'Oil Barrel', 500, 1, 'item_standard', 1, 'A sealed barrel containing crude oil or petroleum.')
ON DUPLICATE KEY UPDATE `limit` = 500, `usable` = 1;

-- ─────────── ILLEGAL CONTRABAND ───────────
INSERT INTO `items` (`item`, `label`, `limit`, `can_remove`, `type`, `usable`, `desc`) VALUES
('delivery_moonshine_crate', 'Moonshine Crate', 500, 1, 'item_standard', 1, 'A crate of illegally distilled moonshine bottles. Handle with care.'),
('delivery_hemp_crate', 'Hemp Crate', 500, 1, 'item_standard', 1, 'A crate containing bundles of hemp.')
ON DUPLICATE KEY UPDATE `limit` = 500, `usable` = 1;

-- ─────────── UTILITY ITEMS ───────────
-- Empty crate: combined with hemp/moonshine elsewhere to create delivery crates
INSERT INTO `items` (`item`, `label`, `limit`, `can_remove`, `type`, `usable`, `desc`) VALUES
('crated', 'Empty Crate', 500, 1, 'item_standard', 1, 'An empty wooden crate. Can be packed with contraband for smuggling.')
ON DUPLICATE KEY UPDATE `limit` = 500, `usable` = 1;

-- ─────────── SMUGGLING MATERIALS (player-provided items) ───────────
-- These may already exist from other scripts, just change the item names
-- Check your items table before running to avoid issues
INSERT INTO `items` (`item`, `label`, `limit`, `can_remove`, `type`, `usable`, `desc`) VALUES
('cured_hemp', 'Cured Hemp', 500, 1, 'item_standard', 0, 'Dried and cured hemp, ready for transport.'),
('moonshine_original', 'Moonshine Original', 500, 1, 'item_standard', 1, 'A bottle of original moonshine.'),
('moonshine_blueflame', 'Moonshine Blueflame', 500, 1, 'item_standard', 1, 'A bottle of strong blue flame moonshine.'),
('moonshine_red', 'Moonshine Red', 500, 1, 'item_standard', 1, 'A bottle of premium red moonshine.')
ON DUPLICATE KEY UPDATE `limit` = 500;

-- ─────────── REPAIR MATERIALS (used by Config.WagonRepair) ───────────
-- These may already exist from other scripts — check before adding!
INSERT INTO `items` (`item`, `label`, `limit`, `can_remove`, `type`, `usable`, `desc`) VALUES
('wood_plank', 'Wood Plank', 500, 1, 'item_standard', 0, 'A sturdy wooden plank, useful for repairs.'),
('nails', 'Nails', 500, 1, 'item_standard', 0, 'A handful of iron nails for construction and repairs.')
ON DUPLICATE KEY UPDATE `limit` = 500;
