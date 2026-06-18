Config = {}
Config.Framework = nil
Config.ClothingMenu = nil

Config.Notify = {
    rsg = function(src, message, duration, notifyType)
        if src then
            local type = notifyType or 'inform'
            TriggerClientEvent('ox_lib:notify', src, {
                title = message,
                type = type,
                duration = duration or 5000
            })
        else
           dprint("^3[v-bridge]^7 " .. message)
        end
    end,
    vorp = function(src, message, duration)
        if src then
            TriggerClientEvent("vorp:TipBottom", src, message, duration or 5000)
        else
           dprint("^3[v-bridge]^7 " .. message)
        end
    end
}

