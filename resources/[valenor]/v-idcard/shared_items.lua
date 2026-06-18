CreateThread(function()
    Wait(2000)
    
    if GetResourceState('rsg-core') ~= 'started' then
        return
    end
    
    local success, RSGCore = pcall(function()
        return exports['rsg-core']:GetCoreObject()
    end)
    
    if not success or not RSGCore then
        return
    end
    
    RSGCore.Shared.Items = RSGCore.Shared.Items or {}
    
    if not RSGCore.Shared.Items['idcard'] then
        RSGCore.Shared.Items['idcard'] = {
            name = 'idcard',
            label = 'ID Card',
            weight = 0,
            type = 'item',
            image = 'idcard.png',
            unique = true,
            useable = true,
            shouldClose = true,
            combinable = nil,
            description = 'Identification Card'
        }
    end
end)
