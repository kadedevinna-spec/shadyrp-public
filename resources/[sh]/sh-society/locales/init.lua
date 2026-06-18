Locales = Locales or {}

function L(key, ...)
    local selected = Locales[Config.Locale] or Locales.en or {}
    local fallback = Locales.en or {}
    local phrase = selected[key] or fallback[key] or key
    if select('#', ...) > 0 then
        local ok, formatted = pcall(string.format, phrase, ...)
        if ok then
            return formatted
        end
    end
    return phrase
end
