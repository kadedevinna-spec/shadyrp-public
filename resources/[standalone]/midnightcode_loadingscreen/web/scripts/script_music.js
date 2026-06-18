import CONFIG from '../config_main.js'

const MUSIC_PLAYER = {
    audio: null,
    currentTrackIndex: 0,
    isMuted: false,
    isPlaying: false,
    favorites: [],

    init: function () {

        if (this.audio) return;

        if (!CONFIG.MUSIC.ENABLE || (CONFIG.VIDEO.ENABLE && !CONFIG.VIDEO.MUTE_VIDEO)) return;

        const list = CONFIG.MUSIC.MUSIC_LIST;
        const startingVolume = CONFIG.MUSIC.VOLUME;

        this.audio = new Audio();
        this.audio.volume = startingVolume / 100;

        const savedMuteState = localStorage.getItem('loadingscreen_muted');
        if (savedMuteState !== null) {
            this.isMuted = savedMuteState === 'true';
            this.audio.muted = this.isMuted;
        }

        this.loadFavorites();

        if (list && list.length > 0) {
            if (this.favorites.length > 0) {
                const randomFavoriteIndex = Math.floor(Math.random() * this.favorites.length);
                const favoriteName = this.favorites[randomFavoriteIndex];
                const trackIndex = list.findIndex(track => track.NAME === favoriteName);
                if (trackIndex !== -1) {
                    this.currentTrackIndex = trackIndex;
                } else {
                    this.currentTrackIndex = Math.floor(Math.random() * list.length);
                }
            } else {
                this.currentTrackIndex = Math.floor(Math.random() * list.length);
            }

            this.audio.src = `assets/audio/${list[this.currentTrackIndex].NAME}`;
            this.updateMusicTitle();
            this.audio.play().then(() => {
                this.isPlaying = true;
                this.updatePlayPauseButton();
            }).catch(err => {
                console.log('Autoplay blocked:', err);
                this.isPlaying = false;
                this.updatePlayPauseButton();
            });
        }

        this.audio.addEventListener('ended', () => {
            this.nextTrack();
        });

        this.setupControls();
    },

    setupControls: function () {
        if (!CONFIG.MUSIC.ENABLE_CONTROLS) {
            return;
        }

        const controlsDiv = document.getElementById('music-controls');
        const btnToggle = document.getElementById('btn-toggle-controls');
        const btnPrevious = document.getElementById('btn-previous');
        const btnPlayPause = document.getElementById('btn-play-pause');
        const btnNext = document.getElementById('btn-next');
        const btnMute = document.getElementById('btn-mute');
        const btnFavorite = document.getElementById('btn-favorite');
        const volumeSlider = document.getElementById('volume-slider');

        if (btnToggle) {
            btnToggle.classList.add('active');
        }

        if (controlsDiv) {
            controlsDiv.classList.add('active');
            controlsDiv.classList.add('hidden');
            controlsDiv.style.display = 'none';
        }

        if (btnToggle) {
            btnToggle.addEventListener('click', () => {
                if (controlsDiv) {
                    if (controlsDiv.classList.contains('hidden')) {
                        controlsDiv.style.display = 'flex';
                        setTimeout(() => {
                            controlsDiv.classList.add('visible');
                            controlsDiv.classList.remove('hidden');
                        }, 10);
                    } else {
                        const elementsToHide = [
                            { el: btnMute, delay: 100 },
                            { el: btnFavorite, delay: 200 },
                            { el: btnNext, delay: 300 },
                            { el: btnPlayPause, delay: 400 },
                            { el: btnPrevious, delay: 500 },
                            { el: volumeSlider, delay: 0 },
                            { el: document.getElementById('music-info'), delay: 600 }
                        ];

                        elementsToHide.forEach(item => {
                            if (item.el) {
                                setTimeout(() => {
                                    item.el.style.transition = 'opacity 0.3s ease, transform 0.3s ease';
                                    item.el.style.opacity = '0';
                                    item.el.style.transform = 'translateX(20px)';
                                }, item.delay);
                            }
                        });

                        setTimeout(() => {
                            controlsDiv.classList.add('hidden');
                            controlsDiv.style.display = 'none';
                            controlsDiv.classList.remove('visible');

                            elementsToHide.forEach(item => {
                                if (item.el) {
                                    item.el.style.transition = '';
                                    item.el.style.opacity = '';
                                    item.el.style.transform = '';
                                }
                            });
                        }, 1200);
                    }
                }
            });
        }

        if (btnPrevious) {
            btnPrevious.innerHTML = CONFIG.TRANSLATIONS.MUSIC_CONTROLS.BTN_PREVIOUS;
        }
        if (btnPlayPause) {
            btnPlayPause.innerHTML = this.isPlaying
                ? CONFIG.TRANSLATIONS.MUSIC_CONTROLS.BTN_PAUSE
                : CONFIG.TRANSLATIONS.MUSIC_CONTROLS.BTN_PLAY;
        }
        if (btnNext) {
            btnNext.innerHTML = CONFIG.TRANSLATIONS.MUSIC_CONTROLS.BTN_NEXT;
        }
        if (btnMute) {
            btnMute.innerHTML = this.isMuted
                ? CONFIG.TRANSLATIONS.MUSIC_CONTROLS.BTN_UNMUTE
                : CONFIG.TRANSLATIONS.MUSIC_CONTROLS.BTN_MUTE;
        }

        if (volumeSlider) {
            volumeSlider.value = CONFIG.MUSIC.VOLUME;
        }

        if (btnPrevious) {
            btnPrevious.addEventListener('click', () => {
                this.previousTrack();
            });
        }

        if (btnPlayPause) {
            btnPlayPause.addEventListener('click', () => {
                this.togglePlayPause();
                this.updatePlayPauseButton();
            });
        }

        if (btnNext) {
            btnNext.addEventListener('click', () => {
                this.nextTrack();
            });
        }

        if (btnMute) {
            btnMute.addEventListener('click', () => {
                this.toggleMute();
                btnMute.innerHTML = this.isMuted
                    ? CONFIG.TRANSLATIONS.MUSIC_CONTROLS.BTN_UNMUTE
                    : CONFIG.TRANSLATIONS.MUSIC_CONTROLS.BTN_MUTE;
            });
        }

        if (volumeSlider) {
            volumeSlider.addEventListener('input', (e) => {
                const volume = e.target.value;
                this.setVolume(volume);
            });
        }

        if (btnFavorite) {
            btnFavorite.addEventListener('click', () => {
                this.toggleFavorite();
            });
        }

        this.updateFavoriteButton();
    },

    nextTrack: function () {
        if (!this.audio || !CONFIG.MUSIC.MUSIC_LIST) return;

        this.currentTrackIndex = (this.currentTrackIndex + 1) % CONFIG.MUSIC.MUSIC_LIST.length;
        this.audio.src = `assets/audio/${CONFIG.MUSIC.MUSIC_LIST[this.currentTrackIndex].NAME}`;
        this.updateMusicTitle();
        this.updateFavoriteButton();
        this.audio.play();
    },

    previousTrack: function () {
        if (!this.audio || !CONFIG.MUSIC.MUSIC_LIST) return;

        this.currentTrackIndex = (this.currentTrackIndex - 1 + CONFIG.MUSIC.MUSIC_LIST.length) % CONFIG.MUSIC.MUSIC_LIST.length;
        this.audio.src = `assets/audio/${CONFIG.MUSIC.MUSIC_LIST[this.currentTrackIndex].NAME}`;
        this.updateMusicTitle();
        this.updateFavoriteButton();
        this.audio.play();
    },

    togglePlayPause: function () {
        if (!this.audio) return;

        if (this.isPlaying) {
            this.audio.pause();
            this.isPlaying = false;
        } else {
            this.audio.play();
            this.isPlaying = true;
        }
    },

    updatePlayPauseButton: function () {
        const btnPlayPause = document.getElementById('btn-play-pause');
        if (btnPlayPause) {
            btnPlayPause.innerHTML = this.isPlaying
                ? CONFIG.TRANSLATIONS.MUSIC_CONTROLS.BTN_PAUSE
                : CONFIG.TRANSLATIONS.MUSIC_CONTROLS.BTN_PLAY;
        }
    },

    updateMusicTitle: function () {
        const musicTitle = document.getElementById('music-title');
        if (musicTitle && CONFIG.MUSIC.MUSIC_LIST[this.currentTrackIndex]) {
            const track = CONFIG.MUSIC.MUSIC_LIST[this.currentTrackIndex];
            musicTitle.textContent = track.TITLE || '';
        }
    },

    toggleMute: function () {
        if (!this.audio) return;

        this.isMuted = !this.isMuted;
        this.audio.muted = this.isMuted;

        localStorage.setItem('loadingscreen_muted', this.isMuted);
    },

    setVolume: function (volume) {
        if (!this.audio) return;

        const normalizedVolume = Math.max(0, Math.min(100, volume)) / 100;
        this.audio.volume = normalizedVolume;
    },

    fadeOut: function (duration = 1000) {
        if (!this.audio) return;

        const startVolume = this.audio.volume;
        const fadeSteps = 50;
        const stepDuration = duration / fadeSteps;
        const volumeStep = startVolume / fadeSteps;

        let currentStep = 0;

        const fadeInterval = setInterval(() => {
            currentStep++;
            const newVolume = Math.max(0, startVolume - (volumeStep * currentStep));
            this.audio.volume = newVolume;

            if (currentStep >= fadeSteps || newVolume <= 0) {
                clearInterval(fadeInterval);
                this.audio.pause();
                this.audio.volume = startVolume;
            }
        }, stepDuration);
    },

    loadFavorites: function () {
        const savedFavorites = localStorage.getItem('loadingscreen_favorites');
        if (savedFavorites) {
            try {
                this.favorites = JSON.parse(savedFavorites);
            } catch (e) {
                console.error('Error loading favorites:', e);
                this.favorites = [];
            }
        } else {
            this.favorites = [];
        }
    },

    saveFavorites: function () {
        localStorage.setItem('loadingscreen_favorites', JSON.stringify(this.favorites));
    },

    toggleFavorite: function () {
        if (!CONFIG.MUSIC.MUSIC_LIST || this.currentTrackIndex < 0) return;

        const currentTrack = CONFIG.MUSIC.MUSIC_LIST[this.currentTrackIndex];
        const trackName = currentTrack.NAME;
        const index = this.favorites.indexOf(trackName);

        if (index === -1) {
            this.favorites.push(trackName);
        } else {
            this.favorites.splice(index, 1);
        }

        this.saveFavorites();
        this.updateFavoriteButton();
    },

    updateFavoriteButton: function () {
        const btnFavorite = document.getElementById('btn-favorite');
        if (!btnFavorite || !CONFIG.MUSIC.MUSIC_LIST || this.currentTrackIndex < 0) return;

        const currentTrack = CONFIG.MUSIC.MUSIC_LIST[this.currentTrackIndex];
        const trackName = currentTrack.NAME;
        const isFavorite = this.favorites.includes(trackName);

        if (isFavorite) {
            btnFavorite.innerHTML = CONFIG.TRANSLATIONS.MUSIC_CONTROLS.BTN_FAVORITE_REMOVE;
            btnFavorite.classList.add('active');
        } else {
            btnFavorite.innerHTML = CONFIG.TRANSLATIONS.MUSIC_CONTROLS.BTN_FAVORITE_ADD;
            btnFavorite.classList.remove('active');
        }
    }
};

export default MUSIC_PLAYER;