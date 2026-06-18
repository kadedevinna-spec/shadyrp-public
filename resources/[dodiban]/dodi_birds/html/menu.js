// Temporary variable to store purchased birds
let purchasedBirds = [];
let birdIdCounter = 1; // Counter to assign unique IDs

// Variáveis para armazenar informações de oferta
let currentOffer = null;

// Variáveis para armazenar o ID do pássaro a ser vendido
let birdToSellId = null;

// Variaveis para armazenar informacoes do passaro a ser comprado
let birdToBuy = null;
let selectedOutfit = 0;

// Notification queue
let notificationQueue = [];
const maxNotifications = 4;

// ============================================
// NOTIFICATION SYSTEM
// ============================================

function showNotification(options) {
    let container = document.getElementById("notifications-container");
    
    // Create container if it doesn't exist
    if (!container) {
        console.log("[Notifications] Creating container...");
        container = document.createElement("div");
        container.id = "notifications-container";
        document.body.appendChild(container);
    }
    
    // Force container styles
    container.style.cssText = `
        position: fixed !important;
        top: 20px !important;
        right: 20px !important;
        width: 350px !important;
        display: flex !important;
        flex-direction: column !important;
        gap: 12px !important;
        z-index: 999999 !important;
        pointer-events: none !important;
        visibility: visible !important;
        opacity: 1 !important;
    `;
    
    console.log("[Notifications] Container found, showing notification:", options);
    
    const {
        title = "Notification",
        message = "",
        type = "success",
        icon = "images/animal1.png",
        duration = 4000
    } = options;
    
    // Create notification element
    const notification = document.createElement("div");
    notification.classList.add("notification", `notification-${type}`);
    
    // Force inline styles to ensure visibility
    notification.style.cssText = `
        display: flex !important;
        visibility: visible !important;
        opacity: 1 !important;
        background: linear-gradient(135deg, #1a1a1a 0%, #2d2d2d 100%) !important;
        border: 1px solid #3a3a3a !important;
        border-radius: 10px !important;
        padding: 16px 20px !important;
        box-shadow: 0 10px 40px rgba(0, 0, 0, 0.8) !important;
        color: white !important;
        min-width: 300px !important;
        position: relative !important;
    `;
    
    notification.innerHTML = `
        <div class="notification-icon" style="width:55px;height:55px;flex-shrink:0;display:flex;align-items:center;justify-content:center;background:radial-gradient(circle,#252525 0%,#1a1a1a 100%);border-radius:50%;border:2px solid #3a3a3a;margin-right:15px;">
            <img src="${icon}" alt="icon" style="width:35px;height:35px;object-fit:contain;">
        </div>
        <div class="notification-content" style="flex:1;">
            <div class="notification-title" style="font-size:15px;font-weight:bold;color:white;margin-bottom:4px;">${title}</div>
            <div class="notification-message" style="font-size:13px;color:#b0b0b0;">${message}</div>
        </div>
        <div class="notification-progress" style="position:absolute;bottom:0;left:0;height:3px;background:linear-gradient(90deg,#d4af37,#f4d03f);animation:notification-progress ${duration}ms linear forwards;"></div>
    `;
    
    // Add progress bar animation style if not exists
    if (!document.querySelector('style[data-notification-progress]')) {
        const style = document.createElement("style");
        style.setAttribute('data-notification-progress', 'true');
        style.textContent = `
            @keyframes notification-progress {
                0% { width: 100%; }
                100% { width: 0%; }
            }
        `;
        document.head.appendChild(style);
    }
    
    // Add to container
    container.appendChild(notification);
    notificationQueue.push(notification);
    
    console.log("[Notifications] Notification added to container. Total:", notificationQueue.length);
    
    // Remove old notifications if too many
    while (notificationQueue.length > maxNotifications) {
        const oldNotification = notificationQueue.shift();
        if (oldNotification && oldNotification.parentNode) {
            oldNotification.classList.add("hiding");
            setTimeout(() => {
                if (oldNotification.parentNode) {
                    oldNotification.parentNode.removeChild(oldNotification);
                }
            }, 400);
        }
    }
    
    // Auto remove after duration
    setTimeout(() => {
        if (notification.parentNode) {
            notification.classList.add("hiding");
            setTimeout(() => {
                if (notification.parentNode) {
                    notification.parentNode.removeChild(notification);
                }
                const index = notificationQueue.indexOf(notification);
                if (index > -1) {
                    notificationQueue.splice(index, 1);
                }
            }, 400);
        }
    }, duration);
    
    return notification;
}

// XP Gain notification
function showXPNotification(birdName, xpGained) {
    showNotification({
        title: "XP Gained!",
        message: `<strong>${birdName}</strong> earned <span class="xp-value">+${xpGained} XP</span>`,
        type: "xp",
        icon: Config.HomeStats?.trainerLevel?.image || "images/animal2.png",
        duration: 4000
    });
}

// Level Up notification
function showLevelUpNotification(birdName, newLevel) {
    showNotification({
        title: "Level Up!",
        message: `<strong>${birdName}</strong> reached <span class="level-value">Level ${newLevel}</span>!`,
        type: "levelup",
        icon: Config.HomeStats?.trainerLevel?.image || "images/animal2.png",
        duration: 5000
    });
}

// Item received notification
function showItemNotification(itemName) {
    showNotification({
        title: "Item Found!",
        message: `Your bird found: <span class="item-name">${itemName}</span>`,
        type: "item",
        icon: Config.HomeStats?.totalBirds?.image || "images/animal1.png",
        duration: 4000
    });
}

// Training notification
function showTrainingNotification(birdName, status) {
    const messages = {
        start: `<strong>${birdName}</strong> started training...`,
        complete: `<strong>${birdName}</strong> completed training!`,
        cooldown: `<strong>${birdName}</strong> is resting...`
    };
    
    showNotification({
        title: status === "start" ? "Training Started" : status === "complete" ? "Training Complete!" : "Cooldown",
        message: messages[status] || messages.start,
        type: "training",
        icon: Config.HomeStats?.totalBirds?.image || "images/animal1.png",
        duration: 3500
    });
}

// Error notification
function showErrorNotification(message) {
    showNotification({
        title: "Error",
        message: message,
        type: "error",
        icon: "images/animal1.png",
        duration: 4000
    });
}

// Manage tabs
function openTab(tabId) {
    // Hide all tab contents
    document.querySelectorAll('.tab-content').forEach((tab) => {
        tab.classList.remove('active');
    });

    // Remove active state from all buttons
    document.querySelectorAll('.tab-btn').forEach((btn) => {
        btn.classList.remove('active');
    });

    // Show the selected tab
    document.getElementById(tabId).classList.add('active');

    // Set active state to the clicked button
    document.querySelector(`[onclick="openTab('${tabId}')"]`).classList.add('active');
    
    // Carregar conteúdo específico da aba
    if (tabId === 'shop') {
        loadShop("Scavenger"); // Carregar categoria padrão ao abrir shop
    } else if (tabId === 'inventory') {
        loadInventory();
    } else if (tabId === 'home') {
        loadHome();
    }
}

// Simulate buying a bird
function buyBird(birdName, birdType, birdPrice, birdImage, category) {
    // Encontrar o pássaro no Config
    const bird = birdCategories[category].find(b => b.name === birdName);
    
    if (!bird || !bird.outfits) {
        console.error("Pássaro não encontrado ou não possui variantes:", birdName);
        return;
    }
    
    // Armazenar informações do pássaro para compra posterior
    birdToBuy = {
        name: birdName,
        type: birdType,
        level: 1,
        xp: "0 / 100",
        price: birdPrice,
        image: birdImage,
        nickname: "(no name)",
        outfit: 0 // Valor padrão
    };
    
    // Exibir o modal de seleção de outfit
    const outfitModal = document.getElementById("outfit-selection-modal");
    
    // Exibir a imagem do pássaro
    document.getElementById("bird-preview").innerHTML = `
        <img src="${birdImage}" alt="${birdName}">
        <h3>${birdName}</h3>
    `;
    
    // Exibir as opções de outfit
    const outfitOptions = document.getElementById("outfit-options");
    outfitOptions.innerHTML = "";
    
    bird.outfits.forEach((outfit, index) => {
        const option = document.createElement("div");
        option.classList.add("outfit-option");
        if (index === 0) option.classList.add("selected");
        
        option.innerHTML = `
            <input type="radio" name="outfit" value="${outfit.value}" ${index === 0 ? 'checked' : ''}>
            <span>${outfit.name}</span>
        `;
        
        option.addEventListener("click", () => {
            // Remover a classe 'selected' de todas as opções
            document.querySelectorAll(".outfit-option").forEach(opt => {
                opt.classList.remove("selected");
            });
            
            // Adicionar a classe 'selected' à opção clicada
            option.classList.add("selected");
            
            // Marcar o radio button
            const radio = option.querySelector("input");
            radio.checked = true;
            
            // Atualizar o outfit selecionado
            selectedOutfit = outfit.value;
        });
        
        outfitOptions.appendChild(option);
    });
    
    // Exibir o modal
    outfitModal.style.display = "flex";
}

// Load birds into shop by category
function loadShop(category) {
    const shopList = document.getElementById("shop-list");
    shopList.innerHTML = "";

    const trainerLevel = parseInt(document.getElementById("your-level").innerText, 10);

    if (birdCategories[category]) {
        birdCategories[category].forEach((bird) => {
            const isLocked = trainerLevel < bird.requiredLevel;
            const birdItem = document.createElement("div");
            birdItem.classList.add("bird-item");
            
            if (isLocked) {
                birdItem.classList.add("bird-locked");
                birdItem.innerHTML = `
                    <div class="locked-overlay">
                        <div class="lock-icon">
                            <div class="lock-shackle"></div>
                            <div class="lock-body">
                                <div class="lock-keyhole"></div>
                            </div>
                        </div>
                    </div>
                    <img src="${bird.image}" alt="${bird.name}">
                    <div class="bird-info">
                        <h3>${bird.name}</h3>
                        <p>Type: ${category}</p>
                        <p>Price: $${bird.price}</p>
                        <p class="required-level-locked">Required Level: ${bird.requiredLevel}</p>
                        <button class="buy-btn locked-btn" disabled>Locked</button>
                    </div>
                `;
            } else {
                birdItem.innerHTML = `
                    <img src="${bird.image}" alt="${bird.name}">
                    <div class="bird-info">
                        <h3>${bird.name}</h3>
                        <p>Type: ${category}</p>
                        <p>Price: $${bird.price}</p>
                        <p>Required Level: ${bird.requiredLevel}</p>
                        <button class="buy-btn" onclick="buyBird('${bird.name}', '${category}', ${bird.price}, '${bird.image}', '${category}')">Buy</button>
                    </div>
                `;
            }
            shopList.appendChild(birdItem);
        });

        if (!shopList.hasChildNodes()) {
            shopList.innerHTML = `<p>No birds available in this category.</p>`;
        }
    } else {
        shopList.innerHTML = `<p>No birds available in this category.</p>`;
    }
}

// Load inventory birds dynamically
function loadInventory() {
    const inventoryContainer = document.querySelector('#inventory .bird-list');
    inventoryContainer.innerHTML = ""; // Clear existing items

    if (purchasedBirds.length === 0) {
        inventoryContainer.innerHTML = "<p>No birds in your inventory.</p>";
        return;
    }

    purchasedBirds.forEach((bird) => {
        // Verificar se o pássaro tem um ID válido
        if (!bird.id || isNaN(bird.id)) {
            console.error("Pássaro sem ID válido:", bird);
            return; // Pular este pássaro
        }
        
        const birdItem = document.createElement("div");
        birdItem.classList.add("bird-item");
        birdItem.innerHTML = `
            <img src="${bird.image}" alt="${bird.name}">
            <div class="bird-info">
                <h3>${bird.name}</h3>
                <p>${bird.nickname}</p> <!-- Display nickname -->
                <p>Type: ${bird.type}</p>
                <p>Level: ${bird.level}</p>
                <p>XP: ${bird.xp}</p>
                <button class="manage-btn" onclick="manageBird(${bird.id})">Manage</button>
            </div>
        `;
        inventoryContainer.appendChild(birdItem);
    });

    loadHome(); // Update the home summary as well
}

// Display the modal with the bird details
function manageBird(birdId) {
    // console.log("Função manageBird chamada com ID:", birdId);
    const modal = document.getElementById("bird-management-modal");
    
    if (!modal) {
        // console.error("Modal de gerenciamento não encontrado");
        return;
    }
    
    // Verificar se o ID é um número válido
    if (isNaN(birdId) || birdId <= 0) {
        // console.error("ID do pássaro inválido:", birdId);
        return;
    }
    
    const bird = purchasedBirds.find((b) => b.id === birdId);
    // console.log("Pássaro encontrado:", bird);

    if (bird) {
        document.getElementById("bird-name").innerText = bird.name;
        document.getElementById("bird-details").innerHTML = `
            <p>Type: ${bird.type}</p>
            <p>Level: ${bird.level}</p>
            <p>XP: ${bird.xp}</p>
            <p>Nickname: ${bird.nickname}</p>
        `;
        // Definir o ID como string para evitar problemas de conversão
        modal.setAttribute('data-bird-id', String(birdId));
        // console.log("ID do pássaro definido no modal:", modal.getAttribute('data-bird-id'));
    } else {
        console.error("Pássaro não encontrado para ID:", birdId);
        return; // Não abrir o modal se o pássaro não for encontrado
    }

    modal.style.display = "flex"; // Displays the modal
}

// Fechar o modal
function closeModal() {
    const modal = document.getElementById("bird-management-modal");
    modal.style.display = "none"; // Hide the modal
    modal.removeAttribute('data-bird-id'); // Remove bird ID from modal
}

// Abrir modal para mudar nome
function changeBirdName() {
    const managementModal = document.getElementById("bird-management-modal");
    const changeNameModal = document.getElementById("change-name-modal");
    const birdId = parseInt(managementModal.getAttribute('data-bird-id'), 10);
    const bird = purchasedBirds.find((b) => b.id === birdId);

    if (bird) {
        changeNameModal.setAttribute('data-bird-id', birdId);
        
        document.getElementById("change-name-details").innerHTML = `
            <p>Nome atual: ${bird.name}</p>
            <p>Apelido atual: ${bird.nickname}</p>
        `;
        
        // Preencher o campo com o apelido atual (sem parênteses)
        const currentNickname = bird.nickname === "(no name)" ? "" : bird.nickname.slice(1, -1);
        document.getElementById("new-bird-name").value = currentNickname;
        
        // Fechar o modal de gerenciamento e abrir o de mudança de nome
        managementModal.style.display = "none";
        changeNameModal.style.display = "flex";
    }
}

// Fechar modal de mudança de nome
function closeChangeNameModal() {
    document.getElementById("change-name-modal").style.display = "none";
    // Reabrir o modal de gerenciamento
    const birdId = parseInt(document.getElementById("change-name-modal").getAttribute('data-bird-id'), 10);
    if (birdId) {
        manageBird(birdId);
    }
}

// Confirmar mudança de nome
function confirmNameChange() {
    const changeNameModal = document.getElementById("change-name-modal");
    const birdId = parseInt(changeNameModal.getAttribute('data-bird-id'), 10);
    const newName = document.getElementById("new-bird-name").value;
    
    const bird = purchasedBirds.find((b) => b.id === birdId);
    if (bird) {
        const trimmedName = newName.trim();
        
        let nickname;
        if (trimmedName !== "") {
            nickname = `(${trimmedName})`;
        } else {
            nickname = "(no name)";
        }
        
        // Enviar a atualização para o servidor
        fetch("http://dodi_birds/updateBirdName", {
            method: "POST",
            headers: {
                "Content-Type": "application/json",
            },
            body: JSON.stringify({ birdId: bird.id, nickname: nickname }),
        })
        .then(() => {
            console.log("Bird name updated successfully!");
            // Atualizar o nome localmente
            bird.nickname = nickname;
            // Fechar o modal de mudança de nome
            closeChangeNameModal();
            // Atualizar a interface
            loadInventory();
            loadHome();
        })
        .catch((error) => {
            console.error("Error updating bird name:", error);
        });
    }
}

// Update Trainer Level only on bird training
function trainBird() {
    const modal = document.getElementById("bird-management-modal");
    const birdId = parseInt(modal.getAttribute('data-bird-id'), 10);
    const bird = purchasedBirds.find((b) => b.id === birdId);

    if (bird) {
        let [currentXP, maxXP] = bird.xp.split(" / ").map(Number);
        currentXP += 10;
        if (currentXP >= maxXP) {
            currentXP = 0;
            bird.level += 1;
            maxXP += 50;
            bird.xp = `${currentXP} / ${maxXP}`;
            alert(`${bird.name} has leveled up to Level ${bird.level}!`);
            
            // Update Trainer Level
            calculateTrainerLevel();
        } else {
            bird.xp = `${currentXP} / ${maxXP}`;
            alert(`${bird.name} has been trained. XP is now ${bird.xp}.`);
        }

        loadInventory();
        manageBird(birdId);
        loadHome();
    }
}

function viewXP() {
    const modal = document.getElementById("bird-management-modal");
    const birdId = parseInt(modal.getAttribute('data-bird-id'), 10);
    const bird = purchasedBirds.find((b) => b.id === birdId);

    if (bird) {
        alert(`${bird.name}'s XP: ${bird.xp}`);
    }
}

// Calculate Trainer Level (soma de todos os níveis dos pássaros)
function calculateTrainerLevel() {
    const trainerLevel = purchasedBirds.reduce((total, bird) => total + bird.level, 0);
    document.getElementById("your-level").innerText = trainerLevel.toString().padStart(2, "0");
}

// Load home summary
function loadHome() {
    const totalBirds = purchasedBirds.length;
    const highestLevelBird = purchasedBirds.reduce((highest, bird) => {
        return !highest || bird.level > highest.level ? bird : highest;
    }, null);

    // Update total birds with leading zero
    const totalBirdsEl = document.getElementById("total-birds");
    if (totalBirdsEl) {
        totalBirdsEl.innerText = totalBirds.toString().padStart(2, '0');
    }

    // Update highest level bird info
    const highestBirdEl = document.getElementById("highest-level-bird");
    const bestBirdLevelEl = document.getElementById("best-bird-level");
    const bestBirdImgEl = document.getElementById("best-bird-img");
    
    if (highestLevelBird) {
        const displayName = highestLevelBird.nickname !== "(no name)" 
            ? `${highestLevelBird.name} ${highestLevelBird.nickname}`
            : highestLevelBird.name;
            
        if (highestBirdEl) {
            highestBirdEl.innerText = displayName;
        }
        if (bestBirdLevelEl) {
            bestBirdLevelEl.innerText = `Level ${highestLevelBird.level}`;
        }
        if (bestBirdImgEl && highestLevelBird.image) {
            bestBirdImgEl.src = highestLevelBird.image;
        }
    } else {
        if (highestBirdEl) {
            highestBirdEl.innerText = "No birds yet";
        }
        if (bestBirdLevelEl) {
            bestBirdLevelEl.innerText = "";
        }
    }

    calculateTrainerLevel();
}

// Initialize the app
window.onload = function () {
    // Carregar configurações primeiro
    fetchConfig();
    
    // Depois carregar os pássaros
    setTimeout(() => {
        // Carregar pássaros da loja
        fetchShopBirds(() => {
            loadShop("Scavenger");
        });

        // Carregar pássaros do jogador
        fetchPlayerBirds(() => {
            loadInventory();
            loadHome();
        });
    }, 500); // Pequeno atraso para garantir que as configurações sejam carregadas primeiro
};

function toggleMenu() {
    const menu = document.getElementById("menu-container");
    if (menu.style.display === "none" || menu.style.display === "") {
        // Displays the menu
        menu.style.display = "block"; 
        openTab("home"); // Always opens in the "Home" tab

        // Carries the updated birds when opening the menu
        fetchPlayerBirds(() => {
            loadInventory(); // Updates the inventory at the interface
            loadHome(); // Updates Home's summary
        });
    } else {
        // Hide the menu
        menu.style.display = "none"; 
        closeModal(); // Closes any open modal
    }
}

window.addEventListener("message", function (event) {
    if (event.data.action === "toggleMenu") {
        toggleMenu(); // Call the function that opens the menu
    }
});

// Function to load store birds from the server
function fetchShopBirds(callback) {
    fetch("http://dodi_birds/requestShopBirds", {
        method: "POST",
    })
        .then((response) => response.json())
        .then((data) => {
            birdCategories = data; // Update the birds available at the store
            if (callback) callback(); // Call Callback to update UI
        })
        .catch((error) => {
            console.error("Error fetching shop birds:", error);
        });
}

// Update NUI when the server notifies
window.addEventListener("message", function (event) {
    if (event.data.action === "updateNUI") {
        fetchPlayerBirds(() => {
            loadInventory();
            loadHome();
            // console.log("NUI updated after bird XP gain.");
        });
    }
});

// Function to load player birds from the database
function fetchPlayerBirds(callback) {
    fetch("http://dodi_birds/requestPlayerBirds", {
        method: "POST",
    })
        .then((response) => response.json())
        .then((data) => {
            // console.log("Pássaros recebidos do servidor:", data);
            
            // Verificar se cada pássaro tem um ID válido e processar outfit
            purchasedBirds = data.filter(bird => {
                if (!bird.id || isNaN(parseInt(bird.id, 10))) {
                    // console.error("Pássaro com ID inválido ignorado:", bird);
                    return false;
                }
                bird.id = parseInt(bird.id, 10);
                
                if (bird.outfit !== undefined && bird.outfit !== null) {
                    bird.outfit = parseInt(bird.outfit, 10);
                    if (isNaN(bird.outfit)) {
                        bird.outfit = 0;
                    }
                } else {
                    bird.outfit = 0;
                }
                
                // console.log(`Processed bird ${bird.name}: outfit = ${bird.outfit} (type: ${typeof bird.outfit})`);
                return true;
            });
            
            // console.log("Pássaros processados:", purchasedBirds);
            
            if (callback) callback();
        })
        .catch((error) => {
            // console.error("Error fetching player birds:", error);
        });
}

function callBird() {
    const modal = document.getElementById("bird-management-modal");
    const birdId = parseInt(modal.getAttribute("data-bird-id"), 10);
    const bird = purchasedBirds.find((b) => b.id === birdId);

    if (bird) {
        fetch("http://dodi_birds/spawnBird", {
            method: "POST",
            headers: {
                "Content-Type": "application/json",
            },
            body: JSON.stringify({ bird }),
        })
            .then(() => {})
            .catch((error) => {});
    }
}

window.addEventListener("message", function (event) {
    if (event.data.action === "closeClient") {
        const menu = document.getElementById("menu-container");
        menu.style.display = "none"; // Hide the menu
        fetch("http://dodi_birds/closeMenu", {
            method: "POST"
        }); // Send an event to the server to remove the focus from NUI
        closeModal();
    }
});

document.addEventListener("keydown", function (event) {
    if (event.key === "Escape") {
        const menu = document.getElementById("menu-container");
        menu.style.display = "none"; // Hide the menu
        fetch("http://dodi_birds/closeMenu", {
            method: "POST"
        }); // Send an event to the server to remove the focus from NUI
        closeModal();
    }
});

// Configuracao padrao
let Config = {
    SellBackPercentage: 60,
    MenuTabs: {
        home: {
            label: "Home",
            image: "images/animal1.png",
            description: "Overview of your bird collection"
        },
        shop: {
            label: "Shop",
            image: "images/animal2.png",
            description: "Purchase new birds for your collection"
        },
        inventory: {
            label: "Your Birds",
            image: "images/animal1.png",
            description: "Manage and train your owned birds"
        }
    },
    HomeStats: {
        totalBirds: {
            image: "images/animal1.png"
        },
        trainerLevel: {
            image: "images/animal2.png"
        },
        bestBird: {
            image: "images/animal1.png"
        }
    }
};

// Abrir modal de venda
function openSellModal() {
    console.log("Função openSellModal chamada");
    const managementModal = document.getElementById("bird-management-modal");
    const sellModal = document.getElementById("sell-bird-modal");
    
    if (!managementModal) {
        console.error("Modal de gerenciamento não encontrado");
        return;
    }
    
    if (!sellModal) {
        console.error("Modal de venda não encontrado");
        return;
    }
    
    // Obter o ID do pássaro como string primeiro
    const birdIdStr = managementModal.getAttribute('data-bird-id');
    console.log("ID do pássaro (string):", birdIdStr);
    
    // Verificar se o ID é válido antes de converter para número
    if (!birdIdStr || birdIdStr === "") {
        console.error("ID do pássaro não definido no modal");
        return;
    }
    
    const birdId = parseInt(birdIdStr, 10);
    console.log("ID do pássaro (número):", birdId);
    
    // Verificar se o ID é um número válido
    if (isNaN(birdId)) {
        console.error("ID do pássaro não é um número válido:", birdIdStr);
        return;
    }
    
    const bird = purchasedBirds.find((b) => b.id === birdId);
    console.log("Pássaro encontrado:", bird);
    
    if (!bird) {
        console.error("Pássaro não encontrado para ID:", birdId);
        return;
    }
    
    sellModal.setAttribute('data-bird-id', birdId);
    
    // Usar um valor fixo para SellBackPercentage se não estiver definido
    const sellBackPercentage = Config.SellBackPercentage || 60;
    const sellBackPrice = Math.floor(bird.price * (sellBackPercentage / 100));
    
    document.getElementById("sell-bird-details").innerHTML = `
        <p>Nome: ${bird.name} ${bird.nickname}</p>
        <p>Tipo: ${bird.type}</p>
        <p>Nível: ${bird.level}</p>
        <p>Preço original: $${bird.price}</p>
        <p>Valor de venda para o sistema: $${sellBackPrice}</p>
    `;
    
    // Limpar campos de entrada
    document.getElementById("target-player-id").value = "";
    document.getElementById("bird-sell-price").value = "";
    
    // Fechar o modal de gerenciamento e abrir o de venda
    managementModal.style.display = "none";
    sellModal.style.display = "flex";
}

// Fechar modal de venda
function closeSellModal() {
    const sellModal = document.getElementById("sell-bird-modal");
    if (sellModal) {
        sellModal.style.display = "none";
    }
}

// Vender pássaro para o sistema (abre o modal de confirmação)
function sellBirdToSystem() {
    const sellModal = document.getElementById("sell-bird-modal");
    const confirmModal = document.getElementById("confirm-sell-modal");
    birdToSellId = parseInt(sellModal.getAttribute('data-bird-id'), 10);
    
    // Fechar o modal de venda e abrir o de confirmação
    sellModal.style.display = "none";
    confirmModal.style.display = "flex";
}

// Fechar modal de confirmação de venda
function closeConfirmSellModal() {
    const confirmModal = document.getElementById("confirm-sell-modal");
    const sellModal = document.getElementById("sell-bird-modal");
    
    confirmModal.style.display = "none";
    sellModal.style.display = "flex"; // Reabrir o modal de venda
    birdToSellId = null;
}

// Confirmar venda para o sistema
function confirmSellToSystem() {
    if (!birdToSellId) {
        console.error("ID do pássaro a ser vendido não definido");
        return;
    }
    
    console.log("Enviando solicitação para vender pássaro ID:", birdToSellId);
    
    fetch("http://dodi_birds/sellBirdToSystem", {
        method: "POST",
        headers: {
            "Content-Type": "application/json",
        },
        body: JSON.stringify({ birdId: birdToSellId }),
    })
    .then(() => {
        console.log("Pássaro vendido com sucesso, ID:", birdToSellId);
        // Fechar todos os modais
        document.getElementById("confirm-sell-modal").style.display = "none";
        document.getElementById("sell-bird-modal").style.display = "none";
        
        // Limpar o ID do pássaro a ser vendido
        birdToSellId = null;
        
        // Atualizar a lista de pássaros após a venda
        setTimeout(() => {
            fetchPlayerBirds(() => {
                loadInventory();
                loadHome();
            });
        }, 1000);
    })
    .catch((error) => {
        console.error("Erro ao vender pássaro:", error);
    });
}

// Oferecer pássaro para outro jogador
function offerBirdToPlayer() {
    const sellModal = document.getElementById("sell-bird-modal");
    const birdId = parseInt(sellModal.getAttribute('data-bird-id'), 10);
    const targetId = document.getElementById("target-player-id").value;
    const price = document.getElementById("bird-sell-price").value;
    
    if (!targetId || !price) {
        alert("Por favor, preencha o ID do jogador e o preço.");
        return;
    }
    
    if (parseInt(targetId) <= 0 || parseInt(price) <= 0) {
        alert("ID do jogador e preço devem ser valores positivos.");
        return;
    }
    
    fetch("http://dodi_birds/offerBirdToPlayer", {
        method: "POST",
        headers: {
            "Content-Type": "application/json",
        },
        body: JSON.stringify({ 
            targetId: parseInt(targetId),
            birdId: birdId,
            price: parseInt(price)
        }),
    })
    .then(() => {
        console.log("Bird offer sent to player");
        closeSellModal();
    })
    .catch((error) => {
        console.error("Error offering bird to player:", error);
    });
}

// Receber oferta de pássaro
window.addEventListener("message", function (event) {
    if (event.data.action === "receiveBirdOffer") {
        currentOffer = {
            sellerId: event.data.sellerId,
            birdId: event.data.birdId,
            bird: event.data.bird,
            price: event.data.price
        };
        
        // Mostrar detalhes da oferta
        document.getElementById("offer-bird-details").innerHTML = `
            <p>Player #${currentOffer.sellerId} It is offering:</p>
            <p>Name: ${currentOffer.bird.name} ${currentOffer.bird.nickname}</p>
            <p>Type: ${currentOffer.bird.type}</p>
            <p>Level: ${currentOffer.bird.level}</p>
            <p>XP: ${currentOffer.bird.xp}</p>
            <div class="offer-price">Price: $${currentOffer.price}</div>
        `;
        
        // Abrir modal de oferta
        document.getElementById("bird-offer-modal").style.display = "flex";
    }
});

// Fechar modal de oferta
function closeOfferModal() {
    document.getElementById("bird-offer-modal").style.display = "none";
    currentOffer = null;
}

// Aceitar oferta de pássaro
function acceptBirdOffer() {
    if (!currentOffer) return;
    
    fetch("http://dodi_birds/acceptBirdOffer", {
        method: "POST",
        headers: {
            "Content-Type": "application/json",
        },
        body: JSON.stringify({ 
            sellerId: currentOffer.sellerId,
            birdId: currentOffer.birdId,
            price: currentOffer.price
        }),
    })
    .then(() => {
        console.log("Bird offer accepted");
        closeOfferModal();
    })
    .catch((error) => {
        console.error("Error accepting bird offer:", error);
    });
}

// Recusar oferta de pássaro
function declineBirdOffer() {
    if (!currentOffer) return;
    
    fetch("http://dodi_birds/declineBirdOffer", {
        method: "POST",
        headers: {
            "Content-Type": "application/json",
        },
        body: JSON.stringify({ 
            sellerId: currentOffer.sellerId
        }),
    })
    .then(() => {
        closeOfferModal();
    })
    .catch((error) => {});
}

// Carregar configuracoes do servidor
function fetchConfig() {
    fetch("http://dodi_birds/getConfig", {
        method: "POST",
    })
    .then((response) => response.json())
    .then((data) => {
        if (data && typeof data === 'object') {
            Config = {
                ...Config,
                ...data
            };
        }
        renderMenuTabs();
        renderHomeStatsImages();
    })
    .catch((error) => {
        console.error("Error loading config:", error);
        renderMenuTabs();
        renderHomeStatsImages();
    });
}

// Render home stats images from config
function renderHomeStatsImages() {
    const statsConfig = Config.HomeStats;
    if (!statsConfig) return;
    
    // Total Birds image
    const totalBirdsImg = document.querySelector('.stat-birds .stat-icon img');
    if (totalBirdsImg && statsConfig.totalBirds) {
        totalBirdsImg.src = statsConfig.totalBirds.image;
    }
    
    // Trainer Level image
    const trainerLevelImg = document.querySelector('.stat-level .stat-icon img');
    if (trainerLevelImg && statsConfig.trainerLevel) {
        trainerLevelImg.src = statsConfig.trainerLevel.image;
    }
    
    // Best Bird default image
    const bestBirdImg = document.getElementById('best-bird-img');
    if (bestBirdImg && statsConfig.bestBird && purchasedBirds.length === 0) {
        bestBirdImg.src = statsConfig.bestBird.image;
    }
}

// Render menu tabs from config
function renderMenuTabs() {
    const tabsContainer = document.getElementById("menu-tabs");
    if (!tabsContainer) return;
    
    tabsContainer.innerHTML = "";
    
    const tabOrder = ["home", "shop", "inventory"];
    
    tabOrder.forEach((tabId, index) => {
        const tabConfig = Config.MenuTabs[tabId];
        if (!tabConfig) return;
        
        const isActive = index === 0;
        
        const wrapper = document.createElement("div");
        wrapper.classList.add("tab-wrapper");
        
        wrapper.innerHTML = `
            <button class="tab-btn ${isActive ? 'active' : ''}" onclick="openTab('${tabId}')">
                <img class="tab-icon-img" src="${tabConfig.image}" alt="${tabConfig.label}">
                <span class="tab-text">${tabConfig.label}</span>
                <span class="tab-line"></span>
            </button>
            <div class="tab-tooltip">
                <img src="${tabConfig.image}" alt="${tabConfig.label}">
                <span>${tabConfig.description}</span>
            </div>
        `;
        
        tabsContainer.appendChild(wrapper);
    });
}

// Fechar o modal de selecao de outfit
function closeOutfitModal() {
    document.getElementById("outfit-selection-modal").style.display = "none";
    birdToBuy = null;
    selectedOutfit = 0;
}

// Confirmar a compra do passaro com o outfit selecionado
function confirmBirdPurchase() {
    if (!birdToBuy) {
        console.error("No bird selected for purchase");
        return;
    }
    
    // Adicionar o outfit selecionado ao passaro
    birdToBuy.outfit = selectedOutfit;
    
    // Guardar info para animacao
    const purchasedBirdInfo = {
        name: birdToBuy.name,
        image: birdToBuy.image,
        outfit: selectedOutfit
    };
    
    // Encontrar nome da variante
    const category = birdToBuy.type;
    let variantName = "Default";
    if (birdCategories && birdCategories[category]) {
        const birdConfig = birdCategories[category].find(b => b.name === birdToBuy.name);
        if (birdConfig && birdConfig.outfits) {
            const outfit = birdConfig.outfits.find(o => o.value === selectedOutfit);
            if (outfit) variantName = outfit.name;
        }
    }
    purchasedBirdInfo.variant = variantName;
    
    // Enviar para o servidor
    fetch("http://dodi_birds/buyBird", {
        method: "POST",
        headers: {
            "Content-Type": "application/json",
        },
        body: JSON.stringify({ bird: birdToBuy }),
    })
    .then((response) => response.json())
    .then(() => {
        console.log("Bird sent to server with outfit:", selectedOutfit);
        
        // Fechar o modal
        closeOutfitModal();
        
        // Mostrar animacao de sucesso
        showPurchaseSuccess(purchasedBirdInfo);
        
        // Atualizar a lista de passaros apos animacao
        setTimeout(() => {
            fetchPlayerBirds(() => {
                console.log("Inventory updated after purchase");
                loadInventory();
                loadHome();
            });
        }, 500);
    })
    .catch((error) => {
        console.error("Error sending bird to server:", error);
    });
}

// Show purchase success animation
function showPurchaseSuccess(birdInfo) {
    const overlay = document.getElementById("purchase-success-overlay");
    const birdImg = document.getElementById("success-bird-img");
    const birdName = document.getElementById("success-bird-name");
    const birdVariant = document.getElementById("success-bird-variant");
    const particlesContainer = document.getElementById("success-particles");
    
    if (!overlay) return;
    
    // Set bird info
    if (birdImg) birdImg.src = birdInfo.image;
    if (birdName) birdName.textContent = birdInfo.name;
    if (birdVariant) birdVariant.textContent = birdInfo.variant;
    
    // Clear old particles
    if (particlesContainer) particlesContainer.innerHTML = "";
    
    // Create particles
    createSuccessParticles(particlesContainer);
    
    // Show overlay
    overlay.style.display = "flex";
    setTimeout(() => {
        overlay.classList.add("show");
    }, 10);
    
    // Auto hide after 3 seconds
    setTimeout(() => {
        hidePurchaseSuccess();
    }, 3000);
}

// Hide purchase success animation
function hidePurchaseSuccess() {
    const overlay = document.getElementById("purchase-success-overlay");
    if (!overlay) return;
    
    overlay.classList.remove("show");
    setTimeout(() => {
        overlay.style.display = "none";
    }, 300);
}

// Create particle effects
function createSuccessParticles(container) {
    if (!container) return;
    
    const colors = ['#fc0', '#ffd700', '#ffec8b', '#fff8dc'];
    
    for (let i = 0; i < 30; i++) {
        const particle = document.createElement("div");
        particle.classList.add("particle");
        
        // Random position
        particle.style.left = Math.random() * 100 + "%";
        particle.style.top = Math.random() * 50 + "%";
        
        // Random color
        particle.style.background = colors[Math.floor(Math.random() * colors.length)];
        
        // Random size
        const size = Math.random() * 8 + 4;
        particle.style.width = size + "px";
        particle.style.height = size + "px";
        
        // Random delay
        particle.style.animationDelay = Math.random() * 0.5 + "s";
        particle.style.animationDuration = (Math.random() * 1 + 1.5) + "s";
        
        container.appendChild(particle);
    }
}

// Função para reproduzir sons de papagaio
function playBirdSound(soundType) {
    const audioPlayer = document.getElementById("bird-sound-player");
    
    // Mapeamento de tipos de som para arquivos
    const soundFiles = {
        greeting: ["sounds/parrot_greeting1.mp3"],
        happy: ["sounds/parrot_happy1.mp3"],
        angry: ["sounds/parrot_angry1.mp3"],
        training: ["sounds/parrot_training1.mp3"],
        random: ["sounds/parrot_random1.mp3"]
    };
    
    // Selecionar um arquivo aleatório do tipo especificado
    const sounds = soundFiles[soundType] || soundFiles.random;
    const randomSound = sounds[Math.floor(Math.random() * sounds.length)];
    
    // Definir o arquivo de áudio e reproduzir
    audioPlayer.src = randomSound;
    audioPlayer.volume = 0.5; // Volume a 50%
    
    // Reproduzir o som
    audioPlayer.play().catch(error => {
        console.error("Erro ao reproduzir som:", error);
    });
}

// Adicionar um listener para mensagens do cliente
window.addEventListener("message", function (event) {
    if (!event.data || !event.data.action) return;
    
    // Debug log for notifications
    if (event.data.action.includes("Notification") || event.data.action.includes("notification")) {
        console.log("[NUI] Received notification action:", event.data.action, event.data);
    }
    
    // Play bird sound
    if (event.data.action === "playBirdSound") {
        playBirdSound(event.data.soundType);
    }
    
    // XP Notification
    if (event.data.action === "xpNotification") {
        showXPNotification(event.data.birdName, event.data.xpGained);
    }
    
    // Level Up Notification
    if (event.data.action === "levelUpNotification") {
        showLevelUpNotification(event.data.birdName, event.data.newLevel);
    }
    
    // Item Notification
    if (event.data.action === "itemNotification") {
        showItemNotification(event.data.itemName);
    }
    
    // Training Notification
    if (event.data.action === "trainingNotification") {
        showTrainingNotification(event.data.birdName, event.data.status);
    }
    
    // Error Notification
    if (event.data.action === "errorNotification") {
        showErrorNotification(event.data.message);
    }
    
    // Generic Notification
    if (event.data.action === "showNotification") {
        showNotification({
            title: event.data.title || "Notification",
            message: event.data.message || "",
            type: event.data.type || "success",
            icon: event.data.icon || "images/animal1.png",
            duration: event.data.duration || 4000
        });
    }
});
