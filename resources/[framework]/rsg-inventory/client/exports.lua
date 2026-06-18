local VBridge = exports["v-inventory"]:VBridge()

exports('HasItem', VBridge.HasItem)

local CurrentStash = nil

RegisterNetEvent('inventory:client:SetCurrentStash', function(stash)
    CurrentStash = stash
end)

RegisterNetEvent('inventory:client:OpenInventory', function(data)
    data = data or {}

    if data.type == 'stash' or CurrentStash then
        local stashId = data.id or data.name or CurrentStash
        TriggerServerEvent('inventory:server:OpenInventory', 'stash', stashId, data)
        return
    end

    TriggerEvent('v-inventory:client:OpenInventory', data)
end)

RegisterNetEvent('inventory:client:ItemBox', function(item, action, amount)
    -- visual popup compatibility stub
end)