--- Lost Objects system.
--- When a camp despawns (out of fuel), every furniture item placed in it AND
--- every item stored in its storage props is queued in `murphy_camp_lost_objects`
--- so the owner can recover them later from the "Lost Objects" NPC.

local LostObjects = {}
_G.LostObjects = LostObjects

local function resolveFurnitureItem(model)
    for _, v in pairs(Config.Furnitures) do
        if v.propset then
            if tablesAreEqual(v.propset, model) then return v.item end
        else
            if v.props == model then return v.item end
        end
    end
end

local function resolveCampfireItem(model)
    for _, v in pairs(Config.Campfire) do
        if v.propset then
            if tablesAreEqual(v.propset, model) then return v.item end
        else
            if v.props == model then return v.item end
        end
    end
end

local function queueItem(charid, item, amount, metadata)
    if not charid or not item or not amount or amount <= 0 then return end
    local metaJson = nil
    if metadata ~= nil then
        local ok, encoded = pcall(json.encode, metadata)
        if ok then metaJson = encoded end
    end
    MySQL.insert.await(
        'INSERT INTO murphy_camp_lost_objects (`charid`, `item`, `amount`, `metadata`) VALUES (?, ?, ?, ?)',
        { tostring(charid), item, amount, metaJson }
    )
end

--- Called by Sync.lua when a camp has just run out of fuel and is about to disappear.
--- Pushes every furniture item and every storage-prop item content into the owner's
--- lost-objects queue.
function LostObjects.OnCampDepop(campid, campData)
    if not Config.LostObjects or not Config.LostObjects.enabled then return end
    if not campData or not campData.charid then return end

    local charid = tostring(campData.charid)

    -- Furniture items placed in the camp
    for _, prop in pairs(campData.props or {}) do
        local item = resolveFurnitureItem(prop.model)
        if item then
            queueItem(charid, item, 1)
        end
    end

    -- Storage props content (tents, chests, wagons...)
    if Config.LostObjects.transferStorageItems and GetStashItems and ClearStash then
        for key, prop in pairs(campData.props or {}) do
            local resolved = nil
            for _, v in pairs(Config.Furnitures) do
                if v.propset then
                    if tablesAreEqual(v.propset, prop.model) then resolved = v; break end
                else
                    if v.props == prop.model then resolved = v; break end
                end
            end
            if resolved and resolved.inventory and tonumber(resolved.inventory) and tonumber(resolved.inventory) > 0 then
                local stashid = "camp_" .. campid .. "_" .. key
                local items = GetStashItems(stashid) or {}
                for _, it in ipairs(items) do
                    queueItem(charid, it.name, it.amount, it.metadata)
                end
                ClearStash(stashid)
            end
        end
    end
end

local function countPending(charid)
    local row = MySQL.scalar.await(
        'SELECT COUNT(*) FROM murphy_camp_lost_objects WHERE charid = ?',
        { tostring(charid) }
    )
    return tonumber(row) or 0
end

RegisterServerEvent("murphy_camp:ClaimLostObjects", function()
    local src = source
    local charid = GetCharIdentifier(src)
    if not charid then return end

    local rows = MySQL.query.await(
        'SELECT id, item, amount, metadata FROM murphy_camp_lost_objects WHERE charid = ?',
        { tostring(charid) }
    )
    if not rows or #rows == 0 then
        TriggerClientEvent('murphy_camp:ShowAdvancedRightNotification', src, Translate[37],
            "itemtype_textures", "itemtype_camp", "COLOR_WHITE", 4000)
        return
    end

    local recovered = 0
    local failed = 0
    for _, row in ipairs(rows) do
        local meta = {}
        if row.metadata and row.metadata ~= "" then
            local ok, decoded = pcall(json.decode, row.metadata)
            if ok and type(decoded) == "table" then meta = decoded end
        end
        local ok = GiveItem(src, row.item, tonumber(row.amount) or 1, meta)
        if ok then
            recovered = recovered + 1
            MySQL.update.await('DELETE FROM murphy_camp_lost_objects WHERE id = ?', { row.id })
        else
            failed = failed + 1
        end
    end

    if failed == 0 then
        TriggerClientEvent('murphy_camp:ShowAdvancedRightNotification', src,
            Translate[38][1] .. recovered .. Translate[38][2],
            "itemtype_textures", "itemtype_camp", "COLOR_WHITE", 4000)
    else
        TriggerClientEvent('murphy_camp:ShowAdvancedRightNotification', src,
            Translate[39][1] .. recovered .. Translate[39][2] .. failed .. Translate[39][3],
            "itemtype_textures", "itemtype_camp", "COLOR_WHITE", 6000)
    end
end)

Callback.register("murphy_camp:GetLostObjectsCount", function(source)
    local charid = GetCharIdentifier(source)
    if not charid then return 0 end
    return countPending(charid)
end)
