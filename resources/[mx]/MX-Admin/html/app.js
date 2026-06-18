/**
 * RSG Admin Menu — NUI dashboard
 */
(function () {
  'use strict';

  const ICON_MAP = {
    dashboard: 'i-dashboard',
    users: 'i-users',
    trash: 'i-trash',
    'user-cog': 'i-user-cog',
    flag: 'i-flag',
    crosshair: 'i-crosshair',
    messages: 'i-messages',
    settings: 'i-settings',
    logs: 'i-logs',
    ban: 'i-ban',
    search: 'i-search',
    refresh: 'i-refresh',
    online: 'i-online',
    offline: 'i-offline',
    total: 'i-total',
    key: 'i-key',
    'map-pin': 'i-map-pin',
    code: 'i-code',
    bolt: 'i-bolt',
    heart: 'i-heart',
    layers: 'i-layers',
    package: 'i-package',
    coins: 'i-coins',
    cash: 'i-cash',
    'eye-off': 'i-eye-off',
    'teleport-add': 'i-teleport-add',
    pencil: 'i-pencil',
    'announce-default': 'i-announce-default',
    'announce-info': 'i-announce-info',
    'announce-urgent': 'i-announce-urgent',
  };

  /** Itens: quantos mostrar por bloco (DOM leve). */
  const ITEMS_PAGE_SIZE = 48;

  /** Live map — tempos e limites (NUI). */
  const LIVEMAP_POLL_MS = 2500;
  const LIVEMAP_WHEEL_ZOOM_STEP = 1.06;
  const LIVEMAP_ZOOM_BTN_FACTOR = 1.2;
  const LIVEMAP_ZOOM_MIN = 1;
  const LIVEMAP_ZOOM_MAX = 4;
  const LIVEMAP_FRAME_RESIZE_THRESH_PX = 2;
  const LIVEMAP_WINDOW_RESIZE_DEBOUNCE_MS = 120;
  const LIVEMAP_PAN_DRAG_THRESHOLD_PX = 4;

  const state = {
    players: [],
    maxPlayers: 32,
    staffName: 'Admin',
    serverName: 'Server',
    staffRankLabel: '',
    staffRank: 0,
    allowedCommands: {},
    /** Visibilidade da sidebar conforme o servidor (`getMenuMeta.navVisibility`). */
    navVisibility: {},
    currentView: 'players',
    selectedPlayerId: null,
    /** Painel «Death report» visível no modal Player actions (toggle com Check death). */
    deathReportPanelOpen: false,
    kickTargetId: null,
    banTargetId: null,
    canEditPermissions: false,
    permissionPayload: null,
    staffAdminsList: [],
    reportsList: [],
    selectedReportId: null,
    reportDetailPayload: null,
    bansList: [],
    selectedBanId: null,
    lastReportDetailChatReportId: null,
    newReportToastTimer: null,
    dashboardCharts: { hourlyPeaks: null, reportsStatus: null, reportsTrend: null },
    adminChatMessages: [],
    adminChatById: {},
    adminChatUnread: 0,
    teleportPresets: [],
    teleportEditMode: false,
    weatherSyncPollTimer: null,
    coordsPollTimer: null,
    /** Primeira resposta weatherSyncState após abrir Definições: ainda não aplicámos seed aos inputs editáveis. */
    weatherSyncServerSeedApplied: false,
    /** Utilizador alterou algum campo do painel (evita repor valores ao chegar a 1.ª resposta atrasada). */
    weatherSyncFormTouched: false,
    menuConfig: {},
    liveMapBounds: null,
    livemapPollTimer: null,
    livemapPollBusy: false,
    livemapSelected: null,
    /** Elemento do marcador aberto (reposicionar popover após pan/zoom/resize). */
    livemapPopoverMarkerEl: null,
    livemapPanX: 0,
    livemapPanY: 0,
    livemapZoom: 1,
    permissionSearchQuery: '',
    /** Estados ligado/desligado sincronizados com o cliente (god, wall, etc.). */
    commandToggles: {},
    /** Timeout para esconder o anúncio global no ecrã. */
    screenAnnounceHideTimer: null,
    /** Catálogo de itens (getItems) + filtro de pesquisa na UI */
    itemsCatalog: [],
    itemsSearchQuery: '',
    itemsVisibleCount: ITEMS_PAGE_SIZE,
    itemsSearchDebounceTimer: null,
    /** Modal «Dar item» a partir das ações do jogador */
    giveItemTargetId: null,
    giveItemSearchQuery: '',
    giveItemVisibleCount: ITEMS_PAGE_SIZE,
    giveItemSearchDebounceTimer: null,
    weaponsCatalog: [],
    weaponsSearchQuery: '',
    weaponsVisibleCount: ITEMS_PAGE_SIZE,
    weaponsSearchDebounceTimer: null,
    setJobTargetId: null,
    financeTargetId: null,
    removeJobTargetId: null,
    jobsCatalog: null,
    dangerConfirmHandler: null,
    /** 'rsg' | 'vorp' — economia (bancos por cidade vs ouro/ROL). */
    framework: 'rsg',
  };

  /** Pan no mapa ao vivo: arrastar com o rato. */
  let livemapPanPointer = null;
  let livemapPanDidDrag = false;
  /** Evita reflow / clamp em picos de ResizeObserver (subpixel, scrollbar). */
  let livemapLastFrameLayoutW = -1;
  let livemapLastFrameLayoutH = -1;
  let livemapResizeObserverRaf = null;
  let livemapPanelWired = false;
  let livemapResizeObserver = null;
  let livemapWindowResizeTimer = null;
  /** Cache de getElementById do live map (evita dezenas de lookups por frame ao panar/zoom). */
  let livemapDomCache = null;
  let livemapPanMoveRaf = null;
  let livemapPanMovePendingEvent = null;

  /** Tipos de clima RDR2 (weathersync/shared RDR2WeatherTypes). */
  const WEATHER_TYPES_RDR3 = [
    'blizzard',
    'clouds',
    'drizzle',
    'fog',
    'groundblizzard',
    'hail',
    'highpressure',
    'hurricane',
    'misty',
    'overcast',
    'overcastdark',
    'rain',
    'sandstorm',
    'shower',
    'sleet',
    'snow',
    'snowlight',
    'sunny',
    'thunder',
    'thunderstorm',
    'whiteout',
  ];

  const WS_DOW_EN = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];

  const prUi = {
    open: false,
    cooldownUntil: 0,
    cooldownSec: 60,
    serverName: 'Server',
    selectedType: null,
    currentDetailId: null,
    cooldownTimer: null,
    lastDetailChatReportId: null,
  };

  function getResourceName() {
    if (typeof GetParentResourceName === 'function') {
      return GetParentResourceName();
    }
    return 'rsg-adminmenu';
  }

  /** Ficheiros em html/ (ex. teleports/x.png): o CEF do jogo não resolve bem caminhos relativos; usar cfx-nui. */
  function nuiHtmlAssetUrl(relativePath) {
    if (!relativePath || typeof relativePath !== 'string') return '';
    const t = relativePath.trim();
    if (/^https?:\/\//i.test(t)) return t;
    const clean = t.replace(/^\.+\//, '').replace(/^\/+/, '');
    return 'https://cfx-nui-' + getResourceName() + '/html/' + clean;
  }

  function cleanCatalogImagePath(value) {
    if (value == null) return '';
    return String(value).trim().replace(/\\/g, '/').replace(/^@+/, '');
  }

  function catalogImageFileName(primary, fallbackName) {
    let source = cleanCatalogImagePath(primary);
    if (!source && fallbackName) source = cleanCatalogImagePath(fallbackName);
    if (!source) return '';
    source = source.split(/[?#]/)[0].replace(/^nui:\/\/[^/]+\//i, '').replace(/^https:\/\/cfx-nui-[^/]+\//i, '');
    const slash = source.lastIndexOf('/');
    let file = slash >= 0 ? source.slice(slash + 1) : source;
    file = file.trim();
    if (!file) return '';
    if (!/\.(png|jpe?g|webp|gif|svg)$/i.test(file)) file += '.png';
    return file;
  }

  function pushUniqueImageUrl(list, seen, url) {
    if (!url) return;
    const clean = String(url).trim().replace(/ /g, '%20');
    if (!clean || seen[clean]) return;
    seen[clean] = true;
    list.push(clean);
  }

  function addCatalogResourceCandidates(list, seen, resource, basePath, file) {
    if (!file) return;
    const variants = [file];
    const lower = file.toLowerCase();
    if (lower !== file) variants.push(lower);
    variants.forEach(function (name) {
      pushUniqueImageUrl(list, seen, 'https://cfx-nui-' + resource + '/' + basePath + '/' + name);
      pushUniqueImageUrl(list, seen, 'nui://' + resource + '/' + basePath + '/' + name);
    });
  }

  function getCatalogImageCandidates(entry, kind) {
    const out = [];
    const seen = {};
    const raw = cleanCatalogImagePath(entry && entry.image);
    const file = catalogImageFileName(raw, entry && entry.name);
    const nameFile = catalogImageFileName(entry && entry.name, '');

    if (/^(https?:\/\/|data:|blob:|nui:\/\/)/i.test(raw) && !/rsg-inventory/i.test(raw)) {
      pushUniqueImageUrl(out, seen, raw);
    }

    if (kind === 'weapon') {
      addCatalogResourceCandidates(out, seen, 'v-hud', 'html/img/weapons', file);
      addCatalogResourceCandidates(out, seen, 'v-hud', 'html/img/weapons', nameFile);
    }

    addCatalogResourceCandidates(out, seen, 'v-inventory', 'web/dist/items', file);
    addCatalogResourceCandidates(out, seen, 'v-inventory', 'web/dist/items/items', file);
    addCatalogResourceCandidates(out, seen, 'v-inventory', 'web/dist/items', nameFile);
    addCatalogResourceCandidates(out, seen, 'v-inventory', 'web/dist/items/items', nameFile);

    if (raw && !/^(https?:\/\/|data:|blob:|nui:\/\/)/i.test(raw)) {
      pushUniqueImageUrl(out, seen, raw);
    }

    return out;
  }

  function attachCatalogCardImage(fig, img, entry, kind) {
    const candidates = getCatalogImageCandidates(entry, kind);
    let idx = 0;

    function showFallback() {
      fig.classList.add('adm-item-card__media--fallback');
      if (img.parentNode) img.remove();
      if (!fig.querySelector('.adm-item-card__ph')) {
        const ph = document.createElement('span');
        ph.className = 'adm-item-card__ph';
        ph.textContent = ((entry && (entry.label || entry.name)) || '?').charAt(0).toUpperCase();
        fig.appendChild(ph);
      }
    }

    function tryNext() {
      if (idx >= candidates.length) {
        showFallback();
        return;
      }
      img.src = candidates[idx++];
    }

    img.addEventListener('error', tryNext);
    if (candidates.length > 0) {
      tryNext();
    } else {
      showFallback();
    }
  }

  function applySidebarBranding(payload) {
    const wrap = document.getElementById('adm-sidebar-logo-wrap');
    const img = document.getElementById('adm-sidebar-logo-img');
    const titleEl = document.getElementById('adm-sidebar-title');
    const subEl = document.getElementById('adm-server-name');
    const hostName = payload && payload.serverName ? payload.serverName : 'Server';
    const guildName =
      payload && payload.discordGuildName && String(payload.discordGuildName).trim()
        ? String(payload.discordGuildName).trim()
        : '';
    const iconUrl =
      payload && payload.discordGuildIconUrl && String(payload.discordGuildIconUrl).trim()
        ? String(payload.discordGuildIconUrl).trim()
        : '';
    if (titleEl) {
      titleEl.textContent = guildName || 'Admin';
    }
    if (subEl) {
      subEl.textContent = hostName;
    }
    if (!wrap || !img) return;
    wrap.classList.remove('adm-sidebar__logo-wrap--has-icon');
    img.classList.add('adm-view--hidden');
    img.onload = null;
    img.onerror = null;
    img.removeAttribute('src');
    if (iconUrl) {
      img.onload = function () {
        img.classList.remove('adm-view--hidden');
        wrap.classList.add('adm-sidebar__logo-wrap--has-icon');
      };
      img.onerror = function () {
        img.classList.add('adm-view--hidden');
        wrap.classList.remove('adm-sidebar__logo-wrap--has-icon');
      };
      img.src = iconUrl;
    }
  }

  async function postNui(eventName, data) {
    try {
      const res = await fetch(`https://${getResourceName()}/${eventName}`, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json; charset=UTF-8' },
        body: JSON.stringify(data ?? {}),
      });
      if (!res || !res.ok) {
        return {};
      }
      try {
        return await res.json();
      } catch {
        return {};
      }
    } catch {
      /* Fora do jogo / NUI indisponível: fetch falha com «Failed to fetch». */
      return {};
    }
  }

  /** Notificação ox_lib no jogo (evita window.alert do CEF). */
  async function notifyGame(title, description, type, duration) {
    await postNui('notify', {
      title: title || 'Admin',
      description: description || '',
      type: type || 'inform',
      duration: duration,
    });
  }

  /** Confirmação ox_lib no jogo (evita window.confirm). */
  async function confirmGame(title, message) {
    const res = await postNui('confirmDialog', {
      title: title || 'Confirm',
      message: message || '',
    });
    return !!(res && res.ok);
  }

  function formatDurationSeconds(totalSec) {
    const s = Math.max(0, Math.floor(Number(totalSec) || 0));
    const d = Math.floor(s / 86400);
    const h = Math.floor((s % 86400) / 3600);
    const m = Math.floor((s % 3600) / 60);
    const parts = [];
    if (d > 0) parts.push(d + 'd');
    if (h > 0 || d > 0) parts.push(h + 'h');
    parts.push(m + 'm');
    return parts.join(' ');
  }

  function buildLast7DaysSeries(trend) {
    const map = {};
    (trend || []).forEach(function (row) {
      const k = String(row.date || '').slice(0, 10);
      if (k) map[k] = Number(row.count) || 0;
    });
    const labels = [];
    const data = [];
    for (let i = 6; i >= 0; i--) {
      const d = new Date();
      d.setHours(12, 0, 0, 0);
      d.setDate(d.getDate() - i);
      const y = d.getFullYear();
      const mo = String(d.getMonth() + 1).padStart(2, '0');
      const day = String(d.getDate()).padStart(2, '0');
      const key = y + '-' + mo + '-' + day;
      labels.push(
        d.toLocaleDateString('en-US', { weekday: 'short', day: 'numeric', month: 'short' })
      );
      data.push(map[key] != null ? map[key] : 0);
    }
    return { labels: labels, data: data };
  }

  function destroyDashboardCharts() {
    ['hourlyPeaks', 'reportsStatus', 'reportsTrend'].forEach(function (key) {
      const c = state.dashboardCharts[key];
      if (c && typeof c.destroy === 'function') {
        c.destroy();
      }
      state.dashboardCharts[key] = null;
    });
  }

  async function loadDashboard() {
    destroyDashboardCharts();
    const errEl = document.getElementById('adm-dashboard-error');
    if (errEl) {
      errEl.classList.add('adm-view--hidden');
      errEl.textContent = '';
    }

    const raw = await postNui('getDashboardStats', {});
    if (!raw || raw.ok === false) {
      if (errEl) {
        errEl.textContent = 'Could not load statistics.';
        errEl.classList.remove('adm-view--hidden');
      }
      return;
    }

    const chartOk = typeof Chart !== 'undefined';
    if (!chartOk && errEl) {
      errEl.textContent =
        'Charts unavailable (Chart.js failed to load). Top numbers still update.';
      errEl.classList.remove('adm-view--hidden');
    }

    const onlineHint = document.getElementById('adm-dash-stat-online-hint');
    if (onlineHint) {
      onlineHint.textContent =
        raw.maxPlayers != null ? 'max ' + raw.maxPlayers + ' slots' : '';
    }
    const elOn = document.getElementById('adm-dash-stat-online');
    if (elOn) elOn.textContent = String(raw.online ?? 0) + ' / ' + String(raw.maxPlayers ?? '—');
    const elPing = document.getElementById('adm-dash-stat-ping');
    if (elPing) elPing.textContent = String(raw.pingAvg ?? 0);
    const elUp = document.getElementById('adm-dash-stat-uptime');
    if (elUp) elUp.textContent = formatDurationSeconds(raw.uptimeSeconds);

    const locked = document.getElementById('adm-dashboard-reports-locked');
    const cardStatus = document.getElementById('adm-chart-card-reports-status');
    const cardTrend = document.getElementById('adm-chart-card-reports-trend');
    const elRep = document.getElementById('adm-dash-stat-reports');
    const hasRep = raw.hasReportStats === true;

    if (hasRep) {
      if (locked) locked.classList.add('adm-view--hidden');
      if (cardStatus) cardStatus.classList.remove('adm-view--hidden');
      if (cardTrend) cardTrend.classList.remove('adm-view--hidden');
      const rs = raw.reportsByStatus || {};
      if (elRep) elRep.textContent = String(rs.open != null ? rs.open : 0);
    } else {
      if (locked) locked.classList.remove('adm-view--hidden');
      if (cardStatus) cardStatus.classList.add('adm-view--hidden');
      if (cardTrend) cardTrend.classList.add('adm-view--hidden');
      if (elRep) elRep.textContent = '—';
    }

    const elGlobalPeak = document.getElementById('adm-dash-global-peak');
    if (elGlobalPeak) {
      const peak = raw.peakOnline != null ? Number(raw.peakOnline) : 0;
      elGlobalPeak.textContent = 'Global peak ' + peak + ' pl.';
    }

    if (chartOk) {
    const hourly = raw.hourlyPeaks24 || [];
    const hLabels = hourly.map(function (row) {
      return row.label || '';
    });
    const hData = hourly.map(function (row) {
      return Number(row.peak) || 0;
    });
    const maxSlots = raw.maxPlayers != null ? Number(raw.maxPlayers) : 64;
    let dataMax = 0;
    hData.forEach(function (v) {
      if (v > dataMax) dataMax = v;
    });
    const ySuggestedMax = Math.min(maxSlots, Math.max(4, Math.ceil(dataMax * 1.25 + 0.99)));

    const ctxH = document.getElementById('adm-chart-hourly-peaks');
    if (ctxH) {
      state.dashboardCharts.hourlyPeaks = new Chart(ctxH, {
        type: 'bar',
        data: {
          labels: hLabels.length ? hLabels : ['—'],
          datasets: [
            {
              label: 'Peak',
              data: hData.length ? hData : [0],
              borderWidth: 0,
              borderRadius: { topLeft: 8, topRight: 8, bottomLeft: 0, bottomRight: 0 },
              borderSkipped: false,
              maxBarThickness: 14,
              backgroundColor: function (context) {
                const chart = context.chart;
                const { ctx: c2, chartArea } = chart;
                if (!chartArea) {
                  return 'rgba(253, 227, 177, 0.75)';
                }
                const g = c2.createLinearGradient(0, chartArea.bottom, 0, chartArea.top);
                g.addColorStop(0, 'rgba(180, 145, 90, 0.55)');
                g.addColorStop(0.5, 'rgba(253, 227, 177, 0.82)');
                g.addColorStop(1, 'rgba(255, 240, 210, 0.95)');
                return g;
              },
            },
          ],
        },
        options: {
          responsive: true,
          maintainAspectRatio: false,
          animation: {
            duration: 520,
            easing: 'easeOutQuart',
          },
          interaction: { mode: 'index', intersect: false },
          plugins: {
            legend: { display: false },
            tooltip: {
              backgroundColor: 'rgba(22, 26, 34, 0.96)',
              titleColor: '#fde3b1',
              bodyColor: '#e8eaef',
              borderColor: 'rgba(253, 227, 177, 0.25)',
              borderWidth: 1,
              padding: 12,
              cornerRadius: 10,
              displayColors: false,
              callbacks: {
                title: function (items) {
                  const i = items[0] && items[0].dataIndex;
                  return i != null && hourly[i] ? hourly[i].label : '';
                },
                label: function (ctx) {
                  const n = ctx.parsed.y;
                  return n === 1 ? 'Peak: 1 player' : 'Peak: ' + n + ' players';
                },
              },
            },
          },
          scales: {
            x: {
              grid: { display: false },
              ticks: {
                color: 'rgba(203, 213, 225, 0.78)',
                maxRotation: 50,
                minRotation: 0,
                autoSkip: true,
                maxTicksLimit: 24,
                font: { size: 10, weight: '500' },
              },
            },
            y: {
              beginAtZero: true,
              suggestedMax: ySuggestedMax,
              border: { display: false },
              grid: {
                color: 'rgba(255, 255, 255, 0.08)',
                lineWidth: 1,
                drawTicks: false,
              },
              ticks: {
                color: 'rgba(203, 213, 225, 0.78)',
                precision: 0,
                padding: 8,
                font: { size: 10 },
                callback: function (val) {
                  return Number.isInteger(val) ? val : '';
                },
              },
            },
          },
        },
      });
    }

    if (hasRep) {
      const st = raw.reportsByStatus || {};
      const ctxS = document.getElementById('adm-chart-reports-status');
      if (ctxS) {
        state.dashboardCharts.reportsStatus = new Chart(ctxS, {
          type: 'doughnut',
          data: {
            labels: ['Open', 'Claimed', 'Resolved', 'Closed'],
            datasets: [
              {
                data: [st.open || 0, st.claimed || 0, st.resolved || 0, st.closed || 0],
                backgroundColor: [
                  'rgba(253, 227, 177, 0.88)',
                  'rgba(212, 175, 95, 0.88)',
                  'rgba(94, 184, 138, 0.88)',
                  'rgba(148, 163, 184, 0.75)',
                ],
                borderWidth: 2,
                borderColor: 'rgba(15, 17, 21, 0.85)',
              },
            ],
          },
          options: {
            responsive: true,
            maintainAspectRatio: false,
            plugins: {
              legend: {
                position: 'bottom',
                labels: {
                  color: 'rgba(226, 232, 240, 0.9)',
                  boxWidth: 12,
                  padding: 12,
                  font: { size: 11 },
                },
              },
            },
          },
        });
      }

      const series = buildLast7DaysSeries(raw.reportsTrend);
      const ctxT = document.getElementById('adm-chart-reports-trend');
      if (ctxT) {
        state.dashboardCharts.reportsTrend = new Chart(ctxT, {
          type: 'line',
          data: {
            labels: series.labels,
            datasets: [
              {
                label: 'New reports',
                data: series.data,
                fill: true,
                backgroundColor: 'rgba(253, 227, 177, 0.12)',
                borderColor: 'rgba(253, 227, 177, 0.9)',
                tension: 0.35,
                pointRadius: 3,
                pointBackgroundColor: '#fde3b1',
                pointBorderColor: 'rgba(15, 17, 21, 0.9)',
                pointBorderWidth: 1,
              },
            ],
          },
          options: {
            responsive: true,
            maintainAspectRatio: false,
            plugins: { legend: { display: false } },
            scales: {
              x: {
                grid: { color: 'rgba(255, 255, 255, 0.07)' },
                ticks: { color: 'rgba(203, 213, 225, 0.78)', maxRotation: 40 },
              },
              y: {
                beginAtZero: true,
                grid: { color: 'rgba(255, 255, 255, 0.07)' },
                ticks: { color: 'rgba(203, 213, 225, 0.78)', precision: 0 },
              },
            },
          },
        });
      }
    }
    }

    const dash = document.getElementById('view-dashboard');
    if (dash) injectIcons(dash);
  }

  function injectIcons(root) {
    const scope = root || document;
    scope.querySelectorAll('[data-icon]').forEach(function (el) {
      const key = el.getAttribute('data-icon');
      const id = ICON_MAP[key];
      if (!id) return;
      el.innerHTML = '';
      const svg = document.createElementNS('http://www.w3.org/2000/svg', 'svg');
      var announceIcon = el.id === 'adm-screen-announce-title-icon';
      var px = announceIcon ? '56' : '20';
      svg.setAttribute('width', px);
      svg.setAttribute('height', px);
      svg.setAttribute('viewBox', '0 0 24 24');
      const use = document.createElementNS('http://www.w3.org/2000/svg', 'use');
      use.setAttribute('href', '#' + id);
      use.setAttributeNS('http://www.w3.org/1999/xlink', 'href', '#' + id);
      svg.appendChild(use);
      el.appendChild(svg);
    });
  }

  function formatMoney(n) {
    const v = Number(n) || 0;
    return '$' + v.toLocaleString('en-US');
  }

  function jobBadgeClass(jobName) {
    const j = (jobName || '').toLowerCase();
    if (j.includes('sheriff') || j.includes('law') || j.includes('police') || j.includes('marshal')) {
      return 'adm-badge adm-badge--sheriff';
    }
    if (j.includes('outlaw') || j.includes('outlaws') || j.includes('criminal')) {
      return 'adm-badge adm-badge--outlaw';
    }
    if (j.includes('bounty')) {
      return 'adm-badge adm-badge--bounty';
    }
    return 'adm-badge adm-badge--default';
  }

  function buildPlayerModalMetaHtml(p, info) {
    info = info || {};
    let jobLabel = '';
    let gradeDisplay = '';
    if (info && !info.error) {
      jobLabel = (info.job && String(info.job).trim()) || '';
      gradeDisplay =
        info.gradeName != null && String(info.gradeName).trim() !== ''
          ? String(info.gradeName).trim()
          : '';
    } else if (p) {
      jobLabel = (p.jobLabel && String(p.jobLabel).trim()) || '';
      gradeDisplay =
        p.jobGradeName != null && String(p.jobGradeName).trim() !== ''
          ? String(p.jobGradeName).trim()
          : '';
    }
    let jobLine = '—';
    if (jobLabel && gradeDisplay) {
      jobLine = escapeHtml(jobLabel) + ' · ' + escapeHtml(gradeDisplay);
    } else if (jobLabel) {
      jobLine = escapeHtml(jobLabel);
    } else if (gradeDisplay) {
      jobLine = escapeHtml(gradeDisplay);
    }
    const discordId = (info && info.discordId) || (p && p.discordId);
    const discordLine = discordId ? 'Discord · ' + String(discordId) : 'Discord · —';
    return (
      '<div class="adm-modal__meta-inner">' +
      '<div class="adm-modal__meta-line">' +
      escapeHtml(discordLine) +
      '</div>' +
      '<div class="adm-modal__meta-line adm-modal__meta-line--job">' +
      jobLine +
      '</div>' +
      '</div>'
    );
  }

  function walletFieldRow(label, val) {
    const n = val != null && val !== '' ? Number(val) : 0;
    const safe = isFinite(n) ? n : 0;
    return (
      '<div class="adm-player-profile__field">' +
      '<span class="adm-player-profile__field-label">' +
      escapeHtml(label) +
      '</span>' +
      '<span class="adm-player-profile__field-value adm-player-profile__field-value--accent">' +
      escapeHtml(formatMoney(safe)) +
      '</span></div>'
    );
  }

  function buildPlayerProfileCardHtml(p, info, playerId) {
    info = info || {};
    const charName = p
      ? (p.charName || '').trim() || (p.name || '').split('|')[0].trim()
      : 'Player';
    let fullName = charName;
    if ((info.firstname || info.lastname) && !info.error) {
      const joined = [info.firstname || '', info.lastname || ''].join(' ').trim();
      if (joined) fullName = joined;
    }
    const initials = charName
      .split(' ')
      .map(function (s) {
        return s[0];
      })
      .join('')
      .slice(0, 2)
      .toUpperCase() || '?';
    const avatarUrl = (info && info.avatarUrl) || (p && p.avatarUrl);

    const hasErr = info.error;
    let warnHtml = '';
    if (hasErr === 'offline' || hasErr === 'not_found') {
      warnHtml =
        '<p class="adm-player-profile__warn">Could not load live data (offline or invalid).</p>';
    } else if (hasErr === 'bad_id') {
      warnHtml = '<p class="adm-player-profile__warn">Invalid ID.</p>';
    }

    const cashVal =
      info && !info.error && info.cash != null ? info.cash : p && p.cash != null ? p.cash : null;

    let jobLabel = '';
    let gradeDisplay = '';
    if (info && !info.error) {
      jobLabel = (info.job && String(info.job).trim()) || '';
      gradeDisplay =
        info.gradeName != null && String(info.gradeName).trim() !== ''
          ? String(info.gradeName).trim()
          : '';
    } else if (p) {
      jobLabel = (p.jobLabel && String(p.jobLabel).trim()) || '';
      gradeDisplay =
        p.jobGradeName != null && String(p.jobGradeName).trim() !== ''
          ? String(p.jobGradeName).trim()
          : '';
    }
    const pillJob = jobLabel || '—';
    const pillGrade = gradeDisplay || '—';

    const citizenId = (info && info.citizenid) || (p && p.citizenid);
    const citizenDisplay = citizenId ? String(citizenId) : '—';
    const discordId = (info && info.discordId) || (p && p.discordId);
    const discordDisplay = discordId ? String(discordId) : '—';

    const walletsCardOpen =
      '<div class="adm-player-profile__card adm-player-profile__card--wallets">' +
      '<p class="adm-player-profile__section-label">Wallets</p>';
    let walletsHtml = '';
    const vorpFx = info.framework === 'vorp' || state.framework === 'vorp';
    if (info && !info.error) {
      if (vorpFx) {
        walletsHtml =
          walletsCardOpen +
          walletFieldRow('Dollars (hand)', info.cash) +
          walletFieldRow('Ouro (gold)', info.bank) +
          walletFieldRow('Valentine', info.valbank) +
          walletFieldRow('Rhodes', info.rhobank) +
          walletFieldRow('Blackwater', info.blkbank) +
          walletFieldRow('Armadillo', info.armbank) +
          walletFieldRow('ROL', info.bloodmoney) +
          '</div>';
      } else {
        walletsHtml =
          walletsCardOpen +
          walletFieldRow('Hand', info.cash) +
          walletFieldRow('Banco', info.bank) +
          walletFieldRow('Valentine', info.valbank) +
          walletFieldRow('Rhodes', info.rhobank) +
          walletFieldRow('Blackwater', info.blkbank) +
          walletFieldRow('Armadillo', info.armbank) +
          walletFieldRow('Blood money', info.bloodmoney) +
          '</div>';
      }
    } else {
      if (vorpFx) {
        walletsHtml =
          walletsCardOpen +
          walletFieldRow('Dollars (hand)', cashVal != null ? cashVal : 0) +
          walletFieldRow('Ouro (gold)', 0) +
          walletFieldRow('Valentine', 0) +
          walletFieldRow('Rhodes', 0) +
          walletFieldRow('Blackwater', 0) +
          walletFieldRow('Armadillo', 0) +
          walletFieldRow('ROL', 0) +
          '</div>';
      } else {
        walletsHtml =
          walletsCardOpen +
          walletFieldRow('Hand', cashVal != null ? cashVal : 0) +
          walletFieldRow('Banco', 0) +
          walletFieldRow('Valentine', 0) +
          walletFieldRow('Rhodes', 0) +
          walletFieldRow('Blackwater', 0) +
          walletFieldRow('Armadillo', 0) +
          walletFieldRow('Blood money', 0) +
          '</div>';
      }
    }

    const avatarBlock = avatarUrl
      ? '<img class="adm-player-profile__avatar" src="' +
        escapeAttr(avatarUrl) +
        '" alt="" loading="lazy" />'
      : '<div class="adm-player-profile__ph" aria-hidden="true">' + escapeHtml(initials) + '</div>';

    const sid = playerId != null ? String(playerId) : '—';

    return (
      '<section class="adm-player-profile adm-player-profile--aside" aria-label="Player profile">' +
      '<div class="adm-player-profile__identity">' +
      '<div class="adm-player-profile__avatar-wrap">' +
      avatarBlock +
      '</div>' +
      '<div class="adm-player-profile__id-block">' +
      '<h2 class="adm-player-profile__name">' +
      escapeHtml(fullName) +
      '</h2>' +
      '<p class="adm-player-profile__server-id">Server · ' +
      escapeHtml(sid) +
      '</p>' +
      '</div></div>' +
      '<div class="adm-player-profile__card adm-player-profile__card--player-meta">' +
      '<div class="adm-player-profile__field">' +
      '<span class="adm-player-profile__field-label">Player ID</span>' +
      '<span class="adm-player-profile__field-value adm-player-profile__field-value--accent">' +
      escapeHtml(citizenDisplay) +
      '</span></div>' +
      '<div class="adm-player-profile__field">' +
      '<span class="adm-player-profile__field-label">Discord</span>' +
      '<span class="adm-player-profile__field-value adm-player-profile__field-value--accent">' +
      escapeHtml(discordDisplay) +
      '</span></div>' +
      '<div class="adm-player-profile__field adm-player-profile__field--status">' +
      '<span class="adm-player-profile__field-label">Player status</span>' +
      '<div class="adm-player-profile__pills">' +
      '<span class="adm-player-pill adm-player-pill--job">' +
      escapeHtml(pillJob) +
      '</span>' +
      '<span class="adm-player-pill adm-player-pill--grade">' +
      escapeHtml(pillGrade) +
      '</span>' +
      '</div></div></div>' +
      walletsHtml +
      warnHtml +
      '</section>'
    );
  }

  /**
   * Formata o texto do «Check death» para o alertDialog do ox_lib: narrativa + lista com marcas.
   */
  function formatDeathCheckDialogContent(res) {
    var msg = (res && res.message && String(res.message).trim()) || '';
    if (!msg) {
      var h = res.headline ? String(res.headline).trim() : '';
      var db = res.detailBody ? String(res.detailBody).trim() : '';
      msg = h && db ? h + '\n\n' + db : h || db || '';
    }
    var chunks = msg.split(/\n\n+/);
    if (chunks.length < 2) {
      return msg;
    }
    var intro = chunks[0].trim();
    var rest = chunks.slice(1).join('\n\n').trim();
    var firstLine = (rest.split(/\r?\n/)[0] || '').trim();
    if (!/^details?:/i.test(firstLine) && !/^detalhes:/i.test(firstLine)) {
      return msg;
    }
    var lines = rest.split(/\r?\n/);
    var out = [intro, '', lines[0]];
    for (var i = 1; i < lines.length; i++) {
      var L = String(lines[i]).trim();
      if (L) {
        out.push('  · ' + L);
      }
    }
    return out.join('\n');
  }

  function deathReportAsideHtml() {
    return (
      '<aside class="adm-player-modal-split__death adm-player-modal-split__death--hidden" id="adm-death-report-aside" aria-label="Death report">' +
      '<div class="adm-death-report">' +
      '<h4 class="adm-death-report__title">Death report</h4>' +
      '<p class="adm-death-report__hint" id="adm-death-report-hint">Click «Check death» to load the last known cause.</p>' +
      '<div class="adm-death-report__body" id="adm-death-report-body" hidden>' +
      '<p class="adm-death-report__lead" id="adm-death-report-lead"></p>' +
      '<pre class="adm-death-report__details" id="adm-death-report-details"></pre>' +
      '</div>' +
      '<p class="adm-death-report__err" id="adm-death-report-err" role="alert" hidden></p>' +
      '</div></aside>'
    );
  }

  function resetDeathReportPanel() {
    var hint = document.getElementById('adm-death-report-hint');
    var bodyEl = document.getElementById('adm-death-report-body');
    var err = document.getElementById('adm-death-report-err');
    var lead = document.getElementById('adm-death-report-lead');
    var det = document.getElementById('adm-death-report-details');
    var aside = document.getElementById('adm-death-report-aside');
    if (hint) {
      hint.hidden = false;
      hint.textContent = 'Click «Check death» to load the last known cause.';
    }
    if (bodyEl) {
      bodyEl.hidden = true;
    }
    if (err) {
      err.hidden = true;
      err.textContent = '';
    }
    if (lead) {
      lead.textContent = '';
    }
    if (det) {
      det.textContent = '';
      det.hidden = false;
    }
    if (aside) {
      aside.classList.remove('adm-death-report-aside--partial');
    }
  }

  function syncCheckDeathTileActive(active) {
    var btn = document.querySelector('.adm-player-quick-tile[data-pa-action="checkPlayerDeath"]');
    if (!btn) {
      return;
    }
    var lab = btn.querySelector('.adm-player-quick-tile__label');
    if (active) {
      btn.classList.add('adm-player-quick-tile--death-open');
      if (lab) {
        lab.textContent = 'Hide report';
      }
    } else {
      btn.classList.remove('adm-player-quick-tile--death-open');
      if (lab) {
        lab.textContent = 'Check death';
      }
    }
  }

  function getPlayerActionsModalShell() {
    var ov = document.getElementById('adm-modal-overlay');
    if (!ov) {
      return null;
    }
    return ov.querySelector('.adm-modal.adm-modal--player-actions');
  }

  function syncPlayerActionsModalDeathClass() {
    var modal = getPlayerActionsModalShell();
    if (!modal) {
      return;
    }
    if (state.deathReportPanelOpen) {
      modal.classList.add('adm-modal--death-report-open');
    } else {
      modal.classList.remove('adm-modal--death-report-open');
    }
  }

  function hideDeathReportAside() {
    state.deathReportPanelOpen = false;
    var root = document.getElementById('adm-player-split-root');
    var aside = document.getElementById('adm-death-report-aside');
    if (root) {
      root.classList.remove('adm-player-modal-split--death-open');
    }
    if (aside) {
      aside.classList.add('adm-player-modal-split__death--hidden');
    }
    syncCheckDeathTileActive(false);
    syncPlayerActionsModalDeathClass();
  }

  function showDeathReportAside() {
    state.deathReportPanelOpen = true;
    var root = document.getElementById('adm-player-split-root');
    var aside = document.getElementById('adm-death-report-aside');
    if (root) {
      root.classList.add('adm-player-modal-split--death-open');
    }
    if (aside) {
      aside.classList.remove('adm-player-modal-split__death--hidden');
    }
    syncCheckDeathTileActive(true);
    syncPlayerActionsModalDeathClass();
  }

  function setDeathReportPanelLoading() {
    var hint = document.getElementById('adm-death-report-hint');
    var bodyEl = document.getElementById('adm-death-report-body');
    var err = document.getElementById('adm-death-report-err');
    if (hint) {
      hint.hidden = false;
      hint.textContent = 'Loading…';
    }
    if (bodyEl) {
      bodyEl.hidden = true;
    }
    if (err) {
      err.hidden = true;
      err.textContent = '';
    }
  }

  function fillDeathReportPanelSuccess(res) {
    var hint = document.getElementById('adm-death-report-hint');
    var bodyEl = document.getElementById('adm-death-report-body');
    var err = document.getElementById('adm-death-report-err');
    var lead = document.getElementById('adm-death-report-lead');
    var det = document.getElementById('adm-death-report-details');
    var aside = document.getElementById('adm-death-report-aside');
    if (!bodyEl || !det || !lead) {
      return;
    }
    if (hint) {
      hint.hidden = true;
    }
    if (err) {
      err.hidden = true;
      err.textContent = '';
    }
    bodyEl.hidden = false;
    lead.textContent = (res.headline && String(res.headline).trim()) || '—';
    var db = res.detailBody != null ? String(res.detailBody).trim() : '';
    if (!db) {
      det.hidden = true;
      det.textContent = '';
    } else {
      det.hidden = false;
      det.textContent = db || formatDeathCheckDialogContent(res) || '';
    }
    if (aside) {
      if (res.partial) {
        aside.classList.add('adm-death-report-aside--partial');
      } else {
        aside.classList.remove('adm-death-report-aside--partial');
      }
    }
  }

  function fillDeathReportPanelError(msg) {
    var hint = document.getElementById('adm-death-report-hint');
    var bodyEl = document.getElementById('adm-death-report-body');
    var err = document.getElementById('adm-death-report-err');
    var aside = document.getElementById('adm-death-report-aside');
    if (hint) {
      hint.hidden = true;
    }
    if (bodyEl) {
      bodyEl.hidden = true;
    }
    if (err) {
      err.hidden = false;
      err.textContent = msg || 'Error';
    }
    if (aside) {
      aside.classList.remove('adm-death-report-aside--partial');
    }
  }

  function execPlayerAdminAction(def, playerId, p, info) {
    if (!def) return;
    if (def.action === 'openFinanceModal') {
      openFinanceModal(playerId, p);
      return;
    }
    if (def.action === 'giveItemPicker') {
      document.getElementById('adm-modal-overlay').classList.add('adm-modal-overlay--hidden');
      openGiveItemToPlayerModal(playerId, p);
      return;
    }
    if (def.action === 'setJobPrompt') {
      openSetJobModal(playerId, p);
      return;
    }
    if (def.action === 'removeJobPrompt') {
      openRemoveJobModal(playerId, p);
      return;
    }
    if (def.action === 'clearInvPrompt') {
      openDangerConfirm({
        title: 'Clear inventory',
        text: "This removes all items from the player's inventory. This cannot be undone.",
        onConfirm: function () {
          postNui('action', { action: 'clearPlayerInventory', playerId: playerId }).then(function () {
            refreshPlayers();
            openActionModal(playerId);
          });
        },
      });
      return;
    }
    if (def.action === 'killPlayer') {
      openDangerConfirm({
        title: 'Kill player',
        text: "This kills the player's character in the world. Continue?",
        onConfirm: function () {
          postNui('action', { action: 'killPlayer', playerId: playerId }).then(function () {
            refreshPlayers();
            openActionModal(playerId);
          });
        },
      });
      return;
    }
    if (def.action === 'checkPlayerDeath') {
      if (state.deathReportPanelOpen) {
        hideDeathReportAside();
        return;
      }
      showDeathReportAside();
      setDeathReportPanelLoading();
      postNui('checkPlayerDeath', { playerId: playerId })
        .then(function (res) {
          if (res && res.ok === true && res.message) {
            fillDeathReportPanelSuccess(res);
            return;
          }
          fillDeathReportPanelError((res && res.message) || (res && res.error) || 'Request failed.');
        })
        .catch(function () {
          fillDeathReportPanelError('Could not reach the game client.');
        });
      return;
    }
    if (def.action === 'kickPrompt') {
      document.getElementById('adm-modal-overlay').classList.add('adm-modal-overlay--hidden');
      state.kickTargetId = playerId;
      document.getElementById('adm-kick-reason').value = '';
      document.getElementById('adm-kick-overlay').classList.remove('adm-modal-overlay--hidden');
      return;
    }
    if (def.action === 'banPrompt') {
      document.getElementById('adm-modal-overlay').classList.add('adm-modal-overlay--hidden');
      state.banTargetId = playerId;
      document.getElementById('adm-ban-reason').value = '';
      document.getElementById('adm-ban-overlay').classList.remove('adm-modal-overlay--hidden');
      return;
    }
    runAction(def.action, playerId, p);
  }

  function updateSetJobGradeSelect(preferredGrade) {
    const catalog = state.jobsCatalog || [];
    const jobSel = document.getElementById('adm-setjob-job');
    const gradeSel = document.getElementById('adm-setjob-grade');
    if (!jobSel || !gradeSel) return;
    const jname = jobSel.value;
    const def = catalog.find(function (j) {
      return j.name === jname;
    });
    gradeSel.innerHTML = '';
    if (!def || !def.grades || def.grades.length === 0) {
      const o = document.createElement('option');
      o.value = '0';
      o.textContent = '—';
      gradeSel.appendChild(o);
      return;
    }
    def.grades.forEach(function (g) {
      const o = document.createElement('option');
      o.value = String(g.level);
      o.textContent = g.name ? String(g.name) : 'Grade ' + String(g.level);
      gradeSel.appendChild(o);
    });
    if (preferredGrade != null && preferredGrade !== '') {
      const pg = String(preferredGrade);
      if (Array.prototype.some.call(gradeSel.options, function (op) { return op.value === pg; })) {
        gradeSel.value = pg;
      }
    }
  }

  async function openSetJobModal(playerId, p) {
    state.setJobTargetId = playerId;
    const hint = document.getElementById('adm-setjob-hint');
    const jobSel = document.getElementById('adm-setjob-job');
    const display = p
      ? ((p.charName || '').trim() || 'Player') + ' · ID ' + playerId
      : 'ID ' + playerId;
    if (hint) hint.textContent = display;

    try {
      const list = await postNui('getJobsCatalog', {});
      state.jobsCatalog = Array.isArray(list) ? list : [];
    } catch (e) {
      state.jobsCatalog = [];
    }

    if (jobSel) {
      jobSel.innerHTML = '';
      const ph = document.createElement('option');
      ph.value = '';
      ph.textContent =
        state.jobsCatalog.length > 0 ? 'Choose job…' : 'Empty catalog (no setjob permission?)';
      jobSel.appendChild(ph);
      state.jobsCatalog.forEach(function (j) {
        const o = document.createElement('option');
        o.value = j.name;
        o.textContent = j.label + ' (' + j.name + ')';
        jobSel.appendChild(o);
      });
      const want = p && p.jobName ? String(p.jobName) : '';
      if (want && state.jobsCatalog.some(function (x) { return x.name === want; })) {
        jobSel.value = want;
      }
    }
    const prefGrade = p && p.jobGrade != null ? p.jobGrade : null;
    updateSetJobGradeSelect(prefGrade);

    const ov = document.getElementById('adm-setjob-overlay');
    if (ov) {
      ov.classList.remove('adm-modal-overlay--hidden');
      ov.setAttribute('aria-hidden', 'false');
    }
    document.getElementById('adm-modal-overlay').classList.add('adm-modal-overlay--hidden');
  }

  function setupFinanceTypeSelect() {
    const sel = document.getElementById('adm-finance-type');
    if (!sel) return;
    sel.innerHTML = '';
    const vorp = state.framework === 'vorp';
    const opts = vorp
      ? [
          { value: 'cash', label: 'Dollars (hand)' },
          { value: 'bank', label: 'Gold (bank)' },
          { value: 'bloodmoney', label: 'ROL' },
        ]
      : [
          { value: 'bank', label: 'Banco' },
          { value: 'valbank', label: 'Valentine' },
          { value: 'rhobank', label: 'Rhodes' },
          { value: 'blkbank', label: 'Blackwater' },
          { value: 'armbank', label: 'Armadillo' },
          { value: 'cash', label: 'Hand' },
          { value: 'bloodmoney', label: 'Blood money' },
        ];
    opts.forEach(function (o) {
      const el = document.createElement('option');
      el.value = o.value;
      el.textContent = o.label;
      sel.appendChild(el);
    });
  }

  function openFinanceModal(playerId, p) {
    state.financeTargetId = playerId;
    const hint = document.getElementById('adm-finance-hint');
    const display = p
      ? ((p.charName || '').trim() || 'Player') + ' · ID ' + playerId
      : 'ID ' + playerId;
    if (hint) hint.textContent = display;
    setupFinanceTypeSelect();
    const amountEl = document.getElementById('adm-finance-amount');
    if (amountEl) amountEl.value = '';
    const giveBtn = document.getElementById('adm-finance-give');
    const removeBtn = document.getElementById('adm-finance-remove');
    if (giveBtn) giveBtn.disabled = !allowed('givemoney');
    if (removeBtn) removeBtn.disabled = !allowed('removemoney');
    const ov = document.getElementById('adm-finance-overlay');
    if (ov) {
      ov.classList.remove('adm-modal-overlay--hidden');
      ov.setAttribute('aria-hidden', 'false');
    }
    document.getElementById('adm-modal-overlay').classList.add('adm-modal-overlay--hidden');
  }

  function closeFinanceModal(reopenPlayerModal) {
    const ov = document.getElementById('adm-finance-overlay');
    if (ov) {
      ov.classList.add('adm-modal-overlay--hidden');
      ov.setAttribute('aria-hidden', 'true');
    }
    const pid = state.financeTargetId;
    state.financeTargetId = null;
    if (reopenPlayerModal && pid != null) {
      openActionModal(pid);
    }
  }

  async function openRemoveJobModal(playerId, p) {
    state.removeJobTargetId = playerId;
    const hint = document.getElementById('adm-removejob-hint');
    const sel = document.getElementById('adm-removejob-select');
    const emptyEl = document.getElementById('adm-removejob-empty');
    const confirmBtn = document.getElementById('adm-removejob-confirm');
    const display = p
      ? ((p.charName || '').trim() || 'Player') + ' · ID ' + playerId
      : 'ID ' + playerId;
    if (hint) hint.textContent = display;

    let res = { jobs: [] };
    try {
      res = (await postNui('getTargetPlayerJobs', { playerId: playerId })) || {};
    } catch (e) {
      res = {};
    }

    if (res.denied) {
      if (hint) hint.textContent = "No permission to view this player's jobs.";
      if (sel) {
        sel.innerHTML = '';
        sel.disabled = true;
      }
      if (emptyEl) {
        emptyEl.textContent = '';
        emptyEl.classList.add('adm-view--hidden');
      }
      if (confirmBtn) confirmBtn.disabled = true;
    } else if (res.offline) {
      if (hint) hint.textContent = 'Player offline.';
      if (sel) {
        sel.innerHTML = '';
        sel.disabled = true;
      }
      if (emptyEl) emptyEl.classList.add('adm-view--hidden');
      if (confirmBtn) confirmBtn.disabled = true;
    } else {
      const jobs = res.jobs || [];
      if (sel) {
        sel.innerHTML = '';
        jobs.forEach(function (j) {
          const o = document.createElement('option');
          o.value = j.name;
          const activeMark = res.activeJob === j.name ? ' - active' : '';
          o.textContent = j.label + ' — ' + (j.gradeLabel || '') + activeMark;
          sel.appendChild(o);
        });
        sel.disabled = jobs.length === 0;
      }
      const empty = jobs.length === 0;
      if (emptyEl) {
        emptyEl.classList.toggle('adm-view--hidden', !empty);
        emptyEl.textContent = empty
          ? 'This player has no jobs to remove (only civilian / unemployed).'
          : '';
      }
      if (confirmBtn) confirmBtn.disabled = empty;
    }

    const ov = document.getElementById('adm-removejob-overlay');
    if (ov) {
      ov.classList.remove('adm-modal-overlay--hidden');
      ov.setAttribute('aria-hidden', 'false');
    }
    document.getElementById('adm-modal-overlay').classList.add('adm-modal-overlay--hidden');
  }

  function closeRemoveJobModal(reopenPlayerModal) {
    const ov = document.getElementById('adm-removejob-overlay');
    if (ov) {
      ov.classList.add('adm-modal-overlay--hidden');
      ov.setAttribute('aria-hidden', 'true');
    }
    const pid = state.removeJobTargetId;
    state.removeJobTargetId = null;
    if (reopenPlayerModal && pid != null) {
      openActionModal(pid);
    }
  }

  function closeSetJobModal(reopenPlayerModal) {
    const ov = document.getElementById('adm-setjob-overlay');
    if (ov) {
      ov.classList.add('adm-modal-overlay--hidden');
      ov.setAttribute('aria-hidden', 'true');
    }
    const pid = state.setJobTargetId;
    state.setJobTargetId = null;
    if (reopenPlayerModal && pid != null) {
      openActionModal(pid);
    }
  }

  function openDangerConfirm(opts) {
    state.dangerConfirmHandler = opts && opts.onConfirm;
    const titleEl = document.getElementById('adm-danger-confirm-title');
    const textEl = document.getElementById('adm-danger-confirm-text');
    if (titleEl) titleEl.textContent = (opts && opts.title) || 'Confirm';
    if (textEl) textEl.textContent = (opts && opts.text) || '';
    const ov = document.getElementById('adm-danger-confirm-overlay');
    if (ov) {
      ov.classList.remove('adm-modal-overlay--hidden');
      ov.setAttribute('aria-hidden', 'false');
    }
    document.getElementById('adm-modal-overlay').classList.add('adm-modal-overlay--hidden');
  }

  function closeDangerConfirm() {
    const ov = document.getElementById('adm-danger-confirm-overlay');
    if (ov) {
      ov.classList.add('adm-modal-overlay--hidden');
      ov.setAttribute('aria-hidden', 'true');
    }
    state.dangerConfirmHandler = null;
  }

  function allowed(cmd) {
    return state.allowedCommands[cmd] === true;
  }

  function canViewBans() {
    return allowed('ban') || allowed('unban');
  }

  function canEditBanDetails() {
    return allowed('ban');
  }

  function canRemoveBan() {
    return allowed('unban');
  }

  /** Separação «Commands»: pelo menos uma ação rápida / anúncio permitida na matriz. */
  function commandsSidebarAllowed() {
    return (
      allowed('teleport') ||
      allowed('revive') ||
      allowed('heal') ||
      allowed('checkdeath') ||
      allowed('kill') ||
      allowed('kick') ||
      allowed('broadcastannounce') ||
      allowed('wildattack') ||
      allowed('setonfire') ||
      allowed('giveitem') ||
      allowed('clearinventory') ||
      allowed('givemoney') ||
      allowed('removemoney') ||
      allowed('inventory') ||
      allowed('freeze') ||
      allowed('spectate') ||
      allowed('goto') ||
      allowed('bring') ||
      allowed('setjob') ||
      allowed('removejob')
    );
  }

  /** Mostrar entrada da sidebar só quando o cargo tem permissão para essa área (servidor tem prioridade). */
  function sidebarAllowsView(view) {
    const nv = state.navVisibility;
    if (nv && typeof nv === 'object' && Object.prototype.hasOwnProperty.call(nv, view)) {
      return nv[view] === true;
    }
    switch (view) {
      case 'players':
        return true;
      case 'reports':
        return allowed('viewreports');
      case 'adminchat':
        return allowed('adminchat');
      case 'dashboard':
        return allowed('adminmenu');
      case 'livemap':
        return allowed('getplayers');
      case 'teleports':
        return allowed('teleport') || allowed('createteleport') || allowed('deleteteleport');
      case 'commands':
        return commandsSidebarAllowed();
      case 'coords':
        return allowed('adminmenu');
      case 'developer':
        return allowed('wildattack') || allowed('setonfire');
      case 'items':
        return allowed('itemcatalog');
      case 'weapons':
        return allowed('weaponcatalog');
      case 'admins':
        return allowed('adminmenu');
      case 'bans':
        return canViewBans();
      case 'permissions':
        return state.canEditPermissions === true;
      case 'settings':
        return allowed('adminmenu');
      default:
        return true;
    }
  }

  /** Esconde botões sem permissão e grupos da sidebar totalmente vazios. */
  function applySidebarPermissionVisibility() {
    document.querySelectorAll('.adm-nav-item[data-view]').forEach(function (nav) {
      const v = nav.getAttribute('data-view');
      nav.classList.toggle('adm-nav-item--hidden', !sidebarAllowsView(v));
    });
    document.querySelectorAll('.adm-sidebar__nav .adm-nav-group').forEach(function (group) {
      const items = group.querySelectorAll('.adm-nav-item[data-view]');
      let anyVisible = false;
      items.forEach(function (item) {
        if (!item.classList.contains('adm-nav-item--hidden')) {
          anyVisible = true;
        }
      });
      group.classList.toggle('adm-view--hidden', !anyVisible);
    });
  }

  function syncBanDetailPermissions() {
    const canEdit = canEditBanDetails();
    const canRem = canRemoveBan();
    const saveBtn = document.getElementById('adm-ban-btn-save');
    const remBtn = document.getElementById('adm-ban-btn-remove');
    const reason = document.getElementById('adm-ban-input-reason');
    const chk = document.getElementById('adm-ban-check-permanent');
    const dt = document.getElementById('adm-ban-input-expire');
    if (saveBtn) saveBtn.classList.toggle('adm-view--hidden', !canEdit);
    if (remBtn) remBtn.classList.toggle('adm-view--hidden', !canRem);
    if (reason) reason.disabled = !canEdit;
    if (chk) chk.disabled = !canEdit;
    if (dt && chk) dt.disabled = !canEdit || chk.checked;
  }

  /** Rank ≥ 4 (founder): mostra o IP numérico na coluna localização; outros staff veem só geo (cidade/região), não a lista vazia. */
  function canSeePlayerEndpointIp() {
    return Number(state.staffRank) >= 4;
  }

  function updateClock() {
    const el = document.getElementById('adm-datetime');
    if (!el) return;
    const now = new Date();
    el.textContent = now.toLocaleString('en-US', {
      weekday: 'short',
      month: 'short',
      day: 'numeric',
      year: 'numeric',
      hour: '2-digit',
      minute: '2-digit',
      second: '2-digit',
    });
  }

  function updateStats() {
    const online = state.players.length;
    const max = Math.max(Number(state.maxPlayers) || 0, online);
    const offline = Math.max(0, max - online);
    const total = max;

    const elOn = document.getElementById('adm-stat-online');
    const elOff = document.getElementById('adm-stat-offline');
    const elTot = document.getElementById('adm-stat-total');
    if (elOn) elOn.textContent = String(online);
    if (elOff) elOff.textContent = String(offline);
    if (elTot) elTot.textContent = String(total);
  }

  function filterPlayers(list) {
    const q = (document.getElementById('adm-search-players')?.value || '').trim().toLowerCase();
    return list.filter(function (p) {
      const name = (p.charName || p.name || '').toLowerCase();
      const steam = (p.steamName || '').toLowerCase();
      const idStr = String(p.id);
      const geo = (p.geoLabel || '').toLowerCase();
      const vital =
        p.isDead === true ? 'dead' : 'alive';
      return (
        !q ||
        name.includes(q) ||
        steam.includes(q) ||
        idStr.includes(q) ||
        geo.includes(q) ||
        vital.includes(q)
      );
    });
  }

  function renderPlayerRows() {
    const tbody = document.getElementById('adm-tbody-players');
    const empty = document.getElementById('adm-players-empty');
    if (!tbody) return;

    const rows = filterPlayers(state.players);
    tbody.innerHTML = '';

    if (rows.length === 0) {
      empty.classList.add('adm-table-empty--visible');
      return;
    }
    empty.classList.remove('adm-table-empty--visible');

    rows.forEach(function (p) {
      const tr = document.createElement('tr');
      const charName = (p.charName || '').trim() || (p.name || '').split('|')[0].trim();
      const jobLabel = p.jobLabel || '—';
      const jobName = p.jobName || '';
      const ping = p.ping != null ? p.ping : '—';
      const cash = formatMoney(p.cash);
      const avatar = p.avatarUrl;
      const initials = charName
        .split(' ')
        .map(function (s) {
          return s[0];
        })
        .join('')
        .slice(0, 2)
        .toUpperCase() || '?';

      tr.innerHTML = [
        '<td>',
        '<div class="adm-cell-player">',
        avatar
          ? `<img class="adm-avatar" src="${avatar.replace(/"/g, '&quot;')}" alt="" />`
          : `<div class="adm-avatar adm-avatar--placeholder">${initials}</div>`,
        '<div class="adm-cell-player__meta">',
        `<div class="adm-cell-player__name">${escapeHtml(charName)}</div>`,
        `<div class="adm-cell-player__sub">ID ${escapeHtml(String(p.id))} · <span>${escapeHtml(String(ping))} ms</span></div>`,
        '</div></div>',
        '</td>',
        '<td>',
        `<span class="${jobBadgeClass(jobName)}">${escapeHtml(jobLabel)}</span>`,
        '</td>',
        '<td>',
        `<div class="adm-money">${escapeHtml(cash)}</div>`,
        '</td>',
        '<td>',
        `<div class="adm-geo">${escapeHtml(p.geoLabel != null && p.geoLabel !== '' ? String(p.geoLabel) : '—')}</div>`,
        canSeePlayerEndpointIp() && p.endpointIp
          ? `<div class="adm-geo-ip">${escapeHtml(String(p.endpointIp))}</div>`
          : '',
        '</td>',
        '<td>' +
          (p.isDead === true
            ? '<span class="adm-status adm-status--dead">Dead</span>'
            : '<span class="adm-status adm-status--online">Alive</span>') +
          '</td>',
        '<td class="adm-table__cell-action">',
        `<button type="button" class="adm-btn-icon" data-player-action="${p.id}" title="Actions">`,
        '<svg viewBox="0 0 24 24" width="18" height="18" fill="none" stroke="currentColor" stroke-width="2"><circle cx="12" cy="12" r="1"/><circle cx="12" cy="5" r="1"/><circle cx="12" cy="19" r="1"/></svg>',
        '</button>',
        '</td>',
      ].join('');

      tr.style.cursor = 'default';
      const actionBtn = tr.querySelector('[data-player-action]');
      if (actionBtn) {
        actionBtn.addEventListener('click', function (e) {
          e.preventDefault();
          e.stopPropagation();
          openActionModal(p.id);
        });
      }

      tbody.appendChild(tr);
    });
  }

  function escapeHtml(s) {
    const div = document.createElement('div');
    div.textContent = s;
    return div.innerHTML;
  }

  function escapeAttr(s) {
    if (s == null) return '';
    return String(s).replace(/&/g, '&amp;').replace(/"/g, '&quot;');
  }

  function staffChatInitials(name) {
    const parts = (name || '').trim().split(/\s+/).filter(Boolean);
    if (parts.length === 0) return '?';
    if (parts.length === 1) return parts[0].slice(0, 2).toUpperCase();
    return (parts[0][0] + parts[parts.length - 1][0]).toUpperCase();
  }

  function staffChatAvatarHtml(avatarUrl, senderName) {
    const initials = staffChatInitials(senderName);
    if (avatarUrl) {
      return (
        '<img class="adm-staff-msg__img" src="' +
        escapeAttr(avatarUrl) +
        '" alt="" loading="lazy" />'
      );
    }
    return '<span class="adm-staff-msg__ph">' + escapeHtml(initials) + '</span>';
  }

  /**
   * Mensagens do report em formato chat: jogador à esquerda, staff à direita.
   * @param {HTMLElement} scrollEl — #adm-report-messages-list ou #pr-detail-messages-list
   * @param {object[]} messages
   * @param {{ playerPerspective?: boolean }} opts — true na UI do jogador («Tu»)
   */
  function renderReportChatMessages(scrollEl, messages, opts) {
    opts = opts || {};
    const playerPerspective = opts.playerPerspective === true;
    if (!scrollEl) return;
    scrollEl.innerHTML = '';
    if (!messages || messages.length === 0) {
      const empty = document.createElement('div');
      empty.className = 'adm-chat-empty';
      empty.textContent = 'No messages yet.';
      scrollEl.appendChild(empty);
      return;
    }
    (messages || []).forEach(function (m) {
      const isStaff = (m.sender_type || 'player') === 'admin';
      const row = document.createElement('div');
      row.className = 'adm-chat-row ' + (isStaff ? 'adm-chat-row--staff' : 'adm-chat-row--player');
      let metaStr;
      if (isStaff) {
        metaStr = 'Staff';
        if (m.sender_name) metaStr += ' · ' + String(m.sender_name).trim();
        if (m.created_at_text) metaStr += ' · ' + m.created_at_text;
      } else {
        metaStr = playerPerspective ? 'You' : 'Player';
        if (!playerPerspective && m.sender_name) metaStr += ' · ' + String(m.sender_name).trim();
        if (m.created_at_text) metaStr += ' · ' + m.created_at_text;
      }
      const bubble = document.createElement('div');
      bubble.className = 'adm-chat-bubble';
      const meta = document.createElement('div');
      meta.className = 'adm-chat-bubble__meta';
      meta.textContent = metaStr;
      const text = document.createElement('p');
      text.className = 'adm-chat-bubble__text';
      text.textContent = m.message || '';
      bubble.appendChild(meta);
      bubble.appendChild(text);
      row.appendChild(bubble);
      scrollEl.appendChild(row);
    });
    requestAnimationFrame(function () {
      scrollEl.scrollTop = scrollEl.scrollHeight;
    });
  }

  function populatePlayerActionsPanel(mainEl, playerId, p, info) {
    const quickDefs = [
      { cmd: 'revive', label: 'Revive', action: 'revivePlayer', variant: 'heal', icon: 'heart' },
      { cmd: 'heal', label: 'Heal', action: 'healPlayer', variant: 'heal', icon: 'bolt' },
      { cmd: 'checkdeath', label: 'Check death', action: 'checkPlayerDeath', variant: 'inv', icon: 'logs' },
      { cmd: 'kill', label: 'Kill', action: 'killPlayer', variant: 'danger', icon: 'ban' },
      { cmd: 'inventory', label: 'Inventory', action: 'openInventory', variant: 'inv', icon: 'layers' },
      { cmd: 'givemoney', label: 'Give money', action: 'openFinanceModal', variant: 'money', icon: 'cash' },
      { cmd: 'goto', label: 'Go to player', action: 'gotoPlayer', variant: 'goto', icon: 'map-pin' },
      { cmd: 'bring', label: 'Bring player', action: 'bringPlayer', variant: 'bring', icon: 'users' },
      { cmd: 'freeze', label: 'Freeze', action: 'freezePlayer', variant: 'freeze', icon: 'key' },
      { cmd: 'spectate', label: 'Spectate', action: 'spectatePlayer', variant: 'spec', icon: 'crosshair' },
      { cmd: 'giveitem', label: 'Give Item', action: 'giveItemPicker', variant: 'giveitem', icon: 'package' },
    ];

    mainEl.innerHTML =
      '<section class="adm-pa-section" aria-label="Quick actions">' +
      '<h4 class="adm-pa-section__title">Quick actions</h4>' +
      '<div class="adm-player-quick-grid" role="group"></div>' +
      '</section>' +
      '<section class="adm-pa-section" aria-label="Job">' +
      '<h4 class="adm-pa-section__title">Job</h4>' +
      '<div class="adm-pa-row adm-pa-row--2">' +
      '<button type="button" class="adm-pa-block-btn adm-pa-block-btn--job" data-pa-cmd="setjob">' +
      '<span class="adm-pa-block-btn__icon" data-icon="user-cog" aria-hidden="true"></span>' +
      '<span class="adm-pa-block-btn__label">Set</span></button>' +
      '<button type="button" class="adm-pa-block-btn adm-pa-block-btn--job" data-pa-cmd="removejob">' +
      '<span class="adm-pa-block-btn__icon" data-icon="trash" aria-hidden="true"></span>' +
      '<span class="adm-pa-block-btn__label">Remove</span></button></div>' +
      '<button type="button" class="adm-pa-block-btn adm-pa-block-btn--wide adm-pa-block-btn--clear" data-pa-cmd="clearinventory">' +
      '<span class="adm-pa-block-btn__icon" data-icon="trash" aria-hidden="true"></span>' +
      '<span class="adm-pa-block-btn__label">Clear inventory</span></button>' +
      '</section>' +
      '<section class="adm-pa-section" aria-label="Moderation">' +
      '<h4 class="adm-pa-section__title">Moderation</h4>' +
      '<div class="adm-pa-row adm-pa-row--2">' +
      '<button type="button" class="adm-pa-block-btn adm-pa-block-btn--danger" data-pa-cmd="kick">' +
      '<span class="adm-pa-block-btn__icon" data-icon="flag" aria-hidden="true"></span>' +
      '<span class="adm-pa-block-btn__label">Kick</span></button>' +
      '<button type="button" class="adm-pa-block-btn adm-pa-block-btn--danger" data-pa-cmd="ban">' +
      '<span class="adm-pa-block-btn__icon" data-icon="ban" aria-hidden="true"></span>' +
      '<span class="adm-pa-block-btn__label">Ban</span></button></div>' +
      '</section>';

    const grid = mainEl.querySelector('.adm-player-quick-grid');
    quickDefs.forEach(function (def) {
      const btn = document.createElement('button');
      btn.type = 'button';
      btn.className =
        'adm-player-quick-tile' + (def.variant ? ' adm-player-quick-tile--' + def.variant : '');
      btn.disabled = def.cmd != null && !allowed(def.cmd);
      const icon = document.createElement('span');
      icon.className = 'adm-player-quick-tile__icon';
      icon.setAttribute('aria-hidden', 'true');
      if (def.icon && ICON_MAP[def.icon]) {
        icon.setAttribute('data-icon', def.icon);
      }
      const lab = document.createElement('span');
      lab.className = 'adm-player-quick-tile__label';
      lab.textContent = def.label;
      btn.appendChild(icon);
      btn.appendChild(lab);
      if (def.action) {
        btn.setAttribute('data-pa-action', def.action);
      }
      btn.addEventListener('click', function () {
        execPlayerAdminAction(def, playerId, p, info);
      });
      grid.appendChild(btn);
    });

    const jobMap = {
      setjob: { action: 'setJobPrompt', cmd: 'setjob' },
      removejob: { action: 'removeJobPrompt', cmd: 'removejob' },
      clearinventory: { action: 'clearInvPrompt', cmd: 'clearinventory' },
      kick: { action: 'kickPrompt', cmd: 'kick' },
      ban: { action: 'banPrompt', cmd: 'ban' },
    };
    mainEl.querySelectorAll('[data-pa-cmd]').forEach(function (btn) {
      const key = btn.getAttribute('data-pa-cmd');
      const j = jobMap[key];
      if (!j) return;
      btn.disabled = !allowed(j.cmd);
      btn.addEventListener('click', function () {
        execPlayerAdminAction({ action: j.action, cmd: j.cmd }, playerId, p, info);
      });
    });

    injectIcons(mainEl);
  }

  async function openActionModal(playerId) {
    state.selectedPlayerId = playerId;
    const p = state.players.find(function (x) {
      return Number(x.id) === Number(playerId);
    });
    const title = document.getElementById('adm-modal-title');
    const sub = document.getElementById('adm-modal-subtitle');
    const metaEl = document.getElementById('adm-modal-meta');
    const body = document.getElementById('adm-modal-body');
    if (!body || !title) return;

    title.textContent = 'Player actions';
    if (sub) sub.textContent = '';
    if (metaEl) metaEl.innerHTML = '';

    state.deathReportPanelOpen = false;

    body.innerHTML =
      '<div class="adm-player-modal-split" id="adm-player-split-root">' +
      '<aside class="adm-player-modal-split__aside">' +
      '<div class="adm-player-profile adm-player-profile--loading"><p>Loading profile…</p></div>' +
      '</aside>' +
      '<div class="adm-player-modal-split__main adm-player-modal-split__main--actions">' +
      '<div class="adm-player-actions-panel adm-player-actions-panel--placeholder"></div>' +
      '</div>' +
      deathReportAsideHtml() +
      '</div>';
    document.getElementById('adm-modal-overlay').classList.remove('adm-modal-overlay--hidden');

    let info = {};
    if (allowed('playerinfo')) {
      try {
        info = (await postNui('getPlayerInfo', { playerId: playerId })) || {};
      } catch (e) {
        info = {};
      }
    }

    const profileHtml = buildPlayerProfileCardHtml(p, info, playerId);
    body.innerHTML =
      '<div class="adm-player-modal-split" id="adm-player-split-root">' +
      '<aside class="adm-player-modal-split__aside">' +
      profileHtml +
      '</aside>' +
      '<div class="adm-player-modal-split__main adm-player-modal-split__main--actions">' +
      '<div class="adm-player-actions-panel" role="region"></div>' +
      '</div>' +
      deathReportAsideHtml() +
      '</div>';
    const mainPanel = body.querySelector('.adm-player-actions-panel');
    populatePlayerActionsPanel(mainPanel, playerId, p, info);
    hideDeathReportAside();
    resetDeathReportPanel();

    injectIcons(document.getElementById('adm-modal-overlay'));
  }

  function runAction(action, playerId, playerRow) {
    const payload = { action: action, playerId: playerId };
    if (action === 'freezePlayer') {
      payload.playerName = playerRow ? playerRow.name || '' : '';
    }
    postNui('action', payload).then(function (res) {
      if (res && res.closeMenu) {
        closeUi();
        return;
      }
      document.getElementById('adm-modal-overlay').classList.add('adm-modal-overlay--hidden');
    });
  }

  /**
   * @param {{ skipPlayerTable?: boolean }} [opts] — no Live map evitar `renderPlayerRows()` (tabela escondida mas DOM pesado).
   */
  async function refreshPlayers(opts) {
    const skipPlayerTable = opts && opts.skipPlayerTable === true;
    const list = await postNui('getPlayers', {});
    state.players = Array.isArray(list) ? list : [];
    updateStats();
    if (!skipPlayerTable) {
      renderPlayerRows();
    }
  }

  function mergeLiveMapPlayersWithAvatar(list) {
    const prevById = new Map();
    (state.players || []).forEach(function (p) {
      if (p && p.id != null) prevById.set(Number(p.id), p);
    });
    return (Array.isArray(list) ? list : []).map(function (p) {
      const old = prevById.get(Number(p.id));
      if (!old) return p;
      return Object.assign({}, p, {
        avatarUrl: p.avatarUrl || old.avatarUrl || null,
        charName: p.charName || old.charName || '',
      });
    });
  }

  async function refreshPlayersLiveMap() {
    const list = await postNui('getPlayersLiveMap', {});
    state.players = mergeLiveMapPlayersWithAvatar(list);
  }

  const VIEW_IDS = [
    'view-dashboard',
    'view-livemap',
    'view-players',
    'view-admins',
    'view-permissions',
    'view-reports',
    'view-bans',
    'view-adminchat',
    'view-teleports',
    'view-commands',
    'view-coords',
    'view-developer',
    'view-settings',
    'view-items',
    'view-weapons',
  ];

  const PERMANENT_BAN_EXPIRE = 2524608000;
  /** INT assinado em MySQL corta 2524608000 para 2147483647 — tratar como permanente na UI. */
  const MYSQL_INT_MAX_TS = 2147483647;

  function isBanPermanentExpire(ts) {
    const t = Number(ts);
    if (!isFinite(t) || t <= 0) return false;
    if (t >= PERMANENT_BAN_EXPIRE - 86400) return true;
    if (t >= MYSQL_INT_MAX_TS - 3600) return true;
    return false;
  }

  function hideAllMainViews() {
    VIEW_IDS.forEach(function (id) {
      const el = document.getElementById(id);
      if (el) el.classList.add('adm-view--hidden');
    });
  }

  function getLiveMapBounds() {
    const d = state.liveMapBounds;
    if (d && d.bounds && typeof d.bounds === 'object') {
      const b = d.bounds;
      const nx = function (v, def) {
        const n = Number(v);
        return isFinite(n) ? n : def;
      };
      return {
        minX: nx(b.minX, -5200),
        maxX: nx(b.maxX, 400),
        minY: nx(b.minY, -6000),
        maxY: nx(b.maxY, 6000),
        invertY: d.invertY !== false,
      };
    }
    return { minX: -5200, maxX: 400, minY: -6000, maxY: 6000, invertY: true };
  }

  function parsePlayerCoords(p) {
    if (!p || p.coords == null) return null;
    const c = p.coords;
    if (typeof c === 'object' && c.x != null && c.y != null) {
      const x = Number(c.x);
      const y = Number(c.y);
      const z = c.z != null ? Number(c.z) : 0;
      if (isFinite(x) && isFinite(y)) {
        return { x: x, y: y, z: isFinite(z) ? z : 0 };
      }
    }
    return null;
  }

  /** Mesma projeção que [local]/webmap/http/script.js (addBlip + rdr3Map). */
  function worldToMapPercent(x, y) {
    const d = state.liveMapBounds;
    if (d && d.projection === 'webmap' && d.webMap && typeof d.webMap === 'object') {
      const w = d.webMap;
      const mapRadius = Number(w.mapRadius);
      const width = Number(w.width);
      const height = Number(w.height);
      const xOffset = Number(w.xOffset);
      const yOffset = Number(w.yOffset);
      if (
        isFinite(mapRadius) &&
        isFinite(width) &&
        width !== 0 &&
        isFinite(height) &&
        height !== 0 &&
        isFinite(xOffset) &&
        isFinite(yOffset)
      ) {
        let left = ((x + mapRadius - xOffset) / width) * 100;
        let bottom = ((y + mapRadius - yOffset) / height) * 100;
        left = Math.max(0, Math.min(100, left));
        bottom = Math.max(0, Math.min(100, bottom));
        /* top: para o popover; bottom: mesmo % que o webmap (CSS bottom) */
        return { left: left, top: 100 - bottom, bottom: bottom };
      }
    }
    const bounds = getLiveMapBounds();
    const bw = bounds.maxX - bounds.minX;
    const bh = bounds.maxY - bounds.minY;
    if (!isFinite(bw) || bw === 0 || !isFinite(bh) || bh === 0) {
      return { left: 50, top: 50 };
    }
    let nx = (x - bounds.minX) / bw;
    let ny = (y - bounds.minY) / bh;
    if (bounds.invertY) ny = 1 - ny;
    nx = Math.max(0, Math.min(1, nx));
    ny = Math.max(0, Math.min(1, ny));
    return { left: nx * 100, top: ny * 100 };
  }

  /* --- Live map: refs DOM e viewport --- */
  function livemapInvalidateDomCache() {
    livemapDomCache = null;
  }

  function livemapDom() {
    if (!livemapDomCache || !livemapDomCache.layer || !document.body.contains(livemapDomCache.layer)) {
      livemapDomCache = {
        surface: document.getElementById('adm-livemap-surface'),
        layer: document.getElementById('adm-livemap-layer'),
        frame: document.getElementById('adm-livemap-frame'),
        popover: document.getElementById('adm-livemap-popover'),
      };
    }
    return livemapDomCache;
  }

  function livemapIsPopoverTarget(el) {
    return !!(el && el.closest && el.closest('#adm-livemap-popover'));
  }

  /** Mantém o pan dentro do intervalo para o mapa escalado cobrir o viewport. */
  function livemapClampPan() {
    const surface = livemapDom().surface;
    if (!surface) return;
    const W = surface.clientWidth;
    const H = surface.clientHeight;
    if (W <= 0 || H <= 0) return;
    if (state.livemapZoom < LIVEMAP_ZOOM_MIN) state.livemapZoom = LIVEMAP_ZOOM_MIN;
    const z = state.livemapZoom;
    const cx = W / 2;
    const cy = H / 2;
    const maxPanX = Math.max(0, cx * (z - 1));
    const maxPanY = Math.max(0, cy * (z - 1));
    state.livemapPanX = Math.max(-maxPanX, Math.min(maxPanX, state.livemapPanX));
    state.livemapPanY = Math.max(-maxPanY, Math.min(maxPanY, state.livemapPanY));
  }

  /** Só o transform da camada (inclui clamp). */
  function livemapWriteLayerTransform() {
    const layer = livemapDom().layer;
    const surface = livemapDom().surface;
    if (!layer || !surface) return;
    livemapClampPan();
    const z = state.livemapZoom;
    const px = state.livemapPanX;
    const py = state.livemapPanY;
    const W = surface.clientWidth;
    const H = surface.clientHeight;
    const cx = W > 0 ? W / 2 : 0;
    const cy = H > 0 ? H / 2 : 0;
    /* T(pan) · T(c) · S(z) · T(-c) — zoom em torno do centro do viewport. */
    layer.style.transform =
      'translate(' +
      px +
      'px,' +
      py +
      'px) translate(' +
      cx +
      'px,' +
      cy +
      'px) scale(' +
      z +
      ') translate(' +
      -cx +
      'px,' +
      -cy +
      'px)';
  }

  function livemapSyncPopoverFromMarker() {
    if (state.livemapPopoverMarkerEl) {
      positionLivemapPopoverFromMarker(state.livemapPopoverMarkerEl);
    }
  }

  function applyLivemapTransform() {
    livemapWriteLayerTransform();
    livemapSyncPopoverFromMarker();
  }

  /**
   * (ox, oy) em px relativos ao surface. Mantém o ponto do mapa sob o cursor ao mudar z.
   * Compatível com T(pan)·T(c)·S(z)·T(-c).
   */
  function livemapZoomAtPoint(ox, oy, newZ) {
    const z = Math.max(LIVEMAP_ZOOM_MIN, Math.min(LIVEMAP_ZOOM_MAX, newZ));
    const oldZ = state.livemapZoom;
    if (Math.abs(oldZ - z) < 1e-9) return;
    const surface = livemapDom().surface;
    if (!surface) return;
    const W = surface.clientWidth;
    const H = surface.clientHeight;
    if (W <= 0 || H <= 0) return;
    const cx = W / 2;
    const cy = H / 2;
    const k = z / oldZ;
    const mx = Number(ox) || 0;
    const my = Number(oy) || 0;
    state.livemapPanX = mx - cx - k * (mx - state.livemapPanX - cx);
    state.livemapPanY = my - cy - k * (my - state.livemapPanY - cy);
    state.livemapZoom = z;
    applyLivemapTransform();
  }

  function resetLivemapViewport() {
    state.livemapPanX = 0;
    state.livemapPanY = 0;
    state.livemapZoom = LIVEMAP_ZOOM_MIN;
    applyLivemapTransform();
  }

  function applyLiveMapSurfaceBg() {
    const layer = livemapDom().layer;
    if (!layer) return;
    /* Não voltar a sondar ao trocar de vista: evita “flash” entre grelha / imagem (parece mudar resolução). */
    if (layer.dataset.livemapBg === 'ok' || layer.dataset.livemapBg === 'loading') {
      return;
    }
    layer.dataset.livemapBg = 'loading';
    const candidates = ['livemap/rdr3-map.jpg', 'livemap/map-bg.png'];
    let idx = 0;
    function tryNext() {
      if (idx >= candidates.length) {
        layer.classList.remove('has-map-bg');
        layer.style.backgroundImage = '';
        layer.dataset.livemapBg = 'none';
        return;
      }
      const url = nuiHtmlAssetUrl(candidates[idx]);
      idx += 1;
      const probe = new Image();
      probe.onload = function () {
        layer.classList.add('has-map-bg');
        layer.style.backgroundImage = 'url("' + url.replace(/"/g, '\\"') + '")';
        layer.dataset.livemapBg = 'ok';
        applyLivemapTransform();
      };
      probe.onerror = function () {
        tryNext();
      };
      probe.src = url;
    }
    tryNext();
  }

  function hideLivemapPopover() {
    const pop = livemapDom().popover;
    if (pop) {
      pop.classList.add('adm-view--hidden');
      pop.setAttribute('aria-hidden', 'true');
      pop.style.left = '';
      pop.style.top = '';
      pop.style.right = '';
      pop.style.bottom = '';
    }
    state.livemapSelected = null;
    state.livemapPopoverMarkerEl = null;
  }

  /** Posiciona o popover junto ao marcador (coordenadas de ecrã), dentro do frame. */
  function positionLivemapPopoverFromMarker(markerEl) {
    const frame = livemapDom().frame;
    const pop = livemapDom().popover;
    if (!frame || !pop || !markerEl || pop.classList.contains('adm-view--hidden')) return;
    const margin = 8;
    const fw = frame.clientWidth;
    const fh = frame.clientHeight;
    const fr = frame.getBoundingClientRect();
    const mr = markerEl.getBoundingClientRect();
    const popW = pop.offsetWidth;
    const popH = pop.offsetHeight;
    if (!fw || !fh || popW < 8 || popH < 8) return;
    let leftPx = mr.right - fr.left + 8;
    let topPx = mr.top - fr.top;
    if (leftPx + popW > fw - margin) {
      leftPx = mr.left - fr.left - popW - 8;
    }
    if (leftPx < margin) {
      leftPx = margin;
    }
    if (leftPx + popW > fw - margin) {
      leftPx = Math.max(margin, fw - popW - margin);
    }
    if (topPx + popH > fh - margin) {
      topPx = Math.max(margin, fh - popH - margin);
    }
    if (topPx < margin) {
      topPx = margin;
    }
    pop.style.left = leftPx + 'px';
    pop.style.top = topPx + 'px';
    pop.style.right = 'auto';
    pop.style.bottom = 'auto';
  }

  function showLivemapPopover(p, markerEl) {
    state.livemapSelected = p;
    const pop = livemapDom().popover;
    const av = document.getElementById('adm-livemap-pop-avatar');
    const nm = document.getElementById('adm-livemap-pop-name');
    const idEl = document.getElementById('adm-livemap-pop-id');
    if (!pop || !nm || !idEl) return;
    const name =
      (p.charName || '').trim() ||
      (p.name || '')
        .split('|')[0]
        .trim() ||
      'Player';
    nm.textContent = name;
    idEl.textContent = 'ID ' + String(p.id);
    if (av) {
      const initials = name
        .split(/\s+/)
        .map(function (s) {
          return s[0];
        })
        .join('')
        .slice(0, 2)
        .toUpperCase() || '?';
      if (p.avatarUrl) {
        av.innerHTML = '<img src="' + String(p.avatarUrl).replace(/"/g, '&quot;') + '" alt="" />';
      } else {
        av.innerHTML = '<span class="adm-livemap-marker__ph">' + escapeHtml(initials) + '</span>';
      }
    }
    pop.classList.remove('adm-view--hidden');
    pop.setAttribute('aria-hidden', 'false');
    const btnG = document.getElementById('adm-livemap-btn-goto');
    const btnS = document.getElementById('adm-livemap-btn-spec');
    if (btnG) btnG.disabled = !allowed('goto');
    if (btnS) btnS.disabled = !allowed('spectate');
    injectIcons(pop);
    state.livemapPopoverMarkerEl = markerEl || null;
    requestAnimationFrame(function () {
      requestAnimationFrame(function () {
        if (markerEl) {
          positionLivemapPopoverFromMarker(markerEl);
        }
      });
    });
  }

  function livemapMarkerInnerHtml(p) {
    const charName = (p.charName || '').trim() || '';
    const initials =
      charName
        .split(/\s+/)
        .map(function (s) {
          return s[0];
        })
        .join('')
        .slice(0, 2)
        .toUpperCase() || '?';
    if (p.avatarUrl) {
      return '<img src="' + String(p.avatarUrl).replace(/"/g, '&quot;') + '" alt="" />';
    }
    return '<span class="adm-livemap-marker__ph">' + escapeHtml(initials) + '</span>';
  }

  function livemapSyncMarkerDom(mk, p, pct) {
    const anchorBottom = pct.bottom != null && isFinite(pct.bottom);
    const cls =
      'adm-livemap-marker' +
      (p.isDead === true ? ' adm-livemap-marker--dead' : '') +
      (anchorBottom ? ' adm-livemap-marker--anchor-bottom' : ' adm-livemap-marker--anchor-center');
    if (mk.className !== cls) {
      mk.className = cls;
    }
    mk.style.left = pct.left + '%';
    if (anchorBottom) {
      mk.style.bottom = pct.bottom + '%';
      mk.style.top = 'auto';
    } else {
      mk.style.top = pct.top + '%';
      mk.style.bottom = 'auto';
    }
    const title = ((p.charName || '').trim() || 'Player') + ' · ID ' + p.id;
    mk.title = title;
    mk.setAttribute('aria-label', title);
    const bodyHtml = livemapMarkerInnerHtml(p);
    const inner = mk.querySelector('.adm-livemap-marker__body');
    if (!inner) {
      mk.innerHTML = '<span class="adm-livemap-marker__body">' + bodyHtml + '</span>';
    } else if (inner.innerHTML !== bodyHtml) {
      inner.innerHTML = bodyHtml;
    }
  }

  function renderLiveMap() {
    const layer = livemapDom().layer;
    if (!layer) return;
    const savedPlayerId = state.livemapSelected ? state.livemapSelected.id : null;
    const popEl = livemapDom().popover;
    const popWasOpen =
      popEl && savedPlayerId != null && !popEl.classList.contains('adm-view--hidden');
    if (!layer._livemapMarkerClickBound) {
      layer._livemapMarkerClickBound = true;
      layer.addEventListener('click', function (e) {
        const mk = e.target && e.target.closest && e.target.closest('.adm-livemap-marker');
        if (!mk) return;
        e.stopPropagation();
        if (livemapPanDidDrag) return;
        const id = mk.getAttribute('data-livemap-player-id');
        const pl = (state.players || []).find(function (x) {
          return String(x.id) === String(id);
        });
        if (pl) showLivemapPopover(pl, mk);
      });
    }
    const prevById = new Map();
    layer.querySelectorAll('.adm-livemap-marker').forEach(function (m) {
      const id = m.getAttribute('data-livemap-player-id');
      if (id) prevById.set(id, m);
    });
    (state.players || []).forEach(function (p) {
      const pos = parsePlayerCoords(p);
      if (!pos) return;
      const pct = worldToMapPercent(pos.x, pos.y);
      const sid = String(p.id);
      let mk = prevById.get(sid);
      if (mk) {
        prevById.delete(sid);
        livemapSyncMarkerDom(mk, p, pct);
      } else {
        mk = document.createElement('button');
        mk.type = 'button';
        mk.setAttribute('data-livemap-player-id', sid);
        livemapSyncMarkerDom(mk, p, pct);
        layer.appendChild(mk);
      }
    });
    prevById.forEach(function (m) {
      m.remove();
    });
    applyLivemapTransform();
    if (popWasOpen && savedPlayerId != null) {
      const btn = layer.querySelector('[data-livemap-player-id="' + String(savedPlayerId) + '"]');
      if (btn) {
        state.livemapPopoverMarkerEl = btn;
        requestAnimationFrame(function () {
          positionLivemapPopoverFromMarker(btn);
        });
      } else {
        hideLivemapPopover();
      }
    }
  }

  function livemapStopPoll(keepPopover) {
    if (state.livemapPollTimer) {
      clearInterval(state.livemapPollTimer);
      state.livemapPollTimer = null;
    }
    state.livemapPollBusy = false;
    if (!keepPopover) {
      hideLivemapPopover();
    }
  }

  function livemapStartPoll() {
    livemapStopPoll(true);
    state.livemapPollBusy = true;
    refreshPlayers({ skipPlayerTable: true })
      .then(function () {
        return refreshPlayersLiveMap();
      })
      .then(function () {
        renderLiveMap();
      })
      .catch(function () {})
      .finally(function () {
        state.livemapPollBusy = false;
      });
    state.livemapPollTimer = setInterval(function () {
      if (state.livemapPollBusy) return;
      state.livemapPollBusy = true;
      refreshPlayersLiveMap()
        .then(function () {
          try {
            renderLiveMap();
          } catch (err) {
            /* Evita bloquear o poll se o render falhar (DOM inesperado, etc.). */
          }
        })
        .catch(function () {})
        .finally(function () {
          state.livemapPollBusy = false;
        });
    }, LIVEMAP_POLL_MS);
  }

  function livemapFlushPanMove() {
    livemapPanMoveRaf = null;
    const e = livemapPanMovePendingEvent;
    livemapPanMovePendingEvent = null;
    if (!livemapPanPointer || !e) return;
    /* Com pointer capture no surface, o alvo pode ser o mapa mesmo com o cursor sobre o popover — não panar por cima do menu. */
    try {
      const top = document.elementFromPoint(e.clientX, e.clientY);
      if (top && top.closest && top.closest('#adm-livemap-popover')) {
        onLivemapPointerUp(e);
        return;
      }
    } catch (err) {}
    const dx = e.clientX - livemapPanPointer.x;
    const dy = e.clientY - livemapPanPointer.y;
    if (Math.abs(dx) + Math.abs(dy) > LIVEMAP_PAN_DRAG_THRESHOLD_PX) {
      livemapPanDidDrag = true;
      state.livemapPanX = livemapPanPointer.panX + dx;
      state.livemapPanY = livemapPanPointer.panY + dy;
      applyLivemapTransform();
    }
  }

  function onLivemapPointerMove(e) {
    if (!livemapPanPointer) return;
    livemapPanMovePendingEvent = e;
    if (livemapPanMoveRaf != null) return;
    livemapPanMoveRaf = requestAnimationFrame(livemapFlushPanMove);
  }

  function onLivemapPointerUp(e) {
    if (livemapPanMoveRaf != null) {
      cancelAnimationFrame(livemapPanMoveRaf);
      livemapPanMoveRaf = null;
    }
    const ev = livemapPanMovePendingEvent != null ? livemapPanMovePendingEvent : e;
    livemapPanMovePendingEvent = null;
    if (livemapPanPointer && ev) {
      try {
        const top = document.elementFromPoint(ev.clientX, ev.clientY);
        if (!(top && top.closest && top.closest('#adm-livemap-popover'))) {
          const dx = ev.clientX - livemapPanPointer.x;
          const dy = ev.clientY - livemapPanPointer.y;
          if (Math.abs(dx) + Math.abs(dy) > LIVEMAP_PAN_DRAG_THRESHOLD_PX) {
            livemapPanDidDrag = true;
            state.livemapPanX = livemapPanPointer.panX + dx;
            state.livemapPanY = livemapPanPointer.panY + dy;
            applyLivemapTransform();
          }
        }
      } catch (err2) {}
    }
    document.removeEventListener('pointermove', onLivemapPointerMove);
    document.removeEventListener('pointerup', onLivemapPointerUp);
    const surface = livemapDom().surface;
    if (surface && e && e.pointerId != null) {
      try {
        surface.releasePointerCapture(e.pointerId);
      } catch (err) {}
    }
    livemapPanPointer = null;
  }

  /** Evita foco no canvas do mapa (role=application fazia scrollIntoView no painel → scrollbar / “zoom”). */
  function onLivemapSurfaceMouseDown(e) {
    if (e.button !== 0) return;
    const surface = livemapDom().surface;
    if (!surface || !surface.contains(e.target)) return;
    if (livemapIsPopoverTarget(e.target)) return;
    if (e.target && e.target.closest && e.target.closest('.adm-livemap-marker')) return;
    e.preventDefault();
  }

  function onLivemapPointerDown(e) {
    if (e.button !== 0) return;
    const surface = livemapDom().surface;
    if (!surface || !surface.contains(e.target)) return;
    livemapPanDidDrag = false;
    if (livemapIsPopoverTarget(e.target)) return;
    if (e.target && e.target.closest && e.target.closest('.adm-livemap-marker')) {
      return;
    }
    e.preventDefault();
    try {
      surface.setPointerCapture(e.pointerId);
    } catch (err) {}
    livemapPanPointer = {
      x: e.clientX,
      y: e.clientY,
      panX: state.livemapPanX,
      panY: state.livemapPanY,
    };
    livemapPanDidDrag = false;
    document.addEventListener('pointermove', onLivemapPointerMove);
    document.addEventListener('pointerup', onLivemapPointerUp);
  }

  function livemapRunLayoutRefitFromObserver() {
    livemapResizeObserverRaf = null;
    if (state.currentView !== 'livemap') return;
    const frameEl = livemapDom().frame;
    if (!frameEl) return;
    const w = Math.round(frameEl.clientWidth);
    const h = Math.round(frameEl.clientHeight);
    if (w <= 0 || h <= 0) return;
    if (
      livemapLastFrameLayoutW >= 0 &&
      Math.abs(w - livemapLastFrameLayoutW) < LIVEMAP_FRAME_RESIZE_THRESH_PX &&
      Math.abs(h - livemapLastFrameLayoutH) < LIVEMAP_FRAME_RESIZE_THRESH_PX
    ) {
      return;
    }
    livemapLastFrameLayoutW = w;
    livemapLastFrameLayoutH = h;
    applyLivemapTransform();
  }

  function livemapMountLayoutObserver() {
    const frame = livemapDom().frame;
    if (!frame || typeof ResizeObserver === 'undefined') return;
    if (!livemapResizeObserver) {
      livemapResizeObserver = new ResizeObserver(function () {
        if (state.currentView !== 'livemap') return;
        if (livemapResizeObserverRaf != null) return;
        livemapResizeObserverRaf = requestAnimationFrame(livemapRunLayoutRefitFromObserver);
      });
    }
    livemapResizeObserver.observe(frame);
  }

  function livemapUnmountLayoutObserver() {
    const frame = livemapDom().frame;
    if (livemapResizeObserver && frame) {
      try {
        livemapResizeObserver.unobserve(frame);
      } catch (err) {}
    }
    if (livemapResizeObserverRaf != null) {
      cancelAnimationFrame(livemapResizeObserverRaf);
      livemapResizeObserverRaf = null;
    }
  }

  function onLivemapWindowResize() {
    if (state.currentView !== 'livemap') return;
    if (livemapWindowResizeTimer) clearTimeout(livemapWindowResizeTimer);
    livemapWindowResizeTimer = setTimeout(function () {
      livemapWindowResizeTimer = null;
      applyLivemapTransform();
    }, LIVEMAP_WINDOW_RESIZE_DEBOUNCE_MS);
  }

  function wireLiveMapPanel() {
    if (livemapPanelWired) return;
    livemapPanelWired = true;

    const surf = livemapDom().surface;
    if (surf) {
      surf.addEventListener('mousedown', onLivemapSurfaceMouseDown);
      surf.addEventListener('pointerdown', onLivemapPointerDown);
      surf.addEventListener(
        'wheel',
        function (e) {
          if (livemapIsPopoverTarget(e.target)) return;
          e.preventDefault();
          const dir = e.deltaY > 0 ? -1 : 1;
          const factor = dir < 0 ? 1 / LIVEMAP_WHEEL_ZOOM_STEP : LIVEMAP_WHEEL_ZOOM_STEP;
          const r = surf.getBoundingClientRect();
          const ox = e.clientX - r.left;
          const oy = e.clientY - r.top;
          livemapZoomAtPoint(ox, oy, state.livemapZoom * factor);
        },
        { passive: false }
      );
      surf.addEventListener('click', function (e) {
        if (livemapIsPopoverTarget(e.target)) return;
        hideLivemapPopover();
      });
    }
    const zIn = document.getElementById('adm-livemap-zoom-in');
    const zOut = document.getElementById('adm-livemap-zoom-out');
    const zReset = document.getElementById('adm-livemap-zoom-reset');
    if (zIn) {
      zIn.addEventListener('click', function (e) {
        e.stopPropagation();
        const s = livemapDom().surface;
        if (!s) return;
        const r = s.getBoundingClientRect();
        livemapZoomAtPoint(r.width / 2, r.height / 2, state.livemapZoom * LIVEMAP_ZOOM_BTN_FACTOR);
      });
    }
    if (zOut) {
      zOut.addEventListener('click', function (e) {
        e.stopPropagation();
        const s = livemapDom().surface;
        if (!s) return;
        const r = s.getBoundingClientRect();
        livemapZoomAtPoint(r.width / 2, r.height / 2, state.livemapZoom / LIVEMAP_ZOOM_BTN_FACTOR);
      });
    }
    if (zReset) {
      zReset.addEventListener('click', function (e) {
        e.stopPropagation();
        resetLivemapViewport();
      });
    }
    const ref = document.getElementById('adm-livemap-refresh');
    if (ref) {
      ref.addEventListener('click', function () {
        if (state.livemapPollBusy) return;
        state.livemapPollBusy = true;
        refreshPlayers({ skipPlayerTable: true })
          .then(function () {
            return refreshPlayersLiveMap();
          })
          .then(function () {
            try {
              renderLiveMap();
            } catch (err) {}
          })
          .catch(function () {})
          .finally(function () {
            state.livemapPollBusy = false;
          });
      });
    }
    const btnG = document.getElementById('adm-livemap-btn-goto');
    const btnS = document.getElementById('adm-livemap-btn-spec');
    if (btnG) {
      btnG.addEventListener('click', function (e) {
        e.stopPropagation();
        const p = state.livemapSelected;
        if (!p) return;
        runAction('gotoPlayer', p.id, p);
        hideLivemapPopover();
      });
    }
    if (btnS) {
      btnS.addEventListener('click', function (e) {
        e.stopPropagation();
        const p = state.livemapSelected;
        if (!p) return;
        runAction('spectatePlayer', p.id, p);
        hideLivemapPopover();
      });
    }
    const pop = livemapDom().popover;
    if (pop) {
      pop.addEventListener('click', function (e) {
        e.stopPropagation();
      });
      pop.addEventListener(
        'wheel',
        function (e) {
          e.preventDefault();
          e.stopPropagation();
        },
        { passive: false }
      );
    }
    const livemapFrame = livemapDom().frame;
    if (livemapFrame) {
      livemapFrame.addEventListener(
        'wheel',
        function (e) {
          if (livemapIsPopoverTarget(e.target)) {
            e.preventDefault();
            e.stopPropagation();
          }
        },
        { passive: false }
      );
    }
    window.addEventListener('resize', onLivemapWindowResize);
    window.addEventListener('keydown', onLivemapKeyDown);
  }

  function onLivemapKeyDown(e) {
    if (state.currentView !== 'livemap') return;
    if (!e || e.key !== 'Escape') return;
    const pop = livemapDom().popover;
    if (!pop || pop.classList.contains('adm-view--hidden')) return;
    e.preventDefault();
    hideLivemapPopover();
  }

  function formatStaffChatTime(at) {
    const t = Number(at);
    if (!isFinite(t) || t <= 0) return '';
    return new Date(t * 1000).toLocaleString('en-US', {
      day: '2-digit',
      month: 'short',
      hour: '2-digit',
      minute: '2-digit',
    });
  }

  function updateAdminChatBadge() {
    const b = document.getElementById('adm-chat-badge');
    if (!b) return;
    const n = state.adminChatUnread;
    if (n > 0) {
      b.textContent = String(Math.min(99, n));
      b.classList.remove('adm-view--hidden');
    } else {
      b.classList.add('adm-view--hidden');
    }
  }

  function scrollStaffChatToBottom() {
    const el = document.getElementById('adm-staff-chat-scroll');
    if (el) {
      el.scrollTop = el.scrollHeight;
    }
  }

  function renderAdminChat() {
    const scroll = document.getElementById('adm-staff-chat-scroll');
    if (!scroll) return;
    const list = state.adminChatMessages.slice().sort(function (a, b) {
      return a.id - b.id;
    });
    const myName = (state.staffName || '').trim();
    if (list.length === 0) {
      scroll.innerHTML =
        '<div class="adm-staff-chat-stream adm-staff-chat-stream--empty">' +
        '<p class="adm-chat-empty">No messages yet. Write below to start.</p>' +
        '</div>';
      return;
    }
    const rows = list
      .map(function (m) {
        const mine = (m.senderName || '').trim() === myName;
        const meta =
          escapeHtml(m.senderName || 'Staff') + ' · ' + escapeHtml(formatStaffChatTime(m.at));
        const body = escapeHtml(m.message || '');
        const av = staffChatAvatarHtml(m.avatarUrl, m.senderName);
        const bubbleClass = mine ? 'adm-chat-bubble adm-chat-bubble--mine' : 'adm-chat-bubble adm-chat-bubble--them';
        const bubble =
          '<div class="' +
          bubbleClass +
          '">' +
          '<div class="adm-chat-bubble__meta">' +
          meta +
          '</div>' +
          '<p class="adm-chat-bubble__text">' +
          body +
          '</p>' +
          '</div>';
        if (mine) {
          return (
            '<div class="adm-staff-msg adm-staff-msg--mine">' +
            '<div class="adm-staff-msg__grow">' +
            bubble +
            '</div>' +
            '<div class="adm-staff-msg__avatar" aria-hidden="true">' +
            av +
            '</div>' +
            '</div>'
          );
        }
        return (
          '<div class="adm-staff-msg adm-staff-msg--them">' +
          '<div class="adm-staff-msg__avatar" aria-hidden="true">' +
          av +
          '</div>' +
          '<div class="adm-staff-msg__grow">' +
          bubble +
          '</div>' +
          '</div>'
        );
      })
      .join('');
    scroll.innerHTML = '<div class="adm-staff-chat-stream">' + rows + '</div>';
    requestAnimationFrame(function () {
      scrollStaffChatToBottom();
    });
  }

  function ingestAdminChatMessage(m, fromBroadcast) {
    if (!m || m.id == null) return;
    const id = Number(m.id);
    if (!isFinite(id) || state.adminChatById[id]) return;
    state.adminChatById[id] = true;
    state.adminChatMessages.push({
      id: id,
      senderName: m.senderName || 'Staff',
      discordId: m.discordId || null,
      avatarUrl: m.avatarUrl || null,
      message: m.message || '',
      at: Number(m.at) || 0,
    });
    if (fromBroadcast === true && state.currentView !== 'adminchat') {
      state.adminChatUnread += 1;
      updateAdminChatBadge();
    }
    renderAdminChat();
  }

  async function loadAdminChat() {
    if (!allowed('adminchat')) return;
    const res = await postNui('getAdminChat', {});
    state.adminChatMessages = [];
    state.adminChatById = {};
    if (res && res.ok && Array.isArray(res.messages)) {
      res.messages.forEach(function (m) {
        const id = Number(m.id);
        if (!isFinite(id) || state.adminChatById[id]) return;
        state.adminChatById[id] = true;
        state.adminChatMessages.push({
          id: id,
          senderName: m.senderName || 'Staff',
          discordId: m.discordId || null,
          avatarUrl: m.avatarUrl || null,
          message: m.message || '',
          at: Number(m.at) || 0,
        });
      });
    }
    state.adminChatUnread = 0;
    updateAdminChatBadge();
    renderAdminChat();
  }

  async function submitStaffChat() {
    if (!allowed('adminchat')) return;
    const input = document.getElementById('adm-staff-chat-input');
    if (!input) return;
    const text = input.value.trim();
    if (!text) return;
    input.value = '';
    const res = await postNui('sendAdminChat', { message: text });
    if (res && res.ok && res.message) {
      ingestAdminChatMessage(res.message, false);
    } else {
      await postNui('notify', {
        title: 'Staff chat',
        description: 'Could not send the message.',
        type: 'error',
      });
    }
  }

  function setPermUiVisible(showTable, showDenied, errMsg) {
    const editor = document.getElementById('adm-perm-editor');
    const card = document.getElementById('adm-perm-card');
    const denied = document.getElementById('adm-perm-denied');
    const err = document.getElementById('adm-perm-error');
    if (editor) editor.classList.toggle('adm-view--hidden', showDenied);
    if (card) card.classList.toggle('adm-view--hidden', !showTable);
    if (denied) denied.classList.toggle('adm-view--hidden', !showDenied);
    if (err) {
      err.classList.toggle('adm-view--hidden', !errMsg);
      err.textContent = errMsg || '';
    }
  }

  /** Normaliza texto para filtro (minúsculas, sem acentos — útil em pt/en). */
  function normalizePermSearchString(s) {
    let t = String(s || '')
      .trim()
      .toLowerCase();
    if (typeof t.normalize === 'function') {
      t = t.normalize('NFD').replace(/[\u0300-\u036f]/g, '');
    }
    return t;
  }

  function permissionCommandMatchesSearch(cmd, rawQuery) {
    const qNorm = normalizePermSearchString(rawQuery);
    if (!qNorm) return true;
    const blob = normalizePermSearchString(
      String(cmd.label != null ? cmd.label : '') + ' ' + String(cmd.key != null ? cmd.key : '')
    );
    const tokens = qNorm.split(/\s+/).filter(Boolean);
    return tokens.every(function (tok) {
      return blob.indexOf(tok) !== -1;
    });
  }

  function syncPermissionSearchQueryFromDom() {
    const el = document.getElementById('adm-search-permissions');
    state.permissionSearchQuery = el ? el.value || '' : '';
  }

  function onPermissionMatrixSearchInput() {
    syncPermissionSearchQueryFromDom();
    if (state.permissionPayload) {
      renderPermissionMatrix(state.permissionPayload);
    }
  }

  function renderPermissionMatrix(payload) {
    state.permissionPayload = payload;
    const thead = document.getElementById('adm-perm-thead');
    const tbody = document.getElementById('adm-perm-tbody');
    const note = document.getElementById('adm-perm-strict-note');
    if (!thead || !tbody || !payload || !payload.roles) return;
    if (!Array.isArray(payload.commands)) return;

    if (note) {
      if (payload.strictDefault) {
        if (payload.founderDefaultsAllow && payload.founderRoleKey) {
          note.textContent =
            'Each role needs Allow saved per command, except "' +
            String(payload.founderRoleKey) +
            '" (Allow unless you set Deny).';
        } else {
          note.textContent = 'Each role needs Allow saved per command in the database.';
        }
      }
    }

    const roles = payload.roles;
    syncPermissionQuickRoleOptions(roles);
    syncPermissionQuickCommandOptions(payload.commands || []);
    const searchQ = state.permissionSearchQuery || '';
    const commands = payload.commands.filter(function (cmd) {
      return permissionCommandMatchesSearch(cmd, searchQ);
    });
    const matrix = payload.matrix || {};

    const trLabels = document.createElement('tr');
    const trKeys = document.createElement('tr');

    const thAction = document.createElement('th');
    thAction.rowSpan = 2;
    thAction.scope = 'col';
    thAction.className = 'adm-perm-th-action';
    thAction.textContent = 'Action';
    trLabels.appendChild(thAction);

    roles.forEach(function (r) {
      const th = document.createElement('th');
      th.scope = 'col';
      th.className = 'adm-perm-th-role adm-perm-th-role--label';
      th.innerHTML =
        '<span class="adm-perm-role-label">' + escapeHtml(r.label || r.key) + '</span>';
      trLabels.appendChild(th);
    });

    roles.forEach(function (r) {
      const th = document.createElement('th');
      th.scope = 'col';
      th.className = 'adm-perm-th-role adm-perm-th-role--key';
      th.innerHTML = '<span class="adm-perm-role-key">' + escapeHtml(r.key) + '</span>';
      trKeys.appendChild(th);
    });

    thead.innerHTML = '';
    thead.appendChild(trLabels);
    thead.appendChild(trKeys);

    tbody.innerHTML = '';
    commands.forEach(function (cmd) {
      const tr = document.createElement('tr');
      const td0 = document.createElement('td');
      td0.className = 'adm-perm-td-cmd';
      td0.innerHTML =
        '<span class="adm-perm-cmd-label">' +
        escapeHtml(cmd.label || cmd.key) +
        '</span><code class="adm-perm-cmd-key">' +
        escapeHtml(cmd.key) +
        '</code>';
      tr.appendChild(td0);

      roles.forEach(function (r) {
        const td = document.createElement('td');
        td.className = 'adm-perm-td-cell';
        const val = matrix[r.key] && matrix[r.key][cmd.key] === true;
        const id = 'perm-' + r.key + '-' + cmd.key.replace(/[^a-zA-Z0-9]/g, '_');
        const sel = document.createElement('select');
        sel.className = 'adm-select adm-select--perm';
        sel.id = id;
        sel.dataset.role = r.key;
        sel.dataset.cmd = cmd.key;
        sel.setAttribute('aria-label', (r.label || r.key) + ' — ' + (cmd.label || cmd.key));
        const optNo = document.createElement('option');
        optNo.value = '0';
        optNo.textContent = 'No';
        const optYes = document.createElement('option');
        optYes.value = '1';
        optYes.textContent = 'Allow';
        sel.appendChild(optNo);
        sel.appendChild(optYes);
        sel.value = val ? '1' : '0';
        td.appendChild(sel);
        tr.appendChild(td);
      });
      tbody.appendChild(tr);
    });
  }

  function getFilteredPermissionCommands(payload) {
    const searchQ = state.permissionSearchQuery || '';
    const list = payload && Array.isArray(payload.commands) ? payload.commands : [];
    return list.filter(function (cmd) {
      return permissionCommandMatchesSearch(cmd, searchQ);
    });
  }

  function syncPermissionQuickRoleOptions(roles) {
    const sel = document.getElementById('adm-perm-role-quick');
    if (!sel) return;
    const prev = sel.value || '';
    sel.innerHTML = '<option value="">Role...</option>';
    (roles || []).forEach(function (r) {
      const o = document.createElement('option');
      o.value = r.key;
      o.textContent = (r.label || r.key) + ' (' + r.key + ')';
      sel.appendChild(o);
    });
    if (prev && Array.prototype.some.call(sel.options, function (o) { return o.value === prev; })) {
      sel.value = prev;
    }
  }

  function syncPermissionQuickCommandOptions(commands) {
    const sel = document.getElementById('adm-perm-command-quick');
    if (!sel) return;
    const prev = sel.value || '';
    sel.innerHTML = '<option value="">Permission...</option>';
    (commands || []).forEach(function (c) {
      const o = document.createElement('option');
      o.value = c.key;
      o.textContent = (c.label || c.key) + ' (' + c.key + ')';
      sel.appendChild(o);
    });
    if (prev && Array.prototype.some.call(sel.options, function (o) { return o.value === prev; })) {
      sel.value = prev;
    }
  }

  async function applyQuickPermission(roleKey, commandKey, allowed) {
    const payload = state.permissionPayload;
    if (!payload || !roleKey || !commandKey) return;
    const res = await postNui('setPermission', {
      roleKey: roleKey,
      commandKey: commandKey,
      allowed: allowed,
    });
    if (!res || res.ok !== true) {
      const err = document.getElementById('adm-perm-error');
      if (err) {
        err.classList.remove('adm-view--hidden');
        err.textContent = 'Failed to apply quick permission.';
      }
      return;
    }
    if (payload.matrix) {
      payload.matrix[roleKey] = payload.matrix[roleKey] || {};
      payload.matrix[roleKey][commandKey] = allowed;
    }
    const quickCommandSel = document.getElementById('adm-perm-command-quick');
    if (quickCommandSel) {
      quickCommandSel.value = commandKey;
    }
    document.querySelectorAll('.adm-select--perm').forEach(function (el) {
      if (el.dataset && el.dataset.role === roleKey && el.dataset.cmd === commandKey) {
        el.value = allowed ? '1' : '0';
      }
    });
    const err = document.getElementById('adm-perm-error');
    if (err) {
      err.classList.add('adm-view--hidden');
      err.textContent = '';
    }
  }

  function formatStaffDate(v) {
    if (v == null || v === '') return '—';
    let d = new Date(v);
    // oxmysql costuma devolver DATETIME como "YYYY-MM-DD HH:MM:SS", que falha em alguns CEF.
    if (isNaN(d.getTime()) && typeof v === 'string') {
      const isoTry = v.replace(' ', 'T');
      d = new Date(isoTry);
    }
    if (isNaN(d.getTime()) && typeof v === 'string') {
      const m = v.match(/^(\d{4})-(\d{2})-(\d{2})[ T](\d{2}):(\d{2}):(\d{2})$/);
      if (m) {
        d = new Date(
          Number(m[1]),
          Number(m[2]) - 1,
          Number(m[3]),
          Number(m[4]),
          Number(m[5]),
          Number(m[6])
        );
      }
    }
    if (isNaN(d.getTime())) return String(v);
    const pad = function (n) {
      return String(n).padStart(2, '0');
    };
    const day = pad(d.getDate());
    const month = pad(d.getMonth() + 1);
    const year = d.getFullYear();
    const hh = pad(d.getHours());
    const mm = pad(d.getMinutes());
    return day + '/' + month + '/' + year + ' - ' + hh + ':' + mm;
  }

  function updateStaffStats(list) {
    let on = 0;
    let off = 0;
    (list || []).forEach(function (a) {
      if (a.online) on += 1;
      else off += 1;
    });
    const elOn = document.getElementById('adm-staff-stat-online');
    const elOff = document.getElementById('adm-staff-stat-offline');
    const elTot = document.getElementById('adm-staff-stat-total');
    if (elOn) elOn.textContent = String(on);
    if (elOff) elOff.textContent = String(off);
    if (elTot) elTot.textContent = String((list || []).length);
  }

  /** Normaliza nome para comparar (evita mostrar Discord + personagem + display quase iguais). */
  function staffNameNormForCompare(s) {
    return (s || '')
      .toLowerCase()
      .replace(/[^a-z0-9\s]/g, ' ')
      .replace(/\s+/g, ' ')
      .trim();
  }

  /** True se os dois nomes são o mesmo “sujeito” para efeitos de UI (ex.: Rayan Morgan vs Rayan, O Morgan ツ). */
  function staffNamesLookSame(a, b) {
    const na = staffNameNormForCompare(a);
    const nb = staffNameNormForCompare(b);
    if (!na || !nb) return false;
    if (na === nb) return true;
    if (na.length >= 4 && nb.length >= 4 && (na.indexOf(nb) >= 0 || nb.indexOf(na) >= 0)) return true;
    const ta = na.split(' ').filter(function (t) {
      return t.length > 2;
    });
    const tb = nb.split(' ').filter(function (t) {
      return t.length > 2;
    });
    if (ta.length < 2 || tb.length < 2) return false;
    const short = ta.length <= tb.length ? ta : tb;
    const longStr = ta.length <= tb.length ? nb : na;
    let hit = 0;
    short.forEach(function (t) {
      if (longStr.indexOf(t) >= 0) hit += 1;
    });
    return hit >= short.length;
  }

  function renderStaffAdminsTable() {
    const list = state.staffAdminsList || [];
    const q = (document.getElementById('adm-search-staff')?.value || '').trim().toLowerCase();
    const grid = document.getElementById('adm-staff-grid');
    const empty = document.getElementById('adm-staff-empty');
    if (!grid) return;

    const filtered = list.filter(function (a) {
      if (!q) return true;
      const blob = [
        a.username,
        a.discordUsername,
        a.discordId,
        a.rankLabel,
        a.inGameName,
      ]
        .filter(Boolean)
        .join(' ')
        .toLowerCase();
      return blob.includes(q);
    });

    grid.innerHTML = '';
    if (filtered.length === 0) {
      if (empty) empty.classList.add('adm-table-empty--visible');
      return;
    }
    if (empty) empty.classList.remove('adm-table-empty--visible');

    filtered.forEach(function (a) {
      const uname = a.username || '—';
      const initials = uname
        .split(/\s+/)
        .map(function (x) {
          return x[0];
        })
        .join('')
        .slice(0, 2)
        .toUpperCase();
      const avatarHtml = a.avatarUrl
        ? '<img class="adm-avatar adm-avatar--staff adm-avatar--staff-card" src="' +
          String(a.avatarUrl).replace(/"/g, '&quot;') +
          '" alt="" />'
        : '<div class="adm-avatar adm-avatar--placeholder adm-avatar--staff adm-avatar--staff-card">' +
          escapeHtml(initials || '?') +
          '</div>';
      const ingame = (a.inGameName || '').trim();
      const discordUser = (a.discordUsername || '').trim();
      const discordId = a.discordId != null && String(a.discordId).trim() !== '' ? String(a.discordId) : '';
      const partialChip = a.partial
        ? '<span class="adm-staff-chip" title="Incomplete Discord data">Partial</span>'
        : '';
      const showCharacter =
        ingame.length > 0 && !staffNamesLookSame(ingame, uname);
      const discordBits = [];
      if (discordUser) {
        discordBits.push('<span class="adm-staff-profile__handle">' + escapeHtml('@' + discordUser) + '</span>');
      }
      if (discordId) {
        discordBits.push('<code class="adm-staff-profile__id">' + escapeHtml(discordId) + '</code>');
      }
      const discordStr =
        discordBits.length > 0
          ? discordBits.join('<span class="adm-staff-profile__sep" aria-hidden="true">·</span>')
          : '';
      let metaInner = '';
      if (showCharacter && discordStr) {
        metaInner =
          '<span class="adm-staff-profile__char">' +
          escapeHtml(ingame) +
          '</span><span class="adm-staff-profile__sep" aria-hidden="true">·</span>' +
          '<span class="adm-staff-profile__discord-inline">' +
          discordStr +
          '</span>';
      } else if (showCharacter) {
        metaInner = '<span class="adm-staff-profile__char">' + escapeHtml(ingame) + '</span>';
      } else if (discordStr) {
        metaInner = '<span class="adm-staff-profile__discord-inline">' + discordStr + '</span>';
      }
      const metaRow = metaInner ? '<div class="adm-staff-card__meta">' + metaInner + '</div>' : '';

      const statusPill = a.online
        ? '<span class="adm-staff-pill adm-staff-pill--online adm-staff-pill--card"><span class="adm-staff-pill__dot" aria-hidden="true"></span>Online</span>'
        : '<span class="adm-staff-pill adm-staff-pill--offline adm-staff-pill--card"><span class="adm-staff-pill__dot" aria-hidden="true"></span>Offline</span>';

      const card = document.createElement('article');
      card.className =
        'adm-staff-card' + (a.online ? ' adm-staff-card--online' : ' adm-staff-card--offline');
      card.setAttribute('role', 'listitem');

      card.innerHTML = [
        '<div class="adm-staff-card__top">',
        '<div class="adm-staff-card__avatar">' + avatarHtml + '</div>',
        '<div class="adm-staff-card__intro">',
        '<div class="adm-staff-card__title-row">',
        '<h3 class="adm-staff-card__name">' + escapeHtml(uname) + '</h3>',
        partialChip,
        '</div>',
        metaRow,
        '</div>',
        statusPill,
        '</div>',
        '<div class="adm-staff-card__foot">',
        '<span class="adm-staff-rank adm-staff-rank--card">' + escapeHtml(a.rankLabel || '—') + '</span>',
        '<div class="adm-staff-card__join">',
        '<span class="adm-staff-card__join-lbl">Last join</span>',
        '<span class="adm-staff-card__join-val">' + escapeHtml(formatStaffDate(a.lastServerJoin)) + '</span>',
        '</div>',
        '</div>',
      ].join('');

      grid.appendChild(card);
    });
  }

  async function loadStaffAdmins() {
    const data = await postNui('getStaffAdmins', {});
    const list = (data && data.admins) || [];
    state.staffAdminsList = list;
    const warn = document.getElementById('adm-staff-warn');
    if (warn) {
      if (data && data.fetchWarning === 'discord_api_unavailable') {
        warn.classList.remove('adm-view--hidden');
        warn.textContent =
          'Could not fetch the full list from Discord. Showing only records stored in the database.';
      } else {
        warn.classList.add('adm-view--hidden');
        warn.textContent = '';
      }
    }
    updateStaffStats(list);
    renderStaffAdminsTable();
    injectIcons(document.getElementById('view-admins'));
  }

  function reportTypeLabel(t) {
    const m = { bug: 'Bug', player: 'Player', question: 'Question', response: 'New message' };
    return m[t] || t || '—';
  }

  function reportStatusLabel(s) {
    const m = {
      open: 'Open',
      claimed: 'Claimed',
      resolved: 'Resolved',
      closed: 'Closed',
    };
    return m[s] || s || '—';
  }

  function reportStatusBadgeClass(s) {
    if (s === 'open') return 'adm-badge adm-badge--default';
    if (s === 'claimed') return 'adm-badge adm-badge--bounty';
    if (s === 'resolved') return 'adm-badge adm-badge--sheriff';
    return 'adm-badge adm-badge--default';
  }

  function formatBanExpire(ts) {
    if (isBanPermanentExpire(ts)) return 'Permanent';
    const t = Number(ts) || 0;
    const now = Math.floor(Date.now() / 1000);
    if (t < now) return 'Expired';
    return new Date(t * 1000).toLocaleString('en-US', { dateStyle: 'short', timeStyle: 'short' });
  }

  function unixToDatetimeLocal(sec) {
    const d = new Date((Number(sec) || 0) * 1000);
    if (isNaN(d.getTime())) return '';
    const pad = function (n) {
      return String(n).padStart(2, '0');
    };
    return (
      d.getFullYear() +
      '-' +
      pad(d.getMonth() + 1) +
      '-' +
      pad(d.getDate()) +
      'T' +
      pad(d.getHours()) +
      ':' +
      pad(d.getMinutes())
    );
  }

  function datetimeLocalToUnix(str) {
    const d = new Date(str);
    if (isNaN(d.getTime())) return Math.floor(Date.now() / 1000) + 3600;
    return Math.floor(d.getTime() / 1000);
  }

  function filterBansRows(list) {
    const q = (document.getElementById('adm-search-bans')?.value || '').trim().toLowerCase();
    return (list || []).filter(function (b) {
      if (!q) return true;
      const blob = [b.name, b.license, b.discord, b.reason, b.bannedby, String(b.id)]
        .join(' ')
        .toLowerCase();
      return blob.includes(q);
    });
  }

  function updateBansStats(list) {
    const el = document.getElementById('adm-bans-stat-total');
    if (el) el.textContent = String((list || []).length);
  }

  function clearBanDetailPanel() {
    state.selectedBanId = null;
    const ov = document.getElementById('adm-ban-detail-overlay');
    if (ov) ov.classList.add('adm-modal-overlay--hidden');
    document.querySelectorAll('#adm-tbody-bans tr').forEach(function (tr) {
      tr.classList.remove('adm-table__row--selected');
    });
  }

  function setBanDetailAvatar(b) {
    const img = document.getElementById('adm-ban-detail-avatar');
    if (!img) return;
    const name = (b.name || '').trim() || '?';
    const initial = name.charAt(0).toUpperCase();
    img.alt = name;
    const fallbackSvg =
      'data:image/svg+xml,' +
      encodeURIComponent(
        '<svg xmlns="http://www.w3.org/2000/svg" width="56" height="56"><rect fill="%23333" width="56" height="56" rx="28"/><text x="50%" y="52%" dominant-baseline="middle" text-anchor="middle" fill="%23ccc" font-size="22" font-family="sans-serif">' +
          initial +
          '</text></svg>'
      );
    if (b.avatarUrl) {
      img.src = b.avatarUrl;
      img.style.display = '';
      img.onerror = function () {
        img.onerror = null;
        img.src = fallbackSvg;
      };
    } else {
      img.src = fallbackSvg;
      img.style.display = '';
    }
  }

  function populateBanDetailModal(b) {
    document.getElementById('adm-ban-detail-title').textContent = b.name || 'Ban';
    document.getElementById('adm-ban-detail-sub').textContent =
      '#' + String(b.id) + (b.license ? ' · ' + String(b.license).slice(0, 24) : '');
    setBanDetailAvatar(b);
    document.getElementById('adm-ban-meta-license').textContent = b.license || '—';
    document.getElementById('adm-ban-meta-discord').textContent = b.discord || '—';
    document.getElementById('adm-ban-meta-ip').textContent = b.ip || '—';
    document.getElementById('adm-ban-input-reason').value = b.reason || '';

    const perm = isBanPermanentExpire(b.expire);
    const chk = document.getElementById('adm-ban-check-permanent');
    const dt = document.getElementById('adm-ban-input-expire');
    chk.checked = perm;
    dt.value = perm ? '' : unixToDatetimeLocal(b.expire);
    syncBanDetailPermissions();
  }

  function selectBan(banId) {
    state.selectedBanId = banId;
    renderBansTable();
    const b = state.bansList.find(function (x) {
      return Number(x.id) === Number(banId);
    });
    if (!b) return;
    populateBanDetailModal(b);
    document.getElementById('adm-ban-detail-overlay').classList.remove('adm-modal-overlay--hidden');
  }

  function renderBansTable() {
    const tbody = document.getElementById('adm-tbody-bans');
    const empty = document.getElementById('adm-bans-empty');
    if (!tbody) return;

    const rows = filterBansRows(state.bansList);
    tbody.innerHTML = '';

    if (rows.length === 0) {
      empty.classList.add('adm-table-empty--visible');
      return;
    }
    empty.classList.remove('adm-table-empty--visible');

    rows.forEach(function (b) {
      const tr = document.createElement('tr');
      tr.dataset.banRow = '1';
      tr.dataset.banId = String(b.id);
      if (state.selectedBanId != null && Number(state.selectedBanId) === Number(b.id)) {
        tr.classList.add('adm-table__row--selected');
      }
      const name = b.name || '—';
      const initial = name.trim().charAt(0).toUpperCase() || '?';
      let avatarCell;
      if (b.avatarUrl) {
        avatarCell =
          '<td class="adm-ban-avatar-cell"><img src="' +
          escapeHtml(b.avatarUrl) +
          '" alt="" loading="lazy" /></td>';
      } else {
        avatarCell =
          '<td class="adm-ban-avatar-cell"><span class="adm-ban-avatar-fallback">' +
          escapeHtml(initial) +
          '</span></td>';
      }
      tr.innerHTML = [
        avatarCell,
        '<td>' + escapeHtml(name) + '</td>',
        '<td>' + escapeHtml(formatBanExpire(b.expire)) + '</td>',
        '<td>' + escapeHtml((b.reason || '').slice(0, 80)) + ((b.reason || '').length > 80 ? '…' : '') + '</td>',
        '<td>' + escapeHtml(b.bannedby || '—') + '</td>',
      ].join('');
      tbody.appendChild(tr);
    });

    tbody.querySelectorAll('tr[data-ban-row]').forEach(function (tr) {
      tr.addEventListener('click', function () {
        const id = Number(tr.dataset.banId);
        selectBan(id);
      });
    });
  }

  async function loadBansList() {
    const res = await postNui('getBans', {});
    if (!res || res.denied || !res.ok) {
      state.bansList = [];
      updateBansStats([]);
      renderBansTable();
      clearBanDetailPanel();
      return;
    }
    state.bansList = Array.isArray(res.bans) ? res.bans : [];
    updateBansStats(state.bansList);
    renderBansTable();
    if (state.selectedBanId != null) {
      const still = state.bansList.some(function (b) {
        return Number(b.id) === Number(state.selectedBanId);
      });
      if (!still) {
        clearBanDetailPanel();
      } else {
        const b = state.bansList.find(function (x) {
          return Number(x.id) === Number(state.selectedBanId);
        });
        if (b) populateBanDetailModal(b);
      }
    }
  }

  async function loadBansView() {
    const denied = document.getElementById('adm-bans-denied');
    const main = document.getElementById('adm-bans-main');
    if (!canViewBans()) {
      if (denied) denied.classList.remove('adm-view--hidden');
      if (main) main.classList.add('adm-view--hidden');
      return;
    }
    if (denied) denied.classList.add('adm-view--hidden');
    if (main) main.classList.remove('adm-view--hidden');
    const offlineBtn = document.getElementById('adm-btn-ban-offline');
    if (offlineBtn) offlineBtn.classList.toggle('adm-view--hidden', !allowed('ban'));
    await loadBansList();
    injectIcons(document.getElementById('view-bans'));
  }

  async function ensureItemsCatalog(forceRefetch) {
    const viewRoot = document.getElementById('view-items');
    if (!forceRefetch && state.itemsCatalog && state.itemsCatalog.length > 0) {
      renderItemsGrid('self');
      if (viewRoot) injectIcons(viewRoot);
      return;
    }
    const list = await postNui('getItems', {});
    state.itemsCatalog = Array.isArray(list) ? list : [];
    const inp = document.getElementById('adm-search-items');
    if (inp) inp.value = '';
    state.itemsSearchQuery = '';
    state.itemsVisibleCount = ITEMS_PAGE_SIZE;
    renderItemsGrid('self');
    if (viewRoot) injectIcons(viewRoot);
  }

  function getFilteredItems(mode) {
    mode = mode || 'self';
    const q =
      (mode === 'give' ? state.giveItemSearchQuery : state.itemsSearchQuery || '').trim().toLowerCase();
    const all = state.itemsCatalog || [];
    if (!q) return all;
    return all.filter(function (it) {
      const label = (it.label || '').toLowerCase();
      const name = (it.name || '').toLowerCase();
      const desc = (it.description || '').toLowerCase();
      return label.includes(q) || name.includes(q) || desc.includes(q);
    });
  }

  async function openGiveItemToPlayerModal(playerId, playerRow) {
    state.giveItemTargetId = playerId;
    state.giveItemSearchQuery = '';
    state.giveItemVisibleCount = ITEMS_PAGE_SIZE;
    const searchInp = document.getElementById('adm-give-item-search');
    if (searchInp) searchInp.value = '';
    const title = document.getElementById('adm-give-item-title');
    const sub = document.getElementById('adm-give-item-subtitle');
    const displayName = playerRow ? playerRow.charName || playerRow.name || 'Player' : 'Player';
    if (title) title.textContent = 'Give item';
    if (sub) {
      sub.textContent = displayName + ' · ID ' + playerId;
    }
    if (!state.itemsCatalog || state.itemsCatalog.length === 0) {
      const list = await postNui('getItems', {});
      state.itemsCatalog = Array.isArray(list) ? list : [];
    }
    const ov = document.getElementById('adm-give-item-overlay');
    if (ov) {
      ov.classList.remove('adm-modal-overlay--hidden');
      ov.setAttribute('aria-hidden', 'false');
    }
    renderItemsGrid('give');
    injectIcons(document.getElementById('adm-give-item-overlay'));
  }

  function closeGiveItemToPlayerModal(reopenPlayerActions) {
    const ov = document.getElementById('adm-give-item-overlay');
    if (ov) {
      ov.classList.add('adm-modal-overlay--hidden');
      ov.setAttribute('aria-hidden', 'true');
    }
    const pid = state.giveItemTargetId;
    state.giveItemTargetId = null;
    if (reopenPlayerActions && pid != null) {
      openActionModal(pid);
    }
  }

  function renderItemsGrid(mode) {
    mode = mode || 'self';
    const isGive = mode === 'give';
    const grid = document.getElementById(isGive ? 'adm-give-item-grid' : 'adm-items-grid');
    const meta = document.getElementById(isGive ? 'adm-give-item-meta' : 'adm-items-meta');
    const loadWrap = document.getElementById(isGive ? 'adm-give-item-load-wrap' : 'adm-items-load-wrap');
    const loadBtn = document.getElementById(isGive ? 'adm-give-item-load-more' : 'adm-items-load-more');
    const loadHint = document.getElementById(isGive ? 'adm-give-item-load-hint' : 'adm-items-load-hint');
    if (!grid) return;
    const filtered = getFilteredItems(mode);
    const total = (state.itemsCatalog || []).length;
    const visCount = isGive ? state.giveItemVisibleCount : state.itemsVisibleCount;
    const vis = Math.min(visCount || ITEMS_PAGE_SIZE, filtered.length);
    const slice = filtered.slice(0, vis);
    const shown = slice.length;
    const hasMore = filtered.length > shown;

    if (meta) {
      if (total === 0) {
        meta.textContent = '';
      } else if (filtered.length === total) {
        meta.textContent =
          'Showing ' + shown + ' of ' + total + (hasMore ? ' - Load more' : '');
      } else {
        meta.textContent =
          'Showing ' +
          shown +
          ' of ' +
          filtered.length +
          ' (filter) - ' +
          total +
          ' in catalog' +
          (hasMore ? ' - Load more' : '');
      }
    }

    if (loadWrap) {
      loadWrap.classList.toggle('adm-view--hidden', !hasMore);
    }
    if (loadHint && loadBtn) {
      const rest = filtered.length - shown;
      loadHint.textContent = hasMore ? '(' + rest + ' left to load)' : '';
    }

    const canGive = allowed('giveitem');
    grid.innerHTML = '';
    if (filtered.length === 0) {
      if (loadWrap) loadWrap.classList.add('adm-view--hidden');
      const empty = document.createElement('p');
      empty.className = 'adm-items-empty';
      empty.textContent = total === 0 ? 'No items found in core.' : 'No results for this search.';
      grid.appendChild(empty);
      return;
    }

    slice.forEach(function (it) {
      const card = document.createElement('article');
      card.className = 'adm-item-card';
      card.setAttribute('role', 'listitem');

      const fig = document.createElement('div');
      fig.className = 'adm-item-card__media';
      const img = document.createElement('img');
      img.className = 'adm-item-card__img';
      img.alt = '';
      img.loading = 'lazy';
      img.decoding = 'async';
      fig.appendChild(img);
      attachCatalogCardImage(fig, img, it, 'item');

      const body = document.createElement('div');
      body.className = 'adm-item-card__body';
      const title = document.createElement('h3');
      title.className = 'adm-item-card__title';
      title.textContent = it.label || it.name;
      const sub = document.createElement('p');
      sub.className = 'adm-item-card__id';
      sub.textContent = it.name;
      body.appendChild(title);
      body.appendChild(sub);

      if (canGive) {
        const row = document.createElement('div');
        row.className = 'adm-item-card__actions';
        const num = document.createElement('input');
        num.type = 'number';
        num.className = 'adm-input adm-input--qty adm-input--qty-card';
        num.min = '1';
        num.max = '999999';
        num.value = '1';
        num.setAttribute('aria-label', 'Quantity');
        const btn = document.createElement('button');
        btn.type = 'button';
        btn.className = 'adm-btn adm-btn--primary adm-btn--sm adm-item-card__btn';
        btn.textContent = isGive ? 'Give' : 'Receive';
        btn.addEventListener('click', function () {
          let n = parseInt(num.value, 10);
          if (!isFinite(n) || n < 1) n = 1;
          if (isGive) {
            const tid = state.giveItemTargetId;
            if (tid == null) return;
            postNui('giveItemToPlayer', { playerId: tid, item: it.name, amount: n });
          } else {
            postNui('giveItemToSelf', { item: it.name, amount: n });
          }
        });
        row.appendChild(num);
        row.appendChild(btn);
        body.appendChild(row);
      } else {
        const hint = document.createElement('p');
        hint.className = 'adm-item-card__locked';
        hint.textContent = 'No permission to receive items (Give item).';
        body.appendChild(hint);
      }

      card.appendChild(fig);
      card.appendChild(body);
      grid.appendChild(card);
    });
  }

  async function ensureWeaponsCatalog(forceRefetch) {
    const viewRoot = document.getElementById('view-weapons');
    if (!forceRefetch && state.weaponsCatalog && state.weaponsCatalog.length > 0) {
      renderWeaponsGrid();
      if (viewRoot) injectIcons(viewRoot);
      return;
    }
    const list = await postNui('getWeapons', {});
    state.weaponsCatalog = Array.isArray(list) ? list : [];
    const inp = document.getElementById('adm-search-weapons');
    if (inp) inp.value = '';
    state.weaponsSearchQuery = '';
    state.weaponsVisibleCount = ITEMS_PAGE_SIZE;
    renderWeaponsGrid();
    if (viewRoot) injectIcons(viewRoot);
  }

  function getFilteredWeapons() {
    const q = (state.weaponsSearchQuery || '').trim().toLowerCase();
    const all = state.weaponsCatalog || [];
    if (!q) return all;
    return all.filter(function (w) {
      const label = (w.label || '').toLowerCase();
      const name = (w.name || '').toLowerCase();
      const desc = (w.description || '').toLowerCase();
      return label.includes(q) || name.includes(q) || desc.includes(q);
    });
  }

  function renderWeaponsGrid() {
    const grid = document.getElementById('adm-weapons-grid');
    const meta = document.getElementById('adm-weapons-meta');
    const loadWrap = document.getElementById('adm-weapons-load-wrap');
    const loadBtn = document.getElementById('adm-weapons-load-more');
    const loadHint = document.getElementById('adm-weapons-load-hint');
    if (!grid) return;
    const filtered = getFilteredWeapons();
    const total = (state.weaponsCatalog || []).length;
    const visCount = state.weaponsVisibleCount;
    const vis = Math.min(visCount || ITEMS_PAGE_SIZE, filtered.length);
    const slice = filtered.slice(0, vis);
    const shown = slice.length;
    const hasMore = filtered.length > shown;

    if (meta) {
      if (total === 0) {
        meta.textContent = '';
      } else if (filtered.length === total) {
        meta.textContent =
          'Showing ' + shown + ' of ' + total + (hasMore ? ' - Load more' : '');
      } else {
        meta.textContent =
          'Showing ' +
          shown +
          ' of ' +
          filtered.length +
          ' (filter) - ' +
          total +
          ' in catalog' +
          (hasMore ? ' - Load more' : '');
      }
    }

    if (loadWrap) {
      loadWrap.classList.toggle('adm-view--hidden', !hasMore);
    }
    if (loadHint && loadBtn) {
      const rest = filtered.length - shown;
      loadHint.textContent = hasMore ? '(' + rest + ' remaining)' : '';
    }

    const canReceive = allowed('giveitem');
    grid.innerHTML = '';
    if (filtered.length === 0) {
      if (loadWrap) loadWrap.classList.add('adm-view--hidden');
      const empty = document.createElement('p');
      empty.className = 'adm-items-empty';
      empty.textContent =
        total === 0
          ? state.framework === 'vorp'
            ? 'No weapons in catalog (VORP: vorp_inventory/config/weapons.lua).'
            : 'No weapons in catalog (RSG: rsg-core/shared/weapons.lua).'
          : 'No results for this search.';
      grid.appendChild(empty);
      return;
    }

    slice.forEach(function (w) {
      const card = document.createElement('article');
      card.className = 'adm-item-card';
      card.setAttribute('role', 'listitem');

      const fig = document.createElement('div');
      fig.className = 'adm-item-card__media';
      const img = document.createElement('img');
      img.className = 'adm-item-card__img';
      img.alt = '';
      img.loading = 'lazy';
      img.decoding = 'async';
      fig.appendChild(img);
      attachCatalogCardImage(fig, img, w, 'weapon');

      const body = document.createElement('div');
      body.className = 'adm-item-card__body';
      const title = document.createElement('h3');
      title.className = 'adm-item-card__title';
      title.textContent = w.label || w.name;
      const sub = document.createElement('p');
      sub.className = 'adm-item-card__id';
      sub.textContent = w.name;
      body.appendChild(title);
      body.appendChild(sub);

      if (canReceive) {
        const row = document.createElement('div');
        row.className = 'adm-item-card__actions';
        const btn = document.createElement('button');
        btn.type = 'button';
        btn.className = 'adm-btn adm-btn--primary adm-btn--sm adm-item-card__btn';
        btn.textContent = 'Receive';
        btn.addEventListener('click', function () {
          postNui('giveWeaponToSelf', { weapon: w.name });
        });
        row.appendChild(btn);
        body.appendChild(row);
      } else {
        const hint = document.createElement('p');
        hint.className = 'adm-item-card__locked';
        hint.textContent = 'No permission to receive weapons (Give item).';
        body.appendChild(hint);
      }

      card.appendChild(fig);
      card.appendChild(body);
      grid.appendChild(card);
    });
  }

  function renderTeleports() {
    const grid = document.getElementById('adm-teleports-grid');
    const empty = document.getElementById('adm-teleports-empty');
    const createBtn = document.getElementById('adm-teleports-create');
    const editBtn = document.getElementById('adm-teleports-edit');
    const createBox = document.getElementById('adm-teleport-create-box');
    const canCreateTeleport = allowed('createteleport') || allowed('teleport');
    const canDeleteTeleport = allowed('deleteteleport') || allowed('createteleport');
    const canSetTeleportImage = allowed('deleteteleport') || allowed('createteleport');
    if (!grid) return;
    if (createBtn) {
      createBtn.classList.toggle('adm-view--hidden', !canCreateTeleport);
      createBtn.disabled = !canCreateTeleport;
    }
    if (editBtn) {
      editBtn.classList.toggle('adm-view--hidden', !canDeleteTeleport);
      editBtn.disabled = !canDeleteTeleport;
      editBtn.classList.toggle('adm-teleports-edit-btn--active', !!state.teleportEditMode);
      editBtn.textContent = state.teleportEditMode ? 'Done editing' : 'Edit';
    }
    if (createBox && !canCreateTeleport) {
      createBox.classList.add('adm-view--hidden');
    }
    const list = state.teleportPresets || [];
    grid.innerHTML = '';
    if (!list.length) {
      if (empty) empty.classList.remove('adm-view--hidden');
      return;
    }
    if (empty) empty.classList.add('adm-view--hidden');

    list.forEach(function (p) {
      const card = document.createElement('article');
      card.className = 'adm-teleport-card';
      card.setAttribute('role', 'listitem');

      const media = document.createElement('div');
      media.className = 'adm-teleport-card__media';
      if (canSetTeleportImage) {
        media.classList.add('adm-teleport-card__media--clickable');
        media.setAttribute('title', 'Click to set the image link');
      }

      function addFallbackLetter() {
        media.classList.add('adm-teleport-card__media--fallback');
        if (media.querySelector('.adm-teleport-card__ph')) return;
        const ph = document.createElement('span');
        ph.className = 'adm-teleport-card__ph';
        ph.textContent = (p.label || p.id || '?').charAt(0).toUpperCase();
        media.appendChild(ph);
      }

      function closeAllTeleportImageEditors() {
        document.querySelectorAll('.adm-teleport-card__media-editor').forEach(function (el) {
          el.classList.add('adm-view--hidden');
        });
      }

      const rawImage = p.image && String(p.image).trim();
      const isRemoteImage = rawImage && /^https?:\/\//i.test(rawImage);
      const isLocalImage = rawImage && !isRemoteImage && rawImage.indexOf('://') === -1;

      if (isRemoteImage || isLocalImage) {
        const img = document.createElement('img');
        img.className = 'adm-teleport-card__img';
        img.alt = '';
        img.loading = 'lazy';
        img.src = nuiHtmlAssetUrl(rawImage);
        img.addEventListener('error', function onImgErr() {
          img.removeEventListener('error', onImgErr);
          img.remove();
          addFallbackLetter();
        });
        media.appendChild(img);
      } else {
        addFallbackLetter();
      }

      if (canSetTeleportImage) {
        const editor = document.createElement('div');
        editor.className = 'adm-teleport-card__media-editor adm-view--hidden';
        editor.setAttribute('role', 'dialog');
        editor.setAttribute('aria-label', 'Image URL');
        const editorInner = document.createElement('div');
        editorInner.className = 'adm-teleport-card__media-editor-inner';
        const lab = document.createElement('label');
        lab.className = 'adm-label adm-teleport-card__media-editor-label';
        lab.setAttribute('for', 'adm-tp-img-' + String(p.id).replace(/[^a-zA-Z0-9_-]/g, ''));
        lab.textContent = 'Image URL (https)';
        const inp = document.createElement('input');
        inp.type = 'url';
        inp.className = 'adm-input adm-input--block';
        inp.id = 'adm-tp-img-' + String(p.id).replace(/[^a-zA-Z0-9_-]/g, '');
        inp.placeholder = 'https://…';
        inp.autocomplete = 'off';
        inp.value = isRemoteImage ? rawImage : '';
        const row = document.createElement('div');
        row.className = 'adm-teleport-card__media-editor-actions';
        const saveBtn = document.createElement('button');
        saveBtn.type = 'button';
        saveBtn.className = 'adm-btn adm-btn--primary adm-btn--sm';
        saveBtn.textContent = 'Save';
        const clearBtn = document.createElement('button');
        clearBtn.type = 'button';
        clearBtn.className = 'adm-btn adm-btn--ghost adm-btn--sm';
        clearBtn.textContent = 'Remove';
        const cancelBtn = document.createElement('button');
        cancelBtn.type = 'button';
        cancelBtn.className = 'adm-btn adm-btn--ghost adm-btn--sm';
        cancelBtn.textContent = 'Cancel';
        function closeEditor() {
          editor.classList.add('adm-view--hidden');
          inp.value = isRemoteImage ? rawImage : '';
        }
        cancelBtn.addEventListener('click', function (ev) {
          ev.stopPropagation();
          closeEditor();
        });
        clearBtn.addEventListener('click', function (ev) {
          ev.stopPropagation();
          inp.value = '';
        });
        saveBtn.addEventListener('click', function (ev) {
          ev.stopPropagation();
          const v = inp.value ? inp.value.trim() : '';
          if (v !== '' && !/^https?:\/\//i.test(v)) {
            notifyGame('Teleports', 'Use a full URL starting with http:// or https://', 'error');
            return;
          }
          postNui('updateTeleportPresetImage', { presetId: p.id, image: v }).then(async function (res) {
            if (!res || !res.ok) {
              const err = res && res.error;
              let msg = 'Could not save image.';
              if (err === 'too_long') msg = 'URL is too long (max 255 characters).';
              else if (err === 'invalid_url') msg = 'Invalid URL.';
              else if (err === 'denied') msg = 'No permission.';
              await notifyGame('Teleports', msg, 'error');
              return;
            }
            closeEditor();
            await notifyGame('Teleports', v ? 'Image saved.' : 'Image removed.', 'success');
            await refreshTeleportPresets();
          });
        });
        row.appendChild(saveBtn);
        row.appendChild(clearBtn);
        row.appendChild(cancelBtn);
        editorInner.appendChild(lab);
        editorInner.appendChild(inp);
        editorInner.appendChild(row);
        editor.appendChild(editorInner);
        editor.addEventListener('click', function (ev) {
          if (ev.target === editor) closeEditor();
        });
        media.appendChild(editor);

        media.addEventListener('click', function (ev) {
          if (!editor.classList.contains('adm-view--hidden')) return;
          if (ev.target.closest('.adm-teleport-card__media-editor')) return;
          closeAllTeleportImageEditors();
          editor.classList.remove('adm-view--hidden');
          inp.focus();
          inp.select();
        });
      }

      const body = document.createElement('div');
      body.className = 'adm-teleport-card__body';
      const title = document.createElement('h3');
      title.className = 'adm-teleport-card__title';
      title.textContent = p.label || String(p.id);
      const btn = document.createElement('button');
      btn.type = 'button';
      btn.className = 'adm-btn adm-btn--primary adm-btn--block adm-teleport-card__btn';
      btn.textContent = 'Teleport';
      btn.addEventListener('click', function () {
        postNui('action', { action: 'teleportPreset', presetId: p.id });
      });
      const delBtn = document.createElement('button');
      delBtn.type = 'button';
      delBtn.className = 'adm-btn adm-btn--ghost adm-btn--block adm-teleport-card__btn adm-teleport-card__btn--delete';
      delBtn.textContent = 'Delete';
      delBtn.disabled = !canDeleteTeleport;
      delBtn.classList.toggle('adm-view--hidden', !state.teleportEditMode);
      delBtn.addEventListener('click', function () {
        if (!canDeleteTeleport) return;
        openDangerConfirm({
          title: 'Delete teleport',
          text: 'Really delete "' + String(p.label || p.id) + '"?',
          onConfirm: function () {
            postNui('deleteTeleportPreset', { presetId: p.id }).then(async function (res) {
              if (!res || !res.ok) {
                await notifyGame('Teleports', 'Could not delete teleport.', 'error');
                return;
              }
              await notifyGame('Teleports', 'Teleport deleted.', 'success');
              await refreshTeleportPresets();
            });
          },
        });
      });
      body.appendChild(title);
      body.appendChild(btn);
      body.appendChild(delBtn);
      card.appendChild(media);
      card.appendChild(body);
      grid.appendChild(card);
    });
  }

  async function refreshTeleportPresets() {
    try {
      const meta = await postNui('getMenuMetaRefresh', {});
      if (meta && meta.denied === true) {
        return;
      }
      state.teleportPresets = Array.isArray(meta && meta.teleportPresets) ? meta.teleportPresets : [];
      if (meta && meta.framework) {
        state.framework = meta.framework === 'vorp' ? 'vorp' : 'rsg';
      }
      if (meta && meta.navVisibility && typeof meta.navVisibility === 'object') {
        state.navVisibility = meta.navVisibility;
        applySidebarPermissionVisibility();
      }
      if (meta && meta.liveMap && typeof meta.liveMap === 'object') {
        state.liveMapBounds = meta.liveMap;
      }
      if (state.currentView === 'teleports') {
        renderTeleports();
      }
    } catch (e) {}
  }

  async function createTeleportFromCurrentPosition() {
    if (!(allowed('createteleport') || allowed('teleport'))) return;
    const nameInput = document.getElementById('adm-teleport-create-name');
    const label = nameInput && nameInput.value ? nameInput.value.trim() : '';
    if (!label) return;
    const coords = await postNui('getCoords', {});
    if (!coords || coords.x == null || coords.y == null || coords.z == null) {
      await notifyGame('Teleports', 'Could not read current coordinates.', 'error');
      return;
    }
    const res = await postNui('createTeleportPreset', {
      label: label,
      x: Number(coords.x),
      y: Number(coords.y),
      z: Number(coords.z),
      w: Number(coords.h) || 0,
    });
    if (!res || !res.ok) {
      await notifyGame('Teleports', 'Could not create teleport.', 'error');
      return;
    }
    if (nameInput) nameInput.value = '';
    closeTeleportCreateBox();
    await notifyGame('Teleports', 'Teleport created.', 'success');
    await refreshTeleportPresets();
  }

  function openTeleportCreateBox() {
    const box = document.getElementById('adm-teleport-create-box');
    const input = document.getElementById('adm-teleport-create-name');
    if (!box) return;
    box.classList.remove('adm-view--hidden');
    if (input) input.focus();
  }

  function closeTeleportCreateBox() {
    const box = document.getElementById('adm-teleport-create-box');
    const input = document.getElementById('adm-teleport-create-name');
    if (box) box.classList.add('adm-view--hidden');
    if (input) input.value = '';
  }

  function resolveCommandIcon(key) {
    if (key && ICON_MAP[key]) return key;
    return 'map-pin';
  }

  function isCommandToggleActive(toggleKey) {
    if (!toggleKey || !state.commandToggles || typeof state.commandToggles !== 'object') return false;
    return state.commandToggles[toggleKey] === true;
  }

  function renderQuickCommandsPanel() {
    const grid = document.getElementById('adm-commands-grid');
    if (!grid) return;

    const cfg = state.menuConfig || {};
    const parts = [];

    const builtins = [
      { action: 'teleport', label: 'TP to waypoint', hint: 'Go to map waypoint', icon: 'map-pin', toggleKey: null },
      { action: 'selfRevive', label: 'Revive', hint: 'Revive your character', icon: 'heart', toggleKey: null },
      { action: 'noClip', label: 'NoClip', hint: 'Built-in fly mode (MX-Admin, no txAdmin)', icon: 'bolt', toggleKey: null },
      { action: 'godMode', label: 'God mode', hint: 'Click again to turn off', icon: 'settings', toggleKey: 'godMode' },
      { action: 'invisible', label: 'Invisible', hint: 'Click again to turn off', icon: 'eye-off', toggleKey: 'invisible' },
      {
        action: 'playerBlips',
        label: 'Map blips',
        hint: 'Click again to turn off',
        icon: 'flag',
        toggleKey: 'playerBlips',
        requireBlips: true,
      },
    ];

    builtins.forEach(function (it) {
      if (it.requireBlips && !cfg.enablePlayerBlips) return;
      const tk = it.toggleKey;
      const active = isCommandToggleActive(tk);
      let cls = 'adm-command-tile';
      if (tk) cls += ' adm-command-tile--toggle';
      if (active) cls += ' adm-command-tile--active';
      const ariaPressed = tk ? ' aria-pressed="' + (active ? 'true' : 'false') + '"' : '';
      parts.push(
        '<button type="button" class="' +
          cls +
          '" role="listitem" data-action="' +
          escapeAttr(it.action) +
          '"' +
          ariaPressed +
          '>' +
          '<span class="adm-command-tile__icon" data-icon="' +
          escapeAttr(resolveCommandIcon(it.icon)) +
          '"></span>' +
          '<span class="adm-command-tile__body">' +
          '<span class="adm-command-tile__label">' +
          escapeHtml(it.label) +
          (active ? ' · on' : '') +
          '</span>' +
          '<span class="adm-command-tile__hint">' +
          escapeHtml(it.hint) +
          '</span>' +
          '</span></button>'
      );
    });

    (cfg.quickExecuteCommands || []).forEach(function (e) {
      if (!e || typeof e.command !== 'string' || !e.command.trim()) return;
      const cmdTrim = e.command.trim();
      const label = (e.label && String(e.label).trim()) || cmdTrim;
      const icon = resolveCommandIcon(typeof e.icon === 'string' ? e.icon : 'layers');
      const isWall = cmdTrim === 'rsg-adminmenu:quick:playerwall';
      const tk = isWall ? 'playerWall' : null;
      const active = isCommandToggleActive(tk);
      let cls = 'adm-command-tile adm-command-tile--extra';
      if (tk) cls += ' adm-command-tile--toggle';
      if (active) cls += ' adm-command-tile--active';
      const ariaPressed = tk ? ' aria-pressed="' + (active ? 'true' : 'false') + '"' : '';
      const hint = isWall ? 'Click again to turn off 3D text' : cmdTrim;
      parts.push(
        '<button type="button" class="' +
          cls +
          '" role="listitem" data-exec-command="' +
          escapeAttr(cmdTrim) +
          '"' +
          ariaPressed +
          '>' +
          '<span class="adm-command-tile__icon" data-icon="' +
          escapeAttr(icon) +
          '"></span>' +
          '<span class="adm-command-tile__body">' +
          '<span class="adm-command-tile__label">' +
          escapeHtml(label) +
          (active ? ' · on' : '') +
          '</span>' +
          '<span class="adm-command-tile__hint">' +
          escapeHtml(hint) +
          '</span>' +
          '</span></button>'
      );
    });

    grid.innerHTML = parts.join('');
    applyScreenAnnounceConfigToForm();
    syncCommandsAnnouncePanel();
  }

  function applyScreenAnnounceConfigToForm() {
    const sc = (state.menuConfig && state.menuConfig.screenAnnounce) || {};
    const maxMsg = Math.min(600, Math.max(80, Number(sc.MaxMessageLength) || 280));
    const maxTit = Math.min(80, Math.max(0, Number(sc.MaxTitleLength) || 48));
    const ti = document.getElementById('adm-announce-title');
    const ta = document.getElementById('adm-announce-message');
    if (ti) {
      ti.maxLength = maxTit;
      if (maxTit <= 0) {
        ti.value = '';
        ti.disabled = true;
      } else {
        ti.disabled = false;
      }
    }
    if (ta) ta.maxLength = maxMsg;
  }

  function syncCommandsAnnouncePanel() {
    const box = document.getElementById('adm-commands-announce');
    if (!box) return;
    box.classList.toggle('adm-view--hidden', !allowed('broadcastannounce'));
  }

  function showScreenAnnounceOverlay(payload) {
    const root = document.getElementById('adm-screen-announce-root');
    const card = document.getElementById('adm-screen-announce-card');
    const elTitle = document.getElementById('adm-screen-announce-title');
    const elBody = document.getElementById('adm-screen-announce-body');
    const elEyebrow = document.getElementById('adm-screen-announce-eyebrow');
    if (!root || !card || !elTitle || !elBody) return;

    if (state.screenAnnounceHideTimer != null) {
      clearTimeout(state.screenAnnounceHideTimer);
      state.screenAnnounceHideTimer = null;
    }

    const st = payload.style === 'urgent' || payload.style === 'info' ? payload.style : 'default';
    card.className = 'adm-screen-announce adm-screen-announce--' + st;

    const title = (payload.title && String(payload.title).trim()) || '';
    const msg = payload.message != null ? String(payload.message) : '';
    const staff = (payload.staffName && String(payload.staffName).trim()) || '';

    const iconEl = document.getElementById('adm-screen-announce-title-icon');
    if (iconEl) {
      const iconKey =
        st === 'info' ? 'announce-info' : st === 'urgent' ? 'announce-urgent' : 'announce-default';
      iconEl.setAttribute('data-icon', iconKey);
    }

    const elTw = document.getElementById('adm-screen-announce-textwrap');
    if (title) {
      elTitle.textContent = title;
      elTitle.classList.remove('adm-view--hidden');
    } else {
      elTitle.textContent = '';
      elTitle.classList.add('adm-view--hidden');
    }
    elBody.textContent = msg;
    if (elEyebrow) {
      elEyebrow.textContent = staff ? 'Staff: ' + staff : '';
      elEyebrow.classList.toggle('adm-view--hidden', !staff);
    }
    if (elTw) {
      elTw.classList.toggle('adm-screen-announce__textwrap--has-staff', !!staff);
    }

    injectIcons(card);

    root.classList.remove('adm-screen-announce-root--hidden');
    root.classList.add('adm-screen-announce-root--visible');

    let ms = Number(payload.durationMs);
    if (!Number.isFinite(ms)) ms = 8000;
    ms = Math.max(2000, Math.min(180000, ms));

    state.screenAnnounceHideTimer = setTimeout(function () {
      root.classList.add('adm-screen-announce-root--hidden');
      root.classList.remove('adm-screen-announce-root--visible');
      state.screenAnnounceHideTimer = null;
    }, ms);
  }

  function wireScreenAnnounceForm() {
    const btn = document.getElementById('adm-announce-send');
    if (!btn || btn.dataset.wired === '1') return;
    btn.dataset.wired = '1';
    btn.addEventListener('click', async function () {
      if (!allowed('broadcastannounce')) return;
      const titleEl = document.getElementById('adm-announce-title');
      const msgEl = document.getElementById('adm-announce-message');
      const durEl = document.getElementById('adm-announce-duration');
      const styleEl = document.getElementById('adm-announce-style');
      const message = msgEl ? msgEl.value.trim() : '';
      if (!message) {
        await notifyGame('Commands', 'Enter an announcement message.', 'error', 2500);
        return;
      }
      const res = await postNui('broadcastScreenAnnounce', {
        title: titleEl && !titleEl.disabled ? titleEl.value.trim() : '',
        message: message,
        durationMs: durEl ? Number(durEl.value) || 8000 : 8000,
        style: styleEl ? String(styleEl.value || 'default') : 'default',
      });
      if (res && res.ok) {
        await notifyGame('Commands', 'Announcement sent.', 'success', 2200);
      } else {
        await notifyGame('Commands', 'Could not send.', 'error', 2500);
      }
    });
  }

  function refreshCommandsViewIfOpen() {
    if (state.currentView !== 'commands') return;
    renderQuickCommandsPanel();
    injectIcons(document.getElementById('view-commands'));
  }

  function wireQuickCommandsPanel() {
    const grid = document.getElementById('adm-commands-grid');
    if (!grid || grid.dataset.wired === '1') return;
    grid.dataset.wired = '1';
    grid.addEventListener('click', async function (e) {
      const btn = e.target && e.target.closest('.adm-command-tile');
      if (!btn) return;
      const exec = btn.getAttribute('data-exec-command');
      if (exec) {
        const res = await postNui('action', { action: 'executeQuickCommand', command: exec });
        if (res && res.commandToggles) {
          state.commandToggles = res.commandToggles;
        }
        refreshCommandsViewIfOpen();
        if (exec === 'rsg-adminmenu:quick:playerwall') {
          const on = state.commandToggles && state.commandToggles.playerWall === true;
          await notifyGame('Wall', on ? 'On.' : 'Off.', 'inform', 2800);
        } else {
          await notifyGame('Commands', 'Command executed.', 'inform', 2500);
        }
        return;
      }
      const action = btn.getAttribute('data-action');
      if (!action) return;
      const res = await postNui('action', { action: action });
      if (res && res.commandToggles) {
        state.commandToggles = res.commandToggles;
      }
      refreshCommandsViewIfOpen();
      if (res && res.closeMenu) {
        closeUi();
        return;
      }
      const toggles = ['godMode', 'invisible', 'playerBlips'];
      if (toggles.indexOf(action) >= 0 && res && res.commandToggles) {
        const on = res.commandToggles[action] === true;
        await notifyGame('Commands', on ? 'Feature on.' : 'Feature off.', 'inform', 2400);
      } else {
        await notifyGame('Commands', 'Request sent.', 'inform', 2200);
      }
    });
  }

  function resetOfflineBanForm() {
    const set = function (id, val) {
      const el = document.getElementById(id);
      if (el) el.value = val != null ? val : '';
    };
    set('adm-ban-offline-citizenid', '');
    set('adm-ban-offline-reason', '');
    const perm = document.getElementById('adm-ban-offline-permanent');
    if (perm) perm.checked = false;
    const dt = document.getElementById('adm-ban-offline-expire');
    if (dt) {
      dt.disabled = false;
      const exp = Math.floor(Date.now() / 1000) + 7 * 86400;
      dt.value = unixToDatetimeLocal(exp);
    }
  }

  function closeOfflineBanModal() {
    const ov = document.getElementById('adm-ban-offline-overlay');
    if (ov) ov.classList.add('adm-modal-overlay--hidden');
  }

  function openOfflineBanModal() {
    if (!allowed('ban')) return;
    resetOfflineBanForm();
    const ov = document.getElementById('adm-ban-offline-overlay');
    if (ov) ov.classList.remove('adm-modal-overlay--hidden');
    injectIcons(document.getElementById('adm-ban-offline-overlay'));
  }

  function filterReportsRows(list) {
    const q = (document.getElementById('adm-search-reports')?.value || '').trim().toLowerCase();
    const fil = document.getElementById('adm-filter-reports')?.value || 'all';
    return (list || []).filter(function (r) {
      if (fil !== 'all' && (r.status || '') !== fil) return false;
      if (!q) return true;
      const blob = [r.title, r.reporter_name, String(r.id), r.report_type].join(' ').toLowerCase();
      return blob.includes(q);
    });
  }

  function updateReportsStats(list) {
    let open = 0;
    let claimed = 0;
    (list || []).forEach(function (r) {
      if (r.status === 'open') open += 1;
      if (r.status === 'claimed') claimed += 1;
    });
    const elT = document.getElementById('adm-reports-stat-total');
    const elO = document.getElementById('adm-reports-stat-open');
    const elC = document.getElementById('adm-reports-stat-claimed');
    if (elT) elT.textContent = String((list || []).length);
    if (elO) elO.textContent = String(open);
    if (elC) elC.textContent = String(claimed);

    const navReportsBtn = document.getElementById('adm-nav-reports');
    const navBadge = document.getElementById('adm-reports-nav-badge');
    if (navBadge && navReportsBtn) {
      if (open > 0) {
        navBadge.textContent = open > 99 ? '99+' : String(open);
        navBadge.classList.remove('adm-view--hidden');
        navReportsBtn.classList.add('adm-nav-item--badge');
      } else {
        navBadge.classList.add('adm-view--hidden');
        navReportsBtn.classList.remove('adm-nav-item--badge');
      }
    }
  }

  function renderReportsTable() {
    const tbody = document.getElementById('adm-tbody-reports');
    const empty = document.getElementById('adm-reports-empty');
    if (!tbody) return;

    const rows = filterReportsRows(state.reportsList);
    tbody.innerHTML = '';

    if (rows.length === 0) {
      empty.classList.add('adm-table-empty--visible');
      return;
    }
    empty.classList.remove('adm-table-empty--visible');

    rows.forEach(function (r) {
      const tr = document.createElement('tr');
      tr.setAttribute('data-report-row', '1');
      tr.dataset.reportId = String(r.id);
      if (state.selectedReportId != null && Number(state.selectedReportId) === Number(r.id)) {
        tr.classList.add('adm-table__row--selected');
      }
      const st = reportStatusLabel(r.status);
      const createdShort = formatReportDate(r.created_at);
      tr.innerHTML = [
        '<td>#' + escapeHtml(String(r.id)) + '</td>',
        '<td>' + escapeHtml(reportTypeLabel(r.report_type)) + '</td>',
        '<td>' + escapeHtml((r.title || '').slice(0, 56)) + (r.title && r.title.length > 56 ? '…' : '') + '</td>',
        '<td>' + escapeHtml(r.reporter_name || '—') + '</td>',
        '<td>' + escapeHtml(createdShort) + '</td>',
        '<td><span class="' + reportStatusBadgeClass(r.status) + '">' + escapeHtml(st) + '</span></td>',
        '<td class="adm-table__cell-action">',
        '<button type="button" class="adm-btn-icon" data-report-open="' +
          escapeHtml(String(r.id)) +
          '" title="Details" aria-label="Details">',
        '<svg viewBox="0 0 24 24" width="18" height="18" fill="none" stroke="currentColor" stroke-width="2"><circle cx="12" cy="12" r="1"/><circle cx="12" cy="5" r="1"/><circle cx="12" cy="19" r="1"/></svg>',
        '</button>',
        '</td>',
      ].join('');
      tbody.appendChild(tr);
    });

    tbody.querySelectorAll('tr[data-report-row]').forEach(function (tr) {
      tr.addEventListener('click', function (e) {
        if (e.target.closest && e.target.closest('[data-report-open]')) return;
        const id = Number(tr.dataset.reportId);
        selectReport(id);
      });
    });

    tbody.querySelectorAll('[data-report-open]').forEach(function (btn) {
      btn.addEventListener('click', function (e) {
        e.stopPropagation();
        const id = Number(btn.getAttribute('data-report-open'));
        selectReport(id);
      });
    });
  }

  function clearReportDetailPanel() {
    state.selectedReportId = null;
    state.reportDetailPayload = null;
    state.lastReportDetailChatReportId = null;
    const ov = document.getElementById('adm-report-detail-overlay');
    if (ov) ov.classList.add('adm-modal-overlay--hidden');
    document.querySelectorAll('#adm-tbody-reports tr').forEach(function (tr) {
      tr.classList.remove('adm-table__row--selected');
    });
  }

  function formatReportDate(v) {
    if (v == null || v === '') return '—';
    const d = new Date(v);
    if (!isNaN(d.getTime())) {
      return d.toLocaleString('en-US', { dateStyle: 'short', timeStyle: 'short' });
    }
    return String(v);
  }

  function renderReportDetail() {
    const payload = state.reportDetailPayload;
    const ov = document.getElementById('adm-report-detail-overlay');
    if (!payload || !payload.report) {
      if (ov) ov.classList.add('adm-modal-overlay--hidden');
      return;
    }

    const rep = payload.report;
    const messages = payload.messages || [];
    const nearby = payload.nearbyPlayers || [];

    document.getElementById('adm-report-detail-title').textContent = '#' + rep.id + ' — ' + (rep.title || '');
    document.getElementById('adm-report-badge-type').textContent = reportTypeLabel(rep.report_type);
    const stEl = document.getElementById('adm-report-badge-status');
    stEl.textContent = reportStatusLabel(rep.status);
    stEl.className = reportStatusBadgeClass(rep.status);

    document.getElementById('adm-report-meta-reporter').textContent =
      (rep.reporter_name || '—') + (rep.reporter_id != null ? ' (ID ' + rep.reporter_id + ')' : '');
    document.getElementById('adm-report-meta-created').textContent = formatReportDate(rep.created_at);

    const aw = document.getElementById('adm-report-meta-assigned-wrap');
    if (rep.assigned_admin_name) {
      aw.classList.remove('adm-view--hidden');
      document.getElementById('adm-report-meta-assigned').textContent = rep.assigned_admin_name;
    } else {
      aw.classList.add('adm-view--hidden');
    }

    const rw = document.getElementById('adm-report-meta-reported-wrap');
    if (rep.reported_player_id && rep.reported_player_name) {
      rw.classList.remove('adm-view--hidden');
      document.getElementById('adm-report-meta-reported').textContent =
        rep.reported_player_name + ' (ID ' + rep.reported_player_id + ')';
    } else {
      rw.classList.add('adm-view--hidden');
    }

    document.getElementById('adm-report-description').textContent = rep.description || '—';

    const imgWrap = document.getElementById('adm-report-image-wrap');
    const imgLink = document.getElementById('adm-report-image-link');
    if (rep.image_url && String(rep.image_url).trim() !== '') {
      imgWrap.classList.remove('adm-view--hidden');
      imgLink.href = rep.image_url;
      imgLink.textContent = rep.image_url.length > 60 ? rep.image_url.slice(0, 60) + '…' : rep.image_url;
    } else {
      imgWrap.classList.add('adm-view--hidden');
    }

    const msgWrap = document.getElementById('adm-report-messages-wrap');
    const msgList = document.getElementById('adm-report-messages-list');
    msgWrap.classList.remove('adm-view--hidden');
    renderReportChatMessages(msgList, messages, { playerPerspective: false });

    if (state.lastReportDetailChatReportId !== rep.id) {
      state.lastReportDetailChatReportId = rep.id;
      const chatIn = document.getElementById('adm-report-chat-input');
      if (chatIn) chatIn.value = '';
    }

    const nbWrap = document.getElementById('adm-report-nearby-wrap');
    const nbList = document.getElementById('adm-report-nearby-list');
    if (nearby.length > 0) {
      nbWrap.classList.remove('adm-view--hidden');
      nbList.innerHTML = '';
      nearby.forEach(function (p) {
        const li = document.createElement('li');
        const pid = p.player_id;
        li.innerHTML =
          escapeHtml((p.player_name || '—') + ' · ID ' + pid + ' · ' + (p.distance != null ? Number(p.distance).toFixed(1) + ' m' : ''));
        li.style.cursor = 'pointer';
        li.title = 'Player actions (if online)';
        li.addEventListener('click', function () {
          openReportPlayerActions(Number(pid));
        });
        nbList.appendChild(li);
      });
    } else {
      nbWrap.classList.add('adm-view--hidden');
      nbList.innerHTML = '';
    }

    const canManage = allowed('managereports');
    const st = rep.status || '';
    const canView = allowed('viewreports');
    const composer = document.getElementById('adm-report-chat-composer');
    if (composer) {
      composer.classList.toggle('adm-view--hidden', !canView || st === 'closed');
    }

    const btnClaim = document.getElementById('adm-report-btn-claim');
    const btnRel = document.getElementById('adm-report-btn-release');
    const btnRes = document.getElementById('adm-report-btn-resolve');
    const btnDel = document.getElementById('adm-report-btn-delete');

    if (!canManage) {
      [btnClaim, btnRel, btnRes, btnDel].forEach(function (b) {
        b.classList.add('adm-view--hidden');
        b.onclick = null;
      });
    } else {
      btnClaim.classList.toggle('adm-view--hidden', st !== 'open');
      btnRel.classList.toggle('adm-view--hidden', st !== 'claimed');
      btnRes.classList.toggle('adm-view--hidden', st === 'resolved' || st === 'closed');
      btnDel.classList.remove('adm-view--hidden');
      const rid = rep.id;
      btnClaim.onclick = function () {
        runReportAction('claimReport', { reportId: rid });
      };
      btnRel.onclick = function () {
        runReportAction('releaseReport', { reportId: rid });
      };
      btnRes.onclick = function () {
        runReportAction('resolveReport', { reportId: rid });
      };
      btnDel.onclick = function () {
        document.getElementById('adm-report-delete-reason').value = '';
        document.getElementById('adm-report-delete-overlay').classList.remove('adm-modal-overlay--hidden');
      };
    }

    if (ov) ov.classList.remove('adm-modal-overlay--hidden');
  }

  async function openReportPlayerActions(playerId) {
    if (playerId == null || playerId === '') return;
    await refreshPlayers();
    const id = Number(playerId);
    const found = state.players.some(function (p) {
      return Number(p.id) === id;
    });
    if (!found) {
      await notifyGame(
        'Player offline',
        'This player is not online. Quick actions are only available for players in the session.',
        'inform'
      );
      return;
    }
    openActionModal(id);
  }

  async function selectReport(reportId) {
    state.selectedReportId = reportId;
    renderReportsTable();
    const res = await postNui('getReportDetails', { reportId: reportId });
    if (!res || !res.ok || !res.report) {
      state.reportDetailPayload = null;
      clearReportDetailPanel();
      return;
    }
    state.reportDetailPayload = {
      report: res.report,
      messages: res.messages || [],
      nearbyPlayers: res.nearbyPlayers || [],
    };
    renderReportDetail();
  }

  async function loadReportsList() {
    const res = await postNui('getAllReports', {});
    if (!res || res.denied || !res.ok) {
      state.reportsList = [];
      updateReportsStats([]);
      renderReportsTable();
      clearReportDetailPanel();
      return;
    }
    state.reportsList = Array.isArray(res.reports) ? res.reports : [];
    updateReportsStats(state.reportsList);
    renderReportsTable();
    if (state.selectedReportId != null) {
      const still = state.reportsList.some(function (r) {
        return Number(r.id) === Number(state.selectedReportId);
      });
      if (!still) {
        state.selectedReportId = null;
        state.reportDetailPayload = null;
        clearReportDetailPanel();
      } else {
        await selectReport(state.selectedReportId);
      }
    } else {
      clearReportDetailPanel();
    }
  }

  async function loadReportsView() {
    const denied = document.getElementById('adm-reports-denied');
    const main = document.getElementById('adm-reports-main');
    if (!allowed('viewreports')) {
      if (denied) denied.classList.remove('adm-view--hidden');
      if (main) main.classList.add('adm-view--hidden');
      return;
    }
    if (denied) denied.classList.add('adm-view--hidden');
    if (main) main.classList.remove('adm-view--hidden');
    await loadReportsList();
    injectIcons(document.getElementById('view-reports'));
  }

  async function runReportAction(action, extra) {
    await postNui('action', Object.assign({ action: action }, extra || {}));
    await loadReportsList();
  }

  function prIsCoolingDown() {
    return Date.now() < prUi.cooldownUntil;
  }

  function prUpdateCooldownBanner() {
    const el = document.getElementById('pr-cooldown-msg');
    if (!el) return;
    if (!prIsCoolingDown()) {
      el.classList.add('adm-view--hidden');
      el.textContent = '';
      if (prUi.cooldownTimer) {
        clearInterval(prUi.cooldownTimer);
        prUi.cooldownTimer = null;
      }
      return;
    }
    const s = Math.ceil((prUi.cooldownUntil - Date.now()) / 1000);
    el.classList.remove('adm-view--hidden');
    el.textContent = 'Wait ' + s + ' s before submitting another report.';
  }

  function prStartCooldown() {
    prUi.cooldownUntil = Date.now() + prUi.cooldownSec * 1000;
    prUpdateCooldownBanner();
    if (prUi.cooldownTimer) clearInterval(prUi.cooldownTimer);
    prUi.cooldownTimer = setInterval(function () {
      prUpdateCooldownBanner();
    }, 500);
  }

  function prShowView(name) {
    const map = { home: 'pr-view-home', list: 'pr-view-list' };
    Object.keys(map).forEach(function (k) {
      const el = document.getElementById(map[k]);
      if (el) el.classList.toggle('adm-view--hidden', k !== name);
    });
    const mineBtn = document.getElementById('pr-btn-mine');
    if (mineBtn) {
      mineBtn.classList.toggle('adm-view--hidden', name === 'list');
    }
    if (name === 'home') {
      prLoadOnlineStaffList();
    }
  }

  function prStaffInitials(displayName) {
    const s = String(displayName || '').trim();
    if (!s) return '?';
    const parts = s.split(/\s+/).filter(Boolean);
    if (parts.length >= 2) {
      return (parts[0].charAt(0) + parts[1].charAt(0)).toUpperCase();
    }
    return s.slice(0, 2).toUpperCase();
  }

  async function prLoadOnlineStaffList() {
    const listEl = document.getElementById('pr-rail-staff-list');
    const emptyEl = document.getElementById('pr-rail-staff-empty');
    const loadEl = document.getElementById('pr-rail-staff-loading');
    if (!listEl || !emptyEl) return;
    listEl.innerHTML = '';
    emptyEl.classList.add('adm-view--hidden');
    listEl.classList.add('adm-view--hidden');
    if (loadEl) {
      loadEl.classList.remove('adm-view--hidden');
      loadEl.textContent = 'Loading staff photos…';
    }
    const res = await postNui('playerReportGetOnlineStaff', {});
    const staff = (res && res.ok && res.staff) || [];
    if (loadEl) loadEl.classList.add('adm-view--hidden');
    if (staff.length === 0) {
      emptyEl.classList.remove('adm-view--hidden');
      return;
    }
    listEl.classList.remove('adm-view--hidden');
    staff.forEach(function (s) {
      const li = document.createElement('li');
      li.className = 'adm-pr-staff-rail__card';
      const display = (s.charName && String(s.charName).trim()) || s.licenseName || '#' + s.id;
      const badge =
        s.rankLabel && String(s.rankLabel).trim() !== ''
          ? '<span class="adm-pr-staff-rail__badge">' + escapeHtml(String(s.rankLabel)) + '</span>'
          : '';
      const av = s.avatarUrl
        ? '<img class="adm-pr-staff-rail__avatar" src="' +
          escapeAttr(String(s.avatarUrl)) +
          '" alt="" width="48" height="48" loading="lazy" />'
        : '<div class="adm-pr-staff-rail__avatar adm-pr-staff-rail__avatar--ph" role="img" aria-hidden="true">' +
          escapeHtml(prStaffInitials(display)) +
          '</div>';
      li.innerHTML =
        av +
        '<div class="adm-pr-staff-rail__meta">' +
        '<span class="adm-pr-staff-rail__name">' +
        escapeHtml(String(display)) +
        '</span>' +
        '<div class="adm-pr-staff-rail__row">' +
        badge +
        '<span class="adm-pr-staff-rail__id">#' +
        escapeHtml(String(s.id)) +
        '</span></div></div>';
      listEl.appendChild(li);
    });
  }

  function prResetForm() {
    document.getElementById('pr-input-title').value = '';
    document.getElementById('pr-input-desc').value = '';
    document.getElementById('pr-input-image').value = '';
    const err = document.getElementById('pr-form-error');
    if (err) {
      err.classList.add('adm-view--hidden');
      err.textContent = '';
    }
  }

  function prApplyTypeToForm() {
    const h = document.getElementById('pr-form-heading');
    if (h) h.textContent = 'New report';
  }

  function openPlayerReportUi(data) {
    prUi.open = true;
    prUi.cooldownSec = Number(data.cooldownSeconds) || 60;
    prUi.serverName = data.serverName || 'Server';
    const sn = document.getElementById('adm-pr-server-name');
    if (sn) sn.textContent = prUi.serverName;
    document.getElementById('adm-player-report-app').classList.remove('adm-app--hidden');
    document.getElementById('adm-player-report-app').setAttribute('aria-hidden', 'false');
    document.body.classList.add('adm-body--panel-open');
    prUi.selectedType = 'question';
    prResetForm();
    prApplyTypeToForm();
    prShowView('home');
    prUpdateCooldownBanner();
    injectIcons(document.getElementById('adm-player-report-app'));
  }

  function closePlayerReportUi() {
    postNui('closePlayerReport', {});
    prUi.open = false;
    prUi.currentDetailId = null;
    prUi.lastDetailChatReportId = null;
    document.getElementById('adm-player-report-app').classList.add('adm-app--hidden');
    document.getElementById('adm-player-report-app').setAttribute('aria-hidden', 'true');
    document.body.classList.remove('adm-body--panel-open');
    document.getElementById('pr-detail-overlay').classList.add('adm-modal-overlay--hidden');
    if (prUi.cooldownTimer) {
      clearInterval(prUi.cooldownTimer);
      prUi.cooldownTimer = null;
    }
  }

  function prEscapeStackClose() {
    if (!prUi.open) return false;
    const detOv = document.getElementById('pr-detail-overlay');
    if (detOv && !detOv.classList.contains('adm-modal-overlay--hidden')) {
      detOv.classList.add('adm-modal-overlay--hidden');
      return true;
    }
    closePlayerReportUi();
    return true;
  }

  async function prLoadMyReports() {
    const res = await postNui('playerReportGetMyReports', {});
    const list = (res && res.ok && res.reports) || [];
    const tbody = document.getElementById('pr-tbody-list');
    const empty = document.getElementById('pr-list-empty');
    if (!tbody) return;
    tbody.innerHTML = '';
    if (list.length === 0) {
      empty.classList.add('adm-table-empty--visible');
      return;
    }
    empty.classList.remove('adm-table-empty--visible');
    list.forEach(function (r) {
      const tr = document.createElement('tr');
      tr.dataset.prRow = '1';
      tr.dataset.prId = String(r.id);
      const st = reportStatusLabel(r.status);
      tr.innerHTML = [
        '<td>#' + escapeHtml(String(r.id)) + '</td>',
        '<td>' + escapeHtml(reportTypeLabel(r.report_type)) + '</td>',
        '<td>' + escapeHtml((r.title || '').slice(0, 40)) + (r.title && r.title.length > 40 ? '…' : '') + '</td>',
        '<td><span class="' + reportStatusBadgeClass(r.status) + '">' + escapeHtml(st) + '</span></td>',
        '<td class="adm-table__cell-action">',
        '<button type="button" class="adm-btn-icon" data-pr-open="' + escapeHtml(String(r.id)) + '" title="View">',
        '<svg viewBox="0 0 24 24" width="18" height="18" fill="none" stroke="currentColor" stroke-width="2"><circle cx="12" cy="12" r="1"/><circle cx="12" cy="5" r="1"/><circle cx="12" cy="19" r="1"/></svg>',
        '</button></td>',
      ].join('');
      tbody.appendChild(tr);
    });

    tbody.querySelectorAll('tr[data-pr-row]').forEach(function (tr) {
      tr.addEventListener('click', function (e) {
        if (e.target.closest && e.target.closest('[data-pr-open]')) return;
        prOpenDetail(Number(tr.dataset.prId));
      });
    });
    tbody.querySelectorAll('[data-pr-open]').forEach(function (btn) {
      btn.addEventListener('click', function (e) {
        e.stopPropagation();
        prOpenDetail(Number(btn.getAttribute('data-pr-open')));
      });
    });
  }

  async function prOpenDetail(reportId) {
    const res = await postNui('playerReportGetDetails', { reportId: reportId });
    if (!res || !res.ok || !res.report) return;
    const rep = res.report;
    const messages = res.messages || [];
    prUi.currentDetailId = rep.id;

    document.getElementById('pr-detail-title').textContent = '#' + rep.id + ' — ' + (rep.title || '');
    document.getElementById('pr-detail-badge-type').textContent = reportTypeLabel(rep.report_type);
    const stEl = document.getElementById('pr-detail-badge-status');
    stEl.textContent = reportStatusLabel(rep.status);
    stEl.className = reportStatusBadgeClass(rep.status);
    document.getElementById('pr-detail-status-text').textContent = reportStatusLabel(rep.status);
    document.getElementById('pr-detail-created').textContent = formatReportDate(rep.created_at);
    document.getElementById('pr-detail-description').textContent = rep.description || '—';

    const imgWrap = document.getElementById('pr-detail-image-wrap');
    const imgLink = document.getElementById('pr-detail-image-link');
    if (rep.image_url && String(rep.image_url).trim() !== '') {
      imgWrap.classList.remove('adm-view--hidden');
      imgLink.href = rep.image_url;
      imgLink.textContent = rep.image_url.length > 48 ? rep.image_url.slice(0, 48) + '…' : rep.image_url;
    } else {
      imgWrap.classList.add('adm-view--hidden');
    }

    const msgWrap = document.getElementById('pr-detail-messages-wrap');
    const msgList = document.getElementById('pr-detail-messages-list');
    msgWrap.classList.remove('adm-view--hidden');
    renderReportChatMessages(msgList, messages, { playerPerspective: true });

    if (prUi.lastDetailChatReportId !== rep.id) {
      prUi.lastDetailChatReportId = rep.id;
      const prIn = document.getElementById('pr-chat-input');
      if (prIn) prIn.value = '';
    }

    const st = rep.status || '';
    const prComposer = document.getElementById('pr-chat-composer');
    if (prComposer) {
      prComposer.classList.toggle('adm-view--hidden', st === 'closed');
    }

    document.getElementById('pr-detail-overlay').classList.remove('adm-modal-overlay--hidden');
  }

  async function loadPermissionMatrix() {
    if (!state.canEditPermissions) {
      setPermUiVisible(false, true, '');
      return;
    }
    setPermUiVisible(false, false, '');
    const payload = await postNui('getPermissionMatrix', {});
    if (!payload || !payload.roles) {
      setPermUiVisible(false, false, 'Could not load the permission matrix (no permission or server error).');
      return;
    }
    setPermUiVisible(true, false, '');
    syncPermissionSearchQueryFromDom();
    renderPermissionMatrix(payload);
    injectIcons(document.getElementById('view-permissions'));
  }

  async function onPermissionToggle(ev) {
    const t = ev.target;
    if (!t || !t.classList || !t.classList.contains('adm-select--perm')) return;
    const roleKey = t.dataset.role;
    const commandKey = t.dataset.cmd;
    if (!roleKey || !commandKey) return;

    const allowed = t.value === '1';
    const prev = allowed ? '0' : '1';
    const res = await postNui('setPermission', {
      roleKey: roleKey,
      commandKey: commandKey,
      allowed: allowed,
    });
    if (!res || res.ok !== true) {
      t.value = prev;
      const err = document.getElementById('adm-perm-error');
      if (err) {
        err.classList.remove('adm-view--hidden');
        err.textContent = 'Could not save this permission.';
      }
      return;
    }
    const err = document.getElementById('adm-perm-error');
    if (err) {
      err.classList.add('adm-view--hidden');
      err.textContent = '';
    }
    if (state.permissionPayload && state.permissionPayload.matrix) {
      state.permissionPayload.matrix[roleKey] = state.permissionPayload.matrix[roleKey] || {};
      state.permissionPayload.matrix[roleKey][commandKey] = allowed;
    }
  }

  function weatherSyncStopPoll() {
    if (state.weatherSyncPollTimer) {
      clearInterval(state.weatherSyncPollTimer);
      state.weatherSyncPollTimer = null;
    }
  }

  function weatherSyncStartPoll() {
    weatherSyncStopPoll();
    function tick() {
      postNui('weatherSyncRequestState', {});
    }
    tick();
    state.weatherSyncPollTimer = setInterval(tick, 2500);
  }

  function coordsFmt(n) {
    const v = Number(n);
    if (!isFinite(v)) return '0.0000';
    return v.toFixed(4);
  }

  function buildCoordFormats(x, y, z, h) {
    const fx = coordsFmt(x);
    const fy = coordsFmt(y);
    const fz = coordsFmt(z);
    const fh = coordsFmt(h);
    return {
      assign: 'x = ' + fx + ', y = ' + fy + ', z = ' + fz + ', h = ' + fh,
      lua: '{ x = ' + fx + ', y = ' + fy + ', z = ' + fz + ', h = ' + fh + ' }',
      vec3: 'vector3(' + fx + ', ' + fy + ', ' + fz + ')',
      vec4: 'vector4(' + fx + ', ' + fy + ', ' + fz + ', ' + fh + ')',
    };
  }

  function coordsStopPoll() {
    if (state.coordsPollTimer) {
      clearInterval(state.coordsPollTimer);
      state.coordsPollTimer = null;
    }
  }

  async function refreshCoordsDisplay() {
    const res = await postNui('getPlayerCoords', {});
    if (!res || res.ok !== true) return;
    const x = res.x;
    const y = res.y;
    const z = res.z;
    const h = res.h;
    const f = buildCoordFormats(x, y, z, h);
    const setCode = function (id, text) {
      const el = document.getElementById(id);
      if (el) el.textContent = text;
    };
    setCode('adm-coords-fmt-assign', f.assign);
    setCode('adm-coords-fmt-lua', f.lua);
    setCode('adm-coords-fmt-vec3', f.vec3);
    setCode('adm-coords-fmt-vec4', f.vec4);
    const setChip = function (id, v) {
      const el = document.getElementById(id);
      if (el) el.textContent = coordsFmt(v);
    };
    setChip('adm-coords-vx', x);
    setChip('adm-coords-vy', y);
    setChip('adm-coords-vz', z);
    setChip('adm-coords-vh', h);
  }

  function coordsStartPoll() {
    coordsStopPoll();
    refreshCoordsDisplay();
    state.coordsPollTimer = setInterval(refreshCoordsDisplay, 800);
  }

  async function copyCoordsClipboard(text) {
    if (!text) return;
    const s = String(text).trim();
    try {
      const res = await postNui('action', { action: 'setClipboard', text: s });
      if (res && res.ok !== false) {
        await notifyGame('Coordinates', 'Copied to clipboard.', 'success', 3500);
        return;
      }
    } catch (e) {
      /* continua para fallback */
    }
    try {
      if (navigator.clipboard && navigator.clipboard.writeText) {
        await navigator.clipboard.writeText(s);
        await notifyGame('Coordinates', 'Copied to clipboard.', 'success', 3500);
        return;
      }
    } catch (err) {
      /* fallback execCommand */
    }
    try {
      const ta = document.createElement('textarea');
      ta.value = s;
      ta.setAttribute('readonly', '');
      ta.style.position = 'fixed';
      ta.style.left = '-9999px';
      document.body.appendChild(ta);
      ta.select();
      document.execCommand('copy');
      document.body.removeChild(ta);
      await notifyGame('Coordinates', 'Copied to clipboard.', 'success', 3500);
    } catch (e2) {
      await notifyGame('Coordinates', 'Could not copy to clipboard.', 'error', 4500);
    }
  }

  async function loadDeveloperHorseSelect() {
    const sel = document.getElementById('adm-dev-horse-select');
    if (!sel) return;
    sel.innerHTML = '';
    const loading = document.createElement('option');
    loading.value = '';
    loading.textContent = 'Loading…';
    sel.appendChild(loading);
    const res = await postNui('getDeveloperMeta', {});
    sel.innerHTML = '';
    const ph = document.createElement('option');
    ph.value = '';
    ph.textContent = 'Choose horse...';
    sel.appendChild(ph);
    if (res && res.ok && Array.isArray(res.adminHorses)) {
      res.adminHorses.forEach(function (h) {
        const o = document.createElement('option');
        o.value = String(h.hash);
        o.textContent = h.label || String(h.hash);
        sel.appendChild(o);
      });
    }
  }

  function wireDeveloperPanel() {
    const root = document.getElementById('view-developer');
    if (!root) return;
    root.addEventListener('click', async function (e) {
      const t = e.target;
      const id = t && t.id;
      if (!id) return;
      if (id === 'adm-dev-apply-horse') {
        const sel = document.getElementById('adm-dev-horse-select');
        const v = sel && sel.value;
        if (!v) {
          await notifyGame('Developer', 'Choose a horse from the list.', 'error', 4000);
          return;
        }
        await postNui('action', { action: 'spawnHorse', horseHash: Number(v) });
        await notifyGame('Developer', 'Horse spawn requested.', 'success', 3500);
      } else if (id === 'adm-dev-apply-anim') {
        const dictEl = document.getElementById('adm-dev-anim-dict');
        const clipEl = document.getElementById('adm-dev-anim-clip');
        const dict = dictEl ? dictEl.value.trim() : '';
        const clip = clipEl ? clipEl.value.trim() : '';
        if (!dict || !clip) {
          await notifyGame('Developer', 'Fill in dictionary and clip.', 'error', 4000);
          return;
        }
        const flag = Number(document.getElementById('adm-dev-anim-flag').value);
        const length = Number(document.getElementById('adm-dev-anim-length').value);
        await postNui('action', {
          action: 'testAnimation',
          dict: dict,
          clip: clip,
          flag: flag,
          length: length,
        });
        await notifyGame('Developer', 'Animation started.', 'inform', 3500);
      } else if (id === 'adm-dev-apply-hash') {
        const inp = document.getElementById('adm-dev-hash-model');
        const v = inp ? inp.value.trim() : '';
        if (!v) {
          await notifyGame('Developer', 'Enter the model name.', 'error', 4000);
          return;
        }
        const res = await postNui('action', { action: 'getHash', value: v });
        if (res && res.hash) {
          await notifyGame('Developer', 'Hash ' + res.hash + ' copied.', 'success', 5000);
        } else {
          await notifyGame('Developer', 'Could not compute hash.', 'error', 4000);
        }
      } else if (id === 'adm-dev-apply-doors') {
        await postNui('action', { action: 'toggleDoorIds' });
        await notifyGame('Developer', 'Door ID mode toggled.', 'inform', 3500);
      } else if (id === 'adm-dev-apply-ped') {
        const modelEl = document.getElementById('adm-dev-ped-model');
        const model = modelEl ? modelEl.value.trim() : '';
        if (!model) {
          await notifyGame('Developer', 'Enter the ped model.', 'error', 4000);
          return;
        }
        await postNui('action', {
          action: 'spawnPed',
          model: model,
          outfit: Number(document.getElementById('adm-dev-ped-outfit').value),
          distance: Number(document.getElementById('adm-dev-ped-dist').value),
          freeze: document.getElementById('adm-dev-ped-freeze').value,
          dead: document.getElementById('adm-dev-ped-dead').value,
        });
        await notifyGame('Developer', 'Ped spawn requested.', 'success', 3500);
      }
    });
  }

  function wireCoordsPanel() {
    const refresh = document.getElementById('adm-coords-refresh');
    if (refresh) {
      refresh.addEventListener('click', function () {
        refreshCoordsDisplay();
      });
    }
    const root = document.getElementById('view-coords');
    if (root) {
      root.addEventListener('click', function (e) {
        const btn = e.target.closest('[data-coords-copy]');
        if (!btn) return;
        const key = btn.getAttribute('data-coords-copy');
        const map = { assign: 'adm-coords-fmt-assign', lua: 'adm-coords-fmt-lua', vec3: 'adm-coords-fmt-vec3', vec4: 'adm-coords-fmt-vec4' };
        const id = map[key];
        if (!id) return;
        const el = document.getElementById(id);
        const t = el && (el.textContent || el.value);
        if (t && String(t).trim()) copyCoordsClipboard(String(t).trim());
      });
    }
  }

  function populateWeatherTypeSelect() {
    const sel = document.getElementById('adm-ws-new-weather');
    if (!sel || sel.options.length > 0) return;
    WEATHER_TYPES_RDR3.forEach(function (w) {
      const o = document.createElement('option');
      o.value = w;
      o.textContent = w;
      sel.appendChild(o);
    });
  }

  function applyWeatherSyncStateReadonly(p) {
    if (!p || typeof p !== 'object') return;
    const pad = function (n) {
      return String(Math.max(0, Math.min(59, Number(n) || 0))).padStart(2, '0');
    };
    const padH = function (n) {
      return String(Math.max(0, Math.min(23, Number(n) || 0))).padStart(2, '0');
    };
    const di = Number(p.day);
    const dow = WS_DOW_EN[((di % 7) + 7) % 7] || String(di);
    const curTimeEl = document.getElementById('adm-ws-cur-time');
    if (curTimeEl) {
      curTimeEl.textContent = dow + ' ' + padH(p.hour) + ':' + pad(p.min) + ':' + pad(p.sec);
    }
    const curTs = document.getElementById('adm-ws-cur-timescale');
    if (curTs) curTs.textContent = p.timescale != null ? String(p.timescale) : '—';
    const curW = document.getElementById('adm-ws-cur-weather');
    if (curW) curW.textContent = p.weather != null ? String(p.weather) : '—';
    const curWd = document.getElementById('adm-ws-cur-wind-dir');
    if (curWd) {
      curWd.textContent = p.windDirection != null ? String(Math.round(Number(p.windDirection))) : '—';
    }
    const curWs = document.getElementById('adm-ws-cur-wind-speed');
    if (curWs) curWs.textContent = p.windSpeed != null ? String(p.windSpeed) : '—';
  }

  function applyWeatherSyncStateEditable(p) {
    if (!p || typeof p !== 'object') return;
    const setVal = function (id, v) {
      const el = document.getElementById(id);
      if (el && v != null && v !== '') el.value = String(v);
    };
    const daySel = document.getElementById('adm-ws-new-day');
    if (daySel && p.day != null) {
      daySel.value = String(((Number(p.day) % 7) + 7) % 7);
    }
    setVal('adm-ws-new-hour', p.hour);
    setVal('adm-ws-new-min', p.min);
    setVal('adm-ws-new-sec', p.sec);
    setVal('adm-ws-new-timescale', p.timescale);
    setVal('adm-ws-new-wind-dir', p.windDirection);
    setVal('adm-ws-new-wind-speed', p.windSpeed);
    setVal('adm-ws-sync-delay', p.syncDelay);
    const wSel = document.getElementById('adm-ws-new-weather');
    if (wSel && p.weather) {
      wSel.value = String(p.weather);
    }
  }

  function applyWeatherSyncState(p) {
    if (!p || typeof p !== 'object') return;
    applyWeatherSyncStateReadonly(p);
    if (!state.weatherSyncServerSeedApplied) {
      if (!state.weatherSyncFormTouched) {
        applyWeatherSyncStateEditable(p);
      }
      state.weatherSyncServerSeedApplied = true;
    }
  }

  function wireWeatherSyncPanel() {
    const bind = function (id, action, getPayload) {
      const el = document.getElementById(id);
      if (!el) return;
      el.addEventListener('click', function () {
        postNui('weatherSyncAction', Object.assign({ action: action }, getPayload()));
      });
    };
    bind('adm-ws-apply-time', 'setTime', function () {
      return {
        day: Number(document.getElementById('adm-ws-new-day').value),
        hour: Number(document.getElementById('adm-ws-new-hour').value),
        min: Number(document.getElementById('adm-ws-new-min').value),
        sec: Number(document.getElementById('adm-ws-new-sec').value),
        transition: Number(document.getElementById('adm-ws-time-transition').value),
        freeze: document.getElementById('adm-ws-time-freeze').checked,
      };
    });
    bind('adm-ws-apply-timescale', 'setTimescale', function () {
      return { timescale: Number(document.getElementById('adm-ws-new-timescale').value) };
    });
    bind('adm-ws-apply-weather', 'setWeather', function () {
      return {
        weather: document.getElementById('adm-ws-new-weather').value,
        transition: Number(document.getElementById('adm-ws-weather-transition').value),
        freeze: document.getElementById('adm-ws-weather-freeze').checked,
        permanentSnow: document.getElementById('adm-ws-weather-snow').checked,
      };
    });
    bind('adm-ws-apply-wind', 'setWind', function () {
      return {
        windDirection: Number(document.getElementById('adm-ws-new-wind-dir').value),
        windSpeed: Number(document.getElementById('adm-ws-new-wind-speed').value),
        freeze: document.getElementById('adm-ws-wind-freeze').checked,
      };
    });
    bind('adm-ws-apply-sync', 'setSyncDelay', function () {
      return { syncDelay: Number(document.getElementById('adm-ws-sync-delay').value) };
    });
    const bmApply = document.getElementById('adm-bm-apply');
    const bmRestore = document.getElementById('adm-bm-restore');
    if (bmApply && !bmApply._bmWired) {
      bmApply._bmWired = true;
      bmApply.addEventListener('click', function () {
        postNui('bloodMoonAction', { enable: true }).then(async function (res) {
          if (res && res.ok) {
            await notifyGame('Blood Moon', 'Fog weather sent to the server.', 'success');
          }
        });
      });
    }
    if (bmRestore && !bmRestore._bmWired) {
      bmRestore._bmWired = true;
      bmRestore.addEventListener('click', function () {
        postNui('bloodMoonAction', { enable: false }).then(async function (res) {
          if (res && res.ok) {
            await notifyGame('Blood Moon', 'Restore requested.', 'inform');
          }
        });
      });
    }
    const viewSettings = document.getElementById('view-settings');
    if (viewSettings) {
      function markWeatherSyncFormTouched(ev) {
        const t = ev.target;
        if (!t || !t.id) return;
        if (t.id.indexOf('adm-ws-cur') === 0) return;
        if (t.id.indexOf('adm-ws-apply') === 0) return;
        if (t.id.indexOf('adm-ws-') === 0) state.weatherSyncFormTouched = true;
      }
      viewSettings.addEventListener('input', markWeatherSyncFormTouched, true);
      viewSettings.addEventListener('change', markWeatherSyncFormTouched, true);
    }
  }

  function showView(view) {
    if (!sidebarAllowsView(view)) {
      showView('players');
      return;
    }
    const previousView = state.currentView;
    if (state.currentView === 'settings' && view !== 'settings') {
      weatherSyncStopPoll();
    }
    if (state.currentView === 'coords' && view !== 'coords') {
      coordsStopPoll();
    }
    if (state.currentView === 'livemap' && view !== 'livemap') {
      livemapUnmountLayoutObserver();
      livemapStopPoll();
      resetLivemapViewport();
      livemapLastFrameLayoutW = -1;
      livemapLastFrameLayoutH = -1;
    }
    hideAllMainViews();
    const contentEl = document.querySelector('.adm-content');
    if (contentEl) {
      contentEl.classList.toggle('adm-content--staff-chat', view === 'adminchat');
    }
    if (view !== 'dashboard') {
      destroyDashboardCharts();
    }

    document.querySelectorAll('.adm-nav-item').forEach(function (nav) {
      nav.classList.toggle('adm-nav-item--active', nav.getAttribute('data-view') === view);
    });
    const activeNav = document.querySelector('.adm-nav-item--active');
    if (activeNav && typeof activeNav.scrollIntoView === 'function') {
      activeNav.scrollIntoView({ block: 'nearest', inline: 'nearest' });
    }

    if (view === 'dashboard') {
      document.getElementById('view-dashboard').classList.remove('adm-view--hidden');
      loadDashboard();
    } else if (view === 'players') {
      document.getElementById('view-players').classList.remove('adm-view--hidden');
      if (previousView !== 'players') {
        renderPlayerRows();
      }
    } else if (view === 'admins') {
      document.getElementById('view-admins').classList.remove('adm-view--hidden');
      loadStaffAdmins();
    } else if (view === 'permissions') {
      document.getElementById('view-permissions').classList.remove('adm-view--hidden');
      loadPermissionMatrix();
    } else if (view === 'reports') {
      document.getElementById('view-reports').classList.remove('adm-view--hidden');
      loadReportsView();
    } else if (view === 'bans') {
      document.getElementById('view-bans').classList.remove('adm-view--hidden');
      loadBansView();
    } else if (view === 'teleports') {
      document.getElementById('view-teleports').classList.remove('adm-view--hidden');
      renderTeleports();
      refreshTeleportPresets();
      injectIcons(document.getElementById('view-teleports'));
    } else if (view === 'commands') {
      document.getElementById('view-commands').classList.remove('adm-view--hidden');
      postNui('getCommandToggles', {}).then(function (t) {
        if (t && typeof t === 'object') {
          state.commandToggles = t;
        }
        renderQuickCommandsPanel();
        injectIcons(document.getElementById('view-commands'));
      });
    } else if (view === 'coords') {
      document.getElementById('view-coords').classList.remove('adm-view--hidden');
      coordsStartPoll();
      injectIcons(document.getElementById('view-coords'));
    } else if (view === 'livemap') {
      document.getElementById('view-livemap').classList.remove('adm-view--hidden');
      applyLiveMapSurfaceBg();
      applyLivemapTransform();
      /* Deferir poll + ícones para o próximo frame: o clique na navegação volta logo; evita picar com refreshPlayers+DOM. */
      requestAnimationFrame(function () {
        livemapClampPan();
        applyLivemapTransform();
        livemapStartPoll();
        livemapMountLayoutObserver();
        injectIcons(document.getElementById('view-livemap'));
      });
    } else if (view === 'developer') {
      document.getElementById('view-developer').classList.remove('adm-view--hidden');
      loadDeveloperHorseSelect();
      injectIcons(document.getElementById('view-developer'));
    } else if (view === 'settings') {
      document.getElementById('view-settings').classList.remove('adm-view--hidden');
      state.weatherSyncServerSeedApplied = false;
      state.weatherSyncFormTouched = false;
      populateWeatherTypeSelect();
      weatherSyncStartPoll();
      injectIcons(document.getElementById('view-settings'));
    } else if (view === 'adminchat') {
      document.getElementById('view-adminchat').classList.remove('adm-view--hidden');
      const can = allowed('adminchat');
      const denied = document.getElementById('adm-adminchat-denied');
      const main = document.getElementById('adm-adminchat-main');
      if (denied) denied.classList.toggle('adm-view--hidden', can);
      if (main) main.classList.toggle('adm-view--hidden', !can);
      if (can) {
        state.adminChatUnread = 0;
        updateAdminChatBadge();
        loadAdminChat();
      }
      injectIcons(document.getElementById('view-adminchat'));
    } else if (view === 'items') {
      document.getElementById('view-items').classList.remove('adm-view--hidden');
      ensureItemsCatalog(false);
    } else if (view === 'weapons') {
      document.getElementById('view-weapons').classList.remove('adm-view--hidden');
      ensureWeaponsCatalog(false);
    }

    state.currentView = view;
  }

  function openFromMessage(data) {
    state.players = data.players || [];
    state.staffName = data.staffName || 'Admin';
    state.maxPlayers = data.maxPlayers != null ? data.maxPlayers : 32;
    state.serverName = data.serverName || 'Server';
    state.staffRankLabel = data.staffRankLabel || '';
    state.staffRank = data.staffRank != null ? Number(data.staffRank) : 0;
    state.allowedCommands = data.allowedCommands || {};
    state.navVisibility =
      data.navVisibility && typeof data.navVisibility === 'object' ? data.navVisibility : {};
    state.framework = data.framework === 'vorp' ? 'vorp' : 'rsg';
    state.teleportPresets = Array.isArray(data.teleportPresets) ? data.teleportPresets : [];
    state.canEditPermissions = data.canEditPermissions === true;
    state.menuConfig = data.config && typeof data.config === 'object' ? data.config : {};
    state.commandToggles =
      data.commandToggles && typeof data.commandToggles === 'object' ? data.commandToggles : {};
    state.liveMapBounds = data.liveMap && typeof data.liveMap === 'object' ? data.liveMap : null;

    document.getElementById('adm-greeting').textContent = 'Hello, ' + state.staffName;
    applySidebarBranding({
      discordGuildName: data.discordGuildName,
      discordGuildIconUrl: data.discordGuildIconUrl,
      serverName: state.serverName,
    });
    const rankEl = document.getElementById('adm-staff-rank');
    rankEl.textContent = state.staffRankLabel ? state.staffRankLabel : '';

    applySidebarPermissionVisibility();

    applyLiveMapSurfaceBg();

    if (allowed('viewreports')) {
      loadReportsList();
    }

    updateStats();
    renderPlayerRows();
    showView('players');

    document.getElementById('adm-app').classList.remove('adm-app--hidden');
    document.getElementById('adm-app').setAttribute('aria-hidden', 'false');
    document.body.classList.add('adm-body--panel-open');
  }

  function hideNewReportToast() {
    const el = document.getElementById('adm-new-report-toast');
    const nav = document.getElementById('adm-nav-reports');
    if (el) el.classList.add('adm-view--hidden');
    if (nav) nav.classList.remove('adm-nav-item--pulse');
    if (state.newReportToastTimer) {
      clearTimeout(state.newReportToastTimer);
      state.newReportToastTimer = null;
    }
  }

  function showNewReportToast(payload) {
    if (!payload || !allowed('viewreports')) return;
    const el = document.getElementById('adm-new-report-toast');
    const txt = document.getElementById('adm-new-report-toast-text');
    const nav = document.getElementById('adm-nav-reports');
    if (!el || !txt) return;
    const typeLabel = reportTypeLabel(payload.report_type);
    const repName = payload.reporter_name || '—';
    txt.textContent = '#' + payload.reportId + ' · ' + repName + ' · ' + typeLabel;
    el.classList.remove('adm-view--hidden');
    if (nav && !nav.classList.contains('adm-nav-item--hidden')) {
      nav.classList.remove('adm-nav-item--pulse');
      void nav.offsetWidth;
      nav.classList.add('adm-nav-item--pulse');
    }
    injectIcons(el);
    if (state.newReportToastTimer) clearTimeout(state.newReportToastTimer);
    state.newReportToastTimer = setTimeout(hideNewReportToast, 14000);
    loadReportsList();
  }

  function closeUi() {
    weatherSyncStopPoll();
    const contentEl = document.querySelector('.adm-content');
    if (contentEl) {
      contentEl.classList.remove('adm-content--staff-chat');
    }
    destroyDashboardCharts();
    hideNewReportToast();
    clearBanDetailPanel();
    postNui('close', {});
    document.body.classList.remove('adm-body--panel-open');
    document.getElementById('adm-app').classList.add('adm-app--hidden');
    document.getElementById('adm-app').setAttribute('aria-hidden', 'true');
    document.getElementById('adm-modal-overlay').classList.add('adm-modal-overlay--hidden');
    document.getElementById('adm-kick-overlay').classList.add('adm-modal-overlay--hidden');
    document.getElementById('adm-ban-overlay').classList.add('adm-modal-overlay--hidden');
    document.getElementById('adm-report-detail-overlay').classList.add('adm-modal-overlay--hidden');
    document.getElementById('adm-report-delete-overlay').classList.add('adm-modal-overlay--hidden');
    document.getElementById('adm-ban-detail-overlay').classList.add('adm-modal-overlay--hidden');
    document.getElementById('adm-ban-offline-overlay').classList.add('adm-modal-overlay--hidden');
    const giveItemOv = document.getElementById('adm-give-item-overlay');
    if (giveItemOv) {
      giveItemOv.classList.add('adm-modal-overlay--hidden');
      giveItemOv.setAttribute('aria-hidden', 'true');
    }
    state.giveItemTargetId = null;
    const setJobOv = document.getElementById('adm-setjob-overlay');
    if (setJobOv) {
      setJobOv.classList.add('adm-modal-overlay--hidden');
      setJobOv.setAttribute('aria-hidden', 'true');
    }
    state.setJobTargetId = null;
    const financeOv = document.getElementById('adm-finance-overlay');
    if (financeOv) {
      financeOv.classList.add('adm-modal-overlay--hidden');
      financeOv.setAttribute('aria-hidden', 'true');
    }
    state.financeTargetId = null;
    const removeJobOv = document.getElementById('adm-removejob-overlay');
    if (removeJobOv) {
      removeJobOv.classList.add('adm-modal-overlay--hidden');
      removeJobOv.setAttribute('aria-hidden', 'true');
    }
    state.removeJobTargetId = null;
    const dangerOv = document.getElementById('adm-danger-confirm-overlay');
    if (dangerOv) {
      dangerOv.classList.add('adm-modal-overlay--hidden');
      dangerOv.setAttribute('aria-hidden', 'true');
    }
    state.dangerConfirmHandler = null;
  }

  document.addEventListener('DOMContentLoaded', function () {
    injectIcons(document);

    const toastClose = document.getElementById('adm-new-report-toast-close');
    if (toastClose) toastClose.addEventListener('click', hideNewReportToast);
    const toastGoto = document.getElementById('adm-new-report-toast-goto');
    if (toastGoto) {
      toastGoto.addEventListener('click', function () {
        hideNewReportToast();
        showView('reports');
      });
    }

    setInterval(updateClock, 1000);
    updateClock();

    document.querySelectorAll('.adm-nav-item').forEach(function (btn) {
      btn.addEventListener('click', function () {
        const v = btn.getAttribute('data-view');
        if (!v || !sidebarAllowsView(v)) {
          return;
        }
        showView(v);
      });
    });

    wireWeatherSyncPanel();
    wireCoordsPanel();
    wireLiveMapPanel();
    wireDeveloperPanel();
    wireQuickCommandsPanel();
    wireScreenAnnounceForm();

    const admBtnRefreshPermissions = document.getElementById('adm-btn-refresh-permissions');
    if (admBtnRefreshPermissions) {
      admBtnRefreshPermissions.addEventListener('click', function () {
        if (state.currentView === 'permissions') loadPermissionMatrix();
      });
    }
    const admSearchPermissions = document.getElementById('adm-search-permissions');
    if (admSearchPermissions) {
      admSearchPermissions.addEventListener('input', onPermissionMatrixSearchInput);
      admSearchPermissions.addEventListener('search', onPermissionMatrixSearchInput);
    }

    document.getElementById('adm-btn-refresh-staff').addEventListener('click', function () {
      if (state.currentView === 'admins') loadStaffAdmins();
    });

    document.getElementById('adm-search-staff').addEventListener('input', renderStaffAdminsTable);

    document.getElementById('view-permissions').addEventListener('change', onPermissionToggle);
    const admPermRoleApply = document.getElementById('adm-perm-role-apply');
    if (admPermRoleApply) {
      admPermRoleApply.addEventListener('click', async function () {
        const roleSel = document.getElementById('adm-perm-role-quick');
        const cmdSel = document.getElementById('adm-perm-command-quick');
        const effectSel = document.getElementById('adm-perm-quick-effect');
        const roleKey = roleSel ? roleSel.value : '';
        const commandKey = cmdSel ? cmdSel.value : '';
        const allow = effectSel ? effectSel.value === 'allow' : true;
        if (!roleKey || !commandKey) return;
        await applyQuickPermission(roleKey, commandKey, allow);
      });
    }

    document.getElementById('adm-btn-banned').addEventListener('click', function () {
      showView('bans');
    });

    const admSearchBans = document.getElementById('adm-search-bans');
    if (admSearchBans) {
      admSearchBans.addEventListener('input', renderBansTable);
    }

    const admSearchItems = document.getElementById('adm-search-items');
    if (admSearchItems) {
      admSearchItems.addEventListener('input', function () {
        const v = admSearchItems.value || '';
        if (state.itemsSearchDebounceTimer) {
          clearTimeout(state.itemsSearchDebounceTimer);
        }
        state.itemsSearchDebounceTimer = setTimeout(function () {
          state.itemsSearchDebounceTimer = null;
          state.itemsSearchQuery = v;
          state.itemsVisibleCount = ITEMS_PAGE_SIZE;
          renderItemsGrid('self');
        }, 200);
      });
    }

    const admItemsLoadMore = document.getElementById('adm-items-load-more');
    if (admItemsLoadMore) {
      admItemsLoadMore.addEventListener('click', function () {
        state.itemsVisibleCount = (state.itemsVisibleCount || ITEMS_PAGE_SIZE) + ITEMS_PAGE_SIZE;
        renderItemsGrid('self');
      });
    }

    const admSearchWeapons = document.getElementById('adm-search-weapons');
    if (admSearchWeapons) {
      admSearchWeapons.addEventListener('input', function () {
        const v = admSearchWeapons.value || '';
        if (state.weaponsSearchDebounceTimer) {
          clearTimeout(state.weaponsSearchDebounceTimer);
        }
        state.weaponsSearchDebounceTimer = setTimeout(function () {
          state.weaponsSearchDebounceTimer = null;
          state.weaponsSearchQuery = v;
          state.weaponsVisibleCount = ITEMS_PAGE_SIZE;
          renderWeaponsGrid();
        }, 200);
      });
    }

    const admWeaponsLoadMore = document.getElementById('adm-weapons-load-more');
    if (admWeaponsLoadMore) {
      admWeaponsLoadMore.addEventListener('click', function () {
        state.weaponsVisibleCount = (state.weaponsVisibleCount || ITEMS_PAGE_SIZE) + ITEMS_PAGE_SIZE;
        renderWeaponsGrid();
      });
    }

    const admGiveItemSearch = document.getElementById('adm-give-item-search');
    if (admGiveItemSearch) {
      admGiveItemSearch.addEventListener('input', function () {
        const v = admGiveItemSearch.value || '';
        if (state.giveItemSearchDebounceTimer) {
          clearTimeout(state.giveItemSearchDebounceTimer);
        }
        state.giveItemSearchDebounceTimer = setTimeout(function () {
          state.giveItemSearchDebounceTimer = null;
          state.giveItemSearchQuery = v;
          state.giveItemVisibleCount = ITEMS_PAGE_SIZE;
          renderItemsGrid('give');
        }, 200);
      });
    }
    const admGiveItemLoadMore = document.getElementById('adm-give-item-load-more');
    if (admGiveItemLoadMore) {
      admGiveItemLoadMore.addEventListener('click', function () {
        state.giveItemVisibleCount = (state.giveItemVisibleCount || ITEMS_PAGE_SIZE) + ITEMS_PAGE_SIZE;
        renderItemsGrid('give');
      });
    }
    const admGiveItemBack = document.getElementById('adm-give-item-back');
    if (admGiveItemBack) {
      admGiveItemBack.addEventListener('click', function () {
        closeGiveItemToPlayerModal(true);
      });
    }
    const admGiveItemClose = document.getElementById('adm-give-item-close');
    if (admGiveItemClose) {
      admGiveItemClose.addEventListener('click', function () {
        closeGiveItemToPlayerModal(true);
      });
    }
    const admGiveItemOverlay = document.getElementById('adm-give-item-overlay');
    if (admGiveItemOverlay) {
      admGiveItemOverlay.addEventListener('click', function (e) {
        if (e.target.id === 'adm-give-item-overlay') {
          closeGiveItemToPlayerModal(true);
        }
      });
    }

    document.getElementById('adm-btn-refresh-bans').addEventListener('click', function () {
      if (state.currentView === 'bans') loadBansList();
    });

    document.getElementById('adm-btn-ban-offline').addEventListener('click', function () {
      openOfflineBanModal();
    });
    document.getElementById('adm-ban-offline-close').addEventListener('click', closeOfflineBanModal);
    document.getElementById('adm-ban-offline-cancel').addEventListener('click', closeOfflineBanModal);
    document.getElementById('adm-ban-offline-overlay').addEventListener('click', function (e) {
      if (e.target.id === 'adm-ban-offline-overlay') closeOfflineBanModal();
    });
    document.getElementById('adm-ban-offline-permanent').addEventListener('change', function () {
      const perm = document.getElementById('adm-ban-offline-permanent').checked;
      const dt = document.getElementById('adm-ban-offline-expire');
      if (dt) dt.disabled = perm;
    });
    document.getElementById('adm-ban-offline-confirm').addEventListener('click', async function () {
      const citizenid = document.getElementById('adm-ban-offline-citizenid').value.trim();
      const reason = document.getElementById('adm-ban-offline-reason').value.trim();
      if (!citizenid || !reason) {
        await notifyGame('Offline ban', 'Fill in citizen id (char id) and reason.', 'error');
        return;
      }
      const permanent = document.getElementById('adm-ban-offline-permanent').checked;
      let expire;
      if (permanent) {
        expire = PERMANENT_BAN_EXPIRE;
      } else {
        const v = document.getElementById('adm-ban-offline-expire').value;
        if (!v) {
          await notifyGame(
            'Offline ban',
            'Set an expiry date or mark as permanent ban.',
            'inform'
          );
          return;
        }
        expire = datetimeLocalToUnix(v);
      }
      const res = await postNui('banOffline', {
        citizenid: citizenid,
        reason: reason,
        expire: expire,
        permanent: permanent,
      });
      if (!res || !res.ok) {
        const err = res && res.error;
        let msg = 'Could not create ban.';
        if (err === 'duplicate') msg = "A ban with this character's license already exists.";
        else if (err === 'not_found') msg = 'No character found with this citizen id in the database.';
        else if (err === 'citizenid') msg = 'Enter a valid citizen id.';
        else if (err === 'invalid_license') msg = 'Invalid license on player record (contact a developer).';
        else if (err === 'reason') msg = 'Enter a reason.';
        else if (err === 'expire') msg = 'Invalid expiry date.';
        else if (err === 'denied') msg = 'No permission to ban.';
        await notifyGame('Offline ban', msg, 'error');
        return;
      }
      const dn = res.displayName ? String(res.displayName) : '';
      const cid = res.citizenid ? String(res.citizenid) : citizenid;
      await notifyGame(
        'Ban created',
        dn ? dn + ' (citizenid ' + cid + ')' : 'Citizenid ' + cid,
        'success'
      );
      closeOfflineBanModal();
      if (state.currentView === 'bans') await loadBansList();
    });

    document.getElementById('adm-ban-detail-close').addEventListener('click', clearBanDetailPanel);
    document.getElementById('adm-ban-detail-overlay').addEventListener('click', function (e) {
      if (e.target.id === 'adm-ban-detail-overlay') clearBanDetailPanel();
    });

    document.getElementById('adm-ban-check-permanent').addEventListener('change', function () {
      const perm = document.getElementById('adm-ban-check-permanent').checked;
      const dt = document.getElementById('adm-ban-input-expire');
      dt.disabled = perm;
      if (!perm && state.selectedBanId != null) {
        const b = state.bansList.find(function (x) {
          return Number(x.id) === Number(state.selectedBanId);
        });
        if (b) dt.value = unixToDatetimeLocal(b.expire);
      }
    });

    document.getElementById('adm-ban-btn-save').addEventListener('click', async function () {
      if (state.selectedBanId == null) return;
      if (!canEditBanDetails()) return;
      const permanent = document.getElementById('adm-ban-check-permanent').checked;
      let expire;
      if (permanent) {
        expire = PERMANENT_BAN_EXPIRE;
      } else {
        const v = document.getElementById('adm-ban-input-expire').value;
        if (!v) {
          await notifyGame(
            'Ban',
            'Set an expiry date or mark as permanent ban.',
            'inform'
          );
          return;
        }
        expire = datetimeLocalToUnix(v);
      }
      const reason = document.getElementById('adm-ban-input-reason').value;
      const res = await postNui('updateBan', {
        banId: state.selectedBanId,
        reason: reason,
        expire: expire,
        permanent: permanent,
      });
      if (!res || !res.ok) {
        await notifyGame(
          'Ban',
          'Could not update the ban (no permission or server error).',
          'error'
        );
        return;
      }
      await notifyGame('Ban', 'Changes saved.', 'success');
      await loadBansList();
    });

    document.getElementById('adm-ban-btn-remove').addEventListener('click', async function () {
      if (state.selectedBanId == null) return;
      if (!canRemoveBan()) return;
      const confirmed = await confirmGame(
        'Remove ban',
        'Remove this ban from the database? The player can join if there is no other ban.'
      );
      if (!confirmed) return;
      const res = await postNui('removeBan', { banId: state.selectedBanId });
      if (!res || !res.ok) {
        await notifyGame('Ban', 'Could not remove ban.', 'error');
        return;
      }
      await notifyGame('Ban', 'Ban removed.', 'success');
      clearBanDetailPanel();
      await loadBansList();
    });

    const refreshPlayersBtn = document.getElementById('adm-btn-refresh-players');
    if (refreshPlayersBtn) {
      refreshPlayersBtn.addEventListener('click', function () {
        refreshPlayers();
      });
    }
    const tpCreateBtn = document.getElementById('adm-teleports-create');
    if (tpCreateBtn) {
      tpCreateBtn.addEventListener('click', function () {
        openTeleportCreateBox();
      });
    }
    const tpEditBtn = document.getElementById('adm-teleports-edit');
    if (tpEditBtn) {
      tpEditBtn.addEventListener('click', function () {
        state.teleportEditMode = !state.teleportEditMode;
        if (!state.teleportEditMode) closeTeleportCreateBox();
        renderTeleports();
      });
    }
    const tpCreateSave = document.getElementById('adm-teleport-create-save');
    if (tpCreateSave) {
      tpCreateSave.addEventListener('click', function () {
        createTeleportFromCurrentPosition();
      });
    }
    const tpCreateCancel = document.getElementById('adm-teleport-create-cancel');
    if (tpCreateCancel) {
      tpCreateCancel.addEventListener('click', function () {
        closeTeleportCreateBox();
      });
    }
    const tpCreateInput = document.getElementById('adm-teleport-create-name');
    if (tpCreateInput) {
      tpCreateInput.addEventListener('keydown', function (e) {
        if (e.key === 'Enter') {
          e.preventDefault();
          createTeleportFromCurrentPosition();
        } else if (e.key === 'Escape') {
          e.preventDefault();
          closeTeleportCreateBox();
        }
      });
    }

    document.getElementById('adm-search-players').addEventListener('input', renderPlayerRows);

    document.getElementById('adm-modal-close').addEventListener('click', function () {
      document.getElementById('adm-modal-overlay').classList.add('adm-modal-overlay--hidden');
    });
    document.getElementById('adm-modal-overlay').addEventListener('click', function (e) {
      if (e.target.id === 'adm-modal-overlay') {
        document.getElementById('adm-modal-overlay').classList.add('adm-modal-overlay--hidden');
      }
    });

    function reopenPlayerModalFromAux() {
      const pid = state.selectedPlayerId;
      if (pid != null) openActionModal(pid);
    }

    const admSetjobClose = document.getElementById('adm-setjob-close');
    if (admSetjobClose) {
      admSetjobClose.addEventListener('click', function () {
        closeSetJobModal(true);
      });
    }
    const admSetjobCancel = document.getElementById('adm-setjob-cancel');
    if (admSetjobCancel) {
      admSetjobCancel.addEventListener('click', function () {
        closeSetJobModal(true);
      });
    }
    const admSetjobJob = document.getElementById('adm-setjob-job');
    if (admSetjobJob) {
      admSetjobJob.addEventListener('change', function () {
        updateSetJobGradeSelect(null);
      });
    }
    const admSetjobConfirm = document.getElementById('adm-setjob-confirm');
    if (admSetjobConfirm) {
      admSetjobConfirm.addEventListener('click', function () {
        const jid = state.setJobTargetId;
        const jobSel = document.getElementById('adm-setjob-job');
        const gradeSel = document.getElementById('adm-setjob-grade');
        const name = jobSel ? jobSel.value.trim() : '';
        const grade = gradeSel ? parseInt(gradeSel.value, 10) || 0 : 0;
        if (!name || jid == null) return;
        postNui('action', { action: 'setPlayerJob', playerId: jid, jobName: name, grade: grade }).then(function () {
          closeSetJobModal(true);
          refreshPlayers();
        });
      });
    }
    const admSetjobOv = document.getElementById('adm-setjob-overlay');
    if (admSetjobOv) {
      admSetjobOv.addEventListener('click', function (e) {
        if (e.target.id === 'adm-setjob-overlay') {
          closeSetJobModal(true);
        }
      });
    }

    function submitFinanceChange(kind) {
      const pid = state.financeTargetId;
      const typeSel = document.getElementById('adm-finance-type');
      const amountEl = document.getElementById('adm-finance-amount');
      const moneyType = typeSel && typeSel.value ? String(typeSel.value) : 'cash';
      const amount = amountEl ? parseInt(amountEl.value, 10) || 0 : 0;
      if (pid == null || amount <= 0) return;
      const action = kind === 'remove' ? 'removeMoney' : 'giveMoney';
      postNui('action', { action: action, playerId: pid, moneyType: moneyType, amount: amount }).then(function () {
        closeFinanceModal(true);
        refreshPlayers();
      });
    }

    const admFinanceClose = document.getElementById('adm-finance-close');
    if (admFinanceClose) {
      admFinanceClose.addEventListener('click', function () {
        closeFinanceModal(true);
      });
    }
    const admFinanceCancel = document.getElementById('adm-finance-cancel');
    if (admFinanceCancel) {
      admFinanceCancel.addEventListener('click', function () {
        closeFinanceModal(true);
      });
    }
    const admFinanceGive = document.getElementById('adm-finance-give');
    if (admFinanceGive) {
      admFinanceGive.addEventListener('click', function () {
        submitFinanceChange('give');
      });
    }
    const admFinanceRemove = document.getElementById('adm-finance-remove');
    if (admFinanceRemove) {
      admFinanceRemove.addEventListener('click', function () {
        submitFinanceChange('remove');
      });
    }
    const admFinanceAmount = document.getElementById('adm-finance-amount');
    if (admFinanceAmount) {
      admFinanceAmount.addEventListener('keydown', function (e) {
        if (e.key === 'Enter') {
          submitFinanceChange('give');
        }
      });
    }
    const admFinanceOv = document.getElementById('adm-finance-overlay');
    if (admFinanceOv) {
      admFinanceOv.addEventListener('click', function (e) {
        if (e.target.id === 'adm-finance-overlay') {
          closeFinanceModal(true);
        }
      });
    }

    const admRemovejobClose = document.getElementById('adm-removejob-close');
    if (admRemovejobClose) {
      admRemovejobClose.addEventListener('click', function () {
        closeRemoveJobModal(true);
      });
    }
    const admRemovejobCancel = document.getElementById('adm-removejob-cancel');
    if (admRemovejobCancel) {
      admRemovejobCancel.addEventListener('click', function () {
        closeRemoveJobModal(true);
      });
    }
    const admRemovejobConfirm = document.getElementById('adm-removejob-confirm');
    if (admRemovejobConfirm) {
      admRemovejobConfirm.addEventListener('click', function () {
        const jid = state.removeJobTargetId;
        const sel = document.getElementById('adm-removejob-select');
        const jobName = sel && sel.value ? sel.value.trim() : '';
        if (!jobName || jid == null || sel.disabled) return;
        postNui('action', { action: 'removePlayerJob', playerId: jid, jobName: jobName }).then(function () {
          closeRemoveJobModal(true);
          refreshPlayers();
        });
      });
    }
    const admRemovejobOv = document.getElementById('adm-removejob-overlay');
    if (admRemovejobOv) {
      admRemovejobOv.addEventListener('click', function (e) {
        if (e.target.id === 'adm-removejob-overlay') {
          closeRemoveJobModal(true);
        }
      });
    }

    function cancelDangerAndReopenProfile() {
      closeDangerConfirm();
      reopenPlayerModalFromAux();
    }

    const admDangerClose = document.getElementById('adm-danger-confirm-close');
    if (admDangerClose) {
      admDangerClose.addEventListener('click', cancelDangerAndReopenProfile);
    }
    const admDangerCancel = document.getElementById('adm-danger-confirm-cancel');
    if (admDangerCancel) {
      admDangerCancel.addEventListener('click', cancelDangerAndReopenProfile);
    }
    const admDangerOk = document.getElementById('adm-danger-confirm-ok');
    if (admDangerOk) {
      admDangerOk.addEventListener('click', function () {
        const h = state.dangerConfirmHandler;
        closeDangerConfirm();
        if (typeof h === 'function') {
          h();
        }
      });
    }
    const admDangerOv = document.getElementById('adm-danger-confirm-overlay');
    if (admDangerOv) {
      admDangerOv.addEventListener('click', function (e) {
        if (e.target.id === 'adm-danger-confirm-overlay') {
          cancelDangerAndReopenProfile();
        }
      });
    }

    document.getElementById('adm-kick-close').addEventListener('click', function () {
      document.getElementById('adm-kick-overlay').classList.add('adm-modal-overlay--hidden');
    });
    document.getElementById('adm-kick-cancel').addEventListener('click', function () {
      document.getElementById('adm-kick-overlay').classList.add('adm-modal-overlay--hidden');
    });
    document.getElementById('adm-kick-confirm').addEventListener('click', function () {
      const reason = document.getElementById('adm-kick-reason').value.trim();
      if (!reason || !state.kickTargetId) return;
      postNui('action', { action: 'kickPlayer', playerId: state.kickTargetId, reason: reason });
      document.getElementById('adm-kick-overlay').classList.add('adm-modal-overlay--hidden');
      refreshPlayers();
    });

    document.getElementById('adm-ban-close').addEventListener('click', function () {
      document.getElementById('adm-ban-overlay').classList.add('adm-modal-overlay--hidden');
    });
    document.getElementById('adm-ban-cancel').addEventListener('click', function () {
      document.getElementById('adm-ban-overlay').classList.add('adm-modal-overlay--hidden');
    });
    document.getElementById('adm-ban-confirm').addEventListener('click', function () {
      const reason = document.getElementById('adm-ban-reason').value.trim();
      if (!reason || !state.banTargetId) return;
      const type = document.getElementById('adm-ban-type').value;
      let duration = document.getElementById('adm-ban-duration').value;
      if (type === 'permanent') {
        duration = '99999999999';
      }
      postNui('action', {
        action: 'banPlayer',
        playerId: state.banTargetId,
        duration: duration,
        reason: reason,
      });
      document.getElementById('adm-ban-overlay').classList.add('adm-modal-overlay--hidden');
      refreshPlayers();
    });

    document.getElementById('adm-ban-type').addEventListener('change', function () {
      const dur = document.getElementById('adm-ban-duration');
      dur.disabled = document.getElementById('adm-ban-type').value === 'permanent';
    });

    document.getElementById('adm-btn-refresh-reports').addEventListener('click', function () {
      if (state.currentView === 'reports') loadReportsList();
    });

    const dashRefresh = document.getElementById('adm-dashboard-refresh');
    if (dashRefresh) {
      dashRefresh.addEventListener('click', function () {
        if (state.currentView === 'dashboard') loadDashboard();
      });
    }

    document.getElementById('adm-report-detail-close').addEventListener('click', function () {
      clearReportDetailPanel();
    });
    document.getElementById('adm-report-detail-overlay').addEventListener('click', function (e) {
      if (e.target.id === 'adm-report-detail-overlay') clearReportDetailPanel();
    });
    document.getElementById('adm-search-reports').addEventListener('input', function () {
      renderReportsTable();
    });
    document.getElementById('adm-filter-reports').addEventListener('change', function () {
      renderReportsTable();
    });

    function hideReportDeleteOverlay() {
      document.getElementById('adm-report-delete-overlay').classList.add('adm-modal-overlay--hidden');
    }

    async function submitAdminReportChat() {
      const inp = document.getElementById('adm-report-chat-input');
      const text = inp && inp.value.trim();
      if (!text || text.length < 5) return;
      const id = state.selectedReportId;
      if (id == null) return;
      inp.value = '';
      await postNui('action', { action: 'replyReport', reportId: id, message: text });
      await loadReportsList();
    }

    async function submitPlayerReportChat() {
      const inp = document.getElementById('pr-chat-input');
      const text = inp && inp.value.trim();
      if (!text || text.length < 5) return;
      const id = prUi.currentDetailId;
      if (id == null) return;
      inp.value = '';
      await postNui('playerReportReply', { reportId: id, message: text });
      await prOpenDetail(id);
    }

    function bindChatComposerEnter(textareaId, submitFn) {
      const el = document.getElementById(textareaId);
      if (!el) return;
      el.addEventListener('keydown', function (e) {
        if (e.key !== 'Enter' || e.shiftKey) return;
        e.preventDefault();
        submitFn();
      });
    }

    const admChatSend = document.getElementById('adm-report-chat-send');
    if (admChatSend) admChatSend.addEventListener('click', submitAdminReportChat);
    bindChatComposerEnter('adm-report-chat-input', submitAdminReportChat);

    const prChatSend = document.getElementById('pr-chat-send');
    if (prChatSend) prChatSend.addEventListener('click', submitPlayerReportChat);
    bindChatComposerEnter('pr-chat-input', submitPlayerReportChat);

    const staffChatSend = document.getElementById('adm-staff-chat-send');
    if (staffChatSend) staffChatSend.addEventListener('click', submitStaffChat);
    bindChatComposerEnter('adm-staff-chat-input', submitStaffChat);

    document.getElementById('adm-report-delete-close').addEventListener('click', hideReportDeleteOverlay);
    document.getElementById('adm-report-delete-cancel').addEventListener('click', hideReportDeleteOverlay);
    document.getElementById('adm-report-delete-confirm').addEventListener('click', async function () {
      const reason = document.getElementById('adm-report-delete-reason').value.trim();
      if (reason.length < 5) return;
      const id = state.selectedReportId;
      hideReportDeleteOverlay();
      await postNui('action', { action: 'deleteReport', reportId: id, reason: reason });
      await loadReportsList();
    });

    document.getElementById('adm-pr-btn-close').addEventListener('click', function () {
      closePlayerReportUi();
    });

    document.getElementById('pr-btn-mine').addEventListener('click', async function () {
      await prLoadMyReports();
      prShowView('list');
    });

    document.getElementById('pr-back-list').addEventListener('click', function () {
      prShowView('home');
    });

    document.getElementById('pr-refresh-list').addEventListener('click', function () {
      prLoadMyReports();
    });

    document.getElementById('pr-form').addEventListener('submit', async function (e) {
      e.preventDefault();
      if (prIsCoolingDown()) {
        const cooldownEl = document.getElementById('pr-cooldown-msg');
        if (cooldownEl) cooldownEl.classList.remove('adm-view--hidden');
        prUpdateCooldownBanner();
        return;
      }
      const errEl = document.getElementById('pr-form-error');
      const title = document.getElementById('pr-input-title').value.trim();
      const desc = document.getElementById('pr-input-desc').value.trim();
      if (title.length < 5 || title.length > 100) {
        errEl.classList.remove('adm-view--hidden');
        errEl.textContent = 'Title: between 5 and 100 characters.';
        return;
      }
      if (desc.length < 10 || desc.length > 500) {
        errEl.classList.remove('adm-view--hidden');
        errEl.textContent = 'Description: between 10 and 500 characters.';
        return;
      }
      errEl.classList.add('adm-view--hidden');
      errEl.textContent = '';

      const reportData = {
        reportType: 'question',
        title: title,
        description: desc,
        reportedPlayerId: null,
        imageUrl: null,
      };
      const img = document.getElementById('pr-input-image').value.trim();
      if (img !== '') reportData.imageUrl = img;

      await postNui('playerReportCreate', reportData);
      prStartCooldown();
      prResetForm();
      prShowView('home');
    });

    document.getElementById('pr-detail-close').addEventListener('click', function () {
      document.getElementById('pr-detail-overlay').classList.add('adm-modal-overlay--hidden');
    });
    document.getElementById('pr-detail-overlay').addEventListener('click', function (e) {
      if (e.target.id === 'pr-detail-overlay') {
        document.getElementById('pr-detail-overlay').classList.add('adm-modal-overlay--hidden');
      }
    });

    document.getElementById('pr-detail-copy-url').addEventListener('click', function () {
      const a = document.getElementById('pr-detail-image-link');
      const u = a && a.href;
      if (u) postNui('action', { action: 'setClipboard', text: u });
    });

    window.addEventListener('keydown', function (e) {
      if (e.key === 'Escape') {
        if (prEscapeStackClose()) return;
        const offOv = document.getElementById('adm-ban-offline-overlay');
        if (offOv && !offOv.classList.contains('adm-modal-overlay--hidden')) {
          closeOfflineBanModal();
          return;
        }
        const banOv = document.getElementById('adm-ban-detail-overlay');
        if (banOv && !banOv.classList.contains('adm-modal-overlay--hidden')) {
          clearBanDetailPanel();
          return;
        }
        closeUi();
      }
    });
  });

  window.addEventListener('message', function (event) {
    const data = event.data;
    if (!data || typeof data !== 'object') return;
    if (data.type === 'open') {
      openFromMessage(data);
    } else if (data.type === 'openPlayerReport') {
      openPlayerReportUi(data);
    } else if (data.type === 'newReport') {
      showNewReportToast(data);
    } else if (data.type === 'adminChatMessage' && data.payload) {
      ingestAdminChatMessage(data.payload, true);
    } else if (data.type === 'weatherSyncState' && data.payload) {
      applyWeatherSyncState(data.payload);
    } else if (data.type === 'screenAnnounce' && data.payload) {
      showScreenAnnounceOverlay(data.payload);
    }
  });
})();
