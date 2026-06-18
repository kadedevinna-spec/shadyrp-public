-- ╔═══════════════════════════════════════════════════════════════╗
-- ║            M-RAIDS - DISCORD LOGGING CONFIGURATION           ║
-- ╚═══════════════════════════════════════════════════════════════╝

DiscordConfig = {}

-- ═══════════════════════════════════════════════════════════════════
--                         GLOBAL TOGGLE
-- ═══════════════════════════════════════════════════════════════════

DiscordConfig.enabled = false                    -- Master switch for all Discord logging

-- ═══════════════════════════════════════════════════════════════════
--                         WEBHOOK SETTINGS
-- ═══════════════════════════════════════════════════════════════════
-- You can use a single webhook for everything, or set separate webhooks
-- per category. Leave a category blank ("") to fall back to the default.

DiscordConfig.webhookURL = ""                   -- Default / fallback webhook

DiscordConfig.webhooks = {
    raids   = "",       -- Raid started, completed, abandoned
    combat  = "",       -- Enemy kills, reinforcements, waves
    loot    = "",       -- Loot chest opened, items awarded
    admin   = "",       -- Admin commands (/raidstart, /testraidwave, etc.)
}

-- Bot Appearance
DiscordConfig.botName   = "Raid Commander"
DiscordConfig.botAvatar = ""                    -- URL to bot avatar image (leave "" for default)

-- ═══════════════════════════════════════════════════════════════════
--                          EMBED COLORS
-- ═══════════════════════════════════════════════════════════════════
-- Decimal color values. Convert hex at https://www.spycolor.com/

DiscordConfig.colors = {
    started      = 3447003,     -- Blue   (#3498DB) — Raid started
    completed    = 3066993,     -- Green  (#2ECC71) — Raid completed / loot opened
    abandoned    = 15105570,    -- Orange (#E67E22) — Raid abandoned / timed out
    failed       = 15158332,    -- Red    (#E74C3C) — Raid failed
    combat       = 15844367,    -- Gold   (#F1C40F) — Enemy kills / reinforcements
    loot         = 10181046,    -- Purple (#9B59B6) — Loot events
    admin        = 15277667,    -- Coral  (#E91E63) — Admin actions
    info         = 1752220,     -- Teal   (#1ABC9C) — Misc info
}

-- ═══════════════════════════════════════════════════════════════════
--                         EVENT TOGGLES
-- ═══════════════════════════════════════════════════════════════════

DiscordConfig.events = {
    -- Raid Lifecycle
    raidStarted      = true,    -- A raid is initiated by a player
    raidCompleted    = true,    -- All loot has been claimed and raid ends
    raidAbandoned    = true,    -- Raid abandoned (host dropped, timed out, etc.)

    -- Combat
    waveStarted      = true,    -- A new enemy wave spawns
    reinforcements   = true,    -- Cavalry reinforcements arrive
    enemyKill        = false,   -- Individual enemy kill (high volume — disabled by default)

    -- Loot
    lootOpened       = true,    -- A loot chest is successfully opened
    lootItems        = true,    -- Include item list in loot embed

    -- Admin
    adminCommands    = true,    -- Admin commands that trigger raids/waves
}

-- ═══════════════════════════════════════════════════════════════════
--                      EMBED APPEARANCE
-- ═══════════════════════════════════════════════════════════════════

DiscordConfig.footer        = "M-Raids"
DiscordConfig.showTimestamp = true
