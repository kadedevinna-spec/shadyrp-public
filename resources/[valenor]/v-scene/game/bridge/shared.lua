Bridge = Bridge or {}

function BridgeResolveFramework()
  local forced = BridgeConfig and BridgeConfig.framework or 'auto'
  if forced and forced ~= '' and forced ~= 'auto' then
    return forced
  end

  local vorpRes = (BridgeConfig and BridgeConfig.resources and BridgeConfig.resources.vorp) or 'vorp_core'
  local rsgRes = (BridgeConfig and BridgeConfig.resources and BridgeConfig.resources.rsg) or 'rsg-core'

  if GetResourceState(vorpRes) == 'started' then
    return 'vorp'
  end
  if GetResourceState(rsgRes) == 'started' then
    return 'rsg'
  end
  return 'custom'
end

function BridgeTrim(value)
  if value == nil then return '' end
  return tostring(value):gsub('^%s+', ''):gsub('%s+$', '')
end
