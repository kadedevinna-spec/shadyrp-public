BridgeRsgServer = BridgeRsgServer or {}

local function getCore()
  local ok, core = pcall(function()
    return exports['rsg-core']:GetCoreObject()
  end)
  if not ok or not core or not core.Functions then
    return nil
  end
  return core
end

local function getPlayer(src)
  local core = getCore()
  if not core then return nil end
  return core.Functions.GetPlayer(src)
end

function BridgeRsgServer.GetPermissionContext(src)
  local player = getPlayer(src)
  if not player or not player.PlayerData then
    return {}
  end

  local data = player.PlayerData
  local jobName = data.job and data.job.name or nil
  local groupName = data.group or data.permission or nil

  return {
    framework = 'rsg',
    job = jobName and tostring(jobName) or nil,
    group = groupName and tostring(groupName) or nil
  }
end

function BridgeRsgServer.GetCharacterIdentifier(src)
  local player = getPlayer(src)
  if not player or not player.PlayerData then
    return nil
  end

  local data = player.PlayerData
  local citizenId = data.citizenid or data.citizenId or data.cid or data.charid
  if citizenId and tostring(citizenId) ~= '' then
    return ('rsg:%s'):format(tostring(citizenId))
  end

  return nil
end

function BridgeRsgServer.HasGroupPermission(src, groupName)
  if not groupName or groupName == '' then
    return false
  end

  local context = BridgeRsgServer.GetPermissionContext(src)
  if context.group and context.group == groupName then
    return true
  end

  local core = getCore()
  if core and core.Functions and core.Functions.HasPermission then
    local ok, hasPermission = pcall(function()
      return core.Functions.HasPermission(src, groupName)
    end)
    if ok and hasPermission == true then
      return true
    end
  end

  return false
end

function BridgeRsgServer.AddItem(src, itemName, itemCount)
  local player = getPlayer(src)
  if not player or not player.Functions or not player.Functions.AddItem then
    return false, 'RSG player bulunamadi.'
  end

  local ok = pcall(function()
    player.Functions.AddItem(itemName, itemCount, false, false, 'v-scene')
  end)
  if ok then return true end
  return false, 'RSG AddItem cagrisinda hata olustu.'
end

function BridgeRsgServer.GiveWeapon(src, weaponName, ammoCount)
  local player = getPlayer(src)
  if not player or not player.Functions or not player.Functions.AddItem then
    return false, 'RSG player bulunamadi.'
  end

  local ok = pcall(function()
    player.Functions.AddItem(weaponName, 1, false, false, 'v-scene')
  end)
  if not ok then
    return false, 'RSG weapon AddItem cagrisinda hata olustu.'
  end

  return true
end

function BridgeRsgServer.SetJob(src, jobName, grade)
  local player = getPlayer(src)
  if not player or not player.Functions or not player.Functions.SetJob then
    return false, 'RSG player bulunamadi.'
  end

  local ok = pcall(function()
    player.Functions.SetJob(jobName, grade)
  end)
  if ok then return true end
  return false, 'RSG SetJob cagrisinda hata olustu.'
end
