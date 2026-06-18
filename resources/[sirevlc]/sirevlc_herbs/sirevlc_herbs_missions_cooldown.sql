 
CREATE TABLE IF NOT EXISTS `sirevlc_herbs_missions_cooldown` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(70) NOT NULL,
  `charid` int(6) NOT NULL,
  `cooldown` varchar(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4;
