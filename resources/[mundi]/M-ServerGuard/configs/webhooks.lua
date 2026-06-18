MGuard.Webhooks = {
    -- Bot display name
    BotName = 'M-ServerGuard',

    -- Bot avatar URL
    BotAvatar = '',

    -- Server name (shown in embeds)
    ServerName = 'My RedM Server',

    -- Webhook URLs per category (set '' to disable that category)
    URLs = {
        -- Anti-cheat detections
        AntiCheat   = '',

        -- Economy anomalies & large transactions
        Economy     = '',

        -- Player join/leave/session
        Players     = '',

        -- Admin actions (kick, ban, etc.)
        AdminActions = '',

        -- General alerts
        Alerts      = '',

        -- Chat logs
        Chat        = '',

        -- Server events (resource start/stop, restarts)
        Server      = '',

        -- Daily analytics summary
        Analytics   = '',

        -- Catch-all: also send ALL webhooks to this URL (in addition to category)
        All         = '',

        -- Player screening results (join allowed, denied, or flagged)
        Screening   = '',
    },

    -- Embed colors per severity (decimal)
    Colors = {
        low      = 3447003,  -- Blue
        medium   = 16776960, -- Yellow
        high     = 15158332, -- Orange
        critical = 15548997, -- Red
        info     = 3066993,  -- Green
        neutral  = 9807270,  -- Grey
    },

    -- Rate limit: max webhooks per minute (Discord limit is 30)
    RateLimit = 25,
}
