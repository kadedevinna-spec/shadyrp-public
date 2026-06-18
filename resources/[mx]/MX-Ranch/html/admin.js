/**
 * MX-Ranch — admin panel (list / create / edit / delete ranches)
 */
(function () {
  const resName =
    typeof GetParentResourceName === 'function' ? GetParentResourceName() : 'MX-Ranch';

  let adminList = [];
  let adminEscBound = false;
  let adminDeleteId = null;
  let adminEditId = null;

  function el(id) {
    return document.getElementById(id);
  }

  function tAdmin(key, vars) {
    return typeof window.t === 'function' ? window.t('admin.' + key, vars) : key;
  }

  function post(name, data) {
    return fetch(`https://${resName}/${name}`, {
      method: 'POST',
      headers: { 'Content-Type': 'application/json; charset=UTF-8' },
      body: JSON.stringify(data || {}),
    }).then((r) => r.json().catch(() => ({})));
  }

  function escapeHtml(str) {
    const d = document.createElement('div');
    d.textContent = str == null ? '' : String(str);
    return d.innerHTML;
  }

  function formatOwnerShort(owner) {
    if (owner == null || owner === '' || owner === '—') return '—';
    const s = String(owner);
    if (s.length <= 22) return s;
    return s.slice(0, 10) + '…' + s.slice(-6);
  }

  function adminPanelOpen() {
    const root = el('adminRanchesRoot');
    return root && !root.classList.contains('hidden');
  }

  function applyAdminI18n() {
    const map = {
      mxAdminRanchesTitle: 'title',
      mxAdminRanchesTag: 'tag',
      adminRanchesSearch: ['searchPlaceholder', 'placeholder'],
      adminRanchesEmptyState: 'empty',
      adminRanchesToolsTitle: 'toolsTitle',
      adminRanchesToolsHint1: 'toolsHint1',
      adminRanchesToolsHint2: 'toolsHint2',
      adminRanchesRefresh: 'refresh',
      adminRanchesPlaceNew: 'placeNew',
      adminRanchesDeleteHeading: 'deleteHeading',
      adminRanchesDeleteCancel: 'cancel',
      adminRanchesDeleteConfirm: 'deleteConfirm',
      adminRanchesEditHeading: 'editHeading',
      adminRanchesEditCancel: 'cancel',
      adminRanchesEditSave: 'save',
      adminRanchesEditLabelName: 'labelName',
      adminRanchesEditLabelJob: 'labelJob',
      adminRanchesEditLabelPrice: 'labelPrice',
      adminRanchesEditLabelRadius: 'labelRadius',
      adminRanchesEditLabelOwner: 'labelOwner',
      adminRanchesEditOwnerHint: 'ownerHint',
      adminRanchesEditLabelOwnerId: 'labelOwnerServerId',
      adminRanchesEditOwnerIdHint: 'ownerServerIdHint',
      adminRanchesEditNoOwnerLabel: 'noOwner',
      adminRanchesEditUsePositionLabel: 'usePosition',
      adminRanchesPlaceHeading: 'placeHeading',
      adminRanchesPlaceHint: 'placeHint',
      adminRanchesPlaceCancel: 'cancel',
      adminRanchesPlaceSave: 'placeSave',
      adminRanchesPlaceLabelName: 'labelName',
      adminRanchesPlaceLabelJob: 'labelJob',
      adminRanchesPlaceLabelPrice: 'labelPrice',
      adminRanchesPlaceLabelRadius: 'labelRadius',
    };
    Object.keys(map).forEach((id) => {
      const node = el(id);
      if (!node) return;
      const spec = map[id];
      const key = Array.isArray(spec) ? spec[0] : spec;
      const attr = Array.isArray(spec) ? spec[1] : 'textContent';
      const val = tAdmin(key);
      if (attr === 'placeholder') node.placeholder = val;
      else node.textContent = val;
    });
    document.querySelectorAll('[data-admin-th]').forEach((th) => {
      const k = th.getAttribute('data-admin-th');
      if (k) th.textContent = tAdmin(k);
    });
    const closeBtn = el('adminRanchesBtnClose');
    if (closeBtn) closeBtn.setAttribute('aria-label', tAdmin('close'));
    if (closeBtn) closeBtn.title = tAdmin('close');
  }

  function bindAdminEsc() {
    if (adminEscBound) return;
    document.addEventListener('keydown', onAdminKeydown, true);
    adminEscBound = true;
  }

  function unbindAdminEsc() {
    if (!adminEscBound) return;
    document.removeEventListener('keydown', onAdminKeydown, true);
    adminEscBound = false;
  }

  function onAdminKeydown(ev) {
    if (ev.key !== 'Escape' || !adminPanelOpen()) return;
    ev.preventDefault();
    ev.stopPropagation();
    if (!el('adminRanchesPlaceModal')?.classList.contains('hidden')) {
      hidePlaceModal();
      return;
    }
    if (!el('adminRanchesEditModal')?.classList.contains('hidden')) {
      hideEditModal();
      return;
    }
    if (!el('adminRanchesDeleteModal')?.classList.contains('hidden')) {
      hideDeleteModal();
      return;
    }
    closeAdminPanel();
  }

  function getFiltered() {
    const q = (el('adminRanchesSearch')?.value || '').trim().toLowerCase();
    if (!q) return adminList.slice();
    return adminList.filter((r) => {
      const hay = [r.id, r.name, r.job, r.owner, r.price, r.radius, r.x, r.y, r.z]
        .map((x) => String(x == null ? '' : x).toLowerCase())
        .join(' ');
      return hay.includes(q);
    });
  }

  function hideDeleteModal() {
    el('adminRanchesDeleteModal')?.classList.add('hidden');
    el('adminRanchesDeleteBackdrop')?.classList.add('hidden');
    adminDeleteId = null;
  }

  function showDeleteModal(ranchId, ranchName) {
    hidePlaceModal();
    hideEditModal();
    adminDeleteId = Number(ranchId);
    const p = el('adminRanchesDeleteText');
    if (p) {
      p.textContent = tAdmin('deleteText', { name: ranchName, id: ranchId });
    }
    el('adminRanchesDeleteBackdrop')?.classList.remove('hidden');
    el('adminRanchesDeleteModal')?.classList.remove('hidden');
  }

  function hideEditModal() {
    adminEditId = null;
    el('adminRanchesEditModal')?.classList.add('hidden');
    el('adminRanchesEditBackdrop')?.classList.add('hidden');
    const err = el('adminRanchesEditError');
    if (err) {
      err.textContent = '';
      err.classList.add('hidden');
    }
  }

  function hidePlaceModal() {
    el('adminRanchesPlaceModal')?.classList.add('hidden');
    el('adminRanchesPlaceBackdrop')?.classList.add('hidden');
    const err = el('adminRanchesPlaceError');
    if (err) {
      err.textContent = '';
      err.classList.add('hidden');
    }
  }

  function showPlaceModal() {
    hideEditModal();
    hideDeleteModal();
    const fields = ['adminRanchesPlaceName', 'adminRanchesPlaceJob', 'adminRanchesPlacePrice', 'adminRanchesPlaceRadius'];
    fields.forEach((id, i) => {
      const node = el(id);
      if (!node) return;
      if (i === 1) node.value = 'rancher';
      else if (i === 2) node.value = '0';
      else if (i === 3) node.value = '100';
      else node.value = '';
    });
    const errEl = el('adminRanchesPlaceError');
    if (errEl) {
      errEl.textContent = '';
      errEl.classList.add('hidden');
    }
    el('adminRanchesPlaceBackdrop')?.classList.remove('hidden');
    el('adminRanchesPlaceModal')?.classList.remove('hidden');
    window.setTimeout(() => el('adminRanchesPlaceName')?.focus(), 60);
  }

  function syncEditOwnerFieldsDisabled() {
    const noOwner = !!el('adminRanchesEditNoOwner')?.checked;
    const ownerIn = el('adminRanchesEditOwnerCharId');
    const ownerSid = el('adminRanchesEditOwnerServerId');
    if (ownerIn) ownerIn.disabled = noOwner;
    if (ownerSid) ownerSid.disabled = noOwner;
  }

  function showEditModal(ranchId) {
    hidePlaceModal();
    hideDeleteModal();
    const sid = Number(ranchId);
    const row = adminList.find((x) => Number(x.id) === sid);
    if (!row) return;
    const hint = el('adminRanchesEditHint');
    if (hint) hint.textContent = tAdmin('editHint', { id: sid });
    if (el('adminRanchesEditName')) el('adminRanchesEditName').value = row.name != null ? String(row.name) : '';
    if (el('adminRanchesEditJob')) el('adminRanchesEditJob').value = row.job != null ? String(row.job) : 'rancher';
    if (el('adminRanchesEditPrice')) el('adminRanchesEditPrice').value = String(row.price != null ? row.price : 0);
    if (el('adminRanchesEditRadius')) el('adminRanchesEditRadius').value = String(row.radius != null ? row.radius : 100);
    const hasOwner = !!(row.owner && row.is_owned);
    if (el('adminRanchesEditOwnerCharId')) {
      el('adminRanchesEditOwnerCharId').value = hasOwner && row.owner != null ? String(row.owner) : '';
    }
    if (el('adminRanchesEditOwnerServerId')) el('adminRanchesEditOwnerServerId').value = '';
    if (el('adminRanchesEditNoOwner')) el('adminRanchesEditNoOwner').checked = !hasOwner;
    if (el('adminRanchesEditUsePosition')) el('adminRanchesEditUsePosition').checked = false;
    syncEditOwnerFieldsDisabled();
    const errEl = el('adminRanchesEditError');
    if (errEl) {
      errEl.textContent = '';
      errEl.classList.add('hidden');
    }
    adminEditId = sid;
    el('adminRanchesEditBackdrop')?.classList.remove('hidden');
    el('adminRanchesEditModal')?.classList.remove('hidden');
    window.setTimeout(() => el('adminRanchesEditName')?.focus(), 60);
  }

  function renderTable() {
    const tbody = el('adminRanchesTbody');
    const emptyEl = el('adminRanchesEmptyState');
    const meta = el('adminRanchesCountMeta');
    if (!tbody) return;

    const rows = getFiltered();
    const total = adminList.length;

    if (meta) {
      meta.textContent =
        rows.length === total
          ? tAdmin('countTotal', { count: total })
          : tAdmin('countFiltered', { shown: rows.length, total });
    }

    tbody.innerHTML = '';
    if (!rows.length) {
      emptyEl?.classList.remove('hidden');
      return;
    }
    emptyEl?.classList.add('hidden');

    rows.forEach((r) => {
      const rid = Number(r.id);
      const name = r.name != null ? String(r.name) : '';
      const job = r.job != null ? String(r.job) : '—';
      const owner = r.owner != null && r.owner !== '' ? String(r.owner) : '—';
      const owned = r.is_owned ? tAdmin('ownedYes') : tAdmin('ownedNo');
      const price = Number(r.price);
      const priceStr = Number.isFinite(price) ? price.toLocaleString() : '0';
      const cx = Number(r.x) || 0;
      const cy = Number(r.y) || 0;
      const cz = Number(r.z) || 0;
      const tr = document.createElement('tr');
      tr.dataset.ranchId = String(rid);
      const ownerTitle = owner !== '—' ? ` title="${escapeHtml(owner)}"` : '';
      tr.innerHTML = `
        <td class="mx-admin-cell--num">${rid}</td>
        <td class="mx-admin-cell--clip"${name ? ` title="${escapeHtml(name)}"` : ''}><span class="mx-admin-clip">${escapeHtml(name) || '—'}</span></td>
        <td class="mx-admin-cell--clip"><span class="mx-admin-clip">${escapeHtml(job)}</span></td>
        <td class="mx-admin-cell--num">${priceStr}</td>
        <td class="mx-admin-cell--num">${Number(r.radius) || 0}</td>
        <td>${escapeHtml(owned)}</td>
        <td class="mx-admin-cell--clip"${ownerTitle}><span class="mx-admin-clip mx-admin-coords">${escapeHtml(formatOwnerShort(owner))}</span></td>
        <td class="mx-admin-cell--clip"><span class="mx-admin-coords">${cx.toFixed(1)}, ${cy.toFixed(1)}, ${cz.toFixed(1)}</span></td>
        <td class="mx-admin-cell--actions">
          <div class="mx-admin-actions">
            <button type="button" class="mx-admin-row-btn mx-admin-row-btn--tp" data-ranch-id="${rid}">${escapeHtml(tAdmin('goto'))}</button>
            <button type="button" class="mx-admin-row-btn mx-admin-row-btn--edit" data-ranch-id="${rid}">${escapeHtml(tAdmin('edit'))}</button>
            <button type="button" class="mx-admin-row-btn mx-admin-row-btn--del" data-ranch-id="${rid}">${escapeHtml(tAdmin('delete'))}</button>
          </div>
        </td>
      `;
      tbody.appendChild(tr);
    });

    tbody.querySelectorAll('.mx-admin-row-btn--tp').forEach((btn) => {
      btn.addEventListener('click', () => {
        const id = Number(btn.getAttribute('data-ranch-id'));
        if (id) post('adminTeleportRanch', { ranchId: id });
      });
    });
    tbody.querySelectorAll('.mx-admin-row-btn--edit').forEach((btn) => {
      btn.addEventListener('click', () => {
        const id = Number(btn.getAttribute('data-ranch-id'));
        if (id) showEditModal(id);
      });
    });
    tbody.querySelectorAll('.mx-admin-row-btn--del').forEach((btn) => {
      btn.addEventListener('click', () => {
        const id = Number(btn.getAttribute('data-ranch-id'));
        if (!id) return;
        const row = adminList.find((x) => Number(x.id) === id);
        const label = row && row.name != null ? String(row.name) : `#${id}`;
        showDeleteModal(id, label);
      });
    });
  }

  async function openAdminPanel(ranches, locale) {
    if (typeof initRanchI18n === 'function') {
      await initRanchI18n(locale || window.RANCH_LOCALE || 'en');
    }
    adminList = Array.isArray(ranches) ? ranches.slice() : [];
    const root = el('adminRanchesRoot');
    if (!root) return;
    hidePlaceModal();
    hideEditModal();
    hideDeleteModal();
    document.body.classList.add('ranch-admin-body--open');
    root.classList.remove('hidden');
    root.setAttribute('aria-hidden', 'false');
    const searchEl = el('adminRanchesSearch');
    if (searchEl) searchEl.value = '';
    applyAdminI18n();
    bindAdminEsc();
    renderTable();
    window.setTimeout(() => searchEl?.focus(), 80);
  }

  function closeAdminPanel() {
    hidePlaceModal();
    hideEditModal();
    hideDeleteModal();
    document.body.classList.remove('ranch-admin-body--open');
    const root = el('adminRanchesRoot');
    root?.classList.add('hidden');
    root?.setAttribute('aria-hidden', 'true');
    adminList = [];
    unbindAdminEsc();
    post('closeAdminRanches', {});
  }

  function setAdminList(ranches) {
    adminList = Array.isArray(ranches) ? ranches.slice() : [];
    renderTable();
  }

  function removeRanchFromList(id) {
    const n = Number(id);
    adminList = adminList.filter((r) => Number(r.id) !== n);
    renderTable();
  }

  function wireAdminEvents() {
    el('adminRanchesBtnClose')?.addEventListener('click', closeAdminPanel);
    el('adminRanchesRefresh')?.addEventListener('click', async () => {
      const body = await post('refreshAdminRanches', {});
      if (body && body.ok && Array.isArray(body.ranches)) setAdminList(body.ranches);
    });
    el('adminRanchesPlaceNew')?.addEventListener('click', showPlaceModal);
    el('adminRanchesSearch')?.addEventListener('input', renderTable);

    el('adminRanchesDeleteBackdrop')?.addEventListener('click', hideDeleteModal);
    el('adminRanchesDeleteModal')?.addEventListener('click', (e) => e.stopPropagation());
    el('adminRanchesDeleteCancel')?.addEventListener('click', hideDeleteModal);
    el('adminRanchesDeleteConfirm')?.addEventListener('click', async () => {
      if (!adminDeleteId) return;
      await post('adminDeleteRanch', { ranchId: adminDeleteId });
      hideDeleteModal();
    });

    el('adminRanchesEditBackdrop')?.addEventListener('click', hideEditModal);
    el('adminRanchesEditModal')?.addEventListener('click', (e) => e.stopPropagation());
    el('adminRanchesEditCancel')?.addEventListener('click', hideEditModal);
    el('adminRanchesEditNoOwner')?.addEventListener('change', syncEditOwnerFieldsDisabled);
    el('adminRanchesEditSave')?.addEventListener('click', async () => {
      const errEl = el('adminRanchesEditError');
      if (!adminEditId) return;
      const name = el('adminRanchesEditName')?.value?.trim() ?? '';
      const job = el('adminRanchesEditJob')?.value?.trim() ?? '';
      const price = el('adminRanchesEditPrice')?.value?.trim() ?? '';
      const radius = el('adminRanchesEditRadius')?.value?.trim() ?? '';
      const usePosition = !!el('adminRanchesEditUsePosition')?.checked;
      const noOwner = !!el('adminRanchesEditNoOwner')?.checked;
      const ownerCharId = el('adminRanchesEditOwnerCharId')?.value?.trim() ?? '';
      const ownerServerId = el('adminRanchesEditOwnerServerId')?.value?.trim() ?? '';
      const result = await post('adminUpdateRanch', {
        ranchId: adminEditId,
        name,
        job,
        price,
        radius,
        usePosition,
        noOwner,
        ownerCharId,
        ownerServerId,
      });
      if (result && result.ok) {
        hideEditModal();
        if (Array.isArray(result.ranches)) setAdminList(result.ranches);
        else {
          const ref = await post('refreshAdminRanches', {});
          if (ref && ref.ok && Array.isArray(ref.ranches)) setAdminList(ref.ranches);
        }
        return;
      }
      if (errEl) {
        errEl.textContent = (result && (result.err || result.message)) || tAdmin('saveFailed');
        errEl.classList.remove('hidden');
      }
    });

    el('adminRanchesPlaceBackdrop')?.addEventListener('click', hidePlaceModal);
    el('adminRanchesPlaceModal')?.addEventListener('click', (e) => e.stopPropagation());
    el('adminRanchesPlaceCancel')?.addEventListener('click', hidePlaceModal);
    el('adminRanchesPlaceSave')?.addEventListener('click', async () => {
      const errEl = el('adminRanchesPlaceError');
      const name = el('adminRanchesPlaceName')?.value?.trim() ?? '';
      const job = el('adminRanchesPlaceJob')?.value?.trim() ?? 'rancher';
      const price = el('adminRanchesPlacePrice')?.value?.trim() ?? '0';
      const radius = el('adminRanchesPlaceRadius')?.value?.trim() ?? '100';
      const result = await post('adminCreateRanch', { name, job, price, radius });
      if (result && result.ok) {
        hidePlaceModal();
        if (Array.isArray(result.ranches)) setAdminList(result.ranches);
        else {
          const ref = await post('refreshAdminRanches', {});
          if (ref && ref.ok && Array.isArray(ref.ranches)) setAdminList(ref.ranches);
        }
        return;
      }
      if (errEl) {
        errEl.textContent = (result && (result.err || result.message)) || tAdmin('createFailed');
        errEl.classList.remove('hidden');
      }
    });

    const bannerImg = el('adminRanchesBannerImage');
    if (bannerImg) {
      bannerImg.addEventListener('error', () => {
        bannerImg.src = 'img/menu_button_1.png';
      });
    }
  }

  window.addEventListener('message', (ev) => {
    const msg = ev.data;
    if (!msg) return;
    if (msg.action === 'openAdminRanches') {
      openAdminPanel(msg.ranches || [], msg.locale);
    }
    if (msg.action === 'adminRanchRemoved') {
      removeRanchFromList(msg.ranchId);
    }
    if (msg.action === 'adminRanchesList') {
      setAdminList(msg.ranches || []);
    }
  });

  document.addEventListener('DOMContentLoaded', async () => {
    if (typeof initRanchI18n === 'function' && !window.RANCH_STRINGS) {
      await initRanchI18n();
    }
    applyAdminI18n();
    wireAdminEvents();
  });
})();
