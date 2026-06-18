# OxObjSelector - Configurable Object Interaction System

A production-ready, fully configurable object interaction system for RedM using ox_target and ox_lib.

## Features

- ✅ **Fully Configurable** - All objects and interactions defined in `config.lua`
- ✅ **Multi-Language Support** - Built-in English, French, Serbian, and Spanish translations
- ✅ **Easy to Extend** - Add your own objects and animations without touching client code
- ✅ **Quick Access** - Define quick action buttons for common interactions
- ✅ **Organized Menus** - Categorized interaction menus for better UX
- ✅ **Gender-Specific** - Support for male/female specific animations
- ✅ **Production Ready** - Clean code, optimized performance, no errors

## Dependencies

- [ox_target](https://github.com/overextended/ox_target)
- [ox_lib](https://github.com/overextended/ox_lib)

## Installation

1. Extract the `OxObjselector` folder to your resources directory
2. Ensure you have `ox_target` and `ox_lib` installed and started
3. Add `ensure OxObjselector` to your `server.cfg`
4. Restart your server

## Language/Localization

OxObjSelector supports multiple languages out of the box! Change the language in `config.lua`:

```lua
Config.Locale = 'en'  -- Options: 'en', 'fr', 'sr', 'es', 'de', 'pl', 'pt'
```

**Supported Languages:**
- English (`en`) - Default
- French (`fr`)
- Serbian (`sr`)
- Spanish (`es`)
- German (`de`)
- Polish (`pl`)
- Portuguese (`pt`)

### Adding Your Own Language

1. **Create a new locale file** in the `locales/` folder (e.g., `de.lua` for German)
2. **Copy the structure** from `locales/en.lua` as a template
3. **Translate all the strings** keeping the keys the same:
   ```lua
   Locales['de'] = {
       ['press_to_stand'] = 'Drücke ESC oder G zum Aufstehen',
       ['sit_down'] = 'Hinsetzen',
       -- ... translate all keys
   }
   ```
4. **Add your locale file to fxmanifest.lua** in the `shared_scripts` section:
   ```lua
   shared_scripts {
       'locales/locale.lua',
       'locales/en.lua',
       'locales/fr.lua',
       -- ... other locales
       'locales/de.lua',  -- Add your new locale here
       'config.lua',
       'bath_config.lua'
   }
   ```
5. **Set your language** in `config.lua`:
   ```lua
   Config.Locale = 'de'
   ```
6. **Restart the resource** and test!

For a complete guide with all translation keys, see [LOCALIZATION.md](LOCALIZATION.md)

## Configuration

All configuration is done in `config.lua`. The config is divided into sections:

### 1. Object Models (`Config.Objects`)

Define the prop/model names for each object type:

```lua
Config.Objects = {
    Chairs = {
        "p_chair01x",
        "p_chair02x",
        -- Add more chair models here
    },
    
    Beds = {
        "p_bed01x",
        "p_bed02x",
        -- Add more bed models here
    }
    
    -- Add your own object types here
}
```

### 2. Interaction Categories (`Config.Interactions`)

Define categories of interactions for each object type:

```lua
Config.Interactions = {
    Chairs = {
        {
            name = 'sitting',
            label = 'Sitting Positions',
            icon = 'chair',
            scenarios = {
                {label = "Sit Normal", scenario = "PROP_HUMAN_SEAT_CHAIR"},
                {label = "Sit Slouched", scenario = "PROP_HUMAN_SEAT_CHAIR_UPRIGHT"},
                -- Add more scenarios here
            }
        },
        -- Add more categories here
    }
    
    -- Add your own object types here
}
```

#### Scenario Options

Each scenario can have the following properties:

- `label` (required): Display name in the menu
- `scenario` (required): The scenario/animation name
- `icon` (optional): Font Awesome icon name
- `male` (optional): Set to `true` if only for male characters
- `female` (optional): Set to `true` if only for female characters
- `offsetX`, `offsetY`, `offsetZ` (optional): Position offsets from object
- `headingOffset` (optional): Rotation offset in degrees

### 3. Quick Access (`Config.QuickAccess`)

Define quick action buttons that appear first in the ox_target menu:

```lua
Config.QuickAccess = {
    Chairs = {
        {
            label = 'Sit Down',
            icon = 'fas fa-chair',
            scenario = 'PROP_HUMAN_SEAT_CHAIR',
            offsetX = 0.0, offsetY = 0.0, offsetZ = 0.0, headingOffset = 180.0
        }
    }
}
```

## Adding Your Own Objects

### Example: Adding a Custom Table

1. **Add the models to `Config.Objects`:**

```lua
Config.Objects.CustomTables = {
    "my_custom_table_01",
    "my_custom_table_02"
}
```

2. **Define the interactions in `Config.Interactions`:**

```lua
Config.Interactions.CustomTables = {
    {
        name = 'working',
        label = 'Work Activities',
        icon = 'briefcase',
        scenarios = {
            {label = "Write at Table", scenario = "WORLD_HUMAN_WRITE_NOTEBOOK"},
            {label = "Read at Table", scenario = "WORLD_HUMAN_READ_NEWSPAPER_GROUND"}
        }
    }
}
```

3. **Add quick access (optional):**

```lua
Config.QuickAccess.CustomTables = {
    {
        label = 'Work Here',
        icon = 'fas fa-pen',
        scenario = 'WORLD_HUMAN_WRITE_NOTEBOOK',
        offsetX = 0.0, offsetY = 0.0, offsetZ = 0.0, headingOffset = 0.0
    }
}
```

That's it! No code changes needed - just restart the resource.

## Finding Scenario Names

You can find RedM scenario names by:

1. Checking the [RedM Natives documentation](https://docs.fivem.net/natives/)
2. Using scenario discovery tools
3. Looking at other scripts
4. Checking the RedM game files

Common scenarios:
- `PROP_HUMAN_SEAT_CHAIR` - Sit on chair
- `PROP_HUMAN_SLEEP_BED_PILLOW` - Sleep on bed
- `WORLD_HUMAN_STAND_FIRE` - Warm hands by fire
- `WORLD_HUMAN_WRITE_NOTEBOOK` - Write in notebook
- `PROP_HUMAN_ABIGAIL_PIANO` - Play piano

## Commands

- `/ec` - Exit current scenario (stand up)
- `/rc` - Exit current scenario (stand up)
- `/standup` - Exit current scenario (stand up)

You can also press **ESC**, **G**, or **X** to stand up.

## Exports

The script provides exports for other resources:

```lua
-- Cancel the current scenario
exports.OxObjselector:CancelScenario()

-- Check if player is in a scenario
local isInScenario = exports.OxObjselector:IsInScenario()
```

## Settings

General settings in `config.lua`:

```lua
-- Interaction distance for ox_target
Config.InteractionDistance = 2.0

-- Enable debug prints
Config.Debug = false
```

## Support

For support, please contact the seller through your purchase platform.

## Credits

- Script by Touka
- Uses ox_target and ox_lib by Overextended

## Version History

### 2.0.0 (Production Release)
- Complete rewrite with config-based system
- Easy to add custom objects and interactions
- Improved menu organization
- Better performance
- Production ready

---

**Thank you for your purchase!**

Enjoy your fully configurable object interaction system. If you create cool custom interactions, feel free to share them with the community!
