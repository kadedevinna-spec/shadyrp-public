# M-Telegrams — Update Notes v1.0.9

This file lists exactly what was changed so you can apply updates surgically
without replacing files that contain your local settings.

---

## FILES TO REPLACE IN FULL

These files contain no server-specific settings — replace them completely:

```
server/database.lua
server/telegrams.lua
client/nui.lua
nui/script.js
nui/index.html
fxmanifest.lua
server/main.lua
```

---

## FILES TO EDIT MANUALLY

### `shared/config.lua`

Only **one new line** was added. No existing lines were changed.

**Where:** Inside `Config.Notifications = { ... }`, after the `showSenderId` line.

**Find this block:**
```lua
    showSenderName = true,      -- Show the sender's name in the notification
    showSubject    = true,      -- Show the telegram subject / title
    showSenderId   = true,      -- Show the sender's telegram ID (e.g. #VAL-4553)
}
```

**Replace with:**
```lua
    showSenderName = true,      -- Show the sender's name in the notification
    showSubject    = true,      -- Show the telegram subject / title
    showSenderId   = true,      -- Show the sender's telegram ID (e.g. #VAL-4553)
    pigeonEnabled  = false,     -- Enable telegram received notifications (left-side toast + pigeon fly-in animation)
}
```

> **Note:** `pigeonEnabled = false` by default — no behaviour change until you set it to `true`.
> When enabled, receiving a telegram shows the left-side toast notification and spawns a pigeon fly-in animation.

---

### `Config.Companies` entries — optional field

Each entry in `Config.Companies` now supports an optional `showInDirectory` field.
By default (if the field is absent) the company **will** appear in the Directory tab.
To hide a company from the directory, add `showInDirectory = false`:

```lua
    {
        companyId = "WESO",
        jobName   = "WESO",
        label     = "WESO",
        permittedGrades = { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10 },
        canSendToAll = true,
        showInDirectory = false,   -- add this line to hide from the Directory tab
    },
```

> If you do nothing here, all your existing companies will show up in the directory.

---

## WHAT WAS ADDED / CHANGED

| Feature | Description |
|---|---|
| **Edit member nickname — Companies** | Company owners get a pencil button next to each member to edit or clear their nickname inline. |
| **Edit member nickname — Businesses** | Same feature now available for player-created business members. |
| **Send telegram from Company** | The "Send As" dropdown in Compose now shows an "Organizations" group so players can send telegrams as their company (job-grade gated). |
| **Organizations in Directory** | The Directory tab shows a separate "Organizations" section listing companies with `showInDirectory ~= false`. |
| **Post Office reading animation** | Opening the telegram app plays the reading/letter animation on the player character. |
| **Pigeon notification toggle** | New `pigeonEnabled` config key. When `true`, receiving a telegram shows the left-side toast notification and spawns a pigeon fly-in animation. |

---

## NO DATABASE CHANGES REQUIRED
