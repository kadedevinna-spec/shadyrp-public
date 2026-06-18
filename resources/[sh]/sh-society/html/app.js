const root = document.getElementById('root');
const storefrontRoot = document.getElementById('storefront-root');
const storefrontCategoriesRoot = document.getElementById('storefront-categories');
const storefrontList = document.getElementById('storefront-list');
const craftingRoot = document.getElementById('crafting-root');
const craftingTitle = document.getElementById('crafting-title');
const craftingSubtitle = document.getElementById('crafting-subtitle');
const craftingListRoot = document.getElementById('crafting-list');
const craftingRecipeImage = document.getElementById('crafting-recipe-image');
const craftingRecipeTitle = document.getElementById('crafting-recipe-title');
const craftingRecipeDescription = document.getElementById('crafting-recipe-description');
const craftingRecipeTime = document.getElementById('crafting-recipe-time');
const craftingRecipeOutput = document.getElementById('crafting-recipe-output');
const craftingIngredientsRoot = document.getElementById('crafting-ingredients');
const craftingOutputsRoot = document.getElementById('crafting-outputs');
const craftingQuantityInput = document.getElementById('crafting-quantity');
const craftingCraftBtn = document.getElementById('crafting-craft-btn');
const craftingProgressRoot = document.getElementById('crafting-progress');
const craftingProgressTitle = document.getElementById('crafting-progress-title');
const craftingProgressPercent = document.getElementById('crafting-progress-percent');
const craftingProgressFill = document.getElementById('crafting-progress-fill');
const advertRoot = document.getElementById('advert-root');
const advertImageEl = document.getElementById('advert-image');
const advertFallbackEl = document.getElementById('advert-fallback');
const advertCaptionEl = document.getElementById('advert-caption');
const billsRoot = document.getElementById('bills-root');
const billsList = document.getElementById('bills-list');
const invoiceRoot = document.getElementById('invoice-root');
const jobOfferRoot = document.getElementById('job-offer-root');
const invoicePlayerSelect = document.getElementById('invoice-player-select');
const tabsRoot = document.getElementById('tabs');
const panes = Array.from(document.querySelectorAll('.pane'));
const toastRoot = document.getElementById('toast-root');
const REQUEST_COOLDOWN_MS = 300;
const REQUEST_TIMEOUT_MS = 10000;
const MAX_IN_FLIGHT_REQUESTS = 3;
const DEFAULT_BLIP_SPRITE = -1954662204; // Tithing
const requestNextAt = {};
let requestInFlight = 0;
let storefrontOpen = false;
let storefrontData = null;
let storefrontSelectedCategory = 'all';
let storefrontMode = 'buy';
let craftingOpen = false;
let craftingData = null;
let craftingSelectedRecipeId = '';
let craftingBusy = false;
let craftingProgressTimer = null;
let craftingProgressState = null;
let advertOpen = false;
let billsWindowOpen = false;
let invoiceWindowOpen = false;
let jobOfferOpen = false;
let invoiceWindowState = {
  societyId: '',
  societyLabel: '',
  players: [],
};
let jobOfferState = {
  offerId: '',
};

const DEFAULT_THEME_PRESET_COLORS = [
  '#9e7840',
  '#6f4f27',
  '#8f312a',
  '#2f6b4a',
  '#3d5f89',
  '#d8c19b',
];

const state = {
  mode: 'society',
  societyId: '',
  societies: [],
  publicJobs: [],
  selectedSociety: null,
  invoices: [],
  myInvoices: [],
  societyInvoices: [],
  billingStatusFilter: 'all',
  adminSelectedSocietyId: '',
  employees: [],
  onlinePlayers: [],
  invoiceCandidates: [],
  ranks: [],
  rankPermissions: [],
  stores: [],
  storePropList: [],
  craftingEnabled: true,
  craftingPropList: [],
  ingameWebhookEnabled: false,
  adverts: [],
  advertPropList: [],
  managerInventory: [],
  selectedStoreId: '',
  selectedStoreStockItem: '',
  selectedStoreBuyItem: '',
  selectedAdvertId: '',
  blips: [],
  selectedBlipSprites: {
    business: DEFAULT_BLIP_SPRITE,
    store: DEFAULT_BLIP_SPRITE,
  },
  blipSearch: {
    business: '',
    store: '',
  },
  transactions: [],
  myCharId: '',
  themePresetColors: [...DEFAULT_THEME_PRESET_COLORS],
  themePresetTarget: 'theme-primary',
  storeQtyBounds: { min: 1, max: 50 },
};

const DEFAULT_THEME = {
  primary: '#9e7840',
  secondary: '#6f4f27',
  surface: '#faf1e0',
  surface2: '#e6d4b5',
  card: '#fffaf0',
  text: '#1c1510',
  muted: '#4b3928',
  icon: 'star',
};

const THEME_ICON_VALUES = new Set(['star', 'eagle', 'shield', 'coins', 'store', 'wrench', 'horse', 'scales', 'hammer', 'lamp', 'gear', 'wheat']);

const LOCATION_PRESETS = {
  valentine: { x: -279.42, y: 804.9, z: 119.38 },
  rhodes: { x: 1327.49, y: -1291.92, z: 77.02 },
  saintdenis: { x: 2629.86, y: -1223.95, z: 53.38 },
  blackwater: { x: -786.1, y: -1322.9, z: 43.89 },
  strawberry: { x: -1788.61, y: -386.67, z: 160.33 },
  tumbleweed: { x: -5519.86, y: -2948.84, z: -1.88 },
};

function normalizeStoreQtyBounds(bounds) {
  const rawMin = Number(bounds?.min ?? bounds?.MinQty ?? 1);
  const rawMax = Number(bounds?.max ?? bounds?.MaxQty ?? 50);
  const min = Number.isFinite(rawMin) ? Math.max(1, Math.floor(rawMin)) : 1;
  const maxCandidate = Number.isFinite(rawMax) ? Math.floor(rawMax) : 50;
  const max = Math.max(min, maxCandidate);
  return { min, max };
}

function getStoreQtyBounds() {
  return normalizeStoreQtyBounds(state.storeQtyBounds || { min: 1, max: 50 });
}

function clampStoreQty(value) {
  const bounds = getStoreQtyBounds();
  const raw = Number(value);
  if (!Number.isFinite(raw)) return bounds.min;
  return Math.max(bounds.min, Math.min(bounds.max, Math.floor(raw)));
}

function applyStoreQtyInputBounds() {
  const input = document.getElementById('store-stock-qty');
  if (!input) return;
  const bounds = getStoreQtyBounds();
  input.min = String(bounds.min);
  input.max = String(bounds.max);
  input.value = String(clampStoreQty(Number(input.value || bounds.min)));
}

const BLIP_ICON_OPTIONS = [
  { sprite: -861219276, key: 'blip_ambient_bounty_hunter', label: 'Bounty Hunter', marker: 'BH' },
  { sprite: -535302224, key: 'blip_ambient_bounty_hunter_higher', label: 'Bounty High', marker: 'B+' },
  { sprite: 1481032477, key: 'blip_ambient_bounty_target', label: 'Bounty Target', marker: 'BT' },
  { sprite: 1321928545, key: 'blip_ambient_chore', label: 'Chore', marker: 'CH' },
  { sprite: 1012165077, key: 'blip_ambient_coach', label: 'Coach', marker: 'CO' },
  { sprite: -185399168, key: 'blip_ambient_companion', label: 'Companion', marker: 'CP' },
  { sprite: 350569997, key: 'blip_ambient_death', label: 'Death', marker: 'DE' },
  { sprite: -2018361632, key: 'blip_ambient_eyewitness', label: 'Eyewitness', marker: 'EW' },
  { sprite: -1489164512, key: 'blip_ambient_gang_leader', label: 'Gang Leader', marker: 'GL' },
  { sprite: 423351566, key: 'blip_ambient_herd', label: 'Herd', marker: 'HD' },
  { sprite: 1220803671, key: 'blip_ambient_hitching_post', label: 'Hitching Post', marker: 'HP' },
  { sprite: -643888085, key: 'blip_ambient_horse', label: 'Horse', marker: 'HS' },
  { sprite: -1596758107, key: 'blip_ambient_law', label: 'Law', marker: 'LW' },
  { sprite: 1838354131, key: 'blip_ambient_loan_shark', label: 'Loan Shark', marker: 'LS' },
  { sprite: 587827268, key: 'blip_ambient_newspaper', label: 'Newspaper', marker: 'NP' },
  { sprite: 305281166, key: 'blip_ambient_npc', label: 'NPC', marker: 'NC' },
  { sprite: 249721687, key: 'blip_ambient_quartermaster', label: 'Quartermaster', marker: 'QM' },
  { sprite: 2033397166, key: 'blip_ambient_riverboat', label: 'Riverboat', marker: 'RB' },
  { sprite: -693644997, key: 'blip_ambient_sheriff', label: 'Sheriff', marker: 'SF' },
  { sprite: 503049244, key: 'blip_ambient_telegraph', label: 'Telegraph', marker: 'TG' },
  { sprite: -417940443, key: 'blip_ambient_theatre', label: 'Theatre', marker: 'TH' },
  { sprite: -1580514024, key: 'blip_ambient_tracking', label: 'Tracking', marker: 'TK' },
  { sprite: -250506368, key: 'blip_ambient_train', label: 'Train', marker: 'TR' },
  { sprite: 874255393, key: 'blip_ambient_wagon', label: 'Wagon', marker: 'WG' },
  { sprite: 784218150, key: 'blip_ambient_warp', label: 'Warp', marker: 'WP' },
  { sprite: 573732443, key: 'blip_ammo_arrow', label: 'Ammo Arrow', marker: 'AA' },
  { sprite: 1445158214, key: 'blip_ammo_bullets', label: 'Ammo Bullets', marker: 'AB' },
  { sprite: -1646261997, key: 'blip_animal', label: 'Animal', marker: 'AN' },
  { sprite: 218395012, key: 'blip_animal_skin', label: 'Animal Skin', marker: 'SK' },
  { sprite: -774688241, key: 'blip_attention', label: 'Attention', marker: 'AT' },
  { sprite: 1869246576, key: 'blip_bank_debt', label: 'Bank Debt', marker: 'BD' },
  { sprite: -304640465, key: 'blip_bath_house', label: 'Bath House', marker: 'BA' },
  { sprite: 327180499, key: 'blip_camp', label: 'Camp', marker: 'CA' },
  { sprite: -1043855483, key: 'blip_camp_request', label: 'Camp Request', marker: 'RQ' },
  { sprite: -910004446, key: 'blip_camp_tent', label: 'Camp Tent', marker: 'CT' },
  { sprite: 1754365229, key: 'blip_campfire', label: 'Campfire', marker: 'CF' },
  { sprite: 773587962, key: 'blip_campfire_full', label: 'Campfire Full', marker: 'C+' },
  { sprite: 62421675, key: 'blip_canoe', label: 'Canoe', marker: 'CN' },
  { sprite: 688589278, key: 'blip_cash_bag', label: 'Cash Bag', marker: 'CB' },
  { sprite: -1138864184, key: 'blip_chest', label: 'Chest', marker: 'CS' },
  { sprite: 960467426, key: 'blip_code_waypoint', label: 'Waypoint', marker: 'WY' },
  { sprite: 1754506823, key: 'blip_deadeye_cross', label: 'Deadeye', marker: 'DX' },
  { sprite: 456887900, key: 'blip_destroy', label: 'Destroy', marker: 'DS' },
  { sprite: 51988200, key: 'blip_direction_pointer', label: 'Direction', marker: 'DR' },
  { sprite: -1236018085, key: 'blip_donate_food', label: 'Donate Food', marker: 'DF' },
  { sprite: 1904459580, key: 'blip_event_appleseed', label: 'Event Appleseed', marker: 'EA' },
  { sprite: -1989725258, key: 'blip_event_castor', label: 'Event Castor', marker: 'EC' },
  { sprite: -487631996, key: 'blip_event_railroad_camp', label: 'Railroad Camp', marker: 'RC' },
  { sprite: -1944395098, key: 'blip_event_riggs_camp', label: 'Riggs Camp', marker: 'RG' },
  { sprite: -1383036426, key: 'blip_for_sale', label: 'For Sale', marker: 'FS' },
  { sprite: -1179229323, key: 'blip_fence_building', label: 'Fence', marker: 'FN' },
  { sprite: 571063529, key: 'blip_gang_savings', label: 'Gang Savings', marker: 'GS' },
  { sprite: 1350383321, key: 'blip_gang_savings_special', label: 'Gang Savings+', marker: 'G+' },
  { sprite: 935247438, key: 'blip_grub', label: 'Grub', marker: 'GB' },
  { sprite: 990667866, key: 'blip_hat', label: 'Hat', marker: 'HT' },
  { sprite: -1715189579, key: 'blip_horse_owned', label: 'Owned Horse', marker: 'OH' },
  { sprite: 1210165179, key: 'blip_horse_owned_active', label: 'Horse Active', marker: 'OA' },
  { sprite: 28148096, key: 'blip_ambient_bounty_hunter_lower', label: 'Bounty Low', marker: 'B-' },
  { sprite: 54149631, key: 'blip_ambient_companion_higher', label: 'Companion High', marker: 'C+' },
  { sprite: -1971029474, key: 'blip_ambient_companion_lower', label: 'Companion Low', marker: 'C-' },
  { sprite: -1979146842, key: 'blip_ambient_herd_straggler', label: 'Herd Straggler', marker: 'SR' },
  { sprite: -920572370, key: 'blip_ambient_higher', label: 'Ambient High', marker: 'AH' },
  { sprite: -1843639063, key: 'blip_ambient_lower', label: 'Ambient Low', marker: 'AL' },
  { sprite: 419258445, key: 'blip_ambient_new', label: 'Ambient New', marker: 'NW' },
  { sprite: 978474677, key: 'blip_ambient_npc_higher', label: 'NPC High', marker: 'N+' },
  { sprite: -67528377, key: 'blip_ambient_npc_lower', label: 'NPC Low', marker: 'N-' },
  { sprite: 1453767378, key: 'blip_ambient_ped_downed', label: 'Downed Ped', marker: 'PD' },
  { sprite: -1350763423, key: 'blip_ambient_ped_medium', label: 'Ped Medium', marker: 'PM' },
  { sprite: 1386031480, key: 'blip_ambient_ped_medium_higher', label: 'Ped Medium+', marker: 'P+' },
  { sprite: 1995891146, key: 'blip_ambient_ped_medium_lower', label: 'Ped Medium-', marker: 'P-' },
  { sprite: 692310, key: 'blip_ambient_ped_small', label: 'Ped Small', marker: 'PS' },
  { sprite: 195811413, key: 'blip_ambient_ped_small_higher', label: 'Ped Small+', marker: 'S+' },
  { sprite: 511626456, key: 'blip_ambient_ped_small_lower', label: 'Ped Small-', marker: 'S-' },
  { sprite: 675509286, key: 'blip_ambient_secret', label: 'Secret', marker: 'SC' },
  { sprite: -1954662204, key: 'blip_ambient_tithing', label: 'Tithing', marker: 'TT' },
  { sprite: 1340161527, key: 'blip_animal_dead', label: 'Animal Dead', marker: 'AD' },
  { sprite: 1996684768, key: 'blip_animal_quality_01', label: 'Animal Quality 1', marker: 'Q1' },
  { sprite: -171082889, key: 'blip_animal_quality_02', label: 'Animal Quality 2', marker: 'Q2' },
  { sprite: -480291173, key: 'blip_animal_quality_03', label: 'Animal Quality 3', marker: 'Q3' },
  { sprite: 1173759417, key: 'blip_app_connected', label: 'App Connected', marker: 'AP' },
  { sprite: 1420154945, key: 'blip_cash_arthur', label: 'Cash Arthur', marker: 'AR' },
  { sprite: -758439257, key: 'blip_code_center', label: 'Code Center', marker: 'CC' },
  { sprite: 648067515, key: 'blip_code_center_on_horse', label: 'Code Horse', marker: 'CH' },
  { sprite: 600220762, key: 'blip_horse_higher', label: 'Horse High', marker: 'H+' },
  { sprite: 2131881492, key: 'blip_horse_lower', label: 'Horse Low', marker: 'H-' },
  { sprite: -217389439, key: 'blip_horse_owned_bonding_0', label: 'Bonding 0', marker: 'B0' },
  { sprite: 13992470, key: 'blip_horse_owned_bonding_1', label: 'Bonding 1', marker: 'B1' },
  { sprite: 396341162, key: 'blip_horse_owned_bonding_2', label: 'Bonding 2', marker: 'B2' },
  { sprite: 623069873, key: 'blip_horse_owned_bonding_3', label: 'Bonding 3', marker: 'B3' },
  { sprite: -637422489, key: 'blip_horse_owned_bonding_4', label: 'Bonding 4', marker: 'B4' },
  { sprite: -44909892, key: 'blip_horse_owned_hitched', label: 'Owned Hitched', marker: 'HT' },
  { sprite: -641397381, key: 'blip_horse_temp', label: 'Temp Horse', marker: 'TH' },
  { sprite: 937553910, key: 'blip_horse_temp_bonding_0', label: 'Temp Bond 0', marker: 'T0' },
  { sprite: 489732756, key: 'blip_horse_temp_bonding_1', label: 'Temp Bond 1', marker: 'T1' },
  { sprite: 195204984, key: 'blip_horse_temp_bonding_2', label: 'Temp Bond 2', marker: 'T2' },
  { sprite: -103418913, key: 'blip_horse_temp_bonding_3', label: 'Temp Bond 3', marker: 'T3' },
  { sprite: -815685893, key: 'blip_horse_temp_bonding_4', label: 'Temp Bond 4', marker: 'T4' },
  { sprite: 444737100, key: 'blip_horse_temp_hitched', label: 'Temp Hitched', marker: 'TI' },
  { sprite: 1887082874, key: 'blip_horseshoe_0', label: 'Horseshoe 0', marker: 'S0' },
  { sprite: 2100933368, key: 'blip_horseshoe_1', label: 'Horseshoe 1', marker: 'S1' },
  { sprite: 1166328735, key: 'blip_horseshoe_2', label: 'Horseshoe 2', marker: 'S2' },
  { sprite: 1463641872, key: 'blip_horseshoe_3', label: 'Horseshoe 3', marker: 'S3' },
  { sprite: 687278724, key: 'blip_horseshoe_4', label: 'Horseshoe 4', marker: 'S4' },
  { sprite: -211556852, key: 'blip_hotel_bed', label: 'Hotel Bed', marker: 'HB' },
  { sprite: -986795390, key: 'blip_job', label: 'Job', marker: 'JB' },
  { sprite: -902701436, key: 'blip_location_higher', label: 'Location High', marker: 'L+' },
  { sprite: -432067112, key: 'blip_location_lower', label: 'Location Low', marker: 'L-' },
  { sprite: 1255312268, key: 'blip_locked', label: 'Locked', marker: 'LK' },
  { sprite: 595820042, key: 'blip_mg_blackjack', label: 'Blackjack', marker: 'BJ' },
  { sprite: -1650465405, key: 'blip_mg_dominoes', label: 'Dominoes', marker: 'DM' },
  { sprite: -1581061148, key: 'blip_mg_dominoes_all3s', label: 'Dominoes All 3s', marker: 'D3' },
  { sprite: -48718882, key: 'blip_mg_dominoes_all5s', label: 'Dominoes All 5s', marker: 'D5' },
  { sprite: -379108622, key: 'blip_mg_dominoes_draw', label: 'Dominoes Draw', marker: 'DD' },
  { sprite: 1242464081, key: 'blip_mg_drinking', label: 'Drinking', marker: 'DK' },
  { sprite: -1575595762, key: 'blip_mg_fishing', label: 'Fishing', marker: 'FI' },
  { sprite: 1974815632, key: 'blip_mg_five_finger_fillet', label: 'Five Finger', marker: 'FF' },
  { sprite: 1015604260, key: 'blip_mg_five_finger_fillet_burnout', label: 'Fillet Burnout', marker: 'FB' },
  { sprite: 126262516, key: 'blip_mg_five_finger_fillet_guts', label: 'Fillet Guts', marker: 'FG' },
  { sprite: 1243830185, key: 'blip_mg_poker', label: 'Poker', marker: 'PK' },
  { sprite: 1109348405, key: 'blip_mp_pickup', label: 'Pickup', marker: 'PU' },
  { sprite: 2031478856, key: 'blip_npc_search', label: 'NPC Search', marker: 'NS' },
  { sprite: -570710357, key: 'blip_objective', label: 'Objective', marker: 'OB' },
  { sprite: 1192138201, key: 'blip_objective_minor', label: 'Objective Minor', marker: 'OM' },
];

for (const option of BLIP_ICON_OPTIONS) {
  option.image = `https://abdulkadiraktas.github.io/rdr3_discoveries/useful_info_from_rpfs/textures/blips/images/blips/${option.key}.png`;
}
BLIP_ICON_OPTIONS.sort((a, b) => String(a.label).localeCompare(String(b.label)));

const PERMISSION_CATALOG = [
  { key: 'employee.storage', icon: 'ST', label: 'Storage' },
  { key: 'employee.store', icon: 'SH', label: 'Store Access' },
  { key: 'employee.invoice.create', icon: 'IN', label: 'Create Invoice' },
  { key: 'boss.employee.hire', icon: 'HI', label: 'Hire' },
  { key: 'boss.employee.fire', icon: 'FI', label: 'Fire' },
  { key: 'boss.employee.promote', icon: 'PR', label: 'Promote' },
  { key: 'boss.ranks.manage', icon: 'RK', label: 'Manage Ranks' },
  { key: 'boss.payroll.manage', icon: 'PY', label: 'Manage Payroll' },
  { key: 'boss.ledger.withdraw', icon: 'WD', label: 'Ledger Withdraw' },
  { key: 'boss.ledger.deposit', icon: 'DP', label: 'Ledger Deposit' },
  { key: 'boss.store.manage', icon: 'SM', label: 'Manage Stores' },
  { key: 'boss.blip.manage', icon: 'BL', label: 'Manage Blips' },
  { key: 'boss.advert.manage', icon: 'AD', label: 'Manage Ads' },
  { key: 'boss.storage.manage', icon: 'SG', label: 'Manage Storage' },
  { key: 'boss.theme.manage', icon: 'TH', label: 'Manage Theme' },
  { key: 'boss.discord.manage', icon: 'DC', label: 'Manage Discord' },
];

const DISCORD_WEBHOOK_CHANNELS = [
  { key: 'admin', label: 'Admin' },
  { key: 'boss', label: 'Boss Updates' },
  { key: 'billing', label: 'Billing' },
  { key: 'payroll', label: 'Payroll' },
  { key: 'stores', label: 'Stores' },
  { key: 'adverts', label: 'Advertisements' },
  { key: 'blips', label: 'Blips' },
  { key: 'employees', label: 'Employees' },
  { key: 'ranks', label: 'Ranks' },
  { key: 'ledger', label: 'Ledger' },
  { key: 'audit', label: 'Audit' },
  { key: 'taxes', label: 'Taxes' },
  { key: 'security', label: 'Security' },
  { key: 'crafting', label: 'Crafting' },
];

const tabConfig = [
  { id: 'overview', label: 'Overview' },
  { id: 'jobcenter', label: 'Public Board' },
  { id: 'employees', label: 'Employees' },
  { id: 'ranks', label: 'Ranks' },
  { id: 'stores', label: 'Stores' },
  { id: 'blips', label: 'Blips' },
  { id: 'discord', label: 'Discord' },
  { id: 'theme', label: 'Theme' },
  { id: 'bills', label: 'Bills' },
  { id: 'admin', label: 'Admin' },
];

function postNui(name, payload = {}) {
  return fetch(`https://${GetParentResourceName()}/${name}`, {
    method: 'POST',
    headers: { 'Content-Type': 'application/json; charset=UTF-8' },
    body: JSON.stringify(payload),
  }).then((r) => r.json()).catch(() => ({ success: false }));
}

function toast(message, kind = 'info') {
  const el = document.createElement('div');
  el.className = `toast ${kind}`;
  el.textContent = String(message || '');
  toastRoot.appendChild(el);
  setTimeout(() => el.remove(), 3500);
}

function formatTime(value) {
  if (value === null || value === undefined || value === '') return '-';

  const date = parseDateValue(value);
  if (!(date instanceof Date) || Number.isNaN(date.getTime())) {
    return '-';
  }

  return date.toLocaleTimeString('en-US', {
    hour: 'numeric',
    minute: '2-digit',
    hour12: true,
  });
}

function parseDateValue(value) {
  let date = null;
  if (typeof value === 'number') {
    const ms = value > 1e12 ? value : value * 1000;
    date = new Date(ms);
  } else if (typeof value === 'string') {
    const numeric = Number(value);
    if (!Number.isNaN(numeric) && value.trim() !== '') {
      const ms = numeric > 1e12 ? numeric : numeric * 1000;
      date = new Date(ms);
    } else {
      date = new Date(value);
    }
  } else if (value instanceof Date) {
    date = value;
  }

  return date;
}

function formatDateTime(value) {
  if (value === null || value === undefined || value === '') return '-';
  const date = parseDateValue(value);
  if (!(date instanceof Date) || Number.isNaN(date.getTime())) {
    return '-';
  }
  const datePart = date.toLocaleDateString('en-US', {
    month: 'short',
    day: 'numeric',
    year: 'numeric',
  });
  const timePart = date.toLocaleTimeString('en-US', {
    hour: 'numeric',
    minute: '2-digit',
    hour12: true,
  });
  return `${datePart} ${timePart}`;
}

function formatActionLabel(value) {
  const raw = String(value || '').trim();
  if (!raw) return '-';
  return raw
    .replace(/[._-]+/g, ' ')
    .replace(/\s+/g, ' ')
    .replace(/\b\w/g, (m) => m.toUpperCase());
}

function formatCurrency(value) {
  const n = Number(value || 0);
  if (!Number.isFinite(n)) return '$0';
  const rounded = Math.round(n * 100) / 100;
  const hasCents = Math.abs(rounded - Math.round(rounded)) > 0.001;
  return `$${rounded.toLocaleString('en-US', {
    minimumFractionDigits: hasCents ? 2 : 0,
    maximumFractionDigits: 2,
  })}`;
}

function normalizeMoneyInput(value) {
  const n = Number(value || 0);
  if (!Number.isFinite(n) || n <= 0) return 0;
  return Math.round(n * 100) / 100;
}

function normalizeHexColor(value, fallback) {
  const raw = String(value || '').trim();
  if (/^#[0-9a-fA-F]{6}$/.test(raw)) {
    return raw;
  }
  return fallback;
}

function normalizeTheme(theme) {
  const incoming = theme && typeof theme === 'object' ? theme : {};
  const icon = String(incoming.icon || DEFAULT_THEME.icon).trim().toLowerCase();
  return {
    primary: normalizeHexColor(incoming.primary, DEFAULT_THEME.primary),
    secondary: normalizeHexColor(incoming.secondary, DEFAULT_THEME.secondary),
    surface: normalizeHexColor(incoming.surface, DEFAULT_THEME.surface),
    surface2: normalizeHexColor(incoming.surface2, DEFAULT_THEME.surface2),
    card: normalizeHexColor(incoming.card, DEFAULT_THEME.card),
    text: normalizeHexColor(incoming.text, DEFAULT_THEME.text),
    muted: normalizeHexColor(incoming.muted, DEFAULT_THEME.muted),
    icon: THEME_ICON_VALUES.has(icon) ? icon : DEFAULT_THEME.icon,
  };
}

function buildThemeIconSvg(iconKey) {
  const stroke = '#fff7e7';
  const fill = 'none';
  const key = String(iconKey || 'star');
  if (key === 'eagle') {
    return `<svg viewBox="0 0 24 24" aria-hidden="true"><path d="M3 14 L9 10 L12 12 L15 10 L21 14 L15 14 L12 17 L9 14 Z" fill="${stroke}"/></svg>`;
  }
  if (key === 'shield') {
    return `<svg viewBox="0 0 24 24" aria-hidden="true"><path d="M12 3 L19 6 V11 C19 15 16 18 12 21 C8 18 5 15 5 11 V6 Z" fill="${fill}" stroke="${stroke}" stroke-width="2"/></svg>`;
  }
  if (key === 'coins') {
    return `<svg viewBox="0 0 24 24" aria-hidden="true"><ellipse cx="10" cy="9" rx="5" ry="2.5" fill="${fill}" stroke="${stroke}" stroke-width="2"/><ellipse cx="14" cy="15" rx="5" ry="2.5" fill="${fill}" stroke="${stroke}" stroke-width="2"/></svg>`;
  }
  if (key === 'store') {
    return `<svg viewBox="0 0 24 24" aria-hidden="true"><path d="M4 10 H20 V20 H4 Z" fill="${fill}" stroke="${stroke}" stroke-width="2"/><path d="M3 10 L5 6 H19 L21 10 Z" fill="${fill}" stroke="${stroke}" stroke-width="2"/></svg>`;
  }
  if (key === 'wrench') {
    return `<svg viewBox="0 0 24 24" aria-hidden="true"><path d="M14 4 A4 4 0 0 0 18 8 L11 15 L9 13 L16 6 A4 4 0 0 0 14 4 Z M7 15 L4 18 L6 20 L9 17 Z" fill="${stroke}"/></svg>`;
  }
  if (key === 'horse') {
    return `<svg viewBox="0 0 24 24" aria-hidden="true"><path d="M7 6 L11 4 L15 6 L17 10 L16 14 L12 18 L8 16 L6 12 Z" fill="${fill}" stroke="${stroke}" stroke-width="2"/></svg>`;
  }
  if (key === 'scales') {
    return `<svg viewBox="0 0 24 24" aria-hidden="true"><path d="M12 4 V18 M8 8 H16 M6 8 L4 12 H8 Z M18 8 L16 12 H20 Z" fill="${fill}" stroke="${stroke}" stroke-width="2"/></svg>`;
  }
  if (key === 'hammer') {
    return `<svg viewBox="0 0 24 24" aria-hidden="true"><path d="M5 7 H13 V10 H10 L18 18 L16 20 L8 12 V15 H5 Z" fill="${stroke}"/></svg>`;
  }
  if (key === 'lamp') {
    return `<svg viewBox="0 0 24 24" aria-hidden="true"><path d="M10 3 H14 L13 7 H11 Z M8 9 H16 V13 C16 16 14 18 12 18 C10 18 8 16 8 13 Z M9 20 H15" fill="${fill}" stroke="${stroke}" stroke-width="2"/></svg>`;
  }
  if (key === 'gear') {
    return `<svg viewBox="0 0 24 24" aria-hidden="true"><path d="M12 8 A4 4 0 1 0 12 16 A4 4 0 1 0 12 8 Z M12 3 V6 M12 18 V21 M3 12 H6 M18 12 H21 M5.2 5.2 L7.4 7.4 M16.6 16.6 L18.8 18.8 M18.8 5.2 L16.6 7.4 M7.4 16.6 L5.2 18.8" fill="${fill}" stroke="${stroke}" stroke-width="2"/></svg>`;
  }
  if (key === 'wheat') {
    return `<svg viewBox="0 0 24 24" aria-hidden="true"><path d="M12 20 V5 M12 8 L9 6 M12 10 L15 8 M12 12 L9 10 M12 14 L15 12 M12 16 L9 14 M12 18 L15 16" fill="${fill}" stroke="${stroke}" stroke-width="2"/></svg>`;
  }
  return `<svg viewBox="0 0 24 24" aria-hidden="true"><path d="M12 3 L14.6 8.2 L20.3 9 L16.1 13.1 L17.1 18.8 L12 16.1 L6.9 18.8 L7.9 13.1 L3.7 9 L9.4 8.2 Z" fill="${stroke}"/></svg>`;
}

function setThemeBadge(el, iconKey) {
  if (!el) return;
  const normalized = THEME_ICON_VALUES.has(String(iconKey || '').toLowerCase()) ? String(iconKey).toLowerCase() : DEFAULT_THEME.icon;
  el.innerHTML = buildThemeIconSvg(normalized);
  el.title = normalized;
}

function applyThemeToUi(themeLike) {
  const theme = normalizeTheme(themeLike);
  const rootStyle = document.documentElement.style;
  rootStyle.setProperty('--brass-500', theme.primary);
  rootStyle.setProperty('--brass-700', theme.secondary);
  rootStyle.setProperty('--ui-surface', theme.surface);
  rootStyle.setProperty('--ui-surface-2', theme.surface2);
  rootStyle.setProperty('--ui-card', theme.card);
  rootStyle.setProperty('--ink-900', theme.text);
  rootStyle.setProperty('--ink-700', theme.muted);

  const primaryInput = document.getElementById('theme-primary');
  const secondaryInput = document.getElementById('theme-secondary');
  const surfaceInput = document.getElementById('theme-surface');
  const surface2Input = document.getElementById('theme-surface-2');
  const cardInput = document.getElementById('theme-card');
  const textInput = document.getElementById('theme-text');
  const mutedInput = document.getElementById('theme-muted');
  const iconInput = document.getElementById('theme-icon');
  if (primaryInput && primaryInput.value !== theme.primary) primaryInput.value = theme.primary;
  if (secondaryInput && secondaryInput.value !== theme.secondary) secondaryInput.value = theme.secondary;
  if (surfaceInput && surfaceInput.value !== theme.surface) surfaceInput.value = theme.surface;
  if (surface2Input && surface2Input.value !== theme.surface2) surface2Input.value = theme.surface2;
  if (cardInput && cardInput.value !== theme.card) cardInput.value = theme.card;
  if (textInput && textInput.value !== theme.text) textInput.value = theme.text;
  if (mutedInput && mutedInput.value !== theme.muted) mutedInput.value = theme.muted;
  if (iconInput && iconInput.value !== theme.icon) iconInput.value = theme.icon;

  const iconBadge = document.getElementById('theme-icon-badge');
  const iconPreview = document.getElementById('theme-icon-preview');
  setThemeBadge(iconBadge, theme.icon);
  setThemeBadge(iconPreview, theme.icon);
  renderThemePresetColors();
}

function resolveDisplayItemLabel(entry) {
  const label = String(entry?.label || '').trim();
  const item = String(entry?.item || '').trim();
  if (label && label.toLowerCase() !== item.toLowerCase()) {
    return label;
  }
  if (label) {
    return formatActionLabel(label);
  }
  if (item) {
    return formatActionLabel(item);
  }
  return 'Item';
}

function storefrontFallbackImage(label) {
  const safe = String(label || '?').slice(0, 2).toUpperCase();
  const svg = `<svg xmlns='http://www.w3.org/2000/svg' width='320' height='200' viewBox='0 0 320 200'><rect width='320' height='200' rx='14' fill='#e8d6b8'/><rect x='12' y='12' width='296' height='176' rx='12' fill='#f9f0df'/><circle cx='160' cy='84' r='42' fill='#d8b27b'/><text x='160' y='96' text-anchor='middle' font-size='28' font-family='Rockwell,serif' fill='#3a2a16'>${safe}</text><text x='160' y='158' text-anchor='middle' font-size='13' font-family='Palatino Linotype,serif' fill='#6f4f27'>No Item Image</text></svg>`;
  return `data:image/svg+xml;utf8,${encodeURIComponent(svg)}`;
}

function buildStorefrontImageCandidates(item) {
  const name = String(item?.item || '').trim();
  const metadataImage = item?.image ? String(item.image) : '';
  const list = [];
  const seen = new Set();
  const addCandidate = (url) => {
    const next = String(url || '').trim();
    if (!next || seen.has(next)) return;
    seen.add(next);
    list.push(next);
  };

  if (metadataImage) addCandidate(metadataImage);
  if (!name) return list;

  const lower = name.toLowerCase();
  const upper = name.toUpperCase();
  const strippedWeapon = lower.startsWith('weapon_') ? lower.slice(7) : lower;
  const normalized = strippedWeapon.replace(/_/g, '');
  const variants = [];
  const addVariant = (value) => {
    const v = String(value || '').trim();
    if (!v || variants.includes(v)) return;
    variants.push(v);
  };

  addVariant(name);
  addVariant(lower);
  addVariant(upper);
  addVariant(strippedWeapon);
  addVariant(normalized);

  const roots = [
    'https://cfx-nui-vorp_inventory/html/img/items/',
    'https://cfx-nui-vorp_inventory/html/img/weapons/',
    'https://cfx-nui-rsg-inventory/html/images/items/',
    'https://cfx-nui-rsg-inventory/html/images/weapons/',
    'https://cfx-nui-rsg-inventory/html/images/',
    'https://cfx-nui-rsg-inventory/html/img/items/',
    'https://cfx-nui-rsg-inventory/html/img/weapons/',
    'https://cfx-nui-rsg-inventory-main/html/images/items/',
    'https://cfx-nui-rsg-inventory-main/html/images/weapons/',
    'https://cfx-nui-rsg-inventory-main/html/images/',
    'nui://vorp_inventory/html/img/items/',
    'nui://vorp_inventory/html/img/weapons/',
    'nui://rsg-inventory/html/images/items/',
    'nui://rsg-inventory/html/images/weapons/',
    'nui://rsg-inventory/html/images/',
    'nui://rsg-inventory/html/img/items/',
    'nui://rsg-inventory/html/img/weapons/',
    'nui://rsg-inventory-main/html/images/items/',
    'nui://rsg-inventory-main/html/images/weapons/',
    'nui://rsg-inventory-main/html/images/',
  ];
  const exts = ['png', 'webp', 'jpg', 'jpeg'];

  for (let i = 0; i < roots.length; i += 1) {
    const root = roots[i];
    for (let j = 0; j < variants.length; j += 1) {
      const encoded = encodeURIComponent(variants[j]);
      for (let k = 0; k < exts.length; k += 1) {
        addCandidate(`${root}${encoded}.${exts[k]}`);
      }
    }
  }

  return list;
}

function closeStorefront(localOnly = false) {
  storefrontOpen = false;
  storefrontData = null;
  storefrontSelectedCategory = 'all';
  storefrontMode = 'buy';
  storefrontRoot.classList.add('hidden');
  if (!localOnly) {
    postNui('storefrontClose', {});
  }
}

function closeCrafting(localOnly = false) {
  craftingOpen = false;
  craftingData = null;
  craftingSelectedRecipeId = '';
  craftingBusy = false;
  clearCraftingProgress();
  if (craftingRoot) {
    craftingRoot.classList.add('hidden');
  }
  if (!localOnly) {
    postNui('craftingClose', {});
  }
}

function clearCraftingProgress() {
  if (craftingProgressTimer) {
    clearInterval(craftingProgressTimer);
    craftingProgressTimer = null;
  }
  craftingProgressState = null;
  if (craftingProgressRoot) {
    craftingProgressRoot.classList.add('hidden');
  }
  if (craftingProgressFill) {
    craftingProgressFill.style.width = '0%';
  }
  if (craftingProgressPercent) {
    craftingProgressPercent.textContent = '0%';
  }
}

function updateCraftingProgress() {
  if (!craftingProgressState) return;
  const now = Date.now();
  const elapsed = Math.max(0, now - craftingProgressState.startedAt);
  const duration = Math.max(1, craftingProgressState.durationMs);
  const pct = Math.max(0, Math.min(1, elapsed / duration));
  const percentText = `${Math.floor(pct * 100)}%`;
  if (craftingProgressFill) {
    craftingProgressFill.style.width = `${pct * 100}%`;
  }
  if (craftingProgressPercent) {
    craftingProgressPercent.textContent = percentText;
  }
}

function startCraftingProgress(payload = {}) {
  clearCraftingProgress();
  const durationMs = Math.max(0, Number(payload.durationMs || 0));
  const label = String(payload.label || 'Crafting');
  craftingBusy = true;
  craftingProgressState = {
    token: String(payload.token || ''),
    startedAt: Date.now(),
    durationMs: Math.max(1, durationMs),
  };
  if (craftingProgressTitle) {
    const qty = Math.max(1, Number(payload.quantity || 1));
    craftingProgressTitle.textContent = qty > 1 ? `Crafting ${qty}x ${label}` : `Crafting ${label}`;
  }
  if (craftingProgressRoot) {
    craftingProgressRoot.classList.remove('hidden');
  }
  updateCraftingProgress();
  craftingProgressTimer = setInterval(updateCraftingProgress, 100);
  renderCraftingDetail();
}

function finishCraftingProgress(payload = {}) {
  const incomingToken = String(payload.token || '');
  if (incomingToken && craftingProgressState?.token && incomingToken !== craftingProgressState.token) {
    return;
  }
  if (!incomingToken && payload.success === false && craftingProgressState) {
    craftingBusy = !craftingAllowsMultiple();
    renderCraftingDetail();
    return;
  }
  const success = payload.success !== false;
  if (craftingProgressState && success && craftingProgressFill && craftingProgressPercent) {
    craftingProgressFill.style.width = '100%';
    craftingProgressPercent.textContent = '100%';
  }
  if (craftingProgressTimer) {
    clearInterval(craftingProgressTimer);
    craftingProgressTimer = null;
  }
  craftingProgressState = null;
  craftingBusy = false;
  setTimeout(() => {
    if (!craftingBusy) {
      clearCraftingProgress();
      renderCraftingDetail();
    }
  }, success ? 450 : 0);
}

function formatCraftingDuration(ms) {
  const totalMs = Math.max(0, Number(ms || 0));
  if (!Number.isFinite(totalMs) || totalMs <= 0) return 'Instant';
  const totalSeconds = Math.ceil(totalMs / 1000);
  const minutes = Math.floor(totalSeconds / 60);
  const seconds = totalSeconds % 60;
  if (minutes > 0 && seconds > 0) return `${minutes}m ${seconds}s`;
  if (minutes > 0) return `${minutes}m`;
  return `${seconds}s`;
}

function getCraftingRecipes() {
  if (!craftingData || typeof craftingData !== 'object') return [];
  return Array.isArray(craftingData.recipes) ? craftingData.recipes : [];
}

function getCraftingSelectedRecipe() {
  const recipes = getCraftingRecipes();
  return recipes.find((recipe) => String(recipe?.id || '') === craftingSelectedRecipeId) || recipes[0] || null;
}

function getCraftingQuantity(recipe = null) {
  const raw = Number(craftingQuantityInput?.value || 1);
  const max = Math.max(1, Number(recipe?.maxCount || 50));
  if (!Number.isFinite(raw)) return 1;
  return Math.max(1, Math.min(max, Math.floor(raw)));
}

function setCraftingQuantityBounds(recipe) {
  if (!craftingQuantityInput) return;
  const max = Math.max(1, Number(recipe?.maxCount || 50));
  craftingQuantityInput.min = '1';
  craftingQuantityInput.max = String(max);
  craftingQuantityInput.value = String(getCraftingQuantity(recipe));
}

function getCraftingOutputSummary(recipe, qty) {
  const outputs = Array.isArray(recipe?.outputs) ? recipe.outputs : [];
  if (!outputs.length) return '-';
  return outputs.map((item) => {
    const count = Math.max(1, Number(item?.count ?? item?.amount ?? 1)) * Math.max(1, qty);
    return `${count}x ${String(item?.label || item?.item || 'Item')}`;
  }).join(', ');
}

function getCraftingInputNeed(recipe, input, qty) {
  const base = Math.max(0, Number(input?.count ?? input?.amount ?? 0));
  if (input?.consume === false) {
    return base;
  }
  if (recipe?.scaleInputsWithQuantity === false) {
    return base;
  }
  return base * Math.max(1, qty);
}

function recipeCanCraft(recipe, qty) {
  if (recipe?.enabled === false) return false;
  const inputs = Array.isArray(recipe?.inputs) ? recipe.inputs : [];
  return inputs.every((input) => Number(input?.have || 0) >= getCraftingInputNeed(recipe, input, qty));
}

function craftingAllowsMultiple() {
  return craftingData?.allowMultipleCrafts === true;
}

function makeCraftingImage(item, label, className) {
  const img = document.createElement('img');
  img.className = className;
  img.alt = label;
  const candidates = buildStorefrontImageCandidates({ item, label });
  img.src = candidates[0] || storefrontFallbackImage(label);
  let imageIndex = 1;
  img.onerror = () => {
    if (imageIndex < candidates.length) {
      img.src = candidates[imageIndex];
      imageIndex += 1;
      return;
    }
    img.onerror = null;
    img.src = storefrontFallbackImage(label);
  };
  return img;
}

function renderCraftingList() {
  if (!craftingListRoot) return;
  const recipes = getCraftingRecipes();
  craftingListRoot.innerHTML = '';

  if (!recipes.length) {
    craftingListRoot.innerHTML = '<div class="storefront-empty">No recipes available.</div>';
    return;
  }

  for (const recipe of recipes) {
    const id = String(recipe?.id || '');
    const btn = document.createElement('button');
    btn.type = 'button';
    const unavailable = recipe?.enabled === false;
    btn.className = `crafting-recipe-row ${id === craftingSelectedRecipeId ? 'active' : ''} ${unavailable ? 'unavailable' : ''}`;
    const outputs = getCraftingOutputSummary(recipe, 1);
    btn.innerHTML = `
      <div>
        <div class="crafting-recipe-name">${String(recipe?.label || 'Recipe')}</div>
        <div class="crafting-recipe-meta">${String(recipe?.category || 'General')} &bull; ${formatCraftingDuration(recipe?.timeMs || 0)}</div>
      </div>
      <div class="crafting-recipe-meta">${outputs}</div>
    `;
    btn.addEventListener('click', () => {
      craftingSelectedRecipeId = id;
      if (craftingQuantityInput) craftingQuantityInput.value = '1';
      renderCrafting();
    });
    craftingListRoot.appendChild(btn);
  }
}

function renderCraftingMaterials(rootEl, items, recipe, qty, isInput) {
  if (!rootEl) return;
  rootEl.innerHTML = '';
  if (!items.length) {
    rootEl.innerHTML = `<div class="muted">${isInput ? 'No ingredients required.' : 'No outputs configured.'}</div>`;
    return;
  }

  for (const item of items) {
    const label = String(item?.label || item?.item || 'Item');
    const row = document.createElement('div');
    const need = isInput ? getCraftingInputNeed(recipe, item, qty) : Math.max(1, Number(item?.count ?? item?.amount ?? 1)) * qty;
    const have = Math.max(0, Number(item?.have || 0));
    const missing = isInput && have < need;
    row.className = `crafting-material-row ${missing ? 'missing' : ''}`;
    row.appendChild(makeCraftingImage(String(item?.item || ''), label, 'crafting-material-image'));

    const copy = document.createElement('div');
    copy.innerHTML = `
      <div class="crafting-material-name">${label}</div>
      <div class="crafting-material-meta">${String(item?.item || '')}</div>
    `;
    row.appendChild(copy);

    const count = document.createElement('div');
    count.className = 'crafting-material-count';
    count.textContent = isInput ? `${have}/${need}` : `x${need}`;
    row.appendChild(count);
    rootEl.appendChild(row);
  }
}

function renderCraftingDetail() {
  const recipe = getCraftingSelectedRecipe();
  if (!recipe) {
    if (craftingRecipeTitle) craftingRecipeTitle.textContent = 'No recipes available';
    if (craftingRecipeDescription) craftingRecipeDescription.textContent = 'This job does not have crafting recipes configured.';
    if (craftingIngredientsRoot) craftingIngredientsRoot.innerHTML = '';
    if (craftingOutputsRoot) craftingOutputsRoot.innerHTML = '';
    if (craftingCraftBtn) craftingCraftBtn.disabled = true;
    return;
  }

  const qty = getCraftingQuantity(recipe);
  setCraftingQuantityBounds(recipe);
  const title = String(recipe.label || 'Recipe');
  if (craftingRecipeImage) {
    const imageItem = String(recipe.imageItem || recipe.outputs?.[0]?.item || '');
    const candidates = buildStorefrontImageCandidates({ item: imageItem, label: title });
    craftingRecipeImage.src = candidates[0] || storefrontFallbackImage(title);
    let imageIndex = 1;
    craftingRecipeImage.onerror = () => {
      if (imageIndex < candidates.length) {
        craftingRecipeImage.src = candidates[imageIndex];
        imageIndex += 1;
        return;
      }
      craftingRecipeImage.onerror = null;
      craftingRecipeImage.src = storefrontFallbackImage(title);
    };
  }
  if (craftingRecipeTitle) craftingRecipeTitle.textContent = title;
  if (craftingRecipeDescription) craftingRecipeDescription.textContent = String(recipe.description || 'Craft this recipe at the society station.');
  if (craftingRecipeTime) craftingRecipeTime.textContent = `Time: ${formatCraftingDuration(Number(recipe.timeMs || 0) * qty)}`;
  if (craftingRecipeOutput) craftingRecipeOutput.textContent = `Output: ${getCraftingOutputSummary(recipe, qty)}`;

  renderCraftingMaterials(craftingIngredientsRoot, Array.isArray(recipe.inputs) ? recipe.inputs : [], recipe, qty, true);
  renderCraftingMaterials(craftingOutputsRoot, Array.isArray(recipe.outputs) ? recipe.outputs : [], recipe, qty, false);

  const blockWhileCrafting = craftingBusy && !craftingAllowsMultiple();
  if (craftingCraftBtn) {
    craftingCraftBtn.disabled = blockWhileCrafting || !recipeCanCraft(recipe, qty);
    craftingCraftBtn.textContent = blockWhileCrafting ? 'Crafting...' : 'Craft';
  }
  if (craftingQuantityInput) {
    craftingQuantityInput.disabled = blockWhileCrafting;
  }
}

function renderCrafting() {
  if (!craftingData) return;
  const recipes = getCraftingRecipes();
  if (!recipes.find((recipe) => String(recipe?.id || '') === craftingSelectedRecipeId)) {
    craftingSelectedRecipeId = String(recipes[0]?.id || '');
  }
  renderCraftingList();
  renderCraftingDetail();
}

function openCrafting(payload) {
  const data = payload && typeof payload === 'object' ? payload : {};
  craftingData = data;
  craftingOpen = true;
  craftingBusy = craftingProgressState !== null;
  const recipes = getCraftingRecipes();
  craftingSelectedRecipeId = String(recipes[0]?.id || '');
  if (craftingTitle) craftingTitle.textContent = String(data.title || 'Crafting');
  if (craftingSubtitle) craftingSubtitle.textContent = String(data.subtitle || 'Select a recipe and craft job goods.');
  if (craftingQuantityInput) craftingQuantityInput.value = '1';
  renderCrafting();
  if (craftingRoot) {
    craftingRoot.classList.remove('hidden');
  }
}

function updateCrafting(payload) {
  const data = payload && typeof payload === 'object' ? payload : {};
  const previousRecipeId = craftingSelectedRecipeId;
  craftingData = data;
  const recipes = getCraftingRecipes();
  if (recipes.find((recipe) => String(recipe?.id || '') === previousRecipeId)) {
    craftingSelectedRecipeId = previousRecipeId;
  } else {
    craftingSelectedRecipeId = String(recipes[0]?.id || '');
  }
  if (craftingTitle) craftingTitle.textContent = String(data.title || 'Crafting');
  if (craftingSubtitle) craftingSubtitle.textContent = String(data.subtitle || 'Select a recipe and craft job goods.');
  renderCrafting();
}

function closeAdvert(localOnly = false) {
  advertOpen = false;
  advertRoot.classList.add('hidden');
  if (advertImageEl) {
    advertImageEl.src = '';
  }
  if (advertFallbackEl) {
    advertFallbackEl.classList.add('hidden');
  }
  if (advertCaptionEl) {
    advertCaptionEl.textContent = '';
    advertCaptionEl.classList.add('hidden');
  }
  if (!localOnly) {
    postNui('advertClose', {});
  }
}

function openAdvert(payload) {
  const data = payload && typeof payload === 'object' ? payload : {};
  advertOpen = true;
  document.getElementById('advert-title').textContent = String(data.title || 'Advertisement');
  const description = String(data.description || '').trim();
  if (advertCaptionEl) {
    advertCaptionEl.textContent = description;
    advertCaptionEl.classList.toggle('hidden', !description);
  }

  const imageUrl = String(data.imageUrl || '').trim();
  if (!advertImageEl) return;
  advertFallbackEl.classList.add('hidden');
  advertImageEl.loading = 'eager';
  advertImageEl.decoding = 'async';
  advertImageEl.referrerPolicy = 'no-referrer';
  advertImageEl.onerror = () => {
    advertImageEl.onerror = null;
    advertFallbackEl.classList.remove('hidden');
  };
  advertImageEl.onload = () => {
    advertFallbackEl.classList.add('hidden');
  };
  advertImageEl.src = imageUrl || '';

  advertRoot.classList.remove('hidden');
}

function closeBillsWindow(localOnly = false) {
  billsWindowOpen = false;
  if (billsRoot) {
    billsRoot.classList.add('hidden');
  }
  if (!localOnly) {
    postNui('billsClose', {});
  }
}

function renderBillsWindow(list = []) {
  if (!billsList) return;
  billsList.innerHTML = '';
  if (!list.length) {
    billsList.innerHTML = '<div class="muted">No bills due right now.</div>';
    return;
  }

  for (const row of list) {
    const invoiceId = Number(row.id || 0);
    const status = String(row.status || '').toLowerCase();
    const open = status === 'open';

    const card = document.createElement('div');
    card.className = 'bill-row';

    const main = document.createElement('div');
    main.className = 'bill-main';
    const reason = String(row.reason || 'Invoice');
    const society = String(row.society_label || '').trim() || getSocietyLabel(row.society_id);
    main.innerHTML = `
      <div class="bill-title">#${invoiceId} ${reason}</div>
      <div class="bill-meta">${society} • ${formatTime(row.created_at)} • ${formatActionLabel(status || 'open')}</div>
    `;

    const amount = document.createElement('strong');
    amount.textContent = formatCurrency(row.amount || 0);

    const payBtn = document.createElement('button');
    payBtn.className = `btn ${open ? '' : 'btn-danger'}`;
    payBtn.textContent = open ? 'Pay' : 'Settled';
    payBtn.disabled = !open || invoiceId <= 0;
    payBtn.addEventListener('click', () => {
      if (!open || invoiceId <= 0) return;
      postNui('billsPay', { invoiceId });
    });

    card.appendChild(main);
    card.appendChild(amount);
    card.appendChild(payBtn);
    billsList.appendChild(card);
  }
}

function openBillsWindow(invoices = []) {
  if (invoiceWindowOpen) {
    closeInvoiceWindow(true);
  }
  billsWindowOpen = true;
  renderBillsWindow(Array.isArray(invoices) ? invoices : []);
  if (billsRoot) {
    billsRoot.classList.remove('hidden');
  }
}

function closeInvoiceWindow(localOnly = false) {
  invoiceWindowOpen = false;
  if (invoiceRoot) {
    invoiceRoot.classList.add('hidden');
  }
  if (!localOnly) {
    postNui('invoiceWindowClose', {});
  }
}

function closeJobOffer(localOnly = false) {
  const offerId = String(jobOfferState.offerId || '');
  jobOfferOpen = false;
  jobOfferState = { offerId: '' };
  if (jobOfferRoot) {
    jobOfferRoot.classList.add('hidden');
  }
  if (!localOnly && offerId) {
    postNui('jobOfferRespond', { offerId, accept: false });
  }
}

function renderInvoicePlayers(players = []) {
  if (invoicePlayerSelect) {
    const prev = String(invoicePlayerSelect.value || '');
    invoicePlayerSelect.innerHTML = '';
    const empty = document.createElement('option');
    empty.value = '';
    empty.textContent = players.length > 0 ? 'Choose nearby player' : 'No nearby players';
    invoicePlayerSelect.appendChild(empty);

    for (const p of players) {
      const id = String(p.char_id ?? p.charId ?? '');
      if (!id || id === String(state.myCharId || '')) continue;
      const name = String(p.player_name || p.name || p.label || `Character ${id}`).trim();
      const opt = document.createElement('option');
      opt.value = id;
      opt.textContent = name || `Character ${id}`;
      invoicePlayerSelect.appendChild(opt);
    }

    if (prev && Array.from(invoicePlayerSelect.options).some((x) => String(x.value) === prev)) {
      invoicePlayerSelect.value = prev;
    }
  }

}

function openInvoiceWindow(payload = {}) {
  if (billsWindowOpen) {
    closeBillsWindow(true);
  }
  invoiceWindowOpen = true;
  invoiceWindowState = {
    societyId: String(payload.societyId || ''),
    societyLabel: String(payload.societyLabel || 'Society'),
    players: Array.isArray(payload.players) ? payload.players : [],
  };
  const label = document.getElementById('invoice-society-label');
  if (label) {
    label.textContent = `${invoiceWindowState.societyLabel}: choose a nearby player and send a bill.`;
  }
  renderInvoicePlayers(invoiceWindowState.players);
  if (invoiceRoot) {
    invoiceRoot.classList.remove('hidden');
  }
}

function updateInvoiceWindow(payload = {}) {
  invoiceWindowState.societyId = String(payload.societyId || invoiceWindowState.societyId || '');
  invoiceWindowState.societyLabel = String(payload.societyLabel || invoiceWindowState.societyLabel || 'Society');
  invoiceWindowState.players = Array.isArray(payload.players) ? payload.players : [];
  const label = document.getElementById('invoice-society-label');
  if (label) {
    label.textContent = `${invoiceWindowState.societyLabel}: choose a nearby player and send a bill.`;
  }
  renderInvoicePlayers(invoiceWindowState.players);
}

function openJobOffer(payload = {}) {
  jobOfferState = {
    offerId: String(payload.offerId || ''),
  };
  jobOfferOpen = true;
  if (jobOfferRoot) {
    jobOfferRoot.classList.remove('hidden');
  }
  const societyEl = document.getElementById('job-offer-society');
  const roleEl = document.getElementById('job-offer-role');
  const actorEl = document.getElementById('job-offer-actor');
  if (societyEl) societyEl.textContent = String(payload.societyLabel || payload.societyId || '-');
  if (roleEl) roleEl.textContent = `Grade ${Number(payload.rankIndex || 0)}${payload.isBoss === true ? ' (Boss)' : ''}`;
  if (actorEl) actorEl.textContent = String(payload.offeredByName || 'Unknown');
}

function renderStorefrontItemCard(item, mode) {
  const card = document.createElement('article');
  card.className = 'storefront-item';

  const title = String(item?.label || item?.item || 'Item');
  const candidates = buildStorefrontImageCandidates(item);
  const img = document.createElement('img');
  img.className = 'storefront-item-image';
  img.alt = title;
  img.src = candidates[0] || storefrontFallbackImage(title);
  let imageIndex = 1;
  img.onerror = () => {
    if (imageIndex < candidates.length) {
      img.src = candidates[imageIndex];
      imageIndex += 1;
      return;
    }
    img.onerror = null;
    img.src = storefrontFallbackImage(title);
  };

  const name = document.createElement('div');
  name.className = 'storefront-item-title';
  name.textContent = title;

  const meta = document.createElement('div');
  meta.className = 'storefront-item-meta';
  if (mode === 'sell') {
    const owned = Math.max(0, Number(item?.ownedQty || 0));
    const maxText = Number(item?.maxQty || 0) > 0 ? Number(item?.maxQty || 0) : 'No Limit';
    meta.innerHTML = `<span>${String(item?.category || 'General')}</span><span>Society Pays ${formatCurrency(item?.price || 0)}</span><span>You Have: ${owned}</span><span>Max/Txn: ${maxText}</span>`;
  } else {
    meta.innerHTML = `<span>${String(item?.category || 'General')}</span><span>${formatCurrency(item?.price || 0)}</span><span>Stock: ${Number(item?.qty || 0)}</span>`;
  }

  const qtyWrap = document.createElement('div');
  qtyWrap.className = 'storefront-item-buy';
  const qtyInput = document.createElement('input');
  qtyInput.type = 'number';
  qtyInput.min = '1';
  const available = mode === 'sell'
    ? Math.max(0, Number(item?.ownedQty || 0))
    : Math.max(0, Number(item?.qty || 0));
  const maxTxn = mode === 'sell' ? Math.max(0, Number(item?.maxQty || 0)) : 0;
  const maxAllowed = mode === 'sell'
    ? (maxTxn > 0 ? Math.max(0, Math.min(maxTxn, available)) : available)
    : available;
  qtyInput.max = String(Math.max(1, maxAllowed));
  qtyInput.value = '1';
  const buyBtn = document.createElement('button');
  buyBtn.className = 'btn';
  buyBtn.textContent = mode === 'sell' ? 'Sell' : 'Buy';
  if (maxAllowed <= 0) {
    buyBtn.disabled = true;
    qtyInput.disabled = true;
  }
  buyBtn.addEventListener('click', () => {
    if (!storefrontData || !storefrontOpen) return;
    const qty = Math.max(1, Math.min(Math.max(1, maxAllowed), Number(qtyInput.value || 1)));
    if (mode === 'sell') {
      request('storefront.sell', {
        societyId: storefrontData.societyId,
        storeId: storefrontData.storeId,
        itemName: String(item?.item || ''),
        qty,
      });
    } else {
      request('storefront.buy', {
        societyId: storefrontData.societyId,
        storeId: storefrontData.storeId,
        itemName: String(item?.item || ''),
        qty,
      });
    }
  });
  qtyWrap.appendChild(qtyInput);
  qtyWrap.appendChild(buyBtn);

  card.appendChild(img);
  card.appendChild(name);
  card.appendChild(meta);
  card.appendChild(qtyWrap);
  return card;
}

function getStorefrontCategories(items = []) {
  const out = new Set(['all']);
  for (const item of items) {
    const category = String(item?.category || 'General').trim();
    if (category) out.add(category);
  }
  return Array.from(out);
}

function getStorefrontItemsByMode(mode) {
  if (!storefrontData || typeof storefrontData !== 'object') return [];
  if (mode === 'sell') {
    return Array.isArray(storefrontData.buyItems) ? storefrontData.buyItems : [];
  }
  return Array.isArray(storefrontData.items) ? storefrontData.items : [];
}

function getStorefrontModeOptions() {
  if (!storefrontData || typeof storefrontData !== 'object') return [];
  const canBuy = Array.isArray(storefrontData.items) && storefrontData.items.length > 0;
  const canSell = storefrontData.buyEnabled === true
    && Array.isArray(storefrontData.buyItems)
    && storefrontData.buyItems.length > 0;

  const options = [];
  if (canBuy) options.push({ key: 'buy', label: 'Buy From Store' });
  if (canSell) options.push({ key: 'sell', label: 'Sell To Society' });
  return options;
}

function renderStorefrontModeToggle() {
  const root = document.getElementById('storefront-mode-toggle');
  if (!root || !storefrontData) return;
  root.innerHTML = '';

  const options = getStorefrontModeOptions();
  root.classList.toggle('hidden', options.length === 0);
  if (!options.length) {
    return;
  }

  if (!options.find((o) => o.key === storefrontMode)) {
    storefrontMode = options[0].key;
  }

  for (const option of options) {
    const btn = document.createElement('button');
    btn.type = 'button';
    btn.className = `storefront-category-btn ${storefrontMode === option.key ? 'active' : ''}`;
    btn.textContent = option.label;
    btn.addEventListener('click', () => {
      storefrontMode = option.key;
      storefrontSelectedCategory = 'all';
      renderStorefront();
    });
    root.appendChild(btn);
  }
}

function renderStorefront() {
  if (!storefrontData || !storefrontCategoriesRoot || !storefrontList) return;
  const options = getStorefrontModeOptions();
  renderStorefrontModeToggle();
  if (!options.length) {
    storefrontCategoriesRoot.innerHTML = '';
    storefrontList.innerHTML = '';
    storefrontCategoriesRoot.classList.add('hidden');
    storefrontList.classList.add('hidden');
    return;
  }
  storefrontCategoriesRoot.classList.remove('hidden');
  storefrontList.classList.remove('hidden');
  const items = getStorefrontItemsByMode(storefrontMode);
  const categories = getStorefrontCategories(items);
  if (!categories.includes(storefrontSelectedCategory)) {
    storefrontSelectedCategory = 'all';
  }

  storefrontCategoriesRoot.innerHTML = '';
  for (const category of categories) {
    const btn = document.createElement('button');
    btn.type = 'button';
    btn.className = `storefront-category-btn ${category === storefrontSelectedCategory ? 'active' : ''}`;
    btn.textContent = category === 'all' ? 'All' : category;
    btn.addEventListener('click', () => {
      storefrontSelectedCategory = category;
      renderStorefront();
    });
    storefrontCategoriesRoot.appendChild(btn);
  }

  storefrontList.innerHTML = '';
  const filtered = items.filter((item) => {
    if (storefrontSelectedCategory === 'all') return true;
    return String(item?.category || 'General').trim() === storefrontSelectedCategory;
  });

  if (!filtered.length) {
    storefrontList.innerHTML = items.length
      ? '<div class="storefront-empty">No items in this category.</div>'
      : `<div class="storefront-empty">${storefrontMode === 'sell' ? 'This society is not buying items right now.' : 'This store is currently sold out.'}</div>`;
    return;
  }

  for (const item of filtered) {
    storefrontList.appendChild(renderStorefrontItemCard(item, storefrontMode));
  }
}

function openStorefront(payload) {
  const data = payload && typeof payload === 'object' ? payload : {};
  const previousStoreId = storefrontData?.storeId ? String(storefrontData.storeId) : '';
  storefrontData = data;
  storefrontOpen = true;
  const nextStoreId = String(data.storeId || '');
  if (previousStoreId !== nextStoreId) {
    storefrontSelectedCategory = 'all';
    const hasBuyItems = Array.isArray(data.items) && data.items.length > 0;
    const hasSellItems = data.buyEnabled === true && Array.isArray(data.buyItems) && data.buyItems.length > 0;
    storefrontMode = hasBuyItems ? 'buy' : (hasSellItems ? 'sell' : 'buy');
  }

  document.getElementById('storefront-title').textContent = String(data.label || 'General Store');
  document.getElementById('storefront-subtitle').textContent = String(data.subtitle || 'Buy from the store or sell goods back to the society.');
  renderStorefront();

  storefrontRoot.classList.remove('hidden');
}

function iconPreviewSrc(marker, bgColor = '#6f4f27') {
  const safe = String(marker || '?').slice(0, 3).toUpperCase();
  const svg = `<svg xmlns='http://www.w3.org/2000/svg' width='52' height='52' viewBox='0 0 52 52'><rect x='2' y='2' width='48' height='48' rx='10' fill='${bgColor}'/><circle cx='26' cy='26' r='15' fill='#f4dfb7'/><text x='26' y='31' text-anchor='middle' font-size='12' font-family='Georgia,serif' fill='#2d2012'>${safe}</text></svg>`;
  return `data:image/svg+xml;utf8,${encodeURIComponent(svg)}`;
}

function getBlipByKey(key) {
  return (state.blips || []).find((b) => String(b.blip_key || '') === String(key || ''));
}

function nearestLocationPreset(coords) {
  if (!coords || coords.x === undefined || coords.y === undefined || coords.z === undefined) {
    return 'valentine';
  }
  let selected = 'valentine';
  let best = Number.POSITIVE_INFINITY;
  for (const [name, p] of Object.entries(LOCATION_PRESETS)) {
    const dx = Number(coords.x) - Number(p.x);
    const dy = Number(coords.y) - Number(p.y);
    const dz = Number(coords.z) - Number(p.z);
    const dist = Math.sqrt((dx * dx) + (dy * dy) + (dz * dz));
    if (dist < best) {
      best = dist;
      selected = name;
    }
  }
  return selected;
}

function getRankName(rankIndex) {
  const idx = Number(rankIndex || 0);
  const found = (state.ranks || []).find((r) => Number(r.rank_index) === idx);
  return found?.rank_name || `Rank ${idx}`;
}

function canCurrentUserManageTheme() {
  if (state.mode === 'admin') return true;
  const myChar = String(state.myCharId || '').trim();
  if (!myChar || !state.selectedSociety) return false;
  const bossGrade = Number(state.selectedSociety?.boss_grade ?? 3);
  const me = (state.employees || []).find((e) => String(e.char_id || '') === myChar);
  if (!me) return false;
  return Number(me.is_boss || 0) === 1 || Number(me.rank_index || -1) >= bossGrade;
}

function canCurrentUserManageDiscord() {
  if (state.mode === 'admin') return true;
  const myChar = String(state.myCharId || '').trim();
  if (!myChar || !state.selectedSociety) return false;
  const bossGrade = Number(state.selectedSociety?.boss_grade ?? 3);
  const me = (state.employees || []).find((e) => String(e.char_id || '') === myChar);
  if (!me) return false;
  const rankIndex = Number(me.rank_index || 0);
  if (Number(me.is_boss || 0) === 1 || rankIndex >= bossGrade) {
    return true;
  }
  const permissionMap = buildRankPermissionMap(state.rankPermissions || []);
  return permissionMap[rankIndex] && permissionMap[rankIndex]['boss.discord.manage'] === true;
}

function canCurrentUserUseSocietyPermission(permissionKey) {
  if (state.mode === 'admin') return true;
  const myChar = String(state.myCharId || '').trim();
  if (!myChar || !state.selectedSociety || !permissionKey) return false;
  const bossGrade = Number(state.selectedSociety?.boss_grade ?? 3);
  const me = (state.employees || []).find((e) => String(e.char_id || e.charId || '') === myChar);
  if (!me) return false;
  const rankIndex = Number(me.rank_index || 0);
  if (Number(me.is_boss || 0) === 1 || rankIndex >= bossGrade) {
    return true;
  }
  const permissionMap = buildRankPermissionMap(state.rankPermissions || []);
  return permissionMap[rankIndex] && permissionMap[rankIndex][permissionKey] === true;
}

function syncLedgerAccessControls() {
  const deposit = document.getElementById('deposit-btn');
  const withdraw = document.getElementById('withdraw-btn');
  if (deposit) {
    const unlocked = canCurrentUserUseSocietyPermission('boss.ledger.deposit');
    deposit.disabled = !unlocked;
    deposit.title = unlocked ? '' : 'Missing ledger deposit permission.';
  }
  if (withdraw) {
    const unlocked = canCurrentUserUseSocietyPermission('boss.ledger.withdraw');
    withdraw.disabled = !unlocked;
    withdraw.title = unlocked ? '' : 'Missing ledger withdraw permission.';
  }
}

function normalizeDiscordWebhook(webhook) {
  const raw = webhook && typeof webhook === 'object' ? webhook : {};
  const channels = {};
  for (const channel of DISCORD_WEBHOOK_CHANNELS) {
    channels[channel.key] = raw.channels && Object.prototype.hasOwnProperty.call(raw.channels, channel.key)
      ? raw.channels[channel.key] === true || raw.channels[channel.key] === 1
      : true;
  }
  return {
    enabled: raw.enabled === true || raw.enabled === 1,
    url: String(raw.url || raw.webhookUrl || raw.webhook_url || ''),
    channels,
  };
}

function syncDiscordAccessControls() {
  const unlocked = canCurrentUserManageDiscord();
  const ids = [
    'discord-webhook-enabled',
    'discord-webhook-url',
    'save-discord-webhook-btn',
  ];
  for (const id of ids) {
    const el = document.getElementById(id);
    if (!el) continue;
    el.disabled = !unlocked;
  }
  for (const checkbox of document.querySelectorAll('[data-discord-channel]')) {
    checkbox.disabled = !unlocked;
  }
}

function renderDiscordWebhookSettings() {
  if (state.ingameWebhookEnabled !== true) {
    return;
  }

  const webhook = normalizeDiscordWebhook(state.selectedSociety?.webhook);
  const enabledInput = document.getElementById('discord-webhook-enabled');
  const urlInput = document.getElementById('discord-webhook-url');
  const channelRoot = document.getElementById('discord-channel-list');
  if (enabledInput) enabledInput.checked = webhook.enabled;
  if (urlInput) urlInput.value = webhook.url;
  if (channelRoot) {
    channelRoot.innerHTML = '';
    for (const channel of DISCORD_WEBHOOK_CHANNELS) {
      const label = document.createElement('label');
      label.className = 'discord-channel-toggle';
      const input = document.createElement('input');
      input.type = 'checkbox';
      input.dataset.discordChannel = channel.key;
      input.checked = webhook.channels[channel.key] === true;
      label.appendChild(input);
      label.appendChild(document.createTextNode(channel.label));
      channelRoot.appendChild(label);
    }
  }
  syncDiscordAccessControls();
}

function normalizeThemePresetColors(colors) {
  if (!Array.isArray(colors)) {
    return [...DEFAULT_THEME_PRESET_COLORS];
  }
  const normalized = [];
  for (const color of colors) {
    const safe = normalizeHexColor(color, '');
    if (!safe) continue;
    if (normalized.includes(safe)) continue;
    normalized.push(safe);
  }
  if (!normalized.length) {
    return [...DEFAULT_THEME_PRESET_COLORS];
  }
  return normalized;
}

function renderThemePresetColors() {
  const root = document.getElementById('theme-preset-colors');
  const targetSelect = document.getElementById('theme-preset-target');
  if (!root || !targetSelect) return;

  const targetId = String(state.themePresetTarget || 'theme-primary');
  if (targetSelect.value !== targetId) {
    targetSelect.value = targetId;
  }

  const targetInput = document.getElementById(targetSelect.value);
  const currentColor = String(targetInput?.value || '').toLowerCase();
  const unlocked = canCurrentUserManageTheme();
  const colors = normalizeThemePresetColors(state.themePresetColors);

  root.innerHTML = '';
  for (const color of colors) {
    const swatch = document.createElement('button');
    swatch.type = 'button';
    swatch.className = `theme-preset-swatch${currentColor === color.toLowerCase() ? ' active' : ''}`;
    swatch.title = color;
    swatch.style.backgroundColor = color;
    swatch.disabled = !unlocked;
    swatch.addEventListener('click', () => {
      const selectedTarget = document.getElementById(String(state.themePresetTarget || 'theme-primary'));
      if (!selectedTarget || selectedTarget.disabled) return;
      selectedTarget.value = color;
      applyThemeFromInputs();
      renderThemePresetColors();
    });
    root.appendChild(swatch);
  }
}

function syncThemeAccessControls() {
  const unlocked = canCurrentUserManageTheme();
  const ids = [
    'theme-primary',
    'theme-secondary',
    'theme-surface',
    'theme-surface-2',
    'theme-card',
    'theme-text',
    'theme-muted',
    'theme-icon',
    'theme-preset-target',
    'save-theme-btn',
    'reset-theme-btn',
  ];
  for (const id of ids) {
    const el = document.getElementById(id);
    if (!el) continue;
    el.disabled = !unlocked;
  }
  const note = document.getElementById('theme-access-note');
  if (note) {
    note.textContent = unlocked
      ? 'Theme controls unlocked.'
      : 'Theme controls are locked. Only boss-grade can edit this theme.';
  }
  renderThemePresetColors();
}

function buildRankPermissionMap(list = []) {
  const map = {};
  for (const row of list) {
    const idx = Number(row.rank_index || 0);
    const key = String(row.permission_key || '');
    if (!map[idx]) map[idx] = {};
    map[idx][key] = Number(row.allowed) === 1;
  }
  return map;
}

function isBossLockedRank(rankIndex) {
  const bossGrade = Number(state.selectedSociety?.boss_grade ?? 3);
  return Number(rankIndex) >= bossGrade;
}

function setSelectedWorker(charId, displayName, rankIndex) {
  const hiddenTarget = document.getElementById('target-char');
  const display = document.getElementById('employee-selected-display');
  const rankInput = document.getElementById('target-rank');
  if (hiddenTarget) hiddenTarget.value = String(charId || '');
  if (display) display.textContent = `Selected Worker: ${displayName || 'None'}`;
  if (rankInput && rankIndex !== undefined && rankIndex !== null && rankInput.value === '') {
    rankInput.value = String(rankIndex);
  }
}

function setPane(id) {
  for (const pane of panes) {
    pane.classList.toggle('hidden', pane.dataset.pane !== id);
  }
  for (const tab of tabsRoot.querySelectorAll('.tab')) {
    tab.classList.toggle('active', tab.dataset.tab === id);
  }
  if (id === 'stores' && state.societyId) {
    request('society.store.inventory', { societyId: state.societyId });
  }
}

function renderTabs() {
  tabsRoot.innerHTML = '';
  if (state.mode === 'jobcenter') {
    tabsRoot.classList.add('hidden');
    setPane('jobcenter');
    return;
  }

  tabsRoot.classList.remove('hidden');
  const visibleTabs = tabConfig.filter((tab) => {
    if (tab.id === 'jobcenter') return false;
    if (state.mode !== 'admin' && tab.id === 'admin') return false;
    if (tab.id === 'discord' && state.ingameWebhookEnabled !== true) return false;
    return true;
  });
  for (const tab of visibleTabs) {
    const b = document.createElement('button');
    b.className = 'tab';
    b.dataset.tab = tab.id;
    b.textContent = tab.label;
    b.addEventListener('click', () => setPane(tab.id));
    tabsRoot.appendChild(b);
  }
  setPane('overview');
}

function renderSocietySelect() {
  const sel = document.getElementById('society-select');
  if (!sel) return;
  sel.disabled = state.mode !== 'admin';
  sel.innerHTML = '';
  for (const s of state.societies) {
    const op = document.createElement('option');
    op.value = s.society_id;
    op.textContent = s.label || s.society_id;
    sel.appendChild(op);
  }
  if (state.societyId) {
    sel.value = state.societyId;
  }
}

function renderAdminSocietyList() {
  const root = document.getElementById('admin-society-list');
  if (!root) return;
  root.innerHTML = '';
  for (const s of state.societies || []) {
    const row = document.createElement('div');
    row.className = 'table-row';
    const selected = String(state.adminSelectedSocietyId || '') === String(s.society_id) ? ' [selected]' : '';
    row.innerHTML = `<span>${s.label || s.society_id}${selected}</span><span>${s.job_name || ''}</span><span>Entry ${Number(s.entry_grade || 0)}</span><span>Boss ${Number(s.boss_grade || 3)}</span><span>Tax ${Number(s.tax_percent || 0)}%</span>`;
    row.style.cursor = 'pointer';
    row.addEventListener('click', () => selectAdminSociety(s.society_id));
    root.appendChild(row);
  }
}

function selectAdminSociety(societyId, loadState = true) {
  const sid = String(societyId || '');
  const selected = (state.societies || []).find((s) => String(s.society_id) === sid);
  if (!selected) return;
  state.adminSelectedSocietyId = sid;
  state.societyId = sid;
  const select = document.getElementById('society-select');
  if (select) select.value = sid;
  document.getElementById('admin-edit-label').value = selected.label || '';
  document.getElementById('admin-edit-entry-grade').value = Number(selected.entry_grade || 0);
  document.getElementById('admin-edit-boss-grade').value = Number(selected.boss_grade || 3);
  document.getElementById('admin-edit-tax').value = Number(selected.tax_percent || 0);
  document.getElementById('admin-edit-public').checked = Number(selected.is_public || 0) === 1;
  const info = document.getElementById('admin-selected-info');
  if (info) {
    info.textContent = `Selected: ${selected.label || sid} (${sid})`;
  }
  renderAdminSocietyList();
  if (loadState && state.mode === 'admin') {
    request('society.open', { societyId: sid });
  }
}

function getSocietyLabel(societyId) {
  const sid = String(societyId || '');
  const found = (state.societies || []).find((s) => String(s.society_id) === sid);
  return found?.label || sid;
}

function renderOverview() {
  const businessName = document.getElementById('overview-business-name');
  const businessSummary = document.getElementById('overview-business-summary');
  const contextMode = document.getElementById('overview-context-mode');
  const businessJob = document.getElementById('overview-business-job');
  const businessBossGrade = document.getElementById('overview-business-boss-grade');
  const businessPublic = document.getElementById('overview-business-public');
  const mEmployees = document.getElementById('overview-metric-employees');
  const mRanks = document.getElementById('overview-metric-ranks');
  const mStores = document.getElementById('overview-metric-stores');
  const mBlips = document.getElementById('overview-metric-blips');
  const mBills = document.getElementById('overview-metric-bills');
  const txRoot = document.getElementById('overview-transactions');
  const btnGoAdmin = document.getElementById('overview-go-admin');

  if (btnGoAdmin) {
    btnGoAdmin.style.display = state.mode === 'admin' ? '' : 'none';
  }

  const s = state.selectedSociety;
  if (!s) {
    businessName.textContent = 'No Business Loaded';
    businessSummary.textContent = state.mode === 'admin'
      ? 'Use county records to select a registered business and inspect its books.'
      : 'You are not currently employed by a registered society business.';
    contextMode.textContent = 'Society Ledger';
    businessJob.textContent = '-';
    businessBossGrade.textContent = '-';
    businessPublic.textContent = '-';
    mEmployees.textContent = '0';
    mRanks.textContent = '0';
    mStores.textContent = '0';
    mBlips.textContent = '0';
    mBills.textContent = String((state.societyInvoices || []).filter((x) => String(x.status || '').toLowerCase() === 'open').length);
    txRoot.innerHTML = '<div class="muted">No transaction history loaded.</div>';
    return;
  }

  const openBills = (state.societyInvoices || []).filter((x) => String(x.status || '').toLowerCase() === 'open').length;
  contextMode.textContent = 'Society Ledger';
  businessName.textContent = s.label || s.society_id;
  businessSummary.textContent = state.mode === 'admin'
    ? `County administration is reviewing the books for ${s.label || s.society_id}.`
    : 'These records reflect your current business: staff, payroll, and ledger activity.';
  businessJob.textContent = s.job_name || '-';
  businessBossGrade.textContent = String(s.boss_grade ?? '-');
  businessPublic.textContent = Number(s.is_public || 0) === 1 ? 'Yes' : 'No';
  mEmployees.textContent = String((state.employees || []).length);
  mRanks.textContent = String((state.ranks || []).length);
  mStores.textContent = String((state.stores || []).length);
  mBlips.textContent = String((state.blips || []).filter((b) => Number(b.enabled) === 1).length);
  mBills.textContent = String(openBills);

  txRoot.innerHTML = '';
  const txList = (state.transactions || []).slice(0, 8);
  if (txList.length === 0) {
    txRoot.innerHTML = '<div class="muted">No transactions yet for this business.</div>';
    return;
  }
  for (const tx of txList) {
    const row = document.createElement('div');
    row.className = 'table-row';
    const actorName = String(tx.actor_name || tx.actor_char_name || tx.actor_char_id || '-');
    row.innerHTML = `<span>${formatActionLabel(tx.tx_type)}</span><span>${formatCurrency(tx.amount)}</span><span>Tax ${formatCurrency(tx.tax_amount)}</span><span>${actorName}</span><span>${formatTime(tx.created_at)}</span>`;
    txRoot.appendChild(row);
  }
}

function renderJobCenterBoard() {
  const rootEl = document.getElementById('job-board-list');
  if (!rootEl) return;
  rootEl.innerHTML = '';

  const jobs = Array.isArray(state.publicJobs) ? state.publicJobs : [];
  if (jobs.length === 0) {
    rootEl.innerHTML = '<div class="muted">No public jobs are currently listed.</div>';
    return;
  }

  for (const job of jobs) {
    const row = document.createElement('div');
    row.className = 'table-row job-board-row';

    const label = String(job.label || job.job_name || 'Public Job');
    const role = formatActionLabel(job.job_name || '');
    const grade = Number(job.entry_grade || 0);
    const source = String(job.source || '').toLowerCase() === 'config' ? 'Default Public' : 'Player-Owned Public';
    const description = String(job.description || '').trim() || '-';
    const salary = Math.max(0, Number(job.salary || 0));
    const interval = Math.max(1, Number(job.payroll_interval_minutes || 0));
    const payrollText = salary > 0
      ? `${formatCurrency(salary)} / ${interval}m`
      : 'Unpaid';

    row.innerHTML = `<span>${label}</span><span>${role}</span><span>Entry Grade ${grade}</span><span>${payrollText}</span><span>${source}</span><span>${description}</span>`;

    const applyBtn = document.createElement('button');
    applyBtn.className = 'btn';
    applyBtn.textContent = 'Apply';
    applyBtn.addEventListener('click', () => {
      request('society.jobCenter.selfHire', {
        societyId: String(job.society_id || ''),
        jobName: String(job.job_name || ''),
      }).then((res) => {
        if (res && res.success) {
          request('society.jobCenter.listPublic', {});
        }
      });
    });

    row.appendChild(applyBtn);
    rootEl.appendChild(row);
  }
}

function syncPayrollIntervalInput() {
  const input = document.getElementById('payroll-interval-minutes');
  const current = document.getElementById('payroll-current-timer');
  if (!input) return;
  const interval = Number(state.selectedSociety?.payroll_interval_minutes || 0);
  if (interval > 0) {
    input.value = String(interval);
    if (current) current.textContent = `${interval} minute${interval === 1 ? '' : 's'}`;
  } else {
    input.value = '';
    if (current) current.textContent = '-';
  }
}

function renderEmployees(list = []) {
  const root = document.getElementById('employee-list');
  root.innerHTML = '';
  if (!list.length) {
    root.innerHTML = '<div class="muted">No staff members yet.</div>';
    return;
  }
  for (const e of list) {
    const charId = String(e.char_id || '');
    const selectedChar = String(document.getElementById('target-char')?.value || '');
    const isActive = selectedChar !== '' && selectedChar === charId;
    const row = document.createElement('div');
    row.className = 'table-row';
    row.innerHTML = `<span>${e.player_name || 'Unknown'}</span><span>${getRankName(e.rank_index)}</span><span>${Number(e.is_boss) === 1 ? 'Boss' : 'Staff'}</span><span>Updated ${formatDateTime(e.updated_at || e.created_at)}</span><span><button type="button" class="btn">${isActive ? 'Selected ✓' : 'Select'}</button></span>`;
    row.style.cursor = 'pointer';
    const applySelection = () => {
      setSelectedWorker(charId, e.player_name || 'Unknown', Number(e.rank_index || 0));
      document.getElementById('target-rank').value = Number(e.rank_index || 0);
      renderEmployees(state.employees || []);
      renderOnlinePlayers(state.onlinePlayers || []);
    };
    const button = row.querySelector('button');
    if (button) {
      button.addEventListener('click', (event) => {
        event.stopPropagation();
        applySelection();
      });
    }
    row.addEventListener('click', () => {
      applySelection();
    });
    root.appendChild(row);
  }
}

function renderOnlinePlayers(list = []) {
  const select = document.getElementById('online-player-select');
  const table = document.getElementById('online-players-list');
  if (!select) return;

  select.innerHTML = '';
  if (table) {
    table.innerHTML = '';
  }

  const empty = document.createElement('option');
  empty.value = '';
  empty.textContent = 'Choose nearby worker';
  select.appendChild(empty);

  if (!list.length && table) {
    table.innerHTML = '<div class="muted">No nearby workers right now.</div>';
  }
  if (!list.length) {
    return;
  }

  for (const player of list) {
    const op = document.createElement('option');
    op.value = player.char_id || '';
    op.dataset.source = String(player.source || '');
    op.textContent = `${player.name || 'Unknown'} - ${formatActionLabel(player.current_job || 'Unemployed')}`;
    select.appendChild(op);

    if (table) {
      const charId = String(player.char_id || '');
      const selectedChar = String(document.getElementById('target-char')?.value || '');
      const isActive = selectedChar !== '' && selectedChar === charId;
      const row = document.createElement('div');
      row.className = 'table-row';
      row.innerHTML = `<span>${player.name || 'Unknown'}</span><span>${formatActionLabel(player.current_job || 'Unemployed')}</span><span>Grade ${player.current_grade ?? 0}</span><span>${player.in_society ? 'Already on staff' : 'Nearby'}</span><span><button type="button" class="btn">${isActive ? 'Selected ✓' : 'Select'}</button></span>`;
      row.style.cursor = 'pointer';
      const applySelection = () => {
        setSelectedWorker(charId, player.name || 'Unknown', player.society_rank ?? 0);
        select.value = player.char_id || '';
        renderEmployees(state.employees || []);
        renderOnlinePlayers(state.onlinePlayers || []);
      };
      const button = row.querySelector('button');
      if (button) {
        button.addEventListener('click', (event) => {
          event.stopPropagation();
          applySelection();
        });
      }
      row.addEventListener('click', () => {
        applySelection();
      });
      table.appendChild(row);
    }
  }
}

function renderBillTargets(list = []) {
  const select = document.getElementById('bill-target-select');
  if (!select) return;

  const prev = String(select.value || '');
  select.innerHTML = '';

  const empty = document.createElement('option');
  empty.value = '';
  empty.textContent = 'Choose nearby player to bill';
  select.appendChild(empty);

  for (const player of list || []) {
    const charId = String(player.char_id || '');
    if (!charId || charId === String(state.myCharId || '')) {
      continue;
    }
    const op = document.createElement('option');
    op.value = charId;
    op.textContent = `${player.name || 'Unknown'} - ${formatActionLabel(player.current_job || 'Unemployed')}`;
    select.appendChild(op);
  }

  if (prev && Array.from(select.options).some((o) => String(o.value) === prev)) {
    select.value = prev;
  }
}

function renderRanks(list = []) {
  const root = document.getElementById('rank-list');
  const legend = document.getElementById('rank-perm-legend');
  root.innerHTML = '';
  if (legend) {
    legend.innerHTML = '';
    for (const perm of PERMISSION_CATALOG) {
      const item = document.createElement('span');
      item.className = 'rank-perm-legend-item';
      item.textContent = `${perm.icon} ${perm.label}`;
      legend.appendChild(item);
    }
  }
  if (!list.length) {
    root.innerHTML = '<div class="muted">No rank records available.</div>';
    return;
  }
  const permissionMap = buildRankPermissionMap(state.rankPermissions || []);
  for (const r of list) {
    const rankIndex = Number(r.rank_index || 0);
    const lockedRank = isBossLockedRank(rankIndex);
    const row = document.createElement('div');
    row.className = 'rank-row';

    const left = document.createElement('div');
    left.className = 'rank-row-main';
    left.innerHTML = `<strong>${r.rank_name || `Rank ${rankIndex}`}</strong><span class="muted">Rank ${rankIndex} | Salary ${formatCurrency(r.salary)}</span>`;
    row.appendChild(left);

    const perms = document.createElement('div');
    perms.className = 'rank-perm-wrap';
    for (const perm of PERMISSION_CATALOG) {
      const dbAllowed = permissionMap[rankIndex] && permissionMap[rankIndex][perm.key] === true;
      const allowed = lockedRank ? true : dbAllowed;
      const chip = document.createElement('button');
      chip.type = 'button';
      chip.className = `rank-perm-chip ${allowed ? 'allowed' : 'denied'} ${lockedRank ? 'locked' : ''}`;
      chip.textContent = perm.icon;
      chip.title = lockedRank
        ? `${perm.label}: Always Allowed for Boss/Owner`
        : `${perm.label}: ${allowed ? 'Allowed' : 'Denied'}`;
      if (!lockedRank) {
        chip.addEventListener('click', (event) => {
          event.stopPropagation();
          request('society.setRankPermission', {
            societyId: state.societyId,
            rankIndex,
            permissionKey: perm.key,
            allowed: !allowed,
          });
        });
      }
      perms.appendChild(chip);
    }
    row.appendChild(perms);

    row.addEventListener('click', () => {
      document.getElementById('rank-index').value = rankIndex;
      document.getElementById('rank-name').value = r.rank_name || '';
      document.getElementById('rank-salary').value = Number(r.salary || 0);
    });
    root.appendChild(row);
  }
}

function renderStores(list = []) {
  const root = document.getElementById('store-list');
  const select = document.getElementById('store-existing-select');
  const labelInput = document.getElementById('store-label-input');
  const propSelect = document.getElementById('store-prop-select');
  root.innerHTML = '';
  if (select) {
    select.innerHTML = '';
    const empty = document.createElement('option');
    empty.value = '';
    empty.textContent = 'Select store';
    select.appendChild(empty);
  }

  const renderStorePropOptions = (selectedValue = '') => {
    if (!propSelect) return;
    propSelect.innerHTML = '';
    const none = document.createElement('option');
    none.value = '';
    none.textContent = 'No Prop';
    propSelect.appendChild(none);

    const configured = Array.isArray(state.storePropList) ? state.storePropList : [];
    for (const model of configured) {
      const safe = String(model || '').trim();
      if (!safe) continue;
      const option = document.createElement('option');
      option.value = safe;
      option.textContent = safe;
      propSelect.appendChild(option);
    }

    const picked = String(selectedValue || '').trim();
    if (picked && !Array.from(propSelect.options).some((opt) => String(opt.value) === picked)) {
      const legacy = document.createElement('option');
      legacy.value = picked;
      legacy.textContent = `${picked} (Legacy)`;
      propSelect.appendChild(legacy);
    }
    propSelect.value = picked;
  };

  let selectedExists = false;
  for (const s of list) {
    const displayLabel = String(s.label || '').trim() || 'Store';
    if (select) {
      const op = document.createElement('option');
      op.value = s.store_id;
      op.textContent = displayLabel;
      select.appendChild(op);
      if (String(state.selectedStoreId || '') === String(s.store_id)) {
        selectedExists = true;
      }
    }
    const row = document.createElement('div');
    row.className = 'table-row';
    const stockCount = (s.catalog || []).reduce((sum, item) => sum + Number(item.qty || 0), 0);
    const buyMode = Number(s.buy_enabled || 0) === 1 ? 'Buying On' : 'Buying Off';
    row.innerHTML = `<span>${displayLabel}</span><span>${Number(s.enabled) === 1 ? 'Enabled' : 'Disabled'}</span><span>${(s.catalog || []).length} items</span><span>${stockCount} stock</span><span>${buyMode}</span><span>${String(s.prop_model || '').trim() || 'No Prop'}</span>`;
    row.style.cursor = 'pointer';
    row.addEventListener('click', () => {
      state.selectedStoreId = s.store_id;
      state.selectedStoreStockItem = '';
      state.selectedStoreBuyItem = '';
      if (select) select.value = s.store_id;
      if (labelInput) labelInput.value = s.label || '';
      renderStorePropOptions(String(s.prop_model || ''));
      renderStoreStock();
      renderStoreBuyOrders();
    });
    root.appendChild(row);
  }

  if (!state.selectedStoreId && list.length > 0) {
    state.selectedStoreId = list[0].store_id;
    selectedExists = true;
  } else if (state.selectedStoreId && !selectedExists) {
    state.selectedStoreId = '';
  }
  if (select) {
    select.value = state.selectedStoreId || '';
  }
  const selected = (list || []).find((s) => String(s.store_id) === String(state.selectedStoreId || ''));
  if (labelInput) {
    labelInput.value = selected?.label || '';
  }
  renderStorePropOptions(selected?.prop_model || '');
  const buyEnabled = document.getElementById('store-buy-enabled');
  if (buyEnabled) {
    buyEnabled.checked = Number(selected?.buy_enabled || 0) === 1;
  }
  renderStoreStock();
  renderStoreBuyOrders();
  renderStorageMarkerStatus();
  renderCraftingControls();
}

function renderCraftingControls() {
  const block = document.getElementById('crafting-config-block');
  if (block) {
    block.classList.toggle('hidden', state.craftingEnabled === false);
  }
  if (state.craftingEnabled === false) {
    return;
  }

  const propSelect = document.getElementById('crafting-prop-select');
  const status = document.getElementById('crafting-prop-status');
  if (propSelect) {
    const selected = String(
      state.selectedSociety?.storage?.crafting?.propModel
        || state.selectedSociety?.storage?.crafting?.prop_model
        || ''
    ).trim();
    propSelect.innerHTML = '';
    const noPropOption = document.createElement('option');
    noPropOption.value = '';
    noPropOption.textContent = 'No Prop';
    propSelect.appendChild(noPropOption);

    const configured = Array.isArray(state.craftingPropList) ? state.craftingPropList : [];
    for (const model of configured) {
      const safe = String(model || '').trim();
      if (!safe) continue;
      const option = document.createElement('option');
      option.value = safe;
      option.textContent = safe;
      propSelect.appendChild(option);
    }
    if (!propSelect.options.length) {
      const fallback = document.createElement('option');
      fallback.value = 'p_workbench01x';
      fallback.textContent = 'p_workbench01x';
      propSelect.appendChild(fallback);
    }
    if (selected && !Array.from(propSelect.options).some((opt) => String(opt.value) === selected)) {
      const legacy = document.createElement('option');
      legacy.value = selected;
      legacy.textContent = `${selected} (Legacy)`;
      propSelect.appendChild(legacy);
    }
    propSelect.value = selected;
  }

  if (!status) return;
  const crafting = state.selectedSociety
    && state.selectedSociety.storage
    && state.selectedSociety.storage.crafting
    && typeof state.selectedSociety.storage.crafting === 'object'
    ? state.selectedSociety.storage.crafting
    : null;
  if (!crafting) {
    status.textContent = 'Crafting prop: not set';
    return;
  }
  const x = Number(crafting.coords && crafting.coords.x);
  const y = Number(crafting.coords && crafting.coords.y);
  const z = Number(crafting.coords && crafting.coords.z);
  if (Number.isFinite(x) && Number.isFinite(y) && Number.isFinite(z)) {
    const prop = String(crafting.propModel || crafting.prop_model || '').trim() || 'No Prop';
    status.textContent = `Crafting prop: ${prop} at ${x.toFixed(1)}, ${y.toFixed(1)}, ${z.toFixed(1)}`;
    return;
  }
  status.textContent = 'Crafting prop: not set';
}

function renderAdverts(list = []) {
  const root = document.getElementById('advert-list');
  const select = document.getElementById('advert-existing-select');
  const titleInput = document.getElementById('advert-title-input');
  const imageInput = document.getElementById('advert-image-input');
  const descriptionInput = document.getElementById('advert-description-input');
  const propSelect = document.getElementById('advert-prop-select');
  if (!root || !select) return;

  const renderPropOptions = (selectedValue = '') => {
    if (!propSelect) return;
    propSelect.innerHTML = '';
    const noPropOption = document.createElement('option');
    noPropOption.value = '';
    noPropOption.textContent = 'No Prop';
    propSelect.appendChild(noPropOption);

    const configured = Array.isArray(state.advertPropList) ? state.advertPropList : [];
    for (const model of configured) {
      const safe = String(model || '').trim();
      if (!safe) continue;
      const option = document.createElement('option');
      option.value = safe;
      option.textContent = safe;
      propSelect.appendChild(option);
    }

    const picked = String(selectedValue || '').trim();
    if (picked && !Array.from(propSelect.options).some((opt) => String(opt.value) === picked)) {
      const legacy = document.createElement('option');
      legacy.value = picked;
      legacy.textContent = `${picked} (Legacy)`;
      propSelect.appendChild(legacy);
    }
    propSelect.value = picked;
  };

  root.innerHTML = '';
  select.innerHTML = '';
  const empty = document.createElement('option');
  empty.value = '';
  empty.textContent = 'Select advertisement';
  select.appendChild(empty);

  if (!state.selectedAdvertId && Array.isArray(list) && list.length > 0) {
    state.selectedAdvertId = String(list[0].advert_id || '');
  }

  let selectedExists = false;
  for (const ad of list || []) {
    const advertId = String(ad.advert_id || '');
    const title = String(ad.title || 'Advertisement').trim() || 'Advertisement';
    const coords = ad.coords || {};
    const hasCoords = Number.isFinite(Number(coords.x)) && Number.isFinite(Number(coords.y)) && Number.isFinite(Number(coords.z));
    const isActive = advertId !== '' && advertId === String(state.selectedAdvertId || '');

    const op = document.createElement('option');
    op.value = advertId;
    op.textContent = title;
    select.appendChild(op);
    if (advertId === String(state.selectedAdvertId || '')) {
      selectedExists = true;
    }

    const row = document.createElement('div');
    row.className = 'table-row';
    row.innerHTML = `<span>${title}</span><span>${Number(ad.enabled) === 1 ? 'Enabled' : 'Disabled'}</span><span>${hasCoords ? `${Number(coords.x).toFixed(1)}, ${Number(coords.y).toFixed(1)}` : 'No position'}</span><span>${String(ad.prop_model || '').trim() || 'No Prop'}</span><span><button type="button" class="btn">${isActive ? 'Selected ✓' : 'Select'}</button></span>`;
    row.style.cursor = 'pointer';
    const applySelection = () => {
      state.selectedAdvertId = advertId;
      renderAdverts(state.adverts || []);
    };
    const button = row.querySelector('button');
    if (button) {
      button.addEventListener('click', (event) => {
        event.stopPropagation();
        applySelection();
      });
    }
    row.addEventListener('click', applySelection);
    root.appendChild(row);
  }

  if (!state.selectedAdvertId && list.length > 0) {
    state.selectedAdvertId = String(list[0].advert_id || '');
    selectedExists = true;
  } else if (state.selectedAdvertId && !selectedExists) {
    state.selectedAdvertId = '';
  }
  select.value = state.selectedAdvertId || '';
  const selected = (list || []).find((a) => String(a.advert_id || '') === String(state.selectedAdvertId || ''));
  if (titleInput) titleInput.value = selected?.title || '';
  if (imageInput) imageInput.value = selected?.image_url || '';
  if (descriptionInput) descriptionInput.value = selected?.description || '';
  renderPropOptions(selected?.prop_model || '');

  if (!list.length) {
    root.innerHTML = '<div class="muted">No advertisements created yet.</div>';
  }
}

function renderManagerInventory(list = []) {
  const select = document.getElementById('store-inventory-item');
  const buySelect = document.getElementById('store-buy-item');
  if (!select) return;
  select.innerHTML = '';
  if (buySelect) buySelect.innerHTML = '';
  const empty = document.createElement('option');
  empty.value = '';
  empty.textContent = 'Select inventory item';
  select.appendChild(empty);
  if (buySelect) {
    const buyEmpty = document.createElement('option');
    buyEmpty.value = '';
    buyEmpty.textContent = 'Select item to buy from players';
    buySelect.appendChild(buyEmpty);
  }
  for (const row of list) {
    const itemName = String(row.item || '');
    if (!itemName) continue;
    const op = document.createElement('option');
    op.value = itemName;
    op.textContent = `${row.label || resolveDisplayItemLabel(row)} x${Number(row.amount || 0)}`;
    select.appendChild(op);
    if (buySelect) {
      const buyOp = document.createElement('option');
      buyOp.value = itemName;
      buyOp.textContent = `${row.label || resolveDisplayItemLabel(row)}`;
      buySelect.appendChild(buyOp);
    }
  }
}

function renderStoreBuyOrders() {
  const root = document.getElementById('store-buy-list');
  if (!root) return;
  root.innerHTML = '';
  const selectedStore = (state.stores || []).find((s) => String(s.store_id) === String(state.selectedStoreId || ''));
  if (!selectedStore) {
    state.selectedStoreBuyItem = '';
    const selectedInput = document.getElementById('store-buy-selected-item');
    if (selectedInput) selectedInput.value = '';
    root.innerHTML = '<div class="muted">Select a store to manage buy orders.</div>';
    return;
  }
  const buyCatalog = Array.isArray(selectedStore.buy_catalog) ? selectedStore.buy_catalog : [];
  if (state.selectedStoreBuyItem && !buyCatalog.find((entry) => String(entry.item || '') === String(state.selectedStoreBuyItem))) {
    state.selectedStoreBuyItem = '';
  }
  if (!buyCatalog.length) {
    const selectedInput = document.getElementById('store-buy-selected-item');
    if (selectedInput) selectedInput.value = '';
    root.innerHTML = '<div class="muted">No buy orders configured yet.</div>';
    return;
  }

  const applySelectedBuyItem = (entry, itemKey) => {
    state.selectedStoreBuyItem = itemKey;
    const buySelect = document.getElementById('store-buy-item');
    const selectedInput = document.getElementById('store-buy-selected-item');
    const priceInput = document.getElementById('store-buy-price');
    const categoryInput = document.getElementById('store-buy-category');
    const maxQtyInput = document.getElementById('store-buy-max-qty');
    if (buySelect) {
      if (!Array.from(buySelect.options).some((opt) => String(opt.value) === itemKey)) {
        const extra = document.createElement('option');
        extra.value = itemKey;
        extra.textContent = resolveDisplayItemLabel(entry);
        buySelect.appendChild(extra);
      }
      buySelect.value = itemKey;
    }
    if (selectedInput) selectedInput.value = resolveDisplayItemLabel(entry);
    if (priceInput) priceInput.value = Number(entry.price || 0);
    if (categoryInput) categoryInput.value = String(entry.category || 'General');
    if (maxQtyInput) maxQtyInput.value = Number(entry.max_qty || 0);
  };

  const clearSelectedBuyInputs = () => {
    const buySelect = document.getElementById('store-buy-item');
    const selectedInput = document.getElementById('store-buy-selected-item');
    const priceInput = document.getElementById('store-buy-price');
    const categoryInput = document.getElementById('store-buy-category');
    const maxQtyInput = document.getElementById('store-buy-max-qty');
    if (buySelect) buySelect.value = '';
    if (selectedInput) selectedInput.value = '';
    if (priceInput) priceInput.value = '';
    if (categoryInput) categoryInput.value = '';
    if (maxQtyInput) maxQtyInput.value = '';
  };

  for (const entry of buyCatalog) {
    const itemKey = String(entry.item || '');
    const isActive = itemKey !== '' && itemKey === String(state.selectedStoreBuyItem || '');
    const row = document.createElement('div');
    row.className = 'table-row';
    const maxText = Number(entry.max_qty || 0) > 0 ? Number(entry.max_qty || 0) : 'No Limit';
    row.innerHTML = `<span>${resolveDisplayItemLabel(entry)}</span><span>${entry.category || 'General'}</span><span>Pays ${formatCurrency(entry.price || 0)}</span><span>Max/Txn: ${maxText}</span><span><button type="button" class="btn">${isActive ? 'Selected ✓' : 'Select'}</button></span>`;
    const button = row.querySelector('button');
    let removeBtn = null;
    if (button) {
      const buttonHost = button.parentElement;
      if (buttonHost) {
        const actionWrap = document.createElement('div');
        actionWrap.className = 'stock-row-actions';
        removeBtn = document.createElement('button');
        removeBtn.type = 'button';
        removeBtn.className = 'btn btn-danger';
        removeBtn.title = 'Remove buy order';
        removeBtn.setAttribute('aria-label', 'Remove buy order');
        removeBtn.innerHTML = '&#128465;';
        buttonHost.replaceChildren();
        actionWrap.appendChild(button);
        actionWrap.appendChild(removeBtn);
        buttonHost.appendChild(actionWrap);
      }

      button.addEventListener('click', (event) => {
        event.stopPropagation();
        applySelectedBuyItem(entry, itemKey);
        renderStoreBuyOrders();
      });
    }
    if (removeBtn) {
      removeBtn.addEventListener('click', (event) => {
        event.stopPropagation();
        const activeStoreId = state.selectedStoreId || document.getElementById('store-existing-select')?.value;
        if (!state.societyId || !activeStoreId || !itemKey) {
          toast('Select a valid buy order first.', 'error');
          return;
        }
        request('society.store.buying.remove', {
          societyId: state.societyId,
          storeId: activeStoreId,
          itemName: itemKey,
        }).then((res) => {
          if (res && res.success && String(state.selectedStoreBuyItem || '') === itemKey) {
            state.selectedStoreBuyItem = '';
            clearSelectedBuyInputs();
          }
        });
        renderStoreBuyOrders();
      });
    }
    row.style.cursor = 'default';
    row.addEventListener('click', () => {
      applySelectedBuyItem(entry, itemKey);
      renderStoreBuyOrders();
    });
    root.appendChild(row);
  }
}

function renderStoreStock() {
  const root = document.getElementById('store-stock-list');
  if (!root) return;
  root.innerHTML = '';
  const selectedStore = (state.stores || []).find((s) => String(s.store_id) === String(state.selectedStoreId || ''));
  if (!selectedStore) {
    state.selectedStoreStockItem = '';
    root.innerHTML = '<div class="muted">Select a store to manage stock.</div>';
    return;
  }
  const catalog = selectedStore.catalog || [];
  if (!catalog.length) {
    state.selectedStoreStockItem = '';
    root.innerHTML = '<div class="muted">No stock loaded in this store.</div>';
    return;
  }

  if (state.selectedStoreStockItem && !catalog.find((entry) => String(entry.item || '') === String(state.selectedStoreStockItem))) {
    state.selectedStoreStockItem = '';
  }

  const applySelectedStockItem = (entry, itemKey) => {
    state.selectedStoreStockItem = itemKey;
    const itemInput = document.getElementById('store-price-item');
    const priceInput = document.getElementById('store-price-value');
    const categoryItemInput = document.getElementById('store-category-item');
    const categoryValueInput = document.getElementById('store-category-value');
    if (itemInput) itemInput.value = resolveDisplayItemLabel(entry);
    if (priceInput) priceInput.value = Number(entry.price || 0);
    if (categoryItemInput) categoryItemInput.value = resolveDisplayItemLabel(entry);
    if (categoryValueInput) categoryValueInput.value = String(entry.category || 'General');
  };

  const clearSelectedStockInputs = () => {
    const itemInput = document.getElementById('store-price-item');
    const priceInput = document.getElementById('store-price-value');
    const categoryItemInput = document.getElementById('store-category-item');
    const categoryValueInput = document.getElementById('store-category-value');
    if (itemInput) itemInput.value = '';
    if (priceInput) priceInput.value = '';
    if (categoryItemInput) categoryItemInput.value = '';
    if (categoryValueInput) categoryValueInput.value = '';
  };

  for (const entry of catalog) {
    const itemKey = String(entry.item || '');
    const isActive = itemKey !== '' && itemKey === String(state.selectedStoreStockItem || '');
    const row = document.createElement('div');
    row.className = 'table-row';
    row.innerHTML = `<span>${resolveDisplayItemLabel(entry)}</span><span>${entry.category || 'General'}</span><span>${Number(entry.qty || 0)} in stock</span><span>${formatCurrency(entry.price || 0)}</span><span><div class="stock-row-actions"><button type="button" class="btn">${isActive ? 'Selected ✓' : 'Select'}</button><button type="button" class="btn btn-danger" title="Remove item from stock" aria-label="Remove item from stock">🗑</button></div></span>`;
    const buttons = row.querySelectorAll('button');
    const selectBtn = buttons[0];
    const removeBtn = buttons[1];
    if (selectBtn) {
      selectBtn.addEventListener('click', (event) => {
        event.stopPropagation();
        applySelectedStockItem(entry, itemKey);
        renderStoreStock();
      });
    }
    if (removeBtn) {
      removeBtn.addEventListener('click', (event) => {
        event.stopPropagation();
        const activeStoreId = state.selectedStoreId || document.getElementById('store-existing-select')?.value;
        if (!state.societyId || !activeStoreId || !itemKey) {
          toast('Select a valid store item first.', 'error');
          return;
        }
        request('society.store.removeStock', {
          societyId: state.societyId,
          storeId: activeStoreId,
          itemName: itemKey,
        }).then((res) => {
          if (res && res.success && String(state.selectedStoreStockItem || '') === itemKey) {
            state.selectedStoreStockItem = '';
            clearSelectedStockInputs();
          }
        });
        renderStoreStock();
      });
    }
    row.style.cursor = 'default';
    row.addEventListener('click', () => {
      applySelectedStockItem(entry, itemKey);
      renderStoreStock();
    });
    root.appendChild(row);
  }
}

function renderStorageMarkerStatus() {
  const status = document.getElementById('storage-marker-status');
  if (!status) return;
  const storage = state.selectedSociety && typeof state.selectedSociety.storage === 'object'
    ? state.selectedSociety.storage
    : null;
  const x = Number(storage && storage.coords && storage.coords.x);
  const y = Number(storage && storage.coords && storage.coords.y);
  const z = Number(storage && storage.coords && storage.coords.z);
  if (Number.isFinite(x) && Number.isFinite(y) && Number.isFinite(z)) {
    status.textContent = `Storage marker: ${x.toFixed(1)}, ${y.toFixed(1)}, ${z.toFixed(1)}`;
    return;
  }
  status.textContent = 'Storage marker: not set';
}

function renderBlips(list = []) {
  const root = document.getElementById('blip-list');
  root.innerHTML = '';
  if (!list.length) {
    root.innerHTML = '<div class="muted">No blips configured yet.</div>';
  }
  for (const b of list || []) {
    const row = document.createElement('div');
    row.className = 'table-row';
    const hasCoords = Number.isFinite(Number(b.coords?.x)) && Number.isFinite(Number(b.coords?.y));
    const enabled = Number(b.enabled) === 1;
    let buttonHtml = '<button type="button" class="btn">Enable</button>';
    if (!hasCoords) {
      buttonHtml = '<button type="button" class="btn" disabled>Set Position First</button>';
    } else if (enabled) {
      buttonHtml = '<button type="button" class="btn btn-danger">Disable</button>';
    }
    row.innerHTML = `<span>${formatActionLabel(b.blip_key || 'blip')}</span><span>${b.label || 'Blip'}</span><span>${enabled ? 'Enabled' : 'Disabled'}</span><span>${hasCoords ? `${Number(b.coords.x).toFixed(1)}, ${Number(b.coords.y).toFixed(1)}` : 'No coords'}</span><span>${buttonHtml}</span>`;
    const button = row.querySelector('button');
    if (button && !button.disabled && hasCoords) {
      button.addEventListener('click', () => {
        if (!state.societyId) {
          toast('No society selected.', 'error');
          return;
        }
        request('society.blip.setEnabled', {
          societyId: state.societyId,
          blipKey: b.blip_key,
          blipId: Number(b.id || 0),
          enabled: !enabled,
        });
      });
    }
    root.appendChild(row);
  }

  const business = getBlipByKey('business');
  const store = getBlipByKey('store');

  document.getElementById('blip-business-label').value = business?.label || 'Business';
  document.getElementById('blip-store-label').value = store?.label || 'Store';
  const businessSearch = document.getElementById('blip-business-search');
  const storeSearch = document.getElementById('blip-store-search');
  if (businessSearch) {
    businessSearch.value = String(state.blipSearch.business || '');
  }
  if (storeSearch) {
    storeSearch.value = String(state.blipSearch.store || '');
  }

  state.selectedBlipSprites.business = Number(business?.sprite || state.selectedBlipSprites.business || DEFAULT_BLIP_SPRITE);
  state.selectedBlipSprites.store = Number(store?.sprite || state.selectedBlipSprites.store || DEFAULT_BLIP_SPRITE);
  renderBlipIconGrid('business');
  renderBlipIconGrid('store');
}

function renderBlipIconGrid(key) {
  const root = document.getElementById(key === 'business' ? 'blip-business-icons' : 'blip-store-icons');
  if (!root) return;
  root.innerHTML = '';
  const selected = Number(state.selectedBlipSprites[key] || 0);
  const query = String((state.blipSearch && state.blipSearch[key]) || '').trim().toLowerCase();
  const filtered = BLIP_ICON_OPTIONS.filter((icon) => {
    if (!query) return true;
    const haystack = `${icon.label} ${icon.key} ${icon.sprite}`.toLowerCase();
    return haystack.includes(query);
  });
  if (!filtered.length) {
    root.innerHTML = '<div class="muted">No matching blips.</div>';
    return;
  }
  for (const icon of filtered) {
    const btn = document.createElement('button');
    btn.type = 'button';
    btn.className = `blip-icon-option ${selected === Number(icon.sprite) ? 'active' : ''}`;
    btn.title = `${icon.label} (${icon.sprite})`;
    const img = document.createElement('img');
    img.src = icon.image || iconPreviewSrc(icon.marker);
    img.alt = icon.label;
    img.loading = 'lazy';
    img.onerror = () => {
      img.onerror = null;
      img.src = iconPreviewSrc(icon.marker);
    };
    const caption = document.createElement('span');
    caption.textContent = icon.label;
    btn.appendChild(img);
    btn.appendChild(caption);
    btn.addEventListener('click', () => {
      state.selectedBlipSprites[key] = Number(icon.sprite);
      renderBlipIconGrid(key);
    });
    root.appendChild(btn);
  }
}

function renderInvoices(list = []) {
  const root = document.getElementById('invoice-list');
  if (!root) return;
  root.innerHTML = '';

  const all = Array.isArray(list) ? list : [];
  const statusFilter = String(state.billingStatusFilter || 'all');
  const filtered = all.filter((row) => statusFilter === 'all' || String(row.status || '').toLowerCase() === statusFilter);

  const openCount = all.filter((x) => String(x.status || '').toLowerCase() === 'open').length;
  const paidCount = all.filter((x) => String(x.status || '').toLowerCase() === 'paid').length;
  const totalAmount = all.reduce((sum, x) => sum + Number(x.amount || 0), 0);
  const paidAmount = all
    .filter((x) => String(x.status || '').toLowerCase() === 'paid')
    .reduce((sum, x) => sum + Number(x.amount || 0), 0);

  const openEl = document.getElementById('billing-open-count');
  const paidEl = document.getElementById('billing-paid-count');
  const totalEl = document.getElementById('billing-total-amount');
  const paidAmountEl = document.getElementById('billing-paid-amount');
  if (openEl) openEl.textContent = String(openCount);
  if (paidEl) paidEl.textContent = String(paidCount);
  if (totalEl) totalEl.textContent = formatCurrency(totalAmount);
  if (paidAmountEl) paidAmountEl.textContent = formatCurrency(paidAmount);

  if (!filtered.length) {
    root.innerHTML = '<div class="muted">No billing records for this filter.</div>';
    return;
  }

  for (const i of filtered) {
    const row = document.createElement('div');
    row.className = 'table-row';
    const society = String(i.society_label || '').trim() || getSocietyLabel(i.society_id);
    const billedTo = String(i.target_name || i.target_char_name || i.target_char_id || '-');
    row.innerHTML = `<span>#${i.id}</span><span>${society}</span><span>To ${billedTo}</span><span>${formatCurrency(i.amount)}</span><span>${formatActionLabel(i.status || '')}</span><span>${i.reason || ''}</span><span>${formatTime(i.created_at)}</span>`;
    root.appendChild(row);
  }
}

function applySocietyState(data = {}) {
  if (data.societies) {
    state.societies = data.societies;
    renderSocietySelect();
    if (state.mode === 'admin') {
      if ((!state.adminSelectedSocietyId || !state.societies.find((s) => String(s.society_id) === String(state.adminSelectedSocietyId))) && state.societies.length > 0) {
        state.adminSelectedSocietyId = state.societies[0].society_id;
      }
      renderAdminSocietyList();
      if (state.adminSelectedSocietyId) {
        const shouldLoad = !data.society || String(data.society.society_id || '') !== String(state.adminSelectedSocietyId);
        selectAdminSociety(state.adminSelectedSocietyId, shouldLoad);
      }
    }
  }
  if (data.publicJobs) {
    state.publicJobs = Array.isArray(data.publicJobs) ? data.publicJobs : [];
    renderJobCenterBoard();
  }
  if (data.society) {
    state.selectedSociety = data.society;
    state.societyId = data.society.society_id;
    const sel = document.getElementById('society-select');
    if (sel) sel.value = state.societyId;
    if (state.mode !== 'admin') {
      applyThemeToUi(state.selectedSociety.theme || DEFAULT_THEME);
    }
    syncPayrollIntervalInput();
  }
  if (data.ledger) {
    document.getElementById('ledger-balance').textContent = formatCurrency(data.ledger.balance || 0);
    document.getElementById('tax-balance').textContent = formatCurrency(data.ledger.taxBalance || 0);
  }
  state.employees = data.employees || state.employees || [];
  state.onlinePlayers = data.onlinePlayers || state.onlinePlayers || [];
  state.invoiceCandidates = data.invoiceCandidates || state.invoiceCandidates || [];
  state.ranks = data.ranks || state.ranks || [];
  state.rankPermissions = data.rankPermissions || state.rankPermissions || [];
  state.stores = data.stores || state.stores || [];
  state.storePropList = data.storePropList || state.storePropList || [];
  if (typeof data.craftingEnabled === 'boolean') {
    state.craftingEnabled = data.craftingEnabled;
  }
  if (typeof data.ingameWebhookEnabled === 'boolean') {
    const changed = state.ingameWebhookEnabled !== data.ingameWebhookEnabled;
    state.ingameWebhookEnabled = data.ingameWebhookEnabled;
    if (changed) {
      renderTabs();
    }
  }
  state.craftingPropList = data.craftingPropList || state.craftingPropList || [];
  state.advertPropList = data.advertPropList || state.advertPropList || [];
  state.adverts = data.adverts || state.adverts || [];
  state.managerInventory = data.managerInventory || state.managerInventory || [];
  state.blips = data.blips || state.blips || [];
  state.transactions = data.transactions || state.transactions || [];
  state.myCharId = data.myCharId || state.myCharId || '';
  if (state.selectedStoreId && !(state.stores || []).find((s) => String(s.store_id) === String(state.selectedStoreId))) {
    state.selectedStoreId = '';
    state.selectedStoreStockItem = '';
    state.selectedStoreBuyItem = '';
  }
  if (state.selectedAdvertId && !(state.adverts || []).find((a) => String(a.advert_id) === String(state.selectedAdvertId))) {
    state.selectedAdvertId = '';
  }
  renderEmployees(state.employees);
  renderOnlinePlayers(state.onlinePlayers);
  renderBillTargets(state.invoiceCandidates);
  renderRanks(state.ranks);
  renderStores(state.stores);
  renderAdverts(state.adverts);
  renderManagerInventory(state.managerInventory);
  renderBlips(state.blips);
  renderJobCenterBoard();
  if (data.invoices) {
    state.invoices = data.invoices;
  }
  if (data.myInvoices) {
    state.myInvoices = data.myInvoices;
  } else {
    state.myInvoices = state.invoices || [];
  }
  if (data.societyInvoices) {
    state.societyInvoices = data.societyInvoices;
  }
  renderInvoices(state.societyInvoices || []);
  renderOverview();
  renderDiscordWebhookSettings();
  syncLedgerAccessControls();
  syncThemeAccessControls();
}

function request(action, data = {}) {
  if (action === 'storefront.buy' || action === 'storefront.sell') {
    const nuiAction = action === 'storefront.sell' ? 'storefrontSell' : 'storefrontBuy';
    return postNui(nuiAction, data).then((res) => {
      if (!res || !res.success) {
        toast(res?.message || (action === 'storefront.sell' ? 'Sale failed' : 'Purchase failed'), 'error');
        return res || { success: false };
      }
      return res;
    });
  }

  const now = Date.now();
  const nextAllowed = Number(requestNextAt[action] || 0);
  if (now < nextAllowed) {
    return Promise.resolve({ success: false, blocked: true, message: '' });
  }
  if (requestInFlight >= MAX_IN_FLIGHT_REQUESTS) {
    return Promise.resolve({ success: false, blocked: true, message: '' });
  }

  requestNextAt[action] = now + REQUEST_COOLDOWN_MS;
  requestInFlight += 1;

  const timeoutPromise = new Promise((resolve) => {
    setTimeout(() => {
      resolve({
        success: false,
        timeout: true,
        message: 'Request timed out. Please try again.',
      });
    }, REQUEST_TIMEOUT_MS);
  });

  return Promise.race([postNui('apiRequest', { action, data }), timeoutPromise])
    .then((res) => {
      if (!res || !res.success) {
        const message = String(res?.message || '').toLowerCase();
        const isRateLimited = message.includes('please wait before trying again') || message.includes('rate limit');
        const isTimeout = res?.timeout === true || message.includes('request timed out');
        if (!res?.blocked && !isRateLimited && !isTimeout) {
          toast(res?.message || 'Request failed', 'error');
        }
        return res || { success: false };
      }
      if (res.data) {
        applySocietyState(res.data);
      }
      if (res.message) {
        toast(res.message, 'success');
      }
      return res;
    })
    .finally(() => {
      requestInFlight = Math.max(0, requestInFlight - 1);
    });
}

function requireSelectedWorker() {
  const target = document.getElementById('target-char').value;
  if (!target) {
    toast('Select a worker first.', 'error');
    return null;
  }
  return target;
}

function forceCloseUi() {
  root.classList.add('hidden');
  postNui('close');
}

document.getElementById('close-btn').addEventListener('click', () => forceCloseUi());
document.getElementById('storefront-close-btn').addEventListener('click', () => closeStorefront());
document.getElementById('crafting-close-btn')?.addEventListener('click', () => closeCrafting());
craftingQuantityInput?.addEventListener('input', () => renderCraftingDetail());
craftingCraftBtn?.addEventListener('click', () => {
  const recipe = getCraftingSelectedRecipe();
  if (!recipe || !craftingData || (craftingBusy && !craftingAllowsMultiple())) return;
  const qty = getCraftingQuantity(recipe);
  if (!recipeCanCraft(recipe, qty)) {
    toast('Missing required ingredients.', 'error');
    renderCraftingDetail();
    return;
  }
  craftingBusy = true;
  renderCraftingDetail();
  postNui('craftingCraft', {
    societyId: String(craftingData.societyId || ''),
    recipeId: String(recipe.id || ''),
    quantity: qty,
  }).then((res) => {
    if (!res?.success) {
      craftingBusy = false;
      renderCraftingDetail();
      if (res?.message) {
        toast(res.message, 'error');
      }
    }
  });
});
document.getElementById('advert-close-btn').addEventListener('click', () => closeAdvert());
document.getElementById('bills-close-btn').addEventListener('click', () => closeBillsWindow());
document.getElementById('bills-refresh-btn').addEventListener('click', () => postNui('billsRefresh', {}));
document.getElementById('invoice-close-btn').addEventListener('click', () => closeInvoiceWindow());
document.getElementById('invoice-refresh-btn').addEventListener('click', () => postNui('invoiceWindowRefresh', {}));
document.getElementById('invoice-send-btn').addEventListener('click', () => {
  const targetCharId = String(invoicePlayerSelect?.value || '').trim();
  const amount = Number(document.getElementById('invoice-amount-input')?.value || 0);
  const reason = String(document.getElementById('invoice-reason-input')?.value || '').trim();

  if (!targetCharId) {
    toast('Select a nearby player first.', 'error');
    return;
  }
  if (!Number.isFinite(amount) || amount <= 0) {
    toast('Enter a valid amount.', 'error');
    return;
  }

  postNui('invoiceWindowCreate', {
    targetCharId,
    amount,
    reason,
    metadata: {
      source: 'invoice_window',
      issuedByName: invoiceWindowState.societyLabel || 'Society',
    },
  });
});
document.getElementById('job-offer-close-btn').addEventListener('click', () => {
  const offerId = String(jobOfferState.offerId || '');
  postNui('jobOfferRespond', { offerId, accept: false });
  closeJobOffer(true);
});
document.getElementById('job-offer-deny-btn').addEventListener('click', () => {
  const offerId = String(jobOfferState.offerId || '');
  postNui('jobOfferRespond', { offerId, accept: false });
  closeJobOffer(true);
});
document.getElementById('job-offer-accept-btn').addEventListener('click', () => {
  const offerId = String(jobOfferState.offerId || '');
  postNui('jobOfferRespond', { offerId, accept: true });
  closeJobOffer(true);
});
document.getElementById('overview-refresh-btn').addEventListener('click', () => {
  if (state.mode === 'jobcenter') {
    request('society.jobCenter.listPublic', {});
  } else if (state.mode === 'admin') {
    if (state.societyId) {
      request('society.open', { societyId: state.societyId });
    } else {
      request('admin.list');
    }
  } else {
    request('society.openCurrent', {});
  }
});
document.getElementById('overview-go-employees').addEventListener('click', () => setPane('employees'));
document.getElementById('overview-go-ranks').addEventListener('click', () => setPane('ranks'));
document.getElementById('overview-go-stores').addEventListener('click', () => setPane('stores'));
document.getElementById('overview-go-admin').addEventListener('click', () => setPane('admin'));
document.getElementById('jobcenter-refresh-btn')?.addEventListener('click', () => {
  request('society.jobCenter.listPublic', {});
});
document.getElementById('deposit-btn').addEventListener('click', () => request('society.ledger.deposit', {
  societyId: state.societyId,
  amount: Number(document.getElementById('amount-input').value || 0),
}));
document.getElementById('withdraw-btn').addEventListener('click', () => request('society.ledger.withdraw', {
  societyId: state.societyId,
  amount: Number(document.getElementById('amount-input').value || 0),
}));
document.getElementById('hire-btn').addEventListener('click', () => {
  const targetCharId = requireSelectedWorker();
  if (!targetCharId) return;
  request('society.hire', {
    societyId: state.societyId,
    targetCharId,
    rankIndex: Number(document.getElementById('target-rank').value || 0),
  });
});
document.getElementById('set-rank-btn').addEventListener('click', () => {
  const targetCharId = requireSelectedWorker();
  if (!targetCharId) return;
  request('society.setRank', {
    societyId: state.societyId,
    targetCharId,
    rankIndex: Number(document.getElementById('target-rank').value || 0),
  });
});
document.getElementById('fire-btn').addEventListener('click', () => {
  const targetCharId = requireSelectedWorker();
  if (!targetCharId) return;
  request('society.fire', {
    societyId: state.societyId,
    targetCharId,
  });
});
document.getElementById('use-online-player-btn').addEventListener('click', () => {
  const select = document.getElementById('online-player-select');
  if (!select || !select.value) {
    toast('Select a worker first.', 'error');
    return;
  }
  const selectedText = select.options[select.selectedIndex]?.textContent || 'Worker';
  setSelectedWorker(select.value, selectedText.replace(/\s-\s.*$/, ''), undefined);
  const billTarget = document.getElementById('bill-target-select');
  if (billTarget && Array.from(billTarget.options).some((o) => String(o.value) === String(select.value))) {
    billTarget.value = String(select.value);
  }
});
document.getElementById('set-rank-count-btn').addEventListener('click', () => {
  const btn = document.getElementById('set-rank-count-btn');
  if (btn.dataset.busy === '1') {
    return;
  }
  btn.dataset.busy = '1';
  btn.disabled = true;
  request('society.setRankCount', {
    societyId: state.societyId,
    rankCount: Number(document.getElementById('rank-count').value || 5),
  }).finally(() => {
    setTimeout(() => {
      btn.dataset.busy = '0';
      btn.disabled = false;
    }, 1200)
  });
});
document.getElementById('set-rank-name-btn').addEventListener('click', () => request('society.setRankName', {
  societyId: state.societyId,
  rankIndex: Number(document.getElementById('rank-index').value || 0),
  rankName: document.getElementById('rank-name').value,
}));
document.getElementById('set-rank-salary-btn').addEventListener('click', () => request('society.setRankSalary', {
  societyId: state.societyId,
  rankIndex: Number(document.getElementById('rank-index').value || 0),
  salary: Number(document.getElementById('rank-salary').value || 0),
}));
document.getElementById('set-payroll-interval-btn').addEventListener('click', () => request('society.setPayrollInterval', {
  societyId: state.societyId,
  minutes: Number(document.getElementById('payroll-interval-minutes').value || 0),
}));
document.getElementById('save-store-btn').addEventListener('click', () => {
  const storeLabel = String(document.getElementById('store-label-input').value || '').trim();
  if (!storeLabel) {
    toast('Enter a store label.', 'error');
    return;
  }
  request('society.store.upsert', {
    societyId: state.societyId,
    store: {
      storeId: '',
      label: storeLabel,
      enabled: true,
    }
  });
});
document.getElementById('store-existing-select').addEventListener('change', (event) => {
  const storeId = String(event.target.value || '');
  state.selectedStoreId = storeId;
  state.selectedStoreStockItem = '';
  state.selectedStoreBuyItem = '';
  const selected = (state.stores || []).find((s) => String(s.store_id) === storeId);
  const labelInput = document.getElementById('store-label-input');
  const propSelect = document.getElementById('store-prop-select');
  if (labelInput) labelInput.value = selected?.label || '';
  if (propSelect) {
    const propValue = String(selected?.prop_model || '').trim();
    if (propValue && !Array.from(propSelect.options).some((opt) => String(opt.value) === propValue)) {
      const legacy = document.createElement('option');
      legacy.value = propValue;
      legacy.textContent = `${propValue} (Legacy)`;
      propSelect.appendChild(legacy);
    }
    propSelect.value = propValue;
  }
  const buyEnabled = document.getElementById('store-buy-enabled');
  if (buyEnabled) buyEnabled.checked = Number(selected?.buy_enabled || 0) === 1;
  renderStoreStock();
  renderStoreBuyOrders();
});
document.getElementById('store-buy-item').addEventListener('change', (event) => {
  const itemName = String(event.target.value || '').trim();
  if (!itemName) return;
  const inventoryRow = (state.managerInventory || []).find((row) => String(row.item || '') === itemName);
  const selectedInput = document.getElementById('store-buy-selected-item');
  if (selectedInput) selectedInput.value = resolveDisplayItemLabel(inventoryRow || { item: itemName, label: itemName });
});
document.getElementById('advert-existing-select').addEventListener('change', (event) => {
  const advertId = String(event.target.value || '');
  state.selectedAdvertId = advertId;
  const selected = (state.adverts || []).find((a) => String(a.advert_id || '') === advertId);
  document.getElementById('advert-title-input').value = selected?.title || '';
  document.getElementById('advert-image-input').value = selected?.image_url || '';
  document.getElementById('advert-description-input').value = selected?.description || '';
  const propSelect = document.getElementById('advert-prop-select');
  if (propSelect) {
    const propValue = String(selected?.prop_model || '').trim();
    if (propValue && !Array.from(propSelect.options).some((opt) => String(opt.value) === propValue)) {
      const legacy = document.createElement('option');
      legacy.value = propValue;
      legacy.textContent = `${propValue} (Legacy)`;
      propSelect.appendChild(legacy);
    }
    propSelect.value = propValue;
  }
});
document.getElementById('store-refresh-inventory-btn').addEventListener('click', () => {
  request('society.store.inventory', { societyId: state.societyId });
});
document.getElementById('store-place-marker-btn').addEventListener('click', () => {
  const storeId = state.selectedStoreId || document.getElementById('store-existing-select').value;
  if (!storeId) {
    toast('Select a store first.', 'error');
    return;
  }
  request('society.store.placeMarker', {
    societyId: state.societyId,
    storeId,
  });
});
document.getElementById('store-set-prop-btn').addEventListener('click', () => {
  const storeId = state.selectedStoreId || document.getElementById('store-existing-select').value;
  if (!storeId) {
    toast('Select a store first.', 'error');
    return;
  }
  const propModel = String(document.getElementById('store-prop-select')?.value || '').trim();
  request('society.store.setProp', {
    societyId: state.societyId,
    storeId,
    propModel,
  });
});
document.getElementById('save-advert-btn').addEventListener('click', () => {
  if (!state.societyId) {
    toast('No society selected.', 'error');
    return;
  }
  const title = String(document.getElementById('advert-title-input').value || '').trim();
  const imageUrl = String(document.getElementById('advert-image-input').value || '').trim();
  const description = String(document.getElementById('advert-description-input').value || '').trim();
  const propModel = String(document.getElementById('advert-prop-select').value || '').trim();
  if (!title) {
    toast('Enter an advertisement title.', 'error');
    return;
  }
  if (!imageUrl) {
    toast('Enter an image URL for the advertisement.', 'error');
    return;
  }
  request('society.advert.upsert', {
    societyId: state.societyId,
    advert: {
      advertId: String(state.selectedAdvertId || document.getElementById('advert-existing-select').value || ''),
      title,
      imageUrl,
      description,
      propModel,
      enabled: true,
    },
  });
});
document.getElementById('advert-place-marker-btn').addEventListener('click', () => {
  if (!state.societyId) {
    toast('No society selected.', 'error');
    return;
  }
  const advertId = String(state.selectedAdvertId || document.getElementById('advert-existing-select').value || '').trim();
  if (!advertId) {
    toast('Select an advertisement first.', 'error');
    return;
  }
  request('society.advert.placeMarker', {
    societyId: state.societyId,
    advertId,
  });
});
document.getElementById('delete-advert-btn').addEventListener('click', () => {
  if (!state.societyId) {
    toast('No society selected.', 'error');
    return;
  }
  const advertId = String(state.selectedAdvertId || document.getElementById('advert-existing-select').value || '').trim();
  if (!advertId) {
    toast('Select an advertisement first.', 'error');
    return;
  }
  request('society.advert.delete', {
    societyId: state.societyId,
    advertId,
  }).then((res) => {
    if (res && res.success) {
      state.selectedAdvertId = '';
    }
  });
});
document.getElementById('storage-place-marker-btn').addEventListener('click', () => {
  if (!state.societyId) {
    toast('No society selected.', 'error');
    return;
  }
  request('society.storage.placeMarker', {
    societyId: state.societyId,
  });
});
document.getElementById('crafting-place-prop-btn')?.addEventListener('click', () => {
  if (state.craftingEnabled === false) {
    toast('Crafting is disabled.', 'error');
    return;
  }
  if (!state.societyId) {
    toast('No society selected.', 'error');
    return;
  }
  const propModel = String(document.getElementById('crafting-prop-select')?.value || '').trim();
  request('society.crafting.placeProp', {
    societyId: state.societyId,
    propModel,
  });
});
document.getElementById('store-add-stock-btn').addEventListener('click', () => {
  const storeId = state.selectedStoreId || document.getElementById('store-existing-select').value;
  if (!storeId) {
    toast('Select a store first.', 'error');
    return;
  }
  const itemName = document.getElementById('store-inventory-item').value;
  const qtyInput = document.getElementById('store-stock-qty');
  const qty = clampStoreQty(Number(qtyInput.value || 0));
  qtyInput.value = String(qty);
  const price = normalizeMoneyInput(document.getElementById('store-stock-price').value);
  const category = String(document.getElementById('store-stock-category').value || '').trim();
  if (!itemName || qty <= 0 || price <= 0) {
    toast('Select an item, quantity, and price.', 'error');
    return;
  }
  request('society.store.addStock', {
    societyId: state.societyId,
    storeId,
    itemName,
    qty,
    price,
    category: category || 'General',
  });
});
document.getElementById('store-set-price-btn').addEventListener('click', () => {
  const storeId = state.selectedStoreId || document.getElementById('store-existing-select').value;
  if (!storeId) {
    toast('Select a store first.', 'error');
    return;
  }
  const itemName = String(state.selectedStoreStockItem || '').trim();
  const price = normalizeMoneyInput(document.getElementById('store-price-value').value);
  if (!itemName || price <= 0) {
    toast('Select a stocked item and enter a new price.', 'error');
    return;
  }
  request('society.store.setPrice', {
    societyId: state.societyId,
    storeId,
    itemName,
    price,
  });
});
document.getElementById('store-set-category-btn').addEventListener('click', () => {
  const storeId = state.selectedStoreId || document.getElementById('store-existing-select').value;
  if (!storeId) {
    toast('Select a store first.', 'error');
    return;
  }
  const itemName = String(state.selectedStoreStockItem || '').trim();
  const category = String(document.getElementById('store-category-value').value || '').trim();
  if (!itemName || !category) {
    toast('Select a stocked item and enter a category.', 'error');
    return;
  }
  request('society.store.setCategory', {
    societyId: state.societyId,
    storeId,
    itemName,
    category,
  });
});
document.getElementById('store-buy-enabled-save-btn').addEventListener('click', () => {
  const storeId = state.selectedStoreId || document.getElementById('store-existing-select').value;
  if (!storeId) {
    toast('Select a store first.', 'error');
    return;
  }
  request('society.store.buying.setEnabled', {
    societyId: state.societyId,
    storeId,
    enabled: document.getElementById('store-buy-enabled').checked === true,
  });
});
document.getElementById('store-buy-upsert-btn').addEventListener('click', () => {
  const storeId = state.selectedStoreId || document.getElementById('store-existing-select').value;
  if (!storeId) {
    toast('Select a store first.', 'error');
    return;
  }
  const itemName = String(document.getElementById('store-buy-item').value || state.selectedStoreBuyItem || '').trim();
  const price = normalizeMoneyInput(document.getElementById('store-buy-price').value);
  const category = String(document.getElementById('store-buy-category').value || '').trim();
  const maxQty = Math.max(0, Number(document.getElementById('store-buy-max-qty').value || 0));
  if (!itemName || price <= 0) {
    toast('Select an item and set a valid buy price.', 'error');
    return;
  }
  request('society.store.buying.upsert', {
    societyId: state.societyId,
    storeId,
    itemName,
    price,
    category: category || 'General',
    maxQty,
  });
});
document.getElementById('store-buy-remove-btn').addEventListener('click', () => {
  const storeId = state.selectedStoreId || document.getElementById('store-existing-select').value;
  if (!storeId) {
    toast('Select a store first.', 'error');
    return;
  }
  const itemName = String(state.selectedStoreBuyItem || '').trim();
  if (!itemName) {
    toast('Select a buy order first.', 'error');
    return;
  }
  request('society.store.buying.remove', {
    societyId: state.societyId,
    storeId,
    itemName,
  }).then((res) => {
    if (res && res.success) {
      state.selectedStoreBuyItem = '';
      const selectedInput = document.getElementById('store-buy-selected-item');
      if (selectedInput) selectedInput.value = '';
    }
  });
});
document.getElementById('delete-store-btn').addEventListener('click', () => {
  const storeId = state.selectedStoreId || document.getElementById('store-existing-select').value;
  if (!storeId) {
    toast('Select a store to delete.', 'error');
    return;
  }
  request('society.store.delete', {
    societyId: state.societyId,
    storeId,
  }).then((res) => {
    if (res.success && state.selectedStoreId === storeId) {
      state.selectedStoreId = '';
      state.selectedStoreStockItem = '';
      state.selectedStoreBuyItem = '';
      document.getElementById('store-price-item').value = '';
      document.getElementById('store-price-value').value = '';
      document.getElementById('store-category-item').value = '';
      document.getElementById('store-category-value').value = '';
      document.getElementById('store-buy-selected-item').value = '';
    }
  });
});
document.getElementById('save-business-blip-btn').addEventListener('click', () => {
  request('society.blip.place', {
    societyId: state.societyId,
    blip: {
      key: 'business',
      label: document.getElementById('blip-business-label').value || 'Business',
      sprite: Number(state.selectedBlipSprites.business || DEFAULT_BLIP_SPRITE),
      enabled: true,
    }
  });
});
document.getElementById('save-store-blip-btn').addEventListener('click', () => {
  request('society.blip.place', {
    societyId: state.societyId,
    blip: {
      key: 'store',
      label: document.getElementById('blip-store-label').value || 'Store',
      sprite: Number(state.selectedBlipSprites.store || DEFAULT_BLIP_SPRITE),
      storeId: String(state.selectedStoreId || ''),
      useStoreMarker: true,
      enabled: true,
    }
  });
});
document.getElementById('save-business-blip-name-btn').addEventListener('click', () => {
  request('society.blip.saveLabel', {
    societyId: state.societyId,
    blip: {
      key: 'business',
      label: document.getElementById('blip-business-label').value || 'Business',
      sprite: Number(state.selectedBlipSprites.business || DEFAULT_BLIP_SPRITE),
    }
  });
});
document.getElementById('save-store-blip-name-btn').addEventListener('click', () => {
  request('society.blip.saveLabel', {
    societyId: state.societyId,
    blip: {
      key: 'store',
      label: document.getElementById('blip-store-label').value || 'Store',
      sprite: Number(state.selectedBlipSprites.store || DEFAULT_BLIP_SPRITE),
      storeId: String(state.selectedStoreId || ''),
    }
  });
});
document.getElementById('blip-business-search').addEventListener('input', (event) => {
  state.blipSearch.business = String(event.target.value || '');
  renderBlipIconGrid('business');
});
document.getElementById('blip-store-search').addEventListener('input', (event) => {
  state.blipSearch.store = String(event.target.value || '');
  renderBlipIconGrid('store');
});
document.getElementById('save-theme-btn').addEventListener('click', () => {
  if (!canCurrentUserManageTheme()) {
    toast('Theme controls are locked for your rank.', 'error');
    return;
  }
  request('society.setTheme', {
    societyId: state.societyId,
    theme: {
      primary: document.getElementById('theme-primary').value,
      secondary: document.getElementById('theme-secondary').value,
      surface: document.getElementById('theme-surface').value,
      surface2: document.getElementById('theme-surface-2').value,
      card: document.getElementById('theme-card').value,
      text: document.getElementById('theme-text').value,
      muted: document.getElementById('theme-muted').value,
      icon: document.getElementById('theme-icon').value,
    }
  });
});
document.getElementById('reset-theme-btn').addEventListener('click', () => {
  if (!canCurrentUserManageTheme()) {
    toast('Theme controls are locked for your rank.', 'error');
    return;
  }
  request('society.setTheme', {
    societyId: state.societyId,
    theme: { ...DEFAULT_THEME },
  });
});
document.getElementById('save-discord-webhook-btn')?.addEventListener('click', () => {
  if (state.ingameWebhookEnabled !== true) {
    toast('Discord webhooks are disabled in config.', 'error');
    return;
  }
  if (!canCurrentUserManageDiscord()) {
    toast('Discord controls are locked for your rank.', 'error');
    return;
  }
  if (!state.societyId) {
    toast('No society selected.', 'error');
    return;
  }

  const channels = {};
  for (const checkbox of document.querySelectorAll('[data-discord-channel]')) {
    channels[String(checkbox.dataset.discordChannel || '')] = checkbox.checked === true;
  }
  request('society.setDiscordWebhook', {
    societyId: state.societyId,
    webhook: {
      enabled: document.getElementById('discord-webhook-enabled')?.checked === true,
      url: String(document.getElementById('discord-webhook-url')?.value || '').trim(),
      channels,
    },
  });
});

const applyThemeFromInputs = () => {
  if (!canCurrentUserManageTheme()) {
    return;
  }
  applyThemeToUi({
    primary: document.getElementById('theme-primary').value,
    secondary: document.getElementById('theme-secondary').value,
    surface: document.getElementById('theme-surface').value,
    surface2: document.getElementById('theme-surface-2').value,
    card: document.getElementById('theme-card').value,
    text: document.getElementById('theme-text').value,
    muted: document.getElementById('theme-muted').value,
    icon: document.getElementById('theme-icon').value,
  });
};

document.getElementById('theme-primary').addEventListener('input', applyThemeFromInputs);
document.getElementById('theme-secondary').addEventListener('input', applyThemeFromInputs);
document.getElementById('theme-surface').addEventListener('input', applyThemeFromInputs);
document.getElementById('theme-surface-2').addEventListener('input', applyThemeFromInputs);
document.getElementById('theme-card').addEventListener('input', applyThemeFromInputs);
document.getElementById('theme-text').addEventListener('input', applyThemeFromInputs);
document.getElementById('theme-muted').addEventListener('input', applyThemeFromInputs);
document.getElementById('theme-icon').addEventListener('change', applyThemeFromInputs);
document.getElementById('theme-preset-target')?.addEventListener('change', (event) => {
  state.themePresetTarget = String(event.target.value || 'theme-primary');
  renderThemePresetColors();
});
['theme-primary', 'theme-secondary', 'theme-surface', 'theme-surface-2', 'theme-card', 'theme-text', 'theme-muted'].forEach((id) => {
  const el = document.getElementById(id);
  if (!el) return;
  el.addEventListener('focus', () => {
    state.themePresetTarget = id;
    const target = document.getElementById('theme-preset-target');
    if (target) target.value = id;
    renderThemePresetColors();
  });
});
document.getElementById('refresh-invoice-btn').addEventListener('click', () => request('society.invoice.society', {
  societyId: state.societyId,
}));
document.getElementById('billing-status-filter')?.addEventListener('change', (event) => {
  state.billingStatusFilter = String(event.target.value || 'all');
  renderInvoices(state.societyInvoices || []);
});
document.getElementById('create-invoice-btn').addEventListener('click', () => {
  const targetFromBills = String(document.getElementById('bill-target-select').value || '');
  const targetFromEmployeeSelection = String(document.getElementById('target-char').value || '');
  const targetCharId = targetFromBills || targetFromEmployeeSelection;
  const amount = Number(document.getElementById('bill-amount').value || 0);
  const reason = String(document.getElementById('bill-reason').value || '').trim();

  if (!state.societyId) {
    toast('No society selected.', 'error');
    return;
  }
  if (!targetCharId) {
    toast('Choose a nearby player to bill.', 'error');
    return;
  }
  if (!Number.isFinite(amount) || amount <= 0) {
    toast('Enter a valid bill amount.', 'error');
    return;
  }

  request('society.invoice.create', {
    societyId: state.societyId,
    targetCharId,
    amount,
    reason,
    metadata: {
      source: 'ui',
      issuedByName: state.selectedSociety?.label || 'Society',
    },
  }).then((res) => {
    if (res && res.success) {
      const amountInput = document.getElementById('bill-amount');
      const reasonInput = document.getElementById('bill-reason');
      if (amountInput) amountInput.value = '';
      if (reasonInput) reasonInput.value = '';
      request('society.invoice.society', { societyId: state.societyId });
    }
  });
});
document.getElementById('admin-create-btn').addEventListener('click', () => request('admin.createSociety', {
  jobName: document.getElementById('admin-job-name').value,
  label: document.getElementById('admin-label').value,
  bossGrade: Number(document.getElementById('admin-boss-grade').value || 3),
  isPublic: false,
  entryGrade: 0,
}));

document.getElementById('admin-save-btn')?.addEventListener('click', () => {
  if (!state.adminSelectedSocietyId) {
    toast('Select a society first.', 'error');
    return;
  }
  request('admin.updateSociety', {
    societyId: state.adminSelectedSocietyId,
    label: document.getElementById('admin-edit-label').value,
    entryGrade: Number(document.getElementById('admin-edit-entry-grade').value || 0),
    bossGrade: Number(document.getElementById('admin-edit-boss-grade').value || 3),
    taxPercent: Number(document.getElementById('admin-edit-tax').value || 0),
    isPublic: document.getElementById('admin-edit-public').checked === true,
  });
});

document.getElementById('admin-delete-btn')?.addEventListener('click', () => {
  if (!state.adminSelectedSocietyId) {
    toast('Select a society first.', 'error');
    return;
  }
  const selectedId = state.adminSelectedSocietyId;
  request('admin.deleteSociety', {
    societyId: selectedId,
  }).then((res) => {
    if (res.success) {
      if (state.adminSelectedSocietyId === selectedId) {
        state.adminSelectedSocietyId = '';
      }
      request('admin.list');
    }
  });
});

window.addEventListener('keydown', (event) => {
  if (event.key === 'Escape') {
    event.preventDefault();
    if (billsWindowOpen) {
      closeBillsWindow();
    } else if (invoiceWindowOpen) {
      closeInvoiceWindow();
    } else if (jobOfferOpen) {
      const offerId = String(jobOfferState.offerId || '');
      postNui('jobOfferRespond', { offerId, accept: false });
      closeJobOffer(true);
    } else if (craftingOpen) {
      closeCrafting();
    } else if (storefrontOpen) {
      closeStorefront();
    } else if (advertOpen) {
      closeAdvert();
    } else {
      forceCloseUi();
    }
  }
});

window.addEventListener('message', (event) => {
  const msg = event.data || {};
  if (msg.action === 'setVisible') {
    if (msg.visible) {
      if (msg.storeQtyBounds) {
        state.storeQtyBounds = normalizeStoreQtyBounds(msg.storeQtyBounds);
      }
      applyStoreQtyInputBounds();
      if (Array.isArray(msg.themePresets)) {
        state.themePresetColors = normalizeThemePresetColors(msg.themePresets);
      }
      if (billsWindowOpen) {
        closeBillsWindow(true);
      }
      if (invoiceWindowOpen) {
        closeInvoiceWindow(true);
      }
      if (craftingOpen) {
        closeCrafting(true);
      }
      applyThemeToUi(msg.theme || DEFAULT_THEME);
      renderThemePresetColors();
    }
    root.classList.toggle('hidden', !msg.visible);
    if (!msg.visible) {
      requestInFlight = 0;
      if (storefrontOpen) {
        closeStorefront(true);
      }
      if (craftingOpen) {
        closeCrafting(true);
      }
      if (advertOpen) {
        closeAdvert(true);
      }
      if (invoiceWindowOpen) {
        closeInvoiceWindow(true);
      }
      if (jobOfferOpen) {
        closeJobOffer(true);
      }
    }
    state.mode = msg.mode || 'society';
    if (state.mode === 'jobcenter') {
      state.societyId = '';
      state.selectedSociety = null;
    }
    renderTabs();
    syncThemeAccessControls();
    if (state.mode === 'jobcenter') {
      request('society.jobCenter.listPublic', {});
    } else if (state.mode !== 'admin') {
      request('society.openCurrent', {});
    } else {
      request('admin.list');
    }
    renderOverview();
  } else if (msg.action === 'openPayload') {
    state.societyId = msg.payload?.societyId || state.societyId;
  } else if (msg.action === 'apiResponse') {
    const payload = msg.payload || {};
    if (payload.success && payload.data) {
      applySocietyState(payload.data);
    }
  } else if (msg.action === 'notify') {
    toast(msg.message, msg.kind || 'info');
  } else if (msg.action === 'showInvoices') {
    state.invoices = msg.invoices || [];
    state.myInvoices = state.invoices;
    openBillsWindow(state.myInvoices);
  } else if (msg.action === 'openBillsWindow') {
    state.invoices = msg.invoices || [];
    state.myInvoices = state.invoices;
    openBillsWindow(state.myInvoices);
  } else if (msg.action === 'updateBillsWindow') {
    state.invoices = msg.invoices || [];
    state.myInvoices = state.invoices;
    renderBillsWindow(state.myInvoices);
  } else if (msg.action === 'closeBillsWindow') {
    closeBillsWindow(true);
  } else if (msg.action === 'openInvoiceWindow') {
    openInvoiceWindow(msg.payload || {});
  } else if (msg.action === 'updateInvoiceWindow') {
    updateInvoiceWindow(msg.payload || {});
  } else if (msg.action === 'closeInvoiceWindow') {
    closeInvoiceWindow(true);
  } else if (msg.action === 'openJobOffer') {
    openJobOffer(msg.payload || {});
  } else if (msg.action === 'closeJobOffer') {
    const incomingId = String(msg.offerId || '');
    if (!incomingId || incomingId === String(jobOfferState.offerId || '')) {
      closeJobOffer(true);
    }
  } else if (msg.action === 'openStorefront') {
    openStorefront(msg.payload || {});
  } else if (msg.action === 'closeStorefront') {
    closeStorefront(true);
  } else if (msg.action === 'openCrafting') {
    openCrafting(msg.payload || {});
  } else if (msg.action === 'closeCrafting') {
    closeCrafting(true);
  } else if (msg.action === 'craftingProgress') {
    startCraftingProgress(msg.payload || {});
  } else if (msg.action === 'craftingProgressDone') {
    finishCraftingProgress(msg.payload || {});
  } else if (msg.action === 'updateCrafting') {
    updateCrafting(msg.payload || {});
  } else if (msg.action === 'openAdvert') {
    openAdvert(msg.payload || {});
  } else if (msg.action === 'closeAdvert') {
    closeAdvert(true);
  }
});

renderThemePresetColors();
applyThemeToUi(DEFAULT_THEME);
applyStoreQtyInputBounds();
