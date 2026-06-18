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

local function makeCharacter(source)
    local player = getPlayer(source)
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

    return setmetatable(character, {
        __call = function(self)
            return self
        end
    })
end

local function makeUser(source)
    local player = getPlayer(source)
    if not player then return nil end

    local character = makeCharacter(source)
    local data = player.PlayerData or {}

    return {
        source = source,
        identifier = data.license,
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
        return core.Functions.TriggerClientCallback(name, target, cb, ...)
    end

    if type(cb) == "function" then cb(nil) end
end

Core.Callback = {
    Register = function(name, cb)
        local core = ensureCore()
        if core and core.Functions and core.Functions.CreateCallback then
            return core.Functions.CreateCallback(name, cb)
        end
        return false
    end,
    TriggerAsync = triggerClientCallbackAsync,
    Trigger = triggerClientCallbackAsync,
    TriggerAwait = function(name, target, ...)
        if not promise or not Citizen or type(Citizen.Await) ~= "function" then
            return nil
        end

        local p = promise.new()
        local resolved = false

        triggerClientCallbackAsync(name, target, function(...)
            if resolved then return end
            resolved = true
            p:resolve(packCallbackResults(...))
        end, ...)

        CreateThread(function()
            Wait(5000)
            if not resolved then
                resolved = true
                p:resolve(packCallbackResults(nil))
            end
        end)

        return unpackCallbackResults(Citizen.Await(p))
    end
}

Core.RegisterCallback = function(name, cb)
    return Core.Callback.Register(name, cb)
end

AddEventHandler("getCore", function(cb)
    if type(cb) == "function" then cb(Core) end
end)

AddEventHandler("vorp:getSharedObject", function(cb)
    if type(cb) == "function" then cb(Core) end
end)

exports("GetCore", function()
    return Core
end)

RegisterCommand("bscheckshim", function(source)
    local coreAliasState = GetResourceState("vorp_core")
    local inventoryAliasState = GetResourceState("vorp_inventory")
    local providerState = GetResourceState(GetCurrentResourceName())
    local coreExportOk, coreExportResult = pcall(function()
        return exports["vorp_core"]:GetCore()
    end)
    local inventoryExportOk, inventoryExportResult = pcall(function()
        return exports["vorp_inventory"]:vorp_inventoryApi()
    end)
    local msg = ("mosquito_vorp_core: alias vorp_core=%s vorp_inventory=%s provider=%s coreExportOk=%s coreExportType=%s invExportOk=%s invExportType=%s"):format(
        tostring(coreAliasState),
        tostring(inventoryAliasState),
        tostring(providerState),
        tostring(coreExportOk),
        tostring(type(coreExportResult)),
        tostring(inventoryExportOk),
        tostring(type(inventoryExportResult))
    )

    print(msg)
    if tonumber(source) and tonumber(source) > 0 then
        TriggerClientEvent("chat:addMessage", source, { args = { "mosquito_vorp_core", msg } })
    end
end, false)
