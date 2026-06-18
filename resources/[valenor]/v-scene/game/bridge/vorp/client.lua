BridgeVorpClient = BridgeVorpClient or {}

function BridgeVorpClient.Notify(message, duration, notifyType)
  local msg = tostring(message or '')
  local time = tonumber(duration) or 3000
  local ok = pcall(function()
    TriggerEvent('vorp:TipRight', msg, time)
  end)
  if ok then return true end

  ok = pcall(function()
    TriggerEvent('vorp:ShowTopNotification', msg, notifyType or 'info')
  end)
  return ok == true
end
