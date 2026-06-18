-- ╔═══════════════════════════════════════════════════════════════╗
-- ║           M-NOTEBOOKS - DATABASE SETUP                        ║
-- ║                                                               ║
-- ║  Run this SQL in your database before starting the resource   ║
-- ╚═══════════════════════════════════════════════════════════════╝

-- ═══════════════════════════════════════════════════════════════
-- NOTEBOOKS TABLE
-- Stores each player's notebook data
-- ═══════════════════════════════════════════════════════════════

CREATE TABLE IF NOT EXISTS `m_notebooks` (
    `id` int(11) NOT NULL AUTO_INCREMENT,
    `identifier` varchar(50) NOT NULL,
    `charid` int(11) NOT NULL,
    `charname` varchar(100) NOT NULL DEFAULT 'Unknown',
    `title` varchar(100) NOT NULL DEFAULT 'My Notebook',
    `cover_date` varchar(100) NOT NULL DEFAULT 'Est. 1899',
    `total_pages` int(11) NOT NULL DEFAULT 100,
    `pages_data` LONGTEXT DEFAULT '[]',
    `address_snapshot` LONGTEXT DEFAULT '[]',
    `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (`id`),
    KEY `idx_owner` (`identifier`, `charid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ═══════════════════════════════════════════════════════════════
-- MIGRATION: Add address_snapshot column for existing tables
-- Safe to run multiple times — does nothing if column exists
-- ═══════════════════════════════════════════════════════════════

SET @dbname = DATABASE();
SET @tablename = 'm_notebooks';
SET @columnname = 'address_snapshot';
SET @preparedStatement = (SELECT IF(
    (SELECT COUNT(*) FROM INFORMATION_SCHEMA.COLUMNS
     WHERE TABLE_SCHEMA = @dbname AND TABLE_NAME = @tablename AND COLUMN_NAME = @columnname) > 0,
    'SELECT 1',
    CONCAT('ALTER TABLE `', @tablename, '` ADD COLUMN `', @columnname, '` LONGTEXT DEFAULT ''[]'' AFTER `pages_data`')
));
PREPARE stmt FROM @preparedStatement;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

-- ═══════════════════════════════════════════════════════════════
-- PINNED NOTES TABLE
-- Stores notes pinned to walls in the world
-- ═══════════════════════════════════════════════════════════════

CREATE TABLE IF NOT EXISTS `m_notebook_pinned` (
    `id` int(11) NOT NULL AUTO_INCREMENT,
    `identifier` varchar(50) NOT NULL,
    `charid` int(11) NOT NULL,
    `author_name` varchar(100) NOT NULL DEFAULT 'Unknown',
    `text` TEXT DEFAULT '',
    `image_url` varchar(500) DEFAULT '',
    `font` varchar(50) DEFAULT 'Caveat',
    `color` varchar(20) DEFAULT '#1a1a1a',
    `x` float NOT NULL DEFAULT 0,
    `y` float NOT NULL DEFAULT 0,
    `z` float NOT NULL DEFAULT 0,
    `rot_pitch` float NOT NULL DEFAULT 0,
    `rot_roll` float NOT NULL DEFAULT 0,
    `rot_yaw` float NOT NULL DEFAULT 0,
    `drawings_data` LONGTEXT DEFAULT '[]',
    `page_content` LONGTEXT DEFAULT NULL,
    `expired` tinyint(1) NOT NULL DEFAULT 0,
    `expires_at` datetime DEFAULT NULL,
    `pinned_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (`id`),
    KEY `idx_pinned_owner` (`identifier`),
    KEY `idx_pinned_active` (`expired`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


-- ═══════════════════════════════════════════════════════════════
-- INVENTORY ITEMS FOR VORP INVENTORY
-- Run these to add the required items to your server
-- ═══════════════════════════════════════════════════════════════

-- Notebook Item
INSERT INTO `items` (`item`, `label`, `limit`, `can_remove`, `type`, `usable`, `desc`) VALUES
('notebook', 'Notebook', 500, 1, 'item_standard', 1, 'A leather bound personal notebook for writing notes and stories.')
ON DUPLICATE KEY UPDATE `label` = VALUES(`label`), `limit` = VALUES(`limit`), `can_remove` = VALUES(`can_remove`), `type` = VALUES(`type`), `usable` = VALUES(`usable`), `desc` = VALUES(`desc`);

-- Pen Item
INSERT INTO `items` (`item`, `label`, `limit`, `can_remove`, `type`, `usable`, `desc`) VALUES
('pen', 'Pen', 500, 1, 'item_standard', 0, 'A simple ink pen for writing.')
ON DUPLICATE KEY UPDATE `label` = VALUES(`label`), `limit` = VALUES(`limit`), `can_remove` = VALUES(`can_remove`), `type` = VALUES(`type`), `usable` = VALUES(`usable`), `desc` = VALUES(`desc`);

-- Torn Page Item (given when ripping, usable to view contents)
INSERT INTO `items` (`item`, `label`, `limit`, `can_remove`, `type`, `usable`, `desc`) VALUES
('torn_page', 'Torn Page', 500, 1, 'item_standard', 1, 'A page torn from a book')
ON DUPLICATE KEY UPDATE `label` = VALUES(`label`), `limit` = VALUES(`limit`), `can_remove` = VALUES(`can_remove`), `type` = VALUES(`type`), `usable` = VALUES(`usable`), `desc` = VALUES(`desc`);
