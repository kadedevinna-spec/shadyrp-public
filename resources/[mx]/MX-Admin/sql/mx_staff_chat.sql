-- Chat de staff (NUI). Criada também em server_adminchat.lua ao iniciar.

CREATE TABLE IF NOT EXISTS `mx_staff_chat` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sender_src` int(11) NOT NULL,
  `sender_name` varchar(255) NOT NULL,
  `sender_discord` varchar(32) DEFAULT NULL,
  `message` varchar(512) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `idx_staff_chat_created` (`created_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
