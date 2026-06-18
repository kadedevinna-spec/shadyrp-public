local JobData = {
    name = filename(),
    label = "Random Tasks",
    description = "Perform tasks at random locations",
    steps = {
        { action = "PlayAnimation"},
        { action = "PlayAnimation"},
        { action = "CompleteJob", reward = 50, label = "Complete", description = "Complete the tasks" },
    },
    board = { "armadillo" },
    image = "./img/Poster_art/train.png",
    reward = "$50",
}
if IsDuplicityVersion() then
    JobsConfig[filename()] = JobData
else
    local lang = {
        ["NextStep"] = "Next step",
        ["Finish"] = "Finish",
    }

    local randomLocations = {
        { name = "Broom", description = "Clean in front of the office", coords = vector3(-3626.562, -2605.512, -14.34603), anim = "WORLD_HUMAN_BROOM",                                         duration = 5000 },
        { name = "Clean the window", description = "Clean a bank's window", coords = vector3(-3670.741, -2622.23, -14.75258),  anim = { dict = "amb_work@world_human_clean_window@male_a@wip_base", anim = "wip_base" }, duration = 5000 },
        { name = "Plane Wood", description = "Clean the store",coords = vector3(-3649.337, -2605.526, -14.62258),  anim = "WORLD_HUMAN_STRAW_BROOM_WORKING",                                         duration = 5000 },
    }

    local blips = {}
    local Utils = {}
    local actions = {} --- table for functions

    actions["PlayAnimation"] = function(job)
        local data = job.steps[job.currentStep]
        local coords = data.coords
        local label = data.label
        local description = data.description
        local anim = data.anim
        local duration = data.duration
        TriggerEvent("murphy_jobpanel:ShowObjective", description, 4000)
        local blip = CreateBlip(coords, label, 'blip_objective', `BLIP_STYLE_OBJECTIVE`)
        table.insert(blips, blip)

        exports.murphy_interact:AddInteraction({
            coords = vector3(coords.x, coords.y, coords.z + 1.5),
            distance = 8.0,
            interactDst = 2.5,
            id = job.name .. "_step" .. job.currentStep,
            options = {
                {
                    label = label,
                    action = function(entity, coords, args)
                        local playerPed = PlayerPedId()
                        local startCoords = GetEntityCoords(playerPed)
                        if type(anim) == "string" then
                            local  scenariopointfound = false
                            local DataStruct = DataView.ArrayBuffer(256 * 4)
                            local is_data_exists = Citizen.InvokeNative(0x345EC3B7EBDE1CB5, GetEntityCoords(PlayerPedId()), 3.5, DataStruct:Buffer(), 10)
                            if is_data_exists ~= false then
                                for index = 1, is_data_exists, 1 do
                                    local scenario = DataStruct:GetInt32(8 * index)
                                    local hash = GetScenarioPointType(scenario)
                                    print (hash, GetHashKey(data.anim))
                                    if GetHashKey(data.anim) == hash then

                                        scenariopointfound = scenario
                                    end
                                end
                            end
                            if scenariopointfound == false then
                                TaskStartScenarioInPlace(playerPed, anim, -1, true)
                            else
                                TaskUseScenarioPoint(playerPed, scenariopointfound, "" , -1.0, true, false, 0, false, -1.0, true)
                            end 
                        elseif type(anim) == "table" then
                            LoadAnim(anim.dict)

                            TaskPlayAnim(playerPed, anim.dict, anim.anim, 8.0, 8.0, -1, 25, 0, 0, 0, 0)
                        end
                        Citizen.Wait(duration)
                        if #(GetEntityCoords(playerPed) - startCoords) > 10.0 then
                            ClearPedTasks(playerPed)
                            TriggerEvent("murphy_jobpanel:ShowObjective", "You moved too far, try again.", 4000)
                        else
                            ClearPedTasks(playerPed)
                            exports.murphy_interact:RemoveInteraction(job.name .. "_step" .. job.currentStep)
                            RemoveBlip(blip)
                            job:nextStep()
                        end
                    end,
                },
            }
        })
    end


    actions["CompleteJob"] = function(job)
        TriggerEvent("murphy_jobpanel:ShowObjective", lang["Finish"], 4000)
        Callback.triggerServer('AddCurrency', function() end, job.steps[job.currentStep].reward)
        job:nextStep()
        Utils.StopJob()

    end


    function Utils.StopJob()
        for _, blip in ipairs(blips) do
            if blip then
                RemoveBlip(blip)
            end
        end
        blips = {}
    end

    function Utils.createJob(jobData)
        local usedLocations = {}
        for _, step in ipairs(jobData.steps) do
            if step.action == "PlayAnimation" then
                local location
                repeat
                    location = randomLocations[math.random(#randomLocations)]
                until not usedLocations[location]
                usedLocations[location] = true
                step.coords = location.coords
                step.anim = location.anim
                step.duration = location.duration
                step.label = location.name
                step.description = location.description
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
        Utils.StopJob()
    end)
    return job
end
