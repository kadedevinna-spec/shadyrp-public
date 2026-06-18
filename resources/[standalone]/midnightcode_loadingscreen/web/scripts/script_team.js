import SERVER from '../config_staff.js';

const TEAM_SYSTEM = {
    isTeamVisible: false,
    isHintsVisible: false,
    isNewsVisible: false,
    isRulesVisible: false,
    isDragging: false,
    startX: 0,
    currentRotation: 0,
    autoScrollInterval: null,
    idleTimeout: null,
    autoScrollSpeed: 0.2,
    cardAngles: [],

    init: function () {
        const btnTeam = document.getElementById('btn-team');
        const btnHints = document.getElementById('btn-hints');
        const btnNews = document.getElementById('btn-news');
        const btnRules = document.getElementById('btn-rules');

        if (btnTeam) {
            btnTeam.addEventListener('click', () => {
                this.toggleTeam();
            });
        }

        if (btnHints) {
            btnHints.addEventListener('click', () => {
                this.toggleHints();
            });
        }

        if (btnNews) {
            btnNews.addEventListener('click', () => {
                this.toggleNews();
            });
        }

        if (btnRules) {
            btnRules.addEventListener('click', () => {
                this.toggleRules();
            });
        }

        this.generateTeamCards();
        this.generateHintCards();
        this.generateNewsCards();
        this.generateRulesCards();

        this.setupDragScroll('team-cards-wrapper');
        this.setupDragScroll('hints-cards-wrapper');
        this.setupDragScroll('news-cards-wrapper');
        this.setupDragScroll('rules-cards-wrapper');
    },

    generateTeamCards: function () {
        const wrapper = document.getElementById('team-cards-wrapper');
        if (!wrapper || !SERVER.CARDS) return;

        wrapper.innerHTML = '';

        SERVER.CARDS.forEach((member, index) => {
            const card = document.createElement('div');
            card.className = 'team-card';
            card.dataset.index = index;

            card.innerHTML = `
                <img src="${member.IMAGE}" alt="${member.NAME}" class="card-image">
                <div class="card-title">${member.NAME}</div>
                <div class="card-role">${member.ROLE}</div>
                <div class="card-description">${member.DESCRIPTION}</div>
            `;

            card.style.display = 'none';
            card.style.opacity = '0';
            wrapper.appendChild(card);
        });

    },

    generateHintCards: function () {
        const wrapper = document.getElementById('hints-cards-wrapper');
        if (!wrapper || !SERVER.HINTS) return;

        wrapper.innerHTML = '';

        SERVER.HINTS.forEach((hint, index) => {
            const card = document.createElement('div');
            card.className = 'hint-card';
            card.dataset.index = index;

            card.innerHTML = `
                <img src="${hint.IMAGE}" alt="${hint.NAME}" class="card-image">
                <div class="card-title">${hint.NAME}</div>
                <div class="card-description">${hint.DESCRIPTION}</div>
            `;

            card.style.display = 'none';
            card.style.opacity = '0';
            wrapper.appendChild(card);
        });

    },

    generateNewsCards: function () {
        const wrapper = document.getElementById('news-cards-wrapper');
        if (!wrapper || !SERVER.NEWS) return;

        wrapper.innerHTML = '';

        SERVER.NEWS.forEach((news, index) => {
            const card = document.createElement('div');
            card.className = 'news-card';
            card.dataset.index = index;

            card.innerHTML = `
                <img src="${news.IMAGE}" alt="${news.TITLE}" class="card-image">
                <div class="card-title">${news.TITLE}</div>
                <div class="card-description">${news.DESCRIPTION}</div>
            `;

            card.style.display = 'none';
            card.style.opacity = '0';
            wrapper.appendChild(card);
        });

    },

    generateRulesCards: function () {
        const wrapper = document.getElementById('rules-cards-wrapper');
        if (!wrapper || !SERVER.RULES) return;

        wrapper.innerHTML = '';

        SERVER.RULES.forEach((rule, index) => {
            const card = document.createElement('div');
            card.className = 'rules-card';
            card.dataset.index = index;

            card.innerHTML = `
                <div class="card-title">${rule.TITLE}</div>
                <div class="card-description">${rule.DESCRIPTION}</div>
            `;

            card.style.display = 'none';
            card.style.opacity = '0';
            wrapper.appendChild(card);
        });

    },

    toggleTeam: function () {
        const container = document.getElementById('team-cards-container');
        const btnTeam = document.getElementById('btn-team');
        const cards = container.querySelectorAll('.team-card');
        const wrapper = document.getElementById('team-cards-wrapper');


        if (this.isTeamVisible) {
            this.stopAutoScroll();

            this.hideCardsStaggered(cards, () => {
                container.classList.remove('active');
                this.isTeamVisible = false;
            });
            btnTeam.classList.remove('active');
        } else {
            if (this.isHintsVisible) {
                const hintsContainer = document.getElementById('hints-cards-container');
                const hintCards = hintsContainer.querySelectorAll('.hint-card');
                const btnHints = document.getElementById('btn-hints');

                this.stopAutoScroll();

                this.hideCardsStaggered(hintCards, () => {
                    hintsContainer.classList.remove('active');
                    this.isHintsVisible = false;
                    btnHints.classList.remove('active');

                    container.classList.add('active');
                    btnTeam.classList.add('active');
                    this.isTeamVisible = true;

                    this.showCardsStaggered(cards, wrapper);

                    this.startIdleTimer(wrapper);
                });
            } else if (this.isNewsVisible) {
                const newsContainer = document.getElementById('news-cards-container');
                const newsCards = newsContainer.querySelectorAll('.news-card');
                const btnNews = document.getElementById('btn-news');

                this.stopAutoScroll();

                this.hideCardsStaggered(newsCards, () => {
                    newsContainer.classList.remove('active');
                    this.isNewsVisible = false;
                    btnNews.classList.remove('active');

                    container.classList.add('active');
                    btnTeam.classList.add('active');
                    this.isTeamVisible = true;

                    this.showCardsStaggered(cards, wrapper);

                    this.startIdleTimer(wrapper);
                });
            } else if (this.isRulesVisible) {
                const rulesContainer = document.getElementById('rules-cards-container');
                const rulesCards = rulesContainer.querySelectorAll('.rules-card');
                const btnRules = document.getElementById('btn-rules');

                this.stopAutoScroll();

                this.hideCardsStaggered(rulesCards, () => {
                    rulesContainer.classList.remove('active');
                    this.isRulesVisible = false;
                    btnRules.classList.remove('active');

                    container.classList.add('active');
                    btnTeam.classList.add('active');
                    this.isTeamVisible = true;

                    this.showCardsStaggered(cards, wrapper);

                    this.startIdleTimer(wrapper);
                });
            } else {
                container.classList.add('active');
                btnTeam.classList.add('active');
                this.isTeamVisible = true;

                this.showCardsStaggered(cards, wrapper);

                this.startIdleTimer(wrapper);
            }
        }
    },

    toggleHints: function () {
        const container = document.getElementById('hints-cards-container');
        const btnHints = document.getElementById('btn-hints');
        const cards = container.querySelectorAll('.hint-card');
        const wrapper = document.getElementById('hints-cards-wrapper');


        if (this.isHintsVisible) {
            this.stopAutoScroll();

            this.hideCardsStaggered(cards, () => {
                container.classList.remove('active');
                this.isHintsVisible = false;
            });
            btnHints.classList.remove('active');
        } else {
            if (this.isTeamVisible) {
                const teamContainer = document.getElementById('team-cards-container');
                const teamCards = teamContainer.querySelectorAll('.team-card');
                const btnTeam = document.getElementById('btn-team');

                this.stopAutoScroll();

                this.hideCardsStaggered(teamCards, () => {
                    teamContainer.classList.remove('active');
                    this.isTeamVisible = false;
                    btnTeam.classList.remove('active');

                    container.classList.add('active');
                    btnHints.classList.add('active');
                    this.isHintsVisible = true;

                    this.showCardsStaggered(cards, wrapper);

                    this.startIdleTimer(wrapper);
                });
            } else if (this.isNewsVisible) {
                const newsContainer = document.getElementById('news-cards-container');
                const newsCards = newsContainer.querySelectorAll('.news-card');
                const btnNews = document.getElementById('btn-news');

                this.stopAutoScroll();

                this.hideCardsStaggered(newsCards, () => {
                    newsContainer.classList.remove('active');
                    this.isNewsVisible = false;
                    btnNews.classList.remove('active');

                    container.classList.add('active');
                    btnHints.classList.add('active');
                    this.isHintsVisible = true;

                    this.showCardsStaggered(cards, wrapper);

                    this.startIdleTimer(wrapper);
                });
            } else if (this.isRulesVisible) {
                const rulesContainer = document.getElementById('rules-cards-container');
                const rulesCards = rulesContainer.querySelectorAll('.rules-card');
                const btnRules = document.getElementById('btn-rules');

                this.stopAutoScroll();

                this.hideCardsStaggered(rulesCards, () => {
                    rulesContainer.classList.remove('active');
                    this.isRulesVisible = false;
                    btnRules.classList.remove('active');

                    container.classList.add('active');
                    btnHints.classList.add('active');
                    this.isHintsVisible = true;

                    this.showCardsStaggered(cards, wrapper);

                    this.startIdleTimer(wrapper);
                });
            } else {
                container.classList.add('active');
                btnHints.classList.add('active');
                this.isHintsVisible = true;

                this.showCardsStaggered(cards, wrapper);

                this.startIdleTimer(wrapper);
            }
        }
    },

    toggleNews: function () {
        const container = document.getElementById('news-cards-container');
        const btnNews = document.getElementById('btn-news');
        const cards = container.querySelectorAll('.news-card');
        const wrapper = document.getElementById('news-cards-wrapper');

        if (this.isNewsVisible) {
            this.stopAutoScroll();

            this.hideCardsStaggered(cards, () => {
                container.classList.remove('active');
                this.isNewsVisible = false;
            });
            btnNews.classList.remove('active');
        } else {
            if (this.isTeamVisible) {
                const teamContainer = document.getElementById('team-cards-container');
                const teamCards = teamContainer.querySelectorAll('.team-card');
                const btnTeam = document.getElementById('btn-team');

                this.stopAutoScroll();

                this.hideCardsStaggered(teamCards, () => {
                    teamContainer.classList.remove('active');
                    this.isTeamVisible = false;
                    btnTeam.classList.remove('active');

                    container.classList.add('active');
                    btnNews.classList.add('active');
                    this.isNewsVisible = true;

                    this.showCardsStaggered(cards, wrapper);

                    this.startIdleTimer(wrapper);
                });
            } else if (this.isHintsVisible) {
                const hintsContainer = document.getElementById('hints-cards-container');
                const hintsCards = hintsContainer.querySelectorAll('.hint-card');
                const btnHints = document.getElementById('btn-hints');

                this.stopAutoScroll();

                this.hideCardsStaggered(hintsCards, () => {
                    hintsContainer.classList.remove('active');
                    this.isHintsVisible = false;
                    btnHints.classList.remove('active');

                    container.classList.add('active');
                    btnNews.classList.add('active');
                    this.isNewsVisible = true;

                    this.showCardsStaggered(cards, wrapper);

                    this.startIdleTimer(wrapper);
                });
            } else if (this.isRulesVisible) {
                const rulesContainer = document.getElementById('rules-cards-container');
                const rulesCards = rulesContainer.querySelectorAll('.rules-card');
                const btnRules = document.getElementById('btn-rules');

                this.stopAutoScroll();

                this.hideCardsStaggered(rulesCards, () => {
                    rulesContainer.classList.remove('active');
                    this.isRulesVisible = false;
                    btnRules.classList.remove('active');

                    container.classList.add('active');
                    btnNews.classList.add('active');
                    this.isNewsVisible = true;

                    this.showCardsStaggered(cards, wrapper);

                    this.startIdleTimer(wrapper);
                });
            } else {
                container.classList.add('active');
                btnNews.classList.add('active');
                this.isNewsVisible = true;

                this.showCardsStaggered(cards, wrapper);

                this.startIdleTimer(wrapper);
            }
        }
    },

    toggleRules: function () {
        const container = document.getElementById('rules-cards-container');
        const btnRules = document.getElementById('btn-rules');
        const cards = container.querySelectorAll('.rules-card');
        const wrapper = document.getElementById('rules-cards-wrapper');

        if (this.isRulesVisible) {
            this.stopAutoScroll();

            this.hideCardsStaggered(cards, () => {
                container.classList.remove('active');
                this.isRulesVisible = false;
            });
            btnRules.classList.remove('active');
        } else {
            if (this.isTeamVisible) {
                const teamContainer = document.getElementById('team-cards-container');
                const teamCards = teamContainer.querySelectorAll('.team-card');
                const btnTeam = document.getElementById('btn-team');

                this.stopAutoScroll();

                this.hideCardsStaggered(teamCards, () => {
                    teamContainer.classList.remove('active');
                    this.isTeamVisible = false;
                    btnTeam.classList.remove('active');

                    container.classList.add('active');
                    btnRules.classList.add('active');
                    this.isRulesVisible = true;

                    this.showCardsStaggered(cards, wrapper);

                    this.startIdleTimer(wrapper);
                });
            } else if (this.isHintsVisible) {
                const hintsContainer = document.getElementById('hints-cards-container');
                const hintsCards = hintsContainer.querySelectorAll('.hint-card');
                const btnHints = document.getElementById('btn-hints');

                this.stopAutoScroll();

                this.hideCardsStaggered(hintsCards, () => {
                    hintsContainer.classList.remove('active');
                    this.isHintsVisible = false;
                    btnHints.classList.remove('active');

                    container.classList.add('active');
                    btnRules.classList.add('active');
                    this.isRulesVisible = true;

                    this.showCardsStaggered(cards, wrapper);

                    this.startIdleTimer(wrapper);
                });
            } else if (this.isNewsVisible) {
                const newsContainer = document.getElementById('news-cards-container');
                const newsCards = newsContainer.querySelectorAll('.news-card');
                const btnNews = document.getElementById('btn-news');

                this.stopAutoScroll();

                this.hideCardsStaggered(newsCards, () => {
                    newsContainer.classList.remove('active');
                    this.isNewsVisible = false;
                    btnNews.classList.remove('active');

                    container.classList.add('active');
                    btnRules.classList.add('active');
                    this.isRulesVisible = true;

                    this.showCardsStaggered(cards, wrapper);

                    this.startIdleTimer(wrapper);
                });
            } else {
                container.classList.add('active');
                btnRules.classList.add('active');
                this.isRulesVisible = true;

                this.showCardsStaggered(cards, wrapper);

                this.startIdleTimer(wrapper);
            }
        }
    },

    showCardsStaggered: function (cards, wrapper) {
        if (wrapper) {
            this.updateCircularPositions(wrapper);
        }

        cards.forEach((card, index) => {
            setTimeout(() => {
                card.classList.add('visible');
                card.classList.remove('hiding');
                card.style.display = 'flex';
            }, index * 20);
        });
    },

    hideCardsStaggered: function (cards, callback) {
        const cardsArray = Array.from(cards);

        cardsArray.forEach((card, index) => {
            setTimeout(() => {
                card.classList.add('hiding');
                card.classList.remove('visible');
                card.style.opacity = '0';
                card.style.display = 'none';
            }, index * 15);
        });

        setTimeout(() => {
            if (callback) callback();
        }, cardsArray.length * 30 + 50);
    },

    setupDragScroll: function (wrapperId) {
        const wrapper = document.getElementById(wrapperId);
        if (!wrapper) return;

        let startRotation = 0;
        this.isDragging = false;

        wrapper.addEventListener('mousedown', (e) => {
            this.isDragging = true;
            this.stopAutoScroll();
            wrapper.style.cursor = 'grabbing';
            this.startX = e.pageX;
            startRotation = this.currentRotation;
        });

        wrapper.addEventListener('mousemove', (e) => {
            if (!this.isDragging) return;
            e.preventDefault();
            const deltaX = e.pageX - this.startX;
            const rotationSpeed = 0.2;
            this.currentRotation = startRotation + deltaX * rotationSpeed;
            this.updateCircularPositions(wrapper);
        });

        const endDrag = () => {
            if (!this.isDragging) return;
            this.isDragging = false;
            wrapper.style.cursor = 'grab';
            if (this.isTeamVisible || this.isHintsVisible) this.startIdleTimer(wrapper);
        };

        wrapper.addEventListener('mouseup', endDrag);
        wrapper.addEventListener('mouseleave', endDrag);

        let clickStartX = 0;
        wrapper.addEventListener('mousedown', (e) => (clickStartX = e.pageX));
        wrapper.addEventListener('click', (e) => {
            if (Math.abs(e.pageX - clickStartX) > 5) e.preventDefault();
        });
    },



    updateCircularPositions: function (wrapper) {
        if (!wrapper) return;

        const cards = wrapper.querySelectorAll('.team-card, .hint-card, .news-card, .rules-card');
        const n = cards.length;
        if (!n) return;

        const step = 360 / n;
        const RADIUS = 600;
        const SLOT_SPACING_DEG = 30;

        const mod = (i, m) => ((i % m) + m) % m;

        const k = -this.currentRotation / step;
        const base = Math.round(k);
        const frac = k - base;

        cards.forEach(c => {
            c.style.display = 'none';
            c.style.opacity = '0';
            c.style.visibility = 'hidden';
        });

        for (let s = -2; s <= 2; s++) {
            const idx = mod(base + s, n);
            const card = cards[idx];
            if (!card) continue;

            const angle = (s - frac) * SLOT_SPACING_DEG;
            const rad = angle * Math.PI / 180;

            const x = Math.sin(rad) * RADIUS;
            const z = Math.cos(rad) * RADIUS;

            const t = Math.min(Math.abs(s - frac) / 2, 1);
            const scale = 1 - 0.3 * t;
            const opacity = 1 - 0.4 * t;

            card.style.position = 'absolute';
            card.style.left = '50%';
            card.style.top = '50%';
            card.style.transformOrigin = 'center center';
            card.style.transform = `translate(-50%, -50%) translate3d(${x}px, 0, ${z}px) scale(${scale})`;
            card.style.zIndex = 1000 + Math.round(z);
            card.style.opacity = opacity;
            card.style.display = 'flex';
            card.style.visibility = 'visible';
        }
    },



    startIdleTimer: function (wrapper) {

        this.stopAutoScroll();
        if (this.idleTimeout) {
            clearTimeout(this.idleTimeout);
        }

        this.idleTimeout = setTimeout(() => {
            this.startAutoScroll(wrapper);
        }, 3000);
    },

    startAutoScroll: function (wrapper) {
        if (!wrapper) return;

        this.autoScrollInterval = setInterval(() => {
            this.currentRotation += this.autoScrollSpeed;
            this.updateCircularPositions(wrapper);
        }, 16); // ~60fps
    },

    stopAutoScroll: function () {
        if (this.autoScrollInterval) {
            clearInterval(this.autoScrollInterval);
            this.autoScrollInterval = null;
        }
        if (this.idleTimeout) {
            clearTimeout(this.idleTimeout);
            this.idleTimeout = null;
        }
    },

    show: function () {
        const infoButtons = document.getElementById('info-buttons');
        if (infoButtons) {
            infoButtons.classList.add('visible');
        }
    },

    hide: function () {
        const infoButtons = document.getElementById('info-buttons');
        if (infoButtons) {
            infoButtons.classList.remove('visible');
        }

        if (this.isTeamVisible) {
            this.toggleTeam();
        }
        if (this.isHintsVisible) {
            this.toggleHints();
        }
    }
};

export default TEAM_SYSTEM;

