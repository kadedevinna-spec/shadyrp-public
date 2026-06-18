-- ============================================================================
-- M-RAIDS — VORP ITEMS
-- ============================================================================
-- Run this file if you are using VORP (vorp_core + vorp_inventory).
-- Schema: vorp_inventory `items` table
--   item, label, limit, can_remove, type, usable, desc
-- ============================================================================
-- If these items already exist in your database use UPDATE or skip the line.
-- To check first:
--   SELECT * FROM items WHERE item IN
--   ('intel_folder','route_plans','dynamite','moneybag','goldbar','lockpick',
--    'crim_raid_torn_map','crim_raid_doolin_will','crim_raid_mining_records',
--    'crim_raid_explosives_high','crim_raid_fort_mercer_schedule',
--    'crim_raid_prototype_order','crim_raid_limpany_ledger',
--    'crim_raid_fort_wallace_schedule','crim_raid_kelly_letter',
--    'crim_raid_shipping_ledger','crim_raid_burned_letter',
--    'crim_raid_braithwaite_key');
-- ============================================================================

-- ============================================================================
-- FENCE TRADE ITEMS
-- ============================================================================

-- Intelligence Folder (dropped from fort raids, traded with fences)
INSERT INTO `items` (`item`, `label`, `limit`, `can_remove`, `type`, `usable`, `desc`) VALUES
('intel_folder', 'Intelligence Folder', 10, 1, 'item_standard', 0, 'Military intelligence gathered from a raid.');

-- Route Plans (received from fence, used to start bank wagon robbery)
INSERT INTO `items` (`item`, `label`, `limit`, `can_remove`, `type`, `usable`, `desc`) VALUES
('route_plans', 'Bank Wagon Route Plans', 5, 1, 'item_standard', 1, 'Detailed plans showing a bank wagon route.');

-- ============================================================================
-- ROBBERY TOOLS
-- ============================================================================

-- Dynamite (required to blow open the bank wagon)
INSERT INTO `items` (`item`, `label`, `limit`, `can_remove`, `type`, `usable`, `desc`) VALUES
('dynamite', 'Dynamite', 10, 1, 'item_standard', 0, 'A stick of dynamite. Handle with extreme care.');

-- Lockpick (used in chest minigames)
INSERT INTO `items` (`item`, `label`, `limit`, `can_remove`, `type`, `usable`, `desc`) VALUES
('lockpick', 'Lockpick', 10, 1, 'item_standard', 0, 'A slender tool for picking locks.');

-- ============================================================================
-- LOOT ITEMS
-- ============================================================================

-- Money Bag (dropped from exploded wagon)
INSERT INTO `items` (`item`, `label`, `limit`, `can_remove`, `type`, `usable`, `desc`) VALUES
('moneybag', 'Money Bag', 50, 1, 'item_standard', 0, 'A bag stuffed with cash. The fruits of a successful heist.');

-- Gold Bar (dropped from exploded wagon)
INSERT INTO `items` (`item`, `label`, `limit`, `can_remove`, `type`, `usable`, `desc`) VALUES
('goldbar', 'Gold Bar', 20, 1, 'item_standard', 0, 'A solid gold bar.');

-- ============================================================================
-- RAID COLLECTIBLE / INTEL ITEMS
-- ============================================================================

INSERT INTO `items` (`item`, `label`, `limit`, `can_remove`, `type`, `usable`, `desc`) VALUES
('crim_raid_torn_map',              'Torn Map',                                    25, 1, 'item_standard', 0, 'A ripped map that seems to lead to a long abandoned mine.'),
('crim_raid_doolin_will',           'Grady Doolin''s Last Will & Testament',       25, 1, 'item_standard', 0, 'A partially destroyed document.'),
('crim_raid_mining_records',        'Black Heaths Mining Records',                 25, 1, 'item_standard', 0, 'A record detailing an abandoned mine up north.'),
('crim_raid_explosives_high',       'High Quality Explosives',                     25, 1, 'item_standard', 0, 'A bundle of mining charges.'),
('crim_raid_fort_mercer_schedule',  'Fort Mercer Shift Schedule',                  25, 1, 'item_standard', 0, 'A shift schedule for Fort Mercer.'),
('crim_raid_prototype_order',       'Prototype Weapon Parts Order',                25, 1, 'item_standard', 0, 'An order requesting prototype weapon shipments.'),
('crim_raid_limpany_ledger',        'Limpany Sheriff''s Office Contraband Ledger', 25, 1, 'item_standard', 0, 'A full ledger of confiscated evidence logs.'),
('crim_raid_fort_wallace_schedule', 'USMO Fort Wallace Schedule',                  25, 1, 'item_standard', 0, 'A USMO shift schedule — valuable intel.'),
('crim_raid_kelly_letter',          'Marshal M. Kelly''s Letter',                  25, 1, 'item_standard', 0, 'A letter from Marshal Kelly detailing contraband movements.'),
('crim_raid_shipping_ledger',       'Red Star Line Shipping Ledger',               25, 1, 'item_standard', 0, 'A ledger for a classified delivery at Saint Denis docks.'),
('crim_raid_burned_letter',         'A Letter Partly Burned',                      25, 1, 'item_standard', 0, 'A letter detailing a shady deal between local officials and the Braithwaites.'),
('crim_raid_braithwaite_key',       'Braithwaite Key',                             25, 1, 'item_standard', 0, 'A key engraved with the Braithwaite family crest.');
