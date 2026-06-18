# QC-AdvancedMoonshine

Immersive moonshine brewing and distribution system for RedM with experimental brewing mechanics, shack management, and illicit economy features for RSG Framework

![Version](https://img.shields.io/badge/version-2.0.0-blue.svg)
![Framework](https://img.shields.io/badge/framework-RSG--Core-green.svg)

## Features

### Brewing System
- **Experimental Stash-Based Brewing**: Add ingredients to still stash, select recipe from menu
- **Dynamic Recipe Discovery**: Learn recipes through experimentation and ingredient combinations
- **Temperature Minigame**: Maintain optimal temperature during brewing for quality moonshine
- **Quality System**: Temperature control affects final product quality and proof
- **Batch Brewing**: Brew multiple batches at once (scales with still tier)
- **Portable Stills**: 4 upgrade tiers (Barrel → Basic → Advanced → Master)
- **Tool Durability**: Stills degrade with use and explosions, require repairs

### Moonshine Shacks
- **Rentable Properties**: 3 shack locations with interior management
- **Shack Upgrades**: Distillery equipment, bar furnishings, interior decorations
- **Boss Missions**: Marcus "The Distiller" Kane offers high-risk illegal brewing jobs
- **Delivery System**: Dynamic delivery offers with reputation-based rewards
- **Access Control**: Give keys to employees, manage authorized players
- **Shack Distillery**: Larger brewing capacity with same experimental mechanics
- **Bar Management**: Stock and sell moonshine to NPCs (planned feature)

### Audio & Effects
- **Server-Synced Brewing Sounds**: xsound integration with 3D positional audio
- **Sound Fade Effects**: Smooth 5-second fade-out as brewing completes
- **Explosion Effects**: Visual and audio feedback for still failures
- **Distance-Based Audio**: Portable stills (15m) vs shack distilleries (10m)

### Economy & Progression
- **Moonshine XP System**: Level up by brewing, discovering recipes, completing deliveries
- **Reputation System**: Build trust with Marcus Kane to unlock boss missions
- **Vendor Shop**: Old Coot McGraw sells supplies and upgrade parts
- **Dynamic Pricing**: Hover-based shop UI with gold-colored pricing
- **Trust Requirements**: Advanced items unlock at level 5 with 3 recipes discovered

### Quality of Life
- **Blip System**: Owner blips vs authorized player blips with color modifiers
- **Auto-Completion**: Brews finish automatically when cook time elapses
- **Timer Synchronization**: Real-time brewing timers sync across clients
- **Sound Persistence**: Brewing sounds restore on player reconnect
- **Input Dialogs**: Clean UI for purchasing, naming, and text entry

## Dependencies
- [ox_lib](https://github.com/overextended/ox_lib)
- [oxmysql](https://github.com/overextended/oxmysql)
- [rsg-inventory](https://github.com/Rexshack-RedM/rsg-inventory)
- [rco-dialogs](https://github.com/RetryR1v2/rco-dialogs)
- [xsound](https://github.com/Xogy/xsound) - for brewing audio effects

## Installation

**📋 For complete installation instructions, see [INSTALL.txt](INSTALL.txt)**

Quick overview:
1. Extract to resources folder
2. Execute database file
3. Add items to rsg-core
4. Configure xsound audio
5. Edit config files
6. Add to server.cfg

## Quick Start

### For New Players
1. Visit Old Coot McGraw's shop (blip on map)
2. Purchase **Basic Still Kit** ($500)
3. Purchase upgrade materials: **Moonshine Barrel** ($150), **Distillery Pot** ($200), **Nails** ($15)
4. Place the barrel still using the kit item
5. Interact with barrel and select **Upgrade Still**
6. Add ingredients to still stash (corn, wheat, sugar, yeast)
7. Select **Start Brew** and choose a recipe
8. Complete temperature minigame
9. Wait for brew timer to finish (45 seconds for basic mash)
10. Collect finished moonshine from stash

### For Experienced Players
1. Rent a moonshine shack ($1000/week)
2. Upgrade shack distillery for larger batches
3. Complete Marcus Kane's boss missions for rare recipes
4. Build reputation through deliveries
5. Unlock advanced still tiers and brewing techniques

## Configuration

### Brewing Mechanics
```lua
Config.Recipes = {
    moonshine = {
        basic = {
            name = "Basic Mash",
            cookTime = 45, -- seconds
            ingredients = {
                corn = 2,
                wheat = 1,
                sugar = 1,
                yeast = 1
            },
            output = "moonshine_basic",
            xp = 10
        },
        -- 15+ moonshine recipes...
    },
    mash = {
        -- 5 mash recipes for shack bar usage...
    }
}
```

### Temperature Minigame
```lua
Config.Minigame = {
    Duration = 150, -- frames (~25 seconds)
    OptimalTemp = 590, -- degrees
    TempTolerance = 40, -- +/- range
    StartTemp = 550,
    ExplosionTemp = 750, -- too hot = boom
    FreezeTemp = 400 -- too cold = failure
}
```

### Shack Locations
```lua
Config.Shacks = {
    Locations = {
        {
            id = "emerald_ranch",
            name = "Emerald Ranch Shack",
            entrance = vector3(1343.68, -2231.83, 47.04),
            interior = vector3(2526.34, -1308.85, 49.08),
            blip = {sprite = "blip_ambient_moonshine", scale = 0.2},
            rental_price = 1000,
            rental_duration = 604800 -- 7 days
        },
        -- 2 more shack locations...
    }
}
```

### Audio Settings
```lua
Config.Sounds = {
    UseInteractSound = true,
    BrewSound = "moonshineDeep",
    ExplosionSound = "explosion"
}
-- xsound automatically uses brewfx.ogg
```

### Vendor Shop
```lua
Config.Vendor = {
    Name = "Old Coot McGraw",
    Location = vector4(1235.36, -2326.19, 44.22, 355.90),
    Shop = {
        {item = "still_build", price = 500},
        {item = "moonshine_barrel", price = 150},
        {item = "moonshine_pot_distillery", price = 200},
        {item = "nails", price = 15, amount = 20},
        -- Coal, yeast, upgrade parts...
    }
}
```

## How It Works

### Experimental Brewing System
1. **Add Ingredients**: Open still stash, add items
2. **Recipe Detection**: System matches ingredients to known recipes
3. **Start Brew**: Menu shows available recipes based on stash contents
4. **Minigame**: Control temperature using heating/cooling
5. **Brewing Time**: Wait for cook timer (server-side tracking)
6. **Collection**: Retrieve finished product from stash

### Quality & Proof Calculation
- **Temperature Control**: Stay within ±40° of optimal temp
- **Quality Range**: 0-100% based on average temperature deviation
- **Proof Boosting**: Add boosting items (ginseng, berries) for higher proof
- **Metadata System**: Each bottle stores quality, proof, still type, brewer name

### Shack Management
- **Rental System**: Weekly payments via SQL expiration tracking
- **Access Control**: Owners can authorize players (stored in database)
- **Blip System**: Owners see "My Moonshine Shack", authorized see "(Access)" with color modifier
- **Delivery Offers**: Refresh every 6 hours, reputation-gated rewards
- **Boss Actions**: Manage access, rename shack, view stats

### Sound System (Server-Sided)
- **PlayUrlPos**: Server broadcasts 3D positional audio to all clients
- **fadeOut**: 5-second fade when 5 seconds remain
- **Destroy**: Sound stops at 0:00 or on collection
- **Persistence**: Sounds restore on reconnect via `GetActiveBrewingSounds` callback

## Recent Updates

### v2.0.0 (Latest - 2025-01-XX)
- 🎵 **Server-Synced Brewing Sounds**: Full xsound integration with fade-out effects
- 🔐 **Shack Access Control**: Give keys to employees, manage authorized players
- 🗺️ **Blip System**: Different blip colors for owners vs authorized players
- ⏱️ **Timer Synchronization**: Fixed UI timer desync, brews now track accurately
- 💰 **Shop Redesign**: Hover-based pricing with gold footer text
- 🛠️ **Auto-Completion**: Brews mark `readyToCollect` when timer hits 0:00
- 🔧 **Bug Fixes**: SaveShack scope error, brew_start timing, collection failures
- 📦 **Vendor Updates**: Barrel upgrade materials now available at level 1

## Performance

- Server-side brew tracking with 1-second update intervals
- Client-side proximity spawning for stills
- Optimized sound management (destroy on completion/collection)
- Database auto-save for shack data

## Troubleshooting

**Brewing sound not stopping?**
- Ensure xsound exports use correct syntax: `exports['xsound']:Destroy(-1, soundName)`
- Check server console for sound destruction logs

**Can't collect finished brew?**
- Verify `still.readyToCollect` is true in server logs
- Check `ActiveBrews` table - brew should auto-complete after cook time

**Blips not showing?**
- Owners: Check `citizenid` matches database `owner` column
- Authorized: Verify `authorized_players` JSON array in database

**Shop items locked?**
- Level 1 items: Still kit, barrel, distillery pot, nails
- Level 5 + Trust (3 recipes): Advanced upgrade parts

## License

Copyright © 2025 Quantum Projects Community. All rights reserved.

See [LICENSE.md](LICENSE.md) for full terms and conditions.

## Support

**Discord**: [Quantum Projects](https://discord.gg/kJ8ZrGM8TS)
**Developer**: Artmines | Quantum Projects Community

---

**Version**: 2.0.0 | **Framework**: RSG-Core for RedM
