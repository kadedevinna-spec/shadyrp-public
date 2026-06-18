-- ===============================================
-- PROGRESS BAR CONFIGURATION
-- ===============================================
-- This file is NOT escrowed - you can edit it to use your own progress bar!
-- 
-- Set Config.ProgressBar in config.lua to one of these options:
-- "builtin" - Uses the built-in HTML progress bar (default, no dependencies)
-- "custom"  - Use your own custom progress bar (edit the function below)

-- ===============================================
-- PROGRESS BAR FUNCTION
-- ===============================================
-- This function is called by the script whenever a progress bar is needed
-- You can modify the "custom" section to work with ANY progress bar resource

function ShowProgressBar(label, durationSeconds)
    local progressType = Config.ProgressBar or "builtin"
    
    if progressType == "builtin" then
        -- Built-in progress bar (default)
        SendNUIMessage({
            action = "showProgress",
            label = label,
            duration = durationSeconds
        })
        
    elseif progressType == "custom" then
        -- ===============================================
        -- ADD YOUR CUSTOM PROGRESS BAR HERE
        -- ===============================================
        -- Replace the line below with your progress bar code
        
        -- Example 1: Using an export
        -- exports['your-progressbar']:showProgress(label, durationSeconds * 1000)
        
        -- Example 2: Using an event
        -- TriggerEvent('your-progressbar:start', {
        --     duration = durationSeconds * 1000,
        --     label = label
        -- })
        
        -- Example 3: RSG Progress Bar (if you use RSG framework)
        -- exports['rsg-progressbar']:Progress({
        --     name = "goldpanning",
        --     duration = durationSeconds * 1000,
        --     label = label,
        --     useWhileDead = false,
        --     canCancel = false,
        --     controlDisables = {
        --         disableMovement = true,
        --         disableCarMovement = true,
        --         disableMouse = false,
        --         disableCombat = true,
        --     }
        -- })
        
        print("[GoldPanning] Custom progress bar not configured! Edit progressbar.lua")
    end
end

function HideProgressBar()
    local progressType = Config.ProgressBar or "builtin"
    
    if progressType == "builtin" then
        SendNUIMessage({
            action = "hideProgress"
        })
    elseif progressType == "custom" then
        -- Add your hide logic here if needed
        -- Most progress bars auto-hide when complete
    end
end

-- ===============================================
-- EXPORTS (Optional - allows other resources to use the builtin progress bar)
-- ===============================================
exports('ShowProgress', function(label, durationSeconds)
    ShowProgressBar(label, durationSeconds)
end)

exports('HideProgress', function()
    HideProgressBar()
end)
