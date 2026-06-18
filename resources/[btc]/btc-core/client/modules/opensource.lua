local targetsCreated = {}
function UseTarget(name, coords, key, label, options, distance)
    if targetsCreated[name] then return end

    if options.type == 'client' then
        local promptId = exports.ox_target:addSphereZone({
            coords = coords.xyz,
            radius = distance or Config.TargetRadius, -- O raio do círculo
            debug = false,
            options = {
                {
                    name = name,
                    icon = 'fa-solid fa-circle',
                    label = label,
                    onSelect = function()
                        local argumentos = options.args or {}
                        TriggerEvent(options.event, table.unpack(argumentos))
                    end
                }
            }
        })
        targetsCreated[name] = promptId
    elseif options.type == 'server' then
        local promptId = exports.ox_target:addSphereZone({
            coords = coords.xyz,
            radius = distance or Config.TargetRadius, -- O raio do círculo
            debug = false,
            options = {
                {
                    name = name,
                    icon = 'fa-solid fa-circle',
                    label = label,
                    onSelect = function()
                        local argumentos = options.args or {}
                        TriggerServerEvent(options.event, table.unpack(argumentos))
                    end
                }
            }
        })
        targetsCreated[name] = promptId
    end
end

function LocalEntity(entity, data)
    local showDistance = data.distance or Config.TargetRadius
    exports.ox_target:addLocalEntity(entity, {
        {
            name = data.name,
            icon = data.icon or 'fa-solid fa-circle',
            label = data.label,
            distance = showDistance,
            onSelect = function()
                if data.event then
                    if data.args then
                        local args = data.args or {}
                        TriggerEvent(data.event, table.unpack(args))
                    else
                        TriggerEvent(data.event)
                    end
                elseif data.serverEvent then
                    if data.args then
                        local args = data.args or {}
                        TriggerServerEvent(data.event, table.unpack(args))
                    else
                        TriggerServerEvent(data.event)
                    end
                end
            end
        },
    })
end

function RemoveNetEntity(entity, optionName)
    exports.ox_target:removeEntity(entity, optionName)
end

function RemoveLocalEntity(entity, optionName)
    exports.ox_target:removeLocalEntity(entity, optionName)
end

function RemoveModelTarget(model, optionName)
    exports.ox_target:removeModel(model, optionName)
end

function NetEntity(netId, data)
    local showDistance = data.distance or Config.TargetRadius
    exports.ox_target:addEntity(netId, {
        {
            name = data.name,
            icon = data.icon or 'fa-solid fa-circle',
            label = data.label,
            distance = showDistance,
            onSelect = function()
                if data.event then
                    if data.args then
                        local args = data.args or {}
                        TriggerEvent(data.event, table.unpack(args))
                    else
                        TriggerEvent(data.event)
                    end
                elseif data.serverEvent then
                    if data.args then
                        local args = data.args or {}
                        TriggerServerEvent(data.event, table.unpack(args))
                    else
                        TriggerServerEvent(data.event)
                    end
                end
            end
        },
    })
end

function ModelTarget(model, data)
    local showDistance = data.distance or Config.TargetRadius
    exports.ox_target:addModel(model, {
        {
            name = data.name,
            icon = data.icon or 'fa-solid fa-circle',
            label = data.label,
            distance = showDistance,
            onSelect = function()
                if data.event then
                    if data.args then
                        local args = data.args or {}
                        TriggerEvent(data.event, table.unpack(args))
                    else
                        TriggerEvent(data.event)
                    end
                elseif data.serverEvent then
                    if data.args then
                        local args = data.args or {}
                        TriggerServerEvent(data.event, table.unpack(args))
                    else
                        TriggerServerEvent(data.event)
                    end
                end
            end

        }
    })
end

function RemoveTarget(name)
    if targetsCreated[name] then
        local targetId = targetsCreated[name]
        exports.ox_target:removeZone(targetId)
        targetsCreated[name] = nil
    end
end
