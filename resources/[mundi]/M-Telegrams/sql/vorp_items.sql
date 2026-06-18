-- ╔═══════════════════════════════════════════════════════════════╗
-- ║           M-TELEGRAMS — VORP ITEM DEFINITIONS                ║
-- ╚═══════════════════════════════════════════════════════════════╝
--
-- Run these INSERTs against your VORP database to register the
-- items used by M-Telegrams.
--
-- If you don't use the Carrier Birds system, you can skip the
-- bird care & training items.
--
-- IMAGES: Place telegram_paper.png, bird_seed.png, bird_treats.png,
--         bird_medicine.png, bird_training_rope.png,
--         bird_training_perch.png in
--         vorp_inventory/html/img/  (128×128 or 100×100 PNG)
-- ═══════════════════════════════════════════════════════════════

-- ── Telegram Paper ───────────────────────────────────────────
-- Useable — allows composing and sending telegrams.
INSERT INTO `items` (`item`, `label`, `limit`, `can_remove`, `type`, `usable`)
VALUES ('telegram_paper', 'Telegram Paper', 50, 1, 'item_standard', 1)
ON DUPLICATE KEY UPDATE `label` = VALUES(`label`);

-- ── Bird Seed ────────────────────────────────────────────────
-- Useable — basic feed that restores bird hunger.
INSERT INTO `items` (`item`, `label`, `limit`, `can_remove`, `type`, `usable`)
VALUES ('bird_seed', 'Bird Seed', 50, 1, 'item_standard', 1)
ON DUPLICATE KEY UPDATE `label` = VALUES(`label`);

-- ── Premium Treats ───────────────────────────────────────────
-- Useable — nutritious treat that restores hunger and loyalty.
INSERT INTO `items` (`item`, `label`, `limit`, `can_remove`, `type`, `usable`)
VALUES ('bird_treats', 'Premium Treats', 50, 1, 'item_standard', 1)
ON DUPLICATE KEY UPDATE `label` = VALUES(`label`);

-- ── Bird Medicine ────────────────────────────────────────────
-- Useable — restores bird health; can revive a gravely ill bird.
INSERT INTO `items` (`item`, `label`, `limit`, `can_remove`, `type`, `usable`)
VALUES ('bird_medicine', 'Bird Medicine', 50, 1, 'item_standard', 1)
ON DUPLICATE KEY UPDATE `label` = VALUES(`label`);

-- ── Training Rope ────────────────────────────────────────────
-- Useable — improves bird flight agility and grants speed XP.
INSERT INTO `items` (`item`, `label`, `limit`, `can_remove`, `type`, `usable`)
VALUES ('bird_training_rope', 'Training Rope', 50, 1, 'item_standard', 1)
ON DUPLICATE KEY UPDATE `label` = VALUES(`label`);

-- ── Training Perch ───────────────────────────────────────────
-- Useable — builds bird stamina and reduces recovery time.
INSERT INTO `items` (`item`, `label`, `limit`, `can_remove`, `type`, `usable`)
VALUES ('bird_training_perch', 'Training Perch', 50, 1, 'item_standard', 1)
ON DUPLICATE KEY UPDATE `label` = VALUES(`label`);
