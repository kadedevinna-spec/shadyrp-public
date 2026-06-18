-- MX-Admin: lista de banimentos (painel NUI + ban offline).
-- Executa isto na base configurada no oxmysql (ex.: vorpcore_b0c56c).

CREATE TABLE IF NOT EXISTS `bans` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(255) NOT NULL DEFAULT '',
  `license` VARCHAR(255) NOT NULL,
  `discord` VARCHAR(255) NOT NULL DEFAULT '',
  `ip` VARCHAR(128) NOT NULL DEFAULT '',
  `reason` TEXT NOT NULL,
  `expire` BIGINT(20) NOT NULL,
  `bannedby` VARCHAR(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `license` (`license`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
