'use strict';

// Helper global de tradução
const t = (key) => (typeof Translate !== 'undefined' && Translate[key]) ? Translate[key] : key;

/* ─────────────────────────────────────────────────────────────────
   Helpers
───────────────────────────────────────────────────────────────── */
function nuiFetch(endpoint, data) {
    return fetch(`https://btc-ranchman/${endpoint}`, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json; charset=UTF-8' },
        body: JSON.stringify(data || {})
    }).catch(e => console.error('[btc-ranchman NUI]', endpoint, e));
}
/* Helpers originais... */
const GRADE_LABELS = [t('grade_0'), t('grade_1'), t('grade_2'), t('grade_3')];

function gradeLabel(g) {
    return GRADE_LABELS[g] || t('grade_0');
}

function choreClass(val) {
    if (val >= 70) return 'high';
    if (val >= 35) return 'medium';
    return 'low';
}
function threatClass(val) {
    if (val >= 70) return 'high';
    if (val >= 35) return 'medium';
    return 'low';
}

function formatMoney(v) {
    return '$' + Number(v || 0).toLocaleString('pt-BR');
}

/* Componente reutilizável de tooltip "?" */
const InfoTip = {
    props: ['text'],
    template: `<span class="info-tip-icon">?<span class="info-tip-box">{{ text }}</span></span>`
};

/* ─────────────────────────────────────────────────────────────────
   Componentes inline
───────────────────────────────────────────────────────────────── */

// ── Aba: Visão Geral ──────────────────────────────────────────────
// [REESTRUTURAÇÃO] chores agora é { AnimalType: { poop, hay, repair, water } }.
// Overview mostra seção por tipo de animal com seus 4 chores individuais.
// startChore envia animalType para que o Lua saiba qual área atualizar.
const CHORE_DEFS = [
    { key: 'poop',   label: t('chore_poop'),   icon: 'fa-solid fa-poo',        tip: t('tip_chore_poop') },
    { key: 'hay',    label: t('chore_hay'),    icon: 'fa-solid fa-wheat-awn',  tip: t('tip_chore_hay') },
    { key: 'repair', label: t('chore_repair'), icon: 'fa-solid fa-hammer',     tip: t('tip_chore_repair') },
    { key: 'water',  label: t('chore_water'),  icon: 'fa-solid fa-bucket',     tip: t('tip_chore_water') },
];

const TabOverview = {
    props: ['ranch', 'animals', 'employeeGrade', 'flags', 'animalConfigs'],
    emits: ['action'],
    data() {
        return {
            webhookInput: '',
            collapsedCategories: {},
            protectionModal: false,
            protectionPct:   5,
        };
    },
    computed: {
        // Retorna array de { animalType, chores: [{key, label, icon, val}] }
        choresByType() {
            const raw = (this.ranch && this.ranch.chores) || {};
            const rawTroughs = (this.ranch && this.ranch.troughs) || {};
            const animalConfigs = this.animalConfigs || {};
            const result = [];

            // Formato novo: keys são tipos de animal
            for (const [animalType, typeChores] of Object.entries(raw)) {
                if (typeof typeChores !== 'object') continue;

                const troughData = rawTroughs[animalType];
                let troughInfo = null;
                if (troughData) {
                    const config = animalConfigs[animalType] || {};
                    const upgradeLevel = troughData.upgradeLevel || 0;
                    const baseCapacity = config.TroughCapacity || 500;
                    const capacity = upgradeLevel > 0 ? baseCapacity * Math.pow(2, upgradeLevel) : baseCapacity;
                    const units = troughData.totalUnits || 0;
                    troughInfo = {
                        units: units,
                        capacity: capacity,
                        percent: capacity > 0 ? Math.min((units / capacity) * 100, 100) : 0,
                    };
                }

                result.push({
                    animalType,
                    chores: CHORE_DEFS.map(d => ({
                        ...d,
                        val: typeChores[d.key] || 0,
                    })),
                    trough: troughInfo,
                });
            }
            return result.sort((a, b) => a.animalType.localeCompare(b.animalType));
        },
        animalCount() { return Object.keys(this.animals || {}).length; },
        canLeave()      { return this.ranch && this.ranch.allowLeave; },
        showInventory() { return !(this.flags && this.flags.disableInventory); },
        maxAnimals() {
            if (this.ranch && (this.ranch.maxAnimals || this.ranch.maxAnimals === 0)) {
                return this.ranch.maxAnimals;
            }
            return false;
        },
        showWebhook()   { return this.employeeGrade >= 3 && this.flags && this.flags.showWebhook; },
        protectionCost() {
            return (this.protectionPct || 0) * ((this.flags && this.flags.protectionCostPerPct) || 0);
        },
        canAffordProtection() {
            return this.ranch && (this.ranch.money || 0) >= this.protectionCost;
        },
    },
    watch: {
        'ranch.webhook': {
            immediate: true,
            handler(v) { this.webhookInput = v || ''; }
        }
    },
    methods: {
        t,
        choreClass,
        threatClass,
        emit(action, payload) { this.$emit('action', { action, ...payload }); },
        saveWebhook() {
            this.$emit('action', { action: 'updateWebhook', webhook: this.webhookInput });
        },
        iconUrl(type) {
            return `../images/${type}_Male.png`;
        },
        toggleCategory(type) {
            this.collapsedCategories[type] = !this.isCategoryCollapsed(type);
        },
        isCategoryCollapsed(type) {
            return this.collapsedCategories[type] ?? true;
        },
        openProtectionModal() {
            this.protectionPct = (this.flags && this.flags.protectionMinReduction) || 5;
            this.protectionModal = true;
        },
        confirmProtection() {
            this.$emit('action', { action: 'payProtection', amount: this.protectionPct });
            this.protectionModal = false;
        },
    },
    template: `
    <div>
        <div class="cards-row">
            <div class="info-card">
                <div class="card-label">{{ t('total_animals') }} <info-tip :text="t('tip_total_animals')"></info-tip></div>
                <div class="card-value" v-if="maxAnimals !== false">{{ animalCount }} / {{ maxAnimals }}</div>
                <div class="card-value" v-else>{{ animalCount }}</div>
            </div>
        </div>

        <div class="divider"></div>

        <!-- Tarefas por tipo de animal -->
        <div class="section-title" v-if="choresByType.length > 0">{{ t('animal_pastures') }} <info-tip :text="t('tip_animal_pastures')"></info-tip></div>
        <div v-if="choresByType.length === 0" class="section-title" style="opacity:0.5">{{ t('no_areas') }}</div>
        <template v-for="group in choresByType" :key="group.animalType">
            <div class="section-title">
                <img :src="iconUrl(group.animalType)" class="section-title-icon" @error="$event.target.style.display='none'">
                <span>{{ t(group.animalType) }}</span>
                <button class="animal-action-btn" style="margin-left: auto;" @click="toggleCategory(group.animalType)">
                    {{ isCategoryCollapsed(group.animalType) ? '▼' : '▲' }}
                </button>
            </div>
            <div v-if="!isCategoryCollapsed(group.animalType)">
                <div class="chores-grid">
                    <div class="chore-row" v-for="c in group.chores" :key="c.key">
                        <div class="chore-header">
                            <span><i :class="c.icon" class="chore-icon"></i> {{ c.label }} <info-tip :text="c.tip"></info-tip></span>
                            <span>{{ c.val.toFixed(1) }} / 100</span>
                        </div>
                        <div class="chore-bar-bg">
                            <div class="chore-bar-fill" :class="choreClass(c.val)" :style="{ width: Math.min(c.val, 100) + '%' }"></div>
                        </div>
                    </div>
                </div>
                <div class="chore-row-single" v-if="group.trough">
                    <div class="chore-header">
                        <span><i class="fa-solid fa-utensils chore-icon"></i> {{ t('trough_title') }} <info-tip :text="t('tip_trough')"></info-tip></span>
                        <span>{{ group.trough.units.toFixed(0) }} / {{ group.trough.capacity }}</span>
                    </div>
                    <div class="chore-bar-bg">
                        <div class="chore-bar-fill" :class="choreClass(group.trough.percent)" :style="{ width: group.trough.percent + '%' }"></div>
                    </div>
                </div>
            </div>
            <div class="divider" v-if="!isCategoryCollapsed(group.animalType)"></div>
        </template>

        <!-- Barra de Ameaça (raid) — só exibida se raids estão habilitados -->
        <div class="threat-section" v-if="flags && flags.raidsEnabled && ranch">
            <div class="chore-row-single">
                <div class="chore-header">
                    <span class="label-tip-wrap">
                        {{ t('threat_level') }}
                        <info-tip :text="t('threat_tooltip')"></info-tip>
                    </span>
                    <span>{{ (ranch.threatLevel || 0).toFixed(1) }}%</span>
                </div>
                <div class="chore-bar-bg">
                    <div class="chore-bar-fill"
                         :class="threatClass(ranch.threatLevel || 0)"
                         :style="{ width: Math.min(ranch.threatLevel || 0, 100) + '%' }">
                    </div>
                </div>
            </div>
            <div v-if="flags.protectionEnabled && (ranch.threatLevel || 0) > 0" class="protection-row">
                <span class="protection-cost">
                    {{ t('pay_protection') }}
                    <info-tip :text="t('tip_pay_protection')"></info-tip>
                </span>
                <button class="action-btn warning" @click="openProtectionModal()">
                    {{ t('pay_protection') }}
                </button>
            </div>
        </div>

        <!-- Modal de Proteção -->
        <div v-if="protectionModal" style="position:fixed;top:0;left:0;width:100%;height:100%;background:rgba(0,0,0,0.88);z-index:1000;display:flex;align-items:center;justify-content:center;" @click.self="protectionModal = false">
            <div style="background:#181a1b;padding:1.5rem;border-radius:8px;border:1px solid rgba(255,255,255,0.12);width:22rem;max-width:90%;">
                <h2 style="margin:0 0 1.2rem;color:#e8b84b;font-family:'crock',serif;font-size:1.1rem;text-align:center;letter-spacing:0.5px;">{{ t('pay_protection') }}</h2>

                <div style="margin-bottom:1rem;">
                    <div style="display:flex;justify-content:space-between;font-size:0.82rem;color:rgba(255,255,255,0.6);margin-bottom:0.4rem;">
                        <span>{{ t('protection_reduce') }}</span>
                        <strong style="color:#fff">{{ protectionPct }}%</strong>
                    </div>
                    <input type="range"
                           :min="flags.protectionMinReduction || 5"
                           :max="flags.protectionReduction || 30"
                           step="1"
                           v-model.number="protectionPct"
                           style="width:100%;accent-color:#e8b84b;cursor:pointer;">
                    <div style="display:flex;justify-content:space-between;font-size:0.7rem;color:rgba(255,255,255,0.3);margin-top:0.2rem;">
                        <span>{{ flags.protectionMinReduction || 5 }}%</span>
                        <span>{{ flags.protectionReduction || 30 }}%</span>
                    </div>
                </div>

                <div style="background:rgba(255,255,255,0.05);border-radius:4px;padding:0.65rem 0.8rem;margin-bottom:1.1rem;">
                    <div style="display:flex;justify-content:space-between;font-size:0.85rem;margin-bottom:0.3rem;">
                        <span style="color:rgba(255,255,255,0.55);">{{ t('protection_cost_label') }}</span>
                        <strong :style="{ color: canAffordProtection ? '#7ec87e' : '#e05252' }">
                            {{ '$' + protectionCost.toLocaleString('pt-BR') }}
                        </strong>
                    </div>
                    <div style="display:flex;justify-content:space-between;font-size:0.8rem;color:rgba(255,255,255,0.4);">
                        <span>{{ t('ranch_cash') }}</span>
                        <span>{{ '$' + ((ranch && ranch.money) || 0).toLocaleString('pt-BR') }}</span>
                    </div>
                </div>

                <div v-if="!canAffordProtection" style="font-size:0.78rem;color:#e05252;margin-bottom:0.75rem;text-align:center;">
                    {{ t('insufficient_funds') }}
                </div>

                <div class="actions-row">
                    <button class="action-btn warning" :disabled="!canAffordProtection" @click="confirmProtection()">
                        {{ t('pay_protection') }}
                    </button>
                    <button class="action-btn" @click="protectionModal = false">{{ t('cancel') }}</button>
                </div>
            </div>
        </div>

        <!-- Webhook (grade ≥ 3) -->
        <div v-if="showWebhook" style="margin-bottom:1rem">
            <div class="section-title" style="font-size:1rem;margin-bottom:0.5rem">{{ t('ranch_webhook') }}</div>
            <div class="finance-input-row">
                <input class="finance-input" type="text" v-model="webhookInput" maxlength="500" placeholder="https://discord.com/api/webhooks/...">
                <button class="action-btn" @click="saveWebhook">{{ t('save') }}</button>
            </div>
        </div>

        <div class="actions-row">
            <button class="action-btn primary" v-if="showInventory" @click="emit('openInventory', {})">{{ t('ranch_inventory') }}</button>
            <button class="action-btn danger" v-if="canLeave" @click="emit('leaveRanch', {})">{{ t('leave_ranch') }}</button>
        </div>
    </div>
    `
};

// ── Aba: Animais ──────────────────────────────────────────────────
// Navegação em 2 níveis + paginação para suportar centenas/milhares de animais.
// Nível 1: lista de tipos com contagem  →  Nível 2: animais do tipo (15/página)
const PAGE_SIZE = 15;

const TabAnimals = {
    props: ['animals', 'animalTypes', 'ranchId', 'employeeGrade', 'animalConfigs'],
    emits: ['action'],
    data() {
        return {
            selectedType: null,
            page: 0,
            renameId: null,
            renameVal: '',
            breedingAnimal: null,
        };
    },
    computed: {
        grouped() {
            const groups = {};
            const raw = this.animals;
            if (!raw || typeof raw !== 'object') return groups;
            Object.entries(raw).forEach(([id, data]) => {
                const t = data.type || t('others');
                if (!groups[t]) groups[t] = [];
                groups[t].push({ _id: id, ...data });
            });
            return groups;
        },
        // Todos os tipos (da config) marcados como empty ou não
        typeSummary() {
            const all = this.animalTypes.length > 0
                ? [...this.animalTypes]
                : Object.keys(this.grouped);
            return all.map(type => {
                const list = this.grouped[type] || [];
                const females = list.filter(a => a.sex === 'Female');
                return {
                    type,
                    count:    list.length,
                    females:  females.length,
                    males:    list.length - females.length,
                    pregnant: females.filter(a => a.pregnancy && a.pregnancy > 0).length,
                    empty:    list.length === 0,
                };
            }).sort((a, b) => a.type.localeCompare(b.type));
        },
        currentList() {
            return this.selectedType ? (this.grouped[this.selectedType] || []) : [];
        },
        totalPages() {
            return Math.ceil(this.currentList.length / PAGE_SIZE);
        },
        pageItems() {
            const start = this.page * PAGE_SIZE;
            return this.currentList.slice(start, start + PAGE_SIZE);
        },
    },
    watch: {
        selectedType() { this.page = 0; this.renameId = null; this.renameVal = ''; },
    },
    methods: {
        t,
        selectType(type) { this.selectedType = type; },
        goBack()         { this.selectedType = null; },
        prevPage()       { if (this.page > 0) this.page--; },
        nextPage()       { if (this.page < this.totalPages - 1) this.page++; },
        iconUrl(type, sex) {
            const g = sex === 'Female' ? 'Female' : 'Male';
            return `../images/${type}_${g}.png`;
        },
        isFemale(a)    { return a.sex === 'Female'; },
        isPregnant(a)  { return a.pregnancy && a.pregnancy > 0; },
        canBreed(a) {
            if (a.sex !== 'Female') return false;
            const config = this.animalConfigs && this.animalConfigs[a.type];
            if (config && config.EggLaying) return false;
            if (!config || !config.FertilAge) return false;
            return a.age >= config.FertilAge && (!a.pregnancy || a.pregnancy === 0);
        },
        availableMales(female) {
            if (!female) return [];
            const list = this.animals ? Object.entries(this.animals).map(([id, d]) => ({ _id: id, ...d })) : [];
            const config = this.animalConfigs && this.animalConfigs[female.type];
            const fertilAge = config ? config.FertilAge : 0;
            return list.filter(a => a.type === female.type && a.sex === 'Male' && a.age >= fertilAge);
        },
        isMaleOnCooldown(m) {
            if (!m.lastBreedingAttempt) return false;
            const cooldownMins = (this.animalConfigs && this.animalConfigs.Rate && this.animalConfigs.Rate.maleBreedingCooldown) || 10;
            const cooldownSecs = cooldownMins * 60;
            const now = Math.floor(Date.now() / 1000);
            return (now - m.lastBreedingAttempt) < cooldownSecs;
        },
        maleCooldownPercent(m) {
            if (!m.lastBreedingAttempt) return 100;
            const cooldownMins = (this.animalConfigs && this.animalConfigs.Rate && this.animalConfigs.Rate.maleBreedingCooldown) || 10;
            const cooldownSecs = cooldownMins * 60;
            const now = Math.floor(Date.now() / 1000);
            const elapsed = now - m.lastBreedingAttempt;
            if (elapsed >= cooldownSecs) return 100;
            return Math.floor((elapsed / cooldownSecs) * 100);
        },
        startPregnancy(a) {
            this.breedingAnimal = a;
        },
        confirmBreed(maleId) {
            if (maleId && this.breedingAnimal) {
                this.$emit('action', { action: 'startBreeding', animalId: this.breedingAnimal._id, maleId: maleId });
                this.breedingAnimal = null;
            }
        },
        cancelBreed() {
            this.breedingAnimal = null;
        },
        pregnancyPercent(a) {
            const config = this.animalConfigs && this.animalConfigs[a.type];
            const max = (config && config.MaxStats && config.MaxStats.pregnancy) || 100;
            return Math.min(((a.pregnancy || 0) / max) * 100, 100);
        },
        isGrowing(a) {
            const config = this.animalConfigs && this.animalConfigs[a.type];
            if (!config || !config.FertilAge) return false;
            return a.age != null && a.age < config.FertilAge;
        },
        growingPercent(a) {
            const config = this.animalConfigs && this.animalConfigs[a.type];
            const fertilAge = (config && config.FertilAge) || 1;
            return Math.min(((a.age || 0) / fertilAge) * 100, 100);
        },
        toggleRename(a) {
            if (this.renameId === a._id) { this.renameId = null; this.renameVal = ''; }
            else { this.renameId = a._id; this.renameVal = a.name || ''; }
        },
        confirmRename(a) {
            const name = this.renameVal.trim();
            if (name) this.$emit('action', { action: 'renameAnimal', animalId: a._id, name });
            this.renameId = null; this.renameVal = '';
        },
    },
    template: `
    <div>

        <!-- ── Nível 1: cards de categoria ── -->
        <div v-if="!selectedType">
            <div class="animal-types-grid">
                <div
                    v-for="s in typeSummary" :key="s.type"
                    class="animal-type-card"
                    :class="{ empty: s.empty }"
                    @click="!s.empty && selectType(s.type)"
                >
                    <img class="animal-type-card-icon" :src="iconUrl(s.type, 'Male')" :alt="s.type" @error="$event.target.style.display='none'">
                    <div class="animal-type-card-name">{{ s.type }}</div>
                    <div class="animal-type-card-count" v-if="!s.empty">{{ s.count }}</div>
                    <div class="animal-type-card-meta" v-if="!s.empty">
                        <div v-if="s.females > 0">
                            {{ t('females') }}: {{ s.females }}
                            <span v-if="s.pregnant > 0"> ({{ s.pregnant }} {{ t('pregnant') }})</span>
                        </div>
                        <div v-if="s.males > 0">{{ t('males') }}: {{ s.males }}</div>
                    </div>
                    <div class="animal-type-card-empty" v-else>{{ t('empty') }}</div>
                </div>
            </div>
        </div>

        <!-- ── Nível 2: cards de animais ── -->
        <div v-else>
            <div class="animals-nav-row">
                <button class="action-btn" @click="goBack()">‹ {{ t('back') }}</button>
                <span class="animals-nav-title">{{ selectedType }} ({{ currentList.length }})</span>
                <div class="animals-nav-pages" v-if="totalPages > 1">
                    <button class="animal-action-btn" :disabled="page === 0" @click="prevPage()">‹</button>
                    <span style="font-size:0.78rem;color:rgba(255,255,255,0.55)">{{ page + 1 }} / {{ totalPages }}</span>
                    <button class="animal-action-btn" :disabled="page >= totalPages - 1" @click="nextPage()">›</button>
                </div>
            </div>

            <div class="animal-cards-grid">
                <div class="animal-card" v-for="a in pageItems" :key="a._id">
                    <div class="animal-card-top">
                        <img class="animal-card-icon" :src="iconUrl(a.type, a.sex)" :alt="a.type" @error="$event.target.style.display='none'">
                        <div class="animal-card-name">{{ a.name || a.type }}</div>
                        <button class="animal-icon-btn" :title="t('rename')" @click="toggleRename(a)">
                            <i class="fa-solid fa-pen"></i>
                        </button>
                    </div>
                    <div class="animal-card-badges">
                        <span class="animal-badge">{{ isFemale(a) ? t('female') : t('male') }}</span>
                        <span class="animal-badge mark" v-if="a.mark">{{ t('marked') }}</span>
                        <span class="animal-badge pregnant" v-if="isPregnant(a)">{{ t('pregnant') }}</span>
                    </div>
                    <div class="animal-card-stats">
                        <span class="stat-tip" :data-tip="t('stat_health')"       v-if="a.health    != null"><i class="fa-solid fa-heart"        style="color:#e05252"></i> {{ Math.floor(a.health) }}%</span>
                        <span class="stat-tip" :data-tip="t('stat_hunger')"        v-if="a.hungry    != null"><i class="fa-solid fa-bowl-food"    style="color:#e8b84b"></i> {{ Math.floor(a.hungry) }}%</span>
                        <span class="stat-tip" :data-tip="t('stat_weight')"        v-if="a.weight    != null"><i class="fa-solid fa-weight-scale" style="color:rgba(255,255,255,0.4)"></i> {{ Math.floor(a.weight) }}</span>
                        <span class="stat-tip" :data-tip="t('stat_fertility')" v-if="a.fertility != null"><i class="fa-solid fa-seedling"     style="color:#a0d0a0"></i> {{ Math.floor(a.fertility) }}%</span>
                        <span class="stat-tip" :data-tip="t('stat_age')"       v-if="a.age       != null"><i class="fa-solid fa-hourglass-half" style="color:rgba(255,255,255,0.35)"></i> {{ Math.floor(a.age) }}</span>
                    </div>
                    <div class="animal-card-pregnancy" v-if="isPregnant(a)">
                        <div style="display:flex; justify-content:space-between; font-size:0.72rem; color:rgba(160,200,255,0.85); margin-bottom:0.35rem;">
                            <span>{{ t('gestation') }} <info-tip :text="t('tip_gestation')"></info-tip></span>
                            <span>{{ Math.floor(pregnancyPercent(a)) }}%</span>
                        </div>
                        <div class="pregnancy-bar-bg">
                            <div class="pregnancy-bar-fill" :style="{ width: pregnancyPercent(a) + '%' }"></div>
                        </div>
                    </div>
                    <div class="animal-card-pregnancy" v-if="isGrowing(a)">
                        <div style="display:flex; justify-content:space-between; font-size:0.72rem; color:rgba(160,208,160,0.85); margin-bottom:0.35rem;">
                            <span>{{ t('growing') }} <info-tip :text="t('tip_growing')"></info-tip></span>
                            <span>{{ Math.floor(growingPercent(a)) }}%</span>
                        </div>
                        <div class="growing-bar-bg">
                            <div class="growing-bar-fill" :style="{ width: growingPercent(a) + '%' }"></div>
                        </div>
                    </div>
                    <div class="rename-row" v-if="renameId === a._id">
                        <input class="rename-input" v-model="renameVal" maxlength="40" :placeholder="t('new_name_placeholder')" @keyup.enter="confirmRename(a)" @keyup.escape="renameId = null">
                        <button class="animal-action-btn" style="color:#a0d0a0" @click="confirmRename(a)">{{ t('ok') }}</button>
                        <button class="animal-action-btn" @click="renameId = null">✕</button>
                    </div>
                </div>
            </div>

        </div>

    </div>
    `
};

// ── Aba: Funcionários ─────────────────────────────────────────────
const TabEmployees = {
    props: ['employees', 'ranchId', 'employeeGrade', 'ownerId', 'flags'],
    emits: ['action'],
    computed: {
        canManage()   { return this.employeeGrade >= 2 && !(this.flags && this.flags.disableEmployees); },
        canTransfer() { return this.employeeGrade >= 3 && !(this.flags && this.flags.notAllowTransfer); },
    },
    methods: {
        t,
        gradeLabel,
        isOwner(emp)    { return emp.grade >= 3 || emp.citizenid === this.ownerId; },
        canPromote(emp) { return this.employeeGrade >= 3 && emp.grade < 3 && !this.isOwner(emp); },
        canDemote(emp)  { return this.employeeGrade >= 3 && emp.grade > 0 && emp.citizenid !== this.ownerId; },
        canFire(emp)    { return this.employeeGrade >= 2 && emp.citizenid !== this.ownerId && (this.employeeGrade >= 3 || emp.grade < this.employeeGrade); },
        promote(emp) { this.$emit('action', { action: 'updateGrade', targetId: emp.citizenid, grade: emp.grade + 1 }); },
        demote(emp)  { this.$emit('action', { action: 'updateGrade', targetId: emp.citizenid, grade: emp.grade - 1 }); },
        fire(emp)    { this.$emit('action', { action: 'fireEmployee', targetId: emp.citizenid }); },
        hire()       { this.$emit('action', { action: 'hireEmployee' }); },
        transfer()   { this.$emit('action', { action: 'transferRanch' }); },
    },
    template: `
    <div>
        <div v-if="!employees || employees.length === 0" class="empty-state">{{ t('no_employees') }}</div>
        <div class="employee-item" v-for="emp in employees" :key="emp.citizenid">
            <div class="employee-name">{{ emp.firstname }} {{ emp.lastname }}</div>
            <span class="employee-grade-badge" :class="{ owner: isOwner(emp) }">{{ gradeLabel(emp.grade) }}</span>
            <div class="employee-actions">
                <button class="animal-action-btn" style="color:#a0d0a0" v-if="canPromote(emp)" @click="promote(emp)">▲</button>
                <button class="animal-action-btn" v-if="canDemote(emp)" @click="demote(emp)">▼</button>
                <button class="animal-action-btn danger" v-if="canFire(emp)" @click="fire(emp)">{{ t('fire') }}</button>
            </div>
        </div>

        <div class="divider" v-if="canManage"></div>
        <div class="actions-row" v-if="canManage">
            <button class="action-btn primary" @click="hire()">{{ t('hire_nearby') }}</button>
            <button class="action-btn danger" v-if="canTransfer" @click="transfer()">{{ t('transfer_ranch') }}</button>
        </div>
    </div>
    `
};

// ── Aba: Finanças ─────────────────────────────────────────────────
const TabFinance = {
    props: ['ranch', 'taxes', 'ranchId', 'employeeGrade', 'flags'],
    emits: ['action'],
    data() {
        return {
            depositAmount: '',
            withdrawAmount: '',
        };
    },
    computed: {
        disabled()    { return this.flags && this.flags.disableCash; },
        canWithdraw() { return this.employeeGrade >= 2 && !this.disabled; },
        canDeposit()  { return this.employeeGrade >= 1 && !this.disabled; },
        taxOverdue()  { const s = this.taxes && this.taxes.status; return s === 'overdue' || s === 'foreclosed'; },
        taxStatus() {
            const s = this.taxes && this.taxes.status;
            if (s === 'foreclosed') return 'tax-due';
            if (s === 'overdue')    return 'tax-warn';
            return 'tax-ok';
        },
        taxLabel() {
            const s = this.taxes && this.taxes.status;
            if (s === 'foreclosed') return t('tax_foreclosed');
            if (s === 'overdue')    return t('tax_overdue');
            return this.taxes && this.taxes.nextTax ? this.taxes.nextTax : t('tax_ok');
        },
    },
    methods: {
        t,
        formatMoney,
        deposit() {
            const amt = parseInt(this.depositAmount);
            if (amt > 0) {
                this.$emit('action', { action: 'deposit', amount: amt });
                this.depositAmount = '';
            }
        },
        withdraw() {
            const amt = parseInt(this.withdrawAmount);
            if (!(amt > 0)) return;
            const balance = (this.ranch && this.ranch.money) || 0;
            if (amt > balance) {
                this.$emit('action', { action: 'showToast', message: t('insufficient_funds'), type: 'error' });
                return;
            }
            this.$emit('action', { action: 'withdraw', amount: amt });
            this.withdrawAmount = '';
        },
        payTaxes() { this.$emit('action', { action: 'payTaxes' }); },
    },
    template: `
    <div>
        <div class="cards-row" style="margin-bottom:1.1rem">
            <div class="info-card">
                <div class="card-label">{{ t('ranch_cash') }} <info-tip :text="t('tip_ranch_cash')"></info-tip></div>
                <div class="card-value">{{ formatMoney(ranch && ranch.money) }}</div>
            </div>
            <div class="info-card">
                <div class="card-label">{{ t('taxes') }} <info-tip :text="t('tip_taxes')"></info-tip></div>
                <div class="card-value" :class="taxStatus">{{ taxLabel }}</div>
            </div>
            <div class="info-card" v-if="taxes">
                <div class="card-label">{{ t('tax_amount') }}</div>
                <div class="card-value">{{ formatMoney(taxes.amount) }}</div>
            </div>
        </div>

        <div class="finance-block" v-if="canDeposit">
            <div class="finance-label">{{ t('deposit_cash') }} <info-tip :text="t('tip_deposit')"></info-tip></div>
            <div class="finance-input-row">
                <input class="finance-input" type="number" min="1" v-model="depositAmount" :placeholder="t('value_placeholder')" @keyup.enter="deposit">
                <button class="action-btn primary" @click="deposit">{{ t('deposit') }}</button>
            </div>
        </div>

        <div class="finance-block" v-if="canWithdraw">
            <div class="finance-label">{{ t('withdraw_cash') }} <info-tip :text="t('tip_withdraw')"></info-tip></div>
            <div class="finance-input-row">
                <input class="finance-input" type="number" min="1" v-model="withdrawAmount" :placeholder="t('value_placeholder')" @keyup.enter="withdraw">
                <button class="action-btn danger" @click="withdraw">{{ t('withdraw') }}</button>
            </div>
        </div>

        <div class="finance-block" v-if="taxOverdue">
            <div class="finance-label" style="color:#e05252">{{ t('tax_overdue_warn') }}{{ formatMoney(taxes && taxes.amount) }}</div>
            <button class="action-btn" style="color:#e8b84b" @click="payTaxes">{{ t('pay_tax') }}</button>
        </div>
    </div>
    `
};

/* ─────────────────────────────────────────────────────────────────
   Area NUI — Componentes (por tipo de animal)
───────────────────────────────────────────────────────────────── */

// ── Area: Animais (rename only) ───────────────────────────────────
const AREA_PAGE_SIZE = 12;

const TabAreaAnimals = {
    props: ['animals', 'employeeGrade', 'animalConfigs'],
    emits: ['areaAction'],
    data() {
        return { page: 0, renameId: null, renameVal: '', breedingAnimal: null };
    },
    computed: {
        list() {
            const raw = this.animals || {};
            return Object.entries(raw).map(([id, d]) => ({ _id: id, ...d }));
        },
        totalPages() { return Math.ceil(this.list.length / AREA_PAGE_SIZE); },
        pageItems()  { const s = this.page * AREA_PAGE_SIZE; return this.list.slice(s, s + AREA_PAGE_SIZE); },
    },
    watch: { animals() { this.page = 0; this.renameId = null; this.renameVal = ''; } },
    methods: {
        t,
        prevPage() { if (this.page > 0) this.page--; },
        nextPage() { if (this.page < this.totalPages - 1) this.page++; },
        iconUrl(type, sex) {
            const g = sex === 'Female' ? 'Female' : 'Male';
            return `../images/${type}_${g}.png`;
        },
        isFemale(a)   { return a.sex === 'Female'; },
        isPregnant(a) { return a.pregnancy && a.pregnancy > 0; },
        canBreed(a) {
            if (a.sex !== 'Female') return false;
            const config = this.animalConfigs && this.animalConfigs[a.type];
            if (config && config.EggLaying) return false;
            if (!config || !config.FertilAge) return false;
            return a.age >= config.FertilAge && (!a.pregnancy || a.pregnancy === 0);
        },
        availableMales(female) {
            if (!female) return [];
            const list = this.animals ? Object.entries(this.animals).map(([id, d]) => ({ _id: id, ...d })) : [];
            const config = this.animalConfigs && this.animalConfigs[female.type];
            const fertilAge = config ? config.FertilAge : 0;
            return list.filter(a => a.type === female.type && a.sex === 'Male' && a.age >= fertilAge);
        },
        isMaleOnCooldown(m) {
            if (!m.lastBreedingAttempt) return false;
            const cooldownMins = (this.animalConfigs && this.animalConfigs.Rate && this.animalConfigs.Rate.maleBreedingCooldown) || 10;
            const cooldownSecs = cooldownMins * 60;
            const now = Math.floor(Date.now() / 1000);
            return (now - m.lastBreedingAttempt) < cooldownSecs;
        },
        maleCooldownPercent(m) {
            if (!m.lastBreedingAttempt) return 100;
            const cooldownMins = (this.animalConfigs && this.animalConfigs.Rate && this.animalConfigs.Rate.maleBreedingCooldown) || 10;
            const cooldownSecs = cooldownMins * 60;
            const now = Math.floor(Date.now() / 1000);
            const elapsed = now - m.lastBreedingAttempt;
            if (elapsed >= cooldownSecs) return 100;
            return Math.floor((elapsed / cooldownSecs) * 100);
        },
        startPregnancy(a) {
            this.breedingAnimal = a;
        },
        confirmBreed(maleId) {
            if (maleId && this.breedingAnimal) {
                this.$emit('areaAction', { action: 'startPregnancyArea', animalId: this.breedingAnimal._id, maleId: maleId });
                this.breedingAnimal = null;
            }
        },
        cancelBreed() {
            this.breedingAnimal = null;
        },
        pregnancyPercent(a) {
            const config = this.animalConfigs && this.animalConfigs[a.type];
            const max = (config && config.MaxStats && config.MaxStats.pregnancy) || 100;
            return Math.min(((a.pregnancy || 0) / max) * 100, 100);
        },
        isGrowing(a) {
            const config = this.animalConfigs && this.animalConfigs[a.type];
            if (!config || !config.FertilAge) return false;
            return a.age != null && a.age < config.FertilAge;
        },
        growingPercent(a) {
            const config = this.animalConfigs && this.animalConfigs[a.type];
            const fertilAge = (config && config.FertilAge) || 1;
            return Math.min(((a.age || 0) / fertilAge) * 100, 100);
        },
        toggleRename(a) {
            if (this.renameId === a._id) { this.renameId = null; this.renameVal = ''; }
            else { this.renameId = a._id; this.renameVal = a.name || ''; }
        },
        confirmRename(a) {
            const name = this.renameVal.trim();
            if (name) this.$emit('areaAction', { action: 'renameAnimalArea', animalId: a._id, name });
            this.renameId = null; this.renameVal = '';
        },
        retrieveFromPen(a) {
            this.$emit('areaAction', { action: 'retrieveAnimalArea', animalId: a._id });
        },
    },
    template: `
    <div>
        <div v-if="list.length === 0" class="empty-state">{{ t('no_animals_area') }}</div>
        <template v-else>
            <div class="animals-nav-row" v-if="totalPages > 1">
                <button class="animal-action-btn" :disabled="page === 0" @click="prevPage()">‹</button>
                <span style="font-size:0.78rem;color:rgba(255,255,255,0.55)">{{ page + 1 }} / {{ totalPages }}</span>
                <button class="animal-action-btn" :disabled="page >= totalPages - 1" @click="nextPage()">›</button>
            </div>
            <div class="animal-cards-grid">
                <div class="animal-card" v-for="a in pageItems" :key="a._id">
                    <div class="animal-card-top">
                        <img class="animal-card-icon" :src="iconUrl(a.type, a.sex)" :alt="a.type" @error="$event.target.style.display='none'">
                        <div class="animal-card-name">{{ a.name || a.type }}</div>
                        <button class="animal-icon-btn" :title="t('rename')" @click="toggleRename(a)">
                            <i class="fa-solid fa-pen"></i>
                        </button>
                    </div>
                    <div class="animal-card-badges">
                        <span class="animal-badge">{{ isFemale(a) ? t('female') : t('male') }}</span>
                        <span class="animal-badge mark" v-if="a.mark">{{ t('marked') }}</span>
                        <span class="animal-badge pregnant" v-if="isPregnant(a)">{{ t('pregnant') }}</span>
                    </div>
                    <div class="animal-card-stats">
                        <span class="stat-tip" :data-tip="t('stat_health')"       v-if="a.health    != null"><i class="fa-solid fa-heart"          style="color:#e05252"></i> {{ Math.floor(a.health) }}%</span>
                        <span class="stat-tip" :data-tip="t('stat_hunger')"        v-if="a.hungry    != null"><i class="fa-solid fa-bowl-food"      style="color:#e8b84b"></i> {{ Math.floor(a.hungry) }}%</span>
                        <span class="stat-tip" :data-tip="t('stat_weight')"        v-if="a.weight    != null"><i class="fa-solid fa-weight-scale"   style="color:rgba(255,255,255,0.4)"></i> {{ Math.floor(a.weight) }}</span>
                        <span class="stat-tip" :data-tip="t('stat_fertility')" v-if="a.fertility != null"><i class="fa-solid fa-seedling"       style="color:#a0d0a0"></i> {{ Math.floor(a.fertility) }}%</span>
                        <span class="stat-tip" :data-tip="t('stat_age')"       v-if="a.age       != null"><i class="fa-solid fa-hourglass-half" style="color:rgba(255,255,255,0.35)"></i> {{ Math.floor(a.age) }}</span>
                    </div>
                    <div class="animal-card-pregnancy" v-if="isPregnant(a)">
                        <div style="display:flex; justify-content:space-between; font-size:0.72rem; color:rgba(160,200,255,0.85); margin-bottom:0.35rem;">
                            <span>{{ t('gestation') }} <info-tip :text="t('tip_gestation')"></info-tip></span>
                            <span>{{ Math.floor(pregnancyPercent(a)) }}%</span>
                        </div>
                        <div class="pregnancy-bar-bg">
                            <div class="pregnancy-bar-fill" :style="{ width: pregnancyPercent(a) + '%' }"></div>
                        </div>
                    </div>
                    <div class="animal-card-pregnancy" v-if="isGrowing(a)">
                        <div style="display:flex; justify-content:space-between; font-size:0.72rem; color:rgba(160,208,160,0.85); margin-bottom:0.35rem;">
                            <span>{{ t('growing') }} <info-tip :text="t('tip_growing')"></info-tip></span>
                            <span>{{ Math.floor(growingPercent(a)) }}%</span>
                        </div>
                        <div class="growing-bar-bg">
                            <div class="growing-bar-fill" :style="{ width: growingPercent(a) + '%' }"></div>
                        </div>
                    </div>
                    <div class="animal-card-actions" style="margin-top: 0.5rem; text-align: center; flex-direction: column;">
                        <button class="action-btn primary" v-if="canBreed(a)" @click="startPregnancy(a)">{{ t('breed') }}</button>
                        <button class="action-btn" @click.stop="retrieveFromPen(a)">{{ t('retrieve_from_pen') }}</button>
                    </div>
                    <div class="rename-row" v-if="renameId === a._id">
                        <input class="rename-input" v-model="renameVal" maxlength="40" :placeholder="t('new_name_placeholder')" @keyup.enter="confirmRename(a)" @keyup.escape="renameId = null">
                        <button class="animal-action-btn" style="color:#a0d0a0" @click="confirmRename(a)">{{ t('ok') }}</button>
                        <button class="animal-action-btn" @click="renameId = null">✕</button>
                    </div>
                </div>
            </div>

            <!-- Modal Seleção de Macho (Reprodução) -->
            <div v-if="breedingAnimal" class="modal-overlay" style="position: fixed; top: 0; left: 0; width: 100%; height: 100%; background: rgba(0,0,0,0.85); z-index: 1000; display: flex; align-items: center; justify-content: center;" @click.self="cancelBreed()">
                <div class="modal-content" style="background: #181a1b; padding: 20px; border-radius: 8px; border: 1px solid rgba(255,255,255,0.1); max-width: 800px; width: 90%; max-height: 80vh; overflow-y: auto;">
                    <h2 style="margin-top: 0; margin-bottom: 15px; color: white; text-align: center; font-size: 1.2rem;">{{ t('select_male') }}</h2>
                    <div v-if="availableMales(breedingAnimal).length === 0" class="empty-state" style="padding: 20px;">
                        {{ t('no_males') }}
                    </div>
                    <div v-else class="animal-cards-grid" style="grid-template-columns: repeat(auto-fill, minmax(200px, 1fr));">
                        <div class="animal-card" v-for="m in availableMales(breedingAnimal)" :key="m._id" style="border: 2px solid transparent; transition: 0.2s;">
                            <div class="animal-card-top">
                                <img class="animal-card-icon" :src="iconUrl(m.type, m.sex)" :alt="m.type" @error="$event.target.style.display='none'">
                                <div class="animal-card-name">{{ m.name || m.type }}</div>
                            </div>
                            <div class="animal-card-stats" style="margin-top: 10px;">
                                <span class="stat-tip" :data-tip="t('stat_fertility')" v-if="m.fertility != null"><i class="fa-solid fa-seedling" style="color:#a0d0a0"></i> {{ Math.floor(m.fertility) }}%</span>
                                <span class="stat-tip" :data-tip="t('stat_health')" v-if="m.health != null"><i class="fa-solid fa-heart" style="color:#e05252"></i> {{ Math.floor(m.health) }}%</span>
                                <span class="stat-tip" :data-tip="t('stat_age')" v-if="m.age != null"><i class="fa-solid fa-hourglass-half" style="color:rgba(255,255,255,0.35)"></i> {{ Math.floor(m.age) }}</span>
                            </div>
                            <div class="animal-card-actions" style="margin-top: 15px; text-align: center;">
                                <button v-if="!isMaleOnCooldown(m)" class="action-btn primary" @click.stop="confirmBreed(m._id)">{{ t('select') }}</button>
                                <div v-else style="width:100%; display:flex; flex-direction:column; gap:4px;">
                                    <div style="display:flex; justify-content:space-between; font-size:0.75rem; color:#e8b84b;">
                                        <span>{{ t('resting') }}</span>
                                        <span>{{ maleCooldownPercent(m) }}%</span>
                                    </div>
                                    <div class="pregnancy-bar-bg" style="height:6px; width:100%;">
                                        <div class="pregnancy-bar-fill" style="background-color:#e8b84b;" :style="{ width: maleCooldownPercent(m) + '%' }"></div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div style="text-align: center; margin-top: 20px;">
                        <button class="action-btn danger" @click="cancelBreed()">{{ t('cancel') }}</button>
                    </div>
                </div>
            </div>

        </template>
    </div>
    `
};

// ── Area: Tarefas ─────────────────────────────────────────────────
const TabAreaChores = {
    props: ['chores', 'animalType'],
    emits: ['areaAction'],
    methods: {
        t,
        choreClass,
        startChore(key) { this.$emit('areaAction', { action: 'startChoreArea', chore: key, animalType: this.animalType }); },
    },
    template: `
    <div>
        <div v-if="!chores || Object.keys(chores).length === 0" class="empty-state">{{ t('no_chores_data') }}</div>
        <div class="chores-grid" v-else>
            <div class="chore-row" v-for="c in $options.choreDefs" :key="c.key">
                <div class="chore-header">
                    <span><i :class="c.icon" class="chore-icon"></i> {{ c.label }}</span>
                    <span>{{ (chores[c.key] || 0).toFixed(1) }} / 100</span>
                    <button class="animal-action-btn" :disabled="(chores[c.key] || 0) >= 100" @click="startChore(c.key)">{{ t('start') }}</button>
                </div>
                <div class="chore-bar-bg">
                    <div class="chore-bar-fill" :class="choreClass(chores[c.key] || 0)" :style="{ width: Math.min(chores[c.key] || 0, 100) + '%' }"></div>
                </div>
            </div>
        </div>
    </div>
    `,
    choreDefs: CHORE_DEFS,
};

// ── Area: Ovos (Galinhas) ─────────────────────────────────────────
const TabAreaEggs = {
    props: ['eggs'],
    emits: ['areaAction'],
    computed: {
        eggList() {
            const raw = this.eggs || {};
            // Converte objeto para array e ordena fertilizados primeiro
            return Object.entries(raw)
                .map(([id, data]) => ({ _id: id, ...data }))
                .sort((a, b) => (b.isFertilized ? 1 : 0) - (a.isFertilized ? 1 : 0));
        }
    },
    methods: {
        t,
        collect(eggId) {
            this.$emit('areaAction', { action: 'collectEgg', eggId: eggId });
        }
    },
    template: `
    <div>
        <div v-if="!eggList || eggList.length === 0" class="empty-state">{{ t('no_eggs_coop') }}</div>
        <div class="animal-cards-grid" v-else>
            <div class="animal-card" v-for="egg in eggList" :key="egg._id" style="justify-content: space-between;">
                <div>
                    <div class="animal-card-top"><img class="animal-card-icon" src="../images/animals_eggs.png" alt="Egg"><div class="animal-card-name">{{ egg.isFertilized ? t('fertilized_egg') : t('tab_eggs') }}</div></div>
                    <div class="animal-card-badges" style="margin-top:0.4rem"><span class="animal-badge" v-if="egg.mother">{{ t('mother') }} {{ egg.mother }}</span><span class="animal-badge pregnant" v-if="egg.isFertilized">{{ t('fertilized_egg') }}</span></div>
                    <div v-if="egg.isFertilized" style="font-size:0.78rem; color:rgba(232,184,75,0.8); margin-top:0.5rem;"><i class="fa-solid fa-triangle-exclamation"></i> {{ t('fertilized_warn') }}</div>
                </div>
                <div class="animal-card-actions" style="margin-top: 0.5rem;"><button class="action-btn primary" @click="collect(egg._id)">{{ t('collect_egg') }}</button></div>
            </div>
        </div>
    </div>`
};

// ── Area: Cocho (Trough) ──────────────────────────────────────────
const TabAreaTrough = {
    props: ['trough', 'foodItems', 'animalType', 'capacity', 'animals', 'chores', 'hungryRate', 'tickRate', 'troughUpgrades', 'employeeGrade'],
    emits: ['areaAction'],
    data() {
        return { selectedFood: null, quantity: 1 };
    },
    computed: {
        totalUnits()   { return (this.trough && this.trough.totalUnits) || 0; },
        upgradeLevel() { return (this.trough && this.trough.upgradeLevel) || 0; },
        cap() {
            const base = this.capacity || 500;
            return this.upgradeLevel > 0 ? base * Math.pow(2, this.upgradeLevel) : base;
        },
        fillPercent() { return Math.min((this.totalUnits / this.cap) * 100, 100); },
        fillClass()   { return choreClass(this.fillPercent); },
        isTroughFull() { return this.totalUnits >= this.cap; },
        foodList() {
            const items = this.foodItems;
            if (!items) return [];
            return Object.values(items).map(f => ({ ...f }));
        },
        nextUpgrade() {
            const upgrades = this.troughUpgrades;
            if (!upgrades || typeof upgrades !== 'object') return null;
            return upgrades[this.upgradeLevel + 1] || null;
        },
        canUpgrade() {
            return this.nextUpgrade && this.employeeGrade >= 3;
        },
        upgradeCostLabel() {
            const up = this.nextUpgrade;
            if (!up) return '';
            const type = up.moneyType;
            const amt = up.amount || 0;
            if (type === 'cash' || type === 'money') return `$${amt.toLocaleString('pt-BR')}`;
            if (type === 'gold') return `${amt} ${t('gold')}`;
            return `${amt}x ${type}`;
        },
        nextCapacity() {
            const base = this.capacity || 500;
            return base * Math.pow(2, this.upgradeLevel + 1);
        },
        estimatedDuration() {
            const units = this.totalUnits;
            if (!units || units <= 0) return null;
            const animalCount = Object.keys(this.animals || {}).length;
            if (animalCount === 0) return null;
            const chores = this.chores || {};
            const choreRate = ((chores.poop || 0) + (chores.hay || 0) + (chores.repair || 0) + (chores.water || 0)) / 400;
            const hungerDropRate = (this.hungryRate || 1.02) * (2 - choreRate);
            const drainPerTick = animalCount * hungerDropRate;
            if (drainPerTick <= 0) return null;
            const totalMinutes = (units / drainPerTick) * (this.tickRate || 15);
            const days = Math.floor(totalMinutes / 1440);
            const hours = Math.floor((totalMinutes % 1440) / 60);
            const mins = Math.floor(totalMinutes % 60);
            const parts = [];
            if (days > 0)  parts.push(`${days}${t('days')}`);
            if (hours > 0) parts.push(`${hours}${t('hours')}`);
            if (mins > 0 || parts.length === 0) parts.push(`${mins}${t('minutes')}`);
            return parts.join(' ');
        },
        previewDuration() {
            if (!this.selectedFood || this.quantity < 1) return null;
            const added = (this.selectedFood.foodAmount || 0) * this.quantity;
            const units = Math.min(this.totalUnits + added, this.cap);
            if (!units || units <= 0) return null;
            const animalCount = Object.keys(this.animals || {}).length;
            if (animalCount === 0) return null;
            const chores = this.chores || {};
            const choreRate = ((chores.poop || 0) + (chores.hay || 0) + (chores.repair || 0) + (chores.water || 0)) / 400;
            const hungerDropRate = (this.hungryRate || 1.02) * (2 - choreRate);
            const drainPerTick = animalCount * hungerDropRate;
            if (drainPerTick <= 0) return null;
            const totalMinutes = (units / drainPerTick) * (this.tickRate || 15);
            const days = Math.floor(totalMinutes / 1440);
            const hours = Math.floor((totalMinutes % 1440) / 60);
            const mins = Math.floor(totalMinutes % 60);
            const parts = [];
            if (days > 0)  parts.push(`${days}${t('days')}`);
            if (hours > 0) parts.push(`${hours}${t('hours')}`);
            if (mins > 0 || parts.length === 0) parts.push(`${mins}${t('minutes')}`);
            return parts.join(' ');
        },
    },
    watch: {
        foodList(v) { if (v.length > 0 && !this.selectedFood) this.selectedFood = v[0]; },
    },
    mounted() { if (this.foodList.length > 0) this.selectedFood = this.foodList[0]; },
    methods: {
        t,
        addToTrough() {
            if (this.isTroughFull || !this.selectedFood || this.quantity < 1) return;
            this.$emit('areaAction', { action: 'addToTrough', food: this.selectedFood, quantity: this.quantity });
            this.quantity = 1;
        },
        doUpgrade() {
            if (!this.canUpgrade) return;
            this.$emit('areaAction', { action: 'upgradeTrough' });
        },
    },
    template: `
    <div>
        <!-- Barra do cocho -->
        <div class="info-card" style="margin-bottom:0.6rem">
            <div class="card-label">{{ t('trough_title') }} — {{ t(animalType) }} <span v-if="upgradeLevel > 0" style="color:rgba(255,255,255,0.5)">({{ t('trough_level') }} {{ upgradeLevel }})</span> <info-tip :text="t('tip_trough_area')"></info-tip></div>
            <div class="card-value">{{ Math.floor(totalUnits) }} / {{ cap }} {{ t('units') }}</div>
        </div>
        <div class="chore-bar-bg" style="margin-bottom:0.5rem">
            <div class="chore-bar-fill" :class="fillClass" :style="{ width: fillPercent + '%' }"></div>
        </div>
        <!-- Previsão de duração atual -->
        <div style="margin-bottom:1.2rem;font-size:0.82rem;color:rgba(255,255,255,0.55);min-height:1.1em">
            <span v-if="estimatedDuration">
                {{ t('estimate_current') }} <strong style="color:rgba(255,255,255,0.85)">{{ estimatedDuration }}</strong> <info-tip :text="t('tip_trough_estimate')"></info-tip>
            </span>
            <span v-else-if="totalUnits <= 0">{{ t('trough_empty_warn') }}</span>
        </div>

        <!-- Seletor de alimento -->
        <div v-if="foodList.length === 0" class="empty-state">{{ t('no_food_configured') }}</div>
        <template v-else>
            <div class="section-title" style="font-size:0.9rem;margin-bottom:0.5rem">{{ t('add_to_trough') }}</div>
            <div class="food-list" style="margin-bottom:0.8rem">
                <div
                    v-for="f in foodList" :key="f.item"
                    class="food-item"
                    :class="{ selected: selectedFood && selectedFood.item === f.item }"
                    @click="selectedFood = f"
                >
                    <img v-if="f.image" :src="f.image" class="food-icon" :alt="f.label || f.item">
                    <span class="food-label">{{ f.label || f.item }}</span>
                    <span class="food-meta">{{ f.amount }}{{ t('per_deposit') }} &nbsp;·&nbsp; +{{ f.foodAmount }} {{ t('units') }}</span>
                </div>
            </div>
            <div v-if="selectedFood" class="finance-input-row" style="margin-bottom:0.5rem">
                <input class="finance-input" type="number" min="1" v-model.number="quantity" style="max-width:100px" :placeholder="t('qty_placeholder')">
                <span style="font-size:0.82rem;color:rgba(255,255,255,0.5)">
                    {{ selectedFood.amount * quantity }}x {{ selectedFood.label || selectedFood.item }}
                    &nbsp;·&nbsp; +{{ selectedFood.foodAmount * quantity }} {{ t('units') }}
                </span>
            </div>
            <!-- Prévia após depósito -->
            <div v-if="previewDuration" style="font-size:0.8rem;color:rgba(255,255,255,0.45);margin-bottom:0.8rem">
                {{ t('after_deposit') }} <strong style="color:rgba(255,255,255,0.7)">{{ previewDuration }}</strong>
            </div>
            <div class="actions-row">
                <button class="action-btn primary" :disabled="isTroughFull || !selectedFood || quantity < 1" @click="addToTrough">
                    {{ t('deposit_in_trough') }}
                </button>
            </div>
        </template>

        <!-- Upgrade de Cocho -->
        <div class="divider" style="margin:1.2rem 0"></div>
        <div class="section-title" style="font-size:0.9rem;margin-bottom:0.5rem">{{ t('upgrade_trough') }} <info-tip :text="t('tip_upgrade_trough')"></info-tip></div>
        <div v-if="!nextUpgrade" style="font-size:0.82rem;color:rgba(255,255,255,0.45)">
            {{ t('trough_max_level') }} ({{ upgradeLevel }}).
        </div>
        <div v-else>
            <div style="font-size:0.82rem;color:rgba(255,255,255,0.55);margin-bottom:0.6rem">
                {{ t('current_level') }} <strong style="color:#fff">{{ upgradeLevel }}</strong> &nbsp;→&nbsp;
                {{ t('next_level') }} <strong style="color:#7ec87e">{{ upgradeLevel + 1 }}</strong>
                <br>
                {{ t('capacity') }} {{ cap }} {{ t('units') }} → <strong style="color:#7ec87e">{{ nextCapacity }} {{ t('units') }}</strong>
            </div>
            <div class="actions-row">
                <button class="action-btn" :class="{ primary: canUpgrade }" :disabled="!canUpgrade" @click="doUpgrade">
                    {{ t('upgrade_btn') }} ({{ upgradeCostLabel }})
                </button>
            </div>
            <div v-if="employeeGrade < 3" style="font-size:0.75rem;color:rgba(255,255,255,0.35);margin-top:0.4rem">
                {{ t('only_owner_upgrade') }}
            </div>
        </div>
    </div>
    `
};

// ── Area: Importar do btc-stable ─────────────────────────────────
const TabAreaStable = {
    props: ['ranchId', 'animalType'],
    emits: ['areaAction'],
    data() { return { horses: [], loading: true }; },
    mounted() {
        nuiFetch('areaAction', { action: 'getStableHorses', ranchId: this.ranchId, animalType: this.animalType })
            .then(r => r && r.json ? r.json() : [])
            .then(data => { this.horses = Array.isArray(data) ? data : []; this.loading = false; })
            .catch(() => { this.horses = []; this.loading = false; });
    },
    methods: {
        t,
        genderLabel(g) { return g === 1 ? t('stable_female') : t('stable_male'); },
        importHorse(horseId) {
            this.$emit('areaAction', { action: 'importStableHorse', horseId });
            this.horses = this.horses.filter(h => h.id !== horseId);
        },
    },
    template: `
    <div>
        <div v-if="loading" class="empty-state">{{ t('stable_loading') }}</div>
        <div v-else-if="!horses.length" class="empty-state">{{ t('stable_no_horses') }}</div>
        <div class="animal-cards-grid" v-else>
            <div class="animal-card" v-for="h in horses" :key="h.id" style="justify-content:space-between">
                <div>
                    <div class="animal-card-top">
                        <div class="animal-card-name">{{ h.name }}</div>
                    </div>
                    <div class="animal-card-badges" style="margin-top:0.4rem">
                        <span class="animal-badge">{{ genderLabel(h.gender) }}</span>
                        <span class="animal-badge">{{ t('stable_age') }}: {{ h.age }} {{ t('stable_days') }}</span>
                        <span class="animal-badge pregnant" v-if="h.active">{{ t('stable_active_warn') }}</span>
                    </div>
                    <div style="font-size:0.75rem;color:rgba(255,255,255,0.45);margin-top:0.35rem">{{ h.model }}</div>
                </div>
                <div class="animal-card-actions" style="margin-top:0.5rem">
                    <button class="action-btn primary" :disabled="h.active" @click="importHorse(h.id)">
                        {{ t('stable_import') }}
                    </button>
                </div>
            </div>
        </div>
    </div>`,
};

/* ─────────────────────────────────────────────────────────────────
   App principal
───────────────────────────────────────────────────────────────── */
const App = {
    components: { TabOverview, TabAnimals, TabEmployees, TabFinance, TabAreaAnimals, TabAreaChores, TabAreaTrough, TabAreaEggs, TabAreaStable },

    data() {
        return {
            /* ranch panel */
            ranchVisible: false,
            activeTab: 'overview',
            ranchId: null,
            ranchInfo: null,
            animalConfigs: {},
            taxes: null,
            animals: [],
            animalTypes: [],
            employees: [],
            employeeGrade: 0,
            flags: {},
            toasts: [],

            /* area panel */
            areaVisible:       false,
            areaTab:           'animals',
            areaRanchId:       null,
            areaAnimalType:    null,
            areaAnimals:       {},
            areaChores:        {},
            areaEggs:          {},
            areaTrough:        {},
            areaTroughCap:     500,
            areaEmployeeGrade: 0,
            areaFoodItems:     [],
            areaHungryRate:    1.02,
            areaTickRate:      15,
            areaTroughUpgrades:     {},
            areaStableIntegration:  false,

            /* admin panel */
            adminVisible: false,
            adminActiveTab: 'general',
            adminConfig: null,
            adminPrices: null,
            adminStats: null,

            /* raid */
            raidActive:   false,
            raidKills:    0,
            raidTotal:    0,
            raidTimeLeft: 0,

            /* carry hint */
            carryHint: '',

            /* ranch rename */
            editingName: false,
            nameInput: '',
        };
    },

    computed: {
        tabs() {
            return [
                { id: 'overview',   label: t('tab_overview') },
                { id: 'animals',    label: t('tab_animals') },
                { id: 'employees',  label: t('tab_employees') },
                { id: 'finance',    label: t('tab_finance') },
            ];
        },
        areaTabs() {
            const tabs = [
                { id: 'animals', label: t('tab_animals') },
                { id: 'chores',  label: t('tab_chores') },
                { id: 'trough',  label: t('tab_trough') },
            ];
            const areaAnimalCfg = this.animalConfigs && this.animalConfigs[this.areaAnimalType];
            if (areaAnimalCfg && areaAnimalCfg.EggLaying) {
                tabs.push({ id: 'eggs', label: t('tab_eggs') });
            }
            if (this.areaStableIntegration) {
                tabs.push({ id: 'stable', label: t('tab_stable') });
            }
            return tabs;
        },
        ownerId() {
            return this.ranchInfo && this.ranchInfo.ownerId;
        },
    },

    methods: {
        t,
        /* ── Ranch panel ────────────────────────────────────────── */
        openRanchMenu(data) {
            this.ranchId       = data.ranchId;
            this.ranchInfo     = data.ranchInfo;
            this.taxes         = data.taxes;
            this.animals       = data.animals      || {};
            this.animalConfigs = data.animalConfigs || {};
            this.animalTypes   = data.animalTypes  || [];
            this.employees     = data.employees    || [];
            this.employeeGrade = data.employeeGrade || 0;
            this.flags         = data.flags || {};
            this.activeTab     = 'overview';
            this.ranchVisible  = true;
        },
        closeRanch() {
            this.editingName = false;
            this.ranchVisible = false;
            nuiFetch('ranchAction', { action: 'close' });
        },
        startEditName() {
            if (this.employeeGrade < 3) return;
            this.nameInput = (this.ranchInfo && this.ranchInfo.name) || '';
            this.editingName = true;
            this.$nextTick(() => {
                const el = this.$el.querySelector('.name-edit-input');
                if (el) el.focus();
            });
        },
        saveRanchName() {
            const name = (this.nameInput || '').trim();
            if (!name || name === (this.ranchInfo && this.ranchInfo.name)) {
                this.editingName = false;
                return;
            }
            nuiFetch('ranchAction', { action: 'renameRanch', name, ranchId: this.ranchId });
            if (this.ranchInfo) this.ranchInfo.name = name;
            this.editingName = false;
        },
        cancelEditName() {
            this.editingName = false;
        },
        updateData(data) {
            if (data.ranchInfo)    this.ranchInfo    = data.ranchInfo;
            if (data.taxes)        this.taxes        = data.taxes;
            if (data.animals)      this.animals      = data.animals;
            if (data.employees)    this.employees    = data.employees;
            if (data.money != null) {
                if (!this.ranchInfo) this.ranchInfo = {};
                this.ranchInfo.money = data.money;
            }
            if (data.threatLevel != null) {
                if (!this.ranchInfo) this.ranchInfo = {};
                this.ranchInfo.threatLevel = data.threatLevel;
            }
            if (data.raidActive  !== undefined) this.raidActive   = data.raidActive;
            if (data.raidKills   !== undefined) this.raidKills    = data.raidKills;
            if (data.raidTotal   !== undefined) this.raidTotal    = data.raidTotal;
            if (data.raidTimeLeft!== undefined) this.raidTimeLeft = data.raidTimeLeft;
            if (data.carryHint   !== undefined) this.carryHint   = data.carryHint;
            if (data.ranchName   != null)       { if (!this.ranchInfo) this.ranchInfo = {}; this.ranchInfo.name = data.ranchName; }
        },
        addToast(message, type) {
            const id = Date.now() + Math.random();
            this.toasts.push({ id, message, type: type || 'info' });
            setTimeout(() => { this.toasts = this.toasts.filter(t => t.id !== id); }, 3500);
        },
        formatRaidTime(s) {
            const m = Math.floor(s / 60), ss = s % 60;
            return m + ':' + String(ss).padStart(2, '0');
        },
        handleAction(payload) {
            if (payload.action === 'showToast') {
                this.addToast(payload.message, payload.type || 'info');
                return;
            }

            nuiFetch('ranchAction', { ...payload, ranchId: this.ranchId });

            const closingActions = ['retrieveAnimal', 'hireEmployee', 'transferRanch', 'openInventory', 'leaveRanch', 'startChore', 'payProtection'];
            if (closingActions.includes(payload.action)) {
                this.ranchVisible = false;
            }
        },

        /* ── Area panel ──────────────────────────────────────────── */
        openAreaMenu(data) {
            this.areaRanchId       = data.ranchId;
            this.areaAnimalType    = data.animalType;
            this.areaAnimals       = data.animals      || {};
            this.areaChores        = data.chores       || {};
            this.areaEggs          = data.eggs         || {};
            this.areaTrough        = data.trough       || { totalUnits: 0 };
            if (data.animalConfigs) this.animalConfigs = data.animalConfigs;
            this.areaTroughCap     = data.capacity     || 500;
            this.areaEmployeeGrade = data.employeeGrade || 0;
            this.areaFoodItems     = data.foodItems    || [];
            this.areaHungryRate    = data.hungryRate    || 1.02;
            this.areaTickRate      = data.tickRateMinutes || 15;
            this.areaTroughUpgrades    = data.troughUpgrades || {};
            this.areaStableIntegration = data.stableIntegration || false;
            this.areaTab               = 'animals';
            this.areaVisible           = true;
        },
        closeArea() {
            this.areaVisible = false;
            nuiFetch('areaAction', { action: 'closeAreaMenu' });
        },
        handleAreaAction(payload) {
            if (payload.action === 'startChoreArea' || payload.action === 'retrieveAnimalArea') {
                this.closeArea();
            }
            nuiFetch('areaAction', { ...payload, ranchId: this.areaRanchId, animalType: this.areaAnimalType });
        },

        /* ── Admin panel ─────────────────────────────────────────── */
        openAdmin(data) {
            this.adminConfig     = data.config;
            this.adminPrices     = data.prices;
            this.adminStats      = data.stats;
            this.adminActiveTab  = 'general';
            this.adminVisible    = true;
            this.$nextTick(() => this.populateAdminPrices());
        },
        closeAdmin() {
            this.adminVisible = false;
            nuiFetch('closePanel', {});
        },
        saveAdmin() {
            const multipliers = {};
            document.querySelectorAll('.admin-price-input').forEach(input => {
                const { animal, type, category, key } = input.dataset;
                if (!multipliers[animal]) {
                    multipliers[animal] = { Buy: { priceIncreases: {}, priceDecreases: {} }, Sell: { priceIncreases: {}, priceDecreases: {} } };
                }
                multipliers[animal][type][category][key] = parseFloat(input.value);
            });
            const limitCheck = document.getElementById('admin-limit-check');
            const maxAnimalsVal = limitCheck && limitCheck.checked
                ? parseInt(document.getElementById('admin-max-animals').value)
                : false;
            const payload = {
                MaxRanchesPerPlayer: parseInt(document.getElementById('admin-max-ranches').value),
                MaxAnimalsPerRanch:  maxAnimalsVal,
                TaxIntervalDays:     parseInt(document.getElementById('admin-tax-interval').value),
                TaxAmount:           parseInt(document.getElementById('admin-tax-amount').value),
                priceMultipliers:    multipliers,
            };
            nuiFetch('saveConfig', payload).then(() => this.closeAdmin());
        },
        populateAdminPrices() {
            const container = document.getElementById('admin-price-container');
            if (!container || !this.adminPrices) return;
            container.innerHTML = '';
            for (const [animalType, animalData] of Object.entries(this.adminPrices)) {
                if (!animalData.PriceMultiplier) continue;
                const div = document.createElement('div');
                div.className = 'admin-price-card';
                let html = `<h3>${animalData.Label || animalType}</h3>`;
                const buildInputs = (type, multipliers) => {
                    let s = `<h4>${type === 'Buy' ? this.t('admin_buy') : this.t('admin_sell')}</h4><div class="admin-price-grid">`;
                    if (multipliers.priceIncreases) {
                        for (const [k, v] of Object.entries(multipliers.priceIncreases)) {
                            s += `<div><label style="color:#285430">${this.t('admin_increase')} ${k}</label><input type="number" step="0.01" class="admin-input admin-price-input" data-animal="${animalType}" data-type="${type}" data-category="priceIncreases" data-key="${k}" value="${Number(v).toFixed(2)}"></div>`;
                        }
                    }
                    if (multipliers.priceDecreases) {
                        for (const [k, v] of Object.entries(multipliers.priceDecreases)) {
                            s += `<div><label style="color:#991B1B">${this.t('admin_decrease')} ${k}</label><input type="number" step="0.01" class="admin-input admin-price-input" data-animal="${animalType}" data-type="${type}" data-category="priceDecreases" data-key="${k}" value="${Number(v).toFixed(2)}"></div>`;
                        }
                    }
                    s += '</div>';
                    return s;
                };
                html += buildInputs('Buy', animalData.PriceMultiplier.Buy);
                html += buildInputs('Sell', animalData.PriceMultiplier.Sell);
                div.innerHTML = html;
                container.appendChild(div);
            }
            // Decimal limit
            document.querySelectorAll('.admin-price-input').forEach(input => {
                input.addEventListener('input', e => {
                    if (e.target.value.includes('.')) {
                        const parts = e.target.value.split('.');
                        if (parts[1] && parts[1].length > 2)
                            e.target.value = `${parts[0]}.${parts[1].substring(0, 2)}`;
                    }
                });
            });
        },
        adminTabClass(id) {
            return ['admin-tab-btn', this.adminActiveTab === id ? 'active' : ''];
        },
        adminContentClass(id) {
            return ['admin-tab-content', this.adminActiveTab === id ? 'active' : ''];
        },
        toggleLimitCheck() {
            const el = document.getElementById('admin-max-animals');
            const check = document.getElementById('admin-limit-check');
            if (el && check) el.disabled = !check.checked;
        },
        adminStatTotal() {
            if (!this.adminStats) return 0;
            return Object.entries(this.adminStats)
                .filter(([k]) => k !== 'Total')
                .reduce((s, [, v]) => s + v, 0);
        },
        adminStatEntries() {
            if (!this.adminStats) return [];
            return Object.entries(this.adminStats)
                .filter(([k]) => k !== 'Total')
                .sort((a, b) => a[0].localeCompare(b[0]));
        },
    },

    mounted() {
        window.addEventListener('message', event => {
            const { action, data } = event.data;
            if (action === 'openRanchMenu') {
                this.openRanchMenu(event.data);
            } else if (action === 'openAreaMenu') {
                this.openAreaMenu(event.data);
            } else if (action === 'updateAreaTrough') {
                if (event.data.trough) this.areaTrough = event.data.trough;
            } else if (action === 'updateData') {
                this.updateData(data || event.data);
            } else if (action === 'notify') {
                this.addToast(event.data.message, event.data.notifyType);
            } else if (action === 'closeRanchMenu') {
                this.ranchVisible = false;
            } else if (action === 'closeAreaMenu') {
                this.areaVisible = false;
            } else if (action === 'open') {
                this.openAdmin(data);
            }
        });

        document.addEventListener('keydown', e => {
            if (e.key === 'Escape') {
                if (this.adminVisible)       this.closeAdmin();
                else if (this.ranchVisible)  this.closeRanch();
                else if (this.areaVisible)   this.closeArea();
            }
        });

    },


    template: `
    <div>

        <!-- ══ Carry Hint (fixo, visível ao carregar animal) ══════════ -->
        <div class="carry-hint" v-if="carryHint">{{ carryHint }}</div>

        <!-- ══ Raid Alert Banner (fixo, visível durante raid) ═══════ -->
        <div class="raid-alert" v-if="raidActive">
            <div class="raid-alert-deco-top"></div>
            <div class="raid-alert-body">
                <div class="raid-alert-icon">&#9760;</div>
                <div class="raid-alert-info">
                    <span class="raid-alert-title">{{ t('raid_alert_title') }}</span>
                    <span class="raid-alert-sub">{{ raidKills }} / {{ raidTotal }} {{ t('raid_killed') }}</span>
                </div>
                <div class="raid-alert-timer">{{ formatRaidTime(raidTimeLeft) }}</div>
            </div>
            <div class="raid-alert-bar-bg">
                <div class="raid-alert-bar-fill"
                    :style="{ width: raidTotal > 0 ? (raidKills / raidTotal * 100) + '%' : '0%' }">
                </div>
            </div>
        </div>

        <!-- ══ Ranch Management Panel ══════════════════════════════ -->
        <div class="overlay" v-if="ranchVisible">
            <div class="panel" style="position:relative">
                <!-- Header -->
                <div class="panel-header">
                    <div class="header-top-row">
                        <span v-if="!editingName"
                              class="panel-title"
                              :class="{ 'editable-title': employeeGrade >= 3 }"
                              @click="startEditName"
                        >{{ ranchInfo && ranchInfo.name || t('ranch') }}</span>
                        <div v-else class="name-edit-header-row">
                            <input class="rename-input name-edit-input" type="text" v-model="nameInput" maxlength="50"
                                   @keyup.enter="saveRanchName" @keyup.escape="cancelEditName">
                            <button class="action-btn primary" style="padding:0.25rem 0.6rem;font-size:0.8rem" @click="saveRanchName">✓</button>
                            <button class="action-btn" style="padding:0.25rem 0.6rem;font-size:0.8rem" @click="cancelEditName">✕</button>
                        </div>
                        <button class="close-btn" @click="closeRanch">✕</button>
                    </div>
                    <div class="header-deco"></div>
                    <div class="header-row">
                        <div class="tabs">
                            <button
                                v-for="t in tabs" :key="t.id"
                                class="tab-btn"
                                :class="{ active: activeTab === t.id }"
                                @click="activeTab = t.id"
                            >{{ t.label }}</button>
                        </div>
                    </div>
                </div>

                <!-- Toasts in-menu -->
                <div class="toast-container" v-if="toasts.length">
                    <div v-for="t in toasts" :key="t.id" class="toast" :class="t.type">
                        <i class="fa-solid fa-circle-xmark"  v-if="t.type === 'error'"></i>
                        <i class="fa-solid fa-circle-check"  v-else-if="t.type === 'success'"></i>
                        <i class="fa-solid fa-triangle-exclamation" v-else-if="t.type === 'warning'"></i>
                        <i class="fa-solid fa-circle-info"   v-else></i>
                        {{ t.message }}
                    </div>
                </div>

                <!-- Body -->
                <div class="panel-body">

                    <!-- Visão Geral -->
                    <tab-overview
                        v-if="activeTab === 'overview'"
                        :ranch="ranchInfo"
                        :animals="animals"
                        :employee-grade="employeeGrade"
                        :flags="flags"
                        :animal-configs="animalConfigs"
                        @action="handleAction"
                    />

                    <!-- Animais -->
                    <tab-animals
                        v-if="activeTab === 'animals'"
                        :animals="animals"
                        :animal-types="animalTypes"
                        :ranch-id="ranchId"
                        :employee-grade="employeeGrade"
                        :animal-configs="animalConfigs"
                        @action="handleAction"
                    />

                    <!-- Funcionários -->
                    <tab-employees
                        v-if="activeTab === 'employees'"
                        :employees="employees"
                        :ranch-id="ranchId"
                        :employee-grade="employeeGrade"
                        :owner-id="ownerId"
                        :flags="flags"
                        @action="handleAction"
                    />

                    <!-- Finanças -->
                    <tab-finance
                        v-if="activeTab === 'finance'"
                        :ranch="ranchInfo"
                        :taxes="taxes"
                        :ranch-id="ranchId"
                        :employee-grade="employeeGrade"
                        :flags="flags"
                        @action="handleAction"
                    />

                </div>
            </div>
        </div>

        <!-- ══ Area Panel (por tipo de animal) ════════════════════ -->
        <div class="overlay" v-if="areaVisible">
            <div class="panel" style="position:relative">
                <!-- Header -->
                <div class="panel-header">
                    <div class="header-top-row">
                        <span class="panel-title">{{ areaAnimalType }}</span>
                        <button class="close-btn" @click="closeArea">✕</button>
                    </div>
                    <div class="header-deco"></div>
                    <div class="header-row">
                        <div class="tabs">
                            <button
                                v-for="t in areaTabs" :key="t.id"
                                class="tab-btn"
                                :class="{ active: areaTab === t.id }"
                                @click="areaTab = t.id"
                            >{{ t.label }}</button>
                        </div>
                    </div>
                </div>

                <!-- Toasts in-menu -->
                <div class="toast-container" v-if="toasts.length">
                    <div v-for="t in toasts" :key="t.id" class="toast" :class="t.type">
                        <i class="fa-solid fa-circle-xmark"  v-if="t.type === 'error'"></i>
                        <i class="fa-solid fa-circle-check"  v-else-if="t.type === 'success'"></i>
                        <i class="fa-solid fa-triangle-exclamation" v-else-if="t.type === 'warning'"></i>
                        <i class="fa-solid fa-circle-info"   v-else></i>
                        {{ t.message }}
                    </div>
                </div>

                <!-- Body -->
                <div class="panel-body">
                    <tab-area-animals
                        v-if="areaTab === 'animals'"
                        :animals="areaAnimals"
                        :employee-grade="areaEmployeeGrade"
                        :animal-configs="animalConfigs"
                        @area-action="handleAreaAction"
                    />
                    <tab-area-chores
                        v-if="areaTab === 'chores'"
                        :chores="areaChores"
                        :animal-type="areaAnimalType"
                        @area-action="handleAreaAction"
                    />
                    <tab-area-trough
                        v-if="areaTab === 'trough'"
                        :trough="areaTrough"
                        :food-items="areaFoodItems"
                        :animal-type="areaAnimalType"
                        :capacity="areaTroughCap"
                        :animals="areaAnimals"
                        :chores="areaChores"
                        :hungry-rate="areaHungryRate"
                        :tick-rate="areaTickRate"
                        :trough-upgrades="areaTroughUpgrades"
                        :employee-grade="areaEmployeeGrade"
                        @area-action="handleAreaAction"
                    />
                    <tab-area-eggs
                        v-if="areaTab === 'eggs'"
                        :eggs="areaEggs"
                        @area-action="handleAreaAction"
                    />
                    <tab-area-stable
                        v-if="areaTab === 'stable'"
                        :ranch-id="areaRanchId"
                        :animal-type="areaAnimalType"
                        @area-action="handleAreaAction"
                    />
                </div>
            </div>
        </div>

        <!-- ══ Admin Panel ══════════════════════════════════════════ -->
        <div class="admin-overlay" v-if="adminVisible">
            <div class="admin-panel">
                <div class="admin-header">
                    <h1>{{ t('admin_title') }}</h1>
                    <button class="admin-btn admin-btn-secondary" @click="closeAdmin">{{ t('close') }}</button>
                </div>

                <div class="admin-main">
                    <!-- Sidebar -->
                    <div class="admin-sidebar">
                        <nav>
                            <button :class="adminTabClass('general')" @click="adminActiveTab = 'general'">{{ t('admin_tab_general') }}</button>
                            <button :class="adminTabClass('taxes')"   @click="adminActiveTab = 'taxes'">{{ t('admin_tab_taxes') }}</button>
                            <button :class="adminTabClass('prices')"  @click="adminActiveTab = 'prices'">{{ t('admin_tab_prices') }}</button>
                            <button :class="adminTabClass('stats')"   @click="adminActiveTab = 'stats'">{{ t('admin_tab_stats') }}</button>
                        </nav>
                    </div>

                    <!-- Content -->
                    <div class="admin-content">

                        <!-- General -->
                        <div :class="adminContentClass('general')">
                            <h2>{{ t('admin_general_settings') }}</h2>
                            <div class="admin-form-group">
                                <label for="admin-max-ranches">{{ t('admin_max_ranches') }}</label>
                                <input id="admin-max-ranches" type="number" class="admin-input"
                                    :value="adminConfig && adminConfig.MaxRanchesPerPlayer">
                            </div>
                            <div class="admin-form-group">
                                <div style="display:flex;align-items:center;gap:10px;margin-bottom:8px">
                                    <input id="admin-limit-check" type="checkbox" style="width:20px;height:20px"
                                        :checked="adminConfig && adminConfig.MaxAnimalsPerRanch !== false"
                                        @change="toggleLimitCheck">
                                    <label for="admin-limit-check">{{ t('admin_limit_animals') }}</label>
                                </div>
                                <input id="admin-max-animals" type="number" class="admin-input"
                                    :value="adminConfig && adminConfig.MaxAnimalsPerRanch !== false ? adminConfig.MaxAnimalsPerRanch : 100"
                                    :disabled="!(adminConfig && adminConfig.MaxAnimalsPerRanch !== false)">
                            </div>
                        </div>

                        <!-- Taxes -->
                        <div :class="adminContentClass('taxes')">
                            <h2>{{ t('admin_tax_settings') }}</h2>
                            <div class="admin-form-group">
                                <label for="admin-tax-interval">{{ t('admin_tax_interval') }}</label>
                                <input id="admin-tax-interval" type="number" class="admin-input"
                                    :value="adminConfig && adminConfig.TaxIntervalDays">
                            </div>
                            <div class="admin-form-group">
                                <label for="admin-tax-amount">{{ t('admin_tax_amount_label') }}</label>
                                <input id="admin-tax-amount" type="number" class="admin-input"
                                    :value="adminConfig && adminConfig.TaxAmount">
                            </div>
                        </div>

                        <!-- Prices -->
                        <div :class="adminContentClass('prices')">
                            <h2>{{ t('admin_price_multipliers') }}</h2>
                            <div id="admin-price-container"></div>
                        </div>

                        <!-- Stats -->
                        <div :class="adminContentClass('stats')">
                            <h2>{{ t('admin_server_stats') }}</h2>
                            <div class="admin-stats-box">
                                <p v-for="[type, count] in adminStatEntries()" :key="type">
                                    {{ type }}: <span>{{ count }}</span>
                                </p>
                            </div>
                            <div style="border-top:2px solid #A07855;margin-top:16px;padding-top:16px">
                                <p style="font-size:20px;font-weight:700">
                                    {{ t('admin_total_animals') }}
                                    <span style="color:#285430">{{ adminStatTotal() }}</span>
                                </p>
                            </div>
                        </div>

                    </div>
                </div>

                <div class="admin-footer">
                    <button class="admin-btn admin-btn-primary" @click="saveAdmin">{{ t('admin_save_changes') }}</button>
                </div>
            </div>
        </div>

    </div>
    `
};

const app = Vue.createApp(App);
app.component('InfoTip', InfoTip);
app.mount('#app');

/* ═══════════════════════════════════════════════════════════════════
   InteractAnimal — Menu NUI lateral esquerdo
   ═══════════════════════════════════════════════════════════════════ */

const InteractAnimalApp = {
    data() {
        return {
            visible:     false,
            animal:      null,
            netId:       null,
            animalCfg:   null,
            // stack de páginas: cada item { title, options: [{id, label, icon, meta, section}] }
            pageStack:   [],
            activeId:    null,
            statusOpen:  true,
        };
    },
    computed: {
        currentPage() {
            return this.pageStack[this.pageStack.length - 1] || null;
        },
        currentOptions() {
            return this.currentPage ? this.currentPage.options : [];
        },
        currentTitle() {
            return this.currentPage ? this.currentPage.title : '';
        },
        isSubPage() {
            return this.pageStack.length > 1;
        },
        iconUrl() {
            if (!this.animal) return '';
            return `../images/${this.animal.type}_${this.animal.sex}.png`;
        },
        animalSubLabel() {
            if (!this.animal) return '';
            const parts = [this.animal.type, this.animal.sex ? t(this.animal.sex) : ''];
            return parts.filter(Boolean).join(' · ');
        },
        stats() {
            const a = this.animal;
            if (!a) return [];
            const cfg = this.animalCfg;
            const maxAge    = cfg && cfg.MaxStats && cfg.MaxStats.age       ? cfg.MaxStats.age       : 100;
            const maxWeight = cfg && cfg.MaxStats && cfg.MaxStats.weight    ? cfg.MaxStats.weight    : 100;
            const maxPreg   = cfg && cfg.MaxStats && cfg.MaxStats.pregnancy ? cfg.MaxStats.pregnancy : 100;
            const rows = [
                { label: t('stat_health'),    val: a.health    || 0, max: 100,      bar: true,  color: barClass(a.health    || 0, 100) },
                { label: t('stat_hungry'),    val: a.hungry    || 0, max: 100,      bar: true,  color: barClass(a.hungry    || 0, 100) },
                { label: t('stat_fertility'), val: a.fertility || 0, max: 100,      bar: true,  color: barClass(a.fertility || 0, 100) },
                { label: t('stat_weight'),    val: (a.weight   || 0).toFixed(1) + ' kg', max: maxWeight, bar: false },
                { label: t('stat_age'),       val: (a.age      || 0).toFixed(1),    max: maxAge, bar: true, color: 'high' },
            ];
            if ((a.pregnancy || 0) > 0 && !(cfg && cfg.EggLaying)) {
                rows.push({ label: t('stat_pregnancy'), val: a.pregnancy || 0, max: maxPreg, bar: true, color: 'blue' });
            }
            if (a.training !== undefined) {
                rows.push({ label: t('stat_training') || 'Treino', val: a.training || 0, max: 100, bar: true, color: barClass(a.training || 0, 100) });
            }
            return rows;
        },
    },
    mounted() {
        this._keyHandler = (e) => {
            if (!this.visible) return;
            if (e.key === 'Escape') {
                if (this.isSubPage) this.goBack();
                else this.close();
            }
        };
        window.addEventListener('keydown', this._keyHandler);
    },
    beforeUnmount() {
        window.removeEventListener('keydown', this._keyHandler);
    },
    methods: {
        t,
        barClass,
        statBarPct(row) {
            if (row.bar && typeof row.val === 'number') return Math.min(100, (row.val / row.max) * 100);
            return 0;
        },
        statDisplayVal(row) {
            if (typeof row.val === 'number') return Math.floor(row.val) + (row.max === 100 ? '%' : '');
            return row.val;
        },
        selectOption(opt) {
            this.activeId = opt.id;
            nuiFetch('interactAnimal:action', { id: opt.id });
        },
        goBack() {
            if (this.pageStack.length > 1) {
                this.pageStack.pop();
                this.activeId = null;
                nuiFetch('interactAnimal:back', {});
            }
        },
        close() {
            this.visible = false;
            nuiFetch('interactAnimal:close', {});
        },
        open(data) {
            this.animal    = data.animal;
            this.netId     = data.netId;
            this.animalCfg = data.animalCfg || null;
            this.pageStack = [{ title: data.animal ? data.animal.name : '—', options: data.options || [] }];
            this.activeId  = null;
            this.statusOpen = true;
            this.visible   = true;
        },
        // Abre um sub-menu dentro da NUI sem fechar
        pushPage(data) {
            this.pageStack.push({ title: data.title || '—', options: data.options || [] });
            this.activeId = null;
        },
    },
    template: `
    <div class="ia-wrapper" v-if="visible">
        <div class="ia-panel">

            <!-- Coluna: lista de acoes -->
            <div class="ia-menu-col">

                <!-- Header -->
                <div class="ia-header">
                    <img :src="iconUrl" class="ia-animal-icon" @error="$event.target.style.display='none'">
                    <div style="min-width:0;flex:1">
                        <div class="ia-animal-name">{{ currentTitle }}</div>
                        <div class="ia-animal-sub" v-if="!isSubPage">{{ animalSubLabel }}</div>
                        <div class="ia-animal-sub" v-else>{{ animal && animal.name }}</div>
                    </div>
                    <button class="animal-icon-btn" @click="statusOpen = !statusOpen"
                        :title="statusOpen ? (t('hide_status') || 'Ocultar status') : (t('show_status') || 'Ver status')">
                        <i :class="statusOpen ? 'fa-solid fa-chevron-right' : 'fa-solid fa-chart-bar'"></i>
                    </button>
                </div>
                <div class="ia-header-deco"></div>

                <!-- Opcoes -->
                <div class="ia-options">
                    <template v-for="(opt, idx) in currentOptions" :key="opt.id">
                        <div class="ia-section-sep" v-if="opt.section && idx > 0"></div>
                        <button class="ia-option" :class="{ active: activeId === opt.id }"
                            @click="selectOption(opt)">
                            <img :src="opt.icon" class="ia-option-icon"
                                @error="$event.target.style.display='none'">
                            <div class="ia-option-label">
                                <div>{{ opt.label }}</div>
                                <div v-if="opt.meta" class="ia-option-meta">
                                    <img v-if="opt.metaIcon" :src="opt.metaIcon" class="ia-option-meta-icon" @error="$event.target.style.display='none'">
                                    <span>{{ opt.meta }}</span>
                                </div>
                            </div>
                        </button>
                    </template>
                </div>

                <!-- Voltar / Fechar -->
                <button class="ia-close-btn" @click="isSubPage ? goBack() : close()">
                    <i :class="isSubPage ? 'fa-solid fa-arrow-left' : 'fa-solid fa-xmark'"></i>
                    {{ isSubPage ? (t('back') || 'Voltar') : (t('close') || 'Fechar') }}
                </button>
            </div>

            <!-- Coluna: status -->
            <div class="ia-status-col" :class="{ visible: statusOpen }">
                <div class="ia-status-title">{{ t('animal_status') || 'Status' }}</div>

                <template v-for="row in stats" :key="row.label">
                    <div class="ia-stat-row" v-if="row.bar">
                        <div class="ia-stat-label">
                            <span>{{ row.label }}</span>
                            <span>{{ statDisplayVal(row) }}</span>
                        </div>
                        <div class="ia-stat-bar-bg">
                            <div class="ia-stat-bar-fill" :class="row.color"
                                :style="{ width: statBarPct(row) + '%' }"></div>
                        </div>
                    </div>
                    <div class="ia-stat-plain" v-else>
                        {{ row.label }}: <strong>{{ row.val }}</strong>
                    </div>
                </template>

                <div class="ia-stat-badge" v-if="animal && animal.mark">
                    <i class="fa-solid fa-tag"></i> {{ animal.mark }}
                </div>
                <div class="ia-stat-plain" v-if="animal && animal.childrens">
                    {{ t('stat_childrens') || 'Filhotes' }}: {{ animal.childrens }}
                </div>
            </div>

        </div>
    </div>
    `,
};

function barClass(val, max) {
    const pct = (val / max) * 100;
    if (pct >= 60) return 'high';
    if (pct >= 30) return 'medium';
    return 'low';
}

const interactApp = Vue.createApp(InteractAnimalApp);
const interactVm  = interactApp.mount('#interact-app');

window.addEventListener('message', function(event) {
    const data = event.data;
    if (!data || !data.action) return;
    if (data.action === 'openInteractAnimal') {
        interactVm.open(data);
    } else if (data.action === 'openInteractSubPage') {
        interactVm.pushPage(data);
    } else if (data.action === 'closeInteractAnimal') {
        interactVm.visible = false;
    }
});
