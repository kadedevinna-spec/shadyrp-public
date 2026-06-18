Config = {}
Config.Locale = "en" -- en = English, tr = Turkish, de = German etc. (must match a key in locales.lua/Config.Locales)
Config.Debug  = false -- true: verbose server/client console logs | false: only errors and startup info


-- MENU SETTINGS 

Config.OpenMenuCommands = {
    objects  = "objects",  -- command for objects menu
    accmenu  = "accmenu",  -- command for accessory (attached) menu
    accadmin = "giveadminpanel"  -- opens calibration panel for target player: /giveadminpanel [serverid]
}

Config.EditPositions = "editpos"  -- command to open the notify/progress-bar position editor

Config.MenuOpenMode = "keybind" -- "keybind": key only | "command": /accmenu only | "both": both
Config.AccadminAdminOnly = true -- true: only ACE admins can access the calibration panel | false: also accessible to a specific role/group defined in AllowedAccAdmin
Config.AllowedAccAdmin   = "acceditor" -- role/group name that can access the calibration panel if AccadminAdminOnly is false

Config.MenuToggle = true -- true: key opens and closes (toggle) | false: key only opens
Config.OpenMenuKey = {
    useKey = true,
    key    = 115, -- Default: F4 | Full key list: https://cherrytree.at/misc/vk.htm
}


-- UI & VISUAL SETTINGS
Config.AttachedMenuOpenDelayMs = 170 -- Delay before attached menu UI appears after camera focus (ms).
Config.AttachedCamInterpMs = 380 -- Camera transition duration when the accessory menu opens (ms). Lower = snappier, higher = smoother.
Config.AccadminDenyMs = 2000 -- How long (ms) the red deny message stays in the subtitle. Default: 2000
Config.AttachedCamFov = 0 -- Camera zoom level for attached menu focus (0-12). Lower = closer zoom, higher = wider zoom.
Config.UIAnimation = {
    RevealStepMs = 70, -- Delay between each UI group reveal
    RevealDurationMs = 50, -- Fade time of each revealed group
    RadialEffect = "fadeIn", -- radialOpen | fadeIn | slideZoom | rotateFlip
    RadialSpeedMs = 600, -- How long each radial item animation lasts
    RadialStaggerMs = 100, -- Delay between radial items (cascade feel)
    RadialDistancePx = 50, -- Distance of radial items from center node
    HoldDetachMs = 650 -- Hold duration to detach an attached item
}

Config.NightMenuLight = {
    Enabled = true, -- Master toggle
    Time = {
        AlwaysOn = false, -- If true, ignores StartHour/EndHour
        StartHour = 20, -- Night start hour
        EndHour = 6 -- Night end hour
    },
    Direction = {
        -- Mode: "top_down" | "side_right" | "bottom_up" | "custom"
        Mode = "top_down", -- Light direction around the player
        CustomOffset = {
            X = 0.0, -- Custom: left/right offset
            Y = 0.9, -- Custom: forward/back offset
            Z = 0.55 -- Custom: up/down offset
        }
    },
    Visual = {
        ColorHex = "#d4e8ff", -- Any color code: #RRGGBB (example: #FFFFFF)
        Range = 2.5, -- Light range, higher = larger radius
        Intensity = 5.0 -- Light power, higher = brighter
    }
}

Config.CalibOutline = {
    Enabled  = true,    -- Orange outline glow on the calibration prop (SetEntityDrawOutline)
    Light = {
        Enabled   = true,       -- Small point light placed at the prop's exact centre
        ColorHex  = "#d4e8ff",  -- Any #RRGGBB — warm amber by default
        Range     = 0.40,       -- Keep small: light stays ON the prop, not spilling outward
        Intensity = 8.0         -- Brightness
    }
}


-- ANIMATIONS SETTINGS

Config.AnimationSetting = "auto" -- "auto" | "forceStop" | "disable"
-- "auto"       → HoldPose=true: freezes on last frame. HoldPose=false: plays once then stops.
-- "forceStop"  → Always force-stops the animation after AnimationDelay ms.
-- "disable"    → No animation played. Prop attaches silently.

Config.AnimationDelay = 2000 --ms
-- How long (ms) before stopping the animation. Only used in "auto" (HoldPose=false) and "forceStop".


-- SHOP SETTINGS

Config.HideBalanceWhenCartEmpty = true -- true: show YOUR CASH / YOUR GOLD only when cart has items | false: always visible

