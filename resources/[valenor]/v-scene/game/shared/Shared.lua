Config = {}

Config.Editor = true -- if you have v-editor you can make true to enable it

Config.PermissionsList = {
    ["jobs"] = {
        "sheriff", "delivery"
    },
    ["groups"] = {
        "admin", "mod"
    },
    ["identifier"] = {
        "license:xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
    }
}

Config.PermissionMode = Config.PermissionMode or 'any'
Config.AllowEditorWhenPermissionsEmpty = Config.AllowEditorWhenPermissionsEmpty ~= false

Config.VisitTracking = Config.VisitTracking or {
    enabled = true,

    -- "character" uses the framework character id when available, then falls back to license.
    -- "license" tracks all characters on the same license together.
    identifierScope = 'character',

    -- Only opted-in scenes are tracked. The editor's Visited Lock button stores
    -- this in scene data. Subtitle tags still work for old/manual scenes.
    -- By default, a visit is marked only after a reward/success action succeeds.
    -- Use [visit-mark:choice] or [visit-mark:open] only for special scenes.
    -- Add cooldownDays/cooldownSeconds to let a completed scene be replayed later.
    scenes = {
        -- ['VLNR12345'] = { mode = 'block', markOn = 'reward', cooldownDays = 3, message = 'You have already done this scene.' },
        -- ['scene_abc123'] = { mode = 'repeat', repeatDialogLineId = 'dialog_line_uid' }
    },

    defaultMessage = 'You have already done this scene.'
}
