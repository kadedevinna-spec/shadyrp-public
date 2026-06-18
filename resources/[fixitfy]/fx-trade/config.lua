Config = {}
Config.Language = "en"
Config.Locale = {
  ["en"] = {
      ["cancarry"] = "One of you has no room for the items in this swap!",
      ["tradesuccess"] = "Successful trade!",
      ["notready"] = "You're not fit for trade!",
      ["playernotready"] = "The player is not suitable for trading!",
      ["notactive"] = "Player not active!",
      ["noid"] = "Invalid id!",
      ["playerquit"] = "The player you're trading with has left the game!",
      ["invalidAmount"] = "Entered Invalid Amount!",
  }
}

Config.OpenTradeCommand = "trade" --- or Config.OpenTradeCommand = false
Config.PlayerSelectionTime = 15 -- second
Config.PlayerSelectionDistance = 10 -- PLayer Selections Distance

local isServer = IsDuplicityVersion()

if isServer then
    Config.CanInteract = function(src,target,cb)
        -- Server Side
        local ped = GetPlayerPed(src)
        local ped2 = GetPlayerPed(target)
        local distance = #(GetEntityCoords(ped)-GetEntityCoords(ped2))
        local retval = false
        if distance < 5 then
            retval = true
        end
        cb(retval)
    end
end

function Notify(data)
    local text = data.text or "No message" 
    local time = data.time or 5000  
    local type = data.type or "info" 
    local dict = data.dict
    local icon = data.icon
    local color = data.color or 0
    local src = data.source
  
    if IsDuplicityVersion() then
        if Framework == "RSG" then
            text = string.gsub(text, "~.-~", "")
            TriggerClientEvent('ox_lib:notify', src, { title = text, type = type, duration = time })
        elseif Framework == "REDEMRP" then
            text = string.gsub(text, "~.-~", "")
            TriggerClientEvent("redem_roleplay:Tip", src, text, time)
        elseif Framework == "VORP" then
            if icon then
                TriggerClientEvent('vorp:ShowAdvancedRightNotification', src, text, dict, icon, color, time)
            else
                TriggerClientEvent("vorp:TipBottom",src, text, time, type)
            end
        end
    else
        if Framework == "RSG" then
            text = string.gsub(text, "~.-~", "")
            TriggerEvent('ox_lib:notify', { title = text, type = type, duration = time })
        elseif Framework == "REDEMRP" then
            text = string.gsub(text, "~.-~", "")
            TriggerEvent("redem_roleplay:Tip", text, time)
        elseif Framework == "VORP" then
            if icon then
                TriggerEvent("vorp:ShowAdvancedRightNotification", text, dict, icon, color, time)
            else
                TriggerEvent("vorp:TipBottom", text, time, type)
            end
        end
    end
  end
  
  function Locale(key, subs)
    local translate = Config.Locale[Config.Language][key] and Config.Locale[Config.Language][key] or "Config.Locale[" .. Config.Language .. "][" .. key .. "] doesn't exist"
    subs = subs and subs or {}
    for k, v in pairs(subs) do
        local templateToFind = '%${' .. k .. '}'
        local safeValue = tostring(v):gsub("%%", "%%%%")
        translate = translate:gsub(templateToFind, safeValue)
    end
    translate = tostring(translate):gsub("%%%%", "%%")
    return tostring(translate)
  end

