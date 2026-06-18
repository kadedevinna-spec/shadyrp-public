CREATE TABLE IF NOT EXISTS `fx_hud` (
  `charid` varchar(50) NOT NULL,
  `health` int(11) DEFAULT 600,
  `stamina` int(11) DEFAULT 100,
  `corehealth` int(11) DEFAULT 100,
  `corestamina` int(11) DEFAULT 100,
  `hunger` int(11) DEFAULT 100,
  `thirst` int(11) DEFAULT 100,
  `stress` int(11) DEFAULT 0,
  `armour` int(11) DEFAULT 0,
  `pvp` TINYINT(1) NOT NULL DEFAULT 0, 
  `xp` int(11) NOT NULL DEFAULT 1,
  `level` int(11) NOT NULL DEFAULT 1,
  `settings` longtext DEFAULT '{}',
  PRIMARY KEY (`charid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;


-- only update sql code
ALTER TABLE `fx_hud`
ADD COLUMN `armour` INT(11) NULL DEFAULT '0' AFTER `stress`;

ALTER TABLE `fx_hud`
ADD COLUMN `pvp` TINYINT(1) NOT NULL DEFAULT 0 AFTER `armour`;