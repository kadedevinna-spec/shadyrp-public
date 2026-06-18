-- Run this once if dl_missions tables already existed before the RSG conversion.
-- It fixes: Incorrect integer value: 'QNF64719' for column owner_id.

ALTER TABLE `character_missions`
    MODIFY COLUMN `owner_id` VARCHAR(64) NOT NULL;

ALTER TABLE `character_mission_items`
    MODIFY COLUMN `owner_id` VARCHAR(64) NOT NULL;

ALTER TABLE `character_mission_completed`
    MODIFY COLUMN `owner_id` VARCHAR(64) NOT NULL;
