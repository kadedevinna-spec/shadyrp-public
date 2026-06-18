-- ─── WARDROBE INTEGRATION ─────────────────────────────────────────────────────
-- Connects fx-camping's wardrobe prompt to a clothing script.
--
-- Supported scripts (resource names):
--   "jo_clothingstore"  → https://docs.jumpon-studios.com/RedM/clothing-store
--   "murphy_clothing"   → https://docs.murphy-workshop.com/murphy-s-clothing
--
-- Set Script to "auto" to detect the active script automatically,
-- or hardcode one of the names above to force a specific script.
-- Set Enabled to false to hide the Set Wardrobe button in /mycamp entirely.
-- ─────────────────────────────────────────────────────────────────────────────

Config.Wardrobe = {
    Enabled  = true,
    Distance = 2.0,  -- metres — prompt interaction radius around the wardrobe point

    -- "auto" | "jo_clothingstore" | "murphy_clothing"
    Script   = "auto",
}

-- Called client-side when the player uses the wardrobe prompt.
-- Edit this function to integrate with a different clothing script.
function Config.Wardrobe.Open()
    local script = Config.Wardrobe.Script

    if script == "auto" then
        if GetResourceState("jo_clothingstore") == "started" then
            script = "jo_clothingstore"
        elseif GetResourceState("murphy_clothing") == "started" then
            script = "murphy_clothing"
        else
            Notify({ text = Locale("wardrobe_no_script"), type = "error", time = 3000 })
            return
        end
    end

    if script == "jo_clothingstore" then
        -- https://docs.jumpon-studios.com/RedM/clothing-store#open-the-wardrobe
        -- needInstance = false: shared wardrobe (no personal instance)
        TriggerEvent('jo_clothingstore:openWardrobe', false)

    elseif script == "murphy_clothing" then
        -- https://docs.murphy-workshop.com/murphy-s-clothing/advanced/api-documentation
        -- Opens outfit list in wardrobe mode (free equip, no charge)
        TriggerEvent('murphy_clothes:OpenWardrobe')
    end
end
