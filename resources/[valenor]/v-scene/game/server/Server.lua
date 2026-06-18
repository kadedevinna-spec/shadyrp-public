local function dbScalar(query, params)
  local p = promise.new()
  exports.oxmysql:scalar(query, params, function(result)
    p:resolve(result)
  end)
  return Citizen.Await(p)
end

local function dbQuery(query, params)
  local p = promise.new()
  exports.oxmysql:query(query, params, function(result)
    p:resolve(result or {})
  end)
  return Citizen.Await(p)
end

local function dbExecute(query, params)
  local p = promise.new()
  exports.oxmysql:execute(query, params, function(result)
    p:resolve(result)
  end)
  return Citizen.Await(p)
end

local function dbInsert(query, params)
  local p = promise.new()
  exports.oxmysql:insert(query, params, function(result)
    p:resolve(result)
  end)
  return Citizen.Await(p)
end

local sessionOwner = sessionOwner or {}
local visitTableReady = false

local function ensureVisitTable()
  if visitTableReady then return end
  visitTableReady = true
  dbExecute([[
    CREATE TABLE IF NOT EXISTS `v_scene_visit` (
      `id` INT NOT NULL AUTO_INCREMENT,
      `player_key` VARCHAR(128) NOT NULL,
      `scene_id` VARCHAR(96) NOT NULL,
      `scene_code` VARCHAR(32) DEFAULT '',
      `visit_key` VARCHAR(96) NOT NULL DEFAULT 'default',
      `visit_count` INT NOT NULL DEFAULT 0,
      `first_seen` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
      `last_seen` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
      `completed_at` TIMESTAMP NULL DEFAULT NULL,
      PRIMARY KEY (`id`),
      UNIQUE KEY `uniq_player_scene_visit` (`player_key`, `scene_id`, `visit_key`),
      KEY `idx_player_key` (`player_key`),
      KEY `idx_scene_id` (`scene_id`),
      KEY `idx_scene_code` (`scene_code`)
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
  ]], {})
end

CreateThread(function()
  Wait(1500)
  ensureVisitTable()
end)

local IDENTIFIER_PRIORITY = {
  'license',
  'license2',
  'fivem',
  'discord',
  'xbl',
  'live',
  'steam'
}

local function tableHasEntries(value)
  if type(value) ~= 'table' then
    return false
  end
  for _, enabled in pairs(value) do
    if enabled then
      return true
    end
  end
  return false
end

local function normalizeToken(value)
  local text = BridgeTrim and BridgeTrim(value) or tostring(value or '')
  return text ~= '' and text:lower() or ''
end

local function permissionLists()
  local function normalizeList(value)
    if type(value) ~= 'table' then
      return {}
    end

    local normalized = {}
    for _, entry in ipairs(value) do
      local token = normalizeToken(entry)
      if token ~= '' then
        normalized[token] = true
      end
    end
    return normalized
  end

  local configured = (Config and Config.PermissionsList) or {}
  return {
    jobs = normalizeList(configured.jobs),
    groups = normalizeList(configured.groups),
    identifier = normalizeList(configured.identifier)
  }
end

local function normalizeIdentifier(value)
  return normalizeToken(value)
end

local function collectPlayerIdentifiers(src)
  local out = {}
  local list = GetPlayerIdentifiers(src) or {}
  for _, identifier in ipairs(list) do
    local normalized = normalizeIdentifier(identifier)
    if normalized ~= '' then
      out[#out + 1] = normalized
    end
  end
  return out
end

local function selectPreferredIdentifier(identifiers)
  if type(identifiers) ~= 'table' or #identifiers == 0 then
    return nil
  end

  for _, prefix in ipairs(IDENTIFIER_PRIORITY) do
    local needle = prefix .. ':'
    for _, identifier in ipairs(identifiers) do
      if identifier:sub(1, #needle) == needle then
        return identifier
      end
    end
  end

  return identifiers[1]
end

local function waitForPermissionContext(src, activeRules)
  local shouldWait = activeRules.jobs or activeRules.groups
  if not shouldWait then
    return BridgeServer and BridgeServer.GetPermissionContext and BridgeServer.GetPermissionContext(src) or {}
  end

  local attempts = 0
  while attempts < 12 do
    local context = BridgeServer and BridgeServer.GetPermissionContext and BridgeServer.GetPermissionContext(src) or {}
    local hasJob = context and context.job and tostring(context.job) ~= ''
    local hasGroup = context and context.group and tostring(context.group) ~= ''

    if (not activeRules.jobs or hasJob) and (not activeRules.groups or hasGroup) then
      return context
    end

    attempts = attempts + 1
    Wait(250)
  end

  return BridgeServer and BridgeServer.GetPermissionContext and BridgeServer.GetPermissionContext(src) or {}
end

local function canAccessEditor(src)
  local lists = permissionLists()
  local hasRules = tableHasEntries(lists.jobs) or tableHasEntries(lists.groups) or tableHasEntries(lists.identifier)

  if not hasRules then
    return (Config and Config.AllowEditorWhenPermissionsEmpty) ~= false, nil
  end

  local mode = tostring((Config and Config.PermissionMode) or 'any')
  local matches = {
    jobs = false,
    groups = false,
    identifier = false
  }
  local activeRules = {
    jobs = tableHasEntries(lists.jobs),
    groups = tableHasEntries(lists.groups),
    identifier = tableHasEntries(lists.identifier)
  }

  if activeRules.identifier then
    for _, identifier in ipairs(collectPlayerIdentifiers(src)) do
      if lists.identifier[identifier] then
        matches.identifier = true
        break
      end
    end
  end

  local context = waitForPermissionContext(src, activeRules)
  if activeRules.jobs and context.job and lists.jobs[normalizeToken(context.job)] then
    matches.jobs = true
  end
  if activeRules.groups and context.group and lists.groups[normalizeToken(context.group)] then
    matches.groups = true
  end
  if activeRules.groups and not matches.groups and BridgeServer and BridgeServer.HasGroupPermission then
    for groupName, enabled in pairs(lists.groups) do
      if enabled and BridgeServer.HasGroupPermission(src, tostring(groupName)) then
        matches.groups = true
        break
      end
    end
  end

  local allowed = false
  if mode == 'all' then
    allowed = true
    for ruleName, isActive in pairs(activeRules) do
      if isActive and not matches[ruleName] then
        allowed = false
        break
      end
    end
  else
    allowed = matches.jobs or matches.groups or matches.identifier
  end

  if allowed then
    return true, nil
  end

  return false, 'Bu menuyu kullanmak icin yetkin yok.'
end

local function getIdentifier(source)
  return selectPreferredIdentifier(collectPlayerIdentifiers(source))
end

local function getOwner(source)
  local identifiers = collectPlayerIdentifiers(source)
  local preferred = selectPreferredIdentifier(identifiers)

  local cached = sessionOwner[source]
  if cached then
    for _, id in ipairs(identifiers) do
      if id == cached then return cached end
    end
  end

  for _, id in ipairs(identifiers) do
    if dbScalar('SELECT id FROM v_scene WHERE owner = ? LIMIT 1', { id }) then
      sessionOwner[source] = id
      return id
    end
  end

  local fallback = preferred or identifiers[1]
  sessionOwner[source] = fallback
  return fallback
end

local function cleanVisitValue(value, fallback, maxLength)
  local text = BridgeTrim and BridgeTrim(value) or tostring(value or '')
  if text == '' then
    text = fallback or ''
  end
  text = text:gsub('[%c]', '')
  if maxLength and #text > maxLength then
    text = text:sub(1, maxLength)
  end
  return text
end

local function getVisitPlayerKey(src)
  local tracking = Config and Config.VisitTracking or {}
  local scope = tostring(tracking.identifierScope or 'character'):lower()

  if scope ~= 'license' and BridgeServer and BridgeServer.GetCharacterIdentifier then
    local characterId = BridgeServer.GetCharacterIdentifier(src)
    characterId = cleanVisitValue(characterId, '', 128)
    if characterId ~= '' then
      return characterId
    end
  end

  return cleanVisitValue(getOwner(src), '', 128)
end

local function normalizeVisitPayload(payload)
  payload = type(payload) == 'table' and payload or {}
  local sceneId = cleanVisitValue(payload.sceneId or payload.id, '', 96)
  if sceneId == '' then
    return nil
  end
  local cooldownSeconds = tonumber(payload.cooldownSeconds or payload.cooldown or 0) or 0
  cooldownSeconds = math.floor(cooldownSeconds)
  if cooldownSeconds < 0 then cooldownSeconds = 0 end
  if cooldownSeconds > 31536000 then cooldownSeconds = 31536000 end

  return {
    sceneId = sceneId,
    sceneCode = cleanVisitValue(payload.sceneCode or payload.code, '', 32),
    visitKey = cleanVisitValue(payload.visitKey or 'default', 'default', 96),
    cooldownSeconds = cooldownSeconds
  }
end

local function getSceneVisitState(src, payload)
  ensureVisitTable()
  local normalized = normalizeVisitPayload(payload)
  local playerKey = getVisitPlayerKey(src)
  if not normalized or playerKey == '' then
    return { ok = false, visited = false, visitCount = 0 }
  end

  local row = dbQuery(
    [[
      SELECT
        visit_count,
        completed_at,
        first_seen,
        last_seen,
        TIMESTAMPDIFF(SECOND, COALESCE(completed_at, last_seen, first_seen), CURRENT_TIMESTAMP) AS seconds_since_visit
      FROM v_scene_visit
      WHERE player_key = ? AND scene_id = ? AND visit_key = ?
      LIMIT 1
    ]],
    { playerKey, normalized.sceneId, normalized.visitKey }
  )[1]

  if not row then
    return { ok = true, visited = false, visitCount = 0, cooldownSeconds = normalized.cooldownSeconds, cooldownRemaining = 0 }
  end
  local cooldownSeconds = normalized.cooldownSeconds or 0
  local secondsSinceVisit = tonumber(row.seconds_since_visit) or 0
  local cooldownRemaining = 0
  local visited = true
  if cooldownSeconds > 0 then
    cooldownRemaining = cooldownSeconds - secondsSinceVisit
    if cooldownRemaining < 0 then cooldownRemaining = 0 end
    visited = cooldownRemaining > 0
  end

  return {
    ok = true,
    visited = visited,
    visitCount = tonumber(row.visit_count) or 1,
    completed = row.completed_at ~= nil,
    firstSeen = row.first_seen,
    lastSeen = row.last_seen,
    completedAt = row.completed_at,
    cooldownSeconds = cooldownSeconds,
    cooldownRemaining = cooldownRemaining,
    canReplay = cooldownSeconds > 0 and visited == false
  }
end

local function markSceneVisited(src, payload)
  ensureVisitTable()
  local normalized = normalizeVisitPayload(payload)
  local playerKey = getVisitPlayerKey(src)
  if not normalized or playerKey == '' then
    return { ok = false, visited = false, visitCount = 0 }
  end

  local reason = tostring(payload and payload.reason or ''):lower()
  local completed = (payload and payload.completed == true) or reason == 'reward' or reason == 'finish' or reason == 'success'
  completed = completed and 1 or 0
  dbExecute([[
    INSERT INTO v_scene_visit (player_key, scene_id, scene_code, visit_key, visit_count, completed_at)
    VALUES (?, ?, ?, ?, 1, CASE WHEN ? = 1 THEN CURRENT_TIMESTAMP ELSE NULL END)
    ON DUPLICATE KEY UPDATE
      scene_code = VALUES(scene_code),
      visit_count = visit_count + 1,
      last_seen = CURRENT_TIMESTAMP,
      completed_at = CASE WHEN ? = 1 THEN CURRENT_TIMESTAMP ELSE completed_at END
  ]], { playerKey, normalized.sceneId, normalized.sceneCode, normalized.visitKey, completed, completed })

  return getSceneVisitState(src, normalized)
end

local function generateCode()
  for _ = 1, 20 do
    local code = ('VLNR%05d'):format(math.random(0, 99999))
    local exists = dbScalar('SELECT id FROM v_scene WHERE code = ? LIMIT 1', { code })
    if not exists then
      return code
    end
  end
  return ('VLNR%05d'):format(math.random(0, 99999))
end

local function newSceneId()
  return ('SCN_%d_%04d'):format(os.time(), math.random(0, 9999))
end

local function loadScenes(owner)
  local rows = dbQuery('SELECT id, code, title, subtitle, scene_json, order_index FROM v_scene WHERE owner = ? ORDER BY order_index ASC', { owner })
  local scenes = {}
  for _, row in ipairs(rows) do
    local scene = {}
    if row.scene_json and row.scene_json ~= '' then
      local ok, decoded = pcall(json.decode, row.scene_json)
      if ok and type(decoded) == 'table' then
        scene = decoded
      end
    end
    scene.dbId = row.id
    scene.code = row.code
    scene.title = scene.title or row.title
    scene.subtitle = scene.subtitle or row.subtitle
    table.insert(scenes, scene)
  end
  return scenes
end

local function loadAllScenes()
  local rows = dbQuery('SELECT id, code, title, subtitle, scene_json, order_index FROM v_scene ORDER BY order_index ASC', {})
  local scenes = {}
  for _, row in ipairs(rows or {}) do
    local scene = {}
    if row.scene_json and row.scene_json ~= '' then
      local ok, decoded = pcall(json.decode, row.scene_json)
      if ok and type(decoded) == 'table' then
        scene = decoded
      end
    end
    scene.dbId = row.id
    scene.code = row.code
    scene.title = scene.title or row.title
    scene.subtitle = scene.subtitle or row.subtitle
    table.insert(scenes, scene)
  end
  return scenes
end

local function saveScenes(owner, scenes)
  if type(scenes) ~= 'table' then return {} end

  local existing = dbQuery('SELECT id FROM v_scene WHERE owner = ?', { owner })
  local existingIds = {}
  for _, row in ipairs(existing) do
    existingIds[row.id] = true
  end

  local keepIds = {}
  local out = {}

  for index, scene in ipairs(scenes) do
    if type(scene) ~= 'table' then goto continue end
    local dbId = scene.dbId
    local code = scene.code
    if not code or code == '' then
      code = generateCode()
      scene.code = code
    end
    if not scene.id then
      scene.id = newSceneId()
    end
    scene.title = scene.title or 'New Scene'
    scene.subtitle = scene.subtitle or ''
    local jsonData = json.encode(scene)
    if dbId and existingIds[dbId] then
      dbExecute(
        'UPDATE v_scene SET code = ?, title = ?, subtitle = ?, scene_json = ?, order_index = ? WHERE id = ? AND owner = ?',
        { code, scene.title, scene.subtitle, jsonData, index, dbId, owner }
      )
    else
      local insertId = dbInsert(
        'INSERT INTO v_scene (owner, code, title, subtitle, scene_json, order_index) VALUES (?, ?, ?, ?, ?, ?)',
        { owner, code, scene.title, scene.subtitle, jsonData, index }
      )
      scene.dbId = insertId
      dbId = insertId
    end
    keepIds[dbId] = true
    table.insert(out, scene)
    ::continue::
  end

  for id, _ in pairs(existingIds) do
    if not keepIds[id] then
      dbExecute('DELETE FROM v_scene WHERE id = ? AND owner = ?', { id, owner })
    end
  end

  return out
end

local function saveScene(owner, scene)
  if type(scene) ~= 'table' then return nil end
  local dbId = scene.dbId
  local code = scene.code
  if not code or code == '' then
    code = generateCode()
    scene.code = code
  end
  if not scene.id then
    scene.id = newSceneId()
  end
  scene.title = scene.title or 'New Scene'
  scene.subtitle = scene.subtitle or ''
  local jsonData = json.encode(scene)

  if dbId then
    dbExecute(
      'UPDATE v_scene SET code = ?, title = ?, subtitle = ?, scene_json = ? WHERE id = ? AND owner = ?',
      { code, scene.title, scene.subtitle, jsonData, dbId, owner }
    )
    return scene
  end

  local row = dbQuery('SELECT COALESCE(MAX(order_index), -1) AS max_order FROM v_scene WHERE owner = ?', { owner })[1]
  local nextOrder = ((row and row.max_order) or -1) + 1
  local insertId = dbInsert(
    'INSERT INTO v_scene (owner, code, title, subtitle, scene_json, order_index) VALUES (?, ?, ?, ?, ?, ?)',
    { owner, code, scene.title, scene.subtitle, jsonData, nextOrder }
  )
  scene.dbId = insertId
  return scene
end

local function editorDeniedResponse(name)
  if name == 'loadScenes' then
    return { denied = true, message = 'Bu menuyu kullanmak icin yetkin yok.' }
  end
  if name == 'checkEditorPermission' then
    return { allowed = false, message = 'Bu menuyu kullanmak icin yetkin yok.' }
  end
  return { ok = false, denied = true, message = 'Bu menuyu kullanmak icin yetkin yok.' }
end

RegisterNetEvent('v-scene:request', function(requestId, name, payload)
  local src = source
  if name == 'getVisitState' then
    TriggerClientEvent('v-scene:response', src, requestId, getSceneVisitState(src, payload))
    return
  end
  if name == 'markSceneVisited' then
    TriggerClientEvent('v-scene:response', src, requestId, markSceneVisited(src, payload))
    return
  end

  local editorRequest = name == 'checkEditorPermission'
    or name == 'loadScenes'
    or name == 'saveScenes'
    or name == 'saveScene'

  if editorRequest then
    local allowed, message = canAccessEditor(src)
    if not allowed then
      if name ~= 'loadScenes' then
        TriggerClientEvent('v-scene:runtimeNotify', src, {
          title = 'Yetki Yok',
          description = message or 'Bu menuyu kullanmak icin yetkin yok.'
        })
      end
      TriggerClientEvent('v-scene:response', src, requestId, editorDeniedResponse(name))
      return
    end
    if name == 'checkEditorPermission' then
      TriggerClientEvent('v-scene:response', src, requestId, { allowed = true, message = '' })
      return
    end
  end

  local owner = getOwner(src)
  if not owner then
    TriggerClientEvent('v-scene:response', src, requestId, editorDeniedResponse(name))
    return
  end

  if name == 'loadScenes' then
    local scenes = loadScenes(owner)
    TriggerClientEvent('v-scene:response', src, requestId, scenes)
    return
  end
  if name == 'loadAllScenes' then
    local scenes = loadAllScenes()
    TriggerClientEvent('v-scene:response', src, requestId, scenes)
    return
  end

  if name == 'saveScenes' then
    local scenes = saveScenes(owner, payload and payload.scenes or {})
    TriggerClientEvent('v-scene:response', src, requestId, scenes)
    local changedSceneId = payload and payload.changedSceneId
    if changedSceneId then
      local updated = nil
      for _, sc in ipairs(scenes) do
        if sc and sc.id == changedSceneId then
          updated = sc
          break
        end
      end
      if updated then
        TriggerClientEvent('v-scene:sceneUpdated', -1, updated)
        return
      end
    end
    local allScenes = loadAllScenes()
    TriggerClientEvent('v-scene:allScenesUpdated', -1, allScenes)
    return
  end

  if name == 'saveScene' then
    local scene = saveScene(owner, payload and payload.scene or {})
    TriggerClientEvent('v-scene:response', src, requestId, scene or {})
    if scene and scene.id then
      TriggerClientEvent('v-scene:sceneUpdated', -1, scene)
    end
    return
  end

  TriggerClientEvent('v-scene:response', src, requestId, {})
end)

local function handleImport(source, code)
  local allowed, message = canAccessEditor(source)
  if not allowed then
    TriggerClientEvent('v-scene:importFailed', source, message or 'Bu menuyu kullanmak icin yetkin yok.')
    return
  end
  if not code then
    TriggerClientEvent('v-scene:importFailed', source, 'Missing code')
    return
  end
  local row = dbQuery('SELECT scene_json, title, subtitle FROM v_scene WHERE code = ? LIMIT 1', { code })[1]
  if not row then
    TriggerClientEvent('v-scene:importFailed', source, 'Code not found')
    return
  end
  local owner = getIdentifier(source)
  if not owner then return end

  local scene = {}
  if row.scene_json and row.scene_json ~= '' then
    local ok, decoded = pcall(json.decode, row.scene_json)
    if ok and type(decoded) == 'table' then
      scene = decoded
    end
  end
  scene.id = newSceneId()
  scene.code = generateCode()
  scene.title = scene.title or row.title or 'Imported Scene'
  scene.subtitle = scene.subtitle or row.subtitle or ''

  local jsonData = json.encode(scene)
  local insertId = dbInsert(
    'INSERT INTO v_scene (owner, code, title, subtitle, scene_json, order_index) VALUES (?, ?, ?, ?, ?, ?)',
    { owner, scene.code, scene.title, scene.subtitle, jsonData, 9999 }
  )
  scene.dbId = insertId

  TriggerClientEvent('v-scene:imported', source, scene)
end

RegisterCommand('importscene', function(source, args)
  if source == 0 then return end
  local code = args and args[1]
  handleImport(source, code)
end, false)

RegisterNetEvent('v-scene:importScene', function(code)
  local src = source
  handleImport(src, code)
end)

local function toNumber(value, fallback)
  local num = tonumber(value)
  if num == nil then return fallback end
  return num
end

local function bridgeFramework()
  if BridgeServer and BridgeServer.GetFramework then
    return BridgeServer.GetFramework()
  end
  if BridgeResolveFramework then
    return BridgeResolveFramework()
  end
  return nil
end

local function triggerRuntimeAction(src, payload)
  if type(payload) ~= 'table' then return end
  local actionType = tostring(payload.actionType or '')
  if actionType == '' then return end
  local framework = bridgeFramework()
  local resultMeta = {
    actionType = actionType,
    nodeId = payload.nodeId
  }

  if actionType == 'item' then
    local itemName = BridgeTrim and BridgeTrim(payload.itemName) or tostring(payload.itemName or '')
    local itemCount = toNumber(payload.itemCount, 1)
    if itemName == '' or itemCount <= 0 then
      TriggerClientEvent('v-scene:runtimeActionResult', src, false, 'Add Item verisi gecersiz.', resultMeta)
      return
    end
    local ok, err = false, 'Bridge AddItem bulunamadi.'
    if BridgeServer and BridgeServer.AddItem then
      ok, err = BridgeServer.AddItem(src, itemName, itemCount)
    end
    if not ok then
      TriggerClientEvent('v-scene:runtimeActionResult', src, false, err or 'Add Item basarisiz.', resultMeta)
      return
    end

    TriggerClientEvent('v-scene:runtimeActionResult', src, true, ('Add Item: %s x%s'):format(itemName, itemCount), resultMeta)
    return
  end

  if actionType == 'weapon' then
    local weaponName = BridgeTrim and BridgeTrim(payload.weaponName) or tostring(payload.weaponName or '')
    local ammoCount = toNumber(payload.ammoCount, 0)
    if weaponName == '' then
      TriggerClientEvent('v-scene:runtimeActionResult', src, false, 'Add Weapon verisi gecersiz.', resultMeta)
      return
    end
    local ok, err = false, 'Bridge GiveWeapon bulunamadi.'
    if BridgeServer and BridgeServer.GiveWeapon then
      ok, err = BridgeServer.GiveWeapon(src, weaponName, ammoCount)
    end
    if not ok then
      TriggerClientEvent('v-scene:runtimeActionResult', src, false, err or 'Add Weapon basarisiz.', resultMeta)
      return
    end

    TriggerClientEvent('v-scene:runtimeActionResult', src, true, ('Add Weapon: %s (%s ammo)'):format(weaponName, ammoCount), resultMeta)
    return
  end

  if actionType == 'job' then
    local jobName = BridgeTrim and BridgeTrim(payload.jobName) or tostring(payload.jobName or '')
    local grade = toNumber(payload.grade, 0)
    if jobName == '' then
      TriggerClientEvent('v-scene:runtimeActionResult', src, false, 'Set Job verisi gecersiz.', resultMeta)
      return
    end
    local ok, err = false, 'Bridge SetJob bulunamadi.'
    if BridgeServer and BridgeServer.SetJob then
      ok, err = BridgeServer.SetJob(src, jobName, grade)
    end
    if not ok then
      TriggerClientEvent('v-scene:runtimeActionResult', src, false, err or 'Set Job basarisiz.', resultMeta)
      return
    end
    TriggerClientEvent('v-scene:runtimeActionResult', src, true, ('Set Job: %s grade %s'):format(jobName, grade), resultMeta)
    return
  end

  if actionType == 'notify' then
    local notifyTitle = tostring(payload.notifyTitle or '')
    local notifyDescription = tostring(payload.notifyDescription or '')
    local notifyType = tostring(payload.notifyType or 'info')
    local duration = toNumber(payload.duration, 3000)
    TriggerClientEvent('v-scene:runtimeNotify', src, {
      title = notifyTitle,
      description = notifyDescription,
      notifyType = notifyType,
      duration = duration
    })
    TriggerClientEvent('v-scene:runtimeActionResult', src, true, '', resultMeta)
    return
  end

  TriggerClientEvent('v-scene:runtimeActionResult', src, false, ('Desteklenmeyen action: %s'):format(actionType), resultMeta)
end

RegisterNetEvent('v-scene:runtimeAction', function(payload)
  local src = source
  if src == 0 then return end
  triggerRuntimeAction(src, payload)
end)
