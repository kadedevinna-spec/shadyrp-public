CREATE TABLE IF NOT EXISTS `sirevlc_boats` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(70) NOT NULL,
  `charid` varchar(20) NOT NULL,
  `model` int(40) NOT NULL,
  `name` varchar(50) NOT NULL,
  `components`  varchar(5000) NOT NULL,
  `price` int(8) NOT NULL DEFAULT 0,
  `gold` int(8) NOT NULL DEFAULT 0,
  `destroyed` int(1) NOT NULL,
  `stashlimit` int(10) NOT NULL DEFAULT 0,
  `stashslots` int(10) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4;
