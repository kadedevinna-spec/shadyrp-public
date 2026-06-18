print("Emote Menu server script loaded")

RegisterNetEvent('v-emotemenu:server:playEmote', function(animationData)
    local src = source

    print("Player " .. src .. " played emote")
end)

RegisterNetEvent("v-emotemenu:server:syncPlayer", function(coords, heading, alpha, isFrozen)
    local source = source
    TriggerClientEvent("v-emotemenu:client:syncPlayer", -1, source, coords, heading, alpha, isFrozen or false)
end)

RegisterNetEvent("v-emotemenu:server:syncProps", function(payload)
    local source = source
    TriggerClientEvent("v-emotemenu:client:syncProps", -1, source, payload)
end)

RegisterNetEvent("v-emotemenu:server:clearProps", function()
    local source = source
    TriggerClientEvent("v-emotemenu:client:clearProps", -1, source)
end)

RegisterNetEvent("v-emotemenu:server:updateWorldProps", function(worldProps)
    local source = source
    TriggerClientEvent("v-emotemenu:client:updateWorldProps", -1, source, worldProps)
end)

local CoupleRequests = {}

RegisterNetEvent('v-emotemenu:server:requestAnimationSync', function(requesterId, targetId, category, animationKey, animationData, baseCoords, baseHeading)
    local src = source
    
    if src ~= requesterId then
        print("Player " .. src .. " tried to impersonate player " .. requesterId)
        return
    end

    CoupleRequests[requesterId] = {
        targetId = targetId,
        category = category,
        animationKey = animationKey,
        animationData = animationData,
        baseCoords = baseCoords,
        baseHeading = baseHeading,
        timestamp = os.time()
    }

    SetTimeout(15000, function()
        local data = CoupleRequests[requesterId]
        if data and data.timestamp and os.time() - data.timestamp >= 15 then
            CoupleRequests[requesterId] = nil
        end
    end)

    TriggerClientEvent('v-emotemenu:client:receiveAnimationRequest', targetId, requesterId, category, animationKey, animationData)
end)

RegisterNetEvent('v-emotemenu:server:acceptAnimationSync', function(requesterId, accepterId, category, animationKey, animationData)
    local src = source
    
    if src ~= accepterId then
        print("Player " .. src .. " tried to impersonate player " .. accepterId)
        return
    end

    local payload = CoupleRequests[requesterId]
    if not payload then
        payload = { baseCoords = nil, baseHeading = nil }
    else
        CoupleRequests[requesterId] = nil
    end

    local useCategory = (payload and payload.category)      or category
    local useAnimKey  = (payload and payload.animationKey)  or animationKey
    local useAnimData = (payload and payload.animationData) or animationData

    TriggerClientEvent('v-emotemenu:client:startSyncedAnimation', requesterId, accepterId, useCategory, useAnimKey, useAnimData, true,  payload.baseCoords, payload.baseHeading)
    TriggerClientEvent('v-emotemenu:client:startSyncedAnimation', accepterId, requesterId, useCategory, useAnimKey, useAnimData, false, payload.baseCoords, payload.baseHeading)
    
    TriggerClientEvent('chatMessage', requesterId, "[System]", {255, 255, 0}, "Animasyon isteğiniz kabul edildi.")
end)

RegisterNetEvent('v-emotemenu:server:saveWalkStyle', function(walkStyle)
    local src = source
    print("Player " .. src .. " set walk style: " .. walkStyle)

end)

RegisterNetEvent('v-emotemenu:server:restoreCoupleCollision', function(partnerId)
    local src = source
    TriggerClientEvent('v-emotemenu:client:remoteRestoreCoupleCollision', src)
    if partnerId and partnerId ~= 0 then
        TriggerClientEvent('v-emotemenu:client:remoteRestoreCoupleCollision', partnerId)
    end
end)
