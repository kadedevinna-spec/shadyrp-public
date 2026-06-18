function DebugPrint(...)
    if Config and Config.Debug then
        print(...)
    end
end

function NicheDebugPrint(...)
    return
    -- if Config and Config.Debug then
    --     print(...)
    -- end
end

local enableMosquitoDebugHooks = false
if type(GetConvar) == "function" then
    enableMosquitoDebugHooks = tostring(GetConvar("mosquito_blacksmith_debug_hooks", "0")) == "1"
end

if not enableMosquitoDebugHooks then
    if not IsDuplicityVersion() then
        print("[mosquito trace] debug hook layer disabled (set convar mosquito_blacksmith_debug_hooks 1 to enable)")
    end
    return
end
local function MosquitoTraceIsEnabled()
    if GetConvar and tostring(GetConvar("mosquito_blacksmith_trace", "0")) == "1" then
        return true
    end

    return Config and Config.Debug == true
end

local function MosquitoTraceShouldPrint(value)
    if not MosquitoTraceIsEnabled() then
        return false
    end

    value = tostring(value or ""):lower()
    if value:find("updateforgecondition", 1, true) then
        return false
    end

    return value:find("forge", 1, true)
        or value:find("black", 1, true)
        or value:find("mine", 1, true)
        or value:find("place", 1, true)
        or value:find("collect", 1, true)
        or value:find("smelt", 1, true)
        or value:find("reward", 1, true)
        or value:find("item", 1, true)
        or value:find("inventory", 1, true)
        or value:find("callback", 1, true)
        or value:find("mosquito", 1, true)
end

local function MosquitoCommandShouldBePublic(commandName)
    commandName = tostring(commandName or ""):lower()
    return commandName == "placeforge" or commandName == "bs_mosquito_placeforge"
end

local MosquitoPlaceForgeHandler = nil
local MosquitoPlaceForgeCommandName = nil
local MosquitoBridgeTraceUntil = {}
local MosquitoSmeltFallbackStates = {}
local MosquitoCollectFallbackLocks = {}
local MosquitoCollectFallbackPendingForges = {}
local MosquitoCrusherFallbackStates = {}
local MosquitoCrusherFallbackLocks = {}

local MosquitoCrusherFallbackPools = {
    rock = {
        { item = "coal", label = "Coal", weight = 40, min = 2, max = 4 },
        { item = "nitrite", label = "Nitrite", weight = 35, min = 1, max = 3 },
        { item = "iron", label = "Iron Ore", weight = 20, min = 1, max = 2 },
        { item = "diamond", label = "Diamond", weight = 5, min = 1, max = 1 },
    },
    stone = {
        { item = "coal", label = "Coal", weight = 40, min = 2, max = 4 },
        { item = "nitrite", label = "Nitrite", weight = 35, min = 1, max = 3 },
        { item = "iron", label = "Iron Ore", weight = 20, min = 1, max = 2 },
        { item = "diamond", label = "Diamond", weight = 5, min = 1, max = 1 },
    },
    sandstone = {
        { item = "salt", label = "Salt", weight = 35, min = 1, max = 4 },
        { item = "chalk", label = "Chalk", weight = 30, min = 2, max = 4 },
        { item = "limestone", label = "Limestone", weight = 20, min = 1, max = 3 },
        { item = "clay", label = "Clay", weight = 15, min = 1, max = 3 },
    },
    limestone = {
        { item = "salt", label = "Salt", weight = 30, min = 1, max = 4 },
        { item = "chalk", label = "Chalk", weight = 30, min = 2, max = 4 },
        { item = "clay", label = "Clay", weight = 25, min = 1, max = 3 },
        { item = "sandstone", label = "Sandstone", weight = 15, min = 1, max = 2 },
    },
    sand = {
        { item = "clay", label = "Clay", weight = 40, min = 1, max = 3 },
        { item = "salt", label = "Salt", weight = 35, min = 1, max = 3 },
        { item = "chalk", label = "Chalk", weight = 25, min = 1, max = 2 },
    },
}

local function MosquitoCrusherIsRawItem(itemName)
    itemName = tostring(itemName or ""):lower()
    return itemName == "rock"
        or itemName == "stone"
        or itemName == "sandstone"
        or itemName == "limestone"
        or itemName == "sand"
end

local function MosquitoNotify(playerSource, message, notifyType)
    print(("[mosquito trace] %s"):format(message))

    playerSource = tonumber(playerSource)
    if playerSource and playerSource > 0 then
        TriggerClientEvent("chat:addMessage", playerSource, {
            args = { "mosquito trace", message }
        })

        TriggerClientEvent("ox_lib:notify", playerSource, {
            title = message,
            type = notifyType or "inform",
            duration = 5000
        })
    end
end

local function MosquitoStartBridgeTrace(playerSource)
    playerSource = tonumber(playerSource)
    if playerSource and playerSource > 0 then
        MosquitoBridgeTraceUntil[playerSource] = (GetGameTimer and GetGameTimer() or 0) + 3000
    end
end

local function MosquitoIsBridgeTracing(target)
    target = tonumber(target)
    if not target then
        return false
    end

    local traceUntil = MosquitoBridgeTraceUntil[target]
    if not traceUntil then
        return false
    end

    local now = GetGameTimer and GetGameTimer() or 0
    if now <= traceUntil then
        return true
    end

    MosquitoBridgeTraceUntil[target] = nil
    return false
end

local function MosquitoTraceEncodeValue(value)
    local valueType = type(value)
    if valueType == "string" then
        return value
    end

    if valueType == "number" or valueType == "boolean" or value == nil then
        return tostring(value)
    end

    if valueType == "table" then
        local ok, encoded = pcall(function()
            return json.encode(value)
        end)

        if ok then
            return encoded
        end
    end

    return ("<%s:%s>"):format(valueType, tostring(value))
end

local function MosquitoTraceEncodeArgs(...)
    local count = select("#", ...)
    local encoded = {}

    for index = 1, math.min(count, 6) do
        encoded[#encoded + 1] = MosquitoTraceEncodeValue(select(index, ...))
    end

    if count > 6 then
        encoded[#encoded + 1] = ("...+%s"):format(tostring(count - 6))
    end

    local text = table.concat(encoded, " | ")
    if #text > 350 then
        text = text:sub(1, 350) .. "..."
    end

    return text
end

local function MosquitoGetInventoryCount(playerSource, itemName)
    playerSource = tonumber(playerSource)
    if not playerSource or playerSource <= 0 or not itemName then
        return 0
    end

    local ok, count = pcall(function()
        return exports["vorp_inventory"]:getItemCount(playerSource, itemName)
    end)

    if ok then
        return tonumber(count) or 0
    end

    print(("[mosquito trace] collect fallback count failed item=%s error=%s"):format(tostring(itemName), tostring(count)))
    return 0
end

local function MosquitoAddInventoryItem(playerSource, itemName, amount)
    playerSource = tonumber(playerSource)
    amount = tonumber(amount) or 1

    if not playerSource or playerSource <= 0 or not itemName or amount <= 0 then
        return false
    end

    local ok, added = pcall(function()
        return exports["vorp_inventory"]:addItem(playerSource, itemName, amount, {})
    end)

    if ok and added ~= false then
        return true
    end

    print(("[mosquito trace] collect fallback vorp add failed item=%s amount=%s error=%s"):format(
        tostring(itemName),
        tostring(amount),
        tostring(added)
    ))

    local rsgOk, rsgAdded = pcall(function()
        return exports["rsg-inventory"]:AddItem(playerSource, itemName, amount)
    end)

    return rsgOk and rsgAdded ~= false
end

local function MosquitoCrusherChooseReward(rawItem, rawAmount)
    rawItem = tostring(rawItem or ""):lower()
    rawAmount = tonumber(rawAmount) or 1

    local pool = MosquitoCrusherFallbackPools[rawItem] or MosquitoCrusherFallbackPools.stone
    local totalWeight = 0
    for _, reward in ipairs(pool) do
        totalWeight = totalWeight + (tonumber(reward.weight) or 0)
    end

    if totalWeight <= 0 then
        return "coal", "Coal", math.max(1, math.floor(rawAmount / 4))
    end

    local roll = math.random(totalWeight)
    local cursor = 0
    local selected = pool[1]
    for _, reward in ipairs(pool) do
        cursor = cursor + (tonumber(reward.weight) or 0)
        if roll <= cursor then
            selected = reward
            break
        end
    end

    local minAmount = tonumber(selected.min) or 1
    local maxAmount = tonumber(selected.max) or minAmount
    if maxAmount < minAmount then
        maxAmount = minAmount
    end

    local baseAmount = math.random(minAmount, maxAmount)
    local scale = math.max(1, math.floor(rawAmount / 5))
    return selected.item, selected.label or selected.item, math.max(1, baseAmount * scale)
end

local function MosquitoCrusherPendingKey(playerSource)
    return tostring(tonumber(playerSource) or playerSource or "")
end

local MosquitoCrusherClaimFallback

local function MosquitoCrusherRememberRawRemoval(playerSource, itemName, amount)
    if not IsDuplicityVersion() or not MosquitoCrusherIsRawItem(itemName) then
        return
    end

    playerSource = tonumber(playerSource)
    amount = tonumber(amount) or 0
    if not playerSource or playerSource <= 0 or amount <= 0 then
        return
    end

    local rewardItem, rewardLabel, rewardAmount = MosquitoCrusherChooseReward(itemName, amount)
    local key = MosquitoCrusherPendingKey(playerSource)
    MosquitoCrusherFallbackStates[key] = {
        source = playerSource,
        rawItem = tostring(itemName),
        rawAmount = amount,
        rewardItem = rewardItem,
        rewardLabel = rewardLabel,
        rewardAmount = rewardAmount,
        beforeRewardCount = MosquitoGetInventoryCount(playerSource, rewardItem),
        createdAt = GetGameTimer and GetGameTimer() or 0,
        normalAddSeen = false,
    }

    print(("[mosquito trace] crusher fallback pending source=%s raw=%s amount=%s reward=%s x%s before=%s"):format(
        tostring(playerSource),
        tostring(itemName),
        tostring(amount),
        tostring(rewardItem),
        tostring(rewardAmount),
        tostring(MosquitoCrusherFallbackStates[key].beforeRewardCount)
    ))

    local createdAt = MosquitoCrusherFallbackStates[key].createdAt
    SetTimeout(10 * 60 * 1000, function()
        local state = MosquitoCrusherFallbackStates[key]
        if state and state.createdAt == createdAt then
            MosquitoCrusherFallbackStates[key] = nil
        end
    end)
end

local function MosquitoCrusherRememberInventoryAdd(playerSource, itemName, amount)
    if not IsDuplicityVersion() then
        return
    end

    local key = MosquitoCrusherPendingKey(playerSource)
    local state = MosquitoCrusherFallbackStates[key]
    if type(state) ~= "table" then
        return
    end

    if itemName and not MosquitoCrusherIsRawItem(itemName) then
        state.normalAddSeen = true
        print(("[mosquito trace] crusher fallback observed normal add source=%s item=%s amount=%s"):format(
            tostring(playerSource),
            tostring(itemName),
            tostring(amount)
        ))
    end
end

MosquitoCrusherClaimFallback = function(playerSource, reason)
    if not IsDuplicityVersion() then
        return
    end

    playerSource = tonumber(playerSource)
    local key = MosquitoCrusherPendingKey(playerSource)
    local state = MosquitoCrusherFallbackStates[key]
    if not playerSource or playerSource <= 0 or type(state) ~= "table" then
        print(("[mosquito trace] crusher fallback claim ignored source=%s reason=%s pending=false"):format(
            tostring(playerSource),
            tostring(reason)
        ))
        return
    end

    if MosquitoCrusherFallbackLocks[key] then
        return
    end

    MosquitoCrusherFallbackLocks[key] = true
    SetTimeout(1500, function()
        MosquitoCrusherFallbackLocks[key] = nil
        local current = MosquitoCrusherFallbackStates[key]
        if type(current) ~= "table" or current.createdAt ~= state.createdAt then
            return
        end

        local afterRewardCount = MosquitoGetInventoryCount(playerSource, current.rewardItem)
        if current.normalAddSeen or afterRewardCount > (tonumber(current.beforeRewardCount) or 0) then
            print(("[mosquito trace] crusher fallback skipped source=%s reward=%s before=%s after=%s normalAdd=%s"):format(
                tostring(playerSource),
                tostring(current.rewardItem),
                tostring(current.beforeRewardCount),
                tostring(afterRewardCount),
                tostring(current.normalAddSeen)
            ))
            MosquitoCrusherFallbackStates[key] = nil
            return
        end

        local added = MosquitoAddInventoryItem(playerSource, current.rewardItem, current.rewardAmount)
        local finalCount = MosquitoGetInventoryCount(playerSource, current.rewardItem)
        print(("[mosquito trace] crusher fallback add result source=%s raw=%s rawAmount=%s reward=%s amount=%s added=%s before=%s after=%s final=%s reason=%s"):format(
            tostring(playerSource),
            tostring(current.rawItem),
            tostring(current.rawAmount),
            tostring(current.rewardItem),
            tostring(current.rewardAmount),
            tostring(added),
            tostring(current.beforeRewardCount),
            tostring(afterRewardCount),
            tostring(finalCount),
            tostring(reason)
        ))

        if added then
            MosquitoCrusherFallbackStates[key] = nil
            TriggerClientEvent("chat:addMessage", playerSource, {
                args = { "mosquito trace", ("fallback crusher reward %s x%s"):format(tostring(current.rewardItem), tostring(current.rewardAmount)) }
            })
            TriggerClientEvent("ox_lib:notify", playerSource, {
                title = ("Received %sx %s"):format(tostring(current.rewardAmount), tostring(current.rewardLabel or current.rewardItem)),
                type = "success",
                duration = 5000
            })
        end
    end)
end

if IsDuplicityVersion() and not _G.__mosquito_blacksmith_crusher_fallback_server then
    _G.__mosquito_blacksmith_crusher_fallback_server = true

    AddEventHandler("mosquito_blacksmith:server:crusherRawRemoved", function(playerSource, itemName, amount)
        MosquitoCrusherRememberRawRemoval(playerSource, itemName, amount)
    end)

    AddEventHandler("mosquito_blacksmith:server:inventoryItemAdded", function(playerSource, itemName, amount)
        MosquitoCrusherRememberInventoryAdd(playerSource, itemName, amount)
    end)

    RegisterNetEvent("mosquito_blacksmith:server:crusherCollectFallback", function(promptText, groupText)
        MosquitoCrusherClaimFallback(source, ("prompt text=%s group=%s"):format(tostring(promptText), tostring(groupText)))
    end)
end

local function MosquitoRememberSmeltState(eventName, ...)
    if not IsDuplicityVersion() or tostring(eventName) ~= "mosquito-mining:client:SmelterState" then
        return
    end

    local forgeId, stateName, stateData = ...
    if type(forgeId) ~= "string" then
        return
    end

    if tostring(stateName) == "done" and type(stateData) == "table" then
        local itemName = stateData.item or stateData.SmeltedItem
        local amount = tonumber(stateData.totalAmount or stateData.amount or stateData.SmeltedAmount)

        if itemName and amount and amount > 0 then
            MosquitoSmeltFallbackStates[forgeId] = {
                item = itemName,
                amount = amount,
                label = stateData.itemLabel or stateData.SmeltedItemLabel or itemName,
                jobId = stateData.jobId,
                ownerCharId = stateData.ownerCharId,
            }

            print(("[mosquito trace] remembered smelt fallback forge=%s item=%s amount=%s"):format(
                tostring(forgeId),
                tostring(itemName),
                tostring(amount)
            ))
        end
    elseif stateName ~= nil and not MosquitoCollectFallbackPendingForges[forgeId] then
        MosquitoSmeltFallbackStates[forgeId] = nil
    end
end

local function MosquitoSendSmelterIdle(playerSource, forgeId, reason)
    TriggerClientEvent("mosquito-mining:client:SmelterState", -1, forgeId, "idle", {})
    SetTimeout(750, function()
        TriggerClientEvent("mosquito-mining:client:SmelterState", playerSource, forgeId, "idle", {})
    end)

    print(("[mosquito trace] collect fallback sent idle state source=%s forge=%s reason=%s"):format(
        tostring(playerSource),
        tostring(forgeId),
        tostring(reason)
    ))
end

local function MosquitoScheduleCollectFallback(eventName, eventSource, ...)
    if not IsDuplicityVersion() or tostring(eventName) ~= "mosquito-mining:server:CollectSmelt" then
        return
    end

    local playerSource = tonumber(eventSource)
    local forgeId = select(1, ...)
    local state = type(forgeId) == "string" and MosquitoSmeltFallbackStates[forgeId] or nil

    if not playerSource or playerSource <= 0 or type(state) ~= "table" or not state.item then
        return
    end

    local amount = tonumber(state.amount) or 0
    if amount <= 0 then
        return
    end

    local lockKey = ("%s:%s:%s:%s:%s"):format(
        tostring(playerSource),
        tostring(forgeId),
        tostring(state.item),
        tostring(amount),
        tostring(state.jobId or "")
    )

    if MosquitoCollectFallbackLocks[lockKey] then
        return
    end

    MosquitoCollectFallbackLocks[lockKey] = true
    MosquitoCollectFallbackPendingForges[forgeId] = true
    local fallbackDelayMs = 5000
    local beforeCount = MosquitoGetInventoryCount(playerSource, state.item)
    print(("[mosquito trace] collect fallback armed source=%s forge=%s item=%s amount=%s before=%s delayMs=%s"):format(
        tostring(playerSource),
        tostring(forgeId),
        tostring(state.item),
        tostring(amount),
        tostring(beforeCount),
        tostring(fallbackDelayMs)
    ))

    SetTimeout(fallbackDelayMs, function()
        MosquitoCollectFallbackLocks[lockKey] = nil
        MosquitoCollectFallbackPendingForges[forgeId] = nil

        local currentState = MosquitoSmeltFallbackStates[forgeId]
        if type(currentState) ~= "table" or currentState.item ~= state.item then
            return
        end

        local afterCount = MosquitoGetInventoryCount(playerSource, state.item)
        if afterCount >= beforeCount + amount then
            print(("[mosquito trace] collect fallback skipped; normal addItem already succeeded item=%s before=%s after=%s"):format(
                tostring(state.item),
                tostring(beforeCount),
                tostring(afterCount)
            ))
            MosquitoSmeltFallbackStates[forgeId] = nil
            return
        end

        local added = MosquitoAddInventoryItem(playerSource, state.item, amount)
        local finalCount = MosquitoGetInventoryCount(playerSource, state.item)
        print(("[mosquito trace] collect fallback add result source=%s forge=%s item=%s amount=%s added=%s before=%s after=%s final=%s"):format(
            tostring(playerSource),
            tostring(forgeId),
            tostring(state.item),
            tostring(amount),
            tostring(added),
            tostring(beforeCount),
            tostring(afterCount),
            tostring(finalCount)
        ))

        if added then
            MosquitoSmeltFallbackStates[forgeId] = nil
            MosquitoSendSmelterIdle(playerSource, forgeId, "fallback-add")
            TriggerClientEvent("chat:addMessage", playerSource, {
                args = { "mosquito trace", ("fallback collected %s x%s"):format(tostring(state.item), tostring(amount)) }
            })
        end
    end)
end

local function MosquitoWrapPublicCommandHandler(commandName, handler)
    if not IsDuplicityVersion()
        or not MosquitoCommandShouldBePublic(commandName)
        or type(handler) ~= "function" then
        return handler
    end

    return function(source, args, rawCommand)
        local playerSource = tonumber(source)
        if playerSource and playerSource > 0 and GetResourceState("blacksmith_hotfix") == "started" then
            local ok, result, message = pcall(function()
                return exports["blacksmith_hotfix"]:EnsureVorpCharacter(playerSource)
            end)

            if not ok then
                print(("[mosquito trace] placeforge db compat export failed: %s"):format(tostring(result)))
            elseif result == false then
                print(("[mosquito trace] placeforge db compat skipped: %s"):format(tostring(message)))
            end
        end

        return handler(source, args, rawCommand)
    end
end

if IsDuplicityVersion() and not _G.__mosquito_blacksmith_placeforge_bridge then
    _G.__mosquito_blacksmith_placeforge_bridge = true

    RegisterNetEvent("blacksmith_hotfix:mosquito:placeforge", function(playerSource, args, rawCommand, requestId, reply)
        if type(requestId) == "function" and reply == nil then
            reply = requestId
            requestId = nil
        end

        playerSource = tonumber(playerSource)
        if not playerSource or playerSource <= 0 then
            local msg = "bridge placeforge missing player source"
            print(("[mosquito trace] %s"):format(msg))
            if requestId then
                TriggerEvent("blacksmith_hotfix:mosquito:placeforgeResult", requestId, playerSource, false, msg)
            end
            if type(reply) == "function" then reply(false, msg) end
            return
        end

        if type(MosquitoPlaceForgeHandler) ~= "function" then
            local msg = "bridge placeforge handler is not registered yet"
            MosquitoNotify(playerSource, msg, "error")
            if requestId then
                TriggerEvent("blacksmith_hotfix:mosquito:placeforgeResult", requestId, playerSource, false, msg)
            end
            if type(reply) == "function" then reply(false, msg) end
            return
        end

        local msg = ("bridge executing internal placeforge command=%s source=%s args=%s"):format(
            tostring(MosquitoPlaceForgeCommandName),
            tostring(playerSource),
            json.encode(args or {})
        )
        MosquitoNotify(playerSource, msg, "inform")
        MosquitoStartBridgeTrace(playerSource)

        local ok, err = pcall(function()
            return MosquitoPlaceForgeHandler(playerSource, args or {}, rawCommand or "placeforge")
        end)

        if type(reply) == "function" then
            reply(ok, ok and msg or tostring(err))
        end

        if requestId then
            TriggerEvent("blacksmith_hotfix:mosquito:placeforgeResult", requestId, playerSource, ok, ok and msg or tostring(err))
        end

        if not ok then
            MosquitoNotify(playerSource, ("bridge placeforge handler failed: %s"):format(tostring(err)), "error")
        end
    end)

    RegisterNetEvent("blacksmith_hotfix:mosquito:status", function(requestId, reply)
        if type(requestId) == "function" and reply == nil then
            reply = requestId
            requestId = nil
        end

        local commands = {}
        local ok, registeredCommands = pcall(GetRegisteredCommands)
        if ok and type(registeredCommands) == "table" then
            for _, command in ipairs(registeredCommands) do
                local name = type(command) == "table" and tostring(command.name or "") or ""
                local lower = name:lower()
                if lower:find("forge", 1, true) or lower:find("place", 1, true) then
                    commands[#commands + 1] = name
                end
            end
        end
        table.sort(commands)

        if type(reply) == "function" then
            reply({
                handler = type(MosquitoPlaceForgeHandler) == "function",
                command = MosquitoPlaceForgeCommandName,
                commands = commands,
            })
        end

        if requestId then
            TriggerEvent("blacksmith_hotfix:mosquito:statusResult", requestId, {
                handler = type(MosquitoPlaceForgeHandler) == "function",
                command = MosquitoPlaceForgeCommandName,
                commands = commands,
            })
        end
    end)
end

if not _G.__mosquito_blacksmith_trace_wrapped then
    _G.__mosquito_blacksmith_trace_wrapped = true
    print(("[mosquito trace] %s wrapper loaded placeforge-public=20260616"):format(
        IsDuplicityVersion() and "server" or "client"
    ))

    local originalRegisterCommand = RegisterCommand
    RegisterCommand = function(commandName, handler, restricted)
        local forcedPublic = MosquitoCommandShouldBePublic(commandName)
        if forcedPublic then
            restricted = false
        end

        if MosquitoTraceShouldPrint(commandName) then
            print(("[mosquito trace] %s RegisterCommand %s restricted=%s forcedPublic=%s"):format(
                IsDuplicityVersion() and "server" or "client",
                tostring(commandName),
                tostring(restricted),
                tostring(forcedPublic)
            ))
        end

        local wrappedHandler = MosquitoWrapPublicCommandHandler(commandName, handler)
        if IsDuplicityVersion() and MosquitoCommandShouldBePublic(commandName) then
            MosquitoPlaceForgeHandler = wrappedHandler
            MosquitoPlaceForgeCommandName = tostring(commandName)
            print(("[mosquito trace] captured internal placeforge handler command=%s"):format(tostring(commandName)))
        end

        return originalRegisterCommand(commandName, wrappedHandler, restricted)
    end

    local function MosquitoWrapTraceHandler(eventName, handler)
        if type(handler) ~= "function" or not MosquitoTraceShouldPrint(eventName) then
            return handler
        end

        return function(...)
            local eventSource = nil
            local srcText = ""
            if IsDuplicityVersion() then
                eventSource = tonumber(source)
                srcText = (" source=%s"):format(tostring(eventSource))
            end

            local message = ("%s handler %s%s args=%s"):format(
                IsDuplicityVersion() and "server" or "client",
                tostring(eventName),
                srcText,
                MosquitoTraceEncodeArgs(...)
            )

            print(("[mosquito trace] %s"):format(message))

            if eventSource and eventSource > 0 then
                TriggerClientEvent("chat:addMessage", eventSource, {
                    args = { "mosquito trace", message }
                })
            end

            MosquitoScheduleCollectFallback(eventName, eventSource, ...)

            local results = table.pack(pcall(handler, ...))
            if not results[1] then
                local errorMessage = ("%s handler error: %s"):format(tostring(eventName), tostring(results[2]))
                print(("[mosquito trace] %s"):format(errorMessage))
                if eventSource and eventSource > 0 then
                    TriggerClientEvent("chat:addMessage", eventSource, {
                        args = { "mosquito trace", errorMessage }
                    })
                end
                error(tostring(results[2]))
            end

            return table.unpack(results, 2, results.n)
        end
    end

    local originalRegisterNetEvent = RegisterNetEvent
    RegisterNetEvent = function(eventName, ...)
        local args = table.pack(...)
        if type(args[1]) == "function" then
            args[1] = MosquitoWrapTraceHandler(eventName, args[1])
        end

        if MosquitoTraceShouldPrint(eventName) then
            print(("[mosquito trace] %s RegisterNetEvent %s"):format(
                IsDuplicityVersion() and "server" or "client",
                tostring(eventName)
            ))
        end

        return originalRegisterNetEvent(eventName, table.unpack(args, 1, args.n))
    end

    local originalAddEventHandler = AddEventHandler
    AddEventHandler = function(eventName, handler)
        handler = MosquitoWrapTraceHandler(eventName, handler)

        if MosquitoTraceShouldPrint(eventName) then
            print(("[mosquito trace] %s AddEventHandler %s"):format(
                IsDuplicityVersion() and "server" or "client",
                tostring(eventName)
            ))
        end

        return originalAddEventHandler(eventName, handler)
    end

    local originalTriggerEvent = TriggerEvent
    TriggerEvent = function(eventName, ...)
        if MosquitoTraceShouldPrint(eventName) then
            print(("[mosquito trace] %s TriggerEvent %s args=%s"):format(
                IsDuplicityVersion() and "server" or "client",
                tostring(eventName),
                MosquitoTraceEncodeArgs(...)
            ))
        end

        return originalTriggerEvent(eventName, ...)
    end

    if not IsDuplicityVersion() and type(TriggerServerEvent) == "function" then
        local originalTriggerServerEvent = TriggerServerEvent
        TriggerServerEvent = function(eventName, ...)
            if MosquitoTraceShouldPrint(eventName) then
                local msg = ("client TriggerServerEvent %s args=%s"):format(
                    tostring(eventName),
                    MosquitoTraceEncodeArgs(...)
                )
                print(("[mosquito trace] %s"):format(msg))
                originalTriggerEvent("chat:addMessage", {
                    args = { "mosquito trace", msg }
                })
            end

            return originalTriggerServerEvent(eventName, ...)
        end
    end

    if IsDuplicityVersion() then
        if type(IsPlayerAceAllowed) == "function" and not _G.__mosquito_blacksmith_ace_wrapped then
            _G.__mosquito_blacksmith_ace_wrapped = true
            local originalIsPlayerAceAllowed = IsPlayerAceAllowed
            IsPlayerAceAllowed = function(playerSource, ace)
                local targetSource = tonumber(playerSource)
                if targetSource and MosquitoIsBridgeTracing(targetSource) then
                    print(("[mosquito trace] IsPlayerAceAllowed override target=%s ace=%s result=true"):format(
                        tostring(targetSource),
                        tostring(ace)
                    ))
                    return true
                end

                return originalIsPlayerAceAllowed(playerSource, ace)
            end
        end

        local originalTriggerClientEvent = TriggerClientEvent
        TriggerClientEvent = function(eventName, target, ...)
            MosquitoRememberSmeltState(eventName, ...)

            local targetSource = tonumber(target)
            if targetSource and MosquitoIsBridgeTracing(targetSource) then
                local eventText = tostring(eventName)
                if eventText ~= "chat:addMessage" and eventText ~= "ox_lib:notify" then
                    local msg = ("TriggerClientEvent %s target=%s args=%s"):format(
                        eventText,
                        tostring(targetSource),
                        MosquitoTraceEncodeArgs(...)
                    )
                    print(("[mosquito trace] %s"):format(msg))
                    originalTriggerClientEvent("chat:addMessage", targetSource, {
                        args = { "mosquito trace", msg }
                    })
                end
            elseif MosquitoTraceShouldPrint(eventName) then
                print(("[mosquito trace] server TriggerClientEvent %s target=%s"):format(
                    tostring(eventName),
                    tostring(target)
                ))
            end

            return originalTriggerClientEvent(eventName, target, ...)
        end
    end
end

if not IsDuplicityVersion() and not _G.__mosquito_blacksmith_grindstone_prompt_guard then
    _G.__mosquito_blacksmith_grindstone_prompt_guard = true

    local promptGuardVersion = "20260616-grindstone-release4"
    local unpackArgs = table.unpack or unpack
    local promptByHandle = {}
    local promptGroups = {}
    local varStringText = {}
    local lastGrindstoneDistance = nil
    local lastGrindstoneObject = nil
    local lastSuppressAt = 0
    local lastRestoreAt = 0
    local activeSuppressCount = 0
    local promptSuppressCount = 0
    local promptRestoreCount = 0
    local forgeWakeUntil = 0
    local forgeWakeReason = "none"
    local forgeWakeForgeId = nil
    local lastForgeWakeReport = 0
    local crusherCollectLastAt = {}
    local originalPromptSetEnabled = nil
    local originalPromptSetVisible = nil
    local originalPromptSetActiveGroupThisFrame = nil

    local promptHashes = {
        registerBegin = 0x04F97DE45A519419,
        setText = 0x5DD02A8318420DD7,
        setGroup = 0x2F11D3A254169EA4,
        setEnabled = 0x8A0FB4D03A630D21,
        setVisible = 0x71215ACCFDE075EE,
        activeGroup = 0xC65A45D4453C2627,
        delete = 0x00EDE88D4D13CF59,
    }

    local function PromptGuardNow()
        return (GetGameTimer and GetGameTimer()) or 0
    end

    local function PromptGuardText(value)
        if value == nil then
            return nil
        end

        if type(value) == "string" then
            return value
        end

        return varStringText[value]
    end

    local function PromptGuardNativeKind(hash)
        for name, value in pairs(promptHashes) do
            if hash == value then
                return name
            end

            local hashText = tostring(hash):lower()
            local valueText = tostring(value):lower()
            if hashText == valueText then
                return name
            end

            local ok, valueHex = pcall(function()
                return ("0x%x"):format(value):lower()
            end)
            if ok and hashText == valueHex then
                return name
            end
        end

        return nil
    end

    local function PromptGuardIsGrindstoneText(text)
        text = tostring(text or ""):lower()
        return text:find("grind", 1, true) ~= nil
            or text:find("grinding wheel", 1, true) ~= nil
    end

    local function PromptGuardIsCollectText(text)
        text = tostring(text or ""):lower()
        return text:find("collect", 1, true) ~= nil
    end

    local function PromptGuardIsCrusherCollectText(text)
        text = tostring(text or ""):lower()
        return text:find("collect", 1, true) ~= nil
            and text:find("activate", 1, true) == nil
    end

    local function PromptGuardIsCrusherCollectPrompt(promptText, groupText)
        promptText = tostring(promptText or ""):lower()
        groupText = tostring(groupText or ""):lower()
        local hasCollect = PromptGuardIsCrusherCollectText(promptText)
            or PromptGuardIsCrusherCollectText(groupText)
        local hasCrushedRockContext = groupText:find("crushed", 1, true) ~= nil
            or groupText:find("crushed rocks", 1, true) ~= nil
            or promptText:find("crushed", 1, true) ~= nil
            or promptText:find("crushed rocks", 1, true) ~= nil

        return hasCollect and hasCrushedRockContext
    end

    local function PromptGuardIsForgeText(text)
        text = tostring(text or ""):lower()
        if text == "" or PromptGuardIsCollectText(text) then
            return false
        end

        return text:find("forge", 1, true) ~= nil
            or text:find("blacksmith", 1, true) ~= nil
    end

    local function PromptGuardDistanceBetween(a, b)
        if not a or not b then
            return nil
        end

        local dx = (a.x or 0.0) - (b.x or 0.0)
        local dy = (a.y or 0.0) - (b.y or 0.0)
        local dz = (a.z or 0.0) - (b.z or 0.0)
        return math.sqrt((dx * dx) + (dy * dy) + (dz * dz))
    end

    local function PromptGuardNearMineNode(playerCoords)
        if not Config or type(Config.mineData) ~= "table" then
            return false
        end

        local range = tonumber(Config.MineDistance) or 2.0
        range = range + 1.5

        for _, mine in pairs(Config.mineData) do
            local nodes = type(mine) == "table" and mine.Nodes or nil
            if type(nodes) == "table" then
                for _, nodeCoords in pairs(nodes) do
                    local distance = PromptGuardDistanceBetween(playerCoords, nodeCoords)
                    if distance and distance <= range then
                        return true
                    end
                end
            end
        end

        return false
    end

    local function PromptGuardNearestGrindstoneDistance()
        local ok, distance, object = pcall(function()
            if type(PlayerPedId) ~= "function" or type(GetEntityCoords) ~= "function" then
                return nil, nil
            end

            local ped = PlayerPedId()
            if not ped or ped == 0 then
                return nil, nil
            end

            local coords = GetEntityCoords(ped)
            if not coords then
                return nil, nil
            end

            local modelName = "p_grindingwheel01x"
            if Config and type(Config.GrindstoneProp) == "string" and Config.GrindstoneProp ~= "" then
                modelName = Config.GrindstoneProp
            end

            local modelHash = GetHashKey(modelName)
            local searchRadius = math.max((tonumber(Config and Config.ForgeToolMaxDistance) or 4.0) + 8.0, 12.0)
            local foundObject = GetClosestObjectOfType(coords.x, coords.y, coords.z, searchRadius, modelHash, false, false, false)
            if foundObject and foundObject ~= 0 and DoesEntityExist(foundObject) then
                return PromptGuardDistanceBetween(coords, GetEntityCoords(foundObject)), foundObject
            end

            return nil, nil
        end)

        if ok then
            lastGrindstoneDistance = distance
            lastGrindstoneObject = object
            return distance, object
        end

        lastGrindstoneDistance = nil
        lastGrindstoneObject = nil
        return nil, nil
    end

    local function PromptGuardNearGrindstone()
        local distance = PromptGuardNearestGrindstoneDistance()
        local range = tonumber(Config and Config.ForgeToolMaxDistance) or 4.0
        return distance ~= nil and distance <= (range + 0.75)
    end

    local function PromptGuardShouldSuppressPrompt(prompt)
        local state = promptByHandle[prompt]
        if not state or not state.grindstone then
            return false
        end

        if PromptGuardNearGrindstone() then
            return false
        end

        return true
    end

    local function PromptGuardShouldSuppressGroup(group, groupLabel)
        local groupState = promptGroups[group]

        if not groupState then
            return false
        end

        if not groupState.grindstone then
            return false
        end

        if PromptGuardNearGrindstone() then
            return false
        end

        local ok, playerCoords = pcall(function()
            return GetEntityCoords(PlayerPedId())
        end)
        if ok and PromptGuardNearMineNode(playerCoords) then
            return false
        end

        return true
    end

    local function PromptGuardCallNative(hash, ...)
        local native = _G.__mosquito_blacksmith_original_invoke_native
        if type(native) ~= "function" and Citizen and type(Citizen.InvokeNative) == "function" then
            native = Citizen.InvokeNative
        end
        if type(native) ~= "function" and type(InvokeNative) == "function" then
            native = InvokeNative
        end

        if type(native) == "function" then
            return pcall(native, hash, ...)
        end

        return false
    end

    local function PromptGuardForceHidePrompt(prompt)
        local touched = false

        if originalPromptSetEnabled then
            local ok = pcall(originalPromptSetEnabled, prompt, false)
            touched = touched or ok
        end
        if originalPromptSetVisible then
            local ok = pcall(originalPromptSetVisible, prompt, false)
            touched = touched or ok
        end

        local okEnabled = PromptGuardCallNative(promptHashes.setEnabled, prompt, false)
        local okVisible = PromptGuardCallNative(promptHashes.setVisible, prompt, false)
        touched = touched or okEnabled or okVisible

        if touched then
            promptSuppressCount = promptSuppressCount + 1
            lastSuppressAt = PromptGuardNow()
        end

        return touched
    end

    local function PromptGuardForceShowPrompt(prompt)
        local touched = false

        if originalPromptSetEnabled then
            local ok = pcall(originalPromptSetEnabled, prompt, true)
            touched = touched or ok
        end
        if originalPromptSetVisible then
            local ok = pcall(originalPromptSetVisible, prompt, true)
            touched = touched or ok
        end

        local okEnabled = PromptGuardCallNative(promptHashes.setEnabled, prompt, true)
        local okVisible = PromptGuardCallNative(promptHashes.setVisible, prompt, true)
        touched = touched or okEnabled or okVisible

        if touched then
            promptRestoreCount = promptRestoreCount + 1
            lastRestoreAt = PromptGuardNow()
        end

        return touched
    end

    local function PromptGuardMakeLabel(labelText)
        labelText = tostring(labelText or "Forge")
        if type(CreateVarString) == "function" then
            local ok, label = pcall(CreateVarString, 10, "LITERAL_STRING", labelText)
            if ok then
                return label
            end
        end

        return labelText
    end

    local function PromptGuardActivateGroup(group, labelText)
        local label = PromptGuardMakeLabel(labelText or "Forge")
        if originalPromptSetActiveGroupThisFrame then
            pcall(originalPromptSetActiveGroupThisFrame, group, label)
        end

        PromptGuardCallNative(promptHashes.activeGroup, group, label)
    end

    local function PromptGuardWakeForgePrompts()
        local touched = false
        local forgePrompts = 0
        local forgeGroups = {}
        local countedPrompts = {}

        for prompt, state in pairs(promptByHandle) do
            if state and (state.forge or PromptGuardIsForgeText(state.text)) then
                forgePrompts = forgePrompts + 1
                countedPrompts[prompt] = true
                touched = PromptGuardForceShowPrompt(prompt) or touched
                if state.group then
                    forgeGroups[state.group] = true
                end
            end
        end

        for group, groupState in pairs(promptGroups) do
            if groupState and (groupState.forge or PromptGuardIsForgeText(groupState.lastActiveText)) then
                forgeGroups[group] = true
            end
        end

        local forgeGroupCount = 0
        for group in pairs(forgeGroups) do
            forgeGroupCount = forgeGroupCount + 1
            local groupState = promptGroups[group]
            local labelText = (groupState and PromptGuardIsForgeText(groupState.lastActiveText) and groupState.lastActiveText) or "Forge"
            if groupState and type(groupState.prompts) == "table" then
                for prompt in pairs(groupState.prompts) do
                    local state = promptByHandle[prompt]
                    if state and not PromptGuardIsCollectText(state.text) then
                        if not countedPrompts[prompt] then
                            forgePrompts = forgePrompts + 1
                            countedPrompts[prompt] = true
                        end
                        touched = PromptGuardForceShowPrompt(prompt) or touched
                    end
                end
            end
            PromptGuardActivateGroup(group, labelText)
        end

        return touched, forgePrompts, forgeGroupCount
    end

    local function PromptGuardBuildSummary()
        local prompts = 0
        local forgePrompts = 0
        local grindPrompts = 0
        local groups = 0
        local forgeGroups = 0
        local countedPrompts = {}
        local labels = {}

        for prompt, state in pairs(promptByHandle) do
            prompts = prompts + 1
            if state.grindstone then
                grindPrompts = grindPrompts + 1
            end
            if state.forge or PromptGuardIsForgeText(state.text) then
                forgePrompts = forgePrompts + 1
                countedPrompts[prompt] = true
                labels[#labels + 1] = tostring(state.text or "?")
            end
        end

        for _, groupState in pairs(promptGroups) do
            groups = groups + 1
            if groupState.forge or PromptGuardIsForgeText(groupState.lastActiveText) then
                forgeGroups = forgeGroups + 1
                if type(groupState.prompts) == "table" then
                    for prompt in pairs(groupState.prompts) do
                        local state = promptByHandle[prompt]
                        if state and not countedPrompts[prompt] and not PromptGuardIsCollectText(state.text) then
                            forgePrompts = forgePrompts + 1
                            countedPrompts[prompt] = true
                            labels[#labels + 1] = tostring(state.text or "?")
                        end
                    end
                end
            end
        end

        return ("prompts=%s groups=%s forgePrompts=%s forgeGroups=%s grindPrompts=%s wakeUntil=%s reason=%s forgeId=%s labels=%s"):format(
            tostring(prompts),
            tostring(groups),
            tostring(forgePrompts),
            tostring(forgeGroups),
            tostring(grindPrompts),
            tostring(forgeWakeUntil),
            tostring(forgeWakeReason),
            tostring(forgeWakeForgeId),
            table.concat(labels, ",")
        )
    end

    local function PromptGuardRememberPrompt(prompt)
        if prompt ~= nil and prompt ~= 0 and not promptByHandle[prompt] then
            promptByHandle[prompt] = {}
        end

        return promptByHandle[prompt]
    end

    local function PromptGuardRememberText(prompt, label)
        local state = PromptGuardRememberPrompt(prompt)
        if not state then
            return
        end

        state.text = PromptGuardText(label) or state.text
        if PromptGuardIsGrindstoneText(state.text) then
            state.grindstone = true
            if state.group then
                promptGroups[state.group] = promptGroups[state.group] or { prompts = {} }
                promptGroups[state.group].grindstone = true
            end
        end

        if PromptGuardIsForgeText(state.text) then
            state.forge = true
            if state.group then
                promptGroups[state.group] = promptGroups[state.group] or { prompts = {} }
                promptGroups[state.group].forge = true
            end
        end
    end

    local function PromptGuardRememberGroup(prompt, group)
        local state = PromptGuardRememberPrompt(prompt)
        if not state then
            return
        end

        state.group = group
        promptGroups[group] = promptGroups[group] or { prompts = {} }
        promptGroups[group].prompts[prompt] = true
        if state.grindstone then
            promptGroups[group].grindstone = true
        end
        if state.forge then
            promptGroups[group].forge = true
        end
    end

    local function PromptGuardForgetPrompt(prompt)
        local state = promptByHandle[prompt]
        if state and state.group and promptGroups[state.group] then
            promptGroups[state.group].prompts[prompt] = nil
        end

        promptByHandle[prompt] = nil
    end

    local function PromptGuardTrackActiveGroup(group, groupLabel)
        local groupState = promptGroups[group]
        if not groupState then
            return
        end

        local labelText = PromptGuardText(groupLabel)
        if labelText then
            groupState.lastActiveText = labelText
            if PromptGuardIsGrindstoneText(labelText) then
                groupState.grindstone = true
            end
            if PromptGuardIsForgeText(labelText) then
                groupState.forge = true
            end
        end
    end

    local function PromptGuardTriggerCrusherCollectFallback(prompt)
        if IsDuplicityVersion() or type(TriggerServerEvent) ~= "function" then
            return false
        end

        local state = promptByHandle[prompt]
        local promptText = state and state.text or ""
        local groupText = ""
        if state and state.group and promptGroups[state.group] then
            groupText = promptGroups[state.group].lastActiveText or ""
        end

        if not PromptGuardIsCrusherCollectPrompt(promptText, groupText) then
            return false
        end

        local now = PromptGuardNow()
        local key = tostring(prompt or "unknown")
        if now - (crusherCollectLastAt[key] or 0) < 3500 then
            return true
        end

        crusherCollectLastAt[key] = now
        print(("[mosquito trace] crusher collect fallback trigger prompt=%s text=%s group=%s"):format(
            tostring(prompt),
            tostring(promptText),
            tostring(groupText)
        ))
        TriggerServerEvent("mosquito_blacksmith:server:crusherCollectFallback", promptText, groupText)
        return true
    end

    local function PromptGuardDisableGroupPrompts(group, originalSetEnabled, originalSetVisible)
        local groupState = promptGroups[group]
        if not groupState or type(groupState.prompts) ~= "table" then
            return
        end

        for prompt in pairs(groupState.prompts) do
            local state = promptByHandle[prompt]
            if state and state.grindstone then
                PromptGuardForceHidePrompt(prompt)
            end
        end
    end

    if type(CreateVarString) == "function" and not _G.__mosquito_blacksmith_original_create_var_string then
        _G.__mosquito_blacksmith_original_create_var_string = CreateVarString
        local originalCreateVarString = CreateVarString
        CreateVarString = function(...)
            local result = originalCreateVarString(...)
            for index = 1, select("#", ...) do
                local value = select(index, ...)
                if type(value) == "string" and value ~= "LITERAL_STRING" then
                    varStringText[result] = value
                    break
                end
            end
            return result
        end
    end

    originalPromptSetEnabled = PromptSetEnabled
    originalPromptSetVisible = PromptSetVisible
    if type(PromptRegisterBegin) == "function" then
        local originalPromptRegisterBegin = PromptRegisterBegin
        PromptRegisterBegin = function(...)
            local prompt = originalPromptRegisterBegin(...)
            PromptGuardRememberPrompt(prompt)
            return prompt
        end
    end

    if type(PromptSetText) == "function" then
        local originalPromptSetText = PromptSetText
        PromptSetText = function(prompt, label, ...)
            PromptGuardRememberText(prompt, label)
            return originalPromptSetText(prompt, label, ...)
        end
    end

    if type(PromptSetGroup) == "function" then
        local originalPromptSetGroup = PromptSetGroup
        PromptSetGroup = function(prompt, group, ...)
            PromptGuardRememberGroup(prompt, group)
            return originalPromptSetGroup(prompt, group, ...)
        end
    end

    if type(PromptSetEnabled) == "function" then
        originalPromptSetEnabled = PromptSetEnabled
        PromptSetEnabled = function(prompt, enabled, ...)
            if enabled and PromptGuardShouldSuppressPrompt(prompt) then
                promptSuppressCount = promptSuppressCount + 1
                lastSuppressAt = PromptGuardNow()
                enabled = false
            end
            return originalPromptSetEnabled(prompt, enabled, ...)
        end
    end

    if type(PromptSetVisible) == "function" then
        originalPromptSetVisible = PromptSetVisible
        PromptSetVisible = function(prompt, visible, ...)
            if visible and PromptGuardShouldSuppressPrompt(prompt) then
                promptSuppressCount = promptSuppressCount + 1
                lastSuppressAt = PromptGuardNow()
                visible = false
            end
            return originalPromptSetVisible(prompt, visible, ...)
        end
    end

    if type(PromptSetActiveGroupThisFrame) == "function" then
        originalPromptSetActiveGroupThisFrame = PromptSetActiveGroupThisFrame
        PromptSetActiveGroupThisFrame = function(group, label, ...)
            PromptGuardTrackActiveGroup(group, label)
            if PromptGuardShouldSuppressGroup(group, label) then
                activeSuppressCount = activeSuppressCount + 1
                lastSuppressAt = PromptGuardNow()
                PromptGuardDisableGroupPrompts(group, originalPromptSetEnabled, originalPromptSetVisible)
                return
            end
            return originalPromptSetActiveGroupThisFrame(group, label, ...)
        end
    end

    if type(PromptDelete) == "function" then
        local originalPromptDelete = PromptDelete
        PromptDelete = function(prompt, ...)
            PromptGuardForgetPrompt(prompt)
            return originalPromptDelete(prompt, ...)
        end
    end

    local function PromptGuardInvokeNativeProxy(originalInvokeNative)
        return function(hash, ...)
            local args = table.pack(...)
            local nativeKind = PromptGuardNativeKind(hash)

            if nativeKind == "registerBegin" then
                local prompt = originalInvokeNative(hash, unpackArgs(args, 1, args.n))
                PromptGuardRememberPrompt(prompt)
                return prompt
            end

            if nativeKind == "setText" then
                PromptGuardRememberText(args[1], args[2])
            elseif nativeKind == "setGroup" then
                PromptGuardRememberGroup(args[1], args[2])
            elseif nativeKind == "setEnabled" or nativeKind == "setVisible" then
                if args[2] and PromptGuardShouldSuppressPrompt(args[1]) then
                    promptSuppressCount = promptSuppressCount + 1
                    lastSuppressAt = PromptGuardNow()
                    args[2] = false
                end
            elseif nativeKind == "activeGroup" then
                PromptGuardTrackActiveGroup(args[1], args[2])
                if PromptGuardShouldSuppressGroup(args[1], args[2]) then
                    activeSuppressCount = activeSuppressCount + 1
                    lastSuppressAt = PromptGuardNow()
                    PromptGuardDisableGroupPrompts(args[1], originalPromptSetEnabled, originalPromptSetVisible)
                    return
                end
            elseif nativeKind == "delete" then
                PromptGuardForgetPrompt(args[1])
            end

            return originalInvokeNative(hash, unpackArgs(args, 1, args.n))
        end
    end

    if Citizen and type(Citizen.InvokeNative) == "function" and not _G.__mosquito_blacksmith_original_invoke_native then
        _G.__mosquito_blacksmith_original_invoke_native = Citizen.InvokeNative
        local originalInvokeNative = Citizen.InvokeNative
        Citizen.InvokeNative = PromptGuardInvokeNativeProxy(originalInvokeNative)
    end

    local promptGuardHookedFunctions = {}
    local promptGuardHookedInvoke = {}

    local function PromptGuardInstallCreateVarStringHook()
        if type(CreateVarString) ~= "function" or promptGuardHookedFunctions.CreateVarString == CreateVarString then
            return
        end

        local originalCreateVarString = CreateVarString
        CreateVarString = function(...)
            local result = originalCreateVarString(...)
            for index = 1, select("#", ...) do
                local value = select(index, ...)
                if type(value) == "string" and value ~= "LITERAL_STRING" then
                    varStringText[result] = value
                    break
                end
            end
            return result
        end
        promptGuardHookedFunctions.CreateVarString = CreateVarString
    end

    local function PromptGuardInstallFunctionHook(name, factory)
        local current = _G[name]
        if type(current) ~= "function" or promptGuardHookedFunctions[name] == current then
            return
        end

        _G[name] = factory(current)
        promptGuardHookedFunctions[name] = _G[name]
    end

    local function PromptGuardInstallInvokeHook(container, key, hookKey)
        if type(container) ~= "table" or type(container[key]) ~= "function" or promptGuardHookedInvoke[hookKey] == container[key] then
            return
        end

        local originalInvokeNative = container[key]
        container[key] = PromptGuardInvokeNativeProxy(originalInvokeNative)
        promptGuardHookedInvoke[hookKey] = container[key]
    end

    local function PromptGuardInstallLateHooks()
        PromptGuardInstallCreateVarStringHook()

        PromptGuardInstallFunctionHook("PromptRegisterBegin", function(original)
            return function(...)
                local prompt = original(...)
                PromptGuardRememberPrompt(prompt)
                return prompt
            end
        end)

        PromptGuardInstallFunctionHook("UiPromptRegisterBegin", function(original)
            return function(...)
                local prompt = original(...)
                PromptGuardRememberPrompt(prompt)
                return prompt
            end
        end)

        PromptGuardInstallFunctionHook("PromptSetText", function(original)
            return function(prompt, label, ...)
                PromptGuardRememberText(prompt, label)
                return original(prompt, label, ...)
            end
        end)

        PromptGuardInstallFunctionHook("UiPromptSetText", function(original)
            return function(prompt, label, ...)
                PromptGuardRememberText(prompt, label)
                return original(prompt, label, ...)
            end
        end)

        PromptGuardInstallFunctionHook("PromptSetGroup", function(original)
            return function(prompt, group, ...)
                PromptGuardRememberGroup(prompt, group)
                return original(prompt, group, ...)
            end
        end)

        PromptGuardInstallFunctionHook("UiPromptSetGroup", function(original)
            return function(prompt, group, ...)
                PromptGuardRememberGroup(prompt, group)
                return original(prompt, group, ...)
            end
        end)

        PromptGuardInstallFunctionHook("PromptSetEnabled", function(original)
            originalPromptSetEnabled = originalPromptSetEnabled or original
            return function(prompt, enabled, ...)
                if enabled and PromptGuardShouldSuppressPrompt(prompt) then
                    promptSuppressCount = promptSuppressCount + 1
                    lastSuppressAt = PromptGuardNow()
                    enabled = false
                end
                return original(prompt, enabled, ...)
            end
        end)

        PromptGuardInstallFunctionHook("UiPromptSetEnabled", function(original)
            originalPromptSetEnabled = originalPromptSetEnabled or original
            return function(prompt, enabled, ...)
                if enabled and PromptGuardShouldSuppressPrompt(prompt) then
                    promptSuppressCount = promptSuppressCount + 1
                    lastSuppressAt = PromptGuardNow()
                    enabled = false
                end
                return original(prompt, enabled, ...)
            end
        end)

        PromptGuardInstallFunctionHook("PromptSetVisible", function(original)
            originalPromptSetVisible = originalPromptSetVisible or original
            return function(prompt, visible, ...)
                if visible and PromptGuardShouldSuppressPrompt(prompt) then
                    promptSuppressCount = promptSuppressCount + 1
                    lastSuppressAt = PromptGuardNow()
                    visible = false
                end
                return original(prompt, visible, ...)
            end
        end)

        PromptGuardInstallFunctionHook("UiPromptSetVisible", function(original)
            originalPromptSetVisible = originalPromptSetVisible or original
            return function(prompt, visible, ...)
                if visible and PromptGuardShouldSuppressPrompt(prompt) then
                    promptSuppressCount = promptSuppressCount + 1
                    lastSuppressAt = PromptGuardNow()
                    visible = false
                end
                return original(prompt, visible, ...)
            end
        end)

        PromptGuardInstallFunctionHook("PromptSetActiveGroupThisFrame", function(original)
            originalPromptSetActiveGroupThisFrame = originalPromptSetActiveGroupThisFrame or original
            return function(group, label, ...)
                PromptGuardTrackActiveGroup(group, label)
                if PromptGuardShouldSuppressGroup(group, label) then
                    activeSuppressCount = activeSuppressCount + 1
                    lastSuppressAt = PromptGuardNow()
                    PromptGuardDisableGroupPrompts(group, originalPromptSetEnabled, originalPromptSetVisible)
                    return
                end
                return original(group, label, ...)
            end
        end)

        PromptGuardInstallFunctionHook("UiPromptSetActiveGroupThisFrame", function(original)
            originalPromptSetActiveGroupThisFrame = originalPromptSetActiveGroupThisFrame or original
            return function(group, label, ...)
                PromptGuardTrackActiveGroup(group, label)
                if PromptGuardShouldSuppressGroup(group, label) then
                    activeSuppressCount = activeSuppressCount + 1
                    lastSuppressAt = PromptGuardNow()
                    PromptGuardDisableGroupPrompts(group, originalPromptSetEnabled, originalPromptSetVisible)
                    return
                end
                return original(group, label, ...)
            end
        end)

        PromptGuardInstallFunctionHook("PromptDelete", function(original)
            return function(prompt, ...)
                PromptGuardForgetPrompt(prompt)
                return original(prompt, ...)
            end
        end)

        PromptGuardInstallFunctionHook("UiPromptDelete", function(original)
            return function(prompt, ...)
                PromptGuardForgetPrompt(prompt)
                return original(prompt, ...)
            end
        end)

        PromptGuardInstallFunctionHook("PromptHasHoldModeCompleted", function(original)
            return function(prompt, ...)
                local completed = original(prompt, ...)
                if completed then
                    PromptGuardTriggerCrusherCollectFallback(prompt)
                end
                return completed
            end
        end)

        PromptGuardInstallFunctionHook("UiPromptHasHoldModeCompleted", function(original)
            return function(prompt, ...)
                local completed = original(prompt, ...)
                if completed then
                    PromptGuardTriggerCrusherCollectFallback(prompt)
                end
                return completed
            end
        end)

        PromptGuardInstallFunctionHook("PromptHasStandardModeCompleted", function(original)
            return function(prompt, ...)
                local completed = original(prompt, ...)
                if completed then
                    PromptGuardTriggerCrusherCollectFallback(prompt)
                end
                return completed
            end
        end)

        PromptGuardInstallFunctionHook("UiPromptHasStandardModeCompleted", function(original)
            return function(prompt, ...)
                local completed = original(prompt, ...)
                if completed then
                    PromptGuardTriggerCrusherCollectFallback(prompt)
                end
                return completed
            end
        end)

        if Citizen then
            PromptGuardInstallInvokeHook(Citizen, "InvokeNative", "Citizen.InvokeNative")
        end

        PromptGuardInstallInvokeHook(_G, "InvokeNative", "InvokeNative")
    end

    PromptGuardInstallLateHooks()

    CreateThread(function()
        while true do
            local sleep = 750
            local touchedGrindstonePrompt = false
            local nearGrindstone = PromptGuardNearGrindstone()
            PromptGuardInstallLateHooks()
            if not nearGrindstone then
                for prompt, state in pairs(promptByHandle) do
                    if state and state.grindstone then
                        touchedGrindstonePrompt = true
                        PromptGuardForceHidePrompt(prompt)
                    end
                end

                for group, groupState in pairs(promptGroups) do
                    if groupState and groupState.grindstone then
                        touchedGrindstonePrompt = true
                        PromptGuardDisableGroupPrompts(group, originalPromptSetEnabled, originalPromptSetVisible)
                    end
                end
            else
                for prompt, state in pairs(promptByHandle) do
                    if state and state.grindstone then
                        touchedGrindstonePrompt = true
                        PromptGuardForceShowPrompt(prompt)
                    end
                end
            end

            if touchedGrindstonePrompt then
                sleep = 250
            end

            local now = PromptGuardNow()
            if forgeWakeUntil > now then
                local touchedForgePrompt, forgePrompts, forgeGroups = PromptGuardWakeForgePrompts()
                touchedGrindstonePrompt = touchedGrindstonePrompt or touchedForgePrompt
                sleep = 0

                if now - lastForgeWakeReport > 1000 then
                    lastForgeWakeReport = now
                    print(("[mosquito trace] forgewake active prompts=%s groups=%s reason=%s forgeId=%s summary=%s"):format(
                        tostring(forgePrompts),
                        tostring(forgeGroups),
                        tostring(forgeWakeReason),
                        tostring(forgeWakeForgeId),
                        PromptGuardBuildSummary()
                    ))
                end
            end

            Wait(sleep)
        end
    end)

    RegisterNetEvent("mosquito_blacksmith:client:wakeForgePrompts", function(forgeId, reason)
        forgeWakeUntil = PromptGuardNow() + 6000
        forgeWakeReason = tostring(reason or "unknown")
        forgeWakeForgeId = forgeId
        lastForgeWakeReport = 0

        local touchedForgePrompt, forgePrompts, forgeGroups = PromptGuardWakeForgePrompts()
        local summary = PromptGuardBuildSummary()
        print(("[mosquito trace] forgewake start touched=%s prompts=%s groups=%s reason=%s forgeId=%s summary=%s"):format(
            tostring(touchedForgePrompt),
            tostring(forgePrompts),
            tostring(forgeGroups),
            tostring(forgeWakeReason),
            tostring(forgeWakeForgeId),
            summary
        ))
        TriggerEvent("chat:addMessage", {
            args = { "mosquito trace", ("forgewake %s"):format(summary) }
        })
    end)

    RegisterCommand("bsprompts", function()
        local summary = PromptGuardBuildSummary()
        print(("[mosquito trace] bsprompts %s"):format(summary))
        TriggerEvent("chat:addMessage", {
            args = { "mosquito trace", ("bsprompts %s"):format(summary) }
        })
    end, false)

    RegisterCommand("bscrusherclaim", function()
        print("[mosquito trace] manual crusher fallback claim requested")
        TriggerEvent("chat:addMessage", {
            args = { "mosquito trace", "manual crusher fallback claim requested" }
        })
        TriggerServerEvent("mosquito_blacksmith:server:crusherCollectFallback", "command", "command")
    end, false)

    RegisterCommand("bsgrindprompt", function()
        local prompts = 0
        local grindPrompts = 0
        local grindGroups = 0
        local labels = {}

        for _, state in pairs(promptByHandle) do
            prompts = prompts + 1
            if state.grindstone then
                grindPrompts = grindPrompts + 1
                labels[#labels + 1] = tostring(state.text or "?")
            end
        end

        for _, groupState in pairs(promptGroups) do
            if groupState.grindstone then
                grindGroups = grindGroups + 1
            end
        end

        local distance = PromptGuardNearestGrindstoneDistance()
        local message = ("grindguard=%s prompts=%s grindPrompts=%s grindGroups=%s distance=%s object=%s activeSuppressed=%s promptSuppressed=%s promptRestored=%s lastSuppress=%s lastRestore=%s labels=%s"):format(
            promptGuardVersion,
            tostring(prompts),
            tostring(grindPrompts),
            tostring(grindGroups),
            distance and string.format("%.2f", distance) or "none",
            tostring(lastGrindstoneObject),
            tostring(activeSuppressCount),
            tostring(promptSuppressCount),
            tostring(promptRestoreCount),
            tostring(lastSuppressAt),
            tostring(lastRestoreAt),
            table.concat(labels, ",")
        )

        print(("[mosquito trace] %s"):format(message))
        TriggerEvent("chat:addMessage", {
            args = { "mosquito trace", message }
        })
    end, false)

    print(("[mosquito trace] client grindstone prompt guard loaded %s"):format(promptGuardVersion))
end
