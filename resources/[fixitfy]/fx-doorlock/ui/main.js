$(document).ready(function () {

    // ─── Convert State ───────────────────────────────────────────────────────
    let convertBusy   = false;
    let convertLocale = {};

    // ─── Progress Bar State ──────────────────────────────────────────────────
    var ImgPath           = '';
    var progressbarActive = false;
    var progressbarTimeout = null;

    // ─── State ───────────────────────────────────────────────────────────────
    let state = {
        jobs:              [],
        charIds:           [],
        groups:            [],
        isEdit:            false,
        isCustomDoor:      false,  // true when saving a custom door
        doorId:            null,
        doorList:          [],   // full door list (for pairedDoorName lookup)
        pairedDoorId:      null,
        pairedDoorName:    null,
        hasSecondDoor:     false,  // true when doors[] contains 2 entities
        previousSettings:  null,   // last saved door's job/charId/group settings
        metalKey:          false,  // door key item access enabled
        doorKeyMaxCreate:  3,      // max allowed, received from config via openMenu
        doorKeyItem:       '',     // item name, received from config (empty = feature disabled)
    };
    let scanActive = false;
    let scanMaxDist = 12;
    const scanMarkerEls = new Map();

    // ─── NUI Messages ────────────────────────────────────────────────────────
    window.addEventListener('message', function (event) {
        const data = event.data;

        if (data.action === 'openConvertMenu') {
            openConvertMenu(data);
        } else if (data.action === 'convertStart') {
            onConvertStart(data.total);
        } else if (data.action === 'convertProgress') {
            onConvertProgress(data.current, data.total, data.added, data.duped, data.failed || 0);
        } else if (data.action === 'convertDone') {
            onConvertDone(data.added, data.duped, data.failed || 0);
        } else if (data.action === 'convertError') {
            onConvertError(data.error);
        } else if (data.action === 'openMenu') {
            openMenu(data);
        } else if (data.action === 'closeMenu') {
            closeMenu();
        } else if (data.action === 'pairedDoorSelected') {
                // Pairing done; set selected door as paired door
            state.pairedDoorId   = String(data.doorId);
            state.pairedDoorName = data.doorName || 'Door';
            updatePairedDoorDisplay();
            // Show paired heading field and read its current heading
            $('#section-paired-heading').show();
            fetchPairedHeading(state.pairedDoorId);
            $('#main-container').fadeIn(200);
        } else if (data.action === 'secondDoorSelected') {
            // Unregistered door selected as second physical panel
            state.pairedDoorId   = '__second__';
            state.pairedDoorName = data.name || 'Door';
            updatePairedDoorDisplay();
            $('#section-paired-heading').show();
            $('#paired-door-heading').val(Number(data.heading || 0).toFixed(2));
            $('#main-container').fadeIn(200);
        } else if (data.action === 'pairingCancelled') {
                // Pairing cancelled: restore main menu
            $('#main-container').fadeIn(200);
        } else if (data.action === 'setScanMode') {
            setScanMode(data.active);
            if (!data.active) clearScanMarkers();
        } else if (data.action === 'updateScanMarkers') {
            if (data.maxDist) scanMaxDist = data.maxDist;
            renderScanMarkers(data.markers || []);
        } else if (data.action === 'openCustomDoorInput') {
            openCustomDoorInput();
        } else if (data.action === 'ProgressBar') {
            const imgSrc      = 'nui://' + ImgPath + data.item + '.png';
            const fallbackSrc = 'nui://vorp_inventory/html/img/items/lockpick.png';
            const $img = $('#progressbar-img');
            $img.off('error').on('error', function () { $(this).attr('src', fallbackSrc); });
            $img.attr('src', imgSrc);
            startCustomProgressBar(data.text, data.duration);
        } else if (data.action === 'cancelProgressBar') {
            cancelCustomProgressBar();
        } else if (data.action === 'setFramework') {
            if (data.framework === 'RSG') {
                ImgPath = 'rsg-inventory/html/images/';
            } else if (data.framework === 'VORP') {
                ImgPath = 'vorp_inventory/html/img/items/';
            }
        } else if (data.action === 'charIdLookupResult') {
            if (data.charId) {
                $('#add-charid').val(data.charId);
                $('#lookup-server-id').val('');
                $('#charid-lookup-status').text('Found: ' + data.charId).css('color', '#c9a86c').show();
                setTimeout(function () { $('#charid-lookup-status').fadeOut(300, function () { $(this).hide(); }); }, 3000);
            } else {
                $('#charid-lookup-status').text('Player not found or not online').css('color', '#c40000').show();
                setTimeout(function () { $('#charid-lookup-status').fadeOut(300, function () { $(this).hide(); }); }, 3000);
            }
        }
    });

    // ─── Menu Open / Close ───────────────────────────────────────────────────
    function openMenu(data) {
        state.doorList         = data.doorList || [];
        state.doorKeyMaxCreate = data.doorKeyMaxCreate || 3;
        state.doorKeyItem      = data.doorKeyItem      || '';
        state.isCustomDoor     = (data.mode === 'customdoor');

        // Apply locale descriptions
        const loc = data.locale || {};
        if (loc.desc_locked)       { $('#desc-locked').text(loc.desc_locked).show(); }
        if (loc.desc_hidden_lock)  { $('#desc-hidden-lock').text(loc.desc_hidden_lock).show(); }
        if (loc.desc_lockpickable) { $('#desc-lockpickable').text(loc.desc_lockpickable).show(); }
        if (loc.desc_alert_law)    { $('#desc-alert-law').text(loc.desc_alert_law).show(); }
        if (loc.desc_door_key)     { $('#desc-door-key').text(loc.desc_door_key).show(); }
        if (loc.create_keys_hint)  { $('#metalkey-create-hint').text(loc.create_keys_hint); }

        // Update the CREATE KEYS input max based on config
        $('#metalkey-count').attr('max', state.doorKeyMaxCreate);
        $('#metalkey-max-label').text('(max ' + state.doorKeyMaxCreate + ')');

        if (state.isCustomDoor) {
            const doorInfo = data.doorInfo || {};
            const customEdit = !!(data.edit && data.doorData);

            $('#menu-title').text(customEdit ? 'EDIT CUSTOM DOOR' : 'CUSTOM DOOR');
            state.isEdit = customEdit;
            state.doorId = customEdit ? (data.doorData.id || null) : null;

            resetForm();
            $('#btn-delete').toggle(customEdit);

            // Custom door sections
            $('#section-heading').hide();
            $('#section-double-door').hide();
            $('#section-icon-offset').css('display', 'flex');
            $('#section-custom-model').show();
            $('#section-custom-headings').show();

            if (customEdit) {
                $('#door-name').val(data.doorData.name || '');
                $('#toggle-locked').prop('checked',   !!data.doorData.locked);
                $('#toggle-hideLock').prop('checked', !!data.doorData.hideLock);
                $('#toggle-lockpick').prop('checked', !!data.doorData.lockpickable);
                $('#toggle-alert').prop('checked',    !!data.doorData.alertLaw);
                $('#toggle-metalKey').prop('checked', !!data.doorData.metalKey);
                state.metalKey = !!data.doorData.metalKey;
                updateCreateKeysButtonState();
                $('#icon-offset-x').val((data.doorData.iconOffsetX && data.doorData.iconOffsetX !== 0) ? Number(data.doorData.iconOffsetX).toFixed(2) : '');
                $('#icon-offset-y').val((data.doorData.iconOffsetY && data.doorData.iconOffsetY !== 0) ? Number(data.doorData.iconOffsetY).toFixed(2) : '');
                $('#icon-offset-z').val((data.doorData.iconOffsetZ && data.doorData.iconOffsetZ !== 0) ? Number(data.doorData.iconOffsetZ).toFixed(2) : '');
                (data.doorData.jobs || []).forEach(j => addPermItem('job', j, true));
                (data.doorData.charIds || []).forEach(c => addPermItem('charid', c, true));
                (data.doorData.groups || []).forEach(g => addPermItem('group', g, true));
            }

            $('#custom-model-display').text(doorInfo.model || (customEdit ? (data.doorData.model || '—') : '—'));
            const closeHeading = Number((doorInfo.rotation && doorInfo.rotation.z) || 0);
            const openHeading = Number(closeHeading + Number((data.doorData && data.doorData.openAngle) || -90));
            $('#custom-close-heading').val(closeHeading.toFixed(2));
            $('#custom-open-heading').val(openHeading.toFixed(2));

            if (state.previousSettings) $('#section-apply-previous').show();
        } else if (data.edit && data.doorData) {
            $('#menu-title').text('EDIT DOORLOCK');
            state.isEdit = true;
            state.doorId = data.doorData.id || null;
            populateForm(data.doorData);
            updateCreateKeysButtonState();
            // populateForm calls resetForm() which clears hasSecondDoor; restore it afterwards
            state.hasSecondDoor = !!(data.doorData.hasSecondDoor);
            $('#btn-delete').show();
            $('#section-heading').show();
            $('#btn-scan-heading').show();
            if (state.previousSettings) $('#section-apply-previous').show();
            // Double door: show second heading section
            if (state.hasSecondDoor) {
                $('#section-heading-2').show();
            } else {
                $('#section-heading-2').hide();
                $('#door-heading-2').val('');
            }
            // Auto-read headings in edit mode
            setTimeout(function () {
                fetch(`https://${getResourceName()}/getDoorHeading`, {
                    method:  'POST',
                    headers: { 'Content-Type': 'application/json' },
                    body:    JSON.stringify({ doorId: state.doorId, doorIndex: 1 }),
                })
                .then(r => r.json())
                .then(function (res) {
                    if (res.ok && res.heading !== undefined) {
                        $('#door-heading').val(res.heading.toFixed(2));
                    }
                })
                .catch(function () {});
                if (state.hasSecondDoor) {
                    fetch(`https://${getResourceName()}/getDoorHeading`, {
                        method:  'POST',
                        headers: { 'Content-Type': 'application/json' },
                        body:    JSON.stringify({ doorId: state.doorId, doorIndex: 2 }),
                    })
                    .then(r => r.json())
                    .then(function (res) {
                        if (res.ok && res.heading !== undefined) {
                            $('#door-heading-2').val(res.heading.toFixed(2));
                        }
                    })
                    .catch(function () {});
                }
            }, 300);
        } else {
            $('#menu-title').text('CREATE DOORLOCK');
            state.isEdit = false;
            state.doorId = null;
            resetForm();
            updateCreateKeysButtonState();
            $('#btn-delete').hide();
            $('#section-heading').show();
            $('#btn-scan-heading').hide();
            if (data.initialHeading !== undefined && data.initialHeading !== null) {
                $('#door-heading').val(Number(data.initialHeading).toFixed(2));
            }
            if (state.previousSettings) $('#section-apply-previous').show();
        }
        $('.menu-body').scrollTop(0);
        $('#main-container').fadeIn(200);
    }

    function closeMenu() {
        $('#main-container').fadeOut(200);
        $('#btn-delete').hide();
    }

    // ─── Paired Door Display ─────────────────────────────────────────────────
    function updatePairedDoorDisplay() {
        if (state.pairedDoorId) {
            const label = state.pairedDoorId === '__second__'
                ? (state.pairedDoorName || 'Door')
                : (state.pairedDoorName
                    ? `${state.pairedDoorName} [${state.pairedDoorId}]`
                    : `Door [${state.pairedDoorId}]`);
            $('#paired-door-name').text(label).addClass('selected');
            $('#btn-clear-paired').show();
        } else {
            $('#paired-door-name').text('None (single door)').removeClass('selected');
            $('#btn-clear-paired').hide();
            $('#section-paired-heading').hide();
            $('#paired-door-heading').val('');
        }
    }

    function fetchPairedHeading(doorId) {
        fetch(`https://${getResourceName()}/getDoorHeading`, {
            method:  'POST',
            headers: { 'Content-Type': 'application/json' },
            body:    JSON.stringify({ doorId: doorId }),
        })
        .then(r => r.json())
        .then(function (res) {
            if (res.ok && res.heading !== undefined) {
                $('#paired-door-heading').val(res.heading.toFixed(2));
            }
        })
        .catch(function () {});
    }

    // ─── Form Reset / Populate ───────────────────────────────────────────────
    function resetForm() {
        $('#door-name').val('');
        $('#door-heading').val('');
        $('#toggle-locked').prop('checked',   true);
        $('#toggle-hideLock').prop('checked', false);
        $('#toggle-lockpick').prop('checked', false);
        $('#toggle-alert').prop('checked',    false);
        $('#toggle-metalKey').prop('checked', false);
        state.metalKey = false;
        $('#metalkey-count').val(1);
        $('#section-metalkey-count').hide();

        $('#lookup-server-id').val('');
        $('#charid-lookup-status').hide();

        state.jobs           = [];
        state.charIds        = [];
        state.groups         = [];
        state.pairedDoorId   = null;
        state.pairedDoorName = null;
        state.hasSecondDoor  = false;

        updatePairedDoorDisplay();
        $('#section-paired-heading').hide();
        $('#paired-door-heading').val('');
        $('#btn-select-paired').show();
        $('#section-heading-2').hide();
        $('#door-heading-2').val('');
        $('#section-apply-previous').hide();
        $('#door-name-error').hide();
        $('#icon-offset-x').val('');
        $('#icon-offset-y').val('');
        $('#icon-offset-z').val('');
        // Reset custom door sections back to hidden
        $('#section-custom-model').hide();
        $('#section-custom-headings').hide();
        $('#custom-close-heading').val('');
        $('#custom-open-heading').val('');
        $('#custom-model-display').text('—');
        $('#section-heading').show();
        $('#section-double-door').show();
        $('#section-icon-offset').css('display', 'flex');

        clearList('job');
        clearList('charid');
        clearList('group');
        switchTab('job');
    }

    function populateForm(data) {
        resetForm();
        $('#door-name').val(data.name || '');
        $('#toggle-locked').prop('checked',   !!data.locked);
        $('#toggle-hideLock').prop('checked', !!data.hideLock);
        $('#toggle-lockpick').prop('checked', !!data.lockpickable);
        $('#toggle-alert').prop('checked',    !!data.alertLaw);
        $('#toggle-metalKey').prop('checked', !!data.metalKey);
        state.metalKey = !!data.metalKey;
        $('#metalkey-count').val(1);

        // Double door (2 entities in same record): hide paired door section, only show 2nd heading
        if (data.hasSecondDoor) {
            $('#paired-door-name').text('Double Door').addClass('selected');
            $('#btn-select-paired').hide();
            $('#btn-clear-paired').hide();
        } else if (data.pairedDoorId != null) {
            // Separately registered paired door
            state.pairedDoorId = String(data.pairedDoorId);
            const found = state.doorList.find(d => String(d.id) === state.pairedDoorId);
            state.pairedDoorName = found ? found.name : ('Door ' + state.pairedDoorId);
            updatePairedDoorDisplay();
            $('#section-paired-heading').show();
            fetchPairedHeading(state.pairedDoorId);
        } else {
            state.pairedDoorId   = null;
            state.pairedDoorName = null;
            updatePairedDoorDisplay();
        }

        // Heading is auto-read in edit mode via openMenu
        $('#door-heading').val('');

        // Icon offset delta values (leave blank if 0)
        $('#icon-offset-x').val((data.iconOffsetX && data.iconOffsetX !== 0) ? Number(data.iconOffsetX).toFixed(2) : '');
        $('#icon-offset-y').val((data.iconOffsetY && data.iconOffsetY !== 0) ? Number(data.iconOffsetY).toFixed(2) : '');
        $('#icon-offset-z').val((data.iconOffsetZ && data.iconOffsetZ !== 0) ? Number(data.iconOffsetZ).toFixed(2) : '');

        (data.jobs    || []).forEach(j => addPermItem('job',    j, true));
        (data.charIds || []).forEach(c => addPermItem('charid', c, true));
        (data.groups  || []).forEach(g => addPermItem('group',  g, true));
    }

    // ─── Tab Switching ───────────────────────────────────────────────────────
    function switchTab(tabName) {
        $('.perm-tab').removeClass('active');
        $(`.perm-tab[data-tab="${tabName}"]`).addClass('active');
        $('.perm-content').removeClass('active');
        $(`#tab-${tabName}`).addClass('active');
    }

    $('.perm-tab').on('click', function () {
        switchTab($(this).data('tab'));
    });

    // ─── Permission Helpers ──────────────────────────────────────────────────
    function stateKey(type) {
        if (type === 'job')    return 'jobs';
        if (type === 'charid') return 'charIds';
        return 'groups';
    }

    function emptyText(type) {
        if (type === 'job')    return 'No jobs added';
        if (type === 'charid') return 'No IDs added';
        return 'No groups added';
    }

    function clearList(type) {
        $(`#list-${type}`).html(`<div class="perm-empty">${emptyText(type)}</div>`);
    }

    function addPermItem(type, value, skipDupeCheck) {
        if (!value || !value.toString().trim()) return;
        value = value.toString().trim();

        const key = stateKey(type);
        if (!skipDupeCheck && state[key].includes(value)) return;

        state[key].push(value);
        $(`#list-${type} .perm-empty`).remove();

        const $item = $(`
            <div class="perm-item" data-value="${value}">
                <span>${value}</span>
                <span class="perm-remove" title="Remove">×</span>
            </div>
        `);

        $item.find('.perm-remove').on('click', function () {
            const val = $item.data('value').toString();
            state[key] = state[key].filter(i => i !== val);
            $item.remove();
            if ($(`#list-${type}`).children().length === 0) {
                $(`#list-${type}`).html(`<div class="perm-empty">${emptyText(type)}</div>`);
            }
        });

        $(`#list-${type}`).append($item);
    }

    // ─── Add Buttons ─────────────────────────────────────────────────────────
    function setupAddBtn(type) {
        const $input = $(`#add-${type}`);
        const $btn   = $(`#btn-add-${type}`);

        $btn.on('click', function () {
            addPermItem(type, $input.val());
            $input.val('').focus();
        });

        $input.on('keypress', function (e) {
            if (e.key === 'Enter') {
                addPermItem(type, $(this).val());
                $(this).val('');
            }
        });
    }

    setupAddBtn('job');
    setupAddBtn('charid');
    setupAddBtn('group');

    // ─── Door Key: helper + CREATE button ────────────────────────────────────
    function updateCreateKeysButtonState() {
        if (state.metalKey && state.doorKeyItem) {
            const maxVal = state.doorKeyMaxCreate || 3;
            $('#metalkey-count').attr('max', maxVal);
            const cur = parseInt($('#metalkey-count').val()) || 1;
            if (cur > maxVal) $('#metalkey-count').val(maxVal);
            $('#metalkey-max-label').text('(max ' + maxVal + ')');
            $('#section-metalkey-count').show();
            if (state.isEdit) {
                $('#btn-create-keys').css({ opacity: '1', pointerEvents: 'auto', cursor: 'pointer' });
                $('#metalkey-create-hint').hide();
            } else {
                $('#btn-create-keys').css({ opacity: '0.35', pointerEvents: 'none', cursor: 'not-allowed' });
                $('#metalkey-create-hint').show();
            }
        } else {
            $('#section-metalkey-count').hide();
        }
    }

    $('#btn-create-keys').on('click', function () {
        if (!state.isEdit || !state.metalKey || !state.doorKeyItem || !state.doorId) return;
        const count = Math.min(parseInt($('#metalkey-count').val()) || 1, state.doorKeyMaxCreate || 3);
        fetch(`https://${getResourceName()}/createDoorKeys`, {
            method:  'POST',
            headers: { 'Content-Type': 'application/json' },
            body:    JSON.stringify({ id: state.doorId, keyCount: count }),
        });
    });

    // ─── Door Key Toggle: show/hide CREATE KEYS section ──────────────────────
    $('#toggle-metalKey').on('change', function () {
        state.metalKey = $(this).is(':checked');
        if (!state.metalKey) $('#metalkey-count').val(1);
        updateCreateKeysButtonState();
    });

    // ─── Char ID: Server ID Lookup ────────────────────────────────────────────
    $('#btn-lookup-charid').on('click', function () {
        const sid = parseInt($('#lookup-server-id').val());
        if (!sid || sid < 1) return;
        $('#charid-lookup-status').text('Looking up...').css('color', '#888').show();
        fetch(`https://${getResourceName()}/lookupCharId`, {
            method:  'POST',
            headers: { 'Content-Type': 'application/json' },
            body:    JSON.stringify({ serverId: sid }),
        });
    });

    $('#lookup-server-id').on('keypress', function (e) {
        if (e.key === 'Enter') $('#btn-lookup-charid').trigger('click');
    });

    // ─── Paired Door: Select / Clear ─────────────────────────────────────────
    $('#btn-select-paired').on('click', function () {
        $('#main-container').fadeOut(200);
        fetch(`https://${getResourceName()}/startPairingMode`, {
            method:  'POST',
            headers: { 'Content-Type': 'application/json' },
            body:    JSON.stringify({ excludeId: state.doorId }),
        });
    });

    $('#btn-clear-paired').on('click', function () {
        state.pairedDoorId   = null;
        state.pairedDoorName = null;
        updatePairedDoorDisplay();
    });

    // ─── Paired Door Heading ──────────────────────────────────────────────────
    let pairedHeadingPreviewTimer = null;
    $('#paired-door-heading').on('input', function () {
        if (!state.pairedDoorId) return;
        const h = parseFloat($(this).val());
        if (isNaN(h)) return;
        clearTimeout(pairedHeadingPreviewTimer);
        pairedHeadingPreviewTimer = setTimeout(function () {
            let body;
            if (state.pairedDoorId === '__second__') {
                // Create mode: second door entity (pendingDoor.secondDoor)
                body = { useSecondDoor: true, heading: h };
            } else {
                // Edit mode: separately registered paired door
                body = { doorId: state.pairedDoorId, heading: h };
            }
            fetch(`https://${getResourceName()}/previewHeading`, {
                method:  'POST',
                headers: { 'Content-Type': 'application/json' },
                body:    JSON.stringify(body),
            });
        }, 150);
    });

    $('#btn-scan-paired-heading').on('click', function () {
        if (!state.pairedDoorId) return;
        fetchPairedHeading(state.pairedDoorId);
    });

    // ─── Apply Previous Settings ─────────────────────────────────────────────
    $('#btn-apply-previous').on('click', function () {
        if (!state.previousSettings) return;
        const prev = state.previousSettings;
        // Reset lists and refill with previous settings
        state.jobs    = []; clearList('job');
        state.charIds = []; clearList('charid');
        state.groups  = []; clearList('group');
        prev.jobs.forEach(j    => addPermItem('job',    j, true));
        prev.charIds.forEach(c => addPermItem('charid', c, true));
        prev.groups.forEach(g  => addPermItem('group',  g, true));
        // Restore toggles
        if (prev.locked      !== undefined) $('#toggle-locked').prop('checked',   prev.locked);
        if (prev.hideLock    !== undefined) $('#toggle-hideLock').prop('checked', prev.hideLock);
        if (prev.lockpickable !== undefined) $('#toggle-lockpick').prop('checked', prev.lockpickable);
        if (prev.alertLaw    !== undefined) $('#toggle-alert').prop('checked',   prev.alertLaw);
    });

    // ─── Door 2 Heading: live preview ────────────────────────────────────────
    let heading2PreviewTimer = null;
    $('#door-heading-2').on('input', function () {
        if (!state.isEdit || !state.doorId) return;
        const h = parseFloat($(this).val());
        if (isNaN(h)) return;
        clearTimeout(heading2PreviewTimer);
        heading2PreviewTimer = setTimeout(function () {
            fetch(`https://${getResourceName()}/previewHeading`, {
                method:  'POST',
                headers: { 'Content-Type': 'application/json' },
                body:    JSON.stringify({ doorId: state.doorId, heading: h, doorIndex: 2 }),
            });
        }, 150);
    });

    $('#btn-scan-heading-2').on('click', function () {
        if (!state.isEdit || !state.doorId) return;
        fetch(`https://${getResourceName()}/getDoorHeading`, {
            method:  'POST',
            headers: { 'Content-Type': 'application/json' },
            body:    JSON.stringify({ doorId: state.doorId, doorIndex: 2 }),
        })
        .then(r => r.json())
        .then(function (res) {
            if (res.ok && res.heading !== undefined) {
                $('#door-heading-2').val(res.heading.toFixed(2));
            }
        });
    });

    // ─── Icon Offset: live preview ───────────────────────────────────────────
    let iconOffsetPreviewTimer = null;
    function sendIconOffsetPreview() {
        clearTimeout(iconOffsetPreviewTimer);
        iconOffsetPreviewTimer = setTimeout(function () {
            const x = parseFloat($('#icon-offset-x').val()) || 0;
            const y = parseFloat($('#icon-offset-y').val()) || 0;
            const z = parseFloat($('#icon-offset-z').val()) || 0;
            fetch(`https://${getResourceName()}/previewIconOffset`, {
                method:  'POST',
                headers: { 'Content-Type': 'application/json' },
                body:    JSON.stringify({ x, y, z }),
            });
        }, 100);
    }
    $('#icon-offset-x, #icon-offset-y, #icon-offset-z').on('input', sendIconOffsetPreview);

    // ─── Custom Door Headings: live preview ─────────────────────────────────
    let customHeadingPreviewTimer = null;
    function sendCustomHeadingPreview(mode, headingValue) {
        if (!state.isCustomDoor) return;
        clearTimeout(customHeadingPreviewTimer);
        customHeadingPreviewTimer = setTimeout(function () {
            fetch(`https://${getResourceName()}/previewCustomDoorHeading`, {
                method:  'POST',
                headers: { 'Content-Type': 'application/json' },
                body:    JSON.stringify({ mode: mode, heading: headingValue, doorId: state.doorId || null }),
            });
        }, 80);
    }

    $('#custom-close-heading').on('input', function () {
        const h = parseFloat($(this).val());
        if (isNaN(h)) return;
        sendCustomHeadingPreview('close', h);
    });

    $('#custom-open-heading').on('input', function () {
        const h = parseFloat($(this).val());
        if (isNaN(h)) return;
        sendCustomHeadingPreview('open', h);
    });

    // ─── Save ────────────────────────────────────────────────────────────────
    $('#btn-save').on('click', function () {
        const name = $('#door-name').val().trim();
        if (!name) {
            $('#door-name').addClass('error');
            setTimeout(() => $('#door-name').removeClass('error'), 450);
            return;
        }

        // Duplicate name check
        const isDuplicate = state.doorList.some(function (d) {
            return d.name === name && String(d.id) !== String(state.doorId);
        });
        if (isDuplicate) {
            $('#door-name').addClass('error');
            $('#door-name-error').show();
            setTimeout(function () {
                $('#door-name').removeClass('error');
                $('#door-name-error').hide();
            }, 2500);
            return;
        }
        $('#door-name-error').hide();

        const headingRaw       = parseFloat($('#door-heading').val());
        const heading2Raw      = parseFloat($('#door-heading-2').val());
        const pairedHeadingRaw = parseFloat($('#paired-door-heading').val());
        const iconOffsetXRaw   = parseFloat($('#icon-offset-x').val());
        const iconOffsetYRaw   = parseFloat($('#icon-offset-y').val());
        const iconOffsetZRaw   = parseFloat($('#icon-offset-z').val());

        const payload = {
            name:              name,
            jobs:              state.jobs,
            charIds:           state.charIds,
            groups:            state.groups,
            locked:            $('#toggle-locked').is(':checked'),
            hideLock:          $('#toggle-hideLock').is(':checked'),
            lockpickable:      $('#toggle-lockpick').is(':checked'),
            alertLaw:          $('#toggle-alert').is(':checked'),
            metalKey:          $('#toggle-metalKey').is(':checked'),
            // '__second__' = same-entry double door (doors[2]); not a real pairedDoorId
            pairedDoorId:      (state.pairedDoorId && state.pairedDoorId !== '__second__') ? state.pairedDoorId : null,
            heading:           isNaN(headingRaw) ? null : headingRaw,
            pairedDoorHeading: (state.pairedDoorId && state.pairedDoorId !== '__second__' && !isNaN(pairedHeadingRaw)) ? pairedHeadingRaw : null,
            // Double door (same entry): second door heading
            secondHeading:     (state.pairedDoorId === '__second__' && !isNaN(pairedHeadingRaw)) ? pairedHeadingRaw : null,
            // Icon offset delta (0 or NaN → null → server stores nil)
            iconOffsetX:       (!isNaN(iconOffsetXRaw) && iconOffsetXRaw !== 0) ? iconOffsetXRaw : null,
            iconOffsetY:       (!isNaN(iconOffsetYRaw) && iconOffsetYRaw !== 0) ? iconOffsetYRaw : null,
            iconOffsetZ:       (!isNaN(iconOffsetZRaw) && iconOffsetZRaw !== 0) ? iconOffsetZRaw : null,
            isEdit:            state.isEdit,
            id:                state.doorId,
        };

        // Save settings for Apply Previous button (metalKey/keyCount excluded — always defaults to OFF)
        state.previousSettings = {
            jobs:         [...state.jobs],
            charIds:      [...state.charIds],
            groups:       [...state.groups],
            locked:       $('#toggle-locked').is(':checked'),
            hideLock:     $('#toggle-hideLock').is(':checked'),
            lockpickable: $('#toggle-lockpick').is(':checked'),
            alertLaw:     $('#toggle-alert').is(':checked'),
        };

        const saveCallback = state.isCustomDoor
            ? (state.isEdit ? 'updateCustomDoor' : 'saveCustomDoor')
            : (state.isEdit ? 'saveDoor'         : 'saveDoor');

        if (state.isCustomDoor) {
            // Custom door payload — close/open heading => openAngle delta
            const closeHeadingRaw = parseFloat($('#custom-close-heading').val());
            const openHeadingRaw  = parseFloat($('#custom-open-heading').val());
            const closeHeading = isNaN(closeHeadingRaw) ? 0 : closeHeadingRaw;
            const openHeading  = isNaN(openHeadingRaw)  ? (closeHeading - 90) : openHeadingRaw;

            payload.closeHeading = closeHeading;
            payload.openHeading  = openHeading;
            payload.openAngle    = openHeading - closeHeading;

            delete payload.heading;
            delete payload.pairedDoorHeading;
            delete payload.secondHeading;
        }

        fetch(`https://${getResourceName()}/${saveCallback}`, {
            method:  'POST',
            headers: { 'Content-Type': 'application/json' },
            body:    JSON.stringify(payload),
        });

        // Persist headings in edit mode
        if (state.isEdit && state.doorId) {
            if (payload.heading !== null) {
                fetch(`https://${getResourceName()}/updateHeading`, {
                    method:  'POST',
                    headers: { 'Content-Type': 'application/json' },
                    body:    JSON.stringify({ doorId: state.doorId, heading: payload.heading, doorIndex: 1 }),
                });
            }
            if (state.hasSecondDoor && !isNaN(heading2Raw)) {
                fetch(`https://${getResourceName()}/updateHeading`, {
                    method:  'POST',
                    headers: { 'Content-Type': 'application/json' },
                    body:    JSON.stringify({ doorId: state.doorId, heading: heading2Raw, doorIndex: 2 }),
                });
            }
        }

        closeMenu();
    });

    // ─── Delete ──────────────────────────────────────────────────────────────
    $('#btn-delete').on('click', function () {
        if (!state.doorId) return;

        const deleteCallback = state.isCustomDoor ? 'deleteCustomDoor' : 'deleteDoor';

        fetch(`https://${getResourceName()}/${deleteCallback}`, {
            method:  'POST',
            headers: { 'Content-Type': 'application/json' },
            body:    JSON.stringify({ id: state.doorId }),
        });

        closeMenu();
    });

    // ─── Heading: live preview (rotate door on input change) ─────────────────
    let headingPreviewTimer = null;
    $('#door-heading').on('input', function () {
        const h = parseFloat($(this).val());
        if (isNaN(h)) return;
        clearTimeout(headingPreviewTimer);
        headingPreviewTimer = setTimeout(function () {
            fetch(`https://${getResourceName()}/previewHeading`, {
                method:  'POST',
                headers: { 'Content-Type': 'application/json' },
                // null doorId: Lua uses pendingDoor entity (create mode)
                body:    JSON.stringify({ doorId: state.doorId || null, heading: h }),
            });
        }, 150);
    });

    // ─── Scan Heading: read current entity heading into input ────────────────
    $('#btn-scan-heading').on('click', function () {
        if (!state.isEdit || !state.doorId) return;
        fetch(`https://${getResourceName()}/getDoorHeading`, {
            method:  'POST',
            headers: { 'Content-Type': 'application/json' },
            body:    JSON.stringify({ doorId: state.doorId }),
        })
        .then(r => r.json())
        .then(function (res) {
            if (res.ok && res.heading !== undefined) {
                $('#door-heading').val(res.heading.toFixed(2));
            }
        });
    });

    // ─── Cancel ──────────────────────────────────────────────────────────────
    $('#btn-cancel').on('click', function () {
        fetch(`https://${getResourceName()}/closeMenu`, {
            method:  'POST',
            headers: { 'Content-Type': 'application/json' },
            body:    JSON.stringify({}),
        });
        closeMenu();
    });

    // ─── Scan Mode Overlay ───────────────────────────────────────────────────
    function setScanMode(active) {
        scanActive = !!active;
        if (active) {
            $('#scan-overlay').addClass('active');
        } else {
            $('#scan-overlay').removeClass('active');
        }
    }

    function clearScanMarkers() {
        $('#scan-overlay').empty();
        scanMarkerEls.clear();
    }

    function renderScanMarkers(markers) {
        const $overlay = $('#scan-overlay');
        const activeIds = new Set();

        markers.forEach(function (m) {
            const id = String(m.id);
            const isClosest = !!m.closest;
            activeIds.add(id);

            let $marker = scanMarkerEls.get(id);
            if (!$marker) {
                $marker = $(`
                    <div class="scan-marker" data-id="${id}">
                        <div class="scan-marker-circle">
                            <iconify-icon icon="game-icons:steel-door" class="scan-door-icon"></iconify-icon>
                        </div>
                        <div class="scan-marker-label"></div>
                    </div>
                `);

                $marker.on('click', function () {
                    fetch(`https://${getResourceName()}/selectScanDoor`, {
                        method:  'POST',
                        headers: { 'Content-Type': 'application/json' },
                        body:    JSON.stringify({ id }),
                    });
                });

                scanMarkerEls.set(id, $marker);
                $overlay.append($marker);
            }

            $marker.css({
                left:      `${m.x}%`,
                top:       `${m.y}%`,
                transform: calcTransform(m.dist, isClosest),
                opacity:   calcOpacity(m.dist),
            });
            $marker.toggleClass('scan-marker--closest', isClosest);

            const $label = $marker.find('.scan-marker-label');
            $label
                .toggleClass('label--registered', !!m.registered)
                .toggleClass('label--unregistered', !m.registered)
                .text(`${m.registered ? '🔒 ' : ''}${m.name || 'Door'}`);
        });

        for (const [id, $marker] of scanMarkerEls.entries()) {
            if (!activeIds.has(id)) {
                $marker.remove();
                scanMarkerEls.delete(id);
            }
        }
    }

    function calcTransform(dist, isClosest) {
        const t     = Math.min((dist || 0) / (scanMaxDist || 12), 1);
        const scale = ((isClosest ? 1.45 : 1.25) - t * 0.75).toFixed(3);
        return `translate(-50%, -100%) scale(${scale})`;
    }

    function calcOpacity(dist) {
        const t = Math.min((dist || 0) / (scanMaxDist || 12), 1);
        return (1.0 - t * 0.45).toFixed(3);
    }

    $(document).on('keydown', function (e) {
        if (e.key === 'Escape') {
            if (scanActive) {
                e.preventDefault();
                fetch(`https://${getResourceName()}/exitScanMode`, {
                    method:  'POST',
                    headers: { 'Content-Type': 'application/json' },
                    body:    JSON.stringify({}),
                });
            } else if ($('#convert-overlay').hasClass('active') && !convertBusy) {
                closeConvertMenu();
            } else if ($('#main-container').is(':visible')) {
                $('#btn-cancel').trigger('click');
            }
        }
    });

    // ─── Convert Menu ────────────────────────────────────────────────────────

    function openConvertMenu(data) {
        const loc = (data && data.locale) ? data.locale : {};
        convertLocale = loc;

        // Apply locale strings to DOM
        if (loc.convert_title)         $('#convert-title-text').text(loc.convert_title);
        if (loc.convert_scripts_label) $('#convert-scripts-label').text(loc.convert_scripts_label);
        if (loc.convert_paste_label)   $('#convert-paste-label').text(loc.convert_paste_label);
        if (loc.convert_placeholder)   $('#convert-textarea').attr('placeholder', loc.convert_placeholder);
        if (loc.convert_btn_close)     $('#convert-btn-close-text').text(loc.convert_btn_close);
        if (loc.convert_btn_convert)   $('#convert-btn-convert-text').text(loc.convert_btn_convert);

        convertBusy = false;
        $('#convert-textarea').val('').prop('disabled', false);
        $('#convert-progress-wrap').removeClass('visible');
        $('#convert-bar-fill').css('width', '0%');
        $('#convert-progress-text').text('');
        $('#btn-convert-start').removeClass('converting');
        $('#convert-overlay').addClass('active');
    }

    function closeConvertMenu() {
        $('#convert-overlay').removeClass('active');
        fetch(`https://${getResourceName()}/closeConvertMenu`, {
            method:  'POST',
            headers: { 'Content-Type': 'application/json' },
            body:    JSON.stringify({}),
        });
    }

    function onConvertStart(total) {
        convertBusy = true;
        $('#convert-progress-wrap').addClass('visible');
        $('#convert-bar-fill').css('width', '0%');
        const status = convertLocale.convert_status_sending || 'Converting...';
        $('#convert-progress-text').text(status + '  0 / ' + total);
    }

    function onConvertProgress(current, total, added, duped, failed) {
        const pct = total > 0 ? Math.min(Math.round((current / total) * 100), 99) : 0;
        $('#convert-bar-fill').css('width', pct + '%');
        const loc = convertLocale;
        let txt = current + ' / ' + total + '  —  ' +
                  added   + ' ' + (loc.convert_lbl_added  || 'doors added')    + ',  ' +
                  duped   + ' ' + (loc.convert_lbl_exists || 'already exist');
        if (failed > 0) txt += ',  ' + failed + ' ' + (loc.convert_lbl_failed || 'failed');
        $('#convert-progress-text').text(txt);
    }

    function onConvertDone(added, duped, failed) {
        convertBusy = false;
        $('#convert-bar-fill').css('width', '100%');
        const loc = convertLocale;
        let msg = added + ' ' + (loc.convert_lbl_added || 'doors added');
        if (duped  > 0) msg += ',  ' + duped  + ' ' + (loc.convert_lbl_exists || 'already exist');
        if (failed > 0) msg += ',  ' + failed + ' ' + (loc.convert_lbl_failed || 'failed');
        $('#convert-progress-text').html(
            '<span style="color:#c9a86c">✓  ' + (loc.convert_done_prefix || 'Done') + '  —  ' + msg + '</span>'
        );
        $('#convert-textarea').val('').prop('disabled', false);
        $('#btn-convert-start').removeClass('converting');
    }

    function onConvertError(err) {
        convertBusy = false;
        $('#convert-progress-wrap').addClass('visible');
        const loc = convertLocale;
        $('#convert-progress-text').html(
            '<span style="color:#c40000">✗  ' + (loc.convert_err_prefix || 'Error:') + ' ' + err + '</span>'
        );
        $('#convert-textarea').prop('disabled', false);
        $('#btn-convert-start').removeClass('converting');
    }

    $('#btn-convert-start').on('click', function () {
        if (convertBusy) return;
        const text = $('#convert-textarea').val().trim();
        if (!text) {
            $('#convert-textarea').addClass('error');
            setTimeout(function () { $('#convert-textarea').removeClass('error'); }, 450);
            return;
        }
        convertBusy = true;
        $(this).addClass('converting');
        $('#convert-textarea').prop('disabled', true);
        $('#convert-progress-wrap').addClass('visible');
        $('#convert-progress-text').text(convertLocale.convert_status_sending || 'Sending to server...');
        $('#convert-bar-fill').css('width', '0%');

        fetch(`https://${getResourceName()}/startConvert`, {
            method:  'POST',
            headers: { 'Content-Type': 'application/json' },
            body:    JSON.stringify({ text: text }),
        });
    });

    $('#btn-convert-cancel').on('click', function () {
        if (!convertBusy) closeConvertMenu();
    });

    // ─── Custom Door Input ───────────────────────────────────────────────────

    function openCustomDoorInput() {
        $('#custom-door-model-input').val('');
        $('#custom-door-model-error').hide();
        $('#custom-door-overlay').fadeIn(200);
        setTimeout(function () { $('#custom-door-model-input').focus(); }, 250);
    }

    function closeCustomDoorInput() {
        $('#custom-door-overlay').fadeOut(200);
    }

    function normalizeModelInput(raw) {
        return String(raw || '')
            .trim()
            .replace(/^["'`]+|["'`]+$/g, '')
            .toLowerCase();
    }

    $('#btn-custom-door-cancel').on('click', function () {
        closeCustomDoorInput();
        fetch(`https://${getResourceName()}/closeMenu`, {
            method:  'POST',
            headers: { 'Content-Type': 'application/json' },
            body:    JSON.stringify({}),
        });
    });

    $('#btn-custom-door-spawn').on('click', function () {
        const model = normalizeModelInput($('#custom-door-model-input').val());
        if (!model) {
            $('#custom-door-model-error').text('⚠ Model name is required').show();
            return;
        }
        $('#custom-door-model-input').val(model);
        closeCustomDoorInput();
        fetch(`https://${getResourceName()}/customdoorSpawn`, {
            method:  'POST',
            headers: { 'Content-Type': 'application/json' },
            body:    JSON.stringify({ model: model }),
        })
        .then(r => r.json())
        .then(function (res) {
            if (!res.ok) {
                // Failed to spawn model — re-open the input with error
                const errorMap = {
                    no_model:      '⚠ Model name is required',
                    model_not_found:'⚠ Model could not be loaded (check spelling)',
                    spawn_failed:  '⚠ Model could not be spawned',
                };
                openCustomDoorInput();
                $('#custom-door-model-input').val(model);
                $('#custom-door-model-error').text(errorMap[res.error] || '⚠ Model not found or invalid').show();
            }
            // On success, Lua will close NUI focus while gizmo runs,
            // then send openMenu with mode: 'customdoor' when done.
        })
        .catch(function () {});
    });

    $('#custom-door-model-input').on('keypress', function (e) {
        if (e.key === 'Enter') $('#btn-custom-door-spawn').trigger('click');
    });

    // ─── Lockpick Progress Bar ───────────────────────────────────────────────

    function startCustomProgressBar(text, duration) {
        $('#progressbar-text').text(text || '');

        $('#progress-fill').css({ width: '0%', transition: 'none', background: '' });

        $('#fx-progress').fadeIn(300, function () {
            setTimeout(function () {
                $('#progress-fill').css({
                    transition: 'width ' + duration + 'ms linear',
                    width:      '100%',
                });
            }, 10);
        });

        progressbarActive = true;

        progressbarTimeout = setTimeout(function () {
            $('#fx-progress').fadeOut(300);
            progressbarActive = false;

            $.post('https://' + getResourceName() + '/progressbarFinished', JSON.stringify({}));
        }, duration);
    }

    function cancelCustomProgressBar() {
        if (!progressbarActive) return;

        clearTimeout(progressbarTimeout);

        // Freeze fill at current position
        var currentWidth = $('#progress-fill').width();
        var totalWidth   = $('#progress-fill').parent().width();
        var currentPct   = totalWidth > 0 ? (currentWidth / totalWidth) * 100 : 0;

        $('#progress-fill').css({ transition: 'none', width: currentPct + '%' });
        $('#progressbar-text').text('Cancelling...');

        setTimeout(function () {
            $('#progress-fill').css({
                background: '#c40000',
                transition: 'width 500ms linear',
                width:      '100%',
            });
        }, 10);

        setTimeout(function () {
            $('#fx-progress').fadeOut(300, function () {
                $('#progress-fill').css({ background: '', width: '0%', transition: 'none' });
            });
            progressbarActive = false;
            $.post('https://' + getResourceName() + '/progressbarCancelled', JSON.stringify({}));
        }, 500);
    }

});

// ─── RedM NUI Helper ─────────────────────────────────────────────────────────
// Save the native before our script can shadow it via hoisting.
const _nativeRN = (function () {
    const f = window.GetParentResourceName;
    return (typeof f === 'function') ? f : null;
}());

function getResourceName() {
    return _nativeRN ? _nativeRN() : 'fx-doorlock';
}
