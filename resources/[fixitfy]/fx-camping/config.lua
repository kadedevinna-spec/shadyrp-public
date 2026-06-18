Config = {}
Config.Debug    = false
Config.DevMode  = false   -- true: enables developer commands (/testwagon, /clearwagon)
Config.Language = "en" -- en = English, tr = Turkish, de = German (for locale keys see locales.lua)

-- ─── GENERAL ─────────────────────────────────────────────────────────────────

Config.Settings = {
    UseTarget              = false,
    MaxSpawnPropCamp       = 250,
    MaxPlayerCreateCamp    = 1,
    MaxPlayerCampRadius    = 50.0,
    createTown             = false,  -- false = in town create camp
    PropStreamDistance     = 500.0,    -- distance at which camp props are spawned/despawned
    DefaultInstallDuration = 5000,     -- ms fallback if item has no installDuration
    CampNameMaxLength      = 32,
    MemberScanRadius       = 20.0,     -- radius in metres for nearby-player scan in the members section
    CampMenuCommand        = 'mycamp',     -- command to open camp menu (also works as /mycamp [charid] to view other camps)
    CreateCampCommand      = 'createcamp', -- command to open create-camp item picker menu
    CampInfoCommand        = 'campinfo',   -- command to open camp info / tutorial menu
    EnableCampInfo         = true,         -- enable /campinfo command
    CampWagonItem          = "caravan_wagon", -- item consumed when using "Move Camp" campwagon
    CampWagonProp          = "wagon04x", -- wagon prop model
    CampWagonInteractDistance = 3.0, -- distance to interact with wagon (stash, change propset, remove)
    AutoRotatePreview = false,        -- auto-rotate prop in store preview and /mycamp inventory hover
    PlacementCamFov   = 90.0,         -- field-of-view for the prop placement camera (higher = wider / more zoomed out)
    PlacementCamDist  = 6.5,          -- distance (metres) the placement camera sits behind the prop
    CampWagonBlip = {
        showBlip   = true,
        BlipSprite =  874255393,
        BlipColor  = "BLIP_MODIFIER_MP_COLOR_27",
        BlipName   = "Camp Wagon",
        BlipScale  = 0.6,
    },
}

-- ─── MEMBER PERMISSIONS ──────────────────────────────────────────────────────
-- Default permissions granted to each new member.
-- Shown as checkboxes in the Add/Edit member dialog.
-- Server enforces all checks; UI merely presents them.

Config.MemberPermissions = {
    admin          = { label = "Camp Admin (all permissions)", default = false },
    stash          = { label = "Access Storage",    default = true  },
    menu           = { label = "Access Camp Menu",  default = true  },
    place_prop     = { label = "Place Props",       default = true  },
    move_prop      = { label = "Move Props",        default = true },
    remove_prop    = { label = "Remove Props",      default = true },
    set_wardrobe   = { label = "Set Wardrobe",      default = true },
    manage_members = { label = "Manage Members",    default = false },
    move_camp      = { label = "Move Camp",         default = false },
    delete_camp    = { label = "Delete Camp",       default = false },
}

Config.WagonAppearance = {
    ["wagon04x"] = {
        defaultPropset = "pg_mission_mud1_wagon02x",  -- applied on first spawn
        tint     = 22,    -- 0–22 available; -1 = no tint
        livery   = 1,     -- 0–16 available; -1 = no livery
        lanterns = {
            "pg_teamster_wagon04x_lightupgrade3",
        },
        extras   = { 1, 2, 3, 5 },
    },
}

-- Selectable propsets per wagon model.
-- "Change Propset" (G key) cycles through this list one by one.
Config.WagonPropsets = {
    ["wagon04x"] = {
        "pg_gunforhire01x",
        "pg_gunforhire02x",
        "pg_gunforhire03x",
        "pg_mission_mud1_jackwagon01x",
        "pg_mission_mud1_wagon01x",
        "pg_mission_mud1_wagon02x",
        "pg_teamster_wagon04x_breakables",
        "pg_teamster_wagon04x_gen",
        "pg_teamster_wagon04x_gen02",
        "pg_veh_wagon04x_1",
        "pg_veh_wagon04x_2",
        "pg_veh_wagon04x_3",
        "pg_vl_blacksmith01",
        "pg_vl_butcher01",
        "pg_vl_craftsman01",
        "pg_vl_delivery01",
        "pg_vl_farmer01",
        "pg_vl_farmer02",
        "pg_vl_ferrier01",
        "pg_vl_fisherman01",
        "pg_vl_hunter01",
        "pg_vl_movingFamily01",
        "pg_vl_rancher01",
        "pg_vl_rancher02",
        "pg_vl_rancher03",
        "pg_vl_rancher04",
        "pg_vl_rancher05",
        "pg_vl_tradesman01",
        "pg_vl_tradesman02",
        "pg_vl_tradesman03",
        "pg_vl_tradesman04",
        "pg_vl_travellingFamily01",
        "pg_vl_travellingLabour01",
        "pg_veh_germFam_wagon04x_01",
    },
}

Config.CampPlacement = {
    MoveForward  = 0x6319DB71,   -- UP ARROW    (INPUT_FRONTEND_UP)
    MoveBackward = 0x05CA7C52,   -- DOWN ARROW  (INPUT_FRONTEND_DOWN)
    MoveLeft     = 0xA65EBAB4,   -- LEFT ARROW  (INPUT_FRONTEND_LEFT)
    MoveRight    = 0xDEB34313,   -- RIGHT ARROW (INPUT_FRONTEND_RIGHT)
    MoveUp       = 0x06052D11,   -- Q           (INPUT_DIVE)
    MoveDown     = 0x43CDA5B0,   -- Z           (INPUT_FRONTEND_LS)
    SnapToGround = 0xD9D0E1C0,   -- SPACE       (INPUT_JUMP)             → snap to ground
    HeadingCCW   = 0x7065027D,   -- A           (INPUT_MOVE_LEFT_ONLY)   → yaw left
    HeadingCW    = 0xB4E465B4,   -- D           (INPUT_MOVE_RIGHT_ONLY)  → yaw right
    RotateCCW    = 0x9959A6F0,   -- C           (INPUT_LOOK_BEHIND)      → axis -
    RotateCW     = 0x7F8D09B8,   -- V           (INPUT_NEXT_CAMERA)      → axis +
    SwitchAxis   = 0x4CC0E2FE,   -- B           (INPUT_OPEN_SATCHEL_MENU)→ switch axis
    Confirm      = 0xC7B5340A,   -- ENTER       (INPUT_FRONTEND_ACCEPT)
    Cancel       = 0x308588E6,   -- BACKSPACE   (INPUT_GAME_MENU_CANCEL)
    MoveSpeed    = 0.03,         -- metres per tick
    RotateSpeed  = 1.0,          -- degrees per tick
    HeightSpeed  = 0.03,         -- metres per tick
}

-- ─── CAMP INSTALL ANIMATION ──────────────────────────────────────────────────

Config.CampInstall = {
    animDict   = "amb_work@world_human_hammer@table@male_a@trans",
    animName   = "base_trans_base",
    label      = "Installing...",
    hammerProp = "p_hammer04x",
    blip = {
        showBlip   = true,
        BlipSprite = 773587962,
        BlipColor  = "BLIP_MODIFIER_MP_COLOR_27",
        radiusColor = "BLIP_MODIFIER_MP_COLOR_26",
        BlipName   = "My Camp",
        BlipScale  = 0.6,
    },
}

-- ─── ADMIN CAMPS COMMAND ─────────────────────────────────────────────────────

Config.AdminCamps = {
    command       = "camps",           -- /camps command
    allowedGroups = { "admin", "god" }, -- allowed groups (FXGetPlayerGroup)
    allowedJobs   = {},                 -- allowed jobs (in addition)
}

-- in preview prop draw light settings
Config.DrawLight    = { open = true,  distance = 5.0,  openRgba = { 255, 255, 255, 250 }, closeRgba = { 255, 255, 255, 150 }, range = 2.0,  intensity = 20.0, extraZ = 2.0 }
Config.DrawMarker   = { open = false, distance = 1.5,  openRgba = { 255, 255, 255, 250 }, closeRgba = { 153, 0,   0,   150 }, type  = "0x94FDAE17", scale = { 1.0, 1.0, 0.15 }, extraZ = 0.0 }
Config.DrawTexture  = { open = true, distance = 2.0,  openRgba = { 255, 255, 255, 250 }, textureStream = "overhead", textureName = "overhead_objective", extraZ = 0.2, width = 0.01, height = 0.01, heading = 0.251 }
Config.HighlightProp = { open = false, distance = 1.5 }


Config.CampStore = {
    ["Camping"] = {
        label           = "Camping Supplies",
        shopItems       = Config.CampItems,
        priceMultiplier = 1.0,

        ped              = true,
        model            = "cs_nils",
        pedSpawnDistance = 30,
        coords           = {
            [1] = vector4(-870.0121, -1313.6134, 43.0142, 64.0291),   -- Blackwater
        },
        promptitle = "Camping Store",
        pedScenario = "WORLD_HUMAN_SMOKE_NERVOUS_STRESSED",
        anim = { animDict = '', animName = '' },

        Blip = {
            showBlip   = true,
            BlipSprite = 1202244626,
            BlipColor  = "BLIP_MODIFIER_MP_COLOR_4",
            BlipName   = "Camping Store",
            BlipScale  = 0.6,
        },
        openTimeSetting = {
            allowed      = false,
            open         = 8,
            close        = 21,
            BlipSprite   = 1202244626,
            blipmodifier = "BLIP_MODIFIER_MP_COLOR_2",
        },
        canInteract = { func = true, error = "none" },
        distance     = 2,
        requiredJobs = false,            -- false = everyone; { "shepherd", "hunter" } = job whitelist
        camSettings = {
            [1] = { coords = vector3(-866.11, -1297.84, 46.53), fov = 71.0, rotation = vector3(-22.41, 0.00, 153.38) },
        },
        spawnPreviewObjectCoords = {
            [1] = vector4(-869.6317138671875, -1304.050048828125, 43.04628372192383, 150.0),
        },
    },
}

Config.Prompts = {
    ["store"] = {
        Label    = "prompt_lbl_store",
        distance = 2.0,
        Keys  = {
            [1] = { Key = 0x760A9C6F, Label = "prompt_key_open",  HoldTime = 200 },
        },
    },

    ["campStash"] = {
        Label    = "prompt_lbl_stash",
        distance = 2.0,
        Keys  = {
            [1] = { Key = 0x760A9C6F, Label = "prompt_key_open_storage", HoldTime = 200 },
        },
    },

    ["campInstall"] = {
        Label    = "prompt_lbl_prop",
        distance = 2.0,
        Keys  = {
            [1] = { Key = 0xC7B5340A, Label = "prompt_key_install", HoldTime = 600 },
            [2] = { Key = 0x6D1319BE, Label = "prompt_key_remove",  HoldTime = 300 },
        },
    },

    ["campProp"] = {
        Label    = "prompt_lbl_prop",
        distance = 2.5,
        Keys  = {
            [1] = { Key = 0x6D1319BE, Label = "prompt_key_remove", HoldTime = 400 },
            [2] = { Key = 0xC7B5340A, Label = "prompt_key_move",   HoldTime = 300 },
        },
    },

    ["campWagon"] = {
        Label    = "prompt_lbl_wagon",
        distance = 6.0,
        Keys  = {
            [1] = { Key = 0x760A9C6F, Label = "prompt_key_storage",         HoldTime = 200 },
            [2] = { Key = 0x5734A944, Label = "prompt_key_remove_wagon",    HoldTime = 600 },
            [3] = { Key = 0x6D1319BE, Label = "prompt_key_change_propset",  HoldTime = 300 },
        },
    },

    ["campWardrobe"] = {
        Label    = "ui_wardrobe",
        distance = 2.0,
        Keys  = {
            [1] = { Key = 0x760A9C6F, Label = "ui_open_wardrobe", HoldTime = 200 },
        },
    },
}

Config.HideHud = function()
  if GetResourceState("fx-hud") == "started" then
    exports["fx-hud"]:hideHud()
  end
end

Config.ShowHud = function()
  if GetResourceState("fx-hud") == "started" then
    exports["fx-hud"]:showHud()
  end
end

function Notify(data)
    local text  = data.text  or "No message"
    local time  = data.time  or 5000
    local ntype = data.type  or "info"
    local dict  = data.dict
    local icon  = data.icon
    local color = data.color or 0
    local src   = data.source

    if IsDuplicityVersion() then
        if Framework == "RSG" then
            TriggerClientEvent("fx-hud:client:showNotify", src, text, time, ntype)
        elseif Framework == "REDEMRP" then
            text = string.gsub(text, "~.-~", "")
            TriggerClientEvent("redem_roleplay:Tip", src, text, time)
        elseif Framework == "VORP" then
            if icon then
                TriggerClientEvent('vorp:ShowAdvancedRightNotification', src, text, dict, icon, color, time)
            else
                TriggerClientEvent("vorp:TipBottom", src, text, time, ntype)
            end
        end
    else
        if Framework == "RSG" then
            TriggerEvent("fx-hud:client:showNotify", text, time, ntype)
        elseif Framework == "REDEMRP" then
            text = string.gsub(text, "~.-~", "")
            TriggerEvent("redem_roleplay:Tip", text, time)
        elseif Framework == "VORP" then
            if icon then
                TriggerEvent("vorp:ShowAdvancedRightNotification", text, dict, icon, color, time)
            else
                TriggerEvent("vorp:TipBottom", text, time, ntype)
            end
        end
    end
end

