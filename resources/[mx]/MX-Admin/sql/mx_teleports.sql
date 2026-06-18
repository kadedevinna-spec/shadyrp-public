-- Teleportes guardados pelo painel. Criada também em server_teleports.lua ao iniciar.

CREATE TABLE IF NOT EXISTS `mx_teleports` (
  `id` int NOT NULL AUTO_INCREMENT,
  `preset_id` varchar(80) NOT NULL,
  `label` varchar(120) NOT NULL,
  `x` double NOT NULL,
  `y` double NOT NULL,
  `z` double NOT NULL,
  `w` double NOT NULL DEFAULT 0,
  `image` varchar(255) DEFAULT NULL,
  `created_by` varchar(64) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uniq_preset_id` (`preset_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
