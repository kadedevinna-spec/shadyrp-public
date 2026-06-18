-- ===============================================
-- M-BACKPACKS LOCALE CONFIGURATION
-- ===============================================
-- Language is set in config.lua via Config.Locale
-- Available languages: "en" (English)
-- Add your own translations below and set Config.Locale to your language code

-- ===============================================
-- LOCALES
-- ===============================================
Locales = {}

-- English
Locales["en"] = {
    -- Backpack Usage
    pleaseWait = "Please wait before using backpack again",
    pleaseWaitShort = "Please wait...",
    dontHaveBackpack = "You don't have this backpack",
    waitBeforeOpening = "Wait a moment before opening your backpack",
    backpackOperationFailed = "Backpack operation failed",
    backpackInitFailed = "Backpack initialization failed",
    failedToInitialize = "Failed to initialize backpack",
    failedToCreate = "Failed to create backpack",
    corruptedData = "Corrupted backpack data",
    
    -- Backpack Limit Enforcement
    cannotCarryMore = "You cannot carry more backpacks",
    carryLimit = "You can only carry %s backpack(s) at a time",
    excessDropped = "%s excess backpack(s) dropped on the ground. You kept your %s",
    excessWarning = "WARNING: You have %s backpack(s) but only %s is allowed. You have %s minutes to drop excess backpacks or they will be dropped automatically. You will keep your %s.",
    
    -- Blacklist / Item Restrictions
    cannotStoreInBackpack = "This item cannot be stored in a backpack!",
    
    -- Exploit Protection
    exploitBlocked = "Exploit blocked: Do not move items while using them!",
    
    -- Wearable Props
    backpackNotifyTitle = "Backpack",
    
    -- Long Notification
    longNotifyTitle = "Backpack Warning",
    
    -- Prop Error
    failedToLoadProp = "Failed to load prop model.",
}

-- ===============================================
-- TEMPLATE FOR YOUR OWN LANGUAGE
-- ===============================================
--[[
Locales["xx"] = {
    -- Backpack Usage
    pleaseWait = "",
    pleaseWaitShort = "",
    dontHaveBackpack = "",
    waitBeforeOpening = "",
    backpackOperationFailed = "",
    backpackInitFailed = "",
    failedToInitialize = "",
    failedToCreate = "",
    corruptedData = "",
    
    -- Backpack Limit Enforcement
    cannotCarryMore = "",
    carryLimit = "",  -- %s = number of backpacks allowed
    excessDropped = "",  -- first %s = count dropped, second %s = kept backpack label
    excessWarning = "",  -- %s = total, allowed, minutes, kept backpack label
    
    -- Blacklist / Item Restrictions
    cannotStoreInBackpack = "",
    
    -- Exploit Protection
    exploitBlocked = "",
    
    -- Wearable Props
    backpackNotifyTitle = "",
    
    -- Long Notification
    longNotifyTitle = "",
    
    -- Prop Error
    failedToLoadProp = "",
}
]]--

-- ===============================================
-- TRANSLATION FUNCTION
-- ===============================================
function _U(str, ...)
    if not Config then return str end
    local locale = Config.Locale or "en"
    local text = Locales[locale] and Locales[locale][str] or Locales["en"] and Locales["en"][str] or str
    if ... then
        return string.format(text, ...)
    end
    return text
end
