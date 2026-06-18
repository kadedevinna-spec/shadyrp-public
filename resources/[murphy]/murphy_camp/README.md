# Murphy Camp

## Dependencies

- [oxmysql](https://github.com/overextended/oxmysql)
- [jo_libs](https://github.com/Jump-On-Studios/RedM-jo_libs)

## Installation

1. Put murphy_camp into your resources folder:

2. Ensure the dependencies are installed and available in your resources folder.

3. Import the SQL file into your database:

4. Add the resource to your `server.cfg`:

## Configuration

### Config File

Edit the `config.lua` file to customize the script according to your needs. Here are some of the key configurations:

- `Config.Campfire`: Define the properties and items required for campfires.
  - `props`: The model of the campfire.
  - `item`: The item required to place the campfire.
  - `radius`: The radius around the campfire where furnitures can be placed.

- `Config.Furnitures`: Define the properties and items required for furnitures.
  - `props`: The model of the furniture.
  - `item`: The item required to place the furniture.

- `Config.BasicFuel`: Set the basic fuel amount for campfires.

- `Config.LockpickItem`: Set the item required for lockpicking.

- `Config.LockpickDistance`: Set the distance required for lockpicking.

- `Config.BannedCity`: Define the cities where camps cannot be placed.

- `Config.InterdictionRadius`: Set the radius around camps where other camps cannot be placed.

- `Config.DisplayDistance`: Set the distance for displaying campfires and furnitures.

- `Config.CampDecay`: Enable or disable camp decay.

### Example Configuration

```lua
Config = {}

Config.Campfire = {
    [1] = {
        props = "p_campfire03x",
        item = "campfire_item",
        radius = 15.0
    }
}

Config.Furnitures = {
    [1] = {
        props = "p_chair01x",
        item = "chair_item"
    }
}

Config.BasicFuel = 100
Config.LockpickItem = "lockpick"
Config.LockpickDistance = 5.0
Config.BannedCity = {
    ["SaintDenis"] = true,
    ["Blackwater"] = true
}
Config.InterdictionRadius = 50.0
Config.DisplayDistance = 20.0
Config.CampDecay = true
```

## Usage

Interact with campfires and furnitures using the prompts displayed on the screen.

For more detailed usage and customization, refer to the comments and documentation within the script files.
