const DYNAMITE_FUSE = {
    canvas: null,
    ctx: null,
    particles: [],
    animationFrame: null,

    init: function () {
        this.canvas = document.getElementById('fuse-canvas');
        if (!this.canvas) return;

        this.ctx = this.canvas.getContext('2d');
        this.canvas.width = 200;
        this.canvas.height = 60;
        this.particles = [];

        this.startAnimation();
    },

    startAnimation: function () {
        const animate = () => {
            this.ctx.clearRect(0, 0, this.canvas.width, this.canvas.height);

            const fuseLength = this.canvas.width - 20;
            const burnPoint = (window.LOADING_PROGRESS / 100) * fuseLength;

            if (burnPoint < fuseLength) {
                this.ctx.strokeStyle = '#e0e0e0';
                this.ctx.lineWidth = 4;
                this.ctx.beginPath();
                this.ctx.moveTo(10 + burnPoint, this.canvas.height / 2);
                this.ctx.lineTo(fuseLength + 10, this.canvas.height / 2);
                this.ctx.stroke();
            }

            if (burnPoint > 0) {
                const glowX = 10 + burnPoint;
                const glowY = this.canvas.height / 2;

                const glow = this.ctx.createRadialGradient(glowX, glowY, 0, glowX, glowY, 15);
                glow.addColorStop(0, 'rgba(255, 255, 255, 0.9)');
                glow.addColorStop(0.5, 'rgba(255, 255, 255, 0.5)');
                glow.addColorStop(1, 'rgba(255, 255, 255, 0)');

                this.ctx.fillStyle = glow;
                this.ctx.beginPath();
                this.ctx.arc(glowX, glowY, 15, 0, Math.PI * 2);
                this.ctx.fill();

                if (Math.random() > 0.7) {
                    this.particles.push(new Spark(glowX, glowY));
                }
            }

            for (let i = this.particles.length - 1; i >= 0; i--) {
                this.particles[i].update();
                this.particles[i].draw(this.ctx);

                if (this.particles[i].life <= 0) {
                    this.particles.splice(i, 1);
                }
            }

            this.animationFrame = requestAnimationFrame(animate);
        };

        animate();
    },

    stop: function () {
        if (this.animationFrame) {
            cancelAnimationFrame(this.animationFrame);
        }
    }
};


class Spark {
    constructor(x, y) {
        this.x = x;
        this.y = y;
        this.vx = (Math.random() - 0.5) * 2;
        this.vy = (Math.random() - 0.5) * 2 - 1;
        this.life = 1;
        this.decay = Math.random() * 0.02 + 0.01;
        this.size = Math.random() * 3 + 1;
    }

    update() {
        this.x += this.vx;
        this.y += this.vy;
        this.vy += 0.1; // gravity
        this.life -= this.decay;
    }

    draw(ctx) {
        if (this.life <= 0) return;

        const alpha = this.life;
        const gradient = ctx.createRadialGradient(this.x, this.y, 0, this.x, this.y, this.size);
        gradient.addColorStop(0, `rgba(255, 255, 255, ${alpha})`);
        gradient.addColorStop(0.5, `rgba(255, 255, 255, ${alpha * 0.8})`);
        gradient.addColorStop(1, `rgba(255, 255, 255, 0)`);

        ctx.fillStyle = gradient;
        ctx.beginPath();
        ctx.arc(this.x, this.y, this.size, 0, Math.PI * 2);
        ctx.fill();
    }
}

export default DYNAMITE_FUSE;

