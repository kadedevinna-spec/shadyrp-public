local JobData = {
    name = filename(),
    label = "Street Sweeper",
    description = "Clean the streets of Saint Denis",
    steps = {
        { action = "PlayAnimation" },
        { action = "PlayAnimation" },
        { action = "CompleteJob", reward = 30, label = "Complete", description = "Collect your pay" },
    },
    board = { "sd" },
    image = "./img/Poster_art/train2.png",
    reward = "$30",
}if IsDuplicityVersion() then
    JobsConfig[filename()] = JobData
else
    local lang = {
        ["NextStep"] = "Next step",
        ["Finish"] = "Job complete!",
    }    local orderedLocations = {
        {
            name = "Sweep the porch",
            description = "Sweep in front of the general store",
            coords = vector3(2821.4602, -1311.7792, 46.7706),
            anim = "WORLD_HUMAN_BROOM",
            duration = 8000
        },
        {
            name = "Clean the window",
            description = "Wipe the bank window clean",
            coords = vector3(2634.8552, -1293.5884, 52.1469),
            anim = {
                dict = "amb_work@world_human_clean_window@male_a@wip_base",
                anim = "wip_base"
            },
            duration = 8000
        },
    }    local blips = {}
    local Utils = {}
    local actions = {}    actions["PlayAnimation"] = function(job)
        local data = job.steps[job.currentStep]
        local coords = data.coords
        local label = data.label
        local description = data.description
        local anim = data.anim
        local duration = data.duration
        TriggerEvent("murphy_jobpanel:ShowObjective", description, 4000)        local blip = CreateBlip(coords, label, 'blip_objective', BLIP_STYLE_OBJECTIVE)
        table.insert(blips, blip)        exports.murphy_interact:AddInteraction({
            coords = vector3(coords.x, coords.y, coords.z + 1.5),
            distance = 8.0,
            interactDst = 2.5,
            id = job.name .. "_step" .. job.currentStep,
            options = {
                {
                    label = label,
                    action = function(entity, coords, args)
                        local playerPed = PlayerPedId()
                        local startCoords = GetEntityCoords(playerPed)                        if type(anim) == "string" then
                            TaskStartScenarioInPlace(playerPed, anim, -1, true)
                        elseif type(anim) == "table" then
                            LoadAnim(anim.dict)
                            TaskPlayAnim(playerPed, anim.dict, anim.anim, 8.0, 8.0, -1, 25, 0, 0, 0, 0)
                        end                        Citizen.Wait(duration)                        if #(GetEntityCoords(playerPed) - startCoords) > 10.0 then
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
    end    actions["CompleteJob"] = function(job)
        TriggerEvent("murphy_jobpanel:ShowObjective", lang["Finish"], 4000)
        Callback.triggerServer('AddCurrency', function() end, job.steps[job.currentStep].reward)
        job:nextStep()
        Utils.StopJob()
    end    function Utils.StopJob()
        for _, blip in ipairs(blips) do
            if blip then RemoveBlip(blip) end
        end
        blips = {}
    end    function Utils.createJob(jobData)
        for i, step in ipairs(jobData.steps) do
            if step.action == "PlayAnimation" then
                local location = orderedLocations[i]
                step.coords = location.coords
                step.anim = location.anim
                step.duration = location.duration
                step.description = location.description
                step.label = location.name
            end
            step.action = actions[step.action]
        end
        return Job:new(jobData)
    end    local job = Utils.createJob(JobData)    AddEventHandler("onResourceStop", function(resourceName)
        if GetCurrentResourceName() ~= resourceName then return end
        Utils.StopJob()
    end)    return job
end