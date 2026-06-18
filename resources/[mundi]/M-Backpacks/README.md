# M-Backpacks

**Portable inventory containers for RedM** — A fully-featured backpack system that allows players to carry additional storage. Items persist inside backpacks even when traded between players!

![Version](https://img.shields.io/badge/Version-1.0.0-blue)
![Framework](https://img.shields.io/badge/Framework-VORP%20%7C%20RSG-green)
![Escrow](https://img.shields.io/badge/Tebex-Escrowed-orange)

---

## 🎒 Features

### Core Functionality
- **Portable Inventory Containers** — Each backpack acts as its own inventory that players can open and store items in
- **Persistent Item Storage** — Items stay inside the backpack, even when:
  - The player logs off and back on
  - The backpack is traded to another player or dropped
  - The server restarts
- **3 Customizable Tiers** — Small, Medium, and Large backpacks with configurable capacities
- **Dual Framework Support** — Works with both VORP and RSG frameworks (auto-detected)

### Advanced Features
- **Weapon Storage** — Players can store weapons inside backpacks (configurable per tier)
- **Item Whitelist/Blacklist** — Control exactly what items can or cannot be stored
- **Job-Based Carry Limits** — Special jobs can carry more backpacks than regular players
- **Anti-Exploit Protection** — Built-in safeguards against duplication and abuse
- **Tradeable Backpacks** — Players can give/sell their backpacks to others with contents intact

### Technical Features
- **Zero Configuration Required** — Framework auto-detection means no manual setup
- **Optimized Performance** — Minimal server impact with efficient code
- **Database Persistence** — All backpack contents saved to your database
- **Debug Mode** — Easily troubleshoot issues with detailed console logs

---

## 📋 Requirements

| Dependency | Required |
|------------|----------|
| `oxmysql` | ✅ Yes |
| `vorp_core` + `vorp_inventory` | ✅ For VORP Framework |
| `rsg-core` + `rsg-inventory` | ✅ For RSG Framework |

---

## 🚀 Installation

### Step 1: Add the Resource
Extract and place the `M-Backpacks` folder into your server's `resources` directory.

### Step 2: Add Items to Your Framework

#### For VORP Framework:
1. Run the SQL file located at `sql/vorp_items.sql` on your database
2. Add the backpack images to: `vorp_inventory/html/images/`

#### For RSG Framework:
1. Open `rsg-core/shared/items.lua`
2. Copy the item definitions from `sql/rsg_items.lua` into your `RSGShared.Items` table
3. Add the backpack images to: `rsg-inventory/html/images/`

### Step 3: Update Your Server Config
Add to your `server.cfg`:

```cfg
ensure oxmysql
ensure vorp_core          # OR rsg-core
ensure vorp_inventory     # OR rsg-inventory
ensure M-Backpacks
```

### Step 4: Add Backpack Images
You need to provide(or use the provided) 3 inventory images from Icons folder:
- `backpack_tier1.png`
- `backpack_tier2.png`
- `backpack_tier3.png`

Place these in your inventory resource's images folder.

### Step 5: Restart Your Server
The script will automatically detect which framework you're using!

---

## 🎮 How It Works

1. **Obtaining a Backpack** — Players receive backpacks through admin commands, crafting, or however you choose to distribute them
2. **Using a Backpack** — Player uses the backpack item from their inventory
3. **Backpack Opens** — A secondary inventory window opens showing the backpack's contents
4. **Store/Retrieve Items** — Player can drag items between their inventory and the backpack
5. **Close Backpack** — Items remain saved inside the backpack
6. **Trade Backpack** — If the player gives the backpack to someone else, all contents transfer with it!

---


## ⚙️ Configuration Reference

All configuration is done in the `config.lua` file. Below is a detailed explanation of every option:

---

### 🔧 General Settings

#### `Config.Debug`
```lua
Config.Debug = false
```
| Value | Description |
|-------|-------------|
| `false` | **(Default)** Normal operation, minimal console output |
| `true` | Enable detailed debug messages in server/client console for troubleshooting |

**When to enable:** Only enable when troubleshooting issues. Debug mode prints detailed information about backpack operations, item transfers, and database queries.

---

### 🎒 Backpack Tiers Configuration

#### `Config.Backpacks`
This is the main configuration table where you define each backpack tier. You can have as many tiers as you want!

```lua
Config.Backpacks = {
    ['backpack_tier1'] = {
        -- settings here
    },
    ['backpack_tier2'] = {
        -- settings here
    },
    -- Add more tiers as needed!
}
```

**Each backpack tier has the following options:**

---

#### `label`
```lua
label = 'Small Backpack'
```
The display name shown to players in their inventory and when interacting with the backpack.

---

#### `slots`
```lua
slots = 25
```
The number of inventory slots available inside this backpack tier.

| Tier | Recommended Slots |
|------|-------------------|
| Small | 15-25 |
| Medium | 30-50 |
| Large | 75-150 |

**Note:** Higher slot counts give players more storage but may affect game balance.

---

#### `weight`
```lua
weight = 100
```
The maximum weight capacity of the backpack in kilograms (kg). This is **independent** of the player's personal inventory weight limit.

**How it works:**
- Items inside the backpack count against the backpack's weight, not the player's
- A player can carry heavy items in their backpack that would normally encumber them
- When the backpack is in the player's inventory, it only counts as 1 item

---

#### `tier`
```lua
tier = 1
```
A numeric identifier for this backpack tier. Used internally for organization and future upgrade systems.

| Value | Description |
|-------|-------------|
| `1` | Small/Basic tier |
| `2` | Medium/Standard tier |
| `3` | Large/Premium tier |

---

#### `description`
```lua
description = 'A small worn satchel with limited storage'
```
The item description shown in the inventory tooltip. Use this to give flavor text about the backpack.

---

#### `upgradeable`
```lua
upgradeable = true
```
| Value | Description |
|-------|-------------|
| `true` | This backpack CAN be upgraded to a higher tier |
| `false` | This is the maximum tier and cannot be upgraded |

**⚠️ IMPORTANT:** This is a **marker flag only** — it does NOT provide built-in upgrade functionality. The script itself does not handle upgrades.

---

**🤔 Should I use this?**

| Your Situation | Recommendation |
|----------------|----------------|
| I just want players to use backpacks as-is | **Ignore it** — leave defaults, it won't affect anything |
| I want to create an upgrade system later | **Use it** — mark lower tiers as `true`, highest as `false` |
| I have a crafting/blacksmith script | **Use it** — your script can check this flag |
| I only have 1 backpack tier | **Set to `false`** — there's nothing to upgrade to |

---

**📖 How to Use This (Step-by-Step Example)**

Let's say you want to create an upgrade system where players can pay a blacksmith to upgrade their backpack. Here's exactly how you would use the `upgradeable` flag:

**Step 1: Set up your config correctly**

In `config.lua`, mark which backpacks can be upgraded:
```lua
Config.Backpacks = {
    ['backpack_tier1'] = {
        label = 'Small Backpack',
        slots = 25,
        tier = 1,
        upgradeable = true,    -- ✅ CAN be upgraded (to tier 2)
        -- ... other settings
    },
    ['backpack_tier2'] = {
        label = 'Medium Backpack',
        slots = 50,
        tier = 2,
        upgradeable = true,    -- ✅ CAN be upgraded (to tier 3)
        -- ... other settings
    },
    ['backpack_tier3'] = {
        label = 'Large Backpack',
        slots = 100,
        tier = 3,
        upgradeable = false,   -- ❌ CANNOT be upgraded (max tier)
        -- ... other settings
    }
}
```

**Step 2: Access the config from your external script**

In your own blacksmith/crafting script, you can read the M-Backpacks config:
```lua
-- Method 1: Direct access (if your script loads after M-Backpacks)
local backpackData = Config.Backpacks['backpack_tier1']

-- Method 2: Using exports (recommended)
local backpackData = exports['M-Backpacks']:GetBackpackConfig('backpack_tier1')
```

**Step 3: Check if the backpack can be upgraded**

```lua
-- Get the backpack the player wants to upgrade
local playerBackpack = 'backpack_tier1'  -- The item name they're holding

-- Check the config
local backpackData = Config.Backpacks[playerBackpack]

if backpackData == nil then
    -- This item isn't a backpack
    print("That's not a backpack!")
    return
end

if backpackData.upgradeable == false then
    -- This backpack is already max tier
    print("This backpack cannot be upgraded further!")
    return
end

-- If we get here, the backpack CAN be upgraded
print("This backpack can be upgraded!")
```

**Step 4: Determine the next tier**

```lua
local currentTier = backpackData.tier  -- e.g., 1

-- Find the next tier backpack
local nextTierName = 'backpack_tier' .. (currentTier + 1)  -- e.g., 'backpack_tier2'

-- Make sure the next tier exists
if Config.Backpacks[nextTierName] == nil then
    print("No higher tier exists!")
    return
end

print("Upgrading from " .. playerBackpack .. " to " .. nextTierName)
```

**Step 5: Complete example (Blacksmith Upgrade Script)**

Here's a complete example you could use as a starting point:
```lua
-- blacksmith_upgrade.lua (YOUR separate script, NOT part of M-Backpacks)

local upgradeCost = 50.00  -- Cost in dollars
local requiredItem = 'leather'  -- Material needed
local requiredAmount = 5

function AttemptUpgrade(source, backpackItemName)
    -- Step 1: Get the backpack config
    local backpackData = Config.Backpacks[backpackItemName]
    
    if not backpackData then
        TriggerClientEvent('ox_lib:notify', source, {
            title = 'Blacksmith',
            description = 'That item cannot be upgraded.',
            type = 'error'
        })
        return false
    end
    
    -- Step 2: Check if upgradeable
    if backpackData.upgradeable == false then
        TriggerClientEvent('ox_lib:notify', source, {
            title = 'Blacksmith',
            description = 'This backpack is already the highest quality!',
            type = 'error'
        })
        return false
    end
    
    -- Step 3: Find next tier
    local currentTier = backpackData.tier
    local nextTierName = 'backpack_tier' .. (currentTier + 1)
    
    if not Config.Backpacks[nextTierName] then
        TriggerClientEvent('ox_lib:notify', source, {
            title = 'Blacksmith',
            description = 'No upgrade available for this backpack.',
            type = 'error'
        })
        return false
    end
    
    -- Step 4: Check if player has money and materials
    -- (Use your framework's money/inventory functions here)
    
    -- Step 5: Remove old backpack, give new one
    -- IMPORTANT: You'll need to handle transferring the contents!
    -- This is where you'd use M-Backpacks' functions to:
    --   1. Get the contents of the old backpack
    --   2. Remove the old backpack from player
    --   3. Give the new tier backpack to player
    --   4. Put the old contents into the new backpack
    
    TriggerClientEvent('ox_lib:notify', source, {
        title = 'Blacksmith',
        description = 'Backpack upgraded to ' .. Config.Backpacks[nextTierName].label .. '!',
        type = 'success'
    })
    
    return true
end
```

**If you don't plan to make an upgrade system:** Just leave the defaults and ignore this setting. It won't affect how backpacks work at all — players can still use backpacks normally.

---

#### `acceptWeapons`
```lua
acceptWeapons = true
```
| Value | Description |
|-------|-------------|
| `true` | **(Default)** Players can store weapons inside this backpack |
| `false` | Weapons cannot be placed in this backpack |

**Use case:** Set to `false` if you want to restrict weapon storage for balancing purposes.

---

#### `shared`
```lua
shared = true
```
| Value | Description |
|-------|-------------|
| `true` | **(REQUIRED)** Items persist when backpack is traded between players |
| `false` | ⚠️ DO NOT USE — Items would be lost when traded |

**⚠️ IMPORTANT:** This should **ALWAYS** be `true`. If set to `false`, items will not transfer when the backpack is given to another player.

---

#### `ignoreItemStackLimit`
```lua
ignoreItemStackLimit = true
```
| Value | Description |
|-------|-------------|
| `true` | **(Default)** Items in the backpack can stack beyond normal limits |
| `false` | Items respect their normal stack limits inside the backpack |

**Example:** If an item normally stacks to 10, setting this to `true` allows unlimited stacking inside the backpack.

---

#### `whitelistItems`
```lua
whitelistItems = {}
```
A list of specific items that are **ALLOWED** in this backpack. 

| Value | Description |
|-------|-------------|
| `{}` | **(Default)** Empty = ALL items are allowed |
| `{'water', 'bread', 'meat'}` | ONLY these items can be stored |

**Use case:** Create specialized backpacks like a "Hunting Bag" that only accepts pelts and animal parts:
```lua
whitelistItems = {'pelt_poor', 'pelt_good', 'pelt_perfect', 'animal_fat'}
```

---

#### `blacklistItems`
```lua
blacklistItems = {'backpack_tier1', 'backpack_tier2', 'backpack_tier3'}
```
A list of items that are **BLOCKED** from being stored in this backpack.

**Default behavior:** All backpack items are blacklisted to prevent "backpack inception" (backpacks inside backpacks).

**Add more items as needed:**
```lua
blacklistItems = {
    'backpack_tier1', 
    'backpack_tier2', 
    'backpack_tier3',
    'gold_bar',           -- Prevent gold storage
    'illegal_item'        -- Prevent contraband storage
}
```

---

### 📦 Inventory Restrictions

#### `Config.MaxBackpacksPerPlayer`
```lua
Config.MaxBackpacksPerPlayer = 1
```
The maximum number of backpacks a regular player can carry in their inventory at one time.

| Value | Description |
|-------|-------------|
| `1` | **(Recommended)** Players can only carry 1 backpack |
| `2-5` | Players can carry multiple backpacks |
| `0` | ⚠️ Players cannot carry any backpacks |

**Balance consideration:** Allowing multiple backpacks significantly increases player storage capacity.

---

#### `Config.SpecialJobs`
```lua
Config.SpecialJobs = {
    'merchant',
    'trader',
    'supplier'
}
```
A list of job names that bypass the normal backpack limit. Players with these jobs can carry more backpacks.

**Customize for your server:**
```lua
Config.SpecialJobs = {
    'merchant',      -- Trader NPCs
    'shopkeeper',    -- Store owners
    'smuggler',      -- Criminal role
    'miner',         -- Resource gatherers
    'hunter'         -- Hunters who need extra storage
}
```

**Note:** Job names must match exactly what your framework uses (case-sensitive).

---

#### `Config.MaxBackpacksSpecialJob`
```lua
Config.MaxBackpacksSpecialJob = 3
```
The maximum number of backpacks that special job players can carry.

| Value | Description |
|-------|-------------|
| `3` | **(Default)** Special jobs can carry 3 backpacks |
| `5-10` | For heavy storage roles |
| Equal to `MaxBackpacksPerPlayer` | No special job bonus |

---

### 📢 Discord Webhook Logging

M-Backpacks includes a comprehensive Discord webhook system to track all backpack activity on your server.

#### `Config.Discord.enabled`
```lua
enabled = true
```
| Value | Description |
|-------|-------------|
| `true` | Enable Discord webhook logging |
| `false` | **(Default)** Disable all Discord logging |

---

#### `Config.Discord.webhook`
```lua
webhook = 'https://discord.com/api/webhooks/YOUR_WEBHOOK_URL'
```
Your Discord webhook URL. To create one:
1. Go to your Discord server settings
2. Navigate to **Integrations** → **Webhooks**
3. Click **New Webhook**
4. Copy the webhook URL and paste it here

**Leave empty to disable logging** (even if `enabled = true`).

---

#### `Config.Discord.botName`
```lua
botName = 'M-Backpacks'
```
The name that appears on Discord messages. Customize this to match your server branding.

---

#### `Config.Discord.botAvatar`
```lua
botAvatar = ''
```
URL to an image for the bot's avatar (optional). Leave empty to use Discord's default.

---

#### `Config.Discord.colors`
```lua
colors = {
    backpackOpened = 3066993,      -- Green
    backpackCreated = 3447003,     -- Blue
    backpackTransferred = 15105570, -- Gold
    itemAdded = 5763719,           -- Teal
    itemRemoved = 15158332,        -- Red
    adminAction = 10181046         -- Purple
}
```
Customize the embed colors for different event types. Colors are in **decimal format**.

**Color converter:** Use a hex-to-decimal converter. For example:
- `#2ECC71` (green) = `3066993`
- `#E74C3C` (red) = `15158332`
- `#F1C40F` (gold) = `15844367`

---

#### Event Toggle Options

Control exactly what gets logged to Discord:

| Config Option | Description | Default |
|--------------|-------------|---------|
| `logBackpackOpened` | Log when player opens a backpack | `true` |
| `logBackpackCreated` | Log when a new backpack is initialized (first use) | `true` |
| `logBackpackTransferred` | Log when backpack changes ownership (traded/given) | `true` |
| `logItemsAdded` | Log when items are placed into backpacks | `true` |
| `logItemsRemoved` | Log when items are taken from backpacks | `true` |
| `logAdminCommands` | Log admin commands (givebackpack) | `true` |

**Example:** To only log transfers and admin commands:
```lua
Config.Discord = {
    enabled = true,
    webhook = 'YOUR_WEBHOOK_URL',
    botName = 'M-Backpacks',
    
    logBackpackOpened = false,
    logBackpackCreated = false,
    logBackpackTransferred = true,   -- Only this
    logItemsAdded = false,
    logItemsRemoved = false,
    logAdminCommands = true          -- And this
}
```

---

#### What Gets Logged

**🎒 Backpack Opened:**
- Player name & character ID
- Server ID
- Backpack type and unique ID

**🆕 Backpack Created:**
- When a player uses a backpack for the first time
- New unique backpack ID generated

**🔄 Backpack Transferred:**
- Previous owner (name, char ID, server ID)
- New owner (name, char ID, server ID)
- Backpack type and ID

**📥 Item Added:**
- Player who added the item
- Item name and quantity
- Which backpack it was added to

**📤 Item Removed:**
- Player who removed the item
- Item name and quantity
- Which backpack it was removed from

---

## 📊 Default Backpack Tiers

| Tier | Item Name | Label | Slots | Weight | Description |
|------|-----------|-------|-------|--------|-------------|
| 1 | `backpack_tier1` | Small Backpack | 25 | 100kg | A small worn satchel with limited storage |
| 2 | `backpack_tier2` | Medium Backpack | 50 | 100kg | A sturdy leather backpack with decent storage |
| 3 | `backpack_tier3` | Large Backpack | 100 | 100kg | A spacious rucksack |

---

## 🛡️ Anti-Exploit Features

This script includes several built-in protections:

- **Duplicate Prevention** — Unique IDs prevent item duplication
- **Operation Cooldowns** — Rapid actions are throttled to prevent abuse
- **Metadata Locks** — Backpack data cannot be modified while in use
- **Open Tracking** — Only one player can access a backpack at a time
- **Server-Side Validation** — All critical operations are validated server-side

---

## ❓ Frequently Asked Questions

**Q: Can players put backpacks inside backpacks?**
> No! All backpack items are blacklisted by default to prevent this.

**Q: What happens to items when a player trades their backpack?**
> Items stay inside! The new owner gets the backpack with all its contents.

**Q: Do items save when the server restarts?**
> Yes! All backpack contents are stored in your database.

**Q: Can I add more than 3 tiers?**
> Yes! See the "Adding Custom Backpack Tiers" section below for a complete guide.

**Q: How do I give players backpacks?**
> Use your framework's built-in give commands (VORP/RSG admin menus), or create your own shop/crafting system. The backpack will automatically initialize with a unique ID when first used.

---

## ➕ Adding Custom Backpack Tiers

You can add as many backpack tiers as you want! Follow these 3 steps:

### Step 1: Add to Config

Open `config.lua` and add a new entry to `Config.Backpacks`:

```lua
['backpack_tier4'] = {
    label = 'Legendary Backpack',
    slots = 150,
    weight = 200,
    tier = 4,
    description = 'An enormous pack for the serious traveler',
    upgradeable = false,                -- Set false if this is the max tier
    acceptWeapons = true,
    shared = true,                      -- ALWAYS keep this true!
    ignoreItemStackLimit = true,
    whitelistItems = {},
    blacklistItems = {'backpack_tier1', 'backpack_tier2', 'backpack_tier3', 'backpack_tier4'}  -- Add your new backpack here too!
}
```

### Step 2: Add the Item to Your Framework

#### For VORP:
Run this SQL on your database:
```sql
INSERT IGNORE INTO items_crafted (item, label, `limit`, can_remove, type, usable, desc) 
VALUES ('backpack_tier4', 'Legendary Backpack', 1, 1, 'item_standard', 1, 'An enormous pack for the serious traveler');
```

#### For RSG:
Add this to `rsg-core/shared/items.lua`:
```lua
['backpack_tier4'] = {
    name = 'backpack_tier4',
    label = 'Legendary Backpack',
    weight = 1000,
    type = 'item',
    image = 'backpack_tier4.png',
    unique = true,
    useable = true,
    shouldClose = true,
    description = 'An enormous pack for the serious traveler'
},
```

### Step 3: Add the Image

Create `backpack_tier4.png` and place it in:
- **VORP:** `vorp_inventory/html/images/`
- **RSG:** `rsg-inventory/html/images/`

### Custom Backpack Ideas

Here are some creative backpack types you could add:

**Hunting Satchel** (only accepts hunting items):
```lua
['hunting_satchel'] = {
    label = 'Hunting Satchel',
    slots = 30,
    weight = 50,
    tier = 1,
    description = 'A specialized bag for hunters',
    upgradeable = false,
    acceptWeapons = false,
    shared = true,
    ignoreItemStackLimit = true,
    whitelistItems = {'pelt_poor', 'pelt_good', 'pelt_perfect', 'animal_fat', 'feather', 'meat_venison'},
    blacklistItems = {}
}
```

**Herb Pouch** (for herbalists):
```lua
['herb_pouch'] = {
    label = 'Herb Pouch',
    slots = 50,
    weight = 25,
    tier = 1,
    description = 'A leather pouch for storing herbs and plants',
    upgradeable = false,
    acceptWeapons = false,
    shared = true,
    ignoreItemStackLimit = true,
    whitelistItems = {'oregano', 'thyme', 'ginseng', 'yarrow', 'indian_tobacco'},
    blacklistItems = {}
}
```

**Smuggler's Bag** (hidden contraband storage):
```lua
['smuggler_bag'] = {
    label = 'Worn Saddlebag',
    slots = 15,
    weight = 30,
    tier = 1,
    description = 'An old saddlebag... or is it?',
    upgradeable = false,
    acceptWeapons = true,
    shared = true,
    ignoreItemStackLimit = false,
    whitelistItems = {},
    blacklistItems = {'backpack_tier1', 'backpack_tier2', 'backpack_tier3', 'smuggler_bag'}
}
```

---

## 🔧 Troubleshooting

| Issue | Solution |
|-------|----------|
| Backpack won't open | Enable `Config.Debug = true` and check console for errors |
| Items disappear | Ensure `shared = true` is set for all backpacks |
| "Item not found" errors | Make sure you ran the SQL file or added items to RSG |
| Framework not detected | Ensure vorp_core/rsg-core starts BEFORE M-Backpacks |
| Images not showing | Check image names match exactly: `backpack_tier1.png`, etc. |

---

## 📞 Support

For support, please contact through:
- Tebex store messages
- Discord (if provided with purchase)

**Before contacting support:**
1. Enable `Config.Debug = true`
2. Reproduce the issue
3. Copy the console output
4. Describe steps to reproduce

---

## 📜 License

This resource is protected by Tebex Asset Escrow. Redistribution, resale, or sharing of this resource is prohibited.

---

## 👤 Credits

**Author:** Mundi

---

*Thank you for your purchase! Enjoy the script!* 🎒
