# Gold Panning Script

## Features
- **Interactive Cradle System** - Place, use, and pick up gold wash cradles
- **Stage-Based Workflow** - Pour sediment → Pour water → Pan for gold
- **Realistic Minigame** - Interactive gold collection minigame with skill-based rewards
- **Environmental Effects** - Weather, time of day, and location affect gold yields
- **Gold Rush Locations** - Randomized high-yield spots that change each server restart
- **Resource Depletion** - Areas become depleted with use and recover over time
- **Gold Pan Degradation** - Tools wear down with use
- **Flexible Interaction** - Works with ox_target OR native RedM prompts (no dependencies!)
- **Built-in Progress Bar** - Standalone UI, no external dependencies required
- **Dual Framework Support** - Works with both VORP and RSG frameworks!

---

## 🎮 Framework Compatibility

This script supports **both** major RedM frameworks:

| Framework | Core | Inventory | Status |
|-----------|------|-----------|--------|
| **VORP** | vorp_core | vorp_inventory | ✅ Fully Supported |
| **RSG** | rsg-core | rsg-inventory | ✅ Fully Supported |

The script **automatically detects** which framework you're running - no configuration needed!

---

## Requirements

### For VORP Servers
- **VORP Core**
- **VORP Inventory**

### For RSG Servers
- **RSG-Core**
- **RSG-Inventory**

### Optional (Both Frameworks)
- **ox_target** - Enhanced interaction system (falls back to native prompts if not available, make sure you are using the correct ox target version depending on your Framework)

---

## 📦 Installation

### Fresh Install

1. Place the `goldpanning` folder in your resources directory
2. Add to your server.cfg:
   ```cfg
   # For VORP:
   ensure goldpanning
   # (after vorp_core and vorp_inventory)
   
   # For RSG:
   ensure goldpanning
   # (after rsg-core and rsg-inventory)
   ```
3. Copy `config.example.lua` to `config.lua` and customize
4. **Add items to your inventory** (see Database Setup below)
5. **Copy item images** to your inventory's image folder
6. Restart your server

---

## 🔄 Upgrading from v1.0.0 

If you purchased this script before the dual-framework update, follow these steps to update:

### Step 1: Backup Your Config
```
Copy your existing config.lua somewhere safe!
```

### Step 2: Replace Files
Replace your entire `goldpanning` folder with the new version.

### Step 3: Restore Your Config
Copy your backed-up `config.lua` back into the goldpanning folder.

### Step 4: That's It!
The new version is fully backward compatible with VORP servers. Your existing config and database items will work without any changes.

**Note:** The new version adds a `bridge/` folder with framework detection. This is loaded automatically - no action needed on your part.

---

## 💾 Database Setup

### For VORP Servers
Run the SQL file in your database: `sql/items.sql`

This uses `INSERT IGNORE` so existing items won't be overwritten.

### For RSG Servers
1. Open `sql/rsg_items.lua` in this resource
2. Copy the items between `-- ============ START COPYING HERE ============` and `-- ============ STOP COPYING HERE ============`
3. Paste them into your `rsg-core/shared/items.lua` file (inside the `RSGShared.Items = {` table)
4. Save and restart your server

### Item Images
Copy the images from `goldpanning/html/img/items/` to your inventory's image folder:
- **VORP:** `vorp_inventory/html/img/items/`
- **RSG:** `rsg-inventory/html/images/`

### Items List
| Item | Label | Description |
|------|-------|-------------|
| `goldpan` | Gold Pan | Tool for panning gold |
| `p_goldcradlestand01x` | Gold Wash Cradle | Placeable workstation |
| `bucket` | Empty Bucket | Collect water |
| `fullbucket` | Full Water Bucket | Pour into cradle |
| `mud_bucket` | Mud Bucket | Collect sediment |
| `river_sediment` | River Sediment | Material for panning |
| `gold_flakes` | Gold Flakes | Common reward |
| `gold_nugget` | Gold Nugget | Rare reward |

---

## 🖼️ Item Icons

The script includes inventory icons in `html/img/items/`:
- `goldpan.png`
- `gold_flakes.png`
- `gold_nugget.png`
- `mud_bucket.png`
- `wateringbucket.png`
- `wateringcan_empty.png`
- `p_goldcradlestand01x.png`

### For VORP
Copy these to: `vorp_inventory/html/img/items/`

### For RSG
Copy these to: `rsg-inventory/html/images/`

---

## ⚙️ Configuration

Copy `config.example.lua` to `config.lua` and customize:

### Interaction System
```lua
Config.InteractionSystem = "ox_target" -- or "native" for RedM prompts
```

### Debug Mode
```lua
Config.debug = false -- Set to true for troubleshooting
```

### Item Names
If your server uses different item names, update these in config.lua:
```lua
Config.cradleProp = "p_goldcradlestand01x"
Config.waterItem = "fullbucket"
Config.emptyWaterItem = "bucket"
Config.sedimentItem = "river_sediment"
Config.mudBucketItem = "mud_bucket"
Config.goldPanItem = "goldpan"
Config.goldReward = "gold_flakes"
Config.extraReward = "gold_nugget"
```

---

## 🎯 Usage

1. Obtain a gold pan, mud bucket, and water bucket
2. Go to a river or water source
3. Fill your bucket with water
4. Collect river sediment
5. Place your cradle near water
6. Pour sediment into the cradle
7. Pour water into the cradle
8. Pan for gold!

### Workflow
```
[Collect Water] → [Collect Sediment] → [Place Cradle] → [Pour Sediment] → [Pour Water] → [Pan for Gold]
```

---

## 🎮 Controls

### Native Prompt Controls (when ox_target not available)
- **G** - Pour sediment
- **R** - Pour water  
- **J** - Pan for gold
- **E** - Pick up cradle

---

## 🔧 Troubleshooting

### "No supported framework detected" Error
- Make sure either `vorp_core` or `rsg-core` is started BEFORE goldpanning in your server.cfg

### Items Not Working
- Verify item names in config.lua match your database
- Check that items are marked as useable in your inventory system

### Notifications Not Showing
- For VORP: Uses `VORPcore.NotifyRightTip`
- For RSG: Uses `RSGCore:Notify`
- Make sure these functions are available in your framework version

### Debug Mode
Enable debug mode to see detailed logs:
```lua
Config.debug = true
```

---

## 📁 File Structure

```
goldpanning/
├── bridge/
│   ├── shared.lua    -- Framework detection
│   ├── client.lua    -- Client-side bridge
│   └── server.lua    -- Server-side bridge
├── client/
│   └── client.lua    -- Main client script
├── server/
│   └── server.lua    -- Main server script
├── html/
│   ├── index.html
│   ├── js/script.js
│   ├── css/style.css
│   ├── img/          -- Minigame images
│   └── audio/        -- Sound effects
├── sql/
│   ├── items.sql     -- VORP items
│   └── rsg_items.lua -- RSG items
├── config.lua        -- Your configuration
├── config.example.lua
├── locale.lua
├── fxmanifest.lua
└── README.md
```

---

## ❓ FAQ

### Q: Do I need to change anything to switch between VORP and RSG?
**A:** No! The script automatically detects which framework is running.

### Q: Will my existing VORP setup break with this update?
**A:** No! The update is fully backward compatible. Your existing config and items will work.

### Q: Can I use custom item names?
**A:** Yes! Update the item names in `config.lua` to match your database.

### Q: Does ox_target work with both frameworks?
**A:** Yes! ox_target is optional and works with both VORP and RSG.

---


## 📝 Changelog

### v1.1.0
- Added RSG framework support (rsg-core + rsg-inventory)
- Automatic framework detection
- Bridge system for framework-agnostic code
- Fully backward compatible with existing VORP setups

### v1.0.0
- Initial release
- VORP framework support
- Interactive minigame
- Cradle placement system
- Weather effects
- Gold rush locations
- Resource depletion
