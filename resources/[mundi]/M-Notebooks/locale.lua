-- ===============================================
-- M-NOTEBOOKS LOCALE CONFIGURATION
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
    -- Core Notifications (these override Config.Messages when locale is used)
    noNotebook = "You don't have a notebook.",
    noPen = "You need a pen to write.",
    notebookOpened = "Opening notebook...",
    notebookSaved = "Notebook saved.",
    pageLimitReached = "You've reached the maximum number of pages.",
    notePinned = "Note pinned to wall.",
    noteRemoved = "Pinned note removed.",
    maxPinnedReached = "You've reached the maximum number of pinned notes.",
    cannotDeleteOther = "You can only remove your own notes.",
    penBroken = "Your pen has run out of ink.",
    penLow = "Your pen is running low on ink.",
    tooFarAway = "You're too far away.",
    
    -- Page Actions
    pageTornOut = "You tore out a page.",
    
    -- Pinned Notes
    notePinnedPermanent = "Note pinned to wall. (Permanent)",
    maxPinnedServer = "Maximum pinned notes on the server reached.",
    noteTakenFromWall = "You took the note from the wall.",
    
    -- Admin
    noPermission = "You don't have permission to use this command.",
    adminUsage = "Usage: /%s <player_id>",
    playerNotFound = "Player not found or not loaded.",
    noNotebooks = "That player doesn't have any notebooks yet.",
    playerUnavailable = "Player no longer available.",
    notebookNotFound = "Notebook not found.",
    adminDeleted = 'Deleted notebook "%s" (#%s) from %s.%s',
    adminItemRemoved = " Item removed from inventory.",
    adminViewing = "Viewing %s's notebook (Admin)",
    
    -- Confiscation
    notebookConfiscated = "Your notebook has been confiscated.",
    
    -- Prop Errors
    failedToLoadProp = "Failed to load prop model.",

    -- Pinned Note Prompts (native prompts & ox_target labels)
    promptReadNote = "Read Note",
    promptRemoveNote = "Remove Note",
    promptTakeNote = "Take Note",
    promptGroupLabel = "Pinned Note",

    -- Torn Page Context Menu
    tornPageMenuTitle = "Torn Page",
    tornPageRead = "Read Page",
    tornPageReadDesc = "View what is written on this page",
    tornPagePlaceOnWall = "Place on Wall",
    tornPagePlaceDesc = "Pin this page to a nearby surface",
}

-- ===============================================
-- TEMPLATE FOR YOUR OWN LANGUAGE
-- ===============================================
--[[
Locales["xx"] = {
    -- Core Notifications
    noNotebook = "",
    noPen = "",
    notebookOpened = "",
    notebookSaved = "",
    pageLimitReached = "",
    notePinned = "",
    noteRemoved = "",
    maxPinnedReached = "",
    cannotDeleteOther = "",
    penBroken = "",
    penLow = "",
    tooFarAway = "",
    
    -- Page Actions
    pageTornOut = "",
    
    -- Pinned Notes
    notePinnedPermanent = "",
    maxPinnedServer = "",
    noteTakenFromWall = "",
    
    -- Admin
    noPermission = "",
    adminUsage = "",  -- %s = command name
    playerNotFound = "",
    noNotebooks = "",
    playerUnavailable = "",
    notebookNotFound = "",
    adminDeleted = "",  -- %s = title, id, player name, item removed text
    adminItemRemoved = "",
    adminViewing = "",  -- %s = player name
    
    -- Confiscation
    notebookConfiscated = "",
    
    -- Prop Errors
    failedToLoadProp = "",

    -- Pinned Note Prompts (native prompts & ox_target labels)
    promptReadNote = "",
    promptRemoveNote = "",
    promptTakeNote = "",
    promptGroupLabel = "",

    -- Torn Page Context Menu
    tornPageMenuTitle = "",
    tornPageRead = "",
    tornPageReadDesc = "",
    tornPagePlaceOnWall = "",
    tornPagePlaceDesc = "",
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
