const CONFIG = {
    // General loading screen settings
    ENABLE_BLACK_FADEOUT: true, // if false, no initial black screen fade out
    ENABLE_COMPLETE_BUTTON: false, // if true it will wait until player press join button to finish loading screen YOU MUST GO TO CONFIG.LUA TO DO THE SAME THING
    COMPLETE_BUTTON_DELAY: 7000, // delay in milliseconds before the complete button is shown
    COMPLETE_LOADING_SCREEN_DELAY: 5000, // delay in milliseconds , how long to wait when loading percentage is finished this waits when it reaches 100. this is only if you have no complete button.

    // Initial reveal settings
    SERVER_NAME: "SERVER NAME", // Text displayed during initial reveal
    SERVER_DESCRIPTION: "description text", // Description text below server name/logo
    SERVER_WARNING: "footer description", // Footer warning message
    ENABLE_SERVER_LOGO: false, // if true, shows logo instead of server name
    SERVER_LOGO: "logo.png", // Logo image file in assets/images/ (only used if ENABLE_SERVER_LOGO is true)
    INITIAL_REVEAL_DURATION: 5000, // How long to show server name/logo before revealing content (ms)

    MUSIC: {
        ENABLE: true, // if false wil disable music this will be disabled if you are using video
        ENABLE_CONTROLS: true, // if false will disable music controls
        VOLUME: 100, // volume of music 0-100 players can change this in the ui
        MUSIC_LIST: [ // players can cycle through these files if you just want one only add one
            {
                TITLE: "", // leave empty for no music title
                NAME: "rdrmusic_3.mp3", // must exist in the assets/audio folder
            },
            {
                TITLE: "",
                NAME: "rdrmusic_1.mp3", // must exist in the assets/audio folder
            },
            {
                TITLE: "",
                NAME: "rdrmusic.mp3", // must exist in the assets/audio folder
            },
        ]
    },


    VIDEO: {
        ENABLE: false, // if true will enable video other wise it will enable images
        VIDEO: "video.webm", // must exist in the assets/videos folder YOU CANNOT USE MP4 only webm convert them using this link https://www.veed.io/convert/mp4-to-webm
        MUTE_VIDEO: true, // if true will mute video audio (users can use music controls instead)
    },

    IMAGES: {
        // leave only one to have it static other wise will play all of them in a loop like a slider
        ENABLE_SLIDER: true, // if true will enable image slider otherwise will be static
        SLIDER_STYLE: "fade-in", // Styles: "fade-in" (simple fade transition)
        SLIDER_DURATION: 10000, // Duration each image is displayed in milliseconds (10000 = 10 seconds)

        ENABLE_OVERLAY: true, // if true, overlay images will cycle on top of background images
        OVERLAY_FRAME_DURATION: 80, // Duration each overlay image is displayed in milliseconds (80 = 0.08 seconds) bigger the faster it does the lower the slower the overlay is displayed
        ENABLE_BORDER_IMAGE: true, // if tru will add an image tothe border of the screen all around it
        IMAGE_LIST: [ // players can cycle through these files if you just want one only add one
            {
                NAME: "image_1.jpg", // must exist in the assets/images folder
            },
            {
                NAME: "image_2.jpg", // must exist in the assets/images folder
            },
            {
                NAME: "image_3.jpg", // must exist in the assets/images folder
            },
            {
                NAME: "image_4.jpg", // must exist in the assets/images folder
            },
            {
                NAME: "image_5.jpg", // must exist in the assets/images folder
            },
            {
                NAME: "image_6.jpg", // must exist in the assets/images folder
            },
            {
                NAME: "image_7.jpg", // must exist in the assets/images folder
            },
            {
                NAME: "image_8.jpg", // must exist in the assets/images folder
            },
        ]
    },

    // User card settings
    USER_CARD: {
        ENABLE: true, // if true will display user card with avatar and name
    },

    // only 3 is allowed
    SOCIALS: {
        DISCORD: {
            ENABLE: true, // if true will enable discord link
            URL: "https://discord.gg/yourdiscordlink",
            ICON: "fa-brands fa-discord", // Font Awesome icon class
        },
        YOUTUBE: {
            ENABLE: true, // if true will enable youtube link
            URL: "https://youtube.com/youryoutubelink",
            ICON: "fa-brands fa-youtube",
        },
        WEBSITE: {
            ENABLE: true, // if true will enable website/instagram link
            URL: "https://instagram.com/yourwebiste",
            ICON: "fa-solid fa-globe",
        }
    },

    // Translations for UI elements
    TRANSLATIONS: {
        MUSIC_CONTROLS: {
            BTN_PREVIOUS: '<i class="fa-solid fa-backward-step"></i>',
            BTN_NEXT: '<i class="fa-solid fa-forward-step"></i>',
            BTN_PLAY: '<i class="fa-solid fa-play"></i>',
            BTN_PAUSE: '<i class="fa-solid fa-pause"></i>',
            BTN_MUTE: '<i class="fa-solid fa-volume-high"></i>',
            BTN_UNMUTE: '<i class="fa-solid fa-volume-xmark"></i>',
            BTN_FAVORITE_ADD: '<i class="fa-regular fa-star"></i>',
            BTN_FAVORITE_REMOVE: '<i class="fa-solid fa-star"></i>',
        },
        INFO_BUTTONS: {
            BTN_TEAM: '<i class="fa-solid fa-users"></i><span>TEAM</span>',
            BTN_HINTS: '<i class="fa-solid fa-lightbulb"></i><span>HINTS</span>',
            BTN_NEWS: '<i class="fa-solid fa-newspaper"></i><span>NEWS</span>',
            BTN_RULES: '<i class="fa-solid fa-gavel"></i><span>RULES</span>',
        },
        COMPLETE_BUTTON: {
            TEXT: 'JOIN NOW',
        }
    }
};

export default CONFIG;