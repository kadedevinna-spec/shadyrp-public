if Config.framework == 'rsg-core' then
    local myChars          = {}
    charselectpeds         = {}
    headsonscreen          = {}
    PedAccess              = false
    PlayerInfo             = {}
    PlayerSex              = {}
    local RSGCore          = exports['rsg-core']:GetCoreObject()
    local currentCharacter = nil
    local creatingCharacter = false -- Prevent duplicate character creation
    local pendingPeds = 0 -- Track async ped creation
    local totalPedsToCreate = 0

    -- Helper function to add pin to headsonscreen when ped is ready
    local function AddPedToHeadsonscreen(pedHandler, key, name, ExistingChar)
        Wait(500)
        local headCoords = GetPedBoneCoords(pedHandler, 21030, 0.0, 0.0, 0.0)
        local retval, headx, heady = GetScreenCoordFromWorldCoord(headCoords.x, headCoords.y, headCoords.z + 0.2)
        
        table.insert(headsonscreen, {
            id = key,
            name = name,
            ExistingChar = ExistingChar,
            startPosition = {
                x = headx,
                y = heady
            }
        })
        pendingPeds = pendingPeds - 1
    end

    RegisterNetEvent('murphy_creator:LaunchCharSelect', function(characters, pedperm, slots)
        currentCharacter = nil
        creatingCharacter = false -- Reset character creation flag
        pendingPeds = 0
        totalPedsToCreate = 0
        if Config.CustomLoadingScreen then
            while GetIsLoadingScreenActive() do
                Wait(500)
            end
            -- Wait for the custom loading screen NUI to shut down on its own
            while SendLoadingScreenMessage('{}') do
                Wait(500)
            end
        else
            ShutdownLoadingScreen()
            ShutdownLoadingScreenNui()
        end
        -- Protection: empêcher la boucle mort de rsg-medic pendant le menu
        if LocalPlayer and LocalPlayer.state then
            LocalPlayer.state:set('invincible', true, true)
        end
        headsonscreen          = {}
        charselectpeds         = {}
        myChars                = {}
        PlayerInfo             = {}
        PlayerSex              = {}
        ActiveCam              = 0
        currentCamDestionation = ""
        camCoords              = {}
        baseHeading            = false
        rotatePedIndex         = 0
        PedAccess              = pedperm
        DoScreenFadeOut(500)
        Wait(500)
        DisplayRadar(false)
        DisplayHud(false)
        SetEntityCoords(PlayerPedId(), Config.CharSelect.playerSpawn.coords)
        FreezeEntityPosition(PlayerPedId(), true)
        SetEntityInvincible(PlayerPedId(), true)
        SetEntityCanBeDamaged(PlayerPedId(), false)
        SpawnCharSelectProps()
        MoveCam("charselect",
            {
                coords = DecorSettings.charselectcam.coords,
                target = DecorSettings.charselectcam.target,
                fov =
                    DecorSettings.charselectcam.fov
            }, true)
        local remainingslots = slots

        for key, value in pairs(characters) do
            myChars[#myChars + 1] = value
        end
        DebugPrint("Remaining slots: " .. remainingslots)
        DebugPrint("myChars: " .. #myChars)
        
        -- Calculate actual available slots (can be negative if player has more chars than allowed slots)
        local availableNewSlots = remainingslots - #myChars
        
        -- Only add empty character slots if player has slots available
        if availableNewSlots > 0 then
            for i = 1, availableNewSlots do
                table.insert(myChars, { charIdentifier = 0 })
            end
        end
        
        -- Always display ALL existing characters, regardless of slot count
        local totalSlotsToDisplay = math.max(#myChars, remainingslots)
        local slotCounter = totalSlotsToDisplay
        
        -- Count total peds to create for async tracking
        totalPedsToCreate = math.min(#myChars, totalSlotsToDisplay)
        pendingPeds = totalPedsToCreate
        
        for key, value in pairs(myChars) do
            local data = DecorSettings.pedslots[slotCounter]
            if slotCounter > 0 then
                slotCounter = slotCounter - 1
            else
                break
            end
            if value.citizenid ~= nil then
                PlayerInfo[key] = {
                    firstname = value.charinfo.firstname,
                    lastname = value.charinfo.lastname,
                    characterid = value.citizenid,
                    informations = value.informations,
                    charid = value.citizenid,
                }
                if value.charinfo.gender == 0 then
                    PlayerSex[key] = 1
                else
                    PlayerSex[key] = 0
                end
                if value.peddata and next(value.peddata) ~= nil then
                    local peddata = value.peddata
                    local model = GetHashKey(peddata.pedmodel.model)
                    RequestModel(model)
                    while not HasModelLoaded(model) do
                        Wait(100)
                    end

                    SetPlayerModel(PlayerId(), model)
                    -- EquipMetaPedOutfitPreset(PlayerPedId(), 0, false)
                    -- local PedHandler = PlayerPedId()
                    IsPedReadyToRender(PlayerPedId())
                    -- while not DoesEntityExist(PlayerPedId()) do
                    --     Wait(100)
                    -- end
                    if peddata.pedmodel.model ~= "mp_female" and peddata.pedmodel.model ~= "mp_male" then
                        EquipMetaPedOutfitPreset(PlayerPedId(), peddata.pedmodel.outfit, false)
                    end

                    RemoveHairsAndBeards(PlayerPedId())
                    ApplyCachePedDataToPed(PlayerPedId(), peddata, value.citizenid)
                    Wait(3000)
                    data.PedHandler = ClonePed(PlayerPedId(), false, true, true)
                    charselectpeds[key] = data.PedHandler
                    SetEntityCoords(data.PedHandler, data.coords)
                    SetEntityHeading(data.PedHandler, data.heading)
                    NetworkSetEntityInvisibleToNetwork(data.PedHandler, true)
                    SetEntityAsMissionEntity(data.PedHandler, true, true)
                    -- Citizen.InvokeNative(0x283978A15512B2FE, data.PedHandler, true) -- random outfit
                    SetEntityInvincible(data.PedHandler, true)
                    SetEntityCanBeDamagedByRelationshipGroup(data.PedHandler, false, GetHashKey("PLAYER"))
                    -- Add pin for this ped (sync path)
                    local charName = value.charinfo.firstname .. " " .. value.charinfo.lastname
                    Citizen.CreateThread(function()
                        AddPedToHeadsonscreen(data.PedHandler, key, charName, true)
                    end)
                else
                    DebugPrint("Loading existing character: " .. tostring(value.citizenid))
                    local capturedKey = key
                    local capturedName = value.charinfo.firstname .. " " .. value.charinfo.lastname
                    RSGCore.Functions.TriggerCallback('rsg-multicharacter:server:getAppearance', function(appearance)
                        if appearance == nil or next(appearance) == nil then
                            DebugPrint("No appearance data found for character: " .. tostring(value.citizenid))
                            pendingPeds = pendingPeds - 1 -- Still decrement even on failure
                        else
                            local skinTable = appearance.skin or {}
                            DataSkin = appearance.skin
                            local clothesTable = appearance.clothes or {}
                            local sex = tonumber(skinTable.sex) == 1 and `mp_male` or `mp_female`
                            DebugPrint("Loading skin for character: " .. tostring(value.citizenid))
                            if sex ~= nil then
                                RequestModel(sex)
                                while not HasModelLoaded(sex) do
                                    Wait(0)
                                end
                                data.PedHandler = CreatePed(sex, data.coords, 0.0, false, false, false, false)
                                repeat Wait(0) until DoesEntityExist(data.PedHandler)
                                charselectpeds[capturedKey] = data.PedHandler
                                -- EquipMetaPedOutfitPreset(data.PedHandler, 0, false)
                                SetEntityCoords(data.PedHandler, data.coords)
                                SetEntityHeading(data.PedHandler, data.heading)
                                FreezeEntityPosition(data.PedHandler, false)
                                SetEntityInvincible(data.PedHandler, true)
                                SetBlockingOfNonTemporaryEvents(data.PedHandler, true)
                                NetworkSetEntityInvisibleToNetwork(data.PedHandler, true)
                                SetEntityAsMissionEntity(data.PedHandler, true, true)
                                DebugPrint(data.PedHandler, Citizen.InvokeNative(0xA0BC8FAED8CFEB3C, data.PedHandler),
                                    GetEntityCoords(data.PedHandler))
                                while Citizen.InvokeNative(0xA0BC8FAED8CFEB3C, data.PedHandler) ~= 1 do
                                    Wait(1)
                                end
                                exports['rsg-appearance']:ApplySkinMultiChar(skinTable, data.PedHandler, clothesTable)
                                DebugPrint("Character skin applied: " .. tostring(value.citizenid))
                                TriggerEvent("murphy_clothes:ApplyClothesToCharid", value.citizenid, data.PedHandler)
                                TriggerEvent("murphy_barber_creator:loadbarberoverlayOnCharacter", value.citizenid,
                                    data.PedHandler)
                                -- Add pin for this ped (async path - inside callback)
                                AddPedToHeadsonscreen(data.PedHandler, capturedKey, capturedName, true)
                            else
                                pendingPeds = pendingPeds - 1 -- Decrement if sex is nil
                            end
                        end
                    end, value.citizenid)
                end
            else
                DebugPrint("Loading new character: " .. tostring(value.citizenid))
                local NPCGender = "Female"
                local genderrole = math.random(1, 2)
                if genderrole == 1 then NPCGender = "Male" end
                local model = GetHashKey("mp_female")
                if NPCGender == "Male" then
                    model = GetHashKey("mp_male")
                end
                RequestModel(model)
                while not HasModelLoaded(model) do
                    Wait(100)
                end
                data.PedHandler = CreatePed_2(model, 0.0, 0.0, 0.0, 0.0, false, true)
                while not DoesEntityExist(data.PedHandler) do
                    Wait(100)
                end

                SetEntityCoords(data.PedHandler, data.coords)
                SetEntityHeading(data.PedHandler, data.heading)
                charselectpeds[key] = data.PedHandler
                NetworkSetEntityInvisibleToNetwork(data.PedHandler, true)
                SetEntityAsMissionEntity(data.PedHandler, true, true)
                Citizen.InvokeNative(0x283978A15512B2FE, data.PedHandler, true)
                SetEntityInvincible(data.PedHandler, true)
                SetEntityCanBeDamagedByRelationshipGroup(data.PedHandler, false, GetHashKey("PLAYER"))
                EquipMetaPedOutfitPreset(data.PedHandler, 3, false)
                -- FreezeEntityPosition(ped, true)
                SetEntityAlpha(data.PedHandler, 150, false)
                -- Add pin for new character slot (sync path)
                local newCharKey = key
                local newCharPed = data.PedHandler
                Citizen.CreateThread(function()
                    AddPedToHeadsonscreen(newCharPed, newCharKey, "none", false)
                end)
            end
            if data.PedHandler and data.scenario then
                TaskStartScenarioInPlace(data.PedHandler, data.scenario, -1, false)
            end
            if data.PedHandler and data.scenariopoint then
                local DataStruct = DataView.ArrayBuffer(256 * 4)
                local is_data_exists = Citizen.InvokeNative(0x345EC3B7EBDE1CB5, GetEntityCoords(data.PedHandler), 1.5,
                    DataStruct:Buffer(), 10)
                if is_data_exists ~= false then
                    for i = 1, is_data_exists, 1 do
                        local scenario = DataStruct:GetInt32(8 * i)
                        local hash = GetScenarioPointType(scenario)
                        DebugPrint("Scenario Hash: " .. hash)
                        if data.scenariopoint == hash then
                            TaskUseScenarioPoint(data.PedHandler, scenario, 0, 0, false);
                        end
                    end
                end
            end
        end

        -- Wait for all async ped creations to complete
        local waitAttempts = 0
        local maxWaitAttempts = 300 -- 30 seconds max
        while pendingPeds > 0 and waitAttempts < maxWaitAttempts do
            Wait(100)
            waitAttempts = waitAttempts + 1
        end

        DebugPrint("headsonscreen: " .. #headsonscreen)
        DebugPrint(json.encode(headsonscreen))
        SetEntityVisible(PlayerPedId(), false, false)
        SetEntityAlpha(PlayerPedId(), 0, false)
        SendNUIMessage(
            {
                type = "updateElemSelectCharMenu",
                pinsSelectChar = {},
            }
        )
        DoScreenFadeIn(500)
        Wait(500)

        SetNuiFocus(true, true)
        SendNUIMessage({ type = "setLocale", locale = Config.Locale })
        SendNUIMessage(
            {
                type = "openSelectCharMenu",
                pinsSelectChar = headsonscreen,
            }
        )
    end)

    RegisterNetEvent("murphy_creator:PlaySelectedChar", function(id)
        -- Validate character ID and data
        if not myChars[id] or not myChars[id].citizenid then
            print("^1[MURPHY CREATOR ERROR]^7 Invalid character ID or missing citizenid")
            return
        end
        
        -- CRITICAL: Set currentCharacter BEFORE loading to prevent race condition
        currentCharacter = myChars[id].citizenid
        DebugPrint("Loading character: " .. tostring(currentCharacter))
        
        ResetEntityAlpha(PlayerPedId())
        SetEntityVisible(PlayerPedId(), true, false)
        TriggerServerEvent("murphy_creator:RemovePlayerFromInstance")
        DoScreenFadeOut(0)
        repeat Wait(0) until IsScreenFadedOut()
        Wait(1000)
        CleanupCharSelectProps()
        SwitchOffCam(false)
        DisplayRadar(true)
        DisplayHud(true)
        
        -- Load the selected character data
        TriggerServerEvent('rsg-multicharacter:server:loadUserData', myChars[id])
        Wait(5000)
        
        -- Verify the correct character was loaded
        local PlayerData = RSGCore.Functions.GetPlayerData()
        local attempts = 0
        local maxAttempts = 50  -- 5 seconds max
        
        while PlayerData.citizenid ~= currentCharacter and attempts < maxAttempts do
            Wait(100)
            PlayerData = RSGCore.Functions.GetPlayerData()
            attempts = attempts + 1
            if attempts % 10 == 0 then
                DebugPrint("Waiting for character sync (" .. attempts .. "/" .. maxAttempts .. "): Expected " .. tostring(currentCharacter) .. ", Got " .. tostring(PlayerData.citizenid))
            end
        end
        
        -- Check if correct character loaded
        if PlayerData.citizenid ~= currentCharacter then
            print("^1[MURPHY CREATOR ERROR]^7 Character mismatch! Expected: " .. tostring(currentCharacter) .. ", Got: " .. tostring(PlayerData.citizenid))
            print("^1[MURPHY CREATOR ERROR]^7 Aborting character load to prevent loading wrong character")
            return
        end
        
        DebugPrint("Character verified successfully: " .. tostring(PlayerData.citizenid))
        
        TriggerServerEvent('rsg-appearance:server:LoadSkin')
        Wait(500)
        TriggerServerEvent('rsg-appearance:server:LoadClothes', 1)
        
        local ped = PlayerPedId()
        FreezeEntityPosition(ped, false)
        -- Use saved position from DB (captured before char select could corrupt it)
        -- Fallback to PlayerData.position if savedPosition is not available
        local pos = myChars[id].savedPosition or PlayerData.position
        if pos then
            SetEntityCoords(ped, pos.x, pos.y, pos.z)
            SetEntityHeading(ped, pos.w or 0.0)
        end
        TriggerServerEvent('RSGCore:Server:OnPlayerLoaded')
        TriggerEvent('RSGCore:Client:OnPlayerLoaded')

        if PlayerData.metadata["injail"] > 0 then
            Wait(2000)
            TriggerEvent('rsg-prison:client:prisonclothes')
        end
    end)

    AddEventHandler("RSGCore:Client:OnPlayerLoaded", function()
        if currentCharacter == nil then
            DebugPrint("Skipping Murphy OnPlayerLoaded skin sync because no Murphy character context is active")
            return
        end
        Wait(1000)
        -- Ne retire pas l’invincibilité avant le chargement du skin
        if LocalPlayer and LocalPlayer.state then
            LocalPlayer.state:set('invincible', true, true)
        end
        SetEntityInvincible(PlayerPedId(), true)
        SetEntityCanBeDamaged(PlayerPedId(), false)
        TriggerEvent("murphy_creator:loadskin")
    end)
    local healthinit = false
    RegisterNetEvent("murphy_creator:loadskin", function()
        if LocalPlayer and LocalPlayer.state and LocalPlayer.state.murphy_appearance_paused then
            DebugPrint("Appearance paused, skipping loadskin")
            return
        end
        local currentPlayerData = RSGCore.Functions.GetPlayerData()
        if currentCharacter == nil then
            currentCharacter = currentPlayerData and currentPlayerData.citizenid or nil
            if currentCharacter == nil then
                DebugPrint("Skipping Murphy loadskin because no current character is active yet")
                return
            end
        end
        -- Sécuriser toute la phase de swap model/skin
        if LocalPlayer and LocalPlayer.state then
            LocalPlayer.state:set('invincible', true, true)
        end
        SetEntityInvincible(PlayerPedId(), true)
        SetEntityCanBeDamaged(PlayerPedId(), false)
        
        -- CRITICAL: Disable health regeneration during skin loading
        -- Save current health to restore it after loading
        local savedHealth = GetEntityHealth(PlayerPedId())
        local savedHealthCore = Citizen.InvokeNative(0x36731AC041289BB1, PlayerPedId(), 0) -- _GET_ATTRIBUTE_CORE_VALUE (health core)

        Callback.triggerServer("murphy_creator:GetPedData", function(peddata)
            DebugPrint("Loading skin data")
            CachePedData = peddata
            local PlayerData = RSGCore.Functions.GetPlayerData()
            local syncAttempts = 0
            local maxSyncAttempts = 100  -- 10 seconds max
            
            repeat
                Wait(100)
                syncAttempts = syncAttempts + 1
                if syncAttempts % 10 == 0 or syncAttempts == 1 then
                    DebugPrint("Syncing PlayerData (" .. syncAttempts .. "/" .. maxSyncAttempts .. "): " ..
                        tostring(PlayerData.citizenid) .. " vs " .. tostring(currentCharacter))
                end
                PlayerData = RSGCore.Functions.GetPlayerData()
            until PlayerData.citizenid == currentCharacter or syncAttempts >= maxSyncAttempts
            
            -- Check if sync failed
            if syncAttempts >= maxSyncAttempts then
                print("^1[MURPHY CREATOR ERROR]^7 Failed to sync PlayerData after " .. maxSyncAttempts .. " attempts!")
                print("^1[MURPHY CREATOR ERROR]^7 Expected: " .. tostring(currentCharacter) .. ", Got: " .. tostring(PlayerData.citizenid))
                -- Reset invincibility and abort
                SetEntityInvincible(PlayerPedId(), false)
                SetEntityCanBeDamaged(PlayerPedId(), true)
                if LocalPlayer and LocalPlayer.state then
                    LocalPlayer.state:set('invincible', false, true)
                end
                return
            end
            
            DebugPrint("PlayerData synchronized successfully")
            local isDead = PlayerData.metadata["isdead"]
            if isDead == nil then isDead = false end
            DebugPrint("Player is dead: " .. tostring(isDead))
            if isDead == true then return end -- Si mort, on ne charge pas le skin (évite les bugs)
            
            -- Vérifier si le model doit être changé
            local currentModel = GetEntityModel(PlayerPedId())
            local targetModel = nil
            if CachePedData and CachePedData.pedmodel and CachePedData.pedmodel.model then
                targetModel = GetHashKey(CachePedData.pedmodel.model)
            end
            local needsModelChange = (targetModel == nil) or (currentModel ~= targetModel)
            
            local ped
            local healthCore, stamCore, health, stam
            
            -- Sauvegarder les valeurs de vie/stamina AVANT le changement de modèle si nécessaire
            if needsModelChange then
                healthCore = GetAttributeCoreValue(PlayerPedId(), 0) -- Get health core value
                stamCore = GetAttributeCoreValue(PlayerPedId(), 1)   -- Get stamina core value
                health = GetEntityHealth(PlayerPedId())              -- Get health value
                stam = Citizen.ResultAsFloat(Citizen.InvokeNative(0x22F2A386D43048A9, PlayerPedId()))
                DebugPrint("Model needs change, saving health/stamina - HealthCore: " .. tostring(healthCore) .. ", StamCore: " .. tostring(stamCore) .. ", Health: " .. tostring(health) .. ", Stam: " .. tostring(stam))
            else
                DebugPrint("Model already correct, skipping health/stamina save/restore")
            end

            if next(CachePedData) == nil then
                --- If no data in murphy_creator, load default skin for framework
                DebugPrint("No skin data in murphy_creator")
                TriggerServerEvent('rsg-appearance:server:LoadSkin')
            else
                local model = CachePedData.pedmodel.model
                local outfit = CachePedData.pedmodel.outfit
                DebugPrint("Loading skin: " .. model .. " : " .. outfit)
                ped = PlayerPedId()
                if model == "mp_male" or model == "mp_female" then
                    if needsModelChange then
                        RequestModel(GetHashKey(model))
                        while not HasModelLoaded(GetHashKey(model)) do
                            Wait(1)
                        end
                        SetPlayerModel(PlayerId(), GetHashKey(model))
                        Wait(1000)
                        SetModelAsNoLongerNeeded(GetHashKey(model))
                    end
                    ped = PlayerPedId()
                    CachePed = PlayerPedId()


                    if model == "mp_female" then
                        Citizen.InvokeNative(0x77FF8D35EEC6BBC4, CachePed, 2, false)    -- EquipMetaPedOutfitPreset avec preset 2

                        while not Citizen.InvokeNative(0xA0BC8FAED8CFEB3C, CachePed) do -- IsPedReadyToRender
                            Wait(0)
                        end

                        Citizen.InvokeNative(0x0BFA1BD465CDFEFD, CachePed)                                 -- ResetPedComponents

                        Citizen.InvokeNative(0xAAB86462966168CE, CachePed, true)                           -- Fixes outfit
                        Citizen.InvokeNative(0xCC8CA3E88256E58F, CachePed, false, true, true, true, false) -- UpdatePedVariation
                    else
                        Citizen.InvokeNative(0x77FF8D35EEC6BBC4, CachePed, 0, false)                       -- EquipMetaPedOutfitPreset avec preset 0

                        while not Citizen.InvokeNative(0xA0BC8FAED8CFEB3C, CachePed) do                    -- IsPedReadyToRender
                            Wait(0)
                        end
                    end

                    local SkinColor   = DefaultChar[CachePedData.gender][CachePedData.skintone]
                    local legs        = tonumber("0x" .. SkinColor.Legs[CachePedData.lowerbody])
                    local bodyType    = tonumber("0x" .. SkinColor.Body[CachePedData.upperbody])
                    local heads       = tonumber("0x" .. SkinColor.Heads[CachePedData.head])
                    local headtexture = joaat(SkinColor.HeadTexture[1])
                    local albedo      = texture_types[CachePedData.gender].albedo
                    DebugPrint(CachePed, "Heads:", heads, "BodyType:", bodyType, "Legs:", legs, "HeadTexture:", headtexture,
                        "Albedo:", albedo)
                    IsPedReadyToRender(CachePed)
                    RemoveAllClothesExceptEssentials(CachePed)
                    ApplyShopItemToPed(heads, CachePed)
                    ApplyShopItemToPed(bodyType, CachePed)
                    ApplyShopItemToPed(legs, CachePed)
                    Citizen.InvokeNative(0xC5E7204F322E49EB, albedo, headtexture, 0x7FC5B1E1)
                    UpdatePedVariation(CachePed)
                    if CachePedData.head > 0 then
                        DebugPrint("Loading head: " .. CachePedData.head)
                        local head = tonumber("0x" ..
                            DefaultChar[CachePedData.gender][CachePedData.skintone].Heads[CachePedData.head])
                        ApplyShopItemToPed(head, CachePed)
                    end
                    if CachePedData.lowerbody > 0 then
                        local comp = DefaultChar[CachePedData.gender][CachePedData.skintone].Legs
                            [CachePedData.lowerbody]
                        ApplyShopItemToPed(tonumber("0x" .. comp), CachePed)
                        TriggerEvent("murphy_clothes:Loadlowerbody", tonumber("0x" .. comp))
                    end
                    if CachePedData.upperbody > 0 then
                        local comp = DefaultChar[CachePedData.gender][CachePedData.skintone].Body
                            [CachePedData.upperbody]
                        ApplyShopItemToPed(tonumber("0x" .. comp), CachePed)
                        TriggerEvent("murphy_clothes:Loadupperbody", tonumber("0x" .. comp))
                    end
                    if CachePedData.body > 0 then
                        local comp = tonumber(Body[CachePedData.body])
                        EquipMetaPedOutfit(comp, CachePed)
                    end
                    if CachePedData.waist > 0 then
                        local comp = tonumber(Waist[CachePedData.waist])
                        EquipMetaPedOutfit(comp, CachePed)
                    end
                else
                    NPCAssetsToPed(model, outfit, PlayerPedId())
                    CachePed = PlayerPedId()
                end


                if CachePedData.teeth > 0 then
                    ApplyShopItemToPed(Teeth[CachePedData.gender][CachePedData.teeth].hash, CachePed)
                end

                if CachePedData.eyes > 0 then
                    ApplyShopItemToPed(Eyes[CachePedData.gender][CachePedData.eyes], CachePed)
                end
                IsPedReadyToRender(CachePed)
                for k, v in pairs(CachePedData.expressions) do
                    DebugPrint("Expression: " .. k .. " : " .. v)
                    SetCharExpression(CachePed, ExpressionsHashes[k], v)
                end
                UpdatePedVariation(CachePed)
            end
            TriggerEvent("murphy_clothing:loadclothes")
            TriggerEvent("murphy_barber_creator:loadbarberoverlay")

            Wait(1000)
            
            local currentHealth
            DebugPrint("Is Dead: " .. tostring(isDead), isDead)
            if isDead == true then
                currentHealth = 0
            else
                if healthinit == true then
                    currentHealth = 600
                    TriggerServerEvent('rsg-medic:server:SetHealth', currentHealth)
                    healthinit = false
                else
                    currentHealth = PlayerData.metadata["health"]
                    -- Sécurité: éviter 0 HP avec isDead=false
                    if (not currentHealth or currentHealth <= 0) then
                        currentHealth = 100
                        TriggerServerEvent('rsg-medic:server:SetHealth', currentHealth)
                    end
                end
            end
            
            -- Use the LOWEST value between saved health and metadata health to prevent health gain
            -- This prevents health regeneration during skin loading
            if savedHealth and savedHealth > 0 and savedHealth < currentHealth and not healthinit then
                DebugPrint("Preventing health regeneration - using saved health: " .. savedHealth .. " instead of " .. currentHealth)
                currentHealth = savedHealth
            end
            
            DebugPrint("Current Health: " .. tostring(currentHealth))
            SetEntityHealth(PlayerPedId(), currentHealth)

            -- Restaurer vie/stamina SEULEMENT si le modèle a été changé
            if needsModelChange then
                Citizen.InvokeNative(0xC6258F41D86676E0, PlayerPedId(), 0, healthCore) -- Set Health Core back to what it was
                Citizen.InvokeNative(0xC6258F41D86676E0, PlayerPedId(), 1, stamCore)   -- Set Stamina Core back to what it was
                Citizen.InvokeNative(0x675680D089BFA21F, PlayerPedId(), stam or 100.0) -- RestorePedStamina
                DebugPrint("Restored health/stamina after model change")
            else

            end

            SetEntityInvincible(PlayerPedId(), false)
            SetEntityCanBeDamaged(PlayerPedId(), true)
            if LocalPlayer and LocalPlayer.state then
                LocalPlayer.state:set('invincible', false, true)
            end
        end)
    end)

    RegisterNetEvent("murphy_creator:createnewchar", function(data)
        if creatingCharacter then
            DebugPrint("Character creation already in progress, ignoring duplicate call")
            return
        end
        creatingCharacter = true
        currentCharacter = nil
        ResetEntityAlpha(PlayerPedId())
        SetEntityVisible(PlayerPedId(), true, false)
        CleanupCharSelectProps()
        TriggerServerEvent('rsg-multicharacter:server:createCharacter', data)
        Wait(2000)
        exports.weathersync:setSyncEnabled(true)
        TriggerServerEvent('RSGCore:Server:OnPlayerLoaded')
        TriggerEvent('RSGCore:Client:OnPlayerLoaded')
        TriggerServerEvent("murphy_creator:RemovePlayerFromInstance")
        Wait(2000)
        healthinit = true
        creatingCharacter = false
        -- TriggerEvent("murphy_creator:loadskin")
    end)
    RegisterNetEvent("murphy_creator:rsg:getcitizenid", function(charid)
        DebugPrint("Received citizenid for new char: " .. tostring(charid))
        currentCharacter = charid
    end)
end
