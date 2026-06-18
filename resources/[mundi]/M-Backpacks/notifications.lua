-- =====================================================
-- M-BACKPACKS CUSTOM NOTIFICATIONS
-- =====================================================
-- Edit this file to use your own notification system.
-- This file is NOT encrypted — you can freely modify it.
--
-- Three functions are provided:
--   ClientNotify(message, duration, notifyType)          — called on the CLIENT side
--   ServerNotify(source, message, duration, notifyType)  — called on the SERVER side
--   ClientLongNotify(message, durationMs, notifyType)    — called on CLIENT for long (30s) warnings
--
-- Parameters:
--   message    (string) — The notification message (already translated via locale)
--   duration   (number) — Duration in milliseconds (default: 4000)
--   durationMs (number) — Duration in milliseconds for long notifications (default: 30000)
--   notifyType (string) — 'success', 'error', 'warning', or 'info' (default: 'success')
--   source     (number) — The player server ID (server-side only)
--
-- Replace the contents of each function with your preferred
-- notification export, event, or system. Examples are included below.
-- =====================================================

-- =====================================================
-- CLIENT-SIDE NOTIFICATION
-- =====================================================
-- Called from the client for standard notifications (4 second default).
--
-- Examples you can swap in:
--   exports['mythic_notify']:SendAlert(notifyType, message, duration)
--   TriggerEvent('ox_lib:notify', { title = 'Backpack', description = message, type = notifyType, duration = duration })
--   exports['pNotify']:SendNotification({ text = message, type = notifyType, timeout = duration })
--   exports['okokNotify']:Alert('Backpack', message, duration, notifyType)

function ClientNotify(message, duration, notifyType)
    duration = duration or 4000
    notifyType = notifyType or 'success'

    -- DEFAULT: Uses framework-native notifications
    -- VORP: NotifyLeft  |  RSG: ox_lib:notify
    local Bridge = Bridge

    if Bridge.IsVORP() then
        local VORPcore = exports.vorp_core:GetCore()
        if VORPcore then
            VORPcore.NotifyLeft('Backpack', message, 'generic_textures', 'satchel_01', duration)
        end
    elseif Bridge.IsRSG() then
        TriggerEvent('ox_lib:notify', {
            title = 'Backpack',
            description = message,
            type = notifyType,
            duration = duration
        })
    end
end

-- =====================================================
-- SERVER-SIDE NOTIFICATION
-- =====================================================
-- Called from the server to send a notification to a specific player.
--
-- Examples you can swap in:
--   TriggerClientEvent('ox_lib:notify', source, { title = 'Backpack', description = message, type = notifyType, duration = duration })
--   TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = notifyType, text = message, length = duration })
--   TriggerClientEvent('okokNotify:Alert', source, 'Backpack', message, duration, notifyType)

function ServerNotify(source, message, duration, notifyType)
    duration = duration or 4000
    notifyType = notifyType or 'success'

    -- DEFAULT: Uses framework-native notifications
    -- VORP: vorp:NotifyLeft  |  RSG: ox_lib:notify
    local Bridge = Bridge

    if Bridge.IsVORP() then
        TriggerClientEvent('vorp:NotifyLeft', source, 'Backpack', message, 'generic_textures', 'satchel_01', duration, notifyType)
    elseif Bridge.IsRSG() then
        TriggerClientEvent('ox_lib:notify', source, {
            title = 'Backpack',
            description = message,
            type = notifyType,
            duration = duration
        })
    end
end

-- =====================================================
-- CLIENT-SIDE LONG NOTIFICATION
-- =====================================================
-- Called for extended-duration warnings (e.g. 30-second excess backpack warnings).
-- Some notification systems don't support long durations — the fallback at the
-- bottom repeats a short notification every 5 seconds as a last resort.
--
-- If your notification system supports custom durations, just call it directly
-- and return. Otherwise the fallback loop at the bottom will handle it.

function ClientLongNotify(message, durationMs, notifyType)
    durationMs = durationMs or 30000
    notifyType = notifyType or 'warning'

    -- Method 1: ox_lib (supports long durations natively)
    if GetResourceState('ox_lib') == 'started' then
        exports.ox_lib:notify({
            title = _U('longNotifyTitle'),
            description = message,
            type = notifyType,
            duration = durationMs
        })
        return
    end

    -- Method 2: vorp_notify
    if GetResourceState('vorp_notify') == 'started' then
        TriggerEvent('vorp:NotifyRight', message, 'inventory', durationMs)
        return
    end

    -- Method 3: VORP core tip
    if GetResourceState('vorp_core') == 'started' then
        TriggerEvent('vorp:TipBottom', message, durationMs)
        return
    end

    -- Method 4: Fallback — repeat short notification every 5 seconds
    local intervals = math.ceil(durationMs / 5000)
    CreateThread(function()
        for i = 1, intervals do
            ClientNotify(message, 5000, notifyType)
            Wait(5000)
        end
    end)
end
