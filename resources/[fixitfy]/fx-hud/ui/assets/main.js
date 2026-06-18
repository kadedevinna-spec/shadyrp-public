const hudLabelMap = {
    "health2": "Health",
    "stamina2": "Stamina",
    "hunger2": "hunger",
    "thirst2": "Thirst",
    "stress2": "Stress",
    "pvp2": "PVP",
    "armour2": "Armour",
    "dirty2": "Dirty",
    "microphone2": "Microphone",
    "temp2": "Temperature",
    "onesync2": "OneSync",
    "alcohol2": "Alcohol",
    "horse-health2": "Horse Health",
    "horse-stamina2": "Horse Stamina",
    "horse-dirty2": "Horse Dirty",
    "level2": "Level"
};

let rafScheduled = false;
let lastHudData = null;
let onPlayerLoaded = false;
let hudInitialized = false;
var ImgPath = "";
var onEditMenu= false;
var defaultHudCheckedData = {};
var editHuds = [".health2", ".stamina2", ".hunger2", ".thirst2", ".stress2", ".pvp2", ".armour2", ".dirty2", ".microphone2", ".temp2", ".onesync2", ".alcohol2", ".horse-health2", ".horse-stamina2", ".horse-dirty2", ".level2", ".hud-prewiev .cash", ".hud-prewiev .gold", ".hud-prewiev .hour", ".hud-prewiev .id"];
var mainHuds = [".health", ".stamina", ".hunger", ".thirst", ".stress", ".pvp", ".armour", ".dirty", ".microphone", ".temp", ".onesync", ".alcohol", ".horse-health", ".horse-stamina", ".horse-dirty", ".level", ".cash", ".gold", ".hour", ".id", ".locations"]; 
var HudAutoHide = false, progressSelected = false, hudHide = false, iconSelected = true, selectAllHud = true, selectHud = null, DisableNumbersAboveCores = false, changeHudWidhtType = false, changeStatWidhtType = false;
var hudForceColor = {};
var LocaleText = {};
var SizeData = {};
var HudPositionDatas = {};
var progressIsBussy = false;
var currentHudData = {
    ".horse-stamina": 0, ".horse-health": 0, ".dirty": 0, ".horse-dirty": 0, ".level": 0,
    ".stress": 0, ".pvp": 100, ".armour": 0, ".thirst": 0, ".hunger": 0, ".alcohol": 0, ".stamina": 0, ".health": 0,
    ".microphone": 0, ".temp": 0, ".onesync": 0,
};

let defaultHudPositionData = null; 
function defaultHudSize() { return { position: "relative", display: "flex", left: "0%", top: "96.8%", width: "2.3%", height: "2.3%", borderRadius: "50%", overflow: "visible" }; }

var currentHudPositionData = {
    ".horse-stamina": defaultHudSize(), 
    ".horse-health": defaultHudSize(), 
    ".horse-dirty": defaultHudSize(),
    ".dirty": defaultHudSize(), 
    ".stress": defaultHudSize(), 
    ".pvp": defaultHudSize(), 
    ".armour": defaultHudSize(), 
    ".thirst": defaultHudSize(), 
    ".hunger": defaultHudSize(),
    ".stamina": defaultHudSize(), 
    ".health": defaultHudSize(), 
    ".microphone": defaultHudSize(), 
    ".temp": defaultHudSize(),
    ".onesync": defaultHudSize(), 
    ".alcohol": defaultHudSize(), 
    ".level": defaultHudSize(),
    ".hour": { position: "absolute", left: "79%", top: "97%", width: "auto", height: "auto", fontSize: "1.2vh"},
    ".cash": { position: "absolute", left: "70%", top: "97%", width: "auto", height: "auto", fontSize: "1.2vh"},
    ".gold": { position: "absolute", left: "75%", top: "97%", width: "auto", height: "auto", fontSize: "1.2vh"},
    ".id": { position: "absolute", left: "82%", top: "97%", width: "auto", height: "auto", fontSize: "1.2vh"},
    ".locations": { position: "absolute", left: "0.2%", top: "92%", width: "auto", height: "auto", fontSize: "1.0vh", areaFontSize: "1.2vh", txtFontSize: "1.3vh" },
    ".notify-container": { position: "absolute", right: "0%", top: "15%", width: "15%", height: "max-content" }
};

var homeSettingsData = {
    ".health": 1, 
    ".stamina": 1, 
    ".hunger": 1, 
    ".thirst": 1, 
    ".stress": 1, 
    ".pvp": 1, 
    ".armour": 1, 
    ".dirty": 1, 
    ".horse-dirty": 1, 
    ".microphone": 1, 
    ".temp": 1,
    ".onesync": 1, 
    ".alcohol": 1, 
    ".horse-health": 1, 
    ".horse-stamina": 1, 
    ".level": 1, 
    ".hour": 1, 
    ".cash": 1, 
    ".gold": 1, 
    ".id": 1, 
    ".locations": 1,
};

var currentHudColorData = {};
var hudColorData = {
    "#health-core": "#ffffff", "#stamina-core": "#ffffff", "#thirst-core": "#ffffff", "#stress-core": "#ffffff", "#pvp-core": "#ffffff", "#armour-core": "#ffffff", "#dirty-core": "#ffffff",
    "#microphone-core": "#ffffff", "#temp-core": "#ffffff", "#onesync-core": "#ffffff", "#alcohol-core": "#ffffff", "#level-core": "#ffffff",
    "#horse-health-core": "#ffffff", "#horse-stamina-core": "#ffffff", "#horse-dirty-core": "#ffffff", "#health-meter": "#ffffff",
    "#stamina-meter": "#ffffff", "#hunger-meter": "#ffffff", "#thirst-meter": "#ffffff", "#stress-meter": "#ffffff", "#pvp-meter": "#ffffff", "#armour-meter": "#ffffff", "#dirty-meter": "#ffffff",
    "#microphone-meter": "#ffffff", "#temp-meter": "#ffffff", "#onesync-meter": "#ffffff", "#alcohol-meter": "#ffffff", "#level-meter": "#ffffff",
    "#horse-health-meter": "#ffffff", "#horse-stamina-meter": "#ffffff", "#horse-dirty-meter": "#ffffff"
};

// === PROGRESS ===
function updateProgressMeter(divname, value) {
    let meterValue = Math.floor(value * 99 / 100);
    meterValue = Math.min(Math.max(meterValue, 0), 99);
    const newSrc = `/ui/assets/img/rpg_meter/rpg_meter_${meterValue}.png`;
    const img = $(`${divname} .progress-bar-img`);

    if (img.length === 0) {
        // console.error(`Element not found: ${divname} .progress-bar-img`);
        return;
    }

    if (img.attr('src') !== newSrc) {
        img.attr('src', newSrc);
    }
}


// Global SVG map for each HUD element
const hudSvgMap = {};
const allHudSelectors = [
    ".health", ".stamina", ".hunger", ".thirst", ".stress", ".pvp", ".armour", ".dirty",
    ".microphone", ".temp", ".onesync", ".alcohol", ".horse-health",
    ".horse-stamina", ".horse-dirty", ".level",
    ".health2", ".stamina2", ".hunger2", ".thirst2", ".stress2", ".pvp2", ".armour2", ".dirty2",
    ".microphone2", ".temp2", ".onesync2", ".alcohol2", ".horse-health2",
    ".horse-stamina2", ".horse-dirty2", ".level2"
];

function createAllHudFiltersOnce() {
    allHudSelectors.forEach(selector => {
        [".progress-bar-img", ".core-img"].forEach(suffix => {
            const fullSelector = `${selector} ${suffix}`;
            const baseId = fullSelector.replace(/[^a-zA-Z0-9]/g, '_');
            const filterId = `filter_${baseId}`;

            if (!document.getElementById(`svg_${baseId}`)) {
                const defaultRGB = { r: 255, g: 255, b: 255 };
                const svg = document.createElementNS("http://www.w3.org/2000/svg", "svg");
                svg.setAttribute("id", `svg_${baseId}`);
                svg.setAttribute("xmlns", "http://www.w3.org/2000/svg");
                svg.setAttribute("style", "position:absolute;width:0;height:0;");
                svg.innerHTML = `
                    <defs>
                        <filter id="${filterId}">
                            <feComponentTransfer>
                                <feFuncR type="linear" slope="${defaultRGB.r / 255}" />
                                <feFuncG type="linear" slope="${defaultRGB.g / 255}" />
                                <feFuncB type="linear" slope="${defaultRGB.b / 255}" />
                                <feFuncA type="table" tableValues="0 1" />
                            </feComponentTransfer>
                        </filter>
                    </defs>
                `;
                document.body.appendChild(svg);
                hudSvgMap[baseId] = true;
            }
        });
    });
}

function applyColorFilter(selector, rgb, overrideOriginal = false) {
    const el = typeof selector === "string" ? $(selector) : $(selector); 
    const domEl = el[0];

    let baseId;
    if (typeof selector === "string") {
        baseId = selector.replace(/[^a-zA-Z0-9]/g, '_');
    } else if (domEl) {
        const classPart = domEl.className || "";
        const idPart = domEl.id || "";
        baseId = `${classPart}_${idPart}`.replace(/[^a-zA-Z0-9]/g, '_');
    } 

    const filterId = `filter_${baseId}`;
    const newColorHex = rgbToHex(rgb);
    const currentColor = el.attr('data-color') || '#ffffff';

    if (!overrideOriginal && currentColor === newColorHex) return;

    if (!overrideOriginal && !el.attr('data-original-color')) {
        el.attr('data-original-color', currentColor);
    }

    const svg = document.getElementById(`svg_${baseId}`);
    if (svg) {
        const filter = svg.querySelector(`filter#${filterId}`);
        if (filter) {
            filter.innerHTML = `
                <feComponentTransfer>
                    <feFuncR type="linear" slope="${rgb.r / 255}" />
                    <feFuncG type="linear" slope="${rgb.g / 255}" />
                    <feFuncB type="linear" slope="${rgb.b / 255}" />
                    <feFuncA type="table" tableValues="0 1" />
                </feComponentTransfer>
            `;
        }
    } else {
        const newSvg = document.createElementNS("http://www.w3.org/2000/svg", "svg");
        newSvg.setAttribute("id", `svg_${baseId}`);
        newSvg.setAttribute("style", "position:absolute;width:0;height:0;");
        newSvg.innerHTML = `
            <defs>
                <filter id="${filterId}">
                    <feComponentTransfer>
                        <feFuncR type="linear" slope="${rgb.r / 255}" />
                        <feFuncG type="linear" slope="${rgb.g / 255}" />
                        <feFuncB type="linear" slope="${rgb.b / 255}" />
                        <feFuncA type="table" tableValues="0 1" />
                    </feComponentTransfer>
                </filter>
            </defs>
        `;
        document.body.appendChild(newSvg);
    }

    el.css('filter', `url(#${filterId})`);
    el.attr('data-color', newColorHex);
    el.attr('data-filter-id', filterId);
}

function resetColorFilter(element) {
    const filterId = element.attr('data-filter-id');
    if (filterId) {
        const $filter = $(`filter#${filterId}`);
        if ($filter.length > 0) {
            $filter.html('');
        }
    }
    element.removeAttr('data-filter-id');
    element.css('filter', 'none');
}

function updateElementColor(selector, hexColor) {
    const rgb = hexToRGB(hexColor);
    const el = $(selector);

    resetColorFilter(el);

    applyColorFilter(el, rgb, true);
}


function rgbToHex(rgb) {
    if (!rgb || typeof rgb !== 'object') return '#ffffff';
    const r = Number(rgb.r ?? 255).toString(16).padStart(2, '0');
    const g = Number(rgb.g ?? 255).toString(16).padStart(2, '0');
    const b = Number(rgb.b ?? 255).toString(16).padStart(2, '0');
    return `#${r}${g}${b}`;
}

function hexToRGB(hex) {
    if (!hex || typeof hex !== 'string' || !/^#[0-9A-Fa-f]{6}$/.test(hex)) {
        return { r: 255, g: 255, b: 255 }; 
    }
    const bigint = parseInt(hex.slice(1), 16);
    return {
        r: (bigint >> 16) & 255,
        g: (bigint >> 8) & 255,
        b: bigint & 255
    };
}

function applyGoldCoreFilters(hudData) {
    if (onEditMenu) return;

    const goldColor = { r: 255, g: 231, b: 111 };
    const micMuteColor = { r: 255, g: 0, b: 0 };

    const goldChecks = {
        ".health .progress-bar-img":   { overpowered: hudData.HealthOuterOverpowered,  color: goldColor,   coreId: "#health-meter" },
        ".health .core-img":           { overpowered: hudData.HealthCoreOverpowered,   color: goldColor,   coreId: "#health-core" },
        ".stamina .progress-bar-img":  { overpowered: hudData.StaminaOuterOverpowered, color: goldColor,   coreId: "#stamina-meter" },
        ".stamina .core-img":          { overpowered: hudData.StaminaCoreOverpowered,  color: goldColor,   coreId: "#stamina-core" },
        ".horse-health .progress-bar-img": { overpowered: hudData.HorseHealthOuterOverpowered, color: goldColor, coreId: "#horse-health-meter" },
        ".horse-health .core-img":         { overpowered: hudData.HorseHealthCoreOverpowered,  color: goldColor, coreId: "#horse-health-core" },
        ".horse-stamina .progress-bar-img":{ overpowered: hudData.HorseStaminaOuterOverpowered,color: goldColor, coreId: "#horse-stamina-meter" },
        ".horse-stamina .core-img":        { overpowered: hudData.HorseStaminaCoreOverpowered, color: goldColor, coreId: "#horse-stamina-core" },
        ".microphone .progress-bar-img":   { overpowered: hudData.micMuted,                    color: micMuteColor, coreId: "#microphone-meter" },
        ".microphone .core-img":           { overpowered: hudData.micMuted,                    color: micMuteColor, coreId: "#microphone-core" },
    };

    Object.entries(goldChecks).forEach(([selector, { overpowered, color, coreId }]) => {
        const element = $(selector);
        if (!element.length) return;

        const expectedHex = (hudColorData?.[coreId] || "#ffffff").toLowerCase();
        const currentHex  = (element.attr('data-color') || expectedHex).toLowerCase();
        const originalHex = (element.attr('data-original-color') || expectedHex).toLowerCase();
        const desiredHex  = rgbToHex(color).toLowerCase();

        if (!element.attr('data-original-color') || originalHex === desiredHex) {
            element.attr('data-original-color', expectedHex);
        }

        if (overpowered) {
            if (currentHex !== desiredHex) {
                resetColorFilter(element);
                applyColorFilter(element, color);
                element.attr('data-color', desiredHex);
                element.attr('data-was-overpowered', 'true');
            }
        } else {
            if (element.attr('data-was-overpowered') === 'true' && currentHex !== expectedHex) {
                const restoreRGB = hexToRGB(expectedHex);
                resetColorFilter(element);
                applyColorFilter(element, restoreRGB, true);
                element.attr('data-color', expectedHex);
                element.removeAttr('data-was-overpowered');
            }
        }
    });
}



let thirstInterval = null;
let hungerInterval = null;
let healthInterval = null;
let staminaInterval = null;
let horseHealthInterval = null;
let horseStaminaInterval = null;
    
const isAnimating = {
    ".health": false,
    ".stamina": false,
    ".horse-health": false,
    ".horse-stamina": false
};


// Global dictionary for safe timeout refs
const coreTimeouts = {};

function handleCoreImageAndColor(coreClass, coreId, isCritical, value, normalImage, agitationImage, getIntervalRef, setIntervalRef) {
    const element = $(`${coreClass} ${coreId}`);
    const criticalHex = "#8d0707";
    const criticalRGB = hexToRGB(criticalHex);

    const idSelector = `#${coreId.replace('#', '')}`;
    const expectedColor = hudColorData?.[idSelector] || "#ffffff";

    // Save original color once
    if (!element.attr("data-original-color") || element.attr("data-original-color") === criticalHex) {
        element.attr("data-original-color", expectedColor);
    }

    // Save original width once
    if (!element.attr("data-original-width")) {
        element.attr("data-original-width", element.css("width"));
    }

    const originalHex = element.attr("data-original-color");
    const originalWidth = element.attr("data-original-width");

    if (!$(element).length) return;
    if ($(element).is(":hidden")) {
        isAnimating[coreClass] = false;
        clearTimeout(coreTimeouts[coreClass]);
        // Animasyonun kendi hide() çağrısından kaldıysa elementi geri göster.
        // Parent gizliyse bu göstermez ama parent açıldığında element hazır olur.
        element.show();
        return;
    }

    // ---- NON-CRITICAL STATE ----
    if (!isCritical) {
        isAnimating[coreClass] = false;

        const hadCritical = element.attr("data-critical") === "true";
        const currentColor = element.attr("data-color")?.toLowerCase();
        const originalColor = originalHex?.toLowerCase();

        if (hadCritical || currentColor === criticalHex.toLowerCase()) {
            element.hide();
            element.removeAttr("data-critical");
        
            if (element.attr("src") !== normalImage) {
                element.attr("src", normalImage);
            }
        
            if (originalWidth) {
                element.css("width", originalWidth);
            }
        
            if (currentColor !== originalColor) {
                applyColorFilter(element, hexToRGB(originalHex));
                element.attr("data-color", originalHex);
            }
        
            element.show();
        }        
        return;
    }

    // ---- CRITICAL STATE ----
    if (isAnimating[coreClass]) return; // already animating
    isAnimating[coreClass] = true;
    element.attr("data-critical", "true");

    function animationCycle() {
        if (!isAnimating[coreClass]) return;

        element.hide();

        if (element.attr("src") !== agitationImage) {
            element.attr("src", agitationImage);
            element.css("width", "90%");
        }
        
        if (element.attr("data-color")?.toLowerCase() !== criticalHex.toLowerCase()) {
            applyColorFilter(element, criticalRGB);
            element.attr("data-color", criticalHex);
        }
        
        element.show();
        if (!isAnimating[coreClass]) return;
        
        setTimeout(() => {
            if (!isAnimating[coreClass]) return;
        
            element.hide();
        
            if (element.attr("src") !== normalImage) {
                if (originalWidth) {
                    element.css("width", originalWidth);
                }
                element.attr("src", normalImage);
            }
        
            if (element.attr("data-color")?.toLowerCase() !== criticalHex.toLowerCase()) {
                applyColorFilter(element, criticalRGB);
                element.attr("data-color", criticalHex);
            }
        
            element.show();
        
            if (isAnimating[coreClass]) {
                coreTimeouts[coreClass] = setTimeout(animationCycle, 1500);
                if (typeof setIntervalRef === "function") {
                    setIntervalRef(coreTimeouts[coreClass]);
                }
            }
        }, 800);        
    }
    animationCycle();
}

function getCoreIndex(value) {
    if (value <= 0) return 0;
    let index = Math.ceil(value / 6.67); // 0–100 arası değeri 0–15 scale’e çevir
    if (index > 15) index = 15;
    if (index < 0) index = 0;
    return index;
}


function updateCoreImages(divname, value, onHorse) {
    if (divname === ".horse-health") divname = ".horse-core-health";
    if (divname === ".horse-stamina") divname = ".horse-core-stamina";

    const agitationPath = "/ui/assets/img/rpg_agitation.png";
    const imgIndex = getCoreIndex(value); // ✅ her zaman 0–15
    const isHunger = divname === ".hunger";
    const isThirst = divname === ".thirst";
    let hungerIndex = 1;

    if (value >= 80) hungerIndex = 8;
    else if (value >= 70) hungerIndex = 7;
    else if (value >= 60) hungerIndex = 6;
    else if (value >= 50) hungerIndex = 5;
    else if (value >= 40) hungerIndex = 4;
    else if (value >= 30) hungerIndex = 3;
    else if (value >= 20) hungerIndex = 2;

    const isCritical = (isHunger || isThirst) ? value < 20 : imgIndex <= 2;

    const config = {
        '.health-core': {
            className: ".health",
            coreId: "#health-core",
            imagePath: `/ui/assets/img/player_core_health/core_state_${imgIndex}.png`,
            getInterval: () => healthInterval,
            setInterval: v => (healthInterval = v)
        },
        '.stamina-core': {
            className: ".stamina",
            coreId: "#stamina-core",
            imagePath: `/ui/assets/img/player_core_stamina/core_state_${imgIndex}.png`,
            getInterval: () => staminaInterval,
            setInterval: v => (staminaInterval = v)
        },
        '.horse-core-health': {
            className: ".horse-health",
            coreId: "#horse-health-core",
            imagePath: `/ui/assets/img/horse_core_health/core_state_${imgIndex}.png`,
            getInterval: () => horseHealthInterval,
            setInterval: v => (horseHealthInterval = v),
            requireHorse: true
        },
        '.horse-core-stamina': {
            className: ".horse-stamina",
            coreId: "#horse-stamina-core",
            imagePath: `/ui/assets/img/horse_core_stamina/core_state_${imgIndex}.png`,
            getInterval: () => horseStaminaInterval,
            setInterval: v => (horseStaminaInterval = v),
            requireHorse: true
        },
        '.hunger': {
            className: ".hunger",
            coreId: "#hunger-core",
            imagePath: `/ui/assets/img/hunger/${hungerIndex}.png`,
            getInterval: () => hungerInterval,
            setInterval: v => (hungerInterval = v)
        },
        '.thirst': {
            className: ".thirst",
            coreId: "#thirst-core",
            imagePath: `/ui/assets/img/thirst/${hungerIndex}.png`,
            getInterval: () => thirstInterval,
            setInterval: v => (thirstInterval = v)
        }
    };

    const cfg = config[divname];
    if (!cfg) return;
    if (cfg.requireHorse && !onHorse) return;

    const coreImg = $(`${cfg.className} ${cfg.coreId}`);

    if (!isCritical) {
        const currentSrc = coreImg.attr("src");
        if (currentSrc !== cfg.imagePath) {
            coreImg.attr("src", cfg.imagePath);
            coreImg.css("width", coreImg.attr("data-original-width") || "100%");
        }
    }

    handleCoreImageAndColor(
        cfg.className,
        cfg.coreId,
        isCritical,
        value,
        cfg.imagePath,
        agitationPath,
        cfg.getInterval,
        cfg.setInterval
    );
}

function getCoreIndex(value) {
    if (value <= 0) return 0;
    let index = Math.ceil(value / 6.67); // 100 / 6.67 ≈ 15
    if (index > 15) index = 15;
    return index;
}



// ========== 4. HUD RENK SENKRONİZASYON ========== //
function syncHudColors(sourceHuds, targetHuds) {
    sourceHuds.forEach((src, i) => {
        const tgt = targetHuds[i];
        [".progress-bar-img", ".core-img"].forEach(sel => {
            const sourceEl = $(`${src} ${sel}`);
            const targetSel = `${tgt} ${sel}`;
            const srcColor = sourceEl.attr('data-color');
            if (srcColor) {
                updateElementColor(targetSel, srcColor);
            }
        });
    });
}



// ========== 5. RENGİ UYGULAMA ========== //
function applyColorToSelectedHuds(rgb, hexColor) {
    const huds = selectAllHud ? [...editHuds, ...mainHuds] : [selectHud];
    huds.forEach(h => {
        if (progressSelected) updateElementColor(`${h} .progress-bar-img`, hexColor);
        if (iconSelected) updateElementColor(`${h} .core-img`, hexColor);
    });
}    
// ========== 6. INPUT EVENTLER ========== //
function registerInputEvents() {
    $('.color-box').on('click', function () {
        const color = $(this).attr('data-color');
        const rgb = hexToRGB(color);
        applyColorToSelectedHuds(rgb, color);
        syncHudColors(editHuds, mainHuds);
    });

    $('#customColorPicker').off('change').on('change', function () {
        const hexColor = $(this).val();
        const rgb = hexToRGB(hexColor);
        applyColorToSelectedHuds(rgb, hexColor);
        syncHudColors(editHuds, mainHuds);
    });
}

function initializeHUD() {
    $(".select-all-hud").addClass("select-all-hudactive");
    editHuds.forEach(h => $(h).addClass("activehud"));
    $('#colorbox2').addClass('selectcolortypeactive');
    $(".showvoicerange, .ui-panel").hide();
    [...mainHuds, ".cash", ".locations", ".gold", ".id", ".level", ".hour"].forEach(h => $(h).hide());
}

$(document).ready(function () {
    $(".temp-value").hide();
    $(".level-value").hide();
    $(".hud-settings, .navbar").draggable({
        containment: "window", 
        scroll: false         
    });
    createAllHudFiltersOnce()
    initializeHUD();
    registerInputEvents();
    function resetHudData() {
        disableDraggable();
        currentHudPositionData = defaultHudPositionData || {}
        Object.keys(currentHudPositionData).forEach(hud => {
            const def = currentHudPositionData[hud] || {};
            const cssPosition = {
                position: def.position || "absolute",
                width: def.width || "2.3%",
                height: def.height || "2.3%"
            };
    
            if (def.display !== undefined) cssPosition.display = def.display;
            if (def.top !== undefined) cssPosition.top = def.top;
            if (def.left !== undefined) cssPosition.left = def.left;
            if (def.right !== undefined) cssPosition.right = def.right;
            if (def.bottom !== undefined) cssPosition.bottom = def.bottom;
    
            $(hud).css(cssPosition);
    
            if (def.fontSize) {
                $(hud).find(".id-text, .hour-text, .gold-value, .cash-value").css("font-size", def.fontSize);
            }
    
            if (hud === ".locations") {
                if (def.fontSize) $(".locations").css("font-size", def.fontSize);
                if (def.areaFontSize) $(".locations-area").css("font-size", def.areaFontSize);
                if (def.txtFontSize) $(".locations-txt").css("font-size", def.txtFontSize);
            }
    
            HudPositionDatas[hud] = {
                top: def.top || null,
                left: def.left || null,
                right: def.right || null,
                bottom: def.bottom || null,
                position: def.position || "absolute",
                width: def.width || "2.3%",
                height: def.height || "2.3%",
                display: def.display || null,
                fontSize: def.fontSize || null,
                areaFontSize: def.areaFontSize || null,
                txtFontSize: def.txtFontSize || null
            };
        });
        
        
        $(".notify-container").html('').css("background-color", 'rgba(0, 0, 0, 0.0)');
        $(".notify-container").css({
            left: "",
            right: "0%",
            top: "15%",
            bottom: "",
            width: "15%",
            height: "max-content",
            overflow: "hidden"
        });  
        homeSettingsData = {};
        $.each(mainHuds, function (_, hud) {
            homeSettingsData[hud] = 1;
        });
    
        hudColorData = {};

        $.each(mainHuds, function (_, hud) {
            const id = `#${hud.slice(1)}`;
            const progressSelector = hud + ' .progress-bar-img';
            const iconSelector = hud + ' .core-img';
        
            const progressElement = $(progressSelector);
            const iconElement = $(iconSelector);
        
            const progressColor = currentHudColorData[`${id}-meter`] || "#ffffff";
            const iconColor = currentHudColorData[`${id}-core`] || "#ffffff";
        
            hudColorData[`${id}-meter`] = progressColor;
            hudColorData[`${id}-core`] = iconColor;
        
            progressElement.attr('data-original-color', progressColor);
            iconElement.attr('data-original-color', iconColor);
        });
        
    
        $(".ui-panel").hide();
    
        const allHuds = editHuds.concat(mainHuds);

        allHuds.forEach(function (hudClass) {
            $(hudClass).removeClass('change-positionactive');
            const progress = $(hudClass + ' .progress-bar-img');
            const icon = $(hudClass + ' .core-img');
    
            resetColorFilter(progress);
            resetColorFilter(icon);
    
            progress.css({
                'filter': 'none',
                'overflow': 'visible'
            }).removeAttr('data-color data-filter-id');
    
            icon.css({
                'filter': 'none',
                'overflow': 'visible'
            }).removeAttr('data-color data-filter-id');
        });
    
        $.post(`https://${GetParentResourceName()}/close`, JSON.stringify({
            currentHudPositionData: {},
            homeSettingsData: {},
            hudColorData: {}
        }));        

        onEditMenu = false;

        onloadFunc({
            currentHudPositionData: {},
            homeSettingsData: {},
            hudColorData: {}
        });

    }
    
    
    $(".showvoicerange").hide();
    $(".ui-panel").hide()
    for (key in currentHudData) {
        $(key).hide()
    }
    $(".cash").hide();
    $(".locations").hide();
    $(".gold").hide();
    $(".id").hide();
    $(".level").hide();
    $(".hour").hide()

    function fadeToggle($el, show) {
        if (!$el || $el.length === 0) return;
        if (show) $el.show();
        else $el.hide();
    }
    
    function handleVisibility(divname, value, autohide, onHorse, noAutoHideDivs, horseDivs) {
        const $el = $(divname);
        const userEnabled = homeSettingsData[divname] === 1;
    
        let shouldShow = false;
        if (autohide) {
            if (noAutoHideDivs.includes(divname)) shouldShow = true;
            else if (horseDivs.includes(divname)) shouldShow = onHorse && userEnabled && value > 0;
            else shouldShow = userEnabled && (value > 0 || divname === ".temp");
        } else {
            shouldShow = userEnabled && (!horseDivs.includes(divname) || onHorse);
        }
    
        fadeToggle($el, shouldShow);
    
        if (divname === ".temp")  fadeToggle($(".temp-value"),  userEnabled && shouldShow);
        if (divname === ".level") fadeToggle($(".level-value"), userEnabled && shouldShow);
    }
    
    function handleCoreAnimations(divname, currentValue, newValue, hudData) {
        const animatedElements = [".health", ".stamina", ".horse-health", ".horse-stamina", ".hunger", ".thirst", ".alcohol"];
    
        if (!animatedElements.includes(divname)) return;
    
        const isGold = (key1, key2) => hudData[key1] || hudData[key2];
        const gold = {
            '.health': isGold('HealthOuterOverpowered', 'HealthCoreOverpowered'),
            '.stamina': isGold('StaminaOuterOverpowered', 'StaminaCoreOverpowered'),
            '.horse-health': isGold('HorseHealthOuterOverpowered', 'HorseHealthCoreOverpowered'),
            '.horse-stamina': isGold('HorseStaminaOuterOverpowered', 'HorseStaminaCoreOverpowered')
        };
    
        const delta = newValue - currentValue;
        const animationType = gold[divname] ? "pulseGold" : (delta === 0 ? "" : delta > 0 ? "+" : "-");
    
        if (delta === 0) {
            StopAnimation(divname);
        } else {
            StartAnimation(divname, animationType);
            if (Math.abs(delta) > 5) {
                usedItemChange(divname, Math.abs(delta).toFixed(0));
            }
        }
    }    
    function calculateColorGradient(value, colorStops) {
        // Threshold sıralamasını küçükten büyüğe sırala
        colorStops = [...colorStops].sort((a, b) => a.threshold - b.threshold);
    
        for (let i = 0; i < colorStops.length - 1; i++) {
            const current = colorStops[i];
            const next = colorStops[i + 1];
    
            if (value >= current.threshold && value <= next.threshold) {
                const range = next.threshold - current.threshold;
                const t = (value - current.threshold) / range;
    
                return {
                    r: Math.round(current.r + t * (next.r - current.r)),
                    g: Math.round(current.g + t * (next.g - current.g)),
                    b: Math.round(current.b + t * (next.b - current.b)),
                };
            }
        }
    
        // Değer belirtilen aralığın dışında ise en yakın renk değerini döndür
        if (value < colorStops[0].threshold) {
            return {
                r: colorStops[0].r,
                g: colorStops[0].g,
                b: colorStops[0].b,
            };
        } else {
            const last = colorStops[colorStops.length - 1];
            return {
                r: last.r,
                g: last.g,
                b: last.b,
            };
        }
    }
    
    const tempFilterCache = {}; 

    function handleTemperatureHud(divname, value, hudData) {
        const tempData = hudData["TempData"];
        if (!tempData || !tempData.Colors?.cold || !tempData.Colors?.hot) return;
    
        const coldConfig = tempData.Colors.cold;
        const hotConfig = tempData.Colors.hot;
    
        const tempImgSelectors = [".temp #temp-core", ".temp2 #temp-core"];
        const tempCoreSelectors = [".temp .core-img", ".temp2 .core-img"];
    
        let targetImage = "/ui/assets/img/rpg_hot.png";
        let filterColor = null;
    
        if (tempData.imgColorChangeOnValue) {
            if (value <= coldConfig.valueRange[0] && value >= coldConfig.valueRange[1]) {
                targetImage = "/ui/assets/img/rpg_cold.png";
                filterColor = calculateColorGradient(value, coldConfig.colors);
            } else if (value >= hotConfig.valueRange[0] && value <= hotConfig.valueRange[1]) {
                targetImage = "/ui/assets/img/rpg_hot.png";
                filterColor = calculateColorGradient(value, hotConfig.colors);
            }
    
            tempImgSelectors.forEach(sel => {
                const el = $(sel);
                if (el.attr("src") !== targetImage) {
                    el.attr("src", targetImage);
                }
            });
    
            if (filterColor) {
                tempCoreSelectors.forEach(sel => {
                    const el = $(sel)[0];
                    const previous = tempFilterCache[sel];
    
                    const hasChanged = !previous ||
                        filterColor.r !== previous.r ||
                        filterColor.g !== previous.g ||
                        filterColor.b !== previous.b;
    
                    if (hasChanged) {
                        resetColorFilter($(el));
                        applyColorFilter(sel, filterColor);
                        tempFilterCache[sel] = { ...filterColor };
                        $(el).attr("data-color", rgbToHex(filterColor));
                    }
                });
            }
        } else {
            if (value <= coldConfig.valueRange[0] && value >= coldConfig.valueRange[1]) {
                targetImage = "/ui/assets/img/rpg_cold.png";
            } else if (value >= hotConfig.valueRange[0] && value <= hotConfig.valueRange[1]) {
                targetImage = "/ui/assets/img/rpg_hot.png";
            }
    
            tempImgSelectors.forEach(sel => {
                const el = $(sel);
                if (el.attr("src") !== targetImage) {
                    el.attr("src", targetImage);
                }
            });
        }
    
        const newText = `${value.toFixed(1)}°`;
        $(".temp-value").each(function () {
            if ($(this).text() !== newText) {
                $(this).text(newText);
            }
        });
    
        const $temp = $('.temp');
        const $value = $('.temp-value');
        let leftOffset = 35;
        let topOffset = 18;
    
        if ($temp.length && $value.length) {
            const rect = $temp[0].getBoundingClientRect();
            $value.css({
                position: 'absolute',
                top: `${rect.top + window.scrollY - topOffset}px`,
                left: `${rect.left + window.scrollX + leftOffset}px`,
                zIndex: 5
            });
        }
    
        const $level = $('.level');
        const $levelValue = $('.level-value');
        if ($level.length && $levelValue.length) {
            const rect = $level[0].getBoundingClientRect();
            $levelValue.css({
                position: 'absolute',
                top: `${rect.top + window.scrollY - topOffset}px`,
                left: `${rect.left + window.scrollX + leftOffset}px`,
                zIndex: 5
            });
        }
    }
    
    
    var previousValues = {};
    function getHudGroupBySelector(selector) {
        for (const [groupKey, selectors] of Object.entries(hudGroups)) {
            if (selectors.includes(selector)) {
                return groupKey;
            }
        }
        return null;
    }
    function setProgress(divname, value, autohide, hudData = {}, onHorse = false) {

        const groupKey = getHudGroupBySelector(divname);
    
        if (groupKey && defaultHudCheckedData[groupKey] === true) {
            hudGroups[groupKey].forEach(sel => $(sel).hide());
            return;
        }
    
        if (hudHide) return;
    
        if (!onEditMenu && homeSettingsData[divname] === 0) {
            $(divname).hide();
    
            if (divname === ".temp") $(".temp-value").hide();
            if (divname === ".level") $(".level-value").hide();
    
            currentHudData[divname] = value;
            return;
        }
    
        if (onEditMenu) {
    
            for (const [group, selectors] of Object.entries(hudGroups)) {
    
                if (defaultHudCheckedData[group] === true) {
                    selectors.forEach(sel => $(sel).hide());
                    continue;
                }
    
                selectors.forEach(sel => {
                    const isUserHidden = homeSettingsData[sel] === 0;
    
                    if (!isUserHidden) {
                        $(sel).show();
                    } else {
                        $(sel).hide();
                    }
                });
            }
    
            const statsToCheck = {
                "#cash": defaultHudCheckedData.cash,
                "#gold": defaultHudCheckedData.gold,
                "#hour": defaultHudCheckedData.hour,
                "#id": defaultHudCheckedData.id,
                ".locations2": defaultHudCheckedData.locations,
            };
    
            for (const selector in statsToCheck) {
                if (statsToCheck[selector]) {
                    $(selector).hide();
                } else {
                    $(selector).show();
                }
            }
    
            if (
                [".health-core", ".stamina-core", ".horse-core-health", ".horse-core-stamina"].includes(divname)
            ) {
                value = 50;
            } else if (divname !== ".temp") {
                value = 100;
            }
        }
    
        const currentValue = currentHudData[divname];
    
        const noAutoHideDivs = [".health", ".stamina", ".hunger", ".thirst", ".temp", ".pvp"];
        const onlyOnHorseDivs = [".horse-dirty", ".horse-health", ".horse-stamina", ".horse-core-health", ".horse-core-stamina"];
    
        if (!onEditMenu) {
            if (onlyOnHorseDivs.includes(divname) && !onHorse) {
                $(divname).hide();
            } else {
                handleVisibility(divname, value, autohide, onHorse, noAutoHideDivs, onlyOnHorseDivs);
            }
        }
    
        if (!onEditMenu) {
            applyGoldCoreFilters(hudData);
        }
    
        if (divname === ".temp") {
            handleTemperatureHud(divname, value, hudData);
        }
    
        if (divname === ".armour" && hudData['maxArmour']) {
            const max = hudData['maxArmour'];

            if (onEditMenu) {
                value = 100;
            } else {
                value = Math.min(Math.max((value / max) * 100, 0), 100);
            }
        }

        if (!onEditMenu) {
            const coreOverpowerMap = {
                ".health-core":        hudData.HealthCoreOverpowered,
                ".health":             hudData.HealthOuterOverpowered,
                ".stamina-core":       hudData.StaminaCoreOverpowered,
                ".stamina":            hudData.StaminaOuterOverpowered,
                ".horse-core-health":  hudData.HorseHealthCoreOverpowered,
                ".horse-health":       hudData.HorseHealthOuterOverpowered,
                ".horse-core-stamina": hudData.HorseStaminaCoreOverpowered,
                ".horse-stamina":      hudData.HorseStaminaOuterOverpowered,
            };
            if (coreOverpowerMap[divname]) value = 100;
        }

        handleCoreAnimations(divname, currentValue, value, hudData);
        updateProgressMeter(divname, value);
    
        if (
            [".health-core", ".stamina-core", ".horse-core-health", ".horse-core-stamina", ".hunger", ".thirst"]
                .includes(divname)
        ) {
            updateCoreImages(divname, value, onHorse);
        }
    
        previousValues[divname] = value;
        currentHudData[divname] = value;
    }
    
    function closeAllSettings() {
        $(".color-cont").hide();
        $(".home-cont").hide();
        $(".sizing-cont").hide();
    }

    $("#home-btn").on("click", function () {
        closeAllSettings();
        $("#hud-settings-title").html(LocaleText.hometitle);  
        $(".home-cont").css('display', 'flex').css('opacity', '0').fadeTo(500, 1);
    });
    
    $("#hud-color-btn").on("click", function () {
        closeAllSettings();
        $("#hud-settings-title").html(LocaleText.coloringtitle); 
        $(".color-cont").css('display', 'flex').css('opacity', '0').fadeTo(500, 1);
    });
    
    $("#hud-size-btn").on("click", function () {
        closeAllSettings();
        $("#hud-settings-title").html(LocaleText.resizingtitle); 
        $(".sizing-cont").css('display', 'flex').css('opacity', '0').fadeTo(500, 1);
    });
    
    $(".stat-box").on("click", function () {
        const id = $(this).attr("id");
        if (!id) return;
    
        const $target = $(".hud-prewiev #" + id);
    
        if ($target.hasClass("activehud")) {
            $target.removeClass("activehud");
            selectHud = null;
            $('.checkbox').prop('checked', false); 
        } else {
            $(".hud-prewiev .activehud").removeClass("activehud");
            $target.addClass("activehud");
    
            selectHud = "." + id; 
    
            const hudWithoutNumber = selectHud.replace(/2$/, '').replace('.hud-prewiev ', '');
            const isEnabled = homeSettingsData[hudWithoutNumber] === 1 || typeof homeSettingsData[hudWithoutNumber] === "undefined";
    
            $('.checkbox').prop('checked', isEnabled); 
        }
    });
    $(".locations2").on("click", function () {
        const target = $(".locations2");
    
        if (target.hasClass("activehud")) {
            target.removeClass("activehud");
            selectHud = null;
            $('.checkbox').prop('checked', false); 
        } else {
            $(".hud-prewiev .activehud").removeClass("activehud");
            target.addClass("activehud");
    
            selectHud = ".locations"; // ✅ string olarak atama yapıyoruz
    
            const isEnabled = homeSettingsData[".locations"] === 1 || typeof homeSettingsData[".locations"] === "undefined";
            $('.checkbox').prop('checked', isEnabled); 
        }
    });    
    
    $(".select-all-hud").on("click", function() {
        if ($(this)[0].classList.contains("select-all-hudactive")) {
            $(this)[0].classList.remove("select-all-hudactive");
            selectAllHud = false;
        } else {
            $(this)[0].classList.add("select-all-hudactive");
            selectAllHud = true;
        }
    
        if (selectAllHud) {
            editHuds.forEach(function(hud) {
                $(hud).addClass("activehud");
            });
        } else {
            $(".activehud").removeClass("activehud");
            selectHud = null; 
        }
    });
    
    $('#colorbox1').on('click', function () {
        if ($(this).hasClass('selectcolortypeactive')) {
            $(this).removeClass('selectcolortypeactive');
            progressSelected = false;
        } else {
            $(this).addClass('selectcolortypeactive');
            progressSelected = true;
            iconSelected = false; 
            $('#colorbox2').removeClass('selectcolortypeactive'); 
        }
    });
    
    $('#colorbox2').on('click', function () {
        if ($(this).hasClass('selectcolortypeactive')) {
            $(this).removeClass('selectcolortypeactive');
            iconSelected = false;
        } else {
            $(this).addClass('selectcolortypeactive');
            iconSelected = true;
            progressSelected = false; 
            $('#colorbox1').removeClass('selectcolortypeactive'); 
        }
    });
    
    function updateWidthModeSettings() {
        if (changeHudWidhtType) {
            // sadece aralığı ayarla, değeri resetleme
            $('#hud-width').attr({ min: 1.8, max: 4.0, step: 0.1 });
        } else if (changeStatWidhtType) {
            $('#hud-width').attr({ min: 0.5, max: 2.5, step: 0.1 });
        } else {
            $('#hud-width').attr({ min: 1.8, max: 4.0 });
        }
    
        // seçilen HUD varsa onun mevcut width değerini slider’a yansıt
        if (selectHud) {
            const currentWidth = $(selectHud).css("width");
            if (currentWidth) {
                $('#hud-width').val(parseFloat(currentWidth)).trigger('input');
                $('#width-value').val(parseFloat(currentWidth));
            }
        }
    }
    
    
    $('#changehud-widht').on('click', function () {
        if ($(this).hasClass('selectwidht-typeactive')) {
            $(this).removeClass('selectwidht-typeactive');
            changeHudWidhtType = false;
        } else {
            $(this).addClass('selectwidht-typeactive');
            changeHudWidhtType = true;
            changeStatWidhtType = false;
            $('#changestat-widht').removeClass('selectwidht-typeactive');
        }
        updateWidthModeSettings();
    });
    
    $('#changestat-widht').on('click', function () {
        if ($(this).hasClass('selectwidht-typeactive')) {
            $(this).removeClass('selectwidht-typeactive');
            changeStatWidhtType = false;
        } else {
            $(this).addClass('selectwidht-typeactive');
            changeStatWidhtType = true;
            changeHudWidhtType = false;
            $('#changehud-widht').removeClass('selectwidht-typeactive');
        }
        updateWidthModeSettings();
    });
    

    const skipInSelectAll = [".cash", ".gold", ".hour", ".id", ".locations2"];

    editHuds.forEach(function (hud) {
        $(hud).on("click", function () {
            const hudWithoutNumber = hud.replace(/^\.hud-prewiev\s*/, '');

            // Select-all açıkken bu HUD'lar tıklanamaz
            if (selectAllHud && skipInSelectAll.includes(hud)) {
                return;
            }
    
            // Select-all kapatılıyor
            if (selectAllHud) {
                $(".select-all-hud").removeClass("select-all-hudactive");
                selectAllHud = false;
            }
    
            // Önceki aktifleri temizle
            $(".activehud").removeClass("activehud");
    
            // Eğer bu HUD özel listedeyse activehud class ekleme
            if (!skipInSelectAll.includes(hud)) {
                $(this).addClass("activehud");
            }
    
            selectHud = hud;
    
            if (typeof homeSettingsData[hudWithoutNumber] === 'undefined') {
                homeSettingsData[hudWithoutNumber] = 1;
            }
    
            $('.checkbox').prop('checked', homeSettingsData[hudWithoutNumber] === 1);
        });
    });
    
    $(".checkbox").on("change", function () {
        if (selectHud) {
            const hudWithoutNumber = selectHud.replace(/2$/, '').replace('.hud-prewiev ', '');
    
            if ($(this).is(":checked")) {
                homeSettingsData[hudWithoutNumber] = 1;
                $(hudWithoutNumber).show();
            
                if (hudWithoutNumber === ".temp") $(".temp-value").show();
                if (hudWithoutNumber === ".level") $(".level-value").show();
            } else {
                homeSettingsData[hudWithoutNumber] = 0;
                $(hudWithoutNumber).hide();
            
                if (hudWithoutNumber === ".temp") $(".temp-value").hide();
                if (hudWithoutNumber === ".level") $(".level-value").hide();
            }            
        } else {
            console.log("No HUD selected.");
        }
    });
    
    for (const hudClass in hudLabelMap) {
        $("." + hudClass).on("mouseenter", function () {
            $("#title-huds").text(hudLabelMap[hudClass]);
        }).on("mouseleave", function () {
            $("#title-huds").text((LocaleText && LocaleText.ui_huds_title) || "HUDS");
        });
    }

    
    var huds = [
        ".horse-stamina",
        ".horse-health",
        ".horse-dirty",
        ".dirty",
        ".stress",
        ".armour",
        ".pvp",
        ".thirst",
        ".hunger",
        ".alcohol",
        ".stamina",
        ".health",
        ".microphone",
        ".temp",
        ".onesync",
        ".level",

        ".cash",
        ".locations",
        ".id",
        ".gold",
        ".hour",
        ".notify-container"
    ];
    
    function enableDraggable() {
        huds.forEach(function (key) {
          $(key).css({ border: '1px dashed white' });
      
          let clickDelta = { x: 0, y: 0 };
      
          $(key).draggable({
            helper: "original",
            containment: 'parent',
            scroll: false,
      
            start: function (e, ui) {
              const $el = $(this);
              const parentOff = $el.parent().offset();
              const elOff     = $el.offset();
      
              clickDelta.x = e.pageX - elOff.left;
              clickDelta.y = e.pageY - elOff.top;
      
              const left = elOff.left - parentOff.left;
              const top  = elOff.top  - parentOff.top;
      
              $el.css({ position: 'absolute', left: left, top: top });
      
              ui.position.left = left;
              ui.position.top  = top;
              ui.offset.left   = parentOff.left + left;
              ui.offset.top    = parentOff.top  + top;
      
              $el.draggable('option', 'cursorAt', { left: clickDelta.x, top: clickDelta.y });
            },
      
            drag: function (e, ui) {
              const parentOff = $(this).parent().offset();
              ui.position.left = e.pageX - parentOff.left - clickDelta.x;
              ui.position.top  = e.pageY - parentOff.top  - clickDelta.y;
            },
      
            stop: function (e, ui) {
              HudPositionDatas[key] = HudPositionDatas[key] || {};
              HudPositionDatas[key].left = ui.position.left + "px";
              HudPositionDatas[key].top  = ui.position.top  + "px";
              HudPositionDatas[key].position = 'absolute';
            }
          });
        });
    }
      
    
    function disableDraggable() {
        huds.forEach(function(key) {
            if ($(key).data("ui-draggable")) {
                $(key).draggable('destroy');
            }
    
            $(key).css({
                'border': 'none'
            });
        });
    }
    
    $('#change-position').off('click');
    $('#change-position').on('click', function () {
        const $grid = $('.grid-overlay');
    
        if ($(this).hasClass('change-positionactive')) {
            disableDraggable();
            $(this).removeClass('change-positionactive');
    
            // Fade-out + display:none
            $grid.removeClass('active');
            setTimeout(() => $grid.hide(), 250); 
        } else {
            enableDraggable();
            $(this).addClass('change-positionactive');
    
            $grid.show(0, () => $grid.addClass('active'));
        }
    });
    
    
    $("#default-settings").on("click", function () {
        resetHudData()
    })

    function applyLocaleTexts() {
        var L = LocaleText || {};

        // Navbar section titles
        $("#hud-settings-title").html(L.hometitle         || "SETTING");

        // Home tab buttons
        $("#default-settings").text(L.ui_default_settings  || "DEFAULT SETTINGS");
        $("#change-position").text(L.ui_change_position    || "CHANGE POSITION");

        // Resize tab selectors
        $("#changehud-widht").text(L.ui_huds_tab           || "HUDS");
        $("#changestat-widht").text(L.ui_stats_tab         || "STATS");
        $(".onofftitle").text(L.ui_hide_show               || "HIDE/SHOW");

        // Color tab selectors
        $("#colorbox1").text(L.ui_progress                 || "PROGRESS");
        $("#colorbox2").text(L.ui_icon                     || "ICON");

        // Preview section titles
        $("#title-huds").text(L.ui_huds_title              || "HUDS");
        $(".select-all-hud").text(L.ui_select_all          || "SELECT ALL");
        $("#title-stat").text(L.ui_stats_title             || "STATS");

        // Description
        $(".container-description p").text(L.ui_description       || "");
        $(".container-description li:first-child").text(L.ui_description_step1 || "");

        // HUD label map — hover labels on preview
        if (L.hud_health)        hudLabelMap["health2"]       = L.hud_health;
        if (L.hud_stamina)       hudLabelMap["stamina2"]      = L.hud_stamina;
        if (L.hud_hunger)        hudLabelMap["hunger2"]       = L.hud_hunger;
        if (L.hud_thirst)        hudLabelMap["thirst2"]       = L.hud_thirst;
        if (L.hud_stress)        hudLabelMap["stress2"]       = L.hud_stress;
        if (L.hud_pvp)           hudLabelMap["pvp2"]          = L.hud_pvp;
        if (L.hud_armour)        hudLabelMap["armour2"]       = L.hud_armour;
        if (L.hud_dirty)         hudLabelMap["dirty2"]        = L.hud_dirty;
        if (L.hud_microphone)    hudLabelMap["microphone2"]   = L.hud_microphone;
        if (L.hud_temp)          hudLabelMap["temp2"]         = L.hud_temp;
        if (L.hud_onesync)       hudLabelMap["onesync2"]      = L.hud_onesync;
        if (L.hud_alcohol)       hudLabelMap["alcohol2"]      = L.hud_alcohol;
        if (L.hud_horse_health)  hudLabelMap["horse-health2"] = L.hud_horse_health;
        if (L.hud_horse_stamina) hudLabelMap["horse-stamina2"]= L.hud_horse_stamina;
        if (L.hud_horse_dirty)   hudLabelMap["horse-dirty2"]  = L.hud_horse_dirty;
        if (L.hud_level)         hudLabelMap["level2"]        = L.hud_level;
    }

    function onloadFunc(data) {

        const isEmptyLoad = !data.currentHudPositionData || Object.keys(data.currentHudPositionData).length === 0;

        hudInitialized = true;
        onPlayerLoaded = false;
    
        if (isEmptyLoad) {
            hudColorData = currentHudColorData;
    
            Object.keys(currentHudPositionData).forEach(hud => {
                const def = currentHudPositionData[hud] || {};
    
                const cssPosition = {
                    position: def.position || "absolute",
                    width: def.width || "2.3%",
                    height: def.height || "2.3%"
                };
    
                if (def.display !== undefined) cssPosition.display = def.display;
                if (def.top !== undefined) cssPosition.top = def.top;
                if (def.left !== undefined) cssPosition.left = def.left;
                if (def.right !== undefined) cssPosition.right = def.right;
                if (def.bottom !== undefined) cssPosition.bottom = def.bottom;
    
                $(hud).css(cssPosition);
    
                if (def.fontSize) {
                    $(hud).find(".id-text, .hour-text, .gold-value, .cash-value").css("font-size", def.fontSize);
                }
    
                if (hud === ".locations") {
                    if (def.fontSize) $(".locations").css("font-size", def.fontSize);
                    if (def.areaFontSize) $(".locations-area").css("font-size", def.areaFontSize);
                    if (def.txtFontSize) $(".locations-txt").css("font-size", def.txtFontSize);
                }
    
                HudPositionDatas[hud] = {
                    top: def.top || null,
                    left: def.left || null,
                    right: def.right || null,
                    bottom: def.bottom || null,
                    position: def.position || null,
                    width: def.width || null,
                    height: def.height || null,
                    display: def.display || null,
                    fontSize: def.fontSize || null,
                    areaFontSize: def.areaFontSize || null,
                    txtFontSize: def.txtFontSize || null
                };
            });
    
        } else {
    
            currentHudPositionData = data.currentHudPositionData || {};
            homeSettingsData = data.homeSettingsData || {};
            hudColorData = data.hudColorData || {};
    
            Object.keys(currentHudPositionData).forEach(hud => {
                const position = currentHudPositionData[hud] || {};
    
                const cssPosition = {
                    position: position.position || "absolute",
                    width: position.width,
                    height: position.height
                };
    
                if (position.top !== undefined) cssPosition.top = position.top;
                if (position.left !== undefined) cssPosition.left = position.left;
                if (position.right !== undefined) cssPosition.right = position.right;
                if (position.bottom !== undefined) cssPosition.bottom = position.bottom;
                if (position.display !== undefined) cssPosition.display = position.display;
    
                $(hud).css(cssPosition);
    
                if (position.fontSize) {
                    $(hud).find(".id-text, .hour-text, .gold-value, .cash-value").css("font-size", position.fontSize);
                }
    
                if (hud === ".locations") {
                    if (position.fontSize) $(".locations").css("font-size", position.fontSize);
                    if (position.areaFontSize) $(".locations-area").css("font-size", position.areaFontSize);
                    if (position.txtFontSize) $(".locations-txt").css("font-size", position.txtFontSize);
                }
    
                HudPositionDatas[hud] = {
                    top: position.top || null,
                    left: position.left || null,
                    right: position.right || null,
                    bottom: position.bottom || null,
                    position: cssPosition.position || null,
                    width: position.width || null,
                    height: position.height || null,
                    display: position.display || null,
                    fontSize: position.fontSize || null,
                    areaFontSize: position.areaFontSize || null,
                    txtFontSize: position.txtFontSize || null
                };
            });
        }
    
        $(".cash, .locations, .gold, .id, .level, .hour").show();
    
        $.each(homeSettingsData, function (key, value) {
            if (value === 1 || value === undefined) $(key).show();
            else $(key).hide();
        });
    
        var allHuds = editHuds.concat(mainHuds);
        var delay = 150;
    
        // 🔥 TOTAL LOAD TIME
        var totalDelay = allHuds.length * delay;
    
        allHuds.forEach(function (hudClass, index) {
    
            setTimeout(function () {
    
                const className = hudClass.replace('.', '');
                const baseName = className.replace(/\d+$/, '');
    
                const progressSelector = hudClass + ' .progress-bar-img';
                const iconSelector = hudClass + ' .core-img';
    
                const progressElement = $(progressSelector);
                const iconElement = $(iconSelector);
    
                const progressId = `#${baseName}-meter`;
                const iconId = `#${baseName}-core`;
    
                const progressColor = hudColorData[progressId] || "#ffffff";
                const iconColor = hudColorData[iconId] || "#ffffff";
    
                if (progressColor && progressColor !== 'none') {
                    const progressRGB = hexToRGB(progressColor);
    
                    if (progressElement.length) {
                        progressElement.fadeOut(100);
    
                        if (!progressElement.attr('data-original-color')) {
                            const defaultColor = currentHudColorData?.[progressId] || "#ffffff";
                            progressElement.attr('data-original-color', defaultColor);
                        }
    
                        applyColorFilter(progressSelector, progressRGB);
                        progressElement.attr('data-color', progressColor);
    
                        progressElement.fadeIn(200);
                    }
                }
    
                if ((baseName !== 'temp' && baseName !== 'temp2') && iconColor && iconColor !== 'none') {
    
                    const iconRGB = hexToRGB(iconColor);
    
                    if (iconElement.length) {
                        iconElement.fadeOut(100);
    
                        if (!iconElement.attr('data-original-color')) {
                            const defaultColor = currentHudColorData?.[iconId] || "#ffffff";
                            iconElement.attr('data-original-color', defaultColor);
                        }
    
                        applyColorFilter(iconSelector, iconRGB);
                        iconElement.attr('data-color', iconColor);
    
                        iconElement.fadeIn(200);
                    }
                }
    
            }, index * delay);
        });
    
        // 🔥 CRITICAL FIX → ALL HUDS FINISHED
        setTimeout(() => {
            onPlayerLoaded = true;
        }, totalDelay + 50);
    }
    
    
    function getText(text) {
        var colors = {
            "~e~": "#FF0000",    // Red
            "~o~": "#FFFF00",    // Yellow
            "~d~": "#FFA500",    // Orange
            "~m~": "#808080",    // Grey
            "~q~": "#FFFFFF",    // White
            "~t~": "#D3D3D3",    // Light Grey
            "~v~": "#000000",    // Black
            "~u~": "#FFC0CB",    // Pink
            "~pa~": "#0000FF",   // Blue
            "~t1~": "#800080",   // Purple
            "~t2~": "#FFA500",   // Orange
            "~t3~": "#ADD8E6",   // Light Blue
            "~t4~": "#FFFF00",   // Yellow
            "~t5~": "#FFB6C1",   // Light Pink
            "~t6~": "#008000",   // Green
            "~t7~": "#00008B",   // Dark Blue
            "~t8~": "#FF6961"    // Light RedIsh
        };
        text = text.replace(/~n~/g, '<br>');
        text = text.replace(/~italic~/g, '<span style="font-style: italic;">');
        text = text.replace(/~\/italic~/g, '</span>');
        text = text.replace(/~bold~/g, '<span style="font-weight: bold;">');
        text = text.replace(/~\/bold~/g, '</span>');
        for (var key in colors) {
            if (colors.hasOwnProperty(key)) {
                var regex = new RegExp(key, "g");
     
                text = text.replace(regex, '<span style="color:' + colors[key] + ';">');
            }
        }
        text = text.replace(/~.*?~/g, '</span>');
        return text;
    }
    

    function showNotify(text, type, time) {

        const labels = {
            success:  (LocaleText && LocaleText.notify_success)  || "SUCCESS",
            error:    (LocaleText && LocaleText.notify_error)    || "ERROR",
            info:     (LocaleText && LocaleText.notify_info)     || "INFO",
            warning:  (LocaleText && LocaleText.notify_warning)  || "WARNING",
            announce: (LocaleText && LocaleText.notify_announce) || "ANNOUNCE",
        };
        let typetext = labels[type] || type;
    
        let imgSrc = `/ui/assets/img/${type}.png`; 
        let soundType = type === "announce" ? "success" : type;
    
        var newText = getText(text);
        const randomNumber = Math.floor(Math.random() * 10000) + 1;
    
        let imgStyle = "";
        if (type === "announce") {
            imgStyle = `style="animation: spin 3s linear infinite; transform-origin: center center;"`;
        }
    
        $(".notify-container").append(`
            <div class="notify ${type} id${randomNumber}" style="display: none;">
                <img id="notify-img" src="${imgSrc}" alt="${type}" ${imgStyle}/>
                <span class="notify-title">${typetext}</span>
                <div class="notify-bar" role="progressbar" aria-valuenow="75" aria-valuemin="0" aria-valuemax="100"></div>
                <span class="notify-desc">${newText}</span>
            </div>
        `);
    
        $(".notify-container").show();
        $(`.id${randomNumber}`).fadeIn();
    
        let audio = new Audio(`/ui/assets/sounds/${soundType}.mp3`);
        audio.volume = 0.05;
        audio.play().catch(e => {});
    
        var remainingTime = time;
    
        function updateProgressBar() {
            let val = (remainingTime / time) * 100;
            $(`.id${randomNumber} .notify-bar`).css({
                'background': `radial-gradient(closest-side, rgb(0, 0, 0) 79%, transparent 80% 100%), conic-gradient(rgb(255, 255, 255) ${val}%, rgba(37, 37, 37, 0.0) 0)`
            });
        }
    
        const timer = setInterval(() => {
            remainingTime -= 10;
            updateProgressBar();
            if (remainingTime <= 0) {
                $(`.id${randomNumber}`).fadeOut();
                setTimeout(function () {
                    $(`.id${randomNumber}`).remove();
                }, 2000);
                clearInterval(timer);
            }
        }, 10);
    }
    
    // keep one demo progress timer & current notify id
    let notifyProgressTimer = null;
    let activeNotifyId = null;

    function openUIPanel() {
        onEditMenu = true;
        syncHudColors(editHuds, mainHuds);
    
        const keyMap = {
            ".id": "id",
            ".cash": "cash",
            ".gold": "gold",
            ".hour": "hour",
            ".locations": "locations",
            ".locations2": "locations"
        };
    
        for (let key in homeSettingsData) {
            const settingKey = key;
            const pureKey = settingKey.replace(/^\./, "");
            const mappedKey = keyMap[settingKey] || pureKey;
    
            if (defaultHudCheckedData[mappedKey] === true) {
    
                // MAIN HUD
                $(settingKey).stop(true, true).hide();
    
                // PREVIEW HUD (güvenli selector)
                const previewSelector = `.hud-prewiev ${settingKey}2`;
                $(previewSelector).stop(true, true).hide();
    
                // Checkbox disable
                $(`.checkbox[data-hud="${settingKey}"]`)
                    .prop("disabled", true)
                    .prop("checked", false);
    
                continue;
            }
    
            const enabled = (homeSettingsData[settingKey] === 1 || homeSettingsData[settingKey] === undefined);
            homeSettingsData[settingKey] = enabled ? 1 : 0;
    
            $(settingKey).stop(true, true);
    
            $(`.checkbox[data-hud="${settingKey}"]`)
                .prop("checked", enabled)
                .prop("disabled", false);
        }
    
        $(".ui-panel").stop(true, true).show();
        $(".notify-container").css("background-color", "rgba(38, 39, 41, 0.55)").show();
    
        if (activeNotifyId) {
            $(`.${activeNotifyId}`).remove();
            activeNotifyId = null;
        }
    
        const notifyId = `notify-${Math.floor(Math.random() * 10000)}`;
        activeNotifyId = notifyId;
    
        $(".notify-container").append(`
            <div class="notify ${notifyId}" style="display:none;">
                <img id="notify-img" src="./assets/img/info.png" alt="info">
                <span class="notify-title">INFO</span>
                <div class="notify-bar" role="progressbar"></div>
                <span class="notify-desc">You can change the location of this notification</span>
            </div>
        `);
    
        $(`.${notifyId}`).stop(true, true).fadeIn(200);
    
        if (notifyProgressTimer) {
            clearInterval(notifyProgressTimer);
            notifyProgressTimer = null;
        }
    
        let direction = 1;
        let progress = 0;
    
        notifyProgressTimer = setInterval(() => {
            if (!activeNotifyId || $(`.${activeNotifyId}`).length === 0) {
                clearInterval(notifyProgressTimer);
                notifyProgressTimer = null;
                return;
            }
    
            progress += direction;
            if (progress >= 100) direction = -1;
            if (progress <= 0) direction = 1;
    
            $(`.${notifyId} .notify-bar`).css({
                background: `radial-gradient(closest-side, rgb(0,0,0) 79%, transparent 80% 100%), 
                             conic-gradient(rgb(255,255,255) ${progress}%, rgba(37,37,37,0.0) 0)`
            });
        }, 50);
    
        $(".ui-box").stop(true, true).fadeIn(300);
    }

    $(document).on('keyup', function (e) {
        if (e.key === "Escape" && onEditMenu) {
            disableDraggable();
            $(".ui-panel").stop(true, true).hide();
            $(".notify-container").empty().css("background-color", "rgba(0,0,0,0)");
            $(".ui-box").stop(true, true).hide();
            $('#change-position').removeClass('change-positionactive');
    
            const $grid = $('.grid-overlay');
            $grid.removeClass('active'); // fade-out
            setTimeout(() => $grid.hide(), 250); 
    
            syncHudColors(editHuds, mainHuds);
            onEditMenu = false;
        
            if (notifyProgressTimer) {
                clearInterval(notifyProgressTimer);
                notifyProgressTimer = null;
            }
            activeNotifyId = null;
        
            const ColorData = {};
        
            [...editHuds, ...mainHuds].forEach(hudClass => {
                const progress = $(`${hudClass} .progress-bar-img`);
                const icon = $(`${hudClass} .core-img`);
            
                const progressId = progress.attr('id');
                const iconId = icon.attr('id');
            
                const progressColor = progress.attr('data-color');
                const iconColor = icon.attr('data-color');
            
                if (progressId && progressColor) ColorData[`#${progressId}`] = progressColor;
                if (iconId && iconColor) ColorData[`#${iconId}`] = iconColor;
            
                if (!progress.attr('data-original-color')) progress.attr('data-original-color', '#ffffff');
                if (!icon.attr('data-original-color')) icon.attr('data-original-color', '#ffffff');
            });
        
            hudColorData = ColorData;
            $.post(`https://${GetParentResourceName()}/close`, JSON.stringify({
                currentHudPositionData: HudPositionDatas,
                homeSettingsData: homeSettingsData,
                hudColorData: ColorData
            }));
        }
    });
    
    const staticHuds = ["cash", "gold", "hour", "id", "locations"];
    function getShouldShow(divname, autohide, userEnabled, value) {
        const pureKey = divname.replace('.', '').replace('#', '');
        
        const noAutoHideDivs = [
            "health", "stamina", "hunger", "thirst", "temp", "pvp"
        ];
    
        const horseDivs = [
            "horse-dirty", "horse-health", "horse-stamina", "horse-core-health", "horse-core-stamina"
        ];
    
    
        if (defaultHudCheckedData[pureKey]) {
            return false;
        }
    
        if (staticHuds.includes(pureKey)) {
            return userEnabled;
        }
    
        if (horseDivs.includes(pureKey)) {
            if (!onHorse) return false;
            return userEnabled && value > 0;
        }
    
        if (autohide) {
            if (noAutoHideDivs.includes(pureKey)) {
                return userEnabled && (!horseDivs.includes(pureKey) || onHorse);
            }
            return userEnabled && value > 0;
        }
    
        return userEnabled && (!horseDivs.includes(pureKey) || onHorse);
    }
    
    
    function startCustomProgressBar(text, duration, callback) {
        $("#progressbar-text").text(text);
        $("#progress-fill").css({
            width: "0%",
            transition: "none"
        });
    
        $(".progress").fadeIn(300, () => {
            setTimeout(() => {
                $("#progress-fill").css({
                    transition: `width ${duration}ms linear`,
                    width: "100%"
                });
            }, 10);
        });
    
        setTimeout(() => {
            $(".progress").fadeOut(300);
            if (typeof callback === "function") callback();
        }, duration);
    }
    
    const hudGroups = {
        health: [".health", ".health2"],
        stamina: [".stamina", ".stamina2"],
        hunger: [".hunger", ".hunger2"],
        thirst: [".thirst", ".thirst2"],
        stress: [".stress", ".stress2"],
        pvp: [".pvp", ".pvp2"],
        armour: [".armour", ".armour2"],
        dirty: [".dirty", ".dirty2"],
        microphone: [".microphone", ".microphone2"],
        temp: [".temp", ".temp2", ".temp-value"],
        alcohol: [".alcohol", ".alcohol2"],
        onesync: [".onesync", ".onesync2"],
        level: [".level", ".level2", ".level-value"],
        horseHealth: [".horse-health", ".horse-health2"],
        horseStamina: [".horse-stamina", ".horse-stamina2"],
        horseDirty: [".horse-dirty", ".horse-dirty2"],
        cash: [".cash"],
        gold: [".gold"],
        hour: [".hour"],
        id: [".id"],
        locations: [".locations", ".locations2"]
    };
    
    window.addEventListener('message', function (event) {
        const data = event.data;

        switch (data.action) {
            case 'onPlayerLoaded':
                onloadFunc(data.settings);
                LocaleText = data.locale;
                applyLocaleTexts();
                break;
            case 'notify':
                showNotify(data.text, data.ntype, data.time);
                break;
            case 'openUIPanel':
                onEditMenu = true;
                openUIPanel();
                syncHudColors(mainHuds, editHuds);
                break;
            case 'hudtick':
                scheduleHudTick(data.huddata); 
                break;
                  
            case 'setFramework':
                const resolutionKey = `${window.innerWidth}x${window.innerHeight}`;
                const resolutionData = event.data.currentHudPositionData || {};
                const fallbackResolution = "1920x1080"; 
                
                defaultHudPositionData = resolutionData[resolutionKey] || resolutionData[fallbackResolution] || {};
                currentHudPositionData = { ...defaultHudPositionData }; 
                currentHudColorData = event.data.currentHudColorData
                if (event.data.framework === "RSG") {
                  ImgPath = "rsg-inventory/html/images/";
                } else if (event.data.framework === "VORP") {
                  ImgPath = "vorp_inventory/html/img/items/";
                }
                break;
            case 'ProgressBar':
                const imgSrc = `nui://${ImgPath}${data.item}.png`;
                const fallbackSrc = `nui://fx-hud/ui/assets/img/defaultimg.png`;

                const $img = $('#progressbar-img');
                $img.attr('src', imgSrc);

                $img.off('error').on('error', function () {
                    $(this).attr('src', fallbackSrc);
                });
            
                startCustomProgressBar(data.text, data.duration, function () {

                });
                break;
            case 'voicerange':
                var voiceValue = data.voicerange;
                var coord = data.coord;
                $(".voice-range").html(voiceValue);
                var leftStyle = `left: ${coord.x * 104}%;`;
                var topStyle = `top: ${coord.y * 76}%`;
                if (window._vrHideTimeout) clearTimeout(window._vrHideTimeout);
                $(".showvoicerange").stop(true, true).attr("style", leftStyle + topStyle).fadeIn(250);
                window._vrHideTimeout = setTimeout(function () {
                    $(".showvoicerange").stop(true).fadeOut(350);
                }, 1800);
                if (data.showPulse) {
                    var px = (coord.x * 104) + "%";
                    var py = (coord.y * 76) + "%";
                    var rings = $(".voice-pulse-ring");
                    rings.removeClass("pulse-1 pulse-2 pulse-3").hide();
                    void rings[0].offsetWidth;
                    rings.css({ left: px, top: py }).show();
                    $(rings[0]).addClass("pulse-1");
                    $(rings[1]).addClass("pulse-2");
                    $(rings[2]).addClass("pulse-3");
                    setTimeout(function() { rings.removeClass("pulse-1 pulse-2 pulse-3").hide(); }, 2000);
                }
                break;
            case 'updateXP':
                $(".level-value").html(`${data.level}`)
                $(".level-xp").html(`${data.xp}/${data.neededxp}`)
                var val = (data.xp / data.neededxp) * 100
                setProgress(".level", val, HudAutoHide)
                break;
            case 'setOther':
                if (data.id) {
                    $(".id-text").html(data.id)
                }

                if (data.gold !== undefined) {
                    var currentGold = Math.floor(parseFloat(data.gold) * 100) / 100
                    $(".gold-value").html(currentGold)
                }
                if (data.cash !== undefined) {
                    var currentCash = Math.floor(parseFloat(data.cash) * 100) / 100
                    $(".cash-value").html(currentCash)
                }
                if (data.time) {
                    $(".hour-text").html(data.time)
                }
                break;
            case 'hideHuds':
                defaultHudCheckedData = data.disabled || {};
                
                Object.entries(hudGroups).forEach(([key, selectors]) => {
                    if (defaultHudCheckedData[key]) {
                        selectors.forEach(sel => $(sel).hide());
                    }
                });
            
                const allStatsDisabled = ["cash", "gold", "hour", "id", "locations"].every(stat => defaultHudCheckedData[stat]);
                if (allStatsDisabled) {
                    $("#title-stat").hide();
                }
                break;
            
            case 'hideHud':
                if (onEditMenu) return; 
            
                if (hudHide) return;   
                hudHide = true;
            
                for (const [key, selectors] of Object.entries(hudGroups)) {
                    if (!defaultHudCheckedData[key]) {
                        selectors.forEach(sel => {
                            $(sel).hide();
                        });
                
                        const pureKey = key.replace('.', '');
                        if (!defaultHudCheckedData[pureKey]) {
                            $(key).hide();
                        }
                    }
                }
                
                for (let key in homeSettingsData) {
                    const pureKey = key.replace('.', '');
                    if (!defaultHudCheckedData[pureKey]) {
                        $(key).hide();
                        hudHide = true;
                    }
                }                
                break;
            case 'showHud':
                if (onEditMenu) return;
                if (!hudInitialized) return;

                hudHide = false;
                const autohide = data?.autohide ?? false;

                // ---- 1. hudGroups üzerinden kontrol ----
                for (const [key, selectors] of Object.entries(hudGroups)) {

                    // Global disable edilmişse asla gösterme
                    if (defaultHudCheckedData[key] === true) {
                        selectors.forEach(sel => $(sel).hide());
                        continue;
                    }

                    const userEnabled =
                        (homeSettingsData["." + key] === 1 ||
                        homeSettingsData["." + key] === undefined);

                    selectors.forEach(sel => {

                        const $el = $(sel);
                        if (!$el.length) return;

                        const pureSel = sel.replace('.', '').replace('#', '');
                        const value = currentHudData[sel] || 0;

                        const shouldShow = getShouldShow(sel, autohide, userEnabled, value);

                        if (!staticHuds.includes(pureSel) && autohide && value <= 0) {
                            $el.hide();
                            return;
                        }

                        shouldShow ? $el.show() : $el.hide();
                    });
                }

                // ---- 2. homeSettingsData fallback ----
                for (let key in homeSettingsData) {

                    const pureKey = key.replace('.', '').replace('#', '');

                    // Global disable edilmişse asla gösterme
                    if (defaultHudCheckedData[pureKey] === true) {
                        $(key).hide();
                        continue;
                    }

                    const $el = $(key);
                    if (!$el.length) continue;

                    const userEnabled =
                        (homeSettingsData[key] === 1 ||
                        homeSettingsData[key] === undefined);

                    const value = currentHudData[key] || 0;

                    const shouldShow = getShouldShow(key, autohide, userEnabled, value);

                    if (!staticHuds.includes(pureKey) && autohide && value <= 0) {
                        $el.hide();
                        continue;
                    }

                    shouldShow ? $el.show() : $el.hide();
                }

                break;
            
            case 'softRefreshHud':
                if (onEditMenu || !hudInitialized) return;

                hudHide = false;
                const autohideRefresh = data?.autohide ?? false;
            
                for (let key in homeSettingsData) {
                    const pureKey = key.replace('.', '').replace('#', '');
                    if (!defaultHudCheckedData[pureKey]) {
                        const $el = $(key);
                        if (!$el.length) continue;
            
                        const userEnabled = (homeSettingsData[key] === 1 || homeSettingsData[key] === undefined);
                        const value = currentHudData[key] || 0;
                        const shouldShow = getShouldShow(key, autohideRefresh, userEnabled, value);
            
                        if (!staticHuds.includes(pureKey) && autohideRefresh && value <= 0) {
                            $el.hide();
                            continue;
                        }
            
                        if (shouldShow) $el.show();
                        else $el.hide();
                    }
                }
                break;
                
                
            case 'usedItem':
                usedItemDirect(data.type,data.val)
                break;
        }
    });


    var usedItemArray = {}

    function usedItemChange(div, newVal) {
        if (DisableNumbersAboveCores) return;
    
        if (previousValues[div] === undefined) {
            previousValues[div] = newVal;
            return;
        }
    
        let diff = newVal - previousValues[div];
        previousValues[div] = newVal;
    
        if (diff === 0) return;
    
        showUsedItem(div, diff);
    }
    
    function usedItemDirect(div, changeVal) {
        if (DisableNumbersAboveCores) return;
        if (changeVal === 0) return;
    
        showUsedItem(div, changeVal);
    }
    
    function showUsedItem(div, diff) {
        if (!$(div).is(":visible") || usedItemArray[div] === true) return;
    
        var parentelement = $(div).parent();
        var offset = $(div).offset();
        var width = $(div).outerWidth();
    
        var top = offset.top;
        var left = offset.left + width / 2;
    
        if ($(div).css("position") === "relative") {
            var parentOffset = parentelement.offset();
            top = offset.top - parentOffset.top;
            left = offset.left - parentOffset.left + width / 2;
        }
    
        if ($(div).css("display") != "none") {
            var adjustedTop = (top > window.innerHeight / 2) ? top - 20 : top + 20;
            left = left - 20;
    
            const displayVal = (diff > 0 ? "+" : "") + diff.toFixed(1);
    
            var element = $(`<div class="usevalue" style="position: absolute; left:${left}px; top:${adjustedTop}px;">${displayVal}</div>`);
    
            usedItemArray[div] = true;
            $("body").append(element);
    
            element.animate({ top: adjustedTop - 20 + "px" }, 1000)
                   .delay(1000)
                   .animate({ top: adjustedTop + "px" }, 1000)
                   .delay(1000);
    
            setTimeout(function () {
                usedItemArray[div] = false;
                element.remove();
            }, 1000);
        }
    }
        

    let activeAnimations = {};

    function StartAnimation(divname, tp) {
        let animationType;
        if (tp === "pulseGold") animationType = "pulseGold";
        else if (tp === "-") animationType = "pulse";
        else if (tp === "talking") animationType = "pulseTalking";
        else animationType = "pulse2";
    
        if (activeAnimations[divname] === animationType) return;
        activeAnimations[divname] = animationType;
    
        $(divname).css("animation", "none");
        $(divname).find("img[id$='-core']").css("animation", "none");
        void $(divname)[0].offsetWidth; 
    
        $(divname).css({
            "animation": `${animationType} 0.8s infinite ease-in-out`,
            "z-index": "1",
            "box-shadow": "0 0 0 0 rgba(255,150,13,0.7)" 
        });
    
        $(divname).find("img[id$='-core']").css({
            "animation": "pulseicon 0.8s infinite ease-in-out",
            "z-index": "1"
        });
    }
    
    
    
    function StopAnimation(divname) {
        if (!activeAnimations[divname]) return;
        delete activeAnimations[divname];
    
        $(divname).css({
            "animation": "none",
            "box-shadow": "none",
            "z-index": "2"
        });
    
        $(divname).find("img[id$='-core']").css({
            "animation": "none",
            "z-index": "2"
        });
    }
    
    let onHorse = false;
    function handleHudTick(hudData) {
        if ($(".health-bounding").text() !== hudData['horse-bounding']) {
            $(".health-bounding").text(hudData['horse-bounding']);
            $(".stamina-bounding").text(hudData['horse-bounding']);
        }
    
        DisableNumbersAboveCores = hudData['DisableNumbersAboveCores'];
    
        if (!progressIsBussy) {
            onHorse = hudData['onHorse'];
            for (const key in hudData) {
                if (
                    key === "horse-bounding" ||
                    key === "DisableNumbersAboveCores" ||
                    key === "talking" ||
                    key === "autohide" ||
                    key === ".locations" ||
                    key === "onHorse" ||
                    key === "TempData" ||
                    key === "micMuted" ||
                    key === "pvpState"  
                ) continue;
    
                setProgress(key, hudData[key], hudData['autohide'], hudData, onHorse);
            }
        }
    
        const talking = hudData["talking"];
        if (talking) {
            StartAnimation(".microphone", "talking");
        } else {
            StopAnimation(".microphone");
        }


        const pvpState = hudData["pvpState"];

        if (!onEditMenu && onPlayerLoaded && typeof pvpState !== "undefined") {
        
            const redHex = "#d10000";
        
            const coreSelector = ".pvp .core-img";
            const meterSelector = ".pvp .progress-bar-img";
        
            const $core = $(coreSelector);
            if (!$core.length) return;
        
            const defaultCoreColor = (hudColorData["#pvp-core"] || "#ffffff").toLowerCase();
            const defaultMeterColor = (hudColorData["#pvp-meter"] || "#ffffff").toLowerCase();
        
            const targetCoreColor = pvpState ? redHex : defaultCoreColor;
            const targetMeterColor = pvpState ? redHex : defaultMeterColor;
        
            const currentColor = ($core.attr("data-color") || "").toLowerCase();
        
            if (currentColor !== targetCoreColor) {
                updateElementColor(coreSelector, targetCoreColor);
                updateElementColor(meterSelector, targetMeterColor);
            }
        }

        const locData = hudData['.locations'] || {};
        const loc1 = locData.location1 || "West Elizabeth";
        const loc2 = locData.location2 || "Blackwater";
    
        if ($(".locations-area").text() !== loc1) {
            $(".locations-area").text(loc1);
        }
        if ($(".locations-txt").text() !== loc2) {
            $(".locations-txt").text(loc2);
        }
    }
    
    function scheduleHudTick(huddata) {
        if (!hudInitialized) return;
        lastHudData = huddata;
        if (rafScheduled) return;
        rafScheduled = true;
        requestAnimationFrame(() => {
          rafScheduled = false;
          handleHudTick(lastHudData);
        });
    }

    if (!document.getElementById("color-tint3")) {
        $("body").append(`
            <svg width="0" height="0">
                <filter id="color-tint3">
                    <feColorMatrix type="matrix"
                        values="0 0 0 0 0
                                0 0 0 0 0
                                0 0 0 0 0
                                0 0 0 1 0" />
                </filter>
            </svg>
        `);
    }

    $("[id$='-background']").css({
        filter: "url(#color-tint3)",
        // width: "70%" 
    });

    $('#hud-width').on('input', function () {
        const value = parseFloat($(this).val());
        const roundedValue = parseFloat(value.toFixed(2));
        $('#width-value').val(roundedValue);
    
        const heightToWidthRatio = 3.1 / 1.8;
        const newHeight = (roundedValue * heightToWidthRatio).toFixed(2);
        const newWidthStr = `${roundedValue}%`;
        const newHeightStr = `${newHeight}%`;
    
        const huds = Object.keys(currentHudPositionData);
    
        huds.forEach(function (element) {
            if (element === '.notify-container') return;
    
            const $el = $(element);
            if ($el.length === 0) return;
    
            const hudData = currentHudPositionData[element];
            const isIconHud = hudData.width !== "auto";
    
            if (isIconHud && changeHudWidhtType) {
                let leftPercent = parseFloat($el.css('left')) || 0;
                let topPercent = parseFloat($el.css('top')) || 0;
            
                const maxLeft = 100 - roundedValue;   // sağ tarafa taşmayı engeller
                const maxTop = 100 - newHeight;       // alt tarafa taşmayı engeller
            
                leftPercent = Math.max(0, Math.min(leftPercent, maxLeft));
                topPercent = Math.max(0, Math.min(topPercent, maxTop));
            
                $el.css({
                    width: newWidthStr,
                    height: newHeightStr,
                    left: `${leftPercent}%`,
                    top: `${topPercent}%`,
                    maxWidth: '100%',
                    maxHeight: '100%',
                    overflow: 'hidden'
                });
            
                $el.find(".stat-img").css("width", "25%");
            
                SizeData[element] = {
                    width: newWidthStr,
                    height: newHeightStr
                };
            
                HudPositionDatas[element] = {
                    ...HudPositionDatas[element],
                    width: newWidthStr,
                    height: newHeightStr,
                    left: `${leftPercent}%`,
                    top: `${topPercent}%`
                };
            }
            
    
            else if (!isIconHud && changeStatWidhtType) {
                const fontSizeRaw = Math.max(roundedValue, 1.0); 
                const fontSizeStr = `${fontSizeRaw}vh`;
    
                $el.find(".id-text, .hour-text, .gold-value, .cash-value").css("font-size", fontSizeStr);
    
                HudPositionDatas[element] = {
                    ...HudPositionDatas[element],
                    fontSize: fontSizeStr
                };
            }
        });
    
        if (changeStatWidhtType) {
            const locEl = $(".locations");
    
            if (locEl.length > 0 && !locEl.hasClass("notify-container")) {
                const locFontSize = `${Math.max((roundedValue * 0.8), 1.0).toFixed(2)}vh`;
                const locTxtFontSize = `${Math.max(roundedValue, 1.0).toFixed(2)}vh`;
    
                locEl.css("font-size", locFontSize);
                locEl.find(".locations-area").css("font-size", locFontSize);
                locEl.find(".locations-txt").css("font-size", locTxtFontSize);
    
                if (!HudPositionDatas[".locations"]) HudPositionDatas[".locations"] = {};
                HudPositionDatas[".locations"].fontSize = locFontSize;
                HudPositionDatas[".locations"].areaFontSize = locFontSize;
                HudPositionDatas[".locations"].txtFontSize = locTxtFontSize;
            }
        }
    });
    
    
    

    $('#width-value').on('input', function () {
        const value = $(this).val();
    
        if (/^[0-9]*\.?[0-9]{0,2}$/.test(value)) {
            const numValue = parseFloat(value);
            let min = 0.5, max = 4.0;
    
            if (changeHudWidhtType) {
                min = 1.8;
                max = 4.0;
            } else if (changeStatWidhtType) {
                min = 0.5;
                max = 2.5;
            }
    
            if (numValue >= min && numValue <= max) {
                $('#hud-width').val(numValue);
                $('#hud-width').trigger('input');
            }
        } else {
            $(this).val('');
        }
    });
});
