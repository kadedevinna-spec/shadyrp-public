
local currentWalkStyle = nil

RegisterCommand('walk', function(source, args, rawCommand)
    if #args == 0 then 
        if currentWalkStyle then
            Citizen.InvokeNative(0xA6F67BEC53379A32, PlayerPedId(), currentWalkStyle)
        end
        Citizen.InvokeNative(0xCB9401F918CB0F75, PlayerPedId(), "MP_Style_Casual", 1, -1)
        currentWalkStyle = "MP_Style_Casual"
        return
    end
    
    local animationName = args[1]
    local animationData = nil
    local category = nil
    
    if Valenor.Walks[animationName] then
        animationData = Valenor.Walks[animationName]
        category = "Walks"
    end
    
    if animationData and category then
        TriggerServerEvent('v-emotemenu:server:playEmote', animationData)
        PlayWalkAnimation(category, animationName, animationData)
    end
end, false)

function PlayWalkAnimation(category, animationKey, animationData)
    if animationData.name then
        if currentWalkStyle then
            Citizen.InvokeNative(0xA6F67BEC53379A32, PlayerPedId(), currentWalkStyle)
        end
        Citizen.InvokeNative(0xCB9401F918CB0F75, PlayerPedId(), animationData.name, 1, -1)
        currentWalkStyle = animationData.name
    end
end

RegisterNetEvent('v-emotemenu:client:setWalkStyle', function(walkStyle)
    local player = PlayerPedId()
    if walkStyle == "noanim" or walkStyle == "" then
        if currentWalkStyle then
            Citizen.InvokeNative(0xA6F67BEC53379A32, player, currentWalkStyle)
        end
        Citizen.InvokeNative(0xCB9401F918CB0F75, player, "MP_Style_Casual", 1, -1)
        currentWalkStyle = "MP_Style_Casual"
    else
        if currentWalkStyle then
            Citizen.InvokeNative(0xA6F67BEC53379A32, player, currentWalkStyle)
        end
        Citizen.InvokeNative(0xCB9401F918CB0F75, player, walkStyle, 1, -1)
        currentWalkStyle = walkStyle
    end
end)