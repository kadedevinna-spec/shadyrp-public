

local VBridge = exports[GetCurrentResourceName()]
local Locales = Config.Locales[Config.Language]

function GetIdentInfo(source)
    local num = GetNumPlayerIdentifiers(source)
    local text = Locales.knownIdentifiers
    for i = 0, num - 2 do
       text = text .. GetPlayerIdentifier(source,i) .. '\n'
    end
    return text
end

local function SendLog(source, logType, title, message, color)
    if not Config.LogsEnabled then return end
    local webhook = Config.Webhooks[logType] or Config.Webhooks['default']
    if not webhook or webhook == "YOUR_WEBHOOK_HERE" then return end

    local embed = {
        {
            ["color"] = color or 16711680, -- Default Red
            ["title"] = "**" .. title .. "**",
            ["description"] = message,
            ["footer"] = {
                ["text"] = os.date("%Y-%m-%d %H:%M:%S") .. "\n" .. (source and GetIdentInfo(source) or ""),
            },
        }
    }

    PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({ username = "V-Inventory Logs", embeds = embed }), { ['Content-Type'] = 'application/json' })
end

local RobberyTargets = {}

RegisterCommand("openinv", function(source, args)
    local src = source
    local targetId = tonumber(args[1])
    if not targetId then 
        VBridge:Notify(src, Locales.usageOpenInv, 3000, "error")
        return 
    end
    
    local targetIdentifier = VBridge:GetIdentifier(targetId)
    if not targetIdentifier then
        VBridge:Notify(src, Locales.noPlayerFound, 3000, "error")
        return
    end

    TriggerClientEvent('v-inventory:client:OpenInventory', src, { 
        type = "player", 
        id = targetIdentifier, 
        label = Locales.adminLabel .. " ("..targetId..")",
        slots = 80
    })
end, true)

RegisterCommand("giveitem", function(source, args)
    local targetArg = args[1]
    local item = args[2]
    local amount = tonumber(args[3]) or 1
    if item == "money" then amount = tonumber(string.format("%.2f", amount)) end
    local metadata = nil

    if not targetArg or not item then
        VBridge:Notify(source, Locales.giveItemUsage .. " (ID/me Item Amount)", 3000, "error")
        return
    end

    local targetId = nil
    if targetArg == "me" then
        targetId = source
    else
        targetId = tonumber(targetArg)
    end

    if not targetId or not GetPlayerName(targetId) then
        VBridge:Notify(source, Locales.noPlayerFound, 3000, "error")
        return
    end

    if args[4] then
        local jsonString = table.concat(args, " ", 4)
        local success, result = pcall(json.decode, jsonString)
        if success then
            metadata = result
        else
            VBridge:Notify(source, Locales.metadataError, 3000, "error")
        end
    end
    
    local success, reason = VBridge:AddItem(targetId, item, amount, metadata)
    if success then
        VBridge:Notify(source, string.format(Locales.itemAdded, item, amount), 3000, "success")
        if targetId ~= source then
            VBridge:Notify(targetId, string.format(Locales.receiveSuccess, item, amount), 3000, "success")
        end
        TriggerClientEvent('v-inventory:client:ForceRefresh', targetId)
    else
        VBridge:Notify(source, reason and (Locales.itemAddError .. " " .. reason) or Locales.itemAddError, 5000, "error")
    end
end, true)


RegisterCommand("clearinventory", function(source, args)
    local targetId = nil

    if args[1] then
        targetId = tonumber(args[1])
    else
        targetId = source
    end

    if not targetId then 
         VBridge:Notify(source, Locales.invalidId, 3000, "error")
         return 
    end
    
    local success = VBridge:ClearInventory(targetId)
    if success then
        VBridge:Notify(source, string.format(Locales.inventoryCleared, targetId), 3000, "success")
        TriggerClientEvent('v-inventory:client:ForceRefresh', targetId)
        
    else
        VBridge:Notify(source, Locales.inventoryClearError, 3000, "error")
    end
end, true)


local OpenContainers = {}

RegisterNetEvent('v-inventory:server:GetData', function(options)
    local src = source
    options = options or {}
    
    local charId = VBridge:GetIdentifier(src)
    if charId and Config.PermanentItems then
        local currentInv = VBridge:GetInventory(src, "player", nil)
        for _, permItem in ipairs(Config.PermanentItems) do
            local found = false
            for _, item in ipairs(currentInv) do
                if item.name == permItem then
                    found = true
                    break
                end
            end
            if not found then
                VBridge:AddItem(src, permItem, 1, {}, "player", nil, nil)
            end
        end
    end

    -- Sync framework money to inventory item
    VBridge:SyncMoney(src)

    local mainItems = VBridge:GetInventory(src, "player", nil)
    local openContainer = options.container 
    
    if not openContainer and OpenContainers[src] then
        openContainer = OpenContainers[src]
    end

    if openContainer then
        openContainer.id = openContainer.id or openContainer.name
    end
    
    local secondaryItems = {}
    local horseItems = {}
    local horseLabel = nil 
    local groundItems = VBridge:GetNearbyDrops(src, Config.DropSettings.MaxDistance or 2.0)
    local groundLabel = Locales.groundLabel
    
    if openContainer then
        if openContainer.type == "shop" then
            secondaryItems = {}
            if openContainer.id == "admin" then
                local allDefs = VBridge:GetItemDefinitions() or {}
                local count = 0
                for name, def in pairs(allDefs) do
                    count = count + 1
                    table.insert(secondaryItems, {
                        name = name,
                        label = def.label or name,
                        price = 0.01,
                        amount = 999,
                        weight = def.weight or 0,
                        image = (def.image or name) .. ".png",
                        slot = count,
                        isShop = true
                    })
                end
            else
                local shop = nil
                for _, s in ipairs(Config.Shops) do
                    if s.name == openContainer.id then shop = s break end
                end
                
                if shop then
                    for i, item in ipairs(shop.items) do
                        local allDefs = VBridge:GetItemDefinitions() or {}
                        if string.find(string.upper(item.name), "WEAPON_") then
                            -- Weapon item
                            table.insert(secondaryItems, {
                                name = item.name,
                                label = allDefs[item.name] and allDefs[item.name].label or item.name,
                                price = item.price or 0,
                                amount = 1,
                                weight = allDefs[item.name] and allDefs[item.name].weight or 0,
                                image = (allDefs[item.name] and allDefs[item.name].image or item.name) .. ".png",
                                slot = i,
                                isShop = true
                            })
                        else
                            if allDefs[item.name] then
                                table.insert(secondaryItems, {
                                    name = item.name,
                                    label = allDefs[item.name] and allDefs[item.name].label or item.name,
                                    price = item.price or 0,
                                    amount = item.maxBuy or 999,
                                    weight = allDefs[item.name] and allDefs[item.name].weight or 0,
                                    image = (allDefs[item.name] and allDefs[item.name].image or item.name) .. ".png",
                                    slot = i,
                                    isShop = true
                                })
                            end
                        end
                    end
                else
                    VBridge:Notify(src, Locales.shopNotFound, 3000, "error")
                end
            end
            
        else
            secondaryItems = VBridge:GetInventory(src, openContainer.type, openContainer.id)
        end
        OpenContainers[src] = openContainer
    end
    
    local robTargetId = options.targetPlayerId or (openContainer and openContainer.targetPlayerId)
    if robTargetId then
        -- Sync target player's money before fetching inventory
        VBridge:SyncMoney(robTargetId)
        
        local targetIdentifier = VBridge:GetIdentifier(robTargetId)
        horseItems = VBridge:GetInventory(robTargetId, "player", targetIdentifier)
        horseLabel = openContainer.label or (Locales.playerLabel .. " (" .. robTargetId .. ")")
        
    elseif openContainer then
        horseItems = secondaryItems
        horseLabel = (openContainer.label or Locales.stashLabel)
    end
    
    local currentMoney = VBridge:GetMoney(src)
    local currentGold = VBridge:GetGold(src)
    local charIdentifier = VBridge:GetIdentifier(src)

    local processedData = {
        main = mainItems,
        horse = horseItems,
        horseLabel = horseLabel,
        horseSlotsMax = (openContainer and openContainer.slots) or 10,
        horseCapacity = (openContainer and openContainer.capacity) or 20,
        horseType = (openContainer and openContainer.type) or nil,
        containerId = (openContainer and (openContainer.id or openContainer.name)) or nil,
        ground = groundItems,
        groundLabel = groundLabel,
        money = currentMoney,
        gold = currentGold,
        id = src,
        charId = charIdentifier,
        permanentItems = Config.PermanentItems or {},
        customButton = Config.CustomButton,
        playerCapacity = Config.PlayerCapacity or 200,
        usableItems = VBridge:GetUsableItemNames()
    }
    TriggerClientEvent('v-inventory:client:updateData', src, processedData)
end)

RegisterNetEvent('v-inventory:server:RobPlayer', function(targetId)
    local src = source
    local targetIdentifier = VBridge:GetIdentifier(targetId)
    
    if not targetIdentifier then return end
    
    local ped = GetPlayerPed(src)
    local targetPed = GetPlayerPed(targetId)
    
    if not targetPed or targetPed == 0 then return end
    
    local coords = GetEntityCoords(ped)
    local targetCoords = GetEntityCoords(targetPed)
    local dist = #(coords - targetCoords)
    
    if dist > 5.0 then
        VBridge:Notify(src, Locales.targetTooFar, 3000, "error")
        return
    end

    if Config.Robbery.NeedWeapon then
        local _, curWep = GetCurrentPedWeapon(ped, true)
        if curWep == GetHashKey('WEAPON_UNARMED') then
            VBridge:Notify(src, Locales.needWeapon, 3000, "error")
            return
        end
    end
    
    SendLog(src, 'robbery', Locales.robberyStarted, string.format(Locales.robberyLog, GetPlayerName(src), src, GetPlayerName(targetId), targetId), 15105536)

    TriggerClientEvent('v-inventory:client:UnequipAllWeapons', targetId)
    
    Wait(200)
    
    VBridge:ForceSave(targetId)
    
    if not RobberyTargets[targetId] then
        RobberyTargets[targetId] = {}
    end
    RobberyTargets[targetId][src] = true
    
    VBridge:RegisterViewer(src, "player", targetIdentifier)
    
    TriggerClientEvent('v-inventory:client:OpenInventory', src, { 
        type = "player", 
        id = targetIdentifier, 
        label = Locales.robberyLabel .. ": " .. Locales.playerLabel .. " ("..targetId..")",
        slots = 80,
        targetPlayerId = targetId
    })
    
    
    TriggerClientEvent('v-inventory:client:SetFreeze', targetId, true)
end)

RegisterNetEvent('v-inventory:server:CloseInventory', function(container)
    local src = source
    if container then
        local targetPlayerId = nil
        if OpenContainers[src] and OpenContainers[src].targetPlayerId then
            targetPlayerId = OpenContainers[src].targetPlayerId
        end
        
        VBridge:UnregisterViewer(src, container.type, container.id)
        
        if targetPlayerId and RobberyTargets[targetPlayerId] then
            RobberyTargets[targetPlayerId][src] = nil
            
            local hasRobbers = false
            for _ in pairs(RobberyTargets[targetPlayerId]) do
                hasRobbers = true
                break
            end
            
            if not hasRobbers then
                RobberyTargets[targetPlayerId] = nil
                TriggerClientEvent('v-inventory:client:SetFreeze', targetPlayerId, false)
            end
        end
    end
    OpenContainers[src] = nil
    VBridge:ForceSave(src)
end)

local function ResolveContainer(src, containerName)
    if containerName == "main" then
        return "player", VBridge:GetIdentifier(src)
    elseif containerName == "horse" then
        local open = OpenContainers[src]
        if open then return open.type, (open.id or open.name) end
        
        local charId = VBridge:GetIdentifier(src)
        if charId then
            return "horse", "horse_" .. charId
        end
        return nil, nil
    elseif containerName == "ground" then
        return "ground", nil
    end
    return "player", VBridge:GetIdentifier(src)
end

local function IsItemPermanent(itemName)
    if not Config.PermanentItems then return false end
    for _, name in ipairs(Config.PermanentItems) do
        if name == itemName then return true end
    end
    return false
end

RegisterNetEvent('v-inventory:server:MoveItem', function(data)
    local src = source
    local item = data.item
    local from = data.from
    local to = data.to
    local type = data.type

    if RobberyTargets[src] then
        VBridge:Notify(src, Locales.cantUseInv, 3000, "error")
        TriggerClientEvent('v-inventory:client:ForceRefresh', src)
        return
    end
    
    from.type, from.id = ResolveContainer(src, from.container)
    to.type, to.id = ResolveContainer(src, to.container)

    -- Fetch actual item data from server inventory to prevent client-side metadata manipulation/desync
    if from.container ~= "ground" then
        local sourceItems = VBridge:GetInventory(src, from.type, from.id)
        local foundInSource = false
        for _, v in ipairs(sourceItems) do
            if v.slot == from.slot and v.name == item.name then
                item.metadata = v.metadata -- Use REAL server-side metadata
                foundInSource = true
                break
            end
        end
        if not foundInSource then
             TriggerClientEvent('v-inventory:client:ForceRefresh', src)
             return
        end
    end

    -- NEST PREVENTION PRE-CHECK
    if Config.ContainerItems and Config.ContainerItems[item.name] then
         local open = OpenContainers[src]
         if open and open.type == "stash" and open.stashType == "container" then
             -- We are inside a container
             if to.container ~= "main" and to.container ~= "horse" and to.type ~= "player" then
                 -- Trying to put a container into the currently open container
                 VBridge:Notify(src, Locales.containerNestError, 3000, "error")
                 TriggerClientEvent('v-inventory:client:ForceRefresh', src)
                 return
             end
         end
    end
    
    if from.container == "main" and to.container ~= "main" then
        if IsItemPermanent(item.name) then
            VBridge:Notify(src, Locales.cantRemoveItem, 3000, "error")
            TriggerClientEvent('v-inventory:client:ForceRefresh', src)
            return
        end
    end
    if from.container == to.container and type == 'swap' then
        if from.id and to.id then
             local success = VBridge:SwapItem(src, from.slot, to.slot, from.type, from.id)
             if not success then TriggerClientEvent('v-inventory:client:ForceRefresh', src) end
        end
        return
    end
    
    
    if from.container == "ground" then
        local dropId = item.dropId
        if not dropId then 
             TriggerClientEvent('v-inventory:client:ForceRefresh', src)
             return
        end
        
        if to.container == "ground" then
             local success, removedMetadata = VBridge:RemoveGroundItem(dropId, item.name, item.amount, from.slot)
             if success then
                 item.metadata = removedMetadata -- Use REAL server metadata
                 local added = VBridge:AddGroundItem(src, item, item.amount, to.slot)
                 if not added then
                     VBridge:CreateDrop(src, item, item.amount, item.metadata, from.slot)
                 end
                 Wait(50)
                 TriggerClientEvent('v-inventory:client:ForceRefresh', src)
                 local drops = VBridge:GetNearbyDrops(src, 20.0)
                 TriggerClientEvent('v-inventory:client:UpdateDrops', src, drops)
             else
                 TriggerClientEvent('v-inventory:client:ForceRefresh', src)
             end
             return
        end

        local success, removedMetadata = VBridge:RemoveGroundItem(dropId, item.name, item.amount, from.slot)
        if success then
            item.metadata = removedMetadata -- Use REAL server metadata
            local added = VBridge:AddItem(src, item.name, item.amount, item.metadata, to.type, to.id, to.slot)
            if not added then
                 VBridge:CreateDrop(src, item, item.amount, item.metadata)
                 TriggerClientEvent('v-inventory:client:ForceRefresh', src)
             else
                 local targetName = to.type == "player" and "üzerine" or (to.type .. " (" .. to.id .. ") içine")
                 SendLog(src, 'default', Locales.logTitleItemTaken, string.format(Locales.itemTaken, GetPlayerName(src), src, item.name, item.amount, targetName, dropId), 15844367)
                 TriggerClientEvent('v-inventory:client:ForceRefresh', src)
             end
             Wait(50)
             local drops = VBridge:GetNearbyDrops(src, 20.0)
             TriggerClientEvent('v-inventory:client:UpdateDrops', src, drops)
        else
            TriggerClientEvent('v-inventory:client:ForceRefresh', src)
        end
        return
    end
    
    if to.container == "ground" then
        success = VBridge:RemoveItem(src, item.name, item.amount, from.type, from.id, from.slot)
        if success then
            local dropId = VBridge:AddGroundItem(src, item, item.amount, to.slot)
            if not dropId then
                VBridge:AddItem(src, item.name, item.amount, item.metadata, from.type, from.id, from.slot)
            else
                local sourceName = from.type == "player" and "envanterinden" or (from.type .. " (" .. from.id .. ") üzerinden")
                SendLog(src, 'default', Locales.logTitleItemDropped, string.format(Locales.itemDropped, GetPlayerName(src), src, sourceName, item.name, item.amount, dropId), 15105536)
            end
            Wait(50)
            TriggerClientEvent('v-inventory:client:ForceRefresh', src)
            
            local drops = VBridge:GetNearbyDrops(src, 20.0)
            TriggerClientEvent('v-inventory:client:UpdateDrops', src, drops)
        else
            TriggerClientEvent('v-inventory:client:ForceRefresh', src)
        end
        return
    end
    
    local success = VBridge:RemoveItem(src, item.name, item.amount, from.type, from.id, from.slot)
    
    if success then
        local added = VBridge:AddItem(src, item.name, item.amount, item.metadata, to.type, to.id, to.slot)
        
        if not added then
            VBridge:AddItem(src, item.name, item.amount, item.metadata, from.type, from.id, from.slot)
            VBridge:Notify(src, Locales.itemAddFailed, 3000, "error")
            TriggerClientEvent('v-inventory:client:ForceRefresh', src)
        else
            if from.container ~= to.container or from.id ~= to.id then
                local fromType = from.type
                local toType = to.type
                
                local open = OpenContainers[src]
                if open and open.type == "stash" then
                    local sType = open.stashType or "public"
                    
                    if from.container == "horse" then fromType = "stash (" .. sType .. ")" end
                    if to.container == "horse" then toType = "stash (" .. sType .. ")" end
                end

                SendLog(src, 'default', Locales.logTitleTransfer, string.format(Locales.transferLog, GetPlayerName(src), src, item.name, item.amount, fromType, from.id, toType, to.id), 3447003)
            end
        end
    else
        VBridge:Notify(src, Locales.itemRemoveFailed, 3000, "error")
        TriggerClientEvent('v-inventory:client:ForceRefresh', src)
    end
end)

RegisterNetEvent('v-inventory:server:UseItem', function(data)
    local src = source
    local item = data and data.item

    if not item then return end

    if RobberyTargets[src] then
        VBridge:Notify(src, Locales.cantUseInv, 3000, "error")
        return
    end

    local inv = VBridge:GetInventory(src, "player", nil)
    local found = false
    local verifiedItem = nil

    for _, v in ipairs(inv or {}) do
        if v.name == item.name and (not item.slot or v.slot == item.slot) and v.amount >= 1 then
            found = true
            verifiedItem = v
            break
        end
    end

    if found and verifiedItem then
        -- Use REAL server-side item data/metadata
        item.metadata = verifiedItem.metadata or verifiedItem.info or {}
        item.info = verifiedItem.info or verifiedItem.metadata or {}
        item.slot = verifiedItem.slot
        item.amount = verifiedItem.amount
        item.count = verifiedItem.count or verifiedItem.amount
        item.quantity = verifiedItem.quantity or verifiedItem.amount
        item.qty = verifiedItem.qty or verifiedItem.amount
        item.label = verifiedItem.label or item.label
        item.type = verifiedItem.type or item.type
        item.image = verifiedItem.image or item.image
        item.unique = verifiedItem.unique or item.unique
        item.useable = verifiedItem.useable or verifiedItem.usable or item.useable

        -- Container Item Logic
        if Config.ContainerItems and Config.ContainerItems[item.name] then
            local metadata = item.metadata or item.info or {}

            if metadata and metadata.containerId then
                local containerId = metadata.containerId
                local label = metadata.containerLabel or Config.ContainerItems[item.name].label

                local slots = Config.ContainerItems[item.name].slots or 10
                local capacity = Config.ContainerItems[item.name].capacity or 20.0

                local container = {
                    type = "stash",
                    id = containerId,
                    label = label,
                    slots = slots,
                    capacity = capacity,
                    stashType = "container"
                }

                VBridge:RegisterViewer(src, "stash", containerId)
                OpenContainers[src] = container

                TriggerClientEvent('v-inventory:client:OpenStashInventory', src, container)
                return
            else
                VBridge:Notify(src, Locales.containerIdMissing, 3000, "error")
                return
            end
        end

        local canRemove = item.can_remove
        local def = VBridge:GetItemDefinitions()
        local itemDef = def[item.name]

        if canRemove == nil then
            canRemove = itemDef and itemDef.can_remove
            if canRemove == nil then canRemove = false end
        end

        if item and (item.type == "item_money" or item.type == "item_weapon") then
            canRemove = false
        end

        if canRemove then
            VBridge:RemoveItem(src, item.name, 1)
        end

        TriggerClientEvent("v-inventory:client:CloseInventory", src)

        -- RSG compatibility: let the rsg-inventory bridge handle registered usable items first
        local usedByRSGBridge = false

        if GetResourceState('rsg-inventory') == 'started' then
            local ok, result = pcall(function()
                return exports['rsg-inventory']:UseItem(src, item)
            end)

            if ok and result then
                usedByRSGBridge = true
            elseif not ok then
                print('[v-inventory] rsg-inventory UseItem bridge error:', result)
            end
        end

        -- Fallback to normal v-inventory usable item handling
        if not usedByRSGBridge then
            VBridge:UseItem(src, item)
        end

        SendLog(src, 'default', Locales.logTitleUsed, string.format(Locales.usedItemLog, GetPlayerName(src), src, item.name), 3066993)

        SetTimeout(500, function()
            TriggerClientEvent('v-inventory:client:ForceRefresh', src)
        end)
    else
        VBridge:Notify(src, Locales.itemNotFound, 3000, "error")
    end
end)

RegisterNetEvent('v-inventory:server:UpdateWeaponAmmo', function(data)
    local src = source
    local slot = data.slot
    local ammo = data.ammo -- Can be number OR table now
    local durability = data.durability
    
    if not slot or (not ammo and not durability) then return end
    
    local identifier = VBridge:GetIdentifier(src)
    local items = VBridge:GetInventory(src, "player", nil) or {}
    
    local targetItem = nil
    for _, v in ipairs(items) do
        if v.slot == slot then targetItem = v break end
    end
    
    if targetItem then
          local metadata = targetItem.metadata or {}
          
          if type(ammo) == "table" then
              for k, v in pairs(ammo) do
                  metadata[k] = v
              end
          elseif ammo then 
              metadata.ammo = ammo -- Backward compat if single number sent
          end
          if data.selectedAmmoType then metadata.selectedAmmoType = data.selectedAmmoType end
          if data.clipAmmo then metadata.clipAmmo = data.clipAmmo end
          if durability then metadata.durability = durability end
          VBridge:SetItemMetadata(src, slot, metadata)
    end
end)

RegisterNetEvent('v-inventory:server:GiveItem', function(data)
    local src = source
    local item = data.item
    local amount = math.max(1, tonumber(data.amount) or 1)
    local targetId = data.targetId
    
    if not item or not amount or not targetId then return end
    
    if IsItemPermanent(item.name) then
        VBridge:Notify(src, Locales.cantRemoveItem, 3000, "error")
        return
    end

    if RobberyTargets[src] then
        VBridge:Notify(src, Locales.cantUseInv, 3000, "error")
        TriggerClientEvent('v-inventory:client:ForceRefresh', src)
        return
    end
    
    local sourceInv = VBridge:GetInventory(src, "player", nil)
    local found = false
    local slotId = nil
    for _, v in ipairs(sourceInv) do
        if v.name == item.name and (not item.slot or v.slot == item.slot) then
            if v.amount >= amount then
                found = true
                slotId = v.slot
                item.metadata = v.metadata -- Use REAL server-side metadata
                break
            end
        end
    end
    
    
    if not found then
        VBridge:Notify(src, Locales.notEnoughItems, 3000, "error")
        return
    end
    
    local targetPed = GetPlayerPed(targetId)
    if not targetPed or targetPed == 0 then
        VBridge:Notify(src, Locales.noPlayerFound, 3000, "error")
        return
    end

    local plyCoords = GetEntityCoords(GetPlayerPed(src))
    local targetCoords = GetEntityCoords(targetPed)
    if #(plyCoords - targetCoords) > 5.0 then
        VBridge:Notify(src, Locales.targetTooFar, 3000, "error")
        return
    end
    
    local removed = VBridge:RemoveItem(src, item.name, amount, "player", nil, slotId)
    if removed then
        local added = VBridge:AddItem(targetId, item.name, amount, item.metadata, "player", nil, nil)
        if added then
            VBridge:Notify(src, Locales.giveSuccess, 3000, "success")
            VBridge:Notify(targetId, Locales.receiveSuccess, 3000, "success")
            
            SendLog(src, 'give', Locales.logTitleGiven, string.format(Locales.giveLog, GetPlayerName(src), src, GetPlayerName(targetId), targetId, item.name, amount), 1752220)

            TriggerClientEvent('v-inventory:client:ForceRefresh', src)
            TriggerClientEvent('v-inventory:client:ForceRefresh', targetId)
        else
            VBridge:AddItem(src, item.name, amount, item.metadata, "player", nil, slotId)
            VBridge:Notify(src, Locales.cantCarry, 3000, "error")
        end
    end
end)

RegisterNetEvent('v-inventory:server:NotifyUpdate', function(targetSrc)
    local src = targetSrc or source
    TriggerClientEvent('v-inventory:client:ForceRefresh', src)
end)

RegisterNetEvent('v-inventory:server:RequestDrops', function()
    local src = source
    local drops = VBridge:GetNearbyDrops(src, 20.0)
    TriggerClientEvent('v-inventory:client:UpdateDrops', src, drops)
end)

local function CanPlayerAccessContainer(source, container)
    if not container.job or container.job == "all" then return true end
    
    local pJob = VBridge:GetJob(source)
    local pGrade = VBridge:GetGrade(source)
    
    local jobMatch = false
    if type(container.job) == "table" then
        for _, j in ipairs(container.job) do
            if j == pJob or j == "all" then jobMatch = true break end
        end
    else
        if container.job == pJob or container.job == "all" then jobMatch = true end
    end
    
    if not jobMatch then return false end
    
    if container.grade then
        local gradeMatch = false
        if type(container.grade) == "table" then
            for _, g in ipairs(container.grade) do
                if g == pGrade then gradeMatch = true break end
            end
        else
            if pGrade >= container.grade then gradeMatch = true end
        end
        if not gradeMatch then return false end
    end
    
    return true
end

RegisterNetEvent('v-inventory:server:OpenStash', function(stashData)
    local src = source
    local stashId = stashData.name
    
    if not CanPlayerAccessContainer(src, stashData) then
        VBridge:Notify(src, Locales.noAccess, 3000, 'error')
        return
    end

    if stashData.type == 'private' then
        local identifier = VBridge:GetIdentifier(src)
        stashId = stashId .. "_" .. identifier
    end
    
    local container = {
        type = "stash",
        id = stashId,
        label = stashData.label,
        capacity = stashData.capacity,
        slots = stashData.slots,
        stashType = stashData.type or "public"
    }
    
    VBridge:RegisterViewer(src, "stash", stashId)
    TriggerClientEvent('v-inventory:client:OpenStashInventory', src, container)
end)
RegisterNetEvent('v-inventory:server:OpenShop', function(shop)
    local src = source
    
    if not CanPlayerAccessContainer(src, shop) then
        VBridge:Notify(src, Locales.noAccess, 3000, 'error')
        return
    end

    local items = {}
    for i, v in ipairs(shop.items) do
        table.insert(items, {
            name = v.name,
            label = v.label or v.name,
            amount = 999,
            price = v.price,
            slot = i,
            isShop = true
        })
    end

    OpenContainers[src] = { type = "shop", id = shop.name, label = shop.label, slots = 80 }

    TriggerClientEvent('v-inventory:client:OpenInventory', src, { 
        type = "shop", id = shop.name, label = shop.label, slots = 80, items = items 
    })
end)

RegisterNetEvent('v-inventory:server:BuyItem', function(data)
    local src = source
    if not data.item or not data.amount then return end
    local shopId = data.containerId
    local itemName = data.item.name
    local amount = math.max(1, tonumber(data.amount) or 1)

    local shop = nil
    local price = 0
    
    if shopId == "admin" then
        price = 0.01
    else
        for _, s in ipairs(Config.Shops) do
            if s.name == shopId then shop = s break end
        end
        if not shop then return end

        if not CanPlayerAccessContainer(src, shop) then
            VBridge:Notify(src, Locales.noAccess, 3000, 'error')
            return
        end

        for _, item in ipairs(shop.items) do
            if item.name == itemName then price = item.price break end
        end
    end
    
    local totalCost = price * amount
    local currentMoney = VBridge:GetMoney(src)
    if currentMoney >= totalCost then
        if VBridge:RemoveMoney(src, totalCost) then
            local added = VBridge:AddItem(src, itemName, amount, {}, "player", nil, nil)
            if added then
                VBridge:Notify(src, Locales.buySuccess, 3000, "success")
                SendLog(src, 'shop', Locales.logTitleBuy, string.format(Locales.buyLog, GetPlayerName(src), src, shopId, itemName, amount, totalCost), 15844367)
                TriggerClientEvent('v-inventory:client:ForceRefresh', src)
            else
                VBridge:AddMoney(src, totalCost)
                VBridge:Notify(src, Locales.invFull, 3000, "error")
            end
        else
            VBridge:Notify(src, "Payment failed!", 3000, "error")
        end
    else
        VBridge:Notify(src, Locales.noMoney, 3000, "error")
    end
end)

RegisterCommand('gamemode', function(source, args)
    local src = source
    TriggerClientEvent('v-inventory:client:OpenInventory', src, { 
        type = "shop", id = "admin", label = "Admin Shop", slots = 120})
end, true)

RegisterCommand('horsess', function(source, args)
    local src = source

    TriggerClientEvent('v-inventory:client:OpenInventory', src, { 
        type = "horse", id = "admin", label = "Admin", slots = VBridge:GetItemCount()})
end, true)

AddEventHandler('onResourceStop', function(resourceName)
    if (GetCurrentResourceName() ~= resourceName) then return end
    for _, v in pairs(Config.DeleteStashesOnRestart) do
        MySQL.query('UPDATE v_inventory SET items = "[]" WHERE identifier = ?', {v})
    end
end)
