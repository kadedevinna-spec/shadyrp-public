
local pendingAnimationRequests = {}
local currentNotificationRequester = nil
local ActiveCouplePairs = {}
local ActiveCouplePartner = nil

local function SetCoupleCollision(pedA, pedB, disable)
  if not pedA or not pedB then return end
  if not DoesEntityExist(pedA) or not DoesEntityExist(pedB) then return end
  SetEntityNoCollisionEntity(pedA, pedB, disable)
  SetEntityNoCollisionEntity(pedB, pedA, disable)
  if disable then
    for _, pair in ipairs(ActiveCouplePairs) do
      if (pair.a == pedA and pair.b == pedB) or (pair.a == pedB and pair.b == pedA) then return end
    end
    ActiveCouplePairs[#ActiveCouplePairs + 1] = {a = pedA, b = pedB}
  end
end

local function RestoreAllCoupleCollision()
  for i = #ActiveCouplePairs, 1, -1 do
    local pair = ActiveCouplePairs[i]
    if pair then
      local a, b = pair.a, pair.b
      if a and b and DoesEntityExist(a) and DoesEntityExist(b) then
        SetEntityNoCollisionEntity(a, b, false)
        SetEntityNoCollisionEntity(b, a, false)
        ClearPedTasks(a)
        ClearPedSecondaryTask(a)
        FreezeEntityPosition(a, false)
        SetEntityCollision(a, true, true)
        SetPedCanRagdoll(a, true)
        ClearPedTasks(b)
        ClearPedSecondaryTask(b)
        FreezeEntityPosition(b, false)
        SetEntityCollision(b, true, true)
        SetPedCanRagdoll(b, true)
      end
    end
    ActiveCouplePairs[i] = nil
  end
end

local function RestoreCoupleCollisionLocal(notifyServer)
  if notifyServer and ActiveCouplePartner then
    TriggerServerEvent('v-emotemenu:server:restoreCoupleCollision', ActiveCouplePartner)
  end
  RestoreAllCoupleCollision()
  ActiveCouplePartner = nil
end
function ResetAllCouple()
  RestoreAllCoupleCollision()
  RestoreCoupleCollisionLocal()
end

RegisterNetEvent('v-emotemenu:client:restoreCoupleCollision', function()
  RestoreCoupleCollisionLocal(true)
end)

RegisterNetEvent('v-emotemenu:client:remoteRestoreCoupleCollision', function()
  RestoreCoupleCollisionLocal(false)

end)
local CoupleDebug = {
  enabled = false,
  ped = nil
}
local AlignCouplePeds
local EnsureCoupleDebugPed
local ClearCoupleDebugPed

function GetNearestPlayer()
    local playerPed = PlayerPedId()
    local playerCoords = GetEntityCoords(playerPed)
    local nearestPlayer = nil
    local nearestDistance = 3.0

    for _, player in ipairs(GetActivePlayers()) do
        local otherPlayerPed = GetPlayerPed(player)
        if otherPlayerPed ~= playerPed then
            local otherCoords = GetEntityCoords(otherPlayerPed)
            local distance = #(playerCoords - otherCoords)
            if distance < nearestDistance then
                nearestDistance = distance
                nearestPlayer = player
            end
        end
    end

    return nearestPlayer
end

function PlayCoupleAnimation(category, animationKey, animationData)
    local targetPlayer = GetNearestPlayer()
    if targetPlayer then
        local targetServerId = GetPlayerServerId(targetPlayer)
        local requesterServerId = GetPlayerServerId(PlayerId())
        SendNUIMessage({ action = "PLAY_SOUND", sound = "click" })
        local myPed = PlayerPedId()
        local coords = GetEntityCoords(myPed)
        local heading = GetEntityHeading(myPed)
        TriggerServerEvent('v-emotemenu:server:requestAnimationSync', requesterServerId, targetServerId, category, animationKey, animationData, { x = coords.x, y = coords.y, z = coords.z }, heading)
  else
    Notify("No nearby player found for couple animation.", "error", 3000)
    

    if CoupleDebug.enabled and animationData and animationData.player and animationData.target then
      local debugPed = EnsureCoupleDebugPed()
      if debugPed then
        local myPed = PlayerPedId()
        ClearPedTasksImmediately(myPed)
        ClearPedTasksImmediately(debugPed)

        local coords = GetEntityCoords(myPed)
        local heading = GetEntityHeading(myPed)
        AlignCouplePeds(myPed, debugPed, animationData.player, animationData.target, coords, heading)
        Notify("DEBUG: Playing couple animation with local debug partner.", "info", 3000)
      else
        Notify("DEBUG: Failed to create debug partner ped.", "error", 3000)
      end
    end
  end
end

RegisterNetEvent('v-emotemenu:client:receiveAnimationRequest', function(requesterId, category, animationKey, animationData)
    local requesterPed = GetPlayerFromServerId(requesterId)
    
    local requesterName = "Unknown"
    if requesterPed and requesterPed ~= -1 then
        requesterName = GetPlayerName(requesterPed) or "Unknown"
    end
    
    local animationTitle = animationKey
    if animationData and animationData.title then
        animationTitle = animationData.title
    end
    
    pendingAnimationRequests[requesterId] = {
        category = category,
        animationKey = animationKey,
        animationData = animationData
    }
    
    currentNotificationRequester = requesterId
    
    SendNUIMessage({
        action = "SHOW_ANIMATION_REQUEST",
        senderName = requesterName,
        animationTitle = animationTitle,
        key = Config.Keybinds["REQUEST_ACCEPT_NAME"]
    })
    
    Citizen.SetTimeout(10000, function()
        if currentNotificationRequester == requesterId then
            pendingAnimationRequests[requesterId] = nil
            currentNotificationRequester = nil
            SendNUIMessage({
                action = "HIDE_ANIMATION_REQUEST"
            })
        end
    end)
end)

local function ResolveAnimFlag(loop, movable, stopLastFrame)
  if not loop and not movable and not stopLastFrame then
    return 0
  elseif loop and not movable then
    return 1
  elseif not loop and not movable and stopLastFrame then
    return 2
  elseif not loop and movable and stopLastFrame then
    return 30
  elseif loop and movable then
    return 31
  elseif not loop and movable then
    return 28
  end
  return 0
end

local function OffsetFromCoord(basePos, heading, offY, offX, offZ, groundSnapWhenZero)
  local rad = math.rad(heading)
  local fx = math.sin(rad)
  local fy = -math.cos(rad)
  local rx = -fy
  local ry =  fx

  local baseX = basePos.x or 0.0
  local baseY = basePos.y or 0.0
  local baseZ = basePos.z or 0.0
  local x = baseX + (offY or 0.0) * fx + (offX or 0.0) * rx
  local y = baseY + (offY or 0.0) * fy + (offX or 0.0) * ry

  local z
  local zOff = tonumber(offZ) or 0.0
  if groundSnapWhenZero and zOff == 0.0 then
    local found, gz = GetGroundZFor_3dCoord(x, y, baseZ + 1.0, false)
    z = found and (gz + 0.02) or baseZ
  else
    z = baseZ + zOff
  end

  return vector3(x, y, z)
end

local function RequestEntityControl(entity)
  if not entity or not DoesEntityExist(entity) then return end
  if NetworkHasControlOfEntity(entity) then return end

  local attempts = 0
  NetworkRequestControlOfEntity(entity)
  while attempts < 15 and not NetworkHasControlOfEntity(entity) do
    Citizen.Wait(0)
    NetworkRequestControlOfEntity(entity)
    attempts = attempts + 1
  end
end

local function HasEffectiveControl(entity)
  if not entity or not DoesEntityExist(entity) then return false end
  if entity == PlayerPedId() then return true end
  return NetworkHasControlOfEntity(entity)
end

local function PlayAnimSmart(ped, data, worldPos, baseHeading)
  if not data then return end
  local dict, anim = data.dict, data.anim
  local o = data.options or {}
  local flag = data.flag or ResolveAnimFlag(o.loop or false, o.movable or false, o.stop_last_frame or false)

  if dict and anim then
    RequestAnimDict(dict)
    while not HasAnimDictLoaded(dict) do Citizen.Wait(0) end

    local rx = tonumber(data.rotX) or 0.0
    local ry = tonumber(data.rotY) or 0.0
    local rz = tonumber(data.rotZ) or 0.0

    if worldPos or data.rotX or data.rotY or data.rotZ then
      local px, py, pz = worldPos and worldPos.x or GetEntityCoords(ped).x, worldPos and worldPos.y or GetEntityCoords(ped).y, worldPos and worldPos.z or GetEntityCoords(ped).z
      local heading = baseHeading or GetEntityHeading(ped)
      TaskPlayAnimAdvanced(ped, dict, anim, px, py, pz, rx, ry, heading + rz, 8.0, 8.0, -1, flag, 0.0, 0, 0)
    else
      TaskPlayAnim(ped, dict, anim, 1.0, 1.0, -1, flag, 0.0, false, false, false)
    end
    SetPedKeepTask(ped, true)
  elseif data.emote then
    local emoteHash = GetHashKey(data.emote)
    if string.find(data.emote, "KIT_EMOTE") then
      TaskEmote(ped, 0, 2, emoteHash, true, true, true, true, true)
    else
      TaskStartScenarioInPlace(ped, emoteHash, 0, true)
    end
    SetPedKeepTask(ped, true)
  end
end

AlignCouplePeds = function(playerPedEntity, targetPedEntity, playerData, targetData, baseCoords, baseHeading)
  if not playerPedEntity or not DoesEntityExist(playerPedEntity) then return end
  if not targetPedEntity or not DoesEntityExist(targetPedEntity) then return end
  if not playerData or not targetData then return end

  SetEntityNoCollisionEntity(playerPedEntity, targetPedEntity, true)
  SetEntityNoCollisionEntity(targetPedEntity, playerPedEntity, true)

  local pX  = tonumber(playerData.posX) or 0.0
  local pY  = tonumber(playerData.posY) or 0.0
  local pZ  = tonumber(playerData.posZ) or 0.0
  local pRZ = tonumber(playerData.rotZ) or 0.0

  local tX  = tonumber(targetData.posX) or 0.0
  local tY  = tonumber(targetData.posY) or 0.0
  local tZ  = tonumber(targetData.posZ) or 0.0
  local tRZ = tonumber(targetData.rotZ) or 0.0

  local playerHasControl = HasEffectiveControl(playerPedEntity)
  local targetHasControl = HasEffectiveControl(targetPedEntity)

  local playerPos, playerHead

  if playerHasControl then
    playerPos = OffsetFromCoord(baseCoords, baseHeading, pY, pX, pZ, true)
    playerHead = baseHeading + pRZ

    SetEntityCoordsNoOffset(playerPedEntity, playerPos.x, playerPos.y, playerPos.z, false, false, true)
    SetEntityHeading(playerPedEntity, playerHead)
    ClearPedTasksImmediately(playerPedEntity)
    PlayAnimSmart(playerPedEntity, playerData, playerPos, baseHeading)
  else
    playerPos = OffsetFromCoord(baseCoords, baseHeading, pY, pX, pZ, true)
    playerHead = baseHeading + pRZ
  end

  local targetPos  = OffsetFromCoord(playerPos, playerHead, tY, tX, tZ, true)
  local targetHead = playerHead + tRZ

  if targetHasControl then
    SetEntityCoordsNoOffset(targetPedEntity, targetPos.x, targetPos.y, targetPos.z, false, false, true)
    SetEntityHeading(targetPedEntity, targetHead)
    ClearPedTasksImmediately(targetPedEntity)
    PlayAnimSmart(targetPedEntity, targetData, targetPos, playerHead)
  end

  SetCoupleCollision(playerPedEntity, targetPedEntity, true)
end

ClearCoupleDebugPed = function()
  if CoupleDebug.ped and DoesEntityExist(CoupleDebug.ped) then
    SetEntityAsMissionEntity(CoupleDebug.ped, true, true)
    DeleteEntity(CoupleDebug.ped)
  end
  CoupleDebug.ped = nil
end

EnsureCoupleDebugPed = function()
  if CoupleDebug.ped and DoesEntityExist(CoupleDebug.ped) then
    return CoupleDebug.ped
  end

  local me = PlayerPedId()
  local coords = GetEntityCoords(me)
  local heading = GetEntityHeading(me)
  local model = GetEntityModel(me)

  RequestModel(model)
  while not HasModelLoaded(model) do Citizen.Wait(0) end

  local forward = GetEntityForwardVector(me)
  local right = vector3(-forward.y, forward.x, 0.0)
  local spawnPos = vector3(
    coords.x + forward.x * 0.6 + right.x * 0.3,
    coords.y + forward.y * 0.6 + right.y * 0.3,
    coords.z
  )

  local ped
  if ClonePed then
    ped = ClonePed(me, false, false, false)
    if DoesEntityExist(ped) then
      SetEntityCoordsNoOffset(ped, spawnPos.x, spawnPos.y, spawnPos.z, false, false, true)
      SetEntityHeading(ped, heading)
    end
  end

  if not ped or not DoesEntityExist(ped) then
    ped = CreatePed(model, spawnPos.x, spawnPos.y, spawnPos.z, heading, false, false, false, false)
  end

  if not ped or not DoesEntityExist(ped) then
    SetModelAsNoLongerNeeded(model)
    return nil
  end

  SetEntityAsMissionEntity(ped, true, true)
  SetEntityInvincible(ped, true)
  SetBlockingOfNonTemporaryEvents(ped, true)
  SetPedCanRagdoll(ped, false)
  ResetEntityAlpha(ped)
  SetEntityCollision(ped, true, true)
  SetEntityNoCollisionEntity(ped, me, true)
  CoupleDebug.ped = ped

  SetModelAsNoLongerNeeded(model)
  return ped
end

local function ResolveCoupleAnimation(category, animationKey)
  if not animationKey or animationKey == "" then return nil end

  local pools = {
    erotic  = Valenor and Valenor.Love and Valenor.Love.Erotic,
    love    = Valenor and Valenor.Love and Valenor.Love.Love,
    romance = Valenor and Valenor.Love and Valenor.Love.Love,
    dance   = Valenor and Valenor.Love and Valenor.Love.Dance,
    dances  = Valenor and Valenor.Dances
  }

  local function findInCollection(collection)
    if not collection then return nil end
    if collection[animationKey] then return collection[animationKey] end
    local needle = string.lower(animationKey)
    for key, value in pairs(collection) do
      if string.lower(key) == needle then
        return value
      end
    end
    return nil
  end

  local targetCategory = category and string.lower(category) or "couple"
  local chosen = pools[targetCategory]
  if chosen then
    local entry = findInCollection(chosen)
    if entry then return entry end
  end

  for _, collection in pairs(pools) do
    local entry = findInCollection(collection)
    if entry then return entry end
  end

  return nil
end

RegisterNetEvent('v-emotemenu:client:startSyncedAnimation', function(targetId, category, animationKey, animationData, isRequester, baseCoords, baseHeading)
  local myPed = PlayerPedId()
  local targetPlayer = GetPlayerFromServerId(targetId)
  if not targetPlayer or targetPlayer == -1 then return end
  local targetPed = GetPlayerPed(targetPlayer)
  if not targetPed or not DoesEntityExist(targetPed) then return end
  if not animationData then return end

  local playerData = animationData.player
  local targetData = animationData.target
  if not playerData or not targetData then return end

  RestoreCoupleCollisionLocal(false)

  local basePed = isRequester and myPed or targetPed
  if not basePed or not DoesEntityExist(basePed) then basePed = myPed end

  local baseCoordsVec = baseCoords and vector3(baseCoords.x, baseCoords.y, baseCoords.z) or GetEntityCoords(basePed)
  local baseHeadingValue = tonumber(baseHeading) or GetEntityHeading(basePed)

  if isRequester then
    AlignCouplePeds(myPed, targetPed, playerData, targetData, baseCoordsVec, baseHeadingValue)
  else
    AlignCouplePeds(targetPed, myPed, playerData, targetData, baseCoordsVec, baseHeadingValue)
  end

  ActiveCouplePartner = targetId
  isInAnimation = true
  currentAnimationData = { category = category, key = animationKey, data = animationData }
end)

if Config.Debug then 
  RegisterCommand('coupledebugmode', function(_, args)
    local mode = args[1] and string.lower(args[1]) or nil
    if mode == "on" then
      CoupleDebug.enabled = true
      print("Couple debug mode enabled. Use /coupledebug [category] <animationKey>.")
    elseif mode == "off" then
      CoupleDebug.enabled = false
      ClearCoupleDebugPed()
      print("Couple debug mode disabled.")
    else
      print("Usage: /coupledebugmode on|off")
    end
  end, false)

  RegisterCommand('coupledebug', function(_, args)
    if not CoupleDebug.enabled then
      print("Enable couple debug mode first with /coupledebugmode on.")
      return
    end

    if #args == 0 then
      print("Usage: /coupledebug [category] <animationKey>")
      return
    end

    local category = #args == 1 and "couple" or args[1]
    local animationKey = #args == 1 and args[1] or args[2]

    local animationData = ResolveCoupleAnimation(category, animationKey)
    if not animationData then
      print(("DEBUG: Animation '%s' not found (category '%s')."):format(animationKey, category or "any"))
      return
    end

    if not animationData.player or not animationData.target then
      return
    end

    local partner = EnsureCoupleDebugPed()
    if not partner then
      return
    end

    local myPed = PlayerPedId()
    ClearPedTasksImmediately(myPed)
    ClearPedTasksImmediately(partner)

    local coords = GetEntityCoords(myPed)
    local heading = GetEntityHeading(myPed)

    AlignCouplePeds(myPed, partner, animationData.player, animationData.target, coords, heading)
  end, false)

  RegisterCommand('coupledebugclear', function()
    ClearCoupleDebugPed()
  end, false)

  local testDanceNpc = nil
  local testDanceScene = nil

  local function ClearTestDance()
    if testDanceNpc and DoesEntityExist(testDanceNpc) then
      ClearPedTasksImmediately(testDanceNpc)
      SetEntityAsMissionEntity(testDanceNpc, true, true)
      DeleteEntity(testDanceNpc)
    end
    testDanceNpc = nil
    testDanceScene = nil
    ClearPedTasks(PlayerPedId())
  end

  local function SpawnTestPartner()
    local me = PlayerPedId()
    local coords = GetEntityCoords(me)
    local heading = GetEntityHeading(me)
    local model = GetEntityModel(me)

    RequestModel(model)
    local waited = 0
    while not HasModelLoaded(model) and waited < 200 do
      Citizen.Wait(10)
      waited = waited + 1
    end

    local fwd = GetEntityForwardVector(me)
    local px = coords.x + fwd.x * 0.8
    local py = coords.y + fwd.y * 0.8

    local ped
    if ClonePed then
      ped = ClonePed(me, false, false, false)
      if ped and DoesEntityExist(ped) then
        SetEntityCoordsNoOffset(ped, px, py, coords.z, false, false, true)
        SetEntityHeading(ped, heading + 180.0)
      end
    end

    if not ped or not DoesEntityExist(ped) then
      ped = CreatePed(model, px, py, coords.z, heading + 180.0, false, false, false, false)
    end

    SetEntityAsMissionEntity(ped, true, true)
    SetBlockingOfNonTemporaryEvents(ped, true)
    SetEntityInvincible(ped, true)
    SetPedCanRagdoll(ped, false)
    SetEntityNoCollisionEntity(me, ped, true)
    SetEntityNoCollisionEntity(ped, me, true)
    SetModelAsNoLongerNeeded(model)
    return ped
  end

  -- Approach 1: TaskPlayAnimAdvanced on both peds at the same world anchor
  RegisterCommand('testdance', function()
    ClearTestDance()
    local me = PlayerPedId()
    local coords = GetEntityCoords(me)
    local heading = GetEntityHeading(me)

    local dict = "cnv_camp@rchso@cnv@ccdtc32@arthur_marybeth"
    RequestAnimDict(dict)
    local waited = 0
    while not HasAnimDictLoaded(dict) and waited < 200 do
      Citizen.Wait(10)
      waited = waited + 1
    end
    if not HasAnimDictLoaded(dict) then
      print("[testdance] anim dict failed to load: " .. dict)
      return
    end

    testDanceNpc = SpawnTestPartner()
    if not testDanceNpc then
      print("[testdance] failed to spawn partner ped")
      return
    end

    ClearPedTasksImmediately(me)
    ClearPedTasksImmediately(testDanceNpc)

    -- flag 1 = loop
    TaskPlayAnimAdvanced(me, dict, "player_zero_au_face_only_dance",
      coords.x, coords.y, coords.z, 0.0, 0.0, heading,
      8.0, 8.0, -1, 1, 0.0, 0, 0)
    SetPedKeepTask(me, true)

    TaskPlayAnimAdvanced(testDanceNpc, dict, "ig_marybeth_au_face_only_dance",
      coords.x, coords.y, coords.z, 0.0, 0.0, heading,
      8.0, 8.0, -1, 1, 0.0, 0, 0)
    SetPedKeepTask(testDanceNpc, true)

    print("[testdance] started TaskPlayAnimAdvanced approach")
  end, false)

  -- Approach 2: Synchronized Scene (cutscene-style anchor) on both peds
  RegisterCommand('testdancescene', function()
    ClearTestDance()
    local me = PlayerPedId()
    local coords = GetEntityCoords(me)
    local heading = GetEntityHeading(me)

    local dict = "cnv_camp@rchso@cnv@ccdtc32@arthur_marybeth"
    RequestAnimDict(dict)
    local waited = 0
    while not HasAnimDictLoaded(dict) and waited < 200 do
      Citizen.Wait(10)
      waited = waited + 1
    end
    if not HasAnimDictLoaded(dict) then
      print("[testdancescene] anim dict failed to load: " .. dict)
      return
    end

    testDanceNpc = SpawnTestPartner()
    if not testDanceNpc then
      print("[testdancescene] failed to spawn partner ped")
      return
    end

    -- CREATE_SYNCHRONIZED_SCENE (x, y, z, rotX, rotY, rotZ, rotOrder)
    local sceneId = Citizen.InvokeNative(0x8C18E0F9080ADD73,
      coords.x, coords.y, coords.z, 0.0, 0.0, heading, 2)
    -- SET_SYNCHRONIZED_SCENE_LOOPED
    Citizen.InvokeNative(0xD9A897A4C6C2974F, sceneId, true)

    ClearPedTasksImmediately(me)
    ClearPedTasksImmediately(testDanceNpc)

    -- TASK_SYNCHRONIZED_SCENE (ped, sceneId, dict, anim, blendIn, blendOut, flag, ragdollFlag, moverBlend, ikFlags)
    Citizen.InvokeNative(0xEEA929141F699854,
      me, sceneId, dict, "player_zero_au_face_only_dance",
      8.0, -8.0, 64, 0, 1148846080, 0)
    Citizen.InvokeNative(0xEEA929141F699854,
      testDanceNpc, sceneId, dict, "ig_marybeth_au_face_only_dance",
      8.0, -8.0, 64, 0, 1148846080, 0)

    testDanceScene = sceneId
    print("[testdancescene] started synchronized scene id=" .. tostring(sceneId))
  end, false)

  RegisterCommand('testdanceclear', function()
    ClearTestDance()
    print("[testdance] cleared")
  end, false)
end

Citizen.CreateThread(function()
    while true do
        if IsControlJustPressed(0, Config.KeyBinds["REQUEST_ACCEPT"]) and currentNotificationRequester then
            local requesterId = currentNotificationRequester
            local requestInfo = pendingAnimationRequests[requesterId]
            
            if requestInfo then
                local category = requestInfo.category
                local animationKey = requestInfo.animationKey
                local animationData = requestInfo.animationData
                
                TriggerServerEvent('v-emotemenu:server:acceptAnimationSync', requesterId, GetPlayerServerId(PlayerId()), category, animationKey, animationData)
                
                pendingAnimationRequests[requesterId] = nil
                currentNotificationRequester = nil
                
                SendNUIMessage({
                    action = "HIDE_ANIMATION_REQUEST"
                })
            end
        end
        
        Citizen.Wait(100)
    end
end)

RegisterNUICallback('acceptAnimation', function(data, cb)
    cb('ok')
end)

RegisterNUICallback('closeNotification', function(data, cb)
    cb('ok')
end)
