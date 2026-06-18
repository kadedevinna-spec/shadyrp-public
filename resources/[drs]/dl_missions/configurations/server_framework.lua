local RSGCore = exports['rsg-core']:GetCoreObject()

local registeredUseTaskItems = {}

local function getPlayer(_source)
    return RSGCore.Functions.GetPlayer(tonumber(_source))
end

local function hasPermission(_source, permission)
    if not RSGCore.Functions.HasPermission then return false end

    local ok, allowed = pcall(RSGCore.Functions.HasPermission, tonumber(_source), permission)
    return ok and allowed or false
end

local function getSourceFromLoadedPlayer(Player)
    if type(Player) == 'table' and Player.PlayerData then
        return Player.PlayerData.source
    end

    return nil
end

AddEventHandler('RSGCore:Server:PlayerLoaded', function(Player)
    local src = getSourceFromLoadedPlayer(Player)
    if src then
        characterJoinedServer(src)
    end
end)

AddEventHandler('RSGCore:Server:OnJobUpdate', function(source, job)
    local jobName = type(job) == 'table' and job.name or job
    updateCharacterJob(source, jobName or 'unemployed')
end)

CreateThread(function()
    Wait(2500)

    for _, playerId in ipairs(GetPlayers()) do
        local src = tonumber(playerId)
        if src and getPlayer(src) then
            characterJoinedServer(src)
        end
    end
end)

local function buildCharacterCompat(Player)
    if not Player or not Player.PlayerData then
        return {
            Character = {},
            PlayerData = {},
            citizenid = nil,
            cid = nil,
            charIdentifier = nil,
            identifier = nil,
            firstname = nil,
            lastname = nil,
            job = 'unemployed',
            jobLabel = nil,
            jobGrade = 0,
            grade = 0,
            money = 0,
            cash = 0,
            gold = 0,
            source = nil
        }
    end

    local data = Player.PlayerData
    local charinfo = data.charinfo or {}
    local job = data.job or {}
    local grade = type(job.grade) == 'table' and job.grade or {}
    local money = type(data.money) == 'table' and data.money or {}
    local citizenid = data.citizenid or data.charIdentifier or data.cid

    local character = {
        citizenid = citizenid,
        cid = data.cid,
        charIdentifier = citizenid,
        identifier = citizenid,
        firstname = charinfo.firstname,
        lastname = charinfo.lastname,
        job = job.name or data.job,
        jobLabel = job.label,
        jobGrade = grade.level or grade.grade or data.jobGrade or 0,
        grade = grade.level or grade.grade or data.jobGrade or 0,
        money = money.cash or data.cash or 0,
        cash = money.cash or data.cash or 0,
        gold = money.gold or money.bank or data.gold or 0,
        source = data.source
    }

    -- Some escrowed mission code expects a VORP-style `.Character` field,
    -- while the RSG bridge uses PlayerData directly. Return both shapes.
    return setmetatable({
        Character = character,
        PlayerData = data,
        citizenid = character.citizenid,
        cid = character.cid,
        charIdentifier = character.charIdentifier,
        identifier = character.identifier,
        firstname = character.firstname,
        lastname = character.lastname,
        job = character.job,
        jobLabel = character.jobLabel,
        jobGrade = character.jobGrade,
        grade = character.grade,
        money = character.money,
        cash = character.cash,
        gold = character.gold,
        source = character.source
    }, { __index = data })
end

function getPlayerCharacter(_source)
    local Player = getPlayer(_source)
    return buildCharacterCompat(Player)
end

function getCharacterIdentifier(Character)
    if not Character then return nil end
    local nestedCharacter = Character.Character
    return Character.citizenid
        or Character.charIdentifier
        or Character.cid
        or (nestedCharacter and (nestedCharacter.citizenid or nestedCharacter.charIdentifier or nestedCharacter.cid))
end

function getCharacterJob(_source)
    local Player = getPlayer(_source)
    local job = Player and Player.PlayerData and Player.PlayerData.job

    return job and job.name or 'unemployed'
end

function getPlayerGroup(_source)
    if hasPermission(_source, 'god') or hasPermission(_source, 'admin') then
        return 'admin'
    end

    if hasPermission(_source, 'moderator') or hasPermission(_source, 'mod') then
        return 'moderator'
    end

    return 'user'
end

function getInventoryItemAmount(_source, itemName)
    return tonumber(exports['rsg-inventory']:GetItemCount(_source, itemName)) or 0
end

function canCarryRewardItem(_source, itemName, amount)
    return exports['rsg-inventory']:CanAddItem(_source, itemName, tonumber(amount) or 1)
end

local function normalizeMoneyType(currencyType)
    currencyType = tostring(currencyType or ''):lower()

    if currencyType == 'money' then return 'cash' end
    if currencyType == 'cash' or currencyType == 'bank' or currencyType == 'bloodmoney' then return currencyType end
    if currencyType == 'valbank' or currencyType == 'rhobank' or currencyType == 'blkbank' or currencyType == 'armbank' then return currencyType end

    return nil
end

function addRewardCurrency(_source, currencyType, currencyAmount)
    local Player = getPlayer(_source)
    if not Player then return false end

    local amount = tonumber(currencyAmount) or 0
    local currency = tostring(currencyType or ''):lower()

    if currency == 'xp' then
        if Player.Functions.AddRep then
            Player.Functions.AddRep('missions', amount)
            return true
        end

        print(('[dl_missions][rsg] XP reward skipped: RSG AddRep unavailable for source %s'):format(tostring(_source)))
        return false
    end

    local moneyType = normalizeMoneyType(currency)
    if moneyType then
        return Player.Functions.AddMoney(moneyType, amount, 'dl_missions reward')
    end

    print(('[dl_missions][rsg] Unsupported reward currency "%s" for source %s'):format(tostring(currencyType), tostring(_source)))
    return false
end

function addInventoryItem(_source, itemName, amount)
    return exports['rsg-inventory']:AddItem(_source, itemName, tonumber(amount) or 1)
end

function removeInventoryItem(_source, itemName, amount)
    return exports['rsg-inventory']:RemoveItem(_source, itemName, tonumber(amount) or 1)
end

local function callExistingUseCallback(itemName, existingCallback, source, item)
    if not existingCallback then return end

    local ok, err = pcall(existingCallback, source, item)
    if not ok then
        print(('[dl_missions][rsg] Existing usable callback failed for %s: %s'):format(tostring(itemName), tostring(err)))
    end
end

local function trackUsedMissionItem(source, itemName)
    if type(inventoryItemUsedCheckTasks) ~= 'function' then
        print(('[dl_missions][rsg] Use task tracker unavailable for %s'):format(tostring(itemName)))
        return
    end

    inventoryItemUsedCheckTasks(source, itemName)
end

local function registerUseTaskItem(itemName)
    if not itemName or registeredUseTaskItems[itemName] then return end

    registeredUseTaskItems[itemName] = true
    local existingCallback = RSGCore.Functions.CanUseItem and RSGCore.Functions.CanUseItem(itemName) or nil

    exports['rsg-inventory']:CreateUseableItem(itemName, function(source, item)
        callExistingUseCallback(itemName, existingCallback, source, item)
        trackUsedMissionItem(source, itemName)
    end)
end

CreateThread(function()
    Wait(2000)

    for _, task in pairs(Config.Tasks or {}) do
        if type(task) == 'table' and tonumber(task.type) == 7 then
            if type(task.itemNames) == 'table' then
                for _, itemName in ipairs(task.itemNames) do
                    registerUseTaskItem(itemName)
                end
            elseif task.itemName then
                registerUseTaskItem(task.itemName)
            end
        end
    end
end)
