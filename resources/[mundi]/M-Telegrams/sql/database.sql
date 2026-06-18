-- ═══════════════════════════════════════════════════════════════
-- M-TELEGRAMS DATABASE SCHEMA v2.9
-- ═══════════════════════════════════════════════════════════════
-- This file is safe to run on BOTH fresh installs and existing
-- databases. It will create any missing tables and add any
-- missing columns without touching your existing data.
--
-- The server also applies these same migrations automatically
-- on every boot this file is for manual / advance use only.
-- ═══════════════════════════════════════════════════════════════

-- Registration table: each character gets a unique telegram ID
CREATE TABLE IF NOT EXISTS `m_telegrams_registrations` (
    `id` int(11) NOT NULL AUTO_INCREMENT,
    `identifier` varchar(50) NOT NULL,
    `charid` varchar(50) NOT NULL,
    `telegram_id` varchar(20) NOT NULL,
    `firstname` varchar(100) NOT NULL DEFAULT '',
    `lastname` varchar(100) NOT NULL DEFAULT '',
    `profile_picture` varchar(500) DEFAULT '',
    `signature` LONGTEXT DEFAULT NULL,
    `custom_stamp_url` varchar(500) DEFAULT '',
    `is_custom_id` tinyint(1) NOT NULL DEFAULT 0,
    `outstanding_fees` decimal(10,2) NOT NULL DEFAULT 0.00,
    `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (`id`),
    UNIQUE KEY `uk_telegram_id` (`telegram_id`),
    UNIQUE KEY `uk_char` (`identifier`, `charid`),
    KEY `idx_charid` (`charid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Company/Job telegram numbers
CREATE TABLE IF NOT EXISTS `m_telegrams_companies` (
    `id` int(11) NOT NULL AUTO_INCREMENT,
    `company_id` varchar(20) NOT NULL,
    `job_name` varchar(50) NOT NULL,
    `label` varchar(100) NOT NULL DEFAULT '',
    `owner_telegram_id` varchar(20) DEFAULT NULL,
    `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (`id`),
    UNIQUE KEY `uk_company_id` (`company_id`),
    KEY `idx_job` (`job_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Company member access (for manually assigned access beyond job grades)
CREATE TABLE IF NOT EXISTS `m_telegrams_company_members` (
    `id` int(11) NOT NULL AUTO_INCREMENT,
    `company_id` varchar(20) NOT NULL,
    `telegram_id` varchar(20) NOT NULL,
    `added_by` varchar(20) NOT NULL DEFAULT '',
    `nickname` varchar(100) DEFAULT NULL,
    `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (`id`),
    UNIQUE KEY `uk_member` (`company_id`, `telegram_id`),
    KEY `idx_company` (`company_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Telegram messages
CREATE TABLE IF NOT EXISTS `m_telegrams_messages` (
    `id` int(11) NOT NULL AUTO_INCREMENT,
    `sender_telegram_id` varchar(20) NOT NULL,
    `sender_name` varchar(200) NOT NULL DEFAULT 'Unknown',
    `recipient_telegram_id` varchar(20) NOT NULL,
    `subject` varchar(255) NOT NULL DEFAULT '',
    `message` LONGTEXT NOT NULL,
    `drawings_data` LONGTEXT DEFAULT '[]',
    `image_url` varchar(500) DEFAULT '',
    `image_x` decimal(6,2) DEFAULT 50.00,
    `image_y` decimal(6,2) DEFAULT 10.00,
    `image_rot` decimal(5,1) DEFAULT 0.0,
    `image_scale` decimal(4,2) DEFAULT 1.00,
    `stamp` varchar(50) DEFAULT '',
    `stamp_image` LONGTEXT DEFAULT NULL,
    `signature_image` LONGTEXT DEFAULT NULL,
    `font` varchar(100) DEFAULT '',
    `color` varchar(20) DEFAULT '',
    `city_from` varchar(100) DEFAULT '',
    `city_to` varchar(100) DEFAULT '',
    `cost` decimal(10,2) NOT NULL DEFAULT 0.00,
    `anonymous` tinyint(1) NOT NULL DEFAULT 0,
    `is_job` tinyint(1) NOT NULL DEFAULT 0,
    `is_bulk` tinyint(1) NOT NULL DEFAULT 0,
    `viewed` tinyint(1) NOT NULL DEFAULT 0,
    `archived_recipient` tinyint(1) NOT NULL DEFAULT 0,
    `archived_sender` tinyint(1) NOT NULL DEFAULT 0,
    `extracted` tinyint(1) NOT NULL DEFAULT 0,
    `deleted_sender` tinyint(1) NOT NULL DEFAULT 0,
    `deleted_recipient` tinyint(1) NOT NULL DEFAULT 0,
    `sent_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (`id`),
    KEY `idx_recipient` (`recipient_telegram_id`, `deleted_recipient`, `archived_recipient`, `sent_at`),
    KEY `idx_sender` (`sender_telegram_id`, `deleted_sender`, `archived_sender`),
    KEY `idx_viewed` (`recipient_telegram_id`, `viewed`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Contacts / Address Book
CREATE TABLE IF NOT EXISTS `m_telegrams_contacts` (
    `id` int(11) NOT NULL AUTO_INCREMENT,
    `owner_telegram_id` varchar(20) NOT NULL,
    `contact_telegram_id` varchar(20) NOT NULL,
    `contact_name` varchar(100) NOT NULL DEFAULT '',
    `notes` TEXT DEFAULT '',
    `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (`id`),
    UNIQUE KEY `uk_contact` (`owner_telegram_id`, `contact_telegram_id`),
    KEY `idx_owner` (`owner_telegram_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Telegram Book (personal saved telegram references with custom names)
CREATE TABLE IF NOT EXISTS `m_telegrams_book` (
    `id` int(11) NOT NULL AUTO_INCREMENT,
    `owner_telegram_id` varchar(20) NOT NULL,
    `saved_telegram_id` varchar(20) NOT NULL,
    `entry_name` varchar(100) NOT NULL DEFAULT '',
    `notes` TEXT DEFAULT '',
    `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (`id`),
    UNIQUE KEY `uk_book_entry` (`owner_telegram_id`, `saved_telegram_id`),
    KEY `idx_book_owner` (`owner_telegram_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Public Telegram Directory (opt-in public listing)
CREATE TABLE IF NOT EXISTS `m_telegrams_directory` (
    `id` int(11) NOT NULL AUTO_INCREMENT,
    `telegram_id` varchar(20) NOT NULL,
    `display_name` varchar(100) NOT NULL DEFAULT '',
    `description` varchar(255) DEFAULT '',
    `category` varchar(50) DEFAULT 'General',
    `listed_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (`id`),
    UNIQUE KEY `uk_directory_tid` (`telegram_id`),
    KEY `idx_category` (`category`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- VIP / Patreon reserved custom telegram IDs (assigned by steam hex)
CREATE TABLE IF NOT EXISTS `m_telegrams_vip_ids` (
    `id` int(11) NOT NULL AUTO_INCREMENT,
    `steam_id` varchar(50) NOT NULL,
    `reserved_telegram_id` varchar(20) NOT NULL,
    `assigned_by` varchar(50) DEFAULT 'system',
    `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (`id`),
    UNIQUE KEY `uk_vip_steam` (`steam_id`),
    UNIQUE KEY `uk_vip_tid` (`reserved_telegram_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Player-created Businesses (v2.3)
CREATE TABLE IF NOT EXISTS `m_telegrams_businesses` (
    `id` int(11) NOT NULL AUTO_INCREMENT,
    `business_id` varchar(20) NOT NULL,
    `owner_telegram_id` varchar(20) NOT NULL,
    `business_name` varchar(100) NOT NULL DEFAULT '',
    `description` varchar(255) DEFAULT '',
    `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (`id`),
    UNIQUE KEY `uk_business_id` (`business_id`),
    KEY `idx_owner` (`owner_telegram_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Business member access (v2.3)
CREATE TABLE IF NOT EXISTS `m_telegrams_business_members` (
    `id` int(11) NOT NULL AUTO_INCREMENT,
    `business_id` varchar(20) NOT NULL,
    `member_telegram_id` varchar(20) NOT NULL,
    `role` varchar(20) NOT NULL DEFAULT 'employee',
    `can_read` tinyint(1) NOT NULL DEFAULT 1,
    `can_send` tinyint(1) NOT NULL DEFAULT 1,
    `added_by` varchar(20) NOT NULL DEFAULT '',
    `nickname` varchar(100) DEFAULT NULL,
    `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (`id`),
    UNIQUE KEY `uk_biz_member` (`business_id`, `member_telegram_id`),
    KEY `idx_biz` (`business_id`),
    KEY `idx_member` (`member_telegram_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Parcel System (v2.5)
-- status: pending (awaiting collection), collected (recipient took items),
--         returned (rejected/overdue), refunded (items given back to sender),
--         lost (unrecoverable)
CREATE TABLE IF NOT EXISTS `m_telegrams_parcels` (
    `id` int(11) NOT NULL AUTO_INCREMENT,
    `sender_telegram_id` varchar(20) NOT NULL,
    `sender_name` varchar(200) NOT NULL DEFAULT '',
    `recipient_telegram_id` varchar(20) NOT NULL,
    `note` TEXT DEFAULT '',
    `items_json` LONGTEXT NOT NULL DEFAULT '[]',
    `total_weight` decimal(8,2) NOT NULL DEFAULT 0.00,
    `fee` decimal(10,2) NOT NULL DEFAULT 0.00,
    `status` enum('pending','collected','returned','lost','refunded','transit') NOT NULL DEFAULT 'pending',
    `linked_telegram_id` int(11) DEFAULT NULL,
    `sent_from_city` varchar(100) DEFAULT '',
    `sent_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `deliver_at` timestamp NULL DEFAULT NULL,
    `collected_at` timestamp NULL DEFAULT NULL,
    PRIMARY KEY (`id`),
    KEY `idx_parcel_recipient` (`recipient_telegram_id`, `status`),
    KEY `idx_parcel_sender` (`sender_telegram_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Carrier Birds (v2.5)
CREATE TABLE IF NOT EXISTS `m_telegrams_birds` (
    `id` int(11) NOT NULL AUTO_INCREMENT,
    `owner_telegram_id` varchar(20) NOT NULL,
    `bird_name` varchar(50) NOT NULL DEFAULT 'My Bird',
    `breed_id` varchar(50) NOT NULL DEFAULT 'rock_pigeon',
    `speed` int(11) NOT NULL DEFAULT 30,
    `health` int(11) NOT NULL DEFAULT 100,
    `max_health` int(11) NOT NULL DEFAULT 100,
    `hunger` int(11) NOT NULL DEFAULT 100,
    `stamina` int(11) NOT NULL DEFAULT 80,
    `loyalty` int(11) NOT NULL DEFAULT 50,
    `xp` int(11) NOT NULL DEFAULT 0,
    `level` int(11) NOT NULL DEFAULT 1,
    `status` enum('healthy','hungry','sick','resting','inflight','training','dead') NOT NULL DEFAULT 'healthy',
    `death_reason` varchar(100) DEFAULT NULL,
    `total_deliveries` int(11) NOT NULL DEFAULT 0,
    `last_fed_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `last_cared_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `flight_eta` bigint(20) DEFAULT NULL,
    `flight_station` varchar(100) DEFAULT NULL,
    `rest_until` bigint(20) DEFAULT NULL,
    `training_until` bigint(20) DEFAULT NULL,
    `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (`id`),
    KEY `idx_bird_owner` (`owner_telegram_id`),
    KEY `idx_bird_status` (`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Bird training cooldown log (v2.5)
CREATE TABLE IF NOT EXISTS `m_telegrams_bird_training_log` (
    `id` int(11) NOT NULL AUTO_INCREMENT,
    `bird_id` int(11) NOT NULL,
    `item_name` varchar(100) NOT NULL,
    `next_allowed` bigint(20) NOT NULL DEFAULT 0,
    PRIMARY KEY (`id`),
    UNIQUE KEY `uk_bird_item` (`bird_id`, `item_name`),
    KEY `idx_btl_bird` (`bird_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Bird deliveries (in-flight messages) (v2.5)
CREATE TABLE IF NOT EXISTS `m_telegrams_bird_deliveries` (
    `id` int(11) NOT NULL AUTO_INCREMENT,
    `bird_id` int(11) NOT NULL,
    `owner_telegram_id` varchar(20) NOT NULL,
    `telegram_message_id` int(11) DEFAULT NULL,
    `deliver_at_unix` bigint(20) NOT NULL,
    `destination_station` varchar(100) NOT NULL DEFAULT '',
    `sender_name` varchar(200) DEFAULT '',
    `delivered` tinyint(1) NOT NULL DEFAULT 0,
    `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (`id`),
    KEY `idx_bd_bird` (`bird_id`),
    KEY `idx_bd_delivered` (`delivered`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Public Board (v2.9)
CREATE TABLE IF NOT EXISTS `m_telegrams_public_board` (
    `id` int(11) NOT NULL AUTO_INCREMENT,
    `sender_identifier` varchar(50) NOT NULL,
    `sender_charid` varchar(50) NOT NULL,
    `sender_telegram_id` varchar(20) NOT NULL,
    `sender_name` varchar(200) NOT NULL DEFAULT 'Unknown',
    `subject` varchar(255) NOT NULL DEFAULT '',
    `message` LONGTEXT NOT NULL,
    `drawings_data` LONGTEXT DEFAULT '[]',
    `image_url` varchar(500) DEFAULT '',
    `image_x` decimal(6,2) DEFAULT 50.00,
    `image_y` decimal(6,2) DEFAULT 10.00,
    `image_rot` decimal(5,1) DEFAULT 0.0,
    `image_scale` decimal(4,2) DEFAULT 1.00,
    `stamp` varchar(50) DEFAULT '',
    `stamp_image` LONGTEXT DEFAULT NULL,
    `signature_image` LONGTEXT DEFAULT NULL,
    `font` varchar(100) DEFAULT '',
    `color` varchar(20) DEFAULT '',
    `city_from` varchar(100) DEFAULT '',
    `anonymous` tinyint(1) NOT NULL DEFAULT 0,
    `posted_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (`id`),
    KEY `idx_board_posted` (`posted_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


-- ═══════════════════════════════════════════════════════════════
-- MIGRATIONS Safe column updates for existing databases
-- ═══════════════════════════════════════════════════════════════
-- Everything below uses IF NOT EXISTS / IF EXISTS so it is
-- safe to run on any version columns that already exist
-- are simply skipped, no data is ever lost.
-- ═══════════════════════════════════════════════════════════════

-- v1.0: Core column additions
ALTER TABLE `m_telegrams_registrations`  ADD COLUMN IF NOT EXISTS `is_custom_id` tinyint(1) NOT NULL DEFAULT 0;
ALTER TABLE `m_telegrams_registrations`  MODIFY COLUMN `charid` varchar(50) NOT NULL;
ALTER TABLE `m_telegrams_registrations`  ADD COLUMN IF NOT EXISTS `outstanding_fees` DECIMAL(10,2) NOT NULL DEFAULT 0.00 AFTER `is_custom_id`;
ALTER TABLE `m_telegrams_companies`      ADD COLUMN IF NOT EXISTS `owner_telegram_id` varchar(20) DEFAULT NULL;
ALTER TABLE `m_telegrams_messages`       ADD COLUMN IF NOT EXISTS `archived_recipient` tinyint(1) NOT NULL DEFAULT 0;
ALTER TABLE `m_telegrams_messages`       ADD COLUMN IF NOT EXISTS `archived_sender` tinyint(1) NOT NULL DEFAULT 0;
ALTER TABLE `m_telegrams_messages`       ADD COLUMN IF NOT EXISTS `extracted` tinyint(1) NOT NULL DEFAULT 0;
ALTER TABLE `m_telegrams_registrations`  DROP COLUMN IF EXISTS `contacts`;

-- v2.1: Profile pictures, signatures & stamps
ALTER TABLE `m_telegrams_registrations`  ADD COLUMN IF NOT EXISTS `profile_picture` varchar(500) DEFAULT '';
ALTER TABLE `m_telegrams_registrations`  ADD COLUMN IF NOT EXISTS `signature` LONGTEXT DEFAULT NULL;
ALTER TABLE `m_telegrams_registrations`  ADD COLUMN IF NOT EXISTS `custom_stamp_url` varchar(500) DEFAULT '';
ALTER TABLE `m_telegrams_messages`       ADD COLUMN IF NOT EXISTS `stamp_image` LONGTEXT DEFAULT NULL;

-- v2.2: Image position & rotation
ALTER TABLE `m_telegrams_messages`       ADD COLUMN IF NOT EXISTS `image_x` decimal(6,2) DEFAULT 50.00;
ALTER TABLE `m_telegrams_messages`       ADD COLUMN IF NOT EXISTS `image_y` decimal(6,2) DEFAULT 10.00;
ALTER TABLE `m_telegrams_messages`       ADD COLUMN IF NOT EXISTS `image_rot` decimal(5,1) DEFAULT 0.0;

-- v2.4: Business member permissions
ALTER TABLE `m_telegrams_business_members` ADD COLUMN IF NOT EXISTS `can_read` tinyint(1) NOT NULL DEFAULT 1;
ALTER TABLE `m_telegrams_business_members` ADD COLUMN IF NOT EXISTS `can_send` tinyint(1) NOT NULL DEFAULT 1;

-- v2.5: Bird training column + status enum update
ALTER TABLE `m_telegrams_birds`          ADD COLUMN IF NOT EXISTS `training_until` bigint(20) DEFAULT NULL;
ALTER TABLE `m_telegrams_birds`          MODIFY COLUMN `status` enum('healthy','hungry','sick','resting','inflight','training','dead') NOT NULL DEFAULT 'healthy';

-- v2.6: Bird death reason
ALTER TABLE `m_telegrams_birds`          ADD COLUMN IF NOT EXISTS `death_reason` varchar(100) DEFAULT NULL;

-- v2.7: Parcel refund status
ALTER TABLE `m_telegrams_parcels`        MODIFY COLUMN `status` enum('pending','collected','returned','lost','refunded') NOT NULL DEFAULT 'pending';

-- v2.8: Delivery delay, transit status & image scale
ALTER TABLE `m_telegrams_parcels`        ADD COLUMN IF NOT EXISTS `deliver_at` TIMESTAMP NULL DEFAULT NULL AFTER `sent_at`;
ALTER TABLE `m_telegrams_parcels`        MODIFY COLUMN `status` enum('pending','collected','returned','lost','refunded','transit') NOT NULL DEFAULT 'pending';
ALTER TABLE `m_telegrams_messages`       ADD COLUMN IF NOT EXISTS `image_scale` decimal(4,2) DEFAULT 1.00;

-- v2.9: Signature image baked into messages
ALTER TABLE `m_telegrams_messages`       ADD COLUMN IF NOT EXISTS `signature_image` LONGTEXT DEFAULT NULL;

-- v3.0: Nickname for business/company inbox members
ALTER TABLE `m_telegrams_business_members` ADD COLUMN IF NOT EXISTS `nickname` varchar(100) DEFAULT NULL;
ALTER TABLE `m_telegrams_company_members`  ADD COLUMN IF NOT EXISTS `nickname` varchar(100) DEFAULT NULL;


-- ═══════════════════════════════════════════════════════════════
-- DONE Your database is now up to date with schema v3.0
-- ═══════════════════════════════════════════════════════════════
