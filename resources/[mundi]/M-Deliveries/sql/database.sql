-- ╔═══════════════════════════════════════════════════════════════╗
-- ║            M-DELIVERIES DATABASE SETUP                        ║
-- ╚═══════════════════════════════════════════════════════════════╝

-- ═══════════════════════════════════════════════════════════════
-- REPUTATION & STATS TABLES
-- ═══════════════════════════════════════════════════════════════

-- Smuggle Reputation Database Table
CREATE TABLE IF NOT EXISTS `smuggle_reputation` (
    `id` int(11) NOT NULL AUTO_INCREMENT,
    `identifier` varchar(100) NOT NULL,
    `npc_id` varchar(50) NOT NULL,
    `reputation` int(11) NOT NULL DEFAULT 0,
    `last_updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (`id`),
    UNIQUE KEY `unique_reputation` (`identifier`, `npc_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Player Statistics Database Table
CREATE TABLE IF NOT EXISTS `smuggle_stats` (
    `id` int(11) NOT NULL AUTO_INCREMENT,
    `identifier` varchar(100) NOT NULL,
    `total_deliveries` int(11) NOT NULL DEFAULT 0,
    `successful_deliveries` int(11) NOT NULL DEFAULT 0,
    `failed_deliveries` int(11) NOT NULL DEFAULT 0,
    `total_earnings` int(11) NOT NULL DEFAULT 0,
    `total_reputation` int(11) NOT NULL DEFAULT 0,
    `level` int(11) NOT NULL DEFAULT 1,
    `ambushes_survived` int(11) NOT NULL DEFAULT 0,
    `packages_delivered` int(11) NOT NULL DEFAULT 0,
    `group_missions_completed` int(11) NOT NULL DEFAULT 0,
    `profile_picture` varchar(500) DEFAULT NULL,
    `last_updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (`id`),
    UNIQUE KEY `unique_stats` (`identifier`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Active Delivery Groups (for cooperative missions)
CREATE TABLE IF NOT EXISTS `smuggle_groups` (
    `id` int(11) NOT NULL AUTO_INCREMENT,
    `group_id` varchar(100) NOT NULL,
    `leader_identifier` varchar(100) NOT NULL,
    `mission_data` JSON,
    `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `active` tinyint(1) NOT NULL DEFAULT 1,
    PRIMARY KEY (`id`),
    UNIQUE KEY `unique_group` (`group_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Group Members Table
CREATE TABLE IF NOT EXISTS `smuggle_group_members` (
    `id` int(11) NOT NULL AUTO_INCREMENT,
    `group_id` varchar(100) NOT NULL,
    `member_identifier` varchar(100) NOT NULL,
    `member_source` int(11),
    `joined_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (`id`),
    KEY `group_id` (`group_id`),
    CONSTRAINT `fk_group_members` FOREIGN KEY (`group_id`) REFERENCES `smuggle_groups` (`group_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


-- PER-LOCATION STATS TABLE (for foreman-specific statistics)
CREATE TABLE IF NOT EXISTS `smuggle_location_stats` (
    `id` int(11) NOT NULL AUTO_INCREMENT,
    `identifier` varchar(100) NOT NULL,
    `location_id` varchar(50) NOT NULL,
    `total_deliveries` int(11) NOT NULL DEFAULT 0,
    `successful_deliveries` int(11) NOT NULL DEFAULT 0,
    `failed_deliveries` int(11) NOT NULL DEFAULT 0,
    `total_earnings` int(11) NOT NULL DEFAULT 0,
    `packages_delivered` int(11) NOT NULL DEFAULT 0,
    `last_updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (`id`),
    UNIQUE KEY `unique_location_stats` (`identifier`, `location_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;