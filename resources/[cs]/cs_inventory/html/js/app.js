/* ============================================================
   CS INVENTORY - app.js
   CAS Roleplay - Full inventory NUI logic
   ============================================================ */

'use strict';

// ---- State ----
const state = {
    open:            false,
    items:           [],
    secondaryItems:  [],
    droppedItems:    [],
    filter:          'all',
    playerQuery:     '',
    secondaryQuery:  '',
    activeTab:       'drop',
    inventoryType:   'main',
    secondaryType:   null,
    secondaryId:     null,
    secondaryTitle:  '',
    secondaryCap:    '',
    money:           0,
    gold:            0,
    weight:          0,
    maxWeight:       35.0,
    playerId:        1,
    job:             'UNEMPLOYED',
    health:          100,
    hunger:          100,
    thirst:          100,
    temperature:     21,
    location:        { region: '...', city: '' },
    ctxItem:         null,
    ctxSide:         'player',
    pendingAction:   null,
    pendingGive:     null,
    groups:          {},
    ammoData:        {},
    ammoLabels:      {},
    tradeActive:     false,
    tradeSessionId:  null,
    myOffer:         [],
    theirOffer:      [],
    myValidated:     false,
    partnerValidated: false,
    clothingEnabled: false,
    clothingState:   {},
    lang:            {},
};

// ---- Group mapping ----
const GROUPS = {
    all:       [0,1,2,3,4,5,6,7,8,9,10,11],
    medical:   [0,2],
    foods:     [0,3],
    weapons:   [0,5],
    ammo:      [0,6],
    tools:     [0,4],
    animals:   [0,8],
    docs:      [0,7],
    valuables: [0,9],
    horse:     [0,10],
    herbs:     [0,11],
    trade:     [0,11],
};

// ---- Elements ----
const $ = id => document.getElementById(id);
const el = {
    inv:            $('cs-inventory'),
    closeBtn:       $('inv-close-btn'),
    playerGrid:     $('player-grid'),
    secondGrid:     $('secondary-grid'),
    playerSearch:   $('player-search'),
    secondSearch:   $('secondary-search'),
    weightDisplay:  $('weight-display'),
    weightBar:      $('weight-bar'),
    catBar:         $('category-bar'),
    panelTabs:      $('panel-tabs'),
    secondTitle:    $('secondary-title-bar'),
    secondTitleTxt: $('secondary-title-text'),
    secondCap:      $('secondary-cap-text'),
    statMoney:      $('stat-money'),
    statGold:       $('stat-gold'),
    statId:         $('stat-id'),
    statJob:        $('stat-job'),
    locationRegion: $('location-region'),
    locationCity:   $('location-city'),
    healthBar:      $('health-bar'),
    healthVal:      $('health-val'),
    hungerBar:      $('hunger-bar'),
    hungerVal:      $('hunger-val'),
    thirstBar:      $('thirst-bar'),
    thirstVal:      $('thirst-val'),
    tempVal:        $('temp-val'),
    ctxMenu:        $('ctx-menu'),
    ctxItemName:    $('ctx-item-name'),
    ctxItemDesc:    $('ctx-item-desc'),
    ctxUse:         $('ctx-use'),
    ctxEquip:       $('ctx-equip'),
    ctxDrop:        $('ctx-drop'),
    ctxGive:        $('ctx-give'),
    ctxMove:        $('ctx-move'),
    ctxTake:        $('ctx-take'),
    qtyOverlay:     $('qty-overlay'),
    qtyTitle:       $('qty-title'),
    qtyItemInfo:    $('qty-item-info'),
    qtyInput:       $('qty-input'),
    qtySlider:      $('qty-slider'),
    qtyConfirm:     $('qty-confirm'),
    qtyCancel:      $('qty-cancel'),
    qtyMinus:       $('qty-minus'),
    qtyPlus:        $('qty-plus'),
    playersOverlay: $('players-overlay'),
    playersList:    $('players-list'),
    giveItemLabel:  $('give-item-label'),
    playersCancel:  $('players-cancel'),
    txLoader:       $('transaction-loader'),
    loaderText:     $('loader-text'),
    hotbarMoney:    $('hotbar-money'),
    hotbarGold:     $('hotbar-gold'),
    tradePanel:          $('trade-panel'),
    tradeStatusBar:      $('trade-status-bar'),
    myOfferItems:        $('my-offer-items'),
    theirOfferItems:     $('their-offer-items'),
    tradeValidateBtn:    $('trade-validate-btn'),
    tradeCancelBtn:      $('trade-cancel-btn'),
    tradeRequestOverlay: $('trade-request-overlay'),
    tradeRequestFrom:    $('trade-request-from'),
    tradeAcceptBtn:      $('trade-accept-btn'),
    tradeRefuseBtn:      $('trade-refuse-btn'),
};

// ---- Ammo popup state ----
let _ammoPanelPending = false;
let _ammoPopupOpen    = false;

// ---- Language helper ----
function L(key, fallback) {
    return (state.lang && state.lang[key]) || fallback || key;
}

// ---- NUI Communication ----
function nuiPost(action, data, cb) {
    fetch(`https://cs_inventory/${action}`, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify(data || {}),
    }).then(r => r.json()).then(cb || (() => {})).catch(() => {});
}

// ---- Message Handler ----
window.addEventListener('message', e => {
    const d = e.data;
    if (!d || !d.action) return;

    switch (d.action) {
        case 'open':
            handleOpen(d);
            break;
        case 'hide':
            handleHide();
            break;
        case 'setItems':
            if (d.itemList || d.items) {
                // Normalize items: ensure name field exists (vorp may send 'item' instead of 'name')
                const rawItems = d.itemList || d.items || [];
                state.items = rawItems.map(i => i.name ? i : Object.assign({}, i, { name: i.item || '' }));
                if (state.open) renderPlayerGrid();
            }
            break;
        case 'updateStatusHud':
            if (d.money !== undefined) state.money = d.money;
            if (d.gold  !== undefined) state.gold  = d.gold;
            if (d.id    !== undefined) state.playerId = d.id;
            updateStatsPanel();
            break;
        case 'updateStats':
            if (d.health      !== undefined) state.health      = d.health;
            if (d.hunger      !== undefined) state.hunger      = d.hunger;
            if (d.thirst      !== undefined) state.thirst      = d.thirst;
            if (d.temperature !== undefined) state.temperature = d.temperature;
            if (d.job         !== undefined) state.job         = d.job;
            if (d.location) {
                state.location.region = d.location.region || state.location.region;
                state.location.city   = d.location.city   || state.location.city;
            }
            updateVitals();
            updateLocation();
            break;
        case 'changecheck':
            state.weight    = parseFloat(d.check) || 0;
            state.maxWeight = parseFloat(d.info)  || state.maxWeight;
            updateWeight();
            break;
        case 'openSecondary':
            handleOpenSecondary(d);
            break;
        case 'setSecondaryItems':
            state.secondaryItems = d.itemList || d.items || [];
            renderSecondaryGrid();
            break;
        case 'closeSecondary':
            handleCloseSecondary();
            break;
        case 'nearPlayers':
            handleNearPlayers(d);
            break;
        case 'transaction':
            if (d.type === 'started')   showLoader(d.text || 'Processing...');
            if (d.type === 'completed') hideLoader();
            break;
        case 'display':
            if (!state.open) handleOpen(d);
            break;
        case 'updateammo':
            if (d.ammo) {
                state.ammoData = d.ammo;
                updateAmmoSlot();
                if (_ammoPanelPending) {
                    _ammoPanelPending = false;
                    if (_ammoPopupOpen) renderAmmoPopup();
                }
            }
            break;
        case 'reclabels':
            if (d.labels) state.ammoLabels = d.labels;
            break;
        case 'tradeSelectOpen':
            openTradeSelectorUI();
            break;
        case 'tradeSelectClose':
            closeTradeSelectorUI();
            if (state.open) el.inv.classList.remove('hidden');
            break;
        case 'tradeDotsUpdate':
            updateTradeDots(d.players || []);
            break;
        case 'tradeRequest':
            el.tradeRequestFrom.textContent = `${d.fromName || ('Player ' + d.from)} wants to trade with you`;
            el.tradeRequestOverlay.classList.remove('hidden');
            break;
        case 'openTrade':
            openTradeMode(d.sessionId, d.partner, d.partnerName);
            break;
        case 'tradeUpdate':
            if (d.myOffer    != null) { state.myOffer    = d.myOffer;    renderMyOffer(); }
            if (d.theirOffer != null) { state.theirOffer = d.theirOffer; renderTheirOffer(); }
            break;
        case 'tradePartnerValidated':
            state.partnerValidated = true;
            el.tradeStatusBar.textContent = L('trade_partner_ready', 'PARTNER READY — VALIDATE TO CONFIRM');
            el.tradeStatusBar.style.color = 'var(--cs-green)';
            break;
        case 'tradeCancelled':
            closeTrade(false);
            break;
        case 'tradeComplete':
            closeTrade(true);
            break;
        case 'clothingState':
            state.clothingState = d.state || {};
            if (state.clothingEnabled) renderClothingPanel();
            break;
        case 'removeItem':
            state.items = state.items.filter(i =>
                !(String(i.id) === String(d.id) && i.type === (d.itype || 'item_standard'))
            );
            if (state.open) renderPlayerGrid();
            break;
    }
});

// ============================================================
// OPEN / CLOSE
// ============================================================
function handleOpen(d) {
    state.open = true;
    state.inventoryType = d.type || 'main';
    state.droppedItems  = [];
    el.inv.classList.remove('hidden');

    if (d.items || d.itemList)   state.items   = d.items || d.itemList || [];
    if (d.money !== undefined)   state.money   = d.money;
    if (d.gold  !== undefined)   state.gold    = d.gold;
    if (d.weight !== undefined)  state.weight  = d.weight;
    if (d.maxWeight !== undefined) state.maxWeight = d.maxWeight;
    if (d.playerId !== undefined) state.playerId = d.playerId;
    if (d.job !== undefined)     state.job     = d.job;
    if (d.health !== undefined)  state.health  = d.health;
    if (d.hunger !== undefined)  state.hunger  = d.hunger;
    if (d.thirst !== undefined)  state.thirst  = d.thirst;
    if (d.temperature !== undefined) state.temperature = d.temperature;
    if (d.location) {
        state.location.region = d.location.region || state.location.region;
        state.location.city   = d.location.city   || state.location.city;
    }
    if (d.serverName) { const sn = $('server-name'); if (sn) sn.textContent = d.serverName; }

    if (d.lang) applyLang(d.lang);

    if (d.clothingEnabled !== undefined) {
        state.clothingEnabled = !!d.clothingEnabled;
        const cp = document.getElementById('clothing-panel');
        if (cp) cp.classList.toggle('hidden', !state.clothingEnabled);
    }
    if (d.clothingState) {
        state.clothingState = d.clothingState;
        if (state.clothingEnabled) renderClothingPanel();
    }

    renderPlayerGrid();
    updateStatsPanel();
    updateVitals();
    updateLocation();
    updateWeight();
    hideCtxMenu();
    renderSecondaryGrid();
}

function handleHide() {
    if (state.tradeActive && state.tradeSessionId) {
        nuiPost('CancelTrade', { sessionId: state.tradeSessionId });
    }
    closeTrade(false);
    el.tradeRequestOverlay.classList.add('hidden');
    state.open = false;
    el.inv.classList.add('hidden');
    hideCtxMenu();
    hideQtyModal();
    hidePlayersModal();
    hideLoader();
    hideAmmoPopup();
    hideTooltip();
}

// ============================================================
// SECONDARY INVENTORY
// ============================================================
function handleOpenSecondary(d) {
    state.secondaryType  = d.type || 'custom';
    state.secondaryId    = d.id   || null;
    state.secondaryTitle = d.title || '';
    state.secondaryCap   = d.capacity ? `${d.capacity} slots` : '';
    state.secondaryItems = d.itemList || d.items || [];

    el.panelTabs.classList.add('hidden');
    el.secondTitle.classList.remove('hidden');
    el.secondTitleTxt.textContent = state.secondaryTitle.toUpperCase();
    el.secondCap.textContent      = state.secondaryCap;

    el.ctxMove.classList.remove('hidden');
    el.ctxTake.classList.remove('hidden');

    renderSecondaryGrid();
}

function handleCloseSecondary() {
    state.secondaryType  = null;
    state.secondaryId    = null;
    state.secondaryItems = [];

    el.panelTabs.classList.remove('hidden');
    el.secondTitle.classList.add('hidden');
    el.ctxMove.classList.add('hidden');
    el.ctxTake.classList.add('hidden');

    renderSecondaryGrid();
}

// ============================================================
// ITEM RENDERING
// ============================================================
const TOTAL_SLOTS = 25;

function itemMatchesFilter(item) {
    const cat    = state.filter;
    const query  = state.playerQuery.toLowerCase();
    const groups = GROUPS[cat] || GROUPS.all;

    if (item.type === 'item_weapon') {
        if (!groups.includes(5)) return false;
    } else {
        const grp = item.group != null ? item.group : 1;
        if (!groups.includes(grp) && !groups.includes(0)) return false;
        if (cat !== 'all' && !groups.includes(grp)) return false;
    }

    if (query) {
        const lbl = (item.label || item.name || '').toLowerCase();
        if (!lbl.includes(query)) return false;
    }
    return true;
}

function itemMatchesSecondarySearch(item) {
    const query = state.secondaryQuery.toLowerCase();
    if (!query) return true;
    const lbl = (item.label || item.name || '').toLowerCase();
    return lbl.includes(query);
}

function getItemImageUrl(item) {
    if (item.metadata && item.metadata.image) {
        return `nui://vorp_inventory/html/img/items/${item.metadata.image}`;
    }
    if (item.type === 'item_weapon') {
        return `nui://vorp_inventory/html/img/items/${item.name}.png`;
    }
    return `nui://vorp_inventory/html/img/items/${item.name}.png`;
}

// side: 'player' | 'secondary' | 'drop'  ('drop' = non-interactive display)
function createSlotEl(item, side) {
    const slot     = document.createElement('div');
    const inner    = document.createElement('div');
    slot.className = 'item-slot';
    inner.className= 'item-slot-inner';

    if (!item) {
        slot.classList.add('empty-slot');
        slot.appendChild(inner);
        return slot;
    }

    slot.dataset.id   = item.id   != null ? item.id : '';
    slot.dataset.name = item.name || '';
    slot.dataset.type = item.type || 'item_standard';
    slot.dataset.side = side;

    if (side === 'drop') slot.classList.add('dropped-slot');

    const img = document.createElement('img');
    img.className   = 'item-img';
    img.src         = getItemImageUrl(item);
    img.alt         = item.label || item.name || '';
    img.draggable   = false;
    img.onerror     = function() {
        const noImg = document.createElement('div');
        noImg.className = 'item-no-img';
        noImg.textContent = L('no_image', 'NO IMAGE');
        if (this.parentNode) this.parentNode.replaceChild(noImg, this);
    };
    inner.appendChild(img);

    if (item.count != null && item.count > 0 && !(item.type === 'item_weapon' && item.count <= 0)) {
        const badge   = document.createElement('span');
        badge.className = 'item-count';
        badge.textContent = item.count;
        inner.appendChild(badge);
    }

    if (item.type === 'item_weapon' && item.used) {
        const dot    = document.createElement('div');
        dot.className= 'item-weapon-used';
        inner.appendChild(dot);
    }

    if (item.degradation != null && item.maxDegradation > 0) {
        const pct  = (item.degradation / item.maxDegradation) * 100;
        const dBar = document.createElement('div');
        dBar.className   = 'item-degradation';
        dBar.style.width = pct + '%';
        dBar.style.background = pct > 60 ? '#48c47c' : pct > 30 ? '#c4a030' : '#c44848';
        inner.appendChild(dBar);
    }

    slot.appendChild(inner);

    // Interactive only for player/secondary sides
    if (side !== 'drop') {
        slot.addEventListener('mousedown', ev => {
            if (ev.button !== 0) return;
            drag.item   = item;
            drag.side   = side;
            drag.startX = ev.clientX;
            drag.startY = ev.clientY;
            drag.active = false;
            drag.isHotbar = false;
        });

        slot.addEventListener('dblclick', ev => {
            ev.preventDefault();
            ev.stopPropagation();
            if (item.type === 'item_weapon') {
                if (item.used) {
                    nuiPost('UnequipWeapon', { id: item.id });
                } else {
                    nuiPost('UseItem', { id: item.id, type: item.type, item: item.name, name: item.name, hash: item.hash || 0, amount: item.count || 1 });
                }
            } else {
                nuiPost('UseItem', { id: item.id, type: item.type, item: item.name, name: item.name, hash: item.hash || 0, amount: item.count || 1 });
            }
        });

        slot.addEventListener('contextmenu', ev => {
            ev.preventDefault();
            ev.stopPropagation();
            openCtxMenu(item, ev.clientX, ev.clientY, side);
        });
    }

    slot.addEventListener('mouseenter', ev => showTooltip(item, ev));
    slot.addEventListener('mousemove',  ev => moveTooltip(ev));
    slot.addEventListener('mouseleave', () => hideTooltip());

    return slot;
}

function renderGrid(gridEl, items, filterFn) {
    gridEl.innerHTML = '';
    const filtered = items.filter(filterFn);
    for (let i = 0; i < TOTAL_SLOTS; i++) {
        const item = filtered[i] || null;
        gridEl.appendChild(createSlotEl(item, gridEl.id === 'player-grid' ? 'player' : 'secondary'));
    }
}

function renderPlayerGrid() {
    renderGrid(el.playerGrid, state.items, itemMatchesFilter);
}

// Right panel: secondary inventory OR drop/give panel
function renderSecondaryGrid() {
    if (state.secondaryType) {
        renderGrid(el.secondGrid, state.secondaryItems, itemMatchesSecondarySearch);
    } else {
        renderDropGivePanel();
    }
}

// Renders the right panel in drop or give mode (no secondary open)
function renderDropGivePanel() {
    el.secondGrid.innerHTML = '';

    if (state.activeTab === 'drop' && state.droppedItems.length > 0) {
        for (let i = 0; i < TOTAL_SLOTS; i++) {
            const item = state.droppedItems[i] || null;
            el.secondGrid.appendChild(createSlotEl(item, 'drop'));
        }
    } else if (state.activeTab === 'give') {
        const hint = document.createElement('div');
        hint.className   = 'give-hint';
        hint.textContent = L('give_zone_hint', 'Drag items here to give to a player');
        el.secondGrid.appendChild(hint);
        for (let i = 0; i < TOTAL_SLOTS; i++) {
            el.secondGrid.appendChild(createSlotEl(null, 'secondary'));
        }
    } else {
        for (let i = 0; i < TOTAL_SLOTS; i++) {
            el.secondGrid.appendChild(createSlotEl(null, 'secondary'));
        }
    }
}

// Track a drop locally (visual feedback in drop panel)
function trackDrop(item, qty) {
    if (state.activeTab !== 'drop') return;
    const existing = state.droppedItems.find(d => d.name === item.name && String(d.id) === String(item.id));
    if (existing) {
        existing.count = (existing.count || 1) + qty;
    } else {
        state.droppedItems.push(Object.assign({}, item, { count: qty }));
    }
    renderDropGivePanel();
}

// ============================================================
// STATS PANEL
// ============================================================
function updateStatsPanel() {
    el.statMoney.textContent = state.money.toFixed(2);
    el.statGold.textContent  = state.gold.toFixed(2);
    el.statId.textContent    = '#' + state.playerId;
    el.statJob.textContent   = (state.job || 'UNEMPLOYED').toUpperCase();
    // Update hotbar amounts
    if (el.hotbarMoney) el.hotbarMoney.textContent = state.money.toFixed(2);
    if (el.hotbarGold)  el.hotbarGold.textContent  = state.gold.toFixed(2);
}

function updateVitals() {
    const h = Math.max(0, Math.min(100, state.health));
    const n = Math.max(0, Math.min(100, state.hunger));
    const t = Math.max(0, Math.min(100, state.thirst));

    el.healthBar.style.width = h + '%';
    el.healthVal.textContent = h + ' %';
    el.hungerBar.style.width = n + '%';
    el.hungerVal.textContent = n + ' %';
    el.thirstBar.style.width = t + '%';
    el.thirstVal.textContent = t + ' %';
    el.tempVal.textContent = state.temperature + '°C';
}

function updateLocation() {
    el.locationRegion.textContent = state.location.region || '...';
    el.locationCity.textContent   = (state.location.city  || '').toUpperCase();
}

function updateWeight() {
    const w   = state.weight    || 0;
    const max = state.maxWeight || 35;
    const pct = Math.min(100, (w / max) * 100);
    el.weightDisplay.textContent = `${w.toFixed(1)} / ${max.toFixed(1)} KG`;
    el.weightBar.style.width     = pct + '%';
    el.weightBar.style.background = pct > 90 ? '#c44848' : pct > 70 ? '#c4a030' : '';
}

// ============================================================
// LANGUAGE
// ============================================================
function applyLang(lang) {
    if (!lang || typeof lang !== 'object') return;
    state.lang = lang;
    document.querySelectorAll('[data-lang]').forEach(el => {
        const key = el.dataset.lang;
        if (lang[key] !== undefined) el.textContent = lang[key];
    });
    document.querySelectorAll('[data-lang-ph]').forEach(el => {
        const key = el.dataset.langPh;
        if (lang[key] !== undefined) el.placeholder = lang[key];
    });
}

// ============================================================
// CLOTHING PANEL
// ============================================================
const CLOTHING_SLOTS = [
    { key: 'Hat',        cmd: 'hat',        langKey: 'cloth_hat'       },
    { key: 'EyeWear',    cmd: 'eyewear',    langKey: 'cloth_eyewear'   },
    { key: 'Mask',       cmd: 'mask',       langKey: 'cloth_mask'      },
    { key: 'NeckWear',   cmd: 'neckwear',   langKey: 'cloth_neckwear'  },
    { key: 'NeckTies',   cmd: 'tie',        langKey: 'cloth_necktie'   },
    { key: 'Shirt',      cmd: 'shirt',      langKey: 'cloth_shirt'     },
    { key: 'Vest',       cmd: 'vest',       langKey: 'cloth_vest'      },
    { key: 'Coat',       cmd: 'coat',       langKey: 'cloth_coat'      },
    { key: 'Poncho',     cmd: 'poncho',     langKey: 'cloth_poncho'    },
    { key: 'Cloak',      cmd: 'cloak',      langKey: 'cloth_cloak'     },
    { key: 'Glove',      cmd: 'glove',      langKey: 'cloth_glove'     },
    { key: 'Bracelet',   cmd: 'bracelet',   langKey: 'cloth_bracelet'  },
    { key: 'Pant',       cmd: 'pant',       langKey: 'cloth_pant'      },
    { key: 'Skirt',      cmd: 'skirt',      langKey: 'cloth_skirt'     },
    { key: 'Boots',      cmd: 'boots',      langKey: 'cloth_boots'     },
    { key: 'Spurs',      cmd: 'spurs',      langKey: 'cloth_spurs'     },
    { key: 'Gunbelt',    cmd: 'gunbelt',    langKey: 'cloth_gunbelt'   },
    { key: 'Holster',    cmd: 'holster',    langKey: 'cloth_holster'   },
    { key: 'Suspender',  cmd: 'suspender',  langKey: 'cloth_suspender' },
    { key: 'Belt',       cmd: 'belt',       langKey: 'cloth_belt'      },
    { key: 'Satchels',   cmd: 'satchels',   langKey: 'cloth_satchels'  },
    { key: 'Armor',      cmd: 'armor',      langKey: 'cloth_armor'     },
];

function renderClothingPanel() {
    const grid = document.getElementById('clothing-grid');
    if (!grid) return;
    grid.innerHTML = '';

    CLOTHING_SLOTS.forEach(slot => {
        const stateVal = state.clothingState[slot.key];
        const hasComp  = stateVal !== undefined;   // undefined = player has no clothing for this slot
        const isOn     = stateVal === true;
        const label    = (state.lang && state.lang[slot.langKey]) || slot.key.toUpperCase();

        const btn = document.createElement('button');
        btn.className = 'cloth-btn' + (isOn ? ' cloth-on' : '') + (!hasComp ? ' cloth-none' : '');
        btn.textContent = label;
        btn.title = label;
        btn.disabled = !hasComp;

        if (hasComp) {
            btn.addEventListener('click', () => {
                nuiPost('ToggleClothing', { command: slot.cmd });
            });
        }
        grid.appendChild(btn);
    });
}

// ============================================================
// CONTEXT MENU
// ============================================================
function openCtxMenu(item, x, y, side) {
    state.ctxItem = item;
    state.ctxSide = side;

    el.ctxItemName.textContent = (item.label || item.name || 'ITEM').toUpperCase();
    el.ctxItemDesc.textContent = item.desc || '';
    el.ctxItemDesc.style.display = item.desc ? '' : 'none';

    const isWeapon = item.type === 'item_weapon';
    const isMoney  = item.type === 'item_money';
    const isAmmo   = item.type === 'item_ammo';

    el.ctxUse.classList.toggle('hidden', isWeapon || isMoney || isAmmo);
    el.ctxEquip.classList.toggle('hidden', !isWeapon);
    el.ctxEquip.textContent = item.used ? L('ctx_unequip', 'UNEQUIP') : L('ctx_equip', 'EQUIP');
    el.ctxGive.classList.toggle('hidden', false);

    const hasSecondary = !!state.secondaryType;
    el.ctxMove.classList.toggle('hidden', !hasSecondary || side !== 'player');
    el.ctxTake.classList.toggle('hidden', !hasSecondary || side !== 'secondary');

    el.ctxMenu.classList.remove('hidden');
    const cw = el.ctxMenu.offsetWidth  || 160;
    const ch = el.ctxMenu.offsetHeight || 200;
    el.ctxMenu.style.left = Math.min(x, window.innerWidth  - cw - 8) + 'px';
    el.ctxMenu.style.top  = Math.min(y, window.innerHeight - ch - 8) + 'px';
}

function hideCtxMenu() {
    el.ctxMenu.classList.add('hidden');
    state.ctxItem = null;
}

el.ctxUse.addEventListener('click', () => {
    const item = state.ctxItem;
    if (!item) return;
    hideCtxMenu();
    nuiPost('UseItem', { id: item.id, type: item.type, item: item.name, name: item.name, hash: item.hash || 0, amount: item.count || 1 });
});

el.ctxEquip.addEventListener('click', () => {
    const item = state.ctxItem;
    if (!item) return;
    hideCtxMenu();
    if (item.used) {
        nuiPost('UnequipWeapon', { id: item.id });
    } else {
        nuiPost('UseItem', { id: item.id, type: item.type, item: item.name, name: item.name, hash: item.hash || 0, amount: item.count || 1 });
    }
});

el.ctxDrop.addEventListener('click', () => {
    const item = state.ctxItem;
    if (!item) return;
    hideCtxMenu();

    const maxQty = item.count || 1;
    const doDropAndTrack = qty => {
        nuiPost('DropItem', {
            item: item.name, id: item.id,
            type: item.type, number: qty,
            metadata: item.metadata, degradation: item.degradation,
        });
        trackDrop(item, qty);
    };

    if (maxQty <= 1 && item.type !== 'item_money') {
        doDropAndTrack(1);
    } else {
        openQtyModal(L('modal_qty_drop', 'DROP QUANTITY'), item.label || item.name, maxQty, doDropAndTrack);
    }
});

el.ctxGive.addEventListener('click', () => {
    const item = state.ctxItem;
    if (!item) return;
    hideCtxMenu();

    const maxQty = item.count || 1;
    const doGive = qty => {
        state.pendingGive = { item, qty };
        nuiPost('GetNearPlayers', {
            item: item.name, id: item.id,
            type: item.type, count: qty,
            metadata: item.metadata, hash: item.hash || 0,
        });
    };

    if (maxQty > 1 && item.type !== 'item_weapon') {
        openQtyModal(L('modal_qty_give', 'GIVE QUANTITY'), item.label || item.name, maxQty, doGive);
    } else {
        doGive(1);
    }
});

el.ctxMove.addEventListener('click', () => {
    const item = state.ctxItem;
    if (!item) return;
    hideCtxMenu();
    const maxQty = item.count || 1;
    const doMove = qty => nuiPost('MoveToCustom', {
        type: state.secondaryType, id: state.secondaryId,
        item: item.name, itemId: item.id,
        count: qty, metadata: item.metadata,
    });
    (maxQty > 1 && item.type !== 'item_weapon')
        ? openQtyModal(L('modal_qty_move', 'MOVE QUANTITY'), item.label || item.name, maxQty, doMove)
        : doMove(1);
});

el.ctxTake.addEventListener('click', () => {
    const item = state.ctxItem;
    if (!item) return;
    hideCtxMenu();
    const maxQty = item.count || 1;
    const doTake = qty => nuiPost('TakeFromCustom', {
        type: state.secondaryType, id: state.secondaryId,
        item: item.name, itemId: item.id,
        count: qty, metadata: item.metadata,
    });
    (maxQty > 1 && item.type !== 'item_weapon')
        ? openQtyModal(L('modal_qty_take', 'TAKE QUANTITY'), item.label || item.name, maxQty, doTake)
        : doTake(1);
});

// ============================================================
// NEAR PLAYERS MODAL
// ============================================================
function handleNearPlayers(d) {
    const players = d.players || [];
    const give    = state.pendingGive;
    if (!give) return;
    if (players.length === 0) return;

    el.giveItemLabel.textContent = `${(give.item.label || give.item.name).toUpperCase()} × ${give.qty}`;
    el.playersList.innerHTML = '';

    players.forEach(p => {
        const li = document.createElement('li');
        li.textContent = p.label || `Player ${p.player}`;
        li.addEventListener('click', () => {
            hidePlayersModal();
            nuiPost('GiveItem', {
                player: p.player,
                data: {
                    id:    give.item.id,
                    name:  give.item.name,
                    type:  give.item.type,
                    count: give.qty,
                    item:  give.item.name,
                    hash:  give.item.hash || 0,
                },
            });
            state.pendingGive = null;
        });
        el.playersList.appendChild(li);
    });

    el.playersOverlay.classList.remove('hidden');
}

function hidePlayersModal() {
    el.playersOverlay.classList.add('hidden');
    state.pendingGive = null;
}

el.playersCancel.addEventListener('click', hidePlayersModal);
el.playersOverlay.addEventListener('click', ev => {
    if (ev.target === el.playersOverlay) hidePlayersModal();
});

// ============================================================
// QUANTITY MODAL
// ============================================================
let _qtyCallback = null;

function openQtyModal(title, itemLabel, max, cb) {
    _qtyCallback = cb;
    el.qtyTitle.textContent    = title;
    el.qtyItemInfo.textContent = itemLabel || '';
    el.qtyInput.max    = max;
    el.qtyInput.value  = 1;
    el.qtySlider.max   = max;
    el.qtySlider.value = 1;
    el.qtyOverlay.classList.remove('hidden');
    el.qtyInput.focus();
    el.qtyInput.select();
}

function hideQtyModal() {
    el.qtyOverlay.classList.add('hidden');
    _qtyCallback = null;
}

el.qtyConfirm.addEventListener('click', () => {
    const qty = Math.max(1, Math.min(parseInt(el.qtyInput.value) || 1, parseInt(el.qtyInput.max) || 999));
    const cb = _qtyCallback;
    hideQtyModal();
    if (cb) cb(qty);
});

el.qtyCancel.addEventListener('click', hideQtyModal);

el.qtyMinus.addEventListener('click', () => {
    const v = Math.max(1, (parseInt(el.qtyInput.value) || 1) - 1);
    el.qtyInput.value = v; el.qtySlider.value = v;
});

el.qtyPlus.addEventListener('click', () => {
    const v = Math.min(parseInt(el.qtyInput.max) || 999, (parseInt(el.qtyInput.value) || 1) + 1);
    el.qtyInput.value = v; el.qtySlider.value = v;
});

el.qtyInput.addEventListener('input',  () => { el.qtySlider.value = el.qtyInput.value; });
el.qtySlider.addEventListener('input', () => { el.qtyInput.value  = el.qtySlider.value; });

el.qtyInput.addEventListener('keydown', ev => {
    if (ev.key === 'Enter')  el.qtyConfirm.click();
    if (ev.key === 'Escape') hideQtyModal();
});

el.qtyOverlay.addEventListener('click', ev => {
    if (ev.target === el.qtyOverlay) hideQtyModal();
});

// ============================================================
// TRANSACTION LOADER
// ============================================================
function showLoader(text) {
    el.loaderText.textContent = text || L('loader_default', 'Processing...');
    el.txLoader.classList.remove('hidden');
}
function hideLoader() {
    el.txLoader.classList.add('hidden');
}

// ============================================================
// TOOLTIP
// ============================================================
let tooltipEl = null;

function showTooltip(item, ev) {
    if (!tooltipEl) {
        tooltipEl = document.createElement('div');
        tooltipEl.id = 'cs-tooltip';
        document.body.appendChild(tooltipEl);
    }
    tooltipEl.innerHTML = '';

    const name = document.createElement('div');
    name.className   = 'tooltip-name';
    name.textContent = (item.label || item.name || '').toUpperCase();
    tooltipEl.appendChild(name);

    if (item.desc) {
        const desc = document.createElement('div');
        desc.className   = 'tooltip-desc';
        desc.textContent = item.desc;
        tooltipEl.appendChild(desc);
    }
    if (item.weight) {
        const wgt = document.createElement('div');
        wgt.className   = 'tooltip-weight';
        wgt.textContent = `${L('tooltip_weight', 'Weight')}: ${item.weight} kg`;
        tooltipEl.appendChild(wgt);
    }

    tooltipEl.classList.remove('hidden');
    moveTooltip(ev);
}

function moveTooltip(ev) {
    if (!tooltipEl) return;
    const x = ev.clientX + 12;
    const y = ev.clientY + 12;
    const tw = tooltipEl.offsetWidth  || 180;
    const th = tooltipEl.offsetHeight || 80;
    tooltipEl.style.left = Math.min(x, window.innerWidth  - tw - 8) + 'px';
    tooltipEl.style.top  = Math.min(y, window.innerHeight - th - 8) + 'px';
}

function hideTooltip() {
    if (tooltipEl) tooltipEl.classList.add('hidden');
}

// ============================================================
// CATEGORY FILTER
// ============================================================
el.catBar.querySelectorAll('.cat-btn').forEach(btn => {
    btn.addEventListener('click', () => {
        el.catBar.querySelectorAll('.cat-btn').forEach(b => b.classList.remove('active'));
        btn.classList.add('active');
        state.filter = btn.dataset.cat || 'all';
        renderPlayerGrid();
    });
});

// ============================================================
// SEARCH
// ============================================================
el.playerSearch.addEventListener('input', () => {
    state.playerQuery = el.playerSearch.value;
    renderPlayerGrid();
});

el.secondSearch.addEventListener('input', () => {
    state.secondaryQuery = el.secondSearch.value;
    renderSecondaryGrid();
});

// ============================================================
// PANEL TABS
// ============================================================
el.panelTabs.querySelectorAll('.tab-btn').forEach(btn => {
    btn.addEventListener('click', () => {
        if (btn.dataset.tab === 'trade') {
            nuiPost('StartTrade', {});
            return;
        }
        el.panelTabs.querySelectorAll('.tab-btn').forEach(b => b.classList.remove('active'));
        btn.classList.add('active');
        state.activeTab = btn.dataset.tab;
        if (!state.secondaryType) renderDropGivePanel();
    });
});

// ============================================================
// KEYBOARD EVENTS
// ============================================================
document.addEventListener('keydown', ev => {
    // Escape during trade selector (dots)
    if (_tradeSelecting && (ev.key === 'Escape' || ev.keyCode === 113)) {
        ev.preventDefault();
        closeTradeSelectorUI();
        if (state.open) el.inv.classList.remove('hidden');
        nuiPost('TradeSelectCancel', {});
        return;
    }
    if (!state.open) return;
    if (ev.key === 'Escape' || ev.keyCode === 113) {
        ev.preventDefault();
        if (_ammoPopupOpen) { hideAmmoPopup(); return; }
        if (el.qtyOverlay && !el.qtyOverlay.classList.contains('hidden')) { hideQtyModal(); return; }
        if (el.playersOverlay && !el.playersOverlay.classList.contains('hidden')) { hidePlayersModal(); return; }
        if (state.tradeActive) { cancelTradeAndClose(); return; }
        nuiPost('NUIFocusOff', {});
    }
});

// ============================================================
// CLOSE ON BACKGROUND CLICK
// ============================================================
document.addEventListener('click', ev => {
    if (!el.ctxMenu.classList.contains('hidden')) {
        if (!el.ctxMenu.contains(ev.target)) hideCtxMenu();
    }
    if (_ammoPopupOpen) {
        const popup = $('ammo-popup');
        const hotbarA = $('hotbar-a');
        if (popup && !popup.contains(ev.target) && hotbarA && !hotbarA.contains(ev.target)) {
            hideAmmoPopup();
        }
    }
    hideTooltip();
});

document.addEventListener('contextmenu', ev => {
    if (!ev.target.closest('.item-slot')) ev.preventDefault();
});

// ============================================================
// DRAG & DROP
// ============================================================
const drag = {
    item: null, side: null,
    ghost: null,
    startX: 0, startY: 0,
    active: false,
    isHotbar: false,
};

function ptInRect(x, y, r) {
    return x >= r.left && x <= r.right && y >= r.top && y <= r.bottom;
}

function clearDrag() {
    if (drag.ghost) { drag.ghost.remove(); drag.ghost = null; }
    el.secondGrid.classList.remove('dz-hover');
    el.playerGrid.classList.remove('dz-hover');
    Object.assign(drag, { item: null, side: null, active: false, ghost: null, isHotbar: false });
}

function executeDrop(item) {
    const maxQty = item.count || 1;
    const doDropAndTrack = qty => {
        nuiPost('DropItem', {
            item: item.name, id: item.id,
            type: item.type, number: qty,
            metadata: item.metadata, degradation: item.degradation,
        });
        trackDrop(item, qty);
    };
    if (maxQty <= 1 || item.type === 'item_weapon') {
        doDropAndTrack(1);
    } else {
        openQtyModal(L('modal_qty_drop', 'DROP QUANTITY'), item.label || item.name, maxQty, doDropAndTrack);
    }
}

function executeMove(item) {
    const doMove = qty => nuiPost('MoveToCustom', {
        type: state.secondaryType, id: state.secondaryId,
        item: item.name, itemId: item.id,
        count: qty, metadata: item.metadata,
    });
    const maxQty = item.count || 1;
    (maxQty > 1 && item.type !== 'item_weapon')
        ? openQtyModal(L('modal_qty_move', 'MOVE QUANTITY'), item.label || item.name, maxQty, doMove)
        : doMove(1);
}

function executeTake(item) {
    const doTake = qty => nuiPost('TakeFromCustom', {
        type: state.secondaryType, id: state.secondaryId,
        item: item.name, itemId: item.id,
        count: qty, metadata: item.metadata,
    });
    const maxQty = item.count || 1;
    (maxQty > 1 && item.type !== 'item_weapon')
        ? openQtyModal(L('modal_qty_take', 'TAKE QUANTITY'), item.label || item.name, maxQty, doTake)
        : doTake(1);
}

// Give an item from inventory to a nearby player
function executeGive(item) {
    const maxQty = item.count || 1;
    const doGive = qty => {
        state.pendingGive = { item, qty };
        nuiPost('GetNearPlayers', {
            item: item.name, id: item.id,
            type: item.type, count: qty,
            metadata: item.metadata, hash: item.hash || 0,
        });
    };
    if (maxQty > 1 && item.type !== 'item_weapon') {
        openQtyModal(L('modal_qty_give', 'GIVE QUANTITY'), item.label || item.name, maxQty, doGive);
    } else {
        doGive(1);
    }
}

// Give money from hotbar M slot
function openMoneyGive() {
    if (state.money <= 0) return;
    const max = Math.max(1, Math.floor(state.money));
    openQtyModal(L('modal_qty_cash', 'GIVE CASH'), `$ ${state.money.toFixed(2)}`, max, qty => {
        const fakeItem = { name: 'money', type: 'item_money', id: 0, label: 'Cash', hash: 0 };
        state.pendingGive = { item: fakeItem, qty };
        nuiPost('GetNearPlayers', { item: 'money', id: 0, type: 'item_money', count: qty, hash: 0 });
    });
}

// Give gold from hotbar G slot
function openGoldGive() {
    if (state.gold <= 0) return;
    const max = Math.max(1, Math.floor(state.gold));
    openQtyModal(L('modal_qty_gold', 'GIVE GOLD'), `◆ ${state.gold.toFixed(2)}`, max, qty => {
        const fakeItem = { name: 'gold', type: 'item_gold', id: 0, label: 'Gold', hash: 0 };
        state.pendingGive = { item: fakeItem, qty };
        nuiPost('GetNearPlayers', { item: 'gold', id: 0, type: 'item_gold', count: qty, hash: 0 });
    });
}

document.addEventListener('mousemove', ev => {
    if (!drag.item) return;

    if (!drag.active) {
        if (Math.hypot(ev.clientX - drag.startX, ev.clientY - drag.startY) < 8) return;
        drag.active = true;
        drag.ghost  = document.createElement('div');
        drag.ghost.className = 'drag-ghost';

        const ghostImg = document.createElement('img');
        if (drag.item.type === 'item_money') {
            ghostImg.src = 'nui://vorp_inventory/html/img/items/money.png';
        } else if (drag.item.type === 'item_gold') {
            ghostImg.src = 'nui://vorp_inventory/html/img/items/goldbar.png';
        } else {
            ghostImg.src = getItemImageUrl(drag.item);
        }
        ghostImg.onerror = () => { ghostImg.style.display = 'none'; ghostImg.onerror = null; };
        drag.ghost.appendChild(ghostImg);
        document.body.appendChild(drag.ghost);
    }

    drag.ghost.style.left = (ev.clientX - 24) + 'px';
    drag.ghost.style.top  = (ev.clientY - 24) + 'px';

    // Use full right panel as drop zone so tabs/search bar don't block drops
    const rightPanel = el.secondGrid.parentElement;
    const rS = rightPanel ? rightPanel.getBoundingClientRect() : el.secondGrid.getBoundingClientRect();
    const rP = el.playerGrid.getBoundingClientRect();
    const overSecond = ptInRect(ev.clientX, ev.clientY, rS);
    const overPlayer = ptInRect(ev.clientX, ev.clientY, rP);

    el.secondGrid.classList.toggle('dz-hover', overSecond && drag.side === 'player');
    el.playerGrid.classList.toggle('dz-hover', overPlayer && (drag.side === 'secondary' || drag.side === 'player'));

    if (overSecond && drag.side === 'player') {
        el.secondGrid.dataset.dropLabel = state.secondaryType ? L('dz_transfer', 'TRANSFER')
            : state.tradeActive ? L('dz_offer', 'OFFER')
            : (state.activeTab === 'give' ? L('dz_give', 'GIVE') : L('dz_drop', 'DROP'));
    }
});

document.addEventListener('mouseup', ev => {
    if (!drag.item || !drag.active) { clearDrag(); return; }

    // Use full right panel as drop zone (same as mousemove)
    const rightPanel = el.secondGrid.parentElement;
    const rS = rightPanel ? rightPanel.getBoundingClientRect() : el.secondGrid.getBoundingClientRect();
    const rP = el.playerGrid.getBoundingClientRect();

    if (ptInRect(ev.clientX, ev.clientY, rS) && drag.side === 'player') {
        const item = drag.item;
        clearDrag();
        if (state.secondaryType) {
            executeMove(item);
        } else if (state.tradeActive) {
            executeAddToTrade(item);
        } else if (state.activeTab === 'give') {
            executeGive(item);
        } else {
            executeDrop(item);
        }
    } else if (ptInRect(ev.clientX, ev.clientY, rP) && drag.side === 'secondary' && state.secondaryType) {
        const item = drag.item;
        clearDrag();
        executeTake(item);
    } else if (ptInRect(ev.clientX, ev.clientY, rP) && drag.side === 'player') {
        const item = drag.item;
        const dropX = ev.clientX, dropY = ev.clientY;
        clearDrag();
        const els = document.elementsFromPoint(dropX, dropY);
        const targetSlot = els.find(e => e.classList.contains('item-slot'));
        if (!targetSlot) { return; }

        const fromKey = (item.type || 'item_standard') + '_' + item.id;
        const allSlots = Array.from(el.playerGrid.children);
        const targetSlotIdx = allSlots.indexOf(targetSlot);

        // Filtered items currently displayed (in order)
        const filtered = state.items.filter(itemMatchesFilter);
        const fromFilteredIdx = filtered.findIndex(i => (i.type || 'item_standard') + '_' + i.id === fromKey);
        if (fromFilteredIdx === -1) return;

        // Clamp: drop beyond last item → move to end
        const toFilteredIdx = Math.min(targetSlotIdx, filtered.length - 1);
        if (fromFilteredIdx === toFilteredIdx) return;

        // Reorder filtered array
        const newFiltered = [...filtered];
        const [moved] = newFiltered.splice(fromFilteredIdx, 1);
        newFiltered.splice(toFilteredIdx, 0, moved);

        // Rebuild state.items: swap filtered items in place, keep unfiltered untouched
        let ptr = 0;
        state.items = state.items.map(i => itemMatchesFilter(i) ? newFiltered[ptr++] : i);

        renderPlayerGrid();
        const order = state.items.map(i => ({ type: i.type || 'item_standard', id: i.id }));
        nuiPost('SaveInventoryLayout', { order });
    } else {
        clearDrag();
    }
});

// ============================================================
// AMMO DISPLAY
// ============================================================
function updateAmmoSlot() {
    const totalAmmo = Object.values(state.ammoData).reduce((s, v) => s + (v || 0), 0);
    const badge = document.querySelector('#hotbar-a .hotbar-hamount');
    if (badge) badge.textContent = totalAmmo > 0 ? totalAmmo : '';
}

function renderAmmoPopup() {
    const list = $('ammo-popup-list');
    if (!list) return;
    list.innerHTML = '';
    const ammo   = state.ammoData;
    const labels = state.ammoLabels;
    const keys   = Object.keys(ammo || {}).filter(k => ammo[k] > 0);

    if (keys.length === 0) {
        const empty = document.createElement('div');
        empty.className = 'ammo-popup-empty';
        empty.textContent = L('no_ammo', 'NO AMMUNITION');
        list.appendChild(empty);
        return;
    }
    keys.forEach(ammoType => {
        const row = document.createElement('div');
        row.className = 'ammo-popup-row';

        const img = document.createElement('img');
        img.className = 'ammo-popup-img';
        img.src = `nui://vorp_inventory/html/img/items/${ammoType.toLowerCase()}.png`;
        img.onerror = function() { this.src = 'nui://vorp_inventory/html/img/items/ammopistolnormal.png'; this.onerror = null; };

        const lbl = document.createElement('span');
        lbl.className = 'ammo-popup-label';
        lbl.textContent = (labels[ammoType] || ammoType).toUpperCase();

        const cnt = document.createElement('span');
        cnt.className = 'ammo-popup-count';
        cnt.textContent = ammo[ammoType];

        row.appendChild(img);
        row.appendChild(lbl);
        row.appendChild(cnt);
        list.appendChild(row);
    });
}

function showAmmoPopup() {
    renderAmmoPopup();
    const popup = $('ammo-popup');
    if (popup) popup.classList.remove('hidden');
    _ammoPopupOpen = true;
}

function hideAmmoPopup() {
    const popup = $('ammo-popup');
    if (popup) popup.classList.add('hidden');
    _ammoPopupOpen = false;
}

// ============================================================
// HOTBAR HANDLERS
// ============================================================
(function initHotbar() {
    const hotbarA = $('hotbar-a');
    const hotbarM = $('hotbar-m');
    const hotbarG = $('hotbar-g');

    // A = Toggle ammo popup
    if (hotbarA) {
        hotbarA.addEventListener('click', () => {
            if (_ammoPopupOpen) { hideAmmoPopup(); return; }
            showAmmoPopup();
            _ammoPanelPending = true;
            nuiPost('RequestAmmoData', {});
        });
    }

    // M = Money: double-click to give, drag to give/drop zone
    if (hotbarM) {
        hotbarM.addEventListener('dblclick', openMoneyGive);
        hotbarM.addEventListener('mousedown', ev => {
            if (ev.button !== 0 || state.money <= 0) return;
            drag.item   = { name: 'money', type: 'item_money', id: 0, label: 'Cash', count: Math.floor(state.money), hash: 0 };
            drag.side   = 'player';
            drag.startX = ev.clientX;
            drag.startY = ev.clientY;
            drag.active = false;
            drag.isHotbar = true;
        });
    }

    // G = Gold: double-click to give, drag to give/drop zone
    if (hotbarG) {
        hotbarG.addEventListener('dblclick', openGoldGive);
        hotbarG.addEventListener('mousedown', ev => {
            if (ev.button !== 0 || state.gold <= 0) return;
            drag.item   = { name: 'gold', type: 'item_gold', id: 0, label: 'Gold', count: Math.floor(state.gold), hash: 0 };
            drag.side   = 'player';
            drag.startX = ev.clientX;
            drag.startY = ev.clientY;
            drag.active = false;
            drag.isHotbar = true;
        });
    }
})();

// ============================================================
// CLOSE BUTTON
// ============================================================
if (el.closeBtn) {
    el.closeBtn.addEventListener('click', () => {
        if (!state.open) return;
        if (state.tradeActive) { cancelTradeAndClose(); return; }
        nuiPost('NUIFocusOff', {});
    });
}

// ============================================================
// TRADE SYSTEM
// ============================================================

let _tradeSelecting = false;
const _tradeMarkers = new Map();

function openTradeSelectorUI() {
    _tradeSelecting = true;
    el.inv.classList.add('hidden');
    $('trade-selector').classList.remove('hidden');
}

function closeTradeSelectorUI() {
    _tradeSelecting = false;
    $('trade-selector').classList.add('hidden');
    _tradeMarkers.forEach(m => m.remove());
    _tradeMarkers.clear();
}

function updateTradeDots(players) {
    const layer = $('trade-dots-layer');
    const ids   = new Set(players.map(p => p.id));

    _tradeMarkers.forEach((el, id) => {
        if (!ids.has(id)) { el.remove(); _tradeMarkers.delete(id); }
    });

    for (const p of players) {
        const px = p.x * window.innerWidth;
        const py = p.y * window.innerHeight;

        if (_tradeMarkers.has(p.id)) {
            const m = _tradeMarkers.get(p.id);
            m.style.left = px + 'px';
            m.style.top  = py + 'px';
        } else {
            const m = buildTradeMarker(p.id, p.dist, p.name);
            m.style.left = px + 'px';
            m.style.top  = py + 'px';
            layer.appendChild(m);
            _tradeMarkers.set(p.id, m);
        }
    }
}

function buildTradeMarker(id, dist, name) {
    const wrap = document.createElement('div');
    wrap.className = 'trade-marker';
    const displayName = (name || `Player ${id}`).toUpperCase();
    wrap.innerHTML = `
        <div class="tm-dot">
            <div class="tm-ring"></div>
            <div class="tm-ring"></div>
            <div class="tm-ring"></div>
            <div class="tm-core"></div>
        </div>
        <div class="tm-label">${displayName} &bull; ${dist}m</div>`;
    wrap.addEventListener('click', e => {
        e.stopPropagation();
        _tradeMarkers.forEach(m => { m.style.pointerEvents = 'none'; });
        wrap.classList.add('selecting');
        setTimeout(() => {
            closeTradeSelectorUI();
            nuiPost('TradeSelectPlayer', { id });
        }, 200);
    });
    return wrap;
}

$('trade-dots-layer').addEventListener('click', e => {
    if (e.target === $('trade-dots-layer')) {
        closeTradeSelectorUI();
        if (state.open) el.inv.classList.remove('hidden');
        nuiPost('TradeSelectCancel', {});
    }
});

// ---- Active trade UI ----

function openTradeMode(sessionId, partner, partnerName) {
    state.tradeActive      = true;
    state.tradeSessionId   = sessionId;
    state.myOffer          = [];
    state.theirOffer       = [];
    state.myValidated      = false;
    state.partnerValidated = false;
    el.tradeRequestOverlay.classList.add('hidden');
    el.tradeStatusBar.textContent  = `TRADE — ${(partnerName || ('PLAYER ' + partner)).toUpperCase()}`;
    el.tradeStatusBar.style.color  = '';
    el.tradeValidateBtn.disabled   = false;
    el.tradeValidateBtn.textContent = L('trade_validate', 'VALIDATE');
    el.tradePanel.classList.remove('hidden');
    renderMyOffer();
    renderTheirOffer();
}

function closeTrade(success) {
    state.tradeActive      = false;
    state.tradeSessionId   = null;
    state.myOffer          = [];
    state.theirOffer       = [];
    state.myValidated      = false;
    state.partnerValidated = false;
    if (el.tradePanel) el.tradePanel.classList.add('hidden');
    if (success) renderPlayerGrid();
}

function cancelTradeAndClose() {
    if (state.tradeSessionId) {
        nuiPost('CancelTrade', { sessionId: state.tradeSessionId });
    }
    closeTrade(false);
    nuiPost('NUIFocusOff', {});
}

function renderMyOffer() {
    el.myOfferItems.innerHTML = '';
    if (state.myOffer.length === 0) {
        const h = document.createElement('div');
        h.className = 'trade-hint';
        h.textContent = L('trade_drag_hint', 'Drag items here');
        el.myOfferItems.appendChild(h);
        return;
    }
    state.myOffer.forEach((item, idx) => {
        const row = document.createElement('div');
        row.className = 'trade-item-row';
        const img = document.createElement('img');
        img.className = 'trade-item-img';
        img.src = getItemImageUrl(item);
        img.onerror = () => { const n = document.createElement('div'); n.className = 'item-no-img'; n.textContent = L('no_image', 'NO IMAGE'); if (img.parentNode) img.parentNode.replaceChild(n, img); };
        const lbl = document.createElement('span');
        lbl.className = 'trade-item-label';
        lbl.textContent = (item.label || item.name || 'ITEM').toUpperCase();
        const cnt = document.createElement('span');
        cnt.className = 'trade-item-count';
        cnt.textContent = '× ' + (item.count || 1);
        row.appendChild(img); row.appendChild(lbl); row.appendChild(cnt);
        if (!state.myValidated) {
            const rm = document.createElement('span');
            rm.className = 'trade-item-remove';
            rm.textContent = '×';
            rm.title = 'Remove';
            rm.addEventListener('click', () => {
                if (state.myValidated) return;
                state.myOffer.splice(idx, 1);
                renderMyOffer();
                nuiPost('TradeOffer', { sessionId: state.tradeSessionId, offer: state.myOffer });
            });
            row.appendChild(rm);
        }
        el.myOfferItems.appendChild(row);
    });
}

function renderTheirOffer() {
    el.theirOfferItems.innerHTML = '';
    if (state.theirOffer.length === 0) {
        const h = document.createElement('div');
        h.className = 'trade-hint';
        h.textContent = L('trade_waiting', 'Waiting...');
        el.theirOfferItems.appendChild(h);
        return;
    }
    state.theirOffer.forEach(item => {
        const row = document.createElement('div');
        row.className = 'trade-item-row';
        const img = document.createElement('img');
        img.className = 'trade-item-img';
        img.src = getItemImageUrl(item);
        img.onerror = () => { const n = document.createElement('div'); n.className = 'item-no-img'; n.textContent = L('no_image', 'NO IMAGE'); if (img.parentNode) img.parentNode.replaceChild(n, img); };
        const lbl = document.createElement('span');
        lbl.className = 'trade-item-label';
        lbl.textContent = (item.label || item.name || 'ITEM').toUpperCase();
        const cnt = document.createElement('span');
        cnt.className = 'trade-item-count';
        cnt.textContent = '× ' + (item.count || 1);
        row.appendChild(img); row.appendChild(lbl); row.appendChild(cnt);
        el.theirOfferItems.appendChild(row);
    });
}

function executeAddToTrade(item) {
    if (!state.tradeActive || state.myValidated) return;
    const existing      = state.myOffer.find(o => String(o.id) === String(item.id) && o.name === item.name);
    const alreadyOffered = existing ? (existing.count || 1) : 0;
    const available      = (item.count || 1) - alreadyOffered;
    if (available <= 0) return;

    const doAdd = qty => {
        if (existing) {
            existing.count = (existing.count || 0) + qty;
        } else {
            state.myOffer.push({
                id: item.id, name: item.name, label: item.label,
                type: item.type, count: qty, hash: item.hash || 0,
            });
        }
        renderMyOffer();
        nuiPost('TradeOffer', { sessionId: state.tradeSessionId, offer: state.myOffer });
    };

    if (available > 1) {
        openQtyModal(L('modal_qty_trade', 'ADD TO TRADE'), item.label || item.name, available, doAdd);
    } else {
        doAdd(1);
    }
}

// Validate button
if (el.tradeValidateBtn) {
    el.tradeValidateBtn.addEventListener('click', () => {
        if (!state.tradeActive || state.myValidated || !state.tradeSessionId) return;
        state.myValidated = true;
        el.tradeValidateBtn.disabled    = true;
        el.tradeValidateBtn.textContent = L('trade_waiting_confirm', 'WAITING...');
        el.tradeStatusBar.textContent   = L('trade_offer_validated', 'OFFER VALIDATED — WAITING FOR PARTNER');
        el.tradeStatusBar.style.color   = '';
        nuiPost('ValidateTrade', { sessionId: state.tradeSessionId });
    });
}

// Cancel button
if (el.tradeCancelBtn) {
    el.tradeCancelBtn.addEventListener('click', cancelTradeAndClose);
}

// Accept trade request
if (el.tradeAcceptBtn) {
    el.tradeAcceptBtn.addEventListener('click', () => {
        el.tradeRequestOverlay.classList.add('hidden');
        nuiPost('AcceptTrade', {});
    });
}

// Refuse trade request
if (el.tradeRefuseBtn) {
    el.tradeRefuseBtn.addEventListener('click', () => {
        el.tradeRequestOverlay.classList.add('hidden');
        nuiPost('RefuseTrade', {});
    });
}

// ============================================================
// INIT
// ============================================================
(function init() {
    handleHide();
    renderPlayerGrid();
    renderSecondaryGrid();
})();
