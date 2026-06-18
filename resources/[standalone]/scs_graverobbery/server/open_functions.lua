-- ========================================
-- GRAVE ROBBERY LAWMAN ALERTS
-- ========================================
-- Handles lawman alert functionality including:
-- - Alert chance and cooldown system
-- - Dynamic location detection
-- - Alert distribution to lawmen

local RSG = exports['rsg-core']:GetCoreObject()
local config = Config

local lastAlertTime = 0

---Get location name based on coordinates
---@param coords vector3 The coordinates to get location name for
---@return string locationName The name of the location
local function GetLocationName(coords)
    -- Check if the coordinates are near any grave (which indicates cemetery area)
    for _, grave in pairs(config.Graves) do
        local distance = #(vector3(coords.x, coords.y, coords.z) - vector3(grave.coords.x, grave.coords.y, grave.coords.z))
        if distance <= 50.0 then -- Within 50 units of any grave
            return "Cemetery Area"
        end
    end
    
    local x, y = coords.x, coords.y
    
    -- Basic area detection based on coordinates (Red Dead Redemption 2 map areas)
    if x >= -2000 and x <= -1000 and y >= -1000 and y <= 0 then
        return "Saint Denis Area"
    elseif x >= -1000 and x <= 0 and y >= -1000 and y <= 0 then
        return "Rhodes Area"
    elseif x >= 0 and x <= 1000 and y >= -1000 and y <= 0 then
        return "Valentine Area"
    elseif x >= -1000 and x <= 0 and y >= 0 and y <= 1000 then
        return "Strawberry Area"
    elseif x >= 0 and x <= 1000 and y >= 0 and y <= 1000 then
        return "Blackwater Area"
    else
        return "Unknown Area"
    end
end

---Send alert to all online lawmen
---@param message string Alert message to send
---@param coords vector3 Coordinates where the crime occurred
---@param crimeType string Type of crime (for tracking)
local function SendLawmanAlert(message, coords, crimeType)
    local lawmenCount = 0
    local players = RSG.Functions.GetRSGPlayers()
    
    if players then
        for _, player in pairs(players) do
            if player and player.PlayerData and player.PlayerData.job and player.PlayerData.job.type == config.lawmen.jobType then
                -- Send alert to lawman
                TriggerClientEvent('scs_graverobbery:lawmanAlert', player.PlayerData.source, {
                    message = message,
                    coords = coords,
                    crimeType = crimeType,
                    time = os.date('%H:%M:%S')
                })
                
                lawmenCount = lawmenCount + 1
            end
        end
    end
    
    if config.debug then
        print("^3[DEBUG] Sent grave robbery alert to " .. lawmenCount .. " lawmen^7")
    end
    
    return lawmenCount
end

---Check if grave robbery should trigger lawman alert
---@param coords vector3 Coordinates of the grave
---@return boolean shouldAlert Whether an alert should be sent
local function ShouldTriggerLawmanAlert(coords)
    -- Check if alerts are enabled
    if not config.lawmanAlerts.enabled then
        return false
    end
    
    -- Check cooldown
    local currentTime = os.time()
    if currentTime - lastAlertTime < config.lawmanAlerts.alertCooldown then
        if config.debug then
            local timeRemaining = config.lawmanAlerts.alertCooldown - (currentTime - lastAlertTime)
            print("^3[DEBUG] Lawman alert on cooldown for " .. timeRemaining .. " more seconds^7")
        end
        return false
    end
    
    -- Check if there are any lawmen online
    local lawmenCount = 0
    local players = RSG.Functions.GetRSGPlayers()
    if players then
        for _, player in pairs(players) do
            if player and player.PlayerData and player.PlayerData.job and player.PlayerData.job.type == config.lawmen.jobType then
                lawmenCount = lawmenCount + 1
            end
        end
    end
    
    if lawmenCount == 0 then
        if config.debug then
            print("^3[DEBUG] No lawmen online, skipping alert^7")
        end
        return false
    end
    
    -- Roll for chance
    local roll = math.random(1, 100)
    local shouldAlert = roll <= config.lawmanAlerts.chance
    
    if config.debug then
        print("^3[DEBUG] Lawman alert roll: " .. roll .. "/100 (chance: " .. config.lawmanAlerts.chance .. "%) - " .. (shouldAlert and "ALERT" or "NO ALERT") .. "^7")
    end
    
    return shouldAlert
end

---Trigger lawman alert for grave robbery
---@param coords vector3 Coordinates of the robbed grave
---@param playerName string Name of the player who robbed the grave
function TriggerGraveRobberyAlert(coords, playerName)
    if not ShouldTriggerLawmanAlert(coords) then
        return
    end
    
    -- Update last alert time
    lastAlertTime = os.time()
    
    -- Get location name based on coordinates
    local locationName = GetLocationName(coords)
    
    -- Create alert message with dynamic location
    local alertMessage = locale('lawman_alert.grave_robbery_reported') .. " " .. string.format(locale('lawman_alert.grave_robbery_location'), locationName)
    
    -- Send alert to all lawmen
    local lawmenNotified = SendLawmanAlert(alertMessage, coords, "grave_robbery")
    
    if lawmenNotified > 0 then
        if config.debug then
            print("^1[DEBUG] Grave robbery alert sent to " .. lawmenNotified .. " lawmen at " .. coords.x .. ", " .. coords.y .. ", " .. coords.z .. "^7")
        end
    end
end

exports('TriggerGraveRobberyAlert', TriggerGraveRobberyAlert)
exports('SendLawmanAlert', SendLawmanAlert)

return {
    TriggerGraveRobberyAlert = TriggerGraveRobberyAlert,
    SendLawmanAlert = SendLawmanAlert
}
