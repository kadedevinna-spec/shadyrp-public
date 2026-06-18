const resName = typeof GetParentResourceName === 'function' ? GetParentResourceName() : 'MX-Ranch';

/** NUI strings — delegates to `window.t` (i18n.js); safe fallback if i18n fails. */
function ranchT(path, vars) {
  var fn = typeof window !== 'undefined' ? window.t : null;
  if (typeof fn === 'function') return fn(path, vars);
  var s = path;
  if (vars && typeof vars === 'object') {
    Object.keys(vars).forEach(function (k) {
      s = s.split('{' + k + '}').join(String(vars[k]));
    });
  }
  return s;
}

/** Caminho para assets: NUI no jogo; URL relativa no Chrome / Live Server */
function nuiHtml(rel) {
  const p = String(rel || '').replace(/^\//, '');
  if (typeof GetParentResourceName !== 'function') {
    try {
      return new URL(p, window.location.href).href;
    } catch (e) {
      return p;
    }
  }
  return `https://cfx-nui-${GetParentResourceName()}/html/${p}`;
}

function applyNuiImages() {
  document.querySelectorAll('img[data-nui]').forEach((el) => {
    const rel = el.getAttribute('data-nui');
    if (rel) el.src = nuiHtml(rel);
  });
}

/** Keys match locales/en.json → animals.{type}.title / .desc */
const SHOP_ANIMAL_DEFS = [
  { type: 'vacas', img: 'img/vaca.png' },
  { type: 'porcos', img: 'img/pig.png' },
  { type: 'ovelhas', img: 'img/sheep.png' },
  { type: 'galinhas', img: 'img/chicken.png' },
  { type: 'cabras', img: 'img/goat.png' },
];

function getShopAnimals() {
  return SHOP_ANIMAL_DEFS.map((d) => ({
    type: d.type,
    img: d.img,
    title: ranchT('animals.' + d.type + '.title'),
    desc: ranchT('animals.' + d.type + '.desc'),
  }));
}

function animalTypeTitle(type) {
  if (!type) return '';
  const key = 'animals.' + type + '.title';
  const raw = ranchT(key);
  if (raw !== key) return raw;
  const shortKey = 'client.animalShort.' + type;
  const shortRaw = ranchT(shortKey);
  return shortRaw === shortKey ? String(type) : shortRaw;
}

function structTypeTitle(stype) {
  const key = 'structures.types.' + stype;
  const raw = ranchT(key);
  return raw === key ? String(stype) : raw;
}

/** Western shell — wr-* markup; IDs kept for NUI callbacks */
function buildRanchDom() {
  const overlay = document.getElementById('overlay');
  if (!overlay || overlay.querySelector('.wr-root')) return;

  const main = document.createElement('main');
  main.className = 'wr-root';

  const header = document.createElement('header');
  header.className = 'wr-topbar';
  header.innerHTML =
    '<div class="wr-brand">' +
    '<p class="wr-brand__eyebrow">' +
    ranchT('ui.brandEyebrow') +
    '</p>' +
    '<h1 class="wr-brand__title">' +
    ranchT('ui.ranchTitle') +
    '</h1>' +
    '</div>' +
    '<button type="button" id="btnClose" class="wr-close wr-nav-btn wr-nav-btn--compact" aria-label="' +
    ranchT('ui.closeAria') +
    '"><span>' +
    ranchT('ui.close') +
    '</span></button>';

  const frame = document.createElement('div');
  frame.className = 'wr-frame';

  const nav = document.createElement('nav');
  nav.className = 'wr-sidebar';
  nav.setAttribute('aria-label', ranchT('ui.navAria'));
  const tabs = [
    ['geral', ranchT('tabs.geral')],
    ['animais', ranchT('tabs.animais')],
    ['rebanho', ranchT('tabs.rebanho')],
    ['estruturas', ranchT('tabs.estruturas')],
    ['func', ranchT('tabs.func')],
  ];
  tabs.forEach(([id, label], i) => {
    const b = document.createElement('button');
    b.type = 'button';
    b.className = 'wr-nav-item' + (i === 0 ? ' wr-nav-item--active' : '');
    b.dataset.tab = id;
    b.innerHTML = '<span class="wr-nav-item__label">' + label + '</span>';
    nav.appendChild(b);
  });

  const body = document.createElement('div');
  body.className = 'wr-body';

  const panelGeral = document.createElement('section');
  panelGeral.id = 'panel-geral';
  panelGeral.className = 'wr-panel';
  panelGeral.innerHTML =
    '<div id="geral-empty" class="wr-empty">' +
    ranchT('general.emptyRanches') +
    '</div>' +
    '<div id="geral-details" class="hidden wr-ranch-general">' +
    '<div class="wr-ranch-general__main">' +
    '<p class="wr-ranch-info__kicker">' +
    ranchT('general.summaryKicker') +
    '</p>' +
    '<div class="wr-ranch-name-edit">' +
    '<label class="wr-label" for="r-name-input">' +
    ranchT('general.ranchName') +
    '</label>' +
    '<div class="wr-ranch-name-edit__row">' +
    '<input type="text" id="r-name-input" class="wr-input wr-input--name" maxlength="40" placeholder="' +
    ranchT('general.ranchNamePlaceholder') +
    '" />' +
    '<button type="button" id="btnSaveRanchName" class="wr-nav-btn"><span class="wr-nav-item__label">' +
    ranchT('general.saveName') +
    '</span></button></div></div>' +
    '</div>' +
    '<div class="wr-ranch-info__stats">' +
    '<div class="wr-statbox"><span class="wr-statbox__lab">' +
    ranchT('general.animals') +
    '</span><strong id="r-acount" class="wr-statbox__num">0</strong></div>' +
    '<div class="wr-statbox"><span class="wr-statbox__lab">' +
    ranchT('general.totalWeight') +
    '</span><strong id="r-weight" class="wr-statbox__num">0</strong><span class="wr-statbox__unit">' +
    ranchT('general.kg') +
    '</span></div>' +
    '</div>' +
    '<div id="ranchWalletPanel" class="wr-ranch-wallet hidden">' +
    '<p class="wr-ranch-info__kicker">' +
    ranchT('general.cashLabel') +
    '</p>' +
    '<div class="wr-ranch-wallet__stat">' +
    ranchT('general.cashBalance') +
    ' <strong id="ranchWalletBalance">$0</strong></div>' +
    '<div class="wr-ranch-wallet__row">' +
    '<label class="wr-label" for="ranchCashAmt">' +
    ranchT('general.cashAmount') +
    '</label>' +
    '<div class="wr-hire__row">' +
    '<input type="number" id="ranchCashAmt" class="wr-input" min="1" step="1" placeholder="100" />' +
    '<button type="button" id="btnRanchDeposit" class="wr-nav-btn hidden"><span class="wr-nav-item__label">' +
    ranchT('general.deposit') +
    '</span></button>' +
    '<button type="button" id="btnRanchWithdraw" class="wr-nav-btn hidden"><span class="wr-nav-item__label">' +
    ranchT('general.withdraw') +
    '</span></button>' +
    '</div></div>' +
    '<p id="ranchWalletHint" class="wr-ranch-wallet__hint"></p>' +
    '</div>' +
    '<div id="ranchWebhookPanel" class="wr-ranch-webhook hidden">' +
    '<p class="wr-ranch-info__kicker">' +
    ranchT('general.webhookTitle') +
    '</p>' +
    '<p class="wr-section-head__lead wr-ranch-webhook__lead">' +
    ranchT('general.webhookLead') +
    '</p>' +
    '<label class="wr-label" for="ranchWebhookUrl">' +
    ranchT('general.webhookLabel') +
    '</label>' +
    '<input type="url" id="ranchWebhookUrl" class="wr-input wr-input--block" autocomplete="off" placeholder="' +
    ranchT('general.webhookPlaceholder') +
    '" />' +
    '<p id="ranchWebhookSaveHint" class="wr-ranch-webhook__hint">' +
    ranchT('general.webhookSaveHint') +
    '</p></div></div>';

  const panelAnimais = document.createElement('section');
  panelAnimais.id = 'panel-animais';
  panelAnimais.className = 'wr-panel wr-panel--shop hidden';
  panelAnimais.innerHTML =
    '<header class="wr-section-head">' +
    '<h2 class="wr-section-head__title">' +
    ranchT('animalsPanel.shopTitle') +
    '</h2>' +
    '<p class="wr-section-head__lead">' +
    ranchT('animalsPanel.shopLead') +
    '</p></header>' +
    '<div id="animalShopList" class="wr-buy-list" role="list"></div>';

  const panelRebanho = document.createElement('section');
  panelRebanho.id = 'panel-rebanho';
  panelRebanho.className = 'wr-panel wr-panel--herd hidden';
  panelRebanho.innerHTML =
    '<header class="wr-section-head">' +
    '<h2 class="wr-section-head__title">' +
    ranchT('animalsPanel.herdTitle') +
    '</h2>' +
    '<p class="wr-section-head__lead">' +
    ranchT('animalsPanel.herdLead') +
    '</p></header>' +
    '<div id="herdWanderGlobal" class="wr-herd-wander wr-herd-wander--global hidden"></div>' +
    '<div id="animalHerdList" class="wr-herd-list" role="list" aria-label="' +
    ranchT('animalsPanel.herdAria') +
    '"></div>';

  const panelEst = document.createElement('section');
  panelEst.id = 'panel-estruturas';
  panelEst.className = 'wr-panel hidden';
  panelEst.innerHTML =
    '<header class="wr-section-head">' +
    '<h2 class="wr-section-head__title">' +
    ranchT('structures.shopTitle') +
    '</h2>' +
    '<p class="wr-section-head__lead">' +
    ranchT('structures.shopLead') +
    '</p></header>' +
    '<div id="structShopCards" class="wr-buy-list" role="list"></div>';

  const panelFunc = document.createElement('section');
  panelFunc.id = 'panel-func';
  panelFunc.className = 'wr-panel wr-panel--crew hidden';
  panelFunc.innerHTML =
    '<header class="wr-section-head">' +
    '<h2 class="wr-section-head__title">' +
    ranchT('crew.title') +
    '</h2>' +
    '<p class="wr-section-head__lead">' +
    ranchT('crew.lead') +
    '</p></header>' +
    '<div class="wr-hire wr-hire--crew hidden" id="ranchHirePanel">' +
    '<label class="wr-label" for="hirePlayerId">' +
    ranchT('structures.playerIdLabel') +
    '</label>' +
    '<div class="wr-hire__row">' +
    '<input type="number" id="hirePlayerId" class="wr-input" placeholder="' +
    ranchT('structures.playerIdPlaceholder') +
    '" min="0" step="1" />' +
    '<button type="button" id="btnHire" class="wr-nav-btn"><span class="wr-nav-item__label">' +
    ranchT('structures.hire') +
    '</span></button>' +
    '</div></div>' +
    '<div id="crew-empty" class="wr-empty wr-empty--crew hidden">' +
    ranchT('crew.empty') +
    '</div>' +
    '<div id="crewCards" class="wr-crew-grid" role="list"></div>';

  body.appendChild(panelGeral);
  body.appendChild(panelAnimais);
  body.appendChild(panelRebanho);
  body.appendChild(panelEst);
  body.appendChild(panelFunc);

  frame.appendChild(nav);
  frame.appendChild(body);
  main.appendChild(header);
  main.appendChild(frame);
  overlay.appendChild(main);
}

function wireRanchEvents() {
  document.querySelectorAll('.wr-nav-item').forEach((btn) => {
    btn.addEventListener('click', () => setTab(btn.dataset.tab));
  });

  $('btnClose')?.addEventListener('click', () => {
    post('close', {});
    showOverlay(false);
  });

  $('btnHire')?.addEventListener('click', () => {
    const id = Number($('hirePlayerId').value);
    if (!id) return;
    post('hireWorker', { ranchId: state.activeRanchId, targetId: id }).then(() =>
      post('refresh').then(refreshAll)
    );
  });

  $('btnRanchDeposit')?.addEventListener('click', () => {
    const amt = Number($('ranchCashAmt')?.value);
    if (!amt || !state.activeRanchId) return;
    post('depositRanchCash', { ranchId: state.activeRanchId, amount: amt }).then(() =>
      post('refresh').then(refreshAll)
    );
  });

  $('btnRanchWithdraw')?.addEventListener('click', () => {
    const amt = Number($('ranchCashAmt')?.value);
    if (!amt || !state.activeRanchId) return;
    post('withdrawRanchCash', { ranchId: state.activeRanchId, amount: amt }).then(() =>
      post('refresh').then(refreshAll)
    );
  });

  let webhookSaveTimer = null;
  function flushWebhookSave() {
    if (webhookSaveTimer) {
      clearTimeout(webhookSaveTimer);
      webhookSaveTimer = null;
    }
    const input = $('ranchWebhookUrl');
    if (!input || !state.activeRanchId) return;
    post('updateWebhook', { ranchId: state.activeRanchId, webhook: input.value.trim() })
      .then((r) => r.json().catch(() => ({})))
      .then((res) => {
        if (!res || !res.ok) return;
        const ranches = state.data?.ranches || [];
        const rid = Number(state.activeRanchId);
        const row = ranches.find((x) => Number(x.id) === rid);
        if (row) row.webhook_masked = res.webhook_masked || '';
        if (res.webhook_masked) {
          input.value = '';
          input.placeholder = '********';
        }
      });
  }
  function scheduleWebhookSave() {
    if (webhookSaveTimer) clearTimeout(webhookSaveTimer);
    webhookSaveTimer = setTimeout(flushWebhookSave, 650);
  }
  const webhookInput = $('ranchWebhookUrl');
  if (webhookInput) {
    webhookInput.addEventListener('input', scheduleWebhookSave);
    webhookInput.addEventListener('blur', () => {
      if (webhookSaveTimer) flushWebhookSave();
    });
  }

  $('btnSaveRanchName')?.addEventListener('click', () => {
    const input = $('r-name-input');
    const name = input && String(input.value || '').trim();
    if (!name || !state.activeRanchId) return;
    post('renameRanch', { ranchId: state.activeRanchId, name })
      .then((r) => r.json())
      .then((res) => {
        if (res && res.ok) {
          post('refresh').then(refreshAll);
        }
      })
      .catch(() => {});
  });

  $('r-name-input')?.addEventListener('keydown', (e) => {
    if (e.key === 'Enter') {
      e.preventDefault();
      $('btnSaveRanchName')?.click();
    }
  });

  window.addEventListener('keydown', (e) => {
    if (e.key === 'Escape') {
      if (sellYardState.open) {
        closeSellYardUi(true);
        return;
      }
      post('close', {});
      showOverlay(false);
    }
  });
}

function buildSellYardDom() {
  const overlay = document.getElementById('sellYardOverlay');
  if (!overlay || overlay.querySelector('.wr-root')) return;

  const main = document.createElement('main');
  main.className = 'wr-root wr-sell-yard';

  const header = document.createElement('header');
  header.className = 'wr-topbar';
  header.innerHTML =
    '<div class="wr-brand">' +
    '<p class="wr-brand__eyebrow">' +
    ranchT('sellYardPanel.title') +
    '</p>' +
    '<h1 class="wr-brand__title">' +
    ranchT('sellYardPanel.title') +
    '</h1>' +
    '</div>' +
    '<button type="button" id="btnCloseSellYard" class="wr-close wr-nav-btn wr-nav-btn--compact" aria-label="' +
    ranchT('sellYardPanel.closeAria') +
    '"><span>' +
    ranchT('sellYardPanel.close') +
    '</span></button>';

  const frame = document.createElement('div');
  frame.className = 'wr-frame wr-frame--sell-yard';

  const body = document.createElement('div');
  body.className = 'wr-body';

  const panel = document.createElement('section');
  panel.id = 'panel-sell-yard';
  panel.className = 'wr-panel wr-panel--herd';
  panel.innerHTML =
    '<header class="wr-section-head">' +
    '<h2 class="wr-section-head__title">' +
    ranchT('sellYardPanel.title') +
    '</h2>' +
    '<p class="wr-section-head__lead">' +
    ranchT('sellYardPanel.lead') +
    '</p>' +
    '<p id="sellYardRanchLine" class="wr-sell-yard__ranch hidden"></p>' +
    '</header>' +
    '<div id="sellYardHerdList" class="wr-herd-list" role="list" aria-label="' +
    ranchT('sellYardPanel.herdAria') +
    '"></div>';

  body.appendChild(panel);
  frame.appendChild(body);
  main.appendChild(header);
  main.appendChild(frame);
  overlay.appendChild(main);
}

let sellYardEventsWired = false;

function wireSellYardEvents() {
  if (sellYardEventsWired) return;
  sellYardEventsWired = true;
  $('btnCloseSellYard')?.addEventListener('click', () => closeSellYardUi(true));
}

function showSellYardOverlay(show) {
  const el = document.getElementById('sellYardOverlay');
  if (!el) return;
  el.classList.toggle('hidden', !show);
  el.setAttribute('aria-hidden', show ? 'false' : 'true');
  document.body.classList.toggle('ranch-body--sell-yard-open', !!show);
}

function closeSellYardUi(notifyLua) {
  sellYardState.open = false;
  sellYardState.data = null;
  showSellYardOverlay(false);
  if (notifyLua) post('closeSellYard', {});
}

function renderSellYardList() {
  const root = $('sellYardHerdList');
  const ranchLine = $('sellYardRanchLine');
  if (!root || !sellYardState.data) return;

  const animals = sellYardState.data.animals || [];
  const minLvlHead = minSellLevelFromData(sellYardState.data);
  const leadEl = document.querySelector('#panel-sell-yard .wr-section-head__lead');
  if (leadEl) {
    leadEl.textContent =
      ranchT('sellYardPanel.lead') +
      ' ' +
      ranchT('sellYardPanel.minLevelNote', { level: minLvlHead });
  }
  if (ranchLine) {
    const name = sellYardState.data.ranchName ? String(sellYardState.data.ranchName) : '';
    if (name) {
      ranchLine.classList.remove('hidden');
      ranchLine.innerHTML =
        ranchT('sellYardPanel.ranchLabel') + ' <strong>' + name + '</strong>';
    } else {
      ranchLine.classList.add('hidden');
      ranchLine.innerHTML = '';
    }
  }

  root.innerHTML = '';
  if (animals.length === 0) {
    root.innerHTML =
      '<div class="wr-empty wr-empty--herd">' +
      '<p class="wr-empty__line">' +
      ranchT('sellYardPanel.emptyLine') +
      '</p>' +
      '<p class="wr-empty__hint">' +
      ranchT('sellYardPanel.emptyHint') +
      '</p></div>';
    return;
  }

  const minLvl = minSellLevelFromData(sellYardState.data);

  animals.forEach((a) => {
    const meta = getShopAnimals().find((x) => x.type === a.type);
    const imgSrc = meta ? nuiHtml(meta.img) : '';
    const species = animalTypeTitle(a.type) || a.type;
    const price = formatPrice(a.sell_price);
    const curLvl = animalDisplayLevel(a);
    const canSell = curLvl >= minLvl;
    const article = document.createElement('article');
    article.className = 'wr-herd-card wr-herd-card--walking';
    article.setAttribute('role', 'listitem');
    article.innerHTML =
      '<div class="wr-herd-card__media">' +
      '<div class="wr-herd-card__slot">' +
      '<img src="' +
      imgSrc +
      '" alt="" class="wr-herd-card__img" />' +
      '</div></div>' +
      '<div class="wr-herd-card__body">' +
      '<div class="wr-herd-card__head">' +
      '<div class="wr-herd-card__title-block">' +
      '<h3 class="wr-herd-card__title">' +
      species +
      '</h3>' +
      buildAnimalXpHeadHtml(a) +
      '</div>' +
      '<span class="wr-herd-card__id">#' +
      a.id +
      '</span></div>' +
      '<div class="wr-herd-card__stats">' +
      buildAnimalStatsInline(a, { hideMarketHint: true }) +
      '</div></div>' +
      '<div class="wr-herd-card__commerce">' +
      '<div class="wr-buy-card__pricebox">' +
      '<span class="wr-buy-card__price-lab">' +
      ranchT('animalsPanel.sellValue') +
      '</span>' +
      '<div class="wr-price wr-price--buy">' +
      '<span class="wr-price__sym">$</span>' +
      '<span class="wr-price__val">' +
      price +
      '</span></div></div>' +
      '<button type="button" class="wr-herd-card__sell wr-nav-btn' +
      (canSell ? '' : ' wr-herd-card__sell--blocked') +
      '" data-sell-yard="' +
      a.id +
      '"' +
      (canSell ? '' : ' disabled') +
      ' title="' +
      (canSell
        ? ranchT('animalsPanel.sellBtn')
        : ranchT('animalsPanel.sellMinLevelHint', { level: minLvl })) +
      '">' +
      (canSell
        ? ranchT('animalsPanel.sellBtn')
        : ranchT('animalsPanel.sellLevelTooLowBtn', { current: curLvl, min: minLvl })) +
      '</button></div>';

    article.querySelector('[data-sell-yard]')?.addEventListener('click', (ev) => {
      const btn = ev.currentTarget;
      if (!btn || btn.disabled) return;
      btn.disabled = true;
      post('sellYardAnimal', { animalId: a.id })
        .then((r) => r.json())
        .then((res) => {
          if (res && res.ok && res.data && res.data.animals) {
            sellYardState.data = res.data;
            renderSellYardList();
            applyNuiImages();
          } else if (res && res.ok) {
            closeSellYardUi(true);
          }
        })
        .catch(() => {})
        .finally(() => {
          if (btn.isConnected) btn.disabled = false;
        });
    });
    root.appendChild(article);
  });
  applyNuiImages();
}

function openSellYardUi(payload) {
  sellYardState.data = payload || null;
  sellYardState.open = true;
  buildSellYardDom();
  if (!sellYardEventsWired) wireSellYardEvents();
  renderSellYardList();
  showSellYardOverlay(true);
}

function post(name, data) {
  return fetch(`https://${resName}/${name}`, {
    method: 'POST',
    headers: { 'Content-Type': 'application/json; charset=UTF-8' },
    body: JSON.stringify(data || {}),
  });
}

let state = {
  data: null,
  placement: null,
  activeRanchId: null,
  walkActiveIds: [],
  walkHud: null,
  walkNearRanch: true,
};

const sellYardState = {
  open: false,
  data: null,
};

const $ = (id) => document.getElementById(id);

function showOverlay(show) {
  const el = $('overlay');
  if (!el) return;
  el.classList.toggle('hidden', !show);
  document.body.classList.toggle('ranch-body--panel-open', !!show);
}

function normalizeWalkIds(ids) {
  if (!Array.isArray(ids)) return [];
  return ids.map((id) => Number(id)).filter((n) => Number.isFinite(n) && n > 0);
}

function walkIdsEqual(a, b) {
  const x = normalizeWalkIds(a).sort((p, q) => p - q);
  const y = normalizeWalkIds(b).sort((p, q) => p - q);
  if (x.length !== y.length) return false;
  for (let i = 0; i < x.length; i += 1) {
    if (x[i] !== y[i]) return false;
  }
  return true;
}

function isAnimalInWalk(animalId) {
  const id = Number(animalId);
  return state.walkActiveIds.some((x) => Number(x) === id);
}

function canAddAnimalToWalk() {
  if (state.walkActiveIds.length === 0) return true;
  return state.walkNearRanch !== false;
}

function applyWalkNearRanch(msg) {
  if (msg && typeof msg.nearRanch === 'boolean') {
    const prev = state.walkNearRanch;
    state.walkNearRanch = msg.nearRanch;
    if (prev !== msg.nearRanch && state.walkActiveIds.length > 0) {
      renderAnimalList();
    }
  }
}

function applyWalkSession(msg) {
  if (!msg || msg.active === false) {
    state.walkActiveIds = [];
    state.walkHud = null;
    state.walkNearRanch = true;
    setWalkHudVisible(false);
    renderAnimalList();
    return;
  }
  applyWalkNearRanch(msg);
  const newIds = normalizeWalkIds(msg.animalIds);
  const idsChanged = !walkIdsEqual(state.walkActiveIds, newIds);
  state.walkActiveIds = newIds;
  if (msg.hud) {
    state.walkHud = msg.hud;
    updateWalkHud(msg.hud);
  } else if (state.walkHud) {
    updateWalkHud(state.walkHud);
  }
  setWalkHudVisible(state.walkActiveIds.length > 0);
  if (msg.openHerdTab) {
    setTab('rebanho');
  }
  if (idsChanged || msg.openHerdTab) {
    renderAnimalList();
  }
}

function setWalkHudVisible(show) {
  const hud = $('walkHud');
  if (!hud) return;
  hud.classList.toggle('hidden', !show);
  hud.setAttribute('aria-hidden', show ? 'false' : 'true');
}

function updateWalkHud(hud) {
  if (!hud) return;
  state.walkHud = hud;
  const line = $('walkHudLine');
  const hint = $('walkHudHint');
  if (line) {
    line.textContent = ranchT('ui.walkHudProgress', {
      count: hud.count != null ? hud.count : 0,
      dist: hud.dist != null ? hud.dist : 0,
      sec: hud.sec != null ? hud.sec : 0,
    });
  }
  if (hint) {
    hint.textContent = ranchT('ui.walkHudHint');
  }
  setWalkHudVisible(true);
}

function setTab(name) {
  document.querySelectorAll('.wr-nav-item').forEach((b) => {
    b.classList.toggle('wr-nav-item--active', b.dataset.tab === name);
  });
  const map = {
    geral: 'panel-geral',
    animais: 'panel-animais',
    rebanho: 'panel-rebanho',
    estruturas: 'panel-estruturas',
    func: 'panel-func',
  };
  const activeId = map[name] || 'panel-geral';
  Object.values(map).forEach((sid) => {
    const sec = document.getElementById(sid);
    if (sec) sec.classList.toggle('hidden', sid !== activeId);
  });
}

function prettyRanchName(raw) {
  if (raw == null || raw === '') return '—';
  const s = String(raw).trim();
  if (!s) return '—';
  return s
    .split(/\s+/)
    .map((w) => {
      if (!w) return w;
      return w.charAt(0).toUpperCase() + w.slice(1).toLowerCase();
    })
    .join(' ');
}

function ranchStats(ranch, animals) {
  let w = 0;
  let c = 0;
  (animals || []).forEach((a) => {
    if (a.ranch_id === ranch.id) {
      c += 1;
      w += Number(a.weight || 0);
    }
  });
  return { count: c, weight: w.toFixed(1) };
}

/** Current ranch = first in list (no “active ranch” dropdown) */
function syncActiveRanch() {
  if (!state.data) return;
  const ranches = state.data.ranches || [];
  if (ranches.length > 0) {
    const keep =
      state.activeRanchId &&
      ranches.some((r) => Number(r.id) === Number(state.activeRanchId));
    if (!keep) {
      state.activeRanchId = Number(ranches[0].id);
    }
  } else {
    state.activeRanchId = null;
  }
  updateGeral();
}

function updateGeral() {
  const ranches = state.data?.ranches || [];
  const animals = state.data?.animalsFull || [];

  const emptyEl = $('geral-empty');
  const detailsEl = $('geral-details');
  if (!emptyEl || !detailsEl) return;
  emptyEl.classList.toggle('hidden', ranches.length > 0);
  detailsEl.classList.toggle('hidden', ranches.length === 0);

  if (ranches.length === 0) return;

  const rid = Number(state.activeRanchId || ranches[0].id);
  state.activeRanchId = rid;
  const ranch = ranches.find((x) => Number(x.id) === rid) || ranches[0];
  const st = ranchStats(ranch, animals);

  const nameInput = $('r-name-input');
  if (nameInput && document.activeElement !== nameInput) {
    nameInput.value = ranch.name ? String(ranch.name) : '';
  }
  $('r-acount').textContent = String(st.count);
  $('r-weight').textContent = st.weight;

  const whPanel = $('ranchWebhookPanel');
  const whInput = $('ranchWebhookUrl');
  const access = activeRanchAccess();
  const isOwner = !!(access && access.perms && access.perms.isOwner);
  if (whPanel) whPanel.classList.toggle('hidden', !isOwner);
  if (whInput && isOwner && document.activeElement !== whInput) {
    whInput.value = ranch.webhook_masked ? '' : '';
    whInput.placeholder = ranch.webhook_masked
      ? '********'
      : ranchT('general.webhookPlaceholder');
  }
  renderRanchWallet();
}

function minSellLevelFromData(d) {
  const n = Number(d?.minSellLevel);
  return Number.isFinite(n) && n >= 1 ? Math.floor(n) : 1;
}

function animalDisplayLevel(a) {
  const lvl = Number(a?.level);
  if (Number.isFinite(lvl) && lvl >= 1) return Math.floor(lvl);
  return getAnimalXpMeta(a?.experience).level;
}

function animalCanSellAtMarket(a, d) {
  return animalDisplayLevel(a) >= minSellLevelFromData(d);
}

function getAnimalXpConfig() {
  const src = sellYardState.open && sellYardState.data ? sellYardState.data : state.data;
  const maxExp = Number(src?.animalMaxExperience);
  const maxLevel = Number(src?.animalMaxLevel);
  return {
    maxExp: Number.isFinite(maxExp) && maxExp > 0 ? maxExp : 100,
    maxLevel: Number.isFinite(maxLevel) && maxLevel > 0 ? Math.floor(maxLevel) : 10,
  };
}

function getAnimalXpMeta(exp) {
  const { maxExp, maxLevel } = getAnimalXpConfig();
  const xp = Math.max(0, Math.min(maxExp, Number(exp) || 0));
  const xpPerLevel = maxExp / maxLevel;
  let level = Math.floor(xp / xpPerLevel) + 1;
  if (xp >= maxExp) {
    level = maxLevel;
  }
  level = Math.max(1, Math.min(maxLevel, level));
  const totalPct = maxExp > 0 ? Math.max(0, Math.min(100, (xp / maxExp) * 100)) : 0;
  return { xp, maxExp, level, maxLevel, totalPct };
}

function buildAnimalXpHeadHtml(a) {
  const meta = getAnimalXpMeta(a.experience);
  return (
    '<div class="wr-herd-card__xp-block" title="' +
    ranchT('animalsPanel.experience') +
    '">' +
    '<span class="wr-herd-card__level">' +
    ranchT('animalsPanel.levelShort', { level: meta.level }) +
    '</span>' +
    '<div class="wr-herd-card__xp">' +
    '<div class="wr-herd-card__xp-track" role="progressbar" aria-valuenow="' +
    Math.round(meta.totalPct) +
    '" aria-valuemin="0" aria-valuemax="100">' +
    '<div class="wr-herd-card__xp-fill" style="width:' +
    meta.totalPct.toFixed(1) +
    '%"></div></div>' +
    '<span class="wr-herd-card__xp-val">' +
    Math.round(meta.xp) +
    '<span class="wr-herd-card__xp-sep">/</span>' +
    Math.round(meta.maxExp) +
    ' ' +
    ranchT('animalsPanel.xpBarLabel') +
    '</span></div></div>'
  );
}

function getWanderRadiusBounds() {
  const minR = Number(state.data?.wanderRadiusMin);
  const maxR = Number(state.data?.wanderRadiusMax);
  const def = Number(state.data?.wanderRadiusDefault);
  return {
    min: Number.isFinite(minR) && minR > 0 ? minR : 3,
    max: Number.isFinite(maxR) && maxR > 0 ? maxR : 18,
    default: Number.isFinite(def) && def > 0 ? def : 8,
  };
}

function wanderRadiusForActiveRanch() {
  const { min, max, default: def } = getWanderRadiusBounds();
  const rid = state.activeRanchId;
  const ranch = (state.data?.ranches || []).find((r) => Number(r.id) === Number(rid));
  let raw = ranch?.wander_radius;
  if (raw == null) {
    const animals = (state.data?.animalsFull || []).filter(
      (a) => Number(a.ranch_id) === Number(rid)
    );
    if (animals.length && animals[0].wander_radius != null) {
      raw = animals[0].wander_radius;
    }
  }
  const n = Number.isFinite(Number(raw)) ? Number(raw) : def;
  return Math.max(min, Math.min(max, n));
}

let herdWanderDebounce = null;

function renderHerdWanderGlobal() {
  const root = $('herdWanderGlobal');
  if (!root || !state.data) return;
  const rid = state.activeRanchId;
  const animals = (state.data.animalsFull || []).filter(
    (a) => Number(a.ranch_id) === Number(rid)
  );
  if (!rid || animals.length === 0) {
    root.classList.add('hidden');
    root.innerHTML = '';
    return;
  }
  const { min, max } = getWanderRadiusBounds();
  const val = wanderRadiusForActiveRanch();
  const step = max - min > 30 ? 1 : 0.5;
  root.classList.remove('hidden');
  root.innerHTML =
    '<div class="wr-herd-wander__head">' +
    '<span class="wr-herd-wander__lab">' +
    ranchT('animalsPanel.wanderRadius') +
    '</span>' +
    '<span class="wr-herd-wander__val" id="herdWanderVal">' +
    ranchT('animalsPanel.wanderRadiusMeters', { value: val.toFixed(1) }) +
    '</span></div>' +
    '<input type="range" class="wr-herd-wander__range" id="herdWanderRange" min="' +
    min +
    '" max="' +
    max +
    '" step="' +
    step +
    '" value="' +
    val +
    '" aria-label="' +
    ranchT('animalsPanel.wanderRadius') +
    '" title="' +
    ranchT('animalsPanel.wanderRadiusHint') +
    '" />' +
    '<div class="wr-herd-wander__scale">' +
    '<span>' +
    ranchT('animalsPanel.wanderRadiusClose') +
    '</span>' +
    '<span>' +
    ranchT('animalsPanel.wanderRadiusFar') +
    '</span></div>';

  const input = $('herdWanderRange');
  const valEl = $('herdWanderVal');
  if (!input) return;
  input.addEventListener('input', (ev) => {
    const n = Number(ev.currentTarget.value);
    if (!Number.isFinite(n)) return;
    if (valEl) {
      valEl.textContent = ranchT('animalsPanel.wanderRadiusMeters', {
        value: n.toFixed(1),
      });
    }
    if (herdWanderDebounce) clearTimeout(herdWanderDebounce);
    herdWanderDebounce = setTimeout(() => {
      post('setRanchWanderRadius', { ranchId: rid, radius: n })
        .then((r) => r.json())
        .then((d) => {
          if (d && typeof d === 'object') {
            state.data = d;
            syncActiveRanch();
            updateGeral();
            renderHerdWanderGlobal();
            renderAnimalShopList();
            renderStructShopCards();
            renderAnimalList();
            renderWorkers();
            applyNuiImages();
          }
        })
        .catch(() => {});
    }, 420);
  });
}

function buildAnimalStatsInline(a, opts) {
  opts = opts || {};
  const pct = (v) => {
    const n = Number(v);
    return Number.isFinite(n) ? Math.max(0, Math.min(100, n)) : null;
  };
  const bar = (label, val, mod) => {
    const p = pct(val);
    const w = p == null ? 0 : p;
    const show = p == null ? '\u2014' : Math.round(p) + '%';
    return (
      '<div class="wr-herd-stat">' +
      '<div class="wr-herd-stat__head">' +
      '<span class="wr-herd-stat__lab">' +
      label +
      '</span>' +
      '<span class="wr-herd-stat__pct">' +
      show +
      '</span></div>' +
      '<div class="wr-herd-stat__track">' +
      '<div class="wr-herd-stat__fill ' +
      (mod || '') +
      '" style="width:' +
      w +
      '%"></div></div></div>'
    );
  };
  let growthHtml = '';
  if (a.growth !== undefined && a.growth !== null && Number.isFinite(Number(a.growth))) {
    growthHtml =
      '<span class="wr-herd-card__growth">' +
      ranchT('animalsPanel.growth') +
      ' <strong>' +
      Number(a.growth).toFixed(1) +
      '%</strong></span>';
  }
  let sellHtml = '';
  if (
    !opts.hideMarketHint &&
    a.sell_price !== undefined &&
    a.sell_price !== null &&
    Number.isFinite(Number(a.sell_price))
  ) {
    sellHtml =
      '<span class="wr-herd-card__meta-line wr-herd-card__sell-hint">' +
      ranchT('animalsPanel.sellValue') +
      ' <strong>$ ' +
      formatPrice(a.sell_price) +
      '</strong> · ' +
      ranchT('animalsPanel.sellAtMarketHint') +
      ' · ' +
      ranchT('animalsPanel.sellMinLevelHint', {
        level: minSellLevelFromData(state.data),
      }) +
      '</span>';
  }
  return (
    bar(ranchT('animalsPanel.health'), a.health, 'wr-herd-stat__fill--health') +
    bar(ranchT('animalsPanel.hunger'), a.hunger, 'wr-herd-stat__fill--hunger') +
    bar(ranchT('animalsPanel.thirst'), a.thirst, 'wr-herd-stat__fill--thirst') +
    '<div class="wr-herd-card__meta">' +
    '<span class="wr-herd-card__meta-line">' +
    ranchT('animalsPanel.weight') +
    ' <strong>' +
    Number(a.weight || 0).toFixed(1) +
    ' ' +
    ranchT('general.kg') +
    '</strong></span>' +
    growthHtml +
    sellHtml +
    '</div>'
  );
}

/** Feed/water trough per species + coop (same species list as shop animals). */
function buildStructShopMetas() {
  const out = [];
  getShopAnimals().forEach((a) => {
    out.push({
      stype: 'food_trough',
      animalType: a.type,
      title: ranchT('structures.foodTitle', { species: a.title }),
      img: 'img/cochofood.png',
      desc: ranchT('structures.feedDesc', { species: a.title.toLowerCase() }),
    });
    out.push({
      stype: 'water_trough',
      animalType: a.type,
      title: ranchT('structures.waterTitle', { species: a.title }),
      img: 'img/cochowater.png',
      desc: ranchT('structures.waterDesc', { species: a.title.toLowerCase() }),
    });
  });
  out.push({
    stype: 'chicken_coop',
    animalType: null,
    title: ranchT('structures.coopTitle'),
    img: 'img/galinheiro.png',
    desc: ranchT('structures.coopDesc'),
  });
  out.push({
    stype: 'storage_chest',
    animalType: null,
    title: ranchT('structures.chestTitle'),
    img: 'img/chest.png',
    desc: ranchT('structures.chestDesc'),
  });
  return out;
}

function normStructAnimalType(v) {
  if (v === undefined || v === null || v === '') return null;
  return String(v);
}

/** At least one matching structure on active ranch (type + species on troughs) */
function ranchOwnsStructure(rid, stype, animalType) {
  if (!rid || !state.data) return false;
  const want = normStructAnimalType(animalType);
  return (state.data.structures || []).some((s) => {
    if (Number(s.ranch_id) !== Number(rid) || s.type !== stype) return false;
    if (stype === 'chicken_coop' || stype === 'storage_chest') return true;
    return normStructAnimalType(s.animal_type) === want;
  });
}

function countAnimalsOnRanchOfType(rid, animalType) {
  if (!rid || !state.data) return 0;
  let n = 0;
  (state.data.animalsFull || []).forEach((a) => {
    if (Number(a.ranch_id) === Number(rid) && a.type === animalType) n += 1;
  });
  return n;
}

function maxAnimalsPerType() {
  const n = Number(state.data?.maxAnimalsPerType);
  return Number.isFinite(n) && n > 0 ? Math.floor(n) : 4;
}

function formatPrice(p) {
  const n = Number(p);
  return Number.isFinite(n) ? Math.floor(n).toLocaleString('en-US') : '\u2014';
}

function renderStructShopCards() {
  const root = $('structShopCards');
  if (!root || !state.data) return;
  const prices = state.data.pricesStruct || {};
  const metas = buildStructShopMetas();
  const rid = state.activeRanchId;
  root.innerHTML = '';
  metas.forEach((meta) => {
    const price = formatPrice(prices[meta.stype]);
    const owns = ranchOwnsStructure(rid, meta.stype, meta.animalType);
    const article = document.createElement('article');
    article.className = 'wr-buy-card' + (owns ? ' wr-buy-card--owned' : '');
    article.setAttribute('role', 'listitem');
    const idSlug = meta.animalType ? `${meta.stype}-${meta.animalType}` : meta.stype;
    article.id = `struct-shop-${idSlug}`;
    const atEsc = meta.animalType ? String(meta.animalType) : '';
    const ownedBadge = owns
      ? '<span class="wr-buy-card__badge wr-buy-card__badge--owned">' +
        ranchT('structures.owned') +
        '</span>'
      : '';
    const buyLabel = owns ? ranchT('structures.limitReached') : ranchT('structures.buy');
    article.innerHTML =
      '<div class="wr-buy-card__media">' +
      ownedBadge +
      '<div class="wr-buy-card__slot">' +
      '<img src="' +
      nuiHtml(meta.img) +
      '" alt="" class="wr-buy-card__img" />' +
      '</div></div>' +
      '<div class="wr-buy-card__body">' +
      '<h3 class="wr-buy-card__title">' +
      meta.title +
      '</h3>' +
      '<p class="wr-buy-card__desc">' +
      meta.desc +
      '</p></div>' +
      '<div class="wr-buy-card__commerce">' +
      '<div class="wr-buy-card__pricebox">' +
      '<span class="wr-buy-card__price-lab">' +
      ranchT('animalsPanel.priceLabel') +
      '</span>' +
      '<div class="wr-price wr-price--buy">' +
      '<span class="wr-price__sym">$</span>' +
      '<span class="wr-price__val">' +
      price +
      '</span></div></div>' +
      '<button type="button" class="wr-buy-card__buy wr-nav-btn" data-s-stype="' +
      meta.stype +
      '" data-s-at="' +
      atEsc +
      '"' +
      (owns ? ' disabled' : '') +
      '>' +
      buyLabel +
      '</button></div>';
    article.querySelector('button[data-s-stype]')?.addEventListener('click', () => {
      const btn = article.querySelector('button[data-s-stype]');
      if (!btn || btn.disabled) return;
      const stype = btn.getAttribute('data-s-stype');
      const raw = btn.getAttribute('data-s-at');
      const animalType =
        stype === 'chicken_coop' || stype === 'storage_chest' || !raw || raw === '' ? null : raw;
      post('buyStructure', { ranchId: state.activeRanchId, stype, animalType });
    });
    root.appendChild(article);
  });
  applyNuiImages();
}

function renderAnimalShopList() {
  const root = $('animalShopList');
  if (!root || !state.data) return;
  root.className = 'wr-buy-list wr-buy-list--animals';
  const prices = state.data.pricesAnimals || {};
  const rid = state.activeRanchId;
  root.innerHTML = '';
  const typeCap = maxAnimalsPerType();
  getShopAnimals().forEach((meta) => {
    const price = formatPrice(prices[meta.type]);
    const cnt = countAnimalsOnRanchOfType(rid, meta.type);
    const atCap = cnt >= typeCap;
    const article = document.createElement('article');
    article.className = 'wr-buy-card' + (atCap ? ' wr-buy-card--owned' : '');
    article.setAttribute('role', 'listitem');
    const countBadge =
      '<span class="wr-buy-card__badge' +
      (atCap ? ' wr-buy-card__badge--owned' : '') +
      '">' +
      ranchT('animalsPanel.herdCountOnRanch', { current: cnt, max: typeCap }) +
      '</span>';
    const buyLabel = atCap ? ranchT('structures.limitReached') : ranchT('animalsPanel.buy');
    article.innerHTML =
      '<div class="wr-buy-card__media">' +
      countBadge +
      '<div class="wr-buy-card__slot">' +
      '<img src="' +
      nuiHtml(meta.img) +
      '" alt="" class="wr-buy-card__img" />' +
      '</div></div>' +
      '<div class="wr-buy-card__body">' +
      '<h3 class="wr-buy-card__title">' +
      meta.title +
      '</h3>' +
      '<p class="wr-buy-card__desc">' +
      meta.desc +
      '</p></div>' +
      '<div class="wr-buy-card__commerce">' +
      '<div class="wr-buy-card__pricebox">' +
      '<span class="wr-buy-card__price-lab">' +
      ranchT('animalsPanel.priceLabel') +
      '</span>' +
      '<div class="wr-price wr-price--buy">' +
      '<span class="wr-price__sym">$</span>' +
      '<span class="wr-price__val">' +
      price +
      '</span></div></div>' +
      '<button type="button" class="wr-buy-card__buy wr-nav-btn" data-buy="' +
      meta.type +
      '"' +
      (atCap ? ' disabled' : '') +
      '>' +
      buyLabel +
      '</button></div>';
    article.querySelector('[data-buy]')?.addEventListener('click', () => {
      const btn = article.querySelector('[data-buy]');
      if (!btn || btn.disabled) return;
      post('buyAnimal', { ranchId: state.activeRanchId, animalType: meta.type });
    });
    root.appendChild(article);
  });
  applyNuiImages();
}

function renderAnimalList() {
  const root = $('animalHerdList');
  if (!root || !state.data) return;
  const rid = state.activeRanchId;
  const animals = (state.data.animalsFull || [])
    .filter((a) => Number(a.ranch_id) === Number(rid))
    .sort((a, b) => Number(a.id) - Number(b.id));

  renderHerdWanderGlobal();
  root.innerHTML = '';
  if (animals.length === 0) {
    root.innerHTML =
      '<div class="wr-empty wr-empty--herd">' +
      '<p class="wr-empty__line">' +
      ranchT('animalsPanel.emptyHerdLine') +
      '</p>' +
      '<p class="wr-empty__hint">' +
      ranchT('animalsPanel.emptyHerdHint') +
      '</p></div>';
    return;
  }

  animals.forEach((a) => {
    const meta = getShopAnimals().find((x) => x.type === a.type);
    const imgSrc = meta ? nuiHtml(meta.img) : '';
    const species = animalTypeTitle(a.type) || a.type;
    const article = document.createElement('article');
    article.className = 'wr-herd-card';
    article.setAttribute('role', 'listitem');
    const inWalk = isAnimalInWalk(a.id);
    const canAddWalk = canAddAnimalToWalk() || inWalk;
    if (inWalk) {
      article.classList.add('wr-herd-card--walking');
    }
    article.innerHTML =
      '<div class="wr-herd-card__media">' +
      '<div class="wr-herd-card__slot">' +
      '<img src="' +
      imgSrc +
      '" alt="" class="wr-herd-card__img" />' +
      '</div></div>' +
      '<div class="wr-herd-card__body">' +
      '<div class="wr-herd-card__head">' +
      '<div class="wr-herd-card__title-block">' +
      '<h3 class="wr-herd-card__title">' +
      species +
      '</h3>' +
      buildAnimalXpHeadHtml(a) +
      '</div>' +
      '<span class="wr-herd-card__id">#' +
      a.id +
      '</span></div>' +
      '<div class="wr-herd-card__stats">' +
      buildAnimalStatsInline(a) +
      '</div></div>' +
      '<div class="wr-herd-card__commerce">' +
      '<button type="button" class="wr-herd-card__spawn wr-nav-btn" data-spawn-one="' +
      a.id +
      '">' +
      ranchT('animalsPanel.spawnHereBtn') +
      '</button>' +
      '<button type="button" class="wr-herd-card__walk wr-nav-btn' +
      (inWalk ? ' wr-herd-card__walk--active' : '') +
      (!canAddWalk ? ' wr-herd-card__walk--blocked' : '') +
      '" data-walk-one="' +
      a.id +
      '" data-walk-end="' +
      (inWalk ? '1' : '0') +
      '"' +
      (!canAddWalk ? ' disabled' : '') +
      ' title="' +
      (!canAddWalk ? ranchT('animalsPanel.walkNeedRanch') : '') +
      '">' +
      (inWalk
        ? ranchT('animalsPanel.endWalkReturn')
        : !canAddWalk
          ? ranchT('animalsPanel.walkNeedRanch')
          : ranchT('animalsPanel.walkWithAnimal')) +
      '</button></div>';

    const refreshFromPayload = (d) => {
      if (d && typeof d === 'object') {
        state.data = d;
        syncActiveRanch();
        updateGeral();
        renderAnimalShopList();
        renderStructShopCards();
        renderAnimalList();
        renderWorkers();
        applyNuiImages();
      }
    };

    article.querySelector('[data-spawn-one]')?.addEventListener('click', () => {
      post('setAnimalSpawn', { animalId: a.id, ranchId: rid })
        .then((r) => r.json())
        .then(refreshFromPayload)
        .catch(() => {});
    });

    article.querySelector('[data-walk-one]')?.addEventListener('click', (ev) => {
      if (ev.currentTarget.disabled) return;
      post('startAnimalWalk', { animalId: a.id, ranchId: rid })
        .then((r) => r.json())
        .then((d) => {
          if (d && d.walkSession) {
            applyWalkSession(d.walkSession);
          }
          if (d && d.data) {
            refreshFromPayload(d.data);
          }
        })
        .catch(() => {});
    });

    root.appendChild(article);
  });
  applyNuiImages();
}

function crewRoleLabel(level) {
  const n = Number(level);
  if (n >= 3) return ranchT('crew.ownerRole');
  if (n >= 2) return ranchT('crew.managerRole');
  return ranchT('crew.workerRole');
}

function activeRanchAccess() {
  if (!state.data || !state.activeRanchId) return null;
  const map = state.data.ranchAccess || {};
  return map[String(state.activeRanchId)] || null;
}

function renderRanchWallet() {
  const panel = $('ranchWalletPanel');
  const balEl = $('ranchWalletBalance');
  const depBtn = $('btnRanchDeposit');
  const witBtn = $('btnRanchWithdraw');
  const hint = $('ranchWalletHint');
  const access = activeRanchAccess();
  const perms = access?.perms || {};
  const showWallet = !!access && Number(access.roleLevel) >= 1;
  if (panel) panel.classList.toggle('hidden', !showWallet);
  if (balEl && access) {
    const bal = Number(access.balance) || 0;
    balEl.textContent = '$' + bal.toLocaleString('en-US');
  }
  if (depBtn) depBtn.classList.toggle('hidden', !perms.canDepositCash);
  if (witBtn) witBtn.classList.toggle('hidden', !perms.canWithdrawCash);
  if (hint) {
    hint.textContent = perms.canWithdrawCash
      ? ranchT('general.cashHintWithdraw')
      : perms.canDepositCash
        ? ranchT('general.cashHintDeposit')
        : ranchT('general.cashHintView');
  }
}

function renderCrewHirePanel() {
  const hirePanel = $('ranchHirePanel');
  const access = activeRanchAccess();
  const perms = access?.perms || {};
  if (hirePanel) hirePanel.classList.toggle('hidden', !perms.canManage);
}

function crewDisplayFromIdentifier(id) {
  const s = String(id || '').trim();
  if (!s) return '—';
  const idx = s.indexOf(':');
  return idx >= 0 ? s.slice(idx + 1) : s;
}

function crewInitials(displayName) {
  const s = String(displayName || '').trim();
  if (!s) return '?';
  const parts = s.split(/\s+/).filter(Boolean);
  if (parts.length >= 2) {
    return (parts[0][0] + parts[parts.length - 1][0]).toUpperCase();
  }
  const compact = s.replace(/[^a-zA-Z0-9]/g, '');
  return (compact.slice(0, 2) || s.slice(0, 2) || '?').toUpperCase();
}

function buildCrewEmpCard(opts) {
  const displayName = opts.displayName || '—';
  const card = document.createElement('article');
  card.className = 'wr-crew-card' + (opts.isOwner ? ' wr-crew-card--owner' : '');
  card.setAttribute('role', 'listitem');

  const header = document.createElement('div');
  header.className = 'wr-crew-card__header';

  const avatarWrap = document.createElement('div');
  avatarWrap.className = 'wr-crew-card__avatar-wrap';
  const initials = document.createElement('span');
  initials.className = 'wr-crew-card__initials wr-crew-card__initials--visible';
  initials.textContent = crewInitials(displayName);
  initials.setAttribute('aria-hidden', 'true');
  avatarWrap.appendChild(initials);

  const meta = document.createElement('div');
  meta.className = 'wr-crew-card__meta';
  const nameEl = document.createElement('strong');
  nameEl.className = 'wr-crew-card__name';
  if (opts.isOwner) nameEl.id = 'r-owner';
  nameEl.textContent = displayName;
  const roleEl = document.createElement('span');
  roleEl.className = 'wr-crew-card__role';
  roleEl.textContent = opts.roleText || '';
  meta.appendChild(nameEl);
  meta.appendChild(roleEl);
  if (opts.cidText) {
    const cidEl = document.createElement('span');
    cidEl.className = 'wr-crew-card__cid';
    cidEl.textContent = opts.cidText;
    meta.appendChild(cidEl);
  }

  header.appendChild(avatarWrap);
  header.appendChild(meta);
  card.appendChild(header);

  if (!opts.isOwner && opts.actions && opts.actions.length) {
    const actions = document.createElement('div');
    actions.className = 'wr-crew-card__actions wr-crew-card__actions--icons';
    opts.actions.forEach(({ act, label, sym }) => {
      const btn = document.createElement('button');
      btn.type = 'button';
      btn.className =
        'wr-crew-icon-btn wr-nav-btn wr-nav-btn--compact' +
        (act === 'fire' ? ' wr-nav-btn--danger' : '');
      btn.setAttribute('aria-label', label);
      btn.title = label;
      btn.textContent = sym;
      btn.addEventListener('click', () => {
        if (typeof opts.onAction === 'function') opts.onAction(act);
      });
      actions.appendChild(btn);
    });
    card.appendChild(actions);
  } else if (!opts.isOwner && typeof opts.onFire === 'function') {
    const actions = document.createElement('div');
    actions.className = 'wr-crew-card__actions';
    const btn = document.createElement('button');
    btn.type = 'button';
    btn.className = 'wr-crew-card__fire-btn wr-nav-btn wr-nav-btn--danger';
    btn.textContent = ranchT('workers.fire');
    btn.addEventListener('click', opts.onFire);
    actions.appendChild(btn);
    card.appendChild(actions);
  }

  return card;
}

function renderWorkers() {
  const root = $('crewCards');
  const emptyEl = $('crew-empty');
  if (!root || !state.data) return;

  root.innerHTML = '';
  const rid = state.activeRanchId;
  const ownerLabel =
    (state.data.playerName && String(state.data.playerName).trim()) ||
    state.data.identifier ||
    '—';
  const ownerCid =
    (state.data.charid != null && String(state.data.charid)) ||
    (state.data.identifier != null && String(state.data.identifier)) ||
    '';

  root.appendChild(
    buildCrewEmpCard({
      isOwner: true,
      displayName: ownerLabel,
      roleText: ranchT('crew.ownerRole'),
      cidText: ownerCid || null,
    })
  );

  const map = state.data.workers || {};
  const list = map[String(rid)] || [];
  if (emptyEl) {
    emptyEl.classList.toggle('hidden', list.length > 0);
  }
  list.forEach((emp) => {
    const isObj = emp && typeof emp === 'object';
    const identifier = isObj ? String(emp.identifier || '') : String(emp || '');
    const displayName =
      isObj && emp.worker_name ? String(emp.worker_name) : crewDisplayFromIdentifier(identifier);
    const roleLevel = isObj ? Number(emp.role_level) || 1 : 1;
    const access = activeRanchAccess();
    const canManage = !!(access && access.perms && access.perms.canManage);
    const cardOpts = {
      displayName: displayName.length > 24 ? displayName.slice(0, 22) + '…' : displayName,
      roleText: crewRoleLabel(roleLevel),
      cidText: identifier,
    };
    if (canManage) {
      cardOpts.actions = [
        { act: 'promote', label: ranchT('workers.promote'), sym: '\u2191' },
        { act: 'demote', label: ranchT('workers.demote'), sym: '\u2193' },
        { act: 'fire', label: ranchT('workers.fire'), sym: '\u2715' },
      ];
      cardOpts.onAction = (act) => {
        post('workerAction', { ranchId: rid, identifier, action: act }).then(() =>
          post('refresh').then(refreshAll)
        );
      };
    }
    root.appendChild(buildCrewEmpCard(cardOpts));
  });
  renderCrewHirePanel();
}

function refreshAll() {
  return post('refresh', {}).then((r) => r.json()).then((d) => {
    if (d && typeof d === 'object') {
      state.data = d;
      syncActiveRanch();
      updateGeral();
      renderAnimalShopList();
      renderStructShopCards();
      renderAnimalList();
      renderWorkers();
      applyNuiImages();
    }
  }).catch(() => {});
}

function openUi(payload) {
  state.data = payload.data;
  state.placement = payload.placement;
  if (payload.walkSession) {
    applyWalkSession(payload.walkSession);
  }
  showOverlay(true);
  syncActiveRanch();
  updateGeral();
  renderAnimalShopList();
  renderStructShopCards();
  renderAnimalList();
  renderWorkers();
  setTab('geral');
  applyNuiImages();
}

const HEART_PATH =
  'M12 18.35c-4.35-3.55-7.15-6.45-7.15-9.55C4.85 6.05 6.75 4.15 9.25 4.15c1.45 0 2.75.75 3.55 1.95.8-1.2 2.1-1.95 3.55-1.95 2.5 0 4.4 1.9 4.4 4.65 0 3.1-2.8 6-7.15 9.55z';

const HEART_SHINE_PATH =
  'M9.1 7.2c.9-.95 2.1-1.45 3.35-1.2 1.55.3 2.55 1.65 2.55 3.25 0 1.15-.55 2.25-1.65 3.35-1.35 1.35-2.85 2.55-4.25 3.65C7.5 14.5 6 13.3 4.65 12c-1.1-1.1-1.65-2.2-1.65-3.35 0-1.6 1-2.95 2.55-3.25.55-.1 1.1-.05 1.55.2z';

const PRODUCT_PATH = {
  milk:
    'M9.5 2.5h5l1 2.2c.4 1.1.6 2.2.6 3.4V18a2.8 2.8 0 01-2.8 2.8h-2.6A2.8 2.8 0 017 18V8.1c0-1.2.2-2.3.6-3.4l1-2.2zm1.2 4.3h2.6v9.4h-2.6V6.8z',
  wool: 'M6.2 16.2h11.6v-.5a4.2 4.2 0 00-4-4.4 3.6 3.6 0 00-7-.2 4 4 0 00-3.8 4.4v.7zM9 8.5a1.2 1.2 0 102.4 0 1.2 1.2 0 00-2.4 0zm3.8 0a1.2 1.2 0 102.3 0 1.2 1.2 0 00-2.3 0z',
  egg: 'M12 5.2c-2.6 3.4-4.2 6.8-4.2 9.1a4.2 4.2 0 008.4 0c0-2.3-1.6-5.7-4.2-9.1z',
  meat:
    'M5.8 11.4c1.4-2.4 3.8-3.8 7.2-3.2 2.8.5 4.6 3 4.2 5.6-.4 2.6-2.8 4.8-6.2 4.3-3.4-.5-5.8-3.3-5.2-6.7z',
};

const PRODUCT_GRADIENT = {
  milk: ['#d4e8ff', '#7eb8e8', '#e8f6ff'],
  wool: ['#ede7ff', '#b8a0e0', '#f5f2ff'],
  egg: ['#fff4c4', '#ffc107', '#fff8e1'],
  meat: ['#7a1f2e', '#e85d6e', '#ffb3bc'],
};

/** Vaccine icon on world HUD when animal is sick */
const VACCINE_PATH =
  'M8.5 3h7v2.2l-1.4 1.6h-4.2L8.5 5.2V3zm1.8 5.2h3.4l.6 1.8H9.7l.6-1.8zM11 11.8v7.2h2V11.8h-2zm-1 9.2h4v1.5H10v-1.5z';

function buildVaccineIcon(gradId) {
  const gid = gradId || 'mxranch_vaccine_grad';
  return (
    '<svg class="world-animal-vaccine-wrap" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg" aria-hidden="true" title="' +
    ranchT('worldHud.needsVaccine') +
    '">' +
    '<defs><linearGradient id="' +
    gid +
    '" x1="0%" y1="0%" x2="0%" y2="100%">' +
    '<stop offset="0%" stop-color="#b8e8ff"/>' +
    '<stop offset="50%" stop-color="#4db8e8"/>' +
    '<stop offset="100%" stop-color="#1a6a9a"/></linearGradient></defs>' +
    '<path class="world-animal-vaccine-bg" d="' +
    VACCINE_PATH +
    '" fill="#1a2838" stroke="rgba(120, 200, 255, 0.55)" stroke-width="0.5"/>' +
    '<path class="world-animal-vaccine-fill" d="' +
    VACCINE_PATH +
    '" fill="url(#' +
    gid +
    ')"/>' +
    '</svg>'
  );
}

function productKindForAnimal(t) {
  const k = String(t || '');
  if (k === 'vacas' || k === 'cabras') return 'milk';
  if (k === 'ovelhas') return 'wool';
  if (k === 'galinhas') return 'egg';
  if (k === 'porcos') return 'meat';
  return 'egg';
}

/** Pigs: no product icon on world HUD (meat path looked like a dot). */
function worldHudShowsProductIcon(animalType) {
  return String(animalType || '') !== 'porcos';
}

/** Product bar (milk/wool/egg): bottom-to-top fill like the heart */
function buildProgressProduct(productPct, animalType, clipId, gradId) {
  const p = Math.max(0, Math.min(100, Number(productPct) || 0));
  const kind = productKindForAnimal(animalType);
  const pathD = PRODUCT_PATH[kind] || PRODUCT_PATH.egg;
  const g = PRODUCT_GRADIENT[kind] || PRODUCT_GRADIENT.egg;
  const fillH = 24 * (p / 100);
  const fillY = 24 - fillH;
  return (
    '<svg class="world-animal-product-wrap" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg" aria-hidden="true">' +
    '<defs>' +
    '<linearGradient id="' +
    gradId +
    '" x1="0%" y1="100%" x2="0%" y2="0%">' +
    '<stop offset="0%" stop-color="' +
    g[0] +
    '"/>' +
    '<stop offset="50%" stop-color="' +
    g[1] +
    '"/>' +
    '<stop offset="100%" stop-color="' +
    g[2] +
    '"/>' +
    '</linearGradient>' +
    '<clipPath id="' +
    clipId +
    '"><rect x="0" y="' +
    fillY +
    '" width="24" height="' +
    fillH +
    '"/></clipPath>' +
    '</defs>' +
    '<path class="world-animal-product-bg" d="' +
    pathD +
    '" fill="#221c18" stroke="rgba(165, 132, 88, 0.45)" stroke-width="0.45" />' +
    '<g clip-path="url(#' +
    clipId +
    ')">' +
    '<path class="world-animal-product-fill" d="' +
    pathD +
    '" fill="url(#' +
    gradId +
    ')"/>' +
    '</g></svg>'
  );
}

/** Heart: bottom-to-top fill + glow */
function buildProgressHeart(healthPct, clipId, gradId) {
  const h = Math.max(0, Math.min(100, Number(healthPct) || 0));
  const fillH = 24 * (h / 100);
  const fillY = 24 - fillH;
  return (
    '<svg class="world-animal-heart-wrap" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg" aria-hidden="true">' +
    '<defs>' +
    '<linearGradient id="' +
    gradId +
    '" x1="0%" y1="100%" x2="0%" y2="0%">' +
    '<stop offset="0%" stop-color="#7a1818"/>' +
    '<stop offset="45%" stop-color="#c73a3a"/>' +
    '<stop offset="78%" stop-color="#e86a62"/>' +
    '<stop offset="100%" stop-color="#ffd4cc"/>' +
    '</linearGradient>' +
    '<clipPath id="' +
    clipId +
    '"><rect x="0" y="' +
    fillY +
    '" width="24" height="' +
    fillH +
    '"/></clipPath>' +
    '</defs>' +
    '<path class="world-animal-heart-bg" d="' +
    HEART_PATH +
    '" fill="#1a1210" stroke="rgba(120, 70, 55, 0.65)" stroke-width="0.55" />' +
    '<g clip-path="url(#' +
    clipId +
    ')">' +
    '<path class="world-animal-heart-fill" d="' +
    HEART_PATH +
    '" fill="url(#' +
    gradId +
    ')"/>' +
    '<path class="world-animal-heart-shine" d="' +
    HEART_SHINE_PATH +
    '" fill="rgba(255, 220, 210, 0.42)"/>' +
    '</g></svg>'
  );
}

/** Reused cards — avoids innerHTML every frame (smooth world HUD). */
const worldAnimalHudPool = new Map();

function worldAnimalHudStatKey(it) {
  return [
    it.nameWt,
    it.healthPct,
    worldHudShowsProductIcon(it.animalType) ? it.productPct : '',
    it.needsVaccine ? 1 : 0,
    it.experience,
    it.animalType,
  ].join('|');
}

function fillWorldAnimalCard(card, it, slot) {
  const row = document.createElement('div');
  row.className = 'world-animal-row';
  const xpMeta = getAnimalXpMeta(it.experience);
  const main = document.createElement('div');
  main.className = 'world-animal-main';
  main.innerHTML =
    '<div class="world-animal-top">' +
    '<span class="world-animal-name">' +
    (it.nameWt || '') +
    '</span>' +
    '<span class="world-animal-level">' +
    ranchT('animalsPanel.levelShort', { level: xpMeta.level }) +
    '</span></div>' +
    '<div class="world-animal-xp-row">' +
    '<div class="world-animal-xp__track" role="progressbar" aria-valuenow="' +
    Math.round(xpMeta.totalPct) +
    '">' +
    '<div class="world-animal-xp__fill" style="width:' +
    xpMeta.totalPct.toFixed(1) +
    '%"></div></div>' +
    '<span class="world-animal-xp__val">' +
    Math.round(xpMeta.xp) +
    '<span class="world-animal-xp__sep">/</span>' +
    Math.round(xpMeta.maxExp) +
    '</span></div>';
  const icons = document.createElement('div');
  icons.className = 'world-animal-icons';
  const hClip = 'mxranch_wh_' + slot;
  const hGrad = 'mxranch_hg_' + slot;
  const pClip = 'mxranch_wp_' + slot;
  const pGrad = 'mxranch_pg_' + slot;
  icons.insertAdjacentHTML('beforeend', buildProgressHeart(it.healthPct, hClip, hGrad));
  if (worldHudShowsProductIcon(it.animalType)) {
    const prodHtml = buildProgressProduct(it.productPct, it.animalType, pClip, pGrad);
    const prodWrap = document.createElement('div');
    prodWrap.innerHTML = prodHtml;
    const prodSvg = prodWrap.firstElementChild;
    if (prodSvg && Number(it.productPct) >= 100) {
      prodSvg.classList.add('world-animal-product-wrap--ready');
    }
    if (prodSvg) {
      icons.appendChild(prodSvg);
    } else {
      icons.insertAdjacentHTML('beforeend', prodHtml);
    }
  }
  if (it.needsVaccine) {
    icons.insertAdjacentHTML('beforeend', buildVaccineIcon('mxranch_vg_' + slot));
  }
  row.appendChild(icons);
  row.appendChild(main);
  card.replaceChildren(row);
}

function clearWorldAnimalHudPool() {
  worldAnimalHudPool.forEach((entry) => {
    if (entry.card && entry.card.parentNode) {
      entry.card.remove();
    }
  });
  worldAnimalHudPool.clear();
}

function setWorldAnimalHud(msg) {
  const hud = $('animalWorldHud');
  const root = $('animalWorldCards');
  if (!hud || !root) return;
  if (!msg || !msg.show || !Array.isArray(msg.items) || msg.items.length === 0) {
    clearWorldAnimalHudPool();
    hud.classList.add('hidden');
    hud.setAttribute('aria-hidden', 'true');
    return;
  }
  hud.classList.remove('hidden');
  hud.setAttribute('aria-hidden', 'false');
  const seen = new Set();
  msg.items.forEach((it, i) => {
    const id = String(it.animalId != null ? it.animalId : i);
    seen.add(id);
    let entry = worldAnimalHudPool.get(id);
    if (!entry) {
      const card = document.createElement('div');
      card.className = 'world-animal-card';
      card.dataset.animalId = id;
      entry = { card, statKey: '' };
      worldAnimalHudPool.set(id, entry);
      root.appendChild(card);
    }
    const lp = typeof it.leftPct === 'number' ? it.leftPct : 50;
    const tp = typeof it.topPct === 'number' ? it.topPct : 40;
    entry.card.style.left = `${lp}%`;
    entry.card.style.top = `${tp}%`;
    const statKey = worldAnimalHudStatKey(it);
    if (entry.statKey !== statKey) {
      entry.statKey = statKey;
      fillWorldAnimalCard(entry.card, it, id);
    }
  });
  for (const [id, entry] of worldAnimalHudPool) {
    if (!seen.has(id)) {
      entry.card.remove();
      worldAnimalHudPool.delete(id);
    }
  }
}

window.addEventListener('message', (ev) => {
  const msg = ev.data;
  if (!msg || !msg.action) return;
  if (msg.action === 'open') {
    $('animalWorldHud')?.classList.add('hidden');
    openUi(msg);
  }
  if (msg.action === 'openSellYard') {
    openSellYardUi(msg.data);
  }
  if (msg.action === 'closeSellYard') {
    closeSellYardUi(false);
  }
  if (msg.action === 'placementStarted') {
    showOverlay(false);
    $('animalWorldHud')?.classList.add('hidden');
  }
  if (msg.action === 'worldAnimalHud') {
    setWorldAnimalHud(msg);
  }
  if (msg.action === 'walkSession') {
    applyWalkSession(msg);
  }
  if (msg.action === 'walkHudUpdate') {
    updateWalkHud(msg.hud);
    applyWalkNearRanch(msg);
    if (Array.isArray(msg.animalIds) && !walkIdsEqual(state.walkActiveIds, msg.animalIds)) {
      state.walkActiveIds = normalizeWalkIds(msg.animalIds);
      renderAnimalList();
    }
  }
  if (msg.action === 'walkSessionEnd') {
    applyWalkSession({ active: false });
  }
});

function initBrowserPreview() {
  if (typeof GetParentResourceName === 'function') return;
  document.documentElement.classList.add('mx-ranch-preview');
}

document.addEventListener('DOMContentLoaded', async () => {
  if (typeof initRanchI18n === 'function') {
    await initRanchI18n();
  }
  initBrowserPreview();
  buildRanchDom();
  buildSellYardDom();
  wireRanchEvents();
  wireSellYardEvents();
  applyNuiImages();
});
