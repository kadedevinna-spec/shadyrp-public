// ════════════════════════════════════════════════════════════════════════════
// LOCALE — populated via "setLocale" NUI message from Lua
// ════════════════════════════════════════════════════════════════════════════
const _loc = {};

function L(key) {
    return _loc[key] !== undefined ? _loc[key] : key;
}

function applyLocale() {
    document.querySelectorAll('[data-i18n]').forEach(function (el) {
        var key = el.getAttribute('data-i18n');
        el.textContent = L(key);
    });
    document.querySelectorAll('[data-i18n-ph]').forEach(function (el) {
        var key = el.getAttribute('data-i18n-ph');
        el.placeholder = L(key);
    });
}

window.addEventListener('message', function (ev) {
    if (ev.data && ev.data.action === 'setLocale' && ev.data.data) {
        Object.assign(_loc, ev.data.data);
        applyLocale();
    }
});

// ════════════════════════════════════════════════════════════════════════════
// FRAMEWORK IMAGE PATH — envanter resim yolu, framework'e göre belirlenir
// ════════════════════════════════════════════════════════════════════════════
let _imgPath = '';

window.addEventListener('message', function (ev) {
    const d = ev.data;
    if (!d || d.action !== 'setFramework') return;
    if (d.framework === 'RSG') {
        _imgPath = 'rsg-inventory/html/images/';
    } else if (d.framework === 'VORP') {
        _imgPath = 'vorp_inventory/html/img/items/';
    }
});

// ════════════════════════════════════════════════════════════════════════════
// SHARED SOUND ENGINE (used by both store and mycamp panels)
// ════════════════════════════════════════════════════════════════════════════
const Sound = (function () {
    let ctx = null;
    function ac() {
        if (!ctx) {
            const AC = window.AudioContext || window.webkitAudioContext;
            if (AC) ctx = new AC();
        }
        return ctx;
    }
    function tone(freq, dur, type, gain, when) {
        const a = ac(); if (!a) return;
        const t0 = (when != null ? when : a.currentTime);
        const osc = a.createOscillator();
        const g   = a.createGain();
        osc.type = type || 'sine';
        osc.frequency.setValueAtTime(freq, t0);
        g.gain.setValueAtTime(0.0001, t0);
        g.gain.exponentialRampToValueAtTime(gain || 0.18, t0 + 0.008);
        g.gain.exponentialRampToValueAtTime(0.0001, t0 + dur);
        osc.connect(g).connect(a.destination);
        osc.start(t0);
        osc.stop(t0 + dur + 0.02);
    }
    function noise(dur, gain) {
        const a = ac(); if (!a) return;
        const t0 = a.currentTime;
        const len = Math.floor(a.sampleRate * dur);
        const buf = a.createBuffer(1, len, a.sampleRate);
        const d = buf.getChannelData(0);
        for (let i = 0; i < len; i++) d[i] = (Math.random() * 2 - 1) * (1 - i / len);
        const src = a.createBufferSource();
        src.buffer = buf;
        const bp = a.createBiquadFilter();
        bp.type = 'bandpass'; bp.frequency.value = 1400; bp.Q.value = 3.5;
        const g = a.createGain();
        g.gain.setValueAtTime(gain || 0.08, t0);
        g.gain.exponentialRampToValueAtTime(0.0001, t0 + dur);
        src.connect(bp).connect(g).connect(a.destination);
        src.start(t0);
    }
    // RDR2 feel: dry wooden ticks, very short, low gain, no slides/echo
    return {
        nav:      () => noise(0.025, 0.04),
        select:   () => { tone(900, 0.03, 'sine', 0.06); noise(0.02, 0.03); },
        back:     () => { tone(520, 0.035, 'sine', 0.05); noise(0.02, 0.03); },
        addCart:  () => { tone(1100, 0.025, 'sine', 0.07); noise(0.03, 0.04); },
        remove:   () => { tone(420, 0.035, 'sine', 0.05); noise(0.02, 0.03); },
        error:    () => tone(260, 0.05, 'sine', 0.06),
        purchase: () => { tone(760, 0.04, 'sine', 0.07); noise(0.04, 0.04); },
        open:     () => noise(0.05, 0.05),
        close:    () => noise(0.04, 0.04),
        toggle:   () => noise(0.018, 0.035),
    };
})();

(function () {
    'use strict';

    const ALL_CATEGORY = '__all__';

    // ─── STATE ──────────────────────────────────────────────────────────────
    const drag = { active: false, button: -1, lastX: 0, lastY: 0 };

    const state = {
        open:            false,
        store:           null,
        categories:      [],
        view:            'categories', // 'categories' | 'items'
        currentCategory: null,
        focusedIndex:    0,
        search:          '',
        selectedProp:    null,
        cart:            {},
        favorites:       new Set(),   // itemNames this player has voted — loaded from server on open
        favCounts:       {},          // { [itemName]: globalVoteCount } — loaded from server on open
        favPending:      new Set(),   // itemNames whose toggle request is currently in-flight
        canCarry:        true,
        money:           { cash: 0, gold: 0 },
        menuVisible:     true,
    };

    const $container = $('#store-container');

    // ─── MOCK DATA (local preview) ──────────────────────────────────────────
    function loadMockData() {
        state.categories = [
            { id: 'campsetup',  label: 'Camp Setup',  icon: 'mdi:flag-variant' },
            { id: 'shelter',    label: 'Shelter',     icon: 'mdi:tent' },
            { id: 'furniture',  label: 'Furniture',   icon: 'mdi:chair-rolling' },
            { id: 'fire',       label: 'Fire & Cook', icon: 'mdi:campfire' },
            { id: 'lighting',   label: 'Lighting',    icon: 'game-icons:old-lantern' },
            { id: 'storage',    label: 'Storage',     icon: 'mdi:treasure-chest' },
            { id: 'decoration', label: 'Decoration',  icon: 'mdi:feather' },
            { id: 'utility',    label: 'Utility',     icon: 'mdi:hammer-wrench' },
        ];
        // [itemName, label, prop, category, cash, gold, weight]
        const sample = [
            // SHELTER
            ['fxcamp_tent_open',       'Open Tent',             's_tent_maropen01b',                    'shelter',    90,1,5.0],
            ['fxcamp_tent_hunter',     'Hunter Tent',           'mp005_s_posse_tent_bountyhunter07x',   'shelter',   180,2,7.0],
            ['fxcamp_tent_mountain',   'Mountain Tent',         'p_tentmountainmen02x',                 'shelter',   220,3,8.0],
            ['fxcamp_tent_rain',       'Rain Tarp',             's_wap_rainsfalls',                     'shelter',   140,1,6.0],
            ['fxcamp_tent_tanner',     'Tanner Tent',           'mp004_p_mptenttanner01x',              'shelter',   160,1,6.0],
            ['fxcamp_tent_lemoyne',    'Lemoyne Canvas Tent',   'p_gangtentlemoyne01x',                 'shelter',   130,1,5.5],
            ['fxcamp_tent_hide_small', 'Small Hide Tent',       'p_ambtenthide01b',                     'shelter',   100,0,4.5],
            ['fxcamp_tent_bison',      'Bison Hide Tent',       's_tentbison01x',                       'shelter',   260,3,9.0],
            ['fxcamp_tent_swamp',      'Swamp Reed Tent',       'p_ambtentswamp01x',                    'shelter',   110,0,5.0],
            ['fxcamp_tent_mulch',      'Leaf Tent',             'p_ambtentmulch01b',                    'shelter',    95,0,4.5],
            ['fxcamp_shelter_leanto',  'Pine Lean-To',          'p_leantopine01x',                      'shelter',    60,0,3.0],
            ['fxcamp_tipi_small',      'Small Tipi',            'tippi1',                               'shelter',   150,1,6.0],
            ['fxcamp_tipi_large',      'Large Tipi',            'tippi2',                               'shelter',   160,1,6.0],
            ['fxcamp_shelter_debris',  'Makeshift Shelter',     'p_ambtentdebris01x',                   'shelter',    40,0,2.5],
            ['fxcamp_caravan_wagon',   'Caravan Wagon',         's_wagoncaravan01a',                    'shelter',   500,5,20.0],

            // FURNITURE
            ['fxcamp_table_wood',       'Wooden Table',         'p_table11x',                           'furniture',  40,0,3.0],
            ['fxcamp_chair_wood',       'Wooden Chair',         'p_ambchair01x',                        'furniture',  20,0,2.0],
            ['fxcamp_bench_wood',       'Wooden Bench',         'p_bench03x',                           'furniture',  35,0,3.5],
            ['fxcamp_cot',              'Camp Cot',             'p_cot01x',                             'furniture',  55,0,4.0],
            ['fxcamp_table_bespoke',    'Bespoke Table',        'p_bespoketable01x',                    'furniture',  60,0,3.5],
            ['fxcamp_stool_folding',    'Folding Stool',        'p_stoolfolding01x',                    'furniture',  15,0,1.5],
            ['fxcamp_chair_folding',    'Folding Chair',        'p_chairfolding02x',                    'furniture',  20,0,1.8],
            ['fxcamp_chair_rustic',     'Rustic Chair',         'p_chair09x',                           'furniture',  22,0,2.0],
            ['fxcamp_bed_native_small', 'Small Native Bed',     'p_bedindian02x',                       'furniture',  45,0,3.5],
            ['fxcamp_bed_native_large', 'Large Native Bed',     'p_graveindian01x',                     'furniture',  65,0,5.0],
            ['fxcamp_bedroll',          'Bedroll',              'p_bedrollopen03x',                     'furniture',  25,0,2.0],
            ['fxcamp_backrest',         'Backrest',             'p_indianbackrest01x',                  'furniture',  30,0,2.5],
            ['fxcamp_log_bench_large',  'Large Log Bench',      'p_bench_log05x',                       'furniture',  50,0,4.5],
            ['fxcamp_log_bench_small',  'Small Log Bench',      'p_bench_log03x',                       'furniture',  30,0,2.5],
            ['fxcamp_log_bench_medium', 'Medium Log Bench',     'p_bench_log04x',                       'furniture',  40,0,3.5],

            // FIRE
            ['fxcamp_bonfire',      'Bonfire',           'mp001_p_mp_finishline_bonfire01x',     'fire',  35,0,2.0],
            ['fxcamp_firepit',      'Firepit',           'p_cookfirestructure02x',               'fire',  45,0,2.5],
            ['fxcamp_kettle_fire',  'Kettle & Firewood', 'mp001_p_mp_kettle03_fire01x',          'fire',  55,0,3.0],
            ['fxcamp_bread_oven',   'Bread Oven',        'p_breadoven01x',                       'fire', 180,1,8.0],
            ['fxcamp_forge',        'Blacksmith Forge',  'p_forge01x',                           'fire', 300,2,15.0],
            ['fxcamp_anvil',        'Anvil',             'p_anvil01x',                           'fire', 120,1,10.0],
            ['fxcamp_anvil_stump',  'Anvil Stump',       'p_stump',                              'fire',  20,0,3.0],
            ['fxcamp_sawhorse',     'Sawhorse',          'p_sawhorse04x',                        'fire',  60,0,4.0],
            ['fxcamp_workbench',    'Workbench',         'p_benchwork01x',                       'fire', 150,1,7.0],
            ['fxcamp_grindstone',   'Grindstone',        'p_grindingwheel01x',                   'fire', 140,1,6.0],
            ['fxcamp_coal_bin',     'Coal Bin',          'p_coalbin01x',                         'fire',  40,0,3.5],

            // LIGHTING
            ['fxcamp_lantern_oil', 'Oil Lantern', 'p_lantern09xint', 'lighting',  25,0,1.0],
            ['fxcamp_lamp_street', 'Street Lamp', 'p_lampstreet01x', 'lighting', 120,1,6.0],
            ['fxcamp_light_post',  'Light Post',  'p_lightpost01x',  'lighting', 100,0,5.0],

            // STORAGE
            ['fxcamp_chest_small',  'Small Storage Chest', 's_cvan_chest01',        'storage', 150,1,6.0],
            ['fxcamp_chest_large',  'Large Storage Chest', 'p_chestmedhunt01x',     'storage', 350,3,10.0],
            ['fxcamp_trunk',        'Trunk',               'p_trunk05x',            'storage',  80,0,4.0],
            ['fxcamp_barrel',       'Barrel',              'p_barrel02x',           'storage',  35,0,3.0],
            ['fxcamp_crate',        'Wooden Crate',        'p_crate15x',            'storage',  30,0,2.5],
            ['fxcamp_coffin',       'Coffin',              'p_coffin04x_sea',       'storage',  70,0,5.0],
            ['fxcamp_washbasin',    'Washbasin',           'p_basinwater01x',       'storage',  25,0,2.0],
            ['fxcamp_dirt_tub',     'Dirty Water Tub',     'p_dirttub01x',          'storage',  20,0,2.0],
            ['fxcamp_rope_basket',  'Rope Basket',         'p_basketrope01x',       'storage',  18,0,1.5],
            ['fxcamp_water_bucket', 'Water Bucket',        'p_waterbucket01x',      'storage',  15,0,1.2],
            ['fxcamp_grain_sack_a', 'Grain Sack A',        'p_sandbagcover01x',     'storage',  22,0,2.0],
            ['fxcamp_grain_sack_b', 'Grain Sack B',        'p_floursackstack02x',   'storage',  28,0,2.5],
            ['fxcamp_gourd',        'Water Gourd',         'p_gourdwater01x',       'storage',  12,0,0.8],
            ['fxcamp_basket_a',     'Woven Basket A',      'p_basketindian01x',     'storage',  18,0,1.2],
            ['fxcamp_basket_b',     'Woven Basket B',      'p_basketindian02x',     'storage',  20,0,1.3],
            ['fxcamp_pottery_a',    'Pottery A',           'p_potteryindian05x',    'storage',  22,0,1.5],
            ['fxcamp_pottery_b',    'Pottery B',           'p_potteryindian08x',    'storage',  22,0,1.5],
            ['fxcamp_pottery_c',    'Pottery C',           'p_potteryindian07x',    'storage',  22,0,1.5],
            ['fxcamp_bowl',         'Clay Bowl',           'p_bowlna01x',           'storage',  10,0,0.5],
            ['fxcamp_cloth_pile',   'Cloth Pile',          's_clothpile01x',        'storage',  25,0,1.8],
            ['fxcamp_hide_roll',    'Hide Roll',           's_cvan_hideroll01',     'storage',  30,0,2.0],

            // DECORATION
            ['fxcamp_totem_a',          'Totem A',             'p_spookynative04x',             'decoration', 45,0,1.5],
            ['fxcamp_totem_b',          'Totem B',             'p_spookynative07x',             'decoration', 45,0,1.5],
            ['fxcamp_totem_staff',      'Totem Staff',         'p_staffindian03x',              'decoration', 40,0,1.2],
            ['fxcamp_totem_c',          'Totem C',             'p_spookynative05x',             'decoration', 45,0,1.5],
            ['fxcamp_totem_d',          'Totem D',             'p_spookynative12x',             'decoration', 45,0,1.5],
            ['fxcamp_skull_stones',     'Skull Stones',        'p_spookynative02x',             'decoration', 55,0,2.0],
            ['fxcamp_skull_post',       'Skull Post',          'p_skullpost02x',                'decoration', 60,0,2.5],
            ['fxcamp_skull_tip_a',      'Skull Spear A',       'p_spookyskulls07bx',            'decoration', 30,0,1.0],
            ['fxcamp_skull_tip_b',      'Skull Spear B',       'p_spookyskulls07ax',            'decoration', 30,0,1.0],
            ['fxcamp_skull_totem_small','Small Skull Totem',   'p_spookyskulls04x',             'decoration', 50,0,1.8],
            ['fxcamp_stone_tomahawk',   'Stone Tomahawk',      'p_indianartifact01x',           'decoration', 35,0,0.8],
            ['fxcamp_dreamcatcher',     'Dreamcatcher',        'p_indiandream01x_a',            'decoration', 40,0,0.5],
            ['fxcamp_feather_tip',      'Feather Tip',         'p_spookynative01x',             'decoration', 25,0,0.5],
            ['fxcamp_rattle_hanging',   'Hanging Rattle',      'p_spookynative09x',             'decoration', 30,0,0.6],
            ['fxcamp_dreamcatcher_bead','Beaded Dreamcatcher', 'p_indiandream01x',              'decoration', 50,1,0.6],
            ['fxcamp_feather_decor',    'Feather Decoration',  'p_indianfan01x',                'decoration', 28,0,0.5],
            ['fxcamp_skull_totem_large','Large Skull Totem',   'p_group_skull01x',              'decoration', 65,0,2.5],
            ['fxcamp_skull_spear_trio', 'Skull & Spears',      'p_spookyskulls02x_a',           'decoration', 55,0,2.0],
            ['fxcamp_bone_catcher',     'Bone Catcher',        'p_hangingbones01x',             'decoration', 45,0,1.5],
            ['fxcamp_totem_hanging',    'Hanging Totem',       'p_target06x',                   'decoration', 35,0,1.0],
            ['fxcamp_bearskin',         'Bearskin Rug',        'p_bearskin01x',                 'decoration', 80,0,3.0],
            ['fxcamp_cattle_skull',     'Cattle Skull',        'p_skullcattle03x',              'decoration', 40,0,2.0],
            ['fxcamp_xmas_tree',        'Christmas Tree',      'mp006_p_xmastree01x',           'decoration',120,1,5.0],
            ['fxcamp_xmas_candy',       'Candy Cane',          'mp006_s_markercandycane',       'decoration', 20,0,1.0],
            ['fxcamp_xmas_ginger',      'Gingerbread Man',     'mp006_s_markergingerbread',     'decoration', 20,0,1.0],
            ['fxcamp_xmas_gift',        'Gift Box',            'mp006_s_lootablechest03x',      'decoration', 60,0,2.0],
            ['fxcamp_xmas_wreath',      'Christmas Wreath',    'mp006_p_wreath01x',             'decoration', 35,0,1.0],

            // UTILITY
            ['fxcamp_hitchpost_wood',  'Wooden Hitching Post', 'p_hitchingpost01x',              'utility',  40,0,3.0],
            ['fxcamp_target_practice', 'Practice Target',      'p_target01x',                    'utility',  15,0,1.0],
            ['fxcamp_water_pump',      'Water Pump',           'p_waterpump01x',                 'utility', 250,2,12.0],
            ['fxcamp_strawman',        'Strawman',             's_confedtarget',                 'utility',  30,0,2.0],
            ['fxcamp_fence_a',         'Wooden Fence A',       'p_fence06ax',                    'utility',  20,0,2.0],
            ['fxcamp_fence_b',         'Wooden Fence B',       'p_fence10cx',                    'utility',  20,0,2.0],
            ['fxcamp_fence_wall_a',    'Stone Wall A',         'p_fence_wall01x',                'utility',  25,0,2.5],
            ['fxcamp_fence_wall_b',    'Stone Wall B',         'p_fence_wall02x',                'utility',  25,0,2.5],
            ['fxcamp_barricade',       'Wooden Barricade',     'p_barricadewood_sml01x',         'utility',  22,0,2.0],
            ['fxcamp_bounty_board',    'Bounty Board',         'mp005_p_mp_bountyboard02x',      'utility',  90,0,4.0],
            ['fxcamp_gatling_gun',     'Gatling Gun',          'gatlingMaxim02',                 'utility', 800,10,25.0],
            ['fxcamp_jump_hay',        'Hay Jump',             'mp001_p_mp_jump_haybaleshort01', 'utility',  18,0,1.5],
            ['fxcamp_jump_fence',      'Fence Jump',           'mp001_p_mp_jump_fenceshort02',   'utility',  18,0,1.5],
            ['fxcamp_jump_sack',       'Sack Jump',            'mp001_p_mp_jump_sackshort01',    'utility',  18,0,1.5],
            ['fxcamp_jump_barrel',     'Barrel Jump',          'mp001_p_mp_jump_barrelshort01',  'utility',  18,0,1.5],
            ['fxcamp_jump_block',      'Block Jump',           'mp001_p_mp_jump_blocksmall01',   'utility',  18,0,1.5],
            ['fxcamp_jump_dock',       'Dock Jump',            'mp001_p_mp_jump_dock01',         'utility',  22,0,2.0],
            ['fxcamp_jump_hurdle',     'Hurdle',               'mp001_p_jumphurdles01x',         'utility',  20,0,1.8],
            ['fxcamp_baby_stroller',   'Baby Stroller',        'p_babystroller',                 'utility',  60,0,3.0],
            ['fxcamp_gold_cradle',     'Gold Cradle Stand',    'p_goldcradlestand01x',           'utility', 320,3,12.0],
            ['fxcamp_drying_rack',     'Meat Drying Rack',     'p_dryingmeat01x',                'utility',  70,0,3.5],
        ];
        // items that can start a camp (createCamp = true in CampItemSettings)
        const campSetupItems = new Set([
            'fxcamp_tent_open','fxcamp_tent_hunter','fxcamp_tent_mountain','fxcamp_tent_rain',
            'fxcamp_tent_tanner','fxcamp_tent_lemoyne','fxcamp_tent_hide_small','fxcamp_tent_bison',
            'fxcamp_tent_swamp','fxcamp_tent_mulch','fxcamp_shelter_leanto','fxcamp_shelter_debris',
            'fxcamp_caravan_wagon',
            'fxcamp_chest_small','fxcamp_chest_large','fxcamp_trunk','fxcamp_barrel','fxcamp_crate',
            'fxcamp_coffin','fxcamp_rope_basket','fxcamp_basket_a','fxcamp_basket_b',
        ]);
        state.store = {
            label: 'CAMPING STORE',
            priceMultiplier: 1.0,
            items: sample.map(r => ({
                itemName: r[0], label: r[1], prop: r[2], category: r[3],
                price: { cash: r[4], gold: r[5] }, weight: r[6],
                createCamp: campSetupItems.has(r[0]),
            })),
        };
        state.money = { cash: 1250, gold: 8 };
    }

    // ─── NUI POST ───────────────────────────────────────────────────────────
    function post(name, data) {
        if (typeof GetParentResourceName !== 'function') return;
        $.post(`https://${GetParentResourceName()}/${name}`, JSON.stringify(data || {}));
    }

    // Like post() but returns a Promise so callers can read the NUI callback response.
    function postAsync(name, data) {
        if (typeof GetParentResourceName !== 'function') return Promise.resolve({});
        return $.post(`https://${GetParentResourceName()}/${name}`, JSON.stringify(data || {}));
    }

    // ─── HELPERS ────────────────────────────────────────────────────────────
    function mult(n) {
        const m = (state.store && state.store.priceMultiplier) || 1;
        return Math.ceil(n * m);
    }

    function cashHtml(n)  { return `<iconify-icon icon="mdi:cash" class="money-icon"></iconify-icon><span>$${n}</span>`; }
    function goldHtml(n)  { return `<iconify-icon icon="mdi:gold" class="money-icon gold"></iconify-icon><span>${n}</span>`; }
    function priceHtml(cash, gold) {
        let h = cashHtml(cash);
        if (gold > 0) h += ` ${goldHtml(gold)}`;
        return h;
    }

    const CAMPSETUP_CATEGORY  = 'campsetup';
    const FAVORITES_CATEGORY  = '__favorites__';

    function itemsInCurrentCategory() {
        if (!state.store || !state.currentCategory) return [];
        const q = state.search.trim().toLowerCase();
        const showAll      = state.currentCategory === ALL_CATEGORY;
        const showCampSetup = state.currentCategory === CAMPSETUP_CATEGORY;
        const showFavorites = state.currentCategory === FAVORITES_CATEGORY;
        let list = state.store.items.filter(it => {
            if (showFavorites) return state.favorites.has(it.itemName);
            if (!showAll && !showCampSetup && it.category !== state.currentCategory) return false;
            if (showCampSetup && !it.createCamp) return false;
            if (q && !it.label.toLowerCase().includes(q)) return false;
            return true;
        });
        // Pin favorited items to the top within any category view
        if (!showFavorites && state.favorites.size > 0) {
            list = list.slice().sort((a, b) => {
                const af = state.favorites.has(a.itemName) ? 0 : 1;
                const bf = state.favorites.has(b.itemName) ? 0 : 1;
                return af - bf;
            });
        }
        return list;
    }

    function visibleCategories() {
        if (!state.store) return [];
        const counts = {};
        state.store.items.forEach(it => {
            counts[it.category] = (counts[it.category] || 0) + 1;
            if (it.createCamp) counts[CAMPSETUP_CATEGORY] = (counts[CAMPSETUP_CATEGORY] || 0) + 1;
        });
        const q = state.search.trim().toLowerCase();
        const total = state.store.items.length;
        const favCount = state.store.items.filter(it => state.favorites.has(it.itemName)).length;
        const favLabel = L('ui_favorites');
        const fav = { id: FAVORITES_CATEGORY, label: favLabel, icon: 'mdi:star', count: favCount };
        const all = { id: ALL_CATEGORY, label: L('ui_all_items'), icon: 'mdi:view-grid', count: total };
        const rest = state.categories
            .filter(c => (counts[c.id] || 0) > 0)
            .filter(c => !q || c.label.toLowerCase().includes(q))
            .map(c => Object.assign({ count: counts[c.id] || 0 }, c));
        let list = (!q || 'all items'.includes(q)) ? [all].concat(rest) : rest;
        // Prepend favorites row when there are favorites and search doesn't exclude it
        if (favCount > 0 && (!q || favLabel.toLowerCase().includes(q))) {
            list = [fav].concat(list);
        }
        return list;
    }

    function currentList() {
        return state.view === 'categories' ? visibleCategories() : itemsInCurrentCategory();
    }

    // ─── RENDER ─────────────────────────────────────────────────────────────
    function renderMoney() {
        $('#money-cash').text(`$${state.money.cash || 0}`);
        $('#money-gold').text(`${state.money.gold || 0}`);
    }

    function renderTitle() {
        const $back = $('#btn-back');
        const $home = $('#home-section');
        if (state.view === 'categories') {
            $('#title-text').text((state.store && state.store.label) ? state.store.label.toUpperCase() : L('ui_store_title'));
            $back.hide();
            $home.hide();
            $('#list-label').text(L('ui_categories'));
            $('#list-icon').attr('icon', 'mdi:shape-outline');
        } else {
            let title = L('ui_items'), icon = 'mdi:package-variant';
            if (state.currentCategory === ALL_CATEGORY) {
                title = L('ui_all_items'); icon = 'mdi:view-grid';
            } else if (state.currentCategory === FAVORITES_CATEGORY) {
                title = L('ui_favorites'); icon = 'mdi:star';
            } else {
                const cat = state.categories.find(c => c.id === state.currentCategory);
                if (cat) { title = cat.label.toUpperCase(); icon = cat.icon; }
            }
            $('#title-text').text(title);
            $back.show();
            $home.show();
            $('#list-label').text(L('ui_items'));
            $('#list-icon').attr('icon', icon);
        }
    }

    function renderList() {
        const $list = $('#nav-list').empty();
        const items = currentList();
        $('#list-count').text(items.length);

        if (items.length === 0) {
            $list.append('<div class="list-empty">' + L('ui_nothing_here') + '</div>');
            return;
        }

        if (state.focusedIndex >= items.length) state.focusedIndex = items.length - 1;
        if (state.focusedIndex < 0) state.focusedIndex = 0;

        if (state.view === 'categories') {
            items.forEach((c, i) => {
                const focused = i === state.focusedIndex ? 'focused' : '';
                $list.append(`
                    <div class="nav-row ${focused}" data-index="${i}" data-kind="category" data-id="${c.id}">
                        <iconify-icon class="row-icon" icon="${c.icon}"></iconify-icon>
                        <span class="row-name">${c.label}</span>
                        <span class="row-meta">${c.count}</span>
                        <iconify-icon class="chev" icon="mdi:chevron-right"></iconify-icon>
                    </div>`);
            });
        } else {
            items.forEach((it, i) => {
                const focused    = i === state.focusedIndex ? 'focused' : '';
                const voted      = state.favorites.has(it.itemName);
                const isFav      = voted ? 'favorite' : '';
                const count      = state.favCounts[it.itemName] || 0;
                const cash       = mult(it.price.cash || 0);
                const gold       = it.price.gold || 0;
                const countBadge = count > 0 ? `<span class="fav-count">${count}</span>` : '';
                $list.append(`
                    <div class="nav-row ${focused} ${isFav}" data-index="${i}" data-kind="item" data-prop="${it.prop}" data-itemname="${it.itemName}">
                        <iconify-icon class="fav-star" icon="${voted ? 'mdi:star' : 'mdi:star-outline'}"></iconify-icon>
                        ${countBadge}
                        <span class="row-name">${it.label}</span>
                        <span class="row-meta">${priceHtml(cash, gold)}</span>
                    </div>`);
            });
        }

        const $focused = $list.find('.nav-row.focused');
        if ($focused.length) $focused[0].scrollIntoView({ block: 'nearest' });
    }

    function renderPreview() {
        if (!state.selectedProp) {
            $('#preview-label').text(L('ui_select_item'));
            $('#preview-price').text('—');
            return;
        }
        const it = state.store.items.find(i => i.prop === state.selectedProp);
        if (!it) return;
        const cash = mult(it.price.cash || 0);
        const gold = it.price.gold || 0;
        $('#preview-label').text(it.label);
        $('#preview-price').html(priceHtml(cash, gold));
    }

    function renderCart() {
        const $list = $('#cart-list').empty();
        const entries = Object.values(state.cart);
        let totalCash = 0, totalGold = 0, totalWeight = 0, totalCount = 0;

        if (entries.length === 0) {
            $list.append('<div class="cart-empty">' + L('ui_cart_empty') + '</div>');
        } else {
            // Group entries by category, preserving insertion order
            const groups = {};
            const groupOrder = [];
            entries.forEach(e => {
                const catId = e.item.category || '__other__';
                if (!groups[catId]) { groups[catId] = []; groupOrder.push(catId); }
                groups[catId].push(e);
            });

            groupOrder.forEach(catId => {
                const cat   = state.categories.find(c => c.id === catId);
                const label = cat ? cat.label : catId;
                const icon  = cat ? cat.icon  : 'mdi:package-variant';

                $list.append(`
                    <div class="cart-cat-header">
                        <iconify-icon icon="${icon}" class="cart-cat-icon"></iconify-icon>
                        <span>${label.toUpperCase()}</span>
                    </div>`);

                groups[catId].forEach(e => {
                    const it = e.item, q = e.qty;
                    const unitCash = mult(it.price.cash || 0);
                    const unitGold = it.price.gold || 0;
                    totalCash   += unitCash * q;
                    totalGold   += unitGold * q;
                    totalWeight += (it.weight || 0) * q;
                    totalCount  += q;

                    $list.append(`
                        <div class="cart-item" data-prop="${it.prop}">
                            <div class="cart-name">
                                ${it.label}
                                <span class="cart-sub">${priceHtml(unitCash, unitGold)} · ${(it.weight || 0).toFixed(1)}kg</span>
                            </div>
                            <div class="cart-qty">
                                <div class="qty-btn" data-act="dec">-</div>
                                <div class="qty-val">${q}</div>
                                <div class="qty-btn" data-act="inc">+</div>
                            </div>
                            <div class="cart-remove">✕</div>
                        </div>`);
                });
            });
        }

        $('#cart-count').text(totalCount);
        $('#total-cash').html(cashHtml(totalCash));
        $('#total-gold').html(goldHtml(totalGold));
        $('#total-weight').html(`<iconify-icon icon="mdi:weight" class="money-icon"></iconify-icon><span>${totalWeight.toFixed(1)}</span>`);

        updateInfoPanel(totalCount, totalCash, totalGold);
        updatePurchaseButton(totalCount, totalCash, totalGold);
    }

    function updateInfoPanel(count, tCash, tGold) {
        const $info = $('#info-panel');
        const $text = $('#info-text');
        $info.removeClass('warn ok');
        if (count === 0) {
            $text.text(L('ui_cart_empty_info'));
            return;
        }
        if (!state.canCarry) {
            $info.addClass('warn');
            $text.text(L('ui_cannot_carry'));
            return;
        }
        if (tCash > (state.money.cash || 0)) {
            $info.addClass('warn');
            $text.text(L('ui_not_enough_cash'));
            return;
        }
        if (tGold > (state.money.gold || 0)) {
            $info.addClass('warn');
            $text.text(L('ui_not_enough_gold'));
            return;
        }
        $info.addClass('ok');
        $text.text(L('ui_all_items_ok'));
    }

    function updatePurchaseButton(count, tCash, tGold) {
        const $btn = $('#btn-purchase');
        const ok = count > 0 && state.canCarry
                 && tCash <= (state.money.cash || 0)
                 && tGold <= (state.money.gold || 0);
        if (ok) $btn.removeClass('disabled');
        else    $btn.addClass('disabled');
    }

    function renderAll() {
        renderMoney();
        renderTitle();
        renderList();
        renderPreview();
        renderCart();
    }

    // ─── NAVIGATION ─────────────────────────────────────────────────────────
    function enterCategory(catId) {
        clearTimeout(_previewDebounce);
        state.currentCategory = catId;
        state.view = 'items';
        state.focusedIndex = 0;
        state.search = '';
        $('#search-input').val('');
        Sound.select();
        renderAll();
    }

    function goBack() {
        if (state.view === 'items') {
            clearTimeout(_previewDebounce);
            state.view = 'categories';
            state.currentCategory = null;
            state.focusedIndex = 0;
            state.search = '';
            $('#search-input').val('');
            post('clearPreview');
            state.selectedProp = null;
            Sound.back();
            renderAll();
        } else {
            closeStore();
        }
    }

    function activateFocused() {
        const items = currentList();
        if (items.length === 0) return;
        const entry = items[state.focusedIndex];
        if (state.view === 'categories') {
            enterCategory(entry.id);
        } else {
            selectItem(entry.prop);
            Sound.select();
        }
    }

    function shiftFocus() {
        const $rows = $('#nav-list .nav-row');
        $rows.removeClass('focused');
        const $next = $rows.eq(state.focusedIndex).addClass('focused');
        if ($next.length) $next[0].scrollIntoView({ block: 'nearest' });
    }

    function moveFocus(delta) {
        const items = currentList();
        if (items.length === 0) return;
        state.focusedIndex = (state.focusedIndex + delta + items.length) % items.length;
        Sound.nav();
        shiftFocus();
        if (state.view === 'items') {
            const it = items[state.focusedIndex];
            if (it) selectItem(it.prop);
        }
    }

    // ─── ITEM / CART / FAV ──────────────────────────────────────────────────
    let _previewDebounce = null;

    function selectItem(prop) {
        state.selectedProp = prop;
        renderPreview();
        clearTimeout(_previewDebounce);
        _previewDebounce = setTimeout(() => {
            post('previewItem', { propName: prop });
        }, 150);
    }

    function addToCart(prop) {
        const it = state.store.items.find(i => i.prop === prop);
        if (!it) return;
        const e = state.cart[prop];
        if (e) e.qty += 1;
        else   state.cart[prop] = { item: it, qty: 1 };
        Sound.addCart();
        checkCanCarry();
        renderCart();
    }

    function changeQty(prop, delta) {
        const e = state.cart[prop];
        if (!e) return;
        e.qty += delta;
        if (e.qty <= 0) { delete state.cart[prop]; Sound.remove(); }
        else Sound.toggle();
        checkCanCarry();
        renderCart();
    }

    function removeFromCart(prop) {
        delete state.cart[prop];
        Sound.remove();
        checkCanCarry();
        renderCart();
    }

    function clearCart() {
        state.cart = {};
        state.canCarry = true;
        renderCart();
    }

    function checkCanCarry() {
        const entries = Object.values(state.cart);
        if (entries.length === 0) { state.canCarry = true; return; }
        const payload = entries.map(e => ({ itemName: e.item.itemName, qty: e.qty }));
        post('checkCanCarry', { items: payload });
        state.canCarry = true;
    }

    function toggleFavorite(itemName) {
        if (state.favPending.has(itemName)) return; // this item's request is already in-flight

        // Optimistic update — immediately reflect in UI, then confirm/revert from server
        const wasVoted = state.favorites.has(itemName);
        if (wasVoted) {
            state.favorites.delete(itemName);
            state.favCounts[itemName] = Math.max(0, (state.favCounts[itemName] || 0) - 1);
        } else {
            state.favorites.add(itemName);
            state.favCounts[itemName] = (state.favCounts[itemName] || 0) + 1;
        }
        state.favPending.add(itemName);
        Sound.toggle();
        renderList();

        postAsync('toggleFavorite', { itemName }).then(function (res) {
            state.favPending.delete(itemName);
            try {
                const r = typeof res === 'string' ? JSON.parse(res) : res;
                if (r && r.ok) {
                    // Sync authoritative server state
                    if (r.voted) state.favorites.add(itemName);
                    else         state.favorites.delete(itemName);
                    if (r.count !== undefined) state.favCounts[itemName] = r.count;
                } else {
                    // Server rejected — revert optimistic change
                    if (wasVoted) state.favorites.add(itemName);
                    else          state.favorites.delete(itemName);
                    state.favCounts[itemName] = wasVoted
                        ? (state.favCounts[itemName] || 0) + 1
                        : Math.max(0, (state.favCounts[itemName] || 0) - 1);
                }
            } catch (_) {}
            renderList();
        }).catch(function () {
            state.favPending.delete(itemName);
            // Network/NUI error — revert optimistic change
            if (wasVoted) state.favorites.add(itemName);
            else          state.favorites.delete(itemName);
            renderList();
        });
    }

    // ─── MENU VISIBILITY TOGGLE ─────────────────────────────────────────────
    function applyPanelVisibility() {
        const show = state.menuVisible && !drag.active;
        $('.panel')[show ? 'removeClass' : 'addClass']('ui-hidden');
    }

    function setMenuVisible(visible) {
        state.menuVisible = visible;
        $('#toggle-icon').attr('icon', visible ? 'mdi:eye-outline' : 'mdi:eye-off-outline');
        $('#toggle-label').text(visible ? L('ui_hide_menu') : L('ui_show_menu'));
    }

    // ─── OPEN / CLOSE / PURCHASE ────────────────────────────────────────────
    function openStore(payload) {
        if (payload.locale) Object.assign(_loc, payload.locale);
        state.open = true;
        state.store = payload.store;
        state.categories = payload.categories || state.categories;
        state.view = 'categories';
        state.currentCategory = null;
        state.focusedIndex = 0;
        state.search = '';
        state.selectedProp = null;
        state.cart = {};
        state.canCarry = true;
        state.favorites  = new Set();
        state.favCounts  = {};
        state.favPending = new Set();
        if (payload.money) state.money = payload.money;
        $('#search-input').val('');
        $container.show();
        Sound.open();
        renderAll();
        setMenuVisible(true);
        applyPanelVisibility();

        // Fetch server-side vote data once; re-render list when it arrives
        postAsync('getFavorites', {}).then(function (res) {
            try {
                const r = typeof res === 'string' ? JSON.parse(res) : res;
                if (r && state.open) {
                    state.favCounts = r.counts || {};
                    state.favorites = new Set(r.voted  || []);
                    renderList();
                }
            } catch (_) {}
        });
    }

    function closeStore() {
        state.open = false;
        // Drag ve visibility state'ini sıfırla
        drag.active = false;
        setMenuVisible(true);
        $('.panel').removeClass('ui-hidden');
        $container.hide();
        clearCart();
        Sound.close();
        post('close');
    }

    function purchase() {
        const entries = Object.values(state.cart);
        if (entries.length === 0) return;
        if ($('#btn-purchase').hasClass('disabled')) { Sound.error(); return; }

        let totalCash = 0, totalGold = 0;
        entries.forEach(e => {
            totalCash += mult(e.item.price.cash || 0) * e.qty;
            totalGold += (e.item.price.gold || 0) * e.qty;
        });
        state.pendingCost = { cash: totalCash, gold: totalGold };

        Sound.purchase();
        const payload = entries.map(e => ({
            prop: e.item.prop,
            itemName: e.item.itemName,
            qty: e.qty,
        }));
        post('purchase', { items: payload });
    }

    function applyPendingCost() {
        if (!state.pendingCost) return;
        state.money.cash = Math.max(0, (state.money.cash || 0) - state.pendingCost.cash);
        state.money.gold = Math.max(0, (state.money.gold || 0) - state.pendingCost.gold);
        state.pendingCost = null;
        renderMoney();
    }

    // ─── EVENTS ─────────────────────────────────────────────────────────────
    function bind() {
        $('#search-input').on('input', function () {
            state.search = $(this).val() || '';
            state.focusedIndex = 0;
            renderList();
        });

        $('#nav-list').on('click', '.fav-star', function (ev) {
            ev.stopPropagation();
            const itemName = $(this).closest('.nav-row').data('itemname');
            if (itemName) toggleFavorite(itemName);
        });

        $('#nav-list').on('click', '.nav-row', function () {
            const i = $(this).data('index');
            state.focusedIndex = i;
            activateFocused();
            shiftFocus();
        });

        $('#btn-back').on('click', goBack);
        $('#btn-home').on('click', goBack);
        $('#btn-close').on('click', closeStore);
        $('#btn-purchase').on('click', purchase);

        $('#cart-list').on('click', '.qty-btn', function () {
            const prop = $(this).closest('.cart-item').data('prop');
            const act  = $(this).data('act');
            changeQty(prop, act === 'inc' ? 1 : -1);
        });

        $('#cart-list').on('click', '.cart-remove', function () {
            const prop = $(this).closest('.cart-item').data('prop');
            removeFromCart(prop);
        });

        $(document).on('keydown', function (ev) {
            if (!state.open) return;
            const key = ev.key;
            const inInput = $(ev.target).is('input, textarea');

            switch (key) {
                case 'ArrowDown': ev.preventDefault(); moveFocus(1); return;
                case 'ArrowUp':   ev.preventDefault(); moveFocus(-1); return;
                case 'Enter':     ev.preventDefault(); activateFocused(); return;
                case 'Backspace':
                    if (inInput && $(ev.target).val() !== '') return;
                    ev.preventDefault(); goBack(); return;
                case 'Escape':    ev.preventDefault(); goBack(); return;
            }

            if (key.toLowerCase() === 'h') {
                setMenuVisible(!state.menuVisible);
                applyPanelVisibility();
                Sound.toggle();
                return;
            }

            if (state.view !== 'items' || !state.selectedProp) return;
            switch (key.toLowerCase()) {
                case 'q': post('rotate', { axis: 'z', dir: -1 }); break;
                case 'e': post('rotate', { axis: 'z', dir:  1 }); break;
                case 'r': post('rotate', { axis: 'x', dir:  1 }); break;
                case 'f': post('rotate', { axis: 'x', dir: -1 }); break;
                case 'x': post('resetRotation'); break;
                case ' ': ev.preventDefault(); addToCart(state.selectedProp); break;
                case 'b': post('quickBuy', { propName: state.selectedProp }); break;
            }
        });

        $(document).on('wheel', function (ev) {
            if (!state.open || !state.selectedProp) return;
            if ($(ev.target).closest('.panel-left').length) return;
            const dir = ev.originalEvent.deltaY < 0 ? 1 : -1;
            post('zoom', { dir });
        });

        // ─── MOUSE DRAG (prop move + FOV) ───────────────────────────────────
        const $dragZone = $('#preview-drag-zone');
        let dragThrottle = null;


        $dragZone.on('mousedown', function (ev) {
            if (!state.open || !state.selectedProp) return;
            ev.preventDefault();
            drag.active = true;
            drag.button = ev.button;
            drag.lastX  = ev.clientX;
            drag.lastY  = ev.clientY;
            $dragZone.css('cursor', ev.button === 0 ? 'grabbing' : 'ns-resize');
            applyPanelVisibility();
        });

        $(document).on('mousemove.drag', function (ev) {
            if (!drag.active) return;
            const dx = ev.clientX - drag.lastX;
            const dy = ev.clientY - drag.lastY;
            drag.lastX = ev.clientX;
            drag.lastY = ev.clientY;
            if (dx === 0 && dy === 0) return;
            if (dragThrottle) return;
            dragThrottle = setTimeout(() => { dragThrottle = null; }, 16);
            if (drag.button === 0) {
                post('moveProp', { dx, dy });
            } else if (drag.button === 2) {
                post('adjustFov', { delta: dy * 0.3 });
            }
        });

        $(document).on('mouseup.drag', function () {
            if (!drag.active) return;
            drag.active = false;
            $dragZone.css('cursor', 'grab');
            applyPanelVisibility();  // state.menuVisible'a göre restore et
        });

        $dragZone.on('contextmenu', ev => ev.preventDefault());

        // ─── TOGGLE BUTTON ──────────────────────────────────────────────────
        $('#btn-toggle-menu').on('click', function () {
            Sound.toggle();
            setMenuVisible(!state.menuVisible);
            applyPanelVisibility();
        });
    }

    // ─── NUI MESSAGES ───────────────────────────────────────────────────────
    window.addEventListener('message', function (ev) {
        const d = ev.data || {};
        switch (d.action) {
            case 'open':         openStore(d); break;
            case 'close':        closeStore(); break;
            case 'money':        state.money = d.money || state.money; renderMoney(); renderCart(); break;
            case 'canCarry':     state.canCarry = !!d.value; renderCart(); break;
            case 'purchaseDone': applyPendingCost(); clearCart(); closeStore(); break;
            case 'quickBuyDone':
                if (d.cost) {
                    state.money.cash = Math.max(0, (state.money.cash || 0) - (d.cost.cash || 0));
                    state.money.gold = Math.max(0, (state.money.gold || 0) - (d.cost.gold || 0));
                    renderMoney();
                }
                break;
        }
    });

    // ─── INIT ───────────────────────────────────────────────────────────────
    $(function () {
        bind();
        if (typeof GetParentResourceName !== 'function') {
            loadMockData();
            state.open = true;
            $container.show();
            renderAll();
        }
    });
})();

// ════════════════════════════════════════════════════════════════════════════
// MY CAMP PANEL
// ════════════════════════════════════════════════════════════════════════════
(function () {
    'use strict';

    // ─── STATE ──────────────────────────────────────────────────────────────
    const mc = {
        open:            false,
        camp:            null,   // full camp object from server
        inventory:       [],     // [{itemName, label, count, …}]
        imageBase:       '',
        selectedUUID:    null,   // UUID of selected prop in list
        confirmPayload:  null,   // { id, extra } pending confirmation
        membersVisible:  false,
        dragItem:        null,   // itemName being dragged
        categories:      [],     // Config.Categories array
        propCategoryMap: {},     // itemName → categoryId
        propFilter:      'all',  // active category filter (props panel)
        invFilter:       'all',  // active category filter (inventory panel)
        propSearch:      '',     // text search (props panel)
        invSearch:       '',     // text search (inventory panel)
    };

    // ─── NUI POST ────────────────────────────────────────────────────────────
    function post(name, data) {
        if (typeof GetParentResourceName !== 'function') return;
        $.post(`https://${GetParentResourceName()}/${name}`, JSON.stringify(data || {}));
    }

    // ─── HELPERS ─────────────────────────────────────────────────────────────
    function imgSrc(imageBase, itemName) {
        if (!imageBase || !itemName) return '';
        return imageBase.replace('%s', itemName);
    }

    function propStatusDot(prop) {
        if (prop.isBase)    return '<span class="mc-dot mc-dot-base"></span>';
        if (prop.installed) return '<span class="mc-dot mc-dot-installed"></span>';
        return '<span class="mc-dot mc-dot-pending"></span>';
    }

    // ─── RENDER ──────────────────────────────────────────────────────────────
    function updatePlacementCounter(count) {
        const $badge = $('#ph-counter-badge');
        $badge.text('×' + count);
        $('#ph-item-counter')
            .removeClass('ph-count-green ph-count-yellow ph-count-red')
            .addClass(count >= 3 ? 'ph-count-green' : count === 2 ? 'ph-count-yellow' : 'ph-count-red');
    }

    function renderCategoryFilter() {
        const $f    = $('#mc-prop-filter').empty();
        const props = (mc.camp && mc.camp.props) || [];

        const present = new Set();
        props.forEach(function (p) {
            const cat = mc.propCategoryMap[p.itemName];
            if (cat) present.add(cat);
        });

        if (present.size === 0) { $f.hide(); return; }
        $f.show();

        const allA = mc.propFilter === 'all' ? 'active' : '';
        $f.append(`<button class="mc-cat-btn ${allA}" data-cat="all" title="${L('ui_all_items')}"><iconify-icon icon="mdi:view-grid"></iconify-icon></button>`);

        mc.categories.forEach(function (cat) {
            if (!present.has(cat.id)) return;
            const a = mc.propFilter === cat.id ? 'active' : '';
            $f.append(`<button class="mc-cat-btn ${a}" data-cat="${cat.id}" title="${cat.label}"><iconify-icon icon="${cat.icon}"></iconify-icon></button>`);
        });
    }

    function renderPropList(props) {
        const all = props || [];
        const q   = (mc.propSearch || '').trim().toLowerCase();
        const filtered = all.filter(function (p) {
            if (mc.propFilter && mc.propFilter !== 'all' && (mc.propCategoryMap[p.itemName] || '') !== mc.propFilter) return false;
            if (q) {
                const lbl = (p.itemName || '').replace(/_/g, ' ').toLowerCase();
                if (!lbl.includes(q)) return false;
            }
            return true;
        });

        if ($('#mc-prop-actions').closest('#mc-prop-list').length) {
            $('#mc-prop-actions').detach().removeClass('inline-accordion').appendTo('#mc-props-section').hide();
            mc.selectedUUID = null;
        }
        const $list = $('#mc-prop-list').empty();
        $('#mc-prop-count').text(all.length);

        if (filtered.length === 0) {
            $list.append('<div class="list-empty">' + L('ui_no_props') + '</div>');
            return;
        }

        const basePropUUID = mc.camp && mc.camp.base_prop_uuid;
        filtered.forEach(function (p) {
            const sel    = (p.uuid === mc.selectedUUID) ? 'selected' : '';
            const isBase = basePropUUID && p.uuid === basePropUUID;
            const label  = p.itemName ? p.itemName.replace(/_/g, ' ') : p.uuid;
            const catId  = mc.propCategoryMap[p.itemName];
            const catDef = catId && mc.categories.find(function (c) { return c.id === catId; });
            const catIcon = catDef
                ? `<iconify-icon class="mc-prop-cat-icon" icon="${catDef.icon}" title="${catDef.label}"></iconify-icon>`
                : '';
            $list.append(
                `<div class="nav-row mc-prop-item ${sel}" data-uuid="${p.uuid}">
                    ${propStatusDot(p)}
                    ${catIcon}
                    <span class="row-name">${label}</span>
                    ${isBase ? '<span class="mc-prop-tag">BASE</span>' : ''}
                    <iconify-icon class="chev" icon="mdi:chevron-right"></iconify-icon>
                </div>`
            );
        });
    }

    function renderInvCategoryFilter() {
        const $f = $('#mc-inv-filter').empty();

        const present = new Set();
        (mc.inventory || []).forEach(function (it) {
            const cat = mc.propCategoryMap[it.itemName || it.name || ''];
            if (cat) present.add(cat);
        });

        if (present.size === 0) { $f.hide(); return; }
        $f.show();

        const allA = mc.invFilter === 'all' ? 'active' : '';
        $f.append(`<button class="mc-cat-btn ${allA}" data-cat="all" title="${L('ui_all_items')}"><iconify-icon icon="mdi:view-grid"></iconify-icon></button>`);

        (mc.categories || []).forEach(function (cat) {
            if (!present.has(cat.id)) return;
            const a = mc.invFilter === cat.id ? 'active' : '';
            $f.append(`<button class="mc-cat-btn ${a}" data-cat="${cat.id}" title="${cat.label}"><iconify-icon icon="${cat.icon}"></iconify-icon></button>`);
        });
    }

    function renderInvGrid(inventory, imageBase) {
        const all = inventory || [];
        const q   = (mc.invSearch || '').trim().toLowerCase();
        const filtered = all.filter(function (it) {
            const name = it.itemName || it.name || '';
            if (mc.invFilter && mc.invFilter !== 'all' && (mc.propCategoryMap[name] || '') !== mc.invFilter) return false;
            if (q) {
                const lbl = (it.label || name.replace(/_/g, ' ')).toLowerCase();
                if (!lbl.includes(q)) return false;
            }
            return true;
        });

        const $list = $('#mc-inv-grid').empty();
        if (filtered.length === 0) {
            $list.append('<div class="list-empty">' + L('ui_no_items') + '</div>');
            return;
        }

        filtered.forEach(function (it) {
            const itemName = it.itemName || it.name || '';
            const src      = imgSrc(imageBase || mc.imageBase, itemName);
            const lbl      = it.label || itemName.replace(/_/g, ' ');
            const catId    = mc.propCategoryMap[itemName];
            const catDef   = catId && (mc.categories || []).find(function (c) { return c.id === catId; });
            const catIcon  = catDef
                ? `<iconify-icon class="mc-prop-cat-icon" icon="${catDef.icon}" title="${catDef.label}"></iconify-icon>`
                : '';
            $list.append(
                `<div class="nav-row mc-inv-item" data-itemname="${itemName}" data-count="${it.count || 1}" title="${lbl}">
                    <img class="mc-inv-img-sm" src="${src}" alt=""
                         onerror="this.style.display='none'" style="pointer-events:none;">
                    ${catIcon}
                    <span class="row-name" style="pointer-events:none;">${lbl}</span>
                    <span class="row-meta" style="pointer-events:none;">${it.count || 1}</span>
                </div>`
            );
        });
    }

    function renderMembersList(members) {
        const $list = $('#mc-members-list').empty();
        if (!members || members.length === 0) {
            $list.append('<div class="list-empty">' + L('ui_no_members') + '</div>');
            return;
        }
        const cfg = mc.permissionsConfig || {};
        members.forEach(function (m) {
            const charId = (typeof m === 'object') ? m.charId : m;
            const name   = (typeof m === 'object' && m.name) ? m.name : ('CharID ' + charId);
            const perms  = (typeof m === 'object' && m.permissions) ? m.permissions : {};

            // Build active-permission tag list
            const tags = Object.keys(cfg).filter(k => perms[k]).map(k =>
                `<span style="font-size:0.68vh;background:rgba(201,168,108,0.18);
                       color:rgba(201,168,108,0.85);padding:1px 5px;border-radius:2px;
                       white-space:nowrap;">${cfg[k] ? cfg[k].label : k}</span>`
            ).join('');

            $list.append(
                `<div class="nav-row mc-member-row" data-charid="${charId}"
                      style="flex-direction:column;align-items:flex-start;gap:3px;padding:6px 8px;cursor:pointer;">
                    <div style="display:flex;align-items:center;width:100%;gap:4px;">
                        <iconify-icon class="row-icon" icon="mdi:account"
                                      style="pointer-events:none;flex-shrink:0;"></iconify-icon>
                        <span class="row-name" style="flex:1;pointer-events:none;">${name}</span>
                        <iconify-icon class="mc-member-edit-icon" icon="mdi:pencil"
                                      style="pointer-events:none;flex-shrink:0;font-size:12px;
                                             opacity:0;color:rgba(201,168,108,0.75);transition:opacity 0.15s;"></iconify-icon>
                        <div class="mc-remove-member" data-charid="${charId}"
                             style="color:rgba(190,60,60,0.8);cursor:pointer;font-size:13px;
                                    padding:0 4px;flex-shrink:0;">✕</div>
                    </div>
                    ${tags ? `<div style="display:flex;flex-wrap:wrap;gap:3px;
                                          margin-left:22px;">${tags}</div>` : ''}
                </div>`
            );
        });
    }

    function renderNearbyPlayers(players) {
        const $list = $('#mc-nearby-list').empty();
        if (!players || players.length === 0) {
            $list.append('<div class="list-empty">' + L('ui_no_players') + '</div>');
            return;
        }
        players.forEach(function (p) {
            const nameStr = (p.name || '?') + ' | ID: ' + p.serverId + ' | CHARID: ' + p.charId;
            $list.append(
                `<div class="nav-row mc-nearby-row">
                    <iconify-icon class="row-icon" icon="mdi:account-circle" style="flex-shrink:0;"></iconify-icon>
                    <span class="row-name" style="flex:1;font-size:0.82vh;white-space:nowrap;
                          overflow:hidden;text-overflow:ellipsis;">${nameStr}</span>
                    <div class="mc-add-nearby"
                         data-serverid="${p.serverId}" data-charid="${p.charId}" data-name="${p.name || ''}"
                         style="flex-shrink:0;font-size:0.9vh;color:#c9a86c;cursor:pointer;
                                display:flex;align-items:center;gap:3px;">
                        <iconify-icon icon="mdi:account-plus"></iconify-icon> ${L('ui_add')}
                    </div>
                </div>`
            );
        });
    }

    // ─── PERMISSION DIALOG ───────────────────────────────────────────────────
    let _permCallback = null;

    function openPermDialog(title, initialPerms, onConfirm) {
        _permCallback = onConfirm;
        $('#mc-perm-title-text').text(title);

        const $list = $('#mc-perm-list').empty();
        const cfg   = mc.permissionsConfig || {};

        Object.entries(cfg).forEach(function ([key, def]) {
            const active = (initialPerms && initialPerms[key] !== undefined)
                ? !!initialPerms[key]
                : !!(def && def.default);
            const $row = $(
                `<div class="mc-perm-row${active ? ' active' : ''}" data-perm="${key}">
                    <span class="mc-perm-label">${(def && def.label) || key}</span>
                    <span class="mc-perm-toggle">${active ? 'ON' : 'OFF'}</span>
                </div>`
            );
            $row.on('click', function () {
                const $r = $(this);
                const nowActive = $r.toggleClass('active').hasClass('active');
                $r.find('.mc-perm-toggle').text(nowActive ? 'ON' : 'OFF');
            });
            $list.append($row);
        });

        $('#mc-perm-dialog').show();
    }

    function closePermDialog() {
        _permCallback = null;
        $('#mc-perm-dialog').hide();
    }

    // ─── IN-WORLD MARKER OVERLAY ─────────────────────────────────────────────
    let _hoveredMarkerId = null;

    function updateMarkers(markers) {
        const $c = $('#mc-markers-container');

        if (!mc.membersVisible || !markers || markers.length === 0) {
            $c.hide().empty();
            return;
        }
        $c.show();

        // Track which server IDs are currently in range
        const activeIds = new Set(markers.map(function (m) { return m.serverId; }));

        // Remove markers that are no longer in range
        $c.find('.mc-world-marker').each(function () {
            if (!activeIds.has(parseInt($(this).data('serverid'), 10))) {
                $(this).remove();
            }
        });

        // Update existing positions or create new markers
        markers.forEach(function (m) {
            const left = (m.x * 100).toFixed(2) + '%';
            const top  = (m.y * 100).toFixed(2) + '%';
            const $el  = $c.find('.mc-world-marker[data-serverid="' + m.serverId + '"]');

            if ($el.length) {
                // Element already exists — just reposition, keep DOM intact
                $el.css({ left: left, top: top });
            } else {
                // New player entered range — create the element once
                const imgSrc = (_hoveredMarkerId === m.serverId)
                    ? './assets/img/circle-black.png'
                    : './assets/img/circle-white.png';
                $(`<div class="mc-world-marker" data-serverid="${m.serverId}" style="left:${left};top:${top};">
                    <img class="mc-marker-img" src="${imgSrc}">
                    <span class="mc-marker-label">${m.serverId}</span>
                </div>`).appendTo($c);
            }
        });
    }

    // ─── PERMISSION HELPERS ──────────────────────────────────────────────────
    function computeMyPerms() {
        const cfg = mc.permissionsConfig || {};
        if (mc.isOwner) {
            const all = {};
            Object.keys(cfg).forEach(function (k) { all[k] = true; });
            mc.myPerms = all;
            return;
        }
        const myId = (mc.myCharId != null) ? String(mc.myCharId) : null;
        mc.myPerms = {};
        if (!myId || !mc.camp || !mc.camp.members) return;
        for (const m of mc.camp.members) {
            const mid = String(typeof m === 'object' ? m.charId : m);
            if (mid === myId) {
                if (typeof m === 'object' && m.permissions) {
                    Object.assign(mc.myPerms, m.permissions);
                }
                break;
            }
        }
    }

    function applyPermissionVisibility() {
        const p = mc.myPerms || {};
        if (mc.isOwner) {
            $('#mc-btn-delete-camp, #mc-btn-move-camp, #mc-btn-members, #mc-btn-edit-mode, #mc-rename-btn').show();
            return;
        }
        // Edit mode toggle: only if member can do at least one prop action
        if (p.place_prop || p.move_prop || p.remove_prop) {
            $('#mc-btn-edit-mode').show();
        } else {
            $('#mc-btn-edit-mode').hide();
            // Disable edit mode if it was on
            $('#mc-btn-edit-mode').removeClass('active');
        }
        p.manage_members ? $('#mc-btn-members').show()     : $('#mc-btn-members').hide();
        p.move_camp      ? $('#mc-btn-move-camp').show()   : $('#mc-btn-move-camp').hide();
        p.delete_camp    ? $('#mc-btn-delete-camp').show() : $('#mc-btn-delete-camp').hide();
        p.admin          ? $('#mc-rename-btn').show()      : $('#mc-rename-btn').hide();
        // Wardrobe: additionally hide if member lacks set_wardrobe (wardrobeEnabled already handled in openMyCamp)
        if (!p.set_wardrobe) { $('#mc-btn-set-wardrobe').hide(); }
    }

    function permDeniedNotify() {
        let $t = $('#mc-perm-denied-toast');
        if (!$t.length) {
            $t = $('<div id="mc-perm-denied-toast"></div>').appendTo('body');
        }
        $t.text(L('no_permission_camp') || 'No Permission');
        $t.stop(true, true).fadeIn(120).delay(1600).fadeOut(350);
    }

    function renderAll() {
        if (!mc.camp) return;
        mc.isOwner = !!(mc.camp && mc.myCharId != null && String(mc.camp.owner_charid) === String(mc.myCharId));
        computeMyPerms();
        $('#mc-camp-name').text(mc.camp.camp_name || 'My Camp');
        renderCategoryFilter();
        renderPropList(mc.camp.props || []);
        renderInvCategoryFilter();
        renderInvGrid(mc.inventory, mc.imageBase);
        renderMembersList(mc.camp.members || []);
        hideSelectedActions();
        applyPermissionVisibility();
    }

    // ─── SELECTED PROP ACTIONS ───────────────────────────────────────────────
    function hideSelectedActions() {
        mc.selectedUUID = null;
        $('#mc-prop-actions').detach().removeClass('inline-accordion').appendTo('#mc-props-section').hide();
        $('#mc-prop-list .mc-prop-item').removeClass('selected');
    }

    function showSelectedActions(uuid, prop) {
        mc.selectedUUID = uuid;
        $('#mc-selected-label').text(prop.itemName ? prop.itemName.replace(/_/g, ' ') : uuid);
        const p = mc.myPerms || {};

        // Install: requires place_prop
        if (!prop.installed && (mc.isOwner || p.place_prop)) {
            $('#mc-btn-install-prop').show();
        } else {
            $('#mc-btn-install-prop').hide();
        }
        // Reposition: requires move_prop
        if (mc.isOwner || p.move_prop) {
            $('#mc-btn-edit-prop').show();
        } else {
            $('#mc-btn-edit-prop').hide();
        }
        // Remove: requires remove_prop
        if (mc.isOwner || p.remove_prop) {
            $('#mc-btn-remove-prop').show();
        } else {
            $('#mc-btn-remove-prop').hide();
        }

        $('#mc-prop-list .mc-prop-item').removeClass('selected');
        const $item = $('#mc-prop-list .mc-prop-item[data-uuid="' + uuid + '"]').addClass('selected');
        $('#mc-prop-actions').detach().addClass('inline-accordion').insertAfter($item).show();
    }

    function findProp(uuid) {
        if (!mc.camp || !mc.camp.props) return null;
        for (let i = 0; i < mc.camp.props.length; i++) {
            if (mc.camp.props[i].uuid === uuid) return mc.camp.props[i];
        }
        return null;
    }

    // ─── OPEN / CLOSE ────────────────────────────────────────────────────────
    function openMyCamp(payload) {
        if (payload.locale) Object.assign(_loc, payload.locale);
        mc.open              = true;
        mc.camp              = payload.camp              || null;
        mc.inventory         = payload.inventory         || [];
        mc.imageBase         = payload.imageBase         || '';
        mc.permissionsConfig = payload.permissionsConfig || {};
        mc.categories        = payload.categories        || [];
        mc.propCategoryMap   = payload.propCategoryMap   || {};
        mc.myCharId          = payload.myCharId          || null;
        mc.isOwner           = !!(mc.camp && mc.myCharId != null && String(mc.camp.owner_charid) === String(mc.myCharId));
        mc.selectedUUID      = null;
        mc.membersVisible    = false;
        mc.propFilter        = 'all';
        mc.invFilter         = 'all';
        mc.propSearch        = '';
        mc.invSearch         = '';
        $('#mc-prop-search').val('');
        $('#mc-inv-search').val('');

        // Always start on props view, drop zone hidden
        $('#mc-props-section').show();
        $('#mc-members-section').hide();
        $('#mc-drop-zone').hide();
        $('#mc-markers-container').hide();
        $('#mc-btn-members').removeClass('active');
        // Restore edit mode button state (persists across menu open/close)
        if (payload.editMode) {
            $('#mc-btn-edit-mode').addClass('active');
        } else {
            $('#mc-btn-edit-mode').removeClass('active');
        }
        // Show wardrobe button only when a clothing script is configured
        if (payload.wardrobeEnabled) {
            $('#mc-btn-set-wardrobe').show();
        } else {
            $('#mc-btn-set-wardrobe').hide();
        }
        $('#mycamp-container').show();
        Sound.open();
        renderAll();
    }

    function closeMyCampUI() {
        mc.open           = false;
        mc.membersVisible = false;
        Sound.close();
        $('#mycamp-container').hide();
        $('#mc-markers-container').hide();
        closePermDialog();
        hideSelectedActions();
    }

    // ─── PROGRESS BAR ────────────────────────────────────────────────────────
    let _progressTimer = null;

    function startCustomProgressBar(text, duration, callback) {
        clearCustomProgressBar();
        $('#progressbar-text').text(text);
        $('#progress-fill').css({ width: '0%', transition: 'none' });

        $('.progress').fadeIn(300, function () {
            setTimeout(function () {
                $('#progress-fill').css({
                    transition: `width ${duration}ms linear`,
                    width: '100%',
                });
            }, 10);
        });

        _progressTimer = setTimeout(function () {
            clearCustomProgressBar();
            if (typeof callback === 'function') callback();
        }, duration + 300);
    }

    function clearCustomProgressBar() {
        if (_progressTimer) { clearTimeout(_progressTimer); _progressTimer = null; }
        $('.progress').fadeOut(300);
        $('#progress-fill').css({ transition: 'none', width: '0%' });
    }

    // ─── CONFIRM DIALOG ──────────────────────────────────────────────────────
    function showConfirm(payload) {
        mc.confirmPayload = { id: payload.id, extra: payload.extra || {} };
        $('#fx-confirm-msg').text(payload.message || 'Are you sure?');
        $('#fx-confirm-overlay').show();
    }

    function hideConfirm() {
        mc.confirmPayload = null;
        $('#fx-confirm-overlay').hide();
    }

    // ─── BIND EVENTS ─────────────────────────────────────────────────────────
    function bind() {
        // ── Close button ────────────────────────────────────────────────────
        $('#mc-close-btn').on('click', function () {
            post('mycampClose', {});
        });

        // ── Search: props ────────────────────────────────────────────────────
        $('#mc-prop-search').on('input', function () {
            mc.propSearch = $(this).val() || '';
            renderPropList((mc.camp && mc.camp.props) || []);
        });

        // ── Search: inventory ────────────────────────────────────────────────
        $('#mc-inv-search').on('input', function () {
            mc.invSearch = $(this).val() || '';
            renderInvGrid(mc.inventory, mc.imageBase);
        });

        // ── Category filter bar (props) ──────────────────────────────────────
        $('#mc-prop-filter').on('click', '.mc-cat-btn', function () {
            mc.propFilter = $(this).data('cat') || 'all';
            Sound.nav();
            renderCategoryFilter();
            renderPropList((mc.camp && mc.camp.props) || []);
            hideSelectedActions();
        });

        // ── Category filter bar (inventory) ──────────────────────────────────
        $('#mc-inv-filter').on('click', '.mc-cat-btn', function () {
            mc.invFilter = $(this).data('cat') || 'all';
            Sound.nav();
            renderInvCategoryFilter();
            renderInvGrid(mc.inventory, mc.imageBase);
        });

        // ── Prop list: hover preview ─────────────────────────────────────────
        let propHoverTimer = null;

        $('#mc-prop-list').on('mouseenter', '.mc-prop-item', function () {
            if (propHoverTimer) { clearTimeout(propHoverTimer); propHoverTimer = null; }
            const uuid = $(this).data('uuid');
            if (uuid) {
                Sound.nav();
                post('campHoverInstalledProp', { propUUID: uuid });
            }
        });

        $('#mc-prop-list').on('mouseleave', '.mc-prop-item', function () {
            propHoverTimer = setTimeout(function () {
                propHoverTimer = null;
                post('campHoverInstalledProp', { propUUID: null });
            }, 80);
        });

        // ── Prop list: select prop ───────────────────────────────────────────
        $('#mc-prop-list').on('click', '.mc-prop-item', function () {
            const uuid = $(this).data('uuid');
            if (!uuid) return;
            if (mc.selectedUUID === uuid) {
                Sound.back();
                hideSelectedActions();
                post('campFocusProp', {});
                return;
            }
            const prop = findProp(uuid);
            if (!prop) return;
            Sound.select();
            showSelectedActions(uuid, prop);
            post('campFocusProp', { propUUID: uuid });
        });

        // ── Prop action: Reposition ──────────────────────────────────────────
        $('#mc-btn-edit-prop').on('click', function () {
            if (!mc.selectedUUID) return;
            if (!mc.isOwner && !(mc.myPerms && mc.myPerms.move_prop)) { permDeniedNotify(); return; }
            Sound.select();
            post('campEditProp', { propUUID: mc.selectedUUID });
        });

        // ── Prop action: Install ─────────────────────────────────────────────
        $('#mc-btn-install-prop').on('click', function () {
            if (!mc.selectedUUID) return;
            if (!mc.isOwner && !(mc.myPerms && mc.myPerms.place_prop)) { permDeniedNotify(); return; }
            Sound.select();
            post('campInstallPropMenu', { propUUID: mc.selectedUUID });
        });

        // ── Prop action: Remove ──────────────────────────────────────────────
        $('#mc-btn-remove-prop').on('click', function () {
            if (!mc.selectedUUID) return;
            if (!mc.isOwner && !(mc.myPerms && mc.myPerms.remove_prop)) { permDeniedNotify(); return; }
            Sound.remove();
            post('campRemoveProp', { propUUID: mc.selectedUUID });
            hideSelectedActions();
        });

        // ── Rename button ────────────────────────────────────────────────────
        $('#mc-rename-btn').on('click', function () {
            Sound.toggle();
            const current = $('#mc-camp-name').text();
            $('#mc-rename-input').val(current);
            $('#mc-rename-overlay').show();
            $('#mc-rename-input').focus();
        });

        $('#mc-rename-save').on('click', function () {
            const name = $('#mc-rename-input').val().trim();
            if (!name) return;
            Sound.select();
            post('campRenameCamp', { name: name });
            $('#mc-rename-overlay').hide();
        });

        $('#mc-rename-cancel').on('click', function () {
            Sound.back();
            $('#mc-rename-overlay').hide();
        });

        $('#mc-rename-input').on('keydown', function (ev) {
            if (ev.key === 'Enter') { $('#mc-rename-save').trigger('click'); }
            if (ev.key === 'Escape') { Sound.back(); $('#mc-rename-overlay').hide(); }
        });

        // ── Footer: Members toggle ───────────────────────────────────────────
        $('#mc-btn-members').on('click', function () {
            Sound.toggle();
            mc.membersVisible = !mc.membersVisible;
            if (mc.membersVisible) {
                $('#mc-props-section').hide();
                $('#mc-members-section').show();
                $(this).addClass('active');
                post('campGetNearbyPlayers', {});
                post('campSetMembersOpen', { open: true });
            } else {
                $('#mc-members-section').hide();
                $('#mc-props-section').show();
                $('#mc-markers-container').hide();
                $(this).removeClass('active');
                post('campSetMembersOpen', { open: false });
            }
        });

        // ── Footer: Delete camp ──────────────────────────────────────────────
        $('#mc-btn-delete-camp').on('click', function () {
            if (!mc.isOwner && !(mc.myPerms && mc.myPerms.delete_camp)) { permDeniedNotify(); return; }
            Sound.remove();
            post('campDeleteCamp', {});
        });

        // ── Footer: Move camp ────────────────────────────────────────────────
        $('#mc-btn-move-camp').on('click', function () {
            if (!mc.isOwner && !(mc.myPerms && mc.myPerms.move_camp)) { permDeniedNotify(); return; }
            Sound.select();
            post('campMoveCamp', {});
        });

        // ── Footer: Edit Mode toggle ─────────────────────────────────────────
        $('#mc-btn-edit-mode').on('click', function () {
            Sound.toggle();
            $(this).toggleClass('active');
            post('campToggleEditMode', {});
        });

        // ── Footer: Set Wardrobe ──────────────────────────────────────────────
        $('#mc-btn-set-wardrobe').on('click', function () {
            if (!mc.isOwner && !(mc.myPerms && mc.myPerms.set_wardrobe)) { permDeniedNotify(); return; }
            Sound.select();
            post('campSetWardrobe', {});
        });

        // ── Members: add by Server ID input ─────────────────────────────────
        $('#mc-member-add-btn').on('click', function () {
            const serverId = parseInt($('#mc-member-input').val(), 10);
            if (!serverId || serverId < 1) return;
            Sound.addCart();
            openPermDialog(L('ui_add') + ': Server ID ' + serverId, null, function (perms) {
                post('campAddMember', { targetServerId: serverId, permissions: perms });
                $('#mc-member-input').val('');
            });
        });

        $('#mc-member-input').on('keydown', function (ev) {
            if (ev.key === 'Enter') { $('#mc-member-add-btn').trigger('click'); }
        });

        // ── Members: click row to edit permissions ───────────────────────────
        $('#mc-members-list').on('click', '.mc-member-row', function () {
            if (!mc.isOwner) return;
            const charId = String($(this).data('charid') ?? '');
            if (!charId) return;
            let currentPerms = null;
            if (mc.camp && mc.camp.members) {
                for (const m of mc.camp.members) {
                    const mid = String((typeof m === 'object') ? m.charId : m);
                    if (mid === charId) { currentPerms = (typeof m === 'object') ? m.permissions : null; break; }
                }
            }
            Sound.toggle();
            openPermDialog(L('ui_edit_permissions') + ': ' + charId, currentPerms, function (perms) {
                post('campEditMemberPermissions', { targetCharId: charId, permissions: perms });
            });
        });

        // ── Members: remove member (stop propagation so row click doesn't fire)
        $('#mc-members-list').on('click', '.mc-remove-member', function (ev) {
            ev.stopPropagation();
            const charId = String($(this).data('charid') ?? '');
            if (!charId) return;
            Sound.remove();
            post('campRemoveMember', { targetCharId: charId });
        });

        // ── Nearby players: click to add ─────────────────────────────────────
        $('#mc-nearby-list').on('click', '.mc-add-nearby', function () {
            const serverId = parseInt($(this).data('serverid'), 10);
            const name     = $(this).data('name') || '';
            if (!serverId) return;
            Sound.addCart();
            openPermDialog(L('ui_add') + ': ' + (name || 'ID ' + serverId), null, function (perms) {
                post('campAddMember', { targetServerId: serverId, permissions: perms });
            });
        });

        // ── In-world markers: hover (black ↔ white) + click to add ──────────
        $('#mc-markers-container')
            .on('mouseenter', '.mc-world-marker', function () {
                _hoveredMarkerId = parseInt($(this).data('serverid'), 10) || null;
                $(this).find('.mc-marker-img').attr('src', './assets/img/circle-black.png');
            })
            .on('mouseleave', '.mc-world-marker', function () {
                _hoveredMarkerId = null;
                $(this).find('.mc-marker-img').attr('src', './assets/img/circle-white.png');
            })
            .on('click', '.mc-world-marker', function () {
                const serverId = parseInt($(this).data('serverid'), 10);
                if (!serverId) return;
                Sound.addCart();
                openPermDialog(L('ui_add') + ': ID ' + serverId, null, function (perms) {
                    post('campAddMember', { targetServerId: serverId, permissions: perms });
                });
            });

        // ── Permission dialog: confirm / cancel ──────────────────────────────
        $('#mc-perm-confirm').on('click', function () {
            const perms = {};
            $('#mc-perm-list .mc-perm-row').each(function () {
                perms[$(this).data('perm')] = $(this).hasClass('active');
            });
            if (typeof _permCallback === 'function') _permCallback(perms);
            closePermDialog();
        });

        $('#mc-perm-cancel').on('click', function () {
            Sound.back();
            closePermDialog();
        });

        // ── Inventory hover → prop preview ───────────────────────────────────
        let hoverClearTimer = null;

        $('#mc-inv-grid').on('mouseenter', '.mc-inv-item', function () {
            if (hoverClearTimer) { clearTimeout(hoverClearTimer); hoverClearTimer = null; }
            const itemName = $(this).data('itemname');
            if (itemName) { Sound.nav(); post('mycampHoverProp', { itemName: itemName }); }
            $('#mc-drag-hint').show();
        });

        $('#mc-inv-grid').on('mouseleave', '.mc-inv-item', function () {
            hoverClearTimer = setTimeout(function () {
                hoverClearTimer = null;
                post('mycampHoverProp', { itemName: null });
            }, 80);
            $('#mc-drag-hint').hide();
        });

        // ── Drag & drop: inventory → drop zone (mouse-based for CEF) ────────────
        let mcDrag = { active: false, itemName: null, count: 1, label: '', ghost: null, $source: null };

        function mcDragEnd(dropped) {
            if (mcDrag.ghost) { mcDrag.ghost.remove(); mcDrag.ghost = null; }
            if (mcDrag.$source) mcDrag.$source.removeClass('dragging');
            if (dropped && mcDrag.itemName) {
                post('campPlaceProp', { itemName: mcDrag.itemName, count: mcDrag.count, label: mcDrag.label });
            }
            mcDrag = { active: false, itemName: null, count: 1, label: '', ghost: null, $source: null };
            $('#mc-drop-zone').hide().removeClass('drag-over');
        }

        $('#mc-inv-grid').on('mousedown', '.mc-inv-item', function (ev) {
            if (ev.button !== 0) return;
            ev.preventDefault();
            ev.stopPropagation();
            $('#mc-drag-hint').hide();
            // Clear preview when drag starts
            post('mycampHoverProp', { itemName: null });
            mcDrag.itemName  = $(this).data('itemname');
            mcDrag.count     = parseInt($(this).data('count'), 10) || 1;
            mcDrag.$source   = $(this).addClass('dragging');
            mcDrag.active    = true;

            const label = $(this).find('.row-name').text();
            mcDrag.label = label;
            mcDrag.ghost = $('<div class="mc-drag-ghost"></div>').text(label);
            mcDrag.ghost.css({ left: ev.clientX + 10, top: ev.clientY - 12 });
            $('body').append(mcDrag.ghost);

            $('#mc-drop-zone').show();
        });

        $(document).on('mousemove.mcdrag', function (ev) {
            if (!mcDrag.active) return;
            if (mcDrag.ghost) mcDrag.ghost.css({ left: ev.clientX + 10, top: ev.clientY - 12 });

            const dz = document.getElementById('mc-drop-zone');
            if (!dz || !$(dz).is(':visible')) return;
            const r = dz.getBoundingClientRect();
            const over = ev.clientX >= r.left && ev.clientX <= r.right
                      && ev.clientY >= r.top  && ev.clientY <= r.bottom;
            $('#mc-drop-zone').toggleClass('drag-over', over);
        });

        $(document).on('mouseup.mcdrag', function (ev) {
            if (!mcDrag.active) return;
            const dz = document.getElementById('mc-drop-zone');
            let dropped = false;
            if (dz && $(dz).is(':visible')) {
                const r = dz.getBoundingClientRect();
                dropped = ev.clientX >= r.left && ev.clientX <= r.right
                       && ev.clientY >= r.top  && ev.clientY <= r.bottom;
            }
            mcDragEnd(dropped);
        });

        // ── Confirm dialog: YES ──────────────────────────────────────────────
        $('#fx-confirm-yes').on('click', function () {
            if (!mc.confirmPayload) { hideConfirm(); return; }
            post('confirmAction', mc.confirmPayload);
            hideConfirm();
        });

        // ── Confirm dialog: NO ───────────────────────────────────────────────
        $('#fx-confirm-no').on('click', function () {
            post('confirmCancel', {});
            hideConfirm();
        });

        // ── ESC: confirm + mycamp ─────────────────────────────────────────────
        $(document).on('keydown', function (ev) {
            if (ev.key !== 'Escape') return;
            // Always handle ESC for confirm regardless of mc.open
            if ($('#fx-confirm-overlay').is(':visible')) {
                post('confirmCancel', {});
                hideConfirm();
                return;
            }
            if (!mc.open) return;
            if ($('#mc-rename-overlay').is(':visible')) {
                $('#mc-rename-overlay').hide();
                return;
            }
            post('mycampClose', {});
        });
    }

    // ─── NUI MESSAGES ────────────────────────────────────────────────────────
    window.addEventListener('message', function (ev) {
        const d = ev.data || {};
        switch (d.action) {
            // ── Camp menu open ───────────────────────────────────────────────
            case 'openMyCamp':
            case 'mycampReopen':
                openMyCamp(d);
                break;

            // ── Camp menu close ──────────────────────────────────────────────
            case 'mycampClose':
                closeMyCampUI();
                break;

            // ── Temporarily hide (placement mode) ───────────────────────────
            case 'mycampHide':
                $('#mycamp-container').hide();
                break;

            // ── Data updated (live sync or after action) ─────────────────────
            case 'mycampUpdate':
                if (d.camp)      mc.camp      = d.camp;
                if (d.inventory) mc.inventory = d.inventory;
                renderAll();
                break;

            // ── Rename confirmed ─────────────────────────────────────────────
            case 'mycampSetName':
                if (d.name) {
                    $('#mc-camp-name').text(d.name);
                    if (mc.camp) mc.camp.camp_name = d.name;
                }
                break;

            // ── Nearby players response ──────────────────────────────────────
            case 'mycampNearbyPlayers':
                renderNearbyPlayers(d.players || []);
                break;

            // ── In-world marker positions ────────────────────────────────────
            case 'updateNearbyMarkers':
                updateMarkers(d.markers || []);
                break;

            // ── Placement HUD ────────────────────────────────────────────────
            case 'showPlacementHints':
                $('#placement-hud').show();
                $('#ph-radius-status').removeClass('ph-warn').addClass('ph-ok');
                $('#ph-radius-text').text(L('ui_within_radius'));
                // Multi-placement counter
                if (d.count && d.count > 1) {
                    $('#ph-counter-label').text(d.label || '');
                    updatePlacementCounter(d.count);
                    $('#ph-item-counter').show();
                } else {
                    $('#ph-item-counter').hide();
                }
                break;

            case 'hidePlacementHints':
                $('#placement-hud').hide();
                $('#ph-item-counter').hide();
                break;

            case 'placementCounterUpdate':
                if (d.count && d.count > 0) {
                    updatePlacementCounter(d.count);
                    $('#ph-item-counter').show();
                } else {
                    $('#ph-item-counter').hide();
                }
                break;

            case 'placementHintsUpdate': {
                const distLabel = (d.dist != null && d.maxDist != null)
                    ? `${d.dist}m / ${d.maxDist}m` : '— / —';
                $('#ph-dist-badge').text(distLabel);
                if (d.inRadius) {
                    $('#ph-radius-status').removeClass('ph-warn').addClass('ph-ok');
                    $('#ph-radius-text').text(L('ui_within_radius'));
                } else {
                    $('#ph-radius-status').removeClass('ph-ok').addClass('ph-warn');
                    $('#ph-radius-text').text(L('ui_outside_radius'));
                }
                break;
            }

            case 'placementAxisUpdate':
                $('#ph-axis-badge').text(d.axis || 'X');
                break;

            // ── Progress bar ─────────────────────────────────────────────────
            case 'ProgressBar': {
                const $img      = $('#progressbar-img');
                const itemName  = d.itemName || '';
                // Prefer the camping resource's own image (d.imageBase = Config.ItemImagePath).
                // Fall back to the framework inventory path (_imgPath) for compatibility.
                const campImg   = (d.imageBase && itemName)
                    ? d.imageBase.replace('%s', itemName)
                    : '';
                const fwImg     = (_imgPath && itemName)
                    ? ('nui://' + _imgPath + itemName + '.png')
                    : '';
                const fallback  = 'nui://fx-camping/ui/assets/img/dropicon.png';

                $img.off('error');
                if (campImg) {
                    // Try camping image first, then framework image, then fallback
                    $img.on('error', function () {
                        $(this).off('error');
                        if (fwImg) {
                            $(this).on('error', function () {
                                $(this).off('error').attr('src', fallback);
                            }).attr('src', fwImg);
                        } else {
                            $(this).attr('src', fallback);
                        }
                    });
                    $img.attr('src', campImg);
                } else {
                    $img.on('error', function () {
                        $(this).off('error').attr('src', fallback);
                    });
                    $img.attr('src', fwImg || fallback);
                }

                startCustomProgressBar(d.text, d.duration || 5000, function () {});
                break;
            }

            case 'StopProgress':
                clearCustomProgressBar();
                break;

            // ── Confirm dialog ───────────────────────────────────────────────
            case 'showConfirm':
                showConfirm(d);
                break;

            // ── Inventory item removed (prop placed from mycamp menu) ─────────
            // Immediately reduces the item count in the local inventory array so the
            // grid updates right away, before the server re-fetch arrives.
            case 'mycampRemoveInvItem': {
                const removedName = d.itemName;
                if (!removedName) break;
                mc.inventory = mc.inventory
                    .map(function (it) {
                        const n = it.itemName || it.name || '';
                        if (n !== removedName) return it;
                        return Object.assign({}, it, { count: (it.count || 1) - 1 });
                    })
                    .filter(function (it) { return (it.count || 0) > 0; });
                renderInvGrid(mc.inventory, mc.imageBase);
                break;
            }
        }
    });

    // ─── INIT ────────────────────────────────────────────────────────────────
    $(function () {
        bind();
    });
})();

// ═══════════════════════════════════════════════════════════════════════════════
// PLACEMENT INPUT — tüm tuş ve mouse olayları JS'den Lua'ya NUI callback ile
// ═══════════════════════════════════════════════════════════════════════════════
;(function () {
    'use strict';

    let active = false;

    // Basılı tutulunca tekrar eden tuşlar → action adı
    const HELD = {
        'ArrowUp':    'moveForward',
        'ArrowDown':  'moveBackward',
        'ArrowLeft':  'moveLeft',
        'ArrowRight': 'moveRight',
        'q': 'moveUp',    'Q': 'moveUp',
        'z': 'moveDown',  'Z': 'moveDown',
        'a': 'headingCCW','A': 'headingCCW',
        'd': 'headingCW', 'D': 'headingCW',
        'c': 'rotateCCW', 'C': 'rotateCCW',
        'v': 'rotateCW',  'V': 'rotateCW',
    };

    // Tek seferlik tuşlar → action adı
    const INSTANT = {
        'b': 'switchAxis',   'B': 'switchAxis',
        ' ': 'snapToGround',
        'Enter': 'confirm',
        'Escape': 'cancel',
    };

    function post(cb, data) {
        fetch('https://fx-camping/' + cb, {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify(data || {})
        });
    }

    // Placement aktif/pasif takibi
    window.addEventListener('message', function (e) {
        const d = e.data;
        if (!d) return;
        if (d.action === 'showPlacementHints') active = true;
        if (d.action === 'hidePlacementHints') active = false;
    });

    // Tuş basıldı
    $(document).on('keydown.placementInput', function (e) {
        if (!active) return;
        e.preventDefault();
        const held = HELD[e.key];
        if (held && !e.repeat) { post('placementKeyDown', { key: held }); return; }
        const instant = INSTANT[e.key];
        if (instant && !e.repeat) { post('placementAction', { action: instant }); }
    });

    // Tuş bırakıldı
    $(document).on('keyup.placementInput', function (e) {
        if (!active) return;
        const held = HELD[e.key];
        if (held) { post('placementKeyUp', { key: held }); }
    });

    // Sol/sağ tık durumu takibi
    let leftDown  = false;
    let rightDown = false;

    $(document).on('mousedown.placementInput', function (e) {
        if (!active) return;
        if (e.button === 0) leftDown  = true;
        if (e.button === 2) rightDown = true;
    });
    $(document).on('mouseup.placementInput', function (e) {
        if (e.button === 0) leftDown  = false;
        if (e.button === 2) rightDown = false;
    });

    // Sol tık basılı + yatay mouse → orbit kamera
    // Sağ tık basılı + dikey mouse → kamera Z yüksekliği
    $(document).on('mousemove.placementInput', function (e) {
        if (!active) return;
        const oe = e.originalEvent;
        if (!oe) return;
        if (leftDown  && oe.movementX !== 0) { post('placementMouseDelta', { dx: oe.movementX }); }
        if (rightDown && oe.movementY !== 0) { post('placementCamZDelta',  { delta: -oe.movementY }); }
    });

    // Scroll tekerleği → FOV
    document.addEventListener('wheel', function (e) {
        if (!active) return;
        e.preventDefault();
        post('placementFovDelta', { delta: e.deltaY / 10 });
    }, { passive: false });
})();

// ═══════════════════════════════════════════════════════════════════════════════
// ADMIN CAMPS PANEL
// ═══════════════════════════════════════════════════════════════════════════════
;(function () {
    'use strict';

    const ac = {
        open:       false,
        camps:      [],
        names:      {},
        selected:   null,
        blipsOpen:  false,
        previewing: false,
        camHeight:  50.0,   // mirrors AdminPreviewHeight in Lua
    };

    const $container      = () => $('#admincamp-container');
    const $campList       = () => $('#ac-camp-list');
    const $blipsBtn       = () => $('#ac-toggle-blips');
    const $blipsLabel     = () => $('#ac-blips-label');
    const $blipsIcon      = () => $('#ac-blips-icon');
    const $campCount      = () => $('#ac-camp-count');
    const $previewOverlay = () => $('#ac-preview-overlay');
    const $previewZone    = () => $('#ac-preview-zone');
    const $camControls    = () => $('#ac-cam-controls');

    // ── helpers ──────────────────────────────────────────────────────────────
    function post(cb, data) {
        return fetch('https://fx-camping/' + cb, {
            method:  'POST',
            headers: { 'Content-Type': 'application/json; charset=UTF-8' },
            body:    JSON.stringify(data || {}),
        });
    }

    function ownerName(camp) {
        return ac.names[String(camp.ownerCharId)] || ('Char #' + camp.ownerCharId);
    }

    // ── render ───────────────────────────────────────────────────────────────
    function buildDetailHtml(camp) {
        const owner     = ownerName(camp);
        const near      = camp.nearLocation || '—';
        const coordText = camp.baseCoords
            ? camp.baseCoords.x.toFixed(2) + ', ' + camp.baseCoords.y.toFixed(2) + ', ' + camp.baseCoords.z.toFixed(2)
            : '—';
        const cid = String(camp.campId);

        return '<div class="ac-row-detail">' +
            '<div class="ac-detail-name">' + (camp.campName || 'Camp') + '</div>' +
            '<div class="ac-detail-grid">' +
                '<div class="ac-detail-row"><span class="ac-detail-lbl">' + L('ui_owner') + '</span><span class="ac-detail-val">' + owner + '</span></div>' +
                '<div class="ac-detail-row"><span class="ac-detail-lbl">' + L('ui_location') + '</span><span class="ac-detail-val">' + near + '</span></div>' +
                '<div class="ac-detail-row"><span class="ac-detail-lbl">' + L('ui_coords') + '</span><span class="ac-detail-val">' + coordText + '</span>' +
                    (camp.baseCoords ? '<span class="ac-detail-copy" data-campid="' + cid + '"><iconify-icon icon="mdi:content-copy" style="pointer-events:none;"></iconify-icon></span>' : '') +
                '</div>' +
                '<div class="ac-detail-row"><span class="ac-detail-lbl">' + L('ui_props_count') + '</span><span class="ac-detail-val">' + (camp.propCount || 0) + ' ' + L('ui_placed') + '</span></div>' +
            '</div>' +
            '<div class="ac-detail-actions">' +
                '<div class="fx-btn btn-save ac-btn-preview" data-campid="' + cid + '">' +
                    '<iconify-icon icon="mdi:eye-outline" style="pointer-events:none;"></iconify-icon> ' + L('ui_preview') +
                '</div>' +
                '<div class="fx-btn btn-cancel ac-btn-delete" data-campid="' + cid + '">' +
                    '<iconify-icon icon="mdi:delete-forever" style="pointer-events:none;"></iconify-icon> ' + L('ui_delete') +
                '</div>' +
            '</div>' +
        '</div>';
    }

    function renderCampList() {
        const list = $campList();
        list.empty();
        $campCount().text(ac.camps.length);

        if (ac.camps.length === 0) {
            list.append('<div style="color:#7a6a50;font-family:rdr;font-size:1.1vh;padding:12px 0;text-align:center;">' + L('ui_no_camps') + '</div>');
            return;
        }

        ac.camps.forEach(function (camp) {
            const owner    = ownerName(camp);
            const near     = camp.nearLocation || '—';
            const selected = ac.selected && ac.selected.campId === camp.campId;

            const nameColor = selected ? '#e8d5a0' : '#c9a86c';
            const metaColor = selected ? '#b0956a' : '#7a6a50';

            const $row = $('<div class="nav-row ac-camp-row' + (selected ? ' ac-selected' : '') + '">')
                .attr('data-campid', camp.campId);

            const $header = $('<div class="ac-row-header">')
                .append(
                    $('<div>').css({ display:'flex', flexDirection:'column', gap:'3px', flex:'1', minWidth:0 })
                        .append($('<span>').css({ fontFamily:'rdr', fontSize:'1.15vh', color:nameColor, letterSpacing:'1px', whiteSpace:'nowrap', overflow:'hidden', textOverflow:'ellipsis' }).text(camp.campName || 'Camp'))
                        .append($('<span>').css({ fontFamily:'rdr', fontSize:'0.88vh', color:metaColor, letterSpacing:'0.4px', whiteSpace:'nowrap', overflow:'hidden', textOverflow:'ellipsis' }).text(owner + '   ·   ' + near))
                )
                .append($('<iconify-icon class="chev" icon="mdi:chevron-right">'));

            $row.append($header);
            if (selected) $row.append(buildDetailHtml(camp));

            list.append($row);
        });
    }

    function selectCamp(camp) {
        Sound.nav();
        // Toggle: clicking the already-selected camp collapses it
        ac.selected = (ac.selected && ac.selected.campId === camp.campId) ? null : camp;
        renderCampList();
    }

    // ── camera controls ───────────────────────────────────────────────────────
    let _camHoldTimer  = null;
    let _camDragActive = false;
    let _dragLastX     = 0;
    let _dragLastY     = 0;
    let _keyHoldTimer  = null;
    const _heldKeys    = {};

    function camSendPan(dx, dy) {
        post('adminPreviewCameraInput', { type: 'pan', dx: dx, dy: dy });
    }

    function camSendZoom(delta) {
        // delta > 0 = zoom in (camera lower), delta < 0 = zoom out (camera higher)
        ac.camHeight = Math.max(15, Math.min(120, ac.camHeight - delta));
        post('adminPreviewCameraInput', { type: 'zoom', delta: delta });
    }

    function startCamHold(fn) {
        fn();
        _camHoldTimer = setInterval(fn, 80);
    }

    function stopCamHold() {
        if (_camHoldTimer) { clearInterval(_camHoldTimer); _camHoldTimer = null; }
    }

    function bindCamBtn(id, fn) {
        const $el = $(id);
        $el.on('mousedown', function (e) {
            e.preventDefault();
            e.stopPropagation();
            $el.addClass('ac-cam-active');
            startCamHold(fn);
        });
        // Global mouseup releases all held buttons
        $(document).on('mouseup.camhold', function () {
            stopCamHold();
            $('.ac-cam-dir-btn, .ac-cam-action-btn').removeClass('ac-cam-active');
        });
    }

    function bindCamControls() {
        const PAN_STEP  = 3.0;
        const ZOOM_STEP = 6.0;

        // Button → action map (shared by mouse hold and keyboard)
        const btnActions = {
            '#ac-cam-up':       function () { camSendPan(0,  PAN_STEP); },
            '#ac-cam-down':     function () { camSendPan(0, -PAN_STEP); },
            '#ac-cam-left':     function () { camSendPan(-PAN_STEP, 0); },
            '#ac-cam-right':    function () { camSendPan( PAN_STEP, 0); },
            '#ac-cam-zoom-in':  function () { camSendZoom( ZOOM_STEP); },
            '#ac-cam-zoom-out': function () { camSendZoom(-ZOOM_STEP); },
        };
        for (const sel in btnActions) bindCamBtn(sel, btnActions[sel]);

        // Key → button selector + per-tick delta (supports simultaneous keys)
        const keyBtnMap = {
            'ArrowUp':    '#ac-cam-up',
            'ArrowDown':  '#ac-cam-down',
            'ArrowLeft':  '#ac-cam-left',
            'ArrowRight': '#ac-cam-right',
            '+':          '#ac-cam-zoom-in',
            '=':          '#ac-cam-zoom-in',
            '-':          '#ac-cam-zoom-out',
        };
        const keyPanMap = {
            'ArrowUp':    { dx: 0,         dy: PAN_STEP  },
            'ArrowDown':  { dx: 0,         dy: -PAN_STEP },
            'ArrowLeft':  { dx: -PAN_STEP, dy: 0         },
            'ArrowRight': { dx: PAN_STEP,  dy: 0         },
        };
        const keyZoomMap = { '+': ZOOM_STEP, '=': ZOOM_STEP, '-': -ZOOM_STEP };

        function tickKeys() {
            let dx = 0, dy = 0, dz = 0;
            for (const k in _heldKeys) {
                if (keyPanMap[k])  { dx += keyPanMap[k].dx;  dy += keyPanMap[k].dy; }
                if (keyZoomMap[k]) { dz += keyZoomMap[k]; }
            }
            if (dx !== 0 || dy !== 0) camSendPan(dx, dy);
            if (dz !== 0)             camSendZoom(dz);
        }

        $(document).on('keydown.camprev', function (e) {
            if (!ac.previewing) return;
            if (!keyBtnMap[e.key]) return;
            if (_heldKeys[e.key]) return;   // already held, browser repeat — ignore
            e.preventDefault();
            _heldKeys[e.key] = true;
            $(keyBtnMap[e.key]).addClass('ac-cam-active');
            tickKeys();   // immediate response on first press
            if (!_keyHoldTimer) _keyHoldTimer = setInterval(tickKeys, 80);
        });

        $(document).on('keyup.camprev', function (e) {
            if (!_heldKeys[e.key]) return;
            delete _heldKeys[e.key];
            $(keyBtnMap[e.key]).removeClass('ac-cam-active');
            if (Object.keys(_heldKeys).length === 0 && _keyHoldTimer) {
                clearInterval(_keyHoldTimer);
                _keyHoldTimer = null;
            }
        });

        // Mouse drag-to-pan: uses absolute clientX/Y delta to avoid movementX/Y
        // accumulation bugs that occur after scroll events in CEF.
        $(document).on('mousedown.camprev', function (e) {
            if (!ac.previewing || e.button !== 0) return;
            if ($(e.target).closest('.panel, #ac-cam-controls').length) return;
            _camDragActive = true;
            _dragLastX     = e.clientX;
            _dragLastY     = e.clientY;
            $('html').addClass('ac-cam-grabbing');
            e.preventDefault();
        });
        $(document).on('mousemove.camprev', function (e) {
            if (!_camDragActive || !ac.previewing) return;
            const movX = e.clientX - _dragLastX;
            const movY = e.clientY - _dragLastY;
            _dragLastX  = e.clientX;
            _dragLastY  = e.clientY;
            if (movX === 0 && movY === 0) return;
            // Grab-and-drag convention (same as map pan):
            //   drag right → camera moves west  → dx = -movX * scale
            //   drag down  → camera moves north → dy = +movY * scale
            const scale = (2 * ac.camHeight * Math.tan(40 * Math.PI / 180)) / window.innerHeight;
            camSendPan(-movX * scale, +movY * scale);
        });
        $(document).on('mouseup.camprev', function () {
            _camDragActive = false;
            $('html').removeClass('ac-cam-grabbing');
        });

        // Scroll wheel: scroll UP = zoom in, scroll DOWN = zoom out
        document.addEventListener('wheel', function (e) {
            if (!ac.previewing) return;
            e.preventDefault();
            // Negate deltaY: scroll down (deltaY > 0) → zoom out (delta < 0 → height increases)
            camSendZoom(-(e.deltaY / 100) * 8.0);
        }, { passive: false });
    }

    function _clearCamKeyState() {
        for (const k in _heldKeys) {
            const sel = {
                'ArrowUp': '#ac-cam-up', 'ArrowDown': '#ac-cam-down',
                'ArrowLeft': '#ac-cam-left', 'ArrowRight': '#ac-cam-right',
                '+': '#ac-cam-zoom-in', '=': '#ac-cam-zoom-in', '-': '#ac-cam-zoom-out',
            }[k];
            if (sel) $(sel).removeClass('ac-cam-active');
            delete _heldKeys[k];
        }
        if (_keyHoldTimer) { clearInterval(_keyHoldTimer); _keyHoldTimer = null; }
    }

    // ── open / close ─────────────────────────────────────────────────────────
    function stopPreview() {
        if (!ac.previewing) return;
        ac.previewing = false;
        _camDragActive = false;
        _clearCamKeyState();
        $('html').removeClass('ac-cam-grabbing');
        $previewOverlay().hide();
        $camControls().hide();
        post('adminCampsStopPreview', {});
    }

    function openAdminCamps(data) {
        if (data.locale) Object.assign(_loc, data.locale);
        ac.camps      = data.camps  || [];
        ac.names      = data.names  || {};
        ac.selected   = null;
        ac.open       = true;
        ac.previewing = false;
        ac.camHeight  = 50.0;
        $previewOverlay().hide();
        $camControls().hide();

        $container().show();
        renderCampList();
        updateBlipsBtn();
        Sound.open();
    }

    function closeAdminCamps() {
        if (!ac.open) return;
        if (ac.previewing) stopPreview();
        ac.open     = false;
        ac.selected = null;
        $container().hide();
        Sound.close();
        post('adminCampsClose', {});
    }

    function updateBlipsBtn() {
        if (ac.blipsOpen) {
            $blipsLabel().text(L('ui_close_blips'));
            $blipsIcon().attr('icon', 'mdi:map-marker-multiple');
            $blipsBtn().removeClass('btn-save').addClass('btn-cancel');
        } else {
            $blipsLabel().text(L('ui_open_blips'));
            $blipsIcon().attr('icon', 'mdi:map-marker-multiple-outline');
            $blipsBtn().removeClass('btn-cancel').addClass('btn-save');
        }
    }

    // ── bindings ─────────────────────────────────────────────────────────────
    function bind() {
        // Row header click → select / collapse (delegated)
        $campList().on('click', '.ac-row-header', function () {
            const campId = $(this).closest('.ac-camp-row').data('campid');
            const camp   = ac.camps.find(c => String(c.campId) === String(campId));
            if (camp) selectCamp(camp);
        });

        // Copy coordinates (delegated)
        $campList().on('click', '.ac-detail-copy', function (e) {
            e.stopPropagation();
            if (!ac.selected || !ac.selected.baseCoords) return;
            const c    = ac.selected.baseCoords;
            const text = c.x.toFixed(2) + ', ' + c.y.toFixed(2) + ', ' + c.z.toFixed(2);
            const el   = document.createElement('textarea');
            el.value   = text;
            el.style.cssText = 'position:fixed;top:0;left:0;opacity:0;pointer-events:none;';
            document.body.appendChild(el);
            el.focus();
            el.select();
            document.execCommand('copy');
            document.body.removeChild(el);
            post('adminCampsCopyCoords', {});
            Sound.nav();
        });

        // Toggle blips
        $blipsBtn().on('click', function () {
            Sound.nav();
            post('adminCampsToggleBlips', { camps: ac.camps, names: ac.names })
                .then(r => r.json())
                .then(function (res) {
                    ac.blipsOpen = !!res.open;
                    updateBlipsBtn();
                });
        });

        // Preview (delegated)
        $campList().on('click', '.ac-btn-preview', function (e) {
            e.stopPropagation();
            if (!ac.selected || !ac.selected.baseCoords) return;
            if (ac.previewing) return;
            Sound.nav();
            ac.previewing = true;
            ac.camHeight  = 50.0;
            const loc = ac.selected.nearLocation || '';
            $previewZone().text(loc);
            $previewOverlay().show();
            $camControls().show();
            post('adminCampsPreview', { coords: ac.selected.baseCoords, location: loc });
        });

        // Delete (delegated)
        $campList().on('click', '.ac-btn-delete', function (e) {
            e.stopPropagation();
            if (!ac.selected) return;
            Sound.nav();
            if (ac.previewing) stopPreview();
            const campId   = ac.selected.campId;
            const campName = ac.selected.campName || '';
            post('adminCampsDelete', { campId: campId, campName: campName })
                .then(r => r.json())
                .then(function (res) {
                    if (res.ok) {
                        Sound.close();
                        ac.camps    = ac.camps.filter(c => c.campId !== campId);
                        ac.selected = null;
                        renderCampList();
                    }
                });
        });
    }

    // ── NUI messages ─────────────────────────────────────────────────────────
    window.addEventListener('message', function (ev) {
        const d = ev.data || {};
        switch (d.action) {
            case 'openAdminCamps':
                openAdminCamps(d);
                break;

            case 'adminCampsClose':
                closeAdminCamps();
                break;

            case 'campEditHud':
                if (d.visible) {
                    $('#camp-edit-hud').show();
                } else {
                    $('#camp-edit-hud').hide();
                }
                break;

            // Lua tarafında preview durdu (resource stop vb.)
            case 'adminPreviewStopped':
                ac.previewing = false;
                _camDragActive = false;
                _clearCamKeyState();
                $('html').removeClass('ac-cam-grabbing');
                $previewOverlay().hide();
                $camControls().hide();
                break;
        }
    });

    // ── ESC key ──────────────────────────────────────────────────────────────
    $(document).on('keydown', function (e) {
        if (e.key === 'Escape') {
            if (ac.previewing) {
                stopPreview();
            } else if (ac.open) {
                closeAdminCamps();
            }
        }
    });

    // ── INIT ─────────────────────────────────────────────────────────────────
    $(function () { bind(); bindCamControls(); });
})();

// ═══════════════════════════════════════════════════════════════════════════════
// CREATE CAMP  (/createcamp)
// ═══════════════════════════════════════════════════════════════════════════════
(function () {
    'use strict';

    const cc = { open: false, items: [], imageBase: '' };

    function post(cb, data) {
        return fetch('https://fx-camping/' + cb, {
            method:  'POST',
            headers: { 'Content-Type': 'application/json; charset=UTF-8' },
            body:    JSON.stringify(data || {}),
        });
    }

    const $container  = () => $('#createcamp-container');
    const $grid       = () => $('#cc-inv-grid');
    const $itemsCount = () => $('#cc-items-count');

    function renderGrid(items) {
        const $g = $grid().empty();
        if (!items || items.length === 0) {
            $g.append('<div class="list-empty">No base items found.</div>');
            $itemsCount().text('0');
            return;
        }
        $itemsCount().text(items.length);
        items.forEach(function (item) {
            $g.append(
                `<div class="nav-row cc-item-row" data-item-name="${item.name}">
                    <iconify-icon class="row-icon" icon="mdi:tent" style="pointer-events:none;"></iconify-icon>
                    <span class="row-name" style="pointer-events:none;">${item.label || item.name}</span>
                    <span class="row-meta" style="pointer-events:none;">x${item.count || 1}</span>
                </div>`
            );
        });
    }

    function selectItem(itemName) {
        if (!itemName || !cc.open) return;
        cc.open = false;
        $grid().off('click.cc');
        $container().fadeOut(200);
        post('createCampUseItem', { itemName: itemName });
    }

    function openCreateCampUI(data) {
        if (cc.open) return;
        cc.open      = true;
        cc.items     = data.items     || [];
        cc.imageBase = data.imageBase || '';
        renderGrid(cc.items);
        $container().fadeIn(250);
        $grid().off('click.cc').on('click.cc', '.cc-item-row', function () {
            selectItem($(this).data('item-name'));
        });
    }

    function closeCreateCampUI() {
        if (!cc.open) return;
        cc.open = false;
        $grid().off('click.cc');
        $container().fadeOut(200);
        post('createCampClose', {});
    }

    $(document).on('keydown.cc', function (e) {
        if (e.key === 'Escape' && cc.open) { closeCreateCampUI(); }
    });

    window.addEventListener('message', function (e) {
        const d = e.data;
        if (!d || !d.action) return;
        if (d.action === 'openCreateCamp') {
            openCreateCampUI(d);
        } else if (d.action === 'createCampClose') {
            if (cc.open) {
                cc.open = false;
                $grid().off('click.cc');
                $container().fadeOut(200);
            }
        }
    });
})();

// ═══════════════════════════════════════════════════════════════════════════════
// CAMP INFO  (/campinfo)
// ═══════════════════════════════════════════════════════════════════════════════
(function () {
    'use strict';

    const ci = {
        open:        false,
        steps:       [],
        total:       0,
        currentStep: 0,
        lang:        'en',
    };

    function post(cb, data) {
        return fetch('https://fx-camping/' + cb, {
            method:  'POST',
            headers: { 'Content-Type': 'application/json; charset=UTF-8' },
            body:    JSON.stringify(data || {}),
        });
    }

    const $container    = () => $('#campinfo-container');
    const $tabInfo      = () => $('#ci-tab-info');
    const $tabTutorial  = () => $('#ci-tab-tutorial');
    const $tabCommands  = () => $('#ci-tab-commands');
    const $bodyInfo     = () => $('#ci-info-body');
    const $bodyTutorial = () => $('#ci-tutorial-body');
    const $bodyCommands = () => $('#ci-commands-body');

    function switchTab(tab) {
        $tabInfo().removeClass('active');
        $tabTutorial().removeClass('active');
        $tabCommands().removeClass('active');
        $bodyInfo().hide();
        $bodyTutorial().hide();
        $bodyCommands().hide();
        $('#ci-nav-row').hide();

        if (tab === 'info') {
            $tabInfo().addClass('active');
            $bodyInfo().show();
        } else if (tab === 'tutorial') {
            $tabTutorial().addClass('active');
            $bodyTutorial().show();
            $('#ci-nav-row').css('display', 'flex');
        } else if (tab === 'commands') {
            $tabCommands().addClass('active');
            $bodyCommands().show();
        }
    }

    function renderCampInfo(campInfo) {
        if (!campInfo) {
            $('#ci-no-camp').show();
            $('#ci-camp-data').hide();
            return;
        }
        $('#ci-no-camp').hide();
        $('#ci-camp-data').show();
        $('#ci-camp-name').text(campInfo.name     || '—');
        $('#ci-camp-location').text(campInfo.location || '—');
        const inst  = campInfo.propInst  || 0;
        const total = campInfo.propTotal || 0;
        $('#ci-camp-props').text(inst + ' / ' + total);
        $('#ci-camp-members').text(campInfo.members || 0);
    }

    function renderTutorialStep(index) {
        const step = ci.steps[index];
        if (!step) return;
        ci.currentStep = index;

        $('#ci-step-current').text(step.index || (index + 1));
        $('#ci-step-total').text(ci.total);
        $('#ci-step-title').text(step.title || '');
        $('#ci-step-desc').text(step.desc   || '');

        const $noImg    = $('#ci-no-image');
        const $caption  = $('#ci-img-caption');
        const $imgCont  = $('#ci-images-container');
        const images    = step.images || [];

        $imgCont.empty();

        if (images.length > 0) {
            $noImg.hide();
            $imgCont.show();
            images.forEach(function (src) {
                const $wrapper = $('<div class="ci-img-wrapper"></div>');
                const $img     = $('<img>').attr({ alt: '', src: '' });
                $wrapper.append($img);
                $imgCont.append($wrapper);
                // CEF GIF dondurma önlemi: show'dan sonra src set et
                setTimeout(function () { $img.attr('src', src); }, 0);
            });
            if (step.caption && step.caption !== '') {
                $caption.text(step.caption).show();
            } else {
                $caption.hide();
            }
        } else {
            $imgCont.hide();
            $noImg.show();
            $caption.hide();
        }

        const $dots = $('#ci-step-dots');
        $dots.empty();
        for (let i = 0; i < ci.total; i++) {
            const $dot = $('<span class="ci-dot"></span>');
            if (i === index) $dot.addClass('active');
            (function (idx) {
                $dot.on('click', function () { renderTutorialStep(idx); });
            })(i);
            $dots.append($dot);
        }

        $('#ci-btn-prev').prop('disabled', index === 0);
        $('#ci-btn-next').prop('disabled', index === ci.total - 1);
    }

    function openLightbox(src) {
        $('#ci-lightbox-img').attr('src', src);
        $('#ci-lightbox').stop(true).css({ display: 'flex', opacity: 0 }).animate({ opacity: 1 }, 200);
    }

    function closeLightbox() {
        $('#ci-lightbox').stop(true).animate({ opacity: 0 }, 150, function () {
            $(this).hide();
            $('#ci-lightbox-img').attr('src', '');
        });
    }

    function renderCommands(commands) {
        const $list = $('#ci-commands-list');
        $list.empty();
        if (!commands || commands.length === 0) return;
        commands.forEach(function (c) {
            const $row = $('<div class="ci-cmd-row"></div>');
            const $top = $('<div class="ci-cmd-top"></div>');
            const $badge = $('<span class="ci-cmd-badge"></span>').text(c.cmd);
            $top.append($badge);
            if (c.admin) {
                $top.append($('<span class="ci-cmd-admin">ADMIN</span>'));
            }
            const $desc = $('<div class="ci-cmd-desc"></div>');
            if (c.descKey) { $desc.attr('data-i18n', c.descKey).text(L(c.descKey)); }
            else { $desc.text(c.desc || ''); }
            $row.append($top).append($desc);
            $list.append($row);
        });
    }

    function openCampInfoUI(data) {
        if (ci.open) return;
        ci.open        = true;
        ci.steps       = data.steps    || [];
        ci.total       = data.total    || ci.steps.length;
        ci.lang        = data.lang     || 'en';
        ci.commands    = data.commands || [];
        ci.currentStep = 0;

        renderCampInfo(data.campInfo);
        if (ci.steps.length > 0) { renderTutorialStep(0); }
        renderCommands(ci.commands);

        switchTab('info');
        $container().fadeIn(250);
    }

    function closeCampInfoUI() {
        if (!ci.open) return;
        ci.open = false;
        closeLightbox();
        $container().fadeOut(200);
        post('campInfoClose', {});
    }

    $(document).on('click', '#ci-tab-info',      function () { switchTab('info'); });
    $(document).on('click', '#ci-tab-tutorial',  function () { switchTab('tutorial'); });
    $(document).on('click', '#ci-tab-commands',  function () { switchTab('commands'); });

    $(document).on('click', '#ci-btn-prev', function () {
        if (ci.currentStep > 0) { renderTutorialStep(ci.currentStep - 1); }
    });
    $(document).on('click', '#ci-btn-next', function () {
        if (ci.currentStep < ci.total - 1) { renderTutorialStep(ci.currentStep + 1); }
    });

    $(document).on('click', '#ci-images-container .ci-img-wrapper img', function () {
        const src = $(this).attr('src');
        if (src && src !== '') { openLightbox(src); }
    });

    $(document).on('click', '#ci-lightbox', function () { closeLightbox(); });

    $(document).on('click', '#ci-close-btn', function () { closeCampInfoUI(); });

    $(document).on('keydown.ci', function (e) {
        if (!ci.open) return;
        if (e.key === 'Escape') {
            if ($('#ci-lightbox').is(':visible')) { closeLightbox(); }
            else { closeCampInfoUI(); }
        }
        if (e.key === 'ArrowLeft'  && ci.currentStep > 0)         { renderTutorialStep(ci.currentStep - 1); }
        if (e.key === 'ArrowRight' && ci.currentStep < ci.total-1) { renderTutorialStep(ci.currentStep + 1); }
    });

    window.addEventListener('message', function (e) {
        const d = e.data;
        if (!d || !d.action) return;
        if (d.action === 'openCampInfo') {
            openCampInfoUI(d);
        } else if (d.action === 'campInfoUpdate') {
            renderCampInfo(d.campInfo);
        } else if (d.action === 'campInfoClose') {
            if (ci.open) {
                ci.open = false;
                closeLightbox();
                $container().fadeOut(200);
            }
        }
    });
})();
