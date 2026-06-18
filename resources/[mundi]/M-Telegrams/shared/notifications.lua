-- ═══════════════════════════════════════════════════════════════
-- M-TELEGRAMS — CUSTOM NOTIFICATION BRIDGE
-- ═══════════════════════════════════════════════════════════════
--
-- This file lets you replace M-Telegrams' built-in
-- NUI notifications with any notification system you prefer
-- (ox_lib, rNotify, okokNotify, mythic_notify, etc.).
--
-- HOW IT WORKS
-- ─────────────
-- M-Telegrams calls these two functions whenever a notification
-- needs to be shown.  By default they return `nil`, which tells
-- the script to use its own NUI toast system.
--
-- To use YOUR OWN notification system, simply fill in the
-- function body and return `true`.  Returning `true` prevents
-- the built-in NUI notification from firing.
--
-- PARAMETERS
-- ──────────
--   text      (string)  — The notification message text.
--   duration  (number)  — Duration in milliseconds (default 4000).
--   notifType (string)  — One of: "info", "success", "warning", "error".
--
-- EXAMPLES (uncomment one block below or write your own)
-- ═══════════════════════════════════════════════════════════════

--- Client-side notification override.
--- Return `true` to suppress the built-in NUI notification.
--- @param text string
--- @param duration number
--- @param notifType string "info"|"success"|"warning"|"error"
--- @return boolean|nil
function Config.ClientNotify(text, duration, notifType)
    -- ── BUILT-IN (default) ──────────────────────────────────
    -- Return nil/false to use M-Telegrams' own NUI notifications.
    -- No changes needed if you like the built-in style.
    return nil

    -- ── ox_lib ──────────────────────────────────────────────
    -- lib.notify({
    --     title    = 'Telegram',
    --     description = text,
    --     type     = notifType,
    --     duration = duration,
    -- })
    -- return true

    -- ── rNotify ─────────────────────────────────────────────
    -- TriggerEvent('rNotify:NotifyLeft', text, notifType, duration)
    -- return true

    -- ── okokNotify ──────────────────────────────────────────
    -- exports['okokNotify']:Alert('Telegram', text, duration, notifType)
    -- return true

    -- ── RSG-Core (built-in) ─────────────────────────────────
    -- local RSGCore = exports['rsg-core']:GetCoreObject()
    -- TriggerEvent('RSGCore:Notify', text, notifType, duration)
    -- return true

    -- ── VORP (built-in) ─────────────────────────────────────
    -- TriggerEvent('vorp:TipRight', text, duration)
    -- return true
end

--- Server-side notification override.
--- Return `true` to suppress the built-in NUI notification.
--- @param source number  Player server ID
--- @param text string
--- @param duration number
--- @param notifType string "info"|"success"|"warning"|"error"
--- @return boolean|nil
function Config.ServerNotify(source, text, duration, notifType)
    -- ── BUILT-IN (default) ──────────────────────────────────
    -- Return nil/false to use M-Telegrams' own NUI notifications.
    return nil

    -- ── ox_lib (server-side) ────────────────────────────────
    -- TriggerClientEvent('ox_lib:notify', source, {
    --     title    = 'Telegram',
    --     description = text,
    --     type     = notifType,
    --     duration = duration,
    -- })
    -- return true

    -- ── RSG-Core (server-side) ──────────────────────────────
    -- TriggerClientEvent('RSGCore:Notify', source, text, notifType, duration)
    -- return true

    -- ── VORP (server-side) ──────────────────────────────────
    -- TriggerClientEvent('vorp:TipRight', source, text, duration)
    -- return true
end
