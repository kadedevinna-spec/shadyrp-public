-- ─── fx-camping database setup ───────────────────────────────────────────────
-- Run this once before starting the resource for the first time.
-- Requires MySQL 5.7+ or MariaDB 10.2+ (JSON column support).
-- ─────────────────────────────────────────────────────────────────────────────

CREATE TABLE IF NOT EXISTS `fx_camps` (
    `id`             VARCHAR(64)  NOT NULL,
    `owner_charid`   INT          NOT NULL,
    `camp_name`      VARCHAR(128) NOT NULL DEFAULT 'My Camp',
    `members`        JSON         NOT NULL,
    `base_coords`    JSON         NOT NULL,
    `base_item`      VARCHAR(64)  NOT NULL,
    `base_prop_uuid` VARCHAR(64)  NOT NULL,
    `props`          JSON         NOT NULL,
    `wardrobe`       JSON         DEFAULT NULL,
    `created_at`     TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (`id`),
    INDEX `idx_owner_charid` (`owner_charid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ─────────────────────────────────────────────────────────────────────────────

CREATE TABLE IF NOT EXISTS `fx_camp_wagons` (
    `id`           VARCHAR(64)  NOT NULL,
    `owner_charid` INT          NOT NULL,
    `coords`       JSON         NOT NULL,
    `stash_id`     VARCHAR(128) NOT NULL,
    `packed_items` JSON         NOT NULL,
    `created_at`   TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (`id`),
    INDEX `idx_owner_charid` (`owner_charid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
