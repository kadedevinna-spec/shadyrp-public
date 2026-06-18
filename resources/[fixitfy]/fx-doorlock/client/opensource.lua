-- ─── FX-Doorlock: Open-Source Minigame Integration ───────────────────────────
-- This file is intentionally separate so you can swap or customise the
-- minigame without touching the core lockpick logic.
--
-- The function StartLockpickMinigame(lp) is called by StartLockpick() in
-- client/functions.lua when Config.Settings.Lockpick.minigame == true.
--
-- It receives the full Lockpick config table and must RETURN:
--   true  — pick succeeded
--   false — pick failed / cancelled
--
-- ─────────────────────────────────────────────────────────────────────────────

-- ─── StartLockpickMinigame ────────────────────────────────────────────────────

function StartLockpickMinigame(lp)
    local result = exports['lockpick']:startLockpick()
    return result
end
