CREATE TABLE IF NOT EXISTS `sirevlc_bounty_hunter_role` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(100) NOT NULL,
  `charid` int(5) NOT NULL,
  `lvl` int(6) NOT NULL,
  `xp` int(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4;
 