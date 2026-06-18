let currentActiveCategory = null;
let categoriesData = [];
let currentCategoryItems = [];
let selectedItemIndex = 0;
let currentScreen = 1;
let scrollOffset = 0;
const MAX_VISIBLE_ITEMS = 4;
let activeBuyHandler = null;

let holdStartTime = null;
let holdInterval = null;
const HOLD_DURATION = 3000;

// MAP CIRCLE VARIABLES
let mapCircleActive = false;
let mapCircleData = null;

window.addEventListener('message', function(event) {
    const data = event.data;

    switch(data.action) {
        case 'openBlackmarket':
            openBlackmarket();
            break;

        case 'closeBlackmarket':
            closeBlackmarket();
            break;

        case 'setCategories':
            setCategories(data.categories);
            break;

        case 'setItems':
            setItems(data.categoryId, data.items);
            break;

        case 'setActiveCategory':
            setActiveCategory(data.categoryId);
            break;

        case 'purchaseResult':
            handlePurchaseResult(data.success, data.message);
            break;

        case 'showNotification':
            showNotification(data.title, data.description);
            break;

        case 'showMapCircle':
            showMapCircle(data);
            break;

        case 'updateMapCircle':
            updateMapCircle(data);
            break;

        case 'hideMapCircle':
            hideMapCircle();
            break;
    }
});

function openBlackmarket() {
    const mainContainer = document.querySelector('.main-container');

    mainContainer.style.display = 'flex';
    document.querySelector('.main-container2').style.display = 'none';
    currentScreen = 1;

    setTimeout(() => {
        mainContainer.classList.add('show');
        mainContainer.classList.add('opening');

        setTimeout(() => {
            mainContainer.classList.remove('opening');
        }, 1000);
    }, 10);
}

function closeBlackmarket() {
    const mainContainer = document.querySelector('.main-container');
    const mainContainer2 = document.querySelector('.main-container2');

    mainContainer.classList.remove('show');
    mainContainer2.classList.remove('show');

    setTimeout(() => {
        mainContainer.style.display = 'none';
        mainContainer2.style.display = 'none';
        currentScreen = 1;
    }, 400);
}

function setCategories(categories) {
    categoriesData = categories;

    categories.forEach(category => {
        const categoryElement = document.querySelector(`.${category.icon}`);
        if (categoryElement) {
            categoryElement.addEventListener('click', function() {
                fetch(`https://${GetParentResourceName()}/selectCategory`, {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/json'
                    },
                    body: JSON.stringify({
                        categoryId: category.id
                    })
                });
            });
        }
    });
}

function setActiveCategory(categoryId) {
    currentActiveCategory = categoryId;

    categoriesData.forEach(cat => {
        const element = document.querySelector(`.${cat.icon}`);
        if (element) {
            element.classList.remove('active-category');
        }
    });

    const activeCategory = categoriesData.find(cat => cat.id === categoryId);
    if (activeCategory) {
        const element = document.querySelector(`.${activeCategory.icon}`);
        if (element) {
            element.classList.add('active-category');

            document.querySelector('.market-header').textContent = activeCategory.label;
            document.querySelector('.market-desc').textContent = activeCategory.description;
        }
    }
}

function setItems(categoryId, items) {
    currentCategoryItems = items;
    selectedItemIndex = 0;
    scrollOffset = 0;

    renderItems();
    updateItemCounter();
}

function renderItems() {
    const productListSection = document.querySelector('.productlist-section');
    productListSection.innerHTML = '';

    const visibleItems = currentCategoryItems.slice(scrollOffset, scrollOffset + MAX_VISIBLE_ITEMS);

    visibleItems.forEach((item, index) => {
        const productDiv = document.createElement('div');
        productDiv.className = 'productbg';
        productDiv.style.left = `${1.0417 + (index * 7.95)}vw`;
        productDiv.style.top = '7.5vw';

        const actualIndex = scrollOffset + index;
        if (actualIndex === selectedItemIndex) {
            productDiv.classList.add('selected-item');
        }

        productDiv.innerHTML = `
            <div class="product-money">${item.price} $</div>
            <div class="productmoney-bg"></div>
            <div class="product-photo" style="background-image: url('${item.image}');"></div>
        `;

        productDiv.style.pointerEvents = 'none';

        productListSection.appendChild(productDiv);
    });

    if (currentCategoryItems.length > 0) {
        updateItemInfo(currentCategoryItems[selectedItemIndex]);
    }
}

function updateItemCounter() {
    document.querySelector('.current-product').textContent = (selectedItemIndex + 1).toString();
    document.querySelector('.total-product').textContent = currentCategoryItems.length.toString();
}

function updateItemInfo(item) {
    document.querySelector('.itemlist-header').textContent = item.label;
    document.querySelector('.itemlistheader-desc').textContent = item.description;
}

function startHoldProgress() {
    const progressContainer = document.querySelector('.purchase-progress-container');
    const progressFill = document.querySelector('.progress-bar-fill');

    if (!progressContainer || !progressFill) return;

    progressContainer.style.display = 'flex';
    progressFill.style.width = '0%';

    holdStartTime = Date.now();

    holdInterval = setInterval(() => {
        const elapsed = Date.now() - holdStartTime;
        const progress = Math.min((elapsed / HOLD_DURATION) * 100, 100);

        progressFill.style.width = `${progress}%`;

        if (elapsed >= HOLD_DURATION) {
            clearInterval(holdInterval);
            holdInterval = null;
            return true;
        }
    }, 50);
}

function stopHoldProgress() {
    const progressContainer = document.querySelector('.purchase-progress-container');
    const progressFill = document.querySelector('.progress-bar-fill');

    if (holdInterval) {
        clearInterval(holdInterval);
        holdInterval = null;
    }

    holdStartTime = null;

    if (progressContainer) progressContainer.style.display = 'none';
    if (progressFill) progressFill.style.width = '0%';
}

let currentItemDetail = null;

function showItemDetail(item) {
    currentItemDetail = item;

    const mainContainer = document.querySelector('.main-container');
    const mainContainer2 = document.querySelector('.main-container2');

    mainContainer.classList.remove('show');

    setTimeout(() => {
        mainContainer.style.display = 'none';

        mainContainer2.querySelector('.market-header').textContent = 'Black Market';
        mainContainer2.querySelector('.market-desc').textContent = 'Purchase Item';
        mainContainer2.querySelector('.itemlist-header').textContent = item.label;
        mainContainer2.querySelector('.itemlistheader-desc').textContent = item.description;
        document.querySelector('.special-money').textContent = `${item.price} $`;

        mainContainer2.style.display = 'flex';
        currentScreen = 2;

        setTimeout(() => {
            mainContainer2.classList.add('show');
        }, 10);

        fetch(`https://${GetParentResourceName()}/openItemDetail`, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify({
                itemName: item.name
            })
        });
    }, 400);
}

function purchaseItem(itemName, amount) {

    fetch(`https://${GetParentResourceName()}/buyItem`, {
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

function handlePurchaseResult(success, message) {

    stopHoldProgress();

    if (success) {
        document.querySelector('.main-container').style.display = 'flex';
        document.querySelector('.main-container2').style.display = 'none';
        currentScreen = 1;
        currentItemDetail = null;
    } else {
    }
}

document.addEventListener('keydown', function(e) {
    if (e.key === 'Enter' && currentScreen === 2 && !holdStartTime) {
        startHoldProgress();

        setTimeout(() => {
            if (holdStartTime && currentItemDetail) {
                purchaseItem(currentItemDetail.name, 1);
                stopHoldProgress();
            }
        }, HOLD_DURATION);
    }

    if (e.key === 'Delete' || e.key === 'Backspace') {
        if (currentScreen === 2) {
            stopHoldProgress();

            const mainContainer = document.querySelector('.main-container');
            const mainContainer2 = document.querySelector('.main-container2');

            mainContainer2.classList.remove('show');

            setTimeout(() => {
                mainContainer2.style.display = 'none';
                currentItemDetail = null;

                mainContainer.style.display = 'flex';
                currentScreen = 1;

                setTimeout(() => {
                    mainContainer.classList.add('show');
                }, 10);

                fetch(`https://${GetParentResourceName()}/closeItemDetail`, {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/json'
                    },
                    body: JSON.stringify({})
                });
            }, 400);
        } else {
            fetch(`https://${GetParentResourceName()}/closeUI`, {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify({})
            });
        }
    }

    if (currentScreen === 1 && currentCategoryItems.length > 0) {
        if (e.key === 'a' || e.key === 'A') {
            selectedItemIndex--;
            if (selectedItemIndex < 0) {
                selectedItemIndex = currentCategoryItems.length - 1;
                scrollOffset = Math.max(0, currentCategoryItems.length - MAX_VISIBLE_ITEMS);
            } else if (selectedItemIndex < scrollOffset) {
                scrollOffset = selectedItemIndex;
            }

            renderItems();
            updateItemInfo(currentCategoryItems[selectedItemIndex]);
            updateItemCounter();
        }
        if (e.key === 'd' || e.key === 'D') {
            selectedItemIndex++;
            if (selectedItemIndex >= currentCategoryItems.length) {
                selectedItemIndex = 0;
                scrollOffset = 0;
            } else if (selectedItemIndex >= scrollOffset + MAX_VISIBLE_ITEMS) {
                scrollOffset = selectedItemIndex - MAX_VISIBLE_ITEMS + 1;
            }

            renderItems();
            updateItemInfo(currentCategoryItems[selectedItemIndex]);
            updateItemCounter();
        }
    }

    if (e.key === 'Enter' && currentScreen === 1 && currentCategoryItems.length > 0) {
        showItemDetail(currentCategoryItems[selectedItemIndex]);
    }

    if (currentScreen === 2) {
        if (e.key === 'q' || e.key === 'Q') {
            fetch(`https://${GetParentResourceName()}/rotateItem`, {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify({
                    direction: 'left'
                })
            });
        }
        if (e.key === 'e' || e.key === 'E') {
            fetch(`https://${GetParentResourceName()}/rotateItem`, {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify({
                    direction: 'right'
                })
            });
        }
    }
});

document.addEventListener('keyup', function(e) {
    if (e.key === 'Enter' && currentScreen === 2 && holdStartTime) {
        stopHoldProgress();
    }
});

function GetParentResourceName() {
    let resourceName = 'valenr';
    if (window.location.href.includes('://')) {
        resourceName = window.location.href.split('://')[1].split('/')[0];
    }
    return resourceName;
}

let notificationTimeout = null;

function showNotification(title, description) {
    const notifyContainer = document.querySelector('.notify-container');
    const alertText = document.querySelector('.alert-text');
    const alertDesc = document.querySelector('.alert-desc');

    if (!notifyContainer || !alertText || !alertDesc) {
        return;
    }

    if (notificationTimeout) {
        clearTimeout(notificationTimeout);
        notificationTimeout = null;
    }

    alertText.textContent = title;
    alertDesc.textContent = description;

    notifyContainer.style.display = 'flex';
    setTimeout(() => {
        notifyContainer.style.opacity = '1';
    }, 10);

    notificationTimeout = setTimeout(() => {
        hideNotification();
    }, 5000);
}

function hideNotification() {
    const notifyContainer = document.querySelector('.notify-container');

    if (!notifyContainer) return;

    notifyContainer.style.opacity = '0';

    setTimeout(() => {
        notifyContainer.style.display = 'none';
    }, 400);

    notificationTimeout = null;
}

// ═══════════════════════════════════════════════════════════════
// MAP CIRCLE FUNCTIONS - KIRMIZI DAİRE
// ═══════════════════════════════════════════════════════════════

function showMapCircle(data) {
    const container = document.getElementById('map-circle-container');
    const circle = document.getElementById('map-circle');
    const center = document.getElementById('map-circle-center');

    if (!container || !circle || !center) return;

    mapCircleActive = true;
    mapCircleData = data;

    container.style.display = 'block';

    // Başlangıç boyutu
    circle.style.width = (data.radius || 150) + 'px';
    circle.style.height = (data.radius || 150) + 'px';

    console.log('[MAP CIRCLE] Shown with radius: ' + (data.radius || 150));
}

function updateMapCircle(data) {
    if (!mapCircleActive) return;

    const container = document.getElementById('map-circle-container');
    const circle = document.getElementById('map-circle');
    const center = document.getElementById('map-circle-center');

    if (!container || !circle || !center) return;

    // Harita açık değilse gizle
    if (!data.show) {
        container.style.display = 'none';
        return;
    }

    // Harita açık - göster
    container.style.display = 'block';

    // RDR2 Harita sınırları (yaklaşık)
    const worldMinX = -6000;
    const worldMaxX = 4500;
    const worldMinY = -5500;
    const worldMaxY = 4500;

    // Ekran boyutları
    const screenWidth = window.innerWidth;
    const screenHeight = window.innerHeight;

    // Harita alanı (pause menu haritası için) - ekranın ortasında
    const mapPadding = 50;
    const mapWidth = screenWidth - (mapPadding * 2);
    const mapHeight = screenHeight - (mapPadding * 2);

    // Dünya koordinatını ekran koordinatına dönüştür
    const normalizedX = (data.keyX - worldMinX) / (worldMaxX - worldMinX);
    const normalizedY = (data.keyY - worldMinY) / (worldMaxY - worldMinY);

    // Ekran pozisyonu (Y ekseni ters)
    const screenX = mapPadding + (normalizedX * mapWidth);
    const screenY = mapPadding + ((1 - normalizedY) * mapHeight);

    // Daire boyutu (dünya birimi -> piksel)
    const worldRange = worldMaxX - worldMinX;
    const pixelPerUnit = mapWidth / worldRange;
    const circleSize = (data.worldRadius || 150) * pixelPerUnit * 2;

    // Pozisyonları güncelle
    circle.style.left = screenX + 'px';
    circle.style.top = screenY + 'px';
    circle.style.width = Math.max(circleSize, 50) + 'px';
    circle.style.height = Math.max(circleSize, 50) + 'px';

    center.style.left = screenX + 'px';
    center.style.top = screenY + 'px';
}

function hideMapCircle() {
    const container = document.getElementById('map-circle-container');

    if (container) {
        container.style.display = 'none';
    }

    mapCircleActive = false;
    mapCircleData = null;

    console.log('[MAP CIRCLE] Hidden');
}

