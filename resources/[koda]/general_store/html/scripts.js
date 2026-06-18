/* global GetParentResourceName */

const CARD_FRAME_CORNERS = `
    <svg class="card-frame-corner card-frame-corner--tl" aria-hidden="true"><use href="#ornament-frame-corner" /></svg>
    <svg class="card-frame-corner card-frame-corner--tr" aria-hidden="true"><use href="#ornament-frame-corner" /></svg>
    <svg class="card-frame-corner card-frame-corner--bl" aria-hidden="true"><use href="#ornament-frame-corner" /></svg>
    <svg class="card-frame-corner card-frame-corner--br" aria-hidden="true"><use href="#ornament-frame-corner" /></svg>
`;

/* ============================================================
   TOAST SYSTEM
   ============================================================ */

const toastStack = document.getElementById('toastStack');

const TOAST_ICONS = { success: '✓', error: '✗', info: '◆' };
const TOAST_DEFAULT_MS = 4200;

function showToast(type, title, msg, durationMs) {
    if (!toastStack) return;
    const dur = durationMs || TOAST_DEFAULT_MS;
    const icon = TOAST_ICONS[type] || '◆';

    const el = document.createElement('div');
    el.className = `toast toast--${type}`;
    el.setAttribute('role', 'status');
    el.innerHTML = `
        <div class="toast-bar-track">
            <div class="toast-bar-fill" style="animation: toastBarDrain ${dur}ms linear forwards;"></div>
        </div>
        <div class="toast-inner">
            <span class="toast-icon" aria-hidden="true">${icon}</span>
            <div class="toast-body">
                <div class="toast-title">${escapeHtml(title)}</div>
                ${msg ? `<div class="toast-msg">${escapeHtml(msg)}</div>` : ''}
            </div>
        </div>
        <div class="toast-ornament" aria-hidden="true">
            <span class="toast-ornament-line"></span>
            <span class="toast-ornament-glyph">&#10022; &#10022; &#10022;</span>
            <span class="toast-ornament-line"></span>
        </div>
    `;

    toastStack.appendChild(el);

    const dismiss = () => {
        el.classList.add('toast--leaving');
        el.addEventListener('animationend', () => el.remove(), { once: true });
    };

    const timer = setTimeout(dismiss, dur);
    el.addEventListener('click', () => { clearTimeout(timer); dismiss(); });
}

/* ============================================================
   APP
   ============================================================ */

const app = document.getElementById('app');
const storeTitle = document.getElementById('storeTitle');
const storeKicker = document.getElementById('storeKicker');
const storeLogo = document.getElementById('storeLogo');
const walletValue = document.getElementById('walletValue');
const categoryList = document.getElementById('categoryList');
const productGrid = document.getElementById('productGrid');
const searchInput = document.getElementById('searchInput');
const cartBody = document.getElementById('cartBody');
const cartTotal = document.getElementById('cartTotal');
const btnClose = document.getElementById('btnClose');
const btnCheckout = document.getElementById('btnCheckout');
const btnClear = document.getElementById('btnClear');
const cartModal = document.getElementById('cartModal');
const cartModalScrim = document.getElementById('cartModalScrim');
const btnCloseCartModal = document.getElementById('btnCloseCartModal');
const btnOpenBag = document.getElementById('btnOpenBag');
const cartBadge = document.getElementById('cartBadge');
const btnSellMode = document.getElementById('btnSellMode');
const sellBadge = document.getElementById('sellBadge');
const btnManageStore = document.getElementById('btnManageStore');
const manageRoleBadge = document.getElementById('manageRoleBadge');
const manageModal = document.getElementById('manageModal');
const manageModalScrim = document.getElementById('manageModalScrim');
const btnCloseManage = document.getElementById('btnCloseManage');
const manageBody = document.getElementById('manageBody');
const propRotateZone = document.getElementById('propRotateZone');
const rotateHint = document.getElementById('rotateHint');
const shellPane = document.querySelector('.shell');

const SHELL_ENTER_MS = 370;
const SHELL_EXIT_MS = 280;
const CARD_EXIT_MS = 240;
const CARD_ENTER_MS = 360;
const CARD_STAGGER_MS = 42;

let shellEnterCleanupTimer = null;
let shellExitTimer = null;
let uiClosing = false;
let productGridRenderId = 0;

let state = {
    open: false,
    storeId: null,
    moneyType: 'cash',
    categories: [],
    catalog: [],
    buyCatalog: [],
    marketMode: 'shop',
    activeCategory: 'all',
    cart: new Map(),
    selectedItem: null,
    logo: '',
    management: null,
    stock: {},   // itemName (lowercase) → current stock count
};

let worldPreviewTimer = null;
let manageState = {
    open: false,
    tab: 'details',
    data: null,
};

function fmtMoney(n) {
    const v = Number(n) || 0;
    return `$${v.toFixed(2)}`;
}

function resName() {
    try {
        return GetParentResourceName();
    } catch {
        return 'general_store';
    }
}

function postNui(endpoint, data) {
    return fetch(`https://${resName()}/${endpoint}`, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json; charset=UTF-8' },
        body: JSON.stringify(data ?? {}),
    }).then((r) => r.json().catch(() => ({})));
}

function withTimeout(promise, ms, fallback) {
    return Promise.race([
        promise,
        new Promise((resolve) => setTimeout(() => resolve(fallback), ms)),
    ]);
}

function catalogPropModel(p) {
    if (!p) return '';
    const raw = p.prop || p.propModel;
    return typeof raw === 'string' ? raw.trim() : '';
}

function catalogHasShowcase(p) {
    return catalogPropModel(p).length > 0;
}

function setShowcaseChrome(on) {
    if (!propRotateZone || !rotateHint) return;
    propRotateZone.classList.toggle('is-visible', on);
    propRotateZone.setAttribute('aria-hidden', on ? 'false' : 'true');
    rotateHint.classList.toggle('is-visible', on);
}

function firstShowcaseProduct(list) {
    if (!list || list.length === 0) return null;
    const withProp = list.find((p) => catalogHasShowcase(p));
    return withProp || list[0];
}

/** Spawns vitrine prop for the clicked catalog row only. */
function scheduleWorldPreview(p) {
    clearTimeout(worldPreviewTimer);
    worldPreviewTimer = setTimeout(() => {
        worldPreviewTimer = null;
        if (!state.storeId || !state.open || uiClosing) return;
        if (!p) {
            postNui('worldPreview', { storeId: state.storeId, item: false });
            setShowcaseChrome(false);
            return;
        }
        const propModel = catalogPropModel(p);
        postNui('worldPreview', {
            storeId: state.storeId,
            item: p.item,
            label: p.label,
            price: p.price,
            prop: propModel || null,
            propModel: propModel || null,
            propType: p.propType || 'object',
            propRotation: p.propRotation || null,
        });
        setShowcaseChrome(catalogHasShowcase(p));
    }, 72);
}

function primeShellEnterAnimation() {
    if (!shellPane) return;
    shellPane.classList.remove('shell-exiting', 'shell-enter', 'shell-open');
    shellPane.offsetWidth;
    shellPane.classList.add('shell-enter');
    clearTimeout(shellEnterCleanupTimer);
    shellEnterCleanupTimer = setTimeout(() => {
        shellEnterCleanupTimer = null;
        if (!shellPane || !state.open || uiClosing) return;
        shellPane.classList.remove('shell-enter');
        shellPane.classList.add('shell-open');
    }, SHELL_ENTER_MS);
}

/**
 * @param {{ notifyLua?: boolean }} opts — set notifyLua false when Lua already requested close (`action:close`).
 */
function runShellExitAnimation(opts) {
    const notifyLua = opts && opts.notifyLua;
    const sp = shellPane;
    clearTimeout(shellEnterCleanupTimer);
    shellEnterCleanupTimer = null;
    clearTimeout(shellExitTimer);
    if (!sp || uiClosing || !app.classList.contains('is-open')) {
        return;
    }
    uiClosing = true;
    clearTimeout(worldPreviewTimer);
    if (state.storeId) {
        postNui('worldPreview', { storeId: state.storeId, item: false });
    }
    closeCartModal();
    closeManageModal();
    setShowcaseChrome(false);

    sp.classList.remove('shell-enter', 'shell-open');
    sp.offsetWidth;
    sp.classList.add('shell-exiting');

    shellExitTimer = setTimeout(() => {
        shellExitTimer = null;
        uiClosing = false;
        state.open = false;
        app.classList.remove('is-open');
        sp.classList.remove('shell-exiting');
        app.setAttribute('aria-hidden', 'true');
        if (notifyLua !== false) {
            postNui('close', {});
        }
    }, SHELL_EXIT_MS);
}

function cartLinesArray() {
    const arr = [];
    state.cart.forEach((row) => {
        if (row.qty > 0) arr.push({ item: row.item, qty: row.qty });
    });
    return arr;
}

function cartItemCount() {
    let n = 0;
    state.cart.forEach((row) => {
        if (row.qty > 0) n += row.qty;
    });
    return n;
}

function cartTotalValue() {
    let t = 0;
    state.cart.forEach((row) => {
        t += row.price * row.qty;
    });
    return t;
}

function cartModalOpen() {
    return cartModal && cartModal.classList.contains('is-open');
}

function openCartModal() {
    if (!cartModal || cartLinesArray().length === 0) return;
    cartModal.classList.add('is-open');
    cartModal.setAttribute('aria-hidden', 'false');
}

function closeCartModal() {
    if (!cartModal) return;
    cartModal.classList.remove('is-open');
    cartModal.setAttribute('aria-hidden', 'true');
}

function escapeHtml(s) {
    return String(s)
        .replace(/&/g, '&amp;')
        .replace(/</g, '&lt;')
        .replace(/>/g, '&gt;')
        .replace(/"/g, '&quot;');
}

function resolveImageRef(raw) {
    const value = String(raw || '').trim();
    if (!value) return '';
    if (/^(https?:|nui:|data:image\/)/i.test(value)) return value;
    const safe = value.replace(/[\\/]/g, '');
    if (!safe || safe.includes('..')) return '';
    return `nui://${resName()}/html/images/${safe}`;
}

function applyStoreLogo(raw) {
    if (!storeLogo) return;
    const src = resolveImageRef(raw);
    if (!src) {
        storeLogo.hidden = true;
        storeLogo.removeAttribute('src');
        return;
    }
    storeLogo.src = src;
    storeLogo.hidden = false;
}

function roleLabel(role) {
    if (role === 'owner') return 'Owner';
    if (role === 'manager') return 'Mgr';
    if (role === 'employee') return 'Staff';
    return '-';
}

function updateManagementButton() {
    const canOpen = !!(state.management && state.management.canOpen);
    if (btnManageStore) {
        btnManageStore.hidden = !canOpen;
        btnManageStore.disabled = !canOpen;
    }
    if (manageRoleBadge) manageRoleBadge.textContent = roleLabel(state.management && state.management.role);
}

function updateSellModeButton() {
    const count = (state.buyCatalog || []).length;
    if (sellBadge) sellBadge.textContent = String(count);
    if (!btnSellMode) return;
    btnSellMode.hidden = count === 0;
    btnSellMode.disabled = count === 0;
    btnSellMode.classList.toggle('has-items', state.marketMode === 'sell');
    btnSellMode.classList.toggle('has-buy-list', count > 0);
    btnSellMode.setAttribute('aria-pressed', state.marketMode === 'sell' ? 'true' : 'false');
    btnSellMode.title = state.marketMode === 'sell'
        ? 'Return to the store shelf'
        : 'See items this store will buy from you';
    const label = btnSellMode.querySelector('.bag-btn-label');
    if (label) label.textContent = state.marketMode === 'sell' ? 'Shop Items' : 'Store Buys';
}

function setMarketMode(mode) {
    const next = mode === 'sell' && (state.buyCatalog || []).length > 0 ? 'sell' : 'shop';
    if (state.marketMode === next) return;
    state.marketMode = next;
    state.cart = new Map();
    state.activeCategory = 'all';
    closeCartModal();
    updateSellModeButton();
    renderCategories();
    renderProducts({ animate: true });
    renderCart();
}

function manageErrorMessage(code) {
    const map = {
        access_denied: 'You do not have permission for that.',
        bad_input: 'Check the item, quantity, and price.',
        unknown_item: 'That item is not registered.',
        not_enough_items: 'You do not have enough of that item.',
        remove_failed: 'Could not remove that item from your inventory.',
        inventory_full: 'You do not have room to pull that stock.',
        empty_register: 'The register is empty.',
        player_not_found: 'That player is not nearby or online.',
        cannot_hire_owner: 'The owner is already part of this store.',
        owner_only_manager: 'Only the owner can add or remove managers.',
        not_staff: 'That citizen is not on this store staff.',
        no_player: 'Your player data was not ready. Try again in a moment.',
        callback_timeout: 'The client callback did not answer. Restart general_store so the Lua callbacks reload.',
        no_money: 'You do not have enough money.',
        store_no_money: 'The store register does not have enough money.',
        not_buying: 'This store is not buying that item.',
    };
    return map[code] || 'The store could not update.';
}

function itemImageRef(item) {
    if (!item) return '';
    return resolveImageRef(item.thumbnail || item.image || `${item.item || ''}.png`);
}

function mergeManageItems(...lists) {
    const map = new Map();
    lists.forEach((list) => {
        (list || []).forEach((row) => {
            if (!row || !row.item) return;
            const key = String(row.item).toLowerCase();
            const existing = map.get(key) || {};
            map.set(key, {
                ...existing,
                ...row,
                item: key,
                label: row.label || existing.label || key,
                image: row.image || existing.image || `${key}.png`,
            });
        });
    });
    return Array.from(map.values()).sort((a, b) => String(a.label).localeCompare(String(b.label)));
}

function manageCardImage(item) {
    const src = itemImageRef(item);
    return `
        <div class="manage-card-img-wrap">
            ${CARD_FRAME_CORNERS}
            ${src ? `<img class="manage-card-img" alt="" src="${escapeHtml(src)}" />` : '<span class="manage-card-no-img">No image</span>'}
        </div>
    `;
}

function renderStockCard(item, data) {
    return `
        <article class="manage-item-card" data-item="${escapeHtml(item.item)}">
            ${manageCardImage(item)}
            <div class="manage-card-copy">
                <strong>${escapeHtml(item.label)}</strong>
                <span>${escapeHtml(item.item)} | Stock: ${item.stock}</span>
            </div>
            <div class="manage-card-fields">
                <label>Price
                    <input class="manage-price" type="number" step="0.01" min="0" value="${Number(item.price || 0).toFixed(2)}" ${data.canEditDetails ? '' : 'disabled'} />
                </label>
                <label>Image
                    <input class="manage-image" type="text" value="${escapeHtml(item.image || '')}" ${data.canEditDetails ? '' : 'disabled'} />
                </label>
            </div>
            <div class="manage-card-actions">
                <button type="button" class="btn btn--ghost manage-update" ${data.canEditDetails ? '' : 'disabled'}>Save</button>
                <button type="button" class="btn btn--ghost manage-remove" ${data.canEditDetails ? '' : 'disabled'}>Pull</button>
            </div>
        </article>
    `;
}

function renderStockCandidateCard(item, data) {
    const amount = Number(item.amount || 0);
    const defaultPrice = Number(item.price || 1);
    return `
        <article class="manage-picker-card manage-picker-card--action" data-item="${escapeHtml(item.item)}" data-image="${escapeHtml(item.image || `${item.item}.png`)}">
            ${manageCardImage(item)}
            <div class="manage-card-copy">
                <strong>${escapeHtml(item.label || item.item)}</strong>
                <span>${amount} available</span>
            </div>
            <div class="manage-card-fields">
                <label>Amount
                    <input class="manage-candidate-qty" type="number" min="1" max="${amount}" value="1" ${data.canManageStock && amount > 0 ? '' : 'disabled'} />
                </label>
                <label>Sell Price
                    <input class="manage-candidate-price" type="number" min="0" step="0.01" value="${defaultPrice.toFixed(2)}" ${data.canManageStock && amount > 0 ? '' : 'disabled'} />
                </label>
            </div>
            <button type="button" class="btn btn--primary manage-add-stock" ${data.canManageStock && amount > 0 ? '' : 'disabled'}>Add To Store</button>
        </article>
    `;
}

function renderBuyCard(item, data) {
    return `
        <article class="manage-item-card manage-item-card--buy" data-item="${escapeHtml(item.item)}">
            ${manageCardImage(item)}
            <div class="manage-card-copy">
                <strong>${escapeHtml(item.label)}</strong>
                <span>${escapeHtml(item.item)} | Pays: ${fmtMoney(item.price)}</span>
            </div>
            <div class="manage-card-fields manage-card-fields--single">
                <label>Pay Price
                    <input class="manage-price" type="number" step="0.01" min="0" value="${Number(item.price || 0).toFixed(2)}" ${data.canEditDetails ? '' : 'disabled'} />
                </label>
            </div>
            <div class="manage-card-actions">
                <button type="button" class="btn btn--ghost manage-buy-save" ${data.canEditDetails ? '' : 'disabled'}>Save</button>
                <button type="button" class="btn btn--ghost manage-buy-remove" ${data.canEditDetails ? '' : 'disabled'}>Remove</button>
            </div>
        </article>
    `;
}

function renderBuyCandidateCard(item, data) {
    const meta = item.amount !== undefined
        ? `${item.amount} carried`
        : (item.stock !== undefined ? `${item.stock} in stock` : item.item);
    const defaultPrice = Number(item.price || 0.5);
    return `
        <article class="manage-picker-card manage-picker-card--action" data-item="${escapeHtml(item.item)}">
            ${manageCardImage(item)}
            <div class="manage-card-copy">
                <strong>${escapeHtml(item.label || item.item)}</strong>
                <span>${escapeHtml(meta)}</span>
            </div>
            <div class="manage-card-fields manage-card-fields--single">
                <label>Buy Price
                    <input class="manage-candidate-price" type="number" min="0" step="0.01" value="${defaultPrice.toFixed(2)}" ${data.canEditDetails ? '' : 'disabled'} />
                </label>
            </div>
            <button type="button" class="btn btn--primary manage-add-buy" ${data.canEditDetails ? '' : 'disabled'}>Buy From Players</button>
        </article>
    `;
}

function setManageTab(tab) {
    manageState.tab = tab || 'details';
    document.querySelectorAll('.manage-tab').forEach((btn) => {
        btn.classList.toggle('is-active', btn.dataset.tab === manageState.tab);
    });
    renderManageBody();
}

function closeManageModal() {
    if (!manageModal) return;
    manageState.open = false;
    manageModal.classList.remove('is-open');
    manageModal.setAttribute('aria-hidden', 'true');
}

async function refreshStorePayloadFromServer() {
    const res = await postNui('refreshStorePayload', {});
    if (!res || !res.ok || !res.payload) return false;
    const data = res.payload;
    state.moneyType = data.moneyType || state.moneyType;
    state.categories = data.categories || [];
    state.catalog = data.catalog || [];
    state.buyCatalog = data.buyCatalog || [];
    state.management = data.management || null;
    state.logo = data.logo || '';
    if (state.marketMode === 'sell' && state.buyCatalog.length === 0) state.marketMode = 'shop';
    state.stock = {};
    (state.catalog || []).forEach((p) => {
        if (p.stock !== undefined && p.stock !== null) state.stock[p.item] = p.stock;
    });
    applyStoreHeaderTitle(data.title || 'General store');
    applyStoreLogo(state.logo);
    updateManagementButton();
    updateSellModeButton();
    renderCategories();
    renderProducts({ animate: true });
    renderCart();
    return true;
}

async function refreshManagePayload() {
    const res = await withTimeout(postNui('manageGet', {}), 5000, { ok: false, error: 'callback_timeout' });
    if (!res || !res.ok) {
        showToast('error', 'Manager unavailable', manageErrorMessage(res && res.error));
        return false;
    }
    manageState.data = res.payload;
    renderManageBody();
    return true;
}

async function openManageModal() {
    if (!manageModal) return;
    if (!state.management || !state.management.canOpen) {
        await refreshStorePayloadFromServer();
    }
    if (!state.management || !state.management.canOpen) {
        showToast('error', 'No Manager Access', 'This character is not the owner or hired staff for this store.');
        return;
    }

    manageState.open = true;
    manageModal.classList.add('is-open');
    manageModal.setAttribute('aria-hidden', 'false');
    manageState.data = state.management.payload || manageState.data;
    if (manageState.data) {
        renderManageBody();
    } else {
        manageBody.innerHTML = '<div class="manage-empty">Opening business ledger...</div>';
    }
    const ok = await refreshManagePayload();
    if (!ok && !manageState.data) {
        manageBody.innerHTML = '<div class="manage-empty">Manager callback did not answer. Restart general_store and try again.</div>';
    }
}

async function runManageAction(endpoint, data, successTitle) {
    const res = await postNui(endpoint, data || {});
    if (!res || !res.ok) {
        showToast('error', 'Store update failed', manageErrorMessage(res && res.error));
        return false;
    }
    manageState.data = res.payload;
    renderManageBody();
    await refreshStorePayloadFromServer();
    showToast('success', successTitle || 'Store updated', 'The business ledger was saved.');
    return true;
}

function renderManageBody() {
    if (!manageBody) return;
    const data = manageState.data;
    if (!data) {
        manageBody.innerHTML = '<div class="manage-empty">No management data loaded.</div>';
        return;
    }

    const d = data.details || {};
    if (manageState.tab === 'details') {
        manageBody.innerHTML = `
            <div class="manage-grid manage-grid--details">
                <label class="manage-field">Store Name
                    <input id="manageName" type="text" value="${escapeHtml(d.label || '')}" ${data.canEditDetails ? '' : 'disabled'} />
                </label>
                <label class="manage-field">Logo URL or image filename
                    <input id="manageLogo" type="text" value="${escapeHtml(d.logo || '')}" ${data.canEditDetails ? '' : 'disabled'} placeholder="market_logo.png or https://..." />
                </label>
                <label class="manage-field manage-field--wide">Description
                    <input id="manageDescription" type="text" value="${escapeHtml(d.description || '')}" ${data.canEditDetails ? '' : 'disabled'} />
                </label>
                <div class="manage-logo-preview">${d.logo ? `<img src="${escapeHtml(resolveImageRef(d.logo))}" alt="" />` : '<span>No logo set</span>'}</div>
                <button type="button" class="btn btn--primary manage-action" id="btnSaveDetails" ${data.canEditDetails ? '' : 'disabled'}>Save Details</button>
            </div>
        `;
        const btn = document.getElementById('btnSaveDetails');
        if (btn) btn.addEventListener('click', () => runManageAction('manageSaveDetails', {
            label: document.getElementById('manageName').value,
            logo: document.getElementById('manageLogo').value,
            description: document.getElementById('manageDescription').value,
        }, 'Store details saved'));
        return;
    }

    if (manageState.tab === 'stock') {
        const inv = data.inventory || [];
        const items = data.items || [];
        const candidates = mergeManageItems(inv);
        const candidateCards = candidates.map((item) => renderStockCandidateCard(item, data)).join('');
        const rows = items.map((item) => renderStockCard(item, data)).join('');
        manageBody.innerHTML = `
            <div class="manage-section">
                <div class="manage-section-head">
                    <strong>Add Stock From Your Inventory</strong>
                    <span>Set amount and sale price directly on an item card.</span>
                </div>
                <div class="manage-picker-grid">${candidateCards || '<div class="manage-empty manage-empty--compact">You have no inventory items to stock.</div>'}</div>
            </div>
            <div class="manage-section-head manage-section-head--stock">
                <strong>Store Stock</strong>
                <span>These are the items customers can buy.</span>
            </div>
            <div class="manage-card-grid">${rows || '<div class="manage-empty">No store stock yet.</div>'}</div>
        `;
        manageBody.querySelectorAll('.manage-add-stock').forEach((btn) => {
            btn.addEventListener('click', () => {
                const row = btn.closest('.manage-picker-card');
                runManageAction('manageAddStock', {
                    item: row.dataset.item,
                    qty: row.querySelector('.manage-candidate-qty').value,
                    price: row.querySelector('.manage-candidate-price').value,
                    image: row.dataset.image || `${row.dataset.item}.png`,
                }, 'Stock added');
            });
        });
        manageBody.querySelectorAll('.manage-update').forEach((btn) => {
            btn.addEventListener('click', () => {
                const row = btn.closest('.manage-item-card');
                runManageAction('manageUpdateItem', {
                    item: row.dataset.item,
                    price: row.querySelector('.manage-price').value,
                    image: row.querySelector('.manage-image').value,
                }, 'Item updated');
            });
        });
        manageBody.querySelectorAll('.manage-remove').forEach((btn) => {
            btn.addEventListener('click', () => {
                const row = btn.closest('.manage-item-card');
                runManageAction('manageRemoveItem', { item: row.dataset.item }, 'Stock pulled');
            });
        });
        return;
    }

    if (manageState.tab === 'buys') {
        const inv = data.inventory || [];
        const storeItems = data.items || [];
        const buyItems = data.buyItems || [];
        const candidates = mergeManageItems(inv, storeItems, buyItems);
        const candidateCards = candidates.map((item) => renderBuyCandidateCard(item, data)).join('');
        const rows = buyItems.map((item) => renderBuyCard(item, data)).join('');
        manageBody.innerHTML = `
            <div class="manage-section">
                <div class="manage-section-head">
                    <strong>Choose What The Store Buys</strong>
                    <span>Set the buy price directly on an item card.</span>
                </div>
                <div class="manage-picker-grid">${candidateCards || '<div class="manage-empty manage-empty--compact">No selectable items yet. Carry an item or add it to stock first.</div>'}</div>
            </div>
            <div class="manage-empty manage-empty--hint">Players can sell these items to the store. The store pays from its register balance and adds sold items to stock.</div>
            <div class="manage-card-grid manage-card-grid--buys">${rows || '<div class="manage-empty">This store is not buying anything yet.</div>'}</div>
        `;
        manageBody.querySelectorAll('.manage-add-buy').forEach((btn) => {
            btn.addEventListener('click', () => {
                const row = btn.closest('.manage-picker-card');
                runManageAction('manageUpdateBuyItem', {
                    item: row.dataset.item,
                    price: row.querySelector('.manage-candidate-price').value,
                }, 'Buy list updated');
            });
        });
        manageBody.querySelectorAll('.manage-buy-save').forEach((btn) => {
            btn.addEventListener('click', () => {
                const row = btn.closest('.manage-item-card');
                runManageAction('manageUpdateBuyItem', {
                    item: row.dataset.item,
                    price: row.querySelector('.manage-price').value,
                }, 'Buy price updated');
            });
        });
        manageBody.querySelectorAll('.manage-buy-remove').forEach((btn) => {
            btn.addEventListener('click', () => {
                const row = btn.closest('.manage-item-card');
                runManageAction('manageRemoveBuyItem', { item: row.dataset.item }, 'Buy item removed');
            });
        });
        return;
    }

    if (manageState.tab === 'register') {
        manageBody.innerHTML = `
            <div class="manage-register">
                <span>Register Balance</span>
                <strong>${fmtMoney(d.balance || 0)}</strong>
                <div class="manage-deposit-row">
                    <input id="depositAmount" type="number" min="0" step="0.01" value="10.00" ${data.canWithdraw ? '' : 'disabled'} />
                    <button type="button" class="btn btn--ghost" id="btnDepositRegister" ${data.canWithdraw ? '' : 'disabled'}>Deposit</button>
                </div>
                <button type="button" class="btn btn--primary" id="btnWithdrawRegister" ${data.canWithdraw ? '' : 'disabled'}>Withdraw Register</button>
            </div>
        `;
        const btn = document.getElementById('btnWithdrawRegister');
        if (btn) btn.addEventListener('click', () => runManageAction('manageWithdraw', {}, 'Register withdrawn'));
        const deposit = document.getElementById('btnDepositRegister');
        if (deposit) deposit.addEventListener('click', () => runManageAction('manageDeposit', {
            amount: document.getElementById('depositAmount').value,
        }, 'Register deposit added'));
        return;
    }

    if (manageState.tab === 'staff') {
        const rows = (data.staff || []).map((row) => `
            <div class="manage-row" data-cid="${escapeHtml(row.citizenid)}">
                <div>
                    <strong>${escapeHtml(row.name)}</strong>
                    <span>${escapeHtml(row.citizenid)} | ${escapeHtml(row.role)}</span>
                </div>
                <button type="button" class="btn btn--ghost manage-fire" ${data.canHire ? '' : 'disabled'}>Remove</button>
            </div>
        `).join('');
        manageBody.innerHTML = `
            <div class="manage-stock-add">
                <input id="staffServerId" type="number" min="1" placeholder="Player ID" ${data.canHire ? '' : 'disabled'} />
                <select id="staffRole" ${data.canHire ? '' : 'disabled'}>
                    <option value="employee">Employee</option>
                    <option value="manager">Manager</option>
                </select>
                <button type="button" class="btn btn--primary" id="btnHireStaff" ${data.canHire ? '' : 'disabled'}>Hire</button>
            </div>
            <div class="manage-list">${rows || '<div class="manage-empty">No hired staff yet.</div>'}</div>
        `;
        const hire = document.getElementById('btnHireStaff');
        if (hire) hire.addEventListener('click', () => runManageAction('manageHireStaff', {
            targetId: document.getElementById('staffServerId').value,
            role: document.getElementById('staffRole').value,
        }, 'Staff hired'));
        manageBody.querySelectorAll('.manage-fire').forEach((btn) => {
            btn.addEventListener('click', () => {
                const row = btn.closest('.manage-row');
                runManageAction('manageFireStaff', { citizenid: row.dataset.cid }, 'Staff removed');
            });
        });
    }
}

function categoryLabelFor(id) {
    const key = String(id || '').toLowerCase();
    const configured = (state.categories || []).find((c) => String(c.id || '').toLowerCase() === key);
    if (configured && configured.label) return configured.label;
    if (key === 'owner_stock') return 'Owner Stock';
    if (key === 'sell_to_store') return 'Store Buys';
    return key
        .split(/[_-]+/)
        .filter(Boolean)
        .map((part) => part.charAt(0).toUpperCase() + part.slice(1))
        .join(' ') || 'Other';
}

function currentCatalogSource() {
    return state.marketMode === 'sell' ? (state.buyCatalog || []) : (state.catalog || []);
}

function categoryOptionsForMode() {
    const seen = new Set();
    currentCatalogSource().forEach((row) => {
        const id = String(row && row.category || '').toLowerCase();
        if (id && id !== 'all') seen.add(id);
    });

    const options = [];
    const added = new Set();
    const add = (id, label) => {
        id = String(id || '').toLowerCase();
        if (!id || id === 'all' || added.has(id)) return;
        if (seen.size > 0 && !seen.has(id)) return;
        options.push({ id, label: label || categoryLabelFor(id) });
        added.add(id);
    };

    (state.categories || []).forEach((c) => add(c.id, c.label));
    seen.forEach((id) => add(id, categoryLabelFor(id)));

    return options;
}

function renderCategories() {
    categoryList.innerHTML = '';
    const categoryOptions = categoryOptionsForMode();
    if (state.activeCategory !== 'all' && !categoryOptions.some((c) => c.id === state.activeCategory)) {
        state.activeCategory = 'all';
    }

    if ((state.buyCatalog || []).length > 0) {
        const hint = document.createElement('div');
        hint.className = `market-mode-card${state.marketMode === 'sell' ? ' market-mode-card--sell' : ''}`;
        const title = document.createElement('strong');
        title.textContent = state.marketMode === 'sell' ? 'Store is buying' : 'This store buys goods';
        const copy = document.createElement('span');
        copy.textContent = state.marketMode === 'sell'
            ? 'Pick an accepted item, add the amount to your bag, then press Sell Items.'
            : 'Use Store Buys to sell approved items from your inventory.';
        const swap = document.createElement('button');
        swap.type = 'button';
        swap.className = 'market-mode-switch';
        swap.textContent = state.marketMode === 'sell' ? 'Back to shop' : 'View buys';
        swap.addEventListener('click', () => setMarketMode(state.marketMode === 'sell' ? 'shop' : 'sell'));
        hint.appendChild(title);
        hint.appendChild(copy);
        hint.appendChild(swap);
        categoryList.appendChild(hint);
    }

    const all = document.createElement('button');
    all.type = 'button';
    all.className = `cat-btn${state.activeCategory === 'all' ? ' is-active' : ''}`;
    all.textContent = state.marketMode === 'sell' ? 'Accepted items' : 'All items';
    all.addEventListener('click', () => {
        state.activeCategory = 'all';
        renderCategories();
        renderProducts({ animate: true });
    });
    categoryList.appendChild(all);

    categoryOptions.forEach((c) => {
        const b = document.createElement('button');
        b.type = 'button';
        b.className = `cat-btn${state.activeCategory === c.id ? ' is-active' : ''}`;
        b.textContent = c.label || c.id;
        b.addEventListener('click', () => {
            state.activeCategory = c.id;
            renderCategories();
            renderProducts({ animate: true });
        });
        categoryList.appendChild(b);
    });
}

function productMatchesSearch(p, q) {
    if (!q) return true;
    const s = q.toLowerCase();
    return (
        (p.label && p.label.toLowerCase().includes(s)) ||
        (p.item && p.item.toLowerCase().includes(s)) ||
        (p.description && p.description.toLowerCase().includes(s))
    );
}

function selectProductCard(p, cardEl) {
    state.selectedItem = p.item;
    productGrid.querySelectorAll('.card.is-selected').forEach((el) => el.classList.remove('is-selected'));
    if (cardEl) cardEl.classList.add('is-selected');
    scheduleWorldPreview(p);
}

function getItemStock(itemName) {
    if (state.marketMode === 'sell') {
        const key = String(itemName || '').toLowerCase();
        const row = (state.buyCatalog || []).find((p) => String(p.item || '').toLowerCase() === key);
        if (!row) return 0;
        const amount = row.stock ?? row.amount;
        return amount !== undefined && amount !== null ? Number(amount) || 0 : null;
    }

    const v = state.stock[itemName];
    return (v !== undefined && v !== null) ? v : null;
}

function createProductCard(p) {
    const card = document.createElement('article');
    card.className = 'card';
    card.tabIndex = 0;
    card.dataset.item = p.item;
    if (state.selectedItem === p.item) card.classList.add('is-selected');

    const stockCount = getItemStock(p.item);
    const isSoldOut  = stockCount !== null && stockCount <= 0;
    const isLow      = stockCount !== null && stockCount > 0 && stockCount <= 10;
    const hasStock   = stockCount !== null;

    if (isSoldOut) card.classList.add('is-sold-out');

    const imgSrc = p.thumbnail || '';

    let stockBadge = '';
    if (isSoldOut) {
        stockBadge = `<span class="stock-tag stock-tag--out">Sold Out</span>`;
    } else if (isLow) {
        stockBadge = `<span class="stock-tag stock-tag--low">${stockCount} ${state.marketMode === 'sell' ? 'owned' : 'left'}</span>`;
    } else if (hasStock) {
        stockBadge = `<span class="stock-tag stock-tag--ok">${stockCount} ${state.marketMode === 'sell' ? 'owned' : 'in stock'}</span>`;
    }

    card.innerHTML = `
        <div class="card-img-wrap">
            ${CARD_FRAME_CORNERS}
            ${imgSrc ? `<img class="card-img" alt="" src="${imgSrc}" />` : `<span class="card-desc" style="margin:0">No image</span>`}
            ${isSoldOut ? `<div class="card-soldout-overlay"><span>Sold Out</span></div>` : ''}
        </div>
        <h3 class="card-title">${escapeHtml(p.label)}</h3>
        <p class="card-desc">${escapeHtml(p.description || '')}</p>
        <div class="card-row">
            <span class="price">${fmtMoney(p.price)}</span>
            ${stockBadge}
        </div>
        <button type="button" class="btn card-add-btn"${isSoldOut ? ' disabled' : ''}>${state.marketMode === 'sell' ? 'Sell' : 'Add'}</button>
    `;

    card.addEventListener('click', (e) => {
        if (e.target.closest('.card-add-btn')) return;
        selectProductCard(p, card);
    });

    card.addEventListener('keydown', (e) => {
        if (e.key !== 'Enter' && e.key !== ' ') return;
        if (e.target.closest('.card-add-btn')) return;
        e.preventDefault();
        selectProductCard(p, card);
    });

    card.querySelector('.card-add-btn').addEventListener('click', (e) => {
        e.stopPropagation();
        if (getItemStock(p.item) === 0) return;
        bumpCart(p, 1, { openBag: true });
    });

    return card;
}

function paintProductGrid(list, renderId) {
    productGrid.innerHTML = '';

    if (list.length === 0) {
        const empty = document.createElement('div');
        empty.className = 'cart-empty product-grid-empty';
        empty.style.gridColumn = '1 / -1';
        empty.textContent = 'No matches.';
        productGrid.appendChild(empty);
        requestAnimationFrame(() => empty.classList.add('is-visible'));
        return;
    }

    list.forEach((p, index) => {
        const card = createProductCard(p);
        card.style.animationDelay = `${index * CARD_STAGGER_MS}ms`;
        card.classList.add('card-entering');
        productGrid.appendChild(card);

        const cleanupDelay = CARD_ENTER_MS + index * CARD_STAGGER_MS;
        setTimeout(() => {
            if (renderId !== productGridRenderId) return;
            card.classList.remove('card-entering');
            card.style.animationDelay = '';
        }, cleanupDelay);
    });
}

function renderProducts(options) {
    const animate = !!(options && options.animate);
    const q = searchInput.value.trim();
    const cat = state.activeCategory;

    const source = state.marketMode === 'sell' ? (state.buyCatalog || []) : (state.catalog || []);
    const list = source.filter((p) => {
        if (cat !== 'all' && String(p.category || '').toLowerCase() !== cat) return false;
        return productMatchesSearch(p, q);
    });

    productGridRenderId += 1;
    const renderId = productGridRenderId;

    function finishPaint() {
        if (renderId !== productGridRenderId) return;
        const showcase = firstShowcaseProduct(list);
        state.selectedItem = showcase ? showcase.item : null;
        paintProductGrid(list, renderId);
        if (showcase) scheduleWorldPreview(showcase);
        else {
            scheduleWorldPreview(null);
            setShowcaseChrome(false);
        }
    }

    if (!animate) {
        finishPaint();
        return;
    }

    const existingCards = productGrid.querySelectorAll('.card');
    if (existingCards.length === 0) {
        finishPaint();
        return;
    }

    existingCards.forEach((card, index) => {
        card.style.animationDelay = `${index * CARD_STAGGER_MS}ms`;
        card.classList.add('card-exiting');
    });

    setTimeout(finishPaint, CARD_EXIT_MS);
}

/**
 * @param {object} p — catalog row
 * @param {number} delta
 * @param {{ openBag?: boolean }} options — open modal when adding via Add button
 */
function bumpCart(p, delta, options) {
    const opts = options || {};
    const key  = p.item;

    // Refuse add if sold out
    const stockCount = getItemStock(p.item);
    if (delta > 0 && stockCount !== null && stockCount <= 0) return;

    const cur = state.cart.get(key) || { item: p.item, label: p.label, price: p.price, qty: 0 };
    cur.price = p.price;
    cur.label = p.label;

    const newQty = Math.max(0, cur.qty + delta);
    // Cap at available stock
    cur.qty = (stockCount !== null) ? Math.min(newQty, stockCount) : newQty;

    if (cur.qty === 0) state.cart.delete(key);
    else state.cart.set(key, cur);

    if (delta > 0 && opts.openBag) openCartModal();
    renderCart();
}

function renderCart() {
    const wasOpen = cartModalOpen();
    cartBody.innerHTML = '';
    const lines = cartLinesArray();

    const count = cartItemCount();
    if (cartBadge) cartBadge.textContent = String(count);
    if (btnOpenBag) {
        btnOpenBag.disabled = count === 0;
        btnOpenBag.classList.toggle('has-items', count > 0);
    }

    btnCheckout.disabled = lines.length === 0;
    btnCheckout.textContent = state.marketMode === 'sell' ? 'Sell Items' : 'Checkout';

    if (lines.length === 0) {
        cartBody.innerHTML = state.marketMode === 'sell'
            ? '<div class="cart-empty">Nothing selected.<br />Use Sell on an item the store buys.</div>'
            : '<div class="cart-empty">Your bag is empty.<br />Use Add on a product to put it here.</div>';
        cartTotal.textContent = fmtMoney(0);
        closeCartModal();
        return;
    }

    state.cart.forEach((row) => {
        if (row.qty <= 0) return;
        const el = document.createElement('div');
        el.className = 'line';
        el.innerHTML = `
            <div class="line-info">
                <div class="line-name">${escapeHtml(row.label)}</div>
                <div class="line-meta">${fmtMoney(row.price)} ea.</div>
            </div>
            <div class="qty-controls">
                <button type="button" class="qty-btn" data-act="-" aria-label="decrease quantity">−</button>
                <span class="qty-val">${row.qty}</span>
                <button type="button" class="qty-btn" data-act="+" aria-label="increase quantity">+</button>
            </div>
        `;
        const stub = { item: row.item, label: row.label, price: row.price, description: '' };
        el.querySelector('[data-act="-"]').addEventListener('click', (e) => {
            e.stopPropagation();
            bumpCart(stub, -1);
        });
        el.querySelector('[data-act="+"]').addEventListener('click', (e) => {
            e.stopPropagation();
            bumpCart(stub, 1);
        });
        cartBody.appendChild(el);
    });

    cartTotal.textContent = fmtMoney(cartTotalValue());
    btnCheckout.textContent = state.marketMode === 'sell' ? 'Sell Items' : 'Checkout';

    if (wasOpen) {
        openCartModal();
    }
}

function applyStoreHeaderTitle(fullTitle) {
    const raw = (fullTitle || 'General Store').trim();
    const parts = raw.split(/\s*[—–-]\s*/).map((s) => s.trim()).filter(Boolean);
    if (!storeKicker || !storeTitle) return;
    if (parts.length >= 2) {
        storeKicker.textContent = parts[0];
        storeTitle.textContent = parts.slice(1).join(' — ');
        return;
    }
    storeKicker.textContent = 'General Store';
    storeTitle.textContent = raw;
}

function openUi(data) {
    clearTimeout(shellExitTimer);
    shellExitTimer = null;
    clearTimeout(shellEnterCleanupTimer);
    shellEnterCleanupTimer = null;
    uiClosing = false;

    state.open = true;
    state.storeId = data.storeId;
    state.moneyType = data.moneyType || 'cash';
    state.categories = data.categories || [];
    state.catalog = data.catalog || [];
    state.buyCatalog = data.buyCatalog || [];
    state.marketMode = 'shop';
    state.activeCategory = 'all';
    state.cart = new Map();
    state.selectedItem = null;
    state.logo = data.logo || '';
    state.management = data.management || null;
    manageState.open = false;
    manageState.tab = 'details';
    manageState.data = state.management && state.management.payload ? state.management.payload : null;
    document.querySelectorAll('.manage-tab').forEach((btn) => {
        btn.classList.toggle('is-active', btn.dataset.tab === manageState.tab);
    });
    searchInput.value = '';

    // Seed stock map from catalog payload
    state.stock = {};
    (state.catalog || []).forEach((p) => {
        if (p.stock !== undefined && p.stock !== null) {
            state.stock[p.item] = p.stock;
        }
    });

    applyStoreHeaderTitle(data.title || 'General store');
    applyStoreLogo(state.logo);
    updateManagementButton();
    updateSellModeButton();
    walletValue.textContent = fmtMoney(data.balance);

    app.classList.add('is-open');
    app.setAttribute('aria-hidden', 'false');

    requestAnimationFrame(() => primeShellEnterAnimation());

    closeCartModal();
    renderCategories();
    renderProducts();
    renderCart();
}

function closeUi() {
    runShellExitAnimation({ notifyLua: true });
}

window.addEventListener('message', (e) => {
    const { action, success, balance } = e.data || {};
    if (action === 'open') openUi(e.data.data || {});
    if (action === 'close') {
        if (uiClosing) return;
        if (!app.classList.contains('is-open')) {
            state.open = false;
            closeCartModal();
            closeManageModal();
            setShowcaseChrome(false);
            return;
        }
        runShellExitAnimation({ notifyLua: false });
    }
    if (action === 'purchaseResult') {
        if (typeof balance === 'number') walletValue.textContent = fmtMoney(balance);
        if (success) {
            // snapshot cart before clearing
            const lines = cartLinesArray();
            const summary = lines.map((l) => {
                const row = state.cart.get(l.item);
                return row ? `${row.label} x${row.qty}` : l.item;
            }).join(', ');
            state.cart = new Map();
            renderCart();
            showToast('success', 'Purchase complete', summary || 'Items delivered.');
        } else {
            const msgs = {
                no_money:     'Insufficient funds.',
                inventory:    'Not enough space or weight.',
                not_for_sale: 'Item not sold at this shop.',
                out_of_stock: 'One or more items are sold out.',
                empty:        'Cart is empty.',
                pay_failed:   'Payment failed.',
                give_failed:  'Could not grant items — refunded.',
            };
            const msg = msgs[e.data.code] || 'Purchase could not be completed.';
            showToast('error', 'Purchase failed', msg);
        }
    }
    if (action === 'toast') {
        const d = e.data;
        showToast(d.toastType || 'info', d.title || '', d.msg || '', d.duration);
    }
    if (action === 'stockUpdate') {
        if (state.marketMode === 'sell') return;
        const updates = e.data.stock || {};
        Object.assign(state.stock, updates);
        // Patch visible cards without full re-render
        Object.entries(updates).forEach(([itemName, count]) => {
            const card = productGrid.querySelector(`.card[data-item="${itemName}"]`);
            if (!card) return;
            const isSoldOut = count <= 0;
            const isLow     = count > 0 && count <= 10;
            card.classList.toggle('is-sold-out', isSoldOut);
            const addBtn = card.querySelector('.card-add-btn');
            if (addBtn) addBtn.disabled = isSoldOut;
            // Update or add sold-out overlay
            const wrap = card.querySelector('.card-img-wrap');
            let overlay = wrap && wrap.querySelector('.card-soldout-overlay');
            if (isSoldOut && wrap && !overlay) {
                overlay = document.createElement('div');
                overlay.className = 'card-soldout-overlay';
                overlay.innerHTML = '<span>Sold Out</span>';
                wrap.appendChild(overlay);
            } else if (!isSoldOut && overlay) {
                overlay.remove();
            }
            // Update stock tag
            const row = card.querySelector('.card-row');
            let tag = row && row.querySelector('.stock-tag');
            if (row) {
                if (!tag) {
                    tag = document.createElement('span');
                    row.appendChild(tag);
                }
                if (isSoldOut) {
                    tag.className = 'stock-tag stock-tag--out';
                    tag.textContent = 'Sold Out';
                } else if (isLow) {
                    tag.className = 'stock-tag stock-tag--low';
                    tag.textContent = `${count} left`;
                } else {
                    tag.className = 'stock-tag stock-tag--ok';
                    tag.textContent = `${count} in stock`;
                }
            }
        });
        // Also clamp cart items that now exceed stock
        state.cart.forEach((row) => {
            const s = state.stock[row.item];
            if (s !== undefined && s !== null && row.qty > s) {
                row.qty = Math.max(0, s);
                if (row.qty === 0) state.cart.delete(row.item);
            }
        });
        renderCart();
    }
});

btnClose.addEventListener('click', closeUi);
btnOpenBag.addEventListener('click', () => openCartModal());
btnCloseCartModal.addEventListener('click', () => closeCartModal());
if (btnSellMode) btnSellMode.addEventListener('click', (e) => {
    e.preventDefault();
    e.stopPropagation();
    setMarketMode(state.marketMode === 'sell' ? 'shop' : 'sell');
});
if (btnManageStore) btnManageStore.addEventListener('click', (e) => {
    e.preventDefault();
    e.stopPropagation();
    openManageModal();
});
if (btnCloseManage) btnCloseManage.addEventListener('click', () => closeManageModal());
if (manageModalScrim) manageModalScrim.addEventListener('click', () => closeManageModal());
document.querySelectorAll('.manage-tab').forEach((btn) => {
    btn.addEventListener('click', () => setManageTab(btn.dataset.tab));
});

btnClear.addEventListener('click', () => {
    state.cart = new Map();
    renderCart();
});
searchInput.addEventListener('input', () => renderProducts());

btnCheckout.addEventListener('click', async () => {
    const cart = cartLinesArray();
    if (cart.length === 0) return;
    btnCheckout.disabled = true;
    if (state.marketMode === 'sell') {
        const res = await postNui('sellToStore', { cart });
        if (res && res.ok) {
            const summary = cart.map((l) => {
                const row = state.cart.get(l.item);
                return row ? `${row.label} x${row.qty}` : l.item;
            }).join(', ');
            state.cart = new Map();
            if (typeof res.balance === 'number') walletValue.textContent = fmtMoney(res.balance);
            state.buyCatalog = res.buyCatalog || [];
            if (state.buyCatalog.length === 0) state.marketMode = 'shop';
            updateSellModeButton();
            await refreshStorePayloadFromServer();
            renderCategories();
            renderProducts({ animate: true });
            renderCart();
            showToast('success', 'Items sold', summary || 'Store bought your items.');
        } else {
            const msgs = {
                store_no_money: 'The store register does not have enough money.',
                not_buying: 'This store is not buying one of those items.',
                not_enough_items: 'You do not have enough of that item.',
                empty: 'Nothing selected.',
                remove_failed: 'Could not remove an item from your inventory.',
                no_player: 'Your player data was not ready.',
                robbery_active: 'The store is busy with a robbery.',
            };
            showToast('error', 'Sale failed', msgs[res && res.error] || 'The store could not buy those items.');
        }
    } else {
        await postNui('checkout', { cart });
    }
    btnCheckout.disabled = cartLinesArray().length === 0;
});

window.addEventListener('keydown', (e) => {
    if (!state.open || uiClosing) return;
    if (e.key === 'Escape') {
        e.preventDefault();
        if (manageState.open) closeManageModal();
        else if (cartModalOpen()) closeCartModal();
        else closeUi();
    }
});

/* Left-screen drag → Lua showcase rotation */
(function initShowcaseDrag() {
    if (!propRotateZone) return;
    let drag = false;
    let pendingYaw = 0;
    let pendingPitch = 0;
    let raf = null;

    function flush() {
        raf = null;
        if (pendingYaw === 0 && pendingPitch === 0) return;
        const y = pendingYaw;
        const p = pendingPitch;
        pendingYaw = 0;
        pendingPitch = 0;
        postNui('rotateDisplay', { yaw: y, pitch: p });
    }

    propRotateZone.addEventListener('mousedown', (e) => {
        if (!propRotateZone.classList.contains('is-visible')) return;
        drag = true;
        propRotateZone.classList.add('is-dragging');
        e.preventDefault();
    });

    window.addEventListener('mouseup', () => {
        if (!drag) return;
        drag = false;
        propRotateZone.classList.remove('is-dragging');
    });

    window.addEventListener('mousemove', (e) => {
        if (!drag) return;
        pendingYaw += e.movementX || 0;
        pendingPitch += e.movementY || 0;
        if (raf == null) raf = requestAnimationFrame(flush);
    });
})();
