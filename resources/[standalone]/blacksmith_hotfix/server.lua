local ForgeItems = {
    blacksmith_forge = {
        name = "blacksmith_forge",
        label = "Blacksmith Forge",
        weight = 8000,
        type = "item",
        image = "blacksmith_forge.png",
        unique = true,
        useable = true,
        usable = true,
        shouldClose = true,
        can_remove = true,
        limit = 1,
        description = "Mosquito mining/blacksmithing forge",
    },
    blacksmith_forge_advanced = {
        name = "blacksmith_forge_advanced",
        label = "Advanced Blacksmith Forge",
        weight = 10000,
        type = "item",
        image = "blacksmith_forge_advanced.png",
        unique = true,
        useable = true,
        usable = true,
        shouldClose = true,
        can_remove = true,
        limit = 1,
        description = "Mosquito mining/blacksmithing forge",
    },
}

local HotfixVersion = "20260619-forge-condition-guard"
local DbCompatReady = false
local DbCompatStatus = "not checked"
local ensureVorpCharacter

local cbOk, cbMsg = registerSafeForgeConditionCallback()
print(("[blacksmith_hotfix] version %s forge condition callback: %s (%s)"):format(
    HotfixVersion,
    cbOk and "ok" or "failed",
    tostring(cbMsg)
))

local function say(source, message, messageType)
    print(("[blacksmith_hotfix] %s"):format(message))

    if source and source > 0 then
        TriggerClientEvent("chat:addMessage", source, {
            args = { "blacksmith_hotfix", message }
        })

        TriggerClientEvent("ox_lib:notify", source, {
            title = message,
            type = messageType or "inform",
            duration = 5000
        })
    end
end

local PlaceForgeForwardedAt = {}
local PlaceForgeBridgeRequestId = 0
local PendingPlaceForgeRequests = {}
local ForgeBridgeStatusRequestId = 0
local PendingForgeBridgeStatus = {}

local function getForgeItemNameByIndex(index)
    local numericIndex = tonumber(index) or 1
    if numericIndex == 2 then
        return "blacksmith_forge_advanced"
    end
    return "blacksmith_forge"
end

local function getForgeItemCount(source, itemName)
    local ok, count = pcall(function()
        return exports["vorp_inventory"]:getItemCount(source, itemName)
    end)
    if ok then return tonumber(count) or 0 end

    ok, count = pcall(function()
        return exports["rsg-inventory"]:GetItemCount(source, itemName)
    end)
    if ok then return tonumber(count) or 0 end

    ok, count = pcall(function()
        return exports["v-inventory"]:GetItemCount(source, itemName)
    end)
    if ok then return tonumber(count) or 0 end

    return 0
end

local function consumePlacedForgeItem(source, itemName, amount)
    amount = tonumber(amount) or 1

    local ok, removed = pcall(function()
        return exports["vorp_inventory"]:subItem(source, itemName, amount, nil)
    end)
    if ok and removed ~= false then return true, "vorp_inventory" end

    ok, removed = pcall(function()
        return exports["rsg-inventory"]:RemoveItem(source, itemName, amount, nil)
    end)
    if ok and removed ~= false then return true, "rsg-inventory" end

    ok, removed = pcall(function()
        return exports["v-inventory"]:RemoveItem(source, itemName, amount, "player")
    end)
    if ok and removed ~= false then return true, "v-inventory" end

    return false, removed
end

AddEventHandler("blacksmith_hotfix:mosquito:placeforgeResult", function(requestId, playerSource, ok, message)
    requestId = tostring(requestId or "")
    local pending = PendingPlaceForgeRequests[requestId]
    if not pending then
        return
    end

    PendingPlaceForgeRequests[requestId] = nil
    say(pending.source, ("Mosquito bridge result for /placeforge %s: ok=%s msg=%s"):format(
        tostring(pending.index),
        tostring(ok == true),
        tostring(message)
    ), ok == true and "success" or "error")
end)

AddEventHandler("blacksmith_hotfix:mosquito:statusResult", function(requestId, status)
    requestId = tostring(requestId or "")
    local pending = PendingForgeBridgeStatus[requestId]
    if not pending then
        return
    end

    PendingForgeBridgeStatus[requestId] = nil

    local handler = type(status) == "table" and status.handler or false
    local command = type(status) == "table" and status.command or nil
    local commands = type(status) == "table" and type(status.commands) == "table" and table.concat(status.commands, ", ") or "none"

    say(pending.source, ("hotfix=%s mosquitoBridge responded=true handler=%s command=%s commands=%s"):format(
        HotfixVersion,
        tostring(handler),
        tostring(command),
        commands ~= "" and commands or "none"
    ), handler and "success" or "error")
end)

local function forwardPlaceForgeCommand(source, args)
    if not source or source <= 0 then
        say(source, "usage: /placeforge [index]", "error")
        return
    end

    local now = GetGameTimer and GetGameTimer() or (os.time() * 1000)
    if PlaceForgeForwardedAt[source] and (now - PlaceForgeForwardedAt[source]) < 1500 then
        return
    end

    PlaceForgeForwardedAt[source] = now

    local index = args and args[1] or "1"
    local itemName = getForgeItemNameByIndex(index)
    local beforeCount = getForgeItemCount(source, itemName)
    local dbOk, dbMsg = ensureVorpCharacter(source)
    if not dbOk then
        say(source, ("forge placement DB precheck failed: %s"):format(tostring(dbMsg)), "error")
        return
    end

    PlaceForgeBridgeRequestId = PlaceForgeBridgeRequestId + 1
    local requestId = ("%s:%s"):format(tostring(source), tostring(PlaceForgeBridgeRequestId))
        PendingPlaceForgeRequests[requestId] = {
         source = source,
            index = tostring(index or "1"),
            itemName = itemName,
            beforeCount = beforeCount,
}

    TriggerEvent("blacksmith_hotfix:mosquito:placeforge", source, { tostring(index or "1") }, ("placeforge %s"):format(tostring(index or "1")), requestId)
    say(source, ("sent /placeforge %s to Mosquito server bridge; %s"):format(tostring(index or "1"), tostring(dbMsg)), "inform")

    CreateThread(function()
        Wait(2000)
        if PendingPlaceForgeRequests[requestId] then
            PendingPlaceForgeRequests[requestId] = nil
            local consumeDetail = "not-required"
if ok == true and pending.itemName then
    local beforeCount = tonumber(pending.beforeCount) or 0
    local afterCount = getForgeItemCount(pending.source, pending.itemName)

    if afterCount >= beforeCount and afterCount > 0 then
        local consumed, consumeSource = consumePlacedForgeItem(pending.source, pending.itemName, 1)
        local finalCount = getForgeItemCount(pending.source, pending.itemName)
        consumeDetail = ("consume=%s source=%s item=%s count %s->%s"):format(
            tostring(consumed),
            tostring(consumeSource),
            tostring(pending.itemName),
            tostring(afterCount),
            tostring(finalCount)
        )
    else
        consumeDetail = ("already-consumed item=%s count %s->%s"):format(
            tostring(pending.itemName),
            tostring(beforeCount),
            tostring(afterCount)
        )
    end
end
            say(pending.source, ("Mosquito bridge result for /placeforge %s: ok=%s msg=%s"):format(
    tostring(pending.index),
    tostring(ok == true),
    ("%s [%s]"):format(tostring(message), consumeDetail)
), ok == true and "success" or "error")
        end
    end)
end

local function getBridgeFileStatus()
    local contents = LoadResourceFile("v-inventory", "bridge_server.lua")
    if not contents then
        return "bridge=unreadable"
    end

    local vorpContents = LoadResourceFile("vorp_inventory", "server.lua") or ""
    local rsgContents = LoadResourceFile("rsg-inventory", "server/exports.lua") or ""
    local hasRetryPatch = contents:find("EnsureFrameworkReady", 1, true) ~= nil
    local hasRsgLoader = contents:find("LoadRSGItemDefinitions", 1, true) ~= nil
    local hasForgeSeed = contents:find("MosquitoBlacksmithItems", 1, true) ~= nil
    local hasDirectFallback = contents:find("GetRSGCoreObject", 1, true) ~= nil
        and contents:find("saving inventory only", 1, true) ~= nil
    local hasUseOrderPatch = contents:find(":UseItem(source, sendData)", 1, true) ~= nil
    local hasVorpCountFallback = vorpContents:find("v GetInventory", 1, true) ~= nil
    local hasRsgCountFallback = rsgContents:find("sumItems", 1, true) ~= nil

    return ("bridge retryPatch=%s rsgLoader=%s forgeSeed=%s directFallback=%s useOrder=%s vorpCountFallback=%s rsgCountFallback=%s bytes=%s"):format(
        tostring(hasRetryPatch),
        tostring(hasRsgLoader),
        tostring(hasForgeSeed),
        tostring(hasDirectFallback),
        tostring(hasUseOrderPatch),
        tostring(hasVorpCountFallback),
        tostring(hasRsgCountFallback),
        tostring(#contents)
    )
end

local function getVInventoryDefinitions()
    local ok, defs = pcall(function()
        return exports["v-inventory"]:GetAllItems()
    end)

    if ok and type(defs) == "table" then
        return defs
    end

    ok, defs = pcall(function()
        return exports["v-inventory"]:GetItemDefinitions()
    end)

    if ok and type(defs) == "table" then
        return defs
    end

    local bridge = nil
    ok, bridge = pcall(function()
        return exports["v-inventory"]:VBridge()
    end)

    if ok and type(bridge) == "table" then
        defs = bridge.GetItemDefinitions
        if type(defs) == "function" then
            local okDefs, result = pcall(defs)
            defs = okDefs and result or nil
        end
        if type(defs) == "table" then
            return defs
        end
    end

    return nil
end

local function getVBridge()
    local ok, bridge = pcall(function()
        return exports["v-inventory"]:VBridge()
    end)

    if ok and type(bridge) == "table" then
        return bridge
    end

    return nil
end

local function getVFramework()
    local bridge = getVBridge()
    if bridge and type(bridge.GetFramework) == "function" then
        local ok, framework = pcall(function()
            return bridge.GetFramework()
        end)
        if ok then return framework end
    end

    return nil
end

local function getVIdentifier(target)
    local bridge = getVBridge()
    if bridge and type(bridge.GetIdentifier) == "function" then
        local ok, identifier = pcall(function()
            return bridge.GetIdentifier(target)
        end)
        if ok then return identifier end
    end

    return nil
end

local function getRsgCitizenId(target)
    local ok, core = pcall(function()
        return exports["rsg-core"]:GetCoreObject()
    end)

    if not ok or not core then return nil end

    local player = core.Functions.GetPlayer(target)
    return player and player.PlayerData and player.PlayerData.citizenid or nil
end

local function getRsgPlayerData(target)
    local ok, core = pcall(function()
        return exports["rsg-core"]:GetCoreObject()
    end)

    if not ok or not core then return nil end

    local player = core.Functions.GetPlayer(target)
    return player and player.PlayerData or nil
end

local function ensureColumn(tableName, columnName, definition)
    local rows = MySQL.query.await(("SHOW COLUMNS FROM `%s` LIKE '%s'"):format(tableName, columnName))
    if type(rows) == "table" and #rows > 0 then
        return true
    end

    MySQL.query.await(("ALTER TABLE `%s` ADD COLUMN `%s` %s"):format(tableName, columnName, definition))
    return true
end

local function ensureVorpCharactersTable()
    if DbCompatReady then
        return true, DbCompatStatus
    end

    local ok, err = pcall(function()
        MySQL.query.await([[
            CREATE TABLE IF NOT EXISTS `characters` (
                `id` INT NOT NULL AUTO_INCREMENT,
                `identifier` VARCHAR(64) NOT NULL,
                `charidentifier` VARCHAR(64) NOT NULL,
                `characterid` VARCHAR(64) DEFAULT NULL,
                `citizenid` VARCHAR(64) DEFAULT NULL,
                `firstname` VARCHAR(50) DEFAULT NULL,
                `lastname` VARCHAR(50) DEFAULT NULL,
                `job` VARCHAR(50) DEFAULT 'unemployed',
                `jobgrade` INT DEFAULT 0,
                `mosquitoMining` LONGTEXT NULL,
                PRIMARY KEY (`id`),
                UNIQUE KEY `idx_identifier_charidentifier` (`identifier`, `charidentifier`),
                KEY `idx_citizenid` (`citizenid`)
            ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
        ]])

        ensureColumn("characters", "characterid", "VARCHAR(64) DEFAULT NULL")
        ensureColumn("characters", "citizenid", "VARCHAR(64) DEFAULT NULL")
        ensureColumn("characters", "firstname", "VARCHAR(50) DEFAULT NULL")
        ensureColumn("characters", "lastname", "VARCHAR(50) DEFAULT NULL")
        ensureColumn("characters", "job", "VARCHAR(50) DEFAULT 'unemployed'")
        ensureColumn("characters", "jobgrade", "INT DEFAULT 0")
        ensureColumn("characters", "mosquitoMining", "LONGTEXT NULL")
    end)

    DbCompatReady = ok
    DbCompatStatus = ok and "characters table ready" or tostring(err)
    return ok, DbCompatStatus
end

function ensureVorpCharacter(target)
    target = tonumber(target)
    if not target or target <= 0 then
        return false, "invalid player source"
    end

    local tableOk, tableMsg = ensureVorpCharactersTable()
    if not tableOk then
        return false, tableMsg
    end

    local data = getRsgPlayerData(target)
    if not data then
        return false, "no RSG player data"
    end

    local citizenId = data.citizenid
    local identifier = data.license or citizenId
    if not citizenId or not identifier then
        return false, "missing RSG identifier/citizenid"
    end

    local charinfo = data.charinfo or {}
    local job = data.job or {}
    local grade = job.grade or {}
    local jobGrade = tonumber(grade.level or grade.grade or job.gradelevel or 0) or 0

    MySQL.update.await([[
        INSERT INTO `characters`
            (`identifier`, `charidentifier`, `characterid`, `citizenid`, `firstname`, `lastname`, `job`, `jobgrade`, `mosquitoMining`)
        VALUES
            (?, ?, ?, ?, ?, ?, ?, ?, '{}')
        ON DUPLICATE KEY UPDATE
            `characterid` = VALUES(`characterid`),
            `citizenid` = VALUES(`citizenid`),
            `firstname` = VALUES(`firstname`),
            `lastname` = VALUES(`lastname`),
            `job` = VALUES(`job`),
            `jobgrade` = VALUES(`jobgrade`),
            `mosquitoMining` = COALESCE(`mosquitoMining`, VALUES(`mosquitoMining`))
    ]], {
        identifier,
        citizenId,
        citizenId,
        citizenId,
        charinfo.firstname or "",
        charinfo.lastname or "",
        job.name or "unemployed",
        jobGrade
    })

    return true, ("synced characters row identifier=%s charidentifier=%s"):format(tostring(identifier), tostring(citizenId))
end

local function syncOnlineVorpCharacters()
    local synced = 0
    for _, playerId in ipairs(GetPlayers()) do
        local ok = ensureVorpCharacter(tonumber(playerId))
        if ok then synced = synced + 1 end
    end

    return synced
end

local function callInventory(label, fn)
    local results = table.pack(pcall(fn))
    if not results[1] then
        return false, nil, ("%s exception: %s"):format(label, tostring(results[2]))
    end

    return true, results[2], results[3]
end

local RuntimeItemSeed
local RuntimeItemSeedSource = "unbuilt"
local FallbackMosquitoItems = {
    barmold = { label = "Bar Mold", limit = 50, can_remove = true, useable = true, weight = 300 },
    pickaxe = { label = "Pickaxe", limit = 10, can_remove = true, useable = true, weight = 6000 },
    pickaxe_steel = { label = "Steel Pickaxe", limit = 10, can_remove = true, useable = true, weight = 6500 },
    pickaxe_silver = { label = "Silver Titanium Pickaxe", limit = 10, can_remove = true, useable = true, weight = 6800 },
    pickaxe_gold = { label = "Golden Titanium Pickaxe", limit = 10, can_remove = true, useable = true, weight = 7000 },
    pickaxe_head = { label = "Pickaxe Head", limit = 50, can_remove = true, useable = true, weight = 2500 },
    pickaxe_steel_head = { label = "Steel Pickaxe Head", limit = 50, can_remove = true, useable = true, weight = 2500 },
    pickaxe_silver_head = { label = "Silver Titanium Pickaxe Head", limit = 50, can_remove = true, useable = true, weight = 2500 },
    pickaxe_gold_head = { label = "Golden Titanium Pickaxe Head", limit = 50, can_remove = true, useable = true, weight = 2500 },
    sharpeningstone = { label = "Sharpening Stone", limit = 50, can_remove = true, useable = true, weight = 150 },
    titaniumbar = { label = "Titanium Bar", limit = 100, can_remove = true, useable = true, weight = 300 },
    titanium = { label = "Titanium Ore", limit = 200, can_remove = true, useable = true, weight = 300 },
    titanium_nugget = { label = "Titanium Nugget", limit = 100, can_remove = true, useable = true, weight = 100 },
    stone = { label = "Stone", limit = 200, can_remove = true, useable = true, weight = 150 },
    steelbar = { label = "Steel Bar", limit = 100, can_remove = true, useable = true, weight = 300 },
    steel_nugget = { label = "Steel Nugget", limit = 100, can_remove = true, useable = true, weight = 100 },
    silverbar = { label = "Silver Bar", limit = 100, can_remove = true, useable = true, weight = 300 },
    silver = { label = "Silver Ore", limit = 200, can_remove = true, useable = true, weight = 300 },
    silver_nugget = { label = "Silver Nugget", limit = 100, can_remove = true, useable = true, weight = 100 },
    sandstone = { label = "Sandstone", limit = 200, can_remove = true, useable = true, weight = 150 },
    sand = { label = "Sand", limit = 200, can_remove = true, useable = true, weight = 1500 },
    salt = { label = "Salt", limit = 200, can_remove = true, useable = true, weight = 1500 },
    rubis = { label = "Ruby", limit = 50, can_remove = true, useable = true, weight = 100 },
    rosegoldnugget = { label = "Rose Gold Nugget", limit = 100, can_remove = true, useable = true, weight = 100 },
    rosegold = { label = "Rose Gold Bar", limit = 100, can_remove = true, useable = true, weight = 300 },
    rock = { label = "Rock", limit = 200, can_remove = true, useable = true, weight = 150 },
    pigironbar = { label = "Pig Iron Bar", limit = 100, can_remove = true, useable = true, weight = 300 },
    nitrite = { label = "Nitrite", limit = 200, can_remove = true, useable = true, weight = 1500 },
    nickel = { label = "Nickel Ore", limit = 200, can_remove = true, useable = true, weight = 300 },
    nickel_nugget = { label = "Nickel Nugget", limit = 100, can_remove = true, useable = true, weight = 100 },
    miningdynamitecrate = { label = "Mining Dynamite Crate", limit = 20, can_remove = true, useable = true, weight = 8000 },
    miningdynamite = { label = "Mining Dynamite", limit = 50, can_remove = true, useable = true, weight = 700 },
    limestone = { label = "Limestone", limit = 200, can_remove = true, useable = true, weight = 150 },
    lead = { label = "Lead Ore", limit = 200, can_remove = true, useable = true, weight = 300 },
    lead_nugget = { label = "Lead Nugget", limit = 100, can_remove = true, useable = true, weight = 100 },
    ironbar = { label = "Iron Bar", limit = 100, can_remove = true, useable = true, weight = 300 },
    iron = { label = "Iron Ore", limit = 200, can_remove = true, useable = true, weight = 300 },
    iron_nugget = { label = "Iron Nugget", limit = 100, can_remove = true, useable = true, weight = 100 },
    greengoldnugget = { label = "Green Gold Nugget", limit = 100, can_remove = true, useable = true, weight = 100 },
    greengold = { label = "Green Gold Bar", limit = 100, can_remove = true, useable = true, weight = 300 },
    goldbar = { label = "Gold Bar", limit = 100, can_remove = true, useable = true, weight = 300 },
    gold_nugget = { label = "Gold Nugget", limit = 100, can_remove = true, useable = true, weight = 100 },
    goldnugget = { label = "Gold Nugget", limit = 100, can_remove = true, useable = true, weight = 100 },
    emerald = { label = "Emerald", limit = 50, can_remove = true, useable = true, weight = 100 },
    diamond = { label = "Diamond", limit = 50, can_remove = true, useable = true, weight = 100 },
    copperbar = { label = "Copper Bar", limit = 100, can_remove = true, useable = true, weight = 300 },
    copper = { label = "Copper Ore", limit = 200, can_remove = true, useable = true, weight = 300 },
    copper_nugget = { label = "Copper Nugget", limit = 100, can_remove = true, useable = true, weight = 100 },
    coal = { label = "Coal", limit = 200, can_remove = true, useable = true, weight = 100 },
    clay = { label = "Clay", limit = 200, can_remove = true, useable = true, weight = 1500 },
    wood = { label = "Wood", limit = 200, can_remove = true, useable = true, weight = 3000 },
    bluegoldnugget = { label = "Blue Gold Nugget", limit = 100, can_remove = true, useable = true, weight = 100 },
    bluegold = { label = "Blue Gold Bar", limit = 100, can_remove = true, useable = true, weight = 300 },
    wateringscan_empty = { label = "Empty Water Bucket", limit = 10, can_remove = true, useable = true, weight = 300 },
    lockpickmold = { label = "Bar Mold", limit = 50, can_remove = true, useable = true, weight = 300 },
    crudeoil = { label = "Crude Oil", limit = 150, can_remove = true, useable = true, weight = 1500 },
    ethanol = { label = "Ethanol", limit = 150, can_remove = true, useable = true, weight = 1500 },
    glass = { label = "Glass", limit = 100, can_remove = true, useable = true, weight = 800 },
    gasoline = { label = "Gasoline", limit = 150, can_remove = true, useable = true, weight = 1500 },
    hammerhead = { label = "Hammer Head", limit = 50, can_remove = true, useable = true, weight = 300 },
    blacksmithhammer = { label = "Blacksmith Hammer", limit = 10, can_remove = true, useable = true, weight = 3000 },
    hammer = { label = "Hammer", limit = 10, can_remove = true, useable = true, weight = 3000 },
    nails = { label = "Nails", limit = 100, can_remove = true, useable = true, weight = 100 },
    armingsword = { label = "Arming Sword", limit = 20, can_remove = true, useable = true, weight = 3000 },
    hammerhandle = { label = "Hammer Handle", limit = 50, can_remove = true, useable = true, weight = 300 },
    bighandle = { label = "Big Wooden Handle", limit = 50, can_remove = true, useable = true, weight = 150 },
    smallhandle = { label = "Small Wooden Handle", limit = 50, can_remove = true, useable = true, weight = 300 },
    leatherstrip = { label = "Leather Strip", limit = 100, can_remove = true, useable = true, weight = 200 },
    lumberaxe = { label = "Lumber Axe", limit = 10, can_remove = true, useable = true, weight = 4500 },
    lumberaxe_steel = { label = "Steel Lumber Axe", limit = 10, can_remove = true, useable = true, weight = 4500 },
    goldpan = { label = "Gold Pan", limit = 10, can_remove = true, useable = true, weight = 150 },
    bolts = { label = "Bolts", limit = 100, can_remove = true, useable = true, weight = 100 },
    chisel = { label = "Chisel", limit = 10, can_remove = true, useable = true, weight = 300 },
    ironhammer = { label = "Iron Hammer", limit = 10, can_remove = true, useable = true, weight = 3000 },
    horseshoe = { label = "Horseshoe", limit = 50, can_remove = true, useable = true, weight = 200 },
    hoofhook = { label = "Hoof Hook", limit = 50, can_remove = true, useable = true, weight = 200 },
    amethyst = { label = "Amethyst", limit = 50, can_remove = true, useable = true, weight = 100 },
    jade = { label = "Jade", limit = 50, can_remove = true, useable = true, weight = 100 },
    borax = { label = "Borax", limit = 200, can_remove = true, useable = true, weight = 150 },
    aquamarine = { label = "Aquamarine", limit = 50, can_remove = true, useable = true, weight = 100 },
    spring = { label = "Spring", limit = 50, can_remove = true, useable = true, weight = 300 },
    firewood = { label = "Firewood", limit = 100, can_remove = true, useable = true, weight = 150 },
    minerhat = { label = "Miner Hat", limit = 10, can_remove = true, useable = true, weight = 150 },
    shovel = { label = "Shovel", limit = 10, can_remove = true, useable = true, weight = 3000 },
}

local function cloneDefinition(def)
    local out = {}
    for key, value in pairs(def or {}) do
        out[key] = value
    end
    return out
end

local function toVInventoryWeight(weight)
    local numericWeight = tonumber(weight) or 0
    if numericWeight > 20 then
        return numericWeight / 1000
    end
    return numericWeight
end

local function buildRuntimeItemSeed()
    if RuntimeItemSeed then
        return RuntimeItemSeed
    end

    local items = {}
    local parsedCount = 0
    local fallbackAdded = 0

    local contents = LoadResourceFile("mosquito-mining-blacksmithing", "items.sql") or ""
    for itemName, label, limit, canRemove, _itemType, usable, weight in contents:gmatch("%('([^']+)',%s*'([^']*)',%s*([%d%.]+),%s*([01]),%s*'([^']+)',%s*([01]),%s*([%d%.]+)%)") do
        if itemName ~= "forge" and itemName ~= "forge_advanced" then
            local numericWeight = tonumber(weight) or 0.0
            local rsgWeight = numericWeight <= 20.0 and math.floor((numericWeight * 1000.0) + 0.5) or math.floor(numericWeight)
            local numericLimit = tonumber(limit) or 0
            local isUsable = tostring(usable) == "1"

            items[itemName] = {
                name = itemName,
                label = label,
                weight = rsgWeight,
                type = "item",
                image = itemName .. ".png",
                unique = numericLimit == 1,
                useable = isUsable,
                usable = isUsable,
                shouldClose = true,
                limit = numericLimit,
                can_remove = tostring(canRemove) == "1",
                description = "Mosquito mining/blacksmithing item",
            }
            parsedCount = parsedCount + 1
        end
    end

    for itemName, fallback in pairs(FallbackMosquitoItems) do
        if items[itemName] == nil then
            local def = cloneDefinition(fallback)
            def.name = itemName
            def.type = "item"
            def.image = itemName .. ".png"
            def.unique = (tonumber(def.limit) or 0) == 1
            def.usable = def.useable
            def.shouldClose = true
            def.description = "Mosquito mining/blacksmithing item"
            items[itemName] = def
            fallbackAdded = fallbackAdded + 1
        end
    end

    for itemName, def in pairs(ForgeItems) do
        items[itemName] = cloneDefinition(def)
    end

    RuntimeItemSeedSource = ("sqlBytes=%s parsed=%s fallbackAdded=%s"):format(
        tostring(#contents),
        tostring(parsedCount),
        tostring(fallbackAdded)
    )
    RuntimeItemSeed = items
    return RuntimeItemSeed
end

local function seedForgeItems()
    local defs = getVInventoryDefinitions()
    if type(defs) ~= "table" then
        return false, "could not read v-inventory item table"
    end

    local seedItems = buildRuntimeItemSeed()
    local vSeeded = 0
    local rsgSeeded = 0
    local total = 0

    for name, def in pairs(seedItems) do
        total = total + 1
        if defs[name] == nil then
            local vDef = cloneDefinition(def)
            vDef.weight = toVInventoryWeight(vDef.weight)
            defs[name] = vDef
            vSeeded = vSeeded + 1
        end
    end

    local ok, core = pcall(function()
        return exports["rsg-core"]:GetCoreObject()
    end)

    if ok and core and core.Shared and type(core.Shared.Items) == "table" then
        for name, def in pairs(seedItems) do
            if core.Shared.Items[name] == nil then
                core.Shared.Items[name] = cloneDefinition(def)
                rsgSeeded = rsgSeeded + 1
            end
        end
    end

    return true, ("seeded mosquito items total=%s vAdded=%s rsgAdded=%s %s"):format(total, vSeeded, rsgSeeded, RuntimeItemSeedSource)
end

local function getDefinitionStatus(itemName)
    local defs = getVInventoryDefinitions()
    local def = type(defs) == "table" and defs[itemName] or nil
    if not def then
        def = buildRuntimeItemSeed()[itemName]
    end

    return def ~= nil, def
end

local function getRsgItemDefinition(itemName)
    local ok, core = pcall(function()
        return exports["rsg-core"]:GetCoreObject()
    end)

    if ok and core and core.Shared and type(core.Shared.Items) == "table" and core.Shared.Items[itemName] then
        return core.Shared.Items[itemName]
    end

    return buildRuntimeItemSeed()[itemName]
end

local function getVorpItemDefinition(itemName)
    local ok, def = pcall(function()
        return exports["vorp_inventory"]:getItemDB(itemName)
    end)

    if ok and type(def) == "table" then
        if def.name or def.label or def.weight then
            return def
        end

        return def[itemName]
    end

    return buildRuntimeItemSeed()[itemName]
end

local function boolText(value)
    return value and "true" or "false"
end

local getDiagnosticCounts

local function getItemDiagnosticLine(target, citizenId, itemName)
    local vHas, vDef = getDefinitionStatus(itemName)
    local rsgDef = getRsgItemDefinition(itemName)
    local vorpDef = getVorpItemDefinition(itemName)
    local bestDef = rsgDef or vDef or vorpDef or {}
    local useable = bestDef.useable
    if useable == nil then
        useable = bestDef.usable
    end

    return ("%s label=%s defs v/rsg/vorp=%s/%s/%s useable=%s weight=%s %s"):format(
        itemName,
        tostring(bestDef.label or "nil"),
        boolText(vHas),
        boolText(rsgDef ~= nil),
        boolText(vorpDef ~= nil),
        tostring(useable),
        tostring(bestDef.weight or "nil"),
        getDiagnosticCounts(target, citizenId, itemName)
    )
end

local function getExistingVInventoryItems(target, citizenId)
    local ok, items = pcall(function()
        return exports["v-inventory"]:GetInventory(target, "player", citizenId)
    end)

    if ok and type(items) == "table" then
        return items, "cache"
    end

    local row = MySQL.single.await("SELECT items FROM v_inventory WHERE identifier = ? AND type = ? LIMIT 1", {
        citizenId,
        "player"
    })

    if row and row.items and row.items ~= "" then
        local decodedOk, decoded = pcall(json.decode, row.items)
        if decodedOk and type(decoded) == "table" then
            return decoded, "db"
        end
    end

    return {}, "new"
end

local function persistVInventoryItems(target, citizenId, items)
    local jsonItems = json.encode(items or {})

    MySQL.update.await("INSERT INTO v_inventory (identifier, type, items) VALUES (?, ?, ?) ON DUPLICATE KEY UPDATE items = ?", {
        citizenId,
        "player",
        jsonItems,
        jsonItems
    })

    local ok, core = pcall(function()
        return exports["rsg-core"]:GetCoreObject()
    end)

    if ok and core then
        local player = core.Functions.GetPlayer(target)
        if player then
            player.Functions.SetPlayerData("items", items)
        end
    end

    TriggerClientEvent("v-inventory:client:ForceRefresh", target)
end

local function countItems(items, itemName)
    local count = 0

    for _, item in pairs(items or {}) do
        if type(item) == "table" then
            local name = item.name or item.item or item.itemName
            if name == itemName then
                count = count + (tonumber(item.amount or item.count or item.quantity or item.qty) or 0)
            end
        end
    end

    return count
end

getDiagnosticCounts = function(target, citizenId, itemName)
    local rsgOk, rsgCount = callInventory("rsg count", function()
        return exports["rsg-inventory"]:GetItemCount(target, itemName)
    end)

    local vorpOk, vorpCount = callInventory("vorp count", function()
        return exports["vorp_inventory"]:getItemCount(target, itemName)
    end)

    local vOk, vCount = callInventory("v count", function()
        return exports["v-inventory"]:GetItemCount(target, itemName)
    end)

    local directCount = 0
    local directSource = "none"

    if citizenId then
        local directItems, sourceLabel = getExistingVInventoryItems(target, citizenId)
        directCount = countItems(directItems, itemName)
        directSource = sourceLabel
    end

    local usable = false
    local okUsable, names = callInventory("v usable names", function()
        return exports["v-inventory"]:GetUsableItemNames()
    end)

    if okUsable and type(names) == "table" then
        for _, name in pairs(names) do
            if name == itemName then
                usable = true
                break
            end
        end
    end

    return ("counts rsg=%s%s vorp=%s%s v=%s%s direct=%s/%s usable=%s"):format(
        tostring(rsgCount),
        rsgOk and "" or "!",
        tostring(vorpCount),
        vorpOk and "" or "!",
        tostring(vCount),
        vOk and "" or "!",
        tostring(directCount),
        tostring(directSource),
        tostring(usable)
    )
end

local function directAddForgeItem(target, citizenId, itemName, amount)
    local def = ForgeItems[itemName]
    if not def then
        return false, "unknown direct item"
    end

    local items, sourceLabel = getExistingVInventoryItems(target, citizenId)
    local currentCount = 0
    local usedSlots = {}

    for _, item in pairs(items) do
        if type(item) == "table" then
            if item.name == itemName then
                currentCount = currentCount + (tonumber(item.amount) or 0)
            end
            if item.slot then
                usedSlots[tonumber(item.slot)] = true
            end
        end
    end

    if def.limit and currentCount >= def.limit then
        return true, ("already has %s in inventory (%s)"):format(itemName, sourceLabel)
    end

    local slot = 1
    while usedSlots[slot] do
        slot = slot + 1
    end

    local metadata = {}
    items[#items + 1] = {
        name = itemName,
        amount = amount,
        label = def.label,
        weight = def.weight,
        type = def.type,
        image = def.image,
        metadata = metadata,
        info = metadata,
        slot = slot,
        can_remove = def.can_remove
    }

    persistVInventoryItems(target, citizenId, items)

    return true, ("direct-added %s x%s to slot %s using %s inventory"):format(itemName, amount, slot, sourceLabel)
end

CreateThread(function()
    Wait(1500)
    local dbOk, dbMsg = ensureVorpCharactersTable()
    local synced = dbOk and syncOnlineVorpCharacters() or 0
    print(("[blacksmith_hotfix] version %s db compat: %s (%s) synced=%s"):format(
        HotfixVersion,
        dbOk and "ok" or "failed",
        dbMsg,
        synced
    ))

    Wait(3000)
    local ok, msg = seedForgeItems()
    print(("[blacksmith_hotfix] version %s startup seed: %s (%s)"):format(HotfixVersion, ok and "ok" or "failed", msg))
end)

CreateThread(function()
    Wait(15000)
    while true do
        seedForgeItems()
        ensureVorpCharactersTable()
        syncOnlineVorpCharacters()
        registerSafeForgeConditionCallback()
        Wait(60000)
    end
end)

exports("EnsureVorpCharacter", function(target)
    return ensureVorpCharacter(target)
end)

exports("EnsureVorpCharactersTable", function()
    return ensureVorpCharactersTable()
end)

RegisterCommand("bsseeditems", function(source)
    local ok, msg = seedForgeItems()
    local hasDef = getDefinitionStatus("blacksmith_forge")
    say(source, ("%s; blacksmith_forge def=%s framework=%s"):format(msg, tostring(hasDef), tostring(getVFramework())), ok and "success" or "error")
end, false)

RegisterCommand("bscheckitems", function(source, args)
    local target = source
    if args and args[1] and tonumber(args[1]) then
        target = tonumber(args[1])
    end

    if not target or target <= 0 then
        say(source, "usage from console: bscheckitems <playerId>", "error")
        return
    end

    local seeded, seedMsg = seedForgeItems()
    local citizenId = getRsgCitizenId(target)
    local itemsToCheck = {
        "wood",
        "firewood",
        "lumberaxe",
        "lumberaxe_steel",
        "pickaxe",
        "pickaxe_steel",
        "pickaxe_silver",
        "pickaxe_gold",
        "sharpeningstone",
        "shovel",
        "barmold",
        "blacksmithhammer",
        "hammer",
        "blacksmith_forge",
        "blacksmith_forge_advanced",
    }

    say(source, ("hotfix=%s target=%s citizenid=%s seed=%s (%s) states v=%s rsgInv=%s rsgCore=%s"):format(
        HotfixVersion,
        tostring(target),
        tostring(citizenId),
        tostring(seeded),
        tostring(seedMsg),
        GetResourceState("v-inventory"),
        GetResourceState("rsg-inventory"),
        GetResourceState("rsg-core")
    ), seeded and citizenId and "success" or "warning")

    for _, itemName in ipairs(itemsToCheck) do
        local line = getItemDiagnosticLine(target, citizenId, itemName)
        say(source, line, line:find("defs v/rsg/vorp=true/true/true", 1, true) and "success" or "warning")
    end
end, false)

RegisterCommand("bsdebuginv", function(source, args)
    local target = source
    if source == 0 then
        target = tonumber(args[1])
    end

    local itemName = args[source == 0 and 2 or 1] or "blacksmith_forge"
    seedForgeItems()

    local hasDef, def = getDefinitionStatus(itemName)
    local vIdentifier = target and getVIdentifier(target) or nil
    local rsgCitizenId = target and getRsgCitizenId(target) or nil
    local counts = target and getDiagnosticCounts(target, rsgCitizenId, itemName) or "counts unavailable"

    say(source, ("hotfix=%s target=%s item=%s def=%s weight=%s framework=%s vIdentifier=%s rsgCitizenId=%s states v=%s rsgInv=%s rsgCore=%s %s %s"):format(
        HotfixVersion,
        tostring(target),
        itemName,
        tostring(hasDef),
        def and tostring(def.weight) or "nil",
        tostring(getVFramework()),
        tostring(vIdentifier),
        tostring(rsgCitizenId),
        GetResourceState("v-inventory"),
        GetResourceState("rsg-inventory"),
        GetResourceState("rsg-core"),
        counts,
        getBridgeFileStatus()
    ), hasDef and "success" or "error")
end, false)

RegisterCommand("bscheckbridge", function(source)
    local status = getBridgeFileStatus()
    say(source, ("hotfix=%s %s"):format(HotfixVersion, status), status:find("retryPatch=true", 1, true) and "success" or "error")
end, false)

RegisterCommand("bsdbcompat", function(source, args)
    local target = source
    if source == 0 then
        target = tonumber(args[1])
    end

    local tableOk, tableMsg = ensureVorpCharactersTable()
    local charOk, charMsg = false, "no player target"
    if target and target > 0 then
        charOk, charMsg = ensureVorpCharacter(target)
    end

    say(source, ("hotfix=%s dbReady=%s table=%s char=%s target=%s msg=%s"):format(
        HotfixVersion,
        tostring(DbCompatReady),
        tostring(tableOk),
        tostring(charOk),
        tostring(target),
        tostring(charOk and charMsg or tableMsg .. "; " .. charMsg)
    ), tableOk and "success" or "error")
end, false)

RegisterCommand("bsforgebridge", function(source)
    ForgeBridgeStatusRequestId = ForgeBridgeStatusRequestId + 1
    local requestId = ("%s:%s"):format(tostring(source or 0), tostring(ForgeBridgeStatusRequestId))
    PendingForgeBridgeStatus[requestId] = {
        source = source
    }

    TriggerEvent("blacksmith_hotfix:mosquito:status", requestId)
    CreateThread(function()
        Wait(1000)
        if PendingForgeBridgeStatus[requestId] then
            PendingForgeBridgeStatus[requestId] = nil
            say(source, ("hotfix=%s mosquitoBridge responded=false handler=false command=nil commands=none"):format(
                HotfixVersion
            ), "error")
        end
    end)
end, false)

RegisterCommand("bsservercmds", function(source)
    local ok, commands = pcall(GetRegisteredCommands)
    local matches = {}

    if ok and type(commands) == "table" then
        for _, command in ipairs(commands) do
            if type(command) == "table" then
                local name = tostring(command.name or "")
                local lower = name:lower()
                if lower:find("forge", 1, true)
                    or lower:find("black", 1, true)
                    or lower:find("mine", 1, true)
                    or lower:find("place", 1, true) then
                    matches[#matches + 1] = name
                end
            end
        end
    end

    table.sort(matches)

    local vorpOk, core = pcall(function()
        return exports.vorp_core:GetCore()
    end)

    say(source, ("server commands=%s vorp_core_state=%s export=%s core=%s"):format(
        #matches > 0 and table.concat(matches, ", ") or "none",
        tostring(GetResourceState("vorp_core")),
        tostring(vorpOk),
        tostring(type(core))
    ), vorpOk and "success" or "error")
end, false)

RegisterCommand("placeforge", function(source, args)
    forwardPlaceForgeCommand(source, args)
end, false)

RegisterCommand("bsplaceforge", function(source, args)
    forwardPlaceForgeCommand(source, args)
end, false)

RegisterCommand("bsgiveforge", function(source, args)
    local target = source
    local itemName = args[1] or "blacksmith_forge"
    local amount = tonumber(args[2]) or 1

    if source == 0 then
        target = tonumber(args[1])
        itemName = args[2] or "blacksmith_forge"
        amount = tonumber(args[3]) or 1
    end

    if not target or target <= 0 then
        say(source, "usage from console: bsgiveforge <playerId> [item] [amount]", "error")
        return
    end

    if not ForgeItems[itemName] then
        say(source, ("unknown forge item: %s"):format(tostring(itemName)), "error")
        return
    end

    local seeded, seedMsg = seedForgeItems()
    local hasDef = getDefinitionStatus(itemName)
    local vIdentifier = getVIdentifier(target)
    local rsgCitizenId = getRsgCitizenId(target)

    say(source, ("precheck seed=%s def=%s framework=%s vIdentifier=%s rsgCitizenId=%s"):format(
        tostring(seeded),
        tostring(hasDef),
        tostring(getVFramework()),
        tostring(vIdentifier),
        tostring(rsgCitizenId)
    ), seeded and hasDef and "success" or "error")

    local ok, result, reason = callInventory("v-inventory normal", function()
        return exports["v-inventory"]:AddItem(target, itemName, amount, {})
    end)

    if ok and result == true then
        say(source, ("gave %s x%s through v-inventory"):format(itemName, amount), "success")
        TriggerClientEvent("v-inventory:client:ForceRefresh", target)
        return
    end

    local firstError = ("%s %s"):format(tostring(result), tostring(reason))

    if rsgCitizenId then
        ok, result, reason = callInventory("v-inventory citizenid", function()
            return exports["v-inventory"]:AddItem(target, itemName, amount, {}, "player", rsgCitizenId)
        end)

        if ok and result == true then
            say(source, ("gave %s x%s through v-inventory citizenid fallback"):format(itemName, amount), "success")
            TriggerClientEvent("v-inventory:client:ForceRefresh", target)
            return
        end

        firstError = ("%s; citizenid=%s %s"):format(firstError, tostring(result), tostring(reason))

        local directOk, directMsg = directAddForgeItem(target, rsgCitizenId, itemName, amount)
        if directOk then
            say(source, directMsg, "success")
            return
        end

        firstError = ("%s; direct=%s"):format(firstError, tostring(directMsg))
    end

    ok, result, reason = callInventory("rsg-inventory", function()
        return exports["rsg-inventory"]:AddItem(target, itemName, amount, nil, {})
    end)

    if ok and result == true then
        say(source, ("gave %s x%s through rsg-inventory"):format(itemName, amount), "success")
        TriggerClientEvent("v-inventory:client:ForceRefresh", target)
        return
    end

    say(source, ("failed %s. seed=%s v=%s rsg=%s %s"):format(itemName, seedMsg, firstError, tostring(result), tostring(reason)), "error")
end, false)
