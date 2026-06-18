MGuard.Web = {
    -- Enable the local web dashboard (accessible from browser)
    Enabled = true,

    -- (Optional) Your server's PUBLIC IP address or domain name.
    -- If left blank, M-ServerGuard will auto-detect the server's public IP on startup.
    -- Set this manually if auto-detection fails or you use a domain/proxy.
    -- Example: '123.45.67.89'  or  'play.yourdomain.com'
    -- DO NOT set this to an admin's personal IP — it should always be the SERVER's IP.
    ServerIP = '',

    -- Token expiry: "hours", "days", or "never"
    TokenExpireMode = 'days',

    -- Token expiry value (ignored when mode is "never")
    -- hours mode: value in hours (e.g. 48 = 2 days)
    -- days mode: value in days (e.g. 7 = one week)
    TokenExpireValue = 7,

    -- Cleanup expired tokens interval (minutes, 0 to disable)
    TokenCleanupInterval = 30,

    -- DEV MODE: Skip token validation entirely.
    -- Set true ONLY for local development/testing — never in production.
    -- When false (recommended), admins authenticate via the in-game /guard command
    -- which auto-generates and injects a session token into the NUI dashboard.
    -- Browser dashboard users can get a token with: /mguard webtoken (in-game)
    DevBypassAuth = false,
}
