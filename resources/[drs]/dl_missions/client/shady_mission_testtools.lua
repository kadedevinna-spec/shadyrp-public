RegisterNUICallback('shadyResetMission', function(data, cb)
    local missionId = data and tonumber(data.missionId)

    if missionId then
        TriggerServerEvent('dl_missions:server:shadyResetMissionById', missionId)
    end

    SetNuiFocus(false, false)
    SendNUIMessage({ action = 'closeMissionUI' })

    cb({ ok = missionId ~= nil })
end)
