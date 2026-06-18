RegisterCommand('getxpclient',function()
    local xp = exports['fx-hud']:getXP()
    print(xp)
end)
RegisterCommand('getlevelclient',function()
    local level = exports['fx-hud']:getLevel()
    print(level)
end)

RegisterCommand('getstatus',function()
    local status = exports['fx-hud']:getStatus("hunger")
    print(status)
end)

--- PROGRESSBAR --
function progressBar(itemName, progressTxt, progressDuration)
    SendNUIMessage({ 
        action = "ProgressBar", 
        item = itemName, 
        text = progressTxt, 
        duration = progressDuration 
    })
end

------ 
-- temp 
-- logged 
-- hunger 
-- thirst 
-- alcohol 
-- stress 

-- Citizen.CreateThread(function()
--     while true do
--         Wait(3000)
--         if not onEdit and logged then
--             print(temp)
--         end
--     end
-- end)

--########### EXAMPLE #######################
-- Citizen.CreateThread(function()
--     while true do
--         Wait(3000)
--         local stress = exports['fx-hud']:getStatus("stress")
--         if stress > 70 then
--             SetPedToRagdoll(PlayerPedId(), 1000, 1000, 0, 0, 0, 0) 
--             SetTimeout(1000, function()
--                 ResetPedRagdollTimer(PlayerPedId())
--             end)
--         end
--     end
-- end)
-- Citizen.CreateThread(function()
--     while true do
--         Wait(3000)
--         print(temp)
--     end
-- end)
-- Example Use Event SERVER SIDE
-- TriggerClientEvent("fx-hud:client:CustomAddStatus", source, "hunger", 50)
RegisterNetEvent("fx-hud:client:CustomAddStatus", function(statusType, value)
    exports['fx-hud']:setStatus(statusType,100)
end)

local com2 = Config.InGameAdminHudLoadCommand or "hudload"
RegisterCommand(com2,function()
    if not logged then
        TriggerServerEvent('fx-hud:server:GetDataDeveloper')
    end
end)

local frontend_soundset_ref = "Consumption_Sounds"
local frontend_soundset_name =  "Core_Fill_Up"
--( Params: hunger,thirst,stress,alcohol and Value must be INT)
local function ForceHeal()
    if IsEntityDead(PlayerPedId()) then return end
    local ped = PlayerPedId()
    local player = PlayerId()
    exports['fx-hud']:setStatus("hunger",100)
    exports['fx-hud']:setStatus("thirst",100)
    exports['fx-hud']:setStatus("stress",-100)-- or -100
    exports['fx-hud']:setStatus("alcohol",-100)-- or -100
    Citizen.InvokeNative(0xE3144B932DFDFF65,ped, 0.0, -1, 1, 1) -- Clean Dirty
    SetAttributeBaseRank(ped,16,0.0)
    SetAttributeBaseRank(ped,17,0.0)
    Citizen.InvokeNative(0xC6258F41D86676E0, ped, 0, 100)  --_SET_ATTRIBUTE_CORE_VALUE
	SetEntityHealth(ped, 600, 1)
	Citizen.InvokeNative(0xC6258F41D86676E0, ped, 1, 100)  --_SET_ATTRIBUTE_CORE_VALUE
	Citizen.InvokeNative(0x675680D089BFA21F, ped, 100.0) -- _RESTORE_PED_STAMINA
    Citizen.InvokeNative(0x4102732DF6B4005F, "RespawnPulseMP01", 0, true)
    Citizen.InvokeNative(0x0F2A2175734926D8,frontend_soundset_name, frontend_soundset_ref)   -- load sound frontend
    Citizen.InvokeNative(0x67C540AA08E4A6F5,frontend_soundset_name, frontend_soundset_ref, true, 0)  -- play sound frontend
    -- Citizen.InvokeNative(0xA9EC16C7,PlayerId(),Citizen.InvokeNative(0xE415EC5C,player)+100) --- Stamina
    SetTimeout(2000,function()
        AnimpostfxStopAll()
        Citizen.InvokeNative(0x9D746964E0CF2C5F,frontend_soundset_name, frontend_soundset_ref)  -- stop audio
    end)
end


RegisterNetEvent("fx-hud:client:ForceHeal", ForceHeal)

RegisterCommand('hidehud',function()
    exports['fx-hud']:hideHud()
end)

RegisterCommand('showhud',function()
    exports['fx-hud']:showHud()
end)

-- Citizen.CreateThread(function()
--     while true do
--         Wait(180 * 1000) 
--         if logged then
--             exports['fx-hud']:hideHud()
--             Wait(2000) 
--             exports['fx-hud']:showHud()
--         end
--     end
-- end)

--- ### LOCATIONS FUNCTIONS ### ---
function GetClosestTown(pedCoords)
    local minDistance = math.huge -- Başlangıçta sonsuz bir mesafe veriyoruz
    local closestTown = nil

    -- List of towns with coordinates
    local towns = {
        { name = "Blackwater", coords = vector3(-800.3203, -1300.4526, 43.5854) },
        { name = "Valentine", coords = vector3(-308.3902, 789.2656, 117.7540) },
        { name = "Saint Denis", coords = vector3(2652.1003, -1213.8416, 53.2344) },
        { name = "Strawberry", coords = vector3(-1809.9420, -388.6063, 161.6693) },
        { name = "Rhodes", coords = vector3(1323.2013, -1271.3915, 76.4865) },
        { name = "Van Horn", coords = vector3(2961.5879, 540.1491, 44.4313) },
        { name = "Annesburg", coords = vector3(2936.0779, 1358.3262, 44.1387) },
        { name = "Armadillo", coords = vector3(-3680.8669, -2610.8877, -14.0343) },
        { name = "Tumbleweed", coords = vector3(-5508.3579, -2938.3845, -1.9047) },
        -- Add more towns as needed
    }
    -- Iterate through towns to find the closest
    for _, town in ipairs(towns) do
        local distance = #(pedCoords - town.coords)
        if distance < minDistance then
            minDistance = distance 
            closestTown = town.name 
        end
    end
    -- return closestTown and closestTown .." "..Locale("neartown") or Locale("unkownneartown")
   return closestTown and (Locale("neartown") .. " " .. closestTown) or Locale("unkownneartown")
end

local isDead = false
Citizen.CreateThread(function()
    while true do
        Wait(2000)
        if IsEntityDead(PlayerPedId()) and logged and not isDead then
            exports['fx-hud']:hideHud()
            isDead = true
        elseif isDead and not IsEntityDead(PlayerPedId()) then
            exports['fx-hud']:showHud()
            isDead = false
        end
    end
end)

Citizen.CreateThread(function()
    local isHudHidden = false
    local mapOpenedOnce = false

    while true do
        Wait(1)
        local playerPed = PlayerPedId()
        local isPauseMenuActive = IsPauseMenuActive()
        local isMapActive = IsAppActive(`MAP`)

        if isPauseMenuActive and not isHudHidden then
            exports['fx-hud']:hideHud()
            isHudHidden = true
        elseif isMapActive == 1 and not isHudHidden then
            exports['fx-hud']:hideHud()
            isHudHidden = true
            mapOpenedOnce = true
        elseif not isPauseMenuActive and isMapActive == 0 and isHudHidden then
            exports['fx-hud']:showHud()
            isHudHidden = false
            mapOpenedOnce = false
        end
    end
end)

if Config.Temperature then
    CreateThread(function()
        while true do
            if logged then
                local ped = PlayerPedId()
                if temp and temp <= Config.Temperature.cold then
                    if Config.Temperature.Damage then
                        Citizen.InvokeNative(0x4102732DF6B4005F, "MP_Downed", 0, true)
                        PlayPain(ped, 9, 1, true, true)
                        ApplyDamageToPed(ped,Config.Temperature.Damage,0,0,ped)
                        SetTimeout(2000,function()
                            Citizen.InvokeNative(0xB4FD7446BAB2F394, "MP_Downed")
                        end)
                    end
                    if Config.Temperature.showNotfiy then
                        Notify({
                            text = Locale("coldmessage"),
                            time = 4000,
                            type = "warning"
                        })
                    end
                end 
                if temp and temp >= Config.Temperature.hot then
                    if Config.Temperature.Damage then
                        Citizen.InvokeNative(0x4102732DF6B4005F, "MP_Downed", 0, true)
                        PlayPain(ped, 9, 1, true, true)
                        ApplyDamageToPed(ped,Config.Temperature.Damage,false,14441,ped)
                        SetTimeout(2000,function()
                            Citizen.InvokeNative(0xB4FD7446BAB2F394, "MP_Downed")
                        end)
                    end
                    if Config.Temperature.showNotfiy then
                        Notify({
                            text = Locale("hotmessage"),
                            time = 4000,
                            type = "warning"
                        })
                    end
                end 
            end
            Wait(Config.Temperature.checkSecond*1000)
        end     
    end)
end

if Config.HudSettings.Hunger.decreaseOnRemoveHealthValue then
    CreateThread(function()
        while true do
            if not IsEntityDead(PlayerPedId()) and logged then
                local ped = PlayerPedId()
                if hunger <= 0 then
                    hunger = 0
                    Citizen.InvokeNative(0x4102732DF6B4005F, "MP_HealthDrop", 0, true)
                    PlayPain(ped, 9, 1, true, true)
                    if GetEntityHealth(ped) > 0 then
                        SetEntityHealth(ped, GetEntityHealth(ped) - Config.HudSettings.Hunger.decreaseOnRemoveHealthValue)                    
                    elseif GetEntityHealth(ped) == 0 then
                        SetEntityHealth(ped, 0)   
                    end
                    Notify({
                        text = Locale("hunger"),
                        time = 4000,
                        type = "warning"
                    })
                    SetTimeout(2000,function()
                        Citizen.InvokeNative(0xB4FD7446BAB2F394, "MP_HealthDrop")
                    end)
                end 
            end
            Wait(5000)
        end     
    end)
end

if Config.HudSettings.Thirst.decreaseOnRemoveHealthValue then
    CreateThread(function()
        while true do
            if not IsEntityDead(PlayerPedId()) and logged then
                local ped = PlayerPedId()
                if thirst <= 0 then
                    thirst = 0
                    Citizen.InvokeNative(0x4102732DF6B4005F, "MP_HealthDrop", 0, true)
                    PlayPain(ped, 9, 1, true, true)
                    if GetEntityHealth(ped) > 0 then
                        SetEntityHealth(ped, GetEntityHealth(ped) - Config.HudSettings.Thirst.decreaseOnRemoveHealthValue)                    
                    elseif GetEntityHealth(ped) == 0 then
                        SetEntityHealth(ped, 0)   
                    end
                    Notify({
                        text = Locale("thirsty"),
                        time = 4000,
                        type = "warning"
                    })
                    SetTimeout(2000,function()
                        Citizen.InvokeNative(0xB4FD7446BAB2F394, "MP_HealthDrop")
                    end)
                end 
            end
            Wait(5000)
        end     
    end)
end

if Config.HudSettings.Stress then
    if Config.HudSettings.Stress.speeding then
        Citizen.CreateThread(function() -- Speeding
            while true do
                if not IsEntityDead(PlayerPedId()) and logged then
                    local player = PlayerId()
                    local ped = PlayerPedId()
                    local entity = 0
                    local speedThreshold = Config.HudSettings.Stress.speedingValue

                    if IsPedInAnyVehicle(ped, false) then
                        local vehicle = GetVehiclePedIsIn(ped, false)
                        local isDriver = (vehicle and vehicle ~= 0) and (GetPedInVehicleSeat(vehicle, -1) == ped) or false
                        local isTrain = IsPedInAnyTrain(ped) or IsPlayerRidingTrain(player) or ((vehicle and vehicle ~= 0) and GetVehicleType(vehicle) == "train")
                        if isDriver then
                            if not isTrain then
                                entity = vehicle
                            end
                        end
                    elseif IsPedOnMount(ped) then
                        local mount = GetMount(ped)
                        -- Passenger seat on a mount should not gain speeding stress.
                        local isMountDriver = (mount and mount ~= 0) and (GetPedInVehicleSeat(mount, -1) == ped) or false
                        if isMountDriver then
                            entity = mount
                        end
                    end

                    if entity and entity ~= 0 then
                        local speed = GetEntitySpeed(entity)
                        if speed >= speedThreshold then
                            stress = stress + (Config.HudSettings.Stress.speedStress or 1.0)
                        end
                    end
                end
                Wait(1000)
            end
        end)
    end

    if Config.HudSettings.Stress.shooting then
        Citizen.CreateThread(function()
            while true do
                if not IsEntityDead(PlayerPedId()) and logged then
                    local ped = PlayerPedId()
                    local random = math.random(1,100)
                    if random <= Config.HudSettings.Stress.shootingchange and IsPedShooting(ped) then
                        stress = stress + (Config.HudSettings.Stress.shootingStress or 1.0)
                        Wait(2000)
                    end
                end
                Wait(1)
            end
        end)
    end

    CreateThread(function()
        while true do
            local time = 10000
            if not IsEntityDead(PlayerPedId()) and logged then
                local ped = PlayerPedId()
                if stress >= 100 then
                    time = time * 3 
                    local FallRepeat = math.random(2, 4)
                    local RagdollTimeout = FallRepeat * 1750
                    ShakeGameplayCam(Config.HudSettings.Stress.ShakeGameplayCam.Effect, Config.HudSettings.Stress.ShakeGameplayCam.Value)
                    if not IsPedRagdoll(ped) and IsPedOnFoot(ped) and not IsPedSwimming(ped) then
                        SetPedToRagdollWithFall(ped, RagdollTimeout, RagdollTimeout, 1, GetEntityForwardVector(player), 1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0)
                    end
        
                    Wait(500)
                    for i = 1, FallRepeat, 1 do
                        Wait(750)
                        DoScreenFadeOut(200)
                        Wait(1000)
                        DoScreenFadeIn(200)
                        ShakeGameplayCam(Config.HudSettings.Stress.ShakeGameplayCam.Effect, Config.HudSettings.Stress.ShakeGameplayCam.Value)
                    end
                elseif stress >= Config.HudSettings.Stress.shakeScreenValue then
                    ShakeGameplayCam(Config.HudSettings.Stress.ShakeGameplayCam.Effect, Config.HudSettings.Stress.ShakeGameplayCam.Value)
                end
            end
            Wait(time)
        end
    end)
    ---- STAMINA RAGDOLL
    -- Citizen.CreateThread(function()
    --     while true do
    --         Citizen.Wait(1000) 
    --         if logged then
    --             local ped = PlayerPedId()
    --             local stamina = tonumber(string.format("%.2f", Citizen.InvokeNative(0x775A1CA7893AA8B5, ped, Citizen.ResultAsFloat())))
    --             local chance = math.random(1, 100)
    --             if stamina <= 5 and not IsPedRagdoll(ped) and IsPedOnFoot(ped) and not IsPedSwimming(ped) then
    --                 if chance <= 10 then
    --                     SetPedToRagdollWithFall(ped, 1500, 1500, 1, GetEntityForwardVector(ped), 1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0)
    --                     Wait(2000)
    --                     ResetPedRagdollTimer(ped)
    --                 end
    --             end
    --         end
    --     end
    -- end)
end

-- RegisterNetEvent('vorpmetabolism:snakedamage')
-- AddEventHandler('vorpmetabolism:snakedamage', function(number, number2)
--     exports['fx-hud']:setStatus("hunger", -number)
--     exports['fx-hud']:setStatus("thirst", -number2)
-- end)


zoneHashMapping = {
    -- State (ZoneType 0)
    [-221059932] = "Ambarino", [1935063277] = "Guarma", [10837344] = "Lemoyne",
    [-1973391500] = "Low W. Elizabeth", [2045157995] = "New Austin", 
    [-1289136221] = "New Hanover", [613867492] = "Nuevo Paraiso",
    [-1247148211] = "Upp W. Elizabeth", [1246494439] = "W. Elizabeth",

    -- Town (ZoneType 1)
    [1654810713] = "Aguas Farm", [201158410] = "Aguas Ruins", [-1207133769] = "Aguas Villa",
    [7359335] = "Annesburg", [-744494798] = "Armadillo", [-1708386982] = "Beecher's Hope",
    [1053078005] = "Blackwater", [1778899666] = "Braithwaite", [-1947415645] = "Butcher Crk",
    [1862420670] = "Caliga Hall", [-1851305682] = "Cornwall", [-473051294] = "Emerald Rch",
    [406627834] = "Lagras", [1299204683] = "Manicato", [1463094051] = "Manzanita",
    [2046780049] = "Rhodes", [2147354003] = "Siska", [-765540529] = "Saint Denis",
    [427683330] = "Strawberry", [-1524959147] = "Tumbleweed", [459833523] = "Valentine",
    [2126321341] = "Van Horn", [-872622034] = "Wallace Stn", [1663398575] = "Wapiti",

    -- District (ZoneType 10)
    [2025841068] = "Bayou Nwa Dist", [822658194] = "Big Valley Dist", [1308232528] = "Bluewtr Marsh",
    [-108848014] = "Cholla Sprngs", [1835499550] = "Cumb. Forest", [426773653] = "Diez Coronas",
    [-2066240242] = "Gaptooth Ridge", [476637847] = "Great Plains", [-120156735] = "Grizzlies E.",
    [1645618177] = "Grizzlies W.", [-512529193] = "Guarma D.", [131399519] = "Heartlands",
    [892930832] = "Henn. Stead", [-1319956120] = "Perdido", [1453836102] = "Punta Orgullo",
    [-2145992129] = "Rio Bravo", [178647645] = "Roanoke", [-864275692] = "Scarlett Mdw",
    [1684533001] = "Tall Trees",

    -- Water Bodies (ZoneType 2, 3, 5, 6, 7, 8)
    [-196675805] = "Aurora Basin", [795414694] = "Barrow Lagoon", [231313522] = "Calmut Ravine",
    [-105598602] = "Elysian Pool", [-1356490953] = "Flat Iron Lk", [1755369577] = "Heartlands Ovf",
    [-1369817450] = "Lake Don Julio", [592454541] = "Lake Isabella", [-1817904483] = "O'Creagh's Run",
    [-1300497193] = "Owanjila", [-247856387] = "Sea of Coronado", [-49694339] = "Arroyo de la Vib.",
    [650214731] = "Beartooth Beck", [370072007] = "Dakota River", [-1229593481] = "Kamassa River",
    [-2040708515] = "Lannahechee", [-1410384421] = "Little Creek", [-1308233316] = "Lower Montana",
    [-1504425495] = "San Luis River", [-1781130443] = "Upper Montana", [-557290573] = "Bayou Nwa",
    [-1168459546] = "Bahia de la Paz", [1245451421] = "Deadboot Crk", [469159176] = "Dewberry Crk",
    [-1276586360] = "Hawk's Eye Crk", [2005774838] = "Ringneck Crk", [-218679770] = "Spider Gorge",
    [-1287619521] = "Stillwater Crk", [-261541730] = "Whinyard Strt", [-1073312073] = "Cairn Lake",
    [-804804953] = "Cattail Pond", [1175365009] = "Hot Springs", [301094150] = "Mattlock Pond",
    [-811730579] = "Moonstone Pond", [-823661292] = "Southfield Flat",
}


local function addChatSuggestions(commands)
    for _, command in ipairs(commands) do
        TriggerEvent('chat:addSuggestion', '/' .. command.name, command.description, command.params)
    end
end

local commands = {
    { 
        name = "addxp", 
        description = "Add XP to a player", 
        params = {
            { name = "playerId", help = "ID of the player" },
            { name = "xpAmount", help = "Amount of XP to add" }
        }
    },
    { 
        name = "removexp", 
        description = "Remove XP from a player", 
        params = {
            { name = "playerId", help = "ID of the player" },
            { name = "xpAmount", help = "Amount of XP to remove" }
        }
    },
    { 
        name = "getxp", 
        description = "Get current XP of a player", 
        params = {
            { name = "playerId", help = "ID of the player" }
        }
    },
    { 
        name = "getlevel", 
        description = "Get current level of a player", 
        params = {
            { name = "playerId", help = "ID of the player" }
        }
    }
}

CreateThread(function()
    Wait(1000)
    addChatSuggestions(commands)
end)

local activeAlcoholTask = false

CreateThread(function()
    while true do
        if not IsEntityDead(PlayerPedId()) then
            local data = Config.HudSettings.Alcohol.ResetAlcohol
            local threshold = data.decreaseOnAlcohol or 85
            local interval = data.RemoveTime or 4
            local removeAmount = data.RemoveAlcoholValue or 5
            if alcohol >= threshold and not activeAlcoholTask then
                activeAlcoholTask = true
                CreateThread(function()
                    while alcohol > 0 do
                        alcohol = alcohol - removeAmount
                        if alcohol < 0 then
                            alcohol = 0
                        end
    
                        Wait(interval * 1000)
    
                        if alcohol <= 0 then
                            break
                        end
                    end
    
                    activeAlcoholTask = false
                end)
            end
        end
        Wait(3000) 
    end
end)


-- SWIMMING STAMINA RECOVER
if Config.RechargeHuds.stamina.rechargeSwimming then
    CreateThread(function()
        while true do
            local ped = PlayerPedId()
            local data = Config.RechargeHuds.stamina
            if logged and not IsEntityDead(ped) and (IsPedSwimming(ped) or IsPedSwimmingUnderWater(ped)) then
                local currentStaminaCore = GetAttributeCoreValue(ped, 1) 
                if not IsPedSprinting(ped) then
                    SetStaminaRechargeMultiplier(ped, data.SetPlayerStaminaRechargeMultiplier)
                    SetPlayerStaminaRechargeMultiplier(PlayerId(), data.SetPlayerStaminaRechargeMultiplier)
                    local newStaminaCore = math.min(currentStaminaCore + data.rechargeSwimmingValue, 100)
                    SetAttributeCoreValue(ped, 1, newStaminaCore)
                    Citizen.InvokeNative(0xC3D4B754C0E86B9E, ped, tonumber(string.format("%.2f", data.rechargeSwimmingValue)))
                end
            end
            Wait(2000)
        end
    end)
end

--- PED OUTER CORE ---
CreateThread(function()
    while true do
        local ped = PlayerPedId()
        if logged and not IsEntityDead(ped) and not IsPedSprinting(ped) and Config.RechargeHuds.health.recharge then
            SetHealthRechargeMultiplier(ped, Config.RechargeHuds.health.SetPlayerHealthRechargeMultiplier)
            SetPlayerHealthRechargeTimeModifier(PlayerId(), Config.RechargeHuds.health.SetPlayerHealthRechargeMultiplier)
        end
        Wait(Config.RechargeHuds.health.reChargeTime * 1000)
    end
end)

CreateThread(function()
    while true do
        if logged and not IsEntityDead(PlayerPedId()) and Config.RechargeHuds.stamina.recharge then
            local ped = PlayerPedId()
            if not IsPedSprinting(ped) then
                SetStaminaRechargeMultiplier(ped, Config.RechargeHuds.stamina.SetPlayerStaminaRechargeMultiplier)
                SetPlayerStaminaRechargeMultiplier(PlayerId(), Config.RechargeHuds.stamina.SetPlayerStaminaRechargeMultiplier)
            end
        end
        Wait(Config.RechargeHuds.stamina.reChargeTime * 1000)
    end
end)

--- HORSE OUTER CORE ---
CreateThread(function()
    while true do
        if logged and not IsEntityDead(PlayerPedId()) and Config.RechargeHuds.horsehealth.recharge then
            local ped = PlayerPedId()
            local horse = GetMount(ped)
            if horse > 0 then
                SetHealthRechargeMultiplier(horse, Config.RechargeHuds.horsehealth.SetHealthRechargeMultiplier)
            end
        end
        Wait(Config.RechargeHuds.horsehealth.reChargeTime * 1000)
    end
end)

CreateThread(function()
    while true do
        if logged and not IsEntityDead(PlayerPedId()) and Config.RechargeHuds.horsestamina.recharge then
            local ped = PlayerPedId()
            local horse = GetMount(ped)
            if horse > 0 and not IsPedSprinting(horse) then
                SetStaminaRechargeMultiplier(horse, Config.RechargeHuds.horsestamina.SetStaminaRechargeMultiplier)
            end
        end
        Wait(Config.RechargeHuds.horsestamina.reChargeTime * 1000)
    end
end)

--- PED INNER CORE ---
CreateThread(function()
    while true do
        local ped = PlayerPedId()
        if logged and not IsEntityDead(ped) and not IsPedSprinting(ped) and Config.RechargeHuds.healthCore.recharge then
            local currentHealthCore = GetAttributeCoreValue(ped, 0) 
            if currentHealthCore < 100 then
                local newHealthCore = math.min(currentHealthCore + Config.RechargeHuds.healthCore.rechargeValue, 100)
                SetAttributeCoreValue(ped, 0, newHealthCore)
            end
        end
        Wait(Config.RechargeHuds.healthCore.reChargeTime * 1000)
    end
end)

CreateThread(function()
    while true do
        if logged and not IsEntityDead(PlayerPedId()) and Config.RechargeHuds.staminaCore.recharge then
            local ped = PlayerPedId()
            local currentStaminaCore = GetAttributeCoreValue(ped, 1) 
            if not IsPedSprinting(ped) and currentStaminaCore < 100 then
                local newStaminaCore = math.min(currentStaminaCore + Config.RechargeHuds.staminaCore.rechargeValue, 100)
                SetAttributeCoreValue(ped, 1, newStaminaCore)
            end
        end
        Wait(Config.RechargeHuds.staminaCore.reChargeTime * 1000)
    end
end)

--- HORSE INNER CORE ---
CreateThread(function()
    while true do
        if logged and not IsEntityDead(PlayerPedId()) and Config.RechargeHuds.horsehealthCore.recharge then
            local ped = PlayerPedId()
            local horse = GetMount(ped)
            if horse > 0 then
                local currentHorseHealthCore = GetAttributeCoreValue(horse, 0) 
                if currentHorseHealthCore < 100 then
                    local newHorseHealthCore = math.min(currentHorseHealthCore + Config.RechargeHuds.horsehealthCore.rechargeValue, 100)
                    SetAttributeCoreValue(horse, 0, newHorseHealthCore)
                end
            end
        end
        Wait(Config.RechargeHuds.horsehealthCore.reChargeTime * 1000)
    end
end)

CreateThread(function()
    while true do
        if logged and not IsEntityDead(PlayerPedId()) and Config.RechargeHuds.horsestaminaCore.recharge then
            local ped = PlayerPedId()
            local horse = GetMount(ped)
            if horse > 0 and not IsPedSprinting(horse) then
                local currentHorseStaminaCore = GetAttributeCoreValue(horse, 1) 
                if currentHorseStaminaCore < 100 then
                    local newHorseStaminaCore = math.min(currentHorseStaminaCore + Config.RechargeHuds.horsestaminaCore.rechargeValue, 100)
                    SetAttributeCoreValue(horse, 1, newHorseStaminaCore)
                end
            end
        end
        Wait(Config.RechargeHuds.horsestaminaCore.reChargeTime * 1000)
    end
end)

function SendPVPNotifications(state)
    if not Config.UsePvpSystem then return end
    if state then
        -- PVP ON

        TriggerEvent("chat:addMessage", {
            color = {255, 0, 0},
            multiline = true,
            args = {
                Locale("system"),
                Locale("pvpon_chat")
            }
        })

        Notify({
            text = Locale("pvpon_notify"),
            type = "error",
            time = 4000
        })

    else
        -- PVP OFF

        TriggerEvent("chat:addMessage", {
            color = {74, 207, 12},
            multiline = true,
            args = {
                Locale("system"),
                Locale("pvpoff_chat")
            }
        })

        Notify({
            text = Locale("pvpoff_notify"),
            type = "success",
            time = 4000
        })
    end
end

if Config.UsePvpSystem then
    CreateThread(function()
        while true do
    
            if not PVPState then
                Wait(0)
    
                local playerPed = PlayerPedId()
    
                DisablePlayerFiring(PlayerId(), true)
    
                DisableControlAction(0, 0x07CE1E61, true) -- Attack
                DisableControlAction(0, 0xB2F377E8, true) -- Melee
    
                if IsPlayerFreeAiming(PlayerId()) then
                    local entity = GetEntityPlayerIsFreeAimingAt(PlayerId())
                    if entity and DoesEntityExist(entity) then
                        if IsEntityAPed(entity) and IsPedAPlayer(entity) then
                            ClearPlayerTargeting(PlayerId())
                        end
                    end
                end
    
            else
                Wait(500)
            end
        end
    end)
    
end

function CigaretteEvent(propName)
    local ped = PlayerPedId()
    local male = IsPedMale(ped)
    local x,y,z = table.unpack(GetEntityCoords(ped, true))
    local cigarette = CreateObject(GetHashKey(propName), x, y, z + 0.2, true, true, true)
    local righthand = GetEntityBoneIndexByName(ped, "SKEL_R_Finger13")
    local mouth = GetEntityBoneIndexByName(ped, "skel_head")
    
    if male then
        AttachEntityToEntity(cigarette, ped, mouth, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, true, true, false, true, 1, true)
        Anim(ped,"amb_rest@world_human_smoking@male_c@stand_enter","enter_back_rf",9400,0)
        Wait(1000)
        AttachEntityToEntity(cigarette, ped, righthand, 0.03, -0.01, 0.0, 0.0, 90.0, 0.0, true, true, false, true, 1, true)
        Wait(1000)
        AttachEntityToEntity(cigarette, ped, mouth, -0.017, 0.1, -0.01, 0.0, 90.0, -90.0, true, true, false, true, 1, true)
        Wait(3000)
        AttachEntityToEntity(cigarette, ped, righthand, 0.017, -0.01, -0.01, 0.0, 120.0, 10.0, true, true, false, true, 1, true)
        Wait(1000)
        Anim(ped,"amb_rest@world_human_smoking@male_c@base","base",-1,30)
        RemoveAnimDict("amb_rest@world_human_smoking@male_c@stand_enter")
        Wait(1000)
    else --female
        AttachEntityToEntity(cigarette, ped, mouth, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, true, true, false, true, 1, true)
        Anim(ped,"amb_rest@world_human_smoking@female_c@base","base",-1,30)
        Wait(1000)
        AttachEntityToEntity(cigarette, ped, righthand, 0.01, 0.0, 0.01, 0.0, -160.0, -130.0, true, true, false, true, 1, true)
        Wait(2500)
    end

    local stance="c"

    if male then
        while  IsEntityPlayingAnim(ped, "amb_rest@world_human_smoking@male_c@base","base", 3)
            or IsEntityPlayingAnim(ped, "amb_rest@world_human_smoking@nervous_stressed@male_b@base","base", 3)
            or IsEntityPlayingAnim(ped, "amb_rest@world_human_smoking@male_d@base","base", 3)
            or IsEntityPlayingAnim(ped, "amb_wander@code_human_smoking_wander@male_a@base","base", 3) do

            Wait(5)
            PromptSetActiveGroupThisFrame(prompts, Locale("promptsmoketitle"))
            if PromptHasHoldModeCompleted(movements[1]) then
                ClearPedSecondaryTask(ped)
                Anim(ped, "amb_rest@world_human_smoking@male_a@stand_exit", "exit_back", -1, 1)
                Wait(2800)
                DetachEntity(cigarette, true, true)
                SetEntityVelocity(cigarette, 0.0,0.0,-1.0)
                Wait(1500)
                ClearPedSecondaryTask(ped)
                ClearPedTasks(ped)
                Wait(10)
            end
            if PromptHasHoldModeCompleted(movements[3]) then
                if stance=="c" then
                    Anim(ped, "amb_rest@world_human_smoking@nervous_stressed@male_b@base", "base", -1, 30)
                    Wait(1000)
                    while not IsEntityPlayingAnim(ped,"amb_rest@world_human_smoking@nervous_stressed@male_b@base", "base", 3) do
                        Wait(100)
                    end    
                    stance="b"
                elseif stance=="b" then
                    Anim(ped, "amb_rest@world_human_smoking@male_d@base", "base", -1, 30)
                    Wait(1000)
                    while not IsEntityPlayingAnim(ped,"amb_rest@world_human_smoking@male_d@base","base", 3) do
                        Wait(100)
                    end
                    stance="d"
                elseif stance=="d" then
                    Anim(ped, "amb_rest@world_human_smoking@male_d@trans", "d_trans_a", -1, 30)
                    Wait(4000)
                    Anim(ped, "amb_wander@code_human_smoking_wander@male_a@base", "base", -1, 30, 0)
                    while not IsEntityPlayingAnim(ped,"amb_wander@code_human_smoking_wander@male_a@base","base", 3) do
                        Wait(100)
                    end
                    stance="a"
                else --stance=="a"
                    Anim(ped, "amb_rest@world_human_smoking@male_a@trans", "a_trans_c", -1, 30)
                    Wait(4233)
                    Anim(ped,"amb_rest@world_human_smoking@male_c@base","base",-1,30,0)
                    while not IsEntityPlayingAnim(ped,"amb_rest@world_human_smoking@male_c@base","base", 3) do
                        Wait(100)
                    end
                    stance="c"
                end
            end
        
            if stance=="c" then
                if PromptHasHoldModeCompleted(movements[2]) then
                    Wait(500)
                    if IsControlPressed(0, 0x07B8BEAF) then
                        Anim(ped, "amb_rest@world_human_smoking@male_c@idle_a","idle_b", -1, 30, 0)
                        Wait(21166)
                        Anim(ped, "amb_rest@world_human_smoking@male_c@base","base", -1, 30, 0)
                        Wait(100)
                    else
                        Anim(ped, "amb_rest@world_human_smoking@male_c@idle_a","idle_a", -1, 30, 0)
                        Wait(8500)
                        Anim(ped, "amb_rest@world_human_smoking@male_c@base","base", -1, 30, 0)
                        Wait(100)
                    end
                end
            elseif stance=="b" then
                if PromptHasHoldModeCompleted(movements[2]) then
                    Wait(500)
                    if IsControlPressed(0, 0x07B8BEAF) then
                        Anim(ped, "amb_rest@world_human_smoking@nervous_stressed@male_b@idle_c","idle_g", -1, 30, 0)
                        Wait(13433)
                        Anim(ped, "amb_rest@world_human_smoking@nervous_stressed@male_b@base", "base", -1, 30, 0)
                        Wait(100)
                    else
                        Anim(ped, "amb_rest@world_human_smoking@nervous_stressed@male_b@idle_a", "idle_a", -1, 30, 0)
                        Wait(3199)
                        Anim(ped, "amb_rest@world_human_smoking@nervous_stressed@male_b@base", "base", -1, 30, 0)
                        Wait(100)
                    end
                end
            elseif stance=="d" then
                if PromptHasHoldModeCompleted(movements[2]) then
                    Wait(500)
                    if IsControlPressed(0, 0x07B8BEAF) then
                        Anim(ped, "amb_rest@world_human_smoking@male_d@idle_a","idle_b", -1, 30, 0)
                        Wait(7366)
                        Anim(ped, "amb_rest@world_human_smoking@male_d@base", "base", -1, 30, 0)
                        Wait(100)
                    else
                        Anim(ped, "amb_rest@world_human_smoking@male_d@idle_c", "idle_g", -1, 30, 0)
                        Wait(7866)
                        Anim(ped, "amb_rest@world_human_smoking@male_d@base", "base", -1, 30, 0)
                        Wait(100)
                    end
                end
            else --stance=="a"
                if PromptHasHoldModeCompleted(movements[2]) then
                    Wait(500)
                    if IsControlPressed(0, 0x07B8BEAF) then
                        Anim(ped, "amb_rest@world_human_smoking@male_a@idle_a", "idle_b", -1, 30, 0)
                        Wait(12533)
                        Anim(ped, "amb_wander@code_human_smoking_wander@male_a@base", "base", -1, 30, 0)
                        Wait(100)
                    else
                        Anim(ped, "amb_rest@world_human_smoking@male_a@idle_a","idle_a", -1, 30, 0)
                        Wait(8200)
                        Anim(ped, "amb_wander@code_human_smoking_wander@male_a@base", "base", -1, 30, 0)
                        Wait(100)
                    end
                end
            end
        end
    else --if female
        while  IsEntityPlayingAnim(ped,"amb_rest@world_human_smoking@female_c@base", "base", 3) 
            or IsEntityPlayingAnim(ped,"amb_rest@world_human_smoking@female_b@base", "base", 3)
            or IsEntityPlayingAnim(ped,"amb_rest@world_human_smoking@female_a@base", "base", 3)do
            PromptSetActiveGroupThisFrame(prompts, Locale("promptsmoketitle"))
            Wait(5)
            if PromptHasHoldModeCompleted(movements[1]) then

                ClearPedSecondaryTask(ped)
                Anim(ped, "amb_rest@world_human_smoking@female_b@trans", "b_trans_fire_stand_a", -1, 1)
                Wait(3800)
                DetachEntity(cigarette, true, true)
                Wait(800)
                ClearPedSecondaryTask(ped)
                ClearPedTasks(ped)
                Wait(10)
            end
            local stanceChanged = false
            if PromptHasHoldModeCompleted(movements[3]) then
                stanceChanged = true
                if stance=="c" then
                    Anim(ped, "amb_rest@world_human_smoking@female_b@base", "base", -1, 30)
                    Wait(1000)
                    while not IsEntityPlayingAnim(ped,"amb_rest@world_human_smoking@female_b@base", "base", 3) do
                        Wait(100)
                    end
                    stance="b"
                elseif stance=="b" then
                    Anim(ped, "amb_rest@world_human_smoking@female_b@trans", "b_trans_a", -1, 30)
                    Wait(5733)
                    Anim(ped, "amb_rest@world_human_smoking@female_a@base", "base", -1, 30, 0)
                    while not IsEntityPlayingAnim(ped,"amb_rest@world_human_smoking@female_a@base","base", 3) do
                        Wait(100)
                    end
                    stance="a"
                else --stance=="a"
                    Anim(ped,"amb_rest@world_human_smoking@female_c@base","base",-1,30)
                    Wait(1000)
                    while not IsEntityPlayingAnim(ped,"amb_rest@world_human_smoking@female_c@base","base", 3) do
                        Wait(100)
                    end
                    stance="c"
                end
            end
            if not stanceChanged then
                if stance=="c" then
                    if PromptHasHoldModeCompleted(movements[2]) then
                        Wait(500)
                        local r = math.random(1, 5)
                        if r == 1 then
                            Anim(ped, "amb_rest@world_human_smoking@female_c@idle_a","idle_a", -1, 30, 0)
                            Wait(9566)
                        elseif r == 2 then
                            Anim(ped, "amb_rest@world_human_smoking@female_c@idle_a","idle_b", -1, 30, 0)
                            Wait(8000)
                        elseif r == 3 then
                            Anim(ped, "amb_rest@world_human_smoking@female_c@idle_b","idle_d", -1, 30, 0)
                            Wait(10000)
                        elseif r == 4 then
                            Anim(ped, "amb_rest@world_human_smoking@female_c@idle_b","idle_e", -1, 30, 0)
                            Wait(8000)
                        else
                            Anim(ped, "amb_rest@world_human_smoking@female_c@idle_b","idle_f", -1, 30, 0)
                            Wait(8133)
                        end
                        Anim(ped, "amb_rest@world_human_smoking@female_c@base","base", -1, 30, 0)
                        Wait(100)
                    end
                elseif stance=="b" then
                    if PromptHasHoldModeCompleted(movements[2]) then
                        Wait(500)
                        if math.random(1, 2) == 1 then
                            Anim(ped, "amb_rest@world_human_smoking@female_b@idle_b","idle_f", -1, 30, 0)
                            Wait(8033)
                        else
                            Anim(ped, "amb_rest@world_human_smoking@female_b@idle_a", "idle_b", -1, 30, 0)
                            Wait(4266)
                        end
                        Anim(ped, "amb_rest@world_human_smoking@female_b@base", "base", -1, 30, 0)
                        Wait(100)
                    end
                else --stance=="a"
                    if PromptHasHoldModeCompleted(movements[2]) then
                        Wait(500)
                        if math.random(1, 2) == 1 then
                            Anim(ped, "amb_rest@world_human_smoking@female_a@idle_b", "idle_d", -1, 30, 0)
                            Wait(14566)
                        else
                            Anim(ped, "amb_rest@world_human_smoking@female_a@idle_a","idle_b", -1, 30, 0)
                            Wait(6100)
                        end
                        Anim(ped, "amb_rest@world_human_smoking@female_a@base", "base", -1, 30, 0)
                        Wait(100)
                    end
                end
            end
        end
    end
    DetachEntity(cigarette, true, true)
    ClearPedSecondaryTask(ped)
    RemoveAnimDict("amb_wander@code_human_smoking_wander@male_a@base")
    RemoveAnimDict("amb_rest@world_human_smoking@male_a@idle_a")
    RemoveAnimDict("amb_rest@world_human_smoking@nervous_stressed@male_b@base")
    RemoveAnimDict("amb_rest@world_human_smoking@nervous_stressed@male_b@idle_a")
    RemoveAnimDict("amb_rest@world_human_smoking@nervous_stressed@male_b@idle_g")
    RemoveAnimDict("amb_rest@world_human_smoking@male_c@base")
    RemoveAnimDict("amb_rest@world_human_smoking@male_c@idle_a")
    RemoveAnimDict("amb_rest@world_human_smoking@male_d@base")
    RemoveAnimDict("amb_rest@world_human_smoking@male_d@idle_a")
    RemoveAnimDict("amb_rest@world_human_smoking@male_d@idle_c")
    RemoveAnimDict("amb_rest@world_human_smoking@male_a@trans")
    RemoveAnimDict("amb_rest@world_human_smoking@male_c@trans")
    RemoveAnimDict("amb_rest@world_human_smoking@male_d@trans")
    RemoveAnimDict("amb_rest@world_human_smoking@female_a@base")
    RemoveAnimDict("amb_rest@world_human_smoking@female_a@idle_a")
    RemoveAnimDict("amb_rest@world_human_smoking@female_a@idle_b")
    RemoveAnimDict("amb_rest@world_human_smoking@female_b@base")
    RemoveAnimDict("amb_rest@world_human_smoking@female_b@idle_a")
    RemoveAnimDict("amb_rest@world_human_smoking@female_b@idle_b")
    RemoveAnimDict("amb_rest@world_human_smoking@female_c@base")
    RemoveAnimDict("amb_rest@world_human_smoking@female_c@idle_a")
    RemoveAnimDict("amb_rest@world_human_smoking@female_c@idle_b")
    RemoveAnimDict("amb_rest@world_human_smoking@female_b@trans")
    Wait(100)
    ClearPedTasks(ped)
end


-- Citizen.CreateThread(function()
--     while true do
--         local ped = PlayerPedId()
--         local health = 0
--         local stamina = 1
--         local InnerCoreStamina = GetAttributeCoreOverpowerSecondsLeft(ped, stamina)
--         local staminaOuterCoreGold = GetAttributeOverpowerSecondsLeft(ped, stamina)
--         print("InnerCoreStamina: " .. InnerCoreStamina .. ", staminaOuterCoreGold: " .. staminaOuterCoreGold)
--         Wait(1000)
--     end
-- end)