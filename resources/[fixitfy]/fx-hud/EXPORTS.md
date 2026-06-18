# FX-HUD

## Installation
- Add ```ensure fx-hud``` in your server.cfg

## Exports 
### Client Side
 ```lua
local xp = exports['fx-hud']:getXP() -- Returned Player XP (INT)
local level = exports['fx-hud']:getLevel() -- Returned Player Level (INT)
local status = exports['fx-hud']:getStatus("hunger") -- Returned Player Status (Example Params: hunger,thirst,stress,alcohol)
exports['fx-hud']:setStatus("thirst", 50) -- Add Or Remove Player Status ( Params: hunger,thirst,stress,alcohol and Value must be INT)
exports['fx-hud']:hideHud() -- Hide all hud elements if you need some scenario (Example: Photograph mode)
exports['fx-hud']:showHud() -- Show all hud elements if you need some scenario
exports['fx-hud']:clearDirty() -- Clear all ped dirt, blood, damage decals and reset dirty stat to 0
### EXAMPLE
RegisterCommand("addstress", function()
    exports['fx-hud']:setStatus("stress",50)-- or -100
end)
RegisterCommand("removestress", function()
    exports['fx-hud']:setStatus("stress",-50)-- or -100
end)
```

### EXPORTS EXAMPLE / USAGE CLIENT SIDE
```lua
    exports['fx-hud']:setStatus("hunger",100)
    exports['fx-hud']:setStatus("thirst",100)
    exports['fx-hud']:setStatus("stress",-100)-- or -100
    exports['fx-hud']:setStatus("alcohol",-100)-- or -100
```

### clearDirty — Ped kirliliğini temizle
Oyuncunun tüm kirliliğini, kanını ve hasar decal'larını temizler. Duş/temizlenme scriptlerinden çağrılabilir.
```lua
-- Kullanım (client side):
exports['fx-hud']:clearDirty()
```

### Server Side
```lua
exports['fx-hud']:addXP(playerId,value) -- Add xp to player
exports['fx-hud']:removeXP(playerId,value) -- Remove xp to player
exports['fx-hud']:getXP(playerId,function(xp)
        print(xp)
end) -- Returned Player XP ASYNC
exports['fx-hud']:getLevel(playerId,function(level)
        print(level)
end) -- Returned Player Level ASYNC
```

### GOLD CORE EFFECTS / CLIENT SIDE

```lua
local ped = PlayerPedId()
local coreIndex = 0 --- 0 = Health, 1 = Stamina, 2 = Dead Eye
local goldValueTime = 1000.0 -- second
local makeSound = true -- gold active sound
EnableAttributeCoreOverpower(ped, coreIndex, goldValueTime, makeSound) -- INNER
EnableAttributeOverpower(ped, coreIndex, goldValueTime, makeSound) -- OUTER
```

## Notify System
```lua
TriggerEvent("fx-hud:client:showNotify", text, time, type)
```
- Text: Display Text (String)
- Time: Set how many seconds it will appear (INT)
- Type: Notify Type (warning,error,success,info)

```js
            "~e~": "#FF0000",    // Red
            "~o~": "#FFFF00",    // Yellow
            "~d~": "#FFA500",    // Orange
            "~m~": "#808080",    // Grey
            "~q~": "#FFFFFF",    // White
            "~t~": "#D3D3D3",    // Light Grey
            "~v~": "#000000",    // Black
            "~u~": "#FFC0CB",    // Pink
            "~pa~": "#0000FF",   // Blue
            "~t1~": "#800080",   // Purple
            "~t2~": "#FFA500",   // Orange
            "~t3~": "#ADD8E6",   // Light Blue
            "~t4~": "#FFFF00",   // Yellow
            "~t5~": "#FFB6C1",   // Light Pink
            "~t6~": "#008000",   // Green
            "~t7~": "#00008B",   // Dark Blue
            "~t8~": "#FF6961"    // Light RedIsh
```
Example
Notify
```lua
local text = "~t6~ Hello ~t2~friend"
local time = 5000
local type = "warning"
TriggerEvent("fx-hud:client:showNotify", text, time, type)
```




