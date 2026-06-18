RegisterNetEvent('v-scene:response', function(id, result)
    local cb = pendingRequests[id]
    if cb then
      pendingRequests[id] = nil
      cb(result)
    end
end)

RegisterNetEvent('v-scene:imported', function(scene)
    SendNUIMessage({ type = 'sceneImported', scene = scene })
end)

RegisterNetEvent('v-scene:importFailed', function(message)
    SendNUIMessage({ type = 'sceneImportFailed', message = message or 'Import failed' })
end)

RegisterNetEvent('v-scene:allScenesUpdated', function(scenes)
    if type(scenes) == 'table' then
      ApplyAllScenesRuntime(scenes)
    end
end)

RegisterNetEvent('v-scene:sceneUpdated', function(scene)
    if scene then
      ApplySceneRuntime(scene)
    end
end)

RegisterNetEvent('v-scene:runtimeActionResult', function(ok, message, result)
    if HandleRuntimeActionResultVisit then
      HandleRuntimeActionResultVisit(ok, result)
    end
    if message and message ~= '' then
      RuntimeNotify({
        title = ok and 'Success' or 'Error',
        description = tostring(message),
        notifyType = ok and 'success' or 'error'
      }, 3000, ok and 'success' or 'error')
    end
end)

RegisterNetEvent('v-scene:runtimeNotify', function(data)
    if type(data) ~= 'table' then return end
    local title = tostring(data.title or '')
    local desc = tostring(data.description or '')
    local notifyType = tostring(data.notifyType or data.type or 'info')
    local duration = tonumber(data.duration) or 3000
    RuntimeNotify({
      title = title,
      description = desc,
      notifyType = notifyType
    }, duration, notifyType)
end)

local editorSceneCallbacks = editorSceneCallbacks or {}
local editorSceneRequestInFlight = editorSceneRequestInFlight or false

local function resourceState(name)
    if not name or name == '' then return 'missing' end
    if GetResourceState then
      return GetResourceState(name)
    end
    return 'missing'
end

local function loadEditorScenes(cb)
    if Config and Config.Editor ~= true then
      if cb then cb({}) end
      return
    end
    if resourceState('v-editor') ~= 'started' then
      if cb then cb({}) end
      return
    end
    local cached = GetEditorScenesCache()
    if type(cached) == 'table' and #cached > 0 then
      if cb then cb(cached) end
      return
    end
    if cb then
      table.insert(editorSceneCallbacks, cb)
    end
    if editorSceneRequestInFlight then return end
    editorSceneRequestInFlight = true
    TriggerServerEvent('v-editor:getCompositions')
    SetTimeout(5000, function()
      if not editorSceneRequestInFlight then return end
      editorSceneRequestInFlight = false
      local callbacks = editorSceneCallbacks
      editorSceneCallbacks = {}
      for _, fn in ipairs(callbacks) do
        fn(GetEditorScenesCache())
      end
    end)
end

RegisterNetEvent('v-editor:receiveCompositions', function(compositions)
    editorSceneRequestInFlight = false
    SetEditorScenesCache(compositions or {})
    local callbacks = editorSceneCallbacks
    editorSceneCallbacks = {}
    for _, fn in ipairs(callbacks) do
      fn(GetEditorScenesCache())
    end
end)

RegisterNUICallback('loadScenes', function(_, cb)
    serverRequest('loadScenes', {}, cb)
end)

RegisterNUICallback('loadEditorScenes', function(_, cb)
    loadEditorScenes(function(list)
      if cb then cb(list or {}) end
    end)
end)

RegisterNUICallback('saveScenes', function(data, cb)
    serverRequest('saveScenes', data or {}, cb)
end)
RegisterNUICallback('saveScene', function(data, cb)
    serverRequest('saveScene', data or {}, cb)
end)

RegisterNUICallback('startRuntime', function(data, cb)
    local scene = data and data.scene
    if scene then
      StartSceneRuntime(scene, { suppressAuto = data and data.suppressAuto })
    end
    if cb then cb(true) end
end)

RegisterNUICallback('stopRuntime', function(_, cb)
    StopSceneRuntime()
    if cb then cb(true) end
end)

RegisterNUICallback('triggerKeyNode', function(data, cb)
    if data and data.nodeId then
      TriggerKeyNode(data.nodeId)
    end
    if cb then cb(true) end
end)

RegisterNUICallback('triggerDialogChoice', function(data, cb)
    if data and data.dialogUid and data.answerKey then
      TriggerDialogChoice(data.dialogUid, data.answerKey)
    end
    if cb then cb(true) end
end)

RegisterNUICallback('runtimeDialogChoice', function(data, cb)
    if data and data.answerKey then
      TriggerRuntimeDialogChoice(data.answerKey)
    end
    if cb then cb(true) end
end)

RegisterNUICallback('closeRuntimeDialog', function(_, cb)
    CloseRuntimeDialog()
    if cb then cb(true) end
end)

RegisterNUICallback('getPlayerCoords', function(_, cb)
    local ped = PlayerPedId()
    local spawn = GetOffsetFromEntityInWorldCoords(ped, 0.0, 1.0, 0.0)
    local heading = GetEntityHeading(ped)
    if cb then
      cb({ posX = spawn.x, posY = spawn.y, posZ = spawn.z, heading = heading })
    end
end)
RegisterNUICallback('syncProps', function(data, cb)
    local props = (data and data.props) or {}
    local seen = {}
    for _, prop in ipairs(props) do
      local uid = prop.uid
      if uid then
        local model = prop.propHash or prop.hash or 'p_ammoboxlancaster01x'
        local previewUid = GetEditorPreviewUid(uid)
        local entity = ensurePropEntity(previewUid, model)
        if entity and DoesEntityExist(entity) then
          applyPropTransform(entity, prop.coords or {})
          seen[previewUid] = true
          SetRuntimePropPreviewHiddenByBaseUid(uid, true)
        end
      end
    end
    for uid, entry in pairs(previewProps) do
      if IsEditorPreviewUid(uid) and not seen[uid] and entry and entry.entity and DoesEntityExist(entry.entity) then
        local baseUid = uid:gsub('^' .. EDITOR_PREVIEW_PREFIX, '')
        DeleteEntity(entry.entity)
        previewProps[uid] = nil
        SetRuntimePropPreviewHiddenByBaseUid(baseUid, false)
      end
    end
    if cb then cb(true) end
end)
RegisterNUICallback('clearProps', function(_, cb)
    for uid, entry in pairs(previewProps) do
      if IsEditorPreviewUid(uid) then
        local baseUid = uid:gsub('^' .. EDITOR_PREVIEW_PREFIX, '')
        SetRuntimePropPreviewHiddenByBaseUid(baseUid, false)
      end
    end
    clearEditorPreviewProps()
    if cb then cb(true) end
end)

RegisterNUICallback('startPropGizmo', function(data, cb)
    local uid = data and data.uid
    local hash = data and data.propHash or 'p_ammoboxlancaster01x'
    if not uid then
      if cb then cb(false) end
      return
    end
    local entity = ensurePropEntity(GetEditorPreviewUid(uid), hash)
    if not entity or not DoesEntityExist(entity) then
      RuntimeNotify({
        title = 'Invalid Model',
        description = 'Use a valid object hash or ped model for this scene prop.',
        notifyType = 'error'
      }, 3500, 'error')
      if cb then cb(false) end
      return
    end
    local coords = data and data.coords or {}
    local x = coords.posX or coords.x or 0.0
    local y = coords.posY or coords.y or 0.0
    local z = coords.posZ or coords.z or 0.0
    if x == 0.0 and y == 0.0 and z == 0.0 then
      local ped = PlayerPedId()
      local spawn = GetOffsetFromEntityInWorldCoords(ped, 0.0, 1.0, 0.0)
      coords.posX = spawn.x
      coords.posY = spawn.y
      coords.posZ = spawn.z
    end
    applyPropTransform(entity, coords)

    SendNUIMessage({ action = 'INTERFACE_CONTROL', status = false })
    SetNuiFocus(false, false)
    local result = exports.object_gizmo:useGizmo(entity)
    SetNuiFocus(true, true)
    SendNUIMessage({ action = 'INTERFACE_CONTROL', status = true })

    if type(result) == 'table' then
      local pos = result.position or result.pos or result.coords or {}
      local rot = result.rotation or result.rot or {}
      local out = {
        posX = pos.x or pos[1] or coords.posX or 0.0,
        posY = pos.y or pos[2] or coords.posY or 0.0,
        posZ = pos.z or pos[3] or coords.posZ or 0.0,
        rotX = rot.x or rot[1] or coords.rotX or 0.0,
        rotY = rot.y or rot[2] or coords.rotY or 0.0,
        rotZ = rot.z or rot[3] or coords.rotZ or 0.0,
        scale = coords.scale or 1
      }
      SendNUIMessage({ type = 'propGizmoDone', uid = uid, coords = out })
    end
    if cb then cb(true) end
end)

RegisterNUICallback('startCoordsPick', function(data, cb)
    startCoordsPick(data or {})
    if cb then cb(true) end
end)

RegisterNUICallback('startPreviewGizmo', function(data, cb)
    local ok = startPreviewGizmo(data or {})
    if cb then cb(ok == true) end
end)

RegisterNUICallback('stopCoordsPick', function(_, cb)
    stopCoordsPick(true)
    if cb then cb(true) end
end)

RegisterNUICallback("closeInterface", function(_, cb)
    OpenUI(false)
    if cb then cb(true) end
end)
