(function () {
    'use strict';

    var app = document.getElementById('derby-app');
    var closeBtn = document.getElementById('derby-close');
    var navBtns = document.querySelectorAll('.derby-nav');
    var panelCareer = document.getElementById('panel-career');
    var panelHallOfFame = document.getElementById('panel-halloffame');
    var panelEvents = document.getElementById('panel-events');
    var panelGuide = document.getElementById('panel-guide');
    var racesList = document.getElementById('races-list');
    var racesEmpty = document.getElementById('races-empty');
    var btnRefreshRaces = document.getElementById('btn-refresh-races');
    var btnRefreshCareer = document.getElementById('btn-refresh-career');
    var btnRefreshHallOfFame = document.getElementById('btn-refresh-halloffame');
    var hofList = document.getElementById('derby-hof-list');
    var hofEmpty = document.getElementById('derby-hof-empty');
    var toastEl = document.getElementById('derby-toast');
    var horseCanvas = document.getElementById('derby-horse-canvas');
    var horseCtx = horseCanvas && horseCanvas.getContext('2d');
    var horseRafId = 0;
    var horseResizeObs = null;
    var horseShellRef = null;
    var raceHud = document.getElementById('derby-race-hud');
    var raceHudNum = document.getElementById('derby-race-hud-num');
    var raceHudSub = document.getElementById('derby-race-hud-sub');

    var panelPlayerEvents = document.getElementById('panel-playerevents');
    var playerRoutesGrid = document.getElementById('player-routes-grid');
    var playerRoutesEmpty = document.getElementById('player-routes-empty');
    var btnRefreshPlayerRoutes = document.getElementById('btn-refresh-player-routes');

    var editorEl = document.getElementById('derby-editor');
    var editorClose = document.getElementById('derby-editor-close');
    var editorTitle = document.getElementById('editor-title');
    var editorDesc = document.getElementById('editor-desc');
    var editorRegion = document.getElementById('editor-region');
    var editorSurface = document.getElementById('editor-surface');
    var editorLoop = document.getElementById('editor-loop');
    var editorMinPlayers = document.getElementById('editor-min-players');
    var editorMaxPlayers = document.getElementById('editor-max-players');
    var editorCpCount = document.getElementById('editor-cp-count');
    var editorCpList = document.getElementById('editor-cp-list');
    var editorCpEmpty = document.getElementById('editor-cp-empty');
    var editorPreviewFrame = document.getElementById('editor-preview-frame');
    var editorBtnClear = document.getElementById('editor-btn-clear');
    var editorBtnCancel = document.getElementById('editor-btn-cancel');
    var editorBtnSave = document.getElementById('editor-btn-save');
    var editorAiEnabled = document.getElementById('editor-ai-enabled');
    var editorAiCount = document.getElementById('editor-ai-count');
    var editorAiCountWrap = document.getElementById('editor-ai-count-wrap');

    var editorCheckpoints = [];

    var el = {
        name: document.getElementById('career-name'),
        title: document.getElementById('career-title'),
        wins: document.getElementById('career-wins'),
        entries: document.getElementById('career-entries'),
        rep: document.getElementById('career-rep'),
    };

    var catalogRoutes = [];
    var playerRoutes = [];
    /** Disables Host / Start / Join while a race session is active (Lua sends derbyBusy / setDerbyBusy). */
    var derbyUiBusy = false;

    function applyDerbyUiBusy(busy) {
        derbyUiBusy = !!busy;
        document.querySelectorAll('.derby-race-join, .derby-catalog-host, .derby-player-route-start').forEach(function (btn) {
            btn.disabled = derbyUiBusy;
            btn.classList.toggle('derby-btn--busy-lock', derbyUiBusy);
        });
    }

    function resourceName() {
        if (typeof GetParentResourceName === 'function') {
            return GetParentResourceName();
        }
        return 'dodi_derbyhorse';
    }

    function post(name, data) {
        return fetch('https://' + resourceName() + '/' + name, {
            method: 'POST',
            headers: { 'Content-Type': 'application/json; charset=UTF-8' },
            body: JSON.stringify(data || {}),
        });
    }

    function showApp(show) {
        if (!app) return;
        app.classList.toggle('hidden', !show);
        app.setAttribute('aria-hidden', show ? 'false' : 'true');
    }

    function stopHorseBg() {
        if (horseRafId) {
            cancelAnimationFrame(horseRafId);
            horseRafId = 0;
        }
        if (horseResizeObs && horseShellRef) {
            horseResizeObs.disconnect();
            horseResizeObs = null;
        }
        horseShellRef = null;
        if (horseCtx && horseCanvas) {
            horseCtx.setTransform(1, 0, 0, 1, 0, 0);
            horseCtx.clearRect(0, 0, horseCanvas.width, horseCanvas.height);
        }
    }

    function drawHorseProgress(ctx, cssW, cssH, xy, endIdx, neonPulse, padOverride) {
        if (!ctx || !xy || xy.length < 4) return;
        if (cssW < 12 || cssH < 12) return;
        var pulse = neonPulse == null ? 1 : neonPulse;
        if (pulse < 0.15) pulse = 0.15;
        var pad = padOverride != null ? padOverride : 28;
        var minX = Infinity;
        var minY = Infinity;
        var maxX = -Infinity;
        var maxY = -Infinity;
        var p;
        for (p = 0; p < xy.length; p += 2) {
            var px = xy[p] * 0.5;
            var py = xy[p + 1] * 0.5;
            if (px < minX) minX = px;
            if (py < minY) minY = py;
            if (px > maxX) maxX = px;
            if (py > maxY) maxY = py;
        }
        var pathW = maxX - minX;
        var pathH = maxY - minY;
        if (pathW < 1) pathW = 1;
        if (pathH < 1) pathH = 1;
        var scale = Math.min((cssW - pad * 2) / pathW, (cssH - pad * 2) / pathH);
        if (!isFinite(scale) || scale <= 0) return;
        var ox = (cssW - pathW * scale) * 0.5 - minX * scale;
        var oy = (cssH - pathH * scale) * 0.5 - minY * scale;
        ctx.clearRect(0, 0, cssW, cssH);
        ctx.save();
        ctx.translate(ox, oy);
        ctx.scale(scale, scale);
        var j;
        var last = Math.min(endIdx, Math.floor(xy.length / 2) - 1);
        var hair = Math.max(0.55, 1.0 / scale);
        /* Neon: red/pink halos + bright core; pulse modulates glow (no shadowBlur in CEF) */
        var g = pulse;
        var passes = [
            { w: hair * 5.5, c: 'rgba(194, 30, 45, ' + (0.2 * g).toFixed(3) + ')' },
            { w: hair * 3.2, c: 'rgba(220, 60, 70, ' + (0.14 * g).toFixed(3) + ')' },
            { w: hair * 1.85, c: 'rgba(255, 160, 165, ' + (0.22 * g).toFixed(3) + ')' },
            { w: hair * 1.05, c: 'rgba(255, 245, 245, ' + (0.38 + 0.22 * g).toFixed(3) + ')' },
        ];
        var pi;
        for (pi = 0; pi < passes.length; pi++) {
            ctx.beginPath();
            ctx.moveTo(xy[0] * 0.5, xy[1] * 0.5);
            for (j = 1; j <= last; j++) {
                ctx.lineTo(xy[j * 2] * 0.5, xy[j * 2 + 1] * 0.5);
            }
            ctx.lineCap = 'round';
            ctx.lineJoin = 'round';
            ctx.lineWidth = passes[pi].w;
            ctx.strokeStyle = passes[pi].c;
            ctx.stroke();
        }
        ctx.restore();
    }

    var HORSE_ICON_PAD = 2;

    function paintHorseLineIcons() {
        var xy = window.DERBY_HORSE_LINE;
        if (!xy || xy.length < 4) return;
        var nodes = document.querySelectorAll('.derby-horse-line-icon');
        if (!nodes.length) return;
        var maxIdx = Math.floor(xy.length / 2) - 1;
        var i;
        for (i = 0; i < nodes.length; i++) {
            var canvas = nodes[i];
            var ctx = canvas.getContext('2d');
            if (!ctx) continue;
            var rect = canvas.getBoundingClientRect();
            var fbW = parseInt(canvas.getAttribute('data-css-w'), 10);
            var fbH = parseInt(canvas.getAttribute('data-css-h'), 10);
            if (!isFinite(fbW) || fbW < 8) fbW = 36;
            if (!isFinite(fbH) || fbH < 8) fbH = 36;
            var cssW = Math.max(12, Math.round(rect.width) || fbW);
            var cssH = Math.max(12, Math.round(rect.height) || fbH);
            var dpr = Math.min(window.devicePixelRatio || 1, 2);
            canvas.width = Math.max(1, Math.floor(cssW * dpr));
            canvas.height = Math.max(1, Math.floor(cssH * dpr));
            ctx.setTransform(dpr, 0, 0, dpr, 0, 0);
            drawHorseProgress(ctx, cssW, cssH, xy, maxIdx, 1, HORSE_ICON_PAD);
        }
    }

    function startHorseBg() {
        stopHorseBg();
        var xy = window.DERBY_HORSE_LINE;
        if (!horseCanvas || !horseCtx || !xy || xy.length < 4) return;
        horseShellRef = document.querySelector('.derby-shell');
        if (!horseShellRef) return;

        function syncCanvasSize() {
            var w = horseShellRef.clientWidth || 1;
            var h = horseShellRef.clientHeight || 1;
            var dpr = Math.min(window.devicePixelRatio || 1, 2);
            horseCanvas.width = Math.max(1, Math.floor(w * dpr));
            horseCanvas.height = Math.max(1, Math.floor(h * dpr));
            horseCanvas.style.width = w + 'px';
            horseCanvas.style.height = h + 'px';
            horseCtx.setTransform(dpr, 0, 0, dpr, 0, 0);
        }

        syncCanvasSize();
        if (typeof ResizeObserver !== 'undefined') {
            horseResizeObs = new ResizeObserver(function () {
                syncCanvasSize();
            });
            horseResizeObs.observe(horseShellRef);
        }

        var maxIdx = Math.floor(xy.length / 2) - 1;
        var DRAW_MS = 8500;
        var vertexProgress = 0;
        var lastTickMs = performance.now();

        function tick() {
            horseRafId = requestAnimationFrame(tick);
            var now = performance.now();
            var dt = (now - lastTickMs) / 1000;
            lastTickMs = now;
            if (dt > 0.12) dt = 0.12;

            var cw = horseShellRef.clientWidth || 1;
            var ch = horseShellRef.clientHeight || 1;

            if (vertexProgress < maxIdx) {
                vertexProgress += (maxIdx / (DRAW_MS / 1000)) * dt;
                if (vertexProgress > maxIdx) vertexProgress = maxIdx;
            }

            var endIdx = Math.floor(vertexProgress);
            var neonPulse = 1;
            if (vertexProgress >= maxIdx) {
                neonPulse = 0.72 + 0.28 * Math.sin(now * 0.0024);
            }

            drawHorseProgress(horseCtx, cw, ch, xy, endIdx, neonPulse);
        }

        horseRafId = requestAnimationFrame(tick);
    }

    function setPanel(name) {
        navBtns.forEach(function (b) {
            b.classList.toggle('is-active', b.getAttribute('data-panel') === name);
        });
        panelCareer.classList.toggle('is-visible', name === 'career');
        if (panelHallOfFame) panelHallOfFame.classList.toggle('is-visible', name === 'halloffame');
        panelEvents.classList.toggle('is-visible', name === 'events');
        panelGuide.classList.toggle('is-visible', name === 'guide');
        if (panelPlayerEvents) panelPlayerEvents.classList.toggle('is-visible', name === 'playerevents');
    }

    function applyCareer(c) {
        if (!c || typeof c !== 'object') return;
        el.name.textContent = c.displayName != null ? String(c.displayName) : '—';
        el.title.textContent = c.title != null ? String(c.title) : '—';
        el.wins.textContent = c.wins != null ? String(c.wins) : '0';
        el.entries.textContent = c.entries != null ? String(c.entries) : '0';
        el.rep.textContent = c.reputation != null ? String(c.reputation) : '0';
    }

    function applyHallOfFame(hall) {
        if (!hofList || !hofEmpty) return;
        var entries = hall && Array.isArray(hall.entries) ? hall.entries : [];
        hofList.innerHTML = '';
        if (entries.length === 0) {
            hofEmpty.classList.remove('hidden');
            return;
        }
        hofEmpty.classList.add('hidden');
        var medals = ['derby-hof-rank--gold', 'derby-hof-rank--silver', 'derby-hof-rank--bronze'];
        entries.forEach(function (e) {
            var li = document.createElement('li');
            li.className = 'derby-hof-row';
            var rk = e.rank != null ? Number(e.rank) : 0;
            var mc = rk >= 1 && rk <= 3 ? medals[rk - 1] : '';
            var name = e.displayName != null ? String(e.displayName) : '—';
            var title = e.title != null ? String(e.title) : '—';
            var w = e.wins != null ? String(e.wins) : '0';
            var st = e.starts != null ? String(e.starts) : '0';
            var rep = e.reputation != null ? String(e.reputation) : '0';
            var esc = function (s) {
                return String(s)
                    .replace(/&/g, '&amp;')
                    .replace(/</g, '&lt;')
                    .replace(/"/g, '&quot;');
            };
            var nameEsc = esc(name);
            var titleEsc = esc(title);
            li.innerHTML =
                '<span class="derby-hof-rank ' +
                mc +
                '">' +
                rk +
                '</span>' +
                '<span class="derby-hof-name" title="' +
                nameEsc +
                '">' +
                nameEsc +
                '</span>' +
                '<span class="derby-hof-title">' +
                titleEsc +
                '</span>' +
                '<span class="derby-hof-num">' +
                w +
                '</span>' +
                '<span class="derby-hof-num">' +
                st +
                '</span>' +
                '<span class="derby-hof-rep">' +
                rep +
                '</span>';
            hofList.appendChild(li);
        });
    }

    function stateLabel(s) {
        var m = { lobby: 'Lobby open', running: 'Under orders', ended: 'Weighed in' };
        return m[s] || (s ? String(s) : '—');
    }

    function safeSuffix(s) {
        return String(s || 'x').replace(/[^a-zA-Z0-9_]/g, '_').slice(0, 48);
    }

    function checkpointsFromRace(r) {
        if (r && Array.isArray(r.checkpoints) && r.checkpoints.length > 0) {
            return r.checkpoints;
        }
        if (r && r.routeId) {
            for (var i = 0; i < catalogRoutes.length; i++) {
                if (catalogRoutes[i].id === r.routeId && catalogRoutes[i].checkpoints) {
                    return catalogRoutes[i].checkpoints;
                }
            }
        }
        return [];
    }

    function closedLoopForCatalogRoute(routeId) {
        if (!routeId) return false;
        for (var i = 0; i < catalogRoutes.length; i++) {
            if (catalogRoutes[i].id === routeId) {
                return catalogRoutes[i].closedLoop === true;
            }
        }
        return false;
    }

    function closedLoopForRace(r) {
        if (r && typeof r.closedLoop === 'boolean') {
            return r.closedLoop;
        }
        if (r && r.routeId) {
            return closedLoopForCatalogRoute(r.routeId);
        }
        return false;
    }

    function buildRoutePreviewSVG(checkpoints, w, h, suffix, opts) {
        w = w || 360;
        h = h || 200;
        suffix = safeSuffix(suffix);
        opts = opts || {};
        var closedLoop = opts.closedLoop === true;
        if (!checkpoints || checkpoints.length < 2) {
            return '<div class="derby-route-empty">No programme chart for this entry.</div>';
        }
        var pts = checkpoints.map(function (p) {
            return { x: Number(p.x), y: Number(p.y) };
        });
        var xs = pts.map(function (p) {
            return p.x;
        });
        var ys = pts.map(function (p) {
            return p.y;
        });
        var minX = Math.min.apply(null, xs);
        var maxX = Math.max.apply(null, xs);
        var minY = Math.min.apply(null, ys);
        var maxY = Math.max.apply(null, ys);
        var dx = Math.max(maxX - minX, 1);
        var dy = Math.max(maxY - minY, 1);
        var pad = Math.max(dx, dy) * 0.16;
        minX -= pad;
        maxX += pad;
        minY -= pad;
        maxY += pad;
        var rw = maxX - minX;
        var rh = maxY - minY;

        /* Pixel gutters inside viewBox so labels (Start/Finish) and 6px nodes are not clipped */
        var gL = Math.min(44, w * 0.12);
        var gR = Math.min(56, w * 0.16);
        var gT = Math.min(18, h * 0.1);
        var gB = Math.min(18, h * 0.1);
        var iw = Math.max(w - gL - gR, 1);
        var ih = Math.max(h - gT - gB, 1);

        function tx(px, py) {
            return {
                x: gL + ((px - minX) / rw) * iw,
                y: gT + ih - ((py - minY) / rh) * ih,
            };
        }

        var d = '';
        pts.forEach(function (p, i) {
            var q = tx(p.x, p.y);
            d += (i === 0 ? 'M' : 'L') + q.x.toFixed(2) + ' ' + q.y.toFixed(2) + ' ';
        });
        /* Closing segment only for true circuits (config closedLoop). Point-to-point: no line back to start. */
        if (closedLoop && pts.length > 2) {
            var q0 = tx(pts[0].x, pts[0].y);
            d += 'L' + q0.x.toFixed(2) + ' ' + q0.y.toFixed(2);
        }

        var last = pts.length - 1;
        var qFirst = tx(pts[0].x, pts[0].y);
        var qLast = tx(pts[last].x, pts[last].y);
        var worldEps = 0.85;
        var sameWorld =
            last >= 1 &&
            Math.abs(pts[0].x - pts[last].x) < worldEps &&
            Math.abs(pts[0].y - pts[last].y) < worldEps;
        var pxDist = Math.hypot(qFirst.x - qLast.x, qFirst.y - qLast.y);
        var mergeStartFinish = sameWorld || (last >= 1 && pxDist < 14);

        var markers = '';
        var labels = '';
        pts.forEach(function (p, i) {
            var q = tx(p.x, p.y);
            if (mergeStartFinish) {
                if (i === 0) {
                    markers +=
                        '<circle class="cp-start cp-start-finish-merge" cx="' +
                        q.x.toFixed(2) +
                        '" cy="' +
                        q.y.toFixed(2) +
                        '" r="6"/>';
                    labels +=
                        '<text class="derby-route-tag" x="' +
                        (q.x + 8).toFixed(2) +
                        '" y="' +
                        (q.y + 4).toFixed(2) +
                        '"><tspan x="' +
                        (q.x + 8).toFixed(2) +
                        '" dy="0">Start</tspan><tspan x="' +
                        (q.x + 8).toFixed(2) +
                        '" dy="13">Finish</tspan></text>';
                } else if (i === last) {
                    /* same grid cell as start — skip duplicate node/label */
                } else {
                    markers +=
                        '<circle class="cp-mid derby-route-cp-disc" cx="' +
                        q.x.toFixed(2) +
                        '" cy="' +
                        q.y.toFixed(2) +
                        '" r="4.2"/>';
                }
            } else if (i === 0) {
                markers +=
                    '<circle class="cp-start" cx="' +
                    q.x.toFixed(2) +
                    '" cy="' +
                    q.y.toFixed(2) +
                    '" r="6"/>';
                labels +=
                    '<text class="derby-route-tag" x="' +
                    (q.x + 8).toFixed(2) +
                    '" y="' +
                    (q.y + 4).toFixed(2) +
                    '">Start</text>';
            } else if (i === last) {
                markers +=
                    '<circle class="cp-finish" cx="' +
                    q.x.toFixed(2) +
                    '" cy="' +
                    q.y.toFixed(2) +
                    '" r="6"/>';
                labels +=
                    '<text class="derby-route-tag" x="' +
                    (q.x + 8).toFixed(2) +
                    '" y="' +
                    (q.y + 4).toFixed(2) +
                    '">Finish</text>';
            } else {
                markers +=
                    '<circle class="cp-mid derby-route-cp-disc" cx="' +
                    q.x.toFixed(2) +
                    '" cy="' +
                    q.y.toFixed(2) +
                    '" r="4.2"/>';
            }
        });

        var motionPathId = 'rt-mot-' + suffix;
        var horseW = 30;
        var horseH = 30;
        var hhx = (-horseW / 2).toFixed(2);
        var hhy = (-horseH / 2).toFixed(2);
        var loneHorse =
            '<g class="derby-route-horse-rider" aria-hidden="true" focusable="false">' +
            '<image class="derby-route-horse-img" href="horse-marker.svg" xlink:href="horse-marker.svg" x="' +
            hhx +
            '" y="' +
            hhy +
            '" width="' +
            horseW +
            '" height="' +
            horseH +
            '" preserveAspectRatio="xMidYMid meet"/>' +
            '</g>';

        var gridId = 'grid-' + suffix;
        var gradId = 'turf-' + suffix;

        return (
            '<svg class="derby-route-svg" data-route-closed="' +
            (closedLoop ? '1' : '0') +
            '" viewBox="0 0 ' +
            w +
            ' ' +
            h +
            '" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" role="img" aria-label="Course trace">' +
            '<defs>' +
            '<linearGradient id="' +
            gradId +
            '" x1="0" y1="1" x2="1" y2="0">' +
            '<stop offset="0%" stop-color="#0a0a0a"/>' +
            '<stop offset="100%" stop-color="#141414"/></linearGradient>' +
            '<pattern id="' +
            gridId +
            '" width="32" height="32" patternUnits="userSpaceOnUse">' +
            '<path d="M 32 0 L 0 0 0 32" fill="none" stroke="#ffffff" stroke-opacity="0.04" stroke-width="1"/></pattern>' +
            '</defs>' +
            '<rect width="100%" height="100%" fill="url(#' +
            gradId +
            ')"/>' +
            '<rect width="100%" height="100%" fill="url(#' +
            gridId +
            ')"/>' +
            '<path id="' +
            motionPathId +
            '" class="derby-route-motion-path" d="' +
            d +
            '" fill="none" stroke="none" pointer-events="none"/>' +
            '<path class="derby-route-path" d="' +
            d +
            '"/>' +
            '<path class="derby-route-path-inner" d="' +
            d +
            '"/>' +
            markers +
            labels +
            loneHorse +
            '</svg>'
        );
    }

    var ROUTE_HORSE_LEAN_DEG = 26;

    function bindRouteHorseMotion(svg) {
        if (!svg || svg.getAttribute('data-horse-motion') === '1') return;
        var motionPath = svg.querySelector('.derby-route-motion-path');
        var rider = svg.querySelector('.derby-route-horse-rider');
        if (!motionPath || !rider) return;
        var pathLen = motionPath.getTotalLength();
        if (!isFinite(pathLen) || pathLen < 8) return;
        svg.setAttribute('data-horse-motion', '1');
        var routeClosed = svg.getAttribute('data-route-closed') === '1';
        var travelMs = Math.min(22000, Math.max(7500, pathLen * 42));
        /* Random start position along path; t0 in the past so (now - t0) is never stuck negative */
        var t0 = performance.now() - Math.random() * travelMs;
        var prevHorseAng = null;

        function applyFrame(now) {
            var u = ((((now - t0) % travelMs) + travelMs) % travelMs) / travelMs;
            var dist = u * pathLen;
            var eps = Math.max(2, pathLen * 0.004);
            var p = motionPath.getPointAtLength(dist);
            var angRad;
            if (routeClosed) {
                var d2 = dist + eps;
                if (d2 >= pathLen) d2 -= pathLen;
                var p2 = motionPath.getPointAtLength(d2);
                angRad = Math.atan2(p2.y - p.y, p2.x - p.x);
            } else if (dist + eps < pathLen - 0.001) {
                var pF = motionPath.getPointAtLength(dist + eps);
                angRad = Math.atan2(pF.y - p.y, pF.x - p.x);
            } else {
                var pB = motionPath.getPointAtLength(Math.max(0, dist - eps));
                angRad = Math.atan2(p.y - pB.y, p.x - pB.x);
            }
            var rawDeg = (angRad * 180) / Math.PI;
            var goingLeft = rawDeg > 90 || rawDeg < -90;
            var flipY = goingLeft ? -1 : 1;
            var ang = rawDeg + (goingLeft ? -ROUTE_HORSE_LEAN_DEG : ROUTE_HORSE_LEAN_DEG);
            if (prevHorseAng != null) {
                while (ang - prevHorseAng > 180) ang -= 360;
                while (prevHorseAng - ang > 180) ang += 360;
            }
            prevHorseAng = ang;
            rider.setAttribute(
                'transform',
                'translate(' + p.x.toFixed(3) + ',' + p.y.toFixed(3) + ') rotate(' + ang.toFixed(2) + ') scale(1,' + flipY + ')'
            );
        }

        function tick(now) {
            if (!svg.isConnected) return;
            requestAnimationFrame(tick);
            applyFrame(now);
        }
        applyFrame(performance.now());
        requestAnimationFrame(tick);
    }

    function showToast(msg, isErr) {
        if (!toastEl) return;
        toastEl.textContent = msg || '';
        toastEl.classList.toggle('hidden', !msg);
        toastEl.classList.toggle('derby-toast--err', !!isErr);
        if (msg) {
            window.clearTimeout(showToast._t);
            showToast._t = window.setTimeout(function () {
                toastEl.classList.add('hidden');
            }, 4200);
        }
    }

    function segmentLength3D(a, b) {
        var dx = Number(b.x) - Number(a.x);
        var dy = Number(b.y) - Number(a.y);
        var dz = Number(b.z) - Number(a.z);
        return Math.sqrt(dx * dx + dy * dy + dz * dz);
    }

    /** World units treated as metres (RAGE); sum of segments, optional closing edge for circuits. */
    function computeRouteLengthKm(checkpoints, closedLoop) {
        if (!Array.isArray(checkpoints) || checkpoints.length < 2) {
            return 0;
        }
        var m = 0;
        var i;
        for (i = 0; i < checkpoints.length - 1; i++) {
            m += segmentLength3D(checkpoints[i], checkpoints[i + 1]);
        }
        if (closedLoop && checkpoints.length > 2) {
            m += segmentLength3D(checkpoints[checkpoints.length - 1], checkpoints[0]);
        }
        return m / 1000;
    }

    function resolveCourseKm(course) {
        var auto = computeRouteLengthKm(course.checkpoints, course.closedLoop === true);
        var manual =
            course.distanceKm != null && course.distanceKm !== ''
                ? Number(course.distanceKm)
                : NaN;
        /* Default: auto from coordinates. Set distanceKm in catalog only to override (e.g. official steward distance). */
        if (isFinite(manual) && manual > 0) {
            return manual;
        }
        if (auto > 0) {
            return auto;
        }
        if (course.distanceYd != null && course.distanceYd !== '') {
            return (Number(course.distanceYd) * 0.9144) / 1000;
        }
        return 0;
    }

    function formatCourseDistanceKm(course) {
        var km = resolveCourseKm(course);
        if (!isFinite(km) || km <= 0) {
            return '';
        }
        var s = km.toFixed(2).replace(/\.?0+$/, '');
        return s + ' km · ';
    }

    function renderRaces(races) {
        racesList.innerHTML = '';
        if (!Array.isArray(races) || races.length === 0) {
            racesEmpty.classList.remove('hidden');
            applyDerbyUiBusy(derbyUiBusy);
            return;
        }
        racesEmpty.classList.add('hidden');
        races.forEach(function (r, idx) {
            var li = document.createElement('li');
            li.className = 'derby-race-item derby-race-card';
            var maxP = r.maxPlayers != null ? r.maxPlayers : '—';
            var pl = r.players != null ? r.players : '0';
            var host = r.host != null ? r.host : '—';
            var st = r.state || 'lobby';
            var routeTitle = r.routeName || r.routeId || 'Course TBA';
            var cps = checkpointsFromRace(r);
            var starts =
                r.startsInSec != null && r.startsInSec !== ''
                    ? 'Estimated post: ' + formatCountdown(r.startsInSec)
                    : 'Post time: at steward’s call';

            li.innerHTML =
                '<div class="derby-race-row">' +
                '<span class="derby-ico-wrap derby-ico-wrap--race" aria-hidden="true">' +
                '<svg class="derby-ico" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink">' +
                '<use xlink:href="#ico-finish" href="#ico-finish"/></svg></span>' +
                '<div class="derby-race-meta">' +
                '<p class="derby-race-name"></p>' +
                '<p class="derby-race-sub"></p>' +
                '<p class="derby-race-route"></p>' +
                '<span class="derby-badge state-lobby"></span>' +
                '</div>' +
                '<button type="button" class="derby-btn derby-btn-sm derby-club-btn derby-race-join">Join lobby</button>' +
                '</div>' +
                '<div class="derby-race-split">' +
                '<div class="derby-route-frame derby-route-frame--inline"></div>' +
                '<div class="derby-race-notes">' +
                '<p class="derby-note derby-note--hint"></p>' +
                '<p class="derby-note derby-note--gps"></p>' +
                '<p class="derby-note derby-note--time"></p>' +
                '</div>' +
                '</div>';

            li.querySelector('.derby-race-name').textContent = r.name || 'Unnamed fixture';
            li.querySelector('.derby-race-sub').textContent =
                'Steward: ' + host + ' · Field ' + pl + '/' + maxP + ' riders';
            li.querySelector('.derby-race-route').textContent = 'Programme: ' + routeTitle;
            var badge = li.querySelector('.derby-badge');
            badge.textContent = stateLabel(st);
            badge.classList.toggle('state-lobby', st === 'lobby');
            badge.classList.toggle('state-running', st === 'running');

            var hint = li.querySelector('.derby-note--hint');
            var gps = li.querySelector('.derby-note--gps');
            var time = li.querySelector('.derby-note--time');
            hint.textContent = r.joinHint || 'Join to reserve a saddle. Steward controls the start.';
            gps.textContent =
                r.gpsNote ||
                'When the lobby closes, follow the marked path in the same order as this programme.';
            time.textContent = starts;

            var frame = li.querySelector('.derby-route-frame--inline');
            frame.innerHTML = buildRoutePreviewSVG(cps, 340, 190, 'evt-' + (r.id || 'x') + '_' + idx, {
                closedLoop: closedLoopForRace(r),
            });
            bindRouteHorseMotion(frame.querySelector('.derby-route-svg'));

            var joinBtn = li.querySelector('.derby-race-join');
            if (st === 'running') {
                joinBtn.disabled = true;
                joinBtn.textContent = 'Racing…';
                joinBtn.classList.add('derby-btn--busy-lock');
            } else {
                joinBtn.addEventListener('click', function () {
                    post('joinRace', { raceId: r.id });
                    showToast('Requesting seat for ' + (r.name || 'fixture') + '…');
                });
            }

            racesList.appendChild(li);
        });
        applyDerbyUiBusy(derbyUiBusy);
    }

    function formatCountdown(sec) {
        var n = Number(sec);
        if (!isFinite(n) || n < 0) return '—';
        var m = Math.floor(n / 60);
        var s = Math.floor(n % 60);
        return (m > 0 ? m + 'm ' : '') + s + 's';
    }

    window.addEventListener('message', function (ev) {
        var d = ev.data;
        if (!d || typeof d !== 'object') return;
        if (d.action === 'open') {
            derbyUiBusy = !!d.derbyBusy;
            showApp(true);
            /* After removing display:none layout can be 0×0 in the same tick (CEF) */
            requestAnimationFrame(function () {
                requestAnimationFrame(function () {
                    startHorseBg();
                    paintHorseLineIcons();
                });
            });
            if (d.career) applyCareer(d.career);
            catalogRoutes = Array.isArray(d.catalogRoutes) ? d.catalogRoutes : [];
            renderRaces(d.races || []);
            renderCatalogRoutes(catalogRoutes);
            setPanel('career');
        }
        if (d.action === 'setDerbyBusy') {
            derbyUiBusy = !!d.busy;
            applyDerbyUiBusy(derbyUiBusy);
        }
        if (d.action === 'close') {
            stopHorseBg();
            showApp(false);
        }
        if (d.action === 'setRaces') {
            renderRaces(d.races || []);
        }
        if (d.action === 'setCareer' && d.career) {
            applyCareer(d.career);
        }
        if (d.action === 'setHallOfFame') {
            applyHallOfFame(d.hall || {});
        }
        if (d.action === 'joinResult' && d.result) {
            var res = d.result;
            if (res.ok) {
                /* Client sends dodi_notifys Tip (GPS / travel to start) */
            } else {
                showToast(res.message || 'Could not join.', true);
            }
        }
        if (d.action === 'derbyCountdown') {
            if (!raceHud || !raceHudNum) return;
            var lobbyHud = document.getElementById('derby-lobby-hud');
            if (lobbyHud) lobbyHud.classList.add('hidden');
            if (!d.visible) {
                raceHud.classList.add('hidden');
                raceHudNum.classList.remove('derby-race-hud-num--go');
                return;
            }
            raceHud.classList.remove('hidden');
            var ph = d.phase || 'tick';
            if (ph === 'go') {
                raceHudNum.textContent = 'GO!';
                raceHudNum.classList.add('derby-race-hud-num--go');
                if (raceHudSub) raceHudSub.textContent = '';
            } else {
                raceHudNum.classList.remove('derby-race-hud-num--go');
                var n = d.seconds;
                raceHudNum.textContent = typeof n === 'number' ? String(n) : '—';
                if (raceHudSub) {
                    raceHudSub.textContent = 'Hold your horse steady - nose to the line';
                }
            }
        }
        if (d.action === 'lobbyWaiting') {
            var lHud = document.getElementById('derby-lobby-hud');
            var lText = document.getElementById('derby-lobby-hud-text');
            var lPlayers = document.getElementById('derby-lobby-hud-players');
            var lForce = document.getElementById('derby-lobby-force-start');
            var lLeave = document.getElementById('derby-lobby-leave');
            if (!lHud) return;
            if (!d.visible) {
                lHud.classList.add('hidden');
                return;
            }
            lHud.classList.remove('hidden');
            var ready = d.readyCount || 0;
            var minP = d.minPlayers || 2;
            var total = d.playerCount || 0;
            if (lText) {
                if (ready >= minP) {
                    lText.textContent = 'Starting soon...';
                } else {
                    lText.textContent = 'Waiting... ' + ready + '/' + minP + ' ready';
                }
            }
            if (lPlayers) {
                var parts = [];
                parts.push(total + ' rider' + (total !== 1 ? 's' : '') + ' in lobby');
                if (Array.isArray(d.playerNames) && d.playerNames.length > 0) {
                    parts.push(d.playerNames.join(', '));
                }
                lPlayers.textContent = parts.join(' — ');
            }
            if (lForce) {
                lForce.classList.toggle('hidden', !d.isHost);
            }
        }
        if (d.action === 'leaderboard') {
            var lb = document.getElementById('derby-leaderboard');
            var rows = document.getElementById('derby-leaderboard-rows');
            if (!lb) return;
            if (!d.visible) { lb.classList.add('hidden'); return; }
            lb.classList.remove('hidden');
            if (rows && Array.isArray(d.entries)) {
                var html = '';
                var medals = ['#ffd700', '#c0c0c0', '#cd7f32'];
                d.entries.forEach(function (e, i) {
                    var col = medals[i] || '#aaa';
                    var pos = (i + 1);
                    var suffix = pos === 1 ? 'st' : pos === 2 ? 'nd' : pos === 3 ? 'rd' : 'th';
                    var you = e.isPlayer ? ' style="font-weight:700;color:#ffd700;"' : '';
                    var fin = e.finished ? ' <span style="opacity:0.5;font-size:0.7rem;">FIN</span>' : '';
                    var disp = e.name || 'Rider';
                    if (e.isAi) disp = disp + ' (AI)';
                    html += '<div' + you + '><span style="color:' + col + ';display:inline-block;width:26px;">' + pos + suffix + '</span> ' + disp + fin + '</div>';
                });
                rows.innerHTML = html;
            }
        }
        if (d.action === 'raceTimer') {
            var tmr = document.getElementById('derby-leaderboard-timer');
            if (!tmr) return;
            if (!d.visible) { tmr.classList.add('hidden'); return; }
            tmr.classList.remove('hidden');
            tmr.textContent = d.text || '';
        }
        if (d.action === 'raceResult') {
            var rr = document.getElementById('derby-race-result');
            if (!rr) return;
            if (!d.visible) {
                rr.classList.remove('is-visible');
                rr.classList.add('is-fading');
                setTimeout(function () {
                    rr.classList.add('hidden');
                    rr.classList.remove('is-fading');
                }, 800);
                return;
            }
            var posEl = document.getElementById('derby-result-pos');
            var timeEl = document.getElementById('derby-result-time');
            var cpsEl = document.getElementById('derby-result-cps');
            var ridersEl = document.getElementById('derby-result-riders');
            var titleEl = document.getElementById('derby-result-title');
            var subEl = document.getElementById('derby-result-subtitle');
            var iconEl = document.getElementById('derby-result-icon');
            if (posEl) {
                posEl.textContent = d.position || '—';
                posEl.className = 'derby-race-result__stat-value derby-race-result__pos';
                var p = parseInt(d.position, 10);
                if (p === 1) posEl.classList.add('derby-race-result__pos--gold');
                else if (p === 2) posEl.classList.add('derby-race-result__pos--silver');
                else if (p === 3) posEl.classList.add('derby-race-result__pos--bronze');
            }
            if (timeEl) timeEl.textContent = d.time || '—';
            if (cpsEl) cpsEl.textContent = d.checkpoints || '—';
            if (ridersEl) ridersEl.textContent = d.totalRiders || '—';
            if (titleEl) titleEl.textContent = d.finished ? 'Race Complete' : 'Time Up';
            if (iconEl) {
                iconEl.classList.toggle('derby-race-result__icon--dnf', !d.finished);
                var useEl = iconEl.querySelector('use');
                if (useEl) {
                    var href = d.finished ? '#ico-trophy' : '#ico-finish';
                    useEl.setAttribute('href', href);
                    useEl.setAttribute('xlink:href', href);
                }
            }
            if (subEl) {
                var p2 = parseInt(d.position, 10);
                if (!d.finished) subEl.textContent = 'Better luck next time.';
                else if (p2 === 1) subEl.textContent = 'Winner! Outstanding ride.';
                else if (p2 === 2) subEl.textContent = 'So close! Great effort.';
                else if (p2 === 3) subEl.textContent = 'On the podium. Well ridden!';
                else subEl.textContent = 'You made it across the line.';
            }
            rr.classList.remove('hidden', 'is-fading');
            void rr.offsetWidth;
            rr.classList.add('is-visible');
            var displayMs = d.displayMs || 7000;
            setTimeout(function () {
                rr.classList.remove('is-visible');
                rr.classList.add('is-fading');
                setTimeout(function () {
                    rr.classList.add('hidden');
                    rr.classList.remove('is-fading');
                }, 800);
            }, displayMs);
        }
    });

    closeBtn.addEventListener('click', function () {
        post('close', {});
    });

    document.addEventListener('keydown', function (e) {
        var editorVisible = editorEl && !editorEl.classList.contains('hidden');
        var editorHasFocus = editorVisible && editorEl.classList.contains('derby-editor--focused');

        if (editorHasFocus && (e.key === 'Escape' || e.key === 'Tab')) {
            e.preventDefault();
            post('editorUnfocus', {});
            return;
        }

        if (e.key === 'Escape' && app && !app.classList.contains('hidden')) {
            post('close', {});
        }
    });

    navBtns.forEach(function (b) {
        b.addEventListener('click', function () {
            setPanel(b.getAttribute('data-panel'));
        });
    });

    btnRefreshRaces.addEventListener('click', function () {
        post('refreshRaces', {});
    });

    btnRefreshCareer.addEventListener('click', function () {
        post('refreshCareer', {});
    });

    if (btnRefreshHallOfFame) {
        btnRefreshHallOfFame.addEventListener('click', function () {
            post('refreshHallOfFame', {});
        });
    }

    if (btnRefreshPlayerRoutes) {
        btnRefreshPlayerRoutes.addEventListener('click', function () {
            post('refreshPlayerRoutes', {});
        });
    }

    /* ── Editor panel logic ── */
    function showEditor(show) {
        if (!editorEl) return;
        editorEl.classList.toggle('hidden', !show);
        editorEl.setAttribute('aria-hidden', show ? 'false' : 'true');
    }

    function clearEditorForm() {
        if (editorTitle) editorTitle.value = '';
        if (editorDesc) editorDesc.value = '';
        if (editorRegion) editorRegion.value = '';
        if (editorSurface) editorSurface.value = '';
        if (editorLoop) editorLoop.checked = false;
        if (editorMinPlayers) editorMinPlayers.value = '2';
        if (editorMaxPlayers) editorMaxPlayers.value = '8';
        if (editorAiEnabled) editorAiEnabled.checked = false;
        if (editorAiCount) editorAiCount.value = '3';
        syncEditorAiCountVisibility();
        editorCheckpoints = [];
        refreshEditorCpList();
    }

    function syncEditorAiCountVisibility() {
        if (editorAiCountWrap) {
            var show = editorAiEnabled && editorAiEnabled.checked;
            editorAiCountWrap.style.display = show ? '' : 'none';
        }
    }

    function refreshEditorCpList() {
        if (!editorCpList) return;
        editorCpList.innerHTML = '';
        if (editorCpCount) editorCpCount.textContent = String(editorCheckpoints.length);
        if (editorCheckpoints.length === 0) {
            if (editorCpEmpty) editorCpEmpty.classList.remove('hidden');
            if (editorPreviewFrame) editorPreviewFrame.innerHTML = '';
            return;
        }
        if (editorCpEmpty) editorCpEmpty.classList.add('hidden');
        editorCheckpoints.forEach(function (cp, idx) {
            var li = document.createElement('li');
            li.className = 'derby-editor-cp-item';
            li.innerHTML =
                '<span class="derby-editor-cp-num">' + (idx + 1) + '</span>' +
                '<span class="derby-editor-cp-coords"></span>' +
                '<button type="button" class="derby-editor-cp-remove" title="Remove">&times;</button>';
            li.querySelector('.derby-editor-cp-coords').textContent =
                cp.x.toFixed(1) + ', ' + cp.y.toFixed(1) + ', ' + cp.z.toFixed(1);
            li.querySelector('.derby-editor-cp-remove').addEventListener('click', function () {
                editorCheckpoints.splice(idx, 1);
                refreshEditorCpList();
                post('editorCpRemoved', { index: idx });
            });
            editorCpList.appendChild(li);
        });
        editorCpList.scrollTop = editorCpList.scrollHeight;
        refreshEditorPreview();
    }

    function refreshEditorPreview() {
        if (!editorPreviewFrame || editorCheckpoints.length < 2) {
            if (editorPreviewFrame) editorPreviewFrame.innerHTML = '';
            return;
        }
        var isLoop = editorLoop ? editorLoop.checked : false;
        editorPreviewFrame.innerHTML = buildRoutePreviewSVG(
            editorCheckpoints, 340, 150, 'editor-prev', { closedLoop: isLoop }
        );
        bindRouteHorseMotion(editorPreviewFrame.querySelector('.derby-route-svg'));
    }

    if (editorLoop) {
        editorLoop.addEventListener('change', function () {
            refreshEditorPreview();
        });
    }

    if (editorAiEnabled) {
        editorAiEnabled.addEventListener('change', function () {
            syncEditorAiCountVisibility();
        });
    }
    syncEditorAiCountVisibility();

    if (editorClose) {
        editorClose.addEventListener('click', function () {
            showEditor(false);
            post('editorClose', {});
        });
    }

    if (editorBtnCancel) {
        editorBtnCancel.addEventListener('click', function () {
            showEditor(false);
            post('editorClose', {});
        });
    }

    if (editorBtnClear) {
        editorBtnClear.addEventListener('click', function () {
            clearEditorForm();
            post('editorClear', {});
        });
    }

    if (editorBtnSave) {
        editorBtnSave.addEventListener('click', function () {
            if (editorCheckpoints.length < 2) {
                showToast('Need at least 2 checkpoints to save.', true);
                return;
            }
            var minP = editorMinPlayers ? parseInt(editorMinPlayers.value, 10) : 2;
            var maxP = editorMaxPlayers ? parseInt(editorMaxPlayers.value, 10) : 8;
            if (!isFinite(minP) || minP < 1) minP = 2;
            if (!isFinite(maxP) || maxP < 1) maxP = 8;
            if (maxP < minP) maxP = minP;
            var aiOn = editorAiEnabled ? editorAiEnabled.checked : false;
            var aiN = editorAiCount ? parseInt(editorAiCount.value, 10) : 3;
            if (!isFinite(aiN) || aiN < 1) aiN = 3;
            if (aiN > 8) aiN = 8;
            var data = {
                title: (editorTitle && editorTitle.value.trim()) || 'Untitled',
                description: (editorDesc && editorDesc.value.trim()) || '',
                region: (editorRegion && editorRegion.value.trim()) || '',
                surface: (editorSurface && editorSurface.value.trim()) || '',
                closedLoop: editorLoop ? editorLoop.checked : false,
                minPlayers: minP,
                maxPlayers: maxP,
                aiEnabled: aiOn,
                aiCount: aiOn ? aiN : 0,
                checkpoints: editorCheckpoints,
            };
            post('editorSave', data);
            showToast('Saving route…');
        });
    }

    /* ── Player routes (DB-backed) rendering ── */
    function renderPlayerRoutes(list) {
        playerRoutes = Array.isArray(list) ? list : [];
        if (!playerRoutesGrid) return;
        playerRoutesGrid.innerHTML = '';
        if (playerRoutes.length === 0) {
            if (playerRoutesEmpty) playerRoutesEmpty.classList.remove('hidden');
            applyDerbyUiBusy(derbyUiBusy);
            return;
        }
        if (playerRoutesEmpty) playerRoutesEmpty.classList.add('hidden');
        playerRoutes.forEach(function (route, idx) {
            var card = document.createElement('article');
            card.className = 'derby-course-card';
            var dist = formatCourseDistanceKm(route);
            var region = route.region || '';
            var surface = route.surface || '';
            var cps = Array.isArray(route.checkpoints) ? route.checkpoints.length : 0;
            card.innerHTML =
                '<header class="derby-course-card-head">' +
                '<h3 class="derby-course-title"></h3>' +
                '<p class="derby-course-meta"></p>' +
                '</header>' +
                (route.description ? '<p class="derby-lead" style="font-size:12px;padding:4px 12px 0;margin:0;"></p>' : '') +
                '<div class="derby-route-frame derby-route-frame--hero"></div>' +
                '<footer class="derby-course-foot">' +
                '<span class="derby-course-chip"></span>' +
                '<div class="derby-player-route-actions">' +
                '<button type="button" class="derby-btn derby-btn-sm derby-club-btn derby-player-route-start">Start race</button>' +
                '<button type="button" class="derby-btn derby-btn-sm derby-player-route-del">Delete</button>' +
                '</div>' +
                '</footer>';
            card.querySelector('.derby-course-title').textContent = route.name || 'Untitled';
            card.querySelector('.derby-course-meta').textContent =
                [dist + region, surface].filter(Boolean).join(' · ');
            if (route.description) {
                var descEl = card.querySelector('.derby-lead');
                if (descEl) descEl.textContent = route.description;
            }
            var minPl = route.minPlayers != null ? route.minPlayers : 2;
            var maxPl = route.maxPlayers != null ? route.maxPlayers : 8;
            var aiTag = route.aiEnabled ? ' + ' + (route.aiCount || 0) + ' AI' : '';
            card.querySelector('.derby-course-chip').textContent =
                cps + ' checkpoint' + (cps === 1 ? '' : 's') +
                ' · ' + minPl + '-' + maxPl + ' riders' + aiTag +
                (route.createdBy ? ' · by ' + route.createdBy : '');
            var frame = card.querySelector('.derby-route-frame--hero');
            if (cps >= 2) {
                frame.innerHTML = buildRoutePreviewSVG(route.checkpoints, 520, 280, 'pr-' + (route.id || idx), {
                    closedLoop: route.closedLoop === true,
                });
                bindRouteHorseMotion(frame.querySelector('.derby-route-svg'));
            }
            card.querySelector('.derby-player-route-start').addEventListener('click', function () {
                post('startPlayerRoute', {
                    id: route.id,
                    dbId: route.dbId,
                    checkpoints: route.checkpoints,
                    closedLoop: route.closedLoop,
                    name: route.name,
                    minPlayers: route.minPlayers,
                    maxPlayers: route.maxPlayers,
                    aiEnabled: route.aiEnabled,
                    aiCount: route.aiCount,
                });
                showToast('Starting race: ' + (route.name || 'Untitled') + '…');
            });
            var delBtn = card.querySelector('.derby-player-route-del');
            if (route.isMine === false) {
                delBtn.style.display = 'none';
            } else {
                delBtn.addEventListener('click', function () {
                    if (route.dbId != null) {
                        post('deletePlayerRoute', { dbId: route.dbId });
                    }
                });
            }
            playerRoutesGrid.appendChild(card);
        });
        applyDerbyUiBusy(derbyUiBusy);
    }

    /* ── Catalog routes (host a lobby) ── */
    var catalogRoutesGrid = document.getElementById('catalog-routes-grid');

    function renderCatalogRoutes(routes) {
        if (!catalogRoutesGrid) return;
        catalogRoutesGrid.innerHTML = '';
        if (!Array.isArray(routes) || routes.length === 0) {
            applyDerbyUiBusy(derbyUiBusy);
            return;
        }
        routes.forEach(function (route, idx) {
            var card = document.createElement('article');
            card.className = 'derby-course-card';
            var dist = formatCourseDistanceKm(route);
            var region = route.region || '';
            var surface = route.surface || '';
            var cpsCount = Array.isArray(route.checkpoints) ? route.checkpoints.length : 0;
            var minP = route.minPlayers || 2;
            var maxP = route.maxPlayers || 8;
            card.innerHTML =
                '<header class="derby-course-card-head">' +
                '<h3 class="derby-course-title"></h3>' +
                '<p class="derby-course-meta"></p>' +
                '</header>' +
                '<div class="derby-route-frame derby-route-frame--hero"></div>' +
                '<footer class="derby-course-foot">' +
                '<span class="derby-course-chip"></span>' +
                '<div class="derby-player-route-actions">' +
                '<button type="button" class="derby-btn derby-btn-sm derby-club-btn derby-catalog-host">Host race</button>' +
                '</div>' +
                '</footer>';
            card.querySelector('.derby-course-title').textContent = route.name || 'Untitled';
            card.querySelector('.derby-course-meta').textContent =
                [dist + region, surface].filter(Boolean).join(' · ');
            card.querySelector('.derby-course-chip').textContent =
                cpsCount + ' checkpoints · ' + minP + '-' + maxP + ' riders' +
                (route.aiEnabled ? ' + AI' : '');
            var frame = card.querySelector('.derby-route-frame--hero');
            if (cpsCount >= 2) {
                frame.innerHTML = buildRoutePreviewSVG(route.checkpoints, 520, 280, 'cat-' + (route.id || idx), {
                    closedLoop: route.closedLoop === true,
                });
                bindRouteHorseMotion(frame.querySelector('.derby-route-svg'));
            }
            card.querySelector('.derby-catalog-host').addEventListener('click', function () {
                post('createLobby', {
                    routeId: route.id,
                    name: route.name,
                    checkpoints: route.checkpoints,
                    closedLoop: route.closedLoop,
                    minPlayers: route.minPlayers,
                    maxPlayers: route.maxPlayers,
                    aiEnabled: route.aiEnabled,
                    aiCount: route.aiCount,
                });
                showToast('Creating lobby for ' + (route.name || 'race') + '...');
            });
            catalogRoutesGrid.appendChild(card);
        });
        applyDerbyUiBusy(derbyUiBusy);
    }

    /* ── Extended message handler ── */
    window.addEventListener('message', function (ev) {
        var d = ev.data;
        if (!d || typeof d !== 'object') return;

        if (d.action === 'editorOpen') {
            clearEditorForm();
            showEditor(true);
        }
        if (d.action === 'editorClose') {
            showEditor(false);
        }
        if (d.action === 'editorFocus') {
            if (editorEl) {
                editorEl.classList.toggle('derby-editor--focused', !!d.focused);
            }
        }
        if (d.action === 'editorAddCp') {
            var cp = d.checkpoint;
            if (cp && typeof cp.x === 'number') {
                editorCheckpoints.push({ x: cp.x, y: cp.y, z: cp.z });
                refreshEditorCpList();
            }
        }
        if (d.action === 'editorSaveResult') {
            if (d.ok) {
                showToast('Route saved!');
                clearEditorForm();
                showEditor(false);
            } else {
                showToast(d.message || 'Failed to save.', true);
            }
        }
        if (d.action === 'setPlayerRoutes') {
            renderPlayerRoutes(d.routes || []);
        }
    });
})();
