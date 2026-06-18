
local VBridge = exports[GetCurrentResourceName()]
local Locales = Config.Locales[Config.Language]

local isInventoryOpen = false


local currentContainer = nil
local cam = nil

local isRobbing = false

local function EnableCam()
    if not DoesCamExist(cam) then
        cam = CreateCam("DEFAULT_SCRIPTED_CAMERA", true)
    end
    local playerPed = PlayerPedId()
    local coords = GetEntityCoords(playerPed)
    local forward = GetEntityForwardVector(playerPed)
    local camCoords = GetOffsetFromEntityInWorldCoords(playerPed, 0.0, 2.5, 0.5)
    
    SetCamCoord(cam, camCoords.x, camCoords.y, camCoords.z - 0.5)
    PointCamAtEntity(cam, playerPed, 0.0, 0.0, 0.0, true)
    SetCamFov(cam, 50.0)
    SetCamActive(cam, true)
    RenderScriptCams(true, true, 500, true, true)
end

local function DisableCam()
    RenderScriptCams(false, true, 500, true, true)
    if DoesCamExist(cam) then
        DestroyCam(cam, false)
    end
    cam = nil
end

local function CloseInventory()
    Config.OpenOtherNuis()
    SetNuiFocus(false, false)
    DisableCam()
    if not isInventoryOpen then return end
    isInventoryOpen = false
    SendNUIMessage({ action = 'CLOSE' })
    if currentContainer then
        TriggerServerEvent("v-inventory:server:CloseInventory", currentContainer)
    end
    currentContainer = nil 
    ClearPedTasks(PlayerPedId())
end

RegisterNetEvent('v-inventory:client:CloseInventory', function()
    CloseInventory()
end)

local function canPlayCam(ped)
    if IsPedOnMount(ped) then return false end
    if IsEntityInAir(ped) then return false end
    if IsPedSwimming(ped) then return false end
    return true
end

local function OpenInventory(container)
    if IsEntityDead(PlayerPedId()) then return end

    if isInventoryOpen then return end
    isInventoryOpen = true
    currentContainer = container 
    
    if not container then
        if canPlayCam(PlayerPedId()) then
            EnableCam()
        end
    end
    
    Config.CloseOtherNuis()
    SetNuiFocus(true, true)
    SendNUIMessage({ 
        action = 'OPEN',
        locales = Config.Locales[Config.Language],
        showClothingMenu = Config.ShowClothingMenu
    })
    
    TriggerServerEvent('v-inventory:server:GetData', {
        container = currentContainer
    })
end

RegisterNetEvent('v-inventory:client:ForceRefresh', function()
    TriggerServerEvent('v-inventory:server:GetData', {
        container = currentContainer
    })
end)

RegisterNetEvent('v-inventory:client:OpenStash', function(id, label)
    OpenInventory({type="stash", id=id, label=label})
end)
exports('OpenStash', function(id, label)
    OpenInventory({type="stash", id=id, label=label})
end)

RegisterNetEvent('v-inventory:client:OpenStashInventory', function(container)
    OpenInventory(container)
end)

RegisterNetEvent('v-inventory:client:OpenInventory', function(container)
    OpenInventory(container)
end)

RegisterNUICallback('close', function(data, cb)
    CloseInventory()
    cb('ok')
end)

RegisterNUICallback('moveItem', function(data, cb)
    if not data.from.type then data.from.type = "player" end
    if not data.to.type then data.to.type = "player" end
    
    if currentContainer then
        if data.from.container == "ground" then
            data.from.type = currentContainer.type
            data.from.id = currentContainer.id
        elseif data.to.container == "ground" then
            data.to.type = currentContainer.type
            data.to.id = currentContainer.id
        end
    end
    
    
    TriggerServerEvent('v-inventory:server:MoveItem', data)
    cb('ok')
end)

local LocalInventoryCache = {}

local function InternalUseItem(item)
    if not item then return end

    -- Verify item is in player inventory
    local foundInInventory = false
    for _, v in ipairs(LocalInventoryCache) do
        if v.name == item.name and (not item.slot or v.slot == item.slot) then
            foundInInventory = true
            break
        end
    end

    if not foundInInventory then
        VBridge:Notify(Locales.itemNotFound, 3000, "error")
        return
    end

    if item.name and (string.find(string.upper(item.name), "WEAPON_") or item.type == "item_weapon") then
        if isRobbing then
            VBridge:Notify(Locales.cantUseInv, 3000, "error")
            return
        else
            exports[GetCurrentResourceName()]:EquipWeapon(item)
        end
    else
        TriggerServerEvent('v-inventory:server:UseItem', { item = item })
    end
end

RegisterNUICallback('useItem', function(data, cb)
    if data.item then
        InternalUseItem(data.item)
    end
    cb('ok')
end)

local GivePrompt
local CancelPrompt

local function SetupGivePrompts()
    local giveStr = VarString(10, 'LITERAL_STRING', Locales.givePrompt)
    GivePrompt = PromptRegisterBegin()
    PromptSetControlAction(GivePrompt, 0x760A9C6F) -- G
    PromptSetText(GivePrompt, giveStr)
    PromptSetEnabled(GivePrompt, false)
    PromptSetVisible(GivePrompt, false)
    PromptSetHoldMode(GivePrompt, true)
    PromptRegisterEnd(GivePrompt)

    local cancelStr = VarString(10, 'LITERAL_STRING', Locales.cancelPrompt)
    CancelPrompt = PromptRegisterBegin()
    PromptSetControlAction(CancelPrompt, 0x156F7119) -- Backspace / Cancel
    PromptSetText(CancelPrompt, cancelStr)
    PromptSetEnabled(CancelPrompt, true)
    PromptSetVisible(CancelPrompt, true)
    PromptRegisterEnd(CancelPrompt)
end

local function CleanupGivePrompts()
    if GivePrompt then PromptDelete(GivePrompt) GivePrompt = nil end
    if CancelPrompt then PromptDelete(CancelPrompt) CancelPrompt = nil end
end


local function RotationToDirection(rotation)
    local adjustedRotation = vector3((math.pi / 180) * rotation.x, (math.pi / 180) * rotation.y, (math.pi / 180) * rotation.z)
    local direction = vector3(-math.sin(adjustedRotation.z) * math.abs(math.cos(adjustedRotation.x)), math.cos(adjustedRotation.z) * math.abs(math.cos(adjustedRotation.x)), math.sin(adjustedRotation.x))
    return direction
end

local function GiveItemTargetingLoop(data)
    SetupGivePrompts()
    
    local itemData = data
    local choosing = true
    
    -- Ensure prompts are initialized
    Citizen.Wait(100)
    
    while choosing do
        local sleep = 5
        local playerPed = PlayerPedId()
        
        -- Cancel Check (Prompt + Manual Fallback)
        if PromptHasStandardModeCompleted(CancelPrompt) or IsControlJustPressed(0, 0x156F7119) then -- 0x156F7119 = INPUT_FRONTEND_CANCEL
            choosing = false
            CleanupGivePrompts()
            OpenInventory() 
            break
        end

        local closestTarget = nil
        
        -- Raycast Logic
        local cameraRotation = GetGameplayCamRot()
        local cameraCoord = GetGameplayCamCoord()
        local direction = RotationToDirection(cameraRotation)
        local destination =  cameraCoord + direction * 5.0

        local shapeTest = StartShapeTestRay(cameraCoord.x, cameraCoord.y, cameraCoord.z, destination.x, destination.y, destination.z, 8, playerPed, 0) -- 8 = Peds
        local _, hit, endCoords, surfaceNormal, entityHit = GetShapeTestResult(shapeTest)
        
        if hit > 0 and entityHit > 0 and IsEntityAPed(entityHit) and IsPedAPlayer(entityHit) then
             local targetPlayerId = NetworkGetPlayerIndexFromPed(entityHit)
             if targetPlayerId ~= -1 and targetPlayerId ~= PlayerId() then
                 closestTarget = targetPlayerId
             end
        end

        if closestTarget and not IsEntityDead(entityHit) then
            if tonumber(DoesEntityExist(entityHit)) == 1 then
                local tCoords = GetEntityCoords(entityHit)
                DrawMarker(0xD6445746, tCoords.x, tCoords.y, tCoords.z + 0.9, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.2, 0.2, 0.2, 255, 215, 0, 200, false, false, 2, false, nil, nil, false)
            end

            local amountToGive = tonumber(itemData.amount)
            if not amountToGive or amountToGive == 0 then
                amountToGive = itemData.item.amount
            end

            local label = VarString(10, 'LITERAL_STRING', Locales.givePrompt .. " (" .. itemData.item.label .. " x" .. amountToGive .. ")")
            PromptSetText(GivePrompt, label)
            PromptSetEnabled(GivePrompt, true)
            PromptSetVisible(GivePrompt, true)
            
            if PromptHasHoldModeCompleted(GivePrompt) then
                local targetServerId = GetPlayerServerId(closestTarget)
                data.targetId = targetServerId
                data.amount = amountToGive
                TriggerServerEvent('v-inventory:server:GiveItem', data)
                choosing = false
                CleanupGivePrompts()
            end
        else
            PromptSetEnabled(GivePrompt, false)
            PromptSetVisible(GivePrompt, false)
        end
        
        Wait(sleep)
    end
    CleanupGivePrompts()
end

RegisterNUICallback('giveItem', function(data, cb)
    local players = GetActivePlayers()
    local ply = PlayerPedId()
    local plyCoords = GetEntityCoords(ply)
    local nearbyPlayers = {}
    
    for _, value in ipairs(players) do
        local target = GetPlayerPed(value)
        if target ~= ply then
            local targetCoords = GetEntityCoords(target)
            if #(plyCoords - targetCoords) < 5.0 then
                table.insert(nearbyPlayers, value)
            end
        end
    end

    if #nearbyPlayers == 0 then
        exports[GetCurrentResourceName()]:Notify(Locales.noPlayersNearby, 3000, "error")
    elseif #nearbyPlayers == 1 then
        -- Only one player nearby, give directly
        local targetPlayer = nearbyPlayers[1]
        local targetServerId = GetPlayerServerId(targetPlayer)
        
        local amountToGive = tonumber(data.amount)
        if not amountToGive or amountToGive == 0 then
             amountToGive = data.item.amount
        end
        
        data.targetId = targetServerId
        data.amount = amountToGive
        TriggerServerEvent('v-inventory:server:GiveItem', data)
    else
        -- Multiple players nearby
        if Config.GiveSystem == "targeting" then
            CloseInventory()
            CreateThread(function()
                GiveItemTargetingLoop(data)
            end)
        else
            local closestPlayer = -1
            local closestDist = 999.0
            
            for _, player in ipairs(nearbyPlayers) do
                local tPed = GetPlayerPed(player)
                local dist = #(plyCoords - GetEntityCoords(tPed))
                if dist < closestDist then
                    closestPlayer = player
                    closestDist = dist
                end
            end
            
            if closestPlayer ~= -1 then
                local targetServerId = GetPlayerServerId(closestPlayer)
                local amountToGive = tonumber(data.amount)
                if not amountToGive or amountToGive == 0 then
                     amountToGive = data.item.amount
                end
                
                data.targetId = targetServerId
                data.amount = amountToGive
                TriggerServerEvent('v-inventory:server:GiveItem', data)
            end
        end
    end
    cb('ok')
end)

local function AttemptRobbery(targetPlayer)
    local targetPed = GetPlayerPed(targetPlayer)
    local targetId = GetPlayerServerId(targetPlayer)

    if Config.Robbery.NeedWeapon then
        local ped = PlayerPedId()
        local _, curWep = GetCurrentPedWeapon(ped, true)
        if curWep == GetHashKey('WEAPON_UNARMED') then
            VBridge:Notify(Locales.needWeapon, 3000, "error")
            return
        end
    end

    if Config.Robbery.RobTime > 0 then
        local anim = Config.Robbery.Animation
        RequestAnimDict(anim.dict)
        while not HasAnimDictLoaded(anim.dict) do Wait(10) end
        
        TaskPlayAnim(PlayerPedId(), anim.dict, anim.anim, 8.0, -8.0, Config.Robbery.RobTime, anim.flag, 0, false, false, false)
        VBridge:Notify(Locales.robbingProgress, Config.Robbery.RobTime, "info")
        Wait(Config.Robbery.RobTime)
        StopAnimTask(PlayerPedId(), anim.dict, anim.anim, 1.0)
    end

    local _, finalDist = VBridge.GetClosestPlayer(5.0)
    if finalDist > 3.5 then
        VBridge:Notify(Locales.targetTooFar, 3000, "error")
        return
    end

    TriggerServerEvent('v-inventory:server:RobPlayer', targetId)
end

RegisterNUICallback('buyItem', function(data, cb)
    TriggerServerEvent('v-inventory:server:BuyItem', data)
    cb('ok')
end)

local function SyncWeapons(newItems)
    local oldItems = LocalInventoryCache or {}
    local playerPed = PlayerPedId()
    
    local oldWeapons = {}
    for _, item in ipairs(oldItems) do
        if item.name and (string.find(string.upper(item.name), "WEAPON_") or item.type == "item_weapon") then
             local hash = GetHashKey(item.name)
             oldWeapons[hash] = (oldWeapons[hash] or 0) + item.amount
        end
    end
    
    local newWeapons = {}
    for _, item in ipairs(newItems) do
        if item.name and (string.find(string.upper(item.name), "WEAPON_") or item.type == "item_weapon") then
             local hash = GetHashKey(item.name)
             newWeapons[hash] = (newWeapons[hash] or 0) + item.amount
        end
    end
    
    for hash, count in pairs(oldWeapons) do
        local newCount = newWeapons[hash] or 0
        if newCount < count then
            if newCount == 0 then
                RemoveWeaponFromPed(playerPed, hash, true, true)
            end
        end
    end
    
    for hash, count in pairs(newWeapons) do
        if not HasPedGotWeapon(playerPed, hash, false) then
            GiveWeaponToPed(playerPed, hash, 0, false, false)
        end
    end
end

RegisterNetEvent('v-inventory:client:updateData', function(data)
    local mainItems = data.main or {}
    
    SyncWeapons(mainItems)
    
    LocalInventoryCache = mainItems 
    SendNUIMessage({
        action = 'UPDATE_DATA',
        data = data
    })
end)

CreateThread(function()
    while true do
        Wait(5)
        
        if isInventoryOpen and IsEntityDead(PlayerPedId()) then
            CloseInventory()
        end

        if IsControlJustPressed(0, Config.OpenInventoryKey) then
            if isInventoryOpen then
                 CloseInventory()
            else
                 OpenInventory()
            end
        end
    end
end)

local NearbyDrops = {}
local DropProps = {}

CreateThread(function()
    while true do
        Wait(2000)
        TriggerServerEvent('v-inventory:server:RequestDrops')
    end
end)

RegisterNetEvent('v-inventory:client:UpdateDrops', function(drops)
    NearbyDrops = drops or {}
    
    if isInventoryOpen then
        local playerCoords = GetEntityCoords(PlayerPedId())
        local filteredGround = {}
        local maxDist = Config.DropSettings.MaxDistance or 2.0
        
        for _, drop in ipairs(drops) do
             local dCoords = vector3(drop.coords.x, drop.coords.y, drop.coords.z)
             if #(playerCoords - dCoords) <= maxDist then
                 table.insert(filteredGround, drop)
             end
        end
        
        SendNUIMessage({
            action = 'UPDATE_DATA',
            data = {
                ground = filteredGround
            }
        })
    end
end)

CreateThread(function()
    while true do
        local sleep = 1000
        local playerPed = PlayerPedId()
        local playerCoords = GetEntityCoords(playerPed)
        
        if next(NearbyDrops) then
            sleep = 5
            for _, drop in ipairs(NearbyDrops) do
                local dCoords = vector3(drop.coords.x, drop.coords.y, drop.coords.z)
                local dist = #(playerCoords - dCoords)
                
                
                if dist < 20.0 then
                    if Config.DropSettings.Type == "prop" then
                         if not DropProps[drop.dropId] then
                             
                             local model = GetHashKey(Config.DropSettings.Model)
                             RequestModel(model)
                             
                             local timeout = 0
                             while not HasModelLoaded(model) and timeout < 500 do 
                                 Wait(10) 
                                 timeout = timeout + 1 
                             end
                             
                             if HasModelLoaded(model) then
                                 local obj = CreateObject(model, dCoords.x, dCoords.y, dCoords.z - 0.98, false, false, false)
                                 SetEntityCollision(obj, false, true) 
                                 FreezeEntityPosition(obj, true)
                                 DropProps[drop.dropId] = obj
                             else
                             end
                         end
                    else
                        DrawMarker(0x6903B113, drop.coords.x, drop.coords.y, drop.coords.z - 1, 0, 0, 0, 0, 0, 0, 0.3, 0.3, 0.3, 255, 255, 255, 200, false, true, 2, false, nil, nil, false) 
                    end
                else
                    if DropProps[drop.dropId] then
                        DeleteObject(DropProps[drop.dropId])
                        DropProps[drop.dropId] = nil
                    end
                end
            end
            
        end
        for id, prop in pairs(DropProps) do
            local exists = false
            for _, drop in ipairs(NearbyDrops) do
                if drop.dropId == id then exists = true break end
            end
            if not exists then
                DeleteObject(prop)
                DropProps[id] = nil
            end
        end
        Wait(sleep)
    end
end)


local ClothingAnims = {
    ['all'] = { dict = "mech_loco_m@character@arthur@fancy@unarmed@idle@_variations", anim = "idle_b" },
    ['hat'] = { dict = "mech_loco_m@character@arthur@fidgets@weather@sunny_hot@unarmed@variations@hat", anim = "hat_cool_c" },
    ['mask'] = { dict = "mech_loco_m@character@arthur@dehydrated@unarmed@idle@fidgets", anim = "idle_i" },
    ['neckwear'] = { dict = "mech_inventory@clothing@bandana", anim = "neck_2_satchel" },
    ['glove'] = { dict = "mech_loco_m@character@arthur@fidgets@item_selection@gloves", anim = "gloves_b" },
    ['belt'] = { dict = "script_proc@loansharking@undertaker@female_mourner", anim = "idle_01" },
    ['pant'] = { dict = "mech_loco_m@character@arthur@fidgets@insects@crouch@unarmed@idle", anim = "idle" },
    ['shirt'] = { dict = "mech_loco_m@character@arthur@fancy@unarmed@idle@_variations", anim = "idle_b" },
    ['vest'] = { dict = "mech_loco_m@character@arthur@fancy@unarmed@idle@_variations", anim = "idle_b" },
    ['coat'] = { dict = "mech_loco_m@character@arthur@fancy@unarmed@idle@_variations", anim = "idle_b" },
    ['poncho'] = { dict = "script_proc@loansharking@undertaker@female_mourner", anim = "idle_01" },
    ['boots'] = { dict = "mech_loco_m@character@arthur@fidgets@insects@crouch@unarmed@idle", anim = "idle" }
}

local function PlayClothingAnim(clothingType)
    local animData = ClothingAnims[clothingType]
    if not animData then return end
    
    local dict = animData.dict
    local anim = animData.anim
    local ped = PlayerPedId()
    
    RequestAnimDict(dict)
    while not HasAnimDictLoaded(dict) do Wait(0) end
    
    TaskPlayAnim(ped, dict, anim, 8.0, -8.0, 1200, 31, 0, true, 0, false, 0, false)
end

local MurphyClothingCategories = {
    hat = "hats",
    mask = "masks",
    neckwear = "neckwear",
    glove = "gloves",
    belt = "belts",
    pant = "pants",
    shirt = "shirts_full",
    vest = "vests",
    coat = "coats",
    poncho = "ponchos",
    boots = "boots"
}

local function ToggleMurphyClothing(item)
    local category = MurphyClothingCategories[item]

    print("[v-inventory clothing] Murphy toggle:", item, "category:", category)

    if not category then
        print("[v-inventory clothing] No Murphy category mapped for:", item)
        return
    end

    TriggerEvent("murphy_clothes:Equip-UnequipCategory", category)
end

RegisterNUICallback('toggleClothing', function(data, cb)
    local item = data and data.item

    if item then
        Citizen.CreateThread(function()
            PlayClothingAnim(item)
            Wait(200)
            ToggleMurphyClothing(item)
        end)
    end

    cb('ok')
end)

RegisterNUICallback('toggleBatch', function(data, cb)
    if data.items and #data.items > 0 then
        Citizen.CreateThread(function()
            PlayClothingAnim("all")

            for _, item in ipairs(data.items) do
                ToggleMurphyClothing(item)
                Citizen.Wait(100)
            end
        end)
    end

    cb('ok')
end)

RegisterNUICallback('customButtonClick', function(data, cb)
    if data.config then
        local config = data.config
        if config.action == 'client' and config.event then
            TriggerEvent(config.event)
        elseif config.action == 'server' and config.event then
            TriggerServerEvent(config.event)
        elseif config.action == 'command' and config.command then
            ExecuteCommand(config.command)
        end
    end
    cb('ok')
end)

AddEventHandler('onResourceStop', function(resource)
    if resource == GetCurrentResourceName() then
        for _, prop in pairs(DropProps) do
            DeleteObject(prop)
        end
    end
end)

local StashPrompt
local ShopPrompt
local RobPrompt

local function SetupRobPrompt()
    local str = VarString(10, 'LITERAL_STRING', Locales.robPrompt)
    RobPrompt = PromptRegisterBegin()
    PromptSetControlAction(RobPrompt, 0x760A9C6F) -- G
    PromptSetText(RobPrompt, str)
    PromptSetEnabled(RobPrompt, false)
    PromptSetVisible(RobPrompt, false)
    PromptSetHoldMode(RobPrompt, true)
    PromptRegisterEnd(RobPrompt)
end

local function CanPlayerAccessContainer(container)
    if not container.job or container.job == "all" then return true end
    
    local pJob, pGrade = VBridge.GetJob()
    
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

local function SetupShopPrompt()
    local str = VarString(10, 'LITERAL_STRING', Locales.openShopPrompt)
    ShopPrompt = PromptRegisterBegin()
    PromptSetControlAction(ShopPrompt, 0x760A9C6F) -- G
    PromptSetText(ShopPrompt, str)
    PromptSetEnabled(ShopPrompt, false)
    PromptSetVisible(ShopPrompt, false)
    PromptSetHoldMode(ShopPrompt, true)
    PromptRegisterEnd(ShopPrompt)
end

local function SetupStashPrompt()
    local str = VarString(10, 'LITERAL_STRING', Locales.openStashPrompt)
    StashPrompt = PromptRegisterBegin()
    PromptSetControlAction(StashPrompt, 0x760A9C6F) -- G
    PromptSetText(StashPrompt, str)
    PromptSetEnabled(StashPrompt, false)
    PromptSetVisible(StashPrompt, false)
    PromptSetHoldMode(StashPrompt, true)
    PromptRegisterEnd(StashPrompt)
end

CreateThread(function()
    SetupStashPrompt()
    SetupShopPrompt()
    SetupRobPrompt()
    while true do
        local sleep = 1000
        local playerPed = PlayerPedId()
        local playerCoords = GetEntityCoords(playerPed)
        
        local players = GetActivePlayers()
        local closestPlayer = -1
        local closestDist = 3.0
        
        for _, player in ipairs(players) do
            local targetPed = GetPlayerPed(player)
            if targetPed ~= playerPed then
                local dist = #(playerCoords - GetEntityCoords(targetPed))
                if dist < closestDist then
                    closestPlayer = player
                    closestDist = dist
                end
            end
        end

        if closestPlayer ~= -1 then
            local targetPed = GetPlayerPed(closestPlayer)
            local isDead = IsEntityDead(targetPed) or IsPedFatallyInjured(targetPed)
            local isHandsUp = IsEntityPlayingAnim(targetPed, Config.Robbery.HandsUpAnim.dict, Config.Robbery.HandsUpAnim.anim, Config.Robbery.HandsUpAnim.flag)
            local isHogtied  = IsPedHogtied(targetPed)
            local isLassoed  = IsPedLassoed(targetPed)

            local canSeePrompt = false
            if Config.Robbery.AllowDead and isDead then
                canSeePrompt = true
            elseif Config.Robbery.AllowHandsUp and isHandsUp then
                canSeePrompt = true
            elseif Config.Robbery.AllowHogtied and isHogtied then
                canSeePrompt = true
            elseif Config.Robbery.AllowLassoed and isLassoed then
                canSeePrompt = true
            end

            if canSeePrompt then
                sleep = 5
                
                -- Attach prompt to the target entity group to prevent overriding
                local group = PromptGetGroupIdForTargetEntity(targetPed)
                PromptSetGroup(RobPrompt, group)

                PromptSetEnabled(RobPrompt, true)
                PromptSetVisible(RobPrompt, true)
                if PromptHasHoldModeCompleted(RobPrompt) then
                    AttemptRobbery(closestPlayer)
                end
            else
                PromptSetEnabled(RobPrompt, false)
                PromptSetVisible(RobPrompt, false)
            end
        else
            PromptSetEnabled(RobPrompt, false)
            PromptSetVisible(RobPrompt, false)
        end

        local closestStash = nil
        local minDist = 2.0

        if Config.Stashes or Config.Shops then
            if Config.Stashes then
                for _, stash in ipairs(Config.Stashes) do
                     local dist = #(playerCoords - stash.coords)
                     if dist < minDist then
                         if CanPlayerAccessContainer(stash) then
                             minDist = dist
                             closestStash = stash
                         end
                     end
                end
            end

            local closestShop = nil
            local minShopDist = 2.0
            if Config.Shops then
                for _, shop in ipairs(Config.Shops) do
                    local dist = #(playerCoords - shop.coords)
                    if dist < minShopDist then
                        if CanPlayerAccessContainer(shop) then
                            minShopDist = dist
                            closestShop = shop
                        end
                    end
                end
            end

            if closestStash then
                sleep = 5
                local label = VarString(10, 'LITERAL_STRING', closestStash.label or Locales.stashLabel)
                PromptSetText(StashPrompt, label)
                PromptSetEnabled(StashPrompt, true)
                PromptSetVisible(StashPrompt, true)
                 if PromptHasHoldModeCompleted(StashPrompt) then
                    TriggerServerEvent('v-inventory:server:OpenStash', closestStash)
                    Wait(1000)
                end
            else
                PromptSetEnabled(StashPrompt, false)
                PromptSetVisible(StashPrompt, false)
            end

            if closestShop then
                sleep = 5
                local label = VarString(10, 'LITERAL_STRING', closestShop.label or Locales.shopLabel)
                PromptSetText(ShopPrompt, label)
                PromptSetEnabled(ShopPrompt, true)
                PromptSetVisible(ShopPrompt, true)
                if PromptHasHoldModeCompleted(ShopPrompt) then
                    TriggerServerEvent('v-inventory:server:OpenShop', closestShop)
                    Wait(1000)
                end
            else
                PromptSetEnabled(ShopPrompt, false)
                PromptSetVisible(ShopPrompt, false)
            end
        end
        Wait(sleep)
    end
end)

AddEventHandler('onResourceStop', function(resource)
    if resource == GetCurrentResourceName() then
        FreezeEntityPosition(PlayerPedId(), false)
        DisableCam()
        if StashPrompt then
            PromptDelete(StashPrompt)
        end
        if ShopPrompt then
            PromptDelete(ShopPrompt)
        end
        if RobPrompt then
            PromptDelete(RobPrompt)
        end
        CleanupGivePrompts()
    end
end)

exports('closeInventory', CloseInventory)
exports('getInventoryItem', function(name)
    for _, item in ipairs(LocalInventoryCache) do
        if item.name == name then
            return item
        end
    end
end)
exports('getInventoryItems', function()
    return LocalInventoryCache or {} 
end)

RegisterNetEvent('v-inventory:client:SetFreeze', function(freeze)
    local playerPed = PlayerPedId()
    isRobbing = freeze
    DisablePlayerFiring(playerPed, freeze)
    -- FreezeEntityPosition(playerPed, freeze)
end)

CreateThread(function()
    while true do
        local sleep = 1000
        if isRobbing then
            sleep = 5
            -- DisableAllControlActions(0)
            for _, v in pairs(Config.OnRobberyBlockKeys) do
                DisableControlAction(0, v, true)
            end
        end
        Wait(sleep)
    end
end)

RegisterNetEvent('v-inventory:client:UnequipAllWeapons', function()
    local playerPed = PlayerPedId()
    local equipped = LocalPlayer.state.equippedWeapon
    
    if equipped and equipped.slot then
        local hash = equipped.hash
        local ammo = GetAmmoInPedWeapon(playerPed, hash)
        local _, clip = GetAmmoInClip(playerPed, hash)
        
        TriggerServerEvent('v-inventory:server:UpdateWeaponAmmo', {
            slot = equipped.slot,
            ammo = ammo,
            clipAmmo = clip
        })
    end
    
    RemoveAllPedWeapons(playerPed, true, true)
    if LocalPlayer and LocalPlayer.state then
        LocalPlayer.state:set('equippedWeapon', nil, true)
    end
end)

-- Weapon Durability Loop (Throttled)
local durabilityDirty = false
local lastDurabilitySync = 0

CreateThread(function()
    while true do
        local sleep = 100
        local ped = PlayerPedId()
        
        if IsPedShooting(ped) then
            sleep = 5
            local equipped = LocalPlayer.state.equippedWeapon
            if equipped and equipped.slot then
                
                -- Find item in local cache
                local targetItem = nil
                for _, item in ipairs(LocalInventoryCache) do
                    if item.slot == equipped.slot then
                        targetItem = item
                        break
                    end
                end
                
                if targetItem then
                    local metadata = targetItem.metadata or {}
                    local currentDurability = tonumber(metadata.durability) or 100.0
                    
                    local decay = Config.WeaponDefaults.DecayRate or 0.5
                    local upperName = string.upper(equipped.name)
                    if Config.Weapons and Config.Weapons[upperName] and Config.Weapons[upperName].DecayRate then
                        decay = Config.Weapons[upperName].DecayRate
                    end
                    
                    local newDurability = currentDurability - decay
                    if newDurability < 0 then newDurability = 0.0 end
                    
                    -- Update local cache immediately to prevent desync during rapid fire
                    targetItem.metadata = targetItem.metadata or {}
                    targetItem.metadata.durability = newDurability

                    local currentAmmo = GetAmmoInPedWeapon(ped, equipped.hash)
                    local _, currentClipAmmo = GetAmmoInClip(ped, equipped.hash)
                    targetItem.metadata.ammo = currentAmmo
                    targetItem.metadata.clipAmmo = currentClipAmmo
                    
                    durabilityDirty = true

                    -- Weapon broke: send immediately and holster
                    if newDurability <= 0 then
                        TriggerServerEvent('v-inventory:server:UpdateWeaponAmmo', {
                            slot = equipped.slot,
                            durability = 0,
                            ammo = currentAmmo,
                            clipAmmo = currentClipAmmo
                        })
                        durabilityDirty = false
                        SetCurrentPedWeapon(ped, GetHashKey('WEAPON_UNARMED'), true)
                        LocalPlayer.state:set('equippedWeapon', nil, true)
                        VBridge:Notify(Locales.weaponBroken, 3000, "error")
                        LocalPlayer.state:set('lastWeapon', nil, true)
                    else
                        -- Throttle: sync every 3 seconds
                        local now = GetGameTimer()
                        if (now - lastDurabilitySync) > 3000 then
                            TriggerServerEvent('v-inventory:server:UpdateWeaponAmmo', {
                                slot = equipped.slot,
                                durability = newDurability,
                                ammo = currentAmmo,
                                clipAmmo = currentClipAmmo
                            })
                            durabilityDirty = false
                            lastDurabilitySync = now
                        end
                    end
                end
            end
        else
            -- Not shooting: flush pending durability update
            if durabilityDirty then
                local equipped = LocalPlayer.state.equippedWeapon
                if equipped and equipped.slot then
                    local targetItem = nil
                    for _, item in ipairs(LocalInventoryCache) do
                        if item.slot == equipped.slot then
                            targetItem = item
                            break
                        end
                    end
                    if targetItem and targetItem.metadata then
                        TriggerServerEvent('v-inventory:server:UpdateWeaponAmmo', {
                            slot = equipped.slot,
                            durability = targetItem.metadata.durability,
                            ammo = GetAmmoInPedWeapon(ped, equipped.hash),
                            clipAmmo = select(2, GetAmmoInClip(ped, equipped.hash))
                        })
                    end
                end
                durabilityDirty = false
            end
        end
        Wait(sleep)
    end
end)

CreateThread(function()
    local keys = {
        [1] = 0xE6F612E4, -- 1
        [2] = 0x6990BDDF, -- 2
        [3] = 0xAE69478F, -- 3
        [4] = 0x8F9F9E58, -- 4
        [5] = 0xAB62E997  -- 5
    }
    
    while true do
        local sleep = 10
        if not isInventoryOpen then
            for slot, key in pairs(keys) do
                if IsControlJustPressed(0, key) then
                    local targetItem = nil
                    for _, item in ipairs(LocalInventoryCache) do
                        if item.slot == slot then
                            targetItem = item
                            break
                        end
                    end
                    
                    if targetItem then
                        InternalUseItem(targetItem)
                    end
                end
            end
        else
            sleep = 100
        end
        Wait(sleep)
    end
end)
