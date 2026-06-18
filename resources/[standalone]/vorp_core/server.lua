local RSGCore = nil
local Core = {}

local CurrencyMap = {
    [0] = "cash",
    [1] = "gold",
    [2] = "bloodmoney",
    cash = "cash",
    money = "cash",
    dollars = "cash",
    gold = "gold",
    bloodmoney = "bloodmoney",
    blood_money = "bloodmoney"
}

local function ensureCore()
    if not RSGCore and GetResourceState("rsg-core") == "started" then
        RSGCore = exports["rsg-core"]:GetCoreObject()
    end

    return RSGCore
end

CreateThread(function()
    while not ensureCore() do
        Wait(250)
    end

    print("^2[vorp_core bridge] ready on top of rsg-core^0")
end)

local function resolveMoneyType(currency)
    return CurrencyMap[currency] or CurrencyMap[tostring(currency or ""):lower()] or "cash"
end

local function getPlayer(source)
    local core = ensureCore()
    if not core or not source then return nil end
    return core.Functions.GetPlayer(tonumber(source) or source)
end

local function makeCharacter(source, player)
    player = player or getPlayer(source)
    if not player then return nil end

    local data = player.PlayerData or {}
    local job = data.job or {}
    local grade = job.grade or {}
    local charinfo = data.charinfo or {}
    local money = data.money or {}

    local character = {
        source = source,
        identifier = data.license,
        charIdentifier = data.citizenid,
        charidentifier = data.citizenid,
        citizenid = data.citizenid,
        firstname = charinfo.firstname,
        lastname = charinfo.lastname,
        job = job.name or "unemployed",
        jobLabel = job.label or job.name or "Unemployed",
        jobGrade = grade.level or 0,
        grade = grade.level or 0,
        group = data.group or "user",
        money = money.cash or 0,
        gold = money.gold or 0,
        bloodmoney = money.bloodmoney or 0
    }

    function character.addCurrency(currency, amount)
        return player.Functions.AddMoney(resolveMoneyType(currency), tonumber(amount) or 0, "vorp_core bridge")
    end

    function character.removeCurrency(currency, amount)
        return player.Functions.RemoveMoney(resolveMoneyType(currency), tonumber(amount) or 0, "vorp_core bridge")
    end

    function character.addMoney(amount)
        return character.addCurrency(0, amount)
    end

    function character.removeMoney(amount)
        return character.removeCurrency(0, amount)
    end

    function character.getMoney()
        return player.Functions.GetMoney("cash") or 0
    end

    function character.setJob(jobName, jobGrade)
        return player.Functions.SetJob(jobName, jobGrade or 0)
    end

    function character.setGroup(group)
        player.Functions.SetPlayerData("group", group)
        return true
    end

    character.Character = character
    character.character = character

    return setmetatable(character, {
        __call = function(self)
            return self
        end
    })
end

local function getRsgPlayers(core)
    if core and core.Functions then
        if type(core.Functions.GetRSGPlayers) == "function" then
            return core.Functions.GetRSGPlayers()
        end

        if type(core.Functions.GetPlayers) == "function" then
            local players = {}
            for _, playerId in pairs(core.Functions.GetPlayers()) do
                local player = core.Functions.GetPlayer(playerId)
                if player then
                    players[#players + 1] = player
                end
            end
            return players
        end
    end

    return {}
end

local function buildMosquitoEmployees(source, jobName)
    local core = ensureCore()
    local sourcePlayer = getPlayer(source)
    if not core or not sourcePlayer then
        return {}
    end

    local sourceJob = ((sourcePlayer.PlayerData or {}).job or {}).name
    local requestedJob = type(jobName) == "string" and jobName ~= "" and jobName or nil
    local players = getRsgPlayers(core)
    local requestedJobExists = false

    if requestedJob then
        for _, player in pairs(players) do
            local pdata = player.PlayerData or {}
            local job = pdata.job or {}
            if job.name == requestedJob then
                requestedJobExists = true
                break
            end
        end
    end

    local targetJob = requestedJobExists and requestedJob or sourceJob
    local employees = {}

    local function addEmployee(player)
        local pdata = player and player.PlayerData or {}
        local job = pdata.job or {}
        local grade = job.grade
        local gradeLevel = 0
        if type(grade) == "table" then
            gradeLevel = grade.level or grade.grade or 0
        elseif grade ~= nil then
            gradeLevel = tonumber(grade) or 0
        end
        local charinfo = pdata.charinfo or {}
        local identifier = pdata.license or pdata.citizenid
        local charIdentifier = pdata.citizenid
        local playerSource = pdata.source or source

        local character = {
            identifier = identifier,
            charIdentifier = charIdentifier,
            charidentifier = charIdentifier,
            firstname = charinfo.firstname or "Unknown",
            lastname = charinfo.lastname or "",
            job = job.name or "unemployed",
            jobGrade = gradeLevel,
            jobgrade = gradeLevel,
            grade = gradeLevel,
            group = pdata.group or "user"
        }
        character.Character = character

        employees[#employees + 1] = {
            Character = character,
            _source = playerSource,
            _serverId = playerSource
        }
    end

    for _, player in pairs(players) do
        local pdata = player.PlayerData or {}
        local job = pdata.job or {}

        if pdata and job and job.name == targetJob then
            addEmployee(player)
        end
    end

    if #employees == 0 then
        addEmployee(sourcePlayer)
    end

    return employees
end

local function makeUser(source)
    local player = getPlayer(source)
    if not player then return nil end

    local character = makeCharacter(source, player)
    if not character then return nil end
    local data = player.PlayerData or {}

    return {
        source = source,
        identifier = data.license,
        Character = character,
        character = character,
        getUsedCharacter = character,
        getIdentifier = function()
            return data.license
        end
    }
end

local function notifyTarget(target, message, duration, notifyType)
    target = tonumber(target)
    if not target then return end

    TriggerClientEvent("ox_lib:notify", target, {
        title = "Notification",
        description = tostring(message or ""),
        type = notifyType or "inform",
        duration = tonumber(duration) or 4000
    })
end

local function normalizeNotifyArgs(...)
    local args = { ... }
    local target = tonumber(args[1])

    if target then
        return target, args[2], args[3], args[4]
    end

    return nil, args[1], args[2], args[3]
end

local function notify(...)
    local target, message, duration, notifyType = normalizeNotifyArgs(...)
    notifyTarget(target, message, duration, notifyType)
end

Core.getUser = makeUser
Core.NotifyTip = notify
Core.NotifyRightTip = notify
Core.NotifyObjective = notify
Core.NotifyLeft = notify
Core.NotifySimpleTop = notify
Core.NotifyTop = notify
Core.NotifyAvanced = notify
Core.NotifyAdvanced = notify
Core.NotifyBasicTop = notify

local function callbackTraceEnabled()
    return not GetConvar or tostring(GetConvar("mosquito_blacksmith_trace", "1")) == "1"
end

local function callbackTraceShouldPrint(name)
    if not callbackTraceEnabled() then return false end

    name = tostring(name or ""):lower()
    return name:find("forge", 1, true)
        or name:find("smelt", 1, true)
        or name:find("collect", 1, true)
        or name:find("mine", 1, true)
        or name:find("blacksmith", 1, true)
        or name:find("mosquito", 1, true)
end

local function callbackTrace(action, name, detail)
    if callbackTraceShouldPrint(name) then
        print(("[vorp_core bridge] server callback %s name=%s %s"):format(
            tostring(action),
            tostring(name),
            tostring(detail or "")
        ))
    end
end

local function packCallbackResults(...)
    return { n = select("#", ...), ... }
end

local function unpackCallbackResults(results)
    if type(results) ~= "table" then
        return nil
    end

    return table.unpack(results, 1, results.n or #results)
end

local function triggerClientCallbackAsync(name, target, cb, ...)
    local core = ensureCore()
    if core and core.Functions and core.Functions.TriggerClientCallback then
        callbackTrace("triggerClient", name, ("target=%s args=%s"):format(tostring(target), tostring(select("#", ...))))
        return core.Functions.TriggerClientCallback(name, target, cb, ...)
    end

    callbackTrace("triggerClient-missing-rsg", name, ("target=%s"):format(tostring(target)))
    if type(cb) == "function" then cb(nil) end
end

local function registerServerCallback(name, cb)
    local core = ensureCore()
    if core and core.Functions and core.Functions.CreateCallback then
        callbackTrace("registerServer", name)
        return core.Functions.CreateCallback(name, function(source, reply, ...)
            callbackTrace("handleServer", name, ("source=%s args=%s"):format(tostring(source), tostring(select("#", ...))))
            if tostring(name or "") == "mosquito-mining:server:getEmployees" then
                local employees = buildMosquitoEmployees(source, ...)
                callbackTrace("getEmployees-rsg", name, ("source=%s count=%s"):format(tostring(source), tostring(#employees)))
                return reply(employees)
            end
            return cb(source, reply, ...)
        end)
    end

    callbackTrace("registerServer-missing-rsg", name)
    return false
end

Core.Callback = {
    Register = registerServerCallback,
    RegisterServerCallback = registerServerCallback,
    TriggerAsync = triggerClientCallbackAsync,
    Trigger = triggerClientCallbackAsync,
    TriggerClientCallback = triggerClientCallbackAsync,
    TriggerAwait = function(name, target, ...)
        if not promise or not Citizen or type(Citizen.Await) ~= "function" then
            return nil
        end

        local p = promise.new()
        local resolved = false

        callbackTrace("triggerAwait", name, ("target=%s args=%s"):format(tostring(target), tostring(select("#", ...))))
        triggerClientCallbackAsync(name, target, function(...)
            if resolved then return end
            resolved = true
            callbackTrace("triggerAwait-result", name, ("target=%s results=%s"):format(tostring(target), tostring(select("#", ...))))
            p:resolve(packCallbackResults(...))
        end, ...)

        CreateThread(function()
            Wait(5000)
            if not resolved then
                resolved = true
                callbackTrace("triggerAwait-timeout", name, ("target=%s"):format(tostring(target)))
                p:resolve(packCallbackResults(nil))
            end
        end)

        return unpackCallbackResults(Citizen.Await(p))
    end
}

Core.RegisterCallback = function(name, cb)
    return registerServerCallback(name, cb)
end
Core.addRpcCallback = registerServerCallback
Core.triggerRpcCallback = triggerClientCallbackAsync

AddEventHandler("getCore", function(cb)
    if type(cb) == "function" then cb(Core) end
end)

AddEventHandler("vorp:getSharedObject", function(cb)
    if type(cb) == "function" then cb(Core) end
end)

exports("GetCore", function()
    return Core
end)
