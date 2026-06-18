local playerRagdoll = false
if Config.Ragdoll then 
    Citizen.CreateThread(function() 
        while true do 
            Citizen.Wait(10)
            if IsControlJustPressed(0, Config.KeyBinds["RAGDOLL"]) then
                if not playerRagdoll then 
                    playerRagdoll = true
                    SetPedToRagdoll(PlayerPedId(), 1000, 1000, 0, 0, 0, 0) 

                else
                    playerRagdoll = false
                end
                Citizen.Wait(200)
            end  
            if playerRagdoll then 
                ResetPedRagdollTimer(PlayerPedId())
            end
        end
    end) 
end
