/**
 * Collect minigame — same product image: green = catch, red = trap.
 */
(function () {
  const resName =
    typeof GetParentResourceName === 'function' ? GetParentResourceName() : 'MX-Ranch';

  const root = document.getElementById('collectMinigameRoot');
  if (!root) return;

  let active = false;
  let finished = false;
  let rafId = 0;
  let timerId = 0;
  let spawnTimerId = 0;
  let state = null;
  let entities = [];
  let catchAudio = null;

  function ensureCatchAudio() {
    if (catchAudio) return catchAudio;
    catchAudio = new Audio('audio/minigameselect2.mp3');
    catchAudio.preload = 'auto';
    catchAudio.volume = 0.65;
    return catchAudio;
  }

  function playCatchSound() {
    try {
      const snd = ensureCatchAudio();
      snd.currentTime = 0;
      const p = snd.play();
      if (p && typeof p.catch === 'function') p.catch(function () {});
    } catch (_) {}
  }

  function postDone(payload) {
    fetch(`https://${resName}/collectMinigameDone`, {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify(payload || {}),
    }).catch(() => {});
  }

  function cleanupUi() {
    active = false;
    finished = false;
    if (rafId) cancelAnimationFrame(rafId);
    rafId = 0;
    if (timerId) clearInterval(timerId);
    timerId = 0;
    if (spawnTimerId) clearInterval(spawnTimerId);
    spawnTimerId = 0;
    entities = [];
    root.classList.add('hidden');
    root.classList.remove('is-active');
    root.innerHTML = '';
    state = null;
  }

  function finishRun(fullSuccess, timedOut) {
    if (finished) return;
    finished = true;
    if (timerId) clearInterval(timerId);
    timerId = 0;
    if (spawnTimerId) clearInterval(spawnTimerId);
    spawnTimerId = 0;
    const hits = state ? state.hits : 0;
    const target = state ? state.target : 0;
    const reached = hits >= target && target > 0;
    const payload = {
      success: !!fullSuccess || reached,
      hits: hits,
      target: target,
      timedOut: !!timedOut && !reached,
    };
    cleanupUi();
    postDone(payload);
  }

  function stopAll(fullSuccess, timedOut) {
    if (!active || finished) return;
    finishRun(fullSuccess, timedOut);
  }

  function setFeedback(text, kind) {
    const el = root.querySelector('.cmg-feedback');
    if (!el) return;
    el.textContent = text || '';
    el.className = 'cmg-feedback' + (kind ? ' cmg-feedback--' + kind : '');
  }

  function updateProgress() {
    const fill = root.querySelector('.cmg-progress__fill');
    if (!fill || !state) return;
    const pct = Math.min(100, Math.round((state.hits / state.target) * 100));
    fill.style.width = pct + '%';
  }

  function randomBetween(min, max) {
    return min + Math.random() * (max - min);
  }

  function applyItemVisual(el, image, item, label) {
    const lbl = label || item || '?';
    el.dataset.item = item || '';
    el.style.backgroundColor = 'transparent';
    if (image) {
      el.style.backgroundImage = 'url("' + image + '")';
      el.style.backgroundSize = 'contain';
      el.style.backgroundPosition = 'center';
      el.style.backgroundRepeat = 'no-repeat';
    } else {
      el.style.backgroundImage = 'none';
    }
    el.setAttribute('aria-label', lbl);
    const fb = el.querySelector('.cmg-fall-item__label');
    if (fb) fb.textContent = lbl;
    if (image) {
      const probe = new Image();
      probe.onerror = function () {
        el.classList.add('cmg-fall-item--noimg');
      };
      probe.src = image;
    } else {
      el.classList.add('cmg-fall-item--noimg');
    }
  }

  function removeEntity(ent) {
    if (!ent || !ent.el) return;
    ent.el.remove();
    const idx = entities.indexOf(ent);
    if (idx >= 0) entities.splice(idx, 1);
  }

  function onItemClick(ent, ev) {
    ev.preventDefault();
    ev.stopPropagation();
    if (!active || !state || ent.clicked) return;
    const now = performance.now();
    if (state.clickLockUntil && now < state.clickLockUntil) return;
    ent.clicked = true;
    state.clickLockUntil = now + 180;

    if (ent.good) {
      state.hits += 1;
      playCatchSound();
      ent.el.classList.add('cmg-fall-item--caught');
      setFeedback(state.labels.good || 'Caught!', 'ok');
      updateProgress();
      setTimeout(() => removeEntity(ent), 120);
      if (state.hits >= state.target) stopAll(true, false);
    } else {
      state.misses += 1;
      ent.el.classList.add('cmg-fall-item--wrong');
      setFeedback(state.labels.wrong || state.labels.miss || 'Wrong!', 'miss');
      setTimeout(() => removeEntity(ent), 200);
      if (state.misses >= state.maxMisses) finishRun(false, false);
    }
  }

  function spawnFallItem() {
    if (!active || !state) return;
    const arena = root.querySelector('.cmg-fall-arena');
    if (!arena) return;
    if (entities.length >= state.maxOnScreen) return;

    const isGood = Math.random() < state.goodChance;
    const itemDef = {
      item: state.targetItem,
      image: state.targetImage,
      label: state.targetLabel,
    };

    const el = document.createElement('button');
    el.type = 'button';
    el.className =
      'cmg-fall-item' + (isGood ? ' cmg-fall-item--good' : ' cmg-fall-item--trap');
    el.innerHTML = '<span class="cmg-fall-item__label"></span>';
    applyItemVisual(el, itemDef.image, itemDef.item, itemDef.label);

    const arenaW = arena.clientWidth || window.innerWidth || 320;
    const size = Math.min(80, Math.max(72, Math.floor(arenaW * 0.075)));
    const leftPx = randomBetween(12, Math.max(12, arenaW - size - 12));
    el.style.left = leftPx + 'px';
    const spawnTop = -(size + 12);
    el.style.top = spawnTop + 'px';

    const ent = {
      el,
      good: isGood,
      y: spawnTop,
      vy: randomBetween(state.fallSpeedMin, state.fallSpeedMax),
      wobble: randomBetween(-0.8, 0.8),
      clicked: false,
    };

    el.addEventListener('mousedown', (ev) => onItemClick(ent, ev));
    arena.appendChild(el);
    entities.push(ent);
  }

  function tickFall() {
    if (!active || !state) return;
    const arena = root.querySelector('.cmg-fall-arena');
    const maxY = (arena && arena.clientHeight) || window.innerHeight || 480;

    for (let i = entities.length - 1; i >= 0; i -= 1) {
      const ent = entities[i];
      ent.y += ent.vy * 0.016;
      ent.el.style.top = ent.y + 'px';
      ent.el.style.transform = 'rotate(' + Math.sin(ent.y * 0.04) * 8 * ent.wobble + 'deg)';
      if (ent.y > maxY + 20 && !ent.clicked) {
        if (ent.good) {
          state.misses += 1;
          setFeedback(state.labels.miss || 'Escaped…', 'miss');
          if (state.misses >= state.maxMisses) {
            finishRun(false, false);
            return;
          }
        }
        removeEntity(ent);
      }
    }
    rafId = requestAnimationFrame(tickFall);
  }

  function buildPanel(labels, targetLabel) {
    const hint = (labels.hint || '').replace(/\{item\}/g, '<strong>' + (targetLabel || '') + '</strong>');
    return (
      '<div class="cmg-panel cmg-panel--catch cmg-panel--fullscreen">' +
      '<div class="cmg-hud">' +
      '<div class="cmg-head"><h2 class="cmg-title"></h2><span class="cmg-timer"></span></div>' +
      '<p class="cmg-hint">' + hint + '</p>' +
      '<div class="cmg-hud-row">' +
      '<div class="cmg-target-badge"><span class="cmg-target-badge__label"></span></div>' +
      '<div class="cmg-progress-wrap"><div class="cmg-progress"><div class="cmg-progress__fill"></div></div></div>' +
      '</div></div>' +
      '<div class="cmg-fall-arena" role="application" aria-label="Catch items"></div>' +
      '<p class="cmg-feedback"></p></div>'
    );
  }

  function start(msg) {
    cleanupUi();
    const durationMs = Math.max(8000, Number(msg.durationMs) || 16000);
    const target = Math.max(3, Number(msg.target) || 6);
    const labels = msg.labels || {};
    const targetItem = msg.targetItem || 'item';
    const targetLabel = msg.targetLabel || targetItem;

    state = {
      kind: 'catch',
      target,
      hits: 0,
      misses: 0,
      maxMisses: Math.max(2, Number(msg.maxMisses) || 4),
      endAt: performance.now() + durationMs,
      labels,
      targetItem,
      targetImage: msg.targetImage || '',
      targetLabel,
      fallSpeedMin: Number(msg.fallSpeedMin) || 95,
      fallSpeedMax: Number(msg.fallSpeedMax) || 175,
      goodChance: Math.min(0.55, Math.max(0.26, Number(msg.goodChance) || 0.36)),
      maxOnScreen: Math.max(4, Number(msg.maxOnScreen) || 9),
      clickLockUntil: 0,
    };

    root.innerHTML = buildPanel(labels, targetLabel);
    root.querySelector('.cmg-title').textContent = labels.title || 'Collect';
    const badge = root.querySelector('.cmg-target-badge__label');
    if (badge) badge.textContent = targetLabel;
    const badgeImg = root.querySelector('.cmg-target-badge');
    if (badgeImg && state.targetImage) {
      badgeImg.style.backgroundColor = 'transparent';
      badgeImg.style.backgroundImage = 'url("' + state.targetImage + '")';
      badgeImg.style.backgroundSize = '88%';
      badgeImg.style.backgroundPosition = 'center';
      badgeImg.style.backgroundRepeat = 'no-repeat';
      badgeImg.setAttribute('title', targetLabel);
    }

    root.classList.remove('hidden');
    root.classList.add('is-active');
    active = true;
    updateProgress();

    const arena = root.querySelector('.cmg-fall-arena');
    const hud = root.querySelector('.cmg-hud');
    if (arena && hud) {
      const hudH = hud.offsetHeight || 100;
      arena.style.top = Math.ceil(hudH + 4) + 'px';
    }

    timerId = setInterval(() => {
      if (!active || !state || finished) return;
      const left = Math.max(0, Math.ceil((state.endAt - performance.now()) / 1000));
      const timerEl = root.querySelector('.cmg-timer');
      if (timerEl) timerEl.textContent = left + 's';
      if (performance.now() >= state.endAt) {
        const reached = state.hits >= state.target;
        finishRun(reached, !reached);
      }
    }, 200);

    ensureCatchAudio();

    const spawnMs = Math.max(380, Number(msg.spawnIntervalMs) || 580);
    spawnFallItem();
    spawnTimerId = setInterval(spawnFallItem, spawnMs);
    rafId = requestAnimationFrame(tickFall);
  }

  window.addEventListener('message', (ev) => {
    const msg = ev.data;
    if (!msg || !msg.action) return;
    if (msg.action === 'collectMinigameStart') start(msg);
    if (msg.action === 'collectMinigameStop') cleanupUi();
  });
})();
