-- ╔═══════════════════════════════════════════════════════════════╗
-- ║           M-TELEGRAMS — RSG-CORE ITEM DEFINITIONS            ║
-- ╚═══════════════════════════════════════════════════════════════╝
--
-- FILE:   rsg-core/shared/items.lua
-- PASTE:  Inside the RSGShared.Items = { ... } table
--
-- If you don't use the Carrier Birds system, you can skip the
-- bird care & training items.
--
-- IMAGES: Place telegram_paper.png, bird_seed.png, bird_treats.png,
--         bird_medicine.png, bird_training_rope.png,
--         bird_training_perch.png in
--         rsg-inventory/html/images/  (128×128 or 100×100 PNG)


-- ── Telegram Paper ───────────────────────────────────────────
-- Useable — allows composing and sending telegrams.
['telegram_paper'] = {
    name        = 'telegram_paper',
    label       = 'Telegram Paper',
    weight      = 100,
    type        = 'item',
    image       = 'telegram_paper.png',
    unique      = false,
    useable     = true,
    shouldClose = true,
    description = 'A blank sheet of telegram paper',
},



-- ── Bird Seed ────────────────────────────────────────────────
-- Useable — basic feed that restores bird hunger.
['bird_seed'] = {
    name        = 'bird_seed',
    label       = 'Bird Seed',
    weight      = 50,
    type        = 'item',
    image       = 'bird_seed.png',
    unique      = false,
    useable     = true,
    shouldClose = true,
    description = 'Basic feed for carrier birds',
},

-- ── Premium Treats ───────────────────────────────────────────
-- Useable — nutritious treat that restores hunger and loyalty.
['bird_treats'] = {
    name        = 'bird_treats',
    label       = 'Premium Treats',
    weight      = 50,
    type        = 'item',
    image       = 'bird_treats.png',
    unique      = false,
    useable     = true,
    shouldClose = true,
    description = 'Highly nutritious treats for carrier birds',
},

-- ── Bird Medicine ────────────────────────────────────────────
-- Useable — restores bird health; can revive a gravely ill bird.
['bird_medicine'] = {
    name        = 'bird_medicine',
    label       = 'Bird Medicine',
    weight      = 100,
    type        = 'item',
    image       = 'bird_medicine.png',
    unique      = false,
    useable     = true,
    shouldClose = true,
    description = 'Medicine to heal or revive a carrier bird',
},

-- ── Training Rope ────────────────────────────────────────────
-- Useable — improves bird flight agility and grants speed XP.
['bird_training_rope'] = {
    name        = 'bird_training_rope',
    label       = 'Training Rope',
    weight      = 200,
    type        = 'item',
    image       = 'bird_training_rope.png',
    unique      = false,
    useable     = true,
    shouldClose = true,
    description = 'A rope used to train carrier birds in agility',
},

-- ── Training Perch ───────────────────────────────────────────
-- Useable — builds bird stamina and reduces recovery time.
['bird_training_perch'] = {
    name        = 'bird_training_perch',
    label       = 'Training Perch',
    weight      = 300,
    type        = 'item',
    image       = 'bird_training_perch.png',
    unique      = false,
    useable     = true,
    shouldClose = true,
    description = 'A perch used to train carrier birds in stamina',
},
