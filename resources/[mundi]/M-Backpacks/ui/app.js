// M-Backpacks UI Controller

let currentBackpackData = null;
let isDragging = false;
let draggedItem = null;

// ================================================================================================
// MESSAGE HANDLER
// ================================================================================================

window.addEventListener('message', function(event) {
    const data = event.data;
    
    switch(data.action) {
        case 'open':
            openBackpack(data.backpackData, data.config);
            break;
        case 'close':
            closeBackpack();
            break;
        case 'refresh':
            refreshBackpack(data.backpackData);
            break;
        case 'itemDragging':
            handleItemDragging(data.item, data.isDragging);
            break;
    }
});

// ================================================================================================
// UI FUNCTIONS
// ================================================================================================

function openBackpack(backpackData, config) {
    currentBackpackData = backpackData;
    
    // Update header
    document.getElementById('backpack-title').textContent = backpackData.label;
    document.getElementById('backpack-tier').textContent = `Tier ${backpackData.tier}`;
    
    // Update usage info
    updateUsageDisplay(backpackData);
    
    // Populate items
    populateItems(backpackData.contents);
    
    // Show container
    document.getElementById('backpack-container').classList.remove('hidden');
}

function closeBackpack() {
    document.getElementById('backpack-container').classList.add('hidden');
    currentBackpackData = null;
    
    // Notify Lua
    fetch(`https://${GetParentResourceName()}/close`, {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify({})
    });
}

function refreshBackpack(backpackData) {
    if (!currentBackpackData) return;
    
    // Update current data
    currentBackpackData.usedSlots = backpackData.usedSlots;
    currentBackpackData.usedWeight = backpackData.usedWeight;
    currentBackpackData.contents = backpackData.contents;
    
    // Update display
    updateUsageDisplay(currentBackpackData);
    populateItems(backpackData.contents);
}

function updateUsageDisplay(backpackData) {
    // Slots
    const slotsText = `${backpackData.usedSlots}/${backpackData.slots}`;
    document.getElementById('slots-usage').textContent = slotsText;
    
    // Weight
    const weightText = `${backpackData.usedWeight.toFixed(1)}/${backpackData.weight} kg`;
    document.getElementById('weight-usage').textContent = weightText;
    
    // Color coding
    const slotsElement = document.getElementById('slots-usage');
    const weightElement = document.getElementById('weight-usage');
    
    // Slots color
    const slotPercent = (backpackData.usedSlots / backpackData.slots) * 100;
    if (slotPercent >= 90) {
        slotsElement.style.color = '#ff4444';
    } else if (slotPercent >= 70) {
        slotsElement.style.color = '#ffaa00';
    } else {
        slotsElement.style.color = '#fff';
    }
    
    // Weight color
    const weightPercent = (backpackData.usedWeight / backpackData.weight) * 100;
    if (weightPercent >= 90) {
        weightElement.style.color = '#ff4444';
    } else if (weightPercent >= 70) {
        weightElement.style.color = '#ffaa00';
    } else {
        weightElement.style.color = '#fff';
    }
}

function populateItems(contents) {
    const grid = document.getElementById('items-grid');
    grid.innerHTML = '';
    
    if (!contents || contents.length === 0) {
        grid.innerHTML = `
            <div class="empty-message">
                <p>Backpack is empty</p>
                <small>Open your inventory to add items</small>
            </div>
        `;
        return;
    }
    
    contents.forEach(item => {
        const itemCard = createItemCard(item);
        grid.appendChild(itemCard);
    });
}

function createItemCard(item) {
    const card = document.createElement('div');
    card.className = 'item-card';
    card.onclick = () => moveItemFromBackpack(item.name, item.amount);
    
    const itemWeight = (item.weight || 0) * item.amount;
    
    card.innerHTML = `
        <div class="item-name" title="${item.label}">${item.label}</div>
        <div class="item-amount">Amount: ${item.amount}</div>
        <div class="item-weight">Weight: ${itemWeight.toFixed(1)} kg</div>
    `;
    
    return card;
}

// ================================================================================================
// ITEM OPERATIONS
// ================================================================================================

function moveItemFromBackpack(itemName, maxAmount) {
    // For now, move the entire stack
    // TODO: Add amount selector dialog
    const amount = maxAmount;
    
    fetch(`https://${GetParentResourceName()}/moveFromBackpack`, {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify({
            itemName: itemName,
            amount: amount
        })
    });
}

// This function would be called from inventory system
function moveItemToBackpack(itemName, amount) {
    fetch(`https://${GetParentResourceName()}/moveToBackpack`, {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify({
            itemName: itemName,
            amount: amount
        })
    });
}

// ================================================================================================
// DRAG AND DROP HANDLERS
// ================================================================================================

function handleItemDragging(item, dragging) {
    isDragging = dragging;
    draggedItem = item;
    
    const dropZone = document.getElementById('drop-zone');
    const backpackWindow = document.querySelector('.backpack-window');
    
    if (dragging) {
        dropZone.classList.add('active');
        backpackWindow.classList.add('drag-over');
    } else {
        dropZone.classList.remove('active');
        backpackWindow.classList.remove('drag-over');
    }
}

// Listen for drag events from VORP inventory
document.addEventListener('dragover', function(event) {
    if (!currentBackpackData) return;
    event.preventDefault();
});

document.addEventListener('drop', function(event) {
    if (!currentBackpackData) return;
    event.preventDefault();
    
    if (draggedItem) {
        // Item dropped on backpack
        moveItemToBackpack(draggedItem.name, draggedItem.amount);
        draggedItem = null;
    }
    
    const dropZone = document.getElementById('drop-zone');
    const backpackWindow = document.querySelector('.backpack-window');
    dropZone.classList.remove('active');
    backpackWindow.classList.remove('drag-over');
});

// Setup drop zone after DOM loads
window.addEventListener('DOMContentLoaded', function() {
    const backpackWindow = document.querySelector('.backpack-window');
    if (backpackWindow) {
        backpackWindow.addEventListener('dragenter', function(event) {
            event.preventDefault();
            if (isDragging) {
                this.classList.add('drag-over');
            }
        });
        
        backpackWindow.addEventListener('dragleave', function(event) {
            event.preventDefault();
            this.classList.remove('drag-over');
        });
    }
});

// ================================================================================================
// KEYBOARD HANDLER
// ================================================================================================

document.addEventListener('keydown', function(event) {
    if (event.key === 'Escape') {
        closeBackpack();
    }
});

// ================================================================================================
// HELPER FUNCTIONS
// ================================================================================================

function GetParentResourceName() {
    return 'M-Backpacks';
}
