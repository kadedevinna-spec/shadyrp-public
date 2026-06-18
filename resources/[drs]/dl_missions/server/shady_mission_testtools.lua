local function testToolsEnabled()
    return Config.ShadyMissionTestTools and Config.ShadyMissionTestTools.enabled == true
end

local function permissionRequired()
    local tools = Config.ShadyMissionTestTools or {}
    return tools.requireAdmin ~= false
end

local function groupAllowed(source)
    if not permissionRequired() then
        return true
    end

    if source <= 0 then
        return true
    end

    local commandName = Config.ShadyMissionTestTools and Config.ShadyMissionTestTools.command or 'missionreset'

    if IsPlayerAceAllowed(source, 'dl_missions.testtools') or IsPlayerAceAllowed(source, ('command.%s'):format(commandName)) then
        return true
    end

    local group = getPlayerGroup(source)
    local allowedGroups = Config.ShadyMissionTestTools and Config.ShadyMissionTestTools.allowedGroups or Config.AdminGroups or {}

    for _, allowedGroup in ipairs(allowedGroups) do
        if group == allowedGroup then
            return true
        end
    end

    return false
end

local function notify(source, message)
    if source <= 0 then
        print(('[dl_missions][testtools] %s'):format(message))
        return
    end

    TriggerClientEvent('ox_lib:notify', source, {
        title = 'Mission Test',
        description = message,
        type = 'inform'
    })
end

local function getOwnerId(source)
    local character = getPlayerCharacter(source)
    return getCharacterIdentifier(character)
end

local function execute(query, params)
    return exports.oxmysql:executeSync(query, params or {})
end

local function scalar(query, params)
    local rows = execute(query, params)

    if rows and rows[1] then
        return tonumber(rows[1].count) or 0
    end

    return 0
end

local function clearConfiguredItems(ownerId, missionRef)
    local clearQuestItems = Config.ShadyMissionTestTools and Config.ShadyMissionTestTools.clearQuestItems or {}
    local items = clearQuestItems[missionRef]

    if type(items) ~= 'table' then
        return
    end

    for _, itemName in ipairs(items) do
        execute('DELETE FROM character_mission_items WHERE owner_id = ? AND item = ?', { ownerId, itemName })
    end
end

local function clearBlackwaterItems(ownerId)
    clearConfiguredItems(ownerId, 'blackwater_ledger_intro')
    clearConfiguredItems(ownerId, 'blackwater_ledger_law')
    clearConfiguredItems(ownerId, 'blackwater_ledger_outlaw')
end

local function resetMissionById(requestSource, targetSource, missionId)
    if not testToolsEnabled() then
        return false, 'Mission test tools are disabled.'
    end

    if not groupAllowed(requestSource) then
        return false, 'Access denied.'
    end

    local ownerId = getOwnerId(targetSource)

    if not ownerId then
        return false, 'Could not resolve your character id.'
    end

    local rows = execute('SELECT id, configRef FROM character_missions WHERE id = ? AND owner_id = ? LIMIT 1', { missionId, ownerId })
    local mission = rows and rows[1]

    if not mission then
        return false, 'Mission row was not found for your character.'
    end

    execute('DELETE FROM character_mission_tasks WHERE mission_id = ?', { mission.id })
    execute('DELETE FROM character_missions WHERE id = ? AND owner_id = ?', { mission.id, ownerId })
    execute('DELETE FROM character_mission_completed WHERE owner_id = ? AND missionRef = ?', { ownerId, mission.configRef })
    clearConfiguredItems(ownerId, mission.configRef)

    return true, ('Reset mission: %s'):format(mission.configRef)
end

local function resetBlackwaterLedger(requestSource, targetSource)
    if not testToolsEnabled() then
        return false, 'Mission test tools are disabled.'
    end

    if not groupAllowed(requestSource) then
        return false, 'Access denied.'
    end

    local ownerId = getOwnerId(targetSource)

    if not ownerId then
        return false, 'Could not resolve your character id.'
    end

    local activeCount = scalar("SELECT COUNT(*) as count FROM character_missions WHERE owner_id = ? AND configRef LIKE 'blackwater_ledger%'", { ownerId })
    local completedCount = scalar("SELECT COUNT(*) as count FROM character_mission_completed WHERE owner_id = ? AND missionRef LIKE 'blackwater_ledger%'", { ownerId })
    local itemCount = scalar("SELECT COUNT(*) as count FROM character_mission_items WHERE owner_id = ? AND item = ?", { ownerId, 'sealed_ledger' })

    execute([[
        DELETE t FROM character_mission_tasks t
        INNER JOIN character_missions m ON m.id = t.mission_id
        WHERE m.owner_id = ? AND m.configRef LIKE 'blackwater_ledger%'
    ]], { ownerId })
    execute("DELETE FROM character_missions WHERE owner_id = ? AND configRef LIKE 'blackwater_ledger%'", { ownerId })
    execute("DELETE FROM character_mission_completed WHERE owner_id = ? AND missionRef LIKE 'blackwater_ledger%'", { ownerId })
    execute('DELETE FROM character_mission_items WHERE owner_id = ? AND item = ?', { ownerId, 'sealed_ledger' })
    clearBlackwaterItems(ownerId)

    return true, ('Reset Blackwater Ledger. Active: %s, completed: %s, items: %s. Reopen /myMissions after reset.'):format(activeCount, completedCount, itemCount)
end

local function resetMissionByName(requestSource, targetSource, missionRef)
    if not testToolsEnabled() then
        return false, 'Mission test tools are disabled.'
    end

    if not groupAllowed(requestSource) then
        return false, 'Access denied.'
    end

    if not missionRef or missionRef == '' then
        return false, 'Usage: /missionreset mission_config_name or /missionreset blackwater'
    end

    missionRef = string.lower(missionRef)

    if missionRef == 'blackwater' or missionRef == 'blackwater_ledger' then
        return resetBlackwaterLedger(requestSource, targetSource)
    end

    local ownerId = getOwnerId(targetSource)

    if not ownerId then
        return false, 'Could not resolve your character id.'
    end

    execute([[
        DELETE t FROM character_mission_tasks t
        INNER JOIN character_missions m ON m.id = t.mission_id
        WHERE m.owner_id = ? AND m.configRef = ?
    ]], { ownerId, missionRef })
    execute('DELETE FROM character_missions WHERE owner_id = ? AND configRef = ?', { ownerId, missionRef })
    execute('DELETE FROM character_mission_completed WHERE owner_id = ? AND missionRef = ?', { ownerId, missionRef })
    clearConfiguredItems(ownerId, missionRef)

    return true, ('Reset mission: %s'):format(missionRef)
end

local function debugBlackwater(requestSource, targetSource)
    if not testToolsEnabled() then
        return false, 'Mission test tools are disabled.'
    end

    if not groupAllowed(requestSource) then
        return false, 'Access denied.'
    end

    local ownerId = getOwnerId(targetSource)

    if not ownerId then
        return false, 'Could not resolve your character id.'
    end

    local activeRows = execute("SELECT configRef, status FROM character_missions WHERE owner_id = ? AND configRef LIKE 'blackwater_ledger%' ORDER BY configRef", { ownerId })
    local taskRows = execute([[
        SELECT m.configRef as missionRef, t.configRef as taskRef, t.status, t.progress
        FROM character_mission_tasks t
        INNER JOIN character_missions m ON m.id = t.mission_id
        WHERE m.owner_id = ? AND m.configRef LIKE 'blackwater_ledger%'
        ORDER BY m.configRef, t.id
    ]], { ownerId })
    local completedCount = scalar("SELECT COUNT(*) as count FROM character_mission_completed WHERE owner_id = ? AND missionRef LIKE 'blackwater_ledger%'", { ownerId })
    local itemCount = scalar("SELECT COUNT(*) as count FROM character_mission_items WHERE owner_id = ? AND item = ?", { ownerId, 'sealed_ledger' })
    local activeParts = {}
    local taskParts = {}

    for _, row in ipairs(activeRows or {}) do
        activeParts[#activeParts + 1] = ('%s:%s'):format(row.configRef, row.status)
    end

    for _, row in ipairs(taskRows or {}) do
        taskParts[#taskParts + 1] = ('%s/%s status:%s progress:%s'):format(row.missionRef, row.taskRef, row.status, row.progress)
    end

    local activeText = #activeParts > 0 and table.concat(activeParts, ', ') or 'none'
    local taskText = #taskParts > 0 and table.concat(taskParts, ' | ') or 'none'
    local message = ('Blackwater debug - owner: %s, active: %s, completed: %s, sealed ledger items: %s, tasks: %s'):format(ownerId, activeText, completedCount, itemCount, taskText)

    print(('[dl_missions][testtools] %s'):format(message))

    return true, message
end

RegisterNetEvent('dl_missions:server:shadyResetMissionById', function(missionId)
    local source = source
    local ok, message = resetMissionById(source, source, tonumber(missionId))
    notify(source, message)

    if not ok then
        print(('[dl_missions][testtools] Reset failed for source %s: %s'):format(source, message))
    end
end)

CreateThread(function()
    Wait(1000)

    if not testToolsEnabled() then
        return
    end

    local commandName = Config.ShadyMissionTestTools.command or 'missionreset'

    RegisterCommand(commandName, function(source, args)
        local targetSource = source
        local missionRef = args and args[1]

        if source <= 0 then
            targetSource = tonumber(args and args[1])
            missionRef = args and args[2]

            if not targetSource or not missionRef then
                notify(source, ('Console usage: %s player_source mission_config_name'):format(commandName))
                return
            end
        end

        local ok, message = resetMissionByName(source, targetSource, missionRef)
        notify(source, message)

        if not ok then
            print(('[dl_missions][testtools] Reset failed for source %s targeting %s: %s'):format(source, targetSource, message))
        end
    end, false)

    RegisterCommand('missiondebug', function(source, args)
        local targetSource = source
        local subject = args and args[1]

        if source <= 0 then
            targetSource = tonumber(args and args[1])
            subject = args and args[2]

            if not targetSource or not subject then
                notify(source, 'Console usage: missiondebug player_source blackwater')
                return
            end
        end

        if subject ~= 'blackwater' and subject ~= 'blackwater_ledger' then
            notify(source, 'Usage: /missiondebug blackwater')
            return
        end

        local ok, message = debugBlackwater(source, targetSource)
        notify(source, message)

        if not ok then
            print(('[dl_missions][testtools] Debug failed for source %s targeting %s: %s'):format(source, targetSource, message))
        end
    end, false)
end)
