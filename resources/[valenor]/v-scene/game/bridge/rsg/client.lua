BridgeRsgClient = BridgeRsgClient or {}

function BridgeRsgClient.Notify(message, duration, notifyType)
  local isTable = type(message) == 'table'
  local title = isTable and tostring(message.title or '') or ''
  local desc = isTable and tostring(message.description or '') or ''
  local lowerTitle = title:lower()
  if lowerTitle == 'v-scene' or lowerTitle == 'maybe next time' or lowerTitle == 'maybe later' then
    title = ''
  end
  local msg = isTable and ((desc ~= '' and desc) or title) or tostring(message or '')
  local time = tonumber(duration) or 3000
  local nType = tostring(notifyType or 'primary')
  local oxType = nType == 'primary' and 'info' or nType
  local function fallbackTitle()
    if nType == 'success' then return 'Success' end
    if nType == 'error' then return 'Error' end
    return 'Notice'
  end

  if GetResourceState and GetResourceState('sirevlc_notifications') == 'started' then
    local ok = pcall(function()
      if isTable then
        local topTitle = title ~= '' and title or fallbackTitle()
        local topDesc = desc ~= '' and desc or msg
        exports['sirevlc_notifications']:ShowTopNotification(topTitle, topDesc, time)
      else
        local topTitle = fallbackTitle()
        exports['sirevlc_notifications']:ShowTopNotification(topTitle, msg, time)
      end
    end)
    if ok then return true end
  end

  if GetResourceState and GetResourceState('ox_lib') == 'started' then
    local ok = pcall(function()
      TriggerEvent('ox_lib:notify', {
        title = isTable and ((title ~= '' and title) or fallbackTitle()) or fallbackTitle(),
        description = msg,
        type = oxType,
        duration = time
      })
    end)
    if ok then return true end
  end

  local ok = pcall(function()
    TriggerEvent('RSGCore:Notify', msg, nType, time)
  end)
  return ok == true
end
