-- ╔═══════════════════════════════════════════════════════════════╗
-- ║         M-DELIVERIES - DISCORD LOGGING CONFIGURATION         ║
-- ╚═══════════════════════════════════════════════════════════════╝

DiscordConfig = {}

-- ═══════════════════════════════════════════════════════════════════
--                         GLOBAL TOGGLE
-- ═══════════════════════════════════════════════════════════════════

DiscordConfig.enabled = true                    -- Master switch for all Discord logging

-- ═══════════════════════════════════════════════════════════════════
--                         WEBHOOK SETTINGS
-- ═══════════════════════════════════════════════════════════════════
-- You can use a single webhook for everything, or set separate webhooks
-- per category. Leave a category blank/nil to use the default webhook.

DiscordConfig.webhookURL = ""

-- Per-category webhooks (optional — leave empty "" to use the default above)
DiscordConfig.webhooks = {
    missions = "",      -- Delivery started/completed/failed/cancelled
    economy  = "",      -- Payouts, money tracking
    law      = "",      -- Law inspections, seizures, evidence
    admin    = "",      -- Admin commands and actions
}

-- Bot Appearance
DiscordConfig.botName = "Delivery Foreman"          -- Bot name shown in Discord
DiscordConfig.botAvatar = ""                        -- Bot avatar URL (leave empty for default)

-- ═══════════════════════════════════════════════════════════════════
--                          EMBED COLORS
-- ═══════════════════════════════════════════════════════════════════
-- Colors in decimal format. Use https://www.spycolor.com to convert.

DiscordConfig.colors = {
    success  = 3066993,     -- Green (#2ECC71)  — Successful deliveries
    warning  = 15105570,    -- Orange (#E67E22) — Warnings, cancelled
    error    = 15158332,    -- Red (#E74C3C)    — Failed deliveries
    info     = 3447003,     -- Blue (#3498DB)   — General info, started
    special  = 10181046,    -- Purple (#9B59B6) — High value, milestones
    ambush   = 15844367,    -- Gold (#F1C40F)   — Ambush events
    admin    = 15277667,    -- Coral (#E91E63)  — Admin actions
    law      = 1752220,     -- Teal (#1ABC9C)   — Law enforcement events
    economy  = 2067276,     -- Dark Green (#1F8B4C) — Economy/payouts
}

-- ═══════════════════════════════════════════════════════════════════
--                         EVENT TOGGLES
-- ═══════════════════════════════════════════════════════════════════
-- Enable/disable individual event types.

DiscordConfig.events = {
    -- Mission Events
    deliveryStarted    = true,      -- Player starts a delivery
    deliveryCompleted  = true,      -- Player completes a delivery
    deliveryFailed     = true,      -- Player fails a delivery
    deliveryCancelled  = true,      -- Player cancels a delivery

    -- Ambush Events
    ambushTriggered    = true,      -- Ambush spawns on a player
    ambushSurvived     = true,      -- Player survives an ambush

    -- Progression Events
    highValueDelivery  = true,      -- High-payout delivery completed
    levelUp            = true,      -- Player levels up
    milestoneReached   = true,      -- Milestone achievement (100 deliveries, etc.)

    -- Group Events
    groupDelivery      = true,      -- Group/posse delivery completed (with payout breakdown)

    -- Law Enforcement Events
    lawInspection      = true,      -- Law officer inspects a wagon
    lawSeizure         = true,      -- Law officer seizes a wagon
    lawEvidence        = true,      -- Law officer delivers all evidence

    -- Admin Events
    adminActions       = true,      -- Admin commands (addrep, setrep, cancel, etc.)

    -- Economy Events
    economyPayout      = true,      -- Individual payout tracking
}

-- ═══════════════════════════════════════════════════════════════════
--                         THRESHOLDS
-- ═══════════════════════════════════════════════════════════════════

DiscordConfig.thresholds = {
    highValueAmount = 100,                              -- Minimum payout ($) to log as "high value"
    milestones = {10, 25, 50, 100, 250, 500, 1000},     -- Delivery count milestones to log
}

-- ═══════════════════════════════════════════════════════════════════
--                      EMBED APPEARANCE
-- ═══════════════════════════════════════════════════════════════════

DiscordConfig.footer = "M-Deliveries"  -- Footer text on all embeds
DiscordConfig.showTimestamp = true              -- Show timestamp on embeds
