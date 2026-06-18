
local API = exports.tp_libs:getAPI()

-----------------------------------------------------------
--[[ Public Functions ]]--
-----------------------------------------------------------

function removeInventoryItem(source, item, quantity)
    local _source = source

    if API.getFramework() == 'rsg' or API.getFramework() == 'rsgv2' then

        local RSGAPI = exports['rsg-core']:GetCoreObject()

        if tonumber(item.unique) == 1 then

            local xPlayer = RSGAPI.Functions.GetPlayer(_source)
            xPlayer.Functions.RemoveItem(item.item, 1, item.itemId) -- item.slot

            if Config.Debug then 
                print('[RSG-21]: : xPlayer.Functions.RemoveItem - Executed [item: ' .. item.item .. ', itemId:' .. item.itemId .. ']')
            end
            
        else 
            API.removeItemFromInventory(_source, item.item, quantity, item.label)

            if Config.Debug then 
                print('[RSG-28]: : xPlayer.Functions.RemoveItem - Executed [item: ' .. item.item .. ', quantity:' .. quantity .. ']')
            end

        end

    elseif API.getFramework() == 'vorp' then

        local inventoryContents = API.getUserInventoryContents(_source)

        for k, v in pairs (inventoryContents) do

            if v.name == item.item then
    
                if tonumber(item.unique) == 1 then
    
                    exports.vorp_inventory:subItem(_source, item.item, quantity, v.metadata)

                    if Config.Debug then 
                        print('[VORP-46]: : exports.vorp_inventory:subItem - Executed [item: ' .. item.item .. ', quantity:' .. quantity .. ']')
                    end

                    break
                end
    
            end
    
        end

        API.removeItemFromInventory(_source, item.item, quantity, item.label)

        if Config.Debug then 
            print('[VORP-59]: : exports.vorp_inventory:subItem - Executed [item: ' .. item.item .. ', quantity:' .. quantity .. ']')
        end

    elseif API.getFramework() == 'tpzcore' then -- TPZCORE does not need any loops and checks, it has already a system through itemId.

        local TPZInv = exports.tpz_inventory:getInventoryAPI()
        TPZInv.removeItem(_source, item.item, tonumber(quantity), item.itemId)

        if Config.Debug then 
            print('[TPZ-CORE-68]: : TPZInv.removeItem - Executed [item: ' .. item.item .. ', itemId: ' .. item.itemId .. ', quantity:' .. quantity ..  ']')
        end

    end
end


function addItemToInventory(source, item, quantity)
    local _source = source

    if API.getFramework() == 'vorp' then

        exports.vorp_inventory:addItem(_source, item.item, tonumber(quantity), item.metadata)

        if Config.Debug then 
            print('[VORP-83]: : exports.vorp_inventory:addItem - Executed [item: ' .. item.item .. ', quantity:' .. quantity .. ']')
        end

    elseif API.getFramework() == 'rsg' then

        if tonumber(item.unique) == 1 then

            local RSGAPI  = exports['rsg-core']:GetCoreObject()
            local xPlayer = RSGAPI.Functions.GetPlayer(_source)
    
            local info = item.metadata
            xPlayer.Functions.AddItem(item.item, quantity, nil, info)

            if Config.Debug then 
                print('[RSG-97]: : xPlayer.Functions.AddItem - Executed [item: ' .. item.item .. ', quantity:' .. quantity .. ']')
            end

        else
            API.addItemToInventory(_source, item.item, quantity, item.label) 

            if Config.Debug then 
                print('[RSG-104]: : xPlayer.Functions.AddItem - Executed [item: ' .. item.item .. ', quantity:' .. quantity .. ']')
            end

        end

    elseif API.getFramework() == 'rsgv2' then

        if tonumber(item.unique) == 1 then

            local RSGAPI  = exports['rsg-core']:GetCoreObject()
            local xPlayer = RSGAPI.Functions.GetPlayer(_source)
    
            local info = item.metadata
            local success = xPlayer.Functions.AddItem(item.item, quantity, nil, info)

            if success then
                TriggerClientEvent('rsg-inventory:client:ItemBox', xPlayer, RSGAPI.Shared.Items[item.item].label, "add")

                if Config.Debug then 
                    print('[RSG-123]: : xPlayer.Functions.AddItem - Executed [item: ' .. item.item .. ', quantity:' .. quantity .. ']')
                end

            end

        else
            API.addItemToInventory(_source, item.item, quantity, item.label) 
            
            if Config.Debug then 
                print('[RSG-133]: : xPlayer.Functions.AddItem - Executed [item: ' .. item.item .. ', quantity:' .. quantity .. ']')
            end

        end   

    elseif API.getFramework() == "tpzcore" then 

        local TPZInv = exports.tpz_inventory:getInventoryAPI()
        TPZInv.addItem(_source, item.item, tonumber(quantity), item.metadata)

        if Config.Debug then 
            print('[TPZ-CORE-143]: : TPZInv.addItem - Executed [item: ' .. item.item .. ', quantity:' .. quantity .. ']')
        end

    end

end

function removeInventoryWeapon(source, item, quantity)
    local _source = source

    local exist = false
    local shouldLoopForRemoval = true

    if API.getFramework() == 'rsg' or API.getFramework() == 'rsgv2' then

        local RSGAPI  = exports['rsg-core']:GetCoreObject()
        local xPlayer = RSGAPI.Functions.GetPlayer(_source)

        xPlayer.Functions.RemoveItem(item.item, 1, item.itemId) -- item.slot

        if Config.Debug then 
            print('[RSG-164]: : xPlayer.Functions.RemoveItem - Executed [item: ' .. item.item .. ', itemId:' .. item.itemId .. ']')
        end

    elseif API.getFramework() == 'vorp' then

        if item == nil or item.itemId == nil then
            print("Failed to remove VORP weapon: missing weaponId")

        else
            
            exports.vorp_inventory:subWeapon(_source, tonumber(item.itemId), function(result)
                if result then
    
                else
                    print("Failed to a remove weapon with the id: " .. item.itemId)
                end
            end)

        end

        if Config.Debug then 
            print('[VORP-185]: : exports.vorp_inventory:subWeapon - Executed [item: ' .. item.item .. ', itemId:' .. item.itemId .. ']')
        end

    elseif API.getFramework() == 'tpzcore' then -- TPZCORE does not need any loops and checks, it has already a system through itemId.

        local TPZInv = exports.tpz_inventory:getInventoryAPI()
        TPZInv.removeWeapon(_source, item.item, item.itemId)

        if Config.Debug then 
            print('[TPZ-CORE-194]: : TPZInv.removeWeapon - Executed [item: ' .. item.item .. ', itemId:' .. item.itemId .. ']')
        end

    end
    
end

function addWeaponToInventory(source, item)
    local _source = source

    if API.getFramework() == 'vorp' then

        exports.vorp_inventory:giveWeapon(_source, tonumber(item.itemId))

        if Config.Debug then 
            print('[VORP-209]: : exports.vorp_inventory:giveWeapon - Executed [item: ' .. item.item .. ', itemId:' .. item.itemId .. ']')
        end

    elseif API.getFramework() == 'rsg' or API.getFramework() == 'rsgv2' then

        local RSGAPI  = exports['rsg-core']:GetCoreObject()
        
        local xPlayer = RSGAPI.Functions.GetPlayer(_source)
        xPlayer.Functions.AddItem(item.item, 1, nil, item.info) 

        if Config.Debug then 
            print('[RSG-220]: : xPlayer.Functions.AddItem - Executed [item: ' .. item.item .. ', itemId:? ]')
        end

    elseif API.getFramework() == 'redemrp' then

    elseif API.getFramework() == "tpzcore" then 

        local TPZInv = exports.tpz_inventory:getInventoryAPI()
        TPZInv.addWeapon(_source, string.upper(item.item), item.itemId, item.metadata)

        if Config.Debug then 
            print('[TPZ-CORE-231]: : TPZInv.addWeapon - Executed [item: ' .. item.item .. ', itemId:' .. item.itemId .. ']')
        end

    end

end