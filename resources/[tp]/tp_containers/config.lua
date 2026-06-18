
Config = {}

Config.DevMode = false
Config.Debug   = false

--[[ ------------------------------------------------
  Discord API Configurations
]]---------------------------------------------------

-- The specified discord roles will be able to execute the Config.Commands.
Config.PermittedDiscordRoles  = { 111111111111111111, 222222222222222222 }

-- The following groups will be able to execute the Config.Commands.
Config.AllowlistedGroups = { 'admin' }

--[[-------------------------------------------------------
 General
]]---------------------------------------------------------

-- You are allowed to edit the specified event since we provide it public, mostly for safety reasons
Config.OpenCustomContainerByIdEventName = 'tp_containers:client:openInventoryContainerById'

-- Notification colors based on the notify type.
-- (!) The specified option is functional only for tp_containers notification event call.
Config.NotificationColors = {
    ['error']   = "rgba(182, 45, 45, 0.89)",
    ['success'] = "rgba(0, 255, 0, 0.79)",
    ['info']    = "rgba(102, 178, 255, 0.79)"
}

-- Inventory path is required for loading item images directly from your inventory and not from our script.
-- TPZ-CORE : tpz_inventory/html/img/items/
-- VORP: vorp_inventory/html/img/items/
-- RSG: rsg-inventory/html/images/

-- (!) OX Inventory will never work, they using web connections and blocking our connection.
-- you must create a new extra "script" with the images inside to load them properly.

Config.InventoryImgPath = "v-inventory/web/dist/items/"

-- Items that will be prevented (blocked) to be placed on any storages.
Config.BlacklistedItems = {
    'cash',
    'money',
}

-- In case you want to modify items weight for the specified script,
-- you can add the items and their weight below, as the following example.
-- (!) This will override the default weight of the placed item.
Config.WeightItems = {
    ['consumable_water_bottle'] = 0.5,
}

-- This is mostly for frameworks or server who dont use double values for grammars.
-- (!) RSG should be true, RSG is not using double values (0.1).
Config.WeightConvertMultiply = false

--[[-------------------------------------------------------
 Notifications
]]---------------------------------------------------------

-- @param source : is always null when called from client.
-- @param type : returns "success" or "error" depends when and where the message is sent.
function SendNotification(source, message, type)

    if not source then -- client side
        TriggerEvent('tp_containers:client:sendNotification', message, type)
        
    else -- server side
        TriggerClientEvent('tp_containers:client:sendNotification', source, message, type)
    end
  
end

--[[ ------------------------------------------------
  Commands
]]---------------------------------------------------

Config.Commands = {

    ['OPEN_CONTAINER'] = { 
        
        Command    = 'opencontainer',
        Suggestion = "Perform this command to open a container by its Id.",
    
        Webhook = { -- (!) Checkout tp_libs/server/webhooks.lua to modify the webhook urls.
          Enabled = false, 
          Color = 10038562,
        },
    
    },
  
}