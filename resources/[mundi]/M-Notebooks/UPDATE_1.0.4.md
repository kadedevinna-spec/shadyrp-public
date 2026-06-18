# M-Notebooks — Update Notes v1.0.4

This file lists exactly what was changed so you can apply updates surgically
without replacing files that contain your local settings.

---

## FILES TO REPLACE IN FULL

These files contain no server-specific settings — replace them completely:

```
server/main.lua
client/main.lua
client/pinned.lua
nui/script.js
fxmanifest.lua
```

---

## FILES TO EDIT MANUALLY

### `locale.lua`

Five new locale keys were added for the Torn Page context menu.
These keys did **not** exist in v1.0.3 or earlier.

**Where:** Inside `Locales["en"] = { ... }`, after the `promptGroupLabel` line.

**Find this line:**
```lua
    promptGroupLabel = "Pinned Note",
```

**Add the following block immediately after it:**
```lua
    -- Torn Page Context Menu
    tornPageMenuTitle = "Torn Page",
    tornPageRead = "Read Page",
    tornPageReadDesc = "View what is written on this page",
    tornPagePlaceOnWall = "Place on Wall",
    tornPagePlaceDesc = "Pin this page to a nearby surface",
```

**Result should look like:**
```lua
    promptGroupLabel = "Pinned Note",

    -- Torn Page Context Menu
    tornPageMenuTitle = "Torn Page",
    tornPageRead = "Read Page",
    tornPageReadDesc = "View what is written on this page",
    tornPagePlaceOnWall = "Place on Wall",
    tornPagePlaceDesc = "Pin this page to a nearby surface",
}
```

> **If you have a custom locale** (e.g. `Locales["de"]`), also add the same five keys
> to that block with your translated strings. Leave them blank (`""`) if untranslated:
> ```lua
>     -- Torn Page Context Menu
>     tornPageMenuTitle = "",
>     tornPageRead = "",
>     tornPageReadDesc = "",
>     tornPagePlaceOnWall = "",
>     tornPagePlaceDesc = "",
> ```

---

### `shared/config.lua`

One new block added inside `Config.Animations`, after the `bookRotation` line.

**Find this line:**
```lua
    bookRotation = { x = -100.0, y = 10.0, z = 0.0 },
}
```

**Replace with:**
```lua
    bookRotation = { x = -100.0, y = 10.0, z = 0.0 },

    -- Wall-pin hammer animation (played when the player confirms placing a page on the wall)
    pinAnim = {
        dict     = "mech_inventory@crafting@fallbacks",
        anim     = "full_craft_and_stow",
        duration = 2500,   -- ms to play before the note is pinned
        flag     = 27,     -- flag used by the crafting animation
    },
}
```

---

## WHAT WAS FIXED / CHANGED

| Change | Description |
|---|---|
| **Bug fix: duplicate page rip** | Tearing a page rapidly (double-tap or duplicate resource) could strip the page multiple times. Now blocked by a client-side `isCutting` guard and a 3-second server-side cooldown per player. |
| **Torn Page menu localized** | The "Torn Page" context menu title and options (Read Page, Place on Wall) now use locale strings instead of hardcoded English text. Servers with custom locales need to add the new keys (see above). |
| **Wall-pin animation** | When a player confirms placing a page on the wall, their character walks to the pin location (2-second timeout for unreachable spots) and plays a crafting animation before the note is committed. Animation dict/clip/duration are configurable via `Config.Animations.pinAnim`. |

---

## NO DATABASE CHANGES REQUIRED
