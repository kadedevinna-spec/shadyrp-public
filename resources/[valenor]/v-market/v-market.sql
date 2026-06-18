CREATE TABLE IF NOT EXISTS `v-market` (
  `id` int(11) NOT NULL,
  `marketName` varchar(50) DEFAULT NULL,
  `marketIcon` longtext DEFAULT NULL,
  `marketDescription` varchar(50) DEFAULT NULL,
  `items` longtext DEFAULT '[]',
  `case` int(11) DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;