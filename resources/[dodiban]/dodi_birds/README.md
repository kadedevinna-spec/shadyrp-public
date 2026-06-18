# 🦅 Dodi Birds - Advanced Bird Companion System

<div align="center">

![Version](https://img.shields.io/badge/version-1.0.0-blue.svg)
![Framework](https://img.shields.io/badge/framework-VORP-red.svg)
![Platform](https://img.shields.io/badge/platform-RedM-orange.svg)
![License](https://img.shields.io/badge/license-MIT-green.svg)

**A comprehensive bird companion system for RedM servers**

*Train, collect, and bond with your feathered friends in the Wild West*

</div>

---

## ✨ Features

### 🐦 Bird Collection System
- **Multiple Bird Categories**: Scavenger, Fishing, Hunting, and Companion birds
- **Unique Species**: Vulture, Crow, Pelican, Heron, Eagle, Hawk, and Parrot
- **Outfit Variants**: Each bird comes with multiple visual variants to choose from
- **Leveling System**: Birds gain XP and level up through training
- **Unlimited Bird Types**: Add as many bird categories and species as you want through simple config


### 🎮 Interactive Gameplay
- **Carry System**: Birds land gracefully on your hand with smooth animations
- **Training Missions**: Send your bird to explore and gather resources
- **Follow Mode**: Your bird follows you on your adventures
- **Store Command**: Safely dismiss your bird when needed

### 🏪 Economy & Trading
- **Bird Shop**: Purchase new birds with in-game currency
- **Level Requirements**: Unlock rarer birds as you progress
- **Sell Back System**: Sell birds back for a percentage of their value
- **Player Trading**: Offer and trade birds with other players

### 🗺️ Training Zones
- **Special Locations**: Certain areas provide bonus XP and item rewards
- **Category Bonuses**: Different zones benefit different bird types
- **Item Drops**: Birds can find valuable items during training

### 🎨 Beautiful UI
- **Modern Interface**: Clean, western-themed menu design
- **Locked Bird Display**: See all available birds, even those you haven't unlocked yet
- **Real-time Updates**: XP, level, and inventory sync automatically
- **Notification System**: Elegant notifications for all actions

### 🦜 Special: Talking Parrot
- **Voice Lines**: Parrots speak with actual sound effects
- **Situational Dialogue**: Different phrases for greetings, happiness, training, etc.
- **Random Chatter**: Parrots occasionally speak when near the player

---

## 📋 Requirements

- [VORP Core](https://github.com/VORPCORE/vorp-core-lua)
- [VORP Inventory](https://github.com/VORPCORE/vorp_inventory-lua)
- [oxmysql](https://github.com/overextended/oxmysql)

---

## 🚀 Installation

### 1. Download & Extract
```
Extract the `dodi_birds` folder into your resources directory:
resources/[VORP]/dodi_birds/
```

### 2. Database Setup
The script **automatically creates** the required database table on first start. No manual SQL needed!

### 3. Add Usable Item
Add the bird cage item to your database:

VORP:
```sql
INSERT INTO items (item, label, `limit`, can_remove, type, usable) 
VALUES ('bird_cage', 'Bird Cage', 1, 1, 'item_standard', 1, 1, '{}', 'nice item', 0, 5.00);
```
RSG:
["bird_cage"]                        = { name = 'bird_cage',                         label = 'Bird Cage',                   weight = 100, type = 'item', image = 'bird_cage.png',             unique = true,  useable = true, shouldClose = true, description = 'Bird Cage' },


### 4. Server Configuration
Add to your `server.cfg`:
```cfg
ensure dodi_birds
```

### 5. Give Item to Players
Players need the `bird_cage` item and use to open the bird menu.

---

## 🎮 Controls

| Action | Key | Description |
|--------|-----|-------------|
| **Open Menu** | Use Item | Opens the bird management menu |
| **Carry** | E | Bird lands on your hand |
| **Train** | Left Alt | Send bird on a training mission |
| **Follow** | X | Bird follows you around |
| **Store** | G | Dismiss your bird |
| **Close Menu** | ESC | Close any open menu |

---

## ⚙️ Configuration

### Bird Types & Prices
Edit `config.lua` to customize birds:

```lua
Config.Birds = {
    Scavenger = {
        { 
            name = "Vulture", 
            price = 50, 
            image = "images/animal_vulture_western.png", 
            requiredLevel = 0, 
            model = "a_c_vulture_01",
            outfits = {
                { name = "Default", value = 0 },
                { name = "Variant 1", value = 2 },
            }
        },
        -- Add more birds...
    },
}
```

### Training Zones
Configure special training areas:

```lua
Config.TrainingZones = {
    {
        name = "Mountain Peak",
        coords = vector3(-787.20, 1183.46, 151.98),
        radius = 200.0,
        bonuses = {
            Scavenger = {
                xpBonus = 15,
                itemRewards = {
                    {name = "feather", label = "Feather", chance = 50},
                },
            },
        },
    },
}
```

### Economy Settings
```lua
Config.SellBackPercentage = 60 -- Players get 60% when selling back
```

---

## 📁 File Structure

```
dodi_birds/
├── client.lua          # Client-side logic & NUI handling
├── server.lua          # Server-side events & database
├── events.lua          # Bird spawning, training & interactions
├── config.lua          # All configuration options
├── functions.lua       # Utility functions
├── notify.lua          # Notification system
├── fxmanifest.lua      # Resource manifest
├── html/
│   ├── html.html       # NUI structure
│   ├── menu.css        # Styling
│   ├── menu.js         # Frontend logic
│   ├── images/         # Bird & UI images
│   └── sounds/         # Parrot voice lines
└── README.md           # This file
```

---

## 🔧 Exports

### Client Exports
```lua
-- Show objective notification
exports.dodi_birds:ShowObjective(message, duration)
```

### Server Events
```lua
-- Give XP to a bird
TriggerServerEvent('dodi_birds:gainXP', birdId, xpAmount)

-- Give item to player
TriggerServerEvent('dodi_birds:giveItem', itemName, quantity)
```

---

## 🎨 Customization

### Adding New Birds
1. Add bird configuration to `Config.Birds` in `config.lua`
2. Add the bird image to `html/images/`
3. Use valid RedM animal model names

### Adding Training Zones
1. Find coordinates in-game
2. Add zone to `Config.TrainingZones`
3. Configure bonuses for each bird category

### Custom Notifications
- `NotifyLeft` - Left-side notification with icon
- `Tip` - Simple tip message
- `ShowObjective` - Center screen objective

---

## 🦜 Talking Parrot System

### How to Enable Speaking
To make a bird talk, add `canSpeak = true` to its configuration in `config.lua`:

```lua
Companion = {
    { 
        name = "Parrot", 
        price = 120, 
        image = "images/animal_parrot_scarlet.png", 
        requiredLevel = 3, 
        model = "a_c_parrot_01",
        canSpeak = true,  -- ← This enables the talking feature!
        outfits = {
            { name = "Green", value = 0 },
            { name = "Blue", value = 1 },
            { name = "Red", value = 2 },
        }
    }
}
```

### When Does the Parrot Speak?

| Situation | When it Triggers |
|-----------|------------------|
| `greeting` | When the bird is first spawned/called |
| `happy` | When picked up (Carry) or after successful training |
| `training` | When returning from a training mission |
| `angry` | Random chance when near player |
| `random` | Random chatter every 30 seconds (30% chance) |

### Sound Files Structure
Sound files are located in `html/sounds/`. The naming convention is:
```
parrot_{situation}{number}.mp3
```

**Current files:**
```
html/sounds/
├── parrot_greeting1.mp3    # "Hello!" type sounds
├── parrot_happy1.mp3       # Happy chirps
├── parrot_angry1.mp3       # Angry squawks  
├── parrot_training1.mp3    # Training sounds
└── parrot_random1.mp3      # Random chatter
```

### Adding More Sound Variations
To add more sound variations, edit `html/menu.js` in the `playBirdSound` function:

```javascript
const soundFiles = {
    greeting: [
        "sounds/parrot_greeting1.mp3",
        "sounds/parrot_greeting2.mp3",  // Add more files
        "sounds/parrot_greeting3.mp3"
    ],
    happy: [
        "sounds/parrot_happy1.mp3",
        "sounds/parrot_happy2.mp3"
    ],
    // ... etc
};
```

The system will randomly select one sound from the array each time.

### Making Other Birds Talk
You can make ANY bird talk by adding `canSpeak = true`:

```lua
{ 
    name = "Crow", 
    price = 30, 
    model = "a_c_crow_01",
    canSpeak = true,  -- Crow will now use the parrot sounds!
    -- ...
}
```

> **Tip:** Create custom sound files for different birds (crow_greeting1.mp3) and modify the `playBirdSound` function to check bird type.

---

## 📊 Database Schema

```sql
CREATE TABLE `birds` (
    `id` INT(11) NOT NULL AUTO_INCREMENT,
    `charid` INT(11) NOT NULL,
    `identifier` VARCHAR(50) NOT NULL,
    `name` VARCHAR(100) NOT NULL,
    `type` VARCHAR(50) NOT NULL,
    `level` INT(11) NOT NULL DEFAULT 1,
    `xp` VARCHAR(20) NOT NULL DEFAULT '0 / 100',
    `price` INT(11) NOT NULL DEFAULT 0,
    `image` VARCHAR(255) DEFAULT NULL,
    `nickname` VARCHAR(100) DEFAULT '(no name)',
    `outfit` INT(11) NOT NULL DEFAULT 0,
    PRIMARY KEY (`id`),
    INDEX `idx_birds_identifier` (`identifier`),
    INDEX `idx_birds_charid` (`charid`)
);
```

---

## 🐛 Troubleshooting

### Bird won't spawn
- Check console for model loading errors
- Verify the model name exists in RedM

### Menu won't open
- Ensure player has the `bird_cage` item
- Check for NUI focus conflicts

### Database errors
- Verify oxmysql is running
- Check database connection in server.cfg

### Bird not landing correctly
- This uses precise bone attachment
- Ensure no conflicting animation scripts

---

## 📝 Changelog

### v1.0.0
- Initial release
- 7 bird species with variants
- Training system with zones
- Player-to-player trading
- Talking parrot feature
- Modern UI with locked bird display

---

## 🤝 Credits

- **Development**: Dodiban Scripts
- **Framework**: VORP core & RSG Core
- **Platform**: RedM / CFX.re

---

## 📄 License

This project is licensed under the Dodiban Scripts License. Do not create unauthorized copies.

---



**Made with ❤️ for the RedM Community**

*If you enjoy this resource, consider giving it a ⭐*



