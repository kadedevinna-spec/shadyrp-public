let currentLobby = null;
let currentPlayerId = null;
let isOwner = false;

// DOM Elements
const lobbyContainer = document.getElementById('lobbyContainer');
const lobbyId = document.getElementById('lobbyId');
const memberCount = document.getElementById('memberCount');
const membersList = document.getElementById('membersList');
const leaveBtn = document.getElementById('leaveBtn');
const closeBtn = document.getElementById('closeBtn');

// Member profile mapping helper
function getMemberProfile(memberId, index) {
    // Priority 1: Use ID-based mapping (most reliable)
    if (currentLobby.memberProfilesById && currentLobby.memberProfilesById[memberId.toString()]) {
        const profile = currentLobby.memberProfilesById[memberId.toString()];
        console.log(`[PROFILE LOOKUP] Found profile for ID ${memberId} via ID mapping:`, profile);
        return profile;
    }
    
    // Priority 2: Use index-based mapping (Lua 1-based)
    if (currentLobby.memberProfiles && currentLobby.memberProfiles[index + 1]) {
        const profile = currentLobby.memberProfiles[index + 1];
        console.log(`[PROFILE LOOKUP] Found profile for ID ${memberId} via index ${index + 1} (fallback):`, profile);
        return profile;
    }
    
    console.log(`[PROFILE LOOKUP] No profile found for ID ${memberId} at index ${index}`);
    return null;
}

// Modal Elements
const inviteModal = document.getElementById('inviteModal');
const openInviteModalBtn = document.getElementById('openInviteModal');
const closeInviteModalBtn = document.getElementById('closeInviteModal');
const searchInput = document.getElementById('searchInput');
const searchResultsList = document.getElementById('searchResultsList');
const inviteSelectedBtn = document.getElementById('inviteSelectedBtn');
const cancelInviteBtn = document.getElementById('cancelInviteBtn');

// Modal State
let selectedPlayer = null;
let searchTimeout = null;

// Notification System
const notificationContainer = document.getElementById('notificationContainer');
let notificationId = 0;

// Profile System - Safe element selection with null checks
const profileModalContainer = document.getElementById('profileModalContainer');
const currentProfileImg = document.getElementById('currentProfileImg');
const profileNameInput = document.getElementById('profileName');
const profileBioInput = document.getElementById('profileBio');
const presetImagesGrid = document.getElementById('presetImagesGrid');
let currentProfile = null;
let profileConfig = null;

// Event Listeners
document.addEventListener('DOMContentLoaded', function() {
    // Debug: Check if confirm modal elements exist
    console.log('[INIT] Checking confirm modal elements:');
    console.log('[INIT] customConfirmModal:', !!customConfirmModal);
    console.log('[INIT] confirmModalTitle:', !!confirmModalTitle);
    console.log('[INIT] confirmModalMessage:', !!confirmModalMessage);
    console.log('[INIT] confirmModalCancel:', !!confirmModalCancel);
    console.log('[INIT] confirmModalConfirm:', !!confirmModalConfirm);
    
    // Close button
    closeBtn.addEventListener('click', closeLobby);
    
    // Leave button
    leaveBtn.addEventListener('click', leaveLobby);
    
    // Modal Events
    openInviteModalBtn.addEventListener('click', openInviteModal);
    closeInviteModalBtn.addEventListener('click', closeInviteModal);
    cancelInviteBtn.addEventListener('click', closeInviteModal);
    
    // Smart Search - real time as user types
    searchInput.addEventListener('input', handleSearchInput);
    searchInput.addEventListener('keypress', function(e) {
        if (e.key === 'Enter') {
            e.preventDefault();
            performSearch();
        }
    });
    
    // Invite selected
    inviteSelectedBtn.addEventListener('click', inviteSelectedPlayer);
    
    // Close modal on overlay click
    inviteModal.addEventListener('click', function(e) {
        if (e.target.classList.contains('modal-overlay')) {
            closeInviteModal();
        }
    });
    
    // ESC key to close
    document.addEventListener('keydown', function(e) {
        if (e.key === 'Escape') {
            console.log('[ESC] ESC key pressed, checking modals...');
            console.log('[ESC] Active element:', e.target.tagName, e.target.className);
            
            // Check if ESC was pressed in an input field within a modal
            const isInInput = e.target.tagName === 'INPUT' || e.target.tagName === 'TEXTAREA';
            const isInProfileModal = profileModalContainer && !profileModalContainer.classList.contains('hidden') && profileModalContainer.contains(e.target);
            const isInInviteModal = !inviteModal.classList.contains('hidden') && inviteModal.contains(e.target);
            
            console.log('[ESC] Is in input:', isInInput);
            console.log('[ESC] Is in profile modal:', isInProfileModal);
            console.log('[ESC] Is in invite modal:', isInInviteModal);
            
            // If ESC is pressed in an input within a modal, just close the modal without disabling focus
            if (isInInput && (isInProfileModal || isInInviteModal)) {
                console.log('[ESC] ESC in input field, closing modal without disabling focus');
                e.preventDefault();
                e.stopPropagation();
                
                if (isInProfileModal) {
                    // Close profile modal but keep focus enabled
                    closeProfileModalKeepFocus();
                } else if (isInInviteModal) {
                    closeInviteModal();
                }
                return;
            }
            
            // Debug: Check which modals are open
            console.log('[ESC] Notifications with focus:', document.querySelectorAll('.custom-notification[data-needs-focus="true"]').length);
            console.log('[ESC] Custom confirm modal hidden:', customConfirmModal ? customConfirmModal.classList.contains('hidden') : 'not found');
            console.log('[ESC] Member details modal hidden:', memberDetailsModalContainer ? memberDetailsModalContainer.classList.contains('hidden') : 'not found');
            console.log('[ESC] Profile modal hidden:', profileModalContainer ? profileModalContainer.classList.contains('hidden') : 'not found');
            console.log('[ESC] Invite modal hidden:', inviteModal.classList.contains('hidden'));
            console.log('[ESC] Lobby container hidden:', lobbyContainer.classList.contains('hidden'));
            
            // Check for notifications with focus first
            const focusNotifications = document.querySelectorAll('.custom-notification[data-needs-focus="true"]');
            if (focusNotifications.length > 0) {
                // Close the most recent notification with focus
                const lastNotification = focusNotifications[focusNotifications.length - 1];
                const notifId = lastNotification.id.replace('notification-', '');
                
                // Disable focus and close
                fetch(`https://${GetParentResourceName()}/disableFocus`, {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/json; charset=UTF-8',
                    },
                    body: JSON.stringify({})
                });
                console.log('[ESC] Closing notification:', notifId);
                closeNotification(notifId);
            } else if (customConfirmModal && !customConfirmModal.classList.contains('hidden')) {
                console.log('[ESC] Closing custom confirm modal');
                hideCustomConfirm();
            } else if (memberDetailsModalContainer && !memberDetailsModalContainer.classList.contains('hidden')) {
                console.log('[ESC] Closing member details modal');
                closeMemberDetailsModal();
            } else if (profileModalContainer && !profileModalContainer.classList.contains('hidden')) {
                console.log('[ESC] Closing profile modal');
                closeProfileModal();
            } else if (!inviteModal.classList.contains('hidden')) {
                console.log('[ESC] Closing invite modal');
                closeInviteModal();
            } else if (!lobbyContainer.classList.contains('hidden')) {
                console.log('[ESC] Closing lobby');
                closeLobby();
            } else {
                console.log('[ESC] No modal found to close');
            }
        }
    });
});

// NUI Message Handler
window.addEventListener('message', function(event) {
    const data = event.data;
    
    switch(data.action) {
        case 'openLobby':
            openLobby(data.lobby, data.config, data.playerId);
            break;
        case 'closeLobby':
            closeLobby(data.config);
            break;
        case 'updateLobby':
            updateLobby(data.lobby);
            break;
            
        case 'forceReload':
            // Force reload the page to clear any cached JavaScript
            window.location.reload(true);
            break;
            
        case 'hideAllNotifications':
            // Hide all active notifications (used when accepting invite while lobby menu is open)
            hideAllNotifications();
            break;
        case 'searchResults':
            displaySearchResults(data.results);
            break;
        case 'showNotification':
            showCustomNotification(data.type, data.title, data.message, data.actions, data.duration, data.imageKey, data.needsFocus);
            break;
            
        case 'receiveProfile':
            console.log('receiveProfile event received:', data);
            if (data.success && data.profile) {
                console.log('Profile data:', data.profile);
                currentProfile = data.profile;
                
                // Update UI
                if (currentProfile.profile_image && currentProfileImg) {
                    console.log('Setting profile image to:', currentProfile.profile_image);
                    currentProfileImg.src = currentProfile.profile_image; // Already includes 'images/' path
                    
                    // Highlight matching preset if exists
                    highlightMatchingPreset(currentProfile.profile_image);
                }
                
                if (currentProfile.display_name && profileNameInput) {
                    console.log('Setting display name to:', currentProfile.display_name);
                    profileNameInput.value = currentProfile.display_name;
                }
                
                if (currentProfile.bio && profileBioInput) {
                    console.log('Setting bio to:', currentProfile.bio);
                    profileBioInput.value = currentProfile.bio;
                }
            } else {
                console.log('No profile data or profile data is null');
            }
            break;
            
        case 'profileUpdateResult':
            console.log('Profile update result received:', data);
            
            // Clear timeout since we got response
            if (window.currentSaveTimeout) {
                clearTimeout(window.currentSaveTimeout);
                window.currentSaveTimeout = null;
            }
            
            // Always reset loading state
            const saveBtn = document.querySelector('.save-profile-btn');
            if (saveBtn) {
                saveBtn.classList.remove('loading');
                saveBtn.textContent = 'Save Changes';
            }
            
            if (data.success) {
                console.log('Showing SUCCESS notification');
                showCustomNotification('success', 'Profile Saved', data.message || 'Profile updated successfully!', null, 4000);
                closeProfileModal();
            } else {
                console.log('Showing FAILURE notification');
                showSaveError(data.message || 'Failed to save profile.');
            }
            break;
    }
});

function openLobby(lobby, config, playerId) {
    currentLobby = lobby;
    currentPlayerId = playerId;
    isOwner = lobby.owner === currentPlayerId;
    
    console.log('Opening lobby with data:', lobby);
    console.log('Lobby has memberProfiles:', !!lobby.memberProfiles);
    
    // If lobby doesn't have enriched profiles, request them
    if (!lobby.memberProfiles || Object.keys(lobby.memberProfiles).length === 0) {
        console.log('Lobby missing profiles, requesting refresh...');
        fetch(`https://${GetParentResourceName()}/refreshLobby`, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
            },
            body: JSON.stringify({})
        }).catch(error => {
            console.error('Error requesting lobby refresh:', error);
        });
    }
    
    updateLobbyDisplay();
    
    // Clean reset and show
    lobbyContainer.classList.remove('hidden', 'closing');
    lobbyContainer.style.opacity = ''; // Reset any inline styles
}

function closeLobby(config = {}) {
    // Prevent multiple close calls
    if (lobbyContainer.classList.contains('closing') || lobbyContainer.classList.contains('hidden')) {
        return;
    }
    
    // Start fade out animation
    lobbyContainer.classList.add('closing');
    
    // Wait for fade to complete, then hide completely
    setTimeout(() => {
        if (lobbyContainer.classList.contains('closing')) {
            lobbyContainer.classList.add('hidden');
            lobbyContainer.classList.remove('closing');
            
            // Send close callback to client
            fetch(`https://${GetParentResourceName()}/closeLobby`, {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json; charset=UTF-8',
                },
                body: JSON.stringify({})
            });
        }
    }, 250); // Match CSS transition time
}

// Debounce timer para evitar atualizações excessivas
let updateLobbyTimeout = null;

function updateLobby(lobby) {
    currentLobby = lobby;
    currentPlayerId = getCurrentPlayerId();
    isOwner = lobby.owner === currentPlayerId;
    
    // Names are now working correctly
    
    // Cancelar atualização anterior se existir
    if (updateLobbyTimeout) {
        clearTimeout(updateLobbyTimeout);
    }
    
    // Agendar nova atualização com debounce de 100ms
    updateLobbyTimeout = setTimeout(() => {
        updateLobbyDisplay();
        updateLobbyTimeout = null;
    }, 100);
}

function updateLobbyDisplay() {
    if (!currentLobby) return;
    
    // Update lobby info
    lobbyId.textContent = `ID: ${currentLobby.id}`;
    memberCount.textContent = `${currentLobby.members.length}/8 members`;
    
    // Update members list
    updateMembersList();
}

function updateMembersList() {
    if (!currentLobby || !currentLobby.members) return;
    
    console.log('Updating members list with lobby:', currentLobby);
    console.log('Members:', currentLobby.members);
    console.log('Member names:', currentLobby.memberNames);
    console.log('Member profiles (by index):', currentLobby.memberProfiles);
    console.log('Member profiles (by ID):', currentLobby.memberProfilesById);
    
    // Store existing members for animation comparison
    const existingMembers = Array.from(membersList.children).map(item => 
        parseInt(item.dataset.memberId)
    );
    
    // Clear list
    membersList.innerHTML = '';
    
    // Add members with entrance animations
    currentLobby.members.forEach((memberId, index) => {
        // Get the correct name for this member at this index
        const memberName = currentLobby.memberNames[index] || 'Unknown';
        
        console.log(`Processing member ${memberId} at index ${index} with name: ${memberName}`);
        
        // Get profile for this member using helper function
        const memberProfile = getMemberProfile(memberId, index);
        
        // Create member item with the correct name and profile
        const memberItem = createMemberItem(memberId, memberName, memberId === currentLobby.owner, memberProfile);
        
        // Set member ID for tracking
        memberItem.dataset.memberId = memberId;
        
        // Add entrance animation for new members
        if (!existingMembers.includes(memberId)) {
            memberItem.classList.add('member-enter');
            setTimeout(() => {
                memberItem.classList.remove('member-enter');
            }, 300);
        }
        
        membersList.appendChild(memberItem);
    });
}

function createMemberItem(memberId, memberName, isOwnerMember, memberProfile) {
    const item = document.createElement('div');
    item.className = `member-item ${isOwnerMember ? 'owner' : ''}`;
    
    console.log(`[MEMBER ITEM] Creating for ID: ${memberId}`);
    console.log(`[MEMBER ITEM] memberName: "${memberName}"`);
    console.log(`[MEMBER ITEM] memberProfile:`, memberProfile);
    console.log(`[MEMBER ITEM] profile display_name: "${memberProfile?.display_name}"`);
    
    // Validation: Ensure we have the correct data
    if (!memberName || memberName === 'Unknown') {
        console.warn(`[MEMBER ITEM] WARNING: Member ${memberId} has no proper name!`);
    }
    if (memberProfile && memberProfile.display_name && memberProfile.display_name !== memberName) {
        console.log(`[MEMBER ITEM] Profile name differs from member name for ${memberId}: "${memberProfile.display_name}" vs "${memberName}"`);
    }
    
    // Add member profile image
    const profileImage = document.createElement('div');
    profileImage.className = 'member-profile-image';
    const img = document.createElement('img');
    img.src = memberProfile?.profile_image || 'images/default_profile.png';
    img.alt = 'Profile';
    img.onerror = function() {
        this.src = 'images/default_profile.png';
    };
    profileImage.appendChild(img);
    
    const memberInfo = document.createElement('div');
    memberInfo.className = 'member-info';
    
    const name = document.createElement('div');
    name.className = 'member-name';
    
    // Use profile display_name if available and not empty, otherwise use memberName
    const displayName = (memberProfile?.display_name && memberProfile.display_name.trim() !== '') 
        ? memberProfile.display_name 
        : memberName;
    
    console.log(`[MEMBER ITEM] Final display name for ${memberId}: "${displayName}"`);
    name.textContent = displayName;
    
    const id = document.createElement('div');
    id.className = 'member-id';
    id.textContent = `ID: ${memberId}`;
    
    memberInfo.appendChild(name);
    memberInfo.appendChild(id);
    
    // Add click event to open member details modal (only on profile area)
    const clickableArea = document.createElement('div');
    clickableArea.style.cssText = `
        display: flex;
        align-items: center;
        gap: 12px;
        flex: 1;
        cursor: pointer;
        padding: 4px;
        border-radius: 4px;
        transition: background 0.2s ease;
    `;
    
            clickableArea.addEventListener('click', (e) => {
        e.stopPropagation(); // Prevent other click events
        // Use the same display name logic for consistency
        const modalDisplayName = (memberProfile?.display_name && memberProfile.display_name.trim() !== '') 
            ? memberProfile.display_name 
            : memberName;
        openMemberDetailsModal(memberId, memberProfile, modalDisplayName, isOwnerMember);
    });
    
    clickableArea.addEventListener('mouseenter', () => {
        clickableArea.style.background = 'rgba(255, 255, 255, 0.05)';
    });
    
    clickableArea.addEventListener('mouseleave', () => {
        clickableArea.style.background = 'transparent';
    });
    
    // Move profile image and info to clickable area
    clickableArea.appendChild(profileImage);
    clickableArea.appendChild(memberInfo);
    
    item.appendChild(clickableArea);
    
    // Add owner badge or kick button
    if (isOwnerMember) {
        const badge = document.createElement('div');
        badge.className = 'owner-badge';
        badge.textContent = 'OWNER';
        item.appendChild(badge);
    } else if (isOwner && memberId !== currentPlayerId) {
        const kickBtn = document.createElement('button');
        kickBtn.className = 'kick-btn';
        kickBtn.textContent = 'KICK';
        kickBtn.addEventListener('click', (e) => {
            console.log('[KICK] Kick button clicked for member:', memberId, memberName);
            e.stopPropagation(); // Prevent opening member details
            e.preventDefault(); // Prevent any default behavior
            
            // Use the same display name logic for consistency
            const kickDisplayName = (memberProfile?.display_name && memberProfile.display_name.trim() !== '') 
                ? memberProfile.display_name 
                : memberName;
            console.log('[KICK] Calling kickPlayerWithConfirm for:', kickDisplayName);
            kickPlayerWithConfirm(memberId, kickDisplayName);
        });
        item.appendChild(kickBtn);
    }
    
    return item;
}

// Modal Functions
function openInviteModal() {
    if (!isOwner) {
        return; // Only owner can invite
    }
    
    inviteModal.classList.remove('hidden');
    resetModal();
    
    // Focus after animation
    setTimeout(() => {
        searchInput.focus();
    }, 100);
}

function closeInviteModal() {
    inviteModal.classList.add('hidden');
    resetModal();
}

function resetModal() {
    searchInput.value = '';
    searchResultsList.innerHTML = '<div class="search-hint">Type a player name or ID to search</div>';
    selectedPlayer = null;
    inviteSelectedBtn.disabled = true;
    
    // Clear any pending search timeout
    if (searchTimeout) {
        clearTimeout(searchTimeout);
        searchTimeout = null;
    }
}

function handleSearchInput() {
    const query = searchInput.value.trim();
    
    // Clear previous timeout
    if (searchTimeout) {
        clearTimeout(searchTimeout);
    }
    
    // Clear selection
    selectedPlayer = null;
    inviteSelectedBtn.disabled = true;
    
    if (!query) {
        searchResultsList.innerHTML = '<div class="search-hint">Type a player name or ID to search</div>';
        return;
    }
    
    // Show loading immediately for responsiveness
    searchResultsList.innerHTML = '<div class="loading-results">Searching...</div>';
    
    // Debounce search - wait 300ms after user stops typing
    searchTimeout = setTimeout(() => {
        performSearch();
    }, 300);
}

function performSearch() {
    const query = searchInput.value.trim();
    
    if (!query) return;
    
    // Determine search type automatically
    const isNumeric = /^\d+$/.test(query);
    const searchType = isNumeric ? 'id' : 'name';
    
    // Send search request to client
    fetch(`https://${GetParentResourceName()}/searchPlayers`, {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json; charset=UTF-8',
        },
        body: JSON.stringify({
            query: query,
            searchType: searchType
        })
    });
}

function displaySearchResults(results) {
    searchResultsList.innerHTML = '';
    
    if (!results || results.length === 0) {
        searchResultsList.innerHTML = '<div class="no-results">No players found</div>';
        return;
    }
    
    results.forEach(player => {
        const resultItem = createResultItem(player);
        searchResultsList.appendChild(resultItem);
    });
}

function createResultItem(player) {
    const item = document.createElement('div');
    item.className = 'result-item';
    item.dataset.playerId = player.id;
    
    item.innerHTML = `
        <div class="result-info">
            <div class="result-name">${player.name}</div>
            <div class="result-details">
                <div class="result-id">ID: ${player.id}</div>
                <div class="result-status">${player.status || 'Online'}</div>
            </div>
        </div>
    `;
    
    item.addEventListener('click', () => selectPlayer(item, player));
    
    return item;
}

function selectPlayer(element, player) {
    // Remove previous selection
    document.querySelectorAll('.result-item').forEach(item => {
        item.classList.remove('selected');
    });
    
    // Select current
    element.classList.add('selected');
    selectedPlayer = player;
    inviteSelectedBtn.disabled = false;
}

function inviteSelectedPlayer() {
    if (!selectedPlayer) return;
    
    // Add western gunshot effect
    inviteSelectedBtn.classList.add('western-gunshot');
    setTimeout(() => {
        inviteSelectedBtn.classList.remove('western-gunshot');
    }, 400);
    
    // Send invite request
    fetch(`https://${GetParentResourceName()}/invitePlayer`, {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json; charset=UTF-8',
        },
        body: JSON.stringify({
            playerId: selectedPlayer.id,
            playerName: selectedPlayer.name
        })
    });
    
    // Close modal
    closeInviteModal();
}

// ================================
//     CUSTOM NOTIFICATION SYSTEM
// ================================

function getNotificationIcon(imageKey, type) {
    // Use custom PNG image if specified, otherwise fallback to type-based image
    if (imageKey) {
        return `<img src="${imageKey}" alt="${type}" />`;
    }
    
    // Fallback to type-based images (for backward compatibility)
    const defaultImages = {
        invite: "images/invite.png",
        success: "images/success.png", 
        error: "images/error.png",
        info: "images/info.png",
        lobby: "images/lobby.png",
        kick: "images/kick.png"
    };
    
    const imagePath = defaultImages[type] || defaultImages.info;
    return `<img src="${imagePath}" alt="${type}" />`;
}

function showCustomNotification(type, title, message, actions = null, duration = 5000, imageKey = null, needsFocus = false) {
    const notifId = ++notificationId;
    
    const notification = document.createElement('div');
    notification.className = `custom-notification ${type}`;
    notification.id = `notification-${notifId}`;
    
    // Add focus attribute if needed
    if (needsFocus) {
        notification.setAttribute('data-needs-focus', 'true');
    }
    
    const icon = getNotificationIcon(imageKey, type);
    
    let actionsHtml = '';
    if (actions && actions.length > 0) {
        actionsHtml = '<div class="notification-actions">';
        actions.forEach(action => {
            actionsHtml += `<button class="notification-btn ${action.type}" data-action="${action.action}" data-data='${JSON.stringify(action.data || {})}'>${action.text}</button>`;
        });
        actionsHtml += '</div>';
    }
    
    notification.innerHTML = `
        <div class="notification-header">
            <div class="notification-icon">${icon}</div>
            <h4 class="notification-title">${title}</h4>
            <button class="notification-close" onclick="closeNotification('${notifId}')">&times;</button>
        </div>
        <div class="notification-body">
            <p class="notification-message">${message}</p>
            ${actionsHtml}
        </div>
    `;
    
    // Add event listeners to action buttons
    if (actions) {
        const actionButtons = notification.querySelectorAll('.notification-btn');
        actionButtons.forEach(button => {
            button.addEventListener('click', function() {
                const action = this.dataset.action;
                const data = JSON.parse(this.dataset.data);
                handleNotificationAction(action, data, notifId);
            });
        });
    }
    
    notificationContainer.appendChild(notification);
    
    // Trigger show animation
    setTimeout(() => {
        notification.classList.add('show');
    }, 100);
    
    // Auto close
    if (duration > 0) {
        setTimeout(() => {
            closeNotification(notifId);
        }, duration);
    }
    
    return notifId;
}

function closeNotification(notifId) {
    const notification = document.getElementById(`notification-${notifId}`);
    if (notification) {
        // Check if this notification needed focus
        const needsFocus = notification.getAttribute('data-needs-focus') === 'true';
        
        notification.classList.add('hide');
        
        // If this notification needed focus, disable it
        if (needsFocus) {
            fetch(`https://${GetParentResourceName()}/disableFocus`, {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json; charset=UTF-8',
                },
                body: JSON.stringify({})
            }).catch(error => {
                console.error('Error disabling focus:', error);
            });
        }
        
        setTimeout(() => {
            if (notification.parentNode) {
                notification.parentNode.removeChild(notification);
            }
        }, 400);
    }
}

function hideAllNotifications() {
    // Find all active notifications
    const notifications = document.querySelectorAll('.custom-notification');
    
    notifications.forEach(notification => {
        // Check if this notification needed focus
        const needsFocus = notification.getAttribute('data-needs-focus') === 'true';
        
        // Add hide class
        notification.classList.add('hide');
        
        // If any notification needed focus, disable it
        if (needsFocus) {
            fetch(`https://${GetParentResourceName()}/disableFocus`, {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json; charset=UTF-8',
                },
                body: JSON.stringify({})
            }).catch(error => {
                console.error('Error disabling focus:', error);
            });
        }
        
        // Remove from DOM after animation
        setTimeout(() => {
            if (notification.parentNode) {
                notification.parentNode.removeChild(notification);
            }
        }, 400);
    });
}

function handleNotificationAction(action, data, notifId) {
    switch (action) {
        case 'acceptInvite':
            fetch(`https://${GetParentResourceName()}/acceptInvite`, {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json; charset=UTF-8',
                },
                body: JSON.stringify({
                    lobbyId: data.lobbyId,
                    fromPlayerId: data.fromPlayerId
                })
            });
            closeNotification(notifId);
            break;
            
        case 'declineInvite':
            fetch(`https://${GetParentResourceName()}/declineInvite`, {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json; charset=UTF-8',
                },
                body: JSON.stringify({
                    lobbyId: data.lobbyId,
                    fromPlayerId: data.fromPlayerId
                })
            });
            closeNotification(notifId);
            break;
            
        case 'openLobby':
            // Open lobby interface if not already open
            if (lobbyContainer.classList.contains('hidden')) {
                fetch(`https://${GetParentResourceName()}/openLobby`, {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/json; charset=UTF-8',
                    },
                    body: JSON.stringify({})
                });
            }
            closeNotification(notifId);
            break;
            
        case 'createLobby':
            // Create a new lobby
            fetch(`https://${GetParentResourceName()}/createLobby`, {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json; charset=UTF-8',
                },
                body: JSON.stringify({})
            });
            // Close notification (it will handle disabling focus)
            closeNotification(notifId);
            break;
            
        case 'cancelLobby':
            // Close notification first (it will handle disabling focus)
            closeNotification(notifId);
            break;
            
        default:
            closeNotification(notifId);
            break;
    }
}

function kickPlayer(playerId) {
    fetch(`https://${GetParentResourceName()}/kickPlayer`, {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json; charset=UTF-8',
        },
        body: JSON.stringify({
            playerId: playerId
        })
    });
}

function kickPlayerWithConfirm(memberId, memberName) {
    console.log('[KICK] kickPlayerWithConfirm called with:', memberId, memberName);
    
    showCustomConfirm(
        'Kick Member',
        `Are you sure you want to kick ${memberName || 'this player'} from the lobby?`,
        () => {
            console.log('[KICK] Confirm dialog accepted, sending kick request for:', memberId);
            fetch(`https://${GetParentResourceName()}/kickPlayer`, {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json; charset=UTF-8',
                },
                body: JSON.stringify({
                    playerId: memberId
                })
            }).then(() => {
                console.log('[KICK] Kick request sent successfully');
                showCustomNotification('success', 'Member Kicked', `${memberName || 'Player'} has been removed from the lobby.`, null, 4000);
            }).catch(error => {
                console.error('[KICK] Error kicking member:', error);
                showCustomNotification('error', 'Kick Failed', 'Failed to kick member.', null, 5000);
            });
        }
    );
}

function leaveLobby() {
    fetch(`https://${GetParentResourceName()}/leaveLobby`, {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json; charset=UTF-8',
        },
        body: JSON.stringify({})
    });
}

// Helper function to get current player ID (mock for now, should be provided by the game)
function getCurrentPlayerId() {
    // This should be set by the client-side script
    return currentPlayerId || (currentLobby ? currentLobby.members[0] : null);
}

// ================================
//      MEMBER DETAILS SYSTEM
// ================================

// Member Details Modal Elements
const memberDetailsModalContainer = document.getElementById('memberDetailsModalContainer');
const memberDetailsBannerImg = document.getElementById('memberDetailsBannerImg');
const memberDetailsProfileImg = document.getElementById('memberDetailsProfileImg');
const memberDetailsName = document.getElementById('memberDetailsName');
const memberDetailsId = document.getElementById('memberDetailsId');
const memberDetailsRole = document.getElementById('memberDetailsRole');
const memberDetailsBio = document.getElementById('memberDetailsBio');
const memberDetailsActions = document.getElementById('memberDetailsActions');

// Custom Confirm Modal Elements
const customConfirmModal = document.getElementById('customConfirmModal');
const confirmModalTitle = document.getElementById('confirmModalTitle');
const confirmModalMessage = document.getElementById('confirmModalMessage');
const confirmModalCancel = document.getElementById('confirmModalCancel');
const confirmModalConfirm = document.getElementById('confirmModalConfirm');

let currentSelectedMember = null;
let currentConfirmCallback = null;

// Custom Confirm Modal Functions
function showCustomConfirm(title, message, onConfirm, onCancel = null) {
    console.log('[CONFIRM] showCustomConfirm called with:', title, message);
    
    if (!customConfirmModal) {
        console.error('[CONFIRM] customConfirmModal not found!');
        return;
    }
    
    // Set content
    if (confirmModalTitle) {
        confirmModalTitle.textContent = title;
        console.log('[CONFIRM] Title set to:', title);
    } else {
        console.error('[CONFIRM] confirmModalTitle element not found!');
    }
    
    if (confirmModalMessage) {
        confirmModalMessage.textContent = message;
        console.log('[CONFIRM] Message set to:', message);
    } else {
        console.error('[CONFIRM] confirmModalMessage element not found!');
    }
    
    // Store callback
    currentConfirmCallback = onConfirm;
    console.log('[CONFIRM] Callback stored');
    
    // Show modal
    customConfirmModal.classList.remove('hidden');
    console.log('[CONFIRM] Modal should now be visible');
    
    // Setup event listeners
    const handleConfirm = () => {
        console.log('[CONFIRM] Confirm button clicked');
        
        // Store callback before hiding modal (which clears it)
        const callbackToExecute = currentConfirmCallback;
        
        hideCustomConfirm();
        
        if (callbackToExecute) {
            console.log('[CONFIRM] Executing confirm callback');
            callbackToExecute();
        } else {
            console.error('[CONFIRM] No confirm callback found!');
        }
    };
    
    const handleCancel = () => {
        console.log('[CONFIRM] Cancel button clicked');
        hideCustomConfirm();
        if (onCancel) {
            console.log('[CONFIRM] Executing cancel callback');
            onCancel();
        }
    };
    
    // Remove existing listeners
    if (confirmModalConfirm) {
        confirmModalConfirm.replaceWith(confirmModalConfirm.cloneNode(true));
        const newConfirmBtn = document.getElementById('confirmModalConfirm');
        newConfirmBtn.addEventListener('click', handleConfirm);
    }
    
    if (confirmModalCancel) {
        confirmModalCancel.replaceWith(confirmModalCancel.cloneNode(true));
        const newCancelBtn = document.getElementById('confirmModalCancel');
        newCancelBtn.addEventListener('click', handleCancel);
    }
    
    // Close on overlay click
    const overlay = customConfirmModal.querySelector('.custom-confirm-modal-overlay');
    if (overlay) {
        overlay.replaceWith(overlay.cloneNode(true));
        const newOverlay = customConfirmModal.querySelector('.custom-confirm-modal-overlay');
        newOverlay.addEventListener('click', handleCancel);
    }
}

function hideCustomConfirm() {
    console.log('[CONFIRM] hideCustomConfirm called');
    if (customConfirmModal) {
        customConfirmModal.classList.add('hidden');
        console.log('[CONFIRM] Modal hidden');
    } else {
        console.error('[CONFIRM] customConfirmModal not found when hiding!');
    }
    currentConfirmCallback = null;
}

// Open Member Details Modal
function openMemberDetailsModal(memberId, memberProfile, memberName, isOwner) {
    console.log('Opening member details for:', memberId, memberProfile);
    
    if (!memberDetailsModalContainer) {
        console.error('Member details modal container not found');
        return;
    }
    
    currentSelectedMember = {
        id: memberId,
        profile: memberProfile,
        name: memberName,
        isOwner: isOwner
    };
    
    // Update modal content
    const profileImageSrc = memberProfile?.profile_image || 'images/default_profile.png';
    
    if (memberDetailsBannerImg) {
        memberDetailsBannerImg.src = profileImageSrc;
    }
    
    if (memberDetailsProfileImg) {
        memberDetailsProfileImg.src = profileImageSrc;
    }
    
    if (memberDetailsName) {
        memberDetailsName.textContent = memberProfile?.display_name || memberName;
    }
    
    if (memberDetailsId) {
        memberDetailsId.textContent = `ID: ${memberId}`;
    }
    
    if (memberDetailsRole) {
        memberDetailsRole.textContent = isOwner ? 'OWNER' : 'MEMBER';
        memberDetailsRole.className = `member-details-role ${isOwner ? 'owner' : ''}`;
    }
    
    if (memberDetailsBio) {
        memberDetailsBio.textContent = memberProfile?.bio || 'No bio available.';
    }
    
    // Update actions based on current player's permissions
    updateMemberDetailsActions(memberId, isOwner);
    
    memberDetailsModalContainer.classList.remove('hidden');
}

// Close Member Details Modal
function closeMemberDetailsModal() {
    if (memberDetailsModalContainer) {
        memberDetailsModalContainer.classList.add('hidden');
    }
    currentSelectedMember = null;
}

// Update actions based on permissions
function updateMemberDetailsActions(targetMemberId, targetIsOwner) {
    if (!memberDetailsActions) return;
    
    memberDetailsActions.innerHTML = '';
    
    const currentPlayerId = getCurrentPlayerId();
    const isCurrentPlayerOwner = currentLobby && currentLobby.owner === currentPlayerId;
    const isViewingSelf = targetMemberId === currentPlayerId;
    
    // Only show actions if current player is owner and not viewing themselves
    if (isCurrentPlayerOwner && !isViewingSelf) {
        memberDetailsActions.classList.remove('hidden');
        
        // Kick button (always available for non-owners)
        if (!targetIsOwner) {
            const kickBtn = document.createElement('button');
            kickBtn.className = 'member-action-btn kick';
            kickBtn.textContent = 'Kick Member';
            kickBtn.onclick = () => {
                console.log('[KICK DETAILS] Member details kick button clicked for:', targetMemberId);
                console.log('[KICK DETAILS] Current selected member:', currentSelectedMember);
                kickMember(targetMemberId);
            };
            memberDetailsActions.appendChild(kickBtn);
        }
        
        // Promote button (only for non-owners)
        if (!targetIsOwner) {
            const promoteBtn = document.createElement('button');
            promoteBtn.className = 'member-action-btn promote';
            promoteBtn.textContent = 'Transfer Leadership';
            promoteBtn.onclick = () => promoteMember(targetMemberId);
            memberDetailsActions.appendChild(promoteBtn);
        }
    } else {
        memberDetailsActions.classList.add('hidden');
    }
}

// Kick member function
function kickMember(memberId) {
    console.log('[KICK DETAILS] kickMember called with:', memberId);
    console.log('[KICK DETAILS] currentSelectedMember:', currentSelectedMember);
    
    if (!currentSelectedMember) {
        console.error('[KICK DETAILS] No currentSelectedMember, cannot kick');
        return;
    }
    
    const memberName = currentSelectedMember.profile?.display_name || currentSelectedMember.name;
    console.log('[KICK DETAILS] Member name for kick:', memberName);
    
    showCustomConfirm(
        'Kick Member',
        `Are you sure you want to kick ${memberName} from the lobby?`,
        () => {
            console.log('[KICK DETAILS] Confirm dialog accepted, sending kickMember request for:', memberId);
            fetch(`https://${GetParentResourceName()}/kickMember`, {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                },
                body: JSON.stringify({ memberId: memberId })
            }).then(response => response.json())
            .then(data => {
                console.log('[KICK DETAILS] kickMember response:', data);
                if (data.success) {
                    showCustomNotification('success', 'Member Kicked', `${memberName} has been removed from the lobby.`, null, 4000);
                    closeMemberDetailsModal();
                } else {
                    showCustomNotification('error', 'Kick Failed', data.message || 'Failed to kick member.', null, 5000);
                }
            })
            .catch(error => {
                console.error('[KICK DETAILS] Error kicking member:', error);
                showCustomNotification('error', 'Error', 'An error occurred while kicking member.', null, 5000);
            });
        }
    );
}

// Promote member function
function promoteMember(memberId) {
    if (!currentSelectedMember) return;
    
    const memberName = currentSelectedMember.profile?.display_name || currentSelectedMember.name;
    
    showCustomConfirm(
        'Transfer Leadership',
        `Are you sure you want to transfer leadership to ${memberName}? You will lose your owner privileges.`,
        () => {
            fetch(`https://${GetParentResourceName()}/transferLeadership`, {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                },
                body: JSON.stringify({ memberId: memberId })
            }).then(response => response.json())
            .then(data => {
                if (data.success) {
                    showCustomNotification('success', 'Leadership Transferred', `${memberName} is now the lobby owner.`, null, 4000);
                    closeMemberDetailsModal();
                } else {
                    showCustomNotification('error', 'Transfer Failed', data.message || 'Failed to transfer leadership.', null, 5000);
                }
            })
            .catch(error => {
                console.error('Error transferring leadership:', error);
                showCustomNotification('error', 'Error', 'An error occurred while transferring leadership.', null, 5000);
            });
        }
    );
}

// ================================
//        PROFILE SYSTEM
// ================================

// Open Profile Modal
function openProfileModal() {
    console.log('Opening profile modal...');
    
    if (!profileModalContainer) {
        console.error('Profile modal container not found');
        return;
    }
    
    // Enable NUI focus for profile modal
    fetch(`https://${GetParentResourceName()}/enableFocus`, {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json; charset=UTF-8',
        },
        body: JSON.stringify({})
    }).catch(error => {
        console.error('Error enabling focus for profile modal:', error);
    });
    
    profileModalContainer.classList.remove('hidden');
    loadProfileConfig();
    loadCurrentProfile();
}

// Close Profile Modal (keeps focus active for lobby interaction)
function closeProfileModal() {
    console.log('[PROFILE] Closing profile modal but keeping focus for lobby interaction');
    if (profileModalContainer) {
        profileModalContainer.classList.add('hidden');
    }
    
    // Don't disable focus - profile modal is used within lobby which needs focus
    // Focus should only be disabled when completely exiting the lobby
    
    resetProfileForm();
}

// Alias for backward compatibility (both functions now do the same thing)
function closeProfileModalKeepFocus() {
    closeProfileModal();
}

// Load profile configuration from server
function loadProfileConfig() {
    fetch(`https://${GetParentResourceName()}/getProfileConfig`, {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json',
        },
        body: JSON.stringify({})
    }).then(response => response.json())
    .then(data => {
        if (data.success && data.config) {
            profileConfig = data.config;
            populatePresetImages();
        }
    })
    .catch(error => {
        console.error('Error loading profile config:', error);
    });
}

// Populate preset images grid
function populatePresetImages() {
    if (!profileConfig || !profileConfig.images || !presetImagesGrid) return;
    
    presetImagesGrid.innerHTML = '';
    
    // Add default and numbered options
    Object.keys(profileConfig.images).forEach(key => {
        const imagePath = profileConfig.images[key];
        
        const imageOption = document.createElement('div');
        imageOption.className = 'preset-image-option';
        imageOption.dataset.imageKey = key;
        imageOption.dataset.imagePath = imagePath;
        
        const img = document.createElement('img');
        img.src = imagePath;
        img.alt = `Profile ${key}`;
        img.onerror = function() {
            // If image fails to load, show a placeholder
            this.src = 'data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iNTAiIGhlaWdodD0iNTAiIHZpZXdCb3g9IjAgMCA1MCA1MCIgZmlsbD0ibm9uZSIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIj4KPGNpcmNsZSBjeD0iMjUiIGN5PSIyNSIgcj0iMjUiIGZpbGw9IiM0NDQiLz4KPHRleHQgeD0iNTAlIiB5PSI1MCUiIHRleHQtYW5jaG9yPSJtaWRkbGUiIGR5PSIwLjNlbSIgZm9udC1mYW1pbHk9IkFyaWFsIiBmb250LXNpemU9IjEwIiBmaWxsPSIjOTk5Ij4/PC90ZXh0Pgo8L3N2Zz4K';
        };
        
        imageOption.appendChild(img);
        imageOption.addEventListener('click', () => selectPresetImage(key, imagePath));
        
        presetImagesGrid.appendChild(imageOption);
    });
}

// Select preset image
function selectPresetImage(imageKey, imagePath) {
    // Update preview
    if (currentProfileImg) {
        currentProfileImg.src = imagePath;
    }
    
    // Update selection state
    document.querySelectorAll('.preset-image-option').forEach(option => {
        option.classList.remove('selected');
    });
    document.querySelector(`[data-image-key="${imageKey}"]`).classList.add('selected');
    
    // Store selection
    if (!currentProfile) currentProfile = {};
    currentProfile.profile_image = imagePath;
    currentProfile.selectedPreset = imageKey;
}



// Load current profile
function loadCurrentProfile() {
    console.log('Loading current profile...');
    
    fetch(`https://${GetParentResourceName()}/getProfile`, {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json',
        },
        body: JSON.stringify({})
    }).then(response => response.json())
    .then(data => {
        console.log('Profile response received:', data);
        
        if (data.success && data.profile) {
            console.log('Profile data loaded:', data.profile);
            currentProfile = data.profile;
            
            // Update UI
            if (currentProfile.profile_image && currentProfileImg) {
                console.log('Setting profile image in loadCurrentProfile to:', currentProfile.profile_image);
                currentProfileImg.src = currentProfile.profile_image;
                
                // Highlight matching preset if exists
                highlightMatchingPreset(currentProfile.profile_image);
            } else {
                console.log('No profile image or currentProfileImg element not found in loadCurrentProfile');
                console.log('currentProfile.profile_image:', currentProfile.profile_image);
                console.log('currentProfileImg element:', currentProfileImg);
            }
            
            if (currentProfile.display_name && profileNameInput) {
                profileNameInput.value = currentProfile.display_name;
                console.log('Display name set in loadCurrentProfile to:', currentProfile.display_name);
            }
            
            if (currentProfile.bio && profileBioInput) {
                profileBioInput.value = currentProfile.bio;
                console.log('Bio set in loadCurrentProfile to:', currentProfile.bio);
            }
        } else {
            // Set defaults
            currentProfile = {
                profile_image: 'images/default_profile.png',
                display_name: '',
                bio: ''
            };
        }
    })
    .catch(error => {
        console.error('Error loading profile:', error);
        showCustomNotification('error', 'Load Error', 'Failed to load profile data.', null, 4000);
    });
}

// Save profile
function saveProfile() {
    const saveBtn = document.querySelector('.save-profile-btn');
    saveBtn.classList.add('loading');
    saveBtn.textContent = '';
    
    const profileData = {
        display_name: profileNameInput ? profileNameInput.value.trim() : '',
        bio: profileBioInput ? profileBioInput.value.trim() : ''
    };
    
    // Add image if changed (preset selection)
    if (currentProfile && currentProfile.profile_image) {
        profileData.profile_image = currentProfile.profile_image;
    }
    
    // Validate data
    if (profileData.display_name.length > 50) {
        showSaveError('Display name must be 50 characters or less.');
        return;
    }
    
    if (profileData.bio.length > 200) {
        showSaveError('Bio must be 200 characters or less.');
        return;
    }
    
    // Add timeout as failsafe
    const saveTimeout = setTimeout(() => {
        console.warn('Save timeout - no response from server after 10 seconds');
        const timeoutSaveBtn = document.querySelector('.save-profile-btn');
        if (timeoutSaveBtn && timeoutSaveBtn.classList.contains('loading')) {
            timeoutSaveBtn.classList.remove('loading');
            timeoutSaveBtn.textContent = 'Save Changes';
            showSaveError('Save timeout - please try again.');
        }
    }, 10000);
    
    // Store timeout to clear it if we get response
    window.currentSaveTimeout = saveTimeout;
    
    // Save profile data directly (no upload needed)
    saveProfileData(profileData);
}



// Save profile data
function saveProfileData(profileData) {
    const dataToSend = {
        display_name: profileData.display_name,
        bio: profileData.bio
    };
    
    if (profileData.profile_image) {
        dataToSend.profile_image = profileData.profile_image;
    }
    
    console.log('Sending profile data:', dataToSend);
    
    fetch(`https://${GetParentResourceName()}/saveProfile`, {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json',
        },
        body: JSON.stringify(dataToSend)
    })
    .then(response => response.json())
    .then(data => {
        console.log('Save profile fetch response:', data);
        // Don't handle success/failure here - wait for profileUpdateResult event
        // The server will send TriggerClientEvent with the actual result
    })
    .catch(error => {
        console.error('Error saving profile:', error);
        showSaveError('An error occurred while saving.');
    });
}

// Show save error
function showSaveError(message) {
    console.log('showSaveError called with message:', message);
    console.log('Calling showCustomNotification with error type');
    showCustomNotification('error', 'Save Failed', message, null, 5000);
}

// Highlight matching preset image
function highlightMatchingPreset(imagePath) {
    // Clear all selections
    document.querySelectorAll('.preset-image-option').forEach(option => {
        option.classList.remove('selected');
    });
    
    // Find and highlight matching preset
    const matchingOption = document.querySelector(`[data-image-path="${imagePath}"]`);
    if (matchingOption) {
        matchingOption.classList.add('selected');
    }
}

// Reset profile form
function resetProfileForm() {
    if (profileNameInput) profileNameInput.value = '';
    if (profileBioInput) profileBioInput.value = '';
    if (currentProfileImg) currentProfileImg.src = 'images/default_profile.png';
    currentProfile = null;
    
    // Clear preset selections
    document.querySelectorAll('.preset-image-option').forEach(option => {
        option.classList.remove('selected');
    });
    
    const saveBtn = document.querySelector('.save-profile-btn');
    saveBtn.classList.remove('loading');
    saveBtn.textContent = 'Save Changes';
}

// Character counter for inputs
function setupCharacterCounters() {
    function updateCounter(input, maxLength) {
        const counter = input.parentElement.querySelector('.char-counter') || 
                       (() => {
                           const counter = document.createElement('div');
                           counter.className = 'char-counter';
                           counter.style.cssText = `
                               position: absolute;
                               bottom: -18px;
                               right: 0;
                               font-size: 11px;
                               color: var(--dial-text-secondary);
                           `;
                           input.parentElement.appendChild(counter);
                           return counter;
                       })();
        
        const currentLength = input.value.length;
        counter.textContent = `${currentLength}/${maxLength}`;
        
        if (currentLength > maxLength * 0.9) {
            counter.style.color = 'var(--dial-text-found)';
        } else {
            counter.style.color = 'var(--dial-text-secondary)';
        }
    }
    
    if (profileNameInput && profileBioInput) {
        profileNameInput.addEventListener('input', () => updateCounter(profileNameInput, 50));
        profileBioInput.addEventListener('input', () => updateCounter(profileBioInput, 200));
    }
}

// Initialize profile system
document.addEventListener('DOMContentLoaded', function() {
    setupCharacterCounters();
});

// Resource name helper
function GetParentResourceName() {
    return window.location.hostname === 'nui-game-internal' ? 'bank_lobby' : 'bank_lobby';
}
