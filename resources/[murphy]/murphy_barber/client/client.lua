Citizen.CreateThread(function()
    Wait(1000)
    baseoverlay = deepcopy(overlay_all_layers)
end)

local props = {}
local blips = {}

local promptkey = 0x760A9C6F
local PromptGroup = GetRandomIntInRange(0, 0xffffff)
local str = Lang.Prompt.open
local prompttext = Lang.Prompt.title
Citizen.CreateThread(function()
    Citizen.Wait(0)
    if Config.NativePrompt == true then

        barberprompt = PromptRegisterBegin()
        PromptSetControlAction(barberprompt, promptkey)
        str = CreateVarString(10, 'LITERAL_STRING', str)
        PromptSetText(barberprompt, str)
        PromptSetEnabled(barberprompt, true)
        PromptSetVisible(barberprompt, true)
        PromptSetHoldMode(barberprompt, true)
        PromptSetGroup(barberprompt, PromptGroup)
        PromptRegisterEnd(barberprompt)
    end
    for k, v in pairs(Config.Shops) do
        local blip = Citizen.InvokeNative(0x554D9D53F696D002, 1664425300, v.coords)
        blips[#blips + 1] = blip
        SetBlipSprite(blip, -2090472724)
        SetBlipScale(blip, 0.2)
        Citizen.InvokeNative(0x9CB1A1623062F402, blip, string.format(k))
        if Config.NativePrompt == false then
            exports.murphy_interact:AddInteraction({
                coords = vector3(v.coords.x, v.coords.y, v.coords.z + 1.0),
                distance = 8.0,    -- optional
                interactDst = 4.0, -- optional
                id = k,            -- needed for removing interactions
                options = {
                    {
                        label = Lang.Prompt.interact,
                        action = function(entity, coords, args)
                            OpenPresetMenu(true)
                        end,
                    },
                }
            })
        end
        if v.props then
            RequestModel(GetHashKey(v.props.model))
            while not HasModelLoaded(GetHashKey(v.props.model)) do
                Wait(1)
            end
            local prop = CreateObject(GetHashKey(v.props.model), v.coords, false, true, false)
            PlaceEntityOnGroundProperly(prop)
            FreezeEntityPosition(prop, true)
            props[#props + 1] = prop
            SetEntityRotation(prop, v.props.rotation[1], v.props.rotation[2], v.props.rotation[3], 0, true)
        end
    end
end)

if Config.NativePrompt == true then
    Citizen.CreateThread(function()
        while true do
            Citizen.Wait(0)
            for k, v in pairs(Config.Shops) do
                if #(GetEntityCoords(PlayerPedId()) - v.coords) < 2.0 and not CreatorLight then
                    local label  = CreateVarString(10, 'LITERAL_STRING', prompttext)
                    PromptSetActiveGroupThisFrame(PromptGroup, label)
                    if IsControlJustPressed(0, promptkey) then
                        OpenPresetMenu(true)
                    end
                end
            end

        end
    end)
end

AddEventHandler("onResourceStop", function(resource)
    if resource == GetCurrentResourceName() then
        for k, v in pairs(props) do
            DeleteObject(v)
        end
        for k, v in pairs(blips) do
            RemoveBlip(v)
        end
    end
end)
