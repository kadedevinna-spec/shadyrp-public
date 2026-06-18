RegisterCommand('addxp', function(source, args, raw)
    local src = source
    local Character = FXGetPlayerData(src)
    local admin = Character.admin

    if admin then
        local playerId = tonumber(args[1])
        local xpToAdd = tonumber(args[2])

        if not playerId or not xpToAdd then
            Notify({
                source = src,
                text = Locale("invalid_params"), 
                type = "error",
                time = 5000,
            })
            return
        end

        exports['fx-hud']:addXP(playerId, xpToAdd)

        Notify({
            source = src,
            text = Locale("xp_added", { xp = xpToAdd, playerId = playerId }),
            type = "success",
            time = 4000,
        })

        Notify({
            source = playerId,
            text = Locale("xp_received", { xp = xpToAdd }),
            type = "info",
            time = 4000,
        })
    else
        Notify({
            source = src,
            text = Locale("no_permission"),
            type = "error",
            time = 4000,
        })
    end
end)


RegisterCommand('removexp', function(source, args, raw)
    local src = source
    local Character = FXGetPlayerData(src)
    local admin = Character.admin
    local playerId = tonumber(args[1])
    local xpToRemove = tonumber(args[2])

    if not playerId or not xpToRemove then
        Notify({
            source = src,
            text = Locale("invalid_params"), 
            type = "error",
            time = 5000,
        })
        return
    end
    if admin then
        Notify({
            source = src,
            text = Locale("xp_removed", { xp = xpToRemove, playerId = playerId }),
            type = "success",
            time = 4000,
        })
    
        Notify({
            source = playerId,
            text = Locale("xp_lost", { xp = xpToRemove }),
            type = "info",
            time = 4000,
        })
        exports['fx-hud']:removeXP(playerId, xpToRemove)
    else
        return Notify({
            source = src,
            text = Locale("no_permission"),
            type = "error",
            time = 4000,
        })
    end
    
end)

RegisterCommand('getxp', function(source, args, raw)
    local src = source
    local playerId = tonumber(args[1])

    if not playerId then
        Notify({
            source = src,
            text = Locale("invalid_params"),
            type = "error",
            time = 5000,
        })
        return
    end

    exports['fx-hud']:getXP(playerId, function(xp)
        Notify({
            source = src,
            text = Locale("current_xp", { xp = xp, playerId = playerId }),
            type = "info",
            time = 4000,
        })
    end)
end)

RegisterCommand('getlevel', function(source, args, raw)
    local src = source
    local playerId = tonumber(args[1])

    if not playerId then
        Notify({
            source = src,
            text = Locale("invalid_params"),
            type = "error",
            time = 5000,
        })
        return
    end

    exports['fx-hud']:getLevel(playerId, function(level)
        Notify({
            source = src,
            text = Locale("current_level", { level = level, playerId = playerId }),
            type = "info",
            time = 4000,
        })
    end)
end)

RegisterCommand(Config.HealAdminCommand,function(source,args,raw)
    local User = FXGetPlayerData(source)
    local admin = User.admin
    local target = args[1] and tonumber(args[1]) or source
    if admin then
        TriggerClientEvent("fx-hud:client:ForceHeal", target)
    else
        Notify({
            source = source,
            text = "You are not admin !",
            time = 4000,
            type = "error"
        })
    end
end)

local ExpSetting = Config.HudSettings.Level
if ExpSetting.useLevel and ExpSetting.autoExpLoop.enable then
    Citizen.CreateThread(function()
        while true do
            Citizen.Wait(ExpSetting.autoExpLoop.loopTime * 60 * 1000) 
            local players = GetPlayers()
    
            for _, playerId in ipairs(players) do
                local src = tonumber(playerId)
                addXP(src, ExpSetting.autoExpLoop.expValue)
            end
        end
    end)
end

RegisterNetEvent("fx-hud:server:GetDataDeveloper", function()
    local src = source 
    local Character = FXGetPlayerData(src)
    if not Character.admin then
        return Notify({ source = src, text = "You are not admin!", time = 4000, type = "error" })
    end
    GetHudData(src)
end)

local com1 = Config.CmdHudLoadAllPlayerCommand or "loadhud"
RegisterCommand(com1, function(source, args, raw)
    if source == 0 then
        for _, playerId in ipairs(GetPlayers()) do
            GetHudData(tonumber(playerId))
        end
        print("[fx-hud] All players triggered for HUD load.")
    else
        -- Oyuncuların kullanması engelleniyor
        TriggerClientEvent("chat:addMessage", source, {
            args = { "[System]", "You don't have permission to run this command." }
        })
    end
end)

function sendAnnouncement(text)
    for _, playerId in pairs(GetPlayers()) do
        TriggerClientEvent("fx-hud:client:showNotify", tonumber(playerId), text, 15000, "announce")
    end
end

RegisterCommand(Config.AnnounceCommand, function(src, args, raw)
    local text = table.concat(args, " ")

    if src == 0 then
        sendAnnouncement(text)
        return
    end

    local data = FXGetPlayerData(src)
    if data and data.admin then
        sendAnnouncement(text)
    else
        TriggerClientEvent("fx-hud:client:showNotify", src, "~o~You are not authorized to use this command!", 5000, "error")
    end
end, false)


