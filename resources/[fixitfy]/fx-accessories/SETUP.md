# fx-accessories — Installation Guide

## Requirements

- RedM (cerulean) — ✅ required — standard RedM server
- `/assetpacks` — ✅ required — built into RedM, no extra setup needed
- VORP **or** RSG — ❌ optional — runs without a framework if neither is present
- `fx-hud` — ❌ optional — only used to hide the HUD when the shop opens

> **What is `/assetpacks`?**  
> It is RedM's built-in model loading system. You do not need to install it separately.  
> Your `server.cfg` must have this line **before** `ensure fx-accessories`:
> ```
> ensure /assetpacks
> ```
> It is most likely already there. Add it if it isn't.

---

## Step 1 — Installation

Drop the `fx-accessories` folder into your server's resources directory:

```
resources/
└── [FIXITFY]/
    └── fx-accessories/
```

Add to `server.cfg` **below** your framework:

**For VORP:**
```
ensure vorp_core
ensure vorp_inventory
ensure fx-accessories
```

**For RSG:**
```
ensure rsg-core
ensure fx-accessories
```

**Without a framework:**
```
ensure /assetpacks
ensure fx-accessories
```

---

## Step 2 — Language

Open `config.lua` and set the first line:

```lua
Config.Locale = "en"  -- "en" (English) | "tr" (Turkish) | "de" (German)
```

---

## Step 3 — Item Registration

Every item key in `config_items.lua` must be registered in your framework's database.

**Easy way:** The Accadmin panel (calibration tool) generates a ready-to-paste block in both **VORP SQL** and **RSG Lua** format. No manual editing needed.

**Manual registration:**
- VORP → run the INSERT statements from `fx_accessories.sql`
- RSG → use the RSG section inside `fx_accessories.sql`

---

## Step 4 — Commands

- `/accmenu` — Open the accessory menu
- `/objects` — Open the prop browser
- `/giveadminpanel [serverid]` — Give the calibration panel to the target player
- `/acceditpos` — Drag to reposition the notification and progress bar

The default menu open key is **F4**. Change it in `config.lua`:

```lua
Config.OpenMenuKey = {
    useKey = true,
    key    = 115,  -- F4 | Full list: https://cherrytree.at/misc/vk.htm
}
```

---

## Step 5 — Optional: Item Images

Place item icons in:

```
ui/assets/inventoryitemimages/{itemKey}.png
```

The filename must **exactly** match the item key. If no image is found, `dropicon.png` is used as a fallback.

---

## Step 6 — Optional: fx-hud Integration

If `fx-hud` is running, the HUD is automatically hidden when the shop opens and restored when it closes. No extra configuration needed — it is detected at runtime.

---

## Verification

Restart the server. You should see this in the console:

```
[Accessories] Framework: VORP
```

`RSG` or `NONE` are also valid. `NONE` means the resource is running without a framework.

**Troubleshooting:**
- Seeing `[Accessories] Framework: NONE` but a framework is installed — check the order in `server.cfg`: the framework must be `ensure`d before fx-accessories
- Props not visible — verify that `/assetpacks` is present in `server.cfg`
- Commands not working — check `Config.OpenMenuCommands` in `config.lua`
