CREATE TABLE IF NOT EXISTS `murphy_camp` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `charid` varchar(200) DEFAULT 0,
  `campfire` varchar(2000) DEFAULT '{}',
  `guests` varchar(200) DEFAULT '{}',
  `props` varchar(10000) DEFAULT '{}',
  `fuel` int(11),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

CREATE TABLE IF NOT EXISTS `murphy_camp_lost_objects` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `charid` varchar(200) NOT NULL,
  `item` varchar(100) NOT NULL,
  `amount` int(11) NOT NULL DEFAULT 1,
  `metadata` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_charid` (`charid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
