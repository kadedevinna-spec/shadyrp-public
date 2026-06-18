local JobData = {
    name = filename(),
    label = "Pronghorn Ranch",
    description = "Drive the herd to Pronghorn",
    steps = {
        {
            action = "Initialisation",
            label = "Go get the cows",
            description = "The cows are located in Emerald",
            coords = vector3(1422.9291, 316.2834, 88.6817),
            heading = 274.0,
            cowModel = GetHashKey("A_C_Cow"),
            cowCount = 5,
        },
        {
            action = "HerdCows",
            destination = vector3(1264.4446, 142.9329, 91.3599),
        },
        {
            action = "HerdCows",
            destination = vector3(1145.5696, -32.1921, 89.3817),
        },
        {
            action = "HerdCows",
            destination = vector3(790.5356, -234.7599, 103.8272),
        },
        {
            action = "HerdCows",
            destination = vector3(582.1267, -499.4063, 78.1320),
        },
                {
            action = "HerdCows",
            destination = vector3(70.2562, -445.8311, 73.4273),
        },
                {
            action = "HerdCows",
            destination = vector3(-449.6033, -513.3238, 57.2714),
        },
                {
            action = "HerdCows",
            destination = vector3(-684.1313, -383.2970, 53.8212),
        },
                {
            action = "HerdCows",
            destination = vector3(-840.8812, -317.6720, 43.2808),
        },
                {
            action = "HerdCows",
            destination = vector3(-1084.8552, -286.3357, 83.6429),
        },
                {
            action = "HerdCows",
            destination = vector3(-1126.3510, -103.8726, 45.0256),
        },
                {
            action = "HerdCows",
            destination = vector3(-1319.4760, 144.7525, 75.0398),
        },
                {
            action = "HerdCows",
            destination = vector3(-1623.1785, 155.1594, 117.0093),
        },
                {
            action = "HerdCows",
            destination = vector3(-1624.0250, 427.5938, 107.6160),
        },
                {
            action = "HerdCows",
            destination = vector3(-2054.2332, 639.2614, 119.7127),
        },
                {
            action = "HerdCows",
            destination = vector3(-2505.0461, 622.7977, 132.9944),
        },
                {
            action = "HerdCows",
            destination = vector3(-2619.4651, 429.3555, 145.6288),
        },
        {
            action = "CompleteJob",
            reward = 200,
            malusfordeadcow = 20, --- when a cow die, remove this amount from the reward
            label = "Finish",
            description = "Complete the quest"
        },
    },
    board = { "emrld" },
    image = "./img/Poster_art/cow.png",
    reward = "$200",
}

if IsDuplicityVersion() then
    JobsConfig[filename()] = JobData
else
    local lang = {
        ["Start"] = "Start",
        ["Herd"] = "Herd",
        ["Finish"] = "Finish",
    }

    local cows = {}
    local blips = {}
    local Utils = {}
    local actions = {}
        AddRelationshipGroup("herdanimals")
        SetRelationshipBetweenGroups(1, GetHashKey("herdanimals"), GetHashKey("PLAYER"))
        SetRelationshipBetweenGroups(1, GetHashKey("PLAYER"), GetHashKey("herdanimals"))
    actions["Initialisation"] = function(job)
        local data = job.steps[job.currentStep]
        local spawnCoords = data.coords
        local spawnHeading = data.heading
        local blip = CreateBlip(spawnCoords, lang["Start"], 'blip_objective', `BLIP_STYLE_OBJECTIVE`)
        table.insert(blips, blip)
        TriggerEvent("murphy_jobpanel:ShowObjective", lang["Start"], 4000)
        local canrun = true
        Citizen.CreateThread(function()
            while canrun do
                Wait(200)
                if #(MeCoords - spawnCoords) < 50 then
                    print("Spawning cows")
                    RequestModel(data.cowModel)
                    while not HasModelLoaded(data.cowModel) do
                        Wait(1)
                    end
                    for i = 1, data.cowCount do
                        local cow = CreatePed(data.cowModel, spawnCoords.x + i, spawnCoords.y + i, spawnCoords.z, spawnHeading, true, true)
                        SetAnimalTuningBoolParam(cow, 25, false)
                        SetAnimalTuningBoolParam(cow, 24, false)
                        TaskAnimalUnalerted(cow, -1, false, 0, 0)
                        SetPedConfigFlag(cow, 297, true)
                        SetPedRelationshipGroupHash(cow, GetHashKey("herdanimals"))
                        SetPedConfigFlag(cow, 310, true)
                        SetPedConfigFlag(cow, 40, false)
                        Citizen.InvokeNative(0xAE6004120C18DF97, cow, 5, false)
                        Citizen.InvokeNative(0xAE6004120C18DF97, cow, 6, false) --- lasso
                        SetRandomOutfitVariation(cow, true)
                        SetEntityAsMissionEntity(cow, true, true)
                        table.insert(cows, cow)
                        local pedblip = CreateBlipEntity(cow, "Cow", `BLIP_STYLE_HERDING_ANIMAL`, nil, `blip_ambient_ped_small`)
                        blips[cow] = pedblip
                    end
                    job:nextStep()
                    canrun = false
                    break
                end
            end
        end)

        Citizen.CreateThread(function()
            local step = job.currentStep
            while true do
                Wait(1000)
                if step ~= job.currentStep or job.abandon == true then
                    canrun = false
                    RemoveBlip(blip)
                    if job.abandon == true then
                        Utils.StopJob()
                    end
                    break
                end
            end
        end)
    end

    actions["HerdCows"] = function(job)
        local data = job.steps[job.currentStep]
        local destination = data.destination
        if not  IsPointOnRoad(destination) then
            local retval, srcNode, targetNode = GetClosestRoad(destination.x, destination.y, destination.z, 5.0, 0, false)
            destination = targetNode
            print ("Destination is not on road, recalculated path to ", destination)
        end
        local blip = CreateBlip(destination, lang["Herd"], 'blip_objective', `BLIP_STYLE_OBJECTIVE`)
        table.insert(blips, blip)
        StartGpsMultiRoute(GetHashKey("COLOR_OBJECTIVE"), true, true)
        Citizen.InvokeNative(0x64C59DD6834FA942, destination.x, destination.y, destination.z)
        Citizen.InvokeNative(0x4426D65E029A4DC0, true)
        TriggerEvent("murphy_jobpanel:ShowObjective", lang["Herd"], 4000)

               Citizen.CreateThread(function()
            local step = job.currentStep
            if next(cows) == nil then
                Utils.StopJob()
                job:stop()
                return
            end
            for _, cow in ipairs(cows) do
                Citizen.CreateThread(function()
                    -- local pathHandle = NavmeshRequestPath(cow, GetEntityCoords(cow).x, GetEntityCoords(cow).y, GetEntityCoords(cow).z, destination.x, destination.y, destination.z, 0)
                    -- while not NavmeshRequestedPathWaypointsFound(pathHandle) do
                    --     Wait(100)
                    --     print(cow, NavmeshRequestedPathWaypointsFound(pathHandle))
                    -- end
                    local isFollowing = false
                    local isFleeing = false
                    repeat 
                        Wait(1000)
                        if not IsEntityDead(cow) then
                            if not isFleeing then
                                if IsPedFleeing(cow) then
                                    isFollowing = false
                                    isFleeing = true
                                    BlipSetStyle(blips[cow], `BLIP_STYLE_MP_MISSION_GIVER`)
                                end
                                local player, coords = GetClosestPlayer(GetEntityCoords(cow))
                                if #(coords - GetEntityCoords(cow)) > 20.0 then
                                    TaskWanderInArea(cow, GetEntityCoords(cow).x, GetEntityCoords(cow).y, GetEntityCoords(cow).z, 10.0, 0, 0)
                                    isFollowing = false
                                    BlipSetStyle(blips[cow], `BLIP_STYLE_NEUTRAL`)
                                elseif not isFollowing then
                                    -- TaskFollowNavMeshToCoord(cow, destination.x, destination.y, destination.z, 1.5, -1, 0.0, 0, 0)
                                    TaskMoveFollowRoadUsingNavmesh(cow, 2.0, destination.x, destination.y, destination.z, 0)
                                    isFollowing = true
                                    BlipSetStyle(blips[cow], `BLIP_STYLE_OBJECTIVE`)
                                end

                                if math.random() < 0.01 and isFollowing then -- 1% chance every 100ms
                                    local randomX = GetEntityCoords(cow).x + math.random(-30, 30)
                                    local randomY = GetEntityCoords(cow).y + math.random(-30, 30)
                                    local randomZ = GetEntityCoords(cow).z
                                    TaskFollowNavMeshToCoord(cow,  randomX, randomY, randomZ, 2.5, -1, 0.0, 0, 0)
                                    BlipSetStyle(blips[cow], `BLIP_STYLE_MP_MISSION_GIVER`)
                                    Wait (2000)
                                    isFleeing = true
                                end
                            else
                                local player, coords = GetClosestPlayer(GetEntityCoords(cow))
                                if #(coords - GetEntityCoords(cow)) <= 5.0 then
                                    isFleeing = false
                                    isFollowing = false
                                end
                            end
                        end
            
                    until step ~= job.currentStep
                end)
            end
        
            while true do
                Wait(1000)
                local allCowsArrived = true
                if step ~= job.currentStep or job.abandon == true then
                    RemoveBlip(blip)
                    if job.abandon == true then
                        Utils.StopJob()
                    end
                    break
                end
                for _, cow in ipairs(cows) do
                    if #(GetEntityCoords(cow) - destination) > 20 then
                        if not IsEntityDead(cow) then
                            allCowsArrived = false
                            break
                        end
                    end
                end
                if allCowsArrived then
                    RemoveBlip(blip)
                    job:nextStep()
                    break
                end

            end
        end)
    end

    actions["CompleteJob"] = function(job)
        TriggerEvent("murphy_jobpanel:ShowObjective", lang["Finish"], 4000)
        -- StartGpsMultiRoute(GetHashKey("COLOR_OBJECTIVE"), true, true)
        -- Citizen.InvokeNative(0x64C59DD6834FA942, job.steps[1].coords.x, job.steps[1].coords.y, job.steps[1].coords.z)
        -- Citizen.InvokeNative(0x4426D65E029A4DC0, true)
        for _, blip in ipairs(blips) do
            if blip then
                RemoveBlip(blip)
            end
        end
        ClearGpsMultiRoute()
        local reward = job.steps[job.currentStep].reward
        for _, cow in ipairs(cows) do
            if IsEntityDead(cow) then
                reward = reward - job.steps[job.currentStep].malusfordeadcow
            end
        end
        Callback.triggerServer('AddCurrency', function() end, reward)
        job:nextStep()
        for _, cow in ipairs(cows) do
            TaskStartScenarioInPlace(cow, GetHashKey("WORLD_ANIMAL_COW_GRAZING"), -1)
        end
        print ("Cows will be deleted in 5 seconds")
        Wait(5000)
        for _, cow in ipairs(cows) do
            DeletePed(cow)
        end

    end

    function Utils.StopJob()
        print("Stopping job and cleaning up")
        for _, cow in ipairs(cows) do
            DeletePed(cow)
        end
        for _, blip in ipairs(blips) do
            if blip then
                RemoveBlip(blip)
            end
        end
        ClearGpsMultiRoute()
        blips = {}
        cows = {}
    end

    function Utils.createJob(jobData)
        for _, step in ipairs(jobData.steps) do
            step.action = actions[step.action]
        end
        return Job:new(jobData)
    end

    local job = Utils.createJob(JobData)
    AddEventHandler("onResourceStop", function(resourceName)
        if GetCurrentResourceName() ~= resourceName then
            return
        end
        for _, cow in ipairs(cows) do
            DeletePed(cow)
        end
        for _, blip in ipairs(blips) do
            if blip then
                RemoveBlip(blip)
            end
        end
    end)
    return job
end
