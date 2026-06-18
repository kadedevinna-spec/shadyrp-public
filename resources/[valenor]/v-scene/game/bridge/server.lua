BridgeServer = BridgeServer or {}
BridgeServer._loggedFramework = BridgeServer._loggedFramework or false

function BridgeServer.GetFramework()
  return BridgeResolveFramework()
end

function BridgeServer.AddItem(src, itemName, itemCount)
  local framework = BridgeServer.GetFramework()
  if framework == 'vorp' then
    return BridgeVorpServer.AddItem(src, itemName, itemCount)
  end
  if framework == 'rsg' then
    return BridgeRsgServer.AddItem(src, itemName, itemCount)
  end
  if framework == 'custom' and BridgeCustomServer and BridgeCustomServer.AddItem then
    return BridgeCustomServer.AddItem(src, itemName, itemCount)
  end
  return false, 'Desteklenen framework bulunamadi.'
end

function BridgeServer.GiveWeapon(src, weaponName, ammoCount)
  local framework = BridgeServer.GetFramework()
  if framework == 'vorp' then
    return BridgeVorpServer.GiveWeapon(src, weaponName, ammoCount)
  end
  if framework == 'rsg' then
    return BridgeRsgServer.GiveWeapon(src, weaponName, ammoCount)
  end
  if framework == 'custom' and BridgeCustomServer and BridgeCustomServer.GiveWeapon then
    return BridgeCustomServer.GiveWeapon(src, weaponName, ammoCount)
  end
  return false, 'Desteklenen framework bulunamadi.'
end

function BridgeServer.SetJob(src, jobName, grade)
  local framework = BridgeServer.GetFramework()
  if framework == 'vorp' then
    return BridgeVorpServer.SetJob(src, jobName, grade)
  end
  if framework == 'rsg' then
    return BridgeRsgServer.SetJob(src, jobName, grade)
  end
  if framework == 'custom' and BridgeCustomServer and BridgeCustomServer.SetJob then
    return BridgeCustomServer.SetJob(src, jobName, grade)
  end
  return false, 'Desteklenen framework bulunamadi.'
end

function BridgeServer.GetPermissionContext(src)
  local framework = BridgeServer.GetFramework()
  if framework == 'vorp' and BridgeVorpServer and BridgeVorpServer.GetPermissionContext then
    return BridgeVorpServer.GetPermissionContext(src)
  end
  if framework == 'rsg' and BridgeRsgServer and BridgeRsgServer.GetPermissionContext then
    return BridgeRsgServer.GetPermissionContext(src)
  end
  if framework == 'custom' and BridgeCustomServer and BridgeCustomServer.GetPermissionContext then
    return BridgeCustomServer.GetPermissionContext(src)
  end
  return {}
end

function BridgeServer.GetCharacterIdentifier(src)
  local framework = BridgeServer.GetFramework()
  if framework == 'vorp' and BridgeVorpServer and BridgeVorpServer.GetCharacterIdentifier then
    return BridgeVorpServer.GetCharacterIdentifier(src)
  end
  if framework == 'rsg' and BridgeRsgServer and BridgeRsgServer.GetCharacterIdentifier then
    return BridgeRsgServer.GetCharacterIdentifier(src)
  end
  if framework == 'custom' and BridgeCustomServer and BridgeCustomServer.GetCharacterIdentifier then
    return BridgeCustomServer.GetCharacterIdentifier(src)
  end
  return nil
end

function BridgeServer.HasGroupPermission(src, groupName)
  local framework = BridgeServer.GetFramework()
  if framework == 'vorp' and BridgeVorpServer and BridgeVorpServer.HasGroupPermission then
    return BridgeVorpServer.HasGroupPermission(src, groupName)
  end
  if framework == 'rsg' and BridgeRsgServer and BridgeRsgServer.HasGroupPermission then
    return BridgeRsgServer.HasGroupPermission(src, groupName)
  end
  if framework == 'custom' and BridgeCustomServer and BridgeCustomServer.HasGroupPermission then
    return BridgeCustomServer.HasGroupPermission(src, groupName)
  end
  return false
end

CreateThread(function()
  Wait(1000)
  if BridgeServer._loggedFramework then return end
  BridgeServer._loggedFramework = true
  local fw = BridgeServer.GetFramework() or 'none'
  print(('[v-scene][bridge][server] framework: %s'):format(fw))
end)
