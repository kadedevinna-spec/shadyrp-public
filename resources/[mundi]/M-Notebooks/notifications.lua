-- =====================================================
-- M-NOTEBOOKS CUSTOM NOTIFICATIONS
-- =====================================================
-- Edit this file to use your own notification system.
-- This file is NOT encrypted — you can freely modify it.
--
-- Two functions are provided:
--   ClientNotify(text, duration)          — called on the CLIENT side
--   ServerNotify(source, text, duration)  — called on the SERVER side
--
-- Parameters:
--   text     (string) — The notification message (already translated via locale)
--   duration (number) — Duration in milliseconds (default: 4000)
--   source   (number) — The player server ID (server-side only)
--
-- Replace the contents of each function with your preferred
-- notification export, event, or system. Examples are included below.
-- =====================================================

-- =====================================================
-- CLIENT-SIDE NOTIFICATION
-- =====================================================
-- Called from the client whenever a notification needs to be shown.
--
-- Examples you can swap in:
--   exports['mythic_notify']:SendAlert('inform', text, duration)
--   TriggerEvent('ox_lib:notify', { title = 'Notebook', description = text, duration = duration })
--   exports['pNotify']:SendNotification({ text = text, type = 'info', timeout = duration })
--   exports['okokNotify']:Alert('Notebook', text, duration, 'info')

function ClientNotify(text, duration)
    duration = duration or 4000

    -- DEFAULT: Uses framework-native notifications
    -- RSG: RSGCore:Notify  |  VORP: NotifyRightTip + TipBottom
    local fw = Config.Core.framework or "VORP"

    if fw == "RSG" then
        TriggerEvent('RSGCore:Notify', text, 'primary', duration)
    else
        local Core = exports.vorp_core:GetCore()
        Core.NotifyRightTip(text, duration)
        TriggerEvent("vorp:TipBottom", text, duration)
    end
end

-- =====================================================
-- SERVER-SIDE NOTIFICATION
-- =====================================================
-- Called from the server to send a notification to a specific player.
--
-- Examples you can swap in:
--   TriggerClientEvent('ox_lib:notify', source, { title = 'Notebook', description = text, duration = duration })
--   TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = text, length = duration })
--   TriggerClientEvent('okokNotify:Alert', source, 'Notebook', text, duration, 'info')

function ServerNotify(source, text, duration)
    duration = duration or 4000

    -- DEFAULT: Uses framework-native notifications
    -- RSG: RSGCore:Notify  |  VORP: NotifyRightTip
    local fw = Config.Core.framework or "VORP"

    if fw == "RSG" then
        TriggerClientEvent('RSGCore:Notify', source, text, 'primary', duration)
    else
        local Core = exports.vorp_core:GetCore()
        Core.NotifyRightTip(source, text, duration)
    end
end
