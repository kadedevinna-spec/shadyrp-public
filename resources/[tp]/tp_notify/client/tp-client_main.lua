local HasNotificationActive = false
local CooldownTime          = 0

-----------------------------------------------------------
--[[ Events ]]--
-----------------------------------------------------------

RegisterNetEvent("tp_notify:sendNotification")
AddEventHandler("tp_notify:sendNotification", function(title, message, actionType, notifyType, duration, align )

	if align == nil then 
		align = "left"
	end

    if HasNotificationActive then
        CooldownTime = 1
    end

    while HasNotificationActive do
        Wait(250)
    end

    CooldownTime = duration
		
    HasNotificationActive = true

    SetNUIState(HasNotificationActive, title, message, actionType, notifyType, align)
end)

-----------------------------------------------------------
--[[ Notifications ]]--
-----------------------------------------------------------

OpenNUI = function ()
    SetNUIState(true)
end

SetNUIState = function(state, title, message, actionType, notifyType, align)

    HasNotificationActive = state

    if Config.NotifyTypes[notifyType] then
        notifyType = Config.NotifyTypes[notifyType]
    end

    if not align then
        align = 'left'
    end

	SendNUIMessage({
		type = "enable_ui",
		enable = state,
        title = title,
        message = message,
        actionType = actionType,
        color = notifyType,
        align = align,
	})

end

CloseNUIProperly = function ()
    
    if HasNotificationActive then
        SetNUIState(false)
    end
end

-----------------------------------------------------------
--[[ NUI Callbacks ]]--
-----------------------------------------------------------

RegisterNUICallback('close', function()
    Wait(1000)
	SetNUIState(false)
end)

-----------------------------------------------------------
--[[ NUI Callbacks ]]--
-----------------------------------------------------------

-- The following task is running properly the cooldown display timer.
-- It is mostly required when another notification is triggered while 
-- There is already one running.
Citizen.CreateThread(function() 
    while true do
        Wait(1000)

        if CooldownTime > 0 then
            CooldownTime = CooldownTime - 1

            if CooldownTime <= 0 then

                CooldownTime = 0

                SendNUIMessage({action = 'close'})
            end

        end

    end
end)

