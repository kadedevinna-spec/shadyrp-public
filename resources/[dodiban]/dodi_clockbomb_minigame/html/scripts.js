let bombTimer = null;
let totalTime = 0;
let remainingTime = 0;
let isActive = false;
let savedTime = 0; // Saves the configured time when UI is closed

// Audio system
let timeSetAudio = null;
let tickAudio = null;

// Button hold system
let holdInterval = null;
let holdTimeout = null;

// Config from Lua
let audioConfig = {
    enabled: true,
    timeSetSound: "sounds/time_set.mp3",
    tickSound: "sounds/tick.mp3",
    volumes: {
        timeSet: 0.5,
        tick: 0.3
    }
};

// DOM elements
const container = document.getElementById('minigame-container');
const timerSetup = document.getElementById('timer-setup');
const timerDisplay = document.getElementById('timer-display');
const activeControls = document.getElementById('active-controls');
const timerText = document.getElementById('timer-text');
const timeInput = document.getElementById('time-input');
const timeIncrease = document.getElementById('time-increase');
const timeDecrease = document.getElementById('time-decrease');
const startBtn = document.getElementById('start-btn');
const stopBtn = document.getElementById('stop-btn');
const closeBtn = document.getElementById('close-btn');
const hourHand = document.getElementById('hour-hand');
const minuteHand = document.getElementById('minute-hand');
const secondHand = document.getElementById('second-hand');
const bombContainer = document.querySelector('.bomb-container');

// Mini display elements
const miniDisplay = document.getElementById('mini-bomb-display');
const miniContainer = document.querySelector('.mini-bomb-container');
const miniTimerText = document.getElementById('mini-timer-text');
const miniHourHand = document.getElementById('mini-hour-hand');
const miniMinuteHand = document.getElementById('mini-minute-hand');
const miniSecondHand = document.getElementById('mini-second-hand');

// Event listeners
closeBtn.addEventListener('click', closeBomb);
startBtn.addEventListener('click', startBomb);
stopBtn.addEventListener('click', stopBomb);
timeInput.addEventListener('input', updateClockHandsPreview);
timeIncrease.addEventListener('click', increaseTime);
timeDecrease.addEventListener('click', decreaseTime);

// Button hold system for time adjustment
timeIncrease.addEventListener('mousedown', () => startHoldAction('increase'));
timeIncrease.addEventListener('mouseup', stopHoldAction);
timeIncrease.addEventListener('mouseleave', stopHoldAction);
timeDecrease.addEventListener('mousedown', () => startHoldAction('decrease'));
timeDecrease.addEventListener('mouseup', stopHoldAction);
timeDecrease.addEventListener('mouseleave', stopHoldAction);

// Initialize audio
initAudio();

// Audio functions
function initAudio() {
    if (!audioConfig.enabled) return;
    
    try {
        // Create audio elements for MP3 files using config
        timeSetAudio = new Audio(audioConfig.timeSetSound);
        tickAudio = new Audio(audioConfig.tickSound);
        
        // Set volume levels from config
        timeSetAudio.volume = audioConfig.volumes.timeSet;
        tickAudio.volume = audioConfig.volumes.tick;
        
        // Preload audio files
        timeSetAudio.preload = 'auto';
        tickAudio.preload = 'auto';
        
    } catch (error) {
        console.log('Error initializing audio:', error);
    }
}

function playTimeSetSound() {
    if (!audioConfig.enabled) return;
    
    try {
        if (timeSetAudio) {
            timeSetAudio.currentTime = 0; // Reset to beginning
            timeSetAudio.play().catch(e => console.log('Error playing time set sound:', e));
        }
    } catch (error) {
        console.log('Error playing time set sound:', error);
    }
}

function startTimeSetSound() {
    if (!audioConfig.enabled) return;
    
    try {
        if (timeSetAudio) {
            // Always stop and reset before starting
            timeSetAudio.pause();
            timeSetAudio.currentTime = 0;
            timeSetAudio.loop = true; // Loop while button is pressed
            timeSetAudio.playbackRate = 2.5; // Make it much faster (2.5x speed)
            timeSetAudio.play().catch(e => console.log('Error starting time set sound:', e));
        }
    } catch (error) {
        console.log('Error starting time set sound:', error);
    }
}

function stopTimeSetSound() {
    try {
        if (timeSetAudio) {
            timeSetAudio.loop = false; // Stop looping
            timeSetAudio.pause();
            timeSetAudio.currentTime = 0;
        }
    } catch (error) {
        console.log('Error stopping time set sound:', error);
    }
}

function playTickSound() {
    if (!audioConfig.enabled) return;
    
    // // Only play if UI is visible
    // if (container.classList.contains('hidden')) return;
    
    try {
        if (tickAudio) {
            tickAudio.currentTime = 0;
            tickAudio.play().catch(e => console.log('Error playing tick sound:', e));
        }
    } catch (error) {
        console.log('Error playing tick sound:', error);
    }
}

function stopAllAudio() {
    try {
        if (timeSetAudio) {
            timeSetAudio.loop = false;
            timeSetAudio.pause();
            timeSetAudio.currentTime = 0;
        }
        if (tickAudio) {
            tickAudio.pause();
            tickAudio.currentTime = 0;
        }
    } catch (error) {
        console.log('Error stopping audio:', error);
    }
}

// Button hold functions
function startHoldAction(action) {
    // Execute immediately
    if (action === 'increase') {
        increaseTime();
    } else {
        decreaseTime();
    }
    
    // Start audio
    startTimeSetSound();
    
    // Start repeating after 500ms delay
    holdTimeout = setTimeout(() => {
        holdInterval = setInterval(() => {
            if (action === 'increase') {
                increaseTime();
            } else {
                decreaseTime();
            }
        }, 100); // Repeat every 100ms
    }, 500); // Initial delay of 500ms
}

function stopHoldAction() {
    // Clear timers
    if (holdTimeout) {
        clearTimeout(holdTimeout);
        holdTimeout = null;
    }
    if (holdInterval) {
        clearInterval(holdInterval);
        holdInterval = null;
    }
    
    // Stop audio
    stopTimeSetSound();
}

// Listen for messages from Lua
window.addEventListener('message', function(event) {
    const data = event.data;
    
    switch(data.action) {
        case 'openMinigame':
            if (data.audioConfig) {
                audioConfig = data.audioConfig;
                initAudio(); // Reinitialize with new config
            }
            openMinigame();
            break;
        case 'closeMinigame':
            closeMinigame();
            break;
        case 'showMiniDisplay':
            // Exibir apenas se o servidor disser explicitamente que pode
            if (data && typeof data.remainingTime === 'number' && data.remainingTime > 0 && data.allow === true) {
                showMiniDisplayExternal(data.remainingTime);
            } else {
                hideMiniDisplay();
            }
            break;
        case 'hideMiniDisplay':
            hideMiniDisplay();
            break;
        case 'updateMiniDisplay':
            updateMiniDisplayExternal(data.remainingTime);
            break;
    }
});

function openMinigame() {
    container.classList.remove('hidden');
    
    // Add opening animation classes
    container.classList.add('opening');
    bombContainer.classList.add('opening');
    
    // Remove animation classes after animation completes
    setTimeout(() => {
        container.classList.remove('opening');
        bombContainer.classList.remove('opening');
    }, 500);
    
    if (isActive && remainingTime > 0) {
        // If bomb is running and has time left, show timer display
        timerSetup.classList.add('hidden');
        timerDisplay.classList.remove('hidden');
        activeControls.classList.remove('hidden');
        
        // Update display with current time
        updateDisplay();
        
        // Timer continues, audio will start playing again automatically
    } else {
        // Show setup screen with saved time
        isActive = false;
        showSetupScreen();
    }
}

function showSetupScreen() {
    timerSetup.classList.remove('hidden');
    timerDisplay.classList.add('hidden');
    activeControls.classList.add('hidden');
    isActive = false;
    
    // Restore saved time and update clock hands
    // If savedTime is 0 or invalid, set to 1 as minimum
    const displayTime = (savedTime && savedTime > 0) ? savedTime : 1;
    timeInput.value = displayTime;
    updateClockHandsPreview();
}

function startBomb() {
    let time = parseInt(timeInput.value);
    
    // Fix zero or invalid values
    if (isNaN(time) || time <= 0) {
        time = 1; // Set minimum time to 1 second
        timeInput.value = time;
        updateClockHandsPreview();
    }
    
    // Validate input
    if (time < 1 || time > 300) {
        alert('Please enter a valid time between 1 and 300 seconds');
        return;
    }
    
    totalTime = time;
    remainingTime = time;
    isActive = true;
    
    // Hide setup, show timer
    timerSetup.classList.add('hidden');
    timerDisplay.classList.remove('hidden');
    activeControls.classList.remove('hidden');
    
    // Send start event to Lua
    fetch(`https://${GetParentResourceName()}/startBomb`, {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json; charset=UTF-8',
        },
        body: JSON.stringify({
            time: time
        })
    });
    
    updateDisplay();
    startTimer();
}

function stopBomb() {
    stopTimer();
    stopAllAudio(); // Force stop all audio immediately
    resetMinigame();
    showSetupScreen();
}

function closeMinigame() {
    // Se bomba está ativa, NÃO para o áudio (continua tocando)
    if (!isActive) {
        stopAllAudio();
    } else {
        // Para apenas o som de configuração, mantém o tick
        stopTimeSetSound();
        console.log("UI fechada - som do timer continua tocando");
    }
    
    // Notificar o Lua que a UI foi fechada (para remover NUI focus)
    fetch(`https://${GetParentResourceName()}/uiClosed`, {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json; charset=UTF-8',
        },
        body: JSON.stringify({
            bombActive: isActive,
            remainingTime: remainingTime
        })
    });
    
    // Add closing animation classes
    container.classList.add('closing');
    bombContainer.classList.add('closing');
    
    // Hide after animation completes
    setTimeout(() => {
        container.classList.add('hidden');
        container.classList.remove('closing');
        bombContainer.classList.remove('closing');
    }, 400);
    
    // Se a bomba está ativa, apenas fecha a UI (ESC)
    if (isActive) {
        // Bomba continua rodando, apenas fecha a UI
        return;
    }
    
    // Se não está ativa, salva o tempo configurado
    savedTime = parseInt(timeInput.value) || 1;
}

function closeBomb() {
    fetch(`https://${GetParentResourceName()}/closeBomb`, {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json; charset=UTF-8',
        },
        body: JSON.stringify({})
    });
}

function startTimer() {
    if (bombTimer) {
        clearInterval(bombTimer);
    }
    
    // Mini display será mostrado apenas se o servidor permitir via showMiniDisplay message
    
    bombTimer = setInterval(() => {
        if (remainingTime <= 0) {
            explodeBomb();
            return;
        }
        
        remainingTime--;
        updateDisplay();
        updateClockHands();
        
        // Play tick sound
        playTickSound();
        
        // Add warning effects when time is low
        if (remainingTime <= 10) {
            container.classList.add('warning');
            bombContainer.classList.add('ticking');
            
            // Warning no mini display também
            if (miniContainer) {
                miniContainer.classList.add('warning');
            }
        }
        
    }, 1000);
}

function stopTimer() {
    if (bombTimer) {
        clearInterval(bombTimer);
        bombTimer = null;
    }
    container.classList.remove('warning');
    bombContainer.classList.remove('ticking');
    
    // Remover warning do mini display
    if (miniContainer) {
        miniContainer.classList.remove('warning');
    }
    
    // Esconder mini display
    hideMiniDisplay();
    
    stopAllAudio(); // Stop all audio when timer stops
}

function forceStopEverything() {
    // Nuclear option - stop absolutely everything
    stopTimer();
    stopAllAudio();
    stopHoldAction();
    isActive = false;
}

function updateDisplay() {
    const minutes = Math.floor(remainingTime / 60);
    const seconds = remainingTime % 60;
    const timeString = `${minutes.toString().padStart(2, '0')}:${seconds.toString().padStart(2, '0')}`;
    
    timerText.textContent = timeString;
    
    // Atualizar mini display também
    if (miniTimerText) {
        miniTimerText.textContent = timeString;
    }
}

function updateClockHands() {
    // Calculate angles based on remaining time
    const totalSeconds = remainingTime;
    const minutes = Math.floor(totalSeconds / 60) % 60;
    const seconds = totalSeconds % 60;
    const hours = Math.floor(totalSeconds / 3600) % 12;
    
    // Calculate angles (360 degrees = full circle, 0 deg = 12 o'clock)
    const secondAngle = (seconds * 6); // 6 degrees per second
    const minuteAngle = (minutes * 6) + (seconds * 0.1); // 6 degrees per minute + smooth seconds
    const hourAngle = (hours * 30) + (minutes * 0.5); // 30 degrees per hour + smooth minutes
    
    // Apply rotations to main clock
    secondHand.style.transform = `rotate(${secondAngle}deg)`;
    minuteHand.style.transform = `rotate(${minuteAngle}deg)`;
    hourHand.style.transform = `rotate(${hourAngle}deg)`;
    
    // Apply rotations to mini clock
    if (miniSecondHand && miniMinuteHand && miniHourHand) {
        miniSecondHand.style.transform = `rotate(${secondAngle}deg)`;
        miniMinuteHand.style.transform = `rotate(${minuteAngle}deg)`;
        miniHourHand.style.transform = `rotate(${hourAngle}deg)`;
    }
}

function updateClockHandsPreview() {
    const inputTime = parseInt(timeInput.value) || 1;
    
    if (inputTime <= 0) {
        // Reset to 12 o'clock position when 0 or invalid
        initializeClockHands();
        return;
    }
    
    // Calculate angles based on input time
    const totalSeconds = inputTime;
    const minutes = Math.floor(totalSeconds / 60) % 60;
    const seconds = totalSeconds % 60;
    const hours = Math.floor(totalSeconds / 3600) % 12;
    
    // Calculate angles (360 degrees = full circle, 0 deg = 12 o'clock)
    const secondAngle = (seconds * 6); // 6 degrees per second
    const minuteAngle = (minutes * 6) + (seconds * 0.1); // 6 degrees per minute + smooth seconds
    const hourAngle = (hours * 30) + (minutes * 0.5); // 30 degrees per hour + smooth minutes
    
    // Apply rotations
    secondHand.style.transform = `rotate(${secondAngle}deg)`;
    minuteHand.style.transform = `rotate(${minuteAngle}deg)`;
    hourHand.style.transform = `rotate(${hourAngle}deg)`;
}

function explodeBomb() {
    stopTimer(); // This already calls stopAllAudio()
    
    // Esconder mini display imediatamente
    hideMiniDisplay();
    
    // Add explosion effect
    bombContainer.classList.add('exploding');
    
    // Send explosion event to Lua com o tempo TOTAL configurado
    fetch(`https://${GetParentResourceName()}/bombExploded`, {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json; charset=UTF-8',
        },
        body: JSON.stringify({
            time: totalTime // Tempo total configurado, não o tempo decorrido
        })
    });
    
    // Reset everything after explosion
    setTimeout(() => {
        resetMinigame();
        closeMinigame();
        bombContainer.classList.remove('exploding');
    }, 1000);
}

function resetMinigame() {
    // Reset all values to initial state
    savedTime = 1; // Set minimum time instead of 0
    totalTime = 0;
    remainingTime = 0;
    isActive = false;
    timeInput.value = 1; // Set minimum time instead of 0
    initializeClockHands();
}

function increaseTime() {
    let currentValue = parseInt(timeInput.value) || 1;
    if (currentValue < 300) {
        currentValue += 1; // Increase by 1 second
        timeInput.value = currentValue;
        updateClockHandsPreview();
    }
}

function decreaseTime() {
    let currentValue = parseInt(timeInput.value) || 1;
    if (currentValue > 1) {
        currentValue = Math.max(1, currentValue - 1); // Decrease by 1 second, min 1
        timeInput.value = currentValue;
        updateClockHandsPreview();
    }
}

// Handle ESC key - apenas fecha a UI, não cancela a bomba
document.addEventListener('keydown', function(event) {
    if (event.key === 'Escape' && container.classList.contains('hidden') === false) {
        closeMinigame(); // Apenas fecha a UI, não cancela
    }
});

// Handle Enter key to start bomb
timeInput.addEventListener('keydown', function(event) {
    if (event.key === 'Enter') {
        startBomb();
    }
});

// Initialize clock hands position
function initializeClockHands() {
    secondHand.style.transform = 'rotate(0deg)';
    minuteHand.style.transform = 'rotate(0deg)';
    hourHand.style.transform = 'rotate(0deg)';
}

// Funções do mini display
function showMiniDisplay() {
    if (miniDisplay) {
        // Evitar reexibir se já estiver visível
        if (!miniDisplay.classList.contains('hidden')) return;
        miniDisplay.classList.remove('hidden');
        console.log("Mini display mostrado");
    }
}

function hideMiniDisplay() {
    if (miniDisplay) {
        miniDisplay.classList.add('hidden');
        console.log("Mini display escondido");
    }
}

// Funções para controle externo do mini display (sincronização)
function showMiniDisplayExternal(remainingTime) {
    if (miniDisplay && miniTimerText) {
        // Ignorar tempos inválidos
        if (!remainingTime || remainingTime <= 0) {
            hideMiniDisplay();
            return;
        }
        // Configurar tempo inicial
        const minutes = Math.floor(remainingTime / 60);
        const seconds = remainingTime % 60;
        const timeString = `${minutes.toString().padStart(2, '0')}:${seconds.toString().padStart(2, '0')}`;
        
        miniTimerText.textContent = timeString;
        
        // Atualizar ponteiros do relógio
        updateMiniClockHands(remainingTime);
        
        // Mostrar display
        if (miniDisplay.classList.contains('hidden')) {
            miniDisplay.classList.remove('hidden');
        }
        
        console.log("Mini display externo mostrado - Tempo: " + remainingTime + "s");
    }
}

function updateMiniDisplayExternal(remainingTime) {
    if (miniTimerText) {
        const minutes = Math.floor(remainingTime / 60);
        const seconds = remainingTime % 60;
        const timeString = `${minutes.toString().padStart(2, '0')}:${seconds.toString().padStart(2, '0')}`;
        
        miniTimerText.textContent = timeString;
        
        // Atualizar ponteiros do relógio
        updateMiniClockHands(remainingTime);
        
        // Adicionar warning se tempo baixo
        if (remainingTime <= 10 && miniContainer) {
            miniContainer.classList.add('warning');
        }
    }
}

function updateMiniClockHands(remainingTime) {
    if (miniSecondHand && miniMinuteHand && miniHourHand) {
        const totalSeconds = remainingTime;
        const minutes = Math.floor(totalSeconds / 60) % 60;
        const seconds = totalSeconds % 60;
        const hours = Math.floor(totalSeconds / 3600) % 12;
        
        const secondAngle = (seconds * 6);
        const minuteAngle = (minutes * 6) + (seconds * 0.1);
        const hourAngle = (hours * 30) + (minutes * 0.5);
        
        miniSecondHand.style.transform = `rotate(${secondAngle}deg)`;
        miniMinuteHand.style.transform = `rotate(${minuteAngle}deg)`;
        miniHourHand.style.transform = `rotate(${hourAngle}deg)`;
    }
}

// Initialize when page loads
document.addEventListener('DOMContentLoaded', function() {
    initializeClockHands();
});
