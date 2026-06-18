-- |||||||||||||||||||||||||||||||||||||||||
-- ||                                     ||
-- ||                                     ||
-- ||  ░S░.░H░.░ ░D░e░v░e░l░o░p░m░e░n░t░  ||
-- ||                                     ||
-- ||                                     ||
-- |||||||||||||||||||||||||||||||||||||||||

Config = Config or {}

---------------------------------------------------------------------
-- Core
---------------------------------------------------------------------

-- Enables verbose script debug output in server/client console.
Config.Debug = false

-- Available: 'en' (English), 'es' (Spanish), 'de' (German), 'fr' (French)
Config.Locale = 'en'

-- Framework mode:
-- auto = detect started framework resources
-- vorp = force VORP paths
-- rsg  = force RSG paths
Config.Framework = 'auto' -- auto | vorp | rsg

-- Global interaction style for in-world points:
-- drawtext = marker + 3D text style
-- ingame   = native prompt-group style
-- target   = ox_target sphere zones
Config.Mode = 'ingame' -- drawtext | ingame | target

-- Third-eye config used when Config.Mode = 'target'.
Config.Target = {
    Resource = 'ox_target', -- ox_target resource name
    Debug = false,          -- enables zone debug
    Icons = {
        Store = 'fa-solid fa-store',
        Storage = 'fa-solid fa-box-open',
        Advert = 'fa-solid fa-image',
        JobCenter = 'fa-solid fa-briefcase',
        Crafting = 'fa-solid fa-hammer',
    },
}

---------------------------------------------------------------------
-- Commands
---------------------------------------------------------------------

Config.Commands = {
    Society = 'society',      -- player/boss panel
    SocietyAdmin = 'socadmin', -- admin panel
    Bills = 'bills',          -- player bills window
    Invoice = 'invoice',      -- quick invoice window for allowed jobs/ranks
}

---------------------------------------------------------------------
-- Security
---------------------------------------------------------------------

Config.Security = {
    EventCooldownMs = 300, -- per-action request cooldown
    MaxString = 256,       -- generic max string length guard
    MaxReason = 512,       -- max reason/description payload length
    MaxAmount = 1000000,   -- upper numeric payload clamp
}

---------------------------------------------------------------------
-- Admin Access
---------------------------------------------------------------------

Config.Admin = {
    Ace = {
        Enabled = true,
        Permission = 'sh.society.admin', -- ACE node required when ACE mode is enabled
    },
    -- Fallback/admin-group checks via framework group data.
    UserGroups = {
        admin = true,
        god = true,
        superadmin = true,
        mod = true,
    },
}

---------------------------------------------------------------------
-- Society Rules
---------------------------------------------------------------------

Config.Society = {
    MaxRanks = 15,                  -- hard cap for rank count
    MinRanks = 1,                   -- minimum allowed rank count
    DefaultRankCount = 5,           -- ranks created for a new society
    DefaultTaxPercent = 10.0,       -- default tax reserve split for new societies
    DefaultEntryGrade = 0,          -- default entry grade for public hires
    UnemployedJob = 'unemployed',   -- framework job assigned on fire
    HireDistance = 12.0,            -- max hire/proposal distance
    HireOfferTimeoutSeconds = 30,   -- hire offer expiry timer
}

---------------------------------------------------------------------
-- Payroll
---------------------------------------------------------------------

Config.Payroll = {
    Enabled = true,
    IntervalMinutes = 15,    -- global default (per-society override exists in DB/UI)
    MinIntervalMinutes = 1,  -- lower clamp for per-society timer
    MaxIntervalMinutes = 240, -- upper clamp for per-society timer
    MoneyType = 'cash',      -- payout money type (bridge resolves framework specifics)
}

---------------------------------------------------------------------
-- Billing
---------------------------------------------------------------------

Config.Billing = {
    Currency = 'cash',      -- invoice payment currency
    CommandPageSize = 25,   -- invoice list size for quick command window
}

---------------------------------------------------------------------
-- Job Center (public self-hire board)
---------------------------------------------------------------------

Config.JobCenter = {
    Enabled = true,
    Model = 'u_m_m_valtownfolk_01',
    -- Currently set for Blackwater Reborn 2 (Spooni). Adjust for your map.
    Coords = vector4(-784.26, -1347.35, 43.75, 90.71),
    Distance = 2.2,     -- interact range
    CleanupRadius = 2.75, -- removes duplicate job center NPCs near this point on restart
    CooldownMs = 5000,  -- anti-spam on interact
    SwitchCooldownHours = 1.0, -- hours between successful public job changes; decimals accepted (0 = disabled)
    Prompt = {
        Control = 0x760A9C6F, -- G
        KeyLabel = 'G',
        DisplayDistance = 6.5,
        TextOffsetZ = 1.0,
    },
    DefaultPublicJobs = {
        -- Config-driven public jobs:
        -- - players can self-hire from job center
        -- - payroll is config-driven (not boss-managed / not society-ledger funded)
        { jobName = 'hunter', label = 'Wildlife Hunter', grade = 0, salary = 15, payrollIntervalMinutes = 15, description = 'Hunting wildlife for a living.' },
    },
    Blip = {
        Enabled = true,
        Sprite = -272216216, -- blip_job_board
        Scale = 0.2,
        Label = 'Public Job Center',
    },
}

---------------------------------------------------------------------
-- Society Storage
---------------------------------------------------------------------

Config.Storage = {
    Enabled = true,
    DefaultMaxWeight = 2000000,
    DefaultSlots = 60,
    OpenDistance = 3.0,    -- server-side stash open check distance
    DrawDistance = 18.0,   -- marker draw distance
    InteractDistance = 2.2, -- prompt interact distance
    Prompt = {
        Control = 0x760A9C6F, -- G
        KeyLabel = 'G',
        DisplayDistance = 6.5,
        TextOffsetZ = 1.0,
    },
    Marker = {
        Type = 0x94FDAE17,
        SnapToGround = true,
        LiftZ = 0.03,
        Scale = { x = 0.9, y = 0.9, z = 0.18 },
        Color = { r = 102, g = 160, b = 210, a = 190 },
    },
}

---------------------------------------------------------------------
-- Stores
---------------------------------------------------------------------

Config.Store = {
    Enabled = true,
    MaxPerSociety = 2, -- 0 = unlimited
    BuyDistance = 2.2, -- server-side buy/sell validation distance
    OpenMode = 'ui',   -- ui = custom storefront NUI
    RefreshMs = 30000, -- world store cache refresh interval
    PropStreamDistance = 70.0, -- client-side distance for showing store world props
    -- Prop choices shown in the Store tab dropdown.
    -- Select "No Prop" in UI to disable a world prop for a store.
    PropList = {
        'p_cratetablemil01x',
        'p_cratetable01x',
    },
    DrawDistance = 18.0,
    InteractDistance = 2.2,
    Prompt = {
        Control = 0x760A9C6F, -- G
        KeyLabel = 'G',
        DisplayDistance = 6.5,
        TextOffsetZ = 1.0,
    },
    Marker = {
        Type = 0x94FDAE17,
        SnapToGround = true,
        LiftZ = 0.03,
        Scale = { x = 1.0, y = 1.0, z = 0.2 },
        Color = { r = 226, g = 176, b = 84, a = 200 },
    },
    Menu = {
        Controls = {
            Next = 0xA5BDCD3C, -- ]
            Prev = 0x430593AA, -- [
            Buy = 0x2CD5343E,  -- Enter
            Close = 0x156F7119, -- Backspace
        },
        Labels = {
            Next = ']',
            Prev = '[',
            Buy = 'ENTER',
            Close = 'BACKSPACE',
        },
        MinQty = 1,
        MaxQty = 2000,
    },
}

---------------------------------------------------------------------
-- Advertisements
---------------------------------------------------------------------

Config.Advertising = {
    Enabled = true,
    MaxPerSociety = 5, -- 0 = unlimited
    RefreshMs = 30000,
    StreamDistance = 70.0, -- prop stream/create distance
    InteractDistance = 2.4,
    Prompt = {
        Control = 0x760A9C6F, -- G
        KeyLabel = 'G',
        DisplayDistance = 7.0,
        TextOffsetZ = 1.0,
    },
    -- Prop choices shown in the Society UI dropdown.
    -- First entry is the default when creating a new advertisement.
    PropList = {
        'p_menuboardnbx01x',
        'p_sandwichboard01x',
    },
    -- Used when advert has no image or URL fails validation/render.
    DefaultImage = 'img/no-image.jpg',
}

---------------------------------------------------------------------
-- Discord Webhooks
---------------------------------------------------------------------

Config.Webhooks = {
    Enabled = true,         -- master toggle
    Username = 'sh-society', -- bot name shown in Discord
    AvatarURL = '',         -- optional avatar URL
    -- Fallback URL used when a channel URL below is blank.
    Default = '',
    Channels = {
        admin = '',     -- society create/update/delete and admin-level actions
        boss = '',      -- boss-facing management updates
        billing = '',   -- invoice creation/payment
        payroll = '',   -- payroll payout/skip cycles
        stores = '',    -- store setup/stock/price/sales/buyback
        adverts = '',   -- advert create/update/delete/place
        blips = '',     -- blip create/update/delete/enable/disable
        employees = '', -- hire/fire/promote/demote
        ranks = '',     -- rank count/name/salary/permission updates
        ledger = '',    -- ledger deposits/withdrawals
        audit = '',     -- successful action logs
        taxes = '',     -- tax reserve movement logs
        security = '',  -- denied/failed security/audit logs
    },
}

-- Lets bosses configure one Discord webhook URL per society from the in-game UI.
-- When disabled, the Discord tab is hidden and society-owned webhooks will not send.
Config.IngameWebhook = {
    Enabled = true,
}

---------------------------------------------------------------------
-- Theme Presets
---------------------------------------------------------------------

Config.Themes = {
    PresetIcons = {
        'star',
        'eagle',
        'shield',
        'coins',
        'store',
        'wrench',
    },
    PresetColors = {
        '#9e7840',
        '#6f4f27',
        '#8f312a',
        '#2f6b4a',
        '#3d5f89',
        '#d8c19b',
    },
}
