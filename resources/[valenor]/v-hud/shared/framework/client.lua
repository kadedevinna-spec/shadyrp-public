-- Framework Bridge - Client Side
-- Supports both VORPCore and RSGCore frameworks

FrameworkClient = {}
FrameworkClient.Core = nil

local isVorp = Config.Framework == "vorp"
local isRsg = Config.Framework == "rsg"

-- Initialize Core (Client)
if isRsg then
    CreateThread(function()
        FrameworkClient.Core = exports['rsg-core']:GetCoreObject()
    end)
end

-- ==================== NOTIFICATION FUNCTIONS ====================

---Send notification to player
---@param message string Notification message
---@param duration number Duration in milliseconds
---@param type? string Notification type (info, success, error)
function FrameworkClient.Notify(message, duration, type)
    type = type or "info"
    duration = duration or 3000

    if isVorp then
        -- VORP notification
        TriggerEvent("vorp:TipBottom", message, duration)
    elseif isRsg then
        -- RSG uses ox_lib or custom notification
        -- Try ox_lib first, fallback to native
        local success = pcall(function()
            exports.ox_lib:notify({
                title = 'HUD',
                description = message,
                type = type,
                duration = duration
            })
        end)

        if not success then
            -- Fallback: Try RSGCore notification if available
            if FrameworkClient.Core and FrameworkClient.Core.Functions and FrameworkClient.Core.Functions.Notify then
                FrameworkClient.Core.Functions.Notify(message, type, duration)
            else
                -- Ultimate fallback: simple text display
                SetTextEntry_2("STRING")
                AddTextComponentString(message)
                DrawSubtitleTimed(duration, true)
            end
        end
    end
end

-- ==================== EVENT NAMES ====================

-- Player respawn event name based on framework
FrameworkClient.Events = {
    -- RSG respawn is handled separately via hospital/ambulancejob events; do NOT reuse the login event here
    PlayerRespawn = isVorp and "vorp_core:Client:OnPlayerRespawn" or nil,
    PlayerLoaded = isVorp and "vorp:SelectedCharacter" or "RSGCore:Client:OnPlayerLoaded",
    PlayerUnloaded = isVorp and "vorp:playerDisconnected" or "RSGCore:Client:OnPlayerUnload"
}

-- Metabolism event (VORP specific, RSG may not have this)
FrameworkClient.Events.MetabolismChange = isVorp and "vorpmetabolism:changeValue" or "rsg-hud:client:UpdateNeeds"

-- ==================== PLAYER DATA FUNCTIONS ====================

---Get player data (RSG specific, VORP uses server callbacks)
---@return table|nil Player data
function FrameworkClient.GetPlayerData()
    if isRsg and FrameworkClient.Core then
        return FrameworkClient.Core.Functions.GetPlayerData()
    end
    return nil
end

---Check if player is loaded
---@return boolean
function FrameworkClient.IsPlayerLoaded()
    if isVorp then
        -- VORP uses state bag or custom check
        return LocalPlayer.state.IsInSession or false
    elseif isRsg and FrameworkClient.Core then
        local playerData = FrameworkClient.Core.Functions.GetPlayerData()
        return playerData and playerData.citizenid ~= nil
    end
    return false
end

-- ==================== CHARACTER FUNCTIONS ====================

---Execute character reload command
function FrameworkClient.ReloadCharacter()
    local cmd = Config.ReloadCharacterCommand or "rc"
    ExecuteCommand(cmd)
end

-- ==================== UTILITY FUNCTIONS ====================

---Get framework type
---@return string "vorp" or "rsg"
function FrameworkClient.GetFrameworkType()
    return Config.Framework
end

---Check if using VORP
---@return boolean
function FrameworkClient.IsVorp()
    return isVorp
end

---Check if using RSG
---@return boolean
function FrameworkClient.IsRsg()
    return isRsg
end

print("^3[v-hud]^7 Client Framework Bridge loaded - Mode: " .. (isVorp and "VORP" or (isRsg and "RSG" or "UNKNOWN")))
