Config = {}

-- Command configuration
Config.Command = "bomba"

-- Minigame settings
Config.Minigame = {
    minTime = 1,       -- Minimum time in seconds
    maxTime = 300,     -- Maximum time in seconds (5 minutes)
    defaultTime = 0,  -- Default time if none specified
}

-- UI settings
Config.UI = {
    showCursor = true,
    keepInput = true,
}

-- Audio settings
Config.Audio = {
    enabled = true,                        -- Enable/disable audio system
    timeSetSound = "sounds/time_set.mp3",  -- Sound when adjusting time
    tickSound = "sounds/tick.mp3",         -- Sound for countdown tick
    volumes = {
        timeSet = 0.5,                     -- Volume for time adjustment sound (0.0 to 1.0)
        tick = 0.3,                        -- Volume for tick sound (0.0 to 1.0)
    }
}

-- ================================
--        LANGUAGE SYSTEM
-- ================================

-- Language Configuration
Config.Languages = {
    currentLanguage = "en-us",
    
    ["en-us"] = {
        -- JavaScript Alert Messages
        alerts = {
            invalidTime = "Please enter a valid time between 1 and 300 seconds"
        },
        
        -- Console Messages
        console = {
            uiClosed = "UI closed - timer sound continues playing",
            miniDisplayShown = "Mini display shown",
            miniDisplayHidden = "Mini display hidden",
            externalMiniDisplayShown = "External mini display shown - Time: ",
            seconds = "s"
        }
    }
}

-- Helper function to get language text
function GetLanguageText(category, key)
    local currentLang = Config.Languages.currentLanguage
    local langTable = Config.Languages[currentLang]
    
    if langTable and langTable[category] and langTable[category][key] then
        return langTable[category][key]
    end
    
    -- Fallback to en-us if not found
    local fallback = Config.Languages["en-us"]
    if fallback and fallback[category] and fallback[category][key] then
        return fallback[category][key]
    end
    
    -- Return key if nothing found
    return key
end
