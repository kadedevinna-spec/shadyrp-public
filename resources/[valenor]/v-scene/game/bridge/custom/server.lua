BridgeCustomServer = BridgeCustomServer or {}

-- Custom framework adapter.
-- Return: true on success
-- Return: false, "reason" on failure

function BridgeCustomServer.AddItem(src, itemName, itemCount)
  return false, 'Custom AddItem implement edilmedi.'
end

function BridgeCustomServer.GiveWeapon(src, weaponName, ammoCount)
  return false, 'Custom GiveWeapon implement edilmedi.'
end

function BridgeCustomServer.SetJob(src, jobName, grade)
  return false, 'Custom SetJob implement edilmedi.'
end

function BridgeCustomServer.GetPermissionContext(src)
  return {}
end

function BridgeCustomServer.HasGroupPermission(src, groupName)
  return false
end
