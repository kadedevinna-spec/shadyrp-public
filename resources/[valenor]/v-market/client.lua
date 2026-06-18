local RSGCore = nil
if Config.Framework == 'rsg-core' then
    RSGCore = exports['rsg-core'] and exports['rsg-core']:GetCoreObject() or nil
end
local CurrentMarket = nil
local CurrentCustomMarket = nil
local CustomMarkets = {}
local prompts = GetRandomIntInRange(0, 0xffffff)
local PlayerInfo = { money = 0, job = nil, grade = nil }
local isOpeningMarket = false
local CreatedBlips = {}

local SpawnedPeds = {
	standalone = {},
	custom = {}
}

local CreatedBlips = {
	standalone = {},
	custom = {}
}

local ServerCallbacks = {}
local CurrentRequestId = 0

local function TriggerServerCallback(name, cb, ...)
    ServerCallbacks[CurrentRequestId] = cb
    TriggerServerEvent('valenor_market:server:triggerCallback', name, CurrentRequestId, ...)
    CurrentRequestId = CurrentRequestId + 1
end

RegisterNetEvent('valenor_market:client:serverCallback')
AddEventHandler('valenor_market:client:serverCallback', function(requestId, ...)
    if ServerCallbacks[requestId] then
        ServerCallbacks[requestId](...)
        ServerCallbacks[requestId] = nil
    end
end)

local function LoadModel(model)
    local modelHash = model
    if type(model) == 'string' then
        modelHash = GetHashKey(model)
    end
    if not IsModelInCdimage(modelHash) then
        print("[v-market] Model not found in CD image: " .. tostring(model))
        return nil
    end
    RequestModel(modelHash)
    local attempts = 0
    while not HasModelLoaded(modelHash) and attempts < 500 do
        attempts = attempts + 1
        Wait(10)
    end
    if not HasModelLoaded(modelHash) then
        print("[v-market] Failed to load model: " .. tostring(model))
        return nil
    end
    return modelHash
end

local function SpawnMarketPed(key, coords, isCustom, customModel, customScenario)
	if not Config.NPCSettings then return end
	local spawnForThis = (isCustom and Config.NPCSettings.spawnForCustom) or ((not isCustom) and Config.NPCSettings.spawnForStandalone)
	if not spawnForThis then return end
	local registry = isCustom and SpawnedPeds.custom or SpawnedPeds.standalone
	if registry[key] and DoesEntityExist(registry[key]) then return end

    local model = customModel or 'a_m_m_farmer_01'
    local modelHash = LoadModel(model)
    if not modelHash then
        model = 'a_m_m_farmer_01'
        modelHash = LoadModel(model)
        if not modelHash then
            print("[v-market] Could not load any ped model, aborting spawn for key: " .. tostring(key))
            return
        end
    end

	local x, y, z = coords.x, coords.y, coords.z
	local heading = coords.w or 0.0
    local ped = CreatePed(modelHash, x, y, z, heading, false, false, false, false)
    SetEntityHeading(ped, heading)
    PlaceEntityOnGroundProperly(ped, true)
    repeat Wait(0) until DoesEntityExist(ped)
    Citizen.InvokeNative(0x283978A15512B2FE, ped, true) 
    SetEntityNoCollisionEntity(PlayerPedId(), ped, false)
    SetEntityCanBeDamaged(ped, false)
    SetEntityInvincible(ped, true)
    SetPedCanRagdoll(ped, false)
    Wait(100)
    FreezeEntityPosition(ped, true)           
    SetBlockingOfNonTemporaryEvents(ped, true) 

	local scenario = customScenario or ''
	if scenario ~= '' then
		TaskStartScenarioInPlace(ped, GetHashKey(scenario), -1, true)
	end

	registry[key] = ped
	SetModelAsNoLongerNeeded(modelHash)
end

local function CleanupBlips()
	for k, blip in pairs(CreatedBlips.standalone) do
		if DoesBlipExist(blip) then RemoveBlip(blip) end
		CreatedBlips.standalone[k] = nil
	end
	for k, blip in pairs(CreatedBlips.custom) do
		if DoesBlipExist(blip) then RemoveBlip(blip) end
		CreatedBlips.custom[k] = nil
	end
end

local function CleanupPeds()
	for k, ped in pairs(SpawnedPeds.standalone) do
		if DoesEntityExist(ped) then DeletePed(ped) end
		SpawnedPeds.standalone[k] = nil
	end
	for k, ped in pairs(SpawnedPeds.custom) do
		if DoesEntityExist(ped) then DeletePed(ped) end
		SpawnedPeds.custom[k] = nil
	end
end

local function GetPlayerDistanceFromCoords(vector)
    local playerPos = GetEntityCoords(PlayerPedId())
    return #(playerPos - vector)
end

local ClosedMarketInfo = nil -- { name, open, close }

local function IsMarketOpen(market)
    if not market.operatingHours then return true end
    local hour = GetClockHours()
    local open = market.operatingHours.open
    local close = market.operatingHours.close
    if open < close then
        return hour >= open and hour < close
    else -- overnight: e.g. open=20, close=6
        return hour >= open or hour < close
    end
end

local function AddBlip(market, isCustom)
    if market.showBlip then
        local registry = isCustom and CreatedBlips.custom or CreatedBlips.standalone
        local key = market.name or (tostring(market.coords.x) .. ':' .. tostring(market.coords.y) .. ':' .. tostring(market.coords.z))
        if registry[key] and DoesBlipExist(registry[key]) then
            RemoveBlip(registry[key])
        end
        local blip = Citizen.InvokeNative(0x554D9D53F696D002,1664425300, market.coords.x, market.coords.y, market.coords.z)
        if isCustom then
            CreatedBlips[tostring(market.id)] = blip
        else
            CreatedBlips[market.name] = blip
        end
        Citizen.InvokeNative(0x9CB1A1623062F402, blip, market.name)
        SetBlipSprite(blip, GetHashKey(market.BlipSettings.blipTexture))
        SetBlipScale(blip, 1.0)
        registry[key] = blip
    end
end

local function CheckManagementAccess(marketId)
    local playerJob = PlayerInfo.job
    local playerGrade = PlayerInfo.grade
    
    for _, market in pairs(Config.customMarkets) do
        if market.id == marketId then
            if playerJob == market.job then
                for _, allowedGrade in pairs(market.grade) do
                    if playerGrade == allowedGrade then
                        return true
                    end
                end
            end
            break
        end
    end
    return false
end

local function CheckWithdrawAccess(marketId)
    local playerJob = PlayerInfo.job
    local playerGrade = PlayerInfo.grade
    
    for _, market in pairs(Config.customMarkets) do
        if market.id == marketId then
            if playerJob == market.job then
                for _, allowedGrade in pairs(market.bossGrade) do
                    if playerGrade == allowedGrade then
                        return true
                    end
                end
            end
            break
        end
    end
    return false
end

local function OpenMarket()
    if not CurrentMarket and not CurrentCustomMarket then return end
    SetNuiFocus(true, true)
    if CurrentCustomMarket then
        isOpeningMarket = true
        TriggerServerEvent("valenor_market:server:getCustomMarketData", CurrentCustomMarket.id)
        return
    else
        local processedItems = {}
        if CurrentMarket and CurrentMarket.items then
            for _, item in pairs(CurrentMarket.items) do
                local processedItem = {
                    id = item.id,
                    itemName = item.itemName,
                    itemLabel = item.itemLabel or item.itemName,
                    category = item.category,
                    description = item.description or "",
                    price = item.price,
                    maxQuantityinStore = item.maxQuantityinStore or Config.MarketLimit,
                    imageUrl = getItemImageUrl(item.itemName, item.imageUrl or "")
                }
                table.insert(processedItems, processedItem)
            end
        end
        
        local processedSellItems = {}
        if CurrentMarket and CurrentMarket.sellItems then
            for _, item in pairs(CurrentMarket.sellItems) do
                local processedItem = {
                    itemName = item.itemName,
                    itemLabel = item.itemLabel or item.itemName,
                    price = item.price,
                    imageUrl = getItemImageUrl(item.itemName, item.imageUrl or "")
                }
                table.insert(processedSellItems, processedItem)
            end
        end
        
        local marketData = {
            name = CurrentMarket.name,
            description = CurrentMarket.description,
            items = processedItems,
            sellItems = processedSellItems
        }
        
        SendNUIMessage({
            type = "OPEN_MENU",
            data = marketData,
            money = PlayerInfo.money or 0,
            framework = Config.Framework,
            imageServer = Config.ImageServer
        })
    end
end

local function PromptSetUp()
    local str = Config.Lang.open_menu_key:gsub("{Config.OpenKey}", Config.OpenKey)
    openmenu = UiPromptRegisterBegin()
    UiPromptSetControlAction(openmenu, Config.OpenKeyHash)
    str = VarString(10, 'LITERAL_STRING', str)
    UiPromptSetText(openmenu, str)
    UiPromptSetEnabled(openmenu, true)
    UiPromptSetVisible(openmenu, true)
    UiPromptSetStandardMode(openmenu, true)
    UiPromptSetGroup(openmenu, prompts, 0)
    UiPromptRegisterEnd(openmenu)
end

RegisterNUICallback('purchase', function(data, cb)
    TriggerServerCallback("valenor_market:server:purchase", function(success)
        if success then
            SetNuiFocus(false, false)
            cb('ok')
        else
            cb('error')
        end
    end, data)
end)

RegisterNUICallback('sellItem', function(data, cb)
    TriggerServerCallback("valenor_market:server:sellItem", function(success)
        if success then cb('ok') else cb('error') end
    end, data)
end)

RegisterNUICallback('sellItems', function(data, cb)
    TriggerServerCallback("valenor_market:server:sellItems", function(success)
        if success then cb('ok') else cb('error') end
    end, data)
end)

RegisterNUICallback('close', function(data, cb)
    isOpeningMarket = false
    SetNuiFocus(false, false)
    cb('ok')
end)

RegisterNUICallback('changeDetails', function(data, cb)
    TriggerServerCallback("valenor_market:server:changeDetails", function(success)
        if success then
            Citizen.InvokeNative(0x9CB1A1623062F402, CreatedBlips[tostring(data.marketId)], data.marketName)
            cb('ok')
        else
            cb('error')
        end
    end, data)
end)

function getItemImageUrl(itemName, existingImageUrl)
    if existingImageUrl and existingImageUrl ~= "" then
        return existingImageUrl
    end
    
    if Config.Framework == 'rsg-core' and RSGCore and RSGCore.Shared and RSGCore.Shared.Items then
        local itemData = RSGCore.Shared.Items[itemName]
        if itemData and itemData.image then
            return itemData.image
        end
    end
    
    return ""
end

local userWeapons = {}

RegisterNetEvent("v-market:client:getUserWeapons", function(data)
    userWeapons = data
end)


RegisterNUICallback('getInventoryItems', function(data, cb)
    TriggerServerCallback("valenor_market:server:getInventoryItems", function(inventoryData)
        local items = inventoryData.items or {}
        local weapons = inventoryData.weapons or {}
        local sendData = {}
        local addedWeaponIds = {}

        -- Process Items
        for i, item in pairs(items) do
            local itemName = item.name or item.itemName
            if itemName then
                local isWeapon = string.find(string.upper(itemName), "^WEAPON_")
                local weaponId = nil
                local metadata = item.metadata or {}

                if isWeapon then
                    metadata.ammo = item.ammo or metadata.ammo or 0
                    metadata.components = item.components or metadata.components or {}
                    weaponId = item.id or item.weaponId or metadata.serial or metadata.weaponId
                end

                local itemId = weaponId or (100000 + i)
                if isWeapon and weaponId then
                    itemId = "W_" .. tostring(weaponId) .. "_" .. tostring(i)
                    addedWeaponIds[tostring(weaponId)] = true
                end

                sendData[#sendData + 1] = {
                    id = itemId,
                    itemName = itemName,
                    itemLabel = item.label or item.itemLabel or itemName,
                    price = 0,
                    maxQuantityinStore = isWeapon and 1 or (item.count or item.amount or item.maxQuantityinStore),
                    weaponId = weaponId,
                    metadata = metadata,
                    imageUrl = getItemImageUrl(itemName, "")
                }
            end
        end

        -- Process Weapons (specifically for VORP if they are separate)
        for i, item in pairs(weapons) do
            local weaponId = item.id or item.weaponId
            if weaponId and not addedWeaponIds[tostring(weaponId)] then
                local metadata = item.metadata or {}
                metadata.ammo = item.ammo or metadata.ammo or 0
                metadata.components = item.components or metadata.components or {}
                metadata.serial = item.serial or metadata.serial or item.serial_number
                metadata.comps = item.comps or metadata.comps or {}
                sendData[#sendData + 1] = {
                    id = "UW_" .. tostring(weaponId) .. "_" .. tostring(i),
                    itemName = item.name or item.itemName,
                    itemLabel = item.label or item.itemLabel or item.name or item.itemName,
                    price = 0,
                    maxQuantityinStore = 1,
                    weaponId = weaponId,
                    metadata = metadata,
                    imageUrl = getItemImageUrl(item.name or item.itemName, "")
                }
            end
        end

        cb(sendData)
    end)
end)

RegisterNUICallback('addItemToMarket', function(data, cb)
    TriggerServerCallback("valenor_market:server:addItemToMarket", function(success)
        if success then cb('ok') else cb('error') end
    end, data)
end)

RegisterNUICallback('updateMarketItem', function(data, cb)
    TriggerServerCallback("valenor_market:server:updateMarketItem", function(success)
        if success then cb('ok') else cb('error') end
    end, data)
end)

RegisterNUICallback('withdrawCash', function(data, cb)
    TriggerServerCallback("valenor_market:server:withdrawCash", function(success)
        if success then cb('ok') else cb('error') end
    end, data)
end)

RegisterNetEvent("valenor_market:client:receiveCustomMarketData")
AddEventHandler("valenor_market:client:receiveCustomMarketData", function(marketData)
    CurrentCustomMarket = marketData
    
    if isOpeningMarket and CurrentCustomMarket then
        isOpeningMarket = false
        local hasManagementAccess = (CurrentCustomMarket.managementAccess ~= nil) and CurrentCustomMarket.managementAccess or CheckManagementAccess(CurrentCustomMarket.id)
        local hasWithdrawAccess = (CurrentCustomMarket.canWithdraw ~= nil) and CurrentCustomMarket.canWithdraw or CheckWithdrawAccess(CurrentCustomMarket.id)
        
        SendNUIMessage({
            type = "OPEN_CUSTOM",
            data = {
                marketId = CurrentCustomMarket.id,
                name = CurrentCustomMarket.name,
                description = CurrentCustomMarket.description,
                icon = CurrentCustomMarket.icon,
                items = CurrentCustomMarket.items,
                caseMoney = CurrentCustomMarket.case,
                managementAccess = hasManagementAccess,
                canWithdraw = hasWithdrawAccess,
                category = CurrentCustomMarket.category
            },
            money = PlayerInfo.money or 0,
            framework = Config.Framework,
            imageServer = Config.ImageServer
        })
    end
end)

RegisterNetEvent("valenor_market:client:receivePlayerInfo")
AddEventHandler("valenor_market:client:receivePlayerInfo", function(info)
    PlayerInfo.money = info.money or 0
    PlayerInfo.job = info.job
    PlayerInfo.grade = info.grade
end)

RegisterNetEvent("valenor_market:client:receivePlayerCustomMarkets")
AddEventHandler("valenor_market:client:receivePlayerCustomMarkets", function(markets)
    CustomMarkets = markets
    for _, market in pairs(markets) do
        AddBlip(market, true)
		SpawnMarketPed(market.id, market.coords, true, market.ped, market.scenario)
    end
end)

RegisterNetEvent("valenor_market:client:caseUpdated")
AddEventHandler("valenor_market:client:caseUpdated", function(data)
    if CurrentCustomMarket and CurrentCustomMarket.id == data.marketId then
        CurrentCustomMarket.case = data.newCase
        
        SendNUIMessage({
            type = "CASE_UPDATED",
            data = {
                marketId = data.marketId,
                caseMoney = data.newCase
            },
            money = PlayerInfo.money or 0
        })
    end
end)

RegisterNetEvent("valenor_market:client:marketUpdated")
AddEventHandler("valenor_market:client:marketUpdated", function(marketData)
    for i, market in pairs(CustomMarkets) do
        if market.id == marketData.marketId then
            CustomMarkets[i] = {
                id = marketData.marketId,
                name = marketData.name,
                description = marketData.description,
                icon = marketData.icon,
                coords = market.coords,
                category = market.category,
                case = marketData.case
            }
            break
        end
    end
    
    if CurrentCustomMarket and CurrentCustomMarket.id == marketData.marketId then
        CurrentCustomMarket.name = marketData.name
        CurrentCustomMarket.description = marketData.description
        CurrentCustomMarket.icon = marketData.icon
        CurrentCustomMarket.items = marketData.items
        CurrentCustomMarket.case = marketData.case
        
        SendNUIMessage({
            type = "MARKET_UPDATED",
            data = {
                marketId = CurrentCustomMarket.id,
                name = CurrentCustomMarket.name,
                description = CurrentCustomMarket.description,
                icon = CurrentCustomMarket.icon,
                items = CurrentCustomMarket.items,
                caseMoney = CurrentCustomMarket.case,
                managementAccess = (CurrentCustomMarket.managementAccess ~= nil) and CurrentCustomMarket.managementAccess or CheckManagementAccess(CurrentCustomMarket.id),
                category = CurrentCustomMarket.category
            },
            money = PlayerInfo.money or 0,
            framework = Config.Framework,
            imageServer = Config.ImageServer
        })
    end
end)

CreateThread(function()
    TriggerServerEvent("valenor_market:server:getPlayerInfo")
    repeat Wait(1000) until PlayerInfo.money ~= nil
    SendNUIMessage({
        type = "LANG_UPDATED",
        data = Config.Lang
    })
    CleanupBlips()
    PromptSetUp()
    for _, market in pairs(Config.markets) do
        AddBlip(market, false)
		SpawnMarketPed(market.name or (market.coords.x .. ':' .. market.coords.y .. ':' .. market.coords.z), market.coords, false, market.ped, market.scenario)
    end

    if Config.sellMarkets then
        for _, market in pairs(Config.sellMarkets) do
            AddBlip(market, false)
            SpawnMarketPed(market.name or (market.coords.x .. ':' .. market.coords.y .. ':' .. market.coords.z), market.coords, false, market.ped, market.scenario)
        end
    end
    
    TriggerServerEvent("valenor_market:server:getPlayerCustomMarkets")

    while true do
        local player = PlayerPedId()
        local dead = IsEntityDead(player)
        local foundMarket = false

        CurrentMarket = nil
        CurrentCustomMarket = nil
        ClosedMarketInfo = nil

        if dead then
            goto skip
        end
        
        for _, market in pairs(Config.markets) do
            local distance = GetPlayerDistanceFromCoords(vector3(market.coords.x, market.coords.y, market.coords.z))
            if (distance <= 3.0) then
                foundMarket = true
                if IsMarketOpen(market) then
                    CurrentMarket = market
                else
                    ClosedMarketInfo = { name = market.name, open = market.operatingHours.open, close = market.operatingHours.close }
                end
                break
            end
        end

        if not foundMarket and Config.sellMarkets then
            for _, market in pairs(Config.sellMarkets) do
                local distance = GetPlayerDistanceFromCoords(vector3(market.coords.x, market.coords.y, market.coords.z))
                if (distance <= 3.0) then
                    foundMarket = true
                    if IsMarketOpen(market) then
                        CurrentMarket = market
                    else
                        ClosedMarketInfo = { name = market.name, open = market.operatingHours.open, close = market.operatingHours.close }
                    end
                    break
                end
            end
        end
        
        if not foundMarket then
            for _, market in pairs(CustomMarkets) do
                local distance = GetPlayerDistanceFromCoords(vector3(market.coords.x, market.coords.y, market.coords.z))
                if (distance <= 3.0) then
                    foundMarket = true
                    if IsMarketOpen(market) then
                        CurrentCustomMarket = market
                    else
                        ClosedMarketInfo = { name = market.name or ('Market #' .. tostring(market.id)), open = market.operatingHours.open, close = market.operatingHours.close }
                    end
                    break
                end
            end
        end
        :: skip ::
        Wait(1000)
    end
end)


CreateThread(function()
    while true do
        local sleep = (CurrentMarket or CurrentCustomMarket or ClosedMarketInfo) and 0 or 100
        Wait(sleep)
        if ClosedMarketInfo and not CurrentMarket and not CurrentCustomMarket then
            -- Market is nearby but closed — show closed message as 3D text
            local closedMsg = Config.Lang.market_closed
                :gsub('{open}', tostring(ClosedMarketInfo.open))
                :gsub('{close}', tostring(ClosedMarketInfo.close))
            local label = CreateVarString(10, 'LITERAL_STRING', ClosedMarketInfo.name .. ' (' .. closedMsg .. ')')
            UiPromptSetActiveGroupThisFrame(prompts, label)
        elseif (CurrentMarket or CurrentCustomMarket) then
            local label
            if CurrentMarket ~= nil and CurrentMarket.name ~= nil then
                label = CreateVarString(10, 'LITERAL_STRING', CurrentMarket.name)
            elseif CurrentCustomMarket ~= nil and CurrentCustomMarket.name ~= nil then
                label = CreateVarString(10, 'LITERAL_STRING', CurrentCustomMarket.name)
            else
                label = CreateVarString(10, 'LITERAL_STRING', "")
            end
            UiPromptSetActiveGroupThisFrame(prompts, label)
            if IsControlJustReleased(1, Config.OpenKeyHash) then
                OpenMarket()
            end
        end
    end
end)

AddEventHandler('onResourceStop', function(res)
	if res ~= GetCurrentResourceName() then return end
	CleanupPeds()
    CleanupBlips()
end)

RegisterNetEvent('RSGCore:Player:SetPlayerData', function(val)
    PlayerInfo.money = val.money.cash
    PlayerInfo.job = val.job.name
    PlayerInfo.grade = val.job.grade.level
end)

if Config.Framework == "vorp" then
    CreateThread(function()
        while true do
            Wait(1000)
            if LocalPlayer.state.Character then
                if LocalPlayer.state.Character.Money then
                    PlayerInfo.money = LocalPlayer.state.Character.Money
                end
                if LocalPlayer.state.Character.Job then
                    PlayerInfo.job = LocalPlayer.state.Character.Job
                end
                if LocalPlayer.state.Character.Grade then
                    PlayerInfo.grade = LocalPlayer.state.Character.Grade
                end
            end
        end
    end)
end

-- AddEventHandler("vorp:playerJobChange", function(source, newjob, oldjob) 
--     PlayerInfo.job = newjob
-- end)