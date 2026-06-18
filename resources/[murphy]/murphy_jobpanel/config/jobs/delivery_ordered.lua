-- Define job data before functions

local JobData = {
    name = filename(),
    label = "Delivery",
    description = "Deliver packages in a specific order",
    steps = {
        {
            action = "Initialisation",
            label = "Initialisation",
            description = "Retrieve the cargo",
            vehicle = GetHashKey("chuckwagon002x"),
            bliplabel = "Work Carriage",
            coords = vector3(-3731.456, -2549.489, -14.83865),
            heading = 274.0,
            packagemodel = GetHashKey("p_crate01x"),
            packagesSettings = { coords = vector3(0.0, -2.1, 0.1), rotation = vector3(0.0, 0.0, 90.01) }
        },
        { action = "DeliverPackage", label = "Deliver the package" },
        { action = "DeliverPackage", label = "Deliver the package" },
        { action = "DeliverPackage", label = "Deliver the package" },
        { action = "DeliverPackage", label = "Deliver the package" },
        { action = "ReturnCarriage", reward = 25, label = "Return the carriage", description = "Return the empty carriage" },
    },
    board = { "armadillo" },
    image = "./img/Poster_art/beef.png",
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
        { Name = "Twin Rocks", Pos = vector3(-3956.079, -2140.656, -5.978973), Description = "Deliver the package to Twin Rocks" },
        { Name = "Ridgewood Farm", Pos = vector3(-4773.722, -2723.127, -14.84364), Description = "Deliver the package to Ridgewood Farm" },
        { Name = "Rathskeller Fork", Pos = vector3(-5217.904, -2120.502, 11.68457), Description = "Deliver the package to Rathskeller Fork" },
        { Name = "Tumbleweed", Pos = vector3(-5498.94, -2932.629, -1.423192), Description = "Deliver the package to Tumbleweed" },
    }
    local Utils = {}
    local PackageList = {}
    local cacheVehicle = nil
    local deliverypoints = {}
    local deliverLocation = 1 -- Initialize to 1
    local blips = {}

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
                    cacheVehicle = CreateVehicle(vehicleHash, spawnCoords.x, spawnCoords.y, spawnCoords.z, spawnHeading,
                        true, true, false, true)
                    SetEntityAsMissionEntity(cacheVehicle, true, true)
                    Wait(500)
                    local packageHash = data.packagemodel
                    RequestModel(packageHash)
                    while not HasModelLoaded(packageHash) do
                        Wait(1)
                    end
                    for i = 1, #deliveries do
                        local Pos = GetEntityCoords(cacheVehicle, true, true)
                        local packageEntity = CreateObject(packageHash, Pos.x, Pos.y, Pos.z, false, true, true)
                        SetEntityAsMissionEntity(packageEntity, true, true)
                        -- NetworkRegisterEntityAsNetworked(packageEntity)
                        -- while not NetworkGetEntityIsNetworked(packageEntity) do
                        --     NetworkRegisterEntityAsNetworked(packageEntity)
                        --     Wait(1)
                        -- end
                        table.insert(PackageList, packageEntity)
                        local settings = data.packagesSettings
                        Citizen.InvokeNative(0x6B9BBD38AB0796DF, packageEntity, cacheVehicle, 0, settings.coords.x,
                            settings.coords.y + (i / 2.0), settings.coords.z, settings.rotation.x, settings.rotation.y,
                            settings.rotation.z, 0, 0, 0, 0, 2, true)
                    end
                    job:nextStep()
                    canrun = false
                    break
                end
            end
        end)

        Citizen.CreateThread(function()  ---- this thread will check if the job is abandon and will delete the interaction
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

    actions["DeliverPackage"] = function(job)
        Utils.NewLocation(job)
        local currentPackage = PackageList[1]
        local deliverLocation = job.steps[job.currentStep].coords
        local blip = CreateBlip(deliverLocation, lang["Delivery Point"], 'blip_objective', `BLIP_STYLE_OBJECTIVE`)
        table.insert(blips, blip)
        if currentPackage == nil or cacheVehicle == nil then
            return
        end
        StartGpsMultiRoute(GetHashKey("COLOR_OBJECTIVE"), true, true)
        Citizen.InvokeNative(0x64C59DD6834FA942, deliverLocation)
        Citizen.InvokeNative(0x4426D65E029A4DC0, true)
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
                        exports.murphy_interact:RemoveLocalEntityInteraction(currentPackage,
                            currentPackage)
                        exports.murphy_interact:AddInteraction({
                            coords = vector3(deliverLocation.x, deliverLocation.y, deliverLocation.z + 1.5),
                            distance = 8.0,
                            interactDst = 2.5,
                            id = job.name .. "_step" .. job.currentStep,
                            options = {
                                {
                                    label = lang["Drop"],
                                    action = function(entity, coords, args)
                                        Utils.DropPackage(currentPackage, job)
                                        exports.murphy_interact:RemoveInteraction(job.name .. "_step" .. job.currentStep)
                                        job:nextStep()
                                    end,
                                },
                            }
                        })
                    end,
                },
            }
        })

        Citizen.CreateThread(function()  ---- this thread will check if the job is abandon and will delete the interaction
            local step = job.currentStep
            while true do
                Wait(1000)
                if step ~= job.currentStep or job.abandon == true then
                    RemoveBlip(blip)
                    if job.abandon == true then
                        exports.murphy_interact:RemoveLocalEntityInteraction(currentPackage,
                            currentPackage)
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
        Citizen.InvokeNative(0x64C59DD6834FA942, deliverLoc)
        Citizen.InvokeNative(0x4426D65E029A4DC0, true)
        deliverLocation = 1
        deliverypoints = {}
        StartGpsMultiRoute(GetHashKey("COLOR_OBJECTIVE"), true, true)
        Citizen.InvokeNative(0x64C59DD6834FA942, deliverLoc)
        Citizen.InvokeNative(0x4426D65E029A4DC0, true)
        exports.murphy_interact:AddInteraction({
            coords = vector3(deliverLoc.x, deliverLoc.y, deliverLoc.z + 1.5),
            distance = 20.0,
            interactDst = 5.0,
            id = job.name .. "_step" .. job.currentStep,
            options = {
                {
                    label = lang["Finish"],
                    action = function(entity, coords, args)
                        if cacheVehicle ~= nil then

                            Callback.triggerServer('AddCurrency', function() end, job.steps[job.currentStep].reward)
                            exports.murphy_interact:RemoveInteraction(job.name .. "_step" .. job.currentStep)
                            job:nextStep()
                            Utils.StopJob()
                        end
                    end,
                },
            }
        })

        Citizen.CreateThread(function()  ---- this thread will check if the job is abandon and will delete the interaction
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

    function Utils.NewLocation(job)
        if deliverLocation > #deliveries then
            deliverLocation = 1
        end
        local pos = deliveries[deliverLocation].Pos
        job.steps[job.currentStep].coords = pos
        Citizen.InvokeNative(0x64C59DD6834FA942, pos.x, pos.y, pos.z)
        Citizen.InvokeNative(0x4426D65E029A4DC0, true)
        local zoneName = deliveries[deliverLocation].Name
        TriggerEvent("murphy_jobpanel:ShowObjective", lang["NextStep"] .. " " .. zoneName, 4000)
        deliverLocation = deliverLocation + 1 -- Increment deliverLocation
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
    function Utils.DropPackage(packageEntity, jobdata, deliverLocation)
        table.remove(PackageList, 1)
        DetachEntity(packageEntity, false, true)
        ClearPedTasks(PlayerPedId(), 1, 1)
        local maxAttempts = 100 -- Nombre maximum de tentatives
        local attempts = 0

        -- Citizen.Wait(10000)
        -- while not NetworkHasControlOfEntity(packageEntity) and attempts < maxAttempts do
        --     Citizen.Wait(0)
        --     NetworkRequestControlOfEntity(packageEntity)
        --     attempts = attempts + 1
        -- end

        -- if not NetworkHasControlOfEntity(packageEntity) then
        --     print("Impossible de prendre le contrôle de l'entité après " .. maxAttempts .. " tentatives.")
        --     -- Vous pouvez ajouter un traitement d'erreur ici si nécessaire
        --     return -- Sortir de la fonction pour éviter un crash
        -- end

        if DoesEntityExist(packageEntity) then
            DeleteEntity(packageEntity)
        else
            print("L'entité n'existe pas, impossible de la supprimer.")
        end
    end

    function Utils.StopJob()
        print("Stopping job and cleaning up")
        ClearGpsMultiRoute()
        for k, props in pairs(PackageList) do
            DeleteEntity(props)
        end
        if cacheVehicle ~= nil then
            DeleteEntity(cacheVehicle)
        end
        for _, blip in ipairs(blips) do
            if blip then
                RemoveBlip(blip)
            end
        end
        blips = {}
        Wait(5000)
        cacheVehicle = 0
        deliverLocation = 1
        PackageList = {}
        deliverypoints = {}
    end

    function Utils.createJob(jobData) --- Create the job
        local deliveryIndex = 1
        for i, step in ipairs(jobData.steps) do
            if step.action == "DeliverPackage" then
                local location = deliveries[deliveryIndex]
                print(location)
                step.coords = location.Pos
                step.description = location.Description or step.description
                deliveryIndex = deliveryIndex + 1
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
