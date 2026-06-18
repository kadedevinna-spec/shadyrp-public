RegisterCommand('testar_todas', function()
    -- Tip
    TriggerEvent('dodi_notifys:Tip', "Testing TIP - Simple notification!", 4000)
    Wait(2000)
    
    -- NotifyLeft
    TriggerEvent('dodi_notifys:NotifyLeft', "Left title", "Left Side Notification", "generic_textures", "tick", 4000)
    Wait(2000)
    
    -- NotifyTop Citys
    TriggerEvent('dodi_notifys:NotifyTop', "Notification at the top", "TOWN_ARMADILLO", 4000)
    Wait(2000)
    
    -- ShowSimpleRightText
    TriggerEvent('dodi_notifys:ShowSimpleRightText', "SIMPLE TEXT ON THE RIGHT", 4000)
    Wait(2000)
    
    -- ShowObjective
    TriggerEvent('dodi_notifys:ShowObjective', "Objective notification", 4000)
    Wait(2000)
    
    -- ShowTopNotification
    TriggerEvent('dodi_notifys:ShowTopNotification', "Higher title", "Notification subtitle", 4000)
    Wait(2000)
    
    -- ShowAdvancedRightNotification
    TriggerEvent('dodi_notifys:ShowAdvancedRightNotification', "Advanced notification", "generic_textures", "tick", "COLOR_PURE_WHITE", 4000)
    Wait(2000)
    
    -- ShowBasicTopNotification
    TriggerEvent('dodi_notifys:ShowBasicTopNotification', "Superior Basic Notification", 4000)
    Wait(2000)
    
    -- ShowSimpleCenterText
    TriggerEvent('dodi_notifys:ShowSimpleCenterText', "Centralized Text", 4000)
end, false)

-- Comandos individuais para cada tipo
RegisterCommand('teste_tip', function()
    TriggerEvent('dodi_notifys:Tip', "Testing Tip!", 4000)
end, false)

RegisterCommand('teste_left', function()
    TriggerEvent('dodi_notifys:NotifyLeft', "Title", "Message on the left", "generic_textures", "tick", 4000)
end, false)

RegisterCommand('teste_top', function() ---- cidade
    TriggerEvent('dodi_notifys:NotifyTop', "Message at the top", "TOWN_ARMADILLO", 4000)
end, false)

RegisterCommand('teste_right', function()
    TriggerEvent('dodi_notifys:ShowSimpleRightText', "Right text", 4000)
end, false)

RegisterCommand('teste_objetivo', function()
    TriggerEvent('dodi_notifys:ShowObjective', "Mission objective", 4000)
end, false)

RegisterCommand('teste_top_full', function()
    TriggerEvent('dodi_notifys:ShowTopNotification', "Title", "Snotification ubtitle", 4000)
end, false)

RegisterCommand('teste_right_advanced', function()
    TriggerEvent('dodi_notifys:ShowAdvancedRightNotification', "Advanced notification", "generic_textures", "tick", "COLOR_PURE_WHITE", 4000)
end, false)

RegisterCommand('teste_top_basic', function()
    TriggerEvent('dodi_notifys:ShowBasicTopNotification', "Basic top notification", 4000)
end, false)

RegisterCommand('teste_center', function()
    TriggerEvent('dodi_notifys:ShowSimpleCenterText', "Centralized Text", 4000)
end, false) 