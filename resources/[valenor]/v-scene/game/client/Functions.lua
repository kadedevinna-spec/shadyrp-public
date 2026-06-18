debugEntity = nil
pendingRequests = pendingRequests or {}
requestId = requestId or 0
coordsPick = coordsPick or {
  active = false,
  mode = nil,
  speed = 0.35,
  fastMul = 2.5,
  slowMul = 0.35,
  pitch = 0.0,
  heading = 0.0,
  baseSpeed = 0.35,
  cam = nil,
  previewNpc = nil
}
previewGizmo = previewGizmo or {
  active = false,
  entity = nil,
  npc = nil,
  uid = nil,
  runtimeNpc = nil,
  mode = nil,
  textThread = false
}
originalPlayerPosition = originalPlayerPosition or nil
originalPlayerHeading = originalPlayerHeading or nil
previewProps = previewProps or {}
runtimeNpcs = runtimeNpcs or {}
EDITOR_PREVIEW_PREFIX = EDITOR_PREVIEW_PREFIX or '__editor__::prop::'

runtimeState = runtimeState or {
  active = false,
  scene = nil,
  nodes = {},
  links = {},
  outLinks = {},
  dialogLinks = {},
  keyLinks = {}
}

runtimeThreadRunning = runtimeThreadRunning or false
runtimeAllScenes = runtimeAllScenes or {}
runtimeTextItems = runtimeTextItems or {}
runtimeTextThread = runtimeTextThread or false
runtimeTextRenderCache = runtimeTextRenderCache or {}
runtimeTextSwitch = runtimeTextSwitch or {}
runtimeTextSources = runtimeTextSources or {}
runtimeTextTargets = runtimeTextTargets or {}
runtimeSoundItems = runtimeSoundItems or {}
runtimeSoundById = runtimeSoundById or {}
runtimeSoundChain = runtimeSoundChain or {}
runtimeSoundChainOwner = runtimeSoundChainOwner or {}
runtimeSoundPlaying = runtimeSoundPlaying or {}
runtimeSoundAttach = runtimeSoundAttach or {}
runtimeSoundAttachOwner = runtimeSoundAttachOwner or {}
runtimeSoundAttachThread = runtimeSoundAttachThread or false
runtimeSoundPosCache = runtimeSoundPosCache or {}
runtimeSoundPaused = runtimeSoundPaused or {}
runtimeSoundUrlCache = runtimeSoundUrlCache or {}
runtimeGlobalNodes = runtimeGlobalNodes or {}
runtimeGlobalKeyLinks = runtimeGlobalKeyLinks or {}
runtimeGlobalDialogLinks = runtimeGlobalDialogLinks or {}
runtimeGlobalOutLinks = runtimeGlobalOutLinks or {}
runtimeKeyPrompts = runtimeKeyPrompts or {}
runtimeKeyPromptThread = runtimeKeyPromptThread or false
runtimeKeyPromptGroup = runtimeKeyPromptGroup or nil
runtimeDialogState = runtimeDialogState or { active = false, currentLineId = nil, cam = nil, npcUid = nil }
runtimeVisitCache = runtimeVisitCache or {}
runtimeVisitPending = runtimeVisitPending or {}
runtimeVisitActive = runtimeVisitActive or nil
runtimeVisitRewardPending = runtimeVisitRewardPending or nil
runtimeEditorScenes = runtimeEditorScenes or {}
runtimeEditorSceneById = runtimeEditorSceneById or {}
runtimeEditorPlayback = runtimeEditorPlayback or { active = false, cam = nil }
uiState = uiState or { open = false }

GIZMO_PREVIEW_MODEL = GIZMO_PREVIEW_MODEL or 'p_ammoboxlancaster01x'

local DIALOG_KEY_E = 0xCEFD9220
local DIALOG_KEY_G = 0x760A9C6F
local DEFAULT_DIALOG_ANIM_DICT = 'script_common@other@unapproved'
local DEFAULT_DIALOG_ANIM_NAME = 'stand_guard@idle_a'

function RuntimeNotify(message, duration, notifyType)
  if not message or message == '' then return end
  local isTable = type(message) == 'table'
  local title = isTable and tostring(message.title or '') or ''
  local desc = isTable and tostring(message.description or '') or ''
  local text = isTable and ((desc ~= '' and desc) or title) or tostring(message)
  if text == '' then text = 'Notify' end
  local ok = false
  if BridgeClient and BridgeClient.Notify then
    ok = BridgeClient.Notify(message, duration or 3000, notifyType or (isTable and message.notifyType) or 'info') == true
  end
  if not ok then
    print(('[v-scene][notify] %s'):format(text))
    pcall(function()
      TriggerEvent('chat:addMessage', {
        color = { 219, 181, 112 },
        args = { 'v-scene', text }
      })
    end)
    return
  end
end

local function normalizeEditorSceneEntry(scene, index)
  if type(scene) ~= 'table' then return nil end
  local id = scene.id or scene.uid or scene.code or scene.name or scene.Name or scene.compositionName or ('editor_scene_' .. tostring(index))
  id = tostring(id)
  local title = tostring(scene.name or scene.Name or scene.title or scene.compositionName or scene.code or ('Editor Scene ' .. tostring(index)))
  local coords = scene.Coords or scene.coords or {}
  return {
    id = id,
    title = title,
    code = scene.code or '',
    coordsCount = #coords,
    raw = scene
  }
end

function SetEditorScenesCache(list)
  runtimeEditorScenes = {}
  runtimeEditorSceneById = {}
  local nextIndex = 1
  local function pushEntry(entry, fallbackTitle)
    if type(entry) ~= 'table' then return end
    if fallbackTitle and (not entry.name and not entry.Name and not entry.title) then
      local patched = {}
      for k, v in pairs(entry) do
        patched[k] = v
      end
      patched.name = tostring(fallbackTitle)
      entry = patched
    end
    local normalized = normalizeEditorSceneEntry(entry, nextIndex)
    if not normalized then return end
    if runtimeEditorSceneById[normalized.id] then return end
    table.insert(runtimeEditorScenes, normalized)
    runtimeEditorSceneById[normalized.id] = normalized
    nextIndex = nextIndex + 1
  end
  for _, entry in ipairs(list or {}) do
    pushEntry(entry)
  end
  for key, entry in pairs(list or {}) do
    if type(key) ~= 'number' then
      pushEntry(entry, key)
    end
  end
end

function GetEditorScenesCache()
  return runtimeEditorScenes or {}
end

local function stopEditorScenePlayback()
  if runtimeEditorPlayback and runtimeEditorPlayback.cam and DoesCamExist(runtimeEditorPlayback.cam) then
    DestroyCam(runtimeEditorPlayback.cam, true)
  end
  runtimeEditorPlayback = { active = false, cam = nil }
  RenderScriptCams(false, false, 1, true, true)
end

local function playEditorScene(sceneData)
  if type(sceneData) ~= 'table' then
    RuntimeNotify('Editor scene verisi gecersiz.')
    return false
  end
  local coords = sceneData.Coords or sceneData.coords
  if type(coords) ~= 'table' or #coords < 2 then
    RuntimeNotify('Editor scene icin en az 2 nokta gerekli.')
    return false
  end

  stopEditorScenePlayback()
  runtimeEditorPlayback.active = true

  local movementMode = sceneData.selectedMovement or 'linear'
  local cameraSpeed = tonumber(sceneData.cameraSpeed) or 30
  local totalDuration = cameraSpeed * 1000
  local segmentDuration = totalDuration / math.max(1, (#coords - 1))

  CreateThread(function()
    local cam = CreateCam('DEFAULT_SCRIPTED_CAMERA', true)
    runtimeEditorPlayback.cam = cam

    local first = coords[1]
    local fx = tonumber(first.x) or 0.0
    local fy = tonumber(first.y) or 0.0
    local fz = tonumber(first.z) or 0.0
    local fh = tonumber(first.h) or 0.0
    local frx = tonumber(first.RotationX) or 0.0
    local fry = tonumber(first.RotationY) or 0.0
    local fzoom = tonumber(first.zoom) or 50.0
    local fov = (100 - fzoom) * 0.7 + 10.0

    SetCamCoord(cam, fx, fy, fz)
    SetCamRot(cam, frx, fry, fh, 2)
    SetCamFov(cam, fov)
    RenderScriptCams(true, false, 1, true, true)

    for i = 1, #coords - 1 do
      if not runtimeEditorPlayback.active then break end
      local a = coords[i]
      local b = coords[i + 1]
      local ax = tonumber(a.x) or 0.0
      local ay = tonumber(a.y) or 0.0
      local az = tonumber(a.z) or 0.0
      local ah = tonumber(a.h) or 0.0
      local arx = tonumber(a.RotationX) or 0.0
      local ary = tonumber(a.RotationY) or 0.0
      local azoom = tonumber(a.zoom) or 50.0
      local bx = tonumber(b.x) or 0.0
      local by = tonumber(b.y) or 0.0
      local bz = tonumber(b.z) or 0.0
      local bh = tonumber(b.h) or 0.0
      local brx = tonumber(b.RotationX) or 0.0
      local bry = tonumber(b.RotationY) or 0.0
      local bzoom = tonumber(b.zoom) or 50.0
      local startTime = GetGameTimer()
      local endTime = startTime + segmentDuration

      while runtimeEditorPlayback.active and GetGameTimer() < endTime do
        local now = GetGameTimer()
        local progress = (now - startTime) / segmentDuration
        local eased = progress
        if movementMode == 'ease-in' then
          eased = progress * progress
        elseif movementMode == 'ease-out' then
          eased = 1 - (1 - progress) * (1 - progress)
        elseif movementMode == 'ease-in-out' then
          if progress < 0.5 then
            eased = 2 * progress * progress
          else
            eased = 1 - math.pow(-2 * progress + 2, 2) / 2
          end
        end
        local x = ax + (bx - ax) * eased
        local y = ay + (by - ay) * eased
        local z = az + (bz - az) * eased
        local h = ah + (bh - ah) * eased
        local rx = arx + (brx - arx) * eased
        local ry = ary + (bry - ary) * eased
        local zoom = azoom + (bzoom - azoom) * eased
        SetCamCoord(cam, x, y, z)
        SetCamRot(cam, rx, ry, h, 2)
        SetCamFov(cam, (100 - zoom) * 0.7 + 10.0)
        Wait(0)
      end
    end

    stopEditorScenePlayback()
  end)
  return true
end

local function findEditorSceneForNode(node)
  if not node then return nil end
  local directId = tostring(node.editorSceneId or node.sceneRef or '')
  if directId ~= '' and runtimeEditorSceneById[directId] then
    return runtimeEditorSceneById[directId]
  end
  local title = tostring(node.editorSceneTitle or node.title or '')
  if title ~= '' then
    for _, scene in ipairs(runtimeEditorScenes or {}) do
      if scene.title == title then
        return scene
      end
    end
  end
  return nil
end

function OpenUI(bool)
  uiState.open = bool == true
  SetNuiFocus(bool, bool)
  SendNUIMessage({ action = 'INTERFACE_CONTROL', status = bool })
end

function spawnProp(hash)
  local model = GetHashKey(hash)
  RequestModel(model)
  while not HasModelLoaded(model) do
    Wait(0)
  end
  local ped = PlayerPedId()
  local coords = GetEntityCoords(ped)
  local forward = GetEntityForwardVector(ped)
  local spawn = coords + forward * 2.0
  local obj = CreateObject(model, spawn.x, spawn.y, spawn.z, true, true, false, false, true)
  SetEntityAsMissionEntity(obj, true, true)
  SetModelAsNoLongerNeeded(model)
  return obj
end

function applyVec3(entity, vec)
  if not vec then return end
  local x = vec.x or vec[1]
  local y = vec.y or vec[2]
  local z = vec.z or vec[3]
  if x and y and z then
    SetEntityCoords(entity, x, y, z, false, false, false, false)
  end
end

function applyRot(entity, rot)
  if not rot then return end
  local x = rot.x or rot[1]
  local y = rot.y or rot[2]
  local z = rot.z or rot[3]
  if x and y and z then
    SetEntityRotation(entity, x, y, z, 2, true)
  end
end

function ensurePropEntity(uid, model)
  if not uid or not model or model == '' then
    return nil
  end
  model = tostring(model):gsub('^%s+', ''):gsub('%s+$', '')
  local entry = previewProps[uid]
  if entry and entry.entity and DoesEntityExist(entry.entity) then
    if entry.model == model then
      return entry.entity
    end
    DeleteEntity(entry.entity)
  end
  local hash = GetHashKey(model)
  if not IsModelValid(hash) then
    return nil
  end
  RequestModel(hash)
  local timeout = GetGameTimer() + 4000
  while not HasModelLoaded(hash) and GetGameTimer() < timeout do
    Wait(0)
  end
  if not HasModelLoaded(hash) then
    return nil
  end
  local ped = PlayerPedId()
  local coords = GetOffsetFromEntityInWorldCoords(ped, 0.0, 1.0, 0.0)
  local entity = nil
  local isPedModel = IsModelAPed and IsModelAPed(hash)
  RequestCollisionAtCoord(coords.x, coords.y, coords.z)
  if isPedModel then
    local heading = GetEntityHeading(ped)
    local ok = pcall(function()
      entity = CreatePed(hash, coords.x, coords.y, coords.z, heading, false, false, false, false)
    end)
    if not ok or not entity or entity == 0 then
      SetModelAsNoLongerNeeded(hash)
      return nil
    end
    SetEntityAsMissionEntity(entity, true, true)
    SetBlockingOfNonTemporaryEvents(entity, true)
    SetPedCanRagdoll(entity, false)
    if SetPedCanBeTargetted then SetPedCanBeTargetted(entity, false) end
    SetEntityInvincible(entity, true)
    SetEntityCanBeDamaged(entity, false)
    if SetEntityAlpha then
      SetEntityAlpha(entity, 0, false)
    end
    if SetRandomOutfitVariation then
      pcall(function()
        SetRandomOutfitVariation(entity, true)
      end)
    end
    if Citizen and Citizen.InvokeNative then
      pcall(function() Citizen.InvokeNative(0xAAB86462966168CE, entity, true) end)
      pcall(function() Citizen.InvokeNative(0xCC8CA3E88256E58F, entity, false, true, true, true, false) end)
    end
    SetEntityVisible(entity, true, false)
    if SetEntityAlpha then
      SetEntityAlpha(entity, 255, false)
    end
    SetEntityCollision(entity, true, true)
    FreezeEntityPosition(entity, true)
    if PlaceEntityOnGroundProperly then
      PlaceEntityOnGroundProperly(entity, true)
    end
  else
    local ok = pcall(function()
      entity = CreateObject(hash, coords.x, coords.y, coords.z, true, false, false)
    end)
    if not ok or not entity or entity == 0 then
      SetModelAsNoLongerNeeded(hash)
      return nil
    end
    SetEntityAsMissionEntity(entity, true, true)
    FreezeEntityPosition(entity, true)
  end
  SetModelAsNoLongerNeeded(hash)
  previewProps[uid] = { entity = entity, model = model, entityType = isPedModel and 'ped' or 'object' }
  return entity
end

function IsEditorPreviewUid(uid)
  return type(uid) == 'string' and uid:sub(1, #EDITOR_PREVIEW_PREFIX) == EDITOR_PREVIEW_PREFIX
end

function GetEditorPreviewUid(uid)
  if not uid then return nil end
  local key = tostring(uid)
  if IsEditorPreviewUid(key) then
    return key
  end
  return EDITOR_PREVIEW_PREFIX .. key
end

function applyPropTransform(entity, coords)
  if not entity or not DoesEntityExist(entity) or not coords then return end
  local x = coords.posX or coords.x or 0.0
  local y = coords.posY or coords.y or 0.0
  local z = coords.posZ or coords.z or 0.0
  SetEntityCoordsNoOffset(entity, x, y, z, false, false, false)
  FreezeEntityPosition(entity, true)
  local rotX = coords.rotX or coords.rx or 0.0
  local rotY = coords.rotY or coords.ry or 0.0
  local rotZ = coords.rotZ or coords.rz or 0.0
  if IsEntityAPed and IsEntityAPed(entity) then
    RequestCollisionAtCoord(x, y, z)
    SetEntityHeading(entity, rotZ)
    SetEntityVisible(entity, true, false)
    if SetEntityAlpha then
      SetEntityAlpha(entity, 255, false)
    end
    SetEntityCollision(entity, true, true)
    if PlaceEntityOnGroundProperly then
      PlaceEntityOnGroundProperly(entity, true)
    end
  else
    SetEntityRotation(entity, rotX, rotY, rotZ, 2, true)
    local scale = coords.scale
    if scale and SetEntityScale then
      SetEntityScale(entity, scale, scale, scale)
    end
  end
  for soundId, propId in pairs(runtimeSoundAttach or {}) do
    if propId and previewProps[propId] and previewProps[propId].entity == entity then
      UpdateAttachedSoundPosition(soundId, true)
    end
  end
end

function clearPreviewGizmo()
  previewGizmo.active = false
  previewGizmo.mode = nil
  if previewGizmo.entity and DoesEntityExist(previewGizmo.entity) then
    DeleteEntity(previewGizmo.entity)
  end
  if previewGizmo.npc and DoesEntityExist(previewGizmo.npc) then
    DeleteEntity(previewGizmo.npc)
  end
  previewGizmo.entity = nil
  previewGizmo.npc = nil
  previewGizmo.uid = nil
  previewGizmo.runtimeNpc = nil
  SendNUIMessage({ type = 'coordsPreviewText', item = nil })
end

function createPreviewObject(model, coords, visible)
  local hash = GetHashKey(model or GIZMO_PREVIEW_MODEL)
  RequestModel(hash)
  local timeout = GetGameTimer() + 4000
  while not HasModelLoaded(hash) and GetGameTimer() < timeout do
    Wait(0)
  end
  if not HasModelLoaded(hash) then
    return nil
  end

  local ped = PlayerPedId()
  local spawn = coords or GetOffsetFromEntityInWorldCoords(ped, 0.0, 1.0, 0.0)
  RequestCollisionAtCoord(spawn.x, spawn.y, spawn.z)
  local obj = CreateObject(hash, spawn.x, spawn.y, spawn.z, true, false, false)
  if not obj or obj == 0 then
    return nil
  end
  SetEntityAsMissionEntity(obj, true, true)
  FreezeEntityPosition(obj, true)
  SetEntityCollision(obj, false, false)
  SetEntityVisible(obj, true, false)
  if SetEntityAlpha then
    if visible == true then
      SetEntityAlpha(obj, 255, false)
    else
      SetEntityAlpha(obj, 160, false)
    end
  end
  SetModelAsNoLongerNeeded(hash)
  return obj
end

function createPreviewNpc(npcHash, coords, heading)
  if not npcHash or npcHash == '' then
    return nil
  end
  local hash = GetHashKey(tostring(npcHash))
  if not IsModelValid(hash) or (IsModelAPed and not IsModelAPed(hash)) then
    return nil
  end
  RequestModel(hash)
  local timeout = GetGameTimer() + 4000
  while not HasModelLoaded(hash) and GetGameTimer() < timeout do
    Wait(0)
  end
  if not HasModelLoaded(hash) then
    return nil
  end

  local ped = CreatePed(hash, coords.x, coords.y, coords.z, heading or 0.0, false, false, false, false)
  if not ped or ped == 0 then
    return nil
  end
  SetEntityAsMissionEntity(ped, true, true)
  SetBlockingOfNonTemporaryEvents(ped, true)
  SetPedCanRagdoll(ped, false)
  SetEntityInvincible(ped, true)
  SetEntityCanBeDamaged(ped, false)
  FreezeEntityPosition(ped, true)
  RequestAnimDict(DEFAULT_DIALOG_ANIM_DICT)
  local timeoutAnim = GetGameTimer() + 4000
  while not HasAnimDictLoaded(DEFAULT_DIALOG_ANIM_DICT) and GetGameTimer() < timeoutAnim do
    Wait(0)
  end
  if HasAnimDictLoaded(DEFAULT_DIALOG_ANIM_DICT) then
    TaskPlayAnim(ped, DEFAULT_DIALOG_ANIM_DICT, DEFAULT_DIALOG_ANIM_NAME, 1.0, 1.0, -1, 1, 0.0, false, false, false, 0, false)
  end
  SetModelAsNoLongerNeeded(hash)
  return ped
end

local function alignEntityCenterToCoords(entity, coords, heading)
  if not entity or not DoesEntityExist(entity) or not coords then return end
  local x = coords.posX or coords.x or 0.0
  local y = coords.posY or coords.y or 0.0
  local z = coords.posZ or coords.z or 0.0
  SetEntityCoordsNoOffset(entity, x, y, z, false, false, false)
  SetEntityHeading(entity, heading or 0.0)

  local model = GetEntityModel(entity)
  if not model or model == 0 or not GetModelDimensions then
    return
  end

  local minDim, maxDim = GetModelDimensions(model)
  if not minDim or not maxDim then
    return
  end

  local centerX = ((minDim.x or 0.0) + (maxDim.x or 0.0)) * 0.5
  local centerY = ((minDim.y or 0.0) + (maxDim.y or 0.0)) * 0.5
  local centerZ = ((minDim.z or 0.0) + (maxDim.z or 0.0)) * 0.5
  local aligned = GetOffsetFromEntityInWorldCoords(entity, -centerX, -centerY, -centerZ)
  SetEntityCoordsNoOffset(entity, aligned.x, aligned.y, aligned.z, false, false, false)
end

local function nudgeEntityDownByModelHeight(entity, multiplier)
  if not entity or not DoesEntityExist(entity) or not GetModelDimensions then return end
  local model = GetEntityModel(entity)
  if not model or model == 0 then return end
  local minDim, maxDim = GetModelDimensions(model)
  if not minDim or not maxDim then return end

  local height = math.abs((maxDim.z or 0.0) - (minDim.z or 0.0))
  if height <= 0.001 then return end

  local current = GetEntityCoords(entity)
  local step = height * (multiplier or 1.0)
  SetEntityCoordsNoOffset(entity, current.x, current.y, current.z - step, false, false, false)
end

function buildPreviewCoords(result, fallback, mode)
  local pos = (result and (result.position or result.pos or result.coords)) or {}
  local rot = (result and (result.rotation or result.rot)) or {}
  local out = {
    posX = pos.x or pos[1] or fallback.posX or 0.0,
    posY = pos.y or pos[2] or fallback.posY or 0.0,
    posZ = pos.z or pos[3] or fallback.posZ or 0.0
  }
  if mode == 'dialog' then
    local heading = rot.z or rot[3] or fallback.h or fallback.heading or fallback.rotZ or 0.0
    out.h = heading
    out.heading = heading
    out.rotZ = heading
  end
  return out
end

function startPreviewTextThread(payload, entity)
  if previewGizmo.textThread then return end
  previewGizmo.textThread = true
  CreateThread(function()
    while previewGizmo.active and previewGizmo.mode == 'text' and entity and DoesEntityExist(entity) do
      local coords = GetEntityCoords(entity)
      local onScreen, sx, sy = GetScreenCoordFromWorldCoord(coords.x, coords.y, coords.z)
      if onScreen and sx and sy then
        SendNUIMessage({
          type = 'coordsPreviewText',
          item = {
            x = sx,
            y = sy,
            text = payload.text or 'New Text',
            color = payload.fontColor or '#ffffff',
            backgroundColor = payload.backgroundColor or '#000000',
            backgroundOpacity = payload.backgroundOpacity or 0,
            size = payload.fontSize or 1.5,
            fontFamily = payload.fontFamily or 'EB_Garamond',
            distance = 0,
            maxDistance = payload.distance or 10
          }
        })
      else
        SendNUIMessage({ type = 'coordsPreviewText', item = nil })
      end
      Wait(0)
    end
    previewGizmo.textThread = false
    SendNUIMessage({ type = 'coordsPreviewText', item = nil })
  end)
end

function startPreviewGizmo(payload)
  if previewGizmo.active then
    clearPreviewGizmo()
  end

  local mode = payload and payload.type or nil
  if mode ~= 'text' and mode ~= 'ambient' and mode ~= 'dialog' then
    return false
  end

  local coords = payload.coords or {}
  local baseCoords = {
    posX = coords.posX or coords.x,
    posY = coords.posY or coords.y,
    posZ = coords.posZ or coords.z
  }
  local hasCoords = baseCoords.posX ~= nil and baseCoords.posY ~= nil and baseCoords.posZ ~= nil
  local isZeroCoords = hasCoords
    and math.abs(tonumber(baseCoords.posX) or 0.0) < 0.001
    and math.abs(tonumber(baseCoords.posY) or 0.0) < 0.001
    and math.abs(tonumber(baseCoords.posZ) or 0.0) < 0.001
  if (not hasCoords) or isZeroCoords then
    local ped = PlayerPedId()
    local spawn = GetOffsetFromEntityInWorldCoords(ped, 0.0, 1.0, 0.0)
    baseCoords.posX = spawn.x
    baseCoords.posY = spawn.y
    baseCoords.posZ = spawn.z
  end
  local heading = coords.h or coords.heading or coords.rotZ or GetEntityHeading(PlayerPedId())

  local visible = mode == 'ambient'
  local entity = createPreviewObject(GIZMO_PREVIEW_MODEL, vector3(baseCoords.posX, baseCoords.posY, baseCoords.posZ), visible)
  if not entity then
    return false
  end

  alignEntityCenterToCoords(entity, baseCoords, heading)
  if mode == 'text' then
    nudgeEntityDownByModelHeight(entity, 1.0)
    SetEntityVisible(entity, false, false)
    if SetEntityAlpha then
      SetEntityAlpha(entity, 0, false)
    end
  end

  previewGizmo.active = true
  previewGizmo.entity = entity
  previewGizmo.mode = mode
  previewGizmo.npc = nil
  previewGizmo.uid = payload and payload.uid or nil
  previewGizmo.runtimeNpc = nil

  if mode == 'text' then
    startPreviewTextThread(payload or {}, entity)
  end
  if mode == 'dialog' and payload.npcHash and payload.npcHash ~= '' then
    local runtimeEntry = payload.uid and runtimeNpcs[payload.uid] or nil
    if runtimeEntry and runtimeEntry.entity and DoesEntityExist(runtimeEntry.entity) then
      previewGizmo.runtimeNpc = runtimeEntry.entity
    end
    if not previewGizmo.runtimeNpc then
      previewGizmo.npc = createPreviewNpc(payload.npcHash, vector3(baseCoords.posX, baseCoords.posY, baseCoords.posZ), heading)
    end
    local npcEntity = previewGizmo.runtimeNpc or previewGizmo.npc
    if npcEntity then
      CreateThread(function()
        while previewGizmo.active and npcEntity and previewGizmo.entity and DoesEntityExist(npcEntity) and DoesEntityExist(previewGizmo.entity) do
          local pos = GetEntityCoords(previewGizmo.entity)
          local rot = GetEntityRotation(previewGizmo.entity, 2)
          SetEntityCoordsNoOffset(npcEntity, pos.x, pos.y, pos.z, false, false, false)
          SetEntityHeading(npcEntity, rot.z or heading)
          Wait(0)
        end
      end)
    end
  end

  SendNUIMessage({ action = 'INTERFACE_CONTROL', status = false })
  SetNuiFocus(false, false)
  local result = exports.object_gizmo:useGizmo(entity)
  SetNuiFocus(true, true)
  SendNUIMessage({ action = 'INTERFACE_CONTROL', status = true })

  if type(result) == 'table' then
    local out = buildPreviewCoords(result, coords or baseCoords, mode)
    SendNUIMessage({ type = 'coordsPicked', coords = out })
    clearPreviewGizmo()
    return true
  end

  clearPreviewGizmo()
  SendNUIMessage({ type = 'coordsPickCanceled' })
  return false
end

function clearPreviewProps()
  for _, entry in pairs(previewProps) do
    if entry and entry.entity and DoesEntityExist(entry.entity) then
      DeleteEntity(entry.entity)
    end
  end
  previewProps = {}
end

function clearEditorPreviewProps()
  for uid, entry in pairs(previewProps) do
    if IsEditorPreviewUid(uid) and entry and entry.entity and DoesEntityExist(entry.entity) then
      DeleteEntity(entry.entity)
      previewProps[uid] = nil
    end
  end
end

function SetPreviewEntityVisible(entity, visible)
  if not entity or not DoesEntityExist(entity) then return end
  local show = visible == true
  SetEntityVisible(entity, show, false)
  if SetEntityAlpha then
    SetEntityAlpha(entity, show and 255 or 0, false)
  end
  SetEntityCollision(entity, show, show)
end

function SetRuntimePropPreviewHiddenByBaseUid(baseUid, hidden)
  if not baseUid then return end
  local suffix = '::prop::' .. tostring(baseUid)
  for uid, entry in pairs(previewProps) do
    if not IsEditorPreviewUid(uid) and type(uid) == 'string' and uid:sub(-#suffix) == suffix and entry and entry.entity and DoesEntityExist(entry.entity) then
      SetPreviewEntityVisible(entry.entity, not hidden)
      entry.previewHidden = hidden == true
    end
  end
end

function HasEditorPreviewProp(baseUid)
  if not baseUid then return false end
  local previewUid = GetEditorPreviewUid(baseUid)
  local entry = previewProps[previewUid]
  return entry and entry.entity and DoesEntityExist(entry.entity) or false
end

function SyncRuntimePropPreviewHiddenState(baseUid)
  SetRuntimePropPreviewHiddenByBaseUid(baseUid, HasEditorPreviewProp(baseUid))
end

function serverRequest(name, payload, cb)
  requestId = requestId + 1
  pendingRequests[requestId] = cb
  TriggerServerEvent('v-scene:request', requestId, name, payload or {})
end

local function copyVisitPolicy(value)
  if type(value) ~= 'table' then return nil end
  local out = {}
  for key, entry in pairs(value) do
    out[key] = entry
  end
  return out
end

local function mergeVisitPolicy(base, override)
  local out = copyVisitPolicy(base) or {}
  if type(override) == 'table' then
    for key, entry in pairs(override) do
      out[key] = entry
    end
  end
  return next(out) and out or nil
end

local function normalizeVisitPolicy(policy)
  if type(policy) ~= 'table' then return nil end
  local mode = tostring(policy.mode or ''):lower()
  if mode == '' or mode == 'off' or mode == 'false' then return nil end
  if mode == 'return' or mode == 'repeat-dialog' or mode == 'dialog' then
    mode = 'repeat'
  end
  local cooldownSeconds = tonumber(policy.cooldownSeconds or policy.cooldown or 0) or 0
  local cooldownDays = tonumber(policy.cooldownDays or policy.replayDays or policy.resetDays or 0) or 0
  local cooldownHours = tonumber(policy.cooldownHours or 0) or 0
  local cooldownMinutes = tonumber(policy.cooldownMinutes or 0) or 0
  if cooldownSeconds <= 0 then
    cooldownSeconds = (cooldownDays * 86400) + (cooldownHours * 3600) + (cooldownMinutes * 60)
  end
  cooldownSeconds = math.floor(cooldownSeconds)
  if cooldownSeconds < 0 then cooldownSeconds = 0 end
  if cooldownSeconds > 31536000 then cooldownSeconds = 31536000 end

  local tracking = Config and Config.VisitTracking or {}
  return {
    mode = mode,
    markOn = tostring(policy.markOn or 'reward'):lower(),
    visitKey = tostring(policy.visitKey or 'reward'),
    message = tostring(policy.message or tracking.defaultMessage or 'You have already done this scene.'),
    cooldownSeconds = cooldownSeconds,
    cooldownDays = cooldownDays,
    repeatDialogLineId = policy.repeatDialogLineId or policy.repeatLineId or policy.dialogLineId
  }
end

local function parseVisitPolicyTag(scene)
  local text = tostring((scene and (scene.subtitle or scene.title)) or '')
  local tag = text:match('%[visit:([^%]]+)%]')
  if not tag then return nil end

  local parts = {}
  for part in tostring(tag):gmatch('[^:]+') do
    parts[#parts + 1] = part
  end

  local mode = parts[1] and parts[1]:lower() or ''
  local policy = { mode = mode }
  if mode == 'repeat' or mode == 'return' or mode == 'dialog' then
    policy.mode = 'repeat'
    policy.repeatDialogLineId = parts[2]
  end

  local message = text:match('%[visit%-message:([^%]]+)%]') or text:match('%[visit_message:([^%]]+)%]')
  if message and message ~= '' then
    policy.message = message
  end
  local markOn = text:match('%[visit%-mark:([^%]]+)%]') or text:match('%[visit_mark:([^%]]+)%]')
  if markOn and markOn ~= '' then
    policy.markOn = markOn
  end
  local cooldown = text:match('%[visit%-cooldown:([^%]]+)%]') or text:match('%[visit_cooldown:([^%]]+)%]')
  if cooldown and cooldown ~= '' then
    local amount = tonumber(tostring(cooldown):match('^%s*(%d+%.?%d*)'))
    local unit = tostring(cooldown):match('%a+') or 'days'
    unit = unit:lower()
    if amount and amount > 0 then
      if unit == 's' or unit == 'sec' or unit == 'secs' or unit == 'second' or unit == 'seconds' then
        policy.cooldownSeconds = amount
      elseif unit == 'm' or unit == 'min' or unit == 'mins' or unit == 'minute' or unit == 'minutes' then
        policy.cooldownMinutes = amount
      elseif unit == 'h' or unit == 'hr' or unit == 'hrs' or unit == 'hour' or unit == 'hours' then
        policy.cooldownHours = amount
      else
        policy.cooldownDays = amount
      end
    end
  end

  return policy
end

function GetSceneVisitPolicy(scene)
  local tracking = Config and Config.VisitTracking or {}
  if tracking.enabled == false then return nil end

  local configured = tracking.scenes or {}
  local scenePolicy = nil
  if scene and scene.code and configured[tostring(scene.code)] then
    scenePolicy = mergeVisitPolicy(scenePolicy, configured[tostring(scene.code)])
  end
  if scene and scene.id and configured[tostring(scene.id)] then
    scenePolicy = mergeVisitPolicy(scenePolicy, configured[tostring(scene.id)])
  end
  if scene and scene.data and type(scene.data.visitTracking) == 'table' then
    if scene.data.visitTracking.enabled == false then
      return nil
    end
    scenePolicy = mergeVisitPolicy(scenePolicy, scene.data.visitTracking)
  end

  scenePolicy = mergeVisitPolicy(parseVisitPolicyTag(scene), scenePolicy)
  return normalizeVisitPolicy(scenePolicy)
end

local function visitCacheKey(payload)
  if not payload then return nil end
  return ('%s:%s'):format(tostring(payload.sceneId or ''), tostring(payload.visitKey or 'reward'))
end

local function buildVisitPayload(node, policy)
  if not node or not node._sceneId then return nil end
  return {
    sceneId = node._sceneId,
    sceneCode = node._sceneCode or '',
    visitKey = policy and policy.visitKey or 'reward',
    cooldownSeconds = policy and policy.cooldownSeconds or 0
  }
end

local function cloneVisitPayload(payload)
  if type(payload) ~= 'table' then return nil end
  local out = {}
  for key, value in pairs(payload) do
    out[key] = value
  end
  return out
end

local function markVisited(payload, completed, reason)
  local key = visitCacheKey(payload)
  local requestPayload = cloneVisitPayload(payload)
  if not requestPayload then return end
  requestPayload.completed = completed == true
  requestPayload.reason = reason
  serverRequest('markSceneVisited', requestPayload, function(state)
    if key and type(state) == 'table' then
      runtimeVisitCache[key] = state
    end
  end)
end

function IsRuntimeRewardActionType(actionType)
  local action = tostring(actionType or ''):lower()
  return action == 'item' or action == 'weapon' or action == 'job'
end

local function visitMarkMatches(markOn, event)
  local mark = tostring(markOn or 'reward'):lower()
  local when = tostring(event or ''):lower()
  if mark == when then return true end
  if (mark == 'reward' or mark == 'finish' or mark == 'success' or mark == 'item') and when == 'reward' then
    return true
  end
  if mark == 'choice' and (when == 'choice' or when == 'action') then
    return true
  end
  return false
end

function CompleteRuntimeVisit(reason, visitState)
  local state = visitState or runtimeVisitActive
  if not state or state.marked then return end
  local markOn = state.policy and state.policy.markOn or 'reward'
  local event = reason or 'choice'
  if not visitMarkMatches(markOn, event) then
    return
  end
  local payload = state.payload
  local key = state.key
  if not payload or not key then
    if not visitState then runtimeVisitActive = nil end
    return
  end
  state.marked = true
  state.reason = event
  runtimeVisitCache[key] = { ok = true, visited = true, visitCount = 1 }
  local completed = event == 'reward' or event == 'finish' or event == 'success'
  markVisited(payload, completed, event)
end

function PrepareRuntimeVisitReward(actionNode)
  if not runtimeVisitActive or runtimeVisitActive.marked then return end
  if not IsRuntimeRewardActionType(actionNode and actionNode.actionType) then return end
  runtimeVisitRewardPending = {
    payload = runtimeVisitActive.payload,
    key = runtimeVisitActive.key,
    policy = runtimeVisitActive.policy,
    marked = runtimeVisitActive.marked
  }
end

function HandleRuntimeActionResultVisit(ok, result)
  if not runtimeVisitRewardPending then return end
  if ok == true and IsRuntimeRewardActionType(result and result.actionType) then
    CompleteRuntimeVisit('reward', runtimeVisitRewardPending)
  end
  runtimeVisitRewardPending = nil
end

local function formatVisitCooldown(seconds)
  seconds = math.floor(tonumber(seconds) or 0)
  if seconds <= 0 then return nil end
  local days = math.floor(seconds / 86400)
  if days >= 2 then return ('%d days'):format(days) end
  if days == 1 then return '1 day' end
  local hours = math.floor(seconds / 3600)
  if hours >= 2 then return ('%d hours'):format(hours) end
  if hours == 1 then return '1 hour' end
  local minutes = math.ceil(seconds / 60)
  if minutes >= 2 then return ('%d minutes'):format(minutes) end
  return '1 minute'
end

local function buildVisitBlockedNotify(policy, state)
  local remaining = tonumber(state and state.cooldownRemaining or 0) or 0
  local label = formatVisitCooldown(remaining)
  if not label then
    return policy and policy.message or 'You have already done this scene.'
  end
  return {
    title = 'Come Back Later',
    description = ('You can return in %s.'):format(label),
    notifyType = 'info'
  }
end

function DeferVisitTrackedDialogOpen(lineId, node, opts)
  if opts and opts.skipVisitCheck then return false end
  local policy = node and node._sceneVisitPolicy
  if not policy then return false end

  local payload = buildVisitPayload(node, policy)
  local key = visitCacheKey(payload)
  if not payload or not key then return false end
  if runtimeVisitPending[key] then return true end

  local function openFirstVisit()
    runtimeVisitActive = {
      payload = payload,
      key = key,
      policy = policy,
      marked = false
    }
    if policy.markOn == 'open' then
      runtimeVisitCache[key] = { ok = true, visited = true, visitCount = 1 }
      runtimeVisitActive.marked = true
      markVisited(payload)
    end
    OpenRuntimeDialogLine(lineId, { skipVisitCheck = true })
  end

  local function openRepeatVisit(state)
    if policy.mode == 'repeat' and policy.repeatDialogLineId and runtimeGlobalNodes[policy.repeatDialogLineId] then
      OpenRuntimeDialogLine(policy.repeatDialogLineId, { skipVisitCheck = true })
      return
    end
    if policy.mode == 'block' or policy.mode == 'repeat' then
      RuntimeNotify(buildVisitBlockedNotify(policy, state), 3500)
      return
    end
    openFirstVisit()
  end

  local function handleState(state)
    runtimeVisitPending[key] = nil
    if type(state) == 'table' then
      runtimeVisitCache[key] = state
    end
    if type(state) == 'table' and state.visited == true then
      openRepeatVisit(state)
      return
    end
    openFirstVisit()
  end

  local cached = runtimeVisitCache[key]
  if cached and not (policy.cooldownSeconds and policy.cooldownSeconds > 0) then
    handleState(cached)
    return true
  end

  runtimeVisitPending[key] = true
  serverRequest('getVisitState', payload, handleState)
  return true
end

function ensureNpcEntity(uid, npcHash)
  if not uid or not npcHash or npcHash == '' then return nil end
  npcHash = tostring(npcHash):gsub('^%s+', ''):gsub('%s+$', '')
  local entry = runtimeNpcs[uid]
  if entry and entry.entity and DoesEntityExist(entry.entity) then
    if entry.model == npcHash then
      return entry.entity
    end
    DeleteEntity(entry.entity)
  end
  local hash = GetHashKey(npcHash)
  if not IsModelValid(hash) then
    return nil
  end
  if IsModelAPed and not IsModelAPed(hash) then
    return nil
  end
  RequestModel(hash)
  local timeout = GetGameTimer() + 4000
  while not HasModelLoaded(hash) and GetGameTimer() < timeout do
    Wait(0)
  end
  if not HasModelLoaded(hash) then
    return nil
  end

  local ped = nil
  local playerPed = PlayerPedId()
  local pcoords = GetEntityCoords(playerPed)
  local heading = GetEntityHeading(playerPed)
  local ok = pcall(function()
    ped = CreatePed(hash, pcoords.x, pcoords.y, pcoords.z - 1.0, heading, false, false, false, false)
  end)
  if not ped or ped == 0 then
    return nil
  end


  SetEntityAsMissionEntity(ped, true, true)
  SetBlockingOfNonTemporaryEvents(ped, true)
  SetPedCanRagdoll(ped, false)
  if SetPedCanBeTargetted then SetPedCanBeTargetted(ped, false) end
  SetEntityInvincible(ped, true)
  SetEntityCanBeDamaged(ped, false)
  SetEntityProofs(ped, true, true, true, true, true, true, true, true)
  if Citizen and Citizen.InvokeNative then
    pcall(function() Citizen.InvokeNative(0x283978A15512B2FE, ped, true) end)
    pcall(function() Citizen.InvokeNative(0x7D9EFB7AD6B19754, ped, true) end)
    pcall(function() Citizen.InvokeNative(0x9F8AA94D6D97DBF4, ped, true) end)
  end
  FreezeEntityPosition(ped, true)
  runtimeNpcs[uid] = { entity = ped, model = npcHash }
  SetModelAsNoLongerNeeded(hash)
  return ped
end

function applyNpcTransform(entity, coords)
  if not entity or not DoesEntityExist(entity) or not coords then return end
  local x = coords.posX or coords.x or 0.0
  local y = coords.posY or coords.y or 0.0
  local z = coords.posZ or coords.z or 0.0
  local h = coords.h or coords.heading or coords.rotZ or 0.0
  RequestCollisionAtCoord(x, y, z)
  SetEntityCoords(entity, x, y, z, false, false, false, false)
  SetEntityCoordsNoOffset(entity, x, y, z, false, false, false)
  SetEntityHeading(entity, h)
  SetEntityVisible(entity, true, false)
  if SetEntityAlpha then
    SetEntityAlpha(entity, 255, false)
  end
  SetEntityCollision(entity, true, true)
  if PlaceEntityOnGroundProperly then
    PlaceEntityOnGroundProperly(entity, true)
  end
end

local function applyNpcLoopAnim(entity, animDict, animName)
  if not entity or not DoesEntityExist(entity) then return end
  local dict = tostring(animDict or ''):gsub('^%s+', ''):gsub('%s+$', '')
  local name = tostring(animName or ''):gsub('^%s+', ''):gsub('%s+$', '')
  if dict == '' then dict = DEFAULT_DIALOG_ANIM_DICT end
  if name == '' then name = DEFAULT_DIALOG_ANIM_NAME end
  RequestAnimDict(dict)
  local timeout = GetGameTimer() + 4000
  while not HasAnimDictLoaded(dict) and GetGameTimer() < timeout do
    Wait(0)
  end
  if not HasAnimDictLoaded(dict) then return end
  ClearPedTasks(entity)
  TaskPlayAnim(entity, dict, name, 1.0, 1.0, -1, 1, 0.0, false, false, false, 0, false)
end

function clearRuntimeNpcs()
  for _, entry in pairs(runtimeNpcs or {}) do
    if entry and entry.entity and DoesEntityExist(entry.entity) then
      DeleteEntity(entry.entity)
    end
  end
  runtimeNpcs = {}
end

function resolveDialogNpcData(dialogGroup)
  if type(dialogGroup) ~= 'table' then return nil, nil end
  local groupHash = dialogGroup.npcHash
  local groupCoords = dialogGroup.coords
  if groupHash and groupHash ~= '' and groupCoords then
    return groupHash, groupCoords
  end
  local firstLine = (dialogGroup.dialogs or {})[1]
  if type(firstLine) ~= 'table' then return nil, nil end
  local hash = groupHash
  if not hash or hash == '' then
    hash = firstLine.npcHash
  end
  local coords = groupCoords or firstLine.coords
  if hash and hash ~= '' and coords then
    return hash, coords
  end
  return nil, nil
end

local function resolveDialogNpcAnimData(dialogGroup)
  if type(dialogGroup) ~= 'table' then
    return DEFAULT_DIALOG_ANIM_DICT, DEFAULT_DIALOG_ANIM_NAME
  end
  local dict = dialogGroup.animDict
  local name = dialogGroup.animName
  local firstLine = (dialogGroup.dialogs or {})[1]
  if (not dict or dict == '') and type(firstLine) == 'table' then
    dict = firstLine.animDict
  end
  if (not name or name == '') and type(firstLine) == 'table' then
    name = firstLine.animName
  end
  if not dict or dict == '' then dict = DEFAULT_DIALOG_ANIM_DICT end
  if not name or name == '' then name = DEFAULT_DIALOG_ANIM_NAME end
  return dict, name
end

function BuildNodesIndex(scene)
  if not scene or not scene.data or not scene.data.nodesGraph then
    return { nodes = {}, links = {}, outLinks = {}, dialogLinks = {}, keyLinks = {} }
  end

  local graph = scene.data.nodesGraph
  local nodes = {}
  for _, node in ipairs(graph.nodes or {}) do
    nodes[node.id] = node
  end
  local sceneVisitPolicy = GetSceneVisitPolicy(scene)
  local actionByUid = {}
  local dialogLineByUid = {}
  local dialogGroupFirstLine = {}
  for _, action in ipairs(scene.data.actionData or {}) do
    if action and action.uid then
      actionByUid[action.uid] = action
    end
  end
  for _, group in ipairs(scene.data.dialogData or {}) do
    if group and group.uid and group.dialogs and group.dialogs[1] and group.dialogs[1].uid then
      dialogGroupFirstLine[group.uid] = group.dialogs[1].uid
    end
    for _, line in ipairs(group.dialogs or {}) do
      if line and line.uid then
        dialogLineByUid[line.uid] = line
      end
    end
  end
  for id, node in pairs(nodes) do
    if node and node.type == 'action' then
      local src = actionByUid[id]
      if src then
        node.title = src.title or node.title
        node.itemName = src.itemName or node.itemName
        if src.itemCount ~= nil then node.itemCount = src.itemCount end
        node.weaponName = src.weaponName or node.weaponName
        if src.ammoCount ~= nil then node.ammoCount = src.ammoCount end
        node.jobName = src.jobName or node.jobName
        if src.grade ~= nil then node.grade = src.grade end
        node.notifyType = src.notifyType or node.notifyType
        node.description = src.description or node.description
        if src.duration ~= nil then node.duration = src.duration end
        node.controlKey = src.controlKey or node.controlKey
        node.promptLabel = src.promptLabel or node.promptLabel
        node.area = src.area or node.area
        if src.useOwnKey ~= nil then
          node.useOwnKey = src.useOwnKey
        end
      end
    end
    if node and node.type == 'dialog-group' then
      node.firstLineId = dialogGroupFirstLine[id] or node.firstLineId
    end
    if node and node.type == 'dialog-line' then
      local src = dialogLineByUid[id]
      if src then
        node.npcName = src.npcName or node.npcName
        node.npcJob = src.npcJob or node.npcJob
        node.npcHash = src.npcHash or node.npcHash
        node.dialog = src.dialog or node.dialog
        node.answers = src.answers or node.answers or {}
      end
    end
    if node then
      node._sceneId = scene.id
      node._sceneCode = scene.code
      node._sceneTitle = scene.title
      node._sceneVisitPolicy = sceneVisitPolicy
    end
  end

  local links = graph.links or {}
  local outLinks = {}
  local dialogLinks = {}
  local keyLinks = {}

  local function normalizeRuleType(rt)
    if not rt then return nil end
    if rt == 'dialog-line' then return 'dialog' end
    if rt == 'dialog-group' then return 'dialog-group' end
    if rt == 'action' then return 'action' end
    return rt
  end

  local function ruleTypeFromNode(node)
    if not node or not node.type then return nil end
    if node.type == 'prop' then return 'prop' end
    if node.type == 'text' then return 'text' end
    if node.type == 'ambient' then return 'ambient' end
    if node.type == 'editor-scene' then return 'editor-scene' end
    if node.type == 'dialog-group' then return 'dialog-group' end
    if node.type == 'dialog-line' then return 'dialog' end
    if node.type == 'action' then
      if node.actionType == 'item' then return 'add-item' end
      if node.actionType == 'weapon' then return 'add-weapon' end
      if node.actionType == 'job' then return 'set-job' end
      if node.actionType == 'notify' then return 'notify' end
      if node.actionType == 'key' then return 'key' end
    end
    return nil
  end

  local normalizedLinks = {}
  for _, link in ipairs(links) do
    local fromNode = nodes[link.fromId]
    local toNode = nodes[link.toId]
    local fromType = normalizeRuleType(link.fromType) or ruleTypeFromNode(fromNode)
    local toType = normalizeRuleType(link.toType) or ruleTypeFromNode(toNode)
    local normalized = {
      id = link.id,
      fromId = link.fromId,
      toId = link.toId,
      fromPort = link.fromPort,
      toPort = link.toPort,
      answerKey = link.answerKey,
      fromType = fromType,
      toType = toType
    }
    table.insert(normalizedLinks, normalized)
  end

  for _, link in ipairs(normalizedLinks) do
    outLinks[link.fromId] = outLinks[link.fromId] or {}
    table.insert(outLinks[link.fromId], link)

    if link.fromType == 'dialog' and link.answerKey then
      local toNode = nodes[link.toId]
      local key = tostring(link.answerKey or ''):upper()
      local keyAllowed = (key == 'E' or key == 'G')
      local isAllowedType = toNode and (toNode.type == 'dialog-line' or toNode.type == 'dialog-group' or toNode.type == 'action')
      if keyAllowed and isAllowedType then
        dialogLinks[link.fromId] = dialogLinks[link.fromId] or {}
        dialogLinks[link.fromId][key] = link
      end
    end

    if link.fromType == 'key' then
      keyLinks[link.fromId] = keyLinks[link.fromId] or {}
      table.insert(keyLinks[link.fromId], link)
    elseif link.toType == 'key' and link.fromType == 'ambient' then
      keyLinks[link.toId] = keyLinks[link.toId] or {}
      table.insert(keyLinks[link.toId], {
        id = link.id,
        fromId = link.toId,
        fromType = 'key',
        toId = link.fromId,
        toType = 'ambient'
      })
    end
  end

  return {
    nodes = nodes,
    links = normalizedLinks,
    outLinks = outLinks,
    dialogLinks = dialogLinks,
    keyLinks = keyLinks
  }
end

function StartSceneRuntime(scene, opts)
  clearPreviewProps()
  clearRuntimeNpcs()
  runtimeTextItems = {}
  runtimeTextRenderCache = {}
  runtimeTextSwitch = {}
  runtimeTextSources = {}
  runtimeTextTargets = {}
  runtimeState.active = true
  runtimeState.scene = scene
  local suppressAuto = opts and opts.suppressAuto or false
  local index = BuildNodesIndex(scene)
  runtimeState.nodes = index.nodes
  runtimeState.links = index.links
  runtimeState.outLinks = index.outLinks
  runtimeState.dialogLinks = index.dialogLinks
  runtimeState.keyLinks = index.keyLinks
  runtimeState.soundById = {}
  runtimeState.soundChain = {}
  runtimeSoundChainOwner = {}

  local keyedSounds = {}
  for _, link in ipairs(runtimeState.links or {}) do
    if link.fromType == 'ambient' and link.toType == 'key' then
      keyedSounds[link.fromId] = true
    end
  end

  local data = scene and scene.data or {}
  for _, prop in ipairs(data.propData or {}) do
    if prop.uid and prop.propHash then
      local runtimePropUid = ('%s::prop::%s'):format(scene.id, prop.uid)
      local entity = ensurePropEntity(runtimePropUid, prop.propHash or 'p_ammoboxlancaster01x')
      applyPropTransform(entity, prop.coords or {})
      if previewProps[runtimePropUid] then
        previewProps[runtimePropUid].sceneId = scene.id
      end
      SyncRuntimePropPreviewHiddenState(prop.uid)
    end
  end

  for _, dialogGroup in ipairs(data.dialogData or {}) do
    local uid = dialogGroup.uid
    local hash, coords = resolveDialogNpcData(dialogGroup)
    local animDict, animName = resolveDialogNpcAnimData(dialogGroup)
    if uid and hash and coords then
      local runtimeNpcUid = ('%s::dialog::%s'):format(scene.id, uid)
      local ped = ensureNpcEntity(runtimeNpcUid, hash)
      if ped then
        applyNpcTransform(ped, coords)
        applyNpcLoopAnim(ped, animDict, animName)
        if runtimeNpcs[runtimeNpcUid] then
          runtimeNpcs[runtimeNpcUid].sceneId = scene.id
        end
      end
    end
  end

  for _, text in ipairs(data.textData or {}) do
    if text and text.coords then
      table.insert(runtimeTextItems, { sceneId = scene.id, item = text })
    end
  end

  for _, sound in ipairs(data.ambientSoundData or {}) do
    if sound and sound.id then
      sound.autoStart = (not keyedSounds[sound.id]) and (not suppressAuto)
      runtimeState.soundById[sound.id] = sound
      runtimeState.soundById[sound.id].sceneId = scene.id
    end
  end

  for _, node in pairs(runtimeState.nodes) do
    if node.type == 'ambient' and node.id and runtimeState.soundById[node.id] then
      node.autoStart = runtimeState.soundById[node.id].autoStart
    end
  end
  for _, link in ipairs(runtimeState.links or {}) do
    if link.fromType == 'ambient' and link.toType == 'ambient' then
      runtimeState.soundChain[link.fromId] = link.toId
      runtimeSoundChainOwner[link.fromId] = scene.id
    end
  end

  for _, node in pairs(runtimeState.nodes) do
    if node.type == 'ambient' and node.autoStart then
      local sound = runtimeState.soundById[node.id]
      if sound then
        PlaySoundNode(sound, runtimeState.soundChain, runtimeState.soundById)
      end
    end
  end
  for _, link in ipairs(runtimeState.links) do
    if link.fromType == 'ambient' and link.toType == 'ambient' then
    end
  end
end

function StopSceneRuntime()
  stopEditorScenePlayback()
  DestroyAllRuntimeSounds()
  runtimeState.active = false
  runtimeState.scene = nil
  runtimeState.nodes = {}
  runtimeState.links = {}
  runtimeState.outLinks = {}
  runtimeState.dialogLinks = {}
  runtimeState.keyLinks = {}
  runtimeState.soundById = {}
  runtimeState.soundChain = {}
  runtimeSoundChainOwner = {}
  runtimeSoundAttach = {}
  runtimeSoundAttachOwner = {}
  runtimeSoundPosCache = {}
  runtimeSoundPaused = {}
  runtimeSoundUrlCache = {}
  runtimeTextItems = {}
  runtimeTextRenderCache = {}
  runtimeTextSwitch = {}
  runtimeTextSources = {}
  runtimeTextTargets = {}
  CloseRuntimeDialog()
  SendNUIMessage({ type = 'runtimeTextRender', items = {} })
  clearPreviewProps()
  clearRuntimeNpcs()
end

function HexToRgb(hex)
  if type(hex) ~= 'string' then return 255, 255, 255 end
  local clean = hex:gsub('#', '')
  if #clean ~= 6 then return 255, 255, 255 end
  local r = tonumber(clean:sub(1, 2), 16) or 255
  local g = tonumber(clean:sub(3, 4), 16) or 255
  local b = tonumber(clean:sub(5, 6), 16) or 255
  return r, g, b
end

function ApplyAllScenesRuntime(scenes)
  DestroyAllRuntimeSounds()
  runtimeAllScenes = scenes or {}
  CloseRuntimeDialog()

  clearPreviewProps()
  clearRuntimeNpcs()
  runtimeTextItems = {}
  runtimeTextRenderCache = {}
  runtimeSoundItems = {}
  runtimeSoundById = {}
  runtimeSoundChain = {}
  runtimeSoundChainOwner = {}
  runtimeSoundAttach = {}
  runtimeSoundAttachOwner = {}
  runtimeSoundPlaying = {}
  runtimeSoundPosCache = {}
  runtimeSoundPaused = {}
  runtimeSoundUrlCache = {}
  runtimeTextSwitch = {}
  runtimeTextSources = {}
  runtimeTextTargets = {}
  ClearKeyPrompts()


  for _, scene in ipairs(runtimeAllScenes) do
    local data = scene.data or {}
    local keyedSounds = {}
    local links = (data.nodesLayout and data.nodesLayout.links) or {}
    for _, link in ipairs(links) do
      if link.fromType == 'ambient' and link.toType == 'key' then
        keyedSounds[link.fromId] = true
      end
    end
    for _, prop in ipairs(data.propData or {}) do
      if prop.uid and prop.propHash then
        local runtimePropUid = ('%s::prop::%s'):format(scene.id, prop.uid)
        local entity = ensurePropEntity(runtimePropUid, prop.propHash)
        applyPropTransform(entity, prop.coords or {})
        if previewProps[runtimePropUid] then
          previewProps[runtimePropUid].sceneId = scene.id
        end
        SyncRuntimePropPreviewHiddenState(prop.uid)
      end
    end

    for _, dialogGroup in ipairs(data.dialogData or {}) do
      local uid = dialogGroup.uid
      local hash, coords = resolveDialogNpcData(dialogGroup)
      local animDict, animName = resolveDialogNpcAnimData(dialogGroup)
      if uid and hash and coords then
        local runtimeNpcUid = ('%s::dialog::%s'):format(scene.id, uid)
        local ped = ensureNpcEntity(runtimeNpcUid, hash)
        if ped then
          applyNpcTransform(ped, coords)
          applyNpcLoopAnim(ped, animDict, animName)
          if runtimeNpcs[runtimeNpcUid] then
            runtimeNpcs[runtimeNpcUid].sceneId = scene.id
          end
        end
      end
    end

    for _, text in ipairs(data.textData or {}) do
      if text.coords then
        table.insert(runtimeTextItems, { sceneId = scene.id, item = text })
      end
    end

    for _, sound in ipairs(data.ambientSoundData or {}) do
      if sound then
        sound.autoStart = not keyedSounds[sound.id]
        table.insert(runtimeSoundItems, { sceneId = scene.id, item = sound })
        if sound.id then
          runtimeSoundById[sound.id] = sound
          runtimeSoundById[sound.id].sceneId = scene.id
        end
      end
    end

    for _, link in ipairs(links) do
      if link.fromType == 'ambient' and link.toType == 'ambient' then
        runtimeSoundChain[link.fromId] = link.toId
        runtimeSoundChainOwner[link.fromId] = scene.id
      elseif link.fromType == 'ambient' and link.toType == 'prop' then
        runtimeSoundAttach[link.fromId] = ('%s::prop::%s'):format(scene.id, link.toId)
        runtimeSoundAttachOwner[link.fromId] = scene.id
      end
    end
  end

  if not runtimeTextThread then
    runtimeTextThread = true
    CreateThread(function()
      while runtimeTextThread do
        if #runtimeTextItems == 0 then
          SendNUIMessage({ type = 'runtimeTextRender', items = {} })
          Wait(500)
        else
          local ped = PlayerPedId()
          local pcoords = GetEntityCoords(ped)
          local playerSpeed = GetEntitySpeed(ped) or 0.0
          local renderItems = {}
          local function isTextVisible(textId)
            if not textId then return true end
            local isSource = runtimeTextSources[textId] == true
            local isTarget = runtimeTextTargets[textId] == true
            if isSource then
              return true
            end
            if isTarget then
              for sourceId, currentId in pairs(runtimeTextSwitch or {}) do
                if sourceId ~= textId and currentId == textId then
                  return true
                end
              end
              return false
            end
            return true
          end
          for _, entry in ipairs(runtimeTextItems) do
            local item = entry.item
            if item.uid and not isTextVisible(item.uid) then
              goto continue_text_item
            end
          local c = item.coords or {}
          if previewGizmo.active and previewGizmo.mode == 'text' and previewGizmo.uid and item.uid == previewGizmo.uid then
            goto continue_text_item
          end
          local x = c.posX or 0
            local y = c.posY or 0
            local z = c.posZ or 0
            local dist = item.distance or 10.0
            local currentDist = #(pcoords - vector3(x, y, z))
            if currentDist <= dist then
              local onScreen, sx, sy = GetScreenCoordFromWorldCoord(x, y, z)
              if onScreen and sx and sy then
                local cacheKey = tostring(item.uid or (entry.sceneId or 'scene') .. ':' .. tostring(item.title or item.text or 'text'))
                local prev = runtimeTextRenderCache[cacheKey]
                if prev then
                  if playerSpeed < 0.08 then
                    local threshold = 0.0015
                    if math.abs((prev.x or 0) - sx) < threshold then
                      sx = prev.x or sx
                    end
                    if math.abs((prev.y or 0) - sy) < threshold then
                      sy = prev.y or sy
                    end
                  else
                    local smoothing = 0.45
                    sx = (prev.x or sx) + ((sx - (prev.x or sx)) * smoothing)
                    sy = (prev.y or sy) + ((sy - (prev.y or sy)) * smoothing)
                  end
                end
                runtimeTextRenderCache[cacheKey] = { x = sx, y = sy }
                table.insert(renderItems, {
                  x = sx,
                  y = sy,
                  text = item.text or item.title or 'Text',
                  color = item.fontColor or '#ffffff',
                  backgroundColor = item.backgroundColor or '#000000',
                  backgroundOpacity = item.backgroundOpacity or 0,
                  size = item.fontSize or 1.5,
                  fontFamily = item.fontFamily or 'EB_Garamond',
                  distance = currentDist,
                  maxDistance = dist
                })
              end
            end
            ::continue_text_item::
          end
          SendNUIMessage({ type = 'runtimeTextRender', items = renderItems })
          Wait(0)
        end
      end
    end)
  end

  BuildGlobalNodes()
  ValidateRuntimeDialogState()
  BuildKeyPrompts()

  if not runtimeSoundAttachThread then
    runtimeSoundAttachThread = true
    CreateThread(function()
      while runtimeSoundAttachThread do
        if next(runtimeSoundAttach) == nil then
          Wait(500)
        else
          for soundId, propId in pairs(runtimeSoundAttach) do
            UpdateAttachedSoundPosition(soundId, false)
          end
          Wait(100)
        end
      end
    end)
  end

  for _, entry in ipairs(runtimeSoundItems) do
      local sound = entry.item
      if sound and sound.id then
        local name = ('vscene_%s'):format(sound.id)
        local isPlaying = IsSoundActive(name)
      if not sound.autoStart and isPlaying then
        SafeStopSound(name)
      elseif sound.autoStart and not isPlaying and sound.soundUrl and sound.soundUrl ~= '' then
        PlaySoundNode(sound, runtimeSoundChain, runtimeSoundById)
      elseif isPlaying then
        ApplySoundSettings(name, sound)
      end
    end
  end

  if not runtimeKeyPromptThread then
    runtimeKeyPromptThread = true
    CreateThread(function()
      while runtimeKeyPromptThread do
        if runtimeDialogState.active then
          if not ValidateRuntimeDialogState() then
            Wait(0)
            goto continue_loop
          end
          DisableAllControlActions(0)
          for _, entry in ipairs(runtimeKeyPrompts) do
            PromptSetEnabled(entry.prompt, false)
            PromptSetVisible(entry.prompt, false)
          end
          if IsControlJustPressed(0, DIALOG_KEY_E) then
            TriggerRuntimeDialogChoice('E')
          elseif IsControlJustPressed(0, DIALOG_KEY_G) then
            TriggerRuntimeDialogChoice('G')
          end
          Wait(0)
        elseif #runtimeKeyPrompts == 0 then
          Wait(500)
        else
          local ped = PlayerPedId()
          local pcoords = GetEntityCoords(ped)
          local anyVisible = false
          for _, entry in ipairs(runtimeKeyPrompts) do
            local dist = #(pcoords - entry.coords)
            local show = dist <= (entry.radius or 2.0)
            PromptSetEnabled(entry.prompt, show)
            PromptSetVisible(entry.prompt, show)
            if show then
              anyVisible = true
              if entry.controlKey and IsControlJustPressed(0, entry.controlKey) then
                TriggerKeyNodeGlobal(entry.keyId, {
                  sourceId = entry.sourceId,
                  sourceType = entry.sourceType
                })
              end
            end
          end
          if anyVisible then
            PromptSetActiveGroupThisFrame(runtimeKeyPromptGroup, CreateVarString(10, 'LITERAL_STRING', 'Key'))
          end
          Wait(0)
        end
        ::continue_loop::
      end
    end)
  end
end

function DestroyAllRuntimeSounds()
  local names = {}

  for soundId, _ in pairs(runtimeSoundById or {}) do
    if soundId then
      names[('vscene_%s'):format(soundId)] = true
    end
  end

  for _, entry in ipairs(runtimeSoundItems or {}) do
    local sound = entry and entry.item or nil
    if sound and sound.id then
      names[('vscene_%s'):format(sound.id)] = true
    end
  end

  for name, isActive in pairs(runtimeSoundPlaying or {}) do
    if isActive then
      names[name] = true
    end
  end

  for name, _ in pairs(names) do
    SafeStopSound(name)
  end

  runtimeSoundPlaying = {}
  runtimeSoundPaused = {}
  runtimeSoundUrlCache = {}
  runtimeSoundPosCache = {}
end

function PlaySoundNode(sound, chainMap, soundById)
  if not sound or not sound.id then return end
  if not sound.soundUrl or sound.soundUrl == '' then return end
  local name = ('vscene_%s'):format(sound.id)
  if IsSoundActive(name) then
    return
  end
  local vec = ResolveSoundVector(sound)
  local volume = sound.volume or 1.0
  local loop = sound.loop or false
  local options = {}
  local nextId = chainMap and chainMap[sound.id]
  options.onPlayEnd = function()
    runtimeSoundPlaying[name] = nil
    runtimeSoundPaused[name] = nil
    runtimeSoundPosCache[name] = nil
    if nextId and not loop then
      local nextSound = soundById and soundById[nextId]
      if nextSound then
        PlaySoundNode(nextSound, chainMap, soundById)
      end
    end
  end
  local ok, err = pcall(function()
    if exports and exports.xsound and exports.xsound.PlayUrlPos then
      exports.xsound:PlayUrlPos(name, sound.soundUrl, volume, vec, loop, options)
    else
    end
  end)
  runtimeSoundPlaying[name] = ok == true
  runtimeSoundUrlCache[name] = sound.soundUrl
  if not ok then
    return
  end
  runtimeSoundPosCache[name] = vec
  runtimeSoundPaused[name] = nil
  ApplySoundSettings(name, sound)
end

function SafeSoundExists(name)
  if not name then return false end
  return runtimeSoundPlaying[name] == true
end

function IsSoundActive(name)
  if not name then return false end
  return runtimeSoundPlaying[name] == true
end

function SafeStopSound(name)
  if not name then return end
  if not (exports and exports.xsound) then return end
  if exports.xsound.Destroy then
    pcall(function() exports.xsound:Destroy(name) end)
  elseif exports.xsound.Stop then
    pcall(function() exports.xsound:Stop(name) end)
  end
  runtimeSoundPlaying[name] = nil
  runtimeSoundPaused[name] = nil
  runtimeSoundPosCache[name] = nil
  runtimeSoundUrlCache[name] = nil
end

function SafePauseSound(name)
  if not name or not SafeSoundExists(name) then return false end
  if not (exports and exports.xsound and exports.xsound.Pause) then return false end
  local ok = pcall(function()
    exports.xsound:Pause(name)
  end)
  if ok then
    runtimeSoundPaused[name] = true
  end
  return ok == true
end

function SafeResumeSound(name)
  if not name or not SafeSoundExists(name) then return false end
  if not (exports and exports.xsound and exports.xsound.Resume) then return false end
  local ok = pcall(function()
    exports.xsound:Resume(name)
  end)
  if ok then
    runtimeSoundPaused[name] = nil
    runtimeSoundPlaying[name] = true
  end
  return ok == true
end

function ApplySoundSettings(name, sound)
  if not name or not sound then return end
  if not (exports and exports.xsound) then return end
  if not SafeSoundExists(name) then return end
  local dist = tonumber(sound.distance) or 10.0
  local vol = tonumber(sound.volume) or 1.0
  local loop = sound.loop == true
  if exports.xsound.Distance then
    pcall(function() exports.xsound:Distance(name, dist) end)
  end
  if exports.xsound.setVolume then
    pcall(function() exports.xsound:setVolume(name, vol) end)
  elseif exports.xsound.SetVolume then
    pcall(function() exports.xsound:SetVolume(name, vol) end)
  end
  if exports.xsound.setSoundLoop then
    pcall(function() exports.xsound:setSoundLoop(name, loop) end)
  elseif exports.xsound.SetSoundLoop then
    pcall(function() exports.xsound:SetSoundLoop(name, loop) end)
  end
end

function SafeSetSoundPosition(name, vec)
  if not name or not vec then return end
  if not (exports and exports.xsound) then return end
  if not SafeSoundExists(name) then return end
  if exports.xsound.Position then
    pcall(function() exports.xsound:Position(name, vec) end)
  elseif exports.xsound.setPosition then
    pcall(function() exports.xsound:setPosition(name, vec) end)
  elseif exports.xsound.SetPosition then
    pcall(function() exports.xsound:SetPosition(name, vec) end)
  end
end

function UpdateAttachedSoundPosition(soundId, force)
  if not soundId then return end
  local propId = runtimeSoundAttach[soundId]
  if not propId then return end

  local propEntry = previewProps[propId]
  if not (propEntry and propEntry.entity and DoesEntityExist(propEntry.entity)) then
    return
  end

  local name = ('vscene_%s'):format(soundId)
  if not IsSoundActive(name) then return end

  local pos = GetEntityCoords(propEntry.entity)
  local vec = vector3(pos.x, pos.y, pos.z)
  local prev = runtimeSoundPosCache[name]
  if not force and prev then
    local dx = math.abs((prev.x or 0.0) - vec.x)
    local dy = math.abs((prev.y or 0.0) - vec.y)
    local dz = math.abs((prev.z or 0.0) - vec.z)
    if dx < 0.01 and dy < 0.01 and dz < 0.01 then
      return
    end
  end

  SafeSetSoundPosition(name, vec)
  runtimeSoundPosCache[name] = vec
end

function ResolveSoundVector(sound)
  if not sound or not sound.id then
    return vector3(0.0, 0.0, 0.0)
  end
  local attachPropId = runtimeSoundAttach[sound.id]
  if attachPropId then
    local propEntry = previewProps[attachPropId]
    if propEntry and propEntry.entity and DoesEntityExist(propEntry.entity) then
      local pos = GetEntityCoords(propEntry.entity)
      return vector3(pos.x, pos.y, pos.z)
    end
  end
  local c = sound.coords or {}
  return vector3(c.posX or 0.0, c.posY or 0.0, c.posZ or 0.0)
end

function ClearKeyPrompts()
  for _, entry in ipairs(runtimeKeyPrompts) do
    if entry.prompt then
      pcall(function() PromptDelete(entry.prompt) end)
    end
  end
  runtimeKeyPrompts = {}
end

function BuildGlobalNodes()
  runtimeGlobalNodes = {}
  runtimeGlobalKeyLinks = {}
  runtimeGlobalDialogLinks = {}
  runtimeGlobalOutLinks = {}
  for _, sc in ipairs(runtimeAllScenes or {}) do
    local index = BuildNodesIndex(sc)
    for id, node in pairs(index.nodes or {}) do
      runtimeGlobalNodes[id] = node
    end
    for fromId, links in pairs(index.outLinks or {}) do
      runtimeGlobalOutLinks[fromId] = runtimeGlobalOutLinks[fromId] or {}
      for _, link in ipairs(links or {}) do
        table.insert(runtimeGlobalOutLinks[fromId], link)
      end
    end
    for keyId, links in pairs(index.keyLinks or {}) do
      runtimeGlobalKeyLinks[keyId] = runtimeGlobalKeyLinks[keyId] or {}
      for _, link in ipairs(links) do
        table.insert(runtimeGlobalKeyLinks[keyId], link)
      end
    end
    for fromId, answerMap in pairs(index.dialogLinks or {}) do
      runtimeGlobalDialogLinks[fromId] = runtimeGlobalDialogLinks[fromId] or {}
      for answerKey, link in pairs(answerMap or {}) do
        runtimeGlobalDialogLinks[fromId][answerKey] = link
      end
    end

    -- If an ambient is attached to a prop, it should use the prop's key prompts.
    local links = (sc.data and sc.data.nodesLayout and sc.data.nodesLayout.links) or {}
    local propKeyIds = {}
    local ambientAttachedProp = {}
    for _, link in ipairs(links) do
      if link.toType == 'key' and link.fromType == 'prop' and link.fromId and link.toId then
        propKeyIds[link.fromId] = propKeyIds[link.fromId] or {}
        table.insert(propKeyIds[link.fromId], link.toId)
      elseif link.fromType == 'ambient' and link.toType == 'prop' and link.fromId and link.toId then
        ambientAttachedProp[link.fromId] = link.toId
      end
    end
    for ambientId, propId in pairs(ambientAttachedProp) do
      local keys = propKeyIds[propId] or {}
      for _, keyId in ipairs(keys) do
        runtimeGlobalKeyLinks[keyId] = runtimeGlobalKeyLinks[keyId] or {}
        local exists = false
        for _, existing in ipairs(runtimeGlobalKeyLinks[keyId]) do
          if existing.toId == ambientId and existing.toType == 'ambient' then
            exists = true
            break
          end
        end
        if not exists then
          table.insert(runtimeGlobalKeyLinks[keyId], {
            id = ('attach_%s_%s'):format(keyId, ambientId),
            fromId = keyId,
            fromType = 'key',
            toId = ambientId,
            toType = 'ambient'
          })
        end
      end
    end
  end
end

function CloseRuntimeDialog()
  if runtimeVisitActive and runtimeVisitActive.policy and runtimeVisitActive.policy.markOn == 'close' then
    CompleteRuntimeVisit('close')
  end
  runtimeVisitActive = nil
  if runtimeDialogState.cam then
    RenderScriptCams(false, true, 450, true, true)
    DestroyCam(runtimeDialogState.cam, false)
    runtimeDialogState.cam = nil
    runtimeDialogState.npcUid = nil
  end
  runtimeDialogState.active = false
  runtimeDialogState.currentLineId = nil
  SendNUIMessage({ type = 'runtimeDialog', active = false })
  if uiState.open then
    SetNuiFocus(true, true)
    if SetNuiFocusKeepInput then
      SetNuiFocusKeepInput(false)
    end
  else
    SetNuiFocus(false, false)
    if SetNuiFocusKeepInput then
      SetNuiFocusKeepInput(false)
    end
  end
end

local function findRuntimeDialogContext(lineId)
  local function matchScene(scene)
    if not scene or not scene.data then return nil end
    for _, group in ipairs(scene.data.dialogData or {}) do
      for _, line in ipairs(group.dialogs or {}) do
        if line and line.uid == lineId then
          return {
            scene = scene,
            group = group,
            line = line
          }
        end
      end
    end
    return nil
  end

  local matched = matchScene(runtimeState and runtimeState.scene or nil)
  if matched then return matched end

  for _, scene in ipairs(runtimeAllScenes or {}) do
    matched = matchScene(scene)
    if matched then return matched end
  end

  return nil
end

local function openRuntimeDialogCamera(lineId)
  local context = findRuntimeDialogContext(lineId)
  if not context or not context.scene or not context.group or not context.group.uid then
    return
  end

  local npcUid = ('%s::dialog::%s'):format(context.scene.id, context.group.uid)
  local entry = runtimeNpcs[npcUid]
  if not (entry and entry.entity and DoesEntityExist(entry.entity)) then
    return
  end

  if runtimeDialogState.cam then
    RenderScriptCams(false, false, 0, true, true)
    DestroyCam(runtimeDialogState.cam, false)
    runtimeDialogState.cam = nil
  end

  local entity = entry.entity
  local lineKey = tostring(lineId or '')
  local sum = 0
  for i = 1, #lineKey do
    sum = sum + string.byte(lineKey, i)
  end
  local side = (sum % 2 == 0) and 0.9 or -0.9
  local camPos = GetOffsetFromEntityInWorldCoords(entity, side, 1.65, 0.72)
  local lookPos = GetOffsetFromEntityInWorldCoords(entity, 0.0, 0.05, 0.62)

  local cam = CreateCam('DEFAULT_SCRIPTED_CAMERA', true)
  SetCamCoord(cam, camPos.x, camPos.y, camPos.z)
  PointCamAtCoord(cam, lookPos.x, lookPos.y, lookPos.z)
  SetCamFov(cam, 33.0)
  RenderScriptCams(true, true, 700, true, true)

  runtimeDialogState.cam = cam
  runtimeDialogState.npcUid = npcUid
end

function ValidateRuntimeDialogState()
  if not runtimeDialogState.active then return true end
  local lineId = runtimeDialogState.currentLineId
  if not lineId then
    CloseRuntimeDialog()
    return false
  end
  local node = runtimeGlobalNodes[lineId]
  if not node or node.type ~= 'dialog-line' then
    CloseRuntimeDialog()
    RuntimeNotify('Dialog state gecersiz, aktif satir kaldirildi.')
    return false
  end
  return true
end

local function FindRuntimeDialogGroupFirstLine(groupId)
  if not groupId then return nil end
  local group = runtimeGlobalNodes[groupId]
  if group and group.firstLineId and runtimeGlobalNodes[group.firstLineId] then
    return group.firstLineId
  end
  for id, node in pairs(runtimeGlobalNodes or {}) do
    if node and node.type == 'dialog-line' and node.parentUid == groupId then
      return id
    end
  end
  return nil
end

function OpenRuntimeDialogLine(lineId, opts)
  if not lineId then
    RuntimeNotify('Dialog acilis id eksik.')
    return
  end
  local node = runtimeGlobalNodes[lineId]
  if not node or node.type ~= 'dialog-line' then
    RuntimeNotify('Dialog line bulunamadi veya gecersiz.')
    return
  end
  if DeferVisitTrackedDialogOpen(lineId, node, opts) then
    return
  end
  local item = node.item or node
  runtimeDialogState.active = true
  runtimeDialogState.currentLineId = lineId
  openRuntimeDialogCamera(lineId)
  SetNuiFocus(true, true)
  if SetNuiFocusKeepInput then
    SetNuiFocusKeepInput(false)
  end
  SendNUIMessage({
    type = 'runtimeDialog',
    active = true,
    lineId = lineId,
    npcName = item.npcName or 'NPC',
    npcJob = item.npcJob or '',
    dialog = item.dialog or '',
    answers = item.answers or {}
  })
end

function TriggerRuntimeDialogChoice(answerKey)
  if not runtimeDialogState.active then return end
  if not ValidateRuntimeDialogState() then return end
  local key = tostring(answerKey or ''):upper()
  if key ~= 'E' and key ~= 'G' then
    RuntimeNotify('Sadece E veya G secenegi gecerlidir.')
    return
  end
  local lineId = runtimeDialogState.currentLineId
  local linkMap = runtimeGlobalDialogLinks[lineId]
  if not linkMap then
    RuntimeNotify('Dialog link bulunamadi.')
    return
  end
  local link = linkMap[key]
  if not link or not link.toId then
    RuntimeNotify(('Secenek [%s] baglantisi yok.'):format(tostring(key)))
    return
  end
  local target = runtimeGlobalNodes[link.toId]
  if not target then
    RuntimeNotify('Dialog hedef node bulunamadi.')
    return
  end
  if target.type == 'dialog-line' then
    CompleteRuntimeVisit('choice')
    OpenRuntimeDialogLine(link.toId, { skipVisitCheck = true })
    return
  end
  if target.type == 'dialog-group' then
    local firstLineId = FindRuntimeDialogGroupFirstLine(target.id or link.toId)
    if firstLineId then
      CompleteRuntimeVisit('choice')
      OpenRuntimeDialogLine(firstLineId, { skipVisitCheck = true })
      return
    end
    RuntimeNotify('Dialog group icinde acilacak satir bulunamadi.')
    return
  end
  if target.type == 'action' then
    CompleteRuntimeVisit('choice')
    ExecuteActionNode(target, 'dialog-line')
    CloseRuntimeDialog()
    return
  end
  RuntimeNotify('Dialog secenegi yalnizca Dialog Line veya Action nodeuna baglanabilir.')
end

function ExecuteActionNode(actionNode, sourceType)
  if not actionNode or actionNode.type ~= 'action' then return end
  local actionType = actionNode.actionType
  local payload = {
    actionType = actionType,
    nodeId = actionNode.id,
    title = actionNode.title,
    sourceType = sourceType
  }
  if actionType == 'item' then
    payload.itemName = actionNode.itemName or ''
    payload.itemCount = tonumber(actionNode.itemCount) or 1
  
  elseif actionType == 'weapon' then
    payload.weaponName = actionNode.weaponName or ''
    payload.ammoCount = tonumber(actionNode.ammoCount) or 0

  elseif actionType == 'job' then
    payload.jobName = actionNode.jobName or ''
    payload.grade = tonumber(actionNode.grade) or 0

  elseif actionType == 'notify' then
    payload.notifyType = actionNode.notifyType or 'info'
    payload.notifyTitle = actionNode.title or actionNode.notifyTitle or ''
    payload.notifyDescription = actionNode.description or actionNode.notifyDescription or ''
    payload.duration = tonumber(actionNode.duration) or 3000

  else

  end
  PrepareRuntimeVisitReward(actionNode)
  TriggerServerEvent('v-scene:runtimeAction', payload)
end

function ExecuteGlobalLink(link, context)
  if not link or not link.toId then return end
  local target = runtimeGlobalNodes[link.toId]
  if target and target.type == 'action' then
    ExecuteActionNode(target, link.fromType or 'key')
    return
  end
  if target and target.type == 'dialog-line' then
    OpenRuntimeDialogLine(target.id)
    return
  end
  if target and target.type == 'ambient' then
    local sound = runtimeSoundById and runtimeSoundById[target.id] or nil
    if sound then
      local name = ('vscene_%s'):format(sound.id)
      if IsSoundActive(name) then
        if runtimeSoundPaused[name] then
          SafeResumeSound(name)
        else
          SafePauseSound(name)
        end
      else
        PlaySoundNode(sound, runtimeSoundChain, runtimeSoundById)
      end
    end
    return
  end
  if target and target.type == 'text' then
    if context and context.sourceType == 'text' and context.sourceId then
      runtimeTextSwitch[context.sourceId] = target.id
    end
    return
  end
  if target and target.type == 'editor-scene' then
    local visited = (context and context.visited) or {}
    if visited[target.id] then
      return
    end
    visited[target.id] = true
    local editorScene = findEditorSceneForNode(target)
    local raw = editorScene and editorScene.raw or target.editorSceneData
    if not playEditorScene(raw) then
      RuntimeNotify('Editor scene oynatilamadi.')
      return
    end
    local nextLinks = runtimeGlobalOutLinks[target.id] or {}
    for _, nextLink in ipairs(nextLinks) do
      ExecuteGlobalLink(nextLink, {
        sourceType = 'editor-scene',
        sourceId = target.id,
        visited = visited
      })
      Wait(0)
    end
    return
  end
  if link.toType == 'ambient' then
    local sound = runtimeSoundById and runtimeSoundById[link.toId] or nil
    if sound then
     
      local name = ('vscene_%s'):format(sound.id)
      if IsSoundActive(name) then
        if runtimeSoundPaused[name] then
          SafeResumeSound(name)
        else
          SafePauseSound(name)
        end
      else
        PlaySoundNode(sound, runtimeSoundChain, runtimeSoundById)
      end
    end
    return
  end
  RuntimeNotify('Node baglantisi gecersiz veya desteklenmiyor.')
end

function BuildKeyPrompts()
  ClearKeyPrompts()
  local allTextIds = {}
  local textSources = {}
  local textTargets = {}
  local function resolveRuleType(id, fallback)
    if fallback then
      if fallback == 'dialog-line' then return 'dialog' end
      return fallback
    end
    local node = runtimeGlobalNodes and runtimeGlobalNodes[id] or nil
    if not node or not node.type then return nil end
    if node.type == 'prop' then return 'prop' end
    if node.type == 'text' then return 'text' end
    if node.type == 'ambient' then return 'ambient' end
    if node.type == 'dialog-group' then return 'dialog-group' end
    if node.type == 'dialog-line' then return 'dialog' end
    if node.type == 'action' then
      if node.actionType == 'item' then return 'add-item' end
      if node.actionType == 'weapon' then return 'add-weapon' end
      if node.actionType == 'job' then return 'set-job' end
      if node.actionType == 'notify' then return 'notify' end
      if node.actionType == 'key' then return 'key' end
    end
    return nil
  end
  if not runtimeKeyPromptGroup then
    runtimeKeyPromptGroup = GetRandomIntInRange(1000, 999999)
  end
  for _, sc in ipairs(runtimeAllScenes or {}) do
    local data = sc.data or {}
    local links = (data.nodesLayout and data.nodesLayout.links) or {}
    local propById = {}
    for _, p in ipairs(data.propData or {}) do
      if p.uid and p.coords then
        propById[p.uid] = { coords = p.coords, radius = 2.0 }
      end
    end
    local textById = {}
    for _, t in ipairs(data.textData or {}) do
      if t.uid and t.coords then
        textById[t.uid] = { coords = t.coords, radius = t.distance or 2.0 }
        allTextIds[t.uid] = true
      end
    end
    local soundById = {}
    for _, s in ipairs(data.ambientSoundData or {}) do
      if s.id and s.coords then
        soundById[s.id] = { coords = s.coords, radius = s.distance or 5.0 }
      end
    end
    local dialogById = {}
    for _, d in ipairs(data.dialogData or {}) do
      if d.uid then
        local dcoords = d.coords
        if not dcoords and d.dialogs and d.dialogs[1] then
          dcoords = d.dialogs[1].coords
        end
        if dcoords then
          dialogById[d.uid] = { coords = dcoords, radius = 2.0 }
        end
      end
    end
    local propByKey = {}
    local ambientAttachToProp = {}
    for _, l in ipairs(links) do
      local lf = resolveRuleType(l.fromId, l.fromType)
      local lt = resolveRuleType(l.toId, l.toType)
      if lt == 'key' and lf == 'prop' and l.fromId and l.toId then
        propByKey[l.fromId] = true
      elseif lf == 'ambient' and lt == 'prop' and l.fromId and l.toId then
        ambientAttachToProp[l.fromId] = l.toId
      end
    end

    for _, link in ipairs(links) do
      local fromType = resolveRuleType(link.fromId, link.fromType)
      local toType = resolveRuleType(link.toId, link.toType)
      if toType == 'key' and (fromType == 'prop' or fromType == 'text' or fromType == 'ambient' or fromType == 'dialog-group') then
        local source = nil
        local skipPrompt = false
        if fromType == 'prop' then source = propById[link.fromId] end
        if fromType == 'text' then
          source = textById[link.fromId]
          if link.fromId then
            textSources[link.fromId] = true
            if not runtimeTextSwitch[link.fromId] then
              runtimeTextSwitch[link.fromId] = link.fromId
            end
          end
        end
        if fromType == 'ambient' then
          local attachedPropId = ambientAttachToProp[link.fromId]
          if attachedPropId and propById[attachedPropId] then
            source = propById[attachedPropId]
            if propByKey[attachedPropId] then
              -- ambient uses attached prop key prompt; skip its own prompt
              skipPrompt = true
            end
          else
            source = soundById[link.fromId]
          end
        end
        if fromType == 'dialog-group' then
          source = dialogById[link.fromId]
        end
        if source and source.coords and not skipPrompt then
          local c = source.coords
          local prompt = PromptRegisterBegin()
          local keyNode = runtimeGlobalNodes[link.toId]
          local keyControlLabel = (keyNode and keyNode.controlKey) or ''
          local promptLabel = (keyNode and keyNode.promptLabel) or ''
          local keyControl = ParseControlKey(keyControlLabel) or 0xCEFD9220
          local visibleLabel = promptLabel ~= '' and promptLabel or (keyControlLabel ~= '' and keyControlLabel or 'Key')
          PromptSetControlAction(prompt, keyControl)
          PromptSetText(prompt, CreateVarString(10, 'LITERAL_STRING', visibleLabel))
          PromptSetEnabled(prompt, false)
          PromptSetVisible(prompt, false)
          PromptSetStandardMode(prompt, true)
          PromptSetGroup(prompt, runtimeKeyPromptGroup)
          PromptRegisterEnd(prompt)
          table.insert(runtimeKeyPrompts, {
            sceneId = sc.id,
            keyId = link.toId,
            prompt = prompt,
            sourceId = link.fromId,
            sourceType = fromType,
            coords = vector3(c.posX or 0, c.posY or 0, c.posZ or 0),
            radius = source.radius or 2.0,
            controlKey = keyControl
          })
        end
      end
    end
    for _, link in ipairs(links) do
      local fromType = resolveRuleType(link.fromId, link.fromType)
      local toType = resolveRuleType(link.toId, link.toType)
      if fromType == 'key' and toType == 'text' and link.toId then
        textTargets[link.toId] = true
      end
    end
  end
  local nextSwitch = {}
  for sourceId, _ in pairs(textSources) do
    local current = runtimeTextSwitch[sourceId] or sourceId
    if not allTextIds[current] then
      current = sourceId
    end
    nextSwitch[sourceId] = current
  end
  runtimeTextSwitch = nextSwitch
  runtimeTextSources = textSources
  runtimeTextTargets = textTargets
end

function TriggerKeyNodeGlobal(nodeId, context)
  local links = runtimeGlobalKeyLinks[nodeId] or {}
  for _, link in ipairs(links) do
    ExecuteGlobalLink(link, context)
    Wait(0)
  end
end

function ApplySceneRuntime(scene)
  if not scene then return end
  local sceneId = scene.id
  local data = scene.data or {}
  local keyedSounds = {}
  local links = (data.nodesLayout and data.nodesLayout.links) or {}
  for _, link in ipairs(links) do
    if link.fromType == 'ambient' and link.toType == 'key' then
      keyedSounds[link.fromId] = true
    end
  end

  local previousSoundIds = {}
  for _, entry in ipairs(runtimeSoundItems or {}) do
    if entry and entry.sceneId == sceneId then
      local sound = entry.item
      if sound and sound.id then
        previousSoundIds[sound.id] = true
      end
    end
  end

  local replaced = false
  for i, sc in ipairs(runtimeAllScenes) do
    if sc and sc.id == sceneId then
      runtimeAllScenes[i] = scene
      replaced = true
      break
    end
  end
  if not replaced then
    table.insert(runtimeAllScenes, scene)
  end

  for uid, entry in pairs(previewProps) do
    if entry and entry.sceneId == sceneId then
      if entry.entity and DoesEntityExist(entry.entity) then
        DeleteEntity(entry.entity)
      end
      previewProps[uid] = nil
    end
  end

  for uid, entry in pairs(runtimeNpcs) do
    if entry and entry.sceneId == sceneId then
      if entry.entity and DoesEntityExist(entry.entity) then
        DeleteEntity(entry.entity)
      end
      runtimeNpcs[uid] = nil
    end
  end

  for _, prop in ipairs(data.propData or {}) do
    if prop.uid and prop.propHash then
      local runtimePropUid = ('%s::prop::%s'):format(sceneId, prop.uid)
      local entity = ensurePropEntity(runtimePropUid, prop.propHash or 'p_ammoboxlancaster01x')
      applyPropTransform(entity, prop.coords or {})
      if previewProps[runtimePropUid] then
        previewProps[runtimePropUid].sceneId = sceneId
      end
      SyncRuntimePropPreviewHiddenState(prop.uid)
    end
  end

  for _, dialogGroup in ipairs(data.dialogData or {}) do
    local uid = dialogGroup.uid
    local hash, coords = resolveDialogNpcData(dialogGroup)
    local animDict, animName = resolveDialogNpcAnimData(dialogGroup)
    if uid and hash and coords then
      local runtimeNpcUid = ('%s::dialog::%s'):format(sceneId, uid)
      local ped = ensureNpcEntity(runtimeNpcUid, hash)
      if ped then
        applyNpcTransform(ped, coords)
        applyNpcLoopAnim(ped, animDict, animName)
        if runtimeNpcs[runtimeNpcUid] then
          runtimeNpcs[runtimeNpcUid].sceneId = sceneId
        end
      end
    end
  end

  local filteredTexts = {}
  for _, entry in ipairs(runtimeTextItems) do
    if entry.sceneId ~= sceneId then
      table.insert(filteredTexts, entry)
    end
  end
  for _, text in ipairs(data.textData or {}) do
    if text.coords then
      table.insert(filteredTexts, { sceneId = sceneId, item = text })
    end
  end
  runtimeTextItems = filteredTexts

  local filteredSounds = {}
  local currentSoundIds = {}
  BuildGlobalNodes()
  ValidateRuntimeDialogState()
  BuildKeyPrompts()

  for _, entry in ipairs(runtimeSoundItems) do
    if entry.sceneId ~= sceneId then
      table.insert(filteredSounds, entry)
    end
  end
  for _, sound in ipairs(data.ambientSoundData or {}) do
    if sound then
      sound.autoStart = not keyedSounds[sound.id]
      table.insert(filteredSounds, { sceneId = sceneId, item = sound })
      if sound.id then
        runtimeSoundById[sound.id] = sound
        runtimeSoundById[sound.id].sceneId = sceneId
        currentSoundIds[sound.id] = true
      end
    end
  end
  runtimeSoundItems = filteredSounds

  for soundId, _ in pairs(previousSoundIds) do
    if not currentSoundIds[soundId] then
      SafeStopSound(('vscene_%s'):format(soundId))
    end
  end

  for id, s in pairs(runtimeSoundById) do
    if s and s.sceneId == sceneId and not currentSoundIds[id] then
      runtimeSoundById[id] = nil
    end
  end

  for fromId, ownerId in pairs(runtimeSoundChainOwner) do
    if ownerId == sceneId then
      runtimeSoundChain[fromId] = nil
      runtimeSoundChainOwner[fromId] = nil
    end
  end
  for fromId, ownerId in pairs(runtimeSoundAttachOwner) do
    if ownerId == sceneId then
      runtimeSoundAttach[fromId] = nil
      runtimeSoundAttachOwner[fromId] = nil
      runtimeSoundPosCache[('vscene_%s'):format(fromId)] = nil
    end
  end
  for _, link in ipairs(links) do
    if link.fromType == 'ambient' and link.toType == 'ambient' then
      runtimeSoundChain[link.fromId] = link.toId
      runtimeSoundChainOwner[link.fromId] = sceneId
    elseif link.fromType == 'ambient' and link.toType == 'prop' then
      runtimeSoundAttach[link.fromId] = ('%s::prop::%s'):format(sceneId, link.toId)
      runtimeSoundAttachOwner[link.fromId] = sceneId
    end
  end

  for _, entry in ipairs(runtimeSoundItems) do
    if entry.sceneId == sceneId then
      local sound = entry.item
      if sound and sound.id then
        local name = ('vscene_%s'):format(sound.id)
        local isPlaying = IsSoundActive(name)
        local cachedUrl = runtimeSoundUrlCache[name]
        local nextUrl = sound.soundUrl or ''
        if nextUrl == '' and isPlaying then
          SafeStopSound(name)
        elseif isPlaying and cachedUrl and cachedUrl ~= nextUrl then
          SafeStopSound(name)
          if sound.autoStart and nextUrl ~= '' then
            PlaySoundNode(sound, runtimeSoundChain, runtimeSoundById)
          end
        elseif keyedSounds[sound.id] then
          if isPlaying then
            ApplySoundSettings(name, sound)
            if runtimeSoundAttach[sound.id] then
              UpdateAttachedSoundPosition(sound.id, false)
            end
          end
        elseif sound.autoStart and not isPlaying and nextUrl ~= '' then
          PlaySoundNode(sound, runtimeSoundChain, runtimeSoundById)
        elseif isPlaying then
          ApplySoundSettings(name, sound)
          if runtimeSoundAttach[sound.id] then
            UpdateAttachedSoundPosition(sound.id, false)
          else
            SafeSetSoundPosition(name, ResolveSoundVector(sound))
          end
        end
      end
    end
  end
end

function ParseControlKey(value)
  if not value then return nil end
  if type(value) == 'number' then return value end
  if type(value) ~= 'string' then return nil end
  local trimmed = value:gsub('%s+', '')
  if trimmed == '' then return nil end
  local num = tonumber(trimmed)
  if num then return num end
  if trimmed:sub(1, 2) == '0x' or trimmed:sub(1, 2) == '0X' then
    return tonumber(trimmed)
  end
  return nil
end

function TriggerKeyNode(nodeId)
  if not runtimeState.active then return end
  local links = runtimeState.keyLinks[nodeId] or {}
  for _, link in ipairs(links) do
    local target = runtimeState.nodes[link.toId]
    if target and target.type == 'action' then
      ExecuteActionNode(target, 'key')
    elseif target and target.type == 'ambient' then
      local sound = runtimeState.soundById and runtimeState.soundById[target.id] or nil
      if sound then
        local name = ('vscene_%s'):format(sound.id)
        if IsSoundActive(name) then
          if runtimeSoundPaused[name] then
            SafeResumeSound(name)
          else
            SafePauseSound(name)
          end
        else
          PlaySoundNode(sound, runtimeState.soundChain, runtimeState.soundById)
        end
      end
    elseif target and target.type == 'dialog-line' then
      OpenRuntimeDialogLine(target.id)
    end
    Wait(0)
  end
end

function TriggerDialogChoice(dialogLineId, answerKey)
  if not runtimeState.active then return end
  local linkSet = runtimeState.dialogLinks[dialogLineId]
  if not linkSet then return end
  local link = linkSet[answerKey]
  if not link then return end
end

if not runtimeThreadRunning then
  runtimeThreadRunning = true
  CreateThread(function()
    while true do
      if not runtimeState.active then
        Wait(250)
      else
        for _, node in pairs(runtimeState.nodes) do
          if node.type == 'action' and node.actionType == 'key' and node.useOwnKey then
            local key = ParseControlKey(node.controlKey)
            if key and IsControlJustPressed(0, key) then
     
            end
          end
        end
        Wait(0)
      end
    end
  end)
end

function GetNoClipTarget()
  local ped = PlayerPedId()
  local veh = GetVehiclePedIsIn(ped, false)
  local mnt = GetMount(ped)
  return (veh == 0 and (mnt == 0 and ped or mnt) or veh)
end

function TranslateHeading(entity, h)
  if GetEntityType(entity) == 1 then
    return (h + 180) % 360
  else
    return h
  end
end

function EnableNoClip()
  local entity = GetNoClipTarget()
  ClearPedTasksImmediately(entity, false, false)
  FreezeEntityPosition(entity, true)
  SetEntityHeading(entity, TranslateHeading(entity, GetEntityHeading(entity)))
  SetEntityVisible(entity, false, false)
end

function DisableNoClip()
  local entity = GetNoClipTarget()
  ClearPedTasksImmediately(entity, false, false)
  FreezeEntityPosition(entity, false)
  SetEntityVisible(entity, true, false)
end

function stopCoordsPick(sendCancel)
  if not coordsPick.active then return end
  coordsPick.active = false
  if coordsPick.previewNpc and DoesEntityExist(coordsPick.previewNpc) then
    DeleteEntity(coordsPick.previewNpc)
  end
  coordsPick.previewNpc = nil
  if coordsPick.cam then
    RenderScriptCams(false, true, 250, true, true)
    DestroyCam(coordsPick.cam, false)
    coordsPick.cam = nil
  end
  DisableNoClip()
  if originalPlayerPosition then
    local entity = GetNoClipTarget()
    SetEntityCoordsNoOffset(entity, originalPlayerPosition.x, originalPlayerPosition.y, originalPlayerPosition.z, false, false, false)
  end
  if originalPlayerHeading then
    local entity = GetNoClipTarget()
    SetEntityHeading(entity, TranslateHeading(entity, originalPlayerHeading))
  end
  SetNuiFocus(true, true)
  if SetNuiFocusKeepInput then
    SetNuiFocusKeepInput(false)
  end
  SendNUIMessage({ type = sendCancel and 'coordsPickCanceled' or 'coordsPick', active = false })
end

function startCoordsPick(payload)
  local mode = payload and payload.type or nil
  if coordsPick.active then return end
  if mode ~= 'text' and mode ~= 'ambient' and mode ~= 'dialog' then return end
  coordsPick.active = true
  coordsPick.mode = mode
  local entity = GetNoClipTarget()
  originalPlayerPosition = GetEntityCoords(entity)
  originalPlayerHeading = GetEntityHeading(entity)
  coordsPick.pitch = 0.0
  coordsPick.heading = GetEntityHeading(entity)
  coordsPick.pos = vector3(originalPlayerPosition.x, originalPlayerPosition.y, originalPlayerPosition.z)
  coordsPick.cam = nil
  coordsPick.previewNpc = nil
  local dialogNpcHash = payload and payload.npcHash or nil
  if mode == 'dialog' and dialogNpcHash and tostring(dialogNpcHash) ~= '' then
    local hash = GetHashKey(tostring(dialogNpcHash))
    if IsModelValid(hash) and (not IsModelAPed or IsModelAPed(hash)) then
      RequestModel(hash)
      local timeout = GetGameTimer() + 3000
      while not HasModelLoaded(hash) and GetGameTimer() < timeout do
        Wait(0)
      end
      if HasModelLoaded(hash) then
        local ped = CreatePed(hash, coordsPick.pos.x, coordsPick.pos.y, coordsPick.pos.z, coordsPick.heading or 0.0, false, false, false, false)
        if ped and ped ~= 0 then
          SetEntityAsMissionEntity(ped, true, true)
          SetBlockingOfNonTemporaryEvents(ped, true)
          SetPedCanRagdoll(ped, false)
          SetEntityInvincible(ped, true)
          FreezeEntityPosition(ped, true)
          coordsPick.previewNpc = ped
        end
        SetModelAsNoLongerNeeded(hash)
      end
    end
  end
  FreezeEntityPosition(entity, true)
  SetNuiFocus(false, false)
  if SetNuiFocusKeepInput then
    SetNuiFocusKeepInput(true)
  end
  SendNUIMessage({ type = 'coordsPick', active = true })

  CreateThread(function()
    while coordsPick.active do
      DisableAllControlActions(0)
      EnableControlAction(0, 0x8FD015D8) -- INPUT_MOVE_UP_ONLY (W)
      EnableControlAction(0, 0xD27782E3) -- INPUT_MOVE_DOWN_ONLY (S)
      EnableControlAction(0, 0x7065027D) -- INPUT_MOVE_LEFT_ONLY (A)
      EnableControlAction(0, 0xB4E465B4) -- INPUT_MOVE_RIGHT_ONLY (D)
      EnableControlAction(0, 0xDE794E3E) -- INPUT_COVER (Q up)
      EnableControlAction(0, 0xCEFD9220) -- INPUT_ENTER (E down)
      EnableControlAction(0, 0x2CD5343E) -- INPUT_CREATOR_ACCEPT (Enter)
      EnableControlAction(0, 0x6319DB71) -- Arrow Up
      EnableControlAction(0, 0x05CA7C52) -- Arrow Down
      EnableControlAction(0, 0xA65EBAB4) -- LEFT ARROW
      EnableControlAction(0, 0xDEB34313) -- RIGHT ARROW

      EnableControlAction(0, 0x8FFC75D6) -- INPUT_SPRINT (Shift)
      EnableControlAction(0, 0x339F3730) -- INPUT_CREATOR_LS (Ctrl)
      EnableControlAction(0, 0x156F7119) -- INPUT_FRONTEND_CANCEL (Esc)

      local entity = GetNoClipTarget()
      local x = coordsPick.pos.x
      local y = coordsPick.pos.y
      local z = coordsPick.pos.z
      local h = coordsPick.heading

      local speed = coordsPick.baseSpeed
      if IsDisabledControlPressed(0, 0x8FFC75D6) then
        speed = coordsPick.baseSpeed * coordsPick.fastMul
      elseif IsDisabledControlPressed(0, 0x339F3730) then
        speed = coordsPick.baseSpeed * coordsPick.slowMul
      end

      if IsDisabledControlPressed(0, 0xDE794E3E) then
        z = z + speed
      end
      if IsDisabledControlPressed(0, 0xCEFD9220) then
        z = z - speed
      end

      local r = -h * math.pi / 180
      local dx = speed * math.sin(r)
      local dy = speed * math.cos(r)
      if IsDisabledControlPressed(0, 0x8FD015D8) then
        x = x + dx
        y = y + dy
      end
      if IsDisabledControlPressed(0, 0xD27782E3) then
        x = x - dx
        y = y - dy
      end
      if IsDisabledControlPressed(0, 0x7065027D) then
        x = x - dy
        y = y + dx
      end
      if IsDisabledControlPressed(0, 0xB4E465B4) then
        x = x + dy
        y = y - dx
      end

      coordsPick.pos = vector3(x, y, z)

      Citizen.InvokeNative(0x2A32FAA57B937173, -1795314153, x, y, z + 0.02, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.7, 0.7, 0.2, 255, 0, 0, 220, 0, 0, 2, true, false)

      if IsDisabledControlPressed(0, 0xA65EBAB4) then
        coordsPick.heading = coordsPick.heading - 2.0
        if coordsPick.heading < -360.0 then coordsPick.heading = coordsPick.heading + 360.0 end
      end
      if IsDisabledControlPressed(0, 0xDEB34313) then
        coordsPick.heading = coordsPick.heading + 2.0
        if coordsPick.heading > 360.0 then coordsPick.heading = coordsPick.heading - 360.0 end
      end
      h = coordsPick.heading

      SetEntityHeading(entity, h)
      if coordsPick.mode == 'dialog' and coordsPick.previewNpc and DoesEntityExist(coordsPick.previewNpc) then
        SetEntityCoordsNoOffset(coordsPick.previewNpc, x, y, z, false, false, false)
        SetEntityHeading(coordsPick.previewNpc, h)
      end

      if IsDisabledControlJustPressed(0, 0x2CD5343E) then
        SendNUIMessage({ type = 'coordsPicked', coords = { posX = x, posY = y, posZ = z } })
        stopCoordsPick(false)
      elseif IsDisabledControlJustPressed(0, 0x156F7119) then
        stopCoordsPick(true)
      end

      Wait(0)
    end
  end)
end
