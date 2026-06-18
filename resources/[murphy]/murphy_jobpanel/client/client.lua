CurrentBoardLocation = nil
Me = nil
MeCoords = nil
Citizen.CreateThread(function ()
    while true do
        Wait(100)
        Me = PlayerPedId()
        MeCoords = GetEntityCoords(Me)
    end
end)


RegisterNUICallback("closeview", function (body, resultCallback)
    CurrentBoardLocation = nil
    SetNuiFocus(false, false)
    PlaySound("MENU_CLOSE", "HUD_PLAYER_MENU")
end)

RegisterNUICallback("lButton", function (body, resultCallback)
    PlaySound("BACK", "HUD_PLAYER_MENU")
end)


RegisterNUICallback("loadCenteredPoster", function (body, resultCallback)
    PlaySound("SELECT", "HUD_PLAYER_MENU")
end)


RegisterNUICallback("useitem", function (body, resultCallback)
    SendNUIMessage({
        type = 'closeJobBoard'
    })
    PlaySound("MENU_CLOSE", "HUD_PLAYER_MENU")
    SetNuiFocus(false, false)
    local selectedjobid = body.item
    if JobRunning then
        print("Job is already running.")
        TriggerEvent("murphy_jobpanel:ShowObjective", Translate["Already have a job"], 4000)
    else
        Callback.triggerServer('TakeJobPoster', function(result) 
            if result then
                print("Selected Job ID:", body.item)
                Selectedjob = require("config.jobs."..selectedjobid)
                if Selectedjob and Selectedjob ~= true then
                    Selectedjob:start()
                end
            else
                OpenJobPanel(CurrentBoardLocation)
            end
        end, CurrentBoardLocation, selectedjobid)
    end
    CurrentBoardLocation = nil
end)

RegisterNUICallback("abandon", function (body, resultCallback)
    Selectedjob:stop()
    TriggerEvent("murphy_jobpanel:ShowObjective", Translate["Abandon"], 4000)
    PlaySound("SELECT", "HUD_PLAYER_MENU")
    Wait(1000)
    PlaySound("MENU_CLOSE", "HUD_PLAYER_MENU")
end)


function OpenJobPanel(boardLocation)
    CurrentBoardLocation = boardLocation
    Callback.triggerServer('RequestJobPosters', function(jobs)
        SendNUIMessage({
            type = 'openJobBoard',
            jobs = jobs
        })
        PlaySound("MENU_ENTER", "HUD_PLAYER_MENU")
        SetNuiFocus(true, true)
        SetNuiFocusKeepInput(false)
    end, boardLocation)
end


RegisterCommand("jobstop", function (source, args, raw)
    if Selectedjob then
        Selectedjob:stop()
    end
end)

local boards = {}
local spawnedEntities = {}
local blips = {}

Citizen.CreateThread(function()
    while true do
        Wait(1000)
        local playerCoords = GetEntityCoords(PlayerPedId())

        for location, data in pairs(Config.Panel) do
            local distance = #(playerCoords - data.coords)
            if distance < 200 then
                if not spawnedEntities[location] then
                    -- Spawn Board
                    RequestModel(GetHashKey(data.model))
                    while not HasModelLoaded(GetHashKey(data.model)) do
                        Wait(1)
                    end
                    local board = CreateObject(GetHashKey(data.model), data.coords.x, data.coords.y, data.coords.z, false, false, false)
                    SetEntityCoords(board, data.coords.x, data.coords.y, data.coords.z, 2, true)
                    SetEntityRotation(board, data.rotation.x, data.rotation.y, data.rotation.z, 2, true)
                    table.insert(boards, board)

                    -- Add interaction to the board
                    exports.murphy_interact:AddLocalEntityInteraction({
                        entity = board,
                        name = 'jobBoardInteraction',
                        id = board,
                        distance = 5.0,
                        interactDst = 2.0,
                        offset = vec3(0.0, 0.0, 1.5), -- optional
                        options = {
                            {
                                label = Translate["Job Panel: View Jobs"] ,
                                action = function(entity, coords, args)
                                    -- Open job panel or perform any action
                                    OpenJobPanel(location)
                                end,
                            },
                        }
                    })

                    -- Add blip for the board
                    

                    local blip_name = "Job Board"
                    local blip_coords = data.coords
                    local blip_hash = GetHashKey("blip_job_board")
                    local blip_modifier_hash = GetHashKey("BLIP_MODIFIER_MP_COLOR_2")
                    local blip_id = Citizen.InvokeNative(0x554D9D53F696D002, GetHashKey("BLIP_STYLE_PICKUP"), blip_coords.x, blip_coords.y, blip_coords.z)
                
                    -- BLIP_ADD_MODIFIER:
                    -- Citizen.InvokeNative(0x662D364ABF16DE2F, blip_id, blip_modifier_hash)
                    SetBlipSprite(blip_id, blip_hash, 0)
                    -- _SET_BLIP_NAME_FROM_PLAYER_STRING:
                    Citizen.InvokeNative(0x9CB1A1623062F402, blip_id, blip_name)
                    blips[location] = blip_id
                    spawnedEntities[location] = {board = board}
                end
            else
                if spawnedEntities[location] then
                    -- Delete Board
                    if DoesEntityExist(spawnedEntities[location].board) then
                        DeleteObject(spawnedEntities[location].board)
                        -- Remove interaction from the board
                        exports.murphy_interact:RemoveLocalEntityInteraction(spawnedEntities[location].board, spawnedEntities[location].board)
                    end

                    -- Remove blip for the board
                    if blips[location] then
                        RemoveBlip(blips[location])
                        blips[location] = nil
                    end

                    spawnedEntities[location] = nil
                end
            end
        end
    end
end)


AddEventHandler("onResourceStop", function(resourceName)
    if GetCurrentResourceName() ~= resourceName then
        return
    end

    for _, board in ipairs(boards) do
        if DoesEntityExist(board) then
            DeleteObject(board)
            -- Remove interaction from the board
            exports.murphy_interact:RemoveLocalEntityInteraction(board, board)
        end
    end

    for _, blip in pairs(blips) do
        RemoveBlip(blip)
    end
end)

Citizen.CreateThread(function()
    local showactivejob = false
    while true do
        Wait(100)
        if JobRunning then
            if not showactivejob then
                if IsUiappRunningByHash(`MAP`) == 1 then
                    showactivejob = true
                    Wait(500)
                    SendNUIMessage({
                        type = 'openJobActiveMenu',
                        jobs = Selectedjob.activejobinfo
                    })
                    PlaySound("show_info", "Study_Sounds")
                    SetNuiFocus(true, false)
                    SetNuiFocusKeepInput(true)
                end
            else
                if IsUiappRunningByHash(`MAP`) == 0 then
                    showactivejob = false
                    SendNUIMessage({
                        type = 'closeJobActiveMenu'
                    })
                    PlaySound("hide_info", "Study_Sounds")
                    SetNuiFocus(false, false)
                end
            end
        end
    end
end)