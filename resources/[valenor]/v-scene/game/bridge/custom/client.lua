BridgeCustomClient = BridgeCustomClient or {}

-- Custom client notify adapter.
-- Return true if shown, otherwise false.

function BridgeCustomClient.Notify(message, duration, notifyType)
  return false
end
