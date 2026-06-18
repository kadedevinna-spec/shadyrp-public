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

local function triggerCallbackAsync(name, cb, ...)
    local core = ensureCore()
    if core and core.Functions and core.Functions.TriggerCallback then
        return core.Functions.TriggerCallback(name, cb, ...)
    end

    if type(cb) == "function" then cb(nil) end
end

Core.Callback = {
    TriggerAsync = triggerCallbackAsync,
    Trigger = triggerCallbackAsync,
    TriggerAwait = function(name, ...)
        if not promise or not Citizen or type(Citizen.Await) ~= "function" then
            return nil
        end

        local p = promise.new()
        local resolved = false

        triggerCallbackAsync(name, function(...)
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

AddEventHandler("getCore", function(cb)
    if type(cb) == "function" then cb(Core) end
end)

AddEventHandler("vorp:getSharedObject", function(cb)
    if type(cb) == "function" then cb(Core) end
end)

exports("GetCore", function()
    return Core
end)
