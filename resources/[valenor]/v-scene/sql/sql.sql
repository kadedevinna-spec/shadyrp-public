CREATE TABLE IF NOT EXISTS `v_scene` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `owner` VARCHAR(64) NOT NULL,
  `code` VARCHAR(16) NOT NULL,
  `title` VARCHAR(128) NOT NULL,
  `subtitle` VARCHAR(255) DEFAULT '',
  `scene_json` LONGTEXT NOT NULL,
  `order_index` INT NOT NULL DEFAULT 0,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uniq_code` (`code`),
  KEY `idx_owner` (`owner`),
  KEY `idx_owner_order` (`owner`, `order_index`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `v_scene_visit` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `player_key` VARCHAR(128) NOT NULL,
  `scene_id` VARCHAR(96) NOT NULL,
  `scene_code` VARCHAR(32) DEFAULT '',
  `visit_key` VARCHAR(96) NOT NULL DEFAULT 'default',
  `visit_count` INT NOT NULL DEFAULT 0,
  `first_seen` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  `last_seen` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `completed_at` TIMESTAMP NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uniq_player_scene_visit` (`player_key`, `scene_id`, `visit_key`),
  KEY `idx_player_key` (`player_key`),
  KEY `idx_scene_id` (`scene_id`),
  KEY `idx_scene_code` (`scene_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
