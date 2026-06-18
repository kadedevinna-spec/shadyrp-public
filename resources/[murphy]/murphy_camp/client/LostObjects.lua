--- "Lost Objects" recovery points. For each entry in Config.LostObjects.locations:
---   * if `ped` is provided, spawn the NPC with the configured model and scenario;
---   * always register a murphy_interact prompt at the coords (with or without ped);
---   * always add a blip if Config.LostObjects.blip.enabled is true.

local spawnedPeds = {}
local spawnedBlips = {}
local interactionIds = {}

local function spawnPed(loc)
    if not loc.ped or not loc.ped.model then return nil end
    local modelHash = type(loc.ped.model) == 'string' and GetHashKey(loc.ped.model) or loc.ped.model
    RequestModel(modelHash)
    local attempts = 0
    while not HasModelLoaded(modelHash) and attempts < 200 do
        Wait(10)
        attempts = attempts + 1
    end
    if not HasModelLoaded(modelHash) then return nil end

    local ped = CreatePed(modelHash, loc.coords.x, loc.coords.y, loc.coords.z - 1.0, loc.heading or 0.0, false, true)
    if not ped or ped == 0 then return nil end

    if EquipMetaPedOutfitPreset and loc.ped.outfit then
        EquipMetaPedOutfitPreset(ped, loc.ped.outfit)
    end
    PlaceEntityOnGroundProperly(ped)
    SetEntityHeading(ped, loc.heading or 0.0)
    FreezeEntityPosition(ped, true)
    SetEntityInvincible(ped, true)
    SetBlockingOfNonTemporaryEvents(ped, true)
    if loc.ped.scenario then
        TaskStartScenarioInPlace(ped, loc.ped.scenario, -1, false)
    end
    SetModelAsNoLongerNeeded(modelHash)
    return ped
end

local function addBlip(loc)
    local b = Config.LostObjects.blip
    if not b or not b.enabled then return nil end
    local blip = Citizen.InvokeNative(0x554D9D53F696D002, 1664425300, loc.coords)
    SetBlipSprite(blip, b.sprite or 1861010125)
    SetBlipScale(blip, b.scale or 0.25)
    Citizen.InvokeNative(0x9CB1A1623062F402, blip, b.label or Translate[35])
    return blip
end

local function registerLocation(index, loc)
    if not loc or not loc.coords then return end

    local ped = spawnPed(loc)
    if ped then spawnedPeds[#spawnedPeds + 1] = ped end

    local blip = addBlip(loc)
    if blip then spawnedBlips[#spawnedBlips + 1] = blip end

    local id = ('murphy_camp:lostobjects:%d'):format(index)
    interactionIds[#interactionIds + 1] = id
    exports.murphy_interact:AddInteraction({
        coords      = loc.coords,
        id          = id,
        distance    = 8.0,
        interactDst = 2.5,
        title       = Translate[35],
        options     = {
            {
                label  = Translate[36],
                action = function()
                    TriggerServerEvent("murphy_camp:ClaimLostObjects")
                end,
            },
        },
    })
end

CreateThread(function()
    Wait(1500)
    if not Config.LostObjects or not Config.LostObjects.enabled then return end
    for i, loc in ipairs(Config.LostObjects.locations or {}) do
        registerLocation(i, loc)
    end
end)

AddEventHandler('onResourceStop', function(resource)
    if resource ~= GetCurrentResourceName() then return end
    for _, ped in ipairs(spawnedPeds) do
        if DoesEntityExist(ped) then DeletePed(ped) end
    end
    for _, blip in ipairs(spawnedBlips) do
        RemoveBlip(blip)
    end
    for _, id in ipairs(interactionIds) do
        pcall(exports.murphy_interact.RemoveInteraction, exports.murphy_interact, id)
    end
end)
