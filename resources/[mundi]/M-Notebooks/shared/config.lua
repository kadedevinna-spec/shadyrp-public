-- ╔═══════════════════════════════════════════════════════════════╗
-- ║            M-NOTEBOOKS - CONFIGURATION FILE                   ║
-- ║                                                               ║
-- ║            NAVIGATION GUIDE (Use Ctrl+F to search):           ║
-- ║  • [CORE]       - Core framework settings                     ║
-- ║  • [ITEMS]      - Item requirements & page items              ║
-- ║  • [NOTEBOOK]   - Notebook defaults & limits                  ║
-- ║  • [ANIMATIONS] - Opening/closing/writing animations          ║
-- ║  • [PINNING]    - Pin notes to walls system                   ║
-- ║  • [DISCORD]    - Discord webhook logging                     ║
-- ║  • [UI]         - NUI customization options                   ║
-- ║  • [COMMANDS]   - Chat commands & keybinds                    ║
-- ║  • [MESSAGES]   - Notification texts                          ║
-- ║  • [ADMIN]      - Admin monitoring & commands                 ║
-- ╚═══════════════════════════════════════════════════════════════╝

Config = {}

-- ╔═══════════════════════════════════════════════════════════════╗
-- ║                    [LOCALE] LANGUAGE SETTINGS                 ║
-- ╚═══════════════════════════════════════════════════════════════╝

Config.Locale = "en"                         -- Language for notifications (see locale.lua for available languages)

-- ╔═══════════════════════════════════════════════════════════════╗
-- ║                      [CORE] CORE SETTINGS                     ║
-- ╚═══════════════════════════════════════════════════════════════╝

Config.Core = {
    framework = "RSG",              -- Framework: "VORP" or "RSG"
    debug = true,                   -- Enable debug prints in F8 console
}

-- ╔═══════════════════════════════════════════════════════════════╗
-- ║                    [ITEMS] ITEM REQUIREMENTS                  ║
-- ╚═══════════════════════════════════════════════════════════════╝

Config.Items = {
    -- Notebook item (must be in inventory to open your notebook)
    notebookItem = "notebook",           -- Item name in vorp_inventory
    
    -- Pen requirement for WRITING (reading always works)
    penRequired = false,                  -- Set false to disable pen requirement
    penItem = "pen",                     -- Pen item name
    penConsumeOnUse = false,             -- If true, pen is removed after writing session

    -- Pen durability (tracks ink usage over time)
    penDurability = {
        enabled = true,                  -- Enable pen durability system
        maxUses = 500,                   -- Total ink uses before pen runs out
        inkPerUse = 1,                   -- Ink consumed per write or draw action
                                         -- Only consumed when the player actually writes text
                                         -- or draws on the canvas (not when moving/deleting)
    },

    -- Torn page item (given to player when they tear a page)
    tornPageItem = "torn_page",          -- Item name for torn pages
}

-- ╔═══════════════════════════════════════════════════════════════╗
-- ║                  [NOTEBOOK] NOTEBOOK DEFAULTS                 ║
-- ╚═══════════════════════════════════════════════════════════════╝

Config.Notebook = {
    defaultPages = 200,                  -- Default number of pages per notebook
    maxPages = 200,                      -- Maximum pages a notebook can have
    maxCharactersPerPage = 500,          -- Max characters per page
    maxImagesPerPage = 1,                -- Max images per page (via URL)
    
    -- Metadata defaults
    defaultTitle = "Notebook",        -- Default notebook title
    defaultCoverDate = "Est. 1899",      -- Default cover date text (editable by players)
    allowCustomTitle = true,             -- Let players rename their notebook
    showOwnerOnCover = true,             -- Show owner name on cover page
    othersCanEdit = true,                -- If true, other players can EDIT notebooks they find/steal
                                         -- If false, non-owners can only VIEW (read-only)
}

-- ╔═══════════════════════════════════════════════════════════════╗
-- ║                  [ANIMATIONS] ANIMATION SETTINGS              ║
-- ╚═══════════════════════════════════════════════════════════════╝

Config.Animations = {
    -- Scenario used while notebook is open
    -- The player will sit/stand with a notebook prop from the scenario itself
    useScenario = true,                  -- Use scenario instead of raw animations
    scenario = "WORLD_HUMAN_WRITE_NOTEBOOK",  -- RDR2 notebook scenario

    -- Fallback raw animations (only used if useScenario = false)
    openBook = {
        male = {
            dict = "amb_rest_lean@world_write_on_notepad@male_a@idle_a",
            anim = "idle_a",
            flag = 49,     -- Upper body only, looping
        },
        female = {
            dict = "amb_rest_lean@world_write_on_notepad@female_a@idle_a",
            anim = "idle_a",
            flag = 49,
        },
    },
    
    -- Writing animation (while NUI is open and player writes)
    writing = {
        male = {
            dict = "amb_rest_lean@world_write_on_notepad@male_a@idle_b",
            anim = "idle_b",
            flag = 49,
        },
        female = {
            dict = "amb_rest_lean@world_write_on_notepad@female_a@idle_b",
            anim = "idle_b",
            flag = 49,
        },
    },
    
    -- Page flip animation duration (ms)
    pageFlipDuration = 400,

    -- Wall-pin hammer animation (played when the player confirms placing a page on the wall)
    pinAnim = {
        dict     = "mech_inventory@crafting@fallbacks",
        anim     = "full_craft_and_stow",
        duration = 2500,   -- ms to play before the note is pinned
        flag     = 27,     -- flag used by the crafting animation
    },
    
    -- Prop models
    bookProp = "p_journal01x",           -- Book prop model held in hand
    bookBone = 36029,                    -- Hand bone index (left hand)
    bookOffset = { x = 0.13, y = 0.04, z = 0.01 },
    bookRotation = { x = -100.0, y = 10.0, z = 0.0 },
}

-- ╔═══════════════════════════════════════════════════════════════╗
-- ║                  [PINNING] PIN NOTES TO WALLS                 ║
-- ╚═══════════════════════════════════════════════════════════════╝

Config.Pinning = {
    enabled = true,                      -- Enable pin-to-wall system
    maxPinnedPerPlayer = 10,             -- Max pinned notes per player
    maxPinnedTotal = 200,                -- Max total pinned notes on server
    
    -- Prop used for pinned notes in world
    pinnedProp = "p_letter01x",          -- World prop for pinned note
    
    -- Interaction
    interactionDistance = 2.0,           -- Distance to read/delete pinned note
    useOxTarget = false,                  -- Use ox_target for interaction (set false to use native prompts instead)

    -- Native prompt controls (only used when useOxTarget = false)
    -- These are RDR2 control action hashes for the prompt buttons
    nativePromptKeys = {
        read   = `INPUT_INTERACT_LOCKON_ANIMAL`,  -- G key — read the note
        remove = `INPUT_FRONTEND_RS`,        -- X key — remove the note from the wall
        take   = `INPUT_MELEE_GRAPPLE_CHOKE`,  -- E key — take the note
    },
    
    -- Permissions
    ownerCanDelete = true,               -- Owner can always delete their pinned notes
    anyoneCanRead = true,                -- Anyone can read pinned notes
    adminCanDelete = true,               -- Admins can delete any pinned note
    adminGroups = { "admin", "god" },    -- Admin permission groups
    
    -- Placement
    placementSpeed = {
        move = 0.01,                     -- Movement speed per frame
        rotate = 5.0,                    -- Rotation degrees per scroll
    },
    
    -- Controls for placement mode
    placementKeys = {
        confirm = 0xC7B5340A,            -- Enter / E key
        cancel = 0x156F7119,             -- Backspace
        rotateLeft = 0xA65EBAB4,         -- Scroll up
        rotateRight = 0xFD1F944B,        -- Scroll down
        moveUp = 0x6319DB71,             -- Arrow up
        moveDown = 0x05CA7C52,           -- Arrow down
    },
    
    -- Expiration
    enableExpiration = true,             -- Notes expire after time
    defaultExpirationHours = 48,         -- Fallback if no duration chosen
    
    -- Duration options shown to player when pinning a note
    -- Set to false or empty to skip selection (uses defaultExpirationHours)
    expirationChoices = {
        { label = "1 Hour",    hours = 1 },
        { label = "4 Hours",   hours = 4 },
        { label = "8 Hours",   hours = 8 },
        { label = "24 Hours",  hours = 24 },
        { label = "48 Hours",  hours = 48 },
    },
    
    -- Cleanup interval (minutes) — how often the server checks for expired notes
    cleanupIntervalMinutes = 5,

    -- Expiration exemptions — certain jobs or admin groups can pin notes with
    -- extended or infinite durations. If a player matches ANY exemption, they
    -- get the special duration options instead of the normal ones.
    expirationExemptions = {
        enabled = false,

        -- Jobs that bypass normal expiration (matches player's current job name)
        jobs = { "sheriff", "doctor" },

        -- Admin groups that bypass normal expiration
        groups = { "admin", "god" },

        -- false = notes from exempt players NEVER expire (infinite)
        -- number = custom hours override (e.g. 720 = 30 days)
        exemptDuration = false,

        -- Duration choices shown to exempt players (only used if exemptDuration is not set)
        -- If exemptDuration is false (infinite), these are ignored and notes never expire.
        -- If exemptDuration is a number, that value is used directly.
        -- If you want exempt players to CHOOSE from longer options, set exemptDuration = nil
        -- and fill these in instead:
        exemptChoices = {
            { label = "1 Week",    hours = 168 },
            { label = "2 Weeks",   hours = 336 },
            { label = "30 Days",   hours = 720 },
            { label = "Permanent", hours = 0 },   -- 0 = never expires
        },
    },
}

-- ╔═══════════════════════════════════════════════════════════════╗
-- ║              [DISCORD] DISCORD WEBHOOK LOGGING                ║
-- ╚═══════════════════════════════════════════════════════════════╝

Config.Discord = {
    enabled = true,                     -- Enable Discord webhook logging
    webhookUrl = "https://discord.com/api/webhooks/1471158786877161627/UedjKiD9mi0toi57HQ2MHvbfgf34LFQIPj_HNAP4A-3sgZYq3hfuNN3nrjCPfKU7vqNB",                     -- Your Discord webhook URL

    -- What to log
    logPinnedNotes = true,               -- Log when notes are pinned/removed/taken
    logTornPages = true,                 -- Log when a page is torn out
    logTitleChanges = true,              -- Log when a notebook title is changed
    logAdminActions = true,              -- Log admin deletions
}

-- ╔═══════════════════════════════════════════════════════════════╗
-- ║                     [UI] NUI CUSTOMIZATION                    ║
-- ╚═══════════════════════════════════════════════════════════════╝

Config.UI = {
    -- Tool panel position
    -- "binding" = tools toggle via feather icon on book binding (bottom toolbars)
    -- "right"   = vertical panel on the right side of the book
    -- "left"    = vertical panel on the left side of the book
    toolPosition = "right",

    -- Quill toggle button position
    -- "binding"  = full-height tab on the book binding (original position)
    -- "topRight" = circular button at the top-right corner of the book
    -- "topLeft"  = circular button at the top-left corner of the book
    quillPosition = "topRight",

    -- Input blocking while notebook is open
    -- The control thread disables ALL game actions every frame, then re-enables
    -- only the controls listed below. Add or remove control hashes as needed.
    -- Voice chat (push-to-talk) is enabled by default.
    --
    -- NOTE: RegisterKeyMapping keybinds (J, H, Y, etc.) bypass the control system.
    -- Other scripts should check exports['M-Notebooks']:IsNotebookOpen() to block theirs.
    allowedControls = {
        `INPUT_PUSH_TO_TALK`,       -- Voice chat push-to-talk
        `INPUT_VEH_PUSH_TO_TALK`,   -- Vehicle voice chat
        `INPUT_CURSOR_ACCEPT`,      -- Mouse left click (NUI interaction)
        `INPUT_CURSOR_CANCEL`,      -- Mouse right click
        `INPUT_CURSOR_X`,           -- Mouse X axis
        `INPUT_CURSOR_Y`,           -- Mouse Y axis
    },

    -- Feature toggles — enable or disable specific notebook tools for your players
    features = {
        drawing   = true,    -- Allow players to draw/sketch on pages (pen required)
        eraser    = true,    -- Allow players to erase drawings (requires drawing enabled)
        images    = true,    -- Allow players to paste image URLs onto pages
        cutPage   = true,    -- Allow players to tear out a page (creates torn_page item)
        pinPage   = true,    -- Allow players to pin a page to the world
        copyPage  = true,    -- Allow players to copy a page's content to the next page
        fontCycle = true,    -- Allow players to cycle between handwriting fonts
        lines     = true,    -- Allow players to toggle lined paper on/off
    },

    -- Available ink colors for writing
    inkColors = {
        { label = "Black",      hex = "#1a1a1a" },
        { label = "Dark Brown", hex = "#3c2415" },
        { label = "Blue",       hex = "#1a3a5c" },
        { label = "Red",        hex = "#8b1a1a" },
        { label = "Green",      hex = "#2d5a27" },
        { label = "Purple",     hex = "#4a235a" },
        { label = "Sepia",      hex = "#704214" },
    },
    
    -- Available handwriting fonts
    fonts = {
        { label = "Caveat",              family = "'Caveat', cursive" },
        { label = "Cedarville Cursive",  family = "'Cedarville Cursive', cursive" },
        { label = "Indie Flower",        family = "'Indie Flower', cursive" },
        { label = "Nothing You Could Do", family = "'Nothing You Could Do', cursive" },
        { label = "Oooh Baby",           family = "'Oooh Baby', cursive" },
        { label = "Reenie Beanie",       family = "'Reenie Beanie', cursive" },
        { label = "Shadows Into Light",  family = "'Shadows Into Light', cursive" },
    },
    
    -- Default writing settings
    defaults = {
        font = "Caveat",
        inkColor = "#1a1a1a",
        fontSize = 1.0,                  -- Scale factor (0.6 - 2.0)
        showLines = true,                -- Show lined paper by default
    },
    
    -- Paper backgrounds
    paperStyle = "parchment",            -- "parchment", "white", "aged"
}

-- ╔═══════════════════════════════════════════════════════════════╗
-- ║                  [COMMANDS] COMMANDS & KEYBINDS               ║
-- ╚═══════════════════════════════════════════════════════════════╝

Config.Commands = {
    openNotebook = "notebook",           -- /notebook to open (also triggered by item use)
    resetNUI = "resetnotebook",          -- Emergency NUI reset command
    
    -- Keybind (set to false to disable keybind, use item only)
    keybindEnabled = false,
    keybindKey = "N",                    -- Key to open notebook
}

-- ╔═══════════════════════════════════════════════════════════════╗
-- ║                 [MESSAGES] NOTIFICATION TEXTS                 ║
-- ║  NOTE: These are now managed via locale.lua for translation   ║
-- ║  support. Edit locale.lua to change notification texts.       ║
-- ║  Config.Messages below serves as a legacy fallback only.      ║
-- ╚═══════════════════════════════════════════════════════════════╝

Config.Messages = {
    noNotebook = "You don't have a notebook.",
    noPen = "You need a pen to write.",
    notebookOpened = "Opening notebook...",
    notebookSaved = "Notebook saved.",
    pageLimitReached = "You've reached the maximum number of pages.",
    notePinned = "Note pinned to wall.",
    noteRemoved = "Pinned note removed.",
    maxPinnedReached = "You've reached the maximum number of pinned notes.",
    cannotDeleteOther = "You can only remove your own notes.",
    penBroken = "Your pen has run out of ink.",
    penLow = "Your pen is running low on ink.",

    tooFarAway = "You're too far away.",
}

-- ╔═══════════════════════════════════════════════════════════════╗
-- ║               [ADMIN] ADMIN MONITORING & LOGGING              ║
-- ╚═══════════════════════════════════════════════════════════════╝

Config.Admin = {
    -- Admin command to view/manage any player's notebook (/notebookadmin <serverid>)
    -- Opens a menu where you can View or Delete each notebook
    adminCommand = "notebookadmin",
    adminGroups = { "admin", "god" },    -- Permission groups that can use admin command
}
