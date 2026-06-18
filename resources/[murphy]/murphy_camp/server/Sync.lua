-- Callback.register('murphy_camp:IsStableEmpty', function(source, id)
--     print("murphy_camp:IsStableEmpty called with source: " .. tostring(source) .. " and id: " .. tostring(id))
--     if Config.murphy_stable ~= true then
--         print("Stable check is disabled in the configuration.")
--         return true
--     end
--     local result = nil
--     print("Checking if stable is empty for camp ID: " .. id)
--     MySQL.query('SELECT COUNT(*) as count FROM stable WHERE stable = @campid', { campid = id }, function(row)
--         print("Stable count for camp ID " .. id .. ": " .. row[1].count)
--         if tonumber(row[1].count) > 0 then
--             result = false
--         else
--             result = true
--         end
--     end)
--     repeat
--         Wait(100)
--     until result ~= nil
--     print ("Stable empty check result for camp ID " .. id .. ": " .. tostring(result))
--     return result
-- end)




-- RegisterServerEvent("murphy_camp:askcamps", function(refresh)
--     local _source = source
--     local table = {}
--     local charid = GetCharIdentifier(_source)
--     while charid == nil do
--         Wait(2000)
--         charid = GetCharIdentifier(_source)
--     end
--     MySQL.query('SELECT * FROM `murphy_camp`;', {}, function(result)
--         if #result ~= 0 then
--             for i = 1, #result do
--                 table[json.decode(result[i].id)] = {
--                     charid = result[i].charid,
--                     campfire = json.decode(result[i].campfire),
--                     guests = json.decode(result[i].guests),
--                     props = json.decode(result[i].props),
--                     fuel = result[i].fuel
--                 }
--             end
--             if refresh then
--                 TriggerClientEvent("murphy_camp:getrefreshcamps", _source, table, GetCharIdentifier(_source))
--             else
--                 TriggerClientEvent("murphy_camp:getcamps", _source, table, GetCharIdentifier(_source))
--             end
--         end
--     end)
-- end)

if Config.CampDecay then
    if Config.OneFuelperDay then
        -- Fonction qui calcule le délai jusqu'à minuit prochain
        function attendreProchainMinuit()
            local now = os.date("*t")
            -- Calculer le timestamp du prochain minuit
            local nextMidnight = os.time({
                year = now.year,
                month = now.month,
                day = now.day + 1,
                hour = 0,
                min = 0,
                sec = 0
            })
            local secondsUntilMidnight = nextMidnight - os.time()
            print("Prochain retrait de fuel à minuit dans " .. secondsUntilMidnight .. " secondes.")
            SetTimeout(secondsUntilMidnight * 1000, function()
                for k, v in pairs(Camps) do
                    if v.fuel == nil then
                        v.fuel = 0
                    end
                    v.fuel = tonumber(v.fuel) - 1
                    local campfirecoords = vector3(v.campfire.coords.x, v.campfire.coords.y, v.campfire.coords.z)
                    if v.fuel < 0 then
                        if LostObjects and LostObjects.OnCampDepop then
                            LostObjects.OnCampDepop(k, v)
                        end
                        MySQL.update('DELETE FROM murphy_camp WHERE id = ?', { k })
                        Camps[k] = nil
                    end
                    local players = GetPlayers()
                    for _, id in pairs(players) do
                        local playercoords = GetEntityCoords(GetPlayerPed(id))
                        if #(playercoords - campfirecoords) < Config.DisplayDistance * 1.3 then
                            Callback.triggerClient("murphy_camp:UpdateCamp", id, function() end, k, v)
                        end
                    end
                end
                attendreProchainMinuit() -- Relance pour le prochain minuit
            end)
        end

        attendreProchainMinuit()
    else
        -- --- boucle qui enleve 1 de bois toutes les heures
        -- --- -- Exemple de fonction à exécuter chaque heure pile
        -- function maFonctionHoraire()
        --     print("La fonction a été exécutée à " .. os.date("%X"))
        --     -- Ajoutez ici la logique à exécuter à chaque heure pile
        -- end

        -- Fonction qui calcule le délai jusqu'à la prochaine heure pile
        function attendreProchaineHeurePile()
            local currentTime = os.date("*t") -- Obtenir l'heure actuelle
            local currentMinute = currentTime.min
            local currentSecond = currentTime.sec

            -- Calculer le nombre de secondes restant jusqu'à la prochaine heure pile
            local secondsUntilNextHour = (60 - currentMinute) * 60 - currentSecond

            -- Planifier l'exécution de la fonction à l'heure pile suivante
            SetTimeout(secondsUntilNextHour * 1000, function()
                for k, v in pairs(Camps) do
                    if v.fuel == nil then
                        v.fuel = 0
                    end
                    v.fuel = tonumber(v.fuel) - 1
                    local campfirecoords = vector3(v.campfire.coords.x, v.campfire.coords.y, v.campfire.coords.z)
                    if v.fuel < 0 then
                        if LostObjects and LostObjects.OnCampDepop then
                            LostObjects.OnCampDepop(k, v)
                        end
                        MySQL.update('DELETE FROM murphy_camp WHERE id = ?', { k })
                        Camps[k] = nil
                    end
                    local players = GetPlayers()
                    for _, id in pairs(players) do
                        local playercoords = GetEntityCoords(GetPlayerPed(id))
                        if #(playercoords - campfirecoords) < Config.DisplayDistance * 1.3 then
                            Callback.triggerClient("murphy_camp:UpdateCamp", id, function() end, k, v)
                        end
                    end
                end


                -- MySQL.query('SELECT * FROM `murphy_camp`;', {}, function(result)
                --     if #result ~= 0 then
                --         for i = 1, #result do
                --             if result[i].fuel < 1 then
                --                 MySQL.update('DELETE FROM murphy_camp WHERE `id`=@id', { id = json.decode(result[i].id) })
                --             else
                --                 MySQL.update("UPDATE murphy_camp SET `fuel`=@fuel WHERE `id`=@id",
                --                     {
                --                         fuel = result[i].fuel - 1,
                --                         id = json.decode(result[i].id)
                --                     }, function(done)
                --                     end)
                --             end
                --         end
                --         print("Remove one fuel at " .. os.date("%X") .. " for " .. #result .. " camps")
                --         TriggerClientEvent("murphy_camp:refreshcamps", -1)
                --     end
                -- end)


                attendreProchaineHeurePile() -- Planifier l'exécution de la prochaine heure pile
            end)
        end

        -- Lancer le processus dès que le serveur démarre
        attendreProchaineHeurePile()
    end
end

RegisterServerEvent("murphy_camp:addfuel", function(campfireid, fuel)
    local src = source
    local item = Config.FuelItem
    local newfuel = 0
    local oldfuel = 0
    if fuel ~= nil and tonumber(fuel) > 0 then
        newfuel = tonumber(Camps[campfireid].fuel) + tonumber(fuel)
        if Config.MaxFuel < newfuel then
            TriggerClientEvent('murphy_camp:ShowAdvancedRightNotification', src, Translate[25],
            "itemtype_textures", "itemtype_camp", "COLOR_WHITE", 4000)
        else
            local enoughitem = RemoveItem(src, item, fuel, {})
            if enoughitem then
                Camps[campfireid].fuel = newfuel
                
                -- Immediately save the updated fuel value to database
                MySQL.update(
                    "UPDATE murphy_camp SET fuel = @fuel WHERE id = @id", {
                        ['@fuel'] = newfuel,
                        ['@id'] = campfireid
                    }, function(rowsChanged)
                        if rowsChanged > 0 then
                            print("^4[DB]^0 Updated fuel for camp ID: " .. campfireid .. " to " .. newfuel)
                        else
                            print("^1[DB]^0 Error updating fuel for camp ID: " .. campfireid)
                        end
                    end)
                
                local players          = GetPlayers()
                for k, v in pairs(players) do
                    local playercoords = GetEntityCoords(GetPlayerPed(v))
                    local campfirecoords = vector3(Camps[campfireid].campfire.coords.x,
                        Camps[campfireid].campfire.coords.y, Camps[campfireid].campfire.coords.z)
                    if #(playercoords - campfirecoords) < Config.DisplayDistance * 1.3 then
                        Callback.triggerClient("murphy_camp:UpdateCamp", v, function() end, campfireid, Camps
                            [campfireid])
                    end
                end
            else
                TriggerClientEvent('murphy_camp:ShowAdvancedRightNotification', src, Translate[27],
                    "itemtype_textures", "itemtype_camp", "COLOR_WHITE", 4000)
            end
        end
    end
end)

RegisterServerEvent("murphy_camp:resetguests", function(campfireid)
    local src                = source
    Camps[campfireid].guests = {}
    
    -- Immediately save the updated guests to database
    MySQL.update(
        "UPDATE murphy_camp SET guests = @guests WHERE id = @id", {
            ['@guests'] = json.encode({}),
            ['@id'] = campfireid
        }, function(rowsChanged)
            if rowsChanged > 0 then
                print("^4[DB]^0 Reset guests for camp ID: " .. campfireid)
            else
                print("^1[DB]^0 Error resetting guests for camp ID: " .. campfireid)
            end
        end)
    
    local players            = GetPlayers()
    for k, v in pairs(players) do
        local playercoords = GetEntityCoords(GetPlayerPed(v))
        local campfirecoords = vector3(Camps[campfireid].campfire.coords.x, Camps[campfireid].campfire.coords.y,
            Camps[campfireid].campfire.coords.z)
        if #(playercoords - campfirecoords) < Config.DisplayDistance * 1.3 then
            Callback.triggerClient("murphy_camp:UpdateCamp", v, function() end, campfireid, Camps[campfireid])
        end
    end
    TriggerClientEvent('murphy_camp:ShowAdvancedRightNotification', src, Translate[28], "itemtype_textures",
        "itemtype_camp", "COLOR_WHITE", 4000)
end)


RegisterServerEvent("murphy_camp:inviteguests", function(campfireid, guest)
    local src = source
    local guests = Camps[campfireid].guests or {}
    local guestCharId = GetCharIdentifier(guest)
    local attempts = 0
    while guestCharId == nil and attempts < 5 do
        Wait(200)
        guestCharId = GetCharIdentifier(guest)
        attempts = attempts + 1
    end
    if guestCharId == nil then
        return
    end
    table.insert(guests, guestCharId)
    Camps[campfireid].guests = guests
    
    -- Immediately save the updated guests to database
    MySQL.update(
        "UPDATE murphy_camp SET guests = @guests WHERE id = @id", {
            ['@guests'] = json.encode(guests),
            ['@id'] = campfireid
        }, function(rowsChanged)
            if rowsChanged > 0 then
                print("^4[DB]^0 Added guest to camp ID: " .. campfireid)
            else
                print("^1[DB]^0 Error adding guest to camp ID: " .. campfireid)
            end
        end)
    
    local players = GetPlayers()
    for k, v in pairs(players) do
        local playercoords = GetEntityCoords(GetPlayerPed(v))
        local campfirecoords = vector3(Camps[campfireid].campfire.coords.x, Camps[campfireid].campfire.coords.y,
            Camps[campfireid].campfire.coords.z)
        if #(playercoords - campfirecoords) < Config.DisplayDistance * 1.3 then
            Callback.triggerClient("murphy_camp:UpdateCamp", v, function() end, campfireid, Camps[campfireid])
        end
    end
    TriggerClientEvent('murphy_camp:ShowAdvancedRightNotification', src, Translate[29], "itemtype_textures",
        "itemtype_camp", "COLOR_WHITE", 4000)
    TriggerClientEvent('murphy_camp:ShowAdvancedRightNotification', guest, Translate[30], "itemtype_textures",
        "itemtype_camp", "COLOR_WHITE", 4000)
end)

RegisterServerEvent("murphy_camp:removeguests", function(campfireid, guest)
    local src = source
    local guests = Camps[campfireid].guests or {}
    for k, v in pairs(guests) do
        if v == GetCharIdentifier(guest) then
            table.remove(guests, k)
            break
        end
    end
    Camps[campfireid].guests = guests
    
    -- Immediately save the updated guests to database
    MySQL.update(
        "UPDATE murphy_camp SET guests = @guests WHERE id = @id", {
            ['@guests'] = json.encode(guests),
            ['@id'] = campfireid
        }, function(rowsChanged)
            if rowsChanged > 0 then
                print("^4[DB]^0 Removed guest from camp ID: " .. campfireid)
            else
                print("^1[DB]^0 Error removing guest from camp ID: " .. campfireid)
            end
        end)
    
    local players = GetPlayers()
    for k, v in pairs(players) do
        local playercoords = GetEntityCoords(GetPlayerPed(v))
        local campfirecoords = vector3(Camps[campfireid].campfire.coords.x, Camps[campfireid].campfire.coords.y,
            Camps[campfireid].campfire.coords.z)
        if #(playercoords - campfirecoords) < Config.DisplayDistance * 1.3 then
            Callback.triggerClient("murphy_camp:UpdateCamp", v, function() end, campfireid, Camps[campfireid])
        end
    end
    TriggerClientEvent('murphy_camp:ShowAdvancedRightNotification', src, Translate[29], "itemtype_textures",
        "itemtype_camp", "COLOR_WHITE", 4000)
    TriggerClientEvent('murphy_camp:ShowAdvancedRightNotification', guest, Translate[30], "itemtype_textures",
        "itemtype_camp", "COLOR_WHITE", 4000)
end)

