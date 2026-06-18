BridgeVorpServer = BridgeVorpServer or {}

local function getCore()
  local ok, core = pcall(function()
    return exports.vorp_core:GetCore()
  end)
  if not ok or not core then
    return nil
  end
  return core
end

local function getUser(src)
  local core = getCore()
  if not core or not core.getUser then
    return nil
  end
  return core.getUser(src)
end

local function getCharacter(src)
  local user = getUser(src)
  if not user or not user.getUsedCharacter then
    return nil
  end
  local ok, character = pcall(function()
    return user.getUsedCharacter
  end)
  if ok and type(character) == 'table' then
    return character
  end

  ok, character = pcall(function()
    return user.getUsedCharacter()
  end)
  if ok and type(character) == 'table' then
    return character
  end

  return nil
end

function BridgeVorpServer.GetPermissionContext(src)
  local user = getUser(src)
  local character = getCharacter(src)

  local jobName = nil
  if character then
    jobName = character.job or character.jobLabel or character.jobName
  end

  local groupName = nil
  if user then
    if user.getGroup then
      local ok, result = pcall(function()
        return user.getGroup()
      end)
      if ok and result then
        groupName = result
      end
    end
    if not groupName then
      groupName = user.group
    end
  end
  if not groupName and character then
    groupName = character.group
  end

  return {
    framework = 'vorp',
    job = jobName and tostring(jobName) or nil,
    group = groupName and tostring(groupName) or nil
  }
end

function BridgeVorpServer.HasGroupPermission(src, groupName)
  if not groupName or groupName == '' then
    return false
  end

  local context = BridgeVorpServer.GetPermissionContext(src)
  return context.group == groupName
end

function BridgeVorpServer.AddItem(src, itemName, itemCount)
  local ok = pcall(function()
    exports.vorp_inventory:addItem(src, itemName, itemCount)
  end)
  if ok then return true end

  ok = pcall(function()
    exports.vorp_inventory:AddItem(src, itemName, itemCount)
  end)
  if ok then return true end

  return false, 'VORP addItem export cagirilamadi.'
end

function BridgeVorpServer.GiveWeapon(src, weaponName, ammoCount)
  local ok = pcall(function()
    exports.vorp_inventory:giveWeapon(src, weaponName)
  end)
  if not ok then
    ok = pcall(function()
      exports.vorp_inventory:GiveWeapon(src, weaponName)
    end)
  end
  if not ok then
    return false, 'VORP giveWeapon export cagirilamadi.'
  end

  local ammo = tonumber(ammoCount) or 0
  if ammo > 0 then
    local bulletOk = pcall(function()
      exports.vorp_inventory:addBullets(src, weaponName, ammo)
    end)
    if not bulletOk then
      bulletOk = pcall(function()
        exports.vorp_inventory:AddBullets(src, weaponName, ammo)
      end)
    end
    if not bulletOk then
      return false, 'VORP addBullets export cagirilamadi.'
    end
  end

  return true
end

function BridgeVorpServer.SetJob(src, jobName, grade)
  local core = getCore()
  if core and core.getUser then
    local ch = getCharacter(src)
    if ch and ch.setJob then
      local callOk = pcall(function()
        ch.setJob(jobName, true)
      end)
      if callOk then
        local g = tonumber(grade)
        if g and ch.setJobGrade then
          pcall(function()
            ch.setJobGrade(g, true)
          end)
        end
        return true
      end
    end
  end

  local fallbackOk = pcall(function()
    exports.vorp_core:setJob(src, jobName, grade)
  end)
  if fallbackOk then return true end

  fallbackOk = pcall(function()
    exports.vorp_core:SetJob(src, jobName, grade)
  end)
  if fallbackOk then return true end

  return false, 'VORP setJob cagrisi basarisiz.'
end
