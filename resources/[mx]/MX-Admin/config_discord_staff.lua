--[[
    Admin panel and reports access only via Discord roles (no RSGCore admin / ACE).
    1. Create a bot at https://discord.com/developers/applications
    2. Enable "SERVER MEMBERS INTENT" under Bot > Privileged Gateway Intents
    3. Invite the bot to the server with "View channels" permission (and scopes to read members)
    4. Copy Guild ID (server) and Role IDs (Developer mode > right-click role > Copy ID)
    Without GuildId, BotToken and role IDs filled in, nobody has staff access.
]]

Config.DiscordStaff = {
    GuildId = '1504810656929419325',   -- Numeric Discord server ID
    -- Put the token here (do not share the file). If exposed, regenerate in Discord Developer Portal > Bot > Reset Token.
    BotToken = 'MTUxMTk2MzQxNDgzMzAwNDU5NA.GIigfm.JdlIomkGQVWmg6OL1CFKxMYsWZYpVLx_SxQ0-M',

    --- Role cache duration (seconds) to avoid hitting the API on every click
    CacheSeconds = 300,

    --- Permission matrix in the panel: only members with this role (key in Roles), e.g. "founder".
    --- If empty string or nil, only PermissionEditorMinRank (numeric level 1–4) is used.
    PermissionEditorRoleKey = 'founder',
    PermissionEditorMinRank = 1,

    --- true (default): no DB row = denied for non-founder roles. Founder defaults to all Allow (see below).
    --- Exception: users who can edit the matrix (PermissionEditorRoleKey) can always open the panel (adminmenu)
    --- so you are not locked with no DB rows; other actions still follow the matrix only.
    PermissionMatrixStrictDefault = false,

    --- Role key that gets every permission allowed by default (no DB row = Allow). Set false to require DB like others.
    PermissionMatrixFounderDefaultsAllow = true,
    --- Must match a key in Roles (usually founder).
    PermissionMatrixFounderRoleKey = 'founder',

    --- Once per session, in client F8: "YOU ARE <label>" when Discord confirms staff role.
    NotifyStaffRoleInF8 = true,
    RankLabels = {
        [1] = 'SUPPORT',
        [2] = 'ADMIN',
        [3] = 'DIRECTOR',
        [4] = 'FOUNDER',
    },

    --- Discord role IDs (strings). Any of them grants "staff" with the level below.
    --- Role keys (founder, diretor, …). What each role can do is set in the matrix
    --- (panel → Permissions) or stays off if PermissionMatrixStrictDefault = true.
    Roles = {
        -- RECOVERY MODE (temporary):
        -- @everyone role ID in Discord is the same as Guild ID.
        -- Use this only to unlock access while you copy real staff role IDs.
        -- IMPORTANT: replace these values with real role IDs after testing.
        founder = '1504810656929419325', -- level 4 (temporary fallback = GuildId/@everyone)
        diretor = 'ROLE ID HERE', -- level 3 (temporary fallback = GuildId/@everyone)
        admin = 'ROLE ID HERE',   -- level 2 (temporary fallback = GuildId/@everyone)
        suporte = 'ROLE ID HERE', -- level 1 (temporary fallback = GuildId/@everyone)
    },
}

Config.DiscordStaff.RoleRank = {
    suporte = 1,
    admin = 2,
    diretor = 3,
    founder = 4,
}
