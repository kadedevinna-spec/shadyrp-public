-- ═══════════════════════════════════════════════════════════════
-- QC-AdvancedMoonshine V2 - OPTIMIZED 3-Table Schema
-- ═══════════════════════════════════════════════════════════════
-- Player progression stored in RSG-Core metadata:
--   metadata['rep']['moonshine'] = total XP (number)
--   metadata.moonshine = {discovered_recipes = {}, level = 1}
-- ═══════════════════════════════════════════════════════════════

-- ════════════════════════════════════════════════════════════════
-- TABLE 1: MOONSHINE STILLS (World Objects)
-- ════════════════════════════════════════════════════════════════
-- Purpose: Track physical stills placed in the world
-- Accessed by: stillId (fast lookups, frequent updates)

CREATE TABLE IF NOT EXISTS `qc_moonshine_stills` (
    `id` INT NOT NULL AUTO_INCREMENT,
    `owner` VARCHAR(50) NOT NULL,

    -- Location
    `coords` TEXT NOT NULL COMMENT 'JSON: {x, y, z}',
    `heading` FLOAT NOT NULL DEFAULT 0.0,

    -- Still properties
    `stage` INT NOT NULL DEFAULT 1 COMMENT '1=Barrel, 2=Basic, 3=Advanced',
    `model` VARCHAR(100) NOT NULL,
    `fuel` INT NOT NULL DEFAULT 0,
    `health` FLOAT NOT NULL DEFAULT 100.0,

    -- Brewing state
    `brewing` TINYINT(1) NOT NULL DEFAULT 0,
    `recipe` VARCHAR(50) DEFAULT NULL,
    `brew_start` BIGINT DEFAULT NULL,

    -- Timestamps
    `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

    PRIMARY KEY (`id`),
    KEY `idx_owner` (`owner`),
    KEY `idx_brewing` (`brewing`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ════════════════════════════════════════════════════════════════
-- TABLE 2: MOONSHINE SHACKS (Player Business - RENTAL SYSTEM)
-- ════════════════════════════════════════════════════════════════
-- Purpose: Store player shack rentals (3-day rental periods)
-- Accessed by: citizenid, location_id, rental_expires

CREATE TABLE IF NOT EXISTS `qc_moonshine_shacks` (
    `id` INT NOT NULL AUTO_INCREMENT,
    `citizenid` VARCHAR(50) NOT NULL,

    -- Shack identity
    `location_id` INT NOT NULL,

    -- Rental system (3-day rentals)
    `rental_expires` BIGINT NOT NULL DEFAULT 0 COMMENT 'Unix timestamp when rental expires',

    -- Shack data (JSON for flexibility)
    `data` LONGTEXT NOT NULL DEFAULT '{}' COMMENT 'JSON: {money, reputation, heat, ingredients, production, bar_stock, upgrades, repairs_completed, last_tribute}',

    -- Distillery fuel (for shack stills)
    `distillery_fuel` INT NOT NULL DEFAULT 0 COMMENT 'Fuel level for distillery brewing equipment',

    -- Financial tracking
    `profit` INT NOT NULL DEFAULT 0 COMMENT 'Accumulated profit from deliveries available for withdrawal',
    `deliveries_made` INT NOT NULL DEFAULT 0 COMMENT 'Total number of deliveries completed',

    -- Access control
    `authorized_players` TEXT DEFAULT NULL COMMENT 'JSON array of citizenids with access to this shack',

    -- Timestamps
    `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

    PRIMARY KEY (`id`),
    KEY `idx_citizenid` (`citizenid`),
    KEY `idx_location` (`location_id`),
    KEY `idx_rental_expires` (`rental_expires`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ════════════════════════════════════════════════════════════════
-- TABLE 3: MOONSHINE STATISTICS (Optional - Leaderboards/Logs)
-- ════════════════════════════════════════════════════════════════
-- Purpose: Track statistics for leaderboards and analytics
-- Can be removed if not needed

CREATE TABLE IF NOT EXISTS `qc_moonshine_stats` (
    `citizenid` VARCHAR(50) NOT NULL,

    -- Vendor conversation progress
    `vendor_intro_complete` TINYINT(1) NOT NULL DEFAULT 0 COMMENT 'Has completed initial vendor conversation',
    `boss_met` TINYINT(1) NOT NULL DEFAULT 0 COMMENT 'Has met Marcus Kane (Boss NPC)',

    -- Brew statistics
    `total_brews` INT NOT NULL DEFAULT 0,
    `successful_brews` INT NOT NULL DEFAULT 0,
    `failed_brews` INT NOT NULL DEFAULT 0,
    `explosions` INT NOT NULL DEFAULT 0,
    `best_quality` FLOAT NOT NULL DEFAULT 0.0,

    -- Economic stats
    `total_revenue` INT NOT NULL DEFAULT 0,
    `total_spent` INT NOT NULL DEFAULT 0,

    -- Timestamps
    `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

    PRIMARY KEY (`citizenid`),
    KEY `idx_total_brews` (`total_brews`),
    KEY `idx_best_quality` (`best_quality`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
