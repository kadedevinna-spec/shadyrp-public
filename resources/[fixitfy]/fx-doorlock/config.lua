Config = {}

Config.Debug    = false
Config.Language = 'en'  -- 'en' | 'tr'

Config.Locale = {
    ['en'] = {
        -- General
        ['no_permission']       = "You don't have permission to use this command.",
        ['createdoor_active']   = 'Door scan mode active. Use mouse to click a door or ~COLOR_YELLOW~ESC~COLOR_WHITE~ to exit.',
        ['createdoor_exit']     = 'Door scan mode deactivated.',
        ['door_no_access']      = "You don't have access to this door.",
        ['door_locked']         = 'Door is now ~COLOR_RED~locked~COLOR_WHITE~.',
        ['door_unlocked']       = 'Door is now ~COLOR_GREEN~unlocked~COLOR_WHITE~.',
        ['lockpick_start']      = 'Picking the lock...',
        ['lockpick_success']    = 'Lock picked successfully!',
        ['lockpick_fail']       = 'Failed to pick the lock!',
        ['lockpick_alert']      = 'Lockpick attempt at door: ${name}',
        ['door_saved']          = "Door '${name}' saved successfully.",
        ['door_updated']        = "Door '${name}' updated.",
        ['door_deleted']        = "Door '${name}' deleted.",
        ['locked_label']        = 'LOCKED',
        ['unlocked_label']      = 'UNLOCKED',
        ['lockpick_label']      = 'Pick Lock',
        ['lockpick_no_item']    = 'You need a lockpick to pick this lock.',
        ['pair_unregistered']   = 'This door is not registered yet. Register it first with /createdoor.',
        ['door_no_key']         = 'You need a door key to access this door.',
        ['door_keys_created']   = '${count} door key(s) added to your inventory.',
        ['door_key_need']       = 'You need ${count} blank doorkey(s) (you have ${have}).',
        -- Convert menu UI labels (sent to NUI)
        ['convert_title']           = 'CONVERT DOORLOCK',
        ['convert_scripts_label']   = 'SUPPORTED SCRIPTS',
        ['convert_paste_label']     = 'PASTE LUA TABLE HERE',
        ['convert_placeholder']     = 'Config.DoorList = { ... }  or  Config.Doors = { ... }  or  Doors = { ... }  or  INSERT INTO gs_doorlocks ...',
        ['convert_btn_close']       = 'CLOSE',
        ['convert_btn_convert']     = 'CONVERT',
        ['convert_status_sending']  = 'Sending to server...',
        ['convert_lbl_added']       = 'doors added',
        ['convert_lbl_exists']      = 'already exist',
        ['convert_lbl_failed']      = 'failed',
        ['convert_done_prefix']     = 'Done',
        ['convert_err_prefix']      = 'Error:',
        -- Settings descriptions (shown in the door management menu)
        ['create_keys_hint'] = 'Save the door first to create keys.',
        ['desc_locked']      = 'Door starts in the locked state.',
        ['desc_hidden_lock'] = 'Hides the lock icon; opened only via key press.',
        ['desc_lockpickable']= 'Allows lockpick attempts on this door.',
        ['desc_alert_law']   = 'Alerts nearby law enforcement when lock is picked.',
        ['desc_door_key']    = 'Players with a matching key item can open this door.',
    },
    ['de'] = {
        ['no_permission']       = "Sie haben keine Berechtigung, diesen Befehl zu verwenden.",
        ['createdoor_active']   = 'Tur-Scan-Modus aktiv. Klicken Sie mit der Maus auf eine Tur oder ~COLOR_YELLOW~ESC~COLOR_WHITE~, um den Modus zu verlassen.',
        ['createdoor_exit']     = 'Tur-Scan-Modus deaktiviert.',
        ['door_no_access']      = "Sie haben keinen Zugriff auf diese Tur.",
        ['door_locked']         = 'Die Tur ist jetzt ~COLOR_RED~verschlossen~COLOR_WHITE~.',
        ['door_unlocked']       = 'Die Tur ist jetzt ~COLOR_GREEN~entriegelt~COLOR_WHITE~.',
        ['lockpick_start']      = 'Das Schloss knacken...',
        ['lockpick_success']    = 'Schloss erfolgreich geknackt!',
        ['lockpick_fail']       = 'Fehler beim Knacken des Schlosses!',
        ['lockpick_alert']      = 'Versuch, die Tur zu knacken: ${name}',
        ['door_saved']          = "Tur '${name}' erfolgreich gespeichert.",
        ['door_updated']        = "Tur '${name}' aktualisiert.",
        ['door_deleted']        = "Tur '${name}' geloscht.",
        ['locked_label']        = 'VERSCHLOSSEN',
        ['unlocked_label']      = 'ENTRIEGELT',
        ['lockpick_label']      = 'Schloss knacken',
        ['lockpick_no_item']    = 'Du brauchst ein Dietrich, um dieses Schloss zu knacken.',
        ['pair_unregistered']   = 'Diese Tur ist noch nicht registriert. Registriere sie zuerst mit /createdoor.',
        ['door_no_key']         = 'Sie benotigen einen Turschlussel fur diese Tur.',
        ['door_keys_created']   = '${count} Turschlussel wurden Ihrem Inventar hinzugefugt.',
        ['door_key_need']       = 'Sie benotigen ${count} leere Turschlussel (Sie haben ${have}).',
        -- Convert menu UI labels (sent to NUI)
        ['convert_title']           = 'TUR KONVERTIEREN',
        ['convert_scripts_label']   = 'UNTERSTUTZDE SCRIPTE',
        ['convert_paste_label']     = 'LUA-TABELLE HIER EINFUGEN',
        ['convert_placeholder']     = 'Config.DoorList = { ... }  oder  Config.Doors = { ... }  oder  Doors = { ... }  oder  INSERT INTO gs_doorlocks ...',
        ['convert_btn_close']       = 'SCHLIESSEN',
        ['convert_btn_convert']     = 'KONVERTIEREN',
        ['convert_status_sending']  = 'Sende an Server...',
        ['convert_lbl_added']       = 'Turen hinzugefugt',
        ['convert_lbl_exists']      = 'existieren bereits',
        ['convert_lbl_failed']      = 'fehlgeschlagen',
        ['convert_done_prefix']     = 'Fertig',
        ['convert_err_prefix']      = 'Fehler:',
        ['create_keys_hint'] = 'Speichern Sie zuerst die Tur, um Schlussel zu erstellen.',
        ['desc_locked']      = 'Tur startet im gesperrten Zustand.',
        ['desc_hidden_lock'] = 'Versteckt das Schlosssymbol; Offnen nur per Tastendruck.',
        ['desc_lockpickable']= 'Erlaubt Dietrich-Versuche an dieser Tur.',
        ['desc_alert_law']   = 'Benachrichtigt nahegelegene Gesetzeshuter beim Aufbrechen.',
        ['desc_door_key']    = 'Spieler mit dem passenden Schlussel-Item konnen diese Tur offnen.',
    },
    ['tr'] = {
        -- General (English characters only — no Turkish-specific diacritics)
        ['no_permission']       = 'Bu komutu kullanmak icin izniniz yok.',
        ['createdoor_active']   = 'Kapi tarama modu aktif. Kapi secmek icin tiklayin veya ~COLOR_YELLOW~ESC~COLOR_WHITE~ ile cikis yapin.',
        ['createdoor_exit']     = 'Kapi tarama modu devre disi.',
        ['door_no_access']      = 'Bu kapiya erisim izniniz yok.',
        ['door_locked']         = 'Kapi ~COLOR_RED~kilitledi~COLOR_WHITE~.',
        ['door_unlocked']       = 'Kapi ~COLOR_GREEN~acildi~COLOR_WHITE~.',
        ['lockpick_start']      = 'Kilit kiriliyor...',
        ['lockpick_success']    = 'Kilit basariyla kirildi!',
        ['lockpick_fail']       = 'Kilit kirma basarisiz!',
        ['lockpick_alert']      = 'Kapi kilit kirma girisimi: ${name}',
        ['door_saved']          = "'${name}' kapisi kaydedildi.",
        ['door_updated']        = "'${name}' kapisi guncellendi.",
        ['door_deleted']        = "'${name}' kapisi silindi.",
        ['locked_label']        = 'KILITLI',
        ['unlocked_label']      = 'ACIK',
        ['lockpick_label']      = 'Kilidi Kir',
        ['lockpick_no_item']    = 'Bu kilidi kirmak icin maymuncuk gerekiyor.',
        ['pair_unregistered']   = 'Bu kapi kayitli degil. Once /createdoor ile kaydedin.',
        ['door_no_key']         = 'Bu kapiya erisim icin kapi anahtari gerekiyor.',
        ['door_keys_created']   = '${count} adet kapi anahtari envanterinize eklendi.',
        ['door_key_need']       = '${count} adet bos kapi anahtarina ihtiyaciniz var (sahipsiniz: ${have}).',
        -- Convert menu UI labels
        ['convert_title']           = 'KAPI DONUSTURUCU',
        ['convert_scripts_label']   = 'DESTEKLENEN SCRIPTLER',
        ['convert_paste_label']     = 'LUA TABLOSUNU BURAYA YAPISTIRIN',
        ['convert_placeholder']     = 'Config.DoorList = { ... }  veya  Config.Doors = { ... }  veya  Doors = { ... }  veya  INSERT INTO gs_doorlocks ...',
        ['convert_btn_close']       = 'KAPAT',
        ['convert_btn_convert']     = 'DONUSTUR',
        ['convert_status_sending']  = 'Sunucuya gonderiliyor...',
        ['convert_lbl_added']       = 'kapi eklendi',
        ['convert_lbl_exists']      = 'zaten var',
        ['convert_lbl_failed']      = 'eklenemedi',
        ['convert_done_prefix']     = 'Tamamlandi',
        ['convert_err_prefix']      = 'Hata:',
        ['create_keys_hint'] = 'Anahtar olusturmak icin once kapiyi kaydedin.',
        ['desc_locked']      = 'Kapi kilitli konumda baslar.',
        ['desc_hidden_lock'] = 'Kilit simgesini gizler; yalnizca tus basisiyla acilir.',
        ['desc_lockpickable']= 'Bu kapiya maymuncukla acma girisimi yapilabilir.',
        ['desc_alert_law']   = 'Kilit kirildiginda yakin kanun gorevlilerine bildirim gonder.',
        ['desc_door_key']    = 'Uygun anahtar esyasina sahip oyuncular bu kapiyi acabilir.',
    },
}


Config.Settings = {

    -- ── Commands ──────────────────────────────────────────────────────────────
    Commands = {
        createdoor  = 'createdoor',
        convertmenu = 'convertmenu',
        customdoor  = 'customdoor',
        toggledoor  = 'toggledoor',
    },

    -- ── Interaction & Display ─────────────────────────────────────────────────
    InteractDistance   = 3.0,   -- Door interaction range (meters)
    CreatedoorDistance = 6.0,   -- Scan range for the createdoor command (meters)
    EnableDrawSprite   = true,  -- Draw lock/key icon on doors (hidden when prompt is hidden)
    UseTarget          = false, -- Use target system instead of proximity prompts
    UseHideDoorsLockPressKey = 0x5415BE48, -- Use key press to hide doors lock (default: false) - G key
    -- ── Access Control ────────────────────────────────────────────────────────
    CreatedoorJobs   = {},      -- Jobs allowed to use the createdoor command (leave empty to disable)
    UseCommandGroups = {        -- Framework groups allowed to manage doors (VORP: getGroup / RSG: HasPermission)
        'admin',
        'mod',
    },

    -- ── Door Key ─────────────────────────────────────────────────────────────
    -- When a door has metalKey = true, players who hold this item can open it
    -- even without job / charId / group access (checked last, after all other rules).
    -- Set item = '' to disable the door-key feature entirely.
    DoorKey = {
        item             = 'doorkey',  -- inventory item name
        maxKeysPerCreate = 3,          -- max keys the admin can generate per save (1–N selector in menu)
    },

    -- ── Lockpick ──────────────────────────────────────────────────────────────
    Lockpick = {
        -- https://github.com/guf1ck/lockpick-system
        -- download and put resource set script name "lockpick"
        minigame            = true,           -- Use minigame; false = simple chance / check client/opensource.lua for custom minigame integration
        itemName            = 'lockpick',     -- Required item name ('' to disable item check)
        remove              = true,           -- Remove item on successful pick
        removeOnFail        = true,           -- Remove item on failed pick
        progressCancelKey   = 0x827E9EE8,     -- X key — cancel during progress bar phase
        progressbarDuration = 2000,          -- Progress bar duration (ms) before minigame starts
        time                = 6000,           -- taskBar duration ms
        chance              = 60,             -- Success chance 0-100 (simple mode only)
    },

    -- ── Alert & Blip ──────────────────────────────────────────────────────────
    AlertJobs = {
        AlertChance   = 100,         -- Probability (0-100) that a law alert is triggered
        AlertDistance = 300.0,      -- Only alert officers within this distance (meters)
        Jobs = {                    -- Jobs that receive lockpick alerts
            'sheriff',
            'police',
        },
        Notification = {
            title    = 'Breakin Attempt',
            message  = 'Someone is attempting to open a door',
            dict     = 'generic_textures',
            icon     = 'lock',
            color    = 'COLOR_WHITE',
            duration = 8000,
        },
        Blip = {
            hash     = 	675509286,                  -- Blip sprite hash (SetBlipSprite)
            modifier = 'BLIP_MODIFIER_MP_COLOR_32',  -- Blip colour modifier
            radius   = 5.0,                         -- Blip display radius (meters)
            duration = 60000,                        -- Blip lifetime (ms) before auto-removal
        },
    },

}

-- ─── Door Icon ───────────────────────────────────────────────────────────────
-- The icon and scan-mode box are automatically placed at the door handle by
-- reading the door model's bounding box (GetModelDimensions).  The offsets
-- below are fine-tuning values applied ON TOP of the auto-detected handle pos.
--
-- HandleFallbackWidth : door width used when the model is not yet loaded (meters)
-- OffsetX : extra shift along the door's right axis (fine-tune, usually 0)
-- OffsetY : shift along the door's forward axis  (positive = toward player side)
-- OffsetZ : vertical offset from door handle height
-- EnableDrawSprite must be true for the icon to display.
Config.DoorIcon = {
    HandleFallbackWidth = 0.9,   -- fallback door width when GetModelDimensions is unavailable (metres)

    -- ── Shared lateral fine-tuning (scan box + draw icon) ─────────────────────
    OffsetX  = -0.10,  -- shift along door's right axis   (+ = right,   - = left)
    OffsetY  = 0.0,    -- shift along door's forward axis  (+ = forward, - = back)

    -- ── Per-system vertical offset ─────────────────────────────────────────────
    ScanBoxHeight = 0.8,   -- scan-mode box height above handle  (+ = up, - = down)
    OffsetZ       = 0.9,   -- draw-icon sprite height above handle (+ = up, - = down)

    -- ── Sprite size ────────────────────────────────────────────────────────────
    Width    = 0.015,
    Height   = 0.020,
    Rotation = 0.0,
}

-- A configuration table used to open doors that are currently marked as open on the map.
Config.OpenFixedDefaultDoors = {
    -408139633,     -- Valentine Bank
    -1652509687,    -- Valentine Bank
    -1477943109,    -- Saint Denis Bank
    2089945615,     -- Saint Denis Bank
    -2136681514,    -- Saint Denis Bank
    1733501235,     -- Saint Denis Bank
    -977211145,     -- Rhodes Bank
    -1206757990,    -- Rhodes Bank
    531022111,      -- Blackwater Bank
    160636303,      -- Armadillo Bank
    -1669881355,    -- Rhodes Gunshop Basement Door
    340151973,      -- New Theater Door
    544106233,      -- New Theater Door
    94437577,       -- Strawberry Dressing Room
}



-- ─── Input Prompts ───────────────────────────────────────────────────────────

Config.Prompts = {
    ['door'] = {
        Label = 'DOOR',
        Keys  = {
            [1] = {
                Key      = 0x5415BE48, -- G
                Label    = 'Interact',
                HoldTime = 200,
            },
            [2] = {
                Key   = 0x80F28E95, -- L
                Label = 'Pick Lock',
            },
        },
    },
}

-- ─── Notify ──────────────────────────────────────────────────────────────────

function Notify(data)
    local text  = data.text  or 'No message'
    local time  = data.time  or 5000
    local ntype = data.type  or 'info'
    local dict  = data.dict
    local icon  = data.icon
    local color = data.color or 0
    local src   = data.source

    if IsDuplicityVersion() then
        if Framework == 'RSG' then
            TriggerClientEvent('fx-hud:client:showNotify', src, text, time, ntype)
        elseif Framework == 'REDEMRP' then
            text = string.gsub(text, '~.-~', '')
            TriggerClientEvent('redem_roleplay:Tip', src, text, time)
        elseif Framework == 'VORP' then
            if icon then
                TriggerClientEvent('vorp:ShowAdvancedRightNotification', src, text, dict, icon, color, time)
            else
                TriggerClientEvent('vorp:TipBottom', src, text, time, ntype)
            end
        end
    else
        if Framework == 'RSG' then
            TriggerEvent('fx-hud:client:showNotify', text, time, ntype)
        elseif Framework == 'REDEMRP' then
            text = string.gsub(text, '~.-~', '')
            TriggerEvent('redem_roleplay:Tip', text, time)
        elseif Framework == 'VORP' then
            if icon then
                TriggerEvent('vorp:ShowAdvancedRightNotification', text, dict, icon, color, time)
            else
                TriggerEvent('vorp:TipBottom', text, time, ntype)
            end
        end
    end
end

-- ─── Locale Helper ───────────────────────────────────────────────────────────

function Locale(key, subs)
    local translate = Config.Locale[Config.Language][key]
        or ('Config.Locale[' .. Config.Language .. '][' .. key .. "] doesn't exist")
    subs = subs or {}
    for k, v in pairs(subs) do
        local pattern   = '%${' .. k .. '}'
        local safeValue = tostring(v):gsub('%%', '%%%%')
        translate       = translate:gsub(pattern, safeValue)
    end
    return tostring(translate):gsub('%%%%', '%%')
end
