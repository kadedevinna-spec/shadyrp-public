CREATE TABLE IF NOT EXISTS `character_missions` (
    `id` INT PRIMARY KEY AUTO_INCREMENT,
    `configRef` VARCHAR(255) NOT NULL,
    `owner_id` VARCHAR(64) NOT NULL,
    `status` TINYINT NOT NULL,
    `started_at` DATETIME NOT NULL,
    KEY idx_owned_by(`owner_id`),
    KEY idx_config_ref(`configRef`)
);

CREATE TABLE IF NOT EXISTS `character_mission_tasks` (
    `id` INT PRIMARY KEY AUTO_INCREMENT,
    `mission_id` INT NOT NULL,
    `configRef` VARCHAR(255) NOT NULL,
    `status` TINYINT NOT NULL,
    `progress` INT NOT NULL DEFAULT 0,
    `state` JSON NOT NULL DEFAULT '{}',
    KEY idx_config_ref(`configRef`),
    KEY idx_mission_id(`mission_id`),
    FOREIGN KEY (`mission_id`) REFERENCES character_missions(`id`) ON DELETE CASCADE
);


CREATE TABLE IF NOT EXISTS `character_mission_items` (
    `id` INT PRIMARY KEY AUTO_INCREMENT,
    `owner_id` VARCHAR(64) NOT NULL,
    `item` VARCHAR(255) NOT NULL,
    `amount` INT NOT NULL DEFAULT 1,
    KEY idx_item_name(`item`)
);


CREATE TABLE IF NOT EXISTS `character_mission_completed` (
    `id` INT PRIMARY KEY AUTO_INCREMENT,
    `owner_id` VARCHAR(64) NOT NULL,
    `missionRef` VARCHAR(255) NOT NULL,
    KEY idx_mission_ref(`missionRef`),
    KEY idx_owner_id(`owner_id`)
);

-- RSG migration for databases that already had the VORP schema installed.
-- RSG uses citizenid strings like QNF64719, not numeric character ids.
ALTER TABLE `character_missions` MODIFY COLUMN `owner_id` VARCHAR(64) NOT NULL;
ALTER TABLE `character_mission_items` MODIFY COLUMN `owner_id` VARCHAR(64) NOT NULL;
ALTER TABLE `character_mission_completed` MODIFY COLUMN `owner_id` VARCHAR(64) NOT NULL;
