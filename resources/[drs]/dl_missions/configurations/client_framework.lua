local RSGCore = exports['rsg-core']:GetCoreObject()
local originalGetPlayerData = RSGCore and RSGCore.Functions and RSGCore.Functions.GetPlayerData
local lastRawPlayerData = {}

local function buildCharacterCompat(data)
    data = type(data) == 'table' and data or {}

    local existingCharacter = type(data.Character) == 'table' and data.Character or {}
    local charinfo = type(data.charinfo) == 'table' and data.charinfo or {}
    local job = type(data.job) == 'table' and data.job or {}
    local grade = type(job.grade) == 'table' and job.grade or {}
    local money = type(data.money) == 'table' and data.money or {}
    local citizenid = data.citizenid or data.charIdentifier or data.cid or existingCharacter.citizenid or existingCharacter.charIdentifier or existingCharacter.cid

    local character = {
        citizenid = citizenid,
        cid = data.cid or existingCharacter.cid,
        charIdentifier = citizenid,
        identifier = citizenid or data.identifier or existingCharacter.identifier,
        firstname = charinfo.firstname or existingCharacter.firstname,
        lastname = charinfo.lastname or existingCharacter.lastname,
        job = job.name or data.job or existingCharacter.job,
        jobLabel = job.label or existingCharacter.jobLabel,
        jobGrade = grade.level or grade.grade or data.jobGrade or existingCharacter.jobGrade or 0,
        grade = grade.level or grade.grade or data.jobGrade or existingCharacter.grade or 0,
        money = money.cash or data.cash or existingCharacter.money or 0,
        cash = money.cash or data.cash or existingCharacter.cash or 0,
        gold = money.gold or money.bank or data.gold or existingCharacter.gold or 0,
        source = data.source or existingCharacter.source
    }

    local compat = {}
    for key, value in pairs(data) do
        compat[key] = value
    end

    compat.Character = character
    compat.PlayerData = data
    compat.citizenid = character.citizenid
    compat.cid = character.cid
    compat.charIdentifier = character.charIdentifier
    compat.identifier = character.identifier
    compat.firstname = character.firstname
    compat.lastname = character.lastname
    compat.job = character.job
    compat.jobLabel = character.jobLabel
    compat.jobGrade = character.jobGrade
    compat.grade = character.grade
    compat.money = character.money
    compat.cash = character.cash
    compat.gold = character.gold
    compat.source = character.source

    lastRawPlayerData = data
    return compat
end

function getPlayerCharacter()
    if originalGetPlayerData then
        local ok, data = pcall(originalGetPlayerData)
        if ok then
            return buildCharacterCompat(data)
        end
    end

    return buildCharacterCompat(lastRawPlayerData)
end

function getCharacterIdentifier(Character)
    if type(Character) ~= 'table' then return nil end
    local nestedCharacter = type(Character.Character) == 'table' and Character.Character or {}

    return Character.citizenid
        or Character.charIdentifier
        or Character.cid
        or nestedCharacter.citizenid
        or nestedCharacter.charIdentifier
        or nestedCharacter.cid
end

if originalGetPlayerData then
    RSGCore.Functions.GetPlayerData = function(...)
        local ok, data = pcall(originalGetPlayerData, ...)
        if ok then
            return buildCharacterCompat(data)
        end

        return buildCharacterCompat(lastRawPlayerData)
    end
end

RegisterNetEvent('RSGCore:Client:OnPlayerLoaded', function()
    Wait(500)
    getPlayerCharacter()
end)

RegisterNetEvent('RSGCore:Player:SetPlayerData', function(data)
    buildCharacterCompat(data)
end)

CreateThread(function()
    Wait(2500)
    getPlayerCharacter()
end)

local function missionNotify(title, message, duration, notifyType)
    local notifyData = {
        title = title or 'Missions',
        description = tostring(message or ''),
        type = notifyType or 'inform',
        duration = tonumber(duration) or 5000
    }

    if GetResourceState('ox_lib') == 'started' then
        TriggerEvent('ox_lib:notify', notifyData)
        return
    end

    print(('[dl_missions] %s: %s'):format(notifyData.title, notifyData.description))
end

function SystemInformationNotification(message, duration)
    missionNotify('Missions', message, duration, 'inform')
end

function NPCDialogNotification(message, duration)
    SendNUIMessage({
        action = 'npcDialog',
        title = 'Mission',
        message = tostring(message or ''),
        duration = tonumber(duration) or 5000
    })
end

function SubTaskCompletedNotification(message, duration)
    missionNotify('Task Complete', message, duration, 'success')
end

function SubTaskFailedNotification(message, duration)
    missionNotify('Task Failed', message, duration, 'error')
end

function MissionCompletedNotification(message, duration)
    missionNotify('Mission Complete', message, duration, 'success')
end

function MissionFailedNotification(message, duration)
    missionNotify('Mission Failed', message, duration, 'error')
end
