local function notify(message, notifyType)
    TriggerEvent("chat:addMessage", {
        args = { "blacksmith_hotfix", message }
    })

    TriggerEvent("ox_lib:notify", {
        title = message,
        type = notifyType or "inform",
        duration = 5000
    })
end

local function hasClientCommand(commandName)
    local ok, commands = pcall(GetRegisteredCommands)
    if not ok or type(commands) ~= "table" then
        return nil
    end

    commandName = tostring(commandName or ""):lower()

    for _, command in ipairs(commands) do
        if type(command) == "table" and tostring(command.name or ""):lower() == commandName then
            return true
        end
    end

    return false
end

local function getMatchingCommands()
    local ok, commands = pcall(GetRegisteredCommands)
    local matches = {}

    if not ok or type(commands) ~= "table" then
        return nil
    end

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

    table.sort(matches)
    return matches
end

local function checkVorpCore()
    if GetResourceState("vorp_core") ~= "started" then
        return "state=" .. tostring(GetResourceState("vorp_core"))
    end

    local ok, core = pcall(function()
        return exports.vorp_core:GetCore()
    end)

    return ("state=started export=%s core=%s"):format(tostring(ok), tostring(type(core)))
end

RegisterNetEvent("blacksmith_hotfix:client:placeforge", function(index, commandName)
    index = tostring(index or "1")
    commandName = tostring(commandName or "bs_mosquito_placeforge")

    local registered = hasClientCommand(commandName)
    if registered == false and commandName ~= "placeforge" then
        local fallbackRegistered = hasClientCommand("placeforge")
        if fallbackRegistered then
            commandName = "placeforge"
            registered = true
        end
    end

    if registered == false then
        notify(("client /%s command is not registered; Mosquito did not register placement"):format(commandName), "error")
        return
    end

    notify(("running client /%s %s"):format(commandName, index), registered and "inform" or "warning")
    ExecuteCommand(("%s %s"):format(commandName, index))
end)

RegisterCommand("bsclientcmds", function()
    local registered = hasClientCommand("placeforge")
    local internalRegistered = hasClientCommand("bs_mosquito_placeforge")
    local matches = getMatchingCommands()
    local matchText = matches and table.concat(matches, ", ") or "unavailable"
    notify(("client placeforge registered=%s internal=%s commands=%s vorp_core=%s"):format(
        tostring(registered),
        tostring(internalRegistered),
        matchText ~= "" and matchText or "none",
        checkVorpCore()
    ), registered and "success" or "error")
end, false)
