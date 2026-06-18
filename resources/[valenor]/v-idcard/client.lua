--[[
    ═══════════════════════════════════════════════════════════════════════
    V-IDCARD
    by Valenor Studio
    ═══════════════════════════════════════════════════════════════════════
--]]

local spawnedPeds = {}
local idcardPrompts = {}

function VarString(p0, p1, variadic)
    return Citizen.InvokeNative(0xFA925AC00EB830B9, p0, p1, variadic, Citizen.ResultAsLong())
end

function CreateVarString(p0, p1, variadic)
    return Citizen.InvokeNative(0xFA925AC00EB830B9, p0, p1, variadic, Citizen.ResultAsLong())
end

function CreateIDCardPrompt(index, promptText)
    local str = VarString(10, 'LITERAL_STRING', promptText)
    
    local prompt = Citizen.InvokeNative(0x04F97DE45A519419) 
    Citizen.InvokeNative(0xB5352B7494A08258, prompt, 0xCEFD9220) 
    Citizen.InvokeNative(0x5DD02A8318420DD7, prompt, str) 
    Citizen.InvokeNative(0x8A0FB4D03A630D21, prompt, true) 
    Citizen.InvokeNative(0x71215ACCFDE075EE, prompt, true) 
    Citizen.InvokeNative(0xCC6656799977741B, prompt, true) 
    Citizen.InvokeNative(0xF7AA2696A22AD8B9, prompt) 
    
    return prompt
end

function SetPromptVisible(prompt, visible)
    if prompt then
        Citizen.InvokeNative(0x8A0FB4D03A630D21, prompt, visible) 
        Citizen.InvokeNative(0x71215ACCFDE075EE, prompt, visible) 
    end
end

function IsPromptCompleted(prompt)
    if prompt then
        return Citizen.InvokeNative(0xC92AC953F0A982AE, prompt) 
    end
    return false
end

function DeletePrompt(prompt)
    if prompt then
        Citizen.InvokeNative(0x00EDE88D4D13CF59, prompt) 
    end
end

function ValidateDateOfBirth(dateStr)
    if not dateStr or dateStr == "" then
        return false
    end
    
    local day, month, year = string.match(dateStr, "^(%d%d)/(%d%d)/(%d%d%d%d)$")
    
    if not day or not month or not year then
        return false
    end
    
    year = tonumber(year)
    month = tonumber(month)
    day = tonumber(day)
    
    if year < Config.DateOfBirth.MinYear or year > Config.DateOfBirth.MaxYear then
        return false
    end
    
    if month < 1 or month > 12 then
        return false
    end
    
    if day < 1 or day > 31 then
        return false
    end
    
    return true
end

function ValidateGender(gender)
    if not Config.Gender.Enabled then return true end
    if not gender or gender == "" then return false end
    
    for _, allowed in ipairs(Config.Gender.AllowedValues) do
        local compareGender = Config.Gender.CaseSensitive and gender or string.lower(gender)
        local compareAllowed = Config.Gender.CaseSensitive and allowed or string.lower(allowed)
        if compareGender == compareAllowed then
            return true
        end
    end
    return false
end

function ValidateWeight(weight)
    if not Config.Weight.Enabled then return true end
    if not weight or weight == "" then return false end
    
    local numWeight = tonumber(weight:match("^(%d+)"))
    if not numWeight then return false end
    return numWeight >= Config.Weight.Min and numWeight <= Config.Weight.Max
end

function ValidateHeight(height)
    if not Config.Height.Enabled then return true end
    if not height or height == "" then return false end
    
    local numHeight = tonumber(height:match("^(%d+)"))
    if not numHeight then return false end
    return numHeight >= Config.Height.Min and numHeight <= Config.Height.Max
end

function ContainsBlacklistedWord(text)
    if not Config.BlacklistWords.Enabled then return false end
    if not text or text == "" then return false end
    
    local lowerText = string.lower(text)
    for _, word in ipairs(Config.BlacklistWords.Words) do
        if string.find(lowerText, string.lower(word)) then
            return true
        end
    end
    return false
end

function ValidateAllFields(data)
    local fieldsToCheck = {
        data.fullname, data.bornIn, data.residence, data.employed,
        data.nationality, data.signature, data.eyesColor, data.hairColor
    }
    
    for _, field in ipairs(fieldsToCheck) do
        if ContainsBlacklistedWord(field) then
            return false, "blacklist"
        end
    end
    
    if not ValidateDateOfBirth(data.dateOfBirth) then
        return false, "dob"
    end
    
    if not ValidateGender(data.gender) then
        return false, "gender"
    end
    
    if not ValidateWeight(data.weight) then
        return false, "weight"
    end
    
    if not ValidateHeight(data.height) then
        return false, "height"
    end
    
    return true, nil
end

function GetClosestPlayer()
    local players = GetActivePlayers()
    local player = PlayerPedId()
    local playerCoords = GetEntityCoords(player)
    local closestPlayer, closestDistance = -1, 9999.0

    for i, targetPlayer in ipairs(players) do
        local targetPed = GetPlayerPed(targetPlayer)
        if targetPed ~= player and DoesEntityExist(targetPed) then
            local targetCoords = GetEntityCoords(targetPed)
            local distance = #(playerCoords - targetCoords)
            
            if distance < closestDistance and distance < Config.ShowCardDistance then
                closestPlayer = targetPlayer
                closestDistance = distance
            end
        end
    end
    return closestPlayer, closestDistance
end

function LoadPedModel(model)
    local modelHash = type(model) == 'string' and GetHashKey(model) or model
    
    RequestModel(modelHash)
    local timeout = 0
    while not HasModelLoaded(modelHash) and timeout < 5000 do
        Wait(100)
        timeout = timeout + 100
    end
    
    if not HasModelLoaded(modelHash) then
        return nil
    end
    return modelHash
end

function ShowNotification(message, duration)
    if Config.Framework and Config.Framework.Notifications then
        Config.Framework.Notifications.ShowNotificationClient(message, duration)
    else
        TriggerEvent('vorp:TipRight', message, duration)
    end
end

CreateThread(function()
    Wait(1000)
    
    for index, location in pairs(Config.CreateLocations) do
        local modelHash = LoadPedModel(Config.PedModel)
        
        if not modelHash then
            goto continue
        end
        
        local ped = CreatePed(modelHash, location.x, location.y, location.z-1, location.heading, false, false, false, false)
        
        repeat Wait(0) until DoesEntityExist(ped)
        
        PlaceEntityOnGroundProperly(ped, true)
        
        Citizen.InvokeNative(0x283978A15512B2FE, ped, true)
        SetEntityCanBeDamaged(ped, false)
        SetEntityInvincible(ped, true)
        SetEntityProofs(ped, true, true, true, true, true, true, true, true)
        FreezeEntityPosition(ped, true)
        
        Citizen.InvokeNative(0x63F58F7C80513AAD, ped, false)
        Citizen.InvokeNative(0xBF1CA77833E58F2C, ped, false)
        SetPedRelationshipGroupHash(ped, joaat("CIVMALE"))
        
        SetPedConfigFlag(ped, 17, true)
        SetPedConfigFlag(ped, 120, true)
        SetPedConfigFlag(ped, 122, true)
        SetPedConfigFlag(ped, 128, true)
        SetPedConfigFlag(ped, 229, true)
        SetPedConfigFlag(ped, 297, true)
        Citizen.InvokeNative(0xDF631E77C36B1BC4, ped, true)
        
        SetBlockingOfNonTemporaryEvents(ped, true)
        SetPedFleeAttributes(ped, 0, false)
        SetPedCombatAttributes(ped, 17, true)
        
        Wait(500)
        TaskStandStill(ped, -1)
        SetModelAsNoLongerNeeded(Config.PedModel)
        
        -- Create prompt
        local prompt = CreateIDCardPrompt(index, Config.Messages.press_e_to_create)
        SetPromptVisible(prompt, false)
        
        spawnedPeds[#spawnedPeds + 1] = {
            ped = ped, 
            coords = vector3(location.x, location.y, location.z),
            prompt = prompt
        }
        
        ::continue::
    end
end)

CreateThread(function()
    while true do
        Wait(0)
        local playerPed = PlayerPedId()
        local playerCoords = GetEntityCoords(playerPed)
        local isNearAnyLocation = false

        for _, pedData in pairs(spawnedPeds) do
            local distance = #(playerCoords - pedData.coords)
            
            if distance < Config.InteractionDistance then
                isNearAnyLocation = true
                SetPromptVisible(pedData.prompt, true)
                
                if IsPromptCompleted(pedData.prompt) then
                    TriggerServerEvent('idcard:requestCardData')
                end
            else
                SetPromptVisible(pedData.prompt, false)
            end
        end
        
        if not isNearAnyLocation then
            Wait(500)
        end
    end
end)

RegisterNetEvent('idcard:openCreationmenu')
AddEventHandler('idcard:openCreationmenu', function(existingData)
    SetNuiFocus(true, true)
    SetNuiFocusKeepInput(false)
    
    local photoUrl = Config.DefaultPhoto
    if existingData and existingData.photoUrl and existingData.photoUrl ~= "" then
        photoUrl = existingData.photoUrl
    end
    
    SendNUIMessage({
        action = 'openCreationmenu', 
        data = existingData,
        photoUrl = photoUrl
    })
end)

RegisterNetEvent('idcard:showToPlayer')
AddEventHandler('idcard:showToPlayer', function(senderServerId, cardData)
    if not cardData then
        ShowNotification(Config.Messages.no_card, 3000)
        return
    end
    
    local photoUrl = Config.DefaultPhotoCard
    if cardData.photoUrl and cardData.photoUrl ~= "" then
        photoUrl = cardData.photoUrl
    end

    SetNuiFocus(false, false)
    SendNUIMessage({
        action = 'showCard',
        cardData = cardData,
        photoUrl = photoUrl
    })
    
    Citizen.SetTimeout(7000, function()
        SendNUIMessage({ action = 'closeUI' })
    end)
end)

RegisterNetEvent('idcard:showOwnCard')
AddEventHandler('idcard:showOwnCard', function(cardData)
    local photoUrl = Config.DefaultPhotoCard
    if cardData.photoUrl and cardData.photoUrl ~= "" then
        photoUrl = cardData.photoUrl
    end
    
    SetNuiFocus(false, false)
    SendNUIMessage({
        action = 'showCard',
        cardData = cardData,
        photoUrl = photoUrl
    })
    
    Citizen.SetTimeout(5000, function()
        SendNUIMessage({ action = 'closeUI' })
    end)
end)

RegisterNetEvent('idcard:useItem')
AddEventHandler('idcard:useItem', function()
    local closestPlayer, closestDistance = GetClosestPlayer()
    
    if closestPlayer == -1 then
        ShowNotification(Config.Messages.no_player_nearby, 3000)
        return
    end
    
    if closestDistance > Config.ShowCardDistance then
        ShowNotification(Config.Messages.no_player_nearby, 3000)
        return
    end
    
    local targetServerId = GetPlayerServerId(closestPlayer)
    TriggerServerEvent('idcard:requestShowCard', targetServerId)    
end)

RegisterNetEvent('idcard:cardSaved')
AddEventHandler('idcard:cardSaved', function(savedCardData)
    Wait(500)
    TriggerEvent('idcard:showOwnCard', savedCardData)
end)

RegisterNUICallback('saveCard', function(data, cb)
    local isValid, errorType = ValidateAllFields(data)
    
    if not isValid then
        if errorType == "dob" then
            ShowNotification(string.format(Config.Messages.invalid_dob, Config.DateOfBirth.MinYear, Config.DateOfBirth.MaxYear), 4000)
        elseif errorType == "gender" then
            ShowNotification(string.format(Config.Messages.invalid_gender, table.concat(Config.Gender.AllowedValues, ", ")), 4000)
        elseif errorType == "weight" then
            ShowNotification(string.format(Config.Messages.invalid_weight, Config.Weight.Min, Config.Weight.Max, Config.Weight.Unit), 4000)
        elseif errorType == "height" then
            ShowNotification(string.format(Config.Messages.invalid_height, Config.Height.Min, Config.Height.Max, Config.Height.Unit), 4000)
        elseif errorType == "blacklist" then
            ShowNotification(Config.Messages.blacklisted_word, 4000)
        end
        cb({status = 'error'})
        return
    end
    
    local playerPed = PlayerPedId()
    
    SetNuiFocus(false, false)
    SendNUIMessage({ action = 'closeUI' })
    
    ShowNotification(Config.Messages.writing_card, 5000)
    Citizen.InvokeNative(0x524B54361229154F, playerPed, joaat("WORLD_HUMAN_WRITE_NOTEBOOK"), 5000, true, false, false, false)
    Wait(5000)
    ClearPedTasks(playerPed)
    
    ShowNotification(Config.Messages.taking_photo, 2000)
    Wait(3000)
    
    ShowNotification(Config.Messages.card_created, 2000)
    
    local serverData = {
        fullname = data.fullname,
        dateOfBirth = data.dateOfBirth,
        gender = data.gender,
        nationality = data.nationality,
        bornIn = data.bornIn,
        residence = data.residence,
        height = data.height,
        weight = data.weight,
        eyesColor = data.eyesColor,
        hairColor = data.hairColor,
        employed = data.employed,
        signature = data.signature,
        photoUrl = data.photoUrl or ""
    }
    
    TriggerServerEvent('idcard:saveCardData', serverData)
    
    cb({status = 'ok'})
end)

RegisterNUICallback('closeUI', function(data, cb)
    SetNuiFocus(false, false)
    SetNuiFocusKeepInput(true)
    Wait(50)
    SetNuiFocus(false, false)
    SendNUIMessage({ action = 'closeUI' })
    
    cb({status = 'ok'})
end)

RegisterCommand('idcard', function()
    TriggerServerEvent('idcard:requestOwnCard')
end, false)

AddEventHandler('onResourceStop', function(resourceName)
    if GetCurrentResourceName() ~= resourceName then return end
    
    for _, pedData in pairs(spawnedPeds) do
        if DoesEntityExist(pedData.ped) then
            DeleteEntity(pedData.ped)
        end
        if pedData.prompt then
            DeletePrompt(pedData.prompt)
        end
    end
end)