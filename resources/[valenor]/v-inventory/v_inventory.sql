CREATE TABLE IF NOT EXISTS `v_inventory` (
  `identifier` varchar(255) NOT NULL,
  `type` varchar(50) NOT NULL DEFAULT 'player',
  `items` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL CHECK (json_valid(`items`)),
  PRIMARY KEY (`identifier`,`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
