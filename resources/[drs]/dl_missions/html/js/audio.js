// Audio State
let currentAudioId = null;
let audioElement = null;


// Initialize Audio Manager
$(document).ready(function(){
    
    audioElement = document.getElementById('audioPlayer');
    
    if (!audioElement) {
        console.error('[Audio] Audio element not found!');
        return;
    }
    
    console.log('[Audio] Audio Manager initialized');
    
    // Setup Audio Event Listeners
    setupAudioEvents();
    
    // Setup NUI Message Listener
    setupNUIListener();
    
});


function setupAudioEvents(){
    // Audio Ended Event
    audioElement.addEventListener('ended', function() {
        notifyLuaAudioFinished();
        resetAudioState();
    });
    
    // Audio Error Event
    audioElement.addEventListener('error', function(e) {
        console.error('[Audio] Error loading audio:', currentAudioId, e);
        notifyLuaAudioFinished();
        resetAudioState();
    });
}


function setupNUIListener(){
    window.addEventListener('message', function(event) {
        if (event.data.type === 'playAudio') {
            handlePlayAudio(event.data);
        } else if (event.data.type === 'stopAudio') {
            handleStopAudio();
        }
    });
}


// Handle Play Audio Request
function handlePlayAudio(data){

    if (!audioElement) {
        console.error('[Audio] Audio element not available');
        return;
    }

    if (!data.audio || data.audio === '') {
        console.warn('[Audio] No audio file provided');
        return;
    }
    
    currentAudioId = data.audioId || 'unknown';
    audioElement.src = "audios/" + data.audio; // ist nui://dl_missions/audios/introduction/intro_begin_01.m4a obwohl es doch wenn man vom js pfad ausgeht ../audios/introduction/intro_begin_01.m4a sein sollte

    audioElement.volume = data.volume || 0.7;
    
    // Try to play audio
    const playPromise = audioElement.play();
    
    if (playPromise !== undefined) {
        playPromise.catch(function(error) {
            console.error('[Audio] Play failed:', error);
            notifyLuaAudioFinished();
            resetAudioState();
        });
    }
    
}


// Handle Stop Audio Request
function handleStopAudio(){
    
    audioElement.pause();
    audioElement.currentTime = 0;
    audioElement.src = '';
    resetAudioState();
    
}


// Notify Lua that Audio has Finished
function notifyLuaAudioFinished(){
    
    if (!currentAudioId) {
        console.warn('[Audio] No audioId to notify');
        return;
    }
    
    $.post(`https://dl_missions/audioFinished`, JSON.stringify({
        audioId: currentAudioId
    }));
    
}


// Reset Audio State
function resetAudioState(){
    currentAudioId = null;
}