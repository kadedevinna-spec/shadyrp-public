# 🏦 COMPLETE BANK ROBBERY SYSTEM - VORP RedM

## 📋 Overview

Robust and complete bank robbery system for RedM/VORP/RSG, developed with multiple assault strategies, intelligent hostage system, toxic gas timer, and specialized tools. The system offers 4 distinct execution plans (A, B, C, D) each with their own mechanics and risks.

---

## 🎯 MAIN FEATURES

### 🏛️ **Supported Banks**
- **Valentine Bank** - Main bank with multiple vaults
- **Saint Denis Bank** - IMAP system and explodable walls  
- **Rhodes Bank** - Custom interior with rayfire


### 👥 **Intelligent Hostage System**
- Dynamic configuration of hostage quantity per bank
- Realistic worker NPCs (bankers, customers, guards)
- Proximity capture system and weapon threat
- Behavioral control: surrender, escape, death
- Direct impact on main timer when hostages escape/die

### ⏱️ **Timer System with Toxic Gas**
- **Main Timer**: 5-10 minutes configurable per bank
- **Toxic Gas**: Activates automatically when timer expires
- **Penalties**: Death/escape of hostages reduces remaining time
- **Visual Warnings**: Dynamic colors (white → yellow → red)

### 🔧 **Specialized Tools**
- **Torch**: Cuts metal doors and locks
- **Dynamite**: Explodes reinforced doors and walls
- **Gas Mask**: Protection against toxic gas
- **Bomb Minigame**: Explosion time configuration

### 🏦 **Vault and Combination System**
- **19 Different Notes**: Each with unique combination
- **Dial Minigame**: Realistic 3D interface with sound
- **Multiple Vaults**: Several vaults per bank
- **Clue System**: Notes scattered around the bank with each vault's code

---

## 🎮 THE 4 ASSAULT PLANS

### 📋 **PLAN A - STEALTH & CONTROL** *(Recommended)*
**Objective**: Total control without violence
- ✅ **Surrender all hostages** without killing anyone
- ✅ **Maintain control** throughout the entire heist  
- ✅ **Banker cooperates** and opens doors automatically
- ✅ **Full access** to all areas without tools (only vault access needs tools)
- ✅ **Maximum time** available on timer or gas is triggered if not sabotaged


**Plan A Timeline:**
1. **Silent Entry** - Approach without alerting guards
2. **Hostage Capture** - Surrender everyone 
3. **Maintained Control** - Prevent escapes and maintain order
4. **Banker Cooperation** - Automatic door opening
5. **Note Collection** - Find papers with combinations
6. **Vault Opening** - Use found combinations
7. **Coordinated Escape** - Exit before timer expires

---

### ⚡ **PLAN B - STRATEGIC HYBRID**
**Objective**: Efficiency with tool backup
- ⚠️ **Surrender main hostages** (banker mandatory)
- ⚠️ **Use tools** on secondary doors if necessary
- ⚠️ **Combine stealth + force** as situation demands
- ⚠️ **Disable generators** as backup plan
- ⚠️ **Mask recommended** as precaution

**Plan B Timeline:**
1. **Tactical Entry** - Assess situation and hostages
2. **Selective Capture** - Focus on banker and key customers
3. **Manual Opening** - Main doors by banker
4. **Backup Tools** - Torch/dynamite on secondary doors
5. **Preventive Sabotage** - Disable roof generators
6. **Mixed Collection** - Combinations + brute force
7. **Contingency Escape** - Alternative routes prepared

---

### 💀 **PLAN C - TOTAL FORCE** *(High Risk)*
**Objective**: Maximum speed, no mercy
- ❌ **Eliminate witnesses** - Spare no one
- ⚠️ **Mandatory tools** - Torch, dynamite, mask
- ⚠️ **Reduced timer** - Deaths accelerate toxic gas
- ⚠️ **Brute force** - Explode all doors
- ⚠️ **Essential mask** - Gas will be released quickly

**Plan C Timeline:**
1. **Hostile Entry** - Eliminate guards immediately
2. **Total Cleanup** - Leave no witnesses alive
3. **Multiple Explosions** - Dynamite on all doors
4. **Security Cutting** - Torch on reinforced locks
5. **Gas Protection** - Mandatory mask
6. **Mixed Collection** - Combinations + brute force
7. **Quick Escape** - Exit before gas spreads

---

### 🧨 **PLAN D - STRATEGIC DEMOLITION** *(Extreme)*
**Objective**: Control + planned destruction
- ✅ **Surrender and protect hostages** in safe locations
- 🧨 **Explode walls** for alternative escape routes
- 🧨 **Controlled demolition** - Saint Denis and Rhodes
- ⚠️ **Complete tools** - Full arsenal needed
- ⚠️ **Precise coordination** - Explosion timing

**Plan D Timeline:**
1. **Entry and Control** - Surrender all hostages
2. **Safe Evacuation** - Move hostages to protected area
3. **Explosive Preparation** - Position dynamite on walls
4. **Wall Demolition** - Create alternative exits
5. **Hostage Protection** - Keep them away from explosions
6. **Total Access** - Use holes in walls
7. **Breach Escape** - Exit through exploded walls

---

## 🛠️ SYSTEM COMPONENTS

### 📦 **1. Bank Lobby** (`bank_lobby`)
Group formation system for heists
- **Web Interface**: Responsive HTML/CSS/JS
- **Profile System**: 14 unique avatars available
- **Notifications**: Complete alert system
- **Management**: Create, join, leave lobbies

### 🎯 **2. Bank Selector** (`bank_selector`) 
Target bank selection interface
- **Visual Selection**: Interface with bank images
- **Detailed Information**: Difficulty, rewards
- **Configuration**: Pre-heist preparation

### 🏦 **3. Bank Robbery** (`dodi_bankrobbery`)
Main heist system with all subsystems:

#### **Hostages System** (`client_hostages.lua`)
```lua
-- Dynamic configuration per bank
Config.HostageSystems = {
    valentine = {
        maxHostages = 6,
        spawnChance = 0.8,
        models = {"cs_hobartcrawley", "cs_bankclerk", "a_m_m_unibutchers_01"}
    }
}
```

#### **Timer System** (`client_timertorobbery.lua`)
```lua
-- Main timer with toxic gas
Config.RobberyTimer = {
    defaultDuration = 300000, -- 5 minutes
    warningTime = 120000,     -- Yellow alert
    criticalTime = 60000      -- Red alert
}
```

#### **Generator System** (`client_generator.lua`)
```lua
-- Generator sabotage system
Config.Generators = {
    valentine = {
        coords = vector3(-308.2, 776.8, 120.4),
        sabotage = {
            requireActiveRobbery = true,
            oncePerRobbery = true
        }
    }
}
```

#### **Vault System** (`client_vaults.lua`)
```lua
-- Vault system with minigame
Config.BankVaults = {
    valentine = {
        vaults = {
            {id = 1, coords = vector3(-307.9, 775.2, 118.7)},
            {id = 2, coords = vector3(-309.1, 773.8, 118.7)}
        }
    }
}
```

### 🕒 **4. Clock Bomb Minigame** (`dodi_clockbomb_minigame`)
Clock bomb configuration minigame
- **3D Interface**: Interactive clock
- **Realistic Sounds**: Tick, time setting
- **Callback System**: Dynamite integration

---

## 📋 INSTALLATION AND CONFIGURATION

### **Prerequisites**
- VORP Core Framework
- RSG Core Framework
- MySQL Database
- RedM Server

### **1. Resource Installation**

# Copy to resources/[VORP]/ folder
bank_lobby/
bank_selector/
dodi_bankrobbery/
dodi_clockbomb_minigame/


### **2. Database Setup**

-- Execute items_database.sql
-- Adds 19 bank notes + tools
source items_database.sql

### VORP ITEMS
-- Bank Notes (19 different)
INSERT INTO `items` (`item`, `label`, `limit`, `can_remove`, `type`, `usable`, `groupId`, `metadata`, `desc`, `degradation`, `weight`) VALUES
('02_99_41_note', 'Bank Note #02994', 5, 1, 'item_standard', 1, 1, '{}', 'A mysterious bank note with important information about vault combinations', 0, 0.10),
('49_10_32_note', 'Bank Note #49103', 5, 1, 'item_standard', 1, 1, '{}', 'A mysterious bank note with important information about vault combinations', 0, 0.10),
('07_45_92_note', 'Bank Note #07459', 5, 1, 'item_standard', 1, 1, '{}', 'A mysterious bank note with important information about vault combinations', 0, 0.10),
('38_11_64_note', 'Bank Note #38116', 5, 1, 'item_standard', 1, 1, '{}', 'A mysterious bank note with important information about vault combinations', 0, 0.10),
('56_03_87_note', 'Bank Note #56038', 5, 1, 'item_standard', 1, 1, '{}', 'A mysterious bank note with important information about vault combinations', 0, 0.10),
('21_74_09_note', 'Bank Note #21740', 5, 1, 'item_standard', 1, 1, '{}', 'A mysterious bank note with important information about vault combinations', 0, 0.10),
('95_62_48_note', 'Bank Note #95624', 5, 1, 'item_standard', 1, 1, '{}', 'A mysterious bank note with important information about vault combinations', 0, 0.10),
('13_80_27_note', 'Bank Note #13802', 5, 1, 'item_standard', 1, 1, '{}', 'A mysterious bank note with important information about vault combinations', 0, 0.10),
('44_19_53_note', 'Bank Note #44195', 5, 1, 'item_standard', 1, 1, '{}', 'A mysterious bank note with important information about vault combinations', 0, 0.10),
('68_07_36_note', 'Bank Note #68073', 5, 1, 'item_standard', 1, 1, '{}', 'A mysterious bank note with important information about vault combinations', 0, 0.10),
('90_24_15_note', 'Bank Note #90241', 5, 1, 'item_standard', 1, 1, '{}', 'A mysterious bank note with important information about vault combinations', 0, 0.10),
('72_33_08_note', 'Bank Note #72330', 5, 1, 'item_standard', 1, 1, '{}', 'A mysterious bank note with important information about vault combinations', 0, 0.10),
('59_14_67_note', 'Bank Note #59146', 5, 1, 'item_standard', 1, 1, '{}', 'A mysterious bank note with important information about vault combinations', 0, 0.10),
('81_06_25_note', 'Bank Note #81062', 5, 1, 'item_standard', 1, 1, '{}', 'A mysterious bank note with important information about vault combinations', 0, 0.10),
('34_58_12_note', 'Bank Note #34581', 5, 1, 'item_standard', 1, 1, '{}', 'A mysterious bank note with important information about vault combinations', 0, 0.10),
('17_83_40_note', 'Bank Note #17834', 5, 1, 'item_standard', 1, 1, '{}', 'A mysterious bank note with important information about vault combinations', 0, 0.10),
('26_91_05_note', 'Bank Note #26910', 5, 1, 'item_standard', 1, 1, '{}', 'A mysterious bank note with important information about vault combinations', 0, 0.10),
('63_39_78_note', 'Bank Note #63397', 5, 1, 'item_standard', 1, 1, '{}', 'A mysterious bank note with important information about vault combinations', 0, 0.10),
('85_28_60_note', 'Bank Note #85286', 5, 1, 'item_standard', 1, 1, '{}', 'A mysterious bank note with important information about vault combinations', 0, 0.10);

-- Heist Tools
INSERT INTO `items` (`item`, `label`, `limit`, `can_remove`, `type`, `usable`, `groupId`, `metadata`, `desc`, `degradation`, `weight`) VALUES
('torch_tool', 'Torch Tool', 3, 1, 'item_standard', 1, 1, '{}', 'A specialized torch tool for cutting through metal doors and locks during bank heists', 0, 2.50),
('dynamite_bank', 'Bank Dynamite', 5, 1, 'item_standard', 1, 1, '{}', 'Explosive device for breaking through reinforced doors and walls. Handle with extreme care!', 0, 1.80),
('gas_mask', 'Gas Mask', 1, 1, 'item_standard', 1, 1, '{}', 'Protective mask against toxic gases and smoke. Essential for dangerous environments', 0, 1.20);





### **For RSG Core (items.lua model)**

If you're using RSG Core, add the items manually to your inventory resource's `items.lua` file, following the pattern below:
----------   BANK NOTES

    ["02_99_41_note"] = { name = "02_99_41_note", label = "Bank Note #02994", weight = 10, type = "item", image = "banknote.png", unique = false, useable = true, shouldClose = true, description = "A mysterious bank note with important information about vault combinations" },
    ["49_10_32_note"] = { name = "49_10_32_note", label = "Bank Note #49103", weight = 10, type = "item", image = "banknote.png", unique = false, useable = true, shouldClose = true, description = "A mysterious bank note with important information about vault combinations" },
    ["07_45_92_note"] = { name = "07_45_92_note", label = "Bank Note #07459", weight = 10, type = "item", image = "banknote.png", unique = false, useable = true, shouldClose = true, description = "A mysterious bank note with important information about vault combinations" },
    ["38_11_64_note"] = { name = "38_11_64_note", label = "Bank Note #38116", weight = 10, type = "item", image = "banknote.png", unique = false, useable = true, shouldClose = true, description = "A mysterious bank note with important information about vault combinations" },
    ["56_03_87_note"] = { name = "56_03_87_note", label = "Bank Note #56038", weight = 10, type = "item", image = "banknote.png", unique = false, useable = true, shouldClose = true, description = "A mysterious bank note with important information about vault combinations" },
    ["21_74_09_note"] = { name = "21_74_09_note", label = "Bank Note #21740", weight = 10, type = "item", image = "banknote.png", unique = false, useable = true, shouldClose = true, description = "A mysterious bank note with important information about vault combinations" },
    ["95_62_48_note"] = { name = "95_62_48_note", label = "Bank Note #95624", weight = 10, type = "item", image = "banknote.png", unique = false, useable = true, shouldClose = true, description = "A mysterious bank note with important information about vault combinations" },
    ["13_80_27_note"] = { name = "13_80_27_note", label = "Bank Note #13802", weight = 10, type = "item", image = "banknote.png", unique = false, useable = true, shouldClose = true, description = "A mysterious bank note with important information about vault combinations" },
    ["44_19_53_note"] = { name = "44_19_53_note", label = "Bank Note #44195", weight = 10, type = "item", image = "banknote.png", unique = false, useable = true, shouldClose = true, description = "A mysterious bank note with important information about vault combinations" },
    ["68_07_36_note"] = { name = "68_07_36_note", label = "Bank Note #68073", weight = 10, type = "item", image = "banknote.png", unique = false, useable = true, shouldClose = true, description = "A mysterious bank note with important information about vault combinations" },
    ["90_24_15_note"] = { name = "90_24_15_note", label = "Bank Note #90241", weight = 10, type = "item", image = "banknote.png", unique = false, useable = true, shouldClose = true, description = "A mysterious bank note with important information about vault combinations" },
    ["72_33_08_note"] = { name = "72_33_08_note", label = "Bank Note #72330", weight = 10, type = "item", image = "banknote.png", unique = false, useable = true, shouldClose = true, description = "A mysterious bank note with important information about vault combinations" },
    ["59_14_67_note"] = { name = "59_14_67_note", label = "Bank Note #59146", weight = 10, type = "item", image = "banknote.png", unique = false, useable = true, shouldClose = true, description = "A mysterious bank note with important information about vault combinations" },
    ["81_06_25_note"] = { name = "81_06_25_note", label = "Bank Note #81062", weight = 10, type = "item", image = "banknote.png", unique = false, useable = true, shouldClose = true, description = "A mysterious bank note with important information about vault combinations" },
    ["34_58_12_note"] = { name = "34_58_12_note", label = "Bank Note #34581", weight = 10, type = "item", image = "banknote.png", unique = false, useable = true, shouldClose = true, description = "A mysterious bank note with important information about vault combinations" },
    ["17_83_40_note"] = { name = "17_83_40_note", label = "Bank Note #17834", weight = 10, type = "item", image = "banknote.png", unique = false, useable = true, shouldClose = true, description = "A mysterious bank note with important information about vault combinations" },
    ["26_91_05_note"] = { name = "26_91_05_note", label = "Bank Note #26910", weight = 10, type = "item", image = "banknote.png", unique = false, useable = true, shouldClose = true, description = "A mysterious bank note with important information about vault combinations" },
    ["63_39_78_note"] = { name = "63_39_78_note", label = "Bank Note #63397", weight = 10, type = "item", image = "banknote.png", unique = false, useable = true, shouldClose = true, description = "A mysterious bank note with important information about vault combinations" },
    ["85_28_60_note"] = { name = "85_28_60_note", label = "Bank Note #85286", weight = 10, type = "item", image = "banknote.png", unique = false, useable = true, shouldClose = true, description = "A mysterious bank note with important information about vault combinations" },

----------   BANK HEIST TOOLS

    ["torch_tool"] = { name = "torch_tool", label = "Torch Tool", weight = 2500, type = "item", image = "torch_tool.png", unique = false, useable = true, shouldClose = true, description = "A specialized torch tool for cutting through metal doors and locks during bank heists" },
    ["dynamite"] = { name = "dynamite", label = "Bank Dynamite", weight = 1800, type = "item", image = "dynamite.png", unique = false, useable = true, shouldClose = true, description = "Explosive device for breaking through reinforced doors and walls. Handle with extreme care!" },
    ["gas_mask"] = { name = "gas_mask", label = "Gas Mask", weight = 1200, type = "item", image = "gas_mask.png", unique = false, useable = true, shouldClose = true, description = "Protective mask against toxic gases and smoke. Essential for dangerous environments" },





### **3. Server.cfg**
```lua
ensure bank_lobby
ensure bank_selector  
ensure dodi_clockbomb_minigame
ensure dodi_bankrobbery
```

### **4. Required Items**
The system automatically adds:
- **19 Bank Notes** - Vault combinations
- **Torch Tool** - Torch for cutting doors
- **Bank Dynamite** - Specialized explosives
- **Gas Mask** - Protection against toxic gas

---

## 🎮 COMMANDS AND CONTROLS



### **Game Controls**
- **G** - Interact with prompts
- **E** - Use tools
- **Mouse** - Vault minigame (dial)
- **ESC** - Cancel minigames

---

## ⚙️ ADVANCED CONFIGURATION

### **Custom Timer**
```lua
Config.RobberyTimer = {
    enabled = true,
    defaultDuration = 600000, -- 10 minutes
    position = {x = 0.5, y = 0.1},
    colors = {
        normal = {r = 255, g = 255, b = 255},
        warning = {r = 255, g = 255, b = 100}, 
        critical = {r = 255, g = 100, b = 100}
    }
}
```

### **Toxic Gas System**
```lua
explosiveGas = {
    enabled = true,
    triggerOnTimerExpired = true,
    explosionCoords = vector3(-305.245, 764.52, 120.346),
    explosionTag = 35,
    damageScale = 1.0
}
```

### **Hostages per Bank**
```lua
Config.HostageSystems = {
    valentine = {
        enabled = true,
        maxHostages = 6,
        spawnRadius = 15.0,
        models = {"cs_hobartcrawley", "cs_bankclerk"}
    }
}
```

---

## 🚨 GAMEPLAY MECHANICS

### **Penalty System**
- **Dead hostage**: -60 seconds on timer
- **Escaped hostage**: -30 seconds on timer  
- **Sabotage generator**: Guaranteed toxic gas
- **No mask**: Death by toxic gas

### **Reward System**
- **Plan A**: Maximum reward + stealth bonus
- **Plan B**: High reward + tactical bonus
- **Plan C**: Medium reward - violence penalty
- **Plan D**: High reward + demolition bonus

### **Progressive Difficulty**
- **Valentine**: Beginner 
- **Rhodes**: Intermediate 
- **Saint Denis**: Advanced 


---

## 🔧 TROUBLESHOOTING

### **Common Issues**


**Timer doesn't start:**
- Check if lobby is active
- Confirm `autoStart = true` configuration
- Check if hostages are spawned

**Gas doesn't activate:**
- Verify `explosiveGas.enabled = true`
- Confirm `triggerOnTimerExpired = true`
- Check explosion coordinates

**Vaults don't open:**
- Verify correct combination
- Confirm note was read by player
- Check if toxic gas is active

---

## 📊 SYSTEM STATISTICS

- **Total Files**: 25+ Lua files
- **Lines of Code**: 15,000+ lines  
- **Supported Banks**: 3 locations
- **Vault Types**: 6 different models
- **Tools**: 3 specialized
- **Heist Plans**: 4 unique strategies
- **Hostage System**: 8+ NPC models
- **Combination Notes**: 19 unique

---

## 🤝 CREDITS AND SUPPORT

**Developed for VORP Framework & RSG Framework**
- Complete bank robbery system
- Full integration with VORP Core & RSG Core
- MySQL/MySQL-Async support
- Optimized for RedM

**External Resources:**
- 3D vault dial model (safe_dial.glb)
- Realistic ambient sounds
- Custom interface textures
- Official RedM animations

---
> **⚠️ SALE OR DISTRIBUTION WITHOUT AUTHORIZATION PROHIBITED!**
>
> This resource is protected by DODIBAN.  
> Any use, copying, sale or redistribution without express permission from the author is strictly prohibited and will result in legal action and community ban.
>
> For support, contact: 
> https://discord.gg/c8E9anNGVg on Discord.
> Github: https://github.com/dodibanScripts