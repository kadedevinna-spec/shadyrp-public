Config = {}

-- Commands
Config.Commands = {
    lobby = "lobby",        -- Command to open lobby interface (shows menu if not in lobby)
    invite = "invite",      -- Command to invite player to lobby (legacy - use UI instead)
    leave = "leaveLobby"    -- Command to leave current lobby
    -- Additional commands:
    -- /createlobby - Create lobby directly (no menu)
    -- /fixlobby - Reset lobby state if stuck
}

-- Lobby Settings
Config.Lobby = {
    maxPlayers = 8,             -- Maximum players in a lobby
    inviteTimeout = 30000,      -- Invitation timeout in milliseconds (30 seconds)
    autoCloseInterface = 5000,  -- Auto close interface after no activity (5 seconds)
    enableNotifications = true, -- Enable notification system
}

-- UI Settings
Config.UI = {
    fadeInDuration = 800,   -- Interface fade in duration in milliseconds
    fadeOutDuration = 400,  -- Interface fade out duration in milliseconds
    animationType = "western-paper", -- Animation type: "western-paper", "western-saloon", "fade", "slide", "zoom", "bounce", "elastic", "flip"
    enableMicroAnimations = true, -- Enable button pulses, shakes, etc
    westernEffects = true,  -- Enable western dust particles and paper texture
}

-- Profile System
Config.Profile = {
    -- Profile image settings
    images = {
        default = "images/default_profile.png",     -- Default profile image
        option1 = "images/profile_1.png",           -- Profile option 1
        option2 = "images/profile_2.png",           -- Profile option 2  
        option3 = "images/profile_3.png",           -- Profile option 3
        option4 = "images/profile_4.png",           -- Profile option 4
        option5 = "images/profile_5.png",           -- Profile option 5
        option6 = "images/profile_6.png",           -- Profile option 6
        option7 = "images/profile_7.png",           -- Profile option 7
        option8 = "images/profile_8.png",           -- Profile option 8
        option9 = "images/profile_9.png",           -- Profile option 9
        option10 = "images/profile_10.png",         -- Profile option 10
        option11 = "images/profile_11.png",         -- Profile option 11
        option12 = "images/profile_12.png",         -- Profile option 12
        option13 = "images/profile_13.png",         -- Profile option 13
        option14 = "images/profile_14.png",         -- Profile option 14
    },
    
    -- Profile validation settings
    validation = {
        maxDisplayNameLength = 50,      -- Maximum characters for display name
        maxBioLength = 200,             -- Maximum characters for bio
    },
    
    -- Profile UI settings
    ui = {
        imageSize = "120px",            -- Profile image display size
        showCharacterCounter = true,    -- Show character counter for inputs
    }
}

-- Notification System
Config.Notifications = {
    
    -- Notification position on screen
    position = {
        top = "80px",
        right = "20px",
        maxWidth = "400px"
    },
    
    -- Custom images for each notification type
    images = {
        invite = "images/invite.png",           -- Envelope/letter icon
        success = "images/success.png",         -- Checkmark/thumbs up
        error = "images/error.png",             -- X/warning icon
        info = "images/info.png",               -- Information/question mark
        lobby = "images/lobby.png",             -- Group/people icon
        kick = "images/kick.png",               -- Boot/sheriff badge
        playerJoined = "images/player_join.png", -- Player joining
        playerLeft = "images/player_leave.png",  -- Player leaving
        lobbyCreated = "images/lobby_create.png", -- Lobby creation
        lobbyDisbanded = "images/lobby_disband.png" -- Lobby disbanded
    },
    
    -- Default durations (in milliseconds)
    durations = {
        invite = 30000,     -- Match invite timeout
        success = 4000,
        error = 5000,
        info = 3000,
        lobby = 4000
    },
    
    -- Notification texts and configurations
    messages = {
        -- Lobby Invitations
        inviteReceived = {
            type = "invite",
            title = "Lobby Invitation",
            message = "%s invited you to join their lobby",
            image = "invite",
            actions = {
                {text = "Accept", type = "accept", action = "acceptInvite"},
                {text = "Decline", type = "decline", action = "declineInvite"}
            }
        },
        
        -- Invite Responses
        inviteAccepted = {
            type = "success",
            title = "Invitation Accepted",
            message = "%s joined your lobby",
            image = "success"
        },
        
        inviteDeclined = {
            type = "error", 
            title = "Invitation Declined",
            message = "%s declined your invitation",
            image = "error"
        },
        
        -- Lobby Events
        lobbyCreated = {
            type = "success",
            title = "Lobby Created",
            message = "Your lobby has been created successfully",
            image = "lobbyCreated"
        },
        
        lobbyDisbanded = {
            type = "error",
            title = "Lobby Disbanded", 
            message = "The lobby has been disbanded",
            image = "lobbyDisbanded"
        },
        
        leadershipTransferred = {
            type = "info",
            title = "Leadership Changed",
            message = "Lobby leadership has been transferred",
            image = "info"
        },
        
        -- Player Connection Status
        playerDisconnected = {
            type = "warning",
            title = "Player Disconnected",
            message = "%s disconnected (can rejoin)",
            image = "warning"
        },
        
        playerReconnected = {
            type = "success", 
            title = "Player Reconnected",
            message = "%s reconnected to the lobby",
            image = "success"
        },
        
        playerJoined = {
            type = "success",
            title = "Player Joined",
            message = "%s joined the lobby",
            image = "playerJoined"
        },
        
        playerLeft = {
            type = "info",
            title = "Player Left", 
            message = "%s left the lobby",
            image = "playerLeft"
        },
        
        playerKicked = {
            type = "error",
            title = "Player Kicked",
            message = "%s was kicked from the lobby",
            image = "kick"
        },
        
        youWereKicked = {
            type = "error",
            title = "Kicked from Lobby",
            message = "You were kicked from the lobby",
            image = "kick"
        },
        
        -- Errors
        lobbyFull = {
            type = "error",
            title = "Lobby Full",
            message = "The lobby is full and cannot accept more players",
            image = "error"
        },
        
        playerNotFound = {
            type = "error", 
            title = "Player Not Found",
            message = "The specified player was not found or is offline",
            image = "error"
        },
        
        alreadyInLobby = {
            type = "error",
            title = "Already in Lobby", 
            message = "You or the target player is already in a lobby",
            image = "error"
        },
        
        notInLobby = {
            type = "error",
            title = "Not in Lobby",
            message = "You are not currently in a lobby",
            image = "error"
        },
        
        cannotInviteSelf = {
            type = "error",
            title = "Invalid Invitation",
            message = "You cannot invite yourself to a lobby",
            image = "error"
        },
        
        invitationSent = {
            type = "success",
            title = "Invitation Sent",
            message = "Invitation sent to %s",
            image = "success"
        }
    }
}


