BridgeClient = BridgeClient or {}
BridgeClient._loggedFramework = BridgeClient._loggedFramework or false

function BridgeClient.GetFramework()
  return BridgeResolveFramework()
end

function BridgeClient.Notify(message, duration, notifyType)
  local framework = BridgeClient.GetFramework()
  local ok = false

  if framework == 'vorp' and BridgeVorpClient and BridgeVorpClient.Notify then
    ok = BridgeVorpClient.Notify(message, duration, notifyType)
  elseif framework == 'rsg' and BridgeRsgClient and BridgeRsgClient.Notify then
    ok = BridgeRsgClient.Notify(message, duration, notifyType)
  elseif framework == 'custom' and BridgeCustomClient and BridgeCustomClient.Notify then
    ok = BridgeCustomClient.Notify(message, duration, notifyType)
  end

  if not ok then
  end

  return ok == true
end

CreateThread(function()
  Wait(1500)
  if BridgeClient._loggedFramework then return end
  BridgeClient._loggedFramework = true
  local fw = BridgeClient.GetFramework() or 'none'
  print(('[v-scene][bridge][client] framework: %s'):format(fw))
end)
