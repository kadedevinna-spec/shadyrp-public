
function PlayEmoteAnimation(category, animationKey, animationData)
    if animationData.emote then
        local emoteHash = GetHashKey(animationData.emote)
        local options = animationData.options or {}
        if string.find(animationData.emote, "KIT_EMOTE") then
            TaskEmote(PlayerPedId(), 0, 2, emoteHash, true, true, true, true, true)
        else
            TaskStartScenarioInPlace(PlayerPedId(), emoteHash, 0, true)
        end
    elseif animationData.dict and animationData.name then
        RequestAnimDict(animationData.dict)
        while not HasAnimDictLoaded(animationData.dict) do
            Citizen.Wait(100)
        end

        local options = animationData.options or {}
        local loop = options.loop or false
        local movable = options.movable or false
        local stopLastFrame = options.stop_last_frame or false
        local flag = 0
        
        if not loop and not movable and not stopLastFrame then
            flag = 0
        elseif loop and not movable then
            flag = 1
        elseif not loop and not movable and stopLastFrame then
            flag = 2
        elseif not loop and movable and stopLastFrame then
            flag = 30
        elseif loop and movable then
            flag = 31
        elseif not loop and movable then
            flag = 28
        end
        
        TaskPlayAnim(PlayerPedId(), animationData.dict, animationData.name, 8.0, 8.0, -1, flag, 0.0, false, false, false)
        SetPedKeepTask(PlayerPedId(), true)
    end
end
