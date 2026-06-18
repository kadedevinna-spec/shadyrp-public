// Dial 3D Minigame System - Based on Badge 3D example
import * as THREE from 'https://cdn.jsdelivr.net/npm/three@0.126.1/build/three.module.js';
import { GLTFLoader } from 'https://cdn.jsdelivr.net/npm/three@0.126.1/examples/jsm/loaders/GLTFLoader.js';

let scene, camera, renderer;
let dialModel; // Modelo do dial
let mouseX = 0;
let mouseY = 0;
const windowHalfX = window.innerWidth / 2;
const windowHalfY = window.innerHeight / 2;
let isDialShowing = false;
let dialInitialized = false;

// Variáveis do minigame
let currentCombination = [];
let targetCombination = [];
let currentStep = 0;
let currentDialRotation = 0;
let isListening = false;
let lastClickSound = 0;

// Audio context for click sounds
let audioContext;
let clickBuffer;
let spinAudio;
let clickAudio;
let isSpinning = false;
let lastMouseAngle = 0;
let mouseSensitivity = 0.3; // Sensibilidade padrão (30%)

// Eventos do mouse
function onDocumentMouseMove(event) {
    mouseX = (event.clientX - windowHalfX);
    mouseY = (event.clientY - windowHalfY);
    
    if (isDialShowing && dialModel) {
        // Calcular rotação baseada no movimento do mouse com sensibilidade
        const mouseAngle = Math.atan2(mouseY, mouseX);
        
        // Calcular diferença de ângulo (tratando wrap-around)
        let angleDiff = mouseAngle - lastMouseAngle;
        if (angleDiff > Math.PI) angleDiff -= 2 * Math.PI;
        if (angleDiff < -Math.PI) angleDiff += 2 * Math.PI;
        
        // Aplicar sensibilidade apenas na velocidade de mudança
        const dampedDiff = angleDiff * mouseSensitivity;
        currentDialRotation += dampedDiff;
        
        // Verificar se o dial está sendo girado
        if (Math.abs(dampedDiff) > 0.003) {
            playSpinSound();
            
            // Timer para parar o som quando parar de girar
            clearTimeout(window.spinTimeout);
            window.spinTimeout = setTimeout(() => {
                stopSpinSound();
            }, 150);
        }
        
        lastMouseAngle = mouseAngle;
        
        // Aplicar rotação baseada no eixo selecionado
        const baseRotation = {x: -Math.PI / 2, y: 0, z: Math.PI}; // Rotação base (dial de cima, virado para frente)
        const axis = window.rotationAxis || 'y'; // Eixo padrão Y (como relógio no plano horizontal)
        
        if (axis === 'x') {
            dialModel.rotation.set(baseRotation.x + currentDialRotation, baseRotation.y, baseRotation.z);
        } else if (axis === 'y') {
            dialModel.rotation.set(baseRotation.x, baseRotation.y + currentDialRotation, baseRotation.z);
        } else if (axis === 'z') {
            dialModel.rotation.set(baseRotation.x, baseRotation.y, baseRotation.z + currentDialRotation);
        }
        
        // Verificar se está próximo de um número da combinação
        checkNumberProximity();
    }
}

// Click para confirmar número
function onDocumentClick(event) {
    if (isDialShowing && isListening) {
        confirmCurrentNumber();
    }
}

document.addEventListener('mousemove', onDocumentMouseMove);
document.addEventListener('click', onDocumentClick);

// Inicializar audio
function initAudio() {
    try {
        // Carregar áudios customizados
        spinAudio = new Audio('audio/dial_spin.mp3');
        clickAudio = new Audio('audio/dial_click.mp3');
        
        // Configurar propriedades dos áudios
        spinAudio.loop = true;
        spinAudio.volume = 0.5;
        clickAudio.volume = 0.7;
        
        console.log('Áudios customizados carregados');
    } catch (e) {
        console.log('Erro ao carregar áudios:', e);
    }
}

// Tocar som de click
function playClickSound() {
    try {
        if (clickAudio) {
            clickAudio.currentTime = 0;
            clickAudio.play();
        }
    } catch (e) {
        console.log('Erro ao tocar som de click:', e);
    }
}

// Tocar som de spin
function playSpinSound() {
    try {
        if (spinAudio && !isSpinning) {
            spinAudio.currentTime = 0;
            spinAudio.play();
            isSpinning = true;
        }
    } catch (e) {
        console.log('Erro ao tocar som de spin:', e);
    }
}

// Parar som de spin
function stopSpinSound() {
    try {
        if (spinAudio && isSpinning) {
            spinAudio.pause();
            spinAudio.currentTime = 0;
            isSpinning = false;
        }
    } catch (e) {
        console.log('Erro ao parar som de spin:', e);
    }
}

// Verificar proximidade do número
function checkNumberProximity() {
    if (currentStep >= targetCombination.length) return;
    
    const targetNumber = targetCombination[currentStep];
    
    // Calcular qual número está no topo (posição 12h) baseado na rotação atual
    // Como o dial foi espelhado, precisamos ajustar o cálculo
    const currentAngle = ((currentDialRotation % (Math.PI * 2)) + (Math.PI * 2)) % (Math.PI * 2);
    
    // Converter ângulo para número no dial (0-99)
    // Inverter direção e ajustar offset para sincronizar com o GLB
    const rawNumber = Math.round(((-currentAngle) / (Math.PI * 2)) * 100);
    const numberAt12h = ((rawNumber + 28) % 100 + 100) % 100;
    
    // Tolerância para considerar "próximo" do número
    const tolerance = 3; // ±3 números de tolerância
    
    // Verificar se o número no topo está próximo do número alvo
    let isNearTarget = false;
    for (let i = -tolerance; i <= tolerance; i++) {
        const checkNumber = (targetNumber + i + 100) % 100;
        if (checkNumber === numberAt12h) {
            isNearTarget = true;
            break;
        }
    }
    
    if (isNearTarget) {
        isListening = true;
        
        // // Feedback visual
        // const statusText = document.getElementById('status-text');
        // if (statusText) {
        //     statusText.textContent = `Click to confirm: ${targetNumber} (showing: ${numberAt12h})`;
        //     statusText.style.color = '#f1c40f';
        // }
    } else {
        isListening = false;
        // const statusText = document.getElementById('status-text');
        // if (statusText && currentStep < 3) {
        //     statusText.textContent = `Find the ${getCurrentStepText()}: ${targetNumber} (showing: ${numberAt12h})`;
        //     statusText.style.color = '#cccccc';
        // }
    }
    
    // Não mostrar dicas sobre qual número encontrar
    const statusText = document.getElementById('status-text');
    if (statusText && currentStep < 3) {
        statusText.textContent = `Find the ${getCurrentStepText()}`;
        statusText.style.color = '#cccccc';
    }
}

// Confirmar número atual
function confirmCurrentNumber() {
    if (currentStep >= targetCombination.length || !isListening) return;
    
    const targetNumber = targetCombination[currentStep];
    
    // Calcular o número atual no topo (12h)
    const currentAngle = ((currentDialRotation % (Math.PI * 2)) + (Math.PI * 2)) % (Math.PI * 2);
    const rawNumber = Math.round(((-currentAngle) / (Math.PI * 2)) * 100);
    const numberAt12h = ((rawNumber + 28) % 100 + 100) % 100;
    
    // Verificar se está realmente próximo do número alvo
    const tolerance = 3;
    let isCorrect = false;
    for (let i = -tolerance; i <= tolerance; i++) {
        const checkNumber = (targetNumber + i + 100) % 100;
        if (checkNumber === numberAt12h) {
            isCorrect = true;
            break;
        }
    }
    
    if (isCorrect) {
        // Sucesso - tocar som e continuar
        playClickSound();
        currentCombination.push(targetNumber);
        
        // Atualizar display
        updateCombinationDisplay();
        updateProgressBar();
        
        const digit = document.getElementById(`digit${currentStep + 1}`);
        if (digit) {
            digit.classList.add('found');
            digit.textContent = targetNumber;
        }
        
        currentStep++;
        
        // Verificar se completou
        if (currentStep >= targetCombination.length) {
            completedMinigame();
        } else {
            // Próximo número
            const statusText = document.getElementById('status-text');
            if (statusText) {
                statusText.textContent = `Find the ${getCurrentStepText()}`;
            }
            
            // Atualizar digit atual
            updateCurrentDigit();
        }
    } else {
        // Erro - não estava no número certo
        console.log(`Erro: tentou confirmar ${targetNumber} mas está em ${numberAt12h}`);
    }
    
    isListening = false;
}

// Obter texto do passo atual
function getCurrentStepText() {
    switch (currentStep) {
        case 0: return 'first number';
        case 1: return 'second number';
        case 2: return 'third number';
        default: return 'number';
    }
}

// Atualizar display da combinação
function updateCombinationDisplay() {
    for (let i = 0; i < 3; i++) {
        const digit = document.getElementById(`digit${i + 1}`);
        if (digit) {
            if (i < currentCombination.length) {
                digit.textContent = currentCombination[i];
                digit.classList.add('found');
                digit.classList.remove('current');
            } else if (i === currentStep) {
                digit.classList.add('current');
                digit.classList.remove('found');
            } else {
                digit.textContent = '-';
                digit.classList.remove('found', 'current');
            }
        }
    }
}

// Atualizar digit atual
function updateCurrentDigit() {
    for (let i = 0; i < 3; i++) {
        const digit = document.getElementById(`digit${i + 1}`);
        if (digit) {
            if (i === currentStep) {
                digit.classList.add('current');
            } else {
                digit.classList.remove('current');
            }
        }
    }
}

// Atualizar barra de progresso
function updateProgressBar() {
    const progressFill = document.getElementById('progress-fill');
    if (progressFill) {
        const progress = (currentCombination.length / 3) * 100;
        progressFill.style.width = `${progress}%`;
    }
}

// Minigame completado
function completedMinigame() {
    const statusText = document.getElementById('status-text');
    if (statusText) {
        statusText.textContent = 'Safe unlocked!';
        statusText.style.color = '#2ecc71';
    }
    
    const dialInterface = document.getElementById('dial-interface');
    if (dialInterface) {
        dialInterface.classList.add('success');
    }
    
    // Notificar o cliente com a combinação
    setTimeout(() => {
        // Formatar combinação como string "XX XX XX"
        const combinationString = targetCombination.map(num => 
            String(num).padStart(2, '0')
        ).join(' ');
        
        fetch(`https://dodi_bankrobbery/dialCompleted`, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json; charset=UTF-8',
            },
            body: JSON.stringify({
                combination: combinationString
            })
        });
        
        console.log('Sending combination to Lua:', combinationString);
    }, 1500);
}

// Inicializar cena 3D
function init3D() {
    console.log('=== Initializing Dial 3D ===');
    
    // Configuração da cena
    scene = new THREE.Scene();
    camera = new THREE.PerspectiveCamera(75, 1, 0.1, 1000); // Aspect ratio 1:1 mantido para 800x800
    renderer = new THREE.WebGLRenderer({ 
        alpha: true,
        antialias: true
    });
    renderer.setClearColor(0x000000, 0);
    renderer.setSize(800, 800); // Aumentado de 600x600 para 800x800
    renderer.outputEncoding = THREE.sRGBEncoding;
    renderer.toneMapping = THREE.ACESFilmicToneMapping;
    renderer.toneMappingExposure = 1;
    renderer.shadowMap.enabled = true;
    renderer.shadowMap.type = THREE.PCFSoftShadowMap;

    // Anexar ao container
    const modelContainer = document.getElementById('model-container');
    if (!modelContainer) {
        console.error('model-container not found!');
        return;
    }
    
    modelContainer.innerHTML = '';
    modelContainer.appendChild(renderer.domElement);

    // Iluminação
    const ambientLight = new THREE.AmbientLight(0xffffff, 0.6);
    scene.add(ambientLight);
    
    const directionalLight = new THREE.DirectionalLight(0xffffff, 0.8);
    directionalLight.position.set(0, 0, 10);
    scene.add(directionalLight);
    
    const pointLight = new THREE.PointLight(0xffffff, 0.5);
    pointLight.position.set(0, 0, 5);
    scene.add(pointLight);

    // Carregar modelo do dial
    const loader = new GLTFLoader();
    console.log('Loading safe_dial.glb');
    
    loader.load('safe_dial.glb', function(gltf) {
        console.log('Dial model loaded successfully!');
        dialModel = gltf.scene;
        
        // Centralizar modelo
        const box = new THREE.Box3().setFromObject(dialModel);
        const center = box.getCenter(new THREE.Vector3());
        const size = box.getSize(new THREE.Vector3());
        
        dialModel.position.sub(center);
        
        // Processar materiais
        dialModel.traverse((child) => {
            if (child.isMesh) {
                if (child.material) {
                    child.material.needsUpdate = true;
                    child.castShadow = false;
                    child.receiveShadow = false;
                    
                    if (child.material.map) {
                        child.material.map.encoding = THREE.sRGBEncoding;
                    }
                }
            }
        });
        
        scene.add(dialModel);

        // Configurar escala e posição - AJUSTADO para o container maior
        const maxDim = Math.max(size.x, size.y, size.z);
        const scale = 3.5 / maxDim; // Diminuído de 4.5 para 3.5 por causa do container maior
        dialModel.scale.set(-scale, scale, scale); // Escala negativa no X para espelhar
        
        // Rotação para deixar o dial de cima para baixo e virado para frente
        dialModel.rotation.x = -Math.PI / 2; // -90 graus no eixo X (vira para cima)
        dialModel.rotation.y = 0; // Reset Y
        dialModel.rotation.z = Math.PI; // 180 graus no eixo Z (vira para frente)
        
        // Câmera mais próxima para mais zoom
        camera.position.set(0, 0, 4); // Aproximado de 5 para 4
        camera.lookAt(0, 0, 0);
        
        dialInitialized = true;
        console.log('Dial 3D initialized');
    }, undefined, function(error) {
        console.error('Error loading dial model:', error);
    });
}

// Loop de animação
function animate() {
    requestAnimationFrame(animate);

    if (dialModel && isDialShowing) {
        // Pequena flutuação no eixo Z (para frente e para trás)
        dialModel.position.z = Math.sin(Date.now() * 0.001) * 0.05;
    }

    if (renderer && isDialShowing) {
        renderer.render(scene, camera);
    }
}

// Gerar combinação aleatória
function generateRandomCombination() {
    targetCombination = [];
    for (let i = 0; i < 3; i++) {
        targetCombination.push(Math.floor(Math.random() * 100));
    }
    console.log('Generated combination:', targetCombination);
}

// Abrir minigame
function openDialMinigame() {
    console.log('=== Opening Dial Minigame ===');
    
    if (isDialShowing) {
        console.log('Dial already showing, returning');
        return;
    }
    
    isDialShowing = true;
    console.log('Setting isDialShowing to true');
    
    // Resetar estado
    currentCombination = [];
    currentStep = 0;
    currentDialRotation = 0;
    isListening = false;
    
    // Não gerar combinação - será definida pelo servidor
    
    // Garantir que o body esteja visível
    document.body.style.display = 'block';

    // Mostrar container
    const container = document.getElementById('dial-container');
    console.log('Container found:', container);
    if (container) {
        console.log('Setting container display to flex');
        container.style.display = 'flex';
        
        // Force z-index to be above everything else
        container.style.zIndex = '9999999';
        
        // Ensure other containers are hidden (using classes instead of inline hard overrides)
        const torchContainer = document.getElementById('minigameContainer');
        if (torchContainer) {
            torchContainer.classList.remove('active');
            torchContainer.classList.add('closing');
            setTimeout(() => {
                torchContainer.classList.remove('closing');
                torchContainer.style.display = '';
                torchContainer.style.zIndex = '';
            }, 300);
            console.log('Torch container closed via classes');
        }
        
        const sabotageContainer = document.getElementById('sabotageContainer');
        if (sabotageContainer) {
            sabotageContainer.classList.add('hidden');
            sabotageContainer.style.display = '';
            sabotageContainer.style.zIndex = '';
            console.log('Sabotage container hidden');
        }
        
        console.log('Dial container z-index set to 9999999');
    }
    
    // Inicializar áudio
    initAudio();
    
    // Inicializar 3D se necessário
    if (!dialInitialized) {
        init3D();
    }
    
    // Atualizar interface
    updateCombinationDisplay();
    updateCurrentDigit();
    updateProgressBar();
    
    const statusText = document.getElementById('status-text');
    if (statusText) {
        statusText.textContent = `Find the first number`;
    }
    
    // Debug: mostrar combinação no console
    console.log('Target combination for this vault:', targetCombination);
    
    // Iniciar loop de animação
    animate();
    
    console.log('Dial minigame opened');
}

// Fechar minigame
function closeDialMinigame() {
    console.log('Closing dial minigame');
    
    if (!isDialShowing) {
        console.log('Dial not showing, but forcing reset');
    }
    
    // Resetar estado SEMPRE
    isDialShowing = false;
    console.log('Setting isDialShowing to false');
    
    // Parar todos os sons
    stopSpinSound();
    clearTimeout(window.spinTimeout);
    
    const container = document.getElementById('dial-container');
    console.log('Container found for closing:', container);
    if (container) {
        console.log('Setting container display to none');
        container.style.display = 'none';
        container.style.zIndex = '999999'; // Reset to original CSS value
        console.log('Dial container z-index reset to original');
    }
    
    // Reset visual feedback
    const dialInterface = document.getElementById('dial-interface');
    if (dialInterface) {
        dialInterface.classList.remove('success', 'error');
    }
    
    console.log('Dial minigame closed');
}

// Event listener principal consolidado para todos os sistemas
window.addEventListener('message', function(event) {
    const data = event.data;
    
    switch (data.action) {
        // === DIAL MINIGAME ===
        case 'openDialMinigame':
            console.log('Received openDialMinigame event');
            // Se a combinação foi enviada pelo servidor, usar ela
            if (data.combination) {
                console.log('Using server combination:', data.combination);
                // Converter string "XX XX XX" para array de números
                const combParts = data.combination.split(' ');
                targetCombination = combParts.map(part => parseInt(part, 10));
                console.log('Parsed combination:', targetCombination);
            }
            openDialMinigame();
            break;
        case 'closeDialMinigame':
            closeDialMinigame();
            break;
            
        // === GENERATOR AUDIO ===
        case 'updateGeneratorAudio':
            if (data.distance !== undefined) {
                generatorAudio.updateVolume(
                    data.distance, 
                    data.minDistance, 
                    data.maxDistance
                );
            }
            break;
            
        case 'fadeOutGeneratorAudio':
            generatorAudio.targetVolume = 0;
            break;
            
        case 'stopGeneratorAudio':
            generatorAudio.cleanup();
            break;
            
        case 'setGeneratorBroken':
            generatorAudio.setBrokenState(data.broken || false);
            break;
            
        // === SABOTAGE MINIGAME ===
        case 'openSabotage':
            gameConfig = data.config;
            currentGeneratorId = data.generatorId;
            (function(){
                const sc = document.getElementById('sabotageContainer');
                if (sc) {
                    // Limpar estilos inline que possam ter sido forçados por outros UIs
                    sc.style.display = '';
                    sc.style.zIndex = '';
                    sc.classList.remove('hidden');
                }
            })();
            playSound('uiOpen');
            console.log('Sabotage UI opened for generator:', currentGeneratorId);
            break;
            
        case 'closeSabotage':
            document.getElementById('sabotageContainer').classList.add('hidden');
            console.log('Sabotage UI closed');
            break;
            
        // === TORCH MINIGAME ===
        case 'openMinigame':
            torchGameConfig = data.config;
            openTorchMinigame();
            break;
        case 'closeMinigame':
            // Parar todos os sons antes de fechar
            if (torchAudio) {
                torchAudio.stopAllSounds();
            }
            closeTorchMinigame();
            break;
        case 'nextPhase':
            torchGameConfig = data.config;
            loadNextPhase(data.phaseData);
            break;
            
        // === ROBBERY PROGRESS ===
        case 'startRobbery':
            if (!robberyProgress) {
                robberyProgress = new RobberyProgress();
            }
            robberyProgress.start(data.config);
            break;
        case 'stopRobbery':
            if (robberyProgress) {
                robberyProgress.stop();
            }
            break;
    }
});

// Teclas para testar orientações + ESC para fechar
document.addEventListener('keydown', function(event) {
    // ESC para fechar qualquer minigame ativo
    if (event.key === 'Escape') {
        if (isDialShowing) {
            console.log('ESC pressed - closing dial minigame');
            fetch('https://dodi_bankrobbery/closeDialMinigame', {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify({})
            });
            return;
        }
        
        // Verificar se torch minigame está ativo
        const torchContainer = document.getElementById('minigameContainer');
        if (torchContainer && torchContainer.classList.contains('active')) {
            console.log('ESC pressed - closing torch minigame');
            
            // Parar todos os sons ANTES de enviar callback
            if (torchAudio) {
                torchAudio.stopAllSounds();
            }
            
            fetch('https://dodi_bankrobbery/closeMinigame', {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify({})
            });
            return;
        }
        
        // Verificar se sabotage está ativo
        const sabotageContainer = document.getElementById('sabotageContainer');
        if (sabotageContainer && !sabotageContainer.classList.contains('hidden')) {
            console.log('ESC pressed - closing sabotage minigame');
            fetch('https://dodi_bankrobbery/closeSabotage', {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify({})
            });
            return;
        }
    }
    
    if (!isDialShowing || !dialModel) return;
    

    // Removido E para evitar conflito com o minigame
});

// Função de debug para testar orientações
window.testDialOrientation = function(x, y, z) {
    if (dialModel) {
        dialModel.rotation.x = x || 0;
        dialModel.rotation.y = y || 0;
        dialModel.rotation.z = z || 0;
        console.log(`Applied rotation: X=${x}, Y=${y}, Z=${z}`);
    }
};

// Função para testar diferentes câmeras
window.testCameraPosition = function(x, y, z) {
    if (camera) {
        camera.position.set(x || 0, y || 0, z || 5);
        camera.lookAt(0, 0, 0);
        console.log(`Camera position: X=${x}, Y=${y}, Z=${z}`);
    }
};

// =====================================================
// SISTEMA DE ÁUDIO DOS GERADORES
// =====================================================

class GeneratorAudioSystem {
    constructor() {
        this.audio = document.getElementById('generator-audio');
        this.isPlaying = false;
        this.currentVolume = 0;
        this.targetVolume = 0;
        this.fadeSpeed = 0.015; // Fade mais rápido para reduzir processamento
        this.maxDistance = 50.0;
        this.minDistance = 5.0;
        this.lastUpdateTime = 0;
        this.updateThreshold = 100; // Aumentado para 100ms - menos atualizações
        this.lastDistance = 0;
        this.distanceThreshold = 1.0; // Aumentado - só atualiza com mudanças significativas
        this.isBroken = false;
        this.brokenVolumeMultiplier = 0.3;
        
        // Performance optimization flags
        this.isInitialized = false;
        this.fadeLoopRunning = false;
        this.audioContext = null;
        this.gainNode = null;
        this.audioBuffer = null;
        this.audioSource = null;
        
        // Debounce para evitar múltiplas inicializações
        this.initTimeout = null;
        
        this.initializeAudio();
    }
    
    initializeAudio() {
        // Debounce initialization
        if (this.initTimeout) {
            clearTimeout(this.initTimeout);
        }
        
        this.initTimeout = setTimeout(() => {
            if (this.audio && !this.isInitialized) {
                this.audio.volume = 0;
                this.audio.loop = true;
                this.audio.preload = 'auto';
                this.isInitialized = true;
                console.log('🔊 Sistema de áudio dos geradores inicializado');
                
                // Start fade loop only once
                if (!this.fadeLoopRunning) {
                    this.startFadeLoop();
                }
            } else if (!this.audio) {
                console.error('❌ Elemento de áudio não encontrado');
            }
        }, 100);
    }
    
    // Atualizar volume baseado na distância (OTIMIZADO)
    updateVolume(distance, minDistance = null, maxDistance = null) {
        if (!this.isInitialized || !this.audio) return;
        
        // Debounce mais agressivo
        const now = Date.now();
        if (now - this.lastUpdateTime < this.updateThreshold) {
            return;
        }
        
        // Só atualiza se mudança significativa (mas sempre permite se não está tocando)
        const distanceDiff = Math.abs(distance - this.lastDistance);
        if (distanceDiff < this.distanceThreshold && this.isPlaying && this.targetVolume > 0) {
            return;
        }
        
        this.lastUpdateTime = now;
        this.lastDistance = distance;
        
        // Usar configurações passadas ou padrões
        const actualMinDistance = minDistance || this.minDistance;
        const actualMaxDistance = maxDistance || this.maxDistance;
        
        let newTargetVolume = 0;
        
        // Cálculo otimizado de volume
        if (distance <= actualMaxDistance) {
            if (distance <= actualMinDistance) {
                newTargetVolume = 1.0;
            } else {
                // Fade linear otimizado
                newTargetVolume = Math.max(0, (actualMaxDistance - distance) / (actualMaxDistance - actualMinDistance));
            }
        }
        
        // Aplicar multiplicador se quebrado
        if (this.isBroken) {
            newTargetVolume *= this.brokenVolumeMultiplier;
        }
        
        // Atualizar volume sempre, mas com lógica melhorada
        const volumeChange = Math.abs(newTargetVolume - this.targetVolume);
        
        // Sempre atualizar se não está tocando e deveria tocar
        if (newTargetVolume > 0.05 && !this.isPlaying) {
            this.targetVolume = newTargetVolume;
            this.startAudio();
        }
        // Parar se volume muito baixo
        else if (newTargetVolume < 0.02 && this.isPlaying) {
            this.targetVolume = 0;
            this.stopAudio();
        }
        // Atualizar volume se mudança significativa
        else if (volumeChange > 0.03 || !this.isPlaying) {
            this.targetVolume = newTargetVolume;
        }
    }
    
    // Iniciar áudio (OTIMIZADO)
    startAudio() {
        if (!this.isInitialized || !this.audio || this.isPlaying) return;
        
        // Reset volume
        this.audio.volume = 0;
        this.currentVolume = 0;
        
        // Tentar iniciar áudio com timeout
        const playPromise = this.audio.play();
        if (playPromise !== undefined) {
            playPromise.then(() => {
                this.isPlaying = true;
            }).catch(error => {
                console.warn('⚠️ Áudio falhou ao iniciar:', error.message);
                this.isPlaying = false;
            });
        }
    }
    
    // Parar áudio (OTIMIZADO)
    stopAudio() {
        if (!this.audio || !this.isPlaying) return;
        
        // Fade out rápido e parar
        this.targetVolume = 0;
        
        // Parar após fade rápido
        setTimeout(() => {
            if (this.audio && this.isPlaying) {
                this.audio.pause();
                this.isPlaying = false;
                this.currentVolume = 0;
                this.audio.volume = 0;
            }
        }, 200); // Fade out mais rápido
    }
    
    // Loop de fade OTIMIZADO
    startFadeLoop() {
        if (this.fadeLoopRunning) return;
        this.fadeLoopRunning = true;
        
        const fadeLoop = () => {
            if (!this.fadeLoopRunning) return;
            
            if (this.audio && this.isPlaying && this.isInitialized) {
                const volumeDiff = this.targetVolume - this.currentVolume;
                
                // Só atualiza se diferença significativa
                if (Math.abs(volumeDiff) > 0.01) {
                    // Fade mais rápido para reduzir processamento
                    this.currentVolume += volumeDiff * this.fadeSpeed;
                    this.currentVolume = Math.max(0, Math.min(1, this.currentVolume));
                    
                    // Aplicar volume (sem arredondamento desnecessário)
                    this.audio.volume = this.currentVolume;
                }
            }
            
            // Usar setTimeout em vez de requestAnimationFrame para controle de frequência
            setTimeout(fadeLoop, 50); // 20 FPS em vez de 60 FPS
        };
        
        fadeLoop();
    }
    
    // Parada imediata OTIMIZADA
    forceStop() {
        if (!this.audio) return;
        
        this.fadeLoopRunning = false; // Parar fade loop
        this.audio.pause();
        this.isPlaying = false;
        this.currentVolume = 0;
        this.targetVolume = 0;
        this.audio.volume = 0;
    }
    
    // Definir estado quebrado (OTIMIZADO)
    setBrokenState(broken) {
        if (this.isBroken === broken) return; // Evitar processamento desnecessário
        
        this.isBroken = broken;
        
        // Só recalcular se estiver tocando e mudança significativa
        if (this.isPlaying && this.targetVolume > 0.05) {
            if (broken) {
                this.targetVolume *= this.brokenVolumeMultiplier;
            } else {
                this.targetVolume = Math.min(1.0, this.targetVolume / this.brokenVolumeMultiplier);
            }
        }
    }
    
    // Limpeza OTIMIZADA
    cleanup() {
        this.forceStop();
        this.isBroken = false;
        this.isInitialized = false;
        
        // Limpar timeouts
        if (this.initTimeout) {
            clearTimeout(this.initTimeout);
            this.initTimeout = null;
        }
    }
}

// Instância global do sistema de áudio
const generatorAudio = new GeneratorAudioSystem();

// Função para ser chamada pelo Lua
window.updateGeneratorAudio = function(distance) {
    generatorAudio.updateVolume(distance);
};

// Função para parar áudio (chamada pelo Lua)
window.stopGeneratorAudio = function() {
    generatorAudio.cleanup();
};

// Função para definir estado quebrado (chamada pelo Lua)
window.setGeneratorBroken = function(broken) {
    generatorAudio.setBrokenState(broken);
};

// Função para debug
window.testGeneratorAudio = function(distance) {
    console.log(`🔊 Testando áudio com distância: ${distance}m`);
    generatorAudio.updateVolume(distance);
};

// Função para debug do estado atual
window.debugGeneratorAudioState = function() {
    console.log('🔍 [AUDIO DEBUG] Estado atual:');
    console.log('  isPlaying:', generatorAudio.isPlaying);
    console.log('  currentVolume:', generatorAudio.currentVolume);
    console.log('  targetVolume:', generatorAudio.targetVolume);
    console.log('  isBroken:', generatorAudio.isBroken);
    console.log('  lastDistance:', generatorAudio.lastDistance);
    console.log('  audio.volume:', generatorAudio.audio ? generatorAudio.audio.volume : 'N/A');
    console.log('  audio.paused:', generatorAudio.audio ? generatorAudio.audio.paused : 'N/A');
};

// =====================================================
// SISTEMA DE MENSAGENS NUI PARA ÁUDIO
// =====================================================

// Event listener removido - consolidado no listener principal

console.log('Dial 3D Minigame System loaded');
console.log('Generator Audio System loaded');
console.log('NUI Message System loaded');
console.log('Debug: Use testGeneratorAudio(distance) to test audio system');
console.log('Debug: Use testDialOrientation(x,y,z) and testCameraPosition(x,y,z) in console to test orientations');


let gameConfig = null;
let currentGeneratorId = null; // ID do gerador atual sendo sabotado

// Event listener removido - consolidado no listener principal

// Sistema de áudio modular
function playSound(soundName, duration = null) {
    if (!gameConfig || !gameConfig.sounds || !gameConfig.sounds.enabled) return;
    
    const soundConfig = gameConfig.sounds.effects[soundName];
    if (!soundConfig) {
        console.warn(`Som não encontrado: ${soundName}`);
        return;
    }
    
    const audio = new Audio(`sounds/${soundConfig.file}`);
    audio.volume = (soundConfig.volume || 0.7) * (gameConfig.sounds.volume || 1.0);
    
    audio.play().catch(error => {
        console.warn(`Erro ao tocar som ${soundName}:`, error);
    });
    
    // Usa duration do parâmetro ou do config, se disponível
    const audioDuration = duration || soundConfig.duration;
    if (audioDuration) {
        setTimeout(() => {
            audio.pause();
            audio.currentTime = 0;
        }, audioDuration);
    }
    
    return audio;
}

// Check if image loads properly
document.addEventListener('DOMContentLoaded', function() {
    const img = document.getElementById('wireBoxImage');
    console.log('Image element found:', img);
    console.log('Image src:', img.src);
    console.log('Full image path:', window.location.href + img.src);
    
    img.onload = function() {
        console.log('Image loaded successfully');
        console.log('Image dimensions:', img.naturalWidth, 'x', img.naturalHeight);
    };
    img.onerror = function() {
        console.error('Failed to load image:', img.src);
        console.error('Trying to load from:', img.src);
    };
    
    // Force reload the image
    setTimeout(() => {
        img.src = img.src + '?t=' + Date.now();
    }, 100);
});

function closeSabotage() {
    playSound('uiClose');
    
    // Adiciona classes de fechamento
    const container = document.getElementById('sabotageContainer');
    const sabotageUI = document.querySelector('.sabotage-ui');
    
    container.classList.add('closing');
    sabotageUI.classList.add('closing');
    
    // Esconde após a animação terminar
    setTimeout(() => {
        container.classList.add('hidden');
        container.classList.remove('closing');
        sabotageUI.classList.remove('closing');
    }, 500);
    
    fetch(`https://dodi_bankrobbery/closeSabotage`, {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify({})
    });
}

document.addEventListener('keydown', function(event) {
    if (event.key === 'Escape') {
        closeSabotage();
    }
});

// Interação com elementos
document.addEventListener('DOMContentLoaded', function() {
    const lever = document.getElementById('lever');
    
    if (lever) {
        lever.addEventListener('click', function() {
            tryMoveLever();
        });
    }
    
    // Adiciona listeners aos fios
    for (let i = 1; i <= 3; i++) {
        const wire = document.getElementById(`wire${i}`);
        if (wire) {
            wire.addEventListener('click', function() {
                startWireCutMinigame(i);
            });
            wire.style.cursor = 'pointer';
        }
    }
});

function tryMoveLever() {
    const lever = document.getElementById('lever');
    
    // Toca o som da alavanca travada
    playSound('leverClank');
    
    // Adiciona classe de movimento travado
    lever.classList.add('lever-stuck');
    
    // Remove a classe após a animação
    setTimeout(() => {
        lever.classList.remove('lever-stuck');
    }, 300);
    
    console.log('Alavanca está travada - precisa resolver os fusíveis primeiro');
}

// Sistema de minigame para cortar fios
let currentWire = null;
let minigameActive = false;
let progressTimer = null;
let cutWires = [];

function startWireCutMinigame(wireNumber) {
    if (cutWires.includes(wireNumber)) {
        console.log(`Fio ${wireNumber} já foi cortado`);
        return;
    }
    
    if (minigameActive) return;
    
    currentWire = wireNumber;
    minigameActive = true;
    
    // Mostra o minigame
    document.getElementById('wireMinigame').classList.remove('hidden');
    
    // Configura a zona de acerto baseada no config
    const config = gameConfig.wireCutting;
    const hitZone = document.getElementById('hitZone');
    hitZone.style.left = (config.hitZonePosition - config.hitZoneSize/2) + '%';
    hitZone.style.width = config.hitZoneSize + '%';
    
    // Inicia a animação da barra
    startProgressBar();
    
    // Adiciona listener para tecla E
    document.addEventListener('keydown', handleMinigameKeypress);
}

function startProgressBar() {
    const indicator = document.getElementById('progressIndicator');
    const config = gameConfig.wireCutting;
    
    indicator.style.left = '0%';
    indicator.style.transition = `left ${config.barSpeed}ms linear`;
    
    // Força reflow antes de iniciar animação
    indicator.offsetHeight;
    
    // Inicia movimento
    indicator.style.left = '100%';
    
    // Timer para resetar se não clicou
    progressTimer = setTimeout(() => {
        failMinigame();
    }, config.barSpeed);
}

function handleMinigameKeypress(event) {
    if (!minigameActive) return;
    
    // Só responde à tecla E
    if (event.key.toLowerCase() !== 'e') return;
    
    event.preventDefault();
    event.stopPropagation();
    
    const indicator = document.getElementById('progressIndicator');
    const hitZone = document.getElementById('hitZone');
    
    // Calcula posição atual da barra
    const indicatorRect = indicator.getBoundingClientRect();
    const progressBar = document.querySelector('.wire-progress-bar');
    const barRect = progressBar.getBoundingClientRect();
    
    const indicatorPos = ((indicatorRect.left - barRect.left) / barRect.width) * 100;
    const hitZoneStart = parseFloat(hitZone.style.left);
    const hitZoneEnd = hitZoneStart + parseFloat(hitZone.style.width);
    
    // Verifica se acertou
    if (indicatorPos >= hitZoneStart && indicatorPos <= hitZoneEnd) {
        successMinigame();
    } else {
        failMinigame();
    }
}

function successMinigame() {
    if (!minigameActive) return;
    
    minigameActive = false;
    clearTimeout(progressTimer);
    document.removeEventListener('keydown', handleMinigameKeypress);
    
    // Toca som de sucesso
    playSound('wireCut');
    
    // Marca fio como cortado
    cutWires.push(currentWire);
    
    // Animação bonita do fio sendo cortado
    animateWireCut(currentWire);
    
    // Fecha minigame
    document.getElementById('wireMinigame').classList.add('hidden');
    
    console.log(`Fio ${currentWire} cortado com sucesso!`);
    
    // Verifica se todos os fios foram cortados
    if (cutWires.length === 3) {
        console.log('Todos os fios cortados! Iniciando sequência final.');
        setTimeout(() => {
            triggerFuseSparkEffect();
        }, 800);
    }
}

function failMinigame() {
    if (!minigameActive) return;
    
    minigameActive = false;
    clearTimeout(progressTimer);
    document.removeEventListener('keydown', handleMinigameKeypress);
    
    // Toca som de choque
    playSound('electricShock');
    
    // Notifica o Lua sobre o choque elétrico
    fetch(`https://dodi_bankrobbery/electricShock`, {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json; charset=UTF-8',
        },
        body: JSON.stringify({
            type: 'electricShock',
            generatorId: currentGeneratorId || 'unknown'
        })
    });
    
    // Fecha minigame
    document.getElementById('wireMinigame').classList.add('hidden');
    
    // Fecha UI após delay
    setTimeout(() => {
        closeSabotage();
    }, gameConfig.wireCutting.shockCloseDelay);
    
    console.log('Choque elétrico! Falhou no corte do fio.');
}

// Animação bonita para fio cortado
function animateWireCut(wireNumber) {
    const wire = document.getElementById(`wire${wireNumber}`);
    
    // Flash inicial
    wire.classList.add('wire-flash');
    
    // Cria efeito de faísca no ponto de corte
    createCutEffect(wire);
    
    // Após o flash, cria o efeito de corte
    setTimeout(() => {
        createWireCutEffect(wire, wireNumber);
    }, 200);
    
    // Desabilita cliques no fio
    wire.style.pointerEvents = 'none';
}

function createCutEffect(wireElement) {
    const container = document.querySelector('.fuses-container');
    const containerRect = container.getBoundingClientRect();
    
    // Pega o SVG do fio para calcular posição correta
    const wireRect = wireElement.getBoundingClientRect();
    
    // Calcula posição no meio do fio relativa ao container, um pouco à esquerda
    const cutX = wireRect.left - containerRect.left + 15; // Mais à esquerda
    const cutY = wireRect.top - containerRect.top + 150; // Meio vertical do fio
    
    // Cria 4 partículas menores e mais realistas
    for (let i = 0; i < 4; i++) {
        setTimeout(() => {
            const particle = document.createElement('div');
            particle.className = 'cut-effect';
            
            // Posição aleatória mais próxima do ponto de corte
            const offsetX = (Math.random() - 0.5) * 15;
            const offsetY = (Math.random() - 0.5) * 15;
            
            particle.style.left = (cutX + offsetX) + 'px';
            particle.style.top = (cutY + offsetY) + 'px';
            
            container.appendChild(particle);
            
            // Remove partícula após animação
            setTimeout(() => {
                if (particle.parentNode) {
                    particle.parentNode.removeChild(particle);
                }
            }, 600);
        }, i * 50);
    }
}

function createWireCutEffect(wireElement, wireNumber) {
    const container = document.querySelector('.fuses-container');
    
    // Esconde o fio original
    wireElement.style.opacity = '0';
    
    // Cria duas partes do fio cortado
    const topPart = wireElement.cloneNode(true);
    const bottomPart = wireElement.cloneNode(true);
    
    // Remove IDs para evitar duplicatas
    topPart.id = `wire${wireNumber}-top`;
    bottomPart.id = `wire${wireNumber}-bottom`;
    
    // Aplica a mesma posição CSS que está definida no styles.css
    if (wireNumber === 1) {
        topPart.style.top = '60px';
        topPart.style.left = '360px';
        bottomPart.style.top = '60px';
        bottomPart.style.left = '360px';
    } else if (wireNumber === 2) {
        topPart.style.top = '60px';
        topPart.style.left = '450px';
        bottomPart.style.top = '60px';
        bottomPart.style.left = '450px';
    } else if (wireNumber === 3) {
        topPart.style.top = '60px';
        topPart.style.left = '530px';
        bottomPart.style.top = '60px';
        bottomPart.style.left = '530px';
    }
    
    // Configura as partes
    topPart.style.opacity = '1';
    bottomPart.style.opacity = '1';
    topPart.style.clipPath = 'polygon(0 0, 100% 0, 100% 45%, 0 45%)';
    bottomPart.style.clipPath = 'polygon(0 55%, 100% 55%, 100% 100%, 0 100%)';
    
    // Remove classes antigas
    topPart.classList.remove('wire-flash');
    bottomPart.classList.remove('wire-flash');
    
    // Adiciona animação de separação
    topPart.classList.add('wire-cut-top');
    bottomPart.classList.add('wire-cut-bottom');
    
    // Adiciona ao container
    container.appendChild(topPart);
    container.appendChild(bottomPart);
}

// Efeito de faísca nos fusíveis quando todos os fios são cortados
function triggerFuseSparkEffect() {
    const container = document.querySelector('.fuses-container');
    
    // Toca som das faíscas (duração configurada no config)
    playSound('fusesSpark');
    
    // Cria faíscas para cada fusível com delay
    for (let fuseNumber = 1; fuseNumber <= 3; fuseNumber++) {
        setTimeout(() => {
            createFuseSparks(fuseNumber);
        }, (fuseNumber - 1) * 300);
    }
    
    // Fecha a UI após todas as faíscas
    setTimeout(() => {
        // Notifica o Lua sobre o sucesso da sabotagem antes de fechar
        fetch(`https://dodi_bankrobbery/sabotageSuccess`, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json; charset=UTF-8',
            },
            body: JSON.stringify({
                generatorId: currentGeneratorId || 'unknown'
            })
        });
        
        closeSabotage();
    }, 2500);
}

function createFuseSparks(fuseNumber) {
    const container = document.querySelector('.fuses-container');
    const fuse = document.getElementById(`fuse${fuseNumber}`);
    
    if (!fuse) return;
    
    // Pega posição do fusível
    const fuseRect = fuse.getBoundingClientRect();
    const containerRect = container.getBoundingClientRect();
    
    // Calcula posição do topo do fusível (onde as faíscas saem)
    const fuseX = fuseRect.left - containerRect.left + 75; // Centro horizontal
    const fuseY = fuseRect.top - containerRect.top + 20;   // Topo do fusível
    
    // Cria várias faíscas realistas em rajadas
    for (let burst = 0; burst < 3; burst++) {
        setTimeout(() => {
            // Cada rajada tem 5-8 faíscas
            const sparksInBurst = 5 + Math.floor(Math.random() * 4);
            
            for (let i = 0; i < sparksInBurst; i++) {
                setTimeout(() => {
                    const spark = document.createElement('div');
                    
                    // Tipos aleatórios de faísca
                    const sparkTypes = ['fuse-spark', 'fuse-spark small', 'fuse-spark large'];
                    spark.className = sparkTypes[Math.floor(Math.random() * sparkTypes.length)];
                    
                    // Ângulo mais realista - faíscas voam para cima e lados
                    const angle = -90 + (Math.random() - 0.5) * 120; // -150° a -30°
                    const distance = 15 + Math.random() * 25;
                    const offsetX = Math.cos(angle * Math.PI / 180) * distance;
                    const offsetY = Math.sin(angle * Math.PI / 180) * distance;
                    
                    // Adiciona rotação aleatória para parecer mais natural
                    spark.style.transform = `rotate(${Math.random() * 360}deg)`;
                    spark.style.left = (fuseX + offsetX) + 'px';
                    spark.style.top = (fuseY + offsetY) + 'px';
                    
                    // Adiciona movimento lateral aleatório
                    const lateralDrift = (Math.random() - 0.5) * 20;
                    spark.style.setProperty('--lateral-drift', lateralDrift + 'px');
                    
                    container.appendChild(spark);
                    
                    // Remove faísca após animação
                    setTimeout(() => {
                        if (spark.parentNode) {
                            spark.parentNode.removeChild(spark);
                        }
                    }, 1000);
                }, i * (20 + Math.random() * 40)); // Delay aleatório entre faíscas
            }
        }, burst * 200); // Delay entre rajadas
    }
}



///////// TORCH MINIGAME /////////

let torchGameConfig = null;

// Torch Audio System
class TorchAudioManager {
    constructor() {
        this.igniteAudio = null;
        this.fireAudio = null;
        this.cuttingAudio = null;
        this.isFirePlaying = false;
        this.isCuttingPlaying = false;
        this.fireStartTimeout = null; // Para cancelar o timeout do fire
        this.audioConfig = {
            igniteVolume: 0.7,
            fireVolume: 0.5,
            cuttingVolume: 0.8,
            fadeTime: 500
        };
        this.initializeAudio();
    }

    initializeAudio() {
        // Initialize ignite sound (plays once when starting)
        this.igniteAudio = new Audio('sounds/ignite_fire.mp3');
        this.igniteAudio.volume = this.audioConfig.igniteVolume;
        this.igniteAudio.preload = 'auto';

        // Initialize fire loop sound (continuous background)
        this.fireAudio = new Audio('sounds/fire.mp3');
        this.fireAudio.volume = this.audioConfig.fireVolume;
        this.fireAudio.loop = true;
        this.fireAudio.preload = 'auto';

        // Initialize cutting sound (when actively cutting)
        this.cuttingAudio = new Audio('sounds/cutting.mp3');
        this.cuttingAudio.volume = this.audioConfig.cuttingVolume;
        this.cuttingAudio.loop = true;
        this.cuttingAudio.preload = 'auto';

        // Apply config settings if available
        this.applyAudioConfig();
    }

    applyAudioConfig() {
        if (torchGameConfig?.torchAudio) {
            const config = torchGameConfig.torchAudio;
            this.audioConfig = { ...this.audioConfig, ...config };
            
            if (this.igniteAudio) this.igniteAudio.volume = this.audioConfig.igniteVolume;
            if (this.fireAudio) this.fireAudio.volume = this.audioConfig.fireVolume;
            if (this.cuttingAudio) this.cuttingAudio.volume = this.audioConfig.cuttingVolume;
        }
    }

    isAudioEnabled() {
        return this.audioConfig.enabled !== false;
    }

    playIgnite() {
        if (!this.isAudioEnabled()) return;
        
        console.log('Playing torch ignite sound');
        if (this.igniteAudio) {
            this.igniteAudio.currentTime = 0;
            this.igniteAudio.play().catch(e => console.log('Ignite audio play failed:', e));
            
            // Start fire loop after ignite finishes
            this.fireStartTimeout = setTimeout(() => {
                this.startFireLoop();
            }, this.igniteAudio.duration * 1000 || 2000);
        }
    }

    startFireLoop() {
        if (!this.isAudioEnabled()) return;
        
        console.log('Starting fire loop sound');
        if (this.fireAudio && !this.isFirePlaying) {
            this.isFirePlaying = true;
            this.fireAudio.currentTime = 0;
            this.fireAudio.play().catch(e => console.log('Fire audio play failed:', e));
        }
    }

    stopFireLoop() {
        console.log('Stopping fire loop sound - isFirePlaying:', this.isFirePlaying);
        if (this.fireAudio && this.isFirePlaying) {
            this.isFirePlaying = false;
            console.log('Setting isFirePlaying to false and fading out');
            this.fadeOut(this.fireAudio, this.audioConfig.fadeTime);
        } else {
            console.log('Fire not playing or audio not found');
        }
    }

    startCutting() {
        if (!this.isAudioEnabled()) return;
        
        console.log('Starting cutting sound');
        if (this.cuttingAudio && !this.isCuttingPlaying) {
            this.isCuttingPlaying = true;
            this.cuttingAudio.currentTime = 0;
            this.cuttingAudio.play().catch(e => console.log('Cutting audio play failed:', e));
        }
    }

    stopCutting() {
        console.log('Stopping cutting sound');
        if (this.cuttingAudio && this.isCuttingPlaying) {
            this.isCuttingPlaying = false;
            this.fadeOut(this.cuttingAudio, this.audioConfig.fadeTime);
        }
    }

    fadeOut(audio, duration) {
        const originalVolume = audio.volume;
        const fadeStep = originalVolume / (duration / 50);
        
        console.log('Starting fadeOut - originalVolume:', originalVolume);
        
        const fadeInterval = setInterval(() => {
            if (audio.volume > fadeStep) {
                audio.volume -= fadeStep;
            } else {
                console.log('FadeOut complete - pausing and resetting audio');
                audio.volume = 0;
                audio.pause();
                audio.currentTime = 0; // Reset position
                audio.volume = originalVolume; // Reset volume for next play
                clearInterval(fadeInterval);
            }
        }, 50);
    }

    stopAllSounds() {
        console.log('Stopping all torch sounds IMMEDIATELY');
        
        // Cancelar timeout que inicia o fire loop
        if (this.fireStartTimeout) {
            clearTimeout(this.fireStartTimeout);
            this.fireStartTimeout = null;
            console.log('Cancelled fire start timeout');
        }
        
        // Parar fire audio IMEDIATAMENTE sem fade
        if (this.fireAudio) {
            this.isFirePlaying = false;
            this.fireAudio.pause();
            this.fireAudio.currentTime = 0;
            this.fireAudio.volume = this.audioConfig.fireVolume; // Reset volume
            console.log('Fire audio stopped immediately');
        }
        
        // Parar cutting audio IMEDIATAMENTE sem fade
        if (this.cuttingAudio) {
            this.isCuttingPlaying = false;
            this.cuttingAudio.pause();
            this.cuttingAudio.currentTime = 0;
            this.cuttingAudio.volume = this.audioConfig.cuttingVolume; // Reset volume
            console.log('Cutting audio stopped immediately');
        }
        
        if (this.igniteAudio) {
            this.igniteAudio.pause();
            this.igniteAudio.currentTime = 0;
            console.log('Ignite audio stopped immediately');
        }
    }
}

// Global torch audio manager
let torchAudio = null;

// Robbery Progress System (Independent)
class RobberyProgress {
    constructor() {
        this.container = document.getElementById('robberyContainer');
        this.progressFill = document.getElementById('robberyProgressFill');
        this.percentageText = document.getElementById('robberyPercentage');
        this.titleText = document.getElementById('robberyTitle');
        this.subtitleText = document.getElementById('robberySubtitle');
        this.iconImg = document.getElementById('robberyIcon');
        
        this.isActive = false;
        this.progress = 0;
        this.duration = 5000; // Default 5 seconds
        this.startTime = 0;
        this.animationFrame = null;
        
        this.setupEventListeners();
    }
    
    setupEventListeners() {
        document.addEventListener('keydown', (event) => {
            if (event.key === 'Escape' && this.isActive) {
                this.cancel();
            }
        });
    }
    
    start(config = {}) {
        if (this.isActive) return;
        
        this.isActive = true;
        this.progress = 0;
        this.duration = config.duration || 5000;
        this.startTime = Date.now();
        
        // Apply config
        if (config.title) this.titleText.textContent = config.title;
        if (config.subtitle) this.subtitleText.textContent = config.subtitle;
        if (config.icon) this.iconImg.src = config.icon;
        
        // Show container
        this.container.classList.add('active');
        
        // Start progress animation
        this.animate();
        
        console.log('Robbery progress started');
    }
    
    animate() {
        if (!this.isActive) return;
        
        const elapsed = Date.now() - this.startTime;
        this.progress = Math.min((elapsed / this.duration) * 100, 100);
        
        // Update UI
        this.progressFill.style.width = this.progress + '%';
        this.percentageText.textContent = Math.floor(this.progress) + '%';
        
        if (this.progress >= 100) {
            this.complete();
        } else {
            this.animationFrame = requestAnimationFrame(() => this.animate());
        }
    }
    
    complete() {
        console.log('Robbery completed successfully');
        this.isActive = false;
        
        // Send completion callback
        fetch(`https://dodi_bankrobbery/robberyCompleted`, {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({ success: true, progress: 100 })
        }).catch(e => console.log('Robbery completion callback failed:', e));
        
        // Hide after short delay
        setTimeout(() => {
            this.container.classList.remove('active');
        }, 1000);
    }
    
    cancel() {
        console.log('Robbery cancelled');
        this.isActive = false;
        
        if (this.animationFrame) {
            cancelAnimationFrame(this.animationFrame);
        }
        
        // Send cancellation callback
        fetch(`https://dodi_bankrobbery/robberyCancelled`, {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({ success: false, progress: this.progress })
        }).catch(e => console.log('Robbery cancellation callback failed:', e));
        
        this.container.classList.remove('active');
    }
    
    stop() {
        this.cancel();
    }
}

// Global robbery progress instance
let robberyProgress = null;

// Event listener removido - consolidado no listener principal

function openTorchMinigame() {
    const container = document.getElementById('minigameContainer');
    // Resetar estilos inline e classes residuais antes de abrir
    if (container) {
        container.style.display = '';
        container.style.zIndex = '';
        container.classList.remove('closing');
        container.classList.add('active');
    }
    // Garantir que o body esteja visível
    document.body.style.display = 'block';
    
    // Initialize torch audio system
    if (!torchAudio) {
        torchAudio = new TorchAudioManager();
    }
    
    // Play ignite sound when opening UI
    torchAudio.playIgnite();
    
    // Apply config settings when opening
    if (torchGameConfig) {
        applyConfigSettings();
    }
    
    // Initialize cutting game
    setTimeout(() => {
        initializeCuttingGame();
    }, 500);
}

function closeTorchMinigame() {
    const container = document.getElementById('minigameContainer');
    console.log('Closing torch minigame - container found:', container);
    
    // Stop all torch sounds when closing
    if (torchAudio) {
        torchAudio.stopAllSounds();
    }
    
    if (container) {
        console.log('Torch container classes before close:', container.classList.toString());
        
        // Add closing animation class
        container.classList.add('closing');
        container.classList.remove('active');
        
        // Force hide immediately to prevent interference
        container.style.display = 'none';
        container.style.zIndex = '-1';
        
        console.log('Torch container hidden and z-index set to -1');
        
        // Wait for animation to complete before hiding
        setTimeout(() => {
            container.classList.remove('closing');
            // Não esconder o body para não afetar outros UIs
            // document.body.style.display = 'none';
        }, 500); // Match the CSS transition duration
    }
    
    // Send callback to client
    fetch(`https://dodi_bankrobbery/closeMinigame`, {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify({})
    });
}

// Close with ESC key (removido - conflita com ESC principal)
// document.addEventListener('keydown', function(event) {
//     if (event.key === 'Escape') {
//         closeTorchMinigame();
//     }
// });

// Helper function to get resource name
function GetParentResourceName() {
    return window.location.hostname === '' ? 'dodi_bankrobbery' : window.location.hostname;
}

// Preload progress icon to prevent delay
function preloadProgressIcon(iconPath) {
    const img = new Image();
    img.src = iconPath;
    return img;
}

// Apply config settings from Lua
function applyConfigSettings() {
    // Show loading IMMEDIATELY before anything else
    showPhaseTransition();
    
    // Hide ALL elements IMMEDIATELY to prevent visual glitches
    const backgroundDiv = document.querySelector('.background-image');
    const hingeElement = document.getElementById('doorHinge');
    const cuttingLine = document.querySelector('.cutting-line');
    const cuttingCanvas = document.getElementById('cuttingCanvas');
    
    if (backgroundDiv) backgroundDiv.style.opacity = '0';
    if (hingeElement) hingeElement.style.opacity = '0';
    if (cuttingLine) cuttingLine.style.opacity = '0';
    if (cuttingCanvas) cuttingCanvas.style.opacity = '0';
    
    // Apply door type specific CSS classes for image sizing
    if (torchGameConfig?.doorType) {
        // Apply background image class
        if (backgroundDiv) {
            backgroundDiv.classList.remove('vault-door', 'regular-door');
            if (torchGameConfig.doorType === 'vault') {
                backgroundDiv.classList.add('vault-door');
            } else {
                backgroundDiv.classList.add('regular-door');
            }
        }
        
        // Apply hinge class
        if (hingeElement) {
            hingeElement.classList.remove('vault-hinge', 'regular-hinge');
            if (torchGameConfig.doorType === 'vault') {
                hingeElement.classList.add('vault-hinge');
            } else {
                hingeElement.classList.add('regular-hinge');
            }
        }
    }
    
    if (!torchGameConfig || !torchGameConfig.phases) {
        hidePhaseTransition();
        return;
    }
    
    // Get current phase data
    const currentPhase = torchGameConfig.phases[torchGameConfig.currentPhase - 1];
    if (!currentPhase) {
        hidePhaseTransition();
        return;
    }
    
    // Apply background image from current phase with elegant transition
    if (backgroundDiv && currentPhase.backgroundImage) {
        console.log('Changing background to:', currentPhase.backgroundImage);
        
        // Get transition settings from config
        const transitionConfig = torchGameConfig?.phaseTransition || {};
        const transitionDuration = transitionConfig.transitionDuration || 400;
        const loadingDuration = transitionConfig.loadingDuration || 300;
        
        // Wait a bit then apply transitions and changes
        setTimeout(() => {
            // Apply smooth transitions (elements already hidden)
            backgroundDiv.style.transition = `opacity ${transitionDuration}ms ease-in-out, filter ${transitionDuration}ms ease-in-out`;
            backgroundDiv.style.filter = 'blur(5px)';
            
            // Apply transitions to other elements
            if (hingeElement) {
                hingeElement.style.transition = `opacity ${transitionDuration}ms ease-in-out`;
            }
            
            if (cuttingLine) {
                cuttingLine.style.transition = `opacity ${transitionDuration}ms ease-in-out`;
            }
            
            if (cuttingCanvas) {
                cuttingCanvas.style.transition = `opacity ${transitionDuration}ms ease-in-out`;
            }
            
            // Change everything while hidden
            setTimeout(() => {
                backgroundDiv.style.backgroundImage = `url('images/${currentPhase.backgroundImage}')`;
                
                // Apply new hinge position and image while hidden
                if (currentPhase.doorHinge && hingeElement) {
                    const hingeConfig = currentPhase.doorHinge;
                    hingeElement.style.transform = `translate(calc(-50% + ${hingeConfig.xPosition}px), calc(-50% + ${hingeConfig.yPosition}px))`;
                    // Size is now controlled by CSS classes, not config
                    
                    // Change hinge image based on door type
                    hingeElement.style.backgroundImage = `url('images/${hingeConfig.image}')`;
                }
                
                // Show everything again
                backgroundDiv.style.opacity = '1';
                backgroundDiv.style.filter = 'blur(0px)';
                if (hingeElement) {
                    hingeElement.style.opacity = '1';
                }
                
                // Show cutting line again
                const cuttingLine = document.querySelector('.cutting-line');
                if (cuttingLine) {
                    cuttingLine.style.opacity = '1';
                }
                
                // Show cutting canvas again
                const cuttingCanvas = document.getElementById('cuttingCanvas');
                if (cuttingCanvas) {
                    cuttingCanvas.style.opacity = '1';
                }
                
                // Hide loading after everything is ready
                setTimeout(() => {
                    hidePhaseTransition();
                }, 300);
            }, loadingDuration);
        }, 100); // Small delay to ensure loading shows first
    }
    
    // Hinge settings are now applied during the transition above to prevent visual glitches
    
    // Apply progress bar config from current phase
    if (currentPhase.cuttingGame) {
        const cutConfig = currentPhase.cuttingGame;
        
        // Update progress bar icon and text
        const progressIcon = document.getElementById('progressIcon');
        const progressTitle = document.querySelector('.progress-title');
        const progressSubtitle = document.querySelector('.progress-subtitle');
        
        if (progressIcon && torchGameConfig.globalCuttingSettings.progressIcon) {
            // Preload and set icon immediately
            preloadProgressIcon(torchGameConfig.globalCuttingSettings.progressIcon);
            progressIcon.src = torchGameConfig.globalCuttingSettings.progressIcon;
        }
        if (progressTitle && cutConfig.progressTitle) {
            progressTitle.textContent = cutConfig.progressTitle;
        }
        if (progressSubtitle && cutConfig.progressSubtitle) {
            progressSubtitle.textContent = cutConfig.progressSubtitle;
        }
    }
}

function showPhaseTransition() {
    // Get transition settings from config
    const transitionConfig = torchGameConfig?.phaseTransition || {};
    const loadingText = transitionConfig.loadingText || 'Carregando próxima fase...';
    const backgroundOpacity = transitionConfig.backgroundOpacity || 0.85;
    const transitionDuration = transitionConfig.transitionDuration || 400;
    
    // Create or show loading overlay
    let loadingOverlay = document.getElementById('phaseTransition');
    if (!loadingOverlay) {
        loadingOverlay = document.createElement('div');
        loadingOverlay.id = 'phaseTransition';
        loadingOverlay.innerHTML = `
            <div class="loading-content">
                <div class="loading-spinner"></div>
                <div class="loading-text">${loadingText}</div>
            </div>
        `;
        loadingOverlay.style.cssText = `
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0, 0, 0, ${backgroundOpacity});
            display: flex;
            align-items: center;
            justify-content: center;
            z-index: 1000;
            opacity: 0;
            transition: opacity ${transitionDuration}ms ease-in-out;
        `;
        
        // Style the loading content
        const style = document.createElement('style');
        style.textContent = `
            .loading-content {
                text-align: center;
                color: white;
                font-family: Arial, sans-serif;
            }
            .loading-spinner {
                width: 40px;
                height: 40px;
                border: 3px solid rgba(255, 255, 255, 0.3);
                border-top: 3px solid #fff;
                border-radius: 50%;
                animation: spin 1s linear infinite;
                margin: 0 auto 15px;
            }
            .loading-text {
                font-size: 16px;
                font-weight: 500;
            }
            @keyframes spin {
                0% { transform: rotate(0deg); }
                100% { transform: rotate(360deg); }
            }
        `;
        document.head.appendChild(style);
        document.body.appendChild(loadingOverlay);
    }
    
    loadingOverlay.style.display = 'flex';
    setTimeout(() => {
        loadingOverlay.style.opacity = '1';
    }, 10);
}

function hidePhaseTransition() {
    const loadingOverlay = document.getElementById('phaseTransition');
    if (loadingOverlay) {
        const transitionConfig = torchGameConfig?.phaseTransition || {};
        const transitionDuration = transitionConfig.transitionDuration || 400;
        
        loadingOverlay.style.opacity = '0';
        setTimeout(() => {
            loadingOverlay.style.display = 'none';
        }, transitionDuration);
    }
}

function loadNextPhase(phaseData) {
    console.log('Loading next phase:', phaseData);
    console.log('Current torchGameConfig:', torchGameConfig);
    
    // Stop all torch sounds and play ignite for new phase
    if (torchAudio) {
        torchAudio.stopAllSounds();
        torchAudio.playIgnite();
    }
    
    // Reset the cutting game for new phase
    if (window.cuttingGame) {
        window.cuttingGame.stopGame();
        window.cuttingGame.progress = 0;
        window.cuttingGame.weldSeam = [];
        window.cuttingGame.particles = [];
        window.cuttingGame.moltenDrops = [];
        window.cuttingGame.updateProgressDisplay();
    }
    
    // Apply new phase settings
    applyConfigSettings();
    
    // Reinitialize cutting game with new phase settings AFTER loading completes
    setTimeout(() => {
        initializeCuttingGame();
    }, 1000); // Wait for loading to complete
}

// Cutting Game Classes and Logic
class Particle {
    constructor(x, y, ctx) {
        this.x = x;
        this.y = y;
        this.ctx = ctx;

        let hue = 33;
        this.coordinates = [];
        this.coordinateCount = 5;
        while(this.coordinateCount--) {
            this.coordinates.push([this.x, this.y]);
        }
        this.angle = this.random(0, Math.PI * 2);
        this.speed = this.random(1, 10);
        this.friction = 0.93;
        this.gravity = 3;
        this.hue = this.random(hue - 15, hue + 15);
        this.brightness = this.random(50, 80);
        this.alpha = 1;
        this.lineW = this.random(1, 3);
        this.decay = this.random(0.01, 0.06);
    }

    random(min, max) {
        return Math.random() * (max - min) + min;
    }

    update() {
        this.coordinates.pop();
        this.coordinates.unshift([this.x, this.y]);
        this.speed *= this.friction;
        this.x += Math.cos(this.angle) * this.speed;
        this.y += Math.sin(this.angle) * this.speed + this.gravity;
        this.alpha -= this.decay;
        
        if(this.alpha <= this.decay) {
            return false;
        }
        return true;
    }

    draw() {
        this.ctx.beginPath();
        let len = this.coordinates.length - 1;
        this.ctx.moveTo(
            this.coordinates[len][0], 
            this.coordinates[len][1] 
        );
        this.ctx.lineTo(this.x, this.y);
        this.ctx.strokeStyle = 'hsla(' + this.hue + ', 100%, ' + this.brightness + '%, ' + this.alpha + ')';
        this.ctx.lineWidth = this.lineW;
        this.ctx.stroke();
    }
}

class Stitch {
    constructor(x, y, ctx, radius, prevX, prevY) {
        this.x = x;
        this.y = y;
        this.ctx = ctx;
        this.radius = radius || 8;
        this.dC = 0.05; // Ultra slow fade for maximum cutting trail visibility
        this.hue = 33;
        this.brightness = 100;
        this.saturation = 100;
        this.prevX = prevX || x;
        this.prevY = prevY || y;
        
        // Calculate cutting angle based on mouse movement
        this.calculateCuttingAngle();
    }
    
    calculateCuttingAngle() {
        const deltaX = this.x - this.prevX;
        const deltaY = this.y - this.prevY;
        
        // Calculate movement angle (in radians)
        this.movementAngle = Math.atan2(deltaY, deltaX);
        
        // Calculate cutting direction (same as movement direction)
        this.cuttingAngle = this.movementAngle;
        
        // Add human imperfection (subtle variation for smooth curves)
        this.cuttingAngle += (Math.random() - 0.5) * 0.2;
    }

    update() {
        if(this.hue > 0) {
            this.hue -= this.dC;
        }
        if(this.brightness > 60) {
            this.brightness -= this.dC;
        }
        if(this.saturation > 0) {
            this.saturation -= this.dC;
        }
    }

    draw() {
        // Draw outer glow (maçarico flame effect)
        let grt = this.ctx.createRadialGradient(this.x, this.y, 0, this.x, this.y, this.radius);
        grt.addColorStop(0.0, 'hsla(' + this.hue + ',' + this.saturation + '%, ' + this.brightness + '%, ' + 1 + ')');
        grt.addColorStop(0.6, 'hsla(' + this.hue + ',' + this.saturation + '%, ' + (this.brightness - 20) + '%, ' + 0.8 + ')');
        grt.addColorStop(1.0, 'hsla(' + this.hue + ',' + this.saturation + '%, ' + (this.brightness - 40) + '%, ' + 0.4 + ')');

        this.ctx.beginPath();
        this.ctx.fillStyle = grt;
        this.ctx.arc(this.x, this.y, this.radius, 0, 2 * Math.PI);
        this.ctx.fill();
        
        // Draw cutting kerf (the actual cut line) - irregular realistic shape
        const cutLength = this.radius * 2.5;
        const kerfWidth = Math.max(6, this.radius * 0.4);
        
        // Create irregular cut path following movement direction
        const cutPoints = [];
        const segments = 12;
        
        for (let i = 0; i <= segments; i++) {
            const t = i / segments;
            
            // Calculate cut line direction based on movement angle
            const lineProgress = (t - 0.5) * cutLength; // -cutLength/2 to +cutLength/2
            
            // Base position along cutting direction
            const baseX = this.x + Math.cos(this.cuttingAngle) * lineProgress;
            const baseY = this.y + Math.sin(this.cuttingAngle) * lineProgress;
            
            // Add subtle irregularity for smooth, natural curves
            const perpAngle = this.cuttingAngle + Math.PI/2;
            const irregularity = (Math.sin(t * Math.PI * 3) * 0.2 + Math.random() * 0.3 - 0.15) * kerfWidth * 0.15;
            
            const x = baseX + Math.cos(perpAngle) * irregularity;
            const y = baseY + Math.sin(perpAngle) * irregularity;
            
            cutPoints.push({x, y});
        }
        
        // Draw outer shadow of the cut (irregular)
        this.ctx.beginPath();
        this.ctx.strokeStyle = `rgba(0, 0, 0, 1.0)`;
        this.ctx.lineWidth = kerfWidth + 4;
        this.ctx.lineCap = 'round';
        this.ctx.lineJoin = 'round';
        
        cutPoints.forEach((point, i) => {
            if (i === 0) {
                this.ctx.moveTo(point.x, point.y);
            } else {
                this.ctx.lineTo(point.x, point.y);
            }
        });
        this.ctx.stroke();
        
        // Draw main cutting line with gradient effect (irregular)
        let kerfGrt = this.ctx.createLinearGradient(
            this.x - kerfWidth/2, this.y, 
            this.x + kerfWidth/2, this.y
        );
        kerfGrt.addColorStop(0.0, 'rgba(80, 40, 0, 0.9)'); // Dark brown edges
        kerfGrt.addColorStop(0.3, 'rgba(20, 10, 0, 1.0)'); // Darker
        kerfGrt.addColorStop(0.5, 'rgba(0, 0, 0, 1.0)'); // Pure black center
        kerfGrt.addColorStop(0.7, 'rgba(20, 10, 0, 1.0)'); // Darker
        kerfGrt.addColorStop(1.0, 'rgba(80, 40, 0, 0.9)'); // Dark brown edges
        
        this.ctx.beginPath();
        this.ctx.strokeStyle = kerfGrt;
        this.ctx.lineWidth = kerfWidth;
        this.ctx.lineCap = 'round';
        this.ctx.lineJoin = 'round';
        
        cutPoints.forEach((point, i) => {
            if (i === 0) {
                this.ctx.moveTo(point.x, point.y);
            } else {
                this.ctx.lineTo(point.x, point.y);
            }
        });
        this.ctx.stroke();
        
        // Add very thin dark center line (the actual cut gap) - irregular
        this.ctx.beginPath();
        this.ctx.strokeStyle = `rgba(0, 0, 0, 1.0)`;
        this.ctx.lineWidth = Math.max(1, kerfWidth * 0.1);
        this.ctx.lineCap = 'round';
        this.ctx.lineJoin = 'round';
        
        cutPoints.forEach((point, i) => {
            if (i === 0) {
                this.ctx.moveTo(point.x, point.y);
            } else {
                this.ctx.lineTo(point.x, point.y);
            }
        });
        this.ctx.stroke();
        
        // Light effect removed from stitches - will be added to mouse position only
        
        // Add inner hot core (bright center around the cut)
        let innerGrt = this.ctx.createRadialGradient(this.x, this.y, 0, this.x, this.y, this.radius * 0.4);
        innerGrt.addColorStop(0.0, 'hsla(55, 100%, 98%, 0.9)'); // Even brighter center
        innerGrt.addColorStop(1.0, 'hsla(' + this.hue + ', 100%, ' + this.brightness + '%, 0.6)');
        
        this.ctx.beginPath();
        this.ctx.fillStyle = innerGrt;
        this.ctx.arc(this.x, this.y, this.radius * 0.4, 0, 2 * Math.PI);
        this.ctx.fill();
        
        // Add sparks effect around the cut line
        if (Math.random() > 0.7) {
            for (let i = 0; i < 3; i++) {
                const sparkX = this.x + (Math.random() - 0.5) * this.radius * 0.5;
                const sparkY = this.y + (Math.random() - 0.5) * cutLength;
                
                this.ctx.beginPath();
                this.ctx.fillStyle = `hsla(45, 100%, 90%, ${Math.random() * 0.8})`;
                this.ctx.arc(sparkX, sparkY, Math.random() * 2 + 1, 0, 2 * Math.PI);
                this.ctx.fill();
            }
        }
    }
}

class MoltenDrop {
    constructor(x, y, ctx) {
        this.x = x;
        this.y = y;
        this.ctx = ctx;
        this.vx = (Math.random() - 0.5) * 3; // More horizontal variation
        this.vy = Math.random() * 1.5 + 0.5; // Initial downward velocity
        this.gravity = 0.25; // Stronger gravity for realism
        this.baseRadius = Math.random() * 3 + 2; // Base size
        this.radius = this.baseRadius;
        this.life = 120;
        this.maxLife = 120;
        this.hue = Math.random() * 40 + 5; // More color variation (red to orange)
        this.trail = []; // Trail of previous positions
        this.maxTrailLength = 12; // Longer trail
        this.deformation = 1; // Shape deformation factor
        this.temperature = 1000; // Starting temperature
        this.coolingRate = 4; // How fast it cools
        this.bounce = 0.3; // Bounce factor when hitting surfaces
        this.hasHitSurface = false;
        this.bubbles = []; // Array for bubbling effect
        this.bubbleTimer = 0; // Timer for bubble creation
    }

    update() {
        // Store previous position for trail
        this.trail.push({
            x: this.x, 
            y: this.y, 
            life: this.life, 
            radius: this.radius,
            temperature: this.temperature
        });
        if (this.trail.length > this.maxTrailLength) {
            this.trail.shift();
        }

        // Physics - more realistic
        this.vy += this.gravity;
        
        // Calculate deformation based on velocity (drops stretch when falling fast)
        const speed = Math.sqrt(this.vx * this.vx + this.vy * this.vy);
        this.deformation = 1 + (speed * 0.1); // Stretch factor
        
        this.x += this.vx;
        this.y += this.vy;
        
        // Air resistance (more realistic)
        const airResistance = 0.02;
        this.vx *= (1 - airResistance);
        this.vy *= (1 - airResistance * 0.5); // Less resistance on vertical
        
        // Temperature cooling
        this.temperature -= this.coolingRate;
        if (this.temperature < 0) this.temperature = 0;
        
        // Size changes based on temperature
        const tempFactor = this.temperature / 1000;
        this.radius = this.baseRadius * (0.7 + tempFactor * 0.3);
        
        // Color changes as it cools
        this.hue = 5 + (tempFactor * 35); // Red when cool, orange/yellow when hot
        
        // Life decreases
        this.life -= 0.8;
        
        // Create bubbling effect when very hot
        this.bubbleTimer++;
        if (tempFactor > 0.6 && this.bubbleTimer > 8) { // Only when very hot
            this.createBubble();
            this.bubbleTimer = 0;
        }
        
        // Update existing bubbles
        for (let i = this.bubbles.length - 1; i >= 0; i--) {
            const bubble = this.bubbles[i];
            bubble.life--;
            bubble.radius += bubble.growth;
            bubble.alpha = bubble.life / bubble.maxLife;
            
            // Remove dead bubbles
            if (bubble.life <= 0) {
                this.bubbles.splice(i, 1);
            }
        }
        
        // Simulate hitting bottom of screen (bounce effect)
        if (this.y > this.ctx.canvas.height - 50 && !this.hasHitSurface) {
            this.vy *= -this.bounce; // Bounce up
            this.vx *= 0.7; // Lose some horizontal speed
            this.hasHitSurface = true;
            this.temperature *= 0.6; // Cool down on impact
        }
        
        return this.life > 0 && this.radius > 0.3 && this.temperature >= 0;
    }

    createBubble() {
        // Create 1-3 bubbles on the surface
        const bubbleCount = Math.floor(Math.random() * 3) + 1;
        
        for (let i = 0; i < bubbleCount; i++) {
            // Position bubbles on the surface of the drop
            const angle = Math.random() * Math.PI * 2;
            const distance = this.radius * (0.6 + Math.random() * 0.3); // Near surface
            
            const bubble = {
                x: Math.cos(angle) * distance,
                y: Math.sin(angle) * distance,
                radius: Math.random() * 1.5 + 0.5,
                growth: Math.random() * 0.15 + 0.05,
                life: Math.floor(Math.random() * 15) + 10,
                maxLife: 25,
                alpha: 1,
                hue: this.hue + Math.random() * 20 - 10 // Slight color variation
            };
            
            this.bubbles.push(bubble);
        }
        
        // Limit bubble count for performance
        if (this.bubbles.length > 8) {
            this.bubbles.splice(0, this.bubbles.length - 8);
        }
    }

    draw() {
        this.ctx.save();
        this.ctx.globalCompositeOperation = 'lighter';
        
        // Draw trail with temperature-based colors
        for (let i = 0; i < this.trail.length; i++) {
            const trailPoint = this.trail[i];
            const alpha = (i / this.trail.length) * (trailPoint.life / this.maxLife) * 0.4;
            const trailRadius = (trailPoint.radius || this.radius) * (i / this.trail.length) * 0.6;
            const trailTemp = trailPoint.temperature || 0;
            const trailHue = 5 + (trailTemp / 1000) * 35;
            
            if (alpha > 0.05) {
                this.ctx.beginPath();
                this.ctx.arc(trailPoint.x, trailPoint.y, trailRadius, 0, 2 * Math.PI);
                this.ctx.fillStyle = `hsla(${trailHue}, 90%, 60%, ${alpha})`;
                this.ctx.fill();
            }
        }
        
        // Calculate deformed shape (ellipse when moving fast)
        const alpha = this.life / this.maxLife;
        const tempFactor = this.temperature / 1000;
        
        // Draw outer glow (larger when hotter)
        const glowSize = this.radius * (2 + tempFactor);
        this.ctx.beginPath();
        this.ctx.arc(this.x, this.y, glowSize, 0, 2 * Math.PI);
        this.ctx.fillStyle = `hsla(${this.hue}, 100%, 50%, ${alpha * tempFactor * 0.4})`;
        this.ctx.fill();
        
        // Draw deformed main drop (ellipse based on velocity)
        this.ctx.save();
        this.ctx.translate(this.x, this.y);
        
        // Calculate stretch direction based on velocity
        const angle = Math.atan2(this.vy, this.vx);
        this.ctx.rotate(angle);
        
        // Draw stretched drop
        this.ctx.beginPath();
        this.ctx.scale(1, this.deformation);
        this.ctx.arc(0, 0, this.radius, 0, 2 * Math.PI);
        
        // Color based on temperature
        const brightness = 60 + (tempFactor * 30);
        const saturation = 80 + (tempFactor * 20);
        this.ctx.fillStyle = `hsla(${this.hue}, ${saturation}%, ${brightness}%, ${alpha})`;
        this.ctx.fill();
        
        // Hot center (only when very hot)
        if (tempFactor > 0.3) {
            this.ctx.beginPath();
            this.ctx.arc(0, 0, this.radius * 0.5, 0, 2 * Math.PI);
            this.ctx.fillStyle = `hsla(${Math.min(60, this.hue + 40)}, 100%, 95%, ${alpha * tempFactor})`;
            this.ctx.fill();
        }
        
        this.ctx.restore();
        
        this.ctx.restore();
        
        // Draw bubbling effect on the surface
        this.ctx.save();
        this.ctx.translate(this.x, this.y);
        this.ctx.globalCompositeOperation = 'lighter';
        
        for (const bubble of this.bubbles) {
            // Draw bubble with glow effect
            const bubbleAlpha = bubble.alpha * tempFactor;
            
            if (bubbleAlpha > 0.1) {
                // Outer bubble glow
                this.ctx.beginPath();
                this.ctx.arc(bubble.x, bubble.y, bubble.radius * 2, 0, 2 * Math.PI);
                this.ctx.fillStyle = `hsla(${bubble.hue}, 80%, 70%, ${bubbleAlpha * 0.3})`;
                this.ctx.fill();
                
                // Main bubble
                this.ctx.beginPath();
                this.ctx.arc(bubble.x, bubble.y, bubble.radius, 0, 2 * Math.PI);
                this.ctx.fillStyle = `hsla(${bubble.hue + 10}, 90%, 80%, ${bubbleAlpha * 0.6})`;
                this.ctx.fill();
                
                // Bubble highlight (makes it look more 3D)
                this.ctx.beginPath();
                this.ctx.arc(
                    bubble.x - bubble.radius * 0.3, 
                    bubble.y - bubble.radius * 0.3, 
                    bubble.radius * 0.4, 
                    0, 2 * Math.PI
                );
                this.ctx.fillStyle = `hsla(${Math.min(60, bubble.hue + 30)}, 100%, 95%, ${bubbleAlpha * 0.8})`;
                this.ctx.fill();
            }
        }
        
        this.ctx.restore();
        
        // Add sparks when very hot and moving
        if (tempFactor > 0.7 && Math.random() > 0.8) {
            for (let i = 0; i < 2; i++) {
                const sparkX = this.x + (Math.random() - 0.5) * this.radius;
                const sparkY = this.y + (Math.random() - 0.5) * this.radius;
                
                this.ctx.beginPath();
                this.ctx.arc(sparkX, sparkY, Math.random() * 1.5 + 0.5, 0, 2 * Math.PI);
                this.ctx.fillStyle = `hsla(45, 100%, 90%, ${Math.random() * 0.8})`;
                this.ctx.fill();
            }
        }
    }
}

class TorchCuttingGame {
    constructor() {
        this.canvas = document.getElementById('cuttingCanvas');
        this.ctx = this.canvas.getContext('2d');
        this.particles = [];
        this.weldSeam = [];
        this.moltenDrops = []; // Array for molten metal drops
        this.mousedown = false;
        this.mx = 0;
        this.my = 0;
        this.progress = 0;
        this.maxProgress = 100;
        this.isGameActive = false;
        this.gameCompleted = false;
        
        // Cutting path definition (vertical line through the hinge)
        this.cuttingPath = [];
        this.pathTolerance = 15;  // Will be updated from config
        this.minSpeed = 0.5;      // Will be updated from config
        this.maxSpeed = 4;        // Will be updated from config
        this.lastMouseTime = 0;
        this.lastMousePos = {x: 0, y: 0};
        
        // Cutting line position settings
        this.cutLineOffsetX = 0;
        this.cutLineOffsetY = 0;
        this.cutLineLength = 150;
        
        // Track previous mouse position for cutting direction
        this.prevMx = 0;
        this.prevMy = 0;
        
        // Performance optimization settings
        this.maxWeldSeam = 120; // Even longer cutting trail
        this.maxParticles = 300; // More sparks allowed
        this.stitchCooldown = 0; // Cooldown between stitches
        this.stitchInterval = 1; // Create stitch every frame for smoothness
        
        this.init();
        this.applyGlobalSettings();
    }

    applyGlobalSettings() {
        // Apply global cutting settings from config
        if (torchGameConfig?.globalCuttingSettings) {
            const settings = torchGameConfig.globalCuttingSettings;
            this.pathTolerance = settings.pathTolerance || 15;
            this.minSpeed = settings.minSpeed || 0.5;
            this.maxSpeed = settings.maxSpeed || 4;
        }
    }

    init() {
        this.resizeCanvas();
        this.setupEventListeners();
        this.defineCuttingPath();
        this.loop();
        
        window.addEventListener('resize', () => this.resizeCanvas());
    }

    resizeCanvas() {
        const rect = this.canvas.parentElement.getBoundingClientRect();
        this.canvas.width = rect.width;
        this.canvas.height = rect.height;
    }

    setupEventListeners() {
        this.canvas.addEventListener('mousemove', (event) => {
            const rect = this.canvas.getBoundingClientRect();
            // Store previous position before updating
            this.prevMx = this.mx;
            this.prevMy = this.my;
            // Update current position
            this.mx = event.clientX - rect.left;
            this.my = event.clientY - rect.top;
        });

        this.canvas.addEventListener('mousedown', (event) => {
            event.preventDefault();
            if (this.isGameActive && !this.gameCompleted) {
                this.mousedown = true;
                this.lastMouseTime = Date.now();
                this.lastMousePos = {x: this.mx, y: this.my};
                
                // Start cutting sound when player starts cutting
                if (torchAudio) {
                    torchAudio.startCutting();
                }
            }
        });

        this.canvas.addEventListener('mouseup', (event) => {
            event.preventDefault();
            this.mousedown = false;
            
            // Stop cutting sound when player stops cutting
            if (torchAudio) {
                torchAudio.stopCutting();
            }
        });
    }

    defineCuttingPath() {
        // Define cutting line as vertical line in the middle
        const centerX = this.canvas.width / 2 + (this.cutLineOffsetX || 0);
        const centerY = this.canvas.height / 2 + (this.cutLineOffsetY || 0);
        const lineLength = this.cutLineLength || 150;
        
        const startY = centerY - lineLength / 2;
        const endY = centerY + lineLength / 2;
        
        this.cuttingPath = [];
        for (let y = startY; y <= endY; y += 5) {
            this.cuttingPath.push({x: centerX, y: y, cut: false});
        }
    }

    startGame() {
        this.isGameActive = true;
        this.gameCompleted = false;
        this.progress = 0;
        this.updateProgressDisplay();
        
        // Clear previous game state
        this.particles = [];
        this.weldSeam = [];
        this.defineCuttingPath();
    }

    stopGame() {
        this.isGameActive = false;
        this.mousedown = false;
        
        // Stop cutting sound when game stops
        if (torchAudio) {
            torchAudio.stopCutting();
        }
    }

    updateCuttingLinePosition(offsetX, offsetY, length) {
        this.cutLineOffsetX = offsetX;
        this.cutLineOffsetY = offsetY;
        this.cutLineLength = length;
        this.defineCuttingPath();
        
        // Reset progress when line is moved
        this.progress = 0;
        this.updateProgressDisplay();
    }

    createParticles(x, y) {
        // Limit total particles for performance
        if (this.particles.length >= this.maxParticles) {
            return; // Skip creating new particles if at limit
        }
        
        let particleCount = Math.min(25, this.maxParticles - this.particles.length); // Much more sparks
        while(particleCount--) {
            this.particles.push(new Particle(x, y, this.ctx));
        }
    }

    createMoltenDrops(x, y) {
        // Create 1-2 molten drops occasionally
        if (Math.random() > 0.85 && this.moltenDrops.length < 10) { // 15% chance, max 10 drops
            const dropCount = Math.random() > 0.7 ? 2 : 1; // 30% chance for 2 drops
            for (let i = 0; i < dropCount; i++) {
                // Slight offset for multiple drops
                const offsetX = (Math.random() - 0.5) * 10;
                const offsetY = (Math.random() - 0.5) * 5;
                this.moltenDrops.push(new MoltenDrop(x + offsetX, y + offsetY, this.ctx));
            }
        }
    }

    drawTorchLight(x, y) {
        // Draw intense cutting light only at mouse position (current cutting point)
        this.ctx.save();
        this.ctx.globalCompositeOperation = 'screen'; // Additive blending for intense light
        
        // Calculate light intensity with more dramatic pulsation
        const time = Date.now() * 0.008;
        const pulsation = 0.7 + Math.sin(time) * 0.25 + Math.sin(time * 2.3) * 0.1 + Math.sin(time * 0.7) * 0.15;
        const lightIntensity = Math.max(0.3, pulsation); // Never go below 30%
        
        // Outer light bloom (massive, very soft)
        let outerLightGrt = this.ctx.createRadialGradient(x, y, 0, x, y, 120);
        outerLightGrt.addColorStop(0.0, `rgba(255, 255, 255, ${0.4 * lightIntensity})`); // Much brighter center
        outerLightGrt.addColorStop(0.2, `rgba(255, 230, 180, ${0.25 * lightIntensity})`); // Warm white
        outerLightGrt.addColorStop(0.4, `rgba(255, 200, 100, ${0.15 * lightIntensity})`); // Warm yellow
        outerLightGrt.addColorStop(0.7, `rgba(255, 150, 50, ${0.08 * lightIntensity})`); // Orange
        outerLightGrt.addColorStop(1.0, 'rgba(255, 100, 0, 0)'); // Fade to nothing
        
        this.ctx.beginPath();
        this.ctx.fillStyle = outerLightGrt;
        this.ctx.arc(x, y, 120, 0, 2 * Math.PI);
        this.ctx.fill();
        
        // Medium light bloom (elliptical like real torch)
        this.ctx.save();
        this.ctx.translate(x, y);
        this.ctx.scale(1, 0.7); // Make it more elliptical
        
        let mediumLightGrt = this.ctx.createRadialGradient(0, 0, 0, 0, 0, 40);
        mediumLightGrt.addColorStop(0.0, `rgba(255, 255, 255, ${0.7 * lightIntensity})`); // Very intense white
        mediumLightGrt.addColorStop(0.3, `rgba(255, 240, 200, ${0.5 * lightIntensity})`); // Bright warm
        mediumLightGrt.addColorStop(0.6, `rgba(255, 200, 120, ${0.3 * lightIntensity})`); // Yellow
        mediumLightGrt.addColorStop(1.0, 'rgba(255, 150, 80, 0)');
        
        this.ctx.beginPath();
        this.ctx.fillStyle = mediumLightGrt;
        this.ctx.arc(0, 0, 40, 0, 2 * Math.PI);
        this.ctx.fill();
        this.ctx.restore();
        
        // Inner core - elongated like real torch flame
        this.ctx.save();
        this.ctx.translate(x, y);
        this.ctx.scale(0.6, 1.4); // Tall and narrow like torch core
        
        let innerLightGrt = this.ctx.createRadialGradient(0, 0, 0, 0, 0, 8);
        innerLightGrt.addColorStop(0.0, `rgba(255, 255, 255, ${1.0 * lightIntensity})`); // Blinding white center
        innerLightGrt.addColorStop(0.2, `rgba(255, 250, 240, ${0.9 * lightIntensity})`); // Almost white
        innerLightGrt.addColorStop(0.5, `rgba(255, 240, 200, ${0.7 * lightIntensity})`); // Very bright warm
        innerLightGrt.addColorStop(1.0, `rgba(255, 200, 150, ${0.4 * lightIntensity})`); // Warm edge
        
        this.ctx.beginPath();
        this.ctx.fillStyle = innerLightGrt;
        this.ctx.arc(0, 0, 8, 0, 2 * Math.PI);
        this.ctx.fill();
        this.ctx.restore();
        
        // Ultra-bright center point (like real torch tip)
        let centerGrt = this.ctx.createRadialGradient(x, y, 0, x, y, 3);
        centerGrt.addColorStop(0.0, `rgba(255, 255, 255, ${1.0 * lightIntensity})`); // Pure white
        centerGrt.addColorStop(0.5, `rgba(255, 255, 255, ${0.8 * lightIntensity})`); // Still white
        centerGrt.addColorStop(1.0, `rgba(255, 250, 240, ${0.5 * lightIntensity})`); // Slight warm
        
        this.ctx.beginPath();
        this.ctx.fillStyle = centerGrt;
        this.ctx.arc(x, y, 3, 0, 2 * Math.PI);
        this.ctx.fill();
        
        this.ctx.restore();
    }

    checkCuttingProgress() {
        if (!this.mousedown) return;

        const currentTime = Date.now();
        const timeDiff = currentTime - this.lastMouseTime;
        const distance = Math.sqrt(
            Math.pow(this.mx - this.lastMousePos.x, 2) + 
            Math.pow(this.my - this.lastMousePos.y, 2)
        );
        
        const speed = timeDiff > 0 ? distance / timeDiff * 10 : 0;
        
        // Get progress rate from config (realistic cutting speed)
        const progressRate = torchGameConfig?.globalCuttingSettings?.progressRate || 0.3;
        
        // Check if speed is within acceptable range (must be slow and steady)
        if (speed >= this.minSpeed && speed <= this.maxSpeed) {
            // Check if mouse is near cutting path
            let nearPath = false;
            for (let point of this.cuttingPath) {
                if (!point.cut) {
                    const dist = Math.sqrt(
                        Math.pow(this.mx - point.x, 2) + 
                        Math.pow(this.my - point.y, 2)
                    );
                    
                    if (dist <= this.pathTolerance) {
                        point.cut = true;
                        nearPath = true;
                        break;
                    }
                }
            }
            
            // Only increase progress if cutting correctly (slow and steady)
            if (nearPath) {
                this.progress += progressRate; // Much slower progress increase
                this.progress = Math.min(100, this.progress);
            }
        } else if (speed < this.minSpeed && speed > 0) {
            // Still cutting but too slow - minimal progress
            let nearPath = false;
            for (let point of this.cuttingPath) {
                if (!point.cut) {
                    const dist = Math.sqrt(
                        Math.pow(this.mx - point.x, 2) + 
                        Math.pow(this.my - point.y, 2)
                    );
                    
                    if (dist <= this.pathTolerance) {
                        point.cut = true;
                        nearPath = true;
                        break;
                    }
                }
            }
            
            if (nearPath) {
                this.progress += progressRate * 0.3; // Slower progress for too slow movement
                this.progress = Math.min(100, this.progress);
            }
        } else if (speed > this.maxSpeed) {
            // Penalty for cutting too fast (realistic - torch needs steady movement)
            this.progress -= 0.1;
            this.progress = Math.max(0, this.progress);
        }
        
        this.lastMouseTime = currentTime;
        this.lastMousePos = {x: this.mx, y: this.my};
        
        // Check if all cutting points are completed (backup system)
        const cutPoints = this.cuttingPath.filter(p => p.cut).length;
        const totalPoints = this.cuttingPath.length;
        const pointsProgress = (cutPoints / totalPoints) * 100;
        
        // If all points are cut but progress isn't 100%, set it to 100%
        if (pointsProgress >= 95 && this.progress < 100) {
            this.progress = 100;
        }
        
        // Also ensure minimum progress based on points cut
        const minProgressFromPoints = pointsProgress * 0.8; // 80% of points progress as minimum
        if (this.progress < minProgressFromPoints) {
            this.progress = minProgressFromPoints;
        }
        
        this.updateProgressDisplay();
        
        // Check if game is completed
        if (this.progress >= 100 && !this.gameCompleted) {
            this.completeGame();
        }
    }

    updateProgressDisplay() {
        const progressFill = document.getElementById('progressFill');
        const progressText = document.getElementById('progressText');
        
        if (progressFill) progressFill.style.width = this.progress + '%';
        if (progressText) progressText.textContent = Math.round(this.progress) + '%';
    }

    completeGame() {
        this.gameCompleted = true;
        this.isGameActive = false;
        
        // Send completion event to Lua
        fetch(`https://dodi_bankrobbery/cuttingCompleted`, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify({
                success: true,
                progress: this.progress
            })
        });
        
        console.log('Cutting completed!');
    }

    drawCuttingPath() {
        this.ctx.globalCompositeOperation = 'source-over';
        
        for (let point of this.cuttingPath) {
            if (!point.cut) {
                // Only draw uncut points (cut points disappear)
                this.ctx.beginPath();
                this.ctx.fillStyle = 'rgba(255, 255, 255, 0.4)'; // White for uncut sections
                this.ctx.arc(point.x, point.y, 3, 0, 2 * Math.PI);
                this.ctx.fill();
                
                // Add subtle glow to make them more visible
                this.ctx.beginPath();
                this.ctx.fillStyle = 'rgba(255, 255, 255, 0.1)';
                this.ctx.arc(point.x, point.y, 6, 0, 2 * Math.PI);
                this.ctx.fill();
            } else {
                // Add fade out animation for recently cut points
                if (!point.fadeStartTime) {
                    point.fadeStartTime = Date.now();
                }
                
                const fadeTime = Date.now() - point.fadeStartTime;
                const fadeDuration = 300; // 300ms fade out
                
                if (fadeTime < fadeDuration) {
                    const alpha = 1 - (fadeTime / fadeDuration);
                    this.ctx.beginPath();
                    this.ctx.fillStyle = `rgba(255, 165, 0, ${alpha * 0.8})`; // Fading orange
                    this.ctx.arc(point.x, point.y, 3 * alpha, 0, 2 * Math.PI);
                    this.ctx.fill();
                }
                // After fade duration, point is completely invisible (no drawing)
            }
        }
    }

    loop() {
        requestAnimationFrame(this.loop.bind(this));
        
        // Clear canvas with fade effect
        this.ctx.globalCompositeOperation = 'destination-out';
        this.ctx.fillStyle = 'rgba(0, 0, 0, 0.5)';
        this.ctx.fillRect(0, 0, this.canvas.width, this.canvas.height);
        
        this.ctx.globalCompositeOperation = 'lighter';
        
        if (this.isGameActive) {
            this.checkCuttingProgress();
            
            if (this.mousedown) {
                // Control stitch creation frequency for performance
                this.stitchCooldown++;
                if (this.stitchCooldown >= this.stitchInterval) {
                    let st = new Stitch(this.mx, this.my, this.ctx, 8, this.prevMx, this.prevMy);
                    this.weldSeam.push(st);
                    this.createParticles(this.mx, this.my); // Restored sparks
                    this.createMoltenDrops(this.mx, this.my); // Create molten drops
                    this.stitchCooldown = 0;
                    
                    // Limit weld seam array size for performance
                    if (this.weldSeam.length > this.maxWeldSeam) {
                        this.weldSeam.shift(); // Remove oldest stitch
                    }
                }
            }
        }
        
        // Update and draw particles (restored sparks)
        for (let i = this.particles.length - 1; i >= 0; i--) {
            const particle = this.particles[i];
            particle.draw();
            if (!particle.update()) {
                this.particles.splice(i, 1);
            }
        }

        // Update and draw molten drops
        for (let i = this.moltenDrops.length - 1; i >= 0; i--) {
            const drop = this.moltenDrops[i];
            drop.draw();
            if (!drop.update()) {
                this.moltenDrops.splice(i, 1);
            }
        }
        
        // Update and draw weld seam (optimized)
        this.ctx.globalCompositeOperation = 'destination-over';
        for (let i = this.weldSeam.length - 1; i >= 0; i--) {
            const stitch = this.weldSeam[i];
            stitch.update();
            stitch.draw();
            
            // Keep stitches much longer for maximum cutting trail visibility
            if (stitch.brightness <= 1 && stitch.saturation <= 1) {
                this.weldSeam.splice(i, 1);
            }
        }
        
        // Draw intense torch light only at current mouse position (where cutting is happening now)
        if (this.isGameActive && this.mousedown) {
            this.drawTorchLight(this.mx, this.my);
        }
        
        // Draw cutting path
        this.drawCuttingPath();
        
        this.ctx.globalCompositeOperation = 'lighter';
    }
}

// Global cutting game instance
let cuttingGame = null;

// Initialize cutting game when minigame opens
function initializeCuttingGame() {
    if (!cuttingGame) {
        cuttingGame = new TorchCuttingGame();
    }
    
    // Apply cutting line config from current phase
    if (torchGameConfig && torchGameConfig.phases) {
        const currentPhase = torchGameConfig.phases[torchGameConfig.currentPhase - 1];
        if (currentPhase && currentPhase.cuttingGame) {
            const cutConfig = currentPhase.cuttingGame;
            cuttingGame.updateCuttingLinePosition(
                cutConfig.cutLineOffsetX || 0,
                cutConfig.cutLineOffsetY || 0,
                cutConfig.cutLineLength || 150
            );
        }
    }
    
    cuttingGame.startGame();
}
