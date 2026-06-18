'use strict';

/* ═══════════════════════════════════════════════════════════════════
   BTC Ranchman — Shop Showroom Panel
   Layout: esquerda (seleção de tipo) | centro (livre p/ câmera) | direita (info animal)
   Comunicação: window.postMessage { action: 'openShopShowroom', ... }
                nuiFetch 'shopShowroomAction' para ações do jogador
   ═══════════════════════════════════════════════════════════════════ */

// ── Helpers ──────────────────────────────────────────────────────────
const st = (key) => (typeof Translate !== 'undefined' && Translate[key]) ? Translate[key] : key;

function shopNuiFetch(endpoint, data) {
    return fetch(`https://btc-ranchman/${endpoint}`, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json; charset=UTF-8' },
        body: JSON.stringify(data || {})
    }).catch(e => console.error('[btc-ranchman shop NUI]', endpoint, e));
}

function formatPrice(v) {
    return '$' + Number(v || 0).toLocaleString('pt-BR', { minimumFractionDigits: 2, maximumFractionDigits: 2 });
}

// ── Componente: Barra de stat (saúde, fome, etc.) ─────────────────────
const StatBar = {
    props: ['value', 'max', 'color'],
    computed: {
        pct() { return Math.min(Math.max((this.value / (this.max || 100)) * 100, 0), 100); },
        barColor() {
            if (this.color) return this.color;
            if (this.pct >= 70) return '#7ec87e';
            if (this.pct >= 35) return '#e8b84b';
            return '#e05252';
        },
    },
    template: `
    <div class="shop-stat-bar-bg">
        <div class="shop-stat-bar-fill" :style="{ width: pct + '%', background: barColor }"></div>
    </div>
    `
};

// ── App do Showroom ───────────────────────────────────────────────────
const ShopApp = {
    components: { StatBar },

    data() {
        return {
            visible: false,

            // Tipos disponíveis nesta loja
            shopId:     null,
            shopName:   '',
            animalTypes: [],          // [{ type, label, icon, animals: [...] }]
            animalConfigs: {},        // Config.Animals passada do Lua

            // Seleção atual
            selectedType:   null,     // string
            selectedAnimal: null,     // objeto animal { _id, name, type, sex, age, ... price }
            animalList:     [],       // lista do tipo selecionado

            // Paginação dentro do tipo
            page:      0,
            pageSize:  6,

            // Compra
            animalNameInput: '',

            // Câmera (controle JS)
            camKeys: { a: false, d: false, w: false, s: false },
            camRaf:  null,
        };
    },

    computed: {
        // Resumo por tipo (contagem)
        typeSummary() {
            return this.animalTypes.map(t => ({
                ...t,
                count: (t.animals || []).length,
                empty: !(t.animals && t.animals.length > 0),
            }));
        },

        totalPages() {
            return Math.ceil(this.animalList.length / this.pageSize);
        },

        pageItems() {
            const start = this.page * this.pageSize;
            return this.animalList.slice(start, start + this.pageSize);
        },

        // Config do tipo selecionado
        typeConfig() {
            if (!this.selectedType || !this.animalConfigs) return null;
            return this.animalConfigs[this.selectedType] || null;
        },

        maxAge() {
            return (this.typeConfig && this.typeConfig.MaxStats && this.typeConfig.MaxStats.age) || 100;
        },

        maxWeight() {
            return (this.typeConfig && this.typeConfig.MaxStats && this.typeConfig.MaxStats.weight) || 100;
        },

        // Dados do animal selecionado para exibição
        animalStats() {
            const a = this.selectedAnimal;
            if (!a) return [];
            const stats = [];
            if (a.health   != null) stats.push({ key: 'stat_health',    icon: 'fa-heart',           color: '#e05252', value: Math.floor(a.health),    suffix: '%' });
            if (a.hungry   != null) stats.push({ key: 'stat_hunger',    icon: 'fa-bowl-food',       color: '#e8b84b', value: Math.floor(a.hungry),    suffix: '%' });
            if (a.weight   != null) stats.push({ key: 'stat_weight',    icon: 'fa-weight-scale',    color: 'rgba(255,255,255,0.55)', value: Math.floor(a.weight),   suffix: '' });
            if (a.fertility!= null) stats.push({ key: 'stat_fertility', icon: 'fa-seedling',        color: '#a0d0a0', value: Math.floor(a.fertility), suffix: '%' });
            if (a.age      != null) stats.push({ key: 'stat_age',       icon: 'fa-hourglass-half',  color: 'rgba(255,255,255,0.4)', value: Math.floor(a.age),      suffix: '' });
            return stats;
        },

        hasPregnancy() {
            return this.selectedAnimal && this.selectedAnimal.pregnancy && this.selectedAnimal.pregnancy > 0;
        },

        pregnancyPct() {
            if (!this.selectedAnimal || !this.selectedAnimal.pregnancy) return 0;
            const maxP = (this.typeConfig && this.typeConfig.MaxStats && this.typeConfig.MaxStats.pregnancy) || 100;
            return Math.min((this.selectedAnimal.pregnancy / maxP) * 100, 100);
        },

        agePct() {
            if (!this.selectedAnimal || this.selectedAnimal.age == null) return 0;
            return Math.min((this.selectedAnimal.age / this.maxAge) * 100, 100);
        },

        canBuy() {
            return this.selectedAnimal != null && this.animalNameInput.trim().length > 0;
        },
    },

    methods: {
        st,
        formatPrice,

        // ── Câmera (A/D/W/S via JS → Lua) ──────────────────────────
        _startCamLoop() {
            const ROTATION_SPEED = 1.5;
            const ZOOM_SPEED     = 0.12;
            const tick = () => {
                if (!this.visible || !this.selectedAnimal) { this.camRaf = null; return; }
                const k = this.camKeys;
                if (k.a || k.d || k.w || k.s) {
                    shopNuiFetch('shopShowroomAction', {
                        action:        'camInput',
                        shopId:        this.shopId,
                        rotateLeft:    k.a,
                        rotateRight:   k.d,
                        zoomIn:        k.w,
                        zoomOut:       k.s,
                        rotationSpeed: ROTATION_SPEED,
                        zoomSpeed:     ZOOM_SPEED,
                    });
                }
                this.camRaf = requestAnimationFrame(tick);
            };
            if (!this.camRaf) this.camRaf = requestAnimationFrame(tick);
        },

        _stopCamLoop() {
            if (this.camRaf) { cancelAnimationFrame(this.camRaf); this.camRaf = null; }
        },

        _onKeyDown(e) {
            if (!this.visible || !this.selectedAnimal) return;
            // Não capturar quando o foco está no input de nome
            if (e.target && e.target.tagName === 'INPUT') return;
            const map = { a: 'a', d: 'd', w: 'w', s: 's' };
            const k = map[e.key.toLowerCase()];
            if (!k) return;
            e.preventDefault();
            if (!this.camKeys[k]) {
                this.camKeys[k] = true;
                this._startCamLoop();
            }
        },

        _onKeyUp(e) {
            const map = { a: 'a', d: 'd', w: 'w', s: 's' };
            const k = map[e.key.toLowerCase()];
            if (k) this.camKeys[k] = false;
        },

        // ── Ações de navegação ──────────────────────────────────────
        selectType(typeEntry) {
            if (typeEntry.empty) return;
            this.selectedType   = typeEntry.type;
            this.animalList     = typeEntry.animals || [];
            this.page           = 0;
            this.selectedAnimal = this.animalList[0] || null;
            // Spawn do primeiro animal no showroom via Lua
            if (this.selectedAnimal) {
                shopNuiFetch('shopShowroomAction', {
                    action:    'previewAnimal',
                    shopId:    this.shopId,
                    animalId:  this.selectedAnimal._id,
                    animalData: this.selectedAnimal,
                });
            }
        },

        selectAnimal(a) {
            this.selectedAnimal = a;
            this.animalNameInput = '';
            shopNuiFetch('shopShowroomAction', {
                action:    'previewAnimal',
                shopId:    this.shopId,
                animalId:  a._id,
                animalData: a,
            });
        },

        prevPage() { if (this.page > 0) { this.page--; } },
        nextPage() { if (this.page < this.totalPages - 1) { this.page++; } },

        backToTypes() {
            this.selectedType    = null;
            this.selectedAnimal  = null;
            this.animalList      = [];
            this.animalNameInput = '';
            shopNuiFetch('shopShowroomAction', { action: 'clearPreview', shopId: this.shopId });
        },

        // ── Comprar ─────────────────────────────────────────────────
        buyAnimal() {
            if (!this.selectedAnimal) return;
            shopNuiFetch('shopShowroomAction', {
                action:     'buyAnimal',
                shopId:     this.shopId,
                animalId:   this.selectedAnimal._id,
                animalName: this.animalNameInput.trim() || null,
            });
            this.close();
        },

        // ── Fechar ───────────────────────────────────────────────────
        close() {
            this._stopCamLoop();
            this.camKeys = { a: false, d: false, w: false, s: false };
            this.visible = false;
            shopNuiFetch('shopShowroomAction', { action: 'closeShopShowroom', shopId: this.shopId });
        },

        // ── Abrir (chamado pelo listener de message) ─────────────────
        open(data) {
            this.shopId        = data.shopId        || null;
            this.shopName      = data.shopName      || '';
            this.animalTypes   = data.animalTypes   || [];
            this.animalConfigs = data.animalConfigs || {};
            this.selectedType   = null;
            this.selectedAnimal = null;
            this.animalList     = [];
            this.page           = 0;
            this.visible        = true;
        },

        // ── Helpers de ícone ─────────────────────────────────────────
        typeIconUrl(type) {
            return `../images/${type}_Male.png`;
        },
        animalIconUrl(a) {
            const g = a.sex === 'Female' ? 'Female' : 'Male';
            return `../images/${a.type}_${g}.png`;
        },

        isSelected(a) {
            return this.selectedAnimal && this.selectedAnimal._id === a._id;
        },
    },

    mounted() {
        window.addEventListener('message', event => {
            const { action } = event.data;
            if (action === 'openShopShowroom') {
                this.open(event.data);
            } else if (action === 'closeShopShowroom') {
                this.visible = false;
            } else if (action === 'updateShopList') {
                // Atualiza a lista de animais de um tipo (ex: após compra)
                if (event.data.animalType && event.data.animals) {
                    const entry = this.animalTypes.find(t => t.type === event.data.animalType);
                    if (entry) {
                        entry.animals = event.data.animals;
                        if (this.selectedType === event.data.animalType) {
                            this.animalList = event.data.animals;
                            if (!this.animalList.find(a => this.selectedAnimal && a._id === this.selectedAnimal._id)) {
                                this.selectedAnimal = this.animalList[0] || null;
                            }
                        }
                    }
                }
            }
        });

        document.addEventListener('keydown', e => {
            if (e.key === 'Escape' && this.visible) { this.close(); return; }
            this._onKeyDown(e);
        });
        document.addEventListener('keyup', e => { this._onKeyUp(e); });
    },

    template: `
    <div v-if="visible" class="shop-overlay">

        <!-- ══ ESQUERDA: Seleção de tipo de animal ══════════════════ -->
        <div class="shop-sidebar-left">

            <!-- Header da loja -->
            <div class="shop-sidebar-title">
                <i class="fa-solid fa-store"></i>
                <span>{{ shopName || st('shop_title') }}</span>
            </div>

            <div class="shop-divider"></div>

            <!-- Botão voltar (quando tipo selecionado) -->
            <button v-if="selectedType" class="shop-back-btn" @click="backToTypes">
                <i class="fa-solid fa-chevron-left"></i> {{ st('back') }}
            </button>

            <!-- Grid de tipos -->
            <div v-if="!selectedType" class="shop-type-list">
                <div
                    v-for="ts in typeSummary" :key="ts.type"
                    class="shop-type-item"
                    :class="{ empty: ts.empty, active: selectedType === ts.type }"
                    @click="selectType(ts)"
                >
                    <img :src="typeIconUrl(ts.type)" class="shop-type-icon" :alt="ts.type" @error="$event.target.style.display='none'">
                    <div class="shop-type-info">
                        <div class="shop-type-name">{{ ts.label || ts.type }}</div>
                        <div class="shop-type-count" v-if="!ts.empty">{{ ts.count }} {{ st('shop_available') }}</div>
                        <div class="shop-type-empty" v-else>{{ st('empty') }}</div>
                    </div>
                </div>
            </div>

            <!-- Lista de animais do tipo (miniaturas) -->
            <div v-else class="shop-animal-mini-list">
                <div class="shop-type-label">
                    <img :src="typeIconUrl(selectedType)" class="shop-type-icon-sm" @error="$event.target.style.display='none'">
                    <span>{{ selectedType }}</span>
                </div>

                <div
                    v-for="a in pageItems" :key="a._id"
                    class="shop-animal-mini-item"
                    :class="{ active: isSelected(a) }"
                    @click="selectAnimal(a)"
                >
                    <img :src="animalIconUrl(a)" class="shop-animal-mini-icon" :alt="a.type" @error="$event.target.style.display='none'">
                    <div class="shop-animal-mini-info">
                        <div class="shop-animal-mini-name">{{ a.name || a.type }}</div>
                        <div class="shop-animal-mini-sex">{{ a.sex === 'Female' ? st('female') : st('male') }}</div>
                    </div>
                    <div class="shop-animal-mini-price" v-if="a.price">{{ formatPrice(a.price) }}</div>
                </div>

                <!-- Paginação -->
                <div class="shop-pagination" v-if="totalPages > 1">
                    <button class="shop-page-btn" :disabled="page === 0" @click="prevPage()">‹</button>
                    <span class="shop-page-info">{{ page + 1 }} / {{ totalPages }}</span>
                    <button class="shop-page-btn" :disabled="page >= totalPages - 1" @click="nextPage()">›</button>
                </div>
            </div>

            <!-- Fechar -->
            <div style="margin-top:auto;padding-top:1rem">
                <button class="shop-close-btn" @click="close">
                    <i class="fa-solid fa-xmark"></i> {{ st('close') }}
                </button>
            </div>
        </div>

        <!-- ══ CENTRO: Área livre para câmera (totalmente transparente) ═ -->
        <div class="shop-center-stage">

            <!-- Estado vazio quando nenhum tipo selecionado -->
            <div class="shop-center-placeholder" v-if="!selectedType">
                <i class="fa-solid fa-arrow-left" style="margin-right:0.5rem"></i>
                {{ st('shop_select_type') }}
            </div>

            <!-- Painel de controles da câmera (aparece quando há animal) -->
            <div class="shop-controls-panel" v-if="selectedAnimal">
                <!-- Rotação -->
                <div class="shop-control-group">
                    <div class="shop-control-label">
                        <i class="fa-solid fa-rotate"></i>
                        {{ st('shop_rotate_hint') }}
                    </div>
                    <div class="shop-control-keys">
                        <div class="shop-key-item">
                            <div class="shop-key-cap" :class="{ active: camKeys.a }">A</div>
                            <div class="shop-key-desc">{{ st('shop_rotate_left') }}</div>
                        </div>
                        <div class="shop-key-item">
                            <div class="shop-key-cap" :class="{ active: camKeys.d }">D</div>
                            <div class="shop-key-desc">{{ st('shop_rotate_right') }}</div>
                        </div>
                    </div>
                </div>
                <!-- Divisor vertical -->
                <div class="shop-controls-sep"></div>
                <!-- Zoom -->
                <div class="shop-control-group">
                    <div class="shop-control-label">
                        <i class="fa-solid fa-magnifying-glass"></i>
                        {{ st('shop_zoom_hint') }}
                    </div>
                    <div class="shop-control-keys">
                        <div class="shop-key-item">
                            <div class="shop-key-cap" :class="{ active: camKeys.w }">W</div>
                            <div class="shop-key-desc">{{ st('shop_zoom_in') }}</div>
                        </div>
                        <div class="shop-key-item">
                            <div class="shop-key-cap" :class="{ active: camKeys.s }">S</div>
                            <div class="shop-key-desc">{{ st('shop_zoom_out') }}</div>
                        </div>
                    </div>
                </div>
            </div>

        </div>

        <!-- ══ DIREITA: Informações do animal selecionado ════════════ -->
        <div class="shop-sidebar-right" v-if="selectedAnimal">

            <!-- Nome e sexo -->
            <div class="shop-animal-header">
                <img :src="animalIconUrl(selectedAnimal)" class="shop-animal-header-icon" @error="$event.target.style.display='none'">
                <div class="shop-animal-header-info">
                    <div class="shop-animal-header-name">{{ selectedAnimal.name || selectedAnimal.type }}</div>
                    <div class="shop-animal-header-badges">
                        <span class="animal-badge">{{ selectedAnimal.sex === 'Female' ? st('female') : st('male') }}</span>
                        <span class="animal-badge mark" v-if="selectedAnimal.mark">{{ st('marked') }}</span>
                        <span class="animal-badge pregnant" v-if="hasPregnancy">{{ st('pregnant') }}</span>
                    </div>
                </div>
            </div>

            <div class="shop-divider"></div>

            <!-- Stats individuais com barras -->
            <div class="shop-stats-list">
                <div class="shop-stat-row" v-for="s in animalStats" :key="s.key">
                    <div class="shop-stat-label">
                        <i :class="'fa-solid ' + s.icon" :style="{ color: s.color }"></i>
                        {{ st(s.key) }}
                    </div>
                    <div class="shop-stat-value">{{ s.value }}{{ s.suffix }}</div>
                    <stat-bar :value="s.value" :max="s.key === 'stat_age' ? maxAge : (s.key === 'stat_weight' ? maxWeight : 100)" :color="s.key === 'stat_age' ? 'rgba(255,255,255,0.4)' : null" />
                </div>
            </div>

            <!-- Gestação -->
            <div class="shop-pregnancy-block" v-if="hasPregnancy">
                <div class="shop-stat-label" style="margin-bottom:0.35rem">
                    <i class="fa-solid fa-baby" style="color:#a0c8ff"></i>
                    {{ st('gestation') }} {{ Math.floor(pregnancyPct) }}%
                </div>
                <div class="shop-stat-bar-bg">
                    <div class="shop-stat-bar-fill" style="background:#a0c8ff" :style="{ width: pregnancyPct + '%' }"></div>
                </div>
            </div>

            <div class="shop-divider" style="margin-top:auto"></div>

            <!-- Nome + preço + botão comprar -->
            <div class="shop-buy-block">
                <div class="shop-price-label" v-if="selectedAnimal.price">
                    {{ formatPrice(selectedAnimal.price) }}
                </div>
                <div>
                    <div class="shop-name-label">{{ st('shop_animal_name') }}</div>
                    <input
                        class="shop-name-input"
                        type="text"
                        maxlength="24"
                        v-model="animalNameInput"
                        :placeholder="st('shop_name_placeholder')"
                        @keyup.enter="buyAnimal"
                    >
                </div>
                <button class="shop-buy-btn" :disabled="!canBuy" @click="buyAnimal">
                    <i class="fa-solid fa-cart-shopping"></i>
                    {{ st('shop_buy') }}
                </button>
            </div>

        </div>

        <!-- Placeholder direita quando sem seleção -->
        <div class="shop-sidebar-right shop-sidebar-right--empty" v-else-if="selectedType">
            <div class="shop-center-placeholder">
                <i class="fa-solid fa-arrow-left" style="margin-right:0.5rem"></i>
                {{ st('shop_select_animal') }}
            </div>
        </div>

    </div>
    `
};

Vue.createApp(ShopApp).mount('#shop-app');
