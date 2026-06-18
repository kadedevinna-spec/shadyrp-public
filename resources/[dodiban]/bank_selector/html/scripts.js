class BankSelector {
    constructor() {
        this.isOpen = false;
        this.banks = [];
        this.selectedBank = null;
        this.autoCloseTimer = null;
        this.currentBankData = null;
        this.photoModalOpen = false;
        this.photoExamineOpen = false;
        
        this.initializeElements();
        this.setupEventListeners();
        this.setupMessageListener();
    }

    initializeElements() {
        this.overlay = document.getElementById('bankSelector');
        this.closeBtn = document.getElementById('closeBtn');
        this.banksGrid = document.getElementById('banksGrid');
        this.bankCardTemplate = document.getElementById('bankCardTemplate');
        
        // Photo modal elements
        this.photoModal = document.getElementById('photoModal');
        this.closePhotoModal = document.getElementById('closePhotoModal');
        this.photosTable = document.getElementById('photosTable');
        this.proceedBtn = document.getElementById('proceedBtn');
        
        // Photo examine elements
        this.photoExamineView = document.getElementById('photoExamineView');
        this.examinedPhoto = document.getElementById('examinedPhoto');
        this.photoTitle = document.getElementById('photoTitle');
        this.photoDescription = document.getElementById('photoDescription');
        this.backToTable = document.getElementById('backToTable');
        
        // Lobby elements
        this.lobbySection = document.getElementById('lobbySection');
        this.instructionsSection = document.getElementById('instructionsSection');
        this.createLobbyBtn = document.getElementById('createLobbyBtn');
    }

    setupEventListeners() {
        // Close button
        this.closeBtn.addEventListener('click', () => {
            this.close();
        });

        // Close on overlay click (outside container)
        this.overlay.addEventListener('click', (e) => {
            if (e.target === this.overlay) {
                this.close();
            }
        });

        // ESC key to close
        document.addEventListener('keydown', (e) => {
            if (e.key === 'Escape') {
                if (this.photoExamineOpen) {
                    this.closePhotoExamine();
                } else if (this.photoModalOpen) {
                    this.closePhotoModalMethod(); // Just close photo modal, not entire UI
                } else if (this.isOpen) {
                    this.close();
                }
            }
        });

        // Photo modal event listeners
        this.closePhotoModal.addEventListener('click', () => {
            this.closePhotoModalMethod(); // Just close photo modal, return to bank selector
        });

        this.proceedBtn.addEventListener('click', () => {
            this.proceedWithHeist();
        });

        this.backToTable.addEventListener('click', (e) => {
            e.preventDefault();
            e.stopPropagation();
            this.closePhotoExamine();
        });

        // Create lobby button
        this.createLobbyBtn.addEventListener('click', () => {
            this.createLobby();
        });

        // Close photo modal on overlay click
        this.photoModal.addEventListener('click', (e) => {
            if (e.target === this.photoModal) {
                this.closePhotoModalMethod(); // Just close photo modal, not entire UI
            }
        });

        // Additional close options for better UX
        document.addEventListener('click', (e) => {
            // Don't close if examining a photo
            if (this.photoExamineOpen) {
                return;
            }
            
            if (this.photoModalOpen && !e.target.closest('.photo-modal-container') && !e.target.closest('.photo-scattered')) {
                this.closePhotoModalHandler();
            }
        });

        // Close photo examine on overlay click (but not on photo or info)
        this.photoExamineView.addEventListener('click', (e) => {
            if (e.target === this.photoExamineView) {
                this.closePhotoExamine();
            }
        });
    }

    setupMessageListener() {
        window.addEventListener('message', (event) => {
            const data = event.data;
            
            switch (data.action) {
                case 'openBankSelector':
                    this.open(data.banks, data.config);
                    break;
                case 'closeBankSelector':
                    this.close();
                    break;
                case 'updateBankStatus':
                    this.updateBankStatus(data.bankId, data.status);
                    break;
                case 'updateLobbyStatus':
                    this.updateLobbyStatus(data.hasLobby);
                    break;
            }
        });
    }

    open(banks, config = {}) {
        if (this.isOpen) return;
        
        this.banks = banks;
        this.config = config;
        this.isOpen = true;
        
        this.renderBanks();
        this.checkLobbyStatus();
        this.show();
        this.startAutoCloseTimer();
        
        // Enable cursor
        this.sendMessage('enableCursor');
    }

    close() {
        if (!this.isOpen) return;
        
        this.isOpen = false;
        this.selectedBank = null;
        this.clearAutoCloseTimer();
        this.hide();
        
        // Disable cursor and send close event
        this.sendMessage('disableCursor');
        this.sendMessage('bankSelectorClosed');
    }

    show() {
        this.overlay.style.display = 'flex';
        setTimeout(() => {
            this.overlay.classList.add('show');
        }, 10);
    }

    hide() {
        this.overlay.classList.remove('show');
        setTimeout(() => {
            this.overlay.style.display = 'none';
        }, 300);
    }

    renderBanks() {
        this.banksGrid.innerHTML = '';
        
        this.banks.forEach(bank => {
            const bankCard = this.createBankCard(bank);
            this.banksGrid.appendChild(bankCard);
        });
    }

    createBankCard(bank) {
        const template = this.bankCardTemplate.content.cloneNode(true);
        const card = template.querySelector('.bank-card');
        
        // Set bank ID
        card.setAttribute('data-bank-id', bank.id);
        
        // Set image
        const img = template.querySelector('.bank-image img');
        img.src = `images/${bank.image}`;
        img.alt = bank.name;
        
        // Set difficulty badge
        const difficultyBadge = template.querySelector('.difficulty-badge');
        const difficultyText = template.querySelector('.difficulty-text');
        difficultyText.textContent = bank.difficulty;
        difficultyBadge.classList.add(bank.difficulty.toLowerCase());
        
        // Set bank info
        template.querySelector('.bank-name').textContent = bank.name;
        template.querySelector('.bank-description').textContent = bank.description;
        
        // Set details
        template.querySelector('.reward-amount').textContent = `$${bank.reward_range.min} - $${bank.reward_range.max}`;
        template.querySelector('.required-players').textContent = bank.required_players;
        template.querySelector('.security-level').textContent = '★'.repeat(bank.security_level);
        
        // Set status
        const statusText = template.querySelector('.status-text');
        const cooldownRow = template.querySelector('.cooldown-row');
        
        if (bank.status) {
            this.updateCardStatus(card, bank.status, bank.cooldown_remaining);
        } else {
            if (statusText) {
                statusText.textContent = 'Available';
                statusText.className = 'status-text available';
            }
        }
        
        // Add click handler
        const selectBtn = template.querySelector('.select-btn');
        selectBtn.addEventListener('click', (e) => {
            e.stopPropagation();
            this.selectBank(bank);
        });
        
        card.addEventListener('click', () => {
            if (!card.classList.contains('disabled')) {
                this.selectBank(bank);
            }
        });
        
        return template;
    }

    updateCardStatus(cardElement, status, cooldownRemaining = null) {
        let card;
        
        // Determine if we have a card element or need to find it
        if (cardElement.classList && cardElement.classList.contains('bank-card')) {
            card = cardElement;
        } else if (cardElement.querySelector) {
            card = cardElement.querySelector('.bank-card');
        } else {
            card = cardElement.closest('.bank-card');
        }
        
        if (!card) {
            console.error('Could not find bank card element');
            return;
        }
        
        const statusText = card.querySelector('.status-text');
        const cooldownRow = card.querySelector('.cooldown-row');
        const cooldownTime = card.querySelector('.cooldown-time');
        
        if (!statusText) {
            console.error('Could not find status text element');
            return;
        }
        
        switch (status) {
            case 'available':
                statusText.textContent = 'Available';
                statusText.className = 'status-text available';
                if (cooldownRow) cooldownRow.style.display = 'none';
                card.classList.remove('disabled');
                break;
                
            case 'cooldown':
                statusText.textContent = 'On Cooldown';
                statusText.className = 'status-text cooldown';
                if (cooldownRemaining && cooldownRow && cooldownTime) {
                    cooldownRow.style.display = 'flex';
                    cooldownTime.textContent = this.formatTime(cooldownRemaining);
                }
                card.classList.add('disabled');
                break;
                
            case 'unavailable':
                statusText.textContent = 'Unavailable';
                statusText.className = 'status-text unavailable';
                if (cooldownRow) cooldownRow.style.display = 'none';
                card.classList.add('disabled');
                break;
        }
    }

    updateBankStatus(bankId, status) {
        const card = document.querySelector(`[data-bank-id="${bankId}"]`);
        if (card) {
            this.updateCardStatus(card, status.status, status.cooldown_remaining);
        }
    }

    selectBank(bank) {
        if (bank.status === 'cooldown' || bank.status === 'unavailable') {
            return;
        }
        
        this.selectedBank = bank;
        this.currentBankData = bank;
        
        // Add selection feedback
        this.addSelectionFeedback(bank.id);
        
        // Open photo modal instead of immediately closing
        setTimeout(() => {
            this.openPhotoModal(bank);
        }, 200);
    }

    addSelectionFeedback(bankId) {
        const card = document.querySelector(`[data-bank-id="${bankId}"]`);
        if (card) {
            card.style.transform = 'scale(0.95)';
            card.style.filter = 'brightness(1.2)';
            
            setTimeout(() => {
                card.style.transform = '';
                card.style.filter = '';
            }, 200);
        }
    }

    startAutoCloseTimer() {
        if (this.config.auto_close_delay && this.config.auto_close_delay > 0) {
            this.autoCloseTimer = setTimeout(() => {
                this.close();
            }, this.config.auto_close_delay);
        }
    }

    clearAutoCloseTimer() {
        if (this.autoCloseTimer) {
            clearTimeout(this.autoCloseTimer);
            this.autoCloseTimer = null;
        }
    }

    formatTime(seconds) {
        const minutes = Math.floor(seconds / 60);
        const remainingSeconds = seconds % 60;
        
        if (minutes > 0) {
            return `${minutes}m ${remainingSeconds}s`;
        } else {
            return `${remainingSeconds}s`;
        }
    }

    sendMessage(action, data = {}) {
        const resourceName = this.getResourceName();
        fetch(`https://${resourceName}/${action}`, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify(data)
        }).catch(() => {
            // Ignore fetch errors in non-game environment
        });
    }

    getResourceName() {
        // Simple method to get resource name
        return 'bank_selector';
    }

    // Photo Modal Methods
    openPhotoModal(bankData) {
        if (!bankData.photos || bankData.photos.length === 0) {
            // No photos available, proceed directly
            this.proceedWithHeist();
            return;
        }

        this.photoModalOpen = true;
        this.currentBankData = bankData;
        
        this.renderPhotos(bankData.photos);
        this.showPhotoModal();
    }

    showPhotoModal() {
        this.photoModal.style.display = 'flex';
        setTimeout(() => {
            this.photoModal.classList.add('show');
        }, 10);
    }

    closePhotoModalHandler() {
        this.closePhotoModalMethod();
        // Don't close main bank selector, just return to it
    }

    closePhotoModalMethod() {
        if (!this.photoModalOpen) return;
        
        this.photoModalOpen = false;
        this.photoModal.classList.remove('show');
        setTimeout(() => {
            this.photoModal.style.display = 'none';
        }, 300);
    }

    // Method to close only photo modal and return to bank selector
    closePhotoModalOnly() {
        this.closePhotoModalMethod();
        // Don't close the main bank selector, just return to it
    }

    renderPhotos(photos) {
        this.photosTable.innerHTML = '';
        
        console.log(`Rendering ${photos.length} photos:`, photos);
        
        photos.forEach((photo, index) => {
            console.log(`Creating photo ${index}:`, photo.title);
            const photoElement = this.createPhotoElement(photo, index);
            this.photosTable.appendChild(photoElement);
        });
    }

    createPhotoElement(photo, index) {
        const photoDiv = document.createElement('div');
        photoDiv.className = 'photo-scattered';
        photoDiv.setAttribute('data-photo-id', photo.id);
        
        // Get table dimensions
        const tableWidth = 1400;
        const tableHeight = 500;
        
        let x, y, rotation;
        
        // Use configured position if available, otherwise use automatic positioning
        if (photo.position) {
            // Use pixel positions directly - adjust for center positioning
            x = photo.position.x - (tableWidth / 2);
            y = photo.position.y - (tableHeight / 2);
            rotation = photo.position.rotation || 0;
        } else {
            // Better distribution to ensure all photos are visible
            const positions = [
                {x: -150, y: -100, rotation: -15},  // Top left
                {x: 150, y: -100, rotation: 12},   // Top right
                {x: -150, y: 100, rotation: 8},    // Bottom left
                {x: 150, y: 100, rotation: -10}    // Bottom right
            ];
            
            const pos = positions[index % positions.length];
            x = pos.x + (Math.random() * 50 - 25); // Small random variation
            y = pos.y + (Math.random() * 50 - 25);
            rotation = pos.rotation + (Math.random() * 10 - 5);
        }
        
        // Set initial position and rotation (centered relative to table center)
        const tableCenterX = tableWidth / 2;
        const tableCenterY = tableHeight / 2;
        
        photoDiv.style.top = `${tableCenterY + y}px`;
        photoDiv.style.left = `${tableCenterX + x}px`;
        photoDiv.style.transform = `translate(-50%, -50%) rotate(${rotation}deg)`;
        
        // Add animation delay for staggered effect
        photoDiv.style.animationDelay = `${index * 0.3}s`;
        
        console.log(`Photo ${index} positioned at:`, {
            x: tableCenterX + x,
            y: tableCenterY + y,
            rotation: rotation,
            delay: `${index * 0.3}s`
        });
        
        photoDiv.innerHTML = `
            <img src="images/${photo.image}" alt="${photo.title}">
            <div class="photo-label">${photo.title}</div>
        `;
        
        // Add drag functionality
        this.makeDraggable(photoDiv);
        
        // Add double-click handler to examine photo (instead of single click to avoid conflict with drag)
        photoDiv.addEventListener('dblclick', () => {
            this.examinePhoto(photo);
        });
        
        return photoDiv;
    }

    // Make photos draggable
    makeDraggable(element) {
        let previousTouch = undefined;

        const updateElementPosition = (event) => {
            let movementX, movementY;

            if (event.type === 'touchmove') {
                const touch = event.touches[0];
                movementX = previousTouch ? touch.clientX - previousTouch.clientX : 0;
                movementY = previousTouch ? touch.clientY - previousTouch.clientY : 0;
                previousTouch = touch;
            } else {
                movementX = event.movementX;
                movementY = event.movementY;
            }
            
            const elementY = parseInt(element.style.top || 0) + movementY;
            const elementX = parseInt(element.style.left || 0) + movementX;

            element.style.top = elementY + "px";
            element.style.left = elementX + "px";
        };

        const startDrag = (event) => {
            event.preventDefault();
            element.style.zIndex = 1000; // Bring to front
            
            const updateFunction = (event) => updateElementPosition(event);
            const stopFunction = () => {
                previousTouch = undefined;
                element.style.zIndex = ''; // Reset z-index
                document.removeEventListener("mousemove", updateFunction);
                document.removeEventListener("touchmove", updateFunction);
                document.removeEventListener("mouseup", stopFunction);
                document.removeEventListener("touchend", stopFunction);
            };
            
            document.addEventListener("mousemove", updateFunction);
            document.addEventListener("touchmove", updateFunction);
            document.addEventListener("mouseup", stopFunction);
            document.addEventListener("touchend", stopFunction);
        };

        element.addEventListener("mousedown", startDrag);
        element.addEventListener("touchstart", startDrag);
    }

    examinePhoto(photo) {
        this.photoExamineOpen = true;
        
        // Create photo stack with 3 variations of the selected photo
        this.createPhotoStack(photo);
        
        // Set initial info to the selected photo
        this.photoTitle.textContent = photo.title;
        this.photoDescription.textContent = photo.description;
        
        this.showPhotoExamine();
    }

    createPhotoStack(selectedPhoto) {
        const photoStack = document.getElementById('photoStack');
        photoStack.innerHTML = '';
        
        // Use the stack_photos from the selected photo category
        let stackPhotos = [];
        
        if (selectedPhoto.stack_photos && selectedPhoto.stack_photos.length > 0) {
            // Use the specific stack photos for this category
            stackPhotos = selectedPhoto.stack_photos;
        } else {
            // Fallback: create stack with main photo and variations
            stackPhotos = [
                selectedPhoto,
                selectedPhoto,
                selectedPhoto
            ];
        }
        
        // Create HTML for each photo in stack
        stackPhotos.forEach((photo, index) => {
            const photoElement = document.createElement('div');
            photoElement.className = 'stack-photo';
            photoElement.innerHTML = `<img src="images/${photo.image}" alt="${photo.title}">`;
            
            // Add hover handler to update info
            photoElement.addEventListener('mouseenter', () => {
                this.photoTitle.textContent = photo.title;
                this.photoDescription.textContent = photo.description;
            });
            
            // Add click handler for closer examination
            photoElement.addEventListener('click', () => {
                this.photoTitle.textContent = photo.title;
                this.photoDescription.textContent = photo.description;
                // Could add additional effects here
            });
            
            photoStack.appendChild(photoElement);
        });
    }

    showPhotoExamine() {
        this.photoExamineView.style.display = 'flex';
        setTimeout(() => {
            this.photoExamineView.classList.add('show');
        }, 10);
    }

    closePhotoExamine() {
        if (!this.photoExamineOpen) return;
        
        this.photoExamineOpen = false;
        this.photoExamineView.classList.remove('show');
        setTimeout(() => {
            this.photoExamineView.style.display = 'none';
        }, 300);
        
        // Don't close anything else, just return to photo modal
    }

    proceedWithHeist() {
        if (!this.currentBankData) return;
        
        // Send selection to client
        this.sendMessage('bankSelected', {
            bankId: this.currentBankData.id,
            bankData: this.currentBankData
        });
        
        // Close all modals
        this.closePhotoModalMethod();
        this.closePhotoExamine();
        this.close();
    }

    // Lobby system functions
    checkLobbyStatus() {
        // Request lobby status from client
        this.sendMessage('checkLobbyStatus');
    }

    updateLobbyStatus(hasLobby) {
        if (hasLobby) {
            // Player has lobby - show normal instructions
            this.lobbySection.style.display = 'none';
            this.instructionsSection.style.display = 'block';
            
            // Enable bank selection
            this.banksGrid.style.pointerEvents = 'auto';
            this.banksGrid.style.opacity = '1';
        } else {
            // Player doesn't have lobby - show lobby creation button
            this.lobbySection.style.display = 'block';
            this.instructionsSection.style.display = 'none';
            
            // Disable bank selection
            this.banksGrid.style.pointerEvents = 'none';
            this.banksGrid.style.opacity = '0.5';
        }
    }

    createLobby() {
        // Send create lobby request to client
        this.sendMessage('createLobby');
        
        // Close bank selector
        this.close();
    }
}

// Simple fallback for compatibility
function GetParentResourceName() {
    return 'bank_selector';
}

// Initialize the bank selector when DOM is loaded
document.addEventListener('DOMContentLoaded', () => {
    window.bankSelector = new BankSelector();
});

// Expose for debugging
window.BankSelector = BankSelector;
