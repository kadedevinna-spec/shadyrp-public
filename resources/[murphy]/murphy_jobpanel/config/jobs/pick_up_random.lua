local JobData = {
    name = filename(),
    label = "Random Pickup",
    description = "Pick up packages at random locations",
    steps = {
        {
            action = "Initialisation",
            label = "Initialization",
            description = "Initialize the quest",
            vehicle = GetHashKey("chuckwagon002x"),
            bliplabel = "Work Carriage",
            coords = vector3(-3731.456, -2549.489, -14.83865),
            heading = 274.0,
            packagemodel = GetHashKey("p_crate01x"),
            packagesSettings = { coords = vector3(0.0, -2.1, 0.1), rotation = vector3(0.0, 0.0, 90.01) }
        },
        { action = "PickUpPackage" },
        { action = "PickUpPackage" },
        { action = "PickUpPackage" },
        { action = "PickUpPackage" },
        { action = "PickUpPackage" },
        { action = "ReturnCarriage", reward = 25, label = "Return the carriage", description = "Return the carriage to the starting point" },
    },
    board = { "armadillo" },
    image = "./img/Poster_art/water.png",
    reward = "$25",
}
if IsDuplicityVersion() then
    JobsConfig[filename()] = JobData
else
    local lang = {
        ["Take"] = "Take",
        ["Drop"] = "Drop",
        ["NextStep"] = "Next step",
        ["Give back the carriage"] = "Give back the carriage",
        ["Take the carriage"] = "Take the carriage",
        ["Delivery Point"] = "Delivery Point",
        ["Finish"] = "Finish",
    }

    local deliveries = {
        { label = "Church", description = "Pick up the package at the specified location", Pos = vector3(-3719.186, -2542.753, -14.89943) },
        { label = "Twin Rocks", description = "Pick up the package at the specified location", Pos = vector3(-3719.186, -2542.753, -14.89943) },
        { label = "Ridgewood Farm", description = "Pick up the package at the specified location", Pos = vector3(-3719.186, -2542.753, -14.89943) },
        { label = "Rathskeller Fork", description = "Pick up the package at the specified location", Pos = vector3(-3719.186, -2542.753, -14.89943) },
        { label = "Tumbleweed", description = "Pick up the package at the specified location", Pos =vector3(-3719.186, -2542.753, -14.89943) },
        { label = "Gaptooth Breach", description = "Pick up the package at the specified location", Pos = vector3(-3719.186, -2542.753, -14.89943)},
        { label = "Benedict Point", description = "Pick up the package at the specified location", Pos = vector3(-3719.186, -2542.753, -14.89943) },
    }

    local PackageQuestList = {}
    local cachequestVehicle = nil
    local PickedupPackages = {}
    local deliverypoints = {}
    local iquest = 1
    local blips = {}

    local Utils = {}
    local actions = {} --- table for functions

    actions["Initialisation"] = function(job)
        local data = job.steps[job.currentStep]
        local vehicleHash = data.vehicle
        local spawnCoords = data.coords
        local spawnHeading = data.heading
        local blip = CreateBlip(spawnCoords, lang["Take the carriage"], 'blip_objective', `BLIP_STYLE_OBJECTIVE`)
        table.insert(blips, blip)
        TriggerEvent("murphy_jobpanel:ShowObjective", lang["Take the carriage"], 4000)
        local canrun = true
        Citizen.CreateThread(function()
            while canrun do
                Wait(200)
                if #(MeCoords - spawnCoords) < 10 then
                    print("Spawning vehicle and packages")
                    RequestModel(vehicleHash)
                    while not HasModelLoaded(vehicleHash) do
                        Wait(1)
                    end
                    cachequestVehicle = CreateVehicle(vehicleHash, spawnCoords.x, spawnCoords.y, spawnCoords.z,
                        spawnHeading,
                        true, true, false, true)
                    SetEntityAsMissionEntity(cachequestVehicle, true, true)
                    Wait(500)
                    local packageHash = data.packagemodel
                    RequestModel(packageHash)
                    while not HasModelLoaded(packageHash) do
                        Wait(1)
                    end
                    job:nextStep()
                    canrun = false
                    break
                end
            end
        end)

        Citizen.CreateThread(function() ---- this thread will check if the job is abandon and will delete the interaction
            local step = job.currentStep
            while true do
                Wait(1000)
                if step ~= job.currentStep or job.abandon == true then
                    canrun = false
                    RemoveBlip(blip)
                    if job.abandon == true then
                        ClearGpsMultiRoute()
                        Utils.StopJob()
                    end
                    break
                end
            end
        end)
    end

    actions["PickUpPackage"] = function(job)
        Utils.NewLocation(job)
        local currentPackage = PackageQuestList[1]
        local deliverLocation = job.steps[job.currentStep].coords
        local blip = CreateBlip(deliverLocation, lang["Delivery Point"], 'blip_objective', `BLIP_STYLE_OBJECTIVE`)
        StartGpsMultiRoute(GetHashKey("COLOR_OBJECTIVE"), true, true)
        Citizen.InvokeNative(0x64C59DD6834FA942, deliverLocation)
        Citizen.InvokeNative(0x4426D65E029A4DC0, true)
        table.insert(blips, blip)
        if currentPackage == nil or cachequestVehicle == nil then
            return
        end
        exports.murphy_interact:AddLocalEntityInteraction({
            entity = currentPackage,
            name = 'packageInteraction',
            id = currentPackage,
            distance = 5.0,
            interactDst = 3.0,
            offset = vec3(0.0, 0.0, 0.5),
            ignoreLos = true, -- optional ignores line of sight
            options = {
                {
                    label = lang["Take"],
                    action = function(entity, coords, args)
                        Utils.PickPackage(currentPackage)
                        exports.murphy_interact:RemoveLocalEntityInteraction(currentPackage, currentPackage)

                        exports.murphy_interact:AddEntityInteraction({
                            netId = NetworkGetNetworkIdFromEntity(cachequestVehicle),
                            id = job.name .. "_step" .. job.currentStep, -- needed for removing interactions
                            distance = 8.0, -- optional
                            interactDst = 2.0, -- optional
                            ignoreLos = true, -- optional ignores line of sight
                            options = {
                                {
                                    label = lang["Drop"],
                                    action = function(entity, coords, args)
                                        Utils.DropPackage(currentPackage, job)
                                        exports.murphy_interact:RemoveEntityInteraction(NetworkGetNetworkIdFromEntity(cachequestVehicle), job.name .. "_step" .. job.currentStep)
                                        Wait(1000)
                                        job:nextStep()
                                    end,
                                },
                            }
                        })
                    end,
                },
            }
        })

        Citizen.CreateThread(function() ---- this thread will check if the job is abandon and will delete the interaction
            local step = job.currentStep
            while true do
                Wait(1000)
                if step ~= job.currentStep or job.abandon == true then
                    RemoveBlip(blip)
                    if job.abandon == true then
                        exports.murphy_interact:RemoveLocalEntityInteraction(currentPackage, currentPackage)
                        exports.murphy_interact:RemoveInteraction(job.name .. "_step" .. job.currentStep)
                        ClearGpsMultiRoute()
                        Utils.StopJob()
                    end
                    break
                end
            end
        end)
    end

    actions["ReturnCarriage"] = function(job)
        TriggerEvent("murphy_jobpanel:ShowObjective", lang["Give back the carriage"], 4000)
        local deliverLoc = job.steps[1].coords
        local blip = CreateBlip(deliverLoc, lang["Give back the carriage"], 'blip_objective', `BLIP_STYLE_OBJECTIVE`)
        table.insert(blips, blip)
        StartGpsMultiRoute(GetHashKey("COLOR_OBJECTIVE"), true, true)
        Citizen.InvokeNative(0x64C59DD6834FA942, deliverLoc)
        Citizen.InvokeNative(0x4426D65E029A4DC0, true)
        deliverLocation = 1
        deliverypoints = {}
        exports.murphy_interact:AddInteraction({
            coords = vector3(deliverLoc.x, deliverLoc.y, deliverLoc.z + 1.5),
            distance = 20.0,
            interactDst = 5.0,
            id = job.name .. "_step" .. job.currentStep,
            options = {
                {
                    label = lang["Finish"],
                    action = function(entity, coords, args)
                        if cachequestVehicle ~= nil then
                            Utils.StopJob()
                            Callback.triggerServer('AddCurrency', function() end, job.steps[job.currentStep].reward)
                            job:nextStep()
                        end
                    end,
                },
            }
        })

        Citizen.CreateThread(function() ---- this thread will check if the job is abandon and will delete the interaction
            local step = job.currentStep
            while true do
                Wait(1000)
                if step ~= job.currentStep or job.abandon == true then
                    RemoveBlip(blip)
                    if job.abandon == true then
                        exports.murphy_interact:RemoveInteraction(job.name .. "_step" .. job.currentStep)
                        ClearGpsMultiRoute()
                        Utils.StopJob()
                    end
                    break
                end
            end
        end)
    end

    function Utils.NewLocation(jobdata)
        local rnd = math.random
        quest = rnd(1, #deliveries)
        while tableContains(deliverypoints, quest) do
            Wait(0)
            quest = rnd(1, #deliveries)
            print("contain")
        end

        table.insert(deliverypoints, quest)
        local pos = deliveries[quest].Pos
        jobdata.steps[jobdata.currentStep].coords = pos
        Citizen.InvokeNative(0x64C59DD6834FA942, pos.x, pos.y, pos.z)
        Citizen.InvokeNative(0x4426D65E029A4DC0, true)
        TriggerEvent("murphy_jobpanel:ShowObjective", jobdata.steps[jobdata.currentStep].description, 4000)

        local packageHash = jobdata.steps[1].packagemodel
        RequestModel(packageHash)
        while not HasModelLoaded(packageHash) do
            Wait(1)
            print("request")
        end
        local packageEntity = CreateObject(packageHash, pos.x, pos.y, pos.z, false, true, true)
        SetEntityAsMissionEntity(packageEntity, true, true)
        PlaceObjectOnGroundProperly(packageEntity)
        table.insert(PackageQuestList, packageEntity)
    end

    -- Function to pick up a package
    function Utils.PickPackage(packageEntity)
        Citizen.CreateThread(function()
            LoadAnim("mech_carry_box")
            Citizen.InvokeNative(0xEA47FE3719165B94, PlayerPedId(), "mech_carry_box", "idle", 1.0, 8.0, -1, 31, 0, 0, 0,
                0)
            Citizen.InvokeNative(0x6B9BBD38AB0796DF, packageEntity, PlayerPedId(),
                GetEntityBoneIndexByName(PlayerPedId(), "SKEL_R_Finger12"), 0.20, -0.028, 0.001, 15.0, 175.0, 0.0, true,
                true, false, true, 1, true)
            while IsEntityAttachedToEntity(packageEntity, PlayerPedId()) do
                Citizen.InvokeNative(0x7DFB49BCDB73089A, packageEntity, false)
                if not IsEntityPlayingAnim(PlayerPedId(), "mech_carry_box", "idle", 3) then
                    Citizen.InvokeNative(0xEA47FE3719165B94, PlayerPedId(), "mech_carry_box", "idle", 1.0, 8.0, -1, 31, 0,
                        0, 0, 0)
                end
                Citizen.Wait(0)
            end
        end)
    end

    -- Function to drop a package
    function Utils.DropPackage(packageEntity, jobdata)
        table.remove(PackageQuestList, 1)
        table.insert(PickedupPackages, packageEntity)
        SetEntityAsMissionEntity(packageEntity, true, true)
        local settings = jobdata.steps[1].packagesSettings
        ClearPedTasks(PlayerPedId(), 1, 1)
        Citizen.InvokeNative(0x6B9BBD38AB0796DF, packageEntity, cachequestVehicle, 0, settings.coords[1],
            (settings.coords[2] + (iquest / 2.0)), settings.coords[3], settings.rotation[1], settings.rotation[2],
            settings.rotation[3], 0, 0, 0, 0, 2, true)
        iquest = iquest + 1
        ClearPedTasks(PlayerPedId(), 1, 1)
        Citizen.Wait(100)
    end

    function Utils.StopJob()
        print("Stopping job and cleaning up")
        for k, props in pairs(PackageQuestList) do
            DeleteEntity(props)
        end
        for k, props in pairs(PickedupPackages) do
            DeleteEntity(props)
        end
        if cachequestVehicle ~= nil then
            DeleteEntity(cachequestVehicle)
        end
        for _, blip in ipairs(blips) do
            if blip then
                RemoveBlip(blip)
            end
        end
        blips = {}
        Wait(5000)
        PackageQuestList = {}
        cachequestVehicle = nil
        PickedupPackages = {}
        questLocation = 0
        iquest = 1
        blips = {}
    end

    function Utils.createJob(jobData) --- Create the job
        for i, step in ipairs(jobData.steps) do
            if step.action == "PickUpPackage" then
                local location = deliveries[i]
                step.coords = location.Pos
                step.description = step.description
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
        for k, props in pairs(PackageQuestList) do
            DeleteEntity(props)
        end
        if cachequestVehicle ~= nil then
            DeleteEntity(cachequestVehicle)
        end
        for _, blip in ipairs(blips) do
            if blip then
                RemoveBlip(blip)
            end
        end
    end)
    return job
end
