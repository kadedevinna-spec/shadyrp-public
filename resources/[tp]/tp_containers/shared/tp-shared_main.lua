
-- @GetTableLength returns the length of a table.
function GetTableLength(T)
    local count = 0
    for _ in pairs(T) do count = count + 1 end
    return count
end

function StartsWith(String,Start)
	return string.sub(String,1,string.len(Start))==Start
end

function Round(num, numDecimalPlaces)
    local mult = 10^(numDecimalPlaces or 0)
    return math.floor(num * mult + 0.5) / mult
end


function IsPlayerAllowlisted(currentGroup, userRoles)

    -- We first check for groups (if available and not null)
    if currentGroup and Config.AllowlistedGroups and GetTableLength(Config.AllowlistedGroups) > 0 then

        for _, group in pairs (Config.AllowlistedGroups) do

            if group == currentGroup then
                return true
            end
        end

    end

    -- Secondary we check for discord roles (if available and not null)
    if ( userRoles and GetTableLength(userRoles) > 0 ) and ( Config.PermittedDiscordRoles and GetTableLength(Config.PermittedDiscordRoles) > 0 ) then

        for _, role in pairs (Config.PermittedDiscordRoles) do
  
            for _, userRole in pairs (userRoles) do
              
              if tonumber(userRole) == tonumber(role) then
                return true
              end
        
            end

        end

    end
  
    return false
end
