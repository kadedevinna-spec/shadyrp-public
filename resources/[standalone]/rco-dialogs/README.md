<h1 align='center'>
  RCO Dialogs
</h1>

<div align="center">
  Advanced NPC dialog system for RedM with automatic camera management
</div>

## `Information`

* **Automatic Camera Management:** Seamlessly handles camera transitions during NPC conversations
* **Interactive Dialogs:** Support for multiple buttons with custom actions
* **Modern UI:** Built with React and TypeScript for a smooth user experience

## `Requirements`

- [**ox_lib**](https://github.com/overextended/ox_lib/releases/latest)

## `Installation`

1. Place the `rco-dialogs` folder in your `resources` directory
2. Add `ensure rco-dialogs` to your server.cfg


### `showDialog(data)`

Shows a dialog with the specified configuration.

```lua
exports["rco-dialogs"]:showDialog({
    npc = entity,
    camera = {
        distance = 1.5,
        height = 0.7,
        fov = 45.0,
        ease = true,
        easeTime = 1000
    },
    name = { text = "NPC Name" },
    message = { 
        text = "Hello! How can I help you?", 
        typeEffect = 40 
    },
    buttons = {
        {
            message = "Option 1",
            onSelect = function()
                -- Your action here
                exports["rco-dialogs"]:hideDialog()
            end
        },
        {
            message = "Option 2",
            onSelect = function()
                -- Your action here
                exports["rco-dialogs"]:hideDialog()
            end
        }
    }
})
```

### `hideDialog()`

Hides the currently active dialog.

```lua
exports["rco-dialogs"]:hideDialog()
```


## `Usage Examples`

### Basic Dialog

```lua
exports["rco-dialogs"]:showDialog({
    npc = shopkeeper,
    name = { text = "Shopkeeper" },
    message = { text = "Welcome to my shop!" },
    buttons = {
        {
            message = "Buy Items",
            onSelect = function()
                -- Open shop
            exports["rco-dialogs"]:hideDialog()

            end
        },
        {
            message = "Leave",
            onSelect = function()
                exports["rco-dialogs"]:hideDialog()
            end
        }
    }
})
```