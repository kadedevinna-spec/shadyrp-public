-- Localization system for OxObjselector
-- Handles multiple language support

Locales = {}

-- Get translation function
function _(str, ...)
    if not Config or not Config.Locale then
        print('[OxObjselector] Warning: Config.Locale not set, defaulting to English')
        Config = Config or {}
        Config.Locale = 'en'
    end

    if Locales[Config.Locale] ~= nil then
        if Locales[Config.Locale][str] ~= nil then
            return string.format(Locales[Config.Locale][str], ...)
        else
            -- Fallback to English if key doesn't exist in selected locale
            if Config.Locale ~= 'en' and Locales['en'] and Locales['en'][str] then
                return string.format(Locales['en'][str], ...)
            else
                return 'Translation [' .. str .. '] does not exist'
            end
        end
    else
        -- Fallback to English if locale doesn't exist
        if Locales['en'] and Locales['en'][str] then
            return string.format(Locales['en'][str], ...)
        else
            return 'Locale [' .. Config.Locale .. '] does not exist'
        end
    end
end

-- Helper function to get localized scenario label from config
function GetScenarioLabel(labelKey)
    -- Try to get translation with scenario_ prefix
    local translated = _('scenario_' .. labelKey:lower():gsub(' ', '_'):gsub('[%(%)%-%.]', ''))
    
    -- If translation doesn't exist, return the original label
    if translated:find('Translation') or translated:find('does not exist') then
        return labelKey
    end
    
    return translated
end

-- Helper function to get localized category label from config
function GetCategoryLabel(labelKey)
    -- Try to get translation with category_ prefix
    local translated = _('category_' .. labelKey:lower():gsub(' ', '_'):gsub('[%(%)%-%.]', ''))
    
    -- If translation doesn't exist, return the original label
    if translated:find('Translation') or translated:find('does not exist') then
        return labelKey
    end
    
    return translated
end
