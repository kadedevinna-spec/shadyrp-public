MGuard = {}

---------------------------------------------------------------------------
-- GENERAL
---------------------------------------------------------------------------
MGuard.General = {
    -- Debug mode (prints extra info to console)
    Debug = false,

    -- Language: 'en', 'de', 'fr'
    Language = 'en',

    -- Command to open the admin dashboard
    DashboardCommand = 'guard',

    -- Keybind to open dashboard (set false to disable)
    -- Uses INPUT_FRONTEND_SOCIAL_CLUB_SECONDARY (F10)
    DashboardKey = 0x6C78B7B3,

    -- Permission groups that can access the dashboard
    AdminGroups = { 'admin', 'superadmin', 'moderator', 'owner', 'mod', 'helper' },

    -- Server owner Steam identifier (steam:xxxxxxxxxxxxxxxxx)
    -- This account will ALWAYS have owner rank and cannot be demoted by anyone.
    -- Set this once and never share it. Leave empty to disable owner lock.
    OwnerSteam = '',

    -- Resource name (auto-detected, override if renamed)
    ResourceName = GetCurrentResourceName(),

    -- Enable whitelist system (check whitelist on connect)
    UseWhitelist = false,

    -- How often to save periodic data (seconds)
    SaveInterval = 300, -- 5 minutes

    -- Data retention (days) - logs older than this are purged
    DataRetention = {
        Logs       = 90,  -- General logs
        Economy    = 60,  -- Economy transaction logs
        Positions  = 7,   -- Player position snapshots
        Sessions   = 90,  -- Session history
        Chat       = 30,  -- Chat messages
        Alerts     = 60,  -- Alert history
        Deaths     = 60,  -- Death/kill logs
        Commands   = 30,  -- Command usage
        Metrics    = 365, -- Server metrics (keep 1 year)
        Detections = 90,  -- Anti-cheat detections
        ItemTransfers = 90,   -- item transfer records (days)
        ProximityLog  = 30,   -- proximity interaction log (days)
    },
}
---------------------------------------------------------------------------
-- CUSTOM BANK SCRIPT INTEGRATION
---------------------------------------------------------------------------
-- Connect a third-party bank script so its balances are tracked in the
-- economy log alongside framework money/gold.
--
-- Two modes:
--   'sql'    – query the bank table(s) directly. Works for any bank script
--              with a database table. Balances from multiple table entries
--              are SUMMED, so scripts that split savings/checking into
--              separate rows or tables are handled automatically.
--   'export' – call exports[Resource]:Function(charId) → number.
--              More accurate if the bank script exposes an export.
--
-- IdentifierColumn must hold the same value as charIdentifier in mguard_players:
--   RSG  →  citizenid  (e.g. "REF12345")
--   VORP →  charIdentifier (numeric, stored as a string in some scripts)
--
-- Leave Enabled = false to disable entirely with zero performance impact.
MGuard.BankIntegration = {
    Enabled = false,
    Mode    = 'sql',   -- 'sql' | 'export'
    Label   = 'Bank',  -- label shown in economy log UI

    -- SQL mode: list every table that holds a balance you want to track.
    -- All matched rows are summed into a single balance value.
    -- Optional Filter: extra WHERE clause (do NOT include the WHERE keyword).
    SQL = {
        { Table = 'bank_accounts', IdentifierColumn = 'citizenid', BalanceColumn = 'balance' },
        -- Examples:
        -- { Table = 'bank_savings',  IdentifierColumn = 'citizenid', BalanceColumn = 'amount' },
        -- { Table = 'bank_accounts', IdentifierColumn = 'owner',     BalanceColumn = 'balance', Filter = "type = 'checking'" },
    },

    -- Export mode: call exports[Resource]:Function(charIdentifier) → number
    Export = {
        Resource = 'murphysbank',
        Function = 'getBalance',
    },

    -- Flag any single-poll balance change exceeding this amount
    LargeTransactionThreshold = 5000,
}

-- Anti-cheat config moved to configs/anticheat.lua

---------------------------------------------------------------------------
-- ECONOMY MONITORING
---------------------------------------------------------------------------
MGuard.Economy = {
    Enabled = true,

    -- Track all money transactions
    TrackMoney = true,

    -- Track all item transactions
    TrackItems = true,

    -- Track gold transactions
    TrackGold = true,

    -- Snapshot economy totals every X minutes
    SnapshotInterval = 15,

    -- Duplication detection: flag if same item+metadata appears multiple times in short window
    DuplicationDetection = true,
    DuplicationWindow = 60, -- seconds

    -- Large transaction alerts
    LargeTransactionThreshold = {
        Money = 1000,
        Gold  = 100,
        Items = 50, -- item count
    },

    -- Track item sources (which script/event caused the item change)
    TrackSources = true,
}

---------------------------------------------------------------------------
-- PLAYER MONITORING
---------------------------------------------------------------------------
MGuard.Players = {
    -- Track player sessions (connect/disconnect)
    TrackSessions = true,

    -- Track player positions periodically
    TrackPositions = true,
    PositionInterval = 60, -- seconds between snapshots

    -- Track deaths and kills
    TrackDeaths = true,

    -- Track player identifiers (steam, discord, license, ip)
    TrackIdentifiers = true,

    -- Track hardware tokens for HWID banning
    TrackTokens = true,

    -- Track job/group changes
    TrackJobChanges = true,

    -- Maximum players to show per page in dashboard
    PlayersPerPage = 20,
}

---------------------------------------------------------------------------
-- RESOURCE MONITORING
---------------------------------------------------------------------------
MGuard.Resources = {
    Enabled = true,

    -- Auto-scan all running resources on startup
    AutoScan = true,

    -- Scan interval (seconds) - check for new/stopped resources
    ScanInterval = 60,

    -- Log resource start/stop events
    TrackStartStop = true,

    -- Detect unauthorized resources (not in whitelist)
    DetectUnauthorized = false,

    -- Known resource prefixes for categorization
    Categories = {
        { prefix = 'vorp_',  category = 'VORP Framework' },
        { prefix = 'rsg-',   category = 'RSG Framework' },
        { prefix = 'bcc-',   category = 'BCC Scripts' },
        { prefix = 'btc-',   category = 'BTC Scripts' },
        { prefix = 'ox_',    category = 'Overextended' },
        { prefix = 'M-',     category = 'Mundi Scripts' },
    },
}

---------------------------------------------------------------------------
-- CHAT MONITORING
---------------------------------------------------------------------------
MGuard.Chat = {
    Enabled = true,

    -- Log all chat messages
    LogMessages = true,

    -- Detect spam (same message repeated)
    SpamDetection = true,
    SpamThreshold = 3,    -- same message X times
    SpamWindow = 10,      -- within X seconds

    -- Word filter (messages containing these trigger alerts)
    FilteredWords = {},

    -- Command logging (track all / commands)
    LogCommands = true,
}

---------------------------------------------------------------------------
-- BAN SYSTEM
---------------------------------------------------------------------------
MGuard.Bans = {
    Enabled = true,

    -- Support HWID bans (hardware token banning)
    HWIDBan = true,

    -- Support IP bans
    IPBan = true,

    -- Ban appeal system
    Appeals = true,

    -- Max ban history shown per player
    MaxHistory = 50,
}

---------------------------------------------------------------------------
-- ALERTS & NOTIFICATIONS
---------------------------------------------------------------------------
MGuard.Alerts = {
    -- In-game notification for online admins
    NotifyAdmins = true,

    -- Discord webhook notifications
    DiscordEnabled = true,

    -- Alert cooldown per type per player (seconds) to prevent spam
    AlertCooldown = 60,

    -- Severity levels and their colors (for dashboard)
    Severities = {
        low      = { color = '#3b82f6', label = 'Low' },
        medium   = { color = '#f59e0b', label = 'Medium' },
        high     = { color = '#ef4444', label = 'High' },
        critical = { color = '#dc2626', label = 'Critical' },
    },
}

---------------------------------------------------------------------------
-- ANALYTICS
---------------------------------------------------------------------------
MGuard.Analytics = {
    -- Server metrics snapshot interval (seconds)
    MetricsInterval = 60,

    -- Track peak player counts
    TrackPeakPlayers = true,

    -- Track total economy (sum of all player money/gold)
    TrackEconomyTotals = true,

    -- Generate daily summary
    DailySummary = true,
    DailySummaryTime = 0, -- hour (0-23) in server time to generate summary

    -- Trending analysis window (days)
    TrendingWindow = 7,
}

---------------------------------------------------------------------------
-- ADMIN PERMISSIONS
---------------------------------------------------------------------------
MGuard.Permissions = {
    -- Role hierarchy (higher number = more power)
    Roles = {
        helper    = { level = 1, label = 'Helper' },
        moderator = { level = 2, label = 'Moderator' },
        admin     = { level = 3, label = 'Admin' },
        superadmin = { level = 4, label = 'Super Admin' },
        owner     = { level = 5, label = 'Owner' },
    },

    -- Permission flags per role
    RolePermissions = {
        helper = {
            'view_dashboard', 'view_players', 'view_logs',
            'view_alerts', 'spectate', 'view_reports',
        },
        moderator = {
            'view_dashboard', 'view_players', 'view_logs', 'view_alerts',
            'view_economy', 'spectate', 'kick', 'warn', 'mute',
            'teleport_to', 'freeze', 'view_inventory',
            'view_reports', 'manage_reports', 'view_admin_chat',
            'view_leaderboard',
        },
        -- 'mod' as alias for moderator
        mod = {
            'view_dashboard', 'view_players', 'view_logs', 'view_alerts',
            'view_economy', 'spectate', 'kick', 'warn', 'mute',
            'teleport_to', 'freeze', 'view_inventory',
            'view_reports', 'manage_reports', 'view_admin_chat',
            'view_leaderboard',
        },
        admin = {
            'view_dashboard', 'view_players', 'view_logs', 'view_alerts',
            'view_economy', 'view_analytics', 'view_resources',
            'spectate', 'kick', 'warn', 'mute', 'ban', 'unban',
            'teleport_to', 'teleport_bring', 'freeze', 'kill', 'revive',
            'view_inventory', 'add_item', 'remove_item',
            'add_money', 'remove_money', 'set_job',
            'manage_whitelist', 'export_data',
            'view_reports', 'manage_reports', 'view_admin_chat',
            'view_leaderboard', 'view_teleports', 'view_screening',
            'view_anticheat', 'manage_anticheat',
            'weather_control', 'server_announce',
            'manage_blips', 'edit_character', 'spawn_entity',
        },
        superadmin = {
            'view_dashboard', 'view_players', 'view_logs', 'view_alerts',
            'view_economy', 'view_analytics', 'view_resources',
            'spectate', 'kick', 'warn', 'mute', 'ban', 'unban',
            'teleport_to', 'teleport_bring', 'freeze', 'kill', 'revive',
            'view_inventory', 'add_item', 'remove_item',
            'add_money', 'remove_money', 'set_job',
            'manage_whitelist', 'export_data',
            'manage_permissions', 'view_anticheat', 'manage_anticheat',
            'server_restart', 'resource_control', 'view_screening',
            'view_reports', 'manage_reports', 'view_admin_chat',
            'view_leaderboard', 'view_teleports',
            'weather_control', 'server_announce', 'server_management',
            'manage_blips', 'manage_admins', 'edit_character', 'spawn_entity',
        },
        owner = {
            '*', -- All permissions
        },
    },
}

---------------------------------------------------------------------------
-- PLAYER SCREENING (Smart Detection)
---------------------------------------------------------------------------
MGuard.Screening = {
    Enabled = true,

    -- Steam Web API key (free — get one at https://steamcommunity.com/dev/apikey)
    -- Required for Steam profile checks (account age, bans, profile visibility)
    SteamAPIKey = '',

    -- What to check on player connect
    CheckSteamProfile = true,       -- Account age, profile visibility
    CheckVACBans = true,            -- VAC bans & game bans via Steam
    CheckAltAccounts = true,        -- Cross-reference IP/HWID/license with banned players
    RequireDiscord = false,         -- Kick player if they have no Discord linked to Steam

    -- Account age thresholds (days)
    NewAccountDays = 30,            -- Flag as "very new" if younger than this
    SuspiciousAccountDays = 90,     -- Flag as "new-ish" if younger than this

    -- Trust score penalties (subtracted from 100)
    Penalties = {
        VACBan = 30,                -- Per VAC ban on their Steam account
        GameBan = 25,               -- Per game ban on their Steam account
        CommunityBan = 20,          -- Steam community ban active
        NewAccount = 25,            -- Account younger than NewAccountDays
        SuspiciousAccount = 10,     -- Account younger than SuspiciousAccountDays
        PrivateProfile = 15,        -- Steam profile set to private
        AltOfBanned = 40,           -- Shares IP/HWID/license with a banned player
        PreviousBanHere = 35,       -- Was previously banned on this server
        NoDiscord = 5,              -- No Discord identifier linked
    },

    -- Alert threshold (0-100, players scoring below this get flagged)
    AlertThreshold = 50,

    -- Deny connection below this score (0 = never deny, just alert)
    DenyThreshold = 0,

    -- Hard deny: reject players with no Steam account at all.
    RequireSteam = false,
    RequireSteamKickMessage = 'You must have Steam running to connect to this server.',

    -- Hard deny: reject accounts newer than X days. 0 = disabled.
    -- Recommended: 7–14 to block throwaway accounts used for ban evasion.
    MinAccountAgeDeny = 0,
    MinAccountAgeMessage = 'Your Steam account is too new to join this server.',

    -- Hard deny: reject players whose most recent VAC/game ban is less than X days old.
    -- 0 = disabled. Example: 365 = deny anyone banned within the last year.
    MaxDaysSinceLastBan = 0,
    MaxDaysSinceLastBanMessage = 'You have a recent ban on record and cannot join this server.',

    -- Hard deny: reject players with private Steam profiles.
    HardDenyPrivateProfile = false,
    PrivateProfileKickMessage = 'Your Steam profile must be set to public to join this server.',

    -- Show screening status to connecting player
    -- (e.g. "Verifying account..." while checking Steam API)
    ShowDeferralStatus = true,

    -- Cache screening results (hours) — don't re-check Steam API every connect
    CacheHours = 24,

    -- Log all screenings (even clean ones) to database
    LogAll = false,
}

---------------------------------------------------------------------------
-- EXTERNAL BAN LISTS
---------------------------------------------------------------------------
MGuard.BanLists = {
    Enabled = false,   -- Enable checking external third-party ban lists on player connect
    Lists = {
        -- JSON arrays of { steam, discord, reason } objects.
        -- Keys must match: url, name, penalty, denyIfListed
        -- Example:
        -- { url = 'https://example.com/bans.json', name = 'Example Community Bans', penalty = 50, denyIfListed = false },
    },
    ShowDeferralStatus = true,  -- Show check status in connection deferral message
}

---------------------------------------------------------------------------
-- DISCORD BOT INTEGRATION
---------------------------------------------------------------------------
MGuard.Discord = {
    -- Your Discord bot token (create at https://discord.com/developers/applications)
    -- The bot must be a member of your Discord server
    BotToken = '',

    -- Your Discord server (guild) ID — right-click server icon → Copy Server ID
    GuildID = '',

    -- Require players to be in your Discord server to connect
    RequireMembership = false,
    MembershipKickMessage = 'You must be in our Discord server to play. discord.gg/yourserver',

    -- Require a specific role ID (leave empty = just require guild membership)
    -- Right-click the role in Discord → Copy Role ID
    RequiredRoleID = '',
    RoleKickMessage = 'You must have the Member role in our Discord to play.',

    -- Deny connection if player is banned from your Discord guild
    DenyIfGuildBanned = true,

    -- Trust score adjustments (when not using hard require)
    NotInGuildPenalty  = 20,   -- Not in guild at all
    MissingRolePenalty = 10,   -- In guild but missing required role
    GuildBanPenalty    = 50,   -- Banned from guild
}

---------------------------------------------------------------------------
-- EXTERNAL BAN LISTS (Community Warden)
---------------------------------------------------------------------------
---------------------------------------------------------------------------
-- TXADMIN SYNC
-- M-ServerGuard listens to txAdmin ban/unban events and mirrors them into
-- its own database automatically. You do NOT need to use M-ServerGuard's
-- ban button — just ban through txAdmin as normal and the script syncs.
-- This also means the Connections tab, Trust Score, and Screening flags
-- all reflect txAdmin-issued bans correctly.
---------------------------------------------------------------------------
MGuard.TxAdminSync = {
    -- txAdmin -> M-ServerGuard sync (receives bans/warns from txAdmin):
    -- Real-time: ban/warn/kick events synced into mguard_bans/mguard_warnings/mguard_admin_log
    -- Startup: all existing txAdmin bans & warns imported from playersDB.json (no duplicates)
    Enabled = true,

    -- Submit bans to the Mundi community ban list (see GitHubBanList.Mode = 'community')
    ContributeToCommunityList = false,

    ---------------------------------------------------------------------------
    -- OPTIONAL: Write M-ServerGuard bans back to txAdmin (two-way sync)
    -- When enabled, bans issued through M-ServerGuard (web panel, /gban, anti-cheat)
    -- are also created as bans in txAdmin, so they appear in txAdmin's ban list.
    ---------------------------------------------------------------------------
    WriteBackEnabled = false,      -- Set true to enable write-back to txAdmin
    TxAdminURL = 'http://localhost:40120',  -- txAdmin web panel URL
    TxAdminUsername = '',          -- txAdmin admin username (must have ban permission)
    TxAdminPassword = '',          -- txAdmin admin password

    ---------------------------------------------------------------------------
    -- OPTIONAL: Manual path override for txAdmin's playersDB.json
    -- Only needed if your FXServer resources folder is NOT inside your txData
    -- folder (non-standard setup). Leave empty for automatic detection.
    --
    -- Set to the full path of your txAdmin data folder:
    --   TxAdminDataPath = 'C:/txData/MyServer.base/data'
    -- Or directly to playersDB.json:
    --   TxAdminDataPath = 'C:/txData/MyServer.base/data/playersDB.json'
    ---------------------------------------------------------------------------
    TxAdminDataPath = '',
}

---------------------------------------------------------------------------
-- GITHUB BAN LIST
-- A shared JSON ban list that all M-ServerGuard servers can check on connect.
-- Two modes:
--
--   'community' — Uses the Mundi community ban list (public shared repo).
--                 All server owners running M-ServerGuard protect each other.
--                 Optionally contribute your own bans back to the community.
--
--   'private'   — Uses your own JSON file (GitHub repo, any raw URL).
--                 Full control, only your server's bans.
--
-- JSON format (array of ban objects):
-- [
--   { "steam": "steam:110000100000001", "reason": "Aimbot", "by": "ServerName", "permanent": true },
--   { "discord": "discord:123456789012345678", "reason": "Toxicity", "permanent": false },
--   { "license": "license:abc123", "reason": "Alt account", "permanent": true }
-- ]
---------------------------------------------------------------------------
MGuard.GitHubBanList = {
    Enabled = false,

    ---------------------------------------------------------------------------
    -- MODE:
    --   'community'  Check players against BOTH the shared Mundi community ban
    --                list (free alternative to V-Warden) AND this server's own
    --                txAdmin bans. Best for most servers.
    --   'private'    Check players against this server's txAdmin bans only.
    --                Use PrivateURL below if you also have your own ban list.
    ---------------------------------------------------------------------------
    Mode = 'community',

    ---------------------------------------------------------------------------
    -- PRIVATE MODE: your own ban list hosted on GitHub
    -- PrivateURL  = raw URL to a bans.json file (public or private repo)
    -- PrivateToken = GitHub token with 'contents:read' scope (private repos only)
    ---------------------------------------------------------------------------
    PrivateURL   = '',
    PrivateToken = '',

    -- How often to re-fetch the ban list (minutes)
    RefreshInterval = 30,

    -- Hard kick if found on ban list (false = penalize trust score only)
    DenyIfListed = true,

    -- Trust score penalty if DenyIfListed = false
    Penalty = 80,
}

---------------------------------------------------------------------------
-- CROSS-SERVER BAN SYNC (requires shared MySQL between your servers)
-- If your VORP and RSG servers point to the same MySQL database, any ban
-- issued on either server is automatically visible to both.
-- Zero extra cost or infrastructure needed.
---------------------------------------------------------------------------
MGuard.CrossServerSync = {
    -- Enable only if both servers share the same MySQL connection
    Enabled = false,

    -- Hard kick if banned on a linked server
    DenyIfBanned = true,

    -- Trust score penalty
    Penalty = 70,
}

---------------------------------------------------------------------------
-- MODERATION
---------------------------------------------------------------------------
MGuard.Moderation = {
    -- Number of active warnings before the player is automatically kicked.
    -- Set to 0 to disable auto-kick on warnings.
    WarningAutoKickThreshold = 3,
}

---------------------------------------------------------------------------
-- DASHBOARD UI
---------------------------------------------------------------------------
MGuard.UI = {
    -- Theme
    Theme = 'dark', -- 'dark' or 'light'

    -- Accent color
    AccentColor = '#e74c3c',

    -- Dashboard refresh rate (ms)
    RefreshRate = 5000,

    -- Max rows per table page
    RowsPerPage = 25,

    -- Chart colors
    ChartColors = {
        '#e74c3c', '#3498db', '#2ecc71', '#f39c12',
        '#9b59b6', '#1abc9c', '#e67e22', '#ecf0f1',
    },

    -- Date format for display
    DateFormat = '%Y-%m-%d %H:%M:%S',
}
