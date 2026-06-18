Callback.register('murphy_camp:GetAllCamps', function(source)
    local _source = source
    local charid = GetCharIdentifier(_source) or 0
    local data = {}
    for k, v in pairs(Camps) do
        data[k] = vector3(v.campfire.coords.x, v.campfire.coords.y, v.campfire.coords.z)
    end
    return data, charid
end)

--- Batched variant: returns coords + ownership metadata for every camp in a
--- single round-trip, so the client blip-refresh loop doesn't have to fire
--- one extra GetCampComponents per camp every tick. Drops network/CPU load
--- by ~Nx on busy servers (where N = total camp count).
Callback.register('murphy_camp:GetAllCampsLite', function(source)
    local charid = GetCharIdentifier(source) or 0
    local data = {}
    for k, v in pairs(Camps) do
        data[k] = {
            coords = vector3(v.campfire.coords.x, v.campfire.coords.y, v.campfire.coords.z),
            charid = v.charid,
            guests = v.guests,
        }
    end
    return data, charid
end)


Callback.register('murphy_camp:GetCampComponents', function(source, campid, coords)
    local _source = source
    local data = nil
    return Camps[campid]
    -- MySQL.query('SELECT * FROM `murphy_camp` WHERE `id`=@id ;', { id = campid }, function(result)
    --     print ("Fetching camp data for camp ID: " .. campid, json.encode(result))
    --     if result[1] then
    --         print ("Camp data for camp ID " .. campid .. " received.")
    --         data = {
    --             charid = result[1].charid,
    --             guests = json.decode(result[1].guests),
    --             campfire = json.decode(result[1].campfire),
    --             props = json.decode(result[1].props),
    --             fuel = result[1].fuel
    --         }
    --     else
    --         data = {}
    --     end
    -- end)
    -- repeat
    --     Wait(100)
    -- until data ~= nil
    -- return data
end)

Callback.register('murphy_camp:GetCampPermissions', function(source, campid, coords)
    local _source = source
    local access = nil
    local charid = GetCharIdentifier(_source)
    MySQL.query('SELECT * FROM `murphy_camp` WHERE `id`=@id ;', { id = campid }, function(result)
        if result[1] then
            access = false
            local owner = result[1].charid
            local guests = json.decode(result[1].guests)
            if owner == charid then
                access = true
            else
                for k, v in pairs(guests) do
                    if charid == v then
                        access = true
                    end
                end
            end
        else
            access = false
        end
    end)
    repeat
        Wait(100)
    until access ~= nil
    return access
end)
