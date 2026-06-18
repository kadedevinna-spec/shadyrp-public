local JobData = {
    name = filename(),
    label = "Item Delivery",
    description = "Deliver items in a specific order",
    steps = {
        { action = "DeliverItem" },
        { action = "DeliverItem" },
        { action = "DeliverItem" },
        { action = "CompleteJob", reward = 50, label = "Complete", description = "Complete the delivery" },
    },
    board = { "armadillo" },
    image = "./img/Poster_art/camp.png",
    reward = "$50",
}
if IsDuplicityVersion() then
    JobsConfig[filename()] = JobData
else
    local lang = {
        ["Delivery Point"] = "Delivery Point",
        ["Deliver"] = "Deliver",
        ["Finish"] = "Finish",
    }

    local deliveryLocations = {
        { label = "Deliver the item", description = "Deliver the item to the specified location",  coords = vector3(-3318.354, -2854.746, -7.087614), npc = { "a_m_m_armtownfolk_01", 90.0 },  item = { "water", 1 } },
        { label = "Deliver the item", description = "Deliver the item to the specified location",  coords = vector3(-3956.079, -2140.656, -5.978973), npc = { "a_m_m_armtownfolk_01", 180.0 }, item = { "water", 1 } },
        { label = "Deliver the item", description = "Deliver the item to the specified location",  coords = vector3(-4773.722, -2723.127, -14.84364), npc = { "a_m_m_armtownfolk_01", 270.0 }, item = { "water", 1 } },
    }

    local blips = {}
    local npcEntities = {}
    local Utils = {}
    local actions = {} --- table for functions



    actions["DeliverItem"] = function(job)
        local data = job.steps[job.currentStep]
        local npc = data.npc
        local coords = data.coords
        local need = data.item
        -- local blip = CreateBlip(coords, lang["Delivery Point"], 'blip_objective', `BLIP_STYLE_OBJECTIVE`)
        -- table.insert(blips, blip)
        TriggerEvent("murphy_jobpanel:ShowObjective", job.steps[job.currentStep].description, 4000)

        -- Spawn NPC
        RequestModel(GetHashKey(npc[1]))
        while not HasModelLoaded(GetHashKey(npc[1])) do
            Wait(1)
        end
        local npcEntity = CreatePed(GetHashKey(npc[1]), coords.x, coords.y, coords.z, npc[2], true, true)
        SetRandomOutfitVariation(npcEntity, true)
        SetEntityAsMissionEntity(npcEntity, true, true)
        PlacePedOnGroundProperly(npcEntity)
        -- SetEntityNoCollisionEntity(PlayerPedId(), npcEntity, false)
        SetEntityCanBeDamaged(npcEntity, false)
        SetEntityInvincible(npcEntity, true)
        SetModelAsNoLongerNeeded(GetHashKey(npc[1]))
        -- FreezeEntityPosition(npcEntity, true)
        TaskWanderInArea(npcEntity, coords, 30.0, 0, 0)
        local pedblip = CreateBlipEntity(npcEntity, job.steps[job.currentStep].label, `BLIP_STYLE_OBJECTIVE`, nil, `blip_ambient_vip`)
        table.insert(blips, pedblip)
        table.insert(npcEntities, npcEntity)
        exports.murphy_interact:AddEntityInteraction({
            netId = NetworkGetNetworkIdFromEntity(npcEntity),
            -- coords = vector3(coords.x, coords.y, coords.z + 1.5),
            distance = 8.0,
            interactDst = 4.0,
            id = job.name .. "_step" .. job.currentStep,
            options = {
                {
                    label = lang["Deliver"],
                    action = function(entity, coords, args)
                        local item = need[1]
                        local neededamount = need[2]
                        Callback.triggerServer('GetItemAmount', function(amount)
                            print (amount, neededamount)
                            if amount >= neededamount then
                                Callback.triggerServer('RemoveItem', function(result)
                                    if result then
                                        LoadAnim("script_common@gestures@unapproved@test@speaker")
                                        local selectedanim = math.random(1,6)
                                        TaskPlayAnim(npcEntity, "script_common@gestures@unapproved@test@speaker", "g_speak_howdy_0"..selectedanim, 8.0, 8.0, 2000, 25, 0, 0, 0, 0)
                                        local speech = {"1070_A_M_M_ARMTOWNFOLK_01_WHITE_01", "1071_A_M_M_ARMTOWNFOLK_01_WHITE_02", "1072_A_M_M_ARMTOWNFOLK_01_WHITE_03"}
                                        local selectedspeech = speech[math.random(1, #speech)]
                                        play_ambient_speech_from_entity(npcEntity,selectedspeech,"GENERIC_THANKS","speech_params_force",0)

                                        exports.murphy_interact:RemoveEntityInteraction(NetworkGetNetworkIdFromEntity(npcEntity), job.name .. "_step" .. job.currentStep)
                                        job:nextStep()
                                        -- Callback.triggerServer('AddCurrency', function() end, 1)
                                        RemoveBlip(pedblip)
                                        Wait(10000)
                                        DeleteEntity(npcEntity)
                                    end
                                end, item, neededamount, {})
                            end
                        end, item)
                    end,
                },
            }
        })

        Citizen.CreateThread(function()
            local step = job.currentStep
            while true do
                Wait(1000)
                if step ~= job.currentStep or job.abandon == true then
                    RemoveBlip(blip)
                    if job.abandon == true then
                        exports.murphy_interact:RemoveEntityInteraction(NetworkGetNetworkIdFromEntity(npcEntity), job.name .. "_step" .. job.currentStep)
                        DeleteEntity(npcEntity)
                        Utils.StopJob()
                    end
                    break
                end
            end
        end)
    end

    actions["CompleteJob"] = function(job)
        TriggerEvent("murphy_jobpanel:ShowObjective", lang["Finish"], 4000)
        Callback.triggerServer('AddCurrency', function() end, job.steps[job.currentStep].reward)
        job:nextStep()
        Wait(1000)
        Utils.StopJob()
    end

    function Utils.StopJob()
        for _, blip in ipairs(blips) do
            if blip then
                RemoveBlip(blip)
            end
        end
        blips = {}
        Wait(10000)
        for _, npcEntity in ipairs(npcEntities) do
            if DoesEntityExist(npcEntity) then
                DeleteEntity(npcEntity)
            end
        end
        npcEntities = {}
    end

    function Utils.createJob(jobData)
        for i, step in ipairs(jobData.steps) do
            if step.action == "DeliverItem" then
                local location = deliveryLocations[i]
                step.coords = location.coords
                step.npc = location.npc
                step.item = location.item
                step.description = location.description
                step.label = location.label
            end
            step.action = actions[step.action]
        end
        return Job:new(jobData)
    end

    local job = Utils.createJob(JobData)
    AddEventHandler("onResourceStop", function(resourceName)
        if GetCurrentResourceName() ~= resourceName then
            return
        end
        for _, npcEntity in ipairs(npcEntities) do
            if DoesEntityExist(npcEntity) then
                DeleteEntity(npcEntity)
            end
        end
    end)
    return job
end
