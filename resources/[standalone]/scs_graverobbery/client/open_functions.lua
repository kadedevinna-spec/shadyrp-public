local RSGCore = exports['rsg-core']:GetCoreObject()
local config = require 'shared.config'

local createdPrompts = {}

---@param message string
---@param type string
function ShowNotify(message, type)
    if config.notify == "ox" then
        lib.notify({
            title = "Grave Robbery",
            description = message,
            type = type,
            duration = 5000,
        })
    elseif config.notify == "rsg" then
        RSGCore.Functions.Notify(message, type)
    end
end

-- server side notify
---@param message string
---@param type string
RegisterNetEvent('scs_graverobbery:notify', function(message, type)
    ShowNotify(message, type)
end)

---@param coords vector3|nil
---@param data table
function CreateTargetZone(coords, data)
    if config.interact == "ox_target" then
        exports.ox_target:addSphereZone({
            coords = coords,
            radius = data.radius or 0.5,
            options = data.options or data,
            debug = config.debug or false,
        })
        
        if config.debug then
            print("^2[DEBUG] Created ox_target zone at: " .. coords.x .. ", " .. coords.y .. ", " .. coords.z .. "^7")
        end
    elseif config.interact == "rsg" then
        if config.debug then
            print("^2[DEBUG] RSG prompts initialized on resource start^7")
        end
    end
end

-- remove target model
---@param model string|number
---@param data table
function RemoveTargetModel(model, data)
    if config.interact == "ox_target" then
        exports.ox_target:removeModel(model, data)
    elseif config.interact == "rsg" then
        if model then
            exports['rsg-core']:deletePrompt(createdPrompts[data.id])
        end
    elseif config.interact == "custom" then
        -- custom target model
    end
end

-- Display a progress bar
--- @param data table
function ProgressBar(data)
    if config.progressbar == "ox_lib" then
        if lib.progressBar({
            label = data.label,
            duration = data.duration,
            position = data.position or 'bottom',
            useWhileDead = data.useWhileDead,
            canCancel = data.canCancel,
            disable = data.disable,
            anim = {
                dict = data.anim and data.anim.dict or config.Animation.dict,
                clip = data.anim and data.anim.clip or config.Animation.anim,
                flag = data.anim and data.anim.flag or config.Animation.flag
            },
            prop = {
                model = data.prop and data.prop.model or nil,
                bone = data.prop and data.prop.bone or nil,
                pos = data.prop and data.prop.position or nil,
                rot = data.prop and data.prop.rotation or nil
            }
        }) then
            return true
        end
        return false
    elseif config.progressbar == "custom" then
        -- Add custom progress bar here
        return true
    end
    return false
end



function AbleToOpenThePropertiesMenu()
    local able = true

    if Config.BrutalPoliceJob and GetResourceState("brutal_policejob") == "started" then
        if exports.brutal_policejob:IsHandcuffed() then
            able = false
        end
    end

    if Config['Core']:upper() == 'QBCORE' then
        if GetResourceState("p_policejob") == "started" then
            if LocalPlayer.state.isCuffed then
                able = false
            end
        end
    end

    -- other blacklists can be added.

    return able
end