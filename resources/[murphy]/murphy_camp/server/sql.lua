Camps = {}

Citizen.CreateThread(function()
    MySQL.query('SELECT * FROM murphy_camp', {}, function(result)
        for _, row in ipairs(result) do
            local data = {
                charid = row.charid,
                guests = json.decode(row.guests),
                campfire = json.decode(row.campfire),
                props = json.decode(row.props),
                fuel = row.fuel
            }
            print ("^4[DB]^0 Loaded camp with ID: " .. row.id .. " for charid: " .. data.charid)
            Camps[row.id] = data
        end
    end)
end)

Citizen.CreateThread(function()
    while true do
        Wait(15 * 60 * 1000) -- Save every 15 minutes
        SaveCamps()
    end
end)

AddEventHandler("txAdmin:events:serverShuttingDown", function(eventData)
    CreateThread(function()
        print("^4[DB]^0 5 seconds before restart... saving all Camps!")
        SaveCamps()
    end)
end)

AddEventHandler('txAdmin:events:scheduledRestart', function(eventData)
    if eventData.secondsRemaining == 60 then
        CreateThread(function()
            print("^4[DB]^0 60 seconds before restart... saving all Camps!")
            SaveCamps()
        end)
    end
end)

RegisterCommand("savecamp", function(source, args, raw)
    if GetCharGroup(source) == "superadmin" then
        CreateThread(function()
            print("^4[DB]^0 Saving all Camps by admin command!")
            SaveCamps()
        end)
    end
end)

AddEventHandler("onResourceStop", function(resourceName)
    if resourceName == GetCurrentResourceName() then
        SaveCamps()
    end
end)

function SaveCamps()
    local campsaved = 0
    local campsdeleted = 0
    for id, data in pairs(Camps) do
        if data.fuel > 0 then
            MySQL.update(
            "UPDATE murphy_camp SET campfire = @campfire, guests = @guests, props = @props, fuel = @fuel WHERE id = @id", {
                ['@campfire'] = json.encode(data.campfire),
                ['@guests']   = json.encode(data.guests),
                ['@props']    = json.encode(data.props),
                ['@fuel']     = data.fuel,
                ['@id']       = id
            }, function(rowsChanged)
                if rowsChanged > 0 then
                    campsaved = campsaved + 1
                else
                    print("^1[DB]^0 Error saving camp with id: " .. tostring(id))
                end
            end)
        elseif data.fuel == 0 then
            MySQL.update(
            "DELETE FROM murphy_camp WHERE id = @id", {
                ['@id'] = id
            }, function(rowsChanged)
                if rowsChanged > 0 then
                    Camps[id] = nil
                    campsdeleted = campsdeleted + 1
                else
                    print("^1[DB]^0 Error deleting camp with id: " .. tostring(id))
                end
            end)
        end
    end
    Citizen.Wait(1000)
    print("^4[DB]^0 Saved ^3" .. campsaved .. "^0 Camps.")
    print("^4[DB]^0 Deleted ^3" .. campsdeleted .. "^0 Camps with no fuel.")
end
