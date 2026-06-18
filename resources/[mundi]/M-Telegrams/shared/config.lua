-- ===============================================================
-- M-TELEGRAMS CONFIGURATION v1.0
-- The ultimate telegram system for VORP/RedM
--
-- SECTIONS:
--   1. Core / General
--   2. ID Generation & Registration
--   3. Player Personalization (Profile, Signature, Stamp)
--   4. Stations & Interaction
--   5. Composing & Sending
--   6. Inbox, Archive & Items
--   7. Contacts & Directory
--   8. Organizations (Companies & Businesses)
--   9. Notifications, Animations & Sounds
--  10. Admin, Maintenance & Discord
-- ===============================================================

Config = {}

-- ===============================================================
--  1. CORE / GENERAL
-- ===============================================================

Config.Debug = false
Config.Locale = "en"
Config.Framework = "RSG"  -- "VORP" or "RSG"
Config.Year = 1899        -- Year displayed on all telegram dates

-- ===============================================================
--  2. ID GENERATION & REGISTRATION
-- ===============================================================

-- ---------------------------------------------------------------
-- TELEGRAM ID GENERATION
-- Controls how auto-generated telegram IDs are created.
--
-- mode = "random"
--   Classic mode. Generates PREFIX-NNNN using CityPrefixes or TelegramIdLetters pool.
--   Each registration picks a random 4-digit number. If a player unregisters, their
--   number is freed and can be assigned to someone else.
--   Example: VL-4829, SD-1337
--
-- mode = "charid"
--   Uses the character's database ID as the number portion. The prefix comes from the
--   city they register at. Deterministic per character -- unregister & re-register gets
--   the same number again. NOTE: different characters from the same player get different
--   numbers (e.g. VL-3 and VL-7).
-- ---------------------------------------------------------------
Config.TelegramIdGeneration = {
    mode = "random",              -- "random" | "charid"
    zeroPad = 4,                  -- Zero-pad the number portion (0 = no padding, 4 = "0003")
}

-- Pool of letter groups for random fallback prefix (first 2 chars used when no city prefix)
Config.TelegramIdLetters = { 'CNH', 'BWR', 'SDN', 'VAL', 'RHD', 'STR', 'ANB', 'ARM', 'TMB' }

-- Maps each station city to its telegram ID prefix (used in both modes)
Config.CityPrefixes = {
    ["Valentine"]     = "VAL",
    ["Blackwater"]    = "BW",
    ["Saint Denis"]   = "SD",
    ["Rhodes"]        = "RH",
    ["Strawberry"]    = "ST",
    ["Annesburg"]     = "AN",
    ["Tumbleweed"]    = "TM",
    ["Armadillo"]     = "AR",
    ["Emerald Ranch"] = "ER",
}

-- ---------------------------------------------------------------
-- CUSTOM TELEGRAM IDS
-- Allow players to choose their own telegram ID at registration.
--
-- useCityPrefix:
--   false = player types the FULL custom ID (e.g. "DUKE", "X99")
--   true  = city prefix is auto-prepended, player only types the suffix
--           e.g. in Valentine: "VAL-" locked + their input -> "VAL-DUKE"
--
-- minLength / maxLength:
--   When useCityPrefix = false: limits the ENTIRE custom ID length
--   When useCityPrefix = true:  limits only the SUFFIX
-- ---------------------------------------------------------------
Config.CustomTelegramId = {
    enabled = true,                  -- Players get the OPTION to pick their own ID
    minLength = 3,                   -- Minimum characters the player types
    maxLength = 10,                   -- Maximum characters the player types
    allowLetters = true,             -- Allow A-Z in the player's input
    allowNumbers = true,             -- Allow 0-9 in the player's input
    useCityPrefix = true,            -- Auto-prepend the station's city prefix
    separator = "-",                 -- Separator between prefix and suffix (only when useCityPrefix = true)
    blockedWords = { "admin", "mod", "staff" },
}

-- ---------------------------------------------------------------
-- VIP / PATREON RESERVED IDS
-- Players with a matching entry get their reserved ID for free on registration.
--
-- Four matching modes (highest priority first):
--
--  1. steamId + charId  → most restrictive; only that exact character on that account.
--     { steamId = "steam:11000010xxxxxxx", charId = 7, telegramId = "DUKE" }
--
--  2. charId only       → targets one specific DB character regardless of account.
--     { charId = 7, telegramId = "DUKE" }
--
--  3. steamId + telegramIds POOL → for multi-character players; each character on
--     the account automatically claims the next unclaimed ID from the list.
--     { steamId = "steam:11000010xxxxxxx", telegramIds = { "DUKE", "DOC", "JANE" } }
--
--  4. steamId only      → simplest; the FIRST character on the account to register
--     claims the ID. Later characters on the same account get normal auto-gen IDs.
--     { steamId = "steam:11000010xxxxxxx", telegramId = "BOSS" }
--
-- NOTE: charId format depends on your framework:
--   RSG  → citizenid string  (e.g. "JOH12345")  — find it in the 'characters' table: SELECT citizenid, firstname, lastname FROM characters;
--   VORP → numeric charidentifier  (e.g. 7)       — find it in 'characters': SELECT charidentifier, firstname, lastname FROM characters;
-- ---------------------------------------------------------------
Config.VipTelegramIds = {
    enabled = true,
    -- Single character by charId (recommended for multi-char servers):
    -- { charId = 7,  telegramId = "DUKE" },
    -- { charId = 12, telegramId = "JANE" },

    -- Pool of IDs for all characters on one account:
    -- { steamId = "steam:11000010xxxxxxx", telegramIds = { "DUKE", "DOC", "JANE" } },

    -- Simple single-character Patreon perk (first char to register gets it):
    -- { steamId = "steam:11000010xxxxxxx", telegramId = "BOSS" },
}

-- Reserved number ranges that cannot be auto-generated or custom-picked
Config.ReservedNumbers = {
    { startRange = 0, endRange = 0 },
    -- { startRange = 1, endRange = 100 },  -- example: held for staff
    -- { startRange = 9000, endRange = 9999 },  -- blocked entirely
}

-- ---------------------------------------------------------------
-- REGISTRATION
-- Controls cost, fields, and display during registration.
-- ---------------------------------------------------------------
Config.RegistrationCost = 5.00

Config.Registration = {
    autoFillFirstName = true,     -- Auto-fill the First Name field from character data
    autoFillLastName  = true,     -- Auto-fill the Last Name field from character data
    allowEditName     = false,    -- Allow player to change first/last name (false = locked to character name)
    showNameFields    = true,     -- Show name fields at all (false = hide entirely, auto-fill silently)
    showPreviewId     = true,     -- Show a preview of the auto-generated telegram ID before registration
    showCostDisplay   = true,     -- Show the "Registration fee: $X.XX" text (false = still charges, just hidden)
    hideCostWhenFree  = false,    -- If true, hide cost display when registration is free ($0.00)
    showLegalText     = true,     -- Show the "By signing below..." legal disclaimer
    legalText         = "By signing below, I agree to the terms set forth by the United States Postal Service. I acknowledge that suspicious transmissions may be subject to investigation by state authorities.",
    privilegedJobs    = {},       -- Jobs that bypass the custom ID cost (e.g. { "sheriff", "governor" })
}

-- ---------------------------------------------------------------
-- UNREGISTER / CANCEL SERVICE
-- Allows players to cancel their telegram service and free their ID.
-- In "random" mode, the freed number can be assigned to someone else.
-- In "charid" mode, they'll get the same number back if they re-register.
-- ---------------------------------------------------------------
Config.Unregister = {
    enabled = true,               -- Allow players to unregister from the telegram office
    refundPercentage = 0,         -- % of registration cost to refund (0 = no refund, 50 = half, 100 = full)
    deleteMessages = true,       -- Delete all inbox/sent messages when a player unregisters
    deleteContacts = true,       -- Delete all saved contacts when unregistering
    confirmationRequired = true,  -- Require a confirmation step in the NUI before unregistering
    cooldownMinutes = 1,          -- Cooldown before re-registration (0 = instant, 60 = 1 hour)
    allowedJobs = {},             -- Empty = everyone; or restrict: { "unemployed" }
    allowedIdentifiers = {},      -- Steam hex whitelist (empty = everyone)
}

-- ===============================================================
--  3. PLAYER PERSONALIZATION
-- ===============================================================

-- ---------------------------------------------------------------
-- PROFILE PICTURES
-- Players can set a URL for their profile picture at registration or later.
-- ---------------------------------------------------------------
Config.ProfilePicture = {
    enabled = true,               -- Master toggle (false = completely disables profile pictures everywhere)
    vintageFilter = true,         -- Apply a sepia/vintage filter to profile pictures (period-accurate 1899 look)
                                  -- false = show profile pictures in their original colours
    maxUrlLength = 500,           -- Max character length for profile picture URLs
    showInMessages = true,        -- Display sender profile pic when reading a telegram
    showInInbox = true,           -- Show profile pic in inbox/sent message lists
    showInDirectory = true,       -- Show profile pic in public directory
    showInContacts = true,        -- Show profile pic in contacts list
    defaultImage = "",            -- Default profile pic URL (empty = show initials avatar)
    -- Restrictions: empty tables = everyone allowed
    allowedJobs = {},             -- e.g. { "sheriff", "governor" }
    allowedIdentifiers = {},      -- RSG: citizenid (e.g. { "JOH12345" })  |  VORP: steam hex (e.g. { "steam:11000010xxxxxxx" })
}

-- ---------------------------------------------------------------
-- SIGNATURE (handwritten canvas signature)
-- Players draw a signature at registration.
-- ---------------------------------------------------------------
Config.Signature = {
    enabled = true,                   -- Master toggle
    requiredForRegistration = true,  -- Player MUST draw a signature before registration
    usableAsStamp = true,             -- Allow players to use their drawn signature as a stamp option in compose
    editableAfterRegistration = true, -- Player can change signature from settings modal
    cost = 0.00,                      -- Extra cost when using signature as a stamp (0 = free)
    -- Restrictions: empty tables = everyone allowed
    allowedJobs = {}, -- e.g. { "sheriff", "governor" }
    allowedIdentifiers = {}, -- RSG: citizenid (e.g. { "JOH12345" })  |  VORP: steam hex (e.g. { "steam:11000010xxxxxxx" })
}

-- ---------------------------------------------------------------
-- CUSTOM STAMP / SEAL (DISABLED by default, stamps are government-issued)
-- ---------------------------------------------------------------
Config.CustomStamp = {
    enabled = false,                  -- Disabled — players cannot add custom stamps
    maxUrlLength = 500,
    editableAfterRegistration = false,
    cost = 0.00,
    allowedJobs = {}, -- e.g. { "sheriff", "governor" }
    allowedIdentifiers = {}, -- RSG: citizenid (e.g. { "JOH12345" })  |  VORP: steam hex (e.g. { "steam:11000010xxxxxxx" })
}

-- ===============================================================
--  4. STATIONS & INTERACTION
-- ===============================================================

-- ---------------------------------------------------------------
-- INTERACTION MODE
-- ---------------------------------------------------------------
Config.InteractionMode = "ox_target"  -- "prompt" = classic RDR2 hold-key | "ox_target" = eye interaction

Config.PromptRange = 2.0      -- Distance to show prompt (used by both modes)
Config.PromptKey = 0x760A9C6F -- G key (only used in "prompt" mode)

-- ox_target settings (only used when InteractionMode = "ox_target")
Config.OxTarget = {
    icon = "fa-solid fa-envelope",
    iconColor = "#c4a882",
    label = "Telegram Office",
    distance = 2.5,            -- Max interaction distance for NPC targets
    zoneRadius = 1.5,          -- Sphere zone radius for stations without NPCs
}

-- ---------------------------------------------------------------
-- NUI CONTROL BLOCKING
-- While the telegram NUI is open, ALL input groups (0, 1, 2) are
-- disabled automatically so no game actions fire while typing.
--
-- If you find a specific control that STILL triggers while the
-- NUI is open, add its hash to the list below as an extra safety net.
-- These are passed to DisableControlAction() every frame.
--
-- Common RedM control hashes:
--   0x4BC9DABB  = INPUT_WHISTLE (horse call — H key)
--   0x07CE1E61  = INPUT_OPEN_WHEEL_MENU
--   0x7F8D09B8  = INPUT_PLAYER_MENU
--   0xB2F377E8  = INPUT_OPEN_SATCHEL_MENU
-- ---------------------------------------------------------------
Config.NuiBlockedControls = {
    -- 0x4BC9DABB,  -- uncomment if horse whistle still triggers
}

-- ---------------------------------------------------------------
-- STATIONS
-- Each station has coords, optional NPC, optional blip, optional jobLock.
-- ---------------------------------------------------------------
Config.Stations = {
    {
        name = "Valentine",
        city = "Valentine",
        coords = vector3(-178.83, 626.60, 114.08),
        blip = {
            enabled = true,
            sprite = 1861010125,
            label = "Telegram Office",
        },
        npc = {
            enabled = true,
            model = "mp_u_m_m_gunforhireclerk_01",
            coords = vector4(-177.94, 628.15, 113.08, 148.26),
        },
        jobLock = nil,  -- nil = open to all, or { "sheriff", "lawman" }
        checkerStation = false,
    },
    {
        name = "Blackwater",
        city = "Blackwater",
        coords = vector3(-875.1062, -1326.8433, 42.97062683105469),
        blip = {
            enabled = true,
            sprite = 1861010125,
            label = "Telegram Office",
        },
        npc = {
            enabled = true,
            model = "S_M_M_BankClerk_01",
            coords = vector4(-875.1062, -1326.8433, 42.97062683105469, 354.7529),
        },
        jobLock = nil,
        checkerStation = false,
    },
    {
        name = "Saint Denis",
        city = "Saint Denis",
        coords = vector3(2749.445, -1399.736, 46.192),
        blip = {
            enabled = true,
            sprite = 1861010125,
            label = "Telegram Office",
        },
        npc = {
            enabled = true,
            model = "mp_u_m_m_gunforhireclerk_01",
            coords = vector4(2748.7266, -1398.2632, 46.2331, 208.2291),
        },
        jobLock = nil,
        checkerStation = false,
    },
    {
        name = "Rhodes",
        city = "Rhodes",
        coords = vector3(1226.770, -1295.02, 76.905),
        blip = {
            enabled = true,
            sprite = 1861010125,
            label = "Telegram Office",
        },
        npc = {
            enabled = true,
            model = "mp_u_m_m_gunforhireclerk_01",
            coords = vector4(1226.770, -1295.02, 75.905, 52.37),
        },
        jobLock = nil,
        checkerStation = false,
    },
    {
        name = "Strawberry",
        city = "Strawberry",
        coords = vector3(-1763.79, -385.11, 157.79),
        blip = {
            enabled = true,
            sprite = 1861010125,
            label = "Telegram Office",
        },
        npc = {
            enabled = true,
            model = "mp_u_m_m_gunforhireclerk_01",
            coords = vector4(-1763.79, -385.11, 156.79, -297),
        },
        jobLock = nil,
        checkerStation = false,
    },
    {
        name = "Annesburg",
        city = "Annesburg",
        coords = vector3(2938.93359375, 1286.998291015625, 43.65509796142578),
        blip = {
            enabled = true,
            sprite = 1861010125,
            label = "Telegram Office",
        },
        npc = {
            enabled = true,
            model = "mp_u_m_m_gunforhireclerk_01",
            coords = vector4(2938.93359375, 1286.998291015625, 43.65509796142578, 342.6581),
        },
        jobLock = nil,
        checkerStation = false,
    },
    {
        name = "Benedict Point",
        city = "Benedict Point",
        coords = vector3(-5228.6260, -3468.3232, -21.56743240356445),
        blip = {
            enabled = true,
            sprite = 1861010125,
            label = "Telegram Office",
        },
        npc = {
            enabled = true,
            model = "mp_u_m_m_gunforhireclerk_01",
            coords = vector4(-5228.6260, -3468.3232, -21.56743240356445, 88.1445),
        },
        jobLock = nil,
        checkerStation = false,
    },
    {
        name = "Armadillo",
        city = "Armadillo",
        coords = vector3(-3732.2271, -2597.7249, -13.93547058105468),
        blip = {
            enabled = true,
            sprite = 1861010125,
            label = "Telegram Office",
        },
        npc = {
            enabled = true,
            model = "mp_u_m_m_gunforhireclerk_01",
            coords = vector4(-3732.2271, -2597.7249, -13.93547058105468, 105.3491),
        },
        jobLock = nil,
        checkerStation = false,
    },
    {
        name = "Emerald Ranch",
        city = "Emerald Ranch",
        coords = vector3(1521.9073486328125, 441.0653991699219, 90.67854309082031),
        blip = {
            enabled = true,
            sprite = 1861010125,
            label = "Telegram Office",
        },
        npc = {
            enabled = true,
            model = "mp_u_m_m_gunforhireclerk_01",
            coords = vector4(1521.9073486328125, 441.0653991699219, 89.67854309082031, 180.0),
        },
        jobLock = nil,
        checkerStation = false,  -- Checker station: gov/admin can look up any number's messages here
    },
    {
        name = "Van Horn",
        city = "Van Horn",
        coords = vector3(2986.22900390625, 570.1043701171875, 43.61395645141601),
        blip = {
            enabled = true,
            sprite = 1861010125,
            label = "Telegram Office",
        },
        npc = {
            enabled = true,
            model = "mp_u_m_m_gunforhireclerk_01",
            coords = vector4(2986.22900390625, 570.1043701171875, 43.61395645141601, 165.7595),
        },
        jobLock = nil,
        checkerStation = false,  -- Checker station: gov/admin can look up any number's messages here
    },
    {
        name = "Baccus Station",
        city = "Baccus Station",
        coords = vector3(583.4948, 1677.0886, 187.9783),
        blip = {
            enabled = true,
            sprite = 1861010125,
            label = "Telegram Office",
        },
        npc = {
            enabled = true,
            model = "mp_u_m_m_gunforhireclerk_01",
            coords = vector4(583.4948, 1677.0886, 186.9305419921875, 135.6463),
        },
        jobLock = nil,
        checkerStation = false,  -- Checker station: gov/admin can look up any number's messages here
    },
    {
        name = "Flatneck Station",
        city = "Flatneck Station",
        coords = vector3(-339.7757568359375, -363.6557922363281, 87.01526641845703),
        blip = {
            enabled = true,
            sprite = 1861010125,
            label = "Telegram Office",
        },
        npc = {
            enabled = true,
            model = "mp_u_m_m_gunforhireclerk_01",
            coords = vector4(-339.7757568359375, -363.6557922363281, 87.01526641845703, 116.4375),
        },
        jobLock = nil,
        checkerStation = false,  -- Checker station: gov/admin can look up any number's messages here
    },
    {
        name = "Riggs Station",
        city = "Riggs Station",
        coords = vector3(-1094.3635, -577.7984, 81.41258239746094),
        blip = {
            enabled = true,
            sprite = 1861010125,
            label = "Telegram Office",
        },
        npc = { 
            enabled = true,
            model = "mp_u_m_m_gunforhireclerk_01",
            coords = vector4(-1094.3635, -577.7984, 81.41258239746094, 44.8096),
        },
        jobLock = nil,
        checkerStation = false,  -- Checker station: gov/admin can look up any number's messages here
    },
    {
        name = "Wallace Station",
        city = "Wallace Station",
        coords = vector3(-1299.9243, 400.6805, 94.4544448852539),
        blip = {
            enabled = true,
            sprite = 1861010125,
            label = "Telegram Office",
        },
        npc = {
            enabled = true,
            model = "mp_u_m_m_gunforhireclerk_01",
            coords = vector4(-1299.9243, 400.6805, 94.4544448852539, 328.4159),
        },
        jobLock = nil,
        checkerStation = false,  -- Checker station: gov/admin can look up any number's messages here
    },
    {
        name = "Macfarlane's",
        city = "Macfarlane's",
        coords = vector3(-2495.4663, -2424.6313, 59.60192108154297),
        blip = {
            enabled = true,
            sprite = 1861010125,
            label = "Telegram Office",
        },
        npc = {
            enabled = true,
            model = "mp_u_m_m_gunforhireclerk_01",
            coords = vector4(-2495.4663, -2424.6313, 59.60192108154297, 202.6884),
        },
        jobLock = nil,
        checkerStation = false,  -- Checker station: gov/admin can look up any number's messages here
    },
}

-- Auto-detect world props as stations (e.g. mailboxes).
-- Any placed instance of a listed model becomes interactable.
-- The script automatically finds the closest Config.Stations entry to the prop's
-- world position and opens that station -- so a mailbox near Rhodes opens the Rhodes
-- station (correct city prefix, cost, jobLock, checkerStation), not Valentine's.
-- range = interaction detection radius in metres (used in prompt mode;
--         ox_target uses its own distance setting from Config.OxTarget).
Config.AutomaticProps = {
    -- { model = "p_mailbox01x", range = 2.0 },
}

-- ===============================================================
--  5. COMPOSING & SENDING
-- ===============================================================

-- ---------------------------------------------------------------
-- COMPOSE SETTINGS (fields and behavior)
-- ---------------------------------------------------------------
Config.Compose = {
    subjectEnabled = true,            -- Show the subject field (false = no subject line)
    subjectRequired = true,           -- Require a subject before sending
    showCostDisplay = true,           -- Show "Cost: $X.XX" in compose footer
    hideCostWhenFree = false,         -- If true, hide cost when it's $0.00
    allowReply = true,                -- Show the Reply button in the telegram reader
    allowDelete = true,               -- Show the Delete button in the telegram reader
}

-- ---------------------------------------------------------------
-- RICH TELEGRAM FEATURES (drawing, fonts, colors)
-- ---------------------------------------------------------------
Config.RichTelegrams = {
    enabled = true,             -- Master toggle for all rich features
    drawingEnabled = true,      -- Allow freehand drawing/painting in compose
    fontSelectorEnabled = true, -- Show the handwriting font picker in compose toolbar
    colorSelectorEnabled = true,-- Show the ink color palette in compose toolbar
    maxImagePerTelegram = 1,    -- Max images per telegram
    maxCharacters = 5000,       -- Max characters per telegram (enforced server-side)
    maxSubjectLength = 100,     -- Max subject line length (enforced server-side)

    -- Available handwriting fonts
    -- Google Fonts: just add the font name as a string (loaded from CDN automatically)
    -- Local fonts:  drop the .ttf/.otf/.woff/.woff2 file into nui/fonts/ and add a table entry:
    --               { name = "Display Name", file = "filename.ttf" }
    fonts = {
        'Caveat',
        'Cedarville Cursive',
        'Indie Flower',
        'Nothing You Could Do',
        'Oooh Baby',
        'Reenie Beanie',
        'Shadows Into Light',
        -- Examples of local fonts (uncomment and adjust):
        -- { name = "Fredericka the Great", file = "FrederickatheGreat-Regular.ttf" },
        -- { name = "Hapna Slab",           file = "HapnaSlabSerif-DemiBold.ttf" },
        -- { name = "Passport",             file = "Passport-Regular.ttf" },
        -- { name = "RDR Lino",             file = "RDRLino-Regular.ttf" },
        -- { name = "The Signature",        file = "Thesignature.ttf" },
    },

    -- Ink colors
    colors = {
        { label = "Black",     hex = "#1a1a1a" },
        { label = "Dark Blue", hex = "#1a3a5c" },
        { label = "Dark Red",  hex = "#6b1a1a" },
        { label = "Sepia",     hex = "#5c4a3a" },
        { label = "Forest",    hex = "#2a4a2a" },
        { label = "Purple",    hex = "#3a1a5c" },
    },

    defaultFont = "Caveat",
    defaultColor = "#1a1a1a",
}

-- ---------------------------------------------------------------
-- COMPOSE IMAGES (embed images inside telegrams)
-- ---------------------------------------------------------------
Config.ComposeImages = {
    enabled = true,                   -- Master toggle for the "Add Image" button
    vintageFilter = true,             -- Apply a sepia/vintage filter to telegram images (period-accurate 1899 look)
                                      -- false = show images in their original colours
    maxPerTelegram = 1,               -- Max images per telegram
    -- Restrictions: empty tables = everyone allowed
    allowedJobs = {},                 -- e.g. { "journalist", "sheriff" }
    allowedIdentifiers = {},
}

-- ---------------------------------------------------------------
-- ANONYMOUS SENDING
-- ---------------------------------------------------------------
Config.Anonymous = {
    enabled = true,                   -- Master toggle for the "Anonymous" checkbox in compose
    -- Restrictions: empty tables = everyone allowed
    allowedJobs = {},
    allowedIdentifiers = {},
}

-- ---------------------------------------------------------------
-- STAMPS (purchasable stamps in compose)
-- ---------------------------------------------------------------
Config.StampSelector = {
    enabled = true,                   -- Show the stamp chooser row in compose
    stampRequired = true,             -- Require selecting a stamp to send from the office
    defaultStampCost = 0.25,          -- Fee charged when sending without a stamp (e.g. via bird)
                                      -- This becomes an outstanding fee the player must pay at the office
}

Config.Stamps = {
    -- example of people stamps
    -- {
    --     id = "benjamin_franklin",
    --     label = "Benjamin Franklin",
    --     image = "img/stamps/benjamin_franklin.png",
    --     cost = 0.25,
    -- },
    -- City-themed stamps
    {
        id = "valentine_stamp",
        label = "Valentine",
        image = "img/stamps/valentine_stamp.png",
        cost = 0.10,
    },
    {
        id = "blackwater_stamp",
        label = "Blackwater",
        image = "img/stamps/blackwater_stamp.png",
        cost = 0.10,
    },
    {
        id = "saintdenis_stamp",
        label = "Saint Denis",
        image = "img/stamps/saintdenis_stamp.png",
        cost = 0.15,
    },
    {
        id = "rhodes_stamp",
        label = "Rhodes",
        image = "img/stamps/rhodes_stamp.png",
        cost = 0.10,
    },
    {
        id = "strawberry_stamp",
        label = "Strawberry",
        image = "img/stamps/strawberry_stamp.png",
        cost = 0.10,
    },
    {
        id = "annesburg_stamp",
        label = "Annesburg",
        image = "img/stamps/annesburg_stamp.png",
        cost = 0.10,
    },
    {
        id = "tumbleweed_stamp",
        label = "Tumbleweed",
        image = "img/stamps/tumbleweed_stamp.png",
        cost = 0.10,
    },
    {
        id = "armadillo_stamp",
        label = "Armadillo",
        image = "img/stamps/armadillo_stamp.png",
        cost = 0.10,
    },
    {
        id = "vanhorn_stamp",
        label = "Van Horn",
        image = "img/stamps/vanhorn_stamp.png",
        cost = 0.10,
    },
}

-- ---------------------------------------------------------------
-- CITY POSTMARKS & LABELS
-- Shown on telegrams based on the city they were sent from.
-- ---------------------------------------------------------------
Config.UseCityLabels = true  -- Show the city name on telegrams
Config.UseCityStamps = true  -- Show city postmark stamp images in the reader

Config.CityStamps = {
    ["Valentine"]     = "img/citystamps/Valentine.png",
    ["Blackwater"]    = "img/citystamps/Blackwater.png",
    ["Saint Denis"]   = "img/citystamps/STDenis.png",
    ["Rhodes"]        = "img/citystamps/Rhodes.png",
    ["Annesburg"]     = "img/citystamps/Annesburg.png",
    ["Emerald Ranch"] = "img/citystamps/Emerald.png",
    -- Additional city stamps available:
    -- ["Escalera"]   = "img/citystamps/Escalera.png",
    -- ["Guarma"]     = "img/citystamps/Guarma.png",
    -- ["Riggs"]      = "img/citystamps/Riggs.png",
}

-- ---------------------------------------------------------------
-- TELEGRAM COSTS (per city/station)
-- ---------------------------------------------------------------
Config.DefaultSendCost = 0.25
Config.AddBaseCostToStamp = true      -- If true, base cost is added ON TOP of stamp cost (total = base + stamp)
                                      -- If false, stamp cost replaces base cost when a stamp is selected (total = stamp only)

Config.TelegramCosts = {
    ["Valentine"]     = 0.25,
    ["Blackwater"]    = 0.25,
    ["Saint Denis"]   = 0.50,
    ["Rhodes"]        = 0.25,
    ["Strawberry"]    = 0.25,
    ["Annesburg"]     = 0.25,
    ["Tumbleweed"]    = 0.25,
    ["Armadillo"]     = 0.25,
    ["Emerald Ranch"] = 0.10,
}

-- ---------------------------------------------------------------
-- BULK MESSAGING
-- ---------------------------------------------------------------
Config.BulkMessaging = {
    enabled = false, -- Allow sending the same telegram to multiple recipients at once
    allowedJobs = { "sheriff", "governor", "mayor" },
    allowedGroups = { "admin", "superadmin" },
    allowedIdentifiers = {},
    recipientCode = "-1",  -- Use this as recipient to send to all
}

-- ===============================================================
--  6. INBOX, ARCHIVE & ITEMS
-- ===============================================================

-- ---------------------------------------------------------------
-- SENT TAB
-- ---------------------------------------------------------------
Config.SentTab = {
    enabled = true,  -- Show the "Sent" tab (false = hide sent history)
}

-- ---------------------------------------------------------------
-- INBOX PERSISTENCE & LIMITS
-- ---------------------------------------------------------------
Config.InboxPersistence = {
    inboxCapEnabled = false,         -- Auto-delete oldest when over limit
    inboxCapAmount = 500,            -- Max telegrams per player before oldest are removed
    capWarningThreshold = 450,       -- Warn player at this count
}

-- ---------------------------------------------------------------
-- ARCHIVE SYSTEM
-- ---------------------------------------------------------------
Config.Archive = {
    enabled = true,  -- Allow archiving/restoring telegrams
}

-- ---------------------------------------------------------------
-- TELEGRAM PAPER ITEM (extract as inventory item)
-- ---------------------------------------------------------------
Config.TelegramItems = {
    enabled = true,
    paperItem = "telegram_paper",    -- Item name in inventory
    consumePaperOnSend = true,       -- Remove 1x paper from inventory when successfully sent via bird
    extractEnabled = true,           -- Allow taking a telegram out of inbox as an item
    extractMode = "copy",            -- "copy" = keeps in inbox, "extract" = removes from inbox
}

-- ===============================================================
--  7. CONTACTS & DIRECTORY
-- ===============================================================

-- ---------------------------------------------------------------
-- CONTACTS / ADDRESS BOOK
-- ---------------------------------------------------------------
Config.Contacts = {
    enabled = true,        -- Master toggle -- hide the Contacts tab entirely
    maxContacts = 100,     -- Max contacts per player (enforced server-side)
}

-- ---------------------------------------------------------------
-- TELEGRAM BOOK (extended contacts with notes)
-- Merged into the Contacts UI -- entries that have notes use the book system.
-- ---------------------------------------------------------------
Config.TelegramBook = {
    enabled = true,
    maxEntries = 1000,
    -- M-Notebooks compatibility: when true, a "Addresses" tab appears inside the
    -- M-Notebooks script showing this player's telegram address book.
    -- Requires M-Notebooks to be running alongside this script.
    -- https://mundis.tebex.io/package/m-notebooks
    notebooksCompat = true,
}

-- ---------------------------------------------------------------
-- PUBLIC TELEGRAM DIRECTORY
-- Players can opt-in to list themselves publicly.
-- ---------------------------------------------------------------
Config.PublicDirectory = {
    enabled = true,
    maxDescriptionLength = 200,
    categories = {
        "General",
        "Business",
        "Services",
        "Government",
        "Social",
    },
}

-- ===============================================================
--  8. ORGANIZATIONS (Companies & Businesses)
-- ===============================================================

-- ---------------------------------------------------------------
-- COMPANY / JOB TELEGRAMS (config-defined, job-based)
-- ---------------------------------------------------------------
Config.CompanyTelegrams = {
    enabled = true,                  -- Show/hide the Company tab
    dynamicEnabled = true,           -- Allow creating company telegrams
    ownerGradeMin = 5,               -- Default: grade 5+ = owner/boss (can be overridden per company below)
    memberAssignEnabled = true,      -- Owners can assign specific people access
    maxMembersPerCompany = 20,       -- Default max manually-assigned members (can be overridden per company below)
}

-- permittedGrades:       which grades can ACCESS the company inbox (read/send).
--                        Grades do NOT need to be sequential — { 0, 3, 7 } is valid.
-- ownerGradeMin:         (optional) per-company override for managing members.
--                        If omitted, uses Config.CompanyTelegrams.ownerGradeMin above.
-- maxMembersPerCompany:  (optional) per-company override for member cap.
--                        If omitted, uses Config.CompanyTelegrams.maxMembersPerCompany above.
-- jobName:               the job role tied to this company. Can be a single string
--                        OR a table of strings to grant multiple roles access.
--                        Examples:
--                          jobName = "sheriff"                    — single role
--                          jobName = { "sheriff", "marshal" }     — multiple roles
--                          jobNames = { "sheriff", "marshal" }    — alternative key (same effect)
Config.Companies = {
    {
        companyId = "WESO",
        jobName = "WESO",
        label = "WESO",
        permittedGrades = { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10 },
        canSendToAll = true,
        -- ownerGradeMin = 5,            -- uncomment to override the global value for this company
        -- maxMembersPerCompany = 20,      -- uncomment to override the global member cap for this company
    },
    {
        companyId = "NARO",
        jobName = "NARO",
        label = "NARO",
        permittedGrades = { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10 },
        canSendToAll = true,
    },
    {
        companyId = "NHSO",
        jobName = "NHSO",
        label = "NHSO",
        permittedGrades = { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10 },
        canSendToAll = true,
    },
    {
        companyId = "LSO",
        jobName = "LSO",
        label = "LSO",
        permittedGrades = { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10 },
        canSendToAll = true,
    },
    {
        companyId = "USDO",
        jobName = "USDO",
        label = "Doctor's Office",
        permittedGrades = { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10 },
        canSendToAll = false,
    },
}

-- ---------------------------------------------------------------
-- PLAYER-CREATED BUSINESSES
-- Separate from job-based companies -- anyone can create one.
-- ---------------------------------------------------------------
Config.BusinessTelegrams = {
    enabled = true,
    maxBusinessesPerPlayer = 3,
    maxMembersPerBusiness = 10,
    maxMembershipsPerPlayer = 5,     -- 0 = unlimited
    creationCost = 5.00,
    idPrefix = "BIZ",                -- Prefix for business IDs (e.g. BIZ-A3F9)
    idLength = 4,                    -- Random suffix length
    -- Restrictions: who can CREATE businesses?
    allowedJobs = {},
    allowedIdentifiers = {},
    -- Default permissions for new employees
    defaultCanRead = true,
    defaultCanSend = false,
}

-- ===============================================================
--  9. NOTIFICATIONS, ANIMATIONS & SOUNDS
-- ===============================================================

-- ---------------------------------------------------------------
-- NOTIFICATIONS
-- ---------------------------------------------------------------
Config.Notifications = {
    onReceive = true,           -- Notify when receiving a telegram while online
    onLogin = true,             -- Notify on login if unread telegrams exist
    onLoginDelaySeconds = 3,    -- Seconds to wait after login before the unread-telegram notification fires
                                -- Increase if players see it before the world finishes loading (default: 3)
    soundEnabled = true,        -- Play sound on notification
    notificationDuration = 5000,-- Duration in ms

    -- Screen position: "top-right", "top-left", "top-center",
    --   "bottom-right", "bottom-left", "bottom-center",
    --   "center-left", "center-right"
    position = "center-left",

    -- What to show in the incoming-telegram notification.
    -- If ALL three are false the notification just says "You received a telegram."
    showSenderName = true,      -- Show the sender's name in the notification
    showSubject    = true,      -- Show the telegram subject / title
    showSenderId   = true,      -- Show the sender's telegram ID (e.g. #VAL-4553)
    pigeonEnabled  = true,     -- Enable telegram received notifications (left-side toast + pigeon fly-in animation)
}

-- ---------------------------------------------------------------
-- ANIMATIONS
-- ---------------------------------------------------------------
Config.Animations = {
    enabled = true,
    readAnim = {
        dict = "mech_inspection@letter@base",
        name = "hold_inspect_enter",
    },
    prop = {
        model = "p_cs_letterfolded02x",
        bone = "SKEL_L_Finger10",
        offset = { x = 0.01, y = -0.12, z = 0.02 },
        rotation = { x = -10.0, y = -10.0, z = -80.0 },
    },
}

-- ---------------------------------------------------------------
-- SOUNDS (files in nui/sounds/)
-- Set file to "" or volume to 0 to disable a specific sound.
-- ---------------------------------------------------------------
Config.Sounds = {
    enabled = true,

    paperOpen    = { file = "paper_open.wav",    volume = 0.5 },
    paperClose   = { file = "paper_close.wav",   volume = 0.5 },
    paperTear    = { file = "paper_tear.wav",     volume = 0.5 },
    stampPlace   = { file = "stamp_place.wav",   volume = 0.5 },
    notification = { file = "notification.wav",  volume = 0.5 },
    pageFlip     = { file = "page_flip.wav",     volume = 0.5 },
    penWriting   = { file = "pen_writing.wav",   volume = 0.5 },
}

-- ===============================================================
--  10. DISPLAY & PRESENTATION
-- ===============================================================

-- ---------------------------------------------------------------
-- DISPLAY OPTIONS
-- Controls what information is shown (or hidden) in the inbox
-- list and the telegram reader/detail view.
-- ---------------------------------------------------------------
Config.Display = {
    -- Show the sender's full name alongside their Telegram ID in the inbox list.
    -- true  = "Mundi Mundi  #BIZ-4553"  (name + ID)
    -- false = "BIZ-4553" only           (ID only — more authentic telegram style)
    showSenderNameInInbox  = false,

    -- Show the sender's full name in the FROM field of the opened telegram reader.
    -- true  = FROM: Mundi Mundi (BIZ-4553)
    -- false = FROM: BIZ-4553 only (recommended — real telegrams only carried IDs)
    showSenderNameInReader = false,

    -- Automatically place sender's name as a text signature below the body.
    -- true  = "— Mundi Mundi" appears at the bottom of every telegram
    -- false = no name signature; only a drawn/image signature if one was attached
    autoSignatureName = false,

    -- Show a circular avatar (profile picture / initials) on each inbox row.
    -- true  = avatar shown
    -- false = no avatar
    showAvatarInInbox = false,

    -- Timestamp display mode for inbox list and telegram reader.
    -- true  = each player sees the time in their own local timezone (client-side)
    -- false = times are shown as-stored (server time, UTC-based)
    useLocalTime = true,
}

-- ===============================================================
--  11. ADMIN, MAINTENANCE & DISCORD
-- ===============================================================

-- ---------------------------------------------------------------
-- ADMIN COMMANDS
-- ---------------------------------------------------------------
Config.Admin = {
    command = "telegramadmin",
    groups = { "admin", "superadmin", "god" },
    changeNumberCommand = "telegramnumber",
    unregisterCommand = "telegramunregister",
}

-- ---------------------------------------------------------------
-- CHECKER STATION (Gov/Admin can look up any number's messages)
-- ---------------------------------------------------------------
Config.CheckerStation = {
    enabled = true,
    jobLock = { "Gov1", "Gov2" },
    allowedIdentifiers = {},
}

-- ---------------------------------------------------------------
-- AUTO CLEANUP (only cleans telegrams BOTH sides have deleted)
-- ---------------------------------------------------------------
Config.AutoCleanup = {
    enabled = true,
    deleteAfterDays = 30,
    checkIntervalMinutes = 60,
}

-- ---------------------------------------------------------------
-- DISCORD WEBHOOKS
-- ---------------------------------------------------------------
Config.Discord = {
    enabled = false,
    webhookUrl = "",
    botName = "M-Telegrams",

    logRegistrations = true,
    logSentTelegrams = true,
    logBulkMessages = true,
    logAdminActions = true,
}

-- ===============================================================
--  11. PARCEL SYSTEM
-- ===============================================================

-- ---------------------------------------------------------------
-- GENERAL PARCEL TOGGLE
-- ---------------------------------------------------------------
Config.Parcels = {
    enabled = true,                   -- Master toggle: false hides Parcels tab entirely

    -- Who can USE the parcel system (send AND receive)?
    -- Empty table = everyone; otherwise restrict by job or identifier.
    allowedJobs = {},                 -- e.g. { "merchant", "sheriff" }
    allowedIdentifiers = {},          -- RSG: citizenid (e.g. { "JOH12345" })  |  VORP: steam hex (e.g. { "steam:11000010xxxxxxx" })

    -- Collection behaviour.
    -- "station" = recipient may collect from ANY Telegram Office. (default)
    -- "sender"  = recipient must collect from the specific station the sender used.
    --             The parcel inbox shows which city the parcel is held at.
    collectionMode = "station",

    -- Delivery delay: how many real-world minutes after sending before the recipient
    -- can collect the parcel. 0 = instant delivery (default).
    -- Example: 60 = 1 hour in transit before parcel becomes available.
    deliveryDelayMinutes = 1,

    -- Max number of items in a single parcel package.
    maxItemsPerParcel = 5,

    -- Weight system (set weightEnabled = false to ignore weight entirely).
    weightEnabled = true,

    -- Unit used for weight display in the UI and for the maxWeightPerParcel limit below.
    -- Options: "g" (grams), "kg" (kilograms), "lb" (pounds)
    -- NOTE: RSG stores item weights internally in grams. This setting only controls display
    -- and how maxWeightPerParcel is interpreted. weightFeePerUnit is always per gram internally.
    weightUnit = "kg",

    maxWeightPerParcel = 10.0,         -- max total weight per parcel (in the unit set by weightUnit above)

    -- Fees
    baseFee = 0.50,                   -- Flat fee per parcel sent
    weightFeePerUnit = 0.05,          -- Extra cost per gram of total weight (always grams, regardless of weightUnit)

    -- How many uncollected parcels a player may have in their inbox at once.
    maxPendingInbox = 20,

    -- Auto-return: return the parcel to sender after this many real-world minutes.
    -- 0 = never auto-return.
    autoReturnMinutes = 10080,        -- 7 days

    -- Notify the recipient in-game when a parcel arrives (if they are online).
    notifyOnReceive = true,

    -- Notify the player on login if they have uncollected parcels waiting.
    -- Uses the same delay as Config.Notifications.onLoginDelaySeconds.
    notifyOnLogin = true,

    -- Items that are disallowed inside parcels (item name strings, case-insensitive).
    blockedItems = {},

    -- Item name prefixes that block entire categories.
    -- Any item whose name starts with one of these strings (case-insensitive) is blocked.
    -- Useful for blocking all weapons, ammo, etc. without listing every individual item name.
    --   "weapon_"  → blocks every weapon  (weapon_revolver_cattleman, weapon_rifle_boltaction, …)
    --   "ammo_"    → blocks all ammunition
    --   "melee_"   → blocks all melee weapons
    blockedCategories = {
        -- "weapon_",
        -- "ammo_",
        -- "melee_",
    },

    -- Discord logging
    logSentParcels = true,        -- Log when a parcel is sent
    logReceivedParcels = true,    -- Log when a parcel is collected by the recipient

    -- Inventory loading mode for the Send Parcel panel.
    -- false = manual "Load Inventory" button (default, lazy-load on demand).
    -- true  = auto-load inventory when the Send Parcel sub-tab is opened,
    --         then refresh automatically on the interval below.
    autoLoadInventory = true,
    inventoryRefreshInterval = 5000,  -- ms between auto-refreshes (only used when autoLoadInventory = true)

    -- Hide currency items from the parcel inventory list.
    -- Players won't be able to send these items in parcels.
    hideCurrencyItems = true,
    currencyItems = {
        -- RSG currency items (rsg-core/shared/items.lua)
        "dollar", "cent", "blood_dollar", "blood_cent",
        "money_clip", "blood_money_clip",
        "gold_nugget",
        -- Generic / legacy names
        "money", "cash", "gold", "goldbar", "cents", "coins",
    },  -- item names blocked from parcels
}

-- ===============================================================
--  12. CARRIER BIRD SYSTEM
-- ===============================================================

-- ---------------------------------------------------------------
-- GENERAL BIRD TOGGLE
-- ---------------------------------------------------------------
Config.CarrierBirds = {
    enabled = true,                   -- Master toggle: false disables the entire bird system

    -- ── Bird model (used for in-world spawn) ────────────────────
    pigeonModel = 'A_C_Pigeon',

    -- ── Ground-send interaction (send via item) ─────────────────
    -- When sending from a telegram_paper item, the player attaches
    -- the letter to the bird on the ground before it flies away.
    attachPromptText   = "Attach Telegram",              -- Prompt label (hold R)
    attachAnimDict     = "mech_animal_interaction@dog@patting@1h", -- Animation dict (TaskPlayAnim)
    attachAnimClip     = "base",                          -- Animation clip name
    attachAnimDuration = 8000,                            -- How long the attachment animation plays (ms)
    attachDistance      = 2.5,                            -- Max distance to show prompt
    spawnDistance       = 2.5,                            -- How far in front of the player to spawn the bird

    -- ── Blip settings ─────────────────────────────────────────
    blip = {
        showDuringSetup  = true,                         -- Blip on bird while on the ground (finding it)
        showDuringFlight = true,                         -- Blip on bird while it flies to destination
        sprite           = 0x1F6B5B1C,                   -- RedM blip sprite hash  (BLIP_STYLE_FRIENDLY — small white marker)
        name             = "Carrier Bird",               -- Blip label on map
    },

    -- ── Bird Tab access ─────────────────────────────────────────
    -- Who can buy / manage birds from the telegram office?
    -- Empty table = everyone.
    allowedJobs = {},
    allowedIdentifiers = {},

    -- ── Ownership limits ────────────────────────────────────────
    maxBirdsPerPlayer = 3,            -- How many birds one player/character can own

    -- ── Shop Pool (randomised market) ───────────────────────────
    shopPoolSize = 6,                 -- Number of birds shown in the market at once
    shopMinLevel = 1,                 -- Minimum level a shop bird can spawn at
    shopMaxLevel = 3,                 -- Maximum level a shop bird can spawn at
    shopRefreshMinutes = 30,          -- How often the shop rotates its stock (minutes)
    shopLevelPriceMultiplier = 0.35,  -- Price increase per level above 1 (0.35 = 35% per level)

    -- ── Sellback ────────────────────────────────────────────────
    sellbackEnabled = true,           -- Allow players to sell birds back to the shop
    sellbackPercentage = 50,          -- % of original purchase price returned (50 = half)
    sellbackMinHealth = 30,           -- Minimum health % required to sell a bird (0-100)

    -- ── Flight Death ────────────────────────────────────────────
    flightDeathChance = 0,            -- Base % chance a bird dies during a delivery (0 = off)
    flightDeathLowHealthBonus = 5,    -- Extra % chance if bird health is below 30%

    -- ── Purchase options (each entry = a breed you can buy) ─────
    --
    -- Portrait images:
    --   Place your bird images in:  nui/img/birds/
    --   Reference them as:          img/birds/your_file.png
    --   healthyImage  = shown when status is: healthy / hungry / resting / training
    --   unhealthyImage = shown when status is: sick / dead
    --
    -- Per-breed model (OPTIONAL):
    --   model = the ped model spawned in-world for this breed.
    --   If omitted (or nil), the global pigeonModel above is used.
    --   Example: model = 'A_C_Eagle_01',
    --
    breeds = {
        {
            id             = "rock_pigeon",
            label          = "Rock Pigeon",
            description    = "A hardy street pigeon. Not the fastest, but reliable.",
            cost           = 10.00,
            baseSpeed      = 20,
            baseHealth     = 80,
            baseStamina    = 80,
            maxLevel       = 10,
            healthyImage   = "img/birds/Pigeon.png",
            unhealthyImage = "img/birds/Pigeon_hurt.png",
            -- model       = 'A_C_Pigeon',  -- (optional) override global pigeonModel for this breed
        },
        {
            id             = "homing_pigeon",
            label          = "Homing Pigeon",
            description    = "Bred for long-distance delivery. Faster and more loyal.",
            cost           = 35.00,
            baseSpeed      = 40,
            baseHealth     = 100,
            baseStamina    = 120,
            maxLevel       = 15,
            healthyImage   = "img/birds/HomingPigeon.png",
            unhealthyImage = "img/birds/HomingPigeon_hurt.png",
            -- model       = 'A_C_Pigeon',  -- (optional) override global pigeonModel for this breed
        },
        {
            id             = "carrier_dove",
            label          = "Carrier Dove",
            description    = "An elegant bird of great loyalty. Exceptional speed.",
            cost           = 45.00,
            baseSpeed      = 70,
            baseHealth     = 100,
            baseStamina    = 90,
            maxLevel       = 20,
            healthyImage   = "img/birds/CarrierDove.png",
            unhealthyImage = "img/birds/CarrierDove_hurt.png",
            model       = 'A_C_Eagle_01',  -- (optional) override global pigeonModel for this breed
        },

        -- ─────────────────────────────────────────────────────────
        -- CUSTOM BREED TEMPLATE
        -- Copy and uncomment this block to add a new bird breed.
        -- The breed becomes available in the telegram office shop.
        -- ─────────────────────────────────────────────────────────
        -- {
        --     id             = "my_custom_bird",       -- Unique internal ID  (no spaces)
        --     label          = "My Custom Bird",       -- Display name in NUI
        --     description    = "A short description of this bird.", -- Shown in shop
        --     cost           = 20.00,                  -- Purchase price in $
        --     baseSpeed      = 40,                     -- Starting speed stat (affects flight ETA)
        --     baseHealth     = 100,                    -- Starting max health
        --     baseStamina    = 90,                     -- Starting stamina   (affects rest time)
        --     maxLevel       = 12,                     -- Cap on how high this breed can level
        --     model          = 'A_C_Pigeon',           -- (optional) ped model for this breed (defaults to pigeonModel)
        --     -- Portrait images (place files in nui/img/birds/)
        --     healthyImage   = "img/birds/my_custom_bird_healthy.png",
        --     unhealthyImage = "img/birds/my_custom_bird_injured.png",
        -- },
    },

    -- ── Training items ──────────────────────────────────────────
    -- Items a player can use on their bird to grant it XP / stat boosts.
    trainingItems = {
        {
            item              = "bird_training_rope",
            label             = "Training Rope",
            description       = "Improves flight agility. Grants speed XP.",
            xpGrant           = 15,
            statBoost         = { stat = "speed", amount = 1 },
            cooldownSec       = 3600,    -- RL seconds before this item can be used again per bird
            trainingDurationSec = 300,   -- Bird is "in training" for this long (consumed from NUI)
        },
        {
            item              = "bird_training_perch",
            label             = "Training Perch",
            description       = "Builds stamina. Reduces recovery time after flights.",
            xpGrant           = 10,
            statBoost         = { stat = "stamina", amount = 2 },
            cooldownSec       = 7200,
            trainingDurationSec = 600,
        },
    },

    -- ── Care items ──────────────────────────────────────────────
    -- Items used to feed and heal birds.
    careItems = {
        {
            item        = "bird_seed",
            label       = "Bird Seed",
            description = "Basic bird feed. Restores hunger.",
            hungerRestore = 30,
            healthRestore = 0,
            loyaltyGain   = 2,
        },
        {
            item        = "bird_treats",
            label       = "Premium Treats",
            description = "Highly nutritious. Restores more hunger and builds loyalty.",
            hungerRestore = 60,
            healthRestore = 10,
            loyaltyGain   = 8,
        },
        {
            item        = "bird_medicine",
            label       = "Bird Medicine",
            description = "Restores bird health. Can revive a gravely ill bird.",
            hungerRestore = 0,
            healthRestore = 50,
            loyaltyGain   = 3,
        },
    },

    -- ── Health & hunger decay (real-world minutes) ──────────────
    -- Hunger drains at hungerDecayPerMinute points per RL minute.
    -- When hunger hits 0, health begins to drain.
    hungerDecayPerMinute = 0.2,       -- points/min  (100 hunger lasts ~8 hours)
    healthDecayPerMinute = 0.05,      -- points/min when hungry (100 health lasts ~33 hours when fully hungry)
    loyaltyDecayPerDay   = 5,         -- loyalty points lost per RL day without interaction

    -- When true, hunger/health decay ONLY ticks while the bird's owner is online.
    -- On disconnect, current stats are frozen and last_cared_at is reset to NOW()
    -- so no decay accumulates while the player is away.
    -- When false (default), decay runs 24/7 based on real-world elapsed time.
    decayOnlyWhenOnline = true,

    -- Below this hunger % the bird becomes "hungry" (shown in UI)
    hungerWarningThreshold = 25,
    -- Below this health % the bird becomes "sick"
    healthWarningThreshold = 20,
    -- If health reaches 0 the bird dies (cannot be used until revived / replaced)
    deathEnabled = true,

    -- ── Flight system ────────────────────────────────────────────
    -- Speed multiplier applied to the bird's speed stat when computing ETA.
    -- flightSeconds = baseSeconds + (distanceMeters / (bird.speed * speedMultiplier))
    speedMultiplier = 1.0,

    -- Minimum flight time in seconds regardless of distance (prevents instant delivery).
    minFlightSeconds = 20,

    -- Maximum range a bird can fly in one trip (meters). 0 = unlimited.
    maxFlightRangeMeters = 0,

    -- After a flight, the bird needs this many RL seconds rest before it can fly again.
    -- Reduced by stamina training.
    baseRestSeconds = 300,            -- 5 minutes at base

    -- Stamina bonus: every 10 points of stamina above 80 reduces rest by this many seconds.
    staminaRestReduction = 15,

    -- While a bird is in flight it cannot be used for another delivery.

    -- ── XP and levelling ─────────────────────────────────────────
    -- XP required to level up = baseXpPerLevel * level
    baseXpPerLevel = 100,

    -- XP awarded per successful delivery
    xpPerDelivery = 25,

    -- Stat bonus gained on level-up
    levelUpSpeedBonus    = 1,
    levelUpStaminaBonus  = 2,
    levelUpHealthBonus   = 5,

    -- ── NUI settings ─────────────────────────────────────────────
    -- How the bird status is labelled for each state.
    statusLabels = {
        healthy  = "Healthy",
        hungry   = "Hungry",
        sick     = "Sick",
        resting  = "Resting",
        inflight = "In Flight",
        training = "In Training",
        dead     = "Dead",
    },
}

-- ═══════════════════════════════════════════════════════════════
-- PUBLIC BOARD (Bulletin Board)
-- Players can post telegrams to a shared public board visible to everyone.
-- Posts are ephemeral — cleared on restart and/or after a configurable time.
-- ═══════════════════════════════════════════════════════════════
Config.PublicBoard = {
    enabled = true,

    -- Maximum number of posts visible on the board at any time.
    maxPosts = 50,

    -- Maximum posts a single player can have on the board at once.
    maxPostsPerPlayer = 5,

    -- Cost to post a bulletin (0 = free).
    postCost = 1.00,

    -- Minutes before a post expires and is automatically removed.
    -- Set to 0 to only clear on server restart (no timed expiry).
    expiryMinutes = 1440, -- 24 hours

    -- Wipe the entire board on every server restart.
    clearOnRestart = true,

    -- Allow anonymous bulletin posts.
    allowAnonymous = true,

    -- Job restrictions: empty = everyone can post. Example: { "lawman", "doctor" }
    allowedJobs = {},

    -- Identifier restrictions: empty = everyone. Example: { "steam:110000xxxxxxx" }
    allowedIdentifiers = {},
}
