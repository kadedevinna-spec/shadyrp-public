local JobData = {
    name = filename(),
    label = "Random Animal Hunting",
    description = "Hunt animals at random locations",
    steps = {
        { action = "HuntAnimal" },
        { action = "HuntAnimal" },
        { action = "CompleteJob", reward = 100, label = "Finish", description = "Complete the hunt" },
    },
    board = { "armadillo" },
    image = "./img/Poster_art/hunt2.png",
    reward = "$100",
}

if IsDuplicityVersion() then
    JobsConfig[filename()] = JobData
else
    local lang = {
        ["NextStep"] = "Next step",
        ["Kill Animal"] = "Kill Animal",
        ["Finish"] = "Finish",
    }

    local huntingLocations = {
        { label = "Location 1", description = "Kill the beasts 1", coords = vector3(-3312.757, -2826.725, -6.813381), radius = 50.0, animal = "a_c_wolf", count = 3 },
        { label = "Location 2", description = "Kill the beasts 2", coords = vector3(-3956.079, -2140.656, -5.978973), radius = 50.0, animal = "a_c_wolf", count = 4 },
        { label = "Location 3", description = "Kill the beasts 3", coords = vector3(-4773.722, -2723.127, -14.84364), radius = 50.0, animal = "a_c_bear_01", count = 1 },
        { label = "Location 4", description = "Kill the beasts 4", coords = vector3(-5217.904, -2120.502, 11.68457), radius = 50.0, animal = "a_c_bear_01", count = 2 },
        { label = "Location 5", description = "Kill the beasts 5", coords = vector3(-5498.94, -2932.629, -1.423192), radius = 50.0, animal = "a_c_cougar_01", count = 1 },
        { label = "Location 6", description = "Kill the beasts 6", coords = vector3(-5987.83, -3229.936, -22.14742), radius = 50.0, animal = "a_c_cougar_01", count = 2 },
        { label = "Location 7", description = "Kill the beasts 7", coords = vector3(-5225.704, -3480.168, -21.56653), radius = 50.0, animal = "a_c_cougar_01", count = 3 },
    }

    local blips = {}
    local animalEntities = {}
    local Utils = {}
    local actions = {} --- table for functions

    AddRelationshipGroup("animalstokill")
    SetRelationshipBetweenGroups(5, GetHashKey("animalstokill"), GetHashKey("PLAYER"))
    SetRelationshipBetweenGroups(5, GetHashKey("PLAYER"), GetHashKey("animalstokill"))

    actions["HuntAnimal"] = function(job)
        local data = job.steps[job.currentStep]
        local coords = data.coords
        local radius = data.radius
        local animals = data.animals
        local blip = CreateBlipRadius(coords, radius, job.steps[job.currentStep].label, 'blip_objective', `BLIP_STYLE_OBJECTIVE`)
        table.insert(blips, blip)
        TriggerEvent("murphy_jobpanel:ShowObjective", job.steps[job.currentStep].description, 4000)

        Citizen.CreateThread(function()
            while true do
                Wait(1000)
                local playerCoords = GetEntityCoords(PlayerPedId())
                if #(playerCoords - coords) < 200.0 then
                    for _, animal in ipairs(animals) do
                        -- Spawn Animal
                        local randomCoords = vector3(
                            coords.x + math.random(-radius, radius),
                            coords.y + math.random(-radius, radius),
                            coords.z
                        )
                        RequestModel(GetHashKey(animal))
                        while not HasModelLoaded(GetHashKey(animal)) do
                            Wait(1)
                        end
                        local _, groundZ = GetGroundZFor_3dCoord(randomCoords.x, randomCoords.y, randomCoords.z, 1)
                        randomCoords = vector3(randomCoords.x, randomCoords.y, groundZ)
                        local animalEntity = CreatePed(GetHashKey(animal), randomCoords.x, randomCoords.y, randomCoords.z, 0.0, true, true)
                        local animalblip = CreateBlipEntity(animalEntity, lang["Kill Animal"], -839369609)
                        TaskWanderInArea(animalEntity, coords, radius, 0,0,false)
                        SetEntityAsMissionEntity(animalEntity, true, true)
                        SetRandomOutfitVariation(animalEntity, true)
                        SetPedRelationshipGroupHash(animalEntity, GetHashKey("animalstokill"))
                        Citizen.InvokeNative(0x9FF1E042FA597187,animalEntity, 22, 0)  -- SET_ANIMAL_TUNING_BOOL_PARAM  ATB_FleeMountedPeds
                        Citizen.InvokeNative(0x9FF1E042FA597187,animalEntity, 88, 1)  -- SET_ANIMAL_TUNING_BOOL_PARAM  ATB_WaitInsteadOfFleeForUnreachableVolumes
                        SetPedCombatAttributes(animalEntity, 58, true) -- 	CA_DISABLE_FLEE_FROM_COMBAT
                        table.insert(animalEntities, animalEntity)
                        table.insert(blips, animalblip)
                        SetModelAsNoLongerNeeded(GetHashKey(animal))
                    end

                    Citizen.CreateThread(function()
                        while true do
                            Wait(1000)
                            local allDead = true
                            for _, animalEntity in ipairs(animalEntities) do
                                if not IsEntityDead(animalEntity) then
                                    allDead = false
                                    break
                                end
                            end
                            if allDead then
                                exports.murphy_interact:RemoveInteraction(job.name .. "_step" .. job.currentStep)
                                RemoveBlip(blip)
                                job:nextStep()
                                break
                            end
                        end
                    end)
                    break
                end
            end
        end)

        Citizen.CreateThread(function()     ---- this thread will check if the job is abandon and will delete the interaction
            local step = job.currentStep
            while true do
                Wait(1000)
                if step ~= job.currentStep or job.abandon == true then
                    RemoveBlip(blip)
                    if job.abandon == true then
                        for _, animalEntity in ipairs(animalEntities) do
                            NetworkRequestControlOfEntity(animalEntity --[[ Entity ]])
                            Wait(100)
                            print (NetworkHasControlOfEntity(animalEntity --[[ Entity ]]))
                            DeletePed(animalEntity)
                        end
                        ClearGpsMultiRoute()
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
        Utils.StopJob()
        job:nextStep()
        Wait(60*1000)
        for _, animalEntity in ipairs(animalEntities) do
            DeletePed(animalEntity)
        end
    end

    function Utils.StopJob()
        for _, blip in ipairs(blips) do
            if blip then
                RemoveBlip(blip)
            end
        end
        -- for _, animalEntity in ipairs(animalEntities) do
        --     DeletePed(animalEntity)
        -- end
        blips = {}
        -- animalEntities = {}
    end

    function Utils.createJob(jobData)
        local usedLocations = {}
        for _, step in ipairs(jobData.steps) do
            if step.action == "HuntAnimal" then
                local location
                repeat
                    location = huntingLocations[math.random(#huntingLocations)]
                until not usedLocations[location]
                usedLocations[location] = true
                step.coords = location.coords
                step.radius = location.radius
                step.animals = {}
                for j = 1, location.count do
                    table.insert(step.animals, location.animal)
                end
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
        for _, blip in ipairs(blips) do
            if blip then
                RemoveBlip(blip)
            end
        end
        for _, animalEntity in ipairs(animalEntities) do
            DeletePed(animalEntity)
        end
    end)
    return job
end
