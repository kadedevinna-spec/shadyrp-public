CREATE TABLE IF NOT EXISTS `murphy_jobpanel` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `charid` varchar(200) DEFAULT 0,
  `job` varchar(2000),
  `step` varchar(200),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

