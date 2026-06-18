local RSGCore = nil
local currentFramework = nil
local PlayerData = {
    money = 0,
    gold = 0,
    job = nil,
    grade = nil,
    identifier = nil
}

CreateThread(function()
    Wait(2000)
    
    if not Config.Framework then
        if GetResourceState('rsg-core') == 'started' then
            Config.Framework = 'rsg-core'
        elseif GetResourceState('vorp_core') == 'started' or GetResourceState('vorp-core') == 'started' then
            Config.Framework = 'vorp'
        else
        end
    end
    
    if Config.Framework == 'rsg-core' then
        currentFramework = "rsg"
        RSGCore = exports['rsg-core'] and exports['rsg-core']:GetCoreObject() or nil
        if RSGCore then
        end
    elseif Config.Framework == 'vorp' then
        currentFramework = "vorp"
    else
    end
    
    UpdatePlayerData()
end)


local function GetFramework()
    return currentFramework
end

function UpdatePlayerData()
    if currentFramework == "vorp" then
        if LocalPlayer.state.Character then
            PlayerData.money = LocalPlayer.state.Character.Money or 0
            PlayerData.gold = LocalPlayer.state.Character.Gold or 0
            PlayerData.job = LocalPlayer.state.Character.Job
            PlayerData.grade = LocalPlayer.state.Character.Grade
            PlayerData.identifier = LocalPlayer.state.Character.charIdentifier
        end
    elseif currentFramework == "rsg" and RSGCore then
        local playerData = RSGCore.Functions.GetPlayerData()
        if playerData then
            PlayerData.money = playerData.money and playerData.money.cash or 0
            PlayerData.gold = playerData.money and playerData.money.gold or 0
            PlayerData.job = playerData.job and playerData.job.name
            PlayerData.grade = playerData.job and playerData.job.grade and playerData.job.grade.level
            PlayerData.identifier = playerData.citizenid
        end
    end
end

local function GetPlayerData()
    UpdatePlayerData()
    return PlayerData
end

local function GetMoney()
    UpdatePlayerData()
    return PlayerData.money or 0
end

local function GetGold()
    UpdatePlayerData()
    return PlayerData.gold or 0
end

local function GetJob()
    UpdatePlayerData()
    return PlayerData.job, PlayerData.grade
end

local function HasJob(jobName, grade)
    local job, jobGrade = GetJob()
    if not job or job ~= jobName then return false end
    
    if grade then
        return jobGrade == grade
    end
    
    return true
end


local function GetInventory()
    return exports[GetCurrentResourceName()]:getInventoryItems() or {}
end

local function HasItem(itemName, amount)
    if not itemName then return false end
    amount = amount or 1
    
    local inventory = GetInventory()
    for _, item in pairs(inventory) do
        if item.name == itemName then
            local count = item.count or item.amount or 0
            return count >= amount
        end
    end
    
    return false
end

local function GetItemCount(itemName)
    if not itemName then return 0 end
    
    local inventory = GetInventory()
    for _, item in pairs(inventory) do
        if item.name == itemName then
            return item.count or item.amount or 0
        end
    end
    
    return 0
end

local function GetAmmoDataForGroup(groupHash)
    if Config.AmmoItems then
        return Config.AmmoItems[groupHash]
    end
    return nil
end

local function GetAmmoKeyFromHash(groupHash, targetHash)
    local ammoData = GetAmmoDataForGroup(groupHash)
    if ammoData then
        for key, _ in pairs(ammoData) do
            if joaat(key) == targetHash then
                return key
            end
        end
    end
    return nil
end

local function Notify(message, duration, notifyType)
    if not message then return end
    duration = duration or 5000
    
    if currentFramework == "vorp" then
        TriggerEvent("vorp:TipBottom", message, duration)
    elseif currentFramework == "rsg" then
        local type = notifyType or 'inform'
        if notifyType == 'success' then
            type = 'success'
        elseif notifyType == 'error' then
            type = 'error'
        elseif notifyType == 'warning' then
            type = 'warning'
        else
            type = 'inform'
        end
        
        TriggerEvent('ox_lib:notify', {
            title = message,
            type = type,
            duration = duration
        })
    else
    end
end

local function EquipWeapon(item)
    if not item or not item.name then return false end
    local ped = PlayerPedId()
    local hash = joaat(item.name)
    
    if not IsWeaponValid(hash) then 
        return false 
    end

    -- Check durability before equipping
    local durability = (item.metadata and tonumber(item.metadata.durability))
    if durability ~= nil and durability <= 0 then
        Notify(Config.Locales[Config.Language].weaponBroken, 3000, "error")
        LocalPlayer.state:set('lastWeapon', nil, true)
        return false
    end

    local equippedData = LocalPlayer.state.equippedWeapon
    
    if equippedData and equippedData.slot then
        
        local oldHash = equippedData.hash
        local oldGroup = GetWeapontypeGroup(oldHash)
        local oldAmmoData = GetAmmoDataForGroup(oldGroup)
        local updates = {}
        if oldAmmoData then
             for ammoKey, _ in pairs(oldAmmoData) do
                  updates[ammoKey] = GetPedAmmoByType(ped, joaat(ammoKey))
             end
        end
        local _, oldClipAmmo = GetAmmoInClip(ped, oldHash)
        updates.clipAmmo = oldClipAmmo
        updates.selectedAmmoType = GetAmmoKeyFromHash(oldGroup, GetCurrentPedWeaponAmmoType(ped, GetPedWeaponObject(ped, 1)))
        TriggerServerEvent('v-inventory:server:UpdateWeaponAmmo', {
            slot = equippedData.slot,
            ammo = updates,
            clipAmmo = oldClipAmmo,
            selectedAmmoType = updates.selectedAmmoType
        })
        
        if hash == oldHash then
            -- Holstering the current weapon
            SetCurrentPedWeapon(ped, GetHashKey('WEAPON_UNARMED'), true)
            LocalPlayer.state:set('equippedWeapon', nil, true)
                if oldAmmoData then
                    for ammoKey, _ in pairs(oldAmmoData) do
                         local amt = GetPedAmmoByType(ped, joaat(ammoKey))
                         if amt > 0 then
                             RemoveAmmoFromPedByType(ped, joaat(ammoKey), amt, `REMOVE_REASON_DEBUG`)
                         end
                    end
                end
            return true
        end


        -- Swapping weapons, remove old ammo first
        if oldAmmoData then
            for ammoKey, _ in pairs(oldAmmoData) do
                 local amt = GetPedAmmoByType(ped, joaat(ammoKey))
                 if amt > 0 then
                     RemoveAmmoFromPedByType(ped, joaat(ammoKey), amt, `REMOVE_REASON_DEBUG`)
                 end
            end
        end

    end

    if hash then


        RemoveWeaponFromPed(ped, hash)
        GiveWeaponToPed(ped, hash, 0, true, true, 0, false, 0.5, 1.0, 0, false, 0.0, false)
        SetCurrentPedWeapon(ped, hash, true, 0, false, false)
        
        local group = GetWeapontypeGroup(hash)
        local ammoData = GetAmmoDataForGroup(group)
        
        if ammoData then
            -- Clear any residual ammo before loading
            for ammoKey, _ in pairs(ammoData) do
                 local leftovers = GetPedAmmoByType(ped, joaat(ammoKey))
                 if leftovers > 0 then
                     RemoveAmmoFromPedByType(ped, joaat(ammoKey), leftovers, `REMOVE_REASON_DEBUG`)
                 end
            end
            
            local metaClipAmmo = (item.metadata and tonumber(item.metadata.clipAmmo)) or 0
            
            -- Get the currently active ammo type for this weapon (defaults to normal usually)
            -- Now that we restored it, this should return our saved type
            local currentAmmoTypeHash = GetPedAmmoTypeFromWeapon(ped, hash)

            -- LOAD ALL CONFIGURED AMMO TYPES FOR THIS GROUP
            for ammoKey, _ in pairs(ammoData) do
                 local metaVal = (item.metadata and tonumber(item.metadata[ammoKey])) or 0
                 local ammoTypeHash = joaat(ammoKey)
                 
                 -- If this is the active ammo type, we must subtract the clip amount from the total
                 -- because SetAmmoInClip will add it back (causing duplication if we don't).
                 if ammoTypeHash == currentAmmoTypeHash and metaClipAmmo > 0 then
                     metaVal = math.max(0, metaVal - metaClipAmmo)
                 end
                 
                 SetPedAmmoByType(ped, ammoTypeHash, metaVal)
            end


            local savedAmmoType = item.metadata and item.metadata.selectedAmmoType
            if savedAmmoType then
                SetAmmoTypeForPedWeapon(ped, hash, joaat(savedAmmoType))
            end
            
            if metaClipAmmo > 0 then
                SetAmmoInClip(ped, hash, metaClipAmmo)
            end

        end

        TriggerServerEvent('syn_weapons:weaponused', {
            id = item.metadata and item.metadata.serial or nil,
            hash = item.name
        })  
        local serdata = {}
        serdata[hash] = item.info and item.info.serie or item.metadata and item.metadata.serial or nil
        LocalPlayer.state:set('equippedWeapon', {
            slot = item.slot,
            name = item.name,
            hash = hash,
            group = group,
            serial = serdata
        }, true)
        LocalPlayer.state:set('lastWeapon', {
            slot = item.slot,
            name = item.name,
            hash = hash,
            group = group,
            serial = serdata
        }, true)
        TriggerServerEvent("rsg-weaponcomp:server:check_comps")
    end
    
    return true
end

local function GetClosestPlayer(maxDist)
    local players = GetActivePlayers()
    local plyPed = PlayerPedId()
    local plyCoords = GetEntityCoords(plyPed)
    local closestPlayer = -1
    local closestDistance = maxDist or 3.0

    for _, player in ipairs(players) do
        local targetPed = GetPlayerPed(player)
        if targetPed ~= plyPed then
            local targetCoords = GetEntityCoords(targetPed)
            local distance = #(plyCoords - targetCoords)
            if distance < closestDistance then
                closestPlayer = player
                closestDistance = distance
            end
        end
    end

    return closestPlayer, closestDistance
end


if Config.Framework == 'rsg-core' then
    RegisterNetEvent('RSGCore:Client:OnPlayerLoaded', function()
        UpdatePlayerData()
    end)
    
    RegisterNetEvent('RSGCore:Player:SetPlayerData', function(val)
        if val.money then
            PlayerData.money = val.money.cash or 0
        end
        if val.job then
            PlayerData.job = val.job.name
            PlayerData.grade = val.job.grade.level
        end
    end)
    
    RegisterNetEvent('RSGCore:Client:OnMoneyChange', function()
        UpdatePlayerData()
    end)
end

if Config.Framework == 'vorp' then
    CreateThread(function()
        while true do
            Wait(1000)
            if LocalPlayer.state.Character then
                UpdatePlayerData()
            end
        end
    end)
end



-- Weapon Wheel Monitoring Loop
local LastUsedSlots = {}

CreateThread(function()
    local lastWeapon = nil
    while true do
        Wait(500)
        local ped = PlayerPedId()
        if not IsEntityDead(ped) then
            local _, currentHash = GetCurrentPedWeapon(ped, true)
            local equippedData = LocalPlayer.state.equippedWeapon

            -- Track Last Used Slot for current weapon if state matches
            if equippedData and equippedData.slot and equippedData.hash == currentHash then
                LastUsedSlots[currentHash] = equippedData.slot
            end
            
            -- If weapon changed
            if lastWeapon ~= currentHash then
                -- 1. Save Previous Weapon State
                if equippedData and equippedData.slot and equippedData.hash == lastWeapon then
                    local group = GetWeapontypeGroup(lastWeapon)
                    local ammoData = GetAmmoDataForGroup(group)
                    
                    local updates = {}
                    
                    if ammoData then
                        for ammoKey, _ in pairs(ammoData) do
                             updates[ammoKey] = GetPedAmmoByType(ped, joaat(ammoKey))
                        end
                    end
                    
                    
                    local _, clipAmmo = GetAmmoInClip(ped, lastWeapon)
                    updates.clipAmmo = clipAmmo
                    updates.selectedAmmoType = GetAmmoKeyFromHash(group, GetPedAmmoTypeFromWeapon(ped, lastWeapon))
                    
                    TriggerServerEvent('v-inventory:server:UpdateWeaponAmmo', {
                        slot = equippedData.slot,
                        ammo = updates,
                        clipAmmo = clipAmmo,
                        selectedAmmoType = updates.selectedAmmoType
                    })
                    
                     -- Update local cache immediately
                     local inventory = GetInventory()
                     for _, item in pairs(inventory) do
                         if item.slot == equippedData.slot then
                             item.metadata = item.metadata or {}
                             -- Merge updates
                             if ammoData then
                                 for k, v in pairs(updates) do item.metadata[k] = v end
                             end
                             item.metadata.clipAmmo = clipAmmo
                             break
                         end
                     end
                end

                -- 2. Load New Weapon State (if valid weapon)
                if currentHash ~= -1569615261 and currentHash ~= 0 then -- WEAPON_UNARMED
                    
                    local needLoad = true
                    if equippedData and equippedData.hash == currentHash then
                        needLoad = false
                    end

                    if needLoad then
                        local inventory = GetInventory()
                        local foundItem = nil
                        
                        -- Priority 1: Check LastUsedSlots
                        local preferredSlot = LastUsedSlots[currentHash]
                        if preferredSlot then
                            for _, item in pairs(inventory) do
                                if item.slot == preferredSlot and item.name and GetHashKey(item.name) == currentHash then
                                    foundItem = item
                                    break
                                end
                            end
                        end

                        -- Priority 2: Find first matching hash
                        if not foundItem then
                            for _, item in pairs(inventory) do
                                if item.name and GetHashKey(item.name) == currentHash then
                                    foundItem = item
                                    break 
                                end
                            end
                        end
                        
                        if foundItem then
                            -- Check durability before allowing weapon wheel equip
                            local wDurability = (foundItem.metadata and tonumber(foundItem.metadata.durability))
                            if wDurability ~= nil and wDurability <= 0 then
                                SetCurrentPedWeapon(ped, GetHashKey('WEAPON_UNARMED'), true)
                                LocalPlayer.state:set('equippedWeapon', nil, true)
                                Notify(Config.Locales[Config.Language].weaponBroken, 3000, "error")
                                LocalPlayer.state:set('lastWeapon', nil, true)
                            else
                            -- Apply Ammo
                            local group = GetWeapontypeGroup(currentHash)
                            local ammoData = GetAmmoDataForGroup(group)
                            
                            if ammoData then
                                local metaClipAmmo = (foundItem.metadata and tonumber(foundItem.metadata.clipAmmo)) or 0
                                local currentAmmoTypeHash = GetPedAmmoTypeFromWeapon(ped, currentHash)
                                
                                for ammoKey, _ in pairs(ammoData) do
                                     local metaVal = (foundItem.metadata and tonumber(foundItem.metadata[ammoKey])) or 0
                                     local ammoTypeHash = joaat(ammoKey)

                                     if ammoTypeHash == currentAmmoTypeHash and metaClipAmmo > 0 then
                                         metaVal = math.max(0, metaVal - metaClipAmmo)
                                     end

                                     SetPedAmmoByType(ped, ammoTypeHash, metaVal)
                                end
                                
                                SetAmmoInClip(ped, currentHash, metaClipAmmo)
                                
                                -- Update State
                                local supradata = {}
                                supradata[currentHash] = foundItem.info and foundItem.info.serie or foundItem.metadata and foundItem.metadata.serial or nil
                                LocalPlayer.state:set('equippedWeapon', {
                                    slot = foundItem.slot,
                                    name = foundItem.name,
                                    hash = currentHash,
                                    group = group,
                                    serial = supradata
                                }, true)
                                LocalPlayer.state:set('lastWeapon', {
                                    slot = foundItem.slot,
                                    name = foundItem.name,
                                    hash = currentHash,
                                    group = group,
                                    serial = supradata
                                }, true)
                                TriggerServerEvent("rsg-weaponcomp:server:check_comps")
                                -- Update LastUsed immediately
                                LastUsedSlots[currentHash] = foundItem.slot
                            end
                            end
                        else
                             -- Weapon not found in inventory. 
                             -- Could be a prop, scenario weapon, or cheated. 
                        end
                    end
                else
                    -- Switched to Unarmed
                    LocalPlayer.state:set('equippedWeapon', nil, true)
                end

                
                lastWeapon = currentHash
            end
        end
    end
end)

-- Durability Safety Check: every 1 second, if holding a broken weapon, force holster
CreateThread(function()
    while true do
        Wait(1000)
        local ped = PlayerPedId()
        if not IsEntityDead(ped) then
            local equipped = LocalPlayer.state.equippedWeapon
            if equipped and equipped.slot then
                local inventory = GetInventory()
                for _, item in pairs(inventory) do
                    if item.slot == equipped.slot then
                        local dur = (item.metadata and tonumber(item.metadata.durability))
                        if dur ~= nil and dur <= 0 then
                            SetCurrentPedWeapon(ped, GetHashKey('WEAPON_UNARMED'), true)
                            LocalPlayer.state:set('equippedWeapon', nil, true)
                            Notify(Config.Locales[Config.Language].weaponBroken, 3000, "error")
                            LocalPlayer.state:set('lastWeapon', nil, true)
                        end
                        break
                    end
                end
            end
        end
    end
end)

exports('GetFramework', GetFramework)
exports('GetPlayerData', GetPlayerData)
exports('GetMoney', GetMoney)
exports('GetGold', GetGold)
exports('GetJob', GetJob)
exports('HasJob', HasJob)
exports('GetInventory', GetInventory)
exports('HasItem', HasItem)
exports('GetItemCount', GetItemCount)
exports('Notify', Notify)
exports('EquipWeapon', EquipWeapon)
exports('GetClosestPlayer', GetClosestPlayer)

exports('getInventory', GetInventory)


VBridge = {
    GetFramework = GetFramework,
    GetPlayerData = GetPlayerData,
    GetMoney = GetMoney,
    GetGold = GetGold,
    GetJob = GetJob,
    HasJob = HasJob,
    GetInventory = GetInventory,
    HasItem = HasItem,
    GetItemCount = GetItemCount,
    Notify = Notify,
    EquipWeapon = EquipWeapon,
    GetClosestPlayer = GetClosestPlayer
}



RegisterNetEvent('v-inventory:client:UpdatePedAmmo', function(data)
    local ped = PlayerPedId()
    local equipped = LocalPlayer.state.equippedWeapon or LocalPlayer.state.lastWeapon
    
    if equipped and equipped.slot == data.slot then
        local hash = GetHashKey(data.name)
        
        -- If specific type update
        if data.ammoType then
            local typeHash = data.ammoType
            if type(typeHash) == "string" then
                typeHash = joaat(typeHash)
            end
            SetPedAmmoByType(ped, typeHash, data.ammo)
            
            -- If we were just refilled, update the clip logic if needed
            -- Usually SetPedAmmoByType updates reserve.
        else
            -- Fallback or full update?
            -- We expect ammoType now.
        end
    end
end)

exports('VBridge', function()
    return VBridge
end)