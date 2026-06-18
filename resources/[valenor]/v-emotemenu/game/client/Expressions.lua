
RegisterCommand('mood', function(source, args, rawCommand)
    if #args == 0 then 
        ClearFacialIdleAnimOverride(PlayerPedId())
        return
    end
    
    local animationName = args[1]
    local animationData = nil
    local category = nil
    
    if Valenor.Expressions[animationName] then
        animationData = Valenor.Expressions[animationName]
        category = "Expressions"
    end
    
    if animationData and category then
        TriggerServerEvent('v-emotemenu:server:playEmote', animationData)
        PlayExpressionAnimation(category, animationName, animationData)
    end
end, false)

function PlayExpressionAnimation(category, animationKey, animationData)
    if animationData.name then
        if animationKey == "clear" then
            ClearFacialIdleAnimOverride(PlayerPedId())
        else
            if animationData.dict then
                RequestAnimDict(animationData.dict)
                while not HasAnimDictLoaded(animationData.dict) do 
                    Wait(1)
                end
            end
            
            if animationData.dict then
                SetFacialIdleAnimOverride(PlayerPedId(), animationData.name, animationData.dict)
            else
                SetFacialIdleAnimOverride(PlayerPedId(), animationData.name, 0)
            end
        end
    end
end