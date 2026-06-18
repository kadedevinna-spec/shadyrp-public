Config = Config or {}

Config.Debug = false                  -- Enable verbose debug prints for cursor/hit info

Config.Language = 'en'

Config.ToggleCommand = 'gm'           -- Chat/console command to toggle Game Master mode

-- Camera and movement
Config.InitialAltitude = 10.0         -- Starting camera height above ground
Config.MinAltitude = 1.5              -- Minimum camera height (close to ground)
Config.MaxAltitude = 100.0            -- Maximum camera height (~100m)
Config.MoveSpeed = 10.0               -- Base lateral movement speed (m/s)
Config.MoveSpeedSprintMultiplier = 5.0 -- Hold Shift to move this many times faster
Config.ZoomSpeed = 5.0                -- Mouse wheel zoom speed (height delta)
Config.RotateSpeed = 90.0             -- Degrees/sec when rotating with arrows
Config.MouseRotateSensitivity = 200.0   -- Multiplier for MMB mouse rotation (lower = slower)
Config.SelectionMaxDistance = 300.0   -- Only consider peds within this distance of the camera for selection calculations



-- Commands
Config.AttackAreaDuration = 60000 -- how long to attack peds in area on "Attack in Area Context menu action" in milliseconds before stopping. (Default: 60 seconds (60000ms))



-- Preview ghost peds while in spawn mode
-- When enabled, shows a semi-transparent, local-only ped following the cursor
-- to indicate where/with which heading the ped would spawn on click/hold.
Config.ShowSpawnPreviewPeds = false

-- Optional tuning for spawn preview smoothing and visibility
Config.SpawnPreview = Config.SpawnPreview or {
    -- Critically-damped smoothing (no snaps): lower smoothTime = snappier
    smoothTime = 0.06,
    headingSmoothTime = 0.05,
    -- Max allowed follow speed (m/s) for stability on big jumps
    maxSpeed = 120.0,
    -- Vertical offset applied after ground projection so preview doesn't clip into terrain
    groundOffset = 1.0,
    -- Optional heading offset to compensate for individual models (0 keeps preview aligned to indicator)
    headingOffset = 0.0,
    -- Legacy values (no longer used): snapDistance, closeLerp
    -- Keep for backward-compat if you override them elsewhere
    snapDistance = 10.0,
    closeLerp = 0.7,
    -- Ensure ghost ped stays visible when cursor is far from camera
    cullingDistance = 2000.0,
}


Config.stayInvisibleAfterLeavingGm = false -- if true, the player will stay invisible after leaving gm mode

-- Exit teleport behavior
-- "entry": teleport player back to where they were when they entered GM mode
-- "camera": teleport player to where the camera is positioned when exiting (current behavior)
-- "coords": teleport player to specified coordinates (set exitCoords below)
Config.ExitTeleportBehavior = "camera"

-- Exit coordinates (only used when ExitTeleportBehavior is "coords")
-- Set to {x = 0.0, y = 0.0, z = 0.0} or use specific coordinates
Config.ExitCoords = {x = 2385.05, y = -2295.01, z = 43.53}



-- UI: Networked entity pool indicator configuration
Config.NetworkIndicator = {
    enabled = true,            -- Toggle indicator visibility entirely
    maxCapacity = 110,         -- Reference capacity displayed as "/max"
    Notify = {
        enabled = false,
    },
    -- Thresholds determine indicator color. Values are lower bounds for each band.
    thresholds = {
        yellow = 76,           -- > yellow => show yellow (warning)
        orange = 91,           -- > orange => show orange (high)
        red = 101,             -- > red => show red (critical)
    },
    minVisible = 1,            -- Do not show indicator when count < minVisible
}

Config.Permissions = {
    -- if you want to use a custom function to check if a player is able to use the gm command, you can set it here
    -- example with jobs:
    -- useGameMaster = function(src)
    --     local job = Bridge._fw.getJob(src)
    --     return job == 'admin' or job == 'gamemaster'
    -- end
    -- or just everyone:
    -- return true
    useGameMaster = function(src) 
        return true --IsPlayerAceAllowed(src, "dd_gamemaster.admin") --in permissions it would look like "add_ace group.admin dd_gamemaster.admin allow"
    end
}

-- You can override the walk option speeds for each category here. 
-- Play around with the values to find the best fit for your use case.
Config.WalkOptionSpeeds = Config.WalkOptionSpeeds or {
    ped = {
        walk = 1.5,
        run = 3.0,
    },
    vehicle = {
        walk = 8.0,
        run = 22.0,
    },
    -- Only used for RedM
    mount = {
        walk = 1.5,
        run = 3.0,
    },
}


-- Game Master command restrictions
Config.RequireAliveToUseGmCommand = true -- Set to true to only allow players to use the gm command when not dead


-- Marker colors used by the Game Master UI
Config.DrawMarkers = {
    screenShotMode = false, -- disable all drawing when in screenshot mode
    selection = {
        ped = { r = 0, g = 128, b = 255 },
        vehicle = { r = 255, g = 165, b = 0 },
    },
    destination = {
        line = { r = 0, g = 200, b = 0 },
        marker = { r = 0, g = 200, b = 0 },
    },
    moveOrder = {
        type = 'rotate', -- 'arrow' or 'rotate'
    },
    InfraredVision = true, 
}


-- Health bar color configuration (used by native DrawSprite bars)
-- Adjust these to change the gradient and background/alpha easily
Config.HealthBar = {
    -- Low (0% HP) color
    colorLow = { r = 255, g = 60, b = 60 },
    -- Optional mid color; if set, gradient goes low -> mid -> high
    colorMid = { r = 255, g = 165, b = 0 },
    -- High (100% HP) color
    colorHigh = { r = 51, g = 189, b = 51 },

    -- Background behind the bar
    background = { r = 20, g = 20, b = 20, a = 180 },

    -- Foreground alpha (fill)
    foregroundAlpha = 230,
}

-- Radial Menu
-- Number of slots to render; UI adapts automatically
Config.RadialSlots = Config.RadialSlots or 5
