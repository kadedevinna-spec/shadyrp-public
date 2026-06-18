-- RSG conversion note:
-- The escrowed Mosquito code still calls VORP-style APIs. Keep these flags on
-- the modern paths and satisfy the calls through the vorp_core/vorp_inventory
-- shim resources in _rsg_shims.
Config.UseLegacyGetItem = Config.UseLegacyGetItem or false -- true = getItemContainingMetadata | false = new getItem with callback (sync wrapped)
Config.UseLegacyMetadatUpdate = Config.UseLegacyMetadatUpdate or true -- true = subItem/addItem metadata updates | false = setItemMetadata in-place updates
