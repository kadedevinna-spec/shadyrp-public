### rsg-core/shared/items.lua
```lua
    apple                          = { name = 'apple',                          label = 'Apple', weight = 100, type = 'item', image = 'apple.png',                          unique = false, useable = true, shouldClose = true, description = 'nice item' },
    consumable_haycube             = { name = 'consumable_haycube',             label = 'Haycube', weight = 100, type = 'item', image = 'consumable_haycube.png',             unique = false, useable = true, shouldClose = true, description = 'nice item' },
    bandage                        = { name = 'bandage',                        label = 'Bandage', weight = 100, type = 'item', image = 'bandage.png',                        unique = false, useable = true, shouldClose = true, description = 'nice item' },
    bread                          = { name = 'bread',                          label = 'Bread', weight = 100, type = 'item', image = 'bread.png',                          unique = false, useable = true, shouldClose = true, description = 'nice item' },
    consumable_chocolate           = { name = 'consumable_chocolate',           label = 'Chocolate', weight = 100, type = 'item', image = 'consumable_chocolate.png',           unique = false, useable = true, shouldClose = true, description = 'nice item' },
    snackplate                     = { name = 'snackplate',                     label = 'Snack Plate', weight = 100, type = 'item', image = 'snackplate.png',                     unique = false, useable = true, shouldClose = true, description = 'nice item' },
    cheese                         = { name = 'cheese',                         label = 'Cheese', weight = 100, type = 'item', image = 'cheese.png',                         unique = false, useable = true, shouldClose = true, description = 'nice item' },
    fruitcake                      = { name = 'fruitcake',                      label = 'Fruit Cake', weight = 100, type = 'item', image = 'fruitcake.png',                      unique = false, useable = true, shouldClose = true, description = 'nice item' },
    chocolatecake                  = { name = 'chocolatecake',                  label = 'Chocolate Cake', weight = 100, type = 'item', image = 'chocolatecake.png',                  unique = false, useable = true, shouldClose = true, description = 'nice item' },
    cookie                         = { name = 'cookie',                         label = 'Cookie', weight = 100, type = 'item', image = 'cookie.png',                         unique = false, useable = true, shouldClose = true, description = 'nice item' },
    consumable_kidneybeans_can     = { name = 'consumable_kidneybeans_can',     label = 'Kidneybeans', weight = 100, type = 'item', image = 'consumable_kidneybeans_can.png',     unique = false, useable = true, shouldClose = true, description = 'nice item' },
    fruitplate                     = { name = 'fruitplate',                     label = 'Fruit Plate', weight = 100, type = 'item', image = 'fruitplate.png',                     unique = false, useable = true, shouldClose = true, description = 'nice item' },
    lobster                        = { name = 'lobster',                        label = 'Lobster', weight = 100, type = 'item', image = 'lobster.png',                        unique = false, useable = true, shouldClose = true, description = 'nice item' },
    oyster                         = { name = 'oyster',                         label = 'Oyster', weight = 100, type = 'item', image = 'oyster.png',                         unique = false, useable = true, shouldClose = true, description = 'nice item' },
    water                          = { name = 'water',                          label = 'Water', weight = 100, type = 'item', image = 'water.png',                          unique = false, useable = true, shouldClose = true, description = 'nice item' },
    coffe                          = { name = 'coffe',                          label = 'Coffe', weight = 100, type = 'item', image = 'coffe.png',                          unique = false, useable = true, shouldClose = true, description = 'nice item' },
    chamomiletea                   = { name = 'chamomiletea',                   label = 'Chamomiletea', weight = 100, type = 'item', image = 'chamomiletea.png',                   unique = false, useable = true, shouldClose = true, description = 'nice item' },
    beer                           = { name = 'beer',                           label = 'Beer', weight = 100, type = 'item', image = 'beer.png',                           unique = false, useable = true, shouldClose = true, description = 'nice item' },
    liquor                         = { name = 'liquor',                         label = 'Liquor', weight = 100, type = 'item', image = 'liquor.png',                         unique = false, useable = true, shouldClose = true, description = 'nice item' },
    gin                            = { name = 'gin',                            label = 'Gin', weight = 100, type = 'item', image = 'gin.png',                            unique = false, useable = true, shouldClose = true, description = 'nice item' },
    wine                           = { name = 'wine',                           label = 'Wine', weight = 100, type = 'item', image = 'wine.png',                           unique = false, useable = true, shouldClose = true, description = 'nice item' },
    whisky                         = { name = 'whisky',                         label = 'Whisky', weight = 100, type = 'item', image = 'whisky.png',                         unique = false, useable = true, shouldClose = true, description = 'nice item' },
    honeywhisky                    = { name = 'honeywhisky',                    label = 'Honey Whisky', weight = 100, type = 'item', image = 'honeywhisky.png',                    unique = false, useable = true, shouldClose = true, description = 'nice item' },
    cigarette                      = { name = 'cigarette',                      label = 'Cigarette', weight = 100, type = 'item', image = 'cigarette.png',                      unique = false, useable = true, shouldClose = true, description = 'nice item' },
    cigar                          = { name = 'cigar',                          label = 'Cigar', weight = 100, type = 'item', image = 'cigar.png',                          unique = false, useable = true, shouldClose = true, description = 'nice item' },
    adrenaline                     = { name = 'adrenaline',                     label = 'Adrenalin', weight = 100, type = 'item', image = 'adrenaline.png',                     unique = false, useable = true, shouldClose = true, description = 'nice item' },
    horseadrenaline                = { name = 'horseadrenaline',                label = 'Horse Adrenalin', weight = 100, type = 'item', image = 'horseadrenaline.png',                unique = false, useable = true, shouldClose = true, description = 'nice item' },
    horsebrush                     = { name = 'horsebrush',                     label = 'Horse Brush', weight = 100, type = 'item', image = 'horsebrush.png',                     unique = false, useable = true, shouldClose = true, description = 'nice item' },
    armor                     = { name = 'armor',                     label = 'Armour', weight = 100, type = 'item', image = 'armor.png',                     unique = false, useable = true,shouldClose = true, description = 'nice item' },
```


- RSG-Core/client/loops.lua (Delete Code or Close)
```lua
CreateThread(function()
    while true do
        if LocalPlayer.state.isLoggedIn then
            if (RSGCore.PlayerData.metadata['hunger'] <= 0 or RSGCore.PlayerData.metadata['thirst'] <= 0) and not RSGCore.PlayerData.metadata['isdead'] then
                local ped = PlayerPedId()
                local currentHealth = GetEntityHealth(ped)
                local decreaseThreshold = math.random(5, 10)
                SetEntityHealth(ped, currentHealth - decreaseThreshold)
            end
        end
        Wait(RSGCore.Config.StatusInterval)
    end
end)
```

### change code rsg-core/server/events.lua
```lua
RegisterNetEvent('RSGCore:Server:SetMetaData', function(meta, data)
    local src = source
    local Player = RSGCore.Functions.GetPlayer(src)
    if not Player then return end
    if meta == 'hunger' or meta == 'thirst' or meta == 'cleanliness' then
        if data > 100 then
            data = 100
        end
    end
    Player.Functions.SetMetaData(meta, data)
    TriggerClientEvent('fx-hud:client:UpdateNeeds', src, Player.PlayerData.metadata['hunger'], Player.PlayerData.metadata['thirst'])
end)

```
- RSG-Core/server/player.lua Change 
```lua
function self.Functions.AddMoney(moneytype, amount, reason, showhud)
        reason = reason or "unknown"
        if showhud == nil then showhud = true end
        moneytype = moneytype:lower()
        amount = tonumber(amount)
        if amount < 0 then
            return
        end
        if not self.PlayerData.money[moneytype] then
            return false
        end
        self.PlayerData.money[moneytype] = self.PlayerData.money[moneytype] + amount

        if not self.Offline then
            self.Functions.UpdatePlayerData()
            if amount > 100000 then
                TriggerEvent(
                    "rsg-log:server:CreateLog",
                    "playermoney",
                    "AddMoney",
                    "lightgreen",
                    "**"
                        .. GetPlayerName(self.PlayerData.source)
                        .. " (citizenid: "
                        .. self.PlayerData.citizenid
                        .. " | id: "
                        .. self.PlayerData.source
                        .. ")** $"
                        .. amount
                        .. " ("
                        .. moneytype
                        .. ") added, new "
                        .. moneytype
                        .. " balance: "
                        .. self.PlayerData.money[moneytype]
                        .. " reason: "
                        .. reason,
                    true
                )
            else
                TriggerEvent(
                    "rsg-log:server:CreateLog",
                    "playermoney",
                    "AddMoney",
                    "lightgreen",
                    "**"
                        .. GetPlayerName(self.PlayerData.source)
                        .. " (citizenid: "
                        .. self.PlayerData.citizenid
                        .. " | id: "
                        .. self.PlayerData.source
                        .. ")** $"
                        .. amount
                        .. " ("
                        .. moneytype
                        .. ") added, new "
                        .. moneytype
                        .. " balance: "
                        .. self.PlayerData.money[moneytype]
                        .. " reason: "
                        .. reason
                )
            end
            if showhud then TriggerClientEvent("hud:client:OnMoneyChange", self.PlayerData.source, moneytype, amount, false) end
            TriggerClientEvent("RSGCore:Client:OnMoneyChange", self.PlayerData.source, moneytype, amount, "add", reason)
            TriggerEvent("RSGCore:Server:OnMoneyChange", self.PlayerData.source, moneytype, amount, "add", reason)

            TriggerClientEvent('vorp:updateUi',self.PlayerData.source,json.encode({
                moneyquanty = self.PlayerData.money["cash"],
                goldquanty = self.PlayerData.money["bank"]
            }))
        end

        return true
    end

    function self.Functions.RemoveMoney(moneytype, amount, reason, showhud)
        reason = reason or "unknown"
        if showhud == nil then showhud = true end
        moneytype = moneytype:lower()
        amount = tonumber(amount)
        if amount < 0 then
            return
        end
        if not self.PlayerData.money[moneytype] then
            return false
        end
        for _, mtype in pairs(RSGCore.Config.Money.DontAllowMinus) do
            if mtype == moneytype then
                if (self.PlayerData.money[moneytype] - amount) < 0 then
                    return false
                end
            end
        end
        self.PlayerData.money[moneytype] = self.PlayerData.money[moneytype] - amount

        if not self.Offline then
            self.Functions.UpdatePlayerData()
            if amount > 100000 then
                TriggerEvent(
                    "rsg-log:server:CreateLog",
                    "playermoney",
                    "RemoveMoney",
                    "red",
                    "**"
                        .. GetPlayerName(self.PlayerData.source)
                        .. " (citizenid: "
                        .. self.PlayerData.citizenid
                        .. " | id: "
                        .. self.PlayerData.source
                        .. ")** $"
                        .. amount
                        .. " ("
                        .. moneytype
                        .. ") removed, new "
                        .. moneytype
                        .. " balance: "
                        .. self.PlayerData.money[moneytype]
                        .. " reason: "
                        .. reason,
                    true
                )
            else
                TriggerEvent(
                    "rsg-log:server:CreateLog",
                    "playermoney",
                    "RemoveMoney",
                    "red",
                    "**"
                        .. GetPlayerName(self.PlayerData.source)
                        .. " (citizenid: "
                        .. self.PlayerData.citizenid
                        .. " | id: "
                        .. self.PlayerData.source
                        .. ")** $"
                        .. amount
                        .. " ("
                        .. moneytype
                        .. ") removed, new "
                        .. moneytype
                        .. " balance: "
                        .. self.PlayerData.money[moneytype]
                        .. " reason: "
                        .. reason
                )
            end
            if showhud then TriggerClientEvent("hud:client:OnMoneyChange", self.PlayerData.source, moneytype, amount, true) end
            TriggerClientEvent("RSGCore:Client:OnMoneyChange", self.PlayerData.source, moneytype, amount, "remove", reason)
            TriggerEvent("RSGCore:Server:OnMoneyChange", self.PlayerData.source, moneytype, amount, "remove", reason)
            TriggerClientEvent('vorp:updateUi',self.PlayerData.source,json.encode({
                moneyquanty = self.PlayerData.money["cash"],
                goldquanty = self.PlayerData.money["bank"]
            }))
        end

        return true
    end

    function self.Functions.SetMoney(moneytype, amount, reason)
        reason = reason or "unknown"
        moneytype = moneytype:lower()
        amount = tonumber(amount)
        if amount < 0 then
            return false
        end
        if not self.PlayerData.money[moneytype] then
            return false
        end
        local difference = amount - self.PlayerData.money[moneytype]
        self.PlayerData.money[moneytype] = amount

        if not self.Offline then
            self.Functions.UpdatePlayerData()
            TriggerEvent(
                "rsg-log:server:CreateLog",
                "playermoney",
                "SetMoney",
                "green",
                "**"
                    .. GetPlayerName(self.PlayerData.source)
                    .. " (citizenid: "
                    .. self.PlayerData.citizenid
                    .. " | id: "
                    .. self.PlayerData.source
                    .. ")** $"
                    .. amount
                    .. " ("
                    .. moneytype
                    .. ") set, new "
                    .. moneytype
                    .. " balance: "
                    .. self.PlayerData.money[moneytype]
                    .. " reason: "
                    .. reason
            )
            TriggerClientEvent(
                "hud:client:OnMoneyChange",
                self.PlayerData.source,
                moneytype,
                math.abs(difference),
                difference < 0
            )
            TriggerClientEvent("RSGCore:Client:OnMoneyChange", self.PlayerData.source, moneytype, amount, "set", reason)
            TriggerEvent("RSGCore:Server:OnMoneyChange", self.PlayerData.source, moneytype, amount, "set", reason)
            TriggerClientEvent('vorp:updateUi',self.PlayerData.source,json.encode({
                moneyquanty = self.PlayerData.money["cash"],
                goldquanty = self.PlayerData.money["bank"]
            }))
        end

        return true
    end
```