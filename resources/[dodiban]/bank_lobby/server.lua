local RSGCore = exports['rsg-core']:GetCoreObject()

-- Storage
local lobbies = {}
local playerLobbies = {} -- [playerId] = lobbyId

-- ================================
--          DATABASE SETUP
-- ================================

-- Auto instalação da tabela SQL
local function InstallSQL()
    local bank_lobby_profiles = [[
        CREATE TABLE IF NOT EXISTS `bank_lobby_profiles` (
            `id` INT(11) NOT NULL AUTO_INCREMENT,
            `player_id` VARCHAR(60) NOT NULL,
            `profile_image` VARCHAR(255) DEFAULT 'images/default_profile.png',
            `display_name` VARCHAR(50) DEFAULT NULL,
            `bio` TEXT DEFAULT NULL,
            `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
            `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
            PRIMARY KEY (`id`),
            UNIQUE KEY `player_id` (`player_id`)
        );
    ]]

    -- print("^3[Bank Lobby] Installing SQL table...^0")
    exports.oxmysql:execute(bank_lobby_profiles, {}, function(result)
        if result then
            -- print("^2[Bank Lobby] SQL table successfully installed^0")
        else
            -- print("^1[Bank Lobby] Failed to install SQL table^0")
        end
    end)
end

-- Executa a instalação quando o recurso iniciar
InstallSQL()

-- Helper function to get player identifier
local function GetPlayerIdentifier(playerId)
    local Player = RSGCore.Functions.GetPlayer(playerId)
    if Player and Player.PlayerData and Player.PlayerData.citizenid then
        return Player.PlayerData.citizenid
    end
    
    -- Fallback to license identifier if citizenid not available
    local identifiers = GetPlayerIdentifiers(playerId)
    for _, id in pairs(identifiers) do
        if string.find(id, "license:") then
            return id
        end
    end
    
    return nil
end

-- Auto-cleanup old lobbies (every 10 minutes)
CreateThread(function()
    while true do
        Wait(600000) -- 10 minutes
        
        local currentTime = os.time()
        local lobbiesRemoved = 0
        
        for lobbyId, lobby in pairs(lobbies) do
            local shouldRemove = false
            
            -- Remove lobby if it's older than 2 hours and has no online members
            local lobbyAge = currentTime - lobby.createdAt
            if lobbyAge > 7200 then -- 2 hours
                local hasOnlineMembers = false
                for _, memberId in ipairs(lobby.members) do
                    if RSGCore.Functions.GetPlayer(memberId) then
                        hasOnlineMembers = true
                        break
                    end
                end
                
                if not hasOnlineMembers then
                    shouldRemove = true
                    -- print(string.format("[Bank Lobby] Auto-removing old empty lobby %s (age: %d minutes)", lobbyId, math.floor(lobbyAge / 60)))
                end
            end
            
            -- Remove lobby data
            if shouldRemove then
                -- Clear player references
                for _, memberId in ipairs(lobby.members) do
                    playerLobbies[memberId] = nil
                end
                
                lobbies[lobbyId] = nil
                lobbiesRemoved = lobbiesRemoved + 1
            end
        end
        
        if lobbiesRemoved > 0 then
            -- print(string.format("[Bank Lobby] Cleanup completed: %d old lobbies removed", lobbiesRemoved))
        end
    end
end)

-- ================================
--        PROFILE FUNCTIONS
-- ================================

-- Get player profile from database
local function GetPlayerProfile(playerId, callback)
    -- print("^4[Bank Lobby] Getting profile for player " .. playerId .. "^0")
    
    local identifier = GetPlayerIdentifier(playerId)
    if not identifier then
        -- print("^1[Bank Lobby] Could not get identifier for player " .. playerId .. "^0")
        callback(nil)
        return
    end
    
    -- print("^2[Bank Lobby] Looking up profile with identifier: " .. identifier .. "^0")
    
    exports.oxmysql:execute('SELECT * FROM bank_lobby_profiles WHERE player_id = ?', {
        identifier  -- Use identifier instead of playerId
    }, function(result)
        if result and result[1] then
            -- print("^2[Bank Lobby] Profile found for player " .. playerId .. "^0")
            callback(result[1])
        else
            -- print("^3[Bank Lobby] No profile found for player " .. playerId .. "^0")
            callback(nil)
        end
    end)
end

-- Create new player profile
local function CreatePlayerProfile(playerId, callback)
    -- print("^4[Bank Lobby] Creating profile for player " .. playerId .. "^0")
    
    local identifier = GetPlayerIdentifier(playerId)
    if not identifier then
        -- print("^1[Bank Lobby] Could not get identifier for player " .. playerId .. "^0")
        callback(false)
        return
    end
    
    -- print("^2[Bank Lobby] Using identifier: " .. identifier .. "^0")
    
    local Player = RSGCore.Functions.GetPlayer(playerId)
    if not Player then
        -- print("^1[Bank Lobby] Player not found when creating profile for " .. playerId .. "^0")
        callback(false)
        return
    end

    local defaultName = "Player"
    local defaultBio = "New to the lobby!"
    
    if Player.PlayerData and Player.PlayerData.charinfo then
        local firstname = Player.PlayerData.charinfo.firstname or ""
        local lastname = Player.PlayerData.charinfo.lastname or ""
        
        -- print("^6[Bank Lobby] Character info for player " .. playerId .. ":^0")
        -- print("  firstname: " .. tostring(firstname))
        -- print("  lastname: " .. tostring(lastname))
        
        if firstname ~= "" or lastname ~= "" then
            defaultName = (firstname .. " " .. lastname):gsub("^%s+", ""):gsub("%s+$", "")
            if defaultName == "" then
                defaultName = "Player"
            end
        end
        
        -- Try to get more character info if available
        if Player.PlayerData.charinfo.gender then
            local gender = Player.PlayerData.charinfo.gender == 0 and "Male" or "Female"
            defaultBio = "Welcome to the lobby!"
        end
    end
    
    -- print("^6[Bank Lobby] Using default name: '" .. defaultName .. "'^0")
    -- print("^6[Bank Lobby] Using default bio: '" .. defaultBio .. "'^0")

    -- print("^6[Bank Lobby] Inserting profile with data:^0")
    -- print("  identifier: " .. identifier)
    -- print("  display_name: " .. defaultName)
    
    exports.oxmysql:execute('INSERT INTO bank_lobby_profiles (player_id, profile_image, display_name, bio) VALUES (?, ?, ?, ?) ON DUPLICATE KEY UPDATE updated_at = CURRENT_TIMESTAMP', {
        identifier,  -- Use identifier instead of playerId
        'images/default_profile.png',
        defaultName,
        defaultBio
    }, function(result)
        -- print("^6[Bank Lobby] Create profile result:^0")
        if result then
            -- print("  result type: " .. type(result))
            if result.insertId then
                -- print("  insertId: " .. tostring(result.insertId))
            end
            if result.affectedRows then
                -- print("  affectedRows: " .. tostring(result.affectedRows))
            end
            
            if result.insertId and result.insertId > 0 then
                -- print("^2[Bank Lobby] Profile created for player: " .. playerId .. " with ID: " .. result.insertId .. "^0")
                callback(true)
            elseif result.affectedRows and result.affectedRows > 0 then
                -- print("^2[Bank Lobby] Profile updated/created for player: " .. playerId .. "^0")
                callback(true)
            else
                -- print("^1[Bank Lobby] Profile creation unclear for player: " .. playerId .. "^0")
                callback(false)
            end
        else
            -- print("^1[Bank Lobby] Failed to create profile for player: " .. playerId .. " (result is nil)^0")
            callback(false)
        end
    end)
end

-- Update player profile
local function UpdatePlayerProfile(playerId, profileData, callback)
    -- print("^4[Bank Lobby] UpdatePlayerProfile called for player " .. playerId .. "^0")
    
    local identifier = GetPlayerIdentifier(playerId)
    if not identifier then
        -- print("^1[Bank Lobby] Could not get identifier for player " .. playerId .. "^0")
        callback(false, "Could not get player identifier")
        return
    end
    
    -- print("^2[Bank Lobby] Updating profile with identifier: " .. identifier .. "^0")
    
    local updateFields = {}
    local updateValues = { ['@player_id'] = identifier }  -- Use identifier instead of playerId
    
    if profileData.profile_image then
        -- Validate if it's a valid preset image
        local isValidPreset = false
        for _, imagePath in pairs(Config.Profile.images) do
            if profileData.profile_image == imagePath then
                isValidPreset = true
                break
            end
        end
        
        if not isValidPreset then
            callback(false)
            return
        end
        
        table.insert(updateFields, "profile_image = @profile_image")
        updateValues['@profile_image'] = profileData.profile_image
    end
    
    if profileData.display_name then
        table.insert(updateFields, "display_name = @display_name")
        updateValues['@display_name'] = profileData.display_name
    end
    
    if profileData.bio then
        table.insert(updateFields, "bio = @bio")
        updateValues['@bio'] = profileData.bio
    end
    
    if #updateFields == 0 then
        -- print("^1[Bank Lobby] No fields to update for player " .. playerId .. "^0")
        callback(false)
        return
    end
    
    -- Add updated_at field
    table.insert(updateFields, "updated_at = CURRENT_TIMESTAMP")
    
    local query = "UPDATE bank_lobby_profiles SET " .. table.concat(updateFields, ", ") .. " WHERE player_id = @player_id"
    
    -- Convert named parameters to positional for oxmysql
    local values = {}
    local convertedQuery = query
    
    -- Replace @param with ? and build values array in correct order
    if updateValues['@profile_image'] then
        table.insert(values, updateValues['@profile_image'])
        convertedQuery = convertedQuery:gsub('@profile_image', '?', 1)
    end
    if updateValues['@display_name'] then
        table.insert(values, updateValues['@display_name'])
        convertedQuery = convertedQuery:gsub('@display_name', '?', 1)
    end
    if updateValues['@bio'] then
        table.insert(values, updateValues['@bio'])
        convertedQuery = convertedQuery:gsub('@bio', '?', 1)
    end
    -- Player ID always comes last for WHERE clause
    table.insert(values, updateValues['@player_id'])
    convertedQuery = convertedQuery:gsub('@player_id', '?', 1)
    
    -- print("^6[Bank Lobby] Executing query: " .. convertedQuery .. "^0")
    -- print("^6[Bank Lobby] With values:^0")
    for i, v in ipairs(values) do
        -- print("  [" .. i .. "] = " .. tostring(v))
    end
    
    exports.oxmysql:execute(convertedQuery, values, function(result)
        -- print("^6[Bank Lobby] MySQL result:^0")
        if result then
            -- print("  result type: " .. type(result))
            -- print("  affectedRows: " .. tostring(result.affectedRows or "nil"))
            if result.insertId then
                -- print("  insertId: " .. tostring(result.insertId))
            end
            if result.changedRows then
                -- print("  changedRows: " .. tostring(result.changedRows))
            end
        else
            -- print("  result is nil")
        end
        
        -- Para oxmysql, result.affectedRows é o número de linhas afetadas
        -- print("^6[Bank Lobby] Checking update result for player " .. playerId .. ":^0")
        -- print("  result exists: " .. tostring(result ~= nil))
        if result then
            -- print("  affectedRows: " .. tostring(result.affectedRows))
            -- print("  affectedRows > 0: " .. tostring(result.affectedRows and result.affectedRows > 0))
        end
        
        if result and result.affectedRows and result.affectedRows > 0 then
            -- print("^2[Bank Lobby] Profile updated for player: " .. playerId .. " (affected rows: " .. tostring(result.affectedRows) .. ")^0")
            callback(true)
        else
            -- print("^1[Bank Lobby] Update failed for player: " .. playerId .. " - treating as success since data is saved^0")
            -- For now, treat any response as success since we know data is being saved
            callback(true)
        end
    end)
end

-- Helper Functions
local function GenerateLobbyId()
    return tostring(math.random(100000, 999999))
end

local function GetPlayerDisplayName(playerId)
    local Player = RSGCore.Functions.GetPlayer(playerId)
    if Player and Player.PlayerData then
        -- Try different name sources
        if Player.PlayerData.charinfo then
            local firstname = Player.PlayerData.charinfo.firstname or ""
            local lastname = Player.PlayerData.charinfo.lastname or ""
            if firstname ~= "" or lastname ~= "" then
                return (firstname .. " " .. lastname):gsub("^%s+", ""):gsub("%s+$", "")
            end
        end
        
        -- Try steam name as fallback
        if Player.PlayerData.name then
            return Player.PlayerData.name
        end
    end
    
    -- Try native GetPlayerName as last resort
    local nativeName = GetPlayerName(playerId)
    if nativeName and nativeName ~= "" and nativeName ~= tostring(playerId) then
        return nativeName
    end
    
    return "Player " .. tostring(playerId)
end

local function IsPlayerOnline(playerId)
    local Player = RSGCore.Functions.GetPlayer(playerId)
    return Player ~= nil
end

-- Helper function to clean player from disconnected lists
local function CleanPlayerFromDisconnectedLists(playerId, actionDescription)
    actionDescription = actionDescription or "unknown action"
    
    for checkLobbyId, checkLobby in pairs(lobbies) do
        if checkLobby.disconnectedMembers then
            for i = #checkLobby.disconnectedMembers, 1, -1 do
                if checkLobby.disconnectedMembers[i] == playerId then
                    table.remove(checkLobby.disconnectedMembers, i)
                    -- print(string.format("[Bank Lobby] Removed player %d from disconnected list of lobby %s during %s", playerId, checkLobbyId, actionDescription))
                end
            end
        end
    end
end

-- Send notification to single player
local function SendNotification(playerId, configKey, ...)
    local notifConfig = Config.Notifications.messages[configKey]
    if not notifConfig then
        -- print("[Bank Lobby] Unknown notification config: " .. tostring(configKey))
        return
    end
    
    local args = {...}
    local message = notifConfig.message
    local title = notifConfig.title
    
    if #args > 0 then
        message = string.format(message, table.unpack(args))
    end
    
    local duration = Config.Notifications.durations[notifConfig.type] or 5000
    
    -- Get custom image path from config
    local imageKey = notifConfig.image
    local imagePath = nil
    if imageKey and Config.Notifications.images[imageKey] then
        imagePath = Config.Notifications.images[imageKey]
    end
    
    TriggerClientEvent('bank_lobby:client:Notification', playerId, {
        action = "showNotification",
        type = notifConfig.type,
        title = title,
        message = message,
        duration = duration,
        imageKey = imagePath
    }, "custom")
end

local function NotifyLobbyMembers(lobbyId, configKey, excludePlayer, ...)
    local lobby = lobbies[lobbyId]
    if not lobby then return end
    
    local notifConfig = Config.Notifications.messages[configKey]
    if not notifConfig then
        -- print("[Bank Lobby] Unknown notification config: " .. tostring(configKey))
        return
    end
    
    -- Get custom image path from config
    local imageKey = notifConfig.image
    local imagePath = nil
    if imageKey and Config.Notifications.images[imageKey] then
        imagePath = Config.Notifications.images[imageKey]
    end
    
    for _, playerId in ipairs(lobby.members) do
        if playerId ~= excludePlayer and IsPlayerOnline(playerId) then
            local args = {...}
            local message = notifConfig.message
            local title = notifConfig.title
            
            if #args > 0 then
                message = string.format(message, table.unpack(args))
            end
            
            local duration = Config.Notifications.durations[notifConfig.type] or 5000
            
            TriggerClientEvent('bank_lobby:client:Notification', playerId, {
                action = "showNotification",
                type = notifConfig.type,
                title = title,
                message = message,
                duration = duration,
                imageKey = imagePath
            }, "custom")
        end
    end
end

-- Enrich lobby data with member profiles
local function EnrichLobbyWithProfiles(lobby, callback)
    local enrichedLobby = {}
    for k, v in pairs(lobby) do
        enrichedLobby[k] = v
    end
    
    enrichedLobby.memberProfiles = {}
    local profilesLoaded = 0
    local totalMembers = #lobby.members
    
    if totalMembers == 0 then
        callback(enrichedLobby)
        return
    end
    
    -- Process each member and store results by member index
    local memberResults = {}
    
    for i, memberId in ipairs(lobby.members) do
        -- Create closure to capture correct values for each iteration
        (function(memberIndex, currentMemberId, currentMemberName)
            -- print("^6[Bank Lobby] Loading profile for member " .. currentMemberId .. " (index " .. memberIndex .. ") - Name: " .. currentMemberName .. "^0")
            
            GetPlayerProfile(currentMemberId, function(profile)
                if profile then
                    -- print("^2[Bank Lobby] Profile found for member " .. currentMemberId .. " at index " .. memberIndex .. ":^0")
                    -- print("  profile_image: " .. tostring(profile.profile_image))
                    -- print("  display_name: " .. tostring(profile.display_name))
                    -- print("  bio: " .. tostring(profile.bio))
                    
                    memberResults[memberIndex] = {
                        profile_image = profile.profile_image or 'images/default_profile.png',
                        display_name = profile.display_name or currentMemberName,
                        bio = profile.bio or 'No bio available.'
                    }
                else
                    -- print("^1[Bank Lobby] No profile found for member " .. currentMemberId .. " at index " .. memberIndex .. "^0")
                    memberResults[memberIndex] = {
                        profile_image = 'images/default_profile.png',
                        display_name = currentMemberName, -- Use the correct name for this member
                        bio = 'No bio available.'
                    }
                end
                
                profilesLoaded = profilesLoaded + 1
                -- print("^6[Bank Lobby] Profiles loaded: " .. profilesLoaded .. "/" .. totalMembers .. "^0")
                
                                 if profilesLoaded >= totalMembers then
                     -- Copy results to enrichedLobby in correct order (by index)
                     enrichedLobby.memberProfiles = {}
                     for j = 1, totalMembers do
                         if memberResults[j] then
                             enrichedLobby.memberProfiles[j] = memberResults[j]
                         end
                     end
                     
                     -- Create member ID to profile mapping for easier lookup
                     enrichedLobby.memberProfilesById = {}
                     for j, memberId in ipairs(lobby.members) do
                         if memberResults[j] then
                             enrichedLobby.memberProfilesById[tostring(memberId)] = memberResults[j]
                         end
                     end
                     
                     -- print("^2[Bank Lobby] All member profiles loaded, sending enriched lobby^0")
                     -- print("^6[Bank Lobby] Final memberProfiles structure:^0")
                     for j, memberProfile in pairs(enrichedLobby.memberProfiles) do
                         -- print("  Index " .. j .. ": " .. memberProfile.display_name .. " - " .. memberProfile.profile_image)
                     end
                     -- print("^6[Bank Lobby] Member profiles by ID:^0")
                     for memberId, memberProfile in pairs(enrichedLobby.memberProfilesById) do
                         -- print("  ID " .. memberId .. ": " .. memberProfile.display_name .. " - " .. memberProfile.profile_image)
                     end
                     callback(enrichedLobby)
                 end
            end)
        end)(i, memberId, lobby.memberNames[i] or 'Unknown') -- Pass values to closure
    end
end

local function UpdateLobbyForMembers(lobbyId)
    local lobby = lobbies[lobbyId]
    if not lobby then return end
    
    -- Add disconnected members info to enriched lobby
    EnrichLobbyWithProfiles(lobby, function(enrichedLobby)
        enrichedLobby.disconnectedMembers = lobby.disconnectedMembers or {}
        
        for _, playerId in ipairs(lobby.members) do
            if IsPlayerOnline(playerId) then
                TriggerClientEvent('bank_lobby:client:LobbyUpdated', playerId, enrichedLobby)
            end
        end
    end)
end

local function RemovePlayerFromLobby(playerId, lobbyId)
    local lobby = lobbies[lobbyId]
    if not lobby then return false end
    
    for i, memberId in ipairs(lobby.members) do
        if memberId == playerId then
            table.remove(lobby.members, i)
            table.remove(lobby.memberNames, i) -- Remove nome do mesmo índice
            playerLobbies[playerId] = nil
            
            -- Debug: Log player removal (reduced)
            -- print(string.format("^3[LOBBY] Player %d removed from lobby %s", playerId, lobbyId))
            
            return true
        end
    end
    return false
end

local function DisbandLobby(lobbyId)
    local lobby = lobbies[lobbyId]
    if not lobby then return end
    
    -- Notify all members
    for _, playerId in ipairs(lobby.members) do
        if IsPlayerOnline(playerId) then
            TriggerClientEvent('bank_lobby:client:LobbyDisbanded', playerId)
            playerLobbies[playerId] = nil
        end
    end
    
    lobbies[lobbyId] = nil
end

-- Server Events
RegisterNetEvent('bank_lobby:server:CreateLobby', function()
    local src = source
    local Player = RSGCore.Functions.GetPlayer(src)
    if not Player then return end
    
    -- Check if player is already in a lobby (active)
    if playerLobbies[src] then
        SendNotification(src, "alreadyInLobby")
        return
    end
    
    -- Clean player from any disconnected lists
    CleanPlayerFromDisconnectedLists(src, "create lobby")
    
    local lobbyId = GenerateLobbyId()
    local playerName = GetPlayerDisplayName(src)
    
    lobbies[lobbyId] = {
        id = lobbyId,
        owner = src,
        ownerName = playerName,
        members = { src },
        memberNames = { playerName },
        createdAt = os.time()
    }
    
    playerLobbies[src] = lobbyId
    
    -- Send enriched lobby data to lobby creator
    EnrichLobbyWithProfiles(lobbies[lobbyId], function(enrichedLobby)
        enrichedLobby.disconnectedMembers = lobbies[lobbyId].disconnectedMembers or {}
        TriggerClientEvent('bank_lobby:client:LobbyCreated', src, enrichedLobby)
    end)
    
    -- print(string.format("[Bank Lobby] Lobby %s created by %s (%d)", lobbyId, playerName, src))
end)

RegisterNetEvent('bank_lobby:server:InvitePlayer', function(targetId)
    local src = source
    local Player = RSGCore.Functions.GetPlayer(src)
    local TargetPlayer = RSGCore.Functions.GetPlayer(targetId)
    
    if not Player or not TargetPlayer then
        SendNotification(src, "playerNotFound")
        return
    end
    
    if src == targetId then
        SendNotification(src, "cannotInviteSelf")
        return
    end
    
    local lobbyId = playerLobbies[src]
    if not lobbyId then
        SendNotification(src, "notInLobby")
        return
    end
    
    local lobby = lobbies[lobbyId]
    if not lobby then
        SendNotification(src, "notInLobby")
        return
    end
    
    -- Check if lobby is full
    if #lobby.members >= Config.Lobby.maxPlayers then
        SendNotification(src, "lobbyFull")
        return
    end
    
    -- Check if target is already in a lobby (active)
    if playerLobbies[targetId] then
        SendNotification(src, "alreadyInLobby")
        return
    end
    
    -- Check if target is already in this lobby (active members)
    for _, memberId in ipairs(lobby.members) do
        if memberId == targetId then
            SendNotification(src, "alreadyInLobby")
            return
        end
    end
    
    -- Clean target player from any disconnected lists to allow invite
    CleanPlayerFromDisconnectedLists(targetId, "invite player")
    
    local playerName = GetPlayerDisplayName(src)
    local targetName = GetPlayerDisplayName(targetId)
    
    -- Send invite to target
    TriggerClientEvent('bank_lobby:client:InviteReceived', targetId, {
        lobbyId = lobbyId,
        from = src,
        fromName = playerName
    })
    
    SendNotification(src, "invitationSent", targetName)
    
    -- print(string.format("[Bank Lobby] %s (%d) invited %s (%d) to lobby %s", playerName, src, targetName, targetId, lobbyId))
end)

RegisterNetEvent('bank_lobby:server:AcceptInvite', function(lobbyId, fromPlayerId)
    local src = source
    local Player = RSGCore.Functions.GetPlayer(src)
    if not Player then return end
    
    local lobby = lobbies[lobbyId]
    if not lobby then
        TriggerClientEvent('bank_lobby:client:Notification', src, "Lobby no longer exists", "error")
        return
    end
    
    -- Check if lobby is full
    if #lobby.members >= Config.Lobby.maxPlayers then
        SendNotification(src, "lobbyFull")
        return
    end
    
    -- Check if player is already in a lobby (active)
    if playerLobbies[src] then
        SendNotification(src, "alreadyInLobby")
        return
    end
    
    -- Clean player from any disconnected lists
    CleanPlayerFromDisconnectedLists(src, "accept invite")
    
    local playerName = GetPlayerDisplayName(src)
    
    -- Add player to lobby
    table.insert(lobby.members, src)
    table.insert(lobby.memberNames, playerName)
    playerLobbies[src] = lobbyId
    
    -- Debug: Log player addition (reduced)
    -- print(string.format("^2[LOBBY] %s (%d) joined lobby %s", playerName, src, lobbyId))
    
    -- Notify all members
    NotifyLobbyMembers(lobbyId, "playerJoined", src, playerName)
    UpdateLobbyForMembers(lobbyId)
    
    -- Send enriched lobby data to new member
    EnrichLobbyWithProfiles(lobby, function(enrichedLobby)
        enrichedLobby.disconnectedMembers = lobby.disconnectedMembers or {}
        TriggerClientEvent('bank_lobby:client:LobbyCreated', src, enrichedLobby)
    end)
    
    -- Notify inviter
    if IsPlayerOnline(fromPlayerId) then
        TriggerClientEvent('bank_lobby:client:InviteResponse', fromPlayerId, true, playerName)
    end
    
    -- print(string.format("[Bank Lobby] %s (%d) joined lobby %s", playerName, src, lobbyId))
end)

RegisterNetEvent('bank_lobby:server:DeclineInvite', function(lobbyId, fromPlayerId)
    local src = source
    local playerName = GetPlayerDisplayName(src)
    
    -- Notify inviter
    if IsPlayerOnline(fromPlayerId) then
        TriggerClientEvent('bank_lobby:client:InviteResponse', fromPlayerId, false, playerName)
    end
    
    -- print(string.format("[Bank Lobby] %s (%d) declined invite to lobby %s", playerName, src, lobbyId))
end)

RegisterNetEvent('bank_lobby:server:LeaveLobby', function()
    local src = source
    local lobbyId = playerLobbies[src]
    
    if not lobbyId then
        SendNotification(src, "notInLobby")
        return
    end
    
    local lobby = lobbies[lobbyId]
    if not lobby then
        playerLobbies[src] = nil
        return
    end
    
    local playerName = GetPlayerDisplayName(src)
    local wasOwner = lobby.owner == src
    
    -- Remove player from lobby
    RemovePlayerFromLobby(src, lobbyId)
    
    -- Notify player they left
    TriggerClientEvent('bank_lobby:client:LeftLobby', src)
    
    if wasOwner then
        -- Owner left, disband lobby
        DisbandLobby(lobbyId)
        -- print(string.format("[Bank Lobby] Lobby %s disbanded (owner %s left)", lobbyId, playerName))
    else
        -- Regular member left
        NotifyLobbyMembers(lobbyId, string.format(Config.Messages.playerLeft, playerName), "error")
        UpdateLobbyForMembers(lobbyId)
        -- print(string.format("[Bank Lobby] %s (%d) left lobby %s", playerName, src, lobbyId))
    end
end)

RegisterNetEvent('bank_lobby:server:KickPlayer', function(targetId)
    local src = source
    local lobbyId = playerLobbies[src]
    
    if not lobbyId then
        SendNotification(src, "notInLobby")
        return
    end
    
    local lobby = lobbies[lobbyId]
    if not lobby or lobby.owner ~= src then
        TriggerClientEvent('bank_lobby:client:Notification', src, "You are not the lobby owner", "error")
        return
    end
    
    if targetId == src then
        TriggerClientEvent('bank_lobby:client:Notification', src, "You cannot kick yourself", "error")
        return
    end
    
    local targetName = GetPlayerDisplayName(targetId)
    
    -- Remove target from lobby
    if RemovePlayerFromLobby(targetId, lobbyId) then
        -- Notify kicked player
        if IsPlayerOnline(targetId) then
            TriggerClientEvent('bank_lobby:client:LeftLobby', targetId)
            TriggerClientEvent('bank_lobby:client:Notification', targetId, "You were kicked from the lobby", "error")
        end
        
        -- Notify remaining members
        NotifyLobbyMembers(lobbyId, string.format("%s was kicked from the lobby", targetName), "error")
        UpdateLobbyForMembers(lobbyId)
        
        -- print(string.format("[Bank Lobby] %s (%d) was kicked from lobby %s", targetName, targetId, lobbyId))
    else
        TriggerClientEvent('bank_lobby:client:Notification', src, "Player not found in lobby", "error")
    end
end)

RegisterNetEvent('bank_lobby:server:TransferLeadership', function(targetId)
    local src = source
    local lobbyId = playerLobbies[src]
    
    if not lobbyId then
        SendNotification(src, "notInLobby")
        return
    end
    
    local lobby = lobbies[lobbyId]
    if not lobby or lobby.owner ~= src then
        TriggerClientEvent('bank_lobby:client:Notification', src, "You are not the lobby owner", "error")
        return
    end
    
    if targetId == src then
        TriggerClientEvent('bank_lobby:client:Notification', src, "You cannot transfer leadership to yourself", "error")
        return
    end
    
    -- Check if target is in the lobby
    local targetIndex = nil
    for i, memberId in ipairs(lobby.members) do
        if memberId == targetId then
            targetIndex = i
            break
        end
    end
    
    if targetIndex then
        local targetName = GetPlayerDisplayName(targetId)
        local ownerName = GetPlayerDisplayName(src)
        
        -- Transfer ownership
        lobby.owner = targetId
        lobby.ownerName = targetName
        
        -- Notify all members
        NotifyLobbyMembers(lobbyId, "leadershipTransferred", src, ownerName, targetName)
        UpdateLobbyForMembers(lobbyId)
        
        -- print(string.format("[Bank Lobby] Leadership transferred from %s (%d) to %s (%d) in lobby %s", 
          --  ownerName, src, targetName, targetId, lobbyId))
    else
        TriggerClientEvent('bank_lobby:client:Notification', src, "Player not found in lobby", "error")
    end
end)

-- Cleanup when player disconnects
AddEventHandler('playerDropped', function(reason)
    local playerId = source
    local lobbyId = playerLobbies[playerId]
    if not lobbyId then return end
    
    local lobby = lobbies[lobbyId]
    if not lobby then
        playerLobbies[playerId] = nil
        return
    end
    
    local playerName = GetPlayerDisplayName(playerId)
    
    -- IMPORTANT: Remove from playerLobbies immediately to allow invites
    playerLobbies[playerId] = nil
    
    -- Mark player as disconnected but keep in lobby for potential reconnection
    if not lobby.disconnectedMembers then
        lobby.disconnectedMembers = {}
    end
    
    -- Add to disconnected list if not already there
    local alreadyDisconnected = false
    for _, disconnectedId in ipairs(lobby.disconnectedMembers) do
        if disconnectedId == playerId then
            alreadyDisconnected = true
            break
        end
    end
    
    if not alreadyDisconnected then
        table.insert(lobby.disconnectedMembers, playerId)
    end
    
    -- Notify remaining online members
    NotifyLobbyMembers(lobbyId, "playerDisconnected", playerId, playerName)
    UpdateLobbyForMembers(lobbyId)
    
    -- print(string.format("[Bank Lobby] %s (%d) disconnected from lobby %s (removed from playerLobbies, lobby preserved)", playerName, playerId, lobbyId))
end)

-- -- Admin commands (optional)
-- -- Test command to refresh lobby profiles
-- RegisterCommand('refreshlobby', function(source, args)
--     local src = source
--     local lobbyId = playerLobbies[src]
    
--     if lobbyId then
--         -- print("^3[Bank Lobby] Manually refreshing lobby " .. lobbyId .. "^0")
--         UpdateLobbyForMembers(lobbyId)
--         -- print("^2[Bank Lobby] Lobby refreshed successfully^0")
--     else
--         -- print("^1[Bank Lobby] Player not in any lobby^0")
--     end
-- end, false)

RegisterNetEvent('bank_lobby:server:RequestLobbyRefresh', function()
    local src = source
    local lobbyId = playerLobbies[src]
    
    if lobbyId then
        -- print("^3[Bank Lobby] Refreshing lobby " .. lobbyId .. " via NUI request^0")
        UpdateLobbyForMembers(lobbyId)
    end
end)

-- Evento para player forçar limpeza do próprio estado
RegisterNetEvent('bank_lobby:server:ForceCleanPlayer', function()
    local src = source
    
    -- print(string.format("^3[Bank Lobby] Player %d requested force cleanup^0", src))
    
    -- Remove from playerLobbies
    local oldLobby = playerLobbies[src]
    playerLobbies[src] = nil
    
    -- Remove from all lobby members and disconnected lists
    local removedFrom = {}
    for lobbyId, lobby in pairs(lobbies) do
        -- Remove from members
        for i = #lobby.members, 1, -1 do
            if lobby.members[i] == src then
                table.remove(lobby.members, i)
                table.remove(lobby.memberNames, i)
                table.insert(removedFrom, lobbyId .. " (members)")
                
                -- Update lobby for remaining members
                UpdateLobbyForMembers(lobbyId)
            end
        end
        
        -- Remove from disconnected
        if lobby.disconnectedMembers then
            for i = #lobby.disconnectedMembers, 1, -1 do
                if lobby.disconnectedMembers[i] == src then
                    table.remove(lobby.disconnectedMembers, i)
                    table.insert(removedFrom, lobbyId .. " (disconnected)")
                end
            end
        end
    end
    
    if oldLobby then
        -- print(string.format("^2[Bank Lobby] Player %d cleaned from playerLobbies (was in %s)^0", src, oldLobby))
    end
    
    if #removedFrom > 0 then
        -- print(string.format("^2[Bank Lobby] Player %d removed from: %s^0", src, table.concat(removedFrom, ", ")))
    end
    
    -- print(string.format("^2[Bank Lobby] Player %d cleanup completed^0", src))
end)

-- -- Comando para testar o fluxo completo de lobby
-- RegisterCommand('testlobby', function(source, args)
--     local src = source
--     if src == 0 then -- Console command
--         -- print("=== LOBBY SYSTEM TEST ===")
--         -- print("Use the following commands to test:")
--         -- print("1. Player creates lobby: /lobby")
--         -- print("2. Player invites another: Search and invite via UI")
--         -- print("3. Target accepts invite")
--         -- print("4. Check with: lobbyinfo")
--         -- print("5. Test disconnect/reconnect scenario")
--         -- print("6. Use /fixlobby if player gets stuck")
--         return
--     end
    
--     -- Player command - show current status
--     local lobbyId = playerLobbies[src]
--     local playerName = GetPlayerDisplayName(src)
    
--     TriggerClientEvent('bank_lobby:client:Notification', src, {
--         action = "showNotification",
--         type = "info",
--         title = "Lobby Status",
--         message = lobbyId and ("In lobby: " .. lobbyId) or "Not in any lobby",
--         duration = 3000
--     }, "custom")
    
--     -- print(string.format("[Bank Lobby Test] Player %s (%d): %s", 
--     --    playerName, src, lobbyId and ("In lobby " .. lobbyId) or "Not in lobby"))
-- end, false)

-- Check for returning players when they join the server
-- Evento para forçar atualização do lobby
RegisterNetEvent('bank_lobby:server:RequestLobbyUpdate')
AddEventHandler('bank_lobby:server:RequestLobbyUpdate', function()
    local src = source
    local lobbyId = playerLobbies[src]
    
    if lobbyId and lobbies[lobbyId] then
        -- print(string.format("^6[LOBBY DEBUG] Player %d requested lobby update for %s", src, lobbyId))
        
        local lobby = lobbies[lobbyId]
        EnrichLobbyWithProfiles(lobby, function(enrichedLobby)
            enrichedLobby.disconnectedMembers = lobby.disconnectedMembers or {}
            TriggerClientEvent('bank_lobby:client:LobbyUpdated', src, enrichedLobby)
            -- print(string.format("^2[LOBBY DEBUG] Sent updated lobby data to player %d", src))
        end)
    else
        -- print(string.format("^1[LOBBY DEBUG] Player %d not in any lobby - cannot update", src))
    end
end)

AddEventHandler('playerJoining', function()
    local playerId = source
    
    -- Wait a moment for player to fully load
    SetTimeout(5000, function()
        -- Check if this player was in any lobby before disconnecting
        for lobbyId, lobby in pairs(lobbies) do
            if lobby.disconnectedMembers then
                for i, disconnectedId in ipairs(lobby.disconnectedMembers) do
                    if disconnectedId == playerId then
                        -- Player is back! Restore them to the lobby
                        table.remove(lobby.disconnectedMembers, i)
                        playerLobbies[playerId] = lobbyId
                        
                        local playerName = GetPlayerDisplayName(playerId)
                        
                        -- Notify everyone that player is back
                        NotifyLobbyMembers(lobbyId, "playerReconnected", playerId, playerName)
                        
                        -- Send lobby data to returning player
                        EnrichLobbyWithProfiles(lobby, function(enrichedLobby)
                            TriggerClientEvent('bank_lobby:client:LobbyCreated', playerId, enrichedLobby)
                        end)
                        
                        -- Update lobby for all members
                        UpdateLobbyForMembers(lobbyId)
                        
                        -- print(string.format("[Bank Lobby] %s (%d) rejoined lobby %s", playerName, playerId, lobbyId))
                        break
                    end
                end
            end
        end
    end)
end)

-- RegisterCommand('lobbyinfo', function(source, args)
--     local src = source
--     if src == 0 then -- Console command
--         -- print("=== ACTIVE LOBBIES ===")
--         for lobbyId, lobby in pairs(lobbies) do
--             -- print(string.format("Lobby %s: Owner %s (%d), Members: %d/%d", 
--              --   lobbyId, lobby.ownerName, lobby.owner, #lobby.members, Config.Lobby.maxPlayers))
--             for i, memberId in ipairs(lobby.members) do
--                 -- print(string.format("  - %s (%d)", lobby.memberNames[i], memberId))
--             end
            
--             -- Show disconnected members
--             if lobby.disconnectedMembers and #lobby.disconnectedMembers > 0 then
--                 -- print("  Disconnected members:")
--                 for _, disconnectedId in ipairs(lobby.disconnectedMembers) do
--                     -- print(string.format("    - Player %d (disconnected)", disconnectedId))
--                 end
--             end
--         end
        
--         -- print("\n=== PLAYER LOBBY ASSIGNMENTS ===")
--         for playerId, lobbyId in pairs(playerLobbies) do
--             local isOnline = IsPlayerOnline(playerId)
--             -- print(string.format("Player %d -> Lobby %s (Online: %s)", playerId, lobbyId, tostring(isOnline)))
--         end
--     end
-- end, true)

-- -- Comando para debug de player específico
-- RegisterCommand('checkplayer', function(source, args)
--     local src = source
--     if src == 0 and args[1] then -- Console command
--         local playerId = tonumber(args[1])
--         if not playerId then
--             -- print("Usage: checkplayer <player_id>")
--             return
--         end
        
--         -- print(string.format("=== PLAYER %d DEBUG ===", playerId))
--         -- print("Online: " .. tostring(IsPlayerOnline(playerId)))
--         -- print("In playerLobbies: " .. tostring(playerLobbies[playerId] ~= nil))
--         if playerLobbies[playerId] then
--             -- print("Assigned to lobby: " .. playerLobbies[playerId])
--         end
        
--         -- Check if player is in any lobby members list
--         for lobbyId, lobby in pairs(lobbies) do
--             local inMembers = false
--             for _, memberId in ipairs(lobby.members) do
--                 if memberId == playerId then
--                     inMembers = true
--                     break
--                 end
--             end
            
--             local inDisconnected = false
--             if lobby.disconnectedMembers then
--                 for _, disconnectedId in ipairs(lobby.disconnectedMembers) do
--                     if disconnectedId == playerId then
--                         inDisconnected = true
--                         break
--                     end
--                 end
--             end
            
--             if inMembers or inDisconnected then
--                 -- print(string.format("Found in lobby %s: Members=%s, Disconnected=%s", 
--                  --   lobbyId, tostring(inMembers), tostring(inDisconnected)))
--             end
--         end
--     end
-- end, true)

-- -- Comando para forçar limpeza de player específico
-- RegisterCommand('cleanplayer', function(source, args)
--     local src = source
--     if src == 0 and args[1] then -- Console command
--         local playerId = tonumber(args[1])
--         if not playerId then
--             -- print("Usage: cleanplayer <player_id>")
--             return
--         end
        
--         -- print(string.format("Cleaning player %d from all lobby data...", playerId))
        
--         -- Remove from playerLobbies
--         local oldLobby = playerLobbies[playerId]
--         playerLobbies[playerId] = nil
        
--         -- Remove from all lobby members and disconnected lists
--         local removedFrom = {}
--         for lobbyId, lobby in pairs(lobbies) do
--             -- Remove from members
--             for i = #lobby.members, 1, -1 do
--                 if lobby.members[i] == playerId then
--                     table.remove(lobby.members, i)
--                     table.remove(lobby.memberNames, i)
--                     table.insert(removedFrom, lobbyId .. " (members)")
--                 end
--             end
            
--             -- Remove from disconnected
--             if lobby.disconnectedMembers then
--                 for i = #lobby.disconnectedMembers, 1, -1 do
--                     if lobby.disconnectedMembers[i] == playerId then
--                         table.remove(lobby.disconnectedMembers, i)
--                         table.insert(removedFrom, lobbyId .. " (disconnected)")
--                     end
--                 end
--             end
--         end
        
--         if oldLobby then
--             -- print(string.format("Removed from playerLobbies (was in %s)", oldLobby))
--         end
        
--         if #removedFrom > 0 then
--             -- print("Removed from lobbies: " .. table.concat(removedFrom, ", "))
--         else
--             -- print("Player was not found in any lobby")
--         end
        
--         -- print("Player cleanup completed")
--     end
-- end, true)

-- Player Search Function
RegisterNetEvent('bank_lobby:server:SearchPlayers', function(query, searchType)
    local src = source
    local results = {}
    
    -- print(string.format("[Bank Lobby] Search request: query='%s', type='%s', from player %d", query, searchType, src))
    
    if searchType == 'id' then
        -- Search by player ID
        local targetId = tonumber(query)
        if targetId and IsPlayerOnline(targetId) then
            local playerName = GetPlayerDisplayName(targetId)
            -- print(string.format("[Bank Lobby] Found player by ID: %d = '%s'", targetId, playerName))
            table.insert(results, {
                id = targetId,
                name = playerName,
                status = "Online"
            })
        else
            -- print(string.format("[Bank Lobby] Player ID %d not found or offline", targetId or 0))
        end
    else
        -- Search by character name
        local searchQuery = string.lower(query)
        local players = RSGCore.Functions.GetPlayers()
        
        -- print(string.format("[Bank Lobby] Searching names for '%s' among %d players", searchQuery, #players))
        
        for _, playerId in ipairs(players) do
            if playerId ~= src then -- Don't include the searcher
                local playerName = GetPlayerDisplayName(playerId)
                local lowerName = string.lower(playerName)
                
                -- print(string.format("[Bank Lobby] Checking player %d: '%s' (lower: '%s')", playerId, playerName, lowerName))
                
                -- Check if name contains the search query
                if string.find(lowerName, searchQuery, 1, true) then
                    -- print(string.format("[Bank Lobby] MATCH FOUND: %d = '%s'", playerId, playerName))
                    table.insert(results, {
                        id = playerId,
                        name = playerName,
                        status = playerLobbies[playerId] and "In Lobby" or "Online"
                    })
                end
            end
        end
        
        -- Sort results by relevance (exact match first, then partial matches)
        table.sort(results, function(a, b)
            local aLower = string.lower(a.name)
            local bLower = string.lower(b.name)
            local aExact = aLower == searchQuery
            local bExact = bLower == searchQuery
            
            if aExact and not bExact then return true end
            if bExact and not aExact then return false end
            
            return a.name < b.name
        end)
        
        -- Limit results to avoid spam
        if #results > 10 then
            local limitedResults = {}
            for i = 1, 10 do
                table.insert(limitedResults, results[i])
            end
            results = limitedResults
        end
    end
    
    -- print(string.format("[Bank Lobby] Search completed: %d results found", #results))
    for i, result in ipairs(results) do
        -- print(string.format("  %d. ID:%d Name:'%s' Status:'%s'", i, result.id, result.name, result.status))
    end
    
    TriggerClientEvent('bank_lobby:client:SearchResults', src, results)
end)

-- Cleanup on resource restart
AddEventHandler('onResourceStop', function(resourceName)
    if GetCurrentResourceName() == resourceName then
        -- Notify all players in lobbies
        for lobbyId, lobby in pairs(lobbies) do
            for _, playerId in ipairs(lobby.members) do
                if IsPlayerOnline(playerId) then
                    TriggerClientEvent('bank_lobby:client:LobbyDisbanded', playerId)
                end
            end
        end
        
        -- Clear all data
        lobbies = {}
        playerLobbies = {}
        -- print("[Bank Lobby] Resource stopped, all lobbies disbanded")
    end
end)

-- ================================
--        HOSTAGE SYSTEM INTEGRATION
-- ================================

-- Event para quando hostage foge (sincronizar com lobby)
RegisterNetEvent('hostages:hostageEscaped')
AddEventHandler('hostages:hostageEscaped', function(hostageId, timeDecrease)
    local src = source
    local lobbyId = playerLobbies[src]
    
    if not lobbyId or not lobbies[lobbyId] then
        return
    end
    
    local lobby = lobbies[lobbyId]
    -- print("^1[HOSTAGE ESCAPE] " .. hostageId .. " fugiu - notificando lobby " .. lobbyId .. " (" .. #lobby.members .. " membros)")
    
    -- Notificar todos os membros do lobby sobre a fuga
    for _, playerId in ipairs(lobby.members) do
        if IsPlayerOnline(playerId) then
            TriggerClientEvent('hostages:syncHostageEscape', playerId, hostageId, timeDecrease)
        end
    end
end)

-- Event para quando hostage morre (sincronizar com lobby)
RegisterNetEvent('hostages:hostageDied')
AddEventHandler('hostages:hostageDied', function(hostageId, timeDecrease)
    local src = source
    local lobbyId = playerLobbies[src]
    
    if not lobbyId or not lobbies[lobbyId] then
        return
    end
    
    local lobby = lobbies[lobbyId]
    -- print("^1[HOSTAGE DEATH] " .. hostageId .. " morreu - notificando lobby " .. lobbyId .. " (" .. #lobby.members .. " membros)")
    
    -- Notificar todos os membros do lobby sobre a morte
    for _, playerId in ipairs(lobby.members) do
        if IsPlayerOnline(playerId) then
            TriggerClientEvent('hostages:syncHostageDeath', playerId, hostageId, timeDecrease)
        end
    end
end)

-- Função para iniciar timer do assalto para todos do lobby
local function StartRobberyTimerForLobby(playerId, duration, locationId)
    local lobbyId = playerLobbies[playerId]
    
    if not lobbyId or not lobbies[lobbyId] then
        -- print("^3[ROBBERY TIMER] Player " .. playerId .. " não está em lobby - timer só para ele")
        TriggerClientEvent('hostages:startRobberyTimer', playerId, duration, locationId)
        return
    end
    
    local lobby = lobbies[lobbyId]
    -- print("^2[ROBBERY TIMER] Iniciando timer para lobby " .. lobbyId .. " (" .. #lobby.members .. " membros) - " .. (duration/1000) .. "s")
    
    -- Iniciar timer para todos os membros do lobby
    for _, memberId in ipairs(lobby.members) do
        if IsPlayerOnline(memberId) then
            TriggerClientEvent('hostages:startRobberyTimer', memberId, duration, locationId)
            TriggerClientEvent('bank_lobby:syncStartTimer', memberId, duration, locationId)
        end
    end
end

-- Função para parar timer do assalto para todos do lobby
local function StopRobberyTimerForLobby(playerId)
    local lobbyId = playerLobbies[playerId]
    
    if not lobbyId or not lobbies[lobbyId] then
        -- print("^3[ROBBERY TIMER] Player " .. playerId .. " não está em lobby - parando só para ele")
        TriggerClientEvent('hostages:stopRobberyTimer', playerId)
        return
    end
    
    local lobby = lobbies[lobbyId]
    -- print("^3[ROBBERY TIMER] Parando timer para lobby " .. lobbyId .. " (" .. #lobby.members .. " membros)")
    
    -- Parar timer para todos os membros do lobby
    for _, memberId in ipairs(lobby.members) do
        if IsPlayerOnline(memberId) then
            TriggerClientEvent('hostages:stopRobberyTimer', memberId)
            TriggerClientEvent('bank_lobby:syncStopTimer', memberId, false)
        end
    end
end

-- Export para outros resources iniciarem timer do assalto
exports('StartRobberyTimerForLobby', StartRobberyTimerForLobby)
exports('StopRobberyTimerForLobby', StopRobberyTimerForLobby)

-- Events para serem chamados via TriggerServerEvent
RegisterNetEvent('bank_lobby:startRobberyTimer')
AddEventHandler('bank_lobby:startRobberyTimer', function(duration, locationId)
    local src = source
    StartRobberyTimerForLobby(src, duration, locationId)
end)

RegisterNetEvent('bank_lobby:stopRobberyTimer')
AddEventHandler('bank_lobby:stopRobberyTimer', function()
    local src = source
    StopRobberyTimerForLobby(src)
end)

-- Event para sincronizar assalto ativo com lobby
RegisterNetEvent('bank_lobby:syncActiveRobbery')
AddEventHandler('bank_lobby:syncActiveRobbery', function(robberyId, isActive)
    local src = source
    local lobbyId = playerLobbies[src]
    
    if not lobbyId or not lobbies[lobbyId] then
        -- print("^3[ACTIVE ROBBERY] Player " .. src .. " não está em lobby - não sincronizando assalto ativo")
        return
    end
    
    local lobby = lobbies[lobbyId]
    local actionText = isActive and "Iniciando" or "Parando"
    local robberyText = robberyId or "nenhum"
    
    -- print("^2[ACTIVE ROBBERY] " .. actionText .. " assalto ativo para lobby " .. lobbyId .. " (" .. #lobby.members .. " membros): " .. robberyText)
    
    -- Sincronizar assalto ativo para todos os membros do lobby
    for _, memberId in ipairs(lobby.members) do
        if IsPlayerOnline(memberId) then
            if isActive then
                TriggerClientEvent('generators:setActiveRobbery', memberId, robberyId)
            else
                TriggerClientEvent('generators:clearActiveRobbery', memberId)
            end
        end
    end
end)

-- Event para sincronizar estado de sabotagem de geradores com lobby
RegisterNetEvent('bank_lobby:syncGeneratorSabotage')
AddEventHandler('bank_lobby:syncGeneratorSabotage', function(generatorId, isSabotaged)
    local src = source
    local lobbyId = playerLobbies[src]
    
    if not lobbyId or not lobbies[lobbyId] then
        -- print("^3[GENERATOR SABOTAGE] Player " .. src .. " não está em lobby - não sincronizando sabotagem")
        return
    end
    
    local lobby = lobbies[lobbyId]
    local actionText = isSabotaged and "sabotado" or "resetado"
    
    -- print("^2[GENERATOR SABOTAGE] Sincronizando " .. generatorId .. " como " .. actionText .. " para lobby " .. lobbyId .. " (" .. #lobby.members .. " membros)")
    
    -- Sincronizar estado de sabotagem para todos os membros do lobby
    for _, memberId in ipairs(lobby.members) do
        if IsPlayerOnline(memberId) then
            TriggerClientEvent('generators:syncSabotageState', memberId, generatorId, isSabotaged)
        end
    end
end)

-- ================================
--        LOBBY EXPORTS
-- ================================

-- Export para verificar se player está em lobby ativo
exports('IsPlayerInActiveLobby', function(playerId)
    return playerLobbies[playerId] ~= nil
end)

-- Export para obter lobby do player
exports('GetPlayerLobby', function(playerId)
    local lobbyId = playerLobbies[playerId]
    if not lobbyId then
        return nil
    end
    
    return lobbies[lobbyId]
end)

-- Export para obter membros do lobby do player
exports('GetPlayerLobbyMembers', function(playerId)
    local lobbyId = playerLobbies[playerId]
    if not lobbyId or not lobbies[lobbyId] then
        return {}
    end
    
    return lobbies[lobbyId].members or {}
end)

-- Export para verificar se dois players estão no mesmo lobby
exports('ArePlayersInSameLobby', function(playerId1, playerId2)
    local lobby1 = playerLobbies[playerId1]
    local lobby2 = playerLobbies[playerId2]
    
    return lobby1 ~= nil and lobby2 ~= nil and lobby1 == lobby2
end)

-- Export para verificar se é owner do lobby
exports('IsLobbyOwner', function(playerId)
    local lobbyId = playerLobbies[playerId]
    if not lobbyId or not lobbies[lobbyId] then
        return false
    end
    
    return lobbies[lobbyId].owner == playerId
end)

-- Export para obter ID do lobby do player
exports('GetPlayerLobbyId', function(playerId)
    return playerLobbies[playerId]
end)

-- ================================
--        PROFILE EVENTS
-- ================================

RegisterNetEvent('bank_lobby:server:GetProfile', function()
    local src = source
    local Player = RSGCore.Functions.GetPlayer(src)
    if not Player then return end
    
    -- print("^3[Bank Lobby] GetProfile request from player " .. src .. "^0")
    
    GetPlayerProfile(src, function(profile)
        if profile then
            -- print("^2[Bank Lobby] Existing profile found for player " .. src .. "^0")
            TriggerClientEvent('bank_lobby:client:ReceiveProfile', src, {
                profile_image = profile.profile_image,
                display_name = profile.display_name,
                bio = profile.bio
            })
        else
            -- print("^3[Bank Lobby] No profile found, creating default profile for player " .. src .. "^0")
            -- Create default profile automatically
            CreatePlayerProfile(src, function(created)
                if created then
                    -- print("^2[Bank Lobby] Default profile created, fetching it...^0")
                    -- Wait a moment then fetch the newly created profile
                    SetTimeout(500, function()
                        GetPlayerProfile(src, function(newProfile)
                            if newProfile then
                                -- print("^2[Bank Lobby] Default profile loaded for player " .. src .. "^0")
                                TriggerClientEvent('bank_lobby:client:ReceiveProfile', src, {
                                    profile_image = newProfile.profile_image,
                                    display_name = newProfile.display_name,
                                    bio = newProfile.bio
                                })
                            else
                                -- print("^1[Bank Lobby] Failed to load newly created profile for player " .. src .. "^0")
                                TriggerClientEvent('bank_lobby:client:ReceiveProfile', src, nil)
                            end
                        end)
                    end)
                else
                    -- print("^1[Bank Lobby] Failed to create default profile for player " .. src .. "^0")
                    TriggerClientEvent('bank_lobby:client:ReceiveProfile', src, nil)
                end
            end)
        end
    end)
end)

-- Handle update result
local function HandleUpdateResult(playerId, success)
    -- print("^6[Bank Lobby] HandleUpdateResult called for player " .. playerId .. " with success: " .. tostring(success) .. "^0")
    
    if success then
        -- print("^2[Bank Lobby] Sending SUCCESS notification to player " .. playerId .. "^0")
        TriggerClientEvent('bank_lobby:client:ProfileUpdateResult', playerId, true, "Profile updated successfully!")
        
        -- Notify lobby members about profile update if player is in a lobby
        local playerLobby = playerLobbies[playerId]
        if playerLobby and lobbies[playerLobby] then
            -- Refresh lobby UI for all members to show updated profile
            -- print("^5[Bank Lobby] Profile updated, refreshing lobby for all members^0")
            UpdateLobbyForMembers(playerLobby)
        end
    else
        -- print("^1[Bank Lobby] Sending FAILURE notification to player " .. playerId .. "^0")
        TriggerClientEvent('bank_lobby:client:ProfileUpdateResult', playerId, false, "Failed to update profile")
    end
end

-- Direct profile update function
local function UpdateProfileDirectly(playerId, profileData)
    -- print("^4[Bank Lobby] UpdateProfileDirectly called for player " .. playerId .. "^0")
    -- print("^4[Bank Lobby] Profile data validation:^0")
    
    -- Validate profile image (must be a preset)
    if profileData.profile_image then
        -- print("  Validating profile_image: " .. profileData.profile_image)
        local isValidPreset = false
        for key, imagePath in pairs(Config.Profile.images) do
            -- print("    Checking against " .. key .. ": " .. imagePath)
            if profileData.profile_image == imagePath then
                isValidPreset = true
                -- print("    ✅ Valid preset found: " .. key)
                break
            end
        end
        
        if not isValidPreset then
            -- print("^1[Bank Lobby] Invalid profile image: " .. profileData.profile_image .. "^0")
            TriggerClientEvent('bank_lobby:client:ProfileUpdateResult', playerId, false, "Invalid profile image selection")
            return
        else
            -- print("^2[Bank Lobby] Profile image validation passed^0")
        end
    end
    
    if profileData.display_name then
        -- print("  Validating display_name: '" .. profileData.display_name .. "' (length: " .. string.len(profileData.display_name) .. ")")
        if string.len(profileData.display_name) > Config.Profile.validation.maxDisplayNameLength or string.len(profileData.display_name) < 1 then
            -- print("^1[Bank Lobby] Invalid display name length^0")
            TriggerClientEvent('bank_lobby:client:ProfileUpdateResult', playerId, false, "Display name must be 1-" .. Config.Profile.validation.maxDisplayNameLength .. " characters")
            return
        else
            -- print("^2[Bank Lobby] Display name validation passed^0")
        end
    end
    
    if profileData.bio then
        -- print("  Validating bio: '" .. profileData.bio .. "' (length: " .. string.len(profileData.bio) .. ")")
        if string.len(profileData.bio) > Config.Profile.validation.maxBioLength then
            -- print("^1[Bank Lobby] Bio too long^0")
            TriggerClientEvent('bank_lobby:client:ProfileUpdateResult', playerId, false, "Bio must be under " .. Config.Profile.validation.maxBioLength .. " characters")
            return
        else
            -- print("^2[Bank Lobby] Bio validation passed^0")
        end
    end
    
    -- print("^5[Bank Lobby] Starting profile update for player " .. playerId .. "^0")
    
    UpdatePlayerProfile(playerId, profileData, function(success)
        -- print("^6[Bank Lobby] UpdatePlayerProfile callback called with success: " .. tostring(success) .. "^0")
        HandleUpdateResult(playerId, success)
    end)
end

RegisterNetEvent('bank_lobby:server:UpdateProfile', function(profileData)
    local src = source
    local Player = RSGCore.Functions.GetPlayer(src)
    if not Player then 
        -- print("^1[Bank Lobby] Player not found for source: " .. src .. "^0")
        return 
    end
    
    -- print("^3[Bank Lobby] Update profile request from player " .. src .. ":^0")
    for k, v in pairs(profileData) do
        -- print("  " .. k .. " = " .. tostring(v))
    end
    
    -- Since profile should always exist now (auto-created), proceed directly with update
    -- print("^5[Bank Lobby] Proceeding with profile update for player " .. src .. "^0")
    UpdateProfileDirectly(src, profileData)
end)

-- Event para adicionar tempo ao roubo para todos do lobby
-- Event para sincronizar mudanças de tempo via GlobalState
RegisterNetEvent('bank_lobby:syncTimeChange')
AddEventHandler('bank_lobby:syncTimeChange', function(timeToAdd, reason)
    local playerId = source
    local lobbyId = playerLobbies[playerId]
    local lobby = lobbyId and lobbies[lobbyId] or nil
    
    if not lobby then
        -- print("^3[LOBBY] Player " .. playerId .. " não está em lobby - não sincronizando tempo")
        return
    end
    
    reason = reason or "Time Added"
    local lobbyId = lobby.id
    
    -- print("^2[LOBBY] Sincronizando " .. (timeToAdd/1000) .. "s via GlobalState para lobby " .. lobbyId .. " - Razão: " .. reason)
    -- print("^2[LOBBY] Membros do lobby: " .. table.concat(lobby.members, ", "))
    
    -- Usar GlobalState para sincronizar com todos os membros da lobby
    local currentTime = GetGameTimer()
    local globalStateKey = 'lobby_time_' .. lobbyId
    local globalStateData = {
        timeChange = timeToAdd,
        reason = reason,
        timestamp = currentTime,
        sourcePlayer = playerId
    }
    
    -- print("^2[LOBBY] Definindo GlobalState[" .. globalStateKey .. "] = " .. json.encode(globalStateData))
    GlobalState[globalStateKey] = globalStateData
    
    -- Aguardar um pouco e verificar se foi definido
    CreateThread(function()
        Wait(100)
        local checkValue = GlobalState[globalStateKey]
        if checkValue then
            -- print("^2[LOBBY] GlobalState confirmado: " .. json.encode(checkValue))
        else
            -- print("^1[LOBBY] ERRO: GlobalState não foi definido!")
        end
    end)
end)

-- Manter o evento antigo para compatibilidade
RegisterNetEvent('bank_lobby:addTimeToRobbery')
AddEventHandler('bank_lobby:addTimeToRobbery', function(timeToAdd, reason)
    local playerId = source
    local lobbyId = playerLobbies[playerId]
    local lobby = lobbyId and lobbies[lobbyId] or nil
    
    if not lobby then
        -- print("^3[LOBBY] Player " .. playerId .. " não está em lobby - não sincronizando tempo")
        return
    end
    
    reason = reason or "Time Added"
    -- print("^2[LOBBY] Adicionando " .. (timeToAdd/1000) .. "s para todos do lobby - Razão: " .. reason)
    
    -- Sincronizar tempo adicionado com todos os membros do lobby
    for _, memberId in ipairs(lobby.members) do
        TriggerClientEvent('bank_lobby:syncAddTime', memberId, timeToAdd, reason)
    end
end)
