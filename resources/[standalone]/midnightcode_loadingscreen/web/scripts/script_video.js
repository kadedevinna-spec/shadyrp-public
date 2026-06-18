import CONFIG from '../config_main.js'

const VIDEO_PLAYER = {
    video: null,

    init: function () {
        if (!CONFIG.VIDEO.ENABLE) return;

        this.video = document.getElementById('video');
        if (!this.video) return console.error('Video element not found');

        const file = CONFIG.VIDEO.VIDEO;
        if (!file) return console.error('No video configured');

        const url = `assets/videos/${file}`;


        this.video.addEventListener('loadeddata', () => {
            this.video.style.display = 'block';
            this.video.play().catch(err => console.log('autoplay blocked:', err));
        }, { once: true });


        this.video.muted = CONFIG.VIDEO.MUTE_VIDEO ?? true;
        this.video.autoplay = true;
        this.video.playsInline = true;
        this.video.loop = true;
        this.video.preload = 'auto';

        this.video.pause();
        this.video.removeAttribute('src');
        while (this.video.firstChild) this.video.removeChild(this.video.firstChild);

        this.video.src = url;
        this.video.load();
    },


    stop: function () {
        if (this.video) {
            this.video.loop = false;
            this.video.pause();
            this.video.style.display = 'none';
        }
    }
}

export default VIDEO_PLAYER;