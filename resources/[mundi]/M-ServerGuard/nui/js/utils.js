var Utils = (function () {
    'use strict';

    var _env = null;

    function detectEnvironment() {
        if (_env) return _env;
        if (typeof GetParentResourceName === 'function') {
            try { GetParentResourceName(); _env = 'nui'; return _env; } catch (e) {}
        }
        _env = 'browser';
        return _env;
    }

    function escapeHtml(str) {
        if (!str) return '';
        var d = document.createElement('div');
        d.appendChild(document.createTextNode(String(str)));
        return d.innerHTML;
    }

    function formatNumber(n) {
        if (n == null) return '0';
        return Number(n).toLocaleString('en-US');
    }

    function formatMoney(n) {
        if (n == null) return '$0';
        return '$' + Number(n).toLocaleString('en-US', { minimumFractionDigits: 2, maximumFractionDigits: 2 });
    }

    function formatDuration(seconds) {
        if (!seconds || seconds <= 0) return '0s';
        var d = Math.floor(seconds / 86400);
        var h = Math.floor((seconds % 86400) / 3600);
        var m = Math.floor((seconds % 3600) / 60);
        var s = Math.floor(seconds % 60);
        var parts = [];
        if (d > 0) parts.push(d + 'd');
        if (h > 0) parts.push(h + 'h');
        if (m > 0) parts.push(m + 'm');
        if (s > 0 || parts.length === 0) parts.push(s + 's');
        return parts.join(' ');
    }

    function formatPlaytime(minutes) {
        if (!minutes || minutes <= 0) return '0m';
        var h = Math.floor(minutes / 60);
        var d = Math.floor(h / 24);
        h = h % 24;
        var m = Math.floor(minutes % 60);
        if (d > 0) return d + 'd ' + h + 'h';
        if (h > 0) return h + 'h ' + m + 'm';
        return m + 'm';
    }

    function formatDate(str) {
        if (!str) return '-';
        var d = new Date(str);
        if (isNaN(d.getTime())) return str;
        return d.toLocaleDateString('en-US', { month: 'short', day: 'numeric', year: 'numeric' }) + ' ' + d.toLocaleTimeString('en-US', { hour: '2-digit', minute: '2-digit' });
    }

    function timeAgo(str) {
        if (!str) return '-';
        var d = new Date(str);
        if (isNaN(d.getTime())) return str;
        var s = Math.floor((Date.now() - d.getTime()) / 1000);
        if (s < 60) return 'just now';
        if (s < 3600) return Math.floor(s / 60) + 'm ago';
        if (s < 86400) return Math.floor(s / 3600) + 'h ago';
        return Math.floor(s / 86400) + 'd ago';
    }

    function severityBadge(sev) {
        var s = (sev || 'info').toLowerCase();
        return '<span class="sev sev-' + escapeHtml(s) + '">' + escapeHtml(s) + '</span>';
    }

    function statusDot(isOnline) {
        return '<span class="st ' + (isOnline ? 'st-online' : 'st-offline') + '"></span>';
    }

    function flagIndicator(flagged) {
        if (!flagged) return '';
        return '<span class="st-flagged">&#9873;</span>';
    }

    function truncate(str, len) {
        if (!str) return '';
        str = String(str);
        return str.length > len ? str.substring(0, len) + '\u2026' : str;
    }

    function padZero(n) { return n < 10 ? '0' + n : String(n); }
function formatTime(str) {
        if (!str) return '-';
        var d = new Date(str);
        if (isNaN(d.getTime())) return String(str);
        var now = new Date();
        var sameDay = d.toDateString() === now.toDateString();
        if (sameDay) {
            return padZero(d.getHours()) + ':' + padZero(d.getMinutes());
        }
        return d.toLocaleDateString('en-US', { month: 'short', day: 'numeric' }) + ' ' +
               padZero(d.getHours()) + ':' + padZero(d.getMinutes());
    }
function renderPagination(containerId, total, perPage, currentPage, onPageChange) {
        var container = document.getElementById(containerId);
        if (!container) return;
        var totalPages = Math.max(1, Math.ceil((total || 0) / (perPage || 25)));
        buildPagination(container, currentPage || 1, totalPages, onPageChange);
    }
function getApiBase() {
        var path = location.pathname;
        // Match /ResourceName, /ResourceName/, /ResourceName/anything
        // Requires no dot in first segment (resource names never have extensions)
        var match = path.match(/^\/([^\/]+)/);
        if (!match || match[1].indexOf('.') !== -1) return '/';
        return '/' + match[1] + '/';
    }

    function nuiCallback(action, data) {
        var liveDot = document.getElementById('live-indicator');
        var hasOverlay = document.querySelector('.loading-overlay');
        if (liveDot && !hasOverlay) liveDot.classList.add('loading');
        return new Promise(function (resolve, reject) {
            var done = function (v) { if (liveDot) liveDot.classList.remove('loading'); resolve(v); };
            var fail = function (e) { if (liveDot) liveDot.classList.remove('loading'); reject(e); };
            if (detectEnvironment() === 'nui') {
                var resource = GetParentResourceName();
                fetch('https://' + resource + '/' + action, {
                    method: 'POST',
                    headers: { 'Content-Type': 'application/json' },
                    body: JSON.stringify(data || {})
                }).then(function (r) {
                    if (!r.ok) { return Promise.reject(new Error('HTTP ' + r.status)); }
                    return r.json();
                }).then(function(result) {
                    if (result && result.action) { window.postMessage(result, '*'); }
                    done(result);
                }).catch(fail);
            } else {
                _browserApiCall(action, data).then(function (result) {
                    if (result && result.action) {
                        window.postMessage(result, '*');
                    }
                    done(result);
                }).catch(fail);
            }
        });
    }

    function _browserApiCall(action, data) {
        var token = localStorage.getItem('mguard_web_token') || '';
        return fetch(getApiBase() + 'api/' + action, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
                'Authorization': 'Bearer ' + token
            },
            body: JSON.stringify(data || {})
        }).then(function (r) {
            if (r.status === 401) {
                localStorage.removeItem('mguard_web_token');
                location.reload();
                return Promise.reject(new Error('Unauthorized'));
            }
            if (!r.ok) {
                return Promise.reject(new Error('HTTP ' + r.status));
            }
            return r.json();
        });
    }

    function validateWebToken(token) {
        var headers = { 'Content-Type': 'application/json' };
        if (token) headers['Authorization'] = 'Bearer ' + token;
        return fetch(getApiBase() + 'api/validateToken', {
            method: 'POST',
            headers: headers,
            body: JSON.stringify({})
        }).then(function (r) {
            if (r.status === 401) return { valid: false, message: 'Invalid or expired token' };
            return r.json().then(function (d) {
                return { valid: true, admin: d.admin, name: d.admin && d.admin.name };
            });
        }).catch(function () {
            return { valid: false, message: 'Connection failed' };
        });
    }
function showToast(msg, type, duration) {
        type = type || 'info';
        duration = duration || 3500;
        var container = document.getElementById('toast-container');
        if (!container) return;

        var icons = { success: '✓', error: '✕', warning: '⚠', info: 'ℹ' };
        var icon = icons[type] || icons.info;

        var el = document.createElement('div');
        el.className = 'toast toast-' + type;
        el.innerHTML =
            '<span class="toast-icon">' + icon + '</span>' +
            '<span class="toast-msg">' + (typeof Utils !== 'undefined' && Utils.escapeHtml ? Utils.escapeHtml(msg) : msg) + '</span>' +
            '<button class="toast-close" title="Dismiss">✕</button>';

        el.querySelector('.toast-close').addEventListener('click', function () {
            el.classList.remove('show');
            setTimeout(function () { if (el.parentNode) el.parentNode.removeChild(el); }, 200);
        });

        container.appendChild(el);
        requestAnimationFrame(function () { el.classList.add('show'); });
        setTimeout(function () {
            el.classList.remove('show');
            setTimeout(function () { if (el.parentNode) el.parentNode.removeChild(el); }, 250);
        }, duration);
    }
function buildPagination(container, currentPage, totalPages, onPageChange) {
        container.innerHTML = '';
        if (totalPages <= 1) return;
        var maxButtons = 7;
        var start = Math.max(1, currentPage - Math.floor(maxButtons / 2));
        var end = Math.min(totalPages, start + maxButtons - 1);
        if (end - start < maxButtons - 1) start = Math.max(1, end - maxButtons + 1);

        if (currentPage > 1) {
            var prev = document.createElement('button');
            prev.className = 'btn btn-muted btn-sm';
            prev.textContent = '<';
            prev.onclick = function () { onPageChange(currentPage - 1); };
            container.appendChild(prev);
        }
        for (var i = start; i <= end; i++) {
            (function (p) {
                var btn = document.createElement('button');
                btn.className = 'btn btn-sm ' + (p === currentPage ? 'btn-accent active' : 'btn-muted');
                btn.textContent = p;
                btn.onclick = function () { onPageChange(p); };
                container.appendChild(btn);
            })(i);
        }
        if (currentPage < totalPages) {
            var next = document.createElement('button');
            next.className = 'btn btn-muted btn-sm';
            next.textContent = '>';
            next.onclick = function () { onPageChange(currentPage + 1); };
            container.appendChild(next);
        }
    }
function drawLineChart(canvasId, labels, datasets, opts) {
        var canvas = document.getElementById(canvasId);
        if (!canvas) return;
        var ctx = canvas.getContext('2d');
        var dpr = window.devicePixelRatio || 1;
        var rect = canvas.parentElement.getBoundingClientRect();
        canvas.width = rect.width * dpr;
        canvas.height = (opts && opts.height ? opts.height : 170) * dpr;
        canvas.style.width = rect.width + 'px';
        canvas.style.height = (opts && opts.height ? opts.height : 170) + 'px';
        ctx.scale(dpr, dpr);
        var w = rect.width, h = opts && opts.height ? opts.height : 170;
        var pad = { top: 10, right: 10, bottom: 28, left: 44 };
        var pw = w - pad.left - pad.right;
        var ph = h - pad.top - pad.bottom;

        // find data range
        var allVals = [];
        datasets.forEach(function (ds) { ds.data.forEach(function (v) { allVals.push(v); }); });
        var maxVal = Math.max.apply(null, allVals);
        if (maxVal <= 0) maxVal = 10;

        ctx.clearRect(0, 0, w, h);

        // grid
        ctx.strokeStyle = '#2a2927';
        ctx.lineWidth = 0.5;
        var gridLines = 4;
        for (var g = 0; g <= gridLines; g++) {
            var gy = pad.top + (ph / gridLines) * g;
            ctx.beginPath(); ctx.moveTo(pad.left, gy); ctx.lineTo(w - pad.right, gy); ctx.stroke();
            ctx.fillStyle = '#8a857c';
            ctx.font = '10px system-ui';
            ctx.textAlign = 'right';
            ctx.fillText(Math.round(maxVal - (maxVal / gridLines) * g), pad.left - 6, gy + 3);
        }

        // x labels
        ctx.fillStyle = '#8a857c';
        ctx.font = '10px system-ui';
        ctx.textAlign = 'center';
        var labelStep = Math.max(1, Math.floor(labels.length / 8));
        for (var l = 0; l < labels.length; l += labelStep) {
            var lx = pad.left + (pw / Math.max(labels.length - 1, 1)) * l;
            ctx.fillText(labels[l], lx, h - 6);
        }

        // collect point hit-boxes for click detection (first dataset only)
        var hitPoints = [];
        var numPts = datasets[0] ? datasets[0].data.length : 0;

        // lines + dots
        datasets.forEach(function (ds) {
            ctx.strokeStyle = ds.color || '#8c2020';
            ctx.lineWidth = 1.5;
            ctx.beginPath();
            for (var i = 0; i < ds.data.length; i++) {
                var x = pad.left + (pw / Math.max(ds.data.length - 1, 1)) * i;
                var y = pad.top + ph - (ds.data[i] / maxVal) * ph;
                if (i === 0) ctx.moveTo(x, y); else ctx.lineTo(x, y);
            }
            ctx.stroke();

            // fill
            if (ds.fill) {
                var lastX = pad.left + pw, lastY = pad.top + ph;
                if (ds.data.length > 0) {
                    lastX = pad.left + (pw / Math.max(ds.data.length - 1, 1)) * (ds.data.length - 1);
                }
                ctx.beginPath();
                for (var i2 = 0; i2 < ds.data.length; i2++) {
                    var fx = pad.left + (pw / Math.max(ds.data.length - 1, 1)) * i2;
                    var fy = pad.top + ph - (ds.data[i2] / maxVal) * ph;
                    if (i2 === 0) ctx.moveTo(fx, fy); else ctx.lineTo(fx, fy);
                }
                ctx.lineTo(lastX, pad.top + ph);
                ctx.lineTo(pad.left, pad.top + ph);
                ctx.closePath();
                ctx.fillStyle = ds.fill;
                ctx.fill();
            }

            // dots (when enabled or when onClick provided)
            if (opts && (opts.dots || opts.onClick)) {
                ctx.fillStyle = ds.color || '#8c2020';
                for (var id = 0; id < ds.data.length; id++) {
                    var dx = pad.left + (pw / Math.max(ds.data.length - 1, 1)) * id;
                    var dy = pad.top + ph - (ds.data[id] / maxVal) * ph;
                    ctx.beginPath();
                    ctx.arc(dx, dy, 3, 0, Math.PI * 2);
                    ctx.fill();
                    // Only collect hit points once (from first dataset)
                    if (ds === datasets[0]) hitPoints.push({ x: dx, y: dy, idx: id });
                }
            }
        });

        // Click handler for interactive charts
        if (opts && typeof opts.onClick === 'function') {
            // Remove old listener if present
            if (canvas._clickHandler) canvas.removeEventListener('click', canvas._clickHandler);
            canvas._clickHandler = function(e) {
                var r = canvas.getBoundingClientRect();
                var mx = e.clientX - r.left;
                var my = e.clientY - r.top;
                var best = null, bestDist = 20; // px threshold
                hitPoints.forEach(function(pt) {
                    var dist = Math.sqrt((mx - pt.x) * (mx - pt.x) + (my - pt.y) * (my - pt.y));
                    if (dist < bestDist) { bestDist = dist; best = pt; }
                });
                if (best !== null) opts.onClick(best.idx);
            };
            canvas.addEventListener('click', canvas._clickHandler);
        }
    }
function drawBarChart(canvasId, items, opts) {
        var canvas = document.getElementById(canvasId);
        if (!canvas) return;
        var ctx = canvas.getContext('2d');
        var dpr = window.devicePixelRatio || 1;
        var rect = canvas.parentElement.getBoundingClientRect();
        var h = opts && opts.height ? opts.height : 170;
        canvas.width = rect.width * dpr;
        canvas.height = h * dpr;
        canvas.style.width = rect.width + 'px';
        canvas.style.height = h + 'px';
        ctx.scale(dpr, dpr);
        var w = rect.width;
        var pad = { top: 10, right: 10, bottom: 40, left: 44 };
        var pw = w - pad.left - pad.right;
        var ph = h - pad.top - pad.bottom;
        var maxVal = Math.max.apply(null, items.map(function (it) { return it.value; }));
        if (maxVal <= 0) maxVal = 10;
        ctx.clearRect(0, 0, w, h);

        var barW = Math.min(30, pw / items.length - 4);
        var gap = (pw - barW * items.length) / (items.length + 1);

        ctx.fillStyle = '#8a857c'; ctx.font = '10px system-ui'; ctx.textAlign = 'center';
        items.forEach(function (it, i) {
            var x = pad.left + gap + (barW + gap) * i;
            var bh = (it.value / maxVal) * ph;
            ctx.fillStyle = it.color || '#8c2020';
            ctx.fillRect(x, pad.top + ph - bh, barW, bh);
            ctx.fillStyle = '#8a857c';
            ctx.save();
            ctx.translate(x + barW / 2, h - 4);
            ctx.rotate(-0.5);
            ctx.fillText(Utils.truncate(it.label, 10), 0, 0);
            ctx.restore();
        });
    }

    function debounce(fn, delay) {
        var t;
        return function() {
            var args = arguments, ctx = this;
            clearTimeout(t);
            t = setTimeout(function() { fn.apply(ctx, args); }, delay || 300);
        };
    }

    function normalizePlayerList(data) {
        if (!data) return [];
        if (Array.isArray(data)) return data;
        if (Array.isArray(data.players)) return data.players;
        return [];
    }

    function findPlayerByServerId(data, serverId) {
        if (serverId == null || serverId === '') return null;
        var players = normalizePlayerList(data);
        for (var i = 0; i < players.length; i++) {
            var player = players[i] || {};
            var candidate = player.serverId;
            if (candidate == null || candidate === '') candidate = player.server_id;
            if (candidate == null || candidate === '') candidate = player.id;
            if (String(candidate) === String(serverId)) return player;
        }
        return null;
    }

    // RDR3 weapon hash → human-readable name lookup (computed from JOAAT hashes)
    var WEAPON_HASH_NAMES = {
        '34411519': 'Volcanic Pistol',
        '1534638301': 'M1899 Pistol',
        '1701864918': 'Semi-Auto Pistol',
        '-2055158210': 'Mauser Pistol',
        '379542007': 'Cattleman Revolver',
        '127400949': 'Double-Action Revolver',
        '-2082646505': 'Gambler Revolver',
        '2075992054': 'Schofield Revolver',
        '1529685685': 'LeMat Revolver',
        '-183018591': 'Carbine Repeater',
        '-1783478894': 'Henry Repeater',
        '1905553950': 'Evans Repeater',
        '-1471716628': 'Winchester Repeater',
        '1676963302': 'Springfield Rifle',
        '1999408598': 'Bolt-Action Rifle',
        '-570967010': 'Varmint Rifle',
        '834124286': 'Pump-Action Shotgun',
        '392538360': 'Sawed-Off Shotgun',
        '1838922096': 'Semi-Auto Shotgun',
        '1674213418': 'Repeating Shotgun',
        '1845102363': 'Double Barrel Shotgun',
        '-506285289': 'Rolling Block Rifle',
        '1402226560': 'Carcano Rifle',
        '-618550132': 'Hunting Knife',
        '277270593': 'Jawbone Knife',
        '680856689': 'Machete',
        '165751297': 'Hatchet',
        '1742487518': 'Torch',
        '-281894307': 'Cleaver',
        '-1504859554': 'Dynamite',
        '1885857703': 'Fire Bottle',
        '-764310200': 'Throwing Knife',
        '-1511427369': 'Tomahawk',
        '2055893578': 'Lasso',
        '-2002235300': 'Bow',
        '-842959696': 'Fall Damage',
        '-10959621': 'Drowning',
        '-1955384325': 'Bleeding Out',
        '-544306709': 'Fire',
        '2118104596': 'Fists',
    };

    function resolveWeaponHash(hash) {
        if (!hash && hash !== 0) return null;
        var key = String(hash);
        if (WEAPON_HASH_NAMES[key]) return WEAPON_HASH_NAMES[key];
        // Try unsigned interpretation
        var unsigned = (hash >>> 0).toString();
        if (WEAPON_HASH_NAMES[unsigned]) return WEAPON_HASH_NAMES[unsigned];
        return null;
    }

    function copyToClipboard(text, label) {
        if (!text || text === '-') { showToast('Nothing to copy', 'error'); return; }
        if (navigator.clipboard && navigator.clipboard.writeText) {
            navigator.clipboard.writeText(text).then(function () {
                showToast((label || 'Value') + ' copied', 'success', 1800);
            }).catch(function () { _fallbackCopy(text, label); });
        } else { _fallbackCopy(text, label); }
    }

    function _fallbackCopy(text, label) {
        var ta = document.createElement('textarea');
        ta.value = text; ta.style.cssText = 'position:fixed;opacity:0;top:0;left:0';
        document.body.appendChild(ta); ta.focus(); ta.select();
        try {
            document.execCommand('copy');
            showToast((label || 'Value') + ' copied', 'success', 1800);
        } catch (e) { showToast('Copy failed — select manually', 'error'); }
        document.body.removeChild(ta);
    }

    return {
        detectEnvironment: detectEnvironment,
        escapeHtml: escapeHtml,
        escHtml: escapeHtml,
        formatNumber: formatNumber,
        formatMoney: formatMoney,
        formatDuration: formatDuration,
        formatPlaytime: formatPlaytime,
        formatDate: formatDate,
        timeAgo: timeAgo,
        severityBadge: severityBadge,
        statusDot: statusDot,
        flagIndicator: flagIndicator,
        truncate: truncate,
        padZero: padZero,
        getApiBase: getApiBase,
        nuiCallback: nuiCallback,
        validateWebToken: validateWebToken,
        showToast: showToast,
        buildPagination: buildPagination,
        renderPagination: renderPagination,
        drawLineChart: drawLineChart,
        drawBarChart: drawBarChart,
        formatTime: formatTime,
        debounce: debounce,
        normalizePlayerList: normalizePlayerList,
        findPlayerByServerId: findPlayerByServerId,
        copyToClipboard: copyToClipboard,
        resolveWeaponHash: resolveWeaponHash,
    };
})();
