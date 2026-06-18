-- Último login de staff no servidor (Discord). Criada também em permission_matrix.lua ao iniciar.

CREATE TABLE IF NOT EXISTS `mx_staff_logins` (
  `discord_id` varchar(32) NOT NULL,
  `last_server_join` timestamp NULL DEFAULT NULL,
  `name_snapshot` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`discord_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
