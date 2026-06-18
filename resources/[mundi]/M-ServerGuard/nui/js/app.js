var IS_INGAME = typeof window.invokeNative !== 'undefined' ||
                window.location.href.includes('nui://') ||
                window.location.protocol === 'nui:' ||
                (function() { try { return typeof GetParentResourceName !== 'undefined'; } catch(e) { return false; } })();
document.documentElement.dataset.env = IS_INGAME ? 'ingame' : 'browser';

// Ammo hash → display name map (built from rdr3_discoveries/weapons/ammo_types.lua)
var AMMO_HASH_MAP = {
    '0x7DF4D025': 'Ammo .22', '0x8E919F27': 'Ammo .22 Tranquilizer',
    '0x38E6F55F': 'Arrow', '0x1F901FAE': 'Arrow (Confusion)', '0xDC6FE2FE': 'Arrow (Disorient)',
    '0xA3B9DB42': 'Arrow (Drain)', '0xC1F57A79': 'Arrow (Dynamite)', '0x11B25B49': 'Arrow (Fire)',
    '0x9238061F': 'Arrow (Improved)', '0x07865A92': 'Arrow (Poison)', '0xAE6E2B0E': 'Arrow (Small Game)',
    '0x62CEC038': 'Arrow (Tracking)', '0xF680010B': 'Arrow (Trail)', '0xB6731F5A': 'Arrow (Wound)',
    '0x020C7A4A': 'Bolas', '0x22E119A9': 'Bolas (Hawkmoth)', '0x9AB3E5C1': 'Bolas (Intertwined)', '0x87BA17E6': 'Bolas (Iron-Spiked)',
    '0xB6976AA1': 'Cannon Ball', '0x1C9D6E9D': 'Dynamite', '0x321BA159': 'Dynamite (Volatile)',
    '0x194631D6': 'Hatchet', '0xA9708E57': 'Hatchet (Ancient)', '0xB925EC32': 'Hatchet (Cleaver)',
    '0x63A5047F': 'Hatchet (Double-Bit)', '0xCABE0C0F': 'Hatchet (Double-Bit Rusted)', '0x8507C1F7': 'Hatchet (Hewing)',
    '0x1AA32EB0': 'Hatchet (Hunter)', '0xBEDC8EB6': 'Hatchet (Hunter Rusted)', '0xE501537B': 'Hatchet (Viking)',
    '0xEAD00129': 'Lasso', '0xAE802EDC': 'Lasso (Reinforced)',
    '0x5633F9D5': 'Molotov', '0x886C55D7': 'Molotov (Volatile)',
    '0x631C84FC': 'Moonshine Jug', '0x656A2F3B': 'Moonshine Jug (MP)',
    '0x743D4F54': 'Pistol Ammo', '0x31E2AD5B': 'Pistol Express', '0x46A648C2': 'Pistol Express Explosive',
    '0xABD96830': 'Pistol High Velocity', '0x0E163B80': 'Pistol Split Point',
    '0x39714C4F': 'Poison Bottle',
    '0xB0B80B9A': 'Repeater Ammo', '0xDD871DC8': 'Repeater Express', '0x9C8B6796': 'Repeater Express Explosive',
    '0x0DCBE210': 'Repeater High Velocity', '0x44750C88': 'Repeater Split Point',
    '0x64356159': 'Revolver Ammo', '0x4970588D': 'Revolver Express', '0x04A8EFBB': 'Revolver Express Explosive',
    '0x83C5E860': 'Revolver High Velocity', '0x4A25B008': 'Revolver Split Point',
    '0x0D05319F': 'Rifle Ammo', '0xB392591E': 'Rifle (Elephant)', '0x62A11A4B': 'Rifle Express',
    '0x6D926443': 'Rifle Express Explosive', '0x6ECB67F9': 'Rifle High Velocity', '0x0BEFA5B2': 'Rifle Split Point',
    '0x90083D3B': 'Shotgun', '0xBFCB2621': 'Shotgun Incendiary', '0x12C60041': 'Shotgun Slug', '0x2314B32A': 'Shotgun Slug Explosive',
    '0x9E4AD291': 'Throwing Knife', '0x9117CF91': 'Throwing Knife (Confusion)', '0x59DCB686': 'Throwing Knife (Disorient)',
    '0x6D0020AB': 'Throwing Knife (Drain)', '0x48DC05F6': 'Throwing Knife (Improved)', '0xF51D1AC7': 'Throwing Knife (Javier)',
    '0x7BA5E56E': 'Throwing Knife (Poison)', '0x4BC1020F': 'Throwing Knife (Trail)', '0x9143D131': 'Throwing Knife (Wound)',
    '0xCE156C30': 'Thrown Item',
    '0x49A985D7': 'Tomahawk', '0xF25D45BC': 'Tomahawk (Ancient)', '0xABD7C401': 'Tomahawk (Homing)', '0xCE489834': 'Tomahawk (Improved)',
    '0xBA2D509B': 'Turret Ammo'
};

function resolveAmmoHash(details) {
    if (!details) return details;
    return details.replace(/0x([0-9A-Fa-f]+)/g, function(match) {
        var upper = '0x' + match.slice(2).toUpperCase();
        return AMMO_HASH_MAP[upper] ? (AMMO_HASH_MAP[upper] + ' (' + upper + ')') : match;
    });
}

window.App = (function () {
    'use strict';

    var state = {
        currentPage: 'dashboard',
        dashboardData: null,
        playerList: null,
        playerDetail: null,
        playerDetailTab: 'overview',
        pdItemFilter: { search: '', action: 'all' },
        alertList: null,
        economyLog: null,
        economySummary: null,
        detectionList: null,
        adminLog: null,
        resourceList: null,
        banList: null,
        appealList: null,

        teleportLocations: null,
        serverStatus: null,
        reportList: null,
        reportDetail: null,
        leaderboardData: null,
        serverStatistics: null,
        itemLog: null,
        itemDistribution: null,
        playerPage: 1,
        banPage: 1,
        warningPage: 1,
        warningList: null,
        blipList: null,
        adminList: null,
        liveMapData: null,
        liveMapTimer: null,
        restartStatus: null,
        itemSearchResults: null,
        allItems: null,
        itemIntelligence: null,
        serverItemTotals: null,
        itemHolders: null,
        itemVelocity: null,
        itemTimeline: null,
        combatLog: null,
        combatStats: null,
        itemTransfers: null,
        playerTimeline: null,
        itemAnomalies: null,
        itemWatchlist: null,
        watchTargetPlayers: [],
        watchEditId: null,
        watchEditTargets: [],
        jobDistribution: null,
        editingBlipId: null,
        ownCoords: null,
        coordsTimer: null,
        editingBanId: null,
        autoRefreshTimer: null,
        pendingAction: null,
        adminName: 'Admin',
        activeItemsSubtab: 'overview',
        serverFramework: null,
        screeningList: null,
        screeningFilter: 'all',
        screeningSearch: '',
        screeningConfig: null,
        communityQueueList: null,
        communityQueuePage: 1,
    communitySyncList: [],
    communitySyncPage: 1,
    itemDbPage: 1,
    itemDbPageSize: 100,
    };
function init() {
        var env = Utils.detectEnvironment();
        document.documentElement.dataset.env = (env === 'nui') ? 'ingame' : 'browser';
        if (env === 'browser') {
            document.body.classList.add('browser-mode');
            // Dev bypass: server injects window.MGUARD_DEV_MODE=true when DevBypassAuth=true in configs/web.lua
            if (window.MGUARD_DEV_MODE) {
                localStorage.setItem('mguard_web_token', 'dev_bypass');
                state.adminName = 'DevAdmin';
                state.adminGroup = 'owner';
                state.adminSteam = 'steam:dev_bypass';
                showApp();
            } else {
                var token = localStorage.getItem('mguard_web_token');
                if (token) {
                    Utils.validateWebToken(token).then(function (res) {
                        if (res && res.valid) {
                            if (res.name) state.adminName = res.name;
                            if (res.admin && res.admin.group) state.adminGroup = res.admin.group;
                            if (res.admin && res.admin.steam) state.adminSteam = res.admin.steam;
                            showApp();
                        } else {
                            localStorage.removeItem('mguard_web_token');
                            showLogin();
                        }
                    }).catch(function () { showLogin(); });
                } else {
                    showLogin();
                }
            }
        } else {
            // In-game NUI: login screen starts hidden by default (class in HTML); nothing to show until openDashboard event
        }
        bindNavigation();
        bindSearch();
        bindActions();
        bindModals();
        listenMessages();
        wrapTablesForMobile();
    }
function wrapTablesForMobile() {
        document.querySelectorAll('.tbl').forEach(function (tbl) {
            if (tbl.parentNode && !tbl.parentNode.classList.contains('tbl-scroll')) {
                var wrap = document.createElement('div');
                wrap.className = 'tbl-scroll';
                tbl.parentNode.insertBefore(wrap, tbl);
                wrap.appendChild(tbl);
            }
        });
    }

    function showLogin() {
        document.getElementById('login-screen').classList.remove('hidden');
        document.getElementById('app').classList.remove('active');
        document.getElementById('app').classList.add('hidden');
        document.getElementById('btn-login').onclick = function () {
            var tok = document.getElementById('login-token').value.trim();
            if (!tok) return;
            Utils.validateWebToken(tok).then(function (res) {
                if (res && res.valid) {
                    localStorage.setItem('mguard_web_token', tok);
                    if (res.name) state.adminName = res.name;
                    if (res.admin && res.admin.group) state.adminGroup = res.admin.group;
                    if (res.admin && res.admin.steam) state.adminSteam = res.admin.steam;
                    showApp();
                } else {
                    var err = document.getElementById('login-error');
                    err.textContent = (res && res.message) || 'Invalid token';
                    err.classList.remove('hidden');
                }
            }).catch(function () {
                document.getElementById('login-error').textContent = 'Connection failed';
                document.getElementById('login-error').classList.remove('hidden');
            });
        };
    }

    function showApp() {
        document.getElementById('login-screen').classList.add('hidden');
        document.getElementById('app').classList.remove('hidden');
        document.getElementById('app').classList.add('active');
        initTheme();
        var nameEl = document.getElementById('admin-name-display');
        if (nameEl) nameEl.textContent = state.adminName || '';
        navigateTo('dashboard');
        startAutoRefresh();
        // Pre-load items list so item search works everywhere without visiting items page first
        setTimeout(function() {
            if (!state.allItems) Utils.nuiCallback('getAllItems', {}).catch(function() {});
        }, 2000);
    }
function initTheme() {
        var saved = localStorage.getItem('mguard_theme') || 'dark';
        applyTheme(saved);
        var btn = document.getElementById('btn-theme-toggle');
        if (btn) {
            btn.addEventListener('click', function () {
                var current = document.documentElement.classList.contains('light') ? 'light' : 'dark';
                var next = current === 'dark' ? 'light' : 'dark';
                applyTheme(next);
                localStorage.setItem('mguard_theme', next);
            });
        }
    }
    function applyTheme(theme) {
        if (theme === 'light') {
            document.documentElement.classList.add('light');
        } else {
            document.documentElement.classList.remove('light');
        }
        var btn = document.getElementById('btn-theme-toggle');
        if (btn) btn.innerHTML = theme === 'light' ? '<i class="fa-solid fa-sun" style="font-size:12px"></i>' : '<i class="fa-solid fa-moon" style="font-size:12px"></i>';
    }
function showPageLoading(pageId) {
        if (document.querySelector('.loading-overlay')) return;
        // Prevent live-dot and overlay from showing simultaneously
        var liveDot = document.getElementById('live-indicator');
        if (liveDot) liveDot.classList.remove('loading');
        var overlay = document.createElement('div');
        overlay.className = 'loading-overlay';
        overlay.dataset.page = pageId || '';
        overlay.innerHTML = '<div class="spinner"><div class="spinner-ring"></div><div class="spinner-text">Loading...</div></div>';
        document.body.appendChild(overlay);
        // Safety net: auto-remove after 8s if server never responds
        setTimeout(function () { hidePageLoading(pageId); }, 8000);
    }
    function hidePageLoading(pageId) {
        var overlay = document.querySelector('.loading-overlay');
        if (overlay) overlay.remove();
    }
function listenMessages() {
        window.addEventListener('message', function (e) {
            var d = e.data;
            if (!d || !d.action) return;

            switch (d.action) {
                case 'openDashboard':
                    // Store the NUI session token so API calls authenticate properly
                    // when DevBypassAuth = false (production mode)
                    if (d.webToken) {
                        localStorage.setItem('mguard_web_token', d.webToken);
                    }
                    document.getElementById('app').classList.remove('hidden');
                    document.getElementById('app').classList.add('active');
                    navigateTo('dashboard');
                    startAutoRefresh();
                    break;

                case 'closeDashboard':
                    closeApp();
                    break;

                case 'dashboardData':
                    state.dashboardData = d.data;
                    if (state.currentPage === 'dashboard') renderDashboard();
                    break;

                case 'playerList':
                    state.playerList = d.data;
                    // Cache player names for search autocomplete
                    if (d.data && d.data.players) {
                        var existing = state.cachedPlayerNames || [];
                        var newNames = d.data.players.map(function(p) { return { name: p.name || p.player_name || '', steam: p.steam || '', char_name: p.char_name || '', discord: p.discord || '', char_identifier: p.char_identifier || '', online: true }; });
                        // Merge, dedupe by steam
                        var steamSet = {};
                        newNames.forEach(function(p) { if (p.steam) steamSet[p.steam] = p; });
                        existing.forEach(function(p) { if (p.steam && !steamSet[p.steam]) steamSet[p.steam] = p; });
                        state.cachedPlayerNames = Object.values(steamSet).slice(0, 500);
                        // Re-invoke any open player filter dropdowns that showed "No matching"
                        var openInputs = document.querySelectorAll('.log-filter-player-input[data-filtering="1"]');
                        openInputs.forEach(function(inp) {
                            var q = inp.value.trim();
                            if (q.length >= 2) showPlayerFilterDropdown(inp, q, inp._filterCallback || function(){});
                        });
                    }
                    if (state.currentPage === 'players') renderPlayerList();
                    break;

                case 'playerDetail':
                    state.playerDetail = d.data;
                    var pdSteam = state.playerDetail && state.playerDetail.steam;
                    if (pdSteam) {
                        Utils.nuiCallback('getPlayerNotes', { steam: pdSteam }).then(function(nr) {
                            if (state.playerDetail) state.playerDetail.notes_list = (nr && nr.notes) || [];
                            renderPlayerDetail();
                            // Load pending actions for offline players
                            var isOnline = state.playerDetail && (state.playerDetail.is_online || state.playerDetail.isOnline);
                            if (!isOnline) {
                                Utils.nuiCallback('getPendingActions', { steam: pdSteam }).catch(function(){});
                            }
                        }).catch(function() { renderPlayerDetail(); });
                    } else {
                        renderPlayerDetail();
                    }
                    break;

                case 'alertList':
                    state.alertList = d.data;
                    if (state.currentPage === 'alerts') renderAlerts();
                    break;

                case 'economyLog':
                    state.economyLog = d.data;
                    if (state.currentPage === 'economy') renderEconomy();
                    break;

                case 'economySummary':
                    state.economySummary = d.data;
                    if (state.currentPage === 'economy') renderEconomySummary();
                    break;

                case 'economyHistory':
                    state.economyHistory = d.data;
                    state.economyHistoryRange = d.range || '24h';
                    if (state.currentPage === 'economy') requestAnimationFrame(renderWealthGraph);
                    break;

                case 'economyDrilldown':
                    if (state.currentPage === 'economy') renderWealthDrilldown(d.data);
                    break;

                case 'detectionList':
                case 'detections':
                    state.detectionList = d.data;
                    if (state.currentPage === 'anticheat') renderDetections();
                    break;

                case 'adminLog':
                    state.adminLog = d.data;
                    if (state.currentPage === 'logs') renderAdminLog();
                    break;

                case 'resourceList':
                    state.resourceList = d.data;
                    if (state.currentPage === 'resources') renderResources();
                    break;

                case 'banList':
                    state.banList = d.data;
                    if (state.currentPage === 'bans') renderBans();
                    break;

                case 'pendingActions':
                    renderPendingActionsList(d.data);
                    break;

                case 'communityQueueList':
                    state.communityQueueList = d.data;
                    if (state.currentPage === 'bans') renderCommunityQueue();
                    break;
                case 'communitySyncList':
                    state.communitySyncList = d.data.entries || d.data || [];
                    if (state.currentPage === 'bans') renderCommunitySync();
                    break;

                case 'appealList':
                    state.appealList = d.data;
                    if (state.currentPage === 'bans') renderAppeals();
                    break;

                case 'chatLog':
                    state.chatLog = d.data;
                    if (state.currentPage === 'chat') renderChatLog();
                    break;

                case 'teleportLocations':
                    state.teleportLocations = d.data;
                    if (state.currentPage === 'teleports') renderTeleports();
                    break;

                case 'serverManagement':
                    state.serverStatus = d.data;
                    if (state.currentPage === 'server') renderServerManagement();
                    break;

                

                case 'reportList':
                    state.reportList = d.data;
                    if (state.currentPage === 'reports') renderReports();
                    break;

                case 'reportDetail':
                    state.reportDetail = d.data;
                    renderReportDetail();
                    break;

                

                

                case 'leaderboardData':
                    state.leaderboardData = d.data;
                    if (state.currentPage === 'statistics') {
                        hidePageLoading('statistics');
                        renderLeaderboard();
                    }
                    break;

                case 'serverStatistics':
                    state.serverStatistics = d.data;
                    if (state.currentPage === 'statistics') renderStatisticsOverview();
                    break;

                case 'itemLog':
                    state.itemLog = d.data;
                    if (state.currentPage === 'items') renderItemLog();
                    break;

                case 'itemDistribution':
                    state.itemDistribution = d.data;
                    if (state.currentPage === 'items') renderItemDistribution();
                    break;

                case 'playerInventory':
                    renderPlayerInventoryModal(d.data);
                    break;

                case 'playerScreening':
                    renderPlayerScreeningModal(d.data);
                    break;

                case 'warningList':
                    state.warningList = d.data;
                    if (state.currentPage === 'warnings') renderWarnings();
                    break;

                case 'blipList':
                    // Clear confirmed-deleted blips from the pending-deletion guard
                    if (d.data && pendingBlipDeletions) {
                        var arrivedIds = (d.data || []).map(function (b) { return String(b.id); });
                        Object.keys(pendingBlipDeletions).forEach(function (k) {
                            if (arrivedIds.indexOf(k) === -1) delete pendingBlipDeletions[k];
                        });
                    }
                    state.blipList = d.data;
                    if (state.currentPage === 'blips' || state.currentPage === 'livemap') renderBlips();
                    if (state.currentPage === 'livemap') updateLeafletBlips(state.blipList || []);
                    break;

                case 'adminList':
                    state.adminList = d.data;
                    if (state.currentPage === 'admins') renderAdmins();
                    break;

                case 'liveMapData':
                    state.liveMapData = d.data;
                    if (state.currentPage === 'livemap') renderLiveMap();
                    break;

                case 'playerCoords':
                    if (d.data) Utils.showToast('Coords: ' + d.data.x.toFixed(2) + ', ' + d.data.y.toFixed(2) + ', ' + d.data.z.toFixed(2), 'info');
                    break;

                case 'ownCoords':
                    state.ownCoords = d.data;
                    if (state.currentPage === 'coords') renderCoords();
                    break;

                case 'itemSearchResults':
                    state.itemSearchResults = d.data;
                    renderItemSearchResults();
                    break;

                case 'allItems':
                    state.allItems = d.data;
                    renderItemDatabase();
                    populateWatchTypeFilter();
                    renderWatchItemGrid();
                    break;

                case 'itemIntelligence':
                    state.itemIntelligence = d.data;
                    renderItemIntelKpis();
                    break;

                case 'serverItemTotals':
                    state.serverItemTotals = d.data;
                    renderServerItemTotals();
                    break;

                case 'itemHolders':
                    state.itemHolders = d.data;
                    renderItemHolders();
                    break;

                case 'itemVelocity':
                    state.itemVelocity = d.data;
                    renderItemVelocity();
                    break;

                case 'itemTimeline':
                    state.itemTimeline = d.data;
                    renderItemTimelineTab();
                    break;

                case 'itemAnomalies':
                    state.itemAnomalies = d.data;
                    renderItemAnomalies();
                    break;

                case 'itemWatchlist':
                    state.itemWatchlist = d.data;
                    renderItemWatchlist();
                    break;

                case 'watchPlayerSearch':
                    renderWatchPlayerSearchResults(d.data || []);
                    break;

                case 'jobDistribution':
                    state.jobDistribution = d.data;
                    if (state.currentPage === 'statistics') renderJobDistribution();
                    break;

                case 'restartStatus':
                    state.restartStatus = d.data;
                    break;

                case 'liveAlert':
                    Utils.showToast((d.data && d.data.title) || 'Alert', 'warning');
                    break;

                case 'webTokenGenerated':
                    if (d.data && d.data.token) {
                        var ta = document.createElement('textarea');
                        ta.value = d.data.token;
                        ta.style.cssText = 'position:fixed;opacity:0';
                        document.body.appendChild(ta);
                        ta.select();
                        document.execCommand('copy');
                        document.body.removeChild(ta);
                        Utils.showToast('Token copied to clipboard', 'success');
                    }
                    break;

                case 'receiveCombatLog':
                    state.combatLog = d.data;
                    if (state.currentPage === 'combat') renderCombatLog();
                    break;

                case 'receiveCombatStats':
                    state.combatStats = d.data;
                    if (state.currentPage === 'combat') renderCombatStats();
                    break;

                case 'receiveItemTransfers':
                    state.itemTransfers = d.data;
                    renderItemTransfers();
                    break;

                case 'receivePlayerTimeline':
                    state.playerTimeline = d.data;
                    renderPlayerTimeline();
                    break;

                case 'weatherData':
                    if (state.serverStatus) {
                        Object.assign(state.serverStatus, d.data || {});
                    } else {
                        state.serverStatus = d.data;
                    }
                    if (state.currentPage === 'server') renderServerManagement();
                    break;

                case 'whitelistData':
                    state.whitelistList = d.data;
                    if (state.currentPage === 'whitelist') renderWhitelist();
                    break;

                case 'screeningList':
                    state.screeningList = d.data || [];
                    if (state.currentPage === 'screening') renderScreeningTable();
                    break;

                case 'screeningConfig':
                    state.screeningConfig = d.data || {};
                    renderScreeningConfigForm(state.screeningConfig);
                    break;

                case 'saveScreeningConfig':
                    var statusEl = document.getElementById('sc-settings-status');
                    if (statusEl) statusEl.textContent = d.ok ? '✓ Saved successfully' : '✗ Save failed';
                    break;

                case 'watchSearchResults':
                    renderWatchPlayerSearchResults(d.data || []);
                    break;

                case 'setFramework':
                    state.serverFramework = d.data;
                    break;
            }
        });
    }
function bindNavigation() {
        document.querySelectorAll('.nav-item').forEach(function (el) {
            el.addEventListener('click', function () {
                navigateTo(el.dataset.page);
                // On mobile, close sidebar after selecting a page
                if (window.innerWidth <= 900) closeSidebar();
            });
        });
        document.getElementById('btn-close').addEventListener('click', function () {
            closeApp();
        });
var hamburger = document.getElementById('btn-hamburger');
        var overlay = document.getElementById('sidebar-overlay');
        var sidebar = document.getElementById('sidebar');
        if (hamburger) {
            hamburger.addEventListener('click', function () {
                var isOpen = sidebar.classList.contains('open');
                if (isOpen) closeSidebar(); else openSidebar();
            });
        }
        if (overlay) {
            overlay.addEventListener('click', function () { closeSidebar(); });
        }
        window.addEventListener('resize', function () {
            if (window.innerWidth > 900) closeSidebar(true);
        });
    }

    function openSidebar() {
        var sidebar = document.getElementById('sidebar');
        var overlay = document.getElementById('sidebar-overlay');
        var hamburger = document.getElementById('btn-hamburger');
        if (sidebar) sidebar.classList.add('open');
        if (overlay) overlay.classList.add('visible');
        if (hamburger) {
            hamburger.querySelector('span:nth-child(1)') && (hamburger.querySelectorAll('span')[0].style.transform = 'translateY(6px) rotate(45deg)');
            hamburger.querySelectorAll('span')[1].style.opacity = '0';
            hamburger.querySelectorAll('span')[2].style.transform = 'translateY(-6px) rotate(-45deg)';
        }
    }

    function closeSidebar(silent) {
        var sidebar = document.getElementById('sidebar');
        var overlay = document.getElementById('sidebar-overlay');
        var hamburger = document.getElementById('btn-hamburger');
        if (sidebar) sidebar.classList.remove('open');
        if (overlay) overlay.classList.remove('visible');
        if (hamburger) {
            hamburger.querySelectorAll('span').forEach(function(s) { s.style.transform = ''; s.style.opacity = ''; });
        }
    }

    var REFRESH_INTERVALS = {
        dashboard: 30, players: 20, economy: 45, items: 45,
        alerts: 15, anticheat: 15, bans: 60, resources: 30,
        logs: 60, reports: 30, statistics: 60,
        warnings: 60, combat: 45, screening: 30,
        livemap: 10, admins: 60, whitelist: 60,
        teleports: 120, server: 30, spawner: 120, coords: 3
    };

    function navigateTo(page) {
        // Blips are now integrated into Live Map
        if (page === 'blips') page = 'livemap';
        state.currentPage = page;
        // Scroll pages container back to top on every page navigation
        var pagesEl = document.getElementById('pages');
        if (pagesEl) pagesEl.scrollTop = 0;
        // Also reset any inner table scrollers so tables don't appear mid-scroll
        document.querySelectorAll('.tbl-scroll').forEach(function(el) { el.scrollTop = 0; });
        document.querySelectorAll('.nav-item').forEach(function (n) {
            n.classList.toggle('active', n.dataset.page === page);
        });
        document.querySelectorAll('.page').forEach(function (p) {
            p.classList.toggle('active', p.id === 'page-' + page);
        });
        var titles = {
            dashboard: 'Dashboard', players: 'Players', economy: 'Economy', items: 'Items',
            combat: 'Combat Log',
            alerts: 'Alerts', anticheat: 'Anti-Cheat', bans: 'Bans', resources: 'Resources',
            logs: 'Admin Logs', teleports: 'Teleports', server: 'Server Control',
            reports: 'Reports', statistics: 'Statistics',
            livemap: 'Live Map & Blips', spawner: 'Entity Spawner', admins: 'Admins', warnings: 'Warnings',
            coords: 'Coordinates', chat: 'Chat Log', whitelist: 'Whitelist', screening: 'Screening'
        };
        document.getElementById('page-title').textContent = titles[page] || page;
        requestPageData(page);
        // Reset refresh countdown to this page's interval
        resetRefreshCountdown();
    }

    function requestPageData(page, silent) {
        if (!silent) showPageLoading(page);
        switch (page) {
            case 'dashboard':
                Utils.nuiCallback('getDashboardData', {}).catch(function() { hidePageLoading('dashboard'); }); break;
            case 'players':
                Utils.nuiCallback('getPlayerList', { page: state.playerPage }).catch(function() { hidePageLoading('players'); }); break;
            case 'economy':
                Utils.nuiCallback('getEconomyLog', { filters: getEconomyFilters() }).catch(function() { hidePageLoading('economy'); });
                Utils.nuiCallback('getEconomySummary', {}).catch(function() {});
                Utils.nuiCallback('getEconomyHistory', { range: state.economyHistoryRange || '24h' }).catch(function() {});
                break;
            case 'items':
                // Always refresh KPIs
                Utils.nuiCallback('getItemIntelligence', {}).catch(function() { hidePageLoading('items'); });
                // Only refresh data for the active subtab
                var activeSub = state.activeItemsSubtab || 'overview';
                if (activeSub === 'overview') {
                    Utils.nuiCallback('getItemDistribution', {}).catch(function() {});
                    Utils.nuiCallback('getServerItemTotals', {}).catch(function() {});
                } else if (activeSub === 'log') {
                    Utils.nuiCallback('getItemLog', getItemFilters()).catch(function() {});
                } else if (activeSub === 'browser') {
                    if (!state.allItems) Utils.nuiCallback('getAllItems', {}).catch(function() {});
                } else if (activeSub === 'watchlist') {
                    Utils.nuiCallback('getItemWatchlist', {}).catch(function() {});
                    if (!state.serverItemTotals) {
                        Utils.nuiCallback('getServerItemTotals', {}).catch(function() {});
                    }
                    if (!state.allItems) {
                        Utils.nuiCallback('getAllItems', {}).catch(function() {});
                    } else {
                        populateWatchTypeFilter();
                        renderWatchItemGrid();
                    }
                } else if (activeSub === 'anomalies') {
                    Utils.nuiCallback('getItemAnomalies', {}).catch(function() {});
                } else if (activeSub === 'transfers') {
                    Utils.nuiCallback('getItemTransfers', getTransferFilters()).catch(function() {});
                }
                bindItemsSubtabs();
                break;
            case 'alerts':
                Utils.nuiCallback('getAlerts', getAlertFilters()).catch(function() { hidePageLoading('alerts'); }); break;
            case 'anticheat':
                Utils.nuiCallback('getDetections', getDetectionFilters()).catch(function() { hidePageLoading('anticheat'); }); break;
            case 'bans':
                Utils.nuiCallback('getBanList', { page: state.banPage }).catch(function() { hidePageLoading('bans'); });
                Utils.nuiCallback('getCommunityQueue', { page: 1, status: 'pending' }).catch(function() {}); break;
            case 'resources':
                Utils.nuiCallback('getResourceList', {}).catch(function() { hidePageLoading('resources'); }); break;
            case 'logs':
                Utils.nuiCallback('getAdminLog', getAdminLogFilters()).catch(function() { hidePageLoading('logs'); });
                Utils.nuiCallback('getAdminLogActions', {}).then(function(res) {
                    if (res && res.actions) {
                        var dl = document.getElementById('log-action-datalist');
                        if (dl) dl.innerHTML = res.actions.map(function(a) { return '<option value="' + Utils.escapeHtml(a) + '">'; }).join('');
                    }
                }).catch(function() {});
                break;
            case 'chat':
                Utils.nuiCallback('getChatLog', getChatFilters()).catch(function() { hidePageLoading('chat'); }); break;
            case 'teleports':
                Utils.nuiCallback('getTeleportLocations', {}).catch(function() { hidePageLoading('teleports'); }); break;
            case 'server':
                Utils.nuiCallback('getServerManagement', {}).catch(function() { hidePageLoading('server'); }); break;
                        case 'reports':
                Utils.nuiCallback('getReports', { filters: getReportFilters() }).catch(function() { hidePageLoading('reports'); }); break;
                        case 'statistics':
                Utils.nuiCallback('getServerStatistics', {}).catch(function() { hidePageLoading('statistics'); });
                Utils.nuiCallback('getLeaderboard', { metric: getLeaderboardMetric() }).catch(function() {});
                Utils.nuiCallback('getJobDistribution', {}).catch(function() {});
                break;
            case 'livemap':
                Utils.nuiCallback('getLiveMapData', {}).catch(function() { hidePageLoading('livemap'); });
                Utils.nuiCallback('getBlips', {}).catch(function() {});
                Utils.nuiCallback('getPlayerList', { page: 1, all: true }).catch(function() {});
                startLiveMapAutoRefresh();
                initLeafletMap();
                break;
            case 'spawner':
                hidePageLoading(page);
                populateSpawnerTargets();
                renderSpawnerPresets();
                break;
            case 'blips':
                // Blips merged into livemap — redirect data loading
                Utils.nuiCallback('getLiveMapData', {}).catch(function() {});
                Utils.nuiCallback('getBlips', {}).catch(function() { hidePageLoading('blips'); });
                populateBlipPresets();
                break;
            case 'admins':
                Utils.nuiCallback('getAdminList', {}).catch(function() { hidePageLoading('admins'); }); break;
            case 'warnings':
                Utils.nuiCallback('getWarnings', { page: state.warningPage }).catch(function() { hidePageLoading('warnings'); }); break;
            case 'screening':
                loadScreeningPage(); break;
            case 'whitelist':
                Utils.nuiCallback('getWhitelist', { page: state.whitelistPage || 1 }).catch(function() { hidePageLoading('whitelist'); }); break;
            case 'coords':
                hidePageLoading(page);
                Utils.nuiCallback('getOwnCoords', {});
                startCoordsUpdate();
                break;
            case 'combat':
                Utils.nuiCallback('getCombatStats', {}).catch(function() { hidePageLoading('combat'); });
                Utils.nuiCallback('getCombatLog', getCombatFilters()).catch(function() {});
                break;
        }
    }

    function refreshCurrentPage() {
        // Don't refresh if user is typing
        var focused = document.activeElement;
        if (focused && (focused.tagName === 'INPUT' || focused.tagName === 'TEXTAREA' || focused.tagName === 'SELECT')) {
            return; // Defer refresh — user is interacting
        }
        requestPageData(state.currentPage, true); // silent=true: no loading overlay on auto-refresh
    }

    function startAutoRefresh() {
        if (state.autoRefreshTimer) clearInterval(state.autoRefreshTimer);
        if (state.autoRefreshCountdown) clearInterval(state.autoRefreshCountdown);
        var countdownEl = document.getElementById('refresh-countdown');
        var total = REFRESH_INTERVALS[state.currentPage] || 30;
        state._refreshTick = total;
        if (countdownEl) { countdownEl.textContent = total + 's'; countdownEl.className = 'refresh-countdown'; }
        function tick() {
            if (document.hidden) return; // Pause silently when browser tab is in background
            state._refreshTick--;
            if (countdownEl) {
                countdownEl.textContent = state._refreshTick + 's';
                countdownEl.className = 'refresh-countdown' + (state._refreshTick <= 3 ? ' urgent' : '');
            }
            if (state._refreshTick <= 0) {
                total = REFRESH_INTERVALS[state.currentPage] || 30;
                state._refreshTick = total;
                refreshCurrentPage();
            }
        }
        state.autoRefreshCountdown = setInterval(tick, 1000);
        state.autoRefreshTimer = state.autoRefreshCountdown;
        // Pause/resume when browser tab visibility changes
        document.removeEventListener('visibilitychange', onPageVisibilityChange);
        document.addEventListener('visibilitychange', onPageVisibilityChange);
    }

    function resetRefreshCountdown() {
        var total = REFRESH_INTERVALS[state.currentPage] || 30;
        state._refreshTick = total;
        var countdownEl = document.getElementById('refresh-countdown');
        if (countdownEl) { countdownEl.textContent = total + 's'; countdownEl.className = 'refresh-countdown'; }
    }

    function onPageVisibilityChange() {
        if (!document.hidden) {
            // Tab just became visible — refresh immediately and reset the countdown
            resetRefreshCountdown();
            refreshCurrentPage();
        }
    }

    function closeApp() {
        if (IS_INGAME) {
            document.getElementById('app').classList.remove('active');
            document.getElementById('app').classList.add('hidden');
            if (state.autoRefreshTimer) { clearInterval(state.autoRefreshTimer); state.autoRefreshTimer = null; }
            document.removeEventListener('visibilitychange', onPageVisibilityChange);
            Utils.nuiCallback('closeDashboard', {});
        } else {
            var sidebar = document.getElementById('sidebar');
            if (sidebar) sidebar.classList.toggle('open');
        }
    }
function bindSearch() {
        // Player search with live autocomplete dropdown
        var playerSearchInp = document.getElementById('player-search');
        if (playerSearchInp) {
            var _psTimer = null;
            playerSearchInp.setAttribute('autocomplete', 'off');
            playerSearchInp.addEventListener('input', function() {
                clearTimeout(_psTimer);
                var q = playerSearchInp.value.trim();
                if (q.length < 1) { closePSDropdown(); return; }
                _psTimer = setTimeout(function() { showPSDropdown(q); }, 150);
            });
            playerSearchInp.addEventListener('keydown', function(e) {
                if (e.key === 'Enter') { closePSDropdown(); doPlayerSearch(); }
                if (e.key === 'Escape') closePSDropdown();
            });
            playerSearchInp.addEventListener('blur', function() {
                setTimeout(closePSDropdown, 200);
            });
        }

        function doPlayerSearch() {
            var q = (document.getElementById('player-search') || {}).value || '';
            q = q.trim();
            if (q) Utils.nuiCallback('getPlayerList', { search: q });
            else { state.playerPage = 1; Utils.nuiCallback('getPlayerList', { page: 1 }); }
        }

        function showPSDropdown(q) {
            var allPlayers = state.cachedPlayerNames || [];
            var ql = q.toLowerCase();
            var matches = allPlayers.filter(function(p) {
                return (p.name || '').toLowerCase().indexOf(ql) !== -1 ||
                       (p.steam || '').toLowerCase().indexOf(ql) !== -1 ||
                       (p.char_name || '').toLowerCase().indexOf(ql) !== -1 ||
                       (p.discord || '').toLowerCase().indexOf(ql) !== -1 ||
                       (p.char_identifier || '').toLowerCase().indexOf(ql) !== -1;
            }).slice(0, 10);

            var dropId = 'ps-dropdown';
            var existing = document.getElementById(dropId);
            if (!existing) {
                existing = document.createElement('div');
                existing.id = dropId;
                existing.style.cssText = 'position:absolute;z-index:9999;background:var(--bg-card);border:1px solid var(--border);border-radius:var(--radius);overflow:hidden;max-height:240px;overflow-y:auto;box-shadow:var(--shadow-md);min-width:220px;top:100%;left:0;right:0';
                var wrap = playerSearchInp.parentNode;
                if (wrap) { wrap.style.position = 'relative'; wrap.appendChild(existing); }
            }
            if (!matches.length) { existing.style.display = 'none'; return; }
            existing.innerHTML = matches.map(function(p) {
                var badge = p.online ? '<span style="display:inline-block;width:6px;height:6px;background:var(--green);border-radius:50%;margin-right:4px"></span>' : '';
                return '<div style="padding:7px 12px;cursor:pointer;display:flex;align-items:center;gap:6px;border-bottom:1px solid var(--border)" ' +
                    'onmousedown="(function(){document.getElementById(\'player-search\').value=' + JSON.stringify(p.name || '') + ';App._psSelect(' + JSON.stringify(p.name || '') + ');})()">' +
                    badge + '<span style="font-size:12.5px;color:var(--text-bright)">' + Utils.escapeHtml(p.name || '') + '</span>' +
                    '<span style="font-size:10px;color:var(--text-muted);margin-left:auto">' + Utils.escapeHtml((p.steam || '').replace('steam:','')) + '</span></div>';
            }).join('');
            existing.style.display = 'block';
        }
        function closePSDropdown() {
            var d = document.getElementById('ps-dropdown');
            if (d) d.style.display = 'none';
        }

        bindBtn('btn-player-search', doPlayerSearch);
        bindEnter('player-search', doPlayerSearch);

        bindBtn('btn-eco-filter', function () {
            Utils.nuiCallback('getEconomyLog', { filters: getEconomyFilters() });
        });

        bindBtn('btn-item-filter', function () {
            Utils.nuiCallback('getItemLog', getItemFilters());
        });
        bindEnter('item-search', function () { document.getElementById('btn-item-filter').click(); });

        bindBtn('btn-ban-search', function () {
            var q = document.getElementById('ban-search').value.trim();
            Utils.nuiCallback('getBanList', { search: q, page: 1 });
        });
        bindEnter('ban-search', function () { document.getElementById('btn-ban-search').click(); });

        bindBtn('btn-chat-search', function () {
            Utils.nuiCallback('getChatLog', getChatFilters());
        });
        bindEnter('chat-search', function () { document.getElementById('btn-chat-search').click(); });

        bindBtn('btn-alert-filter', function () {
            Utils.nuiCallback('getAlerts', getAlertFilters());
        });
        bindEnter('alert-search', function () { document.getElementById('btn-alert-filter').click(); });

        bindBtn('btn-detection-filter', function () {
            Utils.nuiCallback('getDetections', getDetectionFilters());
        });
        bindEnter('detection-search', function () { document.getElementById('btn-detection-filter').click(); });

        bindBtn('btn-log-filter', function () {
            Utils.nuiCallback('getAdminLog', getAdminLogFilters());
        });
        bindEnter('log-search', function () { document.getElementById('btn-log-filter').click(); });

        bindBtn('btn-ack-all', function () {
            confirmAction('Acknowledge All Alerts', 'Mark all visible alerts as acknowledged?', function () {
                Utils.nuiCallback('acknowledgeAllAlerts', {});
                setTimeout(function () {
                    Utils.nuiCallback('getAlerts', {});
                    Utils.nuiCallback('getDashboardData', {});
                }, 600);
            });
        });
        bindBtn('btn-resolve-all', function () {
            confirmAction('Resolve All Detections', 'Mark all visible detections as resolved?', function () {
                Utils.nuiCallback('resolveAllDetections', {});
                setTimeout(function () {
                    Utils.nuiCallback('getDetections', {});
                    Utils.nuiCallback('getDashboardData', {});
                }, 600);
            });
        });

        bindBtn('btn-export-alerts', function () {
            var d = state.alertList;
            var rows = d ? (d.rows || (Array.isArray(d) ? d : [])) : [];
            exportCSV('alerts.csv', ['ID','Severity','Type','Title','Player','Time','Status'], rows.map(function(a) {
                return [a.id, a.severity, a.alert_type, a.title, a.player_name, a.created_at, a.acknowledged ? 'Resolved' : 'Open'];
            }));
        });
        bindBtn('btn-export-detections', function () {
            var d = state.detectionList;
            var rows = d ? (d.rows || (Array.isArray(d) ? d : [])) : [];
            exportCSV('detections.csv', ['ID','Severity','Type','Player','Steam','Details','Action','Time','Status'], rows.map(function(det) {
                return [det.id, det.severity, det.detection_type, det.player_name, det.steam, det.details, det.action_taken, det.created_at, det.resolved ? 'Resolved' : 'Open'];
            }));
        });
        bindBtn('btn-export-bans', function () {
            var d = state.banList;
            var rows = d ? (d.bans || []) : [];
            exportCSV('bans.csv', ['Player','Steam','Reason','Type','Admin','Banned At','Expiry','Active'], rows.map(function(b) {
                return [b.player_name, b.steam, b.reason, b.ban_type, b.banned_by_name, b.created_at, b.expiry_date || 'Never', b.is_active ? 'Yes' : 'No'];
            }));
        });
        bindBtn('btn-export-logs', function () {
            var d = state.adminLog;
            var rows = d ? (d.rows || (Array.isArray(d) ? d : [])) : [];
            exportCSV('admin_log.csv', ['Time','Admin','Action','Target','Details','Severity'], rows.map(function(l) {
                return [l.created_at, l.admin_name, l.action, l.target_name, l.details, l.severity];
            }));
        });
        bindBtn('btn-export-chat', function () {
            var d = state.chatLog;
            var rows = d ? (Array.isArray(d) ? d : (d.messages || [])) : [];
            exportCSV('chat_log.csv', ['Time','Player','Message','Type','Flagged'], rows.map(function(c) {
                return [c.created_at, c.player_name, c.message, c.channel || c.type, c.flagged ? 'Yes' : 'No'];
            }));
        });

        bindBtn('btn-wl-search', function () {
            var q = document.getElementById('wl-search').value.trim();
            Utils.nuiCallback('getWhitelist', { search: q, page: 1 });
        });

        bindBtn('btn-report-filter', function () {
            Utils.nuiCallback('getReports', { filters: getReportFilters() });
        });

        var lbSel = document.getElementById('leaderboard-metric');
        if (lbSel) lbSel.addEventListener('change', function () {
            Utils.nuiCallback('getLeaderboard', { metric: lbSel.value });
        });

        var tpSearch = document.getElementById('teleport-search');
        if (tpSearch) tpSearch.addEventListener('input', Utils.debounce(filterTeleports, 200));
        var tpCat = document.getElementById('teleport-category');
        if (tpCat) tpCat.addEventListener('change', filterTeleports);

        var resSearch = document.getElementById('resource-search');
        if (resSearch) resSearch.addEventListener('input', Utils.debounce(function () {
            if (state.resourceList) renderResources();
        }, 200));
        var resFilter = document.getElementById('resource-filter-status');
        if (resFilter) resFilter.addEventListener('change', function () {
            if (state.resourceList) renderResources();
        });

        // Warning search
        bindBtn('btn-warning-search', function () {
            var q = document.getElementById('warning-search').value.trim();
            Utils.nuiCallback('getWarnings', { search: q, page: 1 });
        });
        bindEnter('warning-search', function () { document.getElementById('btn-warning-search').click(); });

        bindBtn('btn-combat-filter', function() {
            Utils.nuiCallback('getCombatLog', getCombatFilters());
        });
        bindBtn('btn-combat-export', function() {
            if (!state.combatLog || !state.combatLog.rows) return;
            exportCSV('combat_log.csv',
                ['Time', 'Victim', 'Killer', 'Weapon', 'Distance', 'Type'],
                state.combatLog.rows.map(function(r) {
                    return [r.created_at, r.victim_name, r.killer_name || 'NPC', r.weapon_name, r.distance, r.is_pvp ? 'PvP' : 'PvE'];
                }));
        });
        bindBtn('btn-transfer-filter', function() {
            Utils.nuiCallback('getItemTransfers', getTransferFilters());
        });
        bindBtn('btn-transfer-export', function() {
            if (!state.itemTransfers || !state.itemTransfers.rows) return;
            exportCSV('item_transfers.csv',
                ['Time', 'From', 'To', 'Item', 'Qty', 'Source', 'Flagged'],
                state.itemTransfers.rows.map(function(r) {
                    return [r.created_at, r.from_name, r.to_name, r.item_name, r.quantity, r.source_resource, r.flagged ? 'YES' : ''];
                }));
        });
    }

    function getEconomyFilters() {
        return {
            type: val('eco-filter-type'),
            flagged: (document.getElementById('eco-filter-flag') ? document.getElementById('eco-filter-flag').value : '') === '1'
        };
    }
    function getItemFilters() {
        var flaggedEl = document.getElementById('item-filter-flagged');
        var playerInput = document.querySelector('#page-items .log-filter-player-input');
        return {
            search: val('item-search'),
            action: val('item-filter-action'),
            flagged: flaggedEl && flaggedEl.checked ? '1' : '',
            steam: (playerInput && playerInput.dataset.selectedSteam) || ''
        };
    }
    function getReportFilters() {
        return { status: val('report-filter-status'), type: val('report-filter-type') };
    }
    function getAlertFilters() {
        return {
            search: val('alert-search'),
            severity: val('alert-filter-severity'),
            alert_type: val('alert-filter-type'),
            acknowledged: val('alert-filter-ack'),
            limit: 50, offset: 0
        };
    }
    function getDetectionFilters() {
        return {
            search: val('detection-search'),
            detection_type: val('detection-filter-type'),
            severity: val('detection-filter-severity'),
            resolved: val('detection-filter-resolved'),
            limit: 50, offset: 0
        };
    }
    function getAdminLogFilters() {
        return {
            search: val('log-search'),
            action: val('log-filter-action'),
            severity: val('log-filter-severity'),
            limit: 100, offset: 0
        };
    }
    function getChatFilters() {
        var flaggedEl = document.getElementById('chat-filter-flagged');
        return {
            search: val('chat-search'),
            steam: val('chat-player-steam') || '',
            type: val('chat-filter-type'),
            flagged: flaggedEl && flaggedEl.checked ? '1' : '',
            date_from: val('chat-date-from'),
            date_to: val('chat-date-to'),
            limit: 100, offset: 0
        };
    }
    function getLeaderboardMetric() { return val('leaderboard-metric') || 'playtime'; }
function bindActions() {
        bindBtn('btn-view-appeals', function () {
            var sec = document.getElementById('appeals-section');
            sec.classList.toggle('hidden');
            if (!sec.classList.contains('hidden')) Utils.nuiCallback('getAppeals', {});
        });
        bindBtn('btn-view-community-queue', function () {
            var bansTbody = document.getElementById('bans-tbody');
            var bansTable = bansTbody && bansTbody.closest('table');
            var appealsSection = document.getElementById('appeals-section');
            var queueSection = document.getElementById('community-queue-section');
            var queueBtn = document.getElementById('btn-view-community-queue');
            var isHidden = queueSection.classList.contains('hidden');
            if (isHidden) {
                bansTable.classList.add('hidden');
                appealsSection.classList.add('hidden');
                document.getElementById('community-sync-section').classList.add('hidden');
                var syncBtn2 = document.getElementById('btn-view-community-sync');
                if (syncBtn2) syncBtn2.classList.replace('btn-accent', 'btn-muted');
                queueSection.classList.remove('hidden');
                queueBtn.classList.replace('btn-muted', 'btn-accent');
                state.communityQueuePage = 1;
                Utils.nuiCallback('getCommunityQueue', { page: 1, status: 'pending' }).catch(function () {});
            } else {
                queueSection.classList.add('hidden');
                bansTable.classList.remove('hidden');
                queueBtn.classList.replace('btn-accent', 'btn-muted');
            }
        });


        
        bindBtn('btn-view-community-sync', function () {
            var bansTbody2 = document.getElementById('bans-tbody');
            var bansTable = bansTbody2 && bansTbody2.closest('table');
            var appealsSection = document.getElementById('appeals-section');
            var queueSection = document.getElementById('community-queue-section');
            var syncSection = document.getElementById('community-sync-section');
            var syncBtn = document.getElementById('btn-view-community-sync');
            var queueBtn = document.getElementById('btn-view-community-queue');
            var isHidden = syncSection.classList.contains('hidden');
            if (isHidden) {
                bansTable.classList.add('hidden');
                appealsSection.classList.add('hidden');
                queueSection.classList.add('hidden');
                queueBtn.classList.replace('btn-accent', 'btn-muted');
                syncSection.classList.remove('hidden');
                syncBtn.classList.replace('btn-muted', 'btn-accent');
                state.communitySyncPage = 1;
                loadCommunitySync();
            } else {
                syncSection.classList.add('hidden');
                bansTable.classList.remove('hidden');
                syncBtn.classList.replace('btn-accent', 'btn-muted');
            }
        });
        bindBtn('btn-community-sync-refresh', function () { loadCommunitySync(); });
        bindBtn('btn-community-sync-accept-all', function () {
            if (!state.communitySyncList || state.communitySyncList.length === 0) return;
            if (!confirm('Accept all ' + state.communitySyncList.length + ' community bans? This will ban them on your server.')) return;
            Utils.nuiCallback('acceptAllCommunityBans', { bans: state.communitySyncList })
                .then(function (r) {
                    Utils.showToast(r.accepted + ' ban(s) accepted, ' + r.skipped + ' skipped.', 'success');
                    loadCommunitySync();
                }).catch(function () { Utils.showToast('Failed to accept bans', 'error'); });
        });

// Teleport save
        bindBtn('btn-save-tp', function () {
            var name = val('save-tp-name');
            var category = val('save-tp-category');
            if (!name) { Utils.showToast('Name required', 'error'); return; }
            Utils.nuiCallback('saveTeleportLocation', { name: name, category: category || 'Custom' });
        });

        // Server management
        bindBtn('btn-toggle-server', function () {
            var isOpen = state.serverStatus && state.serverStatus.status === 'open';
            confirmAction(isOpen ? 'Close Server' : 'Open Server', 'Are you sure?', function () {
                Utils.nuiCallback('toggleServerClosed', { reason: isOpen ? 'Closed by admin' : '' });
            });
        });
        bindBtn('btn-kick-all', function () {
            confirmAction('Kick All Players', 'This will kick every player from the server.', function () {
                Utils.nuiCallback('kickAll', { reason: 'Admin kicked all' });
            });
        });
        bindBtn('btn-announce', function () {
            var txt = val('announce-text');
            if (!txt) return;
            Utils.nuiCallback('sendAnnouncement', { message: txt });
            var announceEl = document.getElementById('announce-text');
            announceEl.value = '';
            var counterEl = document.getElementById('announce-counter');
            if (counterEl) counterEl.textContent = '0/500';
        });

        // Announce character counter
        (function() {
            var announceEl = document.getElementById('announce-text');
            var counterEl = document.getElementById('announce-counter');
            if (announceEl && counterEl) {
                announceEl.addEventListener('input', function() {
                    counterEl.textContent = this.value.length + '/500';
                });
            }
        })();


        // Live Map refresh
        bindBtn('btn-map-refresh', function () {
            Utils.nuiCallback('getLiveMapData', {});
        });

        // Spawner
        bindBtn('btn-spawn', function () {
            var type = val('spawner-type');
            var model = val('spawner-model');
            var target = val('spawner-target');
            if (!model) { Utils.showToast('Enter a model name or hash', 'error'); return; }
            if (!target) { Utils.showToast('Select a target player', 'error'); return; }
            Utils.nuiCallback('spawnEntity', { entityType: type, modelHash: model, targetId: parseInt(target) });
            Utils.showToast('Spawn requested', 'success');
        });

        // Blips
        bindBtn('btn-blip-add', function () {
            state.editingBlipId = null;
            document.getElementById('blip-modal-title').textContent = 'Create Blip';
            document.getElementById('blip-name').value = '';
            document.getElementById('blip-preset').value = 'blip_code_waypoint';
            document.getElementById('blip-hash').value = 'blip_code_waypoint';
            document.getElementById('blip-x').value = '';
            document.getElementById('blip-y').value = '';
            document.getElementById('blip-z').value = '';
            document.getElementById('blip-scale').value = '0.2';
            document.getElementById('blip-color').value = '0';
            renderBlipColorSwatches();
            selectBlipPreset('blip_code_waypoint');
            document.getElementById('blip-modal').classList.remove('hidden');
        });
        bindBtn('btn-blip-refresh', function () {
            Utils.nuiCallback('getBlips', {});
        });

        // Admin list refresh
        bindBtn('btn-admin-refresh', function () {
            Utils.nuiCallback('getAdminList', {});
        });
    }

    

    function bindModals() {
        bindBtn('close-player-detail', function () { document.getElementById('player-detail-modal').classList.add('hidden'); });
        bindBtn('close-action-modal', function () { document.getElementById('action-modal').classList.add('hidden'); });
        bindBtn('action-modal-cancel', function () { document.getElementById('action-modal').classList.add('hidden'); });
        bindBtn('action-modal-confirm', function () {
            document.getElementById('action-modal').classList.add('hidden');
            if (state.pendingAction) { state.pendingAction(); state.pendingAction = null; }
        });
        bindBtn('close-report-detail', function () { document.getElementById('report-detail-modal').classList.add('hidden'); });
        // Whitelist modal
        bindBtn('btn-wl-add', function () {
            document.getElementById('wl-modal-title').textContent = 'Add to Whitelist';
            document.getElementById('wl-edit-id').value = '';
            document.getElementById('wl-steam').value = '';
            document.getElementById('wl-name').value = '';
            document.getElementById('wl-discord').value = '';
            document.getElementById('wl-reason').value = '';
            document.getElementById('wl-add-modal').classList.remove('hidden');
        });
        bindBtn('close-wl-modal', function () { document.getElementById('wl-add-modal').classList.add('hidden'); });
        bindBtn('btn-wl-cancel', function () { document.getElementById('wl-add-modal').classList.add('hidden'); });
        bindBtn('btn-wl-confirm', function () {
            var steam = val('wl-steam'), name = val('wl-name'), reason = val('wl-reason'), discord = val('wl-discord');
            var editId = val('wl-edit-id');
            if (!steam) { Utils.showToast('Steam ID required', 'error'); return; }
            if (editId) {
                Utils.nuiCallback('whitelistEdit', { id: parseInt(editId), steam: steam, playerName: name, discord: discord, reason: reason });
            } else {
                Utils.nuiCallback('whitelistAdd', { steam: steam, playerName: name, discord: discord, reason: reason });
            }
            document.getElementById('wl-add-modal').classList.add('hidden');
            document.getElementById('wl-steam').value = '';
            document.getElementById('wl-name').value = '';
            document.getElementById('wl-discord').value = '';
            document.getElementById('wl-reason').value = '';
            document.getElementById('wl-edit-id').value = '';
            document.getElementById('wl-modal-title').textContent = 'Add to Whitelist';
            setTimeout(function () { Utils.nuiCallback('getWhitelist', { page: state.whitelistPage }); }, 800);
        });

        // Blip modal
        bindBtn('close-blip-modal', function () { document.getElementById('blip-modal').classList.add('hidden'); });
        bindBtn('btn-blip-cancel', function () { document.getElementById('blip-modal').classList.add('hidden'); });
        bindBtn('btn-blip-save', function () {
            var blipHashRaw = val('blip-hash') || '';
            var blipHash = /^blip_/.test(blipHashRaw) ? blipHashRaw : (parseInt(blipHashRaw, 10) || 'blip_code_waypoint');
            var blipX = parseFloat(val('blip-x'));
            var blipY = parseFloat(val('blip-y'));
            var blipZ = parseFloat(val('blip-z'));
            var blipScale = parseFloat(val('blip-scale'));
            var blipColor = parseInt(val('blip-color'), 10);
            var data = {
                name: val('blip-name'),
                blip_hash: blipHash,
                x: Number.isFinite(blipX) ? blipX : 0,
                y: Number.isFinite(blipY) ? blipY : 0,
                z: Number.isFinite(blipZ) ? blipZ : 0,
                scale: Number.isFinite(blipScale) ? blipScale : 0.2,
                color: Number.isFinite(blipColor) ? blipColor : 0,
                visible_to: val('blip-visible-to') || null
            };
            if (!data.name) { Utils.showToast('Name required', 'error'); return; }
            if (state.editingBlipId) {
                data.id = state.editingBlipId;
                Utils.nuiCallback('updateBlip', data);
            } else {
                Utils.nuiCallback('createBlip', data);
            }
            document.getElementById('blip-modal').classList.add('hidden');
            // Server pushes mguard:ReceiveBlips after create/update — no polling needed
        });

        // Admin role modal
        bindBtn('close-admin-role-modal', function () { document.getElementById('admin-role-modal').classList.add('hidden'); });
        bindBtn('btn-admin-role-cancel', function () { document.getElementById('admin-role-modal').classList.add('hidden'); });
        bindBtn('btn-admin-role-save', function () {
            var steam = val('admin-role-steam');
            var player = val('admin-role-player');
            var role = val('admin-role-select');
            if (!steam || !role) return;
            Utils.nuiCallback('setAdminRole', { steam: steam, playerName: player, role: role });
            document.getElementById('admin-role-modal').classList.add('hidden');
            setTimeout(function () { Utils.nuiCallback('getAdminList', {}); }, 800);
        });
    }

    function confirmAction(title, body, callback) {
        document.getElementById('action-modal-title').textContent = title;
        document.getElementById('action-modal-body').innerHTML = '<p style="font-size:13px;color:var(--text)">' + Utils.escapeHtml(body) + '</p>';
        document.getElementById('action-modal-confirm').classList.remove('hidden');
        state.pendingAction = callback;
        document.getElementById('action-modal').classList.remove('hidden');
    }

    function confirmActionWithInput(title, body, placeholder, callback) {
        document.getElementById('action-modal-title').textContent = title;
        document.getElementById('action-modal-body').innerHTML = '<p style="font-size:13px;color:var(--text);margin-bottom:8px">' + Utils.escapeHtml(body) + '</p><input type="text" id="action-input" class="inp" placeholder="' + Utils.escapeHtml(placeholder) + '">';
        document.getElementById('action-modal-confirm').classList.remove('hidden');
        state.pendingAction = function () {
            var v = val('action-input');
            callback(v);
        };
        document.getElementById('action-modal').classList.remove('hidden');
    }

    function showInfoModal(title, content) {
        document.getElementById('action-modal-title').textContent = title || 'Info';
        document.getElementById('action-modal-body').innerHTML = '<p style="font-size:12px;color:var(--text-main);line-height:1.6;word-break:break-word;white-space:pre-wrap">' + Utils.escapeHtml(content || '') + '</p>';
        document.getElementById('action-modal-confirm').classList.add('hidden');
        state.pendingAction = null;
        document.getElementById('action-modal').classList.remove('hidden');
    }
function renderDashboard() {
        hidePageLoading('dashboard');
        var d = state.dashboardData;
        if (!d) return;

        // KPI Row 1
        setText('stat-players', Utils.formatNumber(d.playerCount || d.onlinePlayers || 0));
        setText('stat-peak', Utils.formatNumber(d.peakPlayers || 0));
        setText('stat-sessions', Utils.formatNumber(d.sessionsToday || 0));
        setText('stat-unique', Utils.formatNumber(d.uniquePlayersToday || d.uniqueToday || 0));
        setText('stat-new-players', Utils.formatNumber(d.newPlayersToday || 0));
        setText('stat-avg-ping', (d.avgPing || 0) + 'ms');
        setText('stat-alerts', Utils.formatNumber(d.unresolvedAlerts || d.activeAlerts || 0));
        setText('stat-detections', Utils.formatNumber(d.detectionsToday || d.recentDetections || 0));

        // KPI Row 2
        setText('stat-bans-today', Utils.formatNumber(d.bansToday || 0));
        setText('stat-reports', Utils.formatNumber(d.pendingReports || 0));
        setText('stat-appeals', Utils.formatNumber(d.pendingAppeals || 0));
        setText('stat-watches-active', Utils.formatNumber(d.watchlistActive || 0));
        setText('stat-watches-triggered', Utils.formatNumber(d.watchlistTriggered24h || 0));
        setText('stat-money', Utils.formatMoney(d.totalMoney || 0));
        setText('stat-gold', Utils.formatNumber(d.totalGold || 0));
        setText('stat-resources', Utils.formatNumber(d.resourceCount || 0));

        // Server info
        setText('info-framework', d.framework || '-');
        setText('info-uptime', Utils.formatDuration(typeof d.uptime === 'number' ? d.uptime : (d.uptimeSeconds || 0)));
        var uptimeInfoEl = document.getElementById('info-uptime'); if (uptimeInfoEl) uptimeInfoEl.className += ' uptime-display';
        setText('info-slots', (d.playerCount || 0) + ' / ' + (d.maxSlots || d.maxPlayers || '?'));
        setText('info-resources', d.resourceCount || '-');
        setText('info-bans', Utils.formatNumber(d.bansToday || 0));
        setText('info-max-ping', (d.maxPing || 0) + 'ms');
        setText('info-alerts-today', Utils.formatNumber(d.alertsToday || 0));
        setText('info-tx-today', Utils.formatNumber(d.txCountToday || 0));
        // Next restart: show countdown if txAdmin provided one
        var restartEl = document.getElementById('info-next-restart');
        if (restartEl) {
            if (d.nextRestartAt) {
                var secsUntil = Math.max(0, d.nextRestartAt - Math.floor(Date.now() / 1000));
                restartEl.textContent = secsUntil > 0 ? Utils.formatDuration(secsUntil) : 'Imminent';
                restartEl.style.color = secsUntil < 300 ? 'var(--red)' : secsUntil < 900 ? 'var(--warn)' : '';
            } else {
                restartEl.textContent = 'Not scheduled';
                restartEl.style.color = '';
            }
        }

        // Security overview
        setText('sec-detections', Utils.formatNumber(d.detectionsToday || 0));
        setText('sec-bans', Utils.formatNumber(d.bansToday || 0));
        setText('sec-alerts', Utils.formatNumber(d.unresolvedAlerts || 0));
        setText('sec-reports', Utils.formatNumber(d.pendingReports || 0));
        setText('sec-appeals', Utils.formatNumber(d.pendingAppeals || 0));
        setText('sec-watches', Utils.formatNumber(d.watchlistActive || 0));
        renderDashDetectionBreakdown(d.detectionBreakdown || []);

        // Economy health
        setText('eco-money-in', Utils.formatMoney(d.moneyIn || 0));
        setText('eco-money-out', Utils.formatMoney(d.moneyOut || 0));
        var netFlow = (d.moneyIn || 0) - (d.moneyOut || 0);
        var netEl = document.getElementById('eco-net-flow');
        if (netEl) {
            netEl.textContent = (netFlow >= 0 ? '+' : '') + Utils.formatMoney(netFlow);
            netEl.style.color = netFlow >= 0 ? 'var(--text-bright)' : 'var(--danger)';
        }
        setText('eco-tx-count', Utils.formatNumber(d.txCountToday || 0));
        setText('eco-gold-in', Utils.formatNumber(d.goldIn || 0));
        setText('eco-gold-out', Utils.formatNumber(d.goldOut || 0));

        // Player count chart
        var history = d.playerHistory || [];
        if (history.length) {
            var labels = history.map(function (h) { return h.time_label || ''; });
            var data = history.map(function (h) { return h.player_count || 0; });
            Utils.drawLineChart('chart-players', labels, [{
                data: data,
                color: '#8c2020',
                fill: 'rgba(140,32,32,.06)'
            }]);
        }

        // Alert badge
        var badge = document.getElementById('alert-badge');
        var alertCount = d.unresolvedAlerts || d.activeAlerts || 0;
        if (alertCount > 0) {
            badge.textContent = alertCount;
            badge.classList.remove('hidden');
        } else {
            badge.classList.add('hidden');
        }

        // Reports badge
        var reportsBadge = document.getElementById('reports-badge');
        if (reportsBadge) {
            var reportCount = d.pendingReports || 0;
            reportsBadge.textContent = reportCount;
            reportsBadge.classList.toggle('hidden', reportCount === 0);
        }

        // Detections badge
        var detBadge = document.getElementById('detections-badge');
        if (detBadge) {
            var detCount = d.detectionsToday || d.recentDetections || 0;
            detBadge.textContent = detCount;
            detBadge.classList.toggle('hidden', detCount === 0);
        }

        // Appeals badge on bans page
        var appealsBadge = document.getElementById('appeals-count-badge');
        if (appealsBadge) {
            var appCount = d.pendingAppeals || 0;
            appealsBadge.textContent = appCount;
            appealsBadge.classList.toggle('hidden', appCount === 0);
        }

        renderDashOnlinePlayers(d.onlinePlayersList || []);
        renderDashActivity(d.recentActivity || []);
        renderDashRecentBans(d.recentBans || []);
        renderDashHighRisk(d.highRiskPlayers || []);
        renderDashStaffOnline(d.staffOnline || []);
        renderDashCombat(d.recentCombat || []);
        renderDashEarners(d.topEarners || []);
    }

    function renderDashDetectionBreakdown(list) {
        var el = document.getElementById('dash-detection-breakdown');
        if (!el) return;
        if (!list || !list.length) {
            el.innerHTML = '<div style="font-size:11px;color:var(--text-dim)">No detections in last 24h</div>';
            return;
        }
        var max = list.reduce(function(m, x) { return Math.max(m, x.cnt || 0); }, 1);
        el.innerHTML = list.map(function(item) {
            var pct = Math.max(4, Math.round(((item.cnt || 0) / max) * 100));
            return '<div style="margin-bottom:5px">' +
                '<div style="display:flex;justify-content:space-between;font-size:10px;color:var(--text-dim);margin-bottom:2px">' +
                '<span>' + Utils.escapeHtml(item.detection_type || '?') + '</span>' +
                '<span style="color:var(--text-bright)">' + (item.cnt || 0) + '</span></div>' +
                '<div style="background:var(--surface-alt);border-radius:2px;height:5px">' +
                '<div style="width:' + pct + '%;height:100%;background:var(--accent);border-radius:2px"></div></div>' +
            '</div>';
        }).join('');
    }

    function renderDashRecentBans(list) {
        var tbody = document.getElementById('dash-bans-tbody');
        if (!tbody) return;
        if (!list || !list.length) {
            tbody.innerHTML = '<tr class="empty-row"><td colspan="4">No recent bans</td></tr>';
            return;
        }
        tbody.innerHTML = list.map(function(b) {
            var typeClass = b.ban_type === 'permanent' ? 'badge-danger' : 'badge-warn';
            return '<tr>' +
                '<td>' + Utils.escapeHtml(b.player_name || '-') + '</td>' +
                '<td><span class="badge ' + typeClass + '">' + Utils.escapeHtml(b.ban_type || 'ban') + '</span></td>' +
                '<td>' + Utils.escapeHtml(b.banned_by_name || '-') + '</td>' +
                '<td style="white-space:nowrap">' + Utils.escapeHtml(Utils.timeAgo(b.created_at)) + '</td>' +
            '</tr>';
        }).join('');
    }

    function renderDashTopSuspicious(list) {
        var tbody = document.getElementById('dash-suspicious-tbody');
        if (!tbody) return;
        if (!list || !list.length) {
            tbody.innerHTML = '<tr class="empty-row"><td colspan="3">No suspicious activity</td></tr>';
            return;
        }
        tbody.innerHTML = list.map(function(p) {
            var steam = p.steam || '';
            var nameLink = steam
                ? '<a href="#" onclick="App.openPlayerDetail(\'' + Utils.escapeHtml(steam) + '\');return false" style="color:var(--accent);text-decoration:none">' + Utils.escapeHtml(p.player_name || '-') + '</a>'
                : Utils.escapeHtml(p.player_name || '-');
            var sevClass = p.det_count >= 10 ? 'badge-danger' : p.det_count >= 5 ? 'badge-warn' : 'badge-muted';
            return '<tr>' +
                '<td>' + nameLink + '</td>' +
                '<td><span class="badge ' + sevClass + '">' + (p.det_count || 0) + '</span></td>' +
                '<td style="white-space:nowrap">' + Utils.escapeHtml(Utils.timeAgo(p.last_detection)) + '</td>' +
            '</tr>';
        }).join('');
    }

    function renderDashHighRisk(list) {
        var tbody = document.getElementById('dash-highrisk-tbody');
        if (!tbody) return;
        tbody.innerHTML = list.length ? list.map(function(p) {
            var scoreClass = p.risk_score >= 50 ? 'badge-danger' : p.risk_score >= 20 ? 'badge-warn' : 'badge-muted';
            return '<tr>' +
                '<td><a href="#" onclick="App.openPlayerDetail(\'' + Utils.escapeHtml(p.steam || '') + '\');return false" style="color:var(--accent)">' + Utils.escapeHtml(p.player_name || '-') + '</a></td>' +
                '<td><span class="badge ' + scoreClass + '">' + p.risk_score + '</span></td>' +
                '<td style="font-size:11px;color:var(--text-dim)">' + Utils.escapeHtml(p.last_detection_type || '-') + '</td>' +
                '</tr>';
        }).join('') : '<tr><td colspan="3" style="color:var(--text-dim);text-align:center">No high-risk players</td></tr>';
    }

    function renderDashCombat(list) {
        var tbody = document.getElementById('dash-combat-tbody');
        if (!tbody) return;
        tbody.innerHTML = list.length ? list.map(function(r) {
            return '<tr>' +
                '<td>' + Utils.escapeHtml(r.victim_name || '-') + '</td>' +
                '<td style="color:var(--accent)">' + Utils.escapeHtml(r.killer_name || '-') + '</td>' +
                '<td style="font-size:11px">' + Utils.escapeHtml(r.weapon_name || '-') + '</td>' +
                '<td>' + (r.distance ? Math.round(r.distance) + 'm' : '-') + '</td>' +
                '<td style="font-size:11px;color:var(--text-dim)">' + Utils.formatTime(r.created_at) + '</td>' +
                '</tr>';
        }).join('') : '<tr><td colspan="5" style="color:var(--text-dim);text-align:center">No PvP deaths recorded</td></tr>';
    }

    function renderDashEarners(list) {
        var tbody = document.getElementById('dash-earners-tbody');
        if (!tbody) return;
        tbody.innerHTML = list.length ? list.map(function(e) {
            return '<tr><td>' + Utils.escapeHtml(e.player_name || '-') + '</td><td style="color:var(--ok)">$' + Math.round(e.total_earned || 0).toLocaleString() + '</td></tr>';
        }).join('') : '<tr><td colspan="2" style="color:var(--text-dim);text-align:center">No transactions this hour</td></tr>';
    }

    function renderDashStaffOnline(list) {
        var tbody = document.getElementById('dash-staff-tbody');
        if (!tbody) return;
        if (!list || !list.length) {
            tbody.innerHTML = '<tr class="empty-row"><td colspan="3">No staff online</td></tr>';
            return;
        }
        tbody.innerHTML = list.map(function(s) {
            var ping = s.ping != null ? s.ping : '-';
            var pingClass = ping > 200 ? 'sev sev-high' : ping > 100 ? 'sev sev-warning' : 'sev sev-ok';
            var pingBadge = ping !== '-' ? '<span class="' + pingClass + '">' + ping + 'ms</span>' : '-';
            return '<tr>' +
                '<td>' + Utils.escapeHtml(s.name || '-') + '</td>' +
                '<td><span class="badge badge-ok">' + Utils.escapeHtml(s.group || '-') + '</span></td>' +
                '<td>' + pingBadge + '</td>' +
            '</tr>';
        }).join('');
    }

    function renderDashOnlinePlayers(list) {
        var tbody = document.getElementById('dash-online-tbody');
        if (!tbody) return;
        if (!list || !list.length) {
            tbody.innerHTML = '<tr class="empty-row"><td colspan="6">No players online</td></tr>';
            return;
        }
        tbody.innerHTML = list.map(function (p) {
            var steam = p.steam || '';
            var nameLink = steam ? '<a href="#" onclick="App.openPlayerDetail(\'' + Utils.escapeHtml(steam) + '\');return false" style="color:var(--text);text-decoration:none">' + Utils.escapeHtml(p.name || p.player_name || '-') + '</a>' : Utils.escapeHtml(p.name || p.player_name || '-');
            var ping = p.ping != null ? p.ping : '-';
            var pingClass = ping > 200 ? 'sev sev-high' : ping > 100 ? 'sev sev-warning' : 'sev sev-ok';
            var pingBadge = ping !== '-' ? '<span class="' + pingClass + '">' + ping + 'ms</span>' : '-';
            return '<tr><td>' + Utils.escapeHtml(String(p.serverId || p.server_id || '-')) + '</td><td>' + nameLink + '</td><td>' + Utils.escapeHtml(p.charName || p.char_name || '-') + '</td><td>' + Utils.escapeHtml(p.job || '-') + '</td><td>' + Utils.escapeHtml(p.group || p.player_group || '-') + '</td><td>' + pingBadge + '</td></tr>';
        }).join('');
    }

    function renderDashActivity(list) {
        var el = document.getElementById('dash-activity');
        if (!el) return;
        if (!list || !list.length) {
            el.innerHTML = '<div style="padding:20px;text-align:center;color:var(--text-dim)">No recent activity</div>';
            return;
        }
        el.innerHTML = list.map(function (a) {
            var typeClass = {
                'join': 'act-join',
                'leave': 'act-leave',
                'connected': 'act-join',
                'disconnected': 'act-leave',
                'ban': 'act-ban',
                'banned': 'act-ban',
                'detection': 'act-detection',
                'economy': 'act-economy',
                'report': 'act-report',
                'kick': 'act-ban'
            }[String(a.type || '').toLowerCase()] || '';
            return '<div class="activity-item ' + typeClass + '"><div class="activity-time">' + Utils.escapeHtml(Utils.timeAgo(a.time || a.created_at)) + '</div><div class="activity-text">' + Utils.escapeHtml(a.message || a.text || '') + '</div></div>';
        }).join('');
    }
function renderPlayerList() {
        hidePageLoading('players');
        var d = state.playerList;
        if (!d) return;
        var list = d.players || d || [];
        var tbody = document.getElementById('player-tbody');
        if (!list.length) {
            tbody.innerHTML = '<tr class="empty-row"><td colspan="8">No players found</td></tr>';
            return;
        }
        tbody.innerHTML = list.map(function (p) {
            var isOnline = p.is_online || p.isOnline || false;
            var ts = p.trust_score != null ? p.trust_score : -1;
            var tsDot = ts < 0 ? 'risk-unknown' : ts >= 70 ? 'risk-clean' : ts >= 40 ? 'risk-moderate' : 'risk-high';
            var steamEsc = Utils.escapeHtml(p.steam || '');
            return '<tr class="clickable-row" onclick="App.openPlayerDetail(\'' + steamEsc + '\')">' +
                '<td>' + Utils.statusDot(isOnline) + '</td>' +
                '<td><span class="risk-dot ' + tsDot + '" title="Trust: ' + (ts >= 0 ? ts : 'N/A') + '"></span>' + Utils.escapeHtml(p.name || p.player_name || '-') + '</td>' +
                '<td>' + Utils.escapeHtml(p.charName || p.char_name || '-') + '</td>' +
                '<td>' + Utils.escapeHtml(p.group || p.player_group || '-') + '</td>' +
                '<td>' + (p.risk_score > 0 ? '<span class="badge ' + (p.risk_score >= 50 ? 'badge-danger' : p.risk_score >= 20 ? 'badge-warn' : 'badge-muted') + '">' + p.risk_score + '</span>' : '<span style="color:var(--text-dim)">\u2014</span>') + '</td>' +
                '<td>' + Utils.formatPlaytime(p.playtime || p.total_playtime || 0) + '</td>' +
                '<td>' + Utils.formatNumber(p.total_sessions || p.sessions || p.session_count || 0) + '</td>' +
                '<td>' + Utils.timeAgo(p.lastSeen || p.last_seen) + '</td>' +
            '</tr>';
        }).join('');

        var totalCount = d.total || 0;
        var perPage = d.perPage || 25;
        var totalPages = Math.ceil(totalCount / perPage);
        if (totalPages > 1) {
            Utils.buildPagination(document.getElementById('player-pagination'), d.page || state.playerPage, totalPages, function (p) {
                state.playerPage = p;
                Utils.nuiCallback('getPlayerList', { page: p });
            });
        } else {
            document.getElementById('player-pagination').innerHTML = '';
        }
    }

    function openPlayerDetail(steamId, serverId, licenseId) {
        if (!steamId && serverId) {
            var found = Utils.findPlayerByServerId(state.playerList, serverId) || Utils.findPlayerByServerId(state.liveMapData, serverId);
            if (found && found.steam) { steamId = found.steam; }
            if (found && found.license) { licenseId = licenseId || found.license; }
        }
        if (!steamId && !serverId && !licenseId) return;
        state.playerDetailTab = 'overview';
        document.getElementById('player-detail-modal').classList.remove('hidden');
        document.getElementById('player-detail-body').innerHTML =
            '<div class="pd-skeleton">' +
            '<div class="pd-skel-row"><div class="skel-block skel-h3"></div><div class="skel-block skel-badge"></div></div>' +
            '<div class="pd-skel-row"><div class="skel-block skel-label"></div><div class="skel-block skel-value"></div></div>' +
            '<div class="pd-skel-row"><div class="skel-block skel-label"></div><div class="skel-block skel-value-long"></div></div>' +
            '<div class="pd-skel-row"><div class="skel-block skel-label"></div><div class="skel-block skel-value-long"></div></div>' +
            '<div class="pd-skel-row"><div class="skel-block skel-label"></div><div class="skel-block skel-value"></div></div>' +
            '</div>';
        Utils.nuiCallback('getPlayerDetail', { steam: steamId || '', serverId: serverId || null, license: licenseId || '' });
    }

    function renderPlayerDetail() {
        var p = state.playerDetail;
        if (!p) return;
        var isOnline = p.is_online || p.isOnline || false;
        var serverId = p.server_id;
        var steamId = p.steam || '';
        var pNameEl = document.getElementById('detail-player-name');
        if (pNameEl) { pNameEl.textContent = p.player_name || p.name || 'Player Detail'; }
        var pOfflineBadge = document.getElementById('detail-offline-badge');
        if (!isOnline) {
            if (!pOfflineBadge) {
                var badge = document.createElement('span');
                badge.id = 'detail-offline-badge';
                badge.style.cssText = 'font-size:10px;padding:2px 6px;border-radius:3px;background:var(--bg-hover);color:var(--text-dim);border:1px solid var(--border);margin-left:8px;vertical-align:middle';
                badge.textContent = 'Offline';
                if (pNameEl) pNameEl.parentNode.insertBefore(badge, pNameEl.nextSibling);
            }
        } else if (pOfflineBadge) {
            pOfflineBadge.remove();
        }
        document.getElementById('player-detail-modal').classList.remove('hidden');

        var tabs = ['overview', 'economy', 'items', 'detections', 'bans', 'warnings', 'deaths', 'chat', 'timeline', 'notes', 'connections', 'actions'];
        var tabsHtml = '<div class="pd-tabs">' + tabs.map(function (t) {
            return '<div class="pd-tab' + (t === state.playerDetailTab ? ' active' : '') + '" data-tab="' + t + '">' + t.charAt(0).toUpperCase() + t.slice(1) + '</div>';
        }).join('') + '</div>';

        var panelsHtml = tabs.map(function (t) {
            return '<div class="pd-panel' + (t === state.playerDetailTab ? ' active' : '') + '" id="pd-' + t + '">' + renderPDTab(t, p) + '</div>';
        }).join('');

        var actionsHtml = '<div class="sec-title" style="margin-top:12px;border-top:1px solid var(--border);padding-top:10px">Quick Actions</div>';
        actionsHtml += '<div style="display:flex;gap:4px;flex-wrap:wrap">';
        var isBrowserEnv = Utils.detectEnvironment() === 'browser';
        if (isOnline && serverId) {
            if (!isBrowserEnv) {
                actionsHtml += '<button class="btn btn-muted btn-sm" onclick="App.adminPlayerAction(\'spectate\',' + serverId + ')">Spectate</button>';
                actionsHtml += '<button class="btn btn-muted btn-sm" onclick="App.adminPlayerAction(\'teleport_to\',' + serverId + ')">Teleport To</button>';
                actionsHtml += '<button class="btn btn-muted btn-sm" onclick="App.adminPlayerAction(\'bring\',' + serverId + ')">Bring</button>';
            }
            actionsHtml += '<button class="btn btn-muted btn-sm" onclick="App.adminPlayerAction(\'revive\',' + serverId + ')">Revive</button>';
            actionsHtml += '<button class="btn btn-muted btn-sm" onclick="App.adminPlayerAction(\'heal\',' + serverId + ')">Heal</button>';
            actionsHtml += '<button class="btn btn-muted btn-sm" onclick="App.adminPlayerAction(\'freeze\',' + serverId + ')">Freeze</button>';
            actionsHtml += '<button class="btn btn-muted btn-sm" onclick="App.adminPlayerAction(\'kill\',' + serverId + ')">Kill</button>';
            actionsHtml += '<button class="btn btn-muted btn-sm" onclick="App.viewInventory(' + serverId + ')">Inventory</button>';
            actionsHtml += '<button class="btn btn-warn btn-sm" onclick="App.warnPlayerPrompt(' + serverId + ')">Warn</button>';
            actionsHtml += '<button class="btn btn-warn btn-sm" onclick="App.kickPlayerPrompt(' + serverId + ')">Kick</button>';
            actionsHtml += '<button class="btn btn-red btn-sm" onclick="App.banOnlinePlayerPrompt(' + serverId + ',\'' + Utils.escapeHtml(steamId) + '\',\'' + Utils.escapeHtml(p.player_name || p.name || '') + '\')">Ban</button>';
        } else {
            actionsHtml += '<button class="btn btn-red btn-sm" onclick="App.banPlayerPrompt(\'' + Utils.escapeHtml(steamId) + '\',\'' + Utils.escapeHtml(p.player_name || p.name || '') + '\')">Ban</button>';
        }
        actionsHtml += '<button class="btn btn-muted btn-sm" onclick="App.screenPlayer(\'' + Utils.escapeHtml(steamId) + '\')">Screen</button>';
        actionsHtml += '</div>';

        // Currency management (online only)
        if (isOnline && serverId) {
            actionsHtml += '<div class="sec-title" style="margin-top:10px">Currency</div>';
            actionsHtml += '<div style="display:flex;gap:6px;flex-wrap:wrap;align-items:flex-end">';
            actionsHtml += '<div class="fg" style="margin:0;flex:0 0 100px"><label>Amount</label><input type="number" id="currency-amount" class="inp" placeholder="100" min="1"></div>';
            actionsHtml += '<div class="fg" style="margin:0;flex:0 0 100px"><label>Currency</label><select id="currency-type" class="sel"><option value="money">Money</option><option value="gold">Gold</option><option value="rol">Rol</option></select></div>';
            actionsHtml += '<button class="btn btn-green btn-sm" onclick="App.manageCurrency(' + serverId + ',\'add\')">Add</button>';
            actionsHtml += '<button class="btn btn-red btn-sm" onclick="App.manageCurrency(' + serverId + ',\'remove\')">Remove</button>';
            actionsHtml += '</div>';

            // Give item
            actionsHtml += '<div class="sec-title" style="margin-top:10px">Items</div>';
            actionsHtml += '<div style="display:flex;gap:6px;flex-wrap:wrap;align-items:flex-end">';
            actionsHtml += '<div class="fg" style="margin:0;flex:1;min-width:120px"><label>Item Name</label><input type="text" id="give-item-name" class="inp" placeholder="e.g. bread"></div>';
            actionsHtml += '<div class="fg" style="margin:0;flex:0 0 70px"><label>Qty</label><input type="number" id="give-item-qty" class="inp" placeholder="1" min="1" value="1"></div>';
            actionsHtml += '<button class="btn btn-green btn-sm" onclick="App.giveItem(' + serverId + ')">Give</button>';
            actionsHtml += '<button class="btn btn-red btn-sm" onclick="App.removeItemPrompt(' + serverId + ')">Remove</button>';
            actionsHtml += '</div>';

            // Set job
            actionsHtml += '<div class="sec-title" style="margin-top:10px">Job</div>';
            actionsHtml += '<div style="display:flex;gap:6px;flex-wrap:wrap;align-items:flex-end">';
            actionsHtml += '<div class="fg" style="margin:0;flex:1;min-width:100px"><label>Job Name</label><input type="text" id="set-job-name" class="inp" placeholder="e.g. lawman"></div>';
            actionsHtml += '<div class="fg" style="margin:0;flex:0 0 70px"><label>Grade</label><input type="number" id="set-job-grade" class="inp" placeholder="0" min="0" value="0"></div>';
            actionsHtml += '<button class="btn btn-accent btn-sm" onclick="App.setPlayerJob(' + serverId + ')">Set Job</button>';
            actionsHtml += '</div>';
        }

        // Offline action queue section (always visible for offline players)
        if (!isOnline) {
            actionsHtml += '<div class="sec-title" style="margin-top:12px;border-top:1px solid var(--border);padding-top:10px"><i class="fa-solid fa-clock-rotate-left" style="color:var(--accent);margin-right:6px"></i>Queue Action (executes when player joins)</div>';
            actionsHtml += '<div style="display:flex;gap:6px;flex-wrap:wrap;align-items:flex-end;margin-bottom:8px">';
            actionsHtml += '<div class="fg" style="margin:0;flex:0 0 130px"><label>Action Type</label><select id="queue-action-type" class="sel" onchange="App.updateQueueActionFields()"><option value="give_item">Give Item</option><option value="remove_item">Remove Item</option><option value="warn">Warning</option><option value="ban">Ban</option><option value="add_note">Add Note</option></select></div>';
            actionsHtml += '<div id="queue-action-fields" style="display:flex;gap:6px;flex-wrap:wrap;align-items:flex-end;flex:1">';
            actionsHtml += '<div class="fg" style="margin:0;flex:1;min-width:110px"><label>Item Name</label><input type="text" id="queue-item-name" class="inp" placeholder="item_name"></div>';
            actionsHtml += '<div class="fg" style="margin:0;flex:0 0 60px"><label>Qty</label><input type="number" id="queue-item-qty" class="inp" placeholder="1" min="1" value="1"></div>';
            actionsHtml += '</div>';
            actionsHtml += '<button class="btn btn-accent btn-sm" onclick="App.submitQueueAction(\'' + Utils.escapeHtml(steamId) + '\',\'' + Utils.escapeHtml(p.player_name || p.name || '') + '\')">Queue</button>';
            actionsHtml += '</div>';
            actionsHtml += '<div id="pending-actions-list" style="margin-top:6px"><div style="color:var(--text-dim);font-size:11px">Loading pending actions...</div></div>';
        }

        document.getElementById('player-detail-body').innerHTML = tabsHtml + panelsHtml + actionsHtml;

        // Wire item search dropdowns to all item name inputs in this modal
        ['give-item-name', 'queue-item-name'].forEach(function(inputId) {
            var inp = document.getElementById(inputId);
            if (!inp) return;
            // Wrap in relative container for dropdown positioning
            inp.setAttribute('autocomplete', 'off');
            inp.addEventListener('input', function() { itemSearchDebounce(inp); });
            inp.addEventListener('focus', function() { if (inp.value.trim().length > 0) itemSearchDebounce(inp); });
            inp.addEventListener('keydown', function(e) {
                if (e.key === 'Escape') { closeItemDropdownFor(inp); }
            });
        });

        // Tab clicks
        document.querySelectorAll('#player-detail-body .pd-tab').forEach(function (tab) {
            tab.addEventListener('click', function () {
                state.playerDetailTab = tab.dataset.tab;
                document.querySelectorAll('#player-detail-body .pd-tab').forEach(function (t) { t.classList.toggle('active', t.dataset.tab === state.playerDetailTab); });
                document.querySelectorAll('#player-detail-body .pd-panel').forEach(function (p) { p.classList.toggle('active', p.id === 'pd-' + state.playerDetailTab); });
                // Load lazy tabs on demand
                var activeTab = state.playerDetailTab;
                if (activeTab === 'timeline') {
                    state.playerTimeline = null;
                    var tPanel = document.getElementById('pd-timeline');
                    if (tPanel) tPanel.innerHTML = '<div style="text-align:center;padding:20px;color:var(--text-dim)">Loading timeline...</div>';
                    Utils.nuiCallback('getPlayerTimeline', { steam: state.playerDetail && state.playerDetail.steam });
                }
                if (activeTab === 'connections') {
                    var cPanel = document.getElementById('pd-connections');
                    if (cPanel) cPanel.innerHTML = '<div style="text-align:center;padding:20px;color:var(--text-dim)">Loading connections...</div>';
                    Utils.nuiCallback('getPlayerConnections', { steam: state.playerDetail && state.playerDetail.steam })
                        .then(function(r) {
                            var conns = (r && r.connections) || [];
                            if (!cPanel) return;
                            if (!conns.length) {
                                cPanel.innerHTML = '<div class="pd-empty">No linked accounts found.</div>';
                                return;
                            }
                            var rows = conns.map(function(c) {
                                var badge = (c.is_banned || c.ban_status === 'banned') ? '<span class="status-badge banned">BANNED</span>' : '';
                                return '<tr><td>' + Utils.escapeHtml(c.player_name) + badge + '</td>' +
                                    '<td class="mono">' + Utils.escapeHtml(c.steam) + '</td>' +
                                    '<td><span class="link-type-' + c.link_type + '">' + c.link_type.toUpperCase() + '</span></td>' +
                                    '<td>' + (c.last_seen ? new Date(c.last_seen).toLocaleDateString() : '\u2014') + '</td>' +
                                    '</tr>';
                            }).join('');
                            cPanel.innerHTML = '<div class="pd-connections"><table class="data-table">' +
                                '<thead><tr><th>Player</th><th>Steam</th><th>Link Type</th><th>Last Seen</th></tr></thead>' +
                                '<tbody>' + rows + '</tbody></table></div>';
                        })
                        .catch(function() {
                            if (cPanel) cPanel.innerHTML = '<div class="pd-empty">Failed to load connections.</div>';
                        });
                }
                if (activeTab === 'actions') {
                    loadPlayerActionsTab(state.playerDetail && state.playerDetail.steam);
                }
                // Reset item filter when switching away from items tab
                if (activeTab !== 'items') {
                    state.pdItemFilter = { search: '', action: 'all' };
                }
            });
        });

        // Item filter event delegation (filter bar lives inside pd-items panel)
        document.getElementById('player-detail-body').addEventListener('click', function(e) {
            var btn = e.target.closest('[data-item-dir]');
            if (!btn) return;
            state.pdItemFilter = state.pdItemFilter || { search: '', action: 'all' };
            state.pdItemFilter.action = btn.dataset.itemDir;
            var searchEl = document.getElementById('pd-item-search');
            if (searchEl) state.pdItemFilter.search = searchEl.value.trim().toLowerCase();
            var panel = document.getElementById('pd-items');
            if (panel && state.playerDetail) panel.innerHTML = renderPDTab('items', state.playerDetail);
        });
        document.getElementById('player-detail-body').addEventListener('input', function(e) {
            if (!e.target || e.target.id !== 'pd-item-search') return;
            var q = e.target.value.trim().toLowerCase();
            state.pdItemFilter = state.pdItemFilter || { search: '', action: 'all' };
            state.pdItemFilter.search = q;
            // Use full item catalog first, fall back to player transaction history
            var catalog = state.allItems || [];
            var histItems = (state.playerDetail && state.playerDetail.items) || [];
            var seen = {}, suggestions = [];
            var searchSrc = catalog.length > 0 ? catalog : histItems;
            for (var i = 0; i < searchSrc.length; i++) {
                var it = searchSrc[i];
                var nm = it.item || it.item_name || '';
                var lbl = it.label || it.item_label || nm;
                if (!seen[nm] && (q.length < 2 || lbl.toLowerCase().includes(q) || nm.toLowerCase().includes(q))) {
                    seen[nm] = true;
                    suggestions.push({ item: nm, label: lbl });
                    if (suggestions.length >= 25) break;
                }
            }
            showItemDropdown(e.target, suggestions, function(selected) {
                state.pdItemFilter.search = selected.item.toLowerCase();
                var el = document.getElementById('pd-item-search');
                if (el) el.value = selected.label;
                var panel = document.getElementById('pd-items');
                if (panel && state.playerDetail) panel.innerHTML = renderPDTab('items', state.playerDetail);
            });
            // Re-render with debounce
            clearTimeout(state._pdItemFilterTimer);
            state._pdItemFilterTimer = setTimeout(function() {
                var panel = document.getElementById('pd-items');
                if (panel && state.playerDetail) panel.innerHTML = renderPDTab('items', state.playerDetail);
            }, 180);
        });
    }

    function getItemActionDir(action) {
        var inActions = ['add','buy','craft','pickup','world_pickup','receive','harvest','catch','loot','bank_withdraw','stable_collect'];
        var outActions = ['remove','sell','craft_consume','drop','give','bank_deposit','stable_store','use'];
        if (inActions.indexOf(action) !== -1) return 'in';
        if (outActions.indexOf(action) !== -1) return 'out';
        if (action === 'give' || action === 'receive') return 'transfer';
        return 'other';
    }

    function itemActionBadge(action) {
        var map = {
            'add':            ['▲', 'IN',          'in'],
            'buy':            ['▲', 'BUY',         'in'],
            'craft':          ['▲', 'CRAFT',        'in'],
            'pickup':         ['▲', 'PICKUP',       'in'],
            'receive':        ['◀', 'RECEIVE',      'transfer'],
            'harvest':        ['▲', 'HARVEST',      'in'],
            'catch':          ['▲', 'CATCH',        'in'],
            'loot':           ['▲', 'LOOT',         'in'],
            'bank_withdraw':  ['▲', 'WITHDRAW',     'in'],
            'stable_collect': ['▲', 'COLLECT',      'in'],
            'remove':         ['▼', 'OUT',          'out'],
            'sell':           ['▼', 'SELL',         'out'],
            'craft_consume':  ['▼', 'CONSUME',      'out'],
            'drop':           ['▼', 'DROP',         'out'],
            'give':           ['▶', 'GIVE',         'transfer'],
            'bank_deposit':   ['▼', 'DEPOSIT',      'out'],
            'stable_store':   ['▼', 'STORE',        'out'],
            'use':            ['▼', 'USE',          'out'],
            'world_pickup':   ['▲', 'W.PICKUP',     'in'],
        };
        var info = map[action] || ['—', (action || '?').toUpperCase().slice(0,8), 'other'];
        return '<span class="il-action-badge il-action-' + info[2] + '">' + info[0] + '\u202F' + info[1] + '</span>';
    }

    function renderPDTab(tab, p) {
        switch (tab) {
            case 'overview': {
                var isOnline = p.is_online || p.isOnline || false;
                var sc = p.screening || {};
                var trustScore = sc.trust_score != null ? sc.trust_score : (p.trust_score != null ? p.trust_score : -1);
                var tsLevel = trustScore < 0 ? 'unknown' : trustScore < 40 ? 'high-risk' : trustScore < 70 ? 'moderate' : 'clean';
                var tsLabel = trustScore < 0 ? 'No Data' : trustScore < 40 ? 'HIGH RISK' : trustScore < 70 ? 'MODERATE' : 'CLEAN';
                var tsDisplayScore = trustScore >= 0 ? trustScore : '—';
                var tsBlock = '<div class="trust-score-block ts-' + tsLevel + '">' +
                    '<span class="ts-number">' + tsDisplayScore + '</span>' +
                    '<div class="ts-info">' +
                        '<div class="ts-label-top">Trust Score</div>' +
                        '<span class="ts-level-chip">' + tsLabel + '</span>' +
                        '<div class="ts-bar-track"><div class="ts-bar-fill" style="width:' + (trustScore >= 0 ? Math.min(trustScore, 100) : 0) + '%"></div></div>' +
                    '</div>' +
                '</div>';
                var sfFlags = Array.isArray(sc.flags) ? sc.flags : [];
                if (!sfFlags.length && p.screening_flags) {
                    try { sfFlags = typeof p.screening_flags === 'string' ? JSON.parse(p.screening_flags) : (p.screening_flags || []); } catch(e) { sfFlags = []; }
                }
                var FLAG_LABELS = {
                    new_account: 'New Account', young_account: 'Young Account',
                    private_profile: 'Private Profile', vac_ban: 'VAC Ban',
                    game_ban: 'Game Ban', community_ban: 'Community Ban',
                    no_discord: 'No Discord', guild_ban: 'Guild Ban',
                    not_in_guild: 'Not In Guild', missing_role: 'Missing Role',
                    external_ban_list: 'External Ban', community_ban_list: 'Community Ban List',
                    cross_server_ban: 'Cross-Server Ban', alt_of_banned: 'Alt of Banned',
                    previous_ban: 'Previous Ban', hwid: 'Hardware ID Match',
                };
                var sfHtml = '<div class="screening-flags"><div class="sf-title">Screening Flags</div>' +
                    (sfFlags.length ? sfFlags.map(function(f) {
                        var label = FLAG_LABELS[f.type] || (f.type || '').replace(/_/g, ' ').replace(/\b\w/g, function(c){ return c.toUpperCase(); });
                        return '<div class="sf-flag-row"><span class="sf-flag-type">' + Utils.escapeHtml(label) + '</span><span class="sf-flag-detail">' + Utils.escapeHtml(f.detail || '') + '</span><span class="sf-flag-penalty">-' + (f.penalty || 0) + '</span></div>';
                    }).join('') : '<div class="sf-empty">No flags detected</div>') +
                    (sc.vac_bans > 0 || sc.game_bans > 0 ?
                        '<div class="sf-steam-section">' +
                            '<div class="sf-steam-item"><span class="sf-steam-label">VAC Bans</span><span class="sf-steam-value' + (sc.vac_bans > 0 ? ' danger' : '') + '">' + (sc.vac_bans || 0) + '</span></div>' +
                            '<div class="sf-steam-item"><span class="sf-steam-label">Game Bans</span><span class="sf-steam-value' + (sc.game_bans > 0 ? ' danger' : '') + '">' + (sc.game_bans || 0) + '</span></div>' +
                            (sc.days_since_last_ban != null ? '<div class="sf-steam-item"><span class="sf-steam-label">Last Ban</span><span class="sf-steam-value">' + sc.days_since_last_ban + 'd ago</span></div>' : '') +
                        '</div>'
                    : '') +
                    '</div>';
                var charsHtml = '';
                if (p.characters && p.characters.length > 0) {
                    charsHtml = '<div class="sec-title" style="margin-top:10px;font-size:11px">Characters (' + p.characters.length + ')</div>';
                    charsHtml += '<table class="tbl tbl-sm" style="margin-top:4px"><thead><tr><th>#</th><th>Name</th><th>Job</th><th>Cash</th><th>Bank</th><th>Gold</th></tr></thead><tbody>';
                    p.characters.forEach(function(ch) {
                        charsHtml += '<tr><td>' + (ch.charidentifier || '-') + '</td><td>' + Utils.escapeHtml((ch.firstname || '') + ' ' + (ch.lastname || '')) + '</td><td>' + Utils.escapeHtml(ch.job || '-') + '</td><td>' + Utils.formatMoney(ch.money || 0) + '</td><td>' + Utils.formatMoney(ch.bank || 0) + '</td><td>' + Utils.formatNumber(ch.gold || 0) + '</td></tr>';
                    });
                    charsHtml += '</tbody></table>';
                }
                return tsBlock + '<div class="kv"><span>Status</span><span>' + Utils.statusDot(isOnline) + ' ' + (isOnline ? 'Online' : 'Offline') + '</span></div>' +
                    '<div class="kv"><span>Steam</span><span class="kv-copyable"><span class="cell-mono">' + Utils.escapeHtml(p.steam || '-') + '</span>' + (p.steam ? '<button class="btn-copy" title="Copy Steam ID" onclick="Utils.copyToClipboard(\'' + Utils.escapeHtml(p.steam) + '\',\'Steam ID\')">⎘</button>' : '') + '</span></div>' +
                    '<div class="kv"><span>License</span><span class="kv-copyable"><span class="cell-mono">' + Utils.escapeHtml(p.license || '-') + '</span>' + (p.license ? '<button class="btn-copy" title="Copy License" onclick="Utils.copyToClipboard(\'' + Utils.escapeHtml(p.license) + '\',\'License\')">⎘</button>' : '') + '</span></div>' +
                    '<div class="kv"><span>Discord</span><span class="kv-copyable"><span class="cell-mono">' + Utils.escapeHtml(p.discord || '-') + '</span>' + (p.discord ? '<button class="btn-copy" title="Copy Discord ID" onclick="Utils.copyToClipboard(\'' + Utils.escapeHtml(p.discord) + '\',\'Discord ID\')">⎘</button>' : '') + '</span></div>' +
                    '<div class="kv"><span>Active Char</span><span>' + Utils.escapeHtml(p.char_name || '-') + '</span></div>' +
                    '<div class="kv"><span>Group</span><span>' + Utils.escapeHtml(p.player_group || p.group || '-') + '</span></div>' +
                    '<div class="kv"><span>Job</span><span>' + Utils.escapeHtml(p.job || (p.characters && p.characters[0] && p.characters[0].job) || '-') + '</span></div>' +
                    '<div class="kv"><span>Money</span><span>' + Utils.formatMoney(p.money || 0) + '</span></div>' +
                    '<div class="kv"><span>Gold</span><span>' + Utils.formatNumber(p.gold || 0) + '</span></div>' +
                    '<div class="kv"><span>Playtime</span><span>' + Utils.formatPlaytime(p.total_playtime || p.playtime || 0) + '</span></div>' +
                    '<div class="kv"><span>Sessions</span><span>' + Utils.formatNumber(p.session_count || (Array.isArray(p.sessions) ? p.sessions.length : (p.sessions || 0))) + '</span></div>' +
                    '<div class="kv"><span>First Seen</span><span>' + Utils.formatDate(p.first_seen || p.firstSeen) + '</span></div>' +
                    '<div class="kv"><span>Last Seen</span><span>' + Utils.formatDate(p.last_seen || p.lastSeen) + '</span></div>' +
                    (p.notes ? '<div class="kv"><span>Notes</span><span>' + Utils.escapeHtml(p.notes) + '</span></div>' : '') +
                    charsHtml + sfHtml;
            }
            case 'economy':
                var eco = p.economy || [];
                var balHtml = '<div style="display:flex;gap:10px;flex-wrap:wrap;margin-bottom:12px;padding:10px;background:var(--bg-elevated);border-radius:6px;border:1px solid var(--border)">' +
                    '<div style="flex:1;min-width:90px;text-align:center"><div style="font-size:11px;color:var(--text-dim);margin-bottom:2px">Cash</div><div style="font-size:15px;font-weight:600;color:var(--text-bright)">' + Utils.formatMoney(p.money || 0) + '</div></div>' +
                    '<div style="flex:1;min-width:90px;text-align:center"><div style="font-size:11px;color:var(--text-dim);margin-bottom:2px">Bank</div><div style="font-size:15px;font-weight:600;color:var(--text-bright)">' + Utils.formatMoney((p.characters && p.characters[0] && p.characters[0].bank) || 0) + '</div></div>' +
                    '<div style="flex:1;min-width:90px;text-align:center"><div style="font-size:11px;color:var(--text-dim);margin-bottom:2px">Gold</div><div style="font-size:15px;font-weight:600;color:var(--warn)">' + Utils.formatNumber(p.gold || 0) + '</div></div>' +
                    (p.rol != null ? '<div style="flex:1;min-width:90px;text-align:center"><div style="font-size:11px;color:var(--text-dim);margin-bottom:2px">Rol</div><div style="font-size:15px;font-weight:600;color:var(--text-bright)">' + Utils.formatNumber(p.rol || 0) + '</div></div>' : '') +
                    '</div>';
                if (!eco.length) return balHtml + emptyState('No transaction history', '💰');
                return balHtml + '<table class="tbl tbl-sm"><thead><tr><th>Time</th><th>Type</th><th>Currency</th><th>Amount</th><th>Before</th><th>After</th><th>Source</th></tr></thead><tbody>' +
                    eco.map(function (e) {
                        return '<tr><td>' + Utils.timeAgo(e.created_at) + '</td><td>' + Utils.escapeHtml(e.transaction_type || e.type) + '</td><td>' + Utils.escapeHtml(e.currency_type || e.currency) + '</td><td>' + Utils.formatNumber(e.amount) + '</td><td>' + Utils.formatNumber(e.balance_before) + '</td><td>' + Utils.formatNumber(e.balance_after) + '</td><td>' + Utils.escapeHtml(e.source_resource || e.source || '-') + '</td></tr>';
                    }).join('') + '</tbody></table>';
            case 'items': {
                var snapshotHtml = '';
                var snap = p.inventory_snapshot || [];
                if (snap.length > 0) {
                    snapshotHtml = '<div class="inv-snapshot-wrap"><div class="inv-snapshot-title">Current Inventory (' + snap.length + ' items)</div>' +
                        '<div class="inv-snapshot-grid">' +
                        snap.map(function(it) {
                            var imgH = itemImageHtml(it.item || it.name, 'inv-snap-img', '24px').replace(/item-dist-img-wrap/g, 'inv-snap-icon');
                            return '<div class="inv-snap-item" title="' + Utils.escapeHtml(it.item || it.name) + '">' +
                                imgH +
                                '<span class="inv-snap-label">' + Utils.escapeHtml(it.label || it.item || it.name) + '</span>' +
                                '<span class="inv-snap-qty">×' + Utils.formatNumber(it.count || it.amount || it.quantity || 0) + '</span>' +
                                '</div>';
                        }).join('') +
                        '</div></div>';
                }
                var allItems = p.items || [];
                var pf = state.pdItemFilter || { search: '', action: 'all' };
                var filtered = allItems.filter(function(it) {
                    if (pf.action !== 'all') {
                        var dir = getItemActionDir(it.action);
                        if (pf.action !== dir) return false;
                    }
                    if (pf.search) {
                        var q = pf.search.toLowerCase();
                        var lbl = (it.item_label || it.item_name || '').toLowerCase();
                        var nm  = (it.item_name || '').toLowerCase();
                        if (!lbl.includes(q) && !nm.includes(q)) return false;
                    }
                    return true;
                });
                var filterBar = '<div class="item-log-filter-bar">' +
                    '<div class="item-search-wrap">' +
                    '<input type="text" id="pd-item-search" class="item-name-search" placeholder="Filter by item…" value="' + Utils.escapeHtml(pf.search || '') + '" autocomplete="off">' +
                    '</div>' +
                    '<div class="item-dir-filters">' +
                    ['all','in','out','transfer'].map(function(d) {
                        return '<button class="idf-btn' + (pf.action === d ? ' active' : '') + '" data-item-dir="' + d + '">' + d.charAt(0).toUpperCase() + d.slice(1) + '</button>';
                    }).join('') +
                    '</div></div>';
                var summary = '<div class="item-log-summary">' +
                    '<span>' + filtered.length + ' of ' + allItems.length + ' entries</span>' +
                    '</div>';
                if (!filtered.length) return snapshotHtml + filterBar + summary + emptyState(pf.search || pf.action !== 'all' ? 'No items match the current filter' : 'No item records', '📦');
                var hasTransfer = filtered.some(function(it) { return it.counterparty_name; });
                var thead = '<tr><th></th><th>Dir</th><th>Time</th><th>Item</th><th>Qty</th>' +
                    (hasTransfer ? '<th>With</th>' : '') + '<th>Source</th></tr>';
                var rows = filtered.map(function(it) {
                    var imgCell = itemImageHtml(it.item_name, 'item-log-img', '20px').replace(/item-dist-img-wrap/g, 'item-log-emoji');
                    var badge = itemActionBadge(it.action);
                    var timeCell = '<td class="il-time">' + Utils.timeAgo(it.created_at) + '</td>';
                    var itemCell = '<td class="il-item">' + Utils.escapeHtml(it.item_label || it.item_name) + '</td>';
                    var qtyCell  = '<td class="il-qty">' + (it.quantity > 0 ? '+' : '') + Utils.formatNumber(it.quantity) + '</td>';
                    var cpCell   = hasTransfer ? '<td class="il-cp">' + (it.counterparty_name ? Utils.escapeHtml(it.counterparty_name) : '<span class="text-dim">—</span>') + '</td>' : '';
                    var srcLabel = (it.source_resource || '').replace(/^vorp_|^rsg-/, '');
                    if (it.source_resource === 'player_transfer') srcLabel = 'p2p';
                    var srcCell  = '<td class="il-src" title="' + Utils.escapeHtml(it.source_resource || '') + '">' + Utils.escapeHtml(srcLabel || '—') + '</td>';
                    return '<tr' + (it.flagged ? ' class="il-row-flagged"' : '') + '><td>' + imgCell + '</td><td>' + badge + '</td>' + timeCell + itemCell + qtyCell + cpCell + srcCell + '</tr>';
                }).join('');
                return snapshotHtml + filterBar + summary + '<div class="item-log-table-wrap"><table class="tbl tbl-sm il-tbl"><thead>' + thead + '</thead><tbody>' + rows + '</tbody></table></div>';
            }
            case 'detections':
                var dets = p.detections || [];
                if (!dets.length) return emptyState('No detections', '🛡');
                return '<table class="tbl tbl-sm"><thead><tr><th>Time</th><th>Type</th><th>Severity</th><th>Details</th><th>Action</th></tr></thead><tbody>' +
                    dets.map(function (d) {
                        return '<tr><td>' + Utils.timeAgo(d.created_at) + '</td><td>' + Utils.escapeHtml(d.detection_type || d.type) + '</td><td>' + Utils.severityBadge(d.severity) + '</td><td title="' + Utils.escapeHtml(resolveAmmoHash(d.details) || '') + '">' + Utils.escapeHtml(Utils.truncate(resolveAmmoHash(d.details) || '', 80)) + '</td><td>' + Utils.escapeHtml(d.action_taken || '-') + '</td></tr>';
                    }).join('') + '</tbody></table>';
            case 'bans':
                var bans = p.bans || [];
                if (!bans.length) return emptyState('No bans', '✅');
                return '<table class="tbl tbl-sm"><thead><tr><th>Date</th><th>Reason</th><th>Banned By</th><th>Type</th><th>Active</th></tr></thead><tbody>' +
                    bans.map(function (b) {
                        return '<tr><td>' + Utils.formatDate(b.created_at) + '</td><td>' + Utils.escapeHtml(b.reason) + '</td><td>' + Utils.escapeHtml(b.banned_by_name || b.banned_by || '-') + '</td><td>' + Utils.escapeHtml(b.ban_type || 'permanent') + '</td><td>' + (b.is_active ? 'Yes' : 'No') + '</td></tr>';
                    }).join('') + '</tbody></table>';
            case 'deaths':
                var deaths = p.deaths || [];
                if (!deaths.length) return emptyState('No death records', '💀');
                return '<table class="tbl tbl-sm"><thead><tr><th>Time</th><th>Cause</th><th>Killer</th><th>Weapon</th><th>Dist</th></tr></thead><tbody>' +
                    deaths.map(function (d) {
                        var weaponRaw = d.weapon_name || d.weapon || '';
                        // Resolve raw hash numbers (positive or negative) to human-readable names
                        if (/^-?\d{6,}$/.test(String(weaponRaw).trim())) {
                            weaponRaw = Utils.resolveWeaponHash(parseInt(weaponRaw)) || ('0x' + (parseInt(weaponRaw) >>> 0).toString(16).toUpperCase());
                        }
                        var weapClean = weaponRaw.replace(/^weapon_/, '').replace(/_/g, ' ').trim() || '-';
                        // Determine cause — use weapon name for environmental deaths
                        var causeMap = { fall: 'Fall Damage', drowning: 'Drowning', drowning_in_vehicle: 'Drowning', fire: 'Fire', explosion: 'Explosion', bleeding: 'Bleeding', horse: 'Horse Fall', animal: 'Animal Attack', alligator: 'Alligator', bear: 'Bear', cougar: 'Cougar' };
                        var weapKey = weaponRaw.replace(/^weapon_/, '').toLowerCase();
                        var cause = d.is_pvp ? 'PvP' : (causeMap[weapKey] || (weapClean !== '-' ? weapClean : 'Unknown'));
                        var killer = d.killer_name || (d.killer_steam ? d.killer_steam.slice(-8) : (d.is_pvp ? 'Unknown Player' : 'NPC / World'));
                        var dist = (d.distance && d.distance > 0) ? Math.round(d.distance) + 'm' : (d.is_pvp ? '< 1m' : '-');
                        return '<tr><td>' + Utils.timeAgo(d.created_at) + '</td><td>' + Utils.escapeHtml(cause) + '</td><td>' + Utils.escapeHtml(killer) + '</td><td>' + Utils.escapeHtml(weapClean) + '</td><td>' + Utils.escapeHtml(dist) + '</td></tr>';
                    }).join('') + '</tbody></table>';
            case 'warnings':
                var warns = p.warnings || [];
                if (!warns.length) return emptyState('No warnings on record', '✅');
                return '<table class="tbl tbl-sm"><thead><tr><th>Date</th><th>Reason</th><th>Severity</th><th>Issued By</th><th>Status</th></tr></thead><tbody>' +
                    warns.map(function (w) {
                        return '<tr><td>' + Utils.timeAgo(w.created_at) + '</td><td>' + Utils.escapeHtml(w.reason || '-') + '</td><td>' + Utils.severityBadge(w.severity || 'low') + '</td><td>' + Utils.escapeHtml(w.warned_by_name || w.warned_by || '-') + '</td><td>' + (w.is_active ? '<span class="sev sev-warning">Active</span>' : '<span class="sev sev-muted">Cleared</span>') + '</td></tr>';
                    }).join('') + '</tbody></table>';
            case 'chat':
                var chats = p.chat || [];
                if (!chats.length) return emptyState('No chat records', '💬');
                return '<table class="tbl tbl-sm"><thead><tr><th>Time</th><th>Message</th><th>Channel</th></tr></thead><tbody>' +
                    chats.map(function (c) {
                        return '<tr><td>' + Utils.timeAgo(c.created_at) + '</td><td>' + Utils.escapeHtml(c.message) + '</td><td>' + Utils.escapeHtml(c.channel || '-') + '</td></tr>';
                    }).join('') + '</tbody></table>';
            case 'timeline': return '<div style="color:var(--text-dim);text-align:center;padding:20px">Loading timeline...</div>';
            case 'notes':
                var notes = p.notes_list || [];
                var notesHtml = '<div class="pd-notes-section">' +
                    '<div class="pd-notes-add">' +
                    '<textarea id="pd-note-input" class="pd-note-textarea" placeholder="Add a note about this player..." rows="3"></textarea>' +
                    '<button class="btn btn-primary btn-sm" onclick="window.App.submitPlayerNote(\'' + Utils.escapeHtml(p.steam || '') + '\', \'' + Utils.escapeHtml(p.char_name || p.name || '') + '\')">Add Note</button>' +
                    '</div>' +
                    (notes.length ? '<div class="pd-notes-list">' + notes.map(function(n) {
                        return '<div class="pd-note-item">' +
                            '<div class="pd-note-header"><span class="pd-note-by">' + Utils.escapeHtml(n.added_by_name || 'Admin') + '</span><span class="pd-note-time">' + Utils.formatDate(n.created_at) + '</span>' +
                            '<button class="pd-note-delete" onclick="window.App.deletePlayerNote(' + n.id + ', \'' + Utils.escapeHtml(p.steam || '') + '\')">&#215;</button></div>' +
                            '<div class="pd-note-text">' + Utils.escapeHtml(n.note_text) + '</div>' +
                            '</div>';
                    }).join('') + '</div>' : '<div class="pd-notes-empty">No notes yet.</div>') +
                    '</div>';
                return notesHtml;
            case 'connections':
                return '<div style="text-align:center;padding:20px;color:var(--text-dim)">Loading connections...</div>';
            case 'actions':
                return '<div style="text-align:center;padding:20px;color:var(--text-dim)">Loading script activity...</div>';
            default: return '';
        }
    }

    function renderScriptActions(container, data) {
        if (!data || !data.resources || data.resources.length === 0) {
            container.innerHTML = '<div class="empty-state" style="padding:24px;text-align:center;color:var(--text-dim)">No scripted events recorded for this player in the past 24h</div>';
            return;
        }
        container.innerHTML = data.resources.map(function(res) {
            var eventsRows = (res.events || []).map(function(ev) {
                return '<tr>' +
                    '<td class="sa-event-name">' + Utils.escapeHtml(ev.event || '') + '</td>' +
                    '<td class="sa-count">' + (ev.count || 0) + '</td>' +
                    '<td class="sa-last">' + (ev.last ? ev.last.split('T')[0] : '\u2014') + '</td>' +
                    '</tr>';
            }).join('');
            return '<div class="sa-resource">' +
                '<div class="sa-resource-name">' + Utils.escapeHtml(res.resource) + '</div>' +
                '<table class="sa-events-table">' +
                '<thead><tr><th>Event</th><th style="text-align:right">Count</th><th>Last Seen</th></tr></thead>' +
                '<tbody>' + eventsRows + '</tbody>' +
                '</table></div>';
        }).join('');
    }

    function loadPlayerActionsTab(steam) {
        var panel = document.getElementById('pd-actions');
        if (!panel || !steam) return;
        panel.innerHTML = '<div style="text-align:center;padding:20px;color:var(--text-dim)">Loading script activity...</div>';
        Utils.nuiCallback('getPlayerActions', { steam: steam, limit: 100 })
            .then(function(r) {
                var rows = r && Array.isArray(r.data) ? r.data : [];
                if (!rows.length) {
                    renderScriptActions(panel, null);
                    return;
                }
                // Group by resource for renderScriptActions format
                var resourceMap = {};
                rows.forEach(function(row) {
                    var res = row.resource_name || 'unknown';
                    if (!resourceMap[res]) resourceMap[res] = {};
                    var evt = row.event_name || '—';
                    if (!resourceMap[res][evt]) resourceMap[res][evt] = { count: 0, last: null };
                    resourceMap[res][evt].count += (row.event_count || row.count || 1);
                    if (!resourceMap[res][evt].last || row.created_at > resourceMap[res][evt].last) {
                        resourceMap[res][evt].last = row.created_at;
                    }
                });
                var sortedResources = Object.keys(resourceMap).sort(function(a, b) {
                    var ca = Object.values(resourceMap[a]).reduce(function(s, e) { return s + e.count; }, 0);
                    var cb = Object.values(resourceMap[b]).reduce(function(s, e) { return s + e.count; }, 0);
                    return cb - ca;
                });
                var grouped = {
                    resources: sortedResources.map(function(res) {
                        var evtMap = resourceMap[res];
                        var events = Object.keys(evtMap).sort(function(a, b) { return evtMap[b].count - evtMap[a].count; }).map(function(evt) {
                            return { event: evt, count: evtMap[evt].count, last: evtMap[evt].last };
                        });
                        return { resource: res, events: events };
                    })
                };
                renderScriptActions(panel, grouped);
            })
            .catch(function() {
                if (panel) panel.innerHTML = '<div class="pd-empty">Failed to load activity.</div>';
            });
    }
    function showItemDropdown(inputEl, items, onSelect) {
        document.querySelectorAll('.item-suggest-list').forEach(function(el) { el.remove(); });
        if (!items || !items.length) return;
        var list = document.createElement('ul');
        list.className = 'item-suggest-list';
        var rect = inputEl.getBoundingClientRect();
        list.style.cssText = 'position:fixed;top:' + (rect.bottom + 2) + 'px;left:' + rect.left + 'px;width:' + Math.max(rect.width, 180) + 'px;z-index:9999;';
        items.slice(0, 25).forEach(function(item) {
            var li = document.createElement('li');
            var name = item.label !== item.item ? item.label + ' (' + item.item + ')' : item.label;
            li.textContent = name;
            li.addEventListener('mousedown', function(e) { e.preventDefault(); onSelect(item); list.remove(); });
            list.appendChild(li);
        });
        document.body.appendChild(list);
        setTimeout(function() {
            document.addEventListener('click', function rm() { list.remove(); document.removeEventListener('click', rm); });
        }, 50);
    }

    function emptyState(msg, icon) {
        icon = icon || '📭';
        return '<div class="empty-state"><span class="empty-state-icon">' + icon + '</span><span class="empty-state-msg">' + Utils.escapeHtml(msg) + '</span></div>';
    }
function renderEconomy() {
        hidePageLoading('economy');
        var d = state.economyLog;
        if (!d) return;
        var list = Array.isArray(d) ? d : (d.entries || []);
        var tbody = document.getElementById('eco-tbody');
        if (!list.length) {
            if (tbody) tbody.innerHTML = '<tr class="empty-row"><td colspan="10">No economy records</td></tr>';
            return;
        }
        if (tbody) tbody.innerHTML = list.map(function (e) {
            var flagCell = e.flagged
                ? '<span class="badge badge-warn" title="' + Utils.escapeHtml(e.flag_reason || '') + '">Flagged</span>'
                : '<span style="color:var(--text-dim)">—</span>';
            var details = e.target_name
                ? (e.transaction_type === 'add' ? 'From: ' : 'To: ') + e.target_name
                : (e.reason || e.source_event || '');
            return '<tr>' +
                '<td>' + Utils.timeAgo(e.created_at) + '</td>' +
                '<td>' + Utils.escapeHtml(e.player_name || '-') + '</td>' +
                '<td>' + Utils.escapeHtml(e.transaction_type || e.type || '-') + '</td>' +
                '<td>' + Utils.escapeHtml(e.currency_type || e.currency || '-') + '</td>' +
                '<td>' + Utils.formatNumber(e.amount) + '</td>' +
                '<td>' + Utils.formatNumber(e.balance_before) + '</td>' +
                '<td>' + Utils.formatNumber(e.balance_after) + '</td>' +
                '<td>' + Utils.escapeHtml(e.source_resource || e.source || '-') + '</td>' +
                '<td style="max-width:200px;overflow:hidden;text-overflow:ellipsis;white-space:nowrap" title="' + Utils.escapeHtml(details) + '">' + Utils.escapeHtml(details || '—') + '</td>' +
                '<td>' + flagCell + '</td>' +
            '</tr>';
        }).join('');
            setupLogFilterBars();
    }

    function renderEconomySummary() {
        hidePageLoading('economy');
        var d = state.economySummary;
        var el = document.getElementById('eco-summary');
        if (!el || !d) return;

        // Support both new nested format (d.flow) and legacy flat format
        var flow = d.flow || d;
        var totals = d.totals || {};
        var richest = d.richest || {};

        // 24h KPI row
        el.innerHTML =
            '<div class="kpi kpi-sm"><span class="kpi-val">' + Utils.formatMoney(flow.totalMoneyAdded || d.totalMoneyAdded || 0) + '</span><span class="kpi-lbl">Money In (24h)</span></div>' +
            '<div class="kpi kpi-sm"><span class="kpi-val">' + Utils.formatMoney(flow.totalMoneyRemoved || d.totalMoneyRemoved || 0) + '</span><span class="kpi-lbl">Money Out (24h)</span></div>' +
            '<div class="kpi kpi-sm"><span class="kpi-val">' + Utils.formatNumber(flow.totalGoldAdded || d.totalGoldAdded || 0) + '</span><span class="kpi-lbl">Gold In (24h)</span></div>' +
            '<div class="kpi kpi-sm"><span class="kpi-val">' + Utils.formatNumber(flow.totalGoldRemoved || d.totalGoldRemoved || 0) + '</span><span class="kpi-lbl">Gold Out (24h)</span></div>' +
            '<div class="kpi kpi-sm"><span class="kpi-val">' + Utils.formatNumber(flow.transactionCount || d.transactionCount || 0) + '</span><span class="kpi-lbl">Transactions</span></div>' +
            '<div class="kpi kpi-sm kpi-warn"><span class="kpi-val">' + Utils.formatNumber(flow.flaggedCount || d.flaggedCount || 0) + '</span><span class="kpi-lbl">Flagged</span></div>';

        // Totals row
        var totalsEl = document.getElementById('eco-totals');
        if (totalsEl) {
            var avgMoney = totals.avgMoney || d.avgMoney || 0;
            var richName = (richest.player_name || richest.char_name)
                ? Utils.escapeHtml((richest.player_name || '') + (richest.char_name ? ' / ' + richest.char_name : ''))
                : '—';
            totalsEl.innerHTML =
                '<div class="kpi kpi-sm"><span class="kpi-val">' + Utils.formatMoney(totals.totalMoney || d.totalMoney || 0) + '</span><span class="kpi-lbl">Total Money</span></div>' +
                '<div class="kpi kpi-sm"><span class="kpi-val">' + Utils.formatNumber(totals.totalGold || d.totalGold || 0) + '</span><span class="kpi-lbl">Total Gold</span></div>' +
                '<div class="kpi kpi-sm"><span class="kpi-val">' + Utils.formatMoney(avgMoney) + '</span><span class="kpi-lbl">Avg Wealth</span></div>' +
                '<div class="kpi kpi-sm" style="flex:2"><span class="kpi-val" style="font-size:12px">' + richName + '</span><span class="kpi-lbl">Richest Player</span></div>';
        }

        // Per-player balances
        state._ecoBalances = Array.isArray(d.balances) ? d.balances : [];
        renderEcoBalances(state._ecoBalances, '');

        // Bind search filter (once)
        var searchEl = document.getElementById('eco-player-search');
        if (searchEl && !searchEl._bound) {
            searchEl._bound = true;
            searchEl.addEventListener('input', Utils.debounce(function () {
                renderEcoBalances(state._ecoBalances || [], this.value);
            }, 200));
        }

        // Render wealth graph if data already available
        if (state.economyHistory) requestAnimationFrame(renderWealthGraph);

        // Wire range buttons (once)
        document.querySelectorAll('.eco-range').forEach(function(btn) {
            if (btn._bound) return;
            btn._bound = true;
            btn.addEventListener('click', function() {
                document.querySelectorAll('.eco-range').forEach(function(b) { b.classList.remove('active'); });
                btn.classList.add('active');
                var range = btn.dataset.range || '24h';
                state.economyHistory = null;
                Utils.nuiCallback('getEconomyHistory', { range: range }).catch(function() {});
            });
        });
    }

    function renderEcoBalances(balances, filter) {
        var tbody = document.getElementById('eco-balances-tbody');
        if (!tbody) return;
        var q = (filter || '').toLowerCase().trim();
        var filtered = balances;
        if (q) {
            filtered = balances.filter(function (b) {
                return (b.player_name || '').toLowerCase().indexOf(q) !== -1 ||
                       (b.char_name || '').toLowerCase().indexOf(q) !== -1;
            });
        }
        if (!filtered.length) {
            tbody.innerHTML = '<tr class="empty-row"><td colspan="7">' + (q ? 'No matching players' : 'No balance data') + '</td></tr>';
            return;
        }
        tbody.innerHTML = filtered.map(function (b, i) {
            var onlineDot = b.is_online
                ? '<span class="eco-online-dot" title="Online"></span>'
                : '<span class="eco-offline-dot" title="Offline"></span>';
            return '<tr>' +
                '<td>' + (i + 1) + '</td>' +
                '<td>' + Utils.escapeHtml(b.player_name || '—') + '</td>' +
                '<td>' + Utils.escapeHtml(b.char_name || '—') + '</td>' +
                '<td>' + Utils.formatMoney(b.money || 0) + '</td>' +
                '<td>' + Utils.formatNumber(b.gold || 0) + '</td>' +
                '<td>' + Utils.formatMoney(b.bank || 0) + '</td>' +
                '<td style="text-align:center">' + onlineDot + '</td>' +
            '</tr>';
        }).join('');
    }
function renderWealthGraph() {
        var history = state.economyHistory;
        var canvas = document.getElementById('chart-wealth');
        if (!canvas) return;
        if (!history || !history.length) {
            var ctx = canvas.getContext('2d');
            ctx.clearRect(0, 0, canvas.width, canvas.height);
            ctx.fillStyle = getComputedStyle(document.documentElement).getPropertyValue('--text-dim') || '#888';
            ctx.font = '13px sans-serif';
            ctx.textAlign = 'center';
            ctx.fillText('No wealth data available', canvas.width / 2, Math.max(canvas.height / 2, 40));
            return;
        }

        var labels = history.map(function(h) { return h.hour_label || ''; });
        var moneyIn  = history.map(function(h) { return Number(h.money_in)  || 0; });
        var moneyOut = history.map(function(h) { return Number(h.money_out) || 0; });
        var activePlayers = history.map(function(h) { return Number(h.active_players) || 0; });

        Utils.drawLineChart('chart-wealth', labels, [
            { data: moneyIn,  color: '#6a9060', fill: 'rgba(106,144,96,.07)', label: 'Money In' },
            { data: moneyOut, color: '#8c3828', fill: 'rgba(140,56,40,.06)',  label: 'Money Out' }
        ], { height: 160, dots: true, onClick: function(pointIdx) {
            var bucket = history[pointIdx];
            if (!bucket) return;
            var leg = document.getElementById('eco-graph-legend');
            if (leg) leg.textContent = bucket.hour_bucket + ' — ' + bucket.tx_count + ' txns, ' + bucket.active_players + ' players';
            Utils.nuiCallback('getEconomyDrilldown', { hour: bucket.hour_bucket }).catch(function() {});
        }});
    }

    function renderWealthDrilldown(d) {
        var panel = document.getElementById('eco-drilldown');
        if (!panel) return;
        var rows = (d && d.rows) || [];
        if (!rows.length) {
            panel.style.display = 'none';
            return;
        }
        panel.style.display = 'block';
        var hour = (d && d.hour) ? d.hour.replace('T', ' ').substring(0, 16) : '';
        var tableRows = rows.map(function(r) {
            var amtColor = r.amount >= 0 ? 'var(--text-bright)' : 'var(--danger)';
            return '<tr>' +
                '<td>' + Utils.escapeHtml(r.player_name || '—') + '</td>' +
                '<td>' + Utils.escapeHtml(r.currency_type || '') + '</td>' +
                '<td>' + Utils.escapeHtml(r.transaction_type || '') + '</td>' +
                '<td style="color:' + amtColor + ';font-family:var(--font-mono)">' + (r.amount >= 0 ? '+' : '') + Utils.formatMoney(r.amount) + '</td>' +
                '<td style="font-family:var(--font-mono)">' + Utils.formatMoney(r.balance_after || 0) + '</td>' +
                '<td style="color:var(--text-dim)">' + Utils.escapeHtml(r.source_resource || '—') + '</td>' +
                '</tr>';
        }).join('');
        panel.innerHTML = '<div style="font-size:11px;color:var(--text-dim);margin-bottom:6px;font-family:var(--font-mono)">Transactions for ' + Utils.escapeHtml(hour) + ' (' + rows.length + ' entries)</div>' +
            '<table class="tbl" style="font-size:12px"><thead><tr><th>Player</th><th>Currency</th><th>Type</th><th>Amount</th><th>Balance After</th><th>Source</th></tr></thead>' +
            '<tbody>' + tableRows + '</tbody></table>';
    }
function getItemImageUrl(itemName) {
        if (!itemName) return '';
        var n = String(itemName).toLowerCase().replace(/\s+/g, '_');
        if (Utils.detectEnvironment() === 'nui') {
            var fw = state.serverFramework || 'VORP';
            if (fw === 'RSG') {
                return 'https://cfx-nui-rsg-inventory/html/images/' + encodeURIComponent(n) + '.png';
            }
            return 'https://cfx-nui-vorp_inventory/html/img/items/' + encodeURIComponent(n) + '.png';
        }
        return Utils.getApiBase() + 'itemimg/' + encodeURIComponent(n) + '.png';
    }

    function itemImageHtml(itemName, cssClass, size) {
        var url = getItemImageUrl(itemName);
        var emoji = getItemIcon(itemName);
        if (!url) return '<div class="' + (cssClass || 'item-dist-img-wrap') + '">' + emoji + '</div>';
        var sz = size || '';
        var sizeStyle = sz ? ' style="width:' + sz + ';height:' + sz + '"' : '';
        return '<img class="' + (cssClass || 'item-dist-img') + '" src="' + url + '"' + sizeStyle + ' onerror="this.style.display=\'none\';this.nextElementSibling.style.display=\'flex\'" loading="lazy">' +
               '<div class="' + (cssClass || 'item-dist-img-wrap') + '" style="display:none"' + sizeStyle + '>' + emoji + '</div>';
    }
function bindItemsSubtabs() {
        var container = document.getElementById('items-subtabs');
        if (!container || container._bound) return;
        container._bound = true;
        container.querySelectorAll('.items-subtab').forEach(function(btn) {
            btn.addEventListener('click', function() {
                var tab = btn.dataset.subtab;
                state.activeItemsSubtab = tab;
                container.querySelectorAll('.items-subtab').forEach(function(b) { b.classList.toggle('active', b.dataset.subtab === tab); });
                document.querySelectorAll('.items-panel').forEach(function(p) {
                    var isActive = p.id === 'items-panel-' + tab;
                    p.classList.toggle('active', isActive);
                    p.style.display = isActive ? 'block' : 'none';
                });
                // Lazy-load data for each tab
                if (tab === 'browser' && !state.allItems) {
                    Utils.nuiCallback('getAllItems', {});
                }
                if (tab === 'watchlist') {
                    if (!state.allItems) {
                        Utils.nuiCallback('getAllItems', {});
                    } else {
                        // Items already loaded — render grid immediately
                        populateWatchTypeFilter();
                        renderWatchItemGrid();
                    }
                    if (!state.itemWatchlist) Utils.nuiCallback('getItemWatchlist', {});
                    if (!state.dashboardData) Utils.nuiCallback('getDashboard', {});
                }
                if (tab === 'anomalies' && !state.itemAnomalies) {
                    Utils.nuiCallback('getItemAnomalies', {});
                }
                if (tab === 'transfers') {
                    if (!state.itemTransfers) {
                        Utils.nuiCallback('getItemTransfers', getTransferFilters());
                    } else {
                        renderItemTransfers();
                    }
                }
            });
        });
        bindWatchItemSearch();
        bindWatchlistBulkActions();
        // Bind anomalies refresh
        var refreshBtn = document.getElementById('btn-refresh-anomalies');
        if (refreshBtn && !refreshBtn._bound) {
            refreshBtn._bound = true;
            refreshBtn.addEventListener('click', function() {
                state.itemAnomalies = null;
                Utils.nuiCallback('getItemAnomalies', {});
            });
        }
        // Bind item log flagged filter
        var flaggedChk = document.getElementById('item-filter-flagged');
        if (flaggedChk && !flaggedChk._bound) {
            flaggedChk._bound = true;
            // Already handled by the filter button
        }
    }
function renderItemLog() {
        var d = state.itemLog;
        if (!d) return;
        var list = Array.isArray(d) ? d : (d.entries || []);
        var tbody = document.getElementById('items-tbody');
        if (!list.length) {
            tbody.innerHTML = '<tr class="empty-row"><td colspan="9">No item records</td></tr>';
            return;
        }
        tbody.innerHTML = list.map(function (it) {
            var imgCell = itemImageHtml(it.item_name, 'item-log-img', '22px').replace(
                'item-dist-img-wrap', 'item-log-emoji'
            );
            return '<tr>' +
                '<td>' + imgCell + '</td>' +
                '<td>' + Utils.timeAgo(it.created_at) + '</td>' +
                '<td>' + Utils.escapeHtml(it.player_name || '-') + '</td>' +
                '<td><span class="sev sev-' + (it.action === 'add' ? 'info' : 'warning') + '">' + Utils.escapeHtml(it.action || '-') + '</span></td>' +
                '<td>' + Utils.escapeHtml(it.item_name || '-') + '</td>' +
                '<td>' + Utils.escapeHtml(it.item_label || '-') + '</td>' +
                '<td>' + Utils.formatNumber(it.quantity) + '</td>' +
                '<td>' + Utils.escapeHtml(it.source_resource || '-') + '</td>' +
                '<td>' + Utils.flagIndicator(it.flagged) + '</td>' +
            '</tr>';
        }).join('');
            setupLogFilterBars();
    }

    function renderItemDistribution() {
        var d = state.itemDistribution;
        var el = document.getElementById('items-overview');
        if (!el) return;
        if (!d || !d.length) {
            el.innerHTML = '<div style="text-align:center;color:var(--text-dim);padding:40px 0">No item distribution data</div>';
            return;
        }
        var top = d.slice(0, 24);
        el.innerHTML = '<div class="items-overview-grid">' + top.map(function (it) {
            var net = (it.added || 0) - (it.removed || 0);
            var itemId = it.item_name || '';
            return '<div class="item-dist-card">' +
                itemImageHtml(itemId, 'item-dist-img', '40px') +
                '<div class="item-dist-info">' +
                    '<div class="item-name" title="' + Utils.escapeHtml(itemId) + '">' + Utils.escapeHtml(it.item_label || it.item_name) + '</div>' +
                    '<div class="item-count">' + Utils.formatNumber(net) + '</div>' +
                    '<div class="item-detail">+' + Utils.formatNumber(it.added || 0) + ' / -' + Utils.formatNumber(it.removed || 0) + '</div>' +
                '</div>' +
            '</div>';
        }).join('') + '</div>';
    }
function renderItemIntelKpis() {
        hidePageLoading('items');
        var d = state.itemIntelligence;
        var el = document.getElementById('item-intel-kpis');
        if (!el || !d) return;
        el.innerHTML =
            '<div class="kpi"><div class="kpi-val">' + Utils.formatNumber(d.uniqueItems || 0) + '</div><div class="kpi-lbl">Unique Items</div></div>' +
            '<div class="kpi"><div class="kpi-val">' + Utils.formatNumber(d.estimatedCirculation || 0) + '</div><div class="kpi-lbl">In Circulation</div></div>' +
            '<div class="kpi"><div class="kpi-val">' + Utils.formatNumber(d.events24h || 0) + '</div><div class="kpi-lbl">Events (24h)</div></div>' +
            '<div class="kpi"><div class="kpi-val' + (d.flagged24h > 0 ? ' kpi-warn' : '') + '">' + Utils.formatNumber(d.flagged24h || 0) + '</div><div class="kpi-lbl">Flagged (24h)</div></div>' +
            '<div class="kpi"><div class="kpi-val">' + Utils.formatNumber(d.activeWatches || 0) + '</div><div class="kpi-lbl">Active Watches</div></div>' +
            (d.topItem ? '<div class="kpi"><div class="kpi-val kpi-accent">' + Utils.escapeHtml(d.topItem.item_label || d.topItem.item_name || '-') + '</div><div class="kpi-lbl">Hottest Item</div></div>' : '');
    }
function renderServerItemTotals() {
        var d = state.serverItemTotals;
        var el = document.getElementById('item-totals-panel');
        if (!el) return;
        if (!d || !d.length) {
            el.innerHTML = '<div class="loading-placeholder">No item data available</div>';
            return;
        }
        el.innerHTML = '<table class="tbl tbl-sm tbl-hover"><thead><tr><th></th><th>Item</th><th>Total Qty</th><th>Players</th><th></th></tr></thead><tbody>' +
            d.slice(0, 30).map(function(it) {
                var imgCell = itemImageHtml(it.item_name, 'item-log-img', '22px').replace(/item-dist-img-wrap/g, 'item-log-emoji');
                return '<tr class="item-row-clickable" data-item="' + Utils.escapeHtml(it.item_name) + '">' +
                    '<td>' + imgCell + '</td>' +
                    '<td>' + Utils.escapeHtml(it.item_label || it.item_name) + '</td>' +
                    '<td class="cell-mono">' + Utils.formatNumber(it.total_quantity || 0) + '</td>' +
                    '<td>' + Utils.formatNumber(it.player_count || 0) + '</td>' +
                    '<td><button class="btn btn-muted btn-xs" onclick="App.openItemDetail(\'' + Utils.escapeHtml(it.item_name) + '\', \'' + Utils.escapeHtml(it.item_label || it.item_name) + '\')">Detail</button></td>' +
                '</tr>';
            }).join('') + '</tbody></table>';
    }
function renderItemAnomalies() {
        var d = state.itemAnomalies;
        var tbody = document.getElementById('anomalies-tbody');
        if (!tbody) return;
        if (!d || !d.length) {
            tbody.innerHTML = '<tr class="empty-row"><td colspan="5">No anomalies detected</td></tr>';
            return;
        }
        tbody.innerHTML = d.map(function(a) {
            var typeLabel = { rapid_accumulation: 'Rapid Gain', flagged_event: 'Flagged', unusual_source: 'Unusual Source', high_frequency: 'High Freq' };
            return '<tr>' +
                '<td>' + Utils.severityBadge(a.severity) + '</td>' +
                '<td><span class="sev sev-' + (a.severity === 'high' ? 'danger' : 'warning') + '">' + Utils.escapeHtml(typeLabel[a.type] || a.type) + '</span></td>' +
                '<td>' + Utils.escapeHtml(a.player_name || '-') + '</td>' +
                '<td>' + (a.item_name ? itemImageHtml(a.item_name, 'item-log-img', '18px').replace(/item-dist-img-wrap/g, 'item-log-emoji') + ' ' + Utils.escapeHtml(a.item_label || a.item_name) : '-') + '</td>' +
                '<td>' + Utils.escapeHtml(a.details || '-') + '</td>' +
            '</tr>';
        }).join('');
    }
function renderItemWatchlist() {
        var d = state.itemWatchlist;
        var tbody = document.getElementById('watchlist-tbody');
        if (!tbody) return;
        if (!d || !d.length) {
            tbody.innerHTML = '<tr class="empty-row"><td colspan="7">No watched items — add one above</td></tr>';
            return;
        }

        var filterQ = (document.getElementById('watchlist-filter') && document.getElementById('watchlist-filter').value || '').toLowerCase();
        var statusFilter = document.getElementById('watchlist-status-filter') && document.getElementById('watchlist-status-filter').value || '';
        var visible = d.filter(function (w) {
            if (statusFilter === 'enabled' && !w.enabled) return false;
            if (statusFilter === 'disabled' && w.enabled) return false;
            if (filterQ) {
                var s = ((w.item_name || '') + ' ' + (w.item_label || '') + ' ' + (w.notes || '')).toLowerCase();
                return s.indexOf(filterQ) !== -1;
            }
            return true;
        });

        if (!visible.length) {
            tbody.innerHTML = '<tr class="empty-row"><td colspan="7">No items match filter</td></tr>';
            return;
        }

        var typeLabels = { server_total: 'Server Total', player_amount: 'Per-Player', rate_spike: 'Rate Spike' };
        tbody.innerHTML = visible.map(function (w) {
            var targets = [];
            try { if (w.target_players) targets = JSON.parse(w.target_players); } catch (e) {}
            var targetsHtml = (!targets || !targets.length)
                ? '<span style="color:var(--text-dim)">All players</span>'
                : targets.slice(0, 3).map(function (t) {
                    return '<span class="watch-chip watch-chip-xs">' + Utils.escapeHtml(t.name || t.steam || '?') + '</span>';
                }).join(' ') + (targets.length > 3 ? ' <span style="color:var(--text-dim);font-size:11px">+' + (targets.length - 3) + '</span>' : '');

            var lastHit = w.last_triggered ? Utils.timeAgo(w.last_triggered) : 'Never';
            var triggerBadge = w.trigger_count > 0
                ? '<span class="badge badge-warn" style="margin-right:4px">' + Utils.formatNumber(w.trigger_count || 0) + '</span>'
                : '<span style="color:var(--text-dim)">' + Utils.formatNumber(w.trigger_count || 0) + '</span>';

            return '<tr data-watch-id="' + w.id + '">' +
                '<td><input type="checkbox" class="watchlist-row-check" data-id="' + w.id + '"></td>' +
                '<td style="cursor:pointer" onclick="App.openItemDetail(\'' + Utils.escapeHtml(w.item_name) + '\', \'' + Utils.escapeHtml(w.item_label || w.item_name) + '\')">' +
                    itemImageHtml(w.item_name, 'item-log-img', '18px').replace(/item-dist-img-wrap/g, 'item-log-emoji') +
                    ' <span style="color:var(--accent);text-decoration:underline dotted">' + Utils.escapeHtml(w.item_label || w.item_name) + '</span>' +
                '</td>' +
                '<td><span style="font-size:11px;color:var(--text-dim)">' + Utils.escapeHtml(typeLabels[w.alert_type] || w.alert_type) + '</span><br>' +
                    '<span class="cell-mono" style="font-size:12px">' + Utils.formatNumber(w.threshold) + '</span>' +
                    (w.time_window_hours ? '<span style="font-size:10px;color:var(--text-dim)"> / ' + w.time_window_hours + 'h</span>' : '') +
                '</td>' +
                '<td style="max-width:160px">' + targetsHtml + '</td>' +
                '<td>' + triggerBadge + '<span style="font-size:11px;color:var(--text-dim)">' + lastHit + '</span></td>' +
                '<td><span class="badge ' + (w.enabled ? 'badge-green' : 'badge-muted') + '">' + (w.enabled ? 'Active' : 'Paused') + '</span></td>' +
                '<td style="white-space:nowrap">' +
                    '<button class="btn btn-muted btn-xs" onclick="App.openWatchPlayersModal(' + w.id + ')" title="Edit target players"><i class="fa-solid fa-users" style="font-size:10px"></i></button> ' +
                    '<button class="btn btn-muted btn-xs" onclick="App.openWatchNotesModal(' + w.id + ')" title="' + (w.notes ? Utils.escapeHtml(w.notes.slice(0, 60)) : 'Add notes') + '"><i class="fa-solid fa-note-sticky" style="font-size:10px"></i></button> ' +
                    '<button class="btn btn-muted btn-xs" onclick="App.toggleItemWatch(' + w.id + ')">' + (w.enabled ? 'Pause' : 'Enable') + '</button> ' +
                    '<button class="btn btn-danger btn-xs" onclick="App.removeItemWatch(' + w.id + ')">Remove</button>' +
                '</td>' +
            '</tr>';
        }).join('');
    }
function bindWatchItemSearch() {
        var searchEl = document.getElementById('watch-item-search');
        if (!searchEl || searchEl._bound) return;
        searchEl._bound = true;

        var debounce = null;
        searchEl.addEventListener('input', function() {
            clearTimeout(debounce);
            debounce = setTimeout(renderWatchItemGrid, 150);
        });

        var typeFilter = document.getElementById('watch-item-type-filter');
        if (typeFilter) typeFilter.addEventListener('change', renderWatchItemGrid);

        var backBtn = document.getElementById('btn-watch-back');
        if (backBtn) backBtn.addEventListener('click', function() { showWatchStep(1); });

        var addBtn = document.getElementById('btn-add-watch');
        if (addBtn) addBtn.addEventListener('click', function() {
            var itemName = val('watch-item-name');
            var itemLabel = val('watch-item-label');
            if (!itemName) { Utils.showToast('No item selected', 'error'); return; }

            // Duplicate check
            var existing = (state.itemWatchlist || []).find(function(w) { return w.item_name === itemName; });
            var dupeWarn = document.getElementById('watch-dupe-warn');
            if (dupeWarn) dupeWarn.classList.toggle('hidden', !existing);

            Utils.nuiCallback('addItemWatch', {
                item_name: itemName,
                item_label: itemLabel || itemName,
                alert_type: val('watch-alert-type') || 'server_total',
                threshold: parseInt(val('watch-threshold')) || 100,
                time_window_hours: parseInt(val('watch-hours')) || 24,
                per_player: (document.getElementById('watch-per-player') || {}).checked ? 1 : 0,
                notes: val('watch-notes') || '',
                target_players: state.watchTargetPlayers
            });

            // Optimistic UI — show loading row immediately
            state.itemWatchlist = null;
            var tbody = document.getElementById('watchlist-tbody');
            if (tbody) tbody.innerHTML = '<tr class="empty-row"><td colspan="11">Saving watch...</td></tr>';

            showWatchStep(1);
            // Ensure fresh data after save, even if optimistic UI stalls
            setTimeout(function() {
                Utils.nuiCallback('getItemWatchlist', {});
            }, 300);
            // Backup poll if server doesn't respond
            setTimeout(function() {
                if (!state.itemWatchlist) Utils.nuiCallback('getItemWatchlist', {});
            }, 800);
        });

        // Bind new-watch player search
        bindWatchNewPlayerSearch();
    }

    function populateWatchTypeFilter() {
        var sel = document.getElementById('watch-item-type-filter');
        if (!sel || sel.options.length > 1) return;
        var items = state.allItems || [];
        var cats = {};
        items.forEach(function(it) { var c = it.type || ''; if (c && !cats[c]) cats[c] = true; });
        Object.keys(cats).sort().forEach(function(c) {
            var opt = document.createElement('option');
            opt.value = c; opt.textContent = c;
            sel.appendChild(opt);
        });
    }

    function renderWatchItemGrid() {
        var grid = document.getElementById('watch-item-grid');
        if (!grid) return;
        var items = state.allItems || [];
        if (!items.length) {
            grid.innerHTML = '<div class="loading-placeholder">Loading items...</div>';
            return;
        }
        var q = (val('watch-item-search') || '').toLowerCase();
        var qNorm = q.replace(/[\s_-]+/g, '');
        var typeVal = val('watch-item-type-filter') || '';
        var filtered = items.filter(function(it) {
            if (typeVal && (it.type || '') !== typeVal) return false;
            if (q) {
                var s = ((it.item || '') + ' ' + (it.label || '')).toLowerCase();
                if (s.indexOf(q) !== -1) return true;
                if (qNorm) {
                    var sNorm = s.replace(/[\s_-]+/g, '');
                    return sNorm.indexOf(qNorm) !== -1;
                }
                return false;
            }
            return true;
        });
        if (!filtered.length) {
            grid.innerHTML = '<div class="loading-placeholder">No items match your search</div>';
            return;
        }
        var watchPage = state._watchItemPage || 0;
        var pageSize = 80;
        var paginated = filtered.slice(watchPage * pageSize, (watchPage + 1) * pageSize);
        // Count badge
        var countEl = document.getElementById('watch-item-count');
        if (countEl) countEl.textContent = filtered.length + ' item' + (filtered.length !== 1 ? 's' : '');
        grid.innerHTML = paginated.map(function(it) {
            var id = it.item || it.name || '';
            var label = it.label || id;
            var totals = state.serverItemTotals || [];
            var tot = totals.find ? totals.find(function(t) { return t.item_name === id; }) : null;
            var holderBadge = tot ? '<div class="watch-item-holders">' + (tot.holder_count || tot.total_holders || 0) + '</div>' : '';
            return '<div class="watch-item-card" title="' + Utils.escapeHtml(id) + '" onclick="App.selectWatchItem(\'' + Utils.escapeHtml(id) + '\', \'' + Utils.escapeHtml(label) + '\')">' +
                holderBadge +
                itemImageHtml(id, 'watch-item-card-img', '34px').replace(/item-dist-img-wrap/g, 'watch-item-card-emoji') +
                '<div class="watch-item-card-name">' + Utils.escapeHtml(label) + '</div>' +
                '<div class="watch-item-card-id">' + Utils.escapeHtml(id) + '</div>' +
            '</div>';
        }).join('');
    }

    function showWatchStep(step) {
        var s1 = document.getElementById('watch-step-1');
        var s2 = document.getElementById('watch-step-2');
        var ind1 = document.getElementById('watch-step-ind-1');
        var ind2 = document.getElementById('watch-step-ind-2');
        if (!s1 || !s2) return;
        if (step === 1) {
            s1.style.display = ''; s2.style.display = 'none';
            if (ind1) ind1.classList.add('active');
            if (ind2) ind2.classList.remove('active');
            state.watchTargetPlayers = [];
        } else {
            s1.style.display = 'none'; s2.style.display = '';
            if (ind1) ind1.classList.remove('active');
            if (ind2) ind2.classList.add('active');
            if (!state.allItems) {
                Utils.nuiCallback('getAllItems', {}).catch(function() {});
            } else {
                renderWatchItemGrid();
            }
        }
    }
function selectWatchItem(itemId, itemLabel) {
        var nameEl = document.getElementById('watch-item-name');
        var labelEl = document.getElementById('watch-item-label');
        if (nameEl) nameEl.value = itemId;
        if (labelEl) labelEl.value = itemLabel || itemId;
        state.watchTargetPlayers = [];
        renderNewWatchChips();
        var preview = document.getElementById('watch-selected-preview');
        if (preview) {
            var detailBtnHtml = '<button class="btn btn-muted btn-xs" style="margin-top:8px" onclick=\'App.openItemDetail(' + JSON.stringify(itemId) + ', ' + JSON.stringify(itemLabel || itemId) + ')\'>View Details</button>';
            // Item context stats from serverItemTotals
            var totals = state.serverItemTotals || [];
            var tot = totals.find ? totals.find(function(t) { return t.item_name === itemId; }) : null;
            var contextHtml = '';
            if (tot) {
                var holders = tot.holder_count || tot.total_holders || 0;
                var added = tot.total_added || 0;
                var removed = tot.total_removed || 0;
                var netQty = added - removed;
                contextHtml = '<div class="watch-item-context">' +
                    itemImageHtml(itemId, 'watch-preview-img', '36px').replace(/item-dist-img-wrap/g, 'watch-preview-emoji') +
                    '<div class="watch-context-stats">' +
                        '<div class="watch-context-stat"><div class="watch-context-stat-val">' + Utils.formatNumber(holders) + '</div><div class="watch-context-stat-lbl">Holders</div></div>' +
                        '<div class="watch-context-stat"><div class="watch-context-stat-val">' + Utils.formatNumber(netQty > 0 ? netQty : 0) + '</div><div class="watch-context-stat-lbl">In Circulation</div></div>' +
                        '<div class="watch-context-stat"><div class="watch-context-stat-val">' + Utils.formatNumber(added) + '</div><div class="watch-context-stat-lbl">Total Added</div></div>' +
                        '<div class="watch-context-stat"><div class="watch-context-stat-val">' + Utils.formatNumber(removed) + '</div><div class="watch-context-stat-lbl">Total Removed</div></div>' +
                    '</div>' +
                    '<div><div class="watch-preview-name">' + Utils.escapeHtml(itemLabel || itemId) + '</div><div class="watch-preview-id" style="color:var(--text-dim);font-size:10px">' + Utils.escapeHtml(itemId) + '</div>' + detailBtnHtml + '</div>' +
                '</div>';
            } else {
                contextHtml = '<div class="watch-item-context">' +
                    itemImageHtml(itemId, 'watch-preview-img', '36px').replace(/item-dist-img-wrap/g, 'watch-preview-emoji') +
                    '<div><div class="watch-preview-name">' + Utils.escapeHtml(itemLabel || itemId) + '</div><div class="watch-preview-id" style="color:var(--text-dim);font-size:10px">' + Utils.escapeHtml(itemId) + '</div>' + detailBtnHtml + '</div>' +
                '</div>';
            }
            preview.innerHTML = contextHtml;
        }
        showWatchStep(2);
    }
function buildPlayerDropdownItem(p, addFn) {
        var onlineBadge = p.is_online ? ' <span class="st st-online" style="font-size:10px">online</span>' : ' <span class="st st-offline" style="font-size:10px">offline</span>';
        var detail = '';
        if (p.discord) detail += ' <span style="color:var(--text-dim);font-size:10px">' + Utils.escapeHtml(p.discord) + '</span>';
        return '<div class="dropdown-item" onclick="' + addFn + '(\'' + Utils.escapeHtml(p.steam || '') + '\', \'' + Utils.escapeHtml(p.player_name || p.name || '') + '\')">' +
            '<strong>' + Utils.escapeHtml(p.player_name || p.name || '?') + '</strong>' + onlineBadge + detail +
            '<div style="font-size:10px;color:var(--text-dim)">' + Utils.escapeHtml(p.steam || '') + '</div>' +
        '</div>';
    }

    function bindWatchNewPlayerSearch() {
        var inp = document.getElementById('watch-player-search');
        if (!inp || inp._bound) return;
        inp._bound = true;
        var dd = document.getElementById('watch-player-dropdown');
        var debounce = null;
        inp.addEventListener('input', function() {
            var q = this.value.trim();
            clearTimeout(debounce);
            if (!q) { if (dd) { dd.innerHTML = ''; dd.style.display = 'none'; } return; }
            // Show online matches immediately from local state
            var players = (state.dashboardData && state.dashboardData.onlinePlayersList) || [];
            var ql = q.toLowerCase();
            var quick = players.filter(function(p) {
                return ((p.name || '') + ' ' + (p.steam || '') + ' ' + p.server_id).toLowerCase().indexOf(ql) !== -1;
            }).slice(0, 5).map(function(p) {
                return buildPlayerDropdownItem({ steam: p.steam, player_name: p.name, is_online: true, discord: null }, 'App.addWatchTargetNew');
            });
            if (quick.length && dd) { dd.innerHTML = quick.join(''); dd.style.display = 'block'; }
            // Then query server for full results (online+offline)
            debounce = setTimeout(function() {
                Utils.nuiCallback('searchWatchPlayers', { query: q });
            }, 350);
        });
        // Cache which context is "new" or "edit" so server response goes to right dropdown
        state._watchPlayerSearchContext = 'new';
        inp.addEventListener('focus', function() { state._watchPlayerSearchContext = 'new'; });
        document.addEventListener('click', function(e) {
            if (dd && !inp.contains(e.target) && !dd.contains(e.target)) { dd.innerHTML = ''; dd.style.display = 'none'; }
        });
    }

    function addWatchTargetNew(steam, name) {
        if (!steam) return;
        if (state.watchTargetPlayers.some(function(p) { return p.steam === steam; })) {
            var inp = document.getElementById('watch-player-search');
            if (inp) inp.value = '';
            var dd = document.getElementById('watch-player-dropdown');
            if (dd) { dd.innerHTML = ''; dd.style.display = 'none'; }
            return;
        }
        state.watchTargetPlayers.push({ steam: steam, name: name });
        renderNewWatchChips();
        var inp = document.getElementById('watch-player-search');
        if (inp) inp.value = '';
        var dd = document.getElementById('watch-player-dropdown');
        if (dd) { dd.innerHTML = ''; dd.style.display = 'none'; }
    }

    function removeWatchTargetNew(steam) {
        state.watchTargetPlayers = state.watchTargetPlayers.filter(function(p) { return p.steam !== steam; });
        renderNewWatchChips();
    }

    function renderNewWatchChips() {
        var container = document.getElementById('watch-target-chips');
        if (!container) return;
        var targets = state.watchTargetPlayers || [];
        if (!targets.length) { container.innerHTML = ''; return; }
        container.innerHTML = targets.map(function(p) {
            return '<span class="watch-chip">' + Utils.escapeHtml(p.name || p.steam) +
                '<span class="watch-chip-x" onclick="App.removeWatchTargetNew(\'' + Utils.escapeHtml(p.steam) + '\')">×</span>' +
            '</span>';
        }).join('');
    }
function openWatchPlayersModal(watchId) {
        var w = (state.itemWatchlist || []).find(function(x) { return x.id === watchId; });
        if (!w) return;
        state.watchEditId = watchId;
        state.watchEditTargets = [];
        try { if (w.target_players) state.watchEditTargets = JSON.parse(w.target_players); } catch(e) {}
        var modal = document.getElementById('watch-players-modal');
        if (modal) modal.classList.remove('hidden');
        var title = document.getElementById('wpm-item-name');
        if (title) title.textContent = w.item_label || w.item_name;
        renderEditWatchChips();
        bindWatchEditPlayerSearch();
    }

    function bindWatchEditPlayerSearch() {
        var inp = document.getElementById('wpm-player-search');
        if (!inp || inp._bound) return;
        inp._bound = true;
        var dd = document.getElementById('wpm-player-dropdown');
        var debounce = null;
        inp.addEventListener('input', function() {
            var q = this.value.trim();
            clearTimeout(debounce);
            if (!q) { if (dd) { dd.innerHTML = ''; dd.style.display = 'none'; } return; }
            // Quick online results
            var players = (state.dashboardData && state.dashboardData.onlinePlayersList) || [];
            var ql = q.toLowerCase();
            var quick = players.filter(function(p) {
                return ((p.name || '') + ' ' + (p.steam || '') + ' ' + p.server_id).toLowerCase().indexOf(ql) !== -1;
            }).slice(0, 5).map(function(p) {
                return buildPlayerDropdownItem({ steam: p.steam, player_name: p.name, is_online: true, discord: null }, 'App.addWatchTargetEdit');
            });
            if (quick.length && dd) { dd.innerHTML = quick.join(''); dd.style.display = 'block'; }
            debounce = setTimeout(function() {
                state._watchPlayerSearchContext = 'edit';
                Utils.nuiCallback('searchWatchPlayers', { query: q });
            }, 350);
        });
        inp.addEventListener('focus', function() { state._watchPlayerSearchContext = 'edit'; });
        document.addEventListener('click', function(e) {
            if (dd && !inp.contains(e.target) && !dd.contains(e.target)) { dd.innerHTML = ''; dd.style.display = 'none'; }
        });
    }

    function addWatchTargetEdit(steam, name) {
        if (!steam) return;
        if (state.watchEditTargets.some(function(p) { return p.steam === steam; })) return;
        state.watchEditTargets.push({ steam: steam, name: name });
        renderEditWatchChips();
        var inp = document.getElementById('wpm-player-search');
        if (inp) inp.value = '';
        var dd = document.getElementById('wpm-player-dropdown');
        if (dd) { dd.innerHTML = ''; dd.style.display = 'none'; }
    }

    function removeWatchTargetEdit(steam) {
        state.watchEditTargets = state.watchEditTargets.filter(function(p) { return p.steam !== steam; });
        renderEditWatchChips();
    }

    function renderEditWatchChips() {
        var container = document.getElementById('wpm-chips');
        if (!container) return;
        var targets = state.watchEditTargets || [];
        if (!targets.length) {
            container.innerHTML = '<span style="font-size:11px;color:var(--text-dim)">No specific targets — alerts on all players</span>';
            return;
        }
        container.innerHTML = targets.map(function(p) {
            return '<span class="watch-chip">' + Utils.escapeHtml(p.name || p.steam) +
                '<span class="watch-chip-x" onclick="App.removeWatchTargetEdit(\'' + Utils.escapeHtml(p.steam) + '\')">×</span>' +
            '</span>';
        }).join('');
    }

    function saveWatchTargets() {
        if (!state.watchEditId) return;
        Utils.nuiCallback('updateWatchTargets', {
            id: state.watchEditId,
            targets: state.watchEditTargets
        });
        // Optimistic update
        state.itemWatchlist = null;
        var tbody = document.getElementById('watchlist-tbody');
        if (tbody) tbody.innerHTML = '<tr class="empty-row"><td colspan="11">Saving...</td></tr>';
        var modal = document.getElementById('watch-players-modal');
        if (modal) modal.classList.add('hidden');
        state.watchEditId = null;
        state.watchEditTargets = [];
        setTimeout(function() { if (!state.itemWatchlist) Utils.nuiCallback('getItemWatchlist', {}); }, 800);
    }

    function renderWatchPlayerSearchResults(results) {
        var ctx = state._watchPlayerSearchContext || 'new';
        var ddId = ctx === 'edit' ? 'wpm-player-dropdown' : 'watch-player-dropdown';
        var addFn = ctx === 'edit' ? 'App.addWatchTargetEdit' : 'App.addWatchTargetNew';
        var dd = document.getElementById(ddId);
        if (!dd) return;
        if (!results || !results.length) {
            dd.innerHTML = '<div style="padding:8px;font-size:11px;color:var(--text-dim)">No players found</div>';
            dd.style.display = 'block';
            return;
        }
        dd.innerHTML = results.map(function(p) {
            return buildPlayerDropdownItem(p, addFn);
        }).join('');
        dd.style.display = 'block';
    }
function openWatchNotesModal(watchId) {
        var w = (state.itemWatchlist || []).find(function(x) { return x.id === watchId; });
        if (!w) return;
        var modal = document.getElementById('watch-notes-modal');
        if (!modal) return;
        modal.classList.remove('hidden');
        var title = document.getElementById('wnm-item-name');
        if (title) title.textContent = w.item_label || w.item_name;
        var notesEl = document.getElementById('wnm-notes');
        if (notesEl) notesEl.value = w.notes || '';
        var idEl = document.getElementById('wnm-watch-id');
        if (idEl) idEl.value = watchId;
    }

    function saveWatchNotes() {
        var watchId = parseInt(val('wnm-watch-id'));
        if (!watchId) return;
        var notes = document.getElementById('wnm-notes') ? document.getElementById('wnm-notes').value : '';
        Utils.nuiCallback('updateWatchNotes', { id: watchId, notes: notes });
        // Optimistic: update in local state so re-render shows new notes without full refresh
        if (state.itemWatchlist) {
            var w = state.itemWatchlist.find(function(x) { return x.id === watchId; });
            if (w) { w.notes = notes; renderItemWatchlist(); }
        }
        var modal = document.getElementById('watch-notes-modal');
        if (modal) modal.classList.add('hidden');
    }
function bindWatchlistBulkActions() {
        // Select-all checkbox
        var checkAll = document.getElementById('watchlist-check-all');
        if (checkAll && !checkAll._bound) {
            checkAll._bound = true;
            checkAll.addEventListener('change', function() {
                document.querySelectorAll('.watchlist-row-check').forEach(function(cb) {
                    cb.checked = checkAll.checked;
                });
            });
        }

        var enableBtn = document.getElementById('btn-watch-enable-all');
        if (enableBtn && !enableBtn._bound) {
            enableBtn._bound = true;
            enableBtn.addEventListener('click', function() {
                var ids = getCheckedWatchIds();
                if (!ids.length) { Utils.showToast('No watches selected (or select via checkboxes)', 'info'); return; }
                Utils.nuiCallback('bulkToggleWatches', { ids: ids, enabled: true });
                state.itemWatchlist = null;
                setTimeout(function() { if (!state.itemWatchlist) Utils.nuiCallback('getItemWatchlist', {}); }, 600);
            });
        }

        var disableBtn = document.getElementById('btn-watch-disable-all');
        if (disableBtn && !disableBtn._bound) {
            disableBtn._bound = true;
            disableBtn.addEventListener('click', function() {
                var ids = getCheckedWatchIds();
                if (!ids.length) { Utils.showToast('No watches selected (or select via checkboxes)', 'info'); return; }
                Utils.nuiCallback('bulkToggleWatches', { ids: ids, enabled: false });
                state.itemWatchlist = null;
                setTimeout(function() { if (!state.itemWatchlist) Utils.nuiCallback('getItemWatchlist', {}); }, 600);
            });
        }

        // Watchlist filter
        var filterInp = document.getElementById('watchlist-filter');
        if (filterInp && !filterInp._bound) {
            filterInp._bound = true;
            var deb = null;
            filterInp.addEventListener('input', function() {
                clearTimeout(deb);
                deb = setTimeout(renderItemWatchlist, 120);
            });
        }

        var statusFilter = document.getElementById('watchlist-status-filter');
        if (statusFilter && !statusFilter._bound) {
            statusFilter._bound = true;
            statusFilter.addEventListener('change', renderItemWatchlist);
        }
    }

    function getCheckedWatchIds() {
        var ids = [];
        document.querySelectorAll('.watchlist-row-check:checked').forEach(function(cb) {
            var id = parseInt(cb.dataset.id);
            if (id) ids.push(id);
        });
        return ids;
    }
var _quickWatchContext = null;
    function quickWatchCurrentItem() {
        if (!_quickWatchContext) return;
        var modal = document.getElementById('item-detail-modal');
        if (modal) modal.classList.add('hidden');
        // Switch to watchlist subtab and pre-select the item
        var watchTab = document.querySelector('[data-subtab="watchlist"]');
        if (watchTab) watchTab.click();
        setTimeout(function() {
            selectWatchItem(_quickWatchContext.name, _quickWatchContext.label);
        }, 100);
    }

    // Watch a specific player for a specific item — opens watchlist step 2 with player pre-added
    function watchPlayerForItem(steam, playerName, itemName, itemLabel) {
        var modal = document.getElementById('item-detail-modal');
        if (modal) modal.classList.add('hidden');
        var watchTab = document.querySelector('[data-subtab="watchlist"]');
        if (watchTab) watchTab.click();
        setTimeout(function() {
            selectWatchItem(itemName, itemLabel || itemName);
            // Pre-add the player as a target
            setTimeout(function() {
                if (steam && playerName) {
                    addWatchTargetNew(steam, playerName);
                }
            }, 80);
        }, 100);
    }

    function openItemDetail(itemName, itemLabel) {
        var modal = document.getElementById('item-detail-modal');
        if (!modal) return;
        modal.classList.remove('hidden');
        document.getElementById('item-detail-title').textContent = itemLabel || itemName;

        // Store context for quick-watch button
        _quickWatchContext = { name: itemName, label: itemLabel || itemName };

        // Header with image
        var header = document.getElementById('item-detail-header');
        header.innerHTML = '<div class="item-detail-header">' +
            itemImageHtml(itemName, 'item-detail-img', '64px') +
            '<div><div class="item-detail-name">' + Utils.escapeHtml(itemLabel || itemName) + '</div>' +
            '<div class="item-detail-id">' + Utils.escapeHtml(itemName) + '</div></div>' +
        '</div>';

        // Bind detail tabs
        var tabs = document.getElementById('item-detail-tabs');
        if (tabs) {
            tabs.querySelectorAll('.items-subtab').forEach(function(btn) {
                btn.classList.toggle('active', btn.dataset.dtab === 'holders');
            });
        }

        // Set content to loading, request data
        document.getElementById('item-detail-content').innerHTML = '<div class="loading-placeholder">Loading holders...</div>';
        state._detailItem = itemName;
        Utils.nuiCallback('getItemHolders', { itemName: itemName });

        // Bind detail sub-tabs if not already
        if (tabs && !tabs._bound) {
            tabs._bound = true;
            tabs.querySelectorAll('.items-subtab').forEach(function(btn) {
                btn.addEventListener('click', function() {
                    var dtab = btn.dataset.dtab;
                    tabs.querySelectorAll('.items-subtab').forEach(function(b) { b.classList.toggle('active', b.dataset.dtab === dtab); });
                    if (dtab === 'holders') {
                        Utils.nuiCallback('getItemHolders', { itemName: state._detailItem });
                    } else if (dtab === 'timeline') {
                        Utils.nuiCallback('getItemTimeline', { itemName: state._detailItem });
                    } else if (dtab === 'velocity') {
                        Utils.nuiCallback('getItemVelocity', { itemName: state._detailItem, hours: 48 });
                    }
                });
            });
        }
    }

    function renderItemHolders() {
        var d = state.itemHolders;
        var el = document.getElementById('item-detail-content');
        if (!el || !d) return;
        var holders = d.holders || [];
        if (!holders.length) {
            el.innerHTML = '<div class="loading-placeholder">No players currently hold this item</div>';
            return;
        }
        var itemName = d.itemName || state._detailItem || '';
        var itemLabel = (_quickWatchContext && _quickWatchContext.name === itemName) ? _quickWatchContext.label : itemName;

        el.innerHTML = '<div style="display:flex;gap:6px;margin-bottom:8px;align-items:center">' +
            '<span style="font-size:11px;color:var(--text-dim)">' + holders.length + ' holder' + (holders.length !== 1 ? 's' : '') + '</span>' +
            '<button class="btn btn-accent btn-xs" onclick="App.quickWatchCurrentItem()" style="margin-left:auto" title="Watch this item for all players">' +
                '<i class="fa-solid fa-eye" style="font-size:9px;margin-right:4px"></i>Watch All Players' +
            '</button>' +
        '</div>' +
        '<table class="tbl tbl-sm"><thead><tr><th>Player</th><th>Character</th><th>Quantity</th><th>Steam</th><th></th></tr></thead><tbody>' +
            holders.map(function(h) {
                var steam = h.steam || '';
                var name = h.player_name || h.char_name || '-';
                var watchBtn = steam ? '<button class="btn btn-muted btn-xs" title="Watch this player for ' + Utils.escapeHtml(itemName) + '" onclick="App.watchPlayerForItem(' + JSON.stringify(steam) + ',' + JSON.stringify(name) + ',' + JSON.stringify(itemName) + ',' + JSON.stringify(itemLabel) + ')"><i class="fa-solid fa-eye" style="font-size:9px"></i></button>' : '';
                return '<tr>' +
                    '<td>' + Utils.escapeHtml(h.player_name || '-') + '</td>' +
                    '<td>' + Utils.escapeHtml(h.char_name || '-') + '</td>' +
                    '<td class="cell-mono">' + Utils.formatNumber(h.quantity || 0) + '</td>' +
                    '<td class="cell-mono">' + Utils.escapeHtml(Utils.truncate(steam, 22)) + '</td>' +
                    '<td style="white-space:nowrap">' + watchBtn + '</td>' +
                '</tr>';
            }).join('') + '</tbody></table>';
    }

    function renderItemTimelineTab() {
        var d = state.itemTimeline;
        var el = document.getElementById('item-detail-content');
        if (!el || !d) return;
        var tl = d.timeline || [];
        if (!tl.length) {
            el.innerHTML = '<div class="loading-placeholder">No timeline events</div>';
            return;
        }
        el.innerHTML = '<table class="tbl tbl-sm"><thead><tr><th>Time</th><th>Player</th><th>Action</th><th>Qty</th><th>Source</th><th>Flag</th></tr></thead><tbody>' +
            tl.map(function(e) {
                return '<tr>' +
                    '<td>' + Utils.timeAgo(e.created_at) + '</td>' +
                    '<td>' + Utils.escapeHtml(e.player_name || '-') + '</td>' +
                    '<td><span class="sev sev-' + (e.action === 'add' ? 'info' : 'warning') + '">' + Utils.escapeHtml(e.action) + '</span></td>' +
                    '<td class="cell-mono">' + Utils.formatNumber(e.quantity) + '</td>' +
                    '<td>' + Utils.escapeHtml(e.source_resource || '-') + '</td>' +
                    '<td>' + Utils.flagIndicator(e.flagged) + '</td>' +
                '</tr>';
            }).join('') + '</tbody></table>';
    }

    function renderItemVelocity() {
        var d = state.itemVelocity;
        var el = document.getElementById('item-detail-content');
        if (!el || !d) return;
        var v = d.velocity || [];
        if (!v.length) {
            el.innerHTML = '<div class="loading-placeholder">No velocity data available</div>';
            return;
        }
        // Render as a visual bar chart using CSS
        var maxVal = 0;
        v.forEach(function(b) { maxVal = Math.max(maxVal, (b.added || 0), (b.removed || 0)); });
        if (maxVal === 0) maxVal = 1;

        el.innerHTML = '<div class="velocity-chart">' +
            v.map(function(b) {
                var addPct = Math.round(((b.added || 0) / maxVal) * 100);
                var remPct = Math.round(((b.removed || 0) / maxVal) * 100);
                var timeLabel = (b.time_bucket || '').slice(-5); // HH:00
                return '<div class="vel-bar-group">' +
                    '<div class="vel-bar vel-bar-add" style="height:' + addPct + '%" title="+' + (b.added || 0) + '"></div>' +
                    '<div class="vel-bar vel-bar-rem" style="height:' + remPct + '%" title="-' + (b.removed || 0) + '"></div>' +
                    '<div class="vel-label">' + Utils.escapeHtml(timeLabel) + '</div>' +
                '</div>';
            }).join('') +
        '</div>' +
        '<div class="vel-legend"><span class="vel-dot vel-dot-add"></span> Added <span class="vel-dot vel-dot-rem"></span> Removed</div>';
    }
function toggleItemWatch(id) {
        Utils.nuiCallback('toggleItemWatch', { id: id });
    }
    function removeItemWatch(id) {
        confirmAction('Remove Watch', 'Remove this item from the watchlist?', function() {
            Utils.nuiCallback('removeItemWatch', { id: id });
        });
    }
function renderAlerts() {
        hidePageLoading('alerts');
        var d = state.alertList;
        if (!d) return;
        var list = Array.isArray(d) ? d : (d.rows || d.alerts || []);
        var total = d.total !== undefined ? d.total : list.length;
        var tbody = document.getElementById('alerts-tbody');
        if (!tbody) return;
        if (!list.length) {
            tbody.innerHTML = '<tr class="empty-row"><td colspan="7">No alerts</td></tr>';
            return;
        }
        tbody.innerHTML = list.map(function (a) {
            return '<tr>' +
                '<td>' + Utils.severityBadge(a.severity) + '</td>' +
                '<td>' + Utils.escapeHtml(a.alert_type || a.type || '-') + '</td>' +
                '<td>' + Utils.escapeHtml(Utils.truncate(a.title || a.message, 50)) + '</td>' +
                '<td><a href="#" onclick="App.openPlayerDetail(\'' + Utils.escapeHtml(a.steam || '') + '\', null, \'' + Utils.escapeHtml(a.license || '') + '\');return false" style="color:var(--accent)">' + Utils.escapeHtml(a.player_name || '-') + '</a></td>' +
                '<td>' + Utils.timeAgo(a.created_at) + '</td>' +
                '<td>' + (a.acknowledged ? '<span class="badge badge-muted">Resolved</span>' : '<span class="badge badge-red">Open</span>') + '</td>' +
                '<td>' + (!a.acknowledged ? '<button class="btn btn-muted btn-sm" onclick="App.resolveAlert(' + (a.id || 0) + ')">Resolve</button>' : '') + '</td>' +
            '</tr>';
        }).join('');
    }
function renderDetections() {
        hidePageLoading('anticheat');
        var d = state.detectionList;
        if (!d) return;
        var list = Array.isArray(d) ? d : (d.rows || d.detections || []);
        var tbody = document.getElementById('detections-tbody');
        if (!tbody) return;
        if (!list.length) {
            tbody.innerHTML = '<tr class="empty-row"><td colspan="8">No detections</td></tr>';
            return;
        }
        tbody.innerHTML = list.map(function (det) {
            var fullDetails = resolveAmmoHash(det.details) || '-';
            var shortDetails = Utils.truncate(fullDetails, 55);
            var detailsCell = fullDetails.length > 55
                ? '<td class="det-details-cell" title="Click to expand" onclick="App.showInfoModal(\'Detection Details\', \'' + fullDetails.replace(/'/g, '&#39;').replace(/\\/g, '\\\\') + '\')" style="cursor:pointer;max-width:220px;overflow:hidden;text-overflow:ellipsis;white-space:nowrap;color:var(--accent)">' + Utils.escapeHtml(shortDetails) + ' <span style="font-size:0.7em;opacity:.7">[+]</span></td>'
                : '<td style="max-width:220px;overflow:hidden;text-overflow:ellipsis;white-space:nowrap">' + Utils.escapeHtml(fullDetails) + '</td>';
            return '<tr>' +
                '<td>' + Utils.severityBadge(det.severity) + '</td>' +
                '<td>' + Utils.escapeHtml(det.detection_type || det.type || '-') + '</td>' +
                '<td><a href="#" onclick="App.openPlayerDetail(\'' + Utils.escapeHtml(det.steam || '') + '\', null, \'' + Utils.escapeHtml(det.license || '') + '\');return false" style="color:var(--accent)">' + Utils.escapeHtml(det.player_name || '-') + '</a></td>' +
                detailsCell +
                '<td>' + Utils.escapeHtml(det.action_taken || '-') + '</td>' +
                '<td>' + Utils.timeAgo(det.created_at) + '</td>' +
                '<td>' + (det.resolved ? '<span class="badge badge-muted">Resolved</span>' : '<span class="badge badge-warn">Open</span>') + '</td>' +
                '<td>' + (!det.resolved ? '<button class="btn btn-muted btn-sm" onclick="App.resolveDetection(' + (det.id || 0) + ')">Resolve</button>' : '') + '</td>' +
            '</tr>';
        }).join('');
    }
function renderBans() {
        hidePageLoading('bans');
        var d = state.banList;
        if (!d) return;
        var list = d.bans || [];
        var tbody = document.getElementById('bans-tbody');
        if (!tbody) return;
        if (!list.length) {
            tbody.innerHTML = '<tr class="empty-row"><td colspan="9">No bans</td></tr>';
            return;
        }
        tbody.innerHTML = list.map(function (b) {
            var active = b.is_active !== false && b.is_active !== 0;
            var expiry = b.expiry_date ? Utils.formatDate(b.expiry_date) : (b.ban_type === 'permanent' ? 'Never' : '-');
            return '<tr>' +
                '<td>' + Utils.escapeHtml(b.player_name || '-') + '</td>' +
                '<td class="cell-mono">' + Utils.escapeHtml(Utils.truncate(b.steam, 20)) + '</td>' +
                '<td>' + Utils.escapeHtml(Utils.truncate(b.reason, 40)) + '</td>' +
                '<td>' + Utils.escapeHtml(b.ban_type || 'permanent') + '</td>' +
                '<td>' + Utils.escapeHtml(b.banned_by_name || b.banned_by || '-') + '</td>' +
                '<td>' + Utils.formatDate(b.created_at) + '</td>' +
                '<td>' + expiry + '</td>' +
                '<td><span class="badge ' + (active ? 'badge-red' : 'badge-muted') + '">' + (active ? 'Active' : 'Inactive') + '</span></td>' +
                '<td>' + (active ? '<button class="btn btn-muted btn-sm" onclick="App.editBan(' + (b.id || 0) + ')">Edit</button> <button class="btn btn-red btn-sm" onclick="App.unbanPlayer(\'' + Utils.escapeHtml(b.steam || '') + '\')">Unban</button>' : '') + '</td>' +
            '</tr>';
        }).join('');

        var totalCount = d.total || 0;
        var perPage = d.perPage || 25;
        var totalPages = Math.ceil(totalCount / perPage);
        var pagEl = document.getElementById('ban-pagination');
        if (totalPages > 1) {
            Utils.buildPagination(pagEl, d.page || state.banPage, totalPages, function (p) {
                state.banPage = p;
                Utils.nuiCallback('getBanList', { page: p });
            });
        } else if (pagEl) {
            pagEl.innerHTML = '';
        }
    }


    
function loadCommunitySync() {
    var badge = document.getElementById('community-sync-badge');
    Utils.nuiCallback('getCommunitySync', {})
        .then(function (r) {
            state.communitySyncList = r.entries || [];
            renderCommunitySync();
            var cnt = state.communitySyncList.length;
            if (badge) {
                badge.textContent = cnt;
                if (cnt > 0) badge.classList.remove('hidden');
                else badge.classList.add('hidden');
            }
        })
        .catch(function (e) {
            Utils.showToast('Failed to load community sync list', 'error');
            console.error('getCommunitySync error', e);
        });
}

function renderCommunitySync() {
    var tbody = document.getElementById('community-sync-tbody');
    var list = state.communitySyncList || [];
    if (!tbody) return;
    if (list.length === 0) {
        tbody.innerHTML = '<tr><td colspan="7" style="text-align:center;padding:20px;color:var(--text-muted)">No new community bans to review</td></tr>';
        return;
    }
    tbody.innerHTML = list.map(function (ban, i) {
        var id = ban.steam || ban.license || '';
        var shortId = id.length > 24 ? id.substring(0, 24) + '…' : id;
        var date = ban.reportedAt ? ban.reportedAt.substring(0, 10) : '—';
        var category = ban.category || 'unknown';
        var catColor = {
            cheating: 'var(--danger)',
            hacking: 'var(--danger)',
            toxicity: 'var(--warn)',
            exploiting: 'var(--warn)',
            other: 'var(--text-muted)'
        }[category] || 'var(--text-muted)';
        return '<tr data-sync-idx="' + i + '">' +
            '<td>' + Utils.escapeHtml(ban.playerName || '—') + '</td>' +
            '<td><span title="' + Utils.escapeHtml(id) + '" style="font-size:11px;font-family:monospace">' + Utils.escapeHtml(shortId) + '</span></td>' +
            '<td>' + Utils.escapeHtml(ban.reason || '—') + '</td>' +
            '<td><span style="color:' + catColor + ';font-weight:600;text-transform:uppercase;font-size:10px">' + Utils.escapeHtml(category) + '</span></td>' +
            '<td>' + Utils.escapeHtml(ban.submittedBy || '—') + '</td>' +
            '<td>' + Utils.escapeHtml(date) + '</td>' +
            '<td style="white-space:nowrap">' +
                '<button class="btn btn-accent btn-xs sync-accept-btn" data-idx="' + i + '">Accept</button> ' +
                '<button class="btn btn-danger btn-xs sync-dismiss-btn" data-idx="' + i + '">Dismiss</button>' +
            '</td>' +
        '</tr>';
    }).join('');

    // Bind row buttons
    Array.from(tbody.querySelectorAll('.sync-accept-btn')).forEach(function (btn) {
        btn.addEventListener('click', function () {
            var row = btn.closest('tr');
            var idx = row ? parseInt(row.getAttribute('data-sync-idx'), 10) : NaN;
            var ban = state.communitySyncList[idx];
            if (!ban) return;
            Utils.nuiCallback('acceptCommunityBan', ban)
                .then(function (r) {
                    Utils.showToast('Banned: ' + (ban.playerName || 'player'), 'success');
                    state.communitySyncList.splice(idx, 1);
                    renderCommunitySync();
                    var badge = document.getElementById('community-sync-badge');
                    if (badge) {
                        var cnt = state.communitySyncList.length;
                        badge.textContent = cnt;
                        if (cnt === 0) badge.classList.add('hidden');
                    }
                }).catch(function () { Utils.showToast('Failed to accept ban', 'error'); });
        });
    });
    Array.from(tbody.querySelectorAll('.sync-dismiss-btn')).forEach(function (btn) {
        btn.addEventListener('click', function () {
            var row = btn.closest('tr');
            var idx = row ? parseInt(row.getAttribute('data-sync-idx'), 10) : NaN;
            var ban = state.communitySyncList[idx];
            if (!ban) return;
            Utils.nuiCallback('dismissCommunityBanEntry', ban)
                .then(function () {
                    state.communitySyncList.splice(idx, 1);
                    renderCommunitySync();
                    var badge = document.getElementById('community-sync-badge');
                    if (badge) {
                        var cnt = state.communitySyncList.length;
                        badge.textContent = cnt;
                        if (cnt === 0) badge.classList.add('hidden');
                    }
                }).catch(function () { Utils.showToast('Failed to dismiss', 'error'); });
        });
    });
}

function renderCommunityQueue() {
        var d = state.communityQueueList;
        var tbody = document.getElementById('community-queue-tbody');
        if (!tbody) return;
        var badge = document.getElementById('community-queue-badge');
        var total = (d && d.total) ? d.total : 0;
        if (badge) { badge.textContent = total; badge.classList.toggle('hidden', total === 0); }

        // Batch action bar
        var batchBar = document.getElementById('community-batch-bar');
        var batchCount = document.getElementById('community-batch-count');
        var batchNote = document.getElementById('community-batch-note');
        var batchSubmitBtn = document.getElementById('community-batch-submit');
        var selectAll = document.getElementById('community-select-all');

        function updateBatchBar() {
            var checked = tbody.querySelectorAll('.community-chk:checked');
            if (batchBar) batchBar.classList.toggle('hidden', checked.length === 0);
            if (batchCount) batchCount.textContent = checked.length;
        }

        if (!d || !d.entries || !d.entries.length) {
            tbody.innerHTML = '<tr class="empty-row"><td colspan="8">No bans pending community review</td></tr>';
            if (batchBar) batchBar.classList.add('hidden');
            return;
        }

        var catOpts = '<option value="">Select category...</option><option value="cheating">Cheating</option><option value="hacking">Hacking / Modding</option><option value="exploiting">Exploiting</option><option value="rwt">Real World Trading</option><option value="toxicity">Extreme Toxicity</option><option value="griefing">Griefing</option><option value="other">Other Serious Offence</option>';
        tbody.innerHTML = d.entries.map(function (b) {
            return '<tr data-id="' + b.id + '">' +
                '<td><input type="checkbox" class="community-chk" data-id="' + b.id + '"></td>' +
                '<td>' + Utils.escapeHtml(b.player_name || '-') + '</td>' +
                '<td class="cell-mono">' + Utils.escapeHtml(Utils.truncate(b.steam || b.license || '-', 20)) + '</td>' +
                '<td>' + Utils.escapeHtml(Utils.truncate(b.reason || '-', 50)) + '</td>' +
                '<td>' + Utils.escapeHtml(b.banned_by_name || 'txAdmin') + '</td>' +
                '<td>' + Utils.formatDate(b.created_at) + '</td>' +
                '<td><select class="sel community-cat" style="width:155px">' + catOpts + '</select></td>' +
                '<td style="white-space:nowrap">' +
                    '<button class="btn btn-accent btn-xs community-submit" data-id="' + b.id + '">Submit</button> ' +
                    '<button class="btn btn-muted btn-xs community-dismiss" data-id="' + b.id + '">Dismiss</button>' +
                '</td></tr>';
        }).join('');

        // Checkbox events
        tbody.querySelectorAll('.community-chk').forEach(function (chk) {
            chk.addEventListener('change', updateBatchBar);
        });

        // Select-all
        if (selectAll) {
            selectAll.checked = false;
            selectAll.onchange = function () {
                tbody.querySelectorAll('.community-chk').forEach(function (chk) { chk.checked = selectAll.checked; });
                updateBatchBar();
            };
        }

        // Bulk submit
        if (batchSubmitBtn) {
            batchSubmitBtn.onclick = function () {
                var checked = Array.from(tbody.querySelectorAll('.community-chk:checked'));
                if (!checked.length) return;
                var bansPayload = [];
                var missing = [];
                checked.forEach(function (chk) {
                    var row = chk.closest('tr');
                    var cat = row.querySelector('.community-cat').value;
                    if (!cat) { missing.push(row.querySelector('td:nth-child(2)').textContent); }
                    else { bansPayload.push({ id: parseInt(chk.dataset.id), category: cat }); }
                });
                if (missing.length) { Utils.showToast('Set a category for all selected bans first', 'warn'); return; }
                var note = batchNote ? batchNote.value.trim() : '';
                batchSubmitBtn.disabled = true;
                Utils.nuiCallback('bulkSubmitToCommunity', { bans: bansPayload, batchNote: note })
                    .then(function (res) {
                        batchSubmitBtn.disabled = false;
                        if (res && res.error) { Utils.showToast(res.error, 'error'); return; }
                        Utils.showToast('Submitted ' + (res.submitted || bansPayload.length) + ' ban(s) to community list', 'success');
                        checked.forEach(function (chk) { chk.closest('tr').remove(); });
                        if (batchNote) batchNote.value = '';
                        var n = Math.max(0, (parseInt(badge ? badge.textContent : 0) || 0) - bansPayload.length);
                        if (badge) { badge.textContent = n; badge.classList.toggle('hidden', n === 0); }
                        updateBatchBar();
                    }).catch(function () { batchSubmitBtn.disabled = false; });
            };
        }

        // Individual submit
        tbody.querySelectorAll('.community-submit').forEach(function (btn) {
            btn.addEventListener('click', function () {
                var row = btn.closest('tr');
                var cat = row.querySelector('.community-cat').value;
                if (!cat) { Utils.showToast('Select a category first', 'warn'); return; }
                btn.disabled = true;
                Utils.nuiCallback('submitToCommunity', { id: parseInt(btn.dataset.id), category: cat })
                    .then(function (res) {
                        if (res && res.error) { Utils.showToast(res.error, 'error'); btn.disabled = false; return; }
                        Utils.showToast('Submitted to community ban list', 'success');
                        row.remove();
                        if (badge) { var n = Math.max(0, (parseInt(badge.textContent) || 0) - 1); badge.textContent = n; badge.classList.toggle('hidden', n === 0); }
                        updateBatchBar();
                    }).catch(function () { btn.disabled = false; });
            });
        });

        // Individual dismiss
        tbody.querySelectorAll('.community-dismiss').forEach(function (btn) {
            btn.addEventListener('click', function () {
                var row = btn.closest('tr');
                btn.disabled = true;
                Utils.nuiCallback('dismissCommunity', { id: parseInt(btn.dataset.id) })
                    .then(function (res) {
                        if (res && res.error) { Utils.showToast(res.error, 'error'); btn.disabled = false; return; }
                        Utils.showToast('Dismissed — stays local only', 'info');
                        row.remove();
                        if (badge) { var n = Math.max(0, (parseInt(badge.textContent) || 0) - 1); badge.textContent = n; badge.classList.toggle('hidden', n === 0); }
                        updateBatchBar();
                    }).catch(function () { btn.disabled = false; });
            });
        });

        // Pagination
        var paginationEl = document.getElementById('community-queue-pagination');
        if (paginationEl) {
            var totalPages = d.totalPages || 1;
            var currentPage = state.communityQueuePage || 1;
            paginationEl.innerHTML = (totalPages > 1)
                ? Array.from({ length: totalPages }, function (_, i) {
                    var pg = i + 1;
                    return '<button class="btn btn-xs' + (pg === currentPage ? ' btn-accent' : ' btn-muted') + '">' + pg + '</button>';
                  }).join('')
                : '';
            paginationEl.querySelectorAll('button').forEach(function (btn, i) {
                btn.addEventListener('click', function () {
                    var p = i + 1;
                    state.communityQueuePage = p;
                    Utils.nuiCallback('getCommunityQueue', { page: p, status: 'pending' }).catch(function () {});
                });
            });
        }
    }

    function renderAppeals() {
        var d = state.appealList;
        if (!d) return;
        var list = Array.isArray(d) ? d : (d.appeals || []);
        var tbody = document.getElementById('appeals-tbody');
        if (!list.length) {
            tbody.innerHTML = '<tr class="empty-row"><td colspan="6">No pending appeals</td></tr>';
            return;
        }
        tbody.innerHTML = list.map(function (a) {
            return '<tr>' +
                '<td>' + Utils.escapeHtml(a.player_name || '-') + '</td>' +
                '<td class="cell-mono">' + Utils.escapeHtml(Utils.truncate(a.steam, 20)) + '</td>' +
                '<td>' + Utils.escapeHtml(Utils.truncate(a.reason || a.ban_reason, 30)) + '</td>' +
                '<td>' + Utils.escapeHtml(Utils.truncate(a.appeal_message || a.appeal, 40)) + '</td>' +
                '<td>' + Utils.formatDate(a.created_at) + '</td>' +
                '<td><button class="btn btn-green btn-sm" onclick="App.handleAppeal(' + (a.id || 0) + ',\'accept\')">Accept</button> <button class="btn btn-red btn-sm" onclick="App.handleAppeal(' + (a.id || 0) + ',\'deny\')">Deny</button></td>' +
            '</tr>';
        }).join('');
    }
function renderResources() {
        hidePageLoading('resources');
        var d = state.resourceList;
        if (!d) return;
        var list = Array.isArray(d) ? d : (d.resources || []);
        filterAndRenderResources(list);
    }

    function filterAndRenderResources(list) {
        var grid = document.getElementById('resource-grid');
        var search = (val('resource-search') || '').toLowerCase();
        var statusFilter = val('resource-filter-status');
        var filtered = list.filter(function (r) {
            var running = r.status === 'started' || r.status === 'running';
            if (statusFilter === 'running' && !running) return false;
            if (statusFilter === 'stopped' && running) return false;
            if (search && !(r.name || '').toLowerCase().includes(search)) return false;
            return true;
        });
        if (!filtered.length) {
            grid.innerHTML = emptyState('No resources found');
            return;
        }
        grid.className = 'resource-grid';
        grid.innerHTML = filtered.map(function (r) {
            var running = r.status === 'started' || r.status === 'running';
            return '<div class="res-card">' +
                '<div class="res-card-name">' + Utils.escapeHtml(r.name || '-') + '</div>' +
                '<div class="res-card-status ' + (running ? 'running' : 'stopped') + '">' + (running ? 'Running' : 'Stopped') + '</div>' +
                '<div class="res-actions">' +
                    (running ?
                        '<button class="btn btn-muted btn-sm" onclick="App.resourceAction(\'restart\',\'' + Utils.escapeHtml(r.name) + '\')">Restart</button><button class="btn btn-red btn-sm" onclick="App.resourceAction(\'stop\',\'' + Utils.escapeHtml(r.name) + '\')">Stop</button>'
                        : '<button class="btn btn-green btn-sm" onclick="App.resourceAction(\'start\',\'' + Utils.escapeHtml(r.name) + '\')">Start</button>') +
                '</div></div>';
        }).join('');
    }
function renderAdminLog() {
        hidePageLoading('logs');
        var d = state.adminLog;
        if (!d) return;
        var list = Array.isArray(d) ? d : (d.rows || d.entries || []);
        var tbody = document.getElementById('logs-tbody');
        if (!list.length) {
            tbody.innerHTML = '<tr class="empty-row"><td colspan="6">No admin log entries</td></tr>';
            return;
        }
        tbody.innerHTML = list.map(function (l) {
            return '<tr>' +
                '<td>' + Utils.timeAgo(l.created_at) + '</td>' +
                '<td>' + Utils.escapeHtml(l.admin_name || '-') + '</td>' +
                '<td><code style="font-size:11px;background:var(--bg-hover);padding:1px 5px;border-radius:3px">' + Utils.escapeHtml(l.action || '-') + '</code></td>' +
                '<td>' + Utils.escapeHtml(l.target_name || '-') + '</td>' +
                '<td title="' + Utils.escapeHtml(l.details || '') + '">' + Utils.escapeHtml(Utils.truncate(l.details, 80)) + '</td>' +
                '<td>' + Utils.severityBadge(l.severity || 'info') + '</td>' +
            '</tr>';
        }).join('');
            setupLogFilterBars();
    }

    function removePlayerFilterDropdown() {
        var el = document.getElementById('player-filter-dropdown');
        if (el) el.remove();
    }

    function showPlayerFilterDropdown(input, q, onSelect) {
        removePlayerFilterDropdown();
        var all = state.cachedPlayerNames || [];
        // Merge with online player list if cached names is sparse
        if (all.length === 0 && state.playerList && state.playerList.players) {
            all = state.playerList.players.map(function(p) {
                return { name: p.name || p.player_name || '', steam: p.steam || '', char_name: p.char_name || '', online: true };
            });
        }
        var ql = q.toLowerCase();
        var matches = all.filter(function(p) {
            return (p.name || '').toLowerCase().indexOf(ql) !== -1 ||
                   (p.steam || '').toLowerCase().indexOf(ql) !== -1 ||
                   (p.char_name || '').toLowerCase().indexOf(ql) !== -1;
        }).slice(0, 10);
        if (!matches.length) {
            // Show "no results" hint if user typed something
            if (ql.length < 2) return;
            var hint = document.createElement('div');
            hint.id = 'player-filter-dropdown';
            hint.style.cssText = 'position:absolute;z-index:9999;background:var(--bg-card);border:1px solid var(--border);border-radius:var(--radius);padding:8px 12px;font-size:12px;color:var(--text-dim);box-shadow:var(--shadow-md);min-width:180px;top:100%;left:0;right:0';
            hint.textContent = 'No matching players found';
            var wrap = input.parentNode;
            if (wrap) { wrap.style.position = 'relative'; wrap.appendChild(hint); }
            return;
        }

        var dd = document.createElement('div');
        dd.id = 'player-filter-dropdown';
        dd.style.cssText = 'position:absolute;z-index:9999;background:var(--bg-card);border:1px solid var(--border);border-radius:var(--radius);overflow:hidden;max-height:200px;overflow-y:auto;box-shadow:var(--shadow-md);min-width:220px;top:100%;left:0;right:0';
        matches.forEach(function(p) {
            var item = document.createElement('div');
            var badge = p.online ? '<span style="display:inline-block;width:6px;height:6px;background:var(--green);border-radius:50%;margin-right:4px;vertical-align:middle"></span>' : '';
            item.innerHTML = badge + Utils.escHtml(p.name || p.steam || '') +
                (p.char_name ? '<span style="color:var(--text-dim);font-size:11px;margin-left:6px">' + Utils.escHtml(p.char_name) + '</span>' : '');
            item.style.cssText = 'padding:7px 12px;cursor:pointer;display:flex;align-items:center;gap:4px;border-bottom:1px solid var(--border);font-size:13px';
            item.addEventListener('mousedown', function(e) {
                e.preventDefault();
                onSelect(p);
                removePlayerFilterDropdown();
            });
            dd.appendChild(item);
        });
        var wrap = input.parentNode;
        if (wrap) { wrap.style.position = 'relative'; wrap.appendChild(dd); }
    }

    function setupLogFilterBars() {
        var bars = document.querySelectorAll('.log-filter-bar');
        bars.forEach(function(bar) {
            var btns = bar.querySelectorAll('.log-filter-btn');
            var playerInput = bar.querySelector('.log-filter-player-input');
            btns.forEach(function(btn) {
                btn.addEventListener('click', function() {
                    btns.forEach(function(b) { b.classList.remove('active'); });
                    btn.classList.add('active');
                    var filter = btn.getAttribute('data-filter');
                    if (filter === 'player') {
                        if (playerInput) {
                            playerInput.style.display = '';
                            playerInput.focus();
                            // Auto-fetch player list if cache is empty
                            if ((!state.cachedPlayerNames || state.cachedPlayerNames.length === 0) &&
                                (!state.playerList || !state.playerList.players || state.playerList.players.length === 0)) {
                                Utils.nuiCallback('getPlayerList', { all: true }).catch(function() {});
                            }
                        }
                    } else {
                        if (playerInput) {
                            playerInput.style.display = 'none';
                            playerInput.value = '';
                            delete playerInput.dataset.selectedSteam;
                            removePlayerFilterDropdown();
                        }
                    }
                    applyLogFilter(bar, filter, playerInput ? playerInput.value : '');
                });
            });
            if (playerInput) {
                playerInput.addEventListener('input', function() {
                    var q = playerInput.value.trim();
                    if (!q) { removePlayerFilterDropdown(); playerInput.removeAttribute('data-filtering'); applyLogFilter(bar, 'player', ''); return; }
                    var cb = function(selected) {
                        playerInput.value = selected.name || selected.steam || '';
                        playerInput.dataset.selectedSteam = selected.steam || '';
                        playerInput.removeAttribute('data-filtering');
                        // Trigger server-side item log reload with this player
                        var subtabBtn = document.querySelector('.items-subtab[data-subtab="log"]');
                        if (subtabBtn) subtabBtn.click();
                        else Utils.nuiCallback('getItemLog', getItemFilters()).catch(function() {});
                    };
                    playerInput._filterCallback = cb;
                    playerInput.setAttribute('data-filtering', '1');
                    showPlayerFilterDropdown(playerInput, q, cb);
                });
                playerInput.addEventListener('blur', function() {
                    setTimeout(function() { removePlayerFilterDropdown(); playerInput.removeAttribute('data-filtering'); }, 200);
                });
            }
        });
    }

    function applyLogFilter(bar, filter, playerSearch) {
        var page = bar.closest('.page');
        if (!page) return;
        var rows = page.querySelectorAll('table.tbl tbody tr');
        var now = Date.now();
        var oneDayMs = 24 * 60 * 60 * 1000;
        rows.forEach(function(row) {
            var show = true;
            if (filter === 'recent') {
                var tsCell = row.querySelector('[data-ts]');
                if (tsCell) {
                    var ts = parseInt(tsCell.getAttribute('data-ts'), 10);
                    show = (now - ts) <= oneDayMs;
                }
            } else if (filter === 'player') {
                var search = (playerSearch || '').toLowerCase().trim();
                if (search) {
                    var text = row.textContent.toLowerCase();
                    show = text.indexOf(search) >= 0;
                }
            }
            row.style.display = show ? '' : 'none';
        });
    }
function renderChatLog() {
        hidePageLoading('chat');
        var d = state.chatLog;
        if (!d) return;
        var list = Array.isArray(d) ? d : (d.messages || []);
        var tbody = document.getElementById('chat-tbody');
        if (!list.length) {
            tbody.innerHTML = '<tr class="empty-row"><td colspan="5">No chat messages</td></tr>';
            return;
        }
        tbody.innerHTML = list.map(function (c) {
            var isCmd = c.is_command === 1 || c.is_command === '1' || c.is_command === true;
            var rowClass = isCmd ? ' class="chat-row-cmd"' : '';
            var typeLabel = isCmd ? '<span class="chat-badge-cmd">CMD</span>' : '<span class="chat-badge-chat">CHAT</span>';
            return '<tr' + rowClass + '>' +
                '<td>' + Utils.timeAgo(c.created_at) + '</td>' +
                '<td>' + Utils.escapeHtml(c.player_name || '-') + '</td>' +
                '<td class="chat-cell-msg">' + Utils.escapeHtml(c.message || '-') + '</td>' +
                '<td>' + typeLabel + '</td>' +
                '<td>' + Utils.flagIndicator(c.flagged) + '</td>' +
            '</tr>';
        }).join('');
    }
function renderTeleports() {
        hidePageLoading('teleports');
        var d = state.teleportLocations;
        if (!d) return;
        var list = Array.isArray(d) ? d : (d.locations || []);
        var catSelect = document.getElementById('teleport-category');
        var cats = {};
        list.forEach(function (t) { if (t.category) cats[t.category] = true; });
        catSelect.innerHTML = '<option value="">All Categories</option>' + Object.keys(cats).map(function (c) { return '<option value="' + Utils.escapeHtml(c) + '">' + Utils.escapeHtml(c) + '</option>'; }).join('');
        renderTeleportGrid(list);
    }

    function renderTeleportGrid(list) {
        var grid = document.getElementById('teleport-grid');
        if (!list || !list.length) {
            grid.innerHTML = emptyState('No teleport locations');
            return;
        }
        grid.className = 'tp-grid';
        grid.innerHTML = list.map(function (t) {
            var x = parseFloat(t.x) || 0, y = parseFloat(t.y) || 0, z = parseFloat(t.z) || 0;
            var editBtn = (!t.preset && t.id) ? '<button class="btn btn-muted btn-sm" onclick="App.editTeleport(' + t.id + ')">Edit</button>' : '';
            var delBtn = (!t.preset && t.id) ? '<button class="btn btn-red btn-sm" onclick="App.deleteTeleport(' + (t.id || 0) + ')">Delete</button>' : '';
            return '<div class="tp-card">' +
                '<div class="tp-name">' + Utils.escapeHtml(t.name || '-') + '</div>' +
                '<div class="tp-cat">' + Utils.escapeHtml(t.category || '-') + '</div>' +
                '<div class="tp-coords">X: ' + x.toFixed(1) + ' Y: ' + y.toFixed(1) + ' Z: ' + z.toFixed(1) + '</div>' +
                '<div class="tp-actions"><button class="btn btn-accent btn-sm" onclick="App.teleportTo(' + (t.id || 0) + ')">Teleport</button>' + editBtn + delBtn + '</div>' +
            '</div>';
        }).join('');
    }

    function filterTeleports() {
        var d = state.teleportLocations;
        if (!d) return;
        var list = Array.isArray(d) ? d : (d.locations || []);
        var cat = val('teleport-category');
        var search = (val('teleport-search') || '').toLowerCase();
        var filtered = list.filter(function (t) {
            if (cat && t.category !== cat) return false;
            if (search && !(t.name || '').toLowerCase().includes(search)) return false;
            return true;
        });
        renderTeleportGrid(filtered);
    }
function renderServerManagement() {
        hidePageLoading('server');
        var d = state.serverStatus;
        if (!d) return;
        setText('mgmt-players', Utils.formatNumber(d.players || d.playerCount || 0));
        setText('mgmt-max', d.maxPlayers || d.maxSlots || 32);
        setText('mgmt-uptime', Utils.formatDuration(typeof d.uptime === 'number' ? d.uptime : (d.uptimeSeconds || 0)));
        var uptimeMgmtEl = document.getElementById('mgmt-uptime'); if (uptimeMgmtEl) uptimeMgmtEl.className += ' uptime-display';
        var isOpen = d.status === 'open' || !d.isClosed;
        setText('mgmt-status', isOpen ? 'Open' : 'Closed');
        var toggleBtn = document.getElementById('btn-toggle-server');
        if (toggleBtn) {
            toggleBtn.textContent = isOpen ? 'Close Server' : 'Open Server';
            toggleBtn.className = isOpen ? 'btn btn-warn btn-sm' : 'btn btn-green btn-sm';
        }
        setText('mgmt-weather', d.weather || d.currentWeather || '-');

        var weathers = ['SUNNY', 'RAIN', 'SNOW', 'OVERCAST', 'FOG', 'THUNDER', 'DRIZZLE', 'SLEET', 'SNOWLIGHT', 'BLIZZARD', 'HAIL', 'MISTY', 'CLEARING'];
        var wbEl = document.getElementById('weather-buttons');
        if (wbEl) {
            wbEl.innerHTML = weathers.map(function (w) {
                return '<button class="btn btn-muted" onclick="App.setWeather(\'' + w + '\')">' + w.charAt(0) + w.slice(1).toLowerCase() + '</button>';
            }).join('');
        }

        var times = [
            { label: 'Dawn', h: 5 }, { label: 'Morning', h: 8 }, { label: 'Noon', h: 12 },
            { label: 'Afternoon', h: 15 }, { label: 'Evening', h: 18 }, { label: 'Night', h: 22 }, { label: 'Midnight', h: 0 }
        ];
        var tbEl = document.getElementById('time-buttons');
        if (tbEl) {
            tbEl.innerHTML = times.map(function (t) {
                return '<button class="btn btn-muted" onclick="App.setTime(' + t.h + ')">' + t.label + '</button>';
            }).join('');
        }
var fw = document.getElementById('mgmt-freeze-weather');
        var ft = document.getElementById('mgmt-freeze-time');
        if (fw) fw.checked = !!d.freezeWeather;
        if (ft) ft.checked = !!d.freezeTime;
        var ts = document.getElementById('mgmt-timescale');
        if (ts && d.timescale != null) { ts.value = d.timescale; setText('mgmt-timescale-val', d.timescale); }
var timeH = document.getElementById('time-hour');
        var timeM = document.getElementById('time-minute');
        if (timeH && d.time != null) timeH.value = Math.floor(d.time);
        if (timeM) timeM.value = d.timeMinute || 0;
var wsEl = document.getElementById('mgmt-wind-speed');
        var wdEl = document.getElementById('mgmt-wind-dir');
        if (wsEl) { wsEl.value = d.windSpeed || 0; setText('mgmt-wind-speed-val', d.windSpeed || 0); }
        if (wdEl) { wdEl.value = d.windDir || 0; setText('mgmt-wind-dir-val', (d.windDir || 0) + '°'); }
setText('mgmt-resources', d.resourceCount || '-');
        var avgPing = d.avgPing != null ? d.avgPing + 'ms' : '-';
        var maxPing = d.maxPing != null ? d.maxPing + 'ms' : '-';
        setText('mgmt-avg-ping', avgPing);
        setText('mgmt-max-ping', maxPing);
        var syncClass = d.avgPing > 200 ? 'sev sev-high' : d.avgPing > 100 ? 'sev sev-warning' : 'sev sev-ok';
        var syncEl = document.getElementById('mgmt-net-sync');
        if (syncEl) syncEl.innerHTML = d.avgPing != null ? '<span class="' + syncClass + '">' + (d.avgPing < 80 ? 'Good' : d.avgPing < 150 ? 'Fair' : 'Poor') + '</span>' : '-';
var rs = d.restartStatus || state.restartStatus;
        setText('mgmt-restart-status', rs && rs.active ? 'Restart in ' + rs.remaining + 's' : 'No restart scheduled');

        initServerToggles();
    }
    function renderReports() {
        hidePageLoading('reports');
        var d = state.reportList;
        if (!d) return;
        var list = Array.isArray(d) ? d : (d.reports || []);
        var tbody = document.getElementById('reports-tbody');
        if (!list.length) {
            tbody.innerHTML = '<tr class="empty-row"><td colspan="9">No reports</td></tr>';
            return;
        }
        tbody.innerHTML = list.map(function (r) {
            return '<tr>' +
                '<td>' + (r.id || '-') + '</td>' +
                '<td>' + Utils.escapeHtml(r.report_type || r.type || '-') + '</td>' +
                '<td>' + Utils.severityBadge(r.priority || 'low') + '</td>' +
                '<td>' + Utils.escapeHtml(Utils.truncate(r.title, 40)) + '</td>' +
                '<td>' + Utils.escapeHtml(r.reporter_name || '-') + '</td>' +
                '<td>' + Utils.escapeHtml(r.status || '-') + '</td>' +
                '<td>' + Utils.formatNumber(r.message_count || 0) + '</td>' +
                '<td>' + Utils.timeAgo(r.created_at) + '</td>' +
                '<td style="display:flex;gap:4px">' +
                    '<button class="btn btn-muted btn-sm" onclick="App.openReport(' + (r.id || 0) + ')">View</button>' +
                    '<button class="btn btn-danger btn-sm" onclick="App.deleteReport(' + (r.id || 0) + ')" title="Delete report">✕</button>' +
                '</td>' +
            '</tr>';
        }).join('');
    }

    function openReport(id) {
        document.getElementById('report-detail-modal').classList.remove('hidden');
        document.getElementById('report-detail-body').innerHTML = '<div style="text-align:center;padding:20px;color:var(--text-dim)">Loading...</div>';
        Utils.nuiCallback('getReportDetail', { id: id });
    }

    function renderReportDetail() {
        var r = state.reportDetail;
        if (!r) return;
        document.getElementById('report-detail-title').textContent = 'Report #' + (r.id || '');
        document.getElementById('report-detail-modal').classList.remove('hidden');

        var html = '<div class="kv"><span>Type</span><span>' + Utils.escapeHtml(r.report_type || '-') + '</span></div>' +
            '<div class="kv"><span>Priority</span><span>' + Utils.severityBadge(r.priority || 'low') + '</span></div>' +
            '<div class="kv"><span>Status</span><span>' + Utils.escapeHtml(r.status || '-') + '</span></div>' +
            '<div class="kv"><span>Reporter</span><span>' + Utils.escapeHtml(r.reporter_name || '-') + '</span></div>' +
            '<div class="kv"><span>Assigned To</span><span>' + Utils.escapeHtml(r.claimed_by_name || r.claimed_by || '-') + '</span></div>' +
            '<div class="kv"><span>Created</span><span>' + Utils.formatDate(r.created_at) + '</span></div>' +
            '<div style="margin:10px 0;padding:10px;background:var(--bg-main);border-radius:var(--radius);border:1px solid var(--border)">' +
            '<div style="font-weight:600;margin-bottom:4px;color:var(--text-bright)">' + Utils.escapeHtml(r.title || '') + '</div>';
        // Only show description if it differs from title and is non-empty
        var desc = (r.description || r.body || '').trim();
        if (desc && desc !== (r.title || '').trim()) {
            html += '<div style="font-size:13px">' + Utils.escapeHtml(desc) + '</div>';
        }
        html += '</div>';

        var messages = r.messages || [];
        if (messages.length) {
            html += '<div style="margin-top:10px"><div class="sec-title">Messages</div>';
            messages.forEach(function (m) {
                html += '<div style="padding:8px;margin-bottom:6px;background:var(--bg-main);border:1px solid var(--border);border-radius:var(--radius)">' +
                    '<div style="font-size:12px;font-weight:600;color:var(--accent)">' + Utils.escapeHtml(m.sender_name || '-') + ' <span style="color:var(--text-dim);font-weight:400">' + Utils.timeAgo(m.created_at) + '</span></div>' +
                    '<div style="font-size:13px;margin-top:3px">' + Utils.escapeHtml(m.message || '') + '</div></div>';
            });
            html += '</div>';
        }

        html += '<div style="margin-top:10px"><textarea id="report-reply-text" class="inp-area" rows="2" placeholder="Write a reply..."></textarea></div>';
        html += '<div style="display:flex;gap:4px;margin-top:8px;flex-wrap:wrap">';
        html += '<button class="btn btn-accent btn-sm" onclick="App.replyToReport(' + r.id + ')">Reply</button>';
        if (r.status === 'open') html += '<button class="btn btn-warn btn-sm" onclick="App.claimReport(' + r.id + ')">Claim</button>';
        if (r.status !== 'resolved') html += '<button class="btn btn-green btn-sm" onclick="App.resolveReport(' + r.id + ')">Resolve</button>';
        if (r.status === 'resolved') html += '<button class="btn btn-warn btn-sm" onclick="App.reopenReport(' + r.id + ')">Reopen</button>';
        html += '<button class="btn btn-danger btn-sm" style="margin-left:auto" onclick="App.deleteReport(' + r.id + ')">Delete Report</button>';
        html += '</div>';

        document.getElementById('report-detail-body').innerHTML = html;
    }
    function renderStatisticsOverview() {
        hidePageLoading('statistics');
        var d = state.serverStatistics;
        if (!d) return;
        var el = document.getElementById('stats-overview');
        if (!el) return;
        el.innerHTML = '<div class="stats-grid">' +
            statCard('Total Players', Utils.formatNumber(d.totalPlayers || 0)) +
            statCard('Players Today', Utils.formatNumber(d.playersToday || 0)) +
            statCard('Peak Today', Utils.formatNumber(d.peakToday || 0)) +
            statCard('Total Sessions', Utils.formatNumber(d.totalSessions || 0)) +
            statCard('Avg Session', Utils.formatDuration(d.avgSessionLength || 0)) +
            statCard('Total Bans', Utils.formatNumber(d.totalBans || 0)) +
            statCard('Active Bans', Utils.formatNumber(d.activeBans || 0)) +
            statCard('Total Detections', Utils.formatNumber(d.totalDetections || 0)) +
            statCard('Total Reports', Utils.formatNumber(d.totalReports || 0)) +
            statCard('Open Reports', Utils.formatNumber(d.openReports || 0)) +
            statCard('Total Money', Utils.formatMoney(d.totalMoney || 0)) +
            statCard('Total Gold', Utils.formatNumber(d.totalGold || 0)) +
        '</div>';

        if (d.dailyActivity && d.dailyActivity.labels) {
            var actLabels = d.dailyActivity.labels.map(function(l) {
                var ts = parseFloat(l);
                if (!isNaN(ts) && ts > 1000000000000) {
                    var dt = new Date(ts);
                    return ['Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'][dt.getMonth()] + ' ' + dt.getDate();
                }
                return l;
            });
            Utils.drawLineChart('chart-daily-activity', actLabels, [{
                data: d.dailyActivity.players || [],
                color: '#8c2020',
                fill: 'rgba(140,32,32,.06)'
            }, {
                data: d.dailyActivity.sessions || [],
                color: 'rgb(100,90,80)',
                fill: 'rgba(100,90,80,.06)'
            }]);
        }

        // Render ban and detection trend charts from dashboard data (populated at login)
        var dd = state.dashboardData;
        if (dd) renderBanTrendChart(dd.banTrend, dd.detectionTrend);
    }

    function renderBanTrendChart(banTrend, detectionTrend) {
        if (!banTrend && !detectionTrend) return;
        var labels = [];
        for (var i = 6; i >= 0; i--) {
            var d2 = new Date(); d2.setDate(d2.getDate() - i);
            labels.push(d2.toLocaleDateString('en-US', { month: 'short', day: 'numeric' }));
        }
        if (banTrend && document.getElementById('chart-ban-trend')) {
            Utils.drawLineChart('chart-ban-trend', labels, [{
                data: banTrend,
                color: '#b02828',
                fill: 'rgba(192,68,56,.07)'
            }]);
        }
        if (detectionTrend && document.getElementById('chart-detection-trend')) {
            Utils.drawLineChart('chart-detection-trend', labels, [{
                data: detectionTrend,
                color: '#9e7818',
                fill: 'rgba(230,168,23,.07)'
            }]);
        }
    }

    function statCard(label, value) {
        return '<div class="stat-card"><div class="stat-val">' + value + '</div><div class="stat-lbl">' + Utils.escapeHtml(label) + '</div></div>';
    }

    function renderLeaderboard() {
        var d = state.leaderboardData;
        if (!d) return;
        var list = Array.isArray(d) ? d : (d.entries || []);
        var tbody = document.getElementById('leaderboard-tbody');
        if (!list.length) {
            tbody.innerHTML = '<tr class="empty-row"><td colspan="6">No data</td></tr>';
            return;
        }
        tbody.innerHTML = list.map(function (p, i) {
            var isOnline = p.is_online || p.isOnline || false;
            return '<tr>' +
                '<td>' + (i + 1) + '</td>' +
                '<td>' + Utils.escapeHtml(p.player_name || p.name || '-') + '</td>' +
                '<td>' + Utils.escapeHtml(p.char_name || '-') + '</td>' +
                '<td>' + Utils.escapeHtml(p.player_group || p.group || '-') + '</td>' +
                '<td>' + formatLeaderboardValue(p) + '</td>' +
                '<td>' + Utils.statusDot(isOnline) + '</td>' +
            '</tr>';
        }).join('');
    }

    function formatLeaderboardValue(p) {
        var metric = getLeaderboardMetric();
        var v = p.value || p[metric] || 0;
        switch (metric) {
            case 'playtime': return Utils.formatPlaytime(v);
            case 'money': return Utils.formatMoney(v);
            case 'gold': return Utils.formatNumber(v);
            case 'sessions': return Utils.formatNumber(v);
            default: return String(v);
        }
    }
function renderPlayerInventoryModal(data) {
        if (!data) return;
        var items = data.items || [];
        var weapons = data.weapons || [];
        var html = '';
        var totalItems = 0;
        items.forEach(function (it) { totalItems += (it.count || it.amount || it.quantity || 0); });
        html = '<div style="margin-bottom:8px;display:flex;gap:8px;flex-wrap:wrap">' +
            '<div class="kpi" style="flex:1;padding:8px;min-width:90px"><span class="kpi-val">' + items.length + '</span><span class="kpi-lbl">Unique Items</span></div>' +
            '<div class="kpi" style="flex:1;padding:8px;min-width:90px"><span class="kpi-val">' + Utils.formatNumber(totalItems) + '</span><span class="kpi-lbl">Total Count</span></div>' +
            '<div class="kpi" style="flex:1;padding:8px;min-width:90px"><span class="kpi-val">' + weapons.length + '</span><span class="kpi-lbl">Weapons</span></div>' +
        '</div>';
        if (!items.length && !weapons.length) {
            html += emptyState('Empty inventory');
        } else {
            if (items.length) {
                html += '<div class="inv-section-title">Items <span>(' + items.length + ')</span></div>';
                html += '<div class="inv-grid">';
                items.forEach(function (it) {
                    var count = it.count || it.amount || it.quantity || 0;
                    var name = it.label || it.item || it.name || '-';
                    var itemId = it.name || it.item || '';
                    html += '<div class="inv-slot">' +
                        '<div class="inv-slot-badge">x' + count + '</div>' +
                        itemImageHtml(itemId, 'inv-slot-img', '44px') +
                        '<div class="inv-slot-name" title="' + Utils.escapeHtml(itemId) + '">' + Utils.escapeHtml(name) + '</div>' +
                    '</div>';
                });
                html += '</div>';
            }
            if (weapons.length) {
                html += '<div class="inv-section-title"><i class="fa-solid fa-gun nav-icon"></i> Weapons <span>(' + weapons.length + ')</span></div>';
                html += '<div class="inv-grid">';
                weapons.forEach(function (w) {
                    var name = w.label || w.name || 'Unknown';
                    var weapId = w.name || '';
                    html += '<div class="inv-slot">' +
                        itemImageHtml(weapId, 'inv-slot-img', '44px') +
                        '<div class="inv-slot-name" title="' + Utils.escapeHtml(weapId) + '">' + Utils.escapeHtml(name) + '</div>' +
                        (w.serialNumber ? '<div class="inv-weapon-meta">SN: ' + Utils.escapeHtml(w.serialNumber) + '</div>' : '') +
                        (w.ammo != null ? '<div class="inv-weapon-meta">Ammo: ' + Utils.formatNumber(w.ammo) + '</div>' : '') +
                    '</div>';
                });
                html += '</div>';
            }
        }
        // Money / character info row
        var money = data.money || {};
        var hasFinancials = money.cash != null || money.gold != null || money.rol != null || data.char_name;
        if (hasFinancials) {
            var moneyHtml = '<div style="display:flex;gap:8px;flex-wrap:wrap;margin-bottom:10px;padding:8px;background:var(--bg-deep,#0d1117);border-radius:4px;border:1px solid var(--border)">';
            if (data.char_name) moneyHtml += '<div class="kv" style="margin:0;flex:1;min-width:100px"><span>Character</span><span>' + Utils.escapeHtml(data.char_name) + '</span></div>';
            if (money.cash != null) moneyHtml += '<div class="kv" style="margin:0;flex:1;min-width:80px"><span>Cash</span><span style="color:#8c2020">' + Utils.formatNumber(money.cash) + '</span></div>';
            if (money.gold != null) moneyHtml += '<div class="kv" style="margin:0;flex:1;min-width:80px"><span>Gold</span><span style="color:#b09030">' + Utils.formatNumber(money.gold) + '</span></div>';
            if (money.rol != null) moneyHtml += '<div class="kv" style="margin:0;flex:1;min-width:80px"><span>Rol</span><span>' + Utils.formatNumber(money.rol) + '</span></div>';
            moneyHtml += '</div>';
            html = moneyHtml + html;
        }
        var srvId = state._inventoryServerId;
        if (srvId) {
            html += '<div style="border-top:1px solid var(--border);margin-top:10px;padding-top:10px"><div class="sec-title" style="margin-bottom:6px">Item Actions</div><div style="display:flex;gap:6px;flex-wrap:wrap"><div class="fg" style="margin:0;flex:1;min-width:110px"><label style="font-size:11px">Item Name</label><input type="text" id="inv-give-name" class="inp" placeholder="item_name" list="inv-items-list"><datalist id="inv-items-list"></datalist></div><div class="fg" style="margin:0;flex:0 0 60px"><label style="font-size:11px">Qty</label><input type="number" id="inv-give-qty" class="inp" placeholder="1" min="1" value="1"></div><button class="btn btn-green btn-xs" onclick="App.invGiveItem()">+ Give</button><button class="btn btn-red btn-xs" onclick="App.invRemoveItem()">Remove</button></div></div>';
        }
        document.getElementById('action-modal-title').textContent = 'Inventory: ' + items.length + ' items, ' + weapons.length + ' weapons';
        document.getElementById('action-modal-body').innerHTML = html;
        document.getElementById('action-modal-confirm').classList.add('hidden');
        document.getElementById('action-modal').classList.remove('hidden');
        state.pendingAction = null;
        var dl = document.getElementById('inv-items-list');
        if (dl && state.allItems && state.allItems.length) {
            state.allItems.slice(0, 200).forEach(function(it) { var opt = document.createElement('option'); opt.value = it.name || it.item || ''; dl.appendChild(opt); });
        }
        // Wire fuzzy search on inv-give-name
        var invInp = document.getElementById('inv-give-name');
        if (invInp) {
            invInp.setAttribute('autocomplete', 'off');
            invInp.removeAttribute('list');
            invInp.addEventListener('input', function() { itemSearchDebounce(invInp); });
            invInp.addEventListener('keydown', function(e) { if (e.key === 'Escape') closeItemDropdownFor(invInp); });
        }
    }
function getItemIcon(itemName) {
        var n = (itemName || '').toLowerCase();
        if (n.includes('meat') || n.includes('venison') || n.includes('steak')) return '<i class="fa-solid fa-drumstick-bite" style="font-size:11px"></i>';
        if (n.includes('fish') || n.includes('trout') || n.includes('bass') || n.includes('salmon')) return '<i class="fa-solid fa-fish" style="font-size:11px"></i>';
        if (n.includes('herb') || n.includes('ginseng') || n.includes('sage') || n.includes('oregano') || n.includes('mint') || n.includes('thyme')) return '<i class="fa-solid fa-seedling" style="font-size:11px"></i>';
        if (n.includes('skin') || n.includes('pelt') || n.includes('hide') || n.includes('feather') || n.includes('fur')) return '<i class="fa-solid fa-paw" style="font-size:11px"></i>';
        if (n.includes('gold') || n.includes('nugget') || n.includes('jewelry') || n.includes('ring') || n.includes('necklace')) return '<i class="fa-solid fa-coins" style="font-size:11px"></i>';
        if (n.includes('ammo') || n.includes('bullet') || n.includes('cartridge')) return '<i class="fa-solid fa-circle-dot" style="font-size:11px"></i>';
        if (n.includes('drink') || n.includes('whiskey') || n.includes('beer') || n.includes('moonshine') || n.includes('rum')) return '<i class="fa-solid fa-bottle-droplet" style="font-size:11px"></i>';
        if (n.includes('bread') || n.includes('food') || n.includes('corn') || n.includes('apple') || n.includes('carrot')) return '<i class="fa-solid fa-wheat-awn" style="font-size:11px"></i>';
        if (n.includes('medicine') || n.includes('tonic') || n.includes('cure') || n.includes('health')) return '<i class="fa-solid fa-kit-medical" style="font-size:11px"></i>';
        if (n.includes('key') || n.includes('lockpick')) return '<i class="fa-solid fa-key" style="font-size:11px"></i>';
        if (n.includes('map') || n.includes('document') || n.includes('letter') || n.includes('note')) return '<i class="fa-solid fa-scroll" style="font-size:11px"></i>';
        if (n.includes('tool') || n.includes('hammer') || n.includes('pickaxe') || n.includes('knife')) return '<i class="fa-solid fa-screwdriver-wrench" style="font-size:11px"></i>';
        if (n.includes('arrow') || n.includes('bow')) return '<i class="fa-solid fa-bow-arrow" style="font-size:11px"></i>';
        if (n.includes('tobacco') || n.includes('cigar') || n.includes('cigarette')) return '<i class="fa-solid fa-fire" style="font-size:11px"></i>';
        if (n.includes('rope') || n.includes('lasso')) return '<i class="fa-solid fa-circle-nodes" style="font-size:11px"></i>';
        if (n.includes('wood') || n.includes('lumber') || n.includes('log')) return '<i class="fa-solid fa-tree" style="font-size:11px"></i>';
        if (n.includes('ore') || n.includes('iron') || n.includes('steel') || n.includes('copper')) return '<i class="fa-solid fa-gem" style="font-size:11px"></i>';
        if (n.includes('cloth') || n.includes('cotton') || n.includes('thread') || n.includes('wool')) return '<i class="fa-solid fa-shirt" style="font-size:11px"></i>';
        return '<i class="fa-solid fa-box" style="font-size:11px"></i>';
    }
    /* ================================================================
     * SCREENING PAGE
     * ============================================================== */

    function loadScreeningPage() {
        bindScreeningControls();
        // Load screening config once (populates settings form)
        if (!state.screeningConfig) loadScreeningConfig();
        Utils.nuiCallback('getScreenings', {
            limit: 100,
            action: state.screeningFilter || 'all'
        }).catch(function() { hidePageLoading('screening'); });
    }

    function renderScreeningTable() {
        hidePageLoading('screening');
        var rows = state.screeningList || [];
        var q = (state.screeningSearch || '').trim().toLowerCase();

        // Client-side search filter
        if (q) {
            rows = rows.filter(function(r) {
                return (r.steam_profile_name && r.steam_profile_name.toLowerCase().includes(q)) ||
                       (r.steam && r.steam.toLowerCase().includes(q));
            });
        }

        var tbody = document.getElementById('screening-tbody');
        var empty = document.getElementById('screening-empty');
        var table = document.getElementById('screening-table');
        if (!tbody) return;

        if (!rows || rows.length === 0) {
            if (empty) empty.classList.remove('hidden');
            if (table) table.classList.add('hidden');
            return;
        }
        if (empty) empty.classList.add('hidden');
        if (table) table.classList.remove('hidden');

        tbody.innerHTML = rows.map(function(r) {
            var score = r.trust_score != null ? r.trust_score : 100;
            var scoreCls = score >= 70 ? 'ts-high' : score >= 40 ? 'ts-med' : 'ts-low';
            var flags = r.flags || [];
            var flagChips = flags.slice(0, 4).map(function(f) {
                var label = typeof f === 'string' ? f : (f.type || f.flag_type || '?');
                return '<span class="sc-flag-chip">' + Utils.escapeHtml(label) + '</span>';
            }).join('');
            if (flags.length > 4) flagChips += '<span class="sc-flag-chip">+' + (flags.length - 4) + '</span>';

            var action = (r.action_taken || 'unknown').toLowerCase();
            var actionCls = action === 'allowed' ? 'sc-allowed' : action === 'denied' ? 'sc-denied' : action === 'flagged' ? 'sc-flagged' : 'sc-cached';
            var vac = (r.vac_bans || 0) + ' / ' + (r.game_bans || 0);
            var altCount = (r.alt_matches && r.alt_matches.length) ? r.alt_matches.length : 0;

            return '<tr class="clickable-row" data-steam="' + Utils.escapeHtml(r.steam || '') + '">' +
                '<td>' + Utils.escapeHtml(r.steam_profile_name || 'Unknown') + '</td>' +
                '<td class="cell-mono" style="font-size:0.7rem">' + Utils.escapeHtml(r.steam || '-') + '</td>' +
                '<td><span class="ts-badge ' + scoreCls + '">' + score + '</span></td>' +
                '<td><div class="sc-flags">' + (flagChips || '<span style="color:var(--text-muted)">—</span>') + '</div></td>' +
                '<td>' + vac + '</td>' +
                '<td>' + (altCount > 0 ? '<span style="color:var(--danger);font-weight:600">' + altCount + '</span>' : '—') + '</td>' +
                '<td><span class="sc-pill ' + actionCls + '">' + Utils.escapeHtml(r.action_taken || '—') + '</span></td>' +
                '<td style="color:var(--text-dim);font-size:0.72rem">' + (r.created_at ? Utils.timeAgo(r.created_at) : '—') + '</td>' +
                '</tr>';
        }).join('');

        // Row click → screening profile modal
        tbody.querySelectorAll('tr.clickable-row').forEach(function(tr) {
            tr.addEventListener('click', function() {
                var steam = tr.dataset.steam;
                var cached = state.screeningList && state.screeningList.find(function(r) { return r.steam === steam; });
                renderPlayerScreeningModal(cached || null);
                if (!cached) {
                    Utils.nuiCallback('getPlayerScreening', { steam: steam }).catch(function() {});
                }
            });
        });
    }

    function bindScreeningControls() {
        // Only bind once
        var page = document.getElementById('page-screening');
        if (!page || page.dataset.bound) return;
        page.dataset.bound = '1';

        // Filter tabs
        page.querySelectorAll('.sc-filter-btn').forEach(function(btn) {
            btn.addEventListener('click', function() {
                page.querySelectorAll('.sc-filter-btn').forEach(function(b) { b.classList.remove('active'); });
                btn.classList.add('active');
                state.screeningFilter = btn.dataset.filter || 'all';
                loadScreeningPage();
            });
        });

        // Search input
        var searchIn = document.getElementById('screening-search');
        if (searchIn) {
            searchIn.addEventListener('input', function() {
                state.screeningSearch = searchIn.value;
                renderScreeningTable();
            });
        }

        // Refresh button
        var btnRefresh = document.getElementById('btn-screening-refresh');
        if (btnRefresh) btnRefresh.addEventListener('click', loadScreeningPage);

        // Settings toggle button
        var btnSettings = document.getElementById('btn-screening-settings');
        var panel = document.getElementById('screening-settings-panel');
        if (btnSettings && panel) {
            btnSettings.addEventListener('click', function() {
                var isHidden = panel.classList.contains('hidden');
                panel.classList.toggle('hidden', !isHidden);
                if (isHidden) loadScreeningConfig();
            });
        }

        // Settings close button
        var btnClose = document.getElementById('btn-screening-settings-close');
        if (btnClose && panel) btnClose.addEventListener('click', function() { panel.classList.add('hidden'); });

        // Save button
        var btnSave = document.getElementById('btn-screening-save');
        if (btnSave) btnSave.addEventListener('click', saveScreeningConfig);
    }

    function loadScreeningConfig() {
        Utils.nuiCallback('getScreeningConfig', {}).catch(function() {});
    }

    function renderScreeningConfigForm(cfg) {
        if (!cfg) return;
        var set = function(id, val) { var el = document.getElementById(id); if (el) { if (el.type === 'checkbox') el.checked = !!val; else el.value = val != null ? val : ''; } };
        set('sc-alert-threshold', cfg.AlertThreshold);
        set('sc-deny-threshold', cfg.DenyThreshold);
        set('sc-min-age', cfg.MinAccountAgeDeny);
        set('sc-max-ban-days', cfg.MaxDaysSinceLastBan);
        set('sc-new-acc-days', cfg.NewAccountDays);
        set('sc-cache-hours', cfg.CacheHours);
        set('sc-require-steam', cfg.RequireSteam);
        set('sc-require-discord', cfg.RequireDiscord);
        set('sc-deny-private', cfg.HardDenyPrivateProfile);
        set('sc-log-all', cfg.LogAll);
        var statusEl = document.getElementById('sc-settings-status');
        if (statusEl) statusEl.textContent = '';
    }

    function saveScreeningConfig() {
        var get = function(id) { var el = document.getElementById(id); if (!el) return null; return el.type === 'checkbox' ? el.checked : el.value; };
        var payload = {
            AlertThreshold:      parseInt(get('sc-alert-threshold'))  || 50,
            DenyThreshold:       parseInt(get('sc-deny-threshold'))   || 0,
            MinAccountAgeDeny:   parseInt(get('sc-min-age'))          || 0,
            MaxDaysSinceLastBan: parseInt(get('sc-max-ban-days'))     || 0,
            NewAccountDays:      parseInt(get('sc-new-acc-days'))     || 30,
            CacheHours:          parseInt(get('sc-cache-hours'))      || 24,
            RequireSteam:        !!get('sc-require-steam'),
            RequireDiscord:      !!get('sc-require-discord'),
            HardDenyPrivateProfile: !!get('sc-deny-private'),
            LogAll:              !!get('sc-log-all'),
        };
        var statusEl = document.getElementById('sc-settings-status');
        if (statusEl) statusEl.textContent = 'Saving…';
        Utils.nuiCallback('saveScreeningConfig', payload).catch(function() {
            if (statusEl) statusEl.textContent = '✗ Save failed';
        });
    }

    /* ================================================================
     * END SCREENING PAGE
     * ============================================================== */

    function renderPlayerScreeningModal(data) {
        if (!data) {
            document.getElementById('action-modal-title').textContent = 'Player Screening';
            document.getElementById('action-modal-body').innerHTML =
                '<div class="empty-state" style="padding:30px 20px;text-align:center">' +
                '<div style="font-size:36px;margin-bottom:12px;opacity:0.4">&#128269;</div>' +
                '<div style="font-weight:600;margin-bottom:6px">No screening data</div>' +
                '<div style="color:var(--text-dim);font-size:12px">This player has not been screened yet.<br>Screening runs automatically when players connect.</div>' +
                '</div>';
            document.getElementById('action-modal-confirm').classList.add('hidden');
            document.getElementById('action-modal').classList.remove('hidden');
            state.pendingAction = null;
            return;
        }
        var html = '';
        var flags = data.flags || [];
        var score = data.trust_score != null ? data.trust_score : (data.riskScore || data.risk_score || 0);
        var scoreColor = score >= 70 ? 'var(--text-bright)' : score >= 40 ? 'var(--warn)' : 'var(--danger)';
        var scoreLabel = score >= 70 ? 'Low Risk' : score >= 40 ? 'Moderate' : 'High Risk';
        html += '<div class="kv"><span>Trust Score</span><span style="font-weight:700;color:' + scoreColor + '">' + score + ' <span style="font-size:11px;opacity:0.8">(' + scoreLabel + ')</span></span></div>';
        if (data.steam_profile_name) html += '<div class="kv"><span>Steam Name</span><span>' + Utils.escapeHtml(data.steam_profile_name) + '</span></div>';
        if (data.steam_created) {
            var acctAge = Math.floor((Date.now()/1000 - data.steam_created) / (86400 * 365));
            html += '<div class="kv"><span>Account Age</span><span>' + acctAge + ' yr(s)</span></div>';
        }
        html += '<div class="kv"><span>Steam</span><span class="cell-mono">' + Utils.escapeHtml(data.steam || '-') + '</span></div>';
        if (data.vac_bans != null) html += '<div class="kv"><span>VAC Bans</span><span style="color:' + (data.vac_bans > 0 ? 'var(--danger)' : 'var(--text-dim)') + '">' + data.vac_bans + '</span></div>';
        if (data.game_bans != null) html += '<div class="kv"><span>Game Bans</span><span style="color:' + (data.game_bans > 0 ? 'var(--danger)' : 'var(--text-dim)') + '">' + data.game_bans + '</span></div>';
        if (data.community_ban) html += '<div class="kv"><span>Community Ban</span><span style="color:var(--danger)">YES</span></div>';
        if (data.days_since_last_ban != null && data.days_since_last_ban > 0) html += '<div class="kv"><span>Days Since Last Ban</span><span>' + data.days_since_last_ban + '</span></div>';
        if (data.previous_bans_here) html += '<div class="kv"><span>Prior Bans Here</span><span style="color:var(--danger)">' + data.previous_bans_here + '</span></div>';
        if (data.action_taken) html += '<div class="kv"><span>Action at Connect</span><span>' + Utils.escapeHtml(data.action_taken) + '</span></div>';
        if (data.created_at) html += '<div class="kv"><span>Last Screened</span><span>' + Utils.timeAgo(data.created_at) + '</span></div>';
        html += '<div class="kv"><span>Flags</span><span>' + Utils.formatNumber(flags.length) + '</span></div>';
        if (flags.length) {
            html += '<div style="margin-top:10px"><div class="sec-title">Security Flags</div>';
            html += '<table class="tbl tbl-sm"><thead><tr><th>Type</th><th>Details</th><th>Severity</th></tr></thead><tbody>';
            flags.forEach(function (f) {
                html += '<tr><td>' + Utils.escapeHtml(f.type || f.flag_type || '-') + '</td><td>' + Utils.escapeHtml(f.details || f.description || f.detail || '-') + '</td><td>' + Utils.severityBadge(f.severity || 'info') + '</td></tr>';
            });
            html += '</tbody></table></div>';
        }
        var altMatches = data.alt_matches || [];
        if (altMatches.length) {
            html += '<div style="margin-top:10px"><div class="sec-title" style="color:var(--danger)">&#9888; Alt Accounts Detected (' + altMatches.length + ')</div>';
            html += '<table class="tbl tbl-sm"><thead><tr><th>Steam</th><th>Link Type</th><th>Player Name</th></tr></thead><tbody>';
            altMatches.forEach(function(a) {
                html += '<tr><td class="cell-mono">' + Utils.escapeHtml(a.steam || a.identifier || '-') + '</td><td>' + Utils.escapeHtml(a.link_type || a.type || '-') + '</td><td>' + Utils.escapeHtml(a.player_name || a.name || '-') + '</td></tr>';
            });
            html += '</tbody></table></div>';
        }
        document.getElementById('action-modal-title').textContent = 'Player Screening';
        document.getElementById('action-modal-body').innerHTML = html;
        document.getElementById('action-modal-confirm').classList.add('hidden');
        document.getElementById('action-modal').classList.remove('hidden');
        state.pendingAction = null;
    }
function adminPlayerAction(action, serverId) {
        if (action === 'spectate') {
            closeApp();
            setTimeout(function () {
                Utils.nuiCallback('adminAction', { action: 'spectate', targetId: serverId });
            }, 200);
            return;
        }
        Utils.nuiCallback('adminAction', { action: action, targetId: serverId });
    }

    function kickPlayerPrompt(serverId) {
        confirmActionWithInput('Kick Player', 'Enter a reason for kicking:', 'Reason', function (reason) {
            Utils.nuiCallback('adminAction', { action: 'kick', targetId: serverId, data: { reason: reason || 'No reason' } });
            setTimeout(function () { refreshCurrentPage(); }, 800);
        });
    }

    function banPlayerPrompt(steamId, name) {
        document.getElementById('action-modal-title').textContent = 'Ban Player';
        document.getElementById('action-modal-body').innerHTML =
            '<p style="font-size:13px;color:var(--text);margin-bottom:8px">Ban ' + Utils.escapeHtml(name) + '</p>' +
            '<div class="fg"><label>Reason</label><input type="text" id="ban-reason-input" class="inp" placeholder="Reason"></div>' +
            '<div class="fg"><label>Duration (0 = permanent)</label><input type="number" id="ban-duration-input" class="inp" value="0" min="0"></div>' +
            '<div class="fg"><label>Duration Unit</label><select id="ban-unit-input" class="sel"><option value="hours">Hours</option><option value="days">Days</option><option value="permanent">Permanent</option></select></div>';
        document.getElementById('action-modal-confirm').classList.remove('hidden');
        state.pendingAction = function () {
            var reason = val('ban-reason-input') || 'No reason';
            var duration = parseInt(val('ban-duration-input')) || 0;
            var unit = val('ban-unit-input');
            var durationStr = unit === 'permanent' ? '0' : (unit === 'days' ? String(duration * 24) : String(duration));
            Utils.nuiCallback('banBySteam', { steam: steamId, reason: reason, duration: durationStr });
            document.getElementById('player-detail-modal').classList.add('hidden');
            setTimeout(function () { refreshCurrentPage(); }, 800);
        };
        document.getElementById('action-modal').classList.remove('hidden');
    }

    function banOnlinePlayerPrompt(serverId, steamId, name) {
        document.getElementById('action-modal-title').textContent = 'Ban Player';
        document.getElementById('action-modal-body').innerHTML =
            '<p style="font-size:13px;color:var(--text);margin-bottom:8px">Ban ' + Utils.escapeHtml(name) + '</p>' +
            '<div class="fg"><label>Reason</label><input type="text" id="ban-reason-input" class="inp" placeholder="Reason"></div>' +
            '<div class="fg"><label>Duration (0 = permanent)</label><input type="number" id="ban-duration-input" class="inp" value="0" min="0"></div>' +
            '<div class="fg"><label>Duration Unit</label><select id="ban-unit-input" class="sel"><option value="hours">Hours</option><option value="days">Days</option><option value="permanent">Permanent</option></select></div>';
        document.getElementById('action-modal-confirm').classList.remove('hidden');
        state.pendingAction = function () {
            var reason = val('ban-reason-input') || 'No reason';
            var duration = parseInt(val('ban-duration-input')) || 0;
            var unit = val('ban-unit-input');
            var durationStr = unit === 'permanent' ? '0' : (unit === 'days' ? String(duration * 24) : String(duration));
            Utils.nuiCallback('adminAction', {
                action: 'ban',
                targetId: serverId,
                data: { reason: reason, duration: durationStr, steam: steamId }
            });
            document.getElementById('player-detail-modal').classList.add('hidden');
            setTimeout(function () { refreshCurrentPage(); }, 800);
        };
        document.getElementById('action-modal').classList.remove('hidden');
    }

    function warnPlayerPrompt(serverId) {
        confirmActionWithInput('Warn Player', 'Enter a warning message:', 'Warning message', function (msg) {
            Utils.nuiCallback('adminAction', { action: 'warn', targetId: serverId, data: { reason: msg || 'Warning from admin' } });
        });
    }

    function manageCurrency(serverId, action) {
        var amount = parseInt(val('currency-amount'));
        var currencyType = val('currency-type') || 'money';
        if (!amount || amount <= 0) { Utils.showToast('Enter a valid amount', 'error'); return; }
        confirmAction((action === 'add' ? 'Add' : 'Remove') + ' ' + amount + ' ' + currencyType, 'Confirm currency change?', function () {
            Utils.nuiCallback('manageCurrency', { targetId: serverId, action: action, currencyType: currencyType, amount: amount });
            document.getElementById('currency-amount').value = '';
        });
    }

    function giveItem(serverId) {
        var itemName = val('give-item-name');
        var qty = parseInt(val('give-item-qty')) || 1;
        if (!itemName) { Utils.showToast('Enter an item name', 'error'); return; }
        confirmAction('Give Item', 'Give ' + qty + 'x ' + itemName + ' to player?', function () {
            Utils.nuiCallback('giveItem', { targetId: serverId, itemName: itemName, amount: qty });
            document.getElementById('give-item-name').value = '';
            document.getElementById('give-item-qty').value = '1';
        });
    }

    function removeItemPrompt(serverId) {
        confirmActionWithInput('Remove Item', 'Enter item name to remove:', 'Item name', function (itemName) {
            if (!itemName) return;
            Utils.nuiCallback('removeItem', { targetId: serverId, itemName: itemName, amount: 1 });
        });
    }

    function setPlayerJob(serverId) {
        var jobName = val('set-job-name');
        var jobGrade = parseInt(val('set-job-grade')) || 0;
        if (!jobName) { Utils.showToast('Enter a job name', 'error'); return; }
        confirmAction('Set Job', 'Set job to ' + jobName + ' (grade ' + jobGrade + ')?', function () {
            Utils.nuiCallback('setPlayerJob', { targetId: serverId, jobName: jobName, jobGrade: jobGrade });
            document.getElementById('set-job-name').value = '';
            document.getElementById('set-job-grade').value = '0';
        });
    }

    function viewInventory(serverId) {
        state._inventoryServerId = serverId;
        document.getElementById('action-modal-title').textContent = 'Loading Inventory...';
        document.getElementById('action-modal-body').innerHTML = '<div style="text-align:center;padding:20px;color:var(--text-dim)">Loading...</div>';
        document.getElementById('action-modal-confirm').classList.add('hidden');
        document.getElementById('action-modal').classList.remove('hidden');
        state.pendingAction = null;
        Utils.nuiCallback('getPlayerInventory', { targetId: serverId });
    }

    function invGiveItem() {
        var srvId = state._inventoryServerId;
        if (!srvId) { Utils.showToast('No player selected', 'error'); return; }
        var name = (document.getElementById('inv-give-name') || {}).value || '';
        var qty = parseInt((document.getElementById('inv-give-qty') || {}).value) || 1;
        if (!name) { Utils.showToast('Enter item name', 'error'); return; }
        confirmAction('Give Item', 'Give ' + qty + 'x ' + name + '?', function() {
            Utils.nuiCallback('giveItem', { targetId: srvId, itemName: name, amount: qty });
            Utils.showToast('Item given', 'success');
        });
    }

    function invRemoveItem() {
        var srvId = state._inventoryServerId;
        if (!srvId) { Utils.showToast('No player selected', 'error'); return; }
        var name = (document.getElementById('inv-give-name') || {}).value || '';
        var qty = parseInt((document.getElementById('inv-give-qty') || {}).value) || 1;
        if (!name) { Utils.showToast('Enter item name', 'error'); return; }
        confirmAction('Remove Item', 'Remove ' + qty + 'x ' + name + '?', function() {
            Utils.nuiCallback('removeItem', { targetId: srvId, itemName: name, amount: qty });
            Utils.showToast('Item removed', 'success');
        });
    }
function updateQueueActionFields() {
        var sel = document.getElementById('queue-action-type');
        var fields = document.getElementById('queue-action-fields');
        if (!sel || !fields) return;
        var type = sel.value;
        if (type === 'give_item') {
            fields.innerHTML =
                '<div class="fg" style="margin:0;flex:1;min-width:110px"><label>Item Name</label><input type="text" id="queue-item-name" class="inp" placeholder="item_name"></div>' +
                '<div class="fg" style="margin:0;flex:0 0 60px"><label>Qty</label><input type="number" id="queue-item-qty" class="inp" placeholder="1" min="1" value="1"></div>';
        } else if (type === 'remove_item') {
            fields.innerHTML =
                '<div class="fg" style="margin:0;flex:1;min-width:110px"><label>Item Name</label><input type="text" id="queue-item-name" class="inp" placeholder="item_name"></div>' +
                '<div class="fg" style="margin:0;flex:0 0 60px"><label>Qty</label><input type="number" id="queue-item-qty" class="inp" placeholder="1" min="1" value="1"></div>';
        } else if (type === 'warn') {
            fields.innerHTML =
                '<div class="fg" style="margin:0;flex:1;min-width:160px"><label>Reason</label><input type="text" id="queue-warn-reason" class="inp" placeholder="Reason for warning"></div>' +
                '<div class="fg" style="margin:0;flex:0 0 100px"><label>Severity</label><select id="queue-warn-sev" class="sel"><option value="low">Low</option><option value="medium" selected>Medium</option><option value="high">High</option></select></div>';
        } else if (type === 'ban') {
            fields.innerHTML =
                '<div class="fg" style="margin:0;flex:1;min-width:160px"><label>Reason</label><input type="text" id="queue-ban-reason" class="inp" placeholder="Reason for ban"></div>' +
                '<div class="fg" style="margin:0;flex:0 0 120px"><label>Duration (days, 0=perm)</label><input type="number" id="queue-ban-duration" class="inp" placeholder="0" min="0" value="0"></div>';
        } else if (type === 'add_note') {
            fields.innerHTML =
                '<div class="fg" style="margin:0;flex:1;min-width:200px"><label>Note Text</label><input type="text" id="queue-note-text" class="inp" placeholder="Add a note about this player"></div>';
        }
        // Re-wire item search for item inputs (re-created by innerHTML above)
        var qi = document.getElementById('queue-item-name');
        if (qi) {
            qi.setAttribute('autocomplete', 'off');
            qi.addEventListener('input', function() { itemSearchDebounce(qi); });
            qi.addEventListener('keydown', function(e) { if (e.key === 'Escape') closeItemDropdownFor(qi); });
        }
    }

    function submitQueueAction(steam, playerName) {
        var sel = document.getElementById('queue-action-type');
        if (!sel) return;
        var type = sel.value;
        var actionData = {};
        if (type === 'give_item') {
            actionData.item_name = (document.getElementById('queue-item-name') || {}).value || '';
            actionData.amount = parseInt((document.getElementById('queue-item-qty') || {}).value) || 1;
            if (!actionData.item_name) { Utils.showToast('Enter item name', 'error'); return; }
        } else if (type === 'remove_item') {
            actionData.item_name = (document.getElementById('queue-item-name') || {}).value || '';
            actionData.amount = parseInt((document.getElementById('queue-item-qty') || {}).value) || 1;
            if (!actionData.item_name) { Utils.showToast('Enter item name', 'error'); return; }
        } else if (type === 'warn') {
            actionData.reason = (document.getElementById('queue-warn-reason') || {}).value || '';
            actionData.severity = (document.getElementById('queue-warn-sev') || {}).value || 'medium';
            if (!actionData.reason) { Utils.showToast('Enter warning reason', 'error'); return; }
        } else if (type === 'ban') {
            actionData.reason = (document.getElementById('queue-ban-reason') || {}).value || '';
            actionData.duration = parseInt((document.getElementById('queue-ban-duration') || {}).value) || 0;
            if (!actionData.reason) { Utils.showToast('Enter ban reason', 'error'); return; }
        } else if (type === 'add_note') {
            actionData.note_text = (document.getElementById('queue-note-text') || {}).value || '';
            if (!actionData.note_text) { Utils.showToast('Enter note text', 'error'); return; }
        }
        Utils.nuiCallback('queueAction', { steam: steam, player_name: playerName, action_type: type, action_data: actionData })
            .then(function(r) {
                if (r && r.ok) {
                    Utils.showToast('Action queued — will run when player joins', 'success');
                    Utils.nuiCallback('getPendingActions', { steam: steam }).catch(function(){});
                }
            }).catch(function() { Utils.showToast('Failed to queue action', 'error'); });
    }

    function renderPendingActionsList(rows) {
        var el = document.getElementById('pending-actions-list');
        if (!el) return;
        var pending = (rows || []).filter(function(r){ return r.status === 'pending'; });
        if (!pending.length) {
            el.innerHTML = '<div style="color:var(--text-dim);font-size:11px">No pending actions queued.</div>';
            return;
        }
        var labels = { give_item: 'Give Item', remove_item: 'Remove Item', warn: 'Warning', ban: 'Ban', add_note: 'Note', kick: 'Kick' };
        el.innerHTML = '<div style="font-size:11px;color:var(--text-dim);margin-bottom:4px">Queued actions (' + pending.length + '):</div>' +
            pending.map(function(r) {
                var data = {};
                try { data = JSON.parse(r.action_data || '{}'); } catch(e) {}
                var detail = '';
                if (r.action_type === 'give_item' || r.action_type === 'remove_item') detail = (data.amount || 1) + 'x ' + (data.item_name || data.item || '');
                else if (r.action_type === 'warn') detail = data.reason;
                else if (r.action_type === 'ban') detail = data.reason + (data.duration ? ' (' + data.duration + 'd)' : ' (perm)');
                else if (r.action_type === 'add_note') detail = data.note_text;
                else if (r.action_type === 'kick') detail = data.reason;
                return '<div style="display:flex;align-items:center;gap:6px;padding:4px 0;border-bottom:1px solid var(--border)">' +
                    '<span class="badge badge-accent" style="font-size:10px">' + Utils.escapeHtml(labels[r.action_type] || r.action_type) + '</span>' +
                    '<span style="flex:1;font-size:11px;color:var(--text)">' + Utils.escapeHtml(detail || '') + '</span>' +
                    '<span style="font-size:10px;color:var(--text-dim)">' + Utils.escapeHtml(r.queued_by_name || '') + '</span>' +
                    '<button class="btn btn-red btn-xs" onclick="App.cancelPendingAction(' + r.id + ',\'' + Utils.escapeHtml(r.steam || '') + '\')">✕</button>' +
                '</div>';
            }).join('');
    }

    function cancelPendingAction(id, steam) {
        Utils.nuiCallback('cancelPendingAction', { id: id })
            .then(function(r) {
                if (r && r.ok) {
                    Utils.showToast('Action cancelled', 'success');
                    Utils.nuiCallback('getPendingActions', { steam: steam }).catch(function(){});
                }
            }).catch(function() { Utils.showToast('Failed to cancel', 'error'); });
    }

    function screenPlayer(steamId) {
        document.getElementById('action-modal-title').textContent = 'Screening Player...';
        document.getElementById('action-modal-body').innerHTML =
            '<div style="text-align:center;padding:30px 20px">' +
            '<div style="font-size:28px;margin-bottom:12px;animation:spin 1s linear infinite;display:inline-block">&#8635;</div>' +
            '<div style="color:var(--text-dim);font-size:13px">Running security checks...</div>' +
            '<div style="color:var(--text-dim);font-size:11px;margin-top:6px">Checking bans, alt accounts, VAC status, risk flags</div>' +
            '</div>';
        document.getElementById('action-modal-confirm').classList.add('hidden');
        document.getElementById('action-modal').classList.remove('hidden');
        state.pendingAction = null;
        Utils.nuiCallback('getPlayerScreening', { steam: steamId });
    }

    function unbanPlayer(steamId) {
        confirmAction('Unban Player', 'Are you sure you want to unban this player?', function () {
            Utils.nuiCallback('unbanBySteam', { steam: steamId });
            setTimeout(function () { Utils.nuiCallback('getBanList', { page: state.banPage }); }, 800);
        });
    }

    function resolveAlert(id) {
        Utils.nuiCallback('acknowledgeAlert', { id: id });
        Utils.showToast('Alert resolved', 'success');
        setTimeout(function () {
            Utils.nuiCallback('getAlerts', {});
            Utils.nuiCallback('getDashboardData', {});
        }, 500);
    }

    function resolveDetection(id) {
        Utils.nuiCallback('resolveDetection', { id: id });
        Utils.showToast('Detection resolved', 'success');
        setTimeout(function () {
            Utils.nuiCallback('getDetections', {});
            Utils.nuiCallback('getDashboardData', {});
        }, 500);
    }

    function resourceAction(action, name) {
        confirmAction(action.charAt(0).toUpperCase() + action.slice(1) + ' Resource', 'Are you sure you want to ' + action + ' "' + name + '"?', function () {
            Utils.nuiCallback('adminAction', { action: action + '_resource', targetId: null, data: { resource: name } });
            setTimeout(function () { Utils.nuiCallback('getResourceList', {}); }, 1500);
        });
    }

    function teleportTo(id) { Utils.nuiCallback('teleportToLocation', { id: id }); }
    function deleteTeleport(id) {
        confirmAction('Delete Teleport', 'Delete this teleport location?', function () {
            Utils.nuiCallback('deleteTeleportLocation', { id: id });
        });
    }

    function setWeather(w) { Utils.nuiCallback('setWeather', { weatherId: w }); }
    function setTime(h) { Utils.nuiCallback('setTime', { hour: h }); }

    function setExactTime() {
        var h = parseInt(val('time-hour'), 10);
        var m = parseInt(val('time-minute'), 10);
        if (isNaN(h) || h < 0 || h > 23) { Utils.showToast('Hour must be 0–23', 'error'); return; }
        if (isNaN(m) || m < 0 || m > 59) m = 0;
        Utils.nuiCallback('setExactTime', { hour: h, minute: m });
        Utils.showToast('Time set to ' + Utils.padZero(h) + ':' + Utils.padZero(m), 'success');
    }

    function applyWind() {
        var speed = parseInt(document.getElementById('mgmt-wind-speed').value || 0, 10);
        var dir = parseInt(document.getElementById('mgmt-wind-dir').value || 0, 10);
        Utils.nuiCallback('setWind', { speed: speed, direction: dir });
        Utils.showToast('Wind set: ' + speed + ' km/h at ' + dir + '°', 'success');
    }

    function renderJobDistribution() {
        var el = document.getElementById('job-dist-container');
        if (!el) return;
        var data = state.jobDistribution;
        if (!data || !data.length) {
            el.innerHTML = '<div class="empty-state" style="padding:20px;text-align:center;color:var(--text-dim)">No job data available</div>';
            hidePageLoading('statistics');
            return;
        }
        var totalEl = document.getElementById('job-dist-total');
        var total = data.reduce(function (s, j) { return s + j.count; }, 0);
        if (totalEl) totalEl.textContent = total + ' characters';
        el.innerHTML = data.map(function (j) {
            var pct = Math.min(100, Math.round((j.count / data[0].count) * 100));
            return '<div class="job-dist-row">' +
                '<div class="job-dist-label">' + Utils.escapeHtml(j.job || 'Unknown') + '</div>' +
                '<div class="job-dist-bar-wrap"><div class="job-dist-bar" style="width:' + pct + '%"></div></div>' +
                '<div class="job-dist-count">' + j.count + ' (' + (parseFloat(j.pct) || 0).toFixed(1) + '%)</div>' +
            '</div>';
        }).join('');
        hidePageLoading('statistics');
    }

    function editTeleport(id) {
        var all = state.teleportLocations || [];
        var tp = null;
        for (var i = 0; i < all.length; i++) { if (String(all[i].id) === String(id)) { tp = all[i]; break; } }
        if (!tp) { Utils.showToast('Teleport not found', 'error'); return; }
        document.getElementById('tp-edit-id').value = id;
        document.getElementById('tp-edit-name').value = tp.name || '';
        document.getElementById('tp-edit-category').value = tp.category || '';
        document.getElementById('tp-edit-x').value = tp.x || 0;
        document.getElementById('tp-edit-y').value = tp.y || 0;
        document.getElementById('tp-edit-z').value = tp.z || 0;
        document.getElementById('tp-edit-modal').classList.remove('hidden');
    }

    function saveTeleportEdit() {
        var id = val('tp-edit-id');
        var name = val('tp-edit-name').trim();
        var category = val('tp-edit-category').trim() || 'Custom';
        var x = parseFloat(val('tp-edit-x'));
        var y = parseFloat(val('tp-edit-y'));
        var z = parseFloat(val('tp-edit-z'));
        if (!id || !name) { Utils.showToast('Name is required', 'error'); return; }
        Utils.nuiCallback('updateTeleportLocation', { id: id, name: name, category: category, x: x, y: y, z: z });
        document.getElementById('tp-edit-modal').classList.add('hidden');
        Utils.showToast('Teleport updated', 'success');
    }

    

    function handleAppeal(id, decision) {
        var label = decision === 'accept' ? 'Accept Appeal' : 'Deny Appeal';
        confirmAction(label, 'Are you sure?', function () {
            Utils.nuiCallback('handleAppeal', { banId: id, decision: decision });
            setTimeout(function () {
                Utils.nuiCallback('getAppeals', {});
                Utils.nuiCallback('getBanList', { page: state.banPage });
            }, 800);
        });
    }

    function claimReport(id) {
        Utils.nuiCallback('claimReport', { id: id });
        setTimeout(function () { Utils.nuiCallback('getReportDetail', { id: id }); }, 500);
    }
    function resolveReport(id) {
        Utils.nuiCallback('resolveReport', { id: id });
        setTimeout(function () {
            Utils.nuiCallback('getReports', { filters: getReportFilters() });
            document.getElementById('report-detail-modal').classList.add('hidden');
        }, 500);
    }
    function reopenReport(id) {
        Utils.nuiCallback('reopenReport', { id: id });
        setTimeout(function () { Utils.nuiCallback('getReportDetail', { id: id }); }, 500);
    }
    function replyToReport(id) {
        var text = val('report-reply-text');
        if (!text) { Utils.showToast('Enter a message', 'error'); return; }
        Utils.nuiCallback('addReportMessage', { id: id, message: text });
        var el = document.getElementById('report-reply-text');
        if (el) el.value = '';
        setTimeout(function () { Utils.nuiCallback('getReportDetail', { id: id }); }, 500);
    }
    function deleteReport(id) {
        if (!window.confirm('Delete report #' + id + ' and all its messages? This cannot be undone.')) return;
        Utils.nuiCallback('deleteReport', { id: id });
        document.getElementById('report-detail-modal').classList.add('hidden');
    }
function renderWarnings() {
        hidePageLoading('warnings');
        var data = state.warningList;
        if (!data) return;
        var tbody = document.getElementById('warnings-tbody');
        if (!tbody) return;
        var rows = (data.warnings || []).map(function (w) {
            var sevBadge = Utils.severityBadge ? Utils.severityBadge(w.severity) : Utils.escapeHtml(w.severity);
            var statusBadge = w.is_active ? '<span class="badge badge-green">Active</span>' : '<span class="badge badge-muted">Removed</span>';
            var actions = w.is_active ? '<button class="btn btn-red btn-xs" onclick="App.removeWarning(' + w.id + ')">Remove</button>' : '';
            return '<tr><td>' + w.id + '</td><td>' + Utils.escapeHtml(w.player_name || '') + '</td><td>' + Utils.escapeHtml(w.reason || '') +
                '</td><td>' + sevBadge + '</td><td>' + Utils.escapeHtml(w.warned_by_name || '') +
                '</td><td>' + Utils.formatDate(w.created_at) + '</td><td>' + statusBadge + '</td><td>' + actions + '</td></tr>';
        }).join('');
        tbody.innerHTML = rows || '<tr class="empty-row"><td colspan="8" style="text-align:center;padding:24px;color:var(--text-dim)">No warnings found</td></tr>';
        Utils.renderPagination('warning-pagination', data.total || 0, data.perPage || 25, data.page || 1, function (p) {
            state.warningPage = p;
            Utils.nuiCallback('getWarnings', { page: p, search: val('warning-search') });
        });
    }

    function removeWarning(id) {
        confirmAction('Remove Warning', 'Remove this warning?', function () {
            Utils.nuiCallback('removeWarning', { id: id });
            setTimeout(function () { Utils.nuiCallback('getWarnings', { page: state.warningPage }); }, 500);
        });
    }

    function clearWarnings(steam) {
        confirmAction('Clear All Warnings', 'Clear all warnings for this player?', function () {
            Utils.nuiCallback('clearWarnings', { steam: steam });
            setTimeout(function () { Utils.nuiCallback('getWarnings', { page: state.warningPage }); }, 500);
        });
    }
function populateBlipVisibleTo() {
        var sel = document.getElementById('blip-visible-to');
        if (!sel) return;
        var players = Utils.normalizePlayerList(state.liveMapData);
        if (!players.length) players = Utils.normalizePlayerList(state.playerList);
        var current = sel.value;
        sel.innerHTML = '<option value="">All Players</option>';
        players.forEach(function(p) {
            var opt = document.createElement('option');
            opt.value = p.steam || p.identifiers && p.identifiers[0] || '';
            var serverId = p.serverId || p.server_id || p.id;
            opt.textContent = (p.name || p.player_name || 'Unknown') + (serverId ? ' [' + serverId + ']' : '');
            sel.appendChild(opt);
        });
        if (current) sel.value = current;
    }

    function startBlipMapPick() {
        var map = window._leafletMap;
        if (!map) { Utils.showToast('Map not ready', 'error'); return; }
        document.getElementById('blip-modal').classList.add('hidden');
        map.getContainer().style.cursor = 'crosshair';
        Utils.showToast('Click on the map to place blip', 'info');
        function onMapClick(e) {
            map.off('click', onMapClick);
            map.getContainer().style.cursor = '';
            var lng = e.latlng.lng;
            var lat = e.latlng.lat;
            var gameX = (lng - 111.29) / 0.01552;
            var gameY = (lat + 63.6) / 0.01552;
            var xEl = document.getElementById('blip-x');
            var yEl = document.getElementById('blip-y');
            if (xEl) xEl.value = gameX.toFixed(1);
            if (yEl) yEl.value = gameY.toFixed(1);
            document.getElementById('blip-modal').classList.remove('hidden');
        }
        map.on('click', onMapClick);
    }

    function renderBlips() {
        hidePageLoading('blips');
        var data = state.blipList;
        if (!data) return;
        var tbody = document.getElementById('blips-tbody');
        if (!tbody) return;
        var rows = (Array.isArray(data) ? data : []).map(function (b) {
            var activeBadge = b.is_active ? '<span class="badge badge-green">Yes</span>' : '<span class="badge badge-muted">No</span>';
            var visibleTo = b.visible_to ? '<span style="font-size:11px">' + Utils.escapeHtml(b.visible_to) + '</span>' : '<span style="color:#888">All</span>';
            return '<tr><td>' + b.id + '</td><td>' + Utils.escapeHtml(b.name || '') + '</td><td>' + (b.blip_hash || 0) +
                '</td><td>' + (b.x ? Number(b.x).toFixed(1) : '0') + '</td><td>' + (b.y ? Number(b.y).toFixed(1) : '0') +
                '</td><td>' + (b.z ? Number(b.z).toFixed(1) : '0') + '</td><td>' + (b.scale || 0.2) +
                '</td><td>' + visibleTo + '</td><td>' + activeBadge + '</td><td>' +
                '<button class="btn btn-accent btn-xs" onclick="App.editBlip(' + b.id + ')">Edit</button> ' +
                '<button class="btn btn-red btn-xs" onclick="App.deleteBlip(' + b.id + ')">Delete</button></td></tr>';
        }).join('');
        tbody.innerHTML = rows || '<tr><td colspan="10" style="text-align:center;color:#888;">No blips found</td></tr>';
        populateBlipVisibleTo();
    }

    function editBlip(id) {
        var data = state.blipList;
        var blip = (Array.isArray(data) ? data : []).find(function (b) { return b.id === id; });
        if (!blip) return;
        state.editingBlipId = id;
        document.getElementById('blip-modal-title').textContent = 'Edit Blip #' + id;
        document.getElementById('blip-name').value = blip.name || '';
        document.getElementById('blip-hash').value = blip.blip_hash || '';
        document.getElementById('blip-x').value = blip.x || '';
        document.getElementById('blip-y').value = blip.y || '';
        document.getElementById('blip-z').value = blip.z || '';
        document.getElementById('blip-scale').value = blip.scale || 0.2;
        document.getElementById('blip-color').value = blip.color || 0;
        document.getElementById('blip-preset').value = blip.blip_hash || '';
        selectBlipPreset(String(blip.blip_hash || ''));
        renderBlipColorSwatches();
        var vtSel = document.getElementById('blip-visible-to');
        if (vtSel) { populateBlipVisibleTo(); vtSel.value = blip.visible_to || ''; }
        document.getElementById('blip-modal').classList.remove('hidden');
    }

    function deleteBlip(id) {
        confirmAction('Delete Blip', 'Are you sure you want to delete this blip?', function () {
            // Optimistic removal — clear from UI immediately so the map updates without waiting for server
            var keyStr = String(id);
            if (mapState.blipMarkers[keyStr]) {
                if (mapState.leafletMap) mapState.leafletMap.removeLayer(mapState.blipMarkers[keyStr]);
                delete mapState.blipMarkers[keyStr];
            }
            if (state.blipList) {
                state.blipList = state.blipList.filter(function (b) { return String(b.id) !== keyStr; });
            }
            if (document.getElementById('blips-tbody')) renderBlips();
            pendingBlipDeletions[keyStr] = Date.now();
            Utils.nuiCallback('deleteBlip', { id: id });
            // Server pushes mguard:ReceiveBlips after delete — no polling needed
        });
    }
function renderAdmins() {
        hidePageLoading('admins');
        var data = state.adminList;
        if (!data) return;
        var container = document.getElementById('admin-cards');
        if (!container) return;
        var cards = (Array.isArray(data) ? data : []).map(function (a) {
            var statusDot = a.is_online ? '<span class="status-dot status-online"></span>' : '<span class="status-dot status-offline"></span>';
            var sourceBadge = a.source === 'database' ? '<span class="badge badge-accent">DB</span>' : '<span class="badge badge-muted">Config</span>';
            return '<div class="admin-card">' +
                '<div class="admin-card-head">' + statusDot + ' <strong>' + Utils.escapeHtml(a.player_name || 'Unknown') + '</strong> ' + sourceBadge + '</div>' +
                '<div class="admin-card-body">' +
                '<div class="kv"><span>Role</span><span>' + Utils.escapeHtml(a.admin_group || '-') + '</span></div>' +
                '<div class="kv"><span>Steam</span><span style="font-size:11px;word-break:break-all;">' + Utils.escapeHtml(a.steam || '') + '</span></div>' +
                (a.server_id ? '<div class="kv"><span>Server ID</span><span>' + a.server_id + '</span></div>' : '') +
                '</div>' +
                '<div class="admin-card-foot">' +
                '<button class="btn btn-accent btn-xs" onclick="App.editAdminRole(\'' + Utils.escapeHtml(a.steam || '') + '\', \'' + Utils.escapeHtml(a.player_name || '') + '\', \'' + Utils.escapeHtml(a.admin_group || '') + '\')">Edit Role</button> ' +
                (a.source === 'database' ? '<button class="btn btn-red btn-xs" onclick="App.removeAdmin(\'' + Utils.escapeHtml(a.steam || '') + '\')">Remove</button>' : '') +
                '</div></div>';
        }).join('');
        container.innerHTML = cards || '<p style="color:#888;text-align:center;padding:20px;">No admins found</p>';
    }

    function editAdminRole(steam, name, currentRole) {
        document.getElementById('admin-role-player').value = name;
        document.getElementById('admin-role-steam').value = steam;
        // Filter roles: only show roles the current user can assign (strictly below their rank)
        var roleRanks = { helper: 1, mod: 2, moderator: 2, admin: 3, superadmin: 4, owner: 5 };
        var myGroup = state.adminGroup || 'admin';
        var myRank = roleRanks[myGroup] || 3;
        var allRoles = [
            { value: 'helper', label: 'Helper', rank: 1 },
            { value: 'moderator', label: 'Moderator', rank: 2 },
            { value: 'admin', label: 'Admin', rank: 3 },
            { value: 'superadmin', label: 'Super Admin', rank: 4 },
            { value: 'owner', label: 'Owner', rank: 5 },
        ];
        var sel = document.getElementById('admin-role-select');
        sel.innerHTML = allRoles
            .filter(function(r) { return r.rank < myRank; })
            .map(function(r) { return '<option value="' + r.value + '"' + (r.value === currentRole ? ' selected' : '') + '>' + r.label + '</option>'; })
            .join('');
        if (!sel.value) sel.value = currentRole || '';
        document.getElementById('admin-role-modal').classList.remove('hidden');
    }

    function removeAdmin(steam) {
        confirmAction('Remove Admin', 'Remove this admin from the database?', function () {
            Utils.nuiCallback('removeAdmin', { steam: steam });
            setTimeout(function () { Utils.nuiCallback('getAdminList', {}); }, 800);
        });
    }

    function renderWhitelist() {
        hidePageLoading('whitelist');
        var d = state.whitelistList;
        if (!d) return;
        var list = d.entries || d.whitelist || (Array.isArray(d) ? d : []);
        var tbody = document.getElementById('wl-tbody');
        if (!tbody) return;
        if (!list.length) {
            tbody.innerHTML = '<tr class="empty-row"><td colspan="7">No whitelist entries</td></tr>';
            return;
        }
        tbody.innerHTML = list.map(function(w) {
            return '<tr>' +
                '<td style="font-size:11px;font-family:var(--font-mono)">' + Utils.escapeHtml(w.steam || '') + '</td>' +
                '<td>' + Utils.escapeHtml(w.player_name || '-') + '</td>' +
                '<td style="font-size:11px">' + Utils.escapeHtml(w.discord || '-') + '</td>' +
                '<td>' + Utils.escapeHtml(w.reason || '-') + '</td>' +
                '<td>' + Utils.escapeHtml(w.added_by_name || w.added_by || '-') + '</td>' +
                '<td>' + Utils.timeAgo(w.created_at) + '</td>' +
                '<td style="white-space:nowrap">' +
                    '<button class="btn btn-muted btn-xs" onclick="App.editWhitelist(' + (w.id||0) + ',\'' + Utils.escapeHtml(w.steam||'') + '\',\'' + Utils.escapeHtml(w.player_name||'') + '\',\'' + Utils.escapeHtml(w.discord||'') + '\',\'' + Utils.escapeHtml(w.reason||'') + '\')">Edit</button> ' +
                    '<button class="btn btn-red btn-xs" onclick="App.removeWhitelist(' + (w.id||0) + ')">Remove</button>' +
                '</td>' +
            '</tr>';
        }).join('');
        var pag = document.getElementById('wl-pagination');
        if (pag && d.total && d.total > 0) {
            var page = d.page || 1, perPage = d.per_page || 25, total = d.total || 0;
            var totalPages = Math.ceil(total / perPage);
            if (totalPages > 1) {
                pag.innerHTML = Utils.buildPagination(page, totalPages, function(p) {
                    state.whitelistPage = p;
                    Utils.nuiCallback('getWhitelist', { page: p });
                });
            } else {
                pag.innerHTML = '';
            }
        }
    }

    function editWhitelist(id, steam, name, discord, reason) {
        document.getElementById('wl-modal-title').textContent = 'Edit Whitelist Entry';
        document.getElementById('wl-edit-id').value = id;
        document.getElementById('wl-steam').value = steam;
        document.getElementById('wl-name').value = name;
        document.getElementById('wl-discord').value = discord;
        document.getElementById('wl-reason').value = reason;
        document.getElementById('wl-add-modal').classList.remove('hidden');
    }

    function removeWhitelist(id) {
        confirmAction('Remove from Whitelist', 'Remove this entry from the whitelist?', function() {
            Utils.nuiCallback('whitelistRemove', { id: id });
            setTimeout(function() { Utils.nuiCallback('getWhitelist', { page: state.whitelistPage || 1 }); }, 800);
        });
    }
    function renderLiveMap() {
        var players = state.liveMapData;
        if (!players) return;
        hidePageLoading('livemap');
        var countEl = document.getElementById('map-player-count');
        if (countEl) countEl.textContent = (players.length || 0) + ' player' + (players.length !== 1 ? 's' : '');
        updateLeafletMarkers(players);
        updateLeafletBlips(state.blipList || []);
        renderBlips();
        renderLiveMapSidebar(players);
        renderLiveMapTable(players);
    }
var mapState = {
        leafletMap: null,
        playerMarkers: {}, /* serverId -> L.marker */
        blipMarkers: {}, /* blipId -> L.circleMarker */
        initialized: false
    };
// Tracks blip IDs that were just deleted — prevents race-condition re-adds during the 5s auto-refresh window
var pendingBlipDeletions = {};
function gameToLatLng(gameX, gameY) {
        var lat = 0.01552 * gameY + -63.6;
        var lng = 0.01552 * gameX + 111.29;
        return [lat, lng];
    }

    function initLeafletMap() {
        if (mapState.leafletMap) {
setTimeout(function () { mapState.leafletMap.invalidateSize(); }, 100);
            return;
        }
        var container = document.getElementById('livemap-leaflet');
        if (!container) return;

        var mapBounds = L.latLngBounds(L.latLng(-144, 0), L.latLng(0, 176));

        mapState.leafletMap = L.map(container, {
            preferCanvas: true,
            minZoom: 2,
            maxZoom: 7,
            zoomControl: false,
            crs: L.CRS.Simple,
            maxBounds: mapBounds,
            maxBoundsViscosity: 0.8,
            attributionControl: false
        }).setView([-70, 111.75], 3);
        window._leafletMap = mapState.leafletMap;
var gameLayer = L.tileLayer('https://s.rsg.sc/sc/images/games/RDR2/map/game/{z}/{x}/{y}.jpg', {
            noWrap: true,
            bounds: mapBounds,
            maxNativeZoom: 7,
            tileSize: 256,
            keepBuffer: 6
        });
var darkLayer = L.tileLayer('https://map-tiles.b-cdn.net/assets/rdr3/webp/darkmode/{z}/{x}_{y}.webp', {
            noWrap: true,
            bounds: mapBounds,
            maxNativeZoom: 7,
            tileSize: 256,
            keepBuffer: 6
        });
var detailedLayer = L.tileLayer('https://map-tiles.b-cdn.net/assets/rdr3/webp/detailed/{z}/{x}_{y}.webp', {
            noWrap: true,
            bounds: mapBounds,
            maxNativeZoom: 7,
            tileSize: 256,
            keepBuffer: 6
        });

        gameLayer.addTo(mapState.leafletMap);
L.control.layers({
            'Satellite': gameLayer,
            'Detailed': detailedLayer,
            'Dark': darkLayer
        }, null, { position: 'topright', collapsed: true }).addTo(mapState.leafletMap);
L.control.zoom({ position: 'topright' }).addTo(mapState.leafletMap);
var searchInput = document.getElementById('map-search-player');
        if (searchInput) {
            searchInput.addEventListener('input', Utils.debounce(function () {
                updateLeafletMarkers(state.liveMapData || []);
                renderLiveMapSidebar(state.liveMapData || []);
            }, 150));
        }
        ['map-show-names', 'map-show-admins'].forEach(function (id) {
            var el = document.getElementById(id);
            if (el) el.addEventListener('change', function () {
                updateLeafletMarkers(state.liveMapData || []);
            });
        });
mapState.leafletMap.on('contextmenu', function(e) {
            var gameX = (e.latlng.lng - 111.29) / 0.01552;
            var gameY = (e.latlng.lat + 63.6) / 0.01552;
            state.editingBlipId = null;
            var titleEl = document.getElementById('blip-modal-title');
            var nameEl  = document.getElementById('blip-name');
            var hashEl  = document.getElementById('blip-hash');
            var presetEl= document.getElementById('blip-preset');
            var xEl     = document.getElementById('blip-x');
            var yEl     = document.getElementById('blip-y');
            var zEl     = document.getElementById('blip-z');
            var scaleEl = document.getElementById('blip-scale');
            var colorEl = document.getElementById('blip-color');
            if (titleEl)  titleEl.textContent = 'Create Blip';
            if (nameEl)   nameEl.value  = '';
            if (hashEl)   hashEl.value  = 'blip_code_waypoint';
            if (presetEl) presetEl.value = 'blip_code_waypoint';
            if (xEl)      xEl.value  = gameX.toFixed(1);
            if (yEl)      yEl.value  = gameY.toFixed(1);
            if (zEl)      zEl.value  = '0';
            if (scaleEl)  scaleEl.value = '0.2';
            if (colorEl)  colorEl.value = '0';
            populateBlipVisibleTo();
            populateBlipPresets();
            renderBlipColorSwatches();
            selectBlipPreset('blip_code_waypoint');
            var modal = document.getElementById('blip-modal');
            if (modal) modal.classList.remove('hidden');
        });
var mapHint = document.getElementById('livemap-ctx-hint');
        if (!mapHint) {
            mapHint = document.createElement('div');
            mapHint.id = 'livemap-ctx-hint';
            mapHint.style.cssText = 'position:absolute;bottom:8px;left:50%;transform:translateX(-50%);background:rgba(0,0,0,0.6);color:var(--text-dim);font-size:11px;padding:3px 10px;border-radius:4px;pointer-events:none;z-index:1000;';
            mapHint.textContent = 'Right-click map to create a blip';
            var mapContainer = document.getElementById('livemap-leaflet');
            if (mapContainer) mapContainer.appendChild(mapHint);
        }
    }

    function createPlayerIcon(player, isAdmin, isHighlighted) {
        var color = isAdmin ? '#8c2020' : '#8a9098';
        var size = isHighlighted ? 16 : 12;
        var border = isHighlighted ? 3 : 2;
        var glow = isAdmin ? 'outline:2px solid rgba(140,32,32,.5)' : 'outline:2px solid rgba(138,144,152,.3)';
        return L.divIcon({
            className: 'mguard-player-marker',
            html: '<div style="width:' + size + 'px;height:' + size + 'px;background:' + color + ';border-radius:50%;border:' + border + 'px solid rgba(255,255,255,.8);' + glow + '"></div>',
            iconSize: [size + border * 2, size + border * 2],
            iconAnchor: [(size + border * 2) / 2, (size + border * 2) / 2]
        });
    }

    function updateLeafletMarkers(players) {
        if (!mapState.leafletMap) return;
        var showNames = document.getElementById('map-show-names');
        showNames = showNames ? showNames.checked : true;
        var highlightAdmins = document.getElementById('map-show-admins');
        highlightAdmins = highlightAdmins ? highlightAdmins.checked : false;
        var searchVal = ((document.getElementById('map-search-player') || {}).value || '').toLowerCase();
var activeSids = {};

        (players || []).forEach(function (p) {
            if (searchVal && !(p.name || '').toLowerCase().includes(searchVal) && !(p.charName || '').toLowerCase().includes(searchVal)) return;

            var isAdmin = p.isAdmin || p.group === 'admin' || p.group === 'superadmin' || p.group === 'owner';
            var highlight = highlightAdmins && isAdmin;
            var latlng = gameToLatLng(p.x || 0, p.y || 0);
            var sid = p.serverId;
            activeSids[sid] = true;
var detailHtml = '<div style="min-width:140px">' +
                '<b>' + Utils.escapeHtml(p.name || 'Unknown') + '</b> <span style="opacity:.6">[' + sid + ']</span>';
            if (p.charName) detailHtml += '<br>' + Utils.escapeHtml(p.charName);
            detailHtml += '<br>Job: ' + Utils.escapeHtml(p.job || '-');
            detailHtml += '<br><span style="font-family:monospace;font-size:10px">' + (p.x||0).toFixed(1) + ', ' + (p.y||0).toFixed(1) + ', ' + (p.z||0).toFixed(1) + '</span>';
            if (isAdmin) detailHtml += '<br><span style="color:#8c2020;font-weight:600">ADMIN</span>';
            detailHtml += '<br><button type="button" style="font-size:10px;color:var(--text-dim);cursor:pointer;background:none;border:0;padding:0;margin:0" class="mguard-detail-link" data-steam="' + Utils.escapeHtml(p.steam || '') + '" data-server-id="' + Utils.escapeHtml(String(p.serverId || sid || '')) + '" onclick="event.stopPropagation();App.openPlayerDetail(this.dataset.steam, this.dataset.serverId);">View Details &rarr;</button>';
            detailHtml += '</div>';

            if (mapState.playerMarkers[sid]) {
mapState.playerMarkers[sid].setLatLng(latlng);
var m = mapState.playerMarkers[sid];
                if (m._mguardAdmin !== isAdmin || m._mguardHighlight !== highlight) {
                    m.setIcon(createPlayerIcon(p, isAdmin, highlight));
                    m._mguardAdmin = isAdmin;
                    m._mguardHighlight = highlight;
                }
            } else {
var marker = L.marker(latlng, {
                    icon: createPlayerIcon(p, isAdmin, highlight),
                    zIndexOffset: isAdmin ? 1000 : 0,
                    interactive: true
                });
                marker._mguardAdmin = isAdmin;
                marker._mguardHighlight = highlight;
                marker.addTo(mapState.leafletMap);
                mapState.playerMarkers[sid] = marker;
            }
mapState.playerMarkers[sid].unbindTooltip();

            if (showNames) {
mapState.playerMarkers[sid].bindTooltip(Utils.escapeHtml(p.name || ('ID:' + sid)), {
                    permanent: true,
                    direction: 'top',
                    offset: [0, -12],
                    className: 'mguard-name-label'
                });
            } else {
mapState.playerMarkers[sid].bindTooltip(detailHtml, {
                    direction: 'top',
                    offset: [0, -10],
                    className: 'mguard-map-tooltip'
                });
            }
            mapState.playerMarkers[sid].off('click');
            mapState.playerMarkers[sid].on('click', (function (playerData) {
                return function () {
                    openPlayerDetail(playerData.steam, playerData.serverId || playerData.server_id || playerData.id);
                };
            })(p));
mapState.playerMarkers[sid]._mguardDetail = detailHtml;
        });
Object.keys(mapState.playerMarkers).forEach(function (sid) {
            if (!activeSids[sid]) {
                mapState.leafletMap.removeLayer(mapState.playerMarkers[sid]);
                delete mapState.playerMarkers[sid];
            }
        });
    }

    function focusMapPlayer(serverId) {
        var players = state.liveMapData || [];
        var p = null;
        for (var i = 0; i < players.length; i++) {
            if (players[i].serverId == serverId) { p = players[i]; break; }
        }
        if (!p || !mapState.leafletMap) return;
        var latlng = gameToLatLng(p.x || 0, p.y || 0);
        mapState.leafletMap.setView(latlng, 5, { animate: true });
var marker = mapState.playerMarkers[serverId];
        if (marker) {
            var html = marker._mguardDetail || Utils.escapeHtml(p.name || 'Unknown');
            marker.unbindPopup();
            marker.bindPopup(html, { className: 'mguard-map-popup', maxWidth: 220, closeButton: true });
            marker.openPopup();
        }
    }

    function getBlipColorMeta(colorId) {
        var id = parseInt(colorId || 0, 10);
        for (var i = 0; i < BLIP_COLORS.length; i++) {
            if (BLIP_COLORS[i].id === id) return BLIP_COLORS[i];
        }
        return BLIP_COLORS[0];
    }

    function getBlipPresetMeta(hash) {
        var key = String(hash || '');
        for (var i = 0; i < BLIP_PRESETS.length; i++) {
            if (String(BLIP_PRESETS[i].hash) === key) return BLIP_PRESETS[i];
        }
        return null;
    }

    function getBlipMarkerIconClass(blip, presetMeta) {
        var name = ((presetMeta && presetMeta.name) || blip.name || '').toLowerCase();
        if (name.includes('player')) return 'fa-solid fa-user';
        if (name.includes('enemy')) return 'fa-solid fa-skull-crossbones';
        if (name.includes('skull')) return 'fa-solid fa-skull';
        if (name.includes('star')) return 'fa-solid fa-star';
        if (name.includes('arrow')) return 'fa-solid fa-location-arrow';
        if (name.includes('circle')) return 'fa-solid fa-circle';
        if (name.includes('stable')) return 'fa-solid fa-horse';
        if (name.includes('store')) return 'fa-solid fa-store';
        return 'fa-solid fa-location-dot';
    }

    function createBlipMarkerIcon(blip, colorMeta, presetMeta) {
        return L.divIcon({
            className: 'mguard-blip-marker',
            html: '<div class="mguard-blip-marker-core" style="--blip-color:' + colorMeta.hex + '">' +
                '<i class="' + getBlipMarkerIconClass(blip, presetMeta) + '"></i>' +
                '</div>',
            iconSize: [28, 28],
            iconAnchor: [14, 14],
            popupAnchor: [0, -12]
        });
    }

    function updateLeafletBlips(blips) {
        if (!mapState.leafletMap) return;
        var active = {};
        (Array.isArray(blips) ? blips : []).forEach(function (b) {
            if (!b || String(b.is_active) === '0') return;
            var id = String(b.id || ('blip-' + (b.name || 'unnamed')));
            active[id] = true;
            var latlng = gameToLatLng(Number(b.x) || 0, Number(b.y) || 0);
            var colorMeta = getBlipColorMeta(b.color);
            var presetMeta = getBlipPresetMeta(b.blip_hash);
            var popupActions = '';
            if (b.id) {
                popupActions = '<div style="margin-top:8px;display:flex;gap:6px;justify-content:flex-end">' +
                    '<button type="button" class="btn btn-red btn-xs" onclick="App.deleteBlip(' + Number(b.id) + ')">Delete</button>' +
                    '</div>';
            }
            var popupHtml = '<div style="min-width:150px">' +
                '<b>' + Utils.escapeHtml(b.name || 'Blip') + '</b>' +
                '<br><span style="font-size:11px;color:var(--text-dim)">' + Utils.escapeHtml((presetMeta && presetMeta.name) || 'Custom Blip') + '</span>' +
                '<br><span style="font-size:11px;color:var(--text-dim)">' + (Number(b.x) || 0).toFixed(1) + ', ' + (Number(b.y) || 0).toFixed(1) + ', ' + (Number(b.z) || 0).toFixed(1) + '</span>' +
                popupActions +
                '</div>';
            var icon = createBlipMarkerIcon(b, colorMeta, presetMeta);
            if (mapState.blipMarkers[id]) {
                mapState.blipMarkers[id].setLatLng(latlng);
                mapState.blipMarkers[id].setIcon(icon);
                mapState.blipMarkers[id].bindPopup(popupHtml, { className: 'mguard-map-popup', maxWidth: 220, closeButton: true });
            } else {
                // Skip blips pending deletion (race-condition guard: server may still be committing the DELETE)
                if (pendingBlipDeletions[id] && Date.now() - pendingBlipDeletions[id] < 5000) return;
                mapState.blipMarkers[id] = L.marker(latlng, {
                    icon: icon,
                    keyboard: false
                }).addTo(mapState.leafletMap);
                mapState.blipMarkers[id].bindPopup(popupHtml, { className: 'mguard-map-popup', maxWidth: 220, closeButton: true });
            }
        });
        Object.keys(mapState.blipMarkers).forEach(function (id) {
            if (!active[id]) {
                mapState.leafletMap.removeLayer(mapState.blipMarkers[id]);
                delete mapState.blipMarkers[id];
            }
        });
    }

    function resetMapView() {
        if (!mapState.leafletMap) return;
        mapState.leafletMap.setView([-70, 111.75], 3, { animate: true });
    }
function renderLiveMapSidebar(players) {
        var container = document.getElementById('livemap-player-list');
        if (!container) return;
        if (!players || !players.length) {
            container.innerHTML = '<div style="padding:12px;text-align:center;color:var(--text-dim);font-size:12px;">No players online</div>';
            return;
        }
        var searchVal = ((document.getElementById('map-search-player') || {}).value || '').toLowerCase();
        var filtered = players.filter(function (p) {
            if (!searchVal) return true;
            return (p.name || '').toLowerCase().includes(searchVal) || (p.charName || '').toLowerCase().includes(searchVal);
        });
        container.innerHTML = filtered.map(function (p) {
            var isAdmin = p.isAdmin || p.group === 'admin' || p.group === 'superadmin' || p.group === 'owner';
            return '<div class="livemap-player-item" data-sid="' + p.serverId + '" onclick="App.focusMapPlayer(' + p.serverId + ')">' +
                '<div class="livemap-player-dot" style="background:' + (isAdmin ? '#8c2020' : '#8a9098') + '"></div>' +
                '<div style="flex:1;min-width:0">' +
                    '<div class="livemap-player-name">[' + p.serverId + '] ' + Utils.escapeHtml(p.name || 'Unknown') +
                    (isAdmin ? ' <span class="badge badge-accent" style="font-size:9px">ADMIN</span>' : '') + '</div>' +
                    '<div class="livemap-player-coords">' + (p.x||0).toFixed(0) + ', ' + (p.y||0).toFixed(0) + ', ' + (p.z||0).toFixed(0) + '</div>' +
                '</div>' +
                '<button class="btn btn-muted btn-xs" onclick="event.stopPropagation();App.openPlayerDetail(\'' + Utils.escapeHtml(p.steam || '') + '\', ' + p.serverId + ')" title="Player detail" style="flex-shrink:0"><i class="fa-solid fa-user" style="font-size:10px"></i></button>' +
            '</div>';
        }).join('');
    }

    function renderLiveMapTable(players) {
        var tbody = document.getElementById('livemap-tbody');
        if (!tbody) return;
        var rows = (players || []).map(function (p) {
            var isAdmin = p.isAdmin || p.group === 'admin' || p.group === 'superadmin' || p.group === 'owner';
            return '<tr><td>' + p.serverId + '</td><td>' + Utils.escapeHtml(p.name || '') +
                (isAdmin ? ' <span class="badge badge-accent" style="font-size:9px">ADMIN</span>' : '') +
                '</td><td>' + Utils.escapeHtml(p.charName || '') +
                '</td><td class="cell-mono">' + (p.x ? p.x.toFixed(1) : '0') +
                '</td><td class="cell-mono">' + (p.y ? p.y.toFixed(1) : '0') +
                '</td><td class="cell-mono">' + (p.z ? p.z.toFixed(1) : '0') +
                '</td><td>' + Utils.escapeHtml(p.group || '') +
                '</td><td>' +
                    '<button class="btn btn-accent btn-xs" onclick="App.focusMapPlayer(' + p.serverId + ')" title="Focus on map"><i class="fa-solid fa-location-crosshairs" style="font-size:10px"></i></button> ' +
                    '<button class="btn btn-muted btn-xs" onclick="App.getPlayerCoords(' + p.serverId + ')" title="Copy coords"><i class="fa-solid fa-copy" style="font-size:10px"></i></button> ' +
                    '<button class="btn btn-muted btn-xs" onclick="App.openPlayerDetail(\'' + Utils.escapeHtml(p.steam || '') + '\', ' + p.serverId + ')" title="Player detail"><i class="fa-solid fa-user" style="font-size:10px"></i></button>' +
                '</td></tr>';
        }).join('');
        tbody.innerHTML = rows || '<tr><td colspan="8" style="text-align:center;color:var(--text-dim);">No players online</td></tr>';
    }

    function startLiveMapAutoRefresh() {
        if (state.liveMapTimer) clearInterval(state.liveMapTimer);
        state.liveMapTimer = setInterval(function () {
            if (state.currentPage !== 'livemap') {
                clearInterval(state.liveMapTimer);
                state.liveMapTimer = null;
                return;
            }
            var cb = document.getElementById('map-auto-refresh');
            if (cb && cb.checked) {
                Utils.nuiCallback('getLiveMapData', {});
            }
        }, 5000);
    }

    function getPlayerCoordsAction(serverId) {
        Utils.nuiCallback('getPlayerCoords', { targetId: serverId });
    }
function populateSpawnerTargets() {
        var sel = document.getElementById('spawner-target');
        if (!sel) return;
        sel.innerHTML = '<option value="">Select player...</option>';
        if (state.dashboardData && state.dashboardData.onlinePlayers) {
            state.dashboardData.onlinePlayers.forEach(function (p) {
                var opt = document.createElement('option');
                opt.value = p.serverId;
                opt.textContent = '[' + p.serverId + '] ' + (p.name || 'Unknown');
                sel.appendChild(opt);
            });
        }
    }

    function renderSpawnerPresets() {
        var container = document.getElementById('spawner-presets');
        if (!container) return;
        var presets = [
            { label: 'Horse (Morgan)', model: 'A_C_Horse_Morgan_Bay', type: 'vehicle' },
            { label: 'Horse (Arabian)', model: 'A_C_Horse_Arabian_White', type: 'vehicle' },
            { label: 'Wagon', model: 'wagonWork01x', type: 'vehicle' },
            { label: 'Stagecoach', model: 'stagecoach001x', type: 'vehicle' },
            { label: 'Canoe', model: 'canoe', type: 'vehicle' },
            { label: 'Random Townfolk', model: 'a_m_m_rancher_01', type: 'ped' },
            { label: 'Lawman', model: 'S_M_M_UniGenericMale_01', type: 'ped' },
            { label: 'Campfire', model: 'p_campfire02x', type: 'object' },
            { label: 'Chair', model: 'p_chair02x', type: 'object' },
            { label: 'Barrel', model: 'p_barrel02x', type: 'object' },
        ];
        container.innerHTML = presets.map(function (p) {
            return '<button class="btn btn-muted btn-sm" onclick="App.quickSpawn(\'' + p.type + '\', \'' + p.model + '\')">' + Utils.escapeHtml(p.label) + '</button>';
        }).join('');
    }

    function quickSpawn(type, model) {
        var target = val('spawner-target');
        if (!target) { Utils.showToast('Select a target player first', 'error'); return; }
        Utils.nuiCallback('spawnEntity', { entityType: type, modelHash: model, targetId: parseInt(target) });
        Utils.showToast('Spawning ' + model, 'success');
    }
var _itemSearchTimer = null;
    var _activeItemInput = null;

    function itemSearchDebounce(inputEl) {
        _activeItemInput = inputEl;
        clearTimeout(_itemSearchTimer);
        var q = (inputEl.value || '').trim();
        if (q.length === 0) { closeItemDropdownFor(inputEl); return; }
        _itemSearchTimer = setTimeout(function() { renderItemFuzzyDropdown(inputEl, q); }, 120);
    }

    function renderItemFuzzyDropdown(inputEl, query) {
        var items = state.allItems || [];
        if (!items.length) {
            // Fallback: request from server
            Utils.nuiCallback('searchItems', { query: query });
            return;
        }
        var q = query.toLowerCase();
        var results = items.filter(function(it) {
            var label = (it.label || '').toLowerCase();
            var name = (it.item || it.name || '').toLowerCase();
            return label.indexOf(q) !== -1 || name.indexOf(q) !== -1;
        }).slice(0, 12);

        var dropId = 'isd-' + inputEl.id;
        var existing = document.getElementById(dropId);
        if (!existing) {
            existing = document.createElement('div');
            existing.id = dropId;
            existing.className = 'item-search-dropdown';
            existing.style.cssText = 'position:absolute;z-index:9999;background:var(--bg-card);border:1px solid var(--border);border-radius:var(--radius);overflow:hidden;max-height:220px;overflow-y:auto;box-shadow:var(--shadow-md);min-width:220px';
            // Insert after the input's parent FG div
            var parent = inputEl.closest('.fg') || inputEl.parentNode;
            parent.style.position = 'relative';
            parent.appendChild(existing);
        }

        if (!results.length) {
            existing.innerHTML = '<div style="padding:8px 12px;color:var(--text-dim);font-size:12px">No items found</div>';
            existing.style.display = 'block';
            return;
        }

        existing.innerHTML = results.map(function(it) {
            var iname = it.item || it.name || '';
            var ilabel = it.label || iname;
            return '<div class="isd-row" onclick="App.selectItemFor(\'' + Utils.escapeHtml(inputEl.id) + '\',\'' + Utils.escapeHtml(iname) + '\')" style="padding:7px 12px;cursor:pointer;display:flex;justify-content:space-between;gap:8px;align-items:center;border-bottom:1px solid var(--border)">' +
                '<span style="font-size:12.5px;color:var(--text-bright)">' + Utils.escapeHtml(ilabel) + '</span>' +
                '<span style="font-size:10.5px;color:var(--text-muted);font-family:var(--font-mono)">' + Utils.escapeHtml(iname) + '</span>' +
                '</div>';
        }).join('');
        existing.style.display = 'block';

        // Close on outside click
        if (!existing._hasClickaway) {
            existing._hasClickaway = true;
            document.addEventListener('click', function onClickAway(e) {
                if (!existing.contains(e.target) && e.target !== inputEl) {
                    existing.style.display = 'none';
                    document.removeEventListener('click', onClickAway);
                    existing._hasClickaway = false;
                }
            });
        }
    }

    function closeItemDropdownFor(inputEl) {
        var dropId = 'isd-' + inputEl.id;
        var el = document.getElementById(dropId);
        if (el) el.style.display = 'none';
    }

    function selectItemFor(inputId, itemName) {
        var inp = document.getElementById(inputId);
        if (inp) { inp.value = itemName; inp.dispatchEvent(new Event('change')); }
        closeItemDropdownFor(inp || { id: inputId });
    }

    function renderItemSearchResults() {
        var inputEl = _activeItemInput || document.getElementById('give-item-name');
        if (!inputEl) return;
        var items = state.itemSearchResults || [];
        if (!items.length) return;
        showItemDropdown(inputEl, items, function(selected) {
            inputEl.value = selected.label || selected.item || selected.name || '';
            inputEl.dataset.selectedItem = selected.item || selected.name || '';
            inputEl.dispatchEvent(new Event('item-selected', { bubbles: true }));
        });
    }
function showPlayerDropdown(inputEl, players, onSelect) {
        var existingDrops = document.querySelectorAll('.player-suggest-list');
        existingDrops.forEach(function(el) { el.remove(); });
        if (!players || players.length === 0) return;

        var list = document.createElement('ul');
        list.className = 'player-suggest-list item-suggest-list';
        var r = inputEl.getBoundingClientRect();
        list.style.cssText = 'position:fixed;top:' + (r.bottom + 2) + 'px;left:' + r.left + 'px;width:' + Math.max(r.width, 240) + 'px;z-index:9999';

        players.slice(0, 10).forEach(function(p) {
            var li = document.createElement('li');
            var steamShort = p.steam ? p.steam.replace('steam:', '').slice(-8) : '';
            var nameSpan = document.createElement('span');
            nameSpan.textContent = p.name || p.player_name || 'Unknown';
            var steamSpan = document.createElement('span');
            steamSpan.className = 'ps-steam';
            steamSpan.textContent = steamShort;
            li.appendChild(nameSpan);
            li.appendChild(steamSpan);
            li.addEventListener('mousedown', function(e) {
                e.preventDefault();
                onSelect(p);
                list.remove();
            });
            list.appendChild(li);
        });

        document.body.appendChild(list);
        setTimeout(function() {
            document.addEventListener('click', function removeList() {
                list.remove();
                document.removeEventListener('click', removeList);
            });
        }, 10);
    }

    // Global input listener for .player-name-search class
    document.addEventListener('input', function(e) {
        if (!e.target || !e.target.matches) return;
        if (e.target.matches('.player-name-search')) {
            var q = e.target.value.trim().toLowerCase();
            var inputEl = e.target;
            var existingDrops = document.querySelectorAll('.player-suggest-list');
            existingDrops.forEach(function(el) { el.remove(); });
            if (q.length < 2) return;
            var all = [];
            if (state.playerList && state.playerList.players) {
                state.playerList.players.forEach(function(p) { all.push(p); });
            }
            var matches = all.filter(function(p) {
                return p.name && p.name.toLowerCase().indexOf(q) !== -1;
            });
            showPlayerDropdown(inputEl, matches, function(selected) {
                inputEl.value = selected.name || selected.player_name || '';
                inputEl.dataset.selectedSteam = selected.steam || '';
                inputEl.dispatchEvent(new CustomEvent('player-selected', { bubbles: true, detail: selected }));
            });
        }
    });
    function selectSearchItem(itemName, itemLabel) {
        // Legacy wrapper — used by old onclick calls
        var inputEl = _activeItemInput || document.getElementById('give-item-name');
        if (inputEl) inputEl.value = itemName;
        var dropId = 'isd-' + (inputEl ? inputEl.id : 'give-item-name');
        var el = document.getElementById(dropId);
        if (el) el.style.display = 'none';
        // Legacy dropdown element
        var legacy = document.getElementById('item-search-dropdown');
        if (legacy) { legacy.innerHTML = ''; legacy.style.display = 'none'; }
    }
function renderItemDatabase() {
        var items = state.allItems || [];
        var grid = document.getElementById('itemdb-grid');
        if (!grid) return;

        // Populate types dropdown
        var catSel = document.getElementById('itemdb-category');
        if (catSel && catSel.options.length <= 1) {
            var cats = {};
            items.forEach(function(it) {
                var c = it.type || '';
                if (c && !cats[c]) cats[c] = true;
            });
            Object.keys(cats).sort().forEach(function(c) {
                var opt = document.createElement('option');
                opt.value = c; opt.textContent = c;
                catSel.appendChild(opt);
            });
        }

        // Apply search/filter
        var searchVal = (val('itemdb-search') || '').toLowerCase();
        var catVal = val('itemdb-category') || '';

        // Deduplicate renders — skip if nothing changed
        var sortVal2 = val('itemdb-sort') || 'name';
        var renderKey = (searchVal || '') + '|' + (catVal || '') + '|' + (sortVal2 || '') + '|' + items.length;
        if (grid._lastRenderKey === renderKey) return;
        grid._lastRenderKey = renderKey;

        var filtered = items.filter(function(it) {            if (catVal && (it.type || '') !== catVal) return false;
            if (searchVal) {
                var itemId = (it.item || '').toLowerCase();
                var label = (it.label || '').toLowerCase();
                var combined = itemId + ' ' + label;
                // Exact substring match first
                if (combined.indexOf(searchVal) !== -1) return true;
                // Normalized match: strip spaces/underscores so "gold bar" matches "goldbar"
                var searchNorm = searchVal.replace(/[\s_\-]+/g, '');
                if (searchNorm) {
                    var itemNorm = itemId.replace(/[\s_\-]+/g, '');
                    var labelNorm = label.replace(/[\s_\-]+/g, '');
                    if (itemNorm.indexOf(searchNorm) !== -1 || labelNorm.indexOf(searchNorm) !== -1) return true;
                }
                return false;
            }
            return true;
        });

        // Sort
        var sortVal = val('itemdb-sort') || 'name';
        if (sortVal === 'weight') {
            filtered.sort(function(a, b) { return (b.weight || 0) - (a.weight || 0); });
        } else if (sortVal === 'name') {
            filtered.sort(function(a, b) { return (a.label || '').localeCompare(b.label || ''); });
        }

        if (!filtered.length) {
            grid.innerHTML = '<div style="text-align:center;color:var(--text-dim);padding:40px 0;grid-column:1/-1">' + (items.length ? 'No items match your search' : 'Loading items...') + '</div>';
            return;
        }

        // Show item count
        var countEl = document.getElementById('itemdb-count');
        var pageSize = state.itemDbPageSize || 100;
        var page = state.itemDbPage || 1;
        var showCount = pageSize === 0 ? filtered.length : Math.min(page * pageSize, filtered.length);
        var paged = pageSize === 0 ? filtered : filtered.slice(0, showCount);

        if (countEl) countEl.textContent = 'Showing ' + paged.length + ' of ' + filtered.length + ' item' + (filtered.length !== 1 ? 's' : '') + (items.length !== filtered.length ? ' (filtered from ' + items.length + ' total)' : '');

        grid.innerHTML = paged.map(function(it) {
            var itemId = it.item || it.name || '';
            var label = it.label || itemId;
            return '<div class="itemdb-card" title="' + Utils.escapeHtml(itemId) + '" onclick="App.openItemDetail(\'' + Utils.escapeHtml(itemId) + '\', \'' + Utils.escapeHtml(label) + '\')">' +
                itemImageHtml(itemId, 'itemdb-card-img', '56px').replace(/item-dist-img-wrap/g, 'itemdb-card-emoji') +
                '<div class="itemdb-card-name">' + Utils.escapeHtml(label) + '</div>' +
                '<div class="itemdb-card-id">' + Utils.escapeHtml(itemId) + '</div>' +
                (it.weight ? '<div class="itemdb-card-weight">' + it.weight + 'g</div>' : '') +
            '</div>';
        }).join('');

        // Load More button
        var moreBtn = document.getElementById('btn-itemdb-more');
        var moreBtnWrap = document.getElementById('itemdb-more-wrap');
        if (moreBtnWrap) {
            if (pageSize > 0 && filtered.length > showCount) {
                moreBtnWrap.style.display = '';
                if (moreBtn) moreBtn.textContent = 'Load More (' + (filtered.length - showCount) + ' remaining)';
            } else {
                moreBtnWrap.style.display = 'none';
            }
        }

        // Bind search after render
        var searchInput = document.getElementById('itemdb-search');
        var searchBtn = document.getElementById('btn-itemdb-search');
        if (searchBtn && !searchBtn._bound) {
            searchBtn._bound = true;
            searchBtn.addEventListener('click', function() { state.itemDbPage = 1; grid._lastRenderKey = null; renderItemDatabase(); });
        }
        if (catSel && !catSel._bound) {
            catSel._bound = true;
            catSel.addEventListener('change', function() { state.itemDbPage = 1; grid._lastRenderKey = null; renderItemDatabase(); });
        }
        var sortSel = document.getElementById('itemdb-sort');
        if (sortSel && !sortSel._bound) {
            sortSel._bound = true;
            sortSel.addEventListener('change', function() { state.itemDbPage = 1; grid._lastRenderKey = null; renderItemDatabase(); });
        }
        var limitSel = document.getElementById('itemdb-limit');
        if (limitSel && !limitSel._bound) {
            limitSel._bound = true;
            limitSel.addEventListener('change', function() {
                state.itemDbPageSize = parseInt(this.value) || 100;
                state.itemDbPage = 1;
                grid._lastRenderKey = null;
                renderItemDatabase();
            });
        }
        if (moreBtn && !moreBtn._bound) {
            moreBtn._bound = true;
            moreBtn.addEventListener('click', function() {
                state.itemDbPage = (state.itemDbPage || 1) + 1;
                grid._lastRenderKey = null;
                renderItemDatabase();
            });
        }
        if (searchInput && !searchInput._bound) {
            searchInput._bound = true;
            var debounce;
            searchInput.addEventListener('input', function() {
                clearTimeout(debounce);
                debounce = setTimeout(function() { state.itemDbPage = 1; renderItemDatabase(); }, 300);
            });
        }
    }
function editCharacterField(targetId, field) {
        confirmActionWithInput('Edit Character', 'Enter new value for ' + field + ':', field, function (value) {
            if (!value) return;
            Utils.nuiCallback('editCharacter', { targetId: targetId, field: field, value: value });
        });
    }
function clearItems(targetId) {
        confirmAction('Clear Items', 'Remove ALL items from this player?', function () {
            Utils.nuiCallback('clearItems', { targetId: targetId });
        });
    }
    function clearWeapons(targetId) {
        confirmAction('Clear Weapons', 'Remove ALL weapons from this player?', function () {
            Utils.nuiCallback('clearWeapons', { targetId: targetId });
        });
    }
    function clearAllInventory(targetId) {
        confirmAction('Clear All Inventory', 'Remove ALL items AND weapons from this player?', function () {
            Utils.nuiCallback('clearAllInventory', { targetId: targetId });
        });
    }
function scheduleRestart() {
        var sel = document.getElementById('restart-delay');
        var secs = sel ? parseInt(sel.value) : 300;
        var label = sel ? sel.options[sel.selectedIndex].text : '5 Minutes';
        confirmAction('Schedule Restart', 'Restart the server in ' + label + '?', function () {
            Utils.nuiCallback('scheduleRestart', { seconds: secs });
        });
    }
    function cancelRestart() {
        Utils.nuiCallback('cancelRestart', {});
    }
function renderCoords() {
        var c = state.ownCoords;
        if (!c) return;
        setText('coord-x', (c.x || 0).toFixed(2));
        setText('coord-y', (c.y || 0).toFixed(2));
        setText('coord-z', (c.z || 0).toFixed(2));
        setText('coord-h', (c.h || c.heading || 0).toFixed(2));
    }
    function startCoordsUpdate() {
        stopCoordsUpdate();
        var toggle = document.getElementById('coords-live-toggle');
        if (toggle) {
            toggle.addEventListener('change', function () {
                if (this.checked) {
                    state.coordsTimer = setInterval(function () {
                        Utils.nuiCallback('getOwnCoords', {});
                    }, 100);
                } else {
                    stopCoordsUpdate();
                }
            });
        }
    }
    function stopCoordsUpdate() {
        if (state.coordsTimer) { clearInterval(state.coordsTimer); state.coordsTimer = null; }
    }
    function copyCoords(format) {
        var c = state.ownCoords;
        if (!c) { Utils.showToast('No coordinate data available', 'error'); return; }
        var x = (c.x || 0).toFixed(4), y = (c.y || 0).toFixed(4), z = (c.z || 0).toFixed(4), h = (c.h || c.heading || 0).toFixed(4);
        var text = '';
        switch (format) {
            case 'xyz': text = x + ', ' + y + ', ' + z; break;
            case 'vector3': text = 'vector3(' + x + ', ' + y + ', ' + z + ')'; break;
            case 'vector4': text = 'vector4(' + x + ', ' + y + ', ' + z + ', ' + h + ')'; break;
            case 'table': text = '{x = ' + x + ', y = ' + y + ', z = ' + z + ', h = ' + h + '}'; break;
        }
        if (navigator.clipboard) {
            navigator.clipboard.writeText(text).then(function () {
                Utils.showToast('Copied: ' + text, 'success');
            });
        } else {
            Utils.showToast(text, 'info');
        }
    }
function editBan(banId) {
        var bans = state.banList;
        var list = Array.isArray(bans) ? bans : (bans.bans || bans.list || []);
        var ban = null;
        for (var i = 0; i < list.length; i++) { if (list[i].id == banId) { ban = list[i]; break; } }
        if (!ban) return;
        state.editingBanId = banId;
        document.getElementById('ban-edit-player').value = ban.player_name || ban.username || '-';
        document.getElementById('ban-edit-reason').value = ban.reason || '';
        document.getElementById('ban-edit-duration').value = 'keep';
        document.getElementById('ban-edit-modal').classList.remove('hidden');
    }
    function saveBanEdit() {
        if (!state.editingBanId) return;
        var reason = val('ban-edit-reason');
        var duration = val('ban-edit-duration');
        Utils.nuiCallback('editBan', { banId: state.editingBanId, reason: reason, duration: duration });
        document.getElementById('ban-edit-modal').classList.add('hidden');
        state.editingBanId = null;
    }
var BLIP_PRESETS = [
        { name: 'Stable',        hash: 'blip_shop_horse'          },
        { name: 'Store',         hash: 'blip_shop_store'          },
        { name: 'Saloon',        hash: 'blip_saloon'              },
        { name: 'Gun Store',     hash: 'blip_shop_gunsmith'       },
        { name: 'Doctor',        hash: 'blip_shop_doctor'         },
        { name: 'Barber',        hash: 'blip_shop_barber'         },
        { name: 'Hotel',         hash: 'blip_bath_house'          },
        { name: 'Train Station', hash: 'blip_shop_train'          },
        { name: 'Camp',          hash: 'blip_camp_tent'           },
        { name: 'Post Office',   hash: 'blip_post_office'         },
        { name: 'Fence',         hash: 'blip_shop_coach_fencing'  },
        { name: 'Butcher',       hash: 'blip_shop_butcher'        },
        { name: 'Fishing',       hash: 'blip_shop_tackle'         },
        { name: 'Sheriff',       hash: 'blip_ambient_sheriff'     },
        { name: 'Trapper',       hash: 'blip_shop_animal_trapper' },
        { name: 'Fast Travel',   hash: 'blip_code_waypoint'       },
        { name: 'Moonshine',     hash: 'blip_shop_shady_store'    },
        { name: 'Bounty Board',  hash: 'blip_proc_bounty_poster'  },
        { name: 'Treasure',      hash: 'blip_chest'               },
        { name: 'Stranger',      hash: 'blip_ambient_bounty_target' },
        { name: 'House',         hash: 'blip_proc_home'           },
        { name: 'Mine',          hash: 'blip_shop_blacksmith'     },
        { name: 'Hunting',       hash: 'blip_animal'              },
        { name: 'Waypoint',      hash: 'blip_code_waypoint'       },
        { name: 'Player',        hash: 'blip_player'              },
        { name: 'Enemy',         hash: 'blip_ambient_bounty_target' },
        { name: 'Companion',     hash: 'blip_ambient_companion'   },
        { name: 'Law',           hash: 'blip_ambient_law'         },
        { name: 'Bounty Hunter', hash: 'blip_ambient_bounty_hunter' },
        { name: 'Hitching Post', hash: 'blip_ambient_hitching_post' }
    ];
    var BLIP_COLORS = [
        { id: 0, name: 'Default', hex: '#8a9098' },
        { id: 1, name: 'Blue', hex: '#4f7cff' },
        { id: 2, name: 'Red', hex: '#d94a4a' },
        { id: 3, name: 'Green', hex: '#49a66d' },
        { id: 4, name: 'Orange', hex: '#d78a3d' },
        { id: 5, name: 'Purple', hex: '#7f62d9' },
        { id: 6, name: 'Gold', hex: '#d5b15a' },
        { id: 7, name: 'Pink', hex: '#d870b7' },
        { id: 8, name: 'Teal', hex: '#3aa6a0' }
    ];
    function populateBlipPresets() {
        var sel = document.getElementById('blip-preset');
        if (!sel || sel.options.length > 1) return;
        BLIP_PRESETS.forEach(function (b) {
            var opt = document.createElement('option');
            opt.value = b.hash;
            opt.textContent = b.name;
            sel.appendChild(opt);
        });
    }
    function selectBlipPreset(val) {
        if (val) document.getElementById('blip-hash').value = val;
        var preview = document.getElementById('blip-preset-preview');
        if (preview) {
            var meta = getBlipPresetMeta(val);
            preview.textContent = meta ? ('Preview: ' + meta.name) : (val ? 'Custom: ' + val : 'No preset selected');
        }
    }
    function renderBlipColorSwatches() {
        var container = document.getElementById('blip-color-swatches');
        var input = document.getElementById('blip-color');
        var label = document.getElementById('blip-color-label');
        if (!container || !input) return;
        var current = parseInt(input.value || 0, 10);
        container.innerHTML = BLIP_COLORS.map(function (color) {
            var active = color.id === current ? ' active' : '';
            return '<button type="button" class="blip-color-swatch' + active + '" data-color-id="' + color.id + '" title="' + Utils.escapeHtml(color.name) + '" style="background:' + color.hex + '"></button>';
        }).join('');
        if (label) label.textContent = getBlipColorMeta(current).name;
    }
    function applyTimescale() {
        var slider = document.getElementById('mgmt-timescale');
        var val = slider ? parseInt(slider.value) : 30;
        Utils.nuiCallback('setTimescale', { value: val });
        Utils.showToast('Timescale set to ' + val, 'success');
    }
    function initServerToggles() {
        var freezeW = document.getElementById('mgmt-freeze-weather');
        var freezeT = document.getElementById('mgmt-freeze-time');
        if (freezeW) {
            freezeW.addEventListener('change', function () {
                Utils.nuiCallback('toggleFreezeWeather', { freeze: this.checked });
                Utils.showToast(this.checked ? 'Weather frozen' : 'Weather unfrozen', 'info');
            });
        }
        if (freezeT) {
            freezeT.addEventListener('change', function () {
                Utils.nuiCallback('toggleFreezeTime', { freeze: this.checked });
                Utils.showToast(this.checked ? 'Time frozen' : 'Time unfrozen', 'info');
            });
        }
        var tsSlider = document.getElementById('mgmt-timescale');
        if (tsSlider) {
            tsSlider.addEventListener('input', function () {
                setText('mgmt-timescale-val', this.value);
            });
        }
        var windSpeed = document.getElementById('mgmt-wind-speed');
        if (windSpeed) {
            windSpeed.addEventListener('input', function () {
                setText('mgmt-wind-speed-val', this.value);
            });
        }
        var windDir = document.getElementById('mgmt-wind-dir');
        if (windDir) {
            windDir.addEventListener('input', function () {
                setText('mgmt-wind-dir-val', this.value + '°');
            });
        }
        bindBtn('close-tp-edit-modal', function () { document.getElementById('tp-edit-modal').classList.add('hidden'); });
        bindBtn('btn-tp-edit-cancel', function () { document.getElementById('tp-edit-modal').classList.add('hidden'); });
        bindBtn('btn-tp-edit-save', saveTeleportEdit);
    }
function setText(id, text) { var el = document.getElementById(id); if (el) el.textContent = text; }
    function val(id) { var el = document.getElementById(id); return el ? el.value : ''; }
    function bindBtn(id, fn) { var el = document.getElementById(id); if (el) el.addEventListener('click', fn); }
    function bindEnter(id, fn) {
        var el = document.getElementById(id);
        if (el) el.addEventListener('keydown', function (e) { if (e.key === 'Enter') fn(); });
    }

    function exportCSV(filename, headers, rows) {
        var csv = [headers.map(function(h) { return '"' + String(h).replace(/"/g, '""') + '"'; }).join(',')];
        rows.forEach(function(row) {
            csv.push(row.map(function(cell) {
                var v = cell == null ? '' : String(cell);
                return '"' + v.replace(/"/g, '""') + '"';
            }).join(','));
        });
        var blob = new Blob([csv.join('\r\n')], { type: 'text/csv;charset=utf-8;' });
        var url = URL.createObjectURL(blob);
        var a = document.createElement('a');
        a.href = url; a.download = filename; a.style.display = 'none';
        document.body.appendChild(a); a.click();
        setTimeout(function() { document.body.removeChild(a); URL.revokeObjectURL(url); }, 500);
    }
document.addEventListener('DOMContentLoaded', init);
document.addEventListener('keydown', function (e) {
        if (e.key === 'Escape') {
            var modals = document.querySelectorAll('.modal:not(.hidden)');
            if (modals.length) {
                modals.forEach(function (m) { m.classList.add('hidden'); });
                var cb = document.getElementById('action-modal-confirm');
                if (cb) cb.classList.remove('hidden');
            } else {
                closeApp();
            }
        }
    });
document.addEventListener('click', function (e) {
        var blipColorSwatch = e.target && e.target.closest ? e.target.closest('.blip-color-swatch') : null;
        if (blipColorSwatch) {
            e.preventDefault();
            var colorInput = document.getElementById('blip-color');
            if (colorInput) {
                colorInput.value = blipColorSwatch.dataset.colorId || '0';
                renderBlipColorSwatches();
            }
            return;
        }
        var detailLink = e.target && e.target.closest ? e.target.closest('.mguard-detail-link') : null;
        if (detailLink) {
            e.preventDefault();
            e.stopPropagation();
            openPlayerDetail(detailLink.dataset.steam, detailLink.dataset.serverId);
            return;
        }
        if (e.target.classList.contains('modal') && !e.target.classList.contains('hidden')) {
            e.target.classList.add('hidden');
            var cb = document.getElementById('action-modal-confirm');
            if (cb) cb.classList.remove('hidden');
        }
    });


    //---------------------------------------------------------------------------
    // COMBAT FILTER HELPERS
    //---------------------------------------------------------------------------
    function getCombatFilters() {
        return {
            search: val('combat-search'),
            pvp_only: val('combat-filter-pvp'),
            date_from: val('combat-date-from'),
            date_to: val('combat-date-to'),
            limit: 100,
            offset: 0,
        };
    }

    function getTransferFilters() {
        return {
            search: val('transfer-search'),
            flagged_only: document.getElementById('transfer-flagged-only') && document.getElementById('transfer-flagged-only').checked ? '1' : '',
            date_from: val('transfer-date-from'),
            date_to: val('transfer-date-to'),
            limit: 100,
            offset: 0,
        };
    }

    //---------------------------------------------------------------------------
    // COMBAT STATS RENDER
    //---------------------------------------------------------------------------
    function renderCombatStats() {
        hidePageLoading('combat');
        var s = state.combatStats;
        if (!s) return;
        var t = s.totals || {};

        setText('combat-stat-total', t.total || 0);
        setText('combat-stat-pvp', t.pvp || 0);
        setText('combat-stat-pve', t.pve || 0);
        setText('combat-stat-unique-killers', t.unique_killers || 0);
        setText('combat-stat-avg-dist', t.avg_distance ? Math.round(t.avg_distance) + 'm' : '0m');

        var killersTbody = document.getElementById('combat-top-killers');
        if (killersTbody) {
            killersTbody.innerHTML = (s.topKillers || []).map(function(k) {
                return '<tr><td><a href="#" onclick="App.openPlayerDetail(\'' + Utils.escapeHtml(k.killer_steam || '') + '\');return false" style="color:var(--accent)">' + Utils.escapeHtml(k.killer_name || '-') + '</a></td>' +
                    '<td><span class="badge badge-danger">' + k.kill_count + '</span></td></tr>';
            }).join('') || '<tr><td colspan="2" style="color:var(--text-dim);text-align:center">No data</td></tr>';
        }

        var weaponTbody = document.getElementById('combat-weapon-breakdown');
        if (weaponTbody) {
            weaponTbody.innerHTML = (s.weaponBreakdown || []).map(function(w) {
                return '<tr><td>' + Utils.escapeHtml(w.weapon_name || 'Unknown') + '</td>' +
                    '<td><span class="badge badge-muted">' + w.cnt + '</span></td></tr>';
            }).join('') || '<tr><td colspan="2" style="color:var(--text-dim);text-align:center">No data</td></tr>';
        }
    }

    //---------------------------------------------------------------------------
    // COMBAT LOG RENDER
    //---------------------------------------------------------------------------
    function renderCombatLog() {
        var data = state.combatLog;
        var rows = (data && data.rows) ? data.rows : (Array.isArray(data) ? data : []);
        var tbody = document.getElementById('combat-tbody');
        if (!tbody) return;
        hidePageLoading('combat');

        if (!rows.length) {
            tbody.innerHTML = '<tr><td colspan="6" style="color:var(--text-dim);text-align:center;padding:20px">No combat events found</td></tr>';
            return;
        }

        tbody.innerHTML = rows.map(function(r) {
            var isPvP = r.is_pvp;
            var typeBadge = isPvP
                ? '<span class="badge badge-danger">PvP</span>'
                : '<span class="badge badge-muted">PvE</span>';
            var dist = (r.distance != null && r.distance > 0) ? parseFloat(r.distance).toFixed(1) + 'm' : '\u2014';
            var victimLink = r.victim_steam
                ? '<a href="#" onclick="App.openPlayerDetail(\'' + Utils.escapeHtml(r.victim_steam) + '\');return false" style="color:var(--text)">' + Utils.escapeHtml(r.victim_name || '-') + '</a>'
                : Utils.escapeHtml(r.victim_name || '-');
            var killerLink = r.killer_steam
                ? '<a href="#" onclick="App.openPlayerDetail(\'' + Utils.escapeHtml(r.killer_steam) + '\');return false" style="color:var(--accent)">' + Utils.escapeHtml(r.killer_name || 'Unknown') + '</a>'
                : '<span style="color:var(--text-dim)">' + Utils.escapeHtml(r.killer_name || r.killer_steam || 'NPC / Environment') + '</span>';
            return '<tr>' +
                '<td style="color:var(--text-dim);font-size:11px">' + Utils.formatTime(r.created_at) + '</td>' +
                '<td>' + victimLink + '</td>' +
                '<td>' + killerLink + '</td>' +
                '<td style="font-size:11px">' + Utils.escapeHtml(r.weapon_name || ('0x' + ((r.weapon_hash||0) >>> 0).toString(16).toUpperCase())) + '</td>' +
                '<td>' + dist + '</td>' +
                '<td>' + typeBadge + '</td>' +
                '</tr>';
        }).join('');
    }

    //---------------------------------------------------------------------------
    // ITEM TRANSFERS RENDER
    //---------------------------------------------------------------------------
    function renderItemTransfers() {
        var data = state.itemTransfers;
        var rows = (data && data.rows) ? data.rows : (Array.isArray(data) ? data : []);
        var tbody = document.getElementById('transfer-tbody');
        if (!tbody) return;

        if (!rows.length) {
            tbody.innerHTML = '<tr><td colspan="7" style="color:var(--text-dim);text-align:center;padding:20px">No transfers found</td></tr>';
            return;
        }

        tbody.innerHTML = rows.map(function(r) {
            var flagBadge = r.flagged
                ? '<span class="badge badge-danger" title="' + Utils.escapeHtml(r.flag_reason || '') + '"><i class="fa-solid fa-triangle-exclamation" style="font-size:9px"></i></span>'
                : '<span class="badge badge-ok"><i class="fa-solid fa-check" style="font-size:9px"></i></span>';
            return '<tr>' +
                '<td style="color:var(--text-dim);font-size:11px">' + Utils.formatTime(r.created_at) + '</td>' +
                '<td><a href="#" onclick="App.openPlayerDetail(\'' + Utils.escapeHtml(r.from_steam || '') + '\');return false" style="color:var(--text)">' + Utils.escapeHtml(r.from_name || '-') + '</a></td>' +
                '<td><a href="#" onclick="App.openPlayerDetail(\'' + Utils.escapeHtml(r.to_steam || '') + '\');return false" style="color:var(--accent)">' + Utils.escapeHtml(r.to_name || '-') + '</a></td>' +
                '<td>' + Utils.escapeHtml(r.item_name || '-') + '</td>' +
                '<td>' + (r.quantity || 1) + '</td>' +
                '<td style="font-size:11px;color:var(--text-dim)">' + Utils.escapeHtml(r.source_resource || '-') + '</td>' +
                '<td>' + flagBadge + '</td>' +
                '</tr>';
        }).join('');
    }

    //---------------------------------------------------------------------------
    // PLAYER TIMELINE RENDER
    //---------------------------------------------------------------------------
    function renderPlayerTimeline() {
        var events = state.playerTimeline;
        if (!Array.isArray(events)) return;

        var panel = document.getElementById('pd-timeline');
        if (!panel) return;

        if (!events.length) {
            panel.innerHTML = '<div style="color:var(--text-dim);text-align:center;padding:20px">No events recorded yet</div>';
            return;
        }

        var icons = {
            session: '<i class="fa-solid fa-arrow-right-to-bracket" style="font-size:12px"></i>',
            death: '<i class="fa-solid fa-skull" style="font-size:12px"></i>',
            kill: '<i class="fa-solid fa-crosshairs" style="font-size:12px"></i>',
            detection: '<i class="fa-solid fa-triangle-exclamation" style="font-size:12px"></i>',
            economy: '<i class="fa-solid fa-coins" style="font-size:12px"></i>',
            alert: '<i class="fa-solid fa-bell" style="font-size:12px"></i>',
            admin_action: '<i class="fa-solid fa-shield-halved" style="font-size:12px"></i>',
        };

        var colorMap = {
            danger: 'var(--danger)',
            warn: 'var(--warn)',
            ok: 'var(--ok)',
            info: 'var(--text-dim)',
        };

        panel.innerHTML = '<div class="timeline-list">' + events.map(function(e) {
            var color = colorMap[e.severity] || 'var(--text-dim)';
            var icon = icons[e.event_type] || '<i class="fa-solid fa-circle" style="font-size:8px"></i>';
            return '<div class="timeline-event">' +
                '<span class="timeline-icon" style="color:' + color + '">' + icon + '</span>' +
                '<div class="timeline-body">' +
                '<div class="timeline-summary" style="color:' + color + '">' + Utils.escapeHtml(e.summary || '') + '</div>' +
                '<div class="timeline-time">' + Utils.formatTime(e.ts) + '</div>' +
                '</div></div>';
        }).join('') + '</div>';
    }
    function submitPlayerNote(steam, playerName) {
        var text = (document.getElementById('pd-note-input') || {}).value || '';
        if (!text.trim()) return;
        Utils.nuiCallback('addPlayerNote', { steam: steam, player_name: playerName, note_text: text.trim(), added_by: 'admin', added_by_name: 'Admin' })
            .then(function(res) {
                if (res && res.success) {
                    var pd = state.selectedPlayer || state.playerDetail;
                    if (pd) {
                        Utils.nuiCallback('getPlayerNotes', { steam: steam }).then(function(nr) {
                            pd.notes_list = (nr && nr.notes) || [];
                            var panel = document.getElementById('pd-notes');
                            if (panel) panel.innerHTML = renderPDTab('notes', pd);
                        });
                    }
                }
            });
    }

    function deletePlayerNote(noteId, steam) {
        Utils.nuiCallback('deletePlayerNote', { id: noteId }).then(function(res) {
            if (res && res.success) {
                var pd = state.selectedPlayer || state.playerDetail;
                if (pd) {
                    Utils.nuiCallback('getPlayerNotes', { steam: steam }).then(function(nr) {
                        pd.notes_list = (nr && nr.notes) || [];
                        var panel = document.getElementById('pd-notes');
                        if (panel) panel.innerHTML = renderPDTab('notes', pd);
                    });
                }
            }
        });
    }

    return {
        openPlayerDetail: openPlayerDetail,
        invGiveItem: invGiveItem,
        invRemoveItem: invRemoveItem,
        adminPlayerAction: adminPlayerAction,
        kickPlayerPrompt: kickPlayerPrompt,
        banPlayerPrompt: banPlayerPrompt,
        banOnlinePlayerPrompt: banOnlinePlayerPrompt,
        warnPlayerPrompt: warnPlayerPrompt,
        manageCurrency: manageCurrency,
        giveItem: giveItem,
        removeItemPrompt: removeItemPrompt,
        setPlayerJob: setPlayerJob,
        viewInventory: viewInventory,
        screenPlayer: screenPlayer,
        updateQueueActionFields: updateQueueActionFields,
        submitQueueAction: submitQueueAction,
        cancelPendingAction: cancelPendingAction,
        unbanPlayer: unbanPlayer,
        resolveAlert: resolveAlert,
        resolveDetection: resolveDetection,
        showInfoModal: showInfoModal,
        resourceAction: resourceAction,
        teleportTo: teleportTo,
        deleteTeleport: deleteTeleport,
        setWeather: setWeather,
        setTime: setTime,
        handleAppeal: handleAppeal,
        openReport: openReport,
        claimReport: claimReport,
        resolveReport: resolveReport,
        reopenReport: reopenReport,
        replyToReport: replyToReport,
        deleteReport: deleteReport,
        removeWarning: removeWarning,
        clearWarnings: clearWarnings,
        editBlip: editBlip,
        deleteBlip: deleteBlip,
        startBlipMapPick: startBlipMapPick,
        populateBlipVisibleTo: populateBlipVisibleTo,
        editAdminRole: editAdminRole,
        removeAdmin: removeAdmin,
        getPlayerCoords: getPlayerCoordsAction,
        quickSpawn: quickSpawn,
        selectSearchItem: selectSearchItem,
        selectItemFor: selectItemFor,
        selectWatchItem: selectWatchItem,
        addWatchTargetNew: addWatchTargetNew,
        removeWatchTargetNew: removeWatchTargetNew,
        addWatchTargetEdit: addWatchTargetEdit,
        removeWatchTargetEdit: removeWatchTargetEdit,
        openWatchPlayersModal: openWatchPlayersModal,
        saveWatchTargets: saveWatchTargets,
        openWatchNotesModal: openWatchNotesModal,
        saveWatchNotes: saveWatchNotes,
        quickWatchCurrentItem: quickWatchCurrentItem,
        watchPlayerForItem: watchPlayerForItem,
        editCharacterField: editCharacterField,
        clearItems: clearItems,
        clearWeapons: clearWeapons,
        clearAllInventory: clearAllInventory,
        openItemDetail: openItemDetail,
        toggleItemWatch: toggleItemWatch,
        removeItemWatch: removeItemWatch,
        scheduleRestart: scheduleRestart,
        cancelRestart: cancelRestart,
        copyCoords: copyCoords,
        editBan: editBan,
        saveBanEdit: saveBanEdit,
        selectBlipPreset: selectBlipPreset,
        applyTimescale: applyTimescale,
        resetMapView: resetMapView,
        focusMapPlayer: focusMapPlayer,
        setExactTime: setExactTime,
        applyWind: applyWind,
        editTeleport: editTeleport,
        submitPlayerNote: submitPlayerNote,
        deletePlayerNote: deletePlayerNote,
        editWhitelist: editWhitelist,
        removeWhitelist: removeWhitelist,
        _psSelect: function(name) {
            var inp = document.getElementById('player-search');
            if (inp) { inp.value = name; }
            var q = name.trim();
            if (q) Utils.nuiCallback('getPlayerList', { search: q });
            var d = document.getElementById('ps-dropdown');
            if (d) d.style.display = 'none';
        },
    };
})();



// Global ESC handler: close topmost open modal, or close NUI if in-game
document.addEventListener('keydown', function(e) {
    if (e.key !== 'Escape') return;
    var openModal = document.querySelector('.modal:not(.hidden)');
    if (openModal) {
        openModal.classList.add('hidden');
        return;
    }
    if (IS_INGAME) {
        if (typeof App !== 'undefined' && App.closeApp) {
            // closeApp handles NUI callback
        }
        document.getElementById('app').classList.add('hidden');
        if (typeof Utils !== 'undefined') Utils.nuiCallback('closeDashboard', {});
    }
});

// Rewire sidebar close button
(function() {
    var btn = document.getElementById('btn-close');
    if (!btn) return;
    btn.addEventListener('click', function(e) {
        e.preventDefault();
        if (IS_INGAME) {
            document.getElementById('app').classList.add('hidden');
            Utils.nuiCallback('closeDashboard', {});
        } else {
            var sidebar = document.getElementById('sidebar');
            if (sidebar) sidebar.classList.toggle('open');
        }
    });
})();

// Mobile bottom nav
document.querySelectorAll('#mobile-nav .mobile-nav-item[data-page]').forEach(item => {
    item.addEventListener('click', () => {
        const page = item.dataset.page;
        if (page) {
            document.querySelectorAll('#mobile-nav .mobile-nav-item').forEach(i => i.classList.remove('active'));
            item.classList.add('active');
        }
    });
});
document.getElementById('mobile-nav-more')?.addEventListener('click', () => {
    const sidebar = document.getElementById('sidebar');
    const overlay = document.getElementById('sidebar-overlay');
    if (sidebar) sidebar.classList.toggle('open');
    if (overlay) overlay.classList.toggle('visible');
});

// ─────────────────────────────────────────────────────────────────
// PLAYER REPORTS PANEL — /myreports in-game command
// Separate from admin dashboard; any player can open it.
// ─────────────────────────────────────────────────────────────────
var PlayerReports = (function () {
    function esc(str) {
        if (str == null) return '';
        return String(str).replace(/&/g,'&amp;').replace(/</g,'&lt;').replace(/>/g,'&gt;').replace(/"/g,'&quot;');
    }
    function timeAgo(dateStr) {
        if (!dateStr) return '';
        var d = new Date(dateStr), now = new Date();
        var diff = Math.floor((now - d) / 1000);
        if (diff < 60) return 'just now';
        if (diff < 3600) return Math.floor(diff/60) + 'm ago';
        if (diff < 86400) return Math.floor(diff/3600) + 'h ago';
        return Math.floor(diff/86400) + 'd ago';
    }
    function statusBadge(s) {
        var styles = {
            open:     'background:rgba(30,215,96,.12);color:#1ed760;border:1px solid rgba(30,215,96,.25)',
            claimed:  'background:rgba(196,154,60,.12);color:#c49a3c;border:1px solid rgba(196,154,60,.25)',
            resolved: 'background:rgba(92,87,80,.15);color:#a09a92;border:1px solid rgba(92,87,80,.3)',
            reopened: 'background:rgba(74,139,181,.12);color:#4a8bb5;border:1px solid rgba(74,139,181,.25)',
        };
        var st = styles[s] || styles.open;
        return '<span style="display:inline-block;padding:1px 7px;border-radius:9999px;font-size:10px;font-weight:600;letter-spacing:.4px;text-transform:uppercase;' + st + '">' + esc(s) + '</span>';
    }

    function renderReports(reports) {
        var body = document.getElementById('pr-body');
        if (!body) return;
        if (!reports || reports.length === 0) {
            body.innerHTML = '<div style="text-align:center;padding:40px 20px;color:#5c5750"><div style="font-size:32px;margin-bottom:10px;opacity:.4">&#128196;</div><p style="font-size:13px">No reports yet.<br>Use <strong>/report [message]</strong> to submit one.</p></div>';
            return;
        }

        var rows = reports.map(function (r, i) {
            var msgs = r.messages || [];
            var adminReplies = msgs.filter(function (m) {
                return m.sender_role === 'admin' || m.sender_role === 'superadmin' || m.sender_role === 'mod';
            });
            var hasReply = adminReplies.length > 0;
            var replyStyle = hasReply
                ? 'background:rgba(30,215,96,.08);color:#1ed760;border:1px solid rgba(30,215,96,.3)'
                : 'background:#2a2927;color:#a09a92;border:1px solid #2e2c29';
            var replyLabel = '<span style="display:inline-block;padding:1px 7px;border-radius:9999px;font-size:10px;' + replyStyle + '">' +
                (msgs.length > 0 ? msgs.length + (msgs.length === 1 ? ' reply' : ' replies') : 'No replies yet') + '</span>';

            var messagesHtml;
            if (msgs.length > 0) {
                messagesHtml = '<div style="font-size:10px;font-weight:600;letter-spacing:.6px;text-transform:uppercase;color:#5c5750;margin-bottom:8px">Conversation</div><div style="display:flex;flex-direction:column;gap:6px">';
                msgs.forEach(function (m) {
                    var isAdmin = m.sender_role === 'admin' || m.sender_role === 'superadmin' || m.sender_role === 'mod';
                    var cardStyle = isAdmin
                        ? 'background:rgba(30,215,96,.05);border:1px solid rgba(30,215,96,.12)'
                        : 'background:rgba(255,255,255,.02);border:1px solid #2e2c29';
                    var avatarStyle = isAdmin
                        ? 'background:rgba(30,215,96,.2);color:#1ed760'
                        : 'background:rgba(255,255,255,.06);color:#a09a92';
                    var roleTag = isAdmin ? '<span style="font-size:9px;font-weight:600;letter-spacing:.5px;text-transform:uppercase;color:#1ed760">Admin</span>' : '';
                    var initials = (m.sender_name || '?').charAt(0).toUpperCase();
                    messagesHtml +=
                        '<div style="display:flex;gap:8px;padding:7px 9px;border-radius:4px;' + cardStyle + '">' +
                            '<div style="width:22px;height:22px;border-radius:50%;flex-shrink:0;display:flex;align-items:center;justify-content:center;font-size:10px;font-weight:700;margin-top:1px;' + avatarStyle + '">' + initials + '</div>' +
                            '<div style="flex:1;min-width:0">' +
                                '<div style="font-size:11px;font-weight:600;color:#eae6df;display:flex;align-items:center;gap:5px">' + esc(m.sender_name || '-') + ' ' + roleTag + '</div>' +
                                '<div style="font-size:12px;color:#a09a92;line-height:1.5;margin-top:2px">' + esc(m.message || '') + '</div>' +
                                '<div style="font-size:10px;color:#5c5750;margin-top:2px">' + timeAgo(m.created_at) + '</div>' +
                            '</div>' +
                        '</div>';
                });
                messagesHtml += '</div>';
            } else {
                messagesHtml = '<div style="font-size:12px;color:#5c5750;font-style:italic;padding:4px 0">No replies yet. An admin will respond soon.</div>';
            }

            // Player can add follow-up info (only for open/claimed/reopened reports)
            var canAddInfo = r.status !== 'resolved';
            var addInfoHtml = canAddInfo ? (
                '<div style="margin-top:10px;padding-top:10px;border-top:1px solid #2e2c29">' +
                    '<div style="font-size:10px;font-weight:600;letter-spacing:.6px;text-transform:uppercase;color:#5c5750;margin-bottom:6px">Add More Info</div>' +
                    '<textarea id="pr-msg-' + r.id + '" style="width:100%;background:#1a1917;border:1px solid #2e2c29;border-radius:4px;color:#eae6df;font-size:12px;padding:7px 9px;resize:vertical;min-height:50px;box-sizing:border-box" rows="2" placeholder="Add additional details..."></textarea>' +
                    '<button onclick="PlayerReports.sendMessage(' + r.id + ')" style="margin-top:5px;padding:5px 12px;background:rgba(140,32,32,.8);border:1px solid rgba(180,60,60,.3);border-radius:4px;color:#eae6df;font-size:11px;font-weight:600;cursor:pointer">Send</button>' +
                '</div>'
            ) : '';

            return '<div id="pr-card-' + i + '" style="background:#2a2927;border:1px solid #2e2c29;border-radius:6px;margin-bottom:10px;overflow:hidden">' +
                '<div onclick="PlayerReports.toggle(' + i + ')" style="padding:10px 12px;cursor:pointer;display:flex;align-items:flex-start;gap:10px;transition:background .12s" onmouseover="this.style.background=\'#2f2d2a\'" onmouseout="this.style.background=\'\'">' +
                    '<span id="pr-chev-' + i + '" style="color:#5c5750;font-size:10px;margin-top:3px;transition:transform .15s;flex-shrink:0">&#9654;</span>' +
                    '<div style="flex:1;min-width:0">' +
                        '<div style="font-size:13px;font-weight:600;color:#eae6df;margin-bottom:4px">' + esc(r.title || r.report_type || 'Report') + '</div>' +
                        '<div style="display:flex;align-items:center;gap:8px;flex-wrap:wrap">' +
                            statusBadge(r.status) + ' ' + replyLabel +
                            '<span style="font-size:10px;color:#5c5750">' + timeAgo(r.created_at) + '</span>' +
                        '</div>' +
                    '</div>' +
                '</div>' +
                '<div id="pr-body-' + i + '" style="display:none;border-top:1px solid #2e2c29;padding:10px 12px">' +
                    (r.description && r.description.trim() && r.description.trim() !== (r.title || '').trim() ? '<div style="font-size:12px;color:#a09a92;line-height:1.5;margin-bottom:10px;padding-bottom:10px;border-bottom:1px solid #2e2c29">' + esc(r.description) + '</div>' : '') +
                    messagesHtml +
                    addInfoHtml +
                '</div>' +
            '</div>';
        }).join('');

        body.innerHTML = rows;
    }

    function sendMessage(reportId) {
        var ta = document.getElementById('pr-msg-' + reportId);
        if (!ta) return;
        var msg = (ta.value || '').trim();
        if (!msg || msg.length === 0) return;
        if (msg.length > 500) { msg = msg.substring(0, 500); }
        ta.value = '';
        ta.placeholder = 'Sending...';
        ta.disabled = true;
        Utils.nuiCallback('playerAddMessage', { reportId: reportId, message: msg });
        // Re-enable after a short delay; server will push updated reports back
        setTimeout(function () {
            ta.disabled = false;
            ta.placeholder = 'Add additional details...';
        }, 1500);
    }

    function toggle(i) {
        var bodyEl = document.getElementById('pr-body-' + i);
        var chevEl = document.getElementById('pr-chev-' + i);
        if (!bodyEl) return;
        var isOpen = bodyEl.style.display !== 'none';
        bodyEl.style.display = isOpen ? 'none' : 'block';
        if (chevEl) chevEl.style.transform = isOpen ? '' : 'rotate(90deg)';
    }

    function open() {
        var overlay = document.getElementById('pr-overlay');
        if (overlay) overlay.style.display = 'flex';
        Utils.nuiCallback('getMyReports', {});
    }

    function close() {
        var overlay = document.getElementById('pr-overlay');
        if (overlay) overlay.style.display = 'none';
        Utils.nuiCallback('closePlayerReports', {});
    }

    // Handle Escape key for player reports panel
    document.addEventListener('keydown', function (e) {
        var overlay = document.getElementById('pr-overlay');
        if (e.key === 'Escape' && overlay && overlay.style.display === 'flex') {
            close();
        }
    });

    return { open: open, close: close, toggle: toggle, renderReports: renderReports, sendMessage: sendMessage };
})();

// Route incoming messages to PlayerReports module
(function () {
    var _origOnMessage = window._mguardOnMessage;
    window.addEventListener('message', function (e) {
        var d = e.data;
        if (!d || !d.action) return;
        if (d.action === 'openPlayerReports') {
            PlayerReports.open();
        } else if (d.action === 'receiveMyReports') {
            PlayerReports.renderReports(d.data || []);
        } else if (d.action === 'closePlayerReports') {
            var overlay = document.getElementById('pr-overlay');
            if (overlay) overlay.style.display = 'none';
        }
    });
})();
