local Core = {}
local RSGCore = nil

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
end)

local function notify(message, duration, notifyType)
    TriggerEvent("ox_lib:notify", {
        title = "Notification",
        description = tostring(message or ""),
        type = notifyType or "inform",
        duration = tonumber(duration) or 4000
    })
end

local function buildCharacter()
    local core = ensureCore()
    local data = {}
    if core and core.Functions and core.Functions.GetPlayerData then
        local ok, result = pcall(core.Functions.GetPlayerData)
        if ok and type(result) == "table" then
            data = result
        end
    end

    local job = data.job or {}
    local grade = job.grade or {}
    local charinfo = data.charinfo or {}
    local money = data.money or {}

    local character = {
        identifier = data.license,
        charIdentifier = data.citizenid,
        charidentifier = data.citizenid,
        citizenid = data.citizenid,
        firstname = charinfo.firstname,
        lastname = charinfo.lastname,
        job = job.name or "unemployed",
        jobLabel = job.label or job.name or "Unemployed",
        jobGrade = grade.level or grade.grade or 0,
        grade = grade.level or grade.grade or 0,
        group = data.group or "user",
        money = money.cash or 0,
        gold = money.gold or 0,
        bloodmoney = money.bloodmoney or 0,
    }

    character.Character = character
    character.character = character

    return setmetatable(character, {
        __call = function(self)
            return self
        end
    })
end

local function refreshCharacter()
    Core.Character = buildCharacter()
    Core.character = Core.Character
    Core.PlayerData = Core.Character
    Core.getUser = function()
        return {
            getUsedCharacter = Core.Character,
            identifier = Core.Character.identifier,
            getIdentifier = function()
                return Core.Character.identifier
            end
        }
    end
    return Core.Character
end

Core.NotifyTip = notify
Core.NotifyRightTip = notify
Core.NotifyObjective = notify
Core.NotifyLeft = notify
Core.NotifySimpleTop = notify
Core.NotifyTop = notify
Core.NotifyAvanced = notify
Core.NotifyAdvanced = notify
Core.NotifyBasicTop = notify

refreshCharacter()

CreateThread(function()
    while not ensureCore() do
        Wait(250)
    end
    Wait(500)
    refreshCharacter()
end)

RegisterNetEvent("RSGCore:Client:OnPlayerLoaded", function()
    refreshCharacter()
end)

RegisterNetEvent("RSGCore:Client:OnPlayerUnload", function()
    refreshCharacter()
end)

RegisterNetEvent("RSGCore:Player:SetPlayerData", function()
    refreshCharacter()
end)

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
        print(("[vorp_core bridge] client callback %s name=%s %s"):format(
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

local function describeCallbackValue(value, depth)
    depth = depth or 0
    local valueType = type(value)
    if valueType ~= "table" then
        return ("%s:%s"):format(valueType, tostring(value))
    end

    if depth >= 3 then
        return "table"
    end

    local parts = {}
    for key, itemValue in pairs(value) do
        parts[#parts + 1] = ("%s=%s"):format(tostring(key), describeCallbackValue(itemValue, depth + 1))
        if #parts >= 12 then break end
    end

    return "table{" .. table.concat(parts, ",") .. "}"
end

local function describeCallbackResults(...)
    local parts = {}
    for index = 1, math.min(select("#", ...), 3) do
        parts[#parts + 1] = describeCallbackValue(select(index, ...), 0)
    end

    return table.concat(parts, " | ")
end

local function normalizeCallbackResults(name, ...)
    if tostring(name or "") ~= "mosquito-mining:server:getEmployees" then
        return ...
    end

    local first = select(1, ...)
    if type(first) ~= "table" then
        return ...
    end

    local rest = { ... }
    if first.Character and not first[1] then
        if type(first.Character) == "table" then
            first.Character.Character = first.Character
        end

        rest[1] = first
        return table.unpack(rest, 1, select("#", ...))
    end

    local employees = first

    local function normalizeEmployeeRow(row)
        if type(row) ~= "table" then return end

        local source = rawget(row, "source") or rawget(row, "_source")
        local serverId = rawget(row, "serverId") or rawget(row, "_serverId") or source
        local character = rawget(row, "Character")
        if type(character) == "table" then
            character.Character = character
        end

        row.source = nil
        row.serverId = nil
        row._source = nil
        row._serverId = nil

        setmetatable(row, {
            __index = function(_, key)
                if key == "source" then return source end
                if key == "serverId" then return serverId end
                return nil
            end
        })
    end

    if type(employees[1]) == "table" then
        for index = 1, #employees do
            normalizeEmployeeRow(employees[index])
        end

        setmetatable(employees, {
            __len = function(tableValue)
                local count = 0
                while rawget(tableValue, count + 1) ~= nil do
                    count = count + 1
                end
                return count
            end,
            __pairs = function(tableValue)
                local index = 0
                return function()
                    index = index + 1
                    local value = rawget(tableValue, index)
                    if value ~= nil then
                        return index, value
                    end
                end
            end,
            __index = function(tableValue, key)
                local primary = rawget(tableValue, 1)
                if type(primary) ~= "table" then return nil end
                if key == "Character" then
                    return rawget(primary, "Character")
                end
                if key == "source" or key == "serverId" then
                    return rawget(primary, key)
                end
                return nil
            end
        })
    end

    rest[1] = employees
    return table.unpack(rest, 1, select("#", ...))
end

local function triggerCallbackAsync(name, cb, ...)
    local core = ensureCore()
    if core and core.Functions and core.Functions.TriggerCallback then
        callbackTrace("triggerServer", name, ("args=%s"):format(tostring(select("#", ...))))
        local wrappedCb = cb
        if type(cb) == "function" then
            wrappedCb = function(...)
                return cb(normalizeCallbackResults(name, ...))
            end
        end
        return core.Functions.TriggerCallback(name, wrappedCb, ...)
    end

    callbackTrace("triggerServer-missing-rsg", name)
    if type(cb) == "function" then cb(nil) end
end

local function registerClientCallback(name, cb)
    local core = ensureCore()
    if core and core.Functions and core.Functions.CreateClientCallback then
        callbackTrace("registerClient", name)
        return core.Functions.CreateClientCallback(name, function(reply, ...)
            callbackTrace("handleClient", name, ("args=%s"):format(tostring(select("#", ...))))
            return cb(reply, ...)
        end)
    end

    callbackTrace("registerClient-missing-rsg", name)
    return false
end

Core.Callback = {
    Register = registerClientCallback,
    RegisterClientCallback = registerClientCallback,
    TriggerAsync = triggerCallbackAsync,
    Trigger = triggerCallbackAsync,
    TriggerServerCallback = triggerCallbackAsync,
    TriggerAwait = function(name, ...)
        if not promise or not Citizen or type(Citizen.Await) ~= "function" then
            return nil
        end

        local p = promise.new()
        local resolved = false

        callbackTrace("triggerAwait", name, ("args=%s"):format(tostring(select("#", ...))))
        triggerCallbackAsync(name, function(...)
            if resolved then return end
            resolved = true
            local normalized = packCallbackResults(normalizeCallbackResults(name, ...))
            callbackTrace("triggerAwait-result", name, ("results=%s detail=%s"):format(
                tostring(normalized.n or 0),
                describeCallbackResults(unpackCallbackResults(normalized))
            ))
            p:resolve(normalized)
        end, ...)

        CreateThread(function()
            Wait(5000)
            if not resolved then
                resolved = true
                callbackTrace("triggerAwait-timeout", name)
                p:resolve(packCallbackResults(nil))
            end
        end)

        return unpackCallbackResults(Citizen.Await(p))
    end
}

Core.RegisterCallback = registerClientCallback
Core.addRpcCallback = registerClientCallback
Core.triggerRpcCallback = triggerCallbackAsync

AddEventHandler("getCore", function(cb)
    if type(cb) == "function" then cb(Core) end
end)

AddEventHandler("vorp:getSharedObject", function(cb)
    if type(cb) == "function" then cb(Core) end
end)

exports("GetCore", function()
    return Core
end)
