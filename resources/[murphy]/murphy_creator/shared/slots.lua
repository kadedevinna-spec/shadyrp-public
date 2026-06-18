-- Slots configuration is now in config.lua
-- This file maintains compatibility with existing code

Slots = Config.Slots or {
    default = 3,
    role = {
        superadmin = 5,
        admin = 5,
    },
    identifier = {}
}

PedPermission = Config.PedPermission or {
    default = true,
    role = {
        superadmin = true,
        admin = true,
    },
    identifier = {}
}