BridgeConfig = BridgeConfig or {}

-- Set to: 'auto' | 'vorp' | 'rsg' | 'custom'
BridgeConfig.framework = 'rsg'

-- Resource names for auto-detect.
BridgeConfig.resources = BridgeConfig.resources or {
  vorp = 'vorp_core',
  rsg = 'rsg-core'
}
