# Spooni Interactions

A comprehensive environmental interaction system for RedM that allows players to interact with furniture, objects, and environments using realistic scenarios and animations.

## 📋 Overview

Spooni Interactions provides an immersive way for players to interact with their environment in RedM. The resource includes interactions for furniture like chairs, benches, beds, pianos, bathtubs, and dance stages, with appropriate animations and scenarios for each object type.

## ✨ Features

### Furniture Interactions
- **Chairs & Benches**: Multiple sitting positions and activities
- **Beds**: Various sleeping and resting positions
- **Pianos**: Gender-specific piano playing scenarios
- **Bathtubs**: Bathing animations with cleaning effects
- **Dance Stages**: Performance animations

### Advanced Features
- **Gender & Age Compatibility**: Different interactions based on character type
- **Multiple Positions**: Support for multiple interaction points on single objects
- **Effect System**: Special effects like cleaning when bathing
- **Localization Support**: Multi-language support (English/German)
- **Banned Areas**: Configurable zones where interactions are disabled
- **ox_target Integration**: Modern targeting system for seamless interaction

## 🔧 Dependencies

- **rsg-core**: Core framework
- **ox_lib**: UI and notification system
- **ox_target**: Targeting system for object interaction

## 📦 Installation

1. Download the resource and place it in your `resources` folder
2. Add `ensure spooni_interactions` to your `server.cfg`
3. Make sure all dependencies are installed and running
4. Restart your server

## ⚙️ Configuration

### Basic Settings
```lua
Config.DevMode = true -- Enable/disable development mode
Config.Locale = 'en' -- Language (en, de)
```

### Effects System
The resource includes a customizable effects system. Currently includes:
- **Clean Effect**: Removes dirt, damage decals, and blood from player

### Banned Areas
Configure areas where interactions should be disabled:
```lua
Config.BannedAreas = {
    {x = -306.482, y = 809.1139, z = 118.98, r = 5}, -- radius in units
}
```

## 🎯 Interaction Types

### Chair & Bench Interactions
- Sit normally
- Sit & drink
- Sit & smoke
- Play instruments (banjo, guitar, harmonica, etc.)
- Various activities (reading, knitting, whittling, etc.)

### Piano Interactions
- Play Piano (Male)
- Elegant Piano (Male)
- Riverboat Piano (Male)
- Sketchy Piano (Male)
- Soft Piano (Female)

### Bed Interactions
- Sleep on side
- Sleep on back
- Sleep on stomach
- Crossed legs sitting
- Various sleeping positions

### Bathing Interactions
- General bathing
- Scrub arms
- Scrub legs
- **Includes cleaning effect that removes dirt and damage**

### Dance Interactions
- Sword Dance
- Can Can
- Fire Dance
- Snake Dance

## 🎮 Usage

Players can interact with compatible objects using the ox_target system:

1. Look at a compatible object
2. Use your targeting key (default: Left Alt)
3. Select an interaction from the menu
4. Choose from available scenarios/animations
5. Press the same key again to stop the interaction

## 🛠️ Compatibility System

The resource uses a sophisticated compatibility system:

- **IsPedChild**: Child-specific interactions
- **IsPedAdult**: Adult-only interactions
- **IsPedHumanMale**: Male-specific interactions
- **IsPedHumanFemale**: Female-specific interactions
- **IsPedAdultMale**: Adult male interactions
- **IsPedAdultFemale**: Adult female interactions

## 📍 Pre-configured Locations

The resource includes pre-configured bathing locations in major towns:
- Valentine
- Saint Denis
- Strawberry
- Annesburg
- Rhodes
- Tumbleweed
- Van Horn
- Blackwater
- Bronte Mansion

## 🔄 Supported Objects

### Chairs (100+ models supported)
Including but not limited to:
- Dining chairs
- Rocking chairs
- Office chairs
- Bar stools
- Rustic chairs
- Victorian chairs
- And many more...

### Benches
- Generic benches
- Porch benches
- Park benches

### Beds
- Single beds
- Double beds
- Bunk beds
- Bedrolls
- Indian beds

### Pianos
- Standard pianos
- Upright pianos
- Fancy pianos

### Bathtubs
- Standard bathtubs
- Fancy bathtubs

## 🌐 Localization

Currently supports:
- English (en)
- German (de)

To add new languages, edit `shared/translation.lua` and add your language code to the Translation table.

## 🎨 Customization

### Adding New Interactions

1. **Add Object Models**: Update the object lists in `client/cl_common.lua`
2. **Create Scenarios**: Add new scenarios to the appropriate scenario tables
3. **Configure Positions**: Set up interaction positions in `shared/config.lua`
4. **Add Translations**: Include labels in `shared/translation.lua`

### Example: Adding a New Chair
```lua
-- In client/cl_common.lua, add to GenericChairs table
'p_yournewchair01x',

-- In shared/config.lua, add interaction configuration
{
    isCompatible = IsPedAdult,
    objects = {'p_yournewchair01x'},
    radius = 1.5,
    scenarios = GenericChairAndBenchScenarios,
    x = 0.0,
    y = 0.0,
    z = 0.5,
    heading = 180.0
},
```

## 🐛 Troubleshooting

### Common Issues

1. **Interactions not appearing**: Check if ox_target is properly installed and configured
2. **Wrong positioning**: Adjust x, y, z, and heading values in config
3. **Animation not playing**: Verify animation dictionaries exist in the game
4. **Compatibility issues**: Check isCompatible functions for character restrictions

### Debug Mode
Enable debug mode in config to see additional console output:
```lua
Config.DevMode = true
```

## 📝 Version History

- **Version 8**: Current release with ox_target integration and enhanced compatibility system

## 🤝 Credits

- **Author**: Spooni
- **Framework**: RSG-Core
- **Targeting System**: ox_target
- **UI System**: ox_lib

## 📄 License

This resource is provided as-is. Please respect the original author's work and any licensing terms.
Original Author - https://github.com/Spooni-Development/spooni_interactions

Big thanks go to kibook the creator of the main script, since the script is already 3 years old (as of 2024) we wanted to give it a little overhaul.

Click here for the original script - https://github.com/kibook/redm-interactions

## 🆘 Support

For support and updates, please refer to the original resource documentation or community forums.

---
