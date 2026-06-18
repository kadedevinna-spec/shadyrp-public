CREATE TABLE IF NOT EXISTS `sh_society_societies` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `society_id` VARCHAR(64) NOT NULL,
  `label` VARCHAR(128) NOT NULL,
  `job_name` VARCHAR(64) NOT NULL,
  `is_public` TINYINT(1) NOT NULL DEFAULT 0,
  `entry_grade` INT NOT NULL DEFAULT 0,
  `boss_grade` INT NOT NULL DEFAULT 3,
  `payroll_interval_minutes` INT NULL DEFAULT NULL,
  `tax_percent` DECIMAL(5,2) NOT NULL DEFAULT 10.00,
  `theme_json` LONGTEXT DEFAULT NULL,
  `blip_json` LONGTEXT DEFAULT NULL,
  `store_json` LONGTEXT DEFAULT NULL,
  `storage_json` LONGTEXT DEFAULT NULL,
  `webhook_json` LONGTEXT DEFAULT NULL,
  `created_by_char_id` VARCHAR(64) DEFAULT NULL,
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_society_id` (`society_id`),
  UNIQUE KEY `uk_job_name` (`job_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `sh_society_ranks` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `society_id` VARCHAR(64) NOT NULL,
  `rank_index` INT NOT NULL,
  `rank_name` VARCHAR(64) NOT NULL,
  `salary` INT NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_society_rank` (`society_id`, `rank_index`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `sh_society_rank_permissions` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `society_id` VARCHAR(64) NOT NULL,
  `rank_index` INT NOT NULL,
  `permission_key` VARCHAR(96) NOT NULL,
  `allowed` TINYINT(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_society_rank_perm` (`society_id`, `rank_index`, `permission_key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `sh_society_employees` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `society_id` VARCHAR(64) NOT NULL,
  `char_id` VARCHAR(64) NOT NULL,
  `player_name` VARCHAR(128) NOT NULL DEFAULT '',
  `rank_index` INT NOT NULL DEFAULT 0,
  `is_boss` TINYINT(1) NOT NULL DEFAULT 0,
  `hired_by_char_id` VARCHAR(64) DEFAULT NULL,
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_society_char` (`society_id`, `char_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `sh_society_ledger` (
  `society_id` VARCHAR(64) NOT NULL,
  `balance` DECIMAL(15,2) NOT NULL DEFAULT 0.00,
  `tax_balance` DECIMAL(15,2) NOT NULL DEFAULT 0.00,
  `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`society_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `sh_society_ledger_tx` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `society_id` VARCHAR(64) NOT NULL,
  `tx_type` VARCHAR(48) NOT NULL,
  `amount` DECIMAL(15,2) NOT NULL,
  `tax_amount` DECIMAL(15,2) NOT NULL DEFAULT 0.00,
  `actor_char_id` VARCHAR(64) DEFAULT NULL,
  `metadata_json` LONGTEXT DEFAULT NULL,
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_society` (`society_id`),
  KEY `idx_created_at` (`created_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `sh_society_invoices` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `invoice_uid` VARCHAR(64) NOT NULL,
  `target_char_id` VARCHAR(64) NOT NULL,
  `society_id` VARCHAR(64) NOT NULL,
  `amount` INT NOT NULL,
  `reason` VARCHAR(512) NOT NULL DEFAULT '',
  `status` VARCHAR(24) NOT NULL DEFAULT 'open',
  `issued_by_char_id` VARCHAR(64) DEFAULT NULL,
  `paid_by_char_id` VARCHAR(64) DEFAULT NULL,
  `paid_at` TIMESTAMP NULL DEFAULT NULL,
  `metadata_json` LONGTEXT DEFAULT NULL,
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_invoice_uid` (`invoice_uid`),
  KEY `idx_target_char_id` (`target_char_id`),
  KEY `idx_society_id` (`society_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `sh_society_blips` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `society_id` VARCHAR(64) NOT NULL,
  `blip_key` VARCHAR(16) NOT NULL DEFAULT '',
  `label` VARCHAR(128) NOT NULL,
  `sprite` INT NOT NULL,
  `color` VARCHAR(24) NOT NULL DEFAULT '#9e7840',
  `coords_json` LONGTEXT NOT NULL,
  `enabled` TINYINT(1) NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`),
  KEY `idx_society_id` (`society_id`),
  UNIQUE KEY `uk_society_blip_key` (`society_id`, `blip_key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `sh_society_stores` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `society_id` VARCHAR(64) NOT NULL,
  `store_id` VARCHAR(64) NOT NULL,
  `label` VARCHAR(128) NOT NULL,
  `coords_json` LONGTEXT NOT NULL,
  `heading` DOUBLE NOT NULL DEFAULT 0,
  `prop_model` VARCHAR(80) DEFAULT '',
  `enabled` TINYINT(1) NOT NULL DEFAULT 1,
  `catalog_json` LONGTEXT DEFAULT NULL,
  `buy_enabled` TINYINT(1) NOT NULL DEFAULT 0,
  `buy_catalog_json` LONGTEXT DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_store` (`society_id`, `store_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `sh_society_adverts` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `society_id` VARCHAR(64) NOT NULL,
  `advert_id` VARCHAR(64) NOT NULL,
  `title` VARCHAR(128) NOT NULL,
  `description` VARCHAR(512) DEFAULT NULL,
  `image_url` VARCHAR(512) NOT NULL,
  `coords_json` LONGTEXT NOT NULL,
  `heading` DOUBLE NOT NULL DEFAULT 0,
  `prop_model` VARCHAR(80) DEFAULT '',
  `enabled` TINYINT(1) NOT NULL DEFAULT 1,
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_society_advert` (`society_id`, `advert_id`),
  KEY `idx_society_enabled` (`society_id`, `enabled`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `sh_society_audit` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `action_key` VARCHAR(96) NOT NULL,
  `success` TINYINT(1) NOT NULL DEFAULT 0,
  `actor_source` INT NOT NULL DEFAULT 0,
  `actor_char_id` VARCHAR(64) DEFAULT NULL,
  `target_char_id` VARCHAR(64) DEFAULT NULL,
  `metadata_json` LONGTEXT DEFAULT NULL,
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_action` (`action_key`),
  KEY `idx_created_at` (`created_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `sh_society_job_cooldowns` (
  `char_id` VARCHAR(64) NOT NULL,
  `last_switch_at` INT UNSIGNED NOT NULL DEFAULT 0,
  `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`char_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
