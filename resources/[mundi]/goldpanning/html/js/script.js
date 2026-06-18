const canvas = document.querySelector(".canvas");
const ctx = canvas.getContext("2d");

// ===============================================
// STANDALONE PROGRESS BAR SYSTEM
// ===============================================
const progressContainer = document.getElementById('progressContainer');
const progressLabel = document.getElementById('progressLabel');
const progressBarFill = document.getElementById('progressBarFill');

let progressInterval = null;
let progressStartTime = 0;
let progressDuration = 0;

function showProgressBar(label, durationSeconds) {
    // Make sure body is visible (may have been hidden by closeUI)
    document.body.style.display = 'block';
    
    progressLabel.textContent = label || 'Loading...';
    progressBarFill.style.width = '0%';
    progressContainer.style.display = 'flex';
    
    progressStartTime = Date.now();
    progressDuration = durationSeconds * 1000;
    
    // Clear any existing interval
    if (progressInterval) {
        clearInterval(progressInterval);
    }
    
    // Update progress bar every 50ms
    progressInterval = setInterval(() => {
        const elapsed = Date.now() - progressStartTime;
        const progress = Math.min((elapsed / progressDuration) * 100, 100);
        progressBarFill.style.width = progress + '%';
        
        if (progress >= 100) {
            clearInterval(progressInterval);
            progressInterval = null;
            // Auto-hide after completing
            setTimeout(() => {
                hideProgressBar();
            }, 200);
        }
    }, 50);
}

function hideProgressBar() {
    progressContainer.style.display = 'none';
    progressBarFill.style.width = '0%';
    if (progressInterval) {
        clearInterval(progressInterval);
        progressInterval = null;
    }
}

// Timer variables
let timerDuration = 10; // 10 seconds
let timerStartTime = 0;
let timerInterval = null;

// Get timer elements
const timerContainer = document.getElementById('timerContainer');
const timerBar = document.getElementById('timerBar');
const timerText = document.getElementById('timerText');
const goldCounter = document.getElementById('goldCounter');
const goldCollectedText = document.getElementById('goldCollectedText');
const goldTotalText = document.getElementById('goldTotalText');
const soundToggle = document.getElementById('soundToggle');

// Sound control
let soundEnabled = true;

// Function to play sound only if enabled
function playSound(audio) {
    if (soundEnabled && audio) {
        audio.play().catch(err => {
            // Silent fail for production
        });
    }
}

// Function to toggle sound
function toggleSound() {
    soundEnabled = !soundEnabled;
    soundToggle.textContent = soundEnabled ? '🔊' : '🔇';
    soundToggle.classList.toggle('muted', !soundEnabled);
    
    // Stop currently playing sounds when muting
    if (!soundEnabled) {
        dragAudio.pause();
        dragAudio.currentTime = 0;
        collectSound.pause();
        collectSound.currentTime = 0;
    }
}

canvas.width = window.innerWidth;
canvas.height = window.innerHeight;

const backgroundImage = new Image();
backgroundImage.src = "img/background.png";
const fullImage = new Image();
fullImage.src = "img/full.png";
const partialImages = [];
for (let i = 1; i <= 6; i++) {
    const img = new Image();
    img.src = `img/partial${i}.png`;
    partialImages.push(img);
}
const goldFlakeImage = new Image();
goldFlakeImage.src = "img/gold_flake.png";
const goldNuggetImage = new Image();
goldNuggetImage.src = "img/gold_nugget.png";

// Collection sound - satisfying coin/pickup sound
const collectSound = new Audio("audio/collect.mp3");
const dragAudioFile = new Audio("audio/shake.mp3");

let goldPositions = [];
let collectedFlakes = 0;
let collectedNuggets = 0;
let totalFlakes = 0;
let totalNuggets = 0;
let collectionPhase = false; // Flag to indicate if we are in the gold collection phase
let shakingPhase = false; // Flag for shaking phase

function spawnGold(flakeAmount, nuggetAmount) {
    goldPositions = [];
    collectedFlakes = 0;
    collectedNuggets = 0;
    totalFlakes = flakeAmount;
    totalNuggets = nuggetAmount;

    // Helper function to check if a position overlaps with existing gold
    const minDistance = 60; // Minimum distance between gold pieces
    const isPositionValid = (x, y) => {
        for (let gold of goldPositions) {
            const dx = x - gold.startX;
            const dy = y - gold.startY;
            const distance = Math.sqrt(dx * dx + dy * dy);
            if (distance < minDistance) {
                return false;
            }
        }
        return true;
    };

    // Spawn gold flakes at random positions in the upper half of the pan with spacing
    for (let i = 0; i < flakeAmount; i++) {
        let attempts = 0;
        let randomX, randomY;
        
        // Try to find a valid position (max 50 attempts)
        do {
            randomX = (Math.random() - 0.5) * 100; // Random X within pan width
            randomY = (Math.random() - 0.5) * 80 - 60; // Random Y in upper half
            attempts++;
        } while (!isPositionValid(backgroundImage.width / 2 + randomX, backgroundImage.height / 2 + randomY) && attempts < 50);
        
        const slideOffsetX = (Math.random() - 0.5) * 40; // Random horizontal slide direction
        goldPositions.push({
            x: backgroundImage.width / 2 + randomX,
            y: backgroundImage.height / 2 + randomY,
            startX: backgroundImage.width / 2 + randomX,
            startY: backgroundImage.height / 2 + randomY,
            slideOffsetX: slideOffsetX, // Fixed horizontal movement per gold piece
            clicked: false,
            isNugget: false,
            opacity: 0, // Start invisible
            slideProgress: 0, // 0 to 1, controls how far down the pan it has slid
            fallenOut: false
        });
    }

    // Spawn gold nuggets at random positions in the upper half of the pan with spacing
    for (let i = 0; i < nuggetAmount; i++) {
        let attempts = 0;
        let randomX, randomY;
        
        // Try to find a valid position (max 50 attempts)
        do {
            randomX = (Math.random() - 0.5) * 100; // Random X within pan width
            randomY = (Math.random() - 0.5) * 80 - 60; // Random Y in upper half
            attempts++;
        } while (!isPositionValid(backgroundImage.width / 2 + randomX, backgroundImage.height / 2 + randomY) && attempts < 50);
        
        const slideOffsetX = (Math.random() - 0.5) * 40; // Random horizontal slide direction
        goldPositions.push({
            x: backgroundImage.width / 2 + randomX,
            y: backgroundImage.height / 2 + randomY,
            startX: backgroundImage.width / 2 + randomX,
            startY: backgroundImage.height / 2 + randomY,
            slideOffsetX: slideOffsetX, // Fixed horizontal movement per gold piece
            clicked: false,
            isNugget: true,
            opacity: 0, // Start invisible
            slideProgress: 0,
            fallenOut: false
        });
    }

    updateGoldCounter();
    drawImages();
}

const dragAudio = new Audio("audio/shake.mp3");
let imageX, imageY;
let isDragging = false;
let offsetX, offsetY;
let totalDistance = 0;
const shakeThreshold = 30; // Further increased to make shaking harder
const shakeDistance = 250; // Significantly increased - requires more shaking
let currentImage = fullImage;
let currentPartialIndex = 0;
let isTestRun = false;

// Animation loop for sliding gold during collection phase
let animationLoop = null;

function startGoldSlideAnimation() {
    const slideSpeed = 0.008; // Increased - gold slides faster, giving player less time
    
    animationLoop = setInterval(() => {
        if (collectionPhase) {
            let hasActiveGold = false;
            
            goldPositions.forEach(gold => {
                if (!gold.clicked && !gold.fallenOut && gold.opacity >= 1.0) {
                    hasActiveGold = true;
                    gold.slideProgress = Math.min(gold.slideProgress + slideSpeed, 1.0);
                    
                    // Check if gold has fallen out - only when it reaches 100% (end of pan)
                    if (gold.slideProgress >= 1.0) {
                        gold.fallenOut = true;
                        // Don't reduce total count - that's already set
                        // Just mark as fallen out so it won't be given to player
                        updateGoldCounter();
                    }
                }
            });
            
            drawImages();
            
            // Only close if no gold is active (all collected or fallen out)
            if (!hasActiveGold) {
                stopGoldSlideAnimation();
                setTimeout(() => closeUI(), 500);
            }
        }
    }, 16); // ~60fps
}

function stopGoldSlideAnimation() {
    if (animationLoop) {
        clearInterval(animationLoop);
        animationLoop = null;
    }
}

function drawImages() {
    ctx.clearRect(0, 0, canvas.width, canvas.height);
    ctx.drawImage(backgroundImage, imageX, imageY);

    // Draw gold with progressive opacity and sliding animation
    goldPositions.forEach((gold) => {
        if (!gold.clicked && !gold.fallenOut) {
            // Calculate slide position (slides down and slightly to the side)
            const slideDistance = 200; // Increased from 120 - gold travels further down the pan
            const slideX = gold.startX + (gold.slideProgress * gold.slideOffsetX); // Use pre-calculated offset
            const slideY = gold.startY + (gold.slideProgress * slideDistance);
            
            const goldDrawX = imageX + slideX - backgroundImage.width / 2;
            const goldDrawY = imageY + slideY - backgroundImage.height / 2;
            const size = gold.isNugget ? 70 : 50;
            const goldImg = gold.isNugget ? goldNuggetImage : goldFlakeImage;

            ctx.save();
            ctx.globalAlpha = gold.opacity; // Apply opacity
            if (gold.isNugget) {
                ctx.shadowColor = '#FFD700';
                ctx.shadowBlur = 15;
            }
            ctx.drawImage(goldImg, goldDrawX + 150, goldDrawY + 140, size, size);
            ctx.restore();
        }
    });

    // Draw dirt layer OVER the gold (if any)
    if (currentImage) {
        const fullX = imageX + (backgroundImage.width - currentImage.width) / 2;
        const fullY = imageY + (backgroundImage.height - currentImage.height) / 2;
        ctx.drawImage(currentImage, fullX, fullY);
    }
}

// Simplified timer function
function startTimer(duration, label, onComplete) {
    timerDuration = duration;
    timerStartTime = Date.now();
    timerContainer.style.display = 'flex';
    timerBar.style.width = '100%';
    timerText.textContent = label + ' - ' + duration.toFixed(0) + 's';

    timerInterval = setInterval(() => {
        const elapsed = (Date.now() - timerStartTime) / 1000;
        const remaining = Math.max(0, timerDuration - elapsed);
        const percentage = (remaining / timerDuration) * 100;
        timerBar.style.width = percentage + '%';
        timerText.textContent = label + ' - ' + Math.ceil(remaining) + 's';

        if (remaining <= 0) {
            stopTimer();
            if (onComplete) {
                onComplete();
            }
        }
    }, 100);
}

function stopTimer() {
    if (timerInterval) {
        clearInterval(timerInterval);
        timerInterval = null;
    }
    timerContainer.style.display = 'none';
}

function closeUI() {
    stopTimer();
    stopGoldSlideAnimation();
    document.body.style.display = 'none';
    canvas.style.display = 'none'; // Hide the canvas
    soundToggle.style.display = 'none'; // Hide sound toggle button
    fetch(`https://goldpanning/close`, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({
            collectedFlakes: collectedFlakes,
            collectedNuggets: collectedNuggets,
            totalFlakes: totalFlakes,
            totalNuggets: totalNuggets
        })
    });
}

function updateGoldCounter() {
    const collectedCount = collectedFlakes + collectedNuggets;
    const totalCount = totalFlakes + totalNuggets;
    goldCollectedText.textContent = collectedCount;
    goldTotalText.textContent = totalCount;
}

function initializeCanvas() {
    imageX = (canvas.width - backgroundImage.width) / 2;
    imageY = (canvas.height - backgroundImage.height) / 2;
    drawImages();
}

backgroundImage.onload = () => {
    if (fullImage.complete) {
        initializeCanvas();
    }
};
fullImage.onload = () => {
    if (backgroundImage.complete) {
        initializeCanvas();
    }
};

canvas.addEventListener("mousedown", (e) => {
    if (!shakingPhase) return; // Don't allow dragging during collection
    const rect = canvas.getBoundingClientRect();
    const mouseX = e.clientX - rect.left;
    const mouseY = e.clientY - rect.top;
    if (
        mouseX >= imageX &&
        mouseX <= imageX + backgroundImage.width &&
        mouseY >= imageY &&
        mouseY <= imageY + backgroundImage.height
    ) {
        isDragging = true;
        offsetX = mouseX - imageX;
        offsetY = mouseY - imageY;
        if (soundEnabled && dragAudio.paused) {
            dragAudio.loop = true;
            dragAudio.play().catch((error) => {
                // Silent fail - retry once
                dragAudio.pause();
                dragAudio.currentTime = 0;
                setTimeout(() => {
                    if (soundEnabled) {
                        dragAudio.play().catch((retryError) => {
                            // Silent fail on retry
                        });
                    }
                }, 100);
            });
        }
    }
});

canvas.addEventListener("click", (e) => {
    if (!collectionPhase) return; // Only allow clicking during collection phase

    const rect = canvas.getBoundingClientRect();
    const mouseX = e.clientX - rect.left;
    const mouseY = e.clientY - rect.top;
    
    let clickedAny = false;
    
    goldPositions.forEach((gold) => {
        if (!gold.clicked && !gold.fallenOut && gold.opacity >= 1.0) {
            // Calculate current slide position for click detection - MUST MATCH drawImages()
            const slideDistance = 200; // Must match drawImages()
            const slideX = gold.startX + (gold.slideProgress * gold.slideOffsetX); // Use pre-calculated offset
            const slideY = gold.startY + (gold.slideProgress * slideDistance);
            
            const size = gold.isNugget ? 70 : 50;
            const goldDrawX = imageX + slideX - backgroundImage.width / 2 + 150;
            const goldDrawY = imageY + slideY - backgroundImage.height / 2 + 140;
            
            if (
                mouseX >= goldDrawX &&
                mouseX <= goldDrawX + size &&
                mouseY >= goldDrawY &&
                mouseY <= goldDrawY + size
            ) {
                gold.clicked = true;
                clickedAny = true;
                playSound(collectSound);

                if (gold.isNugget) {
                    collectedNuggets++;
                } else {
                    collectedFlakes++;
                }

                updateGoldCounter();

                // Check if all remaining items are collected
                const remainingGold = goldPositions.filter(g => !g.clicked && !g.fallenOut);
                if (remainingGold.length === 0) {
                    stopGoldSlideAnimation();
                    setTimeout(() => closeUI(), 500);
                }
                drawImages();
            }
        }
    });
});

canvas.addEventListener("mousemove", (e) => {
    if (isDragging && shakingPhase) {
        const rect = canvas.getBoundingClientRect();
        const mouseX = e.clientX - rect.left;
        const mouseY = e.clientY - rect.top;
        const deltaX = mouseX - offsetX - imageX;
        const deltaY = mouseY - offsetY - imageY;
        const distance = Math.sqrt(deltaX ** 2 + deltaY ** 2);
        imageX = mouseX - offsetX;
        imageY = mouseY - offsetY;
        totalDistance += distance;

        const progress = Math.min(totalDistance / (shakeThreshold * shakeDistance), 1);
        const partialIndex = Math.floor(progress * (partialImages.length));

        if (partialIndex < partialImages.length) {
            currentImage = partialImages[partialIndex];
        } else {
            currentImage = null; // All dirt gone
        }

        // Gradually reveal gold as dirt is removed
        goldPositions.forEach(gold => {
            gold.opacity = Math.min(progress, 1.0);
        });

        drawImages();
    }
});

canvas.addEventListener("mouseup", () => {
    if (shakingPhase) {
        isDragging = false;
        if (!dragAudio.paused) {
            dragAudio.pause();
            dragAudio.currentTime = 0;
        }
        
        // Check if all dirt has been removed (shaking complete)
        if (currentImage === null) {
            shakingPhase = false;
            
            // Send shake result to server
            fetch(`https://goldpanning/panResult`, {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify({
                    success: true,
                    multiplier: 1.0 + (totalDistance / (shakeThreshold * shakeDistance)),
                    isTest: isTestRun
                })
            });
        }
    }
});

canvas.addEventListener("mouseout", () => {
    if (shakingPhase) {
        isDragging = false;
        if (!dragAudio.paused) {
            dragAudio.pause();
            dragAudio.currentTime = 0;
        }
    }
});

function onMouseUp(e) {
    // This function is now empty as the logic is handled by mouseup/mouseout
}

window.addEventListener("message", (event) => {
    const data = event.data;
    
    // Handle progress bar messages
    if (data.action === "showProgress") {
        showProgressBar(data.label, data.duration);
        return;
    }
    if (data.action === "hideProgress") {
        hideProgressBar();
        return;
    }
    
    if (data.action === "startGoldPanning") {
        document.body.style.display = 'block';
        canvas.style.display = 'block'; // Show the canvas
        soundToggle.style.display = 'flex'; // Show sound toggle button
        collectionPhase = false;
        shakingPhase = true; // Start shaking phase
        isDragging = false;
        totalDistance = 0;
        currentImage = fullImage;
        isTestRun = data.isTest || false;
        
        // Get rewards from server and spawn gold (invisible initially)
        spawnGold(data.flakeAmount || 0, data.nuggetAmount || 0);
        
        initializeCanvas();
        goldCounter.style.display = 'none'; // Hide counter completely during shake
        timerContainer.style.display = 'none'; // NO TIMER during shaking phase
        
        // No timer during shaking - player shakes until dirt is removed
    } else if (data.action === 'startCollection') {
        // This is triggered by the client after server calculates rewards
        collectionPhase = true;
        shakingPhase = false;
        isDragging = false;
        currentImage = null; // Remove any remaining dirt
        
        // Check if there's any gold to collect
        const hasGold = goldPositions.length > 0;
        
        if (!hasGold) {
            // No gold found - just show empty pan briefly and close
            goldCounter.style.display = 'none';
            drawImages();
            setTimeout(() => {
                closeUI();
            }, 1500); // Show empty pan for 1.5 seconds then close
            return;
        }
        
        // Make sure all gold is fully visible and reset slide progress
        goldPositions.forEach(gold => {
            gold.opacity = 1.0;
            gold.slideProgress = 0;
            gold.fallenOut = false;
        });
        
        goldCounter.style.display = 'none'; // Keep counter HIDDEN - we don't want to show it
        drawImages();
        
        // Start the sliding animation
        startGoldSlideAnimation();
        
        // Start the collection timer - reduced to 7 seconds for harder difficulty
        startTimer(7, 'Collect gold', () => {
            // When collection timer runs out, close the UI
            closeUI();
        });
    }
});

document.addEventListener('keydown', function(event) {
    if (event.key === 'Escape') {
        closeUI();
    } else if (event.key === ' ' || event.code === 'Space') {
        // Toggle sound with Space key
        event.preventDefault(); // Prevent page scroll
        toggleSound();
    }
});

// Sound toggle button click event
soundToggle.addEventListener('click', function(e) {
    e.stopPropagation(); // Prevent canvas click from interfering
    e.preventDefault();
    toggleSound();
});

function onMouseMove(e) {
    // This function is now empty as the logic is handled by mousemove
}
