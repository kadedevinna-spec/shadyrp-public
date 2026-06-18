```sql
INSERT INTO `items` (`item`, `label`, `limit`, `can_remove`, `type`, `usable`, `metadata`, `desc`)
VALUES
    ('apple', 'Apple', 10, 1, 'item_standard', 1, '{}', 'nice item'),
    ('consumable_haycube', 'Haycube', 10, 1, 'item_standard', 1, '{}', 'nice item'),
    ('bandage', 'Bandage', 10, 1, 'item_standard', 1, '{}', 'nice item'),
    ('bread', 'Bread', 10, 1, 'item_standard', 1, '{}', 'nice item'),
    ('consumable_chocolate', 'Chocolate', 10, 1, 'item_standard', 1, '{}', 'nice item'),
    ('snackplate', 'Snack Plate', 10, 1, 'item_standard', 1, '{}', 'nice item'),
    ('cheese', 'Cheese', 10, 1, 'item_standard', 1, '{}', 'nice item'),
    ('fruitcake', 'Fruit Cake', 10, 1, 'item_standard', 1, '{}', 'nice item'),
    ('chocolatecake', 'Chocolate Cake', 10, 1, 'item_standard', 1, '{}', 'nice item'),
    ('cookie', 'Cookie', 10, 1, 'item_standard', 1, '{}', 'nice item'),
    ('consumable_kidneybeans_can', 'Kidneybeans', 10, 1, 'item_standard', 1, '{}', 'nice item'),
    ('fruitplate', 'Fruit Plate', 10, 1, 'item_standard', 1, '{}', 'nice item'),
    ('lobster', 'Lobster', 10, 1, 'item_standard', 1, '{}', 'nice item'),
    ('oyster', 'Oyster', 10, 1, 'item_standard', 1, '{}', 'nice item'),
    ('water', 'Water', 10, 1, 'item_standard', 1, '{}', 'nice item'),
    ('coffe', 'Coffe', 10, 1, 'item_standard', 1, '{}', 'nice item'),
    ('chamomiletea', 'Chamomiletea', 10, 1, 'item_standard', 1, '{}', 'nice item'),
    ('beer', 'Beer', 10, 1, 'item_standard', 1, '{}', 'nice item'),
    ('liquor', 'Liquor', 10, 1, 'item_standard', 1, '{}', 'nice item'),
    ('gin', 'Gin', 10, 1, 'item_standard', 1, '{}', 'nice item'),
    ('wine', 'Wine', 10, 1, 'item_standard', 1, '{}', 'nice item'),
    ('whisky', 'Whisky', 10, 1, 'item_standard', 1, '{}', 'nice item'),
    ('honeywhisky', 'Honey Whisky', 10, 1, 'item_standard', 1, '{}', 'nice item'),
    ('cigarette', 'Cigarette', 10, 1, 'item_standard', 1, '{}', 'nice item'),
    ('cigar', 'Cigar', 10, 1, 'item_standard', 1, '{}', 'nice item'),
    ('adrenaline', 'Adrenalin', 10, 1, 'item_standard', 1, '{}', 'nice item'),
    ('horseadrenaline', 'Horse Adrenalin', 10, 1, 'item_standard', 1, '{}', 'nice item'),
    ('armor', 'Armour', 10, 1, 'item_standard', 1, '{}', 'nice item'),
    ('horsebrush', 'Horse Brush', 10, 1, 'item_standard', 1, '{}', 'nice item')

ON DUPLICATE KEY UPDATE
    `item` = VALUES(`item`),
    `label` = VALUES(`label`),
    `limit` = VALUES(`limit`),
    `can_remove` = VALUES(`can_remove`),
    `type` = VALUES(`type`),
    `usable` = VALUES(`usable`),
    `metadata` = VALUES(`metadata`),
    `desc` = VALUES(`desc`);
```


### vorp_core/config/config.lua
# change code
```lua
    HideUi                = true,      -- Shows or hides the overall UI.
    HideGold              = true,      -- Disables the Gold UI for all players.
    HideMoney             = true,      -- Disables the Money UI for all players.
    HideLevel             = true,      -- Disables the Level UI for all players.
    HideID                = true,      -- Disables the ID UI for all players.
    HideTokens            = true,      -- Disables the Token UI for all players.
    HidePVP               = true,      -- Disables the PVP UI for all players.
```
### vorp_core/config/commands.lua
# change code
# heal command replace
```lua
    heal = {
        webhook = "",
        custom = T.heal.custom,
        title = T.heal.title,
        commandName = "heal",
        label = T.heal.label,
        suggestion = {
            { name = T.heal.name, help = T.heal.help }
        },
        userCheck = true,
        groupAllowed = { "admin" },
        aceAllowed = 'vorpcore.healplayer.Command',
        callFunction = function(data)
            -- in here you can add your metabolism events
            TriggerClientEvent("fx-hud:client:ForceHeal", tonumber(data.args[1]))
            HealPlayers(data)
        end
    },
```

# revive command replace
```lua
    revive = {
        webhook = "",
        custom = T.revive.custom,
        title = T.revive.title,
        commandName = "revive",
        label = T.revive.label,
        suggestion = {
            { name = T.revive.name, help = T.revive.help }
        },
        userCheck = true,
        groupAllowed = { "admin" },
        aceAllowed = 'vorpcore.reviveplayer.Command',
        callFunction = function(data)
            RevivePlayer(data)
            TriggerClientEvent("fx-hud:client:ForceHeal", tonumber(data.args[1]))
        end
    },
```


# close code or delete
vorp_core/client/spawnplayer.lua
line 136.

set
```lua
        else
            -- CoreAction.Admin.HealPlayer()
        end
```

## It should look like this code
```lua
RegisterNetEvent('vorp:initCharacter')
AddEventHandler('vorp:initCharacter', function(coords, heading, isdead)
    CoreAction.Player.TeleportToCoords(coords, heading)
    if isdead then
        if not Config.CombatLogDeath then
            if Config.Loadinscreen then
                Citizen.InvokeNative(0x1E5B70E53DB661E5, 0, 0, 0, T.forcedrespawn, T.forced, T.Almost)
            end
            SetEntityCanBeDamaged(PlayerPedId(), true)
            CoreAction.Player.RespawnPlayer() -- this one doesnt need to trigger events, its for player combat log
            Wait(Config.LoadinScreenTimer)
            Wait(1000)
            ShutdownLoadingScreen()
            Wait(5000)
        else
            if Config.Loadinscreen then
                Citizen.InvokeNative(0x1E5B70E53DB661E5, 0, 0, 0, T.Holddead, T.Loaddead, T.Almost)
            end
            Wait(10000)
            TriggerEvent("vorp_inventory:CloseInv")
            Wait(4000)
            SetEntityCanBeDamaged(PlayerPedId(), true)
            SetEntityHealth(PlayerPedId(), 0, 0)
            Citizen.InvokeNative(0xC6258F41D86676E0, PlayerPedId(), 0, -1)
            ShutdownLoadingScreen()
        end
    else
        local PlayerId = PlayerId()
        if Config.Loadinscreen then
            Citizen.InvokeNative(0x1E5B70E53DB661E5, 0, 0, 0, T.Hold, T.Load, T.Almost)
            Wait(Config.LoadinScreenTimer)
            Wait(1000)
            ShutdownLoadingScreen()
        end

        if not Config.HealthRecharge.enable then
            Citizen.InvokeNative(0x8899C244EBCF70DE, PlayerId, 0.0) -- SetPlayerHealthRechargeMultiplier
        else
            Citizen.InvokeNative(0x8899C244EBCF70DE, PlayerId, Config.HealthRecharge.multiplier)
            multiplierHealth = Citizen.InvokeNative(0x22CD23BB0C45E0CD, PlayerId) -- GetPlayerHealthRechargeMultiplier
        end

        if not Config.StaminaRecharge.enable then
            Citizen.InvokeNative(0xFECA17CF3343694B, PlayerId, 0.0) -- SetPlayerStaminaRechargeMultiplier
        else
            Citizen.InvokeNative(0xFECA17CF3343694B, PlayerId, Config.StaminaRecharge.multiplier)
            multiplierStamina = Citizen.InvokeNative(0x617D3494AD58200F, PlayerId) -- GetPlayerStaminaRechargeMultiplier
        end

        SetEntityCanBeDamaged(PlayerPedId(), true)

        if Config.SavePlayersStatus then
            TriggerServerEvent("vorp:GetValues")
            Wait(200)
            if HealthData then
                local player = PlayerPedId()
                Citizen.InvokeNative(0xC6258F41D86676E0, player, 0, HealthData.hInner or 600)
                SetEntityHealth(player, (HealthData.hOuter and HealthData.hOuter > 0 and HealthData.hOuter or 600) + (HealthData.hInner and HealthData.hInner > 0 and HealthData.hInner or 600), 0)
                Citizen.InvokeNative(0xC6258F41D86676E0, player, 1, HealthData.sInner or 600)
                Citizen.InvokeNative(0x675680D089BFA21F, player, (HealthData.sOuter or (1065353215 * 100)) / 1065353215 * 100)
            end
            HealthData = {}
        else
            -- CoreAction.Admin.HealPlayer()
        end
    end
    SetTimeout(2000, function()
        DoScreenFadeIn(4000)
        repeat Wait(500) until IsScreenFadedIn()
    end)
end)
```