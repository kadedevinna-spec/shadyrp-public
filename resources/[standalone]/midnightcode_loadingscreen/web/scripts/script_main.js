import IMAGES_SCREEN from './script_images.js'
import MUSIC_PLAYER from './script_music.js'
import DYNAMITE_FUSE from './script_dynamite.js'
import TEAM_SYSTEM from './script_team.js'
import VIDEO_PLAYER from './script_video.js'
import CONFIG from '../config_main.js'

document.addEventListener('DOMContentLoaded', function () {
    const LOADING_SCREEN = {
        currentProgress: 0,
        isStarted: false,
        isComplete: false,
        userInfoAdded: false,
        buttonListenerAdded: false,

        UpdateUserInfo: function (data) {
            if (!data) return;

            const userAvatar = document.querySelector('#user-avatar img');
            const userName = document.getElementById('user-name');
            const userRole = document.getElementById('user-role');
            const playerCountText = document.getElementById('player-count-text');

            if (data.avatarUrl && userAvatar) {
                userAvatar.src = data.avatarUrl;
            }

            if (data.username && userName) {
                userName.textContent = data.username;
            }

            if (data.role && userRole) {
                userRole.textContent = data.role;
                userRole.style.display = 'block';
            } else if (userRole) {
                userRole.style.display = 'none';
            }

            if (data.currentPlayers !== undefined && data.maxPlayers !== undefined && playerCountText) {
                playerCountText.textContent = `${data.currentPlayers}/${data.maxPlayers}`;
            }
        },

        Start: function () {
            if (this.isStarted) return;
            this.isStarted = true;
            document.body.classList.add('loaded');

            window.LOADING_PROGRESS = this.currentProgress;

            this.FadeOut();
            this.ShowBorderImage();
            this.ShowInitialReveal();
        },

        ShowInitialReveal: function () {
            if (CONFIG.VIDEO.ENABLE) {


                VIDEO_PLAYER.init();

            } else {
                IMAGES_SCREEN.init();
            }

            const transitionOverlay = document.getElementById('transition-overlay');
            if (transitionOverlay) {
                transitionOverlay.src = 'assets/images/reveal1.png';
                transitionOverlay.classList.add('active');
            }


            if (CONFIG.ENABLE_SERVER_LOGO) {

                const serverLogo = document.getElementById('server-logo');
                if (serverLogo && CONFIG.SERVER_LOGO) {
                    serverLogo.src = `assets/images/${CONFIG.SERVER_LOGO}`;
                    serverLogo.classList.add('active');
                }
            } else {

                const serverName = document.getElementById('server-name');
                if (serverName && CONFIG.SERVER_NAME) {
                    serverName.textContent = CONFIG.SERVER_NAME;
                    serverName.classList.add('active');
                }
            }


            setTimeout(() => {
                const serverDescription = document.getElementById('server-description');
                if (serverDescription && CONFIG.SERVER_DESCRIPTION) {
                    serverDescription.textContent = CONFIG.SERVER_DESCRIPTION;
                    serverDescription.style.display = 'block';
                    setTimeout(() => {
                        serverDescription.classList.add('active');
                    }, 10);
                }
            }, 2000);


            const serverWarning = document.getElementById('server-warning');
            if (serverWarning && CONFIG.SERVER_WARNING) {
                serverWarning.textContent = CONFIG.SERVER_WARNING;
                serverWarning.style.display = 'block';
                setTimeout(() => {
                    serverWarning.classList.add('active');
                }, 10);
            }


            MUSIC_PLAYER.init();
            TEAM_SYSTEM.init();

            const revealDuration = CONFIG.INITIAL_REVEAL_DURATION || 5000;
            setTimeout(() => {

                const serverName = document.getElementById('server-name');
                const serverLogo = document.getElementById('server-logo');
                const serverDescription = document.getElementById('server-description');
                const serverWarning = document.getElementById('server-warning');

                if (serverName) {
                    serverName.classList.remove('active');
                }
                if (serverLogo) {
                    serverLogo.classList.remove('active');
                }
                if (serverDescription) {
                    serverDescription.classList.remove('active');
                    setTimeout(() => {
                        serverDescription.style.display = 'none';
                    }, 1000);
                }
                if (serverWarning) {
                    serverWarning.classList.remove('active');
                    setTimeout(() => {
                        serverWarning.style.display = 'none';
                    }, 1000);
                }


                this.ShowUIElements();
                if (!CONFIG.VIDEO.ENABLE) {
                    IMAGES_SCREEN.loadFirstImage();

                    IMAGES_SCREEN.startInitialReveal(() => {
                        IMAGES_SCREEN.startNormalLoop();
                    });
                }
            }, revealDuration);
        },

        ShowUIElements: function () {

            const dynamiteContainer = document.getElementById('dynamite-container');
            if (dynamiteContainer) {
                dynamiteContainer.classList.add('visible');

                DYNAMITE_FUSE.init();
            }

            if (CONFIG.USER_CARD.ENABLE) {
                const userInfoCard = document.getElementById('user-info-card');
                if (userInfoCard) {
                    userInfoCard.classList.add('visible');
                }
            }

            this.SetupSocialButtons();
            this.SetupInfoButtons();

            const socialButtons = document.getElementById('social-buttons');
            if (socialButtons && socialButtons.classList.contains('active')) {
                socialButtons.classList.add('visible');
            }

            TEAM_SYSTEM.show();

            const toggleBtn = document.getElementById('btn-toggle-controls');
            if (toggleBtn && toggleBtn.classList.contains('active')) {
                toggleBtn.classList.add('visible');
            }

        },

        SetupSocialButtons: function () {
            const socialButtons = document.getElementById('social-buttons');
            if (!socialButtons) return;

            const btnDiscord = document.getElementById('btn-discord');
            const btnYoutube = document.getElementById('btn-youtube');
            const btnWebsite = document.getElementById('btn-website');

            let hasAnySocial = false;


            if (CONFIG.SOCIALS.DISCORD.ENABLE && btnDiscord) {
                const discordIcon = btnDiscord.querySelector('i');
                if (discordIcon && CONFIG.SOCIALS.DISCORD.ICON) {
                    discordIcon.className = CONFIG.SOCIALS.DISCORD.ICON;
                }
                btnDiscord.href = CONFIG.SOCIALS.DISCORD.URL;
                btnDiscord.style.display = 'flex';
                btnDiscord.addEventListener('click', (e) => {
                    e.preventDefault();
                    this.openUrl(CONFIG.SOCIALS.DISCORD.URL);
                });
                hasAnySocial = true;
            } else if (btnDiscord) {
                btnDiscord.style.display = 'none';
            }


            if (CONFIG.SOCIALS.YOUTUBE.ENABLE && btnYoutube) {
                const youtubeIcon = btnYoutube.querySelector('i');
                if (youtubeIcon && CONFIG.SOCIALS.YOUTUBE.ICON) {
                    youtubeIcon.className = CONFIG.SOCIALS.YOUTUBE.ICON;
                }
                btnYoutube.href = CONFIG.SOCIALS.YOUTUBE.URL;
                btnYoutube.style.display = 'flex';
                btnYoutube.addEventListener('click', (e) => {
                    e.preventDefault();
                    this.openUrl(CONFIG.SOCIALS.YOUTUBE.URL);
                });
                hasAnySocial = true;
            } else if (btnYoutube) {
                btnYoutube.style.display = 'none';
            }


            if (CONFIG.SOCIALS.WEBSITE.ENABLE && btnWebsite) {
                const websiteIcon = btnWebsite.querySelector('i');
                if (websiteIcon && CONFIG.SOCIALS.WEBSITE.ICON) {
                    websiteIcon.className = CONFIG.SOCIALS.WEBSITE.ICON;
                }
                btnWebsite.href = CONFIG.SOCIALS.WEBSITE.URL;
                btnWebsite.style.display = 'flex';
                btnWebsite.addEventListener('click', (e) => {
                    e.preventDefault();
                    this.openUrl(CONFIG.SOCIALS.WEBSITE.URL);
                });
                hasAnySocial = true;
            } else if (btnWebsite) {
                btnWebsite.style.display = 'none';
            }


            if (hasAnySocial) {
                socialButtons.classList.add('active');
            }
        },

        SetupInfoButtons: function () {
            const btnTeam = document.getElementById('btn-team');
            const btnHints = document.getElementById('btn-hints');
            const btnNews = document.getElementById('btn-news');
            const btnRules = document.getElementById('btn-rules');


            if (btnTeam && CONFIG.TRANSLATIONS.INFO_BUTTONS.BTN_TEAM) {
                btnTeam.innerHTML = CONFIG.TRANSLATIONS.INFO_BUTTONS.BTN_TEAM;
            }

            if (btnHints && CONFIG.TRANSLATIONS.INFO_BUTTONS.BTN_HINTS) {
                btnHints.innerHTML = CONFIG.TRANSLATIONS.INFO_BUTTONS.BTN_HINTS;
            }

            if (btnNews && CONFIG.TRANSLATIONS.INFO_BUTTONS.BTN_NEWS) {
                btnNews.innerHTML = CONFIG.TRANSLATIONS.INFO_BUTTONS.BTN_NEWS;
            }

            if (btnRules && CONFIG.TRANSLATIONS.INFO_BUTTONS.BTN_RULES) {
                btnRules.innerHTML = CONFIG.TRANSLATIONS.INFO_BUTTONS.BTN_RULES;
            }
        },

        openUrl: function (url) {
            window.invokeNative("openUrl", url);
        },

        ShowBorderImage: function () {
            if (CONFIG.IMAGES.ENABLE_BORDER_IMAGE) {
                const borderImage = document.getElementById('border-image');
                if (borderImage) {
                    borderImage.classList.add('active');
                }
            }
        },

        FadeOut: function () {
            if (!CONFIG.ENABLE_BLACK_FADEOUT) return;

            const blackOverlay = document.getElementById('black-overlay');
            if (blackOverlay) {
                blackOverlay.classList.remove('fade-in');
                setTimeout(() => {
                    blackOverlay.classList.add('fade-out');
                }, 100);
            }
        },

        FadeIn: function () {
            const blackOverlay = document.getElementById('black-overlay');
            if (blackOverlay) {

                blackOverlay.classList.remove('fade-out');
                setTimeout(() => {
                    blackOverlay.classList.add('fade-in');
                }, 100);

                setTimeout(() => {
                    document.body.style.display = 'none';
                }, 1000);
            }
        },

        Update: function (value) {
            this.currentProgress = Math.floor(value * 100);
            if (this.currentProgress > 100) {
                this.currentProgress = 100;
            }
            window.LOADING_PROGRESS = this.currentProgress;


            if (this.currentProgress == 100 && !this.isComplete) {

                if (this.isComplete) return;
                this.isComplete = true;

                if (CONFIG.ENABLE_COMPLETE_BUTTON) {
                    setTimeout(() => {
                        const dynamiteContainer = document.getElementById('dynamite-container');
                        if (dynamiteContainer) {
                            dynamiteContainer.classList.remove('visible');
                        }

                        const completeButtonContainer = document.getElementById('complete-button-container');
                        if (completeButtonContainer) {
                            completeButtonContainer.classList.add('visible');

                            const completeButton = document.getElementById('complete-button');
                            if (completeButton) {
                                completeButton.setAttribute('data-text', CONFIG.TRANSLATIONS.COMPLETE_BUTTON.TEXT);
                                completeButton.addEventListener('click', (e) => {
                                    e.preventDefault();
                                    completeButton.remove();
                                    completeButtonContainer.classList.remove('visible');
                                    this.Complete(500);
                                });
                            }
                        }
                    }, CONFIG.COMPLETE_BUTTON_DELAY || 1000);
                } else {
                    this.Complete(CONFIG.COMPLETE_LOADING_SCREEN_DELAY || 5000);
                }
            }
        },

        closeAllCards: function () {

            if (TEAM_SYSTEM.isTeamVisible) {
                const teamContainer = document.getElementById('team-cards-container');
                const teamCards = teamContainer.querySelectorAll('.team-card');
                const btnTeam = document.getElementById('btn-team');

                if (teamCards.length > 0) {
                    TEAM_SYSTEM.hideCardsStaggered(teamCards, () => {
                        teamContainer.classList.remove('active');
                        TEAM_SYSTEM.isTeamVisible = false;
                        if (btnTeam) btnTeam.classList.remove('active');
                    });
                }
            }


            if (TEAM_SYSTEM.isHintsVisible) {
                const hintsContainer = document.getElementById('hints-cards-container');
                const hintsCards = hintsContainer.querySelectorAll('.hint-card');
                const btnHints = document.getElementById('btn-hints');

                if (hintsCards.length > 0) {
                    TEAM_SYSTEM.hideCardsStaggered(hintsCards, () => {
                        hintsContainer.classList.remove('active');
                        TEAM_SYSTEM.isHintsVisible = false;
                        if (btnHints) btnHints.classList.remove('active');
                    });
                }
            }


            if (TEAM_SYSTEM.isNewsVisible) {
                const newsContainer = document.getElementById('news-cards-container');
                const newsCards = newsContainer.querySelectorAll('.news-card');
                const btnNews = document.getElementById('btn-news');

                if (newsCards.length > 0) {
                    TEAM_SYSTEM.hideCardsStaggered(newsCards, () => {
                        newsContainer.classList.remove('active');
                        TEAM_SYSTEM.isNewsVisible = false;
                        if (btnNews) btnNews.classList.remove('active');
                    });
                }
            }


            if (TEAM_SYSTEM.isRulesVisible) {
                const rulesContainer = document.getElementById('rules-cards-container');
                const rulesCards = rulesContainer.querySelectorAll('.rules-card');
                const btnRules = document.getElementById('btn-rules');

                if (rulesCards.length > 0) {
                    TEAM_SYSTEM.hideCardsStaggered(rulesCards, () => {
                        rulesContainer.classList.remove('active');
                        TEAM_SYSTEM.isRulesVisible = false;
                        if (btnRules) btnRules.classList.remove('active');
                    });
                }
            }

            TEAM_SYSTEM.stopAutoScroll();
        },

        UpdateLoadingText: function () {
            const LOADING_PHASES = [
                "AUTHENTICATING CREDENTIALS...",
                "SYNCHRONIZING CORE SYSTEMS...",
                "LOADING WORLD DATA...",
                "STREAMING ASSETS..",
                "DECOMPRESSING TEXTURES...",
                "FINALIZING SESSION HANDSHAKE...",
                "AWAITING CHARACTER SELECTION...",
            ];
            // needs to be based of the current progress
            const currentProgress = this.currentProgress;
            const progressPercentage = (currentProgress / 100) * 100;
            const loadingText = LOADING_PHASES[progressPercentage] || "LOADING...";
            document.getElementById('loading-text').textContent = loadingText;

        },

        Complete: function (duration) {

            // the loading screen might be too fast people wont even see the video sowe delay a bit
            setTimeout(() => {
                VIDEO_PLAYER.stop();

                this.closeAllCards();

                IMAGES_SCREEN.waitForBlackFrameToComplete(() => {

                    const userInfoCard = document.getElementById('user-info-card');
                    if (userInfoCard) {
                        userInfoCard.classList.remove('visible');
                    }

                    const socialButtons = document.getElementById('social-buttons');
                    if (socialButtons) {
                        socialButtons.classList.remove('visible');
                    }

                    TEAM_SYSTEM.hide();

                    const toggleBtn = document.getElementById('btn-toggle-controls');
                    if (toggleBtn) {
                        toggleBtn.classList.remove('visible');
                    }

                    const musicControls = document.getElementById('music-controls');
                    if (musicControls) {
                        musicControls.classList.remove('visible');
                    }

                    const dynamiteContainer = document.getElementById('dynamite-container');
                    if (dynamiteContainer) {
                        dynamiteContainer.classList.remove('visible');
                    }

                    DYNAMITE_FUSE.stop();

                    if (MUSIC_PLAYER && MUSIC_PLAYER.audio) {
                        MUSIC_PLAYER.fadeOut(1000);
                    }

                    setTimeout(() => {
                        if (CONFIG.ENABLE_SERVER_LOGO) {
                            const serverLogo = document.getElementById('server-logo');
                            if (serverLogo && CONFIG.SERVER_LOGO) {
                                serverLogo.src = `assets/images/${CONFIG.SERVER_LOGO}`;
                                serverLogo.classList.add('active');
                            }
                        } else {
                            const serverName = document.getElementById('server-name');
                            if (serverName && CONFIG.SERVER_NAME) {
                                serverName.textContent = CONFIG.SERVER_NAME;
                                serverName.classList.add('active');
                            }
                        }

                        setTimeout(() => {

                            const serverName = document.getElementById('server-name');
                            const serverLogo = document.getElementById('server-logo');

                            if (serverName) {
                                serverName.classList.remove('active');
                            }
                            if (serverLogo) {
                                serverLogo.classList.remove('active');
                            }

                            const completeOverlay = document.getElementById('complete-overlay');
                            if (completeOverlay) {
                                completeOverlay.classList.add('active');
                            }

                            this.FadeIn();

                            if (CONFIG.ENABLE_COMPLETE_BUTTON) {

                                const postData = async () => {
                                    while (true) {
                                        try {
                                            const response = await fetch('https://midnightcode_loadingscreen/complete', {
                                                method: 'POST',
                                                headers: {
                                                    'Content-Type': 'application/json'
                                                },
                                                body: JSON.stringify({})
                                            });
                                            if (response.ok) {
                                                break;
                                            }
                                        } catch (error) {
                                            // script might not be ready yet, wait and retry
                                        }
                                        await new Promise(resolve => setTimeout(resolve, 500));
                                    }
                                };
                                postData();
                            }

                        }, 5000);
                    }, 1000);
                });

            }, duration);
        },
    }

    window.addEventListener('message', function (e) {

        if (e.data.eventName === 'loadProgress') {
            LOADING_SCREEN.Start()
            LOADING_SCREEN.Update(e.data.loadFraction)
            LOADING_SCREEN.UpdateLoadingText();
            if (LOADING_SCREEN.userInfoAdded) return;
            if (window?.nuiHandoverData?.name && window?.nuiHandoverData?.avatarUrl) {
                LOADING_SCREEN.userInfoAdded = true;
                LOADING_SCREEN.UpdateUserInfo({
                    username: window.nuiHandoverData.name,
                    avatarUrl: window.nuiHandoverData.avatarUrl,
                    role: window.nuiHandoverData.role,
                    currentPlayers: window.nuiHandoverData.currentPlayers,
                    maxPlayers: window.nuiHandoverData.maxPlayers
                })
            }
        }

        // here is where we remove the black overlay
        if (e.data.eventName === 'complete') {
            LOADING_SCREEN.FadeOut();
            document.body.style.display = 'none';
        }
    });
});