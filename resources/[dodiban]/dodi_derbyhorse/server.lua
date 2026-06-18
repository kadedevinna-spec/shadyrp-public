--[[
  Derby Horse — server lobby system + player route CRUD + career (MySQL `derby_player_career`).
  Config.CatalogRoutes is shared — used to attach checkpoint previews to events.
  Player-created routes live in MySQL (`derby_player_routes`).
]]

local function trim(s)
    if type(s) ~= 'string' then return '' end
    return (s:gsub('^%s+', ''):gsub('%s+$', ''))
end

--- RSG Core: firstname + lastname; fallback Steam / FiveM name.
local function characterDisplayNameFromSrc(src)
    local ok, full = pcall(function()
        local RSGCore = exports['rsg-core']:GetCoreObject()
        local Player = RSGCore.Functions.GetPlayer(src)
        if not Player or not Player.PlayerData or not Player.PlayerData.charinfo then
            return nil
        end
        local ci = Player.PlayerData.charinfo
        local fn = trim(ci.firstname or '')
        local ln = trim(ci.lastname or '')
        local n = trim(fn .. ' ' .. ln)
        if n ~= '' then return n end
        return nil
    end)
    if ok and type(full) == 'string' and full ~= '' then
        return full
    end
    local steam = GetPlayerName(src)
    if type(steam) == 'string' and steam ~= '' then
        return steam
    end
    return 'Unknown'
end

--- RSG Core citizenid for DB career row; nil if offline / no character.
local function citizenIdFromSrc(src)
    local ok, cid = pcall(function()
        local RSGCore = exports['rsg-core']:GetCoreObject()
        local Player = RSGCore.Functions.GetPlayer(src)
        if not Player or not Player.PlayerData then
            return nil
        end
        local c = Player.PlayerData.citizenid
        if type(c) == 'string' and c ~= '' then
            return c
        end
        return nil
    end)
    if ok and type(cid) == 'string' and cid ~= '' then
        return cid
    end
    return nil
end

local function handicapTitleFromRep(rep)
    local r = math.floor(tonumber(rep) or 0)
    local titles = (Config.DerbyCareer and Config.DerbyCareer.handicapTitles) or {}
    local sorted = {}
    for _, row in ipairs(titles) do
        sorted[#sorted + 1] = row
    end
    table.sort(sorted, function(a, b)
        return (tonumber(a.minRep) or 0) < (tonumber(b.minRep) or 0)
    end)
    local best = 'Rookie'
    for _, row in ipairs(sorted) do
        if r >= (tonumber(row.minRep) or 0) and type(row.title) == 'string' and row.title ~= '' then
            best = row.title
        end
    end
    return best
end

local function careerProfileTable(profileKey)
    local c = Config.DerbyCareer or {}
    if profileKey == 'catalog' then
        return c.catalog or {}
    end
    return c.custom or {}
end

local function xpForPlaceFromProfile(prof, place)
    local xpByPlace = prof.xpByPlace
    if type(xpByPlace) ~= 'table' or #xpByPlace < 1 then
        return 0
    end
    local p = math.max(1, math.floor(tonumber(place) or 1))
    local i = math.min(p, #xpByPlace)
    return math.floor(tonumber(xpByPlace[i]) or 0)
end

--- IA não chama raceFinished; só entra no placar via host (`hostAiLeaderboard`). Conta quantos terminaram para o lugar real na carreira.
local function countAiFinishedForCareer(lobby)
    local n = 0
    local rows = lobby and lobby.aiLeaderboardRows
    if type(rows) ~= 'table' then
        return 0
    end
    for _, r in ipairs(rows) do
        if type(r) == 'table' and r.finished == true then
            n = n + 1
        end
    end
    return n
end

--- DB: auto-create table on first boot.
CreateThread(function()
    MySQL.Async.execute([[
        CREATE TABLE IF NOT EXISTS `derby_player_routes` (
            `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
            `route_key` VARCHAR(80) NOT NULL,
            `title` VARCHAR(120) NOT NULL DEFAULT 'Untitled',
            `description` VARCHAR(500) NOT NULL DEFAULT '',
            `region` VARCHAR(80) NOT NULL DEFAULT '',
            `surface` VARCHAR(80) NOT NULL DEFAULT '',
            `checkpoints` LONGTEXT NOT NULL,
            `closed_loop` TINYINT(1) NOT NULL DEFAULT 0,
            `min_players` INT UNSIGNED NOT NULL DEFAULT 2,
            `max_players` INT UNSIGNED NOT NULL DEFAULT 8,
            `created_by` VARCHAR(80) NOT NULL DEFAULT '',
            `created_by_citizenid` VARCHAR(64) NOT NULL DEFAULT '',
            `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
            PRIMARY KEY (`id`),
            UNIQUE KEY `uk_route_key` (`route_key`)
        ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
    ]], {}, function()
        print('^2[dodi_derbyhorse] derby_player_routes table ready.^7')
        MySQL.Async.fetchAll([[
            SELECT COLUMN_NAME FROM INFORMATION_SCHEMA.COLUMNS
            WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'derby_player_routes'
              AND COLUMN_NAME IN ('min_players', 'max_players', 'ai_enabled', 'ai_count', 'created_by_citizenid')
        ]], {}, function(cols)
            local has = {}
            for _, r in ipairs(cols or {}) do
                local cn = r.COLUMN_NAME or r.column_name
                if type(cn) == 'string' then
                    has[cn] = true
                end
            end
            local pending = {}
            if not has.min_players then
                pending[#pending + 1] = 'ADD COLUMN `min_players` INT UNSIGNED NOT NULL DEFAULT 2'
            end
            if not has.max_players then
                pending[#pending + 1] = 'ADD COLUMN `max_players` INT UNSIGNED NOT NULL DEFAULT 8'
            end
            if not has.ai_enabled then
                pending[#pending + 1] = 'ADD COLUMN `ai_enabled` TINYINT(1) NOT NULL DEFAULT 0'
            end
            if not has.ai_count then
                pending[#pending + 1] = 'ADD COLUMN `ai_count` INT UNSIGNED NOT NULL DEFAULT 0'
            end
            if not has.created_by_citizenid then
                pending[#pending + 1] = 'ADD COLUMN `created_by_citizenid` VARCHAR(64) NOT NULL DEFAULT \'\''
            end
            if #pending > 0 then
                local sql = 'ALTER TABLE `derby_player_routes` ' .. table.concat(pending, ', ')
                MySQL.Async.execute(sql, {}, function()
                    print('^2[dodi_derbyhorse] derby_player_routes columns migrated.^7')
                end)
            end
        end)
    end)
end)

local function careerDisplayNameForUpdate(src)
    if type(src) ~= 'number' then
        return ''
    end
    if not GetPlayerName(src) then
        return ''
    end
    local n = trim(characterDisplayNameFromSrc(src))
    if n == '' or n == 'Unknown' then
        return ''
    end
    if #n > 120 then
        n = n:sub(1, 120)
    end
    return n
end

CreateThread(function()
    MySQL.Async.execute([[
        CREATE TABLE IF NOT EXISTS `derby_player_career` (
            `citizenid` VARCHAR(64) NOT NULL,
            `wins` INT UNSIGNED NOT NULL DEFAULT 0,
            `starts` INT UNSIGNED NOT NULL DEFAULT 0,
            `reputation` INT NOT NULL DEFAULT 0,
            `display_name` VARCHAR(120) NOT NULL DEFAULT '',
            `updated_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
            PRIMARY KEY (`citizenid`)
        ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
    ]], {}, function()
        print('^2[dodi_derbyhorse] derby_player_career table ready.^7')
        MySQL.Async.fetchAll([[
            SELECT COLUMN_NAME FROM INFORMATION_SCHEMA.COLUMNS
            WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'derby_player_career'
              AND COLUMN_NAME = 'display_name'
        ]], {}, function(cols)
            if cols and cols[1] then
                return
            end
            MySQL.Async.execute(
                'ALTER TABLE `derby_player_career` ADD COLUMN `display_name` VARCHAR(120) NOT NULL DEFAULT \'\'',
                {},
                function()
                    print('^2[dodi_derbyhorse] derby_player_career.display_name column added.^7')
                end
            )
        end)
    end)
end)

--- CRUD helpers ---
local function routeIsOwnedBySrc(r, src)
    if not r or not src then
        return false
    end
    local myCid = citizenIdFromSrc(src)
    local myName = characterDisplayNameFromSrc(src)
    local rowCid = trim(tostring(r.created_by_citizenid or ''))
    local rowName = trim(tostring(r.created_by or ''))
    if rowCid ~= '' then
        return myCid ~= nil and myCid == rowCid
    end
    return myName ~= '' and rowName ~= '' and myName == rowName
end

local function allPlayerRoutes(cb, forSrc)
    MySQL.Async.fetchAll('SELECT * FROM `derby_player_routes` ORDER BY `id` DESC', {}, function(rows)
        local out = {}
        for _, r in ipairs(rows or {}) do
            local cps = json.decode(r.checkpoints) or {}
            out[#out + 1] = {
                id = 'pr-' .. r.id,
                dbId = r.id,
                routeKey = r.route_key,
                name = r.title,
                description = r.description,
                region = r.region,
                surface = r.surface,
                checkpoints = cps,
                closedLoop = r.closed_loop == 1,
                minPlayers = tonumber(r.min_players) or 2,
                maxPlayers = tonumber(r.max_players) or 8,
                aiEnabled = (tonumber(r.ai_enabled) or 0) == 1,
                aiCount = tonumber(r.ai_count) or 0,
                createdBy = r.created_by,
                isMine = forSrc ~= nil and routeIsOwnedBySrc(r, forSrc),
            }
        end
        cb(out)
    end)
end

local function insertPlayerRoute(data, cb)
    local key = data.routeKey or ('route_' .. os.time() .. '_' .. math.random(1000, 9999))
    local minp = math.max(1, math.min(32, math.floor(tonumber(data.minPlayers) or 2)))
    local maxp = math.max(1, math.min(32, math.floor(tonumber(data.maxPlayers) or 8)))
    if maxp < minp then maxp = minp end
    local aiOn = data.aiEnabled == true and 1 or 0
    local aiN = math.max(0, math.min(8, math.floor(tonumber(data.aiCount) or 0)))
    MySQL.Async.execute([[
        INSERT INTO `derby_player_routes`
            (`route_key`, `title`, `description`, `region`, `surface`, `checkpoints`, `closed_loop`, `min_players`, `max_players`, `ai_enabled`, `ai_count`, `created_by`, `created_by_citizenid`)
        VALUES (@key, @title, @desc, @region, @surface, @cps, @loop, @minp, @maxp, @aiOn, @aiN, @by, @cid)
    ]], {
        ['@key'] = key,
        ['@title'] = data.title or 'Untitled',
        ['@desc'] = data.description or '',
        ['@region'] = data.region or '',
        ['@surface'] = data.surface or '',
        ['@cps'] = json.encode(data.checkpoints or {}),
        ['@loop'] = data.closedLoop and 1 or 0,
        ['@minp'] = minp,
        ['@maxp'] = maxp,
        ['@aiOn'] = aiOn,
        ['@aiN'] = aiN,
        ['@by'] = data.createdBy or '',
        ['@cid'] = trim(tostring(data.createdByCitizenid or '')),
    }, function(rowsChanged)
        cb(rowsChanged and rowsChanged > 0)
    end)
end

local function deletePlayerRouteForSrc(src, dbId, cb)
    local id = tonumber(dbId) or 0
    if id < 1 then
        cb(false, 'invalid')
        return
    end
    MySQL.Async.fetchAll(
        'SELECT `created_by`, `created_by_citizenid` FROM `derby_player_routes` WHERE `id` = @id LIMIT 1',
        { ['@id'] = id },
        function(rows)
            local row = rows and rows[1]
            if not row then
                cb(false, 'not_found')
                return
            end
            if not routeIsOwnedBySrc(row, src) then
                cb(false, 'forbidden')
                return
            end
            MySQL.Async.execute('DELETE FROM `derby_player_routes` WHERE `id` = @id', { ['@id'] = id }, function(rowsChanged)
                cb(rowsChanged and rowsChanged > 0, nil)
            end)
        end
    )
end

--- Net events: player routes CRUD ---
RegisterNetEvent('dodi_derbyhorse:server:listPlayerRoutes', function()
    local src = source
    allPlayerRoutes(function(list)
        TriggerClientEvent('dodi_derbyhorse:client:pushPlayerRoutes', src, list)
    end, src)
end)

RegisterNetEvent('dodi_derbyhorse:server:savePlayerRoute', function(data)
    local src = source
    if type(data) ~= 'table' then
        TriggerClientEvent('dodi_derbyhorse:client:savePlayerRouteResult', src, { ok = false, message = DerbyLang('saveInvalidData') })
        return
    end
    data.createdBy = characterDisplayNameFromSrc(src)
    data.createdByCitizenid = citizenIdFromSrc(src) or ''
    insertPlayerRoute(data, function(ok)
        TriggerClientEvent('dodi_derbyhorse:client:savePlayerRouteResult', src, {
            ok = ok,
            message = ok and DerbyLang('saveRouteSaved') or DerbyLang('saveRouteFailed'),
        })
        if ok then
            allPlayerRoutes(function(list)
                TriggerClientEvent('dodi_derbyhorse:client:pushPlayerRoutes', src, list)
            end, src)
        end
    end)
end)

RegisterNetEvent('dodi_derbyhorse:server:deletePlayerRoute', function(dbId)
    local src = source
    deletePlayerRouteForSrc(src, dbId, function(ok, err)
        local message
        if not ok then
            if err == 'forbidden' then
                message = DerbyLang('deleteOwnOnly')
            elseif err == 'not_found' then
                message = DerbyLang('deleteNotFound')
            elseif err == 'invalid' then
                message = DerbyLang('deleteInvalid')
            end
        end
        TriggerClientEvent('dodi_derbyhorse:client:deletePlayerRouteResult', src, {
            ok = ok,
            dbId = dbId,
            message = message,
        })
        if ok then
            allPlayerRoutes(function(list)
                TriggerClientEvent('dodi_derbyhorse:client:pushPlayerRoutes', src, list)
            end, src)
        end
    end)
end)

local function catalogById(id)
    if type(id) ~= 'string' then
        return nil
    end
    local list = Config.CatalogRoutes or {}
    for _, r in ipairs(list) do
        if r.id == id then
            return r
        end
    end
    return nil
end

local function checkpointsForRoute(routeId)
    local r = catalogById(routeId)
    if r and type(r.checkpoints) == 'table' then
        return r.checkpoints
    end
    return {}
end

local function lobbyDefaults()
    local d = Config.DerbyLobby or {}
    return {
        minPlayers = tonumber(d.defaultMinPlayers) or 2,
        maxPlayers = tonumber(d.defaultMaxPlayers) or 8,
        readyTimeoutSec = tonumber(d.readyTimeoutSec) or 300,
        hostCanForceStart = d.hostCanForceStart ~= false,
    }
end

--- ══════════════════════════════════════════
---  Lobby state machine
--- ══════════════════════════════════════════
local activeLobbies = {}
local lobbyIdCounter = 0
local playerLobbyMap = {}

local function nextLobbyId()
    lobbyIdCounter = lobbyIdCounter + 1
    return 'lobby-' .. lobbyIdCounter .. '-' .. os.time()
end

local function countPlayers(lobby)
    local n = 0
    for _ in pairs(lobby.players) do n = n + 1 end
    return n
end

local function countReady(lobby)
    local n = 0
    for _, ready in pairs(lobby.players) do
        if ready then n = n + 1 end
    end
    return n
end

local function lobbyEffectiveAiCount(lobby)
    if not lobby then return 0 end
    local aiN = math.min(8, math.max(0, math.floor(tonumber(lobby.aiCount) or 0)))
    if lobby.aiEnabled ~= true then
        aiN = 0
    end
    return aiN
end

--- Career: 2+ humans always; 1 human + AI only if Config.DerbyCareer.awardCareerXpHumanVsAi; 1 human + 0 AI never.
local function derbyCareerRewardsEligible(lobby)
    if not lobby then return false end
    local humans = countPlayers(lobby)
    local aiN = lobbyEffectiveAiCount(lobby)
    local c = Config.DerbyCareer or {}
    if humans < 1 then
        return false
    end
    if humans == 1 and aiN == 0 then
        return false
    end
    if humans == 1 and aiN >= 1 then
        return c.awardCareerXpHumanVsAi ~= false
    end
    return humans >= 2
end

local function playerNamesInLobby(lobby)
    local names = {}
    for src, _ in pairs(lobby.players) do
        names[#names + 1] = characterDisplayNameFromSrc(src)
    end
    return names
end

local function lobbyToRaceCard(lobby)
    return {
        id = lobby.id,
        name = lobby.name,
        host = lobby.hostName,
        players = countPlayers(lobby),
        maxPlayers = lobby.maxPlayers,
        minPlayers = lobby.minPlayers,
        state = lobby.state == 'waiting' and 'lobby' or 'running',
        routeId = lobby.routeId,
        routeName = lobby.routeName or lobby.name,
        checkpoints = lobby.checkpoints,
        closedLoop = lobby.closedLoop,
        aiEnabled = lobby.aiEnabled,
        aiCount = lobby.aiCount,
        joinHint = 'Join and ride to the start line. Race begins when enough riders are ready.',
        gpsNote = 'Follow the GPS to the start. Checkpoints appear after GO.',
        playerNames = playerNamesInLobby(lobby),
        readyCount = countReady(lobby),
        isLobby = true,
    }
end

local function broadcastLobbyState(lobby)
    local card = lobbyToRaceCard(lobby)
    for src, _ in pairs(lobby.players) do
        TriggerClientEvent('dodi_derbyhorse:client:lobbyStateUpdate', src, card)
    end
end

local function broadcastRacesListToAll()
    local list = {}
    for _, lobby in pairs(activeLobbies) do
        list[#list + 1] = lobbyToRaceCard(lobby)
    end
    TriggerClientEvent('dodi_derbyhorse:client:pushRaces', -1, list)
end

--- +1 starts at race start; +wins / +rep when lobby closes (finish order + DNF).
local function settleDerbyCareer(lobby)
    if not lobby or lobby._careerSettled then
        return
    end
    if not lobby._careerSnapshot then
        return
    end
    lobby._careerSettled = true

    if lobby._careerSnapshot.rewardsEligible ~= true then
        return
    end

    local prof = careerProfileTable(lobby._careerSnapshot.profile or 'custom')
    local winBonus = math.floor(tonumber(prof.winBonusXp) or 0)
    local dnfXp = math.floor(tonumber(prof.dnfXp) or 0)

    local srcToCid = {}
    for _, r in ipairs(lobby._careerSnapshot.riders or {}) do
        if r.src and r.cid then
            srcToCid[r.src] = r.cid
        end
    end

    local finishedSrc = {}
    local order = lobby._finishOrder or {}
    local aiFinished = countAiFinishedForCareer(lobby)
    for humanPlace, row in ipairs(order) do
        local cid = row.src and srcToCid[row.src]
        if cid then
            finishedSrc[row.src] = true
            --- Client sends its combined position (humans+AI); use it when available and sane.
            local effectivePlace
            if row.clientPosition and row.clientPosition >= 1 then
                effectivePlace = row.clientPosition
            else
                effectivePlace = aiFinished + humanPlace
            end
            local xp = xpForPlaceFromProfile(prof, effectivePlace)
            if effectivePlace == 1 then
                xp = xp + winBonus
            end
            local w = (effectivePlace == 1) and 1 or 0
            if xp ~= 0 or w ~= 0 then
                local nm = careerDisplayNameForUpdate(row.src)
                MySQL.Async.execute([[
                    UPDATE `derby_player_career`
                    SET `wins` = `wins` + @w, `reputation` = `reputation` + @x,
                      `display_name` = IF(CHAR_LENGTH(TRIM(@n)) > 0, LEFT(TRIM(@n), 120), `display_name`)
                    WHERE `citizenid` = @c
                ]], { ['@w'] = w, ['@x'] = xp, ['@c'] = cid, ['@n'] = nm })
            end
        end
    end

    if dnfXp ~= 0 then
        for _, r in ipairs(lobby._careerSnapshot.riders or {}) do
            if r.cid and r.src and not finishedSrc[r.src] then
                local nm = careerDisplayNameForUpdate(r.src)
                MySQL.Async.execute(
                    'UPDATE `derby_player_career` SET `reputation` = `reputation` + @x, `display_name` = IF(CHAR_LENGTH(TRIM(@n)) > 0, LEFT(TRIM(@n), 120), `display_name`) WHERE `citizenid` = @c',
                    { ['@x'] = dnfXp, ['@c'] = r.cid, ['@n'] = nm }
                )
            end
        end
    end
end

--- Clear every player still tied to this lobby (incl. quem já cruzou a meta e saiu de `lobby.players`).
local function clearPlayerLobbyMapForLobby(lobbyId)
    local cleared = {}
    for src, mapped in pairs(playerLobbyMap) do
        if mapped == lobbyId then
            cleared[#cleared + 1] = src
        end
    end
    for _, src in ipairs(cleared) do
        playerLobbyMap[src] = nil
        TriggerClientEvent('dodi_derbyhorse:client:derbySessionEnded', src)
    end
end

local function removeLobby(lobbyId)
    local lobby = activeLobbies[lobbyId]
    if not lobby then return end
    settleDerbyCareer(lobby)
    clearPlayerLobbyMapForLobby(lobbyId)
    activeLobbies[lobbyId] = nil
    broadcastRacesListToAll()
end

local function broadcastRaceProgress(lobby)
    if not lobby or type(lobby.raceProgress) ~= 'table' then return end
    local snapshot = {}
    for sid, pdata in pairs(lobby.raceProgress) do
        snapshot[#snapshot + 1] = {
            serverId = sid,
            name = type(pdata.name) == 'string' and pdata.name or 'Rider',
            cp = tonumber(pdata.cp) or 0,
            dist = tonumber(pdata.dist) or 999999.0,
            finished = pdata.finished == true,
        }
    end
    table.sort(snapshot, function(a, b)
        return (a.serverId or 0) < (b.serverId or 0)
    end)
    local aiRows = type(lobby.aiLeaderboardRows) == 'table' and lobby.aiLeaderboardRows or {}
    for s, _ in pairs(lobby.players) do
        TriggerClientEvent('dodi_derbyhorse:client:raceLeaderboardPeers', s, snapshot, aiRows)
    end
end

local function removePlayerFromLobby(src, lobbyId)
    local lobby = activeLobbies[lobbyId]
    if not lobby then
        if playerLobbyMap[src] == lobbyId then
            playerLobbyMap[src] = nil
            TriggerClientEvent('dodi_derbyhorse:client:derbySessionEnded', src)
        end
        return
    end
    if lobby.raceProgress then
        lobby.raceProgress[src] = nil
    end
    lobby.players[src] = nil
    if countPlayers(lobby) < 1 then
        removeLobby(lobbyId)
        return
    end
    playerLobbyMap[src] = nil
    if lobby.hostSrc == src then
        for newHost, _ in pairs(lobby.players) do
            lobby.hostSrc = newHost
            lobby.hostName = characterDisplayNameFromSrc(newHost)
            break
        end
    end
    if lobby.raceProgress and countPlayers(lobby) > 0 then
        broadcastRaceProgress(lobby)
    end
    broadcastLobbyState(lobby)
    broadcastRacesListToAll()
end

--- Rep virtual por slot de IA (determinístico; todos os clients recebem o mesmo aiBackMs).
local function derbyAiVirtualReputation(lobbyId, aiSlotIndex)
    local s = tostring(lobbyId or '') .. '\0ai\0' .. tostring(aiSlotIndex or 0)
    local h = 5381
    for i = 1, #s do
        h = (h * 33 + string.byte(s, i)) % 2147483647
    end
    local dai = Config.DerbyAI or {}
    local lo = math.floor(tonumber(dai.startGridVirtualRepMin) or 0)
    local hi = math.floor(tonumber(dai.startGridVirtualRepMax) or 1500)
    if hi < lo then
        lo, hi = hi, lo
    end
    local span = hi - lo + 1
    if span < 1 then
        span = 1
    end
    return lo + (h % span)
end

local function derbyGateHalfWidthForStartGrid()
    local g = Config.DerbyGate or {}
    return math.max(0.35, tonumber(g.defaultHalfWidth) or 3.5)
end

--- rank 1..n → backM / lateral (m) ao longo do vetor direita do portão; mesma fórmula que o client.
local function derbyComputeCompactRowsLayout(n, halfW, playerLine, rowStagger, slotW, inset)
    local backs = {}
    local laterals = {}
    if n < 1 then
        return backs, laterals
    end
    halfW = math.max(0.35, halfW + 0.0)
    inset = math.max(0.0, inset + 0.0)
    slotW = math.max(0.35, slotW + 0.0)
    rowStagger = math.max(0.0, rowStagger + 0.0)
    playerLine = playerLine + 0.0
    local margin = math.min(inset, math.max(0.0, halfW - 0.08))
    local usable = 2.0 * (halfW - margin)
    if usable < slotW then
        usable = math.max(slotW, halfW * 0.5)
    end
    local cols = math.max(1, math.floor(usable / slotW))
    local cellW = usable / cols
    for rank = 1, n do
        local idx = rank - 1
        local row = math.floor(idx / cols)
        local col = idx % cols
        laterals[rank] = (-usable / 2) + (col + 0.5) * cellW
        backs[rank] = playerLine + row * rowStagger
    end
    return backs, laterals
end

local function fetchReputationsForLobbyPlayers(lobby)
    local rows = {}
    for src, _ in pairs(lobby.players) do
        local cid = citizenIdFromSrc(src)
        rows[#rows + 1] = { src = src, cid = cid, reputation = 0 }
    end
    local cids = {}
    for _, r in ipairs(rows) do
        if r.cid and r.cid ~= '' then
            cids[#cids + 1] = r.cid
        end
    end
    local repByCid = {}
    if #cids > 0 then
        local ph = {}
        local params = {}
        for i, cid in ipairs(cids) do
            local k = '@c' .. i
            ph[#ph + 1] = k
            params[k] = cid
        end
        local q = 'SELECT `citizenid`, `reputation` FROM `derby_player_career` WHERE `citizenid` IN (' .. table.concat(ph, ',') .. ')'
        local ok, dbRows = pcall(function()
            return MySQL.Sync.fetchAll(q, params)
        end)
        if ok and type(dbRows) == 'table' then
            for _, row in ipairs(dbRows) do
                local id = row.citizenid
                if type(id) == 'string' then
                    repByCid[id] = math.floor(tonumber(row.reputation) or 0)
                end
            end
        end
    end
    for _, r in ipairs(rows) do
        if r.cid and repByCid[r.cid] then
            r.reputation = repByCid[r.cid]
        end
    end
    return rows
end

--- Ordena humanos + IA pela mesma métrica (rep real vs virtual); menor backM = mais à frente.
local function buildReputationStartGrid(lobby, aiCount)
    local dr = Config.DerbyRace or {}
    if dr.reputationOrderedStartGrid ~= true or dr.randomizeStartGridDepth == false then
        return nil
    end
    local dai = Config.DerbyAI or {}
    local playerLine = tonumber(dr.startLineupBackM) or 7.5
    local stagger = tonumber(dai.depthStaggerM) or 2.25
    if stagger < 0.0 then
        stagger = 0.0
    end
    local rowStagger = tonumber(dr.startGridRowStaggerM)
    if rowStagger == nil then
        rowStagger = stagger
    else
        rowStagger = math.max(0.0, rowStagger + 0.0)
    end
    local compact = dr.startGridCompactRows == true
    local halfW = derbyGateHalfWidthForStartGrid()
    local slotW = tonumber(dr.startGridSlotWidthM) or 1.12
    local inset = tonumber(dr.startGridGateInsetM) or 0.55
    aiCount = math.min(8, math.max(0, math.floor(tonumber(aiCount) or 0)))
    local humans = fetchReputationsForLobbyPlayers(lobby)
    local entries = {}
    for _, h in ipairs(humans) do
        entries[#entries + 1] = { kind = 'h', src = h.src, rep = h.reputation, aiIdx = nil }
    end
    for a = 1, aiCount do
        entries[#entries + 1] = { kind = 'a', src = nil, rep = derbyAiVirtualReputation(lobby.id, a), aiIdx = a }
    end
    table.sort(entries, function(a, b)
        if a.rep ~= b.rep then
            return a.rep > b.rep
        end
        if a.kind ~= b.kind then
            return a.kind == 'h'
        end
        if a.kind == 'h' then
            return (a.src or 0) < (b.src or 0)
        end
        return (a.aiIdx or 0) < (b.aiIdx or 0)
    end)
    local n = #entries
    local playerBackBySrc = {}
    local playerLateralBySrc = {}
    local aiBackMs = {}
    local aiLateralMs = {}
    for i = 1, aiCount do
        aiBackMs[i] = playerLine
    end
    local backsByRank, latByRank
    if compact then
        backsByRank, latByRank = derbyComputeCompactRowsLayout(n, halfW, playerLine, rowStagger, slotW, inset)
    end
    for rank = 1, n do
        local e = entries[rank]
        local backM = playerLine + (rank - 1) * stagger
        local latM = 0.0
        if compact and backsByRank and latByRank then
            backM = backsByRank[rank] or backM
            latM = latByRank[rank] or 0.0
        end
        if e.kind == 'h' then
            playerBackBySrc[e.src] = backM
            if compact then
                playerLateralBySrc[e.src] = latM
            end
        elseif e.aiIdx then
            aiBackMs[e.aiIdx] = backM
            if compact then
                aiLateralMs[e.aiIdx] = latM
            end
        end
    end
    local out = {
        playerBackBySrc = playerBackBySrc,
        aiBackMs = aiBackMs,
        compactRows = compact,
    }
    if compact then
        out.playerLateralBySrc = playerLateralBySrc
        out.aiLateralMs = aiLateralMs
    end
    return out
end

local function triggerRaceGo(lobby)
    lobby.state = 'countdown'
    local countCfg = (Config.DerbyRace and tonumber(Config.DerbyRace.countdownSec)) or 5
    local aiN = math.min(8, math.max(0, math.floor(tonumber(lobby.aiCount) or 0)))
    if lobby.aiEnabled ~= true then
        aiN = 0
    end
    local startGrid = buildReputationStartGrid(lobby, aiN)
    local payload = {
        lobbyId = lobby.id,
        checkpoints = lobby.checkpoints,
        closedLoop = lobby.closedLoop,
        countdownSec = countCfg,
        aiEnabled = lobby.aiEnabled,
        aiCount = lobby.aiCount,
        hostSrc = lobby.hostSrc,
        playerCount = countPlayers(lobby),
        startGrid = startGrid,
    }
    lobby.raceProgress = {}
    lobby.aiLeaderboardRows = {}
    for src, _ in pairs(lobby.players) do
        TriggerClientEvent('dodi_derbyhorse:client:raceGo', src, payload)
    end
    broadcastRacesListToAll()
    CreateThread(function()
        Wait((countCfg + 5) * 1000)
        if activeLobbies[lobby.id] and lobby.state == 'countdown' then
            lobby.state = 'racing'
            --- Career: one "start" per rider (only if rewards eligible); snapshot for settle (finish / DNF).
            local rewardsEligible = derbyCareerRewardsEligible(lobby)
            local riders = {}
            for s, _ in pairs(lobby.players) do
                local cid = citizenIdFromSrc(s)
                if cid then
                    riders[#riders + 1] = { src = s, cid = cid }
                    if rewardsEligible then
                        local disp = trim(characterDisplayNameFromSrc(s))
                        if #disp > 120 then
                            disp = disp:sub(1, 120)
                        end
                        MySQL.Async.execute([[
                            INSERT INTO `derby_player_career` (`citizenid`, `wins`, `starts`, `reputation`, `display_name`)
                            VALUES (@c, 0, 1, 0, @n)
                            ON DUPLICATE KEY UPDATE `starts` = `starts` + 1,
                              `display_name` = IF(CHAR_LENGTH(TRIM(@n)) > 0, LEFT(TRIM(@n), 120), `display_name`)
                        ]], { ['@c'] = cid, ['@n'] = disp })
                    end
                end
            end
            lobby._careerSnapshot = {
                profile = lobby.careerXpProfile or 'custom',
                riders = riders,
                rewardsEligible = rewardsEligible,
            }
            lobby._careerSettled = false
            lobby._finishOrder = {}
            lobby._finishTimerStarted = false
        end
        Wait(600000)
        if activeLobbies[lobby.id] then
            removeLobby(lobby.id)
        end
    end)
end

local function checkAutoStart(lobby)
    if lobby.state ~= 'waiting' then return end
    local ready = countReady(lobby)
    if ready >= lobby.minPlayers then
        triggerRaceGo(lobby)
    end
end

local function findLobbyForRoute(routeId, stateFilter)
    if type(routeId) ~= 'string' or routeId == '' then return nil end
    for _, lobby in pairs(activeLobbies) do
        if lobby.routeId == routeId then
            if stateFilter == nil or lobby.state == stateFilter then
                return lobby
            end
        end
    end
    return nil
end

--- Create lobby (or auto-join existing for same route) ---
RegisterNetEvent('dodi_derbyhorse:server:createLobby', function(data)
    local src = source
    if type(data) ~= 'table' then return end
    if playerLobbyMap[src] then
        TriggerClientEvent('dodi_derbyhorse:client:lobbyError', src, DerbyLang('errAlreadyInRaceSession'))
        return
    end

    local routeId = data.routeId

    local anyActive = findLobbyForRoute(routeId)
    if anyActive then
        if anyActive.state == 'waiting' and countPlayers(anyActive) < anyActive.maxPlayers then
            anyActive.players[src] = false
            playerLobbyMap[src] = anyActive.id
            TriggerClientEvent('dodi_derbyhorse:client:joinResult', src, {
                ok = true,
                lobbyId = anyActive.id,
                raceId = anyActive.id,
                routeId = anyActive.routeId,
                checkpoints = anyActive.checkpoints,
                closedLoop = anyActive.closedLoop,
                message = DerbyLang('errJoinedExistingRide'),
            })
            broadcastLobbyState(anyActive)
            broadcastRacesListToAll()
            return
        end
        TriggerClientEvent('dodi_derbyhorse:client:lobbyError', src, DerbyLang('errRaceActiveOnRoute'))
        return
    end

    local defs = lobbyDefaults()
    local cps = {}
    local routeName = data.name or 'Custom Race'
    local closedLoop = data.closedLoop == true
    local catRoute = routeId and catalogById(routeId) or nil

    if catRoute then
        cps = catRoute.checkpoints or {}
        routeName = catRoute.name or routeName
        closedLoop = catRoute.closedLoop == true
    elseif type(data.checkpoints) == 'table' then
        cps = data.checkpoints
    end

    if #cps < 2 then
        TriggerClientEvent('dodi_derbyhorse:client:lobbyError', src, DerbyLang('errRouteNeedsTwoCps'))
        return
    end

    local id = nextLobbyId()
    local lobby = {
        id = id,
        routeId = routeId,
        routeName = routeName,
        name = data.name or routeName,
        checkpoints = cps,
        closedLoop = closedLoop,
        hostSrc = src,
        hostName = characterDisplayNameFromSrc(src),
        minPlayers = tonumber(data.minPlayers) or (catRoute and tonumber(catRoute.minPlayers)) or defs.minPlayers,
        maxPlayers = tonumber(data.maxPlayers) or (catRoute and tonumber(catRoute.maxPlayers)) or defs.maxPlayers,
        aiEnabled = data.aiEnabled ~= nil and data.aiEnabled or (catRoute and catRoute.aiEnabled) or false,
        aiCount = tonumber(data.aiCount) or (catRoute and tonumber(catRoute.aiCount)) or 0,
        players = { [src] = false },
        state = 'waiting',
        createdAt = os.time(),
        --- Config.DerbyCareer: catalog = official programme; custom = player routes / ad-hoc.
        careerXpProfile = catRoute and 'catalog' or 'custom',
    }
    activeLobbies[id] = lobby
    playerLobbyMap[src] = id

    TriggerClientEvent('dodi_derbyhorse:client:lobbyCreated', src, {
        ok = true,
        lobbyId = id,
        checkpoints = cps,
        closedLoop = closedLoop,
        message = DerbyLang('lobbyCreatedRide'),
    })
    broadcastLobbyState(lobby)
    broadcastRacesListToAll()

    if defs.readyTimeoutSec > 0 then
        CreateThread(function()
            Wait(defs.readyTimeoutSec * 1000)
            if activeLobbies[id] and lobby.state == 'waiting' then
                for s, _ in pairs(lobby.players) do
                    TriggerClientEvent('dodi_derbyhorse:client:lobbyError', s, DerbyLang('errLobbyTimeout'))
                end
                removeLobby(id)
            end
        end)
    end
end)

--- Join lobby ---
RegisterNetEvent('dodi_derbyhorse:server:joinLobby', function(lobbyId)
    local src = source
    if type(lobbyId) ~= 'string' then return end
    if playerLobbyMap[src] then
        TriggerClientEvent('dodi_derbyhorse:client:lobbyError', src, DerbyLang('errAlreadyInRaceSession'))
        return
    end
    local lobby = activeLobbies[lobbyId]
    if not lobby then
        TriggerClientEvent('dodi_derbyhorse:client:lobbyError', src, DerbyLang('errLobbyNotFound'))
        return
    end
    if lobby.state ~= 'waiting' then
        TriggerClientEvent('dodi_derbyhorse:client:lobbyError', src, DerbyLang('errRaceAlreadyStarted'))
        return
    end
    if countPlayers(lobby) >= lobby.maxPlayers then
        TriggerClientEvent('dodi_derbyhorse:client:lobbyError', src, DerbyLang('errLobbyFull'))
        return
    end
    lobby.players[src] = false
    playerLobbyMap[src] = lobbyId

    TriggerClientEvent('dodi_derbyhorse:client:joinResult', src, {
        ok = true,
        lobbyId = lobbyId,
        raceId = lobbyId,
        routeId = lobby.routeId,
        checkpoints = lobby.checkpoints,
        closedLoop = lobby.closedLoop,
        message = DerbyLang('onCardFollowGps'),
    })
    broadcastLobbyState(lobby)
    broadcastRacesListToAll()
end)

--- Leave lobby ---
RegisterNetEvent('dodi_derbyhorse:server:leaveLobby', function()
    local src = source
    local lobbyId = playerLobbyMap[src]
    if not lobbyId then return end
    removePlayerFromLobby(src, lobbyId)
    TriggerClientEvent('dodi_derbyhorse:client:lobbyLeft', src)
end)

--- Player ready (arrived at start line) ---
RegisterNetEvent('dodi_derbyhorse:server:playerReady', function(lobbyId)
    local src = source
    if type(lobbyId) ~= 'string' then return end
    local lobby = activeLobbies[lobbyId]
    if not lobby or lobby.players[src] == nil then return end
    if lobby.state ~= 'waiting' then return end
    lobby.players[src] = true
    broadcastLobbyState(lobby)
    checkAutoStart(lobby)
end)

--- Host force start ---
RegisterNetEvent('dodi_derbyhorse:server:hostForceStart', function(lobbyId)
    local src = source
    if type(lobbyId) ~= 'string' then return end
    local defs = lobbyDefaults()
    if not defs.hostCanForceStart then return end
    local lobby = activeLobbies[lobbyId]
    if not lobby then return end
    if lobby.hostSrc ~= src then return end
    if lobby.state ~= 'waiting' then return end
    triggerRaceGo(lobby)
end)

local FINISH_TIMER_SEC = (Config.DerbyLobby and tonumber(Config.DerbyLobby.finishTimerSec)) or 30

--- Countdown + fecho do lobby quando alguém cruza a meta primeiro. IA não chama `raceFinished` — o host manda `hostAiLeaderboard`.
local function startDerbyFinishCountdown(lobby, winnerDisplayName)
    if not lobby or lobby._finishTimerStarted then
        return
    end
    lobby._finishTimerStarted = true
    local w = type(winnerDisplayName) == 'string' and trim(winnerDisplayName) ~= '' and winnerDisplayName or 'Leader'
    for s, _ in pairs(lobby.players) do
        TriggerClientEvent('dodi_derbyhorse:client:finishTimer', s, {
            action = 'start',
            seconds = FINISH_TIMER_SEC,
            winner = w,
        })
    end
    local lobbyId = lobby.id
    CreateThread(function()
        Wait((FINISH_TIMER_SEC + 5) * 1000)
        local lb = activeLobbies[lobbyId]
        if lb then
            for s, mapped in pairs(playerLobbyMap) do
                if mapped == lobbyId then
                    TriggerClientEvent('dodi_derbyhorse:client:finishTimer', s, { action = 'stop' })
                end
            end
            removeLobby(lobbyId)
        end
    end)
end

--- AI net IDs from host ---
RegisterNetEvent('dodi_derbyhorse:server:aiNetIds', function(lobbyId, netIds)
    local src = source
    if type(lobbyId) ~= 'string' or type(netIds) ~= 'table' then return end
    local lobby = activeLobbies[lobbyId]
    if not lobby then return end
    if lobby.hostSrc ~= src then return end
    lobby.aiNetIds = netIds
    for s, _ in pairs(lobby.players) do
        if s ~= src then
            TriggerClientEvent('dodi_derbyhorse:client:aiSpawned', s, netIds)
        end
    end
end)

--- Host-only: AI placar (outros clients não têm derbyAiOpponents).
RegisterNetEvent('dodi_derbyhorse:server:hostAiLeaderboard', function(lobbyId, rows)
    local src = source
    if type(lobbyId) ~= 'string' or type(rows) ~= 'table' then return end
    local lobby = activeLobbies[lobbyId]
    if not lobby or lobby.players[src] == nil then return end
    if lobby.hostSrc ~= src then return end
    local clean = {}
    for i = 1, math.min(#rows, 24) do
        local r = rows[i]
        if type(r) == 'table' then
            clean[#clean + 1] = {
                idx = math.floor(tonumber(r.idx) or i),
                cp = math.floor(tonumber(r.cp) or 0),
                dist = tonumber(r.dist) or 999999.0,
                finished = r.finished == true,
            }
        end
    end
    lobby.aiLeaderboardRows = clean
    broadcastRaceProgress(lobby)
    --- `countdown` só até largada; incluído por segurança se o estado ficar desfasado.
    if lobby.state == 'racing' or lobby.state == 'countdown' then
        for _, r in ipairs(clean) do
            if r.finished == true then
                local aiWinnerName = 'Um rival'
                local cfgN = Config.DerbyLobby and Config.DerbyLobby.aiFirstFinishWinnerName
                if type(cfgN) == 'string' and trim(cfgN) ~= '' then
                    aiWinnerName = cfgN
                end
                startDerbyFinishCountdown(lobby, aiWinnerName)
                break
            end
        end
    end
end)

RegisterNetEvent('dodi_derbyhorse:server:raceProgress', function(lobbyId, cpIndex, distToNext, finished)
    local src = source
    if type(lobbyId) ~= 'string' then return end
    local lobby = activeLobbies[lobbyId]
    if not lobby or lobby.players[src] == nil then return end
    lobby.raceProgress = lobby.raceProgress or {}
    lobby.raceProgress[src] = {
        name = characterDisplayNameFromSrc(src),
        cp = math.floor(tonumber(cpIndex) or 0),
        dist = tonumber(distToNext) or 999999.0,
        finished = finished == true,
    }
    broadcastRaceProgress(lobby)
end)

--- Race finished notification (any player) ---
RegisterNetEvent('dodi_derbyhorse:server:raceFinished', function(lobbyId, clientPosition, clientTotalRiders)
    local src = source
    if type(lobbyId) ~= 'string' then return end
    local lid = playerLobbyMap[src]
    if lid ~= lobbyId then return end
    local lobby = activeLobbies[lobbyId]
    if not lobby then return end
    local ncp = #(lobby.checkpoints or {})
    lobby.raceProgress = lobby.raceProgress or {}
    lobby.raceProgress[src] = {
        name = characterDisplayNameFromSrc(src),
        cp = math.max(ncp, 1),
        dist = 0.0,
        finished = true,
    }
    --- Keep playerLobbyMap until the lobby closes — otherwise the player could create another race while this one is still active.
    lobby.players[src] = nil
    broadcastRaceProgress(lobby)

    if not lobby._finishOrder then
        lobby._finishOrder = {}
    end
    local clPos = tonumber(clientPosition) or 0
    if clPos < 1 then clPos = 0 end
    lobby._finishOrder[#lobby._finishOrder + 1] = {
        src = src,
        name = characterDisplayNameFromSrc(src),
        position = #lobby._finishOrder + 1,
        clientPosition = clPos,
        clientTotalRiders = tonumber(clientTotalRiders) or 0,
    }

    local remaining = countPlayers(lobby)
    if remaining < 1 then
        removeLobby(lobbyId)
        return
    end

    if #lobby._finishOrder == 1 then
        startDerbyFinishCountdown(lobby, lobby._finishOrder[1].name)
    end
end)

--- Request races (NUI opens) ---
RegisterNetEvent('dodi_derbyhorse:server:requestRaces', function()
    local src = source
    local list = {}
    for _, lobby in pairs(activeLobbies) do
        list[#list + 1] = lobbyToRaceCard(lobby)
    end
    TriggerClientEvent('dodi_derbyhorse:client:pushRaces', src, list)
end)

RegisterNetEvent('dodi_derbyhorse:server:requestHallOfFame', function()
    local src = source
    local lim = math.floor(tonumber(Config.DerbyHallOfFame and Config.DerbyHallOfFame.topCount) or 25)
    lim = math.max(5, math.min(100, lim))
    MySQL.Async.fetchAll(
        'SELECT `citizenid`, `display_name`, `wins`, `starts`, `reputation` FROM `derby_player_career` ORDER BY `reputation` DESC, `wins` DESC, `starts` ASC LIMIT '
            .. lim,
        {},
        function(rows)
            local entries = {}
            for i, row in ipairs(rows or {}) do
                local rep = math.floor(tonumber(row.reputation) or 0)
                local dn = trim(tostring(row.display_name or ''))
                if dn == '' then
                    dn = 'Rider'
                end
                entries[#entries + 1] = {
                    rank = i,
                    displayName = dn,
                    wins = math.floor(tonumber(row.wins) or 0),
                    starts = math.floor(tonumber(row.starts) or 0),
                    reputation = rep,
                    title = handicapTitleFromRep(rep),
                }
            end
            TriggerClientEvent('dodi_derbyhorse:client:pushHallOfFame', src, { entries = entries })
        end
    )
end)

RegisterNetEvent('dodi_derbyhorse:server:requestCareer', function()
    local src = source
    local cid = citizenIdFromSrc(src)
    local displayName = characterDisplayNameFromSrc(src)
    if not cid then
        TriggerClientEvent('dodi_derbyhorse:client:pushCareer', src, {
            displayName = displayName,
            wins = 0,
            entries = 0,
            title = 'Rookie',
            reputation = 0,
        })
        return
    end
    MySQL.Async.fetchAll(
        'SELECT `wins`, `starts`, `reputation` FROM `derby_player_career` WHERE `citizenid` = @c LIMIT 1',
        { ['@c'] = cid },
        function(rows)
            local row = rows and rows[1]
            local wins = row and math.floor(tonumber(row.wins) or 0) or 0
            local starts = row and math.floor(tonumber(row.starts) or 0) or 0
            local rep = row and math.floor(tonumber(row.reputation) or 0) or 0
            TriggerClientEvent('dodi_derbyhorse:client:pushCareer', src, {
                displayName = displayName,
                wins = wins,
                entries = starts,
                title = handicapTitleFromRep(rep),
                reputation = rep,
            })
        end
    )
end)

--- Cleanup on player drop ---
AddEventHandler('playerDropped', function()
    local src = source
    local lobbyId = playerLobbyMap[src]
    if lobbyId then
        removePlayerFromLobby(src, lobbyId)
    end
end)
