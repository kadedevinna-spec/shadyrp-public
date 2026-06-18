----- Don't change if you don't know what you doing

---------------------------
----------- Client Side
---------------------------
local locale = Locale[Config.Locale]
local Core = exports['btc-core']:GetCore()
local menu = exports['btc-core']

disableMenuOptions = { --- if true you disable the option
    inventory = false,
    managementCash = false,
    managementEmployees = false,
}


function PlayerStartRanchChore(chore, ranchId)
end

function PlayerFinishRanchChore(chore, ranchId)
end


----- Carry Animation
function CarryAnim(targetPed)
    local ped = targetPed
    local playerPed = PlayerPedId()

    ClearPedTasksImmediately(ped)
    TaskFollowToOffsetOfEntity(ped, playerPed, vector3(0.0, -1.5, 0.0),1.5, -1, 5.0, true)

    Wait(50)

    ClearPedTasksImmediately(ped)
    RequestAnimDict("mech_carry_box")

    while not HasAnimDictLoaded("mech_carry_box") do Wait(100) end

    TaskPlayAnim(playerPed, "mech_carry_box", "idle", 1.0, 8.0, -1, 31, 0, 0, 0, 0)
    AttachEntityToEntity(ped, playerPed, GetEntityBoneIndexByName(playerPed, "SKEL_R_Finger12"), 0.15, -0.28,
        0.0, 0.0, 180.0, 0.0, true, true, false, true, 0, true)

    SetPedToRagdoll(ped, 10000, 10000, 0, false, false, false)

end

function DetachAnimal(targetPed)
    local ped = targetPed
    DetachEntity(ped, true, true)
end


------ Branding Iron Anim
function BrandingIronAnim()
    local propModel = 'p_bamboostick01x'
    local animDict1 = 'amb_camp@prop_camp_butcher@resting@rabbit@male_a@idle_a'
    local animName1 = 'idle_c'
    local animDict = 'mech_melee@unarmed@_male@_ambient@_healthy@_noncombat'
    local animName = 'takedown_animal_kill_from_all_v1'
    local time1 = 5000
    local time = 1000
    local animflag = 1
    local ped = PlayerPedId()
    exports['btc-core']:showProgressBar(locale[284], time1 + time)
    RequestAnimDict(animDict1)
    while not HasAnimDictLoaded(animDict1) do
        Wait(100)
    end

    FreezeEntityPosition(ped, true)
    local brandingObj = CreateObject(propModel, 0, 0, 0, true, true, false)
    AttachEntityToEntity(brandingObj, PlayerPedId(), GetEntityBoneIndexByName(PlayerPedId(), "PH_R_Hand"), 0.01, -0.35, -0.05,
        -75.0, 0.0, 0.0, false, false, true, false, 0, true, false, false)                                    -- or 1
    TaskPlayAnim(PlayerPedId(), animDict1, animName1, 1.0, 1.0, time1, animflag, 0, true, 0, false, 0, false) --- anim flag

    Wait(time1)

    RequestAnimDict(animDict)
    while not HasAnimDictLoaded(animDict) do
        Wait(100)
    end                                                                                                    -- or 1
    TaskPlayAnim(PlayerPedId(), animDict, animName, 1.0, 1.0, time, animflag, 0, true, 0, false, 0, false) --- anim flag
    Wait(time)
    DeleteObject(brandingObj)
    FreezeEntityPosition(ped, false)
    return true -- retorna para seguir
end

function BrandingIronMark(netId, animalData)
    local firstname, lastname = Core.framework.getName()
    local brandingName = firstname .. ' '.. lastname

    --- You can use the logic below to find out which ranch the player belongs to and get the name of that ranch;
    --- however, if the player works at more than one ranch, this could cause problems!

    -- local ranchName = Core.callback.triggerServerSync('btc-ranch:server:getEmployeeRanchName')
    -- if ranchName then
    --     brandingName = ranchName
    -- end

    TriggerServerEvent('btc-ranch:server:createMark', netId, animalData, brandingName)
end

---------------------- Harvest Animals
function StartMilking(netId, animalData) --- Milking Cow and Goats
    local ped = NetToPed(netId)
    FreezeEntityPosition(ped, true)
    menu:showProgressBar(locale[103], 15000)
    TaskGoToEntity(PlayerPedId(), ped, -1, 1.25, 0.5, 0, 0)
    playAnim('script_rc@rch1@ig@ig_1_milkingthecow', 'milkingloop_john', 15000)
    Wait(15000)
    FreezeEntityPosition(ped, false)
    TriggerServerEvent('btc-ranch:server:milkAnimal', netId, animalData)
end

function StartWool(netId, animalData) -- Wool Sheeps
    local ped = NetToPed(netId)
    local playerPed = PlayerPedId()
    FreezeEntityPosition(ped, true)
    menu:showProgressBar(locale[104], 3000)
    FreezeEntityPosition(playerPed, true)
    playAnim('mech_inventory@crafting@fallbacks@in_hand@male_a', 'craft_trans_hold', 3000)
    Wait(3000)
    FreezeEntityPosition(playerPed, false)
    FreezeEntityPosition(ped, false)
    TriggerServerEvent('btc-ranch:server:woolAnimal', netId, animalData)
end

function StartCleaning(netId, animalData) -- Cleaning Pig
    local ped = NetToPed(netId)
    local playerPed = PlayerPedId()
    FreezeEntityPosition(ped, true)
    FreezeEntityPosition(playerPed, true)
    menu:showProgressBar(locale[105], 5000)
    playAnim('amb_work@world_human_gravedig@working@male_b@base', 'base', 5000)
    local rakeObj = CreateObject("p_shovel02x", 0, 0, 0, true, true, false)
    AttachEntityToEntity(rakeObj, PlayerPedId(), GetEntityBoneIndexByName(PlayerPedId(), "PH_R_Hand"), 0.0, 0.0, 0.19,
        0.0, 0.0, 0.0, false, false, true, false, 0, true, false, false)
    Wait(5000)
    DeleteObject(rakeObj)
    FreezeEntityPosition(playerPed, false)
    FreezeEntityPosition(ped, false)
    TriggerServerEvent('btc-ranch:server:cleaningAnimal', netId, animalData)
end

---- Feeding Animation

function FeedingAnim(ped, animalType)
    local eatAnim = false
    local playerPed = PlayerPedId()
    if animalType == 'Cattle' then
        eatAnim = joaat("WORLD_ANIMAL_COW_EATING_GROUND")
    elseif animalType == 'Sheep' then
        eatAnim = joaat("WORLD_ANIMAL_SHEEP_GRAZING")
    elseif animalType == 'Poultry' then
        eatAnim = joaat("WORLD_ANIMAL_CHICKEN_EATING")
    elseif animalType == 'Pigs' then
        eatAnim = joaat("WORLD_ANIMAL_PIG_GRAZING")
    elseif animalType == 'Goats' then
        eatAnim = joaat("WORLD_ANIMAL_GOAT_GRAZING")
    else
        eatAnim = false
    end


    if eatAnim then
        ClearPedTasksImmediately(ped)
        TaskStartScenarioInPlace(ped, eatAnim, -1)
        menu:showProgressBar(locale[102], Config.FeedingTime)

        ------------------- player feeding animation
        ---
        FreezeEntityPosition(playerPed, true)

        local animDict = "amb_work@world_human_feed_chickens@female_a@base"
        RequestAnimDict(animDict)
        while not HasAnimDictLoaded(animDict) do
            Wait(100)
        end

        local propName = "p_feedbag01bx"
        local propHash = GetHashKey(propName)
        RequestModel(propHash)
        while not HasModelLoaded(propHash) do
            Wait(0)
        end
        local prop = CreateObject(propHash, 1.0, 1.0, 1.0, true, true, false)
        AttachEntityToEntity(prop, PlayerPedId(), GetEntityBoneIndexByName(PlayerPedId(), "PH_L_Hand"), 0.0, 0.0, 0.0,
            0.0, 0.0, 0.0, false, false, true, false, 0, true, false, false)


        TaskPlayAnim(playerPed, animDict, "base", 8.0, -8.0, -1, 1, 0, false, false, false)

        Wait(Config.FeedingTime)

        ClearPedTasks(playerPed)
        DeleteObject(prop)

        SetCurrentPedWeapon(playerPed, `WEAPON_UNARMED`, true)
        FreezeEntityPosition(playerPed, false)
        ClearPedTasksImmediately(ped)
    end

end


----- Water
Config.useOtherWaterLogic = false --- if true you use the functions below

function CheckWaterItem()
    return true -- true or false
end


---------------------------
----------- Server Side
---------------------------

